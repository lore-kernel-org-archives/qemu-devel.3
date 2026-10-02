Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67BE7CA5FC4
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2026 10:58:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCaxb-00083b-SO; Fri, 02 Oct 2026 06:57:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1xCaxY-00083K-PO
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 06:57:49 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1xCaxW-0007gZ-LY
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 06:57:48 -0400
Received: from pps.filterd (m0127839.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6929l3RN1562089; Fri, 2 Oct 2026 03:57:41 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=lvQf9bUqruZM5YBvExIMBZmlCRA9+tVYzLre4dtiI
 1A=; b=XsAEJJDwiaPomFWvjpNm65eTU9mqn2ljEgeIrvt890QUXO+uCOuVEVPbI
 rQKCFQtn4e0R5qs4ao5Bjf5bh25QQER9sK4XJhHfM+Lt7ttLmxZ5InzfrS0nV1Vx
 MNUBVvWgM3uBAUScqcPUiGrCKO0GHPmSwZ8qVfeUmL2cvZwDEtgFCTb0dJzKBeg8
 o9Swy3o+FCkfd9wPwGCzFLWQlXYT7NIOlTnFNnAPfJts+VzCBr8txZycUa1p5n6x
 w58W+hjBzPfdV0zL/T0SPk4Z+9jppRFdpfmHI8hh2vRx/N3AcENz6ZLQnl+naOqI
 3/yV7IJ86kz7QFCiEKjbaaBjIDk9g==
Received: from ch1pr05cu001.outbound.protection.outlook.com
 (mail-northcentralusazon11020141.outbound.protection.outlook.com
 [52.101.193.141])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4h1en9vb8a-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 02 Oct 2026 03:57:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MZUhMjy857Lqt7/4dT11KBol38aFBlnr3iixOF+RKI52R8UODpkpDHiuCyDbuqr9nqGiKPTKGXGvCCEmssvdYYu7IdBRBxjXL43EEI5vPhLdRo2YoEQYa8jMmYraIwFuRkJRcrHN14XPrTH6/UoEnVXRAM69R1DotZN/LAbmi9ejPt3PRWQ5pj25zMBmlV4gtKpDkYgv+ApQ0cL9pCjmWDt5vjyx1qerZUZqI07jaO1kyoJ37t7j2sDNDvqvxG61fOaZ92L6bnWfP6NWxaGDAnuE3QgXhdA9upHNBC9ufJy5ekwJQ8mZ14V/2a1bxF/dWwnZ/SzTiEuCDf3KUA9POw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lvQf9bUqruZM5YBvExIMBZmlCRA9+tVYzLre4dtiI1A=;
 b=CovDUwDr9pQl3AEhrv0qMnCDV6eBuugeTWIiOUeGfZTnIPQVHs2P7YfU9ag2yh4+HGcQduMq2L7ba9MmwmE4CrTZhkbdfK/vv33ROCakgmSRKWKbtXyj0uFln/P2LE1gytFBQVX8bzETQS+ZuohgnAN9xv9bn0Wu0CUhneTBFk6lgVozXXLtgqnlYUU9aZmmf0LfG1D5xI1UQ4hqhnJP5uoT0riNGt9WrRvcCjgIAhod/gBDUuPKxg9jobejbk/u4nCWu2+Jg8GUy/obnIO7y1CUiduIqgpFhPWKFidEQWlFXW6nf5fExqCEFVVRJBXA3Lrhu1Dq1ncRgebzTOf28A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lvQf9bUqruZM5YBvExIMBZmlCRA9+tVYzLre4dtiI1A=;
 b=i3ynsF0d035Jdv4JWbjYiye0Nknkj0EgTR2TbiC+Nr1YoA9FUbn6NFI8htramCDSLbV+i9t5ec7SuPZqf9scyLqbQP2mdu+ydr1MEr5Tr8yxsvfARfRXGTzUfj04KsgHnIPkvvdA1OnjW2e7oO92C/6LJM9RdcE6weLC7NoReYaR2DFMV79Z+wW+6BDTwvhDDY4atYmLS8l1h2gXyBtYWztoQvQzHCtyDPCT34f3mjFcTLGEaP8PnqWEh1nzrVfYo2pYa11rccGtrJ0/FkQoOEEyqmVFFVJayHYKBtpoEW+yrllDNUgnlOBrCjEtHU8AgsgPUelFcogbxb6q9NPBXg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nutanix.com;
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by CO1PR02MB8619.namprd02.prod.outlook.com (2603:10b6:303:15e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.19; Fri, 2 Oct
 2026 10:57:38 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%4]) with mapi id 15.21.0451.022; Fri, 2 Oct 2026
 10:57:37 +0000
Message-ID: <1362570a-8bb8-4303-88aa-418eb55b9ef9@nutanix.com>
Date: Fri, 2 Oct 2026 11:57:33 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [qemu-web PATCH] contribute: define clear limits on bug report
 volume
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>
References: <20260924135634.2626603-1-berrange@redhat.com>
Content-Language: en-US
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
In-Reply-To: <20260924135634.2626603-1-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0179.namprd03.prod.outlook.com
 (2603:10b6:a03:338::34) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|CO1PR02MB8619:EE_
X-MS-Office365-Filtering-Correlation-Id: 20a73a7d-8771-49a1-e464-08df2073f8b7
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|10067099003|56012099006|3023799007|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: vmu9GF2CQcuISYXjXvAbNspZMGo7lY06kRHLjZoETwwUElkf60T7z8jMSpR38ZIh2t9v6vjG1+2wPTNLICpoE+xw2SIHgVUVw0+0hkLUFoAD/f2wQSBouFkZGsDrS0aRA+3ZRuqstdJ3kYMw9HFcYHS1H1yPmmHeDZ95AQsZwEgSrbWL7i18YNxxt2Zeps7F82/lvIbFDwOM+tbL6WMYCGKepiAyT4D9DUDzixTrgUEnDklWpbg0sGjZtu7OtdVjDv0Mz+E2U+52ONe7PYRx3/unCvFtqITirclOD+z+dC7OruKkLmVIqF7pCqVSwctyDe41iCn8lBHqsvPBe0r7CHkZmZbauwlOLtZYVns7xwCwos7QtscIu3mjr302PVo9iXybWojaVgA5cVxjXppNzrBXn47PBwX3lKUF0WV8iOWJDEZov1lW0BTWJMSgsOcJ97szFXka07w7p0taG4PZGzyt9TA0+Oj8kcOEOlug03lEx6QIEMDbKS207hhxAR9yf9ODIT69pcuspPn6KhzzBMSDMsP92mo8KkaUv4o52M6BhdI53DV0U1PZqJX4waFsh426rFWZTdWraIlviz5270nOjhKl6S1bcZWTHc37EWR+FhuWUxtgkGJfEXlGjsaOeoLQeIpPQ7Z0w0IjPxxLTQbJRlTfCquNsCobDizWgwY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(10067099003)(56012099006)(3023799007)(6133799003)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K2pKeGRyQlBqeTlvc1Jyc0JtUXVJVll5RkNUYXB3U00rL1ZGeWFZYzlaSUIw?=
 =?utf-8?B?UWJsUGtXaS9lR0ZxQnhkS2FVdHJPWU1MTk1KWDVmWHhFTFgyVW12VURNOU1r?=
 =?utf-8?B?OWtqMDg5SDd2UDZQY0picDlCemgyeStLdzNjSkIzMmx1QytsQWNhTTh4MmtY?=
 =?utf-8?B?UDl0NDJsdTRwcmgrN2R4clEvd1I1NGpFaWt5UHlrSEVJaDdKWVNYRFFzL0Z4?=
 =?utf-8?B?VC9RbERuMjhPNTV2RWpWTXRRZFVlVlBQOWVFTWhGQWFCaEd1dWg5QU15S3JI?=
 =?utf-8?B?TWlUanNYTE1vOHBRV2Y0cEFzbUdWRDR5M2VpWnZla1Y0clNhWWdkSXI1a05y?=
 =?utf-8?B?eW0rQXQrSHROVzhqSmhNWE53ZVBkWXB1YVdRL1pGc2pwK2R1VDlJWU1STU9o?=
 =?utf-8?B?LzJYMzVPRXpUVDFZUXdrRXFERE5qOXp0Zmtyc3UvRFdLc1cyaEo5VjNFNkp6?=
 =?utf-8?B?WU90MVEyckZuR0R3VmRmY3RsK1VYWWx4UE1nVXpTM2t1Q2xpQjJmUHhXZXpT?=
 =?utf-8?B?QS81REdSdGhaWG5ZQ3VLUUFlZU5VbnNrMW42cFk3aS91dnRjTTR2dDZpdHVQ?=
 =?utf-8?B?ZTB0NDlYRVcwUlBGcVRNWEMyeHlGWCtjRmlieXRBaWx1MDd4RHpUenJ4UndJ?=
 =?utf-8?B?ZVovWUlMaS9ON1YwMGhNcGlUWWhsMnZMNlVPd1JOZGhpZkZudGE2ZGtFSUhU?=
 =?utf-8?B?T0ZVL1NzTGwrUmpnSUVLMnNpczQ4cFcwVkkzNUdGYXpiS2J1QU9XbHBxTTI1?=
 =?utf-8?B?Y09wTTVGTDBCcnQ2S3J0L1Zxdncwd3h3QkgxU3BMK0V4ZVNUcmRDN1RhTzMz?=
 =?utf-8?B?M2NtOGhuRXp6OVhLUmZhbXlRQnltVnQvUm4xTHI4YUxwcmE3eEh2Z0tXV3ZO?=
 =?utf-8?B?ZWtPZCtxVFFiWEtnZWFUUWdrL3JsV01OdEhEaU50UHkzV0wwQUVCSTVMdmVG?=
 =?utf-8?B?VEZselZMUXRCeFY2VFBjb25wdzZEMms3Nzhtb2J4UW9xazN6clF6bkVUODh6?=
 =?utf-8?B?ck4wNVg3SU8rKzhpWVRvdnBqRHBLQVpBMEF2MEloZGxOZlc5bWh5WjIvSEJu?=
 =?utf-8?B?WTNJNTVqa2Noa3BEUTFHUHh2dEpwNFdEcFMzZ0ZHUXBseXJEWTZOM1NQN0Zt?=
 =?utf-8?B?OWYvY2lWbjlUZ1BHckc4aWhLL09xeHRiRU1WODkyQ1BESTBVd0czUUJXS1JP?=
 =?utf-8?B?aklSd1M5bGJLRDNUMkhFdUZ1SVNVbnpINk53Z0pYU0d3Y3R1MmhNUHNvUjlT?=
 =?utf-8?B?eDY0Nk9yVk1yQjdzM0Y2NU5zQzdKWU9IRnB4cThxb25hSytrNjJWVHE0bDdW?=
 =?utf-8?B?L2N0TFNrbHlxK1F5SHUwQUk1aDEyTDV1a1BkWG93eG82ZXVuWlhMdmc2RlpR?=
 =?utf-8?B?bXlrKzJMZUZXbWdEN1JrL3lXTkUwMEtHVnhTbkcrYWpIMktML0JkNjNGVUdV?=
 =?utf-8?B?SU1FWjFOekVaT0pyN0tReWRTSjJSNkcwMmZkOFVUd01mSjBBSjJEeWh1d2tF?=
 =?utf-8?B?cTk2QnY3T2o4YnRmcDdwYzYxckc0ZGxYaGxRMEdlSHMxWFd0U1Q5aXd6MWRt?=
 =?utf-8?B?Uk1NcjdhQnNmeHovK0NiTXVGeHE5MnJtS0NzYXUyUmZISWdzbko3WDc2eXJ3?=
 =?utf-8?B?d3pkNHFHWFZQbkFRWnVqRVNUWGkzbFI5QzFCRTFlajRVRTBzWmQzODI3NU00?=
 =?utf-8?B?Tk41M1lpZS9oUlFydmtSaXJ0ZDF5R2hrUXVWODBxUHZVamxITzRLdEtjMUF3?=
 =?utf-8?B?Nmk3UURCczFjcFBuSStUemhDT1kzOVZreFptcDM0ZnZpL0huN1dITUplUmQx?=
 =?utf-8?B?M3RReFVtT014OXZTVDdsU1liTzFQd0xwSkxaZWdERFdZVUZuN3Q4OE1mdlIr?=
 =?utf-8?B?cGh5dWRlc1FjbktqQTByanNuZ1RobGd2VklxVjNLQUt2NERwZWpjbU1HMngr?=
 =?utf-8?B?RGRac2ZzTDJVL0tDQ2hmOEpKT2UxaUV4NjFOUzlDczdaVHBzMFp5anN3MTQ3?=
 =?utf-8?B?SmZxMkd1WHkyNFJyaXhGU3dRYnVxYWJKT3NJK2c4c3dWTzVLMThkeHVCaXFV?=
 =?utf-8?B?WEZVVC9nOEt1ejV4STEwd3BNWUM5TDYvR1NDcnNXOTRtdmRtNVhiRFNWemZI?=
 =?utf-8?B?QVczazNHT3lEcUNNcFNtcFgvSW1hL0ZaZ0VqUW9tOXdnVWRoUWxtaEVOUCtw?=
 =?utf-8?B?d1JEb2Ewckh2aWFuT3VYTkdwMU9wR1ZrSXcrbVgwK2twS0xJd0NlV25Fc3hw?=
 =?utf-8?B?UThSRGFwdDUyN093TGptN1FZSWR5MzJIc2s0WXdJNFJ1WXFjbVAxR1pQcURN?=
 =?utf-8?B?a2NQUEc4MmpDV1htSFdndXF0dEdtMGJSalVVbWpqM05hUUtaV21uN1ptazRF?=
 =?utf-8?Q?X2BoT5Hc70sIF9bk=3D?=
X-Exchange-RoutingPolicyChecked: IEXak5nVJsJNp1IfAUQdmAoz3Stls60zknQvgOQvwWfUmfImhm1qZT5gD0G1mQYda11yQXv/ViDyspjhfqAITxJf5eaTefHClZNuf3qaMkBMw/CHpEdbNwUlz26ccqqfWAZ4D44tpRK4/uvncy4yynUMFbsFimnU4+2z5WGxILIqASydFhAtzS1XeLM8BmPMmN0cSNEJeAVmWjXQt9ZVl+IhXctQEZ7D4Fea3t5KNU0UzQDbJmiJJdKhAybxJI8qZQo1Wb7EFh3IAPLDCNplRfA11MFAZG7lyQYMkm/ABWZF4m72sBoOhfe1kgnVxK6WtWHCaY83phobMjLTdLxD0Q==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20a73a7d-8771-49a1-e464-08df2073f8b7
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2026 10:57:37.7312 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IZkicjOR0bp4qGRA6PiN/YoE5yo/g9qg2iu1tU0k4oWJ4pB3Ot5S4EcV1dOzbVhwIzY/7mOR7KFYVjbXdeKbm2r6LTadWH6VmmzoEjmMPto=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR02MB8619
X-Authority-Analysis: v=2.4 cv=H79OUOYi c=1 sm=1 tr=0 ts=6abf8e24 cx=c_pps
 a=GGp2JTg3dHMzCsOndft0Og==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=y4UcunY2MAxhM4LwGdWI:22
 a=20KFwNOVAAAA:8 a=O2JdbfVyIM2GQ6d8Yv4A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: GMOSCFo08omRN86nDZqU7_xZybs1AV1q
X-Proofpoint-ORIG-GUID: GMOSCFo08omRN86nDZqU7_xZybs1AV1q
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAyMDA0MyBTYWx0ZWRfX3IeEBCqOZjTf
 SxTiHYANJiZFEHty9dS8YkGVa9Zfoq8DNkTQU4zjf6lvEtXtb4cHi5rtUmc0JikfYQnyAl3xMCg
 OQw2oJv772QEX2hosREsiinrc0VAxikx6QGgprfyPkLhSPy5eE8PJo0mAXgt9A2bqohs0PiM/6/
 Dp7qVVwGqgLGiYSnt/ucZQxPauFRj5nzE7o2Zwd4DLF/Ef7NMTXVg4jOEYDt4g8GgfM2KOhiq13
 I+X4RUROIAXOCEzdjFT31GLCKd203j5AKUzQQ4Ou6daRR0Hs4igstdbIj/a15F0AsjgL2T+2y7t
 vzp9ZSWj1S6J0gMjIhjg68EDQSEbq6Y3r0sCgSs9/ldIDTDa7uPwKxEH6EwjdGMqVXVYV2kAk6Q
 ZYG0U9DhM21Jtm613Qx1b04h2MPzbolbJT3z38o84BVrd5fX2tO+paSbqE3DCA69jtMrxGYia77
 Qk/c1slLFyiRP2vIdcg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAyMDA0MyBTYWx0ZWRfXzK/zEF5UBotD
 mRIhg2isbcPPpvNcp5BdGshLWhD1seSwgk8im976mMwsHhQKgjymm1+wo/hDYG27eMu4hZX822T
 SCRdM//5Cw3kP/bH+IRVFQpXeWsZssM=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-02_03,2026-10-01_01,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.336,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
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

On 24/09/2026 14:56, Daniel P. Berrangé wrote:

> Recently QEMU has received a denial of service attack on
> its bug tracker in the form of 120 reports in 10 minutes,
> and now repeated by another reporter in the form of 50
> reports in the same day.
> 
> Prior to switching security disclosures to the bug tracker,
> single reporters have submited 18, 22, and 114 bug reports.

submitted

> None of this is sustainable. It is an effective denial of
> service attack on the project maintainers' time. Every bug
> report is a TODO item added to someone's workload.
> 
> It is time to put hard limits on how many bugs, discovered
> with assitance of automated tools, we are willing to accept

assistance

> in a givenm time frame.

given

> This patch proposal suggests
> 
>   * No more than 5 bugs per week, per reporter
>   * No more than 10 bugs are permitted to be open at any
>     time, per reporter.
> 
> This is explicitly scoped to bugs discovered with the assistance
> of automated tools. Bugs where a human puts in exclusively
> personal time / effort to discover a problem are not limited.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   contribute/report-a-bug.md | 37 +++++++++++++++++++++++++++++++++++++
>   1 file changed, 37 insertions(+)
> 
> diff --git a/contribute/report-a-bug.md b/contribute/report-a-bug.md
> index b506f9f..8fb7b0b 100644
> --- a/contribute/report-a-bug.md
> +++ b/contribute/report-a-bug.md
> @@ -32,6 +32,43 @@ on GitLab, taking into account the following guidance.
>     triage of their output to validate all findings and reproducer
>     scenarios prior to submitting a bug report.
>   
> +* QEMU policy forbids the bulk filing of large numbers of
> +  bug disclosures that were generated with automated tools
> +  (AI/LLM, static analysis, fuzers). Such actions are not
> +  a benefit to the project, placing an unsustainable burden
> +  on maintainers.
> +
> +  * **No more than 5 bug/security reports, discovered
> +    with assistance of automated tools, are permitted
> +    to be filed per week, per reporter.**
> +  * **No more than 10 bug/security reports, discovered
> +    with assistance of automated tools are permitted
> +    to be open at any time, per reporter.**
> +  * Reporters must refrain from filing any reports
> +    that would cause these thresholds to be exceeded
> +    without first obtaining explicit prior permission
> +    from project maintainers.
> +  * Reporters are **required** to respond to triage
> +    comments from maintainers on bugs related to
> +    automated tools on a timely basis.
> +  * If at any time, the project maintainers request
> +    the reporter to stop filing bug reports discovered
> +    with assistance of automated tools, this must be
> +    honoured.
> +
> +  Ignoring any of the above rules may lead to the bugs being
> +  mass closed without further triage, even if valid reports.
> +  In cases where the filing limits are grossly exceeded,
> +  the reporter's GitLab account may be reported for abuse
> +  (spam), potentially leading to termination.

Do we know if people are doing this purely for the recognition? Perhaps 
we could suggest that if these rules are broken, all bug reports 
submitted by the reporter will remain private (to reporters) on GitLab: 
if a maintainer decides to fix a reported bug at their discretion, the 
original reporter will not be credited in the commit message.

> +  If intending to file large numbers of bug disclosures
> +  in aggregate, reporters are expected to invest their
> +  time in writing patches, providing the patches for
> +  review, and then further responding to feedback and
> +  iterating on the patches until a maintainer accepts
> +  them for it.
> +
>   * Reproduce the problem directly with a QEMU command-line. Avoid
>     frontends and management stacks, to ensure that the bug is in
>     QEMU itself and not in a frontend and make it easier for


ATB,

Mark.


