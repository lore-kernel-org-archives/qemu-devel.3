Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91CE6CCF2C3
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2026 13:11:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHhin-0007A0-4l; Fri, 16 Oct 2026 09:11:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1xHhil-00073w-7v
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 09:11:39 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1xHhii-0006rX-KO
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 09:11:38 -0400
Received: from pps.filterd (m0127841.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69GAAK4X2708556; Fri, 16 Oct 2026 06:11:24 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=BMnU6qDU/16KVsRWKCl6RrKVFguDJIGjS7N6Q4eZT
 DM=; b=RStWpkRspVKJrjzXQNAGtzYILw+gUnXBsOtlrnUskrMq+9Xb4ji5r9f6Z
 QL+JaRpCEtBHl9C2ezqlj/Q6VLJlfRLD0KqF9yhCFlm13bSLnaPxypdCx7CEuXfA
 CqG0S0mgrRuFvahmXpvF0Gg7lWd3Y4QEap6Sc4D8vVFrMouw/aalxSYsvbrtjKEn
 /LGPhd7VPshQ5qSztZtf0hqGk3ShZiw32TH2Vv3kp0goIn5e0V1i4oFmmLmKWgLo
 FG6lBSmrptmHKEz+ITN0xFDzJizeOSW+MpBWor1z/FZ79ybqVAmPDRcBNM504lbY
 clR/ONankG1SVhJR/AWwcjSULN6wQ==
Received: from ch4pr04cu002.outbound.protection.outlook.com
 (mail-northcentralusazon11023091.outbound.protection.outlook.com
 [40.107.201.91])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4hb045jvp2-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 16 Oct 2026 06:11:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vErnfX/hTuypWl6UkFFsh3P1hZEhkmKwG/ioQ+wTFlPURJmFWhdGyW1m+2uB+Fgm7DhPjNcNcovs6CaGED/JytK9Y6SiplovvbZcsKt+Yaz5Mxbgybokk04EylvJXzhLDbP8l+FZXKXu80gA9FC3dayjq0+gAnSbLXODdSkVpHfKG6AmuJBFcRDLjztPgC0gjimA98dMF1lfHkDSmgKuJ7Clm+Xv6OLPi7mAfVCgsrzY42cJGryH8GQ+GxIGVCQ4KF9xCHaIDOu/PaWMQPXqQQMXTxGih8ZSqfT/LQjkbqn18LEyMNRJ8a2VrDEBbnXp5KpiHayuYZ4QBhS/I5A5Fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BMnU6qDU/16KVsRWKCl6RrKVFguDJIGjS7N6Q4eZTDM=;
 b=tOniXhPER+1OuXcLGrL6Jn0HbYJ85ps9onfleTLpL5eiY3cs5kHgw+qkRYJUOiZ0bSXxanN4CQBGhVwr/gnxdLh6Q8duf92n9d4KqRZmjeBp+9c6w9+FmnY7Ei58tJ3yMswd3Y1sEbPYgsIz3cpMr5rEWE45m6I94/SW9PHIIsHO3FYqagfgBMkBUCL5wH0djOSf/L4SChdU2G81wA/Tnkp4pa0iSGXUER8xZla17oUdbWM1Xqfq4x0W1Qkab7u64VmqqqzDvHyYj4IS9aeaqZy6za01DF1ODnMJqR2jYSKnpM8aq9Thcrqb7dNCNTkO+NDiw3r+2LDy7wxiiu1mxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BMnU6qDU/16KVsRWKCl6RrKVFguDJIGjS7N6Q4eZTDM=;
 b=zHHnoq6UZa37TgNf+gCz6HdBXH4Yi9aBXbIpwLbIm7l0cuQ3EkPQjGNBH4jIfhcGYi/50Sv8JDOJAbm4uVVMqm+El1qRnXxaJ/BLQR+3N9Itb7muORgklgpQ4Yuoa+QJS+7ZRYGxEZZiPdJoQCui54mZmsvfDKr33CT+H2p+TCnThlW5rxIg/saSinEM2ZIhXnhko2WBAQ1UVBAfc5cUn7gFKqK92FcHIJoRqku1UpLFD6qH6Szhb3niHMmVblJ2knZoUDAn0X1Yyib7HzLVZEbFOED4iFnFMNq0NpefI8Tu2QTVfbNnmq8aNKqIfwBgXh/g5Mii3VwnTQZiFH7u3A==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nutanix.com;
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by DS7PR02MB10964.namprd02.prod.outlook.com (2603:10b6:8:258::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.14; Fri, 16 Oct
 2026 13:11:22 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%4]) with mapi id 15.21.0522.016; Fri, 16 Oct 2026
 13:11:22 +0000
Message-ID: <e8e3be79-23e5-40d0-8843-6ecf2c82e196@nutanix.com>
Date: Fri, 16 Oct 2026 14:11:19 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] include/hw/core/qdev.h: Fix where
 device_class_set_parent_realize docs suggest putting parent_realize
To: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
References: <20261015163352.1751191-1-peter.maydell@linaro.org>
 <atEC-pIGhLYLXVmC@redhat.com>
 <CAFEAcA-wEB15afO4Na8+8cF_Ja3v-8ewd8EdPavxJbfTmrL9GA@mail.gmail.com>
 <atHrFXxyIl3Nbvht@redhat.com> <atHu0kCSQTD9E34p@redhat.com>
 <CAFEAcA9PTB=1V_hV1P0xpEW4aY+4LajYyzKzyTOJj=bb9=oPvA@mail.gmail.com>
Content-Language: en-US
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
In-Reply-To: <CAFEAcA9PTB=1V_hV1P0xpEW4aY+4LajYyzKzyTOJj=bb9=oPvA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR05CA0011.namprd05.prod.outlook.com
 (2603:10b6:a03:33b::16) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|DS7PR02MB10964:EE_
X-MS-Office365-Filtering-Correlation-Id: e51d5009-6bca-49d3-4add-08df2b86f9bf
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|6133799003|22082099003|18002099003|10067099003|5023799004|261009223027099003|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info: rCMW7sNOZcpeVgnuBdOdCUO4IflxQkv/j8bqbxJmR9b3yaDAKwi7UZBeyPTwwAxcXUFvKv2qsFcNZx9UxF49n81jGDaqztKI39yOi8wM21a/emxdLggUCbUoWiqDFZGYZBUlaCLP/yZb+7B6S2M3ZKYANmA/Fp3JxnWnu74q8iG8UXDPelHYVAlcDQKVdtDaSqvnkprttVaMd40I4g8D6u3mvy4VyV/xOuOdX7tamPIAChUboFoOmn5EwWmRuUe+1BELU0sYgVhn/5zfopLstFH2tL0G+QWRgWD+vNIiZSrPb1H3nXfCwq8T14th0rgGC5rzqg0QWTR5DZKPpYfeWzLHAsjG5xZ5AhM9JYUXiID8ij/2P969UDIPhiu3NSms8N2ZKa2T6Vy3sFwn3Qdti4bhBvCAT1wM09LCSUgze4sPNC+JsQwHpnvFnRzBZEvQ8sXGPMwQxKl5PHL+/09okGBdL1iFY+Is5Xscuhwg2AwqdVdKt67IB/7Kv2+bT+EtfjncBZY+0Z8/mnZ5pu/mjlnIB/tJwnxeKahQIWBGSU42ZMIDQbbfroH5frkbwv6koMfmQJimdQqJh6NN4PvkT8T6Jf4TEq79pfjlDE5oiEXjttqzBjPQgluTFO9/1oEQ3Hs/YKHxXs8Gzap6jBGec8fkQ5pryd0i9LwddHH2khc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(6133799003)(22082099003)(18002099003)(10067099003)(5023799004)(261009223027099003)(4143699003)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NlFHRGgrclFleGREcTdHUzRvbGZNMW1Lemg4by80VWpHZG00T3pLMTlmYWU2?=
 =?utf-8?B?ciszQWxOdkJJeW1jcUMwdDJYdGNQT3JmM2pKbVJYeGdSSHRaSklEVDJtSHI3?=
 =?utf-8?B?aG9VMEVaMFhlY0FUMjhYc2ZJc1FxS09uRUwvdGZwL05wdzdVY3liNG0rVG82?=
 =?utf-8?B?WFRmQ3U5QVRyRWkyUVhxVjNoV21GZ0RrcE5iSjVMakQ3akFqeUpmTnR6b2Yy?=
 =?utf-8?B?ODNvQVNTUUNNUFdSTS9aYnlyaVNEQm1VVTZxa09ta053eEhvT3VlQVN1QkE4?=
 =?utf-8?B?Zm12VWoxQkdjRlhjMGVrODZYblBUZGsrUlJxZkQ4US8zY0MxOUh6cHVtc28r?=
 =?utf-8?B?Z1dIcHhPUnZ6UXFURzhpYWg1MW05ZlFiZ0JTQlhpc3RxcHNPMHVjR0hFVlpB?=
 =?utf-8?B?ZVhBcUwxRFpaWXdwbndSMWsxd24xTXg0QTNyNHg0UGZ5NFR1VjBxZkFWdmZ5?=
 =?utf-8?B?NHF1cG1FYnZNaVFqZDF3SExqeGM2MC9jNW10aXg0TEJjMFAzaHA0Z1FVWmdD?=
 =?utf-8?B?d1ZLSzd1dWUycTgyS0g4L1NZZUk0WTNlZjZ0djZETUhjNllIRW52cWxucnAv?=
 =?utf-8?B?Z0EzOEtqV2ZKdjR1ZU96cnVFRjJjSlgxMC85bjdSWnloTmg3YWtpTFpkemFD?=
 =?utf-8?B?M3pHQjVnbklER3FWcjdxYnJDL3FqdWhGaVJLVHB4aE9wUTczNkRwcFVrWjBQ?=
 =?utf-8?B?ZjhLTDVMUGVQczFzbm5kYy8rdWFnS000ZHdjMVBvSmhLV3Zhd3huTjNzRlNx?=
 =?utf-8?B?d3ZvZUl6TkVDWHE3WENXeUc0Um9peUp6dDZFOWZ1ZTFrVTdKS1BEOE1UWnNq?=
 =?utf-8?B?Uk9yYitDeXBPYVUrVFZya0lGNFhSYyt1NWFhTGlSV2hiL0d4dVZKRE1QN0VY?=
 =?utf-8?B?ZVpsLzJ0MEkvSFlQSTlnd2xzZS9zUUFTdHRpenI5UHJubEhsZG9xbDJHTmhJ?=
 =?utf-8?B?amREOVhnYmhFWWptVG4vQ2FSYzFUa283MmFlaEpXSU5Femg4N29wMi82SDJZ?=
 =?utf-8?B?bk4zQlhJQzlYbXRxYTZtMXE1Q0Q3N2o4eWxETDdXWXdBTVk1bHlIblNmM29l?=
 =?utf-8?B?eHU2M0hncUdtdUFEbnNzUWVZME1hRHpXMmNjQ00vZVpEWkI0VWFUWnZaUVRk?=
 =?utf-8?B?dUtJM0t5SkxURVhnWmwybEF2cmFSb3dEbFBwUmlOM05TcWc5bUlscEtMb3Fq?=
 =?utf-8?B?YjlkVXNWOGprNGtRZllicEYzVHFGNTcwY1dONmYwZXJLd0p0RFVobGJabzdl?=
 =?utf-8?B?Tlk2ditXYllJdTVUTzE4cHdjNDFYVWF6ZTYvWGd0UGE2YWZHd3lyK1AxV0Nm?=
 =?utf-8?B?d0pFNFMrcHpNZitHbkJWZER5Q0llK243Z3ZCU3VJYk9ZMnhiY0lhdmowSndv?=
 =?utf-8?B?RVhYOWdNTU9OR0kxczlCTHVtajVySUNaSUVicGpqRW5ZQmRHaXoyVW12bFRS?=
 =?utf-8?B?Ly9yOS9Oa0RMYzFCWVBIb2FveThDcUVRb2dTdG0vNDhsR01Fc1RrQUJBVGpl?=
 =?utf-8?B?V01Rb2M4dDJUTTNXblY1anUyOUh1ZEJ5MWhCU212R1BRSEJoUmJBZGZiMGFz?=
 =?utf-8?B?NlpHTmxiNW1GbnkvQVBBQ0ovZGhJUVpGWlBDK0JyZTBuR0NaYlVMY09QckFN?=
 =?utf-8?B?bi8yTGRwNWhGeU9FUmE0ZDBkRlB5QmpBZG1JNjRoQk55OFlKRjE2SGRzell0?=
 =?utf-8?B?RVhtbUJ4ZzYydmhmVU9OY1VEcGxhWGxCeGM4bjd1MWROR0VLNnJLbTBjaU9H?=
 =?utf-8?B?Q3NURzV5M3FyM1lvZ3Z5SHdmQUNLTGxYOXp2SG9nTC92V3QyUis0WkhEcFpT?=
 =?utf-8?B?eWoyR0JsekRuVnNQUUR5eDIxZTlTZDJIY0xJVTFhRDIrdmwvUThFT3ZQb3JW?=
 =?utf-8?B?bG1zTXlHSnlscmxzSlZwUHYwVmdKKzNSc2x3cVdPN1BRRDg1YVNGL0tPeURt?=
 =?utf-8?B?c0NNU1NEWmtXSEEzd3NVa0FZTVREN054emlJNTc5SCs0dCtLa2FsWVpGQksr?=
 =?utf-8?B?ZzBQVCtROHJDV0IwK1BVdXFxQXozK0JZdGhmSVA2OHoyeWFQbnFJcURqcjN6?=
 =?utf-8?B?blI3T2lSR3NLOGY3WDY0N0E4bHJDQzcrUExuOXd0YVhwNWJ6S2puKzEyNGNV?=
 =?utf-8?B?dFBja3BNSGtyc2pLbWhSUmVEaFpRRjdnRXZUV056b2padjJVeFFaMGxkUGIv?=
 =?utf-8?B?THN4RHVtZGl1TWZxWklqUFhaS2dLallIbWdSa2crRHF6bW44Y3ZLVkVia2p4?=
 =?utf-8?B?TytJY0J6UGNBRWViWHFoSVNVSVBuVURHZUlLZTlVOVlHMHZzb1M1ck1tSzNp?=
 =?utf-8?B?QnlNcWd1Slp4OG5lZXg3VnFhaXFHcS9CSXJJZXZTMFRhMG5CM0FGc21tamwx?=
 =?utf-8?Q?QFuUVc/aDOmMfMB4=3D?=
X-Exchange-RoutingPolicyChecked: JyT2slswZATOsxoNXFyiIhr/ki8kaOHkoOpa2uwNppFgZnHZyPh0sMD5MjnQa7NO9ZoF857CtKpMVglsmrD5aty40mHAYAG50gpRvG+++XO67AeCOxo6BdP9wLpq6C3lOLNLlmw2dMIxrrOOrEosEEbKTm1YwDZnea8VDjYqCCoumQFQU9m2LEwIM/HfmbSKzm/Eq4+xzLaEH+Ns5eVat9UTHfEAZ1JgGDGmhS+DBzDfWD+gNzX/8bqtjvkgzX0QtGxtj6Kj9c0hMwAb2ulTls/gnkLlOu3/+huA9XLW0WTHcMP0J65zxweGl3I5rv9kOSJIDyp2EdmwfGrq49Mcog==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e51d5009-6bca-49d3-4add-08df2b86f9bf
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2026 13:11:22.6488 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lxWWg2N/2eQv7vUdWNaAq+2/uBYr4WiBMiEEH5O65ZbQh53kpxbyZVBE5g48u2ggHjpM4ylaz7X8anVw3NCWR7NGpLhOLtjmfY5Yf1MboVs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR02MB10964
X-Proofpoint-ORIG-GUID: czKWUi0bFXj7u2eVMO2CVbwBz7HBpGTX
X-Proofpoint-GUID: czKWUi0bFXj7u2eVMO2CVbwBz7HBpGTX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE2MDA1MiBTYWx0ZWRfXwKZ1dOpkd35g
 Tchgojz5lQsCTHNZzzPsN22TIsmcyp1qIVm/RuW6uDo/2qqhiydwdMgbKiT5jj1HSnsS76MS8+q
 zPyXu1sFVeQEnMWmhkn5YpQrUGWbWqTo5+4EbyXfaMyj257jaCQ83MV42EMFjqQI/JLeJTRa3ap
 mKF8Ey5pVPc+3bUKr/1r8Knnq/4X5weUn6NjqltLwz/E0RZBkCS/0OzR3I4cR4aBSJyXfM3IvoJ
 //gZak2iCWMipwys/9rDA63m7dLKULbvXxYSBn9aeantC01etcZIK+KPsb+00LtRv6ii3mPKopk
 EXDRISzGOe+2bN/qVz+rsdD+Q375nl06YH1QGoLQgxrXZ/MNPUtR5XLywcdn+iLTXnxsv34mAuR
 wg8nFtZp43qsSTlbe4wqjJ/iKlHl2Wl83gyMsJd5FKipXUBbrAd4PA2kFxW7CCFsjF2VMLy73Sb
 KJQA7fHdPdyAbAVo/yA==
X-Authority-Analysis: v=2.4 cv=V/ToQuni c=1 sm=1 tr=0 ts=6ad2227b cx=c_pps
 a=yYYKAKAKl8D9GxIYT1WzoA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=jxMXjlTPpCISP5mWtjnE:22
 a=20KFwNOVAAAA:8 a=5n5VLQebN_n3QGx3QTYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE2MDA1MiBTYWx0ZWRfX6LGhFZ/2AM/B
 aFQFw/Zk6AJbxtcJQOg5yBpKKJ2H2xxXv4V1L8qNCo2nm6gRFNQJoS37JH0JKccR05aV7p7AHE5
 G4Yy1zXiIz2jmpAHQv2Lk8m79vMWF3Y=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-16_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
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

On 16/10/2026 11:14, Peter Maydell wrote:

> On Fri, 16 Oct 2026 at 10:31, Daniel P. Berrangé <berrange@redhat.com> wrote:
>>
>> On Fri, Oct 16, 2026 at 10:15:01AM +0100, Daniel P. Berrangé wrote:
>>> We're overwriting the DeviceClass::realize field in the class
>>> struct instance for "pl050_keyboard". We still have the completely
>>> independent class struct instance for "pl050" (which is what
>>> object_class_get_parent() returns) that contains the 'realize'
>>> field value set by the parent class.
>>>
>>> eg if I put a break on pl050_kbd_realize():
>>>
>>>    (gdb) print pdc->parent_class->parent_class->parent_class->type->name
>>>    $5 = 0x555557de40a0 "pl050_keyboard"
>>>    (gdb) print pdc->parent_class->parent_class->realize
>>>    $6 = (DeviceRealize) 0x55555585db67 <pl050_kbd_realize>
>>>
>>> and separately
>>>
>>>    (gdb) print ((DeviceClass*)(object_class_get_parent(pdc)))->parent_class->type->name
>>>    $7 = 0x555557de3ee0 "pl050"
>>>    (gdb) print ((DeviceClass*)(object_class_get_parent(pdc)))->realize
>>>    $8 = (DeviceRealize) 0x55555585daf4 <pl050_realize>
> 
> Ah. I didn't realize you could get at the parent's class
> struct like this.
> 
>> We can make it a little less ugly in the callers with a macro in
>> qdev.h thus:
>>
>> diff --git a/include/hw/core/qdev.h b/include/hw/core/qdev.h
>> index 8e91e2fcb08..18e85850c31 100644
>> --- a/include/hw/core/qdev.h
>> +++ b/include/hw/core/qdev.h
>> @@ -461,6 +461,9 @@ static inline bool qdev_is_realized(const DeviceState *dev)
>>    */
>>   bool qdev_realize(DeviceState *dev, BusState *bus, Error **errp);
>>
>> +#define qdev_realize_chain_parent(dev, dc, errp) \
>> +    DEVICE_CLASS(object_class_get_parent(OBJECT_CLASS(dc)))->realize(dev, errp)
> 
> I'm tempted to suggest that we drop the 'dc' argument here and
> have the macro get the class from the dev:
>      DEVICE_CLASS(object_class_get_parent(object_get_class(OBJECT(dev))))->realize(dev,
> errp)

Even better! So then we could just do:

   qdev_realize_chain_parent(dev, errp);

in the child class? I can see this would make adapting existing users to 
make use of the new macro really easy.
> because I think almost all realize methods wanting to chain back up
> won't have the class pointer to hand.
> 
> We could maybe have an extra layer of abstraction here such that
> you write something like:
> 
>     parent_invoke(DEVICE_CLASS, dev)->realize(dev, errp);
> 
> Or is that trying to be too clever?

I'm certainly leaning towards a simple-is-better approach from the ideas 
being suggested here.

>> +
>>   /**
>>    * qdev_realize_and_unref: Realize @dev and drop a reference
>>    * @dev: device to realize
>>
>>
>> which would be used thus:
>>
>>
>> diff --git a/hw/input/pl050.c b/hw/input/pl050.c
>> index 48df2734e26..abe939171f2 100644
>> --- a/hw/input/pl050.c
>> +++ b/hw/input/pl050.c
>> @@ -168,7 +168,7 @@ static void pl050_kbd_realize(DeviceState *dev, Error **errp)
>>       }
>>
>>       ps->ps2dev = PS2_DEVICE(&s->kbd);
>> -    pdc->parent_realize(dev, errp);
>> +    qdev_realize_chain_parent(dev, pdc, errp);
>>   }
>>
>>   static void pl050_kbd_init(Object *obj)
>> @@ -191,7 +191,8 @@ static void pl050_mouse_realize(DeviceState *dev, Error **errp)
>>       }
>>
>>       ps->ps2dev = PS2_DEVICE(&s->mouse);
>> -    pdc->parent_realize(dev, errp);
>> +
>> +    qdev_realize_chain_parent(dev, pdc, errp);
>>   }
>>
>>   static void pl050_mouse_init(Object *obj)
>> @@ -206,10 +207,8 @@ static void pl050_mouse_init(Object *obj)
>>   static void pl050_kbd_class_init(ObjectClass *oc, const void *data)
>>   {
>>       DeviceClass *dc = DEVICE_CLASS(oc);
>> -    PL050DeviceClass *pdc = PL050_CLASS(oc);
>>
>> -    device_class_set_parent_realize(dc, pl050_kbd_realize,
>> -                                    &pdc->parent_realize);
>> +    dc->realize = pl050_kbd_realize;
>>   }
>>
>>   static const TypeInfo pl050_kbd_info = {
>> @@ -223,10 +222,8 @@ static const TypeInfo pl050_kbd_info = {
>>   static void pl050_mouse_class_init(ObjectClass *oc, const void *data)
>>   {
>>       DeviceClass *dc = DEVICE_CLASS(oc);
>> -    PL050DeviceClass *pdc = PL050_CLASS(oc);
>>
>> -    device_class_set_parent_realize(dc, pl050_mouse_realize,
>> -                                    &pdc->parent_realize);
>> +    dc->realize = pl050_mouse_realize;
>>   }
>>
>>   static const TypeInfo pl050_mouse_info = {
>> diff --git a/include/hw/input/pl050.h b/include/hw/input/pl050.h
>> index 2cdfa74f73c..7169afc151f 100644
>> --- a/include/hw/input/pl050.h
>> +++ b/include/hw/input/pl050.h
>> @@ -17,8 +17,6 @@
>>
>>   struct PL050DeviceClass {
>>       SysBusDeviceClass parent_class;
>> -
>> -    DeviceRealize parent_realize;
>>   };
> 
> Yes, this is clearly vastly better than we have at the moment.
> device_class_set_parent_unrealize() can do similarly.
> 
> Does something similar work when QOM interfaces are involved?
> We have resettable_class_set_parent_phases() which deals with
> updating the methods of ResettableClass, which is an interface
> declared by TYPE_DEVICE.

ATB,

Mark.


