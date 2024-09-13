Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3294BFC6169
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2024 17:30:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1spA4Z-0005j1-Bz; Fri, 13 Sep 2024 13:27:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1spA4X-0005dR-MV
 for qemu-devel@nongnu.org; Fri, 13 Sep 2024 13:27:05 -0400
Received: from mail-lf1-x12c.google.com ([2a00:1450:4864:20::12c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1spA4U-0005st-3M
 for qemu-devel@nongnu.org; Fri, 13 Sep 2024 13:27:05 -0400
Received: by mail-lf1-x12c.google.com with SMTP id
 2adb3069b0e04-5365cc68efaso2613792e87.1
 for <qemu-devel@nongnu.org>; Fri, 13 Sep 2024 10:27:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726248420; x=1726853220; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9JqMmYhvvimxL2nuuWz1bK1OoVqJiadEwbZ7PDjZqjg=;
 b=RGU7rSJWpIK8km/Tawn3j4JLb1ZMQ9hdwdrMEV04GJIfd5SSH29CFPAuiFRlScByh5
 n962ffqEKO7/FUvqfPXl3UixWlMec4z7ltdTkYxPpprKFlKz3+YJfVvT2gjcJT8ORiPS
 iKJHwp1okozB7Rol2YEudz5ZdI+kl+gpM2eTQxKF2ehFmJrh8nljkPr3HicMf7tarBvt
 6ZbCbjDsRPWF+MSaWD8pg3Y/5qbSN7tdfa0MfaLxzVad7/4uU93o/JDhDDIv7aFl8zM7
 5TaOtK8R9fvI+a/F6KqzZjlHLEn+owOkow3LikacuxFhwNYZ/8+iglp2qb+YpFGY1LZ7
 j96g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726248420; x=1726853220;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9JqMmYhvvimxL2nuuWz1bK1OoVqJiadEwbZ7PDjZqjg=;
 b=i14WlmmEvSx601G1FKQUtwPHO15N9/Gs57xpPSdDUjuObBRcuZzIr/XhDmIE26xxdC
 VsLN6RyIC3VdMQ3eS2rb7Amk5iF23JMlfHJ2S6+TNGzib91vW9tsbmVcxfBSA5dWKBS6
 FY6NkyBlQ02w3y13dHSQK3uRsdjWu/SisOxYk43egUwCpPdzLrFXpATPxAtlb98OBlnI
 ENogWeZBnCIsdQfScgL5YvmS2p/ZWrK7LIaIhaSdLurZxG9bTkvvyaiPo30B/UfuucMi
 ftiVH2Dz+g1Bv/MeSiSV0GSmmDlIVI15qn+b68ZaDxMg7TLvaiy3OM31peKNynwRmGfM
 SdQQ==
X-Gm-Message-State: AOJu0Yw3gYPq6cxb6sMLQoPOYfgDTeMcI/sMpwBwIypiD98TcuDd1ThL
 VfyEhOxII5LixOQYNcBtOan7fBFGAa8o9Vx4hzqD8BgGaJZ7R/UZb54EggGEt5I=
X-Google-Smtp-Source: AGHT+IH3bdwzTkX6RkmqwIfCijpBrDjsCtcg6FVo/vS7CoFIj8tfb4Cb0f4MAOqNFH3FazC4AeWmRA==
X-Received: by 2002:a05:6512:2344:b0:52c:850b:cfc6 with SMTP id
 2adb3069b0e04-53678feb625mr4600483e87.38.1726248418837; 
 Fri, 13 Sep 2024 10:26:58 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a8d25cee784sm908091066b.177.2024.09.13.10.26.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Sep 2024 10:26:57 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 49ED85F95B;
 Fri, 13 Sep 2024 18:26:56 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, devel@lists.libvirt.org,
 Thomas Huth <thuth@redhat.com>, Mahmoud Mandour <ma.mandourr@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand <david@redhat.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, qemu-ppc@nongnu.org,
 Zhao Liu <zhao1.liu@intel.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Eduardo Habkost <eduardo@habkost.net>,
 qemu-s390x@nongnu.org, Alexandre Iooss <erdnaxe@crans.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PATCH 02/17] deprecation: don't enable TCG plugins by default with
 TCI
Date: Fri, 13 Sep 2024 18:26:40 +0100
Message-Id: <20240913172655.173873-3-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240913172655.173873-1-alex.bennee@linaro.org>
References: <20240913172655.173873-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12c;
 envelope-from=alex.bennee@linaro.org; helo=mail-lf1-x12c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

The softmmu memory instrumentation test sees so many more accesses
than a normal translated host and its really not worth fixing up. Lets
deprecate this odd configuration and save on the CI cycles.

Message-Id: <20240910140733.4007719-13-alex.bennee@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 docs/about/deprecated.rst |  8 ++++++++
 configure                 | 11 +++++++++--
 2 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
index f7c7c33d39..5aa2e35314 100644
--- a/docs/about/deprecated.rst
+++ b/docs/about/deprecated.rst
@@ -196,6 +196,14 @@ benefits from having plenty of host memory it seems reasonable to
 encourage users to use 64 bit builds of QEMU for analysis work
 whatever targets they are instrumenting.
 
+TCG Plugin support not enabled by default with TCI (since 9.2)
+''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
+
+While the TCG interpreter can interpret the TCG ops used by plugins it
+is going to be so much slower it wouldn't make sense for any serious
+instrumentation. Due to implementation differences there will also be
+anomalies in things like memory instrumentation.
+
 System emulator CPUs
 --------------------
 
diff --git a/configure b/configure
index f376fa24b3..3778b61c40 100755
--- a/configure
+++ b/configure
@@ -629,6 +629,9 @@ meson_option_parse() {
     exit 1
   fi
 }
+has_meson_option() {
+    test "${meson_options#*"$1"}" != "$meson_options"
+}
 
 meson_add_machine_file() {
   if test "$cross_compile" = "yes"; then
@@ -1048,8 +1051,12 @@ if test "$static" = "yes" ; then
   plugins="no"
 fi
 if test "$plugins" != "no" && test $host_bits -eq 64; then
-  plugins=yes
-  subdirs="$subdirs contrib/plugins"
+    if has_meson_option "-Dtcg_interpreter=true"; then
+        plugins="no"
+    else
+        plugins=yes
+        subdirs="$subdirs contrib/plugins"
+    fi
 fi
 
 cat > $TMPC << EOF
-- 
2.39.2


