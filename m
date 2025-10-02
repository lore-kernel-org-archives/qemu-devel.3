Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9775CAC5B0
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Oct 2025 19:01:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4OWe-0006kL-FU; Thu, 02 Oct 2025 14:59:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v4OWY-0006ji-7E
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 14:59:30 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v4OWM-0004Rz-A3
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 14:59:27 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-2680cf68265so10084185ad.2
 for <qemu-devel@nongnu.org>; Thu, 02 Oct 2025 11:59:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759431552; x=1760036352; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=REdHJe6z7bttc9T3I2uMMFkF69gmCqgox1fCOqDpUs8=;
 b=O9zLiSefd+OKe00hquZjopJdSr9MnOVuqJN2pf5C1jJk/RWldtSSfzdj+jakqGkEhS
 RZkpu5vhzaHZE0xs2PdtpOSx653qYZQ3G42lm0QtB5lKN/5wJ6Deigo+Laif4FWVJTaT
 TU+5eUs8EPFdsIGlxhvnBy1ksWGHS0Q0UBWJcJlxuonqiIEFzkXktpFNSVGrRYTlokai
 bfDX55vjKVXnfbhTGpr27jCtkTelvktgF9iaG6fB2JOzwKaB3YtNqJ6dJCnhiDfe8e+u
 fxB9nnhVxsk+CGP0clOzSML5/oQBhyjLOhoZHvLKxUAHfbpvjFnDuRl5SXHU2dmGKgAr
 Zrvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759431552; x=1760036352;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=REdHJe6z7bttc9T3I2uMMFkF69gmCqgox1fCOqDpUs8=;
 b=DPQWxID30dj+stRs46TT+Sfwmy8OlGAKLufd1rzoKQe5hBBRMyxqrNfd3PHlUBETsr
 A7gTXHoz1918JMtQi0vYgMOdJtNrcMaE/VmT0erNb+6Z3pT5JQqTrdlx9yZ4ejDCkiqu
 8/OdhUmoWzM6yVBLoG3vzeh110vTFMlI69EdgAN44pYCAY1kwMI8OF0Cnyafbu10RKSX
 mdRcHO3AtqbSqN9NloOcNv32TIv/ttIRHgDo+Wgv5pFHjlT2LxtAxsltNHVLsQBg17Kx
 ns91Dp4KgRsPfJ41E/Rw7XmQcEj4y278wv4xMSBUhbaFqauD1xPrJzIrDS7FCdC7oGzL
 +7CQ==
X-Gm-Message-State: AOJu0YyTG8jtVWnNXQimk1wB/Sn6NybWzznLctgw7J/P1Heab/aA4kJl
 MQBmpMG1Fjqw4poAjgQBoYmngMOR4iM+9scG0k2+frddroM8j2KO4EiBY9AoHV4RCtZEbHfjHMe
 UzoWOvt8=
X-Gm-Gg: ASbGncu96WmY8srWt3ujFZpg3mzFUfxxUrb3lUuJG4NZY0WGie1RrDyteAgyVnAHKHA
 i9ipdY65dTqCv/FoZmwv4mYfB7oTdTUmW2JBnfStkRbgg9NBTfou+bTMDBigd1s+k/r/q5IKKUt
 Cd8tgTaAZukE9CRnk8LxKej6MA5c+dTfu2xsp8FfbFaTsf5KjK4QtTwDYBz+s3G90I9IAS2FxHm
 Lv5DRWSERzgaA5xRpA/3GvZOts2u4wSPd8UYqQcqMmoQOTTFUFv3/0yCl6Hc7GHBikk4HsFhYMK
 Nntq9lX/7ULWLNnYXmeH3kRKhxuu1dh0J2idqx5C3IS1cfqjdkKXfQH2XhsUB6X2LHow9sK9m8b
 lItjlr62XzZu4eWL6ttSF37nIKI8xtzpzhNCPirXOd/knJWo87t+HhoQefUS3DiMWE7s=
X-Google-Smtp-Source: AGHT+IFjej55OLe5Rha73BAm90miVczH3+6mLaFevQ4I9qrpKnaCbP6Z9TJfwev+ZYCO1WZbXDpqrw==
X-Received: by 2002:a17:902:f64d:b0:27f:1c1a:ee43 with SMTP id
 d9443c01a7336-28e9a61ab47mr3320885ad.29.1759431552266; 
 Thu, 02 Oct 2025 11:59:12 -0700 (PDT)
Received: from stoup.. ([71.212.157.132]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-28e8d1d31c8sm28047335ad.95.2025.10.02.11.59.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Oct 2025 11:59:11 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org
Subject: [PATCH 1/2] Update tf-rmm to support FEAT_S1PIE
Date: Thu,  2 Oct 2025 11:59:08 -0700
Message-ID: <20251002185910.584990-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251002185910.584990-1-richard.henderson@linaro.org>
References: <20251002185910.584990-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

There appears to be no tagged release with FEAT_S1PIE, but
it is upstream.  As is the PMU patch we were carrying.
---
 build_tf_rmm.sh                              | 10 ++---
 patches/rmm-support-lower-pmu-versions.patch | 44 --------------------
 2 files changed, 5 insertions(+), 49 deletions(-)
 delete mode 100644 patches/rmm-support-lower-pmu-versions.patch

diff --git a/build_tf_rmm.sh b/build_tf_rmm.sh
index bd1c612..009966d 100755
--- a/build_tf_rmm.sh
+++ b/build_tf_rmm.sh
@@ -11,14 +11,14 @@ fi
 clone()
 {
     rm -f tf-rmm
-    url=https://github.com/TF-RMM/tf-rmm
-    version=tf-rmm-v0.7.0
-    src=$version-support-lower-pmu-versions-release
+    url=https://git.trustedfirmware.org/TF-RMM/tf-rmm
+    version=481cb7f4e64f5c48c03a72b75b736f183f3011d5
+    src=tf-rmm-main-s1pie
     if [ ! -d $src ]; then
-        git clone $url --single-branch --branch $version --depth 1 $src
+        git clone $url $src
         pushd $src
+        git checkout $version
         git submodule update --init --depth 1
-        git am ../patches/rmm-support-lower-pmu-versions.patch
         popd
     fi
     ln -s $src tf-rmm
diff --git a/patches/rmm-support-lower-pmu-versions.patch b/patches/rmm-support-lower-pmu-versions.patch
deleted file mode 100644
index 0993edc..0000000
--- a/patches/rmm-support-lower-pmu-versions.patch
+++ /dev/null
@@ -1,44 +0,0 @@
-From 2235e01874d2b51e32650b2326c94ae2285c554a Mon Sep 17 00:00:00 2001
-From: Jean-Philippe Brucker <jean-philippe@linaro.org>
-Date: Fri, 14 Jul 2023 10:54:43 +0100
-Subject: [PATCH] TMP: fix(qemu): Support lower PMU versions
-
-Although RME mandates v3p7, QEMU has v3p5 at the moment. Until we
-implement the p7 extension, which provides counter isolation for EL3,
-allow p5.
-
-Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
-Change-Id: Id1dd30486f203187e3f882c7495116b743d3883a
----
- lib/arch/include/arch.h | 1 +
- runtime/rmi/feature.c   | 2 +-
- 2 files changed, 2 insertions(+), 1 deletion(-)
-
-diff --git a/lib/arch/include/arch.h b/lib/arch/include/arch.h
-index cecdf2a5..fc64365e 100644
---- a/lib/arch/include/arch.h
-+++ b/lib/arch/include/arch.h
-@@ -493,6 +493,7 @@
- #define ID_AA64DFR0_EL1_PMUVer_WIDTH		UL(4)
- 
- /* Performance Monitors Extension version */
-+#define ID_AA64DFR0_EL1_PMUv3p5			UL(5)
- #define ID_AA64DFR0_EL1_PMUv3p7			UL(7)
- #define ID_AA64DFR0_EL1_PMUv3p8			UL(8)
- #define ID_AA64DFR0_EL1_PMUv3p9			UL(9)
-diff --git a/runtime/rmi/feature.c b/runtime/rmi/feature.c
-index 5468f137..52487c0d 100644
---- a/runtime/rmi/feature.c
-+++ b/runtime/rmi/feature.c
-@@ -35,7 +35,7 @@ unsigned long get_feature_register_0(void)
- 						RMI_FEATURE_TRUE);
- 
- 	/* RMM supports PMUv3p7+ */
--	assert(read_pmu_version() >= ID_AA64DFR0_EL1_PMUv3p7);
-+	assert(read_pmu_version() >= ID_AA64DFR0_EL1_PMUv3p5);
- 
- 	/* Set support for PMUv3 */
- 	feat_reg0 |= INPLACE(RMI_FEATURE_REGISTER_0_PMU_EN,
--- 
-GitLab
-
-- 
2.43.0


