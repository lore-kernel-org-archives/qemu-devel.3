Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19978C5478C
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Mar 2024 14:09:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rh908-0007ep-Ca; Mon, 04 Mar 2024 09:09:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <evan.chai@intel.com>)
 id 1rh6iW-0007OU-H3; Mon, 04 Mar 2024 06:42:49 -0500
Received: from mgamail.intel.com ([192.198.163.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <evan.chai@intel.com>)
 id 1rh6iR-0006UP-Kw; Mon, 04 Mar 2024 06:42:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1709552563; x=1741088563;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=BC/rbRUSe2PoY2UnaUxTiFs/3MhwJIYRQ9p7RtHl3WY=;
 b=NYrtgCVIj8UC/0wT68fysh4ylOnAOh+won9AY1k7fr4cgSUkUyUpPJDv
 3su0/WLRhZ+vXDK5hRLduHJ3HAQlxlACLHaj55r5CuPabBnDkostmu+7x
 NKVQ8oLnPjoeMeM2bN0c8DqfBAoVyKECLDUcQJaKPRoQlbcXs1kQvBOGx
 pGNuV84Ne+wR+fQqhu4CgreHQgUIvkcO+VAcOi0ynPXxswrSVS6ySBZCM
 cG3cVh41WBLgT77cUIIv3g9LXuXWFlmj3eP8gY4ooVejjZqXJTUw9cPdd
 h/WnV77ajtDTXZd0w5/kkjtvgUxNReJS3hQPrQp7nNWGLRZcesQw2dqyA w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11002"; a="4615727"
X-IronPort-AV: E=Sophos;i="6.06,203,1705392000"; 
   d="scan'208";a="4615727"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Mar 2024 03:42:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,203,1705392000"; 
   d="scan'208";a="9149624"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
 by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 04 Mar 2024 03:42:36 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 4 Mar 2024 03:42:36 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 4 Mar 2024 03:42:35 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 4 Mar 2024 03:42:35 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 4 Mar 2024 03:42:35 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HML6yRz+VbAFUyS/cwhqQpNx4edqTic/8YQ4UsfGfpOaDuKtD+LSqDpcBHg9tEtGB/h5FpItOTvgN/ZJijuypOhSgXnSY87M+QJwgnc69vhwZXBp74tBIlkz8sJbfrPftXLfZZBZICF7RWA1Dl61flLTMtIj9UzAVtmBdoZoFyAEtTg3tg6PmJJTUYBswbETK2XQiiUhTBvlr4kL1bJZmEutsoymGPZKHfLlkm4D3zDAj2KEUqnzjGpXgmLG7WvkTQOTuvTus7ISy56ULLsA1SC+zN6yc7XNfHt3ojWYonxM1cTpkHKZynTl7h5RhjZT7BhXLkatBKXYjzXlB0SJ1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BC/rbRUSe2PoY2UnaUxTiFs/3MhwJIYRQ9p7RtHl3WY=;
 b=JU0pFJkukQ6yMBR0geL82lJS7O8klLt2+A/F19CZG/EudyGJqhp90ZaVmuPPzcPQEe8z1gjycF5Nx2eXzMNUCmJqLvULFtpKOJ+MbdG+ZGKTOOn9n5wbiePTKKKYTQ/80ZBGRJGrWfGXgcc9tpeUOngBHDO53uduLNhKKVVd6Q0/35tVqdtZ05Njr5bONAx6RUKKdU2KnRNDWYpuc+MybMHbslT9bnAOupiBh/VWsNkDx35pbNBlCUzNxmU7Roa+cldDutZYhUN2pA0JPqD2JCXhngINDE0khfzq0RG4kJTi0HhQzUL9IVaXBQKbdr5ygsNM/Cq3MwAHzrfmd/txDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB5868.namprd11.prod.outlook.com (2603:10b6:a03:42b::6)
 by SA2PR11MB5100.namprd11.prod.outlook.com (2603:10b6:806:119::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.22; Mon, 4 Mar
 2024 11:42:26 +0000
Received: from SJ0PR11MB5868.namprd11.prod.outlook.com
 ([fe80::fa53:d77d:43ff:6555]) by SJ0PR11MB5868.namprd11.prod.outlook.com
 ([fe80::fa53:d77d:43ff:6555%6]) with mapi id 15.20.7362.019; Mon, 4 Mar 2024
 11:42:26 +0000
From: "Chai, Evan" <evan.chai@intel.com>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>, "Wu, Fei2"
 <fei2.wu@intel.com>
CC: "pbonzini@redhat.com" <pbonzini@redhat.com>, "palmer@dabbelt.com"
 <palmer@dabbelt.com>, "alistair.francis@wdc.com" <alistair.francis@wdc.com>,
 "Meng, Bin" <bin.meng@windriver.com>, "liwei1518@gmail.com"
 <liwei1518@gmail.com>, "dbarboza@ventanamicro.com"
 <dbarboza@ventanamicro.com>, "zhiwei_liu@linux.alibaba.com"
 <zhiwei_liu@linux.alibaba.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>,
 "Warkentin, Andrei" <andrei.warkentin@intel.com>,
 "shaolin.xie@alibaba-inc.com" <shaolin.xie@alibaba-inc.com>,
 "ved@rivosinc.com" <ved@rivosinc.com>, "sunilvl@ventanamicro.com"
 <sunilvl@ventanamicro.com>, "Xu, Haibo1" <haibo1.xu@intel.com>, "Wang, Yin"
 <yin.wang@intel.com>, "tech-server-platform@lists.riscv.org"
 <tech-server-platform@lists.riscv.org>, "tech-server-soc@lists.riscv.org"
 <tech-server-soc@lists.riscv.org>
Subject: RE: [RISC-V][tech-server-platform] [RFC 0/2] Add RISC-V Server
 Platform Reference Board
Thread-Topic: [RISC-V][tech-server-platform] [RFC 0/2] Add RISC-V Server
 Platform Reference Board
Thread-Index: AQHabh548jqNH68LJE26/o3VLTPYjrEnap0AgAAJr7A=
Date: Mon, 4 Mar 2024 11:42:26 +0000
Message-ID: <SJ0PR11MB58685C15C580EA9EFF4BC731FE232@SJ0PR11MB5868.namprd11.prod.outlook.com>
References: <20240304102540.2789225-1-fei2.wu@intel.com>
 <d1bde67a-0f02-4fa4-a736-cbd3f35ff553@canonical.com>
In-Reply-To: <d1bde67a-0f02-4fa4-a736-cbd3f35ff553@canonical.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB5868:EE_|SA2PR11MB5100:EE_
x-ms-office365-filtering-correlation-id: 5d0b51d0-111d-42f7-6048-08dc3c402a07
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IFLA2Jwky5Ejv2zZE2tZ6dt26NAKXKcfDbul5nhJgVRluLfeCdRbsYHGUiMKMb6TGFklTBlC/b5IKttizPV3PUzuOl76Crs6bZUCD5b0yml8DKmdbQ+hlIQD32HoG6jD8etmuotkyLUlU0/ysyLY/lbgokYiRNMPk97H3Cww/ZkNFQTx7YEmMQ9ERv5P53Rkyj1eYFF3gvhOXxrHGCTpvENiOcOuBH3zaRPqKPyhs9zEHIXs7mvRvDeKsN+9QM2NQolshsCd222j2d4J4Mh+Xlbfoc8XhJ3iSEfsxHoKPKkRP91TtdZ6iJSbD/ytFyEbv3VaToeZup/d3Mqku3GO/37+NkNMTyy16sk+Yr/Hoi6tOX75cUvicKObMB/gXRPpDncba4EfJr+48Iqgp3cjd6UJt8ESGp1JMVQh3aUGXO74cTBMwCcacGEP5LL0bl+quGSuQ3ZTh37ovuq0gp7pEocDw4f0kvGAyHyOreyqu9EJMDu1Re5bUv+kuCzQkiq0ybUdgjEwg9ocYTKKlLsduf0MCi+yrEFWRVv74Pi9e7qwoVfAhLVJ5XelPiq20uulBh/g+MNvkkGBeELGHwjE+PSIExrvnoZR6iebTFIjCBoqJxZ405k3vtwEocdUBls+MUMst73GD0ey+3UoW5JsoDE2o3IYVuHODjl6gJU2mYU=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB5868.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ODdmNjJ4Ukw2SEp1STJSQnhmemkvN0VoMlN3eTdpY3dIcG40R01zUHlDM3ZH?=
 =?utf-8?B?eXE0blFVdFFiVXFjWEovMlpkZ0dsN3BLOS9JTktQWWdab1AwSGEvaHRZd1Rh?=
 =?utf-8?B?bHBjRkNGem11UzAvK3FKMk5GTUdHY3dZYzNPSlRUc0hiSVQyOHlJZkpCM0My?=
 =?utf-8?B?dXhxNlUySEgxZDZrbnVZejUrOEdhQ3hUYmRQaUpZaW9qZWs4VFZGMTRXYmwv?=
 =?utf-8?B?NWxNOW5VRjFXdDZNY1JhMzN6Q05pbVJMTmVOek9LcEFvbEdLcjZTejc1SEll?=
 =?utf-8?B?OEYrWVRqRDN2Nml5cHdZaUQ3by8wclVnbVcrWFdGb2lwQlhrVWRNVmUwelVG?=
 =?utf-8?B?dktUYzgzSmpvMi9US04vUXg4MGFwY0RQMmRzU0VjNzlaRGRGN3NKaEZkeGty?=
 =?utf-8?B?R2hKdWRGK1hoZTR2ZS9ycWgwWkZTU3hOVTNtdUlPRng3ZW53enVsZlB0blg3?=
 =?utf-8?B?Q3JSTUNscXdnQ0lQbjA3U0RMSG85UmlFNWJOa0dyWFVTek5KOG9Oelk1dmIz?=
 =?utf-8?B?WlVhMzhPOS9Sd2JvK01PTzJYS3BReFUxeHZySkxkRjZDVXhFQTNMUnc3VU9u?=
 =?utf-8?B?NmY1QWFpTTZuZFdwMjNpSmVWNUNsNW1DSmwweS9sZW8rQzF4cmI5MXB4RC8x?=
 =?utf-8?B?dUNTR0lBRHFWT214S3BJNHNaM2VuSnhKaDVSMFBDK1RFWVZUM0FoNkZwclJO?=
 =?utf-8?B?eDJjWSs4ZmhCN2lDM0xRd1gvcnVMczNDajFlcUpyRW85Q3hMNlZwTDdFOExQ?=
 =?utf-8?B?cGNzajd5TVdodHlaK2w5SEFya09ESXY4TkVFY0xxaGVmM1JKMytYNEl0QnZp?=
 =?utf-8?B?eWI1QWpTb0RUUFJtSVdIb25SRkdrTjVweGNPQUtZdkUxZ0YvbTZTUDZCMFpQ?=
 =?utf-8?B?ZjRlUWw0ZTVzUDRRMTFhQ2Q4d1ZRTmRyamk1cXJJQnlqR0JrZ3VpYXVhN3Vz?=
 =?utf-8?B?NzFaSzIwdjBQZlp3VDNsKzJWemFTQ2RXeXVEWmpqM3F5d1QyWGhOMmZQNGlq?=
 =?utf-8?B?ajJOQXRibXlaTkZZYVNHTFl3azB0NkRCQ0dPVkI4QmRGZnVqUm5XY0Fjbi9M?=
 =?utf-8?B?KzA3Z0VTQWJiYVRvRHhlWit1emQ4a1l0eHp2eUFPTCs1YjFJQ0ZpbWhyS3kw?=
 =?utf-8?B?WmZzbUk0TjFkRU44U003ek5Md1hLSkp5elY1eTliVXZOMXJXQmg1RGRYSmRK?=
 =?utf-8?B?VXc0aktONGVhOXFPT3l5WWZmY2RXYTRTbHF4b2k4YXJVSW13TWZsZHJFTnRq?=
 =?utf-8?B?c2JKMlVTUElwWlBrUWc2S1Z6TlZHcng2ZzJwaDhJaDdDNmIwalJtMUVBUjJK?=
 =?utf-8?B?QUxIbU94UkJ6TjMwcHRrRzRhekQ5aTlWck80MEEzZjYraEtRMEtoajlXelJT?=
 =?utf-8?B?d1FYSHhZZDVwbENUVCtBUE5GSjJaaWgyc1puSlFzM3pGbDExMHhzMjhnVFow?=
 =?utf-8?B?bk9hOFk0cWtnVXBVR05JZFpsSnZ3Qlo1K1JISG9IM1V6TVZrOXVpMWU3TXhZ?=
 =?utf-8?B?TFp6VHFudG9JVmNaVHdIVlZTbzQzanlrdmNlOTczSGpsbzhQNWVmUnV1WjNO?=
 =?utf-8?B?ZURPSXI3OTJxL3laNTVXQ3RZZ1BoMEhXTURyL09xNi9maHhzMjNaVWpjNjc1?=
 =?utf-8?B?SWVNNWU0K0M5TWJub0Y4MjI0VFFpbUFYTVZQUUkwNExtaGxDMmxrTVphN1dK?=
 =?utf-8?B?ZEM1M0pWbVlRNUkxTklFcVcwalc3bUUwRGthR29KVi9wcTZkQ0I0ZGZFTXFy?=
 =?utf-8?B?TzY1VXNHQzRiRHpwS0R4eUk2aUtsRk10Q3lCVCsxV1dJelRZa3VPTERhNFpK?=
 =?utf-8?B?TWhyeDNkdm9TalZVcHJ2dGh2RVRtQ0FHVUh2QzJidDBvRWtnV3lqbGlxR09Q?=
 =?utf-8?B?MWkwamlyVVFYQkFtWGxHSndxZVZuTGVZSzBUV3VCZzdOcFVJMG5BdjM2ck5y?=
 =?utf-8?B?SlhZK2JRTHowY1RjRkE4QitNbkwvMENGMzNTNFhUMk1XYjVlenduWVppWEV5?=
 =?utf-8?B?b2JsK1E3T2tKc3o0cmFjdzdlYTc5WCs3VWRxSGJ0cTBmVUJjUHcvcjU2N1dN?=
 =?utf-8?B?dEhFZzk5T3F1UDNPa1ROQUlkVkhJcDc1S21WMGh5NU5GWjVqbnF2UkV6dGtY?=
 =?utf-8?Q?vnLGXnIKGEwYMi48aAXz+Y25I?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5868.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d0b51d0-111d-42f7-6048-08dc3c402a07
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Mar 2024 11:42:26.0292 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VNYxAPqnpAcqoNhuhUUIqrfWkbwjriQbRuB4w0X5vvyDgM5KHDpOlKcWeLCtPEIx2CzKb6XTn08s2soBFvMqjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5100
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.16; envelope-from=evan.chai@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.589,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 04 Mar 2024 09:09:06 -0500
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

WWVzLiBJbiBzaG9ydCB0ZXJtLCBTbWJpb3MvQUNQSSBzdGlsbCBuZWVkIHRvIGJlIGhhbmRsZWQg
YnkgUWVtdS4gDQpXZSB3aWxsIGhhdmUgYSByZWZlcmVuY2UgYm9hcmQgdG8gdXBzdHJlYW0gdG8g
ZWRrMi1wbGF0Zm9ybSBjb21wYXRpYmxlIHdpdGggc2VydmVyIHBsYXRmb3JtIHNwZWMsIHdoaWNo
IGlzIHN0aWxsIHVuZGVyIHJldmlldyBub3cuIEFmdGVyIHRoYXQsIFNtYmlvcy9BY3BpIHdpbGwg
YmUgdGFrZW4gb3ZlciBieSBmaXJtd2FyZSBkaXJlY3RseS4gDQoNCkJSLA0KRXZhbg0KDQotLS0t
LU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogSGVpbnJpY2ggU2NodWNoYXJkdCA8aGVpbnJp
Y2guc2NodWNoYXJkdEBjYW5vbmljYWwuY29tPiANClNlbnQ6IE1vbmRheSwgTWFyY2ggNCwgMjAy
NCA3OjAyIFBNDQpUbzogV3UsIEZlaTIgPGZlaTIud3VAaW50ZWwuY29tPg0KQ2M6IHBib256aW5p
QHJlZGhhdC5jb207IHBhbG1lckBkYWJiZWx0LmNvbTsgYWxpc3RhaXIuZnJhbmNpc0B3ZGMuY29t
OyBNZW5nLCBCaW4gPGJpbi5tZW5nQHdpbmRyaXZlci5jb20+OyBsaXdlaTE1MThAZ21haWwuY29t
OyBkYmFyYm96YUB2ZW50YW5hbWljcm8uY29tOyB6aGl3ZWlfbGl1QGxpbnV4LmFsaWJhYmEuY29t
OyBxZW11LWRldmVsQG5vbmdudS5vcmc7IHFlbXUtcmlzY3ZAbm9uZ251Lm9yZzsgV2Fya2VudGlu
LCBBbmRyZWkgPGFuZHJlaS53YXJrZW50aW5AaW50ZWwuY29tPjsgc2hhb2xpbi54aWVAYWxpYmFi
YS1pbmMuY29tOyB2ZWRAcml2b3NpbmMuY29tOyBzdW5pbHZsQHZlbnRhbmFtaWNyby5jb207IFh1
LCBIYWlibzEgPGhhaWJvMS54dUBpbnRlbC5jb20+OyBDaGFpLCBFdmFuIDxldmFuLmNoYWlAaW50
ZWwuY29tPjsgV2FuZywgWWluIDx5aW4ud2FuZ0BpbnRlbC5jb20+OyB0ZWNoLXNlcnZlci1wbGF0
Zm9ybUBsaXN0cy5yaXNjdi5vcmc7IHRlY2gtc2VydmVyLXNvY0BsaXN0cy5yaXNjdi5vcmcNClN1
YmplY3Q6IFJlOiBbUklTQy1WXVt0ZWNoLXNlcnZlci1wbGF0Zm9ybV0gW1JGQyAwLzJdIEFkZCBS
SVNDLVYgU2VydmVyIFBsYXRmb3JtIFJlZmVyZW5jZSBCb2FyZA0KDQpPbiAwNC4wMy4yNCAxMToy
NSwgV3UsIEZlaTIgd3JvdGU6DQo+IFRoZSBSSVNDLVYgU2VydmVyIFBsYXRmb3JtIHNwZWNpZmlj
YXRpb25bMV0gZGVmaW5lcyBhIHN0YW5kYXJkaXplZCBzZXQgDQo+IG9mIGhhcmR3YXJlIGFuZCBz
b2Z0d2FyZSBjYXBhYmlsaXRpZXMsIHRoYXQgcG9ydGFibGUgc3lzdGVtIHNvZnR3YXJlLCANCj4g
c3VjaCBhcyBPUyBhbmQgaHlwZXJ2aXNvcnMgY2FuIHJlbHkgb24gYmVpbmcgcHJlc2VudCBpbiBh
IFJJU0MtViANCj4gc2VydmVyIHBsYXRmb3JtLiBUaGlzIHBhdGNoc2V0IHByb3ZpZGVzIGEgUklT
Qy1WIFNlcnZlciBQbGF0Zm9ybSANCj4gKFJWU1ApIHJlZmVyZW5jZSBpbXBsZW1lbnRhdGlvbiBv
biBxZW11IHdoaWNoIGlzIGluIGNvbXBsaWFuY2Ugd2l0aCANCj4gdGhlIHNwZWMgYXMgZmFpdGhm
dWwgYXMgcG9zc2libGUuDQo+IA0KPiBUaGUgcmVmZXJlbmNlIGJvYXJkIGNhbiBiZSBydW5uaW5n
IHdpdGggdGFnIGVkazItc3RhYmxlMjAyMzA4IGluIA0KPiB1cHN0cmVhbSBlZGsyIHJlcG9bMl0u
DQo+IA0KPiBUaGUgcWVtdSBjb21tYW5kIGxpbmUgdXNlZDoNCj4gDQo+ICRRRU1VIC1ub2dyYXBo
aWMgLW0gNEcgLXNtcCAyIFwNCj4gICAgICAtbWFjaGluZSBydnNwLXJlZixwZmxhc2gwPXBmbGFz
aDAscGZsYXNoMT1wZmxhc2gxIFwNCj4gICAgICAtYmxvY2tkZXYgbm9kZS1uYW1lPXBmbGFzaDAs
ZHJpdmVyPWZpbGUscmVhZC1vbmx5PW9uLGZpbGVuYW1lPVJJU0NWX1ZJUlRfQ09ERS5mZCBcDQo+
ICAgICAgLWJsb2NrZGV2IG5vZGUtbmFtZT1wZmxhc2gxLGRyaXZlcj1maWxlLGZpbGVuYW1lPVJJ
U0NWX1ZJUlRfVkFSUy5mZCBcDQo+ICAgICAgLWJpb3MgZndfZHluYW1pYy5iaW4gXA0KPiAgICAg
IC1kcml2ZSBmaWxlPSRCUlNfSU1HLGlmPWlkZSxmb3JtYXQ9cmF3DQo+IA0KPiBTaW5jZSB0aGVy
ZSBpcyBubyBBQ1BJIHRhYmxlIGdlbmVyYXRlZCBpbiB0aGlzIG5ldyBtYWNoaW5lIHR5cGUsIGEg
DQo+IGNvcnJlc3BvbmRpbmcgRURLLUlJIHBsYXRmb3JtIChXSVApIGlzIG5lZWRlZCB0byBwcm92
aWRlIHJlbGF0ZWQgQUNQSSANCj4gdGFibGVzLg0KDQpUaGUgbmVlZCBmb3IgaGF2aW5nIGEgcGxh
dGZvcm0gc2VwYXJhdGUgdG8gdmlydCBmb3IgY29tcGxpYW5jZSB0ZXN0aW5nIHdhcyBkaXNjdXNz
ZWQgaW4gUklTRSBpbiBSVkkgbWVldGluZ3MuIFRoYW5rcyBmb3IgZHJpdmluZyB0aGlzLg0KDQpX
aWxsIHRoZSBFREsgSUkgcGxhdGZvcm0gYWxzbyBnZW5lcmF0ZSB0aGUgU01CSU9TIHRhYmxlIG9y
IHNoYWxsIHRoaXMgYmUgaGFuZGxlZCBpbiBRRU1VPw0KDQpXaWxsIGZ1cnRoZXIgd29yayBpbiBl
ZGsyLXBsYXRmb3JtcyBiZSBuZWVkZWQgdG8gcHJvdmlkZSBmdWxsIGNvbXBsaWFuY2Ugd2l0aCB0
aGUgdGhlIHNlcnZlciBwbGF0Zm9ybSBzcGVjaWZpY2F0aW9uPw0KDQpCZXN0IHJlZ2FyZHMNCg0K
SGVpbnJpY2gNCg0KPiANCj4gRm9yIHRlc3RpbmcgcHVycG9zZXMgb25seSwgd2UgdXNlZCBhIHdv
cmthcm91bmQgdG8gZ2VuZXJhdGUgdGhlIEFDUEkgDQo+IHRhYmxlcyBpbiBRZW11IHdpdGggYSBk
ZWRpY2F0ZWQgZG93bnN0cmVhbSBwYXRjaC4NCj4gDQo+IFsxXSBodHRwczovL2dpdGh1Yi5jb20v
cmlzY3Ytbm9uLWlzYS9yaXNjdi1zZXJ2ZXItcGxhdGZvcm0NCj4gWzJdIGh0dHBzOi8vZ2l0aHVi
LmNvbS90aWFub2NvcmUvZWRrMi5naXQNCj4gDQo+IEZlaSBXdSAoMik6DQo+ICAgIGh3L3Jpc2N2
OiBBZGQgc2VydmVyIHBsYXRmb3JtIHJlZmVyZW5jZSBtYWNoaW5lDQo+ICAgIHRhcmdldC9yaXNj
djogQWRkIHNlcnZlciBwbGF0Zm9ybSByZWZlcmVuY2UgY3B1DQo+IA0KPiAgIGNvbmZpZ3MvZGV2
aWNlcy9yaXNjdjY0LXNvZnRtbXUvZGVmYXVsdC5tYWsgfCAgICAxICsNCj4gICBody9yaXNjdi9L
Y29uZmlnICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgICAxMyArDQo+ICAgaHcvcmlzY3Yv
bWVzb24uYnVpbGQgICAgICAgICAgICAgICAgICAgICAgICB8ICAgIDEgKw0KPiAgIGh3L3Jpc2N2
L3NlcnZlcl9wbGF0Zm9ybV9yZWYuYyAgICAgICAgICAgICAgfCAxMjQ4ICsrKysrKysrKysrKysr
KysrKysNCj4gICB0YXJnZXQvcmlzY3YvY3B1LXFvbS5oICAgICAgICAgICAgICAgICAgICAgIHwg
ICAgMSArDQo+ICAgdGFyZ2V0L3Jpc2N2L2NwdS5jICAgICAgICAgICAgICAgICAgICAgICAgICB8
ICAgNjIgKw0KPiAgIDYgZmlsZXMgY2hhbmdlZCwgMTMyNiBpbnNlcnRpb25zKCspDQo+ICAgY3Jl
YXRlIG1vZGUgMTAwNjQ0IGh3L3Jpc2N2L3NlcnZlcl9wbGF0Zm9ybV9yZWYuYw0KPiANCg0K

