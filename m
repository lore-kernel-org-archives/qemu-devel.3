Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C962C2BD09
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Jul 2024 20:28:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sQC0Z-00036Q-G1; Sat, 06 Jul 2024 16:27:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ziyao@disroot.org>) id 1sQBmK-0007bX-1m
 for qemu-devel@nongnu.org; Sat, 06 Jul 2024 16:13:04 -0400
Received: from layka.disroot.org ([178.21.23.139])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ziyao@disroot.org>) id 1sQBmI-0005nl-3x
 for qemu-devel@nongnu.org; Sat, 06 Jul 2024 16:13:03 -0400
Received: from localhost (localhost [127.0.0.1])
 by disroot.org (Postfix) with ESMTP id F194141309;
 Sat,  6 Jul 2024 22:12:58 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id xXxihTdM_7Ra; Sat,  6 Jul 2024 22:12:58 +0200 (CEST)
From: Yao Zi <ziyao@disroot.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
 t=1720296778; bh=0HCkpQ2r8rZxK0A07E+xUQPSbd2+j7DpUhibiR7DNp8=;
 h=From:To:Cc:Subject:Date;
 b=LcnYG0HOlCy8i+ERV+Wgap3GB8XdWuZ/mu7Ip1TqXwcGlRBX3z9WSEEZ78orIF8pH
 R91zTXF13vnEjH14bzieJkOHK3YAEaxJMYCxxqx8klLF5KX/ioqTaLbgCHT2alPBEn
 i5mPizT4q2goHrnwgwW8MzOHEcmSAm3J3PZfyoUMm6DU5ops0Zd9Kzz4443pI0UiKn
 o/8zah5ad7OYtQwxQiUHDU61BN0SSGE/wO6qgIX/bVrM4ASz3vr2OZ59yXM9PfJo9c
 UjeRLa63cyWa8yQcDgpPbT3eB8sG23iNMtmYI0AkvXvEylj0aQ96ZlxsMaS3pXUjX3
 eVewEhF3Ox6Ig==
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org,
	Yao Zi <ziyao@disroot.org>
Subject: [PATCH] meson.build: fix libgcrypt detection on system without
 libgcrypt-config
Date: Sat,  6 Jul 2024 20:12:26 +0000
Message-ID: <20240706201226.46089-1-ziyao@disroot.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.21.23.139; envelope-from=ziyao@disroot.org;
 helo=layka.disroot.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Sat, 06 Jul 2024 16:27:42 -0400
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

libgcrypt starts providing correct pkg-config configuration and dropping
libgcrypt-config since 1.11.0. So use auto method for detection of
libgcrypt, in which meson will try both pkg-config and libgcrypt-config.

This fixes build failure when libgcrypt is enabled on a system without
ligcrypt-config. Auto method for libgcrypt is supported by meson since
0.49.0, which is higher than the version qemu requires.

Signed-off-by: Yao Zi <ziyao@disroot.org>
---
 meson.build | 1 -
 1 file changed, 1 deletion(-)

diff --git a/meson.build b/meson.build
index 6a93da48e1..1b71824548 100644
--- a/meson.build
+++ b/meson.build
@@ -1695,7 +1695,6 @@ endif
 if not gnutls_crypto.found()
   if (not get_option('gcrypt').auto() or have_system) and not get_option('nettle').enabled()
     gcrypt = dependency('libgcrypt', version: '>=1.8',
-                        method: 'config-tool',
                         required: get_option('gcrypt'))
     # Debian has removed -lgpg-error from libgcrypt-config
     # as it "spreads unnecessary dependencies" which in
-- 
2.45.2


