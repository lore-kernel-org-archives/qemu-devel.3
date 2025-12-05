Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E45AD374AE
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Dec 2025 22:38:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vReR2-0005GD-Mb; Fri, 05 Dec 2025 17:37:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luqmaan.Irshad@amd.com>)
 id 1vRax2-0005AB-9X
 for qemu-devel@nongnu.org; Fri, 05 Dec 2025 13:54:44 -0500
Received: from mail-eastusazon11012032.outbound.protection.outlook.com
 ([52.101.53.32] helo=BL0PR03CU003.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luqmaan.Irshad@amd.com>)
 id 1vRax0-00061Q-AQ
 for qemu-devel@nongnu.org; Fri, 05 Dec 2025 13:54:44 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=or0afTMiJJEyUTCMEnKv4PRl1WVkX8R59dZX1XDAK1iFPkrlzgKlogL5TnaPlIa3mVZxj4S9ReRWJ2bZfxsdiVvOwnIyK1iCjdlgmkueuStWzEs6doBhhEdTO/tpfTxCdQmsmPgnOKSVD7Ur5LG9VRQKkyp2SyCoeWSxgBNXbTmJz4SRfWmIyyJwaDMPieIMequqyfQJ8lqaP57LchYPsOxUVVZYb19vDYj64zQ6CTaXcYi0lNX9jOL2gLxTXCa4o65mXxUmS1ZFdSZ+rD1TBYwrgTB2mgeI3fxit0pCw8Tm5r0oRnmevk7pAAHApljysXotkgqohIq2NBpbw8T4fQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oiMfZZXtegjX3KMZjq26ugN++BLtImNow2BgB7D8UHs=;
 b=e9VvR3rnLNB9Pk3gNO5S6x3gT4DvMhxeuQE6MgZH8EYr2CtY/QoT8VtRyZanotdTxCi+mywO44/A7NYNgIf4btyu6pKDt7PWEDxyMf6b3R2EQmcPeWx1PDwecQepq7EcXxp2CpjSUi6YxDW1JMdZLIi9e5+yQEUEIzykA9iYb6FFHS7o58i9JlK1a8YKClCz6/XWbpeIDcM3wDKITDHb9AFUIwDukrHcjP3WMcoXybISKHJ1APVlLVVdv40EfnUQzPot+bdBHfc43M/57MWUI21Jwg96evWKZBLh4lrFqM3PyYDEN0hiEbf3h2+myt7HjMohkwMpR7EZLJkAMTVgZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oiMfZZXtegjX3KMZjq26ugN++BLtImNow2BgB7D8UHs=;
 b=rDQx9/VGyAn9cN5fDC1KCJhte3mYK+0jQBmtegqyggYjiTRSN91Yz87AHkDd8Jww9s2mo/37/jubulmCYSpcjSszUrabH84hCALuFMkwxFgz77KVgwOcCqR0PU1VDCVUJec56Se6IHKXz3hZM+UILI50r8uqFTrI+wJE9CXD7HQ=
Received: from DM6PR11CA0064.namprd11.prod.outlook.com (2603:10b6:5:14c::41)
 by IA0PR12MB8303.namprd12.prod.outlook.com (2603:10b6:208:3de::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.12; Fri, 5 Dec
 2025 18:49:35 +0000
Received: from DS3PEPF000099DD.namprd04.prod.outlook.com
 (2603:10b6:5:14c:cafe::bc) by DM6PR11CA0064.outlook.office365.com
 (2603:10b6:5:14c::41) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9388.9 via Frontend Transport; Fri, 5
 Dec 2025 18:49:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS3PEPF000099DD.mail.protection.outlook.com (10.167.17.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9412.4 via Frontend Transport; Fri, 5 Dec 2025 18:49:34 +0000
Received: from luirshad-ubuntu-laptop.phub.net.cable.rogers.com
 (10.180.168.240) by satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 5 Dec 2025 12:49:31 -0600
From: Luqmaan Irshad <luirshad@amd.com>
To: <qemu-devel@nongnu.org>
CC: <mst@redhat.com>, <alex.bennee@linaro.org>,
 <odaki@rsg.ci.i.u-tokyo.ac.jp>, <dmitry.osipenko@collabora.com>,
 <pierre-eric.pelloux-prayer@amd.com>, <luckmaan21@gmail.com>, Luqmaan Irshad
 <luirshad@amd.com>
Subject: [PATCH] virtio-gpu: create drm fd based on specified render node path
Date: Fri, 5 Dec 2025 13:49:06 -0500
Message-ID: <20251205184906.110927-1-luirshad@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DD:EE_|IA0PR12MB8303:EE_
X-MS-Office365-Filtering-Correlation-Id: c3deb754-d789-4502-647c-08de342f08af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?rZWSTwGR5umQ2TZ4rpQvvuwu4dPKd8DV+BIIWy/2TyL052jIRac3LmY6VZzK?=
 =?us-ascii?Q?JfylfPjz5bXf8Hss5XfGrqd+oXonaFtC2J1vJiXsF0ww+3yiO2Gj9P34sulr?=
 =?us-ascii?Q?2Uk+y5x4ly1EjxFT0dga8FwdJ5S3RLkGC/GaD4/vRMQ4MvpoBRS3ZfIWMsut?=
 =?us-ascii?Q?wtdIkAwn0ln3HMfqW682AspzPMtD5dQ/tpjsoHXsS3qO4hh3yXZfp6CeaFOa?=
 =?us-ascii?Q?VEi+7I/nYv3SThzYZ9JiuDGE/nVKH4/o+lMK2+RiiPpgbZaNv64cdE74xL3V?=
 =?us-ascii?Q?0xYXoj74h+ftPSHKwxMl2ox+j8YjZuCs+3VI9Ml2R1TpqAQ+Ug3kEqiZgzmz?=
 =?us-ascii?Q?lARqUtKmBxKPXsMjmfPabcWA44M2VTOPL2Q+Mg/QF29id+3tLFPUjDzih+rO?=
 =?us-ascii?Q?247g4f6El9HtCseX04sWasCCYMPEIqdEl1TKus6NXlRKLcuNTpH5f9jpaDpG?=
 =?us-ascii?Q?T0YZZaZQXr0Kdd1SjgErUNjEeV5QMEdaSjs+kqoO78WzR2N4oEXdAksW7PLi?=
 =?us-ascii?Q?D0cicWnoNRlLwYx/1NSkcxPpXpd6g8xct2LLp08CtvE7EJHdeoTtOxnElPjd?=
 =?us-ascii?Q?A5DuohPSwRlTOLTx+k5bF3JRprXwCLCCC3VWvW8V9syCsobm21IvZa2kVB2K?=
 =?us-ascii?Q?gUxIEdKjOYI0l2yu/GH32hAX13H4z82OWitf79TdAyJDoML8iM53WOFb4GT6?=
 =?us-ascii?Q?u0GGl+bpicByK3u7NVsP7QnwMLdSCGoBNXgidl773CgqfNY2ufBgQln8duoS?=
 =?us-ascii?Q?WfL8GUPtZ/63cSAmFF46CER+uGuB8KC4y1Pvr51YmxdMAA5oigQJlCXV3vyV?=
 =?us-ascii?Q?YKO/kN+kqeVAdrNmSExdTgTw1JHLp7f5dM5v1Je9sAddRtAyKlZuh9yg0czL?=
 =?us-ascii?Q?0rX/M0lbbFw08Qg4S3OFGweAwjZXGvz4QFePitH1+M2B5fyJnJMf031O3S+D?=
 =?us-ascii?Q?j93AVwGoOwNuXWQz/Evm9Zr3C8ir8ccOwXtIWtHH7xNEDSO3gAE1QA1/Afci?=
 =?us-ascii?Q?NqcaxpfZHJ2YC8FG/ENxjQugJALTmFGKwgk/HEok3NCBgcJKsX0/X9uCTn5Y?=
 =?us-ascii?Q?SVM8C8bAEQWj4WIJXlSdmRQZrpFjLej/3dXvnbBE7vGudKal/JziKVcRnzT6?=
 =?us-ascii?Q?zLCQ47DzZ/KbRHsuTEdnCoo6WVFyrCUKtLIA5VtM4oggj8JzhZ5i+PWVCbmX?=
 =?us-ascii?Q?lYqUonn8JtF6JLlCztk0wSpFHpDV8Txgy4n09XusaXS2Cn9Rab+uPJDcajmg?=
 =?us-ascii?Q?rO8w/cbAsZSoGplNUdvaGr+2v0Mw9OAed3Sz/UoBdqitSE4I8E+9umG553pU?=
 =?us-ascii?Q?WgQpXlG8LWre7kSIaf4dTE5/SDCZeMH49Um+qF/JcaVVokBYqE084GbrNu/8?=
 =?us-ascii?Q?ORU2JVnOFrjg3a8NdETnjsw7DeQastSkoEkLO1uHa6G6TZFahdG3HqiMeeYw?=
 =?us-ascii?Q?s9XQXeAO5ajkGzVhJYpPZVxNwv5vbCIRHcSM286YrVOtw5NAfOUNrTCPyyH9?=
 =?us-ascii?Q?8dVUV+LN5KfjHqMrd8S6d68VvABqCqB4KR1X8KnonrVHcrxScEJBIZEahCft?=
 =?us-ascii?Q?NgK1XkrnbqdFH+t0AZM=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2025 18:49:34.6596 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c3deb754-d789-4502-647c-08de342f08af
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099DD.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8303
Received-SPF: permerror client-ip=52.101.53.32;
 envelope-from=Luqmaan.Irshad@amd.com;
 helo=BL0PR03CU003.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 05 Dec 2025 17:37:55 -0500
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

Added a special callback function called virtio_get_drm_fd to create
a render node based on the path specified by the user via QEMU command
line.  This function is called during the virglrenderer callback sequence
where we specify the get_drm_fd function pointer to call back our
new function, allowing us to pass the fd of our created render node.

Based-on: 20251116125641.2255794-1-dmitry.osipenko@collabora.com

Signed-off-by: Luqmaan Irshad <luirshad@amd.com>
---
 hw/display/virtio-gpu-gl.c     |  4 ++++
 hw/display/virtio-gpu-virgl.c  | 17 ++++++++++++++++-
 include/hw/virtio/virtio-gpu.h |  1 +
 3 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/hw/display/virtio-gpu-gl.c b/hw/display/virtio-gpu-gl.c
index b640900fc6..c0587929e4 100644
--- a/hw/display/virtio-gpu-gl.c
+++ b/hw/display/virtio-gpu-gl.c
@@ -161,6 +161,10 @@ static const Property virtio_gpu_gl_properties[] = {
                     VIRTIO_GPU_FLAG_VENUS_ENABLED, false),
     DEFINE_PROP_BIT("drm_native_context", VirtIOGPU, parent_obj.conf.flags,
                     VIRTIO_GPU_FLAG_DRM_ENABLED, false),
+#if VIRGL_RENDERER_CALLBACKS_VERSION >= 2s
+    DEFINE_PROP_STRING("drm_render_node", VirtIOGPU,
+                       parent_obj.drm_render_node),
+#endif
 };
 
 static void virtio_gpu_gl_device_unrealize(DeviceState *qdev)
diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-virgl.c
index 6ad3b46066..c271194260 100644
--- a/hw/display/virtio-gpu-virgl.c
+++ b/hw/display/virtio-gpu-virgl.c
@@ -1016,6 +1016,15 @@ void virtio_gpu_virgl_process_cmd(VirtIOGPU *g,
     }
 }
 
+#if VIRGL_RENDERER_CALLBACKS_VERSION >= 2
+static int virtio_get_drm_fd(void *opaque)
+{
+    VirtIOGPU *g = opaque;
+    int fd = open(g->parent_obj.drm_render_node, O_RDWR);
+    return fd;
+}
+#endif
+
 static void virgl_write_fence(void *opaque, uint32_t fence)
 {
     VirtIOGPU *g = opaque;
@@ -1300,7 +1309,13 @@ int virtio_gpu_virgl_init(VirtIOGPU *g)
     }
     if (virtio_gpu_drm_enabled(g->parent_obj.conf)) {
         flags |= VIRGL_RENDERER_DRM;
-
+#if VIRGL_RENDERER_CALLBACKS_VERSION >= 2
+        if (g->parent_obj.drm_render_node) {
+            if (virtio_gpu_3d_cbs.version < 2)
+                virtio_gpu_3d_cbs.version = 2;
+            virtio_gpu_3d_cbs.get_drm_fd = virtio_get_drm_fd;
+        }
+#endif
         if (!(flags & VIRGL_RENDERER_ASYNC_FENCE_CB)) {
             /*
              * Virglrenderer skips enabling DRM context support without
diff --git a/include/hw/virtio/virtio-gpu.h b/include/hw/virtio/virtio-gpu.h
index a4963508a4..aba8343848 100644
--- a/include/hw/virtio/virtio-gpu.h
+++ b/include/hw/virtio/virtio-gpu.h
@@ -152,6 +152,7 @@ struct VirtIOGPUBase {
     struct virtio_gpu_base_conf conf;
     struct virtio_gpu_config virtio_config;
     const GraphicHwOps *hw_ops;
+    char *drm_render_node;
 
     int renderer_blocked;
     int enable;
-- 
2.43.0


