Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45135C54E4A
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Mar 2024 07:04:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riUHC-00075B-R8; Fri, 08 Mar 2024 02:04:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1riUH4-00074R-Gj
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 02:04:11 -0500
Received: from esa10.fujitsucc.c3s2.iphmx.com ([68.232.159.247])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1riUH0-0007a2-1Q
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 02:04:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1709881445; x=1741417445;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=/LA3pYh5yVyCkT+bpB8jkSl0d6TOxUmTwCjEu3YRElw=;
 b=vqTuyoBgSO4LI4NzMujSiAMbk38xx6hOYJ4o3YNAasEKCJXUyZ8CFeA2
 9j7fBd6nPmtFxVuxh/PlXwLGLjR7VEYSPy06HHR7r4w9OHaGDPEpg7FH3
 YRBqr5FukREyFq9BoE74+G/5SHs9BFV3GtRGsMC1l0ZheCk8n9X10SVz/
 830R5bWzZ4ZX71IZrzDTJVCuTaqIsKFUFMewhhFdR0x5A/Jbm/nmE8zMI
 HCzOFrkRmV+B2a/Zto3d76mD7VgCZQp1I2CW7w4VKNDaIP/utbHeDssoF
 Xb//905F7P6OSHYLIIrZBLTduz6PLsChZeSl8DwJrV9F2Bin9bwhnsL0/ Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11006"; a="113503391"
X-IronPort-AV: E=Sophos;i="6.07,108,1708354800"; d="scan'208";a="113503391"
Received: from mail-os0jpn01lp2105.outbound.protection.outlook.com (HELO
 JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.105])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Mar 2024 16:03:59 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KMFfn0KhpHumRgJZSq3P+WWkFE+UPIihERMHuM7N/h+7DW1/kVhjzGJub3egEviSTr7xOiUap7+2Rr+ZZeJ+ew4JVevQb9/z01oUOqgWbC6E3TrO8i4K0N/NwMGIqJd5mIWLbg1nEsf5DQSrGQ8IMj/KNsjcHgUc0lXQK3pYfBSLvjCuzIJVptLqPsE5aZDqgXvf7Is4y+0+omm5DM2yQmKqANnGyqSd+9bf4lA57Q3T8BFLqbmhT+yWcf9ppQ2LPrJp+FSwsefTLqImUDlJKuNhSOZ3p6cB2sQnhd8LpaV7u+SrB0x6OCZXYR6CqSBb7vJOOfFi+zdvaAK4fcAfCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/LA3pYh5yVyCkT+bpB8jkSl0d6TOxUmTwCjEu3YRElw=;
 b=Ac1a0UCZp9TRWVSPGYnkaUqOn+24PsMmpef9JtOy21v27KtuuZaN3MI7CORpPAIQJsi2c2VdxcVmaDMkTk19TKUtTOEOurV7ogM7ZtWTEnlyXOKooKYO5Et+QxgG32T/NFl4u8y8xK3mgZ2I0rc4j5l3mjdYaj6jLRv//TKUTN0qYo0HNmu+mtoi5VsjD6IANUiVw0sOmI+qiQmBnQ7aQOfIJrK4DQerDVjQzgG8VQ2sZOwZb2TqMj+lOJzVXZIv9yz9XNqhFJ/P+v43ovngGaREYBd9uv9djBNLppMv847sj+2o8yMO0eMRDspCO+xg3pxW2iqNSuJHqM5qJMr3cQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OSAPR01MB1905.jpnprd01.prod.outlook.com (2603:1096:603:15::14)
 by OS7PR01MB12067.jpnprd01.prod.outlook.com (2603:1096:604:266::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.24; Fri, 8 Mar
 2024 07:03:56 +0000
Received: from OSAPR01MB1905.jpnprd01.prod.outlook.com
 ([fe80::74c6:da1:e8d5:49bf]) by OSAPR01MB1905.jpnprd01.prod.outlook.com
 ([fe80::74c6:da1:e8d5:49bf%6]) with mapi id 15.20.7362.019; Fri, 8 Mar 2024
 07:03:56 +0000
To: Peter Xu <peterx@redhat.com>, Yu Zhang <yu.zhang@ionos.com>
CC: =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>, Het Gala
 <het.gala@nutanix.com>, qemu-devel <qemu-devel@nongnu.org>, Fabiano Rosas
 <farosas@suse.de>, Jinpu Wang <jinpu.wang@ionos.com>, Alexei Pastuchov
 <alexei.pastuchov@ionos.com>, Elmar Gerdes <elmar.gerdes@ionos.com>
Subject: Re: Problem with migration/rdma
Thread-Topic: Problem with migration/rdma
Thread-Index: AQHab0TXYpucrQ/C2kiIvKCQ3mii3rEq6K0AgACquoCAAA9tAIABwimAgAAHpwCAAAJiAA==
Date: Fri, 8 Mar 2024 07:03:56 +0000
Message-ID: <d03200fc-3ad5-4872-be04-372e74da1134@fujitsu.com>
References: <CAHEcVy7HXSwn4Ow_Kog+Q+TN6f_kMeiCHevz1qGM-fbxBPp1hQ@mail.gmail.com>
 <04da4267-8fe8-4653-90a2-f64e3be64037@linaro.org>
 <a0d9e2c2-3687-4b7d-8fac-887ce262c38a@fujitsu.com> <Zek2UFoAyVrC7yh6@x1n>
 <CAHEcVy4L_D6tuhJ8h=xLR4WaPaprJE3nnxZAEyUnoTrxQ6CF5w@mail.gmail.com>
 <Zeq2WqDuBbKKNWPN@x1n>
In-Reply-To: <Zeq2WqDuBbKKNWPN@x1n>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSAPR01MB1905:EE_|OS7PR01MB12067:EE_
x-ms-office365-filtering-correlation-id: fcea3c1f-06df-460a-af88-08dc3f3debf0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sHasFUMsu4rLG5UpxNlNcD5miqB1MpMcQ45b09zRcltoVSEqXVUsgWManPAH0LKkn/u56XXbIMcW5htnrt1MioBUTXXexBrhioYX9gEEyR2Gjxlc7l2Dsrs1sXKEM/mVpihxQ/dHztfRCD8+it1Fk/MuvGnfMtrJvcpQjh5yoko+pD1KvOW5V+4BzbI6LKCNMxY+x3hNR6BI9Tz3d2Pv6vf+Ca6ZRgjNjFkTJq8xnxWrjqkDsL0n2DpYkrRFnk+a33eU0Y2yRc+m/iDHwt1RuhVZGGPN3+x6KaWj4ZwXZkxC68nA5afSD88rHzckuQh9R23b8GYCC12dxNbE7CzZWGsptGoG9NNZrDIQG/tNny7/LDHNwve9AVbweXLZ3f3nFgD/o16NgtIXVaoiLFfGWXkqBeS8LjP5PklPuOqmLvDrHepyjNdeZoY3nOrExoXrv1vjmVWCmSBgpTitX7TJzS6NQCtWpyt1P7po6Vw7LXDkUHg+koWM+L2r78GGdrGEeD3OU8bY9aOxRrVPYhVXSynUlmYtJssmryy7yrtdCF87d2pmCmmcnC1FZsfUqDHrgvJY95PGTbYd4vZC3wFmGAgdnmhd7x5+E9Kl9s4OLXjxppwMd8BZjNc53NSr+GAeKBeBCMtGOob/waeNzt3Y22297iVaF7l/HByxmLw6GyQg4Xz9ArOzblNTev0H2h11usmn1lq+YCgbOY/rlBcdCf0T8nzBfTLwCGNq3i7Gd5ueyer9LXXx9Zx32P3Saunh
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:OSAPR01MB1905.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(38070700009)(1580799018); DIR:OUT; SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VzA5Y0s1Y3RLVi8wQVZaZitoV242L2tMM2t6Q1lzdG9HWHJ2R01GZFAvZ0lS?=
 =?utf-8?B?MXV2RStvWXM4WmF4T0orOFFZOFNiRXRtME9jTkVFcjRYdU5RS1Z3NlRlRFFV?=
 =?utf-8?B?NFIwL240SEtNOEQ1NlB4Rjc2eUdWbEpqU2VPR053Ym9Va1ltQk91c0MwbnVH?=
 =?utf-8?B?elBISC9NTUswVmY5VEo5bmRmdldBV0VDbmY5NzM0M3Q4YkRFUVorMHJHTkNW?=
 =?utf-8?B?cDlTZGF1NHg3WTcxeE44K1djZHZTWUovbWp2OVErMXRENzhrOWdoRmdrR0ZK?=
 =?utf-8?B?WUpJYXRIeE9sTExBdmFXTmpBQU53T2IyeEZaV2MzQjkvUVhYWjIzdG9hZXFw?=
 =?utf-8?B?UW54QVV3UUg1dW9DS2JVWUtQY25BcllVbDBsZ2IzNDFYS2ZuSHJuU0JnNzZq?=
 =?utf-8?B?OWtSMWdZeWxPL1RUVktGTGdGMGZGdlJnbnVkMnBjVENwYzZDYzJaU05QZ1NV?=
 =?utf-8?B?TlhWSnVwakFSNVFGekI4RmJJRWlvMmxsbGtQZzJFcGpzQk1TSG54clBzY0Fp?=
 =?utf-8?B?VmpzUzZqVFFOdVNoTm9manNLYlpDTWpodlRLd2t6WEtUUndwOEkyN3FqTmdK?=
 =?utf-8?B?WUtjL2ZjMXVCdEFsa0E1TlduVER6SHBaOTMzQU4xbEMyWXM1a0F6Y29kMjEy?=
 =?utf-8?B?dDlZN3kxSkxOajBwRHlZSmV6NDFFTytTUmdTeHFaNEdzTXkwaXFjYmJQNTBr?=
 =?utf-8?B?eGszR2FKbEdPT2o5WjMxYUh1dGFkRGVBVnJ6VmhzVVA5ZkRKUTNrWE9DRHkx?=
 =?utf-8?B?K1ZxNDNIS25sSmYvVERHSnVaVmlYQmlJMkxHSlZycVY4WWNBd3haTVdqRXVN?=
 =?utf-8?B?ZkdiLzBaakFTS2Z0VFFzb0NEemc3UmxoMFpsWjRrdDJvTy9JeUZCTGxtY2tz?=
 =?utf-8?B?Vkh0N29FVGNXYkFFcHdBYjJhNThmbVoxNG52NlZSTzVYV2kyNmhJVUpENGZY?=
 =?utf-8?B?ckdsV3ZrTGlsUmFBUzBPcUs1bUJVVDRLWVNJaUZ1VjAvZjF4d3lDZG5uYVlP?=
 =?utf-8?B?RUZsQVNGOW1mS2FvRjM4ei9zWjJxbzBjWVlBYVh0N2I2TVB5UXFjZVRzWmFk?=
 =?utf-8?B?VFQrRndodkQ4NGhyUnJuUy91MGg5SzBhZGxmNTlDWTZuS2Z3NlpuT1RndllX?=
 =?utf-8?B?V0VmWXZFRDF0QXV5T0R1Yng1bkpaSENlU0liQ3NNYzAyb1RMeHFrRjIrcWtZ?=
 =?utf-8?B?bWhwNnBOQVJzcy9GeGJ6VXU3YnRhWjVmZjZleTh6STNLZzI0eTNkMXVVVFo0?=
 =?utf-8?B?MFBXY2dpOFpGVktCc2dhaU1jNDdZTnNwdGx2NC9EWHBLcGY3NndZR3dFMzhn?=
 =?utf-8?B?cUVSZWttazI3TFNFMGtaNFB6NDVLR2lzNmd2Ujg2NTFyMmVKdlpmNWpCcmFU?=
 =?utf-8?B?K3BQdTZNUmRqa0NtYitaOE1KajlHUVh2U2hTSjZ3V3FUMTZrOURCalRNR01U?=
 =?utf-8?B?OWhkNVhneDU0VmVnUUNsTlByVVFmUjZSQncyTmZYUnFDemt5WGJiWW81U0tD?=
 =?utf-8?B?RzZKc2VVKzU5QVhVcnlmamdCM0FZaWpiNGdjT3k3R0JOOVd0QmV4NkZnQVdD?=
 =?utf-8?B?UnVDNUYvejNEUlpYNGVOMSsyTDRucnZSM2F2OVNjdHpHYVp2Rk91ZmtkSHY0?=
 =?utf-8?B?NE1mM213bzFIWHJFN2l6Nkk3dUtmREF0M0dHSUFPcmpWN0htdURETGZrY0xG?=
 =?utf-8?B?TXg0blBDRTRwNTBNb0tPcVhMQUMvVk1VRWkxL0tjcnpFZDJtaE1Mdkw0K1BJ?=
 =?utf-8?B?STI1UEJQeTJaV3oxd24xSi83bTFPRmNhSHh4aXVWOHpnTlYyR3FuQmRMMEFp?=
 =?utf-8?B?eWlaVnNhY2hoQXZQK1FndDFtL29wcnBZTFhIQ3V1dGdiZFB4U2ZFaHpTdHJI?=
 =?utf-8?B?RVVzU1Y5dzI4Z0txT2ZNWUFwLzViMVhGUHJkREY3VDk4MmRKTTlhRmYwcm1L?=
 =?utf-8?B?R2NDWGRYSFFPclUzbyttb2VyQjNlcy83Ui95RTduSGtrL01Edm43YlQvNU1M?=
 =?utf-8?B?eU1NY0tnY1djTDc1a0ZYL3BFN3YrTmxhVzlDUTk0ZUpiYjVmclAxc1NOWURY?=
 =?utf-8?B?Q09qa1FPcy8wRjcyQ3VNOW96S1NsYWNvNDBtZ0lxT1NOVzgrNUlvVnVvanY0?=
 =?utf-8?B?dTVhY2FuMVdmQi93bDdqVlRTM0pZMzNLdERrLzFLdDdyajh2NnFkTjc1Um9j?=
 =?utf-8?B?Z0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2E1C3602B165CF48A596E95DFD8267E5@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: goflMOvQ4rWeJ1oJKm7EXd1uiLM9IV/RxtkCqpC9b+akIwxSLbiyPLz9gRBQmtvpSkPe2b9Rd7v2m+/5oYPOuBX+Ep5P+8koH88sGzBwaLXCPfv53OFrvoQTZQRR7jZNwBkOOEW6CLqaz6Utl+to6iPyG9TUkaAbapfbPTq03E0BICDmfhproVByxcRAGocvU+GMHkJEdZSozYTNvyUKPRV82vphx0tIC+bIeAdVI0W9YhZ4zL/eRDNxtj4niWX4iKhKQ5A/hG0PTm+EGKPJv8KYWpEEn3OTzEhTOf9A7BZoOiolmOgVmqQkVlkv+2Vhchzzt7DLP+lgZcl+x1afxByMTFNQRQIohwHhlVBCiSzUvcHJj+KQhDZdcLpto2WZfok6pw28uhPVCPRhTmrWWK+245ZOMvvQiu8MaRya+kjXwnlozu1tM0phyYoMAhjyqVpkvOwDSLnQf1vGA9zHmuskFF3sVa+1IbvcVT4e61YAQGzIaX6XoqjkjmcVn7IL9k8lxWnH+83TC08rWjiEL90gExgo7fkZ+psLYeUH9vDM5sg0o96lQ1FQ376mDw9Ys2GywIDMgTFRiMy6DDwA8Tg49b9e0HYzRPPpslcpH1RRB6FZZE4EmxmjSbBWRlDP
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSAPR01MB1905.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fcea3c1f-06df-460a-af88-08dc3f3debf0
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2024 07:03:56.3230 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rQvjKD2Pr03vmbvurPIte+2gdleiHuc3ViLyE5Ybk/J3c4wlQbZIWFIpaH19qVy6JF4gZWJ7gUjT04QZKJIJug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7PR01MB12067
Received-SPF: pass client-ip=68.232.159.247;
 envelope-from=lizhijian@fujitsu.com; helo=esa10.fujitsucc.c3s2.iphmx.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
Reply-to:  "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
From:  "Zhijian Li (Fujitsu)" via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

DQoNCk9uIDA4LzAzLzIwMjQgMTQ6NTUsIFBldGVyIFh1IHdyb3RlOg0KPiBPbiBGcmksIE1hciAw
OCwgMjAyNCBhdCAwNzoyNzo1OUFNICswMTAwLCBZdSBaaGFuZyB3cm90ZToNCj4+IEhlbGxvIFpo
aWppYW4gYW5kIFBldGVyLA0KPj4NCj4+IFRoYW5rIHlvdSBzbyBtdWNoIGZvciB0ZXN0aW5nIGFu
ZCBjb25maXJtaW5nIGl0Lg0KPj4gSSBjcmVhdGVkIGEgcGF0Y2ggaW4gdGhlIGVtYWlsIGZvcm1h
dCwgdW5mb3J0dW5hdGVseSBnb3QgYW4gaXNzdWUgZm9yDQo+PiBzZXR0aW5nIHVwIHRoZQ0KPj4g
IkFwcGxpY2F0aW9uLXNwZWNpZmljIFBhc3N3b3JkIiBpbiBHbWFpbC4gSXQgc2VlbXMgdGhhdCBp
biBteSBnbWFpbA0KPj4gYWNjb3VudCB0aGVyZQ0KPj4gaXMgbm8gb3B0aW9uIGF0IGFsbCBmb3Ig
c2VsZWN0aW5nICJtYWlsIiBiZWZvcmUgY3JlYXRpbmcgdGhlDQo+PiBhcHBsaWNhdGlvbiBwYXNz
d29yZC4NCj4+DQo+PiBBcyBpdCdzIHRpbnksIEkgYXR0YWNoZWQgaXQgaW4gdGhpcyBlbWFpbCBh
dCB0aGlzIHRpbWUgKG5vdCBlbGVnYW50LiksDQo+IA0KPiBJIHF1cXVlZCBpdCwgdGhhbmtzIQ0K
PiANCg0KPiAtICAgIGlzb2NrLT5ob3N0ID0gcmRtYS0+aG9zdDsNCj4gKyAgICBpc29jay0+aG9z
dCA9IGdfc3RyZHVwX3ByaW50ZigiJXMiLCByZG1hLT5ob3N0KTsNCg0KDQpQZXRlciwNCg0KZ19z
dHJkdXAocmRtYS0+aG9zdCkgaXMgZW5vdWdoIGkgZ3Vlc3MuDQoNCg0KVGhhbmtzDQpaaGlqaWFu
DQoNCg0KDQoNCg0KDQo+ICAgICAgaXNvY2stPnBvcnQgPSBnX3N0cmR1cF9wcmludGYoIiVkIiwg
cmRtYS0+cG9ydCk7DQo=

