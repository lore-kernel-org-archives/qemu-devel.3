Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B838BD4A609
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Jan 2026 08:54:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgfWh-0005LO-RS; Fri, 16 Jan 2026 03:49:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Honglei1.Huang@amd.com>)
 id 1vgfWf-0005KV-RY
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 03:49:49 -0500
Received: from mail-westcentralusazon11010040.outbound.protection.outlook.com
 ([40.93.198.40] helo=CY7PR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Honglei1.Huang@amd.com>)
 id 1vgfWd-0006l5-Ho
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 03:49:49 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lca3vBuc3KXRe2OUS1UQp7GndOmvYzB3hstW6QWPdBXNtxZ/OsP4tdwdw5lgz9RnPOhRqKTHlS2/O9NixtAlLujaphkN6OFsNBwOGj3dJjDe0jPmfKVh6lAvc++sejscyVKiv4HOa9p+Wj/Cqg2XO4TrtKxf+RQFHTwRQ/rZBhG/FsKgt68wSTpN8CxPtGLXy/ZUigcuv81rennBBxiHtmFTU/Jqj0k5ytZVNpfD5Lx92AHWCTHIePBpOnaDwIObnGTQi/HDjR5PpbA4O0b8V0vmuQykwDRDD4G359bj6nTqOp27ee1qRy+DHcRhQY2asJw2jZ2CK5WfYg9k1ADsPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LCILyFXJRp68SbHxjGsc1WH1/xe0lFnQgRepQklgxsM=;
 b=exEoxs5l4rAQG/WWG76IylTVurTOzRAgsOVIA96hJwt9k281KTDiTvR8y1IMJsXgE1xpAj1hkPzQ79LTwM7ChX/xQjxlPnLtJ5Lx0Rp2WT06Pi1CMnkfoUlDda6NiOSxhk/dfW4WkmEBzs/0KTXQIdH2cy6bKG48uaSBVoq2hx+KNCDxw2Uk0njStmqhXQuQRO5JFrbULNLx+/81K+Gp8qfnmN93HqSYiUuTRUu5aeNuylDUh/fB7p8le3MpSeQDn8zt84JPWLH4zb78vGbBCCPLxYsmBXapnEAkhErWhVW6o1vjRXwgXjFa6JwnZaUZbzXXQ4m35tsK+Wib9RZFDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LCILyFXJRp68SbHxjGsc1WH1/xe0lFnQgRepQklgxsM=;
 b=aMU91o21SaoCQE0iiI0bVmkJu0ANCf5BipltV+TalHZJU3g3A1dP//EIPxx4k5UI0+V/YFpK+hmHUIpSAWk1nw0YOVIcB4BmovFbPg9EYYIjnqGZ9Wbqn+393xM8DOKp5CveXxNRUkUBKA+1ubuqvRFyXifOz1MbCeNoN96sdt0=
Received: from BN9PR03CA0498.namprd03.prod.outlook.com (2603:10b6:408:130::23)
 by BN7PPF62A0C9A68.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::6d2) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.6; Fri, 16 Jan
 2026 08:44:43 +0000
Received: from BN1PEPF0000468A.namprd05.prod.outlook.com
 (2603:10b6:408:130:cafe::c5) by BN9PR03CA0498.outlook.office365.com
 (2603:10b6:408:130::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.6 via Frontend Transport; Fri,
 16 Jan 2026 08:44:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF0000468A.mail.protection.outlook.com (10.167.243.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Fri, 16 Jan 2026 08:44:42 +0000
Received: from honglei-remote.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 16 Jan
 2026 02:44:31 -0600
From: Honglei Huang <honghuan@amd.com>
To: <alex.bennee@linaro.org>, <dmitry.osipenko@collabora.com>,
 <odaki@rsg.ci.i.u-tokyo.ac.jp>, <Ray.Huang@amd.com>
CC: <mst@redhat.com>, <cohuck@redhat.com>, <pbonzini@redhat.com>,
 <qemu-devel@nongnu.org>, <honghuan@amd.com>
Subject: [RFC v6 3/4] virtio-gpu: Update Linux headers to add ROCM capability
 set
Date: Fri, 16 Jan 2026 16:44:08 +0800
Message-ID: <20260116084409.326062-4-honghuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260116084409.326062-1-honghuan@amd.com>
References: <20260116084409.326062-1-honghuan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468A:EE_|BN7PPF62A0C9A68:EE_
X-MS-Office365-Filtering-Correlation-Id: ff26ce7b-f6ae-49c1-79f9-08de54db7e7c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ZOEYP3rLj2DzzgS6nED0qG7rYAWGhrXOLynH04RkPYw8RzdSaVddYm2HwJyH?=
 =?us-ascii?Q?jVPn0URzkvizkYvD9ANzGSJ9U1obWAN9s0hxBwkBtUBh1te7TG45A9fXS0Qk?=
 =?us-ascii?Q?6iD2Nubu0aoeztTw0AeOJzHfxDvUtvb12nkmfDXkyqtIgfo+3z+QLi3MusFD?=
 =?us-ascii?Q?6vKdsU67kE8fYr0dk15QEVlANruRseKIKkcPYc9EA4zv1Qp6fqOlfPhZx/wN?=
 =?us-ascii?Q?dQnSCZGmZ0QEPQ/ekvBl7nuW3kPRZQx1bWRe/C0rL5bMO2Z3XevnG0tmOeWN?=
 =?us-ascii?Q?z/26UHMdix2jATdzOLKnUHs8tIX8ik/cATYS+NgUkHqAR7MhWzHugw2IP7Un?=
 =?us-ascii?Q?X1/EvTYpNkY40HFzgWaFa6KLmV1slApuhlLGBBwODg61gkOmTAIYKF0Y+gZj?=
 =?us-ascii?Q?Otl8LVr5IAYkkxhe+Ok37aCyoV4mNpVvOE85BAeIl0uCeu4EdqU+u0DxxzF3?=
 =?us-ascii?Q?Ngl5vUW2Dw0herax99Hy8SslGEw8Gehd8vp85d93dYv/DwJB2Qf/tAgtNqNv?=
 =?us-ascii?Q?zEvzTlyZSf1LZm/p43e7d6lblTUTvpUxa6BqQ4GcxaKPiax0vZOAuClrZFvh?=
 =?us-ascii?Q?YqU6yzV6OEdo/CLcQUB7SZjT6TKwHg9A/EyydKYesHmADSVhQKaaCf5d0AF2?=
 =?us-ascii?Q?SXR1Mu0+UqVv5nu0QAUcXz+JyjBQuH3247k4CY8KJqPtGe12RdPkdVEsqqhv?=
 =?us-ascii?Q?6OrxOEDg6wyV2hzM6qjOhcKB5EyJkEZlekttNcnE9xwNLtNn1TzhQo8Qr6zo?=
 =?us-ascii?Q?kkgRY6aTxOwx6YBmVitfubAZSb+umfiPKI5lf8TLlmlmxkTiYHCFNATVpVS5?=
 =?us-ascii?Q?KUA7a9qX+sBaT9EjNUCT2TNYWn7qE0gkR7k5NbNeMT1GHDxP2cpKF7ippefx?=
 =?us-ascii?Q?S6pR+6PbW9RswdHcZIctUSyWBAGmxy1Ersacm839LnPYDX7fAHwzE3oNWwfl?=
 =?us-ascii?Q?njleb0I1/okF0Fthd8HXc5/zVmTFMXCnYQexGDGu6ndKbhDX9uk6V8q3Eqgu?=
 =?us-ascii?Q?vjsG0GfngSmiywNS9toBgYvUgQZCk7ztc9SbWSLYhEmarlF+ld0zLxZUJA7/?=
 =?us-ascii?Q?DHIt2Qzq/DDx7ScZAPwsUgyyPQdNCGdVWM/CG+KHHFuU1dUitZ3psgXBpOs7?=
 =?us-ascii?Q?wKF/sVWrOr9g+kxOVQbjYRQpy3NPSOe67j3mrHlNmE8Qmmi/EawJFj5chObu?=
 =?us-ascii?Q?xj5gM9eTJJgKrXjatflwbQJnyG8ZZpRpTv2Iz5rtnjHzUvmUdcSf8cmLDj8G?=
 =?us-ascii?Q?BF9tqIjAKmYGSBW+sNPpEYuXDluyAOmHaItdBhYP/nh433TkPrdwS0PnlACv?=
 =?us-ascii?Q?aQHRts+AiIl6RdJMySqcTwiTBv5G4PUjgMWCJYj87vTw+EVBEi6qz55I7IV0?=
 =?us-ascii?Q?E+2HJ8AFzPmBR8c4B3AH8/EnCGw1cba9wRVv6DGHKBuLHeiFHO1n57Q637e+?=
 =?us-ascii?Q?sgDjl7+3cG8MNfmG6Eps5DdMWCke25n/ViLH45yV0UZTiLw9eWUkd3Gf4BeJ?=
 =?us-ascii?Q?+RByfBkzb/Dwd5ICUQ3qQwbXKdVbdeY7ELQvDXUf97vUOMOhQSfnvBJo3f/l?=
 =?us-ascii?Q?FTUj2uKhn8M5EjTccuVUzrSHtHqc5/6/sMRgiKLVOyLYFhlavhaXgc5gzWU0?=
 =?us-ascii?Q?LPGKARpn/rsx2q7Yc9sjvyWyR79y2I+eP3Rehp7k7VixDPQKyapjEuxqB5EE?=
 =?us-ascii?Q?kxbOhQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2026 08:44:42.9413 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ff26ce7b-f6ae-49c1-79f9-08de54db7e7c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF0000468A.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPF62A0C9A68
Received-SPF: permerror client-ip=40.93.198.40;
 envelope-from=Honglei1.Huang@amd.com;
 helo=CY7PR03CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Update linux header same with the related linux patches.
kernel headers, which introduces:
- VIRTIO_GPU_CAPSET_ROCM capability set definition

Signed-off-by: Honglei Huang <honghuan@amd.com>
---
 include/standard-headers/linux/virtio_gpu.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/standard-headers/linux/virtio_gpu.h b/include/standard-headers/linux/virtio_gpu.h
index c40961bee5..f4f0a821ba 100644
--- a/include/standard-headers/linux/virtio_gpu.h
+++ b/include/standard-headers/linux/virtio_gpu.h
@@ -313,6 +313,7 @@ struct virtio_gpu_cmd_submit {
 #define VIRTIO_GPU_CAPSET_VENUS 4
 #define VIRTIO_GPU_CAPSET_CROSS_DOMAIN 5
 #define VIRTIO_GPU_CAPSET_DRM 6
+#define VIRTIO_GPU_CAPSET_ROCM 8
 
 /* VIRTIO_GPU_CMD_GET_CAPSET_INFO */
 struct virtio_gpu_get_capset_info {
-- 
2.34.1


