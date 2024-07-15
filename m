Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CD16C3DA5D
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2024 10:15:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTIj5-0000uC-Ka; Mon, 15 Jul 2024 06:14:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ethan84@andestech.com>)
 id 1sTIj1-0000gZ-1Q; Mon, 15 Jul 2024 06:14:31 -0400
Received: from 60-248-80-70.hinet-ip.hinet.net ([60.248.80.70]
 helo=Atcsqr.andestech.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ethan84@andestech.com>)
 id 1sTIiz-0003Ed-6Y; Mon, 15 Jul 2024 06:14:30 -0400
Received: from mail.andestech.com (ATCPCS34.andestech.com [10.0.1.134])
 by Atcsqr.andestech.com with ESMTPS id 46FAEDrV080802
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
 Mon, 15 Jul 2024 18:14:13 +0800 (+08)
 (envelope-from ethan84@andestech.com)
Received: from atcpcw16.andestech.com (10.0.1.106) by ATCPCS34.andestech.com
 (10.0.1.134) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 15 Jul
 2024 18:14:14 +0800
To: <qemu-devel@nongnu.org>
CC: <richard.henderson@linaro.org>, <pbonzini@redhat.com>, <peterx@redhat.com>,
 <david@redhat.com>, <philmd@linaro.org>, <palmer@dabbelt.com>,
 <alistair.francis@wdc.com>, <bmeng.cn@gmail.com>,
 <liwei1518@gmail.com>, <dbarboza@ventanamicro.com>,
 <zhiwei_liu@linux.alibaba.com>, <qemu-riscv@nongnu.org>, Ethan Chen
 <ethan84@andestech.com>
Subject: [PATCH v8 6/8] hw/misc/riscv_iopmp: Add API to configure RISCV CPU
 IOPMP support
Date: Mon, 15 Jul 2024 18:14:09 +0800
Message-ID: <20240715101409.1249373-1-ethan84@andestech.com>
X-Mailer: git-send-email 2.42.0.345.gaab89be2eb.dirty
In-Reply-To: <20240715095702.1222213-1-ethan84@andestech.com>
References: <20240715095702.1222213-1-ethan84@andestech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.0.1.106]
X-ClientProxiedBy: ATCPCS33.andestech.com (10.0.1.100) To
 ATCPCS34.andestech.com (10.0.1.134)
X-DNSRBL: 
X-MAIL: Atcsqr.andestech.com 46FAEDrV080802
Received-SPF: pass client-ip=60.248.80.70; envelope-from=ethan84@andestech.com;
 helo=Atcsqr.andestech.com
X-Spam_score_int: -8
X-Spam_score: -0.9
X-Spam_bar: /
X-Spam_report: (-0.9 / 5.0 requ) BAYES_00=-1.9, RDNS_DYNAMIC=0.982,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 TVD_RCVD_IP=0.001 autolearn=no autolearn_force=no
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
Reply-to:  Ethan Chen <ethan84@andestech.com>
From:  Ethan Chen via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

The iopmp_setup_cpu() function configures the RISCV CPU to support IOPMP and
specifies the CPU's RRID.

Signed-off-by: Ethan Chen <ethan84@andestech.com>
---
 hw/misc/riscv_iopmp.c         | 6 ++++++
 include/hw/misc/riscv_iopmp.h | 1 +
 2 files changed, 7 insertions(+)

diff --git a/hw/misc/riscv_iopmp.c b/hw/misc/riscv_iopmp.c
index e62ac57437..374bf5c610 100644
--- a/hw/misc/riscv_iopmp.c
+++ b/hw/misc/riscv_iopmp.c
@@ -1211,5 +1211,11 @@ void iopmp_setup_system_memory(DeviceState *dev, const MemMapEntry *memmap,
                        "iopmp-downstream-as");
 }
 
+void iopmp_setup_cpu(RISCVCPU *cpu, uint32_t rrid)
+{
+    cpu->cfg.iopmp = true;
+    cpu->cfg.iopmp_rrid = rrid;
+}
+
 
 type_init(iopmp_register_types);
diff --git a/include/hw/misc/riscv_iopmp.h b/include/hw/misc/riscv_iopmp.h
index ebe9c4bc4a..7e7da56d10 100644
--- a/include/hw/misc/riscv_iopmp.h
+++ b/include/hw/misc/riscv_iopmp.h
@@ -167,5 +167,6 @@ typedef struct IopmpState {
 
 void iopmp_setup_system_memory(DeviceState *dev, const MemMapEntry *memmap,
                                uint32_t mapentry_num);
+void iopmp_setup_cpu(RISCVCPU *cpu, uint32_t rrid);
 
 #endif
-- 
2.34.1


