Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1526DC02192
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Feb 2025 16:46:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1teGZE-0000zP-Tg; Sat, 01 Feb 2025 11:42:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1teGYw-0007hi-IN
 for qemu-devel@nongnu.org; Sat, 01 Feb 2025 11:41:42 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1teGYu-0001PB-OI
 for qemu-devel@nongnu.org; Sat, 01 Feb 2025 11:41:42 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-435f8f29f8aso22433865e9.2
 for <qemu-devel@nongnu.org>; Sat, 01 Feb 2025 08:41:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738428099; x=1739032899; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=M3tUHrJKXhPgJLvHhPMtmUKu8TibFHHOtysrUtn96z0=;
 b=nnGcf8cW+X2/0m6Ykg36SkHdlLEBCROHOA4CINxVIXhYfXs69BbEbrJMbmKzerZZX8
 GDWbySd1uanL/nf6oF5OBc05vz9JKqNqIrmG/rYoI/XFWnbsBHVyRqNB/YnlxZWQIxLC
 QCISX5hjghEI6mZOu6MCvty4vy+TBKG/S6mZXimlXhsYNE1oTXvrU8a8BFZOtEbobSBC
 R/Fx1c1/YMrfy7XNU8IlesNIWDE/qzUhMiaWSrmFuiXjuJoE+sfM/SEAAupuklj5Hc5M
 3wDixSipAlOARyTgKt/LHsNuyTbzFSeKzQxkAY+ok/TbJt746ASQ8C3vFy9suaodKDEm
 imRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738428099; x=1739032899;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=M3tUHrJKXhPgJLvHhPMtmUKu8TibFHHOtysrUtn96z0=;
 b=eu/W6Y7ZMI1yyNkBci0LV8rrVr+tteMMeZKZk14etUVHaSQutyxS8MQpxCTfRDP3YB
 10yKBwjFAfF9qMhjIR695WApw2IpGGCASW0I7NAbswjS9EV2WXPac8ucvFwZnitc48MQ
 KeUMTg3CXK1k8kh0JiyopiTBADfbMrwBBH5oQ/uUfQvgUa46Ntqy/7izrTzxIMbdEW0J
 VvNFG9mXhq+TacY1MHccqTlf6Q4L5dNyVMS+/t2xRztk5tCTMNkjypXnuZN0dfayGMvQ
 CXM2POl0PLhZ5kebPuN+CxomgzrF8G8RuO8UpPBGQn/FtA3P3jkQy/+qbVIrwHFxTMmX
 67qw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXYJYZdjYb/s+V6uMAf+g5tz/C2rA2PGi0Qr2Do4IhK730wM38p1HxwpKnjUnR6JbljcGUmHmS9Sr2j@nongnu.org
X-Gm-Message-State: AOJu0YzugUpugff6UoXkVPYKT3H6COxNotmp2FnikSd3J+XS2m4kUsZT
 Agyqyc533+jbhTnTQ1DhGzq4xKs+CfaSF+BXJ9TyaBtx9cLCUFknxSZiZh4PPbM=
X-Gm-Gg: ASbGnctJqMpt59TrXcDiz1KaPrIhzLL7zw2IgqsvB/+Ed81Qr5hrNOFbL4TpB3reBZ3
 C/uxl09R4tuYr6EBAUgok06/6KXN1PDsGZwxUniL+vslaBII1jdb5wF1PaqSJlIbFsHa4LW/+ka
 25XkfnjH/9yirTKEVXsReyHLbLVu33npV3dslZaahEPIvg+lKdTUEkNav2gzY3FHAaTO+17uQk1
 R4kxJgsv/X+Ri2teXAWZ5IpsU+bwocrfHww9Rq9KTtsnVDvVcjCBgoZFRAqE/Jo+mMJeoNlNXEJ
 w2gB0bxDZTpembjL8Z3/
X-Google-Smtp-Source: AGHT+IF1b8v+Iu+L0DqSZae/QqfRCTPD7XOYGphhm1ntDGJ6pKrKGDKuhIW0D0UXfKxiq3kAoX/Jpw==
X-Received: by 2002:a05:600c:4e01:b0:435:136:75f6 with SMTP id
 5b1f17b1804b1-438dc34b179mr157304455e9.0.1738428099313; 
 Sat, 01 Feb 2025 08:41:39 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438dcc81d74sm127401525e9.37.2025.02.01.08.41.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 01 Feb 2025 08:41:38 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH v2 68/69] target/arm: Read fz16 from env->vfp.fpcr
Date: Sat,  1 Feb 2025 16:40:11 +0000
Message-Id: <20250201164012.1660228-69-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250201164012.1660228-1-peter.maydell@linaro.org>
References: <20250201164012.1660228-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32b.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

Read the bit from the source, rather than from the proxy via
get_flush_inputs_to_zero.  This makes it clear that it does
not matter which of the float_status structures is used.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20250129013857.135256-34-richard.henderson@linaro.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/vec_helper.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/target/arm/tcg/vec_helper.c b/target/arm/tcg/vec_helper.c
index 2da44ae7102..cc3586f44ac 100644
--- a/target/arm/tcg/vec_helper.c
+++ b/target/arm/tcg/vec_helper.c
@@ -2155,7 +2155,7 @@ void HELPER(gvec_fmlal_a32)(void *vd, void *vn, void *vm,
     uint64_t negx = is_s ? 0x8000800080008000ull : 0;
 
     do_fmlal(vd, vn, vm, &env->vfp.fp_status[FPST_STD], negx, 0, desc,
-             get_flush_inputs_to_zero(&env->vfp.fp_status[FPST_A32_F16]));
+             env->vfp.fpcr & FPCR_FZ16);
 }
 
 void HELPER(gvec_fmlal_a64)(void *vd, void *vn, void *vm,
@@ -2173,7 +2173,7 @@ void HELPER(gvec_fmlal_a64)(void *vd, void *vn, void *vm,
         }
     }
     do_fmlal(vd, vn, vm, &env->vfp.fp_status[FPST_A64], negx, negf, desc,
-             get_flush_inputs_to_zero(&env->vfp.fp_status[FPST_A64_F16]));
+             env->vfp.fpcr & FPCR_FZ16);
 }
 
 void HELPER(sve2_fmlal_zzzw_s)(void *vd, void *vn, void *vm, void *va,
@@ -2183,7 +2183,7 @@ void HELPER(sve2_fmlal_zzzw_s)(void *vd, void *vn, void *vm, void *va,
     bool is_s = extract32(desc, SIMD_DATA_SHIFT, 1);
     intptr_t sel = extract32(desc, SIMD_DATA_SHIFT + 1, 1) * sizeof(float16);
     float_status *status = &env->vfp.fp_status[FPST_A64];
-    bool fz16 = get_flush_inputs_to_zero(&env->vfp.fp_status[FPST_A64_F16]);
+    bool fz16 = env->vfp.fpcr & FPCR_FZ16;
     int negx = 0, negf = 0;
 
     if (is_s) {
@@ -2236,7 +2236,7 @@ void HELPER(gvec_fmlal_idx_a32)(void *vd, void *vn, void *vm,
     uint64_t negx = is_s ? 0x8000800080008000ull : 0;
 
     do_fmlal_idx(vd, vn, vm, &env->vfp.fp_status[FPST_STD], negx, 0, desc,
-                 get_flush_inputs_to_zero(&env->vfp.fp_status[FPST_A32_F16]));
+                 env->vfp.fpcr & FPCR_FZ16);
 }
 
 void HELPER(gvec_fmlal_idx_a64)(void *vd, void *vn, void *vm,
@@ -2254,7 +2254,7 @@ void HELPER(gvec_fmlal_idx_a64)(void *vd, void *vn, void *vm,
         }
     }
     do_fmlal_idx(vd, vn, vm, &env->vfp.fp_status[FPST_A64], negx, negf, desc,
-                 get_flush_inputs_to_zero(&env->vfp.fp_status[FPST_A64_F16]));
+                 env->vfp.fpcr & FPCR_FZ16);
 }
 
 void HELPER(sve2_fmlal_zzxw_s)(void *vd, void *vn, void *vm, void *va,
@@ -2265,7 +2265,7 @@ void HELPER(sve2_fmlal_zzxw_s)(void *vd, void *vn, void *vm, void *va,
     intptr_t sel = extract32(desc, SIMD_DATA_SHIFT + 1, 1) * sizeof(float16);
     intptr_t idx = extract32(desc, SIMD_DATA_SHIFT + 2, 3) * sizeof(float16);
     float_status *status = &env->vfp.fp_status[FPST_A64];
-    bool fz16 = get_flush_inputs_to_zero(&env->vfp.fp_status[FPST_A64_F16]);
+    bool fz16 = env->vfp.fpcr & FPCR_FZ16;
     int negx = 0, negf = 0;
 
     if (is_s) {
-- 
2.34.1


