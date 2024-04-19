Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D9B2C4345F
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Apr 2024 04:19:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rxfiX-0003DQ-7s; Fri, 19 Apr 2024 00:19:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Jiqian.Chen@amd.com>)
 id 1rxfiV-0003DH-Sm
 for qemu-devel@nongnu.org; Fri, 19 Apr 2024 00:19:15 -0400
Received: from mail-dm6nam10on2071.outbound.protection.outlook.com
 ([40.107.93.71] helo=NAM10-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Jiqian.Chen@amd.com>)
 id 1rxfiT-0000wC-Vx
 for qemu-devel@nongnu.org; Fri, 19 Apr 2024 00:19:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WC3SPS44gpm7Dc02rTYiXcQ1dNITpncxMSLjRc8oiwFByCnBCyXP9PdKqMVQF6wXXVTOvW7SqiY53yBRoxUl/xFLrj51RJsAmFjF0f724vdu4rV7Wb/GRAwnAA4O+xCUT1yhAUrY3Xn5ALc0O1oRE4vjC++J83dfYjbfaASLjgc1hPfXMNLTFgNQtELdYAK24n/2RsiCA1JXwZ15/KwP4Sb/1dOtItsbT8gELO3HPbeeQ4xCsp3Y2vrErOtDvPAkZ94ECJbupocODuQzUcoNnLSgmtrIEHrcn1WbKpNpZSIi9cpD+/18+z+rEWgtfWBElMTygd6SOQLsLKC8ecip9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pj8YD64Ph6IwvRJJqtUYhZIQZnosoF6qgGzX78HNrMA=;
 b=CP8pIPy66ZWI0B3BFcY4zt/0Ufvid5S8B2mFZNpLqjDRpdTRN3BswXR9KlM+6tP+S71B4aikzrDjybTQ7k5UuVqYa8b7EtxoP4sVYxK9QPOt6pKBf93fZryTRxz6KJWepavGur3oo2NJaDyg+i7KOfcgeiJOGw+rGIdn6LsQdLBLV9gkngf7gaWBFx+otol5VxwWNurGB1R+wawn/Sj9tLXkgmLwSMazF2i0D7NIgnVDK4OA18XZ8jBj+R0pLjxnhBtwR08A3XjVR6g2gucsuMLdSl9PxSX+0YwQPbp3NbiDpjKFYsZjYQk/ECQ9ey8y+cuG6zwc/yo4VEJlUQcIsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pj8YD64Ph6IwvRJJqtUYhZIQZnosoF6qgGzX78HNrMA=;
 b=RsFZ7ZlqjTtxL74LHRsspdpiZldZyomG0JVKzdXaFCZyIpi3M6s49Sae161zK6z9qsLmNQY8UmxVTKqtuAAxmlz2FnsjUNq1nhq3ALVPogWVC1xMEjH8ILeAnEYyQtflvhI011kUn2TgWXkpshour7+UbvO6snQn66IUTE+nrXA=
Received: from CH3P220CA0027.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:1e8::25)
 by CH3PR12MB8482.namprd12.prod.outlook.com (2603:10b6:610:15b::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Fri, 19 Apr
 2024 04:14:08 +0000
Received: from CH2PEPF00000149.namprd02.prod.outlook.com
 (2603:10b6:610:1e8:cafe::be) by CH3P220CA0027.outlook.office365.com
 (2603:10b6:610:1e8::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.26 via Frontend
 Transport; Fri, 19 Apr 2024 04:14:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF00000149.mail.protection.outlook.com (10.167.244.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Fri, 19 Apr 2024 04:14:07 +0000
Received: from cjq-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 18 Apr
 2024 23:14:05 -0500
From: Jiqian Chen <Jiqian.Chen@amd.com>
To: <qemu-devel@nongnu.org>
CC: Stefano Stabellini <sstabellini@kernel.org>, Anthony Perard
 <anthony.perard@citrix.com>, Paul Durrant <paul@xen.org>,
 <xen-devel@lists.xenproject.org>, Huang Rui <Ray.Huang@amd.com>, Jiqian Chen
 <Jiqian.Chen@amd.com>
Subject: [RFC QEMU PATCH v6 0/1] Support device passthrough when dom0 is PVH
 on Xen
Date: Fri, 19 Apr 2024 12:13:50 +0800
Message-ID: <20240419041351.633856-1-Jiqian.Chen@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000149:EE_|CH3PR12MB8482:EE_
X-MS-Office365-Filtering-Correlation-Id: 3dd63812-992c-442e-5245-08dc6027284c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6TOIrRuO1jIbFcaZSCKph0h3rkUYigLTp1GFUhGMt/LPzAcS3HtN4qqmcPb9ZZx0B+6eBj+3HTKd2oHnx0TfJIUkv7nLSDFB/OKK11ztyiPbnWyYRoWMVOoMkvMgGJ/47p0PCIF7XBmQMwc3rmqRsm2hgz4YYI2NgyVXo/JcA+Zgqr8NICh+AWzqIl9sgK71GjkdkHiEjXOOdBltPngJ9hrgSOivdcpvVqETUIkTC09u7GOs7WCUEzNcrgdq3WueFrYlxiVo0ipvwriqz+fw8g1OXyDsXRx+bBPutLuLLKLxMaECUTR9BKZ9wvFFkuXEQKsjdbZQ17QrDJ4P37zaCNwaAGsxmjwYU8MK1JF+p9OvAiMRlLmk6SF8kWCj4x58gvZveftBvIUij8pHqoR5uwlvkPCK1Hlt5t7ysgHp2lxn1BiGTuldKf1+xmUkx5XMTpNS31OZ6yOg7t55bBkMs2Dr86pO8M2XW7HNZE00Yz1xna65/1Lx8gi7hb6eq52EC4uAYUtFjLmn8I6ei9DfEY3Fai6Hf6IEvv7BIMdidNFEg1kVPM1oQD2hbmhojzKdRwFOV5Xr7feewhmd1X5xGx+m4q8jcSvOT1UWfeKQbs75W8vg4SiS9chVHluSR7n9JBQ6ezhqJjBOEp3XodGFN+oIOiPRvgdZn48wTkInnvMNHUIWesUVm5YG0LJ7R10wRVdQQHRcVXei1qLqrafGvkK8Inszo26JZHiGl/snSpK2wuAdNu8wMD2JbQQW6vpo
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(1800799015)(82310400014)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2024 04:14:07.5224 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3dd63812-992c-442e-5245-08dc6027284c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000149.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8482
Received-SPF: permerror client-ip=40.107.93.71;
 envelope-from=Jiqian.Chen@amd.com;
 helo=NAM10-DM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.067,
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

Hi All,
This is v6 series to support passthrough on Xen when dom0 is PVH.
v5->v6 changes:
* Due to changes in the implementation of obtaining gsi in the kernel and Xen. Change to use xc_physdev_gsi_from_irq, instead of gsi sysfs.

Best regards,
Jiqian Chen


v4->v5 changes:
* Add review by Stefano


v3->v4 changes:
* Add gsi into struct XenHostPCIDevice and use gsi number that read from gsi sysfs
  if it exists, if there is no gsi sysfs, still use irq.


v2->v3 changes:
* Du to changes in the implementation of the second patch on kernel side(that adds
  a new sysfs for gsi instead of a new syscall), so read gsi number from the sysfs of gsi.


Below is the description of v2 cover letter:
This patch is the v2 of the implementation of passthrough when dom0 is PVH on Xen.
Issues we encountered:
1. failed to map pirq for gsi
Problem: qemu will call xc_physdev_map_pirq() to map a passthrough device\u2019s gsi to pirq in
function xen_pt_realize(). But failed.

Reason: According to the implement of xc_physdev_map_pirq(), it needs gsi instead of irq,
but qemu pass irq to it and treat irq as gsi, it is got from file
/sys/bus/pci/devices/xxxx:xx:xx.x/irq in function xen_host_pci_device_get(). But actually
the gsi number is not equal with irq. On PVH dom0, when it allocates irq for a gsi in
function acpi_register_gsi_ioapic(), allocation is dynamic, and follow the principle of
applying first, distributing first. And if you debug the kernel codes
(see function __irq_alloc_descs), you will find the irq number is allocated from small to
large by order, but the applying gsi number is not, gsi 38 may come before gsi 28, that
causes gsi 38 get a smaller irq number than gsi 28, and then gsi != irq.

Solution: we can record the relation between gsi and irq, then when userspace(qemu) want
to use gsi, we can do a translation. The third patch of kernel(xen/privcmd: Add new syscall
to get gsi from irq) records all the relations in acpi_register_gsi_xen_pvh() when dom0
initialize pci devices, and provide a syscall for userspace to get the gsi from irq. The
third patch of xen(tools: Add new function to get gsi from irq) add a new function
xc_physdev_gsi_from_irq() to call the new syscall added on kernel side.
And then userspace can use that function to get gsi. Then xc_physdev_map_pirq() will success.

This v2 on qemu side is the same as the v1 
(qemu https://lore.kernel.org/xen-devel/20230312092244.451465-19-ray.huang@amd.com/), just call
xc_physdev_gsi_from_irq() to get gsi from irq.

Jiqian Chen (1):
  xen/pci: get gsi from irq for passthrough devices

 hw/xen/xen-host-pci-device.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

-- 
2.34.1


