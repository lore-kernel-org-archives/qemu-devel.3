Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C891106ACEE
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2026 21:04:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0nCF-0000mh-5c; Thu, 12 Mar 2026 17:03:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1w0nCD-0000mB-L0; Thu, 12 Mar 2026 17:03:53 -0400
Received: from mail-southcentralusazlp170130001.outbound.protection.outlook.com
 ([2a01:111:f403:c10c::1] helo=SA9PR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1w0nCC-0002qm-08; Thu, 12 Mar 2026 17:03:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Eb5aAYehttvKO092jNPKW6NwCGcka0+qHrE/GAkH9RHYN8W2scrFPKZOFdTJ+aJySy6PIbFa/8Scfi75qBebq7+ZX3RGAW3LJ22bEdGXQAD3F+35uqI/kAl3P3QlpcuUp7IRy/lsh2NN6p26EJLYtrd4yNWrLzwQiEiuU2SPsHSQqJx8dapZdCp+c6IgPi/RlfKTx8dEodjHKESUK2m3rE6Fb9+3s3F2LBPThZhcXayGGRgiN7a8wpj/WmihoTY21md4Cy9tsNcMsmGI283pYE8GmsvSwgakQAw9xUugxmlyAEjm4/IKJtoXFazNfrU+YxUxRsgL1nkrsjpjCkoFLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4lyT7aW41IkBKjEu2qRtfpkUorNnsjwJPdgtxodVYhM=;
 b=wN5dKGvZeD9d/V4c6k6HJBaRVR7vm7zmJeShlWwMbAcIJizq2WSLC0Ijj84OOeJwFKSf8eDOx3mD0YBiaUq96hOBAs5HfmDIZAaiohreAwOcmsQx1zmVvPvUCJE1wsssxzRzK6g+wpC4u/KSHd0vFnKX9WJIGZlb9g6R16LD/LxgA4P+MGk11B04b5Jdjk0aywNRxl/GrRXivbgXSSZta024BsyCOv1zlWBSISh03Gywak/81e8VzfJVPy3QmF1FFKpEshBqKvDQUbTfVbKCJx8gBciVxql1yPOToZv2OAvfc5xiohtvcDuxs+k6hZckdQR8PElyN3jXjqI02t+Elg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4lyT7aW41IkBKjEu2qRtfpkUorNnsjwJPdgtxodVYhM=;
 b=tcGbr6pbghpl0bNwFXGN/bMKmF6q90aUYBdVO/w/tJJSAWYieBREcNckvcHx6Lnz+akDSu6OI6o3ZvXsiJTPbWULWPVRNzH6OmdvDG9xBG4VTgh/Zt+C083UHuWHuzBYvv6wlGSxih88mI5GoVHaA4kx9FecqEZ/K5iJzf3X4Ge9AElRBlXEkM0t0whadME1wBrGjz6/TuuN20FX/c7cReEXSKpmaGXQwbtp7+d7urp9r0kIAgzu6w4jTKCUq1Vrwo7DYLzMjxJfEwOQ2lE7aIQUwxBLALF2KneKYA4g+es/ZbLXER+QNfnD+14ftJriWvKfArraTCRiCdyVAhPRzQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS2PR12MB9567.namprd12.prod.outlook.com (2603:10b6:8:27c::8) by
 EAYPR12MB999156.namprd12.prod.outlook.com (2603:10b6:303:2c2::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.4; Thu, 12 Mar
 2026 21:03:45 +0000
Received: from DS2PR12MB9567.namprd12.prod.outlook.com
 ([fe80::636:1b52:24ca:d7e5]) by DS2PR12MB9567.namprd12.prod.outlook.com
 ([fe80::636:1b52:24ca:d7e5%3]) with mapi id 15.20.9723.004; Thu, 12 Mar 2026
 21:03:45 +0000
From: Nathan Chen <nathanc@nvidia.com>
To: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org
Cc: Eric Auger <eric.auger@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Shannon Zhao <shannon.zhaosl@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Shameer Kolothum <skolothumtho@nvidia.com>,
 Nicolin Chen <nicolinc@nvidia.com>, Matt Ochs <mochs@nvidia.com>,
 Nathan Chen <nathanc@nvidia.com>
Subject: [PATCH v2 0/8] hw/arm/smmuv3-accel: Support AUTO properties
Date: Thu, 12 Mar 2026 14:03:19 -0700
Message-ID: <20260312210328.2016191-1-nathanc@nvidia.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR03CA0005.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::18) To DS2PR12MB9567.namprd12.prod.outlook.com
 (2603:10b6:8:27c::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PR12MB9567:EE_|EAYPR12MB999156:EE_
X-MS-Office365-Filtering-Correlation-Id: a9e2168e-b217-471b-d940-08de807ad908
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7416014|56012099003|18002099003; 
X-Microsoft-Antispam-Message-Info: MsiOiey67b/qHx6EkPgSr2pzRqKVcTB9aQiEKPmOu12ghnPR3P4zautcsRSbAwagAdit57SK0toNoqnk26k4CkbwrAhyArddT9yvB3AkccbQwenBhkPWU/bSCYMY/5SU2j8SZkj3Lk6AggXLk2drmF5zwK0sKEvKur9z1/hUEulVVmP7HHrXqApEj72gMoQdVC6R061Ezv4fLG36dBIuK8bZqvwVCsq5Ox2ahx9Wy6kEgxuN6HkRMIs8zaoHMCN+PxnHHbWGEK8ubXmsWOTy1SMY+W5IdthTtAs5LyZ/TDsnWFebdM8m7TG67QJ/za2FgAwxxpzNe22O2WaVdC9YAypUSzoVTrbE8cV3TpFHjU+X1g07FkPEsXJv/MRb3VCRCtV2aDVtQ/I/Efh/qfZG3PBmeBfKG9AVc97kVqHry4jBVD3gnhWqZdEctXD9NvM9D3MzjI7wXWWyQqWNc6I5pEPs0HsC7HsnnqnCdtCGzi4jt9zVckvbcmlbaCDvkINGAoFOOr7IznfLP0t+B59+gzEZSTwm94k2l1A8BldxNaGVMJgkc7DaQsZqCeTwLbrjFQPAkz786wOibk8aHo+et10L3bVVIUHwAg4OrrGqRlhDgU9SLA8qbmYU7O1Qh/Cgx5JMDtBjUjWkwjA5TjHsQUQvD4dzqzuQGJpLLE9PQXgbi/kBM4w+l/ulCg2dz8/Y
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS2PR12MB9567.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7416014)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Xw2IAo1S6dqSrVesyYuuFJatLTNmBoIBuWOLttKQrh/vIhK11Z/6lq8xF+lf?=
 =?us-ascii?Q?Xk/MB3IBF7B0K9ISX6JRPRFGl1JGsQxfUk/Drdum+GHz85HYIrqeIQUToYI1?=
 =?us-ascii?Q?goxSATID7TsIXySh01+7llW9Sei/oRjjWdWR18dF88fowkregZiB/scIhAZa?=
 =?us-ascii?Q?ATPUmr4OZoJa8WedMFLAdcZk/F068hUtSE7ZwzdZ9pOTSfnMeT3C9rY/NPRB?=
 =?us-ascii?Q?ousaScX0gVwZ//WO5+tIuKwUsRRkYYz8PgeIx4zed4uiJNYh0+5exjORIrz8?=
 =?us-ascii?Q?DGgbdrHp138EIONgrbdUl0JRXfJve4zR+JMZYCtWR6UfNjUBF+pXvyBZLBo9?=
 =?us-ascii?Q?XMft+DJNa0p3Xwkjfak0QStdIuVUPs8HT/k9a+8AiCM5x5XDk+AIEkrthhl1?=
 =?us-ascii?Q?FPWud9YflKaphD7AIuc2JHRWV2vB9Wb2NBJo+HVSVPwrSYCzw62cgzf7dY8x?=
 =?us-ascii?Q?0gnsZ3g0ZNIhSGVOyewk2YOcX3s192PCBS+s93FQtyFbsX6UAf9dV/ojlDrV?=
 =?us-ascii?Q?ttB+2PbvQgJanNTxqjO0Hxd9H8K4/z9NYp9ZFjpWF1woXq5Nq4tGYJC3dJvI?=
 =?us-ascii?Q?tzGIX4VZ+CmQzfWn2Oq0ZTx7cE+UQxnK1aHWCNcIf6khnQSGW44jTRZ0As8e?=
 =?us-ascii?Q?1TJNqzCBOVO+aG5cBnMe48ifHwQW6Gry28WL8J85J9lpjJybaWR9iDGYlRdE?=
 =?us-ascii?Q?YF/heKYe4OwFokWDCqG1ZUUBnHL8z3mwWIYPJSz9gof2CRblYluwsw/R7CV2?=
 =?us-ascii?Q?wsdSvKJDAa9PFjydjIPyOSN68fVdwU4ucScVzz8sTkqL7v5G3H+9K0wYUVph?=
 =?us-ascii?Q?8A0yuLDpN4fOjKBEfry9bxZ4yj9Pc/pi4o7gc1DTpgTEbK0kviMXPVfOU5aE?=
 =?us-ascii?Q?98CspenawYjjVWmgM625Iq/q9TmSde50lM7Po+VZE7MwAx9VlcSLEFxGU7TA?=
 =?us-ascii?Q?2Pr3ptsXSTcnk4kJXbIzLUkVka9dT67KWgEzpK6RXBATS1ng/QWJPzjfsi+f?=
 =?us-ascii?Q?geMir8A7qJ+OwIA1pu7HcqnopCIDkmtr/7z/lfZlm9IqZKd5+Wt157Hyealj?=
 =?us-ascii?Q?u0qb0sUfUT+Wd1flKET7eO1QX1wQnVREjj8aM7I0zy8HfBvzz37EiTMwSf8v?=
 =?us-ascii?Q?rCPsEfIFYOlcS03a6QGtH/XXMwoDOpijMmZrJUoQT/9paN/79+GDYYA5v3Ip?=
 =?us-ascii?Q?AO+2pwZa2xSob2NvWb/ywS/xqwbkbTLV7Ct/OdPE1kbGd80oR1fhyy++AsXY?=
 =?us-ascii?Q?QyTzEDcq8cavJ+AXENSu40+67MwoV7B+a0YhBVpv3ciDB1jkoxiQGlFjRsPy?=
 =?us-ascii?Q?O3NpX+4SjL0CO64Teqp90eUF7VixrdNws5eYWijY+rF5QBlYCYzUDI2INxR+?=
 =?us-ascii?Q?zmJv44JotQyBrCRD2Ri8xOLtnHRdwEUV984QD11Tq9TD3SFD4K6NNd9Sz3Ab?=
 =?us-ascii?Q?gWOvSVViln2SQwUTSIwRWy0EszFpMC2B6tSBYmFAYXLPiQGUSGOZchYxgYuv?=
 =?us-ascii?Q?7WVJe8UQwVnSjEcHwXZq4fxpJZYNUPshI8aZHn112sy7Lv4j1m4X9gOOC0F+?=
 =?us-ascii?Q?9gTjP2O40PkGnfbuyefV6qVuCKqt/Px31Y0Nk+kzIGnu+sXbXNiSB/9gq3AF?=
 =?us-ascii?Q?7zDYXmkJg5kPKYYnzbR1zG09QlqgahicbfVeYcEIel8lOXwrH813rbGqu2Ed?=
 =?us-ascii?Q?NPUTVjwiZXZMIjKT7Y2sMsizsgiwM6SuQ2Wx/GKzS4LUvJienAnJaQZi0Kq4?=
 =?us-ascii?Q?txlnsEW4Qw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9e2168e-b217-471b-d940-08de807ad908
X-MS-Exchange-CrossTenant-AuthSource: DS2PR12MB9567.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2026 21:03:45.0346 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DDflv+MusH44ScHzirdkgRSVP8WOtI5SDU70mX08GTM5R2+WflvQ8YPc0UVTJuNIJpHersjSPU5dxirI0hV9WA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: EAYPR12MB999156
Received-SPF: permerror client-ip=2a01:111:f403:c10c::1;
 envelope-from=nathanc@nvidia.com;
 helo=SA9PR02CU001.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

Hi,

This is a follow-up to the previous RFC series [0] that introduces
support for specifying 'auto' for arm-smmuv3 accelerated mode's ATS,
RIL, SSIDSIZE, and OAS feature properties. Based on feedback from the
previous mailing list discussion, this refresh only converts the
properties to the auto form, keeping the default values from
Shameer's HW-accel SMMUv3 series [1]. A future series will
introduce support for resolving the 'auto' values based on host
SMMUv3 IDR values, as well as setting per-device ATS capability.

When set to 'auto', RIL and OAS will use the defaults set from
smmuv3_init_id_regs() while ATS and SSIDSIZE will remain at the
initialized 0 value; i.e. RIL enabled, 44-bit OAS, ATS support
disabled, 0-bit SSIDSIZE.

A complete branch can be found here:
https://github.com/NathanChenNVIDIA/qemu/tree/smmuv3-accel-auto-v2

Please take a look and let me know your feedback.

Thanks,
Nathan

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

[0] https://lore.kernel.org/qemu-devel/20260309192119.870186-1-nathanc@nvidia.com/
[1] https://lore.kernel.org/all/20260126104342.253965-1-skolothumtho@nvidia.com/

Nathan Chen (8):
  hw/arm/smmuv3-accel: Check ATS compatibility between host and guest
  hw/arm/smmuv3-accel: Change ATS property to OnOffAuto
  hw/arm/smmuv3-accel: Change RIL property to OnOffAuto
  qdev: Add a SsidSizeMode property
  hw/arm/smmuv3-accel: Change SSIDSIZE property to SsidSizeMode
  qdev: Add an OasMode property
  hw/arm/smmuv3-accel: Change OAS property to OasMode
  qemu-options.hx: Document arm-smmuv3 device's accel properties

 hw/arm/smmuv3-accel.c                    | 42 ++++++++++++++++++----
 hw/arm/smmuv3.c                          | 38 ++++++++++----------
 hw/arm/virt-acpi-build.c                 |  2 +-
 hw/core/qdev-properties-system.c         | 27 +++++++++++++++
 include/hw/arm/smmuv3.h                  | 11 +++---
 include/hw/core/qdev-properties-system.h |  6 ++++
 qapi/misc-arm.json                       | 44 ++++++++++++++++++++++++
 qapi/pragma.json                         |  1 +
 qemu-options.hx                          | 29 +++++++++++++++-
 9 files changed, 169 insertions(+), 31 deletions(-)

-- 
2.43.0


