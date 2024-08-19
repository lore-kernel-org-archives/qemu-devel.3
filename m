Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22BB4C3DA4A
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2024 09:32:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sfyji-0001y4-0m; Mon, 19 Aug 2024 05:31:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1sfyjf-0001xC-HK
 for qemu-devel@nongnu.org; Mon, 19 Aug 2024 05:31:35 -0400
Received: from mgamail.intel.com ([198.175.65.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1sfyjc-0005z8-Pw
 for qemu-devel@nongnu.org; Mon, 19 Aug 2024 05:31:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1724059893; x=1755595893;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=5acONWrCrWoWHY4Jfgjeg0ak+tE8YcDUwKHJWDoSpXI=;
 b=PrLHZQ12D24E6uGnLVIIf1ikAF9m1HdO/XMSz/DtLs/yRi7Hq0n8FUrA
 8Kjuw82td+l59vqab9/NclQ9Z5bjBwYK9/eJhYGz8KXfxyJ30EylGtNcu
 VktOqQf/yA2ku/QtewmV/ubxp0eU8DX2uTN1dyOHAUbHKSOBqMbaR1LWi
 evFQHx61vhUw0PfQsEpn86kPPLMtdAPWnxv2kpw8P+df2fY5S4TQcf8ZH
 zZSUIE5xhIUBNXNBqsHGlVZ20g/w6aIrwuW1X3uXZ1/zzWPegWOX0qy5p
 Y1R7XcXuzX9/aFCfQS5p3Tbt7cD6pZNNNM2JHFkTvJpOSHw5ElO7nq+HN A==;
X-CSE-ConnectionGUID: eJwOpnHOSbGF66WcI8OdVQ==
X-CSE-MsgGUID: Sy+p9xO/R2q8kHzRDrrl1Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11168"; a="39757367"
X-IronPort-AV: E=Sophos;i="6.10,158,1719903600"; d="scan'208";a="39757367"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Aug 2024 02:31:28 -0700
X-CSE-ConnectionGUID: TJj89K98Sb6WulfiI8yuPw==
X-CSE-MsgGUID: Zy91+ZPGQCuPbL9qlP8Ixw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,158,1719903600"; d="scan'208";a="97800296"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
 by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 19 Aug 2024 02:31:26 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 19 Aug 2024 02:31:27 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 19 Aug 2024 02:31:26 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 19 Aug 2024 02:31:26 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.49) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 19 Aug 2024 02:31:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qIo4NlWSFcYR9Qqcho+asv9C7chhqJjbYO6nT68vOfY9X/4XJ6j7m6fF5Mw1ryUH1q9ImnIuA3LzYO6hVDXemy8/BQ2SEU/ckpWvqVnxoF6hhXXN9Sk5vX/BbYMktjH96NKUR3R+ejyzW2F86SXjT+65etqU8Ptu7KjuPgNnuQOT1mIOm/chOfS3SUywCq+C3hRF8h4otSc6C3cEeO8Nhnl40OLxWZxQQheYL+O1Jr0xnzxleiYYbv/I/R97IcYu5dnWJFQ7dekOOGKLNG5f6AL47T5W3bKfLMfqZw8/uLz5W3qQXgwRZdrdP8RSZ/nJ8PbdDfFjqhulfvBvb3oyZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KY3mJk2Xdiu9fH3JfVGAFPzl9bb6k2bG/fyR0CMqv6Q=;
 b=Egape4XNtgwh13RyFT59M0iSVRc0xUzr8q++8JkgTS8+wZcLNVbF7Pv3mdBNBryxO+HeaJ4IjgOQeF8E6CrDvIO4utQLI8fcLPefriEStG+uxSCNUCmHpTJWwCrtdJXf2JMEQ3lr7N2F7E6laxBvi9Up2mBFtBRVP7JGEs1tZO2lBzBnLylAM4zAtrdALE0JTZIhHWyV8YL4tn8Ii7E7yJ9LR5KBQgHIhHU1BIHwQY9VTgsiLnqZKhknMDKUFSZXZXjiotwWrBsF3eh1+PDG+vWH/4mP8d0PPEI3vpkhyt6qHttkeZtdOJrtiFKYXQRP2OwBDVmgf6fya7CQR/eTRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by SJ0PR11MB5918.namprd11.prod.outlook.com (2603:10b6:a03:42c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.17; Mon, 19 Aug
 2024 09:31:19 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a%3]) with mapi id 15.20.7875.019; Mon, 19 Aug 2024
 09:31:17 +0000
Message-ID: <1a3d2c06-1c73-4b4d-a531-bd39007088d9@intel.com>
Date: Mon, 19 Aug 2024 17:35:29 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 13/17] intel_iommu: piotlb invalidation should notify
 unmap
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, <qemu-devel@nongnu.org>
CC: <alex.williamson@redhat.com>, <clg@redhat.com>, <eric.auger@redhat.com>,
 <mst@redhat.com>, <peterx@redhat.com>, <jasowang@redhat.com>,
 <jgg@nvidia.com>, <nicolinc@nvidia.com>, <joao.m.martins@oracle.com>,
 <clement.mathieu--drif@eviden.com>, <kevin.tian@intel.com>,
 <chao.p.peng@intel.com>, Paolo Bonzini <pbonzini@redhat.com>, "Richard
 Henderson" <richard.henderson@linaro.org>, Eduardo Habkost
 <eduardo@habkost.net>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
References: <20240805062727.2307552-1-zhenzhong.duan@intel.com>
 <20240805062727.2307552-14-zhenzhong.duan@intel.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <20240805062727.2307552-14-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR01CA0142.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::22) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|SJ0PR11MB5918:EE_
X-MS-Office365-Filtering-Correlation-Id: 971171bb-5e91-4e2e-514a-08dcc031ad10
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dXFxR05LbWRmTTJmbFBFRC9PNUdOV2Q4U3h0V2FsYkVIQUR4SitGWDlxMXIv?=
 =?utf-8?B?b0tOcmhTeGdjM3N6S2JPVUpOOWZ4VmdDZHhhaWhLdHhvRGZOTVdtejNvdnk3?=
 =?utf-8?B?SnFXU0IzdUh4dllqKzR2NmJSRWprUXVubnFkMGVRcjlZSDNWRUw2eURKc2dN?=
 =?utf-8?B?MHMxK1h4VE1LdEdFVFRYRkRaM0EwbEdyb1dsUVhoeDlUQ0pxZVl6N1lmKzFN?=
 =?utf-8?B?b1REVFVGSThKVDFNWmlFbDBYSG9QZ0hBSnFDbmx4STZWVmRRelRLMG9JYjlZ?=
 =?utf-8?B?TUVTR2xucUs2YzJvcVhkQmdoKytXNWFCcW56ZVdUN1NjSERVSnd6QzJoZmNa?=
 =?utf-8?B?Y08vRmVlekI1MVM3eVczSFF1MVJ2MW1sc3JHVmk2OWpjUGhMcVhUUjdRSmlY?=
 =?utf-8?B?ak1lQXVhUXBkRG5iZW8rdzBrMndwL1pOdk5rTkF4QU5wRnE1c3RXSWxmUzRZ?=
 =?utf-8?B?RmtBU1o0dUErTkhKT2tWY3E2QTVNc01vSTRWL0RWczRjM0hENEpRVERoUWRH?=
 =?utf-8?B?Ni9QNnlQQ1hjL0x5SytiMEloWmx3NnQ2S1ppT3lsTU1JUnd0OTA3OTNpSDFD?=
 =?utf-8?B?dkxMR0grNzJHb3FKMDdnKzhlOHZQSmtzcDFXSUR1M3B6aGNCbjRlT28zTDVy?=
 =?utf-8?B?elMwcFdBTThSRzBZQ1pxcmlQMGtsekMxamtOd2hIZ01qdm1TYytBdlE1WHdn?=
 =?utf-8?B?cHRTTm93LzBXalk1NGtiZ2UrMkZNUU1RN3dPVnZCMGFUQXR6UVZMS0FYN2VY?=
 =?utf-8?B?QUQvNWV1THIwcHpTOUNNblRlTzRlelVYbit2dWdpdXlnMnVNMXhrVVFyMGlX?=
 =?utf-8?B?Q2lLaWpYc041WStDUWZadThlamVESXA5dmpJYU12a0tqRlFsRFlsK3NIOEFM?=
 =?utf-8?B?MHlOLytoaDhJd0F0YTNYSEJzdUhLZjFmMUtpVmE4WlJDVXViWTBlQXV1aDdw?=
 =?utf-8?B?c2NPTEVkZDgvVW1FS2FZcVdvVGRsYmo3QzhtMTVNS1FienZpYmdaSHpxNExJ?=
 =?utf-8?B?MVlObGh1SHdKdE80L3dZaXRLcHFIRG5NbDZab3pSak5GRERhKy9hRVdWajlR?=
 =?utf-8?B?cENZeHdGakd2cm55ZCt6MEZhejhrNS9BWEhML1RBM0RNM0pwTmVTcmdjUXVy?=
 =?utf-8?B?UzZGclRyUzZtcGpMRjhtd2E1V1lmRWVSdFhqNVgwUk1aSkRkVmQvVmJ1VmJo?=
 =?utf-8?B?d0lWa1ZJZldCam1XaG1xZmxBZklSbHZES2NtNTF6dm5wc1c0QWIxZmdKNDJP?=
 =?utf-8?B?Zm5qclVMWTF3NTJzSWFWRThYRXJEK28yemhaQ05Ma1YzQWp6L3pERm5MWlp2?=
 =?utf-8?B?NW56bk8vQmcwL2ZvQmdoN09GS0Q1NFJibEJyR1Nyb3NLMEtVQ3c3ZzczRGNt?=
 =?utf-8?B?djNMYTRucHhXajEzSHJGMHdqSkFyeWpJZVdQQVhzYXZ5YkpQUVRuZHFPSXRy?=
 =?utf-8?B?bWUxdnJ0NzVIYjNZbmJKWVRtcUQ2a05NMnRhd2lXWnN2UmRCSS9UeW9SdXRF?=
 =?utf-8?B?alVXQ2srZHhhZW45N3FFK3JDWk9DdVBxeGRTcjh0Z0M3OGZpeU0xWWNZQkpO?=
 =?utf-8?B?RDAvMXFUb3ZXcERFK3FCVjZXU1ZOMEl6OWs0RGxaemdkeEEyNXFrRjd6UWx5?=
 =?utf-8?B?ZEFWbmRnRGlSOUlBVGcxbmZjZ3ZkcS9jV3RLZm9xVURHbFZkLzMzeXhlYWRU?=
 =?utf-8?B?NlorQk1OT0JrblZyTnJkUmJrRVV6aW9HRFpGV3A0YlpYNkp4Mm1wMXZGVUZi?=
 =?utf-8?B?Nld1WTU0dFdJRDFvZlpKbTlKckw3akFXdEZ0QjlIMGdUaHZuNW9YQkNVaUtD?=
 =?utf-8?B?aFVRcHRLcFVPeDlOVTlmZz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7529.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d0phbFhnWHE1T1MrZzdhY3IvWGNqMzNuV01TNDhDWElZRGV1b056TVBmdVQ3?=
 =?utf-8?B?REN2QTN6UFZJU205eDJ5WHNyeDFWUUZrb2lkemEzdnFWTGViRHQvckRhcHBV?=
 =?utf-8?B?MG0wa1BVSXFsUUIxejcxMzBlTkE3eDRHWE9XSTVyRmxzb1hnME5LTzMvL3hh?=
 =?utf-8?B?QldvZ3AwNHN6aHVVZkl2SW0zR3RhSy9tSVE2OEhuY3pCRWdMbGRVREluVXVM?=
 =?utf-8?B?S2E4d01ZRFEwcVhIYmVORTg1T2NwQkJGckI3MHFoVEtDVEIwWE95K0I4UjNl?=
 =?utf-8?B?M3BwcUdjTGZTbHpLQ0kxWk5YQ2dnTFdqWmVFQ2pIVEFoVnJQblQ2YmdrZzFr?=
 =?utf-8?B?YnkvZWdaTmhxNFhCVDVOZms0M0tMQncwK084MVhHZUl1RnlNNHVGM2VLVm5H?=
 =?utf-8?B?dW1DQUlrMm4xekxYQzBOT0dnU0RGUmRZalJkSURZd1R3OXJtWUErMEIweXdu?=
 =?utf-8?B?eUNpNEZGS3AwT2VtYklFaEF3VE15b0tBTGZkaXBlYVdDOU5RV3VHNVRCV1hq?=
 =?utf-8?B?QURaVWg1TG8yejBUQjVUS2lqY1ZkZUxBOUhZWlNleW8rN3VNZUYyOEw5cGVV?=
 =?utf-8?B?MStrbVJQTnlGTjNscjhla24rQnZnRHM2MnBkOWI5bzNmcEdHQzYyNzQ5KzMr?=
 =?utf-8?B?cWNyN0lHRFRCNVkyYlBUM1AxS3VNUW45K3VXSkFJaU5DMDVlb0lGbStuM1Jv?=
 =?utf-8?B?cU02WTJKTmhMTkVHZUxZa2RkWHpKUXhaRk50TW1tYW11WkhyLzBzaGFUL1g2?=
 =?utf-8?B?QllWUDJkb2xUV2x4YUJGUDBMb0lNdFZWZFFadkpsZCs0T3FUYnVUVUtQWnQ5?=
 =?utf-8?B?MmVLaVlLZmVSdmtLOHZrWFluQ1JjeWNZKzJmcjl0NlZ1U3ZueXg1QlVLVFJF?=
 =?utf-8?B?TjZwcXhaQVhqVFZ1Sk13Q0JZUUZOVnZJTFVZQnpXL2cwSVVRdUpBMnhxNmlD?=
 =?utf-8?B?VEpNRmoxZVI0Z242Rm5KQkhCR0o0b2I3MitZSEFsU3RGdUJaWkxvcmNjUGxy?=
 =?utf-8?B?S0JkOXBkNHpHZ2NpRGMrdGo1TjdkSGg5TWorMEZVLzFZRVFBNS9UdklpU3dh?=
 =?utf-8?B?OFI3cmE1R0hYRGhIVHcvZGVtK3hiQzlwRkQ0SFE5U1k4eWp2Q2VVdkdlL2Zh?=
 =?utf-8?B?RzhtRFVKdW93NlVLM1RKV291L3lKQ1B2R0pOMit5clpwazRIdWgxSXdxNGoz?=
 =?utf-8?B?YUZ0NE9ROFkrN2lFdWJQa2tOWmF2clNHbURQZjFFY2c0UGpkUllVU0taT0Ni?=
 =?utf-8?B?VmxQNHNsQnVtNkg4U21IdnZKeERvdUl6WkdSem4wUko1TEJtR1QyMXlsV2Zm?=
 =?utf-8?B?VVVsL3BNdkl5U1RUZGl0dkxzREVkcTdoVEc1TTB3NEpEaFRlU0dPRXAwOWlp?=
 =?utf-8?B?OEpqdWkrZVo4UUM4Wi9rVUhWWjJyVHdvNE5JZC8zaVE5elhhak0yL1BOYjJK?=
 =?utf-8?B?TDhMcG1CNldlRzQvRGdBWXd1K21SdjN2VDZCNExCZEw4dlNUNEh0QjVkVDFL?=
 =?utf-8?B?UVBYVXZsdi9mcVArd3oyYkcvd0lydWhXVERpOW1Ka0ZXOUk1RjF5dEcvY0RM?=
 =?utf-8?B?ZTVlNlRVTGRNZWdCUkJ4a2I4ek1OaGZVUlVKUWNVNkxFbndqdmVobGVDcHBK?=
 =?utf-8?B?cnR5UmZubldtdTFiNkFJNFpuZGw3Wm05N1IxR0FiY0pFdzFnOVA4UjJWblZH?=
 =?utf-8?B?R0hLMy9tSGJRaFc4ZHRwQUk4Y0VLbE9tS01iYkh6QlIvcStYRUZBekZIL2Zu?=
 =?utf-8?B?dy9SZVJJa20wRTI3blhLYWo2R3QrZWxFN2ZoaktGNGdUWlk0S3p2V0FTNjJC?=
 =?utf-8?B?R3BHWW5EU3J3VW9GZGRzSENOTjBaS2VxQXgwN3Q3UTZrMTJPSkM5aXAyR1VT?=
 =?utf-8?B?ZW9wczRRWlBJYnhIS1ovWkhFS01LOWhvMndIMGFMV0cwTnJnT05DQlRyZmZw?=
 =?utf-8?B?dnFEMlIyeHZ0MXkyaG9RUHExaW5lVDVnU1k0ajhPeko3SzNNVGdmaVN3YnQ1?=
 =?utf-8?B?MWYvelBlQzNXZlo4R09zc1l1MUN5ME5Ldnc2aU9EUkpNL1M4a2VIZDU2MTRE?=
 =?utf-8?B?OW80VUh2Y2lBY09BeW91ZUl5SjhuR0FQcnBFOGh0RXRzWS9GYWZ2cjV0Y1NG?=
 =?utf-8?Q?gdShmtj1efybq8a75NwEn7rQR?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 971171bb-5e91-4e2e-514a-08dcc031ad10
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2024 09:31:17.2119 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3wU7pBAFOhZ6kBFG025vr8dMhYtKY5zpK5B40I7LQS4RY3Z6A9FzBfGH1YXWtZLiae596K8mD9q/Iz0oIeOS9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5918
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.10; envelope-from=yi.l.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 2024/8/5 14:27, Zhenzhong Duan wrote:
> This is used by some emulated devices which caches address
> translation result. When piotlb invalidation issued in guest,
> those caches should be refreshed.

Perhaps I have asked it in the before. :) To me, such emulated devices
should implement an ATS-capability. You may mention the devices that
does not implement ATS-capability, but caches the translation result,
and note that it is better to implement ATS cap if there is need to
cache the translation request.

> 
> Signed-off-by: Yi Sun <yi.y.sun@linux.intel.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> Reviewed-by: Clément Mathieu--Drif<clement.mathieu--drif@eviden.com>
> ---
>   hw/i386/intel_iommu.c | 35 ++++++++++++++++++++++++++++++++++-
>   1 file changed, 34 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> index fa00f85fd7..317e630e08 100644
> --- a/hw/i386/intel_iommu.c
> +++ b/hw/i386/intel_iommu.c
> @@ -2907,7 +2907,7 @@ static void vtd_piotlb_pasid_invalidate(IntelIOMMUState *s,
>                   continue;
>               }
>   
> -            if (!s->scalable_modern) {
> +            if (!s->scalable_modern || !vtd_as_has_map_notifier(vtd_as)) {
>                   vtd_address_space_sync(vtd_as);
>               }
>           }
> @@ -2919,6 +2919,9 @@ static void vtd_piotlb_page_invalidate(IntelIOMMUState *s, uint16_t domain_id,
>                                          bool ih)
>   {
>       VTDIOTLBPageInvInfo info;
> +    VTDAddressSpace *vtd_as;
> +    VTDContextEntry ce;
> +    hwaddr size = (1 << am) * VTD_PAGE_SIZE;
>   
>       info.domain_id = domain_id;
>       info.pasid = pasid;
> @@ -2929,6 +2932,36 @@ static void vtd_piotlb_page_invalidate(IntelIOMMUState *s, uint16_t domain_id,
>       g_hash_table_foreach_remove(s->iotlb,
>                                   vtd_hash_remove_by_page_piotlb, &info);
>       vtd_iommu_unlock(s);
> +
> +    QLIST_FOREACH(vtd_as, &s->vtd_as_with_notifiers, next) {
> +        if (!vtd_dev_to_context_entry(s, pci_bus_num(vtd_as->bus),
> +                                      vtd_as->devfn, &ce) &&
> +            domain_id == vtd_get_domain_id(s, &ce, vtd_as->pasid)) {
> +            uint32_t rid2pasid = VTD_CE_GET_RID2PASID(&ce);
> +            IOMMUTLBEvent event;
> +
> +            if ((vtd_as->pasid != PCI_NO_PASID || pasid != rid2pasid) &&
> +                vtd_as->pasid != pasid) {
> +                continue;
> +            }
> +
> +            /*
> +             * Page-Selective-within-PASID PASID-based-IOTLB Invalidation
> +             * does not flush stage-2 entries. See spec section 6.5.2.4
> +             */
> +            if (!s->scalable_modern) {
> +                continue;
> +            }
> +
> +            event.type = IOMMU_NOTIFIER_UNMAP;
> +            event.entry.target_as = &address_space_memory;
> +            event.entry.iova = addr;
> +            event.entry.perm = IOMMU_NONE;
> +            event.entry.addr_mask = size - 1;
> +            event.entry.translated_addr = 0;
> +            memory_region_notify_iommu(&vtd_as->iommu, 0, event);
> +        }
> +    }
>   }
>   
>   static bool vtd_process_piotlb_desc(IntelIOMMUState *s,

-- 
Regards,
Yi Liu

