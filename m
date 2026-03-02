Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5BECEB362E
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 18:46:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vx8H3-0006FF-O3; Mon, 02 Mar 2026 13:45:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rkrcmar@qti.qualcomm.com>)
 id 1vx8Gu-0006Bv-Tk; Mon, 02 Mar 2026 13:45:43 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rkrcmar@qti.qualcomm.com>)
 id 1vx8Gs-0003vb-A5; Mon, 02 Mar 2026 13:45:36 -0500
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 622Elohl2048839; Mon, 2 Mar 2026 18:45:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-id:content-transfer-encoding:content-type:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 qcppdkim1; bh=1GS1imtG77IPT0i980SkS+KqCLokzZvzX/c9wU75/K0=; b=h0
 vIFyKgaXbFKEaTxickD6MMYML28Ujggt86hlLKOdNWqfsxCc8TqAjXHddRtvv3YW
 qdWE+KXCFoFlA8Pil4O+LdANJN4acOrd0Tz5JK2waWzc3lYpRPc7AO91TOebY/55
 LC9+8qQTfcE1oMGGHhu3b5eOGKEiI0rHi/pZ+XNH3IBLgKQIfoSNWWeNUpI8f3qB
 8XDKgj7uvTEQLuGW8IMG1mruPLCsyT35ITK+Y4PCYVoqhTnUN9nago4taPtIL+lm
 GBjlTxjyv8uN05bwcvsPHH5+aQlLJ4C1y+1qKuliYTm1v8vt9H88y9nZWmHCQAGa
 BnCvKVnWoeix4s+1fD9Q==
Received: from dm2pr04cu003.outbound.protection.outlook.com
 (mail-dm2pr04cu00300.outbound.protection.outlook.com [40.93.13.56])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cncmfrva1-2
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 02 Mar 2026 18:45:03 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rruJzV/cc8RI3qrg1gtMQrEYuzd6jTiS/R3l+1VwiaFP6Qd2dIXmToy+S9nFTdUf/L7B4gucC7rMm/3Q+3ExzOQX3R046ZRgAWI/vrYMsfY5HCuBkJHDPTmplmLwxxpvZ8G6PSDmCh8eNwdgF/3zpCniu7WbQRO7GEJXACJJENK1OaIXrGZiJJktrBEi4QXSMGNjVJhJnvQDeTyN4MQursjYMrPfLyVFfdnft+FcFxuQWYV5p6ewqlDL8xw5/lKrRQ1dlWxMsD5RZsMkzjc8T5XoluIABjlsMwQ+DXUXpFmpnqX5xys4IgBAw4qMU594jJ0eDCpKIaxMBI6H76oo6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1GS1imtG77IPT0i980SkS+KqCLokzZvzX/c9wU75/K0=;
 b=LrGa0U23MqCM2PfnfySqhYZcbz+gqhrQVtc7Sh07SVLti6gWyiVn3IXNiFIv8mpGGYsYfNKBopM/OeNvBTxnfdRY7HAEtn0Z9qsKNl/5ZRioNL+kjp0p7DiGOthqMbpC25uYs2TAxl1XGaZXvczsmtvcFtgIuRPVhZvt97g91zKoDEK7SOWvfq7LxfIkuaYMtcgC40+hsOqTQFqtn2Tvq2ix3RpoSf6AqqNqGocbU+tuUFaHVuSs16zZivB6rQao6D/cADsDYYztcV0Rp43nMkcFx7L4OfHQ4HIVIuEtCgTJ2mGw22J8BtZ4X9ynMIJeHy6AXuZDBfb95d6hxC+7Dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=qti.qualcomm.com; dmarc=pass action=none
 header.from=qti.qualcomm.com; dkim=pass header.d=qti.qualcomm.com; arc=none
Received: from BL0PR02MB4435.namprd02.prod.outlook.com (2603:10b6:208:4a::23)
 by CO6PR02MB8754.namprd02.prod.outlook.com (2603:10b6:303:136::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.16; Mon, 2 Mar
 2026 18:44:59 +0000
Received: from BL0PR02MB4435.namprd02.prod.outlook.com
 ([fe80::5818:27e:c1c8:7aa0]) by BL0PR02MB4435.namprd02.prod.outlook.com
 ([fe80::5818:27e:c1c8:7aa0%4]) with mapi id 15.20.9654.020; Mon, 2 Mar 2026
 18:44:59 +0000
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
Subject: Re: [PATCH v5 3/6] hw/riscv: implement CBQRI capacity controller
Thread-Topic: [PATCH v5 3/6] hw/riscv: implement CBQRI capacity controller
Thread-Index: AQHcqnSsp90lObnLuUaaM+gj3qrWTg==
Date: Mon, 2 Mar 2026 18:44:59 +0000
Message-ID: <DGSIOY06X4A5.1HW34JPQV2IGB@qti.qualcomm.com>
References: <20260201-riscv-ssqosid-cbqri-v5-0-273ea4a21703@kernel.org>
 <20260201-riscv-ssqosid-cbqri-v5-3-273ea4a21703@kernel.org>
In-Reply-To: <20260201-riscv-ssqosid-cbqri-v5-3-273ea4a21703@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL0PR02MB4435:EE_|CO6PR02MB8754:EE_
x-ms-office365-filtering-correlation-id: 2327a230-ee12-47a9-499c-08de788bce97
x-ld-processed: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|376014|1800799024|366016|38070700021; 
x-microsoft-antispam-message-info: 3FR8B0cvLSI/YqC4HafAb4fhbQUg0ieugiyqlrKlm7Vh/dBYDYgeZVysp2KQriRRxFKt8OOuXQujOjsz7HG1PWYXUPh9q1ZXEOumR0Xu39JzkAHZUBvBYOIJF4KdIzDrbnpE1XIa7hJaiYMxN+79FBwAKuvL2UCIKNXCslKM+Atbhk51j8TkqpUBEdln2+QZ4JABC6fW6pUblapBmaBWjBWQl6tLyWVxhesW/RSSdKV7Y3D8RgiUmz2CTe/ZfzZjt4bp8I8kNf62UjW46kNJvc+GIHmcSkiL/eM7HJbNpt3xMvBX64j0hRPv8+xkI4JX9aGxJjJlpS05WpUfTgvEdWyDKdjjjwcqd9ei6y46q/wSwY55sP+Fr11kBsNoX03YfFP7YTxyY8P2Tkoj47lgAuJwznPJ+s8mt4c79Xg+S38kSyaQxV47U+TUAMmkF9nu0W6vH4T4i8lXAGF8zMyP0DIyHhaepUqluYqlKW9mCLRx73fWsm1BRWzw0BnJDqnPnIigHq4lqY13r6gmWokIOWGuq2S5PXXJ0vy+2DxgpHYSFEm0mQj2AeorNr698/VKxuZ1hBqlumSdM6PnTsrfxow8f2ypUiIH9pXtnXmwWG3ogwkRTiKulZRwuNinIUtTTMquEeCJTl4V5Rg1lobfewB202y9H8EhzENyRo+FcGFcBpUjaOfyWVUXPQa2e2WhK5PbLVg9RYBxk08nFZHwfKLFCbS7+I7BJEphbrZX6hQ3BPWsorQO+Oim8q520k83Ay/B2BmUT1M5+/6CTaVlvKYGEVX1TxEQQOXyhOp4Dp0=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR02MB4435.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cTllazNVRTdHbHBzMzlMTlFMWXBtazc4eTJIOTZxVVp3Mzkxbi9sa0c0K05R?=
 =?utf-8?B?MG0vamlyVXlOUi9LQXpNSjB4Rmh0SnNnZzZmb0VKT3FWTnY4UW1sajY1bFlR?=
 =?utf-8?B?NjFPak1MZXRIM0VoK0Vxd1lGTDg5K3VzM0JQOC8wUmQ0Wjllb2JQcUhxM0Z3?=
 =?utf-8?B?Z0dtNGRRdFVkNG9jdnFXZXRReTREbmtuV3B2dFNlM01TR1U0U250UFl1RVpF?=
 =?utf-8?B?K0kyTjBmdGNrNTFVK04xdjN3ZGRSeVlXL0EreTlROHVUNUhBYWxqeHVmY3FP?=
 =?utf-8?B?NzFWL0dxeGowenRrWm5xN0gzalJtWWtaWmxFK3VvdDNPQUQ5UVBackw4dmt3?=
 =?utf-8?B?ZXJHak5tSm9qZ01MVUxqNkVWVUcrdDlEa1gvb0JkZlk0bmRPRzAxck5BRmlO?=
 =?utf-8?B?WHBrc3NENVdtTytRWFJtTk50M2pUSTNiZ2srY2NET3VKMkZxaDZnVkVtdERQ?=
 =?utf-8?B?SzdqcGV3a0VaaFhLR2J5dkViV2VWdzBPVTZkdU1ZVjNPaTRVRjFjU2hjVWdh?=
 =?utf-8?B?SUxTTjVldTBIbW9ldjhCSFBKOXVCNVIvSEdvVmNRR2diSVMxYzJKdVVCeFFk?=
 =?utf-8?B?VkVmcDhLbUN4UVdPYTRzS0ZMamFWVU9pTjE3ejhZeklqdjEvQitEbDl5Tzdw?=
 =?utf-8?B?ZTFuTWdCZjNBcHJSRzJBVTlwS0V3MC9Ib2JNOWh3L0o5cnJuTHJaRHNVZXFD?=
 =?utf-8?B?T0d6SUwrcmM2dWFyMHBHeXo2bTR0dTRnRm8rMGxwc3VsM1Z5TTlwMFIvNHpu?=
 =?utf-8?B?Q1p0QXRHakRwdVBUSWYxVVVVMWVPZFc3ZmFiK0toU21ERXRUWVVQMGJtUWtp?=
 =?utf-8?B?WXhmeml2N1BKanp0L3N2NHR1MGRFcHdUeXZMNm4rcHZVZWNWTHBXbXE3UXg4?=
 =?utf-8?B?SFA5MXNVQVZNYXRVbWVqdW41bzlEWEpUR2tMS0tLZ09KVHArYStYNlRHN01h?=
 =?utf-8?B?M2tjVEJOTlp0SDNTdi9OSzZvNWF5dzB4VEZDMTZ2WE5aczVOaGpMb0VzNWdY?=
 =?utf-8?B?OVZQdTRWaCt1ZnFLMHVXN2Q2L1hiNHpjNlRSTmNUa3MrdkhXN1A4SExoamdp?=
 =?utf-8?B?VkdyaCt6TFppSjAybmlidEVoRDBMU1h3eUtrNFc2S3ozK1NMblUrMVBWRWYw?=
 =?utf-8?B?RFM5Z0RwYWpDZGFXZzJUd2xqZEMrTUx0Wk1pbyt0NXZVUFU3MTNyRFdVQ1F1?=
 =?utf-8?B?TzlTVVF1dzdQWHZYa2t0c3RpZGZpL0tnR0lZVXBGV25wQ2ZmbkZld0c3ZkFM?=
 =?utf-8?B?c2YvcUQ2OXQrUEFweDFxZ2FXQlFlZXlTVnMrV29oNUNBR05GNDZUMTQ3WWtG?=
 =?utf-8?B?b2NTUWVXcUNhWmtVVUtLWHo3dmVlM01sR1dUTi9YTUlBV0h3WU1PWWxwV1Z3?=
 =?utf-8?B?SThSNmVoQUw5cDl2ZE9tYmtDS0pLcXBGZWtVcmt2WFpqMWxBaHg1S25HcTlk?=
 =?utf-8?B?RHBDWmtBMmlBNjVsdHdaQ3BzL2xjUkRPSHUrU012K0Z0MW1Vd3RncWU0Rlho?=
 =?utf-8?B?Q052Zm9qQmU4QkhvZ1ByU3M1elRieFRMS0kvQThCUEs5Nm5kNHk4ODFQc05S?=
 =?utf-8?B?TUdBZElQTUZ2c09STXErMFE3SlRXSGdTYjJqQk1qc21zNENzUzI5QjVENGpi?=
 =?utf-8?B?UG5vTTdnT2N3WHQ4YTVMRjc4M3Y3RFZSL24rdk9EV241ZGFLSGc3aEQraGVp?=
 =?utf-8?B?bWRhSW9jaE1ub2QzOHVLaHRiUURQOHNUNUE1a3FzQmd6ZXlONUpJdkU2WjNl?=
 =?utf-8?B?aUdpakE2WFdhNjNVTFRhbFJjMjVKZm9vLzJuTzkzcXhuTUM5aFRLbk4xOS8w?=
 =?utf-8?B?SUVVeDZtcEhhYmVYckEzSGlwVkROZHFCb0ZtSHY1UGFJbitDcG5Odno5OHNy?=
 =?utf-8?B?Skc5Qlh5Y3hXbEx2N1Fzc3EreG1VY1NOdTJ2cmVwUXovYXE5ZHVkS2VqdEYz?=
 =?utf-8?B?TTdxa0Fjb0FBemN1Mjd2eHo1Q1JINEhGYVFUTStqSkFDb1hXTHo3cE9sdUg2?=
 =?utf-8?B?WFltV3E2SlJoUVk1bDE1QmxEeWgzb3FGKzhYN1k4SjhTTndXSytVeGZJT0VY?=
 =?utf-8?B?bTExN21pMFM2K2Jsd0Z2cjR0aHZTQk5jdzBXaElncmNkK3AzMHhOdDBQWnRy?=
 =?utf-8?B?SnJtQWJHMDhiai92VmVJKzQzOS9TYXFNOVZIaUt5RXA0WjAvellXVzJZRjda?=
 =?utf-8?B?blE1RzVTZEhmSW1OL3dkbVp5cGpxQ1pUYjRMWWxPQmpneFRKVWx4UWlBNFdN?=
 =?utf-8?B?WnVvbDdoTEptbGZ6b2dOMUJXb21FeVBMWXdoZTVtUmVoYzZZVFFybU0zSm5H?=
 =?utf-8?B?NGp2bjZjN2h1bjhRMXdCb1V0cWo5NGhJYUtuZzQyUlNZRm5vVndFSHJFOUUr?=
 =?utf-8?Q?GErrIUPzjlIMPBEI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A05598BEC940AC4E9CFF7E9089C402AB@namprd02.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: ridn72B7G2rYiIqfze/uw0yRwD/eJYVs3QgzpOy8Jpx1iJYk1X2+LxT8DYgdZGUPDv5CliLqZIbXpk6eNMOYOgOddtnRwmWLWxMlopeK3TSIw6vujr3KW40NKoZI47+4Q7UduxDLH+z++rYvIaCFvQkxkFPYKbIXs5u+7mOSiiu5tjlKcfXQBZNzLueDVAH+ybE4dE+dKNvRr9q/pv1hGF06dq/Lqq10a5uAVL3hp0gfDPZcEfMXQSbbF/HCOuJsIO8aByFZ2tkt0LKR+G65rYFQn2IKFJBTurM/DfOA4PLSs2PiJJ82WSQZucD9SEbPGoN1UAcmI+oxUniZ5xtfyPeeB2vXJLqfMC3vwWdBW2eljQIbA+uKAMMQEp+8IruQG4Jhql6jL6PEtOq9PYfzquL7KdHRJZTN60eASdWqA9BF4B1LdiR50bMZbGNO43MFHpfPf+ZKs/rTkuDJGcDWdwFMjtGOGgl4KTL79CbHDvNZX7WXnPMIiN9pfUjcHnuKw92Ch0stnrL3ycQqFesoCmYnTEwCpJv7eV9XaZwYsBQQmkZfVLIOS47wD91q0VlGVHNe5vZW75/xO54aEF9GX+JIv4zADmbLjG7bLjZdenn+LAGM7q8BH72+TgsHizNo
X-OriginatorOrg: qti.qualcomm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR02MB4435.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2327a230-ee12-47a9-499c-08de788bce97
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Mar 2026 18:44:59.4483 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: osq5b4qX5tRjTmfqCOSRus7NIIrX1FqYelB39F6Y7mZzqB/rfxCCcsDnBISoCtQQ65cDW08gjFdwWAHbDD9JxdEL7ZXCeJV8DvIFOITM/l4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR02MB8754
X-Authority-Analysis: v=2.4 cv=Br+QAIX5 c=1 sm=1 tr=0 ts=69a5daaf cx=c_pps
 a=wTW14iHPWsjxmVSX4jmdzg==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=f7IdgyKtn90A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=V1jnuoLLAAAA:20
 a=VwQbUJbxAAAA:8 a=IpJZQVW2AAAA:8 a=EUspDBNiAAAA:8 a=MPGxGW8KdBHyhiCmLn8A:9
 a=QEXdDO2ut3YA:10 a=IawgGOuG5U0WyFbmm1f5:22 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-ORIG-GUID: q7vBPgs2SNyulhyZ36J8x43ySTbD3oWA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAyMDE0NyBTYWx0ZWRfX6T0VZWsDbGEX
 ZFmlzRuCHaUcX0CG1dczk/fz9piOk3NS5lQziUsil6WJ0GFOEfI2kLOE1IfTnueOk3y5ianjLFa
 2NM/hXFyntV/4WHumSPIm+bndJhx1wX2trnr3iZC9bjLzy5voaKNuoqQZ1as2pNVzvyCBMRB99C
 9qwlnBH1eAMqEuFPfqSYOwhhMd1KEb0DyTrQYXaJV5mH511dh9Nz3LGZxApoAUqHwCFilQnEXMa
 wMd7JdGd2KJpAQcMkzu/pNp/vJNePf+kVnjR5g0t67KY0Ctq7QflxnmrHIAYCH83ftsF1D6p/Zc
 eJqwSiAzdbW8ETE2iYyTWM9oElXVS7YT01YhWUIqMb0wwZ+LoU4TjYJSB8Jm5IBjd7lfxyo06v5
 9oJLciswqACBk0+vBswtOd8jXLYZ3xhZzl30Geq8ELlzSsJQxFFiseV13K5uL2qMG+biLdAi1Rs
 +McBG0gBJVQAA4i1f6w==
X-Proofpoint-GUID: q7vBPgs2SNyulhyZ36J8x43ySTbD3oWA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-02_04,2026-03-02_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 clxscore=1015 bulkscore=0 spamscore=0
 priorityscore=1501 adultscore=0 lowpriorityscore=0 suspectscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2602130000
 definitions=main-2603020147
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

MjAyNi0wMi0wMVQxNTo1ODowOS0wODowMCwgRHJldyBGdXN0aW5pIDxmdXN0aW5pQGtlcm5lbC5v
cmc+Og0KPiBGcm9tOiBOaWNvbGFzIFBpdHJlIDxucGl0cmVAYmF5bGlicmUuY29tPg0KPg0KPiBJ
bXBsZW1lbnQgYSBjYXBhY2l0eSBjb250cm9sbGVyIGFjY29yZGluZyB0byB0aGUgQ2FwYWNpdHkg
YW5kIEJhbmR3aWR0aA0KPiBRb1MgUmVnaXN0ZXIgSW50ZXJmYWNlIChDQlFSSSkgd2hpY2ggc3Vw
cG9ydHMgdGhlc2UgY2FwYWJpbGl0aWVzOg0KPg0KPiAgIC0gTnVtYmVyIG9mIGFjY2VzcyB0eXBl
czogMiAoY29kZSBhbmQgZGF0YSkNCj4gICAtIFVzYWdlIG1vbml0b3Jpbmcgb3BlcmF0aW9uczog
Q09ORklHX0VWRU5ULCBSRUFEX0NPVU5URVINCj4gICAtIEV2ZW50IElEcyBzdXBwb3J0ZWQ6IE5v
bmUsIE9jY3VwYW5jeQ0KPiAgIC0gQ2FwYWNpdHkgYWxsb2NhdGlvbiBvcHM6IENPTkZJR19MSU1J
VCwgUkVBRF9MSU1JVCwgRkxVU0hfUkNJRA0KPg0KPiBMaW5rOiBodHRwczovL2dpdGh1Yi5jb20v
cmlzY3Ytbm9uLWlzYS9yaXNjdi1jYnFyaS9yZWxlYXNlcy90YWcvdjEuMA0KPiBTaWduZWQtb2Zm
LWJ5OiBOaWNvbGFzIFBpdHJlIDxucGl0cmVAYmF5bGlicmUuY29tPg0KPiBbZnVzdGluaTogYWRk
IGZpZWxkcyBpbnRyb2R1Y2VkIGluIHRoZSByYXRpZmllZCBzcGVjOiBjdW5pdHMsIHJwZngsIHBd
DQo+IFNpZ25lZC1vZmYtYnk6IERyZXcgRnVzdGluaSA8ZnVzdGluaUBrZXJuZWwub3JnPg0KPiAt
LS0NCj4gZGlmZiAtLWdpdCBhL2h3L3Jpc2N2L2NicXJpX2NhcGFjaXR5LmMgYi9ody9yaXNjdi9j
YnFyaV9jYXBhY2l0eS5jDQo+IEBAIC0wLDAgKzEsNzMzIEBADQo+IFsuLi5dDQo+ICtzdGF0aWMg
dm9pZCByaXNjdl9jYnFyaV9jY193cml0ZV93cmFwcGVyKHZvaWQgKm9wYXF1ZSwgaHdhZGRyIGFk
ZHIsDQo+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB1aW50
NjRfdCB2YWx1ZSwgdW5zaWduZWQgc2l6ZSkNCj4gK3sNCj4gKyAgICBpZiAoc2l6ZSA9PSA0KSB7
DQo+ICsgICAgICAgIHVpbnQ2NF90IHJlZyA9IHJpc2N2X2NicXJpX2NjX3JlYWQob3BhcXVlLCBh
ZGRyICYgfjB4N1VMLCA4KTsNCj4gKyAgICAgICAgaWYgKGFkZHIgJiAweDcpIHsNCj4gKyAgICAg
ICAgICAgIHZhbHVlID0gdmFsdWUgPDwgMzIgfCAocmVnICYgMHhmZmZmZmZmZik7DQo+ICsgICAg
ICAgIH0gZWxzZSB7DQo+ICsgICAgICAgICAgICB2YWx1ZSA9IHZhbHVlIHwgKHJlZyAmIH4weGZm
ZmZmZmZmVUwpOw0KPiArICAgICAgICB9DQo+ICsgICAgfQ0KPiArICAgIHJpc2N2X2NicXJpX2Nj
X3dyaXRlKG9wYXF1ZSwgYWRkciAmIH4weDdVTCwgdmFsdWUsIDgpOw0KPiArfQ0KDQpJIGtub3cg
SSB3cm90ZSBpdCBsaWtlIHRoaXMsIGJ1dCBJIHdvbmRlciBpZiBRRU1VIHByZWZlcnMgVUxMIG9y
IGV2ZW4NCk1BS0VfNjRCSVRfTUFTSz8gIFVMIHNob3VsZG4ndCBicmVhayB1bmxlc3Mgd2UgY29t
cGlsZSB3aXRoIE1TVkMsDQoNClJldmlld2VkLWJ5OiBSYWRpbSBLcsSNbcOhxZkgPHJhZGltLmty
Y21hckBvc3MucXVhbGNvbW0uY29tPg==

