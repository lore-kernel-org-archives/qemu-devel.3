Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A37BC2BD09
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2024 06:07:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sR3zp-0004Bn-5S; Tue, 09 Jul 2024 02:06:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1sR3zL-0003zH-5K
 for qemu-devel@nongnu.org; Tue, 09 Jul 2024 02:06:07 -0400
Received: from mgamail.intel.com ([198.175.65.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1sR3zF-0005OG-DU
 for qemu-devel@nongnu.org; Tue, 09 Jul 2024 02:06:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1720505161; x=1752041161;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=prXib+Iz2mATMPiz8uRDmH/SvMTUj3C8oB0eYWepLHk=;
 b=UM6HiU8qt1CLPIdRb7TeNjYW+30sHDN/r0YBq6eGbKiGOZHJJPiG5pcE
 BE52C3MrfAlbTD7xjkAh6HWuQbPTHS4VqzLcZD59wVvzHchCq8mqCOLi0
 xHRJV8QfjXjCWaEqWaHLhgsGOXodaJp8BxvGs9z3Msu1yaqwXZdkHKeYS
 KOlZi0u/gt7xtetmFz+5ADpFnKsACn1b7fHK5TKSPQy6hN+WfKe08PeST
 Qm4K8iRVEnRyOwXrIQIfqvgBQtcS5iNvgpwqHBpMVRTvPAkF/bT+KiQYO
 0fk3O/WtHGIsT4khaRkWBdxqaHcxkYQS7Yyny0ahH/DpxYQDi0KON5MIu Q==;
X-CSE-ConnectionGUID: xI7OxRZZTGyZ7Xu/E8bDdg==
X-CSE-MsgGUID: M83kXW9LQ2y5zUn7WWbiDg==
X-IronPort-AV: E=McAfee;i="6700,10204,11127"; a="17873535"
X-IronPort-AV: E=Sophos;i="6.09,194,1716274800"; d="scan'208";a="17873535"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Jul 2024 23:05:54 -0700
X-CSE-ConnectionGUID: +FIddEGJR+SFojS/KTUOAQ==
X-CSE-MsgGUID: sHfAqqYBT4mlH61sDG784Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,194,1716274800"; d="scan'208";a="52920790"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
 by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 08 Jul 2024 23:05:55 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 8 Jul 2024 23:05:54 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 8 Jul 2024 23:05:54 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 8 Jul 2024 23:05:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V6/WNGCfRoqAtvI0YGZRe67MsAxRKqHVNIgh4wRI73pCe2Jy12UoMjJFscQ4u2IRM1pEYAAMkBh1xtGudlxvWGYIaMgH8lRASthblZ4b27MNaVWh3yuZxNzCAoJVsHM1Uy1U+xxzOPUFm0sAGEe+cmyRh2/zdkH0elkC2u+qZQkO8DaQFb+Az+YL53hf7n6KVC0rpnwpfmXiJ//T8NQE0yJVavr4KrCkqIJAehfi06L+E8TeUEw7KXfBqEgHWmEBmaswfzn9Dy8+sM9scOP9TQPCjgsSmaqvh29VPC2BqHfx3fDyJxN0Wtpwjmt6c4JZmS5IaYqMDwJoJrChGf9x2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cSMlLAYpDA9IVWLyAtbCBc03xXSkyDuEcTZdwJW5szY=;
 b=IQgviZG8+KLFZyXMljrylmkdqzTSFaIAz44+i8x7VIopAN91x04RFJ71R1ggtF9SZbKukoA29AZIUwwYRoxqukKB371Fwga8Ms2+3Mnochfay7XEyxYrtVshcOnXqr/QWrjc1vZMWtqjDAncA6clb0OO6wBFjzJtXPue4CqzseqkYcu9IO/7Trgnw8XBzFGTvL2HOUMgBEWtLedkHLxph/+7HrPd1jM2Rk19T7y9VPgJ9jVHWufMCjxM3osNietdsmMIn35Jt8Zi4e0CK/GtgL3+ajfPrUb1dOlGJPhSltj5IeoHaFDiGxozLHOElwEuozdH/DoLSR6KABOyPer6uA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by IA1PR11MB7198.namprd11.prod.outlook.com (2603:10b6:208:419::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Tue, 9 Jul
 2024 06:05:52 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a%3]) with mapi id 15.20.7741.033; Tue, 9 Jul 2024
 06:05:52 +0000
Message-ID: <e3141f96-9d51-4a81-bd63-4bb98c397ca8@intel.com>
Date: Tue, 9 Jul 2024 14:09:47 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/4] intel_iommu: fix type of the mask field in
 VTDIOTLBPageInvInfo
To: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "jasowang@redhat.com" <jasowang@redhat.com>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>, "peterx@redhat.com"
 <peterx@redhat.com>, "mst@redhat.com" <mst@redhat.com>
References: <20240708113908.19535-1-clement.mathieu--drif@eviden.com>
 <20240708113908.19535-4-clement.mathieu--drif@eviden.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <20240708113908.19535-4-clement.mathieu--drif@eviden.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR02CA0026.apcprd02.prod.outlook.com
 (2603:1096:4:195::19) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|IA1PR11MB7198:EE_
X-MS-Office365-Filtering-Correlation-Id: aeb2142f-6cc3-423f-9e67-08dc9fdd2fe8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WjE3NXc4M2grWTk2ajg0ajVZaXVnejlDN0IvSDVnMFNNKzlBdllvN0w1NU51?=
 =?utf-8?B?elZiNXQ0Nm9IdWpzM1dkTFZHOW9SSU52UTNGbTlvN1hkVWgxdWtYRUg0UmVv?=
 =?utf-8?B?TnpFaU5tbVFhZ0trUmtJOGl6V3htUjRCanlyYm0yWmUwdXV5NDJoZ1pMSGZl?=
 =?utf-8?B?TEluem9lQmNNdm5jYVl6N0tZSDlQZzJQUzBuYXZNaUJNcnFnMlNkOTVlb0Fl?=
 =?utf-8?B?NHFoUTdEbWZseHFYeUNGNFlxWUVHendqakM2SzBXcklwQkFrdFVQRWlJMk1O?=
 =?utf-8?B?Rk1xYlVvUEZ1dXVTMDR4dTNubVJPUHhTd2tOQmNTQ2pkOTdISEpMV2gzK3VR?=
 =?utf-8?B?eHZmMFVTOGR4SVlObjJDZkJseE0zNGtSWTFQdVQ2RU5TZGF1OUVabGhoSEhB?=
 =?utf-8?B?MVEzSWRxZW8yL2Q2WWQzbGhVcStzQUxacUorMUQwQXVNc2wvL2FlNGVUdGRB?=
 =?utf-8?B?bU4wenk2VnhjNm81VExORis3SnBWaURGVzVmOUtSZzdLRXVzTWdxMWJvV0FF?=
 =?utf-8?B?c2FqeE9Nc3p0UVdjaXRyZjNXQU9VVkZlK3lkelBBU3VaOVNEa2JDZGhLWUZG?=
 =?utf-8?B?Yk5tckFDMkY1VjVaczdSU1E5cEQ2a3R4QTlwQ2VWSkdpZU5kd2hlRmJWaVJH?=
 =?utf-8?B?Ly80NE10elFjbUp3M3d2bHlhSllWODRwWk1scnNUY2prK2QySjVvVTJ3cUFK?=
 =?utf-8?B?cW1UY3QyRDZNMUZUSzMwWHBETkNsUCtrQnd6d0xmK1E5MksxN3hGMWo3am9w?=
 =?utf-8?B?cW9kbU1vMEMzUXUvOTNvdFM2WWJOSjFkV1VZdG5LWXhwcUVocGdTL2pzRFZ5?=
 =?utf-8?B?Z0c4cE40ejJGYlFoSnpHWmlIQi9XQTB6dk5IY3ZncmtRVUM1Tmd4dy9iaEV5?=
 =?utf-8?B?a0FJUlIrWUh0alB6TnM5R2pVdUszZEhDT3BwRDg5Tk1mckZUY2VKN0sxUlJw?=
 =?utf-8?B?RnNGc2tsK0VMeTR3NUxHQzFBVVE4Zlc1Z0Z5dXB6TU52M3hCWEFEOExRNERw?=
 =?utf-8?B?QjZreVhGemp3UUlSUmtCbkVRWXo3bXJxREpxb0VrMUZOK3ZLd3N3MnJUOXow?=
 =?utf-8?B?Wk1TU2sxN3FzV1lLNVRYcWg1Q25uM3NLU0RoL1ptcXBNSHBxVlZYdTBFYzR5?=
 =?utf-8?B?SC9abDZLc1VCU25SelA0dmdGaDdkdGxlMk1lbC92K1VLL3Nmd3lXb3RjTUhy?=
 =?utf-8?B?U0ErS1d1cVdtNytLV2NMQThteGxDZXZUVGsvV0FuVUNVZ1FQcm81MExyb0k1?=
 =?utf-8?B?eGdidysxOGsyMm4vRkttKzJQQ1piWGZ1QldsdWxWMzhXMUdyT1QrUE5sK0F1?=
 =?utf-8?B?a21JMmFTWXRIcjZYeG90cTVFNkhiWkxzZkRvR3VSUVJnQjUzMHlGTytrV3U1?=
 =?utf-8?B?UzVLZkJMY0xMbnpBcDhTdUdpbU80emhqRkNrcm9yNVowR01SZzRJMGZLLzlL?=
 =?utf-8?B?ZU9DMWNVclhlN3VJV29TM1Q1bGE3MDRDVjNybmFkWC9iZFRvRUxnTEFpODM4?=
 =?utf-8?B?VzBCSGk5Kzd2SURxK3BTcUYzUkNQWWlnUkRIZG1NS25CZnFDYUs0N0dQR1dJ?=
 =?utf-8?B?WEdMaGkvd2h1Qm56b1RnNit4Y1VvTmhzQytSL1Rqc0ZZRkN4b3BKWVQ4TzBH?=
 =?utf-8?B?VnBQc0VOUmszK0pIZU45eEtMdkVHWTREY0p6YitrSklVYWRXQlphMkxQU1BY?=
 =?utf-8?B?Y0dRZWRvQzNDajNUWjM4T0ZlV2wyS05OSktjcDBBaFZCNGhlN3c0SWcxOFk4?=
 =?utf-8?B?a2ZVYXd2elNmdUtCdXVuMEVVa28xWG1tOHc1MHEyb0lhWXNsOGdBUUVvemtD?=
 =?utf-8?B?N0lTbHNNUU9xTmFDaU5Rdz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7529.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V1BYL3JncWdabnlxVHZNcmJZWXJ6ZUVlNS9HdDl3YURqZ292cXBxZUk5ckIv?=
 =?utf-8?B?TUFhNU4yaFVESU0za0VFdmNWZUlXbmNlY2pYV1U4dnNzcXloNWpDV3hIbVFJ?=
 =?utf-8?B?SndQdG85V3UwbVNUMktLSUJXaC9pR0xBTEljTVltVndmNHdpcjlkY3V1bVk2?=
 =?utf-8?B?WG9MYUdYeDB3elB4NnNIdTN0UzFyYTZNc01Pd254WHRoTFV2UzhBZ1Y4UGRu?=
 =?utf-8?B?RXpJRlc0bnRMc0l1MkxwTFpxb2p5NWQyTTAwL0lURXJnUHE5QW85dldHbFQw?=
 =?utf-8?B?eXN2UTgwU3RUbTZQd3NuUjh2ZXFDQzZjcXlSSExWcjF2QlF0Y1FweUIvSUNE?=
 =?utf-8?B?b2t3MVBhQXJKSEFxb2xjekcwZU5NVHBaRjArcGdmL2pOTHZQbEhpRjZJR3ZL?=
 =?utf-8?B?REdFSElSWUdIcmpydW5uUDFpaWdPdmRJbEFPSkNqQlBqWEJZQk1XVVZmWUd6?=
 =?utf-8?B?N3lnMHQ5aTFsR3puM2FBZ3ZCVVhUVk1ka21Obi9Eak9md2VnVW5oTWdvcSto?=
 =?utf-8?B?cVNVeHBjUUNyTlB3bU80dmVjUy9pNUVSbDdxU3hWRkJJaGNYVzZMNlVZNjVX?=
 =?utf-8?B?dzQwa2c1NDBQc1pkdGxndEJIand4eUlDbFBwWm5jMFZZMG5IR295dVlMaUtM?=
 =?utf-8?B?b1lBNDdidGU5azRTVEo2TTZVQVphdlZldWZCWWZWam5LVlhSOS9kbEIzb2Nv?=
 =?utf-8?B?TEhVb1E0QnlLTzZQVk1ZTGlERHRRcUFrNEVnQ1cyLzJFNjdJY0VwVUJDcW82?=
 =?utf-8?B?M1owTTROb3pnN0VrTW9BYlNHU3pGRmtMQW5ibmtEWVI3Z2NVT2VDUFZJMTMy?=
 =?utf-8?B?Nk94K0t4YmdvZnIyb1JHUERjMHZ3b1REZ0dpY2tEVHFFZmlPSWVBRVp0MWJs?=
 =?utf-8?B?U3Q3ajVvQU1acmNHZlg4TWVCaEVNdVhSaUlneDdBSmplZ21CYjZBOVZyLzJI?=
 =?utf-8?B?SkJoZG5MeUlVcGI1WXZaRENIMkh5TlN3bGJoTitUckxORFZ1TU1PNnd3WFMr?=
 =?utf-8?B?WUxMSmZNNzRSRDNXRElwUGk2UWIxR2RFSEdvY2hVYUtycDREZHhnOGdHWlJ6?=
 =?utf-8?B?M3VWUDdqT25oV2N2TzNpanh1cnZtUzRXT2dCRzVnMzc0aG1NckNVaUtJZE9M?=
 =?utf-8?B?UnduOHM1bDZBaVZhRERCeWxrZzRuZXBnMHB1YjE0cExrS3crcDVMbDIyUlRo?=
 =?utf-8?B?cFV2TUJZVWQrdUx1UkhrSTJtam5lWFZZR1FsMXE0UDF4azUxVDUwbUYrWkY1?=
 =?utf-8?B?NTQ0Y2NDTEZIV3l5RUgvWlMvaXkvRW9GMkZyRHd4YzN6WE1hUHZpaVc0Wll3?=
 =?utf-8?B?VjlGLytHWFRyUThmSGVYaHl5cVRERkJuN1hvSWt4WGhrREdML3ROanJ3UUJC?=
 =?utf-8?B?VkhTTzZLMXNTM2FLK1E2U1BNalNtMW5GcGN1QldGNG9qZ2grbVpTRHl6a1My?=
 =?utf-8?B?aGZ6WjdVeFFIOE01VnpiaHo2RERQTlRHcGI3N1lOMERzZmtWMDROenlkTTdv?=
 =?utf-8?B?VkpQRk5XZGV6TGhkSlhnL001MThJbUl3RFhwKzdySDY4OUZvSFBWNVIzMy8r?=
 =?utf-8?B?UWsyZnZjTVl4dnFkc2hNdGdXcmdHRWc3UEp1dk1NeWkyNGZqcEp6VkVodzd3?=
 =?utf-8?B?ZHpJM0lMcStmZGh3TkJVV0RMditmRW5qSkpqZE0wby83RDZLU2FKdlJUai9Y?=
 =?utf-8?B?V1Zad2hYMjB6RDF4WnlDRXNncDVhQW9KYVpiQmF5a0l3Q3BwRUIyT3E3U0do?=
 =?utf-8?B?VFN2ak5FeFU3ZDU3M0pNZld4TktaaTh5dXRTVUgrNXY2RHBJRG5oS25HaEFO?=
 =?utf-8?B?MFBuUGVzL040TWd4MTYvbkNaOGhidk82Nm1CZDZtY0tuMXFDRlRITXdOSWc5?=
 =?utf-8?B?enArQ011eGtlamdtTVN1R3Y1N2ZiSFZlMHdCVDFPSWRiaVRnWDNwMmN6RXho?=
 =?utf-8?B?a2wrSXkvbmJXd0FOeUVDTkFGU1ZoTFJQZTZ1SzBGLzBzbnVTcUE1amhrZEVR?=
 =?utf-8?B?ZFpZYlFQU2FOMHlBa01VTHVjbXpDMmRmdkowRU9ZS1FDN0dsRlUyenFkV0Y1?=
 =?utf-8?B?WE9XMVlBeFpraGEwMkUwd0xUOEVxckp3L2J5akR2MmFjcmxTL1JQT2trcVpR?=
 =?utf-8?Q?iqkr+zxqF3qL+biq3cYSYeXOF?=
X-MS-Exchange-CrossTenant-Network-Message-Id: aeb2142f-6cc3-423f-9e67-08dc9fdd2fe8
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2024 06:05:52.1028 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0HDiNFlZLS+Lpbtg+Qz8ViSL5NnQlh2qKN+PE/6/0I5QsEcmcASMwIABWP8+OvtNbgR1lAVri0zFpgSNAB8o8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7198
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.16; envelope-from=yi.l.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
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

On 2024/7/8 19:39, CLEMENT MATHIEU--DRIF wrote:
> From: Clément Mathieu--Drif <clement.mathieu--drif@eviden.com>
> 
> The mask we are trying to store into VTDIOTLBPageInvInfo.mask might not
> fit in an uint8_t. Use uint64_t to avoid overflows.
> 
> Per the below code, it can overflow as am can be larger than 8 according
> to the CH 6.5.2.3 IOTLB Invalidate. And you may want a fix tag as well.

aha, I meant you need to add a fix tag as this is a bug. :)

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
> Signed-off-by: Clément Mathieu--Drif <clement.mathieu--drif@eviden.com>
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

