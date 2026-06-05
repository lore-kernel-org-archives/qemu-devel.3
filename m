Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D613CD6E75
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2026 00:18:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wVIFj-0006Ht-BR; Thu, 04 Jun 2026 20:17:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1wVIFh-0006GU-0b; Thu, 04 Jun 2026 20:17:33 -0400
Received: from mail-eastusazlp17011000f.outbound.protection.outlook.com
 ([2a01:111:f403:c100::f] helo=BL2PR02CU003.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1wVIFf-0007xI-7d; Thu, 04 Jun 2026 20:17:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cLwKHaWWX2J3rHGsqoH4ybZpcN6awXsOzBIlINNtIg8TfQOKk6Kf+E6qHTUSEuCuest/s7civQh1wDViUQ3pUc4mEdyTzzcix5OtROfyygQy9TiHCa/8doSzO4AlOrexg2/zeKV+FGIrl2HeSHTKFqJi8vDqJckgsgCfB9XQ8uc2kfcYTNNuGDBSE8w3CZbSlLKMjBT2J9ptA31fHUViIyZaeBjv9CQsPfNbO7pMB6j6RV6Gn1UicYfgPKdoreaR5/qVzMpPjkPyppYQh0E4ILHG8vTTnbRFvkihUuxgUdehP66T7YN6OkgR5dwbNAa574VNLjordVBXNUvTXhhwlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zrhJVbcAJdPjmg9KVAbhJmq0LFC2CcXSP7ihTQwK/QA=;
 b=Pxuss3AJfsyBm8/R9FwFE/4KbP5wrMNAxbFFH2WSFB+io6yQubvos+MESO0sP1B8kDOiJP/jkgAlXCKR97Tx5DD1vlC639nkV3c9oOxcnhAn6+vsBz+y67IUQyfIb5P9qjyEx4ATNgzpiEJ6CljnvAUMgAmEY43qMni+mgSZTLINKTbjf/hWmtHH3b47KIY4N3KYIQJ5xNf744MEemRUfNuXEr+gboEDGKV9EQjahXuEQEx5HvITmJtsula530dxwioouauZszjfClsEqvm3uYmPwNlDb4oMP9cwcSozMFycr0fr8hcYbwVFXsS/sQNgNJhQ7qFEM63WNAvQvGjZxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zrhJVbcAJdPjmg9KVAbhJmq0LFC2CcXSP7ihTQwK/QA=;
 b=SB63OpP2Y9bq3IbpHl9620RFVm8+2mUL+PEMvXaP6b7GrlbOyH0IuAJlUNhBj9hUrayknvShpilvIIfavDVGIcRWDeAO6+Yqm5gC3Spqu5YsagxdIQkQlIyJ4CpXMWLH0p0AuoIpDFC71gbUfXNnQ1J/4R7QanXSKbGkSZdjbIUXd60UGN1Wlf/hxU4jyngPjoEaZG02ckgnN7b85fPi2ya0csUchFzz5LnK3V/+T/gQxDg3D41vtOhp82HDuhl8jMPEvHCM0oskQuIjtdL089x2kOdp2KQctx3NwAPlZWJduE817XvY/Ro4/BEteCi1EYzYaLc39a+g1uGBGobSGg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB5390.namprd12.prod.outlook.com (2603:10b6:5:389::15)
 by LVUPR12MB999159.namprd12.prod.outlook.com (2603:10b6:408:3a4::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Fri, 5 Jun
 2026 00:17:17 +0000
Received: from DM4PR12MB5390.namprd12.prod.outlook.com
 ([fe80::2815:c27e:a0a:2720]) by DM4PR12MB5390.namprd12.prod.outlook.com
 ([fe80::2815:c27e:a0a:2720%6]) with mapi id 15.21.0092.007; Fri, 5 Jun 2026
 00:17:17 +0000
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
Subject: [PATCH v5 0/9] hw/arm/smmuv3-accel: Resolve AUTO properties
Date: Thu,  4 Jun 2026 17:17:03 -0700
Message-ID: <20260605001712.1823737-1-nathanc@nvidia.com>
X-Mailer: git-send-email 2.43.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0193.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef::18) To DM4PR12MB5390.namprd12.prod.outlook.com
 (2603:10b6:5:389::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5390:EE_|LVUPR12MB999159:EE_
X-MS-Office365-Filtering-Correlation-Id: 677f6ceb-ed1f-4f4b-eab8-08dec297cd3d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|18002099003|6133799003|56012099006|3023799007|11063799006;
X-Microsoft-Antispam-Message-Info: hR5KSM4IH5QkEztVCffXDk/+wLzApPByde+bjp6r4R+y2skBgJosqDRiZyyTkkkxvOnGzWmB8pZ4eGE0g5hF8YYeE3tgcFNRZhKP6riuExRVUzLuSjMu9MhmwcWV/o8o60UvkQGI6zFvuHObzkemqUWHEnWvJ0kjS1SxRJc0rwCcTiiSDersZM5MrPE3XNOyV+S2yP2te+tIZMP/IrYDb1E996umM9ffxTYUoi4zUvqGaQLUKaCaywh/a7GpLEKD1K1m83Jlb7T0hzmXI37ScSebqK1KHRK9ggzAc6A4vGHPxayJLlCA9hmwjXtCj7unLyqb4ZLjVDEmeVPK3lEB6OAol0C+vDCPEDJTxQ3bVwPz3imS7FCFFTSeugszW7epRkJulLGQRMjUOovPtEJN3nkVPNKkM1qmPYTVQV4n7QLKU2GwByRVQnIs0IF91bFKrtb+xJL+HkYs5J2DEYAWzIp406wc9CpUR7OZktzThfAkqouB5nBPBh1hYF9eP20QqCim8Aa5c/cCb36t9QxOSSVxCop3pHkgUOVhUdWzOSVmRD5/gVMURSkIUtoCm5dNWGkd8PCVjytjIWS8Pm//81fepjQaeY7ThAYooEjY1q/BZx2iCSZtZw/Ptkv8hLfSOEPEpSb8ivKwSmErv6eONUWtnPiirEj64jmcoQLzjSRydoQNAUeSINPaR15v2LLgR1hRaXvsTnYKZXIMOGIewA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5390.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(18002099003)(6133799003)(56012099006)(3023799007)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aTBSL3h2dzVyR044UEZWMXZUbENIZFdPUHd5K0h2ckhqeVBCTWFHTEtIUE5B?=
 =?utf-8?B?TmFZZ29uT2p0cEtDMGJjZGJON0FIOHRHWnJjKzZ6UU91Mms1SU05elZDc3Fi?=
 =?utf-8?B?YVBLUXU2UEZ2R3ZKWGhCeGdCOHpiVWEvRlV2RkpLNlFsNE03bXUwa3d4NzA4?=
 =?utf-8?B?bXZoTXFrWGJSSHE0UDM0UEdPNUpsQklFQ1RnVU9BbmRYZ1ZSZW9ZOG1nY2Rv?=
 =?utf-8?B?YnN1K0xUQjU0QXFoT3ZVRFdOQ1B0dXdXQStxU09hd3JvZDVNcGlLRTk4WjRQ?=
 =?utf-8?B?bjdPM3diOVBYV3loZVREVmx4TDgrMmQzcURDdjdNT05taFQxU2wxREN4ZURo?=
 =?utf-8?B?NnhuOTlQMmJFZStzM2dzQ0ZDelhqVnJaazZyWWphSlNNaHJpNVJFM2l5NmN3?=
 =?utf-8?B?MTNqdmZtUGpETFM3SCtQeVdVTHJqUnBKS25ueFlxcUFHbkNub3ZMYUtEWE1S?=
 =?utf-8?B?MFBpNFNDaVJ0QTdqWWZxdFFBN0tEQTFwdUNFdVg0U0pIUHdjOTh5SGFxSjEz?=
 =?utf-8?B?YVllRmNsanBnNk1tTnhMcXZNOHYxVEhjQkIzYVl0N0hhVWZQRjNKVmQzM3Zj?=
 =?utf-8?B?RVY1aTNFWndnYmpEYkRXeXRvTVA5azdEQUdISHJ6SmZENDA0K0UrQzFSYlIv?=
 =?utf-8?B?d0VhZ1pvR0F1U1ljRk9YdEtDaGd5UExGVWhkbUtjYkV3MFFEbDZJcGdXL2lr?=
 =?utf-8?B?anp3VzlNNU9GWHR2aFJSTTUvNGpTaGttQjEyS2lGdmlHZGUwU2VCS040aG84?=
 =?utf-8?B?VW5QTHhSeWlRZ1Fiamc4SldDQkNXTDBFVytoZXpISjQxKzdoNzNQUWJDM2VE?=
 =?utf-8?B?QkI4YlV6enVvdmRXd3Q0REVEcmNYQUFWY29NVit2ait0MDh2SEZCWFZURHNs?=
 =?utf-8?B?Q1Z4OVNaVkI0ZTA1Vm9iRVRyZmR4UFloVHgvRXRwUzVoZUxkajY1U09lWUJ6?=
 =?utf-8?B?Wmk5TnBFdWF6bnVDODJ6eFdVOGJDYVV5TGxFTVlnRW9oRVROT01hdFA5OU0y?=
 =?utf-8?B?TmcvVGFLdXJIU2I2S2lic05pdUVtb3dPVmVGUnZ3VWEvT3ZoU05vdktDT2pW?=
 =?utf-8?B?dVRIRTRhbjA2eCtNOGpBcWp3ekpkZVJQT1FzdkZFM1JQWXgzeFZGMjFQMXJl?=
 =?utf-8?B?U2VIUWx1S3MwQk9UT001NHVsN0tCUFZWQlRMcFQ4Q3Q3SzdDa3JLS2E1N25i?=
 =?utf-8?B?UzlHMFZlaU4xSVcxSWMrN0orMUd0Y1B2TERrcnVOdFllaDZDSEU5bGVXNHQz?=
 =?utf-8?B?a2Ryam5MY25rb25FU3FacG9pZ0Z6WTZtdEJ4RDN6U29BWDgveU1malF5aTNy?=
 =?utf-8?B?MkFCN3JacGVvRWZTcWVMWWR5Y3ZrODZnUE9ibGlDMjY5K1c3b25OelhPK3Bj?=
 =?utf-8?B?L3FNWTloVmhVMFkyRWJHekxHRk9UZ1B5bm1Ra1N6VnVtaXBiVVEreWQ2d0px?=
 =?utf-8?B?cGx6UktFV0s3eVVJV2hVUFNrZm5BbTRYVlFjTjg5aDBKTnZnakJIaXZ0UEVr?=
 =?utf-8?B?MytBZ0dFVG9NSnJ5NEZWNHNIVjBhMWJzM3dIQUV1MUlCOWp1cVZBYWRJTVlq?=
 =?utf-8?B?b3dWeXdrNGxKU3NlU2xGWmZGQ3JRSVBZbDdJK1hGSFRIMFJRa0J5ZHU2cU91?=
 =?utf-8?B?T2p4QVR5TGIxSFFFVTltbWNUUEdhTzJNNWFNY0c5aVpobDR5bk42N081Wllm?=
 =?utf-8?B?M2FDSW5ncEVuMnkzL3R5SlFJWXRMZTU0bDR5ZzE2UGpRMTJOMGE3b0p3c2I3?=
 =?utf-8?B?YzI2VTNsbWVvN2ROTmhha090SUxxQmhyRUJSYU1EWVdWMklPelRZdnBYQlB4?=
 =?utf-8?B?VTFZNzNmcEtrMTJzaEJGMGtHSk9rYlN1UE8zT2tqSmdiM0pLRkZ3VEZFcTlm?=
 =?utf-8?B?bWFhdGp3Vlc5bjdZMG1BclBQZFVTc2xiakpST1lRLzhxREpSVHZkWnZZWWdE?=
 =?utf-8?B?eGRQbFhkdzNkamIrK2Y1L3hZdldCaWFaelA5bHVoNy93UklHWlRraE9sRDBo?=
 =?utf-8?B?VEFxcXc1ZUgranUwTkdPSHRhYXlPSXhiQTdvdmRKeGVVMzZxN2NvRWpsazl1?=
 =?utf-8?B?NjdjL2h6Q0VFakZOVDRxVk1NRW4xaDVsNCtUOTlWUzlCelZoZWpzWWgvakNw?=
 =?utf-8?B?ckRYVk43SmJvSWxrS09iM0M2dWZVZWx2OGdIdE1zd29yWGNNMUR5TVo5aUEx?=
 =?utf-8?B?cTZ5Wnp3elFPVlRnRDNaY2F0dkdQOHdRYjl6emNEdHY1NWp2azNlSVVBMkoz?=
 =?utf-8?B?MUpUcmYrWUQ2Uk95b1hRcDVaVDdmWnFNbVYzbEg1ZVhIWEhrUS96ZUFSR1NE?=
 =?utf-8?B?ZGlhUmVHV0l3L1BtMjZPVm14cFFCQ3RTY1NOT0piaE1IN0xpSmxCdz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 677f6ceb-ed1f-4f4b-eab8-08dec297cd3d
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5390.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2026 00:17:17.3590 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ngL6lOSVSD5UwNUBMbP+JCC7BUMUoTwWKMjspiAd0/+dkA/+jdnpHh2AQkd9SNmnl7ZJtjbwsICNH5lA7bSFyA==
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
https://github.com/NathanChenNVIDIA/qemu/tree/smmuv3-accel-auto-resolve-v5

Please take a look and let me know your feedback.

Thanks,
Nathan

[0] https://lore.kernel.org/all/20260527221631.612026-1-nathanc@nvidia.com/
[1] https://lore.kernel.org/qemu-arm/20260323182454.1416110-1-nathanc@nvidia.com/

Changes from v4:
- Added R-by tags, thanks all!
- Re-word smmuv3_class_init() accel description to list nested
  translation support as a pre-requisite
- Fix typo in smmuv3_class_init() SubstreamID size description

Changes from v3:
- Added R-by tags, thanks all!
- Include a fix patch for resolving ATS support in ATC invalidation
  case
- Update host requirements documented for accel=on, oas, and ssidsize
- Fix style issue, update comments
- Update function name for smmuv3_accel_machine_done
- Remove unnecessary early return for smmuv3_accel_machine_done
- Fix formatting in qemu-options.hx based on html render

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

Testing:
Basic sanity testing was performed on an NVIDIA Grace platform with GPU
device assignment and running CUDA test apps on the guest. Observed the
feature properties being set based on host IOMMU capabilities.
Verified that the VM boot will fail without a cold-plugged device, and
that a hot-plugged device re-uses the resolved values from the initial
cold-plug. Additional testing and feedback are welcome.

Nathan Chen (9):
  hw/arm/smmuv3: Update ATC invalidation check
  hw/arm/smmuv3: Improve accel SMMUv3 usage documentation
  hw/arm/smmuv3-accel: Add helper for resolving auto parameters
  hw/arm/smmuv3-accel: Implement "auto" value for "ats"
  hw/arm/smmuv3-accel: Implement "auto" value for "ril"
  hw/arm/smmuv3-accel: Implement "auto" value for "ssidsize"
  hw/arm/smmuv3-accel: Implement "auto" value for "oas"
  hw/arm/smmuv3: Set default ats, ril, ssidsize, oas to auto
  qemu-options.hx: Support "auto" for accel SMMUv3 properties

 hw/arm/smmuv3-accel.c   | 77 ++++++++++++++++++++++++++++++++++++++-
 hw/arm/smmuv3-accel.h   |  2 +
 hw/arm/smmuv3.c         | 81 +++++++++++++++++++++++------------------
 hw/core/machine.c       |  5 +++
 include/hw/arm/smmuv3.h |  3 ++
 qemu-options.hx         | 25 ++++++++++---
 6 files changed, 150 insertions(+), 43 deletions(-)

-- 
2.43.0


