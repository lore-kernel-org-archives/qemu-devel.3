Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AA62C5DF6D
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2026 13:39:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwgVC-0000nr-TA; Wed, 19 Aug 2026 09:38:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wwgVA-0000mG-LT; Wed, 19 Aug 2026 09:38:44 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wwgV8-0000hA-6L; Wed, 19 Aug 2026 09:38:44 -0400
Received: from pps.filterd (m0127844.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67JCmJc7358436; Wed, 19 Aug 2026 06:38:22 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=proofpoint20171006; bh=7Ja30Ynz5N3eR
 GhGmS0fvN69j467lJ3tRUhExMfj/4A=; b=yENITz+Sgnqdmr7TyyQPOsl5aN2AK
 Iy3atXYnwabcC8DHrscdNAOGdWr0JsirecJxWwyDG2lCQmVPqk88e0F/43WT8fdX
 5MuEZ+gSgXxE8ZJSD+X20RcYuDPm0u7k2Inb9ZPxLuHhb5s8Er+SJC6IPQofAmQW
 MuihHHW4TjGLn3gy+QzePZORPou5ApETbwJM1MF9dl+n6xxI+rYfYqgWtTLAW41Y
 SK6CNncpeZhOHZSX0P31DABuzIj6BDyT2PnFqVp3f55Yf0tii0MSa+sV0u99IV8L
 51VwKrqxRZS58FhleXcwqv7fI9y28zMHXIo7cjYEZZAJXLa+7YtBh1WsA==
Received: from ph7pr06cu001.outbound.protection.outlook.com
 (mail-westus3azon11020138.outbound.protection.outlook.com [52.101.201.138])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4g4up4ts5n-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 19 Aug 2026 06:38:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AvuDcFj8tle04qOILNyqMDH70ZusfBfPd/d1Pc9MNOrsUr74BAUhmvKdACSHn868RVcTj7LFOCDhnOatWPqqYQ0GGwonIQtUNjhiTZofJhUPCk7yoiR3dOURmvq1bHxDS6mwyG/EFm/Q1u4TzXnUkDGESPQJkxy1mZbRxM4vbPdb2WB5Rnp4dIAo4/QA6RQ/uC+qeLlyah6NGyVklKR/vAIVg6roNBw/As9YRj0OuEdv9ZlwwNSv8MTuxSc/IYoKUnRwNGETwFPCe24TMq8UV04BcDC/aJp9FaGtYzdwhGKwYDiWITQ5Muwzw3hReulXBEev8hZl6I1aJMIdeeffoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7Ja30Ynz5N3eRGhGmS0fvN69j467lJ3tRUhExMfj/4A=;
 b=gh9x9f+oBVYsM1KxmkP8ePPNMJUmfekrxTEU78tY2h9afgSK/zaCrlyYaCplF/Nb4vODA/4AnDCD0naQN7Khc7kRZMAphLsh28jUZSkb57Y7cWN6cAT5d+DRju8axKaVP6VXBOs56+rE71CTCd1Y3dJBPegn/hmNGUVIBewP1pvyObs5HWJy57Sf0HN+NXy1rIb4bES3G9NGZEbpRcrSNN6SpAqWmi2GEwMV2wDZxBq2cf//224klo4sHCtDOlPmK/6TWXUzzim06P+LaBOPxf2fj4bPoDRzPut5dMYULGFqpu/gVwD+p/fulM20caT7MPi7o2sUyeVWJ2hp53WWWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7Ja30Ynz5N3eRGhGmS0fvN69j467lJ3tRUhExMfj/4A=;
 b=BIAvmyuWDCUKuBEHi++yWDlGEZnoUeRg5JWLy7MZt/rxQYUNTFPKXR6hElTj9LLh/DFsqjdv/93JTYZ2E/SNMbHZQPN+ddYkVDCnhr1wTBGmoXoPVQ1HeikKWQKW4/l4W93rXyH4WC7SdhOLsyf9X1Yk/aJy/9S5QzT90LMSqnX1xAAvcu3Bp2yhHPvkfTtYi7gTv6oq5wS8T9kYBFatCXvtadV8ekDywzuVQldtR9/tQ+8Dr1lkoKg2pJogdY+ETE6SVtN/jM6hMXK68H3r198bibqTVcvGPwdKh9KoAHYUaa/CROqJRgDvfAWbrucIaZOwhN+PVx9j15XRJwlDjA==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by PH0PR02MB7336.namprd02.prod.outlook.com (2603:10b6:510:d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Wed, 19 Aug
 2026 13:38:19 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%3]) with mapi id 15.21.0339.007; Wed, 19 Aug 2026
 13:38:19 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: mst@redhat.com, imammedo@redhat.com, anisinha@redhat.com, philmd@mailo.com,
 aurelien@aurel32.net, peter.maydell@linaro.org, pbonzini@redhat.com,
 richard.henderson@linaro.org, berrange@redhat.com,
 marcandre.lureau@redhat.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org
Subject: [PATCH v3 00/15] hw/acpi: convert object props to class props
Date: Wed, 19 Aug 2026 14:35:39 +0100
Message-ID: <20260819133816.3497033-1-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA1PR03CA0014.namprd03.prod.outlook.com
 (2603:10b6:806:2d3::10) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|PH0PR02MB7336:EE_
X-MS-Office365-Filtering-Correlation-Id: 457a3a29-7d06-4391-1c0c-08defdf7214a
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|7416014|23010399003|921020|6133799003|3023799007|56012099006|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info: ta2P4syWbhALce8kEaFRa8Jyi+8a2veDSKorUlE1uErrqDFP1f6DNCexttzi+3/CT5xkk0v9jZdQS6gbNa4KYdBg/rAcEZsAKKEr7IjsyNe29GS4OqwJUp6c9lV9rgosI2//zsOuVkxvvHpluHerG0N7Pd9C/mvZ6dtJxLED3JhKOvDx0Lu+PIt44pG44W1NFju4n99FHOCy4ATplQ1zzP/LXgNeQ+As5Ifqo6chKuX2649nKFRMWhXuQm/RDAUCjQ3nxjbRNghLxe4V/eBNF0sAgSpatFnGglSCfNY5q/7gxTNCBhrYYFPDfPf7S5KKgGcqDsbwNFG/4U/pieaWQz4J7T6fm7s3QgmnVhMPMfYBytfRk1m/sQZ0+fABYBIIubgLIB9m7GRx66tNVP9xJquhjzVeGLQ2mKQkXniw1REAuWwO+SHYVFUmcMq70SwuKZArsafbrvPownc4Y/0U+hpvB8IuIflbSx5ha6Nbk/wD0N/eIovczuE7OLxdGaeYM8LB0/YnSz/l89YMSdqs/ie48lWLJiQQX75DPw4ehIPcc5ILvtJLUiRsDbr4hldARKBugama3ZHoFo176RE6Ql35WxIshnWrPxOEuTrzjpLim5W+djtUT0BjL0sYC6c9tB1WZUjpeAyasrM9if6ft6YuBvO+hrkq+biA3NuA/9A=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7416014)(23010399003)(921020)(6133799003)(3023799007)(56012099006)(10067099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dUxHNmZlYnJCUk9vUStuUkZRS2V2dHVMS2RhUVljSlpyMDlrMTBMUmlpRFVO?=
 =?utf-8?B?cEJ1MURTRWNDUXlSaHJXTE1kZXBpWlYwZlpQY20rbUEyNkxFTEJJaXpRZm9v?=
 =?utf-8?B?dXYzcit2MmlGc0pweDd5OTllQjc0cjA3L2F1QlhicXNJM1NkUVlXVEFKYzBV?=
 =?utf-8?B?L0w4Vzd1eE1EM0kwT3FqOFNVT1oyK2RwUWM1RzFkSFh5ZGlRSlE0Si82ZjhI?=
 =?utf-8?B?VzI0c2xUWU10c3hjU0JqeTRVWTI1SkdnN05UdHlIUndTR2dlTm9yN1VMTkRu?=
 =?utf-8?B?dHU0aElTOFdZRkt5UFZLUzNaaTBTQUEzNnp3cFBydGMwcTBOcllsbHZQQ2RZ?=
 =?utf-8?B?V285UXF0RldwTE00YnFwT3FEb0FuWW9xT2txVGZHZVRHZjdWVzFWeVpML0pW?=
 =?utf-8?B?aHhueU9pckJNcVloeHhzRTlybG1ReWU0R2dXUVU1SXNzNEY1UzU5ZUREZ2sr?=
 =?utf-8?B?WTl2R0wweEFNclJ6QUloT21taHpHVVo4c3Q5TDZWbUIxWXg3NkVTVklRS0hh?=
 =?utf-8?B?ZWZuUUovV1lsQVJxeGlTS3ZzTUs4dndDUUxPbVVTYzRhMHJYUHZ1TzJ6d096?=
 =?utf-8?B?YklCSWRLYXZQUUE3MmYyS25YRk5JMVdyOXV2MWR6c2xzZENUUUFzRDFEdDRL?=
 =?utf-8?B?MmV1cEkwTmpwWjVmbnRGNTB1WG9zeTZuY2lqVkR2UTlnK01vUU56N29RNGJy?=
 =?utf-8?B?MTF6ZEZtODR6Yk8vWStIRU5qdCtCOEdJQy9NTnZST1htdmd5amVRS3lJM05o?=
 =?utf-8?B?bEFtRE1RMEd6QjFnTkxNZHo4ejRIUGlpVTF2dWZnSU9tRlRPdERWOGxRcG9q?=
 =?utf-8?B?N2NQVHhDM3BMTW5YRzliQkVZWkdxR1UrQXROanBMeHlQQU0rdzdzS1NxbGRB?=
 =?utf-8?B?aTNXQk5Sc3FmamdjdWF5U0RNZzN4WGFvb0lTMzNUMzZ5VzZuekVTK205VEMz?=
 =?utf-8?B?ajVFOEZxQjRMa3dMelA4bS9TT2hid0NVVUZ2ZlVKMjA0ZnBpd2R6WkovVWxw?=
 =?utf-8?B?WGEvRG8vbytMOGJmamlYREpyVnZRTTB6N2EvYUZMTUhzc1NjRW0zNjhrUVJy?=
 =?utf-8?B?S21CeTdTY2c0TFNHOTZEM2toT3ZpUmZvbW14Z29UdG1iN2laMGdrRkRKSC9t?=
 =?utf-8?B?eTRyUXBrWDBTcjRkUm5GeFNoWHlrWWVBMUJmQmJXZUl4WVZYSjVPbSs0U3lj?=
 =?utf-8?B?OGNxVnBaUDRtcWdsUmpDRGptRGg3WGZBVFJ4OTAzaUJaSWhtZERReC9SSzNy?=
 =?utf-8?B?UXc5RSt0VjRDSVc3bjdRWXcwWmJLOGpmeDVlNzNUem5IUXVld2tEdGVyNk1H?=
 =?utf-8?B?RXI3OTNBWEVsSTFvYUhCMHFWOU02ZkNheDBvbUpmc2xiSS9YOFNYa2RYTWdZ?=
 =?utf-8?B?UkNaTDVXSStDbVZFRG1YbWpMb2xFVW04RW9CV0FSVC9ZaTFNWlFENFBROHc1?=
 =?utf-8?B?Q28xYnNtalNuZHhaaTBhbFhvUC9hVXV5NU8vWElsYXRUbDVFTWlZcFUyMEhI?=
 =?utf-8?B?ZitBd3ZuTnpTTFM2eEMwaG1GckNvQzV6YmJqV2F3VnJObEc5M1lCWTEzNkVx?=
 =?utf-8?B?NldOci9wWUllWlZFSkJlRXY2eWlXWWovWTJBcG42UjdHZ05kazM3RXp4Y1NN?=
 =?utf-8?B?ZU12U3ExaWJLaDFIZnVsL1AzVlQ2UE55bFRJSkNQNTlmcHJpNkNmV2RvbE1r?=
 =?utf-8?B?d2VzbGYzN0RLRnE5eHc3MXprZy9tTndPQkRvTHJ3OWJsRmVYbXkvSS9HRVZn?=
 =?utf-8?B?ZHJoaE1EQ2VHY01RYnNPaFBzVlF3K09nMTFWUXhtRzZwa3NMeGxBVDBqWW55?=
 =?utf-8?B?dmhkMWNNVWxLQ2N6MGdPSTdpSHlnakJoNTVSZk9lL0wwL1Q0V1prRWRBZjNw?=
 =?utf-8?B?bFdnK0s5M0NLTXIzWVc4cVVZNTRWdmtFMmIyVmVkNmVlWDdYME5VWjVXWmha?=
 =?utf-8?B?MnQxOVhlQlZ2V2R5MzViMk5QdDl5aHRxdVN3RkM1M29OcDJ6YkxvaWlEdkp3?=
 =?utf-8?B?VzFXbEZpVTZ3NU1JeENzczlZOXp5YkliMlFEY2poRDdFekp6b1A5ZlR6UitX?=
 =?utf-8?B?SldzQUIxWEVVa0RBWmtrUlBZQVZoei8xMkk2eG9VSVNpalp2aWxKMHI2TStJ?=
 =?utf-8?B?UnVaNEFuV1ZWaHVSUWNXaGdndDJCdmRQNTNJNDZ6bjFaZXl2VFZ5SHE2ZjlM?=
 =?utf-8?B?djRybGZxTHZIVHFyOUxhT3psNGc0YWdNVG5meGU5eHB0TXFZeFBHZDZmTm1t?=
 =?utf-8?B?Y2lId29DeFdob3I5K1kyeTFIOGxCdk11Yyt2bnNDM09EVy9GcDdJV1JadlJj?=
 =?utf-8?B?V0pVKzAzOS9seWM2MXRuNGpUdmZzeGVhSDh4d0N5M3ZpaWNYZzlKeitlamVv?=
 =?utf-8?Q?+TmF04Ch74WyJ9w4=3D?=
X-Exchange-RoutingPolicyChecked: ke3tZmeBsf5EskV+IZCRpHHCOg3QzyavA0fzSNHDPoEVOfIhQ7JnVwqjNwOK8B9VwtRJy7S1BN/1GVLC8QB7dx6Jsaehtlr3oLJqH5PH67FoBw/nbF18XtjrMrj09WeB2JNvt4wbjycii7eEpUvmPeXQUC53Na/ZJhTB8t3+DHq4Neq4o8uq2Ocmg0vnOROwl1TrS5hdPYQVOXZ72U0ERZuFeCGYOX5IQoSelzbfzypGe06UaJudv/NfNuONeBfbpzt+9yzOJ0nx8AJxE/QdYDrV4CC4rZkvUrY/vAS91PM/E1jwaHEqI9KhkpYGgZPRzkmGyQ4JCe+l0jXcwrp3tA==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 457a3a29-7d06-4391-1c0c-08defdf7214a
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2026 13:38:19.2232 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6vKVyp+3Hj7guhqNlEKXmeZPWdbeZKulMeqlayeViA/FCwf9zn66IYYFGzlchjuJXI+42rL5hQc1k0ERcTcIIj7zHC8uPxANWTXvPCdKpXc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB7336
X-Proofpoint-ORIG-GUID: e7AvcyWZ6MEXGI3FF3t9LyI5oqJwmlHi
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE5MDEwNiBTYWx0ZWRfXxlr2uNu1rRn5
 398qTZCd1ZImBMtvf7Dft5GMKTStX1C1qYyw/aRVdfGhB5OuwSPHRHdvO2FAYlPXIcyWS9hFcJp
 F/q4aTV8Q4eXXSKpKIqVtNVjP+g/D0s=
X-Proofpoint-GUID: e7AvcyWZ6MEXGI3FF3t9LyI5oqJwmlHi
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE5MDEwNiBTYWx0ZWRfX34FS66lw46na
 484+gdNkHExTfRzWrE4kLamjMsnWFdIXSulC3b5BXlct57VJf/g3PdnK+BOiUyss3sMujyY8KE9
 6dndqQKGrE9FOsiaancAaFty9SU9U5R2d5Qh3J4PH3hI0P2uDpfUiPJoyiUZgPCQG1vfK3ak1W5
 94LKrtEnBTqPNRLtBH1jrmuipvncdhsqb93YsXC3jLxl0wC0eA21FusUNXlTjugu+VhP6GDcIwe
 Ml0fAQpIqJVljBZTC79rLGd3WF464XH5JA0iDf5wEhqvuzT9P/EWUDZM5OmGErArZSOCnmU5iQ0
 VrH/FKg2fAMe0YWoqgxl8uE0r4r/lu97r8buae5mPRZpmTii5+QgQYu+oYAfnI4zqU/rcn1b5I0
 s+yI0g5TfqBEja6mXM43YmRMMK51+aLhH8/6MA3Zbo2MbFVFb5SdcayAX7UtKHAD6pebP/rmOzT
 IM+psPP4xp0qbYdKziA==
X-Authority-Analysis: v=2.4 cv=JpDBas4C c=1 sm=1 tr=0 ts=6a85b1ce cx=c_pps
 a=jcumTT0saVzx4HVuorHqQw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=0LlEyIVc8U2lsR7dKhuH:22
 a=mDV3o1hIAAAA:8 a=GaQpPoNlAAAA:8 a=20KFwNOVAAAA:8 a=64Cc0HZtAAAA:8
 a=d2J3Bb07bGXQncvXG3QA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=xF5q_uoM5gZT5J3czcBi:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_03,2026-08-19_01,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.341,
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

[Background: based upon Peter's feedback at
 https://lists.gnu.org/archive/html/qemu-devel/2026-06/msg07717.html I realised
 that what we really need are object_class_property_add_*_ptr() equivalents to
 the existing object_property_add_*_ptr() functions to make it easier to
 convert existing properties.

 There are actually existing functions with these names that are already in use
 but after observation these are really static properties, so these are renamed
 to aid porting object props to class props, as well as making the difference
 clearer.]

[Note: this will have substantial conflicts with Marc-André's series "qom/qdev:
 associate properties with QAPI schema types" at
 https://patchew.org/QEMU/20260818-qom-qapi-v3-0-24b8bbbe3d86@redhat.com/.]

Since the use of object props is effectively deprecated, here is an attempt
to convert all use of object props in hw/acpi to class props. The eventual
aim is to continue working through the codebase, removing all remaining uses
of object props.

The series is lightly tested: it passes "make check", GitLab CI and some
simple local tests. I'm mostly interested for feedback on the conversion
strategy, and to get a feel for the best way to merge this series since once
the basic conversion patterns are in place, the same patterns can be applied
elsewhere and it would be good to minimise the merge window for such changes.

The following warnings below are generated by checkpatch but are incorrect
since they form part of macro definitions:

1/15 Checking commit 58e8d5fb5971 (qom/object.c: introduce OBJECT_CLASS_PROPERTY_SCALAR_GETTER(type) macro)
ERROR: spaces required around that '*' (ctx:WxB)
#41: FILE: qom/object.c:2720:
+        type##_t value = *(type##_t *)object_class_prop_ptr(obj, \
                                     ^

total: 1 errors, 0 warnings, 28 lines checked

Patch 1/15 has style problems, please review.  If any of these errors
are false positives report them to the maintainer, see
CHECKPATCH in MAINTAINERS.

2/15 Checking commit 2068ae0d4ded (qom/object.c: introduce OBJECT_CLASS_PROPERTY_SCALAR_SETTER(type) macro)
ERROR: spaces required around that '*' (ctx:WxV)
#28: FILE: qom/object.c:2730:
+        type##_t *field = (type##_t *)object_class_prop_ptr(obj, \
                  ^

ERROR: spaces required around that '*' (ctx:WxB)
#28: FILE: qom/object.c:2730:
+        type##_t *field = (type##_t *)object_class_prop_ptr(obj, \


Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>


v3:
- Re-implement the object_class_property_add_*_ptr() get/set functions using
  new OBJECT_CLASS_PROPERTY_SCALAR_GETTER() and
  OBJECT_CLASS_PROPERTY_SCALAR_SETTER() macros, similar as has already been
  done for object properties

- Drop most R-B tags since nearly all patches have changed since v2

- Split conversion of static variables to static class properties into separate
  commits to act as a reference for future conversions

- Drop patch 6 from v2 since that has already been merged separately by Phil

- Use UINT32_MAX to indicate ACPI_PCIHP_PROP_BSEL has not been set in patch 13
  instead of -1. This is because the existing object_property_add_*_ptr()
  functions always use unsigned scalars: let's try and keep this the same for the
  object_class_property_add_*_ptr() functions if possible

- Add a new object_class_property_add_bool_ptr() function rather than using
  object_class_property_add_bool() in patch 10 since it avoids writing explicit
  helpers for each property, and there will likely be other cases in future

- Rebase onto master


v2:
- Add object_class_property_add_*_ptr() functions matching the existing
  object_property_add_*_ptr() functions for class functions

- Rework patch to use new functions instead of manually adding get/set
  functions as part of the conversion

- Ignore existing R-Bs since this approach is quite different to v1

- Rebase onto master


Mark Cave-Ayland (15):
  qom/object.c: introduce OBJECT_CLASS_PROPERTY_SCALAR_GETTER(type)
    macro
  qom/object.c: introduce OBJECT_CLASS_PROPERTY_SCALAR_SETTER(type)
    macro
  qom/object.c: introduce DEFINE_OBJECT_CLASS_PROPERTY_SCALAR_METHODS()
    macro
  qom/object.c: add object_class_property_add_uint8_ptr()
  hw/isa/lpc_ich9.c: convert ich9_lpc_initfn() object props to class
    props
  hw/acpi/ich9.c: don't pass ICH9LPCPMRegs via opaque for
    ACPI_PM_PROP_GPE0_BLK prop
  qom/object.c: add object_class_property_add_uint32_ptr()
  hw/acpi/ich9.c: convert ACPI_PM_PROP_GPE0_BLK_LEN to a static class
    property
  qom/object.c: add object_class_property_add_bool_ptr()
  hw/acpi/ich9.c: convert object props in ICH9_LPC_DEVICE to class props
  qom/object.c: add object_class_property_add_uint16_ptr()
  hw/acpi/pcihp.c: convert ACPI_PCIHP_IO_BASE_PROP and
    ACPI_PCIHP_IO_BASE_PROP to class props
  hw/acpi/pcihp.c: convert ACPI_PCIHP_PROP_BSEL from object prop to
    class prop
  hw/acpi/piix4.c: convert static variables to static class properties
  hw/acpi/piix4.c: convert ACPI_PM_PROP_PM_IO_BASE to a class prop

 include/hw/acpi/ich9.h         |   2 +-
 include/hw/pci/pci_bus.h       |   2 +
 include/qom/object.h           |  72 ++++++++++++++++
 hw/acpi/generic_event_device.c |  10 +++
 hw/acpi/ich9.c                 | 126 +++++++++++++--------------
 hw/acpi/pci-bridge.c           |   9 +-
 hw/acpi/pcihp.c                |  35 +++-----
 hw/acpi/piix4.c                |  51 +++++++----
 hw/arm/virt-acpi-build.c       |   7 +-
 hw/i386/acpi-build.c           |   7 +-
 hw/isa/lpc_ich9.c              |  33 +++++---
 hw/pci/pci.c                   |   7 ++
 qom/object.c                   | 150 +++++++++++++++++++++++++++++++++
 13 files changed, 389 insertions(+), 122 deletions(-)

-- 
2.43.0


