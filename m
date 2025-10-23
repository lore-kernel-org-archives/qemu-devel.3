Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FFDFCCD193
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 23:54:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vC58N-00058A-9t; Thu, 23 Oct 2025 19:54:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1vC58K-00057M-SE
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 19:54:16 -0400
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1vC58J-00081v-3w
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 19:54:16 -0400
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-33bb1701ca5so1402052a91.3
 for <qemu-devel@nongnu.org>; Thu, 23 Oct 2025 16:54:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1761263653; x=1761868453; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=350XNCdecgPAX+wmyPNQHhgr60+8VzYIB+50MP3LTE4=;
 b=HwAvePVnufwHRyYVEiZFew/ruNLEci5VCa2G4Kc2kiHckaaNUlWOtmMoxJZqUexE2d
 Lh5qTG6l/ptudK/EioWz4e95NGaIQNfRoxoYIGYZc6a6YUcRB4J1DbD5QI2bBBGgLBtE
 KEy1zC7varYEibVZ+AJ35JgMwMr1aE9oiw6NFIUrSZ7y26CPMMz2RN0/I+B+E8zhL2lj
 5rMLx9gDc8Rr3Ty6fHuuc3s9x62ggITLJslwzgui9Q1hp2Gbezy4dvdXmPZc8eEuQChM
 3awKNOGjdeHc8cmRpBFaWfohR2nIo7kCwffboyRyweUNWT+JMxKLs+jJQbKmldQLFXsR
 HLoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761263653; x=1761868453;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=350XNCdecgPAX+wmyPNQHhgr60+8VzYIB+50MP3LTE4=;
 b=FxyAsXswJjFJpuhZXM5yKvYREdTuXLYtWOtmNCVg7hOUTdIwimGLp7uh+Mi29pbHt4
 gtCkIxyCRhNrXUYORMVKToZhVH1hjgLJH9cqOpQ9ylF/qVkmfCv5eVMJCBzF8MmYMtxy
 sNdSHRA/5tmEqRpjReA2chiTZIT2W6dlK50wFR6I2+zBPyK40+UBH8uqy10YAa3NX+xk
 m+QzIEYPAT3qTDeNFG0nBKBhQ6EO7Q0VfMnNd3xfe20vO8YQFA87N+GcOaP5L/C/AuFr
 95Zc/UsIkzuiP/rLtziLl34zJ2Les/57RDMsisurOWyi3CKyLUCdK0QOJQzgsk21mcgV
 uR7w==
X-Gm-Message-State: AOJu0YyXs0m0MpCHi92V94YXRcKdLOPBN+CvqXOr0EyN9YMnhL1tpq5+
 DquvVXumLPoBDr1qobxdDrST0v8RJR3dcifp257wft/dbby8rSTEuwYKsjwvvg==
X-Gm-Gg: ASbGncs2tfweIcEMzojuOlXfTx7EVSLvHcTlnY90Qp8BFrgxGBf1MgYxrLGm5W3Qg1+
 kZJAzCBObw1cEB9MiFMsnuatvwOE9WRpvM/HpZPjWX0oxJVCFqA8uS1MDch0cgmQQ/3EB9QXfHO
 Kto68sdmLLQkgjXhe3/9BWDo0ZNsBrM6yUPWlnV0cMwb67aKhVuMbDo85JBBGY9TrsEKhIpYIT+
 JpQQsiZ/CvXAoA1YMfqIvBkkAqpHA9t9MPZCT/rmv9IN+6wJNn4RgY5iENfeym8h4FXcDvTiHm3
 KLfw6UCLNKDwk0l2knlhSMa87YfRk93BVjbfSwQ1zXJG2+2sybt9IM4Aj4bCn58gDaxlOb0sswm
 GXiWXx6D59Q5odOUKH7rk8BLZ20Qn4BhfBKz1JHhOXZAv9OeygVZrGJesWJYogwGbHFkmuafRdY
 1xhI6byxmb05CNVc/4lIYi5Sw9uvuZX3aRpe4+8R28Y+ADI3D7FVD8nKqHPx/ElAscAEfQEC/oK
 6VNIh8taegZI4r8QBM=
X-Google-Smtp-Source: AGHT+IEPB0dHGxsr6y4MgxcPC859m1dM3BPJ7kxgGA2aqYaG3l3Z8b8x2BdJvp/fwC0L+1u9s5nnww==
X-Received: by 2002:a17:903:244b:b0:290:9a31:26da with SMTP id
 d9443c01a7336-290c9d31109mr330503575ad.16.1761263652976; 
 Thu, 23 Oct 2025 16:54:12 -0700 (PDT)
Received: from toolbx.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2946dda7949sm36542295ad.3.2025.10.23.16.54.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Oct 2025 16:54:12 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>, qemu-stable@nongnu.org
Subject: [PULL v2 22/25] target/riscv: fix riscv_cpu_sirq_pending() mask
Date: Fri, 24 Oct 2025 09:54:02 +1000
Message-ID: <20251023235405.1865337-1-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102f;
 envelope-from=alistair23@gmail.com; helo=mail-pj1-x102f.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

We're filtering out (MIP_VSSIP | MIP_VSTIP | MIP_VSEIP) from S-mode
pending interrupts without apparent reason. There's no special treatment
for these ints as far as the spec goes, and this filtering is causing
read_stopi() to miss those VS interrupts [1].

We shouldn't return delegated VS interrupts in S-mode though, so change
the current mask with "~env->hideleg". Note that this is the same
handling we're doing in riscv_cpu_mirq_pending() and env->mideleg.

[1] https://gitlab.com/qemu-project/qemu/-/issues/2820

Closes: https://gitlab.com/qemu-project/qemu/-/issues/2820
Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20251022124340.493358-1-dbarboza@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Cc: qemu-stable@nongnu.org
---
 target/riscv/cpu_helper.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index 3479a62cc7..360db133e2 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -443,8 +443,7 @@ int riscv_cpu_mirq_pending(CPURISCVState *env)
 
 int riscv_cpu_sirq_pending(CPURISCVState *env)
 {
-    uint64_t irqs = riscv_cpu_all_pending(env) & env->mideleg &
-                    ~(MIP_VSSIP | MIP_VSTIP | MIP_VSEIP);
+    uint64_t irqs = riscv_cpu_all_pending(env) & env->mideleg & ~env->hideleg;
     uint64_t irqs_f = env->mvip & env->mvien & ~env->mideleg & env->sie;
 
     return riscv_cpu_pending_to_irq(env, IRQ_S_EXT, IPRIO_DEFAULT_S,
-- 
2.51.0


