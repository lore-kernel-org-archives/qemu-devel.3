Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3279C3ABCB
	for <qemu-devel@archiver.kernel.org>; Tue, 13 May 2025 01:05:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEe4X-0002lA-7w; Mon, 12 May 2025 21:04:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <KFTING@nuvoton.com>)
 id 1uEe4U-0002kX-DN; Mon, 12 May 2025 21:04:38 -0400
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <KFTING@nuvoton.com>)
 id 1uEe4R-0006yG-KN; Mon, 12 May 2025 21:04:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f4ZsQDLLlqw0D+cHeBmsi4raFIfmbIMXFfPOYyKrDax7/f9FjMXVDtgoRp9Hd/3vRU+wXuPf+JL4hQnDQ8hRQAAihX2TwqDPFGmJPh4fVyc4a/zctSjNz1GlfHN1lSLaiIJgPpL6AeWtHC96TZvIKA5Yh5i0jzzhXF2H8JX+DXOWhMOPOlDy/9B7MrEm88/tXvHqMZHPHp+WudytATXWGFPjvTKLplRhwPG+2tb5M/KlH0vGi/7cQHJegePK8biXZ1M02s1QweBeuUQny4ewlgp3DyxSsXPK1ZGh0xfWXW3SkeFcvq9ueM66hC+9T+88KwWPy6v0MKxtX7t/QaYfHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KhocA+mjshoV0qerwVNZR2I9GBOv9IG7Muv073vwc9c=;
 b=ZtbhAB9ARahlH4w/d7/+SZrRls4xdQpQItJSwO9xlVLI8vuHEL+kvTapLa7p8vq6sDhjdhdipzwvWr+nVhlbl3DvNBibK3gV2tLx/6GIHYBLHwSkLYEBpf3PwFjDNe4/w3zJ3oPE8VBmfTtvIvpNXrFAr+IV7m8BT4/eNeTuC7XA34i0yldyb+7NKk5Jc4kftsrvKBmK0Owx/C3iqhFYFbmLkhu6/qz5CZIxBgWKuUtgxubjiMzXFhTPCHre4nM7eh3u6sGi44TxaWTjP6JjlyKzz6u8Zng4a8GDdkPoKvtkDBG3YvtMZvYvAB40GeQxiIMAm/TChK0bkRNts1J5oA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nuvoton.com; dmarc=pass action=none header.from=nuvoton.com;
 dkim=pass header.d=nuvoton.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nuvoton.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KhocA+mjshoV0qerwVNZR2I9GBOv9IG7Muv073vwc9c=;
 b=W987oUIhCDKfXJwxrEvusVy5dSvseV8aoloJIMehZe95HyMYE7SCnus0ErZqPctr5NAcqPqyv7UI7/DFHnamIvJGeZcFu5iLU9zSS1F3+bI+83mEPwhsBO4n4V7C4UrKlESD3cXrZN5p1gFsGpjf5lffjwKJdvWbYLejBNINj8M=
Received: from TYZPR03MB6896.apcprd03.prod.outlook.com (2603:1096:400:289::14)
 by TYSPR03MB7859.apcprd03.prod.outlook.com (2603:1096:400:480::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.28; Tue, 13 May
 2025 01:04:24 +0000
Received: from TYZPR03MB6896.apcprd03.prod.outlook.com
 ([fe80::ac4e:718:3b03:3123]) by TYZPR03MB6896.apcprd03.prod.outlook.com
 ([fe80::ac4e:718:3b03:3123%7]) with mapi id 15.20.8722.027; Tue, 13 May 2025
 01:04:24 +0000
From: "KFTING@nuvoton.com" <KFTING@nuvoton.com>
To: Peter Maydell <peter.maydell@linaro.org>, Guenter Roeck
 <linux@roeck-us.net>
CC: "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, Hao Wu <wuhaotsh@google.com>,
 "Avi.Fishman@nuvoton.com" <Avi.Fishman@nuvoton.com>,
 "tomer.maimon@nuvoton.com" <tomer.maimon@nuvoton.com>,
 "tali.perry@nuvoton.com" <tali.perry@nuvoton.com>, "CHLI30@nuvoton.com"
 <CHLI30@nuvoton.com>
Subject: RE: [PATCH] hw/arm: Add missing psci_conduit to NPCM8XX SoC boot info
Thread-Topic: [PATCH] hw/arm: Add missing psci_conduit to NPCM8XX SoC boot info
Thread-Index: AQHbwtys94FSPIFTuE+V2F3+0CJfJLPPvyhg
Date: Tue, 13 May 2025 01:04:24 +0000
Message-ID: <TYZPR03MB689654CB39D47E3ACCC24A29DB96A@TYZPR03MB6896.apcprd03.prod.outlook.com>
References: <20250315142050.3642741-1-linux@roeck-us.net>
 <CAFEAcA-zPwJrq3oQk3MRp9ZCyTzDOg2-Je00v20pVzrKe8he6w@mail.gmail.com>
 <5d350a95-886e-420c-8b0d-a3be57b9490d@roeck-us.net>
 <CAFEAcA-9MCRfHb+O-qdMHAOgSVEUY26h7dUzF-yaF81oFZHs4w@mail.gmail.com>
In-Reply-To: <CAFEAcA-9MCRfHb+O-qdMHAOgSVEUY26h7dUzF-yaF81oFZHs4w@mail.gmail.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nuvoton.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6896:EE_|TYSPR03MB7859:EE_
x-ms-office365-filtering-correlation-id: 42035d55-9576-4122-3b81-08dd91ba19e4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?QmhubTVpQnJEOXEwZGovWXZSWXIxOTA5NFRIdDBBUzVMM20zVHVxVlJsRTRy?=
 =?utf-8?B?ano1dTVkYnpXNEw0djlXbXlmTE5hLzJJVjdYOUlqd2ltNyttVDdiOVNZeTlI?=
 =?utf-8?B?RkRLaHk4UFJqalYvVjZERDIveUd1ZzJHYTJIT3BETW92RWJRVjZ3Mm5ROXVE?=
 =?utf-8?B?cVN2MURlTlJmWTJhODQ3eEpDaWZCSGJEdmd5b0pOZjhzdFhCc0VmTFBQYjJW?=
 =?utf-8?B?Y1NZaitzR0g3a0E5Y0I2Vlo2RHJ6eEM0VGl3QlFJaFpmb2lHVzZYZnU5aEVs?=
 =?utf-8?B?MW8wMXRrQ2NhYVY1Z0NMLzBRTDlMRGFqZ04zTnBwbWFlQ2ZmMk5lL29wbmdi?=
 =?utf-8?B?dUhMRGtScVBDZVp4MWFjRkxHdzQwZVY0akF5cE1TSFBKQzlqcUowZDBPUWxJ?=
 =?utf-8?B?Ukd3c0hnWVBGMC9BVkxaYnVQZWFRd3BCUlRYZ2hna0RTUC9abXNZSWQveXFo?=
 =?utf-8?B?S2dDdkNNSXJCRHkxM2dPWFpPSWZTRW1FM3huMGovY2d4VWp6L3JETlFMOGJn?=
 =?utf-8?B?NU1iK092aEZWMkhaTUFnWkZvOU1YMDYxZkhiZEdrc2t0MVc5WFVtQlBPRVg1?=
 =?utf-8?B?OUhhRlBQODZwS0hEVE5qQ0YxQVR4MVg3K0c3WnE2ejhHeFVtdVFIRUtaQ21Z?=
 =?utf-8?B?OU4zazNqNlJuTVQ1enF6VGJaQkIwdnVwTXVQQjhkaEhhVXUyOU5GNkIycFBq?=
 =?utf-8?B?T2pNNmpWWm1JQ05aaDlVMFBWVzFjV0RCaVR6Y3Z6ajlxb1cxczgyZmVnNWpF?=
 =?utf-8?B?RWE4bXRaQ2FYWEdLOHI3RlhjVmc5OTlFZ2s5RkFkSHNCQ2NIUnF0RlFSSVJi?=
 =?utf-8?B?dExLb3pDcmtPKzRmdEpHeElPYU0wYms2VDM1WWxoaXArVTd2c1MxaGZNU2Ez?=
 =?utf-8?B?bnhOTTFSZDM4WmtORWxweGlaR1pQa014RTlKSHppbTZPZ3Z3Y3lxb1JUcFRt?=
 =?utf-8?B?YVFoWUE1SDhYd1Z3bzFEKzZWZjQwOU15OUx1ZHMxRXYrRTRaZGIrWUJkbTdj?=
 =?utf-8?B?em5TeTR2cHlGZUNrSnhZS0d0ajlQZ1lYcUpkbWkxbzlNTEE1aDRhQzVBcTQz?=
 =?utf-8?B?eWJaUzNZbU40QjhreEkrbHBuMVdYY1AzbWkxM1RNb1JBNDZDWlp6VC9MS2NH?=
 =?utf-8?B?R0pNUFZjS3prUFpPOWIvNTdYS3lJTmhrbkk3bVRaOVVwcVdncklKYnVHMUh2?=
 =?utf-8?B?d3lTN1laNlZlcHl6SkZjL3NFZ0lFYVI5b0NwWnBtblQ4QzVSMkZHYTlXQTds?=
 =?utf-8?B?TiszZkxjT29mdzlWcXZ6MWpIRmNFdGFjam1NeUZ4cE9qR1oxU3piU214ZkxB?=
 =?utf-8?B?a2RwZDRaMFVNRmNkbVRlTGx5WFY3a1lqNk13c2JCVVA0aHBTOUtzOUpVTzdw?=
 =?utf-8?B?TmszbDFLNG9PM0JrNy9oTlhVb3ZVNFNMRis4M0M4Z3hadUtJME9CbENVWXhC?=
 =?utf-8?B?elFmbzh0TXJ2MDgydzRlY05kMXpVc0V4NVUxNFRxaGkrRFlGQUtXTWVsRnln?=
 =?utf-8?B?cVdNOWJyNXRZOGFsbzZDSnJBa2pNNGVlUUw1VnlIL0dVbHZ5R04vRkhUNzhF?=
 =?utf-8?B?Um5aQnBjeitOdkpjTTRYV2lhVzhGS2NTbFIyK051bStPamtBVms1QndjQlJ3?=
 =?utf-8?B?eXVzL0NCOXpFVHdHRSt0Zk82Q2NuYUxFTitkWnpYVXlmSVZUNlRwcXZ1SlN5?=
 =?utf-8?B?UG91NWxRN2ZhUWdMUmt2SlEyYVhKbTI5Z09kNXY3U2hWUi9ldDZ6bW4ycFV6?=
 =?utf-8?B?UFl4bUJKYTF2Ui8zdjVuRldoeXFyY08rUjVrZ2pGVDdIcFFpNlhkelNNVXRo?=
 =?utf-8?B?ODd1Q1NXOXYzMHRqZmNQRnptSXd6ZnNuVkZVSkxHN3VxK1hhS0JiQVRHOWZD?=
 =?utf-8?B?K0Q5bEpVa0VPbFJmbjZKUXRKK0xjVXFkZXhzQVNpR0U2SzBQL0tqOTRwemVB?=
 =?utf-8?B?QlZTelBLQkdCTWF5QmRYdERaSkRLelk3bnNZdjY0c1Q4bEUxTWRka29CWlNk?=
 =?utf-8?B?a1lRUUoyUHpBPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR03MB6896.apcprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?b0lOVzZXc3lDeUpVZ2hWOUpzaFJ5RFoyREVKL1JrbjR2OE1XS3kxMFhPQ3Jp?=
 =?utf-8?B?VDQ3bHQ3M0lrSlV0RW9yWUwvbDlEcllHZ0hhSGNQUTdlaXM0OHh5c1A1N3Ft?=
 =?utf-8?B?RTNvelFIWDJua3NrcXpHN3NNUUlJdkxIdDNxOVZ3SHJpZVFiMHdqdzhvRFRk?=
 =?utf-8?B?d0FwcjY3cGhTbWdUam44SmltRDhzWmdpcm9iZXEyZjJ1TG81UEJvbkJMNVpr?=
 =?utf-8?B?VnFWdUtoOUYwc01vUy9lbnREemtkUFBzeDNqRm4rVXlGRW9pazR5RVJCbWky?=
 =?utf-8?B?YXo0eDFIUUw5bEdwMWhUWngxVmRxdGpDcnFCWkgxdGx4RWVMN3lJcVdQL1RK?=
 =?utf-8?B?RWMyL1JkYUI0cjFTNHppV0FuUzRuVW9KWHlYZjA4Y2IxYWl6ZlYyMjZ3UXh0?=
 =?utf-8?B?UE0wdGNhVjJZQlpSWHJ2T3dJZys5ZkdEaWRaWUs4a0xoVDJqUCtkMWdLY2hn?=
 =?utf-8?B?eTZqNksvREFxd0UvV21iNHNMTnRIRU5KWHZ2K2IrYTJZeTBTRXlEZmpZSDVB?=
 =?utf-8?B?OHd3VDMzZ1RGcnE2Tld6dTJhTE8vOXNmQTI3NkVSOVJPSmh0MkViaDFxdHhW?=
 =?utf-8?B?RjR6Q2FNNjBoVWlSNjB6ZGNOK1NoQ01MWWVtZnNQYVRvL2V0VU9SbUZhbXQx?=
 =?utf-8?B?Z0NlZzAwNE5lNkQ2TW04S2p1aUU2MGozWTNrdzAyZzNTYUxRMHMxRXN0ZEpL?=
 =?utf-8?B?d3REY1hVV3lGNi9IWTNBWkdZaUxrMlZNQUZDWTc4K1NqUlFPSFlXNEdaSU5Y?=
 =?utf-8?B?YUt0MEVnbUNXU3hUcHJvbWRIRjZOWDlNU2kxRFg1Wm5UNGg0ZXR3eVM4U0Zw?=
 =?utf-8?B?bTdqSE5qUjhMa3JFUGdBT0trcGhXQnpiLy9pVlFpcmV3Y3A2eFBHZXltWW1V?=
 =?utf-8?B?VWVvb3JHNWdYbE5tZTE5YWt4Y3RuNzRYaU9tcmpoUmJrQ01yU20wQjM2QWF4?=
 =?utf-8?B?OUw5RkdsTWpmQWhHYzV0T21UVWs2Wk80eHJLN0xlNmpyNmtIUjdCUVlDZVpy?=
 =?utf-8?B?azJyOFdGWWNFMHVveHhwa3pGMjI1UytQSjZDaG9TdEdiMFdkeUdPUjJVTnJR?=
 =?utf-8?B?a0cyVDVGQXhMTFZCcnNRSXR6YUg4Um52UWdMTyttVkJvdmRBM1pqN0RUWlAv?=
 =?utf-8?B?alFWQ082NHJLRS9kNDhKVkhkL3FoVXV3NGFWOEJ0aEFrTUVSL09rbVFhekE4?=
 =?utf-8?B?aTJaeWU5dWFrMlRXZWIzYS9RdEJrVDFxQmlveCtPREZFbklxcFpvZTY4UnZK?=
 =?utf-8?B?TzJjcE1yUFEwcyt2Z1BIdTlvc0xTdWFRRGxDSUJCQTc0ZWVoQjhEZENhZ2Uy?=
 =?utf-8?B?UWFMc09JcDRBcktiYmJ0eXkrQUdXOUN1SFBra01JRHQ4cTIzT3ZXcU9nYWk2?=
 =?utf-8?B?Z2w4SzNiT3YyZFEwbEdrU0orUXFjVHJHZXF2KzFhOE9GRjlYdlA5MWFETlJ6?=
 =?utf-8?B?Y29CdVo0UEhlaXZCQ0lvS2hZdWwyZXNSc3pCc2NCQkYzTnQ5dHpwSEVpL3FN?=
 =?utf-8?B?Z2ZNK2d2aHBMbmpia2laY2xLOUdlc0MzNWxsMkdHRWJuSzVaMk1UYm9iZEZS?=
 =?utf-8?B?dnpTbktJK3g0ODZvbEFnZEdsT3YvdE9lUFEva3Z6Smt6V21rQXVtRWhYQXBS?=
 =?utf-8?B?cnUwYlpEYndGMlZHUDJZcGJNWEd5Yjh2cVB4ZHB2N0MyYkVzUlBjeWI4K2lp?=
 =?utf-8?B?VzNaQ2cvbDYrQU5PazlGSDNOcU55UkwvMGEvRU12TjVPa08rQW4reTVXYVRV?=
 =?utf-8?B?ZEZDUmwwQzlIWFpnSXo5anh0eFAzdzJ5eHd2Z3Mrd3JDUlZWOU0rYzdvZmQy?=
 =?utf-8?B?bEQ5NVI2YWdBUTFiY2V0bGoyZmhxbitYNjJkclJvK1JybkZxRldMbFFqZHBt?=
 =?utf-8?B?RDcyRFpMSnVXamFlWGtvRlljT3VSWWV1VE5PZDZnVlpaQnRjSmp4bGlBUzN3?=
 =?utf-8?B?eFJvL0U5dlFMRXg5L3lBQmFjTGVVSXJLc1BLdUFnL1dEbGM3TzRiUC9HSXFt?=
 =?utf-8?B?SEdjeHkyRG1BK0tKNE9NOC9jbU9CUStnQnF6eUNBUHZGVlhKWEtqNldUdkNT?=
 =?utf-8?B?UU93cUtaTDNvOXdHMlhoM3FHNjhBNUN2Z00zYkZkcUZQMkkwcGRGUFA2eEdJ?=
 =?utf-8?Q?RM+k+VAO9k6VKfqs0bMCcci6w?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nuvoton.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6896.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42035d55-9576-4122-3b81-08dd91ba19e4
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 May 2025 01:04:24.0472 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a3f24931-d403-4b4a-94f1-7d83ac638e07
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ss3VWMiA+KJ0HtkquMWuxQGzNeomf9ftNE7XwcOPZV9A+x4k7xGJTiZDAcFCQfgqP6MXMQjMWeLmE2+rHj1+uw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR03MB7859
Received-SPF: pass client-ip=2a01:111:f403:c405::5;
 envelope-from=KFTING@nuvoton.com;
 helo=TYPPR03CU001.outbound.protection.outlook.com
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

SGkgUE1NOg0KDQpGcm9tOiBQZXRlciBNYXlkZWxsIDxwZXRlci5tYXlkZWxsQGxpbmFyby5vcmc+
DQpTZW50OiBTdW5kYXksIE1heSAxMSwgMjAyNSA5OjQyIFBNDQpUbzogR3VlbnRlciBSb2VjayA8
bGludXhAcm9lY2stdXMubmV0Pg0KQ2M6IENTMjAgS0ZUaW5nIDxLRlRJTkdAbnV2b3Rvbi5jb20+
OyBxZW11LWFybUBub25nbnUub3JnOyBxZW11LWRldmVsQG5vbmdudS5vcmc7IEhhbyBXdSA8d3Vo
YW90c2hAZ29vZ2xlLmNvbT4NClN1YmplY3Q6IFJlOiBbUEFUQ0hdIGh3L2FybTogQWRkIG1pc3Np
bmcgcHNjaV9jb25kdWl0IHRvIE5QQ004WFggU29DIGJvb3QgaW5mbw0KDQoNCk9uIFR1ZSwgMTgg
TWFyIDIwMjUgYXQgMTk6NTQsIEd1ZW50ZXIgUm9lY2sgPGxpbnV4QHJvZWNrLXVzLm5ldD4gd3Jv
dGU6DQo+DQo+IE9uIDMvMTgvMjUgMDk6NTksIFBldGVyIE1heWRlbGwgd3JvdGU6DQo+ID4gT24g
U2F0LCAxNSBNYXIgMjAyNSBhdCAxNDoyMCwgR3VlbnRlciBSb2VjayA8bGludXhAcm9lY2stdXMu
bmV0PiB3cm90ZToNCj4gPj4NCj4gPj4gV2l0aG91dCBwc2NpX2NvbmR1aXQsIHRoZSBMaW51eCBr
ZXJuZWwgY3Jhc2hlcyBhbG1vc3QgaW1tZWRpYXRlbHkuDQo+ID4+DQo+ID4+ICAgICAgcHNjaTog
cHJvYmluZyBmb3IgY29uZHVpdCBtZXRob2QgZnJvbSBEVC4NCj4gPj4gICAgICBJbnRlcm5hbCBl
cnJvcjogT29wcyAtIFVuZGVmaW5lZCBpbnN0cnVjdGlvbjogMDAwMDAwMDAwMjAwMDAwMA0KPiA+
PiBbIzFdIFBSRUVNUFQgU01QDQo+ID4+DQo+ID4+IEZpeGVzOiBhZTBjNGQxYTEyOTAgKCJody9h
cm06IEFkZCBOUENNOFhYIFNvQyIpDQo+ID4+IENjOiBIYW8gV3UgPHd1aGFvdHNoQGdvb2dsZS5j
b20+DQo+ID4+IENjOiBQZXRlciBNYXlkZWxsIDxwZXRlci5tYXlkZWxsQGxpbmFyby5vcmc+DQo+
ID4+IFNpZ25lZC1vZmYtYnk6IEd1ZW50ZXIgUm9lY2sgPGxpbnV4QHJvZWNrLXVzLm5ldD4NCj4g
Pj4gLS0tDQo+ID4+ICAgaHcvYXJtL25wY204eHguYyB8IDEgKw0KPiA+PiAgIDEgZmlsZSBjaGFu
Z2VkLCAxIGluc2VydGlvbigrKQ0KPiA+Pg0KPiA+PiBkaWZmIC0tZ2l0IGEvaHcvYXJtL25wY204
eHguYyBiL2h3L2FybS9ucGNtOHh4LmMgaW5kZXgNCj4gPj4gZjE4MmFjY2M0Ny4uZTVhMTkyOWVk
NyAxMDA2NDQNCj4gPj4gLS0tIGEvaHcvYXJtL25wY204eHguYw0KPiA+PiArKysgYi9ody9hcm0v
bnBjbTh4eC5jDQo+ID4+IEBAIC0zNDYsNiArMzQ2LDcgQEAgc3RhdGljIHN0cnVjdCBhcm1fYm9v
dF9pbmZvIG5wY204eHhfYmluZm8gPSB7DQo+ID4+ICAgICAgIC5zZWN1cmVfYm9vdCAgICAgICAg
ICAgID0gZmFsc2UsDQo+ID4+ICAgICAgIC5ib2FyZF9pZCAgICAgICAgICAgICAgID0gLTEsDQo+
ID4+ICAgICAgIC5ib2FyZF9zZXR1cF9hZGRyICAgICAgID0gTlBDTThYWF9CT0FSRF9TRVRVUF9B
RERSLA0KPiA+PiArICAgIC5wc2NpX2NvbmR1aXQgICAgICAgICAgID0gUUVNVV9QU0NJX0NPTkRV
SVRfU01DLA0KPiA+PiAgIH07DQo+ID4NCj4gPiBXaHkgZG8gd2UgbmVlZCB0aGlzIGZvciBucGNt
OHh4IHdoZW4gd2UgZG9uJ3QgbmVlZCBpdCBmb3IgbnBjbTd4eD8NCj4gPiBPciBpcyBpdCBhbHNv
IGJyb2tlbiBvbiA3eHg/DQo+ID4NCj4NCj4gSSBkb24ndCBzZWUgYSByZWZlcmVuY2UgdG8gcHNj
aSBpbiBucGNtN3h4IGRldmljZXRyZWUgZmlsZXMgaW4gdGhlDQo+IHVwc3RyZWFtIExpbnV4IGtl
cm5lbC4NCj4NCj4gJCBnaXQgZ3JlcCBwc2NpIGFyY2gvYXJtNjQvYm9vdC9kdHMvbnV2b3Rvbi8g
YXJjaC9hcm0vYm9vdC9kdHMvbnV2b3Rvbi8NCj4gYXJjaC9hcm02NC9ib290L2R0cy9udXZvdG9u
L21hMzVkMS5kdHNpOiAgICAgICAgICAgICAgICAgICAgICAgIGVuYWJsZS1tZXRob2QgPSAicHNj
aSI7DQo+IGFyY2gvYXJtNjQvYm9vdC9kdHMvbnV2b3Rvbi9tYTM1ZDEuZHRzaTogICAgICAgICAg
ICAgICAgICAgICAgICBlbmFibGUtbWV0aG9kID0gInBzY2kiOw0KPiBhcmNoL2FybTY0L2Jvb3Qv
ZHRzL251dm90b24vbWEzNWQxLmR0c2k6ICAgICAgICBwc2NpIHsNCj4gYXJjaC9hcm02NC9ib290
L2R0cy9udXZvdG9uL21hMzVkMS5kdHNpOiAgICAgICAgICAgICAgICBjb21wYXRpYmxlID0gImFy
bSxwc2NpLTAuMiI7DQo+IGFyY2gvYXJtNjQvYm9vdC9kdHMvbnV2b3Rvbi9udXZvdG9uLW5wY204
NDUuZHRzaTogICAgICAgICAgICAgICAgICAgICAgIGVuYWJsZS1tZXRob2QgPSAicHNjaSI7DQo+
IGFyY2gvYXJtNjQvYm9vdC9kdHMvbnV2b3Rvbi9udXZvdG9uLW5wY204NDUuZHRzaTogICAgICAg
ICAgICAgICAgICAgICAgIGVuYWJsZS1tZXRob2QgPSAicHNjaSI7DQo+IGFyY2gvYXJtNjQvYm9v
dC9kdHMvbnV2b3Rvbi9udXZvdG9uLW5wY204NDUuZHRzaTogICAgICAgICAgICAgICAgICAgICAg
IGVuYWJsZS1tZXRob2QgPSAicHNjaSI7DQo+IGFyY2gvYXJtNjQvYm9vdC9kdHMvbnV2b3Rvbi9u
dXZvdG9uLW5wY204NDUuZHRzaTogICAgICAgICAgICAgICAgICAgICAgIGVuYWJsZS1tZXRob2Qg
PSAicHNjaSI7DQo+IGFyY2gvYXJtNjQvYm9vdC9kdHMvbnV2b3Rvbi9udXZvdG9uLW5wY204NDUu
ZHRzaTogICAgICAgcHNjaSB7DQo+IGFyY2gvYXJtNjQvYm9vdC9kdHMvbnV2b3Rvbi9udXZvdG9u
LW5wY204NDUuZHRzaTogICAgICAgICAgICAgICBjb21wYXRpYmxlICAgICAgPSAiYXJtLHBzY2kt
MS4wIjsNCg0KPiBJIGd1ZXNzIHRoZSBhYXJjaDMyIHZlcnNpb25zIG9mIHRoZSBib2FyZCBkb24n
dCB1c2UgcHNjaSBhbmQgdGhlIGFhcmNoNjQgb25lIGRvZXMuDQoNCj4gV291bGQgYW55IG9mIHRo
ZSBOdXZvdG9uIGZvbGtzIGxpa2UgdG8gY29tbWVudCBvbiB0aGlzIHBhdGNoPw0KPiBJdCBsb29r
cyBsaWtlIGEgY29ycmVjdCBmaXggdG8gbWUuDQoNCg0KDQo+IHRoYW5rcw0KPiAtLSBQTU0NCg0K
WWVzLCB0aGUgYWFyY2g2NCB1c2VzIHBzY2kuDQoNClRoYW5rIHlvdS4NCg0KUmVnYXJkcywNClR5
cm9uZQ0KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18NCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fDQogVGhlIHByaXZpbGVnZWQgY29uZmlkZW50aWFsIGluZm9ybWF0aW9u
IGNvbnRhaW5lZCBpbiB0aGlzIGVtYWlsIGlzIGludGVuZGVkIGZvciB1c2Ugb25seSBieSB0aGUg
YWRkcmVzc2VlcyBhcyBpbmRpY2F0ZWQgYnkgdGhlIG9yaWdpbmFsIHNlbmRlciBvZiB0aGlzIGVt
YWlsLiBJZiB5b3UgYXJlIG5vdCB0aGUgYWRkcmVzc2VlIGluZGljYXRlZCBpbiB0aGlzIGVtYWls
IG9yIGFyZSBub3QgcmVzcG9uc2libGUgZm9yIGRlbGl2ZXJ5IG9mIHRoZSBlbWFpbCB0byBzdWNo
IGEgcGVyc29uLCBwbGVhc2Uga2luZGx5IHJlcGx5IHRvIHRoZSBzZW5kZXIgaW5kaWNhdGluZyB0
aGlzIGZhY3QgYW5kIGRlbGV0ZSBhbGwgY29waWVzIG9mIGl0IGZyb20geW91ciBjb21wdXRlciBh
bmQgbmV0d29yayBzZXJ2ZXIgaW1tZWRpYXRlbHkuIFlvdXIgY29vcGVyYXRpb24gaXMgaGlnaGx5
IGFwcHJlY2lhdGVkLiBJdCBpcyBhZHZpc2VkIHRoYXQgYW55IHVuYXV0aG9yaXplZCB1c2Ugb2Yg
Y29uZmlkZW50aWFsIGluZm9ybWF0aW9uIG9mIE51dm90b24gaXMgc3RyaWN0bHkgcHJvaGliaXRl
ZDsgYW5kIGFueSBpbmZvcm1hdGlvbiBpbiB0aGlzIGVtYWlsIGlycmVsZXZhbnQgdG8gdGhlIG9m
ZmljaWFsIGJ1c2luZXNzIG9mIE51dm90b24gc2hhbGwgYmUgZGVlbWVkIGFzIG5laXRoZXIgZ2l2
ZW4gbm9yIGVuZG9yc2VkIGJ5IE51dm90b24uDQo=

