Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8123CCF2C1
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2026 14:54:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xI5mp-0004sa-7i; Sat, 17 Oct 2026 10:53:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wang.yechao255@zte.com.cn>)
 id 1xI5mb-0004qp-Eo; Sat, 17 Oct 2026 10:53:13 -0400
Received: from mxhk.zte.com.cn ([160.30.148.35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wang.yechao255@zte.com.cn>)
 id 1xI5mX-0006gR-4q; Sat, 17 Oct 2026 10:53:13 -0400
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mxhk.zte.com.cn (FangMail) with ESMTPS id 4j6Ptj63XRz8Xrnw;
 Sat, 17 Oct 2026 22:53:01 +0800 (CST)
Received: from szxlzmapp03.zte.com.cn ([10.5.231.207])
 by mse-fl1.zte.com.cn with SMTP id 69HEqsJ6051305;
 Sat, 17 Oct 2026 22:52:54 +0800 (+08)
 (envelope-from wang.yechao255@zte.com.cn)
Received: from localhost.localdomain (unknown [10.234.74.162])
 by smtp (Zmail) with SMTP; Sat, 17 Oct 2026 22:52:58 +0800
X-Zmail-TransId: 3e816ad38bc9024-fb165
X-Zmail-LocalSMTP: 1
X-ZMAIL-USEORIGINALEMLTOOUTBOUND: 1
X-Zmail-RealSender: wang.yechao255@zte.com.cn
From: Wang Yechao <wang.yechao255@zte.com.cn>
To: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>
Cc: Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org, Wang Yechao <wang.yechao255@zte.com.cn>
Subject: [PATCH 3/3] target/riscv: Add SBI STA state to vmstate
Date: Sat, 17 Oct 2026 22:51:47 +0800
Message-ID: <20261017145211.219258-4-wang.yechao255@zte.com.cn>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20261017145211.219258-1-wang.yechao255@zte.com.cn>
References: <20261017145211.219258-1-wang.yechao255@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-MAIL: mse-fl1.zte.com.cn 69HEqsJ6051305
X-TLS: YES
X-ENVELOPE-SENDER: wang.yechao255@zte.com.cn
X-SOURCE-IP: 10.5.228.132 unknown Sat, 17 Oct 2026 22:53:01 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6AD38BCD.000/4j6Ptj63XRz8Xrnw
Received-SPF: pass client-ip=160.30.148.35;
 envelope-from=wang.yechao255@zte.com.cn; helo=mxhk.zte.com.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

Save and restore the KVM SBI state as a vmstate subsection, so that
a guest using SBI STA keeps working after live migration. Only the
STA shmem address (shmem_lo and shmem_hi) is saved for now; other
SBI state can be appended to kvm_sbi_state as it is added.

Signed-off-by: Wang Yechao <wang.yechao255@zte.com.cn>
---
 target/riscv/machine.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/target/riscv/machine.c b/target/riscv/machine.c
index 0de06e9588..b8cdca79cc 100644
--- a/target/riscv/machine.c
+++ b/target/riscv/machine.c
@@ -318,6 +318,23 @@ static const VMStateDescription vmstate_kvm_mp_state = {
         VMSTATE_END_OF_LIST()
     }
 };
+
+static bool kvm_sbi_state_needed(void *opaque)
+{
+    return kvm_enabled();
+}
+
+static const VMStateDescription vmstate_kvm_sbi_state = {
+    .name = "cpu/kvm-sbi-state",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .needed = kvm_sbi_state_needed,
+    .fields = (const VMStateField[]) {
+        VMSTATE_UINT64(env.kvm_sbi_sta.shmem_lo, RISCVCPU),
+        VMSTATE_UINT64(env.kvm_sbi_sta.shmem_hi, RISCVCPU),
+        VMSTATE_END_OF_LIST()
+    }
+};
 #endif
 
 static bool debug_needed(void *opaque)
@@ -645,6 +662,7 @@ const VMStateDescription vmstate_riscv_cpu = {
         &vmstate_kvm_timer_frequency,
         &vmstate_kvmtimer,
         &vmstate_kvm_mp_state,
+        &vmstate_kvm_sbi_state,
 #endif
         &vmstate_envcfg,
         &vmstate_debug,
-- 
2.27.0


