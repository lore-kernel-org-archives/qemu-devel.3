Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 451B3C43458
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2026 09:09:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfZsx-0001PR-GZ; Fri, 03 Jul 2026 05:08:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wfZsu-0001Oh-WC
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 05:08:33 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wfZss-0007yG-UF
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 05:08:32 -0400
Received: from pps.filterd (m0127839.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6636s7PX2069378; Fri, 3 Jul 2026 02:08:27 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=CrDBpER5wp/xQU06cA05O/TnNXo/lrewm8aQD14AK
 eI=; b=qtttaoiMI9m5uVpU1HqLKXgqwpWueAAieDPG6L0dqm5Mu9hs/kqe57MS5
 3lXXq7DSpnubkKeoigKbwxjRq5CgK+YeLB5qcNmACjXwfJrn22KxWrw8j2C7yrkj
 Sbporc1piEeW101hGOJbisJpBO/hoTmEXrCCVtCcDr0e9ygC65UF8QXX6/nWBcBu
 3QghVQMtghHlAZ1wGqQjwc9NllxXqLiyoEA4AkF4VN8JjUHKof6S88DHhbODtmee
 7n4GfjnNJiIBxCt8jQOrLufYfLqDH8SKiytUnRCgQv8qwlzlrd5NlWnSvUFLYig7
 N/SbQ9ignIcUyHDIesDa91S6mB8zg==
Received: from ch4pr04cu002.outbound.protection.outlook.com
 (mail-northcentralusazon11023092.outbound.protection.outlook.com
 [40.107.201.92])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4f687k097t-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 03 Jul 2026 02:08:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yc45FMxIj2wJTrS0k9yRi8ANYS98AWJjzT8FkA/G2Eu4Q3ObHW7IWgvEkdibsvQMsnIUnBTG1Gr6lWW6btUaAeI4znxIPSPRr/rBD0KnCtvcj2PtdydGPE1tsQKRbE3o3S4/K9sbm5g0sFtVm8jnnxSVwGbPhusulI2qBwE7vCpFZH3NAuBRnCui+g6H4mXJY9ENuy9R4BFy2w8A1rL+/0NA/X7e6LQ+WoBcvwXhz0j70cWhUTvhy0a8OR2bmDv1qZaDFt3icWUJTzgKPNuqp7wcf1L1+mMu9B3fzWKP60+Y6kqdQnb6iO0iIhqnZoLAkVsBaSjq5QkB03Rtg4uxCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CrDBpER5wp/xQU06cA05O/TnNXo/lrewm8aQD14AKeI=;
 b=LBNnIU2r/W940vtPBs4LmrxWoNoJDrlxXbKAa/+xfSu2lLI8RV0UkSsCTKRT5p+lHgu1e3J6JXYOjavOSXe9NZwumSJN5NGAPC1jCVeRG42aFLvHBjcS83eD9RoIFLEoIsC1CkeGQKwFOrHNmb0gQP00sMG9OUmmqYZLNbit/Z9QYbMtTm6QDrB1c42M85fGb7KBiDnxCK/IrecnlGa6zehy3bmlSXKmMN9R+qg7DvrzCG4VFluF7XJ4xBfzQro5+R9kS9yGmD7ZrRigTU92OaUTkZRxP3Mxeej/2Trr4SmN4S4g7F3kuD4+xqBE7nB9VoxbTmuFO3JvoBBHZQBHEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CrDBpER5wp/xQU06cA05O/TnNXo/lrewm8aQD14AKeI=;
 b=bw3teSRsmpP4pKXfv1WcOKnuEI1T+d14n/Jvjj4FmuFq0f8euFKeZQY95eh5d08yqaEyRYKtx3RBOvzrqMiu7cDPxh3nOcqUKliV9nXUeEr/+BNBpAHk270p6goaSckn9kruJvNe3dj5qb9HuUo5avS+1iN4Thuf879jnMW4qD43QZui2+7zAMp1ftKCp6w9pLg9cytD/PkH3OY/biJrJbquaywvra5SI+YOK4S4YgLZYoMn54R/yi/haFiwanqdGSPq+S8+D85xLlladgGVB59vMQmOwIqNs6mAfWL+GwfmFCOAa5JZIKSy8lqzNj/nuwzUvuUh/DmrKNvjwN93Uw==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by SN4PR0201MB8838.namprd02.prod.outlook.com (2603:10b6:806:205::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Fri, 3 Jul
 2026 09:08:24 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%3]) with mapi id 15.21.0181.010; Fri, 3 Jul 2026
 09:08:24 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: pbonzini@redhat.com, richard.henderson@linaro.org, mst@redhat.com,
 mtosatti@redhat.com, berrange@redhat.com, qemu-devel@nongnu.org
Subject: [PATCH 2/9] qom/object.c: introduce object_class_property_add_alias()
Date: Fri,  3 Jul 2026 10:07:55 +0100
Message-ID: <20260703090814.2993188-3-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260703090814.2993188-1-mark.caveayland@nutanix.com>
References: <20260703090814.2993188-1-mark.caveayland@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0132.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:193::11) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|SN4PR0201MB8838:EE_
X-MS-Office365-Filtering-Correlation-Id: 258d8fae-a026-42eb-d35a-08ded8e2a32c
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|18002099003|22082099003|6133799003|56012099006;
X-Microsoft-Antispam-Message-Info: uLnxi2kCVotIkbjK/0WZeTbiancssgVuS+3PdHdUbcN5VKjSFEF2ZrOWCqK0yQvVYUqzhzHNSHCzfkC9OFa2F/49BGJEasN44KDbzzXMlS898p0AX4E3S7a0OGGYwpwM6L0NC9MW58Vw96A2bLN2aEnjbkFlrrYQxU2kwoN3Kf3zXKx7sIehcQh1eUJLUicz1Ui1IRNNdt0Lp8k25n4AUFyQSwNlBEKDS5OgjZNftjrT97n73kpMrlwQXgiCDAF3ZAeq00+Dx2Z1A522ld+ZOz52ZNW4s0x6q3k5p0R9GTBK5oeBTMHqoG+W3WvsXikpZtyz3VxmHoy2cHTsr+GhDGiSfaam0/oEZFWiIEsQRYFcscIKriq1PUjXZK9HU6VrbFYZUq1fb2B9d0XKCSk9ndnglBqJ3O2na76/E4N0pfkFdhbrPy68IkpAfZTKvv+7wCUmj8uROBzwjn4Z/idAk30CfkccBcS19vKb8xTpcYzdy8W5Kj2rt5DOLMAoVYoHgFWHRreHspP4fXz435cgustkzDaz0h/f8F6UlL6WX83zdll+9JnguAKXcviMIzE7QiZxMqE/GYmXn9xzZDoDM2nhETB2BJBoB03l5cE2/f6xUDbU67fJ3qVEBERzzoB0m1PzXMuiZXpsNRLPJJD/lKbZAEj9728n+2Un3O7+obs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(18002099003)(22082099003)(6133799003)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dARNevjQBdfeFawvDGAtOZG6jdXQiWCYY4c/52lUeDJshyYkvDqA0Pdpuzpq?=
 =?us-ascii?Q?bba5JLJzyADfGjbYMEkN6PVjqH8aCRiTWWjb7fOz3qCZi+PTPPkZED8+4Zuw?=
 =?us-ascii?Q?rzqqJ5JB4ucWCfN3ivzsH9p1Z8N1VbxN+/HmoV/kgSjefzMj/ucnE+TwZdEd?=
 =?us-ascii?Q?AUxMfud3zumyMx5nZEtnK6EcLnfk5mlQNaH0ldt0cYLl+tmwazS+aIvZ7P4U?=
 =?us-ascii?Q?irdSp57YswogiMb3k0jHny7XoRuevKsOwJ6MKybmefzAkLrXxy1pzQ7cr3R+?=
 =?us-ascii?Q?t/jllA7t5iZz70zB+b4zZqFuce7RGgbY4rU/uB89jXUAFazobzlDn90O0vwA?=
 =?us-ascii?Q?B07VfT1rgNv5LcB1Bx7BSmGZGVrOxcxlRyjWwdiDbuwMoJU0D497vAhd49CB?=
 =?us-ascii?Q?yEoeuYp6XjtjF7wK2dAjpdXTENuLmbcOISNVG/BlnCcNzTmK5Dymzle9hUJ/?=
 =?us-ascii?Q?MxXUAwg7zWcnJaxWME4A51cUOr0cMt8eXwucqaADyLC4RD5FGCbbaNJ9wuEx?=
 =?us-ascii?Q?/JFD9piKyL0h/s6zSuavslGvCvbFGXuJCleYKAbLnerKIw04fsj2OoUn1sXb?=
 =?us-ascii?Q?9GmoaeU/ya9qYmulh9A55+fbFgPp6ePPP4k6u5Kawn/vV+lMsK7o0fJAiQSs?=
 =?us-ascii?Q?Ll1vgXvuCjbLLi4nDr2Im8pHXZi7m8GGZhEfEU1w/HEX4jsZ/PBDd6Mi+pXN?=
 =?us-ascii?Q?+8DmC9d4khZkWXxCKrkX61ClUKo5KTVSR6VUuS/30lTAekGYGcfi8Ce3C4mk?=
 =?us-ascii?Q?m6CnOU5Lk/BbJcDhxlvB9QILgfGWMcEgi5jjypsId9fq97UTlGbNDbOBQFaR?=
 =?us-ascii?Q?hdhRY95TJWKzh3dInJh7YQjeepsinKFvmuWkATEoN6hjIAOq0Va+i4azPxnF?=
 =?us-ascii?Q?zneIt9zY4qCZ4pJyg/6fVZ3fjiOvedj9xHQpgoeiaU+WuR4+hx5T2/nHiZUz?=
 =?us-ascii?Q?CErlHu1vN0X6ui78kqc/dU/lXXcKxUwHKvYUxsyM783brAH7q+STtODmHvyW?=
 =?us-ascii?Q?nCnSc9cX5AEUxO70NzdUwcTSiwA2CHHx/zDx65R8HyPWDUvoXtlUWrHWMvhx?=
 =?us-ascii?Q?lG61S3W/10RYWR02j0y0SE4RioZ6i2+8E+1kNu1DbMuoSjMRPQ7aDPfiEfMp?=
 =?us-ascii?Q?YDXZp7Orvo8IjTUC5u+pG0UMUIc8+7XMbR4NwFYg2BWYDb5riQD+84Lf5iKy?=
 =?us-ascii?Q?cH8bXGV3qeboGAzIefexKf++zqE0uZWXTJ5DL60fqjAZD31Z3NGEnw1Ufo/4?=
 =?us-ascii?Q?/68lhGlwdlfYSAw38mmQ49crnQzDvevanr5hQipN0RGf9r56HpQDcqa/zTJS?=
 =?us-ascii?Q?6bgX0A5cSUvMzqxo63aK6BjuBqfMbfgYM2SDNJFOlJixkuumO+IQvOiJkcbh?=
 =?us-ascii?Q?ypab0fui7LQNHcrjgIE7PSwCJClfKGxNLNePAeVFNWRo7L3VMNvdCwOArdfv?=
 =?us-ascii?Q?BmYit5cVkxRWVYJqXp4/6xtJxRJ/sBusrjLPCWo8ZuOrkwniZTEWlPywwBr7?=
 =?us-ascii?Q?J4Kqo3nmCpISFoXcjB+m3vwMIMBEc99UPfb+VHRgP/06sNaj4vkULUkOHL02?=
 =?us-ascii?Q?dlm6m8nqwy502jryrmlNjTqhy9qhQStINRQjdvWTVxbQhM2CloQFAACS53dW?=
 =?us-ascii?Q?XIy9b1e+laoxkvhVwwKtb48FPAkCAyjonihDnOaiRqEcrBEY6HsrH775XpVz?=
 =?us-ascii?Q?b9/d9yHYErw4tSfUleToHgdKzzVypHrryG2Nlzr9FiYOyVIeZbYyZp2xzwKI?=
 =?us-ascii?Q?8l7J1SWAIE/rMDVQmGZdaJtrgYhLwvQ=3D?=
X-Exchange-RoutingPolicyChecked: piy5fhZMutnYG5KB9E780iaVLx6Lng2B4DOV0ZT1dbWblpB3K627+Q24PtFeOvGKdr2WwZzD1pZVkSFqrEaLbl1Xrl95HUFW+HO/ioI33iFQbRGjG5BPkDOkmchrWNkg8L9STrYV0zj+u5DqEHIcIUAm83H669r3GTPlIAmATPMRNoRdvSh3JO/eWxQ2guuqZvsJMAFRgggln67pvFGjHI0dvgF0dbQ9eCL3FRvfQGcRD7Cp5boOfKRNPQjbkKTOCgWxud5GC1WCBxFsc7MndsAyOAwzQtQj9tTDt7QAYZA1PXiMjHlc00NWz8yUMyKh8NlIz0yVqA+aboYwpm+agQ==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 258d8fae-a026-42eb-d35a-08ded8e2a32c
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2026 09:08:24.6851 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DsGWHeadgDBsu2Wlb/GJf6TC/9xaCjeVYvt+dogMOV7/ogB/l2hV2xfJqteJvuWBnykV7e+Nc3w/Cbd3aOec5h9BcEXvBp1veWFymx94scY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0201MB8838
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDA4NiBTYWx0ZWRfX1+2GDGKz5zWQ
 +myd7ox+SEsaxjxlH68pvRMldqpNV6+quELuFbeuuMA/nkwmO3fBBjCazKMW3p6ee5sVEnPr4L3
 Z7hVAcWorgrb9kUv/btPTszHhu2vqXFGrQNy+3c6kWB20QZo+Zhm56DLndvHNrhDasIRQsBCFSn
 ODW7/N8DRMVxkWIwTR2THduixEnzRSnfs4ENvqbvk0/t+6swnG4+3KvZZGgYXoQ7gS8wx9k6zMg
 4g/MCSa+rvysW5Kk9F8Pzc/n4tmfyPYvgFiW58V6kS+UCffpWxhm2+04m9+IZwDn800WyKEvi5x
 HwK61mrCNzsF6/qNzWtSJ8CPqJXVqmzfSQqhnVxXgHo6O+pyqZM+J68UydUME3+t7g96Q4JhSv7
 QGR3Qf6aV862rzwkH2E2PbKnESmk8OVlqiOwOcaAQ7BoSXkMGrBPNRA6vokbsLErwtbw2qPqGml
 rv+J9+vpqh2lZgPRaiw==
X-Authority-Analysis: v=2.4 cv=EZz4hvmC c=1 sm=1 tr=0 ts=6a477c0a cx=c_pps
 a=HDWlEWCLQVEuMJptrEg8xw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=RAioF0-LDSMA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=y4UcunY2MAxhM4LwGdWI:22
 a=64Cc0HZtAAAA:8 a=62B12oWUieRLuCsQAtgA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDA4NiBTYWx0ZWRfXyA50cjei6B4K
 Kl5oMXAbCuw7K2WZ1MpK1/TL0jOJI4jFAp9/zHrsaH0d/oMTFhC+IaQqmftl7YvmbVS60aGBi+2
 PkvOo0Y0WLp+FvSlPlc9gcN9VVgr/Wg=
X-Proofpoint-ORIG-GUID: wduTQ51yChrTGPAlmtTaR9sAwQOHD-vV
X-Proofpoint-GUID: wduTQ51yChrTGPAlmtTaR9sAwQOHD-vV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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

This is eventually intended to be a replacement for object_property_add_alias()
which uses an object property instead of a class property.

With the advent of class properties, it is possible that QOM may attempt to
set or retrieve the value of an unset alias property. Update the existing
property_get_alias() and property_set_alias() functions to use the null visitor
if the alias target has not been set, and property_resolve_alias() to return
NULL for the same case.

This ensures that unset class alias properties accessed e.g. via the monitor do
not cause QEMU to crash.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
---
 include/qom/object.h |  11 +++++
 qom/object.c         | 106 ++++++++++++++++++++++++++++++++++++++-----
 2 files changed, 105 insertions(+), 12 deletions(-)

diff --git a/include/qom/object.h b/include/qom/object.h
index 11f55613fc..659b70651a 100644
--- a/include/qom/object.h
+++ b/include/qom/object.h
@@ -2024,6 +2024,11 @@ ObjectProperty *object_class_property_add_uint64_ptr(ObjectClass *klass,
                                           const uint64_t *v,
                                           ObjectPropertyFlags flags);
 
+typedef enum {
+    /* private */
+    OBJ_PROP_ALIAS_CLASS = 0x1,
+} ObjectPropertyAliasFlags;
+
 /**
  * object_property_add_alias:
  * @obj: the object to add a property to
@@ -2044,6 +2049,12 @@ ObjectProperty *object_class_property_add_uint64_ptr(ObjectClass *klass,
 ObjectProperty *object_property_add_alias(Object *obj, const char *name,
                                Object *target_obj, const char *target_name);
 
+ObjectProperty *
+object_class_property_add_alias(ObjectClass *klass, const char *name,
+                                ptrdiff_t offset,
+                                const char *target_type,
+                                const char *target_name);
+
 /**
  * object_property_add_const_link:
  * @obj: the object to add a property to
diff --git a/qom/object.c b/qom/object.c
index da4db3e0c7..a1b0ea19a0 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -34,6 +34,7 @@
 #include "qom/qom-qobject.h"
 #include "qobject/qbool.h"
 #include "qobject/qlist.h"
+#include "qobject/qnull.h"
 #include "qobject/qnum.h"
 #include "qobject/qstring.h"
 #include "qemu/error-report.h"
@@ -2902,14 +2903,22 @@ object_class_property_add_uint64_ptr(ObjectClass *klass, const char *name,
 }
 
 typedef struct {
-    Object *target_obj;
+    union {
+        Object *target_obj; /* if !OBJ_PROP_ALIAS_CLASS */
+        ptrdiff_t offset;   /* if OBJ_PROP_ALIAS_CLASS */
+    };
     char *target_name;
+    ObjectPropertyAliasFlags flags;
 } AliasProperty;
 
 static Object **
-object_alias_get_targetp(Object *obj, AliasProperty *lprop)
+object_alias_get_targetp(Object *obj, AliasProperty *aprop)
 {
-    return &lprop->target_obj;
+    if (aprop->flags & OBJ_PROP_ALIAS_CLASS) {
+        return (void *)obj + aprop->offset;
+    } else {
+        return &aprop->target_obj;
+    }
 }
 
 static void property_get_alias(Object *obj, Visitor *v, const char *name,
@@ -2917,10 +2926,18 @@ static void property_get_alias(Object *obj, Visitor *v, const char *name,
 {
     AliasProperty *prop = opaque;
     Object **target_obj = object_alias_get_targetp(obj, prop);
-    Visitor *alias_v = visitor_forward_field(v, prop->target_name, name);
 
-    object_property_get(*target_obj, prop->target_name, alias_v, errp);
-    visit_free(alias_v);
+    if (*target_obj) {
+        Visitor *alias_v = visitor_forward_field(v, prop->target_name, name);
+
+        object_property_get(*target_obj, prop->target_name, alias_v, errp);
+        visit_free(alias_v);
+    } else {
+        QNull *null = NULL;
+
+        visit_type_null(v, NULL, &null, errp);
+        qnull_unref(null);
+    };
 }
 
 static void property_set_alias(Object *obj, Visitor *v, const char *name,
@@ -2928,10 +2945,18 @@ static void property_set_alias(Object *obj, Visitor *v, const char *name,
 {
     AliasProperty *prop = opaque;
     Object **target_obj = object_alias_get_targetp(obj, prop);
-    Visitor *alias_v = visitor_forward_field(v, prop->target_name, name);
 
-    object_property_set(*target_obj, prop->target_name, alias_v, errp);
-    visit_free(alias_v);
+    if (*target_obj) {
+        Visitor *alias_v = visitor_forward_field(v, prop->target_name, name);
+
+        object_property_set(*target_obj, prop->target_name, alias_v, errp);
+        visit_free(alias_v);
+    } else {
+        QNull *null = NULL;
+
+        visit_type_null(v, NULL, &null, errp);
+        qnull_unref(null);
+    }
 }
 
 static Object *property_resolve_alias(Object *obj, void *opaque,
@@ -2940,15 +2965,27 @@ static Object *property_resolve_alias(Object *obj, void *opaque,
     AliasProperty *prop = opaque;
     Object **target_obj = object_alias_get_targetp(obj, prop);
 
-    return object_resolve_path_component(*target_obj, prop->target_name);
+    if (*target_obj) {
+        return object_resolve_path_component(*target_obj, prop->target_name);
+    } else {
+        return NULL;
+    }
 }
 
 static void property_release_alias(Object *obj, const char *name, void *opaque)
 {
     AliasProperty *prop = opaque;
 
-    g_free(prop->target_name);
-    g_free(prop);
+    if (!(prop->flags & OBJ_PROP_ALIAS_CLASS)) {
+        g_free(prop->target_name);
+        g_free(prop);
+    } else {
+        Object **target_obj = object_alias_get_targetp(obj, prop);
+
+        if (*target_obj) {
+            object_unref(*target_obj);
+        }
+    }
 }
 
 ObjectProperty *
@@ -2973,6 +3010,7 @@ object_property_add_alias(Object *obj, const char *name,
     prop = g_malloc(sizeof(*prop));
     prop->target_obj = target_obj;
     prop->target_name = g_strdup(target_name);
+    prop->flags = 0;
 
     op = object_property_add(obj, name, prop_type,
                              property_get_alias,
@@ -2989,6 +3027,50 @@ object_property_add_alias(Object *obj, const char *name,
     return op;
 }
 
+ObjectProperty *
+object_class_property_add_alias(ObjectClass *klass, const char *name,
+                                ptrdiff_t offset,
+                                const char *target_type,
+                                const char *target_name)
+{
+    AliasProperty *prop;
+    ObjectProperty *op;
+    ObjectProperty *target_prop;
+    ObjectClass *target_class;
+    g_autofree char *prop_type = NULL;
+
+    target_class = object_class_by_name(target_type);
+    assert(target_class);
+    target_prop = object_class_property_find(target_class, target_name);
+    assert(target_prop);
+
+    if (object_property_is_child(target_prop)) {
+        prop_type = g_strdup_printf("link%s",
+                                    target_prop->type + strlen("child"));
+    } else {
+        prop_type = g_strdup(target_prop->type);
+    }
+
+    prop = g_malloc(sizeof(*prop));
+    prop->offset = offset;
+    prop->target_name = g_strdup(target_name);
+    prop->flags = OBJ_PROP_ALIAS_CLASS;
+
+    op = object_class_property_add(klass, name, prop_type,
+                                   property_get_alias,
+                                   property_set_alias,
+                                   property_release_alias,
+                                   prop);
+    op->resolve = property_resolve_alias;
+    if (target_prop->defval) {
+        op->defval = qobject_ref(target_prop->defval);
+    }
+
+    object_class_property_set_description(klass, op->name,
+                                          target_prop->description);
+    return op;
+}
+
 void object_property_set_description(Object *obj, const char *name,
                                      const char *description)
 {
-- 
2.43.0


