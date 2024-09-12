Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE80EEE644D
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2024 05:45:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1socPx-0002LV-ML; Thu, 12 Sep 2024 01:30:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1socPp-0001pq-TZ
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 01:30:52 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1socPn-00031q-Kv
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 01:30:49 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-20551e2f1f8so5922765ad.2
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2024 22:30:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726119046; x=1726723846; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uuV1qEXFWDTUGqNLxwAHmkJmRuD0mHEgZ+QMPt9fcjE=;
 b=jGfix3qU/mAbEm5lVrbjWVDJhV6Lxk/nYKxiyZKBzdT/Imh3GiVyE5hatZoaVae9gX
 ikKBsDlHElAXMItgnAmZOelWWc/7YW3qF2iPkipC+6u43x6e+6ovpJWMYAq0rnHMt7H3
 GXc9mGTE3fsovhTnFCsQi3qcqjVkZNzmYsfPGOf9QSmyHRL5McNkJc4Bz4wSiujvdRlJ
 u4QP2hEy5frD8fwluCMWw6YZsTSPruBrHNTKEcmlJU0mFMtSqA0IrSnAeBfmdUw8QmMv
 2JfJG2goCAVvJBR94EpYmgMpcAmaM95E+7lPJfk0kPVkDlYkh+e6OOSHT/RxLx0szO1N
 vOOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726119046; x=1726723846;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uuV1qEXFWDTUGqNLxwAHmkJmRuD0mHEgZ+QMPt9fcjE=;
 b=WSJ3gFSx79Fhi2kfTNQKOu3zfe6t67OMztUR7aBBXgVhz3Pb3hu65aG0v+sruSZGAb
 rXp+o9flFto9Ru5NvoNaYiuUNUZ2cqr/JS5auubeTzvnP/KDamYPdaRz0ZctPbwKbTEx
 1zgqibXpuo0v3GXt2jczxv5yZCx7iFdbTmNwG9TKF02UrArchQMLY/hJiqqGLOBbV3uc
 OtgN1IeJVtM3dYnzBj8m+cieId/r2LqPo5qvkNWwWkWwj/LwlzqV+05RnCq7Y2NnaKvp
 EbIY+qvBe+ldK1+BLQzlEe/f5GDA3ZgdNgrLTfIlTZp9iLBJ6CZjcm2x6cfZh/8oyYBO
 lt8Q==
X-Gm-Message-State: AOJu0YzGhDm0tMpao0WNc22CB+Wj6/zm9RCZ2FIRQm6Xir2V0NA7mOuX
 NBoVdX5z7iweqkAlTULhgy/fLKdycat0I6W4B94a4gMAznbefzg9eiuGJEGwfxJkAJZeWX3x3Ph
 4
X-Google-Smtp-Source: AGHT+IFS0dKDSDhVNMG12D5nLySaDwQh3X/8CcNRsnpNS8Dnmwq0pPGF4LSipjOB6KmpZ2VZPRJ6rw==
X-Received: by 2002:a17:902:d4c7:b0:205:5410:5738 with SMTP id
 d9443c01a7336-2076e3944aamr20199755ad.27.1726119045788; 
 Wed, 11 Sep 2024 22:30:45 -0700 (PDT)
Received: from stoup.. (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2076afe9e1dsm7513155ad.236.2024.09.11.22.30.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Sep 2024 22:30:45 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, Carl Hauser <chauser@pullman.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Subject: [PULL 1/5] target/sparc: Add FQ and FSR.QNE
Date: Wed, 11 Sep 2024 22:30:39 -0700
Message-ID: <20240912053043.1131626-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240912053043.1131626-1-richard.henderson@linaro.org>
References: <20240912053043.1131626-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
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
Acked-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Tested-by: Carl Hauser <chauser@pullman.com>
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


