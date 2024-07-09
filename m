Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D894C2BD09
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2024 13:58:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRBLX-0002am-1K; Tue, 09 Jul 2024 09:57:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1sRBLV-0002ZX-8L
 for qemu-devel@nongnu.org; Tue, 09 Jul 2024 09:57:29 -0400
Received: from mgamail.intel.com ([192.198.163.7])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1sRBLR-0004Ta-Km
 for qemu-devel@nongnu.org; Tue, 09 Jul 2024 09:57:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1720533446; x=1752069446;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=q3QbuDH10aw7ix7gEIv5b0Hi6eyyelq7+XTLTOWpYQQ=;
 b=mvz4MNRWFDCtB32/nCn1P7tl9sGquo8Sqr5hsIjsFnLHtB4CHIW32NIb
 Svc9ww3zwJ6HkyaNPBd+JLkdS7u76pzQ/qgrkARTjf2IRzjM55n+j34Qz
 qcUppIHfhlh8AWPNKmv9spB1g0uhtw5XJdSA/pX4qsslR/IV+Of1TlK6C
 /yrqRmIandxI40tly4yVJBwf+2FyedxUClD25BwJlWdNS1ORe6c0a5E6H
 +cwNrgcupbPDgWIZo/2WACedV7eKyAVu7+U7RkuLxWg+9DCy1FeJETVNo
 Q9xstpln3Mh3wzaRxgvm7D90EiJrVzb+PqYP/ITwIKVoHCucL3ckrdoPr w==;
X-CSE-ConnectionGUID: xCF/jGMiR/ySBSOr3q0o3w==
X-CSE-MsgGUID: bw/Msxv8StK1YtpYrPPPEw==
X-IronPort-AV: E=McAfee;i="6700,10204,11128"; a="43212086"
X-IronPort-AV: E=Sophos;i="6.09,195,1716274800"; d="scan'208";a="43212086"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jul 2024 06:57:15 -0700
X-CSE-ConnectionGUID: AojmDlsmQtis24BnCnZBqg==
X-CSE-MsgGUID: MGKzkj4dSNuO0Uip8BbGWw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,195,1716274800"; d="scan'208";a="47962618"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
 by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 09 Jul 2024 06:57:15 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 9 Jul 2024 06:57:14 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 9 Jul 2024 06:57:13 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 9 Jul 2024 06:57:13 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 9 Jul 2024 06:57:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fCKO63CkI0Kg9Fkv3Ji/n3WKvGxYuHbuIr9Q0edNQHjMx/ElmtqfIz2MTmELv5pej+Odk6ouv+zQty3wz76eBOV6UhaUKWYDUGhl14TZDqbnvoKKZ4tmLyO4/nqQC1VLxJPLQ9tmclHUgye4FGPxcyLWwbhee+IoP2zYm24i3XMVdOsf9ABqOsNE5/ldz9VL5v5KShnkZK1+kP9hzohWfVYu7nzrrBEkuJN68YhHs8pFHEwsvtEfjrUxyiNDcl822qD2LCJGiAoTf1aL7lalpjO5Yf2Ji6pRgsBjDB449FcaEnbf3F46RKb/p1V66G5wOzQlWJWOCgWy6oToGstZ3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WWqEen31g5iT2tbL+VxtfIcFoyl6tVfiPY6V/4cC/eY=;
 b=U05Ae1NFhZ2UiEuxQGr0tmJMQ3eypJKULNfJAQnip3yyxR5S9llkCRX6oDatR2C4fRdJ4ore960F/h+0WvA9PsbRU6cZPRJz+4gzm7WbKdet3GGTRTsWEjsaY7u6N4sk9c2ECmimP08XWlbrdxuRyu+ts9kT1XUXWH3AVpnKEQl4b9s1mHJi1x4uDHycbDSYfmYJbfGkfnE/TpQ7a2OISy6g3sQNGV7smrpwkVwqgZxDjkIBxhPwztT2XNDYAVYcbKZay/q/12346jj50JUVHKyIWO6sGyXHjmEMHNiW7hOhfZu+7+ZPc9VUJRz9P/rSqL8kVn+69WN6dEBS7RYapA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by SA2PR11MB5161.namprd11.prod.outlook.com (2603:10b6:806:fa::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.20; Tue, 9 Jul
 2024 13:57:11 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a%3]) with mapi id 15.20.7741.033; Tue, 9 Jul 2024
 13:57:11 +0000
Message-ID: <1d7c0f11-7aef-49fb-88ad-337df3081162@intel.com>
Date: Tue, 9 Jul 2024 22:01:06 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 3/4] intel_iommu: fix type of the mask field in
 VTDIOTLBPageInvInfo
To: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "jasowang@redhat.com" <jasowang@redhat.com>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>, "peterx@redhat.com"
 <peterx@redhat.com>, "mst@redhat.com" <mst@redhat.com>, Minwoo Im
 <minwoo.im@samsung.com>
References: <20240709061756.56347-1-clement.mathieu--drif@eviden.com>
 <20240709061756.56347-4-clement.mathieu--drif@eviden.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <20240709061756.56347-4-clement.mathieu--drif@eviden.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2P153CA0015.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::21) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|SA2PR11MB5161:EE_
X-MS-Office365-Filtering-Correlation-Id: d63ca53d-ee38-4921-e8a7-08dca01f07b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZDgzYTdZZVQ1R0N5Nlg5L2JZd2NkWTJtb09lK2hXbXZUNmoyWlVUbjBjQXhJ?=
 =?utf-8?B?MXJYOGFzcWkwUUlUSlFhYzJVNnNVMnFPVFpwcDg0OHJkUEJBaFcyTjVwMkR5?=
 =?utf-8?B?U0NaY0JEVXdGV1RyY1pnR3VNWHZxdC9lNU9SeTBZc0hrRFBlSEs2cS9TWjRv?=
 =?utf-8?B?VUU2YkhML0k3cGtHSHJ2ZEZOZ1V2bkpsQmFpLytqU3owRlA4S0llb2FCdVRV?=
 =?utf-8?B?dWt2UHY1b1h2SjFBbVd2WTdxcVFIVEwwMEg1elVzODdUazRSNWM2SHpLSVBL?=
 =?utf-8?B?NC9iRUVRUFB3cWw1NlZidy82LzRMakQ3TnpNa215eU1KSlg0Z2puYjVRNnNY?=
 =?utf-8?B?cDR2VVYyVXNnMUZFQ0Fabm1HejdQaWh0TjRPY0lXay9EcEl2dWNMaE15dUhN?=
 =?utf-8?B?NG1pVjZ6WXIxcDJCRlZhdHhhV0ROdjFncUdsMm9lWkNpZzQ1ZGt5SXZKVFlQ?=
 =?utf-8?B?bktIbWMwRU1CY0ZUZHhuTVhYQ3ZrQjNhanVLS1EwTVVIU054bDY2RGwwanhY?=
 =?utf-8?B?UjlnK1JMUjY0TkoreThEYWhsV2pJZWNWbmxzU0twZ1pXbVdBQkNGUTBFSDBH?=
 =?utf-8?B?eU1JZGV6d0RqemhrWlpGQ1BpVW5RMnExWXRlYTFGMGJjQlZoc0tBcjlWVVlE?=
 =?utf-8?B?UGIxdk5SdTl4TzlZbE1USW9UeHUvWTVYVUt5c1pFNDBPbHh3RlZDVHZhNFYx?=
 =?utf-8?B?ejZrMTJWaGltVk80ZVNzbnZKaTJKWmxRQlo0eDNnamkxTUNpOWwvYUtjMk5n?=
 =?utf-8?B?WUtTbFoxbHorRUt3VVVUY0ZBbHRGM3p0cGNtLzZuR3lPblAyZnV5MVdFQUVC?=
 =?utf-8?B?WGx1RlRkOGFsbjRwa2tNMThwVEFITkNnd2Y4bjBsaWphS2dWVWkydEZCbHR1?=
 =?utf-8?B?MVl4eGpsbXVtV000eDhveXVpQTg4QlVsT2JZbjhQZWdXb3FlLy84clAvam9N?=
 =?utf-8?B?akdaUU1wNkxVd3BRR2JPSTRxUVVIY0Z4V1RtNHBCNmROVnJIYy96LzAyWXJY?=
 =?utf-8?B?eXRDUmlDaFNpeHAyVkUrVFU5ekhrMzN2ZXRieGFVOVRwNzlWQmp6UUxMclFn?=
 =?utf-8?B?b08wOHNrRTFLRlVpRVF1MlRqbkhKWlhucDlHcnE3K2Z4UHd6TTFXUVJnMUVN?=
 =?utf-8?B?akp6bjRTWXd0RXBwSkViMVUvZ0NQWUZ3S3JRc2RkaGhqa2V5OU11REFQeitW?=
 =?utf-8?B?OUJhLzZSSU1kZGZwZk9GemdGVENYejd6T2lHSWQ0SDh6SDNUS1VIUkFPZWJL?=
 =?utf-8?B?NTBlUDFrN014TG1lcnFPVjB4dEZtUytXbEZLd2tJS0U0L09TT1pZbkU3UE9n?=
 =?utf-8?B?RENkSTdZaWlvc1hEb3puT3AwZGNQTURnZmhSb3EwV29YZWRqRUF6cHZwN0Nx?=
 =?utf-8?B?OXdvVUVqcEdHMkR2MmFWdHNlR3hLWDZxNVo0QitsaUpySE1leGc4UElZV0Ni?=
 =?utf-8?B?WTZSSGUrejQ5RFdkc2lWWnN6eTh2NVN3Ris3ODkvN3BRUFNnQXp2eFFtSGFV?=
 =?utf-8?B?R0tRdkVlaEZBYW54WDc0OGtLRHVNaGVhVU1KTFdpMXlPZkpVMThlQ2ZEcDQ5?=
 =?utf-8?B?UTFIajNZczNNbFZGMjlIZmhoOThkNnc2MGcycEd1cDVnbDNYb0VjQUx6ckZx?=
 =?utf-8?B?cHpUUmVPblFwRS9yYzNEbDNoNjFDTG5wRytzSnJDM3dKaCtnVUF3WWNHcWZP?=
 =?utf-8?B?NWtVSHlTSlZFRjhzNTNhV0NUU3RqN09OTkZMSmtEbTBrbC9kOElVdWVIOWRU?=
 =?utf-8?B?NVFYZmJQeTROdm43Mjd5SUdVZS84Q0JrVGg4NFdOTHc5Ykx6dmE3enJkM05x?=
 =?utf-8?B?dHFDdDhyeHp1R1BQU25Edz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7529.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cnNtYWZpenZwNk5oZGxFUWdBbG51bDdtVnpRSXAxTDRNYXNVZlNsSDhzRFY2?=
 =?utf-8?B?dUU3dWtvVXFiZG1zb3RZbnI1MTZBdlFnYWROSmxRM1lwMjdHOEU1TEM2YlZY?=
 =?utf-8?B?RDlOSlVZNTJRdUNVaFVDVEtpV296YjlDK0dGWHJZeDFBYUVlTlBWNmJlWjVw?=
 =?utf-8?B?ckNKdEtuOGxTbzZTQ3dJQVBaTURaK09zS2hsK0k0d3ZLUUpuclVYK2tWRFRD?=
 =?utf-8?B?OVM3Z2tnL01ONWV4elZMR093aEd5eDlTTW1jd29XZkxmVUxPTzRoWWRiKzJv?=
 =?utf-8?B?N0I0NzYraTRDTUtWOGhBTmc0NXVQU1pmb2tHaUJ6UFBrcHEzK2VjTDNZSW8z?=
 =?utf-8?B?OWw1K2VkMWVPN1hwWnp5MUUxZDJqcjg2cVo0c29SejV3YU5PVzdUZm9peDNs?=
 =?utf-8?B?YXVzYlZNS1hNTGFyVjlZMmRjdy9BSHY3ZzljcWNWTERaVjM5VGZuc1JNcFlm?=
 =?utf-8?B?YzFUb3lhT05DR0N1bGpqblh4M2pJelF0c3VSWHh4TmY4a1I0S2RnV0plNzQ4?=
 =?utf-8?B?Zkh4MER0b3JMSDVjV0JBbExnaks1eEluN21kdjhHYjhabVd4L3ZxVkNRVWFt?=
 =?utf-8?B?TXZjaWIxekl3RjhvWXU1Q1VvaFo4Z05Nd1FiTmRNTmFBL3RPQmxWU2liU0ht?=
 =?utf-8?B?L0VkZjhMa1l6dlpZTUlTMjJKako4c0VPd01EeUVZRFdnVVdTZEJ3UWNpVkIz?=
 =?utf-8?B?eDEwQVJCSW1lU1JlMnRZcHk1azM3WENPSlRNYSt6RlltSjYxNGZEQkIrOHo0?=
 =?utf-8?B?YWdZRUJqMTllUzhhZjBRUm9IUWE1enBhWTNIZlBpbGt4Sy9kdUxTYUNlOFQ5?=
 =?utf-8?B?eDhWRWFzcmVWSHRnYit5NUZob2QrSDJjMGc0YitDZm1Zb0xQT2VMQlAyYUE2?=
 =?utf-8?B?cEk2Y1pYNzdWeGxtLzFMbjZ6amQ4S3VqTjVZY01NVGM5TEdHMUZncGNXcjFl?=
 =?utf-8?B?dTFPSmFDMFJqWkUvK2dQd1pCWmh6N2EvVTBVRjFpZ0ZGOHRiZXMvRXZuUmpv?=
 =?utf-8?B?ZnRUS3RLTXQweGFWY2VVdEJnN2pyNEhNd3l3a01CTzZ6MXZCS20zT0VIT1pq?=
 =?utf-8?B?MldXWVRobVFUcmIvRnlMcitGTkxRbjFlYktIRVFDbUpHd0Z4cUdOcjUyODFN?=
 =?utf-8?B?U2NwcjFQTG1EcnFLVDI0U3JTS0xBaTVpRG15VUhvcDk4RWRyaEtEVjFTaVJt?=
 =?utf-8?B?a3l1dXV0ZlR2MjE0bzgzSExTMkdIbDJQcy9oM2p6SVBRZUYxWGRJR2dIdk5w?=
 =?utf-8?B?Mll3ZmUxM1ZGN1drYXBDMHdoSjBuUkE3Z1dmV3A5bWl4OHRYaTB6RDVqSmVQ?=
 =?utf-8?B?bzFhbWcrWEFXSDBlbVQ4UHdNUUxWdUFFWVAzWjVrUWlvcmppNEowZzVzRzZM?=
 =?utf-8?B?YllyTGIyaW5EaU5kVXh6bSthZ2c5Y2xsSXVidVNpTjI3ZzNSeHVXdFJFMmNT?=
 =?utf-8?B?VDNFZXVTTmVoMkpHL3IxMkZTMWFoT3VRNit4TzFWbnRGTFhiTGRmanJsMnFV?=
 =?utf-8?B?VW1mOERkSlM1Q2d5WVpzL2FVOG41NDhpa1krRmNNbU4xWlF4Zk5ObUIwSU5F?=
 =?utf-8?B?c0xmYm5iaVRueVN2VjY3RnlCNlhsWXplMXpsVFRkUzcrLzRxUVhXeGhDQzRn?=
 =?utf-8?B?azZaVkJhR09rUnVCc0JGeGN2K3l2N1NwZ0kydEFSNFh5cTRGejg4QnJ3bEMr?=
 =?utf-8?B?Z05LM28yUGtlVGZoZjI2aHNlNHlJOXFUYWZSa1VLUUcrZlJNUS8xSTRyaHBj?=
 =?utf-8?B?WklxKzZiN1o2V3hIalI3dmRJejZycVZ1OWRBc3Y3MGdMVllTRVlLTGF5bzFI?=
 =?utf-8?B?Zm1PMGdMOXo0Y1hSYTIzK1hmVDluUkE0aDYxTUJyWWNnbFAvKzh3Y2x1Yy9p?=
 =?utf-8?B?endVNEhmbFNtSDVzamFSSXYxSE5peVBsdEFNU0o1VXNtOWpnSWdCVW1kRmdK?=
 =?utf-8?B?ODFKbGFDRk5xbFJmRytEVEVKZlk2TVhoelJBOGFlNzArUlJUY3NVdFdFSFRU?=
 =?utf-8?B?T3BTVG1PeFVRK0gwMGZtMEtWM0pWc09VY3NRbVlCUWtTdEszdFBpZjZET0NP?=
 =?utf-8?B?Uk1GNENKZGk5Vnc1T1pFTTdUZkc1RldyVVdOVVZsempzbjZlWVQwV01rVnhl?=
 =?utf-8?Q?bDeMDovChblUbRDX9Ptudm05V?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d63ca53d-ee38-4921-e8a7-08dca01f07b0
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2024 13:57:11.6314 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mOcTvpkt65x+j1Emhs/KdgPnEiD9ALWfrJPslsO4iFoDDcItCshyCoew26pT/wPMzoz/KZaGCu+OV4YWaUYIUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5161
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.7; envelope-from=yi.l.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
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

On 2024/7/9 14:18, CLEMENT MATHIEU--DRIF wrote:
> From: Clément Mathieu--Drif <clement.mathieu--drif@eviden.com>
> 
> The mask we are trying to store into VTDIOTLBPageInvInfo.mask might not
> fit in an uint8_t. Use uint64_t to avoid overflows.
> 
> Per the below code, it can overflow as am can be larger than 8 according
> to the CH 6.5.2.3 IOTLB Invalidate. And you may want a fix tag as well.

no need to paste the comment here. Especially the last sentence. :) Just
highlight that overflow is possible.

> 
> info.mask = ~((1 << am) - 1);
> 
> CH 6.5.2.3 IOTLB Invalidate
> 
> Address Mask (AM): For page-selective-within-domain invalidations,
> the Address Mask specifies the number of low order bits of the ADDR
> field that must be masked for the invalidation operation. This field
> enables software to request invalidation of contiguous mappings for
> size-aligned regions. Refer to Table 19 for encodings of this field.
> When invalidating a large-page translation, software must use the
> appropriate Address Mask value (0 for 4KByte page, 9 for 2-MByte page,
> and 18 for 1-GByte page). Hardware implementations report the maximum
> supported address mask value through the Capability register.
> 
> Fixes: b5a280c00840 ("intel-iommu: add IOTLB using hash table")

looks like this is a very old commit. The VTD_MAMV is set as 9 at that
time. If guest sets am=9 in the PSI iotlb invalidation, there is overflow.
Just curious why there is no bug reported here. Have you encountered any
issue before this commit? Anyhow, looks good to me. Remember to refine
the commit message a bit.

Reviewed-by: Yi Liu <yi.l.liu@intel.com>

> Signed-off-by: Clément Mathieu--Drif <clement.mathieu--drif@eviden.com>
> Reviewed-by: Minwoo Im <minwoo.im@samsung.com>
> ---
>   hw/i386/intel_iommu_internal.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_internal.h
> index faea23e8d6..5f32c36943 100644
> --- a/hw/i386/intel_iommu_internal.h
> +++ b/hw/i386/intel_iommu_internal.h
> @@ -436,7 +436,7 @@ struct VTDIOTLBPageInvInfo {
>       uint16_t domain_id;
>       uint32_t pasid;
>       uint64_t addr;
> -    uint8_t mask;
> +    uint64_t mask;
>   };
>   typedef struct VTDIOTLBPageInvInfo VTDIOTLBPageInvInfo;
>   

-- 
Regards,
Yi Liu

