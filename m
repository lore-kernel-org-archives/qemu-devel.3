Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8930DCA0EDC
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Aug 2025 08:26:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uoe9I-00045O-QS; Wed, 20 Aug 2025 04:26:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1uoe9G-00044E-Gr; Wed, 20 Aug 2025 04:26:22 -0400
Received: from mail-sn1nam02on2062c.outbound.protection.outlook.com
 ([2a01:111:f403:2406::62c]
 helo=NAM02-SN1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1uoe9C-0000qk-4R; Wed, 20 Aug 2025 04:26:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N6BDLOyH0nQ2CIc80DY7bC6ObmRNFbhzNWHu+ei07Coyful9MgrAGAIoEv6PCm6Cz6W/OoREJcJzfXzAy93+z2o+scv+JFxYv4Qg0mghFNc/5SpHJvzPhLoSZk0dlAm7w2dtF+2PQvfH6ax/L7wTVnziEmVrZU7Lwt9iDuiODxgHwXq5QjJk1oDdgsvJzkOlyBh+FDc1QlSaLDAU3u2fwyyVPxJuCrkfW32bmPYX2vSxY/i8QFZ8mrEdS5dFEpE6c9U8rhYadT55r/uuP+5RAz6sAbxOf/0Gx3UtJsOaVYQE53MQwGopYF30jHO7lH6D8IlI8S5Rv8bYqM6tSCOLqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vyJRk5Me892I9DbTALk9ivxC5Y+oDkCcGM17dXu+p8A=;
 b=RSyPO7p2Tv15q+gLuIwnk9x7BJzMRPjgqPFQlxH1HMQy5SEfCiQGXR5RYVf6eQNHU3thRkG88TMhA2jvTJeyvMSdPLt5L2C1ef1RBGAXArCTBK5kPwNMPnJJy7dCpyPn/gGOBRtTqLV4B9zRIW/HwYYb2ontcaBlLaom2aol8EVHfx9WCV5RZaCb8N1VkvduisjQEXt13EiWbVVXnXvLL6t653TAmg8eyidMoEHBZWYGwFSD/J5aaLnStxYgzF/UpQTNNXOSMNs+Zs/e+q6OY3VWL4L+f/O/hwg4A+vYm+wIURQSge10RgVnkYyzmAMh5Sedg0SuM66ZaqArI9P+ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vyJRk5Me892I9DbTALk9ivxC5Y+oDkCcGM17dXu+p8A=;
 b=w+Vg4lbJX2veEzcZrDRwglx+RW5MAJqcNMQr00PsuhuMbxlbYjwWYTcPG5o+S1XgQ8W3SEzhMwXB/DgR65cfpVn7fSzac9luCUJJ4G7KvTTiyAfZnAtfTC6WJw8E/v5AWTGXwxvwN9KDetmeGOlnCKie5xfoYvIQsXQ2210MvOY=
Received: from BN9P223CA0022.NAMP223.PROD.OUTLOOK.COM (2603:10b6:408:10b::27)
 by DS0PR12MB7946.namprd12.prod.outlook.com (2603:10b6:8:151::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Wed, 20 Aug
 2025 08:26:10 +0000
Received: from BL02EPF00021F6E.namprd02.prod.outlook.com
 (2603:10b6:408:10b:cafe::62) by BN9P223CA0022.outlook.office365.com
 (2603:10b6:408:10b::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.14 via Frontend Transport; Wed,
 20 Aug 2025 08:26:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF00021F6E.mail.protection.outlook.com (10.167.249.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.8 via Frontend Transport; Wed, 20 Aug 2025 08:26:10 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 20 Aug
 2025 03:26:09 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.10; Wed, 20 Aug
 2025 01:26:09 -0700
Received: from XFR-LUMICHEL-L2.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Wed, 20 Aug 2025 03:26:07 -0500
From: Luc Michel <luc.michel@amd.com>
To: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
CC: Luc Michel <luc.michel@amd.com>, Peter Maydell <peter.maydell@linaro.org>, 
 Francisco Iglesias <francisco.iglesias@amd.com>, "Edgar E . Iglesias"
 <edgar.iglesias@amd.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Alistair Francis <alistair@alistair23.me>, "Frederic
 Konrad" <frederic.konrad@amd.com>, Sai Pavan Boddu <sai.pavan.boddu@amd.com>
Subject: [PATCH v2 00/47] AMD Versal Gen 2 support
Date: Wed, 20 Aug 2025 10:24:59 +0200
Message-ID: <20250820082549.69724-1-luc.michel@amd.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6E:EE_|DS0PR12MB7946:EE_
X-MS-Office365-Filtering-Correlation-Id: a6b39a65-f8b9-4dfa-4389-08dddfc3379d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|30052699003|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?TSQmVHEIgVZ31kdtQgWnYrisn3sJ5NyghtRP2wImrGSHBuWWBk106vPnfc0a?=
 =?us-ascii?Q?k9jEa5MzNSpPWVmEv4NfOSkQl2XvbJwhZaGpWV1jCyfzjvWOLhcnTY7xh/6/?=
 =?us-ascii?Q?pcxuvo9GyU1tmwvgB0DMTgxnSRxSb4c6ayWKEh0qPIza6hvTn5Mb/Mh4IAMt?=
 =?us-ascii?Q?nRfNl62zWooQc7Q62yhwt7w9jbWWV8aS48B+VIOCil/KaRAIKrSRn/5I1RJW?=
 =?us-ascii?Q?MWCLW6mrum6jmxJ93ijVu3yIX7d1Va8tzTGZh9cM499ux7GRU/Id7lIVXB7m?=
 =?us-ascii?Q?IxhlUgFBqghm4qhrncrdIjwGg/7LRyR4kFz5LCTLl7mViG62D0BJ+vvMfRAN?=
 =?us-ascii?Q?BdgQHVK4P7PfThIdufNb7E8zFWdCCecH3euIRVhP+SWqZllUXHMpHZdyydNd?=
 =?us-ascii?Q?5JKU1OC6cJz9TL7vvUBjKnY90rD7TNCn2LYLHnoOCejz+/Dv/0KPNZuVcR32?=
 =?us-ascii?Q?a9DFp0w7h4/PcAb3bri4AeRYBjlLQ/DJGS8aQNotvfgS1Pkn8zsu/uJJ97+9?=
 =?us-ascii?Q?Z7pJZp4q0UCi/qoe5VnMTn9fSzWSbWJwTrX7YlGNl522/j7eUpcrRtjLGygZ?=
 =?us-ascii?Q?0dTobzZDSMUeMh8sUW0oNXf+mgPhkxsCSU/sOc3EC+N3e6nmw2z/NpAVXhVL?=
 =?us-ascii?Q?cwnndBREn4FTFNpnNT0kdRO08dH0urFPkLkxN93IOwRyTZirBj/jCwgKL3wB?=
 =?us-ascii?Q?0fWer6X290C5KItyzx5ljPpItGLVv/a36z49+07baazSK/C45rsJfBOo5EN7?=
 =?us-ascii?Q?S60ikE44TBCrorzqAGVxhMb73Q1bigIQ8tU2d76hoVmFIG+/NmjkaLj3Ng17?=
 =?us-ascii?Q?7paACKkPSq3I9B9f9ZhtGnFH3YFWtmjS53oPNmwiizJJ1eCM499eg3g66RoC?=
 =?us-ascii?Q?+5ZlXFrEp5MgwYfXWpjlBBkaGSx2oIZTjYGntQyGVkv+yhcC4dhYQmYtGsZA?=
 =?us-ascii?Q?LjAgThmdlsbjNbu1VtXw//wzAEdiFR2ln6ZJDoKo5z2gCQwHPlSbJF496sU1?=
 =?us-ascii?Q?gIUn3bGnzEUofXU+r0UVIOVjjSQHrsaTSqgeTm6QwKel2fd6RjNPKlCQHqnT?=
 =?us-ascii?Q?O9bPd+Sew+CqxZD2ewlGpyE/NFy7Ha5o/Yc72c/1JO3JbCzer9v8ZVcnBjaY?=
 =?us-ascii?Q?pakwN0r7UcXunRPzGQk79F9YpLYAVogGXz1qhCWRJBA5Ng8+imTc7SFcujLD?=
 =?us-ascii?Q?MUbe+n6MYKCCY5hxJOLAwLxbMJqQl/iOkODdvh/uin5RH0/32RNkiv+ICu41?=
 =?us-ascii?Q?AyUxnksgm/CEV+rL0xyaTWfIjpkAaCsjgq85CsDJevAgc56TsdqXopuWhEBq?=
 =?us-ascii?Q?Ja2hdTCQP+ua/Vg/6iWsk9ZG8sSgGV/5Mw4wkg87IAs9Y7ZyEQRI4XwU4g7S?=
 =?us-ascii?Q?c7LY17v7jMAnjdGZo1YVHSvmMiwbT7U615ufNLTS3yvmxQDIAeSwRuQQl8mD?=
 =?us-ascii?Q?c6rsX6mp/VfKGcwED+e1LkfCoqc1lc/263FS8BpoiIdIPQY0nnUkJcm2ApGM?=
 =?us-ascii?Q?MLbXdWndmwIQxNgFniXIg1BI8cOE2KfUOsDf?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(30052699003)(1800799024)(36860700013);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2025 08:26:10.0720 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a6b39a65-f8b9-4dfa-4389-08dddfc3379d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00021F6E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7946
Received-SPF: permerror client-ip=2a01:111:f403:2406::62c;
 envelope-from=Luc.Michel@amd.com;
 helo=NAM02-SN1-obe.outbound.protection.outlook.com
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
  - The first patch is a fix in the Cadence GEM model. Some registers
    were badly initialized when the device was built with a number of
    priority queues greater than 2. This was confusing the Linux driver.

  - The next and biggest part of the series performs refactoring of the
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
 include/hw/arm/xlnx-versal.h                 |  341 +--
 include/hw/intc/arm_gicv3_common.h           |    1 +
 include/hw/misc/xlnx-versal-crl.h            |  378 ++-
 hw/arm/xlnx-versal-virt.c                    |  742 ++----
 hw/arm/xlnx-versal.c                         | 2460 +++++++++++++-----
 hw/intc/arm_gicv3_common.c                   |    3 +-
 hw/intc/arm_gicv3_cpuif.c                    |    2 +-
 hw/intc/arm_gicv3_kvm.c                      |    6 +
 hw/misc/xlnx-versal-crl.c                    |  602 ++++-
 target/arm/tcg/cpu64.c                       |   79 +
 tests/functional/test_aarch64_xlnx_versal.py |   10 +-
 13 files changed, 3060 insertions(+), 1660 deletions(-)
 create mode 100644 include/hw/arm/xlnx-versal-version.h

-- 
2.50.1


