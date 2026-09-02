Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 095D6C624D3
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2026 14:43:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1mAs-0008D7-7D; Wed, 02 Sep 2026 10:42:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1x1mAq-0008Ax-HK
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 10:42:48 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1x1mAo-0002Cx-Ql
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 10:42:48 -0400
Received: from pps.filterd (m0127837.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 682CXf9B1539223; Wed, 2 Sep 2026 07:42:44 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=ttdcexMC44C4E/iPMZF4ffCMEZHtLkmBjRba6BS0a
 hI=; b=cTzNh+a29zZrJ4eOU7dh5B3QvPAwx3shd8ZAYWzRh0a0qlNEpd+AJb83M
 WwiwnHMp2RqwLAGU/9PHa2HMmmVjdLrmzdSPLosX3C2VUPt4YcgALqOy/S1BtrZZ
 sJcA+oX9R+dbsIbZGv3vnB2lxx8EgzQT40FLVYmnpt34viy48Qx476GvMPMEHJc7
 vgfTrI2KgtyVuM1d52sreroUkKHdCp0l95sSwrVj7x4JOLzKVUSpC5f8JQI5dbcB
 TslbMUMpgtCv+JW+RNC2mVE1cOLbvpZiCsWtZSEHByy1uJsWmtR4m/Q/SClLVWWo
 uAvrtV9WrsWos8/Q106QS08CPuxEQ==
Received: from dm5pr21cu001.outbound.protection.outlook.com
 (mail-centralusazon11021075.outbound.protection.outlook.com [52.101.62.75])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4ge0sxb5ur-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 02 Sep 2026 07:42:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hcQjZeAsjgzLa9yWhbY5cVtNTvUhR3+d/J3IM7OezQEhLxNRCmollM3uutGWFFihSQXPdhmYnNd7T7snxQ9+s+sYzXPsyDBdOrJWNTl1l3SNMabbnW3sQ+dYhuax7aLTkTiJE+tA9fxE8YIzM6a7HfkvdBb4kBSgTXJiY8W+axs9b8mQT5BpUvAFGQoWxefzZtZGXegTV6tALc6sCyPIYhHgYp4L7S+5478fivo8UUoM5NWzWlfkrLGo2q5MnHVa2+Q9QP/6HTzDj7Kxz4OJNkZ2KFW0FzNqJkV/ua2/W1UrssVmsVDoEVaaqZm2NVBXS+91yFiGHWnl4P+ue5UXIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ttdcexMC44C4E/iPMZF4ffCMEZHtLkmBjRba6BS0ahI=;
 b=cxOX6qZ0DOSYpOi0cCFxxUu744zSOROi75OiXfCdCBfd4NfN5dzS+StqYzqKUk7FNW8ZsaHXOaLi6AYTkdCLtXYtSkiSav/LirOSKWdKjE+myTrQBwZ2UMnKcGh2zkvKYa8GRQgjEkMerNqSfMe+uRsnCQ+BiBkiMgvcuTzF8hMemxHmwt9dl/HGL8FyLrvGq/L2v802F3lPu7+iKtRMpXE6+0u6t3/JqGzGgc2skhKUpyePdJEw8nxo/YApjXM3779TTsNTLAd4hvhq9MLQW7pt7ci/o1agrxIkIkctp6/kGoY26kRj8Ht5XALbEfytVcws4lQCvnjEz2t50RJSPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ttdcexMC44C4E/iPMZF4ffCMEZHtLkmBjRba6BS0ahI=;
 b=YheT7q3rvH8TteasV8V8DokNRbZXModq1/wmBwnG3/fGQwfqf8s1wcYqwfHLkYPXsHlB9GA+UT+5OVyIGbU9XMCB/8Ysbt7L7T2Ns757i0+/iVJ5OCCfFrNYsmMt/ImNThfC9LTTr4QVGaFaLG3fY5M1oOTf1vWp2zbHXQjG2gUSZDv778Ns2AjQNIlAkTzjog7Zxxje8x97PzC2l45sedN9ItxLTD0fR65WYerLhmnrBpiodhPt6vGiHhnlV1LrOwK4aKC8HAZbNUqyoyroqdQ4g4svwdn0cuS1uUzhnYFw1GNQcrCJPNA9zBK7z+z3UG/U6855Ho/3FTdysdGVQQ==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by DS6PR02MB369017.namprd02.prod.outlook.com (2603:10b6:8:4b4::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Wed, 2 Sep
 2026 14:42:42 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%3]) with mapi id 15.21.0360.008; Wed, 2 Sep 2026
 14:42:42 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: pbonzini@redhat.com, richard.henderson@linaro.org, mst@redhat.com,
 mtosatti@redhat.com, marcandre.lureau@redhat.com, armbru@redhat.com,
 qemu-devel@nongnu.org
Subject: [PATCH v3 8/8] hw/i386/sgx-epc.c: convert SGX_EPC_SIZE_PROP object
 prop to class prop
Date: Wed,  2 Sep 2026 15:40:55 +0100
Message-ID: <20260902144207.2553037-9-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260902144207.2553037-1-mark.caveayland@nutanix.com>
References: <20260902144207.2553037-1-mark.caveayland@nutanix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BY5PR04CA0016.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::26) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|DS6PR02MB369017:EE_
X-MS-Office365-Filtering-Correlation-Id: 3fdb06d5-a07b-48ef-3856-08df090071e5
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|10067099003|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info: B7uTAxYJV91X//xyMAtOXQecUziPqNkAJY+HnnfzNwShBjBi8VaRw32j/VMPihPBJSaXJ3j+Ho8wFeLbTQt60YIGVuDp/9G0v2X7ztDBd9vcfYWhgfG0vqfs2SyuOYJEBR5vxX6+Tl50G+4Te5k+0s1b4j22J7VygR6x4jvm/CBE+mRgSKDB6z4CBNwQKBddX8AM1d8heW6cPxEUzGf9MXc1rf8o7uxUlrgVPn9GlbmSbIzJqcB0S1Nt+AsimN3HK33Rs6nCvotN/GWb0HAiX78EozPqcBBMI4L+tekr7tw9c4NHz7m/gmt4+OeOpB6osd59U/qFhRL0e2J/Rx6niW4ZLYJCxZKS3GTUcBTq8xasZUtWmqdnbmsDdHWNXwIhpVGXT/Tg3XlJOdP8jcgUkKzsRyLeCcwF94vSwxkJlx+fWZi1D1josZmLHkd1ptwQC9ZgVZeWx6jtsE4+rB3gMaARg3rwpnO2IbgO/S65xYHDTWI/5XklTSGRP5NryCF4ASOSIODiEufQmHEdkL4Xb9Kgi5g+9edNYiuZi9BKCJdNTOYZP+kNXrPSPaCJhM0roqSW1tjgOjQYy/syvrqgIZeNnQwyV8zLxjeINV9wm79Y01XFouSy4GSRYI/XB3GycJJ1OwzQO4aI1UHnhGHbuF0hkmAgn2BaD8Gtec6tgHc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(10067099003)(22082099003)(18002099003)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QndpcklLeWQzNzJoRzg2WTdDUE5JNzdPaytKYlRFWUV1NVUxWmc1ZGlRRW01?=
 =?utf-8?B?UTJNUENyblhwTG5SU3hHYTR0V2dkakVUNXZGbFZzZEVCTDNSMlpmZms5UmhW?=
 =?utf-8?B?WFc5UkdMRFFFVnJuaUtVZnNmUjZudkVBVHhkdkd1dmxzWjg1S1BNa01PQlhh?=
 =?utf-8?B?TWJMZURzdXNBVTNOUkdCRUVBSjYzWExMekh3VUhqK1QzSmdnNXBXL2Fxc0lt?=
 =?utf-8?B?MkhXTEVZSUs0QjlQWGZHWjZiTlRHTko4aWhSUXVUUmVpdGF5SVdLNHo0bjI4?=
 =?utf-8?B?Q2JXQU5UY1YrTFhDR3R6QThxQm5CR0tDdXg3bzFXOEpmdUFoK0Z4bzJGVDlO?=
 =?utf-8?B?SXlRTlp6WExWeWJEdFpPTWhjUFFQNFZmRmpMUDdNT1c5WUZlQ2c4YjZYTHNw?=
 =?utf-8?B?VmZMR0Q1Vzl6aFBvOGVqRjF1RkdLM2xKeHQvSnRWQytVMitnWTVYTm1CaTlY?=
 =?utf-8?B?R2xWcUxOTlAyUHNWZWtLb001cFJteWFjUjRpL2VmRmQ4NElnenZrTlhYd2Rx?=
 =?utf-8?B?a1RtdTRWWEd3cS93MjZMMms1RWNtTStpSkl5MjdFQWxvZ1dUQlpPdi94OGo5?=
 =?utf-8?B?Y2dyaVo3Zi9PbzhCQzlOa1VtblBiNHFCbUN0SEV2WTV2SU1PNGI3cW5FdUZW?=
 =?utf-8?B?UW0wMmlrMnVKa0d6cHkwczE4dDkyUlNEYzdza2JzSXJJM0EzQklBc2Ewd0xl?=
 =?utf-8?B?UHNuTmNBSElyaDlhQjdnVmgraHpMRkxWR04rdE92RjRvVWZHcE04bVZMZUhw?=
 =?utf-8?B?VkdMamx2b01jSVAvcUEzN2tsMEZuS1dBVUlDZ2I4OWprRTY5bzJTdHMyS1Zp?=
 =?utf-8?B?emwyOUNxbmJ2Z3JYU3M4VE9sUkoybTRhTnBQUHRoV0tyMDYxTCtobHVoYTFx?=
 =?utf-8?B?eW1DUCswdmlFai8yY1c2RWRCdk05ZmwvbklIdjF4RVZ5M251OEx6YTNxR3E3?=
 =?utf-8?B?WFZEV1J4UXZvZkI4YXFwM053NUF3QVZmTDYrMDJzdmhuRW5OSnVpUGJ6TndW?=
 =?utf-8?B?UkVTWFArUThzOTlFOExYcFBaaTlNVng2K0tteTY1RHkvOGoyanFabVpFMklM?=
 =?utf-8?B?YlN4SU5iQ1dYeERPTTN5T2pUT092MW9Hb0ZCWkNJcmtCb1lKMVR3QVUvck5l?=
 =?utf-8?B?VnFZZ2gzRGNsc1RMa08xaUFhYVJuQllxbEhEbldvUFBlb1E1MFF1M2hGSUFE?=
 =?utf-8?B?dlllb1RyRVFFUHhZemJ0M0RtTVEzSDZobmpJL1hhcjdXU2pOdGVvOG02dVFG?=
 =?utf-8?B?Q0Exa0ZsNTR1RmgwWkNkTmRmL0JrNUhnVU15by9oRmQwSGlGZ1F6TVpxWWlV?=
 =?utf-8?B?dVJIQ0hNRW5qdVdYVGNqOGRBNjN6a3FTK3RyNFpzVlZQbVNnOVhmMnM5dENo?=
 =?utf-8?B?emhjWGhXZTcrWUpVZVh3TWpIbjdpNFJsekloVFFCYmZCZU9CUGMrd3N1QjFk?=
 =?utf-8?B?bUtqdGE1dG1qSmFHTjF4YnA0eTlBSks3RkorTVVUUjFjbTRaRGltOFd2ZlVB?=
 =?utf-8?B?UkRQNEFRTUUxQzk4RDltQXZXSXFQTGpSZllzQ001YW9sd1VvY3ZORmRMVXhY?=
 =?utf-8?B?aWRqeGg5VHVjazNxOVg1NFF3VTFLMGQ5ZHhTeDJXWStlTTdjaTdZUyt3cERR?=
 =?utf-8?B?QU9aOWRHYWpGbmVEUW9PWW82ejBwMWd2NDBPSjNnMHBWelU0YnN5ckhkb2lr?=
 =?utf-8?B?YVFsUFRaK2t1b3NxS2pZYW91cGRwdEhYRTVBL1ZSbEJiT0hhb2dTaEdKVEds?=
 =?utf-8?B?STBvdFlMVEkxVWI1YXJkUGZQZmc2U2xvWWdpN0R3eUZteXE0cDFrYUJZTUxE?=
 =?utf-8?B?MzQ3RkNldzBVamc3WGo3dHArWTMwMW5aRlUyUlM3dTNoajc4R0pkQ1lqNVQ0?=
 =?utf-8?B?Mmt6K2VCMzRsWDRWMmNnejF3RUNhcXlteXozTkFtazZvRFFrc3ZKSlJEUDVM?=
 =?utf-8?B?N1hUNDNQaDlnbHo1MDZXb3VoL0lrenE1QjMvaGU3YkNTWTdMWW10bHVtMEg5?=
 =?utf-8?B?UmRVTGJJdXUvTmxTdFRQcXBPbGRDWW9ENnFKUDlNblpiZDJnU0FpUTUxa3JO?=
 =?utf-8?B?MVFuL1RoNFc4Mk9hekZJQUNFU0hCTkh6cWFQUlZ0ODc5YmQ3QWZDNk9vR2hm?=
 =?utf-8?B?TEtxaWdvb1hKSWpaaW1HNHRrcW9LcTNZK3daeVM4cmh4ZHpYK2NaMmdGMnJD?=
 =?utf-8?B?by9nVUpmRmpQSG43RTdZYW5qUHo2WEVZaVNwOExlTnNCdVFGbFlhOGp3REdS?=
 =?utf-8?B?MldaY3Q5OWxvQ3liaU55bGtHVXg5ZVUzVzVYVVlOcmNLdVNkWlZWR01CWjhB?=
 =?utf-8?B?QzFvTndPdmlSYmlhTndCczhSejVpRWN4bU5Qc3Q3YlVSUlE1bHg2eGp0T216?=
 =?utf-8?Q?xOU+0c1o8EHbhysU=3D?=
X-Exchange-RoutingPolicyChecked: j8ra3wg0z9i5nIdxgKsRJr/SAtWSW1BUKupX2mcA8AGvZXlGqEopeS6KowHpvm2QMsFsybE0gvx8hUdC+d66ZnCtZWKLKYrRBPm8eZSOIk7i/4T8WzOTKXvNaHZ0TpJ2dgkE1rYh86c8wpTlT1Znotd05tOFszsLjn1UW5hMGB2VW2j8IOesmqH5suKroLr6T6j+9LkpDNd+ZOfYtlg7iwQMHEEjD5t8md149ETbTPz5azjVTYHnlh+BYq8C1Rhzd36t3tg/6tvDWo6QNmfV4TJGRTwncLXmfEUxxXKYFN8ht3jOcH2/z9FqxEf7puOYlw0it6TNUhFCv4/xbSJApA==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fdb06d5-a07b-48ef-3856-08df090071e5
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2026 14:42:42.6545 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sImC9MZkzCrp+oDnLEAgV3Lp71QGNFI1FrTzx+hZ3wsNeoZw7JIXZpabPcP3Imyxv/vVRjdS36gCQyUoMO+FDIC1OScLo+/4IUYHpQjYNP0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS6PR02MB369017
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAyMDEzMCBTYWx0ZWRfXy6cxRb3wxWOl
 FJv1g9EKKtmvASttYFGo1UBb6fkcjVYYjtIgyTJCSlsCPdPKY5IbX9EQ484lFRgbdz3WewMFLk9
 gUbUuzdZH3P3i/hb1sW/h796lM22ARE=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAyMDEzMCBTYWx0ZWRfX2t4aAo9OLq7O
 rs2K7t11pzARFxXL51g3Wqdn/gkXeppGlULrsyL2HEgeoMRoQ2yV0hNCuf6cHPRJiTw2OOv6Rko
 wADbkxl9Cod/YPQI9IkTxKjcX5f98Rg6zUAh1K0qPkNPTc9g7Mb32U0pwR2WwqoqTLlIykcOcTh
 LJamnFalc5tPuMo6alCRuhFzWN0UOcgNUqObIBZu4EBTyspINwi+agckmlkuxCWXyNSgA543iol
 Tk8dNwScaiKYWBnMKUZ+63EPQ8AmztEqH7hnsuNtHJq1YBA/Pqkf4bk+3XsRuL+b51T6NCJqruL
 Z4vqsbjMBiyH3xwyHGk+5ivu9Uq/dpwcSdmFW18bJEH85gaQ586ND5Nt6QHzJgB2R09hUU9GBLY
 sJSvd2Ze3He/dX/DQGFNiq8awT4jZs8rsK5AridCuiUBjMOey+j/DEO89a/lg1UiZirPqr7ZEZR
 L4u6I6zbL0T3QlV7QrQ==
X-Proofpoint-ORIG-GUID: XYesuslZlT8qjhG46e21eeID2HffU2Fe
X-Proofpoint-GUID: XYesuslZlT8qjhG46e21eeID2HffU2Fe
X-Authority-Analysis: v=2.4 cv=E6r9Y6dl c=1 sm=1 tr=0 ts=6a9835e4 cx=c_pps
 a=APgIdIbuBBIe7PXa++EYhg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=Ap8k9tRZuQ82DLYWQqG7:22
 a=64Cc0HZtAAAA:8 a=20KFwNOVAAAA:8 a=tlSEsSRgIMY7PNDPInsA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-02_03,2026-09-01_03,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0a-002c1b01.pphosted.com
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

Remove sgx_epc_init() since it is no longer required.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
---
 hw/i386/sgx-epc.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/hw/i386/sgx-epc.c b/hw/i386/sgx-epc.c
index d3fe10028c..29cda843c9 100644
--- a/hw/i386/sgx-epc.c
+++ b/hw/i386/sgx-epc.c
@@ -41,12 +41,6 @@ static void sgx_epc_get_size(Object *obj, Visitor *v, const char *name,
     visit_type_uint64(v, name, &value, errp);
 }
 
-static void sgx_epc_init(Object *obj)
-{
-    object_property_add(obj, SGX_EPC_SIZE_PROP, "uint64", sgx_epc_get_size,
-                        NULL, NULL, NULL);
-}
-
 static void sgx_epc_realize(DeviceState *dev, Error **errp)
 {
     PCMachineState *pcms = PC_MACHINE(qdev_get_machine());
@@ -164,13 +158,17 @@ static void sgx_epc_class_init(ObjectClass *oc, const void *data)
     mdc->get_plugged_size = sgx_epc_md_get_plugged_size;
     mdc->get_memory_region = sgx_epc_md_get_memory_region;
     mdc->fill_device_info = sgx_epc_md_fill_device_info;
+
+    object_class_property_add(oc, SGX_EPC_SIZE_PROP, "uint64",
+                              sgx_epc_get_size,
+                              NULL,
+                              NULL, NULL);
 }
 
 static const TypeInfo sgx_epc_info = {
     .name          = TYPE_SGX_EPC,
     .parent        = TYPE_DEVICE,
     .instance_size = sizeof(SGXEPCDevice),
-    .instance_init = sgx_epc_init,
     .class_init    = sgx_epc_class_init,
     .class_size    = sizeof(DeviceClass),
     .interfaces = (const InterfaceInfo[]) {
-- 
2.43.0


