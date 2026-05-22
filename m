Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17CFECD4F3D
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2026 21:42:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQXZU-00080H-4Z; Fri, 22 May 2026 17:38:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wQXZP-0007cw-TC; Fri, 22 May 2026 17:38:15 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wQXZO-0002Tm-2l; Fri, 22 May 2026 17:38:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1779485682; bh=UhI+KDjAYlhcfCiXgj3KBHxzGA1hM+W7e3Oe7frWppQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=XH5VQLGPbQ++u9eevin3kuQce3fHcIKPTRpYvTELicb3VzpEVir5z2nFV1SzyYun4
 Fiz3aqJIUkVZy2oxhSrb1o+S7y+fSGJ4zP4IucjnuU0mbl1B9NP+Oflx4zc5dNXJHd
 FZtHIUrLr4y/frgmuLY+m50QBtz8MM0TE5tksIznKanMSr6LzPc2jyrEmETAbuwMZn
 VNloEiDkgyo1cyUptYxJQlGZBE3dKekVEefHzTqtMfiPwsS/vCJ365a0lmuC/8k90B
 CXer8oJGyRjeiVSoPYP6S1LO5fRITngNCHb4WXcdkhdrgxJcNuYr3AW50bSlRyygxE
 o4aOQ+QGu9aBw==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id AA2D31AFAFD;
 Sat, 23 May 2026 00:34:42 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id CD80F3B717D;
 Sat, 23 May 2026 00:34:46 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>,
 Feifan Qian <bea1e@proton.me>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.10 108/136] hw/uefi: check auth.hdr_length minimum size
Date: Sat, 23 May 2026 00:34:16 +0300
Message-ID: <20260522213446.806182-9-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.10-20260522213601@cover.tls.msk.ru>
References: <qemu-stable-10.0.10-20260522213601@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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

From: Gerd Hoffmann <kraxel@redhat.com>

auth.hdr_length maximum is already checked (against buffer size).  The
header has some fixed fields which are included in the header length, so
there also is a minimum size which must be verified.  Add a check for
that.  Fixes possible integer underflow.

While being at it replace the magic number '24' with sizeof calculations
for better code documentation.

Fixes: CVE-2026-8341
Fixes: f1488fac0584 ("hw/uefi: add var-service-auth.c")
Reported-by: Feifan Qian <bea1e@proton.me>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20260512060523.17493-1-kraxel@redhat.com>
(cherry picked from commit b33fd8ab1caa07aeb290ef5dac44a4e7fd4be02b)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/uefi/var-service-auth.c b/hw/uefi/var-service-auth.c
index 795f2f54e4..f3dc9c6ca6 100644
--- a/hw/uefi/var-service-auth.c
+++ b/hw/uefi/var-service-auth.c
@@ -194,7 +194,7 @@ static efi_status uefi_vars_check_auth_2_sb(uefi_vars_state *uv,
         return EFI_SUCCESS;
     }
 
-    if (auth.hdr_length == 24) {
+    if (auth.hdr_length == (sizeof(auth) - sizeof(auth.timestamp))) {
         /* no signature (auth->cert_data is empty) */
         return EFI_SECURITY_VIOLATION;
     }
@@ -228,6 +228,9 @@ efi_status uefi_vars_check_auth_2(uefi_vars_state *uv, uefi_variable *var,
     }
     memcpy(&auth, data, sizeof(auth));
 
+    if (auth.hdr_length < (sizeof(auth) - sizeof(auth.timestamp))) {
+        return EFI_SECURITY_VIOLATION;
+    }
     if (uadd64_overflow(sizeof(efi_time), auth.hdr_length, &data_offset)) {
         return EFI_SECURITY_VIOLATION;
     }
diff --git a/hw/uefi/var-service-pkcs7.c b/hw/uefi/var-service-pkcs7.c
index c859743e86..8a1f1395a2 100644
--- a/hw/uefi/var-service-pkcs7.c
+++ b/hw/uefi/var-service-pkcs7.c
@@ -113,9 +113,9 @@ static gnutls_datum_t *build_pkcs7(void *data)
 
     memcpy(&auth, data, sizeof(auth));
     pkcs7 = g_new(gnutls_datum_t, 1);
-    pkcs7->size = auth.hdr_length - 24;
+    pkcs7->size = auth.hdr_length - (sizeof(auth) - sizeof(auth.timestamp));
     pkcs7->data = g_malloc(pkcs7->size);
-    memcpy(pkcs7->data, data + 16 + 24, pkcs7->size);
+    memcpy(pkcs7->data, data + sizeof(auth), pkcs7->size);
 
     wrap_pkcs7(pkcs7);
 
-- 
2.47.3


