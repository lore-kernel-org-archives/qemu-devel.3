Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3DF2D111B3
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 06:58:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t7r2p-0005GZ-6R; Mon, 04 Nov 2024 01:58:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1t7r2l-0005GR-Te
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 01:58:32 -0500
Received: from mgamail.intel.com ([198.175.65.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1t7r2i-0002BJ-8r
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 01:58:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1730703508; x=1762239508;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=4G2MVOvWBAfxaIxr6wzrppzrkzw0AGTJ7fEHCjBcwYU=;
 b=L1ks5GnY2CQeP6e10Ify7L+vW+ENyDtFos86P0O6srLbdMfdEpmSrvS9
 M4xrB0EFYJg/YMn8ggKGcvlqk8HSw/vxf0PIbniTYoLs3R7QmZ/pkvlm2
 s4GIuqRNl2b8dzGVwFYWUckl2IKfCwrOPnBnRGO+HJ75B1wkOKxenLDkT
 DOPf9hLcefRWB6dmkeIo74KYSSaBn3MIpdqy6Q5W46IkeJcXrlCeQ+K25
 3/xsjUYLpNz7MrcNnsv8TWx5ywbW82EBLNvdGHFzcnCw22m+YZi68t8P2
 FBRLtMxiqtlpadsUf/1NiTtajWGCkbB8EQQMx8+P1eMRhvx4+QK2TL+H4 A==;
X-CSE-ConnectionGUID: O1jWnnPbQ6KcYqjSo/FTSQ==
X-CSE-MsgGUID: nEVTlft7TGO8Cgz+LWOK4g==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="47851442"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; d="scan'208";a="47851442"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Nov 2024 22:58:26 -0800
X-CSE-ConnectionGUID: sFFq9thORROre9sKd48X8Q==
X-CSE-MsgGUID: Qve0j4LzRF6ASTKHfk0xzw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,256,1725346800"; d="scan'208";a="88695529"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
 by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 03 Nov 2024 22:58:26 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 3 Nov 2024 22:58:25 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Sun, 3 Nov 2024 22:58:25 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.175)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sun, 3 Nov 2024 22:58:24 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xW35C648usIPn42CLUjVrc4S7O185rophzXpLyzYL8nzIXQTVQebHFWDK7G1Mq7yln0nYuEuEfOYuJtK49783thkmXHretEjHosfm9/22GqohqtVeEz7eX0I3vdN7yBxyFzcwYr54cyLWNVGPpEkajZ03BO+r3iRC0aCwVhWgDXy7K/8LQ5uyZDz9l7HPSYjaaQjmKsHckiSqE9yStg/5rGv5HDD6N+C/IihaZGbvPUxWq9744INucf2kclRTfreMlxCMyoDQOlR6U58kaHYPpmn2EOCKFdKOeGd01mAcHQIpqca68aJyj38X16twQ+iOFDcRIBrzkf0GHB/S/dEkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ome2DimRlxZ9X3R7dwaukgVYXEQMLraIwjXJOo0Wsww=;
 b=LVe3RhUi+0MJR94btQphUmDQvyU6k4Y2pNJYLVdBHxPxSiavT7UGRzu2e3+Pjy9jcRcnmSJFTUWyGBxNyvPicFHocQfKeyuoMok2sG21Z+ZGe9Ud04rLH49MLr2OF3DmOe3cJ1FovSRFAA07f9L4/dHmQqssgtKKP/wOGaDRmWqT9GBETWoksU3+i0yazxxSiI2LxMFcOYFNdDgGIhZA7LGKx+y4vecGgWTYyrGL7Tu2qBJvr6n8W2d0pLFB1wJQtp9ccCtbvOIRI5P0Ly7V/vvHIMw9ZF7/f3A9WT2Pmp8x1xDqnNOic63RPT9H1bDyWHo2TfEzQvRsuGn4B/Lq0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by SN7PR11MB6875.namprd11.prod.outlook.com (2603:10b6:806:2a6::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.29; Mon, 4 Nov
 2024 06:58:22 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a%6]) with mapi id 15.20.8114.028; Mon, 4 Nov 2024
 06:58:22 +0000
Message-ID: <8640dcb7-1196-4935-82f2-136f66379c29@intel.com>
Date: Mon, 4 Nov 2024 15:02:53 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 06/17] intel_iommu: Implement stage-1 translation
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>, "eric.auger@redhat.com"
 <eric.auger@redhat.com>, "mst@redhat.com" <mst@redhat.com>,
 "peterx@redhat.com" <peterx@redhat.com>, "jasowang@redhat.com"
 <jasowang@redhat.com>, "jgg@nvidia.com" <jgg@nvidia.com>,
 "nicolinc@nvidia.com" <nicolinc@nvidia.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "clement.mathieu--drif@eviden.com"
 <clement.mathieu--drif@eviden.com>, "Tian, Kevin" <kevin.tian@intel.com>,
 "Peng, Chao P" <chao.p.peng@intel.com>, Yi Sun <yi.y.sun@linux.intel.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
References: <20240930092631.2997543-1-zhenzhong.duan@intel.com>
 <20240930092631.2997543-7-zhenzhong.duan@intel.com>
 <750c9440-b787-4500-b039-a4827e5d7d20@intel.com>
 <SJ0PR11MB6744A33C0CB281D832E809EA92512@SJ0PR11MB6744.namprd11.prod.outlook.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <SJ0PR11MB6744A33C0CB281D832E809EA92512@SJ0PR11MB6744.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR04CA0009.apcprd04.prod.outlook.com
 (2603:1096:4:197::8) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|SN7PR11MB6875:EE_
X-MS-Office365-Filtering-Correlation-Id: f9ccb34c-2435-4fb7-e51d-08dcfc9e1226
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cndZSjNJb1Exa0lZRE5SOTVrL0hvdmc5NTYwVEsxYy9BN2FNUGVqcHhzVHNE?=
 =?utf-8?B?anQ2amVNN0taODNDUU5OSlpQd2FLQnhiOG1ob0J4Y3BsUHNSempZeXM1N2o0?=
 =?utf-8?B?OEtaNmtvWC9lT2EwSWVRS3RuaVNOcmlDS0hBYUNLOUVSSmx5S0tvaW5qRldm?=
 =?utf-8?B?UmVqSnd4cXdWckhIVklhWlJsUGdBenpRaUJqaGF3a25TWkVMQWpiUUJTRUhF?=
 =?utf-8?B?RVg1OVZTaEtVeElWYVN0N2dCamZQcm1TV3VQOXhDaDA0N09PUnZURTRjZ3c5?=
 =?utf-8?B?V2dzbG1uTWpXVnpFTVhKLzZKOGRmUXpNU3hhTUh3cjBMbWQ5cE1GN0pVVHNn?=
 =?utf-8?B?RDNvUmltWWphYjlhVFF0OUVDVmRsUmMrcVI3MHdnZWhWYkR1KytaVVZyUHlm?=
 =?utf-8?B?b0pndml5UjY3NENTOEVnNlMrU0NmVWpFdWN2TFRkeFZJNHJoWDNqZlc3eFZR?=
 =?utf-8?B?SWhQM0V1Mm5FYlRyaEdsdVlGdFhrdWVHMENYc1R5dDFGRFpGZlJhQStjOVM1?=
 =?utf-8?B?cHZ1VGlmZzdsU3BnVWk2QnFQOHh1SmpSTDRzcHlhQmRRdWU5alQ2a3lyemIz?=
 =?utf-8?B?dDJkYlBxR0pudEVuVXBKL2pWQ0RwTmpEN3NFWTl5Ly9TTDQvRHpXc3NXbmx2?=
 =?utf-8?B?cDRHMUJYKzB6SXI1NUVwV1AyM3hYNGluS3NIWkhUUDB1bnptVDNZcyttL2xV?=
 =?utf-8?B?TjNkZ2VEbUJvRm5lUnlTRVM4NDBESzQrSEVBY2NYbnJkTGcxTjRIUk5VeURP?=
 =?utf-8?B?UHhMZDBCb3JscStrMGE1aE9xVlBTZ2MrRmYxMUg5SnhRQW52TGIxaGZBcHlr?=
 =?utf-8?B?TE9ZOENtUjZpVWNNOVcrb3ZleXc5blFmUWlpMCtDcXVRa053QXlFS0J4cngz?=
 =?utf-8?B?YVhxY0czM05Ba0ZCNzlqQVdaYkI2QUg4TWtqTXlQRERFamR3YTJYaWpHYm1K?=
 =?utf-8?B?SkN5cFJnQ0xybE8yVE1TY2VUUmU3K08vZVRMZEwyekhpY016RGhTbVRrQzJV?=
 =?utf-8?B?UFlHdWhISkVCdmpKdTBpMVF3YkMrQlJQS3pRZ2dGZ09iVkZyWXVVajhHeEN2?=
 =?utf-8?B?ZjNzVzRaL1IyVEZHNXNXbFo4SVpjalNKN2N0SEh6OG1acUR6ZVVHeUNGV25J?=
 =?utf-8?B?NzNSNDFHWTMrZ1ZSakplalZBQmx4Mlg3Q2VsYWErZVMwZ2V3RENjYjFQTW1O?=
 =?utf-8?B?WXFSWGU2L0lndHNYMlk2ZG90SmkrWWxiRjlrUFk0cXVyRWFiZUYyVjVEaTdy?=
 =?utf-8?B?c3hIMlBlRGowSlV6LytPYUl1NktXQTdScWxEL3ZrOWllTUtBdkY3SXlBUEJz?=
 =?utf-8?B?dmxTU3dEbWM5OEZoMjZkTEdXOWJWczQ0bi9jRnhDQ3VONlZkMmdNaGlWc05I?=
 =?utf-8?B?OFFYd2UwaTg3aFkxMG4vM2lLWnAyYkFQeWJpREFPaGRVZHkzYTI3VEN3UEg3?=
 =?utf-8?B?SlpyM3dBMzBST0VjWDJXUmJ1ZmhxcE81V0w3UlNmb093dHhma3hoSTVQcGxQ?=
 =?utf-8?B?dDZUd0JPQnNEVE4zVHVTbGNDWmFTTTF0ZE14bWo0bDEyODdaSndrL0gxdTV2?=
 =?utf-8?B?bVJjTGIreVJiR2E4akQ0VVdEdnRMbHpQdENKRDhlc2hoQ1BuSzR0U1dHcUpq?=
 =?utf-8?B?bUhROHh4TDlBS2RpNmlRSnkrMkdTTnZuVUpvUVpkVmFoNWRwOGRqVXhTL3U1?=
 =?utf-8?B?ODBqQVpRbVRlTzRGdXI4NEYwbTU1WTV6RFhBcjcvRXdSditnN21hVXlxNnpw?=
 =?utf-8?Q?7HeGeQuGnNbyRibJ3k=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7529.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dVpxbkRzVTdRK2lGQUppclY3RHRmV2xHaThXRUhhbkYyV0Y2SURxdkxIR2pV?=
 =?utf-8?B?b1ZqTjRPK0tDR3N3UjlCOThsZjliYS9oK3RuZVI1dmRsRGZib1hEVGpSODZw?=
 =?utf-8?B?bFJZbFhxL3FDWmhXb0kyY3h4OHYxNFdCYS9ackVrVVZteVg0b1hTQ1l5aXlr?=
 =?utf-8?B?OG4ycWtLRU5rVVdIdDY0NWViL0Q2ZHBZQkkrLzJqN1BsUGRJVXdEby84NnF0?=
 =?utf-8?B?a044YUpwRUNaOWNXcVNhVmN3MHNFb0RabmZHa0dMY3JnWnc3UnRSM05SaXFN?=
 =?utf-8?B?ZlI1dzZZSVZiSmhWOUV0VzE0ZVk2NFJ1V0oyNU9kOFNreUxKSjBCMUJ5cEx6?=
 =?utf-8?B?WnpSOExPakFMYThma29pM3FHdzVmUGFCRktYbkFtakRKQlNwSEp3eW9jOGd4?=
 =?utf-8?B?a0Vab0tVbFN6Zi9oSzdxTUZuYWxtRnFTdXZEeDRzTkpXWm5LR0lZVHlCdlpQ?=
 =?utf-8?B?QnZKR3FFQ25IQld6VUZCc3ZsSkFsVnVqN3gxcGl5M2ZtUG1YYndTUHJVLzdx?=
 =?utf-8?B?bjloaEpQcjNDd0RDS2hKYTVUUDF6WVJpZEYrQTdqdDkrdlNVbFFlcHlNcTNW?=
 =?utf-8?B?SWpTcWUrMHZnaC9FeHdaUnJoNFRPT1V0Z21TbjdFUW9rSmxKem9FOXNKVWU2?=
 =?utf-8?B?bWp4dkxuZEJ5bTNFemlXbmNkWG9uU0lkQURuWlM3RW1EaXMzS1FtUHZJZ0l1?=
 =?utf-8?B?THg5UjlnMEJLK3VvWlY5Rnc0T1ozZCtZcGh4aU1rTmhGY2VMQkJBbHZrbHFS?=
 =?utf-8?B?SDl2Z1ZhMjZJOVdnbXZydkFmVFRGSDdWWkpsMTdCNmYzdlVrUnZtbTFxa0Ew?=
 =?utf-8?B?UTNNeVFUb0h6WFdLbzVzclM4ODhRbVA3STJqOHlzZ3ppVmtrWTVORGJxeWJO?=
 =?utf-8?B?dVNKVVZMSW9tZy9UQUcyODZ0L1IwbnhjV21vQ1dNQWd1K2ZLWXA4S2RHVU5Q?=
 =?utf-8?B?VUxrc0tCQlI2Z2haS0dyV2QyQ2FyZHZvTkkyOGVCdjZUTkZyb015Z1htMkt0?=
 =?utf-8?B?N012N00rWFVlL1k4dlo2WGxFWHh5Vmc2eWc2aG55MS9QM1RWTzdJMm9yUGRv?=
 =?utf-8?B?NVFvV2JjMDNqbUd6MXdUcldhTTBWZURFcEV4WmFlTnl2QUdpMDZhOHZDRkkv?=
 =?utf-8?B?WlNCYzVQUTRORXNqWSt4MGFmZHB5b0N6azJVTHJ3NW9TSnpNT3dDakptaVU5?=
 =?utf-8?B?NUxNZTNEN2Rnakp1ZTdXWm01bTQxbER6NnpXNjVibkFzTEE3MUxKbjdsVVNR?=
 =?utf-8?B?dkV2ZGdYQWNQc3Z6emNXdE4zU0tQanAzVjhrYld0aCsrcVBISERaNnNCY0RZ?=
 =?utf-8?B?VWRSSmFFQ0FvQ0ZFMW9mMkp4SkJqazJLWHpUUXcxeTB1UkNvclVvTlk4Z1RQ?=
 =?utf-8?B?dzlSNHZ1WVo5M2ZYL2V5dDBTWTJEOFZJaHVwRTBmYjA4UjlBZjZBdW5NY0Jm?=
 =?utf-8?B?RTFXdjl6VnZ5dVlvRUNtcmtmaXJTclBtVmtrUllIK0xvdUF2anl6V2pCWVZt?=
 =?utf-8?B?T0ppUjRQSlU5Ty9sWktWck5JajUyaWo1L0xYOWlGUUUxWW1GanFRaE1JaFRM?=
 =?utf-8?B?a3FPTlNOTU9mWUxNKzJEZ2RmT2gvRmViS1luekdlMHpnZlZHRWlReHdaSjJJ?=
 =?utf-8?B?R1JFOVVzeXM2M2FJSmorcHBJeUg3Q0dNVHA2K2V3cC8vMlpWNVM3UFdRS1k0?=
 =?utf-8?B?QzE3K2lYV2FzSmFQUjV1SDJDKzVmbVJpeEljTUtyQTBuWHlwWUJhYTRSV3Ju?=
 =?utf-8?B?VmhyU04zMW9UYlZFZHluZ0N1bmVWMTNxd09uTHlEKzZIdUhycnVqQVl0WkhY?=
 =?utf-8?B?QStoYm51KzBVeWpSZmRIUm5qR01TMFA2eVVxbkg1R0swREcvNDlkM3dNYkJN?=
 =?utf-8?B?ZmlsRW90RFZ2bXplQkJGMytYOFFsWFZHeHlkejJxdnRIVWk3Q0I3KzdzeEx4?=
 =?utf-8?B?ZlVwY3IwR3JWMGNyOWg2cXNsM3NaTDZoRzF4aUNUQTRtdktXdGxxdGRPYkt4?=
 =?utf-8?B?M0NOajlLanNqU0dxMlhxeTBuZ3h6RlpmNU1JMUJUZ0VnRTM3aU5BWm1JZ0dl?=
 =?utf-8?B?cFZ5Q1ZkNnI3K3NQbzR1UmZyeEVTZDJ6dy9qc1YvK2dZVGN0YkZ0eVFrT1pp?=
 =?utf-8?Q?Mm9YptACQDjC9tqKuqFBzfFyl?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f9ccb34c-2435-4fb7-e51d-08dcfc9e1226
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2024 06:58:22.0539 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Fey/1Ajr869mI+Yo3E4+NF8dZ1xhLMMU0WXmzZdjxq3QDwAdjHOAL1JqKfzSo9NOJadxThZ06nNwZdK+1qFERQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6875
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.10; envelope-from=yi.l.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
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

On 2024/11/4 11:05, Duan, Zhenzhong wrote:
> 
> 
>> -----Original Message-----
>> From: Liu, Yi L <yi.l.liu@intel.com>
>> Sent: Sunday, November 3, 2024 10:22 PM
>> Subject: Re: [PATCH v4 06/17] intel_iommu: Implement stage-1 translation
>>
>> On 2024/9/30 17:26, Zhenzhong Duan wrote:
>>> From: Yi Liu <yi.l.liu@intel.com>
>>>
>>> This adds stage-1 page table walking to support stage-1 only
>>> translation in scalable modern mode.
>>>
>>> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
>>> Co-developed-by: Clément Mathieu--Drif <clement.mathieu--drif@eviden.com>
>>> Signed-off-by: Clément Mathieu--Drif <clement.mathieu--drif@eviden.com>
>>> Signed-off-by: Yi Sun <yi.y.sun@linux.intel.com>
>>> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
>>> Acked-by: Jason Wang <jasowang@redhat.com>
>>> ---
>>>    hw/i386/intel_iommu_internal.h |  24 ++++++
>>>    hw/i386/intel_iommu.c          | 143 ++++++++++++++++++++++++++++++++-
>>>    2 files changed, 163 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_internal.h
>>> index 20fcc73938..38bf0c7a06 100644
>>> --- a/hw/i386/intel_iommu_internal.h
>>> +++ b/hw/i386/intel_iommu_internal.h
>>> @@ -428,6 +428,22 @@ typedef union VTDInvDesc VTDInvDesc;
>>>    #define VTD_SPTE_LPAGE_L3_RSVD_MASK(aw) \
>>>            (0x3ffff800ULL | ~(VTD_HAW_MASK(aw) | VTD_SL_IGN_COM))
>>>
>>> +/* Rsvd field masks for fpte */
>>> +#define VTD_FS_UPPER_IGNORED 0xfff0000000000000ULL
>>> +#define VTD_FPTE_PAGE_L1_RSVD_MASK(aw) \
>>> +        (~(VTD_HAW_MASK(aw) | VTD_FS_UPPER_IGNORED))
>>> +#define VTD_FPTE_PAGE_L2_RSVD_MASK(aw) \
>>> +        (~(VTD_HAW_MASK(aw) | VTD_FS_UPPER_IGNORED))
>>> +#define VTD_FPTE_PAGE_L3_RSVD_MASK(aw) \
>>> +        (~(VTD_HAW_MASK(aw) | VTD_FS_UPPER_IGNORED))
>>> +#define VTD_FPTE_PAGE_L4_RSVD_MASK(aw) \
>>> +        (0x80ULL | ~(VTD_HAW_MASK(aw) | VTD_FS_UPPER_IGNORED))
>>> +
>>> +#define VTD_FPTE_LPAGE_L2_RSVD_MASK(aw) \
>>> +        (0x1fe000ULL | ~(VTD_HAW_MASK(aw) | VTD_FS_UPPER_IGNORED))
>>> +#define VTD_FPTE_LPAGE_L3_RSVD_MASK(aw) \
>>> +        (0x3fffe000ULL | ~(VTD_HAW_MASK(aw) | VTD_FS_UPPER_IGNORED))
>>> +
>>>    /* Masks for PIOTLB Invalidate Descriptor */
>>>    #define VTD_INV_DESC_PIOTLB_G             (3ULL << 4)
>>>    #define VTD_INV_DESC_PIOTLB_ALL_IN_PASID  (2ULL << 4)
>>> @@ -520,6 +536,14 @@ typedef struct VTDRootEntry VTDRootEntry;
>>>    #define VTD_SM_PASID_ENTRY_AW          7ULL /* Adjusted guest-address-
>> width */
>>>    #define VTD_SM_PASID_ENTRY_DID(val)    ((val) & VTD_DOMAIN_ID_MASK)
>>>
>>> +#define VTD_SM_PASID_ENTRY_FLPM          3ULL
>>> +#define VTD_SM_PASID_ENTRY_FLPTPTR       (~0xfffULL)
>>> +
>>> +/* First Level Paging Structure */
>>> +/* Masks for First Level Paging Entry */
>>> +#define VTD_FL_P                    1ULL
>>> +#define VTD_FL_RW                   (1ULL << 1)
>>> +
>>>    /* Second Level Page Translation Pointer*/
>>>    #define VTD_SM_PASID_ENTRY_SLPTPTR     (~0xfffULL)
>>>
>>> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
>>> index 6f2414898c..56d5933e93 100644
>>> --- a/hw/i386/intel_iommu.c
>>> +++ b/hw/i386/intel_iommu.c
>>> @@ -48,6 +48,8 @@
>>>
>>>    /* pe operations */
>>>    #define VTD_PE_GET_TYPE(pe) ((pe)->val[0] & VTD_SM_PASID_ENTRY_PGTT)
>>> +#define VTD_PE_GET_FL_LEVEL(pe) \
>>> +    (4 + (((pe)->val[2] >> 2) & VTD_SM_PASID_ENTRY_FLPM))
>>>    #define VTD_PE_GET_SL_LEVEL(pe) \
>>>        (2 + (((pe)->val[0] >> 2) & VTD_SM_PASID_ENTRY_AW))
>>>
>>> @@ -755,6 +757,11 @@ static inline bool
>> vtd_is_sl_level_supported(IntelIOMMUState *s, uint32_t level)
>>>               (1ULL << (level - 2 + VTD_CAP_SAGAW_SHIFT));
>>>    }
>>>
>>> +static inline bool vtd_is_fl_level_supported(IntelIOMMUState *s, uint32_t
>> level)
>>> +{
>>> +    return level == VTD_PML4_LEVEL;
>>> +}
>>> +
>>>    /* Return true if check passed, otherwise false */
>>>    static inline bool vtd_pe_type_check(X86IOMMUState *x86_iommu,
>>>                                         VTDPASIDEntry *pe)
>>> @@ -838,6 +845,11 @@ static int
>> vtd_get_pe_in_pasid_leaf_table(IntelIOMMUState *s,
>>>                return -VTD_FR_PASID_TABLE_ENTRY_INV;
>>>        }
>>>
>>> +    if (pgtt == VTD_SM_PASID_ENTRY_FLT &&
>>> +        !vtd_is_fl_level_supported(s, VTD_PE_GET_FL_LEVEL(pe))) {
>>> +            return -VTD_FR_PASID_TABLE_ENTRY_INV;
>>> +    }
>>> +
>>>        return 0;
>>>    }
>>>
>>> @@ -973,7 +985,11 @@ static uint32_t vtd_get_iova_level(IntelIOMMUState
>> *s,
>>>
>>>        if (s->root_scalable) {
>>>            vtd_ce_get_rid2pasid_entry(s, ce, &pe, pasid);
>>> -        return VTD_PE_GET_SL_LEVEL(&pe);
>>> +        if (s->scalable_modern) {
>>> +            return VTD_PE_GET_FL_LEVEL(&pe);
>>> +        } else {
>>> +            return VTD_PE_GET_SL_LEVEL(&pe);
>>> +        }
>>>        }
>>>
>>>        return vtd_ce_get_level(ce);
>>> @@ -1060,7 +1076,11 @@ static dma_addr_t
>> vtd_get_iova_pgtbl_base(IntelIOMMUState *s,
>>>
>>>        if (s->root_scalable) {
>>>            vtd_ce_get_rid2pasid_entry(s, ce, &pe, pasid);
>>> -        return pe.val[0] & VTD_SM_PASID_ENTRY_SLPTPTR;
>>> +        if (s->scalable_modern) {
>>> +            return pe.val[2] & VTD_SM_PASID_ENTRY_FLPTPTR;
>>> +        } else {
>>> +            return pe.val[0] & VTD_SM_PASID_ENTRY_SLPTPTR;
>>> +        }
>>>        }
>>>
>>>        return vtd_ce_get_slpt_base(ce);
>>> @@ -1862,6 +1882,104 @@ out:
>>>        trace_vtd_pt_enable_fast_path(source_id, success);
>>>    }
>>>
>>> +/*
>>> + * Rsvd field masks for fpte:
>>> + *     vtd_fpte_rsvd 4k pages
>>> + *     vtd_fpte_rsvd_large large pages
>>> + *
>>> + * We support only 4-level page tables.
>>> + */
>>> +#define VTD_FPTE_RSVD_LEN 5
>>> +static uint64_t vtd_fpte_rsvd[VTD_FPTE_RSVD_LEN];
>>> +static uint64_t vtd_fpte_rsvd_large[VTD_FPTE_RSVD_LEN];
>>> +
>>> +static bool vtd_flpte_nonzero_rsvd(uint64_t flpte, uint32_t level)
>>> +{
>>> +    uint64_t rsvd_mask;
>>> +
>>> +    /*
>>> +     * We should have caught a guest-mis-programmed level earlier,
>>> +     * via vtd_is_fl_level_supported.
>>> +     */
>>> +    assert(level < VTD_FPTE_RSVD_LEN);
>>> +    /*
>>> +     * Zero level doesn't exist. The smallest level is VTD_PT_LEVEL=1 and
>>> +     * checked by vtd_is_last_pte().
>>> +     */
>>> +    assert(level);
>>> +
>>> +    if ((level == VTD_PD_LEVEL || level == VTD_PDP_LEVEL) &&
>>> +        (flpte & VTD_PT_PAGE_SIZE_MASK)) {
>>> +        /* large page */
>>> +        rsvd_mask = vtd_fpte_rsvd_large[level];
>>> +    } else {
>>> +        rsvd_mask = vtd_fpte_rsvd[level];
>>> +    }
>>> +
>>> +    return flpte & rsvd_mask;
>>> +}
>>> +
>>> +static inline bool vtd_flpte_present(uint64_t flpte)
>>> +{
>>> +    return !!(flpte & VTD_FL_P);
>>> +}
>>> +
>>> +/*
>>> + * Given the @iova, get relevant @flptep. @flpte_level will be the last level
>>> + * of the translation, can be used for deciding the size of large page.
>>> + */
>>> +static int vtd_iova_to_flpte(IntelIOMMUState *s, VTDContextEntry *ce,
>>> +                             uint64_t iova, bool is_write,
>>> +                             uint64_t *flptep, uint32_t *flpte_level,
>>> +                             bool *reads, bool *writes, uint8_t aw_bits,
>>> +                             uint32_t pasid)
>>> +{
>>> +    dma_addr_t addr = vtd_get_iova_pgtbl_base(s, ce, pasid);
>>> +    uint32_t level = vtd_get_iova_level(s, ce, pasid);
>>> +    uint32_t offset;
>>> +    uint64_t flpte;
>>> +
>>> +    while (true) {
>>> +        offset = vtd_iova_level_offset(iova, level);
>>> +        flpte = vtd_get_pte(addr, offset);
>>> +
>>> +        if (flpte == (uint64_t)-1) {
>>> +            if (level == vtd_get_iova_level(s, ce, pasid)) {
>>> +                /* Invalid programming of context-entry */
>>> +                return -VTD_FR_CONTEXT_ENTRY_INV;
>>> +            } else {
>>> +                return -VTD_FR_PAGING_ENTRY_INV;
>>> +            }
>>> +        }
>>> +        if (!vtd_flpte_present(flpte)) {
>>> +            *reads = false;
>>> +            *writes = false;
>>> +            return -VTD_FR_PAGING_ENTRY_INV;
>>> +        }
>>> +        *reads = true;
>>> +        *writes = (*writes) && (flpte & VTD_FL_RW);
>>> +        if (is_write && !(flpte & VTD_FL_RW)) {
>>> +            return -VTD_FR_WRITE;
>>> +        }
>>> +        if (vtd_flpte_nonzero_rsvd(flpte, level)) {
>>> +            error_report_once("%s: detected flpte reserved non-zero "
>>> +                              "iova=0x%" PRIx64 ", level=0x%" PRIx32
>>> +                              "flpte=0x%" PRIx64 ", pasid=0x%" PRIX32 ")",
>>> +                              __func__, iova, level, flpte, pasid);
>>> +            return -VTD_FR_PAGING_ENTRY_RSVD;
>>> +        }
>>> +
>>> +        if (vtd_is_last_pte(flpte, level)) {
>>> +            *flptep = flpte;
>>> +            *flpte_level = level;
>>> +            return 0;
>>> +        }
>>> +
>>> +        addr = vtd_get_pte_addr(flpte, aw_bits);
>>> +        level--;
>>> +    }
>>
>> As I replied in last version, it should check the ir range for the
>> translation result. I saw your reply, but that only covers the input
>> address, my comment is about the output addr.
>>
>> [1]
>> https://lore.kernel.org/qemu-
>> devel/SJ0PR11MB6744D2B572D278DAF8BF267692762@SJ0PR11MB6744.nampr
>> d11.prod.outlook.com/
> 
> Oh, I see, you are right! As the check for ir range is common for both stage-2 and stage-1,
> I plan to move it to common place with a separate patch like below, let me know if you
> prefer to have separate check for both stage-2 and stage-1.

checking it in the common place is ok.

> 
> --- a/hw/i386/intel_iommu.c
> +++ b/hw/i386/intel_iommu.c
> @@ -1235,7 +1235,6 @@ static int vtd_iova_to_slpte(IntelIOMMUState *s, VTDContextEntry *ce,
>       uint32_t offset;
>       uint64_t slpte;
>       uint64_t access_right_check;
> -    uint64_t xlat, size;
> 
>       if (!vtd_iova_sl_range_check(s, iova, ce, aw_bits, pasid)) {
>           error_report_once("%s: detected IOVA overflow (iova=0x%" PRIx64 ","
> @@ -1288,28 +1287,7 @@ static int vtd_iova_to_slpte(IntelIOMMUState *s, VTDContextEntry *ce,
>           level--;
>       }
> 
> -    xlat = vtd_get_pte_addr(*slptep, aw_bits);
> -    size = ~vtd_pt_level_page_mask(level) + 1;
> -
> -    /*
> -     * From VT-d spec 3.14: Untranslated requests and translation
> -     * requests that result in an address in the interrupt range will be
> -     * blocked with condition code LGN.4 or SGN.8.
> -     */
> -    if ((xlat > VTD_INTERRUPT_ADDR_LAST ||
> -         xlat + size - 1 < VTD_INTERRUPT_ADDR_FIRST)) {
> -        return 0;
> -    } else {
> -        error_report_once("%s: xlat address is in interrupt range "
> -                          "(iova=0x%" PRIx64 ", level=0x%" PRIx32 ", "
> -                          "slpte=0x%" PRIx64 ", write=%d, "
> -                          "xlat=0x%" PRIx64 ", size=0x%" PRIx64 ", "
> -                          "pasid=0x%" PRIx32 ")",
> -                          __func__, iova, level, slpte, is_write,
> -                          xlat, size, pasid);
> -        return s->scalable_mode ? -VTD_FR_SM_INTERRUPT_ADDR :
> -                                  -VTD_FR_INTERRUPT_ADDR;
> -    }
> +    return 0;
>   }
> 
>   typedef int (*vtd_page_walk_hook)(const IOMMUTLBEvent *event, void *private);
> @@ -2201,6 +2179,7 @@ static bool vtd_do_iommu_translate(VTDAddressSpace *vtd_as, PCIBus *bus,
>       uint8_t access_flags, pgtt;
>       bool rid2pasid = (pasid == PCI_NO_PASID) && s->root_scalable;
>       VTDIOTLBEntry *iotlb_entry;
> +    uint64_t xlat, size;
> 
>       /*
>        * We have standalone memory region for interrupt addresses, we
> @@ -2312,6 +2291,29 @@ static bool vtd_do_iommu_translate(VTDAddressSpace *vtd_as, PCIBus *bus,
>                                      &reads, &writes, s->aw_bits, pasid);
>           pgtt = VTD_SM_PASID_ENTRY_SLT;
>       }
> +    if (!ret_fr) {
> +        xlat = vtd_get_pte_addr(pte, s->aw_bits);
> +        size = ~vtd_pt_level_page_mask(level) + 1;
> +
> +        /*
> +         * From VT-d spec 3.14: Untranslated requests and translation
> +         * requests that result in an address in the interrupt range will be
> +         * blocked with condition code LGN.4 or SGN.8.
> +         */
> +        if ((xlat <= VTD_INTERRUPT_ADDR_LAST &&
> +             xlat + size - 1 >= VTD_INTERRUPT_ADDR_FIRST)) {
> +            error_report_once("%s: xlat address is in interrupt range "
> +                              "(iova=0x%" PRIx64 ", level=0x%" PRIx32 ", "
> +                              "pte=0x%" PRIx64 ", write=%d, "
> +                              "xlat=0x%" PRIx64 ", size=0x%" PRIx64 ", "
> +                              "pasid=0x%" PRIx32 ")",
> +                              __func__, addr, level, pte, is_write,
> +                              xlat, size, pasid);
> +            ret_fr = s->scalable_mode ? -VTD_FR_SM_INTERRUPT_ADDR :
> +                                        -VTD_FR_INTERRUPT_ADDR;
> +        }
> +    }
> +
>       if (ret_fr) {
>           vtd_report_fault(s, -ret_fr, is_fpd_set, source_id,
>                            addr, is_write, pasid != PCI_NO_PASID, pasid);

-- 
Regards,
Yi Liu

