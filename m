Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E665BEF06EE
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Feb 2026 01:32:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpG7b-0001sw-EE; Sun, 08 Feb 2026 20:31:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vpG7W-0001qe-Bk; Sun, 08 Feb 2026 20:31:22 -0500
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vpG7T-0007y3-9t; Sun, 08 Feb 2026 20:31:22 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nnPJHikA2nnclFZyzNWkyfZVkTh/3aQ8SP49SzArDr/2s7qKyQWw7s8BZjGSy3Hx6IZy3twWOgFLpKbWHZeu4SuqzR6aD43H2Qls5Q8S8YU6Mp0dmz1vixS93tGFu+FHKJQM29lr9NNtpBJnbPvI2yagzC4w6mhbEatXOj5pSxZ6ArapwqS9meS4XcHU+3pVI7BnN0pYtRYNkm7dPXVNDsOJudZRWM59xC0RlEmCBoi9SQOI4XRqMf/uqXIzxsMwSNuKRO2+wFwW2IretLBokJv31dSN2QqtZcPk3NxYYcO+6nWgfAMt5di2vKMSb7rUemdD0R7UBnIyeIRldNMaGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SsMecKGkalu2QSduG6SnnXnL1dJI7FlgkbaSk5PHKio=;
 b=b+d11GZvsIyUcT3JjfVdYldudAlTrqVIhw2NoVXcrS+ryWqk4DvCF4nDZW6eJem9HpJd5gdYFwUElckYHgn+r/UDXhIid0ttYOU33AfHGKclOL0pyQBTSJkimGrySOVDys9hoG35UkPn9q3hpmSOfu146VpXR3T486OAgonQAhTYJ9371EWXmtVkjfZdye76KpCH/GLI7kFB8+ugTsoOyYdbtFdPTrF6/ptzWwe3UbbhI1KSMfRSpBlWdOWzYMogezpc9Nh451vOl97hb4/g4d2TGMfZ/rkH1xc0qGZo82ehAdG4OBm5jjf0E8ZAiRzvuocOnC0ox9ZM8f2P6jbwjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SsMecKGkalu2QSduG6SnnXnL1dJI7FlgkbaSk5PHKio=;
 b=Jeqg1JU0YAqKwOWAEv+UnA6MFZze6XzVlaMnC6IzHt+pgq3ohAp8WG6ipOgqE8Z3Trc0sfFCSM6TwzolCsYsogVJuGktVtPkHDa9pr3tYwNGtsMZ3uk3vDbgzb1AA0TVPkZ7sBLLHARioAwm/14bmf6gRn1AykvgK4KhaU9i/+4QLiHA23yMTS46tMfT+QlAWlCftGtctygou5oA+SW2ngFe0GeHu4Thknulhi8uJB7sAHkYSVCCt+TIPSSrlTh9TK+g91UvRMFSKWEJJ7AKbvKa8YnED2+Ohc4drUHDk/X7KRFK2PO0muD19nNbM0yrDAGSImX8PG5/XEC5iXxuUw==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by TYZPR06MB6996.apcprd06.prod.outlook.com (2603:1096:405:3e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.18; Mon, 9 Feb
 2026 01:31:06 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9587.017; Mon, 9 Feb 2026
 01:31:06 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, Joel
 Stanley <joel@jms.id.au>, Fabiano Rosas <farosas@suse.de>, Laurent Vivier
 <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "open list:ASPEED
 BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>, 
 "nabihestefan@google.com" <nabihestefan@google.com>
Subject: RE: [PATCH v1 01/10] hw/i2c/aspeed_i2c: Fix Out-of-Bounds access by
 using dynamic register array
Thread-Topic: [PATCH v1 01/10] hw/i2c/aspeed_i2c: Fix Out-of-Bounds access by
 using dynamic register array
Thread-Index: AQHclyongCEX2lqhb0KrtIuPjBKYfrV1eJEAgAQgchA=
Date: Mon, 9 Feb 2026 01:31:05 +0000
Message-ID: <TYPPR06MB8206CCCC0DAA582939D835AEFC65A@TYPPR06MB8206.apcprd06.prod.outlook.com>
References: <20260206053340.3716041-1-jamin_lin@aspeedtech.com>
 <20260206053340.3716041-2-jamin_lin@aspeedtech.com>
 <8aff2a03-65d8-4d9f-8ed5-413e6233bcc5@kaod.org>
In-Reply-To: <8aff2a03-65d8-4d9f-8ed5-413e6233bcc5@kaod.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|TYZPR06MB6996:EE_
x-ms-office365-filtering-correlation-id: 1b6701f8-4b2c-4bf6-df52-08de677ae520
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|7416014|366016|1800799024|38070700021|921020; 
x-microsoft-antispam-message-info: =?utf-8?B?ZEdMY3ZEVEgyMktOQ2xML3phMFNONnJFUkhuYnBGV01SaUVaWmdHK3ArWnB2?=
 =?utf-8?B?VUhQdzE4Sk5RME5nQTV0cER4eDRjbkxkMUNVSDlySGJrZVZINXpqWDYxc1gz?=
 =?utf-8?B?Q2l5bGd3US8vbFF1T05tNDhyMCtLU0ZTYVMzVHI1K3RZVXNSNldWbk9USkp0?=
 =?utf-8?B?bkxiYzB1alhpSDc2dHpFZGYvYjd0a1N2cHVRaVdMZWp6LzBNUnFNeGJhc1Rk?=
 =?utf-8?B?NGZPai9QV2hsVlZhc2tLZGU5MXVlbCtkMWNxNjcxZ0d6WEdRbmxWYzAxY21m?=
 =?utf-8?B?M0ZMN3pJck1ZWnBtK0h3Vm1hdmxFTy81U0RmR1ZHM3pzUDNOdWZjZzRqbnlX?=
 =?utf-8?B?YWV1YkhISHZTUXlpMGEveGxlM3lkeWp4dDVlN2xHR2RzR1lKK2orQ2ZubXlG?=
 =?utf-8?B?RCt3dTVCK09hQUlVVmc3N3FHc0NMMFkzc1U2eGdmdndxQktGUE40YW5lK0do?=
 =?utf-8?B?MDZZaGF1OWFCYUVQbUFQU3BlQ0ZRY1B6cEFsdHhNSG52cDVvWEdOS0l4L2N2?=
 =?utf-8?B?U212aWVlWEs3NTRNZVNhcEJFa1pVQlZlTVdLajJNUCtRcHFwMG5xM1B4aFI4?=
 =?utf-8?B?U05GS1BWYndPczZMVURLVWJ2VmxiZkthSDdVZ3pYZmNBOWFmM2xBTDcwSk40?=
 =?utf-8?B?WmVscDZSVmNTTnBRVGV0OGl0dXdRT3hIeWU0anlDR1ZpUml6cXNEZWk0V2xh?=
 =?utf-8?B?QkpFWnJGemUyQWJIUlkrNm5GN1ZKSkpUQXhzZVNPd2pXbVR1cUZPeERBTnJL?=
 =?utf-8?B?T3FBOVNsVlMyaGE3L09qMXlVNU5IaVNsWXJremQxQXlEVGZQV0VwWHhrU1pD?=
 =?utf-8?B?TGVPQ25SUXdVYy9ySEN0MWNWbURwRmMxcWt3Rkh0SzFEbEdpY213MFRVbk1X?=
 =?utf-8?B?RHJMTklEcUJRL3d4T3Q2aTRWQ2JMOUNRWWlwWlVobWphRlExbXFwb014VjE4?=
 =?utf-8?B?ZzNKeXU5c09DV3VBQ2VYODI2eHBFTHcwNyt5SHN5VDB1WFdlQjlGZzNVUjZP?=
 =?utf-8?B?OSs1TkVOWGJTTVI5NGZuSHlMR1dzdk55UE1oUWhZaG9LMk45ei90OFFsbzlN?=
 =?utf-8?B?YmNFR3VudnJuMDhxanE1eTlHNkIrNURldUovb3pxN3d5KzNmcFBLZzhwSmJS?=
 =?utf-8?B?VTFvVFNOdXVJVHE1WDFvTll4L1psNjZqS2ZDRmVBOWxYYm5RalJzUytkaFlV?=
 =?utf-8?B?QkJlRHhDSjhZNFdTVzdtMEE2ZW1MaXFLYzNCY1lNL0IwZmVBV0RpMHMwUVBJ?=
 =?utf-8?B?UUNEWDBaVkFwdGZaZ0VwSzVna3V6RzNSV0twMGN3M3dCUjBlSWx5amxoS0Zt?=
 =?utf-8?B?bEJXNWpxallDakxzT1E5NlVwL3NpdEkvUkFLWXNFRnhqWWovS0txb0p0R1Yw?=
 =?utf-8?B?SmxaeEJnMWFsa3JvN2hrek5ST0UvSEhMNHZMdEozcUk4YWV0MFpFaHBxMWE1?=
 =?utf-8?B?aUVmTEFpOW9nNEk4Sk5uYXdVQ1N6dGhla3g1SFI5cXc1dUQ4QTl6am8vUmZS?=
 =?utf-8?B?ZktYL0hwTXJxOFFCaHNKVmRGQUY1Zks4eTN5R3RhS0I4WG1ZclI4NElqQlVn?=
 =?utf-8?B?RHkxaFhobERKV0k2OVdEZ0lYckFRTkxlR2lHcHppa0dJSE1HWHdhTG1yQTR2?=
 =?utf-8?B?VUtxZ1E5dFRDdEpTWG9aWE0vS2xHU0RKcktSRFZRVEdVN2pIWEVkUGxxWHVy?=
 =?utf-8?B?NXp4V3J3RjlsS0ZXTnJQTk5pYXA2YTZvYnlOUi9BTzQxc3BYd3IvQWdVMjM0?=
 =?utf-8?B?dFJVcEdSMTFTVmZVWlA5UnM2a00ydUlodFpCOU1nZVNFR2VYU0dNa3RaVlYr?=
 =?utf-8?B?d0NxSExndjZlY0lBcUhRRG5iTzlXQUZZbFlwSUpmemhpV1JXUitwRURlYlpr?=
 =?utf-8?B?M3pkOG0vR1FON3Y3a3lBNTdKaTZ4WWhJS0FWcE11a1RBZEpoZDFHUWZQZmRy?=
 =?utf-8?B?eng5WXRqWlhxK2hCQ2tyUm5xU29KMlF1dzM1djY5NXpjNEJnR3FxNjVYbmxy?=
 =?utf-8?B?NlRKQ3pDSWNGN002M0wyeTE4ZGQ1clVmZzE1LzhKbGs2RGpNNkFDSjBVRXk3?=
 =?utf-8?B?ZCtUMDVjVGNJb1RIYmlWYXJ1TkZOTzFqbGE4S01ReUxkUUdrTFhvNkszQk1K?=
 =?utf-8?B?Y0F2T3Z3bmdUYmEwR0JLSXhmMjBFL0J6UVZVOFZ0Y0hmUGdVMkxJS2JoSzFo?=
 =?utf-8?Q?l22EfhCSi+vkTiuJjLoCC9ACKBo5gbEertZ6FE22lg2Z?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE;
 SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700021)(921020);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?a2hGcStWNDNoUm4rejYwdjR6MmFFTkZaSjU5SlhWcEdMN3NBZ2thMGpyMnoy?=
 =?utf-8?B?R0FmMUV0alcxMXdlRzBIK3Z3dzlPT2RHa3l3N1JtWS9xN2VpZk44T1AvbEo4?=
 =?utf-8?B?OWZpcG51VGVWdlhJTEc5ZjVxR0FyU1FjUzhuVWpCWmc1QmRUZldUbjUza0xu?=
 =?utf-8?B?b3ZyUTgxVk53a1BObzEzQzl5UEY2ODNqcnk0SUI2ZDBxKzVpTUFuckh3bkk0?=
 =?utf-8?B?UVFxaXVRaUQ4YW9sM1VWNlNwdUVFVUttU2c1RFdFaWV4eEQyV0dQSHl3ZGpE?=
 =?utf-8?B?ZVdzMC9OVTUra3gvWk1McHhEb1NURXNBaUpubVpHOFU2UkVBRkZjSTlOcERO?=
 =?utf-8?B?ZTFXbVJ6bVZpemora3V3Z1JONzRXMDlEZWxka3BCRFVhTlVqRXJ5S01OVUFJ?=
 =?utf-8?B?WXBFYnphSU56YURjMHpBVlNHWW1mMnl5WVNHQVMvWEkzcTBud0V6Y3A5ZE4w?=
 =?utf-8?B?UjY1N0J0MlZ3ai9raDV2WExqNVFjSERxeDNNYTU0QmkxSTVXc0VGRHI0TTZP?=
 =?utf-8?B?TVA4OUVMYUpDdkxVVEt2aDdnUDRXL1FJK2JKamhzNC9kdUdrazZKSEppTUdJ?=
 =?utf-8?B?c1dTK0xuYXg3V1U1cUcxRmtoVjVtNHhqSitQVlNSTytwYndxZUVKdThxYVhN?=
 =?utf-8?B?SVFSZ25vSUdZK054cFB1dnZXSzlubjBTL3pQcmx1eDlxU3Rra3hhTUJLWFRE?=
 =?utf-8?B?Z28xbDZGbitlVkZMUjZkVS83VzVVcm1hQWpmT2xWSHgrWkUxSmh2dnFTdGJ2?=
 =?utf-8?B?MkdYbmYxSTBabEowdmF0dVdzTGpuemY5Vm9KY1FhYm5PUlkvaHNzV1g5ZjFr?=
 =?utf-8?B?eGZ6UXJZWDlkZ2JkV29xcWZwRFhIYU1mQ3J5WWtJSE0raEdIQ1N1TVhGanU4?=
 =?utf-8?B?aWFIVFpBQjdwOHV6N2VjTmRDUmRiVnl5TXdVeUJjTGJKSkcwYlMwWTVpQ2RW?=
 =?utf-8?B?U0xzS1VDNzdYSWNaK2xJN00vVDFzeWx2M3E2RWtTN3o5TnpSNnpNcnI1R2JX?=
 =?utf-8?B?QzdZUXNLRGdyRUdTblZRSWVtS2Y5b0FTK09tbjljZmdBK2duLzlkZmpXejhN?=
 =?utf-8?B?R2ZtaEJNSW9jbERoWmtxY1FDeDBBQTg4VTY4OFJjVjJxeUxVemdodE1QdVBC?=
 =?utf-8?B?TVhBZnhLN1dTVkRTVUg2cTNXeURqWStHRjc5M05GUUVNZnJVemZjVm1XTTFG?=
 =?utf-8?B?b0s4OWpTdHBpRFRXNmxMSU1nS0kwZ2UxQmpPaXZYKzRwRWRxbDF0Ym10WFVj?=
 =?utf-8?B?QTVxbUVGOW1OWlIvMU1JOUV5R1hoZU5GWkplbW1pUG5TSHJWeGhXUUQrbFZM?=
 =?utf-8?B?SzBvTmtKYi9lcXUwdHoyWHdRYUJYZ1RyZkRzNEhpby8zVHVhS2trOE0xSGcv?=
 =?utf-8?B?Ty8xdXNmeXIxK0J3RjU4c2VQelcrN3JmMll5MGVmblh2T2lpM1BPbWd3V04y?=
 =?utf-8?B?NG43N2JUME12aytlS2FsaGsrb1IrZ2x5RExLaXRTc1lMWlRQS3JPM3M0YmNl?=
 =?utf-8?B?U1FPRG1kN21WeGl0ZXN6UmROUUo3RjBoM004eDEzOGYyR2hOSWVsYzNTUFFC?=
 =?utf-8?B?aTRYYU9hWnNEZkJUcEVqeCtjRE5mM1RZTElVVVJuL0tMaXprR20xY3Rza256?=
 =?utf-8?B?ZFRxQXdMSnpuSGxRMXlPUjlUTTFteWZxK0ZmcllwQjJTUy80b0xab1dpbTZW?=
 =?utf-8?B?UjJxa2lWMEE0VzdGMlVYRUx5dlpoS2l4dTAwcWE3Snkxd2crR1JOV0g3YlN3?=
 =?utf-8?B?SGxreVVrK0UwY3BTekt0MEVGV3BuZU9ySGdrT3VKcjdsSC9NaVMyYWN3V01L?=
 =?utf-8?B?a1J2cW1mcjE3V2NzL1ZZckdwZW9ZK0tHYm9selpqdXlMQjI5UHB2bkU2VkI1?=
 =?utf-8?B?L083NjBBSUUrV2JUWHpockM4bkhZWjlna3lNcC9NdTlrVW00WUtZM3B0ZGMx?=
 =?utf-8?B?eDRrSVFlanQ4bWg1RzROVTJVU1VEQzd0RFJTaGZhbncvb3c1VUhsNUVEQzJq?=
 =?utf-8?B?STdKeTgyNUFsdlA5TzA1bHRYVjFFbGt4Slo0bllTbk96VW9xQWcxNHZuVzA1?=
 =?utf-8?B?cWpxTGV2OGZLLzIxVDhJYWlRUzVaRmVITm1RWkRPc3lmN2U4ZHl4ZnBaaU9X?=
 =?utf-8?B?aWQwY0k4VjVIL08yWFlrb09ORHE0RTdLQklxdWQ4VHlyVFF3ZkZSNDh2U2p5?=
 =?utf-8?B?cURGNHRpVUZJZllkekJSUmZBNnM5MzBFVVZRRWlyNnY0ZUdJRmNpSTgrUzNP?=
 =?utf-8?B?bTBSVTNKTzkzZ1NOUU1sVExITGVNbENoTVltQS9SOFlncjVIZFNodlFMK1Vn?=
 =?utf-8?B?MnZCbjlRYWp3TmtNc0p2dG8yM2NZbXJGT2lPN2djZHIvZERZcDMvZz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b6701f8-4b2c-4bf6-df52-08de677ae520
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Feb 2026 01:31:06.0497 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 27XItFcpvzcdK2gXfF21/SynCe7Euf3to4FtvZnY4QlwU6JB26deeaII1doDgS8uIZVukQfaCv5GcgAdaklC4R41/TJ+qM3JTgKACadnY1Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB6996
Received-SPF: pass client-ip=2a01:111:f403:c405::5;
 envelope-from=jamin_lin@aspeedtech.com;
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

SGkgQ8OpZHJpYw0KDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjEgMDEvMTBdIGh3L2kyYy9hc3Bl
ZWRfaTJjOiBGaXggT3V0LW9mLUJvdW5kcyBhY2Nlc3MgYnkNCj4gdXNpbmcgZHluYW1pYyByZWdp
c3RlciBhcnJheQ0KPiANCj4gT24gMi82LzI2IDA2OjMzLCBKYW1pbiBMaW4gd3JvdGU6DQo+ID4g
VGhlIEFTUEVFRCBJMkMgY29udHJvbGxlciBlbXVsYXRpb24gdXNlZCBhIGZpeGVkLXNpemUgcmVn
aXN0ZXIgYXJyYXkNCj4gPiAoMjggZHdvcmRzKSBmb3IgYWxsIFNvQyB2YXJpYW50cywgd2hpbGUg
bXVsdGlwbGUgQVNQRUVEIFNvQ3MgKEFTVDI2MDAsDQo+ID4gQVNUMTAzMCwgQVNUMjcwMCkgZXhw
b3NlIGEgbGFyZ2VyIE1NSU8gcmVnaXN0ZXIgd2luZG93IChlLmcuIHJlZ19zaXplDQo+ID4gPSAw
eDgwKS4NCj4gPg0KPiA+IFRoaXMgbWlzbWF0Y2ggYWxsb3dzIE1NSU8gYWNjZXNzZXMgYmV5b25k
IHRoZSBhbGxvY2F0ZWQgcmVnaXN0ZXINCj4gPiBhcnJheSwgbGVhZGluZyB0byBvdXQtb2YtYm91
bmRzIHJlYWRzIGluIHRoZSBJMkMgY29udHJvbGxlciBtb2RlbC4NCj4gPg0KPiA+IEZpeCB0aGlz
IGJ5IGNvbnZlcnRpbmcgdGhlIHJlZ2lzdGVyIHN0b3JhZ2UgdG8gYSBkeW5hbWljYWxseSBhbGxv
Y2F0ZWQNCj4gPiBhcnJheSBzaXplZCBhY2NvcmRpbmcgdG8gdGhlIGNvbnRyb2xsZXIgY2xhc3Mg
cmVnX3NpemUuIFRoZSByZWdpc3Rlcg0KPiA+IGFycmF5IGlzIG5vdyBhbGxvY2F0ZWQgZHVyaW5n
IGJ1cyByZWFsaXplIGFuZCBmcmVlIG9uIHVucmVhbGl6ZSwNCj4gPiBlbnN1cmluZyBzYWZlIGFj
Y2VzcyBhY3Jvc3MgZGlmZmVyZW50IEFTUEVFRCBTb0MgaW1wbGVtZW50YXRpb25zLg0KPiA+DQo+
ID4gVGhpcyBjaGFuZ2UgZWxpbWluYXRlcyBJMkMgcmVnaXN0ZXIgb3V0LW9mLWJvdW5kcyBhY2Nl
c3MgY2F1c2VkIGJ5DQo+ID4gU29DLXNwZWNpZmljIHJlZ2lzdGVyIHNpemUgZGlmZmVyZW5jZXMu
DQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBKYW1pbiBMaW4gPGphbWluX2xpbkBhc3BlZWR0ZWNo
LmNvbT4NCj4gPiBSZXNvbHZlczogaHR0cHM6Ly9naXRsYWIuY29tL3FlbXUtcHJvamVjdC9xZW11
Ly0vaXNzdWVzLzMyOTANCj4gDQo+IFBsZWFzZSBrZWVwIHRoaXMgcGF0Y2ggc2VwYXJhdGUgZnJv
bSB0aGUgQTIgc2VyaWVzLg0KVGhhbmtzIGZvciB0aGUgcmV2aWV3Lg0KV2lsbCByZXNlbmQNCg0K
VGhhbmtzLUphbWluDQoNCj4gDQo+ID4gLS0tDQo+ID4gICBpbmNsdWRlL2h3L2kyYy9hc3BlZWRf
aTJjLmggfCAgNCArLS0tDQo+ID4gICBody9pMmMvYXNwZWVkX2kyYy5jICAgICAgICAgfCAxOCAr
KysrKysrKysrKysrKy0tLS0NCj4gPiAgIDIgZmlsZXMgY2hhbmdlZCwgMTUgaW5zZXJ0aW9ucygr
KSwgNyBkZWxldGlvbnMoLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2h3L2kyYy9h
c3BlZWRfaTJjLmggYi9pbmNsdWRlL2h3L2kyYy9hc3BlZWRfaTJjLmgNCj4gPiBpbmRleCA2OGJk
MTM4MDI2Li4yMDVmMGE1OGQyIDEwMDY0NA0KPiA+IC0tLSBhL2luY2x1ZGUvaHcvaTJjL2FzcGVl
ZF9pMmMuaA0KPiA+ICsrKyBiL2luY2x1ZGUvaHcvaTJjL2FzcGVlZF9pMmMuaA0KPiA+IEBAIC0z
Niw4ICszNiw2IEBAIE9CSkVDVF9ERUNMQVJFX1RZUEUoQXNwZWVkSTJDU3RhdGUsDQo+IEFzcGVl
ZEkyQ0NsYXNzLCBBU1BFRURfSTJDKQ0KPiA+ICAgI2RlZmluZSBBU1BFRURfSTJDX05SX0JVU1NF
UyAxNg0KPiA+ICAgI2RlZmluZSBBU1BFRURfSTJDX1NIQVJFX1BPT0xfU0laRSAweDgwMA0KPiA+
ICAgI2RlZmluZSBBU1BFRURfSTJDX0JVU19QT09MX1NJWkUgMHgyMCAtI2RlZmluZQ0KPiA+IEFT
UEVFRF9JMkNfT0xEX05VTV9SRUcgMTEgLSNkZWZpbmUgQVNQRUVEX0kyQ19ORVdfTlVNX1JFRyAy
OA0KPiA+DQo+ID4gICAjZGVmaW5lIEFfSTJDRF9NX1NUT1BfQ01EICAgICAgIEJJVCg1KQ0KPiA+
ICAgI2RlZmluZSBBX0kyQ0RfTV9SWF9DTUQgICAgICAgICBCSVQoMykNCj4gPiBAQCAtMjU2LDcg
KzI1NCw3IEBAIHN0cnVjdCBBc3BlZWRJMkNCdXMgew0KPiA+ICAgICAgIHVpbnQ4X3QgaWQ7DQo+
ID4gICAgICAgcWVtdV9pcnEgaXJxOw0KPiA+DQo+ID4gLSAgICB1aW50MzJfdCByZWdzW0FTUEVF
RF9JMkNfTkVXX05VTV9SRUddOw0KPiA+ICsgICAgdWludDMyX3QgKnJlZ3M7DQo+ID4gICAgICAg
dWludDhfdCBwb29sW0FTUEVFRF9JMkNfQlVTX1BPT0xfU0laRV07DQo+ID4gICAgICAgdWludDY0
X3QgZG1hX2RyYW1fb2Zmc2V0Ow0KPiA+ICAgfTsNCj4gPiBkaWZmIC0tZ2l0IGEvaHcvaTJjL2Fz
cGVlZF9pMmMuYyBiL2h3L2kyYy9hc3BlZWRfaTJjLmMgaW5kZXgNCj4gPiBmYjNkNmE1NjAwLi5j
ZjNhMDAzOTc4IDEwMDY0NA0KPiA+IC0tLSBhL2h3L2kyYy9hc3BlZWRfaTJjLmMNCj4gPiArKysg
Yi9ody9pMmMvYXNwZWVkX2kyYy5jDQo+ID4gQEAgLTEwOTEsMTAgKzEwOTEsOSBAQCBzdGF0aWMg
Y29uc3QgTWVtb3J5UmVnaW9uT3BzDQo+ID4gYXNwZWVkX2kyY19idXNfcG9vbF9vcHMgPSB7DQo+
ID4NCj4gPiAgIHN0YXRpYyBjb25zdCBWTVN0YXRlRGVzY3JpcHRpb24gYXNwZWVkX2kyY19idXNf
dm1zdGF0ZSA9IHsNCj4gPiAgICAgICAubmFtZSA9IFRZUEVfQVNQRUVEX0kyQywNCj4gPiAtICAg
IC52ZXJzaW9uX2lkID0gNiwNCj4gPiAtICAgIC5taW5pbXVtX3ZlcnNpb25faWQgPSA2LA0KPiA+
ICsgICAgLnZlcnNpb25faWQgPSA3LA0KPiA+ICsgICAgLm1pbmltdW1fdmVyc2lvbl9pZCA9IDcs
DQo+ID4gICAgICAgLmZpZWxkcyA9IChjb25zdCBWTVN0YXRlRmllbGRbXSkgew0KPiA+IC0gICAg
ICAgIFZNU1RBVEVfVUlOVDMyX0FSUkFZKHJlZ3MsIEFzcGVlZEkyQ0J1cywNCj4gQVNQRUVEX0ky
Q19ORVdfTlVNX1JFRyksDQo+IA0KPiBobW0sIHdoeSBub3QgdXNlIFZNU1RBVEVfVkFSUkFZX1VJ
TlQzMiA/DQo+IA0KPiA+ICAgICAgICAgICBWTVNUQVRFX1VJTlQ4X0FSUkFZKHBvb2wsIEFzcGVl
ZEkyQ0J1cywNCj4gQVNQRUVEX0kyQ19CVVNfUE9PTF9TSVpFKSwNCj4gPiAgICAgICAgICAgVk1T
VEFURV9VSU5UNjQoZG1hX2RyYW1fb2Zmc2V0LCBBc3BlZWRJMkNCdXMpLA0KPiA+ICAgICAgICAg
ICBWTVNUQVRFX0VORF9PRl9MSVNUKCkNCj4gPiBAQCAtMTQ2NSw4ICsxNDY0LDkgQEAgc3RhdGlj
IGNvbnN0IFR5cGVJbmZvIGFzcGVlZF9pMmNfYnVzX3NsYXZlX2luZm8gPQ0KPiB7DQo+ID4gICBz
dGF0aWMgdm9pZCBhc3BlZWRfaTJjX2J1c19yZXNldChEZXZpY2VTdGF0ZSAqZGV2KQ0KPiA+ICAg
ew0KPiA+ICAgICAgIEFzcGVlZEkyQ0J1cyAqcyA9IEFTUEVFRF9JMkNfQlVTKGRldik7DQo+ID4g
KyAgICBBc3BlZWRJMkNDbGFzcyAqYWljID0gQVNQRUVEX0kyQ19HRVRfQ0xBU1Mocy0+Y29udHJv
bGxlcik7DQo+ID4NCj4gPiAtICAgIG1lbXNldChzLT5yZWdzLCAwLCBzaXplb2Yocy0+cmVncykp
Ow0KPiA+ICsgICAgbWVtc2V0KHMtPnJlZ3MsIDAsIGFpYy0+cmVnX3NpemUpOw0KPiA+ICAgICAg
IGkyY19lbmRfdHJhbnNmZXIocy0+YnVzKTsNCj4gPiAgIH0NCj4gPg0KPiA+IEBAIC0xNDkyLDYg
KzE0OTIsNyBAQCBzdGF0aWMgdm9pZCBhc3BlZWRfaTJjX2J1c19yZWFsaXplKERldmljZVN0YXRl
DQo+ICpkZXYsIEVycm9yICoqZXJycCkNCj4gPiAgICAgICBzLT5zbGF2ZSA9IGkyY19zbGF2ZV9j
cmVhdGVfc2ltcGxlKHMtPmJ1cywNCj4gVFlQRV9BU1BFRURfSTJDX0JVU19TTEFWRSwNCj4gPiAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDB4ZmYpOw0KPiA+DQo+ID4g
KyAgICBzLT5yZWdzID0gZ19uZXcodWludDMyX3QsIGFpYy0+cmVnX3NpemUgPj4gMik7DQo+IA0K
PiBnX25ldzAgPyBldmVuIGlmIHRoZSBtZW1zZXQgaW4gcmVzZXQgd2lsbCBzZXQgcmVnc1tdIGNv
bnRlbnRzIHRvIDAuDQo+IA0KPiA+ICAgICAgIG1lbW9yeV9yZWdpb25faW5pdF9pbygmcy0+bXIs
IE9CSkVDVChzKSwgJmFzcGVlZF9pMmNfYnVzX29wcywNCj4gPiAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgcywgcy0+bmFtZSwgYWljLT5yZWdfc2l6ZSk7DQo+ID4gICAgICAgc3lzYnVzX2lu
aXRfbW1pbyhTWVNfQlVTX0RFVklDRShkZXYpLCAmcy0+bXIpOyBAQCAtMTUwMSw2DQo+ID4gKzE1
MDIsMTQgQEAgc3RhdGljIHZvaWQgYXNwZWVkX2kyY19idXNfcmVhbGl6ZShEZXZpY2VTdGF0ZSAq
ZGV2LCBFcnJvcg0KPiAqKmVycnApDQo+ID4gICAgICAgc3lzYnVzX2luaXRfbW1pbyhTWVNfQlVT
X0RFVklDRShkZXYpLCAmcy0+bXJfcG9vbCk7DQo+ID4gICB9DQo+ID4NCj4gPiArc3RhdGljIHZv
aWQgYXNwZWVkX2kyY19idXNfdW5yZWFsaXplKERldmljZVN0YXRlICpkZXYpIHsNCj4gPiArICAg
IEFzcGVlZEkyQ0J1cyAqcyA9IEFTUEVFRF9JMkNfQlVTKGRldik7DQo+ID4gKw0KPiA+ICsgICAg
Z19mcmVlKHMtPnJlZ3MpOw0KPiA+ICsgICAgcy0+cmVncyA9IE5VTEw7DQo+ID4gK30NCj4gPiAr
DQo+ID4gICBzdGF0aWMgY29uc3QgUHJvcGVydHkgYXNwZWVkX2kyY19idXNfcHJvcGVydGllc1td
ID0gew0KPiA+ICAgICAgIERFRklORV9QUk9QX1VJTlQ4KCJidXMtaWQiLCBBc3BlZWRJMkNCdXMs
IGlkLCAwKSwNCj4gPiAgICAgICBERUZJTkVfUFJPUF9MSU5LKCJjb250cm9sbGVyIiwgQXNwZWVk
STJDQnVzLCBjb250cm9sbGVyLA0KPiA+IFRZUEVfQVNQRUVEX0kyQywgQEAgLTE1MTQsNiArMTUy
Myw3IEBAIHN0YXRpYyB2b2lkDQo+ID4gYXNwZWVkX2kyY19idXNfY2xhc3NfaW5pdChPYmplY3RD
bGFzcyAqa2xhc3MsIGNvbnN0IHZvaWQgKmRhdGEpDQo+ID4NCj4gPiAgICAgICBkYy0+ZGVzYyA9
ICJBc3BlZWQgSTJDIEJ1cyI7DQo+ID4gICAgICAgZGMtPnJlYWxpemUgPSBhc3BlZWRfaTJjX2J1
c19yZWFsaXplOw0KPiA+ICsgICAgZGMtPnVucmVhbGl6ZSA9IGFzcGVlZF9pMmNfYnVzX3VucmVh
bGl6ZTsNCj4gPiAgICAgICBkZXZpY2VfY2xhc3Nfc2V0X2xlZ2FjeV9yZXNldChkYywgYXNwZWVk
X2kyY19idXNfcmVzZXQpOw0KPiA+ICAgICAgIGRldmljZV9jbGFzc19zZXRfcHJvcHMoZGMsIGFz
cGVlZF9pMmNfYnVzX3Byb3BlcnRpZXMpOw0KPiA+ICAgfQ0KDQo=

