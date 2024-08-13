Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C64E3C52D7F
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2024 08:32:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sdmwf-0002Ys-Rt; Tue, 13 Aug 2024 04:31:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1sdmwd-0002YA-0q
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 04:31:55 -0400
Received: from mgamail.intel.com ([198.175.65.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1sdmwZ-0006Fw-Cw
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 04:31:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1723537911; x=1755073911;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=wJ2RakSwk5xNJEweMKY03lHdjG5ZL+isZtwkIZjmgJY=;
 b=nQIGVINBNOFU4yoeyhwNDcfm2S/nmubdZf/p/d5kiQ5iHDnqQYyM9Yiv
 kFgI0uG7WU/yGGNyEaVsrJo1q3SId/K6ky1+RlWMTfHW0zxLz3FuRtHZE
 O8WLZyvPNzCNpd40g7u2dzCVBVF/KsD+tExKJZqG59CJExwyNu/LBBp1o
 cGIZn35gAF9UovYrgLeVq1r91s9GwOqkWDzRE154cJ4yO4PjTlna22IlO
 O2aN+n/riHTEcrF3TIEmKZn9zZWh81osmR9onBBaJWb7VJ+IaEM+GkoD0
 IDzs+W0mNTgN5Tkt1tQznmFMzDYmvB2Bamge5wYa6ziy0W2ebXWfdwd2p w==;
X-CSE-ConnectionGUID: 93R+6l3jRV27yjowJY4Yew==
X-CSE-MsgGUID: 5k3aNu7BTmaUiERZy/k2Pg==
X-IronPort-AV: E=McAfee;i="6700,10204,11162"; a="21829543"
X-IronPort-AV: E=Sophos;i="6.09,285,1716274800"; d="scan'208";a="21829543"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Aug 2024 01:31:48 -0700
X-CSE-ConnectionGUID: IRt7ieoLTYqO+eY2AiuAYQ==
X-CSE-MsgGUID: M5wCUzldQQSEKNnPEcL4AQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,285,1716274800"; d="scan'208";a="63550985"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
 by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 13 Aug 2024 01:31:48 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 13 Aug 2024 01:31:47 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 13 Aug 2024 01:31:46 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 13 Aug 2024 01:31:46 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 13 Aug 2024 01:31:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OmT3LW9SRYHeR+W2BOdAjfWKQUqlB0t7+qFXEw8molUVS8H4GJkae8ykiXPzt8bysd+ek/H72rSqWTMGHzg5R9IINlIFhPqQY+8960YJuSZ2nBAxiwvATrRqFmeKzEFuItbaBY6AdJyxoTj5eMo/cHd0lcvES6JBUKxwsQtp52VG8p3gXDM9B6etxopcu1C4cjtp/mc9+434zKAN9cdizAwuL1LkuGaxU9owUzKbGnZPmSH75PgDvUGPd1oCilKcvdJqRXMUFbZSERYpgtTdcZy1InW7vVs736UCAQBYeO3bAfTLu9454ZEsC/kt1m5Fc4oL7FQinWGlwlNvzcGpxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MvrFUazi3eExk+4Ekw/cEFqw9yTGKqArHqY4Ng3DHhc=;
 b=kmDCnvkKUgEt3qO0w6K/s/yOsCuzm81lRQ35sHjiXC9pXkEZwMiFD8vPv4ucmjXPTBc9CG1eD+bGFgwJp4e1Fy1iln9oDoXezw4lIWbJR+mgWiaMBQCj/7KVRFnlwexO236hS0JR83a32u887D/szXzO6mmyLX3JYsTB2dhZ72lpCUMZAZXwoAi4OsxpM6z+dhI6jUGpD4Ak51fzsHiJyRCppPzJ5tM8EU2OL94TIm6rN+YYBg76ctLy37xKmvrRkrgEHJrucgmw93PgiV2k1mkXl0GF8I6Y6wu2eWLcx1l1FwH/MZkRXOKOO4JYZd9hWPrlnjxLTP59YVS6B80e2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by PH0PR11MB7522.namprd11.prod.outlook.com (2603:10b6:510:289::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.25; Tue, 13 Aug
 2024 08:31:44 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a%3]) with mapi id 15.20.7828.030; Tue, 13 Aug 2024
 08:31:44 +0000
Message-ID: <5889eca7-7f2e-4a15-bce0-84af981044e3@intel.com>
Date: Tue, 13 Aug 2024 16:35:53 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] intel_iommu: Make PASID-cache and PIOTLB type
 invalid in legacy mode
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, <qemu-devel@nongnu.org>
CC: <chao.p.peng@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang
 <jasowang@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 "Paolo Bonzini" <pbonzini@redhat.com>, Richard Henderson
 <richard.henderson@linaro.org>, Eduardo Habkost <eduardo@habkost.net>
References: <20240813074410.2571369-1-zhenzhong.duan@intel.com>
 <20240813074410.2571369-3-zhenzhong.duan@intel.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <20240813074410.2571369-3-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR01CA0010.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::12) To SN7PR11MB7540.namprd11.prod.outlook.com
 (2603:10b6:806:340::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|PH0PR11MB7522:EE_
X-MS-Office365-Filtering-Correlation-Id: a9d182e1-19d8-47cb-95ff-08dcbb725c72
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QmNPUUxtMVprZE8yY2dWVFQ5WktETksxT0RYN0NwdXZhTWd5NjRMM3hsWERz?=
 =?utf-8?B?K1k4bzg5VXpadmdkYlZxOUU2L3Z4OEpiY2ZkNUdmUlh3ZmtoK0QwRnk2SW5s?=
 =?utf-8?B?c0kxR1IrZmcrQkNmSG10Y1h1RjJYT1Fld0l4ZWhIV0ZKdmNZbElITVorRVFP?=
 =?utf-8?B?eU1rQSs2aGNlN0d1YnpFNEM0dnhjRUN3QWdpTXVZSkw0cVF3clk2aDB1UWtX?=
 =?utf-8?B?cThxWWRLS28vWm5WVDFQWWlaQ01aZWVuaU8vVjRMc2NXWnZrSU0rYUJ3Ri94?=
 =?utf-8?B?SHFoUWZvb3NMM2hYbzEyMm9CVktBMi9LYk1YM3RwTjBjNm1HM2xFZWZ2aS94?=
 =?utf-8?B?dDF6R1laWjFodmo5ak5RZEo4Uk1QOFJqMWJLVEl1c3pzUEg2bitDcHFGL0hT?=
 =?utf-8?B?MjVVM0VrU0VuOHp4SDI1eUxMM25Zem4xUHBkODZKSjNyRmhqbGU5Yk91T2RB?=
 =?utf-8?B?NVhvbFg4L080ZVpqYUl2ZDQxRkxveHZWbWZJbVVVUFY2V01rYmRwUFczOGZh?=
 =?utf-8?B?TzNZQ2hUMGRndDFmdnVkWUZhTDhQREJZbXc2RDhtU0pFeHhoOHZSaXVPYlAx?=
 =?utf-8?B?dmltOWdKZGlLNndSam56TmlmWkE0YzVERnFqelJXUG8xVmJHNkk0L3FtbVNG?=
 =?utf-8?B?aDlBWXVTOC9DN2l6UzdFcFF2bWdNcjBzU0xWb1QrcWJjVzkxQkVpbklyVkZ2?=
 =?utf-8?B?NWp2RzJ5cEVwUjJyLzVrem9GNXVwM21Mb1VxclJFNXBmNWRtK1gzeGJMZk9k?=
 =?utf-8?B?cWF0enFYMUlrVFRURlQvbEx2b1E4UE9FUVFjZ1ZWRTNRb05HRVVBcWxYU2ZG?=
 =?utf-8?B?eXV1QTZnS0hKRGNteXgrNS8vWjVjMFF2SCtxUHU5NlZYb0dsbEkrdi9kMkNo?=
 =?utf-8?B?ck1JVTZlMnE4UEhOSWlSQ0RYL2FhaXRIUmxuYzlXSXovN0JMbDcrNFpGYkZO?=
 =?utf-8?B?K2NxWk5hK001QnloNTlvV2MrejZhU0dpQzRCd2RkSE5ndDBYYU9GVFEwTlFv?=
 =?utf-8?B?elhzaGtxZXpTUXAxb3RHWEkrMi96WDdzcWZQTXdLdlZvUzlrcW52V2xDbmNv?=
 =?utf-8?B?SHRYNjI0cnp4SmJaekRVTml2WmhpcUdFOUxZd1dNZHpVNk5aMVRhUytkRlVN?=
 =?utf-8?B?YU5kelg5Y0ZZZElxc2YzODlxNm1jTGN6MXk2OGZYSWQreTRKNE1RWjkybUVM?=
 =?utf-8?B?cjhDQUJGMmFkTThuK1VaN003NlBXMTNha1RVV3hWcU5aL0tWYjBNRUo1VHZO?=
 =?utf-8?B?Z01POGl2QW9HOWg1aUFBVm94eVBZMEcyY1I2RFdFSmhzTWhtZFVQdDNwb3dZ?=
 =?utf-8?B?WTBQa2hBRkZOdjBjb3BCczBDZDVhTmdlWTdoRjAwT3N0MTFZK3UyZXhmU2F4?=
 =?utf-8?B?QWR2cVUwQUNLMmFmNXFEQzU2UDNRMTA1dnVYTlpXVSt1bE1kcXh0TXNMelZH?=
 =?utf-8?B?U2tRNkZZY0xzZUluSkpJMjZVc2RDelQrTmtidGxqb2pFZWhYQkxmVnNIcG1J?=
 =?utf-8?B?RXArdDkvT0Y0VkxtYTluSlJidVVwdklOalYvNWN0Y256ZURBVjRSQmUxZk45?=
 =?utf-8?B?RHdWUUkxa29panhzVkZRQnNLWlBTRk9FdzhFUU9aRzFRTlFya0hPUkhNZmZl?=
 =?utf-8?B?SEJTTkdXQUtpcTkvZGovTFI1Nk1UMkNPRUpDbnlpWEFtSVV5aTVPZ05ldFNY?=
 =?utf-8?B?amxCbHpoelpibFRYcGJsYUZGd1FMVE1mV01YTVQ3UXlrSjRPT3ZnSUx2cmlP?=
 =?utf-8?B?ckRrYkh4VVJKL0lMSUs2ODV6M3BYd2pkQW9aTW1RRkprSTA5N3VzMVFnMElp?=
 =?utf-8?B?ZThrMS9IK1VGQ0dmN09EZz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7529.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MUxoVVJ6aG9HcWxVR1kvL2FCL28xVkFqZVNRN1Ruc3VqaHVVbmhxTkNBV2R6?=
 =?utf-8?B?aE1Na2VkR3o2Zk1aZTBCbWQ4M2ZueWhkcDNQNHRReXRoT0V3WTlXRXFUc1Q2?=
 =?utf-8?B?ZHdBT3ZxaFcyOUhCWkU3aXk5NFhwcEtIaTZKN2tpR2d5SW5hOERzSlNnNmZi?=
 =?utf-8?B?eTN1QXlremZzS3pCQTdZR2xSbitkWHdaK2FkSkp2UUFaUElyNlV2Z3FLY01O?=
 =?utf-8?B?bzRqNmgrNmVZcVgzTW9FNkdKWCs3bVJKSXZac2FMZHNQNkowVmo4YnZjK3Zy?=
 =?utf-8?B?bUx3akZCMW5UeUtWTjFMWUJ3M3ZZOXB4QnBxUytxMUQ2SXFDK0lqL090NURO?=
 =?utf-8?B?R0JGSFVQYUExTXBETUx6NDZxWGNDRDhkbC9hcTJPTWhKbTh0WVhHMnVDUnBs?=
 =?utf-8?B?ZEViZjJvWU1VSkxITzZOeFlIbTRxYmpObmppc0xtVmRlZGNtTWxCMFlmR0l5?=
 =?utf-8?B?Q1d4ZDZIQjE4ZFFBL1NQcnRSRHkwMitGVm1LaHBvMXUzZHo3NmRhNDM2Nnhk?=
 =?utf-8?B?LzBwczFNNkNmTWtTRmdqY1VpcGdZVXhDNnlxRlVnWE40TVJGUEJjYm04Tk1P?=
 =?utf-8?B?TUozK2VRYUljcy9LUncvNStBaFJheFBXZ0xyc0hIb2I3a1J0a0lyL2xmN3g2?=
 =?utf-8?B?cFUvSlpSYkdGazE1cFgvUTdCbHd2bENzazd5ZTBFNkRYOFR5RnZGQnA1Rk1W?=
 =?utf-8?B?TUFOOVJjOU1XQy9WV2hVVllqejVVQU9UQVVLNEwvMy9zVmk3M0d6WjVyUEJH?=
 =?utf-8?B?WStrV1ZjOGhNN0lmWDR1VktuSEEyQnJ0L1FWUm1rZExqYlhsUG1pZG80MzNX?=
 =?utf-8?B?WXI0TjhpZ1h2TU9nbE5BKzl4RkZ5czNFTDYxTWZkQW5oZmZ2N3BRWDRZaWwr?=
 =?utf-8?B?TzBrUDllVERQSHNWeW84SCtycHJBSk1uMG1RK0xCbWJPK05FYjZTeC9wN0Fw?=
 =?utf-8?B?aFVValozVTJZZTZMaTU5R3R6QzlVSWdMbFh5TGVaVXNQVHBWbnJvNDdJRi9Y?=
 =?utf-8?B?aGE2dkRweXQ0MGdRTXpTbTkyM3lxcEpLWlluOVA2Zk1abEFXbFAwMk1Eakdq?=
 =?utf-8?B?cWFyU2dFbmZ3SmVtN1BiM1B2QlE0bVdMcmRsaTRtcVdlK3EwZFNDSzhRUmUz?=
 =?utf-8?B?UC9WMGVxUkN0WUdyODFYZWZFMWtJeTY0VjhrUXllWENrWEd4d0p6aTM5U3Jv?=
 =?utf-8?B?ZGxWRmNTcjVGcWVrc2VZMTJSUGgraThHYlc4TXNXWUN6bTBycGpNQlg5UXVE?=
 =?utf-8?B?MGNUYWdzdEJvaEhlSmw5aVgrNHRTcjBkUlpOTFMzMDduZEkvVzBzUlBYNS92?=
 =?utf-8?B?SmgrRkk3SmwvaVFmRUdIRDFRQW94bENlNmNkYTlMMER6ZzZ0R3lLbjdSWGJI?=
 =?utf-8?B?KzVEUndzQnBlaFlkM2thN3YwOE9xYnBlcWdhZFB6dWs5a3Zpc1piTXNGWXNM?=
 =?utf-8?B?QzlZUkZxMlRmU1FYQWY1TXE2VFFDQ0xsdkxpVEd6WXlVVFlFWVZNRFN6SFFB?=
 =?utf-8?B?Z25HNFVZQUg2ck5Ua0E1Y2lwRnI3cVp0ejc0Mm14cEdEN1NBTmJjd2xQOGM1?=
 =?utf-8?B?Rk1WUEpaYTY0ajJyL1BLakoxL2xXamlmMDhSbndGbzhaWEpnTUhrUHptWCtE?=
 =?utf-8?B?eTlZaGtlOEtvUmR1SnpEN2VGYzVtbjJ2YklEZTN3N0FIdWVaUG5qSm83NWl6?=
 =?utf-8?B?VU5kWDVVRWoyeVBuMkdqQ2dGUnhMN1p0VmpxckdpTS9tSCtKbys2bWF1SjZ2?=
 =?utf-8?B?RlROeGw3Z2x0WHREM2NYTXd0YUREenArVWZxdDR0ZFh0a01ITDltZEYvdm50?=
 =?utf-8?B?LzJFSzZ0clNVcVhlcXVLUFc5bVNkRGZibHVlSEZmTEErUUdIdDJQZHQwYlly?=
 =?utf-8?B?enVEcFpWVnNkaWpxVmlaOXVraHpVUmowVTQ0emNzaDk5S1hhalo3RFdHbmhC?=
 =?utf-8?B?TjZCaXg1NUViNTVBOUpyMDA1QU93eWN6QVQwdDhvQnBTeTBJb1RLZGU4bDJr?=
 =?utf-8?B?blVSV2ZHWDJzSXEwWDVZSmFVaHA3WUxNamZUemQ2QWFDWEJvYlc1WHhlSkNR?=
 =?utf-8?B?c0FqeXFkdWsxU0dYZEtmZUFMS2tFWkpKZlV1R0NDM2NXaDBObU1SMk1LR3ox?=
 =?utf-8?Q?eSuDdlWei2Nb9wtH+NyV5HSdd?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a9d182e1-19d8-47cb-95ff-08dcbb725c72
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7540.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2024 08:31:44.2153 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nH7W8LU9eg7Htvw388DWbS5KJ4WGyz39eDng8TVnNkd6bnBYGgUKljRlyz8qjB2H8K/OZww6n+EQedAEoAY2lQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7522
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.16; envelope-from=yi.l.liu@intel.com;
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

On 2024/8/13 15:44, Zhenzhong Duan wrote:
> In vtd_process_inv_desc(), VTD_INV_DESC_PC and VTD_INV_DESC_PIOTLB are
> bypassed without scalable mode check. These two types are not valid
> in legacy mode and we should report error.
> 
> Suggested-by: Yi Liu <yi.l.liu@intel.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> ---
>   hw/i386/intel_iommu.c | 22 +++++++++++-----------
>   1 file changed, 11 insertions(+), 11 deletions(-)

Reviewed-by: Yi Liu <yi.l.liu@intel.com>

Do you think a fix tag is needed or not? @Jason

> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> index 68cb72a481..90cd4e5044 100644
> --- a/hw/i386/intel_iommu.c
> +++ b/hw/i386/intel_iommu.c
> @@ -2763,17 +2763,6 @@ static bool vtd_process_inv_desc(IntelIOMMUState *s)
>           }
>           break;
>   
> -    /*
> -     * TODO: the entity of below two cases will be implemented in future series.
> -     * To make guest (which integrates scalable mode support patch set in
> -     * iommu driver) work, just return true is enough so far.
> -     */
> -    case VTD_INV_DESC_PC:
> -        break;
> -
> -    case VTD_INV_DESC_PIOTLB:
> -        break;
> -
>       case VTD_INV_DESC_WAIT:
>           trace_vtd_inv_desc("wait", inv_desc.hi, inv_desc.lo);
>           if (!vtd_process_wait_desc(s, &inv_desc)) {
> @@ -2795,6 +2784,17 @@ static bool vtd_process_inv_desc(IntelIOMMUState *s)
>           }
>           break;
>   
> +    /*
> +     * TODO: the entity of below two cases will be implemented in future series.
> +     * To make guest (which integrates scalable mode support patch set in
> +     * iommu driver) work, just return true is enough so far.
> +     */
> +    case VTD_INV_DESC_PC:
> +    case VTD_INV_DESC_PIOTLB:
> +        if (s->scalable_mode) {
> +            break;
> +        }
> +    /* fallthrough */
>       default:
>           error_report_once("%s: invalid inv desc: hi=%"PRIx64", lo=%"PRIx64
>                             " (unknown type)", __func__, inv_desc.hi,

-- 
Regards,
Yi Liu

