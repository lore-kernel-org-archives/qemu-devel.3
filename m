Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54101E77183
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2024 17:44:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tM9YZ-0003BO-RP; Fri, 13 Dec 2024 12:34:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tM9Xf-0007fg-Kj
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 12:33:31 -0500
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tM9Xa-0001dw-RR
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 12:33:31 -0500
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-385f06d0c8eso1020885f8f.0
 for <qemu-devel@nongnu.org>; Fri, 13 Dec 2024 09:33:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734111203; x=1734716003; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=KC67yHdo6eZv8smMWuemE2zxBvf5Ux7ZXfjP+6tNWtQ=;
 b=Rz0ljPnMIqwRIJDwk3MJk+Pyd6aP5aJGCtkBIW/3BH2HLxVzSAi2Q+QOGn4f+Q2QiD
 H3iBfhXWf54IvNkjsgcGF4S14RrLizJAv9e4bpZctYxlPrZwMT2myz4gZjp/mra9KPU3
 Yx/ZPVlq4DdQfLOClA91AtfMNe6ui3wkBvohmXobASRyGoFZnlxtAp05BcjiMLJi+P5u
 M71FsrGTneQAr+gufdGBMfyJIGCPXxQHa0lVIV4Gcyds9KRVCTrga347vrG80NI/8pXc
 ungmOZt0WyuCTlkFBMmpWz1ZPF6xPhlVR6u8sdF3YAxcmhN6PAcSg5bZm/P6PaG8u/r9
 TWyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734111203; x=1734716003;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KC67yHdo6eZv8smMWuemE2zxBvf5Ux7ZXfjP+6tNWtQ=;
 b=LfnwN6rkiwOGYwQLwrHEijXRbRsAqzEzYMybwz4kgHjZvaojSgncUgM/MjbIYSG4PA
 Dbz70fzKBR/vP0ickbR0mkNEseuNtXBU+4qeCU5WcU5/m3dGhY/Ir0MEiRVQO9XggTcn
 pUhVm7P8acuUz7BgKlpuJFICOIHtSiYAkwF3hW/CyeUOXojINmhYZB2JzKqRtvsXUCug
 yGmkr4vmHv+oWa9uKi5JrLgIQu7g/Y3cWvi4EbP6r93vYUDyR9s4lEjxm/onp18veuF0
 xyfibF8akDU/OXG0QE9zGPl+4egWwtjPB2Xp67hBsLuKCKon+Bb3c2nJ9E5aOx0Ha/Uz
 6dAA==
X-Gm-Message-State: AOJu0Ywn7BggA1BwTVo4H56r9HcHQ3E2ir5kikMehNkdLbTgbKe6yxic
 39oJi75R8OIOSZDpAcE3CHFEEjpzpoEE39NpdDMUaJXdh1v10Bil+AkXySjOh4eBo5W6cQhunqK
 D
X-Gm-Gg: ASbGnctaBDmP/u3DLGE2wXI/ecqO8KS4JQmE859CWihbULy+Bs/5eDRUgvlfKikSE2u
 vuVXKM9YwwF5QPz8wQzInQxdpJit9EXj4H4mabxojlCe4/sz2OJywQX/5/kp4LAfNpFs2wvkXm9
 pNt7Ctz6ekYHd0oV7dLLU9Rwhe+39heLoAZqAUwcho2rdsP9uXaE7J3W/UInNcthmUti60oH9mD
 xRVS/dbGl44aIcO09oYXDwe3MVRjXtwMrToR8GnJDUh2/w3Z+UUfstBEEUpxQ==
X-Google-Smtp-Source: AGHT+IGEjxogV6Bj5RjFrdRJUOdCRnT9G8yEnqUmqg2p1Wg/gXjluyTWZp0IOTHVDGu0Y5hF55knZQ==
X-Received: by 2002:a5d:6487:0:b0:382:5088:9372 with SMTP id
 ffacd0b85a97d-3888e0b88afmr3095664f8f.43.1734111203440; 
 Fri, 13 Dec 2024 09:33:23 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-388c80162ddsm87026f8f.37.2024.12.13.09.33.22
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Dec 2024 09:33:22 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 48/85] target/arm: Introduce clear_vec
Date: Fri, 13 Dec 2024 17:31:52 +0000
Message-Id: <20241213173229.3308926-49-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241213173229.3308926-1-peter.maydell@linaro.org>
References: <20241213173229.3308926-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

In a couple of places, clearing the entire vector before storing one
element is the easiest solution.  Wrap that into a helper function.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20241211163036.2297116-49-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/translate-a64.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 717d30dd5b9..0e8e8670582 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -628,7 +628,16 @@ static TCGv_i32 read_fp_hreg(DisasContext *s, int reg)
     return v;
 }
 
-/* Clear the bits above an N-bit vector, for N = (is_q ? 128 : 64).
+static void clear_vec(DisasContext *s, int rd)
+{
+    unsigned ofs = fp_reg_offset(s, rd, MO_64);
+    unsigned vsz = vec_full_reg_size(s);
+
+    tcg_gen_gvec_dup_imm(MO_64, ofs, vsz, vsz, 0);
+}
+
+/*
+ * Clear the bits above an N-bit vector, for N = (is_q ? 128 : 64).
  * If SVE is not enabled, then there are only 128 bits in the vector.
  */
 static void clear_vec_high(DisasContext *s, bool is_q, int rd)
@@ -4851,7 +4860,6 @@ static bool trans_SM3SS1(DisasContext *s, arg_SM3SS1 *a)
         TCGv_i32 tcg_op2 = tcg_temp_new_i32();
         TCGv_i32 tcg_op3 = tcg_temp_new_i32();
         TCGv_i32 tcg_res = tcg_temp_new_i32();
-        unsigned vsz, dofs;
 
         read_vec_element_i32(s, tcg_op1, a->rn, 3, MO_32);
         read_vec_element_i32(s, tcg_op2, a->rm, 3, MO_32);
@@ -4863,9 +4871,7 @@ static bool trans_SM3SS1(DisasContext *s, arg_SM3SS1 *a)
         tcg_gen_rotri_i32(tcg_res, tcg_res, 25);
 
         /* Clear the whole register first, then store bits [127:96]. */
-        vsz = vec_full_reg_size(s);
-        dofs = vec_full_reg_offset(s, a->rd);
-        tcg_gen_gvec_dup_imm(MO_64, dofs, vsz, vsz, 0);
+        clear_vec(s, a->rd);
         write_vec_element_i32(s, tcg_res, a->rd, 3, MO_32);
     }
     return true;
@@ -6307,7 +6313,6 @@ static bool do_scalar_muladd_widening_idx(DisasContext *s, arg_rrx_e *a,
         TCGv_i64 t0 = tcg_temp_new_i64();
         TCGv_i64 t1 = tcg_temp_new_i64();
         TCGv_i64 t2 = tcg_temp_new_i64();
-        unsigned vsz, dofs;
 
         if (acc) {
             read_vec_element(s, t0, a->rd, 0, a->esz + 1);
@@ -6317,9 +6322,7 @@ static bool do_scalar_muladd_widening_idx(DisasContext *s, arg_rrx_e *a,
         fn(t0, t1, t2);
 
         /* Clear the whole register first, then store scalar. */
-        vsz = vec_full_reg_size(s);
-        dofs = vec_full_reg_offset(s, a->rd);
-        tcg_gen_gvec_dup_imm(MO_64, dofs, vsz, vsz, 0);
+        clear_vec(s, a->rd);
         write_vec_element(s, t0, a->rd, 0, a->esz + 1);
     }
     return true;
-- 
2.34.1


