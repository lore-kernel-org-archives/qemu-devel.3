Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0510C44516
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2026 12:59:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wki9O-0000HB-GX; Fri, 17 Jul 2026 08:58:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wki9H-0000Az-9z; Fri, 17 Jul 2026 08:58:39 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wki9F-0003n3-Be; Fri, 17 Jul 2026 08:58:39 -0400
Received: from pps.filterd (m0127843.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66HCHnNu3908790; Fri, 17 Jul 2026 05:58:30 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=DoCe1ATJ3gDaEEvngt4LEw9UeoHc7iNSQJH9TGS4t
 CA=; b=ZtDta4kqnk2pFN82SdM5g5kOith6P9KI4PawUuYuHAjTPXy2Rql82cyJt
 ZzK1nZGPzCcu60TVfdOZZzLS7xvLlrZ8DPc1H8KcbGQ86d7SNVTYxZUqEaAsdFjs
 UBiJMAVBUnB811erdQ+mDh0jtX6gzfkY3vuoh8QY5gKoNM2Z6tJUr5sbOaICg7z/
 CVSvx3il5MWoAwGT6rfQwanNuIIV0/VqUg4neB5E6WwHR4jqC6oLepRntEiA/uVO
 mF6vFYSkzX84Wdd54xqbWB+15RD71HryQlduIey6DROu7BAEb4MjESegL2Sp7m3r
 sXHkDq/7nc75W06bGVz0b5HcLVv6Q==
Received: from bn1pr04cu002.outbound.protection.outlook.com
 (mail-eastus2azon11020093.outbound.protection.outlook.com [52.101.56.93])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4fejrfcvu7-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 17 Jul 2026 05:58:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RvTkDLw2Ieni90mNIp9ySpp4vw7jY/eozsPCpzUqeFTMU8IwCMGyKC+TccImQQ8Cw1daD7VpstSbRUDYuyaYga75DNLrwHSLwYEXjwKFpQb3rYS6OOCwlKZc/VU9LLAMPVY9gM9+qHW4MTPooCILR28KXho3JI28neH+fcihsZNbMOI8YuoLuVgUV6IO85OQrhsBjuSOmW0+B1cDJ7AW2alj7gnxvQnzqu8gKpwxoMgW4sasn8yi3erSIwoQtbM6NhTKJyabmnbAaRpEaWbMtHG3i82bHaCt1JxOOwsu0t46DcyTpfSDOKLBOV4WEVF8OgBuZ5i6U50St1ryBkBFIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DoCe1ATJ3gDaEEvngt4LEw9UeoHc7iNSQJH9TGS4tCA=;
 b=tQny+0Bbe2Jvz62vZjEh+kGvKyqtrPTYD6DBI5JobzNnCbe9uiElP9ZS1NWYwbblOXzkUze69ype9b2JiOaUxjUP98aJ4t3BjnLYtryq5g6rg9cpDhbwBoruBFXnAav58GnZ8V+kAG+SYZhKztrlxDWCyfdaxziiOivMP4Hk2mNK8ojvPpzKGOgTYaeAW3tvUmGQUTMWX6rp/0riEvyNao1WNz5fnP+kHe9B+sDrhozBjtAmlW3oPidVK9EHZI6BR7pIf5lp0oSSmPLnjdKjq0ey/maDhgK8OWxqjx5DBCeUM4n278gKOM2uIQKwOoFORQw8lWJBI4Olaz56O/GJ6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DoCe1ATJ3gDaEEvngt4LEw9UeoHc7iNSQJH9TGS4tCA=;
 b=EeHTeoRgtXtRZguinJVxlZce35PmqibcLScCjzOJcHvbNs1gbJqKPRTpS/0dmKR4ztJK2sec6Pj6H+ABTTNysweWeTZBmeYkfPtVCRLm9A8FvIFEpTsPlOgX6Cy6bztj8nNFMmc8ZZeUdQwynSc8vG/KNKhSEST8EGXvHSNtgOCgSdEHViqbxWuo7Dff9XfOqoaIFm76XeAnIlgPGZ84jly4UBadibqZ9RzTi+ptX+VOizI4ggYpnngcWUEiWdAWy03QxfF/XN+hJy8FuLLfWQT1PC80cFMORthCSHRUOJN2ZmUW34qO4+Fri3kbA7zftPvoaSCwTh/fYT8vUx98XQ==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by DM6PR02MB6698.namprd02.prod.outlook.com (2603:10b6:5:217::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.12; Fri, 17 Jul
 2026 12:58:28 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%3]) with mapi id 15.21.0223.011; Fri, 17 Jul 2026
 12:58:28 +0000
Message-ID: <d27f25b8-f256-49b0-9768-3e4c6d748960@nutanix.com>
Date: Fri, 17 Jul 2026 13:58:23 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] qom/object.c: rename
 object_class_property_uint*_ptr() to object_class_static_property_uint*_ptr()
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: palmer@dabbelt.com, alistair.francis@wdc.com, liwei1518@gmail.com,
 daniel.barboza@oss.qualcomm.com, zhiwei_liu@linux.alibaba.com,
 chao.liu@processmission.com, pbonzini@redhat.com,
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org
References: <20260717112022.444367-1-mark.caveayland@nutanix.com>
 <20260717112022.444367-6-mark.caveayland@nutanix.com>
 <alog1_vFOi0agPww@redhat.com>
Content-Language: en-US
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
In-Reply-To: <alog1_vFOi0agPww@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CY5PR15CA0005.namprd15.prod.outlook.com
 (2603:10b6:930:14::18) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|DM6PR02MB6698:EE_
X-MS-Office365-Filtering-Correlation-Id: b3678c53-8d42-4b6c-945d-08dee4031868
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|7416014|376014|23010399003|1800799024|10067099003|22082099003|18002099003|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info: U3P+noLJAnRhjAqby79oCnbPPzx1zN8ME2YO27UHGxLrjugflWHcPHWi4Fwxr0b9tQKMpa48WaZ9JULp2csEVlVbxBTf8UDYnaJkXllXPe9pKBBNYFKqmVsQFPWtMmvc2zSrOJZnPKqdFezgKzrW6tYiTvuCDHsSecNwj88/YI3yy8yDGzcvKc57cOOjhi8w+PxOHbfx4pSzg+TQsYWDaZL03S1KbdL+JDopyG2yPsQYQZNNpeKVTxOCBr5E+cKeD/7qsYtXrrhEOjHECI7N83KMljmthqmpphqyqs8xCM2Zs2q3G/kcAyNlDmYgXEoFVmrntlfdGE77KusXXSdbUmZTXhVHCM4o9jp5mK4AsYSRY+lpgiGGAeHVG/6POR7ycmEDlJLUtUlQJg59CTsrsXEhenZZ7JBeVAPX+LlxW+nHPLVJnO/kCOQGSpbrOKpqtejKdJb/kqprBPTg7xf0NwWukJDmWafaYqZoAqRl2aix6vCQzLT0R+bkYSx+Gdlz7hXPtuJw5Zm4RslEqA7H5h+UYoCyYCnQGeB7+iZktVVPwB9PyGlWcwIe+KMT243ZZF/sweN8GP/bBvzOLUDcabuCiOKsv4Ayvb8AXqK3EcYpatLxcM8PYMIrg1UFrKGjnxllMTtCy00ggaRxmolV4RVBH0wowFCfAxnxQGiFLvc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(376014)(23010399003)(1800799024)(10067099003)(22082099003)(18002099003)(4143699003)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UjZLNWcvTS9IOXlVL1VvaGhtRkZ4TTJJM05ITG9XcHpLQWhlWlJncmhrTXJO?=
 =?utf-8?B?U3VOYi9uTWcvcWs3am0weDBERzRkVG0xQ2praDk0R1NTOFFPb1A2aXk4RDRH?=
 =?utf-8?B?MFlNMUViRXQ5eUlYOVRHK3pDeDllYTVNQW5KOUpQaHA5ZWJHQzdITEFMY1Ni?=
 =?utf-8?B?ZCtPS2hjOUpHUURtWlhTZkhGL2s4amV6U0o2blFPblBReHpVbkxRVDhQOVhG?=
 =?utf-8?B?QVN5UFoxUDhrM2FILzB2RHI4c0VSQlF4MWdyaUJGYWcvTytndFdmR0JYNWVu?=
 =?utf-8?B?UnY1NllhWEcvTHRWUFBTMnVNZU9IWXdEM0E5QitUVzFqY1o5eEVLUkk4K3lB?=
 =?utf-8?B?OStpbENIMElqNGxSVlUyTS83c1Bhb1BwUUJ1WWE0Tk93eXZtMy9qWENpUlBr?=
 =?utf-8?B?VXZVd0JxYXkxM1lrS0hCR2tGeUtoaXRhMkNuOExobFo0M1d1M2hCS0ZVZ3RO?=
 =?utf-8?B?RkZHank4VmlySnF0WW91d3krY1hMc1QwQWtRc0xoMUxQYnFSdjZNT2tHSzhj?=
 =?utf-8?B?WnRJT080a0dlY0NmN3dVTStOdk45azl3RFdJL0k2YXV4YWtOVWV2R05hYllE?=
 =?utf-8?B?Q3FSbWRBUW9nR3l1cU9meWFwV3dtdVJXOWgwYjNSWlE4cFpZNG5OUmJ6Q2FF?=
 =?utf-8?B?Umd6dXdXSWdWZ3VJMXJLb0lWZzUxam41MFhPQit5RWMwVDE0OUZCd1hkY0ZG?=
 =?utf-8?B?VFhlQ3ZYenBFaE4rSUdGSjNwT0xxMkJjOHQ5OEtKdmRMMkhqTFJBVG9oYXFW?=
 =?utf-8?B?UzQ2ZmdLS2F0dmZxblJkWFEyUXRLUkEySktxbFIrc0pmZ0lnbWk2MXFObmlO?=
 =?utf-8?B?V3pVRXNKbjBlNVkxbG4xN2hRNDM3K01xZ2xMS3hCSEkxZWxmeDkxSVlJdXFy?=
 =?utf-8?B?TnBpcUoyL2YyanhmRHJJbnByL2ZlZFlGTXh6TXcrNWlYbDQ2RzF1Z2pWd1Bs?=
 =?utf-8?B?c3pqZUpVNVRPdXhnZUI4MWZKRzNkdmpoSlkxK0I1UjZuVCtvVTJ4ZG1CT3hH?=
 =?utf-8?B?dUYyNTBWMGVySW8xZHlDcFI0cW1xNjdIN0ZxTUZiMzZQb0FpSVRUREhCZVlW?=
 =?utf-8?B?NnRJeDJ5ZHBNTzl5bW5TSjAyeE02NVZKWitVdU4vUlkxMGRiZVljUEtPVW5E?=
 =?utf-8?B?UFJCRmtNNUZIeFNLYlFBQmdDRmdOMVFtMUVhaERGSjNaRWxZdmZvUnJIalpm?=
 =?utf-8?B?eEtFaEhwQlFQbXU0c091ME5OT1JvVWxBeTYwSWtxdHBqUnFHakxvSE15a2tv?=
 =?utf-8?B?cFFBd1grNzg5RDUrQVFINWhKUU82cjJiaW5kUGoxVlZIdTVtY3d6cXpQNTl1?=
 =?utf-8?B?NEYvRWN6N21mNXRUc21tOEtsSXR1clJ6UlN5ZjVDZnE1cG9wWGdhcGMyMGZ6?=
 =?utf-8?B?MW5YaWhCaU1FQTE3N1g3eGhaY0FZSk5jMjhpZzV4TjVvSDhMd2FQeDU3S0hK?=
 =?utf-8?B?dmlVQXRLT2xOZHczdXV1cTVpY3RzMVN2NGNROU04aEN3MnlNclpxOHZ3aFRH?=
 =?utf-8?B?TkViZmJuR05Rbk1pMm5SbTdSemdsTWdkQ0Z6a1kzRSt4VzZaSG1tclFRQjkv?=
 =?utf-8?B?NEJUdStUbzkyTzJjK2oxQklmWnRIRFZQeVNLZTBXYllEL09NVU9iWUhqVmli?=
 =?utf-8?B?RTlsbit1YVFuZ2JCWXhEQi95Yzg2V0g5c2JRNDhrYXJqcVlHL0hSZ1MxenhF?=
 =?utf-8?B?Q1BySGxCbk9tdEhYam1YemcvTFdvWThMNnExamptTittUHRiTldnTnA1Zmh5?=
 =?utf-8?B?ZlNNNGw1UmVxYTlqeDJGNXBGYVJwcXJyRk9mZUpQclcyOXVJMEZScXRZeHpR?=
 =?utf-8?B?d0lpOXN6K3YrZkNtb2NSOVhpZEk3dk0xSDVTU0FVQlBTZnJsTXd3WGVYMDlX?=
 =?utf-8?B?eUNWRzZVUHFPOEg0WDE5VmNjSHo4eVVrdTRQSW9GQUVzMmtQbXBJU2srU1Uv?=
 =?utf-8?B?cnFQcHV3Si9acXZTMFl3V3BWV2loMjAyaXZoaUlYWHI4TXdsejJScnJDMUxh?=
 =?utf-8?B?clpxTFlTWmZQU0oydjR3K0czSVpGb2V2a0RFb3AwajM4WC9wcmF6QlZJRDRp?=
 =?utf-8?B?bWpxRzc2L09qd2RjWUEzL2l4QmFuSE5rTVVLNlk1R3ZJYmxhdkx1UjVqalgr?=
 =?utf-8?B?QktMYUg4MGR2WDYzeVFBOUowM2JUL25EdU1xb252TzZMUktyb3R1YjZPak1r?=
 =?utf-8?B?YW04cnBLUTY3RHkwZThyV1NZVVdUcUYzd21UWDlKRU9rRUI5RVFvbU9Rcm82?=
 =?utf-8?B?WHNodzZ1Q2ZQUFJzT2ZKWFRBdi9DWU52bi96OS8wcCtETFJSblBobXZBN3FJ?=
 =?utf-8?B?R1VRSms2cTNLTzJ3NVhGeEpNRldyWG45Sko5VXZpU21BdE52ZTFXd3BubEhN?=
 =?utf-8?Q?HiZkLNN2Xcriht4I=3D?=
X-Exchange-RoutingPolicyChecked: Sz1Per6JMVgwVYNN0ugeZ7e5CCkVaiMOlru5fTKT62rrrfHnNApBTrGACq0LPwJgmZywQyaNNQHcuqa6b1Ys1WvZ+498kQmGykOv6Z+zxuWFGcG6hDp2cHLzENypyd1r20tMr88aGhBOiN9lpDsdgsNYoQpAylslmEN90KloVmxsWBPBhUVtQ/CV3QUmVdAffg4UKFPOGCKt9yGeUDFTQDjW2CwrSpm3gzPEhmEw4oD6ovokTavOj+B5G+a3fD2ARmhH6SY88ROt6i7UQgDyBrOj0sZ6/k8Uf5DScTWGqooqOxjWHb9lm7EhyimTG/fiJrktb6RcHt8ezeEqNRCnOQ==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3678c53-8d42-4b6c-945d-08dee4031868
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2026 12:58:28.0730 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 53fPqxOzTSoHrQPr0PDasD/PunIwuHO1B2jxiNRdbLPqrPBabQEkbYukmRk9D+GPOOoIIjG6xw91Q5PJKGZrHYKNFMh59izLJAVq962W7qQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB6698
X-Proofpoint-GUID: XKe_7gphpYZye_bkNGQWkZbQAUkQTYvw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE3MDEzMiBTYWx0ZWRfX6TrwVOykpSzj
 qUT0X7rHci/43xLbmpAODTfsWSi4e64x2ndHGvIjWIWBnckorNrVlhDYEr1U5EYY5nO0HP40k7n
 hx0stlpnXNFOtSmuDVSCKvuqTjT/xYx+/QWlyqr/9ha9yVIktp9JRkgxp398FV1X8cB5f423hM7
 sOpNBLhld6aFbpYAEhLbnwzWTpsmGZWSyGy26VxaVQBuAuiHjT49LIbjRkAO9bVMyZMIcHJOLxl
 u9QVgmgmsWbCgBYavoRha9Y1OgbqCq0x3BIUSTnsdIJd87Z4xmScTr+o6yfG4A0K/5KC7HmDCys
 TtehHbAU6QI0U0A2+LcTN2DarSRlksGvXAnYQfnXwIVYeGJEvzB2cSqr2UcgIZXVDsh1MfjCW6g
 s4IGTikbC7Eq485vVFdMgyre7DbPoIm0ZKIDbQUMHb9n7Xz4uGnbO7HqJ3rs5WgxTMTMQR2r1nn
 U7CMvl2GF1+EMIgOgNw==
X-Authority-Analysis: v=2.4 cv=d4HFDxjE c=1 sm=1 tr=0 ts=6a5a26f5 cx=c_pps
 a=BVZXAR9urkJIT3zY0dPXyQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=dEe9Ve2bX-KnNSUMM2s9:22
 a=64Cc0HZtAAAA:8 a=O8Tl9FTRNNNyKM70b3MA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE3MDEzMiBTYWx0ZWRfXzpDR372sFD/i
 +lvHS6DJTdE0RdFsC4X0af9+dhB/4FHysjfvt4DiiPx7pZtHpUy8+vVlGvVQS+NW5ZiDivzpEHW
 IMkjuZJKR5vuji5LkldawegKWcDAibg=
X-Proofpoint-ORIG-GUID: XKe_7gphpYZye_bkNGQWkZbQAUkQTYvw
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

On 17/07/2026 13:32, Daniel P. Berrangé wrote:

> On Fri, Jul 17, 2026 at 12:19:12PM +0100, Mark Cave-Ayland wrote:
>> This more accurately reflects that these properties are held within the class and
>> not the object.
>>
>> Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
>> ---
>>   include/qom/object.h | 32 ++++++++++++++++----------------
>>   hw/riscv/spike.c     |  5 +++--
>>   qom/object.c         | 28 ++++++++++++++++------------
>>   3 files changed, 35 insertions(+), 30 deletions(-)
>>
>> diff --git a/include/qom/object.h b/include/qom/object.h
>> index 95fdf01e30..9df02de93b 100644
>> --- a/include/qom/object.h
>> +++ b/include/qom/object.h
>> @@ -2038,18 +2038,18 @@ ObjectProperty *object_property_add_uint8_ptr(Object *obj, const char *name,
>>                                                 ObjectPropertyFlags flags);
>>   
>>   /**
>> - * object_class_property_add_uint8_ptr:
>> - * @klass: the object class to add a property to
>> + * object_class_static_property_add_uint8_ptr:
>> + * @klass: the object class to add a static property to
>>    * @name: the name of the property
>>    * @v: pointer to value
>>    * @flags: bitwise-or'd ObjectPropertyFlags
>>    *
>> - * Add an integer property in memory.  This function will add a
>> + * Add a static integer property in memory.  This function will add a
>>    * property of type 'uint8'.
>>    *
> 
> Can we add a bit boiler guidance here, something like
> 
>      "A static property is one which is stored outside of
>       the object instance, typically in global variables.
>       It is only appropropriate to use static properties
>       when the class is designed as a singleton. If there
>       is a possibility of multiple instances, then properties
>       must be stored per-instance."

Yes, I can add that in to all the relevant comments for v2.

>>    * Returns: The newly added property on success, or %NULL on failure.
>>    */
>> -ObjectProperty *object_class_property_add_uint8_ptr(ObjectClass *klass,
>> +ObjectProperty *object_class_static_property_add_uint8_ptr(ObjectClass *klass,
>>                                            const char *name,
>>                                            const uint8_t *v,
>>                                            ObjectPropertyFlags flags);
>> @@ -2071,18 +2071,18 @@ ObjectProperty *object_property_add_uint16_ptr(Object *obj, const char *name,
>>                                       ObjectPropertyFlags flags);
>>   
>>   /**
>> - * object_class_property_add_uint16_ptr:
>> - * @klass: the object class to add a property to
>> + * object_class_static_property_add_uint16_ptr:
>> + * @klass: the object class to add a static property to
>>    * @name: the name of the property
>>    * @v: pointer to value
>>    * @flags: bitwise-or'd ObjectPropertyFlags
>>    *
>> - * Add an integer property in memory.  This function will add a
>> + * Add a static integer property in memory.  This function will add a
>>    * property of type 'uint16'.
>>    *
>>    * Returns: The newly added property on success, or %NULL on failure.
>>    */
>> -ObjectProperty *object_class_property_add_uint16_ptr(ObjectClass *klass,
>> +ObjectProperty *object_class_static_property_add_uint16_ptr(ObjectClass *klass,
>>                                             const char *name,
>>                                             const uint16_t *v,
>>                                             ObjectPropertyFlags flags);
>> @@ -2104,18 +2104,18 @@ ObjectProperty *object_property_add_uint32_ptr(Object *obj, const char *name,
>>                                       ObjectPropertyFlags flags);
>>   
>>   /**
>> - * object_class_property_add_uint32_ptr:
>> - * @klass: the object class to add a property to
>> + * object_class_static_property_add_uint32_ptr:
>> + * @klass: the object class to add a static property to
>>    * @name: the name of the property
>>    * @v: pointer to value
>>    * @flags: bitwise-or'd ObjectPropertyFlags
>>    *
>> - * Add an integer property in memory.  This function will add a
>> + * Add a static integer property in memory.  This function will add a
>>    * property of type 'uint32'.
>>    *
>>    * Returns: The newly added property on success, or %NULL on failure.
>>    */
>> -ObjectProperty *object_class_property_add_uint32_ptr(ObjectClass *klass,
>> +ObjectProperty *object_class_static_property_add_uint32_ptr(ObjectClass *klass,
>>                                             const char *name,
>>                                             const uint32_t *v,
>>                                             ObjectPropertyFlags flags);
>> @@ -2137,18 +2137,18 @@ ObjectProperty *object_property_add_uint64_ptr(Object *obj, const char *name,
>>                                       ObjectPropertyFlags flags);
>>   
>>   /**
>> - * object_class_property_add_uint64_ptr:
>> - * @klass: the object class to add a property to
>> + * object_class_static_property_add_uint64_ptr:
>> + * @klass: the object class to add a static property to
>>    * @name: the name of the property
>>    * @v: pointer to value
>>    * @flags: bitwise-or'd ObjectPropertyFlags
>>    *
>> - * Add an integer property in memory.  This function will add a
>> + * Add a static integer property in memory.  This function will add a
>>    * property of type 'uint64'.
>>    *
>>    * Returns: The newly added property on success, or %NULL on failure.
>>    */
>> -ObjectProperty *object_class_property_add_uint64_ptr(ObjectClass *klass,
>> +ObjectProperty *object_class_static_property_add_uint64_ptr(ObjectClass *klass,
>>                                             const char *name,
>>                                             const uint64_t *v,
>>                                             ObjectPropertyFlags flags);
>> diff --git a/hw/riscv/spike.c b/hw/riscv/spike.c
>> index 9fde0faf39..630b65f569 100644
>> --- a/hw/riscv/spike.c
>> +++ b/hw/riscv/spike.c
>> @@ -278,8 +278,9 @@ static void spike_machine_class_init(ObjectClass *oc, const void *data)
>>       object_class_property_add_str(oc, "signature", NULL, spike_set_signature);
>>       object_class_property_set_description(oc, "signature",
>>                                             "File to write ACT test signature");
>> -    object_class_property_add_uint8_ptr(oc, "signature-granularity",
>> -                                        &line_size, OBJ_PROP_FLAG_WRITE);
>> +    object_class_static_property_add_uint8_ptr(oc, "signature-granularity",
>> +                                               &line_size,
>> +                                               OBJ_PROP_FLAG_WRITE);
>>       object_class_property_set_description(oc, "signature-granularity",
>>                                             "Size of each line in ACT signature "
>>                                             "file");
>> diff --git a/qom/object.c b/qom/object.c
>> index 622840f9f8..47977b1f44 100644
>> --- a/qom/object.c
>> +++ b/qom/object.c
>> @@ -2724,9 +2724,10 @@ object_property_add_uint8_ptr(Object *obj, const char *name,
>>   }
>>   
>>   ObjectProperty *
>> -object_class_property_add_uint8_ptr(ObjectClass *klass, const char *name,
>> -                                    const uint8_t *v,
>> -                                    ObjectPropertyFlags flags)
>> +object_class_static_property_add_uint8_ptr(ObjectClass *klass,
>> +                                           const char *name,
>> +                                           const uint8_t *v,
>> +                                           ObjectPropertyFlags flags)
>>   {
>>       ObjectPropertyAccessor *getter = NULL;
>>       ObjectPropertyAccessor *setter = NULL;
>> @@ -2764,9 +2765,10 @@ object_property_add_uint16_ptr(Object *obj, const char *name,
>>   }
>>   
>>   ObjectProperty *
>> -object_class_property_add_uint16_ptr(ObjectClass *klass, const char *name,
>> -                                     const uint16_t *v,
>> -                                     ObjectPropertyFlags flags)
>> +object_class_static_property_add_uint16_ptr(ObjectClass *klass,
>> +                                            const char *name,
>> +                                            const uint16_t *v,
>> +                                            ObjectPropertyFlags flags)
>>   {
>>       ObjectPropertyAccessor *getter = NULL;
>>       ObjectPropertyAccessor *setter = NULL;
>> @@ -2804,9 +2806,10 @@ object_property_add_uint32_ptr(Object *obj, const char *name,
>>   }
>>   
>>   ObjectProperty *
>> -object_class_property_add_uint32_ptr(ObjectClass *klass, const char *name,
>> -                                     const uint32_t *v,
>> -                                     ObjectPropertyFlags flags)
>> +object_class_static_property_add_uint32_ptr(ObjectClass *klass,
>> +                                            const char *name,
>> +                                            const uint32_t *v,
>> +                                            ObjectPropertyFlags flags)
>>   {
>>       ObjectPropertyAccessor *getter = NULL;
>>       ObjectPropertyAccessor *setter = NULL;
>> @@ -2844,9 +2847,10 @@ object_property_add_uint64_ptr(Object *obj, const char *name,
>>   }
>>   
>>   ObjectProperty *
>> -object_class_property_add_uint64_ptr(ObjectClass *klass, const char *name,
>> -                                     const uint64_t *v,
>> -                                     ObjectPropertyFlags flags)
>> +object_class_static_property_add_uint64_ptr(ObjectClass *klass,
>> +                                            const char *name,
>> +                                            const uint64_t *v,
>> +                                            ObjectPropertyFlags flags)
>>   {
>>       ObjectPropertyAccessor *getter = NULL;
>>       ObjectPropertyAccessor *setter = NULL;
>> -- 
>> 2.43.0


ATB,

Mark.


