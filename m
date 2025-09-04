Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DCCACA1010
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Sep 2025 02:46:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utzyr-000638-AM; Wed, 03 Sep 2025 22:45:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1utzyi-00062G-RG
 for qemu-devel@nongnu.org; Wed, 03 Sep 2025 22:45:38 -0400
Received: from mgamail.intel.com ([198.175.65.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1utzyd-0003df-To
 for qemu-devel@nongnu.org; Wed, 03 Sep 2025 22:45:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1756953932; x=1788489932;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=d7kVf5Rnh7VrbuL9TE9wyleMAuzZmTImwaWnngMMHOw=;
 b=gmL4dcmYPLqFJjsj1WpQFNinU4FAGuMm5mB25r15WlwhluzfegisXdjb
 0mGaDpDRxMKKwUiEmllAt7zdGUPWSzPpiyFggiBhiWuBBn+oCiWVGVfHX
 U98Rt6kMu6g3Vda9QKbeohLTa6vxZwkZwtBXexkKGSDn2me3qtpGY6QkU
 EAGLHfqRq3e7bYkZ4uY75BL0/58+Qd21cEwz8iFi0rQwerN3ItY3zcU7f
 xytgDP5ukpL3sJUI1FBBR5EMGrV8P5wMJF6tjzYgsIqrAU35oYEmmiKx7
 /wRjHfM9P+C5hGkuXn0Of4FHKXOZJ8gd+c1tbmW1Tld+hud+5QQnsPg// A==;
X-CSE-ConnectionGUID: rYlYlQzMQlWbG5BqqoJ81w==
X-CSE-MsgGUID: zmRG6RxFT+qGjGjiqLdJGg==
X-IronPort-AV: E=McAfee;i="6800,10657,11542"; a="76731005"
X-IronPort-AV: E=Sophos;i="6.18,237,1751266800"; d="scan'208";a="76731005"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Sep 2025 19:45:21 -0700
X-CSE-ConnectionGUID: VwC9mOBJSoGeGnFvp+31Pw==
X-CSE-MsgGUID: n5oairJoR9Cya//Bn8iZmA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,237,1751266800"; d="scan'208";a="208952464"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Sep 2025 19:45:21 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 3 Sep 2025 19:45:20 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Wed, 3 Sep 2025 19:45:20 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (40.107.93.45) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 3 Sep 2025 19:45:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EetCaMdik28NRCC7fETLF13J2Z4n+bmdlX9UeubEbolSNbC7moMxSipjceheEkDwjx2IrRTzoFmZOiKs8UlDZ+qlcxvTzHw7LusC4ug7tF1ZWDTU3eqzA+zXnzlJKWseO0BnAiAFfD4XlwAMOwcd0cDLihrUzrXI7O43MuDjGUJeohlufHq7M7J0cdQWE7B9n1u+VAZQnHQxEObcd7jtpud8OKqYXy64UN1OxgJY2Lzl+SL9L+qh2QrjV7WG4Y4I/8Wa4xmfCvdcyNsrrP9HUB6aIYXq/Pw5ysnrLU3fnbkc3AnuWOhlAq5jPKUIMtXHHeJM4MSSfViAk5GLC0boZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d7kVf5Rnh7VrbuL9TE9wyleMAuzZmTImwaWnngMMHOw=;
 b=GDmF5XdzAvwLQGlMT4VRjlEvDVg6C8Sj6d9c6VwqeSndYeL5TNwGDCU7djYdTJEW65M9ZqCjEo85rGAOMUT0/ahbilqqGim447qKFEQccNgVCJUUso/fndcb8IM0tTU8fogNeYeYRuneoDJ8bNYG6ig50A3AZ+AOtntGJ6yrBq8pIvSEtqhyynFdPWWYFnXwBJ3ohaWDQVJHrin49ufPuNN48CdL8F+ExlkPZfwlmVBGm/lpRLafwPljt2IVxivw59vAn9IL06xCKpvkjuNIc9CintH/XLbXo1TQlnNvIZqUTsjmytq1VmxnZjwnAOTgD2UJYofF5m+WcIVIw2t5zQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12)
 by SJ0PR11MB5072.namprd11.prod.outlook.com (2603:10b6:a03:2db::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.16; Thu, 4 Sep
 2025 02:45:09 +0000
Received: from IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13]) by IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13%4]) with mapi id 15.20.9073.026; Thu, 4 Sep 2025
 02:45:09 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: "Liu, Yi L" <yi.l.liu@intel.com>, "eric.auger@redhat.com"
 <eric.auger@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>, "mst@redhat.com" <mst@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>, "peterx@redhat.com"
 <peterx@redhat.com>, "ddutile@redhat.com" <ddutile@redhat.com>,
 "jgg@nvidia.com" <jgg@nvidia.com>, "nicolinc@nvidia.com"
 <nicolinc@nvidia.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "clement.mathieu--drif@eviden.com"
 <clement.mathieu--drif@eviden.com>, "Tian, Kevin" <kevin.tian@intel.com>,
 "Peng, Chao P" <chao.p.peng@intel.com>, Yi Sun <yi.y.sun@linux.intel.com>
Subject: RE: [PATCH v5 12/21] intel_iommu: Handle PASID entry addition
Thread-Topic: [PATCH v5 12/21] intel_iommu: Handle PASID entry addition
Thread-Index: AQHcEy/rlmycm26h6E2RTREw7vW8qLR2txwAgAdZPSCAAyl9gIABKpsQ
Date: Thu, 4 Sep 2025 02:45:09 +0000
Message-ID: <IA3PR11MB9136056A8DD8171A908E99059200A@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <20250822064101.123526-1-zhenzhong.duan@intel.com>
 <20250822064101.123526-13-zhenzhong.duan@intel.com>
 <5b25de4b-ae84-4926-9e14-2ab4262e973f@redhat.com>
 <IA3PR11MB91364DF170025220D3168E4B9207A@IA3PR11MB9136.namprd11.prod.outlook.com>
 <c1fe5251-4151-43f1-b152-4c0f1be8592d@intel.com>
In-Reply-To: <c1fe5251-4151-43f1-b152-4c0f1be8592d@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9136:EE_|SJ0PR11MB5072:EE_
x-ms-office365-filtering-correlation-id: c38f1f59-5bbe-47d3-54b6-08ddeb5d102d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|7416014|366016|1800799024|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?VElXZk9JcTVsc2doY1A4VHEwUnF3TTBaTWpEL2l6cFQva1F5cHZ3bW1kZ0dT?=
 =?utf-8?B?ZHF0WWZSR2xsQUw1UldYQThncTgwZ1VqQkh0R0hqUldnRlhLQmtKWVNsdEs3?=
 =?utf-8?B?aDlKdUIzSm4yOUozTTVkY1g2VDBGRjZsMGUvclVpTDZJQ1ZFWnVzNWhydXlG?=
 =?utf-8?B?ZVM5cldaTGd4ajZ4aHFnRTlIWFZLS25kOS9QeVNybXBrYlkzRUhjMVFOZ0x2?=
 =?utf-8?B?K3VqMEFlaW94bTVSQkRHZUNrbGwwSzVEOGNWdElQNWdRR0R0UUFGRWduUDRi?=
 =?utf-8?B?S3FCQlN1NTZsRERhSUdsTHJQK1NGdWhPR1M5THd2akJrdU1oSnBrZE93WER4?=
 =?utf-8?B?Tk9oY1QzL1IxaVVnNzgrRFZBRld6b2dldHYxK2srN09GaHZaUEpZZmUwc1dJ?=
 =?utf-8?B?QlZ6b3YvZVJWVzUwRW5sT0FkZFM5MUxVa3hNR3R2TjRmZEVhMmNyR2c3ODVB?=
 =?utf-8?B?dGNPSklJNW9yT0VNbE12L0VYVWJib2o3ekI2ek1jQnFUeFlPTzV5Y0dHNmEz?=
 =?utf-8?B?Y2ZTRDNaOHF0cTc0em8yYUZzcEYwbTRDY2hxZVM0aEJxM2RqelJDYXdDNExF?=
 =?utf-8?B?SmlHTUJjR2R0eUF1VlB5VFhucjFmSWtFczVnamVlLzU0YUhoc3VOODhBYXVj?=
 =?utf-8?B?eTdFcnZMeUlQc0lGVmlYaGw4UUlLanBrZDVVc2gyN1hveVIyMk40UmZyR1h3?=
 =?utf-8?B?Wjgra25HWkY1OFAxcVhSdkhrM01ZVUhrZ2tqVXBPYW1FVmg5eEUzR0JZY2JQ?=
 =?utf-8?B?TVBkT1hRODh6Szd2a3RmaFdFTHo3MVhnWXhTUDVtME5RRllIZmxncGpIZjZH?=
 =?utf-8?B?K0o0WGJjb0FNN2dFMS90YVhmZ2V5dEpOWW8zazVGNld4UUZTVHFUckdGY09R?=
 =?utf-8?B?Y1Z6ZVQ4THd4OEw3NFhHbDhHemN4ampwWEl3K2htOWxCYXdJNjdTcEtObmR2?=
 =?utf-8?B?dmtrSU1XeFdENVdjaStQSXZqWnV3VlVPSmN1QlVFdTNKYmFNd3E2ejFLbjZj?=
 =?utf-8?B?SVBXNDJwSUJXMHhvbG15VytTVWw2WGV1b3Y0S1N2NUdJa3ZtSWxRNGMzYTQ2?=
 =?utf-8?B?NERqNy92Y1RTK3pYMHgvSkNQdFRQeCtoelg0cW1ITWFFVnZZSmxZcFBROUtO?=
 =?utf-8?B?dWJsdXU2Z21QdStXTCtLUVl5ajYzbm1CQ0ZMSWxXc1ZTeEUwcVEvL1E3Y1Zt?=
 =?utf-8?B?U0lTZFJRYzJOQXNUOTNveU1NMXdUMDFVdEJodnAvMkh4dWtqZ0tnaGlPUGt2?=
 =?utf-8?B?OXZpbm9rZVBqS2R5QWRpRUszdjZOMXRmZ2FLY1dOU1FRa0FHRGVkTDJTaHNL?=
 =?utf-8?B?TkJUSzZqRE9sZTM4aGpNQWN3OGcxNTY3MEN6c2gxdEtWSmFyNU5XcWovSTRN?=
 =?utf-8?B?ZE53ZG5XQWtNd0hIMm5JR3FkQ003MWhFb1VNOHF5NmVTeGlSRGQzUkhEeENz?=
 =?utf-8?B?SmV6SVpFWG5qall6V051ZGdZWTl1d2JGempkODkvQmR0VXhOZGpHVEZaMEp0?=
 =?utf-8?B?NndKZHdoY3psaTNCNTJPY0k1VGhac21mUHd5SUpBL0N2c0FWSXc3QUZFVWsr?=
 =?utf-8?B?Ujc0MVRaMmh5bHVhU0VpQ0YrRDgrWHVjMEhOVm5FanhSQnpxVmZyVE5vQ2Zs?=
 =?utf-8?B?cGhBclFYcEZ1NGhBaFQ3b3dDMjVXMkN2VElSdlNEYmRFenlIYnRKWUM4M01P?=
 =?utf-8?B?QjBkWXd1ZE9DcmhJS1pkSk0wdzZ5cHVXWmdoL25VbHhCeXAvQ1piU2VkOGM1?=
 =?utf-8?B?YzFlVnVqYUFXbDUxTERFQUFEcmwvdVpLcU1TK2lwL3d0VkJUWGhHNTJzRjEx?=
 =?utf-8?B?RW0rTHF0bE1vTVZxUGdjM3RsSTRHTlcwdVhZbXA3dWFBb0grT0Y3d0xvUEQ0?=
 =?utf-8?B?NmljbndqMDcrbDkzWmRGOVBBdEdqSzlJYTJybDYyY0dHV09uR3IyVUcrMG5N?=
 =?utf-8?B?N2hzMGFRa3lkZGxFY0lLTFlBZE4rUTd1cFJreE9ENWFkT0E2TEQrV1VRUUZ1?=
 =?utf-8?B?RVlFaDZRanVBPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9136.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TlZVNmExcXRnWTZjallNQ3B1SE5iS2p5K3FYNXh2cEkwYnV1cGFLd0phMGc2?=
 =?utf-8?B?NTRiKzg1eVA3YzdaK3dRUmdDSHAvNm1oVmRzOWUvOTRLNkhkVTdKL2NBcm8x?=
 =?utf-8?B?VTJMcFNYdTg2T2I2eEt0QlJzSk9nTWtjVi93eDNTb0VsVGRwRi9Sd2RBRnZ4?=
 =?utf-8?B?dWs4YWdYTzVjaTJnWU1YV2tIWWUrdDg2Yjl3VnJpMWszNkwySTdxZ2FteG8y?=
 =?utf-8?B?Q0V6dnRVZEhTdGZzazFtWmtXbUovZ2hoM2tyM2pCeDd3TDErRFFvZzFYT2FT?=
 =?utf-8?B?R1VraVduYXU5S0xJTXBJTEk5ZUNBeUh3RnNKNGhHTDlGM21aTU5aTjRUcWRv?=
 =?utf-8?B?dnIrOXBsMkFvRHF6NjNhZmRKamc4Z0xweTJKMzZrU2JwWFJqMlFlSXVxYWFo?=
 =?utf-8?B?Yms3RzhKS0tyZ0JLRGVFbkRKd1NYamIzMzJ3QS8zekZIRE1NL0h2R2d6Nm53?=
 =?utf-8?B?Kzg1aVZPb29wVzZjVGtZRzNsdVJUUitSblhadi9iaEhmdFNwdzZ2R1p3eWFK?=
 =?utf-8?B?RWIwdVFCb3BKUlBHQnNHKzJVTEw5REpaYlZkWFRWQ1c3aFRoNjJ0dVE5c2dP?=
 =?utf-8?B?a3BiVGtOM0VOd0phZUxZQnVIeGtPTTZMUTJWdmdZUW1NTHdoOFR3RUdtL3Qr?=
 =?utf-8?B?QS9heDEyM3ZjenU3Z1cyMDEwMVVYWlNaMjd3cjcrMXBXOXF0WDBreDkzaHFk?=
 =?utf-8?B?bldVS2hwcjVQeTFzY0FieWVCWlFyYXB6UjBJUHVGT1FtNzhZU0pVYjhPTHFI?=
 =?utf-8?B?YmhiTGNXY0tiUnZLSHNYQ2xhY29KcDB1TVVzY0haYXQ2MXlaVU1kYXhUcHk4?=
 =?utf-8?B?ZlV0TVJQSG1iT2NtemNsaXhiZGRRcFZDcEhxRjZtdG1vbjAvaGw2S3F2UUpq?=
 =?utf-8?B?aXpBN0ZEUHZEbmhUM0tTTW9URlgwLzh4Wk0xbmtiNGc1TGFUT2N5L2R2NGEy?=
 =?utf-8?B?ZUdzRjdXYUh5bUZxUjR2MGF3cHBmMlMzaEUxU2NTd2lJSXBsb2lsN3BpNTFZ?=
 =?utf-8?B?a0hZNXdycGFsaXQ5ZFBYVHppcElqWDZ2OWVZWUE4MWxiN01zdXZlcko2bHhl?=
 =?utf-8?B?eW1Xa0dPZnVGZXdtcjBwRzlsUS9hUVV5ZGRZSS9PWnliV3JhUHRXWm50NUlS?=
 =?utf-8?B?a25qYkxGYU45RlgyU1NsZGxSdlpJTWtnRnRkRWd5RzdQMFdoWGx5VXJzdlh2?=
 =?utf-8?B?VHRRWHNtamQxOFArTFhSYnRpNDA3RnFCV3hCeDBVWElNd2FUc25uLzdnclJ4?=
 =?utf-8?B?NXhLb25rbVJRL3hLVks2K1J2bXAvNHp0c244cFNJT245enUrTTdtUUNMYXVl?=
 =?utf-8?B?UmFMc2lyM1BOWXZpdGdqbXI0TS9DTWhTbDg0bi9SQjBVWktySmdIdlBZUlVi?=
 =?utf-8?B?SjRwS0c2TzRSN0pXaWxGOVpHQk1BUE1OUkYvZVBqZjBEdjU3SmhidEY2dFRL?=
 =?utf-8?B?emxPcHpYeXdobFZ4cEdIRTRuRGVEaHc4VXhSUGl0N1JoNkRuQzFzZzFhekhm?=
 =?utf-8?B?UlVpTEt5eG1Yc1M4STVKNG9CRVArRGpza3JOSnFNSHc3UnI3WTAxZGZVbmtm?=
 =?utf-8?B?Uko4d2g0MFdrTW9wRWdRUWJIbnNBSnExeTF3ZVMxRTdNZmZhdEJLZXBVYnlX?=
 =?utf-8?B?Z3pHaGZmODdXeGN5UURmeEExVWViNTRHZElFOFRGVkJucUpybm1SZDJla2tq?=
 =?utf-8?B?NHFBSTVsN3hsWUNjWGc0T0VaYmlZdFducUNSVUlvM20yMzJ0MFRnWWFxM0pv?=
 =?utf-8?B?YmJJWGViUExYQkdmcE40am94dDR3RWFFTGVsaUI3M1I4SCt6dnoxTXNZNTZN?=
 =?utf-8?B?OFNSREx3em1zblZHQzFTaFR6NlhZVHhDWWgzL0g5d2tVS3BKOExQUlZuSFZM?=
 =?utf-8?B?TENmMGt4NXBlandJTnlmeFQ0YWU2Y2EzRWl5UTUwd1ZyaFd2S1g3dGswZDVF?=
 =?utf-8?B?TGtiSlJ0Y0JXWFd5aTM2OFdWRWllWXNOT1gxbjIwcmZJSE03eTlxZGVPTGRB?=
 =?utf-8?B?b2FkY0xMM2dDNU45bUw5cWpOMVp3S3dDa0wzUFYzK2JReXY3ajhCSjd6Q1Bp?=
 =?utf-8?B?bHFGN2RyMHNjN3VIbzRYQzJERDhsblNqK2ZCRVRuKy9SRDlUQXgxcUhpQXYr?=
 =?utf-8?Q?FAIKzNwiN8/CfMtnV7UuD9UA5?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9136.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c38f1f59-5bbe-47d3-54b6-08ddeb5d102d
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Sep 2025 02:45:09.2222 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: f6lH1FdLF8ngpM2tpFq+scH8eNa86RaZCBQ6NC00KceIsjDXm8gQQpKTyN07LBunjFwMDFmIZLHgjUXcaaatXQfrXWofpJfkQFqRToa7c2U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5072
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.10;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IExpdSwgWWkgTCA8eWkubC5s
aXVAaW50ZWwuY29tPg0KPlN1YmplY3Q6IFJlOiBbUEFUQ0ggdjUgMTIvMjFdIGludGVsX2lvbW11
OiBIYW5kbGUgUEFTSUQgZW50cnkgYWRkaXRpb24NCj4NCj5PbiAyMDI1LzkvMSAxNzowMywgRHVh
biwgWmhlbnpob25nIHdyb3RlOg0KPg0KPj4+PiAgIH0NCj4+Pj4NCj4+Pj4gKy8qDQo+Pj4+ICsg
KiBUaGlzIGZ1bmN0aW9uIHdhbGtzIG92ZXIgUEFTSUQgcmFuZ2Ugd2l0aGluIFtzdGFydCwgZW5k
KSBpbiBhIHNpbmdsZQ0KPj4+PiArICogUEFTSUQgdGFibGUgZm9yIGVudHJpZXMgbWF0Y2hpbmcg
QGluZm8gdHlwZS9kaWQsIHRoZW4gcmV0cmlldmUvY3JlYXRlDQo+Pj4+ICsgKiB2dGRfYXMgYW5k
IGZpbGwgYXNzb2NpYXRlZCBwYXNpZCBlbnRyeSBjYWNoZS4NCj4+Pj4gKyAqLw0KPj4+PiArc3Rh
dGljIHZvaWQgdnRkX3NtX3Bhc2lkX3RhYmxlX3dhbGtfb25lKEludGVsSU9NTVVTdGF0ZSAqcywN
Cj4+Pj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBkbWFfYWRkcl90
IHB0X2Jhc2UsDQo+Pj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
aW50IHN0YXJ0LA0KPj4+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IGludCBlbmQsDQo+Pj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
VlREUEFTSURDYWNoZUluZm8NCj4+PiAqaW5mbykNCj4+Pj4gK3sNCj4+Pj4gKyAgICBWVERQQVNJ
REVudHJ5IHBlOw0KPj4+PiArICAgIGludCBwYXNpZCA9IHN0YXJ0Ow0KPj4+PiArDQo+Pj4+ICsg
ICAgd2hpbGUgKHBhc2lkIDwgZW5kKSB7DQo+Pj4+ICsgICAgICAgIGlmICghdnRkX2dldF9wZV9p
bl9wYXNpZF9sZWFmX3RhYmxlKHMsIHBhc2lkLCBwdF9iYXNlLCAmcGUpDQo+Pj4+ICsgICAgICAg
ICAgICAmJiB2dGRfcGVfcHJlc2VudCgmcGUpKSB7DQo+Pj4+ICsgICAgICAgICAgICBpbnQgYnVz
X24gPSBwY2lfYnVzX251bShpbmZvLT5idXMpLCBkZXZmbiA9IGluZm8tPmRldmZuOw0KPj4+PiAr
ICAgICAgICAgICAgdWludDE2X3Qgc2lkID0gUENJX0JVSUxEX0JERihidXNfbiwgZGV2Zm4pOw0K
Pj4+PiArICAgICAgICAgICAgVlREUEFTSURDYWNoZUVudHJ5ICpwY19lbnRyeTsNCj4+Pj4gKyAg
ICAgICAgICAgIFZUREFkZHJlc3NTcGFjZSAqdnRkX2FzOw0KPj4+PiArDQo+Pj4+ICsgICAgICAg
ICAgICB2dGRfaW9tbXVfbG9jayhzKTsNCj4+Pj4gKyAgICAgICAgICAgIC8qDQo+Pj4+ICsgICAg
ICAgICAgICAgKiBXaGVuIGluZGV4ZWQgYnkgcmlkMnBhc2lkLCB2dGRfYXMgc2hvdWxkIGhhdmUg
YmVlbg0KPj4+IGNyZWF0ZWQsDQo+Pj4+ICsgICAgICAgICAgICAgKiBlLmcuLCBieSBQQ0kgc3Vi
c3lzdGVtLiBGb3Igb3RoZXIgaW9tbXUgcGFzaWQsIHdlDQo+bmVlZA0KPj4+IHRvDQo+Pj4+ICsg
ICAgICAgICAgICAgKiBjcmVhdGUgdnRkX2FzIGR5bmFtaWNhbGx5LiBPdGhlciBpb21tdSBwYXNp
ZCBpcyBzYW1lDQo+Pj4gdmFsdWUNCj4+PiBzaW5jZSB5b3UgZG9uJ3Qgc3VwcG9ydCBzb210aGlu
ZyBlbHNlIHRoYW4gcmlkMnBhc2lkLCBJIHdvdWxkIGRyb3AgdGhhdA0KPj4+IGFuZCBzaW1wbGlm
eSB0aGUgY29kZS4gU2VlIGJlbG93Lg0KPj4+PiArICAgICAgICAgICAgICogYXMgUENJJ3MgcGFz
aWQsIHNvIGl0J3MgdXNlZCBhcyBpbnB1dCBvZg0KPnZ0ZF9maW5kX2FkZF9hcygpLg0KPj4+PiAr
ICAgICAgICAgICAgICovDQo+Pj4+ICsgICAgICAgICAgICB2dGRfYXMgPSB2dGRfYXNfZnJvbV9p
b21tdV9wYXNpZF9sb2NrZWQocywgc2lkLCBwYXNpZCk7DQo+Pj4+ICsgICAgICAgICAgICB2dGRf
aW9tbXVfdW5sb2NrKHMpOw0KPj4+PiArICAgICAgICAgICAgaWYgKCF2dGRfYXMpIHsNCj4+Pj4g
KyAgICAgICAgICAgICAgICB2dGRfYXMgPSB2dGRfZmluZF9hZGRfYXMocywgaW5mby0+YnVzLCBk
ZXZmbiwgcGFzaWQpOw0KPj4+IHlvdSBjb3VsZCBjaGVjayB0aGUgdnRkX2FzIGFscmVhZHkgZXhp
c3RzIGhlcmUgcGVyIHRoZSByaWQycGFzaWQgc3VwcG9ydA0KPj4+IGxpbWl0YXRpb24NCj4+DQo+
PiBJbiB0aGlzIHNlcmllcywgSSBkbyBpbmNsdWRlIHNvbWUgYmFzaWMgY29kZXMgZm9yIG5vbi1y
aWQycGFzaWQgYmVjYXVzZSB0aGV5DQo+c2hhcmUgc29tZSBjb21tb24gY29kZSB3aXRoIHJpZDJw
YXNpZCBhbmQgd2UgYWxyZWFkeSBoYXZlIGVtdWxhdGVkDQo+cmlkMnBhc2lkIHN1cHBvcnQgaW4g
dklPTU1VIGZvciBhIGxvbmcgdGltZSwgaXQncyBub3QgYmFkIHRvIGFjY3VtdWxhdGUgc29tZQ0K
PnN1cHBvcnRpbmcgY29kZSBmb3Igbm9uLXJpZDJwYXNpZCBmb3IgcGFzc3Rocm91Z2ggZGV2aWNl
LiBCdXQgSSBjYW4gZG8gdGhlDQo+ZmFjdG9yIG91dCBpZiB5b3UgaW5zaXN0IHRvIGhhdmUgb25s
eSByaWRfcGFzaWQgY29kZS4NCj4NCj5JIHRoaW5rIGl0J3MgYSByZWFzb25hYmxlIGFzay4gOikN
Cg0KT0ssIHdpbGwgZG8uDQoNCj4NCj4+DQo+Pj4+ICsgICAgICAgICAgICB9DQo+Pj4+ICsNCj4+
Pj4gKyAgICAgICAgICAgIGlmICgoaW5mby0+dHlwZSA9PSBWVERfUEFTSURfQ0FDSEVfRE9NU0kg
fHwNCj4+Pj4gKyAgICAgICAgICAgICAgICAgaW5mby0+dHlwZSA9PSBWVERfUEFTSURfQ0FDSEVf
UEFTSURTSSkgJiYNCj4+Pj4gKyAgICAgICAgICAgICAgICAoaW5mby0+ZGlkICE9IFZURF9TTV9Q
QVNJRF9FTlRSWV9ESUQoJnBlKSkpIHsNCj4+Pj4gKyAgICAgICAgICAgICAgICAvKg0KPj4+PiAr
ICAgICAgICAgICAgICAgICAqIFZURF9QQVNJRF9DQUNIRV9ET01TSSBhbmQNCj4+PiBWVERfUEFT
SURfQ0FDSEVfUEFTSURTSQ0KPj4+PiArICAgICAgICAgICAgICAgICAqIHJlcXVpcmVzIGRvbWFp
biBpZCBjaGVjay4gSWYgZG9tYWluIGlkIGNoZWNrIGZhaWwsDQo+Pj4gZmFpbHMNCj4+Pj4gKyAg
ICAgICAgICAgICAgICAgKiBnbyB0byBuZXh0IHBhc2lkLg0KPj4+PiArICAgICAgICAgICAgICAg
ICAqLw0KPj4+PiArICAgICAgICAgICAgICAgIHBhc2lkKys7DQo+Pj4+ICsgICAgICAgICAgICAg
ICAgY29udGludWU7DQo+Pj4+ICsgICAgICAgICAgICB9DQo+Pj4+ICsNCj4+Pj4gKyAgICAgICAg
ICAgIHBjX2VudHJ5ID0gJnZ0ZF9hcy0+cGFzaWRfY2FjaGVfZW50cnk7DQo+Pj4+ICsgICAgICAg
ICAgICAvKg0KPj4+PiArICAgICAgICAgICAgICogcGFzaWQgY2FjaGUgdXBkYXRlIGFuZCBjbGVh
ciBhcmUgaGFuZGxlZCBpbg0KPj4+PiArICAgICAgICAgICAgICogdnRkX2ZsdXNoX3Bhc2lkX2xv
Y2tlZCgpLCBvbmx5IGNhcmUgbmV3IHBhc2lkIGVudHJ5DQo+Pj4gaGVyZS4NCj4+Pj4gKyAgICAg
ICAgICAgICAqLw0KPj4+PiArICAgICAgICAgICAgaWYgKCFwY19lbnRyeS0+dmFsaWQpIHsNCj4+
Pj4gKyAgICAgICAgICAgICAgICBwY19lbnRyeS0+cGFzaWRfZW50cnkgPSBwZTsNCj4+Pj4gKyAg
ICAgICAgICAgICAgICBwY19lbnRyeS0+dmFsaWQgPSB0cnVlOw0KPj4+PiArICAgICAgICAgICAg
fQ0KPj4+PiArICAgICAgICB9DQo+Pj4+ICsgICAgICAgIHBhc2lkKys7DQo+Pj4+ICsgICAgfQ0K
Pj4+PiArfQ0KPj4+PiArDQo+Pj4+ICsvKg0KPj4+PiArICogSW4gVlQtZCBzY2FsYWJsZSBtb2Rl
IHRyYW5zbGF0aW9uLCBQQVNJRCBkaXIgKyBQQVNJRCB0YWJsZSBpcyB1c2VkLg0KPj4+PiArICog
VGhpcyBmdW5jdGlvbiBhaW1zIGF0IGxvb3Bpbmcgb3ZlciBhIHJhbmdlIG9mIFBBU0lEcyBpbiB0
aGUgZ2l2ZW4NCj4+Pj4gKyAqIHR3byBsZXZlbCB0YWJsZSB0byBpZGVudGlmeSB0aGUgcGFzaWQg
Y29uZmlnIGluIGd1ZXN0Lg0KPj4+PiArICovDQo+Pj4+ICtzdGF0aWMgdm9pZCB2dGRfc21fcGFz
aWRfdGFibGVfd2FsayhJbnRlbElPTU1VU3RhdGUgKnMsDQo+Pj4+ICsgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICBkbWFfYWRkcl90IHBkdF9iYXNlLA0KPj4+PiArICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgaW50IHN0YXJ0LCBpbnQgZW5kLA0KPj4+PiArICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgVlREUEFTSURDYWNoZUluZm8gKmluZm8p
DQo+Pj4+ICt7DQo+Pj4+ICsgICAgVlREUEFTSUREaXJFbnRyeSBwZGlyZTsNCj4+Pj4gKyAgICBp
bnQgcGFzaWQgPSBzdGFydDsNCj4+Pj4gKyAgICBpbnQgcGFzaWRfbmV4dDsNCj4+Pj4gKyAgICBk
bWFfYWRkcl90IHB0X2Jhc2U7DQo+Pj4+ICsNCj4+Pj4gKyAgICB3aGlsZSAocGFzaWQgPCBlbmQp
IHsNCj4+Pj4gKyAgICAgICAgcGFzaWRfbmV4dCA9DQo+Pj4+ICsgICAgICAgICAgICAgKHBhc2lk
ICsgVlREX1BBU0lEX1RCTF9FTlRSWV9OVU0pICYNCj4+PiB+KFZURF9QQVNJRF9UQkxfRU5UUllf
TlVNIC0gMSk7DQo+Pj4+ICsgICAgICAgIHBhc2lkX25leHQgPSBwYXNpZF9uZXh0IDwgZW5kID8g
cGFzaWRfbmV4dCA6IGVuZDsNCj4+Pj4gKw0KPj4+PiArICAgICAgICBpZiAoIXZ0ZF9nZXRfcGRp
cmVfZnJvbV9wZGlyX3RhYmxlKHBkdF9iYXNlLCBwYXNpZCwgJnBkaXJlKQ0KPj4+PiArICAgICAg
ICAgICAgJiYgdnRkX3BkaXJlX3ByZXNlbnQoJnBkaXJlKSkgew0KPj4+PiArICAgICAgICAgICAg
cHRfYmFzZSA9IHBkaXJlLnZhbCAmDQo+Pj4gVlREX1BBU0lEX1RBQkxFX0JBU0VfQUREUl9NQVNL
Ow0KPj4+PiArICAgICAgICAgICAgdnRkX3NtX3Bhc2lkX3RhYmxlX3dhbGtfb25lKHMsIHB0X2Jh
c2UsIHBhc2lkLA0KPj4+IHBhc2lkX25leHQsIGluZm8pOw0KPj4+PiArICAgICAgICB9DQo+Pj4+
ICsgICAgICAgIHBhc2lkID0gcGFzaWRfbmV4dDsNCj4+Pj4gKyAgICB9DQo+Pj4+ICt9DQo+Pj4+
ICsNCj4+Pj4gK3N0YXRpYyB2b2lkIHZ0ZF9yZXBsYXlfcGFzaWRfYmluZF9mb3JfZGV2KEludGVs
SU9NTVVTdGF0ZSAqcywNCj4+Pj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIGludCBzdGFydCwgaW50IGVuZCwNCj4+Pj4gKyAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIFZURFBBU0lEQ2FjaGVJbmZvDQo+Pj4gKmluZm8pDQo+Pj4+ICt7
DQo+Pj4+ICsgICAgVlREQ29udGV4dEVudHJ5IGNlOw0KPj4+PiArDQo+Pj4+ICsgICAgaWYgKCF2
dGRfZGV2X3RvX2NvbnRleHRfZW50cnkocywgcGNpX2J1c19udW0oaW5mby0+YnVzKSwNCj4+PiBp
bmZvLT5kZXZmbiwNCj4+Pj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAmY2Up
KSB7DQo+Pj4+ICsgICAgICAgIHVpbnQzMl90IG1heF9wYXNpZDsNCj4+Pj4gKw0KPj4+PiArICAg
ICAgICBtYXhfcGFzaWQgPSB2dGRfc21fY2VfZ2V0X3BkdF9lbnRyeV9udW0oJmNlKSAqDQo+Pj4g
VlREX1BBU0lEX1RCTF9FTlRSWV9OVU07DQo+Pj4+ICsgICAgICAgIGlmIChlbmQgPiBtYXhfcGFz
aWQpIHsNCj4+Pj4gKyAgICAgICAgICAgIGVuZCA9IG1heF9wYXNpZDsNCj4+Pj4gKyAgICAgICAg
fQ0KPj4+PiArICAgICAgICB2dGRfc21fcGFzaWRfdGFibGVfd2FsayhzLA0KPj4+PiArDQo+Pj4g
VlREX0NFX0dFVF9QQVNJRF9ESVJfVEFCTEUoJmNlKSwNCj4+Pj4gKyAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgc3RhcnQsDQo+Pj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIGVuZCwNCj4+Pj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgaW5mbyk7DQo+
Pj4+ICsgICAgfQ0KPj4+PiArfQ0KPj4+PiArDQo+Pj4+ICsvKg0KPj4+PiArICogVGhpcyBmdW5j
dGlvbiByZXBsYXlzIHRoZSBndWVzdCBwYXNpZCBiaW5kaW5ncyBieSB3YWxraW5nIHRoZSB0d28g
bGV2ZWwNCj4+Pj4gKyAqIGd1ZXN0IFBBU0lEIHRhYmxlLiBGb3IgZWFjaCB2YWxpZCBwYXNpZCBl
bnRyeSwgaXQgZmluZHMgb3IgY3JlYXRlcyBhDQo+Pj4+ICsgKiB2dGRfYXMgYW5kIGNhY2hlcyBw
YXNpZCBlbnRyeSBpbiB2dGRfYXMuDQo+Pj4+ICsgKi8NCj4+Pj4gK3N0YXRpYyB2b2lkIHZ0ZF9y
ZXBsYXlfZ3Vlc3RfcGFzaWRfYmluZGluZ3MoSW50ZWxJT01NVVN0YXRlICpzLA0KPj4+PiArDQo+
VlREUEFTSURDYWNoZUluZm8NCj4+PiAqcGNfaW5mbykNCj4+Pj4gK3sNCj4+Pj4gKyAgICAvKg0K
Pj4+PiArICAgICAqIEN1cnJlbnRseSBvbmx5IFJlcXVlc3RzLXdpdGhvdXQtUEFTSUQgaXMgc3Vw
cG9ydGVkLCBhcw0KPnZJT01NVQ0KPj4+IGRvZXNuJ3QNCj4+Pj4gKyAgICAgKiBzdXBwb3J0IFJQ
UyhSSUQtUEFTSUQgU3VwcG9ydCksIHBhc2lkIHNjb3BlIGlzIGZpeGVkIHRvIFswLCAxKS4NCj4+
Pj4gKyAgICAgKi8NCj4+Pj4gKyAgICBpbnQgc3RhcnQgPSAwLCBlbmQgPSAxOw0KPj4+PiArICAg
IFZUREhvc3RJT01NVURldmljZSAqdnRkX2hpb2Q7DQo+Pj4+ICsgICAgVlREUEFTSURDYWNoZUlu
Zm8gd2Fsa19pbmZvOw0KPj4+PiArICAgIEdIYXNoVGFibGVJdGVyIGFzX2l0Ow0KPj4+PiArDQo+
Pj4+ICsgICAgc3dpdGNoIChwY19pbmZvLT50eXBlKSB7DQo+Pj4+ICsgICAgY2FzZSBWVERfUEFT
SURfQ0FDSEVfUEFTSURTSToNCj4+Pj4gKyAgICAgICAgc3RhcnQgPSBwY19pbmZvLT5wYXNpZDsN
Cj4+Pj4gKyAgICAgICAgZW5kID0gcGNfaW5mby0+cGFzaWQgKyAxOw0KPj4+IGlmIHlvdSBuZXZl
ciByZXBsYXkgYSByYW5nZSwgeW91IGNvdWxkIHNpbXBsaWZ5IHRoZSBjb2RlIGZvciBub3cgYmVj
YXVzZQ0KPj4+IHNvbWUgY29kZSBwYXRocyBhcmUgbm90IHByb3Blcmx5IHRlc3RlZA0KPj4NCj4+
IE9LLiBJbnN0ZWFkIG9mIGFzc2lnbm1lbnQgb2Ygc3RhcnQgYW5kIGVuZCB2YXJpYWJsZSwgbWF5
YmUganVzdCBhbg0KPmFzc2VydCghcGNfaW5mby0+cGFzaWQpLg0KPg0KPkkgdGhpbmsgdGhlcmUg
YXJlIHR3byByZWFzb25zIGZvciB0aGlzIHJhbmdlIHJlcGxheS4NCj4NCj4xKSBhcyBhIHByZXBh
cmF0aW9uIGZvciBwYXRjaCAxNiBvZiB0aGlzIHNlcmllcy4NCj4yKSBzdXBwb3J0IGRvbWFpbiBz
ZWxlY3RpdmUgb3IgZ2xvYmFsIHBhc2lkIGNhY2hlIGludmFsaWRhdGlvbg0KDQpFeGFjdGx5Lg0K
DQo+DQo+Pg0KPj4+PiArICAgICAgIC8qIGZhbGwgdGhyb3VnaCAqLw0KPj4+PiArICAgIGNhc2Ug
VlREX1BBU0lEX0NBQ0hFX0RPTVNJOg0KPj4+IFdoeSBjYW4ndCB3ZSBoYXZlIG90aGVyIGludmFs
aWRhdGlvbiB0eXBlcyBhbG9uZyB3aXRoIHJlcXVlc3Qgd2l0aG91dA0KPj4+IFBBU0lEPyBJdCBp
cyBub3Qgb2J2aW91cyB0byBtZSBhdCBsZWFzdCB3aHkgaXQgY291bGRuJ3QgYmUgdXNlZCBieSB0
aGUNCj4+PiBndWVzdC4gV291bGQgZGVzZXJ2ZSBhIGNvbW1lbnQgaW4gdGhlIGNvbW1pdCBkZXNj
IEkgdGhpbmsuDQo+Pg0KPj4gT3RoZXIgaW52YWxpZGF0aW9uIHR5cGVzIGFyZSBpbmRlZWQgdXNl
ZCwganVzdCBpbiBwYXNpZCBzY29wZSBbMCwgMSksIGJlY2F1c2UNCj5bc3RhcnQsIGVuZCkgYXJl
IGFscmVhZHkgaW5pdGlhbGl6ZWQgdG8gWzAsIDEpLCBub3RoaW5nIG1vcmUgaGVyZSwgc28ganVz
dCBicmVhay4NCj4NCj5obW1tLiBUaGUgZml4ZWQgc2NvcGUgbWFrZXMgdGhlIHJhbmdlIHJlcGxh
eSBhIGZha2Ugb25lLiBJdCdzIGJldHRlcg0KPmhvbGRpbmcgdGhlIHJhbmdlIHJlcGxheSBsb2dp
YyBmb3Igbm93IGFuZCBhZGQgaXQgd2hlbiB0aGVyZSBpcw0KPm5vbi1yaWRfcGFzaWQgc3VwcG9y
dCBmb3IgcGFzc3Rocm91Z2ggZGV2aWNlcy4NCg0KWWVzLCB3aWxsIGRlbGV0ZSB0aGUgbm9uLXJp
ZF9wYXNpZCBjb2RlLg0KDQpUaGFua3MNClpoZW56aG9uZw0K

