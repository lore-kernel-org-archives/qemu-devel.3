Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6A30E77184
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2024 03:54:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tO7bz-0003v5-Bg; Wed, 18 Dec 2024 22:54:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrew.yuan@jaguarmicro.com>)
 id 1tO7bx-0003ub-NB; Wed, 18 Dec 2024 22:54:05 -0500
Received: from mail-tyzapc01on20724.outbound.protection.outlook.com
 ([2a01:111:f403:2011::724]
 helo=APC01-TYZ-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrew.yuan@jaguarmicro.com>)
 id 1tO7bv-00064e-Hv; Wed, 18 Dec 2024 22:54:05 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uKMpCgqX2E/JrK0tijymJQp23vStQoPykPdjbO0pW6vLA9OcDe1lafzvrKOkTY+OH4LTokSDySRTXtErT0DE4/OzkRBIkSI+4yVQiaeFMKT5ugOYVgE2AQRWD1da/pG0vFADG12y3vuim9MWeebPwOZIwZ1J21pJmseRrrMJPqOelZENO2AGjHsMf800IjfBilneyt8QeijHq6SsmUN+S3+Ew7Djab+nlFKuPfYc0+j2H65PybhwCsxzZatZEerCREQ3P4uars0sZN9Kuo1eC4581RgMFqX7eILYnKvP55K7/Rz8SUf3j29WLfWBMrERhhkACHfKHiw2jTykaaX6Bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qr4LxFhzKN7PRWdcb8mdVTFUALkjEPigd4DmsAECq8A=;
 b=vrLxMU4ougA8ouNqn8nOuLlm5Qzjh26f+HpjzA/z7gS2Bh3cKo2ZQPutQdHWcDqHfuSfSIzCvD3WRF2PdSmLr8WViQdeTt2NwBm1kinOqacaai/OVOzCEjeBom4ZFp8BJcFRoCk+8tb6vKC8bTBrZdlN8w2hb21nzE31ceolReziAOQGTHtERrlGlMg7/vyrn4zO6i4+ibTyXe39BxDg7SsKHWgRkKugkerCnTGs9k6ytvatzbn1j2dgQTmepH9U8rIeeX3QliYPLIpX9a1hmRNCBcEnaBeZO94ncys5zoD1Hyuf3HIaFEcGzkbdt0vq1j89GMPPtz4hYAYWS5sYfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=jaguarmicro.com; dmarc=pass action=none
 header.from=jaguarmicro.com; dkim=pass header.d=jaguarmicro.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jaguarmicro.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qr4LxFhzKN7PRWdcb8mdVTFUALkjEPigd4DmsAECq8A=;
 b=e4u5rO4R3OZpoWeoX5EvYtVweQ4h/aLyNsn9VdzsN+I+8zzd8MyaC/TDNCCy0Cmb8UZbUmtqUIGQ0I0G/t4VCUoL84KnslvXuUKAUvb8pv78MSRr1X5s8qkqjmD6vkjgOWXbXhS75z29zsiBFp5Y65Ytx9L+9pQwFa1UvYqCHGFFdZjy8oWrMs4NlMJCh0hx1RX5V6S+l1r7u1dzUUrTmZS7JAp1dOTEybabirerbTp68wT7IklPSmw/kp3AJN34ScsYB20txN5uwb7fLrNqYgTJEpAWwnspDZDBfRk3f7Uj6q+yRo4L1dnkj/3gaDGMz/x6CdvIpmGhyf3B3/cgQw==
Received: from KL1PR0601MB4891.apcprd06.prod.outlook.com (2603:1096:820:ae::7)
 by PUZPR06MB6145.apcprd06.prod.outlook.com (2603:1096:301:11a::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8293.7; Thu, 19 Dec
 2024 03:53:54 +0000
Received: from KL1PR0601MB4891.apcprd06.prod.outlook.com
 ([fe80::8950:42de:2354:91b2]) by KL1PR0601MB4891.apcprd06.prod.outlook.com
 ([fe80::8950:42de:2354:91b2%6]) with mapi id 15.20.8272.005; Thu, 19 Dec 2024
 03:53:54 +0000
From: andrew Yuan <andrew.yuan@jaguarmicro.com>
To: "philmd@linaro.org" <philmd@linaro.org>, "edgar.iglesias@gmail.com"
 <edgar.iglesias@gmail.com>, "alistair@alistair23.me"
 <alistair@alistair23.me>, "jasowang@redhat.com" <jasowang@redhat.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: =?utf-8?B?562U5aSNOiBbUEFUQ0ggdjJdIGh3L25ldDogY2FkZW5jZV9nZW06IGZlYXQ6?=
 =?utf-8?B?IGFkZCBsb2dpYyBmb3IgdGhlIERJU0FCTEVfTUFTSyBiaXQgaW4gdHlwZTJf?=
 =?utf-8?B?Y29tcGFyZV94X3dvcmRfMQ==?=
Thread-Topic: [PATCH v2] hw/net: cadence_gem: feat: add logic for the
 DISABLE_MASK bit in type2_compare_x_word_1
Thread-Index: AQHbUcg3/1u76TWO1kOYcgQ8V7PmPbLs7yhQ
Date: Thu, 19 Dec 2024 03:53:53 +0000
Message-ID: <KL1PR0601MB48911D9E3337C9314F65F533E3062@KL1PR0601MB4891.apcprd06.prod.outlook.com>
References: <20241219034304.747-1-andrew.yuan@jaguarmicro.com>
In-Reply-To: <20241219034304.747-1-andrew.yuan@jaguarmicro.com>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=jaguarmicro.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR0601MB4891:EE_|PUZPR06MB6145:EE_
x-ms-office365-filtering-correlation-id: cda1ab69-1df1-442b-4ab9-08dd1fe0c1bc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?L1hPc2s5dDdRKzJBNVlhblpyY2xLUlNjVk43ejlRTjRrYkRDcWJ0OHVxQVBl?=
 =?utf-8?B?VUgwUTN3TWVkYit0U0h4RkYranByWkd6dkd0eU9VUVJkdnhIMlU2dVJma1ZQ?=
 =?utf-8?B?OEw0bzlnaEpUbHkwMWJDM2VQbVBUYU5iTzRDVFh6N2NYSTRLNWZzMDRxbzJF?=
 =?utf-8?B?bkl5cGNOVjFkb3NQS0FXdEtRY3YrRzhyemo3K01SN1VybWo5bkZIVTVuQlNI?=
 =?utf-8?B?dmZzbDBaK2dHNmRVVThUbE5SNXlaUWRkRnFzVUZxVzBQekNhSE83YzNHV3pv?=
 =?utf-8?B?QmROeG91cWRoclVzL0NmZ0M0dmE4QWFMUjl0RXk0L3Q1YnJzdko4ZllUUnlL?=
 =?utf-8?B?RkxGU2ZKajRFQWg5aDVNU3I2L3JxOVh1QzVhbW5HS1ZLZzd3ZktCZTdTMlkv?=
 =?utf-8?B?RmlQVUxmRFduUmh1WXdJV2V1bDZxWFpiTlFSWm12a2d1QVE1MzVwdUorTFJN?=
 =?utf-8?B?RDBSV1dGV3pMWlZUVFdFVnlDUko2dTZBQy85eTIvYnhqUVladVhqbnRLZmRR?=
 =?utf-8?B?Ym9vR0RCRkdKL2tyZzNuQ2d0T25aK0c3Z09SdXVWYmxJK3JrU0FlYUtacWxG?=
 =?utf-8?B?TUlUTTlBZVViNE1qd04ya2trMmtHc0QxMzZTUGFWUDdBcjlBTnhzL2VYU3Vh?=
 =?utf-8?B?SzJraS9WSHRLSlJmb2d2QXJtVDVBazBlamp1M2pJVGtKWHRiZWN1T2lDZlpo?=
 =?utf-8?B?Q1JGdU5idzlRNlNJblhacUdSRGpCL0EwSnljNU41c3V0T3JSdlZEOXdMbkdm?=
 =?utf-8?B?dEpxVitrRGNUWXZoajhJb0x2QUhwalpDVHkwbzBLZFdtVERXQWZtc2tsMmJN?=
 =?utf-8?B?TitkS0RkMzIyeXJLaFlOOWkzL3pwdEdXYlhKRWVLR000S04rVkwyRFNQWWg0?=
 =?utf-8?B?elYvRiszSnRRQ2w0MXF1Yjd1S1JoT0Z0VmJGYmVSRXZaRW90N1BQMzBYd012?=
 =?utf-8?B?b2pzYlQwWXk3T1hSejUvN1EzZ3ZxMXhJSUJtM3JpaElGVzdZbGlUYkhMZC9v?=
 =?utf-8?B?T0ZVN1N6a3YxUU90c3l0eGZjMC9rNWJ4eXBRM2U0aU1xZjhVZzJ0SlFmbzU2?=
 =?utf-8?B?cUJuUXUvdTN6bFRSWkdUaWo2VnY4Z2FxY0F1SnZreG5QYjBNdVBEQ2hXUDd2?=
 =?utf-8?B?a0RNVWJNZFFKcFRVVllaMVJEVzJyYXpPLzV5akh4NFVjTjhVSzlQYWhxRTNV?=
 =?utf-8?B?bWZkVnVINGJJanQvZExwVVFlUlJhSnRoMEUra3h4OEMreDc5MnAvUFlFWEFu?=
 =?utf-8?B?OEh5VllqWGUvcWJjNkYrSmhEa0lHYk5jOEhRdXg0eTBXMXdPY2xwVVFGN0Vm?=
 =?utf-8?B?YnpIZFhrWEdTemVxYm1wS25GZU9idWprOGwyQU9heHhTa3JCZzFHWndnSmJz?=
 =?utf-8?B?UHljZGkxUFllRllLUlFDREhHaG1KMDR1Z00vTDhWS292VmNxSVEyVlVlZVVv?=
 =?utf-8?B?WHMxdGZrZ1NwQVBXWXd5M1p1NXlVa042Rmdja1k0SDhNTjcrNXZMaEFpbFdD?=
 =?utf-8?B?VGhpMmNXOWpkS3prdkJIdjBHRGpYM1M2cDVOY0lCRDN4Zk9SM1hEdjV4cTNY?=
 =?utf-8?B?YWlodVhBQS9jaUtDUkZGUGZpY1RCTStsYXBseVlzd0pvNjVLSE9rS3gzTUZv?=
 =?utf-8?B?cW91NFZGN0gyOC9KMlhrdnQ1VU80ejJ0TjZMY0g4a0Z3N2F2WktUMUYwUmdw?=
 =?utf-8?B?a3lZY0lOVU51eDZTaW1mUXV6WUtBRzhmdGdJRGROaGg4VHpHMDhsUWlxWmk4?=
 =?utf-8?B?TjdwbGFxUmU5QUM3RDUybkFac3N4bk5zUHhTcEFRV0ZvRm1rRi9ZUkk0RExR?=
 =?utf-8?B?L2N4bnd1MlVmaVZnNGdCZDFMbTFxZkJoQ3lTdUNJUXJwSHdsOTVFR0Q2TEJM?=
 =?utf-8?B?bnRRNXJWejcxZVowTTJJcEZIbnFJVHMrMTM1eWVLZGxYRWVmMXhNRHpYTkF4?=
 =?utf-8?Q?WRxAsQ2SeTjCxmqlDWJPRFsB6de1gI2q?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-cn; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:KL1PR0601MB4891.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(1800799024)(376014)(366016)(7053199007)(38070700018);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?empYcStqM3BQVzJlYlB0M1lDc0pRcTZZejROZ01paEkvUXBGK1d2RGhYNEhp?=
 =?utf-8?B?OVJVRFhHL1lQTmJXelJ0ZkFYUDJvazlPMEtQYlovWmJ3bDFJSGY0V0FxaWZM?=
 =?utf-8?B?MS9xd08zNU45Rk45NSt4OHd6YWlBdHNxWUhJd2pZajFmNGRKV1hLRkRESWNp?=
 =?utf-8?B?bTZiaHFVWFZUTGJINHhwZzFFTE9iVFN3NWJoai9wbldEVG9wSGhuMGE1dFlC?=
 =?utf-8?B?azdjb3F5K2hHK2F2b1o3YUhPMndKQzBnaXcrYVZNQm14REh2S28wUUdzVXRL?=
 =?utf-8?B?RDBVV0JqL1Z5RTEzS08wNW9PTm5oMDJqeXd5RzA3b21oeGt2QVlwKzJPbHRt?=
 =?utf-8?B?endOSlNLY3JQbFNDZlVUZlR5OWZXSVFjU2RSQXhwdU1PT2pnNWdHTWNzb1pU?=
 =?utf-8?B?UFloWCtybEZNVktFRFRYaVNtRWZTUDdpYnlvc1p4NlAxNmNpZlJuemVDWXJk?=
 =?utf-8?B?bnlSTHR0WHNxOFU2eXNNb2Vmd245ZGh6b0x6Qm1wZVYrb0RQK3daeFpXNGhy?=
 =?utf-8?B?TkFPR3VpUFFUSzFtWGJIUUpsaEIyc1M2TThnS1JMWFFkd1NDY3IxWmZMVXA2?=
 =?utf-8?B?M2xaN2t2NjlpOS9mTCtUYzJpSWtIWVFZSm5tMG1LbmRJbExhcytaclRQSWRk?=
 =?utf-8?B?czZiekRvcEFvSGdUVS9tV29tSndMNSs4Zk9UZjVDdzRLRzRjYXBOVXpiTC9r?=
 =?utf-8?B?ejRkL3lXZ1J4U0ljNzdjUnE4aVlUZkhVYWV5cXRRRHBET2I3K0l2Z0JNNVBL?=
 =?utf-8?B?aWJkSEdTQWI0MVE0dnV6RGNmbmVUM2tldnRFcU5CMkVwTGRWbDh1R3Y3Tzky?=
 =?utf-8?B?dlo3RTVtb05XZlgwVEFqdXFoR3FGVGJxdDY1b2diRHBpcjg2blNnbENiSU1y?=
 =?utf-8?B?cFhZMnB6TU9wR3d3bXFLM0wzNVZldWdOMG13QklmUEFqcHBHU3pqeDI2Nzh5?=
 =?utf-8?B?UWZMd2JCQ3hwWXJpVXRSZjI0SjZESE92NnViVEpDbkZ5aVkwZ0tvQjZjdFht?=
 =?utf-8?B?YXoyaHdGVjkwYVNGRkFKdVBoRURJZFlETk1zaGRlM1h5b09EeVJCSE5mRkZ5?=
 =?utf-8?B?SzBGVUlDY3haYXlHUnpaZFNFc25KdzBldW56akNxUWpmT3FxMklpTVFKeGZm?=
 =?utf-8?B?cGhjTFFtZDVqRUEreGtncHRQcmIyMUh4MnNCYU53ZGtTVXFTVUZUOWJiUlRZ?=
 =?utf-8?B?bzFweVNjek13YUw2SlZvam0wcndiTXhkZXJEUmswK1lBdi9SaDRaeHZmdTVq?=
 =?utf-8?B?OCs0M3pTRkQ3WDlNZUJ5bU1DV2o1WDNmb2JENXFqNFlMNEJBNzdMTzdaSHpk?=
 =?utf-8?B?YU1obmtzVXZNRERBMnhoK0dtWG9seUp5aU1FNmpFMGhZZzdVcWpydm9XS1Fs?=
 =?utf-8?B?cXNEMjlzWStxVGJPMFpxOXpRM1BWd0RNbm5xR1hlWWFyazBzUXlwMWRqbjM4?=
 =?utf-8?B?MHdFaFpqMDRQQ25zbkppQmtvdFBxQUp0M085MGpqTVVlajk2c0Z4ZUMvclJk?=
 =?utf-8?B?WnZ2N1dsYXQ0ekhBWkVHVGQzL2tHdFRxQy80Z2czOGlaOTJsSERCWWMrOHVy?=
 =?utf-8?B?K2JGbTJXU0lqYVo5d0twYXY4U0lreVNDYkFJUXZIaUJYZTlTSXU1bVh2NnBL?=
 =?utf-8?B?ekhJZk9zdFZ4RVpxdEpYajZoQnJXMEs4eGg5cVhFTERKS29Ibkw0UXhsWGw4?=
 =?utf-8?B?R3NDbHZZaE4yN3k3dHlVSVlxcjlxMTNuUkhnallWTmdKZlB5MElPLzg5VTE1?=
 =?utf-8?B?VGU5QkhyWlVseDJGclh4cTI1R0Y5enYzUXhCZDhTVS9Na0YzUjkrMkJpM0Vq?=
 =?utf-8?B?aDRqNDQ4UTBCYnJBSGRvWk5kMTdRREdNNk9Fc3QwUmFwRUZOeUtUTzVCUEl6?=
 =?utf-8?B?THZpekV6d3RYRTBoWUZDVGxtTEhDaHhVR1doMC92SjhqaFZsYnJwRUlPV0tW?=
 =?utf-8?B?di9ZaGN0WlM3cDZCczE1RXZudlFsZU13VFFvZU0zWTdFeGt1QzFmZW9HOFRq?=
 =?utf-8?B?VXNIVlFFVXhYbUVoWlhwV2ZSYW1YalBkOTU0OU83bHNYbWFVeGV2VEVRM3RG?=
 =?utf-8?B?Wnh3dXpBZ2R5OGY4dG11QUJqVWxkQ3d6eVkrQTNJVy9kckFLM0FWYTUxL0po?=
 =?utf-8?Q?m6MJbY4PZfcHWKTcQfnAmz3Fm?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: jaguarmicro.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR0601MB4891.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cda1ab69-1df1-442b-4ab9-08dd1fe0c1bc
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Dec 2024 03:53:53.9609 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 1e45a5c2-d3e1-46b3-a0e6-c5ebf6d8ba7b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3+G6xeAPwRbymt6LN3nXI6NgSPX+Zj3HFLeUwuakiIQsRSODSUTBs9cqFX8Ca1rHSHRN0UlPaByv3DSBuZEZm4k9+zgjf4OpFHB5uFd09mo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR06MB6145
Received-SPF: pass client-ip=2a01:111:f403:2011::724;
 envelope-from=andrew.yuan@jaguarmicro.com;
 helo=APC01-TYZ-obe.outbound.protection.outlook.com
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

U29ycnksDQpJIG1hZGUgYSBtaXN0YWtlLiBJIHNlbnQgYW4gaW5jb3JyZWN0IHBhdGNoLg0KDQot
LS0tLemCruS7tuWOn+S7ti0tLS0tDQrlj5Hku7bkuro6IGFuZHJldyBZdWFuIDxhbmRyZXcueXVh
bkBqYWd1YXJtaWNyby5jb20+IA0K5Y+R6YCB5pe26Ze0OiAyMDI05bm0MTLmnIgxOeaXpSAxMTo0
Mw0K5pS25Lu25Lq6OiBwaGlsbWRAbGluYXJvLm9yZzsgZWRnYXIuaWdsZXNpYXNAZ21haWwuY29t
OyBhbGlzdGFpckBhbGlzdGFpcjIzLm1lOyBqYXNvd2FuZ0ByZWRoYXQuY29tOyBwZXRlci5tYXlk
ZWxsQGxpbmFyby5vcmc7IHFlbXUtYXJtQG5vbmdudS5vcmc7IHFlbXUtZGV2ZWxAbm9uZ251Lm9y
Zw0K5oqE6YCBOiBhbmRyZXcgWXVhbiA8YW5kcmV3Lnl1YW5AamFndWFybWljcm8uY29tPg0K5Li7
6aKYOiBbUEFUQ0ggdjJdIGh3L25ldDogY2FkZW5jZV9nZW06IGZlYXQ6IGFkZCBsb2dpYyBmb3Ig
dGhlIERJU0FCTEVfTUFTSyBiaXQgaW4gdHlwZTJfY29tcGFyZV94X3dvcmRfMQ0KDQpGcm9tOiBB
bmRyZXcgWXVhbiA8YW5kcmV3Lnl1YW5AamFndWFybWljcm8uY29tPg0KDQpBcyBpbiB0aGUgQ2Fk
ZW5jZSBJUCBmb3IgR2lnYWJpdCBFdGhlcm5ldCBNQUMgUGFydCBOdW1iZXI6IElQNzAxNCBJUCBS
ZXY6IFIxcDEyIC0gRG9jIFJldjogMS4zIFVzZXIgR3VpZGUsIGlmIHRoZSBESVNBQkxFX01BU0sg
Yml0IGluIHR5cGUyX2NvbXBhcmVfeF93b3JkXzEgaXMgc2V0LCBtYXNrX3ZhbHVlIGluIHR5cGUy
X2NvbXBhcmVfeF93b3JkXzAgaXMgdXNlZCBhcyBhbiBhZGRpdGlvbmFsIDIgYnl0ZSBDb21wYXJl
IFZhbHVlDQoNClNpZ25lZC1vZmYtYnk6IEFuZHJldyBZdWFuIDxhbmRyZXcueXVhbkBqYWd1YXJt
aWNyby5jb20+DQpTdWdnZXN0ZWQtYnk6IFBoaWxpcHBlIE1hdGhpZXUtRGF1ZMOpIDxwaGlsbWRA
bGluYXJvLm9yZz4NCi0tLQ0KIGh3L25ldC9jYWRlbmNlX2dlbS5jIHwgMjQgKysrKysrKysrKysr
KysrKysrKy0tLS0tDQogMSBmaWxlIGNoYW5nZWQsIDE5IGluc2VydGlvbnMoKyksIDUgZGVsZXRp
b25zKC0pDQoNCmRpZmYgLS1naXQgYS9ody9uZXQvY2FkZW5jZV9nZW0uYyBiL2h3L25ldC9jYWRl
bmNlX2dlbS5jIGluZGV4IDNmY2UwMTMxNWYuLjg5NzMzMWM1ZWYgMTAwNjQ0DQotLS0gYS9ody9u
ZXQvY2FkZW5jZV9nZW0uYw0KKysrIGIvaHcvbmV0L2NhZGVuY2VfZ2VtLmMNCkBAIC05MDksOCAr
OTA5LDggQEAgc3RhdGljIGludCBnZXRfcXVldWVfZnJvbV9zY3JlZW4oQ2FkZW5jZUdFTVN0YXRl
ICpzLCB1aW50OF90ICpyeGJ1Zl9wdHIsDQogDQogICAgICAgICAvKiBDb21wYXJlIEEsIEIsIEMg
Ki8NCiAgICAgICAgIGZvciAoaiA9IDA7IGogPCAzOyBqKyspIHsNCi0gICAgICAgICAgICB1aW50
MzJfdCBjcjAsIGNyMSwgbWFzaywgY29tcGFyZTsNCi0gICAgICAgICAgICB1aW50MTZfdCByeF9j
bXA7DQorICAgICAgICAgICAgdWludDMyX3QgY3IwLCBjcjEsIG1hc2ssIGNvbXBhcmUsIGRpc2Fi
bGVfbWFzazsNCisgICAgICAgICAgICB1aW50MzJfdCByeF9jbXA7DQogICAgICAgICAgICAgaW50
IG9mZnNldDsNCiAgICAgICAgICAgICBpbnQgY3JfaWR4ID0gZXh0cmFjdDMyKHJlZywgUl9TQ1JF
RU5JTkdfVFlQRTJfUkVHMF9DT01QQVJFX0FfU0hJRlQgKyBqICogNiwNCiAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIFJfU0NSRUVOSU5HX1RZUEUyX1JFRzBfQ09NUEFSRV9BX0xF
TkdUSCk7DQpAQCAtOTQ2LDkgKzk0NiwyMyBAQCBzdGF0aWMgaW50IGdldF9xdWV1ZV9mcm9tX3Nj
cmVlbihDYWRlbmNlR0VNU3RhdGUgKnMsIHVpbnQ4X3QgKnJ4YnVmX3B0ciwNCiAgICAgICAgICAg
ICAgICAgYnJlYWs7DQogICAgICAgICAgICAgfQ0KIA0KLSAgICAgICAgICAgIHJ4X2NtcCA9IHJ4
YnVmX3B0cltvZmZzZXRdIDw8IDggfCByeGJ1Zl9wdHJbb2Zmc2V0XTsNCi0gICAgICAgICAgICBt
YXNrID0gRklFTERfRVgzMihjcjAsIFRZUEUyX0NPTVBBUkVfMF9XT1JEXzAsIE1BU0tfVkFMVUUp
Ow0KLSAgICAgICAgICAgIGNvbXBhcmUgPSBGSUVMRF9FWDMyKGNyMCwgVFlQRTJfQ09NUEFSRV8w
X1dPUkRfMCwgQ09NUEFSRV9WQUxVRSk7DQorICAgICAgICAgICAgZGlzYWJsZV9tYXNrID0NCisg
ICAgICAgICAgICAgICAgRklFTERfRVgzMihjcjEsIFRZUEUyX0NPTVBBUkVfMF9XT1JEXzEsIERJ
U0FCTEVfTUFTSyk7DQorICAgICAgICAgICAgaWYgKGRpc2FibGVfbWFzaykgew0KKyAgICAgICAg
ICAgICAgICAvKg0KKyAgICAgICAgICAgICAgICAgKiBJZiBkaXNhYmxlX21hc2sgaXMgc2V0LA0K
KyAgICAgICAgICAgICAgICAgKiBtYXNrX3ZhbHVlIGlzIHVzZWQgYXMgYW4gYWRkaXRpb25hbCAy
IGJ5dGUgQ29tcGFyZSBWYWx1ZS4NCisgICAgICAgICAgICAgICAgICogVG8gc2ltcGxlLCBzZXQg
bWFzayA9IDB4RkZGRkZGRkYsIGlmIGRpc2FibGVfbWFzayBpcyBzZXQuDQorICAgICAgICAgICAg
ICAgICAqLw0KKyAgICAgICAgICAgICAgICByeF9jbXAgPSBsZGxfbGVfcChyeGJ1Zl9wdHJbb2Zm
c2V0XSk7DQorICAgICAgICAgICAgICAgIG1hc2sgPSAweEZGRkZGRkZGOw0KKyAgICAgICAgICAg
ICAgICBjb21wYXJlID0gY3IwOw0KKyAgICAgICAgICAgIH0gZWxzZSB7DQorICAgICAgICAgICAg
ICAgIHJ4X2NtcCA9IGxkdXdfbGVfcChyeGJ1Zl9wdHJbb2Zmc2V0XSk7DQorICAgICAgICAgICAg
ICAgIG1hc2sgPSBGSUVMRF9FWDMyKGNyMCwgVFlQRTJfQ09NUEFSRV8wX1dPUkRfMCwgTUFTS19W
QUxVRSk7DQorICAgICAgICAgICAgICAgIGNvbXBhcmUgPQ0KKyAgICAgICAgICAgICAgICAgICAg
RklFTERfRVgzMihjcjAsIFRZUEUyX0NPTVBBUkVfMF9XT1JEXzAsIENPTVBBUkVfVkFMVUUpOw0K
KyAgICAgICAgICAgIH0NCiANCiAgICAgICAgICAgICBpZiAoKHJ4X2NtcCAmIG1hc2spID09IChj
b21wYXJlICYgbWFzaykpIHsNCiAgICAgICAgICAgICAgICAgbWF0Y2hlZCA9IHRydWU7DQotLQ0K
Mi4yNS4xDQoNCg==

