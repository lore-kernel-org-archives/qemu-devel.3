Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2889EC3DA5D
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2024 14:25:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUoXK-0001Kd-HL; Fri, 19 Jul 2024 10:24:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1sUoXI-0001K2-GL
 for qemu-devel@nongnu.org; Fri, 19 Jul 2024 10:24:40 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1sUoXF-0006PL-PA
 for qemu-devel@nongnu.org; Fri, 19 Jul 2024 10:24:40 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46JEAeJX013597;
 Fri, 19 Jul 2024 14:24:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
 message-id:date:subject:to:cc:references:from:in-reply-to
 :content-type:content-transfer-encoding:mime-version; s=
 corp-2023-11-20; bh=rY4mm795ehhEjfDLOwXDkgCZYDnlIgOvJFB+qDlxLKo=; b=
 ab0wZmdsAh+pX+rxVM7NLiIaxjsATnaXjmAc4wBOep+hRaVmfPruO6EVBf9JnXBJ
 gj4zIGiw1QbkDuYREWQZ9F0NFz3/kCsbpG0osVwwWcfnLfD08bcvhFGJGJkZERvU
 JnstTvN07cJ4hFoRddGxIh0aeLgN/NprniFRmFOjH8ElsfcOgkNAliDUf2g/MNSE
 dfrqNlZpedFPlT9XQ7PvAIkFrjqHHYCx++wUiJMXUBYr5sojRQdiEZ8Bt2RNvk08
 1yQJvRyMEs4iuUwSLNnDAq4HKDxEanMDTHNCsER3UonuooZirBPvT7Qt/rWrp5+f
 evDIAvEdBEBW01itrNZ7ag==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40fsnwg115-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 19 Jul 2024 14:24:32 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 46JDPQ4Y006859; Fri, 19 Jul 2024 14:24:31 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam04lp2170.outbound.protection.outlook.com [104.47.73.170])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 40dwf1an57-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 19 Jul 2024 14:24:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qv0x+ozkux6MmYg2iUa0sH3LG+U1jY83D9xqLyUgyTENsdHxb4O8IyQwaierkp7zJ3Fo3jpunoowQGTn3VvVO+3uwsjNGO+YPjsObzZXoIc9H+1gwmQs+OsZsarET2t4BzrO8DFO2awAObwAL3aUAd+CXwqjK7d5QUjwiQYHP5RdhCzB7Bt4HSVEBSMcLl8R2Z2adyTl5AhDHqP2FZup/HLb70N/1tM+2i6IULEtrkBmlR+H768gSN9OADuNUyFY/V9pM9BcepZgF26b/XIi4Ii8LQoNmO5CHPgiBVejCc82vr6UwX6eytcXeWg45pA8UvwgQIuG4KKCp3ZjXiY3Vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rY4mm795ehhEjfDLOwXDkgCZYDnlIgOvJFB+qDlxLKo=;
 b=ljmpnLohATl7WNU/Tj/p1uUa2l4nuaR626CmgJH9gIpC+bQ6345Z931vHtIMrhg3V/krFP0jHmSyq6vld3/ckEgzAb8JaOMjVXWlDWwitVAXleJpwAr8DUE18G4EuxZkFm0x30ZPQUlhEy9KmCcwThXMxjkxZ8aSnYfJpqR8l+71zuvHerDSRPFSfSSQmysQeqQYmOihsD8jY12I9KXhmHCoxhU1n5UXGJ/x/QlSXags/CfHGiXBvF6uku8mmONOJ2/M3+AyhUffofItSgxuolGtlBN9tSKVB/FiRyP6u/isy3IhLvl4Fkzu0iaxqFds9ZnyrkYxcBbTIrkvkDJ2DA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rY4mm795ehhEjfDLOwXDkgCZYDnlIgOvJFB+qDlxLKo=;
 b=vV55DLiMRk0xC7hKc4rkhm6tPfUrrn4VLWQmWkkk0AGNpPumHteqzRDelommmYLC6+lmXodizkVMaWdhYf+akqm0twqm3eNA1dX1IfUlNky8bXicJUgKxNqjMABmjZ6YMeHoFwseisuSu3oJitiBmd6yn3LsSZ6L2MJbG6NDgf8=
Received: from PH0PR10MB5893.namprd10.prod.outlook.com (2603:10b6:510:149::11)
 by SJ2PR10MB7039.namprd10.prod.outlook.com (2603:10b6:a03:4c4::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.17; Fri, 19 Jul
 2024 14:24:29 +0000
Received: from PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::79f1:d24f:94ea:2b53]) by PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::79f1:d24f:94ea:2b53%3]) with mapi id 15.20.7762.025; Fri, 19 Jul 2024
 14:24:29 +0000
Message-ID: <f5d64358-70e3-4217-8376-356c8aaac8ea@oracle.com>
Date: Fri, 19 Jul 2024 15:24:18 +0100
Subject: Re: [PATCH v5 12/13] vfio/migration: Don't block migration device
 dirty tracking is unsupported
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
Cc: Yi Liu <yi.l.liu@intel.com>, Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Jason Gunthorpe <jgg@nvidia.com>, Avihai Horon <avihaih@nvidia.com>
References: <20240719120501.81279-1-joao.m.martins@oracle.com>
 <20240719120501.81279-13-joao.m.martins@oracle.com>
 <a8239962-c987-4ca1-b342-95fd8f03179e@redhat.com>
Content-Language: en-US
From: Joao Martins <joao.m.martins@oracle.com>
In-Reply-To: <a8239962-c987-4ca1-b342-95fd8f03179e@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR01CA0148.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:aa::17) To PH0PR10MB5893.namprd10.prod.outlook.com
 (2603:10b6:510:149::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5893:EE_|SJ2PR10MB7039:EE_
X-MS-Office365-Filtering-Correlation-Id: ee2124cc-ea7a-4c2d-3696-08dca7fe7fd4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VGlZNCtrZk44NStzRGYzQjZSZkluaU8vdFBEMG5sTjhnOEhpUGxnY0hySTBT?=
 =?utf-8?B?RzVjSUswanE4N1dIeFRxZHJyWENNSFpTTUdxajFYdWVvSWs3RFp1OFdzVkMx?=
 =?utf-8?B?a3Y4V016QVplT3BtRmtxQzNWNXAyRUVzenp6YU1BR2xLWi9uQURZZHIwNGho?=
 =?utf-8?B?TU5sR2NSU3NwVlpDWUxVeTVoYis5bGtTVXRtNmVQREVsNkxYeGVmUGx0TGRP?=
 =?utf-8?B?alpCR0h2ME1JWGdKV0JRNnN4RHRLWm15cXBiTVFQeUZCVTM3di8wR1FVYTdF?=
 =?utf-8?B?dTBvSkNNcjZ3ZncvRWtHZzM0SDdaajZZWHIyUDVXcFVpNkJwWHBXaU9ncGJX?=
 =?utf-8?B?SzRGYW0xSitzemJZeFkxYWxXRnFpQWI0OTNUaFVhdGl0dDlUWmZVamk3eDRz?=
 =?utf-8?B?d2p4bitlTFY4RGJuMitLak9TOUs4eXc0VEozWUY5dGx0cXdoU3pLZWF1bmNR?=
 =?utf-8?B?UitNcjU2U0hKbnpMbWY2VWZIUDhJaXk0ckpxUEczUW8wT0Iwd0tJb0paRnBN?=
 =?utf-8?B?V2VSbjRacmdJcGJVZjZWQXBLZFE5TFhrVG1lcno0RTE3bjllNFdvZno0VlhF?=
 =?utf-8?B?WCtDNXNFM1BJSWsrNDViTHBjUzlDSUJBUkxJbldTeFFMaTJlTDlrd1oydVYw?=
 =?utf-8?B?R2tMMndCd0R1TlpGckdWSTUva0JTREtuRVZvVG1PaTBBMU5TcUhlQkJBakxJ?=
 =?utf-8?B?UENuRWNMQ0lkampWNVYyQ0xjQzU4S0Rad1BiL0hMY3NtU0w1QjBJSE1FUHdq?=
 =?utf-8?B?ZU5LTER2Vzh0dGRpWUJqbXd3Yk5LV0owTHVIcXFnbE5zc2kzSkUwWmFvQmVN?=
 =?utf-8?B?RCt4M3VwYlEvN1E3RkNzN2l5bVNLb3RyRXhIUDFrZ3J6YW55WFRuWm9kYnRQ?=
 =?utf-8?B?b1Y0aEprcnUzT0d1Q1FqTGlVUml2QTZ0QmprVUhsQ3d1dDducXh6cDFETER0?=
 =?utf-8?B?c1ljcmRHdWQreFhxeC90dHkrNDBRVWNMTDRLdE0vb3VTWkVTeUNoZmVEVCtW?=
 =?utf-8?B?ZXZ3SGR0d0FsWWFWcFNMSFhWZUptaVpwQjhJQ1hpSldqZ2FoT29tcE1zeGR6?=
 =?utf-8?B?ZENIOFZ3Tm9xTHdTbElHR09IOGdoM1VzQXg1OTVlY1NEeWdqb0xBRFFqd09w?=
 =?utf-8?B?ZFVFSjBtdjJrTmxmS3pSRGJsNzFnWUliajBCWjFsTjdKdFBNQTdyNWpkQXVm?=
 =?utf-8?B?clN1a2NYcThBN2NObnZaSngvbW5vNE9BZDQ5bVBmUytXeTRjbkpMYUUwNmMr?=
 =?utf-8?B?V1VxRkUxZDl3SW5meXZzWlBGQ3d6WHpLNjNxSmY4Wm83STVsUkY0UlI3c2xG?=
 =?utf-8?B?OC9NRWJNUklCOUdZU29zRnIzd3NzMTM3Ukl6L0JpN0l6TUNyemRIRkRkWita?=
 =?utf-8?B?WWhFSnh3eG96bHN1c0d5Q3BPMGNDSWVNRHNwdnBoUStsNlR2TjluZnlvWUcv?=
 =?utf-8?B?ZEp4R0l2Y0xPS0x6cDFUOVhqcllFT3VTMmlmM2N1OU5vaER6YWxtQTJyYndW?=
 =?utf-8?B?RmtEYkFKb1U5Rm9oNS9Leko5d1lOYTFuWlBsSzQ4SWVXak5yazR2R2tGb0VM?=
 =?utf-8?B?NEM0ZGQwcEdTT0VDbFdueVhiMzhVakkwUGNPV2xZdW9Pbko3dVZid2YwTzRt?=
 =?utf-8?B?ZC9aT3hGUkdUU05OdmRvejJTR2dFOElLN01sOXBFTlU2T1JaZXhCYVo5ZCt1?=
 =?utf-8?B?dTRXL29YUlVtY0dOS1NYQndTbmxvdHk5ekczSkxOWTBueFJjby96VzR2QnZy?=
 =?utf-8?B?cGE0WTBnOU5UcExBZ3p3OUxLYlRwVTdFaTIwalFyVHc0RzJmTkM0ZDJRVEpv?=
 =?utf-8?B?Z3FHVFlrTm4zbER3MjRtQT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR10MB5893.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bmhWYzVUbUJDMXNERnJBUk5Dd1Badm41dUYvV0lwbERDYzZiaHR2M1lwbGFG?=
 =?utf-8?B?bzVSdFYzaFMwa2JoVjZlejhDWHVNMUoxNnFsUytNWTdiYjF6M011ODNvVURm?=
 =?utf-8?B?dFJrdUlZTlFibzFVV1ZFYmpENDFoRkVUSnRxcmc2elhOejZUbWg4ZmRTdmVm?=
 =?utf-8?B?VTdDcDQ1Z3pWeEYvbHQ4ODBQdUVRdEgwSnFOZEx4QW1XbFJFU2M2NitHMS9u?=
 =?utf-8?B?by9MV01lUzg5OHRxYlo0dFQ1VEdpanhUM01tN2wrdTBtSytoRVBQSTdHWXo0?=
 =?utf-8?B?cnIrOHNBbU8zR2gvVEtJRHhpTThIbWF1d3M5M3ZkM3hRdXFFTk5RNStHeXhh?=
 =?utf-8?B?Z1FOaXpzZ0dCVFNyS01wRVhWVTJBVU0zTmRRVnpFWjhhSngzc1pQRGJVNXQx?=
 =?utf-8?B?Q2FGbVkvNFcrN0xZdi8vMTVZWGIwL0Zxb2JRekVZdHMyQWQ3cEdjZm95NjI2?=
 =?utf-8?B?dml2RWw4dldPdEROOE1aZWsvc2l2MHZRVEpSQjVlS3I0YnNWYXU0T1g0K0NX?=
 =?utf-8?B?bld1TjJ4T1BaQlFNZHM1MFl0K3hpSGR0QUpjWlpaQnJiU3NxdU0wenNtbUxE?=
 =?utf-8?B?eVlsTWxJdEx3eDh1Y01ZQ3VJbGNXL3BKWjNmRmNjaEFOWWw5OVlFUTdjdjVC?=
 =?utf-8?B?Q1dtWm84OEh2VXJINU9SZU1FaEZnU1pxTGEyWjRrQmEzRFQvVXY1a2JWT1VC?=
 =?utf-8?B?R1RKR25JQTVFQlJNSmc5bndwcGd3RFQ5Y2xUUzVFOGwyVVcyMmZNSGQwdWVZ?=
 =?utf-8?B?VUF5ODJaVmxuNDE4SWFUVUtQelpvdWVPdWYvZDRJczR2anNBRE1nTzlONGl3?=
 =?utf-8?B?QVRENGoyalJqbENFczY5ZE40eWZIQ0FLeDY0b0VyWmNDeEVRNEJrRWxZWEFa?=
 =?utf-8?B?QmdPdmtjdGR2Sjh5aDl1eStoYi82eFUweUV2VDJoazdacEp4d2lKMlBRMFF1?=
 =?utf-8?B?U1d2dWlRUE5ob2JDL2VFSGhFdFdMU2N5S1J2R2F2SXZjcjYyZHJVMElCOG1t?=
 =?utf-8?B?aWZSa0dPVHhzZlJBSjh3Ny8vbFZJQzZibUdueGE0dWNZYUZ6SzJmVUxRWGtM?=
 =?utf-8?B?aVRZZytTSTRmRC96VHZxS0lyd0F5ckFWbjZKam1zRUZWTFVaZWpVQUVxcnRX?=
 =?utf-8?B?RmoxbE5FV1lPMk1YUzN6b1phNzZVVWdTOXRzNmlGd3pBakpFd1NpL2lWRnhZ?=
 =?utf-8?B?b0NBUVk5bFQxdlUzcGN3SEJxTjhRbFlYeHVwTGNWc3VpakVETWU3K0ViSks3?=
 =?utf-8?B?MVNYOHhZSzJ5TzlJaWhvVHhPVG15TDBMREJkUis1TjJGeFlrTlhrUFNYVXFy?=
 =?utf-8?B?RjhPaHhrOTl4SGMxNzgwWHJod3h3VUJORzhFeTlmQWZ1L21XYTg1R2tYRUVl?=
 =?utf-8?B?Rk9TejZvQlkzMTdUQXhmM1ZOYWNPckNRSHJRYkhWRGlzRHdLWGlFUzV3ODBS?=
 =?utf-8?B?QUQ3dHBjTW5qRFZPQ044OCtvYS84K0tTdWt2MHRHeE1CRHFSYkdESHNTZjhG?=
 =?utf-8?B?WEhIUXBoZU0wM3pnVm1JcnM5Z3hXMkRMTlJia0FYNkkwaUVaTmZaMkNnM0p1?=
 =?utf-8?B?VGltcS9pS0syQWJXK2paZHlGdEI3WjBLYWJXU3RNQVhhdmozc2tEcVBGZjZq?=
 =?utf-8?B?OUhwQ3FTcWRzUXpyT3JwWFlDTFVLQjQ0MHMvSjlhbDhlcDJESjBCSHpCWTg1?=
 =?utf-8?B?WEhxcDhXYXh5REpuYXZXdzNTZ2EzUS9CUStzVkhnTmpiTHE0YytUU3pZdlcw?=
 =?utf-8?B?TXpoc0tWS0UyMTFUUURHQzZseDBPTHozNHJzbk8yOWswTXBkdjVmMCt5Y1Np?=
 =?utf-8?B?a0dNbzBPUXFVbUprdTJVcDdCUEJxNUN3MUFLMTRwY3ZCSjZ1aG1ycGR0aStM?=
 =?utf-8?B?bzZ4WTVoOTdhYzRxdVFPU1ltVThpc0xQTmxPcXpjVEpPWG42Nld1L3k1U3BB?=
 =?utf-8?B?alJKL2hDMVBnTklSeGU3bDhPNmFYYXZvdU9PV3ExYjZqRmJPKzcvakxGOEIy?=
 =?utf-8?B?ZzlwVmgva1h5UVFuaTh0bzRxKzlES1FyOHU1dVpJL25sb2JrTDVUby9JVUYw?=
 =?utf-8?B?REYxUUV5ZEE0WVQxRHl4RFBvOVhBRmYrZGp1SDBFR3ZXUWUzd0RWL3p3N005?=
 =?utf-8?B?NmdUTGo2MVRGWGJ4RGNaKzFLckNMRnZ0UFUxajRBeDdNUkpWc3pOYnN6eFZY?=
 =?utf-8?B?NkE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: ckpb7JsIYecntVd1nbxsEYHi+Cq9vCpqcpjfx8sS0oNSXaemWnEbvEg84kmx1a9rI7xxjhf1iWzC9pzKGdVr890vnRc9Va2+Ns05bWeRbgtyAlFLR4+cj0GPXLeQBsAk6fkUtSBQXS3ySQ7AM+VZfXgSsURQBeVlfvkJFoW9qhu/pkn+11/M3cbzvWCTItQYMYm+VEwvbzD2hZGYzpLdTFjPMVDZn16HAC0UyYQKKNaIbFeoXESiDmsNklPTmYqkViAL2iJWDXbpbmw4xi+BF7LVrwzoAn6ypBsMrIvNWhzWj5LyWx2zv8Lmx/hckikQ015oDix4AM7eHHhR6f8b+KCHc8PtjMg8ZSAzEe7kNGxrCvmFGSq0GltYEa7/UEeko1oWUahMgAfVDFR8D3kYmDaxkke7XgYTt2m6wxirn9TCqHALv10nQSx1MrFhUKEUSeINScelbdyBUHDCcnWJaxmaZ8jiecV2V8X1+4VEU0JJScV0tmxrdMv8IHxSc8uLv2q3UwUUTgnW2HMIqVnX087KEDniRdnwmaifCWuf/2Z0RXNsgY0yVyoRRsgRj0N7tWPNIMJjTEAcmqIUFdhM1rtNIYuCLDbm84BpLOqfYjQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee2124cc-ea7a-4c2d-3696-08dca7fe7fd4
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5893.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2024 14:24:29.0101 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1pZMumr/p1op/MNZFAnbIP7EC2gMy4QozV86V+T6/NfpkAgnEap9H+z2Xg1pUODjJ2lC+FbBsI84L5uMlXLvHCEJuyFi6Iyhme+I3coQXIE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB7039
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-19_06,2024-07-18_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 spamscore=0 mlxscore=0
 malwarescore=0 adultscore=0 phishscore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2407190110
X-Proofpoint-GUID: VuqsWINrjowTsjvbSJBjBUyzz1DL4Rvm
X-Proofpoint-ORIG-GUID: VuqsWINrjowTsjvbSJBjBUyzz1DL4Rvm
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=joao.m.martins@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 19/07/2024 15:17, Cédric Le Goater wrote:
> On 7/19/24 14:05, Joao Martins wrote:
>> By default VFIO migration is set to auto, which will support live
>> migration if the migration capability is set *and* also dirty page
>> tracking is supported.
>>
>> For testing purposes one can force enable without dirty page tracking
>> via enable-migration=on, but that option is generally left for testing
>> purposes.
>>
>> So starting with IOMMU dirty tracking it can use to accomodate the lack of
>> VF dirty page tracking allowing us to minimize the VF requirements for
>> migration and thus enabling migration by default for those too.
>>
>> While at it change the error messages to mention IOMMU dirty tracking as
>> well.
>>
>> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
>> ---
>>   include/hw/vfio/vfio-common.h |  1 +
>>   hw/vfio/iommufd.c             |  2 +-
>>   hw/vfio/migration.c           | 11 ++++++-----
>>   3 files changed, 8 insertions(+), 6 deletions(-)
>>
>> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
>> index 7e530c7869dc..00b9e933449e 100644
>> --- a/include/hw/vfio/vfio-common.h
>> +++ b/include/hw/vfio/vfio-common.h
>> @@ -299,6 +299,7 @@ int vfio_devices_query_dirty_bitmap(const
>> VFIOContainerBase *bcontainer,
>>                   VFIOBitmap *vbmap, hwaddr iova, hwaddr size, Error **errp);
>>   int vfio_get_dirty_bitmap(const VFIOContainerBase *bcontainer, uint64_t iova,
>>                             uint64_t size, ram_addr_t ram_addr, Error **errp);
>> +bool iommufd_hwpt_dirty_tracking(VFIOIOASHwpt *hwpt);
>>     /* Returns 0 on success, or a negative errno. */
>>   bool vfio_device_get_name(VFIODevice *vbasedev, Error **errp);
>> diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
>> index 7dd5d43ce06a..a998e8578552 100644
>> --- a/hw/vfio/iommufd.c
>> +++ b/hw/vfio/iommufd.c
>> @@ -111,7 +111,7 @@ static void iommufd_cdev_unbind_and_disconnect(VFIODevice
>> *vbasedev)
>>       iommufd_backend_disconnect(vbasedev->iommufd);
>>   }
>>   -static bool iommufd_hwpt_dirty_tracking(VFIOIOASHwpt *hwpt)
>> +bool iommufd_hwpt_dirty_tracking(VFIOIOASHwpt *hwpt)
>>   {
>>       return hwpt && hwpt->hwpt_flags & IOMMU_HWPT_ALLOC_DIRTY_TRACKING;
>>   }
>> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
>> index 34d4be2ce1b1..63ffa46c9652 100644
>> --- a/hw/vfio/migration.c
>> +++ b/hw/vfio/migration.c
>> @@ -1036,16 +1036,17 @@ bool vfio_migration_realize(VFIODevice *vbasedev,
>> Error **errp)
>>           return !vfio_block_migration(vbasedev, err, errp);
>>       }
>>   -    if (!vbasedev->dirty_pages_supported) {
>> +    if (!vbasedev->dirty_pages_supported &&
>> +        !iommufd_hwpt_dirty_tracking(vbasedev->hwpt)) {
> 
> 
> Some platforms do not have IOMMUFD support and this call will need
> some kind of abstract wrapper to reflect dirty tracking support in
> the IOMMU backend.
> 

This was actually on purpose because only IOMMUFD presents a view of hardware
whereas type1 supporting dirty page tracking is not used as means to 'migration
is supported'.

The hwpt is nil in type1 and the helper checks that, so it should return false.

> Thanks,
> 
> C.
> 
> 
> 
>>           if (vbasedev->enable_migration == ON_OFF_AUTO_AUTO) {
>>               error_setg(&err,
>> -                       "%s: VFIO device doesn't support device dirty tracking",
>> -                       vbasedev->name);
>> +                       "%s: VFIO device doesn't support device and "
>> +                       "IOMMU dirty tracking", vbasedev->name);
>>               goto add_blocker;
>>           }
>>   -        warn_report("%s: VFIO device doesn't support device dirty tracking",
>> -                    vbasedev->name);
>> +        warn_report("%s: VFIO device doesn't support device and "
>> +                    "IOMMU dirty tracking", vbasedev->name);
>>       }
>>         ret = vfio_block_multiple_devices_migration(vbasedev, errp);
> 


