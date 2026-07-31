Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6513CC55173
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2026 18:58:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wpsQ2-0007ZZ-P4; Fri, 31 Jul 2026 14:57:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wpsPQ-0007QY-5l
 for qemu-devel@nongnu.org; Fri, 31 Jul 2026 14:56:40 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wpsPN-0002CO-Pz
 for qemu-devel@nongnu.org; Fri, 31 Jul 2026 14:56:39 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-2caced6038eso13708195ad.0
 for <qemu-devel@nongnu.org>; Fri, 31 Jul 2026 11:56:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1785524196; x=1786128996; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=DyJxoCaaCbWWUX1Kmm2EzCF75YPSwfkHcWGIyEm96So=;
 b=PDy6JZxsPb+nGVDEJqOzZXeRuSOlBBtwqb+i/5XcFvWRkMEEbg+NQMHrO51U1ikIxf
 UQA1Qzm8ZXCIEkxXS5DLEVUyposHxJ7JcxcyvlEKdAYLy76PwLoJDT2H2wKUfFs0o0Pk
 n6DU3RGgJpff+s2KVXdM5FnPef756OZQ+WgPLg62lWeSFRZO/HLabTCpq27fQpd4wSSA
 ASWhT2GgwFmjZXKh3gKNAQDZBDvNkkUZj4fu4jua6EkgqFx/TUxH9AiFTUF8TPXbWbQR
 ekKrcnaJxRWuwEULOthWu+gGmoR48QDBAKNq0y9mV1ItllP9xUpRnPR9ErLC1Bo49SnV
 9gbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785524196; x=1786128996;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=DyJxoCaaCbWWUX1Kmm2EzCF75YPSwfkHcWGIyEm96So=;
 b=l3IqrWJEgrd0efDD03mdB12nkkR/Zd3uypmS3qogNS7aO9jKB8hQ4u3vTGQiAqGZjX
 Ecq9Xj1KkytjuZ+Y40s05zy53xPfXLNOWIpx7lHU6XpkXqlo4/Bs8BC0Bk6CAkmVCMNC
 NBZL9DtgouoJTmNxPQbNbfaRLhvJ/6TLMn6T0ZckzDUqgaB8OdSPGFecC7/JkFAErb4E
 y5XdGXZUV7Cb2yGdi4BoJ2e4kLiw7SAwRyGtVCpBani48iakmGGBk7qVYl6o+useLLla
 lgRVYfwqVPnfd/N6gzZKRP3IQt508scSbnyo8F66wZ9irJ1JjH+5o22HRG2WnRf/kf12
 CW2w==
X-Gm-Message-State: AOJu0Yz51B67AjmbnzOYJCY47ZBg6Ib1EFbFXNDvOMENUmAFmuTe+e4Y
 ScUCGXVVrUtLPF0V8Zkk0/Oja70PSbGlX3Jld1aN13reGxtYwxd8UNOFT5rjeP0UNwMI18o/AP8
 fEWz8
X-Gm-Gg: AR+sD11Wai1YB7M/guXBKt1B1i/PvjbWKhUCkTOX+XGw4sz/lIt7sD7Fn3h2ajC43uI
 GaNp8b3SO/hMk1rAlRjfUM8ttPPDXWlNDUABVLKhDaqZIPOYKq4+lOja+rMmE4gWjcApG9AjQ9o
 23WJbNpkVrNwb/y+Qs2vR8hNWyHRYu96BnZ0op3PmSxqh3kTdHPJafMqQ4X+4blJ330ZZSd8/zn
 zK+n+ojfpIfg3s9uawkF+SDhtccVD769bVsqK/8e5OwW4hg+RVHt0AZu6V3nNnHfEYy4lULAeAn
 EizZflwfE5v0wAZODItHWASfQdPMcJ+xaxGx0Vla7cjPhDU0Rn15iq9UTYW/g4bAafDzOYUcQbA
 tm+8uhfMSNk91Dzw9Pxaq7cfih/xHqTCbgxKYtCvT9sBUjvC9+CKBLkZ36HXHD+HxNX3cgHGDR9
 HGyU+s9Oa7vqC084FkHT10k/hqd09E0MRfNTAKnz4Sj+4F+In1Zczf2mSZdKvN56g2KwfVNQXyj
 Y9hiD/HO5OGO9e9J6EcPVJO+4GzoHI=
X-Received: by 2002:a17:902:ce10:b0:2cf:8aa7:7810 with SMTP id
 d9443c01a7336-2d053552df1mr6697805ad.2.1785524195874; 
 Fri, 31 Jul 2026 11:56:35 -0700 (PDT)
Received: from stoup.. (174-21-93-59.tukw.qwest.net. [174.21.93.59])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2d04ae193fasm9356625ad.7.2026.07.31.11.56.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Jul 2026 11:56:35 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org,
	philmd@oss.qualcomm.com
Subject: [PATCH 07/14] target/s390x: Convert op_ld64 to op_ld
Date: Fri, 31 Jul 2026 11:56:20 -0700
Message-ID: <20260731185628.23161-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260731185628.23161-1-richard.henderson@linaro.org>
References: <20260731185628.23161-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62e.google.com
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
 target/s390x/tcg/translate.c     | 7 -------
 target/s390x/tcg/insn-data.h.inc | 6 +++---
 2 files changed, 3 insertions(+), 10 deletions(-)

diff --git a/target/s390x/tcg/translate.c b/target/s390x/tcg/translate.c
index 4f1e8db780..34ee2d6087 100644
--- a/target/s390x/tcg/translate.c
+++ b/target/s390x/tcg/translate.c
@@ -2755,13 +2755,6 @@ static DisasJumpType op_ld(DisasContext *s, DisasOps *o)
     return DISAS_NEXT;
 }
 
-static DisasJumpType op_ld64(DisasContext *s, DisasOps *o)
-{
-    tcg_gen_qemu_ld_i64(o->out, o->in2, get_mem_index(s),
-                        MO_BEUQ | s->insn->data);
-    return DISAS_NEXT;
-}
-
 static DisasJumpType op_lat(DisasContext *s, DisasOps *o)
 {
     TCGLabel *lab = gen_new_label();
diff --git a/target/s390x/tcg/insn-data.h.inc b/target/s390x/tcg/insn-data.h.inc
index 00c8994345..f72607e389 100644
--- a/target/s390x/tcg/insn-data.h.inc
+++ b/target/s390x/tcg/insn-data.h.inc
@@ -422,7 +422,7 @@
     D(0xe358, LY,      RXY_a, LD,  0, a2, new, r1_32, ld, 0, MO_BESL)
     C(0xb904, LGR,     RRE,   Z,   0, r2_o, 0, r1, mov2, 0)
     C(0xb914, LGFR,    RRE,   Z,   0, r2_32s, 0, r1, mov2, 0)
-    D(0xe304, LG,      RXY_a, Z,   0, a2, r1, 0, ld64, 0, 0)
+    D(0xe304, LG,      RXY_a, Z,   0, a2, r1, 0, ld, 0, MO_BEUQ)
     D(0xe314, LGF,     RXY_a, Z,   0, a2, r1, 0, ld, 0, MO_BESL)
     F(0x2800, LDR,     RR_a,  Z,   0, f2, 0, f1, mov2, 0, IF_AFP1 | IF_AFP2)
     F(0x6800, LD,      RX_a,  Z,   0, m2_64, 0, f1, mov2, 0, IF_AFP1)
@@ -435,7 +435,7 @@
     C(0xc001, LGFI,    RIL_a, EI,  0, i2, 0, r1, mov2, 0)
 /* LOAD RELATIVE LONG */
     D(0xc40d, LRL,     RIL_b, GIE, 0, ri2, new, r1_32, ld, 0, MO_BESL | MO_ALIGN)
-    D(0xc408, LGRL,    RIL_b, GIE, 0, ri2, r1, 0, ld64, 0, MO_ALIGN)
+    D(0xc408, LGRL,    RIL_b, GIE, 0, ri2, r1, 0, ld, 0, MO_BEUQ | MO_ALIGN)
     D(0xc40c, LGFRL,   RIL_b, GIE, 0, ri2, r1, 0, ld, 0, MO_BESL | MO_ALIGN)
 /* LOAD ADDRESS */
     C(0x4100, LA,      RX_a,  Z,   0, a2, 0, r1, mov2, 0)
@@ -465,7 +465,7 @@
     C(0xb902, LTGR,    RRE,   Z,   0, r2_o, 0, r1, mov2, s64)
     C(0xb912, LTGFR,   RRE,   Z,   0, r2_32s, 0, r1, mov2, s64)
     D(0xe312, LT,      RXY_a, EI,  0, a2, new, r1_32, ld, s64, MO_BESL)
-    D(0xe302, LTG,     RXY_a, EI,  0, a2, r1, 0, ld64, s64, 0)
+    D(0xe302, LTG,     RXY_a, EI,  0, a2, r1, 0, ld, s64, MO_BEUQ)
     D(0xe332, LTGF,    RXY_a, GIE, 0, a2, r1, 0, ld, s64, MO_BESL)
     F(0xb302, LTEBR,   RRE,   Z,   0, e2, 0, cond_e1e2, mov2, f32, IF_BFP)
     F(0xb312, LTDBR,   RRE,   Z,   0, f2, 0, f1, mov2, f64, IF_BFP)
-- 
2.43.0


