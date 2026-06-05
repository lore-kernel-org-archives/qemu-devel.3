Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 485A7CD6E75
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2026 00:19:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wVIG3-0006Uz-2Y; Thu, 04 Jun 2026 20:17:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1wVIFz-0006RY-DU; Thu, 04 Jun 2026 20:17:51 -0400
Received: from mail-eastusazlp17011000f.outbound.protection.outlook.com
 ([2a01:111:f403:c100::f] helo=BL2PR02CU003.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1wVIFx-0007xI-Qr; Thu, 04 Jun 2026 20:17:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=slSKl+vpSBhaqXsdWr9s3gEkX4qbnq0JZnF8L4OLkPQdoZqr6E2DV5m/stvccvexQicxYlwLASKoSPaY31y34FUF3jOEyqL++oU6X4huEHwR7fTM7nsid33ZCQoYHBx92tZlpivz3gXNGnlCRlBmepnwMWW4WPonO9Dn5kgudrlQcLbTMp1om/9VjBvBZtQtwuWi5hHBafcQVgYqMfV+pf2WcE586sKzkxRqcMK2xxNwwDDHUe+LUcXjBdK7EV/isaJ+lRKcMc5Lb//1l+HCGjqYRupp5jEBCmpct/HGqP3YB8bOWjS+qi8rR3qtxeTfGZqoGotrO5sA4sMNS7ybDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LN9y3UmHhu+Vgf9Z/EiJgog+wqzZ1aLY5vXqKRI93X8=;
 b=zW18mQtSKNl3Y2FMA2UBDxHUutQDUqq6TgbNPbPbOvELyULO/UADgKAbomHSHzPh6NfjC63DOerNtOw5FjQP5cXWE/WaB3wqwS7WYvtDK/Z1lL3yDyeQYLjSq142Y4fPBnC2w/KYQLeWiFdulxzv2xZTrpKJ3OEKzr4iydDTkNSLjjR/01YYSypOUrruDKsnexYeY5WMJTHG/LZtlOjA0VpONoAw+eJEPk45HLwTLFRYzkwKw1fkkvAKxzYCi2v8TeXx1VXThDL8jFnvhE/J3Qtd4S6dMi85dW3kvh7Q/L/3Rz1TJemjEfnmAGTaLafQWv49yqtKkcQVIegzNtwBlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LN9y3UmHhu+Vgf9Z/EiJgog+wqzZ1aLY5vXqKRI93X8=;
 b=GXFlCma68B6r/c7Ur+tirH1WsG70hfjw8qIYkstmRHfH8I/73Xz7/n5xiQYkBaKdWZIE4S1ToTkwHaxoc0FEQqqggo2x4GQip/IUB2XZhaCOoYLU1itebMU2oWGYADZWvaYkVDUVBE0UGTDIL5Gs12nf6rfSS6hnz+aVynjhyCG8egCn3Yu+qsd40q/BKPG0ORcs/QjeUAg80Hp2pK9qMT5RGJymLvg4IQNHC+qyhV8aMmR0pfmlkK0dIsBmpQpXX4s61sqqMedDAuyVtv/Et47JC1eGaWTAquQI7K52FW751JO5577oZSCiEksm41o1aIMCZ6UGhu3gUFd0S7Jqzg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB5390.namprd12.prod.outlook.com (2603:10b6:5:389::15)
 by LVUPR12MB999159.namprd12.prod.outlook.com (2603:10b6:408:3a4::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Fri, 5 Jun
 2026 00:17:34 +0000
Received: from DM4PR12MB5390.namprd12.prod.outlook.com
 ([fe80::2815:c27e:a0a:2720]) by DM4PR12MB5390.namprd12.prod.outlook.com
 ([fe80::2815:c27e:a0a:2720%6]) with mapi id 15.21.0092.007; Fri, 5 Jun 2026
 00:17:34 +0000
From: Nathan Chen <nathanc@nvidia.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Eric Auger <eric.auger@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Zhao Liu <zhao1.liu@intel.com>, Matt Ochs <mochs@nvidia.com>,
 Nicolin Chen <nicolinc@nvidia.com>,
 Shameer Kolothum <skolothumtho@nvidia.com>,
 Nathan Chen <nathanc@nvidia.com>
Subject: [PATCH v5 9/9] qemu-options.hx: Support "auto" for accel SMMUv3
 properties
Date: Thu,  4 Jun 2026 17:17:12 -0700
Message-ID: <20260605001712.1823737-10-nathanc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260605001712.1823737-1-nathanc@nvidia.com>
References: <20260605001712.1823737-1-nathanc@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0176.namprd03.prod.outlook.com
 (2603:10b6:a03:338::31) To DM4PR12MB5390.namprd12.prod.outlook.com
 (2603:10b6:5:389::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5390:EE_|LVUPR12MB999159:EE_
X-MS-Office365-Filtering-Correlation-Id: 1950ad7e-33ad-4430-040c-08dec297d6ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|18002099003|22082099003|6133799003|56012099006|3023799007|11063799006;
X-Microsoft-Antispam-Message-Info: NIwFI2NvmlbWsmntBI0iWO33Btp5pFFMubu/TCUv2UNQvyAKzQR0duc9XJexwVwbY6lbi3IZsPx9VqxKAGThfDJlz6Re+mbs9a7i4apT+E5V74JtVjThHTMCdWhG/D85Yj7dL2Lb9Ad1xADjw8nlyaxk4XdsPO8a48LoQlpa4Q1JM2+jBq/7Tmr7a4UAcvrr1t82WIZuKd83/jKl97wSdJg5QlliYLGUvoWSEnR4JCVW1EmxuwfT2jUlCuJ+qFgdrE0x2SHYbuaKAO9sNmpiCgQnpYRs75gFCMVjlyrzQlGWB8RRY0l10SKEmhs/q5sNz7EPo3whIg9+kQddPnItTKUK6XWl2yB0PFNa9RiBoB71HpO665kq3nBrlqsGtZd32fs5hYh5efEmBb6HEGDDNGkMy5GzGzHACIdhTjofCARm9DZKfDKCXvi0UgkWvjeuBBHrgZ0xY+NSFmREFcvQTbDs61drM/BBTs01VkanHXwxrFoF5W7S76yrrcLUr/MNBb3jjvdmMP0AjFyde1xNJ/53LSMnHi99oaZR5r5LoQs3R5oSmu2e02yQm0Wm6gDhVFUULrI31po0yuCAqn7esP5tv/ncyhObx5IhqZEr7pGVEk2Gx9Mm4gv3YFIdy/xeaQhP0AMYg/SPBh7NAjJ9tJUrBJovpqQ4oWfwL5L1+xqDeX+q7a29Ts34O4iB6Mid
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5390.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(18002099003)(22082099003)(6133799003)(56012099006)(3023799007)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NvPSTPsr/1J71yY8kz1hj/Kg0grrCosneO7RlSv0VHoii8SmLtUggn+dXZ/l?=
 =?us-ascii?Q?tlBw58hrtBEkckeR29oXUzpVEuqtYYievObvDPe09FP8JV81Wj6Kpxfkl8ma?=
 =?us-ascii?Q?A7OqZm+sqDGCnhnSInLw/SXyJHguhynRXVXG8YgKac2t2sLa9lYPNG+Ts2XS?=
 =?us-ascii?Q?ER9aq0U5qJ0fXoSFSo0ProUz+VNR//gYsp4mklsjT3EtDpfoUUc3kvIgUVmI?=
 =?us-ascii?Q?o3ug7wXhrN+jHbBuj5CVhBWlBrS71IhvZ2I2RCGQZ6rDaiDqA6Y+Z9iHpgOm?=
 =?us-ascii?Q?dfMTMxqD0FpdUvzmstvxOsyZIdU/tjhoETkE2qTkEKRFVQyrZTLua6V2Evzr?=
 =?us-ascii?Q?SNGHHbIpE4ez/0/PvKlcUQRE2j2VOl6nMQWXNJdMNf8lhAlkId0URES9otnZ?=
 =?us-ascii?Q?w6ETFcWBmsATZsaFN+BPIT7wrEiUDw1D8wwFakq5JgcACV1hO0/EXUGXFKPG?=
 =?us-ascii?Q?eMReZ70oiMln19QEBboD/nQ8AiERVG9qLeR/w8a6is9QlWGI8BaIbRRF86/l?=
 =?us-ascii?Q?IQixdeg+IMWIQD9oaAPAZaVaHcemwb6TREVh8fOOcdlKeqXbHfmObDGL/VCA?=
 =?us-ascii?Q?hVRnWRBIEr+URjARIjk0HzQloY1+hJ6YUsJb5mwo+cfqZz/fC0f7sDcgtHFd?=
 =?us-ascii?Q?d+dVZgKlvqEE3t+kAr7PNlNjJqVMxzqDri5jonaRGFmgY/mHAE/2P4h+rS2R?=
 =?us-ascii?Q?uuljiR4J83in8EztmBrJ899uBgrfcfiUy8odjTjxbZP20IHgGU+Uhivghb2N?=
 =?us-ascii?Q?+E5Kmn2UcIX407hg6kw11l9CaOxuB2NxbXYUURtjfyu3sRnsetP4bsjmeOqp?=
 =?us-ascii?Q?8PNRuMkjDLr8kULyidVOWpA1nWVywW3eXVhWhmDUm/+jK060b1kRLOai5DUj?=
 =?us-ascii?Q?b30S85IBDaSVUsVq/WzfkFIWKa1TKTWj5p7dGjfj91yCJHN8Uglf0U7RnVJw?=
 =?us-ascii?Q?djkCOlN0jRBJV4YfOV0s0LIB3UOsogWQC6LL6WG1PVPZpneLMYouPNfmhs1e?=
 =?us-ascii?Q?w/lDxBDet7tQem2wfn5/PLaPZEXTFta65UnE/tpMDCjSI7vg5qeeTNZ25ocj?=
 =?us-ascii?Q?ODoMqaOZk45Zji++TsVy3OoxAjx2TALOnk1FPutYOahshdYf+bgqiH2nKour?=
 =?us-ascii?Q?PdPmri4z6WSzTt0j+ujUSvluWRuuJYDxCInHyOHshwk5w4X69HR5yav1ZemO?=
 =?us-ascii?Q?A26nxyZlVcH60qJQshpfMyc31oRfVN+oqS4TK9N/50AYtRPWTea8x2H10sBU?=
 =?us-ascii?Q?vlFSTK+JAs/j7XCqD1uAmbRQTrpisoAkb+erGFtAs9I8ZLFf9hZM6PN5ooXe?=
 =?us-ascii?Q?tF7T6Ekk3RSMOK8epw6umO1KzTpRm6Ah+/RxTe2JNbPdrBpJpE86WRIH6eXu?=
 =?us-ascii?Q?r7lFoaxku5L+44Em/euxVXgiZg9tNSJdIKgS44nsUPxWYb8fjzgwYhsGYY+k?=
 =?us-ascii?Q?OoBvrMHrxw8ENw6gtPuNVL4hTQ8xikxSS1yiegmW8Kdq2cjMExSqegyOAgeD?=
 =?us-ascii?Q?xPBpE7j9TkBRRuN+hZOiMLDkwiIAzWeLiAiTISbhiFZPHfmo7xvGLSla8I+p?=
 =?us-ascii?Q?/m6CJZZsOalVSCGANZJ+dPpq5NHEJzPv2hnIUJ6d8mpVEfH+Ile8CW13BieN?=
 =?us-ascii?Q?6jTVBsv7JID+JyV7mM6TAB2hHUxhtPlafnmPjZt+20KiuWiYKHr7YV9azuVU?=
 =?us-ascii?Q?WUT1rJhMgpiQrCBquiLUhAHTSjo3N70KZMxozOHqfJnL+s2oP9SIQnycwUvE?=
 =?us-ascii?Q?XvXUUprbEg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1950ad7e-33ad-4430-040c-08dec297d6ed
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5390.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2026 00:17:33.5861 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /7F8FpFeBsQ5k5XdFItvGH1ohMWttp8c+0tfS/CZ4YbRt6fmVuQC6u/znXAfq0BHiS5+uR/lyCYJoChRXat72A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LVUPR12MB999159
Received-SPF: permerror client-ip=2a01:111:f403:c100::f;
 envelope-from=nathanc@nvidia.com;
 helo=BL2PR02CU003.outbound.protection.outlook.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, SPF_HELO_PASS=-0.001,
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

From: Nathan Chen <nathanc@nvidia.com>

Update documentation now that "auto" is supported for accelerated SMMUv3
properties.

Reviewed-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Shameer Kolothum <skolothumtho@nvidia.com>
Signed-off-by: Nathan Chen <nathanc@nvidia.com>
---
 qemu-options.hx | 25 +++++++++++++++++++------
 1 file changed, 19 insertions(+), 6 deletions(-)

diff --git a/qemu-options.hx b/qemu-options.hx
index 96ae41f787..d7e48688b5 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -1291,31 +1291,44 @@ SRST
         Enabling accel configures the host SMMUv3 in nested mode to support
         vfio-pci passthrough.
 
-     The following options are available when accel=on.
-     Note: 'auto' mode is not currently supported.
+    The following options will be set to auto by default if not manually
+    set. When accel=on and these properties are set to auto, the value is
+    derived from the host SMMUv3 capabilities via IOMMU_GET_HW_INFO. With
+    accel=on, this requires at least one cold-plugged vfio-pci device; if
+    none is present at machine init, QEMU will abort.
 
-    ``ril=on|off`` (default: on)
+    If accel=off, auto values resolve to the non-accel defaults given below.
+
+    ``ril=on|off|auto`` (default: auto)
         Support for Range Invalidation, which allows the SMMUv3 driver to
         invalidate TLB entries for a range of IOVAs at once instead of issuing
         separate commands to invalidate each page. Must match with host SMMUv3
         Range Invalidation support.
 
-    ``ats=on|off`` (default: off)
+        - With accel=off, auto is resolved to 'on'.
+
+    ``ats=on|off|auto`` (default: auto)
         Support for Address Translation Services, which enables PCIe devices to
         cache address translations in their local TLB and reduce latency. Host
         SMMUv3 must support ATS in order to enable this feature for the vIOMMU.
 
-    ``oas=val`` (supported values are 44 and 48. default: 44)
+        - With accel=off, auto is resolved to 'off'.
+
+    ``oas=val|auto`` (supported values are 44 and 48. default: auto)
         Sets the Output Address Size in bits. The value set here must be less
         than or equal to the host SMMUv3's supported OAS, so that the
         intermediate physical addresses (IPA) consumed by host SMMU for stage-2
         translation do not exceed the host's max supported IPA size.
 
-    ``ssidsize=val`` (val between 0 and 20. default: 0)
+        - With accel=off, auto is resolved to 44.
+
+    ``ssidsize=val|auto`` (val between 0 and 20. default: auto)
         Sets the Substream ID size in bits. When set to a non-zero value,
         PASID capability is advertised to the vIOMMU and accelerated use cases
         such as Shared Virtual Addressing (SVA) are supported.
 
+        - With accel=off, auto is resolved to 0.
+
 ``-device amd-iommu[,option=...]``
     Enables emulation of an AMD-Vi I/O Memory Management Unit (IOMMU).
     Only available with ``-machine q35``, it supports the following options:
-- 
2.43.0


