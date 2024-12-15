Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE573E7716A
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Dec 2024 19:10:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tMtwE-0001Fw-Ag; Sun, 15 Dec 2024 14:05:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tMtwB-0001FO-NT
 for qemu-devel@nongnu.org; Sun, 15 Dec 2024 14:05:55 -0500
Received: from mail-oa1-x2c.google.com ([2001:4860:4864:20::2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tMtwA-00010H-2N
 for qemu-devel@nongnu.org; Sun, 15 Dec 2024 14:05:55 -0500
Received: by mail-oa1-x2c.google.com with SMTP id
 586e51a60fabf-29e149aff1dso1087327fac.1
 for <qemu-devel@nongnu.org>; Sun, 15 Dec 2024 11:05:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734289553; x=1734894353; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PpFinQbLBbCXIc1LIL8UrXhYAzfU1OtCvzLR35OWdYU=;
 b=RMenslVjZuq2vruoMJsnKBDPoIICU5nnpPpsKf6V/FUgbF2KrmwUyrVRgvY+Em6+zi
 uCAGfjCsTEpN8g1Ty+ti8FbPN4IHfgDJllWYjKhO+Za7sNfzrqXYCPXZ3NKt+hkcvOKq
 JQSxklWaQwj89tbQJwVJztt6b5E41mwmD1o9WsBpmMyIz8Un037vU7jzNAUawhoq08Is
 ucYFZX6EXV1ViculRbVWEFTAVzwmMSeMX3s4MjuK1N1Bb+V8/zTcRYBfnIZSgAGy9vYQ
 tohb5jv2OvPeI4P+HvmOhRbGm+E+LQ1rmgdb9Wuqwo6alM7eIpVN/6txNjiJV4GqgfKV
 yaPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734289553; x=1734894353;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PpFinQbLBbCXIc1LIL8UrXhYAzfU1OtCvzLR35OWdYU=;
 b=GXaDoZM6DNWYtVSJ14C88sHtf3rcIOs2LV4v3BTvF6BVfKwIVVNK5OGKyaHK7pXA/0
 LeNqYbZouMC38NMOF3e6UX46toYrasX4egs53Xa1fNIOwkyaxjfk9pGmZRSd1AjtCZlA
 GxZUopjvl+i/b3u5dsKfvPbmdcwXFhleLy1CkeyoHbq8fbkUHIajwiz9Pl4Rivzy7blI
 w7CQPs2sBQq61e/GmEpS081JamsoTYdGnIV7+V7JM7ev80L6W9e0ekdf5RS5i7ch3FXa
 aC0rgK2bBK+W14/b6hwNDbXmPqnGJfDlDnFaMx5rbIxzC///d7gLA9WQcqGO3BsxcSwf
 +X6w==
X-Gm-Message-State: AOJu0YwEG8RfmhVfip/1mM1y8gdLcMNexbqDNQLtjkI3EM3M7wLlHX7X
 mmcG1lyskPxSDLhuwikflYxggKjKCJCHi0nvdyZD7vaDOORMVt9QigM8hUWcMRBRwfS/OoRtifF
 ktIopgXBM
X-Gm-Gg: ASbGnctEVIdd+Yg8B0jwVD/CIU/vO+110rAr8OniPCSDoIuNLUYFfLQimqMnmE6fWPo
 aAC55CJ/pawSz3+XB/Y1bNRjfXzEBm/N8botR9m3aPvW56GF35g0dkaBGmh4i6LMUP0pAy6jAyV
 VyRjJM7SKDImD169e+XvkwSLFvHI5w1/a6lkdoqvLUx/rS2azCKDYvOCJH1aDyTibB+3dqwtNCP
 FUJADdn3FYoY43A5b8AvlHwtwpJwbX8MhHdApoob4FlV7uAA/AqZcgLwYCNkJYpwV6DFuCvu0fw
 EnqukUcM99hPgf/dKd5PEMo/ucmxPXettYrn0cY75VA=
X-Google-Smtp-Source: AGHT+IG5pSecK+ecnbbq6I9zMypdsaCJfD9fW7iGP/vrN/tj8C3/q7O0nT2MgabzC7FBCxEUkNYOSg==
X-Received: by 2002:a05:6870:7a16:b0:29e:6547:bffa with SMTP id
 586e51a60fabf-2a3ac751e4emr5877822fac.21.1734289552897; 
 Sun, 15 Dec 2024 11:05:52 -0800 (PST)
Received: from localhost.localdomain (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2a3d2914ac6sm1423214fac.39.2024.12.15.11.05.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Dec 2024 11:05:52 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 09/67] target/sparc: Constify all Property and PropertyInfo
Date: Sun, 15 Dec 2024 13:04:35 -0600
Message-ID: <20241215190533.3222854-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241215190533.3222854-1-richard.henderson@linaro.org>
References: <20241215190533.3222854-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::2c;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x2c.google.com
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sparc/cpu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/sparc/cpu.c b/target/sparc/cpu.c
index 284df950e0..8f494c286a 100644
--- a/target/sparc/cpu.c
+++ b/target/sparc/cpu.c
@@ -874,14 +874,14 @@ static void sparc_set_nwindows(Object *obj, Visitor *v, const char *name,
     cpu->env.def.nwindows = value;
 }
 
-static PropertyInfo qdev_prop_nwindows = {
+static const PropertyInfo qdev_prop_nwindows = {
     .name  = "int",
     .get   = sparc_get_nwindows,
     .set   = sparc_set_nwindows,
 };
 
 /* This must match feature_name[]. */
-static Property sparc_cpu_properties[] = {
+static const Property sparc_cpu_properties[] = {
     DEFINE_PROP_BIT("float128", SPARCCPU, env.def.features,
                     CPU_FEATURE_BIT_FLOAT128, false),
 #ifdef TARGET_SPARC64
-- 
2.43.0


