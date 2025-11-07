Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB4A6CCF9F8
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Nov 2025 10:25:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vHJdh-000078-RW; Fri, 07 Nov 2025 05:24:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1vHJdg-00005w-Bi; Fri, 07 Nov 2025 05:24:16 -0500
Received: from mail-northcentralusazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c105::1] helo=CH1PR05CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1vHJdd-00018q-69; Fri, 07 Nov 2025 05:24:16 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HMUbbvlSWhQSg8ZKjrZPokvSnrm0mwDxNv5viVZn2txsa+NS4QvoD+eVNVswPNnnHIF7PTNDFAr4HS0MdnwwQTn671WN+cTJBnaea3ptRiiDTkgHlzrgRJwR0UnMF1NbV8XVn+m7Tj5HyXjjaDqLwBdXUFYFxNvJoKZHKLxX+Hn+ZFhOtjQj4DJUezu8HvDrbK1DLhre06MKDd3gBXyjgvyU7fS3wgPac9YWAmi8TECk8p7e+T/pWVXHEfa2Wi71CLy2sLItcMw0uroInKKrxgrQOBamwvTmBoN0KfXLobkdcdS9ap+bTu+hySId2ClSAHNZGm15gTvpLio2SbWrNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LXPbc2pSbjG6GkH7svqyLfZqDy6tjCczMGxRnrkJqCo=;
 b=U4ULXMKRZm8zaLjaE/cO0iZ60if8PnrBcLiYS1P4/lVLdAf1sk+ZMPIY/vt5fekeEdvOoemiAAEAKUKyN6i+KvqvJ4i8xJjj+6glsJ+95RNlrBdAonoxxMtn7NIEhhR0830e/lEZ9591DO5C+cXsVGTbxlszFoedO/1g9M7/mIc5unO14klJT4ZvnUwLQcqkgDGE8Mkqy89+fI0T2QVjvrL+mlfI/yEnkbZfkaaPYYLOdmE28Cx6XyllzVDgTpB+4c3w95k0YIodgQxn924LKG5t/trcAhDJHrmx0e50EiUoWtIBfakAGmhyX1erZnDBRTAqTzdGGwECanXnMJYscA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LXPbc2pSbjG6GkH7svqyLfZqDy6tjCczMGxRnrkJqCo=;
 b=oAck8cZtuB4arEK/yJVCg3NVISG6om+ufWxEMOIFpRnqMY/As5uZmvtuMd9UbO6RgGcgLpCK6tOYAWFHKcYxFNHtznEX+Yzkf+kwLVU5c/PsOv/rtQi9wIm51Tz27mQfjjepL3GyUqeX39tLM99MbmOk0xdrpz/Wv5gQx1XTpYw=
Received: from BN9PR03CA0777.namprd03.prod.outlook.com (2603:10b6:408:13a::32)
 by SA1PR12MB7222.namprd12.prod.outlook.com (2603:10b6:806:2bf::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.10; Fri, 7 Nov
 2025 10:24:07 +0000
Received: from BN2PEPF000044A2.namprd02.prod.outlook.com
 (2603:10b6:408:13a:cafe::a8) by BN9PR03CA0777.outlook.office365.com
 (2603:10b6:408:13a::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.13 via Frontend Transport; Fri,
 7 Nov 2025 10:24:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN2PEPF000044A2.mail.protection.outlook.com (10.167.243.153) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Fri, 7 Nov 2025 10:24:07 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Fri, 7 Nov
 2025 02:24:05 -0800
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 7 Nov
 2025 04:24:05 -0600
Received: from XFR-LUMICHEL-L2.xilinx.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17
 via Frontend Transport; Fri, 7 Nov 2025 02:24:03 -0800
From: Luc Michel <luc.michel@amd.com>
To: <qemu-devel@nongnu.org>, <qemu-riscv@nongnu.org>
CC: Luc Michel <luc.michel@amd.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, Liu Zhiwei
 <zhiwei_liu@linux.alibaba.com>, Francisco Iglesias
 <francisco.iglesias@amd.com>
Subject: [PATCH 6/9] target/riscv: replace env->rdtime_fn with a time source
Date: Fri, 7 Nov 2025 11:23:32 +0100
Message-ID: <20251107102340.471141-7-luc.michel@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A2:EE_|SA1PR12MB7222:EE_
X-MS-Office365-Filtering-Correlation-Id: 79e6d753-0192-4fde-dd0a-08de1de7c8ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?poWjpATHMlb+E5uJRN/OomZzEvHF9/lGZeBR7K/DrbLWeceiPlxLp9gFarEW?=
 =?us-ascii?Q?+hGuJ1h6CVWupoDz/VBXSZeKRACLCQ/SQ5D4yJWepqNfDX0ztxveEumFCS/8?=
 =?us-ascii?Q?qkI9F4mJbgT/zpu8Kt/noFAGhZYJp5uXkgz2sLwNcL8pX/IFS+q+Bp12WWJQ?=
 =?us-ascii?Q?wLbGbxjLT9T/RntctAE/LudIcqGTq7ZXhFUcXdTueFQveVq3nZTNrhBC+dhV?=
 =?us-ascii?Q?vHT8xmrpc6GCHG+UrTj9jNXd5T/Kbq7YCPHgTdQ4AtXxa2RSFUMmw1/VE1Uc?=
 =?us-ascii?Q?iG0KpO5DKkHbpwMINt305ujk2cDKfLIllNwA2AB4kfvto5UIjlbbEji1MRYL?=
 =?us-ascii?Q?wNWQQTqg5s1s2ydzfNYRjrzM5cRp66ukzp6zvLubaUZ8aTKUy2dUlgctRuPZ?=
 =?us-ascii?Q?YL3rHt7NTVPnDW/WNOkqcTmT+8fq570dlCJKQ7VEGHXkXAnT2nNmrrmkrLoZ?=
 =?us-ascii?Q?wkBR2AWVjokSBnZAGSorf8Yp8hWh5vF4LLSAxgURDm6RlFXr/55Dg6tYS8Qa?=
 =?us-ascii?Q?Q4T7hJwpjwQ0rMIePhMvEoKKDVQuBr0NvSJlv1CYNw1YomKbDSwJEXOpbSRe?=
 =?us-ascii?Q?+DOzqIvw1NoGPY559EzUMyW/FLblHfrgQYOiaeU6wEYyfNw6vucqJ3jJgPqU?=
 =?us-ascii?Q?8mUqr9ZROhzerPOg34fuBnSeaxlsq3Y3tn965YfhCg5KMUb6zLIXA/LECVRY?=
 =?us-ascii?Q?pZE3gwojRWDy4g7xj44AGVA+CtJFE+oWkWmXmoDLpuv3flcUJAQvP5x8Mzde?=
 =?us-ascii?Q?NHgwDgKSBJ9dQjXvbNkzuw0F73lUJ2F0gSd0vo9/qm3ubMchqFE7uDrdBwKN?=
 =?us-ascii?Q?hEasFsuGwYcRSkTFsIy1Frvpy+qBlLtaY1rVSVuFYFd/WOsFIr2N0LdBVkMJ?=
 =?us-ascii?Q?6fbtS+mI+sEfuoBc3juKQfSHgFVkTIUkyhKLtrxGP9ZfirW4ycfBGbudsJm4?=
 =?us-ascii?Q?HpczOCTbm0ZyNHERJkhNXYT86KUOF8iVhnqJhXdNEY49U/i5YFfeR7CIQteW?=
 =?us-ascii?Q?QRYe/o+FlYqkIysBwmzTwXibLdxkSNIE4KHqv/T1Ope/hUE/TLS24A0yRldq?=
 =?us-ascii?Q?EahpFTraLhlzOCl1W6ai6kC2ae6URMZG++B1+NwgpPLB4krenxZqzDskErhK?=
 =?us-ascii?Q?EHmVdiF9TlKD1dDsso2M6ANuVKqwwEuzldQo/SWWs8eh7VK2KDaGhmsOATdJ?=
 =?us-ascii?Q?P82//lLIlLoFPqTavtF3A83MihZkQW041SLu96ThY72Pn+XZKIlpJPuO+0oc?=
 =?us-ascii?Q?Hy89IRhipgi9dGjKnapH+NrmIfYAKLt8zdbeZ4ITROBY4wf5oBnwdgtHMbU1?=
 =?us-ascii?Q?TogxHeP6xoH1Ru3jE5GNEy5yx1PkK47mjf25gwHS1kAw1c8so4J6GWN9yj2d?=
 =?us-ascii?Q?K163kLOkuclmBhWYkgoMyUTAfDLQG9LSKkjhJe6AASWrhPGa0RLJG8y4Esah?=
 =?us-ascii?Q?FIyUmLS/h0WVVj0MJgmOrko60EKUbbBE5YQUr9sp8Z1zzdMf8Kx1e+nBW1CH?=
 =?us-ascii?Q?2jkkmKx4v40h4XShmxH1JWSVAyYCbQPgpxvYHgZ8D9+3trFutJPEAy9kHIwc?=
 =?us-ascii?Q?78WRMaR2pTUVCiMqp0M=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2025 10:24:07.4192 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 79e6d753-0192-4fde-dd0a-08de1de7c8ac
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A2.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7222
Received-SPF: permerror client-ip=2a01:111:f403:c105::1;
 envelope-from=Luc.Michel@amd.com;
 helo=CH1PR05CU001.outbound.protection.outlook.com
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

Replace the env->rdtime_fn function pointer with an instance of the
RISCVCPUTimeSrcIf QOM interface.

This allows to remove the dependency on the ACLINT in the
riscv_timer_write_timecmp function:
   - This dependency was buggy because env->rdtime_fn_arg was an opaque
     pointer and was converted in riscv_timer_write_timecmp to a ACLINT
     without dynamic type check.
   - This will allow to have time sources provided by other devices than
     an ACLINT.

Signed-off-by: Luc Michel <luc.michel@amd.com>
---
 target/riscv/cpu.h         |  8 +++-----
 hw/intc/riscv_aclint.c     |  2 +-
 target/riscv/cpu_helper.c  |  7 -------
 target/riscv/csr.c         | 24 ++++++++++++------------
 target/riscv/time_helper.c | 15 +++++++++------
 5 files changed, 25 insertions(+), 31 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 36e7f100374..368b9e2532d 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -458,13 +458,12 @@ struct CPUArchState {
     struct CPUWatchpoint *cpu_watchpoint[RV_MAX_TRIGGERS];
     QEMUTimer *itrigger_timer[RV_MAX_TRIGGERS];
     int64_t last_icount;
     bool itrigger_enabled;
 
-    /* machine specific rdtime callback */
-    uint64_t (*rdtime_fn)(void *);
-    void *rdtime_fn_arg;
+    /* machine specific time source interface */
+    RISCVCPUTimeSrcIf *time_src;
 
     /* machine specific AIA ireg read-modify-write callback */
 #define AIA_MAKE_IREG(__isel, __priv, __virt, __vgein, __xlen) \
     ((((__xlen) & 0xff) << 24) | \
      (((__vgein) & 0x3f) << 20) | \
@@ -642,12 +641,11 @@ int riscv_cpu_claim_interrupts(RISCVCPU *cpu, uint64_t interrupts);
 uint64_t riscv_cpu_update_mip(CPURISCVState *env, uint64_t mask,
                               uint64_t value);
 void riscv_cpu_set_rnmi(RISCVCPU *cpu, uint32_t irq, bool level);
 void riscv_cpu_interrupt(CPURISCVState *env);
 #define BOOL_TO_MASK(x) (-!!(x)) /* helper for riscv_cpu_update_mip value */
-void riscv_cpu_set_rdtime_fn(CPURISCVState *env, uint64_t (*fn)(void *),
-                             void *arg);
+void riscv_cpu_set_time_src(CPURISCVState *env, RISCVCPUTimeSrcIf *src);
 void riscv_cpu_set_aia_ireg_rmw_fn(CPURISCVState *env, uint32_t priv,
                                    int (*rmw_fn)(void *arg,
                                                  target_ulong reg,
                                                  target_ulong *val,
                                                  target_ulong new_val,
diff --git a/hw/intc/riscv_aclint.c b/hw/intc/riscv_aclint.c
index 4a4449d9d2f..8d001a5eb20 100644
--- a/hw/intc/riscv_aclint.c
+++ b/hw/intc/riscv_aclint.c
@@ -418,11 +418,11 @@ DeviceState *riscv_aclint_mtimer_create(hwaddr addr, hwaddr size,
         if (!env) {
             g_free(cb);
             continue;
         }
         if (provide_rdtime) {
-            riscv_cpu_set_rdtime_fn(env, riscv_aclint_mtimer_get_ticks, dev);
+            riscv_cpu_set_time_src(env, RISCV_CPU_TIME_SRC_IF(dev));
         }
 
         cb->s = s;
         cb->num = i;
         s->timers[i] = timer_new_ns(QEMU_CLOCK_VIRTUAL,
diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index c4fb68b5de8..f642ec80b31 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -757,17 +757,10 @@ uint64_t riscv_cpu_update_mip(CPURISCVState *env, uint64_t mask, uint64_t value)
     riscv_cpu_interrupt(env);
 
     return old;
 }
 
-void riscv_cpu_set_rdtime_fn(CPURISCVState *env, uint64_t (*fn)(void *),
-                             void *arg)
-{
-    env->rdtime_fn = fn;
-    env->rdtime_fn_arg = arg;
-}
-
 void riscv_cpu_set_aia_ireg_rmw_fn(CPURISCVState *env, uint32_t priv,
                                    int (*rmw_fn)(void *arg,
                                                  target_ulong reg,
                                                  target_ulong *val,
                                                  target_ulong new_val,
diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index 5c91658c3dc..583f646460c 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -572,11 +572,11 @@ static RISCVException sstateen(CPURISCVState *env, int csrno)
 
 static RISCVException sstc(CPURISCVState *env, int csrno)
 {
     bool hmode_check = false;
 
-    if (!riscv_cpu_cfg(env)->ext_sstc || !env->rdtime_fn) {
+    if (!riscv_cpu_cfg(env)->ext_sstc || !env->time_src) {
         return RISCV_EXCP_ILLEGAL_INST;
     }
 
     if ((csrno == CSR_VSTIMECMP) || (csrno == CSR_VSTIMECMPH)) {
         hmode_check = true;
@@ -1634,28 +1634,28 @@ static RISCVException read_scountovf(CPURISCVState *env, int csrno,
 static RISCVException read_time(CPURISCVState *env, int csrno,
                                 target_ulong *val)
 {
     uint64_t delta = env->virt_enabled ? env->htimedelta : 0;
 
-    if (!env->rdtime_fn) {
+    if (!env->time_src) {
         return RISCV_EXCP_ILLEGAL_INST;
     }
 
-    *val = env->rdtime_fn(env->rdtime_fn_arg) + delta;
+    *val = riscv_cpu_time_src_get_ticks(env->time_src) + delta;
     return RISCV_EXCP_NONE;
 }
 
 static RISCVException read_timeh(CPURISCVState *env, int csrno,
                                  target_ulong *val)
 {
     uint64_t delta = env->virt_enabled ? env->htimedelta : 0;
 
-    if (!env->rdtime_fn) {
+    if (!env->time_src) {
         return RISCV_EXCP_ILLEGAL_INST;
     }
 
-    *val = (env->rdtime_fn(env->rdtime_fn_arg) + delta) >> 32;
+    *val = (riscv_cpu_time_src_get_ticks(env->time_src) + delta) >> 32;
     return RISCV_EXCP_NONE;
 }
 
 static RISCVException read_vstimecmp(CPURISCVState *env, int csrno,
                                      target_ulong *val)
@@ -4965,60 +4965,60 @@ static RISCVException write_hgatp(CPURISCVState *env, int csrno,
 }
 
 static RISCVException read_htimedelta(CPURISCVState *env, int csrno,
                                       target_ulong *val)
 {
-    if (!env->rdtime_fn) {
+    if (!env->time_src) {
         return RISCV_EXCP_ILLEGAL_INST;
     }
 
     *val = env->htimedelta;
     return RISCV_EXCP_NONE;
 }
 
 static RISCVException write_htimedelta(CPURISCVState *env, int csrno,
                                        target_ulong val, uintptr_t ra)
 {
-    if (!env->rdtime_fn) {
+    if (!env->time_src) {
         return RISCV_EXCP_ILLEGAL_INST;
     }
 
     if (riscv_cpu_mxl(env) == MXL_RV32) {
         env->htimedelta = deposit64(env->htimedelta, 0, 32, (uint64_t)val);
     } else {
         env->htimedelta = val;
     }
 
-    if (riscv_cpu_cfg(env)->ext_sstc && env->rdtime_fn) {
+    if (riscv_cpu_cfg(env)->ext_sstc) {
         riscv_timer_write_timecmp(env, env->vstimer, env->vstimecmp,
                                   env->htimedelta, MIP_VSTIP);
     }
 
     return RISCV_EXCP_NONE;
 }
 
 static RISCVException read_htimedeltah(CPURISCVState *env, int csrno,
                                        target_ulong *val)
 {
-    if (!env->rdtime_fn) {
+    if (!env->time_src) {
         return RISCV_EXCP_ILLEGAL_INST;
     }
 
     *val = env->htimedelta >> 32;
     return RISCV_EXCP_NONE;
 }
 
 static RISCVException write_htimedeltah(CPURISCVState *env, int csrno,
                                         target_ulong val, uintptr_t ra)
 {
-    if (!env->rdtime_fn) {
+    if (!env->time_src) {
         return RISCV_EXCP_ILLEGAL_INST;
     }
 
     env->htimedelta = deposit64(env->htimedelta, 32, 32, (uint64_t)val);
 
-    if (riscv_cpu_cfg(env)->ext_sstc && env->rdtime_fn) {
+    if (riscv_cpu_cfg(env)->ext_sstc) {
         riscv_timer_write_timecmp(env, env->vstimer, env->vstimecmp,
                                   env->htimedelta, MIP_VSTIP);
     }
 
     return RISCV_EXCP_NONE;
@@ -5825,11 +5825,11 @@ riscv_csr_operations csr_ops[CSR_TABLE_SIZE] = {
     [CSR_CYCLEH]   = { "cycleh",   ctr32,  read_hpmcounterh },
     [CSR_INSTRETH] = { "instreth", ctr32,  read_hpmcounterh },
 
     /*
      * In privileged mode, the monitor will have to emulate TIME CSRs only if
-     * rdtime callback is not provided by machine/platform emulation.
+     * CPU time source interface is not provided by machine/platform emulation.
      */
     [CSR_TIME]  = { "time",  ctr,   read_time  },
     [CSR_TIMEH] = { "timeh", ctr32, read_timeh },
 
     /* Crypto Extension */
diff --git a/target/riscv/time_helper.c b/target/riscv/time_helper.c
index dc0777607ab..7b493b7a233 100644
--- a/target/riscv/time_helper.c
+++ b/target/riscv/time_helper.c
@@ -17,11 +17,10 @@
  */
 
 #include "qemu/osdep.h"
 #include "cpu_bits.h"
 #include "time_helper.h"
-#include "hw/intc/riscv_aclint.h"
 
 static void riscv_vstimer_cb(void *opaque)
 {
     RISCVCPU *cpu = opaque;
     CPURISCVState *env = &cpu->env;
@@ -42,28 +41,27 @@ static void riscv_stimer_cb(void *opaque)
 void riscv_timer_write_timecmp(CPURISCVState *env, QEMUTimer *timer,
                                uint64_t timecmp, uint64_t delta,
                                uint32_t timer_irq)
 {
     uint64_t diff, ns_diff, next;
-    RISCVAclintMTimerState *mtimer = env->rdtime_fn_arg;
     uint32_t timebase_freq;
     uint64_t rtc_r;
 
-    if (!riscv_cpu_cfg(env)->ext_sstc || !env->rdtime_fn ||
-        !env->rdtime_fn_arg || !get_field(env->menvcfg, MENVCFG_STCE)) {
+    if (!riscv_cpu_cfg(env)->ext_sstc || !env->time_src ||
+        !get_field(env->menvcfg, MENVCFG_STCE)) {
         /* S/VS Timer IRQ depends on sstc extension, rdtime_fn(), and STCE. */
         return;
     }
 
     if (timer_irq == MIP_VSTIP &&
         (!riscv_has_ext(env, RVH) || !get_field(env->henvcfg, HENVCFG_STCE))) {
         /* VS Timer IRQ also depends on RVH and henvcfg.STCE. */
         return;
     }
 
-    timebase_freq = mtimer->timebase_freq;
-    rtc_r = env->rdtime_fn(env->rdtime_fn_arg) + delta;
+    timebase_freq = riscv_cpu_time_src_get_tick_freq(env->time_src);
+    rtc_r = riscv_cpu_time_src_get_ticks(env->time_src) + delta;
 
     if (timecmp <= rtc_r) {
         /*
          * If we're setting an stimecmp value in the "past",
          * immediately raise the timer interrupt
@@ -199,10 +197,15 @@ void riscv_timer_init(RISCVCPU *cpu)
 
     env->vstimer = timer_new_ns(QEMU_CLOCK_VIRTUAL, &riscv_vstimer_cb, cpu);
     env->vstimecmp = 0;
 }
 
+void riscv_cpu_set_time_src(CPURISCVState *env, RISCVCPUTimeSrcIf *src)
+{
+    env->time_src = src;
+}
+
 static const TypeInfo riscv_cpu_time_src_if_info = {
     .name = TYPE_RISCV_CPU_TIME_SRC_IF,
     .parent = TYPE_INTERFACE,
     .class_size = sizeof(RISCVCPUTimeSrcIfClass),
 };
-- 
2.51.0


