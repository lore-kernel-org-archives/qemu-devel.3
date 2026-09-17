Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1760DC982D8
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2026 21:39:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7Jo2-0002l4-GW; Thu, 17 Sep 2026 17:38:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x7Jnz-0002hR-KH
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 17:38:07 -0400
Received: from mail-pj2-x11.google.com ([2607:f8b0:4864:39::11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x7Jnx-0007jI-S0
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 17:38:07 -0400
Received: by mail-pj2-x11.google.com with SMTP id
 d9443c01a7336-2dd88a115c1so796365ad.3
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2026 14:38:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789681084; x=1790285884; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=1p+vLFp8vFkEM1j9mtOKRmQ9sIWqerc0yLzVRTatAKo=;
 b=EpuV2CY1nLni7apLYbVAvCNfrr3EQJDyZ7nksEpZYPzJpMePdAjimRzfUdCYZEFJXa
 GH/4p2zEfIdMrgwcHhgEYyCdj6rh9u+QxYVDElhS1i9iFgQxFUN7GtdTCJcf/K6nd6DG
 JiJCTv/X5tEWaVVrB3W6Hcyzu9Ffe3Sbhc4okqRUVVrj0geMo5US1cBmMI0eT2pkGANj
 k79q4jEnugNvyA6P77Ru8IHlEMT7kZPKJRqguCmf4oFW/7yF0IxX7PqU3LFZCyWGvaWT
 FMrFX6wc/9zOYUMTrnd8h5IOBPtVtnAmnqxSBgtFHwJB8eLHRJa8Qbe7TUAZLW7SNoO+
 gQkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789681084; x=1790285884;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=1p+vLFp8vFkEM1j9mtOKRmQ9sIWqerc0yLzVRTatAKo=;
 b=YyE1UliHiKDpQ8e//FWMqWE6RR8nLylhgB7zPP/HdHwidCnaBozAsrWxN1ZQxWQ2kS
 PvnBxcGj1MVNNSA+cGPYs9rf8zOcSrgl4tCw90kvXGzCpzjbS+JHG13lKI7zdc0ZbU3i
 SwdZCH0XlAJM9jYtb25gtosG12qG3Af39BEbzr4hnVEd8FVdx8nIw2kTiZt0xqO/rk39
 yev6xJc5FQ7w+rcPuSkiA/AME4tkX9m7tvo5jazhmoxyqyBGUcfl6QTBRWFfSQUcimyD
 pHUk2OayPWL/Sqd8wKbZ0JgrGmvZ0KCRRASVmu8x1DtOtl9Dme5562skroYYg+hPAiMe
 2AUg==
X-Gm-Message-State: AFuF++n2HZUXGvWRFCe+JyvK+KS2Keqs7ztWiCNJTkKisOEQq8fn93Yy
 hsyK10GtqnItIB63uxTTfR/3yB01pay3x0LboTB2zmSKgolnTCebOtv6mCc3csi8maUGYaDpTj/
 ne3vHWgg=
X-Gm-Gg: AYBFou3cmzdQWc68Ish9mg+NaUY5john5gLKVXGa3Yfp7fjPscc7LdCI9HTggBsTbjG
 xJ2wvdRBN22H0eOMTgrHKAceNY06dF2L8NdkFr7Do3OVfrxB8tWkb2WZ0e0SVXaTW09n3sSzVoO
 dkBveymPm+KydsSYEZG8tP7YXEn6+/MvO9IF0KbQkWAjJIH6jxWq6cTcLhbStdmSlxgJiSPy2Qd
 4HyhPop6S8sU4QnDqhnd3J5dZz2MTUPAwBgR7cMYStavQQgTkGLtgb4I9gBSCbRV+2qTWZHq26n
 t9xXFaZnxGxQpLaRgtMELaW12Efn3G3/TIBY0gNeulRB2GdOn7kHdGQnY5vtzWOJXaj3ydb/uy2
 33LbwN2hkH4aTgz0vljE9cc6n/nXK3VO9lMOMgl//WA8Znrs02gBbZGwaqYbuQfAkv+fblFepBv
 xirfNpbrCvDSPRv5t9D7ztgny+uJsJ0+tZwV/LFLTHxWdmw9HQNFWbH5ac5Pqn+dwpE6sCLeKHl
 rAq/U0=
X-Received: by 2002:a17:902:d48e:b0:2dd:4070:8f5 with SMTP id
 d9443c01a7336-2ddb1b86db7mr7709965ad.21.1789681084318; 
 Thu, 17 Sep 2026 14:38:04 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:5a4b:653b:1dce:569f])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33bf56d7e5bsm18178395eec.0.2026.09.17.14.38.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 14:38:03 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Ilya Leoshkevich <iii@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PULL 10/15] target/s390x/tcg: Convert op_st32 to op_st
Date: Thu, 17 Sep 2026 11:37:44 -1000
Message-ID: <20260917213749.36756-11-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260917213749.36756-1-richard.henderson@linaro.org>
References: <20260917213749.36756-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::11;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj2-x11.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

Note that op_st32 already or'd in insn->data, with the only use
being MO_ALIGN.  We now put the entire MemOp in insn->data.

Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20260731185628.23161-11-richard.henderson@linaro.org>
---
 target/s390x/tcg/insn-data.h.inc | 12 ++++++------
 target/s390x/tcg/translate.c     |  7 -------
 2 files changed, 6 insertions(+), 13 deletions(-)

diff --git a/target/s390x/tcg/insn-data.h.inc b/target/s390x/tcg/insn-data.h.inc
index d8b42f13997..1417d32b8b6 100644
--- a/target/s390x/tcg/insn-data.h.inc
+++ b/target/s390x/tcg/insn-data.h.inc
@@ -848,15 +848,15 @@
     F(0xed15, SQDB,    RXE,   Z,   0, m2_64, new, f1, sqdb, 0, IF_BFP)
 
 /* STORE */
-    D(0x5000, ST,      RX_a,  Z,   r1_o, a2, 0, 0, st32, 0, 0)
-    D(0xe350, STY,     RXY_a, LD,  r1_o, a2, 0, 0, st32, 0, 0)
+    D(0x5000, ST,      RX_a,  Z,   r1_o, a2, 0, 0, st, 0, MO_BEUL)
+    D(0xe350, STY,     RXY_a, LD,  r1_o, a2, 0, 0, st, 0, MO_BEUL)
     D(0xe324, STG,     RXY_a, Z,   r1_o, a2, 0, 0, st64, 0, 0)
     E(0x6000, STD,     RX_a,  Z,   f1, a2, 0, 0, st64, 0, 0, IF_AFP1)
     E(0xed67, STDY,    RXY_a, LD,  f1, a2, 0, 0, st64, 0, 0, IF_AFP1)
-    E(0x7000, STE,     RX_a,  Z,   e1, a2, 0, 0, st32, 0, 0, IF_AFP1)
-    E(0xed66, STEY,    RXY_a, LD,  e1, a2, 0, 0, st32, 0, 0, IF_AFP1)
+    E(0x7000, STE,     RX_a,  Z,   e1, a2, 0, 0, st, 0, MO_BEUL, IF_AFP1)
+    E(0xed66, STEY,    RXY_a, LD,  e1, a2, 0, 0, st, 0, MO_BEUL, IF_AFP1)
 /* STORE RELATIVE LONG */
-    D(0xc40f, STRL,    RIL_b, GIE, r1_o, ri2, 0, 0, st32, 0, MO_ALIGN)
+    D(0xc40f, STRL,    RIL_b, GIE, r1_o, ri2, 0, 0, st, 0, MO_BEUL | MO_ALIGN)
     D(0xc40b, STGRL,   RIL_b, GIE, r1_o, ri2, 0, 0, st64, 0, MO_ALIGN)
 /* STORE CHARACTER */
     D(0x4200, STC,     RX_a,  Z,   r1_o, a2, 0, 0, st, 0, MO_UB)
@@ -875,7 +875,7 @@
 /* STORE HALFWORD RELATIVE LONG */
     D(0xc407, STHRL,   RIL_b, GIE, r1_o, ri2, 0, 0, st, 0, MO_BEUW)
 /* STORE HIGH */
-    D(0xe3cb, STFH,    RXY_a, HW,  r1_sr32, a2, 0, 0, st32, 0, 0)
+    D(0xe3cb, STFH,    RXY_a, HW,  r1_sr32, a2, 0, 0, st, 0, MO_BEUL)
 /* STORE ON CONDITION */
     D(0xebf3, STOC,    RSY_b, LOC, 0, 0, 0, 0, soc, 0, 0)
     D(0xebe3, STOCG,   RSY_b, LOC, 0, 0, 0, 0, soc, 0, 1)
diff --git a/target/s390x/tcg/translate.c b/target/s390x/tcg/translate.c
index 1132a1a4251..a2566abc64a 100644
--- a/target/s390x/tcg/translate.c
+++ b/target/s390x/tcg/translate.c
@@ -4350,13 +4350,6 @@ static DisasJumpType op_st(DisasContext *s, DisasOps *o)
     return DISAS_NEXT;
 }
 
-static DisasJumpType op_st32(DisasContext *s, DisasOps *o)
-{
-    tcg_gen_qemu_st_i64(o->in1, o->in2, get_mem_index(s),
-                        MO_BEUL | s->insn->data);
-    return DISAS_NEXT;
-}
-
 static DisasJumpType op_st64(DisasContext *s, DisasOps *o)
 {
     tcg_gen_qemu_st_i64(o->in1, o->in2, get_mem_index(s),
-- 
2.53.0


