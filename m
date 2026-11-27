Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC158606A336
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Nov 2026 05:25:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWoS4-0007t8-VK; Fri, 27 Nov 2026 00:24:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <martin@amutable.com>)
 id 1xWoS2-0007sd-Aq
 for qemu-devel@nongnu.org; Fri, 27 Nov 2026 00:24:50 -0500
Received: from www.mwellner.de ([2a03:4000:6:4019::4] helo=mail.piware.de)
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <martin@amutable.com>) id 1xWoS0-0005WY-Il
 for qemu-devel@nongnu.org; Fri, 27 Nov 2026 00:24:50 -0500
Received: from piware.de (localhost [127.0.0.1])
 by mail.piware.de (Postfix) with SMTP id DEDADFFA80;
 Fri, 27 Nov 2026 06:24:45 +0100 (CET)
Date: Fri, 27 Nov 2026 06:24:45 +0100
From: Martin Pitt <martin@amutable.com>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH for-11.2] hw/uefi: accept a PK enrolled in setup mode
Message-ID: <awkUHTIhRM_DHrTR@piware.de>
X-Archived-By: <archiver.kernel.org>
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
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Martin Pitt <martin@amutable.com>

uefi_vars_check_auth_2_sb() returns an efi_status. Commit cc3cf42e618a
changed it to return "true" for the "no self-signed PK is required" code
path. That value 1 is interpreted as EFI_WARN_UNKNOWN_GLYPH, so
uefi_vars_mm_set_variable() rejects the write, and the guest can never
enroll its own PK. Return the correct code to fix this.

Since commit a1b96fcde870 ("hw/uefi: improve default config security")
a self-signed PK is not required by default. This bug can be worked
around by forcing the still working old code path:

  -global uefi-vars-sysbus.require-self-signed-pk=on

Fixes: cc3cf42e618a ("hw/uefi: add require-self-signed-pk config option")
Signed-off-by: Martin Pitt <martin@amutable.com>
---
 hw/uefi/var-service-auth.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/uefi/var-service-auth.c b/hw/uefi/var-service-auth.c
index 21fc50f904..744c2cc193 100644
--- a/hw/uefi/var-service-auth.c
+++ b/hw/uefi/var-service-auth.c
@@ -214,7 +214,7 @@ static efi_status uefi_vars_check_auth_2_sb(uefi_vars_state *uv,
             };
             return uefi_vars_check_pkcs7_2(&tmp, NULL, NULL, va, data);
         } else {
-            return true;
+            return EFI_SUCCESS;
         }
     }
 
-- 
2.56.0


