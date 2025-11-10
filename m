Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A97ACCF9E3
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Nov 2025 11:18:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vIPul-0000yy-Ds; Mon, 10 Nov 2025 06:18:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1vIPYq-0005r2-Vt
 for qemu-devel@nongnu.org; Mon, 10 Nov 2025 05:55:50 -0500
Received: from mgamail.intel.com ([198.175.65.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1vIPYn-0001um-Ln
 for qemu-devel@nongnu.org; Mon, 10 Nov 2025 05:55:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1762772145; x=1794308145;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=6AFPqpj1QK4oKzNdPVNaMbVagktTlwlLq7FDCWGI2Yo=;
 b=XcJSiOALPIl3oi0BW3mXM4CoH9CuKY20gPuOMs4fBXkpsOqcgjrCwsmP
 wotNDEDJRYOQ/JyaxqzeyGIClzRBMJe4SUXZ9S+Qf9GsVzbbOtSpCxFxx
 xMmvv5QQa3s14fcwSggFF2ODECZUnYMbs97iaat7BOdV7xnk6nfemuiWV
 cZ9DXw7HayvM4OtZcfx5RAZrsl7NQtWZo7SeRkpbLcISwWzroswdpomzg
 DClAWNxC0iKJ4sSC8bNMSjxT/V/m1W57N+FM87O+fMSXwMvghqj3qpsNE
 F9EPtmKp2kj9xmw/pUDkbVIFeMDnFTD09mdSj3ul2BW2KeJPTc6CPgdkc Q==;
X-CSE-ConnectionGUID: v5Gts+buQ3ehttOb2B8yAw==
X-CSE-MsgGUID: ZzxbRvbTTNmkCWbIHPn/+w==
X-IronPort-AV: E=McAfee;i="6800,10657,11608"; a="87450073"
X-IronPort-AV: E=Sophos;i="6.19,293,1754982000"; d="scan'208";a="87450073"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Nov 2025 02:55:41 -0800
X-CSE-ConnectionGUID: WqXZShX+T6WuYQvjEIG5fA==
X-CSE-MsgGUID: XSbx0k6nSW2p/tZ7rVfQag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,293,1754982000"; d="scan'208";a="187897038"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Nov 2025 02:55:42 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 10 Nov 2025 02:55:41 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Mon, 10 Nov 2025 02:55:41 -0800
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.3) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 10 Nov 2025 02:55:41 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i2lOCRbYBiQGWDmamLjmoOPsjcRJWiSxYhxj4wAFpwQN7lbiEjBKpXExWjCUVsjIDeX3e3lf079NEZsuogMNOdeAczxlN3+FPMbZT7gp/PUh36utP24TWIVHlWS39xjgVJfdCi7NG1EnciLcLDJ1eF/lYZgH8sQkJz5ZPxbtvspLdPGfTw5MU8soGUhhr3zQV6mi5dgvjnJcPIXXlM1VgJAoHHpivJUIVZhb0TCuPB9pOgctBx4MMOOf5PmCo3McLLBoFyFlFjpQpzisikIfRcyj1z49NwnCIT5kMxS/ntJJfJKusS/GRSiB8tP9abLqJf1OjxfYHIehAN0MN6BDhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HpxcqUEhLwfzObK+k+y2NR3CqLkkSL00O8f51ja/l2Q=;
 b=MNAP6g7/fZkp/L8HedUBPyXH7ZNfa0SL9kFGN2dBDH4z7gQVOmSwZNv2ZeuJjcVVWySTKUFhDTBefZVk9dJetB8vjpFr6h38mFscyw/jv9/KI32uaeSYrvdPwHGqgEOD0W7BwosGJyOpY7UtxTGTNhBTDtXRE44gCAHB0+tSUDE/8r4ECMjb2vb44HFdMhzuG5b72gEPK3Ha8nnOwEv21Wz1wB1FX7F0IKd2C2h8ysYnuu2vBxay3MdS3t8bFGDg0tvnnpMDgCMJOSYzhTSZxrkTY8pJ5LAS9ofUqgijYExlP+Nw5VoQVKzWafNAWQVW+q5IoQm2LGFJiKK2U4ptNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ0PR11MB4798.namprd11.prod.outlook.com (2603:10b6:a03:2d5::12)
 by PH0PR11MB4792.namprd11.prod.outlook.com (2603:10b6:510:32::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Mon, 10 Nov
 2025 10:55:39 +0000
Received: from SJ0PR11MB4798.namprd11.prod.outlook.com
 ([fe80::d946:6abf:6e7e:fd1e]) by SJ0PR11MB4798.namprd11.prod.outlook.com
 ([fe80::d946:6abf:6e7e:fd1e%7]) with mapi id 15.20.9298.015; Mon, 10 Nov 2025
 10:55:39 +0000
Message-ID: <a7c79221-6872-4f43-bc7a-d9b6f57248da@intel.com>
Date: Mon, 10 Nov 2025 19:02:25 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 7/8] vfio/migration: Add migration blocker if VM memory
 is too large to cause unmap_bitmap failure
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>, "mst@redhat.com" <mst@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>,
 "clement.mathieu--drif@eviden.com" <clement.mathieu--drif@eviden.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "avihaih@nvidia.com" <avihaih@nvidia.com>, "Hao, 
 Xudong" <xudong.hao@intel.com>, "Cabiddu, Giovanni"
 <giovanni.cabiddu@intel.com>, "Gross, Mark" <mark.gross@intel.com>, "Van De
 Ven, Arjan" <arjan.van.de.ven@intel.com>
References: <20251017082234.517827-1-zhenzhong.duan@intel.com>
 <20251017082234.517827-8-zhenzhong.duan@intel.com>
 <49ac485e-4704-40a9-a574-9bcfdc1f33fd@intel.com>
 <IA3PR11MB9136B8DEF2A5D413E121F13D92F2A@IA3PR11MB9136.namprd11.prod.outlook.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <IA3PR11MB9136B8DEF2A5D413E121F13D92F2A@IA3PR11MB9136.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TPYP295CA0050.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:7d0:8::12) To SJ0PR11MB4798.namprd11.prod.outlook.com
 (2603:10b6:a03:2d5::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR11MB4798:EE_|PH0PR11MB4792:EE_
X-MS-Office365-Filtering-Correlation-Id: 04223467-9699-4273-ddbd-08de2047af6c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|1800799024|366016|42112799006|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WFg5MEo4QmNUSTkxRHFBc1BRTmF5ZUpCZUdxTmRVZmdzTCtPRHhsemNvaFF1?=
 =?utf-8?B?aEpTVW9FRFlRaWluaDUzazg0aEMzOE5Vd0ZObWRUaUljVHFtMzFWbTgzTFZR?=
 =?utf-8?B?cGpwZDM1RkJLaVRzR2hhT1dwVFJ1VjVqNUdhdGNQVUQ1NEZ2LzFKRGlBc3E4?=
 =?utf-8?B?VVhKdnVGRXgzVHZnVmhkYytCZUVwb3VKaVgyeElmVHk0TVowQTlJNFYwZVRF?=
 =?utf-8?B?SzBPQURUNDhsQTBhUlNnVW40dkF6MU15WlE5MXhISlBIQ2FnS0llMk9qNmRI?=
 =?utf-8?B?dmowdnlmdngwZm5KM0FDZ0M0ejFnYUh2Mm9makFieVVQNWxpK09DeUx5YmpE?=
 =?utf-8?B?RjNOVlRUanRxUHpUOWU0N1p2YzJndURXT3JjcE85VkxPeXB6TTdvenFVL1lp?=
 =?utf-8?B?MEkxUXkydVFUWnh6QVJUa3dNZ2V4SWVmMVZ5WEJOV1h4ei90TVlPYmdtYmNK?=
 =?utf-8?B?VHdSVGdZRVRyWHltaGxoR04ycmVSRnZjVkJmcjVmRmJhNDNEQmIyZ1l1Vm43?=
 =?utf-8?B?bXRJQzB0TVNLZm5VeE83NHRGRG9qS05Xd3dSRzJDQytuZTlidnJmZFlkNlB6?=
 =?utf-8?B?REZ5eCtTeE1VcCtqYzNlNVNsOEhQYldBRWJ6UWJkN2ZORWZxMVRHOWMvQktF?=
 =?utf-8?B?Tnp3dlZNMDB0TFYwNUhQdU1vdFY3S2p1eTNoa3pISThLaFhBdmNQLytnZSt2?=
 =?utf-8?B?OGVYbm1Qd0NrNGJzdERlQU9wRmQ0eHVLRnVsVUYyb1dCNXF5WFd4RDY1Q0tJ?=
 =?utf-8?B?dzE4RjFqZTVIbGF1ZVFOcXBtYXZoeG9UckhVR3pxVHFaQm9LSlV0Rml0U0xS?=
 =?utf-8?B?NEE5cW9mTkdSRDFabTF4RkdycDl2b0o1N2VPQ1FHVHd3N0I2cFE1dXNMTW1E?=
 =?utf-8?B?OVhIK2YzNW41aWFXa2VvdjFEbkQ3MUNUMDArQ1NUQnFxRkIrWFNkOU9sU0FZ?=
 =?utf-8?B?aW9yZFVkVXlRdnMyNWMwVEpFTUI5UFhYbUtLaEIyZkJHbEozTUxVMUlxOTRz?=
 =?utf-8?B?ODN2S0g2dU5XL2xteWNYdHRXbEFZdHVRQm0xT3RXd3FRYjZnalpoOVdwOUxL?=
 =?utf-8?B?S1EyMFRrODZTWngzcjRBcHNwcFlFeGgyNzg4ZHR4SExOVDlKUnBZV1Y3Z01J?=
 =?utf-8?B?d25PRlNJbis1L1E4bFdPNmR2bzY4VnlPNk1tc0tma3oxWmRpWW9Ib2h3NDVh?=
 =?utf-8?B?MjZXaTVjWk9rZGFsKzlxN1I3QytYbzh1eER5VFd6eS9MTWRFTVFxcS9tekpw?=
 =?utf-8?B?ajhsdGNEUGovd0JxNHg5Vmo2blUwM2NndFhyUmxLdVMzekszN3FHZGpMNnMx?=
 =?utf-8?B?T2MvakpSOW45ZFJoRjVuYzJ1dlhRNWVtakR1dUNCREx3M3kzOHpyVitNTVZF?=
 =?utf-8?B?MWNNdVJ4VTRMc0pTeXFXejVYMDJySXNISHJRWDBQL2lick5WQjBUOFAxOEpC?=
 =?utf-8?B?SkJFTWJ6Z1U5bExoTE0zaE1uTlNYUnJLWUw5OWh1UWYzci9PK2w2WkdTQmVX?=
 =?utf-8?B?UjJVL2lFT3Z4V2dMR2pHY25XQkxHS0lmZkp0YmNrS0VLMFFhWi9oaFVJZVdF?=
 =?utf-8?B?Z0NVQXEwRjgreU9IWUZmZHNvR0ZyTXFMMDMyOG84enNHdGorNE9PMloxdEJJ?=
 =?utf-8?B?UXIyMWNqNmZtQ3JxcHFOaVVidnVtek1zendzVnBaWHordFpxaDBvdkF2QWl0?=
 =?utf-8?B?UXBzTU42VlBPaWZuUXh5MmpsYmNWdkRFbzZGV0NwTDBjQ2V6Z1QyWldRYUlY?=
 =?utf-8?B?bHM1OEtuRlZ4WkVZYmlMUXpBVXp4UFNndXg4eURZOXlTcCs4dGV2Um9kblZK?=
 =?utf-8?B?UUN6V1N6TFRLRHg0Ylo0azJkS0pmRzlWT0ZkQ1d1SEloTFlDT2dlMmEzUEUv?=
 =?utf-8?B?M0V5dW44ZlR3RjV1aE9ESUpSUU5lek1tL015QldVbEpTdXFjK2h6cmZEdndP?=
 =?utf-8?Q?4VwjgJ1BjTMhnoQI7tdV97IKsj+x3Is8?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB4798.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(42112799006)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZVpOWG9kWTBib2pXeGRzWFlmb081T2lGQkUrWGE2M25FY1BOajNFRmpjRVRk?=
 =?utf-8?B?Q0paZWd0S2JTdWIvdURndmNITmRsSlFwdll4WWRzaVc1eFYyUkYzVmZnNWRn?=
 =?utf-8?B?M2VVVEoxbjVXRHVadmwzMGs2VUlySzB3c0g1TDJvNkowSnI0MXlNQzExb0FE?=
 =?utf-8?B?d2gvT0RsQTM3Mjd5bkhUdDM5bG1MSjJWdjRLc0laZDlpRDNlTWxXdlJJemVn?=
 =?utf-8?B?ZTM2T3k4L042SytIS3NvdU9tUFZBYk9QdmUvMHFFbDczdHVXbXRxNTZTWmdZ?=
 =?utf-8?B?aTYrSnJ3NENCT25MUklteFBkTkp0QVV3bjBIS1RDdGRNS2RVTmVCaCt0VEV0?=
 =?utf-8?B?OXZ0T3dESXVsaGZSWGx5ZlAzZHhwKzYvUGFIVlFqbGZxMk9pWmRZRXU2cXI2?=
 =?utf-8?B?Rmh0WlJYU2ppWHQ1NEtjRU1PU3FBZUYweU9PTkNEbWltK1NyM0I2YVo3OVEw?=
 =?utf-8?B?TGEwY2FQOGJieUZuTDlPVm0rN2tqUWJaSEx6OHN6cVFoQVdkNGRyZVFUME91?=
 =?utf-8?B?V05WMUhEUnlkY1djT1N3R0x1aFJXaHQycXVLTTBzRVpON2lxd0FLSEdpTVBq?=
 =?utf-8?B?Wk00bkREN3RMOHJicURsQSszM1lUMnZzTU1hVjBJRXNqbDg0aGxtL05yVENk?=
 =?utf-8?B?OXZXdk9pQjV5M3U4T1Y2OHlGZlgzdGhoL0lmUXYrL0NIcWNjUk9MQjNBWGZM?=
 =?utf-8?B?dFkxK20xakpVQkZFcitJa0dXc2VMb0VFamcydEVzNGtvVjBVWlZJekEzZnBt?=
 =?utf-8?B?aWhQK0lCdDJob2lSMHByOGMzRFpPeXdISXNtcGdpNkxnYXdRenFwby9mOGsz?=
 =?utf-8?B?bHlWMWx1WG83Y3pTTlIvVHlGWnZMdlRRRDB4WDhtbXhPdk1QeW1Uek1jVktF?=
 =?utf-8?B?NUxRRUdialV6L2RMZ1NHeGw1TDRVOE5KM0krMjVOVHZsREhyRlQyOE93NmVj?=
 =?utf-8?B?eHJza3RVR05jMloyTWowYWZFWHc4SzF6ODE1LzA0cndLWVVrY1VuaXB1WFhy?=
 =?utf-8?B?RmFrMHBXMFE0Q3hFa3kvYU5lS2tFL1pCT2hLUnFLTUs0TXBDSXMvNEN4eFBI?=
 =?utf-8?B?WDlHUlNiSjQ0bm5Jb2I0MmdVSGFGRStzNmQrMWJCMmM1dlJyZzFxdWxscU10?=
 =?utf-8?B?eGhnUHkzR3VqanluaGpHQ3ZFM2RXWUpLZFcyNUZWbDZnOTVrTnlQTXJVS05Z?=
 =?utf-8?B?SjFmTjN3N2pjSy96MURRZmlRT29nTVd4TzlUL294S1d3YkszeERMajdzU09s?=
 =?utf-8?B?aUhjM2JteHh0emFycXQ1cThiQkd5Qk1rNGhFSWhkalhaaUZOb3dTY2R5T0hV?=
 =?utf-8?B?MXFabWNTeVdrc1ZCT3UyWGxsaEtscGROdGQ4bUdHSWJxYzNZYk1yeDFPN0hU?=
 =?utf-8?B?WHlpMnFJSUtkTWc5VkZQMzRFZ1ZOYVlyVzN2TTJPQ0dVYjRWTm5wTlRJc3VX?=
 =?utf-8?B?L1NqanhnZk9ZS1gzRWdJc2paQlVjalp5TWdFcWhpSGxOZ0ZxVCtpTndzdUJn?=
 =?utf-8?B?dWxIMVFhcFFZYmRpd053b3FGU1VNd0J1aGg2MHdibWVtRkxEbE9ENTZhL2k5?=
 =?utf-8?B?cWl2bjhvQTlRUlkzOG5iQjRkUFM5MEJaYU15UHZFdEVKSi9Dcy9hTlEwUG5a?=
 =?utf-8?B?ZWo2d04wSnJqU2lDM20vMVdPS2VuM1cwdUxudDZmeHdGUExJUm1QaCsyK2Ey?=
 =?utf-8?B?VzBOTE8rSGF3d0taR2ZMcHRHVGMxaEpFRThWUkZqT1dXcUQ4ZU1ib3gxNGpV?=
 =?utf-8?B?eVlXNEhEQklTS0FqbTd3QWF0akI1NVJGVGVHSzFjeWhRZE9tNEE5VlUwaGl3?=
 =?utf-8?B?cTRkTVZLTGNuOTdjeWRUNlEzanJ0V2d4Y2JHNXlkbytmcFpmWDEwNjZhRTc1?=
 =?utf-8?B?MzR3VnBPM21XM204UzQrU24zWHIzbzNSd1kwejBhczRoTmVUWkxsMGR4N3JR?=
 =?utf-8?B?b3BGSU9ReTFkbVM1LzdWRVA0cXgvM3BxWEZzUk11UTRXeERTWTkxWldZRkRw?=
 =?utf-8?B?SXZ6cHZxL1Z1cmtzc1ZTZ3VzMFJ5Szk4ZmVULzVXVkU0b29KZnEwaGhiZy8v?=
 =?utf-8?B?bWRnM1p0L2xCOE1HbTdPUEdrN2NQWVdlSGhjaDZZNkJUajVSUURzeWZGaDlZ?=
 =?utf-8?Q?i7vRMn5sIGg5gYXj013tXSLwr?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 04223467-9699-4273-ddbd-08de2047af6c
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB4798.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2025 10:55:39.4046 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9gayaKb+lNrqk5eyoJ6JdppfwQL8Z3Pj+1TiESJYyGwbPvA/ML7Pl/VFB7DXKiye+1oSS1OeMMaEBphda3esAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4792
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

On 2025/10/21 16:25, Duan, Zhenzhong wrote:
> 
> 
>> -----Original Message-----
>> From: Liu, Yi L <yi.l.liu@intel.com>
>> Subject: Re: [PATCH v2 7/8] vfio/migration: Add migration blocker if VM
>> memory is too large to cause unmap_bitmap failure
>>
>> On 2025/10/17 16:22, Zhenzhong Duan wrote:
>>> With default config, kernel VFIO type1 driver limits dirty bitmap to 256MB
>>> for unmap_bitmap ioctl so the maximum guest memory region is no more
>> than
>>> 8TB size for the ioctl to succeed.
>>>
>>> Be conservative here to limit total guest memory to 8TB or else add a
>>> migration blocker. IOMMUFD backend doesn't have such limit, one can use
>>> IOMMUFD backed device if there is a need to migration such large VM.
>>>
>>> Suggested-by: Yi Liu <yi.l.liu@intel.com>
>>> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
>>> ---
>>>    hw/vfio/migration.c | 37 +++++++++++++++++++++++++++++++++++++
>>>    1 file changed, 37 insertions(+)
>>>
>>> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
>>> index 4c06e3db93..1106ca7857 100644
>>> --- a/hw/vfio/migration.c
>>> +++ b/hw/vfio/migration.c
>>> @@ -16,6 +16,7 @@
>>>    #include <sys/ioctl.h>
>>>
>>>    #include "system/runstate.h"
>>> +#include "hw/boards.h"
>>>    #include "hw/vfio/vfio-device.h"
>>>    #include "hw/vfio/vfio-migration.h"
>>>    #include "migration/misc.h"
>>> @@ -1152,6 +1153,35 @@ static bool vfio_viommu_preset(VFIODevice
>> *vbasedev)
>>>        return vbasedev->bcontainer->space->as !=
>> &address_space_memory;
>>>    }
>>>
>>> +static bool vfio_dirty_tracking_exceed_limit(VFIODevice *vbasedev)
>>> +{
>>> +    VFIOContainer *bcontainer = vbasedev->bcontainer;
>>> +    uint64_t max_size, page_size;
>>> +
>>> +    if (!object_dynamic_cast(OBJECT(bcontainer),
>> TYPE_VFIO_IOMMU_LEGACY)) {
>>> +        return false;
>>> +    }
>>> +
>>> +    if (!bcontainer->dirty_pages_supported) {
>>> +        return true;
>>> +    }
>>> +    /*
>>> +     * VFIO type1 driver has a limitation of bitmap size on unmap_bitmap
>>> +     * ioctl(), calculate the limit and compare with guest memory size to
>>> +     * catch dirty tracking failure early.
>>> +     *
>>> +     * This limit is 8TB with default kernel and QEMU config, we are a bit
>>> +     * conservative here as VM memory layout may be nonconsecutive
>> or VM
>>> +     * can run with vIOMMU enabled so the limitation could be relaxed.
>> One
>>> +     * can also switch to use IOMMUFD backend if there is a need to
>> migrate
>>> +     * large VM.
>>> +     */
>>> +    page_size = 1 << ctz64(bcontainer->dirty_pgsizes);
>>
>> Should use qemu_real_host_page_size() here?
> 
> hmm, I think it's host mmu page size which is not as accurate as the iommu page sizes? here we want the iommu ones.

I saw vfio_legacy_query_dirty_bitmap() uses qemu_real_host_page_size()
though kernel enforces min iommu page size. Shall we let 
qemu_real_host_page_size() use iommu page size instead of cpu page
size?

