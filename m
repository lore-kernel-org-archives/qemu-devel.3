Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5523C54E58
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Mar 2024 07:13:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1roeVq-0007G1-W2; Mon, 25 Mar 2024 03:12:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Jiqian.Chen@amd.com>)
 id 1roeVn-0007Fa-El
 for qemu-devel@nongnu.org; Mon, 25 Mar 2024 03:12:51 -0400
Received: from mail-dm6nam10on2048.outbound.protection.outlook.com
 ([40.107.93.48] helo=NAM10-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Jiqian.Chen@amd.com>)
 id 1roeVh-0007MU-Kt
 for qemu-devel@nongnu.org; Mon, 25 Mar 2024 03:12:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SUKXxqHNH9Fa8TBsnrijj2kn6DXDD3dWxDWlT9zI/SEqIuZyX9MMJBv7xIGDwqzkfd+EMcDoMnFDELDs2rJHb7f+0VBFCNaO3NhCXlm5QessVMPfJXqUv4w0hKeL6RR0WUD4OlGd9gqwc9Yg1EnweWCF73BRHczJtkXwa0FM86BXOJcOBftB3rBWAgyLs9DipAFzQFeOwSEfHfavwZijR9GCOORHt65I69X2Eq65W5FQDs+wZsYcs9CJLINqM4UYMqYBFtwnJLqAAjFOMd/fYdV/2EQWsXJ5ceozL0Vt81gbeYDe4BpUTNvdpZSayOm7QOedNBHtKvaN2DKj4SrUrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ph95+s7Fuyz6XJh5POQaWZQBtaf6vzmemyD3GqJ0z7c=;
 b=IqvLddXWEjbVsNQz204+xdeW0tplZdg8MgV2ge/CtYFOLwgep8f0MkwKySfxUreK5zUvdlVi1UFyxj2L/sW/5oC+H5EsWbMGWdiPFfR87F32kFnbyzWpOM4NisNaRabIXjvGGUWmw5sUhgaN/7hIUm4sq++ezc+7R6EqvPNFc0YEMx//7xepcu0x8CNx6BEAEX44qRa/6LgyDmtVCEqU4KPsg8EjQ2c0ocMy9rRvWsUOrgsxh6UsnJvUaoz1XBYyCKcoBReno0U2Wr+QNDrks13d4lgCvdbk215DjuPVA+ZsTYWll9kSP+lG2KIT95sA/atXetVlHYo3I6AlRvuaSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ph95+s7Fuyz6XJh5POQaWZQBtaf6vzmemyD3GqJ0z7c=;
 b=MkJy5Pw8vqvX7ihiwt0bW9woVzEPfrpDXw6+C2bfEV7zdFYkxZHqy2KOVKK0ZZfIQhwYO3MwcbJ7XCKsdXVCqYcdQHbgOCbPvNudTXLyeEnxx7/wiDTH5SoXNz5TFteh2+ueV3NJNvhF0M/s6JH3zDeDbq7NnDfMBiPCUEpcEmU=
Received: from CH0PR04CA0014.namprd04.prod.outlook.com (2603:10b6:610:76::19)
 by DS0PR12MB8317.namprd12.prod.outlook.com (2603:10b6:8:f4::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.31; Mon, 25 Mar
 2024 07:07:39 +0000
Received: from CH3PEPF0000000C.namprd04.prod.outlook.com
 (2603:10b6:610:76:cafe::19) by CH0PR04CA0014.outlook.office365.com
 (2603:10b6:610:76::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.28 via Frontend
 Transport; Mon, 25 Mar 2024 07:07:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH3PEPF0000000C.mail.protection.outlook.com (10.167.244.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7409.10 via Frontend Transport; Mon, 25 Mar 2024 07:07:39 +0000
Received: from cjq-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 25 Mar
 2024 02:07:37 -0500
From: Jiqian Chen <Jiqian.Chen@amd.com>
To: "Michael S . Tsirkin" <mst@redhat.com>, <qemu-devel@nongnu.org>
CC: Huang Rui <Ray.Huang@amd.com>, Jiqian Chen <Jiqian.Chen@amd.com>
Subject: [RFC QEMU PATCH v7 0/1] S3 support
Date: Mon, 25 Mar 2024 15:07:23 +0800
Message-ID: <20240325070724.574508-1-Jiqian.Chen@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000C:EE_|DS0PR12MB8317:EE_
X-MS-Office365-Filtering-Correlation-Id: 70f245fc-b7bb-4a62-c859-08dc4c9a41f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HinkpbeipAXnkxSy+zsz94ai0isOa3p51X4Qnz+NcJtPixJVOZjSSb7KLd1XBJjRVL8+B+DuN3zVSQgqnKbbO1JsNuftOslk88WJh6qZKwjfQmVTydNSNS3MXVL3FLTT4k+CnKSACUhA/hZJdWenH/TeTnu7aK1DAEIuFbepehVLn1dbV6aubI9QMmH+DE59j6E/RRdv+2lLxc9hlMq8nIEW5enlXjDl+wYwAETiBrZl6sh0VEqNe4Ivg5T/PVf1njDBHuAvFtjU75a7GIc6YNAU/ojeov4EZC+o+cClEcVtGloOJFT/PpR9r70I0LU1QwwGzeajyYXlECMNao1MTQwVE2MGGjSzbseviiSjKx21pk9sKatbtsraPPxmUDk73WERt1a7puAYF4Ga0cBDXF+BCCCfs4NMWT+p6XDW4CZUunVfVSFd/nzuzYM49n/IBsOxft2JuMkYrBXC3dK3dlvHmdY+YkQp9WScjbc3qfd4kMxA3x6zUwAemVRrbnkw/CR05dXFvi9LR/sAHdPLVSx78zQ4zt8+jPNbu+PiOOQcxzOov4R8PZNZlBCdDC8dAAxHFXarXjFSCDcxKe4CWbFIl25xhXjNr+cbm4NjYhnn/i1sQMyUwqxALZOemgdEOXdEGOha3GEaNj+sR1IqCI1v3Gh03bK279wquUsbUs8178ecixv74ulmT5P25qv1HgTYoJBO8Sa6gjFGqiRaIw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(376005)(82310400014)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2024 07:07:39.4509 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 70f245fc-b7bb-4a62-c859-08dc4c9a41f6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF0000000C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8317
Received-SPF: permerror client-ip=40.107.93.48;
 envelope-from=Jiqian.Chen@amd.com;
 helo=NAM10-DM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -2
X-Spam_score: -0.3
X-Spam_bar: /
X-Spam_report: (-0.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.099,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1.899, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_PASS=-0.001, T_SPF_TEMPERROR=0.01 autolearn=no autolearn_force=no
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
This is the v7 patch to support S3.
v7 makes below changes:
* Tested this patch with Qemu on Xen hypervisor. Depending on kernel
  patch (virtio: Add support for no-reset virtio PCI PM:
  https://lore.kernel.org/lkml/20231208070754.3132339-1-stevensd@chromium.org/)
* Changed the default value of flag VIRTIO_PCI_FLAG_PM_NO_SOFT_RESET_BIT to false
* Fixed coding style violation
* Modified the content of the comments.
* Removed useless flag PCI_PM_CTRL_DATA_SCALE_MASK.


Best regards,
Jiqian Chen


V6:
In current code, when guest does S3, virtio devices are reset during that process, that
causes the display resources of virtio-gpu are destroyed, then the display can't come back
after resuming.
This v6 patch implement the No_Soft_Reset bit of PCI_PM_CTRL register, when this bit is set,
the resetting will not be done, so that the display can work after resuming.
This version abandons all previous version implementations and is a new different solution
according to the outcome of the discussion and suggestions in the mailing thread of virtio-spec.
(https://lists.oasis-open.org/archives/virtio-comment/202401/msg00077.html)


V5:
Hi all,
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
Hi all,
Thanks for Gerd Hoffmann's advice. V4 makes below changes:
* Use enum for freeze mode, so this can be extended with more
  modes in the future.
* Rename functions and paratemers with "_S3" postfix.
And no functional changes.
Link:
https://lore.kernel.org/qemu-devel/20230720120816.8751-1-Jiqian.Chen@amd.com/
No v4 patch on kernel side.


v3:
Hi all,
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

Through reading codes, I founded that when guest was during suspending, it called into Qemu to
call virtio_gpu_gl_reset. In virtio_gpu_gl_reset, it destroyed all resources and reset
renderer. This made the display gone after guest resumed.

I think we should keep resources or prevent they being destroyed when guest is suspending. So,
I add a new status named freezing to virtgpu, and add a new ctrl message
VIRTIO_GPU_CMD_STATUS_FREEZING to get notification from guest. If freezing is set to true, and
then Qemu will realize that guest is suspending, it will not destroy resources and will not
reset renderer. If freezing is set to false, Qemu will do its origin actions, and has no other
impaction.

And now, display can come back and applications can continue their status after guest resumes.
Link:
https://lore.kernel.org/qemu-devel/20230608025655.1674357-1-Jiqian.Chen@amd.com/
V1 of kernel patch:
https://lore.kernel.org/lkml/20230608063857.1677973-1-Jiqian.Chen@amd.com/


Jiqian Chen (1):
  virtio-pci: implement No_Soft_Reset bit

 hw/virtio/virtio-pci.c         | 38 +++++++++++++++++++++++++++++++++-
 include/hw/virtio/virtio-pci.h |  5 +++++
 2 files changed, 42 insertions(+), 1 deletion(-)

-- 
2.34.1


