Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2628C83F1B
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Jul 2025 08:42:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ucKCU-0001Ee-S3; Thu, 17 Jul 2025 04:42:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1ucKCO-0001Al-5K; Thu, 17 Jul 2025 04:42:40 -0400
Received: from mail-francesouthazlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c207::3] helo=MRWPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1ucKCM-0003Qw-8c; Thu, 17 Jul 2025 04:42:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rX/+Efu9bIuPR0r3qeR0ntqu2R3Ki+jwGhsIK+olwhUfYQpW+6QHGSZWeSHB2mmWfbx+lb5PHxM6cnXEXOFvS/Gz+roKwIv/cIjdtiHleP/Qn9qVl0oVSNwMXOQ/r12mEsPw7b1wv9vaVc1702bnimTUcEVvICLzxpJ+SAMwWc7Fdepyt9Nun0rfE8EwaiMMyXCf/obXGImtBDRyWX4xXEfqY+2hQp5jIzFjpddcoHf7Wp80OeTgJRaxJ6kR5LYAmDL79QVIXyogjPk+0eNBN6xK4+VmXkZBmAhbIdq8sTMD1y/U3/5XGVaS+Lu64aKgUNIQYPIb2yoTwJCNoQXl5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TxL5vnO6cAumisHHZ+bcVrMjQq/ftmuJzxd3C+M0MUI=;
 b=o4/UFWBDKOjVjGMvDIr+3hc4Omb45Z2/Vk4iOlnTolqa48cTOVvkNxakwSoJKGzK6kqA9S5HFWLK2aWcsDAKBf160ZbaJjKAicCd0237Tpb0G1QM2xPTqmmCreaWPf3UFbZrmaOyquq7+fDMHPdsPS+r1zMKTFMZy2ORCz/lZ0zeqpqN+bS2DrLr8lXn00QOaQ8HjKo/p/O4HEPlJVHKU91YgdPy19q9JNymNHjqDgngBoXid3oiF59vepi+tN8RcjCx14q357gCI0djKZqhaXhoxaGk205gwd8fn1B05AKlueQM4gHdDYUmR9zZZ5/RI9GS/tuK5TnTkwIf1H+UdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TxL5vnO6cAumisHHZ+bcVrMjQq/ftmuJzxd3C+M0MUI=;
 b=VMN30aLfVdHbyv8aKYSr/2lxS65A3a0MyWQtuqJmY1DRxrJFBg7Ecrq2APQQortI1XEcV9pIt7Mzjmy8QB/LkVAdAndltwN9rTbyGczCnn0XvV/cN7SF9k9l1K80wWrf/xsK4Yj5pIB6dxxVi48KnF/AGPO4ScsvUfvaGqUMRz8/X4T8xogEP8C+xC5GjqQvD0voGEbhf74WQTiUrYZYgewZdm/3HWJhqC+t5WVQ2uzvrekD1hS0ABRreK+WrHcvPmiItS+bqg+8vOAVVfDxkerM5XsFVDF+tEir01t8UjD8x62f18Jyws4ni7SrCHgmbavcGPUko5lyzS8j2ORFZg==
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com (2603:10a6:20b:4fb::5)
 by DB9PR09MB8034.eurprd09.prod.outlook.com (2603:10a6:10:5c5::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.35; Thu, 17 Jul
 2025 08:42:28 +0000
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a]) by AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a%3]) with mapi id 15.20.8857.026; Thu, 17 Jul 2025
 08:42:28 +0000
From: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
To: =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "cfu@mips.com"
 <cfu@mips.com>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>, Thomas Huth
 <thuth@redhat.com>
Subject: Re: [PATCH v5 09/11] hw/riscv: Add support for MIPS Boston-aia board
 model
Thread-Topic: [PATCH v5 09/11] hw/riscv: Add support for MIPS Boston-aia board
 model
Thread-Index: AQHb7AgpZ1R2BnCxSkO9Y4GIFCfW6rQzCF0AgAMNBgA=
Date: Thu, 17 Jul 2025 08:42:28 +0000
Message-ID: <2085501b-6940-4874-9299-357be0795d1a@htecgroup.com>
References: <20250703104925.112688-1-djordje.todorovic@htecgroup.com>
 <20250703104925.112688-10-djordje.todorovic@htecgroup.com>
 <97a9b456-9983-4c1f-8fb2-5bba94c95655@linaro.org>
In-Reply-To: <97a9b456-9983-4c1f-8fb2-5bba94c95655@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS4PR09MB6518:EE_|DB9PR09MB8034:EE_
x-ms-office365-filtering-correlation-id: 65ef8168-4405-4ca2-9b55-08ddc50ddcb5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?eFVhKzFQcVowUTB5VWZHY2d0N2FBTENFYjVYZWtiSGlqWUlmbWI1ZWVkQVg2?=
 =?utf-8?B?YTNuWmZUYmVoYzhQb3kxY045dmFvM3RVLzVNNDhHWkNDenBDWTdlMTJvaEQy?=
 =?utf-8?B?bnR0dGF5Y1c2SmtnbXRQdzdaWkk3ZFVqYTFuOGJJQWdSdHBGdDhEY1BQSldz?=
 =?utf-8?B?cXErdjE2NTRuTGwxdDk0UlhvV1pFWjFoSTg3d3RwOXFrc0EvNU5UcEdrM2VV?=
 =?utf-8?B?ZFd6bzllUVUxbDExUmw0QVNESzVWYUxMQmVLTUJwT0srS0ZSditQV25GUkM0?=
 =?utf-8?B?dFR1Q240SXhVL2RWUm1NSmFMeE9WNlE1Z0d3aVpDOXlkcERaTnc3UlFXRjl4?=
 =?utf-8?B?c2swTldjYWM5aEhiVXBDTHBwYVFYSlVYWlgzcGVBVm56UHRrL2lPWHlnNkNB?=
 =?utf-8?B?MlVydlRLRHZsYzE5QnVxQXlKQWVZTWRXV2pMMFFoWlNRalVSSnNjMU41aXo0?=
 =?utf-8?B?Q2x3T1ZDb1NZVW5rN3phNU8rWUZEZkFBd243SndJNWdYQU9YSU84RTdhSXBo?=
 =?utf-8?B?S3hYNHdXQ0VjMUYxajFHN2p2aWkxSGNkNEtkV2FNMFdwUTIrUEVZZkEwd0Qv?=
 =?utf-8?B?Sk5hdTlyZ2V3bHA2K0FTZ295Tlo0dzhuaGpLbWdyS3pNYmFJYld1MFZHQWFG?=
 =?utf-8?B?bkR1ZlFSOUMvWU5XL1ozVUd2eVZVbDJaUjNlcWNjcm44SURRZ0s0b1lPdnRv?=
 =?utf-8?B?Qm16SElaSVNnREhiYzZSclczaGhPSjRXazVBMnJScHJoRVVESVhhWnFlZER3?=
 =?utf-8?B?YmE5WjdhS2pEZ2tZL2xFaWYzRkxnSmQrbU1Ub2R1Mm15TTRScGRzN0pha0dT?=
 =?utf-8?B?YVJkNVhUeFlobmRuK3BtSEFPT01wYUgrOGJiN01WMTdLQVRpWVlRbmpIZUFD?=
 =?utf-8?B?WGVZeVVKWmkxUEd6dXRRTDU4eVFBaUgrcG1VYytBQXprSk94VVNPZHpOQ3Zt?=
 =?utf-8?B?YnZwMnN0QnBVaDR0NmRoa0w0S2UyM3FhNGRxMU85N2NiZm9ZSUNRY0ZuQnE2?=
 =?utf-8?B?TnpNUTFtZDFGS29CZjRSV0VYd2g1SXRVM2ZWbjNtWnQvcmdSQnNpOFE2d3ZH?=
 =?utf-8?B?RGdkZFFKbU0vK2EwNGxMQjF6bVVDbm00bnVkdGFvcmZGb3dwczF6dFExbWND?=
 =?utf-8?B?OTdmUGtpeHBoYXp3d0ZRU21NSXBrK3pEM3JzS2JZNjRxcFJOcm5oNkw2cnZO?=
 =?utf-8?B?b29iWHp6OW1xd3czazBnYndJUEdwbUEyZzdEajhHdDh5M1ZudFY5Q0t5NTlD?=
 =?utf-8?B?M2FNY2QyTW1samVGQUpkL1JVcytLbWlEaDlOK2tXeCtlM1B0SlZURGcxZ2ts?=
 =?utf-8?B?SE1IbEx1bG1Wc3U1UUZwZ0RBcTlsYnpjYzMzSyttcHVCWldmREtueDF5Rmd6?=
 =?utf-8?B?NzEzamk5Rys5WklkZ3JEcTJNdm5sUGswTmpReTMrZ3JQRDZGT1pWNm1tYzlO?=
 =?utf-8?B?UFc0UWl5RXhKbEZHTlhPRzlMWG9wRkNKaWtNdlo5TFQwcE90aFVaWFFxVW5h?=
 =?utf-8?B?SVBVVnNKd1JpVXllYnJBT3ZkZmRrMmNxdFlYcWx6N3lnSnV5V1IrUzczY1RY?=
 =?utf-8?B?a0JUT1dDdjlNcmJVV01oNXhrcEtFMEZOL3FyU1hGcFczdVF4Q3BWMVcrdlVO?=
 =?utf-8?B?QnhBYTRmc2t1cDl5b2NwRW52T0p4MFh2ckliUkVhQ3g0NExOTmIycFlGWFly?=
 =?utf-8?B?ZGpiYWJqLy9xWjN6cmxhVjJWRTB0K3dGVisyYnJnUDJYbGR6NEtZcFBLNm16?=
 =?utf-8?B?SG42Tm0zMXBJUmVMUW1sVTdCS3hDSU9uYkxEV1BHU1BQMFUrZVRRUjZWV3lu?=
 =?utf-8?B?SEFjbFFpdnlGWHV1NEdPaTNsZEs5WFpVS3B5Q3FpYzJoQjNwQTlQN2o2V3Bx?=
 =?utf-8?B?dHVTcHRTNWhRa0V5b3liRE5IYVZGeTd2T0xpVzVJeUpZaXVaNkNxVTRKcnM0?=
 =?utf-8?B?S1JrSDlmUkh4L2psMHV5dlR0UlR1ZVRUMloxbFMyWFNYeGZJYmM3Tk9SZ3RN?=
 =?utf-8?B?bEllODNHV05nPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR09MB6518.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cnlYalJkcDkwenR4ZWlhbDVWbUFVUCtlZzVIZGVwWjJ2VTE5b2pHTGJvdnFK?=
 =?utf-8?B?VkFPR0d5UUJob0U2YzVUcmF0Qi9ieHJTM2NXR2xQYXFrdi9IL3FlalJ2dGI1?=
 =?utf-8?B?VHJYelV4TUlkYjBDNVNlYm9XU1dHY3hOTGcwVjMwdVUrVnkvZ21tejBMcWFw?=
 =?utf-8?B?bHJ2VGNBaUMyajRqRVdUbnVmK2tXV2ZkaXNCUU5HNTF2c2JrenpKRmMzL3Rk?=
 =?utf-8?B?Q2lIUEZOSjl5NjBNQ0JoQzY0WWNKSUdibGtvaWtObUhKM0J2Q3IyYllPVkJi?=
 =?utf-8?B?VXB2SFVwa0JsaEFTNHZicEZGTlBzeUNOQ1VseGd0T0hsTTFWcDFXeGFRTkRK?=
 =?utf-8?B?MVAySnRWYzhCWUxtTVVlbkcyOFR1Mlg0eUJCTmZVOHJVR1o1NzJMZUFWemNi?=
 =?utf-8?B?Mi9rR3BaS0lscmlONHNGZlVyaTQ5dEVHZnZiN0Vha0tJSGV3WXljYXFGSWdH?=
 =?utf-8?B?K1hhcUNmaDQ0SGlMOHVTTnQ0MDZ2cUVhNUMxOE5FTWhxdkhUMEFkTEszcTRl?=
 =?utf-8?B?SlI3TU1oby9QekJxd0Y4Y014UjI4c202TFdsRTR5OWpSQ1hoSFE0Rlo2RHF4?=
 =?utf-8?B?VllyTWN3NlFUR0d5dVowSEpFeXBBdUp4QnV6WFpEY0x0dkFiZzNvcnZQNGRI?=
 =?utf-8?B?UFhXajVPWmVldzI5V0ZocmxZUVRDYjZ3bmNtTXhvTDE2dmdpM0pDcXlDdlhj?=
 =?utf-8?B?WlRNM3dzdzU4aTd1UUFSMWtmdWhBTUtuM1NQam53S09NTWlReDRaV3dZVkJu?=
 =?utf-8?B?NWhZUDdkb1ZEemdQcW5ZTnZvOXd5cDBjMTF4WHJuWGJhcElMUTJZY3ZLZTZN?=
 =?utf-8?B?UXcvQkNNSDNLZ0N3MzJvdmswb3dQc1ZBQ1BqTTBpTkV0TDVKSVVEMGhBS0ZC?=
 =?utf-8?B?VXBaeUZPNG9XdHNQQUxqWjladXVIN0IyODFqd0NGR1VscXBPVG8xeU1VcU9z?=
 =?utf-8?B?K3RzZlFDWHBYVmhHdVZpaUNjRE9KS2dzeXZpS0hWYjZOWFpuMVBnWGN5UDV4?=
 =?utf-8?B?S05EVlpYUFhqQkQxVlBpWS96VytLUldIMlNsZXJrWGJ6dlZoVWc3L1R5UWsr?=
 =?utf-8?B?dkZ1STNERW8zRkRza01JRDU0TDlWaXJWR09XSWVDYWhMa2M1VTZGZTlzL3J0?=
 =?utf-8?B?WmNOb2hXYUNsdE9CY0FDL1ZmUmlhQnhoVTEzZGF4Wk5mNlBKbU5jdHdBa3hO?=
 =?utf-8?B?azQzbFRmMzZqZ3pMZGY4VEowQXdTeDZSVGNlcjFvODhGUnhIZFVVUlBJQXBI?=
 =?utf-8?B?bEJjV1pRMWp6amJNeEYrcERZTXhlbXVXUjRPWmZnVjFXNUNRY2JSekdJTDU2?=
 =?utf-8?B?L1IyR2Z2cXpnRExnd2w1aUZEemlsYnd1Zmd2aExtcTBNWndHMzlqblNRZTBs?=
 =?utf-8?B?TTN5SWZHMjA1eEgxaGM0S1YwVkZZOWJMeC92T0FnYlZrbkNtWXhvbmtPOTFS?=
 =?utf-8?B?cFN4UkF0UDhSL0prcUFDb0JzaGJiOVhqaXliUVBmS2Z5L3AvMS9vbU83Ykgz?=
 =?utf-8?B?NHhjNHhrcUpnZy81aTUxVHJWZm5vY0xRdVlhY3RHL2lmdEdhM1ZYQjJ5TTBk?=
 =?utf-8?B?UGNtVHhDNUtJWE91Ump1UkRiZERGckNId0wrUm9jMUdsTzZDZWdXVGM0RXV0?=
 =?utf-8?B?YXRnckVVZ2JHWHdXVmJpc21LN045enl1OGdXOUhCN0lMZDJFRFRuWUxoYXgr?=
 =?utf-8?B?M2s1b21QLzk3THp3SHlEZm1qUDA4VmQ2ZkRpekxVSTIvY1JLRld4ZFVvV2V2?=
 =?utf-8?B?S2ZtbnF3NlNjR0Z4dzVNMGpKSDZzNGtYNUc0QS92SmQxSVRKdE9ZbHV0UGRF?=
 =?utf-8?B?VndlNTJnWWFoYjY0MXUwaU5oSVpWdzhEMXA3S1lBQ2dNczVEUmJzK1BnTEZl?=
 =?utf-8?B?eGY1WjRYL2NCR2JzVXIyTnpzVDlMeTJkQjY0NzdIU0tYckd3ekVUNXJWSXkw?=
 =?utf-8?B?cjlta3NsTFQ1eTJ4Wko2VzczVk9Ma3UrTllvekJHbmdhcFpWMEI0L2lMMlRj?=
 =?utf-8?B?eEF3ekZIVFRHSUdjdTZUL25WOUV6THdSY1M4TDluUk16OGtJV0FCbnJYWTRo?=
 =?utf-8?B?elBkSkdZS2ZKS1l5VDNNM3VsTmxaYTBPNGk0b0V4a1N2V0tVcStuNnFEbk5Z?=
 =?utf-8?B?bkppelJDTkg0T1llT3E0S2ZDTG9NeC95MmhwSkdkeUoxMDhVZFNXN2JxejRU?=
 =?utf-8?Q?yqtZw7DpCN7FosIFz8PvSjU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <30ACC284A2D860409C26F65739807F66@eurprd09.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS4PR09MB6518.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65ef8168-4405-4ca2-9b55-08ddc50ddcb5
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2025 08:42:28.4502 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0HMxRqvCTmYycny5ZOwhR7ogS3PM8e4Le0Q+Ol6hHp/efVxtOuqq9XlbQ07a8pfOZfxGbYS5W3Ew3Ok1FL1irjy8uI66AOUZZ49Gapz+N7k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR09MB8034
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

SGkgUGhpbGlwcGUsDQoNClllcywgSSB3aWxsIGRvIHRoYXQuDQoNClRoYW5rcywNCkRqb3JkamUN
Cg0KDQpPbiAxNS4gNy4gMjUuIDEyOjA3LCBQaGlsaXBwZSBNYXRoaWV1LURhdWTDqSB3cm90ZToN
Cj4gQ0FVVElPTjogVGhpcyBlbWFpbCBvcmlnaW5hdGVkIGZyb20gb3V0c2lkZSBvZiB0aGUgb3Jn
YW5pemF0aW9uLiBEbyANCj4gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5s
ZXNzIHlvdSByZWNvZ25pemUgdGhlIHNlbmRlciANCj4gYW5kIGtub3cgdGhlIGNvbnRlbnQgaXMg
c2FmZS4NCj4NCj4NCj4gT24gMy83LzI1IDEyOjQ5LCBEam9yZGplIFRvZG9yb3ZpYyB3cm90ZToN
Cj4+IFRoZSBib2FyZCBtb2RlbCBzdXBwb3J0cyB1cCB0byA2NCBoYXJ0cyB3aXRoIE1JUFMgQ1BT
LCBNSVBTIEdDUiwNCj4+IE1JUFMgQ1BDLCBBSUEgcGxpYywgYW5kIEFJQSBjbGludCBkZXZpY2Vz
LiBUaGUgbW9kZWwgY2FuIGNyZWF0ZQ0KPj4gYm9vdCBjb2RlLCBpZiB0aGVyZSBpcyBubyAtYmlv
cyBwYXJhbWV0ZXIuIFdlIGNhbiBzcGVjaWZ5IC1zbXAgeCwNCj4+IGNvcmVzPXksdGhyZWFkPXou
DQo+Pg0KPj4gRXg6IFVzZSA0IGNvcmVzIGFuZCAyIHRocmVhZHMgd2l0aCBlYWNoIGNvcmUgdG8N
Cj4+IGhhdmUgOCBzbXAgY3B1cyBhcyBmb2xsb3dzLg0KPj4gwqDCoCBxZW11LXN5c3RlbS1yaXNj
djY0IC1jcHUgbWlwcy1wODcwMCBcDQo+PiDCoMKgIC1tIDJHIC1NIGJvc3Rvbi1haWEgXA0KPj4g
wqDCoCAtc21wIDgsY29yZXM9NCx0aHJlYWRzPTIgLWtlcm5lbCBmd19wYXlsb2FkLmJpbiBcDQo+
PiDCoMKgIC1kcml2ZSBmaWxlPXJvb3Rmcy5leHQyLGZvcm1hdD1yYXcgLXNlcmlhbCBzdGRpbw0K
Pj4NCj4+IFNpZ25lZC1vZmYtYnk6IENoYW8teWluZyBGdSA8Y2Z1QG1pcHMuY29tPg0KPj4gU2ln
bmVkLW9mZi1ieTogRGpvcmRqZSBUb2Rvcm92aWMgPGRqb3JkamUudG9kb3JvdmljQGh0ZWNncm91
cC5jb20+DQo+PiAtLS0NCj4+IMKgIGNvbmZpZ3MvZGV2aWNlcy9yaXNjdjY0LXNvZnRtbXUvZGVm
YXVsdC5tYWsgfMKgwqAgMSArDQo+PiDCoCBkb2NzL3N5c3RlbS9yaXNjdi9taXBzLnJzdMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKgIDI1ICsNCj4+IMKgIGRvY3Mvc3lzdGVt
L3RhcmdldC1yaXNjdi5yc3TCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKgwqAgMSAr
DQo+PiDCoCBody9yaXNjdi9LY29uZmlnwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIHzCoMKgIDYgKw0KPj4gwqAgaHcvcmlzY3YvYm9zdG9uLWFp
YS5jwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfCA0ODQgKysr
KysrKysrKysrKysrKysrKysNCj4+IMKgIGh3L3Jpc2N2L2Nwcy5jwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8IDE4NyArKysrKysrKw0K
Pj4gwqAgaHcvcmlzY3YvbWVzb24uYnVpbGTCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIHzCoMKgIDEgKw0KPj4gwqAgaW5jbHVkZS9ody9yaXNjdi9jcHMuaMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8wqAgNzUgKysrDQo+PiDC
oCA4IGZpbGVzIGNoYW5nZWQsIDc4MCBpbnNlcnRpb25zKCspDQo+DQo+IFBhdGNoIGlzIHRvbyBi
aWcuIFBsZWFzZSBwcm92aWRlIHRoZSBDUFMgYXMgYSBwcmVsaW1pbmFyeSBwYXRjaCwNCj4gdGhl
biB0aGUgQm9zdG9uIEFJQSBib2FyZCwgdGhlbiBhZGQgdGVzdHMgZm9yIHRoaXMgbmV3IGJvYXJk
LiBZb3UNCj4gY2FuIGZpbmQgdmFyaW91cyBleGFtcGxlcyBpbiB0aGUgdGVzdHMvZnVuY3Rpb25h
bC8gZGlyZWN0b3J5Lg0KPg0KPiBSZWdhcmRzLA0KPg0KPiBQaGlsLg==

