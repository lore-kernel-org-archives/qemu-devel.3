Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCAD1C52D7B
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2024 07:03:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sdlYv-0001qz-U2; Tue, 13 Aug 2024 03:03:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1sdlYq-0001pe-87
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 03:03:16 -0400
Received: from mgamail.intel.com ([198.175.65.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1sdlYm-00022m-11
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 03:03:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1723532592; x=1755068592;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=o6CTl0rG1xuYgcJh4kCjkcd5MKAltRgLw2YI7EpozZQ=;
 b=LSucrfgV7NbnzAftW7L/7HrVff3wsDbfHRXpxMQEmKEUDLscAkqr3DiM
 DndwbRrD/bX8grWMNeivEbOYeBjIBE5xsvKMdipOCzcVA84znQZBz30RF
 yzDwzSbvey6E3jPpvnxn7KtNhNCpEzF2mNmBnBGMNFxEJgabIa80FOa26
 a/Jb4OUDXuRsmSpkyAwYBvxSvEZG3JqsyUVgL4GnD1uTgefS+7RAzkw0w
 q4kgIhVb5x5thImqgmq/h+wl69WobVnuLKlIbrzaWav6DGZFlDvqcNsu4
 kBcjrDj7jYFr2ipPIqm9I0YSXvd82ixGjUsLrddnrLLjTsOFnjVTvz0D/ Q==;
X-CSE-ConnectionGUID: 1WT4YKHATCKJYl1BzbYLew==
X-CSE-MsgGUID: CFzA+V9lRiCIqXIbzsFCZQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11162"; a="33059991"
X-IronPort-AV: E=Sophos;i="6.09,285,1716274800"; d="scan'208";a="33059991"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Aug 2024 00:02:36 -0700
X-CSE-ConnectionGUID: wmpmnaHJTayqGolgpCyfEQ==
X-CSE-MsgGUID: cfSolzMbQVurA9dTevou9A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,285,1716274800"; d="scan'208";a="58437145"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
 by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 13 Aug 2024 00:02:36 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 13 Aug 2024 00:02:35 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 13 Aug 2024 00:02:35 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 13 Aug 2024 00:02:35 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 13 Aug 2024 00:02:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T8UklRU2MO4nj4CY1WztEiPmARseX0IQUrEkRdFEAs3ewza8xLVzNuojQj2jZpFHOQO1UeBYKKflY7Kvb1dWY2pwY9xeEsvfQLH60KLGYO3gvNNI7FeOd/6jMJzX7LLnIcqQOJOpQ9eCQaWkZ57pAirqexrgXp7lVgJhcL+ULx9aRsD2TWljFu2d12eUVIm2+Ab9xWIDJdZs1sZs7qIsHyC57Wjru6yBByba99njHQLVcoG64q1HWwF2tUkgA3vna1mwYvAjDfofIGe7v50rbCDGLEd7w2oSbj9XVv+wp/AAjUl336PfuOkqPPMh2G1Rf9FT4oLtB49XRLNrK1Pmnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/MRdkHl//owJliiQBoOmJF5FV92ED8qb/9+VrngZn10=;
 b=I3CuywliL85fdHDyLmNIimSPHTlck+Px5tdTJE0FbwG30IJdUoPR95e1aitMluxjoPj7BSaBdHyaaK52Dsw7tCn2ML67t9yPxEC2ufeOhBDQojo0lMfskXKKV+s2C6Pqw8rQ0tZQFbyLE7e2m2lgUV87ricWPbQOl0XnM00qS8BtSLh1B+gldmFGeYOFlYgKSFxLhl7XAz+jHL2WVxqqjPuJ6/XphmgPsD9KAtSOyVuo5Pc2w5rRepVsQZ0264f6c412u608+oHIe1hVdHS9ylNwqkxfK3v1XkIl+lx0+gjoLGSv/Klcb4Eoaed3VpdeEJERmVGOuCAemMpQNnUqng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by IA1PR11MB6515.namprd11.prod.outlook.com (2603:10b6:208:3a1::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.33; Tue, 13 Aug
 2024 07:02:32 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a%3]) with mapi id 15.20.7828.030; Tue, 13 Aug 2024
 07:02:32 +0000
Message-ID: <9404c6b8-67ea-46bc-a702-85b3992a56f8@intel.com>
Date: Tue, 13 Aug 2024 15:06:46 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] intel_iommu: Fix invalidation descriptor type field
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, <qemu-devel@nongnu.org>
CC: <chao.p.peng@intel.com>, =?UTF-8?Q?Cl=C3=A9ment_Mathieu--Drif?=
 <clement.mathieu--drif@eviden.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, Eduardo Habkost
 <eduardo@habkost.net>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
References: <20240813055354.2562736-1-zhenzhong.duan@intel.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <20240813055354.2562736-1-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR01CA0180.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::36) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|IA1PR11MB6515:EE_
X-MS-Office365-Filtering-Correlation-Id: 48ca5046-e124-4a98-f98e-08dcbb65e701
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dDJjNzUzSEIraTRJdXNkRnpzWkJSS1h4dWZlSWhYWlJhYVJrUXVZYi9VVjEy?=
 =?utf-8?B?MUNIa0xZaWcrQzJmL3RGUzhpVDQrOU1rdW00cWtPT05QY1hWcUcreUlrRkMr?=
 =?utf-8?B?Y3lFRDRsZHRRT2RLQUI0cURPMU1xak83QTlKRnNHODhOWEhiZExqckhsWEtt?=
 =?utf-8?B?dUZoaTJrVDFpcFJiSk5FMkFsRStVUWZlaXRyWDdLSmx1YnIzSWlRU1k1VDVw?=
 =?utf-8?B?ZHRZUUc5QWdxcFFiRDlyZ1JHMTEyaGc1d0dHMUxsSHpvRlZPRDN2SG1vUGwx?=
 =?utf-8?B?eXFqOWRmUWFDalJ0czZGR2JBOHZnb1RXWnhIV2p4UjFJY0hqUXFBeGwrei9u?=
 =?utf-8?B?OUxVQmxJWE9ObkUzT2hnNFJuRkJVenlLS25uQ05qMGpybXZaRTBuQmZLS0JS?=
 =?utf-8?B?bHNUdDVQV25zOGxZTWFFbEgrVE5Cc0hOOXdrbFEraTdRVzFuKy8zcThhR2xZ?=
 =?utf-8?B?NVhJNkJ0TVZUU01RMzhQSEdRcTdUNjhnNklEenMrQmtzckExMVBueTJwSUgx?=
 =?utf-8?B?WENVVnM1TERWbnpTNG5wMm5mZnpXb25HU1QxM1ZuZ0prUDI2UHZQdXdkWTJF?=
 =?utf-8?B?ZXBQUVA2azFyYnQrbXZmV2lYTnBvZHlxdWM3Syt6aDZKSitMcDZ4QUErNGRI?=
 =?utf-8?B?dmtSRzFqdzBGR1A3anp2R0p3UmlsaHdUa05kejEwMk9lT3FtbVFNdzdJbnl3?=
 =?utf-8?B?ckFobWJ4TXcyVWRJUWYrOXJ1SE4rWitTcG5VcFdXSllVY1BGRFBPTnkwdjMw?=
 =?utf-8?B?eEdpNjVuNHZZSmtUNFZ6Zmg1OXpaTVMvbnNQRHpyMjNhcndkNlUvcm1KcEJ0?=
 =?utf-8?B?QzN6Y3lMeVoxTkViWUJ5UkV4aHR0TWFDdUZWUWV3L0NPR1Z4YVptM0JMWmlU?=
 =?utf-8?B?SWd0aXQ5NExGenVnYzlpWndsVTJqUnphNkEveVFpVXUzUlRmeEtaVFlUWkts?=
 =?utf-8?B?cVpmejArbVZTUVgwRUdVd2YyZXhNclhVZkhnNE5KQ3hiVUNRYUpQUUFBSFFP?=
 =?utf-8?B?MGd5bkpZVE5VUzJWcnNMeXVkZzUzeHJlNGRodHpiVWNXM2tjQ1RvZnc3NFpq?=
 =?utf-8?B?Nys1WmpyNFY4MUZmZUxzZmJidCt2eGUwNW5XZU1XdWFLdGF6cHZhNXB1dGJL?=
 =?utf-8?B?ckcrcU04UnFDaE1oSlhDZE4wZ1ZaRTBqSGhLeHdhaWlDYWoyWGI1ck9ETjRw?=
 =?utf-8?B?QjZPQkZ6VzdtT0ZiTVlOdm1FdHZ6UHRaNEh3Um14SWhsd20yZElNVVRaOTRH?=
 =?utf-8?B?K24yZHNFVWNQc3RFUVcvdGdudjB4WkJsdFN4c01TaE11d1VWV3pjZmUwTXdX?=
 =?utf-8?B?cHFkQzBpdGZWL2RwRGhNLzBMNDcvenliWlJ5YUVSQmd5ZVhpeWNJS252Y3Nu?=
 =?utf-8?B?TCtWOUlGdThsL3RhZ1I5a0t0VUJTVmwrYzB0cVdMaUJmejY5UlBWRHNRS0Mw?=
 =?utf-8?B?cXNvOGNPbjQ0S25VeWJVYTVCanVQUHpmbjBOdnVKZ1UwQXV1N1ZQMWQybzFo?=
 =?utf-8?B?b3NBSDZJWXNsUGo0QzB1dWg5T29JMExyekFjVTJEVTUvOTU5TVFyWlcvc3c5?=
 =?utf-8?B?V3dMSGZjTUNyazBudGdRMlZKV0ZlNDFxM290U2dZSWZqZjc2TTZWZkVjMnBk?=
 =?utf-8?B?TXZPcW0xVjRSRWVucFc5MjhoaEM5QkZodEhRd3ZoTEVGd0pRdXNsRUFZMndZ?=
 =?utf-8?B?U056NVlkSHlRN0VhY2FsMjAyaUZmRzVvNGRuc24xdnk5VW1MOGpUdTlhaC8v?=
 =?utf-8?B?TWRDZHl2SkVDTyt6SmF5cWpsc0hwWEJCUEh0NVB2N1BLMmwrZXZZWnBFQlU3?=
 =?utf-8?B?S2pHcWlJSlgyRTdFQWhWUT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7529.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MDh3Vll2R2VuUno0Q2RrRDhKSThqZ0RFMUF1MXZsS3FmUkVqTDY5SHNnbjM4?=
 =?utf-8?B?ZlVIODl1S0ovaGNzY29rK1JDd01PQk1HNHJEUElUZlRQNzYzMjdhZVF5OUZP?=
 =?utf-8?B?ZnM5dWhVVUtwczRvbVYvMzJWb0c3Wk9BTzhYcFhPT2VCdmxLWGdWN20zdmdC?=
 =?utf-8?B?ZlREeHV0cWtFRU9CRW1zYk1qL0I2ZTcxS0pZZ1g5eWJSK3Q5K09FVGlwOXgy?=
 =?utf-8?B?VXpCT0VSSnlPMzQ4V09KMUFkbkRnOFAyS1MybTVIMG4xQmhWdEZYbFJtZ3Vx?=
 =?utf-8?B?VXVrSE9yaFc5MEg4NjhCV05KL1duV2RxbzZxWWpSdzBPZEJhTUdZYWZZbjRK?=
 =?utf-8?B?aUMzMU5HaGgyNXJrYlY1SHRJcUxua1ZQRDRvSE5WWDREOVRiaEREOTBEMDNB?=
 =?utf-8?B?WFRoZGtpdzZkRXVZcnNhclpmTjQrazZqSkY0ZEw3T1FDSmNhNlVVSXNoYWdC?=
 =?utf-8?B?b05QditmUFdqcFVBcVFIZC9sd1djemIwRnQ4b0tpcjFvT0JjYXlzNzBGaXp5?=
 =?utf-8?B?MTJkUlFxNmRsZ2NSWUJlUDkrZlRKSHAzZzBtaTAzRyt3VVlSbVM2ck95VUdF?=
 =?utf-8?B?dVpua0xaSUs4K3M0R0U1RW0rV3M0UHhkbUFvMVIvREV1M1RjSnRFbGJxYXJz?=
 =?utf-8?B?V0tvSVFBcEo3MzREb2NOazBEWkdXdEMyK0FpS01VMWVCdXM0cWE0VkxTeHcx?=
 =?utf-8?B?amN1c3QxRmlWdUVWWGdSWTBGdGdZcmV4S29iVTZaM0hTNWFaTEZZSVk2dlVJ?=
 =?utf-8?B?UUpUdWlLV2JCQWRJelRjVWVteWRMV2k2TlBHVnhhb1BrY1JzZG5HaFQ5K29p?=
 =?utf-8?B?c3Njc0oxeUxtaENvalREcnpta1kyV240M3BiUjFoMjJmZ05rc21ZTkRRenJF?=
 =?utf-8?B?TTB4RjlvMEJ2bER3andVZ1hseEFyZnB5MXNIb01hUmhDakErYkZHZFg0WC9I?=
 =?utf-8?B?Q2ZVbGVFMUlHeDBlbDgrbVJxdlU0TEZncE1udXlnQmhycWxFdkg3d04zRFRO?=
 =?utf-8?B?cmt1VGE5U0pDWkhuRzNzeXhHWGpnaFBueEZ6Ny90UWMxbDNFZWFEaENqN0VH?=
 =?utf-8?B?Wk5DRVdxTDlIS1FFNjgva3NvOEFwMlNFVjFNS3p1MkNtcnBnbW1QR0JsYjd0?=
 =?utf-8?B?WUxYRlBvY0VuczFiY0g4amtLaWdsTzV5N1UxaXVWV1JYVGVyYjRzL3A0bzZw?=
 =?utf-8?B?bEJsUTBuWitBdEZkalllVVVIc2lBOXVUcHNlRmxkblVSU3NwUCthYmYvc3Bw?=
 =?utf-8?B?K0x1ODR5WWYydFpDS3ZnMHpGR1g3a1hWTTVOWk9uNzB2YVJlclZ2cmZ5Z01T?=
 =?utf-8?B?WC82eURyMDFxWXI1MTFLUWRVUVZxY0JmVThpQUxyNms1ek80TllZSzJqY1l0?=
 =?utf-8?B?OXk0bloyT25lZVBjT0FndituNHpPaE1NUmlYUUhrRWM5MWx1bU5BNzVOY0VU?=
 =?utf-8?B?SjZpZlJNeHVsRUw3cmFtVm1xT3BZb2d5L3MzaWNxeVM0S2NLb0lsS2kzMEt5?=
 =?utf-8?B?eHRtczdxN1F4VUFHRjhuakVBYXptOU9jMWIxUzIzQXY2c1JBS3NxK0dVRC9K?=
 =?utf-8?B?a1pCVmRaOGhoMmJ3c2hON05JOWFSdldoMVFCUFBvaDUwRXNWV2dIOStDVTd2?=
 =?utf-8?B?YnlQdjhBVVFyMkJtakNTaUFVeGI1QTk3WGhncG5LT3FIYlBkdi9rdDRTSEth?=
 =?utf-8?B?QjJlMjl6b21jYVlhYVJFaWpkNzcyZVpvaGQyb1FvVmxnaUdwT0dZaEptTFRO?=
 =?utf-8?B?Z2ZOQitaRGlta2VmUzFvb1kwNEJtdlUvWDNjU0ZsbUVYOXZqZnNwRnBITFZo?=
 =?utf-8?B?VnVZek9WZUp2bTVnZ3pmWVFLYjBOS00wckgwQkw3MktZZDJ2REdHYllHTGpo?=
 =?utf-8?B?ZEo2U3QvNnN5WWxodEI2VGwwMlJYR015REM1SUE3TlZVQmRQVS9UU25CR0xU?=
 =?utf-8?B?VkJMU1Vqdis1TmxuQ2dDN243RC9yM3hndFlUcFI5TTlodDFvTjdscW9hOGlw?=
 =?utf-8?B?SURSNDBESFNIOGEzRG1FNGZKT3M4b0VHVndVM3ZPVjlRVkpIbm0vamtiUmdZ?=
 =?utf-8?B?aUNrWHFsUDRmVlJyN3FMZmNxbkxPUlZxclViQk8wTE51SUxQUEFGTEFLWGZl?=
 =?utf-8?Q?JAw/3WNI3E58cHCU4T9TpmpEk?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 48ca5046-e124-4a98-f98e-08dcbb65e701
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2024 07:02:32.4641 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K31lMcxSiOJbzb0GjwnUVF/DZtCUuZmAXxdlBbDHSoVUa9U0s8n5eO5e+18M0vLzzOj/lbXQPcuRGdjCuu2t6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6515
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.12; envelope-from=yi.l.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.126,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 2024/8/13 13:53, Zhenzhong Duan wrote:
> According to spec, invalidation descriptor type is 7bits which is
> concatenation of bits[11:9] and bits[3:0] of invalidation descriptor.
> 
> Currently we only pick bits[3:0] as the invalidation type and treat
> bits[11:9] as reserved zero. This is not a problem for now as bits[11:9]
> is zero for all current invalidation types. But it will break if newer
> type occupies bits[11:9].
> 
> Fix it by take bits[11:9] into type and make reserved bits check accurate.

s/take/taking/

Reviewed-by: Yi Liu <yi.l.liu@intel.com>

There is another fix you may add. In vtd_process_inv_desc(), it should
treat the type VTD_INV_DESC_PC and VTD_INV_DESC_PIOTLB as invalid type
if vIOMMU is running in legacy mode.

> Suggested-by: Clément Mathieu--Drif<clement.mathieu--drif@eviden.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> ---
> Tested intel-iommu.flat in kvm-unit-test: PASS
> Tested vfio device hotplug: PASS
> ---
>   hw/i386/intel_iommu_internal.h | 11 ++++++-----
>   hw/i386/intel_iommu.c          |  2 +-
>   2 files changed, 7 insertions(+), 6 deletions(-)
> 
> diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_internal.h
> index 5f32c36943..13d5d129ae 100644
> --- a/hw/i386/intel_iommu_internal.h
> +++ b/hw/i386/intel_iommu_internal.h
> @@ -356,7 +356,8 @@ union VTDInvDesc {
>   typedef union VTDInvDesc VTDInvDesc;
>   
>   /* Masks for struct VTDInvDesc */
> -#define VTD_INV_DESC_TYPE               0xf
> +#define VTD_INV_DESC_TYPE(val)          ((((val) >> 5) & 0x70ULL) | \
> +                                         ((val) & 0xfULL))
>   #define VTD_INV_DESC_CC                 0x1 /* Context-cache Invalidate Desc */
>   #define VTD_INV_DESC_IOTLB              0x2
>   #define VTD_INV_DESC_DEVICE             0x3
> @@ -372,7 +373,7 @@ typedef union VTDInvDesc VTDInvDesc;
>   #define VTD_INV_DESC_WAIT_IF            (1ULL << 4)
>   #define VTD_INV_DESC_WAIT_FN            (1ULL << 6)
>   #define VTD_INV_DESC_WAIT_DATA_SHIFT    32
> -#define VTD_INV_DESC_WAIT_RSVD_LO       0Xffffff80ULL
> +#define VTD_INV_DESC_WAIT_RSVD_LO       0Xfffff180ULL
>   #define VTD_INV_DESC_WAIT_RSVD_HI       3ULL
>   
>   /* Masks for Context-cache Invalidation Descriptor */
> @@ -383,7 +384,7 @@ typedef union VTDInvDesc VTDInvDesc;
>   #define VTD_INV_DESC_CC_DID(val)        (((val) >> 16) & VTD_DOMAIN_ID_MASK)
>   #define VTD_INV_DESC_CC_SID(val)        (((val) >> 32) & 0xffffUL)
>   #define VTD_INV_DESC_CC_FM(val)         (((val) >> 48) & 3UL)
> -#define VTD_INV_DESC_CC_RSVD            0xfffc00000000ffc0ULL
> +#define VTD_INV_DESC_CC_RSVD            0xfffc00000000f1c0ULL
>   
>   /* Masks for IOTLB Invalidate Descriptor */
>   #define VTD_INV_DESC_IOTLB_G            (3ULL << 4)
> @@ -393,7 +394,7 @@ typedef union VTDInvDesc VTDInvDesc;
>   #define VTD_INV_DESC_IOTLB_DID(val)     (((val) >> 16) & VTD_DOMAIN_ID_MASK)
>   #define VTD_INV_DESC_IOTLB_ADDR(val)    ((val) & ~0xfffULL)
>   #define VTD_INV_DESC_IOTLB_AM(val)      ((val) & 0x3fULL)
> -#define VTD_INV_DESC_IOTLB_RSVD_LO      0xffffffff0000ff00ULL
> +#define VTD_INV_DESC_IOTLB_RSVD_LO      0xffffffff0000f100ULL
>   #define VTD_INV_DESC_IOTLB_RSVD_HI      0xf80ULL
>   #define VTD_INV_DESC_IOTLB_PASID_PASID  (2ULL << 4)
>   #define VTD_INV_DESC_IOTLB_PASID_PAGE   (3ULL << 4)
> @@ -406,7 +407,7 @@ typedef union VTDInvDesc VTDInvDesc;
>   #define VTD_INV_DESC_DEVICE_IOTLB_SIZE(val) ((val) & 0x1)
>   #define VTD_INV_DESC_DEVICE_IOTLB_SID(val) (((val) >> 32) & 0xFFFFULL)
>   #define VTD_INV_DESC_DEVICE_IOTLB_RSVD_HI 0xffeULL
> -#define VTD_INV_DESC_DEVICE_IOTLB_RSVD_LO 0xffff0000ffe0fff8
> +#define VTD_INV_DESC_DEVICE_IOTLB_RSVD_LO 0xffff0000ffe0f1f0
>   
>   /* Rsvd field masks for spte */
>   #define VTD_SPTE_SNP 0x800ULL
> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> index 16d2885fcc..68cb72a481 100644
> --- a/hw/i386/intel_iommu.c
> +++ b/hw/i386/intel_iommu.c
> @@ -2744,7 +2744,7 @@ static bool vtd_process_inv_desc(IntelIOMMUState *s)
>           return false;
>       }
>   
> -    desc_type = inv_desc.lo & VTD_INV_DESC_TYPE;
> +    desc_type = VTD_INV_DESC_TYPE(inv_desc.lo);
>       /* FIXME: should update at first or at last? */
>       s->iq_last_desc_type = desc_type;
>   

-- 
Regards,
Yi Liu

