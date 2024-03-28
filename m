Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 181F3C54E64
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Mar 2024 10:40:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rpnAX-0003h1-Gc; Thu, 28 Mar 2024 06:39:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Jiqian.Chen@amd.com>)
 id 1rpnAV-0003gh-09
 for qemu-devel@nongnu.org; Thu, 28 Mar 2024 06:39:35 -0400
Received: from mail-mw2nam10on20600.outbound.protection.outlook.com
 ([2a01:111:f403:2412::600]
 helo=NAM10-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Jiqian.Chen@amd.com>)
 id 1rpnAR-0002Jp-An
 for qemu-devel@nongnu.org; Thu, 28 Mar 2024 06:39:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bfZT47MZF36no/+4SIhq5ZWL6a6MhWpdAB28HQXh49eRYroFuuc4TRJ1dZKjfW7yXj/xEnFeIb3b/IOW6VfuXSOQFvRJgeJ4ZGPqBLQkwe7w64BlffQ5ta68iQSnQ9MAaCirNJY+h0x+nUxJMTcB2GAgllDXLCHTcCOf+zZPDGayPL8gcqtkQxSDrus9Myb0baWq7xUHIAzTRzmeCSeBkK+z2nt+kN239P1UJGB8+PO56Hb+bfbZOeHRgKoLrHayWgsqvlrUuJXhz++/3WmOZvq5xsPrLmQGoYtwZ1XH8yDfqgHBTEwFx8jJPmZeNsv+l5jnCdguMQsBsxDIbragzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kmuSAizVYNdggukM7ja8W6gHWknAcVkj8+PW8j6Dk80=;
 b=PGNN+6WVUAHT8JqGgJVDfiQNpyHNCwQiJRsqn/nPfXBIwi51E+XxDrbRwW4iHIjdlFaFI88kTPva2dkaFdIGwsKOw25n7oUxuvMKgYaK/rHWncGzfjHr1i6InVBMns3ZhTvLLoW7ZjtDjXOLUgSGb5h0HeCOwcgIPHp3uBAfeN7UzUGtKGKQpnucjendmE6/wclUl9tXVnOfy3u5P3Xw+lnr65WmkO3wWIl4Dj71/MAl9LPiwxM1E7dTCAcgg3n199I0GYEmUcM+TyupshnUR1lak0MA8oI0vnuEIQTa48RdcK4wJP08N3Dy79gjHCJ4QfqwmsF9x3tIsrWSVGv9DQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kmuSAizVYNdggukM7ja8W6gHWknAcVkj8+PW8j6Dk80=;
 b=sRdqa2ihC7ALreqtih1RUKwvsoPGp3lIQB03fNvtc+VK87Rv1l73XPiXnxpgXd4tCoag6MNj17i6BGId1/aeZhfsU8e9CEBOnqEqUuBYLgTX5ob+4BcsGb8gZZemxeQ5XNgxVRB2zfc15A/MzmbVMCk6azQ9uEjwWP3VaMfyQR0=
Received: from PH7PR17CA0003.namprd17.prod.outlook.com (2603:10b6:510:324::23)
 by MW4PR12MB7168.namprd12.prod.outlook.com (2603:10b6:303:22d::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.32; Thu, 28 Mar
 2024 10:39:24 +0000
Received: from CY4PEPF0000E9DA.namprd05.prod.outlook.com
 (2603:10b6:510:324:cafe::2d) by PH7PR17CA0003.outlook.office365.com
 (2603:10b6:510:324::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.38 via Frontend
 Transport; Thu, 28 Mar 2024 10:39:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9DA.mail.protection.outlook.com (10.167.241.79) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7409.10 via Frontend Transport; Thu, 28 Mar 2024 10:39:23 +0000
Received: from cjq-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 28 Mar
 2024 05:39:21 -0500
From: Jiqian Chen <Jiqian.Chen@amd.com>
To: "Michael S . Tsirkin" <mst@redhat.com>, <qemu-devel@nongnu.org>
CC: Huang Rui <Ray.Huang@amd.com>, Jiqian Chen <Jiqian.Chen@amd.com>
Subject: [RFC QEMU PATCH v8 0/1] S3 support
Date: Thu, 28 Mar 2024 18:39:01 +0800
Message-ID: <20240328103903.408290-1-Jiqian.Chen@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9DA:EE_|MW4PR12MB7168:EE_
X-MS-Office365-Filtering-Correlation-Id: fe34401a-1656-4df1-788e-08dc4f135580
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZJYKTi6B6ia1H8ksKcCZbQX0Jkxk92KF9LdAJssPNqp2tsSiRnyvyy9i7hsSXOEY3P7fv+Zh0YPHqWojEoeywxiB96wod+f82J3wdOPeisEPj45IwIR6/Fk5qWVKh9j5IGVQXrRGdTNXJHtBHF8wXa/F4gH2+WrNoYo5jG8nEKeioNgQ0pTU1vN/QGz3apjwDsk2nQsjsNdh9RCGIEZUfkKSxuLvO79XR0aYXePCCXJAws5g2ZKel091E3kjYf4TCZy4gqXI1wGHbQgWn+m1yOO58rFsnGduK3zySZpOn8powJ47FAtnaffDc5LgfsNnnJjhWEuoCwXn+b9FFdTKtkser3ACcZfEnonlVljr2hKpLvTZpevQP7vr2siuM5z3mRknVcufFJYt7vtko9/c3pnfdsQKucw5KM25WEp/FuppgoFKMdYFihoBBP3sHG7LTIHuaJuvA7rz3k7EsaFVjIdoiFTiWFR9cXlZ7OHANmxEwF9h2XME11Aei8JBmzDZ7IYIhnZ1kgbXodWGCFVxPGhUNRj94dTBzCgyWSsr77KJu43NuZ62iI25eucYlKGWxUvTc0LqE8J8ED5q3f7IXWgdKnToMaTA71Z614j1hdJFflzrKU47LhmqhIfyqQVuKoutbkSIWv/dqXCXAL+pSG6D7IlSFdPdeGeqfovDi4PzL5DfllKpfkhhcXcmDCZELVqn0MCmcbcSkQ6zepMdKQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(82310400014)(376005)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2024 10:39:23.6286 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fe34401a-1656-4df1-788e-08dc4f135580
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9DA.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7168
Received-SPF: permerror client-ip=2a01:111:f403:2412::600;
 envelope-from=Jiqian.Chen@amd.com;
 helo=NAM10-MW2-obe.outbound.protection.outlook.com
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

Hi all,
This is the v8 patch to support S3.
v8 makes below changes:
* Add a new patch#1 to fix a problem import by 27ce0f3afc9dd25d21b43bbce505157afd93d111,
  the right action is that only the state of PM_CTRL can be clear when resetting.
* patch#2 is the original patch to implement No_Soft_Reset bit, and in this version, I
  rename function and change some condition sequence.

Best regards,
Jiqian Chen


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

 hw/virtio/virtio-pci.c         | 37 +++++++++++++++++++++++++++++++++-
 include/hw/virtio/virtio-pci.h |  5 +++++
 2 files changed, 41 insertions(+), 1 deletion(-)

-- 
2.34.1


