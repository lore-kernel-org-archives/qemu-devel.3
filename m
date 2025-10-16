Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C71B7CCD19A
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Oct 2025 12:12:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9Mph-0003Sh-CN; Thu, 16 Oct 2025 08:11:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1v9Mpf-0003MR-FH
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 08:11:47 -0400
Received: from mgamail.intel.com ([192.198.163.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1v9MpW-0007SS-Sa
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 08:11:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1760616699; x=1792152699;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=dmgg+LtdtKQduA3Bbno+aDpryEv2/X+hEJ33kPA+/UA=;
 b=hhYqYxZ+05mDPRxhJDeSvYws9dyNbdkXrUCt7HRUTVsvLpaV3Lof7WKf
 Lq1vHfSAHYYc+0P0yfvSpYWJGJlwD3/VwxRT7lJUAIbUEEXTgSFg2x4cQ
 ENhE7MM2X3jX7ZxeOZRDWapTLzaQdXM2P9WI9syIlBXMzSeYFoDiXK0pP
 MaTrQXav1iRbQKi+5FuvRrxqnox8Z5RLCtIgr6M3vvv2v250/trT/DOia
 ME1FhAZTUMw7ZeuVtcQRfrLVYxJ1iIypXKmxRZiyq+5rYuXAvqDsg+zMi
 +v4YG0F95MCq/YXE6DqjROpBbN0zEH9JxCGAJyIu4hhXkcRn3xh0cqCO+ Q==;
X-CSE-ConnectionGUID: cdOa/EfHTti+lzjz7rTEtg==
X-CSE-MsgGUID: 3FrlGxqvQryfcWp2Ft5BBw==
X-IronPort-AV: E=McAfee;i="6800,10657,11583"; a="62900262"
X-IronPort-AV: E=Sophos;i="6.19,234,1754982000"; d="scan'208";a="62900262"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Oct 2025 05:11:34 -0700
X-CSE-ConnectionGUID: c5OmQKB9S2yZDFiaPdxJMQ==
X-CSE-MsgGUID: ijSnQ028Rmub4F33k8wRrQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,234,1754982000"; d="scan'208";a="182116402"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Oct 2025 05:11:33 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 16 Oct 2025 05:11:32 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Thu, 16 Oct 2025 05:11:32 -0700
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.58) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 16 Oct 2025 05:11:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JKVOmKAJu0m8ki9RvKkLZdHaiQrLxNdga84PBtzgtUfl7keyV3/ldKRV5s/RnwRc48B4/j3oCgSce6eYwRdL192RAAuueHt0pBrdJE3VDxAZFoP/olNbZhWJINxKteZ0lOD7nClz5iA1fXTo92itwSI6c8Vetm1rCyfq0WhGtKf6OfdsBO1m8mZO9hvKwHVvs8CxsCXS5oHG3ntchUhnzOBVE48dB87LzceqwYOQRJc1Eghz4KkaqnRYS1ymlWnumKsyKxBXpza70QsevRxHuVJvR2kGgA0kDfOHETeSohZZ7CxUo10ttxgcvWHT8X981SstiTAsn2IGq+4Jr1ZSEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YFP7uICMm7uxyZInYnxiMAYWLfHpkrXGgkGkku41AmY=;
 b=rj/lGlE9wHp3TiKN614OOjd3LLSsBJ7QLNlxPltUg9bs0CmskYXYpbbWt7AGP8XoUyysJ/XuwC6xLj9LSRaEcAvY5ErcO+NmXq1Y1l7L/ZGw6iWoqT8guNv2g+8tNCLEpJrfTuytV2QYjvTk5AnprPmvGloZS3m3WSJHxktAgWNrMjSxXMDoOQXEYkNbit7SYqIyb8ipp9gQHgrsBLh+Buyy4Qa9onqfljkgLHTX940Vx8XORbEJWgVGVR0Xniq49xcRIuANnWX0s8RwjXSnhsO5j2jPGnOmvMew4Snu/3zSOzsjfL+fbegVzydczWNdXFcg2y2uPVP35ssvFIH+TA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ0PR11MB4798.namprd11.prod.outlook.com (2603:10b6:a03:2d5::12)
 by PH0PR11MB7168.namprd11.prod.outlook.com (2603:10b6:510:1e9::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.11; Thu, 16 Oct
 2025 12:11:25 +0000
Received: from SJ0PR11MB4798.namprd11.prod.outlook.com
 ([fe80::d946:6abf:6e7e:fd1e]) by SJ0PR11MB4798.namprd11.prod.outlook.com
 ([fe80::d946:6abf:6e7e:fd1e%7]) with mapi id 15.20.9228.012; Thu, 16 Oct 2025
 12:11:25 +0000
Message-ID: <72a149b8-079a-4487-ac3b-850daa40f2dc@intel.com>
Date: Thu, 16 Oct 2025 20:18:17 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] intel_iommu: Fix DMA failure when guest switches
 IOMMU domain
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, <qemu-devel@nongnu.org>
CC: <mst@redhat.com>, <jasowang@redhat.com>, <peterx@redhat.com>,
 <clement.mathieu--drif@eviden.com>
References: <20251016074544.377637-1-zhenzhong.duan@intel.com>
 <20251016074544.377637-4-zhenzhong.duan@intel.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <20251016074544.377637-4-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: KU0P306CA0015.MYSP306.PROD.OUTLOOK.COM
 (2603:1096:d10:17::19) To SJ0PR11MB4798.namprd11.prod.outlook.com
 (2603:10b6:a03:2d5::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR11MB4798:EE_|PH0PR11MB7168:EE_
X-MS-Office365-Filtering-Correlation-Id: 52cc8cc1-901b-486a-e16b-08de0cad20f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|42112799006|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aFZzbktEcmI4UHhocHVoOUgyOGU2bDQyODEzLzZBS0NSZVp4eDlwenVoMkl5?=
 =?utf-8?B?dDRQZEN4ZHZjV3h4SXpjRXVnbi9DZTZ5WkdCSGM5UDI5UlhnTGUrS0UvTDgy?=
 =?utf-8?B?cnpYTEo3SDFDNk9QR2hqWmJOUGZJWm5wZ3pLcjlwdWFuaWVzZkwwTVd1c1gr?=
 =?utf-8?B?cVF0b081RGQ0Z0ZEVmJWN0c3aHRiNnRnNTJCWnh5RkFteXF2RTRaVjdRNzI4?=
 =?utf-8?B?L2ZQSC9GcUF1WkVpSVYzNDdtWFljWURXRE5aTWt0UzhFOWtRNG9DSjJ3L0JJ?=
 =?utf-8?B?b0c0bFBPL01jRDVJaGcxT2YrL3dUQVU0MENhdW5ENmhKZFVnbFRYZFU0QmJI?=
 =?utf-8?B?RldLR2czZkMxYmJteHdwVEFyVU9VaU1DS0hDS25HaDBKem5iUDRJbDByZ0s2?=
 =?utf-8?B?bkdZakVLOHdKa2pqLzhJb0ZaZ1E2ZG40cVpOZmVMWE5DMjVwU2xHK3UzZlVj?=
 =?utf-8?B?ZXhXY2I2UFhJRC9RR0UyYWd6RUVINzJ6c2NmaXNRRHBNR08weTZqOHRCVmUr?=
 =?utf-8?B?elpLVHlweStMNEh4WG9FMGk5YkQ1Q1FzRDFFb0FVblVsb2lNTUtYbUlrbnNK?=
 =?utf-8?B?ajlOcUFCdUk5dVZBdnlPcHZVcGxtbS9YR21OTFRmYllrQnBoeGROVVhQQ0NJ?=
 =?utf-8?B?ODQ0bTdyeFhWQ1RyT0tKZVFLMm54VkkrUTlUVHVKb2J5V1ZheS9WM2YwRThC?=
 =?utf-8?B?V3RXZUlldzlEdWNOcHlTTHVPcEhzK0dzcHpYUmEzRkV3a3dnV0JidzZCRHda?=
 =?utf-8?B?UnM3aVJwbGtGVEF3dEVpWllaTURvZlltMGtBUGJXZHRvdnFYSE1pWm1xeVVO?=
 =?utf-8?B?YjM4OHBSVHEyYkwxWU1DRVBITFU1VnNVTGFFRm03cVdyek5JeDc1MlVndUVr?=
 =?utf-8?B?QzNqRVBRc0JPOW5hVUUySG5PVUxyQytveEJlTGdXSXpITHYzZ2o4eHZjUlA5?=
 =?utf-8?B?ZklRZ0JzWURPVnhNZkY5Qjhub3lzRkFpOXprNndMd3VZU2FBeHkzZitOOW9v?=
 =?utf-8?B?U2pQckRHYTIvREIzalNralRIVHoydms4VURBSGhudmJiemI3L2JNSE5peGJ1?=
 =?utf-8?B?dmR4NDlqeUpmcEFHMmZLd0pBMjBoVXRKMEFmaHhrM2FTd2dGeDU2QmkyamNS?=
 =?utf-8?B?eDFPYVJTbEdKV3pLbmdCa0hXWjFqdGhHeTdKcHRBU0dHT0thOFp0TlBRZ1R5?=
 =?utf-8?B?V0c0UVFaOHdkNlQ3c1cyMTM4Qmh6YlViV0R3YUQyRktWaGJrZ2U0dWRyUzN6?=
 =?utf-8?B?UlovTUJGeTJaRUlDV0tZK3gxMTI1UU9lSWFpcllKOHN4YlcyRXJuYlZqMnR5?=
 =?utf-8?B?Yk5iZHpuejc2WUF4bjRZWXZxcHk4aVNWZWRJM0UxVjc3a0g4ajRPY0RlcXJY?=
 =?utf-8?B?YjU5Z3hNU0tvNGJaa3NBMk5aRUlOdjExMUNWUzk4RW1GUDZFZ05tZjkwWFFG?=
 =?utf-8?B?ZXNzeW4rNzNQTHVLNVhVRGdaa01PaElXYlRldjY0dkU3cHM0YWhpSUpoVG5G?=
 =?utf-8?B?em90dXBaV1g0S0ZieElBU1h0V3BkSlNObE1Mazh2cjcwZzEwQ2hqSHo2c3FP?=
 =?utf-8?B?aTF5cjJYRnRGcncvT2VmRU5FUDlIUXExaE9ucjhYVG8xaE5vcTVPcHRTaWQy?=
 =?utf-8?B?S0FWb0NZaXZIOFJ0MjBMVXcrZVJMSWVJQjNvc2tLc0hweWNXZW1zVWI2RGZa?=
 =?utf-8?B?ZGtpdTBXMWxZUEFhd1dqVnBseVdFRzIyejlZd3Rlb1B4OW5VODVQTkRFRnhL?=
 =?utf-8?B?SmxJN3pBTS9vTmRqRzIyb2p6M1ZNVXYrNFpCdENPSFRkY0huaWpLUUJsK0xY?=
 =?utf-8?B?TnMrTXM3a2Z0TE1xeEl4akJIUWFnbk9PSEZqQSszaXpyTnM1MjVrc1ZkeWdj?=
 =?utf-8?B?YXkyNDdHbGQ3amJUK25mVXo3OHh4VWs3NlJrcENyVHNlTXFQVG4rQVhaNUJy?=
 =?utf-8?Q?SjFY7zoz253H/OL2E7GQ2Q8tQQoccFTi?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB4798.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(42112799006)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aGhjajk5SkFpc0YzU3oreUxZZFROb0JVM2JYQlVqNFU3azZkMzk3K09tUmRX?=
 =?utf-8?B?UDVjQ3ZBTnFEM1RiM3V0WlN5M0o4bC9Wd01SL2EycmNEUk5mbzAzazAyanRP?=
 =?utf-8?B?M0c2M0gwZ3JsWDREUVMwejBobmwrTUtCTWRic0h0ajljL3RjdXlYSXZNb1pQ?=
 =?utf-8?B?c2N5WGJFbjVXVVYrcDcvUWpoVHZ5S1p4blJ4ZlJkVVgzb1p2WVpwYVhKdUo5?=
 =?utf-8?B?cVpEeUVVL2VSeGROeE9HNVVieERUbHpscWRwYUhHNXFNRXhmRGxyVStPZDBk?=
 =?utf-8?B?Mmh6QXZDVXlrK2dWSWtFakFYY2dJWTlxQ3B0RjFxY1JFU3dnZmo1TTZjeUZj?=
 =?utf-8?B?akZiMTBvQUMrcFFIOTVtL3lBOENSQmhaMTNuU0ZkazRUMEdyOWVwYi9YaEhM?=
 =?utf-8?B?TUJ0NUI3SmtnWGt6SlMxVUZuVVNNTVlTTmYxOWdKRXlaQjh5M0RudjdkSGJG?=
 =?utf-8?B?WWJoNmZHeTZVVFV3d3NocEYzUzhtYkNXY3Nvbm5ISTcyTlpZZ294UlVlWXUv?=
 =?utf-8?B?ZVROQ3B1d2FVcmJuckRXMVdwK3QrQ0FpandVTWNNSVhQNnZTTXlYbHc5QjNt?=
 =?utf-8?B?VU56N1I2dlFEWmJJNzFHckYzOEVWeFB5UmYvd0dnOWRiMi92aXQyRUMrT2ty?=
 =?utf-8?B?RG54aTdnVHlld2tSd3FTZVcwTWtCTUVpOXR3aDVnUG15Y3NjNWEycGplTlhu?=
 =?utf-8?B?SEE2M2NiRG9jb3E5b2k5NkptajBaQjdweUZZczlnNm84aUoyUFFTeFB3aGl1?=
 =?utf-8?B?OStOdkpOdUNLa1BkTmRXbEpDRVQyamx1d1VNTWwxTnNzcyt5UEcwRTNRTndk?=
 =?utf-8?B?K2lHNzlmeHZ5YlpKcEgxcUgyUVczaFkxVFZ5dWJCY3NMcXBqc0JwS1JTNHBE?=
 =?utf-8?B?TXlIVTA3STE3ZER2aWN2VUFlRmp0Nnp1dTNVaTVSM1VlUEZGOUpIT04vVmxB?=
 =?utf-8?B?VXk3WmFob01uZ3YvYTAwd0p3NmRvdXkxekpsenFaWi94ZjVYdTNkOTBKcHlq?=
 =?utf-8?B?OWNUU0xPMjAyTS9waUJkTXovZkVOamQvalpCUjhGR2g5UjJnS2thc1NPS2xv?=
 =?utf-8?B?bDdZTCtic0RwMG9SOGE0WmVJSlYyb1BrNnprQlpHVXhHNmNTY1NScHE4UFlD?=
 =?utf-8?B?VzR0SitibTVSQjE3RU4vdGRLS2trK3R5cWl1Q1YxdnRKYVkwL0htOXNLcW1w?=
 =?utf-8?B?UUNSTFVma1MzUEJpV0lTdU1LY3UwQm82RlBpMnBFU3Nybmx2dHRUczZvZkVi?=
 =?utf-8?B?ak9KRmVOcGl0QnpkRU0zY2dBWjQ5T2NBditoUGJ1dkVyRWJqZ2xZMHBWSWJB?=
 =?utf-8?B?c3pnb3NlejNiUzF5Q3hPSTNLVzRPK3RPLzV0VGthSERDdGlzUm9tTk5LQWI3?=
 =?utf-8?B?b0c1UHluaWd6aUF2MlZGMEorakxkYUlvOTdETWh2RUo3eDEvcmwzMEhmV3FI?=
 =?utf-8?B?dVhmampMT3dIUzgwQlR5STZJN2NxRFVka3BsWWVhNTFkU24rK3pQR0JKUkM0?=
 =?utf-8?B?U0VIY1crWXR2RjBMK1ZCdlhMcDhzbGVLdWM4MjBpMTdtOFVGdlQvS25Ld0Fp?=
 =?utf-8?B?cHZsRFozcEUvY1J0cEp6ekJlRWgvYkl4eHhZa0dFdWZpRmRxbU14WWdnWk5C?=
 =?utf-8?B?bmNEQ3Naamw2T0IyclltQlFld3RMZkRSeFJ3WHVrSlFocS9tZHcvZ0kwazNV?=
 =?utf-8?B?TERYNWxmUy9xL0JIeCtYdlF2bVMxdklwcGYvL1Z6b3JmV01aaldHRnVjUjAx?=
 =?utf-8?B?OW1wWDlmSFVjVXhqLzF2WlBBb244T3BtOGR4VkcwVTZmY2ovcUZ5cURHSDYx?=
 =?utf-8?B?NnZ2eFRkUi9saHhqczd3dEFLMFpMZGdOOG9XTk9sd1dMTFpqdnkzSzRqZ0dv?=
 =?utf-8?B?d2VkUkdxWG1sU1ZkaVFITWhaN2ZDQ1N2SUdxeFZWUWFKNEhRamZRMkpGYnN0?=
 =?utf-8?B?NVk3R1ltd0tzSmtER2hmdXk0NGhiSUJJUFBzM0w0MEhyK1IxOWlxQjc5eEZT?=
 =?utf-8?B?UDVoN2xuN3YvbStrSVVnSlFrdlFpejk2TGpvVVpCdG00MTRHY2ttWHdGd2tI?=
 =?utf-8?B?QzIyTk9FVkttbWlSWUIrM3pSQjJyNHorRjZkVGx0dk5CY2poSkhLWmFqVzdk?=
 =?utf-8?Q?/DVULNzLkG8gpBVOctJ1/Rcrb?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 52cc8cc1-901b-486a-e16b-08de0cad20f5
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB4798.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2025 12:11:25.6086 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PsL+RaNzxph/px3kfIJ/tc3K79zFwk2z6+1ypC9ag4qo5tEXXAmSK1I4lZDff46LPyb5Ao77VlklvDr7i9jLCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7168
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.15; envelope-from=yi.l.liu@intel.com;
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

On 2025/10/16 15:45, Zhenzhong Duan wrote:
> Kernel allows user to switch IOMMU domain, e.g., switch between DMA
> and identity domain. When this happen in IOMMU scalable mode, a pasid
> cache invalidation request is sent, this request is ignored by vIOMMU
> which leads to device binding to wrong address space, then DMA fails.
> 
> This issue exists in scalable mode with both first stage and second
> stage translations, both emulated and passthrough devices.
> 
> Take network device for example, below sequence trigger issue:
> 
> 1. start a guest with iommu=pt
> 2. echo 0000:01:00.0 > /sys/bus/pci/drivers/virtio-pci/unbind
> 3. echo DMA > /sys/kernel/iommu_groups/6/type
> 4. echo 0000:01:00.0 > /sys/bus/pci/drivers/virtio-pci/bind
> 5. Ping test
> 
> Fix it by switching address space in invalidation handler.
> 
> Fixes: 4a4f219e8a10 ("intel_iommu: add scalable-mode option to make scalable mode work")
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> ---
>   hw/i386/intel_iommu.c | 16 ++++++++++++++++
>   1 file changed, 16 insertions(+)
> 
> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> index 07bc0a749c..aca51cbd8e 100644
> --- a/hw/i386/intel_iommu.c
> +++ b/hw/i386/intel_iommu.c
> @@ -3095,15 +3095,28 @@ static void vtd_pasid_cache_sync_locked(gpointer key, gpointer value,
>       VTDAddressSpace *vtd_as = value;
>       VTDPASIDCacheEntry *pc_entry = &vtd_as->pasid_cache_entry;
>       VTDPASIDEntry pe;
> +    IOMMUNotifier *n;
>       uint16_t did;
>   
>       if (vtd_dev_get_pe_from_pasid(vtd_as, &pe)) {
> +        if (!pc_entry->valid) {
> +            return;
> +        }
>           /*
>            * No valid pasid entry in guest memory. e.g. pasid entry was modified
>            * to be either all-zero or non-present. Either case means existing
>            * pasid cache should be invalidated.
>            */
>           pc_entry->valid = false;
> +
> +        /*
> +         * When a pasid entry isn't valid any more, we should unmap all
> +         * mappings in shadow pages instantly to ensure DMA security.
> +         */
> +        IOMMU_NOTIFIER_FOREACH(n, &vtd_as->iommu) {
> +            vtd_address_space_unmap(vtd_as, n);
> +        }

will the below switch as also unmap DMAs? Say guest switches vfio device
from identity domain to blocking domain. Guest will tear down pasid
entry and flush pasid cache. The below switch will convert as MR from
nodmar MR to iommu MR. It should trigger the vfio_listener to unmap DMA
as well. could you confirm it? :)

> +        vtd_switch_address_space(vtd_as);
>           return;
>       }
>   
> @@ -3131,6 +3144,9 @@ static void vtd_pasid_cache_sync_locked(gpointer key, gpointer value,
>   
>       pc_entry->pasid_entry = pe;
>       pc_entry->valid = true;
> +
> +    vtd_switch_address_space(vtd_as);
> +    vtd_address_space_sync(vtd_as);

In the case of guest modifies fields other than PGTT/FS/SS page table 
pointer of the pasid entry, we shall not sync as for vfio device. You
may compare the cached pasid entry with the one in guest memory to
detect it.

>   }
>   
>   static void vtd_pasid_cache_sync(IntelIOMMUState *s, VTDPASIDCacheInfo *pc_info)\

Regards,
Yi Liu

