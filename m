Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05FF2CD5BA4
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 18:27:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPlZN-0007wY-U4; Wed, 20 May 2026 14:23:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wPlYu-00079O-5M
 for qemu-devel@nongnu.org; Wed, 20 May 2026 14:22:35 -0400
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wPlYq-0000Xb-MX
 for qemu-devel@nongnu.org; Wed, 20 May 2026 14:22:31 -0400
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-c80170db7d6so2316763a12.0
 for <qemu-devel@nongnu.org>; Wed, 20 May 2026 11:22:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779301346; x=1779906146; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XfEjDJlVu7LsFiNptc3UAEkKV/ApJAH3Ld019vvaP5k=;
 b=ApTEXpUIFJH35Tj5/4p6Vnz9+z197xnpjvnaMhpEKhBAKqUkci219kDyMZar+E8Kpw
 L2wXxoL+D0+BWX/sWMBGaE0XjFIlHngqgWIu4MQsJkc4PS5RvoIpyO8gYnbwJQ24Ed0P
 E+C4VtP7MsrTd9UTTMWaR4osAUB3H9EdJ7Jw4+u1d3EvGW6zmSlQD3j75PvNIOib1aLN
 1gVN3DJ0HCSSnFBUFyBdGtY3w4gdPOkmpmI+CoY+xKwdgLAyW5mvepYxgjprEvrDNat0
 kh3LV4XpVLHlgUJwl7cojrL1AYmzow63pyKOGMp/bvJUmAWZFfzqZQGiDpPGJLshPVgd
 Mv2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779301346; x=1779906146;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=XfEjDJlVu7LsFiNptc3UAEkKV/ApJAH3Ld019vvaP5k=;
 b=Foe4+OlA5kbND+635jbUTQPX7bjMpul7/TQlze0p9t/yAV/BN1BNOvqsqmtacT2xPO
 /W4OryGfZtEWaJpYRwiZ6VN6KfH+v1G67MS58/CDVZpDoMrlNe8kuR5zv6zpx736dE5j
 kzkjyjWV+GWZmCZmnPRoKEa187ZZAqzhVTTArIw5lm/0q0hblXDIh8ATeEaFssdh4Grd
 nCmYIdDryQAA7MngQpn0rTQt9cKMAREA054KIcIGAlrFHUTIBJr2xyo5fuiBSAaCGGLo
 WmzDRs9CE1+ZElgRXqXdOiiH1xEWh8T+gsTN5UeqF36Qz4NlnOEbR5kn/76MDzNHbs48
 DGaA==
X-Gm-Message-State: AOJu0YwZiIP3DGcUIXWSIwwV5VOuaXib4hU+SGoM/NRP58Hr1eLChLt/
 0K8K4DKCYLYEgRcYQ5tQpHJD9sFQdGsAqoGCxt+rFZNXuSQIhZIy6jAcO8Mq1oGonR2o5V4/JQF
 yBkLLnX4=
X-Gm-Gg: Acq92OGXp+E4iQamHcaPsXdsbu/TQ/Vk79O1VZEyr23k8H9x0Jp4LJVZ5ZinshAq8gC
 qYVHvXg36PVNvjGnSLEneQ3vbgC3rwZySU2kwK2/2ik9I/tKAwpjTL/7JqiZ63YGSKZVS04QcoN
 YeD+slurfLrC2k3pg/I8C5GZEDLS+FfHIItOfPk6bRTToiFf/+tYHuS4ls5ACMXpxU9tRKXbvyo
 RV326iBxCbIsi3pOoqRVhhxSDxPf20Cw4Oo5OIkTy+oZ+fbp7DBfpGTWnSEUeivjR1bH4HNOruc
 dETkEVwdnp0PHseQ88S9/S8TdkgElquKMn9xs1Cncylh70RNYbmgEjGRgA1deoxy245QHiqWk4s
 c6UrfV0wQsbZ8tnenmakVIWN2ryFJJyDzYjYYZkBfbZpv329MlGx3lUMShbVZBkY3nVpBHQMnEx
 t2QTNg+Zf+FadVy/4uCFjgRi/fH9ma
X-Received: by 2002:a17:90b:4d0e:b0:368:6a6e:94dd with SMTP id
 98e67ed59e1d1-36951ca31d6mr24740997a91.24.1779301345609; 
 Wed, 20 May 2026 11:22:25 -0700 (PDT)
Received: from stoup.. ([71.212.142.33]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-36a3d210b4esm274764a91.17.2026.05.20.11.22.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 May 2026 11:22:25 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v6 16/64] target/arm: Enable FEAT_FPMR for -cpu max
Date: Wed, 20 May 2026 11:21:25 -0700
Message-ID: <20260520182213.872945-17-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260520182213.872945-1-richard.henderson@linaro.org>
References: <20260520182213.872945-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52e.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/cpu64.c        | 4 ++++
 docs/system/arm/emulation.rst | 1 +
 2 files changed, 5 insertions(+)

diff --git a/target/arm/tcg/cpu64.c b/target/arm/tcg/cpu64.c
index ff0c2b1c47..a377f67b9c 100644
--- a/target/arm/tcg/cpu64.c
+++ b/target/arm/tcg/cpu64.c
@@ -1297,6 +1297,10 @@ void aarch64_max_tcg_initfn(Object *obj)
     t = FIELD_DP64(t, ID_AA64PFR1, GCS, 1);       /* FEAT_GCS */
     SET_IDREG(isar, ID_AA64PFR1, t);
 
+    t = GET_IDREG(isar, ID_AA64PFR2);
+    t = FIELD_DP64(t, ID_AA64PFR2, FPMR, 1);      /* FEAT_FPMR */
+    SET_IDREG(isar, ID_AA64PFR2, t);
+
     t = GET_IDREG(isar, ID_AA64MMFR0);
     t = FIELD_DP64(t, ID_AA64MMFR0, PARANGE, 6); /* FEAT_LPA: 52 bits */
     t = FIELD_DP64(t, ID_AA64MMFR0, TGRAN16, 1);   /* 16k pages supported */
diff --git a/docs/system/arm/emulation.rst b/docs/system/arm/emulation.rst
index da5f7efce2..44c7196d09 100644
--- a/docs/system/arm/emulation.rst
+++ b/docs/system/arm/emulation.rst
@@ -77,6 +77,7 @@ the following architecture extensions:
 - FEAT_FPAC (Faulting on AUT* instructions)
 - FEAT_FPACCOMBINE (Faulting on combined pointer authentication instructions)
 - FEAT_FPACC_SPEC (Speculative behavior of combined pointer authentication instructions)
+- FEAT_FPMR (Floating-point mode register)
 - FEAT_FRINTTS (Floating-point to integer instructions)
 - FEAT_FlagM (Flag manipulation instructions v2)
 - FEAT_FlagM2 (Enhancements to flag manipulation instructions)
-- 
2.43.0


