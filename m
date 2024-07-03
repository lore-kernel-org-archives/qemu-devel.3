Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D56F3C2BD09
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2024 12:29:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOz6a-0003LZ-J6; Wed, 03 Jul 2024 08:29:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1sOz6W-0003JH-Iu
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 08:28:56 -0400
Received: from mgamail.intel.com ([192.198.163.7])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1sOz6S-0006Ns-S8
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 08:28:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1720009733; x=1751545733;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=tjl5BiHKcW26RrCdc3De/TIZBLl+oFGJX6lm17rCO3M=;
 b=hkH8EPFXFKGhUDlKIHB6gsijSh3jksmRypbBjR4arTf3Qh1JLmfnVWeW
 DN1nz+gRhJNeI7BMDSOSjlVeXkKuvj82MArrvprrjZfdALdRclJ1fVtFm
 pGkIRs3eVezwJUK/dsXFAHD1mQnr/kUefiHflknnSa3u+2BHl9KlSSltj
 0AC15+KBrmZP2zpwtbRka9Ivec2UIrvvM3BdMu/5ZRSchT6SgPm/F0SlS
 7d+LBRYsH1ZRoA7Brcdrtc2z66KLsJKxQvK/yON9yONclBl3iRsPqw5E2
 D+0DS5uJ9QLXHXVxWakX55e2AwVBuKzRMESLU1rzzET55uEnqmi3PP7wV w==;
X-CSE-ConnectionGUID: 16iaFwliSxSh8Gr8kIi86A==
X-CSE-MsgGUID: cQw7EC4VQlWFrgeElvEeEQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11121"; a="42662730"
X-IronPort-AV: E=Sophos;i="6.09,182,1716274800"; d="scan'208";a="42662730"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jul 2024 05:28:50 -0700
X-CSE-ConnectionGUID: fZp2MAvaTQm7wmOi+Z7IvA==
X-CSE-MsgGUID: xxRECoBsR8m2pYQy6ZbvAA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,182,1716274800"; d="scan'208";a="50678356"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
 by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 03 Jul 2024 05:28:50 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 3 Jul 2024 05:28:49 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 3 Jul 2024 05:28:49 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 3 Jul 2024 05:28:49 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 3 Jul 2024 05:28:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HhfLWfMdIIL75zn82dOf8hg/KhIeD3DXPm5/z9GKaJ/Aqado9yNiLe34LbthLfDIzWK9hqvRJsb2ZUH4li/7UrC17wydeoGmQgV/4Q7t77Jv9O+Gv/UlaLBCDuprTunSHZmA/SzjUlxHwFEqsaKLFZLcwsSrfJH/ApKPMUm6kjpHZPp5gLLK015XH8lQlZdDHRfNI3CWZgjcIL7WlvYZ1xoKEcWoWqIuDfdALCrmF8Bb0DGzOrf5Oy9sLS8TZCFt4N4Fdxcz/wgNryeQSx6D0o6HVT4NV2xxaoDkFXhBxDAz50DbF0dY8xs6YAtuNBdV/rC0dCgQW5rgkLUdyx15OQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tx8agNWhuGWGBBfygbxMhVXvliVtSyd/YF7uOuuDgW0=;
 b=XnipFh459Dr1fiDM8xldvIz+5QO9usp0vkzS3ZjnXlSijlstEZTb9tQAUT0oVpPYLwC3PvuSaAn2nC9vHW0Eqllbd8tEx+DrnfaJKBmmm48MpeAR32Jj4xAY8dAzpv1ZcIwimRpN32UbyxjGGDM+lO4H6PrPV52Opt2i5BwKrVyIuDW0OwgS5uygkhSS4DEvNXB7Mz5E8wnYbJeNEQgq4r6wVVuN9+wm+XnZSsPtcvlo2xvsoZsx/dZnsmSC8uKQVyWY+FP/PFnvC+2VXtYeq/+pe/4CU8jqnN4oVyVByJHsFoiPWw0mxxf8tf99NAy3yvqeFHiJf0IOOT4Sp6HV7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by SN7PR11MB7418.namprd11.prod.outlook.com (2603:10b6:806:344::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.26; Wed, 3 Jul
 2024 12:28:45 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a%3]) with mapi id 15.20.7719.022; Wed, 3 Jul 2024
 12:28:44 +0000
Message-ID: <1d0c56fe-b821-43c3-9e40-b686573ca840@intel.com>
Date: Wed, 3 Jul 2024 20:32:40 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ats_vtd v5 00/22] ATS support for VT-d
To: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "jasowang@redhat.com" <jasowang@redhat.com>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>, "peterx@redhat.com"
 <peterx@redhat.com>, "mst@redhat.com" <mst@redhat.com>, Clement Mathieu--Drif
 <cmdetu@gmail.com>
References: <20240702055221.1337035-1-clement.mathieu--drif@eviden.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <20240702055221.1337035-1-clement.mathieu--drif@eviden.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2P153CA0012.APCP153.PROD.OUTLOOK.COM (2603:1096::22) To
 DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|SN7PR11MB7418:EE_
X-MS-Office365-Filtering-Correlation-Id: 34e31acb-7d4e-4813-801d-08dc9b5bae24
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UEdjQ1NQM0JaNmU3MTlGOXhacFh3bG1UbFBxcVdFdlArb0JSWXIwUXlXZ3FR?=
 =?utf-8?B?a1pPRm5ETVhiU3pycitOaEtIVHZjNk5NK1BDRlJrUGd6MjJIWStkaHBXd1dG?=
 =?utf-8?B?Slc2VkRqTy9ZQm1RMEUyVXM1TjRLcjZGclhhYmV2eFhjTW5obmR6UHFtRnJE?=
 =?utf-8?B?OWU3Z2Y3Ny9oZThFV3p3dDJvcS8xU1RPc1ZQNXo5ZWx2K2pOOTd3c0paWktO?=
 =?utf-8?B?cGZQYTRkOWR6MDYyMU1qTGZtcStsSTVibnFMZVpQWnY5Tm0zTVNLZU1qamps?=
 =?utf-8?B?alZIZ0l6VEFPQ0Z6amZtaEhvaFA1QTZMQUdhOWlQQ2t3Vk42MS9hSmdoMlZC?=
 =?utf-8?B?ZGt1b3NCR1U1T2VRSThyZ253MXowL2dXK216dm40RE52cWRDNHRobHJoMUVD?=
 =?utf-8?B?a051QjlCeXUzNFZmRXhRbVdwQXJuTnNBRW0zNk15ck1QR2ppTmNxalY5aG9V?=
 =?utf-8?B?K0NGSVVnTE8xMngrSmVhUlFmc3ozWmk5MGl2MW10QnZXc1pUNmFVSnRkUnIy?=
 =?utf-8?B?Q2xreG5rbFp6L202UjcrUUcrMS81Sk9vcVV0RTdJdTIydVRWZUtSMEUrYldh?=
 =?utf-8?B?QXNBZE5ETWNDejhZclZDZW9ZWFgxaHVqQUxYMG5qM29hbXJ5aGVGcm9wYmlQ?=
 =?utf-8?B?bER3bzZiSXBza0I5RWpvOHFOaUhLZUR4eWhNdktnZXErWWJQSWNML1kzMkVu?=
 =?utf-8?B?KytDdGxZZFlMZWxXN01IQ3QzNy9TMCtQMyswQTZhUjlDVmtGenphQ2Z6eHNq?=
 =?utf-8?B?OHhkYThtK3UyRnp1VTdoRERLS1VRU3JDOUdDUUR6amFnVU1ESVppK3lHNUl4?=
 =?utf-8?B?WU55S3cxeXNpRTVKNVJPdWZBVkNPUG1KQkgycXIyaTFJaXZoTk9hMEo1QlEr?=
 =?utf-8?B?TEh4czBXcmNORFg5MWVJcFIxYTRGeDIyM2V5ZXNnUUpVMWR2NUwxUm5aVElj?=
 =?utf-8?B?TGVySE9DZ3BYYXJVYlJrckoxMkxhdjhYbEN1M3ZTZ3poNG9FUDE4NEo1NUV5?=
 =?utf-8?B?NHRxVlVmdmFMYTJ6RUQ5T3NnS3JKWkMwaGFqSzdCamxNRk9DRFQwNDF2SCtm?=
 =?utf-8?B?K2VKV0RlREsvY2pqNURJOWVBSnJ6MjdRYmNIaDczVzl4OFF2ek1SejdSenlI?=
 =?utf-8?B?TUE1Q1FnZ2hPekwxSStVanlYb3B0ako1NXc4bk1JMzZKbHBMcmVER1puUWVw?=
 =?utf-8?B?TW5oS1VQMzEyOU5FTEg3UWYwVXZFbkR1bkJrNVZYT2MyeGVoQ2E2c09oUkd6?=
 =?utf-8?B?cEN1eGJLbkhtQk5tT2p6akxFZUVYNHpZdmcxT08vdXRVbloxbk9Mb0lTT1FE?=
 =?utf-8?B?cUgyT21tSUVwZUR3cVBwdUhEcjM4VC83dktKMGROd0g0RlFEQUtiYU1LTnJt?=
 =?utf-8?B?dVdYaTFTT1NzUnZxdk9nYk9KWW5pakYxSlp1OG1OWUd5cXF0QXZITEZualI4?=
 =?utf-8?B?UHNGYUFQaHdiTWgyRHdleGkrbDlTNW12a2Q2R1IycEtGVE1GTUJPUnFFQWE5?=
 =?utf-8?B?OEdnQ0pOZkZkVVIwNk1UNVNKeHhURHhHVXBhd3phT2gySkdNRnF4YzE4dlgw?=
 =?utf-8?B?U0tLc1ZLNUZhWlQ0NHhoNnBBM0xQMG5VSDltSUd5RHNFL3BTcnE0b1NiMFk3?=
 =?utf-8?B?Y3U3dFRvcGFIMU1NTHhPQ3ZMTDZzVFg4ZkNKY01seGdEdWRubHpDN1hhWjRS?=
 =?utf-8?B?cnNTSzdpVUl6VVVMUzgvV2NjYyt6WFROR2kyWThBdCtBUW1LaUpmN2ZiRUxL?=
 =?utf-8?Q?IAzCimzOenPCShK8Qo=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7529.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V2J3YkRBSnFHeUhBNUVKWFZUbUV0NjhwRW1OVnByWmFpMFdKcFRqamZlakNS?=
 =?utf-8?B?MldXTDlyWWlxSHcwVGtBSFUrRHovTGlib25iM3JNejQzKzJ1OWdKNDQxcVl5?=
 =?utf-8?B?TDgyZW5kc28rSW5kNVJOenlHYjhnSnpDV2hyNVA0SnUrZVFGTG1STUpCd2VS?=
 =?utf-8?B?OElZZUQ3T0FnWG5abnVGZUZmaGxtc01OVkZUQlFuTEpwTVJ6ZE1SRWhXd25W?=
 =?utf-8?B?MUxjS0NBVmpBU0FBRDVYb1ZZb1R3OXhvNXNmeVlxUEhPWmV0MU9UR3FPekFZ?=
 =?utf-8?B?Sm1zTEJ5YXZYelVWdEZsYkgxdUZnUGJvdlFGbDMwZGZFcUZCZGllZ1FITUhu?=
 =?utf-8?B?cEc3aUtnOGgzSGFCNUZlSDJBei81c0JkSG1SK3JYbXNSUnc2NThSK1Y2UEtJ?=
 =?utf-8?B?VXlEOXU5MU9zdU9ka2NCQ1dzUFJNdWxBS214cUxEbEdHeCtmRkRMYSttTlE5?=
 =?utf-8?B?OXYzUVJhc0J4UHFXZVk5VmdkRlQwQ1prdnE1YWpJTzQvOHo1LzlISGU0U1N4?=
 =?utf-8?B?cllydytFUzFwdklKWEIwU2pGNFgyQnpqdmwxMWtibmY2UVdEaUJnNUY3NzBJ?=
 =?utf-8?B?YVFSbkg2RFQwSGR5K0tMMzM0L3o1SzRUK2xTMloxdTg5WkxnYnpIQ3JGdHRJ?=
 =?utf-8?B?R2FkQ1YvQXB3Tm5Nb0FLNVQrV3VnVHdjUTVmVFArZ0FpcVp1OWZRZGQ5Ti9P?=
 =?utf-8?B?SmNiOVgxU0xmVmVKZUJYWURHN21BMlJnbEIvc2pJaUM3dFJ3TndYM3luU3RO?=
 =?utf-8?B?NUpGY0RDTEUyVi92MTh1UWdyWFZXZkNNTGRUNXJROTUxeUN2bXZzWThKdTRk?=
 =?utf-8?B?NnBxb1BRUHJoMzdWZ0ZQTDBPQ2hxOXBQb2dZYWl3ZnFVT3NEc214eldja1dv?=
 =?utf-8?B?WUxWRGhlMEJQWDdJMXhPTkZQRFRqcDFLcU1DVndJRzhFUkQzdDJlbzB4Q3J1?=
 =?utf-8?B?VnNKdllkMU9FWktpK044cXhicklrRWNPbUh6eTNMaG9WZ0YzazlqdVhIYlRN?=
 =?utf-8?B?RUNGK2QxVkdSd29YcTZlWVJDd21rMlIwbEVwenNIS0Q0MU4yUHZoUThYdE5x?=
 =?utf-8?B?aEhITW43eWYyL3BCUGVnUllKMWlGWDRkQllLenM2VE1hRjZ3eitob2xzdndx?=
 =?utf-8?B?czVEdjRhbExjMTYrQWNsczZJQWZxK2xyampzazhkVSswMzh2dHcxcVd3ODlN?=
 =?utf-8?B?VkNnVWVRMVhOQ2FYTVQ0MllBYnRUL3pMYklMbmdhcis4c2lZamdNTDI3aWla?=
 =?utf-8?B?alV0V3c4TU1ZWGFNcE5yUDRaUVR2ZkwyeTZtNUI1MzJzMTE1RHhCNU1hS09H?=
 =?utf-8?B?N2EwYUtobDgrSFpKdndFKzhvNW9RZnFaWFZuRlJFSktOa1NiRkgxUVJieEh4?=
 =?utf-8?B?aE1oYnZGZW05a2xCaXRoQzFiVndEM0x1endHcWprSnNvZ3JVbUZUalJDYlNR?=
 =?utf-8?B?MGo1SXFSTUdwdHZyczdDWWg1dVY1QVV6amlZRlg5dlg5U2dIbUoyUE1MZWxL?=
 =?utf-8?B?MGJHL3lZb0JqQnhSdzI1QXRNNWhlR1p3SVVwQ2ZQdzZqY2RpUmpZRUVJenRv?=
 =?utf-8?B?MWY3K0o5dDZrZTRvaytGN09PZjExU1AvUnRDNlRpejlRUFJ1eCtONVorRHhv?=
 =?utf-8?B?WXRkV3djUEZoaUJFZnJ6aXRkR1dBNVI4WkdQN25ya2l2RmxtQzNDSURJeks4?=
 =?utf-8?B?VGpDRVJVRUJRaW8yNW54ME00bG16WWhTbjF0b3JmRDJuWkN6NWRsVXJGeUdh?=
 =?utf-8?B?TXEyQldJRVZtK2JtWnNIQVlJYjhXbStPUGlKVnNXLytDZEJtMm5raHgwNTky?=
 =?utf-8?B?YlVXaXFUQWU0VWorU1Rzb2h1bWFKdzMzak55Ym5mcElndVdqbEZ3V2RuMzdO?=
 =?utf-8?B?VW5BVk1QYWlNVUxJb0lveGNBVk54aXpzSGdRQjNvNmVoZ0pHT2VRakttcCtY?=
 =?utf-8?B?UllZRTJvS2dUNEFlY3ByY3I1K1dMSW8yc2tZTnAzWXErNG5FMXZGZTFoZlo0?=
 =?utf-8?B?S2s4YVJxQ0dxZ0pSVzJpQ3orYkRocXNhaytnM2REbzhXbUYzcEhLcitCaThi?=
 =?utf-8?B?bmR3cWQ3RVU2aEkrT1VUYjVIdnR4SXFDdHU2enFUeklDTTEwczRhVzA5dW5Q?=
 =?utf-8?Q?fOyGEY/3+OavMx55inl6i0gJi?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 34e31acb-7d4e-4813-801d-08dc9b5bae24
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2024 12:28:44.8524 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IOWC7du/UVrVZdxNtYKwJ82wMrdwJDpZkED0DxoPjRBVG4oOLYhS4dajdVQXsI1ZVNXijgR4JCvbVOgj0eFG9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7418
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.7; envelope-from=yi.l.liu@intel.com;
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

Hi CMD,

I've went through the series. Some general suggestions on the series.

1) Patch 01, 02, 04 can be sent separately as they are fixes.
2) This series mixed the ATS and PASID capability a bit. Actually,
    they don't have dependency. I'd suggest you split the series into
       - support ATS for the requests without PASID
       - support ATS for requests with PASID
    The second part should be an incremental change based on the first
    part. If you can make use of the existing translate() callback, then
    it is possible to remove the dependency on Zhenzhong's stage-1 series.
3) Some commits do not have commit message. It would be good to have
    it.
4) Some helpers look to be used by device model, if possible, it's better
    to submit them with a demo device.
5) A design description in the cover-letter would be helpful.

On 2024/7/2 13:52, CLEMENT MATHIEU--DRIF wrote:
> From: Clement Mathieu--Drif <cmdetu@gmail.com>
> 
> This series belongs to a list of series that add SVM support for VT-d.
> 
> As a starting point, we use the series called 'intel_iommu: Enable stage-1 translation' (rfc2) by Zhenzhong Duan and Yi Liu.
> 
> Here we focus on the implementation of ATS support in the IOMMU and on a PCI-level
> API for ATS to be used by virtual devices.
> 
> This work is based on the VT-d specification version 4.1 (March 2023).
> Here is a link to a GitHub repository where you can find the following elements :
>      - Qemu with all the patches for SVM
>          - ATS
>          - PRI
>          - Device IOTLB invalidations
>          - Requests with already translated addresses
>      - A demo device
>      - A simple driver for the demo device
>      - A userspace program (for testing and demonstration purposes)
> 
> https://github.com/BullSequana/Qemu-in-guest-SVM-demo
> 
> v2
>      - handle huge pages better by detecting the page table level at which the translation errors occur
>      - Changes after review by ZhenZhong Duan :
>      	- Set the access bit after checking permissions
>      	- helper for PASID and ATS : make the commit message more accurate ('present' replaced with 'enabled')
>      	- pcie_pasid_init: add PCI_PASID_CAP_WIDTH_SHIFT and use it instead of PCI_EXT_CAP_PASID_SIZEOF for shifting the pasid width when preparing the capability register
>      	- pci: do not check pci_bus_bypass_iommu after calling pci_device_get_iommu_bus_devfn
>      	- do not alter formatting of IOMMUTLBEntry declaration
>      	- vtd_iova_fl_check_canonical : directly use s->aw_bits instead of aw for the sake of clarity
> 
> v3
>      - rebase on new version of Zhenzhong's flts implementation
>      - fix the atc lookup operation (check the mask before returning an entry)
>      - add a unit test for the ATC
>      - store a user pointer in the iommu notifiers to simplify the implementation of svm devices
>      Changes after review by Zhenzhong :
>      	- store the input pasid instead of rid2pasid when returning an entry after a translation
>      	- split the ATC implementation and its unit tests
> 
> v4
>      Changes after internal review
>      	- Fix the nowrite optimization, an ATS translation without the nowrite flag should not fail when the write permission is not set

It's strange to list internal review here.

> v5
>      Changes after review by Philippe :
>      	- change the type of 'level' to unsigned in vtd_lookup_iotlb

list change log from latest to the earliest would be nice too. Look forward
to your next version. :)

Regards,
Yi Liu

> Clément Mathieu--Drif (22):
>    intel_iommu: fix FRCD construction macro.
>    intel_iommu: make types match
>    intel_iommu: return page walk level even when the translation fails
>    intel_iommu: do not consider wait_desc as an invalid descriptor
>    memory: add permissions in IOMMUAccessFlags
>    pcie: add helper to declare PASID capability for a pcie device
>    pcie: helper functions to check if PASID and ATS are enabled
>    intel_iommu: declare supported PASID size
>    pci: cache the bus mastering status in the device
>    pci: add IOMMU operations to get address spaces and memory regions
>      with PASID
>    memory: store user data pointer in the IOMMU notifiers
>    pci: add a pci-level initialization function for iommu notifiers
>    intel_iommu: implement the get_address_space_pasid iommu operation
>    intel_iommu: implement the get_memory_region_pasid iommu operation
>    memory: Allow to store the PASID in IOMMUTLBEntry
>    intel_iommu: fill the PASID field when creating an instance of
>      IOMMUTLBEntry
>    atc: generic ATC that can be used by PCIe devices that support SVM
>    atc: add unit tests
>    memory: add an API for ATS support
>    pci: add a pci-level API for ATS
>    intel_iommu: set the address mask even when a translation fails
>    intel_iommu: add support for ATS
> 
>   hw/i386/intel_iommu.c                     | 146 +++++-
>   hw/i386/intel_iommu_internal.h            |   6 +-
>   hw/pci/pci.c                              | 127 +++++-
>   hw/pci/pcie.c                             |  42 ++
>   include/exec/memory.h                     |  51 ++-
>   include/hw/i386/intel_iommu.h             |   2 +-
>   include/hw/pci/pci.h                      | 101 +++++
>   include/hw/pci/pci_device.h               |   1 +
>   include/hw/pci/pcie.h                     |   9 +-
>   include/hw/pci/pcie_regs.h                |   3 +
>   include/standard-headers/linux/pci_regs.h |   1 +
>   system/memory.c                           |  20 +
>   tests/unit/meson.build                    |   1 +
>   tests/unit/test-atc.c                     | 527 ++++++++++++++++++++++
>   util/atc.c                                | 211 +++++++++
>   util/atc.h                                | 117 +++++
>   util/meson.build                          |   1 +
>   17 files changed, 1332 insertions(+), 34 deletions(-)
>   create mode 100644 tests/unit/test-atc.c
>   create mode 100644 util/atc.c
>   create mode 100644 util/atc.h
> 



