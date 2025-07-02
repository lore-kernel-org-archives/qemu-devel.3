Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C526C77B7C
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 13:31:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWxYX-0006te-Ef; Wed, 02 Jul 2025 09:31:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1uWxYL-0006rm-MH
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 09:31:14 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1uWxYI-0007PI-By
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 09:31:09 -0400
Received: from pps.filterd (m0127839.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5626qGb1003250;
 Wed, 2 Jul 2025 06:31:01 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=uH4VaAOepdgXvttDAlYTVeNr1KP9ZrMRJzuNBaRt/
 Qo=; b=NLyOt12GDAN52bL0uXC5pKCnALjMDcyhFhLrZfasIIWQ5QBCVZWkDtlH5
 pb0dVt4sltwbjNptWQiKfRLrQX7sss1bABRnuhlW+XKtSL+KDolsow7NLSwTHa5C
 0j7aPkr0I1p1aGb97JmWDEJohm0tP47xGtRGqfn+lCtpwz9rHi6Yh0L31+iBe3sl
 4D8OpRkJ5mySKjt4Yxyo6JQpe5SACdUyK6oN26VknsOHkv4TRJW2/s3X5ebDLSMA
 LKv7W1cITBtXRkGZVVjDeeemY0faYBAp0o+HRTrJWlRxMTx1Z0me73AdlrWb7344
 WwIyrY0fgSqKl1MS0AEksIQDrc+Sw==
Received: from nam12-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2113.outbound.protection.outlook.com [40.107.237.113])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 47mhw2tpn2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 02 Jul 2025 06:31:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tlhPDIs53IbG5gYewz/sZHgw45FvDPqnbQ6rXno4SHBDFHFykGX8IKEKkh784ntChVTHWgfMfRhEM6UIr1EvU0Ge5YDF4mW91yNIz5O6VDflBgFT3BCe0N+A/+nBNqk4s/cCqUCBZbgs/x/6vmGVXQQ8Beo/cuEEZsk8mAqkObJVrqETayPmKk9T95PRYsKMdilOjq8ran6RoXBQW3yWOkZwcUqpO5fDfQTLbmYBhX13BL911GWdkFD/5m/tTT0jj69lvzeT6qrDG2bSWt42uZPmDFguVifgYHGA4kAvI48SE3S88mTB8wB59/Jb6FCNMh/5G8O6O9MwuOTp8pAyMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uH4VaAOepdgXvttDAlYTVeNr1KP9ZrMRJzuNBaRt/Qo=;
 b=uP7ZD6j0GWvdY4R8Arn+iLtBfGlRs2Xx4AYCcyukHrXtrhWxzh0weAzi9NJumxRjlQpu8vrMdOA47WH8+h4Q6/2dmV/Tqr80/qKuIt9S4CZ7Ghbo4s4UWc6HwM+VJyU71rN1MhkhebFPCBsKGmfiJkTsaIwV+ISIH/xXby4w4EKCYKK3kAKA6vKXGA1k0Wxy7o5RH5W/XafwTDro3MW0gA8cTGmaUg2bdQx9OrpGV4WpjSE8tneaakYR/AFL69kLhB8Y9fs/pYYbbbdURpiN3BhLzphth9wB9szs03zSLJNnm+uP5eZQS67MHPUQIyJ+1bbV28f97trhVy876kzesA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uH4VaAOepdgXvttDAlYTVeNr1KP9ZrMRJzuNBaRt/Qo=;
 b=fNvGRM9xsOq83F/6MA5oYzlUTpBU/wOR8zN6NMFceTwuW/SksaScKlWnVHtr7Z/a1h8AvcGhjrRI+ZnLodxZxOifJagZhZ1rkwbu9R+Re66F7PBcm3R4DeMvHn4m1SuuyIucMjnuLfubbFN7nlgkYDq0fjKYZ4WU4sp6ST+ngV//BXR5oNNgyuMwLlERBocqo9yLAD99WycI0ijuIBjHrBJkp3sPBG1ewP6g8iip/I/BTbc0//F2kfF8OL77fqMoRzYU0Atua982j6klsEZtCpXVJ8YbbZjJkHAirtJOgke5Mpbww1IgADpQFMqANZRbBQmmISim69Go1dEoFCT5iw==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by BY5PR02MB6770.namprd02.prod.outlook.com (2603:10b6:a03:20c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.20; Wed, 2 Jul
 2025 13:30:56 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88%3]) with mapi id 15.20.8901.018; Wed, 2 Jul 2025
 13:30:55 +0000
Message-ID: <4d5973e0-b4d7-4201-bac5-495a12972de4@nutanix.com>
Date: Wed, 2 Jul 2025 14:30:52 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] vfio-user: do not register vfio-user container with cpr
To: Steven Sistare <steven.sistare@oracle.com>, clg@redhat.com,
 john.levon@nutanix.com, qemu-devel@nongnu.org
References: <20250702120043.267634-1-mark.caveayland@nutanix.com>
 <4543142d-de4c-42fa-9309-3f00ad44110f@oracle.com>
 <b2bb792b-183c-439b-90b5-9a2f6bcfe864@nutanix.com>
 <8b751d27-7826-48e8-9821-9a961e2f509b@oracle.com>
Content-Language: en-US
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
In-Reply-To: <8b751d27-7826-48e8-9821-9a961e2f509b@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM9P250CA0029.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:20b:21c::34) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|BY5PR02MB6770:EE_
X-MS-Office365-Filtering-Correlation-Id: 5bc5c5c6-ee6a-4c65-735a-08ddb96cac6a
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|366016|1800799024|376014|10070799003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UFNJNENyakpvbStaNlJYdEhDMTdTd1U2SDBVUXRQV2VuNDl2SlRKVXU2WlVr?=
 =?utf-8?B?bnlDbFo3WnRhTHBvbjRxVkRjOEpyNFhoZnVURStpczh6bGZWTWVDVk1GQ0ZX?=
 =?utf-8?B?WUV4dkd5eHNBcHdxUnhjR3pNL3F2b1RDNTNlbUZKK09odmhQdmZFN2tqa1Fs?=
 =?utf-8?B?b01YT0ZvS1JxN20rV05pQTZTSmtoV0h1WHRYSEpubll1SzlJbm1IOE1MV09k?=
 =?utf-8?B?OGtVWWhrZDNOZ0FRd1ZCZmVlS2FiamxVZjVqbm5sS3cyb2FNOTFVRllKcWlw?=
 =?utf-8?B?eC9MZWREVkJnQ28zY2dJUWhZKzZsOG5EQnRhaHpyV1J5YXh5NU5kNk1LL2o3?=
 =?utf-8?B?UDNyK2E5RDd5QlZwMVFrR2x2ZDNUeFJMSTMvZEhLdkFqelpVdG8wMStOQ0or?=
 =?utf-8?B?N0ovV2JyQVU1eXJTa0xpYWhvQ0lWVEJvYnNjR0pJTnBGYldIaVJkemlwNTYx?=
 =?utf-8?B?VitsMXZUeVN0amVUY3NvUWFTUkFUemVxM0pNekVsVTNWcnRGS1VrLy9EMlly?=
 =?utf-8?B?THZzeHNPOXpTVWtEYWVhRmorUFUrR29rTWYrQTRGWFVFZzFKRlZ5UGhTRVpz?=
 =?utf-8?B?VnJRakUrQVNnS2tUYjhaaWJvL3RDUXpZTWlveUg2TUZac0wwUVc0Mk5wWTN5?=
 =?utf-8?B?dTR3WU4xZE5mRG1QUUl1dEkvaktvYUJvRmt0WW5rbzBTRU5QUlVkL2hOQ3Uv?=
 =?utf-8?B?K1pSOGRWOW1hQ2pDd0ZxRVAzZzFtSGVEUjZ0b05hVWw3dW82UnI0VU5KMzhD?=
 =?utf-8?B?c2ZRMEV6RmJrcUtjaW5kSmNld3BLeEJPdmhQWlRyQStpQ0ptRVlPc0UwTUhF?=
 =?utf-8?B?MmZYU0UxN1FmQVQ5WWQzZThFUEZtbHN6bTlSZ1RLYWFyVmI4KzhNV1JSV0dh?=
 =?utf-8?B?SXljdWtKMy9oek44TEo5d2h4dnowSmhzU0dBQWpKNnlXM20vajdGUUxOVm1U?=
 =?utf-8?B?VWN1dXZmTC9OYUVCdEhWYUtpQytseEJjenVqdEl0bCtvL0hqOGpmd1hYeEtn?=
 =?utf-8?B?eFZ4anlyR3RJcTZXbm5yZy9xMHp3Q1ZkK2ZXRVlZRHc3SU1Fa1dDMlNZc2Jn?=
 =?utf-8?B?R2ZtU1F6dW1nVWhjYzE3T2pwM2ZEbzhrZ3FTbGFlVkN0S0NrOFJpUEl1S1Z0?=
 =?utf-8?B?ZjIvWkpBbTlya0hyay9QSFQzQ2ZuZjBIczR3S2RqQ1lJZVRKY0tRS2F0OStN?=
 =?utf-8?B?NTMwNGJEM2xXQWsyT25NUjJaaWdOVVV4bURzNTNkNEIzUjBnd2JvSEJodk8w?=
 =?utf-8?B?ZHplazZxUzNwTUlabjVFMThSZDMwU3hIdjY2czZRVHh4NC8rMTZFNjAxVE4x?=
 =?utf-8?B?bGo1cHBmU09UdThWQ0tZcWtTejhPeGNWcXRPRk91WFNXVTEwc2Q0TnRUY2p3?=
 =?utf-8?B?c0h5UjFHaTFMVzFIVmtaNStWRWNpRUdYZWd3Vk4rUHJsdnN6bTQwWksrWnJY?=
 =?utf-8?B?dWh1NitTaUVBalpOdDNOSkN1YTZIVW9kdFY4bDQ2LzAvNEpwdTY4OFFDSGIr?=
 =?utf-8?B?aXpyWVNwV3ZSNnVZbHd6Vklwa0tnM3FuYlplMVFJZk81eWJzOGFWSkNCQlJ0?=
 =?utf-8?B?OWJjQ0pJdnU5dGtNbk5qV3dhZ2ZOanVjUUdVZzAzejBHbjRHNEFzSlVOb0tW?=
 =?utf-8?B?SzZuNWJoOEdXZW9UTWtiWmR6b20xWDRyUytRbG40dVhsTGIxQ212YVYxbU5V?=
 =?utf-8?B?bmtBRU1GMm1lQlAyVGI2L1FYNU5vaVFacVpXQ2l5NTgyNTU2WGJTbzVRTWxZ?=
 =?utf-8?B?Qk5PcUx5eDA0L1pSanp1NlQ2aThIdkNYeXk1VG5LTzkrOXVIZ3hvbjRkb2Vt?=
 =?utf-8?B?MVZHV1ZvQVZFZ0o4Wk9GblVPNStyVG5OKzFURzVaVUNSL1BYU3Z4Y2xVMnRC?=
 =?utf-8?B?R1kzMTRRUnMzZmVBMEhob05NdHhxdEV6YUtkVjdkblNIWmlQdUErRmRTWFBu?=
 =?utf-8?Q?bcthlEUQEL4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(10070799003); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WW9UVFd4QmdvZmdGZDNKeHAzM3lsUGNsRElyTmhBZjJBVFRJdElGZFU2ZUFE?=
 =?utf-8?B?NFQ3SVh6d0FxQStjVDRHMDNBQ2RZZVdpbEJLV0J1elFMNE8rZTN4YThHYnMy?=
 =?utf-8?B?ZlR4TVV2RUthdnUxTWpsekROaERUcVcwczltRjZtYVFlS3VCQlVpSkFQQW0w?=
 =?utf-8?B?elRCZVpsaElXWVZSLy9sVHdyU3RmMW85RWp3akovNldnRU1TOS9FRlBuZTJr?=
 =?utf-8?B?TThxUWg5ZGRnS005bnpHcjNiZXlpR2NZU2RwZEt4TFlDdUdZZTE5QzlEaTA2?=
 =?utf-8?B?bjNUcDRETDRWT0VqWjM1RmFZTWNpM05nZ2FzdXZhS0FQOEZLOUhhMGw5YjVy?=
 =?utf-8?B?bzhJaGNzaUdHQjdVY3B1VDA1L3RvVUFsM3JGa09KSC96MWZqSGN1bXZSN28r?=
 =?utf-8?B?ZmgwYk8zSTcyaEo2K0U4WE0rSk44SDIvWEZpZjVGZ0lZaTFVMTFnOGtOblA2?=
 =?utf-8?B?d0R2bGhzR1Y2TE5EdHNhdStTdFF0T0FWbFFJZlNSSFBEeDEvTkVnaU5WWGtz?=
 =?utf-8?B?VjU5OXZ6WVpMdTF1T1RwSkxONlg5aSt3TklrWkw3OUNzN0dDQitrVjhlaXhR?=
 =?utf-8?B?SjFSM3dRQk9oWEE5NFpqVzc1VkdyZmJGc0ZsczAzdVc3ZXg5emJpRUdyWGNo?=
 =?utf-8?B?S05tSzhRLzNUZmQ5ZnI1ajI3dE1zNXR6M0JmV1FIZndGNTcxLzhXRk16ZDk3?=
 =?utf-8?B?U2QyWHcwaGpvcE5oaUs0emxwdEVUd2tteVJHQ1N1YWFvNHJkcVZoRDI2Z2N2?=
 =?utf-8?B?bnJ5N2M4V0NadUwvK3ZWR3hXRnN5NHFxYmpVMXV1QmJqTERlUE54OWZPNWdi?=
 =?utf-8?B?eEtkQ0dkQUJQU01aRWpKS1ZaMUxNMDdwRDdwdnRjMitaMjZBWTBkVGRJcWVn?=
 =?utf-8?B?Rk5nTUxYMnpZWFNEVG91RjlDUGt5aU1yalhnOWZqZnVybmNhZTdiQUtNUE1i?=
 =?utf-8?B?eW9vTHBoaDZHeWZONGQvTks5NXQ1bDBIbVIwT1hmOXdWTWhrNFNoWDRxY2Zq?=
 =?utf-8?B?ZnBPYVVmZEZHUFJsZEI4MVFZdTlGWWxvbHhBcEJPaDFQY1ZzMFEwK2xCM1Jy?=
 =?utf-8?B?R2ZjZEFMOHc2S2dtY3NNdkk3NlFSZHBVTTFKRkFxR094dlh0bzk5enJ5bUdJ?=
 =?utf-8?B?b2tyWG1CN3FiS0N6Z2pOM28vd1lURlllWWExT3luQzdrdWdHb2JNUUJocDdt?=
 =?utf-8?B?MHdPemt4azJuT2xjK2RPSHdESnZMU29ZNnJpQkpFa0JDdDNZY29PWUJ5MWpG?=
 =?utf-8?B?RGFyTWwrVXhxUUcrSGxJL1BnMzkxbEZWSXo3RU9nQUlXSUsvcFdYRGtvbVdV?=
 =?utf-8?B?eDV4WXJpMCttc3h0bjZ5dmJWWTJHbGlVWFFBYWZGMzl4K3V2dXl2SC9sTGgz?=
 =?utf-8?B?VnpRbjlabWdiR0xxUGs5WEE0dVFiRXBzVUNBQndoWWF5QzNDTER2Z05mVkRo?=
 =?utf-8?B?MGl2TW9XeS9CM3J6V0E3azRiWFQzY0tGWWVOazNSZ1hvYU9WcFUzRGJGM0xa?=
 =?utf-8?B?ZGlsSC9vd2VUTEI3bkpXVzVLZE9kbHpHZFpjVjllZSsza1hTeE81S29Gc0pn?=
 =?utf-8?B?ak1LNy83dlBoWVI4K3UvSXBvc29YOUMrL3doSW1Da0NFS0dLZ0VHZEJmS1pE?=
 =?utf-8?B?TG55UkU1c1Yrd3VCaFBkMGlJMEJlUnFOeDBsZ0Q2RldXN2Q4NXBUdkdFRTZT?=
 =?utf-8?B?dVJrMVJqd09UNWwrSGJpSUNneFZnS284dUNhVWJMWlpRSmU3a1NLaEJBY01P?=
 =?utf-8?B?NGZzNkpTa0pOVE1GTDBKelk5QXQ3cVA4RHJNc2swc2pnMVhHOGRhVnRGcExw?=
 =?utf-8?B?ZlVIRmR4dXVYOVFkaC9ra1AvYlpJR0lLU29tUHRmNU9GQUlydTRGWHQwcFVX?=
 =?utf-8?B?Q3lsay9kczBjZ3FOaUxyNzhMR0dxbmx5MXdvd3dvM2ZvQXV5Sm5FQllGTlY3?=
 =?utf-8?B?V0Z1U3FQd053TnVRY3ovblFOeDFxS3BOTmU0STU1RER2Z2g2UDdFRnNyZnFU?=
 =?utf-8?B?ZVFsSmw4WlpxaUl0eXpyQmtkSmQ1ZGZaTXhaS3ZNazNIcUZua0Rsdm11dG41?=
 =?utf-8?B?NDkzc1ByRFdFcjNOY05nMVpXZHk5SGVRbVdUdWt3NzdGOURjQU81VGttd1JL?=
 =?utf-8?B?dGZYQXk0RmFzR1l3UHpON1dSeDBJdEZoZW1SMlVuQ2pXWmNGUHF3ZnNzTFhk?=
 =?utf-8?B?eU14YTB2RjllZlJHYVBFYUd0VXRSMmY2N2dZbEViTDcrNllEVWJEZHBKalBu?=
 =?utf-8?B?Q0xVMXlSQXdUakI5Y05GR2tHRVh3PT0=?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bc5c5c6-ee6a-4c65-735a-08ddb96cac6a
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2025 13:30:55.8869 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NRWOqJt7VKVshCtuOzxwnZw4vM0d2FxvQgB/rb1z6hU2qY38juSHruPzlnUO9vyrFtJKDoyFEbxwgsl+FeL+G31m80dDga1lFs0IceP2fwU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR02MB6770
X-Authority-Analysis: v=2.4 cv=ctGbk04i c=1 sm=1 tr=0 ts=68653494 cx=c_pps
 a=8pvF1+Jk5vGtK47n9Xt15A==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=0kUYKlekyDsA:10
 a=64Cc0HZtAAAA:8 a=f3vUbMdx7Ur1a_f8olcA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: QeArkyi6KpqrvkTul619iwoosLEeGWPs
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzAyMDExMCBTYWx0ZWRfX8x49+7SzMPWA
 D9R9N3ps4lLt+LJQdrhpmQC+xvwgZ20FyrypQdj8NTYKjiVmh4vC8VhvRn0+I2aX7AM/CcjadEq
 ZkHQxNpgjqyxm88rbyiIevDWWag4PxQPGJoSAqu8pkmC056UJj8vVWD+WEgCvG5xRZxRcFZIHKQ
 x6WBKUas4eajM3a8igisD9kn6zURnQhb+CUxEG3efmF6kOSSjgTFhm+gXRNNrgL0Yog1lyJDGur
 i2d8O7xvhmda+cRxzLpXhvb1fAEYyJncKi3iDxKRMr4N++NmNGQ7bPy+9B8BsOl4yG+wwvhVBCe
 NcWUTTzHArSUGT48kpRRSbpM4nJ7Qp8qs+PnsUZ7hSKJPxespzAn3TS/2ST3Q8/qpA4S3uaDUfu
 nCdtpowVBHIBliBU0lr/Nkk0EIR/wwpddJWPiqEc3z7GUV2hZh2Tfl0ZfQZTB8M/35vn7s1M
X-Proofpoint-GUID: QeArkyi6KpqrvkTul619iwoosLEeGWPs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-02_01,2025-07-02_01,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.237,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 02/07/2025 14:24, Steven Sistare wrote:

> On 7/2/2025 9:21 AM, Mark Cave-Ayland wrote:
>> On 02/07/2025 13:07, Steven Sistare wrote:
>>
>>> On 7/2/2025 7:59 AM, Mark Cave-Ayland wrote:
>>>> As the full cpr implementation is yet to be merged upstream, do not 
>>>> register
>>>> the vfio-user container with cpr. Full vfio-user support for cpr can be
>>>> merged later as a follow-up series.
>>>>
>>>> Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
>>>
>>> This is fine, or I could drop my pending patch "vfio/container: 
>>> delete old cpr register".
>>> Thus the vfio-user container would be registered for cpr-reboot mode, 
>>> which is fine
>>> at this time.
>>
>> Have you got a pointer to a commit showing how the registration should 
>> be done without using the old register/unregister functions? We are 
>> certainly interested in looking at cpr here at Nutanix, but since any 
>> work is in its early stages I don't think it matters too much if the 
>> old functions were to disappear.
> 
> No.  cpr-transfer for vfio-user is going to be a bit tricky because of 
> the external process,
> and the existing registrations will not cover it.

Got it. In that case I'm happy for Cédric to take my earlier patch to 
remove the old register/unregister functions from vfio-user to avoid 
blocking your work.


ATB,

Mark.


