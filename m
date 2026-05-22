Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDB23CD5BAC
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2026 09:06:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQLpQ-0007S6-6r; Fri, 22 May 2026 05:06:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1wQLpO-0007RU-9c
 for qemu-devel@nongnu.org; Fri, 22 May 2026 05:05:58 -0400
Received: from mgamail.intel.com ([198.175.65.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1wQLpL-0005Pp-Ki
 for qemu-devel@nongnu.org; Fri, 22 May 2026 05:05:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1779440755; x=1810976755;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=c5LvgvFx3ktuyGl9Y9muG4zaKqqbY3GdI97+LbJpvqU=;
 b=BOSgpQgA7uhU7LJHi9b3fPr0argZ0afoUbsjfFYP17KnI3YLtJIGmVSx
 309+qYl9z+yoWMjhzE754ICW8yafcpzgsqq9Mmul3fmOEoI6yROPUwYd7
 EqLnY2MM0o6Odhlnel/Ev+gfrpdfi4VtvJX951fDl66TZZcwacwVzBQ1S
 QH6g2AgPoLPH3/UULeCHr+7ZGGL8a2VmTct2MgqXaxOYXQ4q5i06O/ShS
 oFmHZFOgF1YuGY0pp0OTLyznZ92fc0e1hKmPM5M1iHjpwpZLWv9vv98kR
 0EDToH2c0a3Qpx5PhmHQP6/eypOkpILXKbaP8v7Lt3XT9FNhzxgMyIden A==;
X-CSE-ConnectionGUID: a+EMzZlqTxWAfPQEEMpUGQ==
X-CSE-MsgGUID: dA14U5poTbOkT57mYMEwow==
X-IronPort-AV: E=McAfee;i="6800,10657,11793"; a="80098880"
X-IronPort-AV: E=Sophos;i="6.24,162,1774335600"; d="scan'208";a="80098880"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 May 2026 02:05:52 -0700
X-CSE-ConnectionGUID: 1+TuQpe9T3mxlGPctudqMg==
X-CSE-MsgGUID: SYAj4JGpTZ2meC6PsSHQGg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,162,1774335600"; d="scan'208";a="240024854"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 May 2026 02:05:52 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 22 May 2026 02:05:51 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 22 May 2026 02:05:51 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.25)
 by edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 22 May 2026 02:05:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GlEHf9XAOjPsR6mw3ZjSAOTF1ohp3eCVOzAtAitpFTNjoWFX4c/vNpGFEQ7meC+wHef1EqYcK36deJ7abJj1mJvTWGIEdd1iC21x0P2HsfhBEGbePIauETvZG/oQwT5mX/C6zJz4xGIa/E++LGvMSXbFIfEAWJWdSW9JTD13j/0GGthai4zRaXu//s/qZze0IJdmPuok9REDgTNg9pTdsdT+o182DwhNRoQuIbLiDRTtjdUuQRF714qdCBUhWo3cxc9354Ts+mH5rKQcUd6HUg7osYYJkyNVpLUjKvpCj8KOcn3Fzj04KTn4r7ZbdPAp5tot99kxiQZKZP/YSZqRsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z6J9TYcmmWFGa6AWbDQ3QU0ZgLkYL9vBo+7mjb2wo44=;
 b=l/3pMxrPjCQ0kgs3clEMnokTgEv8aOtEWCnNQ4WQ+RTUDnttr0MCKWxv79dC2EbrqZmQ8GcY7ekz58XVxTprulbTpw2DA+G90SMRacKlRO3FfdhXAawoOABhrX+WwDByn3KWsglZ8DROL0BCy/ff0mTX1rNJvLC4t/8eHD6AZogh/z0gGtwu3AxZ6h0CFCV74dTv+i3BH1hgIlyycyIwKXg/zDJNd1OwfAuAE+Ck0T+izUsNoDV6dReneQjRKjaRcCu1Ny7eclMljEJFC9Aqnlbh7DlfxAIXdcRSMF3PnR6NLiqoVIt3Hztxx3XXNiIJ8tdtYqrG4lvcBm2MJlJDGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV8PR11MB8509.namprd11.prod.outlook.com (2603:10b6:408:1e6::15)
 by SA1PR11MB5948.namprd11.prod.outlook.com (2603:10b6:806:23c::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.17; Fri, 22 May
 2026 09:05:40 +0000
Received: from LV8PR11MB8509.namprd11.prod.outlook.com
 ([fe80::f5bd:4dde:4f2f:20b7]) by LV8PR11MB8509.namprd11.prod.outlook.com
 ([fe80::f5bd:4dde:4f2f:20b7%5]) with mapi id 15.21.0048.013; Fri, 22 May 2026
 09:05:40 +0000
Message-ID: <edf871d5-b7de-42b4-861d-81f495e1510b@intel.com>
Date: Fri, 22 May 2026 17:13:47 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 09/15] intel_iommu_accel: Handle PASID entry addition
 for pc_inv_dsc request
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "alex@shazbot.org" <alex@shazbot.org>, "clg@redhat.com" <clg@redhat.com>, 
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "mst@redhat.com"
 <mst@redhat.com>, "jasowang@redhat.com" <jasowang@redhat.com>,
 "jgg@nvidia.com" <jgg@nvidia.com>, "nicolinc@nvidia.com"
 <nicolinc@nvidia.com>, "skolothumtho@nvidia.com" <skolothumtho@nvidia.com>,
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>,
 "clement.mathieu--drif@bull.com" <clement.mathieu--drif@bull.com>, "Tian,
 Kevin" <kevin.tian@intel.com>, "Hao, Xudong" <xudong.hao@intel.com>
References: <20260509040819.1044702-1-zhenzhong.duan@intel.com>
 <20260509040819.1044702-10-zhenzhong.duan@intel.com>
 <44c1dd56-a37a-42ca-b8f3-9ac69aa1f33b@intel.com>
 <IA3PR11MB9136BDEC87472A1BD0E93B09920F2@IA3PR11MB9136.namprd11.prod.outlook.com>
 <7bb33397-20a1-42a4-a2ee-3537295141f7@intel.com>
 <IA3PR11MB913681991F0F6EDB3A9F274B920F2@IA3PR11MB9136.namprd11.prod.outlook.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <IA3PR11MB913681991F0F6EDB3A9F274B920F2@IA3PR11MB9136.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: KU2P306CA0009.MYSP306.PROD.OUTLOOK.COM
 (2603:1096:d10:14::16) To LV8PR11MB8509.namprd11.prod.outlook.com
 (2603:10b6:408:1e6::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR11MB8509:EE_|SA1PR11MB5948:EE_
X-MS-Office365-Filtering-Correlation-Id: d0930021-a4b7-4b64-fd3b-08deb7e14be1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|42112799006|366016|376014|7416014|3613699012|56012099003|22082099003|18002099003|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info: F66ESBVtq2HZTYy+RiWLFVsmj5WXXBnjQdRCpYNy73fx8xKXDbqEIaXUv5u14hv1WYBGVId5ZGopITfQ+I2NOlyaTydyxNQe4rAltXGrlBwii4cR4C5txu1irlPY6dTrbEL1JWSBF0xP7djMDULoYs7ZxSRqnpsBRYAElh0ByFcxxfwMWzD4ck7vGdUgMZx/9QU8mNTZ9ZeMpmGRYS1SxT18jll7UeDFJisfm5M72XYH1EPkwbZul7k6snBIZyIrDuwuRT1uN9ldmilSXA6ta4HDPz4H+cO/A2te/yYigACxmAYOL4GJENhvxDjBghM+iE3Rr16fl4n3QbrQRB6JEkAlGRrC/+jw6OPJPlQAVoALfPmezZy0v+yktf9Au+w3J3SzJhpOi2xASK7rOAP/noV6Ogw/W1I9fOGdC3w2WM+RH/u7bjADM5LglQUfzMuQ8qvQrd6yNrEQro6l5vAnbBLnwEcNzbY3KEKmdTw3lUbHQZ3pZyZ1b+CdZeZ0nCazBtHGBhPNQUwXukFE5MWWqvbwU9TvgTzJczu6XSp034xccsf4bRGH3j0aWQJSzfXKO2DodO5N0LmhJwRbgX4cjIP7ejRlFLpCkjo5Frwvl6SNEiuL6ON7baEmBdYx2IEdNwdC2bV1LWmPIqCC+AOBUZwFgIzNjcqMLjnkR8NZ1dHNolau/s4XJW5T+9caBjR8swDT8dCcw3wVXxatap++nYwoeycJwPCd4a1UFLZ+vhzf1bhJw8O7TsM3gkfQABlY
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV8PR11MB8509.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(42112799006)(366016)(376014)(7416014)(3613699012)(56012099003)(22082099003)(18002099003)(4143699003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RkE2T215WEVxdURIVk1XUXIxQ1pkTGZ3MEkwWFo4N00wVXh0bGtXVVBMdTJo?=
 =?utf-8?B?RDNzRFlnZURvQ3lyRkpwSzJHa3oxMm1uK05hL1ZsaEh1R2FwbTBOMkRDcnF4?=
 =?utf-8?B?Q2RBOXdhbXZKcnY4OU5PbEN2QmQwSWFHbUVDZXFkdXFJL1FVU3NvUElMYXZZ?=
 =?utf-8?B?Q3VqRlR6bHZmMlY4dk5kNyszSXlnd0N3ZXY1WVNvMHgxejJPeXdZNUQySmVz?=
 =?utf-8?B?TWpaV0kxSTlKRjVjYlpVRVpYV3VSaU4vd28rUmVnSU5BdjFUZVRsNlkxWTI3?=
 =?utf-8?B?ZSt1a0FTYzMvOVVDVEhzMVJ2SERvZ1Y5VzVFZ093MGhyNUhBZ3RZR3Q2eDdW?=
 =?utf-8?B?b2dwWE1BS1ZJb2Z5MlVoeVBYVjlnK3lQQ3pOcE5PN2N1S0dtRDk3K2FaTlN5?=
 =?utf-8?B?MEYrbUJjbzdBVldzSExSVitWRjBoYzNyWkNzemsvdGlwZWRycElBWUc5NkF0?=
 =?utf-8?B?U1B4UUtOVEZNQkc1Z3FNNmdIRnkyOVJKRjlPblZqTlNxQVVnaGxVMUc0V2ds?=
 =?utf-8?B?Rk9Ob0NhejkrRjVnVHdaM0htK1Q3aFh6TG5DNm5GakFuVGZEdjl1ZnMxT2lu?=
 =?utf-8?B?SEhXZlJoWU4rMkpiNG9sMVVvVDIrY2grVWhyb3ZqamNnSytJTitRODVuWGdm?=
 =?utf-8?B?WDA1OG9icmFNeWwzOUN1ZmRickJNa1ZuTVN6UzRneVhuU012b1VoLytDM0xx?=
 =?utf-8?B?YTdwVlgrTzh4czg5RExwTnBuZUNFRVNWVzlHb2haZnlQdjE0UTVsQUN6emxX?=
 =?utf-8?B?cjFPbnJCUFFBYzBvWHF5cWVjWmtxQ0V6YkY2M3NaOEsvR3RRdytNVzBiZG5a?=
 =?utf-8?B?WGx4dk55MmVPTTAzR1M1NmEzSnRZZEkvdHQrQ0x2OFZ3cUpEdGdjQmFOM3JS?=
 =?utf-8?B?aXo4TVdiNVRHdDVmM1A2SjFCU3lpK2tIdUc5WE16UjJvWHhydmsyYXc2WjFO?=
 =?utf-8?B?NWUybUNSL0NTVk5WQ3lHLzl6WDRwam9oWXFYYWxKM1BuaVQ3cDdMeDJhREk0?=
 =?utf-8?B?VE05dk5zcXdQK0Y3ajlvK0lnMkRaSjkxbXVHWTZxbzZQSzcxOXJRaXhlTFkr?=
 =?utf-8?B?OTBLV0tBTHhaK3N6ZWVqUmNpam1RaVJjSW82ZGxOaEtsWHdwak9ocjhodk9I?=
 =?utf-8?B?OG1pRkhwa3hOSWxqV1BKZUJoSEJZOGk1aCt6ZXFBRmZqUDFJNUdLcnVKQlF6?=
 =?utf-8?B?NnVlNGpPZlJFb2oxdjFqSi9EcVl2KzByR09NUnZtWFRmRmp2TjluSjFFYWdl?=
 =?utf-8?B?Mmh4cjI5STNBQlNPRG5ubXhEOTVwYitPQVl0QTh5R2s5b09xTys4d0t6Z05x?=
 =?utf-8?B?V0NxdktzUzYwVGFmY2tCZ25kc1RZNjEvU2h5TzdaQ0xzc2g3L3pTL0VWRmw2?=
 =?utf-8?B?ZWNqQzNaSCtWS2hxN1BFRGxIRTdNalV4Ykd4bWFZRVpJZkxYTmRaVm8wMFZM?=
 =?utf-8?B?WjFlR29jQkFWMzl2N0VMTEhjZFVDSWhhWjJySUpENUFoejBSTFl1Y0ZlWTI4?=
 =?utf-8?B?bnVNMm5DcFJla0NUSUsrUkdLNmFrWkdrRi9sOCtrU1poYzRxM21uRTJDd3Jt?=
 =?utf-8?B?eVF4ekNlRjNadmJuV293WWR3SXNjN1BISUFUUTNORGppODNuc0RpUGRTN1dN?=
 =?utf-8?B?ZDdhUG1CZGE5cWFOS1RFeVJiSWk1cEtjUFN0UktTZlZnQ0ZaK2FBTDdjZjdP?=
 =?utf-8?B?VHZhR0IyUmU5blJQNStnd0dNdVp1cmFlbHA5eFRaMzNSVG13ZnQ1dURCSUlV?=
 =?utf-8?B?bVNmNU5xTExsSmxhY3lMbFhESjRWU004UDRJblFhczBhSEdnQTRlQTMzc0tE?=
 =?utf-8?B?Vm9jQUJvd1pCTEtCRTJEemJra1ZDbDV6NkFUYU8xTFdhaUJad3FQUDBCZGd5?=
 =?utf-8?B?ZmNVcE1jdXlCVDNBWExZSWFZNW5YYVBsNTJGRk80ZlhvMzRGeE53RnlscUZv?=
 =?utf-8?B?cEFPZlFGc3dYbWNRdERIYzhSOXd6VVo1S0hEeTd5b1MwOFVtYXYrSkRXcXhk?=
 =?utf-8?B?bmlYR2hUOHlwcUVkUWNJVDd5UWo3ajJkMHhIYmdZd2pvTGNnL2oxSlV6YWpT?=
 =?utf-8?B?b2VDeXdtcHZHUG53NzdQYXMzQ3NQZlRZV1VYaGZaZmtpR1h0N3hZekVRbGpy?=
 =?utf-8?B?VVhMQkxzQ2Ryak9oSmVOZXlSOXA1Y1NaQ0JnVHZEcmxqWGxpbXJvRFFNWWpr?=
 =?utf-8?B?d1AzZlpCZ05qRkRCQUd0azhxd3RPbUo5SWwyYXNZSEEwTWwwREcxMlMyU0NJ?=
 =?utf-8?B?akczVkwyV3Jua0FGYnVDYk9yMi8wWkNuSUlTZklISnd2UnBsSlM1eklKSk1r?=
 =?utf-8?B?bFRCYzNpWDI0TVRteVFWNVhuenNlRTZ1SmdyTVlKYlZ1OW5MbllPUT09?=
X-Exchange-RoutingPolicyChecked: d/dXI41j6yunolzNlSEY8bLAxE9KnEHy0PZowaCitgfl4lylkk/4C3Hc2dOiydz/YpUNdLzRMEpDMgHPlmXXIvsYLsgXclXcIIcjo/3egbeBZJJNbRRVY2bX2epXfpSDdscfKcsQfh1e3KaGnvnXUmnanCAP6VlB3mC4zkJ0/s6oV0BjZkztcV0PUTYJYvExlw+YYiFgRY669OuSsp04e/mfcRsTUJIfPxuKiXpYOo0abCGyUZWjcgJUjbgr4PS8PLQmIikRcILAPU+z6dWYiH7K9XA5IrtsCLHX/Ez2TX2QMEBSADU0v6U1qxgVcDL/0P1g8Y0abop8wg35stYxMw==
X-MS-Exchange-CrossTenant-Network-Message-Id: d0930021-a4b7-4b64-fd3b-08deb7e14be1
X-MS-Exchange-CrossTenant-AuthSource: LV8PR11MB8509.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2026 09:05:40.5419 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C7V2RJbC3J4nSvO/nuQhWnL1gRycA4rYTeR0/hVy7Eq7vtjVD/Mz9WqINdP5Wl1f7tJXqY7SxhDJnea8VQd3YQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB5948
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.20; envelope-from=yi.l.liu@intel.com;
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

On 5/22/26 16:20, Duan, Zhenzhong wrote:
> 
> 
>> -----Original Message-----
>> From: Liu, Yi L <yi.l.liu@intel.com>
>> Subject: Re: [PATCH v5 09/15] intel_iommu_accel: Handle PASID entry addition for
>> pc_inv_dsc request
>>
>> On 5/22/26 10:44, Duan, Zhenzhong wrote:
>>>
>>>
>>>> -----Original Message-----
>>>> From: Liu, Yi L <yi.l.liu@intel.com>
>>>> Subject: Re: [PATCH v5 09/15] intel_iommu_accel: Handle PASID entry addition
>> for
>>>> pc_inv_dsc request
>>>>
>>>> On 5/9/26 12:08, Zhenzhong Duan wrote:
>>>>> Structure VTDAddressSpace includes some elements suitable for emulated
>>>>> device and passthrough device without PASID, e.g., address space,
>>>>> different memory regions, etc, it is also protected by vtd iommu lock,
>>>>> all these are useless and become a burden for passthrough device with
>>>>> PASID.
>>>>>
>>>>> When there are lots of PASIDs used in one device, the AS and MRs are
>>>>> all registered to memory core and impact the whole system performance.
>>>>>
>>>>> So instead of using VTDAddressSpace to cache pasid entry for each pasid
>>>>> of a passthrough device, we define a light weight structure
>>>>> VTDAccelPASIDCacheEntry with only necessary elements for each pasid. We
>>>>> will use this struct as a parameter to conduct binding/unbinding to
>>>>> nested hwpt and to record the current bound nested hwpt. It's also
>>>>> designed to support IOMMU_NO_PASID.
>>>>>
>>>>> VTDAccelPASIDCacheEntry is designed to only be used in
>> intel_iommu_accel.c,
>>>>> similarly VTDPASIDCacheEntry should only be used in hw/i386/intel_iommu.c
>>>>>
>>>>> When guest creates new PASID entries, QEMU will capture the pc_inv_dsc
>>>>> (pasid cache invalidation) request, walk through each pasid in each
>>>>> passthrough device for valid pasid entries, create a new
>>>>> VTDAccelPASIDCacheEntry if not existing yet.
>>>>>
>>>>> IOMMU_NO_PASID of passthrough device still need to register MRs in case
>>>>> guest does not operate in scalable mode. So for IOMMU_NO_PASID, we have
>>>>> both VTDAPASIDCacheEntry and VTDAccelPASIDCacheEntry.
>>>>
>>>> The implementation LGTM. But I got a question to ask here.
>>>> VTDAPASIDCacheEntry is cached in VTDAddressSpace, while
>>>> VTDAccelPASIDCacheEntry is cached in VTDHostIOMMUDevice. A natural
>>>> question is why usingVTDHostIOMMUDevice instead of VTDAddressSpace. I
>>>> think it might be valuable to mark the reason of this choice. This
>>>> would help maintaining it in future as we might forgot the reason. :)
>>>
>>> Hmm, you mean why not putting VTDAccelPASIDCacheEntry list in
>> VTDAddressSpace?
>>> There is explanation above, paste here:
>>>
>>>     VTDAccelPASIDCacheEntry is designed to only be used in intel_iommu_accel.c,
>>>     similarly VTDPASIDCacheEntry should only be used in hw/i386/intel_iommu.c
>>
>>
>> hmmm. code isolation is a good reason. Is there any other reason?
> 
> Could you hint?:)
> The first four paragraphs in commit log showed all rationales I can think of
> about not using VTDAddressSpace.

TBH. I don't have any hint. When reading this patch, I tried to compare 
the four objects. I view VTDAPASIDCacheEntry and
VTDAccelPASIDCacheEntry as they are per-PASID. But VTDAddressSpace is
per-bdf/pasid, while VTDHostIOMMUDevice is per-bdf. That's why I got
above ask.

never mind, I think code isolation is enough. :)

Regards,
Yi Liu



