Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A097AC982EE
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2026 11:37:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x8cK2-0005cD-Rg; Mon, 21 Sep 2026 07:36:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1x8cJz-0005aZ-PB
 for qemu-devel@nongnu.org; Mon, 21 Sep 2026 07:36:31 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1x8cJt-0007td-FC
 for qemu-devel@nongnu.org; Mon, 21 Sep 2026 07:36:30 -0400
Received: from pps.filterd (m0127837.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68LAhH6l857569; Mon, 21 Sep 2026 04:36:13 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=J+tTNGjiYT3iCox4janBTPHmw1ynyHskIM4lLRQjm
 KY=; b=Lukh4eDV3KsfSbgADL+RVcHcytjQtNxTvM9il4mcTVgsNNT1xoin1tL8j
 XSYOIhoPR1JCMJu6fVy5oLFs/udjagHQ9dR0rIea+azTqqcJt0sNQGRSgXLBVi1l
 FpUintvNkvx4UzvGzP6ntnEfcq6C9xkWxFSZ7aOFm/A/Y9ZelHSixlZZagWd3rVM
 odMydUxgdYqa9b0mQyimte3gVpsAK+qWSIL0ATUkaKGulQg1tD+D2orZhGhJGNjn
 W6KSQ7SI+0/3fhx9ndNUYBz9jcPz22K/8BFY7aThlXsdQsOVwQHrIs9IQhWD7jRZ
 oN5HB9fiG+k50Zej2l5rrbZv8FVlQ==
Received: from sn4pr2101cu001.outbound.protection.outlook.com
 (mail-southcentralusazon11022100.outbound.protection.outlook.com
 [40.93.195.100])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4gspa73ebu-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 21 Sep 2026 04:36:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IA2UE5Rir/SojtXXU2nSqfuM/EfoaMcQ99+S9Qx25ItnEvajmzdmFi5/+u5DOom4fwICt8xobLCRclI+pdzCEDMoggH1IStefq8FWtpLhl/bzGNj5hH8Db8wGvajQy1RSBREiHKG/grUnsFWbwZA5Q7gN37iS6IkQdYol1ELdG1SMyvlppsp9L29OIAynOH49+obMwP8OxeVuaq0+XAfwE7da/qkDkpggT73cQ7xZ/A9+a/P9Xl/4hVksMAbJVzWp+pIWple/DoSyCncHfvQ2meAqiIaboym8e6ZvmYl/rbAwtp0mCCtOG4TG06pZCCUZKcEmbH0hu2/PoJC51DPBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J+tTNGjiYT3iCox4janBTPHmw1ynyHskIM4lLRQjmKY=;
 b=s1bXIkO0a/3FB+ig1MAP7Fq63E7lbnC7hZqtR29o4+nMg9Jj1gqRfgeJkKnouTbk+nmijYdhdF5tHeRsyXb5S6/wnhCz0Yw0opsVIOTSzdph9yKXEMxt48++AcoU6viqdwFiRI96MXUifGPiQNUT6mlaXcHKqA+jPYo5eUmPYQptKYyMMEC07zZze8OhD+iFYhBrtKK89NPCvXYzWF+EJWqLA2DghztlRqxn1XvFj/UnKeZQRNifvk1sBa7WqJvSioSHN38GPU9QUqVexFFAD6C2AnbX+EilsY+WxovgaoOSLe9U40RU14rlF3HdzR13nzythT5rScedkI3rhxOmGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J+tTNGjiYT3iCox4janBTPHmw1ynyHskIM4lLRQjmKY=;
 b=o2BEdyFG6CB2xI38kwiLFo5qINImpZIm1O8dRqYTkaWinDaF8bSRMs/Pek6wNzkOmaLZTPH2qp0Tj/tnSXzt0m1Ioh4dt18EdXesMQzCrNvKwyxIUifDOFKrJv0FRvU/l1zDNCdgLX325QkEoxhA/Ih71b3w+GSV1Jc4LNaEUYrNFASdO7NKRqQBnPmG+ogoMlKLow2/5QPI705bRqBN9OGm1A6EYJQodrSf6FrU/UxEOekEe4i+qYhGsx8HEL6rAt1AEnqNHs/7EUdqbTVM/u4HrXPucfOlV4FeLj646HKP5csEP5jVNte9uPt3z9RLGV8r4kNAM1yeTMvro64HRQ==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by SJ2PR02MB9416.namprd02.prod.outlook.com (2603:10b6:a03:4c4::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Mon, 21 Sep
 2026 11:36:10 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%4]) with mapi id 15.21.0428.015; Mon, 21 Sep 2026
 11:36:09 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: pbonzini@redhat.com, richard.henderson@linaro.org, mst@redhat.com,
 mtosatti@redhat.com, marcandre.lureau@redhat.com, armbru@redhat.com,
 qemu-devel@nongnu.org
Subject: [PATCH v4 2/9] qom/object.c: introduce object_alias_get_targetp()
 lookup function
Date: Mon, 21 Sep 2026 12:35:08 +0100
Message-ID: <20260921113559.1299740-3-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260921113559.1299740-1-mark.caveayland@nutanix.com>
References: <20260921113559.1299740-1-mark.caveayland@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR05CA0042.namprd05.prod.outlook.com
 (2603:10b6:a03:39b::17) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|SJ2PR02MB9416:EE_
X-MS-Office365-Filtering-Correlation-Id: f681fcd6-0e88-4689-d86f-08df17d48848
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|366016|56012099006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: j5fOIeam9bxOaMqL/rxD/4cFYozEHyxzR7JZnuPjo2ApqXEJQxuSnzdWkFJUB45MquLsw32900MhVM8C2YHaD6Dztbmgr6BvVhbTw5n8SCRiIa0GMxnu/qFTdViM3Ve+RhhiWsijQokE8B85OumuSLhjTRKlUEpCCdVGmUM4dbN5alozqZxP3qekwvqSlLmpIDd3xopRK+9i4rR9gl59oC1qruvODMPM5/9z6eIZtZ5/vbXc+T6FYDWvV86baMwQJeLNBQrVd5PbWnpVIrRC+UNmMesIL1MxRdEZlcn0t5b9tm5YPF4eoSEqxNqE4Uw0XaeFa6ixFnrLX75E8nq/AGFEws0G/UfwEoa/UyUk5AjXtH7AAtI59TdiTWSB6vaTvegKT828cIDO/eqoFHvXpeer+61WlmP0CVsDXEnJ42C4dOmQboAyzXMl8fBGxNazY3W7yiuuKMLFj2c72nfcdAlqyCtszb1faLJvINCIarNZJnTjaKxCNUDqNie4u1QR5bAIq1Kwtkb1WlteSERpOiT3Cgf7cPLgPRz96oDnsD2y/1Q7qp4m1lkLPSTX+FGBkd69Xrird32jX30yfCZUfkCKYCRCqX88NdGWal4DiT0Pbo+CIKHThzXqqKp+DShy3axCo6RTHsuc8fX5vuQczZRy+lv804GVpnr5cTFpPpo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(56012099006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UAu9Y5hXL+t0PWlVJM4jpI0Y0CtVxBz2m0H7K2G/8sAPIzPJ4gnPEUyIvGsc?=
 =?us-ascii?Q?xe7EKy0eo53tX6cx/1tyjwFkjuw59CIKKIFo7ieiFFruyZsXKnj/S/9/iqPy?=
 =?us-ascii?Q?yrLyUIB24vv5NyMP4T/j6u7V+YwD9H18t0ADhrJdu0Nq7qAaReTPs6oaF0iN?=
 =?us-ascii?Q?a+7vDyEh4tYHkw8UQkSQDFCahDkNvMwqNxig6gvnVNfM68SjR6gdqTKWvkBA?=
 =?us-ascii?Q?ziq1NZbwhEyGsdB6nGfsPaKc4GPEiGhlt0CiVLC1w6ni3rnxzV4g4sXo+Xwl?=
 =?us-ascii?Q?fyyxbS8mxTYBHV9990ZW8ABzblVNOXoHYqwQwjttOzU4PhNmxnU5DPDYx0/R?=
 =?us-ascii?Q?CDaW1L31X44SxgRFSmsHS0beoiJkYrKA+ds4D21dJRESIooVTdLcdDjHJznv?=
 =?us-ascii?Q?jSqiIJ0U90Hsrbki3CHVfZwqBi3ykmrGWPXAjklUMpE6GZOELCMobzq8ZZWM?=
 =?us-ascii?Q?r9EbfTXPQ+geKZBpolF/kftQuR+jU3NAxnY2S4g8HpdRSHKBoZEIUE2ZJ4Nv?=
 =?us-ascii?Q?2bE+QkO6/SDjHcT7LT+nOmmkTfM1eUcbRk3kE1i8oLTFZJpqv4fiYUoelIIM?=
 =?us-ascii?Q?sZ48Zln2vpYwCCNRcnNFRyUkX04UdJijSIWpSSvatIdFIXkcFx6Mq+xyw9KG?=
 =?us-ascii?Q?5BisCcA/qSQNDNWSL0pvQx+njDt68tcPEEV1U1Ak2lMr+z1rKWDUz8bGegXN?=
 =?us-ascii?Q?8r58qYLNVP/I2xh4mXgj3jeJtpun9tagebLiH04AI6Wwwluqve/jmepznQnt?=
 =?us-ascii?Q?hH9DkPHgTmjNT6HYeF1Q4sCWx7FNuNYbsKbdcM/8eUwZWkMaDFHbjaMAvK0I?=
 =?us-ascii?Q?RVIgzQ3R2b5jRnDe263fMZfgr6aqXOP/21ir7iilgz0c25TA4sA49bc1wIRU?=
 =?us-ascii?Q?BxGjjNDPAULN+52AwiyrUhyNOOBh40nLj1SVBu6pD3HTodM24Jr7eFvVnW3m?=
 =?us-ascii?Q?O4BlJVl8Jt8PMjj6/HctwfbyHpzkF8vighdliJTmHVpfOR61ywMh5Yw7v9jC?=
 =?us-ascii?Q?cQQd5ezzfu6eu/+LvfNCVM56ZVKuLu43/HN6Q6IxpLhq3wyv/sN443LlwAEH?=
 =?us-ascii?Q?9FZ24r2yoxOdWRjzALqSVnkpUc0YUcquTteiPsqhAaDcjtHVOkN79/IJDhuI?=
 =?us-ascii?Q?A9sbaq/dlJRBGjWyWxie9uYHtzirfXbz1HVoLgEwFj/x5L65ik9FLVwonzBF?=
 =?us-ascii?Q?5hBX5PPQgF+f0JtVY/WFqeN7z5g1MDmoazBq9QjUndSgmj0OT71/4YDXOxIh?=
 =?us-ascii?Q?qktGdKc7r6mr//gXotB7vHADR+lxtZE86vLdcmbfF3CO2zD6yyilZMlLhN+R?=
 =?us-ascii?Q?LRxM56UcTtM2jDoOI7TqOT/UQiz/svnGHEAxCyaMr7FYWBzKaudeEcHu2yl2?=
 =?us-ascii?Q?mF+ChZyQlbR2lBbmQljw7nG1ybg6VolgOA7md2Whmwqif5glIeYkgpGI/CUZ?=
 =?us-ascii?Q?YaJJbeWu0wto62H3t4B6whqHxSKAuD2K0qc5TxU6DsEOh78s9HrozbxpPsvY?=
 =?us-ascii?Q?wdr3fvNzbFt0weqUMInXB0aye0HVWtZjM9WX9RowT0fXEvv9NzntzKW0vYh/?=
 =?us-ascii?Q?27zFF4UphvzqjHeZfS0FJUTgpvrwaGYBz/s2qF0B6BSVKDwEc5NU+wWtHFbu?=
 =?us-ascii?Q?UCpY37DDx2q09CyHmJ8+oVQisPcIx9NBYXusSBiLiZImDomYfSxIzEQddAmo?=
 =?us-ascii?Q?prGsL/AH6AIQB6DQ6iP04C1nSBj2gm2uhSo0NkgaAU0hfVMiam85SakT6Vn/?=
 =?us-ascii?Q?Rbd7WaWbUWCVcyN84M7vy4aXdgi4xL8=3D?=
X-Exchange-RoutingPolicyChecked: h65s+BwcX3T+ET6FqoMorRxVO2oGiiKBq8DXkZGU1eTBTZCe0zrb7QF1tEVBKP38PMhYg1WY4ywrnPmaBIySycgci6mETA4m6FnTlasTfcq8J+40GlmkQrRaQa1sfyHoq+8NRH2e9vXPOCcHFz/9GnfbnHt2fjvkQFmv5ZuR4zvydooY5pQMWF1oTSo8ucKmkRDwIRP4eY/fxTLySGv4uG9btMJZYWzTkp86kLI3zYTGUpHjpzPhxmqr62CCCxAmEnI5v69urTZ7wYi0x/s6m8vzrP+bqtAM7cAWkEBMxvNbz2iKjxTaSHezmoLwhRPoxAD2W8AWDFDbdc9koNhzJA==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f681fcd6-0e88-4689-d86f-08df17d48848
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2026 11:36:09.9342 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ynz5QSs/+HXXtEVbXBbyo7TPMrDR4wfkTmPoWj42hDDwQp4Co9wCb+rttlNn3BzpGiPABUr869eFk2ybaOh2wa9s2Ck6sPLQaTcq7mekGp4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR02MB9416
X-Authority-Analysis: v=2.4 cv=fPWsTpae c=1 sm=1 tr=0 ts=6ab116ac cx=c_pps
 a=NdJUlaw63gEkhoowhPQriw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=VdqzKS8jKosA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=Ap8k9tRZuQ82DLYWQqG7:22
 a=64Cc0HZtAAAA:8 a=bLxKGtcusTcs4WrYLd4A:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIxMDE2OCBTYWx0ZWRfXwXE8ph3aO9ln
 0jjyBDecHsjfy4wJZtsq6f7nS1ztBrAQpJ7u/CRFadSCaQgBZfnpl4boxd1WazfReW3WwelsDCo
 xVjo/IEL8eXY3kdf3lAvvChMQgpDK6I=
X-Proofpoint-GUID: F6u4e0KQjGhYCMFmHLfOKdXw8GPKJfV7
X-Proofpoint-ORIG-GUID: F6u4e0KQjGhYCMFmHLfOKdXw8GPKJfV7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIxMDE2OCBTYWx0ZWRfXynTQn6byUFf+
 O5jyOkV93m9mVN1gMs+ZbVvVFxJbOd9Gm4sL4UW1YQj16vFFipyVWjz3ErwV/uWyaWVO4gBtDG8
 TKh8v/Bcat+1YoAQxVYpYwrAo6Z7lXhKPFapAiG/fM5t2sgn9nY4+UqqzxJZupklU2xnFvfkdrX
 aEq5BX018eaib+zfAYCNE/TykQHgNgBZcgwj2kbmgUYaPSFwgek5sxp2P7ighx8nZ2+KIy3q7WO
 gH3jPHpaZ8RRp/NpXqvUTYi62ATz1yqoQutXcrZDlYrZ86I/340IiGd44Cse4+I80Fco8O2+taq
 3AQ4AxYJ5qRUFM4UsWd05QkDdztiHOpi1cPTa1wH5mGwcTC9/OkiaEN37mD+wlFUpxoDoJ3YdKC
 mM9i71rp1kR/nwEGzHhfw1muN5eDFa/pUnB3TjTnX5OEgv1Mjew9mbAZUsRMO7838LNVXQQfb+D
 t7D9QQEmH8SZdqQo9Fg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_04,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0a-002c1b01.pphosted.com
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

This will be used later to add support for alias class properties.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
---
 qom/object.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/qom/object.c b/qom/object.c
index 914d1228ca..eb5f74fc74 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -3056,13 +3056,20 @@ typedef struct {
     char *target_name;
 } AliasProperty;
 
+static Object **
+object_alias_get_targetp(Object *obj, AliasProperty *lprop)
+{
+    return &lprop->target_obj;
+}
+
 static void property_get_alias(Object *obj, Visitor *v, const char *name,
                                void *opaque, Error **errp)
 {
     AliasProperty *prop = opaque;
+    Object **target_obj = object_alias_get_targetp(obj, prop);
     Visitor *alias_v = visitor_forward_field(v, prop->target_name, name);
 
-    object_property_get(prop->target_obj, prop->target_name, alias_v, errp);
+    object_property_get(*target_obj, prop->target_name, alias_v, errp);
     visit_free(alias_v);
 }
 
@@ -3070,9 +3077,10 @@ static void property_set_alias(Object *obj, Visitor *v, const char *name,
                                void *opaque, Error **errp)
 {
     AliasProperty *prop = opaque;
+    Object **target_obj = object_alias_get_targetp(obj, prop);
     Visitor *alias_v = visitor_forward_field(v, prop->target_name, name);
 
-    object_property_set(prop->target_obj, prop->target_name, alias_v, errp);
+    object_property_set(*target_obj, prop->target_name, alias_v, errp);
     visit_free(alias_v);
 }
 
@@ -3080,8 +3088,9 @@ static Object *property_resolve_alias(Object *obj, void *opaque,
                                       const char *part)
 {
     AliasProperty *prop = opaque;
+    Object **target_obj = object_alias_get_targetp(obj, prop);
 
-    return object_resolve_path_component(prop->target_obj, prop->target_name);
+    return object_resolve_path_component(*target_obj, prop->target_name);
 }
 
 static void property_release_alias(Object *obj, const char *name, void *opaque)
-- 
2.43.0


