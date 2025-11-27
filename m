Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABE07D11183
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Nov 2025 13:18:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vObtA-00062J-IP; Thu, 27 Nov 2025 08:18:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1vObrF-0002vn-KR
 for qemu-devel@nongnu.org; Thu, 27 Nov 2025 08:16:37 -0500
Received: from mgamail.intel.com ([192.198.163.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1vObrD-0001Km-8N
 for qemu-devel@nongnu.org; Thu, 27 Nov 2025 08:16:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1764249383; x=1795785383;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=5tp+kTADggpZAdSNV7zrujn2Ld6TBVy2GiVDBS8h6Kw=;
 b=cg3/IdoCpjNhnHSgzGh7uDSHUgfGpwh3djuIIgI4qGkxgCydzxMH35fU
 coLIzF23uAKf5/uIOO20t2K4kiaV2W8prJXA6Ntrm0E4a/NG+DY5bpS0m
 4TBzEU4+TnU1mRALFPgAmNo3eXzNfoq/4QNdUl3HCC9pShfA5vPmCR6+1
 jZDLtY5HTRecjABaKH9M7jniYQGGGIwsxEKC8btiMAKNzhWW0SnWPilU6
 O9nvLZTeg2SCslNmaPVDjH++ohc8xKJ3vFJBiYYbqmPNxuevqw/JUWQ5y
 twVy2ylywZmIpd+ugpb9vA4NfPqb7PRF2/JSMtrDs4UawMGLgNJaDH7U5 g==;
X-CSE-ConnectionGUID: EOsr4ZzgTa2bEvQeD6IJUQ==
X-CSE-MsgGUID: 7+4NU5R5QmORbZ5t719XRA==
X-IronPort-AV: E=McAfee;i="6800,10657,11625"; a="76924216"
X-IronPort-AV: E=Sophos;i="6.20,231,1758610800"; d="scan'208";a="76924216"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Nov 2025 05:16:18 -0800
X-CSE-ConnectionGUID: AtT/1dm8QS6CAdzTKElUig==
X-CSE-MsgGUID: oMS6AgKaQ2GaRESBGNqSYQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,231,1758610800"; d="scan'208";a="194033982"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Nov 2025 05:16:18 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 27 Nov 2025 05:16:18 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Thu, 27 Nov 2025 05:16:18 -0800
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.28) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 27 Nov 2025 05:16:17 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JEtuW4837noPJ0tVKALxwuQk5AMySA4qZ2Ic3NY2P865zmcg4s9Gh3fOoGmM5bCdiGC9ILDQ7xGdnptFhCx2MdLrL3aYVVpb1cKXqTE+wFNTkQQMhOoQcvib8MeeXRUTS5rw0DGZYd+ZrkQoyxBZuWlDYQFM5rZH1nTl8UIVsk6cjL1FcxL86HVyJ4EGzOdYOG5GMrzL1/LZ1buoslnVPK4gyRugbmWk48UBatjXTursMPgZEq4kmvlbGYHQRo3Do6n+laqECGlP9YQ6G4fTljsmFaetfZwdaKJpO+KjvWJq8pOMdmAKSWnMZAmEH30yGcicCWaA0th5onD4XMpziw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2Eyk4oCO960MJEtRcZzVpqsLPwqj48WeEedD0bGfE9Y=;
 b=VG2joo6kA8GXyc58V6nSLeeXUJh5YIUxx2zALr39RrmAdldyz1cgk+eZ2BLziW2u+I4EZuRMW1LxnWyVjg9AG2/C4gtjK7MuBPE5ydDh+k9irK7JCNM6yKgN9bIvNl5PONIolKk1GYc8zROMyxhtxoQFrDqQ0BTJGFC/A5NVdCtSapwBLi4cPgMqUWVsxmAaIix99roZWEEFNFz7EgB1Oj6XF2j3NsiR2ZjGVaSBKM3vhHqIc/8m0myHsDE09vb4DBbtFDoUsMak/Xos8M/U3lT0U469u/c/GcRGwK7xn3JEqth7VuHMo1GbLGSarW0sYZ094rXAxfOykXuIIn00YQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB4790.namprd11.prod.outlook.com (2603:10b6:510:40::17)
 by LV2PR11MB6021.namprd11.prod.outlook.com (2603:10b6:408:17e::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.13; Thu, 27 Nov
 2025 13:16:15 +0000
Received: from PH0PR11MB4790.namprd11.prod.outlook.com
 ([fe80::3836:742d:4c18:1025]) by PH0PR11MB4790.namprd11.prod.outlook.com
 ([fe80::3836:742d:4c18:1025%6]) with mapi id 15.20.9366.012; Thu, 27 Nov 2025
 13:16:15 +0000
Message-ID: <d18b8cac-cf09-40d0-bb50-b36eda0b4900@intel.com>
Date: Thu, 27 Nov 2025 21:23:00 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 7/9] vfio/listener: Construct iotlb entry when unmap
 memory address space
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "alex@shazbot.org" <alex@shazbot.org>, "clg@redhat.com" <clg@redhat.com>, 
 "mst@redhat.com" <mst@redhat.com>, "jasowang@redhat.com"
 <jasowang@redhat.com>, "clement.mathieu--drif@eviden.com"
 <clement.mathieu--drif@eviden.com>, "eric.auger@redhat.com"
 <eric.auger@redhat.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "avihaih@nvidia.com" <avihaih@nvidia.com>, "Hao, 
 Xudong" <xudong.hao@intel.com>, "Cabiddu, Giovanni"
 <giovanni.cabiddu@intel.com>, Rohith S R <rohith.s.r@intel.com>, "Gross,
 Mark" <mark.gross@intel.com>, "Van De Ven, Arjan"
 <arjan.van.de.ven@intel.com>
References: <20251106042027.856594-1-zhenzhong.duan@intel.com>
 <20251106042027.856594-8-zhenzhong.duan@intel.com>
 <6db6365a-225d-4fbb-ac20-d10c424d364b@intel.com>
 <IA3PR11MB9136CF89E7C99375F85E211892DEA@IA3PR11MB9136.namprd11.prod.outlook.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <IA3PR11MB9136CF89E7C99375F85E211892DEA@IA3PR11MB9136.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0040.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::7) To PH0PR11MB4790.namprd11.prod.outlook.com
 (2603:10b6:510:40::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB4790:EE_|LV2PR11MB6021:EE_
X-MS-Office365-Filtering-Correlation-Id: db730d0b-1b57-4b8c-daa7-08de2db724a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|42112799006|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TDdmTlJiVjdRY3R4R0tjWTBSUUFYT0xGL1hkNVpjbXVqK0dDWEV4UjhSNGw1?=
 =?utf-8?B?ZVBKK1NjNjJ2cjZrZjIzQkxaV0FlbEFNellldVJzNEk5cW9WOStHcDd4RUd4?=
 =?utf-8?B?bFpFK2ptZW93Q1pkejM0MFJMVFU5S0tVdzNOMzNzV1lUU2RFZzFXYy9DeG1x?=
 =?utf-8?B?K3pnaHREVjQwNjFxNlA2THQ0Y1V1R2Rya0R5c0pLTWxNNjBCZDIxLzBjZS9a?=
 =?utf-8?B?a090dE8wZGx1ZHBTemZxdHFiQjc0Q3dGWmZVd2hMSWYyekoyZGVFRnA0R1hh?=
 =?utf-8?B?eWpCaUVTY0d6VkZQSy9sZmtIbkI2Z3N2cEcveUR4dVNCc2dTTmhNdE9uR0ZH?=
 =?utf-8?B?alNsb3JTUUVPbEdTbzIyWXpTZ0lVTDVpajVqTThpczgrNkpUVUpmYnJXVW96?=
 =?utf-8?B?OCtqbzRWWUJGOTEwYWFjK05EVHc4b2pNcFJUTCtJUldXTEVqcTZzU2VQa3Bx?=
 =?utf-8?B?UzZtSTdIbEtvMGFQRWtoY0tkWDBUVXdoWXNNTHNoREtRYlRsTWdldzloTlZ4?=
 =?utf-8?B?OFhxYkFDVGJGc2dwZDE4SWFSMUlGY2FDQlJSM3FScUlCajBGZjRtYkNYVDEw?=
 =?utf-8?B?TjFqeE5jWUFQeHgyUFMxZWQxWFVybEUxNzFwMDQvb3FWOHpDVURhWEdJK1V5?=
 =?utf-8?B?ZzV0QUNwbHNVdi8xWUFFUWR4dW9KTXhERUt2VHVWcTFXVXoxTmFIVnVMN2N6?=
 =?utf-8?B?dUZsYWtPbFAvZmF1djNhK0kwbGdtajdGNDd1UnhLUDlTNk9xQWViSk5HdHRW?=
 =?utf-8?B?RlE2VytKd1Rjc0lrU3NRRG1NREtpWjA0b3RGUjRmcXlIdk9td3dycm4wY1No?=
 =?utf-8?B?NUEyY1VFM0dXTzVTMzYzNTlFWm9Qamt3WDh1RlVHekdveDBCZU4wdFpHdXpr?=
 =?utf-8?B?bmkvbEdpR3JTM1BUZi96NEpnSk5yQWRYaEs5VFgwZjk4dGFqQVVpcHhPNUw2?=
 =?utf-8?B?K2RwbW50NEhKTXoxbXdpamozQk1vWkV6ZS85SkhKM2NVRGRSNnM2UkN1eFF5?=
 =?utf-8?B?TDNRV2x5cXBaKzhkY1hJVTZwN0xJVWxVNXZNTXUzMVJzVFRvYlI1TmlNZzJE?=
 =?utf-8?B?WklWTE0ySmliYnU1RElMZmQxc2J2dkMydUg5WG92YkI3M3EvUzNGWlI1anI1?=
 =?utf-8?B?VTdRdFVWWnA2S053eXZBbkdOckJQQUQ3ZGpZNm1oWDZiUjZKZ0VKWFFjaDdU?=
 =?utf-8?B?TDUxUGxGVVlPb3FYM3VzZ0ZsU3BoQXNaYXdtUGVIVW9SSm5yakt5VnFibEh2?=
 =?utf-8?B?enpYcXZLYXh3Y0xvdWxLOTRyY2QxalBnWkJpQnB5YXRDZXJGMzgySE9UKzNF?=
 =?utf-8?B?YmtkTjZBNzZRUGlyRmxkNjJ5Mms5RmtWRi9KYVBWaW5odlhsaUUwS0VZM1RU?=
 =?utf-8?B?VG5GdkhIS2Z1K1pmSkFXMGV6b2JiSmxRa0JIT0QvamVReVo1Si8veXlZZ1R2?=
 =?utf-8?B?dTJzcnZKQWJJelNwaVhWa3Q1T1FPd2xZaDA5OS9RQTNrbjV4TVUvVjVadERD?=
 =?utf-8?B?bUJQTVkxOENMZHlkZ3o5NDVKMTB5bjBHNndMS256SG9NMmdiR0hTa213OEx5?=
 =?utf-8?B?WDlvZzVGSXFTbGtPVE44cy9pZ0hxb0pNN2Q5MVBsMkJHbk9wOVQ0NFBaS3pW?=
 =?utf-8?B?VklsNEg1SVJ5b2RKSzYyZmUzSS9wRHBMeXo5VTBHNzhrYXg4cG9CSFd6em5Q?=
 =?utf-8?B?T0dVcG5LZHpGZHJQK3dNMFJ2cFFKZDBuV2hGK1N6S0k5VkU3WmVoREZjcklx?=
 =?utf-8?B?MU44L0VDR002YVFBZHV5MDdWb0h2UXJOYzhDWUdFb1VrTW5pTTBKejFNcCsy?=
 =?utf-8?B?dW1jdGc4Z3c5bGpqYjBuc3lRWXB6SG55UTZiNXRoeXJURU5wSVZyTGVXMHMy?=
 =?utf-8?B?RTJHMGZTeFQ5dUNZYVlLMWM0RittYTdzZ2g2ZXJKVk14U29Ub3ZPNjJvak9R?=
 =?utf-8?Q?jVafsKiaaHZsB1c10grE4GlgRIzjC/+k?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR11MB4790.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(42112799006)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?REVHQzQzalNmcitraHdOTnBMSU1OQnUxcmg4cXRwa2krTkErT1puV3hKR3Bq?=
 =?utf-8?B?c3R1VkFUNUsxbGJwRHBSdlcxcGJ3b3ZXME5MME02OVhOL3lON29ZaGZOZGVL?=
 =?utf-8?B?MkRQUHdJaCtYVVladUhXekQvbGJ0Z3BwKzJwd2liUUZtRXFub3R5Mk10MDJn?=
 =?utf-8?B?UlFNYXo4WHppOVFJTTArNlMybGNqaDhQcmJUVmZ3enZGaVBLZW5GWE1SS0tS?=
 =?utf-8?B?T3h5NHN1Y01JSmdqckxkT3c4bEpYUEhOQTR6VDIwWlIxUThCZFVrMDlYdGdD?=
 =?utf-8?B?U0dMTnFRSnNNK3dWZW9oNWpZaE9nMmNUazRHMUJZdnJocHl0YlFCL3FqOGRs?=
 =?utf-8?B?dlluWlhiVEdQL2ZIaFBMcnBFYitBSUtCWjFLL0kvSWNFSFIrbll2SXpLZFhP?=
 =?utf-8?B?MzVoTHJ4ajJBajY3d2pOdkZ6ZGxoY3YvWWVzUEtTbWZ2SHFvaXlPNGpMdTcv?=
 =?utf-8?B?Z05wT1VMVklDVHZZOXNuaE5UYS91WFRsY013OE01QTFXdWFWay9nTHo3eS92?=
 =?utf-8?B?T1hNbkIxL2I1a2RNeWl6TFRKZitNbGdLNGVWL0VxT2RmSlcxWjIzRTRkUnhq?=
 =?utf-8?B?YWVhQTZYWlJzbnYzWDI4SWdLVTN1Q2xyTk9pR2RNUmtuS1dCWDdiNGpMd3Rp?=
 =?utf-8?B?R2svdXc4SmkxTWkxZEVCcHp2Z0taVFVOcGxrcDBxK3ZkR3ZNWjVpdUdVaUlQ?=
 =?utf-8?B?QzFmR1VSTjBYNEw1Rmp4d3V2dmVVQk1ud3kxNlY5UlhROHR4UHpnRnFPaUhR?=
 =?utf-8?B?Z0JibGFvTTBETzNZOS9WSWZTdG93ZldvQ1BYRERmQkx6Q0o0eWtjN1BvMmR2?=
 =?utf-8?B?QlE5Q1VCeFZuamFkd2pKWnBsU1VCSHpSV3NGK2MxRTI2cXp6bWdSd0JsM3JZ?=
 =?utf-8?B?TlFXQzcrc2tRNElMUGk4QTlHT2Q5RUNZUXFzaGMwdk1sbENqSDVsbW5NUkt6?=
 =?utf-8?B?QWtCME9meEltbWIzNEYwNjB2a2wxOWRSQldGYnkxTlY0ZkttV3duM28vS1dW?=
 =?utf-8?B?eEFFK3I1anFPNHBZVUxPU2JqajZzY0pNd0NEYnh4WjdyS2Yvd0paL2J1NjFB?=
 =?utf-8?B?ZHdEQnU1L3h2UWxTdW1HV3V0RFlCcWdyOXEyaHlQdlNxL3ZCbzF2aXNJbUxF?=
 =?utf-8?B?SlQvU3ZnRGwvWWxiakQyWWdOc1duQ21RUTRSUXBlcCtmcGFud3FGM3Y3WHN6?=
 =?utf-8?B?YTc4aEs2ZXRqbEoyNGNZajE4ZFBVZk9iS1JYS2JhYlNWREUxajZtOUFYcWFO?=
 =?utf-8?B?SXRsT3l5OHhkd1ZlNHd6Y0I0R083YWd3Qmx2WHVVb09yb3pjTDludVlIUGpq?=
 =?utf-8?B?R0ptSE5HdkJISlVkUkkyejhKZGVBRmlxWFIvTFhuMzZpVjdYNEx6dk1KMHV5?=
 =?utf-8?B?MnFoaVBZRUFjeFRsVWx3bTgzNE5INUlUb2dsWi9aZ3U0QmJmQnZKMU9BZEJh?=
 =?utf-8?B?N3FLR29LZWdEcUFwZkpnMzN0Sy81WitIL0hGRnUxU3RTbEN2QTVPa3BOUTdw?=
 =?utf-8?B?bS9jdHM2ODRuUURRd3FpRkFJZVJXekZ1WEkrVUFhUFc3NDA2bUxQV2NJMnl6?=
 =?utf-8?B?K1lqamVaZ01pTWRJQjREL1gwcDlvQUk1R2Rud1Q5cW5td2hKYVo1bGxQZEMy?=
 =?utf-8?B?MEZ4VnJoN3Zmb1Fmc01NSUJ2dDRQZStzZ2xKbGdDVEprZWM1eHhRc0o1UGV5?=
 =?utf-8?B?NWEySW8xT3dNK2NDMTh0ZU5HR2U5MGYrRHZES05BSTFvaHk0ZktNQ0ZMeTA3?=
 =?utf-8?B?bXVsMnU0VFBZeHR0UVdWZVg2aDVkSi9FOWhZd3BrR3lUMkorWldLclYxZ2Yr?=
 =?utf-8?B?MFBDSTdaMDJVYkJOazdzVGdQck5VaHc3OVdJVVRmbTA0S3hWMFFROUQwaDVq?=
 =?utf-8?B?aXVPcjZqV2o1ZGQ0cmVPY25RV2lGWXBMeWs1Nm8zZzBZejM0bnRzU3FURHNm?=
 =?utf-8?B?bEdhTmJwNXpySlJVWVJjMGVucHVFcUo4STcrV1N1TXZveDRvNmJZNVhkcnIw?=
 =?utf-8?B?VWNOTk9nVzJKa05QMkRpTFVIRDFBMGFHY05IUEpxOVlEdFo2RG1xNytrbFl4?=
 =?utf-8?B?TDRTbzMvbnV3ZTBVWGVRUzRBR1JjMlVpRERneWltVnZaUEcySnZIeVUySDZi?=
 =?utf-8?Q?GHVfB/auJWMIGLMyE0pEwMBF2?=
X-MS-Exchange-CrossTenant-Network-Message-Id: db730d0b-1b57-4b8c-daa7-08de2db724a2
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4790.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2025 13:16:15.3292 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lBBKkASx23bj6xFmwhn+sDUbQn1DRTf6AD9v1NCAZfy06RH6HZYZBoeb0yj54R5/9xT3E6X0asD1zSXYWJL32w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR11MB6021
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.11; envelope-from=yi.l.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.224,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On 2025/11/26 13:45, Duan, Zhenzhong wrote:
> 
> 
>> -----Original Message-----
>> From: Liu, Yi L <yi.l.liu@intel.com>
>> Subject: Re: [PATCH v5 7/9] vfio/listener: Construct iotlb entry when unmap
>> memory address space
>>
>> On 2025/11/6 12:20, Zhenzhong Duan wrote:
>>> If a VFIO device in guest switches from passthrough(PT) domain to block
>>> domain, the whole memory address space is unmapped, but we passed a
>> NULL
>>> iotlb entry to unmap_bitmap, then bitmap query didn't happen and we lost
>>> dirty pages.
>>
>> this is a good catch. :) Have you observed problem in testing or just
>> identified it with patch iteration?
> 
> Patch iteration.
> 
>>
>>> By constructing an iotlb entry with iova = gpa for unmap_bitmap, it can
>>> set dirty bits correctly.
>>>
>>> For IOMMU address space, we still send NULL iotlb because VFIO don't
>>> know the actual mappings in guest. It's vIOMMU's responsibility to send
>>> actual unmapping notifications, e.g.,
>> vtd_address_space_unmap_in_migration()
>>>
>>> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
>>> Tested-by: Giovannio Cabiddu <giovanni.cabiddu@intel.com>
>>> ---
>>>    hw/vfio/listener.c | 15 ++++++++++++++-
>>>    1 file changed, 14 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/hw/vfio/listener.c b/hw/vfio/listener.c
>>> index 2109101158..3b48f6796c 100644
>>> --- a/hw/vfio/listener.c
>>> +++ b/hw/vfio/listener.c
>>> @@ -713,14 +713,27 @@ static void
>> vfio_listener_region_del(MemoryListener *listener,
>>>
>>>        if (try_unmap) {
>>>            bool unmap_all = false;
>>> +        IOMMUTLBEntry entry = {}, *iotlb = NULL;
>>>
>>>            if (int128_eq(llsize, int128_2_64())) {
>>>                assert(!iova);
>>>                unmap_all = true;
>>>                llsize = int128_zero();
>>>            }
>>> +
>>> +        /*
>>> +         * Fake an IOTLB entry for identity mapping which is needed by
>> dirty
>>> +         * tracking. In fact, in unmap_bitmap, only translated_addr field
>> is
>>> +         * used to set dirty bitmap.
>>
>> Just say sync dirty is needed per unmap. So you may add a check
>> in_migration as well. If not in migration, it is no needed to do it.
> 
> Dirty tracking is not only for migration, but also ditry rate/limit. So a non-null iotlb
> is always passed for ram MR. That iotlb pointer is used only when
> vfio_container_dirty_tracking_is_started() return true.
> 
> I can add a check on global_dirty_tracking if you prefer to add a check.

yeah, this would be helpful.

> 
>>
>>> +         */
>>> +        if (!memory_region_is_iommu(section->mr)) {
>>> +            entry.iova = iova;
>>> +            entry.translated_addr = iova;
>>> +            iotlb = &entry;
>>> +        }
>>> +
>>
>> While, I'm still wondering how to deal with iommu MR case. Let's see a
>> scenario first. When switching from DMA domain to PT, QEMU will switch
>> to PT. This shall trigger the vfio_listener_region_del() and unregister
>> the iommu notifier. This means vIOMMU side needs to do unmap prior to
>> switching AS. If not, the iommu notifier is gone when vIOMMU wants to
>> unmap with an IOTLBEvent. For virtual intel_iommu, it is calling
>> vtd_address_space_unmap_in_migration() prior to calling
>> vtd_switch_address_space(). So I think you need to tweak the intel_iommu
>> a bit to suit the order requirement. :)
> 
> VTD doesn't support switching from DMA domain to PT atomically, so switches
> to block domain in between, see intel_iommu_attach_device() in kernel.
> 
> So with this sequence is DMA->block->PT domain, we have guaranteed the order
> you shared? See vtd_pasid_cache_sync_locked().

I see. So guest helps it. This might be a bit weak since we rely on
guest behavior. I think you may add a TODO or add comment to note it.

BTW. I think the subject can be refined since the real purpose is to
make tracking dirty pages in the unmap happen in region_del.

vfio/listener: Add missing dirty tracking in region_del

with this and the prior check, this patch looks good to me.

Reviewed-by: Yi Liu <yi.l.liu@intel.com>

>>
>> BTW. should the iommu MRs even go to this try_unmap branch? I think for
>> such MRs, it relies on the vIOMMU to unmap explicitly (hence trigger the
>> vfio_iommu_map_notify()).
> 
> Yes, it's unnecessary, but it's hard for VFIO to distinguish if try_unmap is due to
> domain switch or a real unmap. I think it's harmless because the second try_unmap
> unmaps nothing.

hmmm. can a unmap path go to region_del()? Not quite get the second 
try_unmap, do you mean when vIOMMU unmaps everything via 
vfio_iommu_map_notify() and then switch AS which triggers the region_del
and this try_unmap branch?

Regards,
Yi Liu

