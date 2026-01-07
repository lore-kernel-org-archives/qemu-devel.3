Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 899B3CF6BF2
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Jan 2026 07:20:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdNpP-0007y2-BX; Wed, 07 Jan 2026 02:19:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Honglei1.Huang@amd.com>)
 id 1vdNpN-0007vL-6b
 for qemu-devel@nongnu.org; Wed, 07 Jan 2026 02:19:33 -0500
Received: from mail-southcentralusazlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c10d::3] helo=SN4PR0501CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Honglei1.Huang@amd.com>)
 id 1vdNpK-00048y-SM
 for qemu-devel@nongnu.org; Wed, 07 Jan 2026 02:19:32 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h2kQfnz7elrGoc6uYlvUv+7a3DSsxUnt6nwRwnIaftn8JOAMeeBfD7lkXYLREg0yt6U4mLzrZq6UH3QNEoG2FAXDKQmm3fm6yBXGbI7Qr/0qwNhdgzhccR+AKU6WmaFeA4UTfMaba+sVgysntZul3U1+C29gqbwnpzXietRviGB5Pg0F9B3XotW6hqa0nEj7e7zV0E8U3Yk4WtQqZ6wFg4I/sZpzCONnfaWc10mq8K4xkUUsd9ZQB6InPIX7yroMVcUcK3Y0XBq3sG2HFIUGq0iQZE4PM63nJIsshK3BbO3Ocux4cdMiFJpd2dQ4l8lDQm9mHs82E7NLl/H4PPG9jA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=plcG1Zgk8gZcgXqp0Uf8sV7mQnm9tsaogalN4N03Mb8=;
 b=mPiIUBkFSa1UcOKJ5YNSUg2d29npQ27zfWgbDhuwvTJlmx5pRu5I+Um3IHOQmsFqrPZtijX0qVc2pcG5p0Dskv+YOj+KuEZFAoHH1t9tkqZHkxTEn82jx66MMrlWqIphWIWUpIzukiVvQGn8paEKNGmcSmzyrmPLbkJZXg6Ylr2+BmlZQx6dQ9DMFazHN+F0WIu+Y2XX3LNGxK93sXY74TJk1HRlng2/FoqPH5RdTrUehlRMmKRJ3hFzCOFEWOWmpe3DTvmiQpDcwEAnguoSxmdmYPkaakcm927++F+3LBUTo4a8qe4m7Cu5n/PxoJkBKshkFQf64B9qM1v9j73uEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=plcG1Zgk8gZcgXqp0Uf8sV7mQnm9tsaogalN4N03Mb8=;
 b=qsb4a1C4NnmTIVKHRw2zql4mYwG5yEJn3xXhqrOQ6ayir76DKFHIX1p4PVLUIznkhvCbM6YQsACuNIp+5JZMiOg26rPwRusv+aKiAUFlgbcBbrlBLt+XbTLUQ1a3Z9LRvT+s1bAFPItyyAY+JYRf5sSNwj+yhMiyezotgDmDQfk=
Received: from BYAPR05CA0011.namprd05.prod.outlook.com (2603:10b6:a03:c0::24)
 by IA1PR12MB7568.namprd12.prod.outlook.com (2603:10b6:208:42c::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Wed, 7 Jan
 2026 07:19:23 +0000
Received: from SJ5PEPF000001ED.namprd05.prod.outlook.com
 (2603:10b6:a03:c0:cafe::6d) by BYAPR05CA0011.outlook.office365.com
 (2603:10b6:a03:c0::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.1 via Frontend Transport; Wed, 7
 Jan 2026 07:19:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001ED.mail.protection.outlook.com (10.167.242.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9499.1 via Frontend Transport; Wed, 7 Jan 2026 07:19:22 +0000
Received: from honglei-remote.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 7 Jan
 2026 01:19:19 -0600
From: Honglei Huang <honghuan@amd.com>
To: <alex.bennee@linaro.org>, <dmitry.osipenko@collabora.com>,
 <odaki@rsg.ci.i.u-tokyo.ac.jp>, <Ray.Huang@amd.com>
CC: <mst@redhat.com>, <cohuck@redhat.com>, <pbonzini@redhat.com>,
 <qemu-devel@nongnu.org>, <honghuan@amd.com>
Subject: [PATCH v3 1/3] virtio-gpu: Add support for
 VIRTIO_GPU_BLOB_FLAG_USE_USERPTR flag
Date: Wed, 7 Jan 2026 15:18:56 +0800
Message-ID: <20260107071858.3452614-2-honghuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260107071858.3452614-1-honghuan@amd.com>
References: <20260107071858.3452614-1-honghuan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001ED:EE_|IA1PR12MB7568:EE_
X-MS-Office365-Filtering-Correlation-Id: b3de3ce1-d44c-4893-3b10-08de4dbd14da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?uBEmGLtXEfN5RY5tW6llYa/oCZUpu5BsYMlLNCS5v0un4/BQ9XI0SWoNaEl9?=
 =?us-ascii?Q?Sf9JN6z5kxF1xpD6rXYKld1qOuQz3+VNtj7wnBjQL4v9AXWLuz966jNKaAPF?=
 =?us-ascii?Q?2mRhMlJ4WitG+bBFwdWEkACveY6kBOpSbKP0JNVeuzqjjMG6v6qYrRh4JWOd?=
 =?us-ascii?Q?Iii4LSIBZhvDBJQmZbXYC3NPUX59sYKMb0TdMfTVhfzJlcC6i137OGka3tiM?=
 =?us-ascii?Q?cthlVLTf3HjKTP0/khLeNkLp0AC3h6W7STfguTmBIuACTT5ejptSi3sUs2+2?=
 =?us-ascii?Q?2zBA0KkzvkUggzRJSO8loUtqGWsqG0BQ/XGJ1lLNK227bID1BNNxSP4kfL97?=
 =?us-ascii?Q?eziQDa0SIwCg7OgtTlt1pTWPGqZx1ver7RI74FEEFbyQGzleXLpVko55GZNQ?=
 =?us-ascii?Q?9DOZezUDLOalb/Rp0rnTzEQOCglwulMX2UWGjrfb3jfo6z9/xgu0aFOpNksQ?=
 =?us-ascii?Q?1ENvvRZ116i54T/BHLN5Iajif/Tor16QtVJD+S3S+pYPZ0HK3yvw1RG5gV0l?=
 =?us-ascii?Q?aGEaKwl5EJojehU5gfxiK0vQYvebAGiUK2tWKe3eoIRYAB9YWhxBZDzPbnN3?=
 =?us-ascii?Q?IHkbfZzYyqJYcEyoDCFgYV8Va60ahlLkxQm+iLqgkEFiDJBchpZNxWgYTGhU?=
 =?us-ascii?Q?v6XYCalaDAkXqnSpTP6aiPyneao3mE+1SJVrvKMlFiEwkKBfkQzekE/0uAR+?=
 =?us-ascii?Q?SpjutdXqzl/voujWVFtyH8/NHncHeT2b2RHnxG9PgKHkCU1cGnwlb40XtKlB?=
 =?us-ascii?Q?SlkCaBSk208Qzp+4rqqLwgLtJryFlt2H1Wmq9DlFgUgtYNY8CzVt/0z5eESr?=
 =?us-ascii?Q?j3qlf1K5HDA3lbkaSmXLYNrS5G04V80YLiKd78Vu2FOWizWnSdk6jgvvaFcM?=
 =?us-ascii?Q?1bCMP1GwGD2t/AdX+rN1Sh2Z9VjKjFKnZ/FMbH581d6ALS4GOmCQVlcP9kEA?=
 =?us-ascii?Q?X+fcrqvNytC7WiZOV1covIX+PPn413K1ZjxFrR3vxLYdiYcDdrih5VFIQfIG?=
 =?us-ascii?Q?Y7PpY1ZsFjuHQiDD452eGG6HGVkRG89Qyt+mkjULPZ2/uNRg26B6IpABiSAM?=
 =?us-ascii?Q?A727PLiHXqZxM78TWivwDarDvDYaR57uO9WGIMCJ646HaICGBH0eeFDqBJ8s?=
 =?us-ascii?Q?rvqqFwjOgJOF921cH19GyvSQYEysx/3pAj3TnL4yJU/DgPdE/36oG9N30ZV2?=
 =?us-ascii?Q?a/iViZw8tektSCRnhKwbl2rkC6QSUvV6JGJi2mhRB4UiSouVL1iv+IM7zt0h?=
 =?us-ascii?Q?fvLxAVjNaBxZtMWKPXdv+3FFze63ZgSoqsQJBkMpKBXXJ7lrnxju4sDgMkpO?=
 =?us-ascii?Q?2VX+CDKODjaVebigi25Ewn5FKudtBGrH5CqnD5vHI1rsx782h16Eq6Q52UGK?=
 =?us-ascii?Q?LavE9PvtOaRm9TUMl1taRrcHqptTcKsV+MhSapIcyDlRNM7SJOk462XIZyMQ?=
 =?us-ascii?Q?LIw7WmEfXSbp7LMjbWNn/ssFqjfXMovAyxh7Da4v1pKKi5SX94fIfr936Jo5?=
 =?us-ascii?Q?xvUyqF5FC/8tKGd0B1gquK7x6o90dap8+GofSWLZM1sypTJ9SMQl9cOaB+iI?=
 =?us-ascii?Q?47GqupplG1bbk7ivg2Y=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2026 07:19:22.5848 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b3de3ce1-d44c-4893-3b10-08de4dbd14da
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001ED.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7568
Received-SPF: permerror client-ip=2a01:111:f403:c10d::3;
 envelope-from=Honglei1.Huang@amd.com;
 helo=SN4PR0501CU005.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Add support for the USE_USERPTR blob flag in virtio-gpu to enable
user pointer mapping for blob resources. This allows guest applications
to use user-allocated memory for GPU resources more efficiently.

Changes include:
- Add VIRTIO_GPU_BLOB_FLAG_USE_USERPTR flag definition
- Enhance blob resource creation to handle userptr flag properly
- Remove arbitrary nr_entries limit (16384) in mapping creation
- Add conditional handling for userptr vs regular blob mapping
- Support guest_blob_mapped parameter for virgl renderer
- Fix value check issue in virtio-gpu

This enables more flexible memory management between guest and host
for GPU virtualization scenarios.

Signed-off-by: Honglei Huang <honghuan@amd.com>
---
 hw/display/virtio-gpu.c                     | 7 -------
 include/standard-headers/linux/virtio_gpu.h | 1 +
 2 files changed, 1 insertion(+), 7 deletions(-)

diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
index 643e91ca2a..17df148920 100644
--- a/hw/display/virtio-gpu.c
+++ b/hw/display/virtio-gpu.c
@@ -808,13 +808,6 @@ int virtio_gpu_create_mapping_iov(VirtIOGPU *g,
     size_t esize, s;
     int e, v;
 
-    if (nr_entries > 16384) {
-        qemu_log_mask(LOG_GUEST_ERROR,
-                      "%s: nr_entries is too big (%d > 16384)\n",
-                      __func__, nr_entries);
-        return -1;
-    }
-
     esize = sizeof(*ents) * nr_entries;
     ents = g_malloc(esize);
     s = iov_to_buf(cmd->elem.out_sg, cmd->elem.out_num,
diff --git a/include/standard-headers/linux/virtio_gpu.h b/include/standard-headers/linux/virtio_gpu.h
index 00cd3f04af..b85e781a2d 100644
--- a/include/standard-headers/linux/virtio_gpu.h
+++ b/include/standard-headers/linux/virtio_gpu.h
@@ -405,6 +405,7 @@ struct virtio_gpu_resource_create_blob {
 #define VIRTIO_GPU_BLOB_FLAG_USE_MAPPABLE     0x0001
 #define VIRTIO_GPU_BLOB_FLAG_USE_SHAREABLE    0x0002
 #define VIRTIO_GPU_BLOB_FLAG_USE_CROSS_DEVICE 0x0004
+#define VIRTIO_GPU_BLOB_FLAG_USE_USERPTR      0x0008
 	/* zero is invalid blob mem */
 	uint32_t blob_mem;
 	uint32_t blob_flags;
-- 
2.34.1


