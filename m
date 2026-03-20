Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70F48109318F
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2026 08:41:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3VP2-0000qJ-9C; Fri, 20 Mar 2026 04:40:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tejus.gk@nutanix.com>)
 id 1w3VOx-0000ps-O7
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 04:40:15 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tejus.gk@nutanix.com>)
 id 1w3VOu-00020z-P2
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 04:40:15 -0400
Received: from pps.filterd (m0127841.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62JJ5owx4085095; Fri, 20 Mar 2026 01:40:08 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=proofpoint20171006; bh=QMM401ccCsKgH
 OymqNFsv8ySGoT/jjS+HwKUrewLqZQ=; b=OyL+OvoG8dhatdyOSdhZhrGUgE1A+
 tQd0bIc6IZZc1u6uD4M6bk3DUc0xUK38yjcB6BK1fiSCK6NU7kcHICeuTtvu/uQD
 tThJD8eESg+iEm+gYBydXKN0RbnQpRvSInRRtT3sZQiq4TQREyj10yDcwmmygEJw
 PFH+dd9eM2SFJfs9/fAqimbiembjoinv5F4kayaz9/F0ICvwxwhPl7rlzxQK/SMM
 xfaJRK9HB16nkStpC5n1GSypJS/RcJe6lRlywcZxhdyPXPLBpoqHjypiCiTIi3Jz
 3Ljx1PhK9IqpOd9DQbPoovpAKTGeiif4nEuF8ItNMOaU+NQyfJTdD4x8g==
Received: from cy7pr03cu001.outbound.protection.outlook.com
 (mail-westcentralusazon11020078.outbound.protection.outlook.com
 [40.93.198.78])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4cyeghy21m-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 20 Mar 2026 01:40:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J4q50ofuc7ZVvLgqN66kOL1tPzoZI9+kMY+oGupdGJQvwIXtOVRE5CHZbHpcol8FhAugdIpmnS3Te4vyqXrpgtmtURftKP1MSNxgl7I/6gtOKF064CQB+fprWLU1eKBTETsiofxmbUnXeoXDkSrYp/+Ev+yL6J/UiKpzbZkz/fL07yHJvYvy24BbQ9ewREbpoWZhwMFw5rFLtnEv9Eb8o4nTo2z6y4/Pk1z73XyXhNQ/yDto0P5YxpLu5MnQmqSuB70IcxeCBh7R67hVC//fumXElJuMmmqKeRGx3TNt9QCJy6FGGw7x4DFWo3kjNbAaUBDrk1pPj8XsojR+XY4idA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QMM401ccCsKgHOymqNFsv8ySGoT/jjS+HwKUrewLqZQ=;
 b=SZEtwHIYTGWxJpV4xSF0h2YHoueUPZkPO8HFK+3ADjCeyK0PkRtqIdJKz7xIUjjNcW89b5Lyg3zMeLH3ydNCksLKFq2fpUgPgQ24fmRx8lIkGFZvl4izYKuE8aTxm70hsSU6rm1INmC3Uy7c/blImyVcf0Z+n8KZQjmdm4ld3YNiXndahRG5oBpEpYNawlLVNVjre5hIVzhkiDe0SC8VmslQW3NM/wAO10/4xG2TeyYdnNYQpmdnozlqbzkn96QzkFs9toBIy4MtC2Za41PwKTyzBbA/H9bZqwcLqXLcSCSmDmVq12xdMDypSiIzLs356dwJbP9W6bUEh+638g1idA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QMM401ccCsKgHOymqNFsv8ySGoT/jjS+HwKUrewLqZQ=;
 b=yBuiYdvTBi6ao63S7eml/mrRl4C3r5DX6fpk5fsGpCgAycKR0BdgvV7xOmWm0XfJTh8mRG2toM0XqQp8N2SYqPYGE6JuxGUXpLDcCTxPD8m+vaoLHwji0S9Fu8w2ru8CMRMFMq9pyZYcoV28Aa7G0iSyXiBt/hQ+nGS8h658lVe8XscRTGu+0jB1bRzx+qP4ovurRVF3DZWS/zPp6PrB3KDqWO8Yrkgoyylb7peYNZXRGlI1tatFXvV0EfW63pAHjaXpiqYYXlukhX1DHVv0PB7/3VHJ7Eus4zBY2AcS8MQ9+QyNgVhYiu1F4OWUKkZAQ9wG7wJGA1NzModvuxZnFg==
Received: from MW6PR02MB9817.namprd02.prod.outlook.com (2603:10b6:303:23b::15)
 by IA3PR02MB10602.namprd02.prod.outlook.com (2603:10b6:208:50c::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.20; Fri, 20 Mar
 2026 08:40:06 +0000
Received: from MW6PR02MB9817.namprd02.prod.outlook.com
 ([fe80::86e5:3449:a3f7:ee4c]) by MW6PR02MB9817.namprd02.prod.outlook.com
 ([fe80::86e5:3449:a3f7:ee4c%5]) with mapi id 15.20.9723.019; Fri, 20 Mar 2026
 08:40:06 +0000
From: Tejus GK <tejus.gk@nutanix.com>
To: qemu-devel@nongnu.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Cc: Tejus GK <tejus.gk@nutanix.com>, Peter Xu <peterx@redhat.com>
Subject: [PATCH v3 1/1] io: invert the return semantics of qio_channel_flush
Date: Fri, 20 Mar 2026 08:39:41 +0000
Message-ID: <20260320083950.262119-1-tejus.gk@nutanix.com>
X-Mailer: git-send-email 2.43.7
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0PR13CA0023.namprd13.prod.outlook.com
 (2603:10b6:610:b1::28) To MW6PR02MB9817.namprd02.prod.outlook.com
 (2603:10b6:303:23b::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW6PR02MB9817:EE_|IA3PR02MB10602:EE_
X-MS-Office365-Filtering-Correlation-Id: 54b852c7-94f7-4cfd-c487-08de865c4995
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|52116014|376014|1800799024|38350700014|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: fOBczlfwb6r279azEY069zl0MZTgAbkHcKO2/vIizN4eItaC2rA+gFNm+qlPxqf/B7n/PfhM9UAz2HU08ytKy0dtuye7gLitLMW2BfKiVGyFZic5oyn6Y0t0VpJdMSNKIEyMraI5t1SiW7GowWcuflf1R7OyXGn+CDYre1udjLpoBWCDDFMVMS8/hO+cqJeN7RpDd0TiLojMKvlKE1Gks9sxlAPHmbLs7H3gIeuij8/hhsjuJFTNEvtuUvI6dEN0Bd7zI+kOoDmA3C0gEoJyJFENmP4jHi7yibp7UrSckYOPhttOaGu/7x1TWi5RQJL4I6CN0+QuoJWXkEDjJ6FC1XbIG5JzgA2CBsbpp5VKlOMQ4Qx9dBMFjQ78UlgtMjQa4ulFvPEVQ21Y0ca8ii4+2gszJKc9LDi1LEC8yDKbuoAa7CZVGicyIkC+6q+qmZgRk3xsd3yInvknhJxpe215k4a5qD91rNwQqsAYq2aLPyhGousFvpRrs1tCzgevx4l0dWCYVVH2ExcaW2K8RR0/Fl7tJ7nlCPGS2zntZ9svns6disU8eRSoeUApLJdZcNKuhMk9huHZ/LAJHoqZjlIoY4eaWbe68kwbiAIkwrgxWz6QmtRNsLBvS/Yvj88zt20MwMWWxUKeyJ8PFCbIQ1SIXA6nKBJqUDFgpdURHYllVsLooygcVFT44patGJ+6a4PoHFc82UYEXUZPFITpUxeH4XQOhRc3tIMgtu5rIW/ufsBnNxeu6WbYq4mxYdgu1EhbaxcETREk8rg9znyq3Odc6uS4UnZ5CpiTvKqIGKhs6nI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW6PR02MB9817.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(52116014)(376014)(1800799024)(38350700014)(56012099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cytacjJOVldIS20xRVAxeXBsU0N3RzJwSWQ0WElsTEV0NjRwbDUrU2JMSUpB?=
 =?utf-8?B?NTUvdTZ2RFpmdHdqVkxoQzhaaGZ4bitqM1JZSmVMcTUxM2NEc3gxR3Fuc2NQ?=
 =?utf-8?B?clFwTk5rQzlFSksrM3dPNUpTZ1JCTkpmTFVNQmovaVJtMVp6RjZvNWRvdy9T?=
 =?utf-8?B?MS91Z093aVF4UW5EUTNWV2ZJNVI3Wkl5U1NUa0xjRlNjWVUyVjNUVEVvWitW?=
 =?utf-8?B?OXF3NWQ2a2taS05IZGwvZnlOWTUwOHZVcW0vRDFMejZtV1U5ZndQZ1NuY3dL?=
 =?utf-8?B?MG16WVAwM1BMQ09oWkovZmplTGVQWUl0ZytuL3NKUnpQSysyZEVsaVpHKzdh?=
 =?utf-8?B?N2pGK3BKdVJ4NGNNNjk4MXFqcndMeGlyM3hjUng5N1ppWDQ4TFZrazdnWmxJ?=
 =?utf-8?B?U3pYNU95QkJWVXptUkNmZHpHUVN2TFpmSXF4b3p1a3JyVGh5REV5RSswZGdT?=
 =?utf-8?B?R0RMVmhqSHBKbGF3alBBM1JWWVBFQVpqclN3QUJiWnZsazlUV2ZTT3dPVnFW?=
 =?utf-8?B?VldTaUxybExhWTg4Z3BiUzF3TVFXYzVRY1I2Y3VId0Q0V3BCRGRpVDZRQnlL?=
 =?utf-8?B?ajI0TWtJZThCNzJMWDdEVzJSRlgvV2VTc1BQa1dtVVRvb2FnWEQ3eXgwRXda?=
 =?utf-8?B?dFI0S1IzdnNhRytGSG1vVGRwaDI5UzlDMW14Sm5LUSttSEwrdVgwUWRpZXNE?=
 =?utf-8?B?V0htdWZEQzNOZTYvalpDeTZtUUswWGFmTUtVeGVtNXZsVDhhV0I2QkM5UDR2?=
 =?utf-8?B?emU3S2R1NmZod2hzK3FzNlNGT1Ziems3RUJvazRvb3VUQXRHSFZPdXA2TzVW?=
 =?utf-8?B?LzNjQmgrWDkzR053cGNYQW5iTVNqU0dnUm9rUXFsT3FScU4vZzNPWmRURFdz?=
 =?utf-8?B?NG0rdXU2RjZrREFPYzRGb2ZJNkxTNGZydlFQSXpQSEpBcldpOGhEYzJ5OGkw?=
 =?utf-8?B?U2tSVkl5aHcvSURhcjZCeDZkQ3FVK1NmN0ZCUEpBSGdBd1dpQTNxOHQxWVFx?=
 =?utf-8?B?OUs0bEduMmcvM2IzZmtxLzV4V0RJS2UyK1o3RTFrQUF4MWxpN0Vod2dwTGVE?=
 =?utf-8?B?d2pmR1NSa0V3L0ZmZ0hvVTBSNkVTWFQ5VDBkT1RxcTRBOVpKMlI4ekVlbjJq?=
 =?utf-8?B?bzB0Q1lKKzdNUU81WURzOWllUDliTVF3RmZwRmlENU1wcWRWMGpHY3JoV1BV?=
 =?utf-8?B?bFROY3YrUVZPTFFHN1RpbldCeC81NHpwYnZDd2VCOUpWbTdWM2lpYkd4bUhq?=
 =?utf-8?B?d0w2ZmhQZUhIMHVEa2JGU29CSkg2bFdVbE1FUHNZNmkvTFp5V0VURkdRRzc1?=
 =?utf-8?B?cHlPWVpSd0tFZVZQeEV5akJvNk5BS3U2ZnlCcmU4N1lLOVMxZWc3T0d4RDNy?=
 =?utf-8?B?RytIYzFKZDVRNDd1MU1ab1laUGFpN1I2TlB6aHQwakczaTl5U0xzbzNFU3ZS?=
 =?utf-8?B?RTZUd0dleUliN3RKUVl4akkwcEZ6TXlhVHBPaFd0MFhjUHJYYmdCQ0lscFht?=
 =?utf-8?B?TDhEay9ONXpIL3JmR1Z6WmJ1dFAvb29kNnl1SVpqYU5GdzB2ckh5YS8vN0Fw?=
 =?utf-8?B?WnYrbFl2WXE0WEZFVXlIbkUzbEVKZUwrajBsUlZqZW5FcVJBbU5KSzUrQWp4?=
 =?utf-8?B?QktqVnZEM3V1TDRYVTBUVXJOZFlnRW9NMlNwOVp2dFVHK1hJWHh3a2VKS3Bt?=
 =?utf-8?B?bDR5bEtRLytxR0FGQVFYaHdsSzRCWkI3UldVcWwrUWhGWFdtaVgxYVQ5OEZu?=
 =?utf-8?B?NXNzcEEzTXptOWFNSzhqTmxBRkFpblZTb3JHOVdUY2tOeVorckFUdEVjNWd2?=
 =?utf-8?B?T1RzSk1WRmJZd3VCdGJkem55WGVPRCs1bUlKNnRxSzVNMmpTbVE3eEp2enBR?=
 =?utf-8?B?Yk9VcXI1anZMdjkvZ21lUXR2WnFYdm1aVmdBY2RLRWJuQjlDbXBDSE1nVVFC?=
 =?utf-8?B?aGpidTByOFJlQVRMNVlzMU91WElaWVR1V0FRa1RySStQSUVibDk0UkFFeW9B?=
 =?utf-8?B?ekdiZk9va2paNUt4RUVXU0lLRUR2d3ZEZUZjcTdBRFdXUlBCVE91c3d3Qk1E?=
 =?utf-8?B?N2xLUlhndXFEOTdvTmg0YzQ3SGRWcnBiNDhuZWNRekVKRkt0SVRGZFY4YmU5?=
 =?utf-8?B?OVVsWFNGTlMwOVpVUWlGREUwckR1RHUycWRBMkRYd2dZMEo5NjR1akNjZUVH?=
 =?utf-8?B?N1VQSXNlOG1qWTNnVi9uajhRR0xjbENwNUdJY1dhUTdJVmRpZGRCZUNHaGdW?=
 =?utf-8?B?Vk5aalF3OEhWOERUZ0p2c1JuOTltSkhieHh0aEo4VjhJbTFjRWU2MmFaRmYx?=
 =?utf-8?B?Q0NQd2lidUdUcVRmZ21EV2U0d082OVNZeC9wRzVWcHBDQWIxcks5UT09?=
X-Exchange-RoutingPolicyChecked: qipBHY6vjjaLf5XGJJVmcRyeUgJCw3T6tnYsMmI3DmzNDXfs/LSfLvAVp/KFXLg6C59ALpVS7sJy6Tavfa2zVqXn8qlE2Fwe/IQCccCH3Qf8tnQq/I/ai24VnauzvMPfmdtDWgU2tM+YwTG5Bce2uvMKb3I+i7hOtuLPQ9pPlWUsk8zXnYIOlfq97kAwObvLqSnO3iKqhEe/RZjp1vrt43UHbg271tXGgoyvC0SH6Jzj7ZWTUT8e1oN+/tzrDeIvg0GrX8lTSdBJ0i52LT11iHD3UgzKc1F48Sz3TY0AluUuwlwmvqoMXq6wfe8Bi8FeR87CTLzp8/LcgT911BnyhQ==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54b852c7-94f7-4cfd-c487-08de865c4995
X-MS-Exchange-CrossTenant-AuthSource: MW6PR02MB9817.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2026 08:40:06.4574 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bGh0+oauSI80wJXnlwDmslDS97FgMtcdB/arNen2tr8gNRk6i33yDNcYb5zc+ga+cGqcuGpciGBkqbVnAA/8EA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR02MB10602
X-Authority-Analysis: v=2.4 cv=GPcF0+NK c=1 sm=1 tr=0 ts=69bd07e8 cx=c_pps
 a=r5kpy6O4d1nOJ9DEYQWzwg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=jxMXjlTPpCISP5mWtjnE:22
 a=20KFwNOVAAAA:8 a=64Cc0HZtAAAA:8 a=yMwPgAGnu0RJ-zQhsUwA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 290OichX7NXhPMbgggW0RlTAnVjBxyrL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIwMDA2NSBTYWx0ZWRfX/vPPu8B/vzRu
 ajC8J/umYpyLG/JspJCpZHlTemw22/PBSZ0G2+fNWtQso4qwVq/jrnV85S8wyG53APKXSvXQ9gt
 uC38+M3TEsGphHQWa646gU4rY8JO3wHsRFCy/cdcC2o9kb/w2vlyC0F2+T5AF8HL68RbEY0mGbO
 Ilzn2t2x7iuEwi4vQWi2xBTg9cve9TbuZ5IE2U7Vm29RCCDXOnqneDFNkd5ooqUZ4vdj0g45WDu
 oHzSgEaUwcqj259p5RP/sSOScRKHQ5vC/Ca/rAnZgX23GcsvJ/IC+QJ0C4aAw3NDVOcdbfgtar3
 ot7RndNkXDk6IYz4cehIrnmxptFBGOfkn97eQfX2lw+SCxDpxDk3HrmkQ9hAFCg/wFQftsk7av3
 DNF1b0xkK1bVxQIHoY8CobMqdOx9Dcr6RgCjL+CCEvgr++k0yYnIb6t0QmRi0T3o0P4c/dqzoki
 zq3W3zH13yzfOUgIvBw==
X-Proofpoint-ORIG-GUID: 290OichX7NXhPMbgggW0RlTAnVjBxyrL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-20_01,2026-03-19_05,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12; envelope-from=tejus.gk@nutanix.com;
 helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903, SPF_HELO_NONE=0.001,
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

With the kernel's zerocopy notification mechanism, the caller can
determine whether
 * All syscalls successfully used zero copy
 * At least one syscall failed to use zero copy

But, as of now QEMU's IO channel flush function semantics are like
 * 1 => all syscalls failed to use zero copy
 * 0 => at least one syscall successfully used zero copy

This is not aligned with what the kernel reports, and ends up reporting
false negatives for cases like when there's just a single successful
zerocopy amongst a collection of deferred zero-copies during a flush.

Fix this by inverting the return semantics of the IO flush function.

Suggested-by: Peter Xu <peterx@redhat.com>
Suggested-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Tejus GK <tejus.gk@nutanix.com>
---
 include/io/channel-socket.h |  6 +-----
 include/io/channel.h        |  4 ++--
 io/channel-socket.c         | 16 ++++++++--------
 3 files changed, 11 insertions(+), 15 deletions(-)

diff --git a/include/io/channel-socket.h b/include/io/channel-socket.h
index a1ef3136ea..b07cd61477 100644
--- a/include/io/channel-socket.h
+++ b/include/io/channel-socket.h
@@ -50,11 +50,7 @@ struct QIOChannelSocket {
     ssize_t zero_copy_queued;
     ssize_t zero_copy_sent;
     bool blocking;
-    /**
-     * This flag indicates whether any new data was successfully sent with
-     * zerocopy since the last qio_channel_socket_flush() call.
-     */
-    bool new_zero_copy_sent_success;
+    bool zero_copy_fallback;
 };
 
 
diff --git a/include/io/channel.h b/include/io/channel.h
index 1b02350437..c357da5460 100644
--- a/include/io/channel.h
+++ b/include/io/channel.h
@@ -1014,8 +1014,8 @@ int coroutine_mixed_fn qio_channel_writev_full_all(QIOChannel *ioc,
  * If not implemented, acts as a no-op, and returns 0.
  *
  * Returns -1 if any error is found,
- *          1 if every send failed to use zero copy.
- *          0 otherwise.
+ *          1 if at least one send failed to use zero copy.
+ *          0 if every send successfully used zero copy.
  */
 
 int qio_channel_flush(QIOChannel *ioc,
diff --git a/io/channel-socket.c b/io/channel-socket.c
index 3053b35ad8..ea2ec84108 100644
--- a/io/channel-socket.c
+++ b/io/channel-socket.c
@@ -72,7 +72,7 @@ qio_channel_socket_new(void)
     sioc->zero_copy_queued = 0;
     sioc->zero_copy_sent = 0;
     sioc->blocking = false;
-    sioc->new_zero_copy_sent_success = false;
+    sioc->zero_copy_fallback = false;
 
     ioc = QIO_CHANNEL(sioc);
     qio_channel_set_feature(ioc, QIO_CHANNEL_FEATURE_SHUTDOWN);
@@ -880,9 +880,9 @@ static int qio_channel_socket_flush_internal(QIOChannel *ioc,
         /* No errors, count successfully finished sendmsg()*/
         sioc->zero_copy_sent += serr->ee_data - serr->ee_info + 1;
 
-        /* If any sendmsg() succeeded using zero copy, mark zerocopy success */
-        if (serr->ee_code != SO_EE_CODE_ZEROCOPY_COPIED) {
-            sioc->new_zero_copy_sent_success = true;
+        if (serr->ee_code == SO_EE_CODE_ZEROCOPY_COPIED) {
+            /* If any sendmsg() fell back to a copy, mark fallback as true */
+            sioc->zero_copy_fallback = true;
         }
     }
 
@@ -900,12 +900,12 @@ static int qio_channel_socket_flush(QIOChannel *ioc,
         return ret;
     }
 
-    if (sioc->new_zero_copy_sent_success) {
-        sioc->new_zero_copy_sent_success = false;
-        return 0;
+    if (sioc->zero_copy_fallback) {
+        sioc->zero_copy_fallback = false;
+        return 1;
     }
 
-    return 1;
+    return 0;
 }
 
 #endif /* QEMU_MSG_ZEROCOPY */
-- 
2.43.7


