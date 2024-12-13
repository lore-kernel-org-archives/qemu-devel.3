Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E16DE7717F
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2024 16:32:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tM8ZT-0003c9-Va; Fri, 13 Dec 2024 11:31:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Frederic.Konrad@amd.com>)
 id 1tM8ZQ-0003bb-Vu; Fri, 13 Dec 2024 11:31:17 -0500
Received: from mail-bn8nam11on2060c.outbound.protection.outlook.com
 ([2a01:111:f403:2414::60c]
 helo=NAM11-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Frederic.Konrad@amd.com>)
 id 1tM8ZN-0003Z6-DH; Fri, 13 Dec 2024 11:31:15 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JwAQ173z2o0HpKhwzRBHXWF88TzD9fNqjIsDYggO2QOGXemJ4Q4bv9k2tAHm5kODXi4u2jJemkdW5FK5JWUir+chDtjySNoRAzQa93levL8nzv5IR80Vyb3We4EMToRS2hasCqCpUFvzEYvxunf0Kbnleh+lFjQwG9j+FNPLVq6Ud3p+2FVBWxy0YRzj3dYhlaBHsTzrfOLOmt97QtrmYyVrp5R6RJX5WYmhqzAqfcfVCA5enUZGayfNzL0jprUj9NkKNBvFBOmv+IPeo46d+adtvv0wbxJOCBLPVg4lPFUYqQK7Cqqm8qClw6SwfdOZB5vyhriYjQn8aYM72R/DHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WVDDcBQs18RJAdnHiA6bXGTmwK1moKQawWDM8XJUsYo=;
 b=q3RTdf7MuMOazNoI2y5RG+cAzelMfgEoyqmcngSaIuOMwc3EhEZu0OiL/0k24En+zCuo5LZ6/rVvYD42i8NAxk/dQpU4yDw9fxceKpmmBXXclwTHLoswHUy/bG0GlsJERg0/4cedAjf9zFTIHj//5WB50e6g/tP2fnJRyldJ7I6dFK7Oq8qHYRBknQArAq0gLmJPS+y6YCIRxlq48psI8RBN8YwCUZoptxaSa1jwoBtH8vD+WSJO3xg1y5ZSFDLnxVaKvurgq3KX8Xq3xhkpo1W9r3jUW3eFQC8F/aLTVAt0CDTktzt5Cr24Bf5pBqt1kx/nHh+gFh3W6OSZCZkNyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WVDDcBQs18RJAdnHiA6bXGTmwK1moKQawWDM8XJUsYo=;
 b=zq9dQdkNPNTk88CepH6b7IR+eZhcrpBDoWatoyGiBO2wzxVwwv5Q5iUh4C6l7x69zYlrUQQEpI9X8MzOpaVsimBrvtX0NFIngy4uN4zzQZR4Yq8JHTTazBmBs4ySHhY25AX09BpKkW/NjHzAUdttG/5qdy2a0pDQcHW8P922dVc=
Received: from CY8PR12MB8411.namprd12.prod.outlook.com (2603:10b6:930:6e::6)
 by IA1PR12MB6018.namprd12.prod.outlook.com (2603:10b6:208:3d6::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.18; Fri, 13 Dec
 2024 16:31:04 +0000
Received: from CY8PR12MB8411.namprd12.prod.outlook.com
 ([fe80::b636:ea75:6169:bcef]) by CY8PR12MB8411.namprd12.prod.outlook.com
 ([fe80::b636:ea75:6169:bcef%6]) with mapi id 15.20.8251.015; Fri, 13 Dec 2024
 16:31:03 +0000
From: "Konrad, Frederic" <Frederic.Konrad@amd.com>
To: Richard Henderson <richard.henderson@linaro.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "palmer@dabbelt.com" <palmer@dabbelt.com>, Alistair Francis
 <alistair.francis@wdc.com>, "bmeng.cn@gmail.com" <bmeng.cn@gmail.com>,
 "liwei1518@gmail.com" <liwei1518@gmail.com>, "dbarboza@ventanamicro.com"
 <dbarboza@ventanamicro.com>, "zhiwei_liu@linux.alibaba.com"
 <zhiwei_liu@linux.alibaba.com>, "qemu-riscv@nongnu.org"
 <qemu-riscv@nongnu.org>, "Michel, Luc" <Luc.Michel@amd.com>, "Iglesias,
 Francisco" <francisco.iglesias@amd.com>
Subject: RE: [PATCH 3/3] target/riscv: fix the trap generation for conditional
 store
Thread-Topic: [PATCH 3/3] target/riscv: fix the trap generation for
 conditional store
Thread-Index: AQHbTBKOGAYBlx/sb0u4xZGAEr0xTrLhkykAgAKvbTA=
Date: Fri, 13 Dec 2024 16:31:03 +0000
Message-ID: <CY8PR12MB84111EF6057B4862D7BC1DC8E6382@CY8PR12MB8411.namprd12.prod.outlook.com>
References: <20241211211933.198792-1-fkonrad@amd.com>
 <20241211211933.198792-4-fkonrad@amd.com>
 <b16c4644-04df-41d1-bc6e-f14d706ab4b7@linaro.org>
In-Reply-To: <b16c4644-04df-41d1-bc6e-f14d706ab4b7@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB8411:EE_|IA1PR12MB6018:EE_
x-ms-office365-filtering-correlation-id: 77f5eb38-3e7b-4376-3896-08dd1b938997
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?c2JSMXJGOG1KVERGa3paUmxOS1pDYVp1eUwwNStZcllORC96c1ZNZjBkQzRq?=
 =?utf-8?B?aFdRQTdQYTd5VThLcXczeCtBQnJvR2RSajl2ZW5ad0VvQW5PNkwxWmFBQUtG?=
 =?utf-8?B?N1h4ME8zSk43OS9wQWVQUzRjS01jTEZwZGxGN3RXTEJ1dHpRcVNOTXl2TjJL?=
 =?utf-8?B?ck8zTitaUTFLdWhUbXA3bG9YTkxlMW0zSHJxc0ZrRkdPbnpXUE9XQ29CQ0Zw?=
 =?utf-8?B?M3dIc2pHZzBKUU5BVkxHa3NlYUNlZ0ZBU1BEQ25SUHJSVFk5d2drcUtuZUdZ?=
 =?utf-8?B?MWF2REREN205cnpXRS9FWHQ3SXE1V09RWkhTRlllRHVhZFBUTm1VcTkrdGR0?=
 =?utf-8?B?cW5ZanBLbG95MkpBWU04R3paOFBLeEdZZVdlOTk1TVF0MVF1YkVYL0hnN1A5?=
 =?utf-8?B?RldMNkFOMEpSNzVVYVNVZktlZm1UTStHYUl4TEtZTXhxM09uN2JyZGFwZkxa?=
 =?utf-8?B?eDFMWXpiRUdJcGpEeTRVOC80L0M0ZWpnTnBaQy9HT0VlKzBQYmRwNjlNU2J0?=
 =?utf-8?B?RWxoVVNmMWd4TkpnblZpTHhiVGM4R3p5K0daZmdrZGlQQkp1R0JQWEFjSWhR?=
 =?utf-8?B?allUQXV3ellBUlQ0SHhCYWlXZjUra3VSbFMycTk3SUU1NTM5eUQzeVlZZWV5?=
 =?utf-8?B?VU5SZ0EvTDU4OGlWc2pQazhhMDdkelIxK1FTZTk5b0N3bkdCcW0xU29wcWxC?=
 =?utf-8?B?d1NCeE9CUHMrM3pkOUFxTWNsR1FRODlabTBTRFcrWldsZElTWXZkbTRjQUxD?=
 =?utf-8?B?RVN5U01OV2ZaVjNrc2tUUS85RU54cTE1TUVxazA2NXlibWhSdFZ2cFIzVU54?=
 =?utf-8?B?SHNIdDNSZGRWQ29xUDRKMTJFK2xHOUZEUUcvcmxoQTQ0SFJlU2plYWJMTFM0?=
 =?utf-8?B?c1hSdTJTVE5ibVBxRlNyZkhkSTk0dnYrR1oxSFVyaEVWZFlWUE9rOXNsRVo4?=
 =?utf-8?B?Mk0zS2V4dkwwV3Y4dUdRSXRuRFU3UnRlaUVIL2ExMGtwRGdOQ1RzcXZFVkRo?=
 =?utf-8?B?Rm55Zzh4S1krZ2pYU2RFUnlnTDJwNmxnQkJCdWVEMktiVUE2WXdLWUpYREJ5?=
 =?utf-8?B?aTMvN29FcFNNV1ZqVXpKSHhlcVpFTld1U0hyWU15QmUwTXpMUnNWNEMxYVVa?=
 =?utf-8?B?d1JCZklGVFRoTzdkOGZvK1orVS9TSSswMDdnZko2eTZ2clBGT0Fad2MzYjha?=
 =?utf-8?B?dHQ2WVpLUWVzU0ZuR0pRT3JwNVpPZ2F5L1EwZjlhS1JlTmVYSHdCVFJ4TTRq?=
 =?utf-8?B?RkFFTG1adlVIanpHSmhyT1dRa3ljSnEvd3pHQmdQT3ZHNk5xRWpRZkRscWhY?=
 =?utf-8?B?WmwybVFXRXpYN3Fuc2tKWkJXYnlQM3pia3YyUE1XcHZWOFphUTd6OWJ6cDkz?=
 =?utf-8?B?VWZMTmpBU0QycWRKaWxja2RreEZSSUpTamZVZit0NExCV0xMMVpjNGN2OTgx?=
 =?utf-8?B?ZmsvTzZVYVI2eC9QWnlQUlhYc3dUWnFXYWlJTFlKUnNsR0JmYjBuZ2U5VUR5?=
 =?utf-8?B?Yk1DSmxyV0R6UDFkYUIrR0R0NWtYM1RrcnZEZC96VWYwcDAzMDIzczB0V2NP?=
 =?utf-8?B?ZkRzZUpSd2lIRmxaMUpvZFk2UWlnUWErUVB0YmtNaU9DQnJnVnhaMnpaS09v?=
 =?utf-8?B?MkVpNVBONVQ3OW9tWW9RSkczT3YyOUhaUmlzQWNaeS9KY1VwU2VWVEYrRUVJ?=
 =?utf-8?B?V1RmcHN1QkI2WjVzaHdHYU5aTVJiN0xpQUQ4UyttazM5cm41NE90Vjczd0Vy?=
 =?utf-8?B?TUJXM0FDNDEySWJFbi9OUndheFZURHQ3NWhzandwUVZWSmljVWp0MVVPOGsx?=
 =?utf-8?B?SjhrWmdxNnVxSGRHbmhDRG1WeVRsb2FNWXczTVdxbVpSUVVMNXJWSnJ5aU5k?=
 =?utf-8?B?SlNtQ2RKa1lEbngvM0VZc29qRExqNG5CQVVQODg2YzdJdlE9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR12MB8411.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cjkzclBhYnpSMnZSOGdsWjVHU0ovNy9tSWYrZlhBMytqYU5aL3BTQXhINnZl?=
 =?utf-8?B?ZXoyRS9Sc2c2VmNqanJqdHk3NDV1bzBscjNXaWtoVnM1S3JKYTIvazVRN3Bv?=
 =?utf-8?B?N1RXK2xpcURRVTM4TlJxR1Y0SEluV3pKTlVQejJFVkpITjgxTHRnbFZrMmVa?=
 =?utf-8?B?T2VJQzJBa3pHQTc2Q2dlK0plVGROa3hxaHJGblYzNjlxblRjZ2JKNkdtcFRT?=
 =?utf-8?B?VHUvNUZWR2JSZVJSamlsTEkyQXEwcjcxWWVIRkNPL3hVb1ZQU2pzSVYwMzgz?=
 =?utf-8?B?ajBsZngrWjdXY3JqbnpHZFZYNHlmdnk4THczTzZsRk9YNW9zdHl0MTNNcFR5?=
 =?utf-8?B?Qk1YU3hhZWxKRlZsaHk1dCszYzBXcW9zeUpGdjBzaHVaYW1zMUJLMDJuMWhQ?=
 =?utf-8?B?d2tRb29YMkUwbEthOFUxc1pmVUdIZFVHcy9rNmNrVDl4L0s0dFIvYlQ2QUU3?=
 =?utf-8?B?bTVUT3B4RDlLS00zbUloZlhWalkrQTlMb2ZFbXg5T05KYy9Ed201MnlKTkFZ?=
 =?utf-8?B?ZUFkV0p3WElwVmlIQ3hPVzlnUHJKbGh3bVREeld2NUxtUVFDMzZTZW83L1hv?=
 =?utf-8?B?YitHOXluZ1pSMkVaSjNqOVQxY1lqWkFlN09yc1FROG5MY2lEdU03MnVBY2ZQ?=
 =?utf-8?B?cTU2Y0l4RHNYdEhOYTVIZ2hvVXlmZFJYQm1mQ1VXR3FmVzBlbWUxMEhuYlRM?=
 =?utf-8?B?RWpwMm1veXgvMUFwYmYwUTB3NVF4LzhwWS8yeTVIVVV4S2xrbVh5ZnIvL1Bo?=
 =?utf-8?B?N2dYS0EwRDY0Wkl1S3ZyaCtjeDllZEVyVFFlM1h2Q3JsYUtSWlpiK1ZFQnU4?=
 =?utf-8?B?NEptOHRZYWNJeW9GRkdzcy92Mm1pSU93TysxN1dXRWluNDlKTWs1a3dvelBz?=
 =?utf-8?B?NmZRUmdaZEk0eG1pdkJhNHNLaENzbldKN0txSVlNM0JqTXpFV09zYS9CbElu?=
 =?utf-8?B?b213M080SkZDL1JSVitUUHJ3bHZsWk04N1VTZnlIUnpWZkgxZzB4bnBTQW9I?=
 =?utf-8?B?Z3B5ZjlDeUV5WU9uV1lnekZBYkw2S3ErY3RqMTlmMHpmanl5aVVtWXRQS0Ja?=
 =?utf-8?B?S1YxWWdORFUwZko0MHh6MXlyTi9icjkwTmpQZ1BBdkRZWVh3VElnTnBuS2U5?=
 =?utf-8?B?MXU3cFl6eDl0UCt6RmNLQVMxbjZvTGVmZlpRakZHaHM2VkJUeDN1bWZBOUV3?=
 =?utf-8?B?NlI5cWY0NkVKU2dQMTcrUFhQM2tscFk4Q1NxUlo1Q2Nza1J3VkJkVld2T2Ni?=
 =?utf-8?B?WUt4NHRZZFJ6aFNFdjlnVFZCcW11d1VyWE80QmhrQ1VSV1dCS3ZTUHBLZit4?=
 =?utf-8?B?RUhxMlpxbDZZbUxySDljdXMvMlVxc21BcE5xL2l1REJ4a1QzdmFHN1NHYU5S?=
 =?utf-8?B?QzhWWWhET25DMDNrYTJFTTBtK1U5NHBIU05tRmMyTmhxUzh4YUx2T0kzV0xX?=
 =?utf-8?B?YTJGcXFNc25VY0ovL2xTazhqRGdqRThOeFVJRDBMdGlnaHJZV3dnNDVJbGxE?=
 =?utf-8?B?ZlA3U1R6UXc5YTR3Wkhma1VSNktGb3JsOTcyRjRaWGhiM0FGNU1LUzZSS2xO?=
 =?utf-8?B?MkNiaGJCbjQrRW1PTFRHWHZ1R3ZVUlJmOEFjeWFNeC9iRlZPOW54U0ZXVm4z?=
 =?utf-8?B?QUMyU0FlSEZ4ZU9xWFE0eXRDa0cvN01zNi9YalA2MW5OaUJuTTdURGJaRGlS?=
 =?utf-8?B?OUY1c3RiT2RiOUtQNnRRWnVPUm9LckE3Ym1nd0E2b3h1Z2ZtNzI2Sm5rQjFh?=
 =?utf-8?B?TWp2dzluQ3o3RGxqc2NhKzVVMFNwYy96aEwrSjgyUktoemxWcGR2cHdzanNk?=
 =?utf-8?B?aEVlRDRuTnJDeUVPU20vekhnekJ3OEhEUzlSdDJ3dWJRQ1hjeUhQV2FKNUov?=
 =?utf-8?B?RWlYUVo2NU9FS0l0SzBlZVVINDdwWG9NS3FoeU9nZjZpQ2ZiUlVqSW5QeFps?=
 =?utf-8?B?MDF1V0E5YjBLYm5TcERuYnhnVXhEdVlhUWxWZllzOW5YUjJ2M1c1ZGZScVJi?=
 =?utf-8?B?cGVkbXc4Rm9pQ3NXM0RXMjZZeThUSmNZV3hOMW5USU54TjZJT3VJd21wcHdx?=
 =?utf-8?B?eDZveDM3eXA3Q25USzNadVdpcjlHd2gwL25Sb05qMzZYdTlHUG5hcmNnNkkr?=
 =?utf-8?Q?9fGc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB8411.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77f5eb38-3e7b-4376-3896-08dd1b938997
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Dec 2024 16:31:03.8866 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rBQ06PCBS4krxicsPS463/Z0swtT4Q2+hshhHIwDiTCmw7E3OSLnhoO6M3c+wJ3p
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6018
Received-SPF: permerror client-ip=2a01:111:f403:2414::60c;
 envelope-from=Frederic.Konrad@amd.com;
 helo=NAM11-BN8-obe.outbound.protection.outlook.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.495,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

K0NDIG1haW50YWluZXJzDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTog
cWVtdS1kZXZlbC1ib3VuY2VzK2Zrb25yYWQ9YW1kLmNvbUBub25nbnUub3JnIDxxZW11LWRldmVs
LWJvdW5jZXMrZmtvbnJhZD1hbWQuY29tQG5vbmdudS5vcmc+IE9uDQo+IEJlaGFsZiBPZiBSaWNo
YXJkIEhlbmRlcnNvbg0KPiBTZW50OiAxMSBEZWNlbWJlciAyMDI0IDIyOjQzDQo+IFRvOiBxZW11
LWRldmVsQG5vbmdudS5vcmcNCj4gU3ViamVjdDogUmU6IFtQQVRDSCAzLzNdIHRhcmdldC9yaXNj
djogZml4IHRoZSB0cmFwIGdlbmVyYXRpb24gZm9yIGNvbmRpdGlvbmFsIHN0b3JlDQo+IA0KPiBP
biAxMi8xMS8yNCAxNToxOSwgRnJlZGVyaWMgS29ucmFkIHdyb3RlOg0KPiA+ICsgICAgLyoNCj4g
PiArICAgICAqIEEgbWlzYWxpZ25lZCBzdG9yZSB0cmFwIHNob3VsZCBiZSB0cmlnZ2VyZWQgZXZl
biBpZiB0aGUgc3RvcmUgc2hvdWxkDQo+ID4gKyAgICAgKiBmYWlsIGR1ZSB0byB0aGUgcmVzZXJ2
YXRpb24uDQo+ID4gKyAgICAgKi8NCj4gPiArICAgIHRjZ19nZW5fYW5kaV90bCh0bXAsIHNyYzEs
IH4oKHVpbnQ2NF90KTApIDw8IG1lbW9wX2FsaWdubWVudF9iaXRzKG1vcCkpOw0KPiANCj4gVGhl
IGNvbnN0YW50IGlzIGluY29ycmVjdCBmb3IgdGVzdGluZyB0aGUgbG93IGJpdHMuDQoNCkhtbSwg
SSBkb24ndCBnZXQgaXQsIGJhc2ljYWxseSB3aXRoIHRoYXQgSSdtIHRyeWluZyB0byBkbzoNCiAg
TU9fODogc3JjMSA9PSAoc3JjMSAmIDB4RkZGRkZGRkYpDQogIE1PXzE2OiBzcmMxID09IChzcmMx
ICYgMHhGRkZGRkZGRSkNCiAgTU9fMzI6IHNyYzEgPT0gKHNyYzEgJiAweEZGRkZGRkZDKQ0KICBl
dGMNCg0Kd2hhdCBhbSBJIG1pc3Npbmc/DQoNCj4gDQo+ID4gKyAgICB0Y2dfZ2VuX2JyY29uZF90
bChUQ0dfQ09ORF9FUSwgdG1wLCBzcmMxLCBsMyk7DQo+IA0KPiBCZXN0IHRvIG1ha2UgdGhlIGZh
bGx0aHJvdWdoIHBhdGggYmUgdGhlIGNvbW1vbiBjYXNlLCBhcyB3ZSB3aWxsIG9wdGltaXplIGFj
cm9zcyB0aGUNCj4gZXh0ZW5kZWQgYmFzaWMgYmxvY2suDQo+IA0KPiBVc2UgdGVzdC1zdHlsZSBj
b21wYXJpc29uOg0KPiANCj4gICAgICB0Y2dfZ2VuX2JyY29uZGlfdGwoVENHX0NPTkRfVFNUTkUs
IHNyYzEsIG1lbW9wX3NpemUobW9wKSAtIDEsIGxfbWlzYWxpZ24pOw0KDQpJbiBhbnkgY2FzZSB0
aGF0IG9uZSBsb29rcyBiZXR0ZXIgdGhhbmtzIGZvciB0aGUgdGlwcyENCg0KQWJvdXQgbWFraW5n
IHRoZSBmYWxsdGhyb3VnaCBwYXRoIGJlIHRoZSBjb21tb24gY2FzZSwgSWYgSSBkbyBpdCBJJ2xs
IG5lZWQgdG8ganVtcCBhbnl3YXkgYW5kIHRoZQ0KZW5kIG9mIHRoaXMgaW5zdHJ1Y3Rpb24gaWU6
DQoNCiAgICBpZiBub3QgYWxpZ25lZCBnbyB0byBtaXNhbGlnbmVkIGxhYmVsOg0KICAgIC4uLg0K
ICAgIGRvIHRoZSBub3JtYWwgb3BlcmF0aW9uDQogICAgLi4uDQogICAgZ28gdG8gZG9uZSBsYWJl
bA0KICAgIG1pc2FsaWduZWQgbGFiZWwNCiAgICAuLi4NCiAgICB0cmlnZ2VyIHRoZSBleGNlcHRp
b24NCiAgICAuLi4NCiAgICBkb25lIGxhYmVsDQoNCklzIHRoYXQgd2hhdCB5b3UgaGFkIGluIG1p
bmQ/DQoNClRoYW5rcywNCkZyZWQNCg0KPiANCj4gDQo+IA0KPiByfg0KDQo=

