Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A92CCD4F3D
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 18:31:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPlcR-0004Lk-IU; Wed, 20 May 2026 14:26:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wPlc4-0003uL-Aq
 for qemu-devel@nongnu.org; Wed, 20 May 2026 14:25:48 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wPlc1-0001zF-PW
 for qemu-devel@nongnu.org; Wed, 20 May 2026 14:25:47 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-2baef9f5ecdso41919295ad.1
 for <qemu-devel@nongnu.org>; Wed, 20 May 2026 11:25:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779301544; x=1779906344; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nTIDtuillPXckV86mcaM2Utf4vRJVw8yqCVUR2w2Jkg=;
 b=ZNmIEcjKcYk7wxZp6GYp+zMnflmMGlZwupiLQiFSUY/JOxZoiDCoQxs2zKOFDyERom
 Ko92nUJpRBrMqhLhot0Q/H2vuuGicp4XyVoQzfUI6OoQBque80UVguoTU75qDVDEkxfm
 FUDdVDOiCjPbCNFNuq49IGc4ahtgdTyhPq8a9NbQCKTyEzDLSQE97QuLR25DE0IoXSpf
 LWr+q++gu6k0u4KTyZCSvL8gAmDolMSvhLBLDDsAFdI7OgtYj05/47uWWPBh3CVplHa3
 Z1zVdZN7hkVQD9VbpaAPrscHgYUrkyINFONkbG8nVRgbUXdTdWHF0GnAN/Jl2U0HB+TB
 /XrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779301544; x=1779906344;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=nTIDtuillPXckV86mcaM2Utf4vRJVw8yqCVUR2w2Jkg=;
 b=qrIsQAGgjjVOCuWzsHByOUtPArf0l5djL4g7QPxAYe8nsbPGKvCj2IyLRAEonIjK/K
 PB1csxhlYGP3+iuJ9ndBJSdrf7odDhvtV1yC0jySlpvd4OpslZXNZ4Gu/J76gBqPcanI
 X8RqKoSrJ66sPnrorsPmc1wsa98KGzxRWwdoNf5NmMh6pILAiuANU3KcVQ/GP7P+ptD9
 rfNdQnvfC4FtZJqEz0KpzNE8cUP9oROdf/1JnpS5SU0MHfqr3ibwjYxLAUFDOdWsj2dg
 MfBjFB0fSM/jgw3/DO/Wt4RxT1FoPGgYg+jObnuD0unpSfeCg01NZKi9X/HBHQCPf8Vj
 m1GA==
X-Gm-Message-State: AOJu0YycB5NZPmkTf58JscdcVNTmhh2nzJ3dkgNgVsuK4j5p8GAZ51+5
 0CyAuzLBcIZATdjTkHJvYkq/WSYvVFrM5XsCl+4Tu2J1zbXNIRRDcVeAuvUv2wDRoqlz90wcHUY
 z+4FYktg=
X-Gm-Gg: Acq92OECMZ0YlpV08hxlDrgmkjuAkfGIDVmM7tllY4PrJCEh6xy4jZOvbmH7T8YqGFq
 kNUzDGdLO2sK6IoOOhVMSyZKbOkyCzXYyFcXm2qy2swcQT2m3/S7lF+OaV2r8+9jRD0a9Q44ib7
 NYTQpGzd7JHaqui8FkwrROkG6I6tuRTeV3Imm+0YwX5R7vy+vGrUX5EsuzxUxlK3S0xvJmsK4Yt
 rF97T0DfKNn4S1B+KVpzAsI875p1jO8JHxHHzhn7sG/Usmbxtea58RhwEF3+DB+VdCH6HhsKA72
 CyVYUvUFLA3tLlfH9W4her3f0I59QA8gfVPiEaOuXF8tVFr+PTpg55yYGOy1xy4lHQ7TD/Ii/5X
 zE5qZsipFq36Xl8F90F8F507q0wBTfB1J7uMZ2qeQCGaTr1J9aASF5W3rIfkDkIA7s0ZeAMW2mL
 Gc8FXpl3Nwulu+01UQ+MAuY1hKrtx2
X-Received: by 2002:a17:903:1b70:b0:2bc:810b:5c0c with SMTP id
 d9443c01a7336-2bd7e8cbd1dmr289503025ad.34.1779301544217; 
 Wed, 20 May 2026 11:25:44 -0700 (PDT)
Received: from stoup.. ([71.212.142.33]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2bd5c0605ddsm217413925ad.32.2026.05.20.11.25.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 May 2026 11:25:43 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v6 41/64] target/arm: Enable FEAT_FP8 for -cpu max
Date: Wed, 20 May 2026 11:21:50 -0700
Message-ID: <20260520182213.872945-42-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260520182213.872945-1-richard.henderson@linaro.org>
References: <20260520182213.872945-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x634.google.com
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
 target/arm/tcg/cpu64.c        | 6 ++++++
 docs/system/arm/emulation.rst | 1 +
 2 files changed, 7 insertions(+)

diff --git a/target/arm/tcg/cpu64.c b/target/arm/tcg/cpu64.c
index bc866c5a67..8d0c057902 100644
--- a/target/arm/tcg/cpu64.c
+++ b/target/arm/tcg/cpu64.c
@@ -1391,6 +1391,12 @@ void aarch64_max_tcg_initfn(Object *obj)
     t = FIELD_DP64(t, ID_AA64SMFR0, FA64, 1);     /* FEAT_SME_FA64 */
     SET_IDREG(isar, ID_AA64SMFR0, t);
 
+    t = GET_IDREG(isar, ID_AA64FPFR0);
+    t = FIELD_DP64(t, ID_AA64FPFR0, F8E5M2, 1);   /* FEAT_FP8 */
+    t = FIELD_DP64(t, ID_AA64FPFR0, F8E4M3, 1);   /* FEAT_FP8 */
+    t = FIELD_DP64(t, ID_AA64FPFR0, F8CVT, 1);    /* FEAT_FP8 */
+    SET_IDREG(isar, ID_AA64FPFR0, t);
+
     /* Replicate the same data to the 32-bit id registers.  */
     aa32_max_features(cpu);
 
diff --git a/docs/system/arm/emulation.rst b/docs/system/arm/emulation.rst
index cf8771d541..b6f0ca9351 100644
--- a/docs/system/arm/emulation.rst
+++ b/docs/system/arm/emulation.rst
@@ -74,6 +74,7 @@ the following architecture extensions:
 - FEAT_FHM (Floating-point half-precision multiplication instructions)
 - FEAT_FP (Floating Point extensions)
 - FEAT_FP16 (Half-precision floating-point data processing)
+- FEAT_FP8 (FP8 convert instructions)
 - FEAT_FPAC (Faulting on AUT* instructions)
 - FEAT_FPACCOMBINE (Faulting on combined pointer authentication instructions)
 - FEAT_FPACC_SPEC (Speculative behavior of combined pointer authentication instructions)
-- 
2.43.0


