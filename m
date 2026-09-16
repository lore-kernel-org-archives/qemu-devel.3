Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36979C88E7F
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 18:57:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6uoE-0006WE-TL; Wed, 16 Sep 2026 14:56:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tdave@nvidia.com>)
 id 1x6unv-0006SV-Lt; Wed, 16 Sep 2026 14:56:23 -0400
Received: from mail-eastus2azlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c110::1] helo=BN1PR04CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tdave@nvidia.com>)
 id 1x6unu-00062u-7t; Wed, 16 Sep 2026 14:56:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DIMxs76d0VO8QZt/HL2PM6+t7VgmtkcOrg6a2eyIkhK+A0aX7QkIkhj/N8DdIlDJ0gg6DaXMe3ggeUHKD2A44Ov81nZLkc+c245W3kqFZOkmvmDXvx/6vy2HA2lixAiJPMCd2FSnPe4vE67uqoJO9KRWCRbZUz3x0GEQw+6Ru7ZIacgoWoMnKaFazBNn4ZqouiT4xAsrOt0mfjBFMrej1EC7JfHDjd5HrfRiYDts1b537Z/pK59hW3tb293fyrvPE+T39DZ1CU63UWjppO3W6lTJQ3VDKuDBvYe3w3vBYc1q9CDGc1D0mKQNSfu7rGc8rpZ2p4xtfwXAyaQ9oxTbGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vXW0q6J0EDh4bd79TLcq6NL8B/+t5L1benFS9VXBx1o=;
 b=T51iDmQB6g2G9NaTr1zrr4e8nsRpYOjLeLGVg/DgvJ5siYRJkPT5Lxw7X9Y/WkQ55kZn4O1BiDAATQ6mRG6v6mYOnyYbzRWihxEHWgnUmOYGm+UU6YvfyBvek4/W0izZ0aSAD5N757RPXxiDRFPuPmEPmQMErMaelOpY5NXtB5hU6UtgmkCqCIOXzY0GpuDYK72Qq91amoAoZuwYg4RvQlRhKtyus9DcQEdsKjq5ra/gpeg9xoXEi3XVO7nEOGyP5Y6vb+T5Z4uZB+mG0idhOpYIC/LWmLvZUaDnifiMc1MNQkMIkthiT52yKGhGyaiEsziOJNHOzQFpr1r8S0RPOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vXW0q6J0EDh4bd79TLcq6NL8B/+t5L1benFS9VXBx1o=;
 b=VEI9XjQ+L+MPZNRSp5CaqFPK4Cesh4TK9viHjq3o4P4n10fluArEVOje8kWNv4lPr6vnmpaeZ6LaJjHCpnTmi0UFKgluKGqrK2BM/3kT1p6yvbs9DzjQ+LVOta2dA5L+Dds5RNdRyZUQ0vgFV4IDDIdeFf+AREBCPVoyoCfhX+BputPJ8Dpu6oSlWIYwVHpAfiWJTh+N2eXGs6q2uQ5WnnUjG02lFf1/Gl1UcLSpYf+O38cXFEJjgWrFskMqV7RZ78FSz++iJWtab99uKPBRODi6qcKw3brXjl9BMKMdrgwbbQTlLfJRZpmztQgMRxqgLoJ1PIpL4o++zOIPZwVQ9w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA3PR12MB923065.namprd12.prod.outlook.com
 (2603:10b6:208:627::17) by CY3PR12MB9631.namprd12.prod.outlook.com
 (2603:10b6:930:ff::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.9; Wed, 16 Sep
 2026 18:56:07 +0000
Received: from IA3PR12MB923065.namprd12.prod.outlook.com
 ([fe80::1c83:bf47:4202:50b1]) by IA3PR12MB923065.namprd12.prod.outlook.com
 ([fe80::1c83:bf47:4202:50b1%5]) with mapi id 15.21.0428.008; Wed, 16 Sep 2026
 18:56:07 +0000
From: Tushar Dave <tdave@nvidia.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, peter.maydell@linaro.org, mst@redhat.com,
 marcel@redhat.com, devel@edk2.groups.io, alwilliamson@nvidia.com,
 jgg@nvidia.com, skolothumtho@nvidia.com
Subject: [PATCH 4/5] hw/arm/virt: export fixed BAR metadata via fw_cfg
Date: Wed, 16 Sep 2026 13:55:53 -0500
Message-Id: <20260916185554.917526-5-tdave@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260916185554.917526-1-tdave@nvidia.com>
References: <20260916185554.917526-1-tdave@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SA9PR13CA0174.namprd13.prod.outlook.com
 (2603:10b6:806:28::29) To IA3PR12MB923065.namprd12.prod.outlook.com
 (2603:10b6:208:627::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA3PR12MB923065:EE_|CY3PR12MB9631:EE_
X-MS-Office365-Filtering-Correlation-Id: ed978799-ed10-41c1-09f4-08df14242a5f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|23010399003|1800799024|10067099003|6133799003|18002099003|22082099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: LG3CARaJz0d4PYlFcZ0Fo+wIwdQcbW3/jvP+saLvZ/X2/uqsQ2S+/5rqn0s92Pl47j8oHF+IhBeJAR/iSDo3JXAOgsdgV645ZF/in9AafDD7Mr0dbQY5GHDj91RAs/jtNBxFmGrufflQ3Qed0VCbtaghgUxfO+JIKloBkqUC2NoXHRwgCj415vTX3v6EylmgEQ/RhB5uHl8QteRoyKyZLUZRPMZq/ySuWZw4BSI7Xg1QHaklzxwCW+9qzQSdGHYN99kWIlMvK9IB3tHIyGSFKyZllwYfOQNjt+TA4mA9LBl32Kbd6upPcAreoaQl/Exk098qgo21+JgSpoNTAHx77HauwBEyUN0T2iGuzoZsDJufLiqfOWM5tUigK5ukzZELthMTWMaTZ71+D9Ikz79cw4liqUs3qCObxAa1+ZD24Up4aZaylU6oqPv0fpBeyS03/6fGpiU1S6KRw8+ZA7TkQzizLQElncJf0Y4G3WZYgEm8zeuNYJvPUQapIhmYKHF88Ul7GP+HXTdA/IWc2ms25TgKWjgdJQPPB62/Dd8FRU2blrjV95K4J63snvW8L5LKeJImw0jSfD+m8eK3wsayYIGzn1Et2wdKi6Pe0TI41fmJudubgke7GYpEfIC1KioT53+QGLCWGzKsOLzROlscOQYY2G78DYQvkQ8JBO770l4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR12MB923065.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(10067099003)(6133799003)(18002099003)(22082099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2QXYatwYjQwH6yid7abMyWrODeIxkqX0KoCV1/k7y+Zqd3J3SeZrZfz4O3om?=
 =?us-ascii?Q?KkQrkQre6uriwcQVDmUHKecN43WSHjGS1265nljnTmYMS7JitVxsbGwyMwxh?=
 =?us-ascii?Q?JRkiLyNao/8JiHICbYBUsmD4RetuhdhhWSHylN7/MYB5SkdaBko/DRofKPVO?=
 =?us-ascii?Q?XbeTPII82L8Svln2wrryT8azOX3p+AXWa3P6R7D1ELDEZk4gcpQJFd+0WcO5?=
 =?us-ascii?Q?aP+MMaeBlLvjXH96QPpVn3gEBDo9V+HOTLyPUaCTjh026k9iUZhL8ufpf1pV?=
 =?us-ascii?Q?BiSLRWgWBBruPNRWzd8kwjIDHNUPKRb0YZpQzzOz38Gl86/ODmx5Ep80Z/22?=
 =?us-ascii?Q?OlKeYPhA7jLX6iXxBGqBfozrv9BnUc6IpcWmvtUPm8lwNAVZTN7eWY/rQiw/?=
 =?us-ascii?Q?Xh3xHfe/lEiOpUDMndSPhd7D42zTdMK1838X5VuOeV2fVX/stl0qsfICZFNO?=
 =?us-ascii?Q?bg3ufyi0Ui79+qTyzuwClrZYsbMIX36hT+x7o18ywmMc/JCX+khlThmf03vI?=
 =?us-ascii?Q?RXRfRojTmrAfiNkYCC/JyekGtJ281aWgSm0ma4P5zVXkee6PhTENs5mGB6+r?=
 =?us-ascii?Q?YgicjlSzGNEZzsYK3IubhkoqvuAqi1uJL3eaOiTH5M2L5uPgdwJcUEqs06gg?=
 =?us-ascii?Q?5tkVrhlbFrdv61okPzgk88LDb+lLHKzR/9x/OSfNTsT55N4Ca/1torV5f4/m?=
 =?us-ascii?Q?PPBsb8iRoD0c2S6gx9Cz/ht0xt1xUAhh+urwOQLvbf9AUTRtNVACUQj1Bf7/?=
 =?us-ascii?Q?BUum9ZnsymNo3KcsinfZ9kpisde9jYzkIQRFVHWNlVHjNNqO2rdXXe/Yogfc?=
 =?us-ascii?Q?TgmKseCBOFtIi4zxAEeA15pUf7S+AMz5uOZUVXIKl4klKgKuiDE5oCpKLNCD?=
 =?us-ascii?Q?bwQA8RqGN8L1qdos8XZDLIdz1tcDjY38Ddyu9spf1e/DUH1yvxRhwkoEi4oC?=
 =?us-ascii?Q?F9mC2Tf3tVSUeZ27FoJsH61JkGp2pMKZOnpzks84HRU+EYx6XdaoEXz8FJMZ?=
 =?us-ascii?Q?l8qvxmgvQPZaQM0sre++ZE7jLa91/EqjLXPGGBbYvak9dcFdnQZFEmTi0Y51?=
 =?us-ascii?Q?dupLI2BwLGdIMYO9/BPQ7z29RPdyaz6yXuFxHHPM/qIQjmx369mD+PNJXrZz?=
 =?us-ascii?Q?Kvi13omCOFObg7dXYIVPbibs4gDJa2fdz3ZioRxjnVqvurH0VA/NIU2y1ttJ?=
 =?us-ascii?Q?5Dx2Nbv7W4/aJax1aqrEb01ukZWKowtSYVkIUNV5dcZdKrdWRBaC+dTXRrQu?=
 =?us-ascii?Q?9nqgky+SztHsKIGSVbcJWCfvTga5aPCaxLHQWe+dTQFUxsRK+HMWRBdpK7i/?=
 =?us-ascii?Q?Lh9OHFdDqwBIekCUme/rz8vHGzfQUYqPqWoHlZEzC3r1BBcwcQ58IxEm+Fh7?=
 =?us-ascii?Q?nsENy4O2ckPB/WSuUkFon1pNBypnV4CpcubYm1f3U41DUCh4uxO5TxGmbulJ?=
 =?us-ascii?Q?WyGWCWn0ImkYQBq5mUuquq1Ulo/9rzs/bxhIckORnIoyDQ08Lc8y9bwZtN/R?=
 =?us-ascii?Q?Qnx9q2E2OvDkLchRA1XFxaCwsRi37fZPqFYLNK3R84A1RalYhWZlz+tgIVik?=
 =?us-ascii?Q?z8UlVZX32sxjKQ2ogayB/n58Ric8rhSHa/SQdEk45lOnelOO4uEjFuSfPAcA?=
 =?us-ascii?Q?dd7r4aC31u9aNR1zFEmDpYoi+xF+inoOK5yNcDUeRVZJzea6yMKwzoInNVGK?=
 =?us-ascii?Q?w0qAiI41m/ci4aO1rdPbu+VnLWzY7YaBtb1Bb80kqg5AIkM3?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed978799-ed10-41c1-09f4-08df14242a5f
X-MS-Exchange-CrossTenant-AuthSource: IA3PR12MB923065.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2026 18:56:07.2749 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 96/uLKWJ9r+Si+v9DpE9WkyBwBPjXq4h2V9ykkUg12QJaC9MonEbHAu3+pMzrP8KlrjXmipCgWjQ/DrrV/teXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY3PR12MB9631
Received-SPF: permerror client-ip=2a01:111:f403:c110::1;
 envelope-from=tdave@nvidia.com;
 helo=BN1PR04CU002.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_NONE=0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Export fixed BAR metadata from the virt machine through the
"etc/fixed-bars" fw_cfg file during machine initialization.

Fixed BAR placement requires firmware to preserve the PCI resource
configuration established by QEMU. ACPI provides this via the PCI
boot configuration preservation mechanism, _DSM function 5.

Reject fixed BAR configuration when ACPI is disabled, and request PCI
boot configuration preservation when ACPI is enabled.

Signed-off-by: Tushar Dave <tdave@nvidia.com>
---
 hw/arm/virt.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 3eecf094bc..c5db663858 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -95,6 +95,7 @@
 #include "hw/cxl/cxl_host.h"
 #include "qemu/guest-random.h"
 #include "hw/watchdog/sbsa_gwdt.h"
+#include "hw/pci/pci-fixed-bar.h"
 
 static GlobalProperty arm_virt_compat_defaults[] = {
     { TYPE_VIRTIO_IOMMU_PCI, "aw-bits", "48" },
@@ -2438,6 +2439,21 @@ void virt_machine_done(Notifier *notifier, void *data)
                                        vms->memmap[VIRT_PLATFORM_BUS].size,
                                        vms->irqmap[VIRT_PLATFORM_BUS]);
     }
+    if (fixed_bars_write_blob(vms->fw_cfg,
+                              vms->memmap[VIRT_PCIE_MMIO].base,
+                              vms->memmap[VIRT_PCIE_MMIO].size,
+                              vms->memmap[VIRT_HIGH_PCIE_MMIO].base,
+                              vms->memmap[VIRT_HIGH_PCIE_MMIO].size)) {
+        if (!virt_is_acpi_enabled(vms)) {
+            error_report("fixed-bar: fixed BAR placement requires ACPI to "
+                         "preserve the PCI boot configuration, otherwise "
+                         "these BAR assignments could be reassigned later "
+                         "with no protection");
+            exit(1);
+        }
+        vms->pci_preserve_config = true;
+    }
+
     if (arm_load_dtb(info->dtb_start, info, info->dtb_limit, as, ms, cpu) < 0) {
         exit(1);
     }
-- 
2.34.1


