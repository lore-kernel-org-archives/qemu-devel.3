Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05E2ECCA462
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2026 01:03:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHWLX-0000G3-Jp; Thu, 15 Oct 2026 21:02:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1xHWLT-0000Ew-II
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 21:02:51 -0400
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1xHWLR-0004C2-Q0
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 21:02:51 -0400
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-3ab41538192so4168927a91.0
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 18:02:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792112568; x=1792717368; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Sfx1HIlYACatyDIWreyR3Kawd11D1y/HMQNShWOnHhU=;
 b=rgPd7xMLV0nhhuJqpqVhfXU6zgpLDUReNy2WCG4RqTydZDHtsP61sFIABR8NTcn9RM
 Y6pVYxaU7hVpAKK0HhZEbtr7zUORfeuqxpEd9n1Ag1v3+AHi8/dwbUJDRL0MZc2YGQ+L
 6PJW57YHUuHroiKwFTwJnwvMXxMTDtLpFtLI443R/BppBxawoH3IEAcvLmy+OY3ZaGIh
 s4sGcnlNF+mk4Y28ft9Z4dAgKSiPG/S5d7d2WhUZ8U3AqDAwmogZvmiOQbi5bslOXP9l
 AfuRfXDjzN1mZ5U13WwFjV3ZE3ES/kY2qXQwBb5Vpp+Vk6F79J1sSoJ2KLjPZ1g9BxD4
 VyXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792112568; x=1792717368;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Sfx1HIlYACatyDIWreyR3Kawd11D1y/HMQNShWOnHhU=;
 b=n1+s8Olar1mNtWoZJk8Qj6sdS+0llhgS/r0nyMy2Wja+65S1dM8IeyckbVK0h7U6iq
 638SqZyaj8imbkMG2cWu4/xol/bgpG26NYiNYjRl0YOI1iGjt3WmYNi2u20xt0Gd9McS
 Uc9sfwWn+uHX8o00MvZ9uaPmfKRdIBcsR03YX4AJio8zJ94FdQV8cfkO2Bc1WYFPTXPd
 pktbSmKJL4qLbBcGBhOrBbWwA1excYVVQpme8H9A5xoGRmG3wzpN6rRvUDtHVAWN8/FM
 Ifj5/V242iVH/sPxNu7N5Xii4C2Sbb+qI4cDl0KREzp4zTe706ROu413Efuf8bcNVLSm
 l/BA==
X-Gm-Message-State: AFq9FYLe02FtHd5m6E08Mkq7FwBf5DkSnlJqHhskXJNELysFfx5YtFQJ
 QoVfOGuYXt1dtQtF0NiKeL4Tib/qiXQotF+rOg+Ys01CXNMPNOON3T770sbvBg==
X-Gm-Gg: AYBFou2+X2+vN0g4ALQ5ohFvfzOX9Imc+RqdPORaI+7tsIF7meX3UMcG0AzeBcVkSO8
 OCygifGO0xWhG5fsbhZwKLGMqV1upOafYtJBNdBF1UuoWNYtXDM7Iz4VQMfsMr2X8iVH3WrZ6QG
 gUxBs89Pi9mvIYwO7OPyuxMCKA2QROGImPVsOEV451NzV4C4vqUO3ykeG76nmXBC77kpLKxALo1
 CkEcLfBLlf2dIecMqW2zTSFChTccE/Np0nbDtCU/pmVUUjyLTf6QlxAdwKdUPLym4dZbSkmomK4
 oEI/ikb9yskXdVk0PQJBzKJ4He15LM3OE8mG9v+ssbFlsZyzj3EL69r4wmx5zf68pnPEDZQ1RXS
 vuEDVzL3RaRATeRcz8doTdADQSNSB/4/JmUEpxDcbSgJKNaPyy2eGRyz4jPFPvL3TWXizRezM+6
 Q6p/ZIjnFwVA4KL67LQQ0y65sjTz3uzVHQaxn+C64EMT0/Mk+kkaRlv3cwvA46pwghs4intT9iq
 UUI+fu7H2q7fpV1Rw==
X-Received: by 2002:a17:90b:48c5:b0:3a4:b418:94cf with SMTP id
 98e67ed59e1d1-3ab3a7366bfmr19069765a91.14.1792112568113; 
 Thu, 15 Oct 2026 18:02:48 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2e97e833f1asm2513995ad.43.2026.10.15.18.02.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2026 18:02:47 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: imaginos <imaginos32@gmail.com>, qemu-stable@nongnu.org,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL v2 01/50] target/riscv: check G-stage write permission for
 VS-stage A/D updates
Date: Fri, 16 Oct 2026 11:01:48 +1000
Message-ID: <20261016010237.1102834-2-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261016010237.1102834-1-alistair.francis@wdc.com>
References: <20261016010237.1102834-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1030;
 envelope-from=alistair23@gmail.com; helo=mail-pj1-x1030.google.com
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

From: imaginos <imaginos32@gmail.com>

During a two-stage (VS-stage + G-stage) page-table walk with hardware
A/D updating enabled (Svadu / menvcfg.ADUE), a store that reaches a
VS-stage leaf PTE whose accessed or dirty bit is clear triggers a
hardware write-back of those bits into the PTE. That write-back is an
implicit store to the PTE's guest-physical address, so it must be
permitted by G-stage.

Fix this by re-running the G-stage translation of the guest PTE's
address with store semantics. get_physical_address() then also checks
that G-stage permits the guest PTE to be written, and raises a
guest-page store fault when it does not.

Cc: qemu-stable@nongnu.org
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3426
Signed-off-by: imaginos <imaginos32@gmail.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20260705140508.17692-1-imaginos32@gmail.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/tcg/cpu_helper.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/target/riscv/tcg/cpu_helper.c b/target/riscv/tcg/cpu_helper.c
index 07d9222652..6115f65adb 100644
--- a/target/riscv/tcg/cpu_helper.c
+++ b/target/riscv/tcg/cpu_helper.c
@@ -1133,6 +1133,7 @@ static int get_physical_address(CPURISCVState *env, hwaddr *physical,
     int ptshift;
     target_ulong pte;
     hwaddr pte_addr;
+    hwaddr pte_gpa = 0;
     const hwaddr base_root = base;
     const bool be = mo_endian_env(env) == MO_BE;
     int i;
@@ -1170,6 +1171,7 @@ static int get_physical_address(CPURISCVState *env, hwaddr *physical,
             }
 
             pte_addr = vbase + idx * ptesize;
+            pte_gpa = base + idx * ptesize;
         } else {
             pte_addr = base + idx * ptesize;
         }
@@ -1424,6 +1426,28 @@ static int get_physical_address(CPURISCVState *env, hwaddr *physical,
             return TRANSLATE_FAIL;
         }
 
+        /*
+         * The implicit store that writes updated A/D bits back to a VS-stage
+         * (first-stage) PTE must itself be permitted by G-stage. Re-run the
+         * second-stage translation of the PTE's guest-physical address with
+         * store semantics. If G-stage denies write, raise G-stage store fault
+         * against the PTE address.
+         */
+        if (two_stage && first_stage) {
+            int gpa_prot;
+            hwaddr gpa_paddr;
+            int gpa_ret = get_physical_address(env, &gpa_paddr, &gpa_prot,
+                                               pte_gpa, NULL, MMU_DATA_STORE,
+                                               MMUIdx_U, false, true,
+                                               is_debug, false);
+            if (gpa_ret != TRANSLATE_SUCCESS) {
+                if (fault_pte_addr) {
+                    *fault_pte_addr = pte_gpa >> 2;
+                }
+                return TRANSLATE_G_STAGE_FAIL;
+            }
+        }
+
         pmp_ret = get_physical_address_pmp(env, &pmp_prot, pte_addr,
                                            sxlen_bytes, MMU_DATA_STORE, PRV_S);
         if (pmp_ret != TRANSLATE_SUCCESS) {
@@ -2114,6 +2138,10 @@ void riscv_cpu_do_interrupt(CPUState *cs)
                  * doing VS-stage page table walk.
                  */
                 tinst = (riscv_cpu_xlen(env) == 32) ? 0x00002000 : 0x00003000;
+
+                if (cause == RISCV_EXCP_STORE_GUEST_AMO_ACCESS_FAULT) {
+                    tinst |= 0x20;
+                }
             } else {
                 /*
                  * The "Addr. Offset" field in transformed instruction is
-- 
2.55.0


