Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39491C5CFC1
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2026 11:32:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuq8h-0002Lh-PP; Fri, 14 Aug 2026 07:31:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wuq8X-0002HD-0e
 for qemu-devel@nongnu.org; Fri, 14 Aug 2026 07:31:54 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wuq8U-0006jO-RE
 for qemu-devel@nongnu.org; Fri, 14 Aug 2026 07:31:44 -0400
Received: from pps.filterd (m0127840.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67EAdvN81366913; Fri, 14 Aug 2026 04:31:40 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=AsplXRCYunFlkTZlBWmbune9Pl9U30AkpgQbTJORZ
 lI=; b=FiMXJjakJaGEP9UWQYqTSizKg8SCflBd/DnTYqj4geUR828GasvjMb90T
 cBzVFg/xjDd8NxHMQea0YloGzahEWr1bK3KPFmy7DJ274mZp8BtpAvN5nPivhfT5
 KGxHWLpV3fPpxA0TKaaNlKz+etwnX9gt9QLazb82vbh2usUjJ9V2W1THCZtQTR7c
 81dgcBMJcoGVnLBwv7bIpFtyvmanp6Eb5JEY/OjduPw9xO9xRgdoTaKzUHzglflw
 5ml5n6U6cUjRx+evlszVLzO5pw/ITcTzekEg2QV5Of3doEPC15OIs6XH+NhBlgYD
 iui+toJYHgzv4b/07QwFm6LWoPrSw==
Received: from bn8pr05cu002.outbound.protection.outlook.com
 (mail-eastus2azon11021097.outbound.protection.outlook.com [52.101.57.97])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4g1p0ehe0x-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 14 Aug 2026 04:31:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uThk9ntRfO0TemITqGNyrQfBpb4QnxwG2A7SO/v6/pxBdyPlXaAha1YlFbLlnAckEaplmSFcCChWoSvS4Ieq3F/9qva9AMmUkfX+P+Y///1MjfnGM0FwrxPwJZpKHqKvQubdbSvbqYQUPoMdk/kY6+R9it23in5zCGPA/gmpPVVJrCkJTV3qlYsuDWpnx9AehK/xaSKAslnDEISKCNmDELKFs7/AmaabS2sPmFtAc39lHt67hLQuZszfl0uY2rfUDe14Nx+Hv4JGs92tes851iI3lzCAn6V/YJHcN1/A8kpOLOSeWGY6UdRunhUy072u6ef9peYRnia4CW9Gx/Y5fQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AsplXRCYunFlkTZlBWmbune9Pl9U30AkpgQbTJORZlI=;
 b=wSWqFrdpuNn95W3u6fWrrmaZ3FCACGFe29PGrEqrOnhwTxurP7H4gPHFbM0fmZRkQNNDNWiQUBROCMNETgShnR+Jd/44xgr9lLX4VbpG8qI5B+FiThWEkvsnhLnVI063oQ8XdF0KR7GGzyEAbGUb93ZKJZ2yC7LZcKdP72cn+CWILPj9iZpOrub/wZg83vwcXI+Jik5yT0nESgv1V7yGMBMwMitcC7t5q5FfGhposm1sJgVSTVPwhgIHYrAavllejn3ynTuqmZJXjfYkxHSc61xtc5da9Yn4C1RzBy/VSo7SL6FvHRsEq5ISOU2Zupw2/Qii6kFOLU3huVlh8pi3lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AsplXRCYunFlkTZlBWmbune9Pl9U30AkpgQbTJORZlI=;
 b=kVOJuy5wTs3bPgU6B0Lr6pgYRcVEZ8seG1UkHYc395Q4D4eMHpbl02Hkc/7cT19N0MvExHzZRSPOzx5b6ZIdUe7hWh3Aktx1ERDC9gfZzHemBazBw9ohY6lrLawG4e4hgg6+BjEzAFYPdCNW+pHSXBHodOCRtowxZhqLqvL590QnBJWwUayOd7PFk943ExBQ/evvuVf/9M7ZUxbPprmcN87rmAmYgblA2W18i4TYmAXSkUSAgSjwvCsUWBRGXltJP4h4plL/OtHdJaPfRRCkstcUbogDDNL95gjnpDc9ksI2JSO1rSRSFVgsefvmUOcL/DrKBHew4xvH8B/unsi5/g==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by IA3PR02MB11199.namprd02.prod.outlook.com (2603:10b6:208:542::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.16; Fri, 14 Aug
 2026 11:31:38 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%3]) with mapi id 15.21.0315.014; Fri, 14 Aug 2026
 11:31:38 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: qemu-devel@nongnu.org, richard.henderson@linaro.org
Cc: Mark Cave-Ayland <mark.caveayland@nutanix.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PULL 6/6] qom/object.c: rename object_class_property_uint*_ptr() to
 object_class_static_property_uint*_ptr()
Date: Fri, 14 Aug 2026 12:30:24 +0100
Message-ID: <20260814113044.2416794-7-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260814113044.2416794-1-mark.caveayland@nutanix.com>
References: <20260814113044.2416794-1-mark.caveayland@nutanix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PA7P264CA0492.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:3dc::15) To MW4PR02MB7153.namprd02.prod.outlook.com
 (2603:10b6:303:65::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|IA3PR02MB11199:EE_
X-MS-Office365-Filtering-Correlation-Id: cf865d6d-be60-4dd9-e313-08def9f79a48
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|56012099006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: UpSIDMEgECZ7jn70KfG2s9Q9Ez+BG4rfqgpKVKv0kuEcgksvtGoxf94bNmTJy+gKzyuRh1dToU7osOpRqErCXq+hId/U4qQXidJRVn/6KLSxScC0pAQXi9A6iQ9j7qysPhppXgWA1xhaLYd1o8AV3AOKQ0zEZnyXMvCDyZ4v5Tu+jRfW62DBgv5sxbGmnnwAhbIn9XdVBTRzNEcBFPzR4seQXbcjxK9AkERtJPNlgvkbuXl6QYnWcNtGoQ8NQn3IBYFl7WnM7SPpoMJYY7MgCqNue5H7C8rXG5MR9+QjGENZeyaHy5p7IMk/20ZdFO8+Xf80GaSGIbSlDVQz1nd/BkW1w1wNY/HFTrscUpa/Ua3kx56FmUIxW1atw1PhwhSgm8h2AnO7AWt4bPvt5i/f5kD6+dpyOT85jaC2Xp4E8S4HbR0GNa4hzo8j9rXloirP+K28e1J+Q5lEjgTlS4z9ACduaF7qEhb1bunXXmU792qDF98XiHGl6oC/Mby0DBc7Zw1BZpve9F/5aj7z+p4uL2FjbHLnfoq5Sf1by/jrw8r75CeTDapKHqtzaxvrOEQg1yJVaqFHsA8boXpRxd0WjEGfyX7OsOxzp01/SR7g6sM0aEoVKGFgi13+ndHOpaM9fGWYMie+dh6hd2xsB4EscGMUpGeeddRd0WTl46n9jqc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(56012099006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MjFQS0t0dDNvc09pN3ZjQmptSC8xYjRaMnNIL3RuVWpNMzk4dXJIM3FLTHBk?=
 =?utf-8?B?UWMvTTgzdnRkYU5odmM5NWVsK2dZZkhISUtKQWJGbnRYWFBOZEY5bEdlWmxO?=
 =?utf-8?B?Rzl0VFVMSkRBeVhGZ29UL1AwZlN6aFZRVnNqSFRvOHJOWDJ2dW4vNjVPMlpS?=
 =?utf-8?B?d1EwZHN4MWJvUnhxbnFFWXp3ay83ZkFDWWMzcHRwUzJwNVJTOXFzeTRGQzAz?=
 =?utf-8?B?SkV2eXFId0ZQdEk1WUZCdXUxcFJEUHg2MExER3pWM2lUbVFRMFVyc0lQU3lJ?=
 =?utf-8?B?UkllVm40bk1OU0Q4dWFlbFQwMWF5SzdEVEFMUmFVOWxVVEdnMHNHRndFUDZ6?=
 =?utf-8?B?blZRNDlEbTFNYUJyRjZCV0srTUlDcHhFdTlyTkUxSkJnQzR5RjVOeEFmaXlT?=
 =?utf-8?B?bytuMFBBVFBYRTA5am1oWTlPd2k3dkxBa2ZlU0wzRElva2oyMDBiSGlEeDZN?=
 =?utf-8?B?SWUvRkFpbDFrOTh6REplajNjaGJNd212UG9KNnBmMkVLQkgzMjBxc3FaNTNK?=
 =?utf-8?B?Y2Z0N2pQSHBEUmZBYllRQ2hudHdEbFR5a2t2c2hvY0VWQ2dJVDVVNUhsY0Q0?=
 =?utf-8?B?aDhwaWhwVzMySXUyOWhnTk4vL3hBRWhBTUNlVzE3cXd6cy93Tmh0RzNDWVBT?=
 =?utf-8?B?T01jTE9vVkY4alkxN2FyNUsvVHMzNFMrK0NXd21hNm9yREM0R2s4VFk5MTB6?=
 =?utf-8?B?YUV6TXRXeWJxZUUwN0U4WDRNRTJnSTBBcUVtOWRjaTkzTFppbURBVkt5Z245?=
 =?utf-8?B?eDExOURhdWNMUXd0KzNwL21ZMlAvSjFwbzE3QmNCVzdWbkVKUjVGYzk1MHN5?=
 =?utf-8?B?cnRySGN6UGYrTDRGbGxsY1BncU5lRnkzeXZGWEdxa0J1WXVoVnQ1OEpsQWxO?=
 =?utf-8?B?YThNN0hwSnBuM1JrNWducWtHQ2pMdWt0TXN3WEdONlNZaXc2ZHB0elNud29a?=
 =?utf-8?B?TFlVVDduSFZua052V1BqaWJ1TEpYNExUSElBYjQvQXIxcjFMZjdVYVhIaTJC?=
 =?utf-8?B?T0NnMzMwYi90L05JY0tlWnAya2dIWXRnYTlpWGpsU000MmdQcHFVZCs4emxo?=
 =?utf-8?B?R2RnNnh4a0t4V1JRZmYvQXVYZHZvU3BUaU4vWDJHRUhaYXVGRHV6NmxTdXdn?=
 =?utf-8?B?dWxvSGtKWFRIY1lXWjhCMTgvYWczZ3M2TGx0YmxSc2NBZDF6Z0pXMGFJcVRs?=
 =?utf-8?B?NnF3RjFDWGdrTFRkNDh5MVlRQzkrV2x1SEpuTktqR2JKMC8xYzJZckVCQzda?=
 =?utf-8?B?bFZYR0RabWhMeHFwR2hCQXM0VkFkeHpDcEtjK0RRM3Z0eVpCSTNiUS81Z01u?=
 =?utf-8?B?UHhVQmQ1K0R0U3hrWmxQa25rUk11ckd4bytqT3o4WG9Udm43TTFHcC9XVWh4?=
 =?utf-8?B?eWFHRDFhckswYzFKR0dHN2UrTzBUeHRYRW1nN0M1V0p4ZzZiUGFtOUozcHJH?=
 =?utf-8?B?TlkzbjZmM3F3QW1rOStDdWJ4NFpnNWozcGkvTW90ZmFkTWxWVnhvanFNaWJP?=
 =?utf-8?B?ci9VV0F0a2MrVkQvSjg5aHNIcUdrQzFEdVVabG9FNVhqdWdGRUJqOXlLMC9J?=
 =?utf-8?B?WCsyQktHbUJVL2FTcEp3WlZ4QWszWWc4LzJrRmoyYTMycFZXVDdPbWhVSGlU?=
 =?utf-8?B?SXVFVFIxVGJyV2pMNmdRcXpiMlg0TDJKK1NBdEFoZnh0aWpicmxYc1AvVUEv?=
 =?utf-8?B?a3c3bjZ2SEtEWUI0TUkyZUx1TmNvMC9iQVpmWkFYeTlQL3BET2gwbE5iRGk4?=
 =?utf-8?B?djhDZ1YxWkNVZU9Ja1BaSE5zV3QyZVJSZDlIbXJ2eFFtenZqVnpCQ09iK3lD?=
 =?utf-8?B?UEwzaGNBaEpGTjFZcHNSN3lrYXp3S3A1MzNzMVBXOUR4c1pXdDBFSUtMTVNJ?=
 =?utf-8?B?SitFTURlU3hxMTdvNnBwalhmbVZTbERkMXNBRWNNWFJ0NmlYbFM1MXhqU081?=
 =?utf-8?B?SlorNTVmUy9vaWlIZjE5bWUwTy9xVmJsVm5PT3VCaGlwbE45Q3JEYjFOdTFY?=
 =?utf-8?B?V21KQ2hKcjRYazNlV3N6ZGhPZUJ2ZDVWNytxdmJndTJFZTFIVHlrR21SZzZ0?=
 =?utf-8?B?cVM1VEE3QUYzUEZJRGhac0hmamRVdFk1eTNhTVJGZUowZVE1U1hmVmloV0Yw?=
 =?utf-8?B?OE9pVy9IOC9ybjZVUVlHOU9kQXdTUHY3UWJTU2h0YjJleW43WHJ3SzBXZ2NX?=
 =?utf-8?B?ZjZ4Vk9YdFEzNFAzQytRZzZKb05raGF0VGFwRm0yRW9Tbys4UDQ1NGhPMWxi?=
 =?utf-8?B?cktid3MwQllJZGtFSkhQUnF1TjB3OXJSa1NDTk1CaHZVZ0RaN3kvd01pU1dT?=
 =?utf-8?B?VElVVXVvUXRkU3A5QThZSWo1dDRRTThWUkZTMjFMUGxyT0NtQ2FBOE5Va3hz?=
 =?utf-8?Q?Ic4H7ElFxtrMMRp0=3D?=
X-Exchange-RoutingPolicyChecked: SBj2NoKePB8qzEdrmUYiBxY/duBx3wriv1XBG/hYWgRI+Zq1f7B/reWZ16zX342S2x7CgaS+5ClVbsr33bC2VVLVylzwKL+T4IRXbXILVoeEiASislwtw7tnEgIM4L9RQSyY6zFhufs0QC9tPCqveUTHa+XFjW7kAbSxqgM5gmnDzuXDIhkGPVZicWn73vgEJrfIzrinrs0YYIidaerwgkP9nPo33ZME10SZnifd8Qk9IXRmkpzufAp8CdHIIYK6DzKiJFdRI2fdHlfUaLecJOk1oueniYsaNw5LOPs6nGQlBZdvhwKZTERQVhioD9HjEl9X/Owz3KUYYgzzSsjnEQ==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf865d6d-be60-4dd9-e313-08def9f79a48
X-MS-Exchange-CrossTenant-AuthSource: MW4PR02MB7153.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2026 11:31:38.0332 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZLK2ISodZERrmi0BAU3hSMMlSYoUlgFnNDGRqDxT/v/MF5zKRV+sNw5Xc6cSVvVFNJU0YimRSovSRDbQD0C1Pl1lPM/5VQRs5/dSFtwnmsM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR02MB11199
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE0MDA4NiBTYWx0ZWRfXzcmHRjVYZqTh
 n/Y6o1gy4PCxLJT4W48T2xgMe7xxY6zIkRtVaptU6Or8HwNOSqOjpHVc1wRfMRsJsRHzXnE8D+k
 sPdP2nMGR9a/h9l8AKYcyHPgXR8SiLN23SNldGLWmuZEeHbVe8cpTSAwR5e52LUpXU7dgfrwouE
 vKqKk901XtNOxv59GEbxZPc73afieeeRhbcmMy8RSS9jEDgzHN9sN32QcWSaYbu1ugEHLqQ9/MB
 KkKOrEDsgSYizOLVO5ovC5kBQIfEmdjGdXxYWvoWgFdDhssEPnxtqI749WJVSe9oR2ZyqzNjzLg
 53UHgvMh3sA/jbnFr3UXmRk9txr7iZWBaOLbgvy8njGaAwmXRBHuAoRcFNqCU12fU4bRfWAQ90n
 bGiROZX3oyXrGzfVoN6BmVBEuuFUv+2w4tEjZwILz1vbXDQpDIsv82TqIpuE0ZaX/ew2+8wMgdx
 N5uyzPVyzjCWPIhbvcQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE0MDA4NiBTYWx0ZWRfX7RoF8JmuUt0B
 y/pR2+JbhrdwP7jk7rlGYfKQZ8u1ZdFkjsenpnUD5dXhjPdWQLK9ahUlMRtVd58NCRSh/Aen1qn
 ZlmAsWzczMCvnYTjQwsWdwYBvaGcNjI=
X-Proofpoint-GUID: 3oW9Lz3qhs4Eeech_mOBaeAjeRNhqlua
X-Proofpoint-ORIG-GUID: 3oW9Lz3qhs4Eeech_mOBaeAjeRNhqlua
X-Authority-Analysis: v=2.4 cv=Eeb4hvmC c=1 sm=1 tr=0 ts=6a7efc9c cx=c_pps
 a=fe6InsbVx+A36OIqCyMR/w==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=_-M8LpHI31CeLmyZm6wg:22
 a=64Cc0HZtAAAA:8 a=20KFwNOVAAAA:8 a=0uU5AjtDRKcLOA9aDR4A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-14_04,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.751,
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

This more accurately reflects that these properties are held within the class and
not the object. Update the documentation to describe the few cases where static
properties should be used.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Message-Id: <20260717135254.508701-7-mark.caveayland@nutanix.com>
---
 include/qom/object.h | 56 +++++++++++++++++++++++++++++++-------------
 hw/riscv/spike.c     |  5 ++--
 qom/object.c         | 28 ++++++++++++----------
 3 files changed, 59 insertions(+), 30 deletions(-)

diff --git a/include/qom/object.h b/include/qom/object.h
index 272c41cac7..11b1c9d2dc 100644
--- a/include/qom/object.h
+++ b/include/qom/object.h
@@ -2034,18 +2034,24 @@ ObjectProperty *object_property_add_uint8_ptr(Object *obj, const char *name,
                                               ObjectPropertyFlags flags);
 
 /**
- * object_class_property_add_uint8_ptr:
- * @klass: the object class to add a property to
+ * object_class_static_property_add_uint8_ptr:
+ * @klass: the object class to add a static property to
  * @name: the name of the property
  * @v: pointer to value
  * @flags: bitwise-or'd ObjectPropertyFlags
  *
- * Add an integer property in memory.  This function will add a
+ * Add a static integer property in memory.  This function will add a
  * property of type 'uint8'.
  *
+ * A static property is one which is stored outside of the object instance,
+ * typically in global variables. It is only appropriate to use static
+ * properties when the class is designed as a singleton. If there is a
+ * possibility of multiple instances, then properties must be stored
+ * per-instance.
+ *
  * Returns: The newly added property on success, or %NULL on failure.
  */
-ObjectProperty *object_class_property_add_uint8_ptr(ObjectClass *klass,
+ObjectProperty *object_class_static_property_add_uint8_ptr(ObjectClass *klass,
                                          const char *name,
                                          const uint8_t *v,
                                          ObjectPropertyFlags flags);
@@ -2067,18 +2073,24 @@ ObjectProperty *object_property_add_uint16_ptr(Object *obj, const char *name,
                                     ObjectPropertyFlags flags);
 
 /**
- * object_class_property_add_uint16_ptr:
- * @klass: the object class to add a property to
+ * object_class_static_property_add_uint16_ptr:
+ * @klass: the object class to add a static property to
  * @name: the name of the property
  * @v: pointer to value
  * @flags: bitwise-or'd ObjectPropertyFlags
  *
- * Add an integer property in memory.  This function will add a
+ * Add a static integer property in memory.  This function will add a
  * property of type 'uint16'.
  *
+ * A static property is one which is stored outside of the object instance,
+ * typically in global variables. It is only appropriate to use static
+ * properties when the class is designed as a singleton. If there is a
+ * possibility of multiple instances, then properties must be stored
+ * per-instance.
+ *
  * Returns: The newly added property on success, or %NULL on failure.
  */
-ObjectProperty *object_class_property_add_uint16_ptr(ObjectClass *klass,
+ObjectProperty *object_class_static_property_add_uint16_ptr(ObjectClass *klass,
                                           const char *name,
                                           const uint16_t *v,
                                           ObjectPropertyFlags flags);
@@ -2100,18 +2112,24 @@ ObjectProperty *object_property_add_uint32_ptr(Object *obj, const char *name,
                                     ObjectPropertyFlags flags);
 
 /**
- * object_class_property_add_uint32_ptr:
- * @klass: the object class to add a property to
+ * object_class_static_property_add_uint32_ptr:
+ * @klass: the object class to add a static property to
  * @name: the name of the property
  * @v: pointer to value
  * @flags: bitwise-or'd ObjectPropertyFlags
  *
- * Add an integer property in memory.  This function will add a
+ * Add a static integer property in memory.  This function will add a
  * property of type 'uint32'.
  *
+ * A static property is one which is stored outside of the object instance,
+ * typically in global variables. It is only appropriate to use static
+ * properties when the class is designed as a singleton. If there is a
+ * possibility of multiple instances, then properties must be stored
+ * per-instance.
+ *
  * Returns: The newly added property on success, or %NULL on failure.
  */
-ObjectProperty *object_class_property_add_uint32_ptr(ObjectClass *klass,
+ObjectProperty *object_class_static_property_add_uint32_ptr(ObjectClass *klass,
                                           const char *name,
                                           const uint32_t *v,
                                           ObjectPropertyFlags flags);
@@ -2133,18 +2151,24 @@ ObjectProperty *object_property_add_uint64_ptr(Object *obj, const char *name,
                                     ObjectPropertyFlags flags);
 
 /**
- * object_class_property_add_uint64_ptr:
- * @klass: the object class to add a property to
+ * object_class_static_property_add_uint64_ptr:
+ * @klass: the object class to add a static property to
  * @name: the name of the property
  * @v: pointer to value
  * @flags: bitwise-or'd ObjectPropertyFlags
  *
- * Add an integer property in memory.  This function will add a
+ * Add a static integer property in memory.  This function will add a
  * property of type 'uint64'.
  *
+ * A static property is one which is stored outside of the object instance,
+ * typically in global variables. It is only appropriate to use static
+ * properties when the class is designed as a singleton. If there is a
+ * possibility of multiple instances, then properties must be stored
+ * per-instance.
+ *
  * Returns: The newly added property on success, or %NULL on failure.
  */
-ObjectProperty *object_class_property_add_uint64_ptr(ObjectClass *klass,
+ObjectProperty *object_class_static_property_add_uint64_ptr(ObjectClass *klass,
                                           const char *name,
                                           const uint64_t *v,
                                           ObjectPropertyFlags flags);
diff --git a/hw/riscv/spike.c b/hw/riscv/spike.c
index 9fde0faf39..630b65f569 100644
--- a/hw/riscv/spike.c
+++ b/hw/riscv/spike.c
@@ -278,8 +278,9 @@ static void spike_machine_class_init(ObjectClass *oc, const void *data)
     object_class_property_add_str(oc, "signature", NULL, spike_set_signature);
     object_class_property_set_description(oc, "signature",
                                           "File to write ACT test signature");
-    object_class_property_add_uint8_ptr(oc, "signature-granularity",
-                                        &line_size, OBJ_PROP_FLAG_WRITE);
+    object_class_static_property_add_uint8_ptr(oc, "signature-granularity",
+                                               &line_size,
+                                               OBJ_PROP_FLAG_WRITE);
     object_class_property_set_description(oc, "signature-granularity",
                                           "Size of each line in ACT signature "
                                           "file");
diff --git a/qom/object.c b/qom/object.c
index 622840f9f8..47977b1f44 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -2724,9 +2724,10 @@ object_property_add_uint8_ptr(Object *obj, const char *name,
 }
 
 ObjectProperty *
-object_class_property_add_uint8_ptr(ObjectClass *klass, const char *name,
-                                    const uint8_t *v,
-                                    ObjectPropertyFlags flags)
+object_class_static_property_add_uint8_ptr(ObjectClass *klass,
+                                           const char *name,
+                                           const uint8_t *v,
+                                           ObjectPropertyFlags flags)
 {
     ObjectPropertyAccessor *getter = NULL;
     ObjectPropertyAccessor *setter = NULL;
@@ -2764,9 +2765,10 @@ object_property_add_uint16_ptr(Object *obj, const char *name,
 }
 
 ObjectProperty *
-object_class_property_add_uint16_ptr(ObjectClass *klass, const char *name,
-                                     const uint16_t *v,
-                                     ObjectPropertyFlags flags)
+object_class_static_property_add_uint16_ptr(ObjectClass *klass,
+                                            const char *name,
+                                            const uint16_t *v,
+                                            ObjectPropertyFlags flags)
 {
     ObjectPropertyAccessor *getter = NULL;
     ObjectPropertyAccessor *setter = NULL;
@@ -2804,9 +2806,10 @@ object_property_add_uint32_ptr(Object *obj, const char *name,
 }
 
 ObjectProperty *
-object_class_property_add_uint32_ptr(ObjectClass *klass, const char *name,
-                                     const uint32_t *v,
-                                     ObjectPropertyFlags flags)
+object_class_static_property_add_uint32_ptr(ObjectClass *klass,
+                                            const char *name,
+                                            const uint32_t *v,
+                                            ObjectPropertyFlags flags)
 {
     ObjectPropertyAccessor *getter = NULL;
     ObjectPropertyAccessor *setter = NULL;
@@ -2844,9 +2847,10 @@ object_property_add_uint64_ptr(Object *obj, const char *name,
 }
 
 ObjectProperty *
-object_class_property_add_uint64_ptr(ObjectClass *klass, const char *name,
-                                     const uint64_t *v,
-                                     ObjectPropertyFlags flags)
+object_class_static_property_add_uint64_ptr(ObjectClass *klass,
+                                            const char *name,
+                                            const uint64_t *v,
+                                            ObjectPropertyFlags flags)
 {
     ObjectPropertyAccessor *getter = NULL;
     ObjectPropertyAccessor *setter = NULL;
-- 
2.43.0


