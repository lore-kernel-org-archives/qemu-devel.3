Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A320CC61DB9
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2026 11:56:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzvBm-0001kr-6P; Fri, 28 Aug 2026 07:56:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@qti.qualcomm.com>)
 id 1wzt1K-0007Xh-Kk; Fri, 28 Aug 2026 05:37:10 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@qti.qualcomm.com>)
 id 1wzt1I-0000Ds-Q9; Fri, 28 Aug 2026 05:37:10 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67S66gWS3205959; Fri, 28 Aug 2026 09:36:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-id:content-transfer-encoding:content-type:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 qcppdkim1; bh=I6v5h0AZ4FmSv5NdQWDOCo4+CTXIUNuC++wasSFoaEc=; b=RR
 cmaBHT7bLQ1uY4XUpcOd8fGbRt4UrNitOhqxtyqjcxGbwVOJYoXHq9AbGn1PnvjB
 Q1zPIQ0PTCdwBhwH8Hg+tUbKTwS+Ker1YFDKpNd1o9LCzTp3grvUcRyZ4qLpbWyG
 14bYYv/ryXVIRLNHaloWQZBwQRtWArHK/XRfFJg9vtHAJp1URTju3uewsXNdDR3T
 B99jjyC8+OoWuyogNNapBky8KytdFPyqABwhtkIhMazkDy+mV/cvfz5GJjcdmWN2
 oFboScdT0Q1JW1O8YdrD90HLb/3Pl9GQcjVLx6lMXYa9GwjPBj9WWrzfq9X28fD4
 CFCToGDXQ7ptYdBmoUgw==
Received: from ph0pr07cu006.outbound.protection.outlook.com
 (mail-ph0pr07cu00605.outbound.protection.outlook.com [40.93.23.93])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gatfxkchx-2
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 28 Aug 2026 09:36:41 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IUilwhnHwvis9Zs8nYNwhJ5Xp7fFOkjcylO4NVjMebhOXK8OuO6j+8Krfq5+H891LMbDTSE2id7+/eW/nJNxQuejgsPHn9sK+KWwAG01sSTnCHRa7UsQ1Ol88L1Fqi+7kRZQw2O9hFmzV/m43zPb/yHa0meVo9lxdbBmJNjdFTvQrwczoK/k+LVUiaBwxtFghVd7ZSh6Uehm4VJMnd3KJq2JdyAxuYUXQH6x6Sq7PtuDgoo+LTXW+FZ0WWCNGAB4RjwVC3vhHXs0fw/E4uF1gW5ANAdoHdTkzB87eP5c8O/KQ8lxLTLmBxuTLvhxALZkyFAmcgKZtTrSLp5MXq3baA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I6v5h0AZ4FmSv5NdQWDOCo4+CTXIUNuC++wasSFoaEc=;
 b=HttvWHznEkkZJngFTEMvB25fffkglvRo4mpAd2n1+DiVXT7ieyi+slaVsu+JAgCZJzxboNf80aUhY8N0A5MizRVxlsM2XfW36U+slthdNU1nk6YKFSxikJAdIYOLbhnc4cEq0/KC/zQL3/+BrXwq8T4fu23XxZZYDB+YPfpB7uQybQe+gB/v1OdTLz+N+o1E3xYbuQ/aD8oYDc/j+HB16UKWPqoB+vRt/KZDhn54uUAow4p9SJuUYn4lZEZHd5aOU7FwUS6RNf+3kbxNCFFEggvTwr7gtD14ZXzGsCUy+zqq1a8cwVOmivMplq0uTc7SMv4BZsS2vbNGjqLLnErceg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=qti.qualcomm.com; dmarc=pass action=none
 header.from=qti.qualcomm.com; dkim=pass header.d=qti.qualcomm.com; arc=none
Received: from SN6PR02MB5518.namprd02.prod.outlook.com (2603:10b6:805:eb::23)
 by LV0PR02MB11111.namprd02.prod.outlook.com (2603:10b6:408:334::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.7; Fri, 28 Aug
 2026 09:36:36 +0000
Received: from SN6PR02MB5518.namprd02.prod.outlook.com
 ([fe80::d86c:cb35:1a2f:df35]) by SN6PR02MB5518.namprd02.prod.outlook.com
 ([fe80::d86c:cb35:1a2f:df35%7]) with mapi id 15.21.0360.008; Fri, 28 Aug 2026
 09:36:36 +0000
From: Philippe Mathieu-Daude <philmd@qti.qualcomm.com>
To: Jamin Lin <jamin_lin@aspeedtech.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>,
 =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, Steven Lee
 <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>, Kane Chen
 <kane_chen@aspeedtech.com>, Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>, "open list:ARM TCG CPUs"
 <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>
Subject: Re: [PATCH v2 4/4] hw/arm/aspeed_ast2600: Wire up the UDC
Thread-Topic: [PATCH v2 4/4] hw/arm/aspeed_ast2600: Wire up the UDC
Thread-Index: AQHdNtC3UWgfFT96mU21Wyyus/Rvnw==
Date: Fri, 28 Aug 2026 09:36:36 +0000
Message-ID: <ba0234b7-3fe6-4d9f-8c07-494985c80f9c@qti.qualcomm.com>
References: <20260828090412.981841-1-jamin_lin@aspeedtech.com>
 <20260828090412.981841-5-jamin_lin@aspeedtech.com>
In-Reply-To: <20260828090412.981841-5-jamin_lin@aspeedtech.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB5518:EE_|LV0PR02MB11111:EE_
x-ms-office365-filtering-correlation-id: 3e3ad381-c227-49ff-1bd4-08df04e7dab1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|376014|23010399003|1800799024|366016|38070700021|921020|10067099003|11063799006|56012099006|22082099003|18002099003|4143699003|3023799007;
x-microsoft-antispam-message-info: p0575IcXcVMt1D1wu8Vdey42UoDPZPACB1vQM62E9D66PH3YfyHocI0htJUArBMMPkYKdapP+W2FkOURmLaq9s32weNI1Rq8N4Zs6MmN+1bygcWIF/iKvtPmO2ZhcLnAlokQ2xB0Ahd3ZHJkEJGYgkoki0LLQ68MGXcdp9UmqZO8BG1w+hInymugEtZ2j6XdBNaSk3WFFherrylfYxhPWRuPVG0sm6RTi2Uq0zMP2Z0tkT1cj2RwaE3V1YVGCDq9jFQPqkbxq0CmiCFigbpFQ1GAjb7Cmgmc2mdf+VvZi+OWPTFWtwePZIOBaLKa31oKokYn8HzIpe1cfOA7NQiwMApDTAdiZZjgISjxoqX1Wx+PwiARD1mgUZ3I1tKS+gTVkdkU/nX0r9a52XwQfG8h+44bhQXagxfR0+HXLvQzvALmox6lk8u3YoQ9IljG3G3nMjVj1kT3pohoQfXrslCznmaNurSIfRpaGAOuzXyLqo2cjs3cxdlUeCYqlCwvdJQ3mtfFr91fZYv/Zz1bu3dx/IsAT1KrYo0Eyhm++dWpaKsAc91dHilEdiHrJwy+jjdvucDLnQyZ/T6PrQex+bk7T3JgJp/4h71xhBIvCxfaDd4Mm6GkIItVjbwY7mccvCw6Ni2we7q1SrpqQvLKYLd+cTHIGc+m/HfLMSMRnXHuJs7InQCpXG1oZJi8KkeSYue/JBJuZ6eww5Mzm1q0GUExODJUMoGFOq6KuXtiKKsw7Oc=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR02MB5518.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(23010399003)(1800799024)(366016)(38070700021)(921020)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003)(4143699003)(3023799007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?T0ZPLy9nNHVsM2dZTFBkbVhqbEIvU1BodnJFMWpOd2c4NHV1NGdjeDRpSHBy?=
 =?utf-8?B?OUtwUDZKNEpMTEVnYXhXQzJBbWVobVZKUUZGN1l0MGlPdUVrRnhNbmZIV2Zv?=
 =?utf-8?B?NzNxMmxtUmszSXZOZmdxVmFxaHhSdG5HcUNyU0twd1J4ZzlVbDNzYllMSjJr?=
 =?utf-8?B?ZGRLYU9TQU92WTVpQW0rd3F4bndkVUsyZWFuckp1TlRDMTFhSTZyUXdsRnJz?=
 =?utf-8?B?UjJmQTY0YWRBOTJybS9sUE0xSnlzYkdNUCtkeUFDaGpBRmNpaWZxR1oxSkgz?=
 =?utf-8?B?UVBzWVNCOFV2K0R4eEM1TjhSMXNHQVRrWVpXcXY1OGpUREwvVVduemZGRlJU?=
 =?utf-8?B?QjVTNE1iellScGZ4cDJwUVE1VlB1ZVNWZ0gzeTlWbFZkS2RaNW56bGZzMEdR?=
 =?utf-8?B?L1JDYXFoU1pZWDNFM0I5T1BRTmc2UnVoNCtBQ0FEbmlybkxneE1lZDQxVEY1?=
 =?utf-8?B?VTBoTk9MdndYc0V3ZVVqRWRtNGJoa0FhM2t2ZktPY0dNblh0UW5KS0RER2tN?=
 =?utf-8?B?NnJmbVZQVS9OY24zd3ZNM25mdUx4NVJGWmp4dHQ3Y0hrNkVCRVFuTXRacnJv?=
 =?utf-8?B?Qnl0NTBoQVFOakorWWk4Z3NHM2lrT0ROTlE0VUJ3SVBRd1pBTDlJVWtRTy96?=
 =?utf-8?B?UUwwdzBwRDc0TlU3aWVHWlBqcXN2VXl4c1RtTkNDY3N1NkIydTVVN3VUejJn?=
 =?utf-8?B?cUIzRGltSURJekxyeTY1cldmQ1hvYXpIR1JWb2M0REQyVWpWdHY2cnllMXJT?=
 =?utf-8?B?dW1DUlNSbnQyYTc0c29xUThaQ0hCQjErdENwRFRsMms4VXNaUGNMQitUeTV1?=
 =?utf-8?B?bU00dXFiSGhTOUJRZUN2VFpEcFBKN1ZxNlBOM3UxZjRqQmF0bENJN25jd29j?=
 =?utf-8?B?QUpISlZnVEJ3QWV6TzVkNkpTbU10OUdEd3lIZ3F3K3FaR1lEVTR1aktja0hp?=
 =?utf-8?B?TEtxaEs1Z0xtVG9sVXB1aFhZRkxpa3p2c2wzRzN3ODdQcWxIQzE5eGpVNWlW?=
 =?utf-8?B?ekRpc0FUZVBycitLY3pWS2hoV0ZDbUN1YTU3K3pKczRlRjg1WUtIQ1pOTEF3?=
 =?utf-8?B?VHd5UG1tbDVWLzdDd3lhVHJGa2RkMmdQUnFDai9hZjVKRytxOEFWdlpSZXJT?=
 =?utf-8?B?enJKR0l5S0hiSmhaVFpIVXV3ZVNRK2pocmtOUk9kdmtDSXg4TlJGbjlCdFRq?=
 =?utf-8?B?aFIwaVU1Y2RmbXdnMHBodVlFWkJSV1lxZThNVjRhczJmOUlxTnloZmZNT2I1?=
 =?utf-8?B?dzV2OW5DNzNKVG9VOW4wbW90TVpsMElHWjFXMTlqT2V5YnIrODBBamNJay9W?=
 =?utf-8?B?UUExYzVyRnQ3YUdwYXdNYlFOVUVQT004VzRhWWI5bmt2QjdxQzVqZ1E0dytU?=
 =?utf-8?B?SVRrTERFZlRlTjdiNnJVcGNJVVJCMUxSMm5na1JLUC8yVVB6RHJHNTk5S3RP?=
 =?utf-8?B?SVluSncvYmRtYTgrY09HZWxPUHdhSjhLRWVPT1FjbXNKelJEdG9iSTRSMVgz?=
 =?utf-8?B?T1VuM3lLZEVYUnEzU0c1aG42SWhQUFpIbUlpd3V1cEtBVkNUYlhPa2ZkdGRp?=
 =?utf-8?B?SE1ad3lSQkl1bjFvZWRTM3AybG4yNEsxNk1KNHRxMTJnNGE1V0wvc0xmN25H?=
 =?utf-8?B?anJiRHVWNnluNTlZZG14eXlCQTZUZU1oMm1UNHlGeldIK1N3dkdDeWZoL0g3?=
 =?utf-8?B?aFZVVlpYSzI4ZVhLK2tvY2FPQW01Rjh6TUlRUGN5czZWTkFTaTJYMVRWQWlV?=
 =?utf-8?B?NW5OaHlzemY0L1gvOVU3S0RhSDh2U2c1cjZEZWRyZzB4Z0Y4Y3ljeVM5RXFl?=
 =?utf-8?B?OCt1YVpOdDBodlBqeGFtN1JGS25PN2VZcU9JN3c5Nk9YQVhVNzlNYy9hckFP?=
 =?utf-8?B?QVh0YjNKS28ycFg3TmtwUHNMZWVZUXYzTVF0cnhFMWMvaDkwMkxMUWNJcm5a?=
 =?utf-8?B?RGErT29ZNXkzTjZtbXNzUVRLaEcycDFVc0tYRENOelYxQW9VVnEwQkpBQlNH?=
 =?utf-8?B?T01wSU1taEV1aEZSeEtsZTg5c2VLM3J5SGhuenhObjIyT20vU3FxQmVZWng2?=
 =?utf-8?B?NnNtUXJheHdheGExcGl1YTdTNFRsMlh4dzB2c3c4QnBHb2tHUTBRemRXTThU?=
 =?utf-8?B?RDVVWURzUlI2UEo1SGhhOU5VRzQ1dHZWdDhRd0owdjlOejdHbDZtdWlFbjMv?=
 =?utf-8?B?bHFWeElBbkkrS0d5WXIyRHA2WXJXWnkwS2NQWHpCUG1uRVNwZndsZGF5S3pY?=
 =?utf-8?B?ZWR6LzRqbVRXRVZVUy9uWktwUFBJYlMzZmF0cVY2YmVNU2ZKa2F5QTcxcmNo?=
 =?utf-8?B?SFJ3T0tmWE52VExKaFZEeldiZnZmVjBIMk5qamdOdEUyL214MnpKQT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2D1668C6AF38C04289E820B5DCE985A8@namprd02.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: bQ6tvszF4se5dXTmDAIy8q5UNsvGWon9ukHyNoZ7zo+855RgT3E86CnHkar5IP71GfFLOE9+1OTPgOuGDqsNwjFJkQ7p4JOkYlerNBZGA16I0rjIAH2DhA4xfr4LzNvRxIGblG5pS+2Uk2nIa+3AeFwll+VtPBhD9GVfIjRp6TGa1WT7uZZiqTQ9oKkrjCXykc4VMs+UcfAlN5FPYKTsUMj+7r8j08bkUHyTcBluLe3ti56VkhWRa7MsayVso8itbjrwM2N7MCzyFXXkeffdI58k5u4+PdhYaVxVZSpzUNGmh+Jbe92h4+Oc9/SjmJpyeBpamoJcK3XzIQaL05BKxg==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: vooLEMg7ynhFPxe/LYm+tiUiP2wH+ern7A14iXn5iFMRODHzdgnvmpTzTMN+Ou8fNiBNYOxSpyVixh4N9HxonFZ4YFo0HP16rPMq3tMIZfn5CC8/MfvaHip3oWQubbW4l70Suc5yewBJxgliRW+Ra9HYoY4oOd5cwpLfMkZ0koHE9TEgs4SysBjBzNbyw0tNMQ/VnH2pNSzoOZwEz2iW9mwaSsblJO4cYmEBcmRD3ueAbKVYfK/5+ANc14v+qvxaEXXT8F5uy/r5PgPOmDnk/5YNEMdWnCyv6+E8mmlvO43bg9ycHIfj3i9cpTqGxOwgtdiT7uF5kxUGca15GulbofyDKvk6Pd3RUcZN+lCV61zcoUzOtT5IhjGg7h5ivXLZ+1CtblFGX6oCyiYFrS1bfLeYaYAHnI3XE0af/6Xle98Zo7cK37KRnZz4t/P6MUsKLEtfOBQTsBRG1iGj+e3RyuGnYt+zrDAGQNxJJQT3zw/0jigQlj2+Ln2qSWpU/nR2wAhCHB7yutPXeMVphsOcxlw1x38ZgHDe/Og5d7bD0U4D4ikDblo1c9rEk22bYUtCpKKc6Mzu3bM4TWJMkMTdDkO4RBsTo0C586XWINM7b5WCtWLFvoj/4DltuvfQpA1q
X-OriginatorOrg: qti.qualcomm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR02MB5518.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e3ad381-c227-49ff-1bd4-08df04e7dab1
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Aug 2026 09:36:36.2662 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tUDrcCYNObe9qxXVjdIX0DBUu+3WcTjYkdW9SHQyQn7TV6QbdVE3UN3zJLbAkoE0fElxZsVs4UIpYJkUpyzw/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV0PR02MB11111
X-Authority-Analysis: v=2.4 cv=UKLt2ify c=1 sm=1 tr=0 ts=6a9156a9 cx=c_pps
 a=kkL2Kc6oeAmw00bzYmamMQ==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=eoimf2acIAo5FJnRuUoq:22 a=V2NxCb60AAAA:8 a=EUspDBNiAAAA:8
 a=1tSEMpTH9XP_W59IOagA:9 a=QEXdDO2ut3YA:10 a=3L6qF29SlnrayQqPM2jZ:22
X-Proofpoint-GUID: WBeLALWWXWrkGs09X6lrfew0iGeDXWcJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI4MDA4MiBTYWx0ZWRfX5Br/doolaWbd
 As6OMFcA5n98s8ODPo21qPX19q63LyRVZlJ11XhWnpBCozGGV1oD9D6hnq6r7Nn/UJxRXi+Vi1C
 3OkI2olIbETAVgihrENDYVRowZUEyIXidTGMsoVv6rM85tgpRR+JwJ7SsEP3fGpgAIU2bsvkudN
 YaCthpL25Sb+Xw1kKA+FgdZoHdoe+ojeSfNjHfOECj+xcs+FOB4ebtHjp8fbpSL2aDEQAZqYeSf
 tet0vvnVwTGj5RaOSCAf3VwwQOnXrrgHTDiWs448gMtACbpk2NKLOW0aJkigNv3PM6+VSCQ5qQN
 /e0Uf5i8uQLlBDbgjYohW0DSWWVnBKDbBkgXo5fv8L9gCa6HSFX4Sd2Yv+yBE1jPh7YYa10hOA9
 LvhcGtDITuPzjdMXBahK+Lo5YFNDLQgNEq2NZ1AfukY9z8cgdg0/CL6iqyRpqwQ+ygZw8dyNT1y
 jDHEbcThDq65WZ4Wmbg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI4MDA4MiBTYWx0ZWRfX+tP4T21O3Lsz
 ihYMTnVT4eISLCVkwNuljMbQzCNDlrkSh3km2dXF6X5ahX3fuvO7vdkQ9E+KQLzEgernWtwHuMr
 BQJZhtLyX2ENQwtleGmVTITtscMsASA=
X-Proofpoint-ORIG-GUID: WBeLALWWXWrkGs09X6lrfew0iGeDXWcJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-28_02,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 bulkscore=0 suspectscore=0 lowpriorityscore=0
 clxscore=1011 phishscore=0 malwarescore=0 priorityscore=1501 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608280082
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@qti.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 28 Aug 2026 07:56:03 -0400
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

T24gMjAyNi0wOC0yOCAxMTowNCwgSmFtaW4gTGluIHdyb3RlOg0KPiBDcmVhdGUgdGhlIFVTQiBE
ZXZpY2UgQ29udHJvbGxlciAoVURDKSBhdCAweDFlNmEyMDAwIG9uIHRoZSBBU1QyNjAwIFNvQw0K
PiBhbmQgbWFwIGl0cyByZWdpc3RlcnMuDQo+IA0KPiBUaGUgVURDIGFuZCB0aGUgc2Vjb25kIEVI
Q0kgaG9zdCBjb250cm9sbGVyIChFSENJMikgc2hhcmUgb25lIFNvQw0KPiBpbnRlcnJ1cHQgbGlu
ZS4gUm91dGUgYm90aCB0aHJvdWdoIGFuIE9SIGdhdGUgd2hvc2Ugb3V0cHV0IGRyaXZlcyB0aGF0
DQo+IEdJQyBpbnB1dCwgc28gZWl0aGVyIGRldmljZSBjYW4gcmFpc2UgdGhlIGludGVycnVwdCB3
aXRob3V0IHRoZSBvdGhlcg0KPiBjbG9iYmVyaW5nIHRoZSBsaW5lLg0KPiANCj4gVGhlIGdhZGdl
dCBVU0IgZGV2aWNlIGlzIG5vdCBjcmVhdGVkIGJ5IHRoZSBTb0MuIEl0IGlzIGEgc2VwYXJhdGUs
DQo+IHVzZXItY3JlYXRhYmxlICJhc3BlZWQudWRjLWdhZGdldCIgVVNCIGRldmljZSB0aGF0IHRo
ZSB1c2VyIHBsdWdzIG9udG8gYQ0KPiBVU0IgaG9zdCBjb250cm9sbGVyJ3MgYnVzOyBpdCBmaW5k
cyBpdHMgY29udHJvbGxlciB0aHJvdWdoIHRoZSAidWRjIg0KPiBsaW5rIHByb3BlcnR5LCBlLmcu
DQo+IA0KPiAgICAtZGV2aWNlIGFzcGVlZC51ZGMtZ2FkZ2V0LHVkYz0vbWFjaGluZS9zb2MvdWRj
DQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBKYW1pbiBMaW4gPGphbWluX2xpbkBhc3BlZWR0ZWNoLmNv
bT4NCj4gLS0tDQo+ICAgaW5jbHVkZS9ody9hcm0vYXNwZWVkX3NvYy5oIHwgIDQgKysrKw0KPiAg
IGh3L2FybS9hc3BlZWRfYXN0MjYwMC5jICAgICB8IDM3ICsrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKystLS0NCj4gICAyIGZpbGVzIGNoYW5nZWQsIDM4IGluc2VydGlvbnMoKyksIDMg
ZGVsZXRpb25zKC0pDQoNClJldmlld2VkLWJ5OiBQaGlsaXBwZSBNYXRoaWV1LURhdWTDqSA8cGhp
bG1kQG9zcy5xdWFsY29tbS5jb20+DQo=

