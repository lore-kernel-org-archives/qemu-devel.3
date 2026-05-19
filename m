Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 136F5CD4F52
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2026 08:43:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPG3A-0001Xt-0r; Tue, 19 May 2026 04:43:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Vasant.Hegde@amd.com>)
 id 1wPG37-0001XI-Kc
 for qemu-devel@nongnu.org; Tue, 19 May 2026 04:43:37 -0400
Received: from mail-southcentralusazlp170130001.outbound.protection.outlook.com
 ([2a01:111:f403:c10c::1] helo=SA9PR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Vasant.Hegde@amd.com>)
 id 1wPG34-00037n-Vt
 for qemu-devel@nongnu.org; Tue, 19 May 2026 04:43:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SQwDMf/4OKouVBVjgC5SotWsfaUZTN7VzrfUpftntDVUHMx69Ndz5Rp8ly/U8eWW+g1KX45iF2rBhyLzNZIXbT5f/ZK4b7Nu9hW4hvGnAdnpzkKcgbpeaVs0wZstGWT4Co9/JKMhnh2jm3bJRW+QlvqMlV4ar99t2GxQ/s6WEbUVJKUaAUHAx7RuTIW/6RYDZ05CGxUQZiMbeq+12W6eJB3i5ODV9OtF24Jukl/jqeV9nYGdUvWxMp+sFlTXSyV+N6fkQ0Gq+1XFCm80SBaR4uaaafft2UcoFP4hDDylkhhjGD9iZlmhOZMQVt+PyYpV9oSYG94v70Q8EV5MUlFQKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dDwDpZ046hFwi7l56MO9evCJxHZWOsW7nUF26YLG1aw=;
 b=NEoLJ5VpwSMxIT/W6AS3y5gI7rpPZjDZBhhes6wLpFo1uP5QwLaz6gFYGBJWvZ0/lNUC//h/YpR8O4rDXrbuGSHn2EtAR5+h6LJRThpZFgj5D279gWGwMhRrDRN0Vgm4fndjwaADCBKNmXC9UBMCYk65lFDQ/dj6CElMfO9AOLbtyTugHbJT68NHd9HqSTJ0hDNr4hNV3k+jYoAxFZV/bTHC78n5Qjm+kdwC7qzqXs9mi8MeDzhIJASeHG2fKKu40y3Z/ySctkjS1sXcz453X3cBi7w4l5XKCXYT2wjRsuMgcKd7dFneX5xEvW2MWw592BGfBOYKGNi3RvKivlTeAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dDwDpZ046hFwi7l56MO9evCJxHZWOsW7nUF26YLG1aw=;
 b=2leylsfXtktmD0zewCjP6ZqRGGApvqYUclJ5UiQAQKnCvR8nrFz1d5f1Afr0n4K+tla6bEcYX+i85QB2KEqBhTEMdSlA4LLTV3CaskfSu9DrWa2mR6Mb0Z+bWdsum5KSZnDZmx8haFtMJ2lwmxdimDe4E/FU4mRE5gDMZaWCU00=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB5766.namprd12.prod.outlook.com (2603:10b6:8:75::12) by
 MN0PR12MB6077.namprd12.prod.outlook.com (2603:10b6:208:3cb::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.23; Tue, 19 May 2026 08:43:28 +0000
Received: from DS7PR12MB5766.namprd12.prod.outlook.com
 ([fe80::222:966a:d65d:d08e]) by DS7PR12MB5766.namprd12.prod.outlook.com
 ([fe80::222:966a:d65d:d08e%3]) with mapi id 15.21.0025.022; Tue, 19 May 2026
 08:43:28 +0000
Message-ID: <5f43672e-8da3-412a-9d0c-e169799948ae@amd.com>
Date: Tue, 19 May 2026 14:13:20 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/8] acpi_build: Build IVRS feature report using extended
 feature register
To: Sairaj Kodilkar <sarunkod@amd.com>, "Michael S. Tsirkin"
 <mst@redhat.com>, Alejandro Jimenez <alejandro.j.jimenez@oracle.com>,
 Ani Sinha <anisinha@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Igor Mammedov <imammedo@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: suravee.suthikulpanit@amd.com
References: <20260511123937.32743-1-sarunkod@amd.com>
 <20260511123937.32743-7-sarunkod@amd.com>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20260511123937.32743-7-sarunkod@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4P287CA0045.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:271::9) To DS7PR12MB5766.namprd12.prod.outlook.com
 (2603:10b6:8:75::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5766:EE_|MN0PR12MB6077:EE_
X-MS-Office365-Filtering-Correlation-Id: 64c9e4e3-09fb-4a31-45ab-08deb582b2e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|56012099003|22082099003|18002099003|11063799006|921020|4143699003;
X-Microsoft-Antispam-Message-Info: c+qv06Vlkr5KXojL9b/nxlU0Qzp7Z6+nyQ37feaCyupMF3jXbiUj1boDz1/bi7NIgzcJMzOwoya9KkYQy4eN2JHgYLmtXA0cb/GAuyAqt+MsB1oQAdLjrnTZ38FLasR76Tsntw+iEs4h6kKH1mEs0G2M24EEMBKQJ7Sp+FkujTCeIfyhYCrNh5gOBwu8AX0QoiUXlfv+AQ5i2O3nTu8lrXXBP1fax59yjIxkos/CxpecNW1DxIq2gizceObqbd4u7o90BWjtKTGa6DxqY5BmvYDg/XRlpzfgW+q22vL26bu4SDZat4YlrlhfNTCm2eCeZG8tISyX5HJ1ug7ACPk3Pd1xb5poyhGEM1H5nuvAV2kU73ZpFIMK1c8Utzw6RLN3mNEACNGlOPaeKXCgjZH9o9YxtDi3aBHc956UytwR0ya+8dlyZmlqy2wXUP8N52dlKzbXD00HSL/VldaKzzfHTosxAB0SCgKD92kqqOFEqemuLJ7XrSb1GLeLBECUTNioNFbUX8bjZBNtS0sLAKnZScHSELkaBPv+sraAyWJLGqqb1qbHLYCaWAIKxdVHQ+z1vk5JpyNo0Rzl5ZEmXFEcEZhtjailxgmW0jwNkJf0JJHC8z36Ajxhi0OUPKe5JCfSavCUiTpLGCU8TZbZ/YHqrAnB9hR6lgBCfaglfzIqVt2AB8nkF1Pq66OhZJJ30IU23erM5Y9+Io7oE4WHAhUTuocRGqidAliumtXkfxL08Vo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB5766.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(56012099003)(22082099003)(18002099003)(11063799006)(921020)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eGFGaEljVEVOVFJNUUtBcmc2clZubTdhc2xYVE1rYUtFcVlKaytHSVR3bEVh?=
 =?utf-8?B?OXM0T1Y0TzhIVWczbjFGaVN2dTY0MVVKQk1aZStMMTlwd0FBTWFyRmUxQlBt?=
 =?utf-8?B?dHZDYzBaRmZJSngxMXRYVUtBUGRLb1FyWGlMQTJ0Q3pWNTVOQjBGZXluZkZ3?=
 =?utf-8?B?b0ZTK0cwQkxzeElLUGpURm9JUzduSVVodWRoTk9LVFNKOE1OaHFiUDRZOEdi?=
 =?utf-8?B?WmV1YWFEUzcvUVM1WVRGR05rU1BnNzlKai9aOWlteS9IL0J5MG5BSUlMTUZj?=
 =?utf-8?B?WTZ5YS9ZUm13Z0lPREFrb3NiYWRNVHBBSDRTZGFVaXVMa0RvclJFYnlXUWZ5?=
 =?utf-8?B?RkNzbmFEc240c1hzLy9CRE1HeE5IRFE3Uml3aXF0ZlY3RWd3ZFhCRG5PVlZ2?=
 =?utf-8?B?SjZXc3lnb3dFcm40bDFBdzUvRHVxY1JOT2VucXBRMXhCMWgwWnBPTE5VNlkr?=
 =?utf-8?B?ZVRqM3BqU0I4cUVTa2lZVU9qbFNWVzl1c0FyMmQwbVNFR3N4Q2JXdnFUbmZ5?=
 =?utf-8?B?Zmd2TEpqSUp6S1d2eHM2SzRQbDU5NTJHQ0VzOW5TRk56d29seG9QZm9mUlN4?=
 =?utf-8?B?NExtbFFIaFNnSTloMGNKblFFZDlPYmt0cnRaZnVaV1V6R0J6R0hBckhSTG16?=
 =?utf-8?B?L25yaHhOU2x2Zk1NeDZPMUJ1Uk8rZXAyRGZqcVNzZzlGbjhpTjlFNlVwSGFa?=
 =?utf-8?B?VHRNbG96MnIyS0F6QUdFeDk3SHg1VzFrSEdma052V2dSL0xSYjhWVkRBcXN5?=
 =?utf-8?B?RjBqdGZ2ZGpxWTZXUlh0SjNMUjZCNW9IdEU2MkplQzc2eFNKcEk1bVc2MzVr?=
 =?utf-8?B?VEtZYStweC94SUcxMjU0NGFBQVFLcnJacXptV0VFN0dyT2F6VDRIWWYrcVB6?=
 =?utf-8?B?eDhzQWtJaFZ5QzZMdzljRmlONWUxUml6bW91ZHdRN1BGZEZ1RG1raFc1KzJV?=
 =?utf-8?B?RGdScFhqSkx6MWtQSmhMTEhGVEM3MWhmUUZqOXlWN1hmZ3hKWFIxbFd6Q3Fy?=
 =?utf-8?B?UE9uUmZIdWxjUW5ZeHlpUTNscTJ4VkpxeTFPVDdkVkNJeHNWc3V4R1Y4U2dZ?=
 =?utf-8?B?R3lTM0pxdEplNDlLOFZqMXRnZDFyczMzbDdnc0hpV2JlazhjZUYvQ3RhOE14?=
 =?utf-8?B?ZlUxdUpqSGRPb2dVekdPeXZoNzFXWlc2TlR5SXdRVk1PR2xUUmZuM0lEckpZ?=
 =?utf-8?B?VlBCTVBpNkNJK2wwUjd3QURjZWxIK2dzMzhUelVSL0plV2Y3NGJjbDFmRkly?=
 =?utf-8?B?bHVoSDhGTGErUS9YanJPRzF3TDFXYVkrMXltZkJyNEt4QUNPTG9ZemtXOHJV?=
 =?utf-8?B?dnVJVHRSZmVLdjI0WWNTUERMamx3b1FCcjFiMXpWbDRweThnVjNEWVVzcU11?=
 =?utf-8?B?bzl3WDZMbTlpcTkrYnFnOWZ0RnprK0daSFNHa2ZLRmR4SWRQbVBKRlE1NlZu?=
 =?utf-8?B?NXRZMkpmdUtKVlh0YmR2ZFhxYzBSbnMwTG5MSnZOUkZuLzllQkpVdWRWT1hp?=
 =?utf-8?B?bityRjlnTU1CS2s3MjNMNisyREkwVURRbkRZalNPODJ4bHVoeXFyTklIbjUv?=
 =?utf-8?B?elEvc1orbmNXYk9wZnJ4V1U2TzFwSXRubUlGYWpuRE9UWTlQdWo3bnFtbnNn?=
 =?utf-8?B?QWlnd2krMm1iTklnSFgxOW56Rk82dE5lbnBUNE4yZzgrQlZPMW52NlBxSFo3?=
 =?utf-8?B?K3R6cWlKOElkTVhHMUMwcDJ5SHpwWCtucUlVNUN4dmsvWUc5SlRJWEtQYmJo?=
 =?utf-8?B?Zlp1YkU5b0RwdFZjNVdQYnpvZWZDUW5BY1hDd0VxQnpBS0E2UnFGZVZOZnRQ?=
 =?utf-8?B?NEhxV3ZOVGwyc20yTW5SaER3clJ4L0ozcjNjQzh4NGJPZHF5YWlzUFFxenBT?=
 =?utf-8?B?NkVtWkdqV0FneWIydWJPSklaamtpS2xEM0M4dTM1THVzZUE4ODdtaTg1eDdk?=
 =?utf-8?B?cjRpR2t4aTF1eWpNS3dnaVVoRmJkLzhYcVRXMXQ3SmVIWDRwYnc2N25hZm02?=
 =?utf-8?B?ZVY4ZW5QTzMzMUwyeWtwNHJxbUNhZmwwek1kd3lyR043Q0I3TTJvbDl0bTND?=
 =?utf-8?B?bEY2bHpBbVdScmdTamJLQXdsdWwxL1ZkZ1J1YnNkZm1XR1VPbTZ4RFJiWEI4?=
 =?utf-8?B?L3g0TmZ1RGhjRWQwWElFU0xnUytlTU1jNjEyTDU1UDBnVDFDcDB4YmNiUlNT?=
 =?utf-8?B?a3VzNy83TU9DWEFCOFo4R3VzT2VHUVpSVzl6UU9KQnF5bDIxQUdrQWNWbUcx?=
 =?utf-8?B?U3ZNOGtrSzZxclJ3SlZuZVZDT1VsNTFFQ0lqMkwrc2hDV3lnUWZ2a3lKUU9s?=
 =?utf-8?B?WndvamF4Qk5kbnNSS0ZUZ3F0R0JBd2x3dmYrelJKOXhRTkI0Z0Fndz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64c9e4e3-09fb-4a31-45ab-08deb582b2e8
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5766.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2026 08:43:28.6679 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: acnnobcrGshN5DeAGUtPqTh/jPTtasck1XyoPVjFrc9uP42/wg7mYmsJc41h1D0wjxbfXz9Cjf3zZbBjXzp7xQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6077
Received-SPF: permerror client-ip=2a01:111:f403:c10c::1;
 envelope-from=Vasant.Hegde@amd.com;
 helo=SA9PR02CU001.outbound.protection.outlook.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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



On 5/11/2026 6:09 PM, Sairaj Kodilkar wrote:
> Currently IVRS feature report values are hardcoded, this is difficult to
> maintain as any updates to extended feature must be synced. Along with
> it current feature report does not have GATS and HATS set. Hence use
> the extended feature registers to build the IVRS feature report.
> > Signed-off-by: Sairaj Kodilkar <sarunkod@amd.com>
> ---
>  hw/i386/acpi-build.c | 38 +++++++++++++++++++++++++++++++-------
>  hw/i386/acpi-build.h |  1 -
>  2 files changed, 31 insertions(+), 8 deletions(-)
> 
> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> index 718e3f546b18..82208e06e155 100644
> --- a/hw/i386/acpi-build.c
> +++ b/hw/i386/acpi-build.c
> @@ -1747,6 +1747,36 @@ ivrs_host_bridges(Object *obj, void *opaque)
>      return 0;
>  }
>  
> +/*
> + * IVHD type 0x10 reports features using Feature Reporting field, which has
> + * different format than extended feature register (EFR) in the IOMMU MMIO
> + * space.
> + *
> + * Convert the EFR format to feature reporting format.
> + */
> +static uint32_t
> +get_amd_ivhd_feature_report(AMDVIState *s)
> +{
> +    uint64_t feature = amdvi_extended_feature_register(s);
> +    uint32_t is_gt = !!(feature & AMDVI_FEATURE_GT);
> +    uint32_t is_ga = !!(feature & AMDVI_FEATURE_GA);
> +    uint64_t glx_sup = (feature & AMDVI_GLX_SUP_MASK) >> AMDVI_GLX_SUP_SHIFT;
> +    uint64_t hats_mode = (feature & AMDVI_HATS_MODE_MASK) >>
> +                         AMDVI_HATS_MODE_SHIFT;
> +    uint64_t gats_mode = (feature & AMDVI_GATS_MODE_MASK) >>
> +                         AMDVI_GATS_MODE_SHIFT;
> +    uint32_t feature_report;
> +
> +    feature_report = s->xtsup << AMD_IVHD_FEATURE_REPORT_XT_SUP_SHIFT |
> +                     is_gt << AMD_IVHD_FEATURE_REPORT_GT_SUP_SHIFT |
> +                     glx_sup << AMD_IVHD_FEATURE_REPORT_GLX_SUP_SHIFT |

Looks like glx is new? Please drop the glx changes as we are not supporting
guest page table yet.


> +                     is_ga << AMD_IVHD_FEATURE_REPORT_GA_SUP_SHIFT |
> +                     hats_mode << AMD_IVHD_FEATURE_REPORT_HATS_SHIFT |
> +                     gats_mode << AMD_IVHD_FEATURE_REPORT_GATS_SHIFT;
> +
> +    return feature_report;
> +}
> +
>  static void
>  build_amd_iommu(GArray *table_data, BIOSLinker *linker, const char *oem_id,
>                  const char *oem_table_id)
> @@ -1829,13 +1859,7 @@ build_amd_iommu(GArray *table_data, BIOSLinker *linker, const char *oem_id,
>      /* IOMMU info */
>      build_append_int_noprefix(table_data, 0, 2);
>      /* IOMMU Feature Reporting */
> -    feature_report = (48UL << 30) | /* HATS   */
> -                     (48UL << 28) | /* GATS   */
> -                     (1UL << 2)   | /* GTSup  */
> -                     (1UL << 6);    /* GASup  */
> -    if (s->xtsup) {
> -        feature_report |= (1UL << 0); /* XTSup */
> -    }
> +    feature_report = get_amd_ivhd_feature_report(s);
>      build_append_int_noprefix(table_data, feature_report, 4);
>  
>      /* IVHD entries as found above */
> diff --git a/hw/i386/acpi-build.h b/hw/i386/acpi-build.h
> index 9fd60a186db1..d81b7890e6e2 100644
> --- a/hw/i386/acpi-build.h
> +++ b/hw/i386/acpi-build.h
> @@ -1,4 +1,3 @@
> -

Unnecessary change.

-Vasant


