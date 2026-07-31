Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D591C5516D
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2026 10:32:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wpkXV-00051f-GK; Fri, 31 Jul 2026 06:32:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=6654ce66d=graf@amazon.de>)
 id 1wpkXN-0004uw-Gh
 for qemu-devel@nongnu.org; Fri, 31 Jul 2026 06:32:27 -0400
Received: from fra-out-009.esa.eu-central-1.outbound.mail-perimeter.amazon.com
 ([3.64.237.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=6654ce66d=graf@amazon.de>)
 id 1wpkXK-0003Ve-Qj
 for qemu-devel@nongnu.org; Fri, 31 Jul 2026 06:32:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
 t=1785493938; x=1817029938;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=fNdQWkleZvJDBZfSvK/cHOZXZqPsPDvPaee6/a7swkU=;
 b=UnXMQ7N89/vTrtVYAUfK08XAP0vTsPtZdxLEEhGpHu/ALV5CMpvwZ4BI
 fTt2VIgLLlNrTjWgLNNiXWzJ7jKU2XhKfdrN6ajzeUQt2kI96zEJb8QW6
 KrW6Z2TRDkvfKUM+FKQs81gk2Bn9Z9bDeo+X94NjI/0JUu5rpQqu3nUDA
 wALVuoUdGSblzprC6w/LOslrycSG7/YqSK/LuCC3tXVzADeMkYtw+no98
 180fCnAgWMwVquIEF8B5K3GaBbfr+dCHDwLqLVPYrQdS5+hGEBGPDx0O8
 kxKAQAyg/KE8ouggSsVrDt6rQuTN4oblSG+OqzmpKbM5L0kNEZJaI/mod A==;
X-CSE-ConnectionGUID: Heblw5+RQK2Co/3auIGG1w==
X-CSE-MsgGUID: SrTYWfm2QU6tvSpvQ5OavQ==
X-IronPort-AV: E=Sophos;i="6.25,196,1779148800"; d="scan'208";a="17103934"
Received: from ip-10-6-3-216.eu-central-1.compute.internal (HELO
 smtpout.naws.eu-central-1.prod.farcaster.email.amazon.dev) ([10.6.3.216])
 by internal-fra-out-009.esa.eu-central-1.outbound.mail-perimeter.amazon.com
 with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2026 10:32:09 +0000
Received: from EX19MTAEUB001.ant.amazon.com [54.240.197.226:31386]
 by smtpin.naws.eu-central-1.prod.farcaster.email.amazon.dev [10.0.31.97:2525]
 with esmtp (Farcaster)
 id f664e0e9-6475-43a6-a10e-d0c91c892c0e; Fri, 31 Jul 2026 10:32:08 +0000 (UTC)
X-Farcaster-Flow-ID: f664e0e9-6475-43a6-a10e-d0c91c892c0e
Received: from EX19EXOEUA001.ant.amazon.com (10.252.50.110) by
 EX19MTAEUB001.ant.amazon.com (10.252.51.26) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.45;
 Fri, 31 Jul 2026 10:32:08 +0000
Received: from EX19EXOEUA001.ant.amazon.com (10.252.50.110) by
 EX19EXOEUA001.ant.amazon.com (10.252.50.110) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.45;
 Fri, 31 Jul 2026 10:32:08 +0000
Received: from FR5P281CU006.outbound.protection.outlook.com (10.252.51.94) by
 EX19EXOEUA001.ant.amazon.com (10.252.50.110) with Microsoft SMTP
 Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.45
 via Frontend Transport; Fri, 31 Jul 2026 10:32:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=StT7U4dxlfGbaABUUe/a5cPh8Xltiao4LMnBw6ELw39TdUt13b9+O6gWTgZOdS1SLC3nyHogEhvCU4G/X0Sb5sE3OYG8gWu/dZCp3HxRP2a0jFUTbMbSxZEuFlTe3V0oL7iBsJa2gWOdHq84hM8EF6QLum2u9B2hpo9tJpT39OUE9bDss+MGr4L1dS4HGsg67BeGfufe3IlcS+Uh2PCu3Rkk/WzIA9fKm8vN+ufYjTy6WEUg2Fa41YkmvcoD6MYmTWaLi6Y1cAKdJ6K23jtJqWGDm0My3iUu+hX+5uRStV9jpGtJVImiClwhOl3IYyERkHO25aba65JMpMCuLhw2Zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fNdQWkleZvJDBZfSvK/cHOZXZqPsPDvPaee6/a7swkU=;
 b=cw92QyGGeV+QKIT4dnWsg7zu9hq6p8DeFy5VUPmoqiZVsWZwlUmK/ut2Wmbasuj2DxUgwsLnaOLIL0WsT3gT0U8GFBLg55hssUnJQEV0f2vQji3iRa9Mnst2IPO8xzUuQQXE29V3SROaCnt9O9U1A9yoL3mK0Hwm7KT/Do4wTWq33xRHtixFib6ek8trZXlMnDW2tC7SAu/4DqVVqLKmKS7VxLSeSFbhch0f9ufCP5cO7ZzG3XsAcqeTOOS0+MiLqlRCNp8ovTr0DYfbKV67LqSJ1pZC/GPPNmOuhzw7tsp8LQofQ+GNxzy0QXQwZRP9Nbyw5kSwUUU+JHZkXABnIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amazon.de; dmarc=pass action=none header.from=amazon.de;
 dkim=pass header.d=amazon.de; arc=none
Received: from FRSP281MB6250.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:1e0::23)
 by BEUP281MB3480.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:a0::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.15; Fri, 31 Jul
 2026 10:32:02 +0000
Received: from FRSP281MB6250.DEUP281.PROD.OUTLOOK.COM
 ([fe80::7ad:f028:e0a7:bd4b]) by FRSP281MB6250.DEUP281.PROD.OUTLOOK.COM
 ([fe80::7ad:f028:e0a7:bd4b%6]) with mapi id 15.21.0270.012; Fri, 31 Jul 2026
 10:32:02 +0000
From: "Graf (AWS), Alexander" <graf@amazon.de>
To: Ani Sinha <anisinha@redhat.com>
CC: "Graf (AWS), Alexander" <graf@amazon.de>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "kraxel@redhat.com" <kraxel@redhat.com>
Subject: Re: [PATCH v3 0/9] Introducing guest driven VM launch update
 mechanism (BYOF interface)
Thread-Topic: [PATCH v3 0/9] Introducing guest driven VM launch update
 mechanism (BYOF interface)
Thread-Index: AQHdINfSmej04q6d+U6lPNotL6hc/w==
Date: Fri, 31 Jul 2026 10:32:01 +0000
Message-ID: <30ac6502-b4a7-4f88-a837-69ea4da7f1ee@amazon.com>
References: <20260730071254.80695-1-anisinha@redhat.com>
In-Reply-To: <20260730071254.80695-1-anisinha@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amazon.de;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: FRSP281MB6250:EE_|BEUP281MB3480:EE_
x-ms-office365-filtering-correlation-id: f39cb5e5-2f16-487a-b781-08deeeeef56b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|10067099003|11063799006|56012099006|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info: 77ijp6aDGtMh3VGdP6WMeWOgZxpNxxw7zJzfjgOQdOjS8iGm9otiLO/k8wfUUexXGXs3JD2dBw9eYLbwEjXTpv5OC0qdemcXw3YBHztFjetgdrfrPTfryLASonT4SUAUhrWHm7FBTTY4XaxOoogj6JmUAbrmzcF1sWfcQPNbUASMLD2icW1RRtSpFr1tLJQoUyJNl8JXT9OQYuSPKsMuKQB92gKSk0onbz7PULzpnhV6LqML8fA0IKf1NFCLM87pmnDUKQV9i2Oy4ZGKo+/uETyxGshyzLkATozom3Mb2wQ+QsgsDFus7shsIjZOtaZd0HSUwhZAKmSDQ4SykJ+SI/IsxCGb6uuI1fS3NVwsskDcPT7zEm91jaXB4iOG+4LAE3iqbRbXcxeaxB146TrkTcz27L+AuQ/wB3mcQ0tYjwQcNqxwGhB3AmsKOk6+epQxd4XUYAEkZEHV56MNr7aKF5OfvkO49l4G9+UQ0D5X0di15wAJCg0FqW1S+bmgATelP7F1bBSCZUL+tjDaW9ZGpAgb4jcIY1OgLc/+r3G7fv8pbBf+5pQMieJKjfG7gCOqloSuXpli+jh4umh5Ba8ARf4dAK53nc9IKzOQ49NDLapequLsOTF29BSE+BNxJd+GU0/nxqnK+BLrt3tmn9q7b1nTgcDwvSG28ngpfvFSlYlIlkKH5zN6b8dEXV10RPQ3eQkxNZZIDwMnkjUn0hmGvO58K9R1Nc321lwi0ZJf5/A=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:FRSP281MB6250.DEUP281.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OGRTdDYvUE1PTXI2MHVVakcyRFp4RTNMWlFJQURPVE1iT3hvZUxhbXlrWW8z?=
 =?utf-8?B?UDg5SlpVNmlvdGVGQ3ZSblhnRmwwQ2pLV0FtbXZrenBWUlJZeDN1L3lqSHBr?=
 =?utf-8?B?SndwR3ZoS3NxZ0MyZzRDcUtHc1NTMWN5ZTdQTWJvYlk3MzRKQ3J3RERhTkFR?=
 =?utf-8?B?ckRaSVQ2a04vRTJ5TFpNVXppbHhMd2YrellUbG1FQWltc1o3a1VmdnJWZlFY?=
 =?utf-8?B?aTBkeFVrQ3d6SGdoMDE5MXB0bXY5aVB4bjJ6VkZmWUY4cldUVUcrTG1Jd3Qw?=
 =?utf-8?B?Zy95MS9ibWpDRUR0MkNyc3RheG1MTlFmbjlkUSsvU1IyMEtjeDMrelpNV3lN?=
 =?utf-8?B?REVJaXpNQlBDcTBHcnNVaUFobGtibDR6U0ErMlhvTFpQdHhPaG9Ka21UWGx1?=
 =?utf-8?B?b2FsWjlqbGJkMThWaU5Eem5SSEQ1Z0dMbVJteUpkcmFCMXYvQlJWRU03K0dZ?=
 =?utf-8?B?MGR4Wi9QWkM0UVo1YWhPaWZWWXA4UFVaS2JZVElaQnQ3WjhlTTRWUkhTcGJj?=
 =?utf-8?B?Z3JMZUlQTFRjdWJ0NWVpU0w2bW0vMm5ndUtCY2dYejFTVWt6Q0VRMzZjL0do?=
 =?utf-8?B?VWxMOWFqSjZDN0swSTFHY0VXZlZsM3pERjNpWnpaTWYzaDdyQlgxb1I1WTg1?=
 =?utf-8?B?WUNVTVV1Tjh1RDMvQmJLdlI3LzhZMGxJdGZBUkc0L2djOTFiWlFjdHB1TTdT?=
 =?utf-8?B?RDloK1Q3bzA2REhKaDZ6WHl1QS9vODl3TVV2bDhnY01HS05WK1IzN21pVEdQ?=
 =?utf-8?B?SUlhdlpwRXY0YjdLRm5FVE53amsxSFAraWEyNXhRZERFUVNnUzU3MUVNV3Nk?=
 =?utf-8?B?QjdLbGJRWGhMdGRlRHVsOGZsL0NsVTBQS2lOOGZydDdyMitkdE55NnpLMEtw?=
 =?utf-8?B?ZUYvTTZGS3VIellmTncvRkdGU2xCTUUyTGNhMmpOaEh4T1R3MFpVNXp0ZTgv?=
 =?utf-8?B?TGhMN1RHY3lQSGxHdkNTMmF2SStOT2JiZ1lRREVsYmI0TFdqMHZaQWo2TE9v?=
 =?utf-8?B?Z0dLYXYyMHpMbDltN0ZieUFyOVgyRjFYV25ZVlBkRTl4VThRR1hnWmNla0xn?=
 =?utf-8?B?UFBwMFloejVYVnRBZTlTWmcyeVE0Z1ZKNS9KS25rWDRBcW9QSE5lc0h4QzFm?=
 =?utf-8?B?c3VBWW9WQitWRVMwZU1XQ1FUT2hBa3BHaml1S09IUSs4OUtjMGtrNmtjT2Rz?=
 =?utf-8?B?VU5zbm9raU9KeXR4czFLWUVWdTNFbWJ6aUJ5ZGV6dno5VzdBNEcwRmc2L3Fw?=
 =?utf-8?B?NWxvWmxTL2F6d01NalQ1Z3MxQnRHVGE5Q2tQRXJZek5GK1ZVakI1MnkrYUdR?=
 =?utf-8?B?TXJqR1Q5QjFQQXNmVkxaSHRwZ0J0UTJnQnZJaVRMZTZSa21YQ0UyZnNKYkRn?=
 =?utf-8?B?OVF5MnltTVNnaWhTdjhGS05DMzlkSGdwZ1RTRlRucE9qSDcxTEdHd1ZtUGJF?=
 =?utf-8?B?Q3FDU044TlQ5SXJydXdrQ2F1WGNJMnd0SHoxS3VBOXRYenFicE9MZXBZZ1NW?=
 =?utf-8?B?TkNYSHNaUzBxaW13aUVjQ2lqbGVMVE5NZzJZQXVpZnBZOGZyaWJhSmQyR0RQ?=
 =?utf-8?B?ZVd3KzZHNDdFcnptbjFFblpMY1dwc2UxSG9yZTI3VW9tT2dBWC9mOWFMSVds?=
 =?utf-8?B?cGx2eHd3dlJORjRqU2o0a21TeW9kdzFiWXd0WTVTSVhxeklMUElTM25CSUJW?=
 =?utf-8?B?TkJDVjRKeFk5aXl4VDdJTUx0KzRXbnMzbTNzTC9aM2QrSjJHeHd1U3NzRFNM?=
 =?utf-8?B?REVqc0dQQzhqMnBUeW5mZGltNFZlL2JuSHBsaEhyYmpvcTJaTTZUNXFtZVQ3?=
 =?utf-8?B?bk1KY2d4dDVTeVFFTWgyWFk0aEIrSnlQRUplaW1kMzJFTkV2TUJzZ1E4Z1pY?=
 =?utf-8?B?RjBrUGIrM2lyaW80MlJXWVprSVJzKy9DZTRmUTBpMjRhTWpkWkh0MFk2SW9X?=
 =?utf-8?B?UHN3Y1FnMkdpUElzSGgyYVFTMTlVUGhmT05va3J0STFLVmZ4SkJwVThBZTJK?=
 =?utf-8?B?Q2paT3RBZ1RuRDhuNlovSVBzQ0lRQm9IRlNPeHlhaW00REJSZ245bHZwZjda?=
 =?utf-8?B?eXppT0dyS00wdWZQaDNzQ2FsZUpidkR1V0srdXFJMzlOMTlBODRhNzNRR1Fj?=
 =?utf-8?B?M21ZbG1sYy95cmdWZDEvMTJRK0NteHkxU1FXMm1HRkRxVFRxL2s2clNaWXFm?=
 =?utf-8?B?WnEwSTM4dS9iTzFQV2YyUUxGRGo2TjFOSFpDSzB2RzVHZEh6R1VrOUdSaDR2?=
 =?utf-8?B?R3hDaHZMYUY3R3o3S3FDQmRuL0twdngrRGNuV3RndkduYS9CUWhIdzlIdWFr?=
 =?utf-8?Q?hdXxB2mZA+Dq1rKupg?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <196A6DFD8FBD694992A8AFE7C7B742B7@DEUP281.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: bGe1BgcY58K1Q083yDMBOFEIHH/FYs9BemwGfxQtEeKvLusPSTPCKHHu46IEsvC8MMnMZeKjWgyDB9oB1cupE7BQTxWWJ+cAPYEnFabp+y591fQaG133EO2d3VODhsYUgy7WzD4x50Wgaa2NZEgYQbFlmmvP7owAqHEYGysaL7CwKEjr9aAusfAIBhxp/G2kqe8411Hh4lNP+Xe0F66pQvK9Tql0gcv4w9UB5uDfGsbwsed2hGtK25E31UHqL8ZM89S47F1ICP5BBrIh9JpG/i4t7XvOCxTRPJ1oOD6k27CwPol3fkTgA3zolN31ZOm9+mMJOONDUkp705yGvoWb4A==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: FRSP281MB6250.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: f39cb5e5-2f16-487a-b781-08deeeeef56b
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jul 2026 10:32:01.9803 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5280104a-472d-4538-9ccf-1e1d0efe8b1b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 82JvELxC2JmcEyH+HZYUTAVxU6Wg4tm7H1EonCZHHg7mC4COQnYOo8iBGe+yyKUD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BEUP281MB3480
X-OriginatorOrg: amazon.de
Received-SPF: pass client-ip=3.64.237.68;
 envelope-from=prvs=6654ce66d=graf@amazon.de;
 helo=fra-out-009.esa.eu-central-1.outbound.mail-perimeter.amazon.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.58,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001, T_SPF_PERMERROR=0.01,
 UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
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

DQpPbiAzMC4wNy4yNiAwOToxMiwgQW5pIFNpbmhhIHdyb3RlOg0KPiBUaGlzIGlzIHRoZSByZXN1
cnJlY3Rpb24gb2YgdGhlIHdvcmsgdGhhdCB3YXMgcHJldmlvdXNseSBkaXNjdXNzZWQgaGVyZToN
Cj4gaHR0cHM6Ly9saXN0cy5lbmRzb2Z0d2FyZXBhdGVudHMub3JnL2FyY2hpdmUvaHRtbC9xZW11
LWRldmVsLzIwMjUtMDMvbXNnMDU4NzIuaHRtbA0KPg0KPiBUaGlzIHJlbGF0ZXMgdG8gdGhlICdi
cmluZyB5b3VyIG93biBmaXJtd2FyZScgd29yayB0aGF0IHdlIGFyZSBkcml2aW5nIGF0IFJlZCBI
YXQsDQo+IG5vdyB3aXRoIElHVk0gc3VwcG9ydC4NCj4NCj4gVGhlIHBhdGNoc2V0IGluY2x1ZGVz
IGEgc3BlYyBkb2MgdGhhdCBoYXMgbW9yZSBkZXRhaWxzLg0KPg0KPiBUaGlzIHBhdGNoc2V0IGlt
cGxlbWVudHMgdGhlIGh5cGVydmlzb3IgaW50ZXJmYWNlIHVzaW5nIGZ3LWNmZy4gVXNpbmcgdGhp
cyBpbnRlcmZhY2UsIHRoZSBndWVzdA0KPiBjYW4gcGFzcyBpdHMgb3duIElHVk0gZmlsZSB0byB0
aGUgaHlwZXJ2aXNvci4gVXBvbiByZXNldCwgdGhlIGh5cGVydmlzb3IgcmUtaW5pdGlhbGl6ZXMg
dGhlIGd1ZXN0DQo+IHVzaW5nIHRoZSBJR1ZNIGZpbGUgdGhlIGd1ZXN0IHByb3ZpZGVkLiAgVGhp
cyBpcyB1c2VmdWwgaW4gb3JkZXIgdG8gaGF2ZSBkZXRlcm1pbmlzdGljIGFuZCB0cnVzdHdvcnRo
eQ0KPiBsYXVuY2ggbWVhc3VyZW1lbnRzLCBtb3N0bHkgZm9yIHRoZSBjbG91ZCBjb25maWRlbnRp
YWwgZ3Vlc3QgZGVwbG95bWVudHMuDQo+DQo+IFRoaXMgcGF0Y2hzZXQgaGFzIGFkZGVkIGZ1bmN0
aW9uYWwgYW5kIHVuaXQgdGVzdHMgdGhhdCBleGVyY2l6ZSB0aGUgaHlwZXJ2aXNvciBpbnRlcmZh
Y2UuIEl0IGhhcyBiZWVuDQo+IHRlc3RlZCBmb3IgYm90aCBjb25maWRlbnRpYWwgZ3Vlc3RzIGFu
ZCBub24tY29uZmlkZW50aWFsIGd1ZXN0cy4gR2VyZCBoYXMgYWxzbyBpbmRlcGVuZGVudGx5IHRl
c3RlZA0KPiB0aGUgcGF0Y2hzZXQuDQoNCg0KVmVyeSBuaWNlLCB0aGFua3MgYSBidW5jaCBmb3Ig
cHVzaGluZyB0aGlzIHRocm91Z2ghDQoNClJldmlld2VkLWJ5OiBBbGV4YW5kZXIgR3JhZiA8Z3Jh
ZkBhbWF6b24uY29tPg0KDQoNCkFsZXgNCg0K

