Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 148F3CAC5AE
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Sep 2025 07:09:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v22ZN-0005wj-8J; Fri, 26 Sep 2025 03:08:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1v22ZL-0005uu-3b; Fri, 26 Sep 2025 03:08:39 -0400
Received: from mail-westcentralusazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c112::7] helo=CY3PR05CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1v22ZA-0006We-Np; Fri, 26 Sep 2025 03:08:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A6ZqUpEAQ/XL0mpYmFUVjSkgJVwb0dEk3xehuhgz+1pZXEFASzXdSAnxewxhy1WAi+Q+wZgL4ld8jyxfJwQ6oVpQXUWabCiT124gaw3LMhdgDYiDmJhrE5NK3EkOEtLF2CwkOk6zoXAwCznHDvQhKsaC70hDbURuv/vqFB+hPyrkbJifWIwXBYEGhstTbHtMxmiB518geyMVoWr8xSNCNgD9vwRypcJygK4L05A8t5KYHsYHliwxGpGDuMCSpK1AXRBUnP9xPlgWX++mGJsiMLj3i+Fb8fbht7rSRQGRXVw8mpDvDi4SYcfGuVb5If9DfKrQAZ74qU+o8Uj9+KSTPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eBifPOepTWQk+a4qidhXzbsXM5XCSfsrmQ21gJOxUss=;
 b=efZnU7TSRXYMzpq4PDcinqJqoPiTTQ9J7XoUxRmqF/27mSq0NBY4DU9v4PdKKxuGWd7lgN92q/MSviUHkfvtY7G2Vpzq8OAI7H9lRQ7NenFGeFi8LFew7DNVawuR75LQ387MxZja+zHDzCsKfrA9yiPhldaIASuUZ938brCV97AlkYTEcygx3Zbrn9K7fe3BfcJR9AhPnElAfKIyJLYc2SW1TL0N4cpHvMm6y6C7iwFNoMOmEz7YfTG/uodMtbUhGScV4UqkjiEb8tID28Ju7ep5zo+fzSlfydlS13IkijxiJZD9mQRAb0I65WXAVsNZENUTPc/uU8f6F6Hyt+ntNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eBifPOepTWQk+a4qidhXzbsXM5XCSfsrmQ21gJOxUss=;
 b=CDrnlowAztINNy4/cckIF71QLJ1T9lH4IxQo924vKI2WrM8zlnuXPYrMSJexr/loqLQiZ+oBkYG1TpLK/9LTA9PFvJLxtTAFm8vWK97R7qg/iiwRXfx2NAGLnhFg98pTUlAZ1yOOOBD1E9OUvgqYvacjVOIJh6641ZvVdyhJBWw=
Received: from CH0PR03CA0252.namprd03.prod.outlook.com (2603:10b6:610:e5::17)
 by SA5PPF8BD1FB094.namprd12.prod.outlook.com
 (2603:10b6:80f:fc04::8d3) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.19; Fri, 26 Sep
 2025 07:08:14 +0000
Received: from DS2PEPF00003448.namprd04.prod.outlook.com
 (2603:10b6:610:e5:cafe::12) by CH0PR03CA0252.outlook.office365.com
 (2603:10b6:610:e5::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.21 via Frontend Transport; Fri,
 26 Sep 2025 07:08:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 DS2PEPF00003448.mail.protection.outlook.com (10.167.17.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.9 via Frontend Transport; Fri, 26 Sep 2025 07:08:14 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 26 Sep
 2025 00:08:13 -0700
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 26 Sep
 2025 00:08:13 -0700
Received: from XFR-LUMICHEL-L2.xilinx.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17
 via Frontend Transport; Fri, 26 Sep 2025 00:08:12 -0700
From: Luc Michel <luc.michel@amd.com>
To: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
CC: Luc Michel <luc.michel@amd.com>, Peter Maydell <peter.maydell@linaro.org>, 
 Francisco Iglesias <francisco.iglesias@amd.com>, "Edgar E . Iglesias"
 <edgar.iglesias@amd.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Alistair Francis <alistair@alistair23.me>, "Frederic
 Konrad" <frederic.konrad@amd.com>, Sai Pavan Boddu <sai.pavan.boddu@amd.com>
Subject: [PATCH v6 00/47] AMD Versal Gen 2 support
Date: Fri, 26 Sep 2025 09:07:18 +0200
Message-ID: <20250926070806.292065-1-luc.michel@amd.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003448:EE_|SA5PPF8BD1FB094:EE_
X-MS-Office365-Filtering-Correlation-Id: ca27217f-810a-4d47-9292-08ddfccb75db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|30052699003|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?M0dZbTNycDVZdVFzbXJDVDkwSXlyY2IvbHhrZm92ejcrbXpWT3lKeSsvcDNm?=
 =?utf-8?B?Tm04bktMZGVRenViV1k2OEhWQ0pubG5hWFErTlFMc2JObXl2cnNFeFlTSXg0?=
 =?utf-8?B?SWIzeFQ1dXFMekFpTlhmdE5kODllOXBSUmp4bDhrNW5oODRuUmpmK25SOTR0?=
 =?utf-8?B?b3pEWERJVi9yT3hSRFROS0tTZkJVTFNLY0VsWGk1MUlZS1hhb2RvQ3I3SkZk?=
 =?utf-8?B?VzdUY1hITnBGRzhLUUh6dkc0ZVlKUVBuY1ZXcUlFT1NDTWt0RjdKeVk2S0Yz?=
 =?utf-8?B?Z1UxY3lCcUN3SmtrYmF6MmtISUJCVGpFRWYwSzNrOEx5eE81M2ZZR1h5dERV?=
 =?utf-8?B?L2ZrZ3VOaGJjWkZjUUs3TWFDSHQxR2pPdEcrV3ZMaEdNWlA1b3k3QXVMeWlE?=
 =?utf-8?B?bk9SVXh0NDRTdWhjQmRmSVJ3OEZZcXRxdHZYOHp0ZFMxK1J0MDB0dERYM1BE?=
 =?utf-8?B?MExTTUhUMXBTOXdJRjlrdE1wRDl0dm1UOW1nU1F5WXRXOUpjRk51eDFFZmJu?=
 =?utf-8?B?VHdxWkpTWDdHUk1aV05HVGovZXArc2NHb0c4MnRUQTE0ZVNyeGlRUDR6VXlS?=
 =?utf-8?B?UndmclRlQjZLQVBaeWNwWXdzeGxWckFvOCtQNjk5SGNmNjRCTkpLS2o5amdD?=
 =?utf-8?B?aVlhUmVuWFh2UzI5WXpmeENXZWhmeWdROUJlbFFLTmlabHI3UnZ0a05wL3M4?=
 =?utf-8?B?UmUyYmV4T1hKazVnSDREbWxIa1JweHZNSFFDZ3VNeGlyUys2NnRUMjF2ZWpL?=
 =?utf-8?B?QnFRLzVxNlVZL240bytPcGRSNjJpRHFYbE1ia0FSWEtiRS9iVlppa1lZZWZ5?=
 =?utf-8?B?bDh0MitKRklIaHpwcHp5dUdocmtmWGIrOFBCRDhJR0FQU1pwbHhseS9BVFZs?=
 =?utf-8?B?eXVIb09UU1JkQjVvSE1Sa2huRWpmcGdOZjZmQUpYYnVpR1E4UWxUbG9uOXl1?=
 =?utf-8?B?aU90MVZZUTI3WGR0Zk9YRHlMTkNCRWdqZFlaR0lvNEpvS21HbFcxNTlBU3Zt?=
 =?utf-8?B?MUp5TzVyV1EzM2JCd0JmYUR4aUQzNWpQVFlJKytnWmEzSXY0QlFpWHpyc2pQ?=
 =?utf-8?B?aURoT2lqYi9rN0ZoamtCdEQ1YkpuWFBsU1dMT0psVStZdVgwZVAxNHpqUkZV?=
 =?utf-8?B?OEhaRUZBc1dBejFNblZ2WU0xNHZ2Zm9aVGxid1dEaWVsMERpV0R5SXFJZVBl?=
 =?utf-8?B?a01Pb2x6U0ZHc2ZuYyszY1NzY0g3emZlamxicVNiM0xjdmlsa2YyYW5CUExH?=
 =?utf-8?B?NjRtbWxvTmZQTFZhVE9LK1l1a1k1Nk9pU2F3ZGF3VThMQzh3S2RiY2VNZFli?=
 =?utf-8?B?Ui9lakhSYTFycDZySzh2YjhFSjh0Y0F0bFNWUU90WkxJZUcvS1E4YmUvS2w2?=
 =?utf-8?B?YVk2VWhYMkFJbkY1QmJVVFZYK0F5U00rc1M3V203RmRadHowSGZyWjVXN2JQ?=
 =?utf-8?B?NnNpWGZjS1hpekltSkxwN1dRR2g1OUljdEhva2hEcGwvTG52UGRWVythN3hD?=
 =?utf-8?B?NnRxTHlteGhEU3UxSmYwSERCbG1GelFKVVh3SmRqK1VnQlNqbCtqZVpSSmRv?=
 =?utf-8?B?UHFwSUhjaW9DT3k0VzFzTXFxNGpSR09oSXRVRmZDVXM4Q0RmQTBFRFc5WklZ?=
 =?utf-8?B?TzNaS2laN1hVQmxLM1hhUEJWWjBHWXdwUlFKTG1IUnN3UnUrcGF5M3hudmZC?=
 =?utf-8?B?bHo5SDFNSHRXTzRPdGlBL3QwbVJQV2xyNDdqSVJ6eE5XbFNZQ0J3ZWdYeVlK?=
 =?utf-8?B?TFI0ZzRTMnk2YU8vT0pocnl2Q0EvWWNvZnRXMVdPSXNyZnNyK3FtWFNiRndT?=
 =?utf-8?B?cXdLeGFZZ1d1aDhqTUpodWk3bXdUeW5yZjk3TjI5VnErcy9CN29ZdEZUMHln?=
 =?utf-8?B?SGRHWGlwMFRUNEZXNkp3SG16bDJrMjdxbFFUT2dCY0F3RWFiS0RKWnBaUkIv?=
 =?utf-8?B?VjdEckY3SS8zWGhncElXa1BkNE1xclRGUHVSdkVMU2pNRlV0YS84REdZQWdE?=
 =?utf-8?B?T1FLLzFrVElmY09hZG9xYjYwS2tUeXJuaUlmWENrYVNneFBRR2NUVkdxR2c3?=
 =?utf-8?B?TFVjbVZXTXprTU14NEREQUxYZUJMQlYzVmFXbE1GbUhZWDhpZHVnazJ1OXpj?=
 =?utf-8?Q?B7dI=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(30052699003)(82310400026)(376014)(1800799024);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2025 07:08:14.1551 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ca27217f-810a-4d47-9292-08ddfccb75db
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003448.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPF8BD1FB094
Received-SPF: permerror client-ip=2a01:111:f403:c112::7;
 envelope-from=Luc.Michel@amd.com;
 helo=CY3PR05CU001.outbound.protection.outlook.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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

v6:
  - assert that the SoC user provides an FDT instead of creating a
    dummy one. [Edgar]

v5:
  - Patch 36 (xlnx-versal-crl versal2 version): replaced `return NULL'
    with a `g_assert_not_reached()' in the versal2_decode_periph_rst
    function. [Phil]
  - Fixed remaining memory leaks in the Versal SoC by adding a finalize
    function. [Peter]
  - Patch 39 (cortex-a78ae addition):
     - Switched to the last r0p3 revision.
     - Removed the CBAR_RO and BACKCOMPAT_CNTFRQ features.
     - Fixed the comments referring to TRM sections. [Peter]

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
 hw/arm/xlnx-versal.c                         | 2470 +++++++++++++-----
 hw/intc/arm_gicv3_common.c                   |    3 +-
 hw/intc/arm_gicv3_cpuif.c                    |    2 +-
 hw/intc/arm_gicv3_kvm.c                      |    6 +
 hw/misc/xlnx-versal-crl.c                    |  602 ++++-
 target/arm/tcg/cpu64.c                       |   78 +
 tests/functional/aarch64/test_xlnx_versal.py |   12 +-
 13 files changed, 3071 insertions(+), 1660 deletions(-)
 create mode 100644 include/hw/arm/xlnx-versal-version.h

-- 
2.51.0


