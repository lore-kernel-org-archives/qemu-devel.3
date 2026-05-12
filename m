Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4655ACD343F
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 19:37:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMstW-0004Po-DI; Tue, 12 May 2026 15:35:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1wMstT-0004Og-0l; Tue, 12 May 2026 15:35:51 -0400
Received: from mail-eastus2azlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c110::3] helo=BN8PR05CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1wMstQ-0005nm-GI; Tue, 12 May 2026 15:35:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p3+ELW+98QRpxgOPrqxmPJRPi1jP/Atv8ycxQbJ0SkxCr1fUPjxsLgM8OJb+zKgQA9W3R7a4lmE+71V6zOgFgqXYdUeH/je9FFoff11iVhHlNJq8EpuxyZ2Deoovi1eJuyf07R7vccYNjNamXhusp6gse2e3dalChInOXhUPEiOy/fqTFz79Tys+bveqna1POY0V/0y4kdcTy4cIZuEY3sOh59E+awkfcVkMuCWEBwO4znZVVv526D8XzRZ/VIYlRlIIFI5DqJnAO84H/5ch+E0LROiGN212f6hJDNDFrrejODENMOTm6QsExRiqpbLXtlvXZfz6DuWoVX+iR4hZxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TeRjiS/yYbcu2/q7UuQBK2lujYCGkIocK3QWXJFATok=;
 b=T0qPcBQgpqEIIiDEJIgSMSP3g3wA77nRvma7sMSGvXRROj8UUEO2bJgewMOOP2QpbAV3eePRuOQ/WMF8Faq059KAzk4ECzhncZHfTvzM3ebmJB8pyk366suR7wVCX8wQ9bBXoYrKbAS3thezK4ZuYFa9ZAz9MAYB5z8O1yCOoQZV+GEaezar+qrG63wU4CO+84uh1MeEr8mz2/cbILUkxZto8qy5Nsa7cdRt6oOvvuxCJ/kzAytkaNWCUJ2Nd2g6mdzuaekOEd+pqPmkXa5rZGucgmtATQ0uI0GxJSo/ndXQITxF+jZ25QyGaDaR1dYRoLuZucNQT6WQMJGNdvvzDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TeRjiS/yYbcu2/q7UuQBK2lujYCGkIocK3QWXJFATok=;
 b=eszbEDBSAi//+1WqWOqxiSs5jSrSJLbODKl0h/U//VTPpymF1st9OdIfX8YdpcOqIozTnOen0l0NJGKi+R/WeXZYrOm1vjB8Aixr+gpucpwB5SvDm/MT+8EMHeVcJBs/BBoizy+OojoktQdSMcoJOFC3TlX3oUBOIhnoIW2KPH4ZkQr1Z8yTCGFaRkG0bv45hX1YBGFjhkJlm46gLl0uR0YeHrQQ5HevLQr3K7mRr9HaQl5BrMGh0FL0iaHvPc8XxZnshLC38UUjEHEFpnCKO5pgvtodIXWfhp+v5OOP0wPq8IpNClYgsijklZOdsOm/jM/njgt9Xb1LAs3ewEEXtQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS2PR12MB9567.namprd12.prod.outlook.com (2603:10b6:8:27c::8) by
 IA1PR12MB6018.namprd12.prod.outlook.com (2603:10b6:208:3d6::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.23; Tue, 12 May 2026 19:35:40 +0000
Received: from DS2PR12MB9567.namprd12.prod.outlook.com
 ([fe80::636:1b52:24ca:d7e5]) by DS2PR12MB9567.namprd12.prod.outlook.com
 ([fe80::636:1b52:24ca:d7e5%2]) with mapi id 15.20.9913.009; Tue, 12 May 2026
 19:35:40 +0000
From: Nathan Chen <nathanc@nvidia.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Eric Auger <eric.auger@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Matt Ochs <mochs@nvidia.com>,
 Nicolin Chen <nicolinc@nvidia.com>,
 Shameer Kolothum <skolothumtho@nvidia.com>,
 Nathan Chen <nathanc@nvidia.com>
Subject: [PATCH v3 0/7] hw/arm/smmuv3-accel: Resolve AUTO properties
Date: Tue, 12 May 2026 12:35:13 -0700
Message-ID: <20260512193520.3109172-1-nathanc@nvidia.com>
X-Mailer: git-send-email 2.43.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR05CA0095.namprd05.prod.outlook.com
 (2603:10b6:a03:334::10) To DS2PR12MB9567.namprd12.prod.outlook.com
 (2603:10b6:8:27c::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PR12MB9567:EE_|IA1PR12MB6018:EE_
X-MS-Office365-Filtering-Correlation-Id: fa695c22-73a1-4589-fd5f-08deb05da648
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|11063799003|3023799003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: malSQREVg8BywYwgjVibGub2tg0ikJKF9JYYYtP8N8INY95PnmrD6QdWdsdZlFPYX5eAc9KIBInWgWNRm6cOuaJvSQITxDjgrCFeQtBQiCzG2lG0bxkrxK9+lOcnELOVNutYn41bzrnh6+PVG83oMEIsbhBZdpsOdjBfpFtMGfMABK9B5Xg7lVmVTz1KgkId0fYOFYuVmii/L7z4o6dUHG34nDQYKb3gSSTJaBqIUEQySr2pYPCJR2NnvsyuLmd8IZgfCvTUAa/G7mZFlKGdBakjGz2XeSS0BcGMsAtg6VdVpRRpkoC8NBEq3TQjK1faUH6+cVbejLDPp2qb2dLPKBVcL3Ohij4Zpe54FbQpkkhG9WYmiZm9K19O6IMCh2K3A8ydP58KzaQvhRaINQpwtmV8/pgq8Z4CHT9V9r+FoFBz48Yxl4gH4gHjnAKQEqMX+ypLom8CnHWoIowleBE3oWtRutOWr7y45PB+a1VVrQCawo7KmRqnYM9s8m/HMFDiU4z82hqFvdvyzD+jdjdGmnHqjSTslJxVJ4uQ5EjH3irBBEhw56HT+gg6KXVhXM1Xr9Ev1Xtd3cxK49PTwI8AnbZFtN8aLfbdPO1rWdRiLLa7k5ThuK9MNz/cMtqNozpfBF0GmtKR8l4fDcnAwrmrXVlWyEiG4JidCuqQRRZ+ng8TzS96mkx937udPI8g28uhp+M16J7/jsaPTJ5dDWgrdw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS2PR12MB9567.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(11063799003)(3023799003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ejhUVjRiRDJQRFZ1Z2hlbCtvbHdVcFVDQnZuNTlQNzZMY1J0cWhSSTQwWUY3?=
 =?utf-8?B?eG5teUJEYndSa25SS2JUWVIyR3Z4SkFNVlpWelp2TlVCbkltbTZ6S2lLYzRN?=
 =?utf-8?B?ejdxVHdUWUxkVDRKR21WNkZwQVVxK3JkUDRaVWQyOFdLRUtOV0lWVUlVU0FY?=
 =?utf-8?B?V3EvZjRJVCtZRjBmc1pUd1ZQNzd5WFhmVWd4b2hkeVoyQlNzbkZTZFd6TkU5?=
 =?utf-8?B?UFdvc2VHdHJqbjJtU3E2T2ZsMlVGb1BhNmJEbXl1QmFMYjZhWmdyN1pLRUxY?=
 =?utf-8?B?aW9TNXlMQ3lMWEJrVjRNMGZqTis0TDBpeEduRG9TNGY5akUvOXowTklKZGFL?=
 =?utf-8?B?dXRqVkpoS2xQSXVDYVNBU2ZmTUdCU1lYZ2owQXVqOS9hNHFwSVM2ajVzQ3Y1?=
 =?utf-8?B?d3NNbWVjSmxHSHUxOGU4S1RVaUg1djFKdWIvalpGbHVHc1F1RXkxSkVzU1NY?=
 =?utf-8?B?TlJ4Wng3aGNqdmI3L0VDMmtYV05IOW8rcDlwWlUzK2lBM0lTMkQxRUludG5h?=
 =?utf-8?B?REhNWHRKUFVCTFo0R2F2b0VpYXFPaGdPY0E2ZEdTSzN4ZHQ0MjhzOUdjTXZE?=
 =?utf-8?B?MStXMDRZREdRazBPSWVoaFQrK0UwNmVUc28rekZqSlZJTDRKTFV0ZlRFMGJr?=
 =?utf-8?B?WWZsQndQekxrSVBNTUxEV2FOc3Z5UWg3MUw2dXhwcUc3aDNaekNxeHJFTzJK?=
 =?utf-8?B?bnN3empzcDhHcXNzSk1tTmVoRHlrS2o0RS9pelhMWXg3cmpEVmt3aDBtdTF0?=
 =?utf-8?B?TGx4WVBubUEwWEQ4UVkzYWVNc01jckxrMWFaNTRkSnpVU2xqa1h4Q3hBK0hI?=
 =?utf-8?B?U3lkWDUxR2UxMFp0a1NrRnpKWmlySmdvODFIdVN0UDM5L3dJbmJnR3pvSmpX?=
 =?utf-8?B?QWUwOGNER3E2VzhvTG1OMXhWUDYzU1BITnIxK01yWERyZ3NOY1Q1SmNQWmY4?=
 =?utf-8?B?c3Bkd0gzVGR1NDEvaWFwMlRKdDdOK1RHMFJHOFA5Q2I1R2hlVzJDUmQ3Q1cv?=
 =?utf-8?B?VUFuclJVVGcxelprWjkyWXRvUi9kWUtoWWtXUXNkNm9XOFcxTCtGMVA0VGJ4?=
 =?utf-8?B?MlZMeTlmSFFwMlFFZHFwemNPMUYvSXR0Um5qZHRNUjFBYmxLNlB3Qk53SjUy?=
 =?utf-8?B?R0E1NzhoNjZKZVEzZTRQV1doTG9xTTdqYUdhQXRiTjJQeDdEQ0x5dmNJMUtB?=
 =?utf-8?B?anN6NlcyU2E5Z3dEVEtjdVJUUm4vSFExTVMwRVBXNmxUT1FwYzlVR21iYmRF?=
 =?utf-8?B?K2JRUjNzT2VwcVJqQ0hKYm5DZ3hvQTFnTVlCRml6K1dkWFJLSHBOb3NaaTU3?=
 =?utf-8?B?eUlTWlVjZ3lmNlFmMTlIeVlLTXA4V0FnQUlLU0tWcHBSdUZxV2dRQjBVczZa?=
 =?utf-8?B?K3FTaG1Qa0Rza05oQ2lmWllWcnFzVVVRMnN1UmtwN0xXTmlhbGR1YmpPL3NR?=
 =?utf-8?B?SS9XdjNHSVlna0UzWXY1WnBDYXovck90RWJRWFNJWlljR1lQMkp4ZkpUcnRi?=
 =?utf-8?B?RVFOQU85VUdCTHhGSWlkdjNvV0VnRmxrMjhsUStTMHpUeFZER1Qra3NVRlkx?=
 =?utf-8?B?RkdpRTFuQmRFWlIrT25BS3NSSjRnZGRvU0htV3A1ZWhyamIrRndzT0NjTVJj?=
 =?utf-8?B?SGtWNWJraW1HVlFvWkFhZi83T3BXbVE2ckhCWVptU0w1QldZV3M3dGFtVk51?=
 =?utf-8?B?aWpDVGczdmFaS1d5N0dmQ2gybzNhT25hcHhtK1ZKZTZUVEFsZkNtMTNkWE9C?=
 =?utf-8?B?TVpwa3JEZUsySGorS1IzWUZ4WEF3aEdBWnZSZCtwSStZMFRMSFdWdzFmYXo2?=
 =?utf-8?B?N1c4aXE1bFF0dUtSZ0hLZ1M1UE1HWUxUTThOY0FHZGN0ZGlNTFBQQVJabnFj?=
 =?utf-8?B?UXdQNDdwYmQrVFloQVVvMGpsZGl6b21YRlVvSWVCbzdpMkZkREhlbnZ0NTVG?=
 =?utf-8?B?aFpFUEo1TmhrS3dwM3RRVkl0b3F4KzJmTlJ2a0xtbTVwZEdDSlF2WWsvVjBZ?=
 =?utf-8?B?VE14bjd2TFRBQUxTbndRMmZiZUIrY1pTR1J6U3ZZbTdGelkxQ2dTcXNBY1Mv?=
 =?utf-8?B?Mjc3VE9ZUTM2YStLQ2hXS2tQVWsxakVuUXFHdENiSk5Ya2Q0c1hUQkVsNmM4?=
 =?utf-8?B?d1hMbFVBTzAwZHNIWjYzb3F2SXF2THBRaVE3a1p6YTRKb1l3YVRnLzNVdDZr?=
 =?utf-8?B?UkJGSlV6NnBkNSt1RDh6dzJDWVJYYjhqQXhsN3RFb0ZTR1Z3NHVQS25SN2Vs?=
 =?utf-8?B?SDJHOFlxSGJxOTIxNk0vMGFoN1p0RzRrODdvOXNaZXp4RW9MdG9waHk0aU1P?=
 =?utf-8?B?Zk5LaWF4QXlxMFNGSU9DYjR1SWRkMUNzTGkrc2tvY3BoVkJxN2hLdz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa695c22-73a1-4589-fd5f-08deb05da648
X-MS-Exchange-CrossTenant-AuthSource: DS2PR12MB9567.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2026 19:35:40.3540 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ugZlXsWxVMVBc+ZMmEFHmt/xnIZM+4NzyLORcDGmpJ3R3zRrkCCmfMFnmLZG4c+jSDit9UW/FE50G/4vF4dqKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6018
Received-SPF: permerror client-ip=2a01:111:f403:c110::3;
 envelope-from=nathanc@nvidia.com;
 helo=BN8PR05CU002.outbound.protection.outlook.com
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

Hi,

This is a follow-up to the series [0] that introduces support for
resolving 'auto' for arm-smmuv3 accelerated mode's ATS, RIL, SSIDSIZE,
and OAS feature properties based on host IOMMU capabilities. This is
dependent on the series [1] for changing these property types to accept
'auto' values.

Accelerated SMMUv3 Address Translation Services support is derived from
IDR0, Range Invalidation support is derived from IDR3, Substream ID
size is derived from IDR1, and output address space is derived from
IDR5.

The default values are set to 'auto' for all properties. If accel=off
and the values are set to 'auto' or are omitted and resolve to 'auto',
the default property values defined in smmuv3_init_id_regs() for OAS
and RIL will remain unchanged, while SSIDSIZE and ATS values will
remain initialized at 0.

A complete branch can be found here:
https://github.com/NathanChenNVIDIA/qemu/tree/smmuv3-accel-auto-resolve-v3

Please take a look and let me know your feedback.

Thanks,
Nathan

[0] https://lore.kernel.org/all/20260422204335.23116-1-nathanc@nvidia.com/
[1] https://lore.kernel.org/qemu-arm/20260323182454.1416110-1-nathanc@nvidia.com/

Changes from v2:
- Added R-by tags, thanks Eric, Shameer, Cédric for the feedback!
- Re-worded descriptions in qemu-options.hx and smmu_validate_property()
- Emphasize accel=off auto behavior in a comment for smmuv3_properties[]

Changes from v1:
- Update qemu-options.hx to explicitly mention auto is supported
- Update qemu-options.hx to mention auto as default
- Simplify comments in smmuv3_accel_auto_finalise()
- Update descriptions in smmuv3_class_init()
- Consolidate all default value change patches into one patch
- Implement and use smmuv3_pasid_supported() for setting PASID support
  flag
- Move smmuv3_machine_done() and qemu_add_machine_init_done_notifier()
  to smmuv3-accel.c
- Register machine done notifier only in case auto_mode is set

Nathan Chen (7):
  hw/arm/smmuv3-accel: Add helper for resolving auto parameters
  hw/arm/smmuv3-accel: Implement "auto" value for "ats"
  hw/arm/smmuv3-accel: Implement "auto" value for "ril"
  hw/arm/smmuv3-accel: Implement "auto" value for "ssidsize"
  hw/arm/smmuv3-accel: Implement "auto" value for "oas"
  hw/arm/smmuv3: Set default ats, ril, ssidsize, oas to auto
  qemu-options.hx: Support "auto" for accel SMMUv3 properties

 hw/arm/smmuv3-accel.c   | 81 ++++++++++++++++++++++++++++++++++++++++-
 hw/arm/smmuv3-accel.h   |  2 +
 hw/arm/smmuv3.c         | 71 +++++++++++++++++++-----------------
 hw/core/machine.c       |  5 +++
 include/hw/arm/smmuv3.h |  2 +
 qemu-options.hx         | 25 ++++++++++---
 6 files changed, 145 insertions(+), 41 deletions(-)

-- 
2.43.0


