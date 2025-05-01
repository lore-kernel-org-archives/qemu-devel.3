Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93C70C369DC
	for <qemu-devel@archiver.kernel.org>; Thu,  1 May 2025 11:44:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uASK6-0001Fh-4t; Thu, 01 May 2025 07:43:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <antonb@tenstorrent.com>)
 id 1uASK3-0001F6-LQ
 for qemu-devel@nongnu.org; Thu, 01 May 2025 07:43:23 -0400
Received: from mail-ot1-x333.google.com ([2607:f8b0:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <antonb@tenstorrent.com>)
 id 1uASK2-0003pY-0C
 for qemu-devel@nongnu.org; Thu, 01 May 2025 07:43:23 -0400
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-72c40235c34so226576a34.3
 for <qemu-devel@nongnu.org>; Thu, 01 May 2025 04:43:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=tenstorrent.com; s=google; t=1746099800; x=1746704600; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Vt0jVrSyerxshL5eCuQqtXgeeRWNi9BNM7IDf17MV90=;
 b=O6DHIf40nvjl4R0m0kbWhg1GerCRGC/qnTCNzrh1osBgSF6UuZlkHkPrTpMZF/PEC7
 cF+J9H57bTBBUMbkiIH8RzRqMPQk2Xt2avLHK5B6CKJD9iGFh5WUxl46mbqFuKb6AFPM
 TWuIqHkIBqjzQJeYCkDjLGZCJaRJvwvi7s8LehOF6l7DobDjBPhdVxaJLJoqLJRF/rhf
 AvyVV58VLJ00y9XdGJLd2yhxtXdj5wo1heXJYcFgtjzaMuKyMZWGOWcjH6vEMbFpqyzu
 QQgnaJn0/pgPM16GVaH6Lu4GNKN8bQgJFLkUN+7sh6GAggVPwedNQIPWLAasjL3eJDfv
 gedQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746099800; x=1746704600;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Vt0jVrSyerxshL5eCuQqtXgeeRWNi9BNM7IDf17MV90=;
 b=WFyJMLNrwQxzraU5++PJnUy+OmzeImJbi5j7aGq0TrDwnsfW+a4pECpY1BLd3q9uC2
 9LXHzp45lTT/JdPHhHY1YrliKcrdgcYqb7rvkoIm0gHx1288twjSlleJ4uGx7Ft2TAXA
 TFIuBqMvoJRzH3DrADSjM/TO2GSqPPWVJqHgKa2XvIPjteEiDHX/wfuKUNG/GIEAEpCA
 mIp2Ll9duqNgckAUfyR2keHXB6e7RO3FXlC9t3xK0U8Ax4L64UDJPUqWT3fwb5qfUkL7
 FV2hxJe0mlTMbQ0uD+24HlCSeTcMJOHUjYJSkA1S8rYGpfPFReduBiD1TfnugTPkLIhV
 7pQw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU97r0REDtaF6e8fWGz0Qe6Y/LE4ZaYVCB8iQ2gfoWrD+f8wBtag8v2bdycK5qqFRUwXqObqBncdpKP@nongnu.org
X-Gm-Message-State: AOJu0YwHZA+A2BZQs7hZ583y+NxjcZXWwDI1+4myQyryuGkqjjITjQcw
 +q93dv7QO4awdmbE+ZkFGPUkzvM7egFNxMkW7+csHziAtSSQQOFgN+7WUClBx04=
X-Gm-Gg: ASbGncvH9DOzkdHikDnT/1H3RjDez7UYWxqC5u53Oi3tp3Fz1saLQ0PsAh5j1ZgsvEf
 kgpLn3WitH5fs27Quivv26DVkwDe7N+nWqfyxr3GLOF8O5LSKnbsEr8FzdldedDctOksu8LXf/j
 DFhKAk8vgHaAjoD5+2V11WSb21TG0a6+FfEGhQzyV8ETl8XtoQTQuRA58IzSZpcjdy6beOzz8Sy
 2HyInSdv31TpNUXPOsdE/sxBithHRAfHZkuhXECGDV2Oru6BPbIFBD0fS3rl6Qzli8NrGSZKtLs
 efxSAFlS0W3DqopIyFZeFnLPHxPjJdPUtXcOYHgokzJ2UfhB2cdGZhGiQchCLgvePiM5nZqHEYU
 =
X-Google-Smtp-Source: AGHT+IELqpAryeCKVABW5WXiDDONm9PRkn8Yyo1JcI2yisPFUnKadySjl8th6sSglcz6avqsSLVU1A==
X-Received: by 2002:a05:6830:670f:b0:72b:a020:a2c0 with SMTP id
 46e09a7af769-731ccc8d4c7mr1580942a34.17.1746099799749; 
 Thu, 01 May 2025 04:43:19 -0700 (PDT)
Received: from ausc-rvsw-c-01-anton.tenstorrent.com ([38.104.49.66])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-731d31cb976sm62964a34.28.2025.05.01.04.43.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 May 2025 04:43:18 -0700 (PDT)
From: Anton Blanchard <antonb@tenstorrent.com>
To: qemu-riscv@nongnu.org,
	qemu-devel@nongnu.org
Cc: Anton Blanchard <antonb@tenstorrent.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Subject: [PATCH v2] target/riscv: Fix fcvt.s.bf16 NaN box checking
Date: Thu,  1 May 2025 11:42:53 +0000
Message-Id: <20250501114253.594887-1-antonb@tenstorrent.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::333;
 envelope-from=antonb@tenstorrent.com; helo=mail-ot1-x333.google.com
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

fcvt.s.bf16 uses the FP16 check_nanbox_h() which returns an FP16
quiet NaN. Add check_nanbox_bf16() which returns a BF16 quiet NaN.

Signed-off-by: Anton Blanchard <antonb@tenstorrent.com>
---
 target/riscv/fpu_helper.c |  2 +-
 target/riscv/internals.h  | 16 ++++++++++++++++
 2 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/target/riscv/fpu_helper.c b/target/riscv/fpu_helper.c
index 91b1a56d10..31c17399fc 100644
--- a/target/riscv/fpu_helper.c
+++ b/target/riscv/fpu_helper.c
@@ -756,6 +756,6 @@ uint64_t helper_fcvt_bf16_s(CPURISCVState *env, uint64_t rs1)
 
 uint64_t helper_fcvt_s_bf16(CPURISCVState *env, uint64_t rs1)
 {
-    float16 frs1 = check_nanbox_h(env, rs1);
+    float16 frs1 = check_nanbox_bf16(env, rs1);
     return nanbox_s(env, bfloat16_to_float32(frs1, &env->fp_status));
 }
diff --git a/target/riscv/internals.h b/target/riscv/internals.h
index 213aff31d8..794c81bf7c 100644
--- a/target/riscv/internals.h
+++ b/target/riscv/internals.h
@@ -142,6 +142,22 @@ static inline float16 check_nanbox_h(CPURISCVState *env, uint64_t f)
     }
 }
 
+static inline float16 check_nanbox_bf16(CPURISCVState *env, uint64_t f)
+{
+    /* Disable nanbox check when enable zfinx */
+    if (env_archcpu(env)->cfg.ext_zfinx) {
+        return (uint16_t)f;
+    }
+
+    uint64_t mask = MAKE_64BIT_MASK(16, 48);
+
+    if (likely((f & mask) == mask)) {
+        return (uint16_t)f;
+    } else {
+        return 0x7FC0u; /* default qnan */
+    }
+}
+
 #ifndef CONFIG_USER_ONLY
 /* Our implementation of SysemuCPUOps::has_work */
 bool riscv_cpu_has_work(CPUState *cs);
-- 
2.34.1


