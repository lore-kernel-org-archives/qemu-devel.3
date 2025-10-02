Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BA01CAC5B0
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Oct 2025 19:01:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4OWk-0006mx-ID; Thu, 02 Oct 2025 14:59:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v4OWh-0006lk-3w
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 14:59:39 -0400
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v4OWP-0004SJ-4d
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 14:59:36 -0400
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-b593def09e3so997435a12.2
 for <qemu-devel@nongnu.org>; Thu, 02 Oct 2025 11:59:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759431553; x=1760036353; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MRoVXTbEiZRq0NCvolopAwrC29j8t8c/HT4EC4PwfXU=;
 b=Ug6un8drqHyPpNTZ+KFRTXx47CCEVPB0HFzuMb70Q5FZ9Ow+1rR3hqGZGh3SPTBal/
 ziSHj+MyBvLIOUQycJb2Wve8KSM72d1DNJVesOG5lLNHSUu7WyKHSBTkiFEt/vMAMfIc
 xMev9qyrUZ/EGW90mFDhlhreQC+nla+UzvI4321qchfqWyyZ/ItComqEzONCBOAYIDwT
 7keqizfpYUtQ1jPJ9ePCxeuiO0vOGBc26GBC7W9f33FtDxXdIOYczXmeP6uBs9zj+ACX
 Yewpw3V5Bh4n+9so4Khk1Fn2czT4gFdj6pQlkFiUNW8Wgv2Fp1kXRxVbJDAZ9J1s4biS
 N0PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759431553; x=1760036353;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MRoVXTbEiZRq0NCvolopAwrC29j8t8c/HT4EC4PwfXU=;
 b=dCPLeD7GGCnyn5vhwZhvenmPD6o6blRCmPpZVwH7CUJSUco4sMVpCC9JAzkPjzevQn
 kdY4EY+/QWL++dSaQ7IMdkDKv4XTuavQX0EWFnAapWCQhz9XP4kT3oBTwpIyEPkm2sV1
 FPpcC45FSJzYRjpbqYlOMF6JCw3K2Pst59Cy9/ABGLmOA7xwTQ90vb8Xzn1cpgx/xnh/
 hISgNIeUkp2FHNyhy17z1c5Xt/ACqAT3CuBTQiW0ReAQx5GPeAW1pSW3Scargk3Ap6yL
 gChAoZIQrFv4rSGAy42xfH0eD/OwRgrmuty+P9miex5Dey/Y95FcWbUgr2HTQK7GARTx
 ay5g==
X-Gm-Message-State: AOJu0Yx1v0DV5Dj+Jog3MQYmxXGAUvYUIcvxQdwh+bJgvZbng6TMsYUS
 muTubRLvG94B14yaBZwnHnOswO0kAq2/QC7rcvEemAkrlHr+1ba75wSLgWDaR75OgrLXx47c7r0
 KtSiIh60=
X-Gm-Gg: ASbGncsIhL194Ue50h1ZGxkeHcW3Hdrz1doWXhzQv346lTddG9JG3O2qBeedceqZRJU
 HVzr7UhUFKAVMB4AuVgRNeWXnePAy4VlCn8A/LO3oMz6GpTFg6OD2DJ+uMpA8ZySdkuPAq3hfhN
 pfB1YMa2Wo7pvPb/2c+CgDSmMhw8McA3r+hEA3nn2Evy/d1AzYXvJ6OrugDpAl93rJYCzJQ++Gc
 yG6iJpOiPbTTJXERcCSaiqCH0z6wQHI2PzFAR6egmD6RLoSZbi76h+gETlWzD3ZhwPkqGSjqKQT
 u0bW3gGLw/NxNJBGe42sygDaAh/50S0c/g8R6YIL1raZTEl8ESTrpgfPvo0/H2JNlGClphhFslC
 huDCjRdgfTNjR5cTEt7/C/pOiKAag46d0XPo85NeCF1FykBnyx2GGvsk9HY2fiVmykWo=
X-Google-Smtp-Source: AGHT+IErqJ3btz+SPzLv+/aaDPLlL6d/QVekQfG7I+jlXmt7sSoEp/MH5YTuHK3FLYgrm41RaIobJQ==
X-Received: by 2002:a17:903:3c70:b0:25c:46cd:1dc1 with SMTP id
 d9443c01a7336-28e9a6aa297mr3215785ad.33.1759431553066; 
 Thu, 02 Oct 2025 11:59:13 -0700 (PDT)
Received: from stoup.. ([71.212.157.132]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-28e8d1d31c8sm28047335ad.95.2025.10.02.11.59.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Oct 2025 11:59:12 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org
Subject: [PATCH 2/2] Enable firmware support for PIE and GCS
Date: Thu,  2 Oct 2025 11:59:09 -0700
Message-ID: <20251002185910.584990-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251002185910.584990-1-richard.henderson@linaro.org>
References: <20251002185910.584990-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::536;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x536.google.com
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

---
 build_arm_trusted_firmware.sh                 |  1 +
 ...arm-trusted-firmware-support-PIE-GCS.patch | 30 +++++++++++++++++++
 2 files changed, 31 insertions(+)
 create mode 100644 patches/arm-trusted-firmware-support-PIE-GCS.patch

diff --git a/build_arm_trusted_firmware.sh b/build_arm_trusted_firmware.sh
index d223142..0b148ef 100755
--- a/build_arm_trusted_firmware.sh
+++ b/build_arm_trusted_firmware.sh
@@ -18,6 +18,7 @@ clone()
         git clone $url --single-branch --branch $version --depth 1 $src
         pushd $src
         git am ../patches/arm-trusted-firmware-support-FEAT_TCR2-and-FEAT-SCTLR2.patch
+        git am ../patches/arm-trusted-firmware-support-PIE-GCS.patch
         popd
     fi
     ln -s $src arm-trusted-firmware
diff --git a/patches/arm-trusted-firmware-support-PIE-GCS.patch b/patches/arm-trusted-firmware-support-PIE-GCS.patch
new file mode 100644
index 0000000..132e939
--- /dev/null
+++ b/patches/arm-trusted-firmware-support-PIE-GCS.patch
@@ -0,0 +1,30 @@
+From 0925eadf8922bbe811ec41fb983347928f3bc63b Mon Sep 17 00:00:00 2001
+From: Richard Henderson <richard.henderson@linaro.org>
+Date: Thu, 2 Oct 2025 11:43:11 -0700
+Subject: [PATCH] plat/qemu/common/: add support for FEAT_{S1PIE,S2PIE,GCS}
+
+---
+ plat/qemu/common/common.mk | 7 +++++++
+ 1 file changed, 7 insertions(+)
+
+diff --git a/plat/qemu/common/common.mk b/plat/qemu/common/common.mk
+index 6bc1084..2c344b6 100644
+--- a/plat/qemu/common/common.mk
++++ b/plat/qemu/common/common.mk
+@@ -126,6 +126,13 @@ ENABLE_FEAT_HCX		:=	2
+ ENABLE_FEAT_TCR2	:=	2
+ ENABLE_FEAT_SCTLR2	:=	2
+ 
++# 8.9
++ENABLE_FEAT_S1PIE	:=	2
++ENABLE_FEAT_S2PIE	:=	2
++
++# 9.4
++ENABLE_FEAT_GCS		=	2
++
+ # SPM_MM is not compatible with ENABLE_SVE_FOR_NS (build breaks)
+ ifeq (${SPM_MM},1)
+ 	ENABLE_SVE_FOR_NS	:= 0
+-- 
+2.43.0
+
-- 
2.43.0


