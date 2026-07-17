Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F89AC44516
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2026 12:57:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wki77-0006fp-38; Fri, 17 Jul 2026 08:56:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wki75-0006fT-Ml; Fri, 17 Jul 2026 08:56:23 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wki73-0003WE-6L; Fri, 17 Jul 2026 08:56:23 -0400
Received: from pps.filterd (m0127842.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66HCHfHW3901678; Fri, 17 Jul 2026 05:56:13 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=kPyoF6Y8ZW1/5Os448bR9wVEV45Y9xDHxSy/f/ipC
 EE=; b=UeDN0+k3H5c0wzaTGzSII07fwcsmpdNdi9D/SSbk1hakjU0DzrGNS2VaO
 en9DwTO4FvamxlOAY5lPBSLQHVJJ/Fe09Pf82g+uMBFhGCFobX140yflgJqEfGrx
 ObpF9ccrvygNt3FibOhW2BhHM9+d8ZQxe9Vr4nVUqrCtkkUMLodsGyTGCt8tQbwp
 p03qq9Au2m24a/mfBr2d5tQtQqXBMjVGUOKl8KtMVpg5s6OMChEarpPkOYSgVrRS
 Go/AOESMv7IBM8T2OOxB0StXkjta99PKrAKAsN2mPZ1GW9wyeRvcDGblqTNnF8lG
 VIghn4o9LEkugRRzDIUF2CJ4adc/Q==
Received: from ch4pr04cu002.outbound.protection.outlook.com
 (mail-northcentralusazon11023137.outbound.protection.outlook.com
 [40.107.201.137])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4ff8dh1gvc-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 17 Jul 2026 05:56:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IEiYrAbkYjv3+RRFUZWkiO5SilC+lKpuJokfK4iSqKQd2a223/tvPMzm2VO9PBQ7z2BPkeCauze0NB1ZObSfsKmeJsE9qDcaZy0N44hqRKwCSqSQoFs6ZhYlZa94IiZY82wHjsaf8Zc12/QxW2RzUPVzq4kAakE2Lu59MGUmK3Wf2jwTHK+yng8VHho1s6c7EneMdc/Scr7G0UZnDqpxoPRRV/RkMe8jQkmpAiECbcJ6igRLOGNbe2UYkj4bnAaBepGlDeMKaxiwUfM7YYJWPNrzQ9HdWVr+YMFAJmAFRpIRFadHWyEqT674cuLCHnoy1SH2XvJnvvS7OtL69bzrvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kPyoF6Y8ZW1/5Os448bR9wVEV45Y9xDHxSy/f/ipCEE=;
 b=XV6/x0bxVbaHCSI8iVVuVEiS+XSAMeMNotfQCZResqPxvA5mM3cl6KIPILAdDvsskJDSSKm+z4bciQ8KxVnqdiV2uj53nqGNQgn9HbM2MVlbkgcQErYUSw+Sw1R4rs5alS/WPDBtZMVBgyJX43dr+Mrt/hD7bmdom2NNdztSnRMG0To68wOSSnOhuulpYHveiX+/7kgw170Cd08eRRKQXt/IfFsI2vgtQNtc/ap9RFb+jJj8iUweXQVZKoEU0Fa7md42I3d2gSGjlTTKRUl5QjqcL83GXidx2cNWWytELxFTy+CJhBRR4kSEu6ILJfRXVOW0oJt8okuXBBhdY0WW4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kPyoF6Y8ZW1/5Os448bR9wVEV45Y9xDHxSy/f/ipCEE=;
 b=FhZnRVZmZdsmygYuxmY52sJ1zNv/o9RTCbU0EU3YOkTVd0NKVdBPdSQ4TSHAJfuy5dy3hGXQnJ+qszeFfRTze8M9Tin0dKmfjelU3yaoGsbssIdahM76pPPnD+g7Q9aSiPMNXbMvUMKaSAIsGcrHXMXJUWrtLpcSsPut6nxCm2HGrzPLBSD5Dma24aVvmV5c3T0xwHO175mRLu1KzkKhNgWr1EPh6tzsJBSGBtPflLXcYs6kX6zxYZNWlz+oVDjSnpifpVoOgH/qe8elpcFsX9oq5KADtv0LVSifl3iNxmb335+9qQ30DSqvRDRvJNEKiwMinkJdtfs15xON2peFoA==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by DM6PR02MB6698.namprd02.prod.outlook.com (2603:10b6:5:217::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.12; Fri, 17 Jul
 2026 12:56:11 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%3]) with mapi id 15.21.0223.011; Fri, 17 Jul 2026
 12:56:10 +0000
Message-ID: <0f723410-d701-456f-b7e5-c51eec3a7573@nutanix.com>
Date: Fri, 17 Jul 2026 13:56:05 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] qom/object.h: add missing documentation for
 object_class_* property functions
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: palmer@dabbelt.com, alistair.francis@wdc.com, liwei1518@gmail.com,
 daniel.barboza@oss.qualcomm.com, zhiwei_liu@linux.alibaba.com,
 chao.liu@processmission.com, pbonzini@redhat.com,
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org
References: <20260717112022.444367-1-mark.caveayland@nutanix.com>
 <20260717112022.444367-5-mark.caveayland@nutanix.com>
 <aloffnKdpvj_2XzU@redhat.com>
Content-Language: en-US
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
In-Reply-To: <aloffnKdpvj_2XzU@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CY5PR22CA0037.namprd22.prod.outlook.com
 (2603:10b6:930:1d::7) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|DM6PR02MB6698:EE_
X-MS-Office365-Filtering-Correlation-Id: e60bf441-759d-4d01-764b-08dee402c638
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|7416014|376014|23010399003|1800799024|6133799003|10067099003|22082099003|18002099003|4143699003|56012099006|5023799004;
X-Microsoft-Antispam-Message-Info: 1MsqBpVCtGvgSXHpgASMPqKkgzanTcOiQYH0U6gzBiwK++LipS0K1ROnkyhXOpwo5LXSRALw7APtyvoLd1oSZ8vL8ncoDQPz10uCvSr0EXzxusOTLZQdgrRv5DO/hkgqsbLvF27xxgV+hQGE2+mTLoaocDX0k4q1NYayswMUnsa0HZnQ9iEENCOpC9epy6V1txpMao4BG+JzGetPRI5ixTRogkiRKmih2CDOBPvDsYzdYMw5nVEsfMvCjAnlGpYAUasKukgIbgoSOLJkyjHfd0iJrmKxePj4K1IN9J9X8rgDwQuJH8uLvguQaFkDTOyOibHWwOx9CnWME3/B/xshWSLP9COnPvwz5jLS6Am9UHEDCj3O023OdTNEZyz9rh5+ZEHwnfE1lljLgwJtlVhd3SA8NzVxBUfCSbLAlHS4/U0XUlW42hE7OQGD2yu398rCUa0IyzwLdczz+aJUUDJGiN74TLVZ/qwE0fj4iGMCuq6SVqnMLXf2PX983pCzMVfcH0UOFuP61g4TK3N469n0gn3K/mXdxtva/o1oxM9++vpwqSFiljuOYfICDCjKBCZNkfb1hS458LGDcqBjHCnC5d9yEGMXUdgE5U4eFtVEtVmYEmgWkA7TrTDVF2S1+56mmqkUVoj5Z9FQ+CstSo/ZsXRATeWnq9/XaKADJ7wIg1o=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(376014)(23010399003)(1800799024)(6133799003)(10067099003)(22082099003)(18002099003)(4143699003)(56012099006)(5023799004);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UlllTlRVYjZ2elNsZzR1N1p2UUxZU1FrVWw5cFc3ZXpBZFZ6VjJWS2ZRR2VR?=
 =?utf-8?B?dWcyaFlVYTFBaElDNDFjcG56SC93c1NHbEswU3FMVzBRR0QxZTRYYzRSSGFN?=
 =?utf-8?B?aFNXaFZmbU9LN0xYcUlJditVU1p2ejJ1eTNUdWpzREFtcTBVblJqd1JFT1F2?=
 =?utf-8?B?djJ3SEp1dURockxtRjFOazBZTWJTWEtZZGNXTllhZkVPS3M3bGRVbThzM0dP?=
 =?utf-8?B?bkRiQ1pEbGVCdjl5Q1Vnbm9GcW9ObGZ0ZWN5SlNieXh6d2NCbTQwTm52Qncv?=
 =?utf-8?B?YTNSNXJVYllCQ3JNeTl5d2lCRXpZSFAxL2hHUE8renpLMGduOCtEdmlCMlU2?=
 =?utf-8?B?S0IxZ3ZPUmpvQndLU0tDTzVNRUJZRXFseERVblVCQkhMeFlTejVkc2oyT3BQ?=
 =?utf-8?B?MzBVS0JMUWIzWFpMSVVpUkgvK3llcGgwZ1VBWWpRbEZpcWFTSXdSUHBYb3Fj?=
 =?utf-8?B?L1NNdHFyYmMxOG0xMmo3QWpMVDVwZTBiclJSeFNsVWZZcnQxcUd2NlhlTWg5?=
 =?utf-8?B?VUQvNk1QSVJERFVvQlJUOHdqOEM5MVVQVGRxNG9rTmw3L21TVi9hM1pLWXVl?=
 =?utf-8?B?Mnl2UmlFRVd4anZvaHBIZEdYMTdKa0hqQXBiOGhIeHB0R3hPWE03WGV0SG5r?=
 =?utf-8?B?a0o5SG0rYlBtY1o0S2ZXWG9NMHZwQTZjZXcyTkdEWmJXaklFT1RjMS9mbWZL?=
 =?utf-8?B?a0YrUFBsSWhTOWN0U0Z5MjRMeVhta2VXNUtnV29lUnZDU0RIQllxWlh1bXhN?=
 =?utf-8?B?SldFc0ZhTCt3Wk5QRkVsWWNPS1AwKyt5THp1NTZtWXR1Qnk4ODJzVEVCMHN1?=
 =?utf-8?B?VnFDT29ZY09FVDcrOVQ1dFBUV0xRY2xETTQrbFZwNXBTcDdEbHNEMzBjVkhG?=
 =?utf-8?B?aTVHNkdULzI2VVN1MVNlcFpZdVI4L0M4R2x3RDZVMEZVeWRONTRSRDVLNjkw?=
 =?utf-8?B?R3NxcnQ5Sk1UeFZpSTYrOFcyT0tFV25rUk1WVXhSNGxSQzhWOHV1RkNRSCsz?=
 =?utf-8?B?RC8zeUNINlg4eHIrRTd3RzQyNW1kZVJobTJ4WG5XY0s2SytrcWZXRk9lU1hR?=
 =?utf-8?B?MkV3cWlRTnZ3K1FJbUJvNkFSNnFMSmYwWExpZ2dxdmtNZ2hrY1dySFNGL3RP?=
 =?utf-8?B?U3RicThsVnJySUV6WkhoN0VPNWJoSWtaL3lPV2tGSS9wRXp6QWROZ3grMEVv?=
 =?utf-8?B?eTk3UFZXSkx0R2VIa0krUFRVSVVkbTU3Q0dNUmthL2E2azRzRHY4a1R4Y2pL?=
 =?utf-8?B?ZndiVUtVWkhxaG9yZlpyZmZ0RDFZUkpjaWdUbWVDRXVtcHIxdml4N1l4T3JP?=
 =?utf-8?B?b0NvWDZLQ0hlMytsNExhZEZwY21qWVFYMHpzdE5HWUFDdXNQdmNpN3ZDWW9i?=
 =?utf-8?B?S1VUY1EwMW11NzU4SXoyK2EyQ2c4cXdJMnUvSWpnd0dXUXpEcTh1dUdkb0Er?=
 =?utf-8?B?bXpZMEhRTG5abW9UdUNGN1BwRDlQbTQyZUk3VVlZY3FTZFF3MlowM0dnK2NC?=
 =?utf-8?B?eHM2WWxTUFIyZWo3TFdaVFA1TjZLWThJZW9qMHluSUwzQ3ZxVUVYY2IwSklD?=
 =?utf-8?B?cmcxaVRZZzRpU2F3Z3JGd2tSNnRxSVhZUlZFVG5wV3g3cmtoUXlyVzNzbFpi?=
 =?utf-8?B?WlF3ZmxmVlBSakZSSW5vamxzWGREdmhmYTRwSkJsUjBwQUpGN011YzBMNndY?=
 =?utf-8?B?YzI5b2d1RkRFVU1Xc2srdUoyOUNMb2svUW9UL0RHZWRnZElObStkeW1GbTZw?=
 =?utf-8?B?S0NJblVsUUtscDY0d0dCZ0JScHdMdXgxZnVhZU9jTEQzeXE4ZFZuK0ovdXJh?=
 =?utf-8?B?bVJIWlh6Uk5aWDhxS1k1a0dOekg0MTJVUzVGMXF2Z2RyVHRvRmtQZ0VMMTVG?=
 =?utf-8?B?TlRyNGFENkNBUHdOSU44UzNONmRSUHNIN01GUkpLRTVzbDZuTkJXbm4wZi9x?=
 =?utf-8?B?ektXUlZTdy9UZXlyTG5wTGc3WlAxbWVzbC9VZlg5TzBYcHI3dFZldTZSVGFT?=
 =?utf-8?B?WmFtajNzZ1Z6MElldWVoWDk0bTF3am5GL3pQTGJ6RVFpbTJoS1I4dEsxanBG?=
 =?utf-8?B?WWUyWTljQVRUWEJCUURva1BRYlpGT01teFM0RURDVWJLR1ZTeWdTOVdlNkQ1?=
 =?utf-8?B?aGt2ZUo0QTQ2YmRvUThOaHI4L1JJd1dGR2dNWG5iZmdCRFh3Rk9NMTJtUW1j?=
 =?utf-8?B?SFRpd3ppa2dCMWJvZVh5a25ldm1NUU9Ga3Juc2p4YWQ0SFYzVFd1MWtRR0pH?=
 =?utf-8?B?ZG5NMUFqNmlsL1RwbU1XRnViaTE5SytuQkxTZ2EyREk5OWkrNVlXU0NTalRU?=
 =?utf-8?B?SldGVFdKczBYcVhKU2U5UG5ERW8yemtGTGh5L09PdHdOU043M0s1S216a09h?=
 =?utf-8?Q?t/mAi72ps/TRvGlw=3D?=
X-Exchange-RoutingPolicyChecked: jlHeHNFgPKkZdI8cMyv/s/Kob4fUAgRtECqSBBPNfzaIF1SlqqBNpQT+sCb955aD9Gy1GlXoCJ2DEv5UNSAl+Eq9PrlHmC/1sA5gu/qfluXMaYpSNVVpSh4PE/XkPQOtUV+rS9dcyJmtSzNIX6ZWOzmXxu6jBGaW8+zFV6M3dN/G9NToF+YvdJWTCB19FFVKhMxDORPPtQHXK9NbHUupiaNLBTd08hma0u9MT5246npUER+qSshHxklbksT2epW+O+jW0ZMKPlzSXrpc7tQPXMz317oebue3IQpCyzPMgIwNXDxQGns2+AT/jUnhM07QShtopj3YeTL7fhQjVyEh9Q==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e60bf441-759d-4d01-764b-08dee402c638
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2026 12:56:10.5970 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DlcDDm/OL4+BFNSeciljxD+n6vysmRdSlfw/99K9vJ9TkQ6ddWUwa3I23veiDv6lOg+VFwrkPokWLAWyIW/bSE3wmQD2AoFe4I7Wy9YR84A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB6698
X-Proofpoint-ORIG-GUID: gzQ3NNCijtvnlO9Zg_7Rcr0efZMJOWhb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE3MDEzMSBTYWx0ZWRfXwp5uGL/F469I
 kjKFrScaKRoCAdV8k8MSbpAtITL10xwi4DFa1pYzWn/EQ+gFiM9mIwcB5RrnAlTgAmAHqA5KBqV
 TvBDh7At1Xmju6HK4OFpQAtkYBnoEe22Rs5hhGosoI09AABfx+ys1kyveAoX+PUEpWc/4zBLqZM
 2p2bknIbqbF6g+Zs9hIl0sFXeot6DdtL5rIZnH6OrcMVXzu7d7gCireKX+Vc67hJH7E34As73Z3
 3dsnraKOOq+BSEPLDVcDXggQKil+Nody+f5C5yh7BJT6heQ9Gpa1eP6uYZFmgAobRrjkCfdnGW+
 VC9HbQTbyK+8R/QRk9H9IRTo92Tnh5mDDIEKhxvaUWCpz5r5dr/Lt8XUHQUamvgX3PYxhIg53oh
 f1YrkaGbh90CT842nrs6wFLs1YDjum1RDDF2NN3/GiAcOJeqQaRSxya2/QjMBBnaGqi3UQZ3f+5
 cQsACTh6WshrGqp838w==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE3MDEzMSBTYWx0ZWRfX7ZKQ28lwsvAQ
 bVd+sOQONt8T52MFtJGLd14eYFzLVeJV4dID6RHSlqqsDU0XgbTxjvfXQ7zaAiOdBoMFoG6qARb
 sIIs+qKgBQZ5GF4Bf94G7ViuCtiZE5I=
X-Proofpoint-GUID: gzQ3NNCijtvnlO9Zg_7Rcr0efZMJOWhb
X-Authority-Analysis: v=2.4 cv=J8aaKgnS c=1 sm=1 tr=0 ts=6a5a266c cx=c_pps
 a=fZezqqEN0LPY/ff19f4zYQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=VUi8bpU7OL1Oj2-RSIOF:22
 a=64Cc0HZtAAAA:8 a=sphQfbQvfuzbBrKC-k4A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-17_03,2026-07-17_01,2025-10-01_01
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

On 17/07/2026 13:26, Daniel P. Berrangé wrote:

> On Fri, Jul 17, 2026 at 12:19:11PM +0100, Mark Cave-Ayland wrote:
>> This is so that the object_class_* property functions appear in the generated
>> QOM documentation at devel/qom-api.html.
>>
>> Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
>> ---
>>   include/qom/object.h | 140 +++++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 140 insertions(+)
>>
>> diff --git a/include/qom/object.h b/include/qom/object.h
>> index 11f55613fc..95fdf01e30 100644
>> --- a/include/qom/object.h
>> +++ b/include/qom/object.h
>> @@ -1818,6 +1818,37 @@ ObjectProperty *object_property_add_link(Object *obj, const char *name,
>>                                               Object *val, Error **errp),
>>                                 ObjectPropertyLinkFlags flags);
>>   
>> +/**
>> + * object_class_property_add_link:
>> + * @oc: the object class to add a property to
>> + * @name: the name of the property
>> + * @type: the qobj type of the link
>> + * @offset: the offset from the object instance where the link object reference
>> + *   is stored
>> + * @check: callback to veto setting or NULL if the property is read-only
>> + * @flags: additional options for the link
>> + *
>> + * Links establish relationships between objects.  Links are unidirectional
>> + * although two links can be combined to form a bidirectional relationship
>> + * between objects.
>> + *
>> + * Links form the graph in the object model.
>> + *
>> + * The @check() callback is invoked when object_property_set_link() is called
>> + * and can raise an error to prevent the link being set. If @check is NULL, the
>> + * property is read-only and cannot be set. Care must be taken to handle NULL
>> + * values for @val.
>> + *
>> + * Ownership of the pointer that @child points to is transferred to the
>> + * link property.  The reference count for *@child is
>> + * managed by the property from after the function returns till the
>> + * property is deleted with object_property_del().  If the
>> + * @flags %OBJ_PROP_LINK_STRONG bit is set,
>> + * the reference count is decremented when the property is deleted or
>> + * modified.
> 
> Copy+paste mistake I presume - object_class_property_add_link does not
> have a @child property, as this is only declaring the property on the
> class, not setting the link's value on the object.

Interestingly enough I see that object_property_add_link() doesn't have 
a @child property either (it appears to have been changed to @targetp). 
I can easily fix that up in a separate patch.

How would we describe the ownership in terms of a class property? I'm 
not sure the last paragraph makes any sense given that a class property 
always exists. From looking at the code I think the last paragraph 
should simply read something like:

"If the @flags %OBJ_PROP_LINK_STRONG bit is set, the reference count of 
the linked object is incremented when the property is set, and 
decremented again when the property is modified."


ATB,

Mark.


