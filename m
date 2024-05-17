Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C8B1C04FFE
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2024 13:14:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7xOt-0002vg-Lh; Fri, 17 May 2024 09:13:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1s7xOr-0002vS-Cd
 for qemu-devel@nongnu.org; Fri, 17 May 2024 09:13:29 -0400
Received: from smarthost4.eviden.com ([80.78.11.85])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1s7xOo-00007w-A5
 for qemu-devel@nongnu.org; Fri, 17 May 2024 09:13:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1715951606; x=1747487606;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=KGqzeLNug9h6JKt6oieDOSz2FBzBNcfiRIfeXl7SPmw=;
 b=po0xONCapBip9af30aGHBtyw1PyDWE/uR82YBXhgKQRR++GKCaGZQZ2a
 UZO8MqXeVnf1E/XtKh2cdZTorRNIxQM7QVmuTjBUy/+6MWQPlXkZVCLID
 QV1Mm+nJYBjR6Ft7ymu2yIiXQiNbc4FG+LUIP2D9I9YhmTRZeW+L7IGGz
 QTcYk8flKi4TfNwMhFd37kLsKDrD1mT8pGb3QCY09RfoiFtncpihLAStT
 30zFtgpSQBqRfSs5w6TZNluazRqbnpWiImVBwgJORx+yvqE9db/ZEQPZm
 IGY/hsH6f4ThYujAmUOqbOAYmeKd/Zh72PHUOtEovT0dB3TrmwUs+YeOu g==;
X-IronPort-AV: E=Sophos;i="6.08,167,1712613600"; d="scan'208";a="12844630"
X-MGA-submission: =?us-ascii?q?MDFFAHIS9noCjJbOq/CwZX8QblKX7tEkVAm9W4?=
 =?us-ascii?q?lu3VzBdMEo2jAzqQ/mInEtxScdvxWFQr48z/6479I7F5zuqhy0dajIRv?=
 =?us-ascii?q?pZYVyUt2Aboyc4iYmD3Fpe6XQ3W/n+P5RB2qQ1irHZlmqms0bBR0j7/b?=
 =?us-ascii?q?E+nnCqwLer2zGGFJGpqrjL1A=3D=3D?=
Received: from mail-ve1eur01lp2050.outbound.protection.outlook.com (HELO
 EUR01-VE1-obe.outbound.protection.outlook.com) ([104.47.1.50])
 by smarthost4.eviden.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 May 2024 15:13:22 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NGuKnYC2xD2rhFRFHtw7FvihmlSdiFYwj8yG251ZOUFTBK4d9vJOaHgffRxGz6GnXYF9KgMwWiXf6wvwhxBi+88i8uCBZoJHk4zAno0wpxx6XZP45LGsgQKWAeHvQMTVkybdtICf9wjQ5VTGNcOWuPRM/TotndLcYbLfAxR9+yFISQ6l/t3FyiKfTNxmt/5CVEqBwXsmHoOq415I0s/qHQPUiA8iYLId7gBMu5RuWliGHUSoGrhGtb7KQ87jSzjHU6mjK/B+s5nMnf1TaPLw259yPy/jpXVhkAX+cGjxKclM653wRRt51yW3Wr/3hCWss6vXG7d9UeAAm+/urNnNuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KGqzeLNug9h6JKt6oieDOSz2FBzBNcfiRIfeXl7SPmw=;
 b=PdWz9Qt9Lc2Z/5dpBprVtJZGd0WAIb8Z0qzI6nw/51HKPhf2RZJcu/+jGzVoTyQjpp3q3szfzRJhnYyqtclFvXpVZToOSIlXikG/GNNLJ1OxRtW6egwvzsByIgdQEnT8KteYKp0V0TEXX32Qix+O5ci/bIrcbC2eunGfh1PiRE4HRv20YrCb+RPpITWoziy8wlbhyae3YyYhiebZ5hLY+esugFkkSPzuLdL8Vs8scusNeReuXyO1WGaHE4CSw75Wf+F0GW6MJVKpz5QFYLK8T/tbTqaU7re83kn1Hlu6IHjFhnsAyzsfhE0/YLx9LYzPrUkHvHTszksnnY6znmKxbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by AS4PR07MB8629.eurprd07.prod.outlook.com (2603:10a6:20b:4ff::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Fri, 17 May
 2024 13:13:19 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%5]) with mapi id 15.20.7587.028; Fri, 17 May 2024
 13:13:19 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "yi.l.liu@intel.com" <yi.l.liu@intel.com>, "chao.p.peng@intel.com"
 <chao.p.peng@intel.com>, Yu Zhang <yu.c.zhang@linux.intel.com>, "Michael S.
 Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Marcel Apfelbaum
 <marcel.apfelbaum@gmail.com>
Subject: Re: [PATCH] intel_iommu: Use the latest fault reasons defined by spec
Thread-Topic: [PATCH] intel_iommu: Use the latest fault reasons defined by spec
Thread-Index: AQHaqETF994sGJc2f06J4v32nB22BLGbZ2IA
Date: Fri, 17 May 2024 13:13:19 +0000
Message-ID: <02ee8c65-54a8-4ce4-a4a0-351f29f3eea6@eviden.com>
References: <20240517102334.81943-1-zhenzhong.duan@intel.com>
In-Reply-To: <20240517102334.81943-1-zhenzhong.duan@intel.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|AS4PR07MB8629:EE_
x-ms-office365-filtering-correlation-id: fe0a8295-4949-4fdb-c85c-08dc76731f16
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230031|7416005|366007|1800799015|376005|38070700009; 
x-microsoft-antispam-message-info: =?utf-8?B?S1BsTi9vSlJWSjArUy83dVZvNVpNS0Zqc2p6MzFmN1pnY1k0SFR0OVVRcTVz?=
 =?utf-8?B?NmFBSWt3RnU5aThyV3hkTVdxSUNMamRRVkMyS2xVL2hYeSt1MkoxYzM1Zk5m?=
 =?utf-8?B?MDBkUzBUMit0NFdzN0tDU2dDRWx2d2xxVGdyalBwVk9qaGFwVURrbXJ6UGpC?=
 =?utf-8?B?U1FQanRIaVlqK0NXTWF1bVFPVnA1bE9ic0VaMzNRNzloLzZtWDZncGJKbXg3?=
 =?utf-8?B?Z1B1b09La0UwWjJnUTNQY0Ryc2E4QWRmcWU0MGxGUjRvbHFPR1FNT3hMMFpR?=
 =?utf-8?B?WDMvc1FHR1loMGZ3L2hzMytCUlc0bHVMckxFT20wSEsvRldPUTBNaEFQbkNT?=
 =?utf-8?B?akQrYmhVbjVWTW5hb1Y0VVJEL2dYTG1Ob0x4bEF0RU5PWlIzMUk1TDZ4dVI3?=
 =?utf-8?B?QU9KK2tzMUVTcnBBQ1c1d1QvbWtvR09YM1o4cDd5TGJCTFJZbzZEa3BjbkNn?=
 =?utf-8?B?cGkxSXFTNWI0ZU9VeVpPUEdRMUR0dk9WV1ZlUWxJTEd4c0ZWR2V6bXNVdmpm?=
 =?utf-8?B?emthTVBPY3o1ZFhEVGM5Nko3Z0ptWXF4REM5ZERNMFZvUmREYXFuUHVldU91?=
 =?utf-8?B?bFZibm1FcUpGLzJKZ0lqaVZycXhXelFMOUNwSm5JWDlOL1ZmUkoxTXpGNlh6?=
 =?utf-8?B?WFRFZ3NtR2VUbWNBRDR6RHBDTWhiODJRWGMybVZBN1VEMFlYRXdoR3l3TFdR?=
 =?utf-8?B?Z2MvcWFpY2JUSXJ3NHZlb3FqeDFiMm45TDAyYXFhUTdCUkp3SWYzT0diaVlZ?=
 =?utf-8?B?S3F1anlPOXN5cUxRVTZXZ3plUUNXNHcxcUhmdkRvTUFhM0hiYXJJQVVvSy9y?=
 =?utf-8?B?RkVDWDJWckUwSFA3TXdqVGlLY2t0OENXaXBHVCs0amUvZ1lXV1FEMjNLd1RU?=
 =?utf-8?B?QXB0T3cvTENiK0FHYkhqQm5Nd1ZXOTBHd3AyMTN0WmpTK0hDN1RLT3FJVFQ2?=
 =?utf-8?B?elg0ZTUwR2JCSUtmZDZ1T1FwSmtwU1B2YkFPWWlCcFB6RG5kOVlMdkJSWnRt?=
 =?utf-8?B?UVcrMEd0eHA1eklpQnY3MnhJVHJuc0YwcE1udHhKTWduajR4Q0dEeUdjNnZU?=
 =?utf-8?B?T3dObkxrNjNWbnZqNlFJQU8rbitoUm5yYmhXZXcrUUxZaGt2VGpDZXhpS3VI?=
 =?utf-8?B?WnBBQVB3M3BnNEU4RFdJZFlaejZqaStRaGc2YUIzZjlDVXNzeW01ME1zK2V0?=
 =?utf-8?B?a2ljbjU0ajliY1BScjAzT2wvZ05OU0pOUHRCM2pMS1BPMzBoTXA0RnVHZlQ5?=
 =?utf-8?B?eklha0p2TU1Wa3VuS2Rsd0Vydjd3a2h0cEFxb0hOZzQyRG9RbjdjRmw5SEVZ?=
 =?utf-8?B?eXpWUVp6c3RQd2lrVmQ4c3RvZkNON3RraGphVGkrbU8rVmFJWkZ4dkRTMVpC?=
 =?utf-8?B?b2p2WWJiTCsrTU9JN0I1TlJaZXhSSE9Kdi9QYlRBSWw0L3ZpakIvWCtmeTNT?=
 =?utf-8?B?Szk5b0c3aUFhbndRS1RnNmZPNDc4Z1EwamlvYlRIbmRTZlhueEphM0NzSERo?=
 =?utf-8?B?OFRwMWJwOUF5WGJEZW9qcWRFTVZ3L2pnVUdZcGRzNWx3Vnh5UWRxZSs0T0VZ?=
 =?utf-8?B?U2hOa0FrTjdRVEZqdVptbU9qZ2E2Rks0bFVRSFJEUDRoL1JwVHE0bCtoczBk?=
 =?utf-8?B?bm9QcUdFZHFNSVhzYmQ3bTdGNWtQNlJIeUIwT1FtY09HOHRBRWYrTTdtcXpk?=
 =?utf-8?B?TENKKzRnVU83S1BIRmp0YXVTUUJncDR5SHQ1aW4xUEh4UWhES0IwSVhYU3dQ?=
 =?utf-8?B?eFpnVm8rMENHMG56Qnc4MEVBOUNyZFNWSklTTUNrZFpOazhKc2V0ek5zcVRv?=
 =?utf-8?B?MTFBc1FZeFFSd3JuWDc1UT09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(7416005)(366007)(1800799015)(376005)(38070700009); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?R1R5dTFwWDNBamNPRnh0bmtHOVR6Q0Nhb0Q3TUFVclUwQVRUU2t0YmVFNjhO?=
 =?utf-8?B?MkVxbG81ejNOcEpSREhmcGpCcjhac0RmMzRtOVZtd25DNElpN2ViSXBSTVRl?=
 =?utf-8?B?Y1BFVkNSWTY0dVJ6TkE1S0pScmh4SWdhM0ZJSE5NekRnOVRhVUdBckJRQXBO?=
 =?utf-8?B?THhPK21BNlozY3FaQkxmL0hnd3RaTzJRV0JJdkEyUmNhSXdaMGF0WCt5UDY3?=
 =?utf-8?B?aHlRazRBMUFkc0ZpbVBid2FpZjFIcmZPMlYwN1ZMd0Q1OWJhV3hUdmxNbXBB?=
 =?utf-8?B?NmxSVDkxQ2pXaVUxM21FdzhDNTc0MGdUTWE5cXFpREZ0L2pra3IyQjlSN29E?=
 =?utf-8?B?OVoyT09IQ3U2WENNR3pqNVpoR3MzSE5NUlVXWEdRb2d4ckhOY0xCTlRpR0JK?=
 =?utf-8?B?Z1NZVDV0SnJHdGE0ZEw5S1JzS0JzZHBoeDcwYURBeE5sVy9abmt5ejV1dUNW?=
 =?utf-8?B?MWt2bDI1WGI2U0VXM3VMdS9wYUJOUHh5OWpOWnQwSHo1ZjVtZkJ4MWZWUUtM?=
 =?utf-8?B?ZDUxM1c0NzV1SGMvSzc3MW1vVFFtY2lWZFdZK1VEQ3lKVjJpazQ1VlRmZkNF?=
 =?utf-8?B?N0lhdEUzOU5GZzh0RG9IM3hQNk1sdWxiWGFkdllzQ1g5b0l6VU9Fb1lnajFX?=
 =?utf-8?B?OGhpTUdLc2dpV0tXSWk0MlFOM3VLZHQ5SCtxZ1JuTDg5cmxVRk5MVGJFMlhT?=
 =?utf-8?B?MmxxNmFBd00rSWNGRUN5NVBacDhHVGR3RFI2YXBacDFZUUR5ckdOb1FTYzV2?=
 =?utf-8?B?M2RWeDRjMDA5Q29BaTJGL2V1UTV2RGxOQXpTUDdpc3l6N2J2dGluWjFKVzZH?=
 =?utf-8?B?aitCZmI4S3I0OGhwRDkyWUdDeU5hMmh1NlVLdFRocDBXY290S29FWmlRUVdY?=
 =?utf-8?B?MkE5UFYydTlPSDkwUDAyL3llb0Nvd0p6bFh6blMzekdJREtvUW5IMGcrcWhL?=
 =?utf-8?B?dXFXbVVRLy8wMXlUU210WkZHVngyVXBuMTdrUDNmVXB6N1NwTUVMYjdqYlRW?=
 =?utf-8?B?REROMDdSdGhtTk5QUXFwdVpDODVYSDFlSnB6Z0RuL1JkUFhHd0xGek52Rk0z?=
 =?utf-8?B?TG1HNkd2eXBKQXlkTkl1SG80RW10THYyRjlTZzh2NzhVZEdvczBEc2pUVkhN?=
 =?utf-8?B?Y2hBQktVYjFQQy9UdWc4dDBBVmliZ2tUSlE0bTBLTFdUK0ZIRWdkY0NoZTQ5?=
 =?utf-8?B?MU5YZExEU1hJU0N0bjZkTW5naG1WOFRvcjRQU3B0U0g2L0pCRkI2and1emtD?=
 =?utf-8?B?bzB2V0JMZWNBd3pjRHR4SmFRamJ2d243NUlMNC9SM0x6OVhqTXdCVmZldWRn?=
 =?utf-8?B?L2E5cTNzRXlFeGdaVStPLzVGWmVNQTMrS0ZNeDdmbFhLNXdueU1xTVhBcGhs?=
 =?utf-8?B?aHhUdVp0K3hvQzU1Q1VqT1ZXc0dleHNYaVZuclJSVVdGTHlqRzlZY1BWc3RT?=
 =?utf-8?B?YTZGQzRLUWVpMlo1YzRmVVc2RngyRFVQS0hTMS8zV2lkbE5kVzZXSEllK21w?=
 =?utf-8?B?NjY3K0pkQnV5UURJUzM4ZXIwaUw4aGs4RWIzUjhxOWE5SkVvNFZOOC9RdHM2?=
 =?utf-8?B?SE82MGlIYTJqZkhCSjUyaEtvM3Z0OFozQmVmVmJUWUxDM0YvaTJ2R3FJdGlk?=
 =?utf-8?B?MG5MeW9ZZVlXc3NwVVRVY1ZjcUVoVjErRmJmbU5mQzdETlZRd1k2T2dlbWFI?=
 =?utf-8?B?RlloOGE1ZUFTY0lKQ3Z3bW14Y3dIZHpvS05xamJGMFlxOWd0Nm5yQ1huc1ZO?=
 =?utf-8?B?UGVNT2xTVzBXaW93WStXOFZzV09QVUtoNGNyc1NyUDV3d0dCQnhUZWk4OEQ1?=
 =?utf-8?B?YnNWQkFZZ3RwYXNCZXNOb2ZJTEJ3MGp3akJoZVFZT1JOQStGZm0wQ3pzWkR6?=
 =?utf-8?B?ZGxsQlBzWVVDeFl6UDdlOTZIUDMwcGlhQTRrRFBuZFpKc09yNlhLUTROR1JG?=
 =?utf-8?B?aURzNG1qUnQzaHVXVEZ5UTNCbncxWnZnTlVDWGlLaUN6TjluYW1XS1ZVZWlj?=
 =?utf-8?B?SFg5OFBTOUtvaFlVWVNKR1BpSkV0dGxXUU9MelBWYzFqa3RWV1lCMkJENVBs?=
 =?utf-8?B?dWZzSkF4Q3Jvci9QZmtDb1RZQ0xwZ1ZXT0NhWDY0K29ONFZoVHo0VEg3NDRl?=
 =?utf-8?B?OGVINWxKdk5CeWx4Zjk1QUYzcVdHVE5IbHQzL01jQnFqMjF6eFdoUlhNMEQ0?=
 =?utf-8?Q?U1+7q6OHIPW1tgheqE76vkA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CD04E64F82E7C44E81B8B87EF59EADC8@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe0a8295-4949-4fdb-c85c-08dc76731f16
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 May 2024 13:13:19.4602 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2AaDKHLW79oqz13/xLc9osXzhiAGFYO1c1D9w0F0fzNioqYVRTNtrVQ0FUlYbE+QIEA9oZt/iV4Pc/0j5kirzO4Crs66+mGwIgvAVE09a225kBTasOkZDXXO69zXYmZW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR07MB8629
Received-SPF: pass client-ip=80.78.11.85;
 envelope-from=clement.mathieu--drif@eviden.com; helo=smarthost4.eviden.com
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

SGkgWmhlbnpob25nDQoNCk9uIDE3LzA1LzIwMjQgMTI6MjMsIFpoZW56aG9uZyBEdWFuIHdyb3Rl
Og0KPiBDYXV0aW9uOiBFeHRlcm5hbCBlbWFpbC4gRG8gbm90IG9wZW4gYXR0YWNobWVudHMgb3Ig
Y2xpY2sgbGlua3MsIHVubGVzcyB0aGlzIGVtYWlsIGNvbWVzIGZyb20gYSBrbm93biBzZW5kZXIg
YW5kIHlvdSBrbm93IHRoZSBjb250ZW50IGlzIHNhZmUuDQo+DQo+DQo+IEZyb206IFl1IFpoYW5n
IDx5dS5jLnpoYW5nQGxpbnV4LmludGVsLmNvbT4NCj4NCj4gQ3VycmVudGx5IHdlIHVzZSBvbmx5
IFZURF9GUl9QQVNJRF9UQUJMRV9JTlYgYXMgZmF1bHQgcmVhc29uLg0KPiBVcGRhdGUgd2l0aCBt
b3JlIGRldGFpbGVkIGZhdWx0IHJlYXNvbnMgbGlzdGVkIGluIFZULWQgc3BlYyA3LjIuMy4NCj4N
Cj4gU2lnbmVkLW9mZi1ieTogWXUgWmhhbmcgPHl1LmMuemhhbmdAbGludXguaW50ZWwuY29tPg0K
PiBTaWduZWQtb2ZmLWJ5OiBaaGVuemhvbmcgRHVhbiA8emhlbnpob25nLmR1YW5AaW50ZWwuY29t
Pg0KPiAtLS0NCj4gICBody9pMzg2L2ludGVsX2lvbW11X2ludGVybmFsLmggfCAgOCArKysrKysr
LQ0KPiAgIGh3L2kzODYvaW50ZWxfaW9tbXUuYyAgICAgICAgICB8IDI1ICsrKysrKysrKysrKysr
KystLS0tLS0tLS0NCj4gICAyIGZpbGVzIGNoYW5nZWQsIDIzIGluc2VydGlvbnMoKyksIDEwIGRl
bGV0aW9ucygtKQ0KPg0KPiBkaWZmIC0tZ2l0IGEvaHcvaTM4Ni9pbnRlbF9pb21tdV9pbnRlcm5h
bC5oIGIvaHcvaTM4Ni9pbnRlbF9pb21tdV9pbnRlcm5hbC5oDQo+IGluZGV4IGY4Y2Y5OWJkZGYu
LjY2NmUyY2YyY2UgMTAwNjQ0DQo+IC0tLSBhL2h3L2kzODYvaW50ZWxfaW9tbXVfaW50ZXJuYWwu
aA0KPiArKysgYi9ody9pMzg2L2ludGVsX2lvbW11X2ludGVybmFsLmgNCj4gQEAgLTMxMSw3ICsz
MTEsMTMgQEAgdHlwZWRlZiBlbnVtIFZUREZhdWx0UmVhc29uIHsNCj4gICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgKiByZXF1ZXN0IHdoaWxlIGRpc2FibGVkICovDQo+ICAgICAg
IFZURF9GUl9JUl9TSURfRVJSID0gMHgyNiwgICAvKiBJbnZhbGlkIFNvdXJjZS1JRCAqLw0KPg0K
PiAtICAgIFZURF9GUl9QQVNJRF9UQUJMRV9JTlYgPSAweDU4LCAgLypJbnZhbGlkIFBBU0lEIHRh
YmxlIGVudHJ5ICovDQo+ICsgICAgLyogUEFTSUQgZGlyZWN0b3J5IGVudHJ5IGFjY2VzcyBmYWls
dXJlICovDQo+ICsgICAgVlREX0ZSX1BBU0lEX0RJUl9BQ0NFU1NfRVJSID0gMHg1MCwNCj4gKyAg
ICAvKiBUaGUgUHJlc2VudChQKSBmaWVsZCBvZiBwYXNpZCBkaXJlY3RvcnkgZW50cnkgaXMgMCAq
Lw0KPiArICAgIFZURF9GUl9QQVNJRF9ESVJfRU5UUllfUCA9IDB4NTEsDQo+ICsgICAgVlREX0ZS
X1BBU0lEX1RBQkxFX0FDQ0VTU19FUlIgPSAweDU4LCAvKiBQQVNJRCB0YWJsZSBlbnRyeSBhY2Nl
c3MgZmFpbHVyZSAqLw0KPiArICAgIFZURF9GUl9QQVNJRF9FTlRSWV9QID0gMHg1OSwgLyogVGhl
IFByZXNlbnQoUCkgZmllbGQgb2YgcGFzaWR0LWVudHJ5IGlzIDAgKi8NCnMvcGFzaWR0L3Bhc2lk
DQo+ICsgICAgVlREX0ZSX1BBU0lEX1RBQkxFX0VOVFJZX0lOViA9IDB4NWIsICAvKkludmFsaWQg
UEFTSUQgdGFibGUgZW50cnkgKi8NCj4NCj4gICAgICAgLyogT3V0cHV0IGFkZHJlc3MgaW4gdGhl
IGludGVycnVwdCBhZGRyZXNzIHJhbmdlIGZvciBzY2FsYWJsZSBtb2RlICovDQo+ICAgICAgIFZU
RF9GUl9TTV9JTlRFUlJVUFRfQUREUiA9IDB4ODcsDQo+IGRpZmYgLS1naXQgYS9ody9pMzg2L2lu
dGVsX2lvbW11LmMgYi9ody9pMzg2L2ludGVsX2lvbW11LmMNCj4gaW5kZXggY2M4ZTU5Njc0ZS4u
MDk1MWViYjcxZCAxMDA2NDQNCj4gLS0tIGEvaHcvaTM4Ni9pbnRlbF9pb21tdS5jDQo+ICsrKyBi
L2h3L2kzODYvaW50ZWxfaW9tbXUuYw0KPiBAQCAtNzcxLDcgKzc3MSw3IEBAIHN0YXRpYyBpbnQg
dnRkX2dldF9wZGlyZV9mcm9tX3BkaXJfdGFibGUoZG1hX2FkZHJfdCBwYXNpZF9kaXJfYmFzZSwN
Cj4gICAgICAgYWRkciA9IHBhc2lkX2Rpcl9iYXNlICsgaW5kZXggKiBlbnRyeV9zaXplOw0KPiAg
ICAgICBpZiAoZG1hX21lbW9yeV9yZWFkKCZhZGRyZXNzX3NwYWNlX21lbW9yeSwgYWRkciwNCj4g
ICAgICAgICAgICAgICAgICAgICAgICAgICBwZGlyZSwgZW50cnlfc2l6ZSwgTUVNVFhBVFRSU19V
TlNQRUNJRklFRCkpIHsNCj4gLSAgICAgICAgcmV0dXJuIC1WVERfRlJfUEFTSURfVEFCTEVfSU5W
Ow0KPiArICAgICAgICByZXR1cm4gLVZURF9GUl9QQVNJRF9ESVJfQUNDRVNTX0VSUjsNCj4gICAg
ICAgfQ0KPg0KPiAgICAgICBwZGlyZS0+dmFsID0gbGU2NF90b19jcHUocGRpcmUtPnZhbCk7DQo+
IEBAIC03ODksNiArNzg5LDcgQEAgc3RhdGljIGludCB2dGRfZ2V0X3BlX2luX3Bhc2lkX2xlYWZf
dGFibGUoSW50ZWxJT01NVVN0YXRlICpzLA0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIGRtYV9hZGRyX3QgYWRkciwNCj4gICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICBWVERQQVNJREVudHJ5ICpwZSkNCj4gICB7DQo+ICsgICAg
dWludDhfdCBwZ3R0Ow0KPiAgICAgICB1aW50MzJfdCBpbmRleDsNCj4gICAgICAgZG1hX2FkZHJf
dCBlbnRyeV9zaXplOw0KPiAgICAgICBYODZJT01NVVN0YXRlICp4ODZfaW9tbXUgPSBYODZfSU9N
TVVfREVWSUNFKHMpOw0KPiBAQCAtNzk4LDcgKzc5OSw3IEBAIHN0YXRpYyBpbnQgdnRkX2dldF9w
ZV9pbl9wYXNpZF9sZWFmX3RhYmxlKEludGVsSU9NTVVTdGF0ZSAqcywNCj4gICAgICAgYWRkciA9
IGFkZHIgKyBpbmRleCAqIGVudHJ5X3NpemU7DQo+ICAgICAgIGlmIChkbWFfbWVtb3J5X3JlYWQo
JmFkZHJlc3Nfc3BhY2VfbWVtb3J5LCBhZGRyLA0KPiAgICAgICAgICAgICAgICAgICAgICAgICAg
IHBlLCBlbnRyeV9zaXplLCBNRU1UWEFUVFJTX1VOU1BFQ0lGSUVEKSkgew0KPiAtICAgICAgICBy
ZXR1cm4gLVZURF9GUl9QQVNJRF9UQUJMRV9JTlY7DQo+ICsgICAgICAgIHJldHVybiAtVlREX0ZS
X1BBU0lEX1RBQkxFX0FDQ0VTU19FUlI7DQo+ICAgICAgIH0NCj4gICAgICAgZm9yIChzaXplX3Qg
aSA9IDA7IGkgPCBBUlJBWV9TSVpFKHBlLT52YWwpOyBpKyspIHsNCj4gICAgICAgICAgIHBlLT52
YWxbaV0gPSBsZTY0X3RvX2NwdShwZS0+dmFsW2ldKTsNCj4gQEAgLTgwNiwxMSArODA3LDEzIEBA
IHN0YXRpYyBpbnQgdnRkX2dldF9wZV9pbl9wYXNpZF9sZWFmX3RhYmxlKEludGVsSU9NTVVTdGF0
ZSAqcywNCj4NCj4gICAgICAgLyogRG8gdHJhbnNsYXRpb24gdHlwZSBjaGVjayAqLw0KPiAgICAg
ICBpZiAoIXZ0ZF9wZV90eXBlX2NoZWNrKHg4Nl9pb21tdSwgcGUpKSB7DQo+IC0gICAgICAgIHJl
dHVybiAtVlREX0ZSX1BBU0lEX1RBQkxFX0lOVjsNCj4gKyAgICAgICAgcmV0dXJuIC1WVERfRlJf
UEFTSURfVEFCTEVfRU5UUllfSU5WOw0KPiAgICAgICB9DQo+DQo+IC0gICAgaWYgKCF2dGRfaXNf
bGV2ZWxfc3VwcG9ydGVkKHMsIFZURF9QRV9HRVRfTEVWRUwocGUpKSkgew0KPiAtICAgICAgICBy
ZXR1cm4gLVZURF9GUl9QQVNJRF9UQUJMRV9JTlY7DQo+ICsgICAgcGd0dCA9IFZURF9QRV9HRVRf
VFlQRShwZSk7DQo+ICsgICAgaWYgKHBndHQgPT0gVlREX1NNX1BBU0lEX0VOVFJZX1NMVCAmJg0K
PiArICAgICAgICAhdnRkX2lzX2xldmVsX3N1cHBvcnRlZChzLCBWVERfUEVfR0VUX0xFVkVMKHBl
KSkpIHsNCj4gKyAgICAgICAgICAgIHJldHVybiAtVlREX0ZSX1BBU0lEX1RBQkxFX0VOVFJZX0lO
VjsNCj4gICAgICAgfQ0KPg0KPiAgICAgICByZXR1cm4gMDsNCj4gQEAgLTg1MSw3ICs4NTQsNyBA
QCBzdGF0aWMgaW50IHZ0ZF9nZXRfcGVfZnJvbV9wYXNpZF90YWJsZShJbnRlbElPTU1VU3RhdGUg
KnMsDQo+ICAgICAgIH0NCj4NCj4gICAgICAgaWYgKCF2dGRfcGRpcmVfcHJlc2VudCgmcGRpcmUp
KSB7DQo+IC0gICAgICAgIHJldHVybiAtVlREX0ZSX1BBU0lEX1RBQkxFX0lOVjsNCj4gKyAgICAg
ICAgcmV0dXJuIC1WVERfRlJfUEFTSURfRElSX0VOVFJZX1A7DQo+ICAgICAgIH0NCj4NCj4gICAg
ICAgcmV0ID0gdnRkX2dldF9wZV9mcm9tX3BkaXJlKHMsIHBhc2lkLCAmcGRpcmUsIHBlKTsNCj4g
QEAgLTg2MCw3ICs4NjMsNyBAQCBzdGF0aWMgaW50IHZ0ZF9nZXRfcGVfZnJvbV9wYXNpZF90YWJs
ZShJbnRlbElPTU1VU3RhdGUgKnMsDQo+ICAgICAgIH0NCj4NCj4gICAgICAgaWYgKCF2dGRfcGVf
cHJlc2VudChwZSkpIHsNCj4gLSAgICAgICAgcmV0dXJuIC1WVERfRlJfUEFTSURfVEFCTEVfSU5W
Ow0KPiArICAgICAgICByZXR1cm4gLVZURF9GUl9QQVNJRF9FTlRSWV9QOw0KPiAgICAgICB9DQo+
DQo+ICAgICAgIHJldHVybiAwOw0KPiBAQCAtOTEzLDcgKzkxNiw3IEBAIHN0YXRpYyBpbnQgdnRk
X2NlX2dldF9wYXNpZF9mcGQoSW50ZWxJT01NVVN0YXRlICpzLA0KPiAgICAgICB9DQo+DQo+ICAg
ICAgIGlmICghdnRkX3BkaXJlX3ByZXNlbnQoJnBkaXJlKSkgew0KPiAtICAgICAgICByZXR1cm4g
LVZURF9GUl9QQVNJRF9UQUJMRV9JTlY7DQo+ICsgICAgICAgIHJldHVybiAtVlREX0ZSX1BBU0lE
X0RJUl9FTlRSWV9QOw0KPiAgICAgICB9DQo+DQo+ICAgICAgIC8qDQo+IEBAIC0xNzcwLDcgKzE3
NzMsMTEgQEAgc3RhdGljIGNvbnN0IGJvb2wgdnRkX3F1YWxpZmllZF9mYXVsdHNbXSA9IHsNCj4g
ICAgICAgW1ZURF9GUl9ST09UX0VOVFJZX1JTVkRdID0gZmFsc2UsDQo+ICAgICAgIFtWVERfRlJf
UEFHSU5HX0VOVFJZX1JTVkRdID0gdHJ1ZSwNCj4gICAgICAgW1ZURF9GUl9DT05URVhUX0VOVFJZ
X1RUXSA9IHRydWUsDQo+IC0gICAgW1ZURF9GUl9QQVNJRF9UQUJMRV9JTlZdID0gZmFsc2UsDQo+
ICsgICAgW1ZURF9GUl9QQVNJRF9ESVJfQUNDRVNTX0VSUl0gPSBmYWxzZSwNCj4gKyAgICBbVlRE
X0ZSX1BBU0lEX0RJUl9FTlRSWV9QXSA9IHRydWUsDQo+ICsgICAgW1ZURF9GUl9QQVNJRF9UQUJM
RV9BQ0NFU1NfRVJSXSA9IGZhbHNlLA0KPiArICAgIFtWVERfRlJfUEFTSURfRU5UUllfUF0gPSB0
cnVlLA0KPiArICAgIFtWVERfRlJfUEFTSURfVEFCTEVfRU5UUllfSU5WXSA9IHRydWUsDQo+ICAg
ICAgIFtWVERfRlJfU01fSU5URVJSVVBUX0FERFJdID0gdHJ1ZSwNCj4gICAgICAgW1ZURF9GUl9N
QVhdID0gZmFsc2UsDQo+ICAgfTsNCj4gLS0NCj4gMi4zNC4xDQo+DQo+DQpsZ3Rt

