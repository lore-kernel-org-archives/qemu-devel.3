Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59A10C4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2024 22:52:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rwreu-0000Oe-16; Tue, 16 Apr 2024 18:52:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1rwres-0000O2-6l
 for qemu-devel@nongnu.org; Tue, 16 Apr 2024 18:52:10 -0400
Received: from mail-mw2nam12on2083.outbound.protection.outlook.com
 ([40.107.244.83] helo=NAM12-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1rwrep-0005B2-He
 for qemu-devel@nongnu.org; Tue, 16 Apr 2024 18:52:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jhpgl52UkzG7Bg2252OkQytw3GB6dwBcPdvc8poXKO1RkpyjnYZ1w9dl7kmjJFSgBqEozjgwNAstcX6UPD6S3QtEnlvmbrV4fj5b6kDujX3gDGoYcAsbLMQztHbI1HnipsJaWw/9o0Nvl9DCKkJdrtWHtmQOLHXyXqBN47VNorQLofzqcDDxIupVpqUiEaq6nQ1UosNC6cRUEXl0yXFY0JUkEBlREZs6PvBrbCVxuWtZhiTbzS8gk5y3KBsrpBzj2jOEb0A7zRJuzWgZVXBUrNTKj6rgD6PJQLovRqKfMoYJYqUsgj71DLehUcXLSXX4wSfl6V7t3ggF1ORplambYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U54vD4KqdvnSR2hWjEAIVS9y0aeVIbLa5YGH9QS5r2c=;
 b=JNSgDQ1HNfeVpQMAlzdRhBEtD8AOrlg5momvnThG1Z24hgFq0WOYRQUqyPs8DhQ7LUbxo0mo6Aoo0v10pZIxdTNJ+nG0dmjTZb2TSRFCf+K88j9UCoyznQIND80AcMLVyAy7E22jlVswNKWMbPD9VOEwYRv7/ViIIdq1kC42HppCplnjIRvVQfLSC4wFrNORSCXmkK35A6PvB5rcmIBI30EY5UL0zppkWabu8jVwpA0KNUihRNf5Vym6drAaXhN42462cgH5dRnBhXoEs9NXzQ56w+/3sQ5lXnSnMEWUHBEMsI0fcF3MK+OpSzlwDYeVLH69xqOFEKILB3hlJPPAlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U54vD4KqdvnSR2hWjEAIVS9y0aeVIbLa5YGH9QS5r2c=;
 b=wFGk6ZhHlkIGUXk4YsGY2UgvExT0l+IgH9aqp9DIpfAdFUgIXtyS5p2MELVxpRpQatwEiZoRIv3UitiWqiHeOmpW4EezWcvoZSk1nF+a8MRFif8sBNI3EAHXs4MpDyA8k+u3xQTLiQl5zsS8OvFHHp/WGfNh9zBb8p5b3YAwzg4=
Received: from MW4PR03CA0225.namprd03.prod.outlook.com (2603:10b6:303:b9::20)
 by BL1PR12MB5873.namprd12.prod.outlook.com (2603:10b6:208:395::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Tue, 16 Apr
 2024 22:46:58 +0000
Received: from MWH0EPF000971E2.namprd02.prod.outlook.com
 (2603:10b6:303:b9:cafe::87) by MW4PR03CA0225.outlook.office365.com
 (2603:10b6:303:b9::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7495.20 via Frontend
 Transport; Tue, 16 Apr 2024 22:46:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000971E2.mail.protection.outlook.com (10.167.243.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Tue, 16 Apr 2024 22:46:57 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 16 Apr
 2024 17:46:55 -0500
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [ANNOUNCE] QEMU 9.0.0-rc4 is now available
From: Michael Roth <michael.roth@amd.com>
To: <qemu-devel@nongnu.org>
CC: <peter.maydell@linaro.org>
Date: Tue, 16 Apr 2024 17:03:12 -0500
Message-ID: <171330499284.1368321.18207482380177884895@amd.com>
User-Agent: alot/0.9
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E2:EE_|BL1PR12MB5873:EE_
X-MS-Office365-Filtering-Correlation-Id: ee6a4459-27f1-4c3b-ccb3-08dc5e671ef6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: c70dyuB9zqF0qjuOHsn+hc26nMv0Z2guaU3zxWVjQozpmCbIUUinxSuFg2IFM6/Gb7SxmlNbkJ/Kq64Fducl9ARxpiPMAV3s3zEqUW+7QuRxPTX9RfIRSt80Kk4YiKF1HjUnib/jc8zMxmrfkdkyAqusixWc/bX6kro2B+iEgksjezMjGtTYt+aaRk13opdPxDKGHbomyHIEDxl1rvPjdliu3yJl/eWOQwKs+tTW2OcvrVMd4LChtUi6svngnNz55BPL9RGkG4qLYLpc9dU5T+qybovV5L/AYFz+rJHov+4e6Knyr3xL0sqArARBpAvat7KPe/25OQjYsSMRcPZjR0q+EjAB8Grq6at0cUbrbGiV9RMmybpF/TBkWk1zM6IdlML5TOp8XYX0Qrp0YAu0buJld/h1C82RnH2Lel2Id+PtdmvHp0g4ia5Vsa8N36BFjvqAiY6R3DsASBVAQFIiXScqS7eGOFNrWtp/WOt0IKLJcJYMRVR1Wv4xyaYKW4ACFZhdpjaUgSCVProTc+FGprBLPNJ6dbMu01ArTX4H5rx6UKqqzbf3pY70vW7HKXuIfaCuVQRKz9qb7IitTHmYqQ7PZbugG/ILfDLl9ej16Xdd+/5U1f3HjHZ2nLpXZpEh4/EjHB7xpAXb1gDB+hwfazwnK6csReioQcSY0E25ZR72aW+IClOqgmuBc0mdtWR1PQ6kH7NdjJdsnNc4jzeTGw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(1800799015)(376005)(82310400014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2024 22:46:57.2338 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ee6a4459-27f1-4c3b-ccb3-08dc5e671ef6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E2.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5873
Received-SPF: permerror client-ip=40.107.244.83;
 envelope-from=Michael.Roth@amd.com;
 helo=NAM12-MW2-obe.outbound.protection.outlook.com
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.844,
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

Hello,

On behalf of the QEMU Team, I'd like to announce the availability of the
fifth release candidate for the QEMU 9.0 release. This release is meant
for testing purposes and should not be used in a production environment.

  http://download.qemu.org/qemu-9.0.0-rc4.tar.xz
  http://download.qemu.org/qemu-9.0.0-rc4.tar.xz.sig

  http://download.qemu.org/qemu-9.0.0-rc4.tar.bz2
  http://download.qemu.org/qemu-9.0.0-rc4.tar.bz2.sig

A note from the maintainer:

  rc4 contains a handful of final fixes; we hope to do the final
  release next week on the 23rd.

You can help improve the quality of the QEMU 9.0 release by testing this
release and reporting bugs using our GitLab issue tracker:

  https://gitlab.com/qemu-project/qemu/-/milestones/11

The release plan, as well a documented known issues for release
candidates, are available at:

  http://wiki.qemu.org/Planning/9.0

Please add entries to the ChangeLog for the 9.0 release below:

  http://wiki.qemu.org/ChangeLog/9.0

Thank you to everyone involved!

Changes since rc3:

62dbe54c24: Update version for v9.0.0-rc4 release (Peter Maydell)
a12214d1c4: usb-storage: Fix BlockConf defaults (Kevin Wolf)
6e4aceba20: hw/pci-host/ppc440_pcix: Do not expose a bridge device on PCI b=
us (BALATON Zoltan)
f33274265a: hw/isa/vt82c686: Keep track of PIRQ/PINT pins separately (BALAT=
ON Zoltan)
2ce6cff94d: virtio-pci: fix use of a released vector (Cindy Lu)
2786a3f8d3: target/sparc: Use GET_ASI_CODE for ASI_KERNELTXT and ASI_USERTX=
T (Richard Henderson)
2d6d995709: meson.build: Disable -fzero-call-used-regs on OpenBSD (Thomas H=
uth)
f9a7c4478c: Makefile: fix use of -j without an argument (Matheus Tavares Be=
rnardino)

