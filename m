Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29DD0C54E67
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Mar 2024 06:14:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rpj0n-0000X7-Cp; Thu, 28 Mar 2024 02:13:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Jiqian.Chen@amd.com>)
 id 1rpj0l-0000WM-ND
 for qemu-devel@nongnu.org; Thu, 28 Mar 2024 02:13:16 -0400
Received: from mail-co1nam11on2077.outbound.protection.outlook.com
 ([40.107.220.77] helo=NAM11-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Jiqian.Chen@amd.com>)
 id 1rpj0j-000823-5k
 for qemu-devel@nongnu.org; Thu, 28 Mar 2024 02:13:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ri7yL3fkaXFtaJNM2/0Rvzgk4ir/pH2soA/kbhMaqqeJZhTGUmv62Yw8RuG+NUT9IkwxVOd5AgZxdDxUdaW2hSPLkqgFsY2ep+2fHYPbf41bgBUgBkI+K2urp+y2D5st+HMQ4TMEU7dj5nK34Yqmki2AFvCIWTCJWhQ19ziF4Tl61A7/Gm/NHh5D6fhGSHuRfHEbXgiYHxDqHFabTJV03L7HEa27l/GCK4zuIPYJHboVuHLT3xOsMRJopDcruXgxi/uwj4V1alDbO3lOaxOeAQdQgWg4RmGsmI0C1mCksWzXAklwWjd1bpucqjh8qVw//6CG4NCNmtzmWwRzb/b8pA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0BVIA9BD2p8N+4kZSKhtmN3U4mw30lLtB421xQPF2gY=;
 b=N/Dm1ZpvhRX/t/knBN8EqtpyNxYfERkS7X9zK8WgQjgDUCiYBJHKwRXeqPCXbTzzPSpVLUoyNeq6FvK08YJUwxO4wyp6+8fC7Vk0eeyLmNT1FH+d2mD9+QwXdhMz/la56LIR/SoOaHiSUzkMS+OO0sPx7vvzpsr4yO8iRq2XQUXYJ48aXMBmDDFOnqL8TzPWKUOp4dFZAAbfYQXCY+c7VD6jLd68JEvunfAmbFa4l0RhPjGPLtQu2vNOCn0BwoN+jLE0LHTR4ErTkKaDYknZ4x9qz2vWf0NpOgouZ+KvZP87JC9ChMOIn7h3qtg5Gmg5N3trBhT1/5AfdOx9tOBzzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0BVIA9BD2p8N+4kZSKhtmN3U4mw30lLtB421xQPF2gY=;
 b=zktDnjjK4babEFP2GuTcm8S894S7w3M5yOA1PG7HR2cQ7K7CEHdZDHK6v5Of02jIZuP1prbOAZK+GtSH2PL0m9zBX4lGHSrjf9ktBnQc4PoRDtsvqIK+zpJHq+tcQAIDPXgCVj1wtVoHJ6s4OL2w79FDmTRiPp0xskXE5qA1L2M=
Received: from BN9PR03CA0388.namprd03.prod.outlook.com (2603:10b6:408:f7::33)
 by MW4PR12MB5604.namprd12.prod.outlook.com (2603:10b6:303:18d::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.32; Thu, 28 Mar
 2024 06:08:07 +0000
Received: from BN3PEPF0000B373.namprd21.prod.outlook.com
 (2603:10b6:408:f7:cafe::bc) by BN9PR03CA0388.outlook.office365.com
 (2603:10b6:408:f7::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.13 via Frontend
 Transport; Thu, 28 Mar 2024 06:08:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B373.mail.protection.outlook.com (10.167.243.170) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.0 via Frontend Transport; Thu, 28 Mar 2024 06:08:06 +0000
Received: from cjq-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 28 Mar
 2024 01:08:04 -0500
From: Jiqian Chen <Jiqian.Chen@amd.com>
To: <qemu-devel@nongnu.org>
CC: Stefano Stabellini <sstabellini@kernel.org>, Anthony Perard
 <anthony.perard@citrix.com>, Paul Durrant <paul@xen.org>,
 <xen-devel@lists.xenproject.org>, Huang Rui <Ray.Huang@amd.com>, Jiqian Chen
 <Jiqian.Chen@amd.com>
Subject: [QEMU PATCH v5 0/1] Support device passthrough when dom0 is PVH on Xen
Date: Thu, 28 Mar 2024 14:07:30 +0800
Message-ID: <20240328060731.354356-1-Jiqian.Chen@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B373:EE_|MW4PR12MB5604:EE_
X-MS-Office365-Filtering-Correlation-Id: 93f91fcf-7979-4d10-0e02-08dc4eed6fca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /ak8AN8NN6XSL8P1NXLbVfOOiJZ7CiHIB0nTU9k4g86Q+PUzOOwZvE8bmDscjty4iM1aN63q96gd7g3G7pQywCxK36yRKEvrKXVyCjYyBK0btGmcn5Rcx8G28VNmPIwi23gy3FZQKGmwH3zJ99d35QBiBxhQLVuHysJYBGLCcDz7TcKn3W6VtELqvV8S6NirO8GCdUbseK0FxEReRnmgW7Lp+uK/05uBoxJ7bSexTzo/KJap/oxWZv5XvbI3H1Fmghhk+KWIWhuSMVkW58omnEswsiUHBI2BHTI7amj8xX95oL3PTQuLVmFq7oV/LcfkiC6FIK9rWFoWBxCVWGrfZ5hGhxNmtWpoAm/Bh59K7Mm3xjRHR+giwO23vPp4TNPIcJSkFsfc7cXb8PVMQSZwSmafTuHgEDwgTcxsWAlpwgwA+eK3QsEett/67fY7jwR2NTgQVO8EXfKy7iTxfD5BMIJoI2+I7NGMXqqLQ7It2jFFyNGQTVOywH2ywnwPWdQ2GOQTtp69ib4yajXtUq1rCZU/q75KEv6lMpenKwuqFPPQwsEJEjdAGjen0XQb5VnNMo1IqI1oT1VubySecQ4OVNXK76ejJZZd5U02nSkSEwaE1Y0JZ9p1LKfqhcI4i2YzLWOMSaV2Emn6VYpCbvhQ3bh0uHuLRPG0+WItDFjGIU3BY4/+9krA/rguuECzg9Yy
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400014)(1800799015)(36860700004)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2024 06:08:06.9183 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 93f91fcf-7979-4d10-0e02-08dc4eed6fca
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B373.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5604
Received-SPF: permerror client-ip=40.107.220.77;
 envelope-from=Jiqian.Chen@amd.com;
 helo=NAM11-CO1-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
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
This is v5 series to support passthrough on Xen when dom0 is PVH.
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
Problem: qemu will call xc_physdev_map_pirq() to map a passthrough device’s gsi to pirq in
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
  xen: Use gsi instead of irq for mapping pirq

 hw/xen/xen-host-pci-device.c | 7 +++++++
 hw/xen/xen-host-pci-device.h | 1 +
 hw/xen/xen_pt.c              | 6 +++++-
 3 files changed, 13 insertions(+), 1 deletion(-)

-- 
2.34.1


