Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 745F9CE8D6B
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Nov 2025 08:54:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vKuzy-0002sc-51; Mon, 17 Nov 2025 03:54:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Honglei1.Huang@amd.com>)
 id 1vKuzv-0002qa-HV
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 03:54:07 -0500
Received: from mail-southcentralusazlp170120001.outbound.protection.outlook.com
 ([2a01:111:f403:c10d::1] helo=SN4PR2101CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Honglei1.Huang@amd.com>)
 id 1vKuzt-0007Rn-Cl
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 03:54:07 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FW7gGR6UG7gwcC4DNhz3YPWVkISjYbI8xl70Bm41gy4XjYomF+a7Bh8Gk796cOysXmtc4EQoVh4FxbK1xD7jFjxxZIjK4KtlKNG1kWFm6GUN7mVhGgRJS63etgLeWTlxV3eZgFTCNd1HI1jUXyunnDRhDVNRZJOVSeK0MEl4zwhkNd/UZF0enO7/b5ejCQEh2g1hlByJ8czd4V/TCfECcGiJTD5AyL4oGO+vOuSXzB+Gz8NaT69aBh3i1NQXf6b+g0ytueiOiUh+4fhmF+ZNeqyB+HRSsmj7Y64rTb3gDWXHKNlYA1JWYNG/Es0ucxmPvzNeryxbpvVkJ56OFt9sdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VnYPAj0BtO+6rI6w0DdcH16SIzIKZx4zB3KeLMsmhN0=;
 b=TV5uXzsJ31gCFI7Kb22/CDa1kOF41ruWbPXf7ALJp+JFWU5F8ZUxD1gijXnNecTsRgWruZxPR3sVKbCedrU+5idgpVp0SbzjHFhD8lY+ewKP1QeeHIqPrxlyoDrDSywDRMIbN306FsDsaL8lFS4yJ0npAAYsjoP2tuDaH6xTAhfBsZkPtv552zGrzLX/U7wL/RqGgFJq3ZuLYmnFx43wejNz+0t64qKZHDu7Psbemqy0jjEP9HkquL2SIMca2++E7tuV4sSS1dGaQCVCDaJNljVxxyK8JME+dqCgI8WHEhajYP1AKbYYz9sItroDx3pW1qhrgV98cTptzHGvqXU9gA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VnYPAj0BtO+6rI6w0DdcH16SIzIKZx4zB3KeLMsmhN0=;
 b=FblTRbulPSes17458wvBABE3pv2uSW18l1TOgRik722H6NiJXVvLNRstLOKFOKWoqvdpbUnENaVrS5ZV5TOUjDdnJ9yq4OsbT5AJISSBYptzoAcvgVZMbu2klDZ3P78rmKGsByJEFL3+AX/8Z4IpQnTGi2YpmfWmIvxOuJE/V0w=
Received: from CH0PR03CA0242.namprd03.prod.outlook.com (2603:10b6:610:e5::7)
 by PH7PR12MB9073.namprd12.prod.outlook.com (2603:10b6:510:2eb::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.17; Mon, 17 Nov
 2025 08:53:58 +0000
Received: from DS2PEPF0000343C.namprd02.prod.outlook.com
 (2603:10b6:610:e5:cafe::a6) by CH0PR03CA0242.outlook.office365.com
 (2603:10b6:610:e5::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.21 via Frontend Transport; Mon,
 17 Nov 2025 08:53:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS2PEPF0000343C.mail.protection.outlook.com (10.167.18.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Mon, 17 Nov 2025 08:53:57 +0000
Received: from honglei-remote.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 17 Nov
 2025 00:53:54 -0800
From: Honglei Huang <honghuan@amd.com>
To: <alex.bennee@linaro.org>, <dmitry.osipenko@collabora.com>,
 <odaki@rsg.ci.i.u-tokyo.ac.jp>, <armbru@redhat.com>
CC: <mst@redhat.com>, <cohuck@redhat.com>, <pbonzini@redhat.com>,
 <qemu-devel@nongnu.org>, <Ray.Huang@amd.com>, Honglei Huang
 <honghuan@amd.com>
Subject: [v3] virtio-gpu: use consistent error checking style for
 virtio_gpu_create_mapping_iov
Date: Mon, 17 Nov 2025 16:53:42 +0800
Message-ID: <20251117085342.175659-1-honghuan@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343C:EE_|PH7PR12MB9073:EE_
X-MS-Office365-Filtering-Correlation-Id: 39e8aa99-abbe-4962-2103-08de25b6d82d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?+Erla/PG3RkZF/Q+TUigHI5nKmYrlGBycCNboxgIbwTZ7EDF/XdjWmVnPYjs?=
 =?us-ascii?Q?wEWpStM7iMr7dcSLM6I0MDo0fCgg1ElCOBsQEe66ocbBRlcN1+Ut38s4CrQN?=
 =?us-ascii?Q?H5QBW73I66D+fj2d/ADvltEWAiHMPXOR7B3CWOJHRkw1ppgRitzQTB4fg/tQ?=
 =?us-ascii?Q?ZTEaiLE8hJcXCgh8J2JgHzAox4KtQLaLc9ipsWcd1VNJulYPeCU2IcEG24Y9?=
 =?us-ascii?Q?VXQhEJgAL+vbMAUYuymSInXQ5tb0f1jp4mfVv6H75pQgJHWF7RbBCQkJvPcT?=
 =?us-ascii?Q?9KIcoRmnXIyNalr2YvXXc+LmexABTeHmbfSkxTEwAf6v0VOqO39m67zi1G2d?=
 =?us-ascii?Q?EDQTgWIL5w4+neSXrjfh4PUXtz3F3aoxoKTf/Vi8xzPmMVqpiceUu0R98n5u?=
 =?us-ascii?Q?yYZIITsNs4t3zzz6Pg5WMyYvBR2FpZY1XdAya9am0lUbGyTsd/1U3pYSETb/?=
 =?us-ascii?Q?vaidLKXrnySPbGdlricPnXJp0qz3HbpHipwTzx3ofznAMjwKA7hMn3FlO0FA?=
 =?us-ascii?Q?H/Soe7Be4hZpzTZ6zdXiVkY/J9mb6pW1Kv2hGJknsjcZzH6QkXXBDUrumMrs?=
 =?us-ascii?Q?Qc/5x/hYOcelElQZKhm2UHxD68n+PBIRZ7geCM6i9yPUqvbnpD5xJGr0eZ4+?=
 =?us-ascii?Q?1w/PIct95zlQdfTXD5tja2EB5LAI2hbPNyOI3o3IaQjT2M93czCp1Qf+2xCw?=
 =?us-ascii?Q?LHYWqXVYsjw39TsgscRcNfIWbvreSvtmR6itx/uvSRFhGxPrO6JCQMjpKHNf?=
 =?us-ascii?Q?HK/sH0hRHwJBkoJCWgKGqUGGf4mvpi6aEK9RjOrUWwarSfx76WSLzkxZaT+b?=
 =?us-ascii?Q?x5h3g82HPmlIburlJbGgDExZKnul4Ho+GeQDFC78dY6QIi1Cp25WWc6IsohY?=
 =?us-ascii?Q?K6WttDSj71bA0iv+XDCvYhSd25dMl0IBA0VznfTPTjNKb7NaRpYYDgz/BmxN?=
 =?us-ascii?Q?5k1aBA0hakIUAQ7n3o0iJnzpKECU9T1mcp0YhCp2pcoye8CRWzy9ber8KaAq?=
 =?us-ascii?Q?ccMWEVGcQpdz+GMIto21aAPCvetFYv5ipZrhNgLQ2pGoPGaOcQcW+w0PgMn/?=
 =?us-ascii?Q?7ZoRGqqALnkOhirOUIXiMPzc7fnJNuzP7nGEMDKnQAuExglyTVJacXFmhms+?=
 =?us-ascii?Q?ojnMvvO+NIGp8LOEqj2qBZwkLYylagHJui0YQ5Qq/bKAfuBsVNEjxz7TKlpQ?=
 =?us-ascii?Q?MhujEUtl2UFthlxp7OMIZRV7NkAVOIYNIJgrD+oKzAzvH8EkSc23t27h+CKC?=
 =?us-ascii?Q?KMax9kk5qMpXHQX6FNH1PjQYR24V3Eqq48Sy6i/mSmLKzDbUepYO/PhQDvER?=
 =?us-ascii?Q?AXyin63WUuUeAJrvqarKDLUyT7E4mKUwmt9f7TMwGM0aXH2tKDr2TlydFaAf?=
 =?us-ascii?Q?mBSbYdixSahgBtmG4lC4+zpX6s2VUHVwjn2E9iL3YJshYOQTLTMEsXQrpQi+?=
 =?us-ascii?Q?pKiKvkntqu2WlcP+pnt6mvWPIWy+KxfjqxwHXOmg/dw+QY8URXMAaxf/9o9X?=
 =?us-ascii?Q?gvSENvO2/6WgTitLt/Lm7mP+EF/cnCI0ETezw2jHFcc4gCkWGkw+XNvCMn94?=
 =?us-ascii?Q?54pM5xe7gj3Df0n+2S0=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2025 08:53:57.3502 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 39e8aa99-abbe-4962-2103-08de25b6d82d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF0000343C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9073
Received-SPF: permerror client-ip=2a01:111:f403:c10d::1;
 envelope-from=Honglei1.Huang@amd.com;
 helo=SN4PR2101CU001.outbound.protection.outlook.com
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

Fix error handling logic in virgl_cmd_resource_create_blob and improve
consistency across the codebase.

virtio_gpu_create_mapping_iov() returns 0 on success and negative values
on error, but the original code was incorrectly checking 'if (!ret)' for
error conditions.

Change all virtio_gpu_create_mapping_iov() error checks to use 'if (ret < 0)'
instead of 'if (ret != 0)', following the preferred QEMU coding convention
for functions that return 0 on success and negative on error. This makes
the return value convention immediately clear to code readers without
needing to look up the function definition.

Updated locations:
- hw/display/virtio-gpu-virgl.c: virgl_cmd_resource_create_blob()
- hw/display/virtio-gpu-virgl.c: virgl_cmd_resource_attach_backing()
- hw/display/virtio-gpu.c: virtio_gpu_resource_create_blob()
- hw/display/virtio-gpu.c: virtio_gpu_resource_attach_backing()

Changes since v2:
- Use 'if (ret < 0)' instead of 'if (ret != 0)' following maintainer's
  feedback on preferred QEMU coding style for error checking functions
  that return 0 on success and negative on error
- Updated all similar usages across virtio-gpu files for consistency
- Expanded scope from single function fix to codebase-wide style consistency

Fixes: 7c092f17ccee ("virtio-gpu: Handle resource blob commands")
Signed-off-by: Honglei Huang <honghuan@amd.com>
Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
---
 hw/display/virtio-gpu-virgl.c | 4 ++--
 hw/display/virtio-gpu.c       | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-virgl.c
index 94ddc01f91..6ebd9293e5 100644
--- a/hw/display/virtio-gpu-virgl.c
+++ b/hw/display/virtio-gpu-virgl.c
@@ -557,7 +557,7 @@ static void virgl_resource_attach_backing(VirtIOGPU *g,
 
     ret = virtio_gpu_create_mapping_iov(g, att_rb.nr_entries, sizeof(att_rb),
                                         cmd, NULL, &res_iovs, &res_niov);
-    if (ret != 0) {
+    if (ret < 0) {
         cmd->error = VIRTIO_GPU_RESP_ERR_UNSPEC;
         return;
     }
@@ -701,7 +701,7 @@ static void virgl_cmd_resource_create_blob(VirtIOGPU *g,
         ret = virtio_gpu_create_mapping_iov(g, cblob.nr_entries, sizeof(cblob),
                                             cmd, &res->base.addrs,
                                             &res->base.iov, &res->base.iov_cnt);
-        if (!ret) {
+        if (ret < 0) {
             cmd->error = VIRTIO_GPU_RESP_ERR_UNSPEC;
             return;
         }
diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
index 0a1a625b0e..1038c6a49f 100644
--- a/hw/display/virtio-gpu.c
+++ b/hw/display/virtio-gpu.c
@@ -352,7 +352,7 @@ static void virtio_gpu_resource_create_blob(VirtIOGPU *g,
     ret = virtio_gpu_create_mapping_iov(g, cblob.nr_entries, sizeof(cblob),
                                         cmd, &res->addrs, &res->iov,
                                         &res->iov_cnt);
-    if (ret != 0) {
+    if (ret < 0) {
         cmd->error = VIRTIO_GPU_RESP_ERR_UNSPEC;
         g_free(res);
         return;
@@ -931,7 +931,7 @@ virtio_gpu_resource_attach_backing(VirtIOGPU *g,
 
     ret = virtio_gpu_create_mapping_iov(g, ab.nr_entries, sizeof(ab), cmd,
                                         &res->addrs, &res->iov, &res->iov_cnt);
-    if (ret != 0) {
+    if (ret < 0) {
         cmd->error = VIRTIO_GPU_RESP_ERR_UNSPEC;
         return;
     }
-- 
2.34.1


