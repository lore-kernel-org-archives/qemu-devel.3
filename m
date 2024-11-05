Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 267A7D1CA3A
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2024 06:52:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8DMP-0008Lz-Rq; Tue, 05 Nov 2024 01:48:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1t8DMK-0007v2-26
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 01:48:14 -0500
Received: from mgamail.intel.com ([198.175.65.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1t8DMH-0002ud-IO
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 01:48:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1730789290; x=1762325290;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=nMe/RZ/on1kwoolLIREW8MG0t2uELMFqREFfg2JvTKM=;
 b=EZIkpv0aMbIf+nkL1BL5WKXpRbslCM9YmEtC4QRClcxJ+PBe9yOFH5Xc
 VEJkfyXpC29YnZNxIHHwxQYH2Z4H6lQ16l7G9A/IZkwM1crdyBueMLy6S
 E8uL8pXPybHoG7OHIiaZn7XG+ydPv5kO/C/SqyPUAQKJAIa1M9Ko5kGCc
 EGyarG3Jm3mdvbW+Twe9JFXdWKqITXDuJGyCRPIVJUAra9ndAzNTuGgPx
 8kNmcag4UshtotCePloPutXByaHQ179EmVfexdz//6YOvEY+e7/kqBqil
 Mzo8e8dT72QEQOblp1BznBffDJi5x33m/5wZOobms+7KSI9NLcy3kEpT3 A==;
X-CSE-ConnectionGUID: Nd3TmnjxTa23adc5LXLgng==
X-CSE-MsgGUID: +L5xb6oNS8GA+ozP7Uuo3Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11246"; a="34301105"
X-IronPort-AV: E=Sophos;i="6.11,259,1725346800"; d="scan'208";a="34301105"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Nov 2024 22:48:08 -0800
X-CSE-ConnectionGUID: tjo+9ipmTZWU7e6EgUxfMQ==
X-CSE-MsgGUID: wTQv0fgLRHSK2uANhQZXFA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,259,1725346800"; d="scan'208";a="84711950"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
 by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 04 Nov 2024 22:48:07 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 4 Nov 2024 22:48:07 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 4 Nov 2024 22:48:07 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.176)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 4 Nov 2024 22:48:07 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XQrHqR54Mlvk9piuDCDNmpgLZskQj26bcAWZv2FKQeLVBiEc9JiWdOBtahU4a8Ldmir5OQEiUxBhCd0Vd4dnFen4e4je+0kE+R5Q7EfWPEk5Bt6ETbJ8cud7ylYami7MIjR3OM3LNwvh9OG84moErxpwTB2ZjvJ7a+5LjgO5PQTinshytIgWcMP3gLMskKiXlsx6rZqpZ2kojTE/K4rYsSmb6JZZS9cXMBRSwiNnJWgj7pbjK7Tw3Ku2kUELQf+q4E+VgYFd85bdpWqLYtjfs8hWXN1Lc194TMug6d4jNX6FonJhGeV+pEQ4F/WvyqAiWBfK3C8zUKl0j8uLm4zKpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nh/CI6+qowSjbltvWH0J5xo9BJBh0Wg2hkX5a+mSrw8=;
 b=Di8Vt0Ld9kwwFz3zdrByBB77VQa5sIgjCZEFaCp635fUb0A9IktxfU2rd8El+6hMaIagds1SsUK0FJGoTnfyJ4zngRxepi74Qv3qCNgcRJ3m4WQh1HUfCyT2i7woAgJPey1l/XoB4l8e+htl5q027OLGUtQTDa5VNpUuOO4V3p7UCwO4LSssY/K30SAkjNgo4Ls8YYCQ2f5ozvyJd3o1rw/3uJd+08R0vKWPoP1WkMNln1xqG7wxoUSFbcrdxBscbZZY+sssRrp3SNv5WWi3XFJViWdJaM51LRViRX/ihHU+Ma8JxeKUX5Csxmdw6hWqrfuoC7wqYg0I2i3CC/8f1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by SA1PR11MB8595.namprd11.prod.outlook.com (2603:10b6:806:3a9::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30; Tue, 5 Nov
 2024 06:48:04 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a%6]) with mapi id 15.20.8114.028; Tue, 5 Nov 2024
 06:48:04 +0000
Message-ID: <8c6cf228-a024-41d7-ad9d-57a28ea91b29@intel.com>
Date: Tue, 5 Nov 2024 14:52:41 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] intel_iommu: Send IQE event when setting reserved bit
 in IQT_TAIL
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, <qemu-devel@nongnu.org>
CC: <mst@redhat.com>, <jasowang@redhat.com>,
 <clement.mathieu--drif@eviden.com>, <chao.p.peng@intel.com>, Marcel Apfelbaum
 <marcel.apfelbaum@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, "Richard
 Henderson" <richard.henderson@linaro.org>, Eduardo Habkost
 <eduardo@habkost.net>
References: <20241104125536.1236118-1-zhenzhong.duan@intel.com>
 <20241104125536.1236118-2-zhenzhong.duan@intel.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <20241104125536.1236118-2-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR01CA0040.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::14) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|SA1PR11MB8595:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ece121b-656d-494e-f8ae-08dcfd65cc5e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NEFhRGd2dzk2MXV2Si9WS3VqakxEUlAwL2hJd0R4QVR0K0h4OG9PaGtOalF2?=
 =?utf-8?B?ZnlkL0M2UnFzK3VqYVBrUXpJM3p2L3FGQWNRZldqUDI3eDJ1NmRLaDZ4RTcr?=
 =?utf-8?B?SFRvbmQ4Unc0VWoydHVScDkzaldVVnNyUmV1VFVtSWJ0RDdoS2toVEdpVlpp?=
 =?utf-8?B?ZHE3MXZ6eTY3b2kzTlQ3NlNPSHY5N25EQVhZcThONGgrVU1wS1pKZHZkLzRh?=
 =?utf-8?B?bWxCS2NoQjdYNUNUZFZ5YVY3a0FkZDRTWitPUDRDR3RHTXFqWnNjc0JKem8v?=
 =?utf-8?B?Q3JXa0dzZkxNR2JNV2s2aUd5SjFhV3JZWE1PUVpETXBqTXBndHhWdHJWWWhZ?=
 =?utf-8?B?V0VLSW1NY0hiNytUckJmVGNiWHNtREJSNUZkTm5RMkpzbTgvWGxCZSthV0JE?=
 =?utf-8?B?RVNmQ294WlRrdzFaSjFkd1FWNVJRYjhhc3hDTGdCWWlXZUlBZGZKZUJmNnFz?=
 =?utf-8?B?blM2bzAwQldxbCtTWEkvV3llcTRJZlZmNnp2RXNJZ2NlU2F2bkNNNXBzZnlh?=
 =?utf-8?B?bkFUT3J3VHJ4VEh4ZndYaFdhcXZoeC9wWVR0b1BFWkRTdS9oSG9XQ1FVZGZ4?=
 =?utf-8?B?SWdMcCt4aE9hTU9icVY5WjRWNnB5SXNmdXpRbWcyZjUwVmpKNEJjQ29LWWI4?=
 =?utf-8?B?S1AyVnEwNUJxWmdIMkxHcU1aSzFPQWh1SUdNRDYzdUlMMCt2UVFueFJaeitP?=
 =?utf-8?B?amRXMHR5c3JXTFZWMEd4clI2eEJCalNHbk00TjIyZVpIN3VOVkpJeW8yR1BW?=
 =?utf-8?B?elNkYnBuTTJ4cnJZblNpVzZhdUxnMVFNYjdCZ3o0Z1d4NFRRUHNYYTJjK0tS?=
 =?utf-8?B?WVFTVFZDdmpsQ1BaMmo4OWxLK2ZKUDNaK2lLa1kwY0hQdFRzOFJ0azFhZUFz?=
 =?utf-8?B?WkM2NWVCV0VrYVh2QVpxV3VoYk9rN1J1bHhpNkdmd1ZPc0hwc1dBUnp1U3Rl?=
 =?utf-8?B?KzYwNTNFallLWWlLRWxFTVBHTGhyZzllOWs4TUtETzBvVGN1ZXJkTldnWTgv?=
 =?utf-8?B?SW90V1k4K0lmYldqTUR6SUtyNy9obHE0OW1ERmxWWHhRVGtWL3hzTEJHSWh3?=
 =?utf-8?B?THI3eWp5M1FlWWZqdEk1dnFKUXl3TkRISk5iMENMZkVHT1pPdTZ5QzFlMUNP?=
 =?utf-8?B?a1prV3pBMUQxTjlXK0pXODNOVDFzNThGN0ZsVVFBWnFldmQ3UVMxZGdoSXQy?=
 =?utf-8?B?Uk9HWFRIM1RxekE5Ry9VWk92UXR3ODNZUVRLMFUzUEN5cklVWjN6Tk9lOWdl?=
 =?utf-8?B?L0gxQ1g0U3FJRlJlOTB0QnBDMmJROFRiU0s3K3JuNURFdGZhWVpVQXVzUHE3?=
 =?utf-8?B?MjhHcWxTbGNvekc1aUVRMFp2UWJnLzVqcm9seWJqWGVra2JGK1lOY25hemY4?=
 =?utf-8?B?WDliTWxGTmdyT0ptd2V5U1ZTMFJnNkthMGROc1ZXU2kycUx2RkpiQlJOQVU2?=
 =?utf-8?B?aDB4emV2aElyUWNWSFJBWGYyVE1pMkt0WDV0cXNRbGN3NDB4M2JBenJvbTJs?=
 =?utf-8?B?NjJDNXZNU3A5QXJHdm16NzRQN1RRdUpBOTRFeDBHK0JpUnpGOEs3SnZKbSs2?=
 =?utf-8?B?VHBkRTlEUnA1N1VQZnZhTzNKa0ViVStVSGZZb29tR0U1NTFUTWpqdWI1V0ZH?=
 =?utf-8?B?Mmw3UUo4SVNtWUc2NmhWYm5MREFvdytsUUtpWm9zVUw0SkRBTEppc3BuZjdw?=
 =?utf-8?B?TFgwV3BqTHRFTlRmR3BWcWRZTlAxZk84aGhQMHVxUUtqcjMvQXBucnVLMVNT?=
 =?utf-8?Q?fmI2S19WAjd67EZy6qWTec0eymZNNJLnZBaP02r?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7529.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ek15NjBHci9oWS9SYzJhb2hqY1RMZFNweFZYbCtLMXJLYkx5L1B6ZEp2bnBC?=
 =?utf-8?B?VVVTUndNdHhYS2VWbEQ3S2dqR3RoUTdCdG9veHo3a2VJbHdKSzRWajIzdW54?=
 =?utf-8?B?UHNSdW9DcXBCYjVoRHBqTkhEOW53RHhXaWJRNFVvbXVqWUJCU1k5SnRPbmM1?=
 =?utf-8?B?Z3RvczhkdUJ5cHJTQUEzN2pKcVFLTGZ3WjVYTFhFSUZMd3JEMXRTQU1XZUhp?=
 =?utf-8?B?LzNNWDFocW5ieFgrOERlSytzWXdhMzBXYmgwQ21iOVFkZFg5OHRLMS91R0hU?=
 =?utf-8?B?WHdTb2xRNUhHSVRwVkdTbHVPdmE2UU9STkRXdlBKNHFHdmFrUW5XQlk0WENr?=
 =?utf-8?B?dkNoQ3Q3UlE0ZzdPL0tINmJOOFgzZ1p3alMvZXlBOEY4RjdIMDlYeHJhNUhs?=
 =?utf-8?B?WWV2T3o3MTRwSnUvcTlYOFNuL3FVaGp3QUd4Q1dZdXk5R0lZN28zU3dVdExQ?=
 =?utf-8?B?SXZFdEp4SUxMM05hcUtPOXZYZnVkWTVJaVdSNkg1MnkvQTY1SXdEVGtwRFhp?=
 =?utf-8?B?MXMvWEp1NXkvRnJ6VmR6bWs1aTVEOXErbVpmZzJvSm5FOEZ1U05xSGJjY09Q?=
 =?utf-8?B?L09adktzVjdJRHh3b0VUQjhiZDUvbjV5MU1CY0s4Z0t6NTluL3BIQkJTR29u?=
 =?utf-8?B?REdIWEdvN056NVpPN0xOQytnczh5T1ZnWDFaSjhxN2Zad2dtNm80TjRSeTB1?=
 =?utf-8?B?L1FMcEJ3SU9CQkQ2NktTUFFXeWJ3ajhySXF5NHppYlZ2RlNJT1AxK3Vhck5p?=
 =?utf-8?B?LzNzVDJxT21nbS9hMitBc290NXdoUWh5d0UxYWNQOHp5eTl0d1BLYnhOVThs?=
 =?utf-8?B?bDNuZ0laUGE5T0pmbktTbXRBZkRnN250ZXFES2F3YlhZNmRoYnk4U3Z3aDh3?=
 =?utf-8?B?Ukh3endnYTJSMzFZMFFYWHU5SjN5d0RXMmJzTGMwSzNzM2pMZDhTUTV3YWtP?=
 =?utf-8?B?UlB6SWVGQktRRnhDK0ZaQWhWUVBlUEx2M2tSMnZPMExybzVZYUhLdkpEV0Vx?=
 =?utf-8?B?NnJUSnhCUHhyS0o4MUFrZEEzS1pGZVpyN3llaWxGUmVtNzhYRVRXQlZEa0Vv?=
 =?utf-8?B?YjViNjFVNVBTQkJJUFdpU0x6S2dsb1hzeEMxZTQ4YWU4R3pTUGZNWDVZS041?=
 =?utf-8?B?Y3pHNVB0eG5UYmhLN3Q1Y0pmZEhMN085cDAwQUI2a0FSS2svVjl5ZTQ5ZGJ0?=
 =?utf-8?B?VWthMFEwVklvUGFvdlpuSWwydGxBdFYxQjF6NkxmVUVxYUprMnNvQ29wa0tp?=
 =?utf-8?B?K0c3WTYzS0gxdXFCN1o4Y3prYXlXNEh6aEhOemt3ZkZuOXlKb3lPUzI0RmdH?=
 =?utf-8?B?OU82ZU80bUxZSE1oZUJ2RDJJejB5N2NNUnRlMWFlQUR1cTRQeUVzOTE3RytG?=
 =?utf-8?B?VjRCbDlFcjMxVUpXNkJNTDFiWkZtMGFHRXk2NVpQZVZzTnVTclVUWnJXNkxM?=
 =?utf-8?B?MG1tMGxSdEJVUzh1Y2xQaHNPK3Q0aFV3dUNEZkJLR1dnL1ZSb2dleDhpMHlr?=
 =?utf-8?B?aUlXL3AxcUFHcXlGT3pqcGl4RGlQWktDY1Y4NzlQUTRQUnhURk5nQW05Zk0v?=
 =?utf-8?B?WmFEN0QvdU1jdHRGaGR0dzNGWmg0UGM5Q1d3QU9TL3VBZ24ySS82cTBHS0Js?=
 =?utf-8?B?SHRTeXk0WUJTalZMNzdtc05OTG9TUU4vRnFSMldleEZ5NEw2eFY3OGptUE5y?=
 =?utf-8?B?aXF3VTFQaTYyeGxUZlNZbjJYSllqSDV0aXBreGR6NXM5QW4wNW1wd3l6cGZI?=
 =?utf-8?B?dTcvSVlObHI3MjFsS0xyUFRVbHVPYVBDdzEyWCtHMEJWcEZReEdBV05OcTYz?=
 =?utf-8?B?M1VnTnZ2SjYrWldlOTdJQkdMa1BORmMySWlKeEFsMnBiVmR0STZmWnNzOEFy?=
 =?utf-8?B?SFFyRUszb05oT1JSell4a3NEbFZFNVlYaG43OGpmd1htWGhtLzBvdlNydkUw?=
 =?utf-8?B?OTNMdE1laDdzSVNDVXZjaWhFRmU3cGgvYmcyYmU5Z2ZtY1JTcTg4SVR3aFF4?=
 =?utf-8?B?NjJnMTliMFNSZncvd0FGdkxpMFdNVzkwYUFKVFhxVE5FbTIxemhmZEd5YWp0?=
 =?utf-8?B?OTVNNzZWeXJ0SUdQSmRLckVQV0Y0TGJEODRLZmIvK2VCeGtuMjNUNThIM0xN?=
 =?utf-8?Q?yco0544VQCuggFi0D8vWqk4OZ?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ece121b-656d-494e-f8ae-08dcfd65cc5e
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2024 06:48:04.5060 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uOYLNNAyjxphdERhLSWT0lgPBW6JcmmYWReKT24N7kq+6DGk60xooKe2J0TWDO07nxU9FafdrseCUjKgSOawOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8595
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.14; envelope-from=yi.l.liu@intel.com;
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

On 2024/11/4 20:55, Zhenzhong Duan wrote:
> According to VTD spec, Figure 11-22, Invalidation Queue Tail Register,
> "When Descriptor Width (DW) field in Invalidation Queue Address Register
> (IQA_REG) is Set (256-bit descriptors), hardware treats bit-4 as reserved
> and a value of 1 in the bit will result in invalidation queue error."
> 
> Current code missed to send IQE event to guest, fix it.

a nit: mention the spec revision as well since the Figure number may be
modified.

Reviewed-by: Yi Liu <yi.l.liu@intel.com>

> 
> Fixes: c0c1d351849b ("intel_iommu: add 256 bits qi_desc support")
> Suggested-by: Yi Liu <yi.l.liu@intel.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> ---
>   hw/i386/intel_iommu.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> index 8612d0917b..1ecfe47963 100644
> --- a/hw/i386/intel_iommu.c
> +++ b/hw/i386/intel_iommu.c
> @@ -2847,6 +2847,7 @@ static void vtd_handle_iqt_write(IntelIOMMUState *s)
>       if (s->iq_dw && (val & VTD_IQT_QT_256_RSV_BIT)) {
>           error_report_once("%s: RSV bit is set: val=0x%"PRIx64,
>                             __func__, val);
> +        vtd_handle_inv_queue_error(s);
>           return;
>       }
>       s->iq_tail = VTD_IQT_QT(s->iq_dw, val);

-- 
Regards,
Yi Liu

