Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE740CCD1AB
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Oct 2025 12:51:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBYJh-0007Fe-3K; Wed, 22 Oct 2025 08:51:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1vBYJd-000791-Fh
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 08:51:46 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1vBYJZ-0002LI-NQ
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 08:51:45 -0400
Received: from pps.filterd (m0127837.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 59M5gYdk167846; Wed, 22 Oct 2025 05:51:36 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=M2VltpDnydWPs54DBW4ZhTIM2VlLhraglNMC1S8AK
 nY=; b=vrJ3cJoiKyzrwhsfGESWWVR98wxFhnjv/uGGQkDZNGgtF5v+rn1Htz9rj
 JKL1zW4RLIC5qTnjWISVt9Y7d8+BOprHTOtXfBy/c03UCGknzAqFgggkx4F7bFo8
 7v6YXnVvTAosKQrHdSubozWnEo4rpnxtH+Nu86aw+TU8WKDK0i1wLGUUXqm88xNA
 fxqkU+3BYaDRiWGCe0imDZkp+2YnZncDHYLBt0qlxj+K+2qwXeyX8Hq8CMOaMCUM
 MF8YCorOtjD9f/f2sG574cHjJfKHZSs3wieGgpE3UHe4sKTGWR9XTDh8romgWBi4
 X2a1lUFIFd1aocWVf4SUKrXS4vjtw==
Received: from sn4pr0501cu005.outbound.protection.outlook.com
 (mail-southcentralusazon11021087.outbound.protection.outlook.com
 [40.93.194.87])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 49xsc08w0j-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 22 Oct 2025 05:51:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rERSMVCeLxYC2+iCrFxVVjRzTcP7L+pYXuuuHIYee7pJg5NJvnCRAFvlJACN4CFgfdfhPaDvvEtt/qNxn6sh0ERGm6xg6j0FpjZhCjKshlLEghFrbMTeaqn0AUbKYRivI3mV5CZT2gNz6nUv+WqLahJDlJT11Ltet/pkK2QkXgZh9AiZQmupjeps6jxHA6sXbQgx65OYyhefGjPvYRcHa8eDATPjr6vFMg8EUJK6ezKfkLnOz4UgrwZissqkjHoHXHgyWE3Fdbo89ZMw9s1F1w4LBM2PLvQ7Vmh9/ICpUvfX9fXj031y3r467s1lGBhxYnHOt2PpNYlWOpAxlkVQyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K6/MUoOe6lSuo/oa7F9F7dFpBbIwLDhO8Mstt5bMDf0=;
 b=VzA2slz9KVh1mNa0CKIZGSxg9/cVHMbsaQVKSyqznQyxdb92hRLn3GpMgvBRCq94PQjAfpjpWr4/tmTron5cXM8w6OsC8vw7Hj581gKbI5gW4c3NmE0EHkqFBB5ynd1jtXj+PwoFS5d932HSKWDMH22RBt6CJ2IQnABxr4BnJ4SU8ulv0T8cw0NociotMnIwtn5x+jraIbYwzi6Ni8M8Le3z//DWkDn2eL9Yei6hIUyhwXYufP2K4K5+ieXIQZke6ogRe+99VF5MyxJtHPag1ONGrbX9uEU9rbw14k5EDYRWZhc+k96KsooZEzI48lOTH4/rkEEogCobAvHomPhxKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K6/MUoOe6lSuo/oa7F9F7dFpBbIwLDhO8Mstt5bMDf0=;
 b=cxVD9HIunspNl3xLNVKg0OQNfsndMRId1UGPoS2wbvxMDwaYqMYY8VGgarR/x38w/G+zavc6RuLWS/9KcXd+WePDvPZmWQKXRiXuN+V2nwMGCJl8dY8l3IJSLK6w4Y+QKqTyJDr8WNLZfIr4NFy0jvL912EXh/TfxMw0+h2PBuMzYwH8dvGNAm3zbIDNZcxDcbHX1/3eZmvHlM1ov0HIcod+Vs8bZ5/5orqzO90QYgBuIGrGrswj8NSEtXsWM9bz+gWy+xqBbps1jtaqVnJIGeaJhZ3H5Ahj93tY1gij91+ZqrIKVjfig8oa3UK8yVw0q+8c3tkEqU1aTvAkTSHJCA==
Received: from BY5PR02MB6753.namprd02.prod.outlook.com (2603:10b6:a03:209::17)
 by LV8PR02MB10168.namprd02.prod.outlook.com (2603:10b6:408:192::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.12; Wed, 22 Oct
 2025 12:51:34 +0000
Received: from BY5PR02MB6753.namprd02.prod.outlook.com
 ([fe80::a343:65a8:bffc:5a57]) by BY5PR02MB6753.namprd02.prod.outlook.com
 ([fe80::a343:65a8:bffc:5a57%4]) with mapi id 15.20.9253.011; Wed, 22 Oct 2025
 12:51:34 +0000
Date: Wed, 22 Oct 2025 14:51:30 +0200
From: John Levon <john.levon@nutanix.com>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>
Cc: qemu-devel@nongnu.org, Thanos Makatos <thanos.makatos@nutanix.com>
Subject: Re: [PATCH] docs/interop/vfio-user: update protocol specification
Message-ID: <aPjTUkBEVHaNrYcv@lent>
References: <20251010102453.711072-1-john.levon@nutanix.com>
 <f863c93d-9bff-4be9-bd1e-344bfaf12ce8@redhat.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f863c93d-9bff-4be9-bd1e-344bfaf12ce8@redhat.com>
X-Url: http://www.movementarian.org/
X-ClientProxiedBy: LO4P123CA0256.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:194::9) To BY5PR02MB6753.namprd02.prod.outlook.com
 (2603:10b6:a03:209::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR02MB6753:EE_|LV8PR02MB10168:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d76ae38-9593-4e8b-524c-08de1169bae1
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?7tngLnlBnuN8TCnS7cyKkBpeUneMnldCTG6MjXrJy0jbn/whzlk7nvOVHN?=
 =?iso-8859-1?Q?zQf3alP7IAcsbP7jZLze/dqwWKqFiIwFL7tlcS7SA9AKz+vzQv4VfOiJV6?=
 =?iso-8859-1?Q?T95Udqyw/NhNA3xR9G1WAo04HR5dMtgZ9vUxP5RxKJ9T4WzAJZEPQsOXwD?=
 =?iso-8859-1?Q?0BUEj2V85URKiGPV5DLqgpQpe2nzhHZE1Rm0IAzp5ogy7+L+kUWApRx1KA?=
 =?iso-8859-1?Q?eJT68WgCIe83Bj6H+r9aQyC8wI0hh/mYFDcO2lfC+LEGR5U24HrtA51RbE?=
 =?iso-8859-1?Q?tEyfZTibNbxyKrsBVCYNhF/C4a51lO7KLes92h9F8KML4nF8MWJ3zjh7zp?=
 =?iso-8859-1?Q?Pud+ERMxqY0vTvBF2NuplHB1dldhme7qni3AynvkvqJAFbefHJX0mcBi6n?=
 =?iso-8859-1?Q?TEZOEe1bF9+sH4rS5WRNnNgHWrIPWoju3w1XNtnCKw0gIGZ3tuU/LCwGff?=
 =?iso-8859-1?Q?CIpjI/6h0bO3TtUyc3l1EY2EjwLRG+Qd+4Ywa4jDB10Rs+lDnAPiOu+xXr?=
 =?iso-8859-1?Q?LtBwS4qNVJe8znS6nY7vQPR2XeUmzZw4tCyhGVDcMcMxFfumtC8fPD4NAI?=
 =?iso-8859-1?Q?1XlTgnnjvNRlWLDMTAeCMrzK4jbjCdu/OM0xhCAQnD/sEqi4OF6GJnOT/h?=
 =?iso-8859-1?Q?6fIYxclRXKkLi9jpOGWsnJUAnkgnTOdyTn5tpgHYcKgX86MPmzpNIJ30dq?=
 =?iso-8859-1?Q?8poRUqZgOQyzK1wD2JyhkEMfjJclw8rzfaWh2MR0icZVN2NOx/J11dKAu/?=
 =?iso-8859-1?Q?KBr3YYqCclzVCawDIfB4q5FHgEMGrhCfNyvm8639TZj1r2Xl40PhixNBW1?=
 =?iso-8859-1?Q?qfCJHExHMHCs9QxrBL981+cPzzd2LTyxWal/btvxolJm5JqPFa50teg9sV?=
 =?iso-8859-1?Q?cK3gYJf5cOOZG3rtSjVE+r/zY8NwZZRFXQBxcBVi08ZwSaN3mBzBfIq9fz?=
 =?iso-8859-1?Q?ytfWt2haVb9kWCAaEHevEiabarShiuBZYT9qU2BFTFY9DF7mG6B9A3UBkr?=
 =?iso-8859-1?Q?9kAhCoxgLbmTe3O35nOdo4HsXC5+cNnmUl76RXNRxXAraXx5tNSB6IAUo4?=
 =?iso-8859-1?Q?piEd3gnqY2ZZ7SLqvTvgskeVLie8BmjoCjM4pgY6VYtWUH9D5TT39mklgw?=
 =?iso-8859-1?Q?GI6I1o27A3GcLPE/NB9FhG/gHEDJUZvF+oW0fvxjrqpX9sEeaw13o3SBUz?=
 =?iso-8859-1?Q?o6Xnt2dDUHN5Miebo1ExSOfCK00lvVoSVOXGbYk9Wvlmt2/6E4iIKEFH5C?=
 =?iso-8859-1?Q?XZ/AaLehi0tUsNtTxGooGLzJz74gHDEsTJ5/Li1O4At3MxeOn1pGBVgVxK?=
 =?iso-8859-1?Q?FvqvbOM6VLeNTS9OhHdzuMTQ7e6jeX2nSdl0o9nYLtoYRFnuDSB/STIfOs?=
 =?iso-8859-1?Q?JlUh6nKXOg4EuxfyaiHzGMkVeohdOfn+bDCUT20HIWQhxzU1Nr7GRuWH47?=
 =?iso-8859-1?Q?CGvgDN2aMxDNkeiNqjeXn0kDAwfrDXtLj7R0N6b97p11ISp2hoINK1T3J7?=
 =?iso-8859-1?Q?HqXnR7vFL4El/byFmtpYf8?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR02MB6753.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?vB5eMR2heB+9sAtG09vJpj94GZEGLYHbmzaTuKWTvEdF/ASuM9Iw0i0Zsq?=
 =?iso-8859-1?Q?JWxB1AwgeYhn1TyYq6pfcSEqlfVCFa0v/ratrQJ76+sYEX4BX8pKywupgr?=
 =?iso-8859-1?Q?u3DXtXeploe3sbeoQnJfC7zkdU6yt/rrkA/4vAyfe3c8i5ExdJmwuzl1AI?=
 =?iso-8859-1?Q?5hFUi44eN70VW1Rju3Q1ghNfOObwhalHH42cdNLaLGq+hdcH0+rK+8OYMG?=
 =?iso-8859-1?Q?MYSa5skUFKdABq4s47ropBaMzStnwt5VPOcSAcUJ4vzVIom+RvIhZqvq3c?=
 =?iso-8859-1?Q?EWUgDghvdEsucwoOrj84GIYl8PSLOsKfE/s/0fvcmKkpi7xIZlk/kDCy4+?=
 =?iso-8859-1?Q?spTtPBBt7PQTW8h3mZzxK8B+FZzr+7psGTBoaNkKTGFrpxLnvJqrif04oD?=
 =?iso-8859-1?Q?YsD+TSumpIRpzVP2ZtBKfm15DCTiL7pGT+pBGAxqmJUkquGZLe4UPMqUit?=
 =?iso-8859-1?Q?NBxli97u4euppv+5uOfrLQ5ykqubKTn2BjtbJs7sRtNLw2sf+bBKbcjTR7?=
 =?iso-8859-1?Q?gqxDCiD+PcdRtpmpkgaYg3JdM0nitPwRKfPnpfF6naxrGQdVEvLUhtScl7?=
 =?iso-8859-1?Q?FKZzDVQjror0Yu27KT6Q2e9tJQd+rizV3WSdZgsB3VaJnEDS4/ub/nXiZc?=
 =?iso-8859-1?Q?eXa+F3ouu0ukNJ9QKFXMasnpWgK1jA/N/RfJH0tAthxNNSruoSgDONY5Vb?=
 =?iso-8859-1?Q?Raecss4Ot1de3Ck4InekeWtpoJIsJ71eTQBU58UuYpudP0v41wQVePWZLF?=
 =?iso-8859-1?Q?FN4FXSuCnDtxYl6AHBeLDC/9SkPabN/A8OZmKMyvvzwpz7yFpzJlH0Nn9C?=
 =?iso-8859-1?Q?EQ+233wT/nRfNy0tuakIR9uLZ1OrljesDd9XXog8TcsJU/MFii+MDJSm8W?=
 =?iso-8859-1?Q?Q52Jx8HWqisWpM6dfO3VDDDY2GyuEq+2y/uU00lj8sDVzV6p/2PaZJ0rqP?=
 =?iso-8859-1?Q?7AYfQdVtojnTHbsvAQjeol7riCVg1S4mO58bP/4ISiOz+MVZSafKeRaR+V?=
 =?iso-8859-1?Q?iIupg3vrEK1QectHeG33M6MLpRCfbSvpFnLjG+jznYTFB2rhGXZPpisDZ0?=
 =?iso-8859-1?Q?XeaC2yLqCLaQhiV6cfd8dFDjAlu+NewWKozyk8k8xEuZg8pbjIVbuQTDa9?=
 =?iso-8859-1?Q?YznU/HLfQbdexnQmAwAqEmikkc+LT7WnHipkLqyuJrw9Gja2NPJmaT11YV?=
 =?iso-8859-1?Q?ldOqrzvWXNBHH2QpaMzc9ed+g2OTV1MIcNRfClmEPQ28JU2SQAX6XzSvZT?=
 =?iso-8859-1?Q?hAPvwB8CiCd4bjsNx8yGmd+YOTopmC2tssfXC1CqJY9yZLuJl89idhJ2RM?=
 =?iso-8859-1?Q?A79iOu7dVCs6qB6nnQ0/SaVIKvF55VAOycDBlIaPtDGJr6KJF1XBYnZLRp?=
 =?iso-8859-1?Q?E7eSFexn2MDHz/pYAiSkgO89MAnacBhvcIS027Bsxldhlpt7/TeQ7udKrb?=
 =?iso-8859-1?Q?wwukKKIQAvu5XvHDeAe59zYPgVarAJzaaygKolE7kmyTwp0Xi+u3PKmvdU?=
 =?iso-8859-1?Q?8DQBuwlh7tT+9f3QQFWvFMvCTI6LQH6YYzuqNPG2Alvhs/hUXToNY0Fa3/?=
 =?iso-8859-1?Q?l8o6BEZyG9dl9AB8mkWkbWWEO9WCGh1jAmd1iz1QggKJfOdh5ANSnNkXZp?=
 =?iso-8859-1?Q?CVl+/fQMlBdUk22ZN1ZpN21xt4PFtbC/78?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d76ae38-9593-4e8b-524c-08de1169bae1
X-MS-Exchange-CrossTenant-AuthSource: BY5PR02MB6753.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2025 12:51:34.4169 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t4jGbp0kawdJQqWR5ssOaY8pI29nHkaE4+QNcv2e0d1zh93PG6ocspRNvuTEh/+DlIEVuYUo9YT4BSUL6BqMRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR02MB10168
X-Proofpoint-ORIG-GUID: gzDLqb0LuddnlQARc-bd5v0ydgCih8NP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDIyMDEwNSBTYWx0ZWRfX0cwg7vQ5A8Nt
 sLW1g5AqgperWQOFPJH/MnenZnFfb02Pd6lse0xg5X9R395QFa5lNGccUTZP5qT2R5DADRNvHa8
 l7ofg8i0LQSvsao8lRb0h85dTgaARX4OWpITt3G8lr4EtorXmsd/qdpFhe6ADWxAa6J71pSImEO
 GvQSQ4GMe4qjMXeAPpZFDpvYldFJ+MvrVLtz9q/k+RF1MPMXN9OO8LVVv1Ci+7nntyd1iTIk5Zr
 DuCDssAeC3srFfs5XmD6atAgdNiC+oJQINfPe/m62Xh9ovPEFrfvgvYXekCtoLhu6rI9ET5n359
 EmNQ4IPdAU+SsQjxtF70/2u5VqcMOeyGW33QgfMymm/0o2uZ9K5ETFDD3l8yjqzEV2Kgzxh7hXq
 w1IsP75f3B6ftadTPQij1VNGWaSU+Q==
X-Authority-Analysis: v=2.4 cv=TqPrRTXh c=1 sm=1 tr=0 ts=68f8d358 cx=c_pps
 a=rTqH417Se8lxsOiWxu6Vqw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10 a=x6icFKpwvdMA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=64Cc0HZtAAAA:8 a=vc8tVPeN491ggtEn-M8A:9
 a=3ZKOabzyN94A:10 a=wPNLvfGTeEIA:10
X-Proofpoint-GUID: gzDLqb0LuddnlQARc-bd5v0ydgCih8NP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-22_04,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=john.levon@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001,
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

On Wed, Oct 22, 2025 at 02:34:02PM +0200, Cédric Le Goater wrote:

> On 10/10/25 12:24, John Levon wrote:
> > Refresh the protocol specification to the latest version implemented by
> > libvfio-user. All changes are backward compatible.
> > 
> > Note that QEMU client itself does not yet implement these extensions,
> > but as this is now the canonical specification, it needs to be kept up
> > to date.
> > 
> > Signed-off-by: John Levon <john.levon@nutanix.com>
> > ---
> >   docs/interop/vfio-user.rst | 554 +++++++++++++++++++++++++++++++++----
> >   1 file changed, 506 insertions(+), 48 deletions(-)
> > 
> 
> I missed this change in the last PR. Will do in the next.

No problem and no rush

thanks
john

