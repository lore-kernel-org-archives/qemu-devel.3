Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16134C83F34
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Jul 2025 19:14:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ucU3C-0007U9-3t; Thu, 17 Jul 2025 15:13:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mburton@qti.qualcomm.com>)
 id 1ucRHP-0006vF-VX
 for qemu-devel@nongnu.org; Thu, 17 Jul 2025 12:16:20 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mburton@qti.qualcomm.com>)
 id 1ucRHN-0003SB-Ha
 for qemu-devel@nongnu.org; Thu, 17 Jul 2025 12:16:19 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56HCUWxG032375;
 Thu, 17 Jul 2025 16:15:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-id:content-transfer-encoding:content-type:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 qcppdkim1; bh=w+Mj17G7/gWGs4ja0X15m/lFHEuxIKsyjywbk09FFsM=; b=G6
 ERV3VF039fnM/Bur2ZtJPfmMnXicNYhzcROAkFmAV/b6kIbpxWYXWieAtjrTK45g
 HauF94hq85NN9cAvW06CS4zzR99aRJWoKNGl6mWNh1W4YtxZRSZbEQc/lLAWom/k
 wY9pPJFOp1qfmEtwj3ChFb0ewbd43tlpVusTahaeyIRGnnoEkQWsZcwlxi0Y+rcP
 AeVAy8pePePSf+2s/4voBnTCwQnFroc/LPPv9/Yxw694Ef2fRU17qumcKfUMQ0ze
 DW01u6O0XOIh0ZdNAsa/I0s9sPgB9P0faVya7Fsnc+QvdsRIHdA4e/BHDuh5xikr
 Gcl3gg3+2aR8OqaBLpSw==
Received: from nam04-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam04lp2173.outbound.protection.outlook.com [104.47.73.173])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47ug388gyt-2
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 17 Jul 2025 16:15:48 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gP4VkR2k02BxTHa4A+ieSfIJi98ovAwm8jIzIefIuvN0uhJXg/rCjDnmXJ/c2a1ehwnh3ZRh7RU324g+KsFZfpepTINAY9PbBht2/o+RaWoNq3jTsyiZYgzrDvqdTrwtn6IVJRBD5u4sOjxQ9dhicv77ZSjq6K1WC7uSOu02+9QfWlRZvyVv+8JbfCQqMO+nUyL3beySiuiJoRZWuSTgTDy6gpVbJsSJJxW9BRxrJjHarbL9CBjutwlgpmZw8geDgBhF0egzvPTdmjRRKh3/kLIXZQAGpl9hFw33AVZNfzxAdJnRARlYtT9+utN/7jFNWNYVp1z3IDGzlGdrvCb25Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w+Mj17G7/gWGs4ja0X15m/lFHEuxIKsyjywbk09FFsM=;
 b=v+jBWqckXOztXwvAmmuFtBGkqhtRMrrK20xEej/tyM6euyGqaeeDrCvv2XDO9/g4auJPkGsl45QMckz4j/aOMx1bIJh2X8QX4OnI6JKHJAAOWBGmndDWT3mAbU77gkhJqTBYCHp2Gs7MOmkDKuCf3vAfvXr1oi7eMbAcODtAWnKOPb+au7Y0Fi/F53osJ1xlDFmozlCQwbgzghTbpGCsUhnOBkCgBV7apFD1abyOaGLCmzzWoTG4gQyctAghBPoy4g1HeqQFx5gztlttfE/JS74ihrqNaq4zw//ph8iql/4nq7A53B98W5j41OIoJbgqp04UX80uegW0MrA9I20yew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=qti.qualcomm.com; dmarc=pass action=none
 header.from=qti.qualcomm.com; dkim=pass header.d=qti.qualcomm.com; arc=none
Received: from CO1PR02MB8617.namprd02.prod.outlook.com (2603:10b6:303:15c::20)
 by CYYPR02MB9668.namprd02.prod.outlook.com (2603:10b6:930:c3::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.39; Thu, 17 Jul
 2025 16:15:44 +0000
Received: from CO1PR02MB8617.namprd02.prod.outlook.com
 ([fe80::5a28:4da0:a734:9bcf]) by CO1PR02MB8617.namprd02.prod.outlook.com
 ([fe80::5a28:4da0:a734:9bcf%4]) with mapi id 15.20.8922.037; Thu, 17 Jul 2025
 16:15:44 +0000
From: Mark Burton <mburton@qti.qualcomm.com>
To: Marc Zyngier <maz@kernel.org>
CC: Peter Maydell <peter.maydell@linaro.org>, Danny Canter
 <danny_canter@apple.com>, =?utf-8?B?QWxleCBCZW5uw6ll?=
 <alex.bennee@linaro.org>, Joelle van Dyne <j@getutm.app>, qemu-devel
 <qemu-devel@nongnu.org>, Alexander Graf <agraf@csgraf.de>, Ynddal
 <mads@ynddal.dk>, Cameron Esfahani <dirty@apple.com>, Roman Bolshakov
 <rbolshakov@ddn.com>, Phil Dennis-Jordan <phil@philjordan.eu>,
 =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>, Richard
 Henderson <richard.henderson@linaro.org>
Subject: Re: HVF EL2 support in QEMU (aka FEAT_NV/FEAT_NV2) for MacOS
Thread-Topic: HVF EL2 support in QEMU (aka FEAT_NV/FEAT_NV2) for MacOS
Thread-Index: AQHb9XnZWftNeaLjp0eXvxtixxiKrLQzEqOAgABDgYCAAQTxAIAAUTQIgAHETgCAAAWIAIAAAg39gAAIQoCAAACpgA==
Date: Thu, 17 Jul 2025 16:15:44 +0000
Message-ID: <E866F234-A3D3-450C-ABF7-DE95AD23BDAE@qti.qualcomm.com>
References: <87zfd5zouv.fsf@draig.linaro.org> <86wm898yf4.wl-maz@kernel.org>
 <CA+E+eSASz9Tx76-8PxMNF30f3L9DfPNYf_Zgf=ENozXapc3gyw@mail.gmail.com>
 <03A3BBBF-6A01-4ECB-BE50-8103B9201528@apple.com>
 <87a554z5wp.fsf@draig.linaro.org>
 <B08AAF88-3770-478A-8589-ADB407878B19@apple.com>
 <CAFEAcA_s2zXkSZCWXqJ7nWTka5wwBPiKJyHmYE7fGr2=fNsOvw@mail.gmail.com>
 <CO1PR02MB86174C98FACECFFD6116231B8F51A@CO1PR02MB8617.namprd02.prod.outlook.com>
 <86tt3a94o8.wl-maz@kernel.org>
In-Reply-To: <86tt3a94o8.wl-maz@kernel.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR02MB8617:EE_|CYYPR02MB9668:EE_
x-ms-office365-filtering-correlation-id: b0e378ae-d713-4d2a-0c2c-08ddc54d2e92
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?VEwxcTJKZ2VJV1I4c1V3MWNDVERESHZtK0Jid21ZZEFzMlBIWEQvbERvOHdl?=
 =?utf-8?B?UVdQdGJJWDA5WlducSt2T2hDLytFY2lHaC9XYVRtbFdacXZHZnRSOE5HdjBh?=
 =?utf-8?B?SUFDckRocnBZZDZoWDhkaUEvZlcvTExXTHlFR1ZicGF4Z2IrcWxkM29Gb1Vz?=
 =?utf-8?B?ZnhNRXArUXF6NEJNVS8xNTZlbEtJN0x4QjNUNTBTZjRSZkNsUkVGazd2U0xG?=
 =?utf-8?B?dUlGbjk3Q1h0SC9vak1HbXNYTHA3NDU4L053QUtvcklvT2ZVbkprallBN3pI?=
 =?utf-8?B?NXJQNUxnQk10WTg5RHd1cUllMUtxeExjOU9peWdsbWdsVzhrMVpqak5QdUJZ?=
 =?utf-8?B?Tk00TkJBS3hENTc5TWtNeG94WmdTbjQxMTNCVXREZnRmVitkRzVzOXpvZUEy?=
 =?utf-8?B?NEpHd0JzeFZRUjJkeFZhSlA3Y1NLcVRRR3lTR25YbXAwSUpMMVpzTnVhQ0lQ?=
 =?utf-8?B?VG1VNGpJWFZNbk9nOHZjR3B1ejNGdDRDNW5nS1R1aVZ4RFVWRUY0TnVlTDhO?=
 =?utf-8?B?NUNDVzg1clFsV1FubmN3YUdXYitSeTdMU1NNaE9TL1QzajQ1NytyR21KUDNS?=
 =?utf-8?B?dVFiM0I5YXpMYVFOM1RUSmF5RWJZV3huNnRUaU1xaVB1cUtVRGxhOEREUlRM?=
 =?utf-8?B?aWQ0NnhqeUxnSVU4Qi9RdXNJWjB2YkY3d0QrSE1XOERidG9NazFBQ0w3djB1?=
 =?utf-8?B?RjBaQUlySVcwSlZlU1kwN0l2bGNtcEFsT1lPSlVMNXhGOE1XbE9rV3NuZkR1?=
 =?utf-8?B?NnhrUkRvd3ZwOHFRZjJFdXNXd0pHQ0tLWmFVWG53cGtPTXlkZS9IN0NsaHRT?=
 =?utf-8?B?WDFpbHh3ZEJFY1B3akxwWEFwTkxNUW5UVlR3Z1RXSGJpT3I4Y1pNaVdsT1BC?=
 =?utf-8?B?VjVYdmQ1OGNmRlJXcXJtanBlWkFtWTVlekFEcEZhQUlTZ3FjR283RVhaVVBH?=
 =?utf-8?B?U01aM2ZYaWhMcElGYkZsVEg4V2tWNC9RSGNuY1ZIeDl2RkVYRkQvY05CVTFr?=
 =?utf-8?B?VlVHaWROK3RUbC9ZcnVodHA5UU0wSjBxUnhIVWtmanJJR0o1NHdOSHkyTzdj?=
 =?utf-8?B?N1p0WHhzVmN0TFp4QitvYnRhM1JmaFZkWHg1MXdIbDdBcTVvalV0WjBFQ3pW?=
 =?utf-8?B?dHVpWXJJU3o2a25ndktXUDlQY0tmeDVYUUNBY1ZvSElyYTMrRFAwTG1kc3U0?=
 =?utf-8?B?MUszZzM2am43WW5xbmwzeTJzVDgrakEzTkU3bFB0alJ5TjV0b0grcGpQZGdL?=
 =?utf-8?B?Z3FkcUxSSkNORkxIdW1VOXhFWE1FQ3dyeEIwci9wVnNuaTVyMnZBMUVYdDVv?=
 =?utf-8?B?elUwVmk5OWhnaExqNU8wZnZnK041QWZQaE9HaEZNeWJUZStjcUdSRVFEYm5N?=
 =?utf-8?B?VGRTUzJUZVRyYUJCZ3prSkQwUXIzdmR6cC9iREIyY3hENTFMR3UxUjlwVXBW?=
 =?utf-8?B?ZUtYZFRkQ1UyeXVjYmg1T2lDYU10MGs5NUdIQjFvQW5JRnhKbnFKcnc3dWF5?=
 =?utf-8?B?MkVLanE1cXBsYndJcmFwYkFEUmJtNVdRRUFnUTZQL3IxdnR3UGt1eVNzdlYw?=
 =?utf-8?B?Q2NtU1dtNEtVM0l5amVxSUJBamdWRm93dGF0RlVrQXF3Y3BheDQvU3FvTHph?=
 =?utf-8?B?WkpOTS95YVZMcXRmRndwKy9CNHNxSTczZS9HSUZNRERCTm9EeGhlRktIK0du?=
 =?utf-8?B?aWQvd3JHMWx0MWhMVkFIQVg0ckoxRXM3Y1ZJZUg5ZUs3SDJ3THN6R1NYdTM3?=
 =?utf-8?B?RHFDZm1ia2xVVDlMb08yUjdDYzg5d09QS0RhVHVDVGhld0JGeFNvc0dUTE93?=
 =?utf-8?B?S1k0UFErb3p3V3NPRExzTFBvSjFidE91VDNSWHpwLzRsQWRLZjVjdENTZDhD?=
 =?utf-8?B?dWdtckQ1azFUREdBUjgrSnpRL1JnS0cxWHd4MTNUV2JVc3JhTnNGZ1hvQzVT?=
 =?utf-8?B?T2tndW1CbnZUZjc4WkdLOE1LLys0QzVaL3BYaHhWRUUzUmo4UUY5ekNQQStL?=
 =?utf-8?Q?Wid2lIPMdrhSePKJerBRwFUiaLV/lw=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO1PR02MB8617.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MElMbTlBWWlUOUlQUkRQTUZJeFFqVjBaU0liWjZERkh4N2l6OUFpL21QVFVv?=
 =?utf-8?B?VW10MFVKUEtMVTg1ZE9KcndvbVNPUzFycG9HNExUdUpvS3pZOHZjWXVwdFVi?=
 =?utf-8?B?Yk1nU3NLTU9aQlhmK1MrNzFXNmYyeVdJMDdhWG56YUVpQlVhbUxUamlsVjBX?=
 =?utf-8?B?R28xWWdIbTRaTUpaNXlZUVdJMGs0enBoWXlCdXR2SHJaemQvUjlsSkJqZUJ3?=
 =?utf-8?B?cFFKV3lmVVlZbFgzOWlHcjJvS052M2xiV1NIbmZ5YStxbXdWSk1FR2s5anZX?=
 =?utf-8?B?Sy9BRCs0enl0TDZxRi9XSlpyaHo4WmZYSFM0Z1E2dnZHc3lCQ0ZRakJxQ1Nj?=
 =?utf-8?B?KzR0a25LUDVIN2Y4QkxUS1lDNWcxN2VrcGhrU0hyL3lhYm1aUmtxN1V5b2p4?=
 =?utf-8?B?amsremowcHZSTmVmYmlFMXBUbDlWSVAxWnF0YkExVWlScytkSVVOM1pmeThQ?=
 =?utf-8?B?b2hsRUs5emdITTFUZVorNXlLQmVPek9IZXRUb0tCNlNEdmcyeXpaQnZPSDY4?=
 =?utf-8?B?cGRBV0lablpFVmZBVXRyckpQVXdaNlFwVGZSNHZWYWpOamlDL05IZFRhTi9Z?=
 =?utf-8?B?OGhnQndEY3BuZjA0RnpCdVd0a1ZOUVNOS3RDa011NlJtTzduWEJKUEEyWTVO?=
 =?utf-8?B?Qm5mV09EbUtqMEY0K3krS3ZDZEcrRTAzR2ExdHlrS3k2SUFseXF1RU15Zko5?=
 =?utf-8?B?eVJTT1FjbmNhRG9yZjRtbWFLYko5OEZ0V0JIajAxeGxKcWRNbzFZOG5XVlhp?=
 =?utf-8?B?VnVySnFLdHhwN2pxdEpVdkNjTzFvQUwzSTIzUnB1bHJ4SFFjUlVvR2Vtems3?=
 =?utf-8?B?YzVVdVgrTm1DY3hFaTE0UGtjaDcyb1VJcXZOTVBFdkZtZHNhU2o2OVBHaFJp?=
 =?utf-8?B?K3JZRTQ0WGk5L0pQMjNIdThrM0l4RWZaalo0NTdwSm8xRWt5VzB3cFdLWDZS?=
 =?utf-8?B?SmdpUnIrdFUrSWJyeldLZWJpa2VKWnpScFI1M1kvMjVaUkFPNDFCR005Q2to?=
 =?utf-8?B?dThLMVkxb1BtUHptYlJ2b0RMOERIaVA3eVZyckpEZG5ld0c1Zi9Zc3pnM2o5?=
 =?utf-8?B?dmY0ZkYxaVhzTVhrRVdTaVZ1aHFla213MmZtblNLSFlYVGdwYU15a1FXZnpY?=
 =?utf-8?B?K003VWt4UWd2aUdGbGVzNFl1Zzk1dkhUNGM0RGx6dHppWUZOM2c2RzNBLzBt?=
 =?utf-8?B?TGIvN0JMSFNTdU9sWUdKTCtnUWJzUUZSMUpPeFFBcDQ1QzZhWEwxZXM1cG5G?=
 =?utf-8?B?dk0xN3Ftc2lGNitZMk5RbWZxcFFIeElsU29abHVlalNybjIzdXJWTmxMV0pO?=
 =?utf-8?B?endLZjNISnhXSk9Rc3Fqb243dmdTTmNsWllNT1UrUWVxTm1TaklxS2VoRjZm?=
 =?utf-8?B?NTJnQUJTRjlaVXh1c0NXcDdQRHpDYWdtSDVNMG82WTI2VkxkTDg5RHU1UVBy?=
 =?utf-8?B?YUgrRnBINWRKZFFmVXFMV3dhcno3YUdkM2pKTjJYK0Z4bFNiZktreXBNN3ZI?=
 =?utf-8?B?czlIcStjdC9GeENDSXBKMDJ3Y3M1L1FpL0VhNHNJL1p1aUIvaVRNZVhZRy9r?=
 =?utf-8?B?Q3Z6OW5DUjJLcXZwV0VHVnZhaFhiYkhaTjQzSFhIR1U3SzU0LzB1cFhwRkNB?=
 =?utf-8?B?cE9pclBFMjlMWGhXRmdhbjRuVFlxZmNwRStNRExvNTJaZ3RheHhBS2J0bXNE?=
 =?utf-8?B?dVV1NzltNUwyZ0doZGVwRVV1WUFCblU1ZHB6OUFsK1NqWmFiK2NMUDJFUDJH?=
 =?utf-8?B?SFRQbkJOWldGaGFvbVA1U3FST2F2MFNlS3BGQVVIblBIcUJ4ZkJicXUyMGtJ?=
 =?utf-8?B?UVhUZ2RzdlBESEpvWTNmMTE2c1JaWEdQVzdBRWptbnpHb0NKMzBnR2txK3V3?=
 =?utf-8?B?UEFqc3FWaVpYOEp6M01YanRTWlhLc2QyeGNvRWVXbTJ6bVZGVFk4ckRLazlU?=
 =?utf-8?B?STk0RWRsWkRIbWk3K3N3ZWxlcVRySm8vOXltc29TRXhzb05ZR00zNVZJSVhz?=
 =?utf-8?B?UjVGYVRpTUQ0NDZnLy82UFljTGc3eU8xOHByeTJSSVdiUERkSndHT3lqM0FM?=
 =?utf-8?B?L0hBSEl6NjNxOUo2T2ZYY2Z5enYyMXQvNG1rcHhicnBpVEd6VU9rMFRGc1Fx?=
 =?utf-8?B?VTRuWU5Qbnh0UnhCYmdVTjdlQ3l0d0liWG9lenc3aWdwVlQ4QUdxbmZVWHhL?=
 =?utf-8?B?YXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <11C8EFB2AC84EE4D9CA5671D4D1F4EEA@namprd02.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: G9a7jX8SQrmawBQKEJH3p4UFLc5ELs66oIaBTQOvfgv7uGq9ng+1lfzXumsjA/p7lOY4cr6zVU67/3EiSbravSqJQJbivDhbCm5raYSJTpqY2wP1EYdpx1ZjvSbkrqLBPYWQXPXYEB5brZ1TAoMeBRIGI+YKQbkQGt4VxXvjGMdWSueJUQ99X59QpWcsFFhpTF/rXKXtWFmC8fEAu1/v7KPse5oQqkhxgwPB8PTBvt5Ml1ndWobhlFtoneywbbg/z7zMYTETLVUnfC2ohNT3wWENezmZ3mkgt82vKBEFhhwfHUWjhp3GY1ZJSE8TKfb7bhBxufTpNfvH2udlsW0ZgW4qu0Iu7WbJtWadZpAI+6ayo56B/wxeA1bbucz2AggZS395oO8qGxmDkIS6QX76Wv0yvtrxiv4gYGOWH+5up+I1/31hrtxwgzSIfFM7+chhbUKOvzbqpWFYOxLB2GBi54n2oohWxw7CPKVt1Qago65qF4OWHaeH38UJG6VKrTJ/voku6iOsj0aDZ7tWXiyvSL+s7r+GKChjYYYuIRZZYCZSp8qQTXHyFKt93VaXvFXkdD8fjA4BXCyKqper6TVgfwcCZCKzUGuBfDay2r7yUsdlIZiMQAmdIcm8rQW9kwSu
X-OriginatorOrg: qti.qualcomm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR02MB8617.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0e378ae-d713-4d2a-0c2c-08ddc54d2e92
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2025 16:15:44.0894 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nFwKlZPjd2OnhCYkBiWRRptUnukWBCtoF1rPU1Pmr6xqSBxkAPoawyuSmF/FiOINjT+SYGJLnN0XmIo1Q4ImqtX+tKBgz6dlYQ5/p5C6gGE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR02MB9668
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE3MDE0MyBTYWx0ZWRfX3iCFItiUDVo0
 r9xOR+RoHU2OX/oif2Lw23zlU0+NhyGJWVMne0FHgkTt2wTLRiJL+3RCJOcpBvdWJFlxv3Yp85Q
 GyQ0CP0kXppkTKK6+yGATG555cfln76/XwQx53ZC36943JH+lRcFD54HopdchAl4H4THF4xzOJX
 ZWoR4KqiYSyy2Yz/IU2glSslLPAPCBWX2uiFCnhwTQDben93rQ/aO+7tVTGcB0S0zQyNJy+i/3v
 M9/6rS7QisEeYFhkTJ/uW243ZNTJVgiL4xEnqY9aOM5Ao3w3YrS2xYKEbwAQTNwYjimC6tdGTUH
 G3PkgawnRQ7z1RJnclkY90Cjp8a3yiq4jZdj1M5lco86Xu5/hT0rT3/qxKR653zScIEv1kXqYvf
 kk3V5y8kVYaY7FtMeSNhMTU4+P8Vnr0U93mVvhrg2K3c3NOyq6psH5YMsdzL1aof6V6I2kVN
X-Proofpoint-GUID: 3EXQyB-UMVXfPWYigt8yuT9PL7OVANY1
X-Authority-Analysis: v=2.4 cv=SZT3duRu c=1 sm=1 tr=0 ts=687921b4 cx=c_pps
 a=VzeH2YOhhDlPZ0WtbyP6yA==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=Re-iBXO3y9Rl39z2ZFQA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 3EXQyB-UMVXfPWYigt8yuT9PL7OVANY1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-17_02,2025-07-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 mlxlogscore=690 mlxscore=0 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 adultscore=0 impostorscore=0 malwarescore=0
 phishscore=0 spamscore=0 suspectscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507170143
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=mburton@qti.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

DQoNCj4gT24gMTcgSnVsIDIwMjUsIGF0IDE4OjEzLCBNYXJjIFp5bmdpZXIgPG1hekBrZXJuZWwu
b3JnPiB3cm90ZToNCj4gDQo+IFdBUk5JTkc6IFRoaXMgZW1haWwgb3JpZ2luYXRlZCBmcm9tIG91
dHNpZGUgb2YgUXVhbGNvbW0uIFBsZWFzZSBiZSB3YXJ5IG9mIGFueSBsaW5rcyBvciBhdHRhY2ht
ZW50cywgYW5kIGRvIG5vdCBlbmFibGUgbWFjcm9zLg0KPiANCj4gT24gVGh1LCAxNyBKdWwgMjAy
NSAxNjo0NTozNyArMDEwMCwNCj4gTWFyayBCdXJ0b24gPG1idXJ0b25AcXRpLnF1YWxjb21tLmNv
bT4gd3JvdGU6DQo+PiANCj4+IFNvIGxvbmcgYXMgd2UgY2FuIGFsc28gc3dpdGNoIHRvIHRoZSBl
bXVsYXRlZCBHSUMgd2hlbiB3ZSB3YW50L25lZWQNCj4+IHRvIDotKSAobG9va2luZyBhdCB5b3Ug
S1ZNIDotKSkNCj4gDQo+IEtWTSByZWFsbHkgZG9lc24ndCBuZWVkIHN1Y2ggYSBub24tZmVhdHVy
ZS4gU3BlY2lhbGx5IGFzIGl0IGNhbm5vdCBiZQ0KPiBpbXBsZW1lbnRlZCB3aXRob3V0IGFuIGFj
dHVhbCBHSUN2MyBpbiBIVywgZm9yIG9idmlvdXMgcmVhc29ucy4NCj4gDQo+IE15IG5vdC1zby1z
ZWNyZXQgcGxhbiBpcyB0byBldmVudHVhbGx5IGRlcHJlY2F0ZSB0aGUgdXNlcnNwYWNlDQo+IGlu
dGVyZmFjZSBhbnl3YXksIGFzIGl0IGhhcyBiZWVuIGJpdHJvdHRpbmcgZm9yIHF1aXRlIHNvbWUg
dGltZSwgYW5kDQo+IGNhbiBiZSByZXBsYWNlZCB3aXRoIGFuIGluLWtlcm5lbCBHSUN2MiBlbXVs
YXRpb24uDQo+IA0KPiBCdXQgdGhpcyBpcyBnZXR0aW5nIG1ham9ybHkgb2ZmLXRvcGljIGluIHRo
aXMgdGhyZWFkLi4uDQoNCg0KRGlmZmVyZW50IHVzZSBjYXNlLCBidXQgeWVzLCBJIGFncmVlIHRo
ZSB1c2VyIHNwYWNlIGludGVyZmFjZSBpbnRlcmZhY2UgaXMgYW4gaXNzdWXigKYuDQoNCkNoZWVy
cw0KTWFyay4NCg0KPiANCj4gICAgICAgIE0uDQo+IA0KPiAtLQ0KPiBXaXRob3V0IGRldmlhdGlv
biBmcm9tIHRoZSBub3JtLCBwcm9ncmVzcyBpcyBub3QgcG9zc2libGUuDQoNCg==

