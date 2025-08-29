Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EB14CA0EFF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 15:26:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usN68-0007Jr-Lt; Sat, 30 Aug 2025 11:02:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1urtY9-0005OX-SP
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 03:29:30 -0400
Received: from mgamail.intel.com ([198.175.65.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1urtY7-0001om-BU
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 03:29:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1756452567; x=1787988567;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=VpfDMTCeUdUDiODKoQc1+VZ+l+GGD5vocak3A4t3CaY=;
 b=WHLdTZ4oBdIRSBIKAxxe92EJ7m69WIdTqBnaqOG6sbCLGMOIK2KWW0wx
 eQFEZVGJ6RsRDf19lASQFU5tkVlWrJMFRzVEtX2rWTa9FsMxeScSSm6bp
 2cmVoUvlS0wk7WgUBRhJapJBmbSXTNwY712Vv5eBS/4pIAdZHvUz9Phpv
 cGfS7DZzHvm8Kz5zgrO/YH8XBNAZ3wOcmuNvG1ef1cz3ZiZv317C0UVkg
 PwXqaH4rHtIYUzhoEilAXpvxGxxzbMLwdmgwY62ZCb+tCmlaHlgqkidCB
 g/i2SAbII67JZhJP9vHAsaLZPIf1tmy2RIljeIslTZZ2yszaLKxoB1Rrx g==;
X-CSE-ConnectionGUID: UA7fwnPDRauHJe556+0lNA==
X-CSE-MsgGUID: 8F2g+0EUTFq6mZejUIVYXw==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="81326807"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; d="scan'208";a="81326807"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Aug 2025 00:29:25 -0700
X-CSE-ConnectionGUID: xETgjgRYS8mNH0+Elbh5yw==
X-CSE-MsgGUID: f+xd6jUjQpiVIjk4Gq9uRQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,221,1751266800"; d="scan'208";a="169575898"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Aug 2025 00:29:25 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 29 Aug 2025 00:29:24 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Fri, 29 Aug 2025 00:29:24 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (40.107.236.67)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 29 Aug 2025 00:29:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xHQcfOch6c8VxvFqbGTdtygbzfeddtzTlwqsxYlzEJ4KsoTng1iTMo0rWnzOdf6clhGV0p1TNgaJeM/hUtT8+N9wJeq1tjrMpxXvn4s4iZPW3i2fQ8Ty7F7WuaSF/Ul/i7ZIkd3kEATa9LIONS69SygeuRXfOkAXY8t/CHZb1So0+mVUmIMsZHuVKy4KzLXUaGd/AZqlH+BwYH8UoN25vCjXNNXIAyjQ+cpejiSI/ITcBUPyjNi2SwBtrYlv8iR1GHnXu0RyH9J7Axmh+o/aC5mp1gDVwnXJh7o2jgaiqflm6scnxEIg+spl7vQTXvb7l29+D+VGkXPrUmVcDWF3Ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aHduJn4jqav25MgtPIzzXj7D2OBvDuRc80+FY+wUhuk=;
 b=fM8jq+94HtS6oiAdK2WRXh4Q26R1N2D96JUsEqA7LfR9Fgep5esZO3XTIDBMAQ3Q7Fu8FMfkuHRABYB9E29TiELz1XKedwirXflElraglhBMM//OZIShtso4jmoQqI6wFSx3xqkgdudgeW8eNEE7GT1ZD230//wHZ99u9aBVhQU+X+cXt46Y2so6FxcgPO2eaNNDONfEsSdGDoj8Qever7BJSHyWGcGyr1/R0wjwShPoT6t7yC7KFhoirIznE061UlGduK0qjYJC/3az5MonFiXKKBeiGiozrPnMVJcOUviOj9qHPTlXvFuMNVV7dWQO2ILaQiKoRfb9eDN1aDi92A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BY5PR11MB3974.namprd11.prod.outlook.com (2603:10b6:a03:183::29)
 by SJ0PR11MB5088.namprd11.prod.outlook.com (2603:10b6:a03:2df::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.18; Fri, 29 Aug
 2025 07:29:18 +0000
Received: from BY5PR11MB3974.namprd11.prod.outlook.com
 ([fe80::fe0b:26f7:75b4:396]) by BY5PR11MB3974.namprd11.prod.outlook.com
 ([fe80::fe0b:26f7:75b4:396%5]) with mapi id 15.20.9073.010; Fri, 29 Aug 2025
 07:29:18 +0000
Message-ID: <eede18d2-e8fb-4bbd-b718-3f11544716ba@intel.com>
Date: Fri, 29 Aug 2025 15:35:48 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 16/21] intel_iommu: Replay pasid bindings after context
 cache invalidation
To: <eric.auger@redhat.com>, Zhenzhong Duan <zhenzhong.duan@intel.com>,
 <qemu-devel@nongnu.org>
CC: <alex.williamson@redhat.com>, <clg@redhat.com>, <mst@redhat.com>,
 <jasowang@redhat.com>, <peterx@redhat.com>, <ddutile@redhat.com>,
 <jgg@nvidia.com>, <nicolinc@nvidia.com>, <joao.m.martins@oracle.com>,
 <clement.mathieu--drif@eviden.com>, <kevin.tian@intel.com>,
 <chao.p.peng@intel.com>, Yi Sun <yi.y.sun@linux.intel.com>
References: <20250822064101.123526-1-zhenzhong.duan@intel.com>
 <20250822064101.123526-17-zhenzhong.duan@intel.com>
 <ed8f5d83-0bcf-4685-a362-cbb948b01baa@redhat.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <ed8f5d83-0bcf-4685-a362-cbb948b01baa@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0035.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::8) To BY5PR11MB3974.namprd11.prod.outlook.com
 (2603:10b6:a03:183::29)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR11MB3974:EE_|SJ0PR11MB5088:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c6e4667-7584-4fef-9141-08dde6cdc38c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|42112799006|1800799024|366016|376014|7416014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UUxiMnJPcWZ0VGNIdVJONFpobHQyZThFanI4cVloM1V0SWZtL0o5cFdQRnhw?=
 =?utf-8?B?d3M5UnU5dVF1S0Z4N2xRNTJuRTN0WVp3b0NTaVgvSVFtWG9Ec3ZGdExvYXFw?=
 =?utf-8?B?K1o4ZWRxbFFWN3JzYTNHY0NXeWJabEF2d3BLbHgzVHd2cm9GQzZQUCsxZFpo?=
 =?utf-8?B?T05Ed1VSblFmV0FOcWIzS3dIQmcvRXBwUVVGRmZXbmdnL2dHSUZJazV5d01P?=
 =?utf-8?B?a21mVE1rd1piTFRkZXhDTG05elhSVitjRGJJWTNUU0xIeW5hUy9rOFRzM0ND?=
 =?utf-8?B?aVhDNVFXWWZMZmVBTy85K2k2aGpkMzQ5aXpHVUdnZlYxditLR3NTa2JoTHlG?=
 =?utf-8?B?RlY5RWw4cEI5ZFovM0tmeEZqcWRqb1BvSWdHS3lKcWtXVjJVNThwUVh3UlNi?=
 =?utf-8?B?THpJSmNqOGJ2S3ZoS3o5ZnU0K1Jic3p1U1ZGV3FSWWo1MUc1bDhEdllwRy9m?=
 =?utf-8?B?WFhUNUJRRkFFVmFnejlnRS9XSC90elBOeG1wZTJpUEhNd2djQjVocEpRSVpi?=
 =?utf-8?B?QUM5WDZjZXU2VlY5cHdmOGpQTFZ3Qk5kMlVrSTBXODNUVERXR2c4K2Yxdk55?=
 =?utf-8?B?amVaK2pzbXYzQ0ZIVTE0WmhaYXp6a2FXMXl4bFhXYjBYMW1zbEpwelJuZklx?=
 =?utf-8?B?Tm84TnU2MlUreDhjL0FvUHplb3FpUXFyajVrUGJ6Y1A2WWVxOFhndkc1Q2o5?=
 =?utf-8?B?bS9VeEE1ZHVWVk0xbWdRMGtBeklXWUtoMksyQk5vSEpXZFN0VmdqYXJxMzFR?=
 =?utf-8?B?ZUtoUlRZNnEzYm5VeTJEYWFjYll4OUpkWGg5N0E4M2NqYnJHblhhd2VlajY4?=
 =?utf-8?B?emxlWnZsWlo0czFIRXFDaXBTM1dzc2I1M0VqdWd4dEZCTkk1bU9uMVVsRHls?=
 =?utf-8?B?OGtuS1R2ZXYvd0FQbTBvaE8wcHlMbzE5d0todWE3QVV5dHNtdXVrVzhEcVlq?=
 =?utf-8?B?TjY5VFV6OWtXUlE3OGdZcEpiOWdaa2M0VjlScjVqSlVhSVp2ZGJ3cnh4N0h4?=
 =?utf-8?B?bWhlSVpBN0ZWRFRZNmg0aGxKazZJMkZtTkhwM09SV2tUMjBRN2ZFQnVoMUpw?=
 =?utf-8?B?TnZISlphenV5azUwd3U3V2ZRV1drM1gyZTBERi9sNmdlTktWc25La3JWSGxr?=
 =?utf-8?B?NWRXUnVmaC9WOW0xVzM4RGJuc0ZuaXRRN29vdUFpQ2lwMnJSTk5MMUZNOElF?=
 =?utf-8?B?NVAyNi84SFdXT252M3FWOWhyZ2lES0srbldEL09BamV6c3N2WXQ5a2gxWHBp?=
 =?utf-8?B?OGFiK2g4aGx1RElFMkVxTDRtRFp4RzZPbDl4ZGovaWpUakdhT1E0Um1Cbzc0?=
 =?utf-8?B?ZGhGWDM1ckZlVDBBMCtWdHdBMzZJQml1RE51aDV4em5wdjBIOXNxVUVWclE1?=
 =?utf-8?B?NDlDM0tYemNwbDBxeGk0UG9adEplUWh2UHpRVjV5NWZJeDU4M3ZZc3dNZHM1?=
 =?utf-8?B?N3VsNUtwM05UV01UQXR2YlRrZzhlTVBTcmx6RXo1bGI0eWgvaHNDbVlSUzQz?=
 =?utf-8?B?MUx6TUd4WllOcnY4dDg4RFlyNm1GUzB1eU9xWFRtUEdxVWg1QUFNVVp4dWpp?=
 =?utf-8?B?WkhUdUtvVE9NWldDVTgvcUdmZDIxbVppTGF6R1pCZ1FCbWwwVGhoTGJ6K3JJ?=
 =?utf-8?B?M25TNTFLMGZJb1BlMWxLM0RVU2F6bzJGN0NiR3prMkF1eVpzbnJsdnhFZnRC?=
 =?utf-8?B?L1hhd0NvNmo3KzhRTjNhVVREMkEvczhJUi9SNHNGSDlRNWpGbjA2bElxdzlN?=
 =?utf-8?B?bDJNOVZnRzVZY2RQamg3Y3FuaGRsTE5vTHFpVkkxR3FTTlU5RWlkbGxuRnNF?=
 =?utf-8?B?c2FwekJHQWtTMmRxSEdRMkVjLzVDeUZDUjNsblRtWXhHb2RRYXA0bEtRc2R5?=
 =?utf-8?B?M1EvZDhRZGtEZUg3OXFrcTFkaFdqRkd0aWZKUExpZTcwcjhxd3lNWnFIMTNR?=
 =?utf-8?Q?9t8zQdLtFDo=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR11MB3974.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(42112799006)(1800799024)(366016)(376014)(7416014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NzNnK3NrRThBemtkamhkdUgrSDBkYnBIWXNKZ09WVTZscTVyemhqRW5DbER6?=
 =?utf-8?B?c0dueTN2UTF5dkFua3RRY1NnUHlqc1IvVzhyaTZ1VGt1bXNiRi81L29EVzdN?=
 =?utf-8?B?djJiWUI2NXpwbzA3MWVJTzAxRE1FbS9qV2cxaCtXVnFuRzF6RXE0UUIwbGxY?=
 =?utf-8?B?RjhwazBkN2ZWVE8wR2c0ZXRtTzBHWVpyQmV1aUVqMzFzalhWdjFQNHpqSVN1?=
 =?utf-8?B?WWovNXNWRHBWWlU4ZGtOM2lUSDNJODVpeDZsL04wNFM4T3RwczBLSmZ1QzRh?=
 =?utf-8?B?YU12bi9OQlh5Uk80ZHZJYVpkMkVqZjJZRWhYMGl4dDdJbEZsRzhmN0tNc0dG?=
 =?utf-8?B?Y3FLSjlRNktGbFBxNXFON3dHLzRmUjVOU2Y1cG13TldDOEt3a1drWWp0ZkRE?=
 =?utf-8?B?bVovMHAzZlBnc21VSytiTjVacnFJaG9PcEd2N1JVWE5vRmk3Z291V0VjTEF2?=
 =?utf-8?B?c09NbnZKekNjcXU3MUprcXVxZ3Y3cCs2cEE4NFc3UzVmNEVwRmpsTHBLUERy?=
 =?utf-8?B?aEFrMythQ2pCTE5RZkxMRDZtVXNuL0g0c1JZaHlsRUhlWFkwdWYyY2ZSZENT?=
 =?utf-8?B?UGtkMnpDR2ZQaHZhazF5VFBJUUsycTUvOXQrT3poRDFtb0tBNThLaEExcktu?=
 =?utf-8?B?bVQ0QXdLL0FzT3JnSnBUKzFhanRvTW1IQklrUkxSNGRYajU3clcvVzJ4b2RO?=
 =?utf-8?B?dzZZVm03SG8xdzhMbTlOL0s1SDJzT0NkNGlGejJKNk5TUUFTaFdYSVVLMWx2?=
 =?utf-8?B?U2d1VjcvK2I2NFlYN3lRMkhsNThWSENqZG1yYVZBcXlwWmRxTE42YlNVQXlj?=
 =?utf-8?B?UlRDc1cyZDVDRitSdVZTdm9hUDZJV1lJNmhUVG1hZVZEMWNLcncvYUdpcDVO?=
 =?utf-8?B?NWd2Zm1BQ3JaNmljSXZGSDl1eCtQcmJaeThFMiszMGJFNldJN0hXUTR1SDVK?=
 =?utf-8?B?UC94TTA0b2hjMDlrcmxZZU5nQ0ZQSXhuY05zWW00NThsSzVyVjU4UWJlZFov?=
 =?utf-8?B?UEw3V1MrYWxRVHZjL0M3Y2xtR2dvYXQrb1RtMjByWHd3WGkvL2lKK0ZpTXcw?=
 =?utf-8?B?VzRwUVVNVnQxZWZkeUFOUzlQV2Vsb3EwZCs5bDJ1ZnpKZWszZzlnRktBelAy?=
 =?utf-8?B?a3VkL3AzRmY1VXJ2Zm9maGxSaGJhSSthT1FlK0grQUNpcWFaV2dhVUVqS3Zs?=
 =?utf-8?B?RWQreXM1NE9rYjRIbEN4ditUTDZheVovTHM2STlsRW9ISzFhTTZ6SmhQLzVz?=
 =?utf-8?B?Um5WTm9hUEF3cXB4VmtwL1NTQldLYXlFcmFBZTJrV2V3aDFQV1k4NXhmUUpr?=
 =?utf-8?B?SVVHVnA5RDFWemhHai94dlJacFFWbGxoZC9RZWhrL0h1Y2NTTVMzenM4U3B1?=
 =?utf-8?B?clRIWHJhZS9ibE10VFZEVFlPOUJjK24xWjJvN1pHWmFqMC9taFlURDZ5QWpI?=
 =?utf-8?B?MzhhejN2U29iN09RVnk2cWRMUFZyT1dwam5lZCsvb21RZmVGd1hjeGF5dHdB?=
 =?utf-8?B?cTdmVkxrQjJHdnpjZ2owWGl6cEpmU0wxMkJPR3BUc0E2Z2g0b2s5M1V2eUZN?=
 =?utf-8?B?RXdxb0lUdlZ0L2VRS3BxakV1bndtMTdxZGkrYnFjcmxkV05qRHFINFl3SDM1?=
 =?utf-8?B?bXVSK2FpMWcrbHVMS2x3bzBWTjNEZDhPeElYSVRZYlR4SytYWHRVaVQxU1F4?=
 =?utf-8?B?QUNJTVhNOGI1c2Z5MXY0UHIyNUxRVUJ6N1ZCSXJobVZqRU1VanN2Vzl6SXhZ?=
 =?utf-8?B?cC9RTDZkWTdxRXhURGxML0s4UW5iVGNxZXhyNVNWRDVFRWJZWnErYWxqNlg5?=
 =?utf-8?B?bVFGWUJ0TlFwZVV0a2c5YVZ2TDZzV2Q5NWFTSktibDFhcGZaa3prUWtWTHU5?=
 =?utf-8?B?VVd5N0NibU1OOU51NC9RenFUVHRzVFk0VU1oUzFZZUxFMHR4ZjhIK3B3V3Np?=
 =?utf-8?B?dUpJbTZSYU5xaDZldTF0UWpETGFvNXZ5Nk9rdjNpTldLYk10M3ZxTVFwMmNZ?=
 =?utf-8?B?Z0xKVGlaWk9IT2pmcWNvOWlReHU4NFlWWTFKd1F1cDRTYUNldGhkNTNYTUE5?=
 =?utf-8?B?QlNzMGtVeTlZNkJIZG9jZ3dxcWEvTDRFSXVyaldaSDJDcFhSRklMbE5pZ3VP?=
 =?utf-8?Q?mq/3pAPtu2hdOoyugiVRzsV2Y?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c6e4667-7584-4fef-9141-08dde6cdc38c
X-MS-Exchange-CrossTenant-AuthSource: BY5PR11MB3974.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2025 07:29:18.4550 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5Q5adQZFbIKiH0xOz4qwW4rROXJMCKsoubcv/+/v8d4rKbWTtYaMdDruKWnFpTBwQlaGC+Yze3NUiKJyD6eqaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5088
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.9; envelope-from=yi.l.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 2025/8/28 17:43, Eric Auger wrote:
> 
> 
> On 8/22/25 8:40 AM, Zhenzhong Duan wrote:
>> From: Yi Liu <yi.l.liu@intel.com>
>>
>> This replays guest pasid bindings after context cache invalidation.
>> This is a behavior to ensure safety. Actually, programmer should issue
>> pasid cache invalidation with proper granularity after issuing a context
>> cache invalidation.
> So is this mandated? If the spec mandates specific invalidations and the
> guest does not comply with the expected invalidation sequence shall we
> do that behind the curtain?

I think this is following the below decision. We can discuss if it's
really needed to replay the pasid bind.

d4d607e40d (Peter Xu                     2017-04-07 18:59:15 +0800 2321) 
     /*
dd4d607e40d (Peter Xu                     2017-04-07 18:59:15 +0800 
2322)      * From VT-d spec 6.5.2.1, a global context entry invalidation
dd4d607e40d (Peter Xu                     2017-04-07 18:59:15 +0800 
2323)      * should be followed by a IOTLB global invalidation, so we should
dd4d607e40d (Peter Xu                     2017-04-07 18:59:15 +0800 
2324)      * be safe even without this. Hoewever, let's replay the region as
dd4d607e40d (Peter Xu                     2017-04-07 18:59:15 +0800 
2325)      * well to be safer, and go back here when we need finer tunes for
dd4d607e40d (Peter Xu                     2017-04-07 18:59:15 +0800 
2326)      * VT-d emulation codes.
dd4d607e40d (Peter Xu                     2017-04-07 18:59:15 +0800 
2327)      */
dd4d607e40d (Peter Xu                     2017-04-07 18:59:15 +0800 
2328)     vtd_iommu_replay_all(s);

Regards,
Yi Liu

