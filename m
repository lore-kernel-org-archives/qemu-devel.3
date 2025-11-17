Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA5B5CEACEF
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Nov 2025 05:57:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vKsEH-0002nW-IP; Mon, 17 Nov 2025 00:56:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Honglei1.Huang@amd.com>)
 id 1vKsEF-0002mY-Rv
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 00:56:43 -0500
Received: from mail-eastusazon11011010.outbound.protection.outlook.com
 ([52.101.52.10] helo=BL2PR02CU003.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Honglei1.Huang@amd.com>)
 id 1vKsED-0006DK-Rm
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 00:56:43 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aaaQRXHai0uPzfTB9pvANGH40rOD8Dkv3V1875dC9vUvnMlmNytBO3wIdw7RKibGweZfiHBF5yPUX9BAe+/tRJzeoX2iVzD2QgP8VmP1I91e2AOADBuFHYtlRfH1gcRm8ZWmwzipGJZ9tWs9kEspPcyjyLvL1OaArLOy94pZrjp1THnuwihEiMoEGZvwaO4pW9ud/OKJSW36L3quojLTzNaSbtypBFHb56axSghURf2Tj7KGvA4pfJM1PtPou/x2X/8kfXTjbI7aCeeDhetGKzwnCbb1xnY7fklHabvNjQpnV+NZC1zySQvALsUgnUs+rMespEZpZjHF10L3MdkrYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=igDiKbQQ5D5R0mAyAbw09aoOUYFI+OPKAxqBaafkLE4=;
 b=l3fbvhhV/Me+CZZE1ndxuuSiSXTaz97f03reoy3lQ65j8Apy1Xy4dmF/Fmek9RWARDC5hbgd1K9ZEKvZf7au02rb2flrhf9uY3z/NrNYa+0hOL2oW2krkgVM3er6CkwGWjdXUu6JmdAIEpHZum7Lxf6e30oTGpRLEvXYk0i3jo4MOnBucgltdCZrIrQHBeFoUTivJGb8qo9jvL8oL4vHUM5g6SOMDbnCslxd2IYpiuk3LlmOd7hYnaKTAlQFnxpKy3gj7DZp7yURO2hNAF+L/XRTfRI7hZJQVBNTTL9ZSfOniZvGlrvTQF09jBPeqzSB3JYDXZqqh3n4nAZIXixN0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=igDiKbQQ5D5R0mAyAbw09aoOUYFI+OPKAxqBaafkLE4=;
 b=dSmJzsmKEMJ2Btw06cOeLlX8wFJezLqpdrwizuiIuEim5dmzjjOoBMcRMTOAFlaiKDYGIjVW78PnADzV2pfBbElCMXStchl9+u+pDGNGVCiwB9CLI15Lr6DVbxHuDSbU+rHAHKSj5pkln/bpPZmUIs88sPL7dfgQn2xUXk9j/UU=
Received: from CH0PR03CA0288.namprd03.prod.outlook.com (2603:10b6:610:e6::23)
 by SA0PR12MB4432.namprd12.prod.outlook.com (2603:10b6:806:98::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.19; Mon, 17 Nov
 2025 05:51:34 +0000
Received: from DS3PEPF000099D3.namprd04.prod.outlook.com
 (2603:10b6:610:e6:cafe::dd) by CH0PR03CA0288.outlook.office365.com
 (2603:10b6:610:e6::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.22 via Frontend Transport; Mon,
 17 Nov 2025 05:51:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS3PEPF000099D3.mail.protection.outlook.com (10.167.17.4) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Mon, 17 Nov 2025 05:51:33 +0000
Received: from honglei-remote.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Sun, 16 Nov
 2025 21:51:30 -0800
From: Honglei Huang <honghuan@amd.com>
To: <alex.bennee@linaro.org>, <dmitry.osipenko@collabora.com>
CC: <odaki@rsg.ci.i.u-tokyo.ac.jp>, <mst@redhat.com>, <cohuck@redhat.com>,
 <pbonzini@redhat.com>, <qemu-devel@nongnu.org>, <Ray.Huang@amd.com>, "Honglei
 Huang" <honghuan@amd.com>
Subject: [PATCH] virtio-gpu-virgl: fix error handling in
 virgl_cmd_resource_create_blob
Date: Mon, 17 Nov 2025 13:51:12 +0800
Message-ID: <20251117055112.99046-1-honghuan@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D3:EE_|SA0PR12MB4432:EE_
X-MS-Office365-Filtering-Correlation-Id: f3c3575d-2f90-426f-eeae-08de259d5d0f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?XyLra6SV/wxnVYaiCEVRgVzL3GDFVZYX3bWLEd2G5et175kyj14IOgRqUE/s?=
 =?us-ascii?Q?opDXfwfvPizlouFwMqxkiMrlUMMT+sZFWDPNAQscr5HbEqtpYABB+1LzB3Q5?=
 =?us-ascii?Q?NJKLEBKoWaFCfyxcvRhWbmLpFhuErWwwFcLcHlKZBQbou80tnr3+EKTEC6Qa?=
 =?us-ascii?Q?rdsAJoMw/IK7sjvdCBy3VeK7S+4v3ggpC1JOdGFFrZ2EMmIc82Qy3n5W8V4K?=
 =?us-ascii?Q?KKDsgzTTkE6wEnw85wGfiN8vjbKpEBbS7Rq49Hc8IHno4mxwN9/4elYfac3P?=
 =?us-ascii?Q?hWFMxEnMbEdSvdjQbHFb9nEq+EKpSM6OMruJOOHnA7Nuza+smwMNpSUa5NtN?=
 =?us-ascii?Q?scvjy+aaychwtEFJRoTJx+j/sMzyDVD6ejGqcxAprcht2hh1q4Gx9yq3cAtZ?=
 =?us-ascii?Q?7JvbT5RFBAhYHiw4GWY6Il2X8aeuQunJjLo7nsL9p8dZzWne6TjNUmIxS0E/?=
 =?us-ascii?Q?iQeQlgvg/eRV1YgAfdlDpSQYxQ9hXdaVEVXUNRdKTXI1/L1KQqXSOvJ8omnN?=
 =?us-ascii?Q?H1ds4cSG5CrMs43HPP0W/Ey1SDTpCu7Eeba+yBazdiDRC5kV3yYUERRomWsr?=
 =?us-ascii?Q?N+z3bYUI3fznkzAUmWWKwJsFVuCfCx6Uhao44HQEFmMy3bHGqkRAqm6htGUl?=
 =?us-ascii?Q?VYxBofb/NDeoEwQ46Tz0nopWA+zgYWL8VYJ9i0eCINFRqhN1Xfwb6rRjoIDr?=
 =?us-ascii?Q?B5b7WbaB/aTtFuYL0jLltk69SSaISc6IOf5JYJKJEEnuZKW4ZiAGMBnEIUEG?=
 =?us-ascii?Q?PL+mpFEFKfOJcHtnKDOKHI+3/DzVnw3A9DPmHitJbKGMc8tIdkglMo+c3DGx?=
 =?us-ascii?Q?tDC4JCe3k5lE01KRYpO2P7WfKWlgp+ZotX9i9HrUHQlpoddQd3Re44lv338h?=
 =?us-ascii?Q?UbiKne5ItoRRn5+8BTzcC8dKJiXxoDbvyRaMfIQu4Gr3+Bt0qbM4RViPKnaW?=
 =?us-ascii?Q?nkE+9whdlj9c1GX8ia0QC3yHVfzmqDyLB1L1g1omi19sdShiMUNGRGZjZbCz?=
 =?us-ascii?Q?5kt2eXiwfDw1MrGiVh0jXVtT3rHHxjB/91S6l7FfK9+Ia5+Gc3rt1bL1p+OK?=
 =?us-ascii?Q?4c5AoKSRU6EaOlqFBe86ai+9BLPl95gSEOgBiivk8QJlaWUeoQLW3xgzugLd?=
 =?us-ascii?Q?OQMIXx1Qsi1eD9zexVVGSXWiy1mz4ohSuv7DakwX9k6XtGVUxkjDySfkIyd2?=
 =?us-ascii?Q?N3P/Ueuo0QTYeUnUtW94MGMzLYfpdDsVQIdZvGikOGgdKQmyotqv85cbrEwP?=
 =?us-ascii?Q?+n2r4K+/BClLOwNN+vqk7tURG6q24jKjmvjBe/VEqNbjf4GUk1RY4Fo3tRem?=
 =?us-ascii?Q?r7HQkFpSZ/QPIQnxj2Y3nOcu6TsbN6glT6wipxw6apr+/y9utD7f8tEUp7KP?=
 =?us-ascii?Q?XRXB7iw2ShmS9LwlJOTnbipPEO78XYS4Bx4TxmQ+xe3tODjVMiA3d3inVXkf?=
 =?us-ascii?Q?X9IuSayiX1jbIGWCfxVD+jDkFD46+Dfa19RpAQFj5wdG735stOS4m1Kscq6I?=
 =?us-ascii?Q?t/FNQml0qLR++As3XBAyjYeHOFXN7HHbGd0f8K0oK0lE0UYAJFXEaYGOjcqG?=
 =?us-ascii?Q?ttrEIv4U4AjHjG+BHhM=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2025 05:51:33.3820 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f3c3575d-2f90-426f-eeae-08de259d5d0f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099D3.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4432
Received-SPF: permerror client-ip=52.101.52.10;
 envelope-from=Honglei1.Huang@amd.com;
 helo=BL2PR02CU003.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

The error handling logic was incorrect in virgl_cmd_resource_create_blob.
virtio_gpu_create_mapping_iov() returns 0 on success and non-zero on 
failure, but the code was checking whether to set the error response.

The fix changes the condition from 'if (!ret)' to 'if (ret != 0)' to
properly handle the return value, consistent with other usage patterns
in the same codebase (see virtio-gpu.c:932 and virtio-gpu.c:354).

Signed-off-by: Honglei Huang <honghuan@amd.com>
---
 hw/display/virtio-gpu-virgl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-virgl.c
index 94ddc01f91..e60e1059df 100644
--- a/hw/display/virtio-gpu-virgl.c
+++ b/hw/display/virtio-gpu-virgl.c
@@ -701,7 +701,7 @@ static void virgl_cmd_resource_create_blob(VirtIOGPU *g,
         ret = virtio_gpu_create_mapping_iov(g, cblob.nr_entries, sizeof(cblob),
                                             cmd, &res->base.addrs,
                                             &res->base.iov, &res->base.iov_cnt);
-        if (!ret) {
+        if (ret != 0) {
             cmd->error = VIRTIO_GPU_RESP_ERR_UNSPEC;
             return;
         }
-- 
2.34.1


