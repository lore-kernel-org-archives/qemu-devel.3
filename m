Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80976CCFA1C
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Nov 2025 10:25:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vHJdd-0008WS-Fo; Fri, 07 Nov 2025 05:24:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1vHJdb-0008VM-73; Fri, 07 Nov 2025 05:24:11 -0500
Received: from mail-westcentralusazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c112::7] helo=CY3PR05CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1vHJdZ-0000xf-93; Fri, 07 Nov 2025 05:24:10 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x23xUOfPM80LEG+LOoHW6kkknjgJNxMZ4QxdHRuuhz0et9WGxG6DzCUXlrj4UnECXfJvmhAOCA9zAgTal4GJDwtTYVtkuee9YSBaeofYlzsdFcwQES+tQR66Javx46MrkWKkJmgXKARs7HxceY48HUfZxu/3TAwHCAiSg3zAqfWSR9QZVPWSVSr0Xr407Hw9ymdMiBGtRNSxZA86zEdMrgdmjCM4nuvnjBvflc3fjwqj5RLAYD0sbwDkZ2n8GfzbSVk5eq3inyw4Xq3V5t1Ck5c+zaSmeaWQxiLnMc4flngKuhj82tB3+TLgMkXgJq3Ygy2JKpS6Z79SsIjxqetOtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A8r1KvHxNf7vDoP9gSEE6sL6xWq523MgXK8dY0e8E+4=;
 b=Vk1FxvZtd9KnU/vomO+XMwQYRRQuWfVxvWgNsswhSHsJDpR39vRqZRPryiGfBVN0sbXL94/plxF85gVGnpWs3iQiBxm5SDQg+YXFYSgLBouvy22IpVhjAgIxCEltD/nPQBJAKoCMeKuv+xwEry1FKv6NG7E/U0X7+B9ypG/7wRiSfWMcYDoAibWHpmBUlMqnXd+yC/uC0pxKgHaxZq56nVSZlQdqeyxOYBWlsB7F58jbndNr635wgj+jkERp8e2YNU7ihO2rsbPmmZ3y3bZ0VoL+ItYksT8/Bv7iDQvcfGA+qfRc/LJMsyNRKgi3p96EWon8qA46gWRZe5lu/tbzag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A8r1KvHxNf7vDoP9gSEE6sL6xWq523MgXK8dY0e8E+4=;
 b=YhF4B83C9n8twXMoGlP9/GiLnGjynWI1GUUqw7RCJjoahsn3oaG0buUyWhB1BsGAumqk7VbYKdxk5t9FFRplPp60eCxSNzgv2GfwLCMTvtLL/khZQDCZMpdycH1mwKaJcO6KZ3uFi456P1TuXubxuqOxqxaMbRSloA4nasty0jU=
Received: from BN9P221CA0027.NAMP221.PROD.OUTLOOK.COM (2603:10b6:408:10a::21)
 by DS0PR12MB6389.namprd12.prod.outlook.com (2603:10b6:8:cf::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.13; Fri, 7 Nov 2025 10:24:01 +0000
Received: from BN2PEPF000044A4.namprd02.prod.outlook.com
 (2603:10b6:408:10a:cafe::85) by BN9P221CA0027.outlook.office365.com
 (2603:10b6:408:10a::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.12 via Frontend Transport; Fri,
 7 Nov 2025 10:24:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN2PEPF000044A4.mail.protection.outlook.com (10.167.243.155) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Fri, 7 Nov 2025 10:24:00 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Fri, 7 Nov
 2025 02:24:00 -0800
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 7 Nov
 2025 04:24:00 -0600
Received: from XFR-LUMICHEL-L2.xilinx.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17
 via Frontend Transport; Fri, 7 Nov 2025 02:23:58 -0800
From: Luc Michel <luc.michel@amd.com>
To: <qemu-devel@nongnu.org>, <qemu-riscv@nongnu.org>
CC: Luc Michel <luc.michel@amd.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, Liu Zhiwei
 <zhiwei_liu@linux.alibaba.com>, Francisco Iglesias
 <francisco.iglesias@amd.com>
Subject: [PATCH 3/9] hw/intc/riscv_aclint: rename cpu_riscv_read_rtc to
 riscv_aclint_mtimer_get_ticks
Date: Fri, 7 Nov 2025 11:23:29 +0100
Message-ID: <20251107102340.471141-4-luc.michel@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A4:EE_|DS0PR12MB6389:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a886b18-397a-4f74-f22e-08de1de7c4c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?cdeO6rQ9IxHDfDYtSH3XNcC4iU4a9EToXfZQHm1Ob5ZHIBEi9WdYnvjbwoWy?=
 =?us-ascii?Q?LCSPj90NlyA0eUVNpgxFh6xgtsCM8Dkt6WWpAzc/WY71hukQSHg5tELXWdf2?=
 =?us-ascii?Q?syz8JcIH1AidyEErDCIvcQFftDK62X/UB5F8OEZ+LgSUpEXkrHDmBvNNmnBR?=
 =?us-ascii?Q?MXqhwU1sUo1Q8U/ixas7JIq68qtejTGLX7pXFd2QZt8JEVUXRbEjAgGr9ZkK?=
 =?us-ascii?Q?IznPcuk5kJbcFzzxr4kaSsS5IOPFt90F9ecambWATZhXwRdO0A2rynH7hXYX?=
 =?us-ascii?Q?lxoJlF/0LkZ7VBpxkTiZilcPWz96rmjytqWmcNP1SWsWF0sI5nHYM9hVy+nF?=
 =?us-ascii?Q?igZSRV/IRWZqD2hoZDZJ20ExVICBNkZ+NErGxDCLUWP3wBa63pjpvrBCPFgG?=
 =?us-ascii?Q?F2ehBNyU2rV3Hf1HseVxjAOB32HvyEfEM60j/WMpGk6btdHiMqb4vVBOsQh9?=
 =?us-ascii?Q?BIjl/49vttkUuuOQ/qL9lhZ3XrZeUONTU0xLkjygbby0SpprFyQoMQkwJp7Z?=
 =?us-ascii?Q?ZKSqyJAikePEmFDbsgRfIO/XKjM2IyzLg5p4mlcSmcjBfyTKkjMycsxCMab2?=
 =?us-ascii?Q?XGoI8SteOmveDqVOd34/62SSF3ddDgX6FcobIYvMtakY9n865B/dyfpe1gx+?=
 =?us-ascii?Q?pHS+QBD2eo5BLCKfONPR9zBOv/x6uR+Lnn9saqfnJ2drg7fmlSHKr50f15x/?=
 =?us-ascii?Q?D0Br+Y80WKy8FrAdVzIiZVLUOJIW2EcsMkQPKkE1rLTVGbaq6Yq7YO+67RsW?=
 =?us-ascii?Q?cNZjj6n0xdSoBtsQ21O8yTpvX1fqpScPwvg5CnXClTiCGaesZARnNw5jYQE0?=
 =?us-ascii?Q?SSoKuq0Oh3Y0AEaK1ZafSra3GeK1VpGseSDwJ8hrbC63D2693ZbcFKWTQOQw?=
 =?us-ascii?Q?t6SJd1dUohMHrB3tV1aAYPxHBRYHc4Z+c1g5GnHGQ9J6LIiUgSwxVcE2ZQRN?=
 =?us-ascii?Q?Nmxj7+3cAfUUa/de/YgLzFCPwxZX8OqhQFb373Lscef+GqNY+hjrKk1zQ/mb?=
 =?us-ascii?Q?inucg+k6c+TmcgrX6RQ9OEPUbJr9bhiZNwYBOBuKDskbgMN9DiKVdZihFEOU?=
 =?us-ascii?Q?ryKdfLAgwrJ7Swp82BDA0NsDw7qTTMCVuQoZM32Zslbs37SKVxwbjmcpN7LT?=
 =?us-ascii?Q?2IZCsVUgczmA1HmT9yAa4aKdjxwyh9/fC2DhzDO74Iq6P87zGE6l67oBnDjf?=
 =?us-ascii?Q?xOep6UI9m5gE7JSRSprZuF6yr9Fw7m+2p7rhIEHfeGE6yuQ4ryvY0e9NCX6J?=
 =?us-ascii?Q?miYPqnUIcCnvqXQmANX7kE1S6eaRRNR95W4ZIpfTIKHkBFUpc5dwTykdudYW?=
 =?us-ascii?Q?50MT+5tXGdbvTbXkrvSPr5sR8V8Y5DHPNE9N+DxUU6pgyicrTwMN/SqrxsVa?=
 =?us-ascii?Q?JPiomFFmQaa7IUTpAXnzGEtv4ShpouttHfqfJrxQCpXuHqNi4Sp2o1WRFKaC?=
 =?us-ascii?Q?xezhsd5qtEBjEGyPaLzF2Rz1s3C22J6CgDnAvZBAPcS0epyn8aN9LgKrDRBE?=
 =?us-ascii?Q?dVfJMKkrlvC3krnKLNZLGoFA/ytUr0mVww+DGmLPUVC1sZYsCVnivh8zZGUy?=
 =?us-ascii?Q?6IY38gusK04US4QspZ4=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2025 10:24:00.8905 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a886b18-397a-4f74-f22e-08de1de7c4c8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A4.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6389
Received-SPF: permerror client-ip=2a01:111:f403:c112::7;
 envelope-from=Luc.Michel@amd.com;
 helo=CY3PR05CU001.outbound.protection.outlook.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.271,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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

For more clarity, rename the cpu_riscv_read_rtc function to
riscv_aclint_mtimer_get_ticks:
   - The ACLINT is the time source here, not the CPU,
   - This function returns a number of ticks based on the timer
     frequency.

Rename the _raw version of this function as well and the local variables
storing the result of those function.

Signed-off-by: Luc Michel <luc.michel@amd.com>
---
 hw/intc/riscv_aclint.c | 31 ++++++++++++++++---------------
 1 file changed, 16 insertions(+), 15 deletions(-)

diff --git a/hw/intc/riscv_aclint.c b/hw/intc/riscv_aclint.c
index 5f5ffc61e80..95398e48821 100644
--- a/hw/intc/riscv_aclint.c
+++ b/hw/intc/riscv_aclint.c
@@ -38,20 +38,21 @@
 typedef struct riscv_aclint_mtimer_callback {
     RISCVAclintMTimerState *s;
     int num;
 } riscv_aclint_mtimer_callback;
 
-static uint64_t cpu_riscv_read_rtc_raw(uint32_t timebase_freq)
+static uint64_t riscv_aclint_mtimer_get_ticks_raw(uint32_t timebase_freq)
 {
     return muldiv64(qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL),
         timebase_freq, NANOSECONDS_PER_SECOND);
 }
 
-static uint64_t cpu_riscv_read_rtc(void *opaque)
+static uint64_t riscv_aclint_mtimer_get_ticks(void *opaque)
 {
     RISCVAclintMTimerState *mtimer = opaque;
-    return cpu_riscv_read_rtc_raw(mtimer->timebase_freq) + mtimer->time_delta;
+    return riscv_aclint_mtimer_get_ticks_raw(mtimer->timebase_freq) +
+           mtimer->time_delta;
 }
 
 /*
  * Called when timecmp is written to update the QEMU timer or immediately
  * trigger timer interrupt if mtimecmp <= current timer value.
@@ -63,28 +64,28 @@ static void riscv_aclint_mtimer_write_timecmp(RISCVAclintMTimerState *mtimer,
 {
     uint32_t timebase_freq = mtimer->timebase_freq;
     uint64_t next;
     uint64_t diff;
 
-    uint64_t rtc = cpu_riscv_read_rtc(mtimer);
+    uint64_t ticks = riscv_aclint_mtimer_get_ticks(mtimer);
 
     /* Compute the relative hartid w.r.t the socket */
     hartid = hartid - mtimer->hartid_base;
 
     mtimer->timecmp[hartid] = value;
-    if (mtimer->timecmp[hartid] <= rtc) {
+    if (mtimer->timecmp[hartid] <= ticks) {
         /*
          * If we're setting an MTIMECMP value in the "past",
          * immediately raise the timer interrupt
          */
         qemu_irq_raise(mtimer->timer_irqs[hartid]);
         return;
     }
 
     /* otherwise, set up the future timer interrupt */
     qemu_irq_lower(mtimer->timer_irqs[hartid]);
-    diff = mtimer->timecmp[hartid] - rtc;
+    diff = mtimer->timecmp[hartid] - ticks;
     /* back to ns (note args switched in muldiv64) */
     uint64_t ns_diff = muldiv64(diff, NANOSECONDS_PER_SECOND, timebase_freq);
 
     /*
      * check if ns_diff overflowed and check if the addition would potentially
@@ -149,15 +150,15 @@ static uint64_t riscv_aclint_mtimer_read(void *opaque, hwaddr addr,
                           "aclint-mtimer: invalid read: %08x", (uint32_t)addr);
             return 0;
         }
     } else if (addr == mtimer->time_base) {
         /* time_lo for RV32/RV64 or timecmp for RV64 */
-        uint64_t rtc = cpu_riscv_read_rtc(mtimer);
-        return (size == 4) ? (rtc & 0xFFFFFFFF) : rtc;
+        uint64_t ticks = riscv_aclint_mtimer_get_ticks(mtimer);
+        return (size == 4) ? (ticks & 0xFFFFFFFF) : ticks;
     } else if (addr == mtimer->time_base + 4) {
         /* time_hi */
-        return (cpu_riscv_read_rtc(mtimer) >> 32) & 0xFFFFFFFF;
+        return (riscv_aclint_mtimer_get_ticks(mtimer) >> 32) & 0xFFFFFFFF;
     }
 
     qemu_log_mask(LOG_UNIMP,
                   "aclint-mtimer: invalid read: %08x", (uint32_t)addr);
     return 0;
@@ -206,25 +207,25 @@ static void riscv_aclint_mtimer_write(void *opaque, hwaddr addr,
                           "aclint-mtimer: invalid timecmp write: %08x",
                           (uint32_t)addr);
         }
         return;
     } else if (addr == mtimer->time_base || addr == mtimer->time_base + 4) {
-        uint64_t rtc_r = cpu_riscv_read_rtc_raw(mtimer->timebase_freq);
-        uint64_t rtc = cpu_riscv_read_rtc(mtimer);
+        uint64_t ticks_r = riscv_aclint_mtimer_get_ticks_raw(mtimer->timebase_freq);
+        uint64_t ticks = riscv_aclint_mtimer_get_ticks(mtimer);
 
         if (addr == mtimer->time_base) {
             if (size == 4) {
                 /* time_lo for RV32/RV64 */
-                mtimer->time_delta = ((rtc & ~0xFFFFFFFFULL) | value) - rtc_r;
+                mtimer->time_delta = ((ticks & ~0xFFFFFFFFULL) | value) - ticks_r;
             } else {
                 /* time for RV64 */
-                mtimer->time_delta = value - rtc_r;
+                mtimer->time_delta = value - ticks_r;
             }
         } else {
             if (size == 4) {
                 /* time_hi for RV32/RV64 */
-                mtimer->time_delta = (value << 32 | (rtc & 0xFFFFFFFF)) - rtc_r;
+                mtimer->time_delta = (value << 32 | (ticks & 0xFFFFFFFF)) - ticks_r;
             } else {
                 qemu_log_mask(LOG_GUEST_ERROR,
                               "aclint-mtimer: invalid time_hi write: %08x",
                               (uint32_t)addr);
                 return;
@@ -395,11 +396,11 @@ DeviceState *riscv_aclint_mtimer_create(hwaddr addr, hwaddr size,
         if (!env) {
             g_free(cb);
             continue;
         }
         if (provide_rdtime) {
-            riscv_cpu_set_rdtime_fn(env, cpu_riscv_read_rtc, dev);
+            riscv_cpu_set_rdtime_fn(env, riscv_aclint_mtimer_get_ticks, dev);
         }
 
         cb->s = s;
         cb->num = i;
         s->timers[i] = timer_new_ns(QEMU_CLOCK_VIRTUAL,
-- 
2.51.0


