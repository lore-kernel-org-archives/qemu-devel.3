Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF859C6FD1F
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Mar 2024 20:30:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rn2Yt-0001jD-Ss; Wed, 20 Mar 2024 16:29:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <si-wei.liu@oracle.com>)
 id 1rn2Ys-0001it-9I
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 16:29:22 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <si-wei.liu@oracle.com>)
 id 1rn2Yn-0000KS-M1
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 16:29:22 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 42KITGML017542; Wed, 20 Mar 2024 20:29:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=1m7s1zop3dUCmMPdTaF18ottfurFZ2gZI6PN+xNyRg4=;
 b=gnYIFbj5Y3/MB7rdwd1+KvNcm8+HRK0HlB/2IGYkpFrDgkKrcFUqQTq9+EXPrhvlOqTi
 rPS8wk3QaxwZ6MeZt5h3BKHoxSfkBOi0AmAcjZ3T2VpoiFD62PHrX5zYF6zRUv/XzjyY
 W00qwARkNAuV/bonLQdnDiF5q7dzD01qw70n0ZrU2KwRfwSCKxBRcxn56B+jNvioGXz/
 IGQo/OXpa2zmlVJxNXFkP6SXoNcHUNQ0hXYeTP7h+QyAORZHb0OrswfIN8x2rnsJ4iEb
 olDKIbZIZ0J3rdafJLZj3xp+L2fZQsRZ54wHkd5ofU1QvGVo6ppGfYC1Dk1ja8T5Cxpc eA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ww3yu8yv8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 20 Mar 2024 20:29:14 +0000
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 42KIdb2k021858; Wed, 20 Mar 2024 20:29:13 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3ww1v89fwt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 20 Mar 2024 20:29:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OnEPoY2WnLO+Ne/AXSNqYxRIt+tWFsGD0gMd0kLeGJ3XcuqmXocQvvEqW80kxQGHZcqOxkoMfQxxLEdkfE9KITd7H9LsLqeO81VWUe3M7xXFhBA0Y7r2HdRB8jdLxKQyFNEncnws6gSsYqqGe6yV2M48ElWDLWLa7f7AOXvJBMCSRL8E9aO3DdIkqhc70xtQVvZbnV4lykQzj28wNgbonkQyUOhb5i51p+hmCWDBzqjI7x+oQeY7qAJ1jp2OOC2q1eeR5h4IWSm20l/q2OgrxgeRfhPMLbT/m13maJZQS+zAdWS1WTTy3Tozo7H+UQTIgwAHkbKZn9VDrwcd6fh2QA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1m7s1zop3dUCmMPdTaF18ottfurFZ2gZI6PN+xNyRg4=;
 b=Yyf1I7LBX7kbdOQP5D12Il6NarPni9HuDvagUowOgAcr987RDW7pFahAJqAzfEQHL0iV2m9ruTbuVXH0yCtkCbDIvE7W5Vk+28UV4QfKJNC8zl2MxoL5v5qyHC1I3tUo8hPamtyGxduwMy6thmVOzXGsKFwebUT7S9wXM8Gm4ZyLmfEEg5STKAtMFbVaN820Vhx/mYnTwzvraZWVdzCzzZ0uy3vcZwQmRfpbcvVulrnoi2kH511P9kGfykrWHbVbtRDTv+b5GYHhtx0fmVMef1jvDT/m/GJo3TPSDgAhx4icE4mzwD94yeNWyaArwJEuiuqdiQsj0bhBZ0ZqX//i8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1m7s1zop3dUCmMPdTaF18ottfurFZ2gZI6PN+xNyRg4=;
 b=kQfO44SXIeCCyNSoNv3wz6kT5G+msbPgzUlRLa7nN6RxD6VM4zRII1jJxF6wvZhaFK/ZJjS4Zznk0xfBOBP9e3+h5IfqJAU2Rq/XJCFI/QCctPCntHe7gslkUyC5SxCEyqA+cibMh5DimyQByr+LJk7OXuPq5aN70vBUrxIUMsk=
Received: from MW4PR10MB6535.namprd10.prod.outlook.com (2603:10b6:303:225::12)
 by IA1PR10MB7387.namprd10.prod.outlook.com (2603:10b6:208:42d::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.27; Wed, 20 Mar
 2024 20:29:10 +0000
Received: from MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::bf6e:420b:90be:3cff]) by MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::bf6e:420b:90be:3cff%4]) with mapi id 15.20.7386.031; Wed, 20 Mar 2024
 20:29:10 +0000
Message-ID: <318cef20-96a6-4476-a8f5-1653b1465a69@oracle.com>
Date: Wed, 20 Mar 2024 13:29:08 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/2] vhost: dirty log should be per backend type
Content-Language: en-US
To: Jason Wang <jasowang@redhat.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com, eperezma@redhat.com,
 joao.m.martins@oracle.com
References: <1710448055-11709-1-git-send-email-si-wei.liu@oracle.com>
 <CACGkMEt2-naXvHjCcPyQAoSfto44OVaSUqPtg_gvS8-wrhNwZA@mail.gmail.com>
 <9cb9fe47-f173-4cf1-8bc0-01971e47559c@oracle.com>
 <CACGkMEvjB45RzonvWMQ=OnDpm5M04u6ab6tT7b0=sMsEyBB-Vg@mail.gmail.com>
 <7c118fa7-2288-45f1-aa67-5bf650d65b51@oracle.com>
 <CACGkMEsHY+1752e0tt58uQevUkoAcSRgZRNoMPPYgXZ5SEkWMw@mail.gmail.com>
From: Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <CACGkMEsHY+1752e0tt58uQevUkoAcSRgZRNoMPPYgXZ5SEkWMw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR05CA0091.namprd05.prod.outlook.com
 (2603:10b6:a03:e0::32) To MW4PR10MB6535.namprd10.prod.outlook.com
 (2603:10b6:303:225::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR10MB6535:EE_|IA1PR10MB7387:EE_
X-MS-Office365-Filtering-Correlation-Id: 245e22ef-48f2-421a-2088-08dc491c6609
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YAYQkw2s/gOpMesqULKgQadtRc/U6NQgGqfTn2mrL2iBDtogLxV3dFf0bDkUMY7Un4mSo4qEqp+03T5cJcHO4INV0Rk41Ppa5XscYoN8bmXcCUYoQrMrbuRo4q8L4xLeyhkdp1FkD4OlcQtfcF32vkY/hNJx7Sjsm6hPFhrocTslHhiv//3a93uloP30l72yowliWVmt3x28U8bmxwIpm4ea/fJ8HdoTX7BBF39PNQPq17mtq3oz5cUIIAhaJDvVLMmyIedI+fW5A+GCI65YkUap7SodrngxRSRVXVnGr7V2wLl9q+NgzdbCPxnsWmtRa4agCNlRp/Rg2xyxZ9LlMAL9CwS94FjyK1uMk7iFpys+lvbrGHlmyO1j0OqDVQK8jkyLSuq+NaVb8Z6hz/17xbjCX3opQNv/dkB+P2KnLwhXr0a2xkUQpwO1DaIantAGRWWKKRujIcAGnQReWFHL83w+GCwZfswwIz2/bVLpBsmQbv2DDMRCms097YZG69gdn5G8x0TKnnD9Rqu9C+ztArqRJHwuLxT1BhL6cmAFaA267n/CXMqH0OglHQq34wW+BVGM++NeD8sMuV87rXfkkN8MJiGv9cl8uq8uefoqarGoSWXAPiw9qryhH3TxppgW6B69HsbLUgdeZ2LaLush2YRigKTB04KMYxM/drMHmIg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR10MB6535.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(366007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SnFLVG5reGpJRzIxVmE1YU1LY1lFdnc3WmJlODJYMndQOStuNnJ6cGd3UnV5?=
 =?utf-8?B?dU40R0pWV25RYXFzV01pdWU1UDBmODhaUXh4UkptYStJb1diSUNUZXB3L2Rx?=
 =?utf-8?B?UFNWR05rQjFGcUpMQ0JxVUc0OHlsS2Q2VC85T3krVXdkN0dITmJSaVVWd2k3?=
 =?utf-8?B?K0NmcGZIdmgrSUxHRXZSVmY2bGQ0cGxjN3lzSDNKT0w3MXMvVmROMjVPYUVs?=
 =?utf-8?B?clpib2JIWitNbFZ6VGdtcGpyWENlOWJFRUNPTThPbld1N3k0THcvNFZ5RlZS?=
 =?utf-8?B?S3lpRHBaalZWNmsyMGYybVZySnJqcVlpUkIrc2dnZk5qUEc4MHRZNzZKREdJ?=
 =?utf-8?B?NEljUkFQQUFXZ2F0MDkrbXNjcWw3RlRabVkrWG9tU1BZVlp6RitudksxU1M1?=
 =?utf-8?B?NDN4Vi92ZUVkNjRJYWs4Y001VG5idmVYeUgvMnZocmdTUVRlWmE0am02VUor?=
 =?utf-8?B?YkR0RXgrdTduM1FFWm5sZW1FRU1kZ2l0VWxTR2xTN3A1V3BxUjV6NWx3bGZq?=
 =?utf-8?B?Wlo1dVNPNjB3NzFzRjduejdpMFkyUFJMRENzUGVCdDBqME05RVdQdmluU2pm?=
 =?utf-8?B?bTYrTW5jTkNYK290TUZiemtBeGVFZWhlNUd5a0twR3MyMHNvdGV6b0dHK2pV?=
 =?utf-8?B?QlFwWnhMdmZqa0p1UWcyREFNSkkvQWlVTWdCckJINVk3ZnNqa3lDNDlFVmQ0?=
 =?utf-8?B?QlRacHY4dlRiaWhBU216dm5hdGhIeE9HY3FkSzZCK0RrQmFrRWxCWlc4VGNI?=
 =?utf-8?B?VUFBY2VPdUdxV1BacENOVW9pZUp6WlFWbXFzOGhUYTdJTDdGaUVOaU4rcmF3?=
 =?utf-8?B?VHI3bkRYR29WRXVGWSs4c2tVRlF0OSs3VDMyOUF2bUhDZmpyVmNMY3Fqam9o?=
 =?utf-8?B?R3JmUVNHNnY3SnlHSHRIclhRNk9CdVRET3lhOEd2ZUhjbFZTVGhkS3g4cGZV?=
 =?utf-8?B?T1BCSjV1L2tENVYxdnlocnZWSVhxZ2xORWdna0UyRHQ2SmFJRUZmS3ltOVdC?=
 =?utf-8?B?SlY4NEtNZVgvRXgyWkdZeDNQdmhmRmFsdzVQTCtOczg1MlFmYWRPV0pjVFQ2?=
 =?utf-8?B?aFk1cHptMGN4NWVJWWh4STZyOHBPRzlnTHdLZ2pYaUk5N2tnUE1BR2RMcWlB?=
 =?utf-8?B?c2hOamxVWEc2SjFDT0JXak05N1BMbzZ4Qlc2WEQ1NWJ0UldnZ1BJbG94cDM1?=
 =?utf-8?B?RzIyTklJelZ2ZGdUMlhLQy9HMmdNMXRtZUJrNEtzeVU2VDJBNmI2UGlsSW1T?=
 =?utf-8?B?WTV5NVZRRmhVb00wenpPUEZxNnIvTzNQS0VwSVBUcXI0SXFvZVV4bU9NaDFF?=
 =?utf-8?B?b3BpZC9hWVJnbmVMME5Kb1ZzOVZoTTZXUEIzZFV0c3JMZUxybXhkZDUva25n?=
 =?utf-8?B?NWdwQVc2d2oxa3duTmF0dFhCcUZaNFJHcllxWitNNDJNS1pyMUFtZzQvVEs0?=
 =?utf-8?B?WGhSSEp6TDlkMnJpd2k2c3RMajBkRUIvSGhyMTFlQUdwR3YvVDlpRGRhNXV3?=
 =?utf-8?B?QXNnTlVLMmJpLzNaT1h0R2xFZ1c1YnhpWUd5Tm83QkJMZ0lTb1IxVkVtWWNF?=
 =?utf-8?B?VThxemJXeHJuaGJpTXk1Z1RUZnc1WWM0Z3ZjeW9oeFo1Vk5ucWlIUW9nRzRC?=
 =?utf-8?B?VUpreFhIRkI3Ung1RHdNS25GenJhaklOSTl3ZUYwSFE1RTJzUGVzZVVadVRk?=
 =?utf-8?B?NWdxWUFzdEJQc3BXQkpXbHd3TWdOUWx3UnhpVEltNW1uVldMU2U2MTVPRTFm?=
 =?utf-8?B?OWl5clNOWDVlb28xVWNZczlzeFNBam85K3NLcHpQSVNQWHpzRUVZMkY0VHAw?=
 =?utf-8?B?OEM5YjAzN2RFTGY5dzN2SmkxRk54WVdCMnZnOStBRFZsbVllNXRUZGVRdnEy?=
 =?utf-8?B?QTYxUERuM3kyVTJTQk1FWTlLV2VRN2hINTRwSGoxZ09FdG84M09XNlI0NTZB?=
 =?utf-8?B?bURadW1VT3JUMU5HNDVOcnorYnJSNXNxY29zaWFwUzE4Mm02TVFMUUhnMkR0?=
 =?utf-8?B?RnhrMHJzb0NneXg0NG1xR2hVTVZxNnF4b25zSG9WbDBmbnNzUWxmYUYxTDFM?=
 =?utf-8?B?UHMvU3VMdWR0RGNMTjk0QlVmSXFpYTAvOWEyV0hOK093NFZWVkJGQitkMzhO?=
 =?utf-8?Q?xJVuZ+B1hP5NKVleo4HqJrJjO?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: b0ZSR/dQAGpreJVEyIHMwWGfflnNUWAyvbKpXlJ/l+14/9VWEDl/6ARGLJqrhQMf60NoXC4av3AwKYnltMeUQPWSZJ9dyEYyKRuWWsMGYl+7JyZTDp9VaNtWUG4zEYenlU2iXcCRoApadSa9t4zMTaEumvzyT/jL19ZQkaYF0mP5hUAHdQrpdJRXSYnnVmy4hu/wpmziJ5onRboZFVEnEDKt5EmA/vSL8B4x5FSmo/cZ9ZFooHqCdNu++igJLIPYPzD3+7h/EHkYKGxxvuIYMymSGKL2bZFmpEj0bTlhVdMqIopXKt6/WvL6ud7+AhjxfW7DGgDT6n+ef3RQKQ3NCG8xfTuHkrdWw9IlA/SJ8v6BPUP/keDW4rzl0pgz1WWjzOQPE0h8tJahCBCZDRfYy6C+Oxi2CvAXUae7iFof6PMEVG16vPerB/cDqcmGc3tuk5/s0xVGpOnU6sOH7Sr0c8/9rjh3yoDoAB/BMop3u9o+6SXiVT5X4g7bGXcxZScaYFC+bedHReWmRMgeb0CMmy1WrNGA6YSTvxbKI2P+Tuk3z50qJN2+MfTrKK5IB3GIwyq/1/kE/LqbWmeSqaqyyPE24vdXUN3xPpvrRg54FOI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 245e22ef-48f2-421a-2088-08dc491c6609
X-MS-Exchange-CrossTenant-AuthSource: MW4PR10MB6535.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2024 20:29:10.0770 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: buR80c58HMcx4oAPVII+PwsB5ySMCI1XKjabsb9vYVIKJ10VDOoI4GjMbVtQAbCxdEm6SjC8ndtmdmeuB5NEAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7387
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-20_10,2024-03-18_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 adultscore=0 mlxscore=0
 bulkscore=0 mlxlogscore=999 suspectscore=0 phishscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2403140000
 definitions=main-2403200163
X-Proofpoint-GUID: G5SNtrPNh0yPu3J7g1Q8zSsV_ILDvx2n
X-Proofpoint-ORIG-GUID: G5SNtrPNh0yPu3J7g1Q8zSsV_ILDvx2n
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=si-wei.liu@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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



On 3/19/2024 8:25 PM, Jason Wang wrote:
> On Tue, Mar 19, 2024 at 6:06 AM Si-Wei Liu <si-wei.liu@oracle.com> wrote:
>>
>>
>> On 3/17/2024 8:20 PM, Jason Wang wrote:
>>> On Sat, Mar 16, 2024 at 2:33 AM Si-Wei Liu <si-wei.liu@oracle.com> wrote:
>>>>
>>>> On 3/14/2024 8:50 PM, Jason Wang wrote:
>>>>> On Fri, Mar 15, 2024 at 5:39 AM Si-Wei Liu <si-wei.liu@oracle.com> wrote:
>>>>>> There could be a mix of both vhost-user and vhost-kernel clients
>>>>>> in the same QEMU process, where separate vhost loggers for the
>>>>>> specific vhost type have to be used. Make the vhost logger per
>>>>>> backend type, and have them properly reference counted.
>>>>> It's better to describe what's the advantage of doing this.
>>>> Yes, I can add that to the log. Although it's a niche use case, it was
>>>> actually a long standing limitation / bug that vhost-user and
>>>> vhost-kernel loggers can't co-exist per QEMU process, but today it's
>>>> just silent failure that may be ended up with. This bug fix removes that
>>>> implicit limitation in the code.
>>> Ok.
>>>
>>>>>> Suggested-by: Michael S. Tsirkin <mst@redhat.com>
>>>>>> Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>
>>>>>>
>>>>>> ---
>>>>>> v3->v4:
>>>>>>      - remove checking NULL return value from vhost_log_get
>>>>>>
>>>>>> v2->v3:
>>>>>>      - remove non-effective assertion that never be reached
>>>>>>      - do not return NULL from vhost_log_get()
>>>>>>      - add neccessary assertions to vhost_log_get()
>>>>>> ---
>>>>>>     hw/virtio/vhost.c | 45 +++++++++++++++++++++++++++++++++------------
>>>>>>     1 file changed, 33 insertions(+), 12 deletions(-)
>>>>>>
>>>>>> diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
>>>>>> index 2c9ac79..612f4db 100644
>>>>>> --- a/hw/virtio/vhost.c
>>>>>> +++ b/hw/virtio/vhost.c
>>>>>> @@ -43,8 +43,8 @@
>>>>>>         do { } while (0)
>>>>>>     #endif
>>>>>>
>>>>>> -static struct vhost_log *vhost_log;
>>>>>> -static struct vhost_log *vhost_log_shm;
>>>>>> +static struct vhost_log *vhost_log[VHOST_BACKEND_TYPE_MAX];
>>>>>> +static struct vhost_log *vhost_log_shm[VHOST_BACKEND_TYPE_MAX];
>>>>>>
>>>>>>     /* Memslots used by backends that support private memslots (without an fd). */
>>>>>>     static unsigned int used_memslots;
>>>>>> @@ -287,6 +287,10 @@ static int vhost_set_backend_type(struct vhost_dev *dev,
>>>>>>             r = -1;
>>>>>>         }
>>>>>>
>>>>>> +    if (r == 0) {
>>>>>> +        assert(dev->vhost_ops->backend_type == backend_type);
>>>>>> +    }
>>>>>> +
>>>>> Under which condition could we hit this?
>>>> Just in case some other function inadvertently corrupted this earlier,
>>>> we have to capture discrepancy in the first place... On the other hand,
>>>> it will be helpful for other vhost backend writers to diagnose day-one
>>>> bug in the code. I feel just code comment here will not be
>>>> sufficient/helpful.
>>> See below.
>>>
>>>>>     It seems not good to assert a local logic.
>>>> It seems to me quite a few local asserts are in the same file already,
>>>> vhost_save_backend_state,
>>> For example it has assert for
>>>
>>> assert(!dev->started);
>>>
>>> which is not the logic of the function itself but require
>>> vhost_dev_start() not to be called before.
>>>
>>> But it looks like this patch you assert the code just a few lines
>>> above the assert itself?
>> Yes, that was the intent - for e.g. xxx_ops may contain corrupted
>> xxx_ops.backend_type already before coming to this
>> vhost_set_backend_type() function. And we may capture this corrupted
>> state by asserting the expected xxx_ops.backend_type (to be consistent
>> with the backend_type passed in),
> This can happen for all variables. Not sure why backend_ops is special.
The assert is just checking the backend_type field only. The other op 
fields in backend_ops have similar assert within the op function itself 
also. For e.g. vhost_user_requires_shm_log() and a lot of other 
vhost_user ops have the following:

     assert(dev->vhost_ops->backend_type == VHOST_BACKEND_TYPE_USER);

vhost_vdpa_vq_get_addr() and a lot of other vhost_vdpa ops have:

     assert(dev->vhost_ops->backend_type == VHOST_BACKEND_TYPE_VDPA);

vhost_kernel ops has similar assertions as well.

The reason why it has to be checked against here is now the callers of 
vhost_log_get(), would pass in dev->vhost_ops->backend_type to the API, 
which are unable to verify the validity of the backend_type by 
themselves. The vhost_log_get() has necessary asserts to make bound 
check for the vhost_log[] or vhost_log_shm[] array, but specific assert 
against the exact backend type in vhost_set_backend_type() will further 
harden the implementation in vhost_log_get() and other backend ops.

>
>> which needs be done in the first place
>> when this discrepancy is detected. In practice I think there should be
>> no harm to add this assert, but this will add warranted guarantee to the
>> current code.
> For example, such corruption can happen after the assert() so a TOCTOU issue.
Sure, it's best effort only. As pointed out earlier, I think together 
with this, there are other similar asserts already in various backend 
ops, which could be helpful to nail down the earliest point or a 
specific range where things may go wrong in the first place.

Thanks,
-Siwei

>
> Thanks
>
>> Regards,
>> -Siwei
>>
>>> dev->vhost_ops = &xxx_ops;
>>>
>>> ...
>>>
>>> assert(dev->vhost_ops->backend_type == backend_type)
>>>
>>> ?
>>>
>>> Thanks
>>>
>>>> vhost_load_backend_state,
>>>> vhost_virtqueue_mask, vhost_config_mask, just to name a few. Why local
>>>> assert a problem?
>>>>
>>>> Thanks,
>>>> -Siwei
>>>>
>>>>> Thanks
>>>>>


