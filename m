Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D66E9C9830E
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2026 14:50:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9klp-0008Ss-TM; Thu, 24 Sep 2026 10:49:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x9klb-0008Kz-6k
 for qemu-devel@nongnu.org; Thu, 24 Sep 2026 10:49:46 -0400
Received: from mail-pz2-x10.google.com ([2607:f8b0:4864:3b::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x9klY-0005Ea-3C
 for qemu-devel@nongnu.org; Thu, 24 Sep 2026 10:49:42 -0400
Received: by mail-pz2-x10.google.com with SMTP id
 d2e1a72fcca58-8692a8568e9so1037591b3a.3
 for <qemu-devel@nongnu.org>; Thu, 24 Sep 2026 07:49:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790261377; x=1790866177; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=n2lHJSnUMpeS2SqKMsjTYAycECHfu0GOUATJYr54vBo=;
 b=oSBdSDR5vzKINDQZVt2CmIW/ZTbU+eAFTqNp8Yct1sv6Ctup642+YOe19VGtXRHMzo
 Mi4gb+/ujI3WGDuKrrFwIjFDWLyFOrzuoGKcmAHlOH3csW3z/+Eg144UQvk4kErEbuyo
 jbu72Ad6XR3YTtpZ7lqY3xR2/JcJRgE4EPsB3LmsVfOd3b2gwRKoemZjJF2zTQxB4nkj
 F57IMPXzPWktY71HSSptZPb6M6GPmlNoUC27TEBJkkoSM5jK43gjtkUgZdFqC6kYp8EH
 KNMkpgFhXXV1AF11pA07dXrLIGEk2GoJRfqL1BuQXbbwxtaj3LNGv4kbjkMtVriUK6bs
 NgJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790261377; x=1790866177;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=n2lHJSnUMpeS2SqKMsjTYAycECHfu0GOUATJYr54vBo=;
 b=w3tm9fikPv8hIfDZ5Yq6QLXLM77C+fOGmx4fLtWN7U4TclI82tAS538DyI3iU5Vgp3
 4z0qaJdiGSrr1MkrPEqKvQLjV9y1daPm6ixg52m+Q9/XwrI/hP+M8jI14vFA9rfTYFZo
 e9TXfUDutuhkaN8SoLhCAwaJAdxu6cIIq/ZhsHbn1Bb2f3IK+3n4oMsYKOsXCff4zQJl
 KQDMpcmwBKYbqqKaEVEw6HyNyZslwpU7n6nU0xVbspjJbn02nw3EYY4W0w9xBPsR2Kdj
 DzyAuwF2HkC3VkiaPeXvjOdWBP9okZE9B4lxRZyyfutA4ZLbFxDEsYNCUD5jf5qm0xm3
 K08w==
X-Gm-Message-State: AFuF++mJFOAT2+KkQMYK60pe0m41MIKCPfqxfMy3/QEQnECCTlJh2iRO
 GTi39hbsPcLrkTfpgPh1I83ih4pdllf7HkrjKsO//EFyg0zF9l5gx4p+xSRdUMdE4poZDI94sHh
 Qvo+r
X-Gm-Gg: AYBFou0qVbFxvjlViKXSr6CT6wqIhLNLHFnj4hE70p0CupZ8Nd6ezgTIy43ft0NXXAg
 AT6voPup3BAqfLok81BUjwGfR0O/t0a7WZmDpKs1MwjdJU1gak+UYjgwbvEytjSckqBg0tCpsru
 m/6LDxPcGOgR/nSfSWcaOWE4wwg6XV7hddVRElOyDMjTIaHProABQTaAD/I6TEtnSN6ZcFkbr+l
 u1ZvozRjtE9jFMMr3r56RF3McWOhQufFt46j09mZSPpxEHpir4H/ESlNaCqaGFx10g/tpe6w+4k
 UBOOQ2qJexS2/Pb3Vscf4K+W6Ab2knLnrVSGHmNhQ+EXvUoJIgcgaLwWxd2LF6rXWwXoopafwoH
 a/OttKbuFjvSQfVUx8vhJ8U7FEYHHthpJm0nLNvfD//az63/6dbCfkK0feN+tLZJrluXpJze+mH
 NELqwF2meWGxSlx5mL9OTPj3bzyMHRbrB3u1ThaelQfbL6vhkljyTiK2+GWg8i480DEbV13zvan
 IunBvIoBq2hbri50esmhMc6mxZ4gQ==
X-Received: by 2002:a05:6a00:e0a:b0:87d:e0ce:7421 with SMTP id
 d2e1a72fcca58-87e9d4d9a24mr2393156b3a.19.1790261377130; 
 Thu, 24 Sep 2026 07:49:37 -0700 (PDT)
Received: from stoup (174-21-68-150.tukw.qwest.net. [174.21.68.150])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-87d1dad3978sm3209818b3a.34.2026.09.24.07.49.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Sep 2026 07:49:36 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PULL 5/8] target/mips/tcg: Use gen_mxu_logic for
 gen_mxu_S32MAX_S32MIN
Date: Thu, 24 Sep 2026 07:49:28 -0700
Message-ID: <20260924144931.161335-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260924144931.161335-1-richard.henderson@linaro.org>
References: <20260924144931.161335-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:3b::10;
 envelope-from=richard.henderson@linaro.org; helo=mail-pz2-x10.google.com
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

Split S32MAX, S32MIN to separate functions.
Fixes a bug in that "0" was passed in one of the zero reg cases,
aka NULL, instead of a proper zero constant.

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/mips/tcg/mxu_translate.c | 47 +++++++--------------------------
 1 file changed, 9 insertions(+), 38 deletions(-)

diff --git a/target/mips/tcg/mxu_translate.c b/target/mips/tcg/mxu_translate.c
index 3f8acfcdb8f..4b2c264f031 100644
--- a/target/mips/tcg/mxu_translate.c
+++ b/target/mips/tcg/mxu_translate.c
@@ -2045,45 +2045,14 @@ static void gen_mxu_q16sxxv(DisasContext *ctx, bool right, bool arithmetic)
  *    Update XRa with the minimum of signed 32-bit integers contained
  *    in XRb and XRc.
  */
-static void gen_mxu_S32MAX_S32MIN(DisasContext *ctx)
+static void gen_mxu_S32MAX(DisasContext *ctx)
 {
-    uint32_t pad, opc, XRc, XRb, XRa;
+    gen_mxu_logic(ctx, tcg_gen_smax_i32);
+}
 
-    pad = extract32(ctx->opcode, 21, 5);
-    opc = extract32(ctx->opcode, 18, 3);
-    XRc = extract32(ctx->opcode, 14, 4);
-    XRb = extract32(ctx->opcode, 10, 4);
-    XRa = extract32(ctx->opcode,  6, 4);
-
-    if (unlikely(pad != 0)) {
-        /* opcode padding incorrect -> do nothing */
-    } else if (unlikely(XRa == 0)) {
-        /* destination is zero register -> do nothing */
-    } else if (unlikely((XRb == 0) && (XRc == 0))) {
-        /* both operands zero registers -> just set destination to zero */
-        tcg_gen_movi_i32(mxu_gpr[XRa - 1], 0);
-    } else if (unlikely((XRb == 0) || (XRc == 0))) {
-        /* exactly one operand is zero register - find which one is not...*/
-        uint32_t XRx = XRb ? XRb : XRc;
-        /* ...and do max/min operation with one operand 0 */
-        if (opc == OPC_MXU_S32MAX) {
-            tcg_gen_smax_i32(mxu_gpr[XRa - 1], mxu_gpr[XRx - 1], 0);
-        } else {
-            tcg_gen_smin_i32(mxu_gpr[XRa - 1], mxu_gpr[XRx - 1], 0);
-        }
-    } else if (unlikely(XRb == XRc)) {
-        /* both operands same -> just set destination to one of them */
-        tcg_gen_mov_i32(mxu_gpr[XRa - 1], mxu_gpr[XRb - 1]);
-    } else {
-        /* the most general case */
-        if (opc == OPC_MXU_S32MAX) {
-            tcg_gen_smax_i32(mxu_gpr[XRa - 1], mxu_gpr[XRb - 1],
-                                               mxu_gpr[XRc - 1]);
-        } else {
-            tcg_gen_smin_i32(mxu_gpr[XRa - 1], mxu_gpr[XRb - 1],
-                                               mxu_gpr[XRc - 1]);
-        }
-    }
+static void gen_mxu_S32MIN(DisasContext *ctx)
+{
+    gen_mxu_logic(ctx, tcg_gen_smin_i32);
 }
 
 /*
@@ -4328,8 +4297,10 @@ static void decode_opc_mxu__pool00(DisasContext *ctx)
 
     switch (opcode) {
     case OPC_MXU_S32MAX:
+        gen_mxu_S32MAX(ctx);
+        break;
     case OPC_MXU_S32MIN:
-        gen_mxu_S32MAX_S32MIN(ctx);
+        gen_mxu_S32MIN(ctx);
         break;
     case OPC_MXU_D16MAX:
     case OPC_MXU_D16MIN:
-- 
2.53.0


