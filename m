Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 520FDC67861
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Apr 2024 10:29:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rsglI-00064y-Uf; Fri, 05 Apr 2024 06:25:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rsglG-00064D-KY
 for qemu-devel@nongnu.org; Fri, 05 Apr 2024 06:25:30 -0400
Received: from mail-oo1-xc30.google.com ([2607:f8b0:4864:20::c30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rsglE-0004mf-U1
 for qemu-devel@nongnu.org; Fri, 05 Apr 2024 06:25:30 -0400
Received: by mail-oo1-xc30.google.com with SMTP id
 006d021491bc7-5a51c063f99so1082841eaf.0
 for <qemu-devel@nongnu.org>; Fri, 05 Apr 2024 03:25:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712312727; x=1712917527; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=a6JV8BkI+h/EIgitTojmjopF07wjZarQ8yr8avazSrs=;
 b=g1+66IjN+oahK8dk/uHyOIRdETq2ZR617o8JxOLo9/rorsJwxEu2V7z6Vrg8q9vCjX
 Qx73O5YJDq+DTdH3mEYuQDcS6spkeuN/Re9iBOZJrDae2dSa7fBte1Idl2/ZO2EPTbCO
 rCvb+k6uiHAB9pr7Fsr0PjB3yuCb/mogaMgFXmHpLvMekmoaLtmEFWKEchW6UrQF0sbh
 Cfy66DnJCCeqD7hvosgD61PpA9Zni2ZIILyNTBDYpd/sDjQcOsiChmqPd0QG11DqtM5j
 rgE37Aw4d2aznDorzCa7VDY8c/aBv1AdV1cONT9Tc7XH5xufc+o0x1Bnd+te91GS5qca
 29Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712312727; x=1712917527;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=a6JV8BkI+h/EIgitTojmjopF07wjZarQ8yr8avazSrs=;
 b=Dt8tklpjyvnHE29IrnXNcKhGLBlhfVrd+EGgkwn09Tg+t3Yn1s4eM9eIF+XHm2hksC
 VUxpWipg4uU0LHdMkf7y1Bof2SwdjvJzfJLjA/0HqFqqTQTdMg1Vj6bZaHw3p2akj2bg
 RltI/R38WmRETMeUdWTCd+G7KbkBTcr+BV4SyvEwzyYnJOkiLvSGxg7514tKbPzbZKMq
 uqRr5x93QTtpmJCId1ECQLSqIFnmI63hOJfo3O40Wh9dCku3O7v48YTtmc41eWtfiqv5
 cqrGyz0KlJB1T1QPV4khwpol6A55gXulSY6t3w3m2W9mbGZgejLdpBUToh281Hj6Ost7
 PG8g==
X-Gm-Message-State: AOJu0YxqjVs7B2ihgeeqOTZNrhWe3hkykLsBxbcsjHpKzdS01a8Thp1o
 SU2aBdpB75Fq0Th9epfRZO97M1/42DBQc1d9nm2w90OMyMpOXx3KkzcpaipOo+NqyMDcIUDc51r
 6
X-Google-Smtp-Source: AGHT+IH43nMJGWKtGL2k/hX9hsrLS57PGrRpLwk6sodRDLyMTntBV41lRdDJPM9q16hRJl6KhndICA==
X-Received: by 2002:a05:6358:d383:b0:183:66a7:b23e with SMTP id
 mp3-20020a056358d38300b0018366a7b23emr1142438rwb.28.1712312727628; 
 Fri, 05 Apr 2024 03:25:27 -0700 (PDT)
Received: from stoup.. (098-147-007-212.res.spectrum.com. [98.147.7.212])
 by smtp.gmail.com with ESMTPSA id
 h10-20020a63f90a000000b005e438fe702dsm1104304pgi.65.2024.04.05.03.25.26
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Apr 2024 03:25:26 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 20/32] accel/tcg: Introduce translator_fake_ld
Date: Fri,  5 Apr 2024 00:24:47 -1000
Message-Id: <20240405102459.462551-21-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240405102459.462551-1-richard.henderson@linaro.org>
References: <20240405102459.462551-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c30;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc30.google.com
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

Replace translator_fake_ldb, which required multiple calls,
with translator_fake_ld, which can take all data at once.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/translator.h    | 8 ++++----
 accel/tcg/translator.c       | 5 ++---
 target/s390x/tcg/translate.c | 8 ++++----
 3 files changed, 10 insertions(+), 11 deletions(-)

diff --git a/include/exec/translator.h b/include/exec/translator.h
index 777dee0ce2..79c2724e96 100644
--- a/include/exec/translator.h
+++ b/include/exec/translator.h
@@ -233,17 +233,17 @@ translator_ldq_swap(CPUArchState *env, DisasContextBase *db,
 }
 
 /**
- * translator_fake_ldb - fake instruction load
+ * translator_fake_ld - fake instruction load
  * @db: Disassembly context
- * @pc: program counter of instruction
- * @insn8: byte of instruction
+ * @data: bytes of instruction
+ * @len: number of bytes
  *
  * This is a special case helper used where the instruction we are
  * about to translate comes from somewhere else (e.g. being
  * re-synthesised for s390x "ex"). It ensures we update other areas of
  * the translator with details of the executed instruction.
  */
-void translator_fake_ldb(DisasContextBase *db, vaddr pc, uint8_t insn8);
+void translator_fake_ld(DisasContextBase *db, const void *data, size_t len);
 
 /**
  * translator_st
diff --git a/accel/tcg/translator.c b/accel/tcg/translator.c
index 4c1dc57890..e84d41b770 100644
--- a/accel/tcg/translator.c
+++ b/accel/tcg/translator.c
@@ -464,9 +464,8 @@ uint64_t translator_ldq(CPUArchState *env, DisasContextBase *db, vaddr pc)
     return tgt;
 }
 
-void translator_fake_ldb(DisasContextBase *db, vaddr pc, uint8_t insn8)
+void translator_fake_ld(DisasContextBase *db, const void *data, size_t len)
 {
-    assert(pc >= db->pc_first);
     db->fake_insn = true;
-    record_save(db, pc, &insn8, sizeof(insn8));
+    record_save(db, db->pc_first, data, len);
 }
diff --git a/target/s390x/tcg/translate.c b/target/s390x/tcg/translate.c
index d8c1ad042d..4d308860f3 100644
--- a/target/s390x/tcg/translate.c
+++ b/target/s390x/tcg/translate.c
@@ -6192,6 +6192,8 @@ static const DisasInsn *extract_insn(CPUS390XState *env, DisasContext *s)
     const DisasInsn *info;
 
     if (unlikely(s->ex_value)) {
+        uint64_t be_insn;
+
         /* Drop the EX data now, so that it's clear on exception paths.  */
         tcg_gen_st_i64(tcg_constant_i64(0), tcg_env,
                        offsetof(CPUS390XState, ex_value));
@@ -6201,10 +6203,8 @@ static const DisasInsn *extract_insn(CPUS390XState *env, DisasContext *s)
         ilen = s->ex_value & 0xf;
 
         /* Register insn bytes with translator so plugins work. */
-        for (int i = 0; i < ilen; i++) {
-            uint8_t byte = extract64(insn, 56 - (i * 8), 8);
-            translator_fake_ldb(&s->base, pc + i, byte);
-        }
+        be_insn = cpu_to_be64(insn);
+        translator_fake_ld(&s->base, &be_insn, ilen);
         op = insn >> 56;
     } else {
         insn = ld_code2(env, s, pc);
-- 
2.34.1


