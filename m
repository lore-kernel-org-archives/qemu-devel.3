Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CA02CD6E56
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2026 03:33:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUcLR-00025i-F8; Tue, 02 Jun 2026 23:32:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wUcLI-0001XO-Fe
 for qemu-devel@nongnu.org; Tue, 02 Jun 2026 23:32:33 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wUcLF-0004cW-Jm
 for qemu-devel@nongnu.org; Tue, 02 Jun 2026 23:32:32 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-2c0b944f6edso33866235ad.2
 for <qemu-devel@nongnu.org>; Tue, 02 Jun 2026 20:32:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780457547; x=1781062347; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=P/P/bsLRa8Km1ZFwwN9fhqKy4ONbgc9/cxj6UUIH6cY=;
 b=xpT5uizjJmGwvUr6U3L4vNX4p/fhLEJ9jw3gFKafS+XzaKe8s2rGZ7DR5pHknNv6ku
 in31pyC4lqNtrE4vff/1Xp6zys+ut7h0sFvF+kEb7RZUmAJ/BbWQjtbDFk24igtC4iiM
 8OHXonofe5ZkRxvUBEBqY+aox1v1mkxAdD10WSZAR6C5TsvEkA6Q/LNXkjoZI0Fb4WOn
 S1Z1XL6lMWd77mShrKVT7GqPzvN3hbY6EkzPE7S34Z9VRoJYwu0+P+3KKHgEi1J+s1jc
 yinz2/g3yypVOS6qeCB2aYku/5D8H0wO4Tmo1Jl/ntj3sr0lL+WubXoYMFwvXCVEdxyb
 XOBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780457547; x=1781062347;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=P/P/bsLRa8Km1ZFwwN9fhqKy4ONbgc9/cxj6UUIH6cY=;
 b=F4hDXeGYjq5+uUpS9UJ8FAyvKZVI394RT8z4GdtuEFEqT7dwMDlPnHeTB7YXsPXcxp
 2v/Rz1TAFaVX7Ylkv1IxQHSpkvLJvXnFiyfdzfPWEyf2Tbp1XgrR7tixy+hRcDn5OwcJ
 8yjH24HQ+BFgEVkeScnAJOKYayUhRdK0dXv5h0wQ4nY1n6MHDnjjSxZLmlVsZja4h2Fo
 ByjOGKuuSiHwXnwqNDfrKqpHmyd4FL/y4AriU1ZIYKWpq68d50IQiet3usZzYeux8ytA
 a7XSm5ha1c4a/O2E2nlXaDUn+vjxLr/2ZfgwPn3Kn+8wFr2DmL6xjjD1xSUF0Raafwjz
 PB1Q==
X-Gm-Message-State: AOJu0YxtOagxRWlcO3J+3zgij24ViqlFOLqQiKjipbDqjjC9jBdz6le0
 GAGLMDy24DoprDvpfhuwWF9/9yQcZwtcxvul4p5kdnFiwvtFqTkk/689fayf/EZ8fCkbKGJy8Vl
 DwGhyJh8=
X-Gm-Gg: Acq92OGAO5wTAvtPQ6u9s4I5LLG6BUIpP2a+z3/wAXs5nvMc/hSL23hUEqlsL8G0va7
 sYER8Q54uMkEyskJhHG2Tj0NT/8SUjcUR77v3vt0/d/CtJrbghsu7WxqBtBQ8+X3rZxu0mXp6TN
 zhxDDHzzeKGupgOqxzzLZ/o0m5wraaaSpF7n7dZGjxuRTtJ/7bF3GYzAOrVnfmYrcdDjK4/sMKp
 qjlXjXXJbKyd38DBW9BHG7sot10JIkreWPO6KIOgeYwfXhnAB0W7Ohpolxme78K9KVv3Y1nxM9R
 j5fy/cx5cOE8tViBg/ROUGEu4GrYN65hxTD5VyFF0nN9oIzQi/2qtIm/zo2RQZzWOsahPzxFGto
 RU0Cnae4muueSvdYYWFkXVA22siweUL48TMCTvQrvvYgM3QbGpBn1Zle/b+Rx3+2zI+3/iV7G3d
 azMLj7fMlKZogXXHmquGpUMOqZBh2YMeNK79aleG9yKyshE/DNZQ==
X-Received: by 2002:a17:902:c947:b0:2c0:ab92:584c with SMTP id
 d9443c01a7336-2c163fa8a01mr17026835ad.25.1780457547132; 
 Tue, 02 Jun 2026 20:32:27 -0700 (PDT)
Received: from stoup.. ([71.212.142.33]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c164fa0236sm7785685ad.33.2026.06.02.20.32.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jun 2026 20:32:26 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v9 42/45] target/arm: Enable FEAT_F8F32MM for -cpu max
Date: Tue,  2 Jun 2026 20:28:51 -0700
Message-ID: <20260603032855.106930-43-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260603032855.106930-1-richard.henderson@linaro.org>
References: <20260603032855.106930-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
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
 linux-user/aarch64/elfload.c  | 1 +
 target/arm/tcg/cpu64.c        | 1 +
 docs/system/arm/emulation.rst | 1 +
 3 files changed, 3 insertions(+)

diff --git a/linux-user/aarch64/elfload.c b/linux-user/aarch64/elfload.c
index d40e39169b..7864765ba0 100644
--- a/linux-user/aarch64/elfload.c
+++ b/linux-user/aarch64/elfload.c
@@ -171,6 +171,7 @@ abi_ulong get_elf_hwcap(CPUState *cs)
     GET_FEATURE_ID(aa64_rcpc_8_4, ARM_HWCAP_A64_ILRCPC);
     GET_FEATURE_ID(aa64_gcs, ARM_HWCAP_A64_GCS);
     GET_FEATURE_ID(aa64_cmpbr, ARM_HWCAP_A64_CMPBR);
+    GET_FEATURE_ID(aa64_f8mm8, ARM_HWCAP_A64_F8MM8);
 
     return hwcaps;
 }
diff --git a/target/arm/tcg/cpu64.c b/target/arm/tcg/cpu64.c
index 893e20f0eb..15dafb9aee 100644
--- a/target/arm/tcg/cpu64.c
+++ b/target/arm/tcg/cpu64.c
@@ -1399,6 +1399,7 @@ void aarch64_max_tcg_initfn(Object *obj)
     t = GET_IDREG(isar, ID_AA64FPFR0);
     t = FIELD_DP64(t, ID_AA64FPFR0, F8E5M2, 1);   /* FEAT_FP8 */
     t = FIELD_DP64(t, ID_AA64FPFR0, F8E4M3, 1);   /* FEAT_FP8 */
+    t = FIELD_DP64(t, ID_AA64FPFR0, F8MM8, 1);    /* FEAT_F8F32MM */
     t = FIELD_DP64(t, ID_AA64FPFR0, F8DP2, 1);    /* FEAT_FP8DOT2 */
     t = FIELD_DP64(t, ID_AA64FPFR0, F8DP4, 1);    /* FEAT_FP8DOT4 */
     t = FIELD_DP64(t, ID_AA64FPFR0, F8FMA, 1);    /* FEAT_FP8FMA */
diff --git a/docs/system/arm/emulation.rst b/docs/system/arm/emulation.rst
index f1c8f5aa68..dcfb4f2073 100644
--- a/docs/system/arm/emulation.rst
+++ b/docs/system/arm/emulation.rst
@@ -67,6 +67,7 @@ the following architecture extensions:
 - FEAT_EPAC (Enhanced pointer authentication)
 - FEAT_ETS2 (Enhanced Translation Synchronization)
 - FEAT_EVT (Enhanced Virtualization Traps)
+- FEAT_F8F32MM (8-bit floating-point matrix multiply-accumulate to single-precision)
 - FEAT_F32MM (Single-precision Matrix Multiplication)
 - FEAT_F64MM (Double-precision Matrix Multiplication)
 - FEAT_FAMINMAX (Floating-point maximum and minimum absolute value instructions)
-- 
2.43.0


