Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E031C52D6F
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Aug 2024 12:28:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sc2G4-0004Ov-9R; Thu, 08 Aug 2024 08:28:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sc2Fr-0003Mg-Pl
 for qemu-devel@nongnu.org; Thu, 08 Aug 2024 08:28:36 -0400
Received: from mgamail.intel.com ([192.198.163.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sc2Fo-00068b-67
 for qemu-devel@nongnu.org; Thu, 08 Aug 2024 08:28:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1723120108; x=1754656108;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=xtZYEN+As3ms4DdstJYCfmOBWPG/ZxE6AwjuIbtZXfY=;
 b=Xr5cA8eCFND84ASpFcBANUGo/6Ep8TUdlNfCfHD2Ym6/1mZJy6cpBe6m
 JWoYGCbeG58kkq9Gwo2faOdkbls/mj61F+Dsm2YTD8dgJ88Y9X5oEWmQx
 RINTe1UmA8RpxUw31ltgwOGp2KFbSWKY6EzZ0E5eOFZxBguIht4vUPTfu
 alXPWKcYcUcbj2KJ5SYLCw8M97dh2WUH5HvDPacKlVFtsUFK+6CzNfXE5
 6RYndqRw2YxAmUhZRYFIp7IdRK8I2kNaBMO8fgZcSPuZoo4jBtnM8xZmh
 FEtZeG1e3UMYxIvH5vLg3H/AyFwTz1SixhF50KYy21HVTVnp9ulC7P3AU w==;
X-CSE-ConnectionGUID: 97vV4KdPT16mIJ7CO4PqZQ==
X-CSE-MsgGUID: XWTjO/DkQU2BSLpXrZbEUA==
X-IronPort-AV: E=McAfee;i="6700,10204,11157"; a="31870707"
X-IronPort-AV: E=Sophos;i="6.09,273,1716274800"; d="scan'208";a="31870707"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Aug 2024 05:28:24 -0700
X-CSE-ConnectionGUID: vLgFZPANTr6w504K5s2kqw==
X-CSE-MsgGUID: yqEEQqBlQOaXlqNMgBQFEg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,273,1716274800"; d="scan'208";a="56881449"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
 by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 08 Aug 2024 05:28:23 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 8 Aug 2024 05:28:22 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 8 Aug 2024 05:28:22 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.49) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 8 Aug 2024 05:28:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iOoV+x3ZFR/p462k/cnwJ4XBNKZBlmm3G432t8A++65lgrD6t1j1MyNhdl5h2W9bQb6rEGn64bor6ZOIImWptwPUtRNo3MkuWUBwUDLdzu0Ct/OA64oGFxrv0TfPdRbaIcuuVJ0PTZCJjEJS1+Xxr3uPwuIN6zdS4FsfLHp+zoxgs6Wfnu33kMoYQqypzWvscHV+Wq2al/d4/9s8GWGleyrCa1g6I1XTl5ufHqcKHsfuulFQpkRmkyEckhxGf3AjhMOyPQUwEiGQYdYdSHnLt96OU5Z2s9cE5WDFKqVHMqf1LE6/hDwgliihnn69JQwTJ4XBPVerbQwO+L9214oEBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ncDnDJZwh8hMMkW+dUsjKVKdEvxThjNFBlkFlMJm2ew=;
 b=wwJ23Xy2Xbb22Ct0mY6wyJut+SzKdL0HDbdYdQMs4F86GgQjrpMZxHnKB4Jo/KFfy8f2MebFCvbCzhwYLBg/1NVUrnlNXy/tpLtD0AXkvGwy/NO1ZUbxFwuHlpdSPt6OuVcJaJ7YcYirNAdcliTNfRwvFHu0E7uC9mW4HXNPbFQ4riSQhf7K0OzsYB/KKq1NHf3OjN63ukbHguPyv3XLl3u3RCBQHjeoW1UXrPvbCO9aCr3S16mHjwUhyQCSh95TbcYfNWbs7Y4bWb1RxczEfVBDjW886nNXDEML4MepXDToxgQsZUEGZAPgOyr0EIpLJosrH7IVA3D0jcyUTaQYVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by PH7PR11MB8598.namprd11.prod.outlook.com (2603:10b6:510:2fd::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.26; Thu, 8 Aug
 2024 12:28:19 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091%6]) with mapi id 15.20.7828.016; Thu, 8 Aug 2024
 12:28:19 +0000
Message-ID: <c3aefa52-6b5f-b8e5-4d63-666c407a6007@intel.com>
Date: Thu, 8 Aug 2024 20:28:06 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v2 15/17] intel_iommu: Modify x-scalable-mode to be string
 option to expose scalable modern mode
To: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>, "eric.auger@redhat.com"
 <eric.auger@redhat.com>, "mst@redhat.com" <mst@redhat.com>,
 "peterx@redhat.com" <peterx@redhat.com>, "jasowang@redhat.com"
 <jasowang@redhat.com>, "jgg@nvidia.com" <jgg@nvidia.com>,
 "nicolinc@nvidia.com" <nicolinc@nvidia.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>, "chao.p.peng@intel.com"
 <chao.p.peng@intel.com>, Paolo Bonzini <pbonzini@redhat.com>, "Richard
 Henderson" <richard.henderson@linaro.org>, Eduardo Habkost
 <eduardo@habkost.net>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
References: <20240805062727.2307552-1-zhenzhong.duan@intel.com>
 <20240805062727.2307552-16-zhenzhong.duan@intel.com>
 <3365817b-2e52-4134-9a24-42a07f05bc4c@eviden.com>
Content-Language: en-US
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
In-Reply-To: <3365817b-2e52-4134-9a24-42a07f05bc4c@eviden.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR01CA0016.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::20) To SJ0PR11MB6744.namprd11.prod.outlook.com
 (2603:10b6:a03:47d::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR11MB6744:EE_|PH7PR11MB8598:EE_
X-MS-Office365-Filtering-Correlation-Id: 39565493-9cba-472c-15d7-08dcb7a595d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RmZpWW43MjdlWDhKUGFIdEh6T1V2cmI1RXJHZkxYMHh6dEhDM2M2TnlwckRI?=
 =?utf-8?B?N2RxZis1Nmt1Y0xqblJyR0wrQ0hHSk9HaC9ocVpNMm1NM0NnZGd4Z1NMd3FF?=
 =?utf-8?B?TjFnZHNTZ2FZMGtPSGZlL0doTVBORlFvMnBoSU1rWVdadURRd3hJeXpUMkh6?=
 =?utf-8?B?cDZMUXovYUdienRKajB6SWRRbFpvcCtRVWdibkNXckNHNTVsZ2VwU3dtNEUy?=
 =?utf-8?B?aGpFRGRyQVc1UFZPN3JMUG9aeEJkSytyWXBBSU5uQ3RYOExLOXd6MnA5OCs1?=
 =?utf-8?B?ZnA3b3IvS0xqTVRwVlVFQjlLTjExMVg2U3dLSEFiZmdFeThxN1lKNlptTDVj?=
 =?utf-8?B?ZE14dWpXOHBoSFZMMXJ6MzNLZlB0Zkx3U1lnOC9SMkFZVDUwMUNOaHhKY0lq?=
 =?utf-8?B?c24yVCtkWktlYkV1WlhVZDRJTFR3NTBvVUgrVXA3elU5dStGeWxwK0Ivc09T?=
 =?utf-8?B?UGpuOTZYZEJQV2FIdFZUL2ZUcXZ5QkMxeWdaUmtnM05IdmgxZkJCbnFIc010?=
 =?utf-8?B?SnBnZVY1dFF2VFF0VnA2K2thSTR1OTFPZWNKYkQrN3h0T2c0SVBLck1OWHVw?=
 =?utf-8?B?M0lhbFZ1Y0Q3cXRXWk1rM0Fmd0twZ2ZBblAwdDhUUStvUmw1VytQMDdJR3dn?=
 =?utf-8?B?ZjZqeUFobkMwQ3B5cVNJSDcrc0lJZXY1TGlPTmlHaDhxdy9kSnh6VnU1SHY0?=
 =?utf-8?B?WmpFRjZkN0RocUEraTBXOEZPc2NkSDU1QUV5eHFJVUVRVTEvWHlPak10N3hm?=
 =?utf-8?B?a25TcExaSlI0REN4dXBGakVOU3E4ZWlGQStxMzFNSm5FYkVkbTFjUEVFUGs5?=
 =?utf-8?B?VDBUc1pRQVQ3bE1wVEJZQkcrMHMvNVhTS2pKdEFTWUVrQnN1NlQwaTVsMWs3?=
 =?utf-8?B?MHEzMlRDNFgyckRLRkVkMkU0dGhTZFBpa21sLy9UeExTYTN3OURMS1dYVC9B?=
 =?utf-8?B?RUJ4U1AxYjZ3Ump6S3RuaUtQRWh0T2pNaEJEZjNLNyt6aXZYM1lvbjdRQmlR?=
 =?utf-8?B?SzRKdEplQnlVSllydVEzTTgrVEdtL3Z4ckxKeWxUTFQ4VGx2UG1ZVFphL1Vn?=
 =?utf-8?B?MW1VUnVLNENDenp6Q2xqOTN1WDE3OXVhSGFZcjRSYlk1ZmhkQmVwNENUcExM?=
 =?utf-8?B?QnIrUUh1UXZVcGdienZPNzZGbzBSbStEZ1VXVDhnb3RBNWRadVo2RHozUDBC?=
 =?utf-8?B?dWdGQ3UyTjIrYjZqek4wSjdwTTQyaUtXQjJjVXN3ekJZUjBaQ0tGSEMyWUpG?=
 =?utf-8?B?NXNINERabUVOZEJqNlE5WFdsK3hQbTh6cHJ5SXVRT1k3TTExMGZLT0VFblU1?=
 =?utf-8?B?dS9LRWlmYlhacGV3VytxUGtTSHlLOStYSmpTTjYrVVVlMHAwRXJOV3A2OTBw?=
 =?utf-8?B?TkUyWGt1YlB1UnRtUm1iK21EdVY2WjZLVFFldG1Jdzc4VkdzTUpqdFdYMXE3?=
 =?utf-8?B?VTcyVFRxcEtFb1Vhbk5QNTlMWmttMFo3anhKTVlCejM3Z3BjRDdaM21HdGlB?=
 =?utf-8?B?NzNkYkRrd0VRNVBhcjBDWTIvMFpickxSUEhhVmZFS044VngyRVN5RE5tRkUv?=
 =?utf-8?B?VFQ5cTFXUnRZZzVDZXBheVl6azZ5YnhHTTJSNGpXVFRCSDg0L2ZJeTFvK1R4?=
 =?utf-8?B?V0VvNXA0blZJZUhNOUYrNTFJeFFVS0hTTzA3WjJMMXpaalcwMzkrdXJrOVZv?=
 =?utf-8?B?ZXBpRlNvN0krWmQwUDE2QnZxWWxDUmJ1TkZ4YTkzN0JyK0R2U25aYjNiNjdI?=
 =?utf-8?B?ZjBnaHdCNm5sak40WDcrbEVJdnBCRVpsc1VZdjZTdE1IQmtReDEwellGSlJx?=
 =?utf-8?B?SlRkQWJ6b0Y5YXdhOXVYZz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WUx1MmdXd3ZSY2NaR0FRK2hXQ3diQm4vcEpkNmExbUlzMllsazVXck01aDZm?=
 =?utf-8?B?czlsK3FwUFl5WFlvL2luTVFGdTE3aHN0c2Z4Zm1jcXhWSllmUkhESVBjM01m?=
 =?utf-8?B?NjkvaUdTSi82dVFyUFdGYmtQeitwdWVzelI2bWxEaUZMMFRXRXpHSWFpWW8x?=
 =?utf-8?B?dVdsUUtTbTZ5RnFpMW4wWW5iU1RwM1NIR3hYWWZRbGEzTnplMTFqZ1BoK1Ra?=
 =?utf-8?B?bXRuM0NsaTcxcXRibGtGdVNGUkM4WFlhaVZrR1lVUGpySXBVa09ZOGIrUXJB?=
 =?utf-8?B?QjcvemhLbzZDVnZPQnVHci9wY3AxaGpnN3Q4TGhTZjhTR2U0SVJmdEluN1BZ?=
 =?utf-8?B?T1U2bytmZkZ6a25NdG56WGp1WkdUejdoeUVEMGkyd0wyV1JVSHVOclB1Z0pq?=
 =?utf-8?B?bHhrdTRqRkwwa1A3YlBGeWhPODc0VmdXWkttMG1DcDNrZUlWTEpjNHpDQURy?=
 =?utf-8?B?eTA0N0cvL29vWE1CN1IzdjdzZGIyK0IxSEQydC84SHlZeFNLOHBscU1yWTRQ?=
 =?utf-8?B?WUpBWW9yU1hYa2xGYnIrUDE1MThsVitDaUJQSjE1ZlAvc2pPa0R5VlhjRGx3?=
 =?utf-8?B?dS9rWlhKL09ubklDUzlxY0hFZXJjakxsVWRxUVBiaXV2aE5xU0wyUlZNODg0?=
 =?utf-8?B?ZjB1ZkRjZ1g2WjJ0b1YzbjNyazNBNDRyd1dTZVlRY1JmTS9DMk9uU2l3RWYw?=
 =?utf-8?B?M1YxZDN2RndnV0NIeWE0UVFlbmNGSTdkUWRkZDJzZjNZMERqL1FwZlU2V1Fw?=
 =?utf-8?B?WW1EWk9jUExzYWFBKzNsYlVoZStnbmc0MHBUUVBBcEdYVlcxMnVQNEdiMkJx?=
 =?utf-8?B?VjdEVkc5OFE0YmVNTFcwbVhDVTU0Z3M3Zm1MVFRVRExlcEFTQVN6QnJCQTNn?=
 =?utf-8?B?ZEtyRU11OG1IWWkwNDEzVDI5cWIxOWtTdm9MNTFHaE02VjQyandUb01QUU5t?=
 =?utf-8?B?Y2NCSUFQQVVLc0s4RUF1OWF4b0lXL2ljNnJaVmVzSnRNNzdsZi9qMGhWNDRH?=
 =?utf-8?B?ZGRKTVBTWUZlNURKTEZlZXNpdW9jc0IyWWUveDVKTTRsTElrVFlRcFgzWmdG?=
 =?utf-8?B?TTU4NTlqSHpSS0xPb2hYcGlwczliQ2pTQmZ6MWJLSDdCeHBnNFRyVnYyVDcz?=
 =?utf-8?B?c2Fjb3lzemFpeDBCUXF4VDN6WWVyVExyYnVnQlhqZzRLNExMMXFWK1A2UFYv?=
 =?utf-8?B?S3Bxd0dtbEZtTm5RRGJGTFNVeW8yUlF3bEVRSE9lR2tYZUtvSk8vODFMTDNW?=
 =?utf-8?B?TE9PWldsZWVWUmZVeE9OQ2krSUFnQ0ZHLzhFUzlpOEswdS80TGJURUltWlF5?=
 =?utf-8?B?WnZCQzkxTG5oYWxNWlVLdHplYU5naEZZdXFCRkpMaVQ3VVA5ejlOU2srWG4y?=
 =?utf-8?B?VnFkVmh4TW1rK3h4MW9TNXdyZnYwdjBvdmVuZ1FQSTkvVTZ1QlorbE9lSE16?=
 =?utf-8?B?Sk8wVWI2dCtVaDJnbEEyRk0wZnoydzFTZXp6YmYzNTZ5STJOZW9WbnpWT0lH?=
 =?utf-8?B?dEluTXJPa2JEWjhhMmJEbHpZMzlZc3FHY3NwNXVtMlcxUGorTThCNG9KSGhh?=
 =?utf-8?B?L2YvL1hvZTY3c1RIMWFkc2RNbzNpcFFuUmtSVTBEeEEzZUVmRjh4bytDbkdT?=
 =?utf-8?B?L0pGNzhaTEJsNDBPV0hMNXhHMWEyc2pPUEU1Z1ZYZS9GbTdtc3FDMW1lcm5w?=
 =?utf-8?B?dzB6TGl4TFM1QVllN2Nac3JkU3QzRUg3TG9HT0gwOS80SzI3TStxa1JQQ2Fx?=
 =?utf-8?B?RUpwY1FoQ1lzalFJWHhqbjYyaWZkZ3d6UWtmU2FZa2hzV240elNMVklZZmxT?=
 =?utf-8?B?Q2hDcVVkaUlicXV3WFRBVERMRHdoTW02TGMydFZ6SlFwNmg0azd1UlZMZ1VF?=
 =?utf-8?B?RkhmbWcrdmpqbUZZeW5MOWRCMTlvM2NiaHM2UVVHR2ladW1ja3dMVG5LNjZs?=
 =?utf-8?B?cEZMZm4vb0NYbEVpc3kvRGF1RDFvUFU2QWcyaWpBWUcwMVgrMWdrd1duWHB1?=
 =?utf-8?B?Z3ZLenVOaFhtdGtMMkxMYkZCWHJxak11WU0wLzYxZEhROXZ0Zk1MYUs0NlN2?=
 =?utf-8?B?OC9PMi95T1ZXSkRwT3NOTGFPUDRKaUZLbngyVlRLZm1pTG5UOFMxSWt5QVh4?=
 =?utf-8?B?RDN4bDliSnprbnhDK0RvSTZnSnRSSjJXTWlxRWd0NkNtOGU5VkNlQzNPb3ly?=
 =?utf-8?B?aWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 39565493-9cba-472c-15d7-08dcb7a595d3
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2024 12:28:19.3651 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QNw1KhomNgDIGZeByVhK1L2joUp42D/SVXchKQQ3pIviyuyK8/vhS754TZP+IpMhqx/FonmCJsCE1/ZYq9X/9P/DrFLXhL8pa6glJurbX2o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8598
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.11;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -69
X-Spam_score: -7.0
X-Spam_bar: -------
X-Spam_report: (-7.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-2.427, RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


On 8/6/2024 2:34 PM, CLEMENT MATHIEU--DRIF wrote:
>
>
> On 05/08/2024 08:27, Zhenzhong Duan wrote:
>> Caution: External email. Do not open attachments or click links, unless this email comes from a known sender and you know the content is safe.
>>
>>
>> From: Yi Liu<yi.l.liu@intel.com>
>>
>> Intel VT-d 3.0 introduces scalable mode, and it has a bunch of capabilities
>> related to scalable mode translation, thus there are multiple combinations.
>> While this vIOMMU implementation wants to simplify it for user by providing
>> typical combinations. User could config it by "x-scalable-mode" option. The
>> usage is as below:
>>
>> "-device intel-iommu,x-scalable-mode=["legacy"|"modern"|"off"]"
>>
>>   - "legacy": gives support for stage-2 page table
>>   - "modern": gives support for stage-1 page table
>>   - "off": no scalable mode support
>>   - any other string, will throw error
>>
>> If x-scalable-mode is not configured, it is equivalent to x-scalable-mode=off.
>>
>> With scalable modern mode exposed to user, also accurate the pasid entry
>> check in vtd_pe_type_check().
>>
>> Signed-off-by: Yi Liu<yi.l.liu@intel.com>
>> Signed-off-by: Yi Sun<yi.y.sun@linux.intel.com>
>> Signed-off-by: Zhenzhong Duan<zhenzhong.duan@intel.com>
>> ---
>>   hw/i386/intel_iommu_internal.h |  2 ++
>>   include/hw/i386/intel_iommu.h  |  1 +
>>   hw/i386/intel_iommu.c          | 46 ++++++++++++++++++++++++++--------
>>   3 files changed, 39 insertions(+), 10 deletions(-)
>>
>> diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_internal.h
>> index 52bdbf3bc5..af99deb4cd 100644
>> --- a/hw/i386/intel_iommu_internal.h
>> +++ b/hw/i386/intel_iommu_internal.h
>> @@ -195,6 +195,7 @@
>>   #define VTD_ECAP_PASID              (1ULL << 40)
>>   #define VTD_ECAP_SMTS               (1ULL << 43)
>>   #define VTD_ECAP_SLTS               (1ULL << 46)
>> +#define VTD_ECAP_FLTS               (1ULL << 47)
>>
>>   /* CAP_REG */
>>   /* (offset >> 4) << 24 */
>> @@ -211,6 +212,7 @@
>>   #define VTD_CAP_SLLPS               ((1ULL << 34) | (1ULL << 35))
>>   #define VTD_CAP_DRAIN_WRITE         (1ULL << 54)
>>   #define VTD_CAP_DRAIN_READ          (1ULL << 55)
>> +#define VTD_CAP_FS1GP               (1ULL << 56)
>>   #define VTD_CAP_DRAIN               (VTD_CAP_DRAIN_READ | VTD_CAP_DRAIN_WRITE)
>>   #define VTD_CAP_CM                  (1ULL << 7)
>>   #define VTD_PASID_ID_SHIFT          20
>> diff --git a/include/hw/i386/intel_iommu.h b/include/hw/i386/intel_iommu.h
>> index 48134bda11..650641544c 100644
>> --- a/include/hw/i386/intel_iommu.h
>> +++ b/include/hw/i386/intel_iommu.h
>> @@ -263,6 +263,7 @@ struct IntelIOMMUState {
>>
>>       bool caching_mode;              /* RO - is cap CM enabled? */
>>       bool scalable_mode;             /* RO - is Scalable Mode supported? */
>> +    char *scalable_mode_str;        /* RO - admin's Scalable Mode config */
>>       bool scalable_modern;           /* RO - is modern SM supported? */
>>       bool snoop_control;             /* RO - is SNP filed supported? */
>>
>> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
>> index 5469ab4f9b..9e973bd710 100644
>> --- a/hw/i386/intel_iommu.c
>> +++ b/hw/i386/intel_iommu.c
>> @@ -803,16 +803,18 @@ static inline bool vtd_is_fl_level_supported(IntelIOMMUState *s, uint32_t level)
>>   }
>>
>>   /* Return true if check passed, otherwise false */
>> -static inline bool vtd_pe_type_check(X86IOMMUState *x86_iommu,
>> -                                     VTDPASIDEntry *pe)
>> +static inline bool vtd_pe_type_check(IntelIOMMUState *s, VTDPASIDEntry *pe)
>>   {
>>       switch (VTD_PE_GET_TYPE(pe)) {
>> -    case VTD_SM_PASID_ENTRY_SLT:
>> -        return true;
>> -    case VTD_SM_PASID_ENTRY_PT:
>> -        return x86_iommu->pt_supported;
>>       case VTD_SM_PASID_ENTRY_FLT:
>> +        return !!(s->ecap & VTD_ECAP_FLTS);
>> +    case VTD_SM_PASID_ENTRY_SLT:
>> +        return !!(s->ecap & VTD_ECAP_SLTS) || !(s->ecap & VTD_ECAP_SMTS);
> Can '!(s->ecap & VTD_ECAP_SMTS)' be evaluated to true in this function 
> event though we have found a pasid entry?

Good suggestion, it's unnecessary, I'll drop that check.

Thanks

Zhenzhong


