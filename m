Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB19AC982D8
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2026 21:38:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7Jo4-0002m0-NE; Thu, 17 Sep 2026 17:38:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x7Jo0-0002kQ-Tr
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 17:38:09 -0400
Received: from mail-pz2-x0e.google.com ([2607:f8b0:4864:3b::e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x7Jny-0007jo-Vh
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 17:38:08 -0400
Received: by mail-pz2-x0e.google.com with SMTP id
 41be03b00d2f7-cc1cebad4adso8964a12.1
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2026 14:38:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789681085; x=1790285885; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=XMseXzIr/NcA+HBGcuQbX7qNPGtxLk2CW7QZy5sugME=;
 b=Q47mXQ8t+t1CoBMhT0l3cgiAXm9h1Gx1vUs+Br689Uago45jWbLCowf7+Moe8sabaP
 rDlaRBGfQWt+kUDSyQM32UclsX61lgr0+AstBpKWyQo93TwXg6wqVX6uJ4/mu7F11njo
 5K9oWdo0Eb8qJg4f9c2eanjSAsTRGUh4DVbnAA9rtHnSRJbOZCeRjGQgOtvc8sh5mrUH
 8qSFsk77IXJ05zJ6q5DxNWns/5Wf3s5C+/kfWtEILBJc2dl0KVibrMEAXhfbq42rFFPT
 eC7rABMmv8RtzGI+8gGT1UapIMb+jNGDUL1iqQGsiOm6htDQf5/StkY3wxCvl2tPEGSN
 mc4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789681085; x=1790285885;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=XMseXzIr/NcA+HBGcuQbX7qNPGtxLk2CW7QZy5sugME=;
 b=DbfxY6I/BoR1B/l42ALAAinACF2WORYxk3UDNsZpQ1+OzmGfQ2jjB74h/RzK+/MxEV
 8+eWQMAk6b9jKsDE5tLPFPuroMzRwRVK81W5N4hJnVZvGu+Lzu+K+HdKf47Dym40wPOl
 DKLyNf0VJYWm2EQI7xbLBMX0zigwNSvZFwWOgZn2T10tjeFHgwPvxy8FC+tKx55xgNlA
 hBFuqrxo/Ap5SueCvcP3eG/OkaB6U3Q/cNAhjvuGu6Aquh2r13vLQG27Ev794BWNIHg9
 zl51Ik7izAMBzn0h9T4VOuPYoBgh2SGVDK9D3ka12xB4jE3vSB4TfOULDtvLMVYZTpVJ
 uHhw==
X-Gm-Message-State: AFuF++mnwFtqsPt3mtoPCHARysYWacXiDXDX35828a9GNgOX1rE3v98y
 A2d+b+K63+NtpNn1aXIluVkGPdZfy1BJ9m3gwf32/UTQkICnUoy6vWvb4gM6cD4gDmNQZwLsk2G
 cUpnBoqk=
X-Gm-Gg: AYBFou0do+UzdQnQca5P/vvwcQzNkXZpQG6/XONFPBA2syrumsygt2XtUydkyHJZn0I
 aV1P+lxiubJA0Rmy9abaIqmjQAJa0EdY3YZ185Gn2r8MSR81UsZad91nFWTdiBRsoeDJ0FSBmsm
 I8z2+XlG6Qcg2iQbWQB6Bo2nvrl8o25Bfb1ZNyj1I6ltiH4Id8gQMeaAFa/YanNTeMJqVt0ofdN
 MlNLb6wSCgJnNJUucAY9ycJRbxYhsoGv/mtnpKl+RqDCAPidleolpw/bOuTFufMNS+GFO2acJzB
 8EPGAknqHD7ayardeD48E7lHtkCtoVOWxOiee/ZWdKWfwFstN/cW6Rkv7sjfSfKQBOCG5JUB7+/
 G2PbE3TMZnNG28BUrTOFM/2G0uC1yZ/jborjUdeX+FqtPItEIr6Es29yeS96sE8M46Su3bAGAai
 4xrBamCJeTiPRgJqEZ+3qemEg0dFZuS5xeL7H+vX3Ej0W+SmNBPX76nBWqqMYQ4o/CdFIJf19g+
 pbrrU0=
X-Received: by 2002:a05:6a20:7d9f:b0:3dd:85a8:4c5d with SMTP id
 adf61e73a8af0-3dd8c594d06mr513405637.36.1789681085444; 
 Thu, 17 Sep 2026 14:38:05 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:5a4b:653b:1dce:569f])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33bf56d7e5bsm18178395eec.0.2026.09.17.14.38.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 14:38:05 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PULL 11/15] target/s390x/tcg: Convert op_st64 to op_st
Date: Thu, 17 Sep 2026 11:37:45 -1000
Message-ID: <20260917213749.36756-12-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260917213749.36756-1-richard.henderson@linaro.org>
References: <20260917213749.36756-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:3b::e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pz2-x0e.google.com
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20260731185628.23161-12-richard.henderson@linaro.org>
---
 target/s390x/tcg/insn-data.h.inc | 8 ++++----
 target/s390x/tcg/translate.c     | 7 -------
 2 files changed, 4 insertions(+), 11 deletions(-)

diff --git a/target/s390x/tcg/insn-data.h.inc b/target/s390x/tcg/insn-data.h.inc
index 1417d32b8b6..c79867d4097 100644
--- a/target/s390x/tcg/insn-data.h.inc
+++ b/target/s390x/tcg/insn-data.h.inc
@@ -850,14 +850,14 @@
 /* STORE */
     D(0x5000, ST,      RX_a,  Z,   r1_o, a2, 0, 0, st, 0, MO_BEUL)
     D(0xe350, STY,     RXY_a, LD,  r1_o, a2, 0, 0, st, 0, MO_BEUL)
-    D(0xe324, STG,     RXY_a, Z,   r1_o, a2, 0, 0, st64, 0, 0)
-    E(0x6000, STD,     RX_a,  Z,   f1, a2, 0, 0, st64, 0, 0, IF_AFP1)
-    E(0xed67, STDY,    RXY_a, LD,  f1, a2, 0, 0, st64, 0, 0, IF_AFP1)
+    D(0xe324, STG,     RXY_a, Z,   r1_o, a2, 0, 0, st, 0, MO_BEUQ)
+    E(0x6000, STD,     RX_a,  Z,   f1, a2, 0, 0, st, 0, MO_BEUQ, IF_AFP1)
+    E(0xed67, STDY,    RXY_a, LD,  f1, a2, 0, 0, st, 0, MO_BEUQ, IF_AFP1)
     E(0x7000, STE,     RX_a,  Z,   e1, a2, 0, 0, st, 0, MO_BEUL, IF_AFP1)
     E(0xed66, STEY,    RXY_a, LD,  e1, a2, 0, 0, st, 0, MO_BEUL, IF_AFP1)
 /* STORE RELATIVE LONG */
     D(0xc40f, STRL,    RIL_b, GIE, r1_o, ri2, 0, 0, st, 0, MO_BEUL | MO_ALIGN)
-    D(0xc40b, STGRL,   RIL_b, GIE, r1_o, ri2, 0, 0, st64, 0, MO_ALIGN)
+    D(0xc40b, STGRL,   RIL_b, GIE, r1_o, ri2, 0, 0, st, 0, MO_BEUQ | MO_ALIGN)
 /* STORE CHARACTER */
     D(0x4200, STC,     RX_a,  Z,   r1_o, a2, 0, 0, st, 0, MO_UB)
     D(0xe372, STCY,    RXY_a, LD,  r1_o, a2, 0, 0, st, 0, MO_UB)
diff --git a/target/s390x/tcg/translate.c b/target/s390x/tcg/translate.c
index a2566abc64a..206330000dd 100644
--- a/target/s390x/tcg/translate.c
+++ b/target/s390x/tcg/translate.c
@@ -4350,13 +4350,6 @@ static DisasJumpType op_st(DisasContext *s, DisasOps *o)
     return DISAS_NEXT;
 }
 
-static DisasJumpType op_st64(DisasContext *s, DisasOps *o)
-{
-    tcg_gen_qemu_st_i64(o->in1, o->in2, get_mem_index(s),
-                        MO_BEUQ | s->insn->data);
-    return DISAS_NEXT;
-}
-
 static DisasJumpType op_stam(DisasContext *s, DisasOps *o)
 {
     TCGv_i32 r1 = tcg_constant_i32(get_field(s, r1));
-- 
2.53.0


