Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 758C2CD98CE
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2026 12:59:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXf0U-0001u9-I6; Thu, 11 Jun 2026 08:59:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wXf0S-0001tf-Ja; Thu, 11 Jun 2026 08:59:36 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wXf0Q-0008Px-LC; Thu, 11 Jun 2026 08:59:36 -0400
Received: from pps.filterd (m0127838.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65BCZx3U3989158; Thu, 11 Jun 2026 05:59:27 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=y9Fr5S0rC3M4f1PH/zfOfhcEtm58bLzvEQTQAOZ35
 G4=; b=hIbga6wN16PM0+eDXaRYY9nmUmLtUEy6wHd7OAAjz7HPA9QMG33bPeSzu
 Y3Q+yiMFbjH4142zY1gyWD7GcFX3BhTnIozk3hDzgBrpAXX8BhcqflL+dApFxY70
 BZLbofwM6jT2+iDzb03LZ/LJekpbevo1MJAd4l6qyBHSlPYGJ+moqLSKm6Q6MCkD
 sOgyXkfz5sQxQZ2D4umF8OV9RPJ+Flty5Lx1wogdQZFixfMeOnrl6U2TDj/TmDCG
 NR9+aOmpD2dg0N2cjLMPIg1X//PYb5ywYBNbLPMrMtOLVQqD88SacrmoYyQCNJWm
 RWj8XHW12CORCFGhLMfCrcULLSgqg==
Received: from ph8pr06cu001.outbound.protection.outlook.com
 (mail-westus3azon11022129.outbound.protection.outlook.com [40.107.209.129])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4eqe5p23fa-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 11 Jun 2026 05:59:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mzyNn+aZ6ix88d/LAluRDlOeMvlqAXeWwM6/vaVGCx4R6tp215TGnnMuEwPBKBwemJ0pU5XQU2r5BrLiCxepqKI14vVxVo3mRbqcukpupe6zSdJDKaTDcqF8f+9lsLvL6VJ+3GFMdiKBFOEz5EKJkU6fnYCLxBsnhkJeEtIsIgenZam68+/ocZemSAdnoRbr/TULiJOpLK4RFuuXu64g2tEv7EZcJ4rjHNvsKjV+zp+igRZfAiPfE9h+k3QJJsIUm6fE4Ut0hnqPdrRntNNgsOlT+W1zpRp3LdnEJcr19qMA4YN3ichHw+NivB7LlXNdZfuYINQXloHJCvc2oBvzcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y9Fr5S0rC3M4f1PH/zfOfhcEtm58bLzvEQTQAOZ35G4=;
 b=fWDtRfEsdE2e3wvZ7uFdUWtR9D070qiIhr+/I5J7Qu9AuqK7/PzJiR8MwDvY0Jb9/zzrz/Nxv6ZnED9V8onnYggcIhitm+e9cg/Yb3r978Q6CLv4Oxuj/Qfx8dz9sv/pE5jfIFje0oSUfUhvvYu+XJ7RnOR8XeTTpR9A6tCoj/Xx6WuikMDyWo+JQduAa3kkN3DuwMPxfmWO5Nyy8wURELUTC6J985uMxqtcnaHWK0mRtRObty0nCDdAsdeTtrATtvcdAhjiPYnH99Ks+htOr03rOVNi/fLw50Irz5D/H1nyXB4RGUAtniKTPOxY7PYCVZ6yzk+Liy2u4nsrTSd7ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y9Fr5S0rC3M4f1PH/zfOfhcEtm58bLzvEQTQAOZ35G4=;
 b=ZK8iarzdllJ2zX36QRcOhefNhtSE2DenAPmwJAY9+e32d2QDdY2oYLik9e6pzM3K/pJpYbBVQO2jzCZAaXZXIPYRA/LLWueVa6Jf1uDegdr7AtxW2ahYan6yYLedSXBtDEFxmqWyxciUkE8UY5AurFtqJdMhNa9Ff2ge+ipBrzDf5GbRIm2536bu/UCNvyZ2jwsP03upVrB4gwPrMJSUFbgXagDiA4cUdBBZUkZWsT523Q62qOReRFEWJwcs7zhqSREbvAMAvxrwZnTWJMK8DvyzdhezXcsMBrbFf9UvF85KriqhUAtgTeY7iqQxL0/ODrdQy+61zowi6z4SkT40ew==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by CH0PR02MB8117.namprd02.prod.outlook.com (2603:10b6:610:10a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.13; Thu, 11 Jun
 2026 12:59:26 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%3]) with mapi id 15.21.0113.013; Thu, 11 Jun 2026
 12:59:25 +0000
Message-ID: <14c293f8-8f37-4705-b84e-7ee583ecf35b@nutanix.com>
Date: Thu, 11 Jun 2026 13:59:19 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/10] qom: Add object_property_add_bool_ptr()
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Fabiano Rosas <farosas@suse.de>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Peter Maydell <peter.maydell@linaro.org>,
 "Dr . David Alan Gilbert" <dave@treblig.org>, Eric Blake
 <eblake@redhat.com>, Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Sana Sharma <sansshar@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Juraj Marcin <jmarcin@redhat.com>, qemu-rust@nongnu.org,
 Markus Armbruster <armbru@redhat.com>
References: <20260609172514.2037645-1-peterx@redhat.com>
 <20260609172514.2037645-7-peterx@redhat.com>
Content-Language: en-US
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
In-Reply-To: <20260609172514.2037645-7-peterx@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CY5PR18CA0024.namprd18.prod.outlook.com
 (2603:10b6:930:5::28) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|CH0PR02MB8117:EE_
X-MS-Office365-Filtering-Correlation-Id: fb3837ce-d439-40e3-dbce-08dec7b94401
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|7416014|366016|4143699003|18002099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info: m7GondMUxFw+JNZgnGmr8xpI0tw7M6KAhMJe61JEUHzPzVn7Y2RKkS36Uyv4PIt5u0R0+8D4Ce07CHY7mstybslD0PqeptODbeI4j4jH5bl32e1nYqUNuVF0qe/nty7AoGuN1NcE7VdPZdfmUiHyL44tIQWUjqiv+/lmSD755DqJQM4AyUFS6H2PxSOu7tA2glryVDr4cD9dycskvGXxq5uabkb32jEq+vKjVK58XUN5SgNvbcAi+Oo1Mx6r6CzTQ45A5RUOX7Ck0IP+/MSmaZ4+hDzABs4NM1kGyw60SUyXRfw0QshORMcAClpu1rhegT8aecLyAG/uouNHAAHzwISq1bxDj1ucMjt58UrsPq5fGohrWPad/pcPYHWm3Z07GvB6ovLLv1vtAao3NCa6+WE82tCYRhiI1ijIPaWqDZTbjb/T7OBInM3CJUpecl9G54+t6Q9QEkebMvxBxZyvGYGs+qib76h/uA4VBggg6qdefMrtkTcnAa7fpTg99xvW/B6ot63udp7GM/jqOrhE0GFA0rlv8CDQXxRlxJceHqya4Bb4x7H4ccOpUK+G9yWmnFB7omcclxYsZJJVsqaXma3rIfN0BZDiiLlL56OfRYOexrE5QIExvcZh/FVVOY2vN6fysbaO7cNI6m43WZVh9fltEIdVaUnCL8BBOr48+FlTLmRBWbAAqKY38uoHHUrr
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(7416014)(366016)(4143699003)(18002099003)(22082099003)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UTIwUDYrS3BlVElvdVpJdVBxNmJ0Ni94cTRNOWpDMDh5Ylo4dDMwWmIrOWIy?=
 =?utf-8?B?ZnM0OHBqcWZZYllxRDdwclJOazBicmNDWHJYQmtpQzJhV2FYNENKN1NRNzFs?=
 =?utf-8?B?eUo0T2VWTUUvZkZnT3RvSkwrZ1lvc3lWaWNxY3F3Zk5aeFNlTnRSZnFYeUYr?=
 =?utf-8?B?dWFSS0s3MDVZUlRKTXJDbEhnLytIQm9SM1puWjhETEl2a2Radm5qMHlWQ0oz?=
 =?utf-8?B?bEg0ZHBZVm1mRXgvZ29ZVndSN0F2V3R6c1VRMmJ0aktsdzBNaURPRnJtTURP?=
 =?utf-8?B?dDFhNWhTVWljc3U4TzlLK1U1RmJmQ3F3Yk8yZGNDTk4rOFp6SXhDMkRkYzEy?=
 =?utf-8?B?elhiZTFsRFFpcXhyWjQ4UFFqRzdidEQ0USsxcmhqcUJUR2ptdjRxelJIYVZ4?=
 =?utf-8?B?QUQ0SkZiZnMrbXRKWjZ1R2NHUHJiN3dtR0p5VnVwVHdJQ0FSZHl2VEFLaDlm?=
 =?utf-8?B?WERzR1pxSDM3VGI4Uk0xZ2ZHdmNvbzRzaDVHMDQyQ2J1ZkV3R0psQ1VKdW45?=
 =?utf-8?B?bEROK25kUHlhV3F4NUt6MEc3dHppcDNCQVlXM0I1NE8zbnlxbGxCVklTQzNv?=
 =?utf-8?B?REtiKzd4T0laeXB2Y0lOd2NtU01wcWJHL09LSFlMQ2N2c3pjVDQwNG9YdFE5?=
 =?utf-8?B?bHhtUyt4bU1GTGJ5UFMvcjRSNDZsdDBTVFgvNDQrZzA0L3ExaW00SEprcGVt?=
 =?utf-8?B?d2ZWcE1yWU5aa2tCMXJxUThLeDRUZkoxY0lhb2djQTBPcjJsUTBVcVphVU00?=
 =?utf-8?B?UlVHZ1FQandFLzBDaXpiOVhLa0llNnMxUnlxYjQxRWEwcndHc3FFdWpSY2d1?=
 =?utf-8?B?c1huTGRHZVFCWEtOUXRrTnowdm1ESFhTcnFCVUJtSm5YRHdzVG1Xc3lOczNQ?=
 =?utf-8?B?SnZTbitrUFVCQXNUMmtjbktueDNWbFdRa3VVR2hSdHhtNkh6WkVWYnEydDJE?=
 =?utf-8?B?MTBZSlJwRElVRlZ3ZXcyMnpocHVjam9wRFpKemkrRWZwYitiTmVpa0hlY2ZN?=
 =?utf-8?B?MHdibFk3YkFSckprWUM0alR6Y3lLNDJwbm9KK3E5RTJ1WS93N0JFNzJ6SGtZ?=
 =?utf-8?B?OUlzcHZqb2FiaGE0K3YrWGFiSks3dks5QTlGTzNZUUNudC9ncGc3MmhIaUM0?=
 =?utf-8?B?TmdwdHp6MVRQOFQ2WnVwY1hhbURlcXFVbnlnTmdSNUV3M3QzWG5TcXN2MmVw?=
 =?utf-8?B?N1FObTg3T0tocmlEbThLbmNMdmI0VjAzU0Zza2t3TWpEdDE4LzVxYWtwTGtB?=
 =?utf-8?B?NElXeFZteFQ2V1JCcDBhOHdTL2VLQUQ3M3ZFZ0xsN2F2dHRVaVU0YUN3ajda?=
 =?utf-8?B?bUErMm92ejJyZk4yT2dsRVZ2L1h6YjNCb3lVOEM3Q1RSUjhQbkRPbFNUVXJh?=
 =?utf-8?B?RFFyNzNpZWV0UUhYUm1YSWNRNnMxbDZ5eFV5aklHNmlPTjd2MnpXVzAzUGhr?=
 =?utf-8?B?T3NlYW9rYklSNnR1Q2NBT0pLdmdFQVNrUmVuYXdXYU52QTE3alRoWFA1UXpr?=
 =?utf-8?B?OTRSOE51K3JJTGJKbmhKS0hIb2RJUkhXL3NWWFAzVW1FZit6VEZWTkdPYTNS?=
 =?utf-8?B?OXdEVm9LeDk3WjZFREhCT2cwZ1Y2WEl2K1E1czJOT3lyeEQ1d083a3JaNDFC?=
 =?utf-8?B?MEVFeEN3WVY1dElDcWpPeUpXb1ZVUEcwRVlVaDgxMFl1SW5qdXVqK25GNU4y?=
 =?utf-8?B?Nk1qMFRBbXFiRG1lUitBU2laaXBZS0lHRldMTXVxUkNQd2NUOHVUUlNyNmE2?=
 =?utf-8?B?YURIZEVzdEhON2ZTZ2RKMXEvcm1MMkNNRnNYSWh4TXo2RkE0SEJzQ2VyWnVl?=
 =?utf-8?B?dGUybXEwMHpqZlUxdWNyc0d2bWJBTWxBeDMxZ2V6YWdScXZSdll4OFMyR3Bq?=
 =?utf-8?B?RUk0SjFXRFBQRWxuWVVscVk1V05IK1RKaGtzV0hFNm9QZzBZN3h2YmpaZE5G?=
 =?utf-8?B?My9ib0xnR21kb2pqZXgyR1gyeHIwdHUxNVBlSjRLQkxwV3ZDeXBjb0xZeXla?=
 =?utf-8?B?VW5jRDJPZy8zZ0F3TDhPKytMZDVROEUxMDM1YVlPOWZHbDBXckt4bndTK0Rj?=
 =?utf-8?B?WGJ5Ymx6U1g4QTNyQUtpSW1jRDRaUEdkWjlrenVPYnA4T3BsTmN4c0JiU01N?=
 =?utf-8?B?a1VHa2JHZHRKSUhrcitoRG0xOVlGZTFyeWFQRG14WTJBRzZ5ZWJUOWRSQTlh?=
 =?utf-8?B?WXpVQjErSnpMWnZEcnZ3OEU4SzA0bmhNRTYrNHAzYXNla1pSMVFKZ3pQYjF1?=
 =?utf-8?B?M05EcmROeFkxeE1MYTZ4TmsxUmcvbzRuUnJyUWNOMjBUSmJqWXcxdlBQQVFo?=
 =?utf-8?B?WDhvWVd5c1JEb2JmbFc1NDA5Y0dTV1h5NHpMdE5WNWd3SFg4NXJhQkFmOTV6?=
 =?utf-8?Q?lCOmbd3wSBCvpKLA=3D?=
X-Exchange-RoutingPolicyChecked: CtrJAJXKv2E52ldNFYdfhOQjKtWVmWg40l7mCK+ya9xsPkX2BY76np2n5cqN+2FvqprBiv4LWNrtH8AHVuf/FbfMJDLbZfqt0u+cGb8yeH1tyBdm1gX9ydJwSFH1D8Z2rEX6tQi1hij7lHaXt9mhSr5sHZ0jfQJ5BR4Jmi5zDBKTCdCb1BWR7SQFn3YHTlR3rIGUWHiZSZbaH3MW81EPTyva2LS34JiHBziobJbXc3ei0YxxlpnF+xSnEnnt7QuZBwL1k2120tWnKh1ttzPXWbhdMQT/HLtDC7IBO1+vZ/uiyQSIkEeSsfvnmGIRpMlmTXNWnHKqqOrEVOfOOZyDMw==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb3837ce-d439-40e3-dbce-08dec7b94401
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2026 12:59:25.9004 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /yPz1+59wo+Imlr7i4vElJHN3SZ76YpSfiS5NWEEsm+T4lrT/sFuX8KynjM5SzjTI+9G+KKQUgs4DTNfoUIIaF3ezkRBIY1vgKpI/pjypLk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR02MB8117
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjExMDEzMCBTYWx0ZWRfXy7tSNqL0W9cS
 FahhmczUIT2XlEHtZS9NkZ2VhE+WJ9YtvhnC2XzYVOEykss/xCaTGzbeFQORM+nL89QJq/ghe/R
 OU4sG1eNK30Lh00VxXmCVoQefJlsUJE=
X-Proofpoint-ORIG-GUID: zQohPlYhzbPBQMo-tLLO2DJS4Hy7nYBa
X-Authority-Analysis: v=2.4 cv=CJoamxrD c=1 sm=1 tr=0 ts=6a2ab12f cx=c_pps
 a=6Bt0GI45FyvFQl6hnU1EVQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=1L6crL_YRTbalZ11mEUO:22
 a=20KFwNOVAAAA:8 a=64Cc0HZtAAAA:8 a=AfW13u5GCiaIJOskeVQA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: zQohPlYhzbPBQMo-tLLO2DJS4Hy7nYBa
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjExMDEzMCBTYWx0ZWRfXwJHjbh1O8veT
 t/P0tPIoGYNFQaVKFcv1cT7gN8oiJ4XWuxR4F4AhmF6qZWVsGjaMqBriH0PccO+NBzTzo9q5RZd
 rmd8FjU63l5OhURoR6rbBB1Vsu6wVbcDFUvLkPfK11Il9b+xFZBjK2NGetUS6ebFXUbxhAsvnIP
 vO2adxKs1zk5TEk78/+OUmV9NuHH+jp+1GlLtAc0y8kLzGxPTIPoU0A3MH1IotwNgL7PLkJJBBH
 UmPbMl5Ts+DN/rWRpmw/gcAcVP2S6ejPr6RXDpIKbC8Fk/WQAyKIjVDgG8IDV7zG3fFQIcR5t4W
 juH4cBKYuAtmiDleWcJQzZGiIFmIh9ZntFsQY19t3Pldrh4eHohSJ+Q3w9E1UwnHweWCPv6MCV0
 ddPpl66629v+Z/PusSqvf451XLusaU61OkxM8hRDhm/6BrTibiaKcBzIW4DF8Ck+CmqBXa/PoxR
 f8dlfRt5jiqsy1QCOnA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-11_02,2026-06-11_01,2025-10-01_01
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

On 09/06/2026 18:25, Peter Xu wrote:

> Add a helper to set qom property via a bool pointer.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>   include/qom/object-property-ptr.h | 15 ++++++++++++
>   qom/object-property-ptr.c         | 39 +++++++++++++++++++++++++++++++
>   2 files changed, 54 insertions(+)
> 
> diff --git a/include/qom/object-property-ptr.h b/include/qom/object-property-ptr.h
> index 6066c377fb..9cd8600094 100644
> --- a/include/qom/object-property-ptr.h
> +++ b/include/qom/object-property-ptr.h
> @@ -16,6 +16,21 @@ typedef enum {
>       OBJ_PROP_FLAG_READWRITE = (OBJ_PROP_FLAG_READ | OBJ_PROP_FLAG_WRITE),
>   } ObjectPropertyFlags;
>   
> +/**
> + * object_property_add_bool_ptr:
> + * @obj: the object to add a property to
> + * @name: the name of the property
> + * @v: pointer to value
> + * @flags: bitwise-or'd ObjectPropertyFlags
> + *
> + * Add a property of type 'bool' to the object.
> + *
> + * Returns: The newly added property on success, or %NULL on failure.
> + */
> +ObjectProperty *
> +object_property_add_bool_ptr(Object *obj, const char *name, const bool *v,
> +                             ObjectPropertyFlags flags);
> +
>   /**
>    * object_property_add_uint8_ptr:
>    * @obj: the object to add a property to
> diff --git a/qom/object-property-ptr.c b/qom/object-property-ptr.c
> index 02c01ed7f0..49f223da7b 100644
> --- a/qom/object-property-ptr.c
> +++ b/qom/object-property-ptr.c
> @@ -7,6 +7,26 @@
>   #include "qom/object.h"
>   #include "qapi/visitor.h"
>   
> +static void property_get_bool_ptr(Object *obj, Visitor *v, const char *name,
> +                                  void *opaque, Error **errp)
> +{
> +    bool value = *(bool *)opaque;
> +    visit_type_bool(v, name, &value, errp);
> +}
> +
> +static void property_set_bool_ptr(Object *obj, Visitor *v, const char *name,
> +                                  void *opaque, Error **errp)
> +{
> +    bool *field = opaque;
> +    bool value;
> +
> +    if (!visit_type_bool(v, name, &value, errp)) {
> +        return;
> +    }
> +
> +    *field = value;
> +}
> +
>   static void property_get_uint8_ptr(Object *obj, Visitor *v, const char *name,
>                                      void *opaque, Error **errp)
>   {
> @@ -87,6 +107,25 @@ static void property_set_uint64_ptr(Object *obj, Visitor *v, const char *name,
>       *field = value;
>   }
>   
> +ObjectProperty *
> +object_property_add_bool_ptr(Object *obj, const char *name,
> +                             const bool *v, ObjectPropertyFlags flags)
> +{
> +    ObjectPropertyAccessor *getter = NULL;
> +    ObjectPropertyAccessor *setter = NULL;
> +
> +    if ((flags & OBJ_PROP_FLAG_READ) == OBJ_PROP_FLAG_READ) {
> +        getter = property_get_bool_ptr;
> +    }
> +
> +    if ((flags & OBJ_PROP_FLAG_WRITE) == OBJ_PROP_FLAG_WRITE) {
> +        setter = property_set_bool_ptr;
> +    }
> +
> +    return object_property_add(obj, name, "bool",
> +                               getter, setter, NULL, (void *)v);
> +}
> +
>   ObjectProperty *
>   object_property_add_uint8_ptr(Object *obj, const char *name,
>                                 const uint8_t *v,

Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>


ATB,

Mark.


