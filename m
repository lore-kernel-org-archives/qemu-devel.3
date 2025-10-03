Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EC53CCA471
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Oct 2025 10:42:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4dDf-00021u-6b; Fri, 03 Oct 2025 06:40:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1v4dDZ-00021H-Hw; Fri, 03 Oct 2025 06:40:54 -0400
Received: from mail-francesouthazlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c207::3] helo=MRWPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1v4dDR-0006Hz-26; Fri, 03 Oct 2025 06:40:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tzjcIr3uho+MytUkS6sGR4dEY3amlyUfR9cqyuPyM00m0uugMJK/MxvysAiPWdGmWvEe2THSx5Us7DwwujvJt+Q8xyREdIpSUGtVzB4dulWv0qHSLB5Y+VIEbV9Blj/aR46RelbIFBVTPkMC4YHHaztg203HQmmCdKZJa25U+8a0G3zO1n5lUUG0ii4CYojow7Y//Rc777sb7o/qi7V9Zj5IzxI4od71btg8C6ZsM93iU0EJ/bfLsdQ3nQr13AA3riPHd8lRQ3NdFm7CEYARys9NSMscUfKwA4aSoIP5JrHtRQ/HPSQGtbXncCtmPpbtOZwqMB+pAJCgSWaJnwD+9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7yLtKhzskTwhop0u0VlZJESGNMDnoiXITrdfHBosi7I=;
 b=BRdimRuMyDOeJhZ7/CsC8c3pwPmBiCQptRS72IFAJPZauDtwfO+SJajdLPS+rRigZ1rKV6acdtpY0iJz1P8gNMlbTwbmV+4jWv3j33ukOs1Wt2yZV+lPRGF8YyKvU87RPyZIYUuOuUkaj509S1H7Gz0MfKL0Yp+n9MDNKx1oqZlQ6H+UCSMfRVywS8eHi/eVbEe07fyid5ks92jg4tXQ85rMXp6LxGcjZLjcQDaf/BuPPBjS6QpFjT3wffc7JHMrwhsxuIpjKClLeHvMtyud33iJUv32YcDDAmP92E3E5obKEfxlrnELQ3mhPqTxXpDDniS+69duJaafo9Lua0oRtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7yLtKhzskTwhop0u0VlZJESGNMDnoiXITrdfHBosi7I=;
 b=ujEQYMHH+YBuW1aHbpkFkVrz0v3TA5R+RILHeGse/rAX/seIDSXzsBv7iGEcxvCoMVaqLNwtGyi/lGv+/oOuhQwLD7vE6tEMXEG6gkwAj7E50QgePO8VApPzobzfZLG8LgWcKQKaB2pginob7h59UBUmH+mbvf5bUFiH67fysD62nPkdcwtbKb8wfuasnsyTLUCsm4n8TlAY0Xw552iv2ga7Lu/deeAigSkpuU1umgHid6qWOuJl/Cx1w8KmkOQ7SMDW07LA81t8zdbadcCHfPb3SSDynOcgpqQKN+elR79sPKbxVVhLqNEBbC735D6duwVa3lX3rdzIfx0n/jmV8w==
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com (2603:10a6:20b:4fb::5)
 by PA2PR09MB7594.eurprd09.prod.outlook.com (2603:10a6:102:411::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.18; Fri, 3 Oct
 2025 10:40:30 +0000
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a]) by AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a%4]) with mapi id 15.20.9160.017; Fri, 3 Oct 2025
 10:40:30 +0000
From: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
To: Alistair Francis <alistair23@gmail.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-riscv@nongnu.org"
 <qemu-riscv@nongnu.org>, "cfu@mips.com" <cfu@mips.com>, "mst@redhat.com"
 <mst@redhat.com>, "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>, "philmd@linaro.org"
 <philmd@linaro.org>
Subject: Re: [PATCH v9 02/13] target/riscv: Add cpu_set_exception_base
Thread-Topic: [PATCH v9 02/13] target/riscv: Add cpu_set_exception_base
Thread-Index: AQHcMriiJMjdKnMaeUmdbBWLAwyUc7SuEVEAgAItgIA=
Date: Fri, 3 Oct 2025 10:40:30 +0000
Message-ID: <718ce626-88ea-4fad-a3c4-5e05a991a83d@htecgroup.com>
References: <20251001094859.2030290-1-djordje.todorovic@htecgroup.com>
 <20251001094859.2030290-3-djordje.todorovic@htecgroup.com>
 <CAKmqyKNvLrdgXFe9Tu-f6V70Cv5piNwNVT8nQZGLt35vAfOGbw@mail.gmail.com>
In-Reply-To: <CAKmqyKNvLrdgXFe9Tu-f6V70Cv5piNwNVT8nQZGLt35vAfOGbw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS4PR09MB6518:EE_|PA2PR09MB7594:EE_
x-ms-office365-filtering-correlation-id: 55fcdba6-d64b-41f0-6e51-08de02694608
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?ZFV1WjFhanN1SU10OHp3dlNmNzFHZDFnanNNSTh4NW92TFhRbGFjK0JuRFk3?=
 =?utf-8?B?QzlPNWpvMG9EazRZdCsyNytEU0FZbTR6bGVBZ0pLZ2prUjFRKy9aa3V6b1NO?=
 =?utf-8?B?QWI0dXVsdlVORTV0ZDViMTZEWHdQcjY5VXhJSnNnZnJ0c005L3VwbVMvejFq?=
 =?utf-8?B?UXFhQlBWdUtHajZWYkVCYm0yU0lGS0hIYjZVRmlBR01iV1A1OFF3cmtGV3Zv?=
 =?utf-8?B?T3FWNE9ma2s5bCtBZ0RQdnZWTk1laEZaOUxpUEhDa21la3I0aUhia1RYdFQ0?=
 =?utf-8?B?WTQrUXc3eWRNeWpmVlNZc0VGWmRvODUvU1A0OUJxS0ZnUDgxNzlUZ0NFWm83?=
 =?utf-8?B?N0ZZWWZ4SFhxMlpNR1diVmlJbVFMRVQzQ0JpTFN2NTNjYmFlWFl0Q0VnOGdN?=
 =?utf-8?B?Q1A3aU5WM1ArbWJOZ2Y0OW1pcGdwWVNLK2IwV3lnNGZFZXlkV1d5S2J3cEdu?=
 =?utf-8?B?Z3lCNXVpdUFKWFpCZ0FsRHViWk85bjNFVlRBc2oxblRIcUdXWVFGbHJKUFpD?=
 =?utf-8?B?UFVHM1F2NGc3a2dDZFBTTnM2YTdyYjhDY21tWmo1QUNZdmVZSERoN09UQ2I1?=
 =?utf-8?B?YThSUG1mdUpvdWg4bjFFL3dEaWQ2OWJ1TEJGQ1hOaUJWeFV4bGhONmFFTkt1?=
 =?utf-8?B?dWhBNE02a2hSU0dOVHNPU0RKWXYxSXVmd2VLbndUcVdXQWFIUEhBL0E1SlF4?=
 =?utf-8?B?NHdGT01WaERscDU1aGRMZFZ5QU9GalBPN1g3aUwrOEhmOGxvbTFibkpkWkNn?=
 =?utf-8?B?TG1RWnNrVjFlaVd5NjljYmdUanEzWWhkZllseEVJSCtYZXpxSjlITi92ZHpZ?=
 =?utf-8?B?T2wzbytlczFGdjcwb0UrdGt3QUtISkRFOXBkV0ZOVm1rQzJLSlZBYmJCM3Rq?=
 =?utf-8?B?MWpvMzMydGNxRFByVG11L2pRL2xIcVdSYjJmTVQyQW9xVnkwOCtsSWtrbm15?=
 =?utf-8?B?M2dXV0MwMUpEbmRxVlVHVVlHUC9wMFhkaTdDZFIrOXFYb091blhlSTJ1SGpr?=
 =?utf-8?B?SG9zcyt4VXpIOElMV0xSQXgxUWJRbXBzWitjOTBIZG1KL2VXQ0hxZU9vMmtj?=
 =?utf-8?B?U21mbkQzUFZGVEE5SVEwT1VjbUc5c3VvaXQ3RTdaR3JHdnNseThaY0NwWGxJ?=
 =?utf-8?B?V1pYVjVWMkdaQVFvNVNJOStwWG9ONmhKa2ZSSHZodmc0U0tGYUpGNzlCQlhp?=
 =?utf-8?B?c2NUWTd1LzQ2cU1pMEFycVhVank2VmFSQjdHd3hEdWRvaC9Rb2taVDJFZWtQ?=
 =?utf-8?B?N2EwSDdRRTJKQlJ6Q2ZZbjJ3Mnc1NzdZNi9CaVp5OFRaWjBtOVpMY25Gcm92?=
 =?utf-8?B?M3VFVWN0WVRKclU3UFZFYTNyUnViTjBGT0tXZVV6Z1lGazEvcTZhd2NLcXlk?=
 =?utf-8?B?S3pwYmNnSG1FeWlRamRKeGczK1ByY1oxcDhYMm1VZ1FpODk1bzV1NGxqMzlW?=
 =?utf-8?B?YnovdVBLMURGM1JJT2ZEL2RrbXp0ZXNIb3IvZk0yd0NqV0Q2b08vUmtIb1Za?=
 =?utf-8?B?SndLMm81ZitPNUNLdDlUNXZvODhYV2ZTMDRRWjdvQkVZQU8zZEVMWjY5Vzdq?=
 =?utf-8?B?TzRsdUNFRmxKZ24xMEc3Y2U5QXNMclAzN0ZDQUhYcTNQZVNhNlk2UCtMYkpE?=
 =?utf-8?B?MXdQV2oyT3I4WTlNQ0w4dHg0YWIxSXgwRk5DaWx3am9qbk91dVlhK1ZNMXAy?=
 =?utf-8?B?M3dQSWlEZlJpREdNbnphcjJzZmg1YWIrT3Q4Um1HOVl0NmNFQ0p0UXRMd20y?=
 =?utf-8?B?ejJpbGhERFpwR1RHV3QzR09aY1lBd20zY3YrVmM1M0V1dUc2YlBwbkprSDVJ?=
 =?utf-8?B?dnIzOEI5ZXF0M3lZNFVlWEkrV0FJV2dHRGRMeUxyalRiMXhreEl6R1pTd2I0?=
 =?utf-8?B?bVg0bTV4Y3JQak9DRFgrYkZuVmk4Q3hjZFJrdE5sYjlMaWREV3lUZFo3ZEpK?=
 =?utf-8?B?eE9sT2hiemVRRWNIdG1QVkFHNGhVcHoxMC9vc09wWW1Ga01LVE9nV3hEb3hx?=
 =?utf-8?B?V1BDaCt4T3lIUm8zZXp3djh1Yk5obWo1Qzl6UjRIdzVyVzNZS2VuZTVGeFdz?=
 =?utf-8?Q?2ugazM?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR09MB6518.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700021); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Y09XTmIya0FKaXQyTWtRVlN2QklNUU9JbjZYVmtvdlh3WHd6RTcvQkdhUk8y?=
 =?utf-8?B?cTNxcHRYOVpoL1NPdnc4ZEhqaEJqblFsNWpnNTNVb3RBaDdzdkRsWXRVR2dT?=
 =?utf-8?B?aW5yakErZmhUeGttRmJMVG05eEExUG13dTJSaDBrZDFYSlhPUkNSYjR1TzQ2?=
 =?utf-8?B?dWZKNUpyc3BSZ0F1ZEpTSjF1Njdpamx5Z3R5SXdQTkdQSXlrK1BCQ0tOMXdk?=
 =?utf-8?B?QmxNVWFURldBOWh4cmpCYzlLQXpZWFA0WXo2NW1mWGd3emhyVnNwRi80QU93?=
 =?utf-8?B?RkZRSlZFOEIxaUJac3crWkdnNEYxcUxKMENpL1ZSWm5mVndyY0VBejNINEVD?=
 =?utf-8?B?M2tpaDBTNHJXRlBOdnp5VWIrL0grS0lWODRxNC9wVlJ2V0dOc0NISzdRYnA1?=
 =?utf-8?B?Q0R3bCtFbjNReVlDY0tpTjNWN1cyUnRNMnpGaVhQSFBYcFJGc2ZkQkZYZCtV?=
 =?utf-8?B?S0d5ekYvTWQ4WGd5RmRqbHBXMmZ0UzJzUlRuL1crdXpkMmVpejFQRG52RkdD?=
 =?utf-8?B?SmRPS1pCZG84emxPYlo2alFxRHFLelZrSTkxRDllUFo4Y2hNM2s3dkV5d050?=
 =?utf-8?B?aEhyVTVMeGdQVUVUblo1RVlHWHV6U1JEY0dWb0Zmbys1R3p1eC9uYk85Q2VB?=
 =?utf-8?B?SHNpWWZvUmFNOUpjUThrejhFNVhCTE0yTVY4RFFPeUJ1cWlCTzFZUjE1OEcw?=
 =?utf-8?B?enFsakNRcCtsc2xiUDBwNVN3d2VxV3FlRUJ3ZTJsNU1SdTN3WmJGdFVwMklu?=
 =?utf-8?B?ekxhbFVDZW9STjVSMC9QdmVvRFAvRTYrVWh2Rk11SEVlUmQ2cmMvVlh3Uk9Y?=
 =?utf-8?B?eFlqczhQQUFsNWVqVHRLeG9HQmxwK2hvZFZQa1pjTzJ3bzBMc01EM3k1bTlQ?=
 =?utf-8?B?UnNoZmNnekJlN01nQmhnT2pQZGY5ZVRFUjQ4K24wbXgrTmNseFRPTk9xN2d6?=
 =?utf-8?B?YkphMVlVZ0ozeUg5QWRXeDFmckdvYlpWRWk5eDREbndGbmUybFB5b2k5YVdw?=
 =?utf-8?B?MURENVBUTGF1UGZCZGJDVnFIN1p2dENKczRWaUxyaVE3K2dOM2drOElZMGFZ?=
 =?utf-8?B?M3ZwckN2QTBjZTVsSWtaL20yVDFFVnBUMy9ra05tbW1oN055SWkvcWwyMUNv?=
 =?utf-8?B?d0dVN0NUU2Q1dnU4VkVuY0hQOUpNZklndVFDRDlHUWIybFhmSlhodVNocjhh?=
 =?utf-8?B?V2VPYm8vMGJUMFVGS01vVm40Um1EUGxBVzZVb3hVUXBTZDJqRU1UaUg5MlZz?=
 =?utf-8?B?cXg4N2pRNHhzQVdObnd2ZTUzWDEzUHpld1poZlNCQ2JJNExLeTZBZzBXWWF6?=
 =?utf-8?B?V3BFajFlVTJSZHhkRVNXemo2SXlxMjAxVVRLbVNiT0dpS2Q0Y2FJRDVFaWpM?=
 =?utf-8?B?KzJiUWpodnFrRzRWR2NDSWs4Y2xjOXcyNTRXeDZ3L094b2NvSHJ2TXNBWlZh?=
 =?utf-8?B?RnpGZDdNZXFjVlRaR2M4M0YvMzhSdEZJc2cvWk1XdTkvS3dGYUpzUmxVanRv?=
 =?utf-8?B?WEsyVUZ6VXZpanpmTjhsRlRzV2YzVy9uUVRLK2xoRWJXNTBrNFg1WFNlcERz?=
 =?utf-8?B?azZEcnVYaEtibnd4NGdjOUUxMjdjN0NJNlBEQ2J2N3d3TkRFUnNMWkdJK29F?=
 =?utf-8?B?NldTQ2VPaUhVT2hwMVBlZFphaGo4TlJ0ajlLUko4MHorWS9DSUdac2Y0VEdO?=
 =?utf-8?B?Zjd6MTMwdVNOb3VVQ3AvN0NXSEpZNjRNVWthRkVhazRDMkovdDRvN2pBQzdr?=
 =?utf-8?B?a0Y3bHkrMlJtdy83SEpWWUYyV2ZnWjM0V25EbVhlR3E4VkNVRzh3dXo4a3Nu?=
 =?utf-8?B?eGpVSzRWUm4rakVMNCtOWFVqVE1aUFY1SHlTaXhtQkVrVDIveGNva21GQ015?=
 =?utf-8?B?TmNTQlJaNFJYUnhCNjR4NmFRZ1c1elpOTU41a0YxM3lvRFVubWIvKzJESVNW?=
 =?utf-8?B?Ym9jbUFzeVlVenR5eVdyL3E1Z3ArcUYzYzcxZkhNSnJjbU9BRjdxOURhTU9L?=
 =?utf-8?B?RTkrcERDdytLc1RnTDdZMXhKSmRZYTRMeXI1cUxLRkl0UUVsM05BZTh2dk80?=
 =?utf-8?B?c0JoSXkwNmcydGNNTjdPOENNMWkxekVIVmlMQ21pM3o3ZGFhY0NTL1l6dHF6?=
 =?utf-8?B?dmJveDN2TDFGMkowTlFGMU5XdVZLUnFRb3I5ZGJVR0VmWUJ1V1JtNlR4N3Yz?=
 =?utf-8?Q?drGKMWHvvpaloM078Ur3kQM=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B69BDC05EB6E8D4F91350C90D5440740@eurprd09.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS4PR09MB6518.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55fcdba6-d64b-41f0-6e51-08de02694608
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Oct 2025 10:40:30.2767 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YAyQlwW6A20T0nTle+5yTPC+TILY2bYHNXwfEIejj6to68b/LpWhZHgxi6DPD/OTNsayG9amUAaRyrI7ObZ1ddEa7A0R+Kz27IJs+0p29cU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR09MB7594
Received-SPF: pass client-ip=2a01:111:f403:c207::3;
 envelope-from=Djordje.Todorovic@htecgroup.com;
 helo=MRWPR03CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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

DQpPbiAyLiAxMC4gMjUuIDAzOjI1LCBBbGlzdGFpciBGcmFuY2lzIHdyb3RlOg0KPiBDQVVUSU9O
OiBUaGlzIGVtYWlsIG9yaWdpbmF0ZWQgZnJvbSBvdXRzaWRlIG9mIHRoZSBvcmdhbml6YXRpb24u
IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3UgcmVjb2du
aXplIHRoZSBzZW5kZXIgYW5kIGtub3cgdGhlIGNvbnRlbnQgaXMgc2FmZS4NCj4NCj4NCj4gT24g
V2VkLCBPY3QgMSwgMjAyNSBhdCA3OjQ54oCvUE0gRGpvcmRqZSBUb2Rvcm92aWMNCj4gPERqb3Jk
amUuVG9kb3JvdmljQGh0ZWNncm91cC5jb20+IHdyb3RlOg0KPj4gQWRkIGEgbmV3IGZ1bmN0aW9u
LCBzbyB3ZSBjYW4gY2hhbmdlIHJlc2V0IHZlY3RvciBmcm9tIHBsYXRmb3Jtcw0KPj4gZHVyaW5n
IHJ1bnRpbWUuDQo+Pg0KPj4gU2lnbmVkLW9mZi1ieTogQ2hhby15aW5nIEZ1IDxjZnVAbWlwcy5j
b20+DQo+PiBTaWduZWQtb2ZmLWJ5OiBEam9yZGplIFRvZG9yb3ZpYyA8ZGpvcmRqZS50b2Rvcm92
aWNAaHRlY2dyb3VwLmNvbT4NCj4+IFJldmlld2VkLWJ5OiBEYW5pZWwgSGVucmlxdWUgQmFyYm96
YSA8ZGJhcmJvemFAdmVudGFuYW1pY3JvLmNvbT4NCj4+IC0tLQ0KPj4gICB0YXJnZXQvcmlzY3Yv
Y3B1LmMgfCAxNCArKysrKysrKysrKysrKw0KPj4gICB0YXJnZXQvcmlzY3YvY3B1LmggfCAgNCAr
KysrDQo+PiAgIDIgZmlsZXMgY2hhbmdlZCwgMTggaW5zZXJ0aW9ucygrKQ0KPj4NCj4+IGRpZmYg
LS1naXQgYS90YXJnZXQvcmlzY3YvY3B1LmMgYi90YXJnZXQvcmlzY3YvY3B1LmMNCj4+IGluZGV4
IGQwNTVkZGY0NjIuLjc0NzI4YzUzNzEgMTAwNjQ0DQo+PiAtLS0gYS90YXJnZXQvcmlzY3YvY3B1
LmMNCj4+ICsrKyBiL3RhcmdldC9yaXNjdi9jcHUuYw0KPj4gQEAgLTczLDYgKzczLDIwIEBAIGJv
b2wgcmlzY3ZfY3B1X29wdGlvbl9zZXQoY29uc3QgY2hhciAqb3B0bmFtZSkNCj4+ICAgICAgIHJl
dHVybiBnX2hhc2hfdGFibGVfY29udGFpbnMoZ2VuZXJhbF91c2VyX29wdHMsIG9wdG5hbWUpOw0K
Pj4gICB9DQo+Pg0KPj4gKyNpZm5kZWYgQ09ORklHX1VTRVJfT05MWQ0KPj4gK3ZvaWQgY3B1X3Nl
dF9leGNlcHRpb25fYmFzZShpbnQgdnBfaW5kZXgsIHRhcmdldF91bG9uZyBhZGRyZXNzKQ0KPiBU
aGlzIHNob3VsZCBwcm9iYWJseSBoYXZlIHNvbWUgZG9jdW1lbnRhdGlvbiBzYXlpbmcgdGhhdCBp
dCdzIG9ubHkgZm9yDQo+IHJ1bnRpbWUgdXNhZ2UNCj4NCj4gQWxpc3RhaXINCg0KSGkgQWxpc3Rh
aXIsDQoNCkl0IG1ha2VzIHNlbnNlLiBJIHdpbGwgYWRkIGEgY29tbWVudCBpbiB2MTAuDQoNClRo
YW5rcywNCkRqb3JkamUNCg0KDQo+DQo+PiArew0KPj4gKyAgICBDUFVTdGF0ZSAqY3B1X3N0YXRl
ID0gcWVtdV9nZXRfY3B1KHZwX2luZGV4KTsNCj4+ICsgICAgaWYgKGNwdV9zdGF0ZSA9PSBOVUxM
KSB7DQo+PiArICAgICAgICBxZW11X2xvZ19tYXNrKExPR19HVUVTVF9FUlJPUiwNCj4+ICsgICAg
ICAgICAgICAgICAgICAgICAgImNwdV9zZXRfZXhjZXB0aW9uX2Jhc2U6IGludmFsaWQgdnBfaW5k
ZXg6ICV1IiwNCj4+ICsgICAgICAgICAgICAgICAgICAgICAgdnBfaW5kZXgpOw0KPj4gKyAgICB9
DQo+PiArICAgIFJJU0NWQ1BVICp2cCA9IFJJU0NWX0NQVShjcHVfc3RhdGUpOw0KPj4gKyAgICB2
cC0+ZW52LnJlc2V0dmVjID0gYWRkcmVzczsNCj4+ICt9DQo+PiArI2VuZGlmDQo+PiArDQo+PiAg
IHN0YXRpYyB2b2lkIHJpc2N2X2NwdV9jZmdfbWVyZ2UoUklTQ1ZDUFVDb25maWcgKmRlc3QsIGNv
bnN0IFJJU0NWQ1BVQ29uZmlnICpzcmMpDQo+PiAgIHsNCj4+ICAgI2RlZmluZSBCT09MX0ZJRUxE
KHgpIGRlc3QtPnggfD0gc3JjLT54Ow0KPj4gZGlmZiAtLWdpdCBhL3RhcmdldC9yaXNjdi9jcHUu
aCBiL3RhcmdldC9yaXNjdi9jcHUuaA0KPj4gaW5kZXggNGE4NjJkYTYxNS4uMzQ3NTFiZDQxNCAx
MDA2NDQNCj4+IC0tLSBhL3RhcmdldC9yaXNjdi9jcHUuaA0KPj4gKysrIGIvdGFyZ2V0L3Jpc2N2
L2NwdS5oDQo+PiBAQCAtNjcyLDYgKzY3MiwxMCBAQCBHX05PUkVUVVJOIHZvaWQgcmlzY3ZfcmFp
c2VfZXhjZXB0aW9uKENQVVJJU0NWU3RhdGUgKmVudiwNCj4+ICAgdGFyZ2V0X3Vsb25nIHJpc2N2
X2NwdV9nZXRfZmZsYWdzKENQVVJJU0NWU3RhdGUgKmVudik7DQo+PiAgIHZvaWQgcmlzY3ZfY3B1
X3NldF9mZmxhZ3MoQ1BVUklTQ1ZTdGF0ZSAqZW52LCB0YXJnZXRfdWxvbmcpOw0KPj4NCj4+ICsj
aWZuZGVmIENPTkZJR19VU0VSX09OTFkNCj4+ICt2b2lkIGNwdV9zZXRfZXhjZXB0aW9uX2Jhc2Uo
aW50IHZwX2luZGV4LCB0YXJnZXRfdWxvbmcgYWRkcmVzcyk7DQo+PiArI2VuZGlmDQo+PiArDQo+
PiAgIEZJRUxEKFRCX0ZMQUdTLCBNRU1fSURYLCAwLCAzKQ0KPj4gICBGSUVMRChUQl9GTEFHUywg
RlMsIDMsIDIpDQo+PiAgIC8qIFZlY3RvciBmbGFncyAqLw0KPj4gLS0NCj4+IDIuMzQuMQ==

