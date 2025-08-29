Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AE37CA0FFF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 15:25:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usN7S-0008CS-K1; Sat, 30 Aug 2025 11:03:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1urt4Z-00059H-Pl
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 02:58:56 -0400
Received: from mgamail.intel.com ([198.175.65.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1urt4V-0003Nx-Kb
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 02:58:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1756450732; x=1787986732;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=+hk6J08cAdVxhDCf2f25uUelvSbckgEMoCV0+VdpMHI=;
 b=BKqLBaLQY2qLlBRW5P365pwEjDIvuJVb3dJTqLL/aWd9dBLz8ew78C87
 vGtUkMD7POEEfUQhYYUCftRICbVJrRsASjjlaiX+3+pUaLNgizQB3+SQ+
 +EZkseVfF62dwKAgnt3U0ZedSNM+TwMdzvw/WFfuu1h3+uDqbpJD06WOW
 w4WOrxTe1sSRzKtYwkSIT5Ih5n6nyDDMVqIN+vk7zwut/w9zMy0rZR7dS
 DKlKIEsjJVHqObxaaMC7V/j8s8/YzDlYHOyDcEo7Hx+jvBxm9emYEdCPS
 C3bHxrq5o/QJPNLV4khuxFz2vuagqu53zT7VWzeFldo+O84+SwpLA/Wks A==;
X-CSE-ConnectionGUID: KOHeLx9kQF6v0XiatZ5Wxg==
X-CSE-MsgGUID: EamSxQ+4Tseqhhh2yGaZbQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11536"; a="70172241"
X-IronPort-AV: E=Sophos;i="6.18,221,1751266800"; d="scan'208";a="70172241"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Aug 2025 23:58:47 -0700
X-CSE-ConnectionGUID: 6vLGmGSNR4mHIg3y7KUg7Q==
X-CSE-MsgGUID: NupjAgIjTWKB8LoHNWA3JA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,221,1751266800"; d="scan'208";a="207450251"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Aug 2025 23:58:47 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 28 Aug 2025 23:58:46 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Thu, 28 Aug 2025 23:58:46 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (40.107.94.85) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 28 Aug 2025 23:58:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z2DrrzW4PsPLfxnyP6Kava5A/oMzr2GpKbD+LCOln5TkG/yioLkITj7MnkFd6bYXnJeiU3Si31xjToOfMFn+D1RHlI/OcnxsXQVZnjDxc+ezDBx+IkLNc05GFFghEVmKOA4Q9oA1cqXRxHmp7yk5kQvPkaxkbW8lSuTxxySBE6oUg52uWqAkJ3DfB8v6Al9ZcwySRTi71nLxlGt5xC88N8kytoyBvP+taNN8xYiGboCS/kM+9DGZwuUClD+hnI81j+edgjL3z188OGyIFZ2T+BCSAp3lzmzHqcfWb692G8LZUsiQ66rlaKx6zRK/ugE5stybmpMxx7ZHM+aXO5tflQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uvcaP0bh/yNiuiui+qG1Vzd4/5N/jsyh8wSivUAjI5k=;
 b=EMIih0vf5YBwe4OryYmKfzod9DOjngwgEXKa5l2i5WmhkWBeWnTVzmCjDhOCIv+9fhVcr5Qj5r5e4kRKkUeGNqCQ2qVqJH+38v2FiwyanxnWPq4T/uqTZbk5ZXY/DdZ5Wtp8D+8ilPQr4vLAGrU2QllZpLNAAcvaTUxg8RdCUEg05fmhETh90yoY6XzBXJFp1DR7Qflhkesoz7kYq/pIKJqAMC/ZnpeR4jUtA0pdgiFq7pC9Lh9IQVfSr7GivZYKVbtPm1mbPra9d3Mpv5+u7jLiEOeX9qaNkklyblrvEdW8BIQNU7CIMVb1678f7Gv4s0U7Xf8U1Fxa3jNOt78o2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BY5PR11MB3974.namprd11.prod.outlook.com (2603:10b6:a03:183::29)
 by DS0PR11MB8071.namprd11.prod.outlook.com (2603:10b6:8:12e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.13; Fri, 29 Aug
 2025 06:58:40 +0000
Received: from BY5PR11MB3974.namprd11.prod.outlook.com
 ([fe80::fe0b:26f7:75b4:396]) by BY5PR11MB3974.namprd11.prod.outlook.com
 ([fe80::fe0b:26f7:75b4:396%5]) with mapi id 15.20.9073.010; Fri, 29 Aug 2025
 06:58:40 +0000
Message-ID: <13f23699-7cf2-4ba1-99bd-f5367ac574c3@intel.com>
Date: Fri, 29 Aug 2025 15:05:10 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 15/21] intel_iommu: Bind/unbind guest page table to host
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, <qemu-devel@nongnu.org>
CC: <alex.williamson@redhat.com>, <clg@redhat.com>, <eric.auger@redhat.com>,
 <mst@redhat.com>, <jasowang@redhat.com>, <peterx@redhat.com>,
 <ddutile@redhat.com>, <jgg@nvidia.com>, <nicolinc@nvidia.com>,
 <joao.m.martins@oracle.com>, <clement.mathieu--drif@eviden.com>,
 <kevin.tian@intel.com>, <chao.p.peng@intel.com>, Yi Sun
 <yi.y.sun@linux.intel.com>
References: <20250822064101.123526-1-zhenzhong.duan@intel.com>
 <20250822064101.123526-16-zhenzhong.duan@intel.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <20250822064101.123526-16-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SGXP274CA0003.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::15)
 To BY5PR11MB3974.namprd11.prod.outlook.com
 (2603:10b6:a03:183::29)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR11MB3974:EE_|DS0PR11MB8071:EE_
X-MS-Office365-Filtering-Correlation-Id: b532e48e-de26-4b50-722a-08dde6c97b3b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|7416014|376014|42112799006|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aXY2RDhrVXdSbGplRTZJNzdscDFRNGN6VjNaUFRZM2RYUjBEMEMzT0l3RkVy?=
 =?utf-8?B?UCtzSXJVMHdGbkI1MytKaVJydWhzR3ZPZGZLeE5WWHpnMEZ6anB2MFNCU0hJ?=
 =?utf-8?B?R2NIcTIzRVNZRGxqRUF1QUd4UnBEN0pGOHdiNWE1VG50VkxQSjdSNGg0R0ls?=
 =?utf-8?B?eC9aM21pUnZHaTFYU3BYaXJRdzA2cjFRM0t4SG10QnJvYjFpcHpTb2FjcnFP?=
 =?utf-8?B?UXRXZFpiUjE3L0NEWkxFYjg1MzJpcStXRkhFZlZsWDNEUGNzQ29hdVhNUE1F?=
 =?utf-8?B?YmN6SWxOS1dsZFFrOEE0MldsWEpjWlZ2clFPeXNwZDN4OFFRV2dFSDFRMVNz?=
 =?utf-8?B?V2c0M2xLWG5nT3YyV3E2aWkrcU5XWUJRSmFQczN0TlMvNnhtTDZtR1VNMU9h?=
 =?utf-8?B?TjlxMlBZV0NCaGtzZkp2VW9Kbi83TDFyNXpKTE5LbkxJc04rRE1TbkFIbnNT?=
 =?utf-8?B?c0lnRlNXdFlmYkE4bnhFcmhKUUV3bFRhRGhNbnEyOG1ZZkVyMUVwV0xScFRz?=
 =?utf-8?B?UTI5Q0lpSDliY3M5WTkrb1FBbm1TVnI0RmVKblg4dENwTTVvSEdLbDFhdG5j?=
 =?utf-8?B?YS8vSWFRSTdUcUowS3U3OFpKOWdtMDgraS94dk1BamRtalFWUXF2bjNYMldr?=
 =?utf-8?B?c0I3SDBvcDNrcUZYam5hNldoZlRsUzNsdVpDdUVSVENiZ2JQWUc5eGkvTC8z?=
 =?utf-8?B?a0JSbE1UdWMrbDFtOHM2L0JYMEpqdWgwS2xqTzNod3pLbnBjZVVZMG5XQ0VN?=
 =?utf-8?B?ZGxYN1dDZkdETVkwMnZVMnBHUlZkNExXZlg0bEo3SU1JQlJLV0YwN3hJMW9r?=
 =?utf-8?B?OGhEMUllakduMVI1VGVQdFl3VERMd28xaUcvTHpGS0RQSWs1V2x0R0dBQUp5?=
 =?utf-8?B?MkxtRE0xZ1drVVpqSmdLMXNYL3VGdnlYcW5XUTkxZWw1YVoxRjNkK2xiVllZ?=
 =?utf-8?B?djI3ZHpRV2Z6dmF0QWc1Zk9XeWZMOU4xUVpiK2NNekhEanpTSmlKdFB6NTY5?=
 =?utf-8?B?YXJFang2S3Z3RVVhSlhYTm81a2pFa3k1QS8xUi9LZXVkL09vR3ljYml5SklR?=
 =?utf-8?B?enJIdzQ2SnVSblByd2xRVEJwa0R5b3hFT09VZWtrSmsvaHhNcW45bEdJRHJu?=
 =?utf-8?B?S0lsMUVhaVArTkI4MGhwRDZudys5THF5QzlZaGtvWGJ4c0g4cnF1Ynl5Mk0v?=
 =?utf-8?B?amFvWGcySmlLaElGNDlORU11dWNYK2JQdzZMRG9qZkhNZkpjRjArZlJaU0Qx?=
 =?utf-8?B?MndPaGxhZEh4Z0RjclIxVjJuVHRFMDUrYTdGOHpsbkdjS3hVQWpiRzJCMHJr?=
 =?utf-8?B?bXpTcnJDOTBrOHE4cDFmNnh3SGttM05pQUhDSUk5aXdmbTFIcEljbWs2OGNF?=
 =?utf-8?B?UlZUV3A5VkJyeit2MFgydXZPQi9IYUdwM29pQ3ZSVFg2d1Y5MnFMYTVQTkcr?=
 =?utf-8?B?K3p6TXhBcXZuSGg4dE9EKzJWa2JwdDZ4V3dpbWlWODlRZDBEY0MzamtDSHdz?=
 =?utf-8?B?c1lJV1lpODlFTDlmcWlNVVpldUpSQWJtTmVPZGtlNWFmQTlUejZmK2IwZFpM?=
 =?utf-8?B?N2lRdm90blhvWjJBMlJ3V0tRcVlTWXE2ZUFaTy9VMGloUitVN0JIR3IwTGxS?=
 =?utf-8?B?TjR1MFlQMlV0NGIzQ0dCUkhkOE4rNmk2MVJDQVl1eG1hQmh0Um1HYnZKb0pr?=
 =?utf-8?B?M3gvcjJ1MzFQcERmMjVtM24xcW90OTJVVGQ5a3lqdEdBYjBHM05ybGVUYTZ4?=
 =?utf-8?B?Tzc5K1JEbHRmRXhxTzhEcGRoTk4rSlNDcWlWU3lSZTZ4eFZpQWJaS21oSER2?=
 =?utf-8?B?emFFSFAxanZOOTJRKzJPaDcyOTk1WFc4eFZndngxRXYxRHMyTUlybk4yak9q?=
 =?utf-8?B?M1NWU1BLOTc3cFlrMnl0clNZUUk4N2hpUWhHdUdodDRNSkE9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR11MB3974.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(376014)(42112799006)(1800799024); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OXE2NWVvSEJyTmljVUdyaTUxeHhIS1FGTXovZkdSK09nWVBubTBMS0hLMGk1?=
 =?utf-8?B?V2lwZXFOV2ZqZlpEaG8xK2YwUzZZa3h1SmlxaFhObWtkY2dJUzlldS84Z3FL?=
 =?utf-8?B?NTlpWlowSEViZlJtSGZjcnV6SEhPWUw3VHJoUVpQSkYzTGJDd0NRMXNuS3NF?=
 =?utf-8?B?Z25rdUZOSE9KMUFQRU5YUno1cmNseEk0cG5WbFZNMFh2NldjODZVcERWcW5q?=
 =?utf-8?B?MDhRQjF6cHlESDVSNDFTYzFjMWJPa1FsVjF4ZHpSK0thb1NJS3Zob29pNFIw?=
 =?utf-8?B?UWN5L0E0YUM4Yko4TTBTYmlnaXcxNWp0WmFUeVh5b004VW10UUdqZTBXeXVO?=
 =?utf-8?B?c0l3WWkxNFlkZ2pQL2NwZS9PQUJPOVVpdHRvV1VlRUJWc2VsZlpXa3ZsaWJu?=
 =?utf-8?B?QzBWRTd4eFNrWmZibnhtOUZqbkc1QldxOUpXRnF0N3BMS0JsaUtPMnI3dEVZ?=
 =?utf-8?B?di84ekZzaTZIYStFdzU1Sm45cTZqbitISGtIOWswSllMZDRsdkFIeUt2QXRL?=
 =?utf-8?B?NnYzVm81ZkxQTFJPcmx2OFNKZGJMSDdRR0djRVk5RldlMzZKUXRBcndXSWlH?=
 =?utf-8?B?dkpUVVB1cFRBc2RoZE50aUFiV21lRjA3ZGM5K21iZFhCLzRQMnFuTTg5ZHpS?=
 =?utf-8?B?SWVHcUQrOVZhMElTT0FZcnZ3a3BmTm9HM3ovOUR6T2lBZk9NblNKZEZBZXhP?=
 =?utf-8?B?bytPYjcrQTc0dmgwUGFCRy9mRW1IQ3ViL2l2MGJGVGNBd2tJdEpaTnRrN3o0?=
 =?utf-8?B?M21nNUhRVndxSlNwQkpFUFVJakRHS2JONkIzVDJ1SHFjdER6ZnhnUjlqbW5V?=
 =?utf-8?B?a3QyM0dzUjBBWSt5L1Q5N1JKL2ZTZDIzWnZ2UnUxU2R5d05LK2pRTEMxUWs5?=
 =?utf-8?B?YVB3ZFVqNnMxUlZ6SG5LV1VNN2RxdU5Xb1pXUzhYS0xDWENZTjRXK1JkMFN5?=
 =?utf-8?B?aE1vZDJIZWRKL1JxNG1xOHBmYzZyVXJVSmx5TmZ2ZnMzRk9QRlZmUFcxb3oy?=
 =?utf-8?B?WFRKMWYyeDVvR0Q2d1pnQkU4ZkRicXhRanNSaXlJRlhrUjhZb1ZKWEFKZUlT?=
 =?utf-8?B?VU44d2QyQkdCVzFMU25vcVA5YmxoZHlyV1RJN2NGNDB0YWU0TGF3S3BkaGF6?=
 =?utf-8?B?clNGMUIzU2MwcGt0RUpOSjlLZGtUaUZtNnBjSFhtZVZNMTRnUm1NNDkyVGZE?=
 =?utf-8?B?RHloTnVGa0dyd2ZDU1FOSjZhWnBQSWpwUVpiMk1nQ0JicDdLUVhWQUpIM2sr?=
 =?utf-8?B?U3BEdi9zZTgxdFVvN2todDZrb3pEMFhkNUs1WXlzdWs3bDNuSElIenZSeG5y?=
 =?utf-8?B?M2ZQVFFMUXVSa2JOczM4dXFMeDF1eWg4aEFUUUw2TmVMeHFoSE9lWEJBblNO?=
 =?utf-8?B?aXB2M3p0aTdmNWVLMm1sY3R3dzNacFAvS2s2NGZGNDdWVytHR01BbjloeTh6?=
 =?utf-8?B?QzZ3K0VzZkVoMnE4WnpCMlZJbUI3VHFBSnl5UjRtaTdoTFZjOG8yZVZWNzZk?=
 =?utf-8?B?NHcxa1QrWWdzbG5qbGpvNERTeWphai9ZaktuNlhJenhKWnV5Y200N2FmbHR4?=
 =?utf-8?B?L2pFQllIMzlhVXFESXdqV05QYXBQV0FnSEhjSVlpc1Z6bXVoVmtoajJucnla?=
 =?utf-8?B?VXBUakJmVzJTZUdtSFFGRmVzMENKbnIvMm0raW9mNjVENEpETmY0UmpYRURx?=
 =?utf-8?B?cDRIMU1SMWZFZjFXT0pzdFBiYWZCcHhJczg0S3JRTXl2bjFNblNySTBWTi9Q?=
 =?utf-8?B?bGY0b1ZVQzZhZVBZSEEwNFBhN0pRUTV5bW5pVmJoV2Z3cDJaZUVTcStPOWZE?=
 =?utf-8?B?SllFSFJXdkcxM0ZhQm9Mdkx6K25ZbVYzQWgzbWFvcWgwNGxNdGtYZEV5VW1s?=
 =?utf-8?B?WElCUWJsWVlwQk1ScFRsbmtnMndyOGJNZFJKMXl6THQwVXM0em43T2R1N3NX?=
 =?utf-8?B?c1dGOU8zYmNFR2h1L2R1TGNFR1hGTzFHTGVuanBnckNyTUtvQ3RoVzFuQzBj?=
 =?utf-8?B?eUxtVUl1aFlCOG8vV3o0S05MUTMrdHZhSUpybU9TaG1KZ0c4eGpOOWZ2V3VP?=
 =?utf-8?B?OERESmIxbk5rUXRhS0V6bUJuN1FOMnlSVE90RmpUeDQ5MDlaYUNhWlg5eito?=
 =?utf-8?Q?i/kjPHXjya3RPtlsLZ/5HkL9n?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b532e48e-de26-4b50-722a-08dde6c97b3b
X-MS-Exchange-CrossTenant-AuthSource: BY5PR11MB3974.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2025 06:58:39.9760 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WqAD6OlGfiyqkSxarOUaUEiciDGTWhqijSkUCMa4rmIrJSuqi4AFo3EHdQjlZvspXBmCfKaJDS7biYIFgiYzPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8071
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.12; envelope-from=yi.l.liu@intel.com;
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

On 2025/8/22 14:40, Zhenzhong Duan wrote:
> This captures the guest PASID table entry modifications and
> propagates the changes to host to attach a hwpt with type determined
> per guest IOMMU mode and PGTT configuration.
> 
> When PGTT is Pass-through(100b), the hwpt on host side is a stage-2
> page table(GPA->HPA). When PGTT is First-stage Translation only(001b),
> vIOMMU reuse hwpt(GPA->HPA) provided by VFIO as nested parent to
> construct nested page table.

maybe more straightforward, if PGTT is xxxx, attach PASID to a xxx
hwpt. e.g. PGTT==pt, attach to the default hwpt.

> When guest decides to use legacy mode then vIOMMU switches the MRs of
> the device's AS, hence the IOAS created by VFIO container would be
> switched to using the IOMMU_NOTIFIER_IOTLB_EVENTS since the MR is
> switched to IOMMU MR. So it is able to support shadowing the guest IO
> page table.

this is not quite related to this patch as bind/unbind pasid only happes
when guest is operating in scalable mode. I think you may drop it and
consider to add it in another more related patch.

> Co-Authored-by: Yi Liu <yi.l.liu@intel.com>
> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
> Signed-off-by: Yi Sun <yi.y.sun@linux.intel.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> ---
>   hw/i386/intel_iommu_internal.h |  14 ++-
>   include/hw/i386/intel_iommu.h  |   1 +
>   hw/i386/intel_iommu.c          | 221 ++++++++++++++++++++++++++++++++-
>   hw/i386/trace-events           |   3 +
>   4 files changed, 233 insertions(+), 6 deletions(-)
> 
> diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_internal.h
> index c510b09d1a..61e35dbdc0 100644
> --- a/hw/i386/intel_iommu_internal.h
> +++ b/hw/i386/intel_iommu_internal.h
> @@ -564,6 +564,12 @@ typedef struct VTDRootEntry VTDRootEntry;
>   #define VTD_SM_CONTEXT_ENTRY_RSVD_VAL0(aw)  (0x1e0ULL | ~VTD_HAW_MASK(aw))
>   #define VTD_SM_CONTEXT_ENTRY_RSVD_VAL1      0xffffffffffe00000ULL
>   
> +typedef enum VTDPASIDOp {
> +    VTD_PASID_BIND,
> +    VTD_PASID_UPDATE,
> +    VTD_PASID_UNBIND,
> +} VTDPASIDOp;
> +
>   typedef enum VTDPCInvType {
>       /* VTD spec defined PASID cache invalidation type */
>       VTD_PASID_CACHE_DOMSI = VTD_INV_DESC_PASIDC_G_DSI,
> @@ -612,8 +618,12 @@ typedef struct VTDPASIDCacheInfo {
>   #define VTD_SM_PASID_ENTRY_AW          7ULL /* Adjusted guest-address-width */
>   #define VTD_SM_PASID_ENTRY_DID(x)      extract64((x)->val[1], 0, 16)
>   
> -#define VTD_SM_PASID_ENTRY_FLPM          3ULL
> -#define VTD_SM_PASID_ENTRY_FLPTPTR       (~0xfffULL)
> +#define VTD_SM_PASID_ENTRY_FSPTPTR       (~0xfffULL)
> +#define VTD_SM_PASID_ENTRY_SRE_BIT(x)    extract64((x)->val[2], 0, 1)
> +/* 00: 4-level paging, 01: 5-level paging, 10-11: Reserved */
> +#define VTD_SM_PASID_ENTRY_FSPM(x)       extract64((x)->val[2], 2, 2)
> +#define VTD_SM_PASID_ENTRY_WPE_BIT(x)    extract64((x)->val[2], 4, 1)
> +#define VTD_SM_PASID_ENTRY_EAFE_BIT(x)   extract64((x)->val[2], 7, 1)
>   
>   /* First Level Paging Structure */
>   /* Masks for First Level Paging Entry */
> diff --git a/include/hw/i386/intel_iommu.h b/include/hw/i386/intel_iommu.h
> index 0e3826f6f0..2affab36b2 100644
> --- a/include/hw/i386/intel_iommu.h
> +++ b/include/hw/i386/intel_iommu.h
> @@ -104,6 +104,7 @@ struct VTDAddressSpace {
>       PCIBus *bus;
>       uint8_t devfn;
>       uint32_t pasid;
> +    uint32_t s1_hwpt;
>       AddressSpace as;
>       IOMMUMemoryRegion iommu;
>       MemoryRegion root;          /* The root container of the device */
> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> index 15582977b8..a10ee8eb4f 100644
> --- a/hw/i386/intel_iommu.c
> +++ b/hw/i386/intel_iommu.c
> @@ -20,6 +20,7 @@
>    */
>   
>   #include "qemu/osdep.h"
> +#include CONFIG_DEVICES /* CONFIG_IOMMUFD */
>   #include "qemu/error-report.h"
>   #include "qemu/main-loop.h"
>   #include "qapi/error.h"
> @@ -41,6 +42,9 @@
>   #include "migration/vmstate.h"
>   #include "trace.h"
>   #include "system/iommufd.h"
> +#ifdef CONFIG_IOMMUFD
> +#include <linux/iommufd.h>
> +#endif
>   
>   /* context entry operations */
>   #define VTD_CE_GET_RID2PASID(ce) \
> @@ -50,10 +54,9 @@
>   
>   /* pe operations */
>   #define VTD_PE_GET_TYPE(pe) ((pe)->val[0] & VTD_SM_PASID_ENTRY_PGTT)
> -#define VTD_PE_GET_FL_LEVEL(pe) \
> -    (4 + (((pe)->val[2] >> 2) & VTD_SM_PASID_ENTRY_FLPM))
>   #define VTD_PE_GET_SL_LEVEL(pe) \
>       (2 + (((pe)->val[0] >> 2) & VTD_SM_PASID_ENTRY_AW))
> +#define VTD_PE_GET_FL_LEVEL(pe) (VTD_SM_PASID_ENTRY_FSPM(pe) + 4)
>   
>   /*
>    * PCI bus number (or SID) is not reliable since the device is usaully
> @@ -834,6 +837,31 @@ static inline uint32_t vtd_sm_ce_get_pdt_entry_num(VTDContextEntry *ce)
>       return 1U << (VTD_SM_CONTEXT_ENTRY_PDTS(ce) + 7);
>   }
>   
> +static inline dma_addr_t vtd_pe_get_flpt_base(VTDPASIDEntry *pe)
> +{
> +    return pe->val[2] & VTD_SM_PASID_ENTRY_FSPTPTR;
> +}
> +
> +/*
> + * Stage-1 IOVA address width: 48 bits for 4-level paging(FSPM=00)
> + *                             57 bits for 5-level paging(FSPM=01)
> + */
> +static inline uint32_t vtd_pe_get_fl_aw(VTDPASIDEntry *pe)
> +{
> +    return 48 + VTD_SM_PASID_ENTRY_FSPM(pe) * 9;
> +}
> +
> +static inline bool vtd_pe_pgtt_is_pt(VTDPASIDEntry *pe)
> +{
> +    return (VTD_PE_GET_TYPE(pe) == VTD_SM_PASID_ENTRY_PT);
> +}

I think the existing pt related code can use this helper as well. A
separate patch to add this helper and replace the existing opened code
would be helpful.

> +/* check if pgtt is first stage translation */
> +static inline bool vtd_pe_pgtt_is_flt(VTDPASIDEntry *pe)
> +{
> +    return (VTD_PE_GET_TYPE(pe) == VTD_SM_PASID_ENTRY_FLT);
> +}
> +
>   static inline bool vtd_pdire_present(VTDPASIDDirEntry *pdire)
>   {
>       return pdire->val & 1;
> @@ -1131,7 +1159,7 @@ static dma_addr_t vtd_get_iova_pgtbl_base(IntelIOMMUState *s,
>       if (s->root_scalable) {
>           vtd_ce_get_pasid_entry(s, ce, &pe, pasid);
>           if (s->flts) {
> -            return pe.val[2] & VTD_SM_PASID_ENTRY_FLPTPTR;
> +            return pe.val[2] & VTD_SM_PASID_ENTRY_FSPTPTR;

such renaming better to be separate patch. If it's not too heavy to 
aford, we may consider to consolidate the "fs" and "fl" term to be "fs". :)

>           } else {
>               return pe.val[0] & VTD_SM_PASID_ENTRY_SLPTPTR;
>           }
> @@ -1766,7 +1794,7 @@ static bool vtd_dev_pt_enabled(IntelIOMMUState *s, VTDContextEntry *ce,
>                */
>               return false;
>           }
> -        return (VTD_PE_GET_TYPE(&pe) == VTD_SM_PASID_ENTRY_PT);
> +        return vtd_pe_pgtt_is_pt(&pe);
>       }
>   
>       return (vtd_ce_get_type(ce) == VTD_CONTEXT_TT_PASS_THROUGH);
> @@ -2433,6 +2461,178 @@ static void vtd_context_global_invalidate(IntelIOMMUState *s)
>       vtd_iommu_replay_all(s);
>   }
>   
> +#ifdef CONFIG_IOMMUFD
> +static void vtd_init_s1_hwpt_data(struct iommu_hwpt_vtd_s1 *vtd,
> +                                  VTDPASIDEntry *pe)
> +{
> +    memset(vtd, 0, sizeof(*vtd));
> +
> +    vtd->flags =  (VTD_SM_PASID_ENTRY_SRE_BIT(pe) ? IOMMU_VTD_S1_SRE : 0) |
> +                  (VTD_SM_PASID_ENTRY_WPE_BIT(pe) ? IOMMU_VTD_S1_WPE : 0) |
> +                  (VTD_SM_PASID_ENTRY_EAFE_BIT(pe) ? IOMMU_VTD_S1_EAFE : 0);
> +    vtd->addr_width = vtd_pe_get_fl_aw(pe);
> +    vtd->pgtbl_addr = (uint64_t)vtd_pe_get_flpt_base(pe);
> +}
> +
> +static int vtd_create_s1_hwpt(HostIOMMUDeviceIOMMUFD *idev,
> +                              VTDPASIDEntry *pe, uint32_t *s1_hwpt,
> +                              Error **errp)
> +{
> +    struct iommu_hwpt_vtd_s1 vtd;
> +
> +    vtd_init_s1_hwpt_data(&vtd, pe);
> +
> +    return !iommufd_backend_alloc_hwpt(idev->iommufd, idev->devid,
> +                                       idev->hwpt_id, 0, IOMMU_HWPT_DATA_VTD_S1,
> +                                       sizeof(vtd), &vtd, s1_hwpt, errp);
> +}
> +
> +static void vtd_destroy_s1_hwpt(HostIOMMUDeviceIOMMUFD *idev,
> +                                VTDAddressSpace *vtd_as)
> +{
> +    if (!vtd_as->s1_hwpt) {
> +        return;
> +    }
> +    iommufd_backend_free_id(idev->iommufd, vtd_as->s1_hwpt);
> +    vtd_as->s1_hwpt = 0;
> +}
> +
> +static int vtd_device_attach_iommufd(VTDHostIOMMUDevice *vtd_hiod,
> +                                     VTDAddressSpace *vtd_as, Error **errp)
> +{
> +    HostIOMMUDeviceIOMMUFD *idev = HOST_IOMMU_DEVICE_IOMMUFD(vtd_hiod->hiod);

should it check if idev is valid as vtd_hiod->hiod may be other type
rather than TYPE_HOST_IOMMU_DEVICE_IOMMUFD?

> +    VTDPASIDEntry *pe = &vtd_as->pasid_cache_entry.pasid_entry;
> +    uint32_t hwpt_id;
> +    int ret;
> +
> +    /*
> +     * We can get here only if flts=on, the supported PGTT is FLT and PT.
> +     * Catch invalid PGTT when processing invalidation request to avoid
> +     * attaching to wrong hwpt.

I think it is necessary to check x-flts=on in vtd_process_pasid_desc()
to gurantee the above comment. Existing vIOMMU has reported scalable
mode to guest without x-flts. For that configuration, vIOMMU just skip
the PASID cache flush as that configuration depends on shadowing guest
I/O page table to host. Now, we are deadling with PASID cache
invalidaiton because we need to bind guest I/O page table to host if
guest uses FS translation.

> +     */
> +    if (!vtd_pe_pgtt_is_flt(pe) && !vtd_pe_pgtt_is_pt(pe)) {
> +        error_setg(errp, "Invalid PGTT type");
> +        return -EINVAL;
> +    }
> +
> +    if (vtd_pe_pgtt_is_flt(pe)) {
> +        /* Should fail if the FLPT base is 0 */
> +        if (!vtd_pe_get_flpt_base(pe)) {

aha, I cannot recall why 0 check is special and added here. If we want
to keep this check, I think the flpt_base should also be smaller than
the AW width of the s2_hwpt to maek the check completed. :)

> +            error_setg(errp, "FLPT base is 0");
> +            return -EINVAL;
> +        }
> +
> +        if (vtd_create_s1_hwpt(idev, pe, &hwpt_id, errp)) {
> +            return -EINVAL;
> +        }
> +    } else {
> +        hwpt_id = idev->hwpt_id;
> +    }
> +
> +    ret = !host_iommu_device_iommufd_attach_hwpt(idev, hwpt_id, errp);
> +    trace_vtd_device_attach_hwpt(idev->devid, vtd_as->pasid, hwpt_id, ret);
> +    if (!ret) {

above three lines have two !!. Consider to simplify it.

> +        vtd_destroy_s1_hwpt(idev, vtd_as);

suppose this is the succ branch. why destroy s1_hwpt?

> +        if (vtd_pe_pgtt_is_flt(pe)) {
> +            vtd_as->s1_hwpt = hwpt_id;
> +        }
> +    } else if (vtd_pe_pgtt_is_flt(pe)) {
> +        iommufd_backend_free_id(idev->iommufd, hwpt_id);
> +    }
> +
> +    return ret;
> +}
> +
> +static int vtd_device_detach_iommufd(VTDHostIOMMUDevice *vtd_hiod,
> +                                     VTDAddressSpace *vtd_as, Error **errp)
> +{
> +    HostIOMMUDeviceIOMMUFD *idev = HOST_IOMMU_DEVICE_IOMMUFD(vtd_hiod->hiod);
> +    uint32_t pasid = vtd_as->pasid;
> +    int ret;
> +
> +    if (vtd_hiod->iommu_state->dmar_enabled) {
> +        ret = !host_iommu_device_iommufd_detach_hwpt(idev, errp);
> +        trace_vtd_device_detach_hwpt(idev->devid, pasid, ret);
> +    } else {
> +        ret = !host_iommu_device_iommufd_attach_hwpt(idev, idev->hwpt_id, errp);
> +        trace_vtd_device_reattach_def_hwpt(idev->devid, pasid, idev->hwpt_id,
> +                                           ret);
> +    }

you need a comment to explain why it differs per iommu_state->dmar_enabled.

> +
> +    if (!ret) {
> +        vtd_destroy_s1_hwpt(idev, vtd_as);
> +    }
> +
> +    return ret;
> +}
> +
> +static int vtd_bind_guest_pasid(VTDAddressSpace *vtd_as, VTDPASIDOp op,
> +                                Error **errp)
> +{
> +    IntelIOMMUState *s = vtd_as->iommu_state;
> +    VTDHostIOMMUDevice *vtd_hiod = vtd_find_hiod_iommufd(s, vtd_as);
> +    int ret;
> +
> +    if (!vtd_hiod) {
> +        /* No need to go further, e.g. for emulated device */
> +        return 0;
> +    }
> +
> +    if (vtd_as->pasid != PCI_NO_PASID) {
> +        error_setg(errp, "Non-rid_pasid %d not supported yet", vtd_as->pasid);

I see. This series is really only for rid_pasid. Then some prior patches
may need to be re-orged. Please refer to related comments to prior patches.

> +        return -EINVAL;
> +    }
> +
> +    switch (op) {
> +    case VTD_PASID_UPDATE:
> +    case VTD_PASID_BIND:

I'm doubting if we really want to have two types. BIND might be enough
since UPDATE is to bind device/pasid to a new page table and kernel
supports bind to a new page table wihout unbinding the old one.

> +    {
> +        ret = vtd_device_attach_iommufd(vtd_hiod, vtd_as, errp);
> +        break;
> +    }
> +    case VTD_PASID_UNBIND:
> +    {
> +        ret = vtd_device_detach_iommufd(vtd_hiod, vtd_as, errp);
> +        break;
> +    }
> +    default:
> +        error_setg(errp, "Unknown VTDPASIDOp!!!");
> +        break;
> +    }
> +
> +    return ret;
> +}
> +#else
> +static int vtd_bind_guest_pasid(VTDAddressSpace *vtd_as, VTDPASIDOp op,
> +                                Error **errp)
> +{
> +    return 0;
> +}
> +#endif
> +
> +static int vtd_bind_guest_pasid_report_err(VTDAddressSpace *vtd_as,
> +                                           VTDPASIDOp op)
> +{
> +    Error *local_err = NULL;
> +    int ret;
> +
> +    /*
> +     * vIOMMU calls into kernel to do BIND/UNBIND, the failure reason
> +     * can be kernel, QEMU bug or invalid guest config. None of them
> +     * should be reported to guest in PASID cache invalidation
> +     * processing path. But at least, we can report it to QEMU console.
> +     *

could you elaborate the reason for the above comment? I agree that we
lack of a formal way to report the failure. But supressing the failure
does not seem correct to me.

Regards,
Yi Liu

> +     * TODO: for invalid guest config, DMA translation fault will be
> +     * caught by host and passed to QEMU to inject to guest in future.
> +     */
> +    ret = vtd_bind_guest_pasid(vtd_as, op, &local_err);
> +    if (ret) {
> +        error_report_err(local_err);
> +    }
> +
> +    return ret;
> +}
> +
>   /* Do a context-cache device-selective invalidation.
>    * @func_mask: FM field after shifting
>    */
> @@ -3248,10 +3448,20 @@ static gboolean vtd_flush_pasid_locked(gpointer key, gpointer value,
>        */
>       if (!vtd_pasid_entry_compare(&pe, &pc_entry->pasid_entry)) {
>           pc_entry->pasid_entry = pe;
> +        if (vtd_bind_guest_pasid_report_err(vtd_as, VTD_PASID_UPDATE)) {
> +            /*
> +             * In case update binding fails, tear down existing binding to
> +             * catch invalid pasid entry config during DMA translation.
> +             */
> +            goto remove;
> +        }
>       }
>       return false;
>   
>   remove:
> +    if (vtd_bind_guest_pasid_report_err(vtd_as, VTD_PASID_UNBIND)) {
> +        return false;
> +    }
>       pc_entry->valid = false;
>   
>       /*
> @@ -3336,6 +3546,9 @@ static void vtd_sm_pasid_table_walk_one(IntelIOMMUState *s,
>               if (!pc_entry->valid) {
>                   pc_entry->pasid_entry = pe;
>                   pc_entry->valid = true;
> +                if (vtd_bind_guest_pasid_report_err(vtd_as, VTD_PASID_BIND)) {
> +                    pc_entry->valid = false;
> +                }
>               }
>           }
>           pasid++;
> diff --git a/hw/i386/trace-events b/hw/i386/trace-events
> index c8a936eb46..1c31b9a873 100644
> --- a/hw/i386/trace-events
> +++ b/hw/i386/trace-events
> @@ -73,6 +73,9 @@ vtd_warn_invalid_qi_tail(uint16_t tail) "tail 0x%"PRIx16
>   vtd_warn_ir_vector(uint16_t sid, int index, int vec, int target) "sid 0x%"PRIx16" index %d vec %d (should be: %d)"
>   vtd_warn_ir_trigger(uint16_t sid, int index, int trig, int target) "sid 0x%"PRIx16" index %d trigger %d (should be: %d)"
>   vtd_reset_exit(void) ""
> +vtd_device_attach_hwpt(uint32_t dev_id, uint32_t pasid, uint32_t hwpt_id, int ret) "dev_id %d pasid %d hwpt_id %d, ret: %d"
> +vtd_device_detach_hwpt(uint32_t dev_id, uint32_t pasid, int ret) "dev_id %d pasid %d ret: %d"
> +vtd_device_reattach_def_hwpt(uint32_t dev_id, uint32_t pasid, uint32_t hwpt_id, int ret) "dev_id %d pasid %d hwpt_id %d, ret: %d"
>   
>   # amd_iommu.c
>   amdvi_evntlog_fail(uint64_t addr, uint32_t head) "error: fail to write at addr 0x%"PRIx64" +  offset 0x%"PRIx32

