Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1F40FE51ED
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2026 09:08:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wGCVV-0008Hk-Ds; Fri, 24 Apr 2026 05:07:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1wGCVT-0008HK-CF
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 05:07:27 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1wGCVO-0008PS-Og
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 05:07:26 -0400
Received: from pps.filterd (m0127840.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63NNA23P1947669; Fri, 24 Apr 2026 02:07:14 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=proofpoint20171006; bh=qa9ogkCJW7/lYt+
 4XFaNqP5LN8Y9oe6ATIyVnJSEf7Y=; b=f/Z5h+K94qAEI/YPcUhGM4S7lQKZbH0
 voL1OWs7T4N2mKJ3uwyNip3lH+MJ8zxOg483V6gVyTBUzFxy3mDQ6B2jZ+ynPcEg
 gsRZ/0M9KkiRL6sdhAkSKlflUJ9jCwRuJEWLL/SmSSOg3AnuBn49dtD5jmskzki2
 gFc85U1FBYwlhY093MAlR9j2uIFeo6eT2oxGuqhawVqTkBsXy5wrQDP+xp7XJR2n
 RYP+3C4BcXQJST30PPayARotVqosTOn8v+dX1rlrLebGxljfDwrbofKBAQfm4AkL
 3aRAaJcFTcwp5S7v0mH7U+zSSSxA1uuFgGBCpWEgF+ca8f+vs6BPv3A==
Received: from byapr05cu005.outbound.protection.outlook.com
 (mail-westusazon11020133.outbound.protection.outlook.com [52.101.85.133])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4dqvuvs2fg-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 24 Apr 2026 02:07:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r8+5VLF3f2DdfSoLh74F3CMG4BTQVEtyF+U8fI4GdHcVK6g1dAjvsgQ3W1e/+qcGfvWjO/sHUBzm0nYaqRh7OdZOjuNck0Q2zeAsyVQFPB0a1dgZtLOXTzNWTQ87fBpVB0Bmuye7ktB5pe+B8/Flz/SnLh/CGiYOEAm62BVaXXmzf9u4zc1Fff/gAklVjv0l885FEQj0fRP2sZTJiYsJmoslp9S89YfC/4Tp/ccWrcmuFKYlyczGlIlwCk0hLu1+57soV9aN17/q5fMIyBIZY1Y7hn0b3BIoJrD4pxmbLg+dwX1GR4ogm2OIOde1KuHusiNq43/Iw7eive9eVrdD4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qa9ogkCJW7/lYt+4XFaNqP5LN8Y9oe6ATIyVnJSEf7Y=;
 b=d+Oxk4DyxT4/CbeEZWS9DWKRARyLlKQuoivcncjYfNfEHMW6sL14XsTpsiPf+MFQKXA5hXzKtKrustBZUp+ty5Z//Aj7M1TM3COi7Fr7qcUjXz6bKsWvSbnGSRJOhUMXiVj9rxxVok1Z16CJvjNnooYUKUmYAre1uQuvHavuHhi2zXL8SfTuBv59KObt7HbMPTIFmLL55cbIpUNxMYqi++Y9xCJRQPiYv/Tddl1dlPPQzEnQrocSlLGB0y9iKqj4NJ3l9uJ/yAh4rxQeDe+hnqC3g3liclJ+nKew5Hd87mdGxmdul0kWVfC743uWamgmtRP/8arKy0m13LGh+zdc4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qa9ogkCJW7/lYt+4XFaNqP5LN8Y9oe6ATIyVnJSEf7Y=;
 b=D0wZ101BG/KCOqnC2ZrCWocFrOnnNstHzpq5wvQAktuzYE5Dc3PaDNeQpWgqTaum+2inucEGWKJcmtccbQGMIwsEm1PRmN55pTfjv4WnOeN77yVOeqkZYY910wOhlk+Cd8JhDW7ZjMBHb4Rf5DeOx6DROE/jHFqpiWtf5ctzG+DYm3gbeY/efYI8AQ1gGtDNHsTBUI2A6y7gv6TgfQJp5eHW6Ztay4aU1bYOueWYNKzxqgA9jsR6VDmq18++EGHblVia7qyLLUHWFQq2i+T6wq+IzAWxdGnN2Zyd3aF/AaeZ/tX+HxRvhEC6nOVtPiX5LnSU7fZk8FUjF4DOZEtepg==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by LV4PR02MB11003.namprd02.prod.outlook.com (2603:10b6:408:2db::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.22; Fri, 24 Apr
 2026 09:07:12 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::dbc1:9766:c58d:4887]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::dbc1:9766:c58d:4887%6]) with mapi id 15.20.9846.021; Fri, 24 Apr 2026
 09:07:12 +0000
Date: Fri, 24 Apr 2026 10:07:08 +0100
From: John Levon <john.levon@nutanix.com>
To: zhaoguohan@kylinos.cn
Cc: Thanos Makatos <thanos.makatos@nutanix.com>,
 =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH] vfio-user: reject malformed migration capabilities
Message-ID: <aesyvEr6_HDsl1ML@lent>
References: <20260424031259.289211-1-zhaoguohan@kylinos.cn>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260424031259.289211-1-zhaoguohan@kylinos.cn>
X-Url: http://www.movementarian.org/
X-ClientProxiedBy: LO4P265CA0189.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:311::15) To CH2PR02MB6760.namprd02.prod.outlook.com
 (2603:10b6:610:7f::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR02MB6760:EE_|LV4PR02MB11003:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f10187e-56b3-4cdd-15ca-08dea1e0ded9
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|56012099003|22082099003|18002099003; 
X-Microsoft-Antispam-Message-Info: ekDGYZwHBxEHahxl33NZJxfNIjpblNTMdwQqregMwORK0w27TOd0vRyu1dAdrytFZUqsfgP7+OJLbvUO0d9SQrWW9LaKhj4/j3AfqxMsCLps+/UN371HMRA+iySPd/S6E9VdhD7745R2LIeNDak0vos9ynpTiC7tyvPCdUuOUC5s0YGjBVQY8oFD1ZskLEG+AT6jIGtQ1YoLIBn/zpOCSZ5xAyy2An3S55FK3DGC/LmckfN5OGdvUKa2E/ByEnYHC742otHWLaQs2lnJNcv0h+7NIyhLu3Xx8ZZIBz6H1+TDP0GtX3a6AOjLLDJyD9rmAWknzr1ckrUB325WvbYt/eVPSWZuctNBHVgahrZjYbu4CKIGQ2I1a8Oq7274RyZFu2YfdDrkM6gvjbUpTdAT0IR/C/1nO827oLOTQR567UGj7DjNHSe+QyIbxGW/q29t57mVyEf/khFr0ROX1J4mIADc16mhqZQWsNO8UxbetAmuUMji1oN4rZXtYbDY/qoR3BwZD8ibrRrmSqVYSCUlX3deAygHy5Q/72BbM06Z4bR8P62pByrLH6T5rHru10CLJ2rzmWgdtEDkSnD1wQj5V8avzG8chXkM3py4M1ebM7jilLFusUMdQAOnqlfyuiyuv6SBkp6FzwpsF+jKMuh80E5XpxAEJrrvHV0Ooi/5rM2AxWVWaRGbwruLoWkRbS7mzHNxBUJtp54Dfv7IltK6mHlUhm8u003dwEBK9CadIYU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?04P5PISV4jWyYOcxyWdt3yRVGq9AWSt0nDI2z2eBVKiFc5LN822et/3OIDnB?=
 =?us-ascii?Q?KsLekV+a05xZyC7QU46AtO0rgd4IXqIe/temKdpTKAuFWANkpE7GZOfLuSc8?=
 =?us-ascii?Q?TEK3tjE5TKi2I3mZgi9bu+dmhWWikOISKgJIZGihsVdoYflevTDuwDgLsEM/?=
 =?us-ascii?Q?+IoTA0EA/YhYb/x8xj9B0phSLRtfD/uSnWoR7vHGxTr4zzmhZ27Fwdq5TmAX?=
 =?us-ascii?Q?iKpp/M8RJRL0/2FK4syErrLFKWyokWApBOthyeJ7F40LClzdvfud+RD1hfji?=
 =?us-ascii?Q?ftjGmCXfuKkvbpYcyENq7tHrrDfQbgFXB27syhVl9GMKWX6cUIpdyHAddPnR?=
 =?us-ascii?Q?MBbFLCKn4pDCCh6Rdz6MB4uOp7e09+oLmbat3sJWG3UPzRSWNiYpORk/KR/9?=
 =?us-ascii?Q?2/mv4Zf6QANgGr6cx0txlv5taZEqfLbY8zCdut+hIe3xdfucbRNeSKcXf+Tt?=
 =?us-ascii?Q?55KaWIoSvcoNjLyOKSJGp5clvKR44E0a6+nJnnHuDUpRkuacrsRiD79fb8dl?=
 =?us-ascii?Q?BjICsdYkMjZa57GPs/vmseppRQFWbNF34TJRqD+4a5NwDVY6KycFGTbf5RxG?=
 =?us-ascii?Q?TY+Gm2+bO5F5si4i8C1T+dWbCbmXmhlOyJZs/mIHAEHYdBYl8K11DuwojkoE?=
 =?us-ascii?Q?cL+i2aI6gITcwXBghseK+kyPcsURkzMM2ZrKMerdxsvdADWcdGab1zgkDJFw?=
 =?us-ascii?Q?tC0eJf1z6b1iYl7Tnj11PPPzP76yziwuRYQnCaKjPEF4ZbZ6wBYQPkORV4/o?=
 =?us-ascii?Q?mL1hwCSPm3/B3ctVAv8jReS2/bZ+b44QsrZMCbRI069Z7ktcyfX7+NvvhzJM?=
 =?us-ascii?Q?N5UZ4EuNUFi0Z/2u2eXePxUBEaqjomH0Xnq3A6rOwI6zILAsOoPzOyBH582Z?=
 =?us-ascii?Q?3BtOTq5wjbUX35cb+W8dPny2fl8UPItd3RvHDEx9arx500s55mtHeHi3S0d8?=
 =?us-ascii?Q?L9QpdwmxDOCFw/TEf/G8BLDUiqa/uskhafBGwALoeODFluFV6VTau0wgrKFD?=
 =?us-ascii?Q?ZxCYOSN0ttsBrgApnVkTZwM8uk44BhinWZYcQ4ZJsX4dbn2xulwRvp+h1nu3?=
 =?us-ascii?Q?xETpHu8Cv+XSd281LztbXz2W0p7cop5IA7vAcnByv5uSahQGR3ZRSbF6k+L3?=
 =?us-ascii?Q?LW+vYCmYOQ6wDvu2AffJiMFBbBskqTTMPUVevOtEgX517Oz4C/Ug1X6ZyIbg?=
 =?us-ascii?Q?mHCVZ/DMpqYUT5u0V1zkG5sGuCyUUuoE2O97AgEkEKl0IvSNykYOHvohWjU+?=
 =?us-ascii?Q?9+nNOAVx7Bv/z7jxkGWDEFeqlfm4VKLtbAgC0m318mDsEMunyaWp4jcntAHE?=
 =?us-ascii?Q?CGROSuMU0bxfpk3Hk6K0P3sF1HkxJZrr5Qwbaw/+tD7BA9XlXLfz99UVtCy6?=
 =?us-ascii?Q?ryGNrmOOG4MyctndlucJ6JIPogtlmw4HPUWnLbMJBEkSNHP32I5bA6gGTLXB?=
 =?us-ascii?Q?LymsDwuz+MOTDBma4xlq3zpz5O2htosmz9ESx98HP+xqpOvnoNBQmCJcVDd+?=
 =?us-ascii?Q?fRuUfLW8oWZfmuXcV468VJQoTOtbZCc15dtn5ZrX1kmgz8/5vA8oHvwGHe9T?=
 =?us-ascii?Q?qfcinc+GB14mKVSDqQ4J0JCoS3hCs8iZ9x1OJkw0T1zqaFLi6/ulyo8vKnWK?=
 =?us-ascii?Q?AfeDOo832DVEutEFsuxYjFM0I1SAePhH5crmx8GJN4TUSsd9Z06sApixYTO8?=
 =?us-ascii?Q?3Va8UAsNwvnu42NuvL1tcvAOpMfvh02E6e/WAtmudZqZ/jw1cVu5FE3RvxNt?=
 =?us-ascii?Q?FY6QubbAGQ=3D=3D?=
X-Exchange-RoutingPolicyChecked: tQFSw5DOBx4z+pC6Tkij7wgPQ9Y/qo0yGb+bA/4xPIyYoYd5KV1LWucaPO3tVNN+WijE7MJCuZqRb0uVfaLu/p+bju7IaVkG5gpeOW8zDB5Y//1+ssiDMYvMDCocMrIXIEQ+MrR9LCT6mSFMlYq16KzVKD1O5IE/RsB0QHLI8Z6pfjEUCk2dAh2gOlKfoc51k80abCuU5VIaiptgysOEJbriMJg/h1N8N6IbjQBiFqsdeizy+k0OrSTK5GsA5PRWLtDpvK99nrUv5IRtBnVGrEC3FTm6QVtCpNfKUB3jcmzwyjEObYL06Vge6kk7uNoMgu2HIG3iVAT6oLWrbFlL4Q==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f10187e-56b3-4cdd-15ca-08dea1e0ded9
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2026 09:07:11.8642 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q8AgzM+gUBHhbJZNvBZtPQGjqdv/7owYt6truSfxZ+Ey5uDkvlL6HRmzflzFvITnt59K1DEQ2q0v2Uilwtfuiw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV4PR02MB11003
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI0MDA4NSBTYWx0ZWRfX00VUhZtl3ATk
 EIC7iehUBTwCG6/yf7W2x52aB8lWtE5HWlZ7KgP48TrdoL1DBF2PTRXooe5vpoY6nJprFsb6H1Y
 HlmfGNXbCxmBO1ILYdd9/Yy+N07ES7yxh0En7gVKXZeANAK4jdsn3Fj+UMv7z2wQegEa3xwUI+U
 AfoqF0erIFTCxcRW6p3HYLRy2xd1mbUkb4kIf+enOJKU5MomDpkwwBcXf5tAiHiQ3iEmTVpIF7D
 QDA+QoCfZTtoq390b51cEIZNpycZiU3tYwPMmVZAABoFoEnJKUuqUpy1sHjDUdnoswMk5NCt3BV
 WAFPy/iQolrLeawNUHGZbUNsvZZsid9VQslU55PJQoXal+WWS+Y1OHPiKpdX91WjAH6K0QTH3Gt
 9rWzqMpfFAYrmge9ZEP756E5/Gw3FCPzheS3d4Dl4ULfbTVADniFmUjnBYgrYGmnMzzvS+6bqL+
 Ln2tE7voxidc9b7QlfA==
X-Authority-Analysis: v=2.4 cv=JdiMa0KV c=1 sm=1 tr=0 ts=69eb32c1 cx=c_pps
 a=HNo1bxtHJBcBpsuwJpMK3g==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=A5OVakUREuEA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=_-M8LpHI31CeLmyZm6wg:22
 a=64Cc0HZtAAAA:8 a=f_Dcp5lQLZwFyXdpp3YA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: 78jyedVSg6TW9NUBIFYcww2dVB0G_ooS
X-Proofpoint-GUID: 78jyedVSg6TW9NUBIFYcww2dVB0G_ooS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-23_03,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=john.levon@nutanix.com; helo=mx0a-002c1b01.pphosted.com
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

On Fri, Apr 24, 2026 at 11:12:59AM +0800, zhaoguohan@kylinos.cn wrote:

> check_migr() sets an error when the migration capability is not an object,
> but still returns true.  This lets version negotiation continue with an
> Error set and reports the wrong capability name in the diagnostic.
> 
> Return false for the malformed capability, and report the migration
> capability name.
> 
> Fixes: 36227628d824 ("vfio-user: implement message send infrastructure")
> Signed-off-by: GuoHan Zhao <zhaoguohan@kylinos.cn>

Thanks!

Reviewed-by: John Levon <john.levon@nutanix.com>

regards
john

