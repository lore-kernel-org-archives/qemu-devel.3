Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C85A1CCF2C4
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2026 20:36:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIB71-0001fZ-Sj; Sat, 17 Oct 2026 16:34:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xIB63-0007DQ-Gw; Sat, 17 Oct 2026 16:33:40 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xIB61-0004is-VU; Sat, 17 Oct 2026 16:33:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1792268902; bh=1QFUAT0Ks7/wzkVRF8wGIcYv/akZSw5nk46VFWm/oTk=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=H+CWwalz4sqwu018I26DT20RQceG3xGeyMPhAZxRYyfG3DSEnvlvxvphAkUuYf18G
 xQcvGQja/umYTiVT1dBIuXhxczCLXTRdDhQqHcQAMA8qCxGJRpOj47awll/72bHBcP
 DtGq8MvLz5aHJtBcnsLZAXVewx2SuGeJg70rCyeBkZYaoiJX0Crf4ZJ5PXbiRRNVau
 8NyJJ2OoKbqBAgj/7iw5o24VwH6D5P6tCkLzIHRvpSv3QkWXnnk7BIg4hxPe27bsEK
 unU6uvaEXRuYDyjFL2oJSCxPaCEaHy8MeI6izU/ruqU6selCnrx/9IFWJbUlZbRYtd
 ttc02AUX5S6BQ==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 25DAF1DE786;
 Sat, 17 Oct 2026 23:28:22 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 44310443457;
 Sat, 17 Oct 2026 23:28:21 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Xie Bo <xb@ultrarisc.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.1.3 69/73] target/riscv/kvm: Preserve VCSR across migration
Date: Sat, 17 Oct 2026 23:26:27 +0300
Message-ID: <20261017202638.728621-69-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.1.3-20261017220607@cover.tls.msk.ru>
References: <qemu-stable-11.1.3-20261017220607@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
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

From: Xie Bo <xb@ultrarisc.com>

The vector state sync handles vstart, vl and vtype, but leaves vcsr
behind.  vxrm and vxsat in the migration stream are therefore stale,
and the destination does not restore the values held by KVM.

Read vcsr when collecting vector state and split it into vxrm and
vxsat.  Rebuild it from those fields when writing vector state back.

Fixes: 3ca78c0689d5 ("target/riscv/kvm: add RVV and Vector CSR regs")
Cc: qemu-stable@nongnu.org
Signed-off-by: Xie Bo <xb@ultrarisc.com>
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Message-ID: <20260831074106.1798671-4-xb@ultrarisc.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
(cherry picked from commit f20acdba2a960689cc7adb179e96b0441cb83e25)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
index aa19c69dd3..0a27744d6b 100644
--- a/target/riscv/kvm/kvm-cpu.c
+++ b/target/riscv/kvm/kvm-cpu.c
@@ -910,6 +910,13 @@ static int kvm_riscv_get_regs_vector(CPUState *cs)
     }
     env->vtype = reg;
 
+    ret = kvm_get_one_reg(cs, RISCV_VECTOR_CSR_REG(vcsr), &reg);
+    if (ret) {
+        return ret;
+    }
+    env->vxrm = (reg & VCSR_VXRM) >> VCSR_VXRM_SHIFT;
+    env->vxsat = (reg & VCSR_VXSAT) >> VCSR_VXSAT_SHIFT;
+
     if (kvm_v_vlenb.supported) {
         ret = kvm_get_one_reg(cs, RISCV_VECTOR_CSR_REG(vlenb), &reg);
         if (ret) {
@@ -966,6 +973,13 @@ static int kvm_riscv_put_regs_vector(CPUState *cs)
         return ret;
     }
 
+    reg = (env->vxrm << VCSR_VXRM_SHIFT) |
+          (env->vxsat << VCSR_VXSAT_SHIFT);
+    ret = kvm_set_one_reg(cs, RISCV_VECTOR_CSR_REG(vcsr), &reg);
+    if (ret) {
+        return ret;
+    }
+
     if (kvm_v_vlenb.supported) {
         reg = cpu->cfg.vlenb;
         ret = kvm_set_one_reg(cs, RISCV_VECTOR_CSR_REG(vlenb), &reg);
-- 
2.47.3


