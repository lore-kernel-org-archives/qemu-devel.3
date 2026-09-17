Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90828C982D2
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2026 21:39:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7Jo2-0002lB-QP; Thu, 17 Sep 2026 17:38:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x7Jny-0002fj-66
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 17:38:06 -0400
Received: from mail-pz2-x10.google.com ([2607:f8b0:4864:3b::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x7Jnw-0007iC-Hp
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 17:38:05 -0400
Received: by mail-pz2-x10.google.com with SMTP id
 d2e1a72fcca58-85469d249c4so108690b3a.2
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2026 14:38:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789681083; x=1790285883; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=rggtCTaQ3oM6zNhoD2jIvXYkBPLYnE0GA4gEsbT2w1Y=;
 b=eBzIeSZ9y4aAyGkZiWpAWQk3tscJ29muw4aRu7c+BraVrf5tuNW7EBLkTfWT3AYkCg
 lOqjqcnEt1MloqJ8M/UPc0jZvbpwx3Gj1Gic1L9YJ06MO4QAY8AtsAh495+Zg6N58WR+
 RZ/bQKWemfjTzmhZdIxa9SDKveuvb+tD+iM77YQQCS0S7de7N2e8DYhAe68ShXBSc212
 RyXIs9YN7OvX1Q5MrXgmQVmqjv1CkjYrUIN6neR1QRNUyr+WXoeKmT6HWe4lp1HFAHqR
 +8g4nGDx1jUYqv16AOh/3rN98muG9W0D303VviG4H4+ffbcoIz6gPw0sf8aG8z+n91ZE
 uNCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789681083; x=1790285883;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=rggtCTaQ3oM6zNhoD2jIvXYkBPLYnE0GA4gEsbT2w1Y=;
 b=McC3fhoemaai36RoGrHx5PWwlT7dc0CkyhZVDwhfiuOjOpo0e23v5UQMtEaBCcugJA
 8sGbRZtEDeyp8VZYOwOrwAfk7ZO7Wn9qnCXiKEGFzwY1FAwv4ca6hp7s6fjMGMyfjPh2
 LtuKz8/B8pejSjiQTa33L6xSE3ui1dcMR8TuJGx1E50my8fBCblzx7mvw+QLbod3x8bE
 pDpOVWpGDDldc+TABCn1Ze50mgEf5yKo/XgtQHFz6ih5Qc4HkE2byIeux7b20D6UZagR
 IcTinzXbPQJCSxiQa69p9qBW9YiJ7LjatylB1Zdt53eVpNKM1+rbMM4RbVoswFCSQMKm
 05UQ==
X-Gm-Message-State: AFuF++kQfP8YwTo3JxeESfFTGX/kNAQ983FGsz/ixAJXWW148278uOzL
 vQpeM+Dqnre//QEnU4j5JYZPaiy+HjsZWYj5oyctojRSWTKom6O9i2I5wS/V7xLWKrqT9qs8VKl
 oBiVTVLM=
X-Gm-Gg: AYBFou2dJiho1NXSrn11IV9zxh9mqN1quNYKFkCu36XL01dNJQj/aPe7Vd7+dPftmtr
 u06a8YlsHhnSyPP3SHMfOkYTE3VyrErgQ5Hnz4WbRWOHYRnlhh11NMZ9us1jCXDwxFkIp5gQnrx
 tjlxTuij3EEXICsXaRfVeNPi6xArdOgiAu5pyvwdml1t5MOklyK9LUh3ksd/yyvxogZavFZ5T4m
 6EeeE5WlZL3Hj9FoQLc13vDOvMRBkOMFlk419Hhtibqj3Wvu8HzxrIIhXH8EjmBEdM8npidd+8Y
 5fiD1utWozXKxixXrFwAR89JGHit5561XtnHrDRk167nzw42oSekxaazp2KcbZCJnRbyk6A/fM/
 izryUiHJ4vWIHd/6dNZqvQWJKEjObHqsl9r7HyL4r6ehSSYaRBUvsnSvUwIyKCID0gZVYAf/ZBj
 /6bs6sLqziM7tK2kwnXo9MrcVbXOXNeyAAkRnSGEEqtRbMJcl8EW0ltMPbDmuH5Vogjs2+dcfS3
 n0tnL9FyNbiRsjRDA==
X-Received: by 2002:a05:6a20:7d9f:b0:3d3:aec2:4dc7 with SMTP id
 adf61e73a8af0-3dd8c44e307mr662825637.19.1789681083248; 
 Thu, 17 Sep 2026 14:38:03 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:5a4b:653b:1dce:569f])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33bf56d7e5bsm18178395eec.0.2026.09.17.14.38.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 14:38:02 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Ilya Leoshkevich <iii@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PULL 09/15] target/s390x/tcg: Convert op_st16 to op_st
Date: Thu, 17 Sep 2026 11:37:43 -1000
Message-ID: <20260917213749.36756-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260917213749.36756-1-richard.henderson@linaro.org>
References: <20260917213749.36756-1-richard.henderson@linaro.org>
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

Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20260731185628.23161-10-richard.henderson@linaro.org>
---
 target/s390x/tcg/insn-data.h.inc | 8 ++++----
 target/s390x/tcg/translate.c     | 6 ------
 2 files changed, 4 insertions(+), 10 deletions(-)

diff --git a/target/s390x/tcg/insn-data.h.inc b/target/s390x/tcg/insn-data.h.inc
index fe90d61c885..d8b42f13997 100644
--- a/target/s390x/tcg/insn-data.h.inc
+++ b/target/s390x/tcg/insn-data.h.inc
@@ -868,12 +868,12 @@
     D(0xeb2d, STCMY,   RSY_b, LD,  r1_o, a2, 0, 0, stcm, 0, 0)
     D(0xeb2c, STCMH,   RSY_b, Z,   r1_o, a2, 0, 0, stcm, 0, 32)
 /* STORE HALFWORD */
-    C(0x4000, STH,     RX_a,  Z,   r1_o, a2, 0, 0, st16, 0)
-    C(0xe370, STHY,    RXY_a, LD,  r1_o, a2, 0, 0, st16, 0)
+    D(0x4000, STH,     RX_a,  Z,   r1_o, a2, 0, 0, st, 0, MO_BEUW)
+    D(0xe370, STHY,    RXY_a, LD,  r1_o, a2, 0, 0, st, 0, MO_BEUW)
 /* STORE HALFWORD HIGH */
-    C(0xe3c7, STHH,    RXY_a, HW,  r1_sr32, a2, 0, 0, st16, 0)
+    D(0xe3c7, STHH,    RXY_a, HW,  r1_sr32, a2, 0, 0, st, 0, MO_BEUW)
 /* STORE HALFWORD RELATIVE LONG */
-    C(0xc407, STHRL,   RIL_b, GIE, r1_o, ri2, 0, 0, st16, 0)
+    D(0xc407, STHRL,   RIL_b, GIE, r1_o, ri2, 0, 0, st, 0, MO_BEUW)
 /* STORE HIGH */
     D(0xe3cb, STFH,    RXY_a, HW,  r1_sr32, a2, 0, 0, st32, 0, 0)
 /* STORE ON CONDITION */
diff --git a/target/s390x/tcg/translate.c b/target/s390x/tcg/translate.c
index beb714b554b..1132a1a4251 100644
--- a/target/s390x/tcg/translate.c
+++ b/target/s390x/tcg/translate.c
@@ -4350,12 +4350,6 @@ static DisasJumpType op_st(DisasContext *s, DisasOps *o)
     return DISAS_NEXT;
 }
 
-static DisasJumpType op_st16(DisasContext *s, DisasOps *o)
-{
-    tcg_gen_qemu_st_i64(o->in1, o->in2, get_mem_index(s), MO_BEUW);
-    return DISAS_NEXT;
-}
-
 static DisasJumpType op_st32(DisasContext *s, DisasOps *o)
 {
     tcg_gen_qemu_st_i64(o->in1, o->in2, get_mem_index(s),
-- 
2.53.0


