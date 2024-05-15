Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1ACFC25B75
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2024 07:36:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s79BL-0001lY-KK; Wed, 15 May 2024 03:36:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Jiqian.Chen@amd.com>)
 id 1s79BJ-0001ji-VQ
 for qemu-devel@nongnu.org; Wed, 15 May 2024 03:36:10 -0400
Received: from mail-mw2nam12on20600.outbound.protection.outlook.com
 ([2a01:111:f403:200a::600]
 helo=NAM12-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Jiqian.Chen@amd.com>)
 id 1s79B5-0000zc-OQ
 for qemu-devel@nongnu.org; Wed, 15 May 2024 03:36:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KnxdUi6UaFyWdyRmBpKhYwluT56e1yA2A7IXEzAi4TQ77VcgcoZTLtiGklNV57VtsLTe8B6jNn2hSWQWJ+/GfYXduGBe8TF5RZxlCLe3ZLrSn2VgXLiY0JlEyN3tah3G/WymoE34mWPaVubeYuvvF181rnM5kU9sQWmZrL8lfXSowediMgxu00BIdcjyylSiIW8bvhpwtmLrSeiR87WcxRQOhKJerq2M8SyixEqTD/y7ujeysCY5Lxiwah3A8bnV29Uv8CucIhJHuY66FzX2ZTVeAsrjoD2RSM47AjZbNRd/bAkMuGsrKZAH4xuCeFFm8J3chRCD2LJ3bvF3sDp38A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oVTnM96Pzs1odTG+l6WBXNV8zcxUyh9wf43JpOBY/7s=;
 b=FP2h+3OfN5OCeKZChHQaqJq+fMY5Z66ib2Ww96ytXS4lOLyov44c5FshlHuEGjlaJnw9xWCEZ8HS1IBeb0GhWS92RlLvlaMhWdF5psKgJNFfMQhuz4jVHQ1McvQ7blSXH14FzNUV5ti3LFDHZWSmR/BwQEQYA55ViwDOfrMZVyDbF3Ob9brIAdx20t9FTiCuD0koJeL7qQhfLMPuKludtC6u0xYs9gLtWaKmt7KbO7zZlSqI6jlojapLh4XnuJGtVxeZKh2ySuBC/687edGQHZ3Fi1PiZSHrzlPYxoR+HJATPolcRoA6gZn4PQN4ECtUKnyMrF7PjWcO53zCffdQfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oVTnM96Pzs1odTG+l6WBXNV8zcxUyh9wf43JpOBY/7s=;
 b=PEYJHZ4jEwz+l99TtlhH+UsIKHN40hkdOacibopUDmcPO9wr2S45N43k82A7g7ZRY85Phepbyvj6i9nI+Xpm//fcW4jE3z0SQFIDlP/ipRUzKpZjBVjJjxmBxzetN3Hbu/R7n7cSHbybMUNIdt6VNug7HV5YFMwtTSMDxmHTv18=
Received: from MN2PR05CA0045.namprd05.prod.outlook.com (2603:10b6:208:236::14)
 by CH3PR12MB8934.namprd12.prod.outlook.com (2603:10b6:610:17a::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.27; Wed, 15 May
 2024 07:35:46 +0000
Received: from MN1PEPF0000ECD7.namprd02.prod.outlook.com
 (2603:10b6:208:236:cafe::4a) by MN2PR05CA0045.outlook.office365.com
 (2603:10b6:208:236::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.28 via Frontend
 Transport; Wed, 15 May 2024 07:35:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000ECD7.mail.protection.outlook.com (10.167.242.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7587.21 via Frontend Transport; Wed, 15 May 2024 07:35:46 +0000
Received: from cjq-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 15 May
 2024 02:35:42 -0500
From: Jiqian Chen <Jiqian.Chen@amd.com>
To: "Michael S . Tsirkin" <mst@redhat.com>
CC: <qemu-devel@nongnu.org>, Huang Rui <Ray.Huang@amd.com>, Jiqian Chen
 <Jiqian.Chen@amd.com>
Subject: [PATCH v10 0/2] S3 support
Date: Wed, 15 May 2024 15:35:24 +0800
Message-ID: <20240515073526.17297-1-Jiqian.Chen@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD7:EE_|CH3PR12MB8934:EE_
X-MS-Office365-Filtering-Correlation-Id: 140e3dbc-2561-495e-fe3c-08dc74b1a2ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|82310400017|1800799015|376005|36860700004; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?OJnW2KC8CQXKQnHzc1HS8sdSGFrCzMrVkE33DCKEiA7pvahjsIIAzVtEgTW0?=
 =?us-ascii?Q?HW+3CwX97xWjTttC8WBe4JOm2yA17XOuWd0ZhESLjDl53DJCD+fyDUXHldwb?=
 =?us-ascii?Q?i2MG28P7VCVEim8J9afvaCGV1AInRdXaNCUYdoLAQ4mbY3GVMF2e0+rpjtDS?=
 =?us-ascii?Q?MHqTYRliz9U2IeT1Oc7Us4QnWh8Oh59aNyGNSZI8Sk5lCg7S6s+s1gF7q31v?=
 =?us-ascii?Q?qGHBurqwboMECYbjM4Ze4Jdk5EBV9IR+y8YuL0jX8Kf/mm4PCzkld+cc0rrh?=
 =?us-ascii?Q?8BfUIR20VnUm3lFFwOnh7IrEXeeSMOPPOP8hlmg1Zm3JJfFz114VhbXZlGyg?=
 =?us-ascii?Q?DWupJd0kk71thlnxvIMk/7j1LoviuGCON5N565VAI/wv49/q4ni5oOQkZAIU?=
 =?us-ascii?Q?tgAtagRJfa51r+V/ndWWOoQDFKU4oQtMA9RI3KYcfTdZV4tzZtuIW5OqL+ki?=
 =?us-ascii?Q?uehYXYMstEePq7Z9h8kfiU4z4rIgcyiHFrG/FyzX7IjyOeCwxvY34yb7rHY1?=
 =?us-ascii?Q?G/QruPKlCHGp7Oqv6Rt18JGH07yVVpHuJW/JeZE7hkRsmErqvUbmcGjRed2/?=
 =?us-ascii?Q?tCjWPR3GJoJJx3n5qm7WLwZj62lEHdwaySW3PnhleOcRU3NBjytfoH+tfzgS?=
 =?us-ascii?Q?ftJoJ+dyvP1gURrbxoFH+G6xpbISKafc1qmcgTCAHRefs7IHrTNV2TUtCv6R?=
 =?us-ascii?Q?JPN4F3mbVyOLpQpynC+Vos/e0BnhjqkZ8ZBUL7+JuR9eFa5ftza4wwJF6yMv?=
 =?us-ascii?Q?qHXQYEaxr/pcp7KTVLIRFHJts2D9ZnogMw82wG98MldOin+HnU+3oOAFhDMV?=
 =?us-ascii?Q?nJB9LZAa6g88fC7+qDPpQRT6LkuOGurczFWLR6C311s0Eg93ZMFVGXhmfzNF?=
 =?us-ascii?Q?DkXwCEyF6yaPxDUnRVTc8QGOC6wzdKcxG/vDZjdGEwyX2l4leBfJrQ8YcP0m?=
 =?us-ascii?Q?vlq3zMVpG35dsPKil3YOoOmALaWsoSFV+JVewm0Ka04fv5wjUqnoyTx4MPOS?=
 =?us-ascii?Q?4MKyzN0xSfWU2iXbOcMlYo1iHwocyq6zH3ZfjxCv6P4LWAba+SEYrCvTHIT3?=
 =?us-ascii?Q?Nfu/fz0UHKsQhJWKTqzIKz1sWax8xctKprxX3JodC44q0KtK8Ah7nX2EBMFc?=
 =?us-ascii?Q?DdrP8vuYtI256i42+0YCzcAieaclZMqIB9gaH4cd4PtmwC5DniAB4Kf9sfun?=
 =?us-ascii?Q?RWAEaAEwEva8PAbfF8y6jykoHehcvrxKX7cULyID8HjgUKZf0pSE8lPjXivJ?=
 =?us-ascii?Q?6192HTW4GCdMm16ilO0vXgrhyy2w8tXFEtHPZJiuc9eg5+BEcUrezkAypfqe?=
 =?us-ascii?Q?h7TGiOgvuqLysImahTCll4JZ9p0mO98e7/SwhcDtTRiFmQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400017)(1800799015)(376005)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2024 07:35:46.6558 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 140e3dbc-2561-495e-fe3c-08dc74b1a2ba
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8934
Received-SPF: permerror client-ip=2a01:111:f403:200a::600;
 envelope-from=Jiqian.Chen@amd.com;
 helo=NAM12-MW2-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.974,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, SPF_HELO_PASS=-0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Hi all,
This is the v10 patch to support S3.
v10 makes below changes:
* patch#1 change the description of commit message.
* patch#2 no changes.


Best regards,
Jiqian Chen



v9 makes below changes:
* patch#1 no changes
* patch#2 remove unnecessary parentheses.
          add some comments to remind we may need to consider SUSPEND bit in future.
          change the commit message to describe which virtio device was tested.
		  keep No_Soft_Reset bit false by default for safety.


v8 makes below changes:
* Add a new patch#1 to fix a problem import by 27ce0f3afc9dd25d21b43bbce505157afd93d111,
  the right action is that only the state of PM_CTRL can be clear when resetting.
* patch#2 is the original patch to implement No_Soft_Reset bit, and in this version, I
  rename function and change some condition sequence.


v7 makes below changes:
* Tested this patch with Qemu on Xen hypervisor. Depending on kernel
  patch (virtio: Add support for no-reset virtio PCI PM:
  https://lore.kernel.org/lkml/20231208070754.3132339-1-stevensd@chromium.org/)
* Changed the default value of flag VIRTIO_PCI_FLAG_PM_NO_SOFT_RESET_BIT to false
* Fixed coding style violation
* Modified the content of the comments.
* Removed useless flag PCI_PM_CTRL_DATA_SCALE_MASK.


V6:
In current code, when guest does S3, virtio devices are reset during that process, that
causes the display resources of virtio-gpu are destroyed, then the display can't come
back after resuming.
This v6 patch implement the No_Soft_Reset bit of PCI_PM_CTRL register, when this bit is
set, the resetting will not be done, so that the display can work after resuming.
This version abandons all previous version implementations and is a new different
solution according to the outcome of the discussion and suggestions in the mailing
thread of virtio-spec.
(https://lists.oasis-open.org/archives/virtio-comment/202401/msg00077.html)


V5:
v5 makes below changes:
* Since this series patches add a new mechanism that let virtgpu and Qemu can negotiate
  their reset behavior, and other guys hope me can improve this mechanism to virtio pci
  level, so that other virtio devices can also benefit from it. So instead of adding
  new feature flag VIRTIO_GPU_F_FREEZE_S3 only serves for virtgpu, v5 add a new parameter
  named freeze_mode to struct VirtIODevice, when guest begin suspending, set freeze_mode
  to VIRTIO_PCI_FREEZE_MODE_FREEZE_S3, and then all virtio devices can get this status,
  and notice that guest is suspending, then they can change their reset behavior . See
  the new commit "virtio-pci: Add freeze_mode case for virtio pci"
* The second commit is just for virtgpu, when freeze_mode is VIRTIO_PCI_FREEZE_MODE_FREEZE_S3,
  prevent Qemu destroying render resources, so that the display can come back after resuming.
V5 of kernel patch:
https://lore.kernel.org/lkml/20230919104607.2282248-1-Jiqian.Chen@amd.com/T/#t
The link to trace this issue:
https://gitlab.com/qemu-project/qemu/-/issues/1860


v4:
Thanks for Gerd Hoffmann's advice. V4 makes below changes:
* Use enum for freeze mode, so this can be extended with more
  modes in the future.
* Rename functions and paratemers with "_S3" postfix.
And no functional changes.
Link:
https://lore.kernel.org/qemu-devel/20230720120816.8751-1-Jiqian.Chen@amd.com/
No v4 patch on kernel side.


v3:
Thanks for Michael S. Tsirkin's advice. V3 makes below changes:
* Remove changes in file include/standard-headers/linux/virtio_gpu.h
  I am not supposed to edit this file and it will be imported after
  the patches of linux kernel was merged.
Link:
https://lore.kernel.org/qemu-devel/20230719074726.1613088-1-Jiqian.Chen@amd.com/T/#t
V3 of kernel patch:
https://lore.kernel.org/lkml/20230720115805.8206-1-Jiqian.Chen@amd.com/T/#t


v2:
makes below changes:
* Change VIRTIO_CPU_CMD_STATUS_FREEZING to 0x0400 (<0x1000)
* Add virtio_gpu_device_unrealize to destroy resources to solve
  potential memory leak problem. This also needs hot-plug support.
* Add a new feature flag VIRTIO_GPU_F_FREEZING, so that guest and
  host can negotiate whenever freezing is supported or not.
Link:
https://lore.kernel.org/qemu-devel/20230630070016.841459-1-Jiqian.Chen@amd.com/T/#t
V2 of kernel patch:
https://lore.kernel.org/lkml/20230630073448.842767-1-Jiqian.Chen@amd.com/T/#t


v1:
Hi all,
I am working to implement virtgpu S3 function on Xen.

Currently on Xen, if we start a guest who enables virtgpu, and then run
"echo mem > /sys/power/state" to suspend guest. And run "sudo xl trigger <guest id> s3resume"
to resume guest. We can find that the guest kernel comes back, but the display doesn't.
It just shown a black screen.

Through reading codes, I founded that when guest was during suspending, it called into Qemu
to call virtio_gpu_gl_reset. In virtio_gpu_gl_reset, it destroyed all resources and reset
renderer. This made the display gone after guest resumed.

I think we should keep resources or prevent they being destroyed when guest is suspending.
So, I add a new status named freezing to virtgpu, and add a new ctrl message
VIRTIO_GPU_CMD_STATUS_FREEZING to get notification from guest. If freezing is set to true,
and then Qemu will realize that guest is suspending, it will not destroy resources and will
not reset renderer. If freezing is set to false, Qemu will do its origin actions, and has no
other impaction.

And now, display can come back and applications can continue their status after guest resumes.
Link:
https://lore.kernel.org/qemu-devel/20230608025655.1674357-1-Jiqian.Chen@amd.com/
V1 of kernel patch:
https://lore.kernel.org/lkml/20230608063857.1677973-1-Jiqian.Chen@amd.com/

Jiqian Chen (2):
  virtio-pci: only reset pm state during resetting
  virtio-pci: implement No_Soft_Reset bit

 hw/virtio/virtio-pci.c         | 45 +++++++++++++++++++++++++++++++++-
 include/hw/virtio/virtio-pci.h |  5 ++++
 2 files changed, 49 insertions(+), 1 deletion(-)

-- 
2.34.1


