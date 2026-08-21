Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4803FC5DF89
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2026 11:18:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wxNEY-0006h3-6I; Fri, 21 Aug 2026 07:16:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wxNEW-0006gO-Cc; Fri, 21 Aug 2026 07:16:24 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wxNEU-0002DE-HI; Fri, 21 Aug 2026 07:16:24 -0400
Received: from pps.filterd (m0127840.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67L9QC941689784; Fri, 21 Aug 2026 04:16:08 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=t7a/lYHB1pGEFQM/QgHp/O+T0+OGxCmT/hWpBFv/B
 WA=; b=yfMFswb+9lmzKPSqRdt53CaWOGOfLePDVxHb/gePlN+pgjAXKzkgmRYpz
 GHKNwrNbzi9n94IJm1l0C0pj+r39zjddOHXUPzQmRhJCMDAfJ86CcnrbzdTIF802
 GnamDExzNBEQymcGEsQQDUSZZCsfVTmxOpL1yvoemsS8vLsh7svbktmvSAnNOsaN
 LYjbuyFFctJqXFRk+aXAUVCuBvLgdc3nbcob7iyymKfokfGDfM00bmFLhJBbQRiO
 o22XPoU7EQzrOrdN8WxKx3O6nFqR4555hjTmvyPjH4Dv5sN48XOky0rwEWy3f/6A
 6OZcXoh7beFLL3pBtgCo4WejkH4aQ==
Received: from byapr05cu005.outbound.protection.outlook.com
 (mail-westusazon11020105.outbound.protection.outlook.com [52.101.85.105])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4g6jkw0br1-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 21 Aug 2026 04:16:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z9ZaZ1fIqFs2I08u71zUBQ3QS4HsB8AoLOLDrpX3dKVBNJNqk3nnUADzI1DhQjC2WwTPSHb+CKqg+Lt5+2Il9wwDWze7pw2Sk7paa7mjioStLxkM3VKkL95EvfZa2RqiahiXq78Aho95+bs2eB9pWzRxS3xdDKBxN/n78uefIlPJj2/5+3DlAYTXs6GcIYfEl54oNe0g7PDposD5hIG7SYSva01Uv1NicQxC7tvoSvqKIyHTWkwpF4ZluYd2gn4a7n2zcvti5yEDXLLkZkL4YFS3imMLeAV8DH2IKHdXaxx1adciIYklANN2ekpFa1jrFOYI7gZq3f6PNUGWfXo4tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t7a/lYHB1pGEFQM/QgHp/O+T0+OGxCmT/hWpBFv/BWA=;
 b=EeYpFbbganse6mHmJHeN0RthrRMoFkEorLIxkCQ1oRWL1r82D2ukqyr10SK98ixVGBCcWGH57z+oA38Mbn1HpG1v5Y1Iy065MtO0pvQxZ4wCxI0qNPaIAnmvOU5Y++UTueaeN6YbJX6zo7Zt/yXcRzDdd1+wXVo9AqeZbBSGnC3cu8LuTNe8KOM1wIL3Yz5qVIjfMl5qhNNUuagCZgVL/cuXsofNLhpMfOKnLG8vLFu3SLS+fI4/bMU9E+mzYgAs9yX4tDnMCTcQOkNim+OSJ21TERpeLevIaypoztq/QZT4dRo2gZPnsNrUzrS8NqO7wPd3Rddgq+kwV0TUrEVx/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t7a/lYHB1pGEFQM/QgHp/O+T0+OGxCmT/hWpBFv/BWA=;
 b=uR05oS5CT2M1Y/QAQQYTIEvRKpr+iqokMeimVLXuY4LFptfPv02+eT/spniRb8pcJpuGxNrmOFinULrCWnygKwAhGItEGnmn2gQj3S8Desy6Lhw8Ye5Ho92Ti5uiosSVAE/NYXTbP1St94psOe0p2Ad472tUIMZ94iu65NJTRV6WHNVsNwe42Em78Ni2I76QZf0YFY+tvTlEZUY94PoYPB7Fy6N8NL/pCS0iRloMUsgDTwfFAe46oMGrHlGbrZHA5O++v5BsS77jEqrdn7/w2ZQtYNANj+DscqZBJ4ws4EdqYvhkSc63LnenonY94hcyXQyWb094DopmFtlxVpqxIg==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by CY8PR02MB9524.namprd02.prod.outlook.com (2603:10b6:930:6c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.11; Fri, 21 Aug
 2026 11:16:07 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%3]) with mapi id 15.21.0339.010; Fri, 21 Aug 2026
 11:16:07 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: mst@redhat.com, imammedo@redhat.com, anisinha@redhat.com, philmd@mailo.com,
 aurelien@aurel32.net, peter.maydell@linaro.org,
 richard.henderson@linaro.org, berrange@redhat.com,
 marcandre.lureau@redhat.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org
Subject: [PATCH v4 04/16] qom/object.c: add
 object_class_property_add_uint8_ptr()
Date: Fri, 21 Aug 2026 12:14:16 +0100
Message-ID: <20260821111550.276011-5-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260821111550.276011-1-mark.caveayland@nutanix.com>
References: <20260821111550.276011-1-mark.caveayland@nutanix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA1PR03CA0017.namprd03.prod.outlook.com
 (2603:10b6:806:2d3::13) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|CY8PR02MB9524:EE_
X-MS-Office365-Filtering-Correlation-Id: 845f4090-e5cb-4ac8-77d6-08deff7598b5
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|366016|1800799024|23010399003|56012099006|18002099003|10067099003|22082099003|921020;
X-Microsoft-Antispam-Message-Info: HgM3dVr3cM4IyR84qQl1O0IwC0dDSdBpeLyKdHcsnOktxIRopfvk1YhkQMbD/fXgJP6GDf1sJ86ymTV+o9isMt7GwoZ2jJIz41Gev1DdHiwpw77b/bpakkBLQOefs65RSSDS0rvcF4I+Gtxug1iUaO6URth7DEX+nFrM9v7oSGDJrHKhpmnwKqJW8vLBSZBpdty6IUhoRU75Gce4m5Yj9N3w5EqY8txDtVn77Kjo+BFukot3L+GU0Ltj9HnjUTpgx7Dz6Fuiz7RWW1p8M3sbbM6KRL+odZGdKQt5/nUwhhce25km9naFxRk3kRtZ+EaOFDNgxalJsZBrFzZt1dP589hRQTdSYWLAvFqyqPm5NQncU6sLDOxBf/PCVKpGBRRfPNRVUAcw/KZyBQE6R1tehiKx9+ddblB1JIujVoMQOmyPSOfShoL3M9HH9NeNeS88rNi3c9+/kGiKGhfAhRYPB8TGC5DkCXqaaPjTchRp/dqiOZth178j/Z7xoVhjR2JV7v46fDGqCcQHZLzwOopH56x/w8kdm0FdpJBUdbFInrZvvc95U5FBuJWV1epChiHaiJx5LuYGl16r+y+RB4oujTphGbnkUx70EHgLBkZLJFYVNwj+3zNgpNXdV1Uc5Fo+qBTI5rFJGmkaz/yBhVk9R0d92AcRpjr1s/kqd6z6NfhQpNn7Ysrg6YPycl/pgXxfzdf9/1Rfn8nyF/EwliaTFQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(1800799024)(23010399003)(56012099006)(18002099003)(10067099003)(22082099003)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UjlpemRXTjBlVkhBWSttbVhQc2gwZ0gxOXBNTEdLcjV5WFd1TkpUcHQ4VE5P?=
 =?utf-8?B?b3VKQWR2VGdiYzNqOHpIaFR2WVdCTkhpOFRsU1p6L0NnbVJjK3FwVGFlM2t0?=
 =?utf-8?B?QVAra2x6d05LZFRHRVAwYWU1T1g2VUVNN3VaNTI5aHorRjZkTHhjMHZ1enB0?=
 =?utf-8?B?L1ZOMFNBU0xFWnZtRURaODh6NjRMYk43SjFhaXROaGJ6WndRakpUeWpIZTAw?=
 =?utf-8?B?dzZWM1FrQnRGd3NCSmE2by80aHBQNnEvSWF2SnZDb3FUUHlEUURwZmtTUS9E?=
 =?utf-8?B?MlprTTdQM0o5MEh4ZzU4NnJRVzBCUURlai94ZHkyOSs0OGNQSDZpNTJIdG91?=
 =?utf-8?B?WU9sdnhDcTFZdjRwdnlvMi9nNG9iMlR6K3VHNWFESDJVVWUzMzJLaXBmN05v?=
 =?utf-8?B?VWNJNVBQUnY0Qlp2Mm1XTEJSazc2aVFwRWt4RitIa011YTd4R0Vjb25YM200?=
 =?utf-8?B?MUJkWkxKVHVqYXpkdmYzUDFiNWtKbGpHUjgwaTJxK3BZQmg1My9oZEgrVmhC?=
 =?utf-8?B?eXdMYlVidjc3ZnZMY1IrVFVYa1VXOTlMc0tSbmt6WmwyUjlRSmpLdU5mNmRO?=
 =?utf-8?B?R3FMRFY1OXVsMnlQL0VXWHRpemlzL29yMFBwS0ZMMjRPWHEwc0pMbnF1WnI2?=
 =?utf-8?B?RDl2dVIrV2FCT1REMjR2RndyN0tXZ2crUThWdVJxdnFSS1RBNG5kVVRIR1hy?=
 =?utf-8?B?YVdFZ2RNWFN5dVptM01oUUd5NU96UnNCWkMrMmZXNWxrYXRnaThCbVIvNmE2?=
 =?utf-8?B?RGdaaUhQU2h2YSs0VWJyVGh2QkdYeURheUhadDczTUZhU2RVSmJQaHlJVlhn?=
 =?utf-8?B?V29OVjhacnZBSUE3cVRsSHNIWENNMHZ3Qm9hendRZTVyNjhoeGowRDNGK1BZ?=
 =?utf-8?B?UzVIM1NBQUlmSUNPSFErQTEzcXdtbm9SM2xtRVZ2MUVqTURNZHpGQkxQUEN3?=
 =?utf-8?B?SWhOZEFLM0VRSC9Pc3paYlZyajAzSXRmNTJOUUlDQVVwS25iR29FempqN25i?=
 =?utf-8?B?THFlTnNZQmxHZmZBTzByMVBJK3NGYW9iOWloZEFITDhlak9FaStadXhESldU?=
 =?utf-8?B?Y1Vld0xDcHh0M0c2cTdZUnp5aC81M0lzNWVKYTZ6WFBidGJVS3hHUCtNWFc2?=
 =?utf-8?B?bFVWRm4yVVRjRlRMMEUwU2NnSkVndGNtQ3lzVlFVL0RDN0w0Z1ZWT1d1V1pO?=
 =?utf-8?B?NmQ5djl2dWh4SVNGNU80alM2QUNuTkRNQVYyUFM0czVqZVY0UHpxY3RJQWtz?=
 =?utf-8?B?NFlpVVVrK1haOURaWnJNYXBBTDlsbjl2ZmRzaUlPMW1Sc0MybU9RbGE1cjJv?=
 =?utf-8?B?R3FHQmhLV1hvUzZCNldKeXJHbjJMVzlhMGlLR2xkMkJzcnNQNjVUSVdKNjYx?=
 =?utf-8?B?VzhJMkYvUTE3TEsrZGluaVR2YUNLVHFOSFBvSFcyT1pOTG9UMzBEbFJWUzVR?=
 =?utf-8?B?eXNZdWs4NEJpTEthdXRZZHBSZVpDVTR6NDRRNlcrQ0tSUE9XOTNwS05kbEpJ?=
 =?utf-8?B?TVd1WUtGQ0N5clZqV0grM0poakp3TERYam03UEZkdTRIRklLdmtuOUt1ajdP?=
 =?utf-8?B?Mi8wSW9JQ0R1Nlo3ZUpkSHMySEhXZEZRTkhTYmFtWXkzTG1CUDBpMVNSNU9W?=
 =?utf-8?B?OFV6cXhBcC82WEFnSWlnL3dDQ1ZpM25KV2haRm5lK1FUbGJPZjNxclFJQU80?=
 =?utf-8?B?b3pOQkp3Q05mTGg2ZmNRTGY2MEVkQjM2dHowT21HSitnY1FjeS9mZ0RJQk1w?=
 =?utf-8?B?UjkxWnNvRHYweXlzQVc2Yzh0b0xXcmU3dER2L2pGbWpLRll0eHg3ditMZE5F?=
 =?utf-8?B?ek8yY2hRcHJxMWY1SlkvcjNDeVgzMytKOVorNFNibzI3UXVKekk5QlU0eW5Z?=
 =?utf-8?B?TU1EVEQyOVFXTUZTMDBlUnZmQm1SamhVeklVYVhYak9KNmRIcnhNVWxmcHVW?=
 =?utf-8?B?MGJJMk9nOE0zMG01ZkFNZEtFQWhBU25iVEQrWUxQdXBQNi9wNzdTRGJMRUVq?=
 =?utf-8?B?dzFsV001Z3NLMkFTd3B5WjJSVE9LS2xSZERaVGFZLzNsTkM4VDVEdzdtZVIv?=
 =?utf-8?B?cjJmcDRmMjY5Vm5LbURLWmRDNVM3N2tUTk5KYUtVdjNITXNQN0ovR1dLLzV5?=
 =?utf-8?B?dlY3TmtkOGFTSVR4bjFvZE96M1BhQ2hUOWNjSXQ2aHUzWk1SWmZyTXEvQ0hq?=
 =?utf-8?B?RDZhVU1HQysrT3JRV3pYNGdnWjM1dks0b3JQb20wQURsVWlyV1Jtdy9hR0Mz?=
 =?utf-8?B?WnVmbHZudS9FcnlURG5qSjF2LytKWEI5WGdpSGx5bEVIRU5YSGg2eUhLUHJx?=
 =?utf-8?B?ZnNDNzBuNkp5V2s5M254WmpQVStVSnhqQ2YrMldNaHdMdjNZK1hHMGVHQytC?=
 =?utf-8?Q?6NZ3b/EoipWuHiCg=3D?=
X-Exchange-RoutingPolicyChecked: BhpV2kJcKyNxQaawUHptvYffuHxHc24iit96Bg/hn9drwaJ21QroeK3tpL4YcdU8XqV1Mwfh1KJVg/rx93xPMGhfx3uanDKDyHGzSqvwV46Z2Ee0eRRDODZ/FV+eRSHh6+GnDUni7AucpzyoxrWl3PdErLdvu2/qEOqiJW0l7SRz41gPeQangmgp3RMICU510Qg1CwzB+hdlNnFC+E+qu8l3VNNZ4qMTSoD61hKi6ok55fYoRA0FceVKQr8knDaNHL4NlnwZ10drNR1+ogVDUgL5kfI027aWr5xfwBv4ShF8PHBts1zE7JbtjV2/ZPfpzt8qo/VsvbyPPm2/afHZcw==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 845f4090-e5cb-4ac8-77d6-08deff7598b5
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 11:16:07.3914 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RQ0iOiUx2MgApYOUveppVOke7MGki5QT+sIhpLOp9vyhx/31JbvB4CoPOwow5FHc84u6kzHPSMwej19p1GaOLw7UVMTHEz8IEkR2OM/bmCc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR02MB9524
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIxMDA4NCBTYWx0ZWRfX68KCKc0eAWfw
 p2hRkkJRuDRZN23rZvd8yAQKCDqfv5+hO3RF6Ch4GsjpKaMvK4zWUfcW4O6evY5+TdJ//DR6TdG
 E2qSWHykq5UyAZHqjNdWcQu0Q+6z48BWRcuQJCv2B3AA1/JjtoKQ652LGMmkjsc/eiMf/0JT694
 S7nZOEKO0yh6QqojbtHkvTptuERpt0e3bspZTBo5m1WHfqCQxiZATci7N/MI/SUmXSu9OxhC0k4
 ziDxRaosKZ8jI8zyZdwInjZytKs4ZGhWwDmCFx31N1IZ9TXt5tZR5cqTdkObEe2/cz3RMkA7m/9
 rmpNsLeGD93F7StNIUiWp6T/wrQru+bSvL/EcJM9lBhs9XicJmGOYbFW3XrjS0SjZ66cM4zao24
 FlwkXZrDr4WIzqcGOD+3cZUvXHpEgxUN0uKiaLWapwGE/tzPdxjXF5g1nJeYjzKDe+6Sam2izQ0
 0Eo20IJPqrE2BB6ceGg==
X-Proofpoint-ORIG-GUID: OwFVyfFPm1qJpUe41B5a61hCdJvLkM4m
X-Proofpoint-GUID: OwFVyfFPm1qJpUe41B5a61hCdJvLkM4m
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIxMDA4NCBTYWx0ZWRfX+ek9mujydJmt
 3RUxMmTPKfEB1mWH2MDvA9H0s+dI648COilqcgIhBEFyIA28tu7SF+Aj6RO/Go1i31Q4tTDdNk6
 kzTbBZOvZuIu6JgsRsV8F9IzIbg7JI0=
X-Authority-Analysis: v=2.4 cv=ernvCIpX c=1 sm=1 tr=0 ts=6a883378 cx=c_pps
 a=KI7s4FTSNOfRXFB7i9gQ4A==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=_-M8LpHI31CeLmyZm6wg:22
 a=64Cc0HZtAAAA:8 a=20KFwNOVAAAA:8 a=4QfE8SPBBHYfMhEiUa4A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-21_03,2026-08-21_01,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0a-002c1b01.pphosted.com
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

This adds a class property that references a uint8_t within the object instance
and is intended to be a replacement for object_property_add_uint8_ptr().

This commit also removes the __attribute__((unused)) annotation from
object_class_prop_ptr() which is no longer required now that the previous defined
DEFINE_OBJECT_CLASS_PROPERTY_SCALAR_METHODS() is now being used.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 include/qom/object.h | 18 ++++++++++++++++++
 qom/object.c         | 23 ++++++++++++++++++++++-
 2 files changed, 40 insertions(+), 1 deletion(-)

diff --git a/include/qom/object.h b/include/qom/object.h
index 11b1c9d2dc..eba675d218 100644
--- a/include/qom/object.h
+++ b/include/qom/object.h
@@ -2033,6 +2033,24 @@ ObjectProperty *object_property_add_uint8_ptr(Object *obj, const char *name,
                                               const uint8_t *v,
                                               ObjectPropertyFlags flags);
 
+/**
+ * object_class_property_add_uint8_ptr:
+ * @klass: the object class to add a property to
+ * @name: the name of the property
+ * @offset: the offset from the object instance where the uint8 value is
+ *   stored
+ * @flags: bitwise-or'd ObjectPropertyFlags
+ *
+ * Add an integer property in memory.  This function will add a
+ * property of type 'uint8'.
+ *
+ * Returns: The newly added property on success, or %NULL on failure.
+ */
+ObjectProperty *object_class_property_add_uint8_ptr(ObjectClass *klass,
+                                         const char *name,
+                                         ptrdiff_t offset,
+                                         ObjectPropertyFlags flags);
+
 /**
  * object_class_static_property_add_uint8_ptr:
  * @klass: the object class to add a static property to
diff --git a/qom/object.c b/qom/object.c
index 9cb2cae4a7..a480fdd400 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -2703,7 +2703,6 @@ DEFINE_OBJECT_PROPERTY_SCALAR_METHODS(uint64)
 #undef DEFINE_OBJECT_PROPERTY_SCALAR_METHODS
 
 
-__attribute__((unused))
 static void *object_class_prop_ptr(Object *obj, ptrdiff_t offset)
 {
     void *ptr = obj;
@@ -2742,6 +2741,8 @@ static void *object_class_prop_ptr(Object *obj, ptrdiff_t offset)
     OBJECT_CLASS_PROPERTY_SCALAR_GETTER(type) \
     OBJECT_CLASS_PROPERTY_SCALAR_SETTER(type)
 
+DEFINE_OBJECT_CLASS_PROPERTY_SCALAR_METHODS(uint8)
+
 #undef OBJECT_CLASS_PROPERTY_SCALAR_GETTER
 #undef OBJECT_CLASS_PROPERTY_SCALAR_SETTER
 #undef DEFINE_OBJECT_CLASS_PROPERTY_SCALAR_METHODS
@@ -2767,6 +2768,26 @@ object_property_add_uint8_ptr(Object *obj, const char *name,
                                getter, setter, NULL, (void *)v);
 }
 
+ObjectProperty *
+object_class_property_add_uint8_ptr(ObjectClass *klass, const char *name,
+                                    ptrdiff_t offset,
+                                    ObjectPropertyFlags flags)
+{
+    ObjectPropertyAccessor *getter = NULL;
+    ObjectPropertyAccessor *setter = NULL;
+
+    if ((flags & OBJ_PROP_FLAG_READ) == OBJ_PROP_FLAG_READ) {
+        getter = property_class_get_uint8_ptr;
+    }
+
+    if ((flags & OBJ_PROP_FLAG_WRITE) == OBJ_PROP_FLAG_WRITE) {
+        setter = property_class_set_uint8_ptr;
+    }
+
+    return object_class_property_add(klass, name, "uint8",
+                                     getter, setter, NULL, (void *)offset);
+}
+
 ObjectProperty *
 object_class_static_property_add_uint8_ptr(ObjectClass *klass,
                                            const char *name,
-- 
2.43.0


