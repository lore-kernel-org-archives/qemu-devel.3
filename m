Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D12A1C5AC7A
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2026 06:18:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wsDuc-0006tj-Kj; Fri, 07 Aug 2026 02:18:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.K@amd.com>) id 1wsDuS-0006kX-19
 for qemu-devel@nongnu.org; Fri, 07 Aug 2026 02:18:24 -0400
Received: from mail-westus2azon11010040.outbound.protection.outlook.com
 ([52.101.46.40] helo=CO1PR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.K@amd.com>) id 1wsDuQ-0002gD-2l
 for qemu-devel@nongnu.org; Fri, 07 Aug 2026 02:18:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yJ4oiK36b8YDqcFP8DUBNkG5RzaNAsVsxDyImuKFhuVTlfKNtUMBcjg85P50J+Ovvaadb/FMYD6crb60mhiojjPfHSkMQGWm9otEUvvnkRa57tt4J/lCrl27ajnTjzuqiLogRsQJQ9cLhyHB7kI40IVaBat5dA5kTOw7XFoO7YEVpkF3m0Z8vm5w3qnf8isqOM6kquibXcLyCOo20Mi9eFQtTqrl/7fe218AsT2TlaLwbY9WoKek78Gtr83I0KBrFm5V234rH/yyHexipA6RyW0j2ncoXXvtaPU1b4ZjRcRMm+Jm9AriZB2JsHMVM2YoHUUckPLNRkhrZZsMyZWv2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EDJCKCOpbRwHGDTFw+y7as8vDCMixz6ZVdkU02bG9SE=;
 b=AKaOj1WImH9yukqjRrCAWCszfEk7RVDOP+ssxIR3tgDVzqH9fxFkHkGgAL32Qte2Uzer9JNozRG6NX5ch76n+lVkpkDmZ247+3hKh1FHMLZTumnqWHhaCo2H98v3BD5nF1rLt366PJgZVFtgLhfgRWQIKIqhHY1yrBb/UfGTAzb8gHGmhBfgJMQZwbLk1SVn1KwjHVJGoBB7Gah0wVyBiDu6+7+WV/IQmPNcwOk636fffi4sZFZL5MDwES/f759Vd9Hjmz0C4T98zHedM8r/6Lx19+ETryFtRUJ8UBlN7mK40EaPU2+MFlvSapxBdS77AvskDLHh86oppGACn9Baaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EDJCKCOpbRwHGDTFw+y7as8vDCMixz6ZVdkU02bG9SE=;
 b=rVeaGrbHWWyHCzV0/C2zy3wO+PiO81fyxpmAr5+4tjdI5ycNGtCeJSEILnVXTnUyPkZIpBeMmtZiM/6AJdxmzFqt9pmZ94LVjNjqcZat03KIuuiXV2gyu1qBD0VRtXoqT4ZzeOCuAZesa/WtdCIKJURdUGzdhWaaZsYaysl/dRU=
Received: from IA1P220CA0016.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:464::10)
 by SA5PPFCAFD069B8.namprd12.prod.outlook.com
 (2603:10b6:80f:fc04::8e1) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.19; Fri, 7 Aug
 2026 06:13:13 +0000
Received: from MN1PEPF0000ECD5.namprd02.prod.outlook.com
 (2603:10b6:208:464:cafe::6c) by IA1P220CA0016.outlook.office365.com
 (2603:10b6:208:464::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.23 via Frontend Transport; Fri, 7
 Aug 2026 06:13:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MN1PEPF0000ECD5.mail.protection.outlook.com (10.167.242.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.6 via Frontend Transport; Fri, 7 Aug 2026 06:13:12 +0000
Received: from BLR-L1-SARUNKOD.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 7 Aug
 2026 01:13:09 -0500
From: Sairaj Kodilkar <sarunkod@amd.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, Alejandro Jimenez
 <alejandro.j.jimenez@oracle.com>, Ani Sinha <anisinha@redhat.com>, "Igor
 Mammedov" <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "Richard Henderson" <richard.henderson@linaro.org>, Sairaj Kodilkar
 <sarunkod@amd.com>, <qemu-devel@nongnu.org>
CC: <vasant.hegde@amd.com>, <suravee.suthikulpanit@amd.com>
Subject: [PATCH v2 0/7] acpi_build: Refactor and cleanup AMD IVRS build
Date: Fri, 7 Aug 2026 11:42:43 +0530
Message-ID: <20260807061250.27739-1-sarunkod@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD5:EE_|SA5PPFCAFD069B8:EE_
X-MS-Office365-Filtering-Correlation-Id: 42e6c10d-4a0a-4a19-4b55-08def44af651
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700016|23010399003|18002099003|56012099006|11063799006|13003099007|10067099003;
X-Microsoft-Antispam-Message-Info: Aq2kMFOKnoQytoEhi76nzCbZW02ujFNWyXoo8dfkrP1zOTf2EWe67VlZPG+ei91xiRUQjqLh4GDswbEur9oMSAp1rujIYWXGvGc1VpALHlMne0wPNTT5T8DzWTXm2sNvI8LCPi9tzg20rn87iZZ6K74l9O2TXTvMpxB3Rv+yfMKOFrsmG9mwTe+OsW8pua1d3++cbHa7mzGPwB7w5cTcpGCBi0LVNXk1VAturcWMhTYhWDkpaAL8LMb/zyrTBOD6zxtg+TZkyMbUbTboO3A3CpS7cMtcPRwUjMQVjZ9mOY7hk7KogakNCP3CAcnQxiiAx9GYzNu9qrhdAku04Po1CRdzIzE9vvROx00522CtrmVf7rsJZ7xsc6V3V15TmCNfMBJ9qq9ZCaIGbJJ6cqBPURFLlAV/NUQmzbiFB/HflGJcZq3x1ehfkQzeSbcMt/vjgxFqBj/MS+J7Lv6uHSCq4Pp42t5R5vkIRlObopPVRnlZkTJXP+h74tA6ntMNPcZf5zrAjBqoMQbPiEWk5wJ/sNs6FEbt/6tJ/JV8SAFHoG0K9Ie6UTeF8Tx6iu7ktxfRL2tDi3ig1BDNUH3CR4dlVxhe/3WlnvkxeMdgFZ0YC3OKu8rFWG9sQHDbEZQaGDV7xrpa5MWi5YYafjhc97XoqmSeoaxgbFsWN4Z661dY8p5hBc76jRjrn/M60+Luhs8jJ2GFBmLgLo4KVXqSo66iCA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700016)(23010399003)(18002099003)(56012099006)(11063799006)(13003099007)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: p63IdwhKwdCtrytcyu8wqTsBHSIeZl/6IkH9msM5vF6X3sVyv483V4PVB0Lvn8EEYJ1oLiIRU/Yn/UoYDW6e55N9pg910R8/fFKwhp2pp2oF84tOjll4xXYCMXyUmdN+OLz5usqflLnlatOSM0IKjcAVJ5KOLaeEjrhcXsau7HVB+rU1J+K4ykbO3gbr50A1+5RciEU2nZKL7aTLEwns+exuSHoZeI02fHv8Q3KoLc0m3TDHzFsTfugwltkmy3Bc8ln9F7HRgCDySqGcbcvNzSCX8gAhi6SUwBOS3kidMPzxvsDYzQZgKoDMOr3j9nxJoiJ/I3X53tNRwBXbaDBAjz55sY54U6rCAuNtjsPdnW+lGBzAqBx/pGKeRKZ1tyk07/RpPIk12RHXJuf7mOIkW4OtLY3F1ptVRxq3v32sC2Hy0gq3RJonWrtIsnSo3XVQ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2026 06:13:12.9962 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 42e6c10d-4a0a-4a19-4b55-08def44af651
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPFCAFD069B8
Received-SPF: permerror client-ip=52.101.46.40; envelope-from=Sairaj.K@amd.com;
 helo=CO1PR03CU002.outbound.protection.outlook.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.852,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

QEMU reports several IVRS fields that either do not match what the
emulated AMD IOMMU actually implements, or are hardcoded and drift out
of sync with the extended feature register (EFR). This series fixes
them.

The goal is to land a maintainable baseline before adding AMD
hardware-accelerated vIOMMU support in QEMU, where we will require multiple
vIOMMUs attached to different pcie-pxb buses in order to serve set of
passthrough devices.

Please refer to AMD IOMMU spec [1] for more details about IVRS.
[1] https://docs.amd.com/api/khub/documents/GD6kOXjzWsek8QUbn_qMvg/content

Changes since v1:
https://lore.kernel.org/all/20260511123937.32743-1-sarunkod@amd.com/
 - Dropped "acpi_build: Cleanup AMD IOMMU IVRS building" and
   "acpi_build: Introduce necessary macros and structs for AMD IOMMU
   IVRS".
 - Added "amd_iommu: acpi-build: Remove unsupported PPR and HE
   feature"
 - Use pci_get_bdf() instead of pci_bus_num
 - Move AMD IVRS specific macros from acpi-build.h to amd_iommu.h
 - Remove GLX_SUP from feature reporting field

Sairaj Kodilkar (7):
  amd_iommu: Return empty efr for stub call
  tests/acpi: x86: Allow IVRS acpi table changes
  amd_iommu: acpi-build: update PA, GVA and VA size macros
  acpi_build: Use IOMMU pci device to build IOMMU DeviceID
  acpi_build: Build IVRS feature report using extended feature register
  amd_iommu: acpi-build: Remove unsupported PPR and HE feature
  tests/acpi: x86: update golden masters for IVRS

 hw/i386/acpi-build.c     | 65 +++++++++++++++++++++++++++-------------
 hw/i386/amd_iommu-stub.c |  2 +-
 hw/i386/amd_iommu.c      |  2 +-
 hw/i386/amd_iommu.h      | 27 +++++++++++++----
 4 files changed, 67 insertions(+), 29 deletions(-)


base-commit: 3e3ccab106f879b1512f8e0d51a827dd4de30e22
-- 
2.34.1


