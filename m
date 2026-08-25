Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AAE5C61DB9
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 15:22:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wysyb-0003PP-Hb; Tue, 25 Aug 2026 11:22:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wysya-0003PB-7o
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 11:22:12 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wysyY-0000RR-Jf
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 11:22:12 -0400
Received: from pps.filterd (m0127841.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67PEbfbY2221836; Tue, 25 Aug 2026 08:21:57 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=bAh3YulMLgLyt+MB+72KUeBXggxdg8dJu799z90Q8
 X0=; b=IH4GCFzIg8q+WnrZfhzfeJkZhkIDLt8aQwq94B8QQajbkUwF4IP2g4yVL
 avHUyuzy8ZxE9ZgEeUyDklpjw1lxA+PkWGfxp1Ahv+myy/lPlYUUYFT0XxR3ck6d
 vlwg/9Irb7gtIFo/5TosMcSDR2XUFfdkCLX9gdQkIphNVVjGesImoHoQNOIaQF8/
 inhaBwFyVIa69+UCsKf0X/M/8nmYUXx6thQ8bguiYGjG8b4xBclDp/6wRqlgn7n3
 jseXkeu39abJDOEzG4vuANVhXYepDLOTn8VuFV5ReMaTYcxfehLbSVXEeTbGlZSx
 aXNJlCmJ9OgXfEqhZ4Mp1SzY/blsg==
Received: from cy7pr03cu001.outbound.protection.outlook.com
 (mail-westcentralusazon11020075.outbound.protection.outlook.com
 [40.93.198.75])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4g8sy0jsqm-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 25 Aug 2026 08:21:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PF9LGsgFykMLccIGneagXZIKUjJ2VLCybl4lJExVEmand+7kQppMX/2sybHlzcpSehdy+W/JyNCHH/XLhj320MwO90yZr24nJULJY7XIRBg0eqZ5E+UzAxrbfpFCvGCH9VlftnU7ol79uBCsUJUGd1D1IfNYz5okR5lBxCU323QIsdG7W7WJcfAH60T6rxYEuL7wkYDguPBXjXlW4clq1xuT5qC1QJ8uMM+oYeZMfKRjqsbCfB6DZDTmZpnas6cFkhBOHSNZkTET4Ya/FN5IvhfK6DLt6xHzlrNQB6gDPDZMfoZbDY1WLmpTSzILLq9kHLqGKN39o8ZQzCg0J5DuCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bAh3YulMLgLyt+MB+72KUeBXggxdg8dJu799z90Q8X0=;
 b=Qsup23cYetd1fz9mj6p/V9bcu7c9Qr02l7OsA8SJ3yfjI688qH2HdWmgzn+JfWBnB1YpbRCKqdU3kTD4nlON4JrpyM4c87yic6rgQPPUgjKFdOJBS15GnxrFfAcy2SF17kZRwKHtu+Fw1VjYpuzp+qVh2oZjxKZ8Fectx4FYlVOgQmKHkL4TPQqRxTdiBVYTjxxYfjOfN55bQEYghyTD2lUQm7BTQR2eD+her74H4vBD8+6gjXeqg7UPgSpKoQuYaPLYnXHgEBHyz1cFbOl3d1u3xQn2az7geYE+Fp1+8fS7IRiGATze4PZlqWUyFwP80hNXGqxHIugunhiNeKdbzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bAh3YulMLgLyt+MB+72KUeBXggxdg8dJu799z90Q8X0=;
 b=b2Txm2XQPWy7d57wJoXg+tLHg8Em4fQSOUKKR3RvgXluFZKFfH/ByvAYmoQmQs1E60uVx5c84zbl4xn5cjTHBU1rJ88FlQyuAUcIPR+n+w09Bs2Kvyjy1STR3fsGcU256X1zKyXmQ+2U+nNG9YvBxmTHUA2ezy32RvzBRP70dDlEj9mEvb08VlI+UtcTjXidXeAL337cnV2vCZpMvxAVosCMeyW1mdr4AM12j7pNgJscStOWmEPvCJrgo0KQjd1z12qLimGZpew2H3m5Pl6mBFslpU6+zn2QWdZO7VSqChL7gWXW1XQcZWl2H4VAdwUgX6EIgpMflrlWRQA7knffTw==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by SJ0PR02MB8562.namprd02.prod.outlook.com (2603:10b6:a03:3f3::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.7; Tue, 25 Aug
 2026 15:21:56 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%3]) with mapi id 15.21.0360.005; Tue, 25 Aug 2026
 15:21:56 +0000
Message-ID: <19354d19-8611-401a-9f84-10758d78ceb3@nutanix.com>
Date: Tue, 25 Aug 2026 16:21:52 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 40/74] backends/hostmem-memfd: fix "hugetlbsize"
 property typename
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Michael Roth <michael.roth@amd.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 David Hildenbrand <david@kernel.org>, Igor Mammedov <imammedo@redhat.com>
References: <20260818-qom-qapi-v3-0-24b8bbbe3d86@redhat.com>
 <20260818-qom-qapi-v3-40-24b8bbbe3d86@redhat.com>
Content-Language: en-US
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
In-Reply-To: <20260818-qom-qapi-v3-40-24b8bbbe3d86@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA1PR03CA0022.namprd03.prod.outlook.com
 (2603:10b6:806:2d3::27) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|SJ0PR02MB8562:EE_
X-MS-Office365-Filtering-Correlation-Id: b7359f8e-6b35-4633-a916-08df02bc9954
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|23010399003|366016|1800799024|376014|22082099003|18002099003|56012099006|4143699003|10067099003;
X-Microsoft-Antispam-Message-Info: i/VKNmuxVkf8trvKmDr4lDrgkgaJ/AY3RjyQhOe7lYKUcyZVBdc8WVbZi/BbT8nXmWwiC3BN3JToza3x4OhWEFNv6dGGXTV2M1ATDsTwVCv4x9c1CqE/HBQ6R9wlC0GjC0qr98JgdWGnmEvTHcWplcNkT46pxjaj8DdhMMc1YbPeTyV2p6yhiPY+1ALXCxMlR4HmAPIzY8jdsfXuDLJYqbBPGaB0x24+CBu9vNVwJUiOIMiGGB5WOphBID/56/Utwqd9/AuUahJrGS3fV68P+NQHhOXKtosWt/lB249hvDuvPTRh7x8fzCpkFhnxVOUHMPSQ2hql58z4eBXH5XdIVtM1NDNSzxcmTY1KrPMMH3YedL47wBWtT0Z1jso6lj5ks+70F6D5lXAb2d9kYa/L0v0nGskjEB5dN2zve/RcONT8C7dII4Di9d8btEZ5haPx1b+mN20U26jNlDu5xqgoGmm3fIiKx1SKSSKkoTVJlhbMftvNiDcbmZ13pQbM0UKcTP3yck3E2SyuFCwt6OL1+9kMI8tvDPYowf85O/ME4Gc0v4aJ6MvzXZMmDND0RRb69x/DHZa8GvCNbEIw39SAa75++l4PAU1gJOHkCkm/ZIuJz49m8cIeKXhnQgDD5DdI8HUQN5gmE5ysEWHEv8XkUdu/Nl7L1vh5iL4tVnUBty4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(23010399003)(366016)(1800799024)(376014)(22082099003)(18002099003)(56012099006)(4143699003)(10067099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UWZjcnFXN0VoZ2NtSkt4S3h2OS9PVTQyNUpMa0tSN251dVlmYUoxeHZVRnAr?=
 =?utf-8?B?UlFaSytYclRGV05SWGdOWWVGb0REdDF3VWMzaXdwUFR5ME1mYVQyMWpmTzE3?=
 =?utf-8?B?TnVYTTBOVlR6Yk16a1FuMXdhSC9PcFJxalZPaUJuSHB0bithdEdLWS9HSC82?=
 =?utf-8?B?T1VJZEVMQXZyMSsvRnZzUndTNnpOVXpORmkvNkZ3cXRsb1lOdXUvN1hweGha?=
 =?utf-8?B?SllTdEFIeG81NUNPM3ZpbVdWdU93Q2JUMDR3aEZDREEvOEhrZFVmOExYdUhp?=
 =?utf-8?B?dFZpM0gvUGNoUU84aUFLRU81bjBnRmN6bnhUeVlqSHQ2SUFpNXFwMHFtTGxp?=
 =?utf-8?B?VnQ4VWo1YXNmM2thWU1vYzFCSk1mMzQ3d1Mvak9ucTJBZFRqWGpibDRZN3ZI?=
 =?utf-8?B?ZTNwbTUzbEZpSUF3SlZSVlpHQ3d3eXZKNVNZZ29uL3l2ZjFub1EyeXhUdzIr?=
 =?utf-8?B?VnJydkdRWi9hUjFFUWxVTVJqMmdUakpsSUhnQVFyNUdMOFJCRzZGdEhRd0VP?=
 =?utf-8?B?Skd6V1JOMTQ1VXd0VVJXUEVIVTUrcU1LZ1dWNXBJenY2TUpFd293SVhUdnlC?=
 =?utf-8?B?eGpKRWZNeURTbVY5akcwbmZFODJySTN4RzhIcHNsOThSNTdXdVBGTjR6aHNh?=
 =?utf-8?B?VFJ3SEcranI1QS9IdHNkMXNlQWxYREwyN3FTRzE4dzcxNHJkMko3MW8xV1Zj?=
 =?utf-8?B?T2FaaUVUMG95Q0Q0eThyU3JDSXA1OC9CY3pta3NPZGxEWTdpOU8yREpPdXh1?=
 =?utf-8?B?V3VEUTRxbGoyZERtLzhxSUNQUHF0T1pkRXNMUGFCYllaK2ZRSUxCZTc3WXB4?=
 =?utf-8?B?WkszUW1jekNSaXdRbHhZQk5TazFZMWE4dWZLQm83dnphc2FTeWRnaTg0eVRm?=
 =?utf-8?B?RXpTdVZyZ0JzZmtsTmRYZXhPUVpEeUdJS0pTOWtFQy9tT1VZM05ZQTNMOUs5?=
 =?utf-8?B?VUpRdm5rQnR1NmJlbUVWV0R0Z0l2RTBHMy9HR0ZwTEw0NVpYbG1YSUk4R1pn?=
 =?utf-8?B?MDFKdElDM05iVStCSEZwNGVERlVPSEwxSWlDSVBIcy9PYXlIWVdjdWlOVWR3?=
 =?utf-8?B?czJTMGprNVB1UENkQUl4dVlLS2NyaGVMYTNobjlQa2g3Y1ordWR5SWl4d0NN?=
 =?utf-8?B?WDAyVWVIQ0pTc2NWbll6MWlDeG5zdEsrU2NaQUtEMFQ2MEwybW9jR0o4WlpS?=
 =?utf-8?B?UmtSeHkzUWVSdlNoZW54R28wNW92cmhVMWVrNHBidmZiZWNoUFpSSHRzVUE2?=
 =?utf-8?B?Q09wZ3BXQ1lQNUdIWm85WE1QTU1Ob2d0MEZ3Qlgwa29IbTFWQ2wzM1hPcTNa?=
 =?utf-8?B?YXpsNkpmVlZQUW4xQ1NudzFUWnRaenhSQ0tTbjBjN0NISkFKYTNncjlpS095?=
 =?utf-8?B?Y2R5c1J0Nzdud0ZwVFBuTFR2QXRvVTh5QW8rL2djL0dVUzE1enNKeW02T253?=
 =?utf-8?B?RFo2VDYySkFHcFp0ZE82WmQ1UjNnMTBVSEtLQ3gwZGFqWFN1QzBJT0NLeGR6?=
 =?utf-8?B?ZG9SRll5MmtwSnhMcXlNeVhKTXl5T2k3dC9ncE5mMG1SWUFYaDRuOTFXR0dK?=
 =?utf-8?B?L3FnMzdTaGcrWHJ6bEh6czZLZWdvZDVsU3JpbVhCR0ZVWng4a3dLTVRaQTha?=
 =?utf-8?B?c1VRR3ZSR0lMQWJmdVV6Ynk5VitTcEZFdGQ1SWd1YnZFRVYvSGI2V2txVXJY?=
 =?utf-8?B?UXpTTmtlLytldnlaOHEzVWFJZTg3bjlNUFVxQVdlTVNJTllYZWd6L0YwTjZ5?=
 =?utf-8?B?MnUrdTlLOFQ3d25oaTN1RzFtdFlkMnp2SStNR29WTzhiMzFTMEFXUVAvUWY4?=
 =?utf-8?B?MkovdENuWmFzSTZGMFlVN1VDQ1Q5TlJOWFpZeko2NFpxbGMyQ1F2cUwwUFdZ?=
 =?utf-8?B?K0ZUdTgwb2tFQ2xyL0ZNNDZIaWlUUzNjaGdMNFpSWjlCODF5UUtGQzdTUUZC?=
 =?utf-8?B?cmpjSjhBVWFZSkRPSGp3a0M0N3Z3SmpISmpDNzNlaVgwWHM4QkZNZmhraXcy?=
 =?utf-8?B?MFdZSTJpVGpoYTc3Ynl3cERnZUV5SmQxdlV0bE9Oa0lDRTJ3WU5VK3EzRVlI?=
 =?utf-8?B?UEZKVEVMcHpNaW5hNHM5QXArelFocEFsa3pkNmlRQ1BIS1FDa0xocmRFK2hI?=
 =?utf-8?B?cngrZGxGOGcyUWwvelVBdjdYS2daSlpwbFZUNzgrSjhOSXdCSTljSzYrUTMx?=
 =?utf-8?B?OHp3V0pQRUNBUUR4UncycjI2ekNrSytHY0tuajZKVmJPSytVVzZzU0tTdjQ2?=
 =?utf-8?B?SDZNUDlWaFBlNTYrb2NxSDVGUnhrMEIxUXphTGcyaDMrVWlYanVrQm9iZmhR?=
 =?utf-8?B?UVk2cTB3WTlncklxQzRON3JXZk9FL3pzVmhnNFRQZXA4VFVRbis1NG10R1Yr?=
 =?utf-8?Q?i7nVlPnT6wQkHWmA=3D?=
X-Exchange-RoutingPolicyChecked: MybqSVWpVPdeB330r05bzeIIbYce9a8sS/6jGaWgNyHSueuyLfpUD/0sbogGz3cWELhMNo2fe0oc3zHsaHCQnDM88j2UyuSJon/pJYHvJMMtVPlrqRp7UGCf6UZ5Qj3h2mZKxrMnlPNw+4q5mOeioN7UsNHFEZYux6K9z/m9n+IWz0t21vafhbQF2rQgJRI4TAo9UDRDC6MtCeXIcGOxuJcAygdGIG8QpfmLJssJ+bFK4/+iweopotXDnv+g9ASEc4NcCX5Uc5AGwedXEgWGR8VR4zcVYN974u2m0oQxuZNOWNCskN+TZDVrT+jJ+PHvNXzjdrkAws8qXeV2xEJTvA==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7359f8e-6b35-4633-a916-08df02bc9954
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2026 15:21:56.0550 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /f4WUpu4ioFkW0aNH1kw6JF7WZp8JIAqh7YCnl/FDDA+59tvNslaBjD/yQdtnn6+a/FwQ5J92KpV9Jk1ZV++85b90V/mKREKMZvprGzIPDY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB8562
X-Proofpoint-GUID: zEjhniEAEr-XmM1Q1-nSHmPnfKX_tucy
X-Proofpoint-ORIG-GUID: zEjhniEAEr-XmM1Q1-nSHmPnfKX_tucy
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI1MDEzMCBTYWx0ZWRfX2J70czBQuCjO
 hunhI3VpFgIp/ZqdMzLxD9VjNO2wFfS1TcI34ViB/GUl9fHbe4sHK28gMogFMlH8t4Gy4SzibfU
 jwlu/TcAUzRlTlHvx9XKrXt0bXL/LpI3FrdvGRucUSsd6YaL2b828X+f8siW1y+p52WVLqlmwEI
 yWSNoQ+19KdghakzAAu9p9SrEDaq7DOzOYmgvk/rqvtkdY749/03XE7ujP4f8tQTiZzQuCx3G/T
 yNqwk5cs7RAGtiIdHBCdxt5/6ei7y7gQtPle7A4i/PoCQz1ZsqsGMdsiopXbVjmMofN7a1T3Yne
 XLLCP2otYh8blGuYoHkCnODPWgdTHloH9oNrkyD/wsdsu/TRdj0PzYAqDD2kXSKDhTtoM3vPLTB
 pk0p1c+lNBqo2u13pMs72MZI3hCrGgB7ffQIVZWZ4/+lrlZa/hg0FHWB5O9Xls094gSQxaORCZh
 oF6aQU3HsA1gKI5s0qg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI1MDEzMCBTYWx0ZWRfX/SNmEgo837X7
 r66RiNeMZpTCW5GRpVm2jUtXFtSwr42FdwcQ3TlC0w5gpcAL0AtBIl4XQCCrOaAQtUG09n7md27
 OHAMwNN2bTLDwR7DXIriydVFBCSCci4=
X-Authority-Analysis: v=2.4 cv=EZ34hvmC c=1 sm=1 tr=0 ts=6a8db315 cx=c_pps
 a=ST2n4ODNysMJ8B86qD7aiQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=jxMXjlTPpCISP5mWtjnE:22
 a=20KFwNOVAAAA:8 a=64Cc0HZtAAAA:8 a=z7fq8Sl8zwIsL0e47X4A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-25_04,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

On 18/08/2026 12:11, Marc-André Lureau wrote:

> The getter and setter use visit_type_size, not visit_type_int.
> 
> Fixes: 3829640049cf ("hostmem-memfd: add checks before adding hostmem-memfd & properties")
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   backends/hostmem-memfd.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/backends/hostmem-memfd.c b/backends/hostmem-memfd.c
> index 923239f9cf69..77f7eab40fe0 100644
> --- a/backends/hostmem-memfd.c
> +++ b/backends/hostmem-memfd.c
> @@ -145,7 +145,7 @@ memfd_backend_class_init(ObjectClass *oc, const void *data)
>                                          memfd_backend_set_hugetlb);
>           object_class_property_set_description(oc, "hugetlb",
>                                                 "Use huge pages");
> -        object_class_property_add(oc, "hugetlbsize", "int",
> +        object_class_property_add(oc, "hugetlbsize", "size",
>                                     memfd_backend_get_hugetlbsize,
>                                     memfd_backend_set_hugetlbsize,
>                                     NULL, NULL);

Similar comment before that in memfd_backend_get_hugetlbsize() and 
memfd_backend_set_hugetlbsize() value is assigned to a uint64_t, but anyhow:

Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>


ATB,

Mark.


