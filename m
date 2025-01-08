Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82503E77199
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2025 11:57:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVUdT-0006TA-Cw; Wed, 08 Jan 2025 06:54:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1tVUdH-0006RG-Iq
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 06:53:55 -0500
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1tVUdC-0002F6-IW
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 06:53:53 -0500
Received: from pps.filterd (m0127842.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5087vts8007169;
 Wed, 8 Jan 2025 03:53:49 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=cZiJP88qlQLTQpmiOnVzHbOcsIU7PmhGTdhYzTdgO
 Rw=; b=XrSorF9RwYQarJ49q/kGA9qAB91T7irtIA2COXRho3D6uRttKD+q3Xyry
 hUMhBkd5obiB2/ADQyz0XSQLGUgAFrRRAOmgfQlOFZkPhLviZFckdIAgYyjACPii
 rijhxcfQ0HccWXd+l8zoLUg5ZQLLaM8ivycnYXiotLPa/9yLQPCl7f2yZOoRnvtX
 6zSODgtgbpE6JzQg9SexfNYEA6DHOnMQ5hpwMVPzRKYU9KuzVJh6NHkI0FHLLAaL
 wuXqNNaKkRz3/GnGN1eTCUkVDjh+D2gsXfDDL1qxpN7hieHiROAXRXSpjMq2uo8w
 +/CIeTiUGgP5k9En1NPvy4M+Kb9hg==
Received: from nam04-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam04lp2048.outbound.protection.outlook.com [104.47.73.48])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 43y56eryxp-4
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 08 Jan 2025 03:53:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p/76y5quWiW6tRkAb8pIuRTiHthB2rVZqHm7QQZGtaZrb3SNz4y1W/A3siw9/nMDmz0PIWpwLYZJEW67zC5Bbx03vx7KLp5Bu6r0bHWHak+HA7TKnCCHTqlRPIPznb7zpUNi1FoKYA5uY6GyywgLT5UnLd1FVROGBdiUen0IXvJief4Wx/pGbjLknj7yspRZ20gT5oh7yppvYc8y1EvCn17gcwKExsW6M9PyFX1u5RuVvA7OR2DdTZ62n6w2JPf1JPGVoi4Wl6eN9l2rSBHa/ssgixdF1VKxYaaSG236GoS5XGSMksuVKsKzXh1Aq0lS36qVmPMaO7xbToH2RVwHAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cZiJP88qlQLTQpmiOnVzHbOcsIU7PmhGTdhYzTdgORw=;
 b=Q1L1rpL7kf1YBtWIUoD9AmLM3t3IPZDji/libiVqMHpVRA0yd1PqiuvWwUeBs2SiHs4bEEcW/ZsIqQHTtlpTUA5gI7VUtbwmXUZy3qLxcRcWxLWRdAzlqQWpWI4Ro3yYkoXMSM8KGnYFUnvDo3AB2/7cDMg6Elt/6VSGafifMevw7HulNuMpPkgj3j9Wccg8TK9a/8JeSsiCTp3GJq1fRY1gArpJKMxQcf5hmcHxwNaQlc9ksSjHD6QF2qXnqWFBiXQhknyBoulwg61nAAN7MEiv59zJxcrEoB7isaTGxSi7vizJFQoqoJZtVQ2NNDyNCy2XcUvbGoZXUMH4Nm9xnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cZiJP88qlQLTQpmiOnVzHbOcsIU7PmhGTdhYzTdgORw=;
 b=qvi8/IwFi0ogebVSNS0FWYqG0MeIzfAGQW5KmgaukPa3zJnZZdP68cUw8yMiHIzj9szAqNGOVbgVSBCjndeVtQRLYyjMKj8yV8m3Bqsi6MYH5RfR8hZ+UQpr3FlUM/mBanTsFpinAZ3HYdYyDggJNol+n4CvF/xJWnTGxn/AH/j6d3aKZdIJLr9IDgjG7YIRBOeFBOAlCgA9w1oxPhsTAvDBduPsNDOeQgi26QCQhLMy1JDvn1bcQHx6SADBFsmr08HVHeUE2Nk9sldTdIanQ0ft3r4b73/hLdgGjnAL9uSys1qv7ME72fJA2T19I/54T1zJ12ZfDkkz9ltHJk/4VQ==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by SJ0PR02MB7502.namprd02.prod.outlook.com (2603:10b6:a03:2a2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.11; Wed, 8 Jan
 2025 11:53:45 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51%4]) with mapi id 15.20.8335.010; Wed, 8 Jan 2025
 11:53:45 +0000
From: John Levon <john.levon@nutanix.com>
To: qemu-devel@nongnu.org
Cc: elena.ufimtseva@oracle.com, alex.williamson@redhat.com, clg@redhat.com,
 jag.raman@oracle.com, thanos.makatos@nutanix.com
Subject: [PATCH 12/26] vfio-user: define socket receive functions
Date: Wed,  8 Jan 2025 11:50:18 +0000
Message-Id: <20250108115032.1677686-13-john.levon@nutanix.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250108115032.1677686-1-john.levon@nutanix.com>
References: <20250108115032.1677686-1-john.levon@nutanix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS4P189CA0066.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:659::14) To CH2PR02MB6760.namprd02.prod.outlook.com
 (2603:10b6:610:7f::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR02MB6760:EE_|SJ0PR02MB7502:EE_
X-MS-Office365-Filtering-Correlation-Id: 6042a6f1-6e0e-46a1-dbc7-08dd2fdb1acc
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?c1JjcWlHVmJxOHFWMXpyeXlsWUJabTAvN2NEa3g4eDczdGZ0dWlQcStWdDBn?=
 =?utf-8?B?blJpbVhHV2piVVREUEloTG1aZnlnYTVVYUZCb0ovbnh2TlRkZ1BoVUwyT3Zq?=
 =?utf-8?B?Nk1jMEoyYnJPVkVRTlFsRTdzMnBodW5zNjIwOFQxTFFESXZHYXg0S256S1pB?=
 =?utf-8?B?SlYxU3dJeUwzdW9vL21yQitDYjg0RElNaTMzbHNMSFpRYkJOWncvS25zY3pY?=
 =?utf-8?B?UXIveEpsWUtteHVjeENBZWduR0JvZWQzS3ZUcDg0Y3NIblRsWXRTZ0dqMmFx?=
 =?utf-8?B?RkY3Z0NlSU8zcFIxWjRiYmE0cWJMTktYVzErWWsvRnlyYmhYOFdXUUJPcXdZ?=
 =?utf-8?B?MEtjMmtFcEEzRlpPRU9PUjlwZ08ra2h3S3pteE9TaUo3SEx6dDUrQ1o5U0Zl?=
 =?utf-8?B?cGRocTRpbERIQVR0TVZET0hNZHc3YWpFN2FIYUV2cFF1aGFLQWFLWVEvdTVT?=
 =?utf-8?B?WjJpOUMrRzI5aXA1VGVSay84dXJBb0Y5Vm1GQzRaNDRjVGtheWVZWDl3enhw?=
 =?utf-8?B?RDBGTkRHRTZ1Q3VLN2hIb25yKytDV0ZpSVNuMFhVOW84N3o1bHdhZnVnMlBB?=
 =?utf-8?B?czV3VUpxeEthZ3Z4OE5yVDRZZjA3YXJER2N6em1PWmVPRW5CdGhHTGl2L1l1?=
 =?utf-8?B?bTB4MDkwWFphVnFOZXM2N2Y4ZzhneDZ4ak9DUmc2emh2L1pyZm0wK0FKUktu?=
 =?utf-8?B?U1dkVHBmcFhBYVh6em1FNmswTjJNS0N1YlY1T1pxUmQzTTNjV2xXcDVwaFJ4?=
 =?utf-8?B?cTV2U0dGdzhEYlpDa0ZTL1lBaTByakNaMkNvRFlBRFdvbDUvZFlVTUkwNFh0?=
 =?utf-8?B?K0FmQmlFQWp4TEgzWmJSdWtOZmdKUUcrSGZOTjNSRzUzVFRWY1d1SHZMWlNQ?=
 =?utf-8?B?aDNwcWt2VFZvUkhPU0hYclp0c3A2Njd6WXdZWXRMajdpVzNmWG1mZGNRQnli?=
 =?utf-8?B?V205MFd0OUs4NEZ2a1JMc2pqWkRBeHkvVG0zWklqclFMeG02S0sxK255Vm1u?=
 =?utf-8?B?SUdnOUI1M252ZDdwa2NiOXkrUU9EWUpGREpuSndiOFE3K0dTMFJxMVJWL3lV?=
 =?utf-8?B?d3N0dVBzSDc5RnhPRDhxOWViUmUvQytSQXZzWG45K24rbElmd2hSZG1MZnNQ?=
 =?utf-8?B?aEg0RGlHRE10U0Y2OXcvUHlWNUNNRlZmQ3ViLzBLbHdJNE4wcWgyZ1pqemlh?=
 =?utf-8?B?VEVXTzhlbVhIbk0vWkl3TUpDTHA2SVdwRXAvSU5lLytHRU9IY2VWSi9RU3NC?=
 =?utf-8?B?UFA5bzR4U0xiZUtPb1BzMGhBZVNhUEk4bVdjSEd4YVljL0Y2bXJBcHMydjE4?=
 =?utf-8?B?YUxnZHI4MmRzT2FKZkR6NUE3SVFCNGx0b0JhQ1RPZGswbzJFdHNQb3lhRXhB?=
 =?utf-8?B?dkVVTkRkQkxrdjZUUXVyRU5XTzFUb2dTKzA2Q2VDZVFXblVDaThpZXViVTlI?=
 =?utf-8?B?U3dFbkRHMHo2clBnSE1VU2hQTHdMemRCR2cxMzNNd3drWlRzR0pqN1lCWDE1?=
 =?utf-8?B?ZWJlcEpiK1VDYThac2Q3Tm5NZVptNStxdFZmTm1Ob2JzbDFzWHhGZ3czZXJx?=
 =?utf-8?B?U3laS0xGVThuUytEdGtxdENDazdWeW0wTEpQSWVaWkNRRzhYZExYNWxUREdm?=
 =?utf-8?B?NEt5eEdPaEx1WUZJZ1RKL1BIcWFWamN2OEo4aGRqMWorU0ZlTnZCOU5mcDZV?=
 =?utf-8?B?djlPWWs3VGduL0szQzdSclppejhCWTV2OU9yOGJKMnhiV0paUk1MTnB3VWg2?=
 =?utf-8?B?Y0pNVlJDeDdiUEU5dUZ2M3ZwdmZHLy9oendpQlVsNFBpcGdmVDl3ejFLUGFE?=
 =?utf-8?B?VEl4d1htUGg0T0tSNVEwTmxiTkVzRWR1cEVFMm13c201MUpqR1lSVk1wUUxW?=
 =?utf-8?Q?WrkJL/+t46eF6?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Qld4NnVqUjFPc0FJa2Uwd2VWeWVlcEFiaFBVTVVpeExzR25Uc1IwWFN3VEtK?=
 =?utf-8?B?aVhLTlozTmthTTFrS3crYm9xTEIwSFNmcy9RcmZUTG1od0NqR2JiT2ZNbWxq?=
 =?utf-8?B?eS9hc1ozN1c4TXlPcS9JR3R1bnI1UFVEZ1QraFNKcTRJWG41TG50LzBuVVpW?=
 =?utf-8?B?QzBNOURMeWRzQXMvMmhTakpxK0NQNXdCdVFqTVVCbElBV1NnVjVtWWcrSEx5?=
 =?utf-8?B?MHdGVFJ2eERQZDBkeVkyeE5Kb2ttTCtKT3FUQkliWGdhZk5yZG5OWmRBMWhi?=
 =?utf-8?B?bGF3Y00xUUhzaENZUWhRWi9CZ0pqdlByYVMrczZoQmtxbGxpS3BNSEY0SlIv?=
 =?utf-8?B?aC94bUJtR3RMNjhUbUhQOVRVSjBZN3p4cUxZVHpkdzQza2xRbUJZR24rV2xm?=
 =?utf-8?B?MzdlbjJFbW5wNzc4WUgxZW1vZUlFMVZLemN3QnVEQ0lzYnFvaUxEMmc1Umlp?=
 =?utf-8?B?c09JcHIxTVZtdjdzeHRkWVhXSGJRU0lWQ2RweFo3SzEzY3NwMUt4R1RYejZS?=
 =?utf-8?B?RGhBSTFNMlRuN2JvL0JGalNsYUJFRjBtbGpmM2NCSW1JbkhaYmJ0b3dyb2o1?=
 =?utf-8?B?aXdUTUdOZHhkV1E1S3YxbThpTzZrYUVBZjhqYmlCaC9JMk8yUS94TDgzbFhj?=
 =?utf-8?B?MVREOVNMcW1TUkJEZ3FPYUF3bmNPRzZHZlIrOHY3Mkp3ZG1MaGNTUUoyRXlw?=
 =?utf-8?B?S3lJVzBOVFUxR1dFV0FvUkc5MTdkU1BObzBpcFdSRHp0dTZCSHlTQzBaR0xU?=
 =?utf-8?B?YXpRNFMrUzUvQUg1THllTUE0Ym52S0haODEveUhGT0dtTWsvTWZlRWdyTktM?=
 =?utf-8?B?bWZyU3l0UkxBWGJXRDE5cno3alh6R0VnYVpUM2R0ZFZQRm53U1ZZczN4Sldl?=
 =?utf-8?B?YUo1QWtWSVBqUTEvODBzMzEyQTZ3T2Z2Q1kwbVQyeTBtaGFENXZBcktTVVhn?=
 =?utf-8?B?S3A2OXJvTnFBNWwyUk11S1JvbEZqdnkxbkp0TkZHc3lJb0J0N21lR0llaGw1?=
 =?utf-8?B?NUI3MUdvRTJRNTM2UGg5RnczZ3lQK29xdU9GZHRNY2NydzQvT2U2RWFZdjlY?=
 =?utf-8?B?NzVvNDBLQ0pTZktUYkZpaWw2L2hCN2tqKzR3QnFLeU03bHZ5R1R2NUdwcmsz?=
 =?utf-8?B?NWlEOWFDdmlvZEQwRzJOSE5zdmNDeWtRZ2xKT1JkaXBYWm4vc2JXa3N3VWlR?=
 =?utf-8?B?VU1CSmtjK29XcE92V0RDaHRUMEhDREU2LzNpQzZucGJXRW1Bdi8xcTRVV0pH?=
 =?utf-8?B?Y0VDRkU2Nk9WZEV3Mi9Oak9QQ24rZGxabm5YaTBwU1R1Q2doUUpHcmUrVTlm?=
 =?utf-8?B?bUFlc3Ywb1pkR3RIOFpQWkNySmNsdmZDeTVOOVI0MG1zMXpMaEZPRWhhQXdI?=
 =?utf-8?B?QklvYWcyODU4R2lTdzJxVUZ5TzA1WUxxTGNBV2UvVnE4SG44UUZtb2tCVEdN?=
 =?utf-8?B?SHEyeU5FZFpKYTZDNkpyajQvSnR1OXRvTm1WdkpCc3ZNTFNObnVsejd3cVVl?=
 =?utf-8?B?MEpxNyt3azRuRGdzSXZ5QlBvc3RhZmpMNjdLRm5xd2RybXFFRWczOXZGV0lQ?=
 =?utf-8?B?SE5UaDh0NmJQWldTSjlyUVQyRGRJS3hiOEVxTHgzUkRXc3I0dWswQmZrWWdx?=
 =?utf-8?B?SkFWZHlsaUpmeHdQZFRXb05BUXEvQmxDaEt1bm44RkZEV1MzNzZJczZsekxm?=
 =?utf-8?B?cU9qSUliZnFJNWhlbERwdm5FcU0zTDJub25oY3ZhTjd2MEVhdGRBVUxXenNX?=
 =?utf-8?B?THExOGxsbTJDMGtjaFNpaUhkTkdjV3NLRFY1d1pCMlJwU1U0L0Y2a1dlcHVG?=
 =?utf-8?B?VE1iM2Q5SXdJQ2JiMllyY3Ayby9ZRm5RczhFUUNZMGVvRDBQSlJrTGFIczR0?=
 =?utf-8?B?R0xsTjVZL2ZEWHAwQTV5b0RYMzN3RTE5VjUrdDVkeG5wck1YUzhmTy96SFYr?=
 =?utf-8?B?N0JHY3hQajBIYVhmQlo2dlVGTFNRbHpYYnpzbGUyVUY4V0V3V1grcE9PZUZn?=
 =?utf-8?B?OC9CcHkrV0NXT2RIV2t1dG1HaUZWcVhUV29hMkhmREVtbE1JZzVrSnJnMUp1?=
 =?utf-8?B?dGdCV1AwNzBLcUsrRXVweTRDMzUyTHB1YmVSc3RJWVE4Q1lsNG5pTnN4K2Q0?=
 =?utf-8?Q?OAOYGWQ75jLV31gZ2F2qIDp6J?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6042a6f1-6e0e-46a1-dbc7-08dd2fdb1acc
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2025 11:53:45.2889 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KToaY+CEToc6H2JsGNpcisw0lNkMBJDLph/VCSt4QDnKjHrbWBztNvQRmVnGTDCIiiJqJkZmewvjSOVoaEnIDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB7502
X-Authority-Analysis: v=2.4 cv=A6aWP7WG c=1 sm=1 tr=0 ts=677e674c cx=c_pps
 a=MHkl0I0wjNeC5ak5fNlPUA==:117 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=VdSt8ZQiCzkA:10 a=0034W8JfsZAA:10
 a=0kUYKlekyDsA:10 a=yPCof4ZbAAAA:8 a=64Cc0HZtAAAA:8 a=isiwTlKnufRvzBNuimkA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=14NRyaPF5x3gF6G45PvQ:22
X-Proofpoint-GUID: i3gusQ1N1ZG-hplGifrZSKRmFbT3uZIO
X-Proofpoint-ORIG-GUID: i3gusQ1N1ZG-hplGifrZSKRmFbT3uZIO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-08_02,2025-01-08_01,2024-11-22_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=john.levon@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.432,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

From: Jagannathan Raman <jag.raman@oracle.com>

Add infrastructure needed to receive incoming messages

Originally-by: John Johnson <john.g.johnson@oracle.com>
Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
Signed-off-by: John Levon <john.levon@nutanix.com>
---
 hw/vfio/trace-events    |   5 +
 hw/vfio/user-pci.c      |  11 ++
 hw/vfio/user-protocol.h |  54 ++++++
 hw/vfio/user.c          | 408 ++++++++++++++++++++++++++++++++++++++++
 hw/vfio/user.h          |  10 +
 5 files changed, 488 insertions(+)
 create mode 100644 hw/vfio/user-protocol.h

diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
index cab1cf1de0..0e3e7be10c 100644
--- a/hw/vfio/trace-events
+++ b/hw/vfio/trace-events
@@ -180,3 +180,8 @@ iommufd_cdev_fail_attach_existing_container(const char *msg) " %s"
 iommufd_cdev_alloc_ioas(int iommufd, int ioas_id) " [iommufd=%d] new IOMMUFD container with ioasid=%d"
 iommufd_cdev_device_info(char *name, int devfd, int num_irqs, int num_regions, int flags) " %s (%d) num_irqs=%d num_regions=%d flags=%d"
 iommufd_cdev_pci_hot_reset_dep_devices(int domain, int bus, int slot, int function, int dev_id) "\t%04x:%02x:%02x.%x devid %d"
+
+# user.c
+vfio_user_recv_hdr(const char *name, uint16_t id, uint16_t cmd, uint32_t size, uint32_t flags) " (%s) id 0x%x cmd 0x%x size 0x%x flags 0x%x"
+vfio_user_recv_read(uint16_t id, int read) " id 0x%x read 0x%x"
+vfio_user_recv_request(uint16_t cmd) " command 0x%x"
diff --git a/hw/vfio/user-pci.c b/hw/vfio/user-pci.c
index 7610b47163..b62fd4edef 100644
--- a/hw/vfio/user-pci.c
+++ b/hw/vfio/user-pci.c
@@ -41,6 +41,16 @@ struct VFIOUserPCIDevice {
     char *sock_name;
 };
 
+/*
+ * Incoming request message callback.
+ *
+ * Runs off main loop, so BQL held.
+ */
+static void vfio_user_pci_process_req(void *opaque, VFIOUserMsg *msg)
+{
+
+}
+
 /*
  * Emulated devices don't use host hot reset
  */
@@ -86,6 +96,7 @@ static void vfio_user_pci_realize(PCIDevice *pdev, Error **errp)
         return;
     }
     vbasedev->proxy = proxy;
+    vfio_user_set_handler(vbasedev, vfio_user_pci_process_req, vdev);
 
     vbasedev->name = g_strdup_printf("VFIO user <%s>", udev->sock_name);
     vbasedev->ops = &vfio_user_pci_ops;
diff --git a/hw/vfio/user-protocol.h b/hw/vfio/user-protocol.h
new file mode 100644
index 0000000000..d23877c958
--- /dev/null
+++ b/hw/vfio/user-protocol.h
@@ -0,0 +1,54 @@
+#ifndef VFIO_USER_PROTOCOL_H
+#define VFIO_USER_PROTOCOL_H
+
+/*
+ * vfio protocol over a UNIX socket.
+ *
+ * Copyright © 2018, 2021 Oracle and/or its affiliates.
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2.  See
+ * the COPYING file in the top-level directory.
+ *
+ * Each message has a standard header that describes the command
+ * being sent, which is almost always a VFIO ioctl().
+ *
+ * The header may be followed by command-specific data, such as the
+ * region and offset info for read and write commands.
+ */
+
+typedef struct {
+    uint16_t id;
+    uint16_t command;
+    uint32_t size;
+    uint32_t flags;
+    uint32_t error_reply;
+} VFIOUserHdr;
+
+/* VFIOUserHdr commands */
+enum vfio_user_command {
+    VFIO_USER_VERSION                   = 1,
+    VFIO_USER_DMA_MAP                   = 2,
+    VFIO_USER_DMA_UNMAP                 = 3,
+    VFIO_USER_DEVICE_GET_INFO           = 4,
+    VFIO_USER_DEVICE_GET_REGION_INFO    = 5,
+    VFIO_USER_DEVICE_GET_REGION_IO_FDS  = 6,
+    VFIO_USER_DEVICE_GET_IRQ_INFO       = 7,
+    VFIO_USER_DEVICE_SET_IRQS           = 8,
+    VFIO_USER_REGION_READ               = 9,
+    VFIO_USER_REGION_WRITE              = 10,
+    VFIO_USER_DMA_READ                  = 11,
+    VFIO_USER_DMA_WRITE                 = 12,
+    VFIO_USER_DEVICE_RESET              = 13,
+    VFIO_USER_DIRTY_PAGES               = 14,
+    VFIO_USER_MAX,
+};
+
+/* VFIOUserHdr flags */
+#define VFIO_USER_REQUEST       0x0
+#define VFIO_USER_REPLY         0x1
+#define VFIO_USER_TYPE          0xF
+
+#define VFIO_USER_NO_REPLY      0x10
+#define VFIO_USER_ERROR         0x20
+
+#endif /* VFIO_USER_PROTOCOL_H */
diff --git a/hw/vfio/user.c b/hw/vfio/user.c
index 1c79fb1cb9..1ab8e10739 100644
--- a/hw/vfio/user.c
+++ b/hw/vfio/user.c
@@ -24,11 +24,27 @@
 #include "io/channel-util.h"
 #include "system/iothread.h"
 #include "user.h"
+#include "trace.h"
 
 static IOThread *vfio_user_iothread;
 
 static void vfio_user_shutdown(VFIOUserProxy *proxy);
+static VFIOUserMsg *vfio_user_getmsg(VFIOUserProxy *proxy, VFIOUserHdr *hdr,
+                                     VFIOUserFDs *fds);
+static VFIOUserFDs *vfio_user_getfds(int numfds);
+static void vfio_user_recycle(VFIOUserProxy *proxy, VFIOUserMsg *msg);
 
+static void vfio_user_recv(void *opaque);
+static int vfio_user_recv_one(VFIOUserProxy *proxy);
+static void vfio_user_cb(void *opaque);
+
+static void vfio_user_request(void *opaque);
+
+static inline void vfio_user_set_error(VFIOUserHdr *hdr, uint32_t err)
+{
+    hdr->flags |= VFIO_USER_ERROR;
+    hdr->error_reply = err;
+}
 
 /*
  * Functions called by main, CPU, or iothread threads
@@ -41,10 +57,340 @@ static void vfio_user_shutdown(VFIOUserProxy *proxy)
                                    proxy->ctx, NULL, NULL);
 }
 
+static VFIOUserMsg *vfio_user_getmsg(VFIOUserProxy *proxy, VFIOUserHdr *hdr,
+                                     VFIOUserFDs *fds)
+{
+    VFIOUserMsg *msg;
+
+    msg = QTAILQ_FIRST(&proxy->free);
+    if (msg != NULL) {
+        QTAILQ_REMOVE(&proxy->free, msg, next);
+    } else {
+        msg = g_malloc0(sizeof(*msg));
+        qemu_cond_init(&msg->cv);
+    }
+
+    msg->hdr = hdr;
+    msg->fds = fds;
+    return msg;
+}
+
+/*
+ * Recycle a message list entry to the free list.
+ */
+static void vfio_user_recycle(VFIOUserProxy *proxy, VFIOUserMsg *msg)
+{
+    if (msg->type == VFIO_MSG_NONE) {
+        error_printf("vfio_user_recycle - freeing free msg\n");
+        return;
+    }
+
+    /* free msg buffer if no one is waiting to consume the reply */
+    if (msg->type == VFIO_MSG_NOWAIT || msg->type == VFIO_MSG_ASYNC) {
+        g_free(msg->hdr);
+        if (msg->fds != NULL) {
+            g_free(msg->fds);
+        }
+    }
+
+    msg->type = VFIO_MSG_NONE;
+    msg->hdr = NULL;
+    msg->fds = NULL;
+    msg->complete = false;
+    QTAILQ_INSERT_HEAD(&proxy->free, msg, next);
+}
+
+static VFIOUserFDs *vfio_user_getfds(int numfds)
+{
+    VFIOUserFDs *fds = g_malloc0(sizeof(*fds) + (numfds * sizeof(int)));
+
+    fds->fds = (int *)((char *)fds + sizeof(*fds));
+
+    return fds;
+}
+
 /*
  * Functions only called by iothread
  */
 
+/*
+ * Process a received message.
+ */
+static void vfio_user_process(VFIOUserProxy *proxy, VFIOUserMsg *msg,
+                              bool isreply)
+{
+
+    /*
+     * Replies signal a waiter, if none just check for errors
+     * and free the message buffer.
+     *
+     * Requests get queued for the BH.
+     */
+    if (isreply) {
+        msg->complete = true;
+        if (msg->type == VFIO_MSG_WAIT) {
+            qemu_cond_signal(&msg->cv);
+        } else {
+            if (msg->hdr->flags & VFIO_USER_ERROR) {
+                error_printf("vfio_user_process: error reply on async ");
+                error_printf("request command %x error %s\n",
+                             msg->hdr->command,
+                             strerror(msg->hdr->error_reply));
+            }
+            /* youngest nowait msg has been ack'd */
+            if (proxy->last_nowait == msg) {
+                proxy->last_nowait = NULL;
+            }
+            vfio_user_recycle(proxy, msg);
+        }
+    } else {
+        QTAILQ_INSERT_TAIL(&proxy->incoming, msg, next);
+        qemu_bh_schedule(proxy->req_bh);
+    }
+}
+
+/*
+ * Complete a partial message read
+ */
+static int vfio_user_complete(VFIOUserProxy *proxy, Error **errp)
+{
+    VFIOUserMsg *msg = proxy->part_recv;
+    size_t msgleft = proxy->recv_left;
+    bool isreply;
+    char *data;
+    int ret;
+
+    data = (char *)msg->hdr + (msg->hdr->size - msgleft);
+    while (msgleft > 0) {
+        ret = qio_channel_read(proxy->ioc, data, msgleft, errp);
+
+        /* error or would block */
+        if (ret <= 0) {
+            /* try for rest on next iternation */
+            if (ret == QIO_CHANNEL_ERR_BLOCK) {
+                proxy->recv_left = msgleft;
+            }
+            return ret;
+        }
+        trace_vfio_user_recv_read(msg->hdr->id, ret);
+
+        msgleft -= ret;
+        data += ret;
+    }
+
+    /*
+     * Read complete message, process it.
+     */
+    proxy->part_recv = NULL;
+    proxy->recv_left = 0;
+    isreply = (msg->hdr->flags & VFIO_USER_TYPE) == VFIO_USER_REPLY;
+    vfio_user_process(proxy, msg, isreply);
+
+    /* return positive value */
+    return 1;
+}
+
+static void vfio_user_recv(void *opaque)
+{
+    VFIOUserProxy *proxy = opaque;
+
+    QEMU_LOCK_GUARD(&proxy->lock);
+
+    if (proxy->state == VFIO_PROXY_CONNECTED) {
+        while (vfio_user_recv_one(proxy) == 0) {
+            ;
+        }
+    }
+}
+
+/*
+ * Receive and process one incoming message.
+ *
+ * For replies, find matching outgoing request and wake any waiters.
+ * For requests, queue in incoming list and run request BH.
+ */
+static int vfio_user_recv_one(VFIOUserProxy *proxy)
+{
+    VFIOUserMsg *msg = NULL;
+    g_autofree int *fdp = NULL;
+    VFIOUserFDs *reqfds;
+    VFIOUserHdr hdr;
+    struct iovec iov = {
+        .iov_base = &hdr,
+        .iov_len = sizeof(hdr),
+    };
+    bool isreply = false;
+    int i, ret;
+    size_t msgleft, numfds = 0;
+    char *data = NULL;
+    char *buf = NULL;
+    Error *local_err = NULL;
+
+    /*
+     * Complete any partial reads
+     */
+    if (proxy->part_recv != NULL) {
+        ret = vfio_user_complete(proxy, &local_err);
+
+        /* still not complete, try later */
+        if (ret == QIO_CHANNEL_ERR_BLOCK) {
+            return ret;
+        }
+
+        if (ret <= 0) {
+            goto fatal;
+        }
+        /* else fall into reading another msg */
+    }
+
+    /*
+     * Read header
+     */
+    ret = qio_channel_readv_full(proxy->ioc, &iov, 1, &fdp, &numfds, 0,
+                                 &local_err);
+    if (ret == QIO_CHANNEL_ERR_BLOCK) {
+        return ret;
+    }
+
+    /* read error or other side closed connection */
+    if (ret <= 0) {
+        goto fatal;
+    }
+
+    if (ret < sizeof(hdr)) {
+        error_setg(&local_err, "short read of header");
+        goto fatal;
+    }
+
+    /*
+     * Validate header
+     */
+    if (hdr.size < sizeof(VFIOUserHdr)) {
+        error_setg(&local_err, "bad header size");
+        goto fatal;
+    }
+    switch (hdr.flags & VFIO_USER_TYPE) {
+    case VFIO_USER_REQUEST:
+        isreply = false;
+        break;
+    case VFIO_USER_REPLY:
+        isreply = true;
+        break;
+    default:
+        error_setg(&local_err, "unknown message type");
+        goto fatal;
+    }
+    trace_vfio_user_recv_hdr(proxy->sockname, hdr.id, hdr.command, hdr.size,
+                             hdr.flags);
+
+    /*
+     * For replies, find the matching pending request.
+     * For requests, reap incoming FDs.
+     */
+    if (isreply) {
+        QTAILQ_FOREACH(msg, &proxy->pending, next) {
+            if (hdr.id == msg->id) {
+                break;
+            }
+        }
+        if (msg == NULL) {
+            error_setg(&local_err, "unexpected reply");
+            goto err;
+        }
+        QTAILQ_REMOVE(&proxy->pending, msg, next);
+
+        /*
+         * Process any received FDs
+         */
+        if (numfds != 0) {
+            if (msg->fds == NULL || msg->fds->recv_fds < numfds) {
+                error_setg(&local_err, "unexpected FDs");
+                goto err;
+            }
+            msg->fds->recv_fds = numfds;
+            memcpy(msg->fds->fds, fdp, numfds * sizeof(int));
+        }
+    } else {
+        if (numfds != 0) {
+            reqfds = vfio_user_getfds(numfds);
+            memcpy(reqfds->fds, fdp, numfds * sizeof(int));
+        } else {
+            reqfds = NULL;
+        }
+    }
+
+    /*
+     * Put the whole message into a single buffer.
+     */
+    if (isreply) {
+        if (hdr.size > msg->rsize) {
+            error_setg(&local_err, "reply larger than recv buffer");
+            goto err;
+        }
+        *msg->hdr = hdr;
+        data = (char *)msg->hdr + sizeof(hdr);
+    } else {
+        buf = g_malloc0(hdr.size);
+        memcpy(buf, &hdr, sizeof(hdr));
+        data = buf + sizeof(hdr);
+        msg = vfio_user_getmsg(proxy, (VFIOUserHdr *)buf, reqfds);
+        msg->type = VFIO_MSG_REQ;
+    }
+
+    /*
+     * Read rest of message.
+     */
+    msgleft = hdr.size - sizeof(hdr);
+    while (msgleft > 0) {
+        ret = qio_channel_read(proxy->ioc, data, msgleft, &local_err);
+
+        /* prepare to complete read on next iternation */
+        if (ret == QIO_CHANNEL_ERR_BLOCK) {
+            proxy->part_recv = msg;
+            proxy->recv_left = msgleft;
+            return ret;
+        }
+
+        if (ret <= 0) {
+            goto fatal;
+        }
+        trace_vfio_user_recv_read(hdr.id, ret);
+
+        msgleft -= ret;
+        data += ret;
+    }
+
+    vfio_user_process(proxy, msg, isreply);
+    return 0;
+
+    /*
+     * fatal means the other side closed or we don't trust the stream
+     * err means this message is corrupt
+     */
+fatal:
+    vfio_user_shutdown(proxy);
+    proxy->state = VFIO_PROXY_ERROR;
+
+    /* set error if server side closed */
+    if (ret == 0) {
+        error_setg(&local_err, "server closed socket");
+    }
+
+err:
+    for (i = 0; i < numfds; i++) {
+        close(fdp[i]);
+    }
+    if (isreply && msg != NULL) {
+        /* force an error to keep sending thread from hanging */
+        vfio_user_set_error(msg->hdr, EINVAL);
+        msg->complete = true;
+        qemu_cond_signal(&msg->cv);
+    }
+    error_prepend(&local_err, "vfio_user_recv_one: ");
+    error_report_err(local_err);
+    return -1;
+}
+
 static void vfio_user_cb(void *opaque)
 {
     VFIOUserProxy *proxy = opaque;
@@ -60,6 +406,53 @@ static void vfio_user_cb(void *opaque)
  * Functions called by main or CPU threads
  */
 
+/*
+ * Process incoming requests.
+ *
+ * The bus-specific callback has the form:
+ *    request(opaque, msg)
+ * where 'opaque' was specified in vfio_user_set_handler
+ * and 'msg' is the inbound message.
+ *
+ * The callback is responsible for disposing of the message buffer,
+ * usually by re-using it when calling vfio_send_reply or vfio_send_error,
+ * both of which free their message buffer when the reply is sent.
+ *
+ * If the callback uses a new buffer, it needs to free the old one.
+ */
+static void vfio_user_request(void *opaque)
+{
+    VFIOUserProxy *proxy = opaque;
+    VFIOUserMsgQ new, free;
+    VFIOUserMsg *msg, *m1;
+
+    /* reap all incoming */
+    QTAILQ_INIT(&new);
+    WITH_QEMU_LOCK_GUARD(&proxy->lock) {
+        QTAILQ_FOREACH_SAFE(msg, &proxy->incoming, next, m1) {
+            QTAILQ_REMOVE(&proxy->incoming, msg, next);
+            QTAILQ_INSERT_TAIL(&new, msg, next);
+        }
+    }
+
+    /* process list */
+    QTAILQ_INIT(&free);
+    QTAILQ_FOREACH_SAFE(msg, &new, next, m1) {
+        QTAILQ_REMOVE(&new, msg, next);
+        trace_vfio_user_recv_request(msg->hdr->command);
+        proxy->request(proxy->req_arg, msg);
+        QTAILQ_INSERT_HEAD(&free, msg, next);
+    }
+
+    /* free list */
+    WITH_QEMU_LOCK_GUARD(&proxy->lock) {
+        QTAILQ_FOREACH_SAFE(msg, &free, next, m1) {
+            vfio_user_recycle(proxy, msg);
+        }
+    }
+}
+
+
 static QLIST_HEAD(, VFIOUserProxy) vfio_user_sockets =
     QLIST_HEAD_INITIALIZER(vfio_user_sockets);
 
@@ -98,6 +491,7 @@ VFIOUserProxy *vfio_user_connect_dev(SocketAddress *addr, Error **errp)
     }
 
     proxy->ctx = iothread_get_aio_context(vfio_user_iothread);
+    proxy->req_bh = qemu_bh_new(vfio_user_request, proxy);
 
     QTAILQ_INIT(&proxy->outgoing);
     QTAILQ_INIT(&proxy->incoming);
@@ -108,6 +502,18 @@ VFIOUserProxy *vfio_user_connect_dev(SocketAddress *addr, Error **errp)
     return proxy;
 }
 
+void vfio_user_set_handler(VFIODevice *vbasedev,
+                           void (*handler)(void *opaque, VFIOUserMsg *msg),
+                           void *req_arg)
+{
+    VFIOUserProxy *proxy = vbasedev->proxy;
+
+    proxy->request = handler;
+    proxy->req_arg = req_arg;
+    qio_channel_set_aio_fd_handler(proxy->ioc, proxy->ctx,
+                                   vfio_user_recv, NULL, NULL, proxy);
+}
+
 void vfio_user_disconnect(VFIOUserProxy *proxy)
 {
     VFIOUserMsg *r1, *r2;
@@ -123,6 +529,8 @@ void vfio_user_disconnect(VFIOUserProxy *proxy)
     }
     object_unref(OBJECT(proxy->ioc));
     proxy->ioc = NULL;
+    qemu_bh_delete(proxy->req_bh);
+    proxy->req_bh = NULL;
 
     proxy->state = VFIO_PROXY_CLOSING;
     QTAILQ_FOREACH_SAFE(r1, &proxy->outgoing, next, r2) {
diff --git a/hw/vfio/user.h b/hw/vfio/user.h
index ac7d15dfa8..30cf35d3e4 100644
--- a/hw/vfio/user.h
+++ b/hw/vfio/user.h
@@ -11,6 +11,8 @@
  *
  */
 
+#include "user-protocol.h"
+
 typedef struct {
     int send_fds;
     int recv_fds;
@@ -27,6 +29,7 @@ enum msg_type {
 
 typedef struct VFIOUserMsg {
     QTAILQ_ENTRY(VFIOUserMsg) next;
+    VFIOUserHdr *hdr;
     VFIOUserFDs *fds;
     uint32_t rsize;
     uint32_t id;
@@ -66,13 +69,20 @@ typedef struct VFIOUserProxy {
     VFIOUserMsgQ incoming;
     VFIOUserMsgQ outgoing;
     VFIOUserMsg *last_nowait;
+    VFIOUserMsg *part_recv;
+    size_t recv_left;
     enum proxy_state state;
 } VFIOUserProxy;
 
 /* VFIOProxy flags */
 #define VFIO_PROXY_CLIENT        0x1
 
+typedef struct VFIODevice VFIODevice;
+
 VFIOUserProxy *vfio_user_connect_dev(SocketAddress *addr, Error **errp);
 void vfio_user_disconnect(VFIOUserProxy *proxy);
+void vfio_user_set_handler(VFIODevice *vbasedev,
+                           void (*handler)(void *opaque, VFIOUserMsg *msg),
+                           void *reqarg);
 
 #endif /* VFIO_USER_H */
-- 
2.34.1


