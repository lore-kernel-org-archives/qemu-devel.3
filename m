Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57A49CF9C6C
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2024 06:18:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1stLLL-00052r-MF; Wed, 25 Sep 2024 02:17:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <heinrich.schuchardt@canonical.com>)
 id 1stLLI-00050X-PY; Wed, 25 Sep 2024 02:17:41 -0400
Received: from smtp-relay-canonical-0.canonical.com ([185.125.188.120])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <heinrich.schuchardt@canonical.com>)
 id 1stLLG-0006Zm-G7; Wed, 25 Sep 2024 02:17:40 -0400
Received: from LT2ubnt.. (dynamic-046-114-104-111.46.114.pool.telefonica.de
 [46.114.104.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 23A6F3F045; 
 Wed, 25 Sep 2024 06:17:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1727245052;
 bh=dR3A/zHjjfI/7spRaVCvxh3g/ioPBZB42x3FY2qEW/M=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=RZTQohsZjUcEgBq/HJNJg0MWvpSIKifCE0HwpW69X4uBw0xUJ4JFjdk1nSQiIbRmw
 ZIIYZ0Dyd3gNkR4HvWaGj7cbB8Ak5pEJAXtcA+81MkCqY2uiC2fUVpHutIvGOTOn61
 YbeZWNS52aaV7SS0LbO7c6dF85mHBffqvCsbdactOPGiJjlFZaJ2eV5e4a7pjH23DE
 oArQLAoBkZGt0arTBvzO3x16/Wb5/UwJhDfdZ4gWS9hptgQ6bA6TKGQei8VC/DngIC
 GXylmnUE4fxmUW5uTWt1xETxwFtr5NzWoIVThuDiwJjMTQJ2IM8I1P22BstuR5KB1s
 Ib6TY3sBDggkw==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>
Cc: Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Andrew Jones <ajones@ventanamicro.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org, kvm-riscv@lists.infradead.org,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH v2 1/1] target/riscv: enable floating point unit
Date: Wed, 25 Sep 2024 08:17:04 +0200
Message-ID: <20240925061704.12440-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=185.125.188.120;
 envelope-from=heinrich.schuchardt@canonical.com;
 helo=smtp-relay-canonical-0.canonical.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.09,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

The status and mstatus CSRs contain bit field FS, which control if the
floating point unit of RISC-V hart is enabled.

There seems to be no specification prescribing the value of the field when
entering S-mode from M-mode. But OpenSBI, as the leading SBI M-mode
firmware, has set a precedent by enabling the FPU by setting the value of
FS to 3 (dirty).

In TCG mode, QEMU uses OpenSBI by default. Users can reasonably expect that
software running QEMU in TCG mode and in KVM mode behaves similarly.

When QEMU in KVM mode creates a vCPU, Linux' KVM code sets FS=1 (initial)
in kvm_riscv_vcpu_fp_reset(). However, QEMU internally keeps a value of
FS=0 (off) and then synchronizes this value into KVM. Thus VS-mode software
is invoked with a disabled floating point unit.

One example of software being impacted is EDK II with TLS enabled. It
crashes when hitting the first floating point instruction while running
QEMU with --accel kvm, and runs fine with --accel tcg.

With this patch the FPU will be enabled when entering S-mode in KVM mode
and when entering M-mode in TCG mode.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
v2:
	Rewrite the commit message as suggested in the v1 thread
	https://lore.kernel.org/qemu-riscv/20240916181633.366449-1-heinrich.schuchardt@canonical.com/
---
 target/riscv/cpu.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 4bda754b01..c32e2721d4 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -923,6 +923,13 @@ static void riscv_cpu_reset_hold(Object *obj, ResetType type)
     if (mcc->parent_phases.hold) {
         mcc->parent_phases.hold(obj, type);
     }
+    if (riscv_has_ext(env, RVF) || riscv_has_ext(env, RVD)) {
+        env->mstatus = set_field(env->mstatus, MSTATUS_FS, env->misa_mxl);
+        for (int regnr = 0; regnr < 32; ++regnr) {
+            env->fpr[regnr] = 0;
+        }
+        riscv_csrrw(env, CSR_FCSR, NULL, 0, -1);
+    }
 #ifndef CONFIG_USER_ONLY
     env->misa_mxl = mcc->misa_mxl_max;
     env->priv = PRV_M;
-- 
2.45.2


