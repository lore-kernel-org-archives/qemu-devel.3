Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CEF6CCA490
	for <qemu-devel@archiver.kernel.org>; Sun, 18 Oct 2026 20:04:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIX6f-0000qB-Qw; Sun, 18 Oct 2026 16:03:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <martin@amutable.com>)
 id 1xIX4V-0000hG-MM; Sun, 18 Oct 2026 16:01:31 -0400
Received: from www.mwellner.de ([2a03:4000:6:4019::4] helo=mail.piware.de)
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <martin@amutable.com>)
 id 1xIX4T-0000xm-OI; Sun, 18 Oct 2026 16:01:31 -0400
Received: from piware.de (localhost [127.0.0.1])
 by mail.piware.de (Postfix) with SMTP id D6294FF866;
 Sun, 18 Oct 2026 22:01:25 +0200 (CEST)
Date: Sun, 18 Oct 2026 22:01:25 +0200
From: Martin Pitt <martin@amutable.com>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, qemu-stable@nongnu.org
Subject: [PATCH] hw/uefi: fix ContentInfo detection in wrap_pkcs7()
Message-ID: <atUllV8bSaHylfKv@piware.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: softfail client-ip=2a03:4000:6:4019::4;
 envelope-from=martin@amutable.com; helo=mail.piware.de
X-Spam_score_int: -7
X-Spam_score: -0.8
X-Spam_bar: /
X-Spam_report: (-0.8 / 5.0 requ) BAYES_00=-1.9, KHOP_HELO_FCRDNS=0.4,
 SPF_HELO_NONE=0.001, SPF_SOFTFAIL=0.665 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Sun, 18 Oct 2026 16:03:38 -0400
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Fix wrap_pkcs7()'s detection for an already present PKCS ContentInfo
envelope: It previously compared byte 15 with 0x0a (ASN.1
ENUMERATED) instead of 0xa0 (the [0] EXPLICIT context tag of
ContentInfo.content). See the original edk2 function [1] where this was
taken from.

Due to that typo, an already wrapped signature got wrapped a second
time, and gnutls_pkcs7_import() rejected it. This breaks Secure Boot key
enrollment with .auth files carrying the envelope, as created by
systemd's "bootctl --secure-boot-auto-enroll".

[1] https://github.com/tianocore/edk2/blob/8f8372439d8ec5f565dbda1548c18deb068e0080/CryptoPkg/Library/BaseCryptLib/Pk/CryptPkcs7VerifyCommon.c#L68

Fixes: 3e33af2cb306 ("hw/uefi: add var-service-pkcs7.c")
Cc: qemu-stable@nongnu.org
Signed-off-by: Martin Pitt <martin@amutable.com>
---
 hw/uefi/var-service-pkcs7.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/uefi/var-service-pkcs7.c b/hw/uefi/var-service-pkcs7.c
index 8a1f1395a2..a47f36492f 100644
--- a/hw/uefi/var-service-pkcs7.c
+++ b/hw/uefi/var-service-pkcs7.c
@@ -80,7 +80,7 @@ static void wrap_pkcs7(gnutls_datum_t *pkcs7)
         pkcs7->data[4] == 0x06 &&
         pkcs7->data[5] == 0x09 &&
         memcmp(pkcs7->data + 6, signed_data_oid, sizeof(signed_data_oid)) == 0 &&
-        pkcs7->data[15] == 0x0a &&
+        pkcs7->data[15] == 0xa0 &&
         pkcs7->data[16] == 0x82) {
         return;
     }

base-commit: a19f59a72d96056d9a8f48cf6c77f5787491e414
-- 
2.56.0


