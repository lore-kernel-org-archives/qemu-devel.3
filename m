Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DB7CC369C2
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 16:04:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8LVi-0006RW-IJ; Fri, 25 Apr 2025 12:02:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1u8LVb-0006Fo-QG
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 12:02:35 -0400
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1u8LVa-0008OO-6R
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 12:02:35 -0400
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-3081f72c271so2429226a91.0
 for <qemu-devel@nongnu.org>; Fri, 25 Apr 2025 09:02:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1745596952; x=1746201752; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DsPryffvmM4Bw35hChkmngqGVooE8Lc3dsAt//9/i5o=;
 b=QLJ+x5W+ZOaCUHWXNdUh0u2UrnUycr+19wLiJDivude4P/ughgee1HTag4Ha/YlNP/
 knz4edcvHoHMQZfKEtma1rkSjQUd0NhZcYAwJPL8hJegD5PHw1LI1hwtVRJCnt097N/F
 tgwgxkzDxI7BHSIbVcVrte3aWFxXs6uXPFUHd1D2posqOZlZyJX6Lerak7+pFOmkz1Sl
 ywAg4aubvPe9qmFdeQRoB9/TCZT4Otuz+Qij2FMe3Jbzo2UAHrzTLE3I/g4CmLj1tM4e
 4q7s7JaE6Ok5t3two7Z7Gy8emXdoMNIXq8NrlFuUW7MQVLQidvZh902tBpfeYHCPwI6L
 607Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745596952; x=1746201752;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DsPryffvmM4Bw35hChkmngqGVooE8Lc3dsAt//9/i5o=;
 b=gHKFZznJi2XpJDHLNisxdKPf4vbvcrO/wHWsKdDGbxf64fRO5dpHzwQ7mU2pHlkPqr
 oGdlA6cIRrGWj6u0gjRhItYXxQLjk0oaax43tBdUU20CGbtc2BoojGMqDTcQ8oJL2n2X
 0Ej6Cu+uf6XfG82V5jsKnEdelKmkJVieNee/csdOw5oA5DQTLNP4xnJgFbFlL2Cw/2Jo
 VL56W/fzksTuo+MU2gFGcmdpEQAKpiOiJJQF5dXDyk0LwlQjP64HiVsr6bqJypcSHlXa
 tyZOj5ti9C7CfyV/mUCt5heulvONV7UGD1ILEwBz5FCgbva9BkB/W3aY2vqYXvpY4u+i
 c9RA==
X-Gm-Message-State: AOJu0YxMy7cVf26mf7Xfquhxrivrq5UjDJqP09H5QixUpPJDoOxsmcjl
 MzhQN6MEit43/DHW75zygJUvyKjfQr30PHDw5LoIKVF1qLWSRuspxpx/T62Ks/StHe+OkIfiqBB
 h
X-Gm-Gg: ASbGncuMQlToTTeMn7F+efYh87f5p6dSqMu5zdKCgdvHpgVvyvo+jI0WF+By/c4qNIZ
 /wjyEIvb4W4ph6QCu/ks7V2AVRE52M1z9Gqpyxo8yHQc/BtuRk5eI82xbK37GkBCcE/56Mx2hz9
 HEytVa9NoLb/zKLuDWfg8SSyXiPe694HyGSN3qQcRphr/ilxDAR5JPh7N1IwPlsPqa6S0ykmxyy
 +IEkH5z41XxEw3Paxr0uuzTFIo3kDIuABbhkcuqnL69+U5ZTqH5PLCcFTCONoM3MLY1yc7QAMue
 KytfrsqtrHJzG2FxbPcG4Fs6NDr2G41gvNiSYlCrlyBNHwg5Rdk3YomhZQ4Clb++MVKo
X-Google-Smtp-Source: AGHT+IHI+dRMiZS6asuQnF1TRrkz186CT+0n10sA4QcTzuw7sgQYJmdfCzLEPXfMHqt4Zk2u75qAkA==
X-Received: by 2002:a17:90b:5249:b0:2f1:3355:4a8f with SMTP id
 98e67ed59e1d1-30a012ed05dmr161177a91.4.1745596952116; 
 Fri, 25 Apr 2025 09:02:32 -0700 (PDT)
Received: from grind.dc1.ventanamicro.com ([152.234.125.33])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-309f774e534sm1820005a91.17.2025.04.25.09.02.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Apr 2025 09:02:31 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com, ajones@ventanamicro.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v3 8/9] target/riscv: widen scounteren to target_ulong
Date: Fri, 25 Apr 2025 13:02:02 -0300
Message-ID: <20250425160203.2774835-9-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250425160203.2774835-1-dbarboza@ventanamicro.com>
References: <20250425160203.2774835-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102a;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pj1-x102a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

We want to support scounteren as a KVM CSR. The KVM UAPI defines every
CSR size as target_ulong, and our env->scounteren is fixed at 32 bits.

The other existing cases where the property size does not match the KVM
reg size happens with uint64_t properties, like 'mstatus'. When running
a 32 bit CPU we'll write a 32 bit 'sstatus' KVM reg into the 64 bit
'mstatus' field. As long as we're consistent, i.e. we're always
reading/writing the same words, this is ok.

For scounteren, a KVM guest running in a 64 bit CPU will end up writing
a 64 bit reg in a 32 bit field. This will have all sort of funny side
effects in the KVM guest that we would rather avoid.

Increase scounteren to target_ulong to allow KVM to read/write the
scounteren CSR without any surprises.

Aside from bumping the version of the RISCVCPU vmstate no other
behavioral changes are expected.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 target/riscv/cpu.h     | 9 ++++++++-
 target/riscv/machine.c | 6 +++---
 2 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index f5a60d0c52..66d4ddfcb4 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -400,7 +400,14 @@ struct CPUArchState {
      */
     bool two_stage_indirect_lookup;
 
-    uint32_t scounteren;
+    /*
+     * scounteren is supposed to be an uint32_t, as the spec
+     * says. We're using a target_ulong instead because the
+     * scounteren KVM CSR is defined as target_ulong in
+     * kvm_riscv_csr, and we want to avoid having to deal
+     * with an ulong reg being read/written in an uint32_t.
+     */
+    target_ulong scounteren;
     uint32_t mcounteren;
 
     uint32_t scountinhibit;
diff --git a/target/riscv/machine.c b/target/riscv/machine.c
index df2d5bad8d..f3477e153b 100644
--- a/target/riscv/machine.c
+++ b/target/riscv/machine.c
@@ -401,8 +401,8 @@ static const VMStateDescription vmstate_ssp = {
 
 const VMStateDescription vmstate_riscv_cpu = {
     .name = "cpu",
-    .version_id = 10,
-    .minimum_version_id = 10,
+    .version_id = 11,
+    .minimum_version_id = 11,
     .post_load = riscv_cpu_post_load,
     .fields = (const VMStateField[]) {
         VMSTATE_UINTTL_ARRAY(env.gpr, RISCVCPU, 32),
@@ -445,7 +445,7 @@ const VMStateDescription vmstate_riscv_cpu = {
         VMSTATE_UINTTL(env.mtval, RISCVCPU),
         VMSTATE_UINTTL(env.miselect, RISCVCPU),
         VMSTATE_UINTTL(env.siselect, RISCVCPU),
-        VMSTATE_UINT32(env.scounteren, RISCVCPU),
+        VMSTATE_UINTTL(env.scounteren, RISCVCPU),
         VMSTATE_UINT32(env.mcounteren, RISCVCPU),
         VMSTATE_UINT32(env.scountinhibit, RISCVCPU),
         VMSTATE_UINT32(env.mcountinhibit, RISCVCPU),
-- 
2.49.0


