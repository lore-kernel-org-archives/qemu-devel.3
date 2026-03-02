Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B537EB362C
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 18:40:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vx8BC-0002yN-CP; Mon, 02 Mar 2026 13:39:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rkrcmar@qti.qualcomm.com>)
 id 1vx7q3-0006Me-RU; Mon, 02 Mar 2026 13:17:51 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rkrcmar@qti.qualcomm.com>)
 id 1vx7q0-000897-S1; Mon, 02 Mar 2026 13:17:50 -0500
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 622B3eG23862850; Mon, 2 Mar 2026 18:17:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-id:content-transfer-encoding:content-type:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 qcppdkim1; bh=ifEba+GhGpAYfpxr+M3y9swaTsfGZIbOFW5b0QYMD7Q=; b=nN
 lvK0Po5tAe4MtFsbYiIPKtiC4EDXKTEZJypAPbz+9G0JMVg4w+1wqcL52lMrsz7N
 sQPYEYMYy7eXvtcRphmsdnN8+xJjiKXaDcV9v2hpBhgdxjza4TwAjjP61LtpRwdg
 B7Njy2UD5SoEKkQNHybsQu1EjgqClUVfOlj+NyzmQEsVwx24XvrFJ/A2gz/+CdqA
 yXuIpFYtRvEGxqzXosW5LE2mhA/ici6qLmech3ZZN3j2JIrIX7YZ6wFyBd+DDqDJ
 sJAON7I0zJqenqvcuxON6IPTB/NHx16nzCsm4GXucOstqEVMDoEzVqJ2kEd+Q+NA
 UQFzgxYTr/NCKudL3qXA==
Received: from sj0pr08cu001.outbound.protection.outlook.com
 (mail-sj0pr08cu00102.outbound.protection.outlook.com [40.93.1.74])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cn9bjhfak-2
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 02 Mar 2026 18:17:18 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IgDImcAs2Xo8NDcoCkE1n+cg53e7eHnp/AZf10IaY+uy4hyMx7x9VTzYoOZ071YbL61AFOcRblUdaHxbbCqAAwnYX2cfAsG32HSVssdx2DUb5NbBrjtYu0peHV53eX4xDHe2cvolxL16OSqEhEnAmEksHU3nnhFFbH7/GO8Yrneo7tXMtZi7Mq2eBrTcbarmYvb7593oVqpfdtD3M87uZs8qmYJbkKTwH203UqIzovaWzaEg4suNDH4lNLnSpBk5aGiyJv0gi/8Seg4d0rHiBGrjY1pNJtxU2PfgVfkbZAbaUHQiVO7xjwbnmuNL9pkBrDeIwxyMDsBUykz1aFfS8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ifEba+GhGpAYfpxr+M3y9swaTsfGZIbOFW5b0QYMD7Q=;
 b=vSkHAwAvvaeNGdlRFjnbKm7B1rznNu4ct2bt8Lrw8QyVFk0P2C/kIpgDGV3IA/xekY+va+qRSNtnPB5EKs1UtN/TdXwIbChmyoEYLF1wUqy4QEwB6BmG8njMTay5eQhmJaYFEWmmW/XWHXJCugA4LCe3ontjCj214K8osAYeBF/pl48qHUnPb21DdTU9/oN5UOswl/QJJLCuXG0awiMdqLStCp2JIPsb2IkiT3A/phjsvD2bVIIOwzkbGsbv1e4wdhZBWXvK3K44VOCtaDfWyB6M7KyODNfT5m5LO6ItAJIw54aI1FTy8Onsc57iJ3hXb8UIVkVqbkWJtRBUM+C4OA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=qti.qualcomm.com; dmarc=pass action=none
 header.from=qti.qualcomm.com; dkim=pass header.d=qti.qualcomm.com; arc=none
Received: from BL0PR02MB4435.namprd02.prod.outlook.com (2603:10b6:208:4a::23)
 by BN0PR02MB8301.namprd02.prod.outlook.com (2603:10b6:408:158::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.21; Mon, 2 Mar
 2026 18:17:15 +0000
Received: from BL0PR02MB4435.namprd02.prod.outlook.com
 ([fe80::5818:27e:c1c8:7aa0]) by BL0PR02MB4435.namprd02.prod.outlook.com
 ([fe80::5818:27e:c1c8:7aa0%4]) with mapi id 15.20.9654.020; Mon, 2 Mar 2026
 18:17:14 +0000
From: Radim Krcmar <rkrcmar@qti.qualcomm.com>
To: Drew Fustini <fustini@kernel.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, Palmer Dabbelt
 <palmer@dabbelt.com>, Alistair Francis <Alistair.Francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>, "dbarboza@ventanamicro.com"
 <dbarboza@ventanamicro.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Nicolas Pitre <npitre@baylibre.com>,
 =?utf-8?B?S29ybmVsIER1bMSZYmE=?= <mindal@semihalf.com>, Atish Kumar Patra
 <atishp@rivosinc.com>, Atish Patra <atish.patra@linux.dev>, Vasudevan
 Srinivasan <vasu@rivosinc.com>, "rkrcmar@ventanamicro.com"
 <rkrcmar@ventanamicro.com>, yunhui cui <cuiyunhui@bytedance.com>, Chen Pei
 <cp0613@linux.alibaba.com>, "guo.wenjia23@zte.com.cn"
 <guo.wenjia23@zte.com.cn>, "liu.qingtao2@zte.com.cn"
 <liu.qingtao2@zte.com.cn>,
 "qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Subject: Re: [PATCH v5 2/6] hw/riscv: define capabilities of CBQRI controllers
Thread-Topic: [PATCH v5 2/6] hw/riscv: define capabilities of CBQRI controllers
Thread-Index: AQHcqnDLxWF46f2NyUy00F8KRlazvg==
Date: Mon, 2 Mar 2026 18:17:14 +0000
Message-ID: <DGSI3PC0N9OO.NV1W4DTKW4C2@qti.qualcomm.com>
References: <20260201-riscv-ssqosid-cbqri-v5-0-273ea4a21703@kernel.org>
 <20260201-riscv-ssqosid-cbqri-v5-2-273ea4a21703@kernel.org>
In-Reply-To: <20260201-riscv-ssqosid-cbqri-v5-2-273ea4a21703@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL0PR02MB4435:EE_|BN0PR02MB8301:EE_
x-ms-office365-filtering-correlation-id: 96990548-dea0-4f75-b601-08de7887ee71
x-ld-processed: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|1800799024|376014|366016|38070700021; 
x-microsoft-antispam-message-info: jcDGny3Lqb85CuawisDiJIEtRLQe3ItipzdyXNMpeD/RMHAfhpURDowEKDkqKqr86mHy+xaSFMlzetpvGOnHx0uGo7WN0uMIhwffyxZUEMzsjTjKrO9iRA3fkBotXqDJsBO5omcI4yo5SfFRvnak9bGQGoJflKXiMoG2sJnR3JVRTDbyWyXEMQ+x+jdqpMs/bPSuewcNUNir6XcR7kZoQWqJc1URdbAwG93EpN5RzyqeJybwos+hxiK2zRboLkFe22bmejXR3ffrrzFXEx0mPUBzh/MKDRXPgP0UDHvu6Zho0+vST5scM4WtIynztrhbqDkC0XeeB68205/tynMcbM3+D4FdHrbdDB4f9lpr6BChPrYr4gwGriQ1q1r7QlDXcBXfybPecu5zhPq8q6hNxiRlllIPIAZgTfeJWoXOlA385PxY37BdatMtsG3l9egmQT7xRHIxb69ULURKG1+sBRh2HJ+3RCwYOMlPejRLREF3hJMY1JKgK5WDVlTtp5fGvtIAhQj8bI2UBvKzDKBVe64DhSqTYufy/dRoQqyCU5p8x/7Xz3zqSYJCA1uT5LIg/hOUKGlYCEmoRcgAK4zZEpheNLEu0Om5iseiWJUPe+2KgW9WKK8/oTEHvHd0A4/NXuOn99eUSTCXGoPeNYrO0QgGj8HNSVkTaJ/hiA6HEyYdI97kRL/8X3pIHxljUvaPdEPvCFEb8lE9xviUHCxmXl284JN8RQlZuJGwn6ha2hpncxK7acZ/4hRqRODn5GwO0elX4SNJcLx9bFVqgVgivJQom1SAODed2K1g9zFxRXI=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR02MB4435.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(1800799024)(376014)(366016)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Q21DM3VxdlZ5N25CQjZiQjA5ZmpKaFdnM0lxdGttRzhMU1JKa0hnZkpBRHdh?=
 =?utf-8?B?VjhwaDNHSGxXWHcyV1daQU9PYWdGZjYwVzNyUlo1d01vUVdZSlYzS3JSeStX?=
 =?utf-8?B?THZ6UzN4c2N0SFpUdFN6K2YvOEg3dlFRLy9INGorTFM2ZDEvcmZvNCtDK1Nr?=
 =?utf-8?B?RFoxZkNQN2kxakNNTXhuUzMzZExodWtFMTlpQnA2SXI3OGNPZnd4bzVpK09S?=
 =?utf-8?B?S0x2aTNEYVNvSlZqY0pEbldacW00SG5taCtNOVRmK2owQUZWQWxJcFY5TTdJ?=
 =?utf-8?B?Ym9EMks1RmtNdWZtaDZDNlZya1pmYnlzMjFYRVBhb1BrZUpkOHBwSXBHNmhn?=
 =?utf-8?B?YUVGZTZ1UWg2NzBDM0MyL2VCbFhIMnFYaEY0bTZ2TEZDV2RUOWZkRDdMblRt?=
 =?utf-8?B?dFlnS1ByRmEvTkhRSFp3WHFxd20yWmxGZHMrVkRuM3ZtdHA4cDZpSWdsQzI2?=
 =?utf-8?B?WmE5SUhoZzlBNkI1RTZGanE1djNEUkhsZ2pjQVc3OGVtZW96LzllYmtmUmdH?=
 =?utf-8?B?Z042RkU0OU81VSt2VUxsRm53RXAvenA3SFd4YjNCY0hFVHJnRFhjamFjY25R?=
 =?utf-8?B?SVpXQWppRy9OM0E1YnZmeFVOYkZjUjdhZW8vTG1tQ3ZOTWtISk1Vckg1L3Qv?=
 =?utf-8?B?M1Z1dVNMYnpNNUUvVnhjaEJycHYwOVQ2WGtrME9nMHpCeXV4ajB2M252RUNl?=
 =?utf-8?B?cCtPb280UlFvYTBJZmN4NTJRaTgvMlV6QnJkQ2JoUGUvL3Z4OURmQW00WmEw?=
 =?utf-8?B?R3Z1RXlnUHppSjk4WGVsM3VDYWx5U1R3R3BPVlN2bGVPNDhMeGRLWnh0M0ZR?=
 =?utf-8?B?QlhLdjZGaUs2YzQ0R0FubmNWN2ZoQWpOWDNkRFl3andwYTd3QjZYSHhvcng3?=
 =?utf-8?B?ck1HNkRqcVU1bUY1bzl5SCtRaFRTUjVIdlI2K0tjMmthazlIckVVZFF5c3pl?=
 =?utf-8?B?Y3ByV0w1cXpOcUl5bFluanlMQW5lK0NwTDRUMFlvaVJiMjErTGdRZlAydkc0?=
 =?utf-8?B?RHgzb0pkczVOTkQvcTI2b0c0SFVmdW9YbkpIZlV2bktXN2RTc3ZiWi9iNGpH?=
 =?utf-8?B?eEVFcDNSaE1pWUJuR0d4czZKVnNrd0gwYktzeWZYWHJaN0kyM09kWXVmZjBj?=
 =?utf-8?B?cHZYVDhQQVFsa1pnODdFZ1ZncXR0eUg5ckdpcVF4dkRGVmZ4d2c0dHFSWWk4?=
 =?utf-8?B?NEdjcHRmTEFBN3A1MDE3aVJmeUdYMHR1RUZVbFdmbktPeEFHUm5OVmtObGhB?=
 =?utf-8?B?cGNCcW83RmpqTFdIMzVPbW0yM3JiMFN3TW1kdjZWWGk0Wlp4SzNIYVZPbDRh?=
 =?utf-8?B?VUNrTFowZnJhbSt5RFVXUVFwNCtGazBXZlBrVEU5N0JuQllwLzNjYkxhcFFi?=
 =?utf-8?B?L0FQbHhEMXpPeENHcVJEQTl0UWxiTW5nY0k5K0poazhxaVJ1QkdWWERMa1pJ?=
 =?utf-8?B?ZHdtTGdQK2N2OEVyK2lrUlc2Z1o4cGdnYlVkaUlXakVyQVgyaVVpZi9SOGg4?=
 =?utf-8?B?M212dkorNmQwZXVvVWJ0emJIQmFnS2UveWp3aXBaNXBrOW44bGhvZG9mZG4x?=
 =?utf-8?B?UjEyMFpzLzNOMndSWitxTG5MUmJucmhweng3M3MraGU4NFphM1ErUHVNTmxE?=
 =?utf-8?B?V1JrVDBsTWYwNDgwQzlzS2hoVThXRWFOMEdpb3RZZG5qcmwyakhTWG9RbmpE?=
 =?utf-8?B?ZmRjc0JsZWRFcDFHRkxTaitQVVoybUpLS2s1ZXFsQWhYTFg0RmtLV0FhQmlE?=
 =?utf-8?B?cThkTUJtVEhpeTZnUndOa0djbVE4VktBdFo1bkFVd3c3NWFUZUZTSW5Rdi9i?=
 =?utf-8?B?OStuTTVzS3lldTV4Y0pxZTlPOUhJek1OWGEya2pxVFRSOUtNRHRvU3hIcG0v?=
 =?utf-8?B?UDI1VWozMUdjaVdnUzBjek16UkNSZWtIVWNDY016aFNXUDN4UkdSR3NTMXdN?=
 =?utf-8?B?Um9hdGdhUG5uRDhXK256NjB5Sk45cVhnRVdmbHk3YTB4cGpkcGNyenlmN1lz?=
 =?utf-8?B?dkZKZ05GOGhOcXZUblFBbDJhekVXQldneFQrUWFOaERPUkZkTkJKVzEvc0Vr?=
 =?utf-8?B?b2toL1pzY2RvN3VqTXZScXloMHU4dXdjeVN4dW0rQXltMDdLZDJNVkI4UThz?=
 =?utf-8?B?Mk10MUNXSjdOUUpjRkttYkZ5N3JsL1hTRzBPOHZtMTVRZkZwbTlHUDlIbHEv?=
 =?utf-8?B?U1NuZnpNdGhnMG82NVVDeGh2ZDRSU3NXL1UyaHhVTS9jY3kvRkwzWDFVY05C?=
 =?utf-8?B?WnFXV1hSYWZSNHdVc1RPT3hLS0U5ZC9FOFl6ZS90T056THJWRG9lQU5NYlhl?=
 =?utf-8?B?V2owS3I4Qit4SDU2NEFieFMvSjEwbnNSWHlzM1c2dmZNZ241TjI3b3lIdFVx?=
 =?utf-8?Q?MbZukeVdAHVCUUMg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <97339E3C00D3A74EAD5986E1300338A6@namprd02.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: QBChzpzY1Fn8udDdGPqPS/gHSA4uVT5ibBgKY4z6z9YnQNuIROU/o12Rqymycf53sozJKIHWS2gErnRP1rguPbZQ9VZdXos7IwyRGEGXwLMvMZMiRH92iJYUyZ3W/ZWXJjECqb1Fn5QKzdqLgPcYb0RuD3I7b9b+oU7HktvaRmTDKz9dl1ptSkY3ZgTGk8OZTSqXdnyRSanNRxWsJJmXmdZQ4LqLOXthgeY2TGcBj38hqPxgYg6HcTWvto9RDK+di/ccFfmpTzgO3pC7zscyQ8EHYqDAari9XQfzHob2ZHoH454ln6UCXW7gnCsgqcmEnXQf069kwzHClm+2Tn+2wPJFOJXqu4lnPoXaS4IfItxVxc7uNkUdZQGRt6HKTIh9zuhH1tIylPG9g94OFwUpfH6mL7wkn80RtryVaTVLbNZ7yvACYpDEZAHtlTf9Kyv7+bdYH62XnB3MGX0VXgewb+U/keQW0X/RBL3JdVLWQYUKEK0SrN3nTzZnHE4q1DsteBGRbmcSBkXDtyZS3P3p5/v7YDPJtKuJEMuzSVlt0gzjM6961sKle/ekuoh73Svl96i2zU8ZYwH0Z93cU7sLrbPDiz1kLUhqJHGbJkVMtFMtjvsBi2VMgnNKqTGLCs5o
X-OriginatorOrg: qti.qualcomm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR02MB4435.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96990548-dea0-4f75-b601-08de7887ee71
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Mar 2026 18:17:14.9468 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AZFcfimonN+P7LCktVVzmu4xKPZUjltgRlgbCt01GWYS0medPQrMcROmXiC1x6WATYOiYgWnQi3BHCxEKemdlP0d2gQZRUvWTvs/rFFyX40=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR02MB8301
X-Authority-Analysis: v=2.4 cv=Pe7yRyhd c=1 sm=1 tr=0 ts=69a5d42e cx=c_pps
 a=i5O+0KHWwz6AHTILDS7dZA==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=f7IdgyKtn90A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=V1jnuoLLAAAA:20
 a=VwQbUJbxAAAA:8 a=IpJZQVW2AAAA:8 a=bDdBU3oEAAAA:8 a=EUspDBNiAAAA:8
 a=sIBLlZgNAvny2aHwhmQA:9 a=QEXdDO2ut3YA:10 a=IawgGOuG5U0WyFbmm1f5:22
 a=DN7SgORnOiO7RqxRx1GC:22 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-ORIG-GUID: mHRkWF3A4kMfqsvtISfl5_E7vN3JkVr4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAyMDE0NSBTYWx0ZWRfX/pimrXnkp20q
 iLfKFQ5DvaqL5j5OAtOrObvs7aSdmtfc5HkYjf7ecGLonVcad9+mkFmtzdXKIOxuxMG7H2LK1eJ
 cl8VNnCrrjRIb3G0XVE+EjWfCX7PPLuSoR2TKMY7Rg3sOkLq4RUjMy6T+YqmhbVSNyctrliz+LB
 /yjbYggVz0bqmnH/z4kgbL0wADseNRgY1q9/UmzY5/G4Jtus7Q+emvIJ27jhOu7fUB7+3zVN79S
 CQ6Gn1TmyyA3nlnmbkRcbq+emouUHsKiMaxcCBX77r10ZAgyNsWMEKZV31yLRwzTp3VQH1GazRv
 AhDAKmfSH4XM/6AHnhO10tCc+46cArB03fMQemXpsG/jZDAw3+VnS14VIRC0pWDVJMdKglTgIpG
 vsR2VSvz03i/MkivK4JhTRRjyt94cqeb11CXoF9ayvt3QKOpki9oDA3AwDVXtntpHG9KmoJ2snx
 QNuiDeckcQd5wpeRPPg==
X-Proofpoint-GUID: mHRkWF3A4kMfqsvtISfl5_E7vN3JkVr4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-02_04,2026-03-02_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 impostorscore=0 priorityscore=1501 spamscore=0
 adultscore=0 bulkscore=0 lowpriorityscore=0 phishscore=0 clxscore=1011
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603020145
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=rkrcmar@qti.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, HK_RANDOM_ENVFROM=0.999, HK_RANDOM_FROM=0.999,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.968,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.495, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 02 Mar 2026 13:39:39 -0500
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

MjAyNi0wMi0wMVQxNTo1ODowOC0wODowMCwgRHJldyBGdXN0aW5pIDxmdXN0aW5pQGtlcm5lbC5v
cmc+Og0KPiBGcm9tOiBOaWNvbGFzIFBpdHJlIDxucGl0cmVAYmF5bGlicmUuY29tPg0KPg0KPiBE
ZWZpbmUgc3RydWN0cyB0byByZXByZXNlbnQgdGhlIGhhcmR3YXJlIGNhcGFiaWxpdGllcyBvZiBj
YXBhY2l0eSBhbmQNCj4gYmFuZHdpZHRoIGNvbnRyb2xsZXJzIGFjY29yZGluZyB0byB0aGUgUklT
Qy1WIENhcGFjaXR5IGFuZCBCYW5kd2lkdGggUW9TDQo+IFJlZ2lzdGVyIEludGVyZmFjZSAoQ0JR
UkkpLg0KPg0KPiBMaW5rOiBodHRwczovL2dpdGh1Yi5jb20vcmlzY3Ytbm9uLWlzYS9yaXNjdi1j
YnFyaS9yZWxlYXNlcy90YWcvdjEuMA0KPiBTaWduZWQtb2ZmLWJ5OiBOaWNvbGFzIFBpdHJlIDxu
cGl0cmVAYmF5bGlicmUuY29tPg0KPiBSZXZpZXdlZC1ieTogRGFuaWVsIEhlbnJpcXVlIEJhcmJv
emEgPGRiYXJib3phQHZlbnRhbmFtaWNyby5jb20+DQo+IFNpZ25lZC1vZmYtYnk6IERyZXcgRnVz
dGluaSA8ZnVzdGluaUBrZXJuZWwub3JnPg0KPiAtLS0NCj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUv
aHcvcmlzY3YvY2JxcmkuaCBiL2luY2x1ZGUvaHcvcmlzY3YvY2JxcmkuaA0KPlsuLi5dDQo+ICsj
ZGVmaW5lIFJJU0NWX0NCUVJJX1ZFUlNJT05fTUFKT1IgICAwDQo+ICsjZGVmaW5lIFJJU0NWX0NC
UVJJX1ZFUlNJT05fTUlOT1IgICAxDQoNCkkgdGhlIHNlcmllcyBhY3R1YWxseSBpbXBsZW1lbnRz
IDEuMCwgaW5zdGVhZCBvZiAwLjEuDQoNCldpdGggdGhhdCwNCg0KUmV2aWV3ZWQtYnk6IFJhZGlt
IEtyxI1tw6HFmSA8cmFkaW0ua3JjbWFyQG9zcy5xdWFsY29tbS5jb20+

