Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B42B4C30658
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 18:13:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOhzs-0000d9-Cm; Tue, 02 Jul 2024 14:12:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1sOhzq-0000cW-65
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 14:12:54 -0400
Received: from mgamail.intel.com ([192.198.163.8])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1sOhzo-0006wt-3E
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 14:12:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1719943972; x=1751479972;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=mwcImFeK5VdywXPHsJeVDqzED4WzJxV4FVwFYD/HUJo=;
 b=cD3v6FkXUDDiMCvV1cMlOKbxDFp9k1JU/CZXg7kOdnET+e/NW0+5Aw/e
 PWOCDO8hjL9DKetX5J2QSpwpTyyleVyqj9xXIW0s3GE1b02zk44q8AtRy
 KNtiVlVwGovJRxk6vooHZNQl3xklzsNrcZ3erTYsXHYcCkIRNqajRlFPr
 8go95CuRop7ffKsFqgEEy7VnHLKAEmjoCl/1hCN3b2mF+erS68pSbCrsS
 RsajsShYwasYfSP13yh6V3gnLAh9UjimgAgt8QwKdxTwF2VpyWhc4sRxw
 e4O1E7MaE1FcujUW/K1xLJrxWBjtLTd8g64ee5E2IM2E62ljmpAkYB0EQ A==;
X-CSE-ConnectionGUID: FiSobWesQxysBs+9kKlk8g==
X-CSE-MsgGUID: 9Qth0t3FTzKPqWqC9p9QSQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11121"; a="34676418"
X-IronPort-AV: E=Sophos;i="6.09,178,1716274800"; d="scan'208";a="34676418"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Jul 2024 11:12:50 -0700
X-CSE-ConnectionGUID: DgW4fNADS6qbbsowQOUH3A==
X-CSE-MsgGUID: /jSsUajSQk+QBpPcDvKC9A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,178,1716274800"; d="scan'208";a="45975407"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
 by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 02 Jul 2024 11:12:30 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 2 Jul 2024 11:12:29 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 2 Jul 2024 11:12:29 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.48) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 2 Jul 2024 11:12:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gccQ5Pq53+rX3VZzZA2TAFDqyyJcQZF54pXfa/AHajeMTRBngowdzg89lMX0z5psZUx1dvW92NxJC0dZXFvwp0u3kQu5Ekfo3aJCkYhs4frEeN8st/VwYNiq8OOJQuLyOJNLSDdWA+ThVoxMf/s5L0Oz8oWqVJrqoaSHKWGVIcFO2ZsaQHudQm3FMPA72T74Oa3HWPkQSCLBrQvCdMRf+uErOOYSsT2wgvOqUSpHqfFLNGeUzVnQH2AZFcHcFbhqEhPiaWoUs0Ah+QGY0KdexiymnQ2D6vF15l07yMZVIOLxGTQa+bUbT7U+mRfAPEylqwVvUO8zQavNcdxdUq99dQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OB8qbkseW3eNpj7LB5q/zHXntFdyohPizHtn0wyzZ+o=;
 b=IozqwIisTyRH4DGMbu9mJvMIBYgVHsdA2TcyBgERMXWNF9Rbg4pMGtFJceCdYbsZCvMqk/4bQmTo2xKm5IZ0D9iUx+7p/jYFZpyYIKSLiUrvrgV3w+FPjCLPx7Rv5uQv5qZDScEkV19CEZ+MYSqlP8I8dFxdVH9r8bQsJYL4U73hwCRhtebK2avuGnJEVQnJxMaI1lzp6ISp9pSDIjRLMtnx2Lp9eMRxrWIqybr9ptl6/RPAtv38pWA0gxJF6O4V+INXOMFXbtcMSIpR7/7/7nIj2yTlDv5z+RXxbvH45iyf8J6u3QE7+rZffs4J6EQ3mtMlEgAq4fm09SjYaLzWaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB6879.namprd11.prod.outlook.com (2603:10b6:510:229::22)
 by MN2PR11MB4630.namprd11.prod.outlook.com (2603:10b6:208:24e::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.28; Tue, 2 Jul
 2024 18:12:26 +0000
Received: from PH8PR11MB6879.namprd11.prod.outlook.com
 ([fe80::bd3d:59f2:9d29:346]) by PH8PR11MB6879.namprd11.prod.outlook.com
 ([fe80::bd3d:59f2:9d29:346%5]) with mapi id 15.20.7719.029; Tue, 2 Jul 2024
 18:12:26 +0000
Message-ID: <3d98e4d1-ab12-4108-a82a-063bf2c2c72c@intel.com>
Date: Tue, 2 Jul 2024 11:12:24 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 2/4] ui/egl-helpers: Consolidates create-sync and
 create-fence
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@gmail.com>
CC: <qemu-devel@nongnu.org>
References: <20240620231727.235841-1-dongwon.kim@intel.com>
 <20240620231727.235841-3-dongwon.kim@intel.com>
 <CAJ+F1C+zF24yTBcx_2X_0e+NZhqxzxk3HDXRzc9eDyWp7uYyCA@mail.gmail.com>
Content-Language: en-US
From: "Kim, Dongwon" <dongwon.kim@intel.com>
In-Reply-To: <CAJ+F1C+zF24yTBcx_2X_0e+NZhqxzxk3HDXRzc9eDyWp7uYyCA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR05CA0019.namprd05.prod.outlook.com
 (2603:10b6:a03:33b::24) To PH8PR11MB6879.namprd11.prod.outlook.com
 (2603:10b6:510:229::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB6879:EE_|MN2PR11MB4630:EE_
X-MS-Office365-Filtering-Correlation-Id: c369db57-7ff4-4ceb-a0c6-08dc9ac28735
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?U0haVTlpV1RwN2Jkb0dqeURRVGNmVk9yNjQ0MWNiWUxnQUlmV1gzVm1hZllu?=
 =?utf-8?B?cVI5WTFsZ1V6VDdjSlFlZzU2Qitoa0xVU1ZDbWdESDAwVVlnYjJTeXlZLzAw?=
 =?utf-8?B?VUZycVZyQSsyenZTeG5RRWhLYTAvUjVVOVJXcjRHSWJpQm81d3kvZGgvYmlK?=
 =?utf-8?B?WVNCQVh2ck1oZldWUGt2SXcxemxlMEZ0aWFDYWVWckJjSnlreitkTm8vWENk?=
 =?utf-8?B?K0ZUb1JQQ2MreHlyeDBNZ2dlcE8yNXpRbzF6UzZRWGtoc1U1K0RWTWl3RStk?=
 =?utf-8?B?Z1cxcVR6MTZCU096b1Zwd1R0VnN5YlRyZDNSZkpGTFBjSTRybHp5VFBqRER6?=
 =?utf-8?B?Y0o4VG8zclhRaENveEdHSExnZnRFK3RmVUVkMEg4UjJBTUV4WmhpbDhsMFZj?=
 =?utf-8?B?SHI0VDJFNzN0KzFicGJVZStsUlNld29nTkdOd0drck9raW44OE1xdHR1TnQ5?=
 =?utf-8?B?Z2EyMnFiVCtTYXJkaGo5bjg0RldOWXZkM1NCSy9DM2g0S1hhTGZCU0YyUFFM?=
 =?utf-8?B?aXdwZHNXbXk0cmE5VDhSdnlDQWJuYnpMaDRFNEZNS1BiMzVrSGswOVhlaWdC?=
 =?utf-8?B?bDNkaVZnOXVWdURQYVJuQnVWaUdydmZuMEluMWpPY0R1cjQzZE52SVltb0ZG?=
 =?utf-8?B?ajdEd1g5emtDaXhJOWVKMjQ2UmNRYlE0Nm8wTXpDU1NqZVdlTHVXRmRQZ0NI?=
 =?utf-8?B?blVFZjVweStXSHNNM2xndk1YYVhER1B2MmdSdWh2R0EweThPa1hqLzkwbmJK?=
 =?utf-8?B?eUE5Q1FtY0oyazNQcUExdkVqQnhpWE11OTJnY051ZW9zVXE3bUY3cWlSSFR4?=
 =?utf-8?B?Vk9INkJqUG9hUnYxVHJYZVZzNnN5VVY4N0VUYVFOam8zTU5tUEZRcVJ0dW5F?=
 =?utf-8?B?ZVllN0N0c21WUjIxVEc0SUtlLzFmRDNiTU1lMWdYU0pQdUE3R2k1SVZZbjZ0?=
 =?utf-8?B?VGJsQ09lNTg1UTEwVEJhc3ZRTjg2U2VmeStDNXU0cE9VK2d5VThIOW1aS3pp?=
 =?utf-8?B?R3h0d0JDWkVBMFNXMkoxZmNEK3ZyZEJCL0libjFQWGx2ajhTTEVvNEFjN0dp?=
 =?utf-8?B?VER1U0Yycml0bkJSN0REejJNcFlnWmd0RHo2b1JIdEpiR3FxSjdHRnRIZWhG?=
 =?utf-8?B?Q2lQUmtxRXoyYVdTaWJsVnlxTDMySE1GVG8zNGZjWWtMSjhaaW1GTkQzV1N5?=
 =?utf-8?B?WmcySUdYZTJXYVA1RXZvekFnRWMxd2g3RW82c3NRcGVPMW1CWU03eXg2cG9H?=
 =?utf-8?B?aHUyOTBpeFVjR3d5QTQ5UThHcnFzZWdtc1oxQXBuZHdya1FxdUIyeFV4cUtK?=
 =?utf-8?B?ZDFyeG41K09HbHIrNWFVeUhnNzM1MVVJbENZTW9jZ0NjcHV6Ly9qUThjOHBl?=
 =?utf-8?B?RFUxajdib1pIckpTZXBSNzdmWmJoSFFUN2o4L0ErRWs3eXVzdHJ0NFZMWU5z?=
 =?utf-8?B?dlpJZXVKamZpWU9pZ0taM3cyUml1RHYveTAyd1RFeUdCZTVKbUxxSXVna0ww?=
 =?utf-8?B?T1RseUlZd2sreWRDeDlHQ1NGR05vcC9neHNCNHQ5dGk4M3VNSzEyTFVLN25j?=
 =?utf-8?B?MTZzRlIvemdkYU9nWEFzM3gxVzdvVE1MTVlyTVJPRkdScHJtZENwZ1lOOTRo?=
 =?utf-8?B?WllVblIweFhOZnNXQjh0STYrK08yZWN0YUdpUHp3eERNTW9kUTlkWUF0Y1J6?=
 =?utf-8?B?QUppSE5hZzBvVEtxWFdRaW5rN1lJcFp3VVlXZG5uN1RsRC9tcEF1ZzRxamJm?=
 =?utf-8?B?ZFN2bU5YNkJwTnhlQUFmRzhrZ2ZKWml0MlZYWGpsVmNEdzlSOEVLQTNrQ1or?=
 =?utf-8?B?YW9pb25QVUdaRkdmTDlqUT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH8PR11MB6879.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TlhCclpyZlc0WWJGSzIrMmVsZVgzTEVVM3JiV2xEb1g3V01OQVgyQkxuNVhO?=
 =?utf-8?B?aHhVdERHWm9kbGduYnZicjgrZWZUd2taazV4RExGcGNnSGhRRktqS1JLTVpS?=
 =?utf-8?B?ckdESEJlS1lRSkZCYitlMzAxQzhzU2RyNXZlRGl6em9YdVpPc0NqakdxWUdl?=
 =?utf-8?B?SW9tbVhqT3ZEOUZSN1F0aWVSYnE1ZjRrNWFESWdGQ1JGV2s2WnA4K0ZPdWFH?=
 =?utf-8?B?b1hQL0VENlJ0Wi9SZTJnR2JMeTV0NlZHa3RNbEppVTRXU1J5aFFnN2pKOUJi?=
 =?utf-8?B?eXJYRHd3cmZLR3NCMGdrZ2UwU1pqSjhBejF2QktDdVpKazg4bzc5UW1kSUdL?=
 =?utf-8?B?VWpQcUk5TnpFeHp6UlJMb1FENVJxa2xLdTdkbU1BT2RZYm8rNEJod0s3dzhw?=
 =?utf-8?B?eVJzYmxSVExFakRlUlNDanJ3Zno5QWppYm1VOXprdGJQcE9PbHd0UzJROTg4?=
 =?utf-8?B?ZStxT055TytwTDUzQzhmRFgrRHdmWE5RSS9oM1R4MllUOHJaZWtxeDlsV2FI?=
 =?utf-8?B?aDdleVAzbExJSmFnQTE0K3RNY1oveFRzbFlkenhOOTV6K2lhd3VpRmVUbVFR?=
 =?utf-8?B?K3Vta2F4UEN6RVoyRFY5WDduRVVvK0l4RDJIOC9XZkJQZXhwRHNKeHFxcVJy?=
 =?utf-8?B?LytadUh6UFNHcmhpbXFQcmVwRklPSkJnRG80ZVFHV1VwZkFFcGxPRk53YVZo?=
 =?utf-8?B?U09iY3NlVk1kV3N2ejNpREVNRUxKQjl4MXF0NU41ZjdacUJELzFLUzE5dWFB?=
 =?utf-8?B?blVUNlo5b0VXc2tQdUJQaWJEODdnMjAvaUF1Y29mR1JNMC9aQ1ZHSXM2aXVW?=
 =?utf-8?B?cGpDdjhodlI4cUttZ3dTd2wxWnZ2Q3F4REI0aHFhcDZBWkNXNFNRbC9CV3Bk?=
 =?utf-8?B?bXQzcUYrbUtVMkJLYzcrUjdKT1ViUnBPTi83OENveHNlaGNKanVTV1lwNzlO?=
 =?utf-8?B?SWIraTJwQnoyRmRaOG0yVjNGZkwvMHN4ZDN0ekxHakRIcW9ScDN0M2hCdC9C?=
 =?utf-8?B?MjZ6TkdhYWQzWW5aUXZ3b2lhK0hzWjV3Tk82OEo3OHpsWFlnMDBoZUZiMW5y?=
 =?utf-8?B?NHI2L05va2Q1VEU5L2FqVEo0YzF6Ymo3VXNwdW42WGRjbWhFYVdaNjVScXFq?=
 =?utf-8?B?cjJFYkJlSDk0VjBPMWtwbFh4N2U0YTAwUXVXelArMkx5TEg1SG1TNGVicGUr?=
 =?utf-8?B?U0ZONlpkVFMrYng4byszcmJERlZVWGVWQ2RwL0p4bndWQ0F1eUZOZTBqWitP?=
 =?utf-8?B?SUk1dFNKMWtjbkh3WVRvb3FSVFA1T3hkNHp2OHU1RUY2YnVnZ1dmNTRMSXZI?=
 =?utf-8?B?SXZsRytwVXpjSHdiUG45ZzNtZEdudmV2cmVkbGIvRG0yMzgxazhSOEJrdzd1?=
 =?utf-8?B?SFdkc3hJcEg3UTFEVjFKYzBKNFdmeUZJTXNEVlJkS2o4MmJrZGhpd1IxOHZx?=
 =?utf-8?B?TitRb24yanJmNXJ2cy9PN0h6UWcrQmJmNmlMZVpjcjdWVGkyaVBYQ3d4TFlN?=
 =?utf-8?B?MXplVWN5ak5kK2x0c0FLdjR5NytBbVlTWkVjNllIa1pDcHhLbDZhcDBlejR2?=
 =?utf-8?B?TzBuNTcwN1JaUUo3cVhFU2YwSk5SOTJ5cnR4YTJEeW9KMlFpZFE0QUd5Q1pl?=
 =?utf-8?B?VEZyWHZZekFHWE9PcjBvU3ZFdjhnMjdvTnZYS2hYcW5tRWRPVllqdzJISGpH?=
 =?utf-8?B?U0VPM3kzbHo1Z05TT2MwQ1lnbUN5R2R4MXlUdmprQ2xTYW93d1FRa3l1bjJF?=
 =?utf-8?B?eGIrcG13M2tkY0pBTUhnM1NIdTV1S2VBVkZXcktvcm5ITW1JZGZwd2UxZW56?=
 =?utf-8?B?cUtYSTZZbGw0dGNOaGVKU1cvWlN5WXFPeU5QaTVYZ056cDRETmhrMzM3YkQy?=
 =?utf-8?B?NEljYUMwWFZZSFJMSEEyVUQzcDRuQlR6RjBadG51NzZNbFk2aHNkNmc0RkJt?=
 =?utf-8?B?VWJSb08wN2FMTW1qeTBhMHBXRjRSeFM4ZG5BcjFwMWVSeVdES1VjeFNpd254?=
 =?utf-8?B?ZUNadG5GdjlMUnVSMStuR1pHSXkyUUJZdFEvMHpzdTdQL00zRzFkWFNpcUxp?=
 =?utf-8?B?dWJSV2poKzlvdmt5YkhSZDhLNXJ5QndkenEvRVl5Zkh6MldBcVgxZjM0R2p5?=
 =?utf-8?Q?u3/0Oq9lQdsgCVYUtD3TGvN2s?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c369db57-7ff4-4ceb-a0c6-08dc9ac28735
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6879.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2024 18:12:26.3914 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K05mRm6H9aY3Q7fIGhwqzg4tYvY2w45glMCLn70HuRTB80iNkEKhg8PknPEF8QdQW6gfOBJRbgda3irqxgwrQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4630
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.8; envelope-from=dongwon.kim@intel.com;
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

Hi Marc-André,

I will come up with a separate patch for this.

On 7/2/2024 1:32 AM, Marc-André Lureau wrote:
> Hi
> 
> On Fri, Jun 21, 2024 at 3:19 AM <dongwon.kim@intel.com 
> <mailto:dongwon.kim@intel.com>> wrote:
> 
>     From: Dongwon Kim <dongwon.kim@intel.com <mailto:dongwon.kim@intel.com>>
> 
>     There is no reason to split those two operations so combining
>     two functions - egl_dmabuf_create_sync and egl_dmabuf_create_fence.
> 
>     Cc: Gerd Hoffmann <kraxel@redhat.com <mailto:kraxel@redhat.com>>
>     Cc: Marc-André Lureau <marcandre.lureau@redhat.com
>     <mailto:marcandre.lureau@redhat.com>>
>     Cc: Vivek Kasireddy <vivek.kasireddy@intel.com
>     <mailto:vivek.kasireddy@intel.com>>
>     Signed-off-by: Dongwon Kim <dongwon.kim@intel.com
>     <mailto:dongwon.kim@intel.com>>
> 
> 
> Can you send this change as a different patch series, or earlier in the 
> series?
> 
> You should also remove qemu_dmabuf_{set,get}_sync() and associated fields
> 
>     ---
>       include/ui/egl-helpers.h |  3 +--
>       ui/egl-helpers.c         | 27 +++++++++++----------------
>       ui/gtk-egl.c             | 19 +++++++------------
>       ui/gtk-gl-area.c         | 10 ++--------
>       4 files changed, 21 insertions(+), 38 deletions(-)
> 
>     diff --git a/include/ui/egl-helpers.h b/include/ui/egl-helpers.h
>     index 4b8c0d2281..606d6c8288 100644
>     --- a/include/ui/egl-helpers.h
>     +++ b/include/ui/egl-helpers.h
>     @@ -51,8 +51,7 @@ int egl_get_fd_for_texture(uint32_t tex_id, EGLint
>     *stride, EGLint *fourcc,
> 
>       void egl_dmabuf_import_texture(QemuDmaBuf *dmabuf);
>       void egl_dmabuf_release_texture(QemuDmaBuf *dmabuf);
>     -void egl_dmabuf_create_sync(QemuDmaBuf *dmabuf);
>     -void egl_dmabuf_create_fence(QemuDmaBuf *dmabuf);
>     +int egl_dmabuf_create_fence(QemuDmaBuf *dmabuf);
> 
>       #endif
> 
>     diff --git a/ui/egl-helpers.c b/ui/egl-helpers.c
>     index 99b2ebbe23..e16f2cb23d 100644
>     --- a/ui/egl-helpers.c
>     +++ b/ui/egl-helpers.c
>     @@ -371,34 +371,29 @@ void egl_dmabuf_release_texture(QemuDmaBuf
>     *dmabuf)
>           qemu_dmabuf_set_texture(dmabuf, 0);
>       }
> 
>     -void egl_dmabuf_create_sync(QemuDmaBuf *dmabuf)
>     +int egl_dmabuf_create_fence(QemuDmaBuf *dmabuf)
>       {
>           EGLSyncKHR sync;
>     +    int fence_fd = -1;
> 
>           if (epoxy_has_egl_extension(qemu_egl_display,
>                                       "EGL_KHR_fence_sync") &&
>               epoxy_has_egl_extension(qemu_egl_display,
>     -                                "EGL_ANDROID_native_fence_sync")) {
>     +                                "EGL_ANDROID_native_fence_sync") &&
>     +        qemu_dmabuf_get_fence_fd(dmabuf) == -1) {
>               sync = eglCreateSyncKHR(qemu_egl_display,
>                                       EGL_SYNC_NATIVE_FENCE_ANDROID, NULL);
>               if (sync != EGL_NO_SYNC_KHR) {
>     -            qemu_dmabuf_set_sync(dmabuf, sync);
>     +            fence_fd = eglDupNativeFenceFDANDROID(qemu_egl_display,
>     +                                                  sync);
>     +            if (fence_fd >= 0) {
>     +                qemu_dmabuf_set_fence_fd(dmabuf, fence_fd);
>     +            }
>     +            eglDestroySyncKHR(qemu_egl_display, sync);
>               }
>           }
>     -}
>     -
>     -void egl_dmabuf_create_fence(QemuDmaBuf *dmabuf)
>     -{
>     -    void *sync = qemu_dmabuf_get_sync(dmabuf);
>     -    int fence_fd;
> 
>     -    if (sync) {
>     -        fence_fd = eglDupNativeFenceFDANDROID(qemu_egl_display,
>     -                                              sync);
>     -        qemu_dmabuf_set_fence_fd(dmabuf, fence_fd);
>     -        eglDestroySyncKHR(qemu_egl_display, sync);
>     -        qemu_dmabuf_set_sync(dmabuf, NULL);
>     -    }
>     +    return fence_fd;
> 
> 
> It should probably return qemu_dmabuf_get_fence_fd() instead. The 
> function should be renamed with _fd postfix since you make it return the fd.
> 
>       }
> 
>       #endif /* CONFIG_GBM */
>     diff --git a/ui/gtk-egl.c b/ui/gtk-egl.c
>     index 9831c10e1b..55199f8659 100644
>     --- a/ui/gtk-egl.c
>     +++ b/ui/gtk-egl.c
>     @@ -68,7 +68,6 @@ void gd_egl_draw(VirtualConsole *vc)
>           GdkWindow *window;
>       #ifdef CONFIG_GBM
>           QemuDmaBuf *dmabuf = vc->gfx.guest_fb.dmabuf;
>     -    int fence_fd;
>       #endif
>           int ww, wh, ws;
> 
>     @@ -99,13 +98,12 @@ void gd_egl_draw(VirtualConsole *vc)
>               glFlush();
>       #ifdef CONFIG_GBM
>               if (dmabuf) {
>     -            egl_dmabuf_create_fence(dmabuf);
>     -            fence_fd = qemu_dmabuf_get_fence_fd(dmabuf);
>     +            fence_fd = egl_dmabuf_create_fence(dmabuf);
>                   if (fence_fd >= 0) {
>                       qemu_set_fd_handler(fence_fd, gd_hw_gl_flushed,
>     NULL, vc);
>     -                return;
>     +            } else {
>     +                graphic_hw_gl_block(vc->gfx.dcl.con, false);
>                   }
>     -            graphic_hw_gl_block(vc->gfx.dcl.con, false);
>               }
>       #endif
>           } else {
>     @@ -336,7 +334,11 @@ void gd_egl_scanout_flush(DisplayChangeListener
>     *dcl,
>       {
>           VirtualConsole *vc = container_of(dcl, VirtualConsole, gfx.dcl);
>           GdkWindow *window;
>     +#ifdef CONFIG_GBM
>     +    QemuDmaBuf *dmabuf = vc->gfx.guest_fb.dmabuf;
>     +#endif
>           int ww, wh, ws;
>     +    int fence_fd;
> 
>           if (!vc->gfx.scanout_mode) {
>               return;
>     @@ -364,12 +366,6 @@ void gd_egl_scanout_flush(DisplayChangeListener
>     *dcl,
>               egl_fb_blit(&vc->gfx.win_fb, &vc->gfx.guest_fb,
>     !vc->gfx.y0_top);
>           }
> 
>     -#ifdef CONFIG_GBM
>     -    if (vc->gfx.guest_fb.dmabuf) {
>     -        egl_dmabuf_create_sync(vc->gfx.guest_fb.dmabuf);
>     -    }
>     -#endif
>     -
>           eglSwapBuffers(qemu_egl_display, vc->gfx.esurface);
>       }
> 
>     @@ -387,7 +383,6 @@ void gd_egl_flush(DisplayChangeListener *dcl,
>               gtk_widget_queue_draw_area(area, x, y, w, h);
>               return;
>           }
>     -
>           gd_egl_scanout_flush(&vc->gfx.dcl, x, y, w, h);
>       }
> 
>     diff --git a/ui/gtk-gl-area.c b/ui/gtk-gl-area.c
>     index b628b35451..0b11423824 100644
>     --- a/ui/gtk-gl-area.c
>     +++ b/ui/gtk-gl-area.c
>     @@ -77,17 +77,10 @@ void gd_gl_area_draw(VirtualConsole *vc)
>               glBlitFramebuffer(0, y1, vc->gfx.w, y2,
>                                 0, 0, ww, wh,
>                                 GL_COLOR_BUFFER_BIT, GL_NEAREST);
>     -#ifdef CONFIG_GBM
>     -        if (dmabuf) {
>     -            egl_dmabuf_create_sync(dmabuf);
>     -        }
>     -#endif
>     -        glFlush();
>       #ifdef CONFIG_GBM
>               if (dmabuf) {
>                   int fence_fd;
>     -            egl_dmabuf_create_fence(dmabuf);
>     -            fence_fd = qemu_dmabuf_get_fence_fd(dmabuf);
>     +            fence_fd = egl_dmabuf_create_fence(dmabuf);
>                   if (fence_fd >= 0) {
>                       qemu_set_fd_handler(fence_fd, gd_hw_gl_flushed,
>     NULL, vc);
>                       return;
>     @@ -95,6 +88,7 @@ void gd_gl_area_draw(VirtualConsole *vc)
>                   graphic_hw_gl_block(vc->gfx.dcl.con, false);
>               }
>       #endif
>     +        glFlush();
>           } else {
>               if (!vc->gfx.ds) {
>                   return;
>     -- 
>     2.34.1
> 
> 
> 
> 
> -- 
> Marc-André Lureau


