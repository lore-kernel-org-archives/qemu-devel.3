Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89F50D41C20
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Dec 2025 10:58:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vTeMu-0002Pe-M6; Thu, 11 Dec 2025 05:57:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1vTeMs-0002P3-Ua
 for qemu-devel@nongnu.org; Thu, 11 Dec 2025 05:57:54 -0500
Received: from mgamail.intel.com ([198.175.65.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1vTeMq-0006Gh-Ag
 for qemu-devel@nongnu.org; Thu, 11 Dec 2025 05:57:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1765450672; x=1796986672;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=i8Mpw1gEF9OVVyUaL8l68wCYxdvjZaJqEaaSIDQuUqk=;
 b=eTrh2oHnPi0lPZiX5v1OFlqagKuXfdjqEsre1mUVf8V2+SHpSF7V8Hwb
 OFNLwbmDbsQ4OBABw8jDAfLn8i4MdbmpXPBPR/SBLHvz29LUMaMDSkQ3n
 ep1eYNlOxYLKtkkykuhtyR9U/GDK+p41pIjeFpO52N4uqLinnewTBxHyA
 Hk3Zuq0dCRLHfvGzpcCO0V6Vja1b+NSeqd0C7GEFy+QGLqPX4zjbGvK+7
 oY9qa6HSE3E3GtL6MlhVBNDJfv0hC5nYQJqWDM0mmXWKav0ZQRzjgViOZ
 tyauWZUYNi/ivpwSKSGjgtVPUDYR+gU+bcpcczYLkS8UZ/Xq33+c3IzXZ Q==;
X-CSE-ConnectionGUID: czH4mAoiSJ6an6TUb4BaMQ==
X-CSE-MsgGUID: /5rkALRdQrCUBv2OTW37nA==
X-IronPort-AV: E=McAfee;i="6800,10657,11638"; a="71052977"
X-IronPort-AV: E=Sophos;i="6.20,265,1758610800"; d="scan'208";a="71052977"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Dec 2025 02:57:48 -0800
X-CSE-ConnectionGUID: YjWb2LJbQQGNO9zd5iHI+Q==
X-CSE-MsgGUID: 4uDtj4VdStmhiAcjP/aSzw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,265,1758610800"; d="scan'208";a="200935758"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Dec 2025 02:57:49 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 11 Dec 2025 02:57:47 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Thu, 11 Dec 2025 02:57:47 -0800
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.2) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 11 Dec 2025 02:57:47 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PEoT2JY2FN43hZDo7WDTwlgWW8uow8xj7S1EZZhY8u7o9rNXBfonDexf4px6EcdzVPH0zxBKEIzx/2bmJEyKb9Dbizrqlwp9diOIHkQmuBemuN8mCQNNuEQhBj50A5xfEpijP5mBdOpcRZu9bE6MzK5XltSIehCBFZtO2d5rbND5pqnQFjNk5kQ0EObJWdQ4dZtrbaiUMDRhPSh/QIqHSLw4wr3AOLK6qG9/2gkTzICPNiy0htsvpROEooztNkyuHveE2+HoQt8inJmCC7DrYweDToG3xWU1b0xYnt5CzKdoDUJMDbhu/kDhO180MB8BQhdSQAb5LoCUXTxX4aGKRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8bkQgMrsFVNJXZKJUf5ncWKKUcgWowibdxAGL/cpsjo=;
 b=A6iaZJ5MINyuwb9yAOd2G9vcnaE+zXSIHfvA6GSHkTGUbgegUQJKZXbFN877Hfr7nm5KVIYh9btvdoQjRMLtxOFJG+vt3tNmCkKsEAB8+vQ3v1gaJL75J33yKIXpLzJ1iDQO2c7JfijHvH6nS5zqiX6xuRRt7cVPYv7qpMKoLUIL3qX+zP+FdqRqpntCx9LkafNQWqRTNUZm9iCNjOwr1G7ScZAaURg2XTJFTStfDlwa/zKo5Sf3h2BK00l1rVxNNXYuwnuEYDVWemU/LDLKci6w2JKpvbDwwFc42MaR0P+jfZ+2qoFmMRnNdHl3gAM+D/FmDrfk7RfnaYasjhOEtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ0PR11MB4798.namprd11.prod.outlook.com (2603:10b6:a03:2d5::12)
 by IA0PR11MB8398.namprd11.prod.outlook.com (2603:10b6:208:487::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.9; Thu, 11 Dec
 2025 10:57:40 +0000
Received: from SJ0PR11MB4798.namprd11.prod.outlook.com
 ([fe80::d946:6abf:6e7e:fd1e]) by SJ0PR11MB4798.namprd11.prod.outlook.com
 ([fe80::d946:6abf:6e7e:fd1e%7]) with mapi id 15.20.9412.005; Thu, 11 Dec 2025
 10:57:39 +0000
Message-ID: <4618ef6c-9f54-45bf-a95c-5f813f9a2365@intel.com>
Date: Thu, 11 Dec 2025 19:04:24 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 02/23] intel_iommu: Delete RPS capability related
 supporting code
To: Jason Wang <jasowang@redhat.com>, Zhenzhong Duan <zhenzhong.duan@intel.com>
CC: <qemu-devel@nongnu.org>, <alex@shazbot.org>, <clg@redhat.com>,
 <eric.auger@redhat.com>, <mst@redhat.com>, <peterx@redhat.com>,
 <ddutile@redhat.com>, <jgg@nvidia.com>, <nicolinc@nvidia.com>,
 <skolothumtho@nvidia.com>, <joao.m.martins@oracle.com>,
 <clement.mathieu--drif@eviden.com>, <kevin.tian@intel.com>,
 <chao.p.peng@intel.com>
References: <20251117093729.1121324-1-zhenzhong.duan@intel.com>
 <20251117093729.1121324-3-zhenzhong.duan@intel.com>
 <CACGkMEtK_KiT+PCvxi2NUQ-gX0ekV3RtZ6E5T7oZSeiOqkSSkw@mail.gmail.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <CACGkMEtK_KiT+PCvxi2NUQ-gX0ekV3RtZ6E5T7oZSeiOqkSSkw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR01CA0007.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::11) To SJ0PR11MB4798.namprd11.prod.outlook.com
 (2603:10b6:a03:2d5::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR11MB4798:EE_|IA0PR11MB8398:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ce4e33c-ab1a-4d39-69d2-08de38a419db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|1800799024|366016|42112799006; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QkxQdW9CaHp2N1c4UVYzNUpMQ1Vuc3d6Vi95eFNkeU5sOERreC9HZE56a053?=
 =?utf-8?B?S1JISFNpZUJqaENIRFhCQStlUHJSRjZqRWF5eUZTNi8vaEpPam1SYXJRL2Rs?=
 =?utf-8?B?ek5nQ3Jta0U3UEZ6YmRQN3grL3NWQjJCcHFwNmpNNS9XbERma3E5Z0ZJNnBD?=
 =?utf-8?B?Um1IeGpyRysvSUNNdEpnMTNkaVNPTkVJNjd3anZ4Q2p4Q1lqekZkQ2U3SEUw?=
 =?utf-8?B?VWtkZTdPQmdEeHhBbGdQaExGZm5GNWpScWwxUVRXb0xTeEJONTdsdTB3elpl?=
 =?utf-8?B?cWxlZzN4bFNGOG1paEVNdFJZT2JUc0tZa0dWM1JvcnE5eFBwTXZpMWIzM01K?=
 =?utf-8?B?SkwrbHZRWm5kNWdjT2RyTHhuRTMwYlFLaFU1OUNqTThzNDc5bkNjTHd4dVVX?=
 =?utf-8?B?dHhmNHVvWlNKNVRpQzhwdW54ZXhZcjQ0QXh2dXF1U1l6YllrYXFHN1BxNmFl?=
 =?utf-8?B?TWs1K29NeldDOFVrK0gzeGZFcENlZ3ZjTUw3RGtxUm1QaVhiNWdRWnF5Mlhu?=
 =?utf-8?B?QXF4VndEVE5USTloUkZBSERXby9FckJwUEE4c1ZlZm90MnBZVXMxajJNSGVY?=
 =?utf-8?B?T1hjbTY2dXdUbGNyTE4vNExYSXlueTNRN3BLWmFieWpWbk02a2VBRnduV0Uz?=
 =?utf-8?B?aFB4SWxFR2pjYWN2blVsTmh6K2Q5VG55Z1ZFYXh4dHRPdXUzTnRwbENQb0Vk?=
 =?utf-8?B?cVBBN084YVpVanA2MUV5Tnh0TGtCd3VzZi9pYXdleVc4NGZhNEkxMnpPMlhW?=
 =?utf-8?B?YUVpSnhhY1FPR1NNQUNMQVJIUHEzcDI2RUtkR3BXRGpvVW90NmpaNGNBTTds?=
 =?utf-8?B?bkNJb2dKREdOeldvMjczejdqdncwdGcvZm82VHM5ZG93YXFTVmZQOUdzOE5K?=
 =?utf-8?B?Vm1ZKzhyN0Fobkd1UG1EQzJROElCdWpEekZWcWtOaU15NWl2ZHR3R1lhbDVU?=
 =?utf-8?B?aHNGMFYvRGZaVUV3N20yZTV2YVBjS3N1N3J6VVVWRGdkSVd0QTFrVkxRNk5Y?=
 =?utf-8?B?RXcxNVNHMnpVTElHZngyNlRtNWc2SlArT3R0THRFK00rVWpqQjF3Zzl0d2ti?=
 =?utf-8?B?RjdRQmk3bC85cXRvWC8yYUJKbUsxNUxWS0FrbEFjOURmWUd0K3NDM3RITGM2?=
 =?utf-8?B?R2RNeG1XdjJxZGJrQVdSTXVsQ0pJNlBGWGpkVmV0bERsVXdDdkFuZmZneXVE?=
 =?utf-8?B?SW12SFR0VmhHY1hWNmIzd3VodzdySk5BbkVWenZpQUhlRlRyVGdEZGh3ZjNk?=
 =?utf-8?B?cnZUcUJ6aWg5MWlUNHU1UmF4ZTYzNm84ZnI4eWQ0ZnBtSkhNZXZOR1Rrbmlr?=
 =?utf-8?B?Yk5kcGdVWGFUdHp2WUJzN2V1eWU3enlMMkZrdkcxS0hRcHlLWlY2S1dwd1g1?=
 =?utf-8?B?Q2hZT0wxSVZYQUFvRHA5eFlKVkNkZ2JEM3NIcXp6T1VMcS94R2U4UThlQWlr?=
 =?utf-8?B?YWlzR1ZmNnRXYXZUOC9kNk1DVWZicGZINm9FQVdhV2ZzRGtWaHluOHR2cHFJ?=
 =?utf-8?B?OS83UWFRUDZmaE5GaHRQK2Z0NmV0dDFVZm9uTnIvSkZRak95bXByRG13ZW9t?=
 =?utf-8?B?bGZja0RWWTdHNUp6RDhOdDQrV0MyaXZwNWR2c0pqN0J4NFphVUc5SE9ySStk?=
 =?utf-8?B?dzF5b0cySjl5cnQvVFNZdmhoc0N0U2V3SW5uUkhkWklDU1FqV2VKYTJJYnh4?=
 =?utf-8?B?OThQYmJhVVR3ODNCbjZJRVV1ald1SFRxdGVVQVRnQTdQdHJEdTQrcWYrL2dy?=
 =?utf-8?B?T3FFcElKZGNBOHFidmlUelU2cUVPZE5CMzcyMlJiUVhWRWZ2NjluaDlrWnNZ?=
 =?utf-8?B?RlhvdU5PeFdNS3hKaHFZallqaGZ0TGFNNFNiR1NaK3YrUldicU1GWFc3WEJE?=
 =?utf-8?B?VEN1UVU5Q2grM3JtdnN5aWtlR1ZzVUtja2tSWXpsOVJIVmQvMkhTVlJlNFF3?=
 =?utf-8?B?WDYxYVk2ZVBIM0gwSWpnQWdEcHFXdTNuMXF3VjV1Z1RzVWs3WnFXY0JWWkNw?=
 =?utf-8?B?MW1yNWVXSHF3PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB4798.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(366016)(42112799006); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eXpZK0U2bmQzeVVjeFZPczAydGRCWlNJMlYrMGNuMS9JUUZvaTEwUFVWYzFM?=
 =?utf-8?B?bE5jcnRBVlJTTzIwY1o1cWx0UUVRYW9QZndiYU5lam1IcUNZSi9kR0d4Y040?=
 =?utf-8?B?cHphUG1FeUdHa3F5TE9ZUmlZcTFOWkowS0Rpdkh3ZWI5NXdtQ3A3dHBabk8w?=
 =?utf-8?B?ZHNwaWkydElJVVQyWFdVUnhKSWJTYzI5cjN2RzUyWWk1NktvS2RJQnJwc1pz?=
 =?utf-8?B?NFZmdHVBMmFjbk5oSFU0dWl3ekV3Q0RDdVlQVU94R0dTSTBMTFpxaHNXQWQz?=
 =?utf-8?B?b3BKVEVHai83MW5KS0wxNW1mOTg2YXUyUWsxRG9KK0lxOWhIQ0hFaUJJalNP?=
 =?utf-8?B?d0ZFcHBaZkZVQnF2UERMd0JaU3BoNC95UzU4VWZuUWdMeWpybTF5b2ZEa2g4?=
 =?utf-8?B?ZStoeE9VeDA3NEcweEhUT0N5VTBmSU4wQUpza0xENnpRcmFIRXVZT0JVdFdx?=
 =?utf-8?B?TjluRkE5cXJybVp0bGRlT2MwRUp1OHBVMHAxK2JpUlcwMnkwLzVyQzJwczBJ?=
 =?utf-8?B?ajZSanVRUmhhUUtRbTlwb0NnbDdheUZUeGErOWhZenNiSmhROUdpWFRucitJ?=
 =?utf-8?B?Rm40SExPamgrU09GU3JQQmsweXFLQUhyVm5tS2M1RU9ZNTRpL2RKdno0OVVO?=
 =?utf-8?B?NmlIaWZaQ094OHlDVUVMenNvakwwNGNSVDZqc0pzNE4zR1pBVnI1QzBUd1Vv?=
 =?utf-8?B?aFpnd1hTMjI5M1g0RWpoZHRtdjVBbGR1bVIzWXpmVlZvbUsyem1wYldzdHBI?=
 =?utf-8?B?cTc4N0h1bDBNUCtaWnYrRWliaUhuZFVtQmQwWUkxVXNaMkUrZGIxQmErWnhp?=
 =?utf-8?B?K0kwbWpwZGtYYVNPRGJiN3BPWi9wVTVFajlqSU9ZS0h6UUFxZGJKL1Y4OUdt?=
 =?utf-8?B?MEpyVG5ZZStyKys2WGJESlhYUFJoK2tIVXRWUnBGUVRyVDNnMjllN21UdGU1?=
 =?utf-8?B?VWNYS3FvM1BsaWRwMzNRYkFZWFphS3V2R0QrclFlSkMwODgvUUpxdXRKSENj?=
 =?utf-8?B?TVF5cEswU2FKQXN2NUk4cjd5WFErRDhzbTRpMHZjRmZlMlFwbVJYVXVlMDR4?=
 =?utf-8?B?QkFleHRPUVQ3OWhVMHR2Vkk1clFJUEg0MUdTdmlmYytJWmpadG1IV0tuOGFJ?=
 =?utf-8?B?eW5zQWxnMEJMWHRJdjBRNkNmTnNnU1JYNHMvQjRyZGZ0VVhkNDNBOE8ya3Qw?=
 =?utf-8?B?TVF5UmI2ZFJQSVhzdENBaEkzZWRtbXZTQW5XMlBsY2p1RGNodUNUL1FMaUJu?=
 =?utf-8?B?RHJ2bmdZT3lvT3dDSzFuTmFkcVlFMjF2MktScENvbkJJMW90VHNQMXJLb2h2?=
 =?utf-8?B?bDFhbnYvWnJvQ3YvZ3lyZUEzdDZVcGU2WXJvOVhYeHpQcktWOXQ2WEhoT0hK?=
 =?utf-8?B?cDVRZWJNUkhIeFZpVmE0bTg2UmxzOG9yYlcyTjRqNlB5VW1ER1ZPNTBlV0tT?=
 =?utf-8?B?UmlYVnBoR0QzaWhJTTVkYTJ4QlBRTlNkRDNWamk1N0VRMG8vcm90dGFidm4v?=
 =?utf-8?B?QllqbXJUMlVqYThNMW40VWFsZ0lXK3RYRDd0cWJrRVRVQk1vUFo5Sk1jaXFl?=
 =?utf-8?B?d3dpVGhHMUIyUG13ZFRYUGtDbTJFVEVQM2UvMlFhMVdIc0gyeFByejgza1cz?=
 =?utf-8?B?cGRLVzB3emRXclZId05aRGZrak80TFVIc3ZJSHZycVEvWXJvOFVTR0VGa2Qv?=
 =?utf-8?B?R3VGbm9tUnF6Q1VlR1o3VGNxL2xiY0dUMzRQMWFnRk00UUlqNnVEdkF6eFFr?=
 =?utf-8?B?emFpOTQvNFlpUjIrSHBiNkM0YUFJSnQyNHprS2RGeHNHeDdDa3dvd2V0c1hS?=
 =?utf-8?B?SS83S1g0dGtXRXRrK1pTZDlXYlZDbXdqV0FGU1NwU1hrTGpadGxlVC9ZazRh?=
 =?utf-8?B?MjlNbUJ1YTU3MnpFZElSdTFMMncvclR2aTBhczJJWjhzVDJiWlZBSjRrS3Mz?=
 =?utf-8?B?V0N1TFl4aFYrdFNrdTNtVUlEM2RzWDNkWGR3Y2FxNG1oT3dSM2VpMHEzMUhF?=
 =?utf-8?B?aTZXeXJycTdMSTIyWWgvR1UveEtRalMydGlqTlBhc3I5SWxYMHVjWmpLb1I4?=
 =?utf-8?B?WjdGVWJDaVJzUG4yQ3J3bUlkSCtjazBhNk1FSk1Jbkc3Uzhqbk1OWjVBR2RS?=
 =?utf-8?Q?HycjBbAfTozs4oL2rj/LcB+tn?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ce4e33c-ab1a-4d39-69d2-08de38a419db
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB4798.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2025 10:57:39.4150 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b3aHUC7bmyd+VH7bWwaK0TsqWN5Q8eb1KjwLoeJvHD6eLyxPsWwRZhGYrD3BineCeYgPq3pUZLlXmye4ub/YPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB8398
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.15; envelope-from=yi.l.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On 2025/12/11 16:22, Jason Wang wrote:
> On Mon, Nov 17, 2025 at 5:38 PM Zhenzhong Duan <zhenzhong.duan@intel.com> wrote:
>>
>> RID-PASID Support(RPS) is not set in vIOMMU ECAP register, the supporting
>> code is there but never takes effect.
>>
>> Meanwhile, according to VTD spec section 3.4.3:
>> "Implementations not supporting RID_PASID capability (ECAP_REG.RPS is 0b),
>> use a PASID value of 0 to perform address translation for requests without
>> PASID."
>>
>> We should delete the supporting code which fetches RID_PASID field from
>> scalable context entry and use 0 as RID_PASID directly, because RID_PASID
>> field is ignored if no RPS support according to spec.
>>
>> This simplifies the code and doesn't bring any penalty.
>>
>> Suggested-by: Yi Liu <yi.l.liu@intel.com>
>> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
>> ---
> 
> Is the feature deprecated in the spec? If not, it should be still
> better to enable it.

Hi Jason,

The feature is still in the spec. However, using PASID#0 for the
requests without pasid is aligned across vendors. So the linux iommu
subsystem uses PASID#0 to differentiate the pasid path and non-pasid
path like below:

commit bc06f7f66de404ae6323963361fe4e2f5f71a1e5
Author: Yi Liu <yi.l.liu@intel.com>
Date:   Fri Mar 21 10:19:26 2025 -0700

     iommufd/device: Only add reserved_iova in non-pasid path

     As the pasid is passed through the attach/replace/detach helpers, it is
     necessary to ensure only the non-pasid path adds reserved_iova.

     Link: 
https://patch.msgid.link/r/20250321171940.7213-5-yi.l.liu@intel.com
     Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
     Reviewed-by: Kevin Tian <kevin.tian@intel.com>
     Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
     Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
     Signed-off-by: Yi Liu <yi.l.liu@intel.com>
     Tested-by: Nicolin Chen <nicolinc@nvidia.com>
     Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>

diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
index 7051feda2fab..4625f084f7d0 100644
--- a/drivers/iommu/iommufd/device.c
+++ b/drivers/iommu/iommufd/device.c
@@ -483,6 +483,7 @@ int iommufd_hw_pagetable_attach(struct 
iommufd_hw_pagetable *hwpt,
                                 struct iommufd_device *idev, ioasid_t 
pasid)
  {
         struct iommufd_hwpt_paging *hwpt_paging = find_hwpt_paging(hwpt);
+       bool attach_resv = hwpt_paging && pasid == IOMMU_NO_PASID;
         int rc;


So even though intel hardware report RPS=1, the linux intel iommu
driver uses PASID#0 as rid_pasid and ignores the RPS value. So
I don't think we will ever report RPS=1 to VM. Also, as Zhenzhong's
commit message states, current vIOMMU does not report RPS, the logic to
retrieve rid_pasid from context entry is not necessary as well. Based on
the fact, I think it is nice to drop the support. Please let us know if
you have other ideas.

Regards,
Yi Liu

