Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B6EEC9832F
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2026 21:53:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xADox-0008Pu-SH; Fri, 25 Sep 2026 17:51:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xADoI-0007mz-7U
 for qemu-devel@nongnu.org; Fri, 25 Sep 2026 17:50:27 -0400
Received: from mail-pz2-x2b.google.com ([2607:f8b0:4864:3b::2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xADoE-0007o2-C1
 for qemu-devel@nongnu.org; Fri, 25 Sep 2026 17:50:23 -0400
Received: by mail-pz2-x2b.google.com with SMTP id
 d2e1a72fcca58-88098db8dcdso470456b3a.3
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2026 14:50:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790373019; x=1790977819; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=XtGPsasgp0HyndARAiz1kRlvHdn/laykPbN7JXONAq0=;
 b=ZeexUcZVqB0BX/sdEIx9oAJdWNol9KDYJ6GGXNwGQ2l2yhAWklY7dI9ZaBRWh50eE2
 U0CUpsi2uESkXDL8ySOYVYP7sNs5Uw0Ka+YQ+1vpg4YuY0VwMPHEL3KSvvDfXtb9nqNt
 3BdTALCsCjZsHf70fLIYfzrqI8vsHqoZ1nyxyul8hfhlZZP13dZQScuTrnbI2F8NVIza
 cH7TKSrJm1Q8BToJj6zwoOwCRJlOq0tqMQR5cXKzogAFA82bidAyayd07oy2zrIoAYxU
 TwZumpuy3a8LBoUfaRGZKgkzfbyZAJYXZJAz3KvIQivhx/I/OxxKf6XYVxUc5zpLjlP9
 zWCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790373019; x=1790977819;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=XtGPsasgp0HyndARAiz1kRlvHdn/laykPbN7JXONAq0=;
 b=0f0qN0ESh5VIF2WOcEH8OEl9++7spCuhnnP2HuED8s+SyyrWS5YDu1gVk0Y8I6JEjj
 HSRTCunC9hXKr0shOI2GLYHvdWV7vZbUf5XuIJPoTAXDyFneh0pIkcbLAhXKnaRuMPIU
 7DJrdH4AZFgaZ67oxDpcYliJId98h+IxwyD1zAm1cHq4+CwwuDDFTr/OxjTDgdHl/FuZ
 n7s6Lt/bNkhNLfFpqqMkkMxVetPW6etWr67oMzesCMENjHUUSX+O7nqnxm1qsv+0xSTY
 NQfJVjSUOEb9zPuoTmWM1MxRIlcMOqczTbVC6058/jVVD/MAdnW2VDJl0yDVCb0+bBEr
 3PgA==
X-Gm-Message-State: AFuF++mTZWiLhRwYYaLePeT/MS6nt4it/XA12IIMjwjmlxT+yyfktpNz
 OAGaUdqiAbbnaKjiDZTXLXsjOar10391JCYT9N6TFQqwfLTSxx8/1xx41y0X/jiwKbP5pzw3ZtT
 74j7/
X-Gm-Gg: AYBFou3+M4NtOK8Vzflg+AfqNL58Mr/h1oC+Ve3tWNOFv9j4Nu9SKDyXBrsi2u6MdDz
 H+on/PgWHYDR3zLsdBDwi0QMFWA6Z/J9oQhuY84rEJ4nCwLt5N3Yfv4gSyNt8qX98n1sg/usaTV
 bQ4yEJh1pknG0kqA0atS0zR8Fw3RDnlJbeRxpKNIEC5i2BOpRK/+V2G/kxfAwY7dXWxpxPX4+Qk
 2SMsgGanbJ5DD3r4t79n3g6bfpXArc8lyNInQq28QhcA0aG3Q0TAF6YwvUq4fAvJFw++qDjxbcA
 sRiGM9KobvH1Xs2Hw/4lbOgWNHtB0taG5z2GymOQMDCLVr8AXB8LiDeZvJmioB8iYbyPQaHYLky
 kThhRZ6lzhYkkoi11lyyuGTkvjQDVbC5/K6WAJXUN42dk2ZjLbnlmHXs/hwphspaOSorrSkL65w
 eJ+VL2h3Wjoc8lGO5fAR3pQIlwFFyqx8CwTX9P7UwNBEvFnujDA8nL/Aq7AdQ9zOIi0bALFM1oC
 B1buSuf3vbucwED1W4F149F8+LbFmRL/YaSi9vu
X-Received: by 2002:a05:6a00:b70f:b0:87c:e6aa:30ec with SMTP id
 d2e1a72fcca58-87e9dfafebamr5408839b3a.49.1790373018749; 
 Fri, 25 Sep 2026 14:50:18 -0700 (PDT)
Received: from stoup (174-21-68-150.tukw.qwest.net. [174.21.68.150])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-87fea1940ecsm1725256b3a.13.2026.09.25.14.50.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Sep 2026 14:50:18 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v2 12/14] target/arm: Split out check_il
Date: Fri, 25 Sep 2026 14:50:02 -0700
Message-ID: <20260925215004.456336-13-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260925215004.456336-1-richard.henderson@linaro.org>
References: <20260925215004.456336-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:3b::2b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pz2-x2b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
 target/arm/tcg/translate.h     |  1 +
 target/arm/tcg/translate-a64.c |  7 +------
 target/arm/tcg/translate.c     | 28 ++++++++++++++++------------
 3 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/target/arm/tcg/translate.h b/target/arm/tcg/translate.h
index f633aa265f0..7eba9b764ce 100644
--- a/target/arm/tcg/translate.h
+++ b/target/arm/tcg/translate.h
@@ -382,6 +382,7 @@ void arm_jump_cc(DisasCompare *cmp, TCGLabel *label);
 void arm_gen_test_cc(int cc, TCGLabel *label);
 MemOp pow2_align(unsigned i);
 void unallocated_encoding(DisasContext *s);
+bool check_il(DisasContext *s);
 void gen_exception_internal(int excp);
 void gen_exception_insn_el(DisasContext *s, int64_t pc_diff, int excp,
                            uint32_t syn, uint32_t target_el);
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index b3438235828..7f858654c43 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -11174,12 +11174,7 @@ static void aarch64_tr_translate_insn(DisasContextBase *dcbase, CPUState *cpu)
     s->fp_access_checked = 0;
     s->sve_access_checked = 0;
 
-    if (s->pstate_il) {
-        /*
-         * Illegal execution state. This has priority over BTI
-         * exceptions, but comes after instruction abort exceptions.
-         */
-        gen_exception_insn(s, 0, EXCP_UDEF, syn_illegalstate());
+    if (check_il(s)) {
         return;
     }
 
diff --git a/target/arm/tcg/translate.c b/target/arm/tcg/translate.c
index f32200cc47e..fbacc3b7574 100644
--- a/target/arm/tcg/translate.c
+++ b/target/arm/tcg/translate.c
@@ -1159,6 +1159,20 @@ void unallocated_encoding(DisasContext *s)
     gen_exception_insn(s, 0, EXCP_UDEF, syn_uncategorized());
 }
 
+/*
+ * These conditions have less priority than instruction abort, and thus
+ * must be checked after reading the instruction.  They have more priority
+ * than the AArch64 BTI exception.
+ */
+bool check_il(DisasContext *s)
+{
+    if (s->pstate_il) {
+        gen_exception_insn(s, 0, EXCP_UDEF, syn_illegalstate());
+        return true;
+    }
+    return false;
+}
+
 /* Force a TB lookup after an instruction that changes the CPU state.  */
 void gen_lookup_tb(DisasContext *s)
 {
@@ -6153,12 +6167,7 @@ static void disas_arm_insn(DisasContext *s, unsigned int insn)
         return;
     }
 
-    if (s->pstate_il) {
-        /*
-         * Illegal execution state. This has priority over BTI
-         * exceptions, but comes after instruction abort exceptions.
-         */
-        gen_exception_insn(s, 0, EXCP_UDEF, syn_illegalstate());
+    if (check_il(s)) {
         return;
     }
 
@@ -6728,12 +6737,7 @@ static void thumb_tr_translate_insn(DisasContextBase *dcbase, CPUState *cpu)
     dc->base.pc_next = pc;
     dc->insn = insn;
 
-    if (dc->pstate_il) {
-        /*
-         * Illegal execution state. This has priority over BTI
-         * exceptions, but comes after instruction abort exceptions.
-         */
-        gen_exception_insn(dc, 0, EXCP_UDEF, syn_illegalstate());
+    if (check_il(dc)) {
         return;
     }
 
-- 
2.53.0


