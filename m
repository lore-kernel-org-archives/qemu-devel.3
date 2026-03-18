Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A116107760A
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2026 18:50:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2vxV-0006gW-NN; Wed, 18 Mar 2026 14:49:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1w2vxT-0006g3-0L; Wed, 18 Mar 2026 14:49:31 -0400
Received: from mail-centralusazlp170100005.outbound.protection.outlook.com
 ([2a01:111:f403:c111::5] helo=DM1PR04CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1w2vxR-0004QE-2f; Wed, 18 Mar 2026 14:49:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qRDhlp3I4JMvw51OsZxmq/aB4G/WWIFsJ4H8pLfH6sc+e4t5u1aHbdBnLy0UqDuqp661atRhB+yJvvcLpNZ7LPucLG5PbB44BI4ME4wkFnM+lfOi5OH+EfKktN1UoMV9Lykv7Z0klVdfltn3d1nhXeMONcva+Dd2mAUhjvKdPaoF/2F8aZXf9TKBE6soVjvOP6fOxfJ+8Q1utxKwJK22OYNfoO5eScCZX/vGZfKOQX5IhAwzXi5hI0zGObMa3PupUzmROFld5hOTJgDAdpdtOQAPSCzw8LjbPwWjubKlRJdv7vMeg7fuDOvrGYcB6K5dk536hcPwHkL8LmEUV3aw9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jFAmowXyibytJLb4kIos6t34pRdoWGcgAjyKnLv365k=;
 b=s1JzLaw0HnY7yRKQt92claPaCi0aub9qaAnOhoH3tzppQBXoODNTDlewHY4xhOgHewi6s0Z889yxeN0LXnU42NQ3LrI5VK87Um8vPJos2boYFpMvirDQOMlKN7Iwkc80yZD8b9CedjWCSS1ZHpaLvEInJb8EIUJVvPEMk+Q6S3C+KM3tEYYqnfyNxioelE2tmMJJzSwK3r6ZHtBlJn0oAky9jTBj09lQR9GT8KrfEc9nvjYsb9sej5E+XHo+D+s8PVh3whi+GFIZ197NZ8eV3x0FTeE44ba05cVVL/aAFvljlsM+xc5QxbTxkAFib8bI1gXdi0Y26K5+IXySSOb1WQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jFAmowXyibytJLb4kIos6t34pRdoWGcgAjyKnLv365k=;
 b=Ie1N+vYQRuuo8C/I2kiwjBwttDNOIVK/suJWpx2aicpdJyh/rtFngH13tIm9FoX++mCVdhLOKBvCguG1NGpreppNoGsxJffY5N3VqL8yFahzyoSFPo+V9YyIlbIDD3aRc66L8O1/FTP3WHdRL97rJE5oKFDHSN2BvK9WUNbp6ZP6PlLFeJwZsqPmLQSrHVsM7y4gxQkf0Cutor2JhQDLXJd2SqQVZq8xRS3ZB2892FM2W9kev6FJGhFDxFgMmjQUDnUClufsHOTmpCmHl1krdHS+b9sAZq7DsNKcAe3oVH62Zs1TLw4s50/B7pkKermPTFQP4yjyjjc4wK/hYvn3AA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY3PR12MB9555.namprd12.prod.outlook.com (2603:10b6:930:10a::14)
 by MW4PR12MB5601.namprd12.prod.outlook.com (2603:10b6:303:168::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.9; Wed, 18 Mar
 2026 18:49:21 +0000
Received: from CY3PR12MB9555.namprd12.prod.outlook.com
 ([fe80::fdb2:266d:ee2b:8d1e]) by CY3PR12MB9555.namprd12.prod.outlook.com
 ([fe80::fdb2:266d:ee2b:8d1e%6]) with mapi id 15.20.9745.007; Wed, 18 Mar 2026
 18:49:21 +0000
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
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Shameer Kolothum <skolothumtho@nvidia.com>, Matt Ochs <mochs@nvidia.com>,
 Nicolin Chen <nicolinc@nvidia.com>, Nathan Chen <nathanc@nvidia.com>
Subject: [PATCH for-11.0 v4 0/8] hw/arm/smmuv3-accel: Support AUTO properties
Date: Wed, 18 Mar 2026 11:48:59 -0700
Message-ID: <20260318184907.4060030-1-nathanc@nvidia.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR04CA0015.namprd04.prod.outlook.com
 (2603:10b6:a03:40::28) To CY3PR12MB9555.namprd12.prod.outlook.com
 (2603:10b6:930:10a::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY3PR12MB9555:EE_|MW4PR12MB5601:EE_
X-MS-Office365-Filtering-Correlation-Id: e894f980-44b0-4619-099d-08de851f1164
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|366016|1800799024|56012099003|18002099003; 
X-Microsoft-Antispam-Message-Info: scLmXXHTyNTU3KthUZwGedq6xb+w/z4QLzD0WhlkLX6auV77GOLm/6BKITq2VD/XHAUONeAbpF/CqTRgqn9bBsnTWVqz2UeSJowLmF+uVp+Ju3DfejJ/+Vmt+ZBdcMWVXGzSmbXpZrEBH4JThVXEFFFI8fjTSIxQF6gApp8ldi1Ja+o4a4yX9Ir3Wh1Ew8J4lvxHx4B+pIqZfHgMfNb1WrQbCghuYBF27q21r0NmIMghV5XwT9r11KT9A07pXX11Yy3CHm/itrMbA+eKfW8vy2lZV6h5Up3eBtowuITjoHexmO3yrqXwNLqvkWsuS3Xs7ayp2crvzspAZUVbvnhkClx9/BliiSHkkyyzxUK7mUNogA8kXukjZ5Q87Lw3LB9yEtC+prlOwwCzXEnQupZ0FRUVdUO3iXQvvalLs+PJLp3IZjv/wXAm3NroAEjmyDKMGcqv6ZFvC0m2qV6DYLBCXZ2HBd83asF4nkY3BLaSxw7OzYiMScxNY6RJD7s3wwCm9zUY2byWAfoQ0+DSbgfM64g9O6iIDYkSkyhDtN5M4W7OpqS0sOXKSxXnI7dzn0dr/KMY/PKdaFMuHvIUXJmxMklP/562zhEkEb4VhzQzz1+r60ZIJcJCZ+L7NEXTT0rAGOOZw9hU9S+lpP1NToD9Zg788nHzU1Mb7MtXpfhcq2FgdxhhuWt5Fd9wGWSgfDHq3yg23BI/0Xs+1gYT3feVm2lSYMTcVZeWQYYIyKVVTVs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY3PR12MB9555.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(366016)(1800799024)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?C1VVPpU0swNLCHGXYOhNQn5sUQZK7Yvr8VIsQPXDGDPACsHH3XGSGwJxIFDc?=
 =?us-ascii?Q?4pwDus62VWt37apG/cLD7zzYVU1CkamSkBh4+OtRQH8PkhlxN9JjmhhL6EIn?=
 =?us-ascii?Q?9PiCGKADMAPU7dNGqI4nfP5En+U7GzWGbUQv5e0h32mMa6Y5YdQ6e6gKd4Y4?=
 =?us-ascii?Q?MYdr2ldKoBgj38Bpwolns+yHcFrrfoG67Xj5WH0c0NP9uzepQe3NX+YETaRY?=
 =?us-ascii?Q?K7LyL93gUs5knxgMYBqtMWlw4oYT3mBNdN3PQRAuxoDNx4uCV8ZAGvW1a9u3?=
 =?us-ascii?Q?PLGmmEWw5KK8D6anosGuFUfAlkwo+JdnpM/LJwPRIHTUZXQaCiksgMNvr1Dy?=
 =?us-ascii?Q?Di+scHWC01Bx9NoNtlhTjVfbTPYp0jYaJy84vb1L2pL6Su3ENzCrBVsdKH9x?=
 =?us-ascii?Q?SHOjY4PiZg5NgxOMbirVwWLvm0CmP4dgtaX4dj/mxK28T72LwQE54dgT9Szk?=
 =?us-ascii?Q?1l3YOBd3zNeV9uot3LpuaTv35YbY9sZB0rHs/6L0EVoaL6MOr7cyfbOZzAxx?=
 =?us-ascii?Q?zzdiqyDAfm+qokA5PdzTAXRvBgt2v8pmQM/UY84URqz7fFeQbgpGkj8XlMRf?=
 =?us-ascii?Q?2AQMATx2K/VuPUZD1XaInCvVnRHIsseQ54sUZWEqUiTREucmjl/pIEY1ByQH?=
 =?us-ascii?Q?BjNsrnkn5pUch5NurzE/QeCPeiFNo5p+oNQp5KK4gOmhAJitO/lvGn4JDZgp?=
 =?us-ascii?Q?Eb/X//a1H8pDoaQGsg5snFBU5z0TWtU/lq0om+o+JjiF4BOTOubXWlfBtwLZ?=
 =?us-ascii?Q?2H/16c/otUuNQKHjLZSSfROIguJ2W58rMQulOVeG0MM484rzBAmd8WCuUvGc?=
 =?us-ascii?Q?68/IVmDDRQWK78JqkPV/ZOBpNpxhjE/j8VsNDdrUjNViKT1PvwUGQEpmkiBI?=
 =?us-ascii?Q?CS5zwU7uOYtEC6RcllRJPYtzyphlhO99xyTtE2GVnCIYQER77mlWRSudt7L6?=
 =?us-ascii?Q?eSFONfgX3fhuLx0JtVcnH3HkVNCbvgITygrk3BFfD9V3pN48vFzz6AqGyAq9?=
 =?us-ascii?Q?t6wuSlPSmpiPNFcHZ3QZTe5JiE3o+s7tMTI6BFLpbMbMGBvyr2ey0jFl6o7f?=
 =?us-ascii?Q?or2xdXq7KcYRbpoNrmxrZ69Xm3bCXpQgGAO+31O2psfxSeIf05sZawrd5biY?=
 =?us-ascii?Q?HuDGMwJ301m/8UIurwbgc9QMcMV7/rP6skN0DRrftApHK4zCrVAmX5e8/s8H?=
 =?us-ascii?Q?A6YHuughrIv4wlNy9F+X6BwIM20tUARetzbjCr6h+y1UtK26GLtuB7f8rl6L?=
 =?us-ascii?Q?zVs25L/4ECRlNgMQ+NID7i7l7QJwC3CLY0oxus+UFJdeRwqgzPrX5UgXmBsO?=
 =?us-ascii?Q?11ukGmdUrm6S3CpArDQgZpf5qlcHqCFgpT+YWjjj+0nXNdG+k0W6Ujiso7i4?=
 =?us-ascii?Q?k+3vU7orkWscBJaRlTcZVWl+hoJT4WaHY/SiiiN1AtW+nr9qlBBw8wotWx2e?=
 =?us-ascii?Q?JcAzJgLp8W8+O9Q0Yh4Uugo02qxDYEacA9nWH+13xFEZsf9/bPZCzJYC8vPA?=
 =?us-ascii?Q?qVR0Wz2qrU0t0wQ32caDdodPcFVYic0vflVeWff7TFj1J8M89kEhn/CMPk2m?=
 =?us-ascii?Q?lIDFW4fzCRg3gHAbCMC2CettNFH2PqY471ZAZhI5kPMrXr0CDCcywPkET2e7?=
 =?us-ascii?Q?7xsRZeeFzs3Zua9JlHfIlKMQipwABDjXZ6D+qWurT895u3jq4DJ4LZYDJnJ+?=
 =?us-ascii?Q?mVGy5ZbrIBI/VwoqNh4ZLXIw2EpQp+F0hSvTcRVoZmw76XfVMniOnF/NSbxX?=
 =?us-ascii?Q?v4mpyTHYBw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e894f980-44b0-4619-099d-08de851f1164
X-MS-Exchange-CrossTenant-AuthSource: CY3PR12MB9555.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2026 18:49:21.7035 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dOIw3WuY4zgVGkolhM1Nyoomgw3314sd2Mygrj9NrIAXhU/7vSHqMGZlX7xTFg+JWcdJ9F+kK3Syn+F96AtWfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5601
Received-SPF: permerror client-ip=2a01:111:f403:c111::5;
 envelope-from=nathanc@nvidia.com;
 helo=DM1PR04CU001.outbound.protection.outlook.com
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
https://github.com/NathanChenNVIDIA/qemu/tree/smmuv3-accel-auto-v4

Please take a look and let me know your feedback.

Thanks,
Nathan

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

[0] https://lore.kernel.org/qemu-devel/20260317183755.3721625-1-nathanc@nvidia.com/
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

 hw/arm/smmuv3-accel.c                    | 41 ++++++++++++---
 hw/arm/smmuv3.c                          | 63 +++++++++++++++---------
 hw/arm/virt-acpi-build.c                 |  2 +-
 hw/core/qdev-properties-system.c         | 27 ++++++++++
 include/hw/arm/smmuv3-common.h           |  3 --
 include/hw/arm/smmuv3.h                  | 11 +++--
 include/hw/core/qdev-properties-system.h |  6 +++
 qapi/misc-arm.json                       | 44 +++++++++++++++++
 qapi/pragma.json                         |  1 +
 qemu-options.hx                          | 32 +++++++++++-
 10 files changed, 192 insertions(+), 38 deletions(-)

-- 
2.43.0


