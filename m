Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 326C210BA422
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2026 04:24:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5ykY-0003De-0N; Fri, 27 Mar 2026 00:24:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1w5ykW-0003DV-LN
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 00:24:44 -0400
Received: from mgamail.intel.com ([192.198.163.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1w5ykV-0005KW-02
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 00:24:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1774585483; x=1806121483;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=V8efksqWCeUC6DcAdeC/eLqEzFVPCrMWEGhBJlwM3ec=;
 b=U0Jn2Bs6QPgqgQ2mcRDsKt2bJySOv3lwEJtFvP1jtTHQ31gJzwzK3Uii
 76xWL08+8Yu4u+xeSEWTYYm8pCecVimD3XNju6mJfV6XOWvc04qYi8g4p
 4qacTqKMp1yZUjl/XniXBP9OeE0LI2M7Etxfi12NsRZ+nLrc9MNN3V2Je
 V2VSAdnNAg4r9YUPMFPIf9nA17rhQJCTnl9yoVlfmyGSY/sLS4ylN8OIM
 iIPNePWWNCPkLGrLqwvazhL7ca/pDm7eYKqklqqP3OoX8uJOc7AvrwVkH
 /aIAz/htmFv1djmCGl6PLEXhBq2GHeCHukXZ31mKZF6v0WJDmCEveRaU2 A==;
X-CSE-ConnectionGUID: W+CTy3A5TKSsenwuCJDsRA==
X-CSE-MsgGUID: fppy5ShBTrq2R5ZT53UarQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11741"; a="78251952"
X-IronPort-AV: E=Sophos;i="6.23,143,1770624000"; d="scan'208";a="78251952"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Mar 2026 21:24:41 -0700
X-CSE-ConnectionGUID: 0kNUMEEBRg+juC73kt8ocg==
X-CSE-MsgGUID: IUpaEwt3QbaS0NdxUUiSuA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,143,1770624000"; d="scan'208";a="229267868"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Mar 2026 21:24:41 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 26 Mar 2026 21:24:40 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 26 Mar 2026 21:24:40 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.43) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 26 Mar 2026 21:24:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WunqfZz8+oza3qICyCjcr3f7UgyUqGdb8onxmno2E17uV0ygDM3520txa/M7k8ttUe2mvXSQhFQLIPw/j8vblS1jP2r82ivt5aHLJEw8521dJNVj8tEKZRZvN8TEIDAE58+pRFbmPGD/n6jsf2ln0qi7VE4UP72ciVil7cSCfPubYHxP/TdEtLraTHyr8rkCk+mO8T3BFzw/WaNTetHOfsqfh9b9nQYfYTNc7ZeiDtu5I1FDp/0atVYLCaotiIuaErmCw5b+YAt6IlSmf5AcCfBar62oywEuWJbX/C9caUgKVDsyx5OYrwNkSrtVBe3Kjpte6tUD6+F+Yv2JWUh+iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zy/p2VQBrbEOSDCKv05YQaC5no7jofjginVI/zkWxVA=;
 b=E0XffzASRPODjynXSxCXhT7iYTmQqQJuavowy342qF8YaVFs48HN6vqTdP8Neu0NvfeGBMFyPQqDtYMB+85YZMyaSTxO79ZlFXQ161FHZIKkdZfZ04pNL6tsxd/daKPFPO6H/2inKqF9y1qSIYQjN7TX8fNWbyVcBfE/QKWnaXnginkCf8y5IJWKelwk1/Jt4CsfJ8OnxHwtVe3lsqWyLKi3t3u8YNzzG0cqtpxvP2o0d6B40fbxaYAlyqQDUG0k3YpHlxv8ua8iWKSyVa1UCrEeYNk/IsjmmEqAjlavm/5MzL1wC4KtgiuZ/ICtZqUtUDNy5e0Hzp7J2Fm2P9uEAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV8PR11MB8509.namprd11.prod.outlook.com (2603:10b6:408:1e6::15)
 by SA1PR11MB9614.namprd11.prod.outlook.com (2603:10b6:806:4c4::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.7; Fri, 27 Mar
 2026 04:24:38 +0000
Received: from LV8PR11MB8509.namprd11.prod.outlook.com
 ([fe80::f5bd:4dde:4f2f:20b7]) by LV8PR11MB8509.namprd11.prod.outlook.com
 ([fe80::f5bd:4dde:4f2f:20b7%5]) with mapi id 15.20.9769.006; Fri, 27 Mar 2026
 04:24:38 +0000
Message-ID: <73392b21-f9b4-48f1-b712-30119cbc8648@intel.com>
Date: Fri, 27 Mar 2026 12:32:22 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 10/14] intel_iommu_accel: Handle PASID entry removal
 for system reset
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, <qemu-devel@nongnu.org>
CC: <alex@shazbot.org>, <clg@redhat.com>, <eric.auger@redhat.com>,
 <mst@redhat.com>, <jasowang@redhat.com>, <jgg@nvidia.com>,
 <nicolinc@nvidia.com>, <skolothumtho@nvidia.com>,
 <joao.m.martins@oracle.com>, <clement.mathieu--drif@bull.com>,
 <kevin.tian@intel.com>, <xudong.hao@intel.com>
References: <20260326091130.321483-1-zhenzhong.duan@intel.com>
 <20260326091130.321483-11-zhenzhong.duan@intel.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <20260326091130.321483-11-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TP0P295CA0056.TWNP295.PROD.OUTLOOK.COM (2603:1096:910:3::7)
 To LV8PR11MB8509.namprd11.prod.outlook.com
 (2603:10b6:408:1e6::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR11MB8509:EE_|SA1PR11MB9614:EE_
X-MS-Office365-Filtering-Correlation-Id: c7f62c2f-4875-4bdd-d2f3-08de8bb8c20d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|42112799006|376014|7416014|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: uyGIcyWgYiSkDLedA7D2moNdOSK9KQsXlTFFvUWkgqMyeunS3sw+pLg+sI2wm3j72cX+vQByOgysRQ8o4CNr+7ninMTBNJkhrXjgLlLqL2wkXdvUQeg4B0JEk09jyt9VnRfBDMujbG8jDXAtoM1dYbq66V1i3nOQ6Ikc9dK974rzAbuItswkkW9IjRSSKc7VkMDzRjbbayM7fFN8j65abUCzTjX0a+YMIvcaliB1tjXH+VB/YbipF3ENX20SXcxbcvAWvDfMH5lOpUdpnBf9HcWMIefqkoWAgV4ywRD2w0iQo/4ZTxuF/njfm/pELnS6NEWyY4ljtiVpTWRwzJq/qtfk/ZpIGaFkmBmHN9dSe+DGQJPHeiE5AbuyUrtEamzY6JfBrluxeL4ToDu0IdR9Eo6wiQA65hLMZ2+RWpcvCpZv1cLIGir66lfikjvT4kmhNw/puPKniPNGXoISvqoNxrdXLf+eG8/rjkjnBGCl+A68a0yGsQpDKaVrSxaHrSllzyvWz51iKudU8wZlYPg/kMy4njEL3AI8VyYKdZarOorHHcsZrAeHAR/f1eZtJCqNPs9FLHTiQx4vST578keEBiIfLCzjIPVone7WUKmI0twcAdkh0tB9D+rLyxrMQBa/mNMDI/XkLK/l/qZpPtDC/DK4fLYDT/aZErLEpjdJuwosOVj0hvcRZYpDxtNe9swNpiStJi7Nr5IdafR+A1H56rxTmU6jYNc38hPQ3yiTIT4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV8PR11MB8509.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(42112799006)(376014)(7416014)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b1FUaURwRDB1RzJrN2RDNEU3SUJTYkhJejI0TjY0dWdiNzZIVVFuYnc1TVYz?=
 =?utf-8?B?WkkrRnk1WEZPdVhmNTQzazNUR3BSRk5mNktXbWtnL0hZU0M1QmVZMUt6aGFH?=
 =?utf-8?B?V3czeC9qcTFqZ3hYakMvKzlBamR0WHFqUzJZNkhSMHhPZ0dEMXB2ZnVIK1pQ?=
 =?utf-8?B?TlhnRVluUlNFYUFES3dCUDNpNFFPOHJhUzVzejZWL2xsOFh3UFdJSGZVSkxF?=
 =?utf-8?B?T0x3Tjk4N1l6dUUwTnk3ckZuS3kwNDJxVERpN29oRUIyZWpQVE9GdlN0OFk4?=
 =?utf-8?B?RTRkd0hiRmVzZisxTmNJeUtSY2FsZTNlKzdjeEc1QlJXY0x1QUtUOG81T2F3?=
 =?utf-8?B?ZGJNa05wTlJGTHZERVNiRy91ZGNDYWJCVVRrZ0U3dkZLZlNRRkRqNGtxTDBE?=
 =?utf-8?B?bUdGMkhXNzYyVUgvNmhsTGdoQXJWM05rWWNXU1J2eTMzTnNEZGtuSlFxazhM?=
 =?utf-8?B?Y2hCRWVaeDZ1T0dlYVFicEh2a0QyMkk3VkUxMDUzbDJxZlpaTFR3S3ZWUFFL?=
 =?utf-8?B?cUdRV0FCWTVmSkFnQXFQaGpFTkJST2RvV3BwMFVoSDY3YTdIeUJYaGxyV05S?=
 =?utf-8?B?UzlyRnc4ZVpsTTY4WFlFd1ZwUTFiK0pSM1EvRjBtdG1UV3czcS9oZUpYVjVj?=
 =?utf-8?B?Y2FMWUlkVG9lcGNJMGVmOUhmZ0o1S1UxZDZTKzM5aFN0bnNFaGd1dWZQRThB?=
 =?utf-8?B?M00yY2h4WTZxR21tU0c4OHdHUHpwTDNBZThBU0Q3UGNBL2RjTTNTWkNoNkdL?=
 =?utf-8?B?ajY3REFoUzdmV1pKNElOTDJSY0o1R0hvUUJLYTB5RlBqb2J2V01xdkxzWTZB?=
 =?utf-8?B?YVJRajV5SldpaVNTb1hUOG1YbzhoaDRHZitNVTZKS285Wm9GVXdtTXNzaE9m?=
 =?utf-8?B?SXM2dG85SzZja05CYWFmek5IbE9uS1F3Qkdlb0VLVXpFcTkwdEdWdTFzaTZO?=
 =?utf-8?B?UVFycmxpMmIyNTQxOTI4OGgyS2JMMEtjc2NMS25hcVlBRHpkbWlkUW9paGU5?=
 =?utf-8?B?NDlUTWhGQnZEQy9lbHpsMVRTLzE1TkV3eCt4cVFFRVFnbWwrNldra01PMnBl?=
 =?utf-8?B?M2MrM1V1cElMclZ2RFg1VTg2cGxUeXdSd29HRmhOOVBFR1E2THNRUTY0VUhH?=
 =?utf-8?B?OVhNalFVMEZEbHZzNGlFekovNmhESWwrayt3ZEFCN2w1ZlZEeE9lWmtTZ2Zo?=
 =?utf-8?B?eHZKS002VmZMWVU0Vy8wM0RESWFyVU9uc2N6eEVLanBiak9sd0tIYkVXWVBV?=
 =?utf-8?B?MjhNYlY3Nllkcyt6ZHZaSzlDTW9CTkJDbG1BcU9iTm40S0lpUHYwTEk5S1Ni?=
 =?utf-8?B?Ly9kV0NIdStDRnhYc25HSDJrc3hDcng2V3pKUVFhU254TDQwVEc0UFZ3MndT?=
 =?utf-8?B?NExtMTNJc1ZZMEhReHNxS3VJNEJFSTZpNE4rbjJDaWEyaHFpek5YT0g5TVlG?=
 =?utf-8?B?cjNMK0JxMkI0eDdZS21FYytjcjVHZnFHdVA0c2RITWY5QXQzbXZwUWJVSGth?=
 =?utf-8?B?RG1uYml0a0xYd2VqMFl2N0VlQTBkOTBGOUtsb3loaEwydDhQZGdwWS9TOGNI?=
 =?utf-8?B?SlJLMVZUc0JzZUlOc3hGZ0RNdE5hUHBUVmxJc013U0s2WEovekVpTXE5Zm14?=
 =?utf-8?B?YmxGT1E1ZTZHQklKa212UDZoRDgrbm02YWlpVVJPZzd1YTN2QkU1NnRreTU3?=
 =?utf-8?B?SGdMRlBBNStkUkFUUGg1Vm1mWDhVT2J3TlN1SGNpZmVqSm93OXhVTVNzS0k3?=
 =?utf-8?B?Nm41bjQzMXhNckxJdnNtWHlvK1RYaVF5SW5YODdva1piUXEzM21vZzN3UkFY?=
 =?utf-8?B?aGpmMHZ5aVl4MWwwK0lwM0RKK21VRFhQTThsb3JoM0kwbU9XeGFuN3FLS3ly?=
 =?utf-8?B?YzVOYWxJNEVBczVCaTNTZEhkSG1UaExZTTdJcTBUVnhSYTVBTDBuN0I3NUgy?=
 =?utf-8?B?cDNITVlRYjMrdkNwcFRBcVh2ajFVc0FweWV3dFRkTjlEa1h4aEwvdFNqRCtq?=
 =?utf-8?B?T014RER6eVZ4MGo4Nk1pWENrbUJhVnhVVmxIVXZ3N3ZkcmY1UDY1eFBXSkNU?=
 =?utf-8?B?NlcvQ1hXLzdRc0Z0N013a2NaWW02VGxpNFk5RjRwQkxNdjBwaUN6Si8vek5u?=
 =?utf-8?B?dkRkZVFPd2wrcGpIOGFZd0FRMXZzd2tRdjdoRHROZ2xaM2JEV2xLSEI5ajVE?=
 =?utf-8?B?T3h6ME1kb2hCL1R1bTRERWdYdGNmR0VSZUNXL2Q1TTJ6cjNBcWIvRW4zUnlH?=
 =?utf-8?B?cktjaTN3YXFLRk9OR2JHb2hSV1hzOTJaZ0p4WmlFVjMzb0JESVdaQXhETE8v?=
 =?utf-8?B?ZTdLUDBGQm9aN2dmUWM1RXdZWVhFSmxqTTByODR1T2QzL1RxRHNIQT09?=
X-Exchange-RoutingPolicyChecked: Cr7TOi1SPL4kXkSc8Bk7+KLjZO0rr1guIUdatns90ZILyhPtf/5TyWMFIfBFctlHvB7TnRmuNhtVd8ZnjHz7K/xT86xd4L+78mw4NethLJO3Y8zUSGsROxAOQfPnSQaSVNSMK5nOB1O3EJ9OFMjdI7XtsmZqtavDJpOr15MjRkMbX67IxYgGfNXBGAfv7oXXVrHQv0qr8MnCUfz85L6OVMjXvkpaHahqgQiFd5w/aL/6MNtDJjuUP+R5YMvpaVSJ6I7uK9UL/wPbKITRDtwch9RRsmJZ28WElvxAyGqiqmhUiHM2xD+GErZ4piov9UUDiLaA2pVNh3cKJlEP/Nsyrg==
X-MS-Exchange-CrossTenant-Network-Message-Id: c7f62c2f-4875-4bdd-d2f3-08de8bb8c20d
X-MS-Exchange-CrossTenant-AuthSource: LV8PR11MB8509.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2026 04:24:38.2438 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ItnZeE+e0Ve0mir7GOGC46CE58tFXE0/tnrEqR/5CbTuj1+alJBssh2eMQWv53VJo+MFuJlq5UAh6Jei71AUlg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB9614
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.13; envelope-from=yi.l.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 3/26/26 17:11, Zhenzhong Duan wrote:
> When system level reset, DMA translation is turned off, all PASID
> entries become stale and should be deleted.
> 
> vtd_hiod list is never accessed without BQL, so no need to guard with
> iommu lock.
> 
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> ---
>   hw/i386/intel_iommu_accel.h |  5 +++++
>   hw/i386/intel_iommu.c       |  2 ++
>   hw/i386/intel_iommu_accel.c | 13 +++++++++++++
>   3 files changed, 20 insertions(+)
> 
> diff --git a/hw/i386/intel_iommu_accel.h b/hw/i386/intel_iommu_accel.h
> index c5981a23bf..1fb7ca0af6 100644
> --- a/hw/i386/intel_iommu_accel.h
> +++ b/hw/i386/intel_iommu_accel.h
> @@ -28,6 +28,7 @@ void vtd_flush_host_piotlb_all_locked(IntelIOMMUState *s, uint16_t domain_id,
>                                         uint32_t pasid, hwaddr addr,
>                                         uint64_t npages, bool ih);
>   void vtd_pasid_cache_sync_accel(IntelIOMMUState *s, VTDPASIDCacheInfo *pc_info);
> +void vtd_pasid_cache_reset_accel(IntelIOMMUState *s);
>   void vtd_iommu_ops_update_accel(PCIIOMMUOps *ops);
>   #else
>   static inline bool vtd_check_hiod_accel(IntelIOMMUState *s,
> @@ -62,6 +63,10 @@ static inline void vtd_pasid_cache_sync_accel(IntelIOMMUState *s,
>   {
>   }
>   
> +static inline void vtd_pasid_cache_reset_accel(IntelIOMMUState *s)
> +{
> +}
> +
>   static inline void vtd_iommu_ops_update_accel(PCIIOMMUOps *ops)
>   {
>   }
> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> index 451ede7530..b022f3cb9e 100644
> --- a/hw/i386/intel_iommu.c
> +++ b/hw/i386/intel_iommu.c
> @@ -391,6 +391,8 @@ static void vtd_reset_caches(IntelIOMMUState *s)
>       vtd_reset_context_cache_locked(s);
>       vtd_pasid_cache_reset_locked(s);
>       vtd_iommu_unlock(s);
> +
> +    vtd_pasid_cache_reset_accel(s);
>   }
>   
>   static uint64_t vtd_get_iotlb_gfn(hwaddr addr, uint32_t level)
> diff --git a/hw/i386/intel_iommu_accel.c b/hw/i386/intel_iommu_accel.c
> index 1e27c0feb8..e9e67eb1a0 100644
> --- a/hw/i386/intel_iommu_accel.c
> +++ b/hw/i386/intel_iommu_accel.c
> @@ -511,6 +511,19 @@ void vtd_pasid_cache_sync_accel(IntelIOMMUState *s, VTDPASIDCacheInfo *pc_info)
>       }
>   }
>   
> +/* Fake a gloal pasid cache invalidation to remove all pasid cache entries */
> +void vtd_pasid_cache_reset_accel(IntelIOMMUState *s)
> +{
> +    VTDPASIDCacheInfo pc_info = { .type = VTD_INV_DESC_PASIDC_G_GLOBAL };
> +    VTDHostIOMMUDevice *vtd_hiod;
> +    GHashTableIter as_it;
> +
> +    g_hash_table_iter_init(&as_it, s->vtd_host_iommu_dev);
> +    while (g_hash_table_iter_next(&as_it, NULL, (void **)&vtd_hiod)) {

s/as_it/hiod_it/

other part LGTM.

Reviewed-by: Yi Liu <yi.l.liu@intel.com>


> +        vtd_pasid_cache_invalidate(vtd_hiod, &pc_info);
> +    }
> +}
> +
>   static uint64_t vtd_get_host_iommu_quirks(uint32_t type,
>                                             void *caps, uint32_t size)
>   {


