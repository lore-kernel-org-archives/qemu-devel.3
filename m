Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E225AC41513
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2024 19:37:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEDUH-00040U-Gy; Mon, 03 Jun 2024 15:36:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <John.Allen@amd.com>)
 id 1sEDUG-00040J-9Z
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 15:36:56 -0400
Received: from mail-mw2nam12on20624.outbound.protection.outlook.com
 ([2a01:111:f403:200a::624]
 helo=NAM12-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <John.Allen@amd.com>)
 id 1sEDUD-0003Cf-0H
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 15:36:56 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IWT5zwllyPm1RHbzVanLbmYP65Vf8IPPbmCbTDnyGXOXb54Rq0xGqyVYtVI7Yd9E/3X1f5vaHde5R5F4IJWXCBcPhpzTowdpQMjJyqYIAxF2pjMXGS5xfqCqwnwjlxu7zm/0Xitl0tbta7CC4DDDptVPnT1U8iwlYvqXCEN9HZtvUD7YCvQOOXbN8XTtW655ei58cqZaVC9x/MnWLRmqJ6Bp19qIfGbE1yLvbFSZ7SQ6og8VePxHuFsNuwqmKTfWCYvYpFSkXY+WDUeYzhZdqqIFtS2TaCsbC4i3PH29q7sFyGE6Fs/1KjRKpLVScE6QmY+i9Nlirb3Wc+Y4BdEc/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sJ/yxlfI+MYw2SqT7bhpFIrqH/sMjF6JC9kMtdptEd0=;
 b=mUxj3PuEupvpr/yYxTIup60/T+12iXbP+i5h2+u2ljWmInke6KHJ/augPa5oIaBv2p/qK4Au13WGurGXrIGl0jH0N74IBoCdfHBy8BQq2OJErdyBU7GVod3DiMC2OyzdjbnWu8Isza7W+FCj9JNH3t5DUmM0RJHwHofrN8LGXQhlhQs08OJHaCkR4Yy3bGvtk1rDm6BLRZ9I6nI++/mRh/L25+gRiD1TZTRZVRjeXFjeoar033P51tVMgHbnqXHBfIivyzYY8ws/2BGH2aaMLNgLhcVnxBtJQ7vuUcLYzqm2ewwu5LNLbFwslOSDebIOLpEbuaNPeT3fJ3REB+3X0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sJ/yxlfI+MYw2SqT7bhpFIrqH/sMjF6JC9kMtdptEd0=;
 b=YtFJY0C/1ycwRzarATZHmONZfpjDFPgIE7I9hdSCB6tPUGGhHM+UI0kLlaRne5wN6MPN1FGuwNf0jDHCccW6NwDDP9x15twXY9dyCugzi/rDMaC1qIGEb2PJCatRskPuzfOonRsaIire3wjRD7OziHgeZaZbpCc8QDb1ZGmBpfk=
Received: from CH0PR03CA0317.namprd03.prod.outlook.com (2603:10b6:610:118::12)
 by DM4PR12MB6182.namprd12.prod.outlook.com (2603:10b6:8:a8::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.21; Mon, 3 Jun
 2024 19:36:48 +0000
Received: from CH1PEPF0000A346.namprd04.prod.outlook.com
 (2603:10b6:610:118:cafe::f) by CH0PR03CA0317.outlook.office365.com
 (2603:10b6:610:118::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.30 via Frontend
 Transport; Mon, 3 Jun 2024 19:36:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000A346.mail.protection.outlook.com (10.167.244.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Mon, 3 Jun 2024 19:36:47 +0000
Received: from jallen-jump-host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 3 Jun
 2024 14:36:44 -0500
From: John Allen <john.allen@amd.com>
To: <qemu-devel@nongnu.org>
CC: <yazen.ghannam@amd.com>, <michael.roth@amd.com>, <babu.moger@amd.com>,
 <pankaj.gupta@amd.com>, <william.roche@oracle.com>,
 <joao.m.martins@oracle.com>, <pbonzini@redhat.com>,
 <richard.henderson@linaro.org>, <eduardo@habkost.net>, John Allen
 <john.allen@amd.com>
Subject: [PATCH v5 1/3] i386: Fix MCE support for AMD hosts
Date: Mon, 3 Jun 2024 19:36:20 +0000
Message-ID: <20240603193622.47156-2-john.allen@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240603193622.47156-1-john.allen@amd.com>
References: <20240603193622.47156-1-john.allen@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A346:EE_|DM4PR12MB6182:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f01490a-859d-4b1f-7240-08dc84048237
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|36860700004|82310400017|1800799015|376005; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?S17f+BSKbQ4hDYJX7dcXt1g6vQV3XzpkLN+J+ge0jGKkj5u7HI4U9WaVVtqD?=
 =?us-ascii?Q?xqWLjG/v8BXlywndSsD6DDFzC2k/csl32zr5PNJ3/cOtE3jlcXVfgyIEErf2?=
 =?us-ascii?Q?HISwM9/8fckNB2PbI4odX7CPE4K93gUVodhGw6gVMrqhPVZAkS7tHFsJf0xO?=
 =?us-ascii?Q?eTneCU78HIJZhZHQnLtCmp5zz+f6+9TG4HzyClK7PM9cReFjEQsnTr7JPkJr?=
 =?us-ascii?Q?X87sajRaORXuQvYF0xRylqa4HQbedbfMfXGFTNCdFYI8IfdxtZz5B6OHN1Dr?=
 =?us-ascii?Q?6PUPJsNOBSH5Nx9v70qswhqF+v+sK8Bz1iwl2d6IuouNR1UOV0Yk0G0JCCNo?=
 =?us-ascii?Q?QqKB7GIa8JbQJAmz73SyEESZW+oGbtEbmmOJCn7Ij8ZUl+WVn3YIuExx6NWh?=
 =?us-ascii?Q?SewrC//3OwJCH/7cN6cFyDMwDfPvnFWz+MKpK92KvdXWFjW3vlwW0LmAPJ0S?=
 =?us-ascii?Q?izwJpYQrpCQwebF6e87oqNra2dIWrb0/5qeMBWs4gd4c3ol/tBoEi4EOxEkM?=
 =?us-ascii?Q?Ki8bnqihkWTmzsF6oLFv78+OGaZFZG+nj6YmppsIZhnV7jCMv7fg0zMCLia5?=
 =?us-ascii?Q?SO/ZzvCj6nPVMS7uJmch3kQGfOwvwHfc2mpnATpJsd7M371KBAxw7jgUahsw?=
 =?us-ascii?Q?3lZ+vpTVmKHgHKtcWaT5Mmv0bTn1qxQ7EDFSAJKUnl1QYNAK50ZmoiBIoFQa?=
 =?us-ascii?Q?7buskV//sQfUQcew1Ga91nGDmiAMkYOTiTRvIhQlzY0SkAHnsIV+TE+LuYUc?=
 =?us-ascii?Q?OOoMHlZzGD/M4UjRpDp02aL6kvm9kRaVxEJpLVyd6s/u7M/zWxhDy3jaRxTV?=
 =?us-ascii?Q?lTPrQXpjgZMUjyiTf1amEL/TnRWkL6C0frj+rXvyLCiYbYCxOJrCePYJxBpv?=
 =?us-ascii?Q?1OOrI0NmUAQOR1a/c2OpyOAUu+YObrIaT3Zp1OoY8A/537pUq2bvx9FO3Pir?=
 =?us-ascii?Q?V+DzUnbdxFpd9CPDSdtdvFos1sixyk5WSuZgpe2/VBBpofYs3Xsauxv67CtL?=
 =?us-ascii?Q?gQKnPuQp4tz9T5sAIb0nWzKDJVovfJoVHuAvh7gkI+Rl5w5LFW0xMrHcAr0H?=
 =?us-ascii?Q?jMEokLkqY776qHpVaJpIUqnkVIuUquXuzbbLbd5skpsqvqZ54LQIqWgM3lJh?=
 =?us-ascii?Q?a3BWUzsILshJK1EhdoENB+YpeRA+I9+I3cL9K6msvCx5SRrx/WeMPoAcsQ7g?=
 =?us-ascii?Q?vg0uHuG4bLhHQBo7up3cS7F+pa4OWeQIMd8P1M6xoBmnlS208PJzuCOfUxtl?=
 =?us-ascii?Q?upBFuXblzPBhMBbkQW86o7PbLz7GLBlwpuwcJhofWjOkYi0rBCOnICGYCpR/?=
 =?us-ascii?Q?o00cQbA2DNh5Hz0rO7vu7/lMFgsXIxPknJxcF1yHIW1tnx869bb8Nna7p5Lp?=
 =?us-ascii?Q?RjBNJKuRfF6hfZKSCtxz6/W60AM9?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(82310400017)(1800799015)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2024 19:36:47.8550 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f01490a-859d-4b1f-7240-08dc84048237
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000A346.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6182
Received-SPF: permerror client-ip=2a01:111:f403:200a::624;
 envelope-from=John.Allen@amd.com;
 helo=NAM12-MW2-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

For the most part, AMD hosts can use the same MCE injection code as Intel, but
there are instances where the qemu implementation is Intel specific. First, MCE
delivery works differently on AMD and does not support broadcast. Second,
kvm_mce_inject generates MCEs that include a number of Intel specific status
bits. Modify kvm_mce_inject to properly generate MCEs on AMD platforms.

Reported-by: William Roche <william.roche@oracle.com>
Signed-off-by: John Allen <john.allen@amd.com>
---
v3:
  - Update to latest qemu code that introduces using MCG_STATUS_RIPV in the
    case of a BUS_MCEERR_AR on a non-AMD machine.
v5:
  - This version implements proper support for AO (deferred) errors. For
    deferred errors, there are some differences in the flags that need to be
    set in order to be handled correctly. First, the UC flag must not be set
    to allow deferred errors to be picked up by the machine_check_poll
    function in the guest kernel, mirroring baremetal behavior. If the UC
    flag is set, the injected MCE will be sent as an interrupt and will be
    handled in do_machine_check which currently is not expected to handle
    deferred errors and would need significant modification to do so.

  - Both the deferred (AO) and uncorrected (AR) error cases set the POISON
    bit. For the uncorrected error case, this is expected and properly
    mirrors baremetal behavior. For the deferred error case, this bit would
    not be set by hardware, but is being reused as a convenient workaround
    to give better behavior in the case that the MCE_KILL_EARLY flag is set
    in the guest process. See code comment for more details.
---
 target/i386/cpu.h     |  2 ++
 target/i386/helper.c  |  4 ++++
 target/i386/kvm/kvm.c | 39 +++++++++++++++++++++++++++++++--------
 3 files changed, 37 insertions(+), 8 deletions(-)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index dfe43b8204..ddf53937b4 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -365,6 +365,8 @@ typedef enum X86Seg {
 #define MCI_STATUS_PCC   (1ULL<<57)  /* processor context corrupt */
 #define MCI_STATUS_S     (1ULL<<56)  /* Signaled machine check */
 #define MCI_STATUS_AR    (1ULL<<55)  /* Action required */
+#define MCI_STATUS_DEFERRED    (1ULL<<44)  /* Deferred error */
+#define MCI_STATUS_POISON      (1ULL<<43)  /* Poisoned data consumed */
 
 /* MISC register defines */
 #define MCM_ADDR_SEGOFF  0      /* segment offset */
diff --git a/target/i386/helper.c b/target/i386/helper.c
index 2070dd0dda..6f6b0f02e0 100644
--- a/target/i386/helper.c
+++ b/target/i386/helper.c
@@ -91,6 +91,10 @@ int cpu_x86_support_mca_broadcast(CPUX86State *env)
     int family = 0;
     int model = 0;
 
+    if (IS_AMD_CPU(env)) {
+        return 0;
+    }
+
     cpu_x86_version(env, &family, &model);
     if ((family == 6 && model >= 14) || family > 6) {
         return 1;
diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index 42970ab046..810f586a59 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -582,17 +582,40 @@ static void kvm_mce_inject(X86CPU *cpu, hwaddr paddr, int code)
 {
     CPUState *cs = CPU(cpu);
     CPUX86State *env = &cpu->env;
-    uint64_t status = MCI_STATUS_VAL | MCI_STATUS_UC | MCI_STATUS_EN |
-                      MCI_STATUS_MISCV | MCI_STATUS_ADDRV | MCI_STATUS_S;
-    uint64_t mcg_status = MCG_STATUS_MCIP;
+    uint64_t status = MCI_STATUS_VAL | MCI_STATUS_EN | MCI_STATUS_MISCV |
+                      MCI_STATUS_ADDRV;
+    uint64_t mcg_status = MCG_STATUS_MCIP | MCG_STATUS_RIPV;
     int flags = 0;
 
-    if (code == BUS_MCEERR_AR) {
-        status |= MCI_STATUS_AR | 0x134;
-        mcg_status |= MCG_STATUS_RIPV | MCG_STATUS_EIPV;
+    if (!IS_AMD_CPU(env)) {
+        status |= MCI_STATUS_S | MCI_STATUS_UC;
+        if (code == BUS_MCEERR_AR) {
+            status |= MCI_STATUS_AR | 0x134;
+            mcg_status |= MCG_STATUS_EIPV;
+        } else {
+            status |= 0xc0;
+        }
     } else {
-        status |= 0xc0;
-        mcg_status |= MCG_STATUS_RIPV;
+        if (code == BUS_MCEERR_AR) {
+            status |= MCI_STATUS_UC | MCI_STATUS_POISON;
+            mcg_status |= MCG_STATUS_EIPV;
+        } else {
+            /* Setting the POISON bit for deferred errors indicates to the
+             * guest kernel that the address provided by the MCE is valid
+             * and usable which will ensure that the guest kernel will send
+             * a SIGBUS_AO signal to the guest process. This allows for
+             * more desirable behavior in the case that the guest process
+             * with poisoned memory has set the MCE_KILL_EARLY prctl flag
+             * which indicates that the process would prefer to handle or
+             * shutdown due to the poisoned memory condition before the
+             * memory has been accessed.
+             *
+             * While the POISON bit would not be set in a deferred error
+             * sent from hardware, the bit is not meaningful for deferred
+             * errors and can be reused in this scenario.
+             */
+            status |= MCI_STATUS_DEFERRED | MCI_STATUS_POISON;
+        }
     }
 
     flags = cpu_x86_support_mca_broadcast(env) ? MCE_INJECT_BROADCAST : 0;
-- 
2.43.0


