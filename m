Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8F8FE7718A
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2024 15:51:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNwK9-0005UG-F1; Wed, 18 Dec 2024 10:50:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1tNwK5-0005Tu-Hv
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 10:50:53 -0500
Received: from mail-mw2nam10on20604.outbound.protection.outlook.com
 ([2a01:111:f403:2412::604]
 helo=NAM10-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1tNwK3-0003qh-MX
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 10:50:53 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JVCKdTgX0O7g7A4Zp92fXCkS9mcD7GTLRAtUB7BLc6onzBUOaG2L0zZh5NhSo3+21bhDqEX7TY+A5EwLX+HB8A2V2MqbPyfuB2QdrUafpFZwOqhX3YV6o3xg21uTz3W5E55hGJzyM4E1w1uhB3f2NuFJtHpM5ccIO9tiRZOtq49leHORQB9Xd4MLf9j/E83pxSgtPMlz07i/Mm43FefH61JvQGa5se9CevTKWdfxp3NWXFFIWCSjl3c7R5edrs0MfQKhOnMxOKGqvcOeAnPf8d8ULs0PZLVH+7catQvf0SCmgg3ZPTEcnmn0P+P0m0hGxPr+MPdZa6wjVtnh6417Bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wVTGCtF0LtdOoZKaoC5Qzv6XnhHaUpQchyQXz90KzY0=;
 b=DfszbgmS3VNHfGVYcDWvA5c9xMi0Tc7Rj1fHm0qRCuevsVrW+cV90lPTAVUOw6C69duJpte0Bwy+9MytfJ8IbSpFon65KIPqkeyuhRmnaQem5r71cR3LJpV6Z2JLp6uGmYbhhGZrFQeVyM0Y5p0bxyE8NfjABMSXkL1bTTJpy7NABJQAQqBQOjGx4773ZGbk9hxuWxa86v/n8pUPF5niB9WrZhZVRW13DTPUuF0JhZqQijgeE5L0qElNhxEY0sNz2Yahh8R55a6VTB9rodGK9u+0hnuMx4tMyZIB7WtR4yXtBKVIntKB+xXpVVUZA+Hc8wiUetam0viRiO4EMF0pWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wVTGCtF0LtdOoZKaoC5Qzv6XnhHaUpQchyQXz90KzY0=;
 b=CpKund+x1LWKOtiLHLhod3JhofjTqza5bfgoKhAvsHC8f4J4x3vZwy88fCV4JuGkg3l/0tIXV1oiqujAJzZ++vLTePbPpsmtJzzzwU6twemXTiJJtklQX7RqVZpa3FrWC7/ajb2RT3UMgkY+yUZ5yjUSd0W5FzCIEqcC6hNNzpg=
Received: from BLAPR03CA0050.namprd03.prod.outlook.com (2603:10b6:208:32d::25)
 by LV3PR12MB9234.namprd12.prod.outlook.com (2603:10b6:408:1a0::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.12; Wed, 18 Dec
 2024 15:50:44 +0000
Received: from MN1PEPF0000ECD9.namprd02.prod.outlook.com
 (2603:10b6:208:32d:cafe::59) by BLAPR03CA0050.outlook.office365.com
 (2603:10b6:208:32d::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.22 via Frontend Transport; Wed,
 18 Dec 2024 15:50:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000ECD9.mail.protection.outlook.com (10.167.242.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8251.15 via Frontend Transport; Wed, 18 Dec 2024 15:50:41 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 18 Dec
 2024 09:50:41 -0600
From: Michael Roth <michael.roth@amd.com>
To: <qemu-devel@nongnu.org>
CC: <pbonzini@redhat.com>, <berrange@redhat.com>, <eduardo@habkost.net>,
 <armbru@redhat.com>, <pankaj.gupta@amd.com>, <huibo.wang@amd.com>,
 <jroedel@suse.com>
Subject: [PATCH v1 2/3] accel/kvm: Add kvm_immediate_exit callback
 infrastructure
Date: Wed, 18 Dec 2024 09:49:38 -0600
Message-ID: <20241218154939.1114831-3-michael.roth@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241218154939.1114831-1-michael.roth@amd.com>
References: <20241218154939.1114831-1-michael.roth@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD9:EE_|LV3PR12MB9234:EE_
X-MS-Office365-Filtering-Correlation-Id: c5a5486c-4cff-46aa-56e0-08dd1f7bb9de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?jOE2fXB17azWBl/n16vjzNSSNamdHDyOKY1F5Mpvoz+OB5wfw/7vP12zED1S?=
 =?us-ascii?Q?5aiGZ3s3DcvKtCpVdf2LdS+0Ht/TlxnboqOQAbngDBwxb4amHtY3xAsHsF61?=
 =?us-ascii?Q?ZIFe3bJYzTZEBEVuZ0UxNnue66i2vdD5l3iSFVEnjel6tzxRPUIA0lYjobxG?=
 =?us-ascii?Q?3oxCBQcY5uMWbRNw23Bd7+W8Q50T90/DUjsPbi6vQi95TAYhWQrkfGAGSjYo?=
 =?us-ascii?Q?zcsEUIeaD7GcC1+3tpY/+fNXOLVkJenzhUV2bZ9CV2bn3qlqwF1P4A0bsBrv?=
 =?us-ascii?Q?zzAYZe2PqI1/HdGjsQxcF9ggKRsasqypUgsHrZ44mje2gzbcXYBjgbOMGlkC?=
 =?us-ascii?Q?FjZ0234uDoAOzNA98B4TKUXBV/2rxb6M2RYsFPSwvjx3WV8T/GI02oCpMLe6?=
 =?us-ascii?Q?/CwWyaK8KQN+xSodjeOr/np5yJTK0GgV82PO49LqPfjNk7tgQ/suMd0PknSC?=
 =?us-ascii?Q?XqHBIZ0zZtKoL+XWj560Br0bIH8ah4cQOcI/lTCLrMq1sZowekb45AgRDNHh?=
 =?us-ascii?Q?EFIX3k9AD7Vx/nQkUOD7Vu3oS3448MMOSPxUFH7uh+VsXy3J19Rcbpg/ET09?=
 =?us-ascii?Q?/hExj/ApHs4W08UyKZrgFwvbFhZDhbmm88OCgHIvAJZZ2+qZkN6sAiTCFqln?=
 =?us-ascii?Q?JbtA4y5CmrIcywY6lwFry2nP3QVnczUA76ZCnoWVfG5SDAF+g+Fq54Z2YXlk?=
 =?us-ascii?Q?QVmtYiNfrXGKZLHeejw1E4CVkQDPMSOog1KxXEUks2k1F9DO8qfsFThcOGrG?=
 =?us-ascii?Q?HQU39SCVzJp40dIobvCRFHWjPfa0zUr43vpH1daiJADkKgPyaOTUMMGm1Sdp?=
 =?us-ascii?Q?G+Xt7lxOKH5visbXUBMVNhtmGxGvITzFA6ulonAS5ZytzgINfnRUbVn4cRym?=
 =?us-ascii?Q?NdiumOtCWv+AjMeAmjndBAsa7zHPxAzzybX1kQge20t7a5lHRnBKaJKtiQqH?=
 =?us-ascii?Q?lojrjQpQAXG14/oRQ52YJagEB9nunR4iYDBW/RiNLKZ08gOJUhimOD1nC6I+?=
 =?us-ascii?Q?Oda7192yRcTn+ib3d5EKpPdH6EsU7pGrNpuI6q/EmZUjCi3eHjHnZhaDhyz1?=
 =?us-ascii?Q?/8FE4sNpDI2rm0RZqgXheyBjTxYABlupc0qn+WYwckSAY4zY9a8o8rILld6J?=
 =?us-ascii?Q?Eu+cm041hdyAPLVcoTjhEBhquieAzfTqNZ6tdDfTFK01znZ7Nbp6OMh9zZVC?=
 =?us-ascii?Q?4QcFEulgQ/SuBlMkbiShhqa7vslBTCleCTzzbVQAbLiBKC8RK4qkveyyQO5M?=
 =?us-ascii?Q?q6LJbGVDE00Ds/8aonpJ9AlyiTO5njwZMHWBSxPBnP4mEBZQR6siIEL7rLkn?=
 =?us-ascii?Q?YuEVBpsSp1vTKRCBk40LChL4lP0KT3OPGUITBZEHE+Ln51RnNqywmgud/Os3?=
 =?us-ascii?Q?9jiTAwFKaCtp5/W8LJ1hRjhMimNiccwdeRuMbQo2lLTv15RRLbVp8K6ki05a?=
 =?us-ascii?Q?pNXd7CY1HlV2Buu8eJBpWMt6lOGCNfSwNT3vNg1lMJRvKJM6ZRVIs4fhvq4G?=
 =?us-ascii?Q?IxEgarNkDPn6nec=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2024 15:50:41.5648 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c5a5486c-4cff-46aa-56e0-08dd1f7bb9de
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD9.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9234
Received-SPF: permerror client-ip=2a01:111:f403:2412::604;
 envelope-from=Michael.Roth@amd.com;
 helo=NAM10-MW2-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Provide a generic mechanism so that users of struct kvm_run's
'immediate_exit' flag can register a callback that can be issued after
returning from KVM.

Signed-off-by: Michael Roth <michael.roth@amd.com>
---
 accel/kvm/kvm-all.c  | 43 +++++++++++++++++++++++++++++++++++++++++++
 include/sysemu/kvm.h |  3 +++
 2 files changed, 46 insertions(+)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 801cff16a5..14e98a96e6 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -3080,6 +3080,46 @@ out_unref:
     return ret;
 }
 
+typedef struct ImmediateExitEntry ImmediateExitEntry;
+
+struct ImmediateExitEntry {
+    ImmediateExitCb *cb;
+    void *opaque;
+    QTAILQ_ENTRY(ImmediateExitEntry) next;
+};
+
+static QTAILQ_HEAD(, ImmediateExitEntry) immediate_exit_list = \
+    QTAILQ_HEAD_INITIALIZER(immediate_exit_list);
+
+void add_immediate_exit_callback(CPUState *cpu, ImmediateExitCb *cb, void *opaque)
+{
+    ImmediateExitEntry *entry = g_new(ImmediateExitEntry, 1);
+    entry->cb = cb;
+    entry->opaque = opaque;
+
+    bql_lock();
+    QTAILQ_INSERT_TAIL(&immediate_exit_list, entry, next);
+    bql_unlock();
+
+    kvm_cpu_kick(cpu);
+}
+
+static void process_immediate_exit_callbacks(void)
+{
+    ImmediateExitEntry *entry, *tmp;
+
+    bql_lock();
+
+    /* Handle any pending immediate-exit callbacks */
+    QTAILQ_FOREACH_SAFE(entry, &immediate_exit_list, next, tmp) {
+        entry->cb(entry->opaque);
+        QTAILQ_REMOVE(&immediate_exit_list, entry, next);
+        g_free(entry);
+    }
+
+    bql_unlock();
+}
+
 int kvm_cpu_exec(CPUState *cpu)
 {
     struct kvm_run *run = cpu->kvm_run;
@@ -3149,6 +3189,9 @@ int kvm_cpu_exec(CPUState *cpu)
             if (run_ret == -EINTR || run_ret == -EAGAIN) {
                 trace_kvm_io_window_exit();
                 kvm_eat_signals(cpu);
+                if (kvm_immediate_exit) {
+                    process_immediate_exit_callbacks();
+                }
                 ret = EXCP_INTERRUPT;
                 break;
             }
diff --git a/include/sysemu/kvm.h b/include/sysemu/kvm.h
index c3a60b2890..5974645c62 100644
--- a/include/sysemu/kvm.h
+++ b/include/sysemu/kvm.h
@@ -578,4 +578,7 @@ int kvm_set_memory_attributes_shared(hwaddr start, uint64_t size);
 
 int kvm_convert_memory(hwaddr start, hwaddr size, bool to_private);
 
+typedef void ImmediateExitCb(void *opaque);
+void add_immediate_exit_callback(CPUState *cpu, ImmediateExitCb *cb, void *opaque);
+
 #endif
-- 
2.25.1


