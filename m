Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 843AECA101F
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Sep 2025 10:02:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ux0bB-0004vw-6P; Fri, 12 Sep 2025 06:01:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1ux0az-0004uk-Ap; Fri, 12 Sep 2025 06:01:33 -0400
Received: from mail-dm6nam04on2062d.outbound.protection.outlook.com
 ([2a01:111:f403:2409::62d]
 helo=NAM04-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1ux0as-0000zP-6k; Fri, 12 Sep 2025 06:01:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s9nTtx1ap/Uh3LS39TxtIJQdFxmsg5g5vcmABH6oTC0awHuFIl2YoOXOpWT0KndZdn/C9Qf3TG4WtvnNIeGFca8La7ggEVviGbnZaebXlQ1SJ9Jn0V9YbG/o4BiLc6440FMbdm+3ISsbbYitaJGEESEvTNO+lHbVn89a4Erd+KEqWrd7xWTUNo6vSlwiO2Z3k3Mhn/9LbONM5Wg5xXauPzZTQQ0Nu9gPJZkcvc/8v3r01mChqaH7n0d+2DakilyHSQeGWlK+taLeWSvtteW8jgZbHpxqccNfTuJzC3llxkImldu0tkNyceqbWgCsS7lH0TllG3pFwtsh800aeZWhQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8KSxdbcgPsV9RceLBjfI9aBpisvYlX2OubIMYU2MiSs=;
 b=hMhRaVNxbB67jWz5ldCtlrSjZ8dp6bs9w96cK62uhw+kutZ1NlDRs8WxWq8Vkz/FWT0O9umW0OjipM2ZZFtlm3Z6hYOmOaFHL0kx3a2xkR4QsQissaimZLoLhHRcLDQF0yckFYrCA0/CylgFmwOadx3OzrYxSjsBX7jIQgXaW9htSGO4U2E6maWg7fOqqcUdGeY7z4BXJZu5xK8p46djjBuVOVqZqP6PVezOhaAspaNgsbgbtZ6JQTjXa/52ITYLT0tAXCxavCy67lm4ftDZ9XHMOu+JjgzpBMj4hO4zQuevGWgcXhCnV2ZJAUuOHqYX3LljcASrW++xzyP0DoicNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8KSxdbcgPsV9RceLBjfI9aBpisvYlX2OubIMYU2MiSs=;
 b=bRE/Mue+SO43aaG7H+imh8rcLeUG6BKwdnVxvAHJGAH5XtLLK6pFg8sT3JQY7V4HHr8wIHKTmOjhZaHW3qmma4Oc26Nn65IWo6NMMA+cScr/mNpp14WXuVWESNMA27pvB/A/oq1CZVPRW2zWuuatticDOKmnDY4dK4k1XiIBI5A=
Received: from DS7PR03CA0038.namprd03.prod.outlook.com (2603:10b6:5:3b5::13)
 by BY5PR12MB4195.namprd12.prod.outlook.com (2603:10b6:a03:200::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Fri, 12 Sep
 2025 10:01:15 +0000
Received: from DS1PEPF0001709A.namprd05.prod.outlook.com
 (2603:10b6:5:3b5:cafe::14) by DS7PR03CA0038.outlook.office365.com
 (2603:10b6:5:3b5::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.22 via Frontend Transport; Fri,
 12 Sep 2025 10:01:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 DS1PEPF0001709A.mail.protection.outlook.com (10.167.18.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.13 via Frontend Transport; Fri, 12 Sep 2025 10:01:14 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 12 Sep
 2025 03:01:14 -0700
Received: from XFR-LUMICHEL-L2.xilinx.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17
 via Frontend Transport; Fri, 12 Sep 2025 03:01:12 -0700
From: Luc Michel <luc.michel@amd.com>
To: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
CC: Luc Michel <luc.michel@amd.com>, Peter Maydell <peter.maydell@linaro.org>, 
 Francisco Iglesias <francisco.iglesias@amd.com>, "Edgar E . Iglesias"
 <edgar.iglesias@amd.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Alistair Francis <alistair@alistair23.me>, "Frederic
 Konrad" <frederic.konrad@amd.com>, Sai Pavan Boddu <sai.pavan.boddu@amd.com>
Subject: [PATCH v5 00/47] AMD Versal Gen 2 support
Date: Fri, 12 Sep 2025 12:00:09 +0200
Message-ID: <20250912100059.103997-1-luc.michel@amd.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709A:EE_|BY5PR12MB4195:EE_
X-MS-Office365-Filtering-Correlation-Id: 7acafb50-56d1-4703-0fe5-08ddf1e34f61
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WGdBYitiWExsRnJDTDBUOEVlekhTUkRLVkRRNTJvYTZjekU1QUZxUVJ3cEIz?=
 =?utf-8?B?N2kyWG9MZWxkQ0l0OUZ2USt2ZVdpSHBSTHdOZ0RzTHZManZscFNhR0RtdTZO?=
 =?utf-8?B?dFhXZWRFOUdJRnhQNklYUUdPdlJyRXdqS20zc0Zvb01VME5iZFVaWC9NOWh3?=
 =?utf-8?B?SFJmbDFHdWd1OE1UNU45K3N2TFh3WWFNQlQ4c1NIMnhXRThlNTQ4NHpiSGhC?=
 =?utf-8?B?K290cXE1bng4K3E4SXQ4ajFhY01xUHc1RkJrUUs0elFTOEFIeTlzVTYraURQ?=
 =?utf-8?B?Ujh6WnNLNlp5N0oraGhLcER5cnNlaDRJRkgzRjRuenFuUmJyNlY3bXFvY1NN?=
 =?utf-8?B?S2JCQzU3a0xnckxFUFM0b0s1a3lNR0RjSjgyQjQzL1JqNENBSVE5L2lVQlp4?=
 =?utf-8?B?MjRnZ2RXRTFVK1NJVDN1NXRmdFV2ZVMwK1lqTTgxWjdldER0MGhQMU51bFVs?=
 =?utf-8?B?azBJNmt0dG1rUEFhSzJrYTdkSXA1RlpmdDBhVkdGMWlBVlVVaXNBM1NuWEVk?=
 =?utf-8?B?K2xzS2pwWU5WSVVlU1dXZm9sbHNGMUlKb0YvWW9qblJ5MUM4dG83MjFTZUJF?=
 =?utf-8?B?ZCtMbHVwMjE5RzVDWmUrOUsyNit3T1F3TlZGM2diT2p6VDZiYmJ6VDRvMk1D?=
 =?utf-8?B?ak1mQ0dZdGpnYkVZUVZDTEYvK0dUSjZJRVdJalNoZlM5QlBpRVdGbFBPY0Rv?=
 =?utf-8?B?U0RGaThIWVlKc3cra3Z4OVBYaDl6T0tSNXJtUms1VG5WZUs2UTF3dXZ2K2xr?=
 =?utf-8?B?SUJDZ21jZTdFQUhUaTlzMnBaa2gzTm9uaVlvOHFCd2txZXVndVFtZDkxbUs5?=
 =?utf-8?B?V1MwT0FkUVJEdTBwcUIzbmhTaDVBanpxMTgwc0ZNa0FZYnprNk15R3Y5RmhP?=
 =?utf-8?B?Y2VKaDBGc3hCZXo3ZFgxZ0JpWThPWk1nbWZ2TnUzM24wKzk2K1d0SVQ3d2Zh?=
 =?utf-8?B?ckRXSzd2Vmk4ZE5OdGNHYzh2SEozU012Y244Z2xwT2FoRGYzRFhHVWZkcFFC?=
 =?utf-8?B?S2ZIS0lsTkdhem8xUWttQnpvMUlzWFYrM0JOVUxGRHFQb3pTSTE5NE8xMzJi?=
 =?utf-8?B?ZHpjU1NUdUdFK3k2MC9hQVI5RUI3MTVBZXBaQTJ4Vk91SkNlakx1ZTNGSEdi?=
 =?utf-8?B?c0tDN01CQ0xpVjhXVmhlWHllblBpZk5MSW9velNVYjlMeDBCaWJrOWdqZDJJ?=
 =?utf-8?B?S1FtOW52TUsxN2RGKzQ0eVJ1dWlWa3EzRGRpSlpYNmRSbWYwd3NvcFA4QWJt?=
 =?utf-8?B?K3ZjTzZwUzhHa1JsQkcwME9wSFRLY0VKVjQzNXZTZGFmNVJzTjVlMnZNVEU5?=
 =?utf-8?B?b2RvYnB1NGxkVGhtK1ZveWcrWTNQaXdkR3Z2WVRhSmRoMHB6RktKQWFCbHhD?=
 =?utf-8?B?UmtORDJqK1ZjanZhT3VSRWFLMHUyemVKMk1CMGZFVnVrczI5VkhkMmI1NjRM?=
 =?utf-8?B?WlpsUVNnbFgxM0hoc1lIVWgvVkdUcFhjVlBoZG9IRmM0cVI4bjEyQmlUQi9j?=
 =?utf-8?B?b21UQTJGcmFBNFVUaVFTOU54VWc0dEVIM25CT1IzVkpJOGlONXRhZkdVNG5m?=
 =?utf-8?B?akV0U2tqOGw2WWVQaEY1c296bjFoMVVsN25PQWtjajdZa3pZZ0ovdkpUYUVr?=
 =?utf-8?B?MG1ZUnY4eWo2TXVKMVpxM29GT3BaNVFpeit5Sit6Q1M4VTlYamRldHZNNzR4?=
 =?utf-8?B?RHBhU1hoSEtSMkRveFMrOUQvbXVCcmNMbXZILzR1b2plQkNqNndJMmVrMHhs?=
 =?utf-8?B?QjZGZUNCOUx1N1Q0bFFxZUc2V3c1ZVgwSzF3dXR5SnRCWDAxNlZOaU1kUzJ4?=
 =?utf-8?B?N21JdjVNL3NZNE5tY2QydDlReUZ2bUtub3hpZU5xazJoMS9MUUpSNGNtcDFQ?=
 =?utf-8?B?MUp4K3FaNjVWa0g5b2NyRnNzTzlObEUyOCtrN3lRbUJOWGZZcUZIc3R0UzdH?=
 =?utf-8?B?Z1FiQlBRWGhqM0xtK3hlR01icG56Njc0VnB6MHV3QzhLV0pzS2ZhdTZDVkxo?=
 =?utf-8?B?aks3QVJQNGxLelZUTnE1SjNFTG81aXdhSnBrdDZjZDBvVUVqakZjMWdVWHIw?=
 =?utf-8?Q?75U859?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2025 10:01:14.7309 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7acafb50-56d1-4703-0fe5-08ddf1e34f61
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0001709A.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4195
Received-SPF: permerror client-ip=2a01:111:f403:2409::62d;
 envelope-from=Luc.Michel@amd.com;
 helo=NAM04-DM6-obe.outbound.protection.outlook.com
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
 hw/arm/xlnx-versal.c                         | 2474 +++++++++++++-----
 hw/intc/arm_gicv3_common.c                   |    3 +-
 hw/intc/arm_gicv3_cpuif.c                    |    2 +-
 hw/intc/arm_gicv3_kvm.c                      |    6 +
 hw/misc/xlnx-versal-crl.c                    |  602 ++++-
 target/arm/tcg/cpu64.c                       |   78 +
 tests/functional/aarch64/test_xlnx_versal.py |   12 +-
 13 files changed, 3075 insertions(+), 1660 deletions(-)
 create mode 100644 include/hw/arm/xlnx-versal-version.h

-- 
2.50.1


