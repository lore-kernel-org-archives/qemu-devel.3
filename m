Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 088D8CAC5A5
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Sep 2025 11:34:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1kEK-0006rb-LE; Thu, 25 Sep 2025 07:33:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1v1kDW-0006WP-TP; Thu, 25 Sep 2025 07:32:56 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1v1kDO-0008LK-RP; Thu, 25 Sep 2025 07:32:53 -0400
Received: from pps.filterd (m0127843.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 58P1rARQ2033586; Thu, 25 Sep 2025 04:32:38 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=IGxqKJ3n1yheYuMJGV1V7MOtjjHxJc4qybyoZZ54p
 IU=; b=0ABTeTM+mAuk4nhFX8PeqBpcuOzF6uNDXmNZjGBhotaDJSj8ODQ0vmvrq
 sFoCktIfiPUTyNO6gTymLN7r101tVWrFXiyiCL4tGa1yn8ETj3HaRKoMnF6bXlGV
 3bA5Jm2cY86PPKzlFEjpNFmpjTeb+e8efZFrvY4OoSIFucvbty0cl3qk9iYbtcqM
 PsfYZWmdONTzRyYtdF8bNMXK3bUO65vHedizrfxymc0hF4aQJDQd9P9mgB4AnLYN
 GU89JJ1B7OXPNYEfK47/eo3o2kagphr8Ev1woWx0JUkpqhfROgoRIvN1C/4ReIWg
 2T7HE+BgityaxUQ0QYcNmR4nfpM2g==
Received: from ch4pr04cu002.outbound.protection.outlook.com
 (mail-northcentralusazon11023104.outbound.protection.outlook.com
 [40.107.201.104])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 49cj95tkna-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 25 Sep 2025 04:32:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bxj36ZP1x262vt3uT2mBUdGC47s8KJJlAwVwEnfdEFjye/Fmit2ATbFumJEkAxuH8KybKrf4lO+QcB7VzdV+5I1091veduzkKU1KD/FxDbZulOkQQMbQtvLoCykmkzHdscVZmcDx4rVZ8qB8GSXOhlKK8qG58ub70wbuvDS6U4yGm39s4EN81BLC7oUMKdQpgvAG7uH/7QPcXmhja2iRTPx4zOGLOwc/lIF2KOai7tU3953x1wTQeauFa21/2ImG06i//+rNDxFYW8zqnV+KsE83MNoNARK9BAcUAhA6aXLTVfXWLAAM90xLSDpCd7jBvZ7Rh7fDSkNssBiHiN8Q0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IGxqKJ3n1yheYuMJGV1V7MOtjjHxJc4qybyoZZ54pIU=;
 b=nNpkFlDfTBDGoOjuSTuZZNLDnzRw4JTJlWSAjFLyOZc8FTykgF08kE+5GkVFfZLSI+5kHXKKx6/GKHhlFk5Y92ToimqDN8dTJ4wOqpY+islbikMYnw5ksJsoN49o9X/X5PJPkONt+fh3cW+V/66aVoYJHlxrq2baXxlGBpYcFeSkA1pO9qng1lcvu8DbAIxuR0MgljX5vk8HQoFGwmM3YAiUJ8XtF77eBlUu5YrGBMCRNSC+qDl9anwKEewjMqWjHvcaS610sPLg8oaVDh9ICmLSpgC3MXCZRg1B6hwUd69dL9whittVdaV98f/2ovJS+DKIdcxuv1ZIT9MYlLZWRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IGxqKJ3n1yheYuMJGV1V7MOtjjHxJc4qybyoZZ54pIU=;
 b=quT0bIU7cgf6fzl/wNsSF7WmrHUDX2aDoRxd27uMsBl1rRQYTb5GJhzqt7q4D0iIJW+OhbSXBnUiAVlnU9a2JuBXreKKHEyWFetRXepgV5nK4daMjlXGgA48grax1Qly06HpHJzRImFfjLiIn1DQSptJHy9CiPRmygVQzeYVijQcWPMCNpX3I/Yiryf6vNrN8GkYTQa+JbDQUps7hHmATIquBtJIhbHMmVbBp9N3cxiIvbY9IZxtdongo10+haHIdSLhhA//9ZP50oBZIOWJthaGkcnGzZZGqHAThVEdsUGJWyWsDycfBvXvv2p0UFtJmQU74iN4rJAVSrRRCZVCBQ==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by IA0PR02MB9854.namprd02.prod.outlook.com (2603:10b6:208:483::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Thu, 25 Sep
 2025 11:32:36 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88%3]) with mapi id 15.20.9160.010; Thu, 25 Sep 2025
 11:32:36 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: npiggin@gmail.com, harshpb@linux.ibm.com, mjrosato@linux.ibm.com,
 farman@linux.ibm.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 thuth@redhat.com, richard.henderson@linaro.org, david@redhat.com,
 iii@linux.ibm.com, john.levon@nutanix.com, thanos.makatos@nutanix.com,
 clg@redhat.com, alex.williamson@redhat.com, steven.sistare@oracle.com,
 qemu-ppc@nongnu.org, qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Subject: [PATCH v2 10/28] vfio/spapr.c: use QOM casts where appropriate
Date: Thu, 25 Sep 2025 12:31:18 +0100
Message-ID: <20250925113159.1760317-11-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250925113159.1760317-1-mark.caveayland@nutanix.com>
References: <20250925113159.1760317-1-mark.caveayland@nutanix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P265CA0273.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:37a::10) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|IA0PR02MB9854:EE_
X-MS-Office365-Filtering-Correlation-Id: 703b625b-297e-4f41-d08e-08ddfc273a10
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|1800799024|366016|376014|10070799003|921020; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OWNDdUU4REdQV0VMaG13TEFBWTk5WXVYWXBacEJCd0VENm9oeXRpS3J1YkhW?=
 =?utf-8?B?bXFNRXRCa282cXU4Rkl5RWRuL0JucXFZZ0ZlYlBkbGtwK0FkRmNFRW40bmVB?=
 =?utf-8?B?aitRdmVzZmlnUnF0amtiN1hYb0liZHp4Nk9odlFtMHAwdE0zSU96MVNVUENW?=
 =?utf-8?B?ajlFYjNEV1pOWEJuUUVPZnBLWFRXMVZ3TXhtWG1ZcFlnbS91WWFQT0IyUGFW?=
 =?utf-8?B?THp2NElJMVhYWEdZb3QrT2xuZWxpeVRuRllTUFNCcVVQa3kyWjhFYTJlTU10?=
 =?utf-8?B?TFlaQ25ubGVwQi9rOFlBU2VxY05mZHlWMW9qbGdubUtWUXZtY3dMMG5vdFV3?=
 =?utf-8?B?YUFYYWNrczJTc244RW4yRHdzUFg5OVhIblZWcHRZU1ZteFI3NzZwWG5jSEY0?=
 =?utf-8?B?Y0h1bEhHV1haOEVCUEpWT01zMmUwZXZTWFJGenRGQ3RGRVNnZ3V2bFJDOTky?=
 =?utf-8?B?N0lrcW5oeFdnNDQ1Y3NTYTBGcGNKZ1I5QndoS1ljakJNNWtKRU1ydGJ2VU42?=
 =?utf-8?B?Y0NsL0I3eUx2U29BR00yV1hkRjhJZEQvc3FreGZlMmw3RC8vMXdjTjhJeXRs?=
 =?utf-8?B?NktRRlhZZUlESTBsd0M2NGQ2RmlWTjcycy9Rd1pVTEFRblYwUlRBSy9YYXpW?=
 =?utf-8?B?eGhuWlVMakJRakVLT1Z1SzQ5N0tucVppdmhESEdVc2llY2t6VmN6UmJ6RHBr?=
 =?utf-8?B?VGEzVk8yNUVra3RkSzE3WVdqWXFYMUc4Zm80YjYvazVjSlc5alJrYkFFMi9M?=
 =?utf-8?B?aFBXREhXcmZaRGhZUGU4VDZTT2NRa2xINktYTTVVT0dMQlhyN3pIMkhxSTBJ?=
 =?utf-8?B?SWtCb09lamxIV0t0MzZaeEdpY1ZvSHdNcmhoc2pRUXdYSGxOTlp3c2JvQUt4?=
 =?utf-8?B?YS8yMEhqdGVNNTZCYlJ2SWpOcnFnd3I2aWlkclhNY2VQMHhJSVNPWjcrZm5h?=
 =?utf-8?B?SEk4Y2JDVlcwbW03MkI3V3N3UTMwSURVa0ExUWxVVlIwUitPcGFjbFFFNmtT?=
 =?utf-8?B?djc2bGpIQ29JM29zdlhIcC9BOERWeGpuam1DMXFVUFZsenBUN1l4aEF0NUZl?=
 =?utf-8?B?NDRYSDMwMkVwMWdVSFZ5cWthM1hjZ0ZVUUkzdjM3RS9QMFROV3Y5eG9aSHor?=
 =?utf-8?B?cG1uYWNxdUFqTTcvTzVHTE1VSVFBdGNyK2w0aldabTdHOHlWM2xlTjJrNU5n?=
 =?utf-8?B?UUpjR3F4bGJSU0g3TzRDVll4MHFaWUhRR3N5SHprNXNLdGNvWmpWNDhGaGE3?=
 =?utf-8?B?ZHN3bUJuSkRsOVMwMVFnajRUT3N2b0UwWW1kejVsWmhsZ3NHWXQ3ZkxhN01l?=
 =?utf-8?B?YW9Uay90SjIrSGt3Q2FoRTY4U3c1ME1QL21ZTTRlZHNjTktFL2FlRnI3MDR5?=
 =?utf-8?B?cEM3eks4R3dORFhmRWo4STBrQXdwcWZSOUc3M1FKWFAzTlRwRlhMdXNabjhG?=
 =?utf-8?B?TlJTUlZ6TzVLYzlFaDhsdFRSUDI2eERYakFSU0hyOVZ5M09lWXY2ZCsxWVVz?=
 =?utf-8?B?K3pMMXlqc201VlphbC8vc2o2SFR3RkI5QnlXTmhrV29sUDFwMWZQV25uYjkr?=
 =?utf-8?B?VFR4WWRFZkI2ckVubUZMZmNqVnIwK284QXlhZTRJaVR4Nm5QK0ZIV1hGWEM5?=
 =?utf-8?B?OHRoeGJiVWdwQTkzTDhUb0dBaStoOWJZeXhLc2J0aklVQ3B6aDNkczBoNVdY?=
 =?utf-8?B?Tzg3MXJ0bHFOM0ltU0x5R1NQUTdjdXZMaGtIbDcrS3g1MHc0VHo4YnA3NXdS?=
 =?utf-8?B?YVhwVGk3Q2NiREFiQitZSDJPeWZQSWZ0RUFucUJSMGhrTjRVc0paazRWWmVu?=
 =?utf-8?B?U256QVFMRENBeGxDbFZ4ekNpWGdiM2dpR1BYMU5oa3UrVURyU01DTDFXRWgw?=
 =?utf-8?B?eEVBbkFsSExDM0VCc2pwWUcwaVRLUko3TlRxc2hORE50QjV1MEtuSXJCNnBB?=
 =?utf-8?B?UjNXMUtiQVdnWk9pS3pybVlucHlXQlMyTGlseUpWYzFacGxnbWYrL0x6QlFP?=
 =?utf-8?Q?OjivVhaxa3VXQmRHoFx9Mj5RTAZ12c=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(1800799024)(366016)(376014)(10070799003)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Tm9jVVNDL3dZZmRBTUpIanR2dU5HVWQ5djQ5cjNQR3dLdlhNUHM1Yk5GZVRD?=
 =?utf-8?B?b0s3RE8wem4rVjNaczN5a3lIeDNEME9pOUpMWXpZSm44azcrU2hBeGlNWWpN?=
 =?utf-8?B?TXFldDhRNDhXcmJ2Z2VpenY3TEtJSEdFd1RqT2gyTlprL2RsVmdVSE9lVW5Z?=
 =?utf-8?B?dTNlRkRkeUx2OFdsMCtKVzhKZy9VTkVBVXIzckF1Z01BZnZHYUJ6NG5Mam5s?=
 =?utf-8?B?TW5vN2ZJd1RCUWpVTlNnbzNXaGUwYlA3T1BHQk03RDJuZEdIM3dWSHVzYWxn?=
 =?utf-8?B?R1BTK29rZC96a0N4UjhiSTNFc3gzRCtKemN3ek5pSHduNXVEVnltaFJpVW5k?=
 =?utf-8?B?L1l3WTdONmw0SC8yMkdnemhLZURrcFYzTU9Kc0hybEZOb3hVRlp4YmJLOCtU?=
 =?utf-8?B?UWk1Z0hLMmdjSE5Fd1RWZVRPQjVyTHptYnJISS9ZRE1zTkRlVnhPRE1ZRTR3?=
 =?utf-8?B?VTB2OEdUTGJwZHB4dS9FdW9jaGlTN3Q3djFvQ2tORy8zQUdnUVZJVnFKZlRy?=
 =?utf-8?B?TlRpWUV0YTREZ05ESTcrQnhGd1pLbDBQVWxzZTYzT1N3NHJpVnAzYUVQbUto?=
 =?utf-8?B?TmRsWEhKaFhEZHEvOCtGODdDUmg3U0ZaQU51WEVFRGswcnBNVTBZQzhLSDRB?=
 =?utf-8?B?cm5MaFFmYm1FL1E1UUlhT2VQb0poZ1htQ0VDZlJVZzNSaTNwb1dnVEFqZlM3?=
 =?utf-8?B?VmJXVHd4cHBpWUtTaXJKeVA5ZHJQVCtUY3dncUh0L2hRdHp2N3FpOVlOUDAv?=
 =?utf-8?B?ZHhkeEw5eUxGd2NLN3E1eXdSWW0vWHprNGhJTUZiYlQ0SW1ETjhISGpOcUhN?=
 =?utf-8?B?anprRUU0bmJJS01PYUpqTTRuWlYwZFhMbGYrUGx5cjlpQThRZGJCazJkc2hB?=
 =?utf-8?B?RWduVFhyVHlsQ0tiY2lYTEZ6SkdqczNUeTlVS3BienB2QlRzUzdHeGNGMnNy?=
 =?utf-8?B?Wmx0V09lSWJweTRkMStCaVIvZ210YTBDRU9MOEhNWWZDcEtVallMZGRKM3l2?=
 =?utf-8?B?ZEd5Yjd2VVpxWVdKTlJhZzNsejR0cVlyVlllYVNYL1RYdlVGNm1PV3YrRWt6?=
 =?utf-8?B?aFhyRmZqaWRCZ2Jud0UrVmpGWXFOTlpzdmZ5UEJQQis1bnV1VGx1NU4zNFlI?=
 =?utf-8?B?d1FETnV3bG5DMndWMi9DOUM5N3JOU2tYZVBPNEcxbFZTQVFzZUJiUS9SeFYy?=
 =?utf-8?B?Si8rZWkwWnJDaXZBUFBuY0JKc0tmWENraW5Za2QrZEpQNHJqbDd5OXRwaGJJ?=
 =?utf-8?B?NW5rdDY1a0FmRGdsZlZVUThVY3gyTGkyMHRjeHM5a3BabkFqSkFrMmRvSkM4?=
 =?utf-8?B?OFpTQjZSQmpVNUZNKzZVZ3JJNGpHYldEMjR4ZVJRV1V0elJHdDVMcldkMnFt?=
 =?utf-8?B?allqOTdCWnZNNFpmVUlhWE1oVU5GQTFVZkNuLyt5Y25UQXZBcnpVdjRwZnho?=
 =?utf-8?B?bldiQXZNN3RHRUJTSUl5cGVCa0kyYk8xc0RncUpqK2Z1Z2VpMHp3RW4weTZM?=
 =?utf-8?B?MklON0l6eE9aOVZpZE1HazF3NWtKMVFXQ1RjQXhlOHpySXBaM1l1ajVueTEw?=
 =?utf-8?B?T0pHcDl3a1dHTmRaaWMyczE3ZFZLRGdrSmR0Q0NuSHZKSi9WdkMvQTVNckdE?=
 =?utf-8?B?ZVdjbzRFRWhwaE1XVUtyNDkxODNtaG9lM2xIRy9tSXBtUFBXdUtjWGphbEpV?=
 =?utf-8?B?SDR0aWhJSU0rSTcxcStUY2VzMG9VZlBqRDVaWWxlL2pQRkNOOFlvM0ZJazF0?=
 =?utf-8?B?UlNtaHh3czdyME5HRk5PTmp5K3FBVnpiVGV2WEN6WlBkRUxUcnFnUDN4cThm?=
 =?utf-8?B?ajdxd0NWTkFtR1JHd2lXK0JIcWwvWUJoL0lHZjNiTysya0xxOG81bzFnaDN3?=
 =?utf-8?B?QjZkVFFDVlhUK1htT0pXdTlYZ2UzVjV1THM0VTBsUkhKNHdJaVh5TVdhbzZI?=
 =?utf-8?B?UHV2aG5CNUxlMXQ5RUM2Z1VzRkg0Y2NwUWNYWW9lVS9GK3Foa1h3ZEplTWQr?=
 =?utf-8?B?SFpCdWlGKy9oQzNEMnRTUWxrcGZLb1RJWVJUbnp5b2xwaHlZNTFhRGtpcUdn?=
 =?utf-8?B?WE5LWk9ra3FkdWlKYy8wT0poYjZPaXRDR2M5dGpOcmcvM2xJNkJjZEh4OFJv?=
 =?utf-8?B?OERLc2krb1dzTDJrUGtnUGxvb2h6cllyUVhCTm9iSmwxQVlvTXlKWUN5Q1M2?=
 =?utf-8?B?dFo1anphY1Z1dGliT1c1eStoUVJWV05DOTdSZGNOY25YQmJZeDUwRjgrczl3?=
 =?utf-8?B?dklBMjl1QVhieWVyL2x5UXhNSlN3PT0=?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 703b625b-297e-4f41-d08e-08ddfc273a10
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2025 11:32:36.6802 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +twcOwzA30pQ0y9rAI6bPSPS/O5z5PKvx9rvjE5vQY7I06g8TdYm+yghG0b0Pt7ogeKIhbbqmfwCJGQ6QFSCuHPtl6zcIrqWwuMbGyQRHkk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR02MB9854
X-Authority-Analysis: v=2.4 cv=fPk53Yae c=1 sm=1 tr=0 ts=68d52856 cx=c_pps
 a=0aASrZ1Sr5nz2ag1/hSaPw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=0kUYKlekyDsA:10
 a=64Cc0HZtAAAA:8 a=20KFwNOVAAAA:8 a=c0CgGTMH7bFtNtui_9cA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: g6RVdCfZBpm88E984RDvqaTIO4xatmUK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI1MDEwOCBTYWx0ZWRfX7oSxG52nd8uU
 kDZGdo/mO8YvK3LiYcWZVj7vNgLKMMufBICmTdXx5O56PBLJMJOquuuwRtgL0rHCjdwjyTwXOtW
 ldz0kTtDU06NsXajIzAoeRk2/mR7IuJY8arVhaCLraAJVx8CDPQ/V1mIeB1ygWddqmElJ/WmHVW
 Cn5U0PO4ukJqegBTPYEaNi0Iuvan3jDMGAQYbHeRarvyBMge2GzflpFhmwnD2l5efdlCgB286K2
 6qPDeuXJ65wIp3Ik+lgsz0H+i8coI29OhNg40TwvAamL+UhJd4aiZyGBqhk2598fALhqbVDOkmb
 Lpqrytyu1D4Gx2F4RTFPo8SNRL7ACBzOCY5DUbsu0SlgACBMxJdf5XEs3GcqCg=
X-Proofpoint-ORIG-GUID: g6RVdCfZBpm88E984RDvqaTIO4xatmUK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-25_01,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Use QOM casts to convert between VFIOSpaprContainer and VFIOLegacyContainer
instead of accessing bcontainer directly.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio/spapr.c | 19 +++++++------------
 1 file changed, 7 insertions(+), 12 deletions(-)

diff --git a/hw/vfio/spapr.c b/hw/vfio/spapr.c
index acaa9c1419..c883ba6da9 100644
--- a/hw/vfio/spapr.c
+++ b/hw/vfio/spapr.c
@@ -61,7 +61,7 @@ static void vfio_prereg_listener_region_add(MemoryListener *listener,
 {
     VFIOSpaprContainer *scontainer = container_of(listener, VFIOSpaprContainer,
                                                   prereg_listener);
-    VFIOLegacyContainer *container = &scontainer->container;
+    VFIOLegacyContainer *container = VFIO_IOMMU_LEGACY(scontainer);
     VFIOContainer *bcontainer = VFIO_IOMMU(container);
     const hwaddr gpa = section->offset_within_address_space;
     hwaddr end;
@@ -121,7 +121,7 @@ static void vfio_prereg_listener_region_del(MemoryListener *listener,
 {
     VFIOSpaprContainer *scontainer = container_of(listener, VFIOSpaprContainer,
                                                   prereg_listener);
-    VFIOLegacyContainer *container = &scontainer->container;
+    VFIOLegacyContainer *container = VFIO_IOMMU_LEGACY(scontainer);
     const hwaddr gpa = section->offset_within_address_space;
     hwaddr end;
     int ret;
@@ -245,8 +245,7 @@ static bool vfio_spapr_create_window(VFIOLegacyContainer *container,
 {
     int ret = 0;
     VFIOContainer *bcontainer = VFIO_IOMMU(container);
-    VFIOSpaprContainer *scontainer = container_of(container, VFIOSpaprContainer,
-                                                  container);
+    VFIOSpaprContainer *scontainer = VFIO_IOMMU_SPAPR(bcontainer);
     IOMMUMemoryRegion *iommu_mr = IOMMU_MEMORY_REGION(section->mr);
     uint64_t pagesize = memory_region_iommu_get_min_page_size(iommu_mr), pgmask;
     unsigned entries, bits_total, bits_per_level, max_levels, ddw_levels;
@@ -353,8 +352,7 @@ vfio_spapr_container_add_section_window(VFIOContainer *bcontainer,
                                         Error **errp)
 {
     VFIOLegacyContainer *container = VFIO_IOMMU_LEGACY(bcontainer);
-    VFIOSpaprContainer *scontainer = container_of(container, VFIOSpaprContainer,
-                                                  container);
+    VFIOSpaprContainer *scontainer = VFIO_IOMMU_SPAPR(container);
     VFIOHostDMAWindow *hostwin;
     hwaddr pgsize = 0;
     int ret;
@@ -443,8 +441,7 @@ vfio_spapr_container_del_section_window(VFIOContainer *bcontainer,
                                         MemoryRegionSection *section)
 {
     VFIOLegacyContainer *container = VFIO_IOMMU_LEGACY(bcontainer);
-    VFIOSpaprContainer *scontainer = container_of(container, VFIOSpaprContainer,
-                                                  container);
+    VFIOSpaprContainer *scontainer = VFIO_IOMMU_SPAPR(container);
 
     if (container->iommu_type != VFIO_SPAPR_TCE_v2_IOMMU) {
         return;
@@ -464,8 +461,7 @@ vfio_spapr_container_del_section_window(VFIOContainer *bcontainer,
 static void vfio_spapr_container_release(VFIOContainer *bcontainer)
 {
     VFIOLegacyContainer *container = VFIO_IOMMU_LEGACY(bcontainer);
-    VFIOSpaprContainer *scontainer = container_of(container, VFIOSpaprContainer,
-                                                  container);
+    VFIOSpaprContainer *scontainer = VFIO_IOMMU_SPAPR(container);
     VFIOHostDMAWindow *hostwin, *next;
 
     if (container->iommu_type == VFIO_SPAPR_TCE_v2_IOMMU) {
@@ -482,8 +478,7 @@ static bool vfio_spapr_container_setup(VFIOContainer *bcontainer,
                                        Error **errp)
 {
     VFIOLegacyContainer *container = VFIO_IOMMU_LEGACY(bcontainer);
-    VFIOSpaprContainer *scontainer = container_of(container, VFIOSpaprContainer,
-                                                  container);
+    VFIOSpaprContainer *scontainer = VFIO_IOMMU_SPAPR(container);
     struct vfio_iommu_spapr_tce_info info;
     bool v2 = container->iommu_type == VFIO_SPAPR_TCE_v2_IOMMU;
     int ret, fd = container->fd;
-- 
2.43.0


