Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FD9EC04FF8
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2024 07:07:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rwcuC-0005q2-Ez; Tue, 16 Apr 2024 03:07:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Jiqian.Chen@amd.com>)
 id 1rwcu9-0005pS-Ol
 for qemu-devel@nongnu.org; Tue, 16 Apr 2024 03:06:58 -0400
Received: from mail-bn8nam12on2049.outbound.protection.outlook.com
 ([40.107.237.49] helo=NAM12-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Jiqian.Chen@amd.com>)
 id 1rwcu5-0001xS-3l
 for qemu-devel@nongnu.org; Tue, 16 Apr 2024 03:06:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RVmo0ng+jRIxSD9r9U+VBPBahJjVHt/me0o4cSryOS0lfPgxrw30wMJvodajNQY/T88zZR08kkWgAPQPimAUjtQdXO3lIaD8Sdk5/93+wqtNh0ZlqxPJCNAWfNYvWHnMxmJam4qOqzgISQBUC3kroSENhi7ecoT81aPADzz1d7LRvN9VdQs6yirdHFzENXFRfNr6LxUBidVbWYT+dUbircvjqwrvYX2pAtnrh9PoK3T/H0a4Vad/V4HlUNIa0teXVWM64FMMGZraoSBgdG3WABAqt49KX3Exd3pNdrBTp2C9XUKLGCo+2+aDHGh2Mn5106ebeUViQhrI9xiiaq0QEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rnuYZeft8lRoIAh9JYSRaNy5fv79TAicnXTxruyEvQc=;
 b=Cwo8KdUOgyR1BXJMa/wGsi/wSWXFjY6d2pgQR8IBPpnV0oqqng1KJlMGkv9VrxxDoYRJpdXd/Vuj/kZoeSyBy/JD865boj6nPiGgc4kxQSf8kvIjkM7jltoiLgcaPZwO/PVESlWDJeZ2yWU4eOCsIgzaZShOevPDCvyyEtOxfZW4WoxMuIEOs+O5FDtqYsyE3pL4/JiL8GNwEJYkpX3kfN77n98S7HIHwAl6wkhOWrjcT5ZQgEiHf9B3NTWx4vQ1xeymyam/0OrrBFktyQRbJCZ515eDjEKPJ2dmSWEbU5zky0Yf3kfu54cBFINJe1NWOrUQs7wyLEXjYGFn4k6pdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rnuYZeft8lRoIAh9JYSRaNy5fv79TAicnXTxruyEvQc=;
 b=Hog1pjgTzusxcSSTIaXaxUMIkGWJ2wNv6WY/hleMq5C9DGtaCulGb9BRZNz8JBNyytpF2TawKzpV+mJKVqf/MI+XidhSLcioOPxq5FvvAFnoESskx7KZ8wRx8d4ytkI+q3w0x6TEhzr7KEVg1/Qzee6/ibTD7tz9LeuRJ8wjKo4=
Received: from CH2PR16CA0016.namprd16.prod.outlook.com (2603:10b6:610:50::26)
 by CH2PR12MB4263.namprd12.prod.outlook.com (2603:10b6:610:a6::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Tue, 16 Apr
 2024 07:01:44 +0000
Received: from DS3PEPF000099DB.namprd04.prod.outlook.com
 (2603:10b6:610:50:cafe::5e) by CH2PR16CA0016.outlook.office365.com
 (2603:10b6:610:50::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.33 via Frontend
 Transport; Tue, 16 Apr 2024 07:01:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099DB.mail.protection.outlook.com (10.167.17.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Tue, 16 Apr 2024 07:01:43 +0000
Received: from cjq-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 16 Apr
 2024 02:01:41 -0500
From: Jiqian Chen <Jiqian.Chen@amd.com>
To: "Michael S . Tsirkin" <mst@redhat.com>
CC: <qemu-devel@nongnu.org>, Jason Wang <jasowang@redhat.com>, Huang Rui
 <Ray.Huang@amd.com>, Jiqian Chen <Jiqian.Chen@amd.com>
Subject: [RFC QEMU PATCH v9 0/1] S3 support
Date: Tue, 16 Apr 2024 15:01:25 +0800
Message-ID: <20240416070127.116922-1-Jiqian.Chen@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DB:EE_|CH2PR12MB4263:EE_
X-MS-Office365-Filtering-Correlation-Id: cebb4f15-1cb8-4442-e097-08dc5de31316
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: F3Uai1mju8Z4xp+wahWfILNqlnVnk5OQavnozHqxRlTkhWMIm7lNlhhpewX62JrlxX5uPZzJkQK8w6kpzIE7Ij8CM30Xb1VDWIRz3RXQ+P1RZC3jvqH4raxN4QhbsYIMJnAPMxZqqpa37H+1j2U5DVYpZkdxL9UZkfCG4ZdKyko/alLOrJBm5vFuJHyZ/lz1Yil/Mn4kiG4/6tJeRCPIEHT+1U7MqmRMQoAqha7+j50QC2qsZ2NiauY+YCe150U/kzF8BNjh0KhkkgdtghOVOOef/CgerscYs4hXcrPx+WuIiRUaY+a9iFCDpG5mKkOROWlCKc/MNpvB2qhDZhn5NPtY3gdCyvcsuwAidT/mc7jSTKg5V6/43cvXD4vdg3qyAhNKkmQ/RZE+cih0d0/YnydB+kZQVH00MZQJpp+0nFGst9d0UbuiQkDNdXrWlTybYcb5SLZCIvbHptxAthdl8KsmtwLyuKSbVMEbusvmjrO65fKVDPsEKllG8EZKqvbpmha1XqmC3zmVy6BZi7ZQVYvoAucWjlh50QAAhIYtcJdohCM3cmfnpaX40AG98tZVn4T5zA9L6huwuYNojLvFEfxmfu13/SBYc2XhnD58j0EYgaFDxhOfugtz57U6+G1bKngUSFfzznI1J8fTRHk2DBruhk59zOZYHYAQJOLJ4zicm0O3xqTW48GZG7oOLxL1w8WMfQ8MLwoJJn/ONbcrMg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(82310400014)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2024 07:01:43.8212 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cebb4f15-1cb8-4442-e097-08dc5de31316
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099DB.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4263
Received-SPF: permerror client-ip=40.107.237.49;
 envelope-from=Jiqian.Chen@amd.com;
 helo=NAM12-BN8-obe.outbound.protection.outlook.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.185,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
This is the v9 patch to support S3.
v9 makes below changes:
* patch#1 no changes
* patch#2 remove unnecessary parentheses.
          add some comments to remind we may need to consider SUSPEND bit in future.
          change the commit message to describe which virtio device was tested.
          keep No_Soft_Reset bit false by default for safety.


Best regards,
Jiqian Chen


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


