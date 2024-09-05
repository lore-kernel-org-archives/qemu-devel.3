Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEA2CCD5BA9
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Sep 2024 11:13:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smAPG-0004s0-6W; Thu, 05 Sep 2024 07:12:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1smAPD-0004qm-MO
 for qemu-devel@nongnu.org; Thu, 05 Sep 2024 07:12:03 -0400
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1smAPB-0000WI-SG
 for qemu-devel@nongnu.org; Thu, 05 Sep 2024 07:12:03 -0400
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-a868d7f92feso98058566b.2
 for <qemu-devel@nongnu.org>; Thu, 05 Sep 2024 04:12:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725534719; x=1726139519; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=b417LV8FGVx5zaVIcJGwBkFTzJWOlPL6Soqk2rPRDSI=;
 b=ejFcEKA/BvMA8Dscb9so8cBHqCBZghZX69k3jSSAM+a+GKeavtY1/x5fog+VS5vFd/
 sRmjLFBsGJdqX0Mhg33i2eg5jWFawSKB1eBWfGPyey1094M0CL3jy65BrfnCzAzKgLSD
 I5SQzalR5bS4G/sDbkWyQEHR2ISQBXV2IBpeJvuxqWt3UNFsP3nyK20wrj/cSKOoyKnM
 Xk9/IZABnIQtAkFcYvVF19gCpc5Y3kNoayLM63RsCCSXolUScmBZcBhkLlHtS/FqS9Ap
 snI0yHC3P7qWShGfU5LT1qwFHRVw+6gQ6cm4jbwoCLJV0Obw8cQeXnMY2f7KDtfS9qJ4
 03cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725534719; x=1726139519;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=b417LV8FGVx5zaVIcJGwBkFTzJWOlPL6Soqk2rPRDSI=;
 b=wF5U3Dt0MrA0NDHKgjzX1Ir0q9edSHi7Rb0JuR8ZNOnqKSb+ZVUzp7b3Amw2I5j2is
 eIaOEKf4E1ga4pEE5n5ObyqtEoSHY/YWPeYNWtGw5UrphM4FUQQVKgJQrj22XYJ7P6CU
 2yZaGx1z++145GX+V+Qhvn1dWsxcf4F5ruzL2oByVnFqkFzYnPaN/kabP4Ie6QCF1Gwl
 UHc+csIfSSDTIB+BF1MFmZEHQmnZPB7kjnVMi3wNnEShFQCcf2mPxFivJGahtPQYOAdA
 Td/AL8HL38hrlhFVxle09ceoNfeOkB6XHasLosMykJapyW9c/ohfy7QoraQuJW4TK52J
 Uufw==
X-Gm-Message-State: AOJu0YzFuoqKmbq1aXmnwaeCeGrQavSW68Wav59k4PbApoTa9AOiqtks
 v9E9fKjg3MajQ8LA2z4XEru/y24B5vQxIQrQG2nb9zBwZe3ncSZ1fFPJnuqJGQc=
X-Google-Smtp-Source: AGHT+IEeQIs1vsHHsmoMsrHPSI1h8y2kIou4QPh9fWLXUEcd0S3XirML9B3WSyLLFMpAd9/I3RRUZg==
X-Received: by 2002:a17:907:9725:b0:a88:b90a:ff30 with SMTP id
 a640c23a62f3a-a897fa74dbcmr1825424666b.50.1725534718385; 
 Thu, 05 Sep 2024 04:11:58 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a8a6236d164sm120320466b.111.2024.09.05.04.11.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Sep 2024 04:11:57 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 1CB4B5F8BA;
 Thu,  5 Sep 2024 12:11:57 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 devel@lists.libvirt.org (reviewer:Incompatible changes)
Subject: [RFC PATCH] deprecation: don't enable TCG plugins by default on 32
 bit hosts
Date: Thu,  5 Sep 2024 12:11:53 +0100
Message-Id: <20240905111153.786500-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::629;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x629.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
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

The existing plugins already liberally use host pointer stuffing for
passing user data which will fail when doing 64 bit guests on 32 bit
hosts. We should discourage this by officially deprecating support and
adding another nail to the 32 bit host coffin.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 docs/about/deprecated.rst | 11 +++++++++++
 configure                 | 11 ++++++++++-
 2 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
index 88f0f03786..8a4e249717 100644
--- a/docs/about/deprecated.rst
+++ b/docs/about/deprecated.rst
@@ -184,6 +184,17 @@ be an effective use of its limited resources, and thus intends to discontinue
 it. Since all recent x86 hardware from the past >10 years is capable of the
 64-bit x86 extensions, a corresponding 64-bit OS should be used instead.
 
+TCG Plugin support not enabled by default on 32-bit hosts (since 9.2)
+'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
+
+While it is still possible to enable TCG plugin support for 32-bit
+hosts there are a number of potential pitfalls when instrumenting
+64-bit guests. The plugin APIs typically pass most addresses as
+uint64_t but practices like encoding that address in a host pointer
+for passing as user-data will loose data. As most software analysis
+benefits from having plenty of host memory it seems reasonable to
+encourage users to use 64 bit builds of QEMU for analysis work
+whatever targets they are instrumenting.
 
 System emulator CPUs
 --------------------
diff --git a/configure b/configure
index d08b71f14b..8acb311527 100755
--- a/configure
+++ b/configure
@@ -424,6 +424,7 @@ fi
 # Note that this case should only have supported host CPUs, not guests.
 # Please keep it sorted and synchronized with meson.build's host_arch.
 host_arch=
+host_bits=64
 linux_arch=
 case "$cpu" in
   aarch64)
@@ -434,12 +435,14 @@ case "$cpu" in
   armv*b|armv*l|arm)
     cpu=arm
     host_arch=arm
+    host_bits=32
     linux_arch=arm
     ;;
 
   i386|i486|i586|i686)
     cpu="i386"
     host_arch=i386
+    host_bits=32
     linux_arch=x86
     CPU_CFLAGS="-m32"
     ;;
@@ -458,11 +461,13 @@ case "$cpu" in
   mips*)
     cpu=mips
     host_arch=mips
+    host_bits=32
     linux_arch=mips
     ;;
 
   ppc)
     host_arch=ppc
+    host_bits=32
     linux_arch=powerpc
     CPU_CFLAGS="-m32"
     ;;
@@ -480,11 +485,13 @@ case "$cpu" in
 
   riscv32 | riscv64)
     host_arch=riscv
+    host_bits=32
     linux_arch=riscv
     ;;
 
   s390)
     linux_arch=s390
+    host_bits=32
     CPU_CFLAGS="-m31"
     ;;
   s390x)
@@ -495,6 +502,7 @@ case "$cpu" in
 
   sparc|sun4[cdmuv])
     cpu=sparc
+    host_bits=32
     CPU_CFLAGS="-m32 -mv8plus -mcpu=ultrasparc"
     ;;
   sparc64)
@@ -505,6 +513,7 @@ case "$cpu" in
   x32)
     cpu="x86_64"
     host_arch=x86_64
+    host_bits=32
     linux_arch=x86
     CPU_CFLAGS="-mx32"
     ;;
@@ -1028,7 +1037,7 @@ if test "$static" = "yes" ; then
   fi
   plugins="no"
 fi
-if test "$plugins" != "no"; then
+if test "$plugins" != "no" && test host_bits = 64; then
   plugins=yes
   subdirs="$subdirs contrib/plugins"
 fi
-- 
2.39.2


