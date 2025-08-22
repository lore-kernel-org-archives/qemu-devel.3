Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D4A2CA0EEB
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Aug 2025 15:17:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1upTVP-0007V2-DM; Fri, 22 Aug 2025 11:16:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1upTVO-0007Ul-Gv; Fri, 22 Aug 2025 11:16:38 -0400
Received: from mail-bn8nam11on20602.outbound.protection.outlook.com
 ([2a01:111:f403:2414::602]
 helo=NAM11-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1upTVK-00076D-1y; Fri, 22 Aug 2025 11:16:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U57W6LPN/feRyF25P00taUVvpE395lGdCmnGtG/TvVipg2IJvwnf2kgZpgeoUzOVbK8r3OlPtaI6CFyMKvi0k9WAX47+pS+gtaYPQDmBwOIOKFAwktgJp6B4ClISOr3+C4mVeIKxhsNjMdhytEVS9p+fAD9+9tHvpcKczNE4E+HvNrrN4LR6ohFeei8Vvst7N8FqyDyY31hfD62NVYEGHfB1tggcLBCjGZvfnml0Ek4JHkmvLSvokhJWWJHQDNcOF9OZRp+EJL03sOlBi0FvL1D7G/Ef2IbfawOEvdYwoSOKYsR5C4wKUEwqJaMnMYKIkdPZ4w5+5GJRY0srtp3Y/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c3LbXuLp/N6gjzse6GGImV9crlpriD7T17nP0TWmtlA=;
 b=eOUdjPDVrsz5yBnSzFKLgODFqU+sR66OtwOtGCDVFrSQTO0Jarc04JL/I1b+4/NxArQCyu8T7dPUseuDlX+U4xzR5XXfwUhjg8bpdhQMuBrT53GRptX3WdaAW9xlEUInama7rPO2HfBzEBCkaEJ7sFqDs5IZaEhIJYsKWA3RC7FC1SNkCORaot7u/7n/w321nZqmjO3B6le3FTCrop9qJMJNwP3b2paXOFUmLxQny0AlrguvLrgNiMimaChgfVhDW1pSuR1dGbNwUguTiXwSE/VGbsHUHA5+P7YRAP8txT184IaXoMWBWbpd/Exw8eg9GcAFLTHujOJmEvzb6AEZug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c3LbXuLp/N6gjzse6GGImV9crlpriD7T17nP0TWmtlA=;
 b=5ZFiHzcadq7oJB/kii2S05+UlvdSIorf176KJeBVsxEnBo58QkZDp0mAfMaa1XphUdSuNH8xrAsctosfDtuQGM/DpJPMiH2hCtYi3kqAf1hzDS1K4V19wpxcNLrv0vAATDuqYqbMaLdnvDytXp2AVcMB3RoK7UAo74lJMgtpUsQ=
Received: from DM6PR12CA0013.namprd12.prod.outlook.com (2603:10b6:5:1c0::26)
 by DS7PR12MB6239.namprd12.prod.outlook.com (2603:10b6:8:95::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.14; Fri, 22 Aug
 2025 15:16:25 +0000
Received: from DS2PEPF0000343E.namprd02.prod.outlook.com
 (2603:10b6:5:1c0:cafe::16) by DM6PR12CA0013.outlook.office365.com
 (2603:10b6:5:1c0::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.18 via Frontend Transport; Fri,
 22 Aug 2025 15:16:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF0000343E.mail.protection.outlook.com (10.167.18.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.8 via Frontend Transport; Fri, 22 Aug 2025 15:16:24 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 22 Aug
 2025 10:16:24 -0500
Received: from XFR-LUMICHEL-L2.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Fri, 22 Aug 2025 10:16:22 -0500
From: Luc Michel <luc.michel@amd.com>
To: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
CC: Luc Michel <luc.michel@amd.com>, Peter Maydell <peter.maydell@linaro.org>, 
 Francisco Iglesias <francisco.iglesias@amd.com>, "Edgar E . Iglesias"
 <edgar.iglesias@amd.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Alistair Francis <alistair@alistair23.me>, "Frederic
 Konrad" <frederic.konrad@amd.com>, Sai Pavan Boddu <sai.pavan.boddu@amd.com>
Subject: [PATCH v4 00/47] AMD Versal Gen 2 support
Date: Fri, 22 Aug 2025 17:15:25 +0200
Message-ID: <20250822151614.187856-1-luc.michel@amd.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Received-SPF: None (SATLEXMB04.amd.com: luc.michel@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343E:EE_|DS7PR12MB6239:EE_
X-MS-Office365-Filtering-Correlation-Id: ebe7ed04-02b7-4711-39f4-08dde18edc18
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?U2w0NGNKbGZYWWNHSUYxdWN1TWxPZy9obUZwNWR1QnIxa3Yyc09ORUQxNVdC?=
 =?utf-8?B?VnlPQllyRXhSemdxTFhlU0svQ2Q5M2hCYzFNRjdzaXlZNyt4MnVGMkN2aGVB?=
 =?utf-8?B?MDE0KzN5U1BqYjFsNUtjaGUrOW5CczJBT3h4VDdrWllWaUJiM0ZIRXBLR1NM?=
 =?utf-8?B?T282Myt4Wnd6ampHdkZMSFdlS2YrVzRaS05Yb2xydjNXSHRBZ1h4ditMc0Zm?=
 =?utf-8?B?bHVYOU5vMVlUTUE5YkFPajlKOGJYVWZXMFgrQXhvNUd4ZzdiOGpOSkFPYUdS?=
 =?utf-8?B?NE9XejVINmlPZEhOWkE0NUl4UnMzR3dWc3VhaG1VMXVpWEF5VytQMUNYVDlt?=
 =?utf-8?B?WFBrMzB0Rkl6ZTdXZHdHbjB1MTBBZmw4aHQrQ3lZSURYWEh5cG9ScTZacTVD?=
 =?utf-8?B?Tjlkc3JDNXludHhCbzRwVlp2QVdkekdtdGc0dkNRaTlLS3BxVkVEbXVwTE9h?=
 =?utf-8?B?cXpiR21ZZmJqWTZDZEh2bFY1VGFnZ0dCK3NFWlJ6WHZSMDlhdFZ6WkFtNTMx?=
 =?utf-8?B?MFNCQVlGR1FvbGpoT1pnNUJaQ2FXMWVWY0NqdEgyZDZJSlRUU1NUZU1VREsr?=
 =?utf-8?B?ZzN0M21FNW52TUZFYVk1QXhhVXpwRy9jQzlZY3dSRjc1ZkYxRUROMHhRWUgw?=
 =?utf-8?B?YkxhOTlrNFlBajQ5NmU5VjNsdmNMdkRNOXVQR25CNFdQdmhmbUpKSVcvNjdV?=
 =?utf-8?B?UEREcngvbDVLZVdJbWZGZHZUblFvbWttVjNtOFFGM2VxeFZZaW92UGswaVpZ?=
 =?utf-8?B?cHlGZC9tbllrVGVHMEtpWG1GL3pBNGNuQTlpU2NsK0hiVkNqYm5QajBhUW9H?=
 =?utf-8?B?K21qS1p4SWZkelNkR05rVy9sd3NmNVdyMm1mc1BuVFdoVWVvUWxzWlJKMUN0?=
 =?utf-8?B?MWpJTlUvWkJrMzJ0RkNXSS9VWU1sT3hwdnh5bmhJS1BPamdzNTBXejdaaTF0?=
 =?utf-8?B?c0RkV3l6c2pCZm01OW95U2tQcGU1V1E2RTFoZVI1SXhhS0tGaTFZUGoxVk9D?=
 =?utf-8?B?NFdzRU5qcGdiYk12ZXFYTVlWVGdlcXFUOWx5Y09jVHVCUmRibEE3Syt5UGs4?=
 =?utf-8?B?L2JSSGJ0OTFLWHpkdkNpOE5JSGw1MFBkWjE4Vm5zeXNrN2l4VzIwbXk2MEpX?=
 =?utf-8?B?TkU1Ym9mNjdvVXZPbGpqRHdWZngwN1BsMUM2M1FCUUhKOEt1dXVmR0tsOHBL?=
 =?utf-8?B?d0JPVk1yVGZ0TnlxTEJ4VkRZYW02S2tmbmpTcFlycUYrTFF2WjQ3aG9CdkV4?=
 =?utf-8?B?NVZMV3NZajMyanlMMnVnM1RleTBFOWdxNWtFU09YRUNJT0FHbFVlUWt2WXE0?=
 =?utf-8?B?MzI2T3ZwN2JGZG9hZmNoRG1XSUpXRkFOcTZsdWpUQmR2cUV4bkhVcTlSUGU4?=
 =?utf-8?B?dGZZTEZ2NlE4amFLem1xR2NqMGlaMVhIc1hqbnJqY3YrVkR4Q08wWlRpNEJu?=
 =?utf-8?B?dE52MkhHNXVqazVCRmpqL2xZbXpWOHJmVVlWOVVEcHVxUXRjUkdOYUZkTWMx?=
 =?utf-8?B?ZTVLVXdGYkxUTE5YdDVvM2gxUjZYZjVPalc0U04vMHRvVEtBNHJqekhqeURk?=
 =?utf-8?B?UXJQTzByV001ZURxL2g2ZzdUWlhpaGQ5Q3FUN3pZTkRWTDdEK3U0aVkyb2R3?=
 =?utf-8?B?RW9jeVN5VFFObmZHSG9Sb2cxbDNuQ05kODBJNVN1a3hmOE9XNWkxWnd4ajBI?=
 =?utf-8?B?em5yMEFRWDE2RUVOK3V3dmJ3dEJaaVZEVGxxSVVVNnljS0p6WWRNbmhhYTZI?=
 =?utf-8?B?KzlKditRSUhUV2N4OFh5UWR1WlZ5V1NkTXIydTFOVkJNNlBsWWx5aHg1Yjdo?=
 =?utf-8?B?a0s3UnZYOHJlR0JUNDBMZUV3NENRTEw1QXlWSU5MTVUwVGMzcVl2MzZaNnNv?=
 =?utf-8?B?djQvcTAvWXo0alkzcC8vMmtsWitQTUJDRnMxajRTN3lWQ0FkYzNEZmJnQndY?=
 =?utf-8?B?cDRKWTFPSDFSUmJSemFzWTRjWlBlVWpFR1FmVE12UC9xMURpL0ZCc3ordk42?=
 =?utf-8?B?dThvckdENGpwdTZPUFR5MkhLSXFWNTdCdnNTNGV4cVdLaTMvMXBjRFpaSG9u?=
 =?utf-8?Q?qDbHG4?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2025 15:16:24.9854 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ebe7ed04-02b7-4711-39f4-08dde18edc18
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF0000343E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6239
Received-SPF: permerror client-ip=2a01:111:f403:2414::602;
 envelope-from=Luc.Michel@amd.com;
 helo=NAM11-BN8-obe.outbound.protection.outlook.com
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

v4:
  - Fixed compilation issues and runtime crashes in 3 intermediate
    patches. [Edgar]
  - Introduced a small hack to keep the GEM FDT node order as it was
    before. This is to avoid kernel iface name swapping (eth0 <-> eth1)
    in Versal. [Edgar]

v3:
  - Dropped qemu_get_cpu() usage in the machine code. Added an getter on
    the SoC interface to retrieve the boot CPU instead. [Phil]
  - Cleaned the mp_affinity logic. Drop the mask attribute and assume
    it's always 0xff (the Affx fields in MPIDR are 8 bits long). Use the
    ARM_AFFx_SHIFT constant instead of hardcoded values in .mp_affinity
    description. [Phil]
  - Avocado test renaming in patch 41 instead of 47. [Phil]
  - Documentation tweak. [Phil]

v2:
  - Addressed formatting/typo issues [Francisco]
  - Patch 23: GICv3 first-cpu-idx: addressed the KVM case by bailing
    out if not 0 at realize. I chose this path as I don't have a clear
    view of what it means to implement that for KVM. It seems to make
    sense anyway as this property is meant to be used for modeling of
    non-SMP systems. [Peter]
  - Patch 39: added a comment to clarify cortex-a78ae != cortex-a78 [Peter]

Hello,

This series brings support for the AMD Versal Gen 2 (versal2) SoC in
QEMU. This SoC is the next iteration of the existing Versal SoC.

It is organized as follows:
  - The first and biggest part of the series performs refactoring of the
    existing versal SoC implementation. This consists in:
       - splitting existing device types into base/concrete classes,
       - moving from an in-place to dynamic device creation approach in
         the SoC code for flexibility,
       - describing the SoC using a new structure called VersalMap,
       - moving the DTB creation logic in the SoC code itself alongside
         device creation.
    Patches are split such that each device is individually converted to
    use this new approach. Behaviour changes are minimal and are
    emphasised in the commit messages. This gets the SoC code ready for
    versal2 addition and leverage the fact that Versal family SoCs are
    quite similar in term of architecture.

  - versal2 SoC support is then added by adding the corresponding
    VersalMap description. This allows to reuse the existing code
    without duplication and almost no special case.

  - The amd-versal2-virt machine is finally added, following the same
    idea as amd-versal-virt. The documentation and tests are updated
    accordingly.

Note that the xlnx-versal-virt machine is renamed amd-versal-virt to
follow current branding guidelines and stay coherent with the new
amd-versal2-virt machine. The xlnx-versal-virt name is kept as an alias
to amd-versal-virt for command line backward compatibility.

Thanks

Luc

Francisco Iglesias (1):
  hw/intc/arm_gicv3: Introduce a 'first-cpu-index' property

Luc Michel (46):
  hw/arm/xlnx-versal: split the xlnx-versal type
  hw/arm/xlnx-versal: prepare for FDT creation
  hw/arm/xlnx-versal: uart: refactor creation
  hw/arm/xlnx-versal: canfd: refactor creation
  hw/arm/xlnx-versal: sdhci: refactor creation
  hw/arm/xlnx-versal: gem: refactor creation
  hw/arm/xlnx-versal: adma: refactor creation
  hw/arm/xlnx-versal: xram: refactor creation
  hw/arm/xlnx-versal: usb: refactor creation
  hw/arm/xlnx-versal: efuse: refactor creation
  hw/arm/xlnx-versal: ospi: refactor creation
  hw/arm/xlnx-versal: VersalMap: add support for OR'ed IRQs
  hw/arm/xlnx-versal: PMC IOU SCLR: refactor creation
  hw/arm/xlnx-versal: bbram: refactor creation
  hw/arm/xlnx-versal: trng: refactor creation
  hw/arm/xlnx-versal: rtc: refactor creation
  hw/arm/xlnx-versal: cfu: refactor creation
  hw/arm/xlnx-versal: crl: refactor creation
  hw/arm/xlnx-versal-virt: virtio: refactor creation
  hw/arm/xlnx-versal: refactor CPU cluster creation
  hw/arm/xlnx-versal: add the mp_affinity property to the CPU mapping
  hw/arm/xlnx-versal: instantiate the GIC ITS in the APU
  hw/arm/xlnx-versal: add support for multiple GICs
  hw/arm/xlnx-versal: add support for GICv2
  hw/arm/xlnx-versal: rpu: refactor creation
  hw/arm/xlnx-versal: ocm: refactor creation
  hw/arm/xlnx-versal: ddr: refactor creation
  hw/arm/xlnx-versal: add the versal_get_num_cpu accessor
  hw/misc/xlnx-versal-crl: remove unnecessary include directives
  hw/misc/xlnx-versal-crl: split into base/concrete classes
  hw/misc/xlnx-versal-crl: refactor device reset logic
  hw/arm/xlnx-versal: reconnect the CRL to the other devices
  hw/arm/xlnx-versal: use hw/arm/bsa.h for timer IRQ indices
  hw/arm/xlnx-versal: tidy up
  hw/misc/xlnx-versal-crl: add the versal2 version
  hw/arm/xlnx-versal: add a per_cluster_gic switch to
    VersalCpuClusterMap
  hw/arm/xlnx-versal: add the target field in IRQ descriptor
  target/arm/tcg/cpu64: add the cortex-a78ae CPU
  hw/arm/xlnx-versal: add versal2 SoC
  hw/arm/xlnx-versal-virt: rename the machine to amd-versal-virt
  hw/arm/xlnx-versal-virt: split into base/concrete classes
  hw/arm/xlnx-versal-virt: tidy up
  docs/system/arm/xlnx-versal-virt: update supported devices
  docs/system/arm/xlnx-versal-virt: add a note about dumpdtb
  hw/arm/xlnx-versal-virt: add the xlnx-versal2-virt machine
  tests/functional/test_aarch64_xlnx_versal: test the versal2 machine

 docs/system/arm/xlnx-versal-virt.rst         |   80 +-
 include/hw/arm/xlnx-versal-version.h         |   16 +
 include/hw/arm/xlnx-versal.h                 |  342 +--
 include/hw/intc/arm_gicv3_common.h           |    1 +
 include/hw/misc/xlnx-versal-crl.h            |  378 ++-
 hw/arm/xlnx-versal-virt.c                    |  741 ++----
 hw/arm/xlnx-versal.c                         | 2465 +++++++++++++-----
 hw/intc/arm_gicv3_common.c                   |    3 +-
 hw/intc/arm_gicv3_cpuif.c                    |    2 +-
 hw/intc/arm_gicv3_kvm.c                      |    6 +
 hw/misc/xlnx-versal-crl.c                    |  602 ++++-
 target/arm/tcg/cpu64.c                       |   79 +
 tests/functional/test_aarch64_xlnx_versal.py |   12 +-
 13 files changed, 3067 insertions(+), 1660 deletions(-)
 create mode 100644 include/hw/arm/xlnx-versal-version.h

-- 
2.50.1


