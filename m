Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 940C8C25B76
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2024 17:25:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEuMH-0006Ef-5X; Wed, 05 Jun 2024 13:23:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sEuMF-0006Cm-48
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 13:23:31 -0400
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sEuMC-0003x6-T2
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 13:23:30 -0400
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-2c21d7de619so47289a91.2
 for <qemu-devel@nongnu.org>; Wed, 05 Jun 2024 10:23:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717608208; x=1718213008; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FvgbvNkpvAzCMVFVXkCW6K6l6RGI/GwPBdbgQeZ0jQU=;
 b=wnaVusguKwfwbCX4PJE/RlYqSsUHchWqowMZlOViUZcT0ObHoIsclOvCc+2/+sSo+u
 P3Bm5V/j/tPcriZw2zS1Pxz9ZEYGdfIQBq0NlCbOj8FI5nkAZwOnXmeMKQHojFDE9g2f
 DQAmx3jbjKAGOZVPwEOcS8LWGwFOeDOve3tpvocC99rbbGq75vvo3ZtyOZ451g/pJFRd
 TGDB2HyZGzCKeLyNXakDLHGMDi7st8lpC50xR3kWDAuavE1p7XxJ1kaxiCJGP/Q8OFen
 mFmWOwOEoRSabpRPu1D4fgxue8XksH0OF63Sa6Mzq3ROvuXvjyJSGlZeyDVBiR6RUbB2
 29OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717608208; x=1718213008;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FvgbvNkpvAzCMVFVXkCW6K6l6RGI/GwPBdbgQeZ0jQU=;
 b=Z8+A2rx9K/zgPJe3dIX7hVtBRHiE/WjifQuFKktpqRoywp6fnhbVUYDYqyy2ScvGJH
 3OFUG1nieXIccoA0OpXPBPgJ7lyMaNz9B6reNOPyUoXn3Hye3kH+7ceEkmSYrukFZF6S
 l1K9odDob4zCaVItyMftFIW8qqhMtxOhJBYU0hc9RcjlrofVgdjF6qnyWcoQ47nynfOn
 jmUkebsdV8MUmkB7dZ6dQneArG1x8j3iMyCgM9sm3Sg6KQ0SZHDJxAEPePYHncEMcUvy
 tg+Ox+JA2HYb9q926PjCho3zZqIRp5N/khZaIuCEgX5oOkQLZjP1GsAXlgFK4L+HWDRk
 T1Yg==
X-Gm-Message-State: AOJu0YwIrn3NnS3QPgnHfxllreIEmLvNXwQ3uI58jLY+dMOWRRM5x0mf
 W4ZyC49lvgZ8KjKNj2yGqwmFNXTP92yvKj3v9hOLOg5YV3HBPZvRBZlZlYHo1Zt2TVyZ9dwGiuu
 O
X-Google-Smtp-Source: AGHT+IGRLmR0UQHuVXRQct377QeuaIjQ4+UzrEOSGB4qEqJxIzrvS1rjxTZadhFid5s8nDKdK3iwNg==
X-Received: by 2002:a17:90a:fa49:b0:2bd:e884:bc72 with SMTP id
 98e67ed59e1d1-2c27dafa4d3mr3403507a91.5.1717608207686; 
 Wed, 05 Jun 2024 10:23:27 -0700 (PDT)
Received: from stoup.. ([71.212.132.216]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2c28066d511sm1720915a91.9.2024.06.05.10.23.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Jun 2024 10:23:27 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 35/38] target/sparc: Implement SUBXC, SUBXCcc
Date: Wed,  5 Jun 2024 10:22:50 -0700
Message-Id: <20240605172253.356302-36-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240605172253.356302-1-richard.henderson@linaro.org>
References: <20240605172253.356302-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102c.google.com
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sparc/insns.decode |  2 ++
 target/sparc/translate.c  | 14 ++++++++++++++
 2 files changed, 16 insertions(+)

diff --git a/target/sparc/insns.decode b/target/sparc/insns.decode
index 2ebee5a1ca..a7720560f8 100644
--- a/target/sparc/insns.decode
+++ b/target/sparc/insns.decode
@@ -447,6 +447,8 @@ FCMPEq      10 000 cc:2 110101 .....  0 0101 0111 .....    \
     PDISTN      10 ..... 110110 ..... 0 0011 1111 .....    @r_d_d
 
     FMEAN16     10 ..... 110110 ..... 0 0100 0000 .....    @d_d_d
+    SUBXC       10 ..... 110110 ..... 0 0100 0001 .....    @r_r_r
+    SUBXCcc     10 ..... 110110 ..... 0 0100 0011 .....    @r_r_r
     FCHKSM16    10 ..... 110110 ..... 0 0100 0100 .....    @d_d_d
     FALIGNDATAg 10 ..... 110110 ..... 0 0100 1000 .....    @d_d_d
     FPMERGE     10 ..... 110110 ..... 0 0100 1011 .....    @d_r_r
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 5bed23a00b..b10936a61a 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -515,6 +515,17 @@ static void gen_op_subccc(TCGv dst, TCGv src1, TCGv src2)
     gen_op_subcc_int(dst, src1, src2, gen_carry32());
 }
 
+static void gen_op_subxc(TCGv dst, TCGv src1, TCGv src2)
+{
+    tcg_gen_sub_tl(dst, src1, src2);
+    tcg_gen_sub_tl(dst, dst, cpu_cc_C);
+}
+
+static void gen_op_subxccc(TCGv dst, TCGv src1, TCGv src2)
+{
+    gen_op_subcc_int(dst, src1, src2, cpu_cc_C);
+}
+
 static void gen_op_mulscc(TCGv dst, TCGv src1, TCGv src2)
 {
     TCGv zero = tcg_constant_tl(0);
@@ -3963,6 +3974,9 @@ TRANS(ARRAY32, VIS1, do_rrr, a, gen_op_array32)
 TRANS(ADDXC, VIS3, do_rrr, a, gen_op_addxc)
 TRANS(ADDXCcc, VIS3, do_rrr, a, gen_op_addxccc)
 
+TRANS(SUBXC, VIS4, do_rrr, a, gen_op_subxc)
+TRANS(SUBXCcc, VIS4, do_rrr, a, gen_op_subxccc)
+
 TRANS(UMULXHI, VIS3, do_rrr, a, gen_op_umulxhi)
 
 static void gen_op_alignaddr(TCGv dst, TCGv s1, TCGv s2)
-- 
2.34.1


