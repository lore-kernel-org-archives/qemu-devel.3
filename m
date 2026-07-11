Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B064C44506
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Jul 2026 22:07:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wifpX-0006V1-Bw; Sat, 11 Jul 2026 18:05:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wifpT-0006B1-4R; Sat, 11 Jul 2026 18:05:47 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wifpR-0000hJ-9q; Sat, 11 Jul 2026 18:05:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1783807181; bh=1sGmdcj+0zYCA1aoM3xC6DkpJdawlyEHwafMS29CB4o=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=P5qJmT8KkMOdWOa1gczwKm/tTPZpFwsBslCSnGVbU3xO1H5L9RpbuWDtVmKTG/0HE
 VtdFwjRvLm5ey/3OwoZxM5WEQ1oUyUekiyMLCA7GZvGd7pFioucLDAh/o31ni8QatF
 xMO+BGwWAuhcnk3IeNYidob7z0t5Ew0XeTE42cTqomgI6MdKxH6SjzzYxStbydpHF6
 iWZ2f1OvQjoF1Qj0sTVfO0XGHzuY42zZf8JJOj5ygxlRBuxTNmK5Fq6U0lQaQx0ylA
 WOFvOyMg+NETdFe95wTgKgNEy8rc4WfzQ0yKQ99rNZimM7u6UWgC1XHCmYY7MeIK2L
 OrWWCZNMDOJSw==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 967CE1C0ACC;
 Sun, 12 Jul 2026 00:59:41 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 4D8C33EAF57;
 Sun, 12 Jul 2026 00:59:51 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id D437D13365; Sun, 12 Jul 2026 00:59:50 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, yujun <yujun@kylinos.cn>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.0.3 65/81] crypto/x509-utils: fix gnutls error code in
 crt_init failure path
Date: Sun, 12 Jul 2026 00:58:43 +0300
Message-ID: <20260711215904.3757-65-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.0.3-20260712005649@cover.tls.msk.ru>
References: <qemu-stable-11.0.3-20260712005649@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_MSPIKE_H2=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: yujun <yujun@kylinos.cn>

qcrypto_get_x509_cert_fingerprint() reports gnutls_strerror(ret) when
gnutls_x509_crt_init() fails, but ret is still the initial value -1.
Store the gnutls return code before formatting the error, matching
other gnutls call sites in the tree.

Fixes: 2183ab6251 ("crypto/x509-utils: Check for error from gnutls_x509_crt_init()")
Signed-off-by: yujun <yujun@kylinos.cn>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
(cherry picked from commit 4952681a5fdc29dc74396756ab85f90ee15ea9bc)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/crypto/x509-utils.c b/crypto/x509-utils.c
index 39bb6d4d8c3..1843488bca3 100644
--- a/crypto/x509-utils.c
+++ b/crypto/x509-utils.c
@@ -46,7 +46,8 @@ int qcrypto_get_x509_cert_fingerprint(uint8_t *cert, size_t size,
         return -1;
     }
 
-    if (gnutls_x509_crt_init(&crt) < 0) {
+    ret = gnutls_x509_crt_init(&crt);
+    if (ret < 0) {
         error_setg(errp, "Unable to initialize certificate: %s",
                    gnutls_strerror(ret));
         return -1;
-- 
2.47.3


