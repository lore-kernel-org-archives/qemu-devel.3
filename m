Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACBDFC3DA4A
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2024 09:36:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYMnL-0000ks-8v; Mon, 29 Jul 2024 05:35:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1sYMnJ-0000eS-Cs
 for qemu-devel@nongnu.org; Mon, 29 Jul 2024 05:35:53 -0400
Received: from mgamail.intel.com ([192.198.163.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1sYMnF-0002Yz-Vj
 for qemu-devel@nongnu.org; Mon, 29 Jul 2024 05:35:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1722245750; x=1753781750;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=Zk0MYCjViAPilLq1LYmRQ61pdjzRLpWtWOtZe7mjP4k=;
 b=eAv3U2OeFoFTOsaWhRonrcxU57wDECCPxvR2sPOcvqhmMvCvemL/Z5Pw
 r0NvHvB1+5E0GISYGxpFuLU8TQH/xL3tvFWkEkHF9diYOIc/ZoLTsL5iI
 7eitIaWfwrjUGfmlZslNnS46IOcOVIcLghdWd32SjAbECDrOEoxqUzW7I
 IgZcxORWI7f9uZPsuJSDIBGad/UGSIoPxicL3wW6fI7zqrwRlSRksvcnB
 wZaWHeEhgJUVqu4BlS56pcIt2cwYn0RlwnLel++WA65j/ClFIlq+2qqzA
 XArQfnrWl0vFMNeKfyxPoIzqCW7XGL9UDRNiHUYu0cQ1t7xsUtAbepj3+ Q==;
X-CSE-ConnectionGUID: sG/6VK/fQiyCuEXaAT2FZg==
X-CSE-MsgGUID: 4zamTUscRgmv+HcKDu2bZA==
X-IronPort-AV: E=McAfee;i="6700,10204,11147"; a="22900381"
X-IronPort-AV: E=Sophos;i="6.09,245,1716274800"; d="scan'208";a="22900381"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Jul 2024 02:35:46 -0700
X-CSE-ConnectionGUID: 2ddC1KxLSKe8kSSVokA8Qg==
X-CSE-MsgGUID: ujIEg3H3RHGdcRHjaqrqFQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,245,1716274800"; d="scan'208";a="59013535"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
 by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 29 Jul 2024 02:35:46 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 29 Jul 2024 02:35:44 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 29 Jul 2024 02:35:44 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.176)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 29 Jul 2024 02:35:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XQV10VEhwUquleFqtvkPRHvKGq8KxcLgVTiGTBnq1Wtepf0yvAMfNmdcqNdAJ/vVx5J6QXyc7naGBunhBH/Srwa2YLobAwlcMGeKu4YeLQ8dshywtwrcbJ+eTXtZBU/j5Z26vXlXu9jCEzqSQUxBxcbkK200GhN6zqBQDvUQN6q0oIe1OO5nYDMDEafG8WfLsW54g1IueS9tgs1n5k03ttMZws+Vwv0O4FO9tous14quKwJ0YXoBxTSknKMRPaaM34pqURdnINsCgdkH4wIRXGtpvCXqHsOCEmUntQ3hVpREm9cUaqfYQ2Le75V1uIE8yAb1gNZoCJ5zgGdOQAaUrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ODTkRTFxcVQw+pLqw/DPhSCaO60puVDFhHDeDXyQOuA=;
 b=w1we5pixxY3JtAvi2aPt+RdS7A6nYDDonYyZaSjRbJc6thJ5EG9ggyV2HbD6utou9kVnC1VpZxwOqzQg8EMvdKsk2et/+JqNvEqCKCLIPjwAXde4f3RNNeQ5yfGw5X6vu5WQvrAfDFqYPIRUao5WeNMviDhKZdDMk2VZeogio8QjdmFDotG4cIw2+QCG6kCK9Kv++LdkqCeSxd/uehCOeyIBd8/++OpYh96MxfgaRP9ZlYjJTlvwGvegeOInlrV68FL5aH/8eTdAAAb7hTKSakGeZwsgK8I2zXUvR8mIJ6KXzzStMwIamdw7Q6+l9yrbAIn+XGKHAQ8x7aj4o90wrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by SJ0PR11MB4976.namprd11.prod.outlook.com (2603:10b6:a03:2d7::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.27; Mon, 29 Jul
 2024 09:35:40 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a%3]) with mapi id 15.20.7807.026; Mon, 29 Jul 2024
 09:35:40 +0000
Message-ID: <a74730a4-4f90-4fa7-862c-6f64299cb2ad@intel.com>
Date: Mon, 29 Jul 2024 17:39:50 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 01/17] intel_iommu: Use the latest fault reasons
 defined by spec
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: <jasowang@redhat.com>, <alex.williamson@redhat.com>, <clg@redhat.com>,
 <eric.auger@redhat.com>, <peterx@redhat.com>, <jgg@nvidia.com>,
 <nicolinc@nvidia.com>, <joao.m.martins@oracle.com>,
 <clement.mathieu--drif@eviden.com>, <kevin.tian@intel.com>,
 <chao.p.peng@intel.com>, Yu Zhang <yu.c.zhang@linux.intel.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Marcel Apfelbaum
 <marcel.apfelbaum@gmail.com>, Zhenzhong Duan <zhenzhong.duan@intel.com>,
 <qemu-devel@nongnu.org>
References: <20240718081636.879544-1-zhenzhong.duan@intel.com>
 <20240718081636.879544-2-zhenzhong.duan@intel.com>
 <db972177-851c-4aa9-bd4c-777fe2b01ae3@intel.com>
 <20240729043610-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <20240729043610-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR04CA0205.apcprd04.prod.outlook.com
 (2603:1096:4:187::6) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|SJ0PR11MB4976:EE_
X-MS-Office365-Filtering-Correlation-Id: eb8ddc35-21b1-4173-908d-08dcafb1cf64
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MVc0VDloWUs2K3IyTER2WU1BeWhmS2pISzlMZEF1eDNyR3N2U1F3dlloU0hu?=
 =?utf-8?B?ZkNSclVOdk5YZUdIa1FvYnVHbHIxSXBCZEdTY0gydnR6TzgxbkdKSkFJTytX?=
 =?utf-8?B?Qnp0dnFObjVSdmFBVHEyOGdpNGNIWXdpZnNLSGhnc1NwdndXejVQYnptV0JC?=
 =?utf-8?B?VjdtTmZOeVZucUZzUVFLNzlRUkowVTJwSmE5cDlJQUR2blhMQ0JoTDE5QVV6?=
 =?utf-8?B?OUpJSUw5T25ZUjRkL2xKazlHZmluOUJJZEQwdjg2cWlmMGV4QmRlZzU1SENz?=
 =?utf-8?B?d1U1Z0RIN2NUbThkMWZqSGY3ckJtUTYyWGx2WlZ6Uml4SEJZUzQyanpvdWVB?=
 =?utf-8?B?Zmo2eDN6T3pueVRGT3VYRWI3Y2N0U0NVdGpsQmtWSUw4Tm1zSkdYYnNLaGxk?=
 =?utf-8?B?ZEhNNFZLWTdnanlMSGpIWXJidHEzSkErRHU4TWhqNGlMYjErZnN1Vmk3NVBX?=
 =?utf-8?B?Wm9uMVZid1c1TGlyWURVdnpZRW92U1ZQWWM5OXdKdW5DM25mS00zeHpVMTVq?=
 =?utf-8?B?eE9mSXo2dDdjYkFzbUtsTHk1Y2xaUElYUVlsSCtsQlF0MW1ZNW90N0lBelcy?=
 =?utf-8?B?SHhCWjByQmYybkswdXJkVHRuSVliS2V2RjRER1JEUU8wMEZlYnFlVWlBK1ly?=
 =?utf-8?B?djFDMVphNDk5WHV2ZkdobjB1TEVIQk5UREt3TWNaaklhclFXSVlzVk9jSXhB?=
 =?utf-8?B?MlpINlkyYllzdkdSd2lLcFpQTGQ4SXhpTy82UG5HWDZGcElheitFdWdXWHBY?=
 =?utf-8?B?MG9GL0p3UmttUDV3a0FTbkt4aXN4bERDSnhUV3hiaWFiaUFRQlBQYi9sRnU3?=
 =?utf-8?B?WSt1d3pmY3BOK3pQZEd5dHVkR0FkaWZmVTFvdkhEMDJVVHhvWXVHMWtZWnQw?=
 =?utf-8?B?U0hsZW1hUno1c2tPbzdHR1A2NEc1YVhXYm9PWFhnTGthZk02WlRRektzVVB3?=
 =?utf-8?B?cUlLYUF4MGZNV2pqdVlCU1k2NmMwS3hJWTJqZ24xWE5qQStzd3VHZ0x6YXpL?=
 =?utf-8?B?aWRzMXduMzdmYTlxVVNLenIrejJDLy8wZlNEc1pLQW5NYlo2WnIvaVQvZHFo?=
 =?utf-8?B?eEdTNUVETm81T2FSSHpCaTVpWVlSall5N1F1YlpEb1g2MTBOSHBZb1dhK3FI?=
 =?utf-8?B?N3FKcldtdThUMTVnUk5Cb1Z0dVRJOEI0MlUvQXd6cGFDZndvNENXNjVQNFlz?=
 =?utf-8?B?UDBaYW9DUkJyN2VXczI0UCtxWDRNellnZTV5Q2cxVnNHaTN4MWhiV0RZN2dH?=
 =?utf-8?B?eWVpNEE0M3phK2FlT0Z1ZGhSSy9lcDY3SVBsTmZrWm1LSWdySWhDYUcxcVdQ?=
 =?utf-8?B?Y2dWdHcrbG83NzZ1MWFySXowZTJrcjFaQ1h4SWd2eXFBTUJ3VG4zR0JwTE9M?=
 =?utf-8?B?dTEwTFRsSmorZGd4VWlJK1pmM2VvODdkRExScTZCVDdLRkZwU01PZG1veXk5?=
 =?utf-8?B?U3JMTVJIZVdIdnMrSVJWcDBNOGcxL1FPNUFJTUJidFFod01oWE1YTGx2TkVt?=
 =?utf-8?B?bnNZYlJ1VnQ5U2thbDRVR1BpUWxpZ3NxU2ltWm45d25WNGVSTytqUmI3bkZm?=
 =?utf-8?B?OHhXaFVUZk53VXlBWnFHZUxIRjV2dlZ6SnpPbG96cDJieU9QSldyaDQ1Z3Nz?=
 =?utf-8?B?TlUyby91WlJFMXd1RzNJNFRWdGlaamRFdzhkeFVuanBZN0RtVlk3ZEFySmVa?=
 =?utf-8?B?K05XeXNoMlg4WDNjZjZpRWxScEJ3c09LZkhEc3duYjNjSVlOWVEzZ1dNK3g2?=
 =?utf-8?Q?LDU07h31QWYddujrmmUbXVBGAjrZ9KenEcdo4P0?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7529.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7416014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QU9ueStSTXdvQWtNTnRwdEx6VFdFWkxKU0I5aktuRVBaOW1rOVhtWWpUQXo2?=
 =?utf-8?B?MkpHcGN0WTVIZ3dyL25YemZUUXJIbm1sd3JrWlhxNFVQYVZJNWIyblBNK0pj?=
 =?utf-8?B?U2twNWlXUXZWNWRTMjJZUlBiZzlKRk9SZXB5eUZGbXpOUzluc1A3MUJoYlg5?=
 =?utf-8?B?eXlya0tXRy9wdXZlTW95SVpFbHlLNUFRQ1Q0RnQ2SEVhZmFmb3Q2cmNmRXht?=
 =?utf-8?B?QXFoOWxYZFNkSzJiQjFLU3ZYeTY5eCswVFUvdklJUXplRjlLdVpHNndkVHVt?=
 =?utf-8?B?aTR3SDM0RVhOL0dsaFhjNWhQQ2FPeUxLSVBvTU54bTVTSktjZmxhUG11OFlR?=
 =?utf-8?B?eWlKWklmYnJ6YmN0TFU1bWU0VDBoVU1QZWM5TEZpS2x1dTVoNVNWSEdyWjVZ?=
 =?utf-8?B?ellQR2x4cVlSdGtjY28wSkY2YlE2a1VZZ09YQTNHMW5KTG1RTFlyTzVnS0Vz?=
 =?utf-8?B?VkRaNmZGQUoyZ1pVK0VJK2ZoOTc2UzNJT0tvQ0VXbGJLd1JkdWhXU1podHln?=
 =?utf-8?B?YVdyS1QzdzNxYVZJUEJ6SzJZQzVwOTVVTHdhbDh5MXZPY0FPLzBVdEJxS3k5?=
 =?utf-8?B?ZXlwTVFnejNEOUZuTHg3ZGRtaVhHd0hPNTlkTzhSblh1K3FwanJzZ2FiSWMw?=
 =?utf-8?B?WCsxeFh5K1lTamVPUDM2cUlQSzdyWkdVWWtKKzVEczhub0JHMUMvSklHMGtH?=
 =?utf-8?B?Snl1SkJvMnVuQTZ4OWpNQ2FQV0pxMFBFbFptekorVU8vd296MGlVMFJoVmg4?=
 =?utf-8?B?YjlKNXR2M0hsNzl6NkhMSWNja21RMHNRWUhXQXVuZ1UxQmkxWEt3UDY4SGRE?=
 =?utf-8?B?R056emZGZ0FTZjdUQ0dqdnc5eUFiOE4vN1VNWlBkNVViNWdFRkE3M0xBUmtN?=
 =?utf-8?B?dUVBN2NZVjQ0YlRtYkQ5dDZ2SlRZaFRwajhJOEFLOWJQdmJzVFltSkhpdnBF?=
 =?utf-8?B?OTRFTlIyNnM5bEV5SFZVMXQ5eC9ZUkNqL1c4QmpmbXlZUTlHMW4zV2VJVUVv?=
 =?utf-8?B?SVhHTHBoS2QwcmZFbDNlZkxzVkhPRitwN0FxTnJQVUpKQXFXa0RISlFoK2Zr?=
 =?utf-8?B?WlJnbmZQSVBrMnUyUGI2YkIrUCtyWmhmd1FCczhkVHd0T09rNmYxZWJINzY4?=
 =?utf-8?B?NVhsbzBsSDJ6QllFL0JEaUVad2t6NjIyY2VPQWVzQXJHcUJuZWcxQmdFNDY0?=
 =?utf-8?B?Z0JJaUhKR3B0WG0rb1JvclhjN0RBZmZXdlBhRDllbWtFZVA5VWtHSG01YkRN?=
 =?utf-8?B?QUx1d0IwOWRDUWxkSkJDMnFreW9EeHpiQk5COXRnbk9aOFp1cW9DUWRPUHVC?=
 =?utf-8?B?eHpJSk9HbU01Zjg3RSthZXV5ZS9tbjhIcWgrRHc5eC9FOHVtdUs2SEZjemxi?=
 =?utf-8?B?MGt2QTVvYlpOTGtkcm1TRWozak16ZnFnaElyS2JrSlBwOXB3SHo2dkRCTE9w?=
 =?utf-8?B?Tzc0VExCWmc4YmsvSGt5bmN0cy9IZUJ6YkNUc1BKditRQTdWOXNjWWZvWlJi?=
 =?utf-8?B?Zmk0MTBhY1lOUWFqU0JPWHBoQ0xQNzZEUjZkVHhuLzhFS1lyd3l2QWsybXJF?=
 =?utf-8?B?TjJhT2xvK2ZNd09OSkU1ZG1aSnV2RksxcnM0djVnbWN6Snh1Q0Z4TzhEb1JI?=
 =?utf-8?B?UFV2RmdEM1A1WmxoQzE5dDFGWWFRL0NMbmNOUnRHNHpSQWpCOWdmc3p6Um9x?=
 =?utf-8?B?T2N5SUQxVVJmK2FpTXdqSG1BVXZTMzB0aGdkNlVJaWhZQlhGOU1XUXgwQkpa?=
 =?utf-8?B?WStRWHJmeWo3NG1jVC93WlVyVkVVUUR2YzBDeEtHRURuNDRFRmpPa2RDTWVC?=
 =?utf-8?B?VHJYRGRPZGZFZ3phYURBNWFGL1pmWmZNS3ZwTVRqM1NSMkkxRmJ1NmUraHRL?=
 =?utf-8?B?bXVRck40ais3SlBuOVhsQXF0c3Z6NWZVQ2lNdlJSTmpYYWdSNGY5bTFockRn?=
 =?utf-8?B?OFc4MVpXUG1iajI0U1JLTi9oTG4wU0l2cXU1ZUlpNWtMU1YvbFh0N1ZGdnEv?=
 =?utf-8?B?RWZIUTl4ZDA1RkxUbkgyTUJ0d3greXJzbzVwNmVZRzk4MjNQWFZJZ3lwanhT?=
 =?utf-8?B?Y1BMemJLamwwWWJzWjFUUU03dXhkWWVVWHlGd1RISnJIM0MvSUpnTTIvVFlN?=
 =?utf-8?Q?WzH2f7LCO6KUHO8Adx3gi9YmI?=
X-MS-Exchange-CrossTenant-Network-Message-Id: eb8ddc35-21b1-4173-908d-08dcafb1cf64
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2024 09:35:40.6499 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VhgT8cqKA4lRfTtbbL7sygD9+0spI5ncuj3zZs56b971RJsMXT99oLwlu0j/fXdxb9FTea4/LoMAmQDVIVekxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4976
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.13; envelope-from=yi.l.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.125,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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



On 2024/7/29 16:42, Michael S. Tsirkin wrote:
> On Mon, Jul 29, 2024 at 03:39:03PM +0800, Yi Liu wrote:
>> On 2024/7/18 16:16, Zhenzhong Duan wrote:
>>> From: Yu Zhang <yu.c.zhang@linux.intel.com>
>>>
>>> Spec revision 3.0 or above defines more detailed fault reasons for
>>> scalable mode. So introduce them into emulation code, see spec
>>> section 7.1.2 for details.
>>>
>>> Note spec revision has no relation with VERSION register, Guest
>>> kernel should not use that register to judge what features are
>>> supported. Instead cap/ecap bits should be checked.
>>>
>>> Signed-off-by: Yu Zhang <yu.c.zhang@linux.intel.com>
>>> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
>>> ---
>>>    hw/i386/intel_iommu_internal.h |  9 ++++++++-
>>>    hw/i386/intel_iommu.c          | 25 ++++++++++++++++---------
>>>    2 files changed, 24 insertions(+), 10 deletions(-)
>>>
>>> diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_internal.h
>>> index f8cf99bddf..c0ca7b372f 100644
>>> --- a/hw/i386/intel_iommu_internal.h
>>> +++ b/hw/i386/intel_iommu_internal.h
>>> @@ -311,7 +311,14 @@ typedef enum VTDFaultReason {
>>>                                      * request while disabled */
>>>        VTD_FR_IR_SID_ERR = 0x26,   /* Invalid Source-ID */
>>> -    VTD_FR_PASID_TABLE_INV = 0x58,  /*Invalid PASID table entry */
>>> +    /* PASID directory entry access failure */
>>> +    VTD_FR_PASID_DIR_ACCESS_ERR = 0x50,
>>> +    /* The Present(P) field of pasid directory entry is 0 */
>>> +    VTD_FR_PASID_DIR_ENTRY_P = 0x51,
>>> +    VTD_FR_PASID_TABLE_ACCESS_ERR = 0x58, /* PASID table entry access failure */
>>> +    /* The Present(P) field of pasid table entry is 0 */
>>> +    VTD_FR_PASID_ENTRY_P = 0x59,
>>> +    VTD_FR_PASID_TABLE_ENTRY_INV = 0x5b,  /*Invalid PASID table entry */
>>>        /* Output address in the interrupt address range for scalable mode */
>>>        VTD_FR_SM_INTERRUPT_ADDR = 0x87,
>>> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
>>> index 37c21a0aec..e65f5b29a5 100644
>>> --- a/hw/i386/intel_iommu.c
>>> +++ b/hw/i386/intel_iommu.c
>>> @@ -796,7 +796,7 @@ static int vtd_get_pdire_from_pdir_table(dma_addr_t pasid_dir_base,
>>>        addr = pasid_dir_base + index * entry_size;
>>>        if (dma_memory_read(&address_space_memory, addr,
>>>                            pdire, entry_size, MEMTXATTRS_UNSPECIFIED)) {
>>> -        return -VTD_FR_PASID_TABLE_INV;
>>> +        return -VTD_FR_PASID_DIR_ACCESS_ERR;
>>>        }
>>>        pdire->val = le64_to_cpu(pdire->val);
>>> @@ -814,6 +814,7 @@ static int vtd_get_pe_in_pasid_leaf_table(IntelIOMMUState *s,
>>>                                              dma_addr_t addr,
>>>                                              VTDPASIDEntry *pe)
>>>    {
>>> +    uint8_t pgtt;
>>>        uint32_t index;
>>>        dma_addr_t entry_size;
>>>        X86IOMMUState *x86_iommu = X86_IOMMU_DEVICE(s);
>>> @@ -823,7 +824,7 @@ static int vtd_get_pe_in_pasid_leaf_table(IntelIOMMUState *s,
>>>        addr = addr + index * entry_size;
>>>        if (dma_memory_read(&address_space_memory, addr,
>>>                            pe, entry_size, MEMTXATTRS_UNSPECIFIED)) {
>>> -        return -VTD_FR_PASID_TABLE_INV;
>>> +        return -VTD_FR_PASID_TABLE_ACCESS_ERR;
>>>        }
>>>        for (size_t i = 0; i < ARRAY_SIZE(pe->val); i++) {
>>>            pe->val[i] = le64_to_cpu(pe->val[i]);
>>> @@ -831,11 +832,13 @@ static int vtd_get_pe_in_pasid_leaf_table(IntelIOMMUState *s,
>>>        /* Do translation type check */
>>>        if (!vtd_pe_type_check(x86_iommu, pe)) {
>>> -        return -VTD_FR_PASID_TABLE_INV;
>>> +        return -VTD_FR_PASID_TABLE_ENTRY_INV;
>>>        }
>>> -    if (!vtd_is_level_supported(s, VTD_PE_GET_LEVEL(pe))) {
>>> -        return -VTD_FR_PASID_TABLE_INV;
>>> +    pgtt = VTD_PE_GET_TYPE(pe);
>>> +    if (pgtt == VTD_SM_PASID_ENTRY_SLT &&
>>> +        !vtd_is_level_supported(s, VTD_PE_GET_LEVEL(pe))) {
>>> +            return -VTD_FR_PASID_TABLE_ENTRY_INV;
>>>        }
>>>        return 0;
>>> @@ -876,7 +879,7 @@ static int vtd_get_pe_from_pasid_table(IntelIOMMUState *s,
>>>        }
>>>        if (!vtd_pdire_present(&pdire)) {
>>> -        return -VTD_FR_PASID_TABLE_INV;
>>> +        return -VTD_FR_PASID_DIR_ENTRY_P;
>>>        }
>>>        ret = vtd_get_pe_from_pdire(s, pasid, &pdire, pe);
>>> @@ -885,7 +888,7 @@ static int vtd_get_pe_from_pasid_table(IntelIOMMUState *s,
>>>        }
>>>        if (!vtd_pe_present(pe)) {
>>> -        return -VTD_FR_PASID_TABLE_INV;
>>> +        return -VTD_FR_PASID_ENTRY_P;
>>>        }
>>>        return 0;
>>> @@ -938,7 +941,7 @@ static int vtd_ce_get_pasid_fpd(IntelIOMMUState *s,
>>>        }
>>>        if (!vtd_pdire_present(&pdire)) {
>>> -        return -VTD_FR_PASID_TABLE_INV;
>>> +        return -VTD_FR_PASID_DIR_ENTRY_P;
>>>        }
>>>        /*
>>> @@ -1795,7 +1798,11 @@ static const bool vtd_qualified_faults[] = {
>>>        [VTD_FR_ROOT_ENTRY_RSVD] = false,
>>>        [VTD_FR_PAGING_ENTRY_RSVD] = true,
>>>        [VTD_FR_CONTEXT_ENTRY_TT] = true,
>>> -    [VTD_FR_PASID_TABLE_INV] = false,
>>> +    [VTD_FR_PASID_DIR_ACCESS_ERR] = false,
>>> +    [VTD_FR_PASID_DIR_ENTRY_P] = true,
>>> +    [VTD_FR_PASID_TABLE_ACCESS_ERR] = false,
>>> +    [VTD_FR_PASID_ENTRY_P] = true,
>>> +    [VTD_FR_PASID_TABLE_ENTRY_INV] = true,
>>>        [VTD_FR_SM_INTERRUPT_ADDR] = true,
>>>        [VTD_FR_MAX] = false,
>>>    };
>>
>> @Jason, @Michael,
>>
>> Do you know the rule of setting this table? I noticed it was introduced
>> since day-1[1]. I didn't see any history discussion on it on lore. So not
>> quite sure about the purpose of it. Per the usage of this table, it is used
>> as a filter when the iommu driver has set the FPD bit. If FPD is set, some
>> errors need not to trigger a trace which is mostly for debug purpose.
>>
>> I noticed Peter had asked it as well[2]. But I don't think it was clarified
>> clearly. May we have a clarification for it here? BTW. I didn't see VT-d
>> spec has any definition on it. So it should just be a software trick. :)
>>
>> [1] https://lore.kernel.org/qemu-devel/1408168544-28605-3-git-send-email-tamlokveer@gmail.com/
>> [2] https://lore.kernel.org/qemu-devel/20190301065219.GA22229@xz-x1/
>>
>> -- 
>> Regards,
>> Yi Liu
> 
> Are you asking for a definition of qualified fault conditions?
> 
> 
> 7.1.1 Non-Recoverable Address Translation Faults
> Non-recoverable address translation faults can be detected by remapping hardware for many different
> kinds of requests as shown by Table 26. A non-recoverable fault condition is considered “qualified” if
> software can suppress reporting of the fault by setting one of the Fault Processing Disable (FPD) bits
> available in one or more of the address translation structures (i.e., the context-entry, scalable-mode
> context-entry, scalable-mode PASID-directory entry, scalable-mode PASID-table entry). For a request
> that encounters a “qualified” non-recoverable fault condition, if the remapping hardware encountered
> any translation structure entry with an FPD field value of 1, the remapping hardware must not report
> the fault to software. For example, when processing a request that encounters an FPD field with a value
> of 1 in the scalable-mode context-entry and encounters any “qualified” fault such as SCT.*, SPD.*, SPT.*,
> SFS.*, SSS.*, or SGN.*, the remapping hardware will not report the fault to software. Memory requests
> that result in non-recoverable address translation faults are blocked by hardware
> 

I see. Table 26 has the "qualified" column. It's clear to me now. Thanks. :)

-- 
Regards,
Yi Liu

