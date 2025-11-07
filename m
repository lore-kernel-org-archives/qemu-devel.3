Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F2E7CCF9F8
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Nov 2025 10:25:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vHJdf-00005f-Hi; Fri, 07 Nov 2025 05:24:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1vHJde-00004z-Ah; Fri, 07 Nov 2025 05:24:14 -0500
Received: from mail-eastusazlp170120007.outbound.protection.outlook.com
 ([2a01:111:f403:c101::7] helo=BL0PR03CU003.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1vHJdc-00015K-8v; Fri, 07 Nov 2025 05:24:14 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kVbwN1/AWownZw2eFnXB04VKbYb88ImFGXIEz65/bEM62cL/FbOzl0Wj+8PJsWDBCwWwQvl4eFqoDlsXQkiefmhHZaPWMsqzhmpTEmzWpTxNJDtTx6UzSUm84OZUCOgeXrKApy337eW3lqZEipL+e1FNpjlDC/ptMhfy4FQSF5CXsYb7o/5+UHphbeDyVVLjq2udOIQ3ZA2OSZEv5idBVJP9ze71e2N2rogxOuKCVFQOti2cmXpqrlMvMshwJ/WkolJ18K4Bl+zPAuTqfdxN7wQ6dc4NMM3wTopDzuijrDSZ2W8M57B+vO7WZflZ3OrgGk0cGTM7ceymhjWxyWL77g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TLyg2tIbzCGed7Z28p+7QJIGBNjERlHLbng5v7CiLrA=;
 b=IINm93uSiMqz7vZv7p/aRzhwF7hz2QDsNpu1jSkzZeCdm0i4XqbzU7n8IUqqsjPhWXawTfpbtsMDPMuV/N0eCgbYyYQGXosILCx8+0QUT3Mv6EWk5IIlPg855rRQncWB2zkCGNmBhFDafbpSopSgyP9kkfBdbWxoaGnnsH1QV43WGdr0+r95VIdGaRMGMY2+BOrD3bAKbI9Rg99MYTXMyBvXsrSLQReHbaIgYem1Zp/uwK5QldG3hlCEfp38o920x8ToWaxmw4KM6G/1xIb1vuNTlS4sR47aYmGUkcc7b0bPbuoF865zlt3Sf/Zj1d98ZSLek195qXmcCWHTtmhWSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TLyg2tIbzCGed7Z28p+7QJIGBNjERlHLbng5v7CiLrA=;
 b=ojHtDS4DFC9EMvBG6e+tNptN4uiurxB461lIdPIePyUPlDU0S2yp7B//zLAD4JUw2MjKcwWsBaA2yhcAFeB0BJOrcMRuqByVIpvtkkDDEpkV1ygAslpBTd/bW5WxrzyGOaqqpf63kSFNaCX4vWMFmHFJG5fjGHfib4Ht3VCT1rU=
Received: from BN9PR03CA0756.namprd03.prod.outlook.com (2603:10b6:408:13a::11)
 by SA1PR12MB7176.namprd12.prod.outlook.com (2603:10b6:806:2bd::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.12; Fri, 7 Nov
 2025 10:24:06 +0000
Received: from BN2PEPF000044A2.namprd02.prod.outlook.com
 (2603:10b6:408:13a:cafe::88) by BN9PR03CA0756.outlook.office365.com
 (2603:10b6:408:13a::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.12 via Frontend Transport; Fri,
 7 Nov 2025 10:24:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN2PEPF000044A2.mail.protection.outlook.com (10.167.243.153) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Fri, 7 Nov 2025 10:24:06 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Fri, 7 Nov
 2025 02:24:02 -0800
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 7 Nov
 2025 04:24:01 -0600
Received: from XFR-LUMICHEL-L2.xilinx.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17
 via Frontend Transport; Fri, 7 Nov 2025 02:24:00 -0800
From: Luc Michel <luc.michel@amd.com>
To: <qemu-devel@nongnu.org>, <qemu-riscv@nongnu.org>
CC: Luc Michel <luc.michel@amd.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, Liu Zhiwei
 <zhiwei_liu@linux.alibaba.com>, Francisco Iglesias
 <francisco.iglesias@amd.com>
Subject: [PATCH 4/9] target/riscv: add the RISCVCPUTimeSrcIf interface
Date: Fri, 7 Nov 2025 11:23:30 +0100
Message-ID: <20251107102340.471141-5-luc.michel@amd.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251107102340.471141-1-luc.michel@amd.com>
References: <20251107102340.471141-1-luc.michel@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: luc.michel@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A2:EE_|SA1PR12MB7176:EE_
X-MS-Office365-Filtering-Correlation-Id: b394dfc8-4bb8-4759-8f18-08de1de7c7f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?bC7RCH9dWK43LGP7BLl6W+7ziPwfIQD5xOmesv02QAx5GV3WbWmqFTM6kNsR?=
 =?us-ascii?Q?MDCd5JEZXCiXGgWhE6Pm4vJS4+mcDYFiamGKmeRILC7v41iDpa6iCbF0NKIN?=
 =?us-ascii?Q?N+sbn7C5+1lGIGHTwFO/NAg1/JObPabPUIT62qa+A8wsSva3STeJ3tbUXYxw?=
 =?us-ascii?Q?OymLfuNXX/4F44d6OWGJs0HkY2DCrm2PGBdV2cgzmHZxIK5EvxzFPRKb6OGI?=
 =?us-ascii?Q?/e+bwKG633k2krtgJ1eqHPZAEnuhHgDWujigPAKEC4SgEsmIjQ4AOHqAwEqT?=
 =?us-ascii?Q?M6MM7DdHq3aDaaziN25CsnZ2I14/7TykH4Vc1Z1q1hDsRQ6fn6b3tpNe1WMr?=
 =?us-ascii?Q?V7dxMEYpvficcNDM9hvYQ4REijEcusOBXsDzQUb+bI9pBGaD0x5nRSApjChZ?=
 =?us-ascii?Q?UCiVls7jYzEoFB9ct73jUWT4jNnBg9XBZJdrgjkfRUeb4MgsmSGu5GPnWQVT?=
 =?us-ascii?Q?vzCPz9ApxqW2z1w/QR1ICgVwniA0AdvgDbP1FT1FO6DxUSRUVLLx4JqxftDt?=
 =?us-ascii?Q?nnYklvS7SVf8txAMjlRQISwlvEBk4oJpIMwafULo7g5cRMY2n2qfzmn+EP8R?=
 =?us-ascii?Q?ERgxUN+mmN0e2ZKXCspi0Qr4nxSm/vonMyh1bgxKQwG2LE2R2udQ4rLm9Gv+?=
 =?us-ascii?Q?EC0YzJgJFs7dlClooGg2hrxw0Dg+hm8Q3gKii4aidpYoZbUdLtFsQbET1mpQ?=
 =?us-ascii?Q?fmKV9SAVDoe6by+JtHuc66/2pljGzEfwbru6rrHPP3e6L6qQuW6NUzpRzTin?=
 =?us-ascii?Q?Q18mY8tqv6wYcEXYptRRgS2bCjzEcLqE5zpqWFQtW4gK0yJqnYPCDitvAPkE?=
 =?us-ascii?Q?13hKE7OU+AxWNiRzaQiH0EzqwGGIdrJ5YZfgKLPFxc2PQX4HzCDCZ05HGHhf?=
 =?us-ascii?Q?a31L3K1NVKdzXQNzlETbK7zjIsGmyIyI+m0++YfsQ3RbxgqJ9cUmSkBKIoLc?=
 =?us-ascii?Q?KwZRwm87Gb1SjpBr8tEFsAvBBuak47gN1I8sYr7iPbfavMAIXeyJwXAoRzn2?=
 =?us-ascii?Q?xZfQNqXJJ4hptM3mO4k+mch7X5k6Ivy67Q6Tq/ZHYBcj4oXIOr2+DbWLR8pa?=
 =?us-ascii?Q?WlW9W3Sa/ndPLwiKZpbM73ZlkAyPmUVNmWypf1QA3ufWqBuILFFG7sZjnGDv?=
 =?us-ascii?Q?U7NigT13CCfKiizc2qIwLyq+393nqfHy43IbkWnd9E6b9iQiI7YwIlZVz8iT?=
 =?us-ascii?Q?qKoCJnkHvghC0m51UdTNvOuZsrUz8f52f3IMqVbC3xOenT5wHdfbuZiDPZ2E?=
 =?us-ascii?Q?+5JBnH/CX845cGw6ujcPvKIxE0uuhW4KE+8GolvIpFQ/4vbl9K0OyxVnXj9P?=
 =?us-ascii?Q?HwNfMl+BgoPYnlFao5GJi/K5ByvYcXPob8UANjs861pc4XQo3K6Q6AAoVsNQ?=
 =?us-ascii?Q?kdDaSw8j/n4DSWkDowX7q4r/nA9pDzqBEfSFR1CoXP1L0VK07DiEj6UN2/ia?=
 =?us-ascii?Q?hfbofpmLvY4NGMDkbr4AOjxSt2deAQHSWbRVyHHsTK2DPTDo2Nnc0HkEcIBR?=
 =?us-ascii?Q?ZTMhG+u8t6ZlqGHOZSRpF7wbnzjGv++KZHcg2LJWYPyKr+9OHcIq60BOqeda?=
 =?us-ascii?Q?w4A1LBVi1ZlLErpOnmU=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2025 10:24:06.2432 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b394dfc8-4bb8-4759-8f18-08de1de7c7f9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A2.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7176
Received-SPF: permerror client-ip=2a01:111:f403:c101::7;
 envelope-from=Luc.Michel@amd.com;
 helo=BL0PR03CU003.outbound.protection.outlook.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.271,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Add the RISCVCPUTimeSrcIf QOM interface to the RISC-V target. This
interface aims at replacing the existing env->rdtime_fn callback in the
RISC-V CPU env. It allows to query the current number of ticks, and the
tick frequency.

Signed-off-by: Luc Michel <luc.michel@amd.com>
---
 target/riscv/cpu-qom.h     | 34 ++++++++++++++++++++++++++++++++++
 target/riscv/time_helper.h | 16 ++++++++++++++++
 target/riscv/time_helper.c | 13 +++++++++++++
 3 files changed, 63 insertions(+)

diff --git a/target/riscv/cpu-qom.h b/target/riscv/cpu-qom.h
index 75f4e434085..e5bc23b2ef5 100644
--- a/target/riscv/cpu-qom.h
+++ b/target/riscv/cpu-qom.h
@@ -58,6 +58,40 @@
 #define TYPE_RISCV_CPU_XIANGSHAN_KMH    RISCV_CPU_TYPE_NAME("xiangshan-kunminghu")
 #define TYPE_RISCV_CPU_HOST             RISCV_CPU_TYPE_NAME("host")
 
 OBJECT_DECLARE_CPU_TYPE(RISCVCPU, RISCVCPUClass, RISCV_CPU)
 
+#define TYPE_RISCV_CPU_TIME_SRC_IF "riscv-cpu-time-src-if"
+
+typedef struct RISCVCPUTimeSrcIfClass RISCVCPUTimeSrcIfClass;
+DECLARE_CLASS_CHECKERS(RISCVCPUTimeSrcIfClass, RISCV_CPU_TIME_SRC_IF,
+                       TYPE_RISCV_CPU_TIME_SRC_IF)
+#define RISCV_CPU_TIME_SRC_IF(obj) \
+        INTERFACE_CHECK(RISCVCPUTimeSrcIf, (obj), TYPE_RISCV_CPU_TIME_SRC_IF)
+
+typedef struct RISCVCPUTimeSrcIf RISCVCPUTimeSrcIf;
+
+/**
+ * RISCVCPUTimeSrcIf interface
+ *
+ * This interface is used by CPUs implementing the sstc extension. When the CPU
+ * implements this extension, it must have a time source to implement the sstc
+ * timers. Devices implementing this interface provide a monotonic tick counter
+ * and the associated tick frequency so that the CPU code can compute timer
+ * deadlines.
+ */
+struct RISCVCPUTimeSrcIfClass {
+    InterfaceClass parent_class;
+
+    /**
+     * get_ticks: get the current value of the free running counter associated
+     * with this time source.
+     */
+    uint64_t (*get_ticks)(RISCVCPUTimeSrcIf *);
+
+    /**
+     * get_tick_freq: get the tick frequency of this time source.
+     */
+    uint32_t (*get_tick_freq)(RISCVCPUTimeSrcIf *);
+};
+
 #endif /* RISCV_CPU_QOM_H */
diff --git a/target/riscv/time_helper.h b/target/riscv/time_helper.h
index af1f634f890..b51fdd96570 100644
--- a/target/riscv/time_helper.h
+++ b/target/riscv/time_helper.h
@@ -26,6 +26,22 @@ void riscv_timer_write_timecmp(CPURISCVState *env, QEMUTimer *timer,
                                uint64_t timecmp, uint64_t delta,
                                uint32_t timer_irq);
 void riscv_timer_stce_changed(CPURISCVState *env, bool is_m_mode, bool enable);
 void riscv_timer_init(RISCVCPU *cpu);
 
+static inline uint64_t riscv_cpu_time_src_get_ticks(RISCVCPUTimeSrcIf *src)
+{
+    RISCVCPUTimeSrcIfClass *rctsc = RISCV_CPU_TIME_SRC_IF_GET_CLASS(src);
+
+    g_assert(rctsc->get_ticks != NULL);
+    return rctsc->get_ticks(src);
+}
+
+static inline uint32_t riscv_cpu_time_src_get_tick_freq(RISCVCPUTimeSrcIf *src)
+{
+    RISCVCPUTimeSrcIfClass *rctsc = RISCV_CPU_TIME_SRC_IF_GET_CLASS(src);
+
+    g_assert(rctsc->get_tick_freq != NULL);
+    return rctsc->get_tick_freq(src);
+}
+
 #endif
diff --git a/target/riscv/time_helper.c b/target/riscv/time_helper.c
index d2ec8a94166..dc0777607ab 100644
--- a/target/riscv/time_helper.c
+++ b/target/riscv/time_helper.c
@@ -198,5 +198,18 @@ void riscv_timer_init(RISCVCPU *cpu)
     env->stimecmp = 0;
 
     env->vstimer = timer_new_ns(QEMU_CLOCK_VIRTUAL, &riscv_vstimer_cb, cpu);
     env->vstimecmp = 0;
 }
+
+static const TypeInfo riscv_cpu_time_src_if_info = {
+    .name = TYPE_RISCV_CPU_TIME_SRC_IF,
+    .parent = TYPE_INTERFACE,
+    .class_size = sizeof(RISCVCPUTimeSrcIfClass),
+};
+
+static void riscv_cpu_time_src_if_register_types(void)
+{
+    type_register_static(&riscv_cpu_time_src_if_info);
+}
+
+type_init(riscv_cpu_time_src_if_register_types)
-- 
2.51.0


