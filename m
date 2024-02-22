Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAB99C48BF6
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Feb 2024 03:46:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rd022-0003QK-V7; Wed, 21 Feb 2024 22:45:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Jiqian.Chen@amd.com>)
 id 1rd01n-0003PU-8Q
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 22:45:43 -0500
Received: from mail-dm6nam10on2053.outbound.protection.outlook.com
 ([40.107.93.53] helo=NAM10-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Jiqian.Chen@amd.com>)
 id 1rd01k-0002z5-Af
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 22:45:42 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PPskbl0GQWeOSnxdFy1GKwWxVeJ16Waf5ex3CXysxriGwWOC4kyuvnYhXFrMFBfG2y3JylIGleEj3Q92qdjMYjZmnWBMh5Z37sBkg8ShinteMZJoD97DJKzrpxsAxuf2lXXgv9EINQvEZdYEp5/Fa8CdTOef3VZqCpDqKJZVeZTGQhsJMHDNedgOomDYP+wUWhcjlJINb8VQOMRpIMf54+9FUubVsz8mwm0NuoPDZxRq2lawye2yY5pekmBMpOSsroxFar5XJrlsSyB7kVGYl0F/ociOSSDf1IezPrySqH9FOXz94Q7NkC2OFlMfgwO70cBMM7Uy7OIzXmvWp3+uNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RCiiO9aHDT91DYmFzehgsH8mdRZIv9sGu1tIFTKs8kw=;
 b=MnlWUC6iBF9yP3tBIvSDRzljvIIW8pP0SgW8MejyAnq/FHroUSIIPinEaNXBzCa9V+mMVd5aRpwvS2scPcwoA5JQc4YL5vsiDQPErGcqxbjSkWKMqjwCJNhvflFBVHnd9gRI4sMAnGrO2wCgMbs9dakzPngZEG6VeUJk/RUfN8iDlN4gVIdro/1rUSogQdqlhluXkJaaxSmlmySbRwO7AVHc4UB8+bJ6gzh16Qrq0utIyy3ZHxhzX/DQQrYhEsOAJuiIlVHjJo14IwWs61newRrpi7g5611gMPAz4R9zhlyvElsnLegYQqNhvKlJYyC3vY0Wujtxd4xdIXrFWLpPbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RCiiO9aHDT91DYmFzehgsH8mdRZIv9sGu1tIFTKs8kw=;
 b=ZHCA+HTLnIyV3zyoG6jbvcdWVaf3OwuYKgNoUgspAU31QeFt0A1JrLYmzojTwBLyJlh7sgq9RD8baDggLcTWPFRL7dFVqhhXJPvRSSybCrDqPReIpw7nlNLt3YDAH5rUd+nQGiNRqeYm7s9JmN9pIsqqYs9AhCEzygRN/Xq8JxA=
Received: from BL0PR02CA0136.namprd02.prod.outlook.com (2603:10b6:208:35::41)
 by PH7PR12MB6764.namprd12.prod.outlook.com (2603:10b6:510:1ae::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.24; Thu, 22 Feb
 2024 03:40:32 +0000
Received: from BL02EPF0001A0FB.namprd03.prod.outlook.com
 (2603:10b6:208:35:cafe::34) by BL0PR02CA0136.outlook.office365.com
 (2603:10b6:208:35::41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.41 via Frontend
 Transport; Thu, 22 Feb 2024 03:40:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A0FB.mail.protection.outlook.com (10.167.242.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7292.25 via Frontend Transport; Thu, 22 Feb 2024 03:40:32 +0000
Received: from cjq-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 21 Feb
 2024 21:40:30 -0600
From: Jiqian Chen <Jiqian.Chen@amd.com>
To: "Michael S . Tsirkin" <mst@redhat.com>, <qemu-devel@nongnu.org>
CC: Jiqian Chen <Jiqian.Chen@amd.com>
Subject: [QEMU PATCH v6 0/1] S3 support
Date: Thu, 22 Feb 2024 11:40:09 +0800
Message-ID: <20240222034010.887390-1-Jiqian.Chen@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FB:EE_|PH7PR12MB6764:EE_
X-MS-Office365-Filtering-Correlation-Id: cf00dbf8-f730-431e-640d-08dc335805d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ibLCq8jfF1T7tdJ11A5nwrVTRHhZfACAxIpQwDJ/suZUpH+cznGVWZqrl6P78pIt+ixHIhBzEhVjAtCL4Am9Yr2/2u15mm1qTVi5Woxwe0Gul/zH9nplqItkcDgg5IOQJAelvmx8THZnPs58Wzsu1XDZPzvgf6YPWEcwiLYjHEx7t+u0q73nFztTUVlJTfarMMNJnvfjOH+6SEDH4Rvnc0Wy2NXH950GY0LgWax6tJ2ekc/gYhIHCHmQ6/+0UK4aYgnf4RiASDYCTna8SpKzTY76+ZA30q2wdO29KqhbTn4cVcSTxeiB3givCtxecduSmxyXyZPpFnaGm1OGgnZVIuHQ3MuWS0H+d+pQh7xvCjBYsZAQCecJoAt6mneNZT5FmaZtsEvvQsiEFfTSq6NeM6CudYgOE0dmmJJsHeJFjEfT5Lc5DeOU3p2G1AI3r/WWvLo7hoASpVaaEfuu/RgJmHUybPXj23rKASoV1fkRD0srGrIrcZa1sIzM4XH+K0c4PvQ7w8F+AXrCfdcnUcqvo9vkhA59TTtGE0WoR0Za3ow0YRDeZ4JlC2bdfNaBA+a3p9y1NAtNgHByOGv3NSqztKNFJu/u1ymI1sXPLgEBB6KmwyC37e6qcFzI1699XCvjklEPNhI/KX9NEWs0i7qMIw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(40470700004)(46966006); DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2024 03:40:32.7530 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cf00dbf8-f730-431e-640d-08dc335805d6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0FB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6764
Received-SPF: softfail client-ip=40.107.93.53;
 envelope-from=Jiqian.Chen@amd.com;
 helo=NAM10-DM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.05,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
This is the v6 patch to support S3.
In current code, when guest does S3, virtio devices are reset during that
process, that causes the display resources of virtio-gpu are destroyed,
then the display can't come back after resuming.
This v6 patch implement the No_Soft_Reset bit of PCI_PM_CTRL register,
when this bit is set, the resetting will not be done, so that the display
can work after resuming.
This version abandons all previous version implementations and is a new
different solution according to the outcome of the discussion and
suggestions in the mailing thread of virtio-spec.
(https://lists.oasis-open.org/archives/virtio-comment/202401/msg00077.html)

Best regards,
Jiqian Chen

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

Currently on Xen, if we start a guest who enables virtgpu, and then run "echo mem > /sys/power/state" to suspend guest. And run "sudo xl trigger <guest id> s3resume" to resume guest. We can find that the guest kernel comes back, but the display doesn't.
It just shown a black screen.

Through reading codes, I founded that when guest was during suspending, it called into Qemu to call virtio_gpu_gl_reset. In virtio_gpu_gl_reset, it destroyed all resources and reset renderer. This made the display gone after guest resumed.

I think we should keep resources or prevent they being destroyed when guest is suspending. So, I add a new status named freezing to virtgpu, and add a new ctrl message VIRTIO_GPU_CMD_STATUS_FREEZING to get notification from guest. If freezing is set to true, and then Qemu will realize that guest is suspending, it will not destroy resources and will not reset renderer. If freezing is set to false, Qemu will do its origin actions, and has no other impaction.

And now, display can come back and applications can continue their status after guest resumes.
Link:
https://lore.kernel.org/qemu-devel/20230608025655.1674357-1-Jiqian.Chen@amd.com/
V1 of kernel patch:
https://lore.kernel.org/lkml/20230608063857.1677973-1-Jiqian.Chen@amd.com/


Jiqian Chen (1):
  virtio-pci: implement No_Soft_Reset bit

 hw/virtio/virtio-pci.c         | 37 +++++++++++++++++++++++++++++++++-
 include/hw/virtio/virtio-pci.h |  5 +++++
 2 files changed, 41 insertions(+), 1 deletion(-)

-- 
2.34.1


