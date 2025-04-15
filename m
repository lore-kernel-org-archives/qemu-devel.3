Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B468C369AB
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Apr 2025 09:21:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4cTZ-0004sg-3S; Tue, 15 Apr 2025 05:21:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manish.mishra@nutanix.com>)
 id 1u4cTW-0004sB-7g
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 05:21:02 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manish.mishra@nutanix.com>)
 id 1u4cTT-0001fP-CP
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 05:21:01 -0400
Received: from pps.filterd (m0127843.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53F8aWPw018947;
 Tue, 15 Apr 2025 02:20:53 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=OeSZIPeFp2/UFqASKcujSzfocYLdM54Vzquwb61Nx
 c8=; b=qVm/GOKzNypjwe/EK4nc2YMfyHG3kp96pNx08YzwgNp2Vj0wB1onkNPKJ
 gwrEWYV4FcOBve8ELwPDe/RAui13lQDDzolDfC1MrU7cZHL1U5Yhx8Qa+AXjghii
 dwH6UPJzU2SfYpIspsJopUT/hO0OPZ2HVrM6XEnUgfP+AZBazT1n7A9COnRkhOxe
 H/6ssDm9nD5HTm3eCrZeEV7+6U/2FEm//ZceBKBS/xG3bVTDCfRSanCWmDnQnf0d
 CCWKl3eqkpCadZSaPM9J6aq5NSUts6zbFy/etJaV2SiYcrCTB/nyrtl5Uc66SP8l
 5gyQWuRQ3yyYEMyY9diF6bxF1uT5Q==
Received: from cy7pr03cu001.outbound.protection.outlook.com
 (mail-westcentralusazlp17012037.outbound.protection.outlook.com [40.93.6.37])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 45yp9hwub9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 15 Apr 2025 02:20:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nDVTW7Sec8mRYJ0qVJBp5pNzFCNSvQtQTVBLpxUhubh8O4efDYQ/VVsOXGCaY5ub++0hY5tAoPo+ceiHEj2QZPxTz+Gflx7iKiiG39F5tP9S+RQlKYMfyUYSSVcpmV2ZmKpMGuruOEDhaNWwVtyti+z78TwH11lX2EGK2CuhfDSoet8Y7M1m9A/pGzuShXDyosSpybPAswOHkerRjsfOeXrB2XX+2Vsaufnub5NQWKhSrWaKUYmvgDdTydFF5eqzK/UaP0y7hxFi6u9I0uCN1iHmJFi4V+lR+9waMqmlBB6W9MIY0/tezPpEywlJdPOvexeMFoUzFOU8wg1jGuItrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OeSZIPeFp2/UFqASKcujSzfocYLdM54Vzquwb61Nxc8=;
 b=xm01B4Ufs18+kCYoZ2Nnw0MnE50jTb2HGOfvNWPoMVvWK38fpRUo6GAJkvhnOTU8NcM1yLOdeO4+JrTO8n1YXIPnkG6zZudV3eihgtxR2+wv2lV1BiOFFMiUqH6XGXzMowBdsQPQsueWDbUuNDtUm24VRsID8wmKrx2N0KpHzZVbMpBxvcCZLWZyUtcsLiO55LtmT2Skdz5ZYjDo/fFoz5+uI+/Fvk9XF18av+mteWs9kGhNJ/SS39/Q0unesy1vjjCUj/nkcfN/R7g1SW6TSOW1bjCgnxTMySlhbcsbVe+CWuISgSiVh455pOmBcDLEs7/vOgwmB/b8Pi7nF/VFOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OeSZIPeFp2/UFqASKcujSzfocYLdM54Vzquwb61Nxc8=;
 b=yi9iphf4Eh/5UgsB60nzE7Jca1q9/DaxudrrJ1BLPW1F1dRUd104BtcJMrS54vzGgchifUhTYWlKKjVFu2Xu0v+ukxdHXNmWeIeAD9Djy5lkyTcI92IdqR+iRx6RL06ffapO7GsdtdbGKN7IIIW+fk2BHtB00zPCHGM6AACZri50oYuoa3pUhr0VQBpzzmDgomUAZ2YfktQlfM0t6VpyKvmQngjVCogdldnFD0nn7ZNs/yadYHWZJGcvQxCnBfHVBDP0HcLEP0vquKS7JdPgSsT5Jkj4pmoGhcUh/8pxjbQHmveAsqW0IQilzckzA7hvo8Gr1rvPj7E8W1Cq9Gmvqg==
Received: from PH0PR02MB7384.namprd02.prod.outlook.com (2603:10b6:510:12::12)
 by MWHPR02MB10596.namprd02.prod.outlook.com (2603:10b6:303:281::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.31; Tue, 15 Apr
 2025 09:20:49 +0000
Received: from PH0PR02MB7384.namprd02.prod.outlook.com
 ([fe80::6bd7:e8f0:596a:4842]) by PH0PR02MB7384.namprd02.prod.outlook.com
 ([fe80::6bd7:e8f0:596a:4842%3]) with mapi id 15.20.8632.030; Tue, 15 Apr 2025
 09:20:49 +0000
Message-ID: <14f644e9-aa8a-45b0-9d0a-972d72345409@nutanix.com>
Date: Tue, 15 Apr 2025 14:50:39 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] QIOChannelSocket: Flush zerocopy socket error queue on
 sendmsg failure due to ENOBUF
Content-Language: en-GB
To: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org
Cc: berrange@redhat.com, peterx@redhat.com, leobras@redhat.com
References: <20250403082121.366851-1-manish.mishra@nutanix.com>
 <871ptuhla6.fsf@suse.de>
From: Manish <manish.mishra@nutanix.com>
In-Reply-To: <871ptuhla6.fsf@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PEPF00000179.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c04::44) To PH0PR02MB7384.namprd02.prod.outlook.com
 (2603:10b6:510:12::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7384:EE_|MWHPR02MB10596:EE_
X-MS-Office365-Filtering-Correlation-Id: 31082e2b-b27e-43e2-69f9-08dd7bfecf70
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|52116014|376014|10070799003; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?b3BPNXl1MmtlK0c4TnZCejJlOE9tNVlqdmV6ZWliNGRMNDdOc3ZKQUE4bDVV?=
 =?utf-8?B?dnUvL3pOemhITDM1K214ZEdhRzFQQjNpZlJTQmMvZVRZRXV3ditLQUg4WGJY?=
 =?utf-8?B?aGVQdWlGZlRjUzRjS0h3NDV6ZTArY2tGSjF5T3BMNjJseEFrMkRmZkdpSWZY?=
 =?utf-8?B?SGluZzdLYkdDbHVpN1VxUlZ4VUhuRk5HVVRuZDR5YXBsUCtWc2N4RldaeTZV?=
 =?utf-8?B?WnFhd1lodksyVGxHNUQwcjU4a2djVXNkUk5DNVFZbEFxcUxaNkVTMEw1L3E5?=
 =?utf-8?B?Y1c2ZmZnYXNqOURQaVpzbFNkQ1U5Mytrb0krNUVxOXZVM253V3RXcWpwcmt1?=
 =?utf-8?B?di9YeHozaldVblZyaXpTY0lOMnY4ek9ONjdOVXIwUDZZMitnSmdoZDdoQnph?=
 =?utf-8?B?YnJ2cXhxNWpXZUFDUUdxTWkvYldVQUkrQmNBcXlRMTVMaTBSenp0QlZPRzI1?=
 =?utf-8?B?WVFtNEl3dWx4QmZJaS92THlBMnZJM1ZtZXlONnhxRk5JUE1Fdk9HTlkvNVdJ?=
 =?utf-8?B?T24yUUZoZ1JhMnlBVW1ab3dENENrNXMrcmpHTCtyaHBva2h1TGV0Lzd4RWox?=
 =?utf-8?B?ZENqOFMyNDhpTkRkVDAwTmdkaEZ4R0VMM0o5NGpYclI2TlRMOE5SK2J3R2dJ?=
 =?utf-8?B?QXBQdnZ4Mi9pbk1aVVY2aTdJa2M1YWFzMFpWQUkyTTllTUJTd3hxWWZ3Skpl?=
 =?utf-8?B?SUp1blRQRm5qczZSNWk2S2k5MzVKcWptU3N0K2xTbTkyMTBWTVJKVXBHZys2?=
 =?utf-8?B?QXlqUHNsRC9zYTZVZU5wa2YwbzV3TkhEajJOR0VrUEVvS0ZGeDZYTVFRaWhD?=
 =?utf-8?B?MlJkRjZKRE8xUDF5VjVRSjVmQXd3bXJZZlE1UFJFZTRyZFVueCtKdTY1Y0Yx?=
 =?utf-8?B?TkZRRkVKRXVGbGdNUGxtK0dtb0d0SzMvNVZEdDlZcmM3ZHpLYUlnV080d084?=
 =?utf-8?B?T09nNUhPdjFFcWJLYjJuNkRJRkRjb3gyZkJIK1VOVURQOFdLQithV0tGK3Qr?=
 =?utf-8?B?OGlyb0p2d0ZBUU5NUlJTczllU1l2L0lXMW5tbGNtZlB6cFpiV2I2SUg3ckdr?=
 =?utf-8?B?ZzVscTNhWVNyblZDMTlNUmphTm5CWWgwWmE5NlRWc3BRS1F5b3EzNnYyYU5t?=
 =?utf-8?B?cmlhSjA5cGk3RndneFF6bnV4ZVhURGlTTm5OQm9pa0hXbkFMeEt0Um80MTcv?=
 =?utf-8?B?NlkwR2kvWlB4ZTFsS2k1V0RiTkRiMVY5bnY0S2hCZXBDaDdQL1JyV1NTN3Iw?=
 =?utf-8?B?VkdtbWZFWlY3ZzJhZXNSb1ZoNkxLbGZxbS9BaWlidTJ0aGgyWjVVTlVqSklK?=
 =?utf-8?B?aXBENlBGcGpJRWluM3Z3SldMdW9GNTlRaUN3dk50ZFRIcUVPelN0MU8wNnhU?=
 =?utf-8?B?U3VyT091QUJzakF2T2FWbklpN3ZrR0RHL1VaWFlubVhneXRPSENDOW5kbjZ0?=
 =?utf-8?B?RWR3SHVRLytDazlmR2V2REFWb1I5VEhEUUd4RU12VC9vWUxQZkJxVHNmTFFR?=
 =?utf-8?B?NFZoWU1uOGFIYThJbDlad1J2R21RMEQwVUNkUmtQbWRjMW9MWmpGZXVvcHkw?=
 =?utf-8?B?VE5EcThTU2RwVlJLc2pCOU45OTcyZkpBbnE5QU10UmpJNEl6QUhYOFV2V3BF?=
 =?utf-8?B?ZHVqT09ndzhuWDRCejczVmhSb0NEVmhlZHMrYlZLbno1NiswUlluOE9rQTh1?=
 =?utf-8?B?WG5TaW5pVlBPQXpaVUljZWtxN25aZTc4WEdzRnlKSTBGN1RXa3lBcFVaVEJO?=
 =?utf-8?B?VTVTeHlCcld2bHYvbjV0elA5T1ZvS2Y5K1hJZk5ESHppRWNiSTdjVHVHVFRx?=
 =?utf-8?Q?U+sXL/nXInIA2EvZiz0WwrEKhEOmVnP4Q8Rcs=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7384.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(52116014)(376014)(10070799003); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YUdEUm1VRVBVMzNibFFad3pYV1VuRDdVZWU2NVZ1czVUOStHazFxTHAvbGxh?=
 =?utf-8?B?K0ZGbm1rRzNGUmhwM1BrTldLNjdSMDBFTHhKNjNVcSs1SlViZ2JER0h3bmJL?=
 =?utf-8?B?MndISy9ld3dldzRMZG5DTDlaa2FXd3Q4cGUwdFkwRW5BM2YvVTRWMzVJdmUz?=
 =?utf-8?B?Rk43YnJScVErOXBoaTFPYU1UTW1IWGtXMVlBbXpKNU1rSEdrWnJoTGNQS1hU?=
 =?utf-8?B?blkwS2I3UmV2UGc1anBMekoxWk85aDBmU2c0M1lIZXFCS212NXJEc0tMTWZK?=
 =?utf-8?B?ZnZsbFVZVkJ0ek96ZkFiZkMxb0JMNlc1VjMvMGdReFpVc3FrUituRWpKOWxI?=
 =?utf-8?B?aXo0WEFRVUZ6RElmTUp5Rnp2aTJIRUZJSGoyZmJuOVhrUkNUUWFIOTdmbG16?=
 =?utf-8?B?NGhDNnE5b2ZvYmJHZXk3a01lOGlpRHBoSjJJNkxMd0Q4Yi9hWDhqYVFGRUxv?=
 =?utf-8?B?SGI4czR0eWxoVzlSVEE5bEVqQktFNlJuNkxZRDlCc1NJNWNlblErVnFjUVVZ?=
 =?utf-8?B?Q3hjZk52TmtuUHMwajZKYlZDREN1TmR6UUo5ZzhVWnVqSVExTXJxLzFWYk5X?=
 =?utf-8?B?ajdrbWpQOSttOHQ1TWdkUDhLeXhlNll2WFVwTDdINENZdENmRVRoT2tXY043?=
 =?utf-8?B?SDFUZzFNMWZqeXpjSjBIRWtoVG03V1NibWhyT3dmZnFxOVF6RGVMQTRxakdY?=
 =?utf-8?B?eEZtcjRrVGlMVk56c1ljTHZkWC8vL3Z6U2RVeGE5bVNMM0dnbWo2Y25tWC9W?=
 =?utf-8?B?bU1xYk1OaHZ1UUcyQTBLTmlZK1ZKaE5sYkRyZmV2WEhjNExNalBJcHdLYVJx?=
 =?utf-8?B?RDJ3QTdNZ3o5S1RtMk5xd3I0aFZSK1NhMlVyTk8vTTFGQU0zc3UwQnVXcDBL?=
 =?utf-8?B?YjB3NWx4anI1VVdXblQrUnFxeGpOazFrOHozYnc1azNnL0ZKT3Y0ZTR3bGln?=
 =?utf-8?B?d3lXTlNyYnhLOTI5bzlsNGZ0T3hYMWFJbyt2TVFtOFJvUktKRXJNS3ZtMnJh?=
 =?utf-8?B?ZWdRczdBVWxqSEdMVWtVelhrcXNKOVRJUTg0Y2VROHkxbEZERytIeVhINXl0?=
 =?utf-8?B?MTg0V1BLZzAxY1FBOUJxUzlaWU93RlBzWGlUZGh5a1hSSE4ySTZpeWV6Tndo?=
 =?utf-8?B?TTB4bEZLVGcrRldHc2d3UzlwNE54bU1YcmxTRlRCSlJRSExLUFFaVStHMkhW?=
 =?utf-8?B?ckVRSnRTVTZDU3JtTVdFV2NBQkpBNjVBTncya0ZxdGx0eFk2YTBMRUJoRy9i?=
 =?utf-8?B?amVleDkvMnNiSjh3YjlYSXFnenE5eXVtVFE1WVpYTjJqZXFHRGNiMFFhZitS?=
 =?utf-8?B?M04zcGozQkR2SGRNUWZVU0preGhxOEE3VnBlZ0s4c29md08rRmhVaDZqL1hR?=
 =?utf-8?B?WlVZaGxBR3QxNDlzK202V3pVY005am9XNWZneDlISHhJV1c0QS9VMVlVcC9L?=
 =?utf-8?B?THpkcXA4MnErSUI2VHlMQnExQ0k4MDNJRm9kckJvZ1RLVVg3aHVIZ0lSYmVI?=
 =?utf-8?B?d1pkUFMxb2grYTRsSk1Pc2Z1N2F5aS9XUXBKR01LYkg4WUhKRHFuRlNPclFY?=
 =?utf-8?B?NXIvSWwyVERWZHRYcm5XL0t4dWZWd1lrejFUYmxreHZBeGJ0WWdsQVpyV0VW?=
 =?utf-8?B?M25nZEhCL29vVUVHbjMzQzRqUmxvaEVpWWFvL2RHWTNDb3ZqcWRzaGJyQ081?=
 =?utf-8?B?Ly9lY1JTb1p5SG5VVEQySmlTZjdDOVpHK3pEaUxaSHpMUEM0cDNDaVc4L0tM?=
 =?utf-8?B?c0I1WlFpdlBRWnJFL1dIYTdzMTdoaDNWeGljOTNLcWZ0RnRJbVhJYkIvd2Nw?=
 =?utf-8?B?Q2tlWG5kTkJUcDNCSGQ5eUZkOXpaVFVUejB4N1J6aGpFTW9ibGJIV1dyWFJz?=
 =?utf-8?B?RGNHV3Yxay9oVDlCTkN4bng4ZHp4dVh3Wm4wRjRHK21IWm1CLy92dHpmZERQ?=
 =?utf-8?B?Z2pKSDBLT0VTK2ZHTnRPRzR0S05PbXZPNFR0bk5zczFUMEtoZElORHdZZkRI?=
 =?utf-8?B?ZGZObkpsaEM3c2hoaG5HNWRaQ1N4SVJMVWNKUUM1TTV0QXpVRjl6UU11YTFF?=
 =?utf-8?B?TWhKeXVZM0twUUExVDFaMlpVRE04d2FOcUwvYWdNQWhsYnozdVVUYmVHelI4?=
 =?utf-8?B?NjEvQ2dhTGhlQ0lTVlpjSGFWS2o2MHo3SVA4NGZ6bFkvRDVUcWNPZ1RVUG5D?=
 =?utf-8?B?Rm4vaWxLMWd6Wm9HUGlWNkVDM0wvVVlqMFcrZjduYy85WXJLU0NIZjcyZ28y?=
 =?utf-8?B?Sk5KMUNjNi9BM1JEVy9PMUczc2lRPT0=?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31082e2b-b27e-43e2-69f9-08dd7bfecf70
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7384.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2025 09:20:49.2379 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WghzhkuvDLxQI+HZUCrCxRadvm05qUj7kcKXlk50me7rFtqiwoHyBg7xm2lnHflh46eLdxHG6uSYUnOMsEl+EDLxTWzdB7MMcXsn3w2qozU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR02MB10596
X-Proofpoint-GUID: -P4IAWomxRIHjtL5LxBxVsw4mdNBuPJr
X-Authority-Analysis: v=2.4 cv=RK2zH5i+ c=1 sm=1 tr=0 ts=67fe24f5 cx=c_pps
 a=dnQYvCYIB+Ymp8NUOuD+qQ==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=XR8D0OoHHMoA:10 a=0kUYKlekyDsA:10 a=VwQbUJbxAAAA:8 a=64Cc0HZtAAAA:8
 a=FbYyvjo7L_R3UwzLoWwA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: -P4IAWomxRIHjtL5LxBxVsw4mdNBuPJr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-15_04,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=manish.mishra@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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


On 14/04/25 7:56 pm, Fabiano Rosas wrote:
> !-------------------------------------------------------------------|
>    CAUTION: External Email
>
> |-------------------------------------------------------------------!
>
> Manish Mishra <manish.mishra@nutanix.com> writes:
>
>> We allocate extra metadata SKBs in case of a zerocopy send. This metadata
>> memory is accounted for in the OPTMEM limit. If there is any error while
>> sending zerocopy packets or if zerocopy is skipped, these metadata SKBs are
>> queued in the socket error queue. This error queue is freed when userspace
>> reads it.
>>
>> Usually, if there are continuous failures, we merge the metadata into a single
>> SKB and free another one. As a result, it never exceeds the OPTMEM limit.
>> However, if there is any out-of-order processing or intermittent zerocopy
>> failures, this error chain can grow significantly, exhausting the OPTMEM limit.
>> As a result, all new sendmsg requests fail to allocate any new SKB, leading to
>> an ENOBUF error. Depending on the amount of data queued before the flush
>> (i.e., large live migration iterations), even large OPTMEM limits are prone to
>> failure.
>>
>> To work around this, if we encounter an ENOBUF error with a zerocopy sendmsg,
>> we flush the error queue and retry once more.
>>
>> Signed-off-by: Manish Mishra <manish.mishra@nutanix.com>
>> ---
>>   include/io/channel-socket.h |  5 +++
>>   io/channel-socket.c         | 74 ++++++++++++++++++++++++++++++-------
>>   2 files changed, 65 insertions(+), 14 deletions(-)
>>
>> V2:
>>    1. Removed the dirty_sync_missed_zero_copy migration stat.
>>    2. Made the call to qio_channel_socket_flush_internal() from
>>       qio_channel_socket_writev() non-blocking.
>>
>> V3:
>>    1. Add the dirty_sync_missed_zero_copy migration stat again.
>>
>> V4:
>>    1. Minor nit to rename s/zero_copy_flush_pending/zerocopy_flushed_once.
>>
>> diff --git a/include/io/channel-socket.h b/include/io/channel-socket.h
>> index ab15577d38..2c48b972e8 100644
>> --- a/include/io/channel-socket.h
>> +++ b/include/io/channel-socket.h
>> @@ -49,6 +49,11 @@ struct QIOChannelSocket {
>>       socklen_t remoteAddrLen;
>>       ssize_t zero_copy_queued;
>>       ssize_t zero_copy_sent;
>> +    /**
>> +     * This flag indicates whether any new data was successfully sent with
>> +     * zerocopy since the last qio_channel_socket_flush() call.
>> +     */
>> +    bool new_zero_copy_sent_success;
>>   };
>>   
>>   
>> diff --git a/io/channel-socket.c b/io/channel-socket.c
>> index 608bcf066e..d5882c16fe 100644
>> --- a/io/channel-socket.c
>> +++ b/io/channel-socket.c
>> @@ -37,6 +37,12 @@
>>   
>>   #define SOCKET_MAX_FDS 16
>>   
>> +#ifdef QEMU_MSG_ZEROCOPY
>> +static int qio_channel_socket_flush_internal(QIOChannel *ioc,
>> +                                             bool block,
>> +                                             Error **errp);
>> +#endif
>> +
>>   SocketAddress *
>>   qio_channel_socket_get_local_address(QIOChannelSocket *ioc,
>>                                        Error **errp)
>> @@ -65,6 +71,7 @@ qio_channel_socket_new(void)
>>       sioc->fd = -1;
>>       sioc->zero_copy_queued = 0;
>>       sioc->zero_copy_sent = 0;
>> +    sioc->new_zero_copy_sent_success = FALSE;
>>   
>>       ioc = QIO_CHANNEL(sioc);
>>       qio_channel_set_feature(ioc, QIO_CHANNEL_FEATURE_SHUTDOWN);
>> @@ -566,6 +573,7 @@ static ssize_t qio_channel_socket_writev(QIOChannel *ioc,
>>       size_t fdsize = sizeof(int) * nfds;
>>       struct cmsghdr *cmsg;
>>       int sflags = 0;
>> +    bool zerocopy_flushed_once = FALSE;
>>   
>>       memset(control, 0, CMSG_SPACE(sizeof(int) * SOCKET_MAX_FDS));
>>   
>> @@ -612,9 +620,25 @@ static ssize_t qio_channel_socket_writev(QIOChannel *ioc,
>>               goto retry;
>>           case ENOBUFS:
>>               if (flags & QIO_CHANNEL_WRITE_FLAG_ZERO_COPY) {
>> -                error_setg_errno(errp, errno,
>> -                                 "Process can't lock enough memory for using MSG_ZEROCOPY");
>> -                return -1;
>> +                /**
>> +                 * Socket error queueing may exhaust the OPTMEM limit. Try
>> +                 * flushing the error queue once.
>> +                 */
>> +                if (!zerocopy_flushed_once) {
>> +                    ret = qio_channel_socket_flush_internal(ioc, false, errp);
> I'm not following this closely so I might have missed some disussion,
> but let me point out that the previous version had a comment regarding
> hardcoding 'false' here that I don't see addressed nor any comments
> explaining why it wasn't addressed.

Hi Fabiano, I did reply to that in last comment for v3. Please let me 
know if that does not make sense. 
https://lore.kernel.org/all/c7a86623-db04-459f-afd5-6a318475bb92@nutanix.com/T/


>
>> +                    if (ret < 0) {
>> +                        error_setg_errno(errp, errno,
>> +                                         "Zerocopy flush failed");
>> +                        return -1;
>> +                    }
>> +                    zerocopy_flushed_once = TRUE;
>> +                    goto retry;
>> +                } else {
>> +                    error_setg_errno(errp, errno,
>> +                                     "Process can't lock enough memory for "
>> +                                     "using MSG_ZEROCOPY");
>> +                    return -1;
>> +                }
>>               }
>>               break;
>>           }
>> @@ -725,8 +749,9 @@ static ssize_t qio_channel_socket_writev(QIOChannel *ioc,
>>   
>>   
>>   #ifdef QEMU_MSG_ZEROCOPY
>> -static int qio_channel_socket_flush(QIOChannel *ioc,
>> -                                    Error **errp)
>> +static int qio_channel_socket_flush_internal(QIOChannel *ioc,
>> +                                             bool block,
>> +                                             Error **errp)
>>   {
>>       QIOChannelSocket *sioc = QIO_CHANNEL_SOCKET(ioc);
>>       struct msghdr msg = {};
>> @@ -734,7 +759,6 @@ static int qio_channel_socket_flush(QIOChannel *ioc,
>>       struct cmsghdr *cm;
>>       char control[CMSG_SPACE(sizeof(*serr))];
>>       int received;
>> -    int ret;
>>   
>>       if (sioc->zero_copy_queued == sioc->zero_copy_sent) {
>>           return 0;
>> @@ -744,16 +768,19 @@ static int qio_channel_socket_flush(QIOChannel *ioc,
>>       msg.msg_controllen = sizeof(control);
>>       memset(control, 0, sizeof(control));
>>   
>> -    ret = 1;
>> -
>>       while (sioc->zero_copy_sent < sioc->zero_copy_queued) {
>>           received = recvmsg(sioc->fd, &msg, MSG_ERRQUEUE);
>>           if (received < 0) {
>>               switch (errno) {
>>               case EAGAIN:
>> -                /* Nothing on errqueue, wait until something is available */
>> -                qio_channel_wait(ioc, G_IO_ERR);
>> -                continue;
>> +                if (block) {
>> +                    /* Nothing on errqueue, wait until something is
>> +                     * available.
>> +                     */
>> +                    qio_channel_wait(ioc, G_IO_ERR);
>> +                    continue;
>> +                }
>> +                return 0;
>>               case EINTR:
>>                   continue;
>>               default:
>> @@ -791,13 +818,32 @@ static int qio_channel_socket_flush(QIOChannel *ioc,
>>           /* No errors, count successfully finished sendmsg()*/
>>           sioc->zero_copy_sent += serr->ee_data - serr->ee_info + 1;
>>   
>> -        /* If any sendmsg() succeeded using zero copy, return 0 at the end */
>> +        /* If any sendmsg() succeeded using zero copy, mark zerocopy success */
>>           if (serr->ee_code != SO_EE_CODE_ZEROCOPY_COPIED) {
>> -            ret = 0;
>> +            sioc->new_zero_copy_sent_success = TRUE;
>>           }
>>       }
>>   
>> -    return ret;
>> +    return 0;
>> +}
>> +
>> +static int qio_channel_socket_flush(QIOChannel *ioc,
>> +                                    Error **errp)
>> +{
>> +    QIOChannelSocket *sioc = QIO_CHANNEL_SOCKET(ioc);
>> +    int ret;
>> +
>> +    ret = qio_channel_socket_flush_internal(ioc, true, errp);
>> +    if (ret < 0) {
>> +        return ret;
>> +    }
>> +
>> +    if (sioc->new_zero_copy_sent_success) {
>> +        sioc->new_zero_copy_sent_success = FALSE;
>> +        return 0;
>> +    }
>> +
>> +    return 1;
>>   }
>>   
>>   #endif /* QEMU_MSG_ZEROCOPY */


Thanks

Manish Mishra


