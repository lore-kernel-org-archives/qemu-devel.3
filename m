Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DDFCC30658
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 18:11:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOhyX-00081A-6e; Tue, 02 Jul 2024 14:11:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1sOhyR-0007xl-HM
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 14:11:27 -0400
Received: from mgamail.intel.com ([198.175.65.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1sOhyK-00029R-Un
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 14:11:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1719943881; x=1751479881;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=5FuVPwSzIxXWmJCtuHgxkZGU6U2ACotEyEsiiDir6Ic=;
 b=RlJQcBHIbvST1+G6uiVP4Gd5cGYAmktKjGXoVWDDHl31qCo5DHDDNyT3
 +rrfs1b4YkB3nKOB4Ce6zp0KY8Zyyp+gjbfHpBujsqy+NZlFn6tO2wJmX
 54vtARLRwzT8qFmPdUTdBm/iMcFNvboblWrbIOISogXqWw3JNHdyvV6TD
 YiNdWBG2GGxogeukFIJc2JWMDtJ2nDBJim3K5wiSJmtGCKK87dMmNuyqi
 xbPpjEF32xLrCOHIfvUVDy06LGMvg+Y/k9AKuLP+pgdOFuLRfXjq3E9fm
 9yDurqc5X9o9w4zxglZjBUmO7QSgoNt1aDnsXTZTp4Quj4ZK8Qu0HrZQf w==;
X-CSE-ConnectionGUID: Khc6sZ+1QymrJnvfAeiNcg==
X-CSE-MsgGUID: mraR9tjYSeiZjM9zqi2eDg==
X-IronPort-AV: E=McAfee;i="6700,10204,11121"; a="16964732"
X-IronPort-AV: E=Sophos;i="6.09,178,1716274800"; d="scan'208";a="16964732"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Jul 2024 11:11:17 -0700
X-CSE-ConnectionGUID: phHIWRWkRbGvWhpIakpgfQ==
X-CSE-MsgGUID: tcxtg7KNR4iMQ5pcjtTjXA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,178,1716274800"; d="scan'208";a="50322209"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
 by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 02 Jul 2024 11:11:16 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 2 Jul 2024 11:11:15 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 2 Jul 2024 11:11:14 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 2 Jul 2024 11:11:14 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.177)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 2 Jul 2024 11:11:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IA4Lcr4Qa/ydUlRhxgLK3O4mbrWhOH0H54qLUn8JsuaIiQ2+H0KlmJ7CR1ZJb6vptLy7o9rMhUW/BlXiLDFsXDVA1hRmiEILT0aV6Y9yCrJRRz9Ml6uMg5uxFPIiJSxml3F6G56xZnUtShO99uzJkRnhf/1XSLc6uRsyRx+2cA6+AlD73VIo1Xt1NYbvT0IEx6CbGmr2Oft27Je6CHdPc2Zg0thor3zLjx+Rs+ASLQNI+/xY8a3Zq4x1GkRlNOibYwMTXW5ckpgatRMjY4aaDGaJG5AWrDs+Waf3K2WmbvZz5YE90ZZLKKjU035q7Tap3HHDANRaXwjqHo4NZFiE5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dsja8B2Oc4uw4B08tGfPQRMfjmh1VRH2BEUy5blHh1c=;
 b=QNUkIQfwXEJiR5AfsI40Yb+nNOtG+0uhBqf9NWM++uaAuTXXcgv9wXd5xu+PyXkA1E39Qyv9RHrOgoUubCh/IR4VihMhy26uJBRLJRNpUsHgPyCkccZ3Ly3+x9GFA3hoWuDndJMIUSswdEWW9W1RQKPfocDNe+sLU7ffFGFFqmCZJnGht0JKRZnYXt+B1yNEn94kqx94R6ZBWa7TkwkMyj9Sw8+76rvAjr+Kwu07f3SEK9cv6qU9jxOckrLhTpdqhxF34IKKuTH0fcFXzTczx1JjtkchffSTTmsHDNhSEv4MBDPjQtsw4KxEB84gIJ6GtKX9A9Gz8Toa0JU+dMVQ5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB6879.namprd11.prod.outlook.com (2603:10b6:510:229::22)
 by MW4PR11MB6957.namprd11.prod.outlook.com (2603:10b6:303:22a::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.28; Tue, 2 Jul
 2024 18:11:11 +0000
Received: from PH8PR11MB6879.namprd11.prod.outlook.com
 ([fe80::bd3d:59f2:9d29:346]) by PH8PR11MB6879.namprd11.prod.outlook.com
 ([fe80::bd3d:59f2:9d29:346%5]) with mapi id 15.20.7719.029; Tue, 2 Jul 2024
 18:11:11 +0000
Message-ID: <71ea0f44-fea9-45ca-8ce0-064e8581c7cf@intel.com>
Date: Tue, 2 Jul 2024 11:11:08 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/4] hw/display/virtio-gpu: Introducing asynchronous
 guest display render
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@gmail.com>, "Gerd
 Hoffmann" <kraxel@redhat.com>
CC: <qemu-devel@nongnu.org>
References: <20240620231727.235841-1-dongwon.kim@intel.com>
 <CAJ+F1CKRau8FGHMv0aBb_ocitavCzivrzpB2YtfNa22N7uVsWw@mail.gmail.com>
Content-Language: en-US
From: "Kim, Dongwon" <dongwon.kim@intel.com>
In-Reply-To: <CAJ+F1CKRau8FGHMv0aBb_ocitavCzivrzpB2YtfNa22N7uVsWw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0063.namprd03.prod.outlook.com
 (2603:10b6:a03:331::8) To PH8PR11MB6879.namprd11.prod.outlook.com
 (2603:10b6:510:229::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB6879:EE_|MW4PR11MB6957:EE_
X-MS-Office365-Filtering-Correlation-Id: 9bc9bb46-22c2-4bf8-04ea-08dc9ac25a48
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MEMwU05IN3ZPcyt5V1FMQUtUbzFNOHpvSHFrdC9BbWNabkR4MWdsbExMUGtG?=
 =?utf-8?B?QjdwVGx2b1pMaTljOHU2UTZxQlM4cC9nUTVrQ3c3dEFsVUdZYitoQ3M3cmR3?=
 =?utf-8?B?MHVidFdkSFNNWDBmRTdzbk1mQXNoRU1iQnVIN3phV3VrQ1lwMjA1VkJMR3hB?=
 =?utf-8?B?c0tVeFhTNWVuQ3lyMVJpcXRFQVZVcGRxM3NldTRLMjNvRHpqa2p0bFFvYTk0?=
 =?utf-8?B?Zng0aFp5MktKUU82QTZpWWYrUWYydTl2Y0RNY0R2akkyM0RRTG9WNFBrVnpK?=
 =?utf-8?B?RGRlakFmQ1p0c29SWlp3UC85TmlxZFFQTC83ZVpaT2s1cVRreW5QTFV2akxC?=
 =?utf-8?B?QnpOYzcrWmcvODhtc0FwZ2lEdVZDWTNjOEtoeUdhaXFCeTF6d3pNRXJ2NzhO?=
 =?utf-8?B?OVVvODlWSkl5Unk0R3JkNytBRG9GMXdFNUNPRnBDd0diM2xwdGR4Wmxzc3pM?=
 =?utf-8?B?Wno3empsK05TYU1VT0p4dGZzZStFa2szc0g3SEZtRld3MHBQbXExeXc1Rk9y?=
 =?utf-8?B?Z0ZwSzNtdWxZdHQ2akxwNS9qS21scWovOUVMUGVXUUE3N1FRTVk2RHFwZGdI?=
 =?utf-8?B?dE82NHQ2bVJTMkdUTitqTWdsa1B1cEZYZjlmN3hvTVpYRzJnVi9zRkx2Q2pz?=
 =?utf-8?B?SCtSUWhUbW1XQlBFeTNKL1hCTlhuNVpPc09OMlBiMVpZa05HMXJnS00ybVFs?=
 =?utf-8?B?Wk5nbzdjSHBKMVpxbFJ5a3ZoZTZLNE42dFN0SnFOZ2orVUVJNmErd3prdWNr?=
 =?utf-8?B?UTRqNi9WOGR0YnppRm96MnBNT1N6NExXenJRRnk0OXNsWlhKbUtwT2pwUEgv?=
 =?utf-8?B?YlEzTjEyT0o5NGg4WWprYlFUV3JESGE1bnY5a09WZnRCSTEyNVIxc2ZyVFVN?=
 =?utf-8?B?WGwyNm1DRWtDcDFaWWVMQlNaUjFpSnQ3S2J5Skt2MXBoczZJU0pTZzFxV3Fu?=
 =?utf-8?B?ZENjdTd3WjArTjlVeXllS3IyTURJNFdKbHhrQVltS0V2d1pFelpuem01WjEx?=
 =?utf-8?B?dkFnakhNVVMwdXNPVzZZQktxRkQreXpvWHBuZ2JEQXJpa0dxbnFSd3ErNVdz?=
 =?utf-8?B?TnFQNVZxWkhQRjlrRFN2bWw0ZjlXbDNmZUVaSkhxZnBZblhZbjB2WTdQeExF?=
 =?utf-8?B?d01qVmZaUzJNTVRydU51Sy9xUTh2S0NCUmtLeEVKQTJScUVhUm8zZmpRNmxw?=
 =?utf-8?B?UDJBUEUzZ1gzUnBsTDE4U2JxVXltTGpBK1ZzK3pCWEprT1AyVTJMcGFNcVhQ?=
 =?utf-8?B?YVIrUDJWVmp5ZHVIRE1vcXp5NERIWmwzUzI0dDV5UWdWbmJQTXhlSkFYU2xj?=
 =?utf-8?B?RFFLYjM4anQ1dlBSUm9ZZlhYcGwwellFaWo0STgwb2lMbzBCSnArWmpuTTRZ?=
 =?utf-8?B?Rnc5azNndWhoaTZlTmRvMjZzK3RlMXRJYTlVam5zamw1SkI3bFJIUnc3WTEy?=
 =?utf-8?B?VUQ4aTdxQi8yWEFjOHdXRGdTS2NTNFNyMURKVlNmS3FISysxb21lWS9PSUhN?=
 =?utf-8?B?NURYTktyZE10KzBLckRGQWN4NzRoWkZmNHlxdWJ0cFBmRG91VXVxMUkzSkE4?=
 =?utf-8?B?dmZ4L3l1bVZpTzRreVIyRVpTcWN4VjVvVUxxVWo3RlBLNVBBclFvUWRqSTI3?=
 =?utf-8?B?SVZKK20wcHdrZWRlREhQbmorRVBxZlhta0djVHVpdVVsaVU5Qkd5a1dXRlEz?=
 =?utf-8?B?S2Zna0hOVm1JUFJ1dG1lbjdvOTVLeEd5c3JDbzc1elFhTHpuYXkrak82a1Na?=
 =?utf-8?B?UnF1YVVnTzlIeHh4M3R5TktPV1MvNjgzSzh5eGZoMlVXWGlsQTEwQVNneDNC?=
 =?utf-8?B?RDBHbEhCejhrZWhSbTVhdz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH8PR11MB6879.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d0IxK1hUeWwxdG9QZ3E3djBSQWc4dUljSmpJY1kza0FZUU5veUZRWThJNTc2?=
 =?utf-8?B?ME1weDc1OFFUM0pLaUYzY2EzRnlXRGZSa2dYbDg4ai80dWVaZzJtTi9pOFNk?=
 =?utf-8?B?eTg1ejcyOWZxR3JCOTRvdXNIc0pURlF1WkwwOFVqb2FEZ0dTVjg3WGRod1or?=
 =?utf-8?B?bXFTb0RYcDdxa29KeVgzWm1NN2tNeDViY3JMb0hhNjFIYy9hNXB2MUxpeVBw?=
 =?utf-8?B?L1EyZXVNWnZwdlpXV0hpbTJjRFZWYXRhVTgvdU0vVTQ5dFU2RVJzN1pLRjhn?=
 =?utf-8?B?VUxUeUJaYkkrWnZMdFpIcWxLdVNBRTU3L1hvTWFiQWlWaVUxSC9rNVBlbC9m?=
 =?utf-8?B?cjV2R2ZqNUJnNUdiM2Z4dGgwWWhpZ1RpUlVVWkR6VUk5Qm1YUG04SmZaeXVI?=
 =?utf-8?B?dFZXdlFxV1RDL1IxNE44aW01NmRqbzBnT1JJRWJVeUt0UG91Z3FRMi9CUnFu?=
 =?utf-8?B?ZlFsVFZ5czI1aDZXY2l1aXBQaEkvZTljem91TnUxcjFaVTVyZlJRYWRWRm54?=
 =?utf-8?B?VmRrREFkOWdYVEJRejhBQWR5akVaLzdyTm9Nc1hRc1VFWmxmMjNtbEpMaHFW?=
 =?utf-8?B?Y01peVdHSXFFa2QzazljNXpiTTB3Mnk4dlhZelNkL0hJWGppTmJDa2pJVlRp?=
 =?utf-8?B?cUdoblRRTnQvRDU5SjZwSjFwK0NtZkF3NkF1Wjkxb2ptSlZmQ0pEWG8zK0pZ?=
 =?utf-8?B?OWRWa1hIUkV2eEw0WnczL3VLN0MxSU9uNzFxVHVHZTRUVDgvWEluNllzN1RH?=
 =?utf-8?B?VUtGSmE3RVU2eHpNYTJUc0F5RXVSc1FUajVUNVZaR0lBQ3U0ZUpqanQzQjkx?=
 =?utf-8?B?cmRDaW02dWVicXMrMnAxQkt6VVg3UWdlSm5qNWJ2VFh0dlhXU2pCVVNybEpC?=
 =?utf-8?B?ZU8rS2x2dHg3d3BpbnU1RVR5c1ZLenptdFNwYURaMjRleW5jMjkrZ01Xd01X?=
 =?utf-8?B?VnY1bTlyeDZVZTN3RC9Jd3AxcUR4VnNmMkRhV0JjUEVRMC9GV2s4dGZMRis3?=
 =?utf-8?B?Sm5JbHFuSlBKQU54VHpRa1FnVWRLdW5iODFQQWZnbzh2TUtETGdEYjRTMThD?=
 =?utf-8?B?Ri9GU3VaSXRJbkM3NTJ5T0tpYlBOMnEraVd3ZEhvYUVnYkhIUFZaUDZqaGUw?=
 =?utf-8?B?SDRvTmY5ZlQvUlp0ZXhDdkNBT3hVYVpnTWpNWFNrbTBIbXlaUlhmRXdNeTlE?=
 =?utf-8?B?NG5wOXVwR2xCT0ZDQ1ltb3ZYVURkT3lrSUFsdE82ZCt3aDFRNUM1aUFlZzlr?=
 =?utf-8?B?VTRFS3RtVXdWMjFYNEw1QmF3VE9JOVF0RkhTaEE3Q0NqcS9jSFlIMEhKdmkv?=
 =?utf-8?B?cnlUTFdlQnZ0KzVtUXJ5RmhPcFhWaVpJWHZ0NGd1RmxGNndmclQxWVpPS2V2?=
 =?utf-8?B?c0N0NnNLbkVxa0ZOWlh0YXZXSUkxaGUrK1pNaVJ3SVNBc2VpdWlrYndna29D?=
 =?utf-8?B?c0hFeTkrSnhpNk5xWXVWeko4TU1jakNZUk5qekk0SzNid013WkxVQVBqc2Vy?=
 =?utf-8?B?blloVm1BcVlBNVpZY3o1eWFzQ2ZiaGE1OFdmZWFCTE40VTBYeUxpZlRjZVhj?=
 =?utf-8?B?aDEyRmU0YTBHdVd5TXlsbW03V3U5c3R5UFFIS25nQjJUQzljY1NPMU12SDh2?=
 =?utf-8?B?V2l3eHNsQWhVbC9ZQTF3V2lsRi80RTVTMk9scnV5OUovWjhWUndOK3lWY2R2?=
 =?utf-8?B?RjFGUkNnWGFvdVFyemtjU05HMS9NMkg3R2FVd2wvb0Z4TjN1L3ZlTEkweVVN?=
 =?utf-8?B?QVZ5cTRxbWhsTk1XWFl6bkJYL3Q0WXpkM3g4RzlVOWxvdW1BaTRDcXNUVVEz?=
 =?utf-8?B?TGUzZVRROGMzbFgzQTBRU2xvbnllU3Nnd2Yvc1Q5ZjN2VW5Yb2RhajFVMTY3?=
 =?utf-8?B?ZFVlVEtkWWJFZGJHMFBGdGRmbzhjTG1QcFF2NUVpS1dLQnVwRHFlM282ZlA2?=
 =?utf-8?B?TUlrTlRyWFVFRUV1RXVZS3ZjWndqZG1DWFRTK3Q5cnVmU0t4UEM2YStoK1Bt?=
 =?utf-8?B?c2QvRzEwZkxIWmgwODFtUzEzTmpac3NOd2ZMZHpqOFh3S3FKcmpJSEpYTXQw?=
 =?utf-8?B?TUI0THdELzNtY1BXYXk0cHlMVDJEQW1MUThNd3lHRy90cGMwc3djTkpZSDBo?=
 =?utf-8?Q?v6Yhm+OmKSI8Ga27LyhFQYTFI?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bc9bb46-22c2-4bf8-04ea-08dc9ac25a48
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6879.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2024 18:11:11.0092 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MYKgXzM+yTRHKCZZBIPSugZvLSoY2ER0JAtTEJxqHxHPrvKgJNkLEgJU5k31CwZh4G0VGdra2OoPNYBci1liVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6957
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.20; envelope-from=dongwon.kim@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

Hi Marc-André,

On 7/2/2024 3:29 AM, Marc-André Lureau wrote:
> Hi
> 
> On Fri, Jun 21, 2024 at 3:20 AM <dongwon.kim@intel.com 
> <mailto:dongwon.kim@intel.com>> wrote:
> 
>     From: Dongwon Kim <dongwon.kim@intel.com <mailto:dongwon.kim@intel.com>>
> 
>     Introducing new virtio-gpu param, 'render_sync' when guest scanout blob
>     is used (blob=true). The new param is used to specify when to start
>     rendering a guest scanout frame.
> 
>     By default (and so far) rendering of the guest frame is started in
>     the draw event to make sure guest display update is sychronized with
>     host's vsync. But this method inevitably brings some extra wait because
>     most of time, the draw event is not happening right after the guest
>     scanout frame is flushed.
> 
> 
>     This delay often makes the guest stuck at certain frame for too long and
>     causes general performance degradation of graphic workloads on the
>     guest's
>     side especially when the display update rate is high. This unwanted perf
>     drop can be reduced if the guest scanout frame is rendered as soon
>     as it is
>     flushed through 'VIRTIO_GPU_CMD_RESOURCE_FLUSH' msg. The gl display
>     pipeline can be unblocked a lot earlier in this case so that guest can
>     move to the next display frame right away.
> 
>     However, this "asynchrounous" render mode may cause some waste of
>     resources
>     as the guest could produce more frames than what are actually displayed
>     on the host display. This is similar as running rendering apps with
>     no vblank
>     or vsync option. This is why this feature should stay as optional.
> 
> 
> Indeed, I don't see much point in doing so, it's pure waste. If you want 
> to benchmark something perhaps. But then, why not simply run a benchmark 
> offscreen?

Benchmark score is not the primary reason. The problem we want to avoid 
is the laggy display update due to too many asynchronous plane updates 
happening in the guest in certain situations like when moving SW mouse 
cursor rigorously on the guest. This is because the fence (as well as 
response for the resource-flush cmd) is signaled in the draw event.

> 
> 
>     The param 'render_sync' is set to 'true' by default and this is in line
>     with traditional way while setting it to 'false' is basically enabling
>     this asynchronouse mode.
> 
> 
> As it stands now, the option should actually be on the display backend 
> (gtk/gtk-egl), it's not implemented for other backends.

We can help to deploy this concept to other backends if needed.

> 
> I am not convinced this is generally useful to be an extra option though.

I initially thought this should be the default because the virtio-gpu 
guest should not be hold by the host for too long in any cases. And this 
new approach is comparable to the default mode with blob=false where the 
guest is released as soon as the resource flush is done. Only difference 
is the resource synchronization using the fence.

> 
>     Dongwon Kim (4):
>        hw/display/virtio-gpu: Introducing render_sync param
>        ui/egl-helpers: Consolidates create-sync and create-fence
>        ui/gtk-egl: Start rendering of guest blob scanout if render_sync is
>          off
>        ui/gtk-gl-draw: Start rendering of guest blob scanout if render_sync
>          is off
> 
>       include/hw/virtio/virtio-gpu.h  |  3 ++
>       include/ui/dmabuf.h             |  4 +-
>       include/ui/egl-helpers.h        |  3 +-
>       hw/display/vhost-user-gpu.c     |  3 +-
>       hw/display/virtio-gpu-udmabuf.c |  3 +-
>       hw/display/virtio-gpu.c         |  2 +
>       hw/vfio/display.c               |  3 +-
>       ui/dbus-listener.c              |  2 +-
>       ui/dmabuf.c                     | 11 +++-
>       ui/egl-helpers.c                | 27 ++++------
>       ui/gtk-egl.c                    | 93 ++++++++++++++++++---------------
>       ui/gtk-gl-area.c                | 90 +++++++++++++++++++------------
>       12 files changed, 146 insertions(+), 98 deletions(-)
> 
>     -- 
>     2.34.1
> 
> 
> 
> 
> -- 
> Marc-André Lureau


