Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1727C61DBD
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 13:42:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzDt7-0000GE-D3; Wed, 26 Aug 2026 09:41:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wzDt4-0000Eu-UY; Wed, 26 Aug 2026 09:41:54 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wzDt2-0005dD-OH; Wed, 26 Aug 2026 09:41:54 -0400
Received: from pps.filterd (m0127842.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67QCCwU83332714; Wed, 26 Aug 2026 06:41:02 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=eqBVBsduV1w73aBaekCYpM5NjYE/kEsWROwuFpnyy
 E0=; b=VLhEHYkQbWWDZ65zH3WgpkH7Cy9wWGttSpCICONmPa28Sliy8uTo1mymg
 7mS8m4bO0gPzo2hJacuhPYHFPjdc+67Y/1mqCwq/glchpPn4/pACjBFcgK72mIkl
 clLtWyb8+lhKIQ7zNOwZchM2C4O3m6lhkQ3YDbYnmbxaxWpptY4ytIBgubgsRYSP
 oZ+4DDC0Oj8+KvdCvG1ExG9nO9HarS2Yo3xLEp+rf04bWOhXYGk55EpcHslBWpq1
 7ydwxdIKLEGxwvq7exsadG2OX0hpHBZiqbKc0kAzhOp4/Me2W+pnQFbo82/CLVbx
 3EZaPcoOp60STlS1ZmsdGrakS1u8g==
Received: from dm1pr04cu001.outbound.protection.outlook.com
 (mail-centralusazon11020101.outbound.protection.outlook.com [52.101.61.101])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4g97as3ypb-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 26 Aug 2026 06:41:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NqbCVAW4B1tAo0CpCWYKNnvuJ9Lw8neUxWU6PyOf6XdcxrnR0vS+l5TP2aPtjzvb5WqU2UnekqE3QGtZS8CaRyH8F+4d4zWpHBwaz2MQr1PAVehnMMvIA9GYMI8Ok13c/hlfFXcYiv9cV8ueujkOGUUBb6VOfqsUA5Ez68RxJxBBv/75fLKO0qfaf3uMP+qiNpb859mpEfv7Sgshv4lkS4eQSGQo/5Su01v8sZTPIc6fCmKbD2xgJc6fRKBMnewAbQXmAjmDKks330WDrwS0EKhtLTv29UZmQcY656fFO2WMHBqTzsDPkRqbFz2BR04J/BgH9xxpZrO/ICe1ic2FpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eqBVBsduV1w73aBaekCYpM5NjYE/kEsWROwuFpnyyE0=;
 b=q8Roxe2zqfMCcFMIeYeEwoNnO2x434+ZjVDdMTkZN0NUEQO2mGg+iCfjbKYR7Dif+HqpfTH5GLSMFzsUdc82t2rGnDBcvoI4Hu9pNwuvbmDnCJiu367kJs+73LXyVfUDiyh4dQKxLy7Hz6+lGdg+2x/xn/s1PVn1IUXwKNuns/kNhQlRfyAsQkULr1bZXjlQ53kbrFmrCG6qwj7400zJHW/Nx2FJVDi0Ic+HVTf3R4vGYcGmRaUy3gtCiwiZNvEOHhkb67ItQ9mYqIp0AaXbM+SSYFN92wZnC/oQwhJPfhP7b1iEbQBBEBmEtLc+9Aw48XVSUnCgE+XJIJb7W3ixkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eqBVBsduV1w73aBaekCYpM5NjYE/kEsWROwuFpnyyE0=;
 b=KOZTaU6S9m+bpty1GJOOgIoEgku0aa3XHanp7Oc4d5vPp09W++8dcDoubWW1zAna5wO+oIvIW9X4/AF1VBjSOr/L/HTIJlt9cJ5RNEZo58DC1KqrA2sotxnUGp+v7wRWt/sCseRm9guQEDrv85KfeWtarq4YesiOhdTtBhBefYB+8PWiOp1CfhvgySIMDQ8qPjltY/qOKS41+txdRaBcP2kxRAYxCoHOXP2VjpcNTPc0LHYRVRTU04XA8XP7YAgyAtRN/E1D4reaS/9Lh1cjTQYz0lp9eMjKrfKJyH5PIAcZFGwju6/Qr7ESR3Hlim97rHHC2OsdK/gUuxq1946b/A==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by DS0PR02MB11944.namprd02.prod.outlook.com (2603:10b6:8:427::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.10; Wed, 26 Aug
 2026 13:40:59 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%3]) with mapi id 15.21.0360.008; Wed, 26 Aug 2026
 13:40:59 +0000
Message-ID: <392d0652-2d06-4889-8b67-c199e59bd314@nutanix.com>
Date: Wed, 26 Aug 2026 14:40:46 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/12] single-binary: link ARM and RISC-V into qemu-system
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Yonggang Luo <luoyonggang@gmail.com>
Cc: qemu-devel@nongnu.org, Xianglai Li <lixianglai@loongson.cn>,
 Alistair Francis <alistair.francis@wdc.com>,
 Chinmay Rath <rathc@linux.ibm.com>,
 Sunil V L <sunilvl@ventanamicro.com>, qemu-riscv@nongnu.org,
 Alexander Bulekov <alxndr@bu.edu>, Zhao Liu <zhao1.liu@intel.com>,
 Eric Farman <farman@linux.ibm.com>, Laurent Vivier <lvivier@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Chao Liu <chao.liu@processmission.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Song Gao <17746591750@163.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Glenn Miles <milesg@linux.ibm.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 qemu-s390x@nongnu.org, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Stefan Hajnoczi
 <stefanha@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>,
 David Hildenbrand <david@kernel.org>, qemu-ppc@nongnu.org,
 qemu-arm@nongnu.org, Igor Mammedov <imammedo@redhat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>, Cornelia Huck <cohuck@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Fabiano Rosas <farosas@suse.de>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Paolo Bonzini <pbonzini@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Bibo Mao <maobibo@loongson.cn>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>, Weiwei Li <liwei1518@gmail.com>,
 Darren Kenny <darren.kenny@oracle.com>
References: <20260823150731.896-1-luoyonggang@gmail.com>
 <ao7c-FiawF9sMCGj@redhat.com>
Content-Language: en-US
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
In-Reply-To: <ao7c-FiawF9sMCGj@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA0PR11CA0121.namprd11.prod.outlook.com
 (2603:10b6:806:131::6) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|DS0PR02MB11944:EE_
X-MS-Office365-Filtering-Correlation-Id: cb593065-1080-4368-3204-08df0377a972
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|23010399003|1800799024|376014|366016|6133799003|3023799007|10067099003|56012099006|5023799004|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: W0VxSkH3rg6P0/beNqECgJBGbps1kvhz/puZLTMAW/scnQ64bKSEiclFJ1B7xuCN3yjTN11op7c7E8QVj8XLiKy3S70gyWlTIQyrqR3IFlSOfBTvCkquckzOysqt7t5hDlQ8DZ0rsR3hBvsktvp83qgKltUiHWueU/WsAmcqWD8aLo1kL/fMusmiCwQl/zvEj53f7LlIhE1P9OoKo7Q9GnP/CkMTUmjka8dfVKmAEZuO1Q9i65QEx/MtPMJz8H3BABMqugv65HcsvSYdOO0rbXo9XY9GWrRN8852ExRO7Hl7MmaWIAWioZ4TuJZU3/mVfT124z3uOlpiHsXNo60OdspIjgx5BLni3dGwr9cUVhn/McM7kdJ4Y5udVLvEu/qVVrb1pEBHrR+u9bCyMCtVUbKZvOaPSCMq9+NA6e67HS6cq9zrZBhU4+ylPA5yLZsx9cTogIHzLEj9GmTTw8lcm7XNhD+M2/Epi1iZmDYqNyigqYfTlZUqPmLASTn6YqHuRJcDtpMr72W8bmHC51fyTv6njGtPa0NADd/YJNGmGj8yn7cPywArj3XZj3AUZHwKvj/lIrN/HFoUFjFrf3idHUwOJSF661OoSDiHbdXae7Baeu1qFjXwtmuhS9PoZ2yemB+/C9UN6rUz2ZDW/oclz+wyDtbICPhwPh4/R9xoi+M=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(23010399003)(1800799024)(376014)(366016)(6133799003)(3023799007)(10067099003)(56012099006)(5023799004)(4143699003)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Rkw2VlhGYVR0RFVDeFRkVm9SYTJoWG1iVU1qSmlocThDSXVYWk05MnRZamk1?=
 =?utf-8?B?N3RjWk5VU1d4Q2h4bXMvaWt5eGVxajBzYTYrM0NOYnhPNVgvSTJiWCsrRWty?=
 =?utf-8?B?bkc4TytGdlAyeXl1Yzh1QmJuWFlKYnFMejZzeHRZaGVtZ256WVpIcXVSZ01T?=
 =?utf-8?B?aTdVcG02dlkrenBNeiswVnh3U3ZnOHN3NmV1Rm9ncXJvZWZEQzlRZERzckVQ?=
 =?utf-8?B?WXNaSi9Sbmk5MlFSOTdVbzYvNUw5TWNpSTN5YVF2eUNTT3ljSE5PbzF1THBl?=
 =?utf-8?B?Z2JpcmVtYXY1ZXJtbUY2MWJzMDJ0ZGlCU3NJVERXeENXMnBYQnNkSUVkSGQ2?=
 =?utf-8?B?OVI1azlHdkdHS3BMZHFBM2RCeGRyR3JtTUp1NXFmNFpCVENTOGlGSmxINVlt?=
 =?utf-8?B?WGZ6YThLdUlTN0k4RkQwTEYyZGEra2pCREdVWFQ1aG94bEFxbE9kUGpJWThH?=
 =?utf-8?B?L1habGhndTBJTzdrakFkR0FTRjZrSGpkZUVSQmUvRjNCZmNBNGpwVkNOUVJw?=
 =?utf-8?B?SVg1YXl0cEdxVEFFWFl1ZWFnOEwzMU95OVVRdjdBbjNERFNsMVo1eEl3YVJt?=
 =?utf-8?B?T1ZQYW1ReW5ub216ZkJDNFdlN0FxbFcrMmQwTkJWKzRRMHd2bm16bHRvR0U3?=
 =?utf-8?B?N2k5NlVudDdLWUdyOWduZnJQN3JjM25ocDVFRVhnbCtpL0FFcjB1RGFOMzJC?=
 =?utf-8?B?UUdSS042M1ZQOS9zeHZubHV6eTBzc0JVZ3FJOGpMQndrZEhBcEFCeXd2OCtU?=
 =?utf-8?B?RUN1eW1WMnlqbUkzZi9IalBpUi9aT2VINWdKakxTWFNaQi9CUFpJR1NYSkxL?=
 =?utf-8?B?Q2VZQ3J1dXZwN1hQZG9yQXNmN1VobVVhLzlqZFBuVlh6V0h4WGs2OXRkeVMy?=
 =?utf-8?B?K244NlF4ZEMyMjhlUE9pcDFud1MxRGhGaUJnZHAzcFJEcDY2K3ZvMldTKzE3?=
 =?utf-8?B?Nm9QYWU0RHBOalIwSWxyaklhbFVDVVRMV1BsMU1Kc24rS1B3eFRWN3hyU2R6?=
 =?utf-8?B?SnJZcnNodkR0S0o3eTdrYk5pVSszMWU1cjVkalNxNUNlaWpsaGhjaTBiRTRp?=
 =?utf-8?B?OHFuanh1c25pQ1pYd2E3QS92UlA3NVhiekJFeTF0ZkRhNTBvOGdvSVVPMlpK?=
 =?utf-8?B?N0RyOHRLSDhMck1PMk04UEtPYm8vNC9NLzF1bDUreGtpcDZ2TTk4T0hKdUp6?=
 =?utf-8?B?aXQwaXdQcHpNbWpHdnQ3WE1MRElyWFZudFZ6WTZqQStqWFRFK3dmbFQ3d3FC?=
 =?utf-8?B?V2Q4V0FxUEQyWENKV2d0aUl4RXVJQUt1Nktlb1ArTVBUN0tiMGxhYUM1Ly9L?=
 =?utf-8?B?R2VqNXJ2Qm10SDFjdWxicGVVTUZPbmNlOVdWWEZKcTJacVZnUThsOGJOOEtI?=
 =?utf-8?B?bnphcDRobG5aVTBTREVwaVExTHY5ZFRjaXl6MVAzTXRiTFRtazFMdWYyMHA2?=
 =?utf-8?B?SmFPQ2JiQnp6L1Y1Wk9hUWI1ejdMMXFQSGhVRU5PN21idmpGWFdZb1I4TXo5?=
 =?utf-8?B?a0FsUFBKbzc0VlNBNXZOY3Y1b1JrUFBHODRjT3NGa2IyZDQ5U05ubkFxc3pS?=
 =?utf-8?B?eWRiZW54KzFYTlRJMUlpaDRIZFpXRk9aOEFnejd0MkpTZDdKbGdIcjVxcDkv?=
 =?utf-8?B?UGptK2g2RjZOc2EyNlF1eEl2VytkdWRhTnEzSStYQTdLcnZBWWdxVE9EQ2Vu?=
 =?utf-8?B?OURHUTFJOFZRRUdkWjF3b3kySGR4UDlpT2hnT3Y5MWg5aEhKNTEzVzRHZFZn?=
 =?utf-8?B?WlJYekRiYXFVL0tqOEd1eDNLSDN5YlVXY1VKVWxWOWRxa0ZncFpKa0tYaHlI?=
 =?utf-8?B?Rk0rcEpsV0pwbXBsQlk5M2R5NG8zZUJFTDU0TTBxVUM1aXFGL21tR2dvTEFC?=
 =?utf-8?B?VTZpYTZBd1dxb3lZWHVXWHFLUWNuZXdvRktzQjcycmJxMGFtdHhzQ1JoLzdW?=
 =?utf-8?B?SHhzeGxCcTBpUEtTNEdFTkpvdS9md25ydlVZTXI2NHMvS1gxckFTcVpBWW55?=
 =?utf-8?B?T2gyMVJjS2phU2pNTExUZm9UR0VHd1g5VC8wQ0RFOFNGWkdTTEZmL0pML1Fx?=
 =?utf-8?B?QW5scFV5d3doQ2wvOWlSTjdKdHFaWjI2NnhEcWFTbENDUHh3eUlFV2Z1ZWxv?=
 =?utf-8?B?bHNaVnd0YW5landOdklTQzI5UnphVzdMSFVYMEZOdWtsOG91QlpvUExDdUhM?=
 =?utf-8?B?MlR4dlQ4TWlaWWtvdDdjS1NSbmtlOHYxWjNmY1phcHgvU05jODgzSngxbWd2?=
 =?utf-8?B?K3dmbXJGQ2pYSmE1elJDRVpaZlpicHVaTHhyYU0ycW52R0ZCQVdkVEs5c05w?=
 =?utf-8?B?dHlxYktBRFlqNUZQbHp2TnhwWitYQmdmWTk2anZFcFFsQ0VZTGFnd1ZqTjRT?=
 =?utf-8?Q?hDCVJUw3yE2EzDbA=3D?=
X-Exchange-RoutingPolicyChecked: DQF8cH3CqvYrVCa20Q8PqTr/Q7tiVT968TwV41fVUuYelqG8xEYRuVzpw3u1YO1aPgxjTM70wb6EnJrVl7KcIfMV909z1F7ju2pwhEQrUwsSK3db2L+dj1xY+gPLn2yO2RMNBNgIRrZep++PIPYoUasl+PCXedjiczpoOaeVASAQIbNtXmWEcDdbc7mepE+21rF7GlH6oZ6jIV/F9iF5AnLhMKxhkaRFlEwmtuksWFStjXQYTG4WiFP3mC1LrRpdWd5CGPAm+z8aNQTLobGfuIskQt3lHUzPXe8mV1Yp13kNwH9c7gyP4TmlD90NmfskI3Z8Gn5H2a77ihoC457LVg==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb593065-1080-4368-3204-08df0377a972
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2026 13:40:59.5327 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iysz81jMvmlQZ/mkbpsBUQKdQlf2l27oReXiiOvDDtq/qm5pTNf+q2awXTGSliNORP988tua6jlX4K9GBemF075uHxFOSQnDB9DEGcp8Ues=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR02MB11944
X-Authority-Analysis: v=2.4 cv=DJu/JSNb c=1 sm=1 tr=0 ts=6a8eeced cx=c_pps
 a=ONVPZRIUl3/knk75a7oMmQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=VUi8bpU7OL1Oj2-RSIOF:22
 a=sNYJANv_GKfWQMPkHx4A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI2MDExMyBTYWx0ZWRfX5DqBlUH4OkJ0
 uw0m24/RY4pvjlZxuRjWC/s7vHEQNQEGjQ+jsl4uFT28qYBBUKhbnbiA/1V7U1ehduE2WMkzcjW
 VfmD6zE7eJl/kfZTc2yCODWzdTYOu9c=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI2MDExMyBTYWx0ZWRfX9sMtlHLMi1jS
 l3doAEB6jSCVPj35cchfZHNrqfuuVz5VyhZs+OXInfV5lnkc7pNJYvrGsOQjvUzXvBGyFgUlrFz
 FeYj4UbmlabkEjkRXiGng2lkoZCvY+6a5WUfx0ECy+IUi0f5bXuB/OGBjPVEK2Vz6Bs5UaTrQ0S
 131cNUtXUm2HXuNVOVcQzmsdjzJ3p/s/J5cxujALgGt3Ti9ZI9z8CvUX0LKN5A2TUS+ATeegWzU
 NrZXM1bSJ6DD/iAriTorJPISLVGPh6xrFbM1aRhT4kRJ1LDL591jjC0MAh3Xmci4z1CbbKqcvCr
 jpjagu3PJIuQbnyt4i3HVQ0xmuzYmEpZrbel+YruLypNB7gJxszrf6KPPezfMoc1h2gmko0wETF
 9ZypIgppmHSsL1O4LFAOfQ0RG1Vg32ZWBbTJzPzFzgI05JWLhpdVVqQDXaZLGEaGRCO1AwDDeXZ
 Bq0teJAy6zkFE0o6WIQ==
X-Proofpoint-GUID: 532hq3OOf0V9G87gklqTi4EmzFUX2fKY
X-Proofpoint-ORIG-GUID: 532hq3OOf0V9G87gklqTi4EmzFUX2fKY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-26_03,2026-08-26_02,2025-10-01_01
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

On 26/08/2026 13:32, Daniel P. Berrangé wrote:

> On Sun, Aug 23, 2026 at 11:07:18PM +0800, Yonggang Luo wrote:
> 
> snip,
> 
> ..to comment just on the end result for now..
> 
>> The last patch builds qemu-system (and qemu-systemw on Windows) from
>> aarch64 common/system objects plus RISC-V arch objects, and installs
>> qemu-system-{arm,aarch64,riscv32,riscv64} as symlinks so argv[0] still
>> selects TargetInfo.
>>
>> Examples:
>>
>>    qemu-system -target aarch64 -M virt ...
>>    qemu-system-riscv64 -M virt ...
>>
>> A basename that matches no registered token falls through to the unique
>> default. A combined binary with no suffix requires -target when more
>> than one default TargetInfo is registered.
> 
> In testing and comparing  the new qemu-system-riscv64 symlink
> to qemu-system vs the current standalone qemu-system-riscv64
> binary there are some significant user visible changes.
> 
> The simplest is 'qom-list-types' went from reporting approx
> 770 classes, to reporting approx 1530 classes. IOW, the
> qemu-system-riscv64 binary is now reporting supporting for
> all the classes that were unique to arm.
> 
> The '-device help' output similarly shows a great many more
> devices
> 
> TL;DR introspecting qemu-system-riscv64 is no longer accurate
> wrt riscv64 capabilities.
> 
> This is not suprising, since we register all TypeInfo meaning
> we get all QOM classes present. Some of Pierricks patches try
> to filter places which iterate over classes, but this does not
> have full coverage.
> 
> 
> I think this is probably also what leads to the increased RAM
> usage in qemu-system-riscv64. Starting
> 
>    qemu-system-riscv64 -nodefaults -display none -M none
> 
> shows an increase in RAM usage from  17.3 to 20.7 MB which
> is about 15% increase. NB this is dirty, private RAM per
> process. The shared RAM pages also increase but that's not
> a concern since they're common to all QEMU processes.
> 
> qemu-system-aarch64 shows a much smaller RAM increase, since
> it only grew from 1430 classes to 1530 classes.
> 
> We have many more target though, so if we assume the end
> point where every single target is unified, the the union
> of all classes for all targets comes to approx 3600.
> 
> My guesstimate is that would mean a memory increase for
> qemu-system-riscv64 from 17.3 to 39.9 MB, which is a
> 72% increase.
> 
> In absolute terms this is still modest, but for deployments
> with large VM counts  and small RAM sizes, that gets to be
> significant.
> 
> 
> None of this means single binary is a bad idea.
> 
> 
> My main takeaway is that we're creating uneccessary work
> for ourselves by trying to make 'qemu-sytem' identical
> in behaviour to qemu-system-$TARGET.
> 
> The complex filtering patches / QOM interfaces that I
> found uncomfortable in Pierrick's base series are largely
> around the filtering needed to simulate qemu-system-$TARGET,
> and they're still incomplete. I don't have high confidence
> in our ability to avoid regressions if we go route this
> route.
> 
> 
> IMHO we should make a clean break with the past. Leave
> the existing qemu-system-$TARGET binaries being built
> from the same pieces they are today, such that there
> is better confidence that we are not making behavioural
> changes to them.
> 
> 
> qemu-system should be built alongside qemu-system-$TARGET
> and offer new semantics where it is documented as exposing
> everything from all targets whenever introspected and does
> not apply target type or target Kconfig filtering to inputs/
> outputs.
> 
> We still get the benefit of only building most  .o files
> once, so keeping qemu-system-$TARGET is only a small
> overhead in the final step of linking everything together.
> 
> 
> qemu-system will still have the increased memory overhead
> but that's fine as qemu-system-$TARGET will be unaffected.
> We can tackle the memory overhead of qemu-system at our
> leisure through use of loadable modules, and thus not have
> that as a task to think about today.
> 
> 
> With the clean break with the past, we also have the
> ability to tackle various long standing design mistakes
> present in qemu-system-$TARGET instead of carrying them
> over into the new binary.
> 
> Specifically
> 
>   * -nodefaults should become the default
>   
>   * All CLI args should be processed in order from
>     the command line, so we eliminate the nonsense
>     where we process some -object, then -chardev,
>     then more -object through hand crafted deps
> 
>   * No default machine type

I would even go as far as to suggest that we should make modules 
mandatory for qemu-system, so that devices can be loaded upon demand 
during machine construction to help keep the size down.

I'll leave whether that is through dependency tracking or via an 
explicit load directive for someone else to decide :)
>   * Drop all legacy syntax so we only have a single
>     QAPI based way of configuring.
>     eg drop -hda, -hdb, -cdrom, -drive, etc
>        only keeping -blockdev
>     eg drop -mon, -monitor, -qmp, etc only
>        keeping -object

The only problem with this is that I often get a lot of complaints that 
QEMU command lines are complicated from retro folks who just want to run 
their favourite old games. Why would they want to come up with a 
long-winded -drive command line when they can just use -hda instead?

> We don't have to do all that straightaway. If we declare
> qemu-system "experimental" initially we can iterate on
> that intentionally breaking compat in releases, without
> any impact on qemu-system-$TARGET.
> 
> Avoiding the back compat task will give us more flexibility
> with the follow on work when people come to create new
> machine types with heterogenous CPU targets.
I agree that this is a good opportunity to explore new things without 
being tied to past decisions.


ATB,

Mark.


