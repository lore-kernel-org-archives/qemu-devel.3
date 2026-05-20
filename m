Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36AC9CD4F3C
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 11:29:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPf6y-0003fF-Ja; Wed, 20 May 2026 07:29:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wPf6v-0003c0-Ta
 for qemu-devel@nongnu.org; Wed, 20 May 2026 07:29:14 -0400
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wPf6s-0004a4-P9
 for qemu-devel@nongnu.org; Wed, 20 May 2026 07:29:13 -0400
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-678a16429c6so8566200a12.1
 for <qemu-devel@nongnu.org>; Wed, 20 May 2026 04:29:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779276549; x=1779881349; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KdA1IwgCPEN6aJYvmA3sZErNIjWvr/NFyJl2T/LkZD4=;
 b=yLGHkVvOJTgSYSh3GFE5+qeTqMzKtiCooycC0gwppMeH74shZEbxOQW8HEapSE0qGn
 F0iL/KfixmzXTfpJvOrHDNCQApNKmFZdUGlsyE9yR7qrV0CzPjWpO7dh1Oy1HtpqpkBA
 kaHuG3j0AG49SajGWiFZ6QZVTeyDphZhKFsHp9c5zZmOzE2gWwqqEfGBlhfgkyVkPcmF
 fYUN66elHgfsSvd2DdAkKqBD+i+y5bnZJBb2hlz1CcZ5+lZaiXjRpybVPw8OE34Jre+v
 Mu02ThQ+/tg7fL5FPSAhxrdC++LXhetJLBEpo7Afj72uR14fdXWll0Ay3tB7LHtrbwTn
 FQgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779276549; x=1779881349;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=KdA1IwgCPEN6aJYvmA3sZErNIjWvr/NFyJl2T/LkZD4=;
 b=Y5Hx4gmZJiuOpCjh1X7l4sBz4oYROnjOlk8t5GsOwniadRdnKz0j/i5C4SyBzRzWLV
 qsVy4uOynDCyFkhijPq66vORXz6h8LaOkVs3flFNgTgoIXrI1PoAHXO6+rdaJKfcT02Q
 Phvw4NB2Ab0WityMpLlMOpXOhzj+5PfCMEGgLzRfZBjGDMUzZGzjj5fvzRY73gcudWUU
 /xNH79nTa3pc0KD4CIPPVHKIn8aVVTZCfaZBbxwdZTKjdJ8NkkOXC22eM3GA8EbAXMSr
 MQEMUEe53bWhu4dX+sgVbfJlTc0ej2OUe+HLgDnGlFpbFW5JKuxjxOFcPNGnHy8O8G1+
 1Qlg==
X-Gm-Message-State: AOJu0YxEHousKAvEWuWLdwZ8/h1NSjs6e15xhFUQcW5/Obi642quMv5L
 J4h5J+u2sACASVlxM9EQ+7mRXFCfeWufcVsu0sRexizWvWzmLbmow5LriTIeuab4HSS2CM/cKGE
 +kN0NsE4=
X-Gm-Gg: Acq92OFMpu/rGmF//Crf3l0xa6VjTF2Z7yY5N7dpJEy1OBOZwajF7x/3cDGGJesuqHU
 lVQEsmc7OgF0JVHjVLZBb49LJG/FfCYHCPd3YtA1TqXKFrk/a3GAOqCtM+ikaOAHIdP4rpMSmOK
 eWszOZI+l7Cac5m4EMV1RJrUfRg/9hHfEVoJytEcfLirRgiPAPcEPGQu65R+Sv5yAU5o9/ZHEMV
 zyA17VouOu8FqJ7Pc87BNvOnwLcZhaY66ix+vVvt0s+p4Gaoo1wkKsKW7v+We4luQXwY+Z0cyZX
 PYD8cEF5ABjC47EWhYj4JVKEPJdN4CrV8Hk93qddZyLD0UO8bmgm3p3spkvRMaFzhdBy6CT/0j5
 JeIXP727ZzUxBPPBRFDQr6fEl6VmZnpbiI0mIQYMliiy+1OUI4BFFw5tNmew/7SPbfH9NvOFzFZ
 PYIG6Uzpk/+H8L9z1LsN3AGk5wDrUtBDLBEY0Xu8M1a6AXdXTpO600yBLvJ8I1p4CTe6KLKoHfn
 Tekrw==
X-Received: by 2002:a05:6000:2dc8:b0:457:ff13:b2a4 with SMTP id
 ffacd0b85a97d-45e5b73b26fmr36040445f8f.3.1779272409076; 
 Wed, 20 May 2026 03:20:09 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45d9ec3ac86sm52289889f8f.14.2026.05.20.03.20.07
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 20 May 2026 03:20:08 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Aleksandar Rikalo <arikalo@gmail.com>,
 James Hilliard <james.hilliard1@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v11 16/24] tcg: Introduce tcg_gen_addN_i64
Date: Wed, 20 May 2026 12:17:57 +0200
Message-ID: <20260520101807.9971-17-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260520101807.9971-1-philmd@linaro.org>
References: <20260520101807.9971-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x536.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

Add a helper for multi-limb 64-bit addition. The helper emits native
carry-chain TCG ops when they are available and falls back to explicit
carry propagation otherwise.

This lets target translators build wider integer accumulators inline
without open-coding the same add-with-carry sequence at each use site.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/tcg/tcg-op-common.h |  1 +
 tcg/tcg-op.c                | 42 +++++++++++++++++++++++++++++++++++++
 2 files changed, 43 insertions(+)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index e02f209c093..ee0ad5f6a3f 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -251,6 +251,7 @@ void tcg_gen_sub2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 al,
                       TCGv_i64 ah, TCGv_i64 bl, TCGv_i64 bh);
 void tcg_gen_addcio_i64(TCGv_i64 r, TCGv_i64 co,
                         TCGv_i64 a, TCGv_i64 b, TCGv_i64 ci);
+void tcg_gen_addN_i64(int n, TCGv_i64 *r, TCGv_i64 *a, TCGv_i64 *b);
 void tcg_gen_mulu2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_muls2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_mulsu2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 arg1, TCGv_i64 arg2);
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index d8ae57d6047..28ef5bacfdf 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -2275,6 +2275,48 @@ void tcg_gen_addcio_i64(TCGv_i64 r, TCGv_i64 co,
     }
 }
 
+void tcg_gen_addN_i64(int n, TCGv_i64 *r, TCGv_i64 *a, TCGv_i64 *b)
+{
+    tcg_debug_assert(n > 2);
+
+    /* ??? Don't allow overlap for now. */
+    for (int i = 0; i < n - 1; ++i) {
+        for (int j = i + 1; j < n; ++j) {
+            tcg_debug_assert(r[i] != a[j]);
+            tcg_debug_assert(r[i] != b[j]);
+        }
+    }
+
+    if (tcg_op_supported(INDEX_op_addci, TCG_TYPE_I64, 0)) {
+        tcg_gen_op3_i64(INDEX_op_addco, r[0], a[0], b[0]);
+        for (int i = 1; i < n - 1; ++i) {
+            tcg_gen_op3_i64(INDEX_op_addcio, r[i], a[i], b[i]);
+        }
+        tcg_gen_op3_i64(INDEX_op_addci, r[n - 1], a[n - 1], b[n - 1]);
+    } else {
+        TCGv_i64 t = tcg_temp_ebb_new_i64();
+        TCGv_i64 c = tcg_temp_ebb_new_i64();
+
+        tcg_gen_add_i64(t, a[0], b[0]);
+        tcg_gen_setcond_i64(TCG_COND_LTU, c, t, a[0]);
+        tcg_gen_mov_i64(r[0], t);
+
+        for (int i = 1; i < n - 1; ++i) {
+            tcg_gen_add_i64(t, a[i], c);
+            tcg_gen_setcond_i64(TCG_COND_LTU, c, t, c);
+            tcg_gen_add_i64(r[i], b[i], t);
+            tcg_gen_setcond_i64(TCG_COND_LTU, t, r[i], t);
+            tcg_gen_or_i64(c, c, t);
+        }
+
+        tcg_gen_add_i64(r[n - 1], a[n - 1], b[n - 1]);
+        tcg_gen_add_i64(r[n - 1], r[n - 1], c);
+
+        tcg_temp_free_i64(t);
+        tcg_temp_free_i64(c);
+    }
+}
+
 void tcg_gen_sub2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 al,
                       TCGv_i64 ah, TCGv_i64 bl, TCGv_i64 bh)
 {
-- 
2.53.0


