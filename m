Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B40A6C54E55
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Mar 2024 05:18:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rgHjd-0002Si-Ju; Sat, 02 Mar 2024 00:16:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rgHjc-0002Ry-7b
 for qemu-devel@nongnu.org; Sat, 02 Mar 2024 00:16:32 -0500
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rgHja-0007W5-P5
 for qemu-devel@nongnu.org; Sat, 02 Mar 2024 00:16:31 -0500
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-5d8b887bb0cso2416652a12.2
 for <qemu-devel@nongnu.org>; Fri, 01 Mar 2024 21:16:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709356588; x=1709961388; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Y3Nnlz9fN+sLTLi0nggXUUY0sOM/rMTIsEeRdpJ4n4M=;
 b=BgTFTbTr6IYBfH9p+YElkWMm6UG+PA742OCBGFr6ui0cRxV4AxW/Guo00LxvQewOJn
 DOYUbQ375UHv/iCso0e69GrooGioizUJYgBjsDKPLsRFPUy6v7sTg6yB0bScXLUo9pRK
 RQwQ3lyFXD99jptFqqpKRJldGc8lJNBvHftzihqb77nRd9unRgkt/HwvgZa5a4A6uwtV
 mtDOraBLnKV/hv5DfbPExoPmcrJZPcP+3+0V7R5DQHpgDbiIEVDKxQw/AVwjUMK23MrR
 rfdgfseMixPoq2Z/UPqpCRDjrwiqIO8RPdrFMz3gWNgcbTqZ81AwhzieVF5mmgkB8Tgl
 Y+IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709356588; x=1709961388;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Y3Nnlz9fN+sLTLi0nggXUUY0sOM/rMTIsEeRdpJ4n4M=;
 b=LyPC7yCcKd+I/3VCSFHulYiwlnaI3DTev1rSCfpEqKx+iUfNg4yh0RCCcd50p5HBhD
 QCqVOrmD7ktVO7LmGD6A6+74//rGOw5jc6FoeDHcpJsBRF4wvdpVYqfwO95D8eZa/4fj
 demj8hZS139Lg2kgzYZLNDv3mbd/mdN2OPcieAP22xcTFF0F6gD8CL8CyRSsUnHOEX9o
 FI7X6lA9fPiYxoatAI0yTTqme/3Ke+tc0N2uwNGUe8dtyyDEwYAhYnERVuGYaDOtWXJu
 1oPlm8DioCgeEnqCD46hriY7nZgqz1eVJCqaJC63fe4L5u0JPJYLDOQG3Vih408LfzFK
 nYJw==
X-Gm-Message-State: AOJu0Yw0W3Pu9vicz9vCjR8BY9+ZXsngmthD90k8CMaZ6guN+gXCnuTl
 3uZx3OOwDJdMEsoZdEMJ9gVN2mU7MZIB9UFDobhm6TKmpp48T3blMzRiz/BkZrFDzhq5LXMKDG8
 h
X-Google-Smtp-Source: AGHT+IEIwkxB+bLAU4pFLrGUI9erD8dtImaLttJTD6O26QYStzse1gVb0EygCZKftgHxZVV2WJJpGA==
X-Received: by 2002:a05:6a20:748a:b0:1a1:4794:9134 with SMTP id
 p10-20020a056a20748a00b001a147949134mr635230pzd.28.1709356588257; 
 Fri, 01 Mar 2024 21:16:28 -0800 (PST)
Received: from stoup.. (098-147-055-211.res.spectrum.com. [98.147.55.211])
 by smtp.gmail.com with ESMTPSA id
 v8-20020a17090a458800b0029af67d4fd0sm4034901pjg.44.2024.03.01.21.16.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Mar 2024 21:16:27 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk,
	atar4qemu@gmail.com
Subject: [PATCH 13/41] target/sparc: Add feature bits for VIS 3
Date: Fri,  1 Mar 2024 19:15:33 -1000
Message-Id: <20240302051601.53649-14-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240302051601.53649-1-richard.henderson@linaro.org>
References: <20240302051601.53649-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52d.google.com
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

The manual separates VIS 3 and VIS 3B, even though they are both
present in all extant cpus.  For clarity, let the translator
match the manual but otherwise leave them on the same feature bit.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sparc/translate.c       | 4 ++++
 target/sparc/cpu-feature.h.inc | 1 +
 2 files changed, 5 insertions(+)

diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 1178fca9e3..0ebb9c3aa9 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -2145,6 +2145,8 @@ static int extract_qfpreg(DisasContext *dc, int x)
 # define avail_HYPV(C)    ((C)->def->features & CPU_FEATURE_HYPV)
 # define avail_VIS1(C)    ((C)->def->features & CPU_FEATURE_VIS1)
 # define avail_VIS2(C)    ((C)->def->features & CPU_FEATURE_VIS2)
+# define avail_VIS3(C)    ((C)->def->features & CPU_FEATURE_VIS3)
+# define avail_VIS3B(C)   avail_VIS3(C)
 #else
 # define avail_32(C)      true
 # define avail_ASR17(C)   ((C)->def->features & CPU_FEATURE_ASR17)
@@ -2158,6 +2160,8 @@ static int extract_qfpreg(DisasContext *dc, int x)
 # define avail_HYPV(C)    false
 # define avail_VIS1(C)    false
 # define avail_VIS2(C)    false
+# define avail_VIS3(C)    false
+# define avail_VIS3B(C)   false
 #endif
 
 /* Default case for non jump instructions. */
diff --git a/target/sparc/cpu-feature.h.inc b/target/sparc/cpu-feature.h.inc
index a30b9255b2..3913fb4a54 100644
--- a/target/sparc/cpu-feature.h.inc
+++ b/target/sparc/cpu-feature.h.inc
@@ -13,3 +13,4 @@ FEATURE(CACHE_CTRL)
 FEATURE(POWERDOWN)
 FEATURE(CASA)
 FEATURE(FMAF)
+FEATURE(VIS3)
-- 
2.34.1


