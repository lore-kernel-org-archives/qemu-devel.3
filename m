Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 643E9ECE579
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2024 18:07:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sninI-0003is-I9; Mon, 09 Sep 2024 14:07:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sninG-0003Sa-LC
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 14:07:18 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sninE-0001wV-M1
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 14:07:18 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-717911ef035so3631499b3a.3
 for <qemu-devel@nongnu.org>; Mon, 09 Sep 2024 11:07:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725905235; x=1726510035; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9bTU4NPeU0IiujACkK1L0VqKDZix8t/nL4Zz2A2ptJA=;
 b=M17CQLGHfEit8ROPH0zp5HTW4R4S+g8AtOact8nr0aQlBooshd73njhDNxmu02PYP5
 MYPUvXLPp01tWYThOZhASAzr5ea02bAbham1Oxyf1GG3/6zC9a/ycTNEXmK7LLTLHSZn
 BSL41VK7m/5MQkNdKx3be/MezKtDsXu9lo2QDFSnCjMoheumX35lp3/6bm78JgpqiORp
 Go1WPnZuvCQG9QLREQ0LGxFDxnNCiz9soBzqkKQ2x5w68FSHFU7N30DrcQW5yU9L8QQ7
 GxKeC7BTB+BSMqpU/NysU1YSp5UW+774pV0MxJL2jJSH+lc2zgc4pgOIdwBIh5h+MtRw
 sNUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725905235; x=1726510035;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9bTU4NPeU0IiujACkK1L0VqKDZix8t/nL4Zz2A2ptJA=;
 b=i1n0r5iD7/YU6jbQizkawqaB69pzpEOh9V3xug6f3RJaYq/xaZ3tPbI7KPyJLw+06x
 mwTF9JDKOr96LzDtFo968guXlE+9ZPadWwf9rZexs0G2A8skiLuqGEEHcJ29+0/LuZ5T
 75OMTHzTevM+W4sDG10xtBQ/ZekGZC1kuEOHsr/pdadBXK1hxq0v/8F2nciiWHb4EO/O
 8oYhPKaeiGLQHsziOMfeQZ15vkalGZs1+bxFN0XRiU9aekwMTig4vVHn6BoAvMxGWFtM
 e5TmMWEZpW1m6r5oZe9I9nwr/PltCJ7oVfAHbB17nIytFCUkjy1LbTvyr1nF4pJHQM7v
 rTGQ==
X-Gm-Message-State: AOJu0YyDYWnP4+TLUe45ba6ECa5aRYpk7g3TwG9ELM/w3QwndJEboIRR
 N7a0HBMRxzZNOhRVXsuHEZ9nYuGIPhfdHarJiDtCQb8FI9MwnG4HusKPTVIW9ypCSdLfnnBedIg
 s
X-Google-Smtp-Source: AGHT+IGAvlLfeJH2JbEGSE4NK5FWHP0l1m2WbdpuBPA2zBC/k+T3mG7QfWdLxgF8GyzDmAX6o53G1g==
X-Received: by 2002:a05:6a00:928a:b0:717:9897:1405 with SMTP id
 d2e1a72fcca58-718d5ee05c1mr12851544b3a.17.1725905234878; 
 Mon, 09 Sep 2024 11:07:14 -0700 (PDT)
Received: from stoup.. (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71908fc84efsm25431b3a.8.2024.09.09.11.07.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Sep 2024 11:07:14 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk, chauser@pullman.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v4 1/5] target/sparc: Add FQ and FSR.QNE
Date: Mon,  9 Sep 2024 11:07:08 -0700
Message-ID: <20240909180712.651651-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240909180712.651651-1-richard.henderson@linaro.org>
References: <20240909180712.651651-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x429.google.com
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

From: Carl Hauser <chauser@pullman.com>

Add support for, and migrate, a single-entry fp
instruction queue for sparc32.

Signed-off-by: Carl Hauser <chauser@pullman.com>
[rth: Split from a larger patch;
      adjust representation with union;
      add migration state]
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/sparc/cpu.h        | 22 ++++++++++++++++++++++
 target/sparc/fop_helper.c |  4 ++++
 target/sparc/machine.c    | 25 +++++++++++++++++++++++++
 3 files changed, 51 insertions(+)

diff --git a/target/sparc/cpu.h b/target/sparc/cpu.h
index dfd9512a21..9f2bc44722 100644
--- a/target/sparc/cpu.h
+++ b/target/sparc/cpu.h
@@ -184,6 +184,8 @@ enum {
 #define FSR_FTT_SEQ_ERROR (4ULL << 14)
 #define FSR_FTT_INVAL_FPR (6ULL << 14)
 
+#define FSR_QNE    (1ULL << 13)
+
 #define FSR_FCC0_SHIFT    10
 #define FSR_FCC1_SHIFT    32
 #define FSR_FCC2_SHIFT    34
@@ -438,6 +440,26 @@ struct CPUArchState {
     uint32_t fsr_cexc_ftt;           /* cexc, ftt */
     uint32_t fcc[TARGET_FCCREGS];    /* fcc* */
 
+#if !defined(TARGET_SPARC64) && !defined(CONFIG_USER_ONLY)
+    /*
+     * Single-element FPU fault queue, with address and insn,
+     * packaged into the double-word with which it is stored.
+     */
+    uint32_t fsr_qne;                /* qne */
+    union {
+        uint64_t d;
+        struct {
+#if HOST_BIG_ENDIAN
+            uint32_t addr;
+            uint32_t insn;
+#else
+            uint32_t insn;
+            uint32_t addr;
+#endif
+        } s;
+    } fq;
+#endif
+
     CPU_DoubleU fpr[TARGET_DPREGS];  /* floating point registers */
     uint32_t cwp;      /* index of current register window (extracted
                           from PSR) */
diff --git a/target/sparc/fop_helper.c b/target/sparc/fop_helper.c
index 0b30665b51..b6692382b3 100644
--- a/target/sparc/fop_helper.c
+++ b/target/sparc/fop_helper.c
@@ -545,6 +545,8 @@ target_ulong cpu_get_fsr(CPUSPARCState *env)
     fsr |= (uint64_t)env->fcc[1] << FSR_FCC1_SHIFT;
     fsr |= (uint64_t)env->fcc[2] << FSR_FCC2_SHIFT;
     fsr |= (uint64_t)env->fcc[3] << FSR_FCC3_SHIFT;
+#elif !defined(CONFIG_USER_ONLY)
+    fsr |= env->fsr_qne;
 #endif
 
     /* VER is kept completely separate until re-assembly. */
@@ -591,6 +593,8 @@ void cpu_put_fsr(CPUSPARCState *env, target_ulong fsr)
     env->fcc[1] = extract64(fsr, FSR_FCC1_SHIFT, 2);
     env->fcc[2] = extract64(fsr, FSR_FCC2_SHIFT, 2);
     env->fcc[3] = extract64(fsr, FSR_FCC3_SHIFT, 2);
+#elif !defined(CONFIG_USER_ONLY)
+    env->fsr_qne = fsr & FSR_QNE;
 #endif
 
     set_fsr_nonsplit(env, fsr);
diff --git a/target/sparc/machine.c b/target/sparc/machine.c
index 48e0cf22f3..222e5709c5 100644
--- a/target/sparc/machine.c
+++ b/target/sparc/machine.c
@@ -143,6 +143,24 @@ static const VMStateInfo vmstate_xcc = {
     .get = get_xcc,
     .put = put_xcc,
 };
+#else
+static bool fq_needed(void *opaque)
+{
+    SPARCCPU *cpu = opaque;
+    return cpu->env.fsr_qne;
+}
+
+static const VMStateDescription vmstate_fq = {
+    .name = "cpu/fq",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .needed = fq_needed,
+    .fields = (const VMStateField[]) {
+        VMSTATE_UINT32(env.fq.s.addr, SPARCCPU),
+        VMSTATE_UINT32(env.fq.s.insn, SPARCCPU),
+        VMSTATE_END_OF_LIST()
+    },
+};
 #endif
 
 static int cpu_pre_save(void *opaque)
@@ -265,4 +283,11 @@ const VMStateDescription vmstate_sparc_cpu = {
 #endif
         VMSTATE_END_OF_LIST()
     },
+#ifndef TARGET_SPARC64
+    .subsections = (const VMStateDescription * const []) {
+        &vmstate_fq,
+        NULL
+    },
+#endif
+
 };
-- 
2.43.0


