Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A68E6CD4F5E
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2026 11:57:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQ21O-0004Ix-9g; Thu, 21 May 2026 07:57:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1wQ21J-0004Ii-B7
 for qemu-devel@nongnu.org; Thu, 21 May 2026 07:56:58 -0400
Received: from mgamail.intel.com ([198.175.65.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1wQ21G-0003gw-V4
 for qemu-devel@nongnu.org; Thu, 21 May 2026 07:56:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1779364615; x=1810900615;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=YjD+KL9KtEyjHJpG37DzWXTcTcZJRR5YtaNZ+2IXeQM=;
 b=S1Xgc+9Brmnx5HPNLOunei98GsYXqG3Nn1O1R+mvx5MkSTAemudkBYi3
 vIRBZbOWwPgOU/b+nrOCGB0fWhcZVwvhHMKxwC24/X5ClxG2ubcZPED/K
 q5t+rVkMwoFAlFJ1ChB+zw1yMr8r97fSO47CphdRbReWofZ2Tld9Ht1lT
 GK+teKhCLAsvtUpQ+fGiS3Ij684YHu1MMnJnvEfvb0Ko3hWPpFvyub/cr
 A5wzRYQ40XZFI9J6me524JwbLRxtPBRif5C+X3e6p3f/FNfZIRj7WaKdE
 PrRdD6s0hU4qO1uYOS2c+PZSHQCz65tH54L6JAPRPmvQBj/zxz4kOVdW9 A==;
X-CSE-ConnectionGUID: LnVMOF59SW+crJxeF3nM3Q==
X-CSE-MsgGUID: Q8ttF8hiSomSemTBZDk0dA==
X-IronPort-AV: E=McAfee;i="6800,10657,11792"; a="80459110"
X-IronPort-AV: E=Sophos;i="6.23,246,1770624000"; d="scan'208";a="80459110"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 May 2026 04:56:53 -0700
X-CSE-ConnectionGUID: aH6elMSKSQKaNdelgSTBcg==
X-CSE-MsgGUID: ovsV+aXLST2MW22CBLUukA==
X-ExtLoop1: 1
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 May 2026 04:56:53 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 21 May 2026 04:56:52 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 21 May 2026 04:56:52 -0700
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.66) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 21 May 2026 04:56:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=imhiNLjBRyUnmNDDfwy3qJDw+nMuNAgPQvv+sG3XUjX7HxthxM6lJRnkVNVFKdwAAqCAVEUXJ25ebKC6QcomZEx4Kn18280RdCVtE6fTDrCYUkjJiVtv0uHTjNlZKnbrr7rMk1Ml4CCRNJX5aJNdaAleNZJetFG9JwCODmwfNr04m5Z/9t9x6N+x9zFw7nr5ybVi36uBVj0PtJfIPySG5Tw44sUOS/mUgDuEWdlUehmh+2xpyfSDcGW6Mmj1qywZtTA54wHi7SVVRVvgUgHNX/zITHjjrgB/QtkwfGII7iAvYX64eiUotn9QaVekQZT/2SBz/Hba5gKg9MJEGAT4CA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o+PzMmaM/R7IL9rqoPqlJO/wuVTRzkNxRSrDXzSkkNU=;
 b=Tm3HoBOG+xplMWYJqoHoiS1u2DIbW1r/n2rOBNoaJCyvJM51uNJqnM2GSWOQirvD12ewMnrUEegtDiaAtvDWu7QXZ6rHvXtabuDGxVQjfE4fgIbbyhAPTjp1kLeVongVvIk4wga2Ztnlll8Mpm9NRb4vYI22AsHQzmIAfl+mprTd6ewptMko9Lomw8YmDCo55YYIka1Bvm4gQUI933qdVljWBa7CQNX4Bjw8Xpri/Kaj+W41n5+q2FT39M/bKcPNwizBGOqSXoye0+SBsHw8oDUcyqJKzQf0z9WteiJWyCUwWHFh6f+kcTYxaZxtDpfF/mAuV8/G9fs4VWwjDWyDgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV8PR11MB8509.namprd11.prod.outlook.com (2603:10b6:408:1e6::15)
 by LV3PR11MB8484.namprd11.prod.outlook.com (2603:10b6:408:1b4::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Thu, 21 May
 2026 11:56:44 +0000
Received: from LV8PR11MB8509.namprd11.prod.outlook.com
 ([fe80::f5bd:4dde:4f2f:20b7]) by LV8PR11MB8509.namprd11.prod.outlook.com
 ([fe80::f5bd:4dde:4f2f:20b7%5]) with mapi id 15.21.0048.013; Thu, 21 May 2026
 11:56:44 +0000
Message-ID: <c00ee663-720f-44ed-8938-6ae56b96b291@intel.com>
Date: Thu, 21 May 2026 20:04:50 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] intel_iommu_accel: Add PRQ injection for passthrough
 device
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, <qemu-devel@nongnu.org>
CC: <alex@shazbot.org>, <clg@redhat.com>, <eric.auger@redhat.com>,
 <mst@redhat.com>, <jasowang@redhat.com>, <jgg@nvidia.com>,
 <nicolinc@nvidia.com>, <skolothumtho@nvidia.com>,
 <joao.m.martins@oracle.com>, <clement.mathieu--drif@bull.com>,
 <kevin.tian@intel.com>, <xudong.hao@intel.com>
References: <20260327025228.474257-1-zhenzhong.duan@intel.com>
 <20260327025228.474257-4-zhenzhong.duan@intel.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <20260327025228.474257-4-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR01CA0021.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::19) To LV8PR11MB8509.namprd11.prod.outlook.com
 (2603:10b6:408:1e6::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR11MB8509:EE_|LV3PR11MB8484:EE_
X-MS-Office365-Filtering-Correlation-Id: f372c082-fc12-4d7e-ad35-08deb73006fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|42112799006|376014|7416014|366016|4143699003|18002099003|56012099003|11063799006|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info: PImSoHGk6kqbBVeuKIm5Nx8BBvov+mg3Sf9/RrAh06U0c4PyiM+IcYgfpOx013++SZeD/t0qTmrsf4o3P15njbfjq5A6Enn7CvP5bBF22tcLFj/atAeZrfhXqqQx0vV/oF9MbVAqwBcDf7UNf+mBu50jrCid79dCm4mjyGprFEtZyNBRxXiFd+UetmXU5dngbNKXF+BvmMWtJhbR93QwWVk5qrMQ4V+KaVPyM3V4oNoRQrwojNTxgeaDEKQ+7IBupxDfT/uWesTxoJgCtlcNDLceMv+RNfn2ei3l8FlYezVPS4F1qB2eCo6J+zgKu9wxr/gQ6aa+9BhZq97b09RJkfQHDFPvssLKTXDI0r3JnaYeDNa0tAsBBC37/G0fTGSwEhaY9Q0wHmjnDgY6LJAj0+yjPa0CGmmS+97/FnkbXw1RigXdORzCyc0F4zQpoAmuXOHaeZRmfv7sSSDBewLZuub330NU6FHsqzAp2Ij7afmzgF4L+Z0DjwMkwBWqcGs0gzrOmyo0bFenrJjFC+q7zO/2PvEbYRLO55GBTcPqqHV3FKIyBtqBKMVTUfT2FhrhiSU74zUYdW7tVC3f2Yn7JHDSST5Mxyd4g+KqdZc4eAtZ6yUd4uyiMgYx0WUUAGGhBa5+Wco4uS51thsCWJ8Bqu5T0qLZ78yKrv1pmde/5rXNnA2HKnRmIuRDt2foCuED
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV8PR11MB8509.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(42112799006)(376014)(7416014)(366016)(4143699003)(18002099003)(56012099003)(11063799006)(22082099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?THFFVTFwT2pPdEJGRUFFRm5kZ0tYRDlRa0U5L1RsTnJOSWNzNW4xVkRXSW5n?=
 =?utf-8?B?M1hsNzVIYloxYW51L2ZWKy9oMnF4bnFYbEo1MmlGZVNoRzVRcStvbXBHTHpj?=
 =?utf-8?B?WHQ4WE1hb1lDSHcwTktoWjdYenFLdElyTVJ3eW5xSk5XaUNDYi84MXh1NEpL?=
 =?utf-8?B?M1BoNXFzZjRSbUtVTE9xNkNieER0ekREVnBDbWlTVGdFUG9ydkQ2UzBrZXpl?=
 =?utf-8?B?ejU4TExNY25ab2w0WG5HaVNlclFVWHBxUkpYQUJ2Q3dkS0dMMUtEMVd6M1ZU?=
 =?utf-8?B?dCtmWHBzWjlpdnA5TVBRbGxwcUdEYWNtZy9qM2ptTkZtcnhIRkRLcGF5RzRu?=
 =?utf-8?B?M2tSbHNnK0FMVlhVK1ZGeGdwdzlsTG1TS1ZFNTFGbWZxMXQwL0E0R2hjK2FC?=
 =?utf-8?B?b1lwQjJOQjFvdTVjbVZkRFR1WnNOTlNWWVR3U3FMSml3WmYyU1I1VXBFL3Zk?=
 =?utf-8?B?Mk5JQkJXNVNMME5vVUxtZGV3RDVIQ25pYTU3NjJCYXhLaFZjVXRpOXo0N3l5?=
 =?utf-8?B?TFE2R2ZiL1Q1U1l4UkRSODN6MUc4THo5cmVKbjFVVGgySFlGemhXcVlqcXkz?=
 =?utf-8?B?QlBFdVB1aVp4TzlWVWdsLzMwYnhmQVoySHc0R09QdFJiZWJCNC95dXpDSDNm?=
 =?utf-8?B?VFpWakRhYm5rcHMwMTQ3Q1g1M1hjd2NObkdERXdKbk54Q2hrdUJNUUxwZ050?=
 =?utf-8?B?YVlYRXVuUDBlNEduQ2NZWkVzWjZxTFJwMklJSzllNStZU2V4VFdGNTFoQm45?=
 =?utf-8?B?bFhlakFlbGNQbCt5SklJbzBtK1pyY3JQTllnKzlZZ0c5WGFNRnBFWVNvNkhy?=
 =?utf-8?B?N0oxa1FBcVFjbDM3WmIxc3pFRWpnUG9Sc1MzV1pGMGtkY2JWN2x0azdSUkht?=
 =?utf-8?B?eUlwT2ZvUERCR0pJVE1Qakp6YXhqTU5YYzhEaEZKdlhwUldlU0c3SWJmY0ZD?=
 =?utf-8?B?aHN1Ti9BQkpiUi9xZWZUaXllelRKOXl0bEJoUmdUN1J4WlMrcHNlQ0FqL2hH?=
 =?utf-8?B?M0FrOWJyYWhRbU5aQ1JhZzlHbVhsWlZTc2ZMUWlrVmRvOWV5M2VuY0czS3ZD?=
 =?utf-8?B?Wnh1WFBlVnlVZklSQ015dTZOYXNkbW1EUmduTEpya1FZSWprZzNCWFYyUkh1?=
 =?utf-8?B?SE1XZlgycnRiamZsWmF6M1M5NEtwTng4TVhCZGdyRllSK3NDYnlQOEhIZ2dt?=
 =?utf-8?B?SkxnaExaa09ZUGI2MzZBVlB4LzgzMzN1U2t3TklydEJBb2tuNFJLTG5aTi9O?=
 =?utf-8?B?SWZLTkN5c05abzdQZXRFNU0rTTVVOHJuWEtQbGZ5Zk8zS294MHc0NzZwVHVC?=
 =?utf-8?B?dXlmRUVaUHNudXNWWGliVWhLT01tNGZId3VhQTF1ZVdpcHlzVUI2a1JxNWJh?=
 =?utf-8?B?MkJWd1c5ekxQMU9mK0o0SWpVYm9OVERpN1k1MnRlUXBOaWRDVGc5Mkx1T21p?=
 =?utf-8?B?QnlSbDU1Ui9nWE12WUxoQnl5VFg1TjhnVnhrc0FsYjVMN0lnZHRublQxMWZi?=
 =?utf-8?B?enFVNm5XR09Vb0gvUjUrRmVIWjd2WE9qMlVWRnBWVnF3RjlQOUQ4QVBtOE1B?=
 =?utf-8?B?RjBXNzIvNUVITjNmYjFJMGt4Sys4UDJ1eTVYSVYwcWxLY0ZaaUlVOWhFTlFq?=
 =?utf-8?B?VkNheXRrZmVTTk5XbWIycG5Vbm1HZ25ZVE1Nelh1UXhSTkhNa3RCam5NcjFX?=
 =?utf-8?B?Nld2cW9nQ1dXNnNJSmkwd1UreUVVZmo0c0pXZERXYzVKMlZxMmhYRWE4Ynli?=
 =?utf-8?B?RU9qaHhJNlExek1nblRUQ3Robks3eXRIUDllQkpvR1NmTFFueUp6UWljdVN1?=
 =?utf-8?B?c2R0NjVOK25hMHVEY1A3WTdmYlNJNEhjNFp1NTAzajhzVFVEeG5ueHBqSDdT?=
 =?utf-8?B?M0FjbzZRd2lSWDVuWDNWTU9hMGJGS203UlVlNnN4RG00Z25QUy9tYmxibUF2?=
 =?utf-8?B?SmVYbDBWYzVSTnREajRZQ3g4K0hnbnV1WVBsNEtVRVpNcWdyRlZhMGNuZFBB?=
 =?utf-8?B?YXFhNFI4Zm9EazB2SkgzTDR0OGdJUXZjTjRRYlU0Z21GbHpLVndIWmswNEk2?=
 =?utf-8?B?RWVwNnBuSm1XMVlLSWNUMmRENnNiRmJmOHkxa3c3OHllMllEeU0rVW5GYkFw?=
 =?utf-8?B?NjMwUXdPaDl3cittdCt0MFZ5QXROYzZ1YUZDVWFidk0vQkJXdGo5WGYvZHJu?=
 =?utf-8?B?aURPckNDTmxLR3dKMjNpTmpZVi81T29XZTlSckJqbHB1bUMrUnpvVG1IODJz?=
 =?utf-8?B?NTM4WmlLQjF4SlY5Q0J6MEVLRmhMbjJsaGxWOENBSDBieVVkWmI4YmlLNzZD?=
 =?utf-8?B?dXgyMlQzUHBKZEIyeTB2WDFEVFovM1BicGora2w0YytLOWtBQlo2Zz09?=
X-Exchange-RoutingPolicyChecked: TTVGq6iUW4fBKDnYV0S2kO18uyq0lTQ41/G1cKA6JEpITjOHG7WN+mESTdLtShbRKRXbzlk4ul5ARiySf4gHBUSjr65VX0nQpaZBqtEEpAmoYSAHAVrAxFGUy4CkvemrIgCWw6TIC3Eyv59q5NZdVbrNIZoSObgd79WV4aZn72XvfPoaSGAkpjr8dKVcJznD1ZIz3f7wB90k0y1JK4PIExnv9S0Yh1uNKpYqntM3RWkA70KJ99HMR6mNP3pzlVbgOyz+qE25xv8eNO+AZOpvHp4And+iuifPtVtrbXucEVyHNJJubJ4Il9DYXtfdctP616IVTkNlACCGI7IiBU8Xsg==
X-MS-Exchange-CrossTenant-Network-Message-Id: f372c082-fc12-4d7e-ad35-08deb73006fa
X-MS-Exchange-CrossTenant-AuthSource: LV8PR11MB8509.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2026 11:56:44.0111 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PNneGQ8RqeCPN52kemaDunmh3sqYWvKznQM/ELyrhelIUQj/qZg6e8HdYcim9KUHJ4bBY4rcUzLtKB9fDjp88g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR11MB8484
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.16; envelope-from=yi.l.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

On 3/27/26 10:52, Zhenzhong Duan wrote:
> When the guest enables the PRQ in vIOMMU, allocate a FAULTQ object so that
> host-side recoverable fault events can be received and propagated back to
> the guest.
> 
> Install an event handler on the FAULTQ fd to read and propagate host
> generated recoverable fault events to the guest.
> 
> The handler runs in QEMU's main loop, using a non-blocking fd registered
> via qemu_set_fd_handler().
> 
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> ---
>   hw/i386/intel_iommu_accel.h |   2 +
>   hw/i386/intel_iommu_accel.c | 151 +++++++++++++++++++++++++++++++++++-
>   hw/i386/trace-events        |   1 +
>   3 files changed, 150 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/i386/intel_iommu_accel.h b/hw/i386/intel_iommu_accel.h
> index 45a12e0292..10e6ee5722 100644
> --- a/hw/i386/intel_iommu_accel.h
> +++ b/hw/i386/intel_iommu_accel.h
> @@ -17,6 +17,8 @@ typedef struct VTDAccelPASIDCacheEntry {
>       VTDPASIDEntry pasid_entry;
>       uint32_t pasid;
>       uint32_t fs_hwpt_id;
> +    uint32_t fault_id;
> +    int fault_fd;
>       QLIST_ENTRY(VTDAccelPASIDCacheEntry) next;
>   } VTDAccelPASIDCacheEntry;
>   
> diff --git a/hw/i386/intel_iommu_accel.c b/hw/i386/intel_iommu_accel.c
> index 32cca7672a..0fce62ff75 100644
> --- a/hw/i386/intel_iommu_accel.c
> +++ b/hw/i386/intel_iommu_accel.c
> @@ -9,6 +9,7 @@
>    */
>   
>   #include "qemu/osdep.h"
> +#include "qemu/error-report.h"
>   #include "system/iommufd.h"
>   #include "intel_iommu_internal.h"
>   #include "intel_iommu_accel.h"
> @@ -38,6 +39,8 @@ static inline int vtd_hiod_get_pe_from_pasid(VTDAccelPASIDCacheEntry *vtd_pce,
>       return vtd_ce_get_pasid_entry(s, &ce, pe, pasid);
>   }
>   
> +static PCIIOMMUOps *accel_ops;
> +
>   bool vtd_check_hiod_accel(IntelIOMMUState *s, VTDHostIOMMUDevice *vtd_hiod,
>                             Error **errp)
>   {
> @@ -99,8 +102,137 @@ VTDHostIOMMUDevice *vtd_find_hiod_iommufd(VTDAddressSpace *as)
>       return NULL;
>   }
>   
> -static bool vtd_create_fs_hwpt(VTDHostIOMMUDevice *vtd_hiod,
> -                               VTDPASIDEntry *pe, uint32_t *fs_hwpt_id,
> +static void vtd_prq_report_fault(VTDAccelPASIDCacheEntry *vtd_pce,
> +                                 struct iommu_hwpt_pgfault *fault, int cnt)
> +{
> +    VTDHostIOMMUDevice *vtd_hiod = vtd_pce->vtd_hiod;
> +
> +    for (; cnt--; fault++) {
> +        bool last_page = fault->flags & IOMMU_PGFAULT_FLAGS_LAST_PAGE;
> +
> +        accel_ops->pri_request_page(vtd_hiod->bus, vtd_hiod->iommu_state,
> +                                    vtd_hiod->devfn, vtd_pce->pasid,
> +                                    fault->perm & IOMMU_PGFAULT_PERM_PRIV,
> +                                    fault->perm & IOMMU_PGFAULT_PERM_EXEC,
> +                                    fault->addr, last_page, fault->grpid,
> +                                    fault->perm & IOMMU_PGFAULT_PERM_READ,
> +                                    fault->perm & IOMMU_PGFAULT_PERM_WRITE);
> +    }
> +}
> +
> +#define FAULTQ_BUF_SIZE 100 /* Large enough in regular test */

hmmm. the comment is misleading, any evidence show this is large enough?
Or modify the comment a bit like below:

  /* Batch size per read(); remaining faults trigger another callback */

> +
> +static void vtd_prq_read_fault(void *opaque)
> +{
> +    VTDAccelPASIDCacheEntry *vtd_pce = opaque;
> +    struct iommu_hwpt_pgfault fault[FAULTQ_BUF_SIZE];
> +    uint32_t id = vtd_pce->fault_id, fd = vtd_pce->fault_fd;
> +    ssize_t bytes, last_bytes;
> +
> +    bytes = read(fd, fault, sizeof(fault));
> +    trace_vtd_prq_read_fault(id, fd, bytes);
> +    if (bytes < 0) {
> +        if (errno != EAGAIN && errno != EINTR) {
> +            error_report_once("FAULTQ(id %u): read failed (%m)", id);
> +        }
> +        return;
> +    } else if (!bytes) {
> +        error_report_once("FAULTQ(id %u): fault group too big", id);
> +        return;
> +    }
> +
> +    last_bytes = bytes % sizeof(fault[0]);
> +    if (last_bytes) {
> +        error_report_once("FAULTQ(id %u): discard partial fault data: %zd/%zu",
> +                          id, last_bytes, sizeof(fault));
> +    }
> +
> +    vtd_prq_report_fault(vtd_pce, fault, bytes / sizeof(fault[0]));
> +}
> +
> +static void vtd_destroy_fs_faultq(VTDHostIOMMUDevice *vtd_hiod,
> +                                  uint32_t fault_id, uint32_t fault_fd)
> +{
> +    HostIOMMUDeviceIOMMUFD *idev = HOST_IOMMU_DEVICE_IOMMUFD(vtd_hiod->hiod);
> +
> +    if (!fault_id) {
> +        return;
> +    }
> +
> +    close(fault_fd);
> +    iommufd_backend_free_id(idev->iommufd, fault_id);
> +}
> +
> +static bool vtd_create_fs_faultq(VTDHostIOMMUDevice *vtd_hiod,
> +                                 uint32_t *fault_id_p, uint32_t *fault_fd_p,
> +                                 Error **errp)
> +{
> +    HostIOMMUDeviceIOMMUFD *idev = HOST_IOMMU_DEVICE_IOMMUFD(vtd_hiod->hiod);
> +    IntelIOMMUState *s = vtd_hiod->iommu_state;
> +    uint8_t bus_n = pci_bus_num(vtd_hiod->bus);
> +    uint32_t fault_id, fault_fd;
> +    VTDContextEntry ce;
> +    int flags;
> +
> +    if (!s->svm ||

s->svm is first referenced here, but no definition found.

> +        vtd_dev_to_context_entry(s, bus_n, vtd_hiod->devfn, &ce) ||
> +        !VTD_CE_GET_PRE(&ce)) {
> +        *fault_id_p = 0;
> +        return true;
> +    }
> +
> +    if (!iommufd_backend_alloc_faultq(idev->iommufd, &fault_id, &fault_fd,
> +                                      errp)) {
> +        return false;
> +    }
> +
> +    flags = fcntl(fault_fd, F_GETFL);
> +    if (flags < 0) {
> +        error_setg_errno(errp, errno, "Failed to get flags for FAULTQ fd");
> +        goto free_faultq;
> +    }
> +
> +    if (fcntl(fault_fd, F_SETFL, flags | O_NONBLOCK) < 0) {
> +        error_setg_errno(errp, errno, "Failed to set O_NONBLOCK on FAULTQ fd");
> +        goto free_faultq;
> +    }
> +
> +    *fault_id_p = fault_id;
> +    *fault_fd_p = fault_fd;
> +    return true;
> +
> +free_faultq:
> +    vtd_destroy_fs_faultq(vtd_hiod, fault_id, fault_fd);
> +    return false;
> +}
> +
> +static void vtd_destroy_old_fs_faultq(VTDHostIOMMUDevice *vtd_hiod,
> +                                      VTDAccelPASIDCacheEntry *vtd_pce)

vtd_pce records vtd_hiod? Also, the naming is strange. how about?


vtd_create_fs_faultq() -> vtd_alloc_fs_faultq()
vtd_destroy_fs_faultq() -> vtd_free_fs_faultq()
vtd_setup_fs_faultq() -> vtd_attach_fs_faultq()
vtd_destroy_old_fs_faultq() -> vtd_destroy_release_fs_faultq()

> +{
> +    if (!vtd_pce->fault_id) {
> +        return;
> +    }
> +
> +    qemu_set_fd_handler(vtd_pce->fault_fd, NULL, NULL, NULL);
> +    vtd_destroy_fs_faultq(vtd_hiod, vtd_pce->fault_id, vtd_pce->fault_fd);
> +    vtd_pce->fault_id = 0;
> +    vtd_pce->fault_fd = -1;
> +}
> +
> +static void vtd_setup_fs_faultq(VTDAccelPASIDCacheEntry *vtd_pce,
> +                                uint32_t fault_id, uint32_t fault_fd)
> +{
> +    if (!fault_id) {

using zero to check fault_id is not reliable.

> +        return;
> +    }
> +
> +    vtd_pce->fault_id = fault_id;
> +    vtd_pce->fault_fd = fault_fd;
> +    qemu_set_fd_handler(fault_fd, vtd_prq_read_fault, NULL, vtd_pce);
> +}
> +
> +static bool vtd_create_fs_hwpt(VTDHostIOMMUDevice *vtd_hiod, VTDPASIDEntry *pe,
> +                               uint32_t fault_id, uint32_t *fs_hwpt_id,
>                                  Error **errp)
>   {
>       HostIOMMUDeviceIOMMUFD *idev = HOST_IOMMU_DEVICE_IOMMUFD(vtd_hiod->hiod);
> @@ -115,7 +247,8 @@ static bool vtd_create_fs_hwpt(VTDHostIOMMUDevice *vtd_hiod,
>   
>       return iommufd_backend_alloc_hwpt(idev->iommufd, idev->devid, idev->hwpt_id,
>                                         flags, IOMMU_HWPT_DATA_VTD_S1,
> -                                      sizeof(vtd), &vtd, 0, fs_hwpt_id, errp);
> +                                      sizeof(vtd), &vtd, fault_id, fs_hwpt_id,
> +                                      errp);
>   }
>   
>   static void vtd_destroy_old_fs_hwpt(VTDHostIOMMUDevice *vtd_hiod,
> @@ -137,6 +270,7 @@ static bool vtd_device_attach_iommufd(VTDAccelPASIDCacheEntry *vtd_pce,
>       HostIOMMUDeviceIOMMUFD *idev = HOST_IOMMU_DEVICE_IOMMUFD(vtd_hiod->hiod);
>       VTDPASIDEntry *pe = &vtd_pce->pasid_entry;
>       uint32_t hwpt_id = idev->hwpt_id, pasid = vtd_pce->pasid;
> +    uint32_t fault_id = 0, fault_fd;
>       bool ret;
>   
>       /*
> @@ -151,7 +285,11 @@ static bool vtd_device_attach_iommufd(VTDAccelPASIDCacheEntry *vtd_pce,
>       }
>   
>       if (vtd_pe_pgtt_is_fst(pe)) {
> -        if (!vtd_create_fs_hwpt(vtd_hiod, pe, &hwpt_id, errp)) {
> +        if (!vtd_create_fs_faultq(vtd_hiod, &fault_id, &fault_fd, errp)) {
> +            return false;
> +        }
> +        if (!vtd_create_fs_hwpt(vtd_hiod, pe, fault_id, &hwpt_id, errp)) {
> +            vtd_destroy_fs_faultq(vtd_hiod, fault_id, fault_fd);
>               return false;
>           }
>       }
> @@ -161,11 +299,14 @@ static bool vtd_device_attach_iommufd(VTDAccelPASIDCacheEntry *vtd_pce,
>       if (ret) {
>           /* Destroy old fs_hwpt if it's a replacement */
>           vtd_destroy_old_fs_hwpt(vtd_hiod, vtd_pce);
> +        vtd_destroy_old_fs_faultq(vtd_hiod, vtd_pce);
>           if (vtd_pe_pgtt_is_fst(pe)) {
>               vtd_pce->fs_hwpt_id = hwpt_id;
> +            vtd_setup_fs_faultq(vtd_pce, fault_id, fault_fd);
>           }
>       } else if (vtd_pe_pgtt_is_fst(pe)) {
>           iommufd_backend_free_id(idev->iommufd, hwpt_id);
> +        vtd_destroy_fs_faultq(vtd_hiod, fault_id, fault_fd);
>       }
>   
>       return ret;
> @@ -197,6 +338,7 @@ static bool vtd_device_detach_iommufd(VTDAccelPASIDCacheEntry *vtd_pce,
>   
>       if (ret) {
>           vtd_destroy_old_fs_hwpt(vtd_hiod, vtd_pce);
> +        vtd_destroy_old_fs_faultq(vtd_hiod, vtd_pce);
>       }
>   
>       return ret;
> @@ -549,4 +691,5 @@ static uint64_t vtd_get_host_iommu_quirks(uint32_t type,
>   void vtd_iommu_ops_update_accel(PCIIOMMUOps *ops)
>   {
>       ops->get_host_iommu_quirks = vtd_get_host_iommu_quirks;
> +    accel_ops = ops;
>   }
> diff --git a/hw/i386/trace-events b/hw/i386/trace-events
> index 5fa5e93b68..bf139338f7 100644
> --- a/hw/i386/trace-events
> +++ b/hw/i386/trace-events
> @@ -77,6 +77,7 @@ vtd_reset_exit(void) ""
>   vtd_device_attach_hwpt(uint32_t dev_id, uint32_t pasid, uint32_t hwpt_id, int ret) "dev_id %d pasid %d hwpt_id %d, ret: %d"
>   vtd_device_detach_hwpt(uint32_t dev_id, uint32_t pasid, int ret) "dev_id %d pasid %d ret: %d"
>   vtd_device_reattach_def_hwpt(uint32_t dev_id, uint32_t pasid, uint32_t hwpt_id, int ret) "dev_id %d pasid %d hwpt_id %d, ret: %d"
> +vtd_prq_read_fault(uint32_t fault_id, uint32_t fault_fd, ssize_t bytes) "fault_id %d fault_fd %d ret: %zd"
>   
>   # amd_iommu.c
>   amdvi_evntlog_fail(uint64_t addr, uint32_t head) "error: fail to write at addr 0x%"PRIx64" +  offset 0x%"PRIx32


