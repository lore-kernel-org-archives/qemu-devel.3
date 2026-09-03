Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACD98C624D4
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 05:24:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1zvE-0002pF-5v; Thu, 03 Sep 2026 01:23:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=6997dc6e7=Alistair.Francis@wdc.com>)
 id 1x1zvC-0002oP-9B; Thu, 03 Sep 2026 01:23:34 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=6997dc6e7=Alistair.Francis@wdc.com>)
 id 1x1zvA-0003Qn-7f; Thu, 03 Sep 2026 01:23:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1788413012; x=1819949012;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=CVYlxcJp2iVCNrHnmrL05TrFMh2Tnul33CT1Hry6BgE=;
 b=BFDQWjw94JdpltMK6C2hqY+/mnESw8lcBwuJ3x3hTrQnJD9dMIQYbzhK
 iiTSwE7ljIywsigjmz4ieYVpRrASHIIhW1cYba51OLDLhHtjTsFa+PTZT
 iZbwNzW5KxxSHIhOctbPP0C+h7q2hpuMf6nREDvvE7AuOnKgDPHzSHk/1
 2iC06Syr5BK8SlhDcnv1TWSRWNoFQeaGXv5JEjrVqIHM2L55oRZt+10LY
 Zb6QZ+2wmW19phOxr2kZE+1zW9a658dGcR0ti/x1m/ZDD1Ht3pxbudZ2Y
 8G+vEoBNPfAya033lyr6T6qxNEM07zHRmdinrmtSau7nnxYoV5drYf7md Q==;
X-CSE-ConnectionGUID: biDagJa4R4WW1tv+pG85ig==
X-CSE-MsgGUID: KGN6PIc8TZKfwSnNb/dKvQ==
X-IronPort-AV: E=Sophos;i="6.25,258,1779120000"; d="scan'208";a="155769637"
Received: from mail-northcentralusazon11013001.outbound.protection.outlook.com
 (HELO CH4PR04CU002.outbound.protection.outlook.com) ([40.107.201.1])
 by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 03 Sep 2026 13:23:28 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IhPuVKhuPfIj3yJSzisTo2DLoyOFaoZRBggrnk6qvQt7bz7QZRTr5v1CmziP3b/DK1vS9AB65BHPZ8uK2ebqKKxCFev8jMDcVUPppBxb4dY/sCKaPNsgC2PMkR230vTTXua+QljnTmwW5aKJyRL2qcfE485ttKJ3Hr3MvIXQeve9SKMBMgjnwIzjD+viOaUCmRjQCQ62PYrBLhn0aKmkYCOU+jm+I5iy52aNtVkqMbHy56iK/b04QlZZ7xfkVaVG+XGioRQAlZ7cEl//fU0BzcxmVKZmw2RKyay37brCGt3sttqEhFkdKQde1e513JkU1PoSiVOr6H18w+BHeTxdTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CVYlxcJp2iVCNrHnmrL05TrFMh2Tnul33CT1Hry6BgE=;
 b=o3GFiyG5xvXweak69pftySQ0fd66X/T7dg5JAb759/zdZYj6oPmZDMbcTPQOiBzI7Wq1+1AWA5w4+dYUdEhiwggy5MYd0k3/cXCKlprn4lpcJPfxbPKjgDHAs4s5P/4+WxtBbqpTHL8cadwY6nQdyunGMzFN0JSrZka8fA6EXEjoureJcGH62OqGW1BbI/OQtwL7uW0U9Y7su6pYdI05YVP7FvqdKdGUBwgDWRsdOpqqMBySoCG7D5PsHpchQZ2/8WjFBq3+ND1lwtung2bTsBYc7f/eEnOgg5cLQcAy2rMliCO1bNl0Hhw0HMv0cleMVO4MqONBqWFLH4/9VtxKRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CVYlxcJp2iVCNrHnmrL05TrFMh2Tnul33CT1Hry6BgE=;
 b=SCJ9+5vPsrAcBoLxLGVqZ5VfrQ1Klq0iJVQpyYmSSsxbFilNN1TbBbyADNNE94vDC/C8i50Hmez5xzaW/VeDQvLk3t2lMxXVQ6oH15esdUrHmOkXXKDhJvXArDP9pFFNgEBRo1rn0CUGvu4sr2KZdUUKoG+XPKbqL0VoKoLGld8=
Received: from BY1PR04MB9561.namprd04.prod.outlook.com (2603:10b6:a03:5b6::11)
 by BY5PR04MB6390.namprd04.prod.outlook.com (2603:10b6:a03:1e2::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.10; Thu, 3 Sep
 2026 05:23:25 +0000
Received: from BY1PR04MB9561.namprd04.prod.outlook.com
 ([fe80::3869:e494:2fa8:9888]) by BY1PR04MB9561.namprd04.prod.outlook.com
 ([fe80::3869:e494:2fa8:9888%5]) with mapi id 15.21.0382.007; Thu, 3 Sep 2026
 05:23:25 +0000
From: Alistair Francis <Alistair.Francis@wdc.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "wangyang25@otcaix.iscas.ac.cn" <wangyang25@otcaix.iscas.ac.cn>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "palmer@dabbelt.com"
 <palmer@dabbelt.com>, "daniel.barboza@oss.qualcomm.com"
 <daniel.barboza@oss.qualcomm.com>, "chao.liu@processmission.com"
 <chao.liu@processmission.com>, "liwei1518@gmail.com" <liwei1518@gmail.com>,
 "zhiwei_liu@linux.alibaba.com" <zhiwei_liu@linux.alibaba.com>
Subject: Re: [PATCH 4/5] target/riscv: gate envcfg CBO fields on extensions
Thread-Topic: [PATCH 4/5] target/riscv: gate envcfg CBO fields on extensions
Thread-Index: AQHdMwFje11UCxRBEEyyWMS2uRZXBra8YqqA
Date: Thu, 3 Sep 2026 05:23:25 +0000
Message-ID: <c0636e62d29c45d897a0ea6926d2f019b521f31e.camel@wdc.com>
References: <cover.1787489230.git.wangyang25@otcaix.iscas.ac.cn>
 <1ae52888e4d542f50a3f6e479d91d1e6d25f63c6.1787489230.git.wangyang25@otcaix.iscas.ac.cn>
In-Reply-To: <1ae52888e4d542f50a3f6e479d91d1e6d25f63c6.1787489230.git.wangyang25@otcaix.iscas.ac.cn>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.60.2 (by Flathub.org) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY1PR04MB9561:EE_|BY5PR04MB6390:EE_
x-ms-office365-filtering-correlation-id: aacc0ee4-bf35-4a91-115f-08df097b7a7e
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|10070799003|1800799024|19092799006|376014|366016|38070700021|56012099006|11063799006|4143699003|10067099003|18002099003|22082099003;
x-microsoft-antispam-message-info: TWPevJhG/IClxuuI9Set+yKxQkPUH6lthJKm9Y9YWuM9sDoR7w9T10REEt9viAXj6QpArcO+DrfRzXZeKBvcEmRXGeDkbu1g1GeJse2DuUOmdEDVJDsSoARV7DlLGqWcl5VdEByj6h/H7ou8Hic7D5IXx6XPwXPiokcy0wWADBHWtknz9QVkG37550EOSNhnfNyzSkpgtnJcQlNvK3IFrlFAqwhqBn4wql5HipcXM3KYhQ6V+MOorX6UnYjBNR6QuoCqR8Tuf1GBHcqHwiGFsmvqT3fn0h5ScOi6gQobKpGhXC0y56C+rhmebyHlyu32XRmQsLZQ8wCSZ5EweSHdmnoABfxzutYXhEAaHYUMuwHb4WVR+1dkLrJoOdIrjEHiwMxxaQOIKOaAKKauxiYGa3Zq6wF5DcL9su94z+VY2XY05VNb+NQGiPymECdkJ+8zdFpgGYrqMZWlqNWjJZ8yNroDmPUEloKiGUteYFpvdKK0CLn+LHaUJzYwFNZHflOycdJEOnfhOrMoX7rAO7Bjvao0saVKS6012P0ojrMcpG46/Twd+Xtuuis8YdB2VY7ytvBqt9EfxjXZ03OQh/iFkb9OyHDkjquTeDKYyYySQVp0lOGvOWp42lEYIM64sf7F6XVmYMglp94kWJgD/v1/E0g7o2IjhzDPeLXkduHZ0UbEkpfUV1b0j8ZEgYVRYUaVbw4YzsUh8Djy8CCfcVzTUdGQK0cxGJw6Gdd0Zh2N+Zg=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY1PR04MB9561.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(10070799003)(1800799024)(19092799006)(376014)(366016)(38070700021)(56012099006)(11063799006)(4143699003)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?L3ZUNDNFWmJvU1h3Z2sxWHJCRkNIRm5RaFFoRU14eHhQK21VKzRNTkVxWDBO?=
 =?utf-8?B?aGZBOWxtQmpMdzdjVWJWRnREQUxvUU1KZzBoSkJMMVkxUVN0OERNcWJEbW8x?=
 =?utf-8?B?bkZCYmdZTlg5YUJHa090RkVKWnhUQW8xYzhOVERKL1dTaitYWVRmUkgyWjBT?=
 =?utf-8?B?L1Q2NjQ2djdSblhoaFFzRjMxYXZqd3pnN0Y1YjRTaS9oYjl5dWhsenovOFhl?=
 =?utf-8?B?Q01WUFZVOTdpazZKK1NOZmdGNVZ1VmVJeFk4WkVwR05BQlJEaThaWWlId2dS?=
 =?utf-8?B?Smt3ZGJ3M2N6VGJNd1B5YlhjdU1oYTVWalRYWk9EZTRHMmVlZWVZQ1JmRi8y?=
 =?utf-8?B?Y0QzS3JIek52RjMyUlBFYlpMenRBc3lsMXp5b3RTOWVPQ2F1YnB3ajdENWN0?=
 =?utf-8?B?cXFxSzhlZUc1ZExwL242aU1ENXUvSDZsYWt0cEtvaG1vK0R5S0t5VXMrRHV3?=
 =?utf-8?B?dWl0eXJROCt1WjNZSmFDamVubE9lUEh0U0RmWG9ucHYxQ0IrY3RuVEp2Q29u?=
 =?utf-8?B?V0pkeUR0a1NPcDJ6bXFTTGk5d1VGRXZzK1pMYUNZT0RLOUtSTEY5dHhOQkx6?=
 =?utf-8?B?N0JUdlBqWDRpSnhjNE45bW1rMERjYll0TFNZb25iMW1GOXZ2a1piaDZkN0lw?=
 =?utf-8?B?aDg5SWtLc1RGL3RBWGFEN2JsM0xTckx2Sm9PVWNPNXpjVDd0ZGpranUxSDZ0?=
 =?utf-8?B?WnpLK2o0VzA1MVNlK0JqeUJTOWJQdGNhVVA0NGQ1OTJEb25Dc0UwQUdacEdy?=
 =?utf-8?B?R3JXbm9kRngwTnB0VWxSWEpXaGR6UG9YUWJ0WklGMm9HdDhpTm42YytldUlB?=
 =?utf-8?B?ZjhKdVhXNGY5anlNOUxQYlZUemFxR2xGTlAyUWdxT0Y3Qkt5eFhsQkdtdGlQ?=
 =?utf-8?B?U1BFbXc1bjB1SE5PSzc2WlFsOWNrSFRSblNTSTZkMzhKR1Z5QjJ5M01vN3B5?=
 =?utf-8?B?THFVbXhKcUU1eDVnZFZoelBKTzg3Vm5NRXZTS0NkUWtnSkdkRnBJeGVWSnZZ?=
 =?utf-8?B?dHF6aGNxc2cwVExzNkJnNVJPd3VUWEI2ZVp0cjdvbWRIUmxXZFVscnhFUUY4?=
 =?utf-8?B?RXh5bytuUWs3UnpVQlVZVzZIZHZTNTNwdU5Ha0h3bjVDb2lwVnMzVkRpSjdv?=
 =?utf-8?B?eFBrVThPeG9uWElvbzRXdllmTjBKcHY3MG5wVWZXZi9vSGxVenRTbDQ2V0tq?=
 =?utf-8?B?aEYvNFBEMVZMa24rdERhMDlwQThDb1kxNmtpQjNCb0ZXRXpGYzRmTnI4YmJZ?=
 =?utf-8?B?blNRUHBueDVFTlhnenM4SDhMakNoaU9FYmM4VHZIYWpNYW52THBRS0xSWDJ3?=
 =?utf-8?B?eW5QNUo4OHMxRmttWlJ4NzNSbzdmenlxaXJMdVUxWjUybW0vY2NPeUlGQ05G?=
 =?utf-8?B?UkJvQVhYT2kwbmczbnBQb041VjRGNGdoNFMyaVZ4K281b2lYS0dCblcvWTFn?=
 =?utf-8?B?UzQ1aysraEtwUERkK1RHWkdVQXBVakxKMVM4YkN4TzNrZ0VFaEkwVDBPUlFn?=
 =?utf-8?B?VzhIMGhERHJpdFoyTjNYSkswcWdqWFNBSnlmM2tZSElFZFpxTDV1a0Z2N1dL?=
 =?utf-8?B?RUovWjhONUF6WjljVVN2SWlHRldpNHExQ1c5OFJSWDRzUUNvYlRSQld3UkNn?=
 =?utf-8?B?VlIyZzRCbHlKQkFGcXFDcXlFRVU0VkgvTk15V1BaMldDYXdZUTJMZ09aUk4y?=
 =?utf-8?B?cmQ5RjVCY0t4MlhUTWZ2T2hGNWQvcWFRK3BCM2FwSTN6bitOdEVQUk9LZHdj?=
 =?utf-8?B?eGVreXJNdzc1NWl1ZUY2UmNMQ28yWndLb0ptYXltaTBIZXV3cE5hN3NCWXpp?=
 =?utf-8?B?eVZIYVlTQVF6cFkyZndsZFhqdGhqaHhiallLUU1ydUZLMGhERFpORXlkaXJr?=
 =?utf-8?B?bzA2cVpsblozTlhyY2trdTlDOS9zU1NxUmpEYk0xNTdqd1FSOUdpZy83V2lJ?=
 =?utf-8?B?cXJlSjdmUVdsVFdJYkdGUHJ1Q2h4VXdCS2JpOVU4V3pYc1Jlc0xUc2c2VS91?=
 =?utf-8?B?UTJnT3h0Y2E5REt5eXVhVitCREVWSGlMTUtiNUxyUDJHeVJoemxvUEI2dkdn?=
 =?utf-8?B?YmQwbm56MkJlNVVhcE5HRDlsaWVwdlUzbFhVQXdDT3hxTi8rZ21oeWt2MlpX?=
 =?utf-8?B?U2xaMW5oU0F4Y2c5QTJONmIzS0JDZlh2bFVLNitzWnNqNzVtZVQzYTRESUpz?=
 =?utf-8?B?R3RrVWNyODJsVmhNR2NRMnBZVFpWQUt3NWJldFVqbm14SlZvbC8rQ0FMd2FQ?=
 =?utf-8?B?Y3NjYjgwbGlCK01PNWx5UVVkMWlYZjNzVmRWd2p4SjFHNWt4VXNndmJDaVRm?=
 =?utf-8?B?ZGltMk1uaTRDeHpYMFBoWkV0c0pYOWUxd082SHpRdVRhekxKNEoxdk9BZStV?=
 =?utf-8?Q?mXYQ9g/uUWgQc7qGM5J4/6zJj2XYGni9EmfJkGs3+EKUH?=
x-ms-exchange-antispam-messagedata-1: 79Kf6oAhJ0s7XDpnb4gC52nXW6tN2Wuz26c=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B297C9E00F4AE14C9E3BC51BC7BEDA26@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: mFVUjQHd7n5kTUX1xnu856VIdAboT3d6pisewFluw3uxMIafY20l5+N0p+bNfZFBPsys/1BSDojOVE6oIdT8NIQWZ+AYu5PulPVDA6d4KH0RYiiYfTO17zCypV4Q6J1sZ6TK57T+QjBZ64QFcQkNLiKf82jfGrXt98UwDVlsn/4ALjPWODj3WaxgOGvm+YT50nwW5y1zuqjef/fGVXB6Lg24OUfkEYaEbSpqfU6aGqqI0/KxpBozP9+ERdDt1ic5zzINAaW5jMRrIXCkRyl2OL4C4CrVqz4yx1uvzt/q8DiYdRqEN/K7DdOUgUolBG+BejMSmHw4i9sUEvo8hCnsYg==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: ZioY1I+NpGZG+KQaRJVJIhDvAB/Voyud8761YZ+RPuIUZ3zBezfFsFCIyr7FvIV55mbr0GbChwAm0AAkgDkTdC/SucUntska/Vv3wVpWU+qCQB9mzB4GbOOVbWF93jgYrAtXMZP+/pGmqZxB9xHLg4PScmaHXsCsaL/x81KI0PRjmGmlkU2uchSeBimcHH/C0ZERi0oPIa2Lq3av/yIQb54dbsKuKkp9M7itSnd7xEQ+k8xzUmHnU0f0AWkY5idwIncNFSICv2ZPzXf40P7jObECktdPjHFtZa8jd7LzWgMTkB53FuEyiRVHozTepLaqxmwVZnFj5ylZelxuMgHTNT67s6E6zsbLldKfSSCmplDIwGCI5gFeJYZqm8DW5oSItEx67CQaFxymTi8lJ/zPwik4B3OUESmFIaNOW6k4rwA9iJS63kF7XVWdiwpocL/Fwm+cqViRaXR5LOh+MbWICy5lOfYnRUBVZa2dVti3veWhA2xE8FaBQzarSRJfyPKSWT2j2fexVd1SDpnglEP0A0Ty6R1ZxHQ5z+pyv+/eeeDJfsX9wGAj6q7fHHmtE0pue0hQiIVRSsBOmLZ16JQiLOEiFHeEd3gD8zm/jUnAS4eu4/lOSUqGlH0GXK5glhFN
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY1PR04MB9561.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aacc0ee4-bf35-4a91-115f-08df097b7a7e
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Sep 2026 05:23:25.0514 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +yGqRDYEHUi16m+hGEc0eA+2qebGsUw70TzFsf1zRbQpquubO7CYqB4xZMCP7kSlm0sC9kJ3cNriBFVrqZNIrBABwIwo1d/2lHM4O8rLy3Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB6390
Received-SPF: pass client-ip=68.232.143.124;
 envelope-from=prvs=6997dc6e7=Alistair.Francis@wdc.com;
 helo=esa2.hgst.iphmx.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

T24gU3VuLCAyMDI2LTA4LTIzIGF0IDIxOjE0ICswODAwLCB3YW5neWFuZzI1QG90Y2FpeC5pc2Nh
cy5hYy5jbiB3cm90ZToKPiBUaGUgZW52Y2ZnIENCTyBmaWVsZHMgYXJlIHByb3ZpZGVkIGJ5IFpp
Y2JvbSBhbmQgWmljYm96LiBLZWVwIHRoZW0KPiByZWFkLW9ubHkgemVybyB3aGVuIHRoZSBjb3Jy
ZXNwb25kaW5nIGV4dGVuc2lvbiBpcyBhYnNlbnQgaW4gYWxsCj4gdGhyZWUKPiBlbnZjZmcgQ1NS
cy4KPiBSZXNvbHZlczogaHR0cHM6Ly9naXRsYWIuY29tL3FlbXUtcHJvamVjdC9xZW11Ly0vd29y
a19pdGVtcy80MjI1Cj4gCj4gU2lnbmVkLW9mZi1ieTogd2FuZ3lhbmcgPHdhbmd5YW5nMjVAb3Rj
YWl4LmlzY2FzLmFjLmNuPgoKUmV2aWV3ZWQtYnk6IEFsaXN0YWlyIEZyYW5jaXMgPGFsaXN0YWly
LmZyYW5jaXNAd2RjLmNvbT4KCkFsaXN0YWlyCgo+IC0tLQo+IMKgdGFyZ2V0L3Jpc2N2L3RjZy9j
c3IuYyB8IDM4ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKystLS0tCj4gwqAxIGZp
bGUgY2hhbmdlZCwgMzQgaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkKPiAKPiBkaWZmIC0t
Z2l0IGEvdGFyZ2V0L3Jpc2N2L3RjZy9jc3IuYyBiL3RhcmdldC9yaXNjdi90Y2cvY3NyLmMKPiBp
bmRleCA3MDc4NzM2Li5mZDAwNTM4IDEwMDY0NAo+IC0tLSBhL3RhcmdldC9yaXNjdi90Y2cvY3Ny
LmMKPiArKysgYi90YXJnZXQvcmlzY3YvdGNnL2Nzci5jCj4gQEAgLTMyMTIsMTAgKzMyMTIsMTkg
QEAgc3RhdGljIFJJU0NWRXhjZXB0aW9uCj4gd3JpdGVfbWVudmNmZyhDUFVSSVNDVlN0YXRlICpl
bnYsIGludCBjc3JubywKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgdGFyZ2V0X3Vsb25nIHZhbCwgdWludHB0
cl90IHJhKQo+IMKgewo+IMKgwqDCoMKgIGNvbnN0IFJJU0NWQ1BVQ29uZmlnICpjZmcgPSByaXNj
dl9jcHVfY2ZnKGVudik7Cj4gLcKgwqDCoCB1aW50NjRfdCBtYXNrID0gTUVOVkNGR19GSU9NIHwg
TUVOVkNGR19DQklFIHwgTUVOVkNGR19DQkNGRSB8Cj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIE1FTlZDRkdfQ0JaRTsKPiArwqDCoMKgIHVpbnQ2NF90IG1hc2sgPSBN
RU5WQ0ZHX0ZJT007Cj4gwqDCoMKgwqAgYm9vbCBzdGNlX2NoYW5nZWQgPSBmYWxzZTsKPiDCoAo+
ICvCoMKgwqAgLyogQ0JJRS9DQkNGRSBhcmUgcmVhZC1vbmx5IHplcm8gd2hlbiBaaWNib20gaXMg
bm90IGltcGxlbWVudGVkLgo+ICovCj4gK8KgwqDCoCBpZiAoY2ZnLT5leHRfemljYm9tKSB7Cj4g
K8KgwqDCoMKgwqDCoMKgIG1hc2sgfD0gTUVOVkNGR19DQklFIHwgTUVOVkNGR19DQkNGRTsKPiAr
wqDCoMKgIH0KPiArCj4gK8KgwqDCoCAvKiBDQlpFIGlzIHJlYWQtb25seSB6ZXJvIHdoZW4gWmlj
Ym96IGlzIG5vdCBpbXBsZW1lbnRlZC4gKi8KPiArwqDCoMKgIGlmIChjZmctPmV4dF96aWNib3op
IHsKPiArwqDCoMKgwqDCoMKgwqAgbWFzayB8PSBNRU5WQ0ZHX0NCWkU7Cj4gK8KgwqDCoCB9Cj4g
Kwo+IMKgwqDCoMKgIGlmIChyaXNjdl9jcHVfbXhsKGVudikgPT0gTVhMX1JWNjQpIHsKPiDCoMKg
wqDCoMKgwqDCoMKgIG1hc2sgfD0gKGNmZy0+ZXh0X3N2cGJtdCA/IE1FTlZDRkdfUEJNVEUgOiAw
KSB8Cj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgKGNmZy0+ZXh0X3NzdGMgPyBN
RU5WQ0ZHX1NUQ0UgOiAwKSB8Cj4gQEAgLTMzMTksOCArMzMyOCwxOSBAQCBzdGF0aWMgUklTQ1ZF
eGNlcHRpb24KPiByZWFkX3NlbnZjZmcoQ1BVUklTQ1ZTdGF0ZSAqZW52LCBpbnQgY3Nybm8sCj4g
wqBzdGF0aWMgUklTQ1ZFeGNlcHRpb24gd3JpdGVfc2VudmNmZyhDUFVSSVNDVlN0YXRlICplbnYs
IGludCBjc3JubywKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgdGFyZ2V0X3Vsb25nIHZhbCwgdWludHB0cl90
IHJhKQo+IMKgewo+IC3CoMKgwqAgdWludDY0X3QgbWFzayA9IFNFTlZDRkdfRklPTSB8IFNFTlZD
RkdfQ0JJRSB8IFNFTlZDRkdfQ0JDRkUgfAo+IFNFTlZDRkdfQ0JaRTsKPiArwqDCoMKgIHVpbnQ2
NF90IG1hc2sgPSBTRU5WQ0ZHX0ZJT007Cj4gwqDCoMKgwqAgUklTQ1ZFeGNlcHRpb24gcmV0Owo+
ICsKPiArwqDCoMKgIC8qIENCSUUvQ0JDRkUgYXJlIHJlYWQtb25seSB6ZXJvIHdoZW4gWmljYm9t
IGlzIG5vdCBpbXBsZW1lbnRlZC4KPiAqLwo+ICvCoMKgwqAgaWYgKGVudl9hcmNoY3B1KGVudikt
PmNmZy5leHRfemljYm9tKSB7Cj4gK8KgwqDCoMKgwqDCoMKgIG1hc2sgfD0gU0VOVkNGR19DQklF
IHwgU0VOVkNGR19DQkNGRTsKPiArwqDCoMKgIH0KPiArCj4gK8KgwqDCoCAvKiBDQlpFIGlzIHJl
YWQtb25seSB6ZXJvIHdoZW4gWmljYm96IGlzIG5vdCBpbXBsZW1lbnRlZC4gKi8KPiArwqDCoMKg
IGlmIChlbnZfYXJjaGNwdShlbnYpLT5jZmcuZXh0X3ppY2Jveikgewo+ICvCoMKgwqDCoMKgwqDC
oCBtYXNrIHw9IFNFTlZDRkdfQ0JaRTsKPiArwqDCoMKgIH0KPiArCj4gwqDCoMKgwqAgLyogVXBk
YXRlIFBNTSBmaWVsZCBvbmx5IGlmIHRoZSB2YWx1ZSBpcyB2YWxpZCBhY2NvcmRpbmcgdG8gWmpw
bQo+IHYxLjAgKi8KPiDCoMKgwqDCoCBpZiAoZW52X2FyY2hjcHUoZW52KS0+Y2ZnLmV4dF9zc25w
bSAmJgo+IMKgwqDCoMKgwqDCoMKgwqAgcmlzY3ZfY3B1X214bChlbnYpID09IE1YTF9SVjY0ICYm
Cj4gQEAgLTMzNzcsNyArMzM5Nyw3IEBAIHN0YXRpYyBSSVNDVkV4Y2VwdGlvbgo+IHdyaXRlX2hl
bnZjZmcoQ1BVUklTQ1ZTdGF0ZSAqZW52LCBpbnQgY3Nybm8sCj4gwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHRh
cmdldF91bG9uZyB2YWwsIHVpbnRwdHJfdCByYSkKPiDCoHsKPiDCoMKgwqDCoCBjb25zdCBSSVND
VkNQVUNvbmZpZyAqY2ZnID0gcmlzY3ZfY3B1X2NmZyhlbnYpOwo+IC3CoMKgwqAgdWludDY0X3Qg
bWFzayA9IEhFTlZDRkdfRklPTSB8IEhFTlZDRkdfQ0JJRSB8IEhFTlZDRkdfQ0JDRkUgfAo+IEhF
TlZDRkdfQ0JaRTsKPiArwqDCoMKgIHVpbnQ2NF90IG1hc2sgPSBIRU5WQ0ZHX0ZJT007Cj4gwqDC
oMKgwqAgUklTQ1ZFeGNlcHRpb24gcmV0Owo+IMKgwqDCoMKgIGJvb2wgc3RjZV9jaGFuZ2VkID0g
ZmFsc2U7Cj4gwqAKPiBAQCAtMzM4Niw2ICszNDA2LDE2IEBAIHN0YXRpYyBSSVNDVkV4Y2VwdGlv
bgo+IHdyaXRlX2hlbnZjZmcoQ1BVUklTQ1ZTdGF0ZSAqZW52LCBpbnQgY3Nybm8sCj4gwqDCoMKg
wqDCoMKgwqDCoCByZXR1cm4gcmV0Owo+IMKgwqDCoMKgIH0KPiDCoAo+ICvCoMKgwqAgLyogQ0JJ
RS9DQkNGRSBhcmUgcmVhZC1vbmx5IHplcm8gd2hlbiBaaWNib20gaXMgbm90IGltcGxlbWVudGVk
Lgo+ICovCj4gK8KgwqDCoCBpZiAoY2ZnLT5leHRfemljYm9tKSB7Cj4gK8KgwqDCoMKgwqDCoMKg
IG1hc2sgfD0gSEVOVkNGR19DQklFIHwgSEVOVkNGR19DQkNGRTsKPiArwqDCoMKgIH0KPiArCj4g
K8KgwqDCoCAvKiBDQlpFIGlzIHJlYWQtb25seSB6ZXJvIHdoZW4gWmljYm96IGlzIG5vdCBpbXBs
ZW1lbnRlZC4gKi8KPiArwqDCoMKgIGlmIChjZmctPmV4dF96aWNib3opIHsKPiArwqDCoMKgwqDC
oMKgwqAgbWFzayB8PSBIRU5WQ0ZHX0NCWkU7Cj4gK8KgwqDCoCB9Cj4gKwo+IMKgwqDCoMKgIGlm
IChyaXNjdl9jcHVfbXhsKGVudikgPT0gTVhMX1JWNjQpIHsKPiDCoMKgwqDCoMKgwqDCoMKgIG1h
c2sgfD0gZW52LT5tZW52Y2ZnICYgKEhFTlZDRkdfUEJNVEUgfCBIRU5WQ0ZHX1NUQ0UgfAo+IEhF
TlZDRkdfQURVRSB8Cj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBIRU5WQ0ZHX0RURSk7Cg==

