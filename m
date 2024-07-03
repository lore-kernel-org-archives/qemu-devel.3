Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE5B8C2BD09
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2024 12:02:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOyfs-0007xa-DK; Wed, 03 Jul 2024 08:01:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1sOyfb-0007r3-Jv
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 08:01:14 -0400
Received: from mgamail.intel.com ([192.198.163.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1sOyfW-0007w8-7j
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 08:01:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1720008062; x=1751544062;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=9Pnv2lWHE/b2FQa9cDcDmUCY6u2b+cl9LLSeopaHf4A=;
 b=YRrzgqapKYKO22Wlobd2U9DBIHYqF15S2QXcwJsBzyPsNuStVxE/Rx++
 8ogglfLMwceSXkmtNW7TbGTJC3sPbIrD8Ygc9WwC2qFc0BEND1mDqN2vD
 DodUL80bE5d8mEQw15jATk4Wo3JreqlhvCZFaLOEMPvHVWxyKisIN6NQq
 QEBOtVVv3gDKgSnF0LE9oNhFzOerEmvR25cSa9+WXNj95wwDc2UvuxQle
 3Pt9ZRp6z3nLP0j1KFQJ/23gMLt2t/SoTgmrWRZDttyhW7cWlYjfmJH9l
 dQgvBDFLeX0x+fj4ygDwo85sIzPG+6MA4gjlk2nbBXHiYkk6j7RJF4Uhl w==;
X-CSE-ConnectionGUID: yn/gkGM5TQaH3j8Qu+umvQ==
X-CSE-MsgGUID: 2YzERCdmS9iO0U0RA9vWGw==
X-IronPort-AV: E=McAfee;i="6700,10204,11121"; a="20135814"
X-IronPort-AV: E=Sophos;i="6.09,182,1716274800"; d="scan'208";a="20135814"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jul 2024 05:00:59 -0700
X-CSE-ConnectionGUID: aCd3i9mxTBGXFBe7KCsUaw==
X-CSE-MsgGUID: 28dVtpXJQiCMNqx5ezM5HQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,182,1716274800"; d="scan'208";a="46661405"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
 by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 03 Jul 2024 05:00:58 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 3 Jul 2024 05:00:58 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 3 Jul 2024 05:00:58 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 3 Jul 2024 05:00:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eZZWvri9vqmnyJnLsrWufJQqy4cCnsaKS/a3QH+jJBn5G+yz28P2Vn2tS+B4EKd/lucXg8J45NStLCA8MhGYGyQXoLHCrAkT/vgm30Rc33rCSSFBnrpaMnhWIP3nrx9M8DwXQiFDw5ONgHFyBoS7YnCmFnXRfMIqsPPME++tNv8ymY4MA/evEW/Rea8qoFeLBsQB9yR3oepIpbQ695lEtVcVAYa+Kg8hXjasoSQzcq0Xh8xbVhD0wVGSvJItKIrTT58kbzgKPewZXPzuaYdqTyiklekMkQR4flfGD9SSKo+bSkZYirltqR7sS+sCJkyHqgJVsBHJb2QOQbJeTbI6jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fBgpvR2dBQJMxZ/K/VSYgTYByzmr+UKtlIWcjKNf37k=;
 b=lN7BkeVFPwxILOSSrBVMzZ66i2Ay+QTpuutbo4mKEpjVpqkSUwycyKnS2R4owJqLC42lpLJ/Ln0eLlVSEhxUrOOisSUSVsA9aWib7jgzDX9mbMK8oItkvUxuRr+5g0DkU2/u3FwVg0nTEwCJ4HYu2K/Ve3Qd8UgfzMjKJwpQcvPyRxMVhXZ27EcAcrz/PAXsFcaHz/dQfK39gYsCP+neVPCrFyQWV2ouY/qnq4PLUwUum0NUumqdEDqdr78Uy77SNrgmWZtR+9IVFoMzLznHDSBiKl0CzLbwdo4m091H9PDdzHuurkbGETdtPe67rBMGUw3nrXmIKc8C0cEwphLaAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by LV8PR11MB8485.namprd11.prod.outlook.com (2603:10b6:408:1e6::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.39; Wed, 3 Jul
 2024 12:00:54 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a%3]) with mapi id 15.20.7719.022; Wed, 3 Jul 2024
 12:00:54 +0000
Message-ID: <d2bed39c-9c5c-4336-bc42-2bf422aab7cc@intel.com>
Date: Wed, 3 Jul 2024 20:04:51 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ats_vtd v5 06/22] pcie: add helper to declare PASID
 capability for a pcie device
To: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "jasowang@redhat.com" <jasowang@redhat.com>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>, "peterx@redhat.com"
 <peterx@redhat.com>, "mst@redhat.com" <mst@redhat.com>
References: <20240702055221.1337035-1-clement.mathieu--drif@eviden.com>
 <20240702055221.1337035-7-clement.mathieu--drif@eviden.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <20240702055221.1337035-7-clement.mathieu--drif@eviden.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR01CA0054.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::22) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|LV8PR11MB8485:EE_
X-MS-Office365-Filtering-Correlation-Id: d4f7555b-8bad-4439-ad61-08dc9b57ca8a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UUdwcGxPdlZ0QmtibS9HQzBxTWkrd3RLT2JCdUdMaXQwSFJnbU5veEhxandE?=
 =?utf-8?B?Z0J4V1Q0TjdCZnpxMnBGY2E4SVN0eVluSytVYm0zSEM0UVc4Q25MaE5IMGlQ?=
 =?utf-8?B?QXVEbWNSMEJrUVhMbWMrc2M0UTdHd1hhODk1K2RRZUZobzlIVkk4S2tyMy9s?=
 =?utf-8?B?ZUlrY2hNYWVqNGZ0UU9qcjFlcnRsZU1uQmNLODI1cUs1YmRXSU5BeXlrWkNx?=
 =?utf-8?B?VTNUUGZsSW9mOW8yd21EczZ2Tk55ZTloczB6Z283S3RwVkVDa0FkYnlkbUsr?=
 =?utf-8?B?S0p6ZHQ0TzRpQ3F6S0p2c0RWb0JOZ05HNVhtZ1NpVy93anA3cnJ5dThpZ1Zi?=
 =?utf-8?B?QW0zT3R2M0d3aXZ6RVZONUZ5RWluS05RQWQ1dlNTWlJMbW5nTklkTHM0d1pS?=
 =?utf-8?B?ZTVhZS9MWStqbnpGRnBwWjR4UlNRUFY5UEMwRGNEMmtFQnc4UDRKeE5rN3Fm?=
 =?utf-8?B?YTFDMnF1MWdDcGpBenJxdVBRZDRoZE84a2M4dWUrSnVJSGVJU0dzaERZWlY3?=
 =?utf-8?B?VW43OENNQzZVbnRDdXFmM1AxZ3ptcm1xUUVaSUQ0KzdqUXRYOUFGVkNjd1Uy?=
 =?utf-8?B?R0RWVEE4YTQ4RUIrMWRVazBVYVlELzdYMTgyRm5NUXFOWW1hSUEwRFh2c0tP?=
 =?utf-8?B?S29YOHh5ZTZlSlZPSVZSeC9NMlM2ZGhOOERVN204cVRYNEpmZkd1UG52QXp4?=
 =?utf-8?B?MHZrbC9lK0FKMEhZRHBWUEhjSWM2RVowbjUyMFd0UXMzSkt4Z0Y5ZlppbDA4?=
 =?utf-8?B?aFhaVUNKdnppVEVldjJDa3ByWG9NMjJGNGtWQ05WT1VrY1lna1lSTmJUNVQz?=
 =?utf-8?B?Y1FnZVR6V3hkUDNNZ09RVmtvV0wzSFFpK1piSGl0dWk0bEFNeFBocHdPN1Ba?=
 =?utf-8?B?NGQxbFVKZkxQUXlPdXpwNXVMZ01IUEtCbVdicGNRTGJpSjdQYktnYlFLODN0?=
 =?utf-8?B?UW4rTDdkdDRJdmdDRmhoQzhoNHhaN0FvOE41MUIzeFE5NHBDdnM1Q3RDbGJ0?=
 =?utf-8?B?LzZlUlVvazJBc25QS1NRWW1WemEzd1BMVTQ0aWRkTVVPM1lhdXZtWElQTzlT?=
 =?utf-8?B?eXVicWUyOTIxSlVaNm9ORjczZEtqcWpralVRNUJyZUlHVVd0MXF1SHkzTVdL?=
 =?utf-8?B?eHBrb2RNSW5xb0g3OW9QczRzR0NQU2JEb2tzUTU1WW1VbWNnbk0xaXRFbzdj?=
 =?utf-8?B?TFM5ZGtLWHQ2dXhWcUpEbVlQbm44OXJUdm0rc21sWjN3bk8wanFIMXRnQXhy?=
 =?utf-8?B?ZlVYaCs5bGtsTHp4U2JqVWlIN3RKbFZkMW1pM1RyVkdSOVZBakQ3MGE0cU9u?=
 =?utf-8?B?ZGc0M1htTmdsd2puTFJzWHBlVTRrZDJuWlo2MmNZeGt3bUh3NGwwVk1rTzkw?=
 =?utf-8?B?YjVCM0JrVFVmcC9lSThnQ3RvVThyVm02RDdibzR2TTlyd0F1dEtOVmZIaFpZ?=
 =?utf-8?B?Mk54aGZtSXdPZk9QT1NwdmlRaGM5QTdZMndLK0YvMlVUSUxtMEdUNERqZVBT?=
 =?utf-8?B?SDZUZHNQSTZVNFdpWmY1R0VHa0wxS3NBVDZZSS9OQndLZVpUTmxWS2k0WGp3?=
 =?utf-8?B?blF3NHUrQmRBZUhSOUR5djgya2VpYWoyN2Z2dEtCOFF4Slo3N2lxL3hxM2kz?=
 =?utf-8?B?VkMxM0xvOVgvelVDREt2VHplOWYrUDhONHE0Nk9pR3pBSExnM1YyMDZZbHMr?=
 =?utf-8?B?NjI1ck4yQ0VsVE1Mdit5R0psOXV3NTV3MENwditaT0VId0FRVlNqc01OZ3Za?=
 =?utf-8?B?a245anFvZEdLQmhRdmNYejM5bXhwTlExdlB4UnlScG13M2FyeG1PaW5YaHR0?=
 =?utf-8?B?NHFwVHVJVndZaG41YmhtZz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7529.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?REhOT0dGbXpqM2ZwMnFLZG9kVWlzRERxenZsVVR6RVFia29CRlFXUHF3Z2Zz?=
 =?utf-8?B?dEtlTklXbkl1dUpNUjU4WmdqVjByeXlEb2huTWRjVXc5b0dlREJ2OWJZNk9S?=
 =?utf-8?B?OGd1SVo5RkNtT1ZSSGx6WFNoUWVBR29EY1NVVUJ5ZjRYSHNwK0tJNGJiRER2?=
 =?utf-8?B?UjM4RzhqUHRuQk9GalJHU3NTZDcwYlRDSE1lbG9SenlJK3RsMFNnZFNlTFJu?=
 =?utf-8?B?TGFqYjBYamVURVN2UC9IYVZ5S3BiVlFiSGFtdUl6VXdjSnpiZXFuVk5nQnBY?=
 =?utf-8?B?bVY4TXQvemhJUjBMK2l1VzBvdHJHcFUvRENCUFBWcFBVTE51b1pub0pzNEkw?=
 =?utf-8?B?Zml0MnY1RUVqTGZPdkpmekMyTEY5SmU1czNZT2QzaFU5aUliZitNVU52Zjdj?=
 =?utf-8?B?Smc0aXBlcHp6cFhUcXl5NHdlZVhMQjBMSnRsVDlqQXAvZkgvc0tkcy91b3pN?=
 =?utf-8?B?aWE5QVRxWW44Mkg4MEU0TGRJUHhBWmUxdDRhQjdLZnJrWjE1Tk9Ba0t1YzhW?=
 =?utf-8?B?SENtVGl4YnpHYWVtWFNPQ0hEYktBVE9JMGFTc0RmcVBUbTNqMUE4WTAxdkhw?=
 =?utf-8?B?Mk1NRzV1ZTNSQVRtMld0Nzh4Slo3QzZnUVJ0M3pSNXd2czU4c2FSSHJPUmFV?=
 =?utf-8?B?L3VDOVNVOGhtbFRDemlycHdEWWZnajFKSmZ5eXVPbjcyL1FXYmtZbjBSUEpP?=
 =?utf-8?B?cGdTWVpVbWtyaC9rS3NSMnNmQ2hqS1UxVWp3R01mVGxpTUoyZkFOZmo2d3pk?=
 =?utf-8?B?a0lENEFHejdtclgzR0VFVVpTVldReWVMeE9LcndLSGJTMzJvZmpYem0zWDdI?=
 =?utf-8?B?enJrMmszc0ZxSW5IT0U0djBDa3dkRkc4TVZRYTM1bXZaSXpuUEc4TW9kTVFw?=
 =?utf-8?B?dHdvZ1pjdVJCT1Y4S3UvbzlzUzRtY09KcG04bU5xOWc5bnlqRDRFSnVlcHVN?=
 =?utf-8?B?NHNGbWJMQTkzVk9KYWl2TnRjYXJBbTdRNFMvdzF2MTNXZEw1U3hLbVJnOG8z?=
 =?utf-8?B?aDFNTDdtUjRxR1o0YlRVK0NEdmJIMFpVTUhhLytyRE1na3kxd2RHN0ROb3Rl?=
 =?utf-8?B?YVhjSVZVMnFCU2lKRnZJNWk5cWJsZng0OFR4WUQySlA3c3N2dzcrYzRBL0Q1?=
 =?utf-8?B?eTZpYU1BSzhuMWV1Wkc3aU1WRkdjZlB5dmxOTmtaazZNbVVKMUR1SkptTWs5?=
 =?utf-8?B?bHA0RFNldURPM1lSVmNsaU5ZZS9hUmE5ZjAwU3RRbzhLNXhERlY5ZHVxWXdm?=
 =?utf-8?B?Sk1ibHZOZDBvUFhDREphQUxLckpTeFdLZVZ3d1lVYUxaVDFuOEpNVnBTNFNG?=
 =?utf-8?B?MDdCMjJoaEJqTGphWmVJWXdwbEp1VWVKR3gvUkZvT2ZIK2NtNzVubW1Bdlo3?=
 =?utf-8?B?aWt4ZzhNQ2dnSUpWTnYrcGVDUXB2N05kWGhpM0xBLzA2cWViU3hkVXJvWi81?=
 =?utf-8?B?TSsvZUt5Q2V5K3E1OUIvQ2YzSm84WXhLaXdNRll4YTNiZlcrNGNvN1pGbm9D?=
 =?utf-8?B?L04zNEw4TGtxQ2w2VWV0NE13amxaV21YUTZjZ2l5Mm05eE9YQUp0T0QyL3dD?=
 =?utf-8?B?VHZmYjNjdEdjM2ZBZXYrUUlKLy9BLzBlYVZzQXpKUk1ITUlRK1hML1lRTk0w?=
 =?utf-8?B?RVhlZ0xYTmtnSHlIa2htVDI3NTNjN3QxTmRDWXZHaWhLaHg2TFFna3h4b3hs?=
 =?utf-8?B?L1pTbGxsV3NXeWlrdFljNWZXRlFOdFdqY0RiMzFadWllNHovU1ZDWVkvR3ZJ?=
 =?utf-8?B?Z1NmbldTRFJrODJYUWJ2bitydXo1ZTNxYU85Ymh4emVrU3lmVXAvRTJReWMx?=
 =?utf-8?B?TUxKK1FKOXV4OG5tRHA1TDNLZ3lXZjZEd3V0LzIzMTNLVXJJN0kvdGhGOUdy?=
 =?utf-8?B?Z3J4LzVTbmxNaDh3WjhRaGdaM3M5TCtudWNvNzljcHB1S2pvMHJMQ25VMkFn?=
 =?utf-8?B?ZXRWTzJ1L2hWa05ZSDVycWh2Q1h3NVNmRElJVXpFZGVSQnJmaU16Z29sb3R3?=
 =?utf-8?B?L1dLZlY0TUNjdTVOa2JTLzBXSnNEdTZQaHlMQ2NLejFIZ2x6cjNjeVNrSW1X?=
 =?utf-8?B?QVY3cEoyOWh5aG5mcHRvV3VlcUtaRlNGQ2I0eEdjUVhVNGt6RldNeHlFWXQ1?=
 =?utf-8?Q?68KHddftMahybERDHCywXmSVk?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d4f7555b-8bad-4439-ad61-08dc9b57ca8a
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2024 12:00:54.5066 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JwcDqbdASUx9BtP7/uur0jlx5h7OS8iRy7h3Y42XnGkuK7Bu/CkCJNIaHP+HznOBILWOyZIPAt6e2thDFtdE2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8485
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.13; envelope-from=yi.l.liu@intel.com;
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

On 2024/7/2 13:52, CLEMENT MATHIEU--DRIF wrote:
> From: Clément Mathieu--Drif <clement.mathieu--drif@eviden.com>
> 
> Signed-off-by: Clément Mathieu--Drif <clement.mathieu--drif@eviden.com>
> ---
>   hw/pci/pcie.c                             | 24 +++++++++++++++++++++++
>   include/hw/pci/pcie.h                     |  6 +++++-
>   include/hw/pci/pcie_regs.h                |  3 +++
>   include/standard-headers/linux/pci_regs.h |  1 +
>   4 files changed, 33 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/pci/pcie.c b/hw/pci/pcie.c
> index 4b2f0805c6..d6a052b616 100644
> --- a/hw/pci/pcie.c
> +++ b/hw/pci/pcie.c
> @@ -1177,3 +1177,27 @@ void pcie_acs_reset(PCIDevice *dev)
>           pci_set_word(dev->config + dev->exp.acs_cap + PCI_ACS_CTRL, 0);
>       }
>   }
> +
> +/* PASID */
> +void pcie_pasid_init(PCIDevice *dev, uint16_t offset, uint8_t pasid_width,
> +                     bool exec_perm, bool priv_mod)
> +{
> +    assert(pasid_width <= PCI_EXT_CAP_PASID_MAX_WIDTH);
> +    static const uint16_t control_reg_rw_mask = 0x07;
> +    uint16_t capability_reg = pasid_width;
> +
> +    pcie_add_capability(dev, PCI_EXT_CAP_ID_PASID, PCI_PASID_VER, offset,
> +                        PCI_EXT_CAP_PASID_SIZEOF);
> +
> +    capability_reg <<= PCI_PASID_CAP_WIDTH_SHIFT;
> +    capability_reg |= exec_perm ? PCI_PASID_CAP_EXEC : 0;
> +    capability_reg |= priv_mod  ? PCI_PASID_CAP_PRIV : 0;
> +    pci_set_word(dev->config + offset + PCI_PASID_CAP, capability_reg);
> +
> +    /* Everything is disabled by default */
> +    pci_set_word(dev->config + offset + PCI_PASID_CTRL, 0);
> +
> +    pci_set_word(dev->wmask + offset + PCI_PASID_CTRL, control_reg_rw_mask);
> +
> +    dev->exp.pasid_cap = offset;
> +}

seems no user of this helper in this series. If yes, you may drop this
patch and include it when there is a caller of it.

> diff --git a/include/hw/pci/pcie.h b/include/hw/pci/pcie.h
> index 5eddb90976..b870958c99 100644
> --- a/include/hw/pci/pcie.h
> +++ b/include/hw/pci/pcie.h
> @@ -72,8 +72,9 @@ struct PCIExpressDevice {
>       uint16_t aer_cap;
>       PCIEAERLog aer_log;
>   
> -    /* Offset of ATS capability in config space */
> +    /* Offset of ATS and PASID capabilities in config space */
>       uint16_t ats_cap;
> +    uint16_t pasid_cap;
>   
>       /* ACS */
>       uint16_t acs_cap;
> @@ -150,4 +151,7 @@ void pcie_cap_slot_unplug_cb(HotplugHandler *hotplug_dev, DeviceState *dev,
>                                Error **errp);
>   void pcie_cap_slot_unplug_request_cb(HotplugHandler *hotplug_dev,
>                                        DeviceState *dev, Error **errp);
> +
> +void pcie_pasid_init(PCIDevice *dev, uint16_t offset, uint8_t pasid_width,
> +                     bool exec_perm, bool priv_mod);
>   #endif /* QEMU_PCIE_H */
> diff --git a/include/hw/pci/pcie_regs.h b/include/hw/pci/pcie_regs.h
> index 9d3b6868dc..0a86598f80 100644
> --- a/include/hw/pci/pcie_regs.h
> +++ b/include/hw/pci/pcie_regs.h
> @@ -86,6 +86,9 @@ typedef enum PCIExpLinkWidth {
>   #define PCI_ARI_VER                     1
>   #define PCI_ARI_SIZEOF                  8
>   
> +/* PASID */
> +#define PCI_PASID_VER                   1
> +#define PCI_EXT_CAP_PASID_MAX_WIDTH     20
>   /* AER */
>   #define PCI_ERR_VER                     2
>   #define PCI_ERR_SIZEOF                  0x48
> diff --git a/include/standard-headers/linux/pci_regs.h b/include/standard-headers/linux/pci_regs.h
> index a39193213f..406dce8e82 100644
> --- a/include/standard-headers/linux/pci_regs.h
> +++ b/include/standard-headers/linux/pci_regs.h
> @@ -935,6 +935,7 @@
>   #define  PCI_PASID_CAP_EXEC	0x0002	/* Exec permissions Supported */
>   #define  PCI_PASID_CAP_PRIV	0x0004	/* Privilege Mode Supported */
>   #define  PCI_PASID_CAP_WIDTH	0x1f00
> +#define  PCI_PASID_CAP_WIDTH_SHIFT  8
>   #define PCI_PASID_CTRL		0x06    /* PASID control register */
>   #define  PCI_PASID_CTRL_ENABLE	0x0001	/* Enable bit */
>   #define  PCI_PASID_CTRL_EXEC	0x0002	/* Exec permissions Enable */

-- 
Regards,
Yi Liu

