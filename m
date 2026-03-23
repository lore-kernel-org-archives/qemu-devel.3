Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69486F483E1
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2026 18:27:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w4jxr-0001pk-9J; Mon, 23 Mar 2026 14:25:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1w4jxc-0001n9-GW; Mon, 23 Mar 2026 14:25:08 -0400
Received: from mail-eastusazlp170120007.outbound.protection.outlook.com
 ([2a01:111:f403:c101::7] helo=BL0PR03CU003.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1w4jxa-00043g-E2; Mon, 23 Mar 2026 14:25:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b3WGwYLD75cSDd7ave/0PjnjgZT8Moqcr1q8HufafYB5CyTsa8b+ctp+LtYClLcPulXKAdOHUS1n+VHOIWi4TAK+nA2zssyPtDrQr+v6HrYZ9zvoeE9if/7pd1o8bMwFQk7pe2bslANTURBRS/LsnDJSl80HzEZg60KLsS3vZ+Yxxh6FbXwUgeZ4dw7SboEFaL9W5KNkqjB/qLidf6R41HBLOYGe7BW+wHlpsVcWvZiS6BBgL9KmG7x1bjqdKuBV5kFMv+hv6lF8OHzbRKAEQsqqkRXO/3bKa0M43mrZpNPcYhpHSR6a2H2SC4k4PucdQ9YxCFqMNjTYPcKVvO17HA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1HZuEE4EyPtlasC2BlZhcHLkSXwJr7FQxcjoOZ9RaEA=;
 b=soOoc0MQsQer9FDjl2Cgh4jcUxqCKul5Jr/il08aRgqM8P1yyyB9chZCoOCL0h/mGZ8WU+KxGMhfjdH0nvwuMpeqQwlDXuACqU6QxAXS/xFfTW2XO7fJ1DHoHDYJe265yQgpkQV+0h+7Z3r29DNqucRuG63Zf+q4tTw+0VsUpapWjdFNf3cfTSqKUlGz1U8viGorgwhG3qiyOZdA1ctXPVgVB4IgfpOmujSDqvEFMaSDMG29NrdCH9fuE//NnHtY0dDKjXosVsX4Lm2WpMDfZ40l+UYCZPEt24IMFEGbX0gUiCjiM4/Ol3LpZ4yq4hC3nQYRak5ukQzHV6p8j7mgow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1HZuEE4EyPtlasC2BlZhcHLkSXwJr7FQxcjoOZ9RaEA=;
 b=rv4lSfTndBFcZKk1L754H78sTl9gi+nmgNnCpurnPtC614R73KiCA1CXfus+oLo9Ifl+uMxXpfZCkCfgqlZs3KbgA1NjnFKkWXQwQghaXRIo7C/YRLPSwn2GPS7R+z4J2oHvkLKSlp3TQsb5bTmvPRJAalsTLdTSfQ1jLwFPxP41nWd2D7HpiZK0dVVVBgCsDnJDoSVoqRtbnumUYFDoTVeBd/9ohiRcr1SQLpIen3qHtyU/iGu0A7s4L3pAw7l2+hSy84ppd5/1rjzpqE36ZT3E8OQbWiRm9E/3zUgXuYo/ppxt/0nClYC6wQMIU5gaOSIbx7+8ib1zpkPCp9Iz0g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS2PR12MB9567.namprd12.prod.outlook.com (2603:10b6:8:27c::8) by
 CY8PR12MB8268.namprd12.prod.outlook.com (2603:10b6:930:6c::16) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.20; Mon, 23 Mar 2026 18:24:58 +0000
Received: from DS2PR12MB9567.namprd12.prod.outlook.com
 ([fe80::636:1b52:24ca:d7e5]) by DS2PR12MB9567.namprd12.prod.outlook.com
 ([fe80::636:1b52:24ca:d7e5%3]) with mapi id 15.20.9745.012; Mon, 23 Mar 2026
 18:24:58 +0000
From: Nathan Chen <nathanc@nvidia.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Eric Auger <eric.auger@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Shannon Zhao <shannon.zhaosl@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Shameer Kolothum <skolothumtho@nvidia.com>, Matt Ochs <mochs@nvidia.com>,
 Nicolin Chen <nicolinc@nvidia.com>, Nathan Chen <nathanc@nvidia.com>
Subject: [PATCH for-11.0 v5 0/8] hw/arm/smmuv3-accel: Support AUTO properties
Date: Mon, 23 Mar 2026 11:24:46 -0700
Message-ID: <20260323182454.1416110-1-nathanc@nvidia.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0040.namprd03.prod.outlook.com
 (2603:10b6:a03:33e::15) To DS2PR12MB9567.namprd12.prod.outlook.com
 (2603:10b6:8:27c::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PR12MB9567:EE_|CY8PR12MB8268:EE_
X-MS-Office365-Filtering-Correlation-Id: ed4eaa2a-c255-4474-86cb-08de89097d3a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|7416014|1800799024|18002099003|56012099003; 
X-Microsoft-Antispam-Message-Info: 8hZlgHS1BUHPMtT2ewSjeNOZ8DRS+MFVDXK4Iz3JRUWnDjo0Npb+5HINS7tVkRoBazrgu+W62UjZ8CnqtwSLhM0EF0hytWL3y6bspWZs/EUynrf62V9Y7V7+1Ru48+eAeBslKpxR/TEB0VaBDpPFUHOWwNZpWBSULLu2z9WHidG7vAbyXtzpJI2/TP5/6xqjE+x8zj6mM9GUI/H3Ar5oQG0duQVln4hilq1onBh1E2AWZpbr2emRxYQjKrol5AuB4aofQQUnIinzt6YN/wer2JxeoEJIiHTVvdUKOOgsnNS8qrXwnZ5P7zb8FiSo0wul7b9yY/aLxTUld17bMmtJy+aZherS2fjtZ390jFAA4XI0dJ6/59u0Yi0ajumLbkMlZbVjHL1suiZunbzzGQaXEO1984jP+W4cW/Yb9bSQuv3C9sW/yr6QqJwS4hSx1l6/8At+T+iA9pocQBHt7COfDa17cE0ocrP49xHc2+8c1pkW0/fOz8zVxswLApfQSfoWlUUxd0LrZZRN8kNAs1i8K7oKWSxY/VAWWisDzxR2dV40CipUvIBD/poRvVT++pGLSCL4eK8vcfzQhsSlJKe8uFedY8SGidUlYBtFKUIJfvetMp2eOcuOwGyDAFca7npnA3LNfLhVXM4BvBRlb3fIV+WEcSzySwOeW2BlHZiIGRycaWZvTrdW4cfaEIo9yTiHrUAiz/D6t+a9/O9gVC0t0Xq0Z7nOMcA4/bS4475+Aps=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS2PR12MB9567.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(7416014)(1800799024)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CGp+vC0rIn6E313TVdX+TwL7/H/6UxyhncV+o342WdLXuVGUrVRuNs+jw6Af?=
 =?us-ascii?Q?elyEfps+/NnuSAGKehNlCUC9hRsBkGPPJZNW1owP+Fb2iTvi2P+N3DQlYnFT?=
 =?us-ascii?Q?AYH9Rq9Jzm/ZeUqYvHWcHnOwuI/apirEUT20epB8sGSGKBjZP4X1NJYaogQJ?=
 =?us-ascii?Q?q7xQzkhkoSPZ0U32M5KQbLi8WfhkkDbj/PBYc/yAHmDUsblu9EyDrAqXgv1d?=
 =?us-ascii?Q?X4LmQvrbwGJfdMV1KOu+hDli5jM3EvSjrvQTj10hiVfcyr20LOVKOdRmjLiu?=
 =?us-ascii?Q?bnidoN+cRjd42qCrT0XoU0Of2dBTYZgArL2XTm4In9nptmCRnnIXIFc6T9cH?=
 =?us-ascii?Q?ity2K6gu+p8JeaI8q2ttvTRP9VbWxT3si7Q2UKeLpbJTB7/4rmlnXPnM8a0E?=
 =?us-ascii?Q?R2SHZAWhhoc8z3iRpa213sN7kGkHfRG0RkbtGKh9XwzIIWdVAhO4pVSoo/+O?=
 =?us-ascii?Q?gAG7j9dZCdMdPfZpm1LOr+89tkWN7pkO+1a3ptkYYXar4J0Gc4nNZZqTqSmK?=
 =?us-ascii?Q?9zEdvdmMrHgF+/pBaQZiGJ6A+b7YurEfJlgFXM9tgvHL3fq9q6xeQxIV5AC0?=
 =?us-ascii?Q?elrv3bUwlQMngNxJe+NB+ZHpD+Lb1yrL0wDq5A6T9sgV8pAqkbYDmnCDjnp3?=
 =?us-ascii?Q?unC+9ocxtSw7HYo33TVPxRHXGyRv4TD0rLlvbgUsEI4/Ba3hrbzPlNWqTJwd?=
 =?us-ascii?Q?FEUC2LpmddGeDk7ZwooE0SXj/0g3Igds2Z2m+mPBY0F+8tFaj8UO1YmN79z0?=
 =?us-ascii?Q?nJNg/aFfEaHAmsvbv+RUm9RtFrOJyBDguC2XgV2+YwQL4ritkGgTSOCIal1Z?=
 =?us-ascii?Q?i9teqXuoogfKp77RCuXpsaII+96ObacDLLvKEkYmssL3/qlH/hnl9s+QhBb4?=
 =?us-ascii?Q?JxcaSv/buK+SC5HNvCT51O6TEX9hROdNIDxQ+pbJyZwmTBXhEio9jxLuhZ6w?=
 =?us-ascii?Q?hWSV5FhaGqS2PESJPzcuMPLFstnibo/AZZnq45V5h+k4RbwXSeaqF9cv2+Tw?=
 =?us-ascii?Q?ovlCxQr+5nRZTIQvkdqOvfTvcirtly6r4usAWLM29yMxUPrUHOpWGYhS4qFE?=
 =?us-ascii?Q?9b+uCnnTBy7Kd/P3QZ4N50/bVE9Y51sBuEDwdZ3cNaWRso5ot2GvRM5lvTXb?=
 =?us-ascii?Q?rg0EE6ZNb9M0z0RLi9wTtvqOgaZrRudo+YTrMEotNta4zGCLKh7weszL4wc4?=
 =?us-ascii?Q?I30XLmPYwUCpxaMLca/P2dWkFpYhewCVu0NgS9tRXJcbEoui1xfHVqQHM0m0?=
 =?us-ascii?Q?SYpU05908S4Nql2hUW0TNOEHKJNDWater6v6FpbFmp5jtEsi0Niwd5zRx777?=
 =?us-ascii?Q?iW+wnioH6S/msiKesBg7SYio/UToZTkKxs/hS0sD9sJRLxWwSyFsAsFHR3sP?=
 =?us-ascii?Q?e2bJbYbuHkc14Ll8INRhmDVV3+H7JoLoaiushzBq/VufJXfFVNCqrBrRhrRd?=
 =?us-ascii?Q?b1yVthw5RaYSxCk5zJ2eWAaArWeNn7BoGn7Xa8VGO0JQuZAojA9y4mz+NXK5?=
 =?us-ascii?Q?5VyVQWw+LyIBjnTWC870ED8z8XAHUqdRwCfg1Kd7cWUcqh8a/Vpd1KyWcAmS?=
 =?us-ascii?Q?eKDuesQ8O5zd7nNQUy2AVnqk7emqh8/ycv64CxkHQrexKGJtyZiPBRJ1JaO6?=
 =?us-ascii?Q?jiQPYPEb7Ga2ehXVR44i0VUkma+Mnil8UK3AEbG5XKlBzN4dEvzJ4gtWlVoD?=
 =?us-ascii?Q?n0GDKvmjuUHebusHsSAyVshqHXbFSxXecSJBjfcM4eMb5tZFaQXUmvUycyoH?=
 =?us-ascii?Q?KIH6BEYQMA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed4eaa2a-c255-4474-86cb-08de89097d3a
X-MS-Exchange-CrossTenant-AuthSource: DS2PR12MB9567.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2026 18:24:58.3183 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4cJc+P4w7TM4FBUkaMal4W68PCS3/vGB2s+KDaPs95abXTmY7Y8v1gK6H4XNamZKO1crGvOVvVddMsLFnVmVpQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8268
Received-SPF: permerror client-ip=2a01:111:f403:c101::7;
 envelope-from=nathanc@nvidia.com;
 helo=BL0PR03CU003.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

Hi,

This is a follow-up to the previous series [0] that introduces support
for specifying 'auto' for arm-smmuv3 accelerated mode's ATS, RIL,
SSIDSIZE, and OAS feature properties.

In QEMU 11.0 we introduced new options for vSMMU [1], but feedback received
when starting the integration of layered products shows the need for
auto/host-retrieved values. To avoid breaking JSON/QMP compat, we want
to fix the option types so that they can later support the auto mode. At
the moment the auto mode is not supported though.

A future series will introduce support for resolving the 'auto' values
based on host SMMUv3 IDR values, as well as setting per-device ATS
capability.

A complete branch can be found here:
https://github.com/NathanChenNVIDIA/qemu/tree/smmuv3-accel-auto-v5

Please take a look and let me know your feedback.

Thanks,
Nathan

Changes from v4:
- Revise OAS validation error message
- Revise SsidSizeMode enum ordering comment
- Revise commit titles and descriptions to mention incompatible change
  and change to 'property type' instead of 'property'.
- Collected R-by, T-by, A-by tags from v4, thanks Eric, Shameer, and
  Markus!

Changes from v3:
- Revise auto support error message
- Restore original comment for ATS in smmuv3_accel_idr_override()
- Update the description in object_class_property_set_description()
  to mention auto mode not supported.
- Move auto mode check before check for accel=on
- Remove SMMU_OAS_44BIT/_48BIT and SMMU_SSID_MAX_BITS defines
- Consolidate documentation notes about properties only being
  available for accel=on and not supporting auto mode.
- Include R-by and T-by tags from v3, thanks Eric and Shameer!

Changes from v2:
- Enforce 'auto' value not being supported for HW-accel SMMUv3 props
- Revise docs to mention auto is not supported and these properties
  are only applicable when accel=on.
- Only override non-defaults in smmuv3_accel_idr_override()
- Remove check for SSIDSIZE AUTO in smmuv3_accel_idr_override() as
  smmu_validate_property() checks for AUTO beforehand
- Consolidate comments for ssidsize_mode_to_value()
- Include Fixes tags in commit descriptions
- Include R-by tags from v2

Changes from RFCv1:
- Remove changes that resolve the 'auto' values based on host SMMUv3
- Restore defaults values for RIL, OAS, SSIDSIZE, and ATS
- Update OasMode to accept all OAS sizes instead of only auto, 44, and
  48
- Include comment in SsidSizeMode schema clarifying enum value
  ordering
- Replace ats-enabled prop with a helper that accepts the dynamic
  casted TYPE_ARM_SMMUV3 object
- Separate out guest vs. host ATS check in
  smmuv3_accel_check_hw_compatible() to a different commit
- Document accel, RIL, OAS, SSIDSIZE, and ATS properties in
  qemu-options.hx

Testing:
Basic sanity testing was performed on an NVIDIA Grace platform with GPU
device assignment and running CUDA test apps on the guest. Additional
testing and feedback are welcome.

[0] https://lore.kernel.org/all/20260318184907.4060030-1-nathanc@nvidia.com/
[1] https://lore.kernel.org/all/20260126104342.253965-1-skolothumtho@nvidia.com/

Nathan Chen (8):
  hw/arm/smmuv3-accel: Check ATS compatibility between host and guest
  hw/arm/smmuv3-accel: Change "ats" property type to OnOffAuto
  hw/arm/smmuv3-accel: Change "ril" property type to OnOffAuto
  qdev: Add a SsidSizeMode property type
  hw/arm/smmuv3-accel: Change "ssidsize" property type to SsidSizeMode
  qdev: Add an OasMode property type
  hw/arm/smmuv3-accel: Change "oas" property type to OasMode
  qemu-options.hx: Document arm-smmuv3 device's accel properties

 hw/arm/smmuv3-accel.c                    | 41 ++++++++++++---
 hw/arm/smmuv3.c                          | 64 +++++++++++++++---------
 hw/arm/virt-acpi-build.c                 |  2 +-
 hw/core/qdev-properties-system.c         | 27 ++++++++++
 include/hw/arm/smmuv3-common.h           |  3 --
 include/hw/arm/smmuv3.h                  | 11 ++--
 include/hw/core/qdev-properties-system.h |  6 +++
 qapi/misc-arm.json                       | 44 ++++++++++++++++
 qapi/pragma.json                         |  1 +
 qemu-options.hx                          | 32 +++++++++++-
 10 files changed, 193 insertions(+), 38 deletions(-)

-- 
2.43.0


