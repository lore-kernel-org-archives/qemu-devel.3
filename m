Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32280D3C544
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2024 02:49:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1d2s-0005S6-PJ; Thu, 17 Oct 2024 22:48:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chen.zhang@intel.com>)
 id 1t1d2q-0005Rp-TN; Thu, 17 Oct 2024 22:48:53 -0400
Received: from mgamail.intel.com ([198.175.65.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chen.zhang@intel.com>)
 id 1t1d2n-0007oL-Ua; Thu, 17 Oct 2024 22:48:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1729219730; x=1760755730;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:mime-version;
 bh=1TwT6YUCcpjp+IcaV663Sv97hcper0wVxJOyNWkH04k=;
 b=gd33YQ96CzI7X5qQvPqEmABF2PnVRKaGTKo9jqwvAMEfLL2NBnjf59sz
 JEX4MQHDNJp8Qok5ooy1V+94wSYR6rrfalOa7tD1BBlHrPRc7GZovf6Fc
 sLNA8PQ7/9v2ZzXSVsKiCQDs6JzPDS7xjy6uIlQwAIp7oJJiDrAJZReBb
 aLxXk+1ZgrJDzt0r89NKDDPjcn3bKnbvrHbqVu6C8aXcqRHJMDerGvYal
 mgXmHxyvMl6cdV26v6aQHbPnLUIe5+nogU4cHWNeqEHkpDyJdML+m+z0u
 uB4fFcoxILFGI8z5VAQchKQAo0Ab/OZhUcWTlLPtO8e1UxyLiB/H5Zk7g Q==;
X-CSE-ConnectionGUID: liH7uXGYR3OApY2Nji4EnA==
X-CSE-MsgGUID: 2XSCzl31RYq099Yc6uS+rg==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="28835617"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; d="scan'208,217";a="28835617"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Oct 2024 19:48:43 -0700
X-CSE-ConnectionGUID: 8zByuCU/SQOYb9sru7P7zQ==
X-CSE-MsgGUID: YPiImjUfQHuorc/f6ld/ig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,212,1725346800"; d="scan'208,217";a="83511666"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
 by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 17 Oct 2024 19:48:43 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 17 Oct 2024 19:48:42 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 17 Oct 2024 19:48:41 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 17 Oct 2024 19:48:41 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.45) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 17 Oct 2024 19:48:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bvkVPqw0dWW5DqXo1QTYIJzYQGGQVOAg7WCJLg//r+HQ762Z0ULqSnFzKKgLobc+/L+d3PAx8VePajEV2a8pwpYuFuP4XAomCcv+ZPtAWsRWNu1opq2FHi8CRuC0ACW4IGIHthoRMneaPzds3Lu0GbIotfy9blJugJ3DHzIUtV00IfG4P0N/rsQh79q9GiugaMl38G0Qoh++Gq3LhO9kY1rhZig/R3nCyCtwqwxedUQmpv6gjbug+oVkZ87ZXMIRMIVIymZxoBeF1rJ3eo+i4Rzfz96zCILZA9WlanrQuPp2dyHh7J+L0WqPNbPZsQQWbV0yMdGxu8XBRsX9ht8OCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1TwT6YUCcpjp+IcaV663Sv97hcper0wVxJOyNWkH04k=;
 b=pn26RzPRh4Dz0Zomw94jhP+x5w9FwojmfbknEhb2xo0A8kftydJ1YE4Rc8TqjnayBT7Ya85w9VpWNWsLg9CNjBqHnSnaFvoHEGFu3fqycMryuLUqc9gLsEevPj1Y63YnjaW1wpkFRrHUJCXQ30XQ0vpnNMmMFBcWX/2U3x4+ptiiK4p4CIhN2MlsroCS/3JPHAIX4KeA9LEU6+PUG22E7PNllTeSX4mI8sN9ZCH/zeu0gEiuqoDqxm+b4kl80sNE8dqecDEz8b45O2lm4YppJXkZGcckrIoNSZilChIEVH4zxfqL2JMry1TS1iV6B1VpvI0kqtOf56GnQOFtmujaeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CYYPR11MB8432.namprd11.prod.outlook.com (2603:10b6:930:be::8)
 by IA1PR11MB6122.namprd11.prod.outlook.com (2603:10b6:208:3ee::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.17; Fri, 18 Oct
 2024 02:48:39 +0000
Received: from CYYPR11MB8432.namprd11.prod.outlook.com
 ([fe80::5c9c:bb71:47cb:f4f9]) by CYYPR11MB8432.namprd11.prod.outlook.com
 ([fe80::5c9c:bb71:47cb:f4f9%5]) with mapi id 15.20.8048.017; Fri, 18 Oct 2024
 02:48:39 +0000
From: "Zhang, Chen" <chen.zhang@intel.com>
To: Stefan Weil <sw@weilnetz.de>, Li Zhijian <lizhijian@fujitsu.com>, "Jason
 Wang" <jasowang@redhat.com>, qemu-stable <qemu-stable@nongnu.org>, "QEMU
 Trivial" <qemu-trivial@nongnu.org>, Michael Tokarev <mjt@tls.msk.ru>,
 "Laurent Vivier" <laurent@vivier.eu>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: RE: [PATCH] Fix calculation of minimum in colo_compare_tcp
Thread-Topic: [PATCH] Fix calculation of minimum in colo_compare_tcp
Thread-Index: AQHbAvjmQaDInInX9UClxjrotKzWGLJQTpAAgDtFRwCAAHHasA==
Date: Fri, 18 Oct 2024 02:48:39 +0000
Message-ID: <CYYPR11MB8432723FB4A5A76E3ABB02699B402@CYYPR11MB8432.namprd11.prod.outlook.com>
References: <20240909204254.1446800-1-sw@weilnetz.de>
 <CYYPR11MB8432028036D306D2FB6F4A359B9A2@CYYPR11MB8432.namprd11.prod.outlook.com>
 <bc8991ef-91af-419c-beda-f0ece8eda019@weilnetz.de>
In-Reply-To: <bc8991ef-91af-419c-beda-f0ece8eda019@weilnetz.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CYYPR11MB8432:EE_|IA1PR11MB6122:EE_
x-ms-office365-filtering-correlation-id: ac614433-e9e9-4518-5de2-08dcef1f5ef1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|38070700018|8096899003; 
x-microsoft-antispam-message-info: =?utf-8?B?c1hyU3pCd2pCT0hnRXJMUElxcEhzeFBGR0xQYnpIM0g1RUJKQVVNMUFjMWVD?=
 =?utf-8?B?S0JycjJLeXN1UDdUKzJvNG5kVEtHU0JYLzFpeUlJNjdrQ1Ria3h6TW1HbkVZ?=
 =?utf-8?B?T3ZnSjYvSERkeG5KS2tPOWMrTGlray9RZmZZMnpLUWZIOVVJQlA4M0gxZUhj?=
 =?utf-8?B?ckdnbWZXOEF6YUhMUEM1SUR5NElWc2pLcGg5UzAzUXE1Tk5CMTRTeTJSNitW?=
 =?utf-8?B?aDBrN0VQcHVpV2hWQW45VzlwUXhNdXNrN2JTU2xMSVlwbTBkTXRBbm9Vc0FH?=
 =?utf-8?B?eE1FVHhwbTBnckFlaXlYekd5SGI1Uzd5MEZGd1dNTEYxcThTdzhyQXBYT3Y5?=
 =?utf-8?B?MVFzRjlWWlBoNitobHRWYXpIKzlOZjZUVHBJRm5ka2dVUDdCbCtqc3I2aHQ5?=
 =?utf-8?B?YTFMclc4eFpkbHordTcwRjA5MWlZdEUvakl2K1RPZ2xzdFFuNUhJcW5EY1gz?=
 =?utf-8?B?YWNpa3pVd0tyMFBFUlJURUNQNmloTExVYkg0cEY3S1YzbnAwblN1NEE3TmJR?=
 =?utf-8?B?cmgvTk5QZGhxMk1mdDQ3Q01Edm5EWVBPZzVJcHU1anhBa3RyZ0hDUXNHVFVD?=
 =?utf-8?B?dHY4bXoxenRnUGd6S01kb2ZOZFBHWDJDRGd6ekUyL1ZBaG40R2tnVVRlb0V5?=
 =?utf-8?B?T1E4TG5LK1ExWU92YVkxTjhOOTNmQnRmZzZTcTRVTk9TWGpKRWYzNGpaTkdt?=
 =?utf-8?B?a1cwaWhsYXBKanhlbUZyR1hVSEhPazNhUWd1NWVPcUxES1NXUjl1ZmppTFlZ?=
 =?utf-8?B?VHUyeWJQc1ZFUm9RL1AzQUhTTXFic1VrTGlMVUY1Nzk2VGErRXFpdm41VWEr?=
 =?utf-8?B?QUV2M2g0Y2daR0FROWRobkVpK2hiS21WeDZZc0gzaHlhM2UyNU0rTTY1VWUr?=
 =?utf-8?B?QkF2THJsdEVSY081Y1ozZEQ2eGpSVmF2UHdCWFJVTXp5QlovY0xCN2l3ZUhu?=
 =?utf-8?B?d3NDM3BKR2E5L2FneFlUWXMwbUpSbVdFTU5TeXNxSnJZempmRjVzRmNTUUtY?=
 =?utf-8?B?VUV6VjdmQUlIdEM4eFBLdkdWMnMzSFZqNUpoVmpycjFXRnVHM2RKMktYMVpL?=
 =?utf-8?B?Tm9Yemp4c0Z4anpJdDZ3Y2d1TjI4eXVWMWFQSU4yTWNpOGVzRTRXZ0F3YlAy?=
 =?utf-8?B?dyt2TmhYbjRpTG9oRU1CVUw5SWt6ZUVMYjFkdmhsYzA5UVdCRDliU2swVFZY?=
 =?utf-8?B?b1o3VEFEb3dWUlJCTUVDSEhtTnRtZUV0elIwNFFXT00yUzNtUm1CaTU1cWV5?=
 =?utf-8?B?SEFMVzV6ZGlvSHlWZ3o2bmptdzkwYjgwTWdtM1FhaFJaUjdpS1QxRzNnd2pB?=
 =?utf-8?B?S1RMU3Z2MVdWS0Z3M3ptVXVVcE1lTkdlRDZiUno1SkYwdWFHaFIxTTJjM1pp?=
 =?utf-8?B?Z2FSQUNYZjRiVFErVEI3WWRoU0FiS0tZUXYrL1pOYmRhcHlaRkZIazlNOGJP?=
 =?utf-8?B?blhpYkQvK3V3WSt5YTlScHhXbjExRE12Qld6ZWppMDVTTnFjYTVjbm8wVlZx?=
 =?utf-8?B?dVArT1EwV2NGdm5uaHhKQzdqN1ZBTE0yMkovTFNHMXpaYnBGMVl4THZQWjB2?=
 =?utf-8?B?cG1Ed1NTUTArcmUrSCtGdHVQQzRRUFF1cklLdmc4M1pRZ2FSTmJ3b0RzVzE1?=
 =?utf-8?B?eHhvNmdYWWdidDFnMFVpL01tY3A5U09tQ0xXazRYczdQUVZ1T2dScTYrY2gw?=
 =?utf-8?B?WVVvN3FsOWRDZHhJV1loYitCV3ZBVXZldDFZUWptSUtGZ3NJakhwdENCMHNs?=
 =?utf-8?B?QlZvMFI2Z2NuaDNxNDh3S3hqZUdTeUV6djNFcFVKZlFYOGdqem9yUklBVnRy?=
 =?utf-8?Q?1+1r3pUNMp8Y/2PFRfYxli9i+AZQgaglM8lVA=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CYYPR11MB8432.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018)(8096899003); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TDZZV01vNW5YcmlHeU5McE1SZHR0a1lhNzBFNFd0U2RmVDRYaVMwMkc3OHhF?=
 =?utf-8?B?OWdLV1pKSVhncm5yUW5TOHByUG8vY1VPR2RiVnhCaGtkd3N6ZkMrTlczR2lI?=
 =?utf-8?B?U3RWK1lucDVkMGV5cnkzdnl6VlFDZTFEbzBBY2VEYU5VejZmd1FXdDJ4RU5E?=
 =?utf-8?B?dWR2SS9mTEVXT3ZUNGpiZHllTDd6Q2l0bUg2cURRQi9PdEJMSUdmUEJpZFY4?=
 =?utf-8?B?Qy92RzIyRnBpV3E1ZDRUeVR4NHgwemVpNjdFSTBucm1JT3VRMktPcnE0Y1lv?=
 =?utf-8?B?VC85ZHZjYTJkTHZVd29EV0ZKb0RNQmJwT0JmL0VlL3BrT3VzL0d5ZUVzMTk2?=
 =?utf-8?B?Mm5aT0poTXhpMnVMYWd4UTJYNUNJR1NuVDNiR1lWSWJaR091b3ZIZFhYUWRB?=
 =?utf-8?B?dHREYVpZT1VrMEdWNnB3UExUZmIrZFFxWStmdHZVNHNXM3lISHdsVUZ0bmFx?=
 =?utf-8?B?OUNNWHJVMTBTc2xjdllzOVM3d3ZvcGJEZDB1THQ3Z081bHN2MmF0S1h0OGsw?=
 =?utf-8?B?cUtSQTYvcFc1cDJQeFEvM3RGMGIvVEtvV1RRNkJ1N0t6QWxJZDMrSEZwYUpy?=
 =?utf-8?B?M1N3NXpOSm5YSlNvYkVadjVrVEVPV3dDTzZzV0pRT3RCd3kzTWxaZFdsdHBh?=
 =?utf-8?B?RDlpWGdFeEFZU3JkTU9mYUtzWkNyYnZSdXhvdko1QWY0cEZzWU5oeXNNdkF0?=
 =?utf-8?B?dUhDVGFhWnR2eHJMVEdIQVI2cnFYQzdremJGbWZJbGJnRmszWmF4YTBxeTYr?=
 =?utf-8?B?SXNMTHlJeGZkcE0yMVZNSExJUkRmZzIzaTM0V2ZXMFk1bm5Nb2tKNUtpUFhF?=
 =?utf-8?B?bGpKaVZyUXZ4cWdIT2pXcVdWQTdtUm95Rnd4RVZzdW85UGNvQnpNaWlYMEJh?=
 =?utf-8?B?N3VZblpnYmRFVU13L0IwQzFlN3l2T09UZkJOSVR6dHk2d0R0UHd5cXlybXgy?=
 =?utf-8?B?SHRXOVFzUzlNa0ZybTFyb2pveTF1Z1ZnRFRnQUczVFhXNzJyQVpISWovcnRK?=
 =?utf-8?B?S1BtOVU1ektHRTExdGsySVkxUDVwU0plelJGTWFVamg4dG15U0NBMldwMGVu?=
 =?utf-8?B?REJtSmNVbmhXa2VUbU1TSXMzSVJZYkxaRHlkOWl2UW5Za1NMZ2xhT3BaQmN2?=
 =?utf-8?B?WUIvVUhYK1NWMStITURwd1dzNVNpVVhOSzNGdUY1L056L2xMSGpPdnhiRlJl?=
 =?utf-8?B?OExhVzZoL3dZVlBKS040cDh6TlRjTEg0N2pqOVM0dzZlZXdvamxta2g3RHZh?=
 =?utf-8?B?QzhEYVUzQ3FwNnJMd2dvT1psNzhycmhWNHQ3VG1KZmwwR2FQd1dkNXNpQlBt?=
 =?utf-8?B?c1hwTGRGRFkzS2F6MFVpamVKeHhsWmlMVHpsaEFiMGJ6eTRoQzZEVmlrZE5U?=
 =?utf-8?B?cG1zeFBCTC9QU1BEcjJvSXNwckZqVnE2NkdXWmRQM25INVJTcEs5eUdWYzVE?=
 =?utf-8?B?VGdoOU5HcGxCN0oyV3B0aE45NlUxZ0lvSW5uYmx0NklURkkrcURIRGZTWTFS?=
 =?utf-8?B?Vnc3eXl5dU0yS1ZuZFExUDdEVGx6YzcyQ21nS0VTV1VVZmsvdTVvYUw4NWdj?=
 =?utf-8?B?T2FHWktWR2cyN09YTThRWHJKbXlOelhEb0Z2UXNjWlpwTWkzUXI2SU1FTFJt?=
 =?utf-8?B?cDRXM1FXdkhuNHlHL2REeWhyRXZGd2ZoMWFwZGJaK1RvdnpSK0x2Y1RMUFI3?=
 =?utf-8?B?YUprdkNCdjRaU3pPR1R4RGFSbWRkbUxQZ1V2akgwWm1YbFRrZUhxazRIUi9N?=
 =?utf-8?B?NGh5SVZHR05KTlM5Smo1TDVDVG1qNXVqbnR6R2RnamtaL0x4MXZlblNuK0Rr?=
 =?utf-8?B?SGo3cjVDY0NRSnMwNDdrVWxPZm9jODRpai9CREhtbXNMUGEwakw5ZUJUZkxN?=
 =?utf-8?B?ZGRBOHhUVFZ1dCtVSlFSYm9LV1Y4bHBJNnNwaitQd2J5UlFPUnpSeXZ1Qzdi?=
 =?utf-8?B?NEpkQ1NkU1hmVWpkaEkzbjhtdWNKUmlxUGxjdU1NVnMvNlhwSUdVTWU4S0Ru?=
 =?utf-8?B?dXNSaUlXc3ZsU0tET01qL0Z0eDZocWE1WHZaQkcvRWFUU0hXaHQrWHhxSC95?=
 =?utf-8?B?cWNPS0dkUzJsK0d6Q0VGK1BRNmRkVDdLejc2eG9GVEJxV3p6d3V4eE5adytt?=
 =?utf-8?Q?0RRUoOx6N8Z8+QQb5frrQGgEZ?=
Content-Type: multipart/alternative;
 boundary="_000_CYYPR11MB8432723FB4A5A76E3ABB02699B402CYYPR11MB8432namp_"
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CYYPR11MB8432.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac614433-e9e9-4518-5de2-08dcef1f5ef1
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Oct 2024 02:48:39.5130 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dW3Mr2eM+2cPMbi1lu7B1ZROriHEf86Xh+hYZ31/69NIC+1O5yfVg24YxUMXpdeJ9+LmWwnTLw4YxiaU/pZTZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6122
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.16; envelope-from=chen.zhang@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.068,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

--_000_CYYPR11MB8432723FB4A5A76E3ABB02699B402CYYPR11MB8432namp_
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

QWRkIFRyaXZpYWwgcGF0Y2hlcyBNYWludGFpbmVycy4NCg0KSGkgSmFzb24vTWljaGFlbC9MYXVy
ZW50LA0KQ2FuIHlvdSBoZWxwIHRvIHBpY2sgdXAgdGhpcyBwYXRjaCBmb3IgdXBzdHJlYW0gYW5k
IHN0YWJsZT8NCg0KVGhhbmtzDQpDaGVuDQoNCkZyb206IFN0ZWZhbiBXZWlsIDxzd0B3ZWlsbmV0
ei5kZT4NClNlbnQ6IEZyaWRheSwgT2N0b2JlciAxOCwgMjAyNCAzOjQ0IEFNDQpUbzogWmhhbmcs
IENoZW4gPGNoZW4uemhhbmdAaW50ZWwuY29tPjsgTGkgWmhpamlhbiA8bGl6aGlqaWFuQGZ1aml0
c3UuY29tPjsgSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT47IHFlbXUtc3RhYmxlIDxx
ZW11LXN0YWJsZUBub25nbnUub3JnPjsgUUVNVSBUcml2aWFsIDxxZW11LXRyaXZpYWxAbm9uZ251
Lm9yZz4NCkNjOiBxZW11LWRldmVsQG5vbmdudS5vcmcNClN1YmplY3Q6IFJlOiBbUEFUQ0hdIEZp
eCBjYWxjdWxhdGlvbiBvZiBtaW5pbXVtIGluIGNvbG9fY29tcGFyZV90Y3ANCg0KDQpJdCBsb29r
cyBsaWtlIG5vYm9keSBoYXMgc2VudCBhIHB1bGwgcmVxdWVzdCBmb3IgdGhpcyBmaXggdXAgdG8g
bm93LiBJcyBpdCB0cml2aWFsIGVub3VnaCBmb3IgcWVtdS10cml2aWFsPyBBbmQgbWF5YmUgcWVt
dS1zdGFibGUgY291bGQgYWxzbyBhcHBseSBpdCB0byBvbGRlciB2ZXJzaW9ucy4NCg0KU3RlZmFu
IFcuDQpBbSAxMC4wOS4yNCB1bSAwNDozOCBzY2hyaWViIFpoYW5nLCBDaGVuOg0KDQotLS0tLU9y
aWdpbmFsIE1lc3NhZ2UtLS0tLQ0KDQpGcm9tOiBTdGVmYW4gV2VpbCA8c3dAd2VpbG5ldHouZGU+
PG1haWx0bzpzd0B3ZWlsbmV0ei5kZT4NCg0KU2VudDogVHVlc2RheSwgU2VwdGVtYmVyIDEwLCAy
MDI0IDQ6NDMgQU0NCg0KVG86IFpoYW5nLCBDaGVuIDxjaGVuLnpoYW5nQGludGVsLmNvbT48bWFp
bHRvOmNoZW4uemhhbmdAaW50ZWwuY29tPjsgTGkgWmhpamlhbiA8bGl6aGlqaWFuQGZ1aml0c3Uu
Y29tPjxtYWlsdG86bGl6aGlqaWFuQGZ1aml0c3UuY29tPjsNCg0KSmFzb24gV2FuZyA8amFzb3dh
bmdAcmVkaGF0LmNvbT48bWFpbHRvOmphc293YW5nQHJlZGhhdC5jb20+DQoNCkNjOiBxZW11LWRl
dmVsQG5vbmdudS5vcmc8bWFpbHRvOnFlbXUtZGV2ZWxAbm9uZ251Lm9yZz47IFN0ZWZhbiBXZWls
IDxzd0B3ZWlsbmV0ei5kZT48bWFpbHRvOnN3QHdlaWxuZXR6LmRlPg0KDQpTdWJqZWN0OiBbUEFU
Q0hdIEZpeCBjYWxjdWxhdGlvbiBvZiBtaW5pbXVtIGluIGNvbG9fY29tcGFyZV90Y3ANCg0KDQoN
CkdpdEh1YidzIENvZGVRTCByZXBvcnRzIGEgY3JpdGljYWwgZXJyb3Igd2hpY2ggaXMgZml4ZWQg
YnkgdXNpbmcgdGhlIE1JTg0KDQptYWNybzoNCg0KDQoNCiAgICBVbnNpZ25lZCBkaWZmZXJlbmNl
IGV4cHJlc3Npb24gY29tcGFyZWQgdG8gemVybw0KDQoNCg0KU2lnbmVkLW9mZi1ieTogU3RlZmFu
IFdlaWwgPHN3QHdlaWxuZXR6LmRlPjxtYWlsdG86c3dAd2VpbG5ldHouZGU+DQoNCg0KDQpMb29r
cyBnb29kIHRvIG1lLg0KDQpSZXZpZXdlZC1ieTogWmhhbmcgQ2hlbiA8Y2hlbi56aGFuZ0BpbnRl
bC5jb20+PG1haWx0bzpjaGVuLnpoYW5nQGludGVsLmNvbT4NCg0KDQoNClRoYW5rcw0KDQpDaGVu
DQoNCg0KDQotLS0NCg0KIG5ldC9jb2xvLWNvbXBhcmUuYyB8IDMgKy0tDQoNCiAxIGZpbGUgY2hh
bmdlZCwgMSBpbnNlcnRpb24oKyksIDIgZGVsZXRpb25zKC0pDQoNCg0KDQpkaWZmIC0tZ2l0IGEv
bmV0L2NvbG8tY29tcGFyZS5jIGIvbmV0L2NvbG8tY29tcGFyZS5jIGluZGV4DQoNCmM0YWQwYWI3
MWYuLjM5ZjkwYzQwNjUgMTAwNjQ0DQoNCi0tLSBhL25ldC9jb2xvLWNvbXBhcmUuYw0KDQorKysg
Yi9uZXQvY29sby1jb21wYXJlLmMNCg0KQEAgLTQxMiw4ICs0MTIsNyBAQCBzdGF0aWMgdm9pZCBj
b2xvX2NvbXBhcmVfdGNwKENvbXBhcmVTdGF0ZSAqcywNCg0KQ29ubmVjdGlvbiAqY29ubikNCg0K
ICAgICAgKiBjYW4gZW5zdXJlIHRoYXQgdGhlIHBhY2tldCdzIHBheWxvYWQgaXMgYWNrbm93bGVk
Z2VkIGJ5DQoNCiAgICAgICogcHJpbWFyeSBhbmQgc2Vjb25kYXJ5Lg0KDQogICAgICovDQoNCi0g
ICAgdWludDMyX3QgbWluX2FjayA9IGNvbm4tPnBhY2sgLSBjb25uLT5zYWNrID4gMCA/DQoNCi0g
ICAgICAgICAgICAgICAgICAgICAgIGNvbm4tPnNhY2sgOiBjb25uLT5wYWNrOw0KDQorICAgIHVp
bnQzMl90IG1pbl9hY2sgPSBNSU4oY29ubi0+cGFjaywgY29ubi0+c2Fjayk7DQoNCg0KDQogcHJp
Og0KDQogICAgIGlmIChnX3F1ZXVlX2lzX2VtcHR5KCZjb25uLT5wcmltYXJ5X2xpc3QpKSB7DQoN
Ci0tDQoNCjIuMzkuMyAoQXBwbGUgR2l0LTE0NikNCg==

--_000_CYYPR11MB8432723FB4A5A76E3ABB02699B402CYYPR11MB8432namp_
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: base64

PGh0bWwgeG1sbnM6dj0idXJuOnNjaGVtYXMtbWljcm9zb2Z0LWNvbTp2bWwiIHhtbG5zOm89InVy
bjpzY2hlbWFzLW1pY3Jvc29mdC1jb206b2ZmaWNlOm9mZmljZSIgeG1sbnM6dz0idXJuOnNjaGVt
YXMtbWljcm9zb2Z0LWNvbTpvZmZpY2U6d29yZCIgeG1sbnM6bT0iaHR0cDovL3NjaGVtYXMubWlj
cm9zb2Z0LmNvbS9vZmZpY2UvMjAwNC8xMi9vbW1sIiB4bWxucz0iaHR0cDovL3d3dy53My5vcmcv
VFIvUkVDLWh0bWw0MCI+DQo8aGVhZD4NCjxtZXRhIGh0dHAtZXF1aXY9IkNvbnRlbnQtVHlwZSIg
Y29udGVudD0idGV4dC9odG1sOyBjaGFyc2V0PXV0Zi04Ij4NCjxtZXRhIG5hbWU9IkdlbmVyYXRv
ciIgY29udGVudD0iTWljcm9zb2Z0IFdvcmQgMTUgKGZpbHRlcmVkIG1lZGl1bSkiPg0KPHN0eWxl
PjwhLS0NCi8qIEZvbnQgRGVmaW5pdGlvbnMgKi8NCkBmb250LWZhY2UNCgl7Zm9udC1mYW1pbHk6
IkNhbWJyaWEgTWF0aCI7DQoJcGFub3NlLTE6MiA0IDUgMyA1IDQgNiAzIDIgNDt9DQpAZm9udC1m
YWNlDQoJe2ZvbnQtZmFtaWx5OkRlbmdYaWFuOw0KCXBhbm9zZS0xOjIgMSA2IDAgMyAxIDEgMSAx
IDE7fQ0KQGZvbnQtZmFjZQ0KCXtmb250LWZhbWlseTpDYWxpYnJpOw0KCXBhbm9zZS0xOjIgMTUg
NSAyIDIgMiA0IDMgMiA0O30NCkBmb250LWZhY2UNCgl7Zm9udC1mYW1pbHk6QXB0b3M7fQ0KQGZv
bnQtZmFjZQ0KCXtmb250LWZhbWlseTpDb25zb2xhczsNCglwYW5vc2UtMToyIDExIDYgOSAyIDIg
NCAzIDIgNDt9DQpAZm9udC1mYWNlDQoJe2ZvbnQtZmFtaWx5OiJcQERlbmdYaWFuIjsNCglwYW5v
c2UtMToyIDEgNiAwIDMgMSAxIDEgMSAxO30NCi8qIFN0eWxlIERlZmluaXRpb25zICovDQpwLk1z
b05vcm1hbCwgbGkuTXNvTm9ybWFsLCBkaXYuTXNvTm9ybWFsDQoJe21hcmdpbjowaW47DQoJZm9u
dC1zaXplOjEyLjBwdDsNCglmb250LWZhbWlseToiQXB0b3MiLHNhbnMtc2VyaWY7fQ0KYTpsaW5r
LCBzcGFuLk1zb0h5cGVybGluaw0KCXttc28tc3R5bGUtcHJpb3JpdHk6OTk7DQoJY29sb3I6Ymx1
ZTsNCgl0ZXh0LWRlY29yYXRpb246dW5kZXJsaW5lO30NCnByZQ0KCXttc28tc3R5bGUtcHJpb3Jp
dHk6OTk7DQoJbXNvLXN0eWxlLWxpbms6IkhUTUwgUHJlZm9ybWF0dGVkIENoYXIiOw0KCW1hcmdp
bjowaW47DQoJZm9udC1zaXplOjEwLjBwdDsNCglmb250LWZhbWlseToiQ291cmllciBOZXciO30N
CnNwYW4uSFRNTFByZWZvcm1hdHRlZENoYXINCgl7bXNvLXN0eWxlLW5hbWU6IkhUTUwgUHJlZm9y
bWF0dGVkIENoYXIiOw0KCW1zby1zdHlsZS1wcmlvcml0eTo5OTsNCgltc28tc3R5bGUtbGluazoi
SFRNTCBQcmVmb3JtYXR0ZWQiOw0KCWZvbnQtZmFtaWx5OkNvbnNvbGFzO30NCnNwYW4uRW1haWxT
dHlsZTIyDQoJe21zby1zdHlsZS10eXBlOnBlcnNvbmFsLWNvbXBvc2U7DQoJZm9udC1mYW1pbHk6
IkFwdG9zIixzYW5zLXNlcmlmOw0KCWNvbG9yOndpbmRvd3RleHQ7fQ0KLk1zb0NocERlZmF1bHQN
Cgl7bXNvLXN0eWxlLXR5cGU6ZXhwb3J0LW9ubHk7DQoJZm9udC1zaXplOjEwLjBwdDsNCgltc28t
bGlnYXR1cmVzOm5vbmU7fQ0KQHBhZ2UgV29yZFNlY3Rpb24xDQoJe3NpemU6OC41aW4gMTEuMGlu
Ow0KCW1hcmdpbjoxLjBpbiAxLjBpbiAxLjBpbiAxLjBpbjt9DQpkaXYuV29yZFNlY3Rpb24xDQoJ
e3BhZ2U6V29yZFNlY3Rpb24xO30NCi0tPjwvc3R5bGU+PCEtLVtpZiBndGUgbXNvIDldPjx4bWw+
DQo8bzpzaGFwZWRlZmF1bHRzIHY6ZXh0PSJlZGl0IiBzcGlkbWF4PSIxMDI2IiAvPg0KPC94bWw+
PCFbZW5kaWZdLS0+PCEtLVtpZiBndGUgbXNvIDldPjx4bWw+DQo8bzpzaGFwZWxheW91dCB2OmV4
dD0iZWRpdCI+DQo8bzppZG1hcCB2OmV4dD0iZWRpdCIgZGF0YT0iMSIgLz4NCjwvbzpzaGFwZWxh
eW91dD48L3htbD48IVtlbmRpZl0tLT4NCjwvaGVhZD4NCjxib2R5IGxhbmc9IkVOLVVTIiBsaW5r
PSJibHVlIiB2bGluaz0icHVycGxlIiBzdHlsZT0id29yZC13cmFwOmJyZWFrLXdvcmQiPg0KPGRp
diBjbGFzcz0iV29yZFNlY3Rpb24xIj4NCjxwIGNsYXNzPSJNc29Ob3JtYWwiPkFkZCBUcml2aWFs
IHBhdGNoZXMgTWFpbnRhaW5lcnMuPG86cD48L286cD48L3A+DQo8cCBjbGFzcz0iTXNvTm9ybWFs
Ij48bzpwPiZuYnNwOzwvbzpwPjwvcD4NCjxwIGNsYXNzPSJNc29Ob3JtYWwiPkhpIEphc29uL01p
Y2hhZWwvTGF1cmVudCwgPG86cD48L286cD48L3A+DQo8cCBjbGFzcz0iTXNvTm9ybWFsIj5DYW4g
eW91IGhlbHAgdG8gcGljayB1cCB0aGlzIHBhdGNoIGZvciB1cHN0cmVhbSBhbmQgc3RhYmxlPzxv
OnA+PC9vOnA+PC9wPg0KPHAgY2xhc3M9Ik1zb05vcm1hbCI+PG86cD4mbmJzcDs8L286cD48L3A+
DQo8cCBjbGFzcz0iTXNvTm9ybWFsIj5UaGFua3M8bzpwPjwvbzpwPjwvcD4NCjxwIGNsYXNzPSJN
c29Ob3JtYWwiPkNoZW48bzpwPjwvbzpwPjwvcD4NCjxwIGNsYXNzPSJNc29Ob3JtYWwiPjxvOnA+
Jm5ic3A7PC9vOnA+PC9wPg0KPGRpdiBzdHlsZT0iYm9yZGVyOm5vbmU7Ym9yZGVyLWxlZnQ6c29s
aWQgYmx1ZSAxLjVwdDtwYWRkaW5nOjBpbiAwaW4gMGluIDQuMHB0Ij4NCjxkaXY+DQo8ZGl2IHN0
eWxlPSJib3JkZXI6bm9uZTtib3JkZXItdG9wOnNvbGlkICNFMUUxRTEgMS4wcHQ7cGFkZGluZzoz
LjBwdCAwaW4gMGluIDBpbiI+DQo8cCBjbGFzcz0iTXNvTm9ybWFsIj48Yj48c3BhbiBzdHlsZT0i
Zm9udC1zaXplOjExLjBwdDtmb250LWZhbWlseTomcXVvdDtDYWxpYnJpJnF1b3Q7LHNhbnMtc2Vy
aWYiPkZyb206PC9zcGFuPjwvYj48c3BhbiBzdHlsZT0iZm9udC1zaXplOjExLjBwdDtmb250LWZh
bWlseTomcXVvdDtDYWxpYnJpJnF1b3Q7LHNhbnMtc2VyaWYiPiBTdGVmYW4gV2VpbCAmbHQ7c3dA
d2VpbG5ldHouZGUmZ3Q7DQo8YnI+DQo8Yj5TZW50OjwvYj4gRnJpZGF5LCBPY3RvYmVyIDE4LCAy
MDI0IDM6NDQgQU08YnI+DQo8Yj5Ubzo8L2I+IFpoYW5nLCBDaGVuICZsdDtjaGVuLnpoYW5nQGlu
dGVsLmNvbSZndDs7IExpIFpoaWppYW4gJmx0O2xpemhpamlhbkBmdWppdHN1LmNvbSZndDs7IEph
c29uIFdhbmcgJmx0O2phc293YW5nQHJlZGhhdC5jb20mZ3Q7OyBxZW11LXN0YWJsZSAmbHQ7cWVt
dS1zdGFibGVAbm9uZ251Lm9yZyZndDs7IFFFTVUgVHJpdmlhbCAmbHQ7cWVtdS10cml2aWFsQG5v
bmdudS5vcmcmZ3Q7PGJyPg0KPGI+Q2M6PC9iPiBxZW11LWRldmVsQG5vbmdudS5vcmc8YnI+DQo8
Yj5TdWJqZWN0OjwvYj4gUmU6IFtQQVRDSF0gRml4IGNhbGN1bGF0aW9uIG9mIG1pbmltdW0gaW4g
Y29sb19jb21wYXJlX3RjcDxvOnA+PC9vOnA+PC9zcGFuPjwvcD4NCjwvZGl2Pg0KPC9kaXY+DQo8
cCBjbGFzcz0iTXNvTm9ybWFsIj48bzpwPiZuYnNwOzwvbzpwPjwvcD4NCjxwPkl0IGxvb2tzIGxp
a2Ugbm9ib2R5IGhhcyBzZW50IGEgcHVsbCByZXF1ZXN0IGZvciB0aGlzIGZpeCB1cCB0byBub3cu
IElzIGl0IHRyaXZpYWwgZW5vdWdoIGZvciBxZW11LXRyaXZpYWw/IEFuZCBtYXliZSBxZW11LXN0
YWJsZSBjb3VsZCBhbHNvIGFwcGx5IGl0IHRvIG9sZGVyIHZlcnNpb25zLjxvOnA+PC9vOnA+PC9w
Pg0KPHA+U3RlZmFuIFcuPG86cD48L286cD48L3A+DQo8ZGl2Pg0KPHAgY2xhc3M9Ik1zb05vcm1h
bCI+QW0gMTAuMDkuMjQgdW0gMDQ6Mzggc2NocmllYiBaaGFuZywgQ2hlbjogPG86cD48L286cD48
L3A+DQo8L2Rpdj4NCjxibG9ja3F1b3RlIHN0eWxlPSJtYXJnaW4tdG9wOjUuMHB0O21hcmdpbi1i
b3R0b206NS4wcHQiPg0KPGJsb2NrcXVvdGUgc3R5bGU9Im1hcmdpbi10b3A6NS4wcHQ7bWFyZ2lu
LWJvdHRvbTo1LjBwdCI+DQo8cHJlPi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tPG86cD48L286
cD48L3ByZT4NCjxwcmU+RnJvbTogU3RlZmFuIFdlaWwgPGEgaHJlZj0ibWFpbHRvOnN3QHdlaWxu
ZXR6LmRlIj4mbHQ7c3dAd2VpbG5ldHouZGUmZ3Q7PC9hPjxvOnA+PC9vOnA+PC9wcmU+DQo8cHJl
PlNlbnQ6IFR1ZXNkYXksIFNlcHRlbWJlciAxMCwgMjAyNCA0OjQzIEFNPG86cD48L286cD48L3By
ZT4NCjxwcmU+VG86IFpoYW5nLCBDaGVuIDxhIGhyZWY9Im1haWx0bzpjaGVuLnpoYW5nQGludGVs
LmNvbSI+Jmx0O2NoZW4uemhhbmdAaW50ZWwuY29tJmd0OzwvYT47IExpIFpoaWppYW4gPGEgaHJl
Zj0ibWFpbHRvOmxpemhpamlhbkBmdWppdHN1LmNvbSI+Jmx0O2xpemhpamlhbkBmdWppdHN1LmNv
bSZndDs8L2E+OzxvOnA+PC9vOnA+PC9wcmU+DQo8cHJlPkphc29uIFdhbmcgPGEgaHJlZj0ibWFp
bHRvOmphc293YW5nQHJlZGhhdC5jb20iPiZsdDtqYXNvd2FuZ0ByZWRoYXQuY29tJmd0OzwvYT48
bzpwPjwvbzpwPjwvcHJlPg0KPHByZT5DYzogPGEgaHJlZj0ibWFpbHRvOnFlbXUtZGV2ZWxAbm9u
Z251Lm9yZyI+cWVtdS1kZXZlbEBub25nbnUub3JnPC9hPjsgU3RlZmFuIFdlaWwgPGEgaHJlZj0i
bWFpbHRvOnN3QHdlaWxuZXR6LmRlIj4mbHQ7c3dAd2VpbG5ldHouZGUmZ3Q7PC9hPjxvOnA+PC9v
OnA+PC9wcmU+DQo8cHJlPlN1YmplY3Q6IFtQQVRDSF0gRml4IGNhbGN1bGF0aW9uIG9mIG1pbmlt
dW0gaW4gY29sb19jb21wYXJlX3RjcDxvOnA+PC9vOnA+PC9wcmU+DQo8cHJlPjxvOnA+Jm5ic3A7
PC9vOnA+PC9wcmU+DQo8cHJlPkdpdEh1YidzIENvZGVRTCByZXBvcnRzIGEgY3JpdGljYWwgZXJy
b3Igd2hpY2ggaXMgZml4ZWQgYnkgdXNpbmcgdGhlIE1JTjxvOnA+PC9vOnA+PC9wcmU+DQo8cHJl
Pm1hY3JvOjxvOnA+PC9vOnA+PC9wcmU+DQo8cHJlPjxvOnA+Jm5ic3A7PC9vOnA+PC9wcmU+DQo8
cHJlPiZuYnNwOyZuYnNwOyZuYnNwOyBVbnNpZ25lZCBkaWZmZXJlbmNlIGV4cHJlc3Npb24gY29t
cGFyZWQgdG8gemVybzxvOnA+PC9vOnA+PC9wcmU+DQo8cHJlPjxvOnA+Jm5ic3A7PC9vOnA+PC9w
cmU+DQo8cHJlPlNpZ25lZC1vZmYtYnk6IFN0ZWZhbiBXZWlsIDxhIGhyZWY9Im1haWx0bzpzd0B3
ZWlsbmV0ei5kZSI+Jmx0O3N3QHdlaWxuZXR6LmRlJmd0OzwvYT48bzpwPjwvbzpwPjwvcHJlPg0K
PC9ibG9ja3F1b3RlPg0KPHByZT48bzpwPiZuYnNwOzwvbzpwPjwvcHJlPg0KPHByZT5Mb29rcyBn
b29kIHRvIG1lLjxvOnA+PC9vOnA+PC9wcmU+DQo8cHJlPlJldmlld2VkLWJ5OiBaaGFuZyBDaGVu
IDxhIGhyZWY9Im1haWx0bzpjaGVuLnpoYW5nQGludGVsLmNvbSI+Jmx0O2NoZW4uemhhbmdAaW50
ZWwuY29tJmd0OzwvYT48bzpwPjwvbzpwPjwvcHJlPg0KPHByZT48bzpwPiZuYnNwOzwvbzpwPjwv
cHJlPg0KPHByZT5UaGFua3M8bzpwPjwvbzpwPjwvcHJlPg0KPHByZT5DaGVuPG86cD48L286cD48
L3ByZT4NCjxwcmU+PG86cD4mbmJzcDs8L286cD48L3ByZT4NCjxibG9ja3F1b3RlIHN0eWxlPSJt
YXJnaW4tdG9wOjUuMHB0O21hcmdpbi1ib3R0b206NS4wcHQiPg0KPHByZT4tLS08bzpwPjwvbzpw
PjwvcHJlPg0KPHByZT4gbmV0L2NvbG8tY29tcGFyZS5jIHwgMyArLS08bzpwPjwvbzpwPjwvcHJl
Pg0KPHByZT4gMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAyIGRlbGV0aW9ucygtKTxv
OnA+PC9vOnA+PC9wcmU+DQo8cHJlPjxvOnA+Jm5ic3A7PC9vOnA+PC9wcmU+DQo8cHJlPmRpZmYg
LS1naXQgYS9uZXQvY29sby1jb21wYXJlLmMgYi9uZXQvY29sby1jb21wYXJlLmMgaW5kZXg8bzpw
PjwvbzpwPjwvcHJlPg0KPHByZT5jNGFkMGFiNzFmLi4zOWY5MGM0MDY1IDEwMDY0NDxvOnA+PC9v
OnA+PC9wcmU+DQo8cHJlPi0tLSBhL25ldC9jb2xvLWNvbXBhcmUuYzxvOnA+PC9vOnA+PC9wcmU+
DQo8cHJlPisrKyBiL25ldC9jb2xvLWNvbXBhcmUuYzxvOnA+PC9vOnA+PC9wcmU+DQo8cHJlPkBA
IC00MTIsOCArNDEyLDcgQEAgc3RhdGljIHZvaWQgY29sb19jb21wYXJlX3RjcChDb21wYXJlU3Rh
dGUgKnMsPG86cD48L286cD48L3ByZT4NCjxwcmU+Q29ubmVjdGlvbiAqY29ubik8bzpwPjwvbzpw
PjwvcHJlPg0KPHByZT4mbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgKiBjYW4gZW5zdXJl
IHRoYXQgdGhlIHBhY2tldCdzIHBheWxvYWQgaXMgYWNrbm93bGVkZ2VkIGJ5PG86cD48L286cD48
L3ByZT4NCjxwcmU+Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7ICogcHJpbWFyeSBhbmQg
c2Vjb25kYXJ5LjxvOnA+PC9vOnA+PC9wcmU+DQo8cHJlPiZuYnNwOyZuYnNwOyZuYnNwOyZuYnNw
OyAqLzxvOnA+PC9vOnA+PC9wcmU+DQo8cHJlPi0mbmJzcDsmbmJzcDsmbmJzcDsgdWludDMyX3Qg
bWluX2FjayA9IGNvbm4tJmd0O3BhY2sgLSBjb25uLSZndDtzYWNrICZndDsgMCA/PG86cD48L286
cD48L3ByZT4NCjxwcmU+LSZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNw
OyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZu
YnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyBjb25uLSZndDtzYWNrIDogY29ubi0m
Z3Q7cGFjazs8bzpwPjwvbzpwPjwvcHJlPg0KPHByZT4rJm5ic3A7Jm5ic3A7Jm5ic3A7IHVpbnQz
Ml90IG1pbl9hY2sgPSBNSU4oY29ubi0mZ3Q7cGFjaywgY29ubi0mZ3Q7c2Fjayk7PG86cD48L286
cD48L3ByZT4NCjxwcmU+PG86cD4mbmJzcDs8L286cD48L3ByZT4NCjxwcmU+IHByaTo8bzpwPjwv
bzpwPjwvcHJlPg0KPHByZT4mbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgaWYgKGdfcXVldWVfaXNf
ZW1wdHkoJmFtcDtjb25uLSZndDtwcmltYXJ5X2xpc3QpKSB7PG86cD48L286cD48L3ByZT4NCjxw
cmU+LS08bzpwPjwvbzpwPjwvcHJlPg0KPHByZT4yLjM5LjMgKEFwcGxlIEdpdC0xNDYpPG86cD48
L286cD48L3ByZT4NCjwvYmxvY2txdW90ZT4NCjwvYmxvY2txdW90ZT4NCjwvZGl2Pg0KPC9kaXY+
DQo8L2JvZHk+DQo8L2h0bWw+DQo=

--_000_CYYPR11MB8432723FB4A5A76E3ABB02699B402CYYPR11MB8432namp_--

