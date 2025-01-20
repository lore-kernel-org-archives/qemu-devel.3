Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3DE3C02181
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2025 22:00:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tZznt-0006sx-HO; Mon, 20 Jan 2025 16:59:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Huibo.Wang@amd.com>)
 id 1tZzNp-0005PJ-Ld
 for qemu-devel@nongnu.org; Mon, 20 Jan 2025 16:32:34 -0500
Received: from mail-mw2nam12on20626.outbound.protection.outlook.com
 ([2a01:111:f403:200a::626]
 helo=NAM12-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Huibo.Wang@amd.com>)
 id 1tZzNn-0000NG-Pm
 for qemu-devel@nongnu.org; Mon, 20 Jan 2025 16:32:33 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dfJ29oMgMo5kAbq+0KBUVoheUQ0bf0tkc4cjttMCwNt9bL4N4+gBcDngJGuxVDWyeivcIdqH5wMOw+IvqgJk+WWhI1QwAZBpOYf2oC+Ksxb5r4IjBx4npD3lA69wH5yX2IV6WqMM556VOgJCxAA+s0KSIBUpDVFLP60kwONzcDLoYiSPJIi09S6uU/adJKl0kXebEw3DHEYugahA8EZF8n0NNLvszKkVCu4ag6isp4LhQXqTUUBU3FcG+gBrJcNxm2jYEa690vp4yLdoAP38961EfFAEWQOBnzp5trtSEvtpGD6PrpLr7Zhfkue7jLV695BYFh9XEcSyN6pXc4i9tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HgPcTzxtDHK+Z2TTaXQsLfkwQ+pfmuU+WrAJgTesJHg=;
 b=x05HHcIOyPoospeq10SR+LnsLoyyABBkktGGkFIpWHZ2Yxh22Gxc0ij9pcech+qv8Mq9B4aV5cGf61Eik0+OZ8bePxd2uONM3xKLIxBRK4IjwSlKefFSXRgE957ptlC1xdH/NFI02tMBU/7b7/68b0JMiPU0A2seQIX+rjzjYDOKnPXTSiQHDtAAvOQrS9rTIejU1sSGHaIWQi2rkouBJ1MjIAxNT4T5JwTq3eWNalwlDhIOLZU38x3VVUr/cZ1Yw3FCiaxh5uYtSe2nYJfm3q9HeWd8S+us8Hc/eQlCiHmLl6AWhcBr4GE0tLcrWM/ZRcMZktzz+aXAFD0MAZuzoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HgPcTzxtDHK+Z2TTaXQsLfkwQ+pfmuU+WrAJgTesJHg=;
 b=Xk1XHZLcKzIcyiqCUlZJYBzQgVu9ZfpPfo5+GAlL+a5GZ8nxfr62/c4mW/wdz6CidyUngC6a6+0lUEXULVHbU9XMdVW9AUZLnzb1BuZXp3YI+LC2wFW7RcknlWWM9ts/xzqRF+NapZiOvUESnSt/oa+gNM5NlJ2l+GFfizrRN3c=
Received: from MN2PR15CA0066.namprd15.prod.outlook.com (2603:10b6:208:237::35)
 by DM6PR12MB4186.namprd12.prod.outlook.com (2603:10b6:5:21b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.22; Mon, 20 Jan
 2025 21:32:26 +0000
Received: from BN1PEPF00004682.namprd03.prod.outlook.com
 (2603:10b6:208:237:cafe::31) by MN2PR15CA0066.outlook.office365.com
 (2603:10b6:208:237::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8356.21 via Frontend Transport; Mon,
 20 Jan 2025 21:32:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF00004682.mail.protection.outlook.com (10.167.243.88) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8377.8 via Frontend Transport; Mon, 20 Jan 2025 21:32:25 +0000
Received: from ruby-9130host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 20 Jan
 2025 15:32:23 -0600
From: Melody Wang <huibo.wang@amd.com>
To: <qemu-devel@nongnu.org>
CC: Tom Lendacky <thomas.lendacky@amd.com>, Paolo Bonzini
 <pbonzini@redhat.com>, <eduardo@habkost.net>, <berrange@redhat.com>,
 <armbru@redhat.com>, <pankaj.gupta@amd.com>, <jroedel@suse.com>,
 <michael.roth@amd.com>, Melody Wang <huibo.wang@amd.com>
Subject: [RFC PATCH v2 2/3] accel/kvm: Add kvm_immediate_exit callback
 infrastructure
Date: Mon, 20 Jan 2025 21:31:15 +0000
Message-ID: <20250120213116.521519-3-huibo.wang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250120213116.521519-1-huibo.wang@amd.com>
References: <20250120213116.521519-1-huibo.wang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004682:EE_|DM6PR12MB4186:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e3f819d-bf7c-45e3-00e9-08dd3999eeda
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?rP9A835PqcbPXCwe6v2mQ7DJgMrGHzplazfSlVLiMcqJ7gPI4LuD8GwWJzjX?=
 =?us-ascii?Q?686jR24/rEEDrfdKbnkGKT/ScDXO6HLN6gFlCi6UTX5N6fd2JSPDHnEcrTmW?=
 =?us-ascii?Q?r+Oyd0VGo2IEbFGmMPLSjHy6kGuJAJfC6YrKP/4HADTtJWz+L4U9Irwv+j8r?=
 =?us-ascii?Q?aDkz1T0mNZ7J0aIAcXfPDLm5wm4I83BYygx4Fv60c8oNArp+Qt/LW6nV3HAP?=
 =?us-ascii?Q?SdLXd6VHb7daKemHLJ7Elsvkl6zq3n2QY2yLSve70kfZtEntAQRHccd47/0o?=
 =?us-ascii?Q?yFjUPVh0wFPtWSmBn7GM2ZpzH/f8FO5LUXHdLay3YBPiGgaDox7oBmT4L48p?=
 =?us-ascii?Q?hDZKI+61v5+A2+7n74VapfA0rdGkj29rHRoGpMWuFAQ/CqXueG8yA1FCGIHI?=
 =?us-ascii?Q?wTAn48V43ms6hbGU7tbtSnXIjtp2YvKCrruGAHfAd4JUJO6MQGaBW5ticlpw?=
 =?us-ascii?Q?P1a2UgWUIG1XoE4hFHqlzSKm16qvDpasD+khHblj8ew9sXVDu+jjxckBaRdT?=
 =?us-ascii?Q?Ww1wVhB1JQbN9nvc+P4ZEUPYZ+AGp/A1Q21QQ4UA+BzoxaFdPoJw8PdQY2iD?=
 =?us-ascii?Q?qb39utw3EFeiICg4xcW30ym+fvxRzz9nmzqOVydDiepkY/x51PYthAcQ7VNn?=
 =?us-ascii?Q?GTI0x4cvJSCWWfNAyqttPnNJGxkIpj/JHxznE5L4lee5hwF80Fjt65tuPcgv?=
 =?us-ascii?Q?ZPArJPMSSDQBpFiA5MmsHqqQrxWp4tbdK267Tn0yYZPNtA3TV0OJc92gcnXi?=
 =?us-ascii?Q?imRhS6MscbQHWxD4Frhmcu4dWjuvLktLZl2jsdpcnkEPKAe4EbWJcmMgc3Sj?=
 =?us-ascii?Q?AS0QvjRZX6nqIdluKRo/k35jvIAWWz8sZx9lMuOGAuKK2kthOxFqGcpAavkg?=
 =?us-ascii?Q?+2CSGCKTVPGyv3nNCBqG+PnUtqDxYxhQy/sm4jK7NFwwrCKc0XWlQGH5Ji3B?=
 =?us-ascii?Q?O6D0jBhGRMCyD5G+5TYs3l6DVQfQ/XEOtB5ph1IRFT6wE49OyC40XYjVTNj2?=
 =?us-ascii?Q?CWrwEoOkmVu3FsspmbsWz6Yq23o3dDyPAusyBYhfZpSWae8U06nXin6jQHcr?=
 =?us-ascii?Q?JlRRQ2noAVIz+snPG2TZlv7qKUHCJlipxN/SFe+RGBdh33AR+7jStxbrflKY?=
 =?us-ascii?Q?Bz2dGHQaheCC7IeK4elr5bX6zkGG7ssrOiyPw3oEDHgP1QyHMNtbJKdrCr7A?=
 =?us-ascii?Q?2q57RqQbZjwd1c2Lo1vPgmbem3XogSpXeBENJlVugK7S2vEAKq7lBVPqIRuz?=
 =?us-ascii?Q?SgIGhItZUXTDozXPkyseTuvZWrCw6kdLFtYkxd5TlZF2CO053J0CSREI6k6p?=
 =?us-ascii?Q?wlJue4YPZFhWjgDWJYYEfbzE2yrdRPzFj6Ju5umcTnD8QABRbfqHgXjub8Wu?=
 =?us-ascii?Q?8qelPu1j7iiBeY2Ospp5CjbWXU0NF1ER07kXEIgY/k3haOB69yn/fmuCBtRu?=
 =?us-ascii?Q?sBT4Ed992qRiM9KrZzEnV8Yyv2MgRojVU3+dxqiQrxhxFTfjUttY7Hy6ITHL?=
 =?us-ascii?Q?xlcpRfj07Pq4mn0=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2025 21:32:25.5897 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e3f819d-bf7c-45e3-00e9-08dd3999eeda
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00004682.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4186
Received-SPF: permerror client-ip=2a01:111:f403:200a::626;
 envelope-from=Huibo.Wang@amd.com;
 helo=NAM12-MW2-obe.outbound.protection.outlook.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-3,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 20 Jan 2025 16:59:27 -0500
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

From: Michael Roth <michael.roth@amd.com>

Provide a generic mechanism so that users of struct kvm_run's
'immediate_exit' flag can register a callback that can be issued after
returning from KVM.

Signed-off-by: Michael Roth <michael.roth@amd.com>
Signed-off-by: Melody Wang <huibo.wang@amd.com>
---
 accel/kvm/kvm-all.c  | 43 +++++++++++++++++++++++++++++++++++++++++++
 include/system/kvm.h |  3 +++
 2 files changed, 46 insertions(+)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index c65b790433..c8516d6ba8 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -3091,6 +3091,46 @@ out_unref:
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
@@ -3160,6 +3200,9 @@ int kvm_cpu_exec(CPUState *cpu)
             if (run_ret == -EINTR || run_ret == -EAGAIN) {
                 trace_kvm_io_window_exit();
                 kvm_eat_signals(cpu);
+                if (kvm_immediate_exit) {
+                    process_immediate_exit_callbacks();
+                }
                 ret = EXCP_INTERRUPT;
                 break;
             }
diff --git a/include/system/kvm.h b/include/system/kvm.h
index ab17c09a55..fb21bdeede 100644
--- a/include/system/kvm.h
+++ b/include/system/kvm.h
@@ -586,4 +586,7 @@ int kvm_set_memory_attributes_shared(hwaddr start, uint64_t size);
 
 int kvm_convert_memory(hwaddr start, hwaddr size, bool to_private);
 
+typedef void ImmediateExitCb(void *opaque);
+void add_immediate_exit_callback(CPUState *cpu, ImmediateExitCb *cb, void *opaque);
+
 #endif
-- 
2.34.1


