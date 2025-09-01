Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73552CA0FFD
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Sep 2025 08:18:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uszjy-0003cb-CV; Mon, 01 Sep 2025 04:18:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1uszjs-0003bn-6r; Mon, 01 Sep 2025 04:18:09 -0400
Received: from mail-francecentralazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c20a::7] helo=PA4PR04CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1uszjl-0006bt-Pv; Mon, 01 Sep 2025 04:18:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gr9UTO5aVqJM9NppGhEaXfQ1VTFnbzdYSOYINUluF4SLLrJ77aNOjY02/e/cnW6ciN9o0Tq9GnFYzs4FWYjhj+Z6hat8reXaeNn7Wc26r2B56T3as0fJoYUPbPvaJjwA2KxMWBGvsp/3Eqn70Nt5XWSVYWOe7YdVU1MGMXxSoNR3qrqdbc69QnTOeQQM9P7n8A23r4h+qVNVq9UIaDRt33xJX64GvG0rFhuuNZpKMGfYfK/TSkNAF+EKJZ03DwxqhxZzteyFNqGyQES2C2+wjzv85Rl04FQg7pDghATPu36y2axbAgMw5mlXZQzINtcPz51061NKXem689nxlukWrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t/6E4k8zOX89U8NLxGK+cdPbmgUzrRsAHSnxH8cgZVo=;
 b=MqVnKFhu9l2+IUNEGuWn42PwySp/FVCAmPacX7mByrbtoy0ySz58LFrZltHBXNHWVgPtD7Woh24KTNUYrlmQjjq5l3mfX7VNhe8RRcwTrLzWowbcxVGPENgQsSdyCtWeXMag1KIGLsMRlDLJvs6+c3Ws9AsIgRHYWiCT7o2xtSZrj/pK8We+7CVDv/7e7xw+Y0zQhuc73hEyszFXjhgcvhQRj9qQ6uhSX8k+pp7m3lE5evvuNC59sBshas5OtsyOcP2R/ZW/dUj2Y/aWi3nKCFjakv4QID6+zcOErdqDUvs98/fdgFEsdLyTTjQoKSOB26jd9cshzZqvOoW4vuX0yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t/6E4k8zOX89U8NLxGK+cdPbmgUzrRsAHSnxH8cgZVo=;
 b=eKUt7WKCXZFSsy92J8bfFTVM37iQeeIgBJapfzRdtZBtF+q0imZCq35UZ+jQ9JO9RLs3hGVSE4pFBZ/Ehzuus8ekMA7wJBm7FoyrkVTxOpgxTyRmYPaYCHUfThKTYVwWN7on7Syqp42VZZNQv2PiVGmAM9fm8AMF5Jd1B2xhBxJo1oLz64MVjQ+meNz1fy/fV6DIRgHN8Hdqc6F1d9X2aJOBUINGxzB25EDMCge9GzxQMQMPecRjo/doRgOSDB2T1QeBs1+1xrlkeTHJ5btLl2ic9MW4VcZBaMydY/71hH3KUTtkJer3G5xoLvmyFBLLyCyfOg37DgR41Z0NupYA8A==
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com (2603:10a6:20b:4fb::5)
 by PA2PR09MB7280.eurprd09.prod.outlook.com (2603:10a6:102:40c::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.21; Mon, 1 Sep
 2025 08:17:56 +0000
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a]) by AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a%4]) with mapi id 15.20.9052.019; Mon, 1 Sep 2025
 08:17:54 +0000
From: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
To: =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "cfu@mips.com"
 <cfu@mips.com>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>
Subject: Re: [PATCH v6 03/14] target/riscv: Add MIPS P8700 CPU
Thread-Topic: [PATCH v6 03/14] target/riscv: Add MIPS P8700 CPU
Thread-Index: AQHb9v6Vpe1TlVo22kuJ6Dgs5NcocbRZHoQAgCUlUwA=
Date: Mon, 1 Sep 2025 08:17:54 +0000
Message-ID: <df3bfce7-7f7c-4301-8821-f48cc0e6fb6e@htecgroup.com>
References: <20250717093833.402237-1-djordje.todorovic@htecgroup.com>
 <20250717093833.402237-4-djordje.todorovic@htecgroup.com>
 <18b51ea3-abea-4a1e-ae48-43bf12bb9afc@linaro.org>
In-Reply-To: <18b51ea3-abea-4a1e-ae48-43bf12bb9afc@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS4PR09MB6518:EE_|PA2PR09MB7280:EE_
x-ms-office365-filtering-correlation-id: b22af439-3069-48ee-014b-08dde9300d41
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?dFE5WjJYMGFZZzR6M2lMNWhrSnRxZy93b1ZXcnlrdkxhWHBCRmRaZyt6dVVv?=
 =?utf-8?B?M2NkRXVKaTY1MjhKNlh2b1JVY0lOaHVDNnVybFpYR2M0Wlk5U3pPODNRejdn?=
 =?utf-8?B?czRBRXpvaThOM09vSm0rNGpOcFdZUkZkWUF2S3llMVVTdFQxeW4vSHFHOWFm?=
 =?utf-8?B?TlFjTEpXWVdEdHF4M3VaL1hBR3J5WnN0alVyL2FUd0VEMXM3RWVCby90cStD?=
 =?utf-8?B?aDZ6UUpyUFJ4S3Jhbms1RENGOFd0U2tueW4vWHYxNFZJNEFGZFBpZEpuSmkw?=
 =?utf-8?B?ZE9NMkowVDFjaE15NllvVHlvZXhuUXNvc2VFSjBqNGVtVU9OQlNBeDFIdk9L?=
 =?utf-8?B?bEx2RnFKT0JWZ2k5NXlLZHhER1hheDVpVFhHMi94ZnRlMEpjM2ZvREdMR1dv?=
 =?utf-8?B?bSsxUWpWdUNxVVpvNFdYczlxb2JYN1Jtb2FaVmplSHVXbE0waURaaDZyNjdx?=
 =?utf-8?B?NjQ4V2pPZlpzaHFLRk1KYy9yZzNmVGl2MzgySkR2bWpCcUpPQTRJdStmWngw?=
 =?utf-8?B?S1R1d3QyaHV3NFNTUGdEMndQc1J1NC9WTW4yQWhRZ05DRzR4ckMvMkNUOUwx?=
 =?utf-8?B?MlIwMmNXZTZtMVk0dHFHUXdQWkRpSnB0SFJhMDFDemlrN09UczVCd0dydlhB?=
 =?utf-8?B?dytqOWpFZEw3Y1pSb1BIYXdQZ1IzVFhlTGkvNjdSY1V3SjlTa0JVNHVYbFpm?=
 =?utf-8?B?cXY3Skc5L0NyL3JvUFA1UlJ2MUZQR2VSUVpDU2tYbjNWTGtZL0dtcnZPUUpw?=
 =?utf-8?B?VThSRXJkNlhJQVJ3b0NpVzBWSTlaQVJpa0NmQU5rOWRyV1pLNnZhQUkxZCtE?=
 =?utf-8?B?cVFVNDFoV2VMQ0VzTFExWmFDbVRqZUZsaXpDcjIrMWpld1RFclpzZHM0aDc5?=
 =?utf-8?B?TzNsRms2Zm9CdnhtN0RoYTlDZHdlajJRa3RLaWluL0thWW9LUGoyTlN2Ujcy?=
 =?utf-8?B?QXdSY2l2eFZoWWplclVrWGJsUUw0VGljUXRQSUVFUUdqWVAwU2UxelZwV05I?=
 =?utf-8?B?eDVnaU16LzBuUkx2Uk41ejRlaURmRWJKQUovaU9oU3AxZTZoT3VKR2J5a3JT?=
 =?utf-8?B?c2hKekxqSzZvMG0zSytvci8vYmZRM2JUVDhtWkpUL1FZTGdDc3VZQlJWMGtE?=
 =?utf-8?B?RDgveWtYTGJQNTRmUzNRUHVwUFk3bnlvTEttT2s3a2lIb2gzdkJjNXNHNk5O?=
 =?utf-8?B?cXZDRUFQcTVKQnBNck9MRkdaNGVIUXVjRzh3dWcrYzhjVXdocTZ2eXg0dnlP?=
 =?utf-8?B?UUVEWmhhL3dPeWFlQk4rN08vcVVxaDV2N1Jld3E0ck02TFU3SHcrZXQwRC9I?=
 =?utf-8?B?cFB0OFJtOFIzb1I5U3NXNEc4eHkyTnRvNXdzdGx4UnR2YXVnNXM1UWRXYXdS?=
 =?utf-8?B?M20yZk03RUtXQVZuR1FZYStqb05CNWZBeDAwc1hMZFFiVVR1SVBoRGZwNXRy?=
 =?utf-8?B?cVdqcXV2UHd5YXQ3QWozd2wxWFNCSEYrVFc4amhFTkx2ZTIybE54cFI4N1hx?=
 =?utf-8?B?UWV0Y2NhaDdyK094cjdKbUNKdzJ1TXdtWTdBWUt0dmVTREFzcEJ3ZUk1MVpa?=
 =?utf-8?B?YXpabTBuVmdOdFJhNVNqVXJsa3hiS2FIRTd3alpQNU5aNEJoVnpoU3pid2VE?=
 =?utf-8?B?c1BjYmo5bis0Ym5RK0lmUlRtRVBHdVdOcjF6V0FwT0Z5bWU5SklrWjkyQUp6?=
 =?utf-8?B?Q2p1Z0xGSWVOV2V5akpHZElFWlVZK2FzaGtpUThMUDlnSGFTQkFpSTh1QlE3?=
 =?utf-8?B?QlI0Y2lzM3lBSGxjR01FYktGb2xyeE1WcmRjN2JiYTlMMXZYbklueDg1Z3dQ?=
 =?utf-8?B?eVA0dWZHTWV6UTI5WEhORVh3NVpkaXpudUNHWURYNjR3TEowVkJvRzN4OU9o?=
 =?utf-8?B?MjlLdVl1MGFYVVlraW91clJ5SkFrVEcyb0tRUldFL0hDYXZsTGtMRC9PeStu?=
 =?utf-8?B?MzZhU2N2TVVBOVl4eDh4SUp1aW8wNmNGaEd3TFZ4L1loWVVjRlBGZ3ZqOXFJ?=
 =?utf-8?Q?b2XoQ4x8+PPV/koBRTCc1UyURYk+Jk=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR09MB6518.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VmJyUGJzbWk4UHI4NTVmSHRoWHpHbnQzcFM1TTBjazVYUnhCMVdyL0YrbGFt?=
 =?utf-8?B?RnBvVHBvMzBiRU53cXNFdmdxd3JwZlVMYVpuZm1xUmdBQ2J0eFFiMkJYOW5r?=
 =?utf-8?B?aXJLMGFDaDRyQVNBNjVNOENmYXE5M3h5Mlp4dTdta2swSDNBSmRYSmw1V0JQ?=
 =?utf-8?B?UEtPRDAxRXZ6QTJvVHQyV09rZjdzMDZEbVlSMk9iTHZLVkZPWFFoVWJ2Yldr?=
 =?utf-8?B?Mk8zUDRiTmRRMzAzVWhxUEwwWDdQTUpnSTQ1TWVaSGxjSkFUT1RzT1pLMk1j?=
 =?utf-8?B?VnlLWTZpWFVzWUdENWNtZ0hMN1NaN2dadlVCWGZtMFRZUDlXSnRlaWtEOVcr?=
 =?utf-8?B?VVkxb3BrRnNHNXlVVVZJZ3ptYmpFRGZHai9TOHJadDBmeDlCQXBLWlBrbG9F?=
 =?utf-8?B?SHZIOGl1WjB3T2o2SWM3cjRPUmFUWm1VbytrOXozdDI0Tld0V01ZbldJV0xT?=
 =?utf-8?B?YUZDYjBxR1lRQ1dpWnBzY2UyenJUNmlpQ0xwNk92Z3pZVGNnbURSWFRRdnlp?=
 =?utf-8?B?UE15eDJ6bFMyT3dqVENzdjRhQnRRSEtLVTE5QTRSUUgyRzlISmNzQ2V0S2lM?=
 =?utf-8?B?K2pKYXBRNXBqUUc1RkVoRWdkSEZPODNaY2R2UHovVnUxQkU1VXFidFZOWXVZ?=
 =?utf-8?B?WFJPdHVHajdUNHcvSElsVlc2azJFSUtlUDJnb3RYUmhTdmczT2pxaUZPS0Zi?=
 =?utf-8?B?SnZ0eGdiUFF0d0N2Y3hRdkxFbE1ScUFBTVp4RGtETHJBNnk4T0E3QVc1SVZ1?=
 =?utf-8?B?VExpaTcwSXN0U3dUNmNmNXRwTE9LN1lyaXVJSDlqNnNSSk4xL1VTYmM5Sm00?=
 =?utf-8?B?ejlmR3N5WGk3MjJCdU9LRTJnY3ZRaHRaSXdEd0tkN1R5a0gvSnV1WGpRMHFh?=
 =?utf-8?B?K1I0WnZpOEsrbytaejZ6RDQ0bjhEbC9IN28vZDYzMERHSlNJRmd5d3J5b1Jv?=
 =?utf-8?B?YiszOFdNMWdJOVlKQ1NrNlVoR1pGRGNEYm80NXNkcU1WUFpCQzBqMGFweTVC?=
 =?utf-8?B?NTlnRk5ydHRuL2puZERyYm9pK2lVckhJOWloMVZ0aWV6VzRJemROaC9XTUJE?=
 =?utf-8?B?UFhYa2hmR1p6Rm5xQ2FDd0dhb1A2bjBXT1JvZ29rR1doVnFEWmpDNTNBeENC?=
 =?utf-8?B?eXNvOFQ3MXZHU3NZejdqNDd5M3VUanlxY3d0YVJieEEwMk5ZK3N4RE82aGxv?=
 =?utf-8?B?SHBaKzRESVJkbE9XZW1SaUlVQjhTSzl4UGxCcDNEekhBTjA0ZlNGTERzRlhN?=
 =?utf-8?B?RzBhcFBxRVhaU1ZXaVFRMlJyQXRkd0NCQkVCOFhhdmtwNVJ3QlhORzA2R2Mx?=
 =?utf-8?B?b2hKL2lpb2VvQ2lmUkdCSWJTRGlXYnY0aCtSYmVrbTc4SmxJdW5zdGpxTlF5?=
 =?utf-8?B?Y0NTYTE0T2dtTkNlcHBLNFdUUVVNZW1GTjZseEwzMm4rcWIvcldPaTg2Uzlm?=
 =?utf-8?B?L3lWVXpYdzRiQjJOSnZmSU9XMkRFaG93c3dyRUs3akd2alEvZHJIbUJlUER2?=
 =?utf-8?B?OWFaRVFnQkZiUDVlQXNBUm5iYmdmR0xpMFB3c2NTMFBSTnZZZFlxd2JRd05i?=
 =?utf-8?B?L2FNN1E1bTd3NFRxdktUL2VMRit0cEZYQUN6SzBhRnlNZHVxTXUwZmJTWGVG?=
 =?utf-8?B?QWs1OWtBWkR5bjMxVUNJUFpjUGpSKzdCWlRWT1c1Y0hSWGVRUnFDZmF2NUdC?=
 =?utf-8?B?czE4QjQwMkwzdVk3bUsvTUkwTkF3azVlNUhjUUduT3VKS29zQnE4c0dGZHNJ?=
 =?utf-8?B?eEIxMHFLclRibFYxazA4Z2ZDaWp5Rk9QUGNHbTNneDVpQ01IbzFjR1YxQUw0?=
 =?utf-8?B?Q3VwNXh1bmZEazlZNmtac1Y4S1AyczhRbHFMZWN0bHcyT1B2UjE1N2tzeG9L?=
 =?utf-8?B?L01hL1lwaGY3Q2U2b2lxT0JxMTlDUmtCeVpDQ2J1ZFdOWk83TlNvL2s0R1Ra?=
 =?utf-8?B?V2lrWlJ3MXR0WDAyRmk0VVQzSFdZd3QxWis5NkZwYnVyQWF4Q3o1c25aWHpj?=
 =?utf-8?B?OTJDWmxSOFdGRDFIR0pScFpCdWNXWml0NDZEOTVCSXhqZDYrbVNhYzNTM0dv?=
 =?utf-8?B?bURsYXR5Rko2Z2trUURvOEVYcmFWK1E4LzV6aTBOSGdNaFhwU2ptQWgxSHFM?=
 =?utf-8?B?TDhPVUlUaENHVHV1Zy9jMFlQRllZZmJHTlFvMXRPL1Z0MUNvL3hjL0JIbmRT?=
 =?utf-8?Q?yL1QknVzkF3aa3nHvHw67lQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <51B78963FA69C64B97E8193FE1BD691A@eurprd09.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS4PR09MB6518.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b22af439-3069-48ee-014b-08dde9300d41
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Sep 2025 08:17:54.6469 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rxP1/BecIXyp5oAe3Nk5CNClqSmWVejWxZT9PRQfSuVxeSp5XE1gTDCLnLvB/jJtHIEQLqkpW1i2JonXCCIXY1Fa0Id3Uy3FmU3LHbS3QEc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR09MB7280
Received-SPF: pass client-ip=2a01:111:f403:c20a::7;
 envelope-from=Djordje.Todorovic@htecgroup.com;
 helo=PA4PR04CU001.outbound.protection.outlook.com
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

DQpPbiA4LiA4LiAyNS4gMTk6MDIsIFBoaWxpcHBlIE1hdGhpZXUtRGF1ZMOpIHdyb3RlOg0KPiBD
QVVUSU9OOiBUaGlzIGVtYWlsIG9yaWdpbmF0ZWQgZnJvbSBvdXRzaWRlIG9mIHRoZSBvcmdhbml6
YXRpb24uIERvIA0KPiBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3Mg
eW91IHJlY29nbml6ZSB0aGUgc2VuZGVyIA0KPiBhbmQga25vdyB0aGUgY29udGVudCBpcyBzYWZl
Lg0KPg0KPg0KPiBPbiAxNy83LzI1IDExOjM4LCBEam9yZGplIFRvZG9yb3ZpYyB3cm90ZToNCj4+
IEludHJvZHVjZSBQODcwMCBDUFUgYnkgTUlQUy4NCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBDaGFv
LXlpbmcgRnUgPGNmdUBtaXBzLmNvbT4NCj4+IFNpZ25lZC1vZmYtYnk6IERqb3JkamUgVG9kb3Jv
dmljIDxkam9yZGplLnRvZG9yb3ZpY0BodGVjZ3JvdXAuY29tPg0KPj4gLS0tDQo+PiDCoCB0YXJn
ZXQvcmlzY3YvY3B1LXFvbS5owqDCoMKgwqDCoCB8wqAgMSArDQo+PiDCoCB0YXJnZXQvcmlzY3Yv
Y3B1LmPCoMKgwqDCoMKgwqDCoMKgwqAgfCAxNSArKysrKysrKysrKysrKysNCj4+IMKgIHRhcmdl
dC9yaXNjdi9jcHVfdmVuZG9yaWQuaCB8wqAgMSArDQo+PiDCoCAzIGZpbGVzIGNoYW5nZWQsIDE3
IGluc2VydGlvbnMoKykNCj4NCj4NCj4+IGRpZmYgLS1naXQgYS90YXJnZXQvcmlzY3YvY3B1LmMg
Yi90YXJnZXQvcmlzY3YvY3B1LmMNCj4+IGluZGV4IGU1ODRiZGM1YWMuLjQwMWMwZjZjN2QgMTAw
NjQ0DQo+PiAtLS0gYS90YXJnZXQvcmlzY3YvY3B1LmMNCj4+ICsrKyBiL3RhcmdldC9yaXNjdi9j
cHUuYw0KPj4gQEAgLTMxODAsNiArMzE4MCwyMSBAQCBzdGF0aWMgY29uc3QgVHlwZUluZm8gcmlz
Y3ZfY3B1X3R5cGVfaW5mb3NbXSA9IHsNCj4+IMKgwqDCoMKgwqDCoMKgwqDCoCAuY2ZnLm1heF9z
YXRwX21vZGUgPSBWTV8xXzEwX1NWMzksDQo+PiDCoMKgwqDCoMKgICksDQo+Pg0KPg0KPiBDYW4g
d2UgYWRkIHRoZSBkYXRhc2hlZXQgbGluayBoZXJlPw0KPg0KPiDCoMKgwqDCoMKgwqAgLyogaHR0
cHM6Ly9taXBzLmNvbS9wcm9kdWN0cy9oYXJkd2FyZS9wODcwMC8gKi8NCj4NClllcywgSSB3aWxs
IGFkZCBpdCBpbiB2Ny4NCg0KDQo+PiArIERFRklORV9SSVNDVl9DUFUoVFlQRV9SSVNDVl9DUFVf
TUlQU19QODcwMCwgVFlQRV9SSVNDVl9WRU5ET1JfQ1BVLA0KPj4gK8KgwqDCoMKgwqDCoMKgIC5t
aXNhX214bF9tYXggPSBNWExfUlY2NCwNCj4+ICvCoMKgwqDCoMKgwqDCoCAubWlzYV9leHQgPSBS
VkkgfCBSVk0gfCBSVkEgfCBSVkYgfCBSVkQgfCBSVkMgfCBSVlMgfCBSVlUsDQo+PiArwqDCoMKg
wqDCoMKgwqAgLnByaXZfc3BlYyA9IFBSSVZfVkVSU0lPTl8xXzEyXzAsDQo+PiArwqDCoMKgwqDC
oMKgwqAgLmNmZy5tYXhfc2F0cF9tb2RlID0gVk1fMV8xMF9TVjQ4LA0KPj4gK8KgwqDCoMKgwqDC
oMKgIC5jZmcuZXh0X3ppZmVuY2VpID0gdHJ1ZSwNCj4+ICvCoMKgwqDCoMKgwqDCoCAuY2ZnLmV4
dF96aWNzciA9IHRydWUsDQo+PiArwqDCoMKgwqDCoMKgwqAgLmNmZy5tbXUgPSB0cnVlLA0KPj4g
K8KgwqDCoMKgwqDCoMKgIC5jZmcucG1wID0gdHJ1ZSwNCj4+ICvCoMKgwqDCoMKgwqDCoCAuY2Zn
LmV4dF96YmEgPSB0cnVlLA0KPj4gK8KgwqDCoMKgwqDCoMKgIC5jZmcuZXh0X3piYiA9IHRydWUs
DQo+PiArwqDCoMKgwqDCoMKgwqAgLmNmZy5tYXJjaGlkID0gMHg4MDAwMDAwMDAwMDAwMjAxLA0K
Pj4gK8KgwqDCoMKgwqDCoMKgIC5jZmcubXZlbmRvcmlkID0gTUlQU19WRU5ET1JfSUQsDQo+PiAr
wqDCoMKgICksDQo+

