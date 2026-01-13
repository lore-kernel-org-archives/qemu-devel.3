Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81607CF45CB
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Jan 2026 01:53:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfTaO-0006br-2t; Mon, 12 Jan 2026 20:52:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Honglei1.Huang@amd.com>)
 id 1vfTaM-0006bY-M9
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 20:52:42 -0500
Received: from mail-westusazlp170120002.outbound.protection.outlook.com
 ([2a01:111:f403:c001::2] helo=SJ2PR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Honglei1.Huang@amd.com>)
 id 1vfTaK-0006G6-Ik
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 20:52:42 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=es0mNUGBdPuYGE/twLpbJSTaYFPxoKvLRX5k4KKovYiFFkMuTR1O622T+iWoe55ncL1OD5UU0FMdtMAmiBpuRTIhjlkdylyZqw7geykaUoDZJ37N69SCxZfyr/AmySe3C/R5Lcl7tUWKEiNbLrMNacS20bztOBVgqDkoRREup0jG8/08naBJFBVQ85ljO0mPnJSqJnguBqH6hiiohqgIQlbaErPmCS7DVZVndZL7295SuLGZJpXqWkJZHZ19ld1cwLcGU+AXZ0j8DovgI7UrfBNmXAwGEGq8atYaLjPBumyRvMEZge4te3q+rFFNvY1UunrNHXQvaziFaexKnfd3TQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nNzMb23wBE/ZHkHfJlNU+2YMtq0NAVu9e75wTx3nMwo=;
 b=Uu9kk9uPTVcp/vxQ7IBfAyhkQzwRhyDD2OBEgzb0a52eWGdACC33fL56Er6N2JxdzU4x/FMk6Ak/QLfZmc7d10EsdZynZSohLx2jaxcRIqGdUrlueomA++CUDRS0tDtkHmR2z4N17CINpIAdKrlsgBghkLeSP1a3ArrE6Q7d12pFn1HUgw7/5PLkUleO2qzLJ4jfVbw9xBGScs7ki+mpTbBawW2lj+lzAN6uwZwbSQ3CGLlAthKxoGjw34wclwv9MiGrjyDebUYyKaGQ1c3iNtMgHpMaa8HWf0iH/7OABqD1Zwqi53I6vl9hu8UOJtTdk62QidIz/zhVvbpE+CdPig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nNzMb23wBE/ZHkHfJlNU+2YMtq0NAVu9e75wTx3nMwo=;
 b=aXuJIzxJPetAGtFqXepTN6KrGxkGeiCOmn2dLSJxn0CBto04hxmkOe/XcqByTLAzdJAw4+kTARkCPw77Q9L/nfeEBsZ/n3WafLJ8Ta3krEVltW4sXCnSIQAdl6qiN7qfvvjQQeT8AH+gnufTKXITjadSPabjlSHsSnhsyPSnUt0=
Received: from SJ0PR13CA0187.namprd13.prod.outlook.com (2603:10b6:a03:2c3::12)
 by CH3PR12MB9079.namprd12.prod.outlook.com (2603:10b6:610:1a1::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Tue, 13 Jan
 2026 01:52:32 +0000
Received: from CO1PEPF000075F4.namprd03.prod.outlook.com
 (2603:10b6:a03:2c3:cafe::16) by SJ0PR13CA0187.outlook.office365.com
 (2603:10b6:a03:2c3::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.4 via Frontend Transport; Tue,
 13 Jan 2026 01:52:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF000075F4.mail.protection.outlook.com (10.167.249.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Tue, 13 Jan 2026 01:52:31 +0000
Received: from honglei-remote.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 12 Jan
 2026 19:52:28 -0600
From: Honglei Huang <honghuan@amd.com>
To: <alex.bennee@linaro.org>, <dmitry.osipenko@collabora.com>,
 <odaki@rsg.ci.i.u-tokyo.ac.jp>, <armbru@redhat.com>
CC: <mst@redhat.com>, <cohuck@redhat.com>, <pbonzini@redhat.com>,
 <qemu-devel@nongnu.org>, <Ray.Huang@amd.com>, Honglei Huang
 <honghuan@amd.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>
Subject: [v6 1/2] virtio-gpu: fix error handling in
 virgl_cmd_resource_create_blob
Date: Tue, 13 Jan 2026 09:52:02 +0800
Message-ID: <20260113015203.3643608-2-honghuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260113015203.3643608-1-honghuan@amd.com>
References: <20260113015203.3643608-1-honghuan@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075F4:EE_|CH3PR12MB9079:EE_
X-MS-Office365-Filtering-Correlation-Id: f560f504-5c52-47b8-bd2b-08de52466a5d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NzNtM1pYY1JOVTlROFV4c2VOamlVZFp5TmRQVlArbVZrM3BHdFNBNk12aGVI?=
 =?utf-8?B?eFFtVU45Y1EyQVg4dG4xaDdsQll5azZrQThiRVVvdnIyY3JCNmVTb3RmaTR5?=
 =?utf-8?B?dnd6OWI3RDRXbmN3NW5yTklZR0lqYTQxNlVzWjZ1VjZYTWNZTEpJRWVNRFFw?=
 =?utf-8?B?YkNvUXNSQ1VBZ0dVY0ZZMUdhUUZQeDRJY2lqS2h4aEVMM29DY09EbTBhNThC?=
 =?utf-8?B?UmgwS2t6SDRlc0h2bGRlSDNxWndJZURjK0JHME5tUFFxRndSN2RxSGw4bTVH?=
 =?utf-8?B?UWN5VXlLM1JGa3EwWWJNUkRHYnBxL3RVZDlFQ1dGQVNveTZwYmtZV3pzYjlL?=
 =?utf-8?B?OXJtVGk4MVlrTnJOaGdJWW1GKzR1dkdlRktDdXY5NFFaV0VmTXl3aFprTkJK?=
 =?utf-8?B?Zmh0Y3M2aEhzVWIvWlJPSk5rN0tpQjNHUVhjWGM5Z2pESS9rcjhINVIzQXp2?=
 =?utf-8?B?TzdtRUFvMWRMV0RGN25PV0ZneTgrWGxDWHByZS9qNDdXMG1jVnozelA2UVo1?=
 =?utf-8?B?dFZhcEJ2L1JwK1hTRU52ZDlybkdyaDVQSUN5MlFTQjFGdnBQM2RXSklxWllp?=
 =?utf-8?B?YlJhRUhDcjU3MEJMSzF6azVUSGNoTTBFa2Y3Y2Q0RFZiRit1OGtkcnY2VFlO?=
 =?utf-8?B?Zkh4MC9uNnFrUGV5SkR1YVM4RXJ0RG1PU21LSWFSV2dac3JFSU5Zamt6TWg2?=
 =?utf-8?B?MkU3eFpNUnkwaDl4aE55TG1tdUVoQzVNL1djeCtkSXROUlZNUENFUWRVM2tG?=
 =?utf-8?B?eHB6Qi9EdzFOempLQjNON0dwTjkzVy9GNUliWGl5eXFVcUxwMmE2eEtUSG8w?=
 =?utf-8?B?OVpYMkptVTY4a1ljeC9KaHlDV00veDBkODJVcFJxZGRLVjJDS0ZaMG02a3BO?=
 =?utf-8?B?UUc4U0dHZFNVbHU3dUVsYyttZ3Fac1dZWlA0bEFwWk1mQ1p2ekM1SENuRHJq?=
 =?utf-8?B?NGRvckdDaXhMREdEZ0xlczZIL1FpVHltU1cwemJ6aVRDaXRodjNJVzJ5NDhp?=
 =?utf-8?B?K0Q3dHJhN25xQU1uVndVUlJmeW9Xb0hhTmsxY2RlT1NOY1gva0E2YlYyckpZ?=
 =?utf-8?B?akwxZWoySmhiTytNdUgzU2c5ZTZSdWo3WmRia2ppNm5WU0RrcEVnankvSkF3?=
 =?utf-8?B?d0M3Rm5RK3drQTc5L2ZKaU5yTFlScEowdnRGQzF5b1doYi9EODZXS2kyQUt4?=
 =?utf-8?B?R3RHVTlWcGpFWEFHREphZ0IveHpzaXR4QWszNHdOSDVyaS82UlF6ZmZmWWV2?=
 =?utf-8?B?NVNGQnZCS3lLWUdVaUhsa0lxY1c1OTBsY2l1eVZYemdsTkZxWGt6QU5zVVRm?=
 =?utf-8?B?S1NqNTV2ZUtLdEFuai90ckU3eHRpd2JlR0JDako4ZHRZb3d2OHEzVm56M0pU?=
 =?utf-8?B?MEpDT3J3UFhTUXFKa3kwUjJ4dG51cHZwMHJxUk1TUVRTS2wwZjJnT1hsZHNa?=
 =?utf-8?B?QkdERjI1Y0E4dkRVVTd4M1ZVMEpmSmR0ampKcUkvREJQTGx4OUo3NktMQmNw?=
 =?utf-8?B?UUdMRDdrZzkySWtzZ3dtU1c0MjY0MDlWRHZSTWRsS1RTRlZGaFYvdkJrWWdy?=
 =?utf-8?B?NElsUjlsMCtpbnNRYmtkVVZjZjFQRnI4bkNzVXoybUkwYXVGN3JHaTNoNzQr?=
 =?utf-8?B?MUFJdXQzSG5EcFdFM25qQU9iWkhDYy9SVGtNRVNzdm5LdTg1V1NaTENsOXBE?=
 =?utf-8?B?M2s0YUdVVjBwdkVMYjNzNXF0OXN0NTRiU2s2QXRRYXkyVDkzdFA0eXBhL0Fr?=
 =?utf-8?B?d3V3UWVidGRiTC9rZk9zWEd4OXRldzJiME43T2htb2M0a3psS01YYXJyTEhy?=
 =?utf-8?B?L2ozOTJGUTZSRDNkSDdJOEY0VVJlQ0Vuc3pyRHZyRUZiVEpRbmFZdFBqYmRX?=
 =?utf-8?B?ejNKS25jKzg4M3I2Q0tLUUVVaU43eEx0dHRJMEFNNCtFUm5ZT2w2MzVZTzlh?=
 =?utf-8?B?OVdFeCttRFdMemtMbXR4d0hvV0hMT3N5S2JRcFRKa1RJZ1k1c2MrcWlBV1pR?=
 =?utf-8?B?RWQ0cXJYM2poQUp0cWdpcGdEbGhyckxBTEFKb1BZbDZOMFd0WU56RlF3K3NU?=
 =?utf-8?B?aXN1b1hqWXh5OFhtcjhKcCs1d0t3U1NhcU5iNkprdXlkbXlaenhIZm9aYm9Y?=
 =?utf-8?Q?3QDo=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2026 01:52:31.7570 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f560f504-5c52-47b8-bd2b-08de52466a5d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000075F4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9079
Received-SPF: permerror client-ip=2a01:111:f403:c001::2;
 envelope-from=Honglei1.Huang@amd.com;
 helo=SJ2PR03CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Fix inverted error check in virgl_cmd_resource_create_blob() that causes
the function to return error when virtio_gpu_create_mapping_iov() succeeds.

virtio_gpu_create_mapping_iov() returns 0 on success and negative values
on error. The check 'if (!ret)' incorrectly treats success (ret=0) as an
error condition, causing the function to fail when it should succeed.

Change the condition to 'if (ret != 0)' to properly detect errors.

Fixes: 7c092f17ccee ("virtio-gpu: Handle resource blob commands")
Signed-off-by: Honglei Huang <honghuan@amd.com>
Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Reviewed-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
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


