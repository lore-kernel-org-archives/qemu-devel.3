Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BA84C5AD55
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 04:56:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wteXH-0005SD-2J; Tue, 11 Aug 2026 00:56:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wteXE-0005Qc-QV
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 00:56:20 -0400
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wteXD-0002nV-Bk
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 00:56:20 -0400
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-38f620399a0so383748a91.2
 for <qemu-devel@nongnu.org>; Mon, 10 Aug 2026 21:56:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786424178; x=1787028978; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=VhlDEow7kayv7qRQDlE/Y1wsQ2IfOPvBYG5/m8i8FvA=;
 b=HeUcAHjFkCJCELe5OhC1kkrrtD3bNTOKCUJbwRtHlpcddeQ4P6Ijkid5wSm5tvvBJN
 Rb2ry0F6pCdOwM0yi9p62fBRQFDtZGs4H017U1cx8y5YVz3nEKqE8EE4BhebyC0fEdyk
 6gw654rHUqcevvvTnmKJSV5ziOPXA722ENTQejpjSBM/9wup7spXY0t75kYABI5K45ga
 QdRzcVCwi34RebkyFOs1OCnV55E3zbljH3vyn2NRYLnmkGgRuSf40laWJw1Bm8n7FZ80
 iXiCHYUTyrvS0dmuLQubGdSAHuNpyionfxNuJJdhfdiieo6/eop5MTdV7k7P96Nd9Lth
 uulw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786424178; x=1787028978;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=VhlDEow7kayv7qRQDlE/Y1wsQ2IfOPvBYG5/m8i8FvA=;
 b=XoeIe0KY8SQ0R+QOnqSSm8UZmDWV4w3WaPqs0onDR/hDBAJB8hbCf7vk4IT2i1IkxI
 Mi21ffHSe9xpxMjTXM2Jd/2MXeqOTSD2SNoh9CDYgfr4stKaBGkDTIKE2+LkEAhejZ4k
 6Tl9ixT/fkJcJxIR6YbMLTv5VUNN+yRM2kYxO2SF062ONDkj0+QFydcSJfE/P8zgldp6
 A2/irRs3fpN4LiLJH1fmyk7kfD/wlCQ+IooNLzZtZJqalF/z5O8w84osXQBMqsqy4KNf
 U5I6FHOjAEWx3vB6n9n5N/MWBeIZMw5xoJPBfZHM9ZBGbcUJmhjjqNwQLnapAIXq4GX0
 OqNw==
X-Gm-Message-State: AOJu0Yx+v08EqYF2KVee3gOGLlplXq6DeCPdQiQzPfMYzyE0pnlCI0F6
 7QdIJ16fWGdawQL7Ysj55eWQhr6oQzLzXMILA7L3PW7v1YQe2ASbcaMCX9mWBocV1DWBB2+Jmb9
 6w71A
X-Gm-Gg: AR+sD1198BBRQ315lLKj33/xZdbF4EaMgMeHjGIzwef176Mc8qMPk3fxaSLZT/CLhRk
 Ffwm9WhJhtCFSlcBZzF86YbHRdxgfPc7h4RiTk/h5vr6FoKxNRZlVoxxFLVNbBv4RvLyyaSnrqN
 pjMmu6HWBoMsUzo0oIQtLZf4QZIAUz9rRNRJK31EWJrNp9Nda4e6zEuxGg3JcKqw7irHdxC2G3w
 JR1IaWx6uJzXxAaVWsfr28I0B+8VHGxcHyVp9EWREhIJh2+DZ4wWpRZ7JT8Zy5GDpjN+64Ttz5l
 xOWPVJrhCp41END4wrxS+9fyIxXBCdtMoJ4vU7o0ZUe9lf9vyyF294MjCSHghdax7+E5/V24S0M
 2tLC1hw5YVBdWWVTNg9/ytX9UHffbKmLp1cKwXeYrATcZ/pWs3JncDpPM89juyetjKQ+K7fAvpT
 LObxQdvLQiTBmqUelFZUA758PAtjkwgImi+UcAxYKicKUG12QYWCs0u80CQOZR4XcxxYqOCO4oA
 3Z6c6MtNtGFD3y4BNKp
X-Received: by 2002:a17:90b:398d:b0:38d:e658:5959 with SMTP id
 98e67ed59e1d1-392ec4d23c3mr603158a91.5.1786424178016; 
 Mon, 10 Aug 2026 21:56:18 -0700 (PDT)
Received: from stoup.. (174-21-93-59.tukw.qwest.net. [174.21.93.59])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-392ee3084d0sm156818a91.8.2026.08.10.21.56.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Aug 2026 21:56:17 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH v2 12/16] tcg/loongarch64: Implement revbit{8,32,64}
Date: Mon, 10 Aug 2026 21:56:01 -0700
Message-ID: <20260811045605.1246543-13-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260811045605.1246543-1-richard.henderson@linaro.org>
References: <20260811045605.1246543-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102b.google.com
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

Reviewed-by: Anton Johansson <anjo@rev.ng>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/loongarch64/tcg-target.c.inc | 34 +++++++++++++++++++++++++++++---
 1 file changed, 31 insertions(+), 3 deletions(-)

diff --git a/tcg/loongarch64/tcg-target.c.inc b/tcg/loongarch64/tcg-target.c.inc
index 97ed51d99c..7d89e80886 100644
--- a/tcg/loongarch64/tcg-target.c.inc
+++ b/tcg/loongarch64/tcg-target.c.inc
@@ -1866,16 +1866,44 @@ static const TCGOutOpUnary outop_bswap64 = {
     .out_rr = tgen_bswap64,
 };
 
+static void tgen_revbit8(TCGContext *s, TCGType type, TCGReg a0, TCGReg a1)
+{
+    if (type == TCG_TYPE_I32) {
+        tcg_out_opc_revbit_4b(s, a0, a1);
+    } else {
+        tcg_out_opc_revbit_8b(s, a0, a1);
+    }
+}
+
 static const TCGOutOpUnary outop_revbit8 = {
-    .base.static_constraint = C_NotImplemented,
+    .base.static_constraint = C_O1_I1(r, r),
+    .out_rr = tgen_revbit8;
 };
 
+static void tgen_revbit32(TCGContext *s, TCGType type,
+                          TCGReg a0, TCGReg a1, unsigned flags)
+{
+    tcg_out_opc_revbit_w(s, a0, a1);
+
+    /* All 32-bit values are computed sign-extended in the register.  */
+    if (type == TCG_TYPE_I64 && (flags & TCG_BSWAP_OZ)) {
+        tcg_out_ext32u(s, a0, a0);
+    }
+}
+
 static const TCGOutOpBswap outop_revbit32 = {
-    .base.static_constraint = C_NotImplemented,
+    .base.static_constraint = C_O1_I1(r, r),
+    .out_rr = tgen_revbit32,
 };
 
+static void tgen_revbit64(TCGContext *s, TCGType type, TCGReg a0, TCGReg a1)
+{
+    tcg_out_opc_revbit_d(s, a0, a1);
+}
+
 static const TCGOutOpUnary outop_revbit64 = {
-    .base.static_constraint = C_NotImplemented,
+    .base.static_constraint = C_O1_I1(r, r),
+    .out_rr = tgen_revbit64,
 };
 
 static void tgen_neg(TCGContext *s, TCGType type, TCGReg a0, TCGReg a1)
-- 
2.43.0


