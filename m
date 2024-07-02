Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EFE8C3064D
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 13:40:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOdkX-000897-2v; Tue, 02 Jul 2024 09:40:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1sOdkN-00083Y-Qx
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 09:40:40 -0400
Received: from mgamail.intel.com ([192.198.163.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1sOdk7-0007Ok-Lc
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 09:40:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1719927623; x=1751463623;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=8tNSHIA7PnwFqcww7e44xfgN25ThyJdbYWA5TpdMIEM=;
 b=k1Ukun5v8Rjv/idgpzQhdoaBGtEn61cmLvONfNswJk6mv0tekVpt2N7Q
 LDNRMwatcKu51+cmstxnayB+Dfs++GZ99LiGRUVjQ6DPWCVtuNWSIz/GE
 QL/fCs//hL/kf94r+DlCfcI4+775cgUpvMkclno5Oc9BPgFj7g3SSQScM
 GYlwdsnna7GIcCrS7CnKD/83iLfALB+F1i8wkB00Ym/A1h3l/KvWPbai5
 OgW4zgaqUMSFkRDCNdO6U9j2yq8x9NhPmULlNdSmMsZ8hYk1NuQJ3BFTR
 URWnAu2HdbsFrSTlsjsLdwGor9ZRFT5x9tyfkbfqFlNJTTmk1wHhMo6Kh g==;
X-CSE-ConnectionGUID: 3WLWbujeTw2bPpMUqkUKDw==
X-CSE-MsgGUID: LI+SkI5YSMWS0gcOAD+Egg==
X-IronPort-AV: E=McAfee;i="6700,10204,11121"; a="27719875"
X-IronPort-AV: E=Sophos;i="6.09,178,1716274800"; d="scan'208";a="27719875"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Jul 2024 06:40:20 -0700
X-CSE-ConnectionGUID: Cq+WVJZFT0Ct35ne3oKpEw==
X-CSE-MsgGUID: EBqyjgrpTdSLcumhb0wqwQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,178,1716274800"; d="scan'208";a="50523922"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
 by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 02 Jul 2024 06:40:19 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 2 Jul 2024 06:40:19 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 2 Jul 2024 06:40:19 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 2 Jul 2024 06:40:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SuCeDgzo4LrtESSrbxzEgyhDvXwG88N0qpvUvMuApk4/BuBOJN/VZ0J4oqqqSeXaRJW2tLi3V6YUwiHC6m+2ax7X6imdLqOcrHb0VbCr47Oqc1cDM6xUpOLwRZz/t7hLwGDhR3IsHIVj25hvrVbe1ZYqFmVRuGtEFewIza2cGlkiEAIguGYa72Haf2vK4+rR5rUDUutKxz5DZnAXLGXE2COr3+UE7NmpHrVfP7FhtUaOTPwV9ivQqmPkDgrGZy41L03C/wQE0nOr8CYHqDisSJfNA/akAbNjs7cj4p1A+j3+hOaYFl//VyUi/G1gevuQEehv2lHC9PHXVP/XLm9kmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F4sNxvRULLMtYWdecp/lWC8NMXbzPDPq9TjAqFCBQTs=;
 b=FyVorS2V4NXyTBRxZDtW3sYzKPiczqTaMsCUnbfHciCZ9Pm+PMnqnPai4sFj5oMEr8tm5FMahSBOjVvilGtsI6qe4m5VAQ8keAoH5WsPScytmOnlpnUprzgOn430jXXutUW1UWy+dSZ+2guQWGYrQ0lbNGRcCn5ckTMIvoGwAYeILE9CgDlx5IORMGpM7h4wTNO+dpreTs4eSCwiogy2aK3ASb0gI9NYhJuyBGdQwgqOc9Jv6QKr/jBMqSL35/V4FHigCrApuWhwf/KK7+ZA4Hl/ZcU2D+YehjWQj9aVbmouegRAI42xQ2byJRaWHHdfZtoKQLvwJFyk3RUseoihJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by CYYPR11MB8360.namprd11.prod.outlook.com (2603:10b6:930:c3::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.29; Tue, 2 Jul
 2024 13:40:16 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a%3]) with mapi id 15.20.7719.022; Tue, 2 Jul 2024
 13:40:16 +0000
Message-ID: <9b17bedc-b55b-4293-a1ff-4120296dc83d@intel.com>
Date: Tue, 2 Jul 2024 21:44:12 +0800
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
X-ClientProxiedBy: SGXP274CA0018.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::30)
 To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|CYYPR11MB8360:EE_
X-MS-Office365-Filtering-Correlation-Id: 36cfc938-7607-4ecf-3d18-08dc9a9c8172
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bTJWWkFuNGFucTRjQVNWclZiRVhjNmU3NGJSb1dFVXFGc2kvRS94WXNFS3hD?=
 =?utf-8?B?WS9PdENjUGlUQWVRUWRmZ3VLOThhOVZ3N1ZNSVF4MEtQK2dGU0wvb08zVTNF?=
 =?utf-8?B?VjRPaU5UYUdKRnBhNFAyUEEwS2tpdm16U2laMG9UOGJLR3VNd0hHNlZyZjZK?=
 =?utf-8?B?SFU0NUVvSGxvUWdMbXNGSEttUUNpNjhWclpjaGtEMmQ3dEx6dHEyc2NRM3V0?=
 =?utf-8?B?U1BiUW5pUlR4RlVLMm93UnVXQnozK2lEcm9XaEtQODF4U3RWZ1lpZTkySDA5?=
 =?utf-8?B?L0ZDRlZnb3gxNTFsVXFTNGp5Z2Z5ZTVXTDlLYW9xaUVPRE1WU1AxV0txUzlx?=
 =?utf-8?B?bEhXYThJRlVFa1NOM2VqQkdtNGI0cVJpOFRnY3gzMXkxT25qYkgyd2tUQm9C?=
 =?utf-8?B?MlAzL1M1Z2M3UXhNQnc2Q0N5cjB0M0pnc0xaRFNLTGJGaVJCaUQvZnRyZEJo?=
 =?utf-8?B?c1hFNUx6b3N0S2ZUZVpjdFVSalNMbk9HL1BwVlQ5MGZNUUcwajIrbVJpQ3l1?=
 =?utf-8?B?VXhObHVGR0RORlBMZzA0N2xBTHVYMEZVTnFkRStBT2xDSjlRZHNZQnkyL0tZ?=
 =?utf-8?B?Mm1PY0ZVd0szV2pHeVVzZE9YZjNoY29lVVNtbit4K1dDcEZYd2dXN2hmaWV3?=
 =?utf-8?B?T3B3ZUk0QnhxZHZUU0tpdFpYK053MHdNUnplT1Y4Tm91d3hnNnorWDNsZitl?=
 =?utf-8?B?UXBiTmtnenJLUm9odFJmYlJ1cDdrRDhmSnZSMkdxcDB1N1JrdUt1dk5EN3A4?=
 =?utf-8?B?ckt2RVlGaFVFbkRSeUlsU0lOQlpETU5wUzdQR3lYZmdLVHBETFg0aVpiS0Rz?=
 =?utf-8?B?aVZ1L08wNU9DejBwcnpnUW5wa2tvYkErVlYyMmdHdjMzdnd3b2tDYWd3ZzJW?=
 =?utf-8?B?Q3pzRW9lRWpRc2c1aFVWY0d5SVJSdFRVd3UwbjQ4ZlVRTGxrWFFia0hPdTdr?=
 =?utf-8?B?UWswRkx5eisxN3JuY0cxV2JQMnRtbDNwcWx5UXVid09TdmRyYjM3YkVub0Zz?=
 =?utf-8?B?WUJia3N5ZlhYazh5Z2FOYkpiamhRZVlZZkRSRlhtNjcyK01iU1hPdVpvaDd2?=
 =?utf-8?B?bjhlZkdXVUJxNFRWOGQrWlBRRWhzc3V6WHNScHJLN0F1QVRIczNqb0t0ZTk2?=
 =?utf-8?B?OGNQcFVzOVMrSmRQZ3VPMGZRTjJ4UUdtVFNoZ3A2bW41NXc0TTU5dTZZZmZx?=
 =?utf-8?B?MExxaWlMRkpLcm1MNWxhZGp4UVJrcFhGNkp2MmRwRVJQMEFIclBTYVE1V0JL?=
 =?utf-8?B?NjhxV1gvNzd1a2pxa0VYZHlEQitwUUFmWXRPclN3M3NnaGs2MFNpbEFJcW9L?=
 =?utf-8?B?WEtVZ3JVMGhXNjlNSmlyZnhkOERJNmkyc0YwYkNpTGNnUDROblY4ZWJadUJv?=
 =?utf-8?B?Ym9JUFE2TjBhdzQwTjZsdnAwZ2dhWFRYZzdTSXRMMHJ0VnNDQ0dWd2M0OGk3?=
 =?utf-8?B?RHdLNUREdnZ4VnBpUk5nVUR0dEFkcm0vZTJYOVFXWUZCVFlrNlVxRkhwUUdX?=
 =?utf-8?B?WFV1b1ZYZi9UN2VmUkZoRW1CaVQyZExEVk54aUZRRzN1cEg0YmpXY25tMlpN?=
 =?utf-8?B?L1F1NW9SaHpQNnR3WGh1azhXRnM3Mm1nWis4cDZlVnJXQzExaHRBekladTJ6?=
 =?utf-8?B?WThOMmxBNHRVbkxkRGJCYmhwRWxSMnFZUnlWSlJtWVhYNm53US9JTElrNDYr?=
 =?utf-8?B?SUx0TCtIVjEwRlFaTnIrMTI2aUFWeXQrR2IwOFZJeGNnaWN0Q0RZaXphMllW?=
 =?utf-8?Q?/IszNvMYENrMUxhbTQ=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7529.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y2k3c21SYzdWeFIrSC85U0cvVDYvbW1RQkl1YktxQmoxVU4wSktCb1dPUEZV?=
 =?utf-8?B?bW5aV3JmYmE0ZysxL296NkZ0UDdXMGZaL2xESGMxdy9uR3VNOHZNektNRFpy?=
 =?utf-8?B?c05sb0hsbi9rRk9HYzlaeUxKelVoK3owd0lIUURNdCtLRU54UkJtZExmSEFE?=
 =?utf-8?B?Q3hTMnNDNUV4OXB2Zmo2cXJpdnc0MjRYb1pEOFRhNHYrc05kNjk4bmd3T1NU?=
 =?utf-8?B?VmVKV2RsUXBCcEM1SU90bkVsZVdyZmo4SnpqcFUreStMQzdsclFtYnpETmFi?=
 =?utf-8?B?em5WeGdGMHhLMWJJbGZjeGRPTk4yRmZ0OXlocXFsdnNqMnRUZ2FlSVMyVlpL?=
 =?utf-8?B?ZWxJUFRnakJjbVdZNVFBNHMzWGRlcXlQQ0NDZWtPZkJib1pZVHdENk9RanBo?=
 =?utf-8?B?SzRJS25FeGFxQ1c1V0dndmlBcExuSmlDdWFuUit4dVhKTE14RXVpZUJnWGM4?=
 =?utf-8?B?Q3h2Wm4yQ2RVeXVUK3o1OCswUU5DengzekVUY2JkNXAwcUtab0ZyN21HV0th?=
 =?utf-8?B?V1JjSWZYVmdMdnNQemVyYkt3Zys5bE01T1dQWW9ZR1FnaGVLSWNpWVMwRXFp?=
 =?utf-8?B?RlZubkdrZFYrVjUzcnVMQk45NXUzeFdmR3gwOVNlV1ovQlY1UU5QWEZ4S3ZR?=
 =?utf-8?B?NFRMbVlZWmk2T2dKNGVNaTNjUmNHUkl0YjdiWUN2RStsUzNHNGFBUzA2d3o2?=
 =?utf-8?B?RFZvSUV1RS8yb0ZaWVNmWStHZzcxbVZuaGhRbHFzZDRtZ0crMlIyc0F3KzJw?=
 =?utf-8?B?dW9ZUERrL0VUNjErMW1UYzA0ZXZLUEVwWVEwQ1dPcTBqbURoK3pKL2tyb3lX?=
 =?utf-8?B?cmRaMTl3K01PZ3cvYXhTS0poT0ZDblBwQm16WTlrZDhQajF5NURMVGFqdDZt?=
 =?utf-8?B?cUlVa0laU1NndjQ3TWtWT0NndUV2ZUZQYXU3QzRFMi9NUGNSblhPN2I5Z2I1?=
 =?utf-8?B?SmlsRFYzZXJadmtzUjNFbjdCR3o2ZkxUZ1JtVGxXenlIL2pCb0dMVHpLckJO?=
 =?utf-8?B?MTdQSmt6U1h6WGt3RjE2Q0xBUFBVNm1sTGhoVk9zMEVjRGxFL1JXR29QTTE2?=
 =?utf-8?B?VThwT0tXOWZHQld5NFVzWVdkOEVoVHZVRHMveFNHVDZUQitHZEFTWmZSMXdQ?=
 =?utf-8?B?TXF3UmZ6NUtWbEdsaFVLVjM0QWtvNTBMWkhOYlFMMWZ2empZT1hXNGlBZlBF?=
 =?utf-8?B?dHlGTFdLUjgvWkJWOUxhMzdZQ0FZWmFLa0ZGOFIxdGRic244cmlJVGQ4dXpr?=
 =?utf-8?B?cFJJaVU2NnJha1czVkI2NFU2OFBjVlI3bmJxWGVsaWM5dzY3bTZVZXN0aUN5?=
 =?utf-8?B?dStxZWc4U3lSSURGTzBGUVhPd00wbnJ0VHNnS3paVVV4U1lpVDJxNHVqM2N4?=
 =?utf-8?B?QUNrWXJqT0JNYlNMSzl6eTJHZ0w3OTNicUdIZktTelczWUx6Wk4xQlEwbnVl?=
 =?utf-8?B?bmVEd1JFTThrcjU1d1o4WU9xUzFNTHY5SjhjRnNiUkMxU3AxU3hOUDVaTTZS?=
 =?utf-8?B?ZUU2N3dtcGduZGNKelkwTjJhS09oa2tYeTEwTmNJWjZGT1YwVjF6TnFTUmlJ?=
 =?utf-8?B?aHdHK0hhU0w0QmNaM3NoQU5zeG9xRDRpb2xodTN3cVBqUXJ6bXMxdmdESWZC?=
 =?utf-8?B?L3AwZHljalpnRTY1dm93VHhFODRiZ05Nd3lkVzJTTDlVanBlSEdzTEhIUzc0?=
 =?utf-8?B?RjdxNUkzQk9QQm9CTWVLczB5ekZFWlNIMmtLQnF3SjE5UjNVNlB4ck5McXpX?=
 =?utf-8?B?YkxsZG1MUUJvM01FUVBhS2NhNjExOHlLV3o5bWZocVlYSkNXSXp4Z3FVenJJ?=
 =?utf-8?B?ZG05TFhPWEV4VVZnZ0dwS2ozM0hRbEZON0htemx0bGZiMnF5Y2RpcGJRbWI5?=
 =?utf-8?B?RUtvb25KdHBIeVcyWkxVRGsxMkowTVFTSGF4QjdManIzc3hFTVRxeWVGUHVL?=
 =?utf-8?B?M1RQc2pTNno1NUI3SFNPMjdFVGpoNFVORFJUcTdLSGRFd2lzVjcvVGVXSUJT?=
 =?utf-8?B?WWhtdy9uYnI1N1o0bmNVdUVZSjhVcldUbUx4eUpJQzgvMGtSeG5RaGdaZEZV?=
 =?utf-8?B?OVBEWXU1ZHkrcWZCdzZzUGVlSWVNUzJoYW0wYkFjODdDUUc0STJhZnY1UUVQ?=
 =?utf-8?Q?ZHYsHqp3DFLo8LnccAjNyTG+o?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 36cfc938-7607-4ecf-3d18-08dc9a9c8172
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2024 13:40:16.0143 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kU/INc4tRfkwdlL6vN6Hckv1EUchps2LtdYZMOacEu5tv9JZyL+MwzpEFyT1hYduOJZsnhEWOmMo2O6BgQetnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR11MB8360
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.11; envelope-from=yi.l.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
> 
> v5
>      Changes after review by Philippe :
>      	- change the type of 'level' to unsigned in vtd_lookup_iotlb

Hi CMD,

I saw two v5 in my inbox, are they the same? :)

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

-- 
Regards,
Yi Liu

