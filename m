Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 866F8EEA84C
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Feb 2026 18:55:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqbp5-00045P-7Y; Thu, 12 Feb 2026 13:53:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vqbp0-00042S-BW; Thu, 12 Feb 2026 13:53:50 -0500
Received: from mail-centralusazlp170110009.outbound.protection.outlook.com
 ([2a01:111:f403:c111::9] helo=DM5PR21CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vqboy-0004CA-RJ; Thu, 12 Feb 2026 13:53:50 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O4eIIvBfAK4RQdQkPsqJ/hALxHFY8xOJdtEVyHogNtbcaTBtkdL9HESo/PKmKvJpWzTZT37WSwEoiGRO7XqXpHnCYwnzRD3Lfoxpf7ZjwniviF6deDU5YAL6SidkEkp9jgn2V0hEbJGr7CqP/jgr7MCTelArRjNyZF7pcR/uftfV8vTon6+3q0e/EMd0Blgbk1jSWW0fFllQfJt91F7R0j8/hTs3LCYrj2fhJZdUDQ7C5yZRV8WVCqCTVVT5GyA7ok6kxrgcXcDYbNiC5t7QrVJGXD7KE4IfXcWOS0L04yuz4hq9iRgETOfapQ0aKY9PZRX/zei450XU1kiPI/XlRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9LWNP21jLcxU8dCzBSnV7Bz41FPXUgEGP3uyocwgnAc=;
 b=aZJrGsDhv5kE2ahI9EyLu/PQt2JRorHL4QofkBdWiCofq5YK3plBPv3qIdkGfkZ3yjCG8r/b++jIwwy8723xsnT7ho4d8ZkyogRX/34iuoUIhStkmF2OxM38Ugsavucj3j1SytlGgR8zyRKgz81tunp+2ICPj+WDqukObAQnsHKdFLGzudMiFYJnnl42WbGHRS794yPiR9IWVtOgQeQF5e1oUSsIKf+/nvtktOxKJVEIr++b+ujxFDSkHoVcUle9KEOUd2JaPhhBxRWfmmPeYBr+UvA1pRlcbGlO6liDGP+kNrXwYYsxgYlSpPZYMtbb2ueSyg3+HI61HtJUW9PooA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9LWNP21jLcxU8dCzBSnV7Bz41FPXUgEGP3uyocwgnAc=;
 b=U0tIuNTCwq/07Nx+WUpRoegLecLgeyajT6SPUCzn4H1POHbfdhU8T4fs1onZu56S226aey8gCbjx/AWKQ5ameprwwzlE3RMwFCXICuu6yBi0tkuASA9BDhExRpiWl//n1TNieC3uwppFHRt0x52wK1T1PuHz8NPhprc1AvkSG1FkHQYWTd+IhTuhZyNnpMN8YKI0Cr02PMZVo/+IAmPEdvBY8UtaS/ndz7pNriUVMmLaPnbg/nxAMT936jOXIZgsFZlVJ8gmEBkoImR8HYrb5lGRV2iHvmjkjgeZp2kV0hh++lX4UXUKAg6VDzEVvGrW72XTloqTcRjLZJec0WUc8Q==
Received: from CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
 by DM6PR12MB4452.namprd12.prod.outlook.com (2603:10b6:5:2a4::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.10; Thu, 12 Feb
 2026 18:53:41 +0000
Received: from CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de]) by CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de%5]) with mapi id 15.20.9611.008; Thu, 12 Feb 2026
 18:53:41 +0000
From: Shameer Kolothum Thodi <skolothumtho@nvidia.com>
To: "eric.auger@redhat.com" <eric.auger@redhat.com>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "peter.maydell@linaro.org" <peter.maydell@linaro.org>, "clg@redhat.com"
 <clg@redhat.com>, "alex@shazbot.org" <alex@shazbot.org>, Nicolin Chen
 <nicolinc@nvidia.com>, Nathan Chen <nathanc@nvidia.com>, Matt Ochs
 <mochs@nvidia.com>, Jiandi An <jan@nvidia.com>, Jason Gunthorpe
 <jgg@nvidia.com>, "jonathan.cameron@huawei.com"
 <jonathan.cameron@huawei.com>, "zhangfei.gao@linaro.org"
 <zhangfei.gao@linaro.org>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>, Krishnakant Jaju <kjaju@nvidia.com>
Subject: RE: [PATCH v2 22/24] hw/arm/smmuv3: Add per-device identifier
 poroperty
Thread-Topic: [PATCH v2 22/24] hw/arm/smmuv3: Add per-device identifier
 poroperty
Thread-Index: AQHcl3gEXhkB/SyYnEO7X7d7vTeZ+bV/bDOAgAADuOA=
Date: Thu, 12 Feb 2026 18:53:41 +0000
Message-ID: <CH3PR12MB7548BFE35E11F407DC3AAC8DAB60A@CH3PR12MB7548.namprd12.prod.outlook.com>
References: <20260206144823.80655-1-skolothumtho@nvidia.com>
 <20260206144823.80655-23-skolothumtho@nvidia.com>
 <6c4468e1-85e5-4d3e-9b4d-6710aac202a2@redhat.com>
In-Reply-To: <6c4468e1-85e5-4d3e-9b4d-6710aac202a2@redhat.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB7548:EE_|DM6PR12MB4452:EE_
x-ms-office365-filtering-correlation-id: 5a153b19-c6ed-4826-6759-08de6a680a1e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?Y1g5WXlHa2FOS3FLMDZJTEk3bGNlaTdHcmVkLzEwY0dlYVNiQlQwTlZkdmtX?=
 =?utf-8?B?clg1MXdic0hBQ2RpdVRqbjFoUFdGc3doVFgyM0tOQlNnU2dRVXZsa3FWbVFR?=
 =?utf-8?B?Q2Y1ZllzeXhGNzhENWhQL3RBNGJHK1ROc3kxM1E3VDRJLzFhQWxNUWZXRmpy?=
 =?utf-8?B?MzB1NXBTNk40S2dISk5TY1ZNLzJGcWlsb2dBMU1vcUxzblNWU2pranhPd0c0?=
 =?utf-8?B?dllpc29pd3FyOVZZZTJ4L0lXd2g1clNaZWJEZzArdXQ0T09ZZ3VRa0krd3Nx?=
 =?utf-8?B?aWxUY2RManVGUG54SHBnZXNvYmNGd3JjYmdnOGRkOC9ZcmJDL0hmRkVub0Qy?=
 =?utf-8?B?QlhiZkoydjJoSVp1TEsyMEdvbjdiN1FmQndCcjN3M0pLblRXSGZ3UU83cFov?=
 =?utf-8?B?clFUU2xOT2lNb0ZDZkRMTG1rSG5nSDRhbFI5bm4xVWt6bzUwMTk3TXdFVnVl?=
 =?utf-8?B?dVY4aFFucFlOR1g1UmV4RDZwMzdVOFBKaDUrMld1QTdzdFFodWFQMUxZV21i?=
 =?utf-8?B?MXJzVGUxOUxnMCtGNDFmYXBsdEUvZTRzT0c3TGoyWDJwRVMzNllyTGprN0xq?=
 =?utf-8?B?Rk1EclpHU2MyWGwxZ0IrTEo4NEpoNXRKY1hTazlEZVk4THBhaktBTlRiZUM1?=
 =?utf-8?B?czhzckRLeGZxL1Q3L2hyU280T2d3QmtOMGRGbWE2b1hsR1pCNmhGTWpmYVpz?=
 =?utf-8?B?bFZOeXpBVmh2N2t5TElmNGtrT3gwZ1VRL0JDOS9qTVVyTi94Q0RzNm5KTTNO?=
 =?utf-8?B?TW9Mb3FqT0VXRWFsQ2xHaTFlTUo4alRmOHlSeE5ScThIdzBlUkMwbHJlZkY4?=
 =?utf-8?B?dXVXb2pWZkNTUmJjQkVXbFJLQmdtKzhIYldFU1ZiQzdoLzM2ZWxGby9GZkVT?=
 =?utf-8?B?aUYvdm5oOXZ2OU84aXJuQ1NRcUpsQThQZ2xYNFIybC9vU1BXVUlZSFFnRVNP?=
 =?utf-8?B?VXZTbFlab0xVZkNDNTg1RUpwcjdYK213R2ZsMW5JYUx4QWc1cFVoanZIUjRP?=
 =?utf-8?B?STdqV05QWXUvRDZrNG1kNXYwRUhKYXJBTGxDWWxTTFpBTHM5anNWWncyVGFE?=
 =?utf-8?B?cDBGdW1wcWtDcjJseGdzQWh1V1pZT2xPZ2N1a1ZwSkpKalBVOFNwUDdJKzF2?=
 =?utf-8?B?R1dZUU4zclRCU1ZTeFhhdEM0UDNUbmlWa2pmdlNBdVNhdXRkeVJEZCt5dHRQ?=
 =?utf-8?B?NEplTDdWelpKcWMvWmlpTFViRitGVllMazl3MlRZS1Y3cjJ0RXBBcEpveVFX?=
 =?utf-8?B?RmoydVQrQ2podENQWnJLZXErM0V3RFpIbFFsOFlMSlVRbDlkbk03WG44bU1m?=
 =?utf-8?B?VG1qUmhQVFZIYmxoaGJEK0RGVU9sbFFiNzBuelI1QVFOeU9zRS9IdW55bndR?=
 =?utf-8?B?WlBURnlVOVdpRXBwaS9CUy83MkhXdk5BYW0rYVhicVFKclZ3OHpRRnFEN3Fv?=
 =?utf-8?B?eG8yRWN4MlprZGRNUGFTcXJ1T3dqMDVaK0I2alZWM3FUY0toSkJGaFVkTWVQ?=
 =?utf-8?B?ZnlIRkEvMUV2V0E0MnVrWmYzaWN5OGNMRGlIMVQxTm1oWkZ2a1o3a0FROFpy?=
 =?utf-8?B?dUdpQ3EvVlVtR1lydlJmZGxYSVkyYllWYklBRFg2L1ljMHJEcHhuTEVCT3oz?=
 =?utf-8?B?cEFjWitTbElLaUFWZ1JvbSt4SjRVVjk5cVFsdllIbjJpWnh4ZEFESUIwdHBJ?=
 =?utf-8?B?TjZYVHdsL3NNT1MxazZTSmRsZHEzN3I1TWtHUG1UVWFjS04wUnNVZ2Ficjgw?=
 =?utf-8?B?WHBNL20rTTZxYnJUK0lyUHE4UFNpVkVlSUIyU3djdGtCT25ITXl4WDJ5a2xv?=
 =?utf-8?B?OTV4OEJqY2l4aHFnakhLV3JLVUlXbS8wL2FxeVE0RGpZZUdjVFY5dDhtY3ZZ?=
 =?utf-8?B?djJHYmtGb1FmRmx3WGRkZTV4aWV4MS94QzNrRzBnMEF4cXZGa2NWQkZBd3Bi?=
 =?utf-8?B?RWNacDFPRFVtdHhUcnJ2MFRZMkdHNTgwbG1DdWpMSnYzTEJldVNSSEMybjBu?=
 =?utf-8?B?aTVIOHJ6NW1YVHVwOWFOUmQyYisyZFNZQlNpdDl4MkMrQ1VSZFB4b2h2OUhj?=
 =?utf-8?B?MitDb1gzWnc3TURaUjk5RVZMbFZ4SkVENHE2dVU1Z1QvZlhRTlVmcWtVWFhI?=
 =?utf-8?B?c3ZtK0xWWWJ0NGJnbGlCSkcycWJuTUxTdUViK2phcytmWkNBQVRxKy9ocTFw?=
 =?utf-8?Q?Hsx47u9XER1clcwHtZPtWmw=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB7548.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Y2h0SkVhY0RKdjBjWHR6Z0xXL29GVGVIM1QvT0ZvRUs3YnVXUnBvRnI4ZWFG?=
 =?utf-8?B?VGFUdWFTa3E5RC95TnYydmRac2J4NytjNUdTSUczalkvM0JqWkJSSkxLdk9P?=
 =?utf-8?B?MHE4a21UcnhONTFPUlpyMGhpZVl6aWpCUzM0K0F4bkNVTFJSN21oRUZRTTBa?=
 =?utf-8?B?ZkJXMERWY0NWNXRFdGRzMmJOVUc4RlVrVzdoNG9hNnpOa0dSOUQ0V05BR1dn?=
 =?utf-8?B?R2tXc3Q3Q0c5NzNIRUFVNm5BdmM2R0F1M0VoeUxhWnAwR05jenR2alE5NEhW?=
 =?utf-8?B?T1IzWGZocUZCV0lveWZnQXFGUTJVbWF5djl3dTVHSktZc0hxZkp6UnljY2FW?=
 =?utf-8?B?REZobmJCZWdxZ2tQc0tIYXZJTHZhVDUwQlByODk1bjFNbmdKaTdvbkZFdUJk?=
 =?utf-8?B?N0JZQzN3UmM1NmlXcGNZK3pYVSt4Uk5DcGdERTdwdGY2RlBJNFJHN1l1eEtX?=
 =?utf-8?B?M21McHBRKzZBeVJ1QkZveThDQ0tqTUk3TllaRGV3NEVtMlpDMlNBR3VsYjdN?=
 =?utf-8?B?bGtWcloyckhoMGMyVmpuNjUwRTd3TG1OZXlMNUpZS2hHRHlJWUl6azQyTVND?=
 =?utf-8?B?WEtNeVJmc2RoZ1VBREJndTRhOGo5RTA1ZGZiWk14S29jQXVlbDFsSnI4TGFX?=
 =?utf-8?B?SFE0NWY0ejdQRnlIVzhMbkN2S0tGTFhVVHZHaUhqVzQvQUovM25SQUxJaEp0?=
 =?utf-8?B?YU1zZi83eUc3LzRvUkNnTThTc1pwRlhVTTA4K0pzbmhtNzR5R3lCcXNuNm5z?=
 =?utf-8?B?bllxZXRzUFB3MFo2d2VIZUlhNjF2OHczSERUTWptUCszU1Y4d0ZickQ0aUdO?=
 =?utf-8?B?ZDVUZVdNV1dVVHNncWowKzJhQ290Q285WGxVdkFNbnR2OVZIdW4xeTRUL2xK?=
 =?utf-8?B?blpKaU1lZk96VGEzK0VqYmpTUTVyWGhrSGwxOGRwb05ZVVIza2lxKzlJeGVw?=
 =?utf-8?B?Z3A2U1d3Ri9MY1NZQUpIcERRb2s2cU41cUUrTndzWTNNaHNxZFhHNEY2YTFI?=
 =?utf-8?B?Q1hXTjU4QmxtUjdBWUFXMFc1R3hNSEQyamR5V3c3M25KYkpsVjFuUWV5VThG?=
 =?utf-8?B?MTdZbVZCcVlGSkFwWGZ3WktkMkxiaEpnTXNFQzlQaFJrV0xIL3ZIaDMzMGRE?=
 =?utf-8?B?M2VRaTlYZ1FIcmRaeEwzYU01R1EyMkFobWVkUnVvTTNrYlFJT002MG1yZjdV?=
 =?utf-8?B?cmIyK0lTSkJQQUxySVhrNUU4RnR1SVBpbTNqSjE4NnRqMnYvOE90UnRWZ1Np?=
 =?utf-8?B?dkJLRk56NUhvNERvYlpGUk9iUFhYdEFtUnRUeHN2N0gyNDNRL2pvcjhmSjQx?=
 =?utf-8?B?SEVVVTYrV2JKL3p2UnJRUzZlaytMbGRSY3NCbXk2QmN5ZGdKMktGdjQ1REti?=
 =?utf-8?B?TS95SWxhR0IvYnNNVVRNK3dnNWI5K2NJN3RlU3kwdVpkVWlZZi9TaVM0TnNy?=
 =?utf-8?B?dWQydEI2Nk9MMGljSEl4V2JrWDExcExSNVIwdUNYb3V0NnpEV2hHTkdLOXdO?=
 =?utf-8?B?U1NmbVBWR2w1TnBCRnhMTThWYlZoZHhjSGF6dnpaWFRBYm9PRUVlYWJGTjlM?=
 =?utf-8?B?MFo1RExJZE1wK0ZWMG13WTV0V3Ava1BUYlRTQ2lDTjM0emZabnRqWmZ6OWxW?=
 =?utf-8?B?aWNoZUlncVQ3Sjg2VGVBTGhvQllXbVM2WFA0b1NnSWw2cTU1THZDbm9JZGJu?=
 =?utf-8?B?T0Rlbno0QVE1dC9HenZEY01adlY1QUFVdVQzREJGZ2pvSXFkT1N0MGlCZUJw?=
 =?utf-8?B?Y2JaR2IvNytvQjBZYTNjWVFUaE9IZW9HNVUxLy84SXJjamNoSmlJWG9yWFZi?=
 =?utf-8?B?MEhLbjlhUmp0bnphVjdJbkR6L056QTJRUzczZExFSXN4dmxEV05ya2lzbkYy?=
 =?utf-8?B?WUlac29DTUZUZHFpVkh5UjJzZEtTNlhKZjNjTVZ4NHZmSlRkbk5BTFZUQ0d0?=
 =?utf-8?B?QkNVZmI5dGtpdU9GY3NJcXl3d3M3emViWU5iN1pqdWNmWUpLUlVyU3l0czI2?=
 =?utf-8?B?dUMzekl6U2NDYWxmbllFR2FIVTZTVWZib3l3aEk1dGpUbEFxbkJ2NnBub000?=
 =?utf-8?B?MEVQeXRBUTQ5VG0wbG0yU3BmQXc4NGYwWm91VE1TdFY3RU1YbHk1WGo1VkE3?=
 =?utf-8?B?MUZsSFZpSlU0NFZCeFFKR0hTOGJuZXREc1BEbEhUeUhUNHllcS9IWnJWUnR2?=
 =?utf-8?B?V0p6Y1VTY0xHaDhqejZ3TDVsUVh0OXdONE80SFFWZ0UzRjUvYWMzc3RSSisv?=
 =?utf-8?B?Ym92U1hDS210c213cWN2OUdaWmp3c1NNaXliS2VzbW1zMmFNSlc0VmRxSDVw?=
 =?utf-8?B?bDJscSt5ZDFKU1RYTjFIV0R4elRFaWZadUxldWJFaXd2NnQ3VjNJUT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7548.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a153b19-c6ed-4826-6759-08de6a680a1e
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Feb 2026 18:53:41.1692 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PCcD8QHk8L0ToudfhwhKVuE78PkCBwISY0PPN0it83n+AktfDxHOmZmLgL10saZfGv6lVpPYlBmNNssAeo6Ang==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4452
Received-SPF: permerror client-ip=2a01:111:f403:c111::9;
 envelope-from=skolothumtho@nvidia.com;
 helo=DM5PR21CU001.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_NONE=0.001 autolearn=no autolearn_force=no
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogRXJpYyBBdWdlciA8ZXJp
Yy5hdWdlckByZWRoYXQuY29tPg0KPiBTZW50OiAxMiBGZWJydWFyeSAyMDI2IDE4OjMwDQo+IFRv
OiBTaGFtZWVyIEtvbG90aHVtIFRob2RpIDxza29sb3RodW10aG9AbnZpZGlhLmNvbT47IHFlbXUt
DQo+IGFybUBub25nbnUub3JnOyBxZW11LWRldmVsQG5vbmdudS5vcmcNCj4gQ2M6IHBldGVyLm1h
eWRlbGxAbGluYXJvLm9yZzsgY2xnQHJlZGhhdC5jb207IGFsZXhAc2hhemJvdC5vcmc7IE5pY29s
aW4NCj4gQ2hlbiA8bmljb2xpbmNAbnZpZGlhLmNvbT47IE5hdGhhbiBDaGVuIDxuYXRoYW5jQG52
aWRpYS5jb20+OyBNYXR0DQo+IE9jaHMgPG1vY2hzQG52aWRpYS5jb20+OyBKaWFuZGkgQW4gPGph
bkBudmlkaWEuY29tPjsgSmFzb24gR3VudGhvcnBlDQo+IDxqZ2dAbnZpZGlhLmNvbT47IGpvbmF0
aGFuLmNhbWVyb25AaHVhd2VpLmNvbTsNCj4gemhhbmdmZWkuZ2FvQGxpbmFyby5vcmc7IHpoZW56
aG9uZy5kdWFuQGludGVsLmNvbTsgS3Jpc2huYWthbnQgSmFqdQ0KPiA8a2phanVAbnZpZGlhLmNv
bT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MiAyMi8yNF0gaHcvYXJtL3NtbXV2MzogQWRkIHBl
ci1kZXZpY2UgaWRlbnRpZmllcg0KPiBwb3JvcGVydHkNCj4gDQo+IEV4dGVybmFsIGVtYWlsOiBV
c2UgY2F1dGlvbiBvcGVuaW5nIGxpbmtzIG9yIGF0dGFjaG1lbnRzDQo+IA0KPiANCj4gT24gMi82
LzI2IDM6NDggUE0sIFNoYW1lZXIgS29sb3RodW0gd3JvdGU6DQo+ID4gQWRkIGFuICJpZGVudGlm
aWVyIiBwcm9wZXJ0eSB0byB0aGUgU01NVXYzIGRldmljZSBhbmQgdXNlIGl0IHdoZW4NCj4gPiBi
dWlsZGluZyB0aGUgQUNQSSBJT1JUIFNNTVV2MyBub2RlIElkZW50aWZpZXIgZmllbGQuDQo+ID4N
Cj4gPiBUaGlzIGF2b2lkcyByZWx5aW5nIG9uIGVudW1lcmF0aW9uIG9yZGVyIGFuZCBwcm92aWRl
cyBhIHN0YWJsZQ0KPiA+IHBlci1kZXZpY2UgaWRlbnRpZmllci4gVGhpcyBpcyB1c2VmdWwgd2hl
biB3ZSBhZGQgc3VwcG9ydCBmb3INCj4gPiBUZWdyYTI0MSBDTURRViBEU0RUIGluIHN1YnNlcXVl
bnQgcGF0Y2guDQo+ID4NCj4gPiBObyBmdW5jdGlvbmFsIGNoYW5nZSBpbnRlbmRlZC4NCj4gSSB0
aGluayBhbiBpbXBvcnRhbnQgaW5mbyB3aGljaCBpcyBtaXNzaW5nIGhlcmUgaXMgeW91IG5lZWQg
dGhlIGlkIHVzZWQNCj4gaW4gSU9SVCBhbmQgRFNEVCB0byBiZSB0aGUgc2FtZSwgaXMgdGhhdCBj
b3JyZWN0DQoNClllcy4gVGhhdCBpcyBjb3JyZWN0LiBJIHRoaW5rIEkgaGF2ZSB0aGF0IGV4cGxh
bmF0aW9uIGluIG5leHQgcGF0Y2guIEkgd2lsbA0KbWVudGlvbiBpdCBoZXJlIGFzIHdlbGwuDQo+
IA0KPiBCeSB0aGUgd2F5IHdoeSBjYW4ndCB5b3UgcmV1c2UgdGhlIFFPTSBpZC4gSSB0aGluayBE
YW4gc2FpZCB0aGVyZSBpcyBvbmUNCj4gZm9yIGFsbCBRT00gb2JqZWN0cy4NCg0KWWVzLiBRT00g
ZGV2aWNlIGhhcyBhIGdsb2JhbCBpZC4gQnV0IEkgYW0gbm90IHN1cmUgd2UgY2FuIHVzZSB0aGF0
IGhlcmUuDQpGb3Igb25lIGl0IGlzIGEgImNoYXIgKiIgYW5kIG5vcm1hbGx5IHVzZXIgb3IgbWFu
YWdlbWVudCBsYXllcnMgd2lsbCB1c2UNClRoYXQsDQplZzoNCi1kZXZpY2UgYXJtLXNtbXV2Myxw
cmltYXJ5LWJ1cz1wY2llLjEsaWQ9c21tdXYzLjEtcHhiMSwNCg0KVGhhbmtzLA0KU2hhbWVlcg0K
DQo=

