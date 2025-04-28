Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 880D1C369DC
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Apr 2025 15:27:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9QNN-0000UQ-2w; Mon, 28 Apr 2025 11:26:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1u9QNK-0000U3-Tp; Mon, 28 Apr 2025 11:26:32 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1u9QNB-0000mO-IR; Mon, 28 Apr 2025 11:26:27 -0400
Received: from pps.filterd (m0127839.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53SDRwlt013771;
 Mon, 28 Apr 2025 08:26:12 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=wIBi37KbOob0SiA21dBIbPh7u/UnDWXm9iNvelCPo
 24=; b=jsnCSTL84C7bHGbwxOhB0G9uYbD7i1+jNl3imy4oWUJCVcl34cKojVkrC
 yTL3hy4O+nINsjrnq0oqeMrkXavCP3KC0dPlp7z6us6RlWisf/YHdvCv9y0vhEB3
 S3PfFecOSkvxQo3dk2seBCkARCjgcu3H1j62TpUrHhUv+mThEVEKgmv3vGewNFvs
 D3rWoxblZ7QnZ5Swj2qX+C6mRXqXwOWSIS+a6F3Lw0mlD7nGt1tCQOb1Isug2l9L
 neE64fUAmTMLyMxST2NXh1Vj7CWu0jeT5SeYkNNCvRXWPbT01UytPYMWGoTZGAtd
 TZW0Vm7o8X8GddHxqLUaJlAYLsJgQ==
Received: from co1pr03cu002.outbound.protection.outlook.com
 (mail-westus2azlp17010003.outbound.protection.outlook.com [40.93.10.3])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 468xjjucbd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 28 Apr 2025 08:26:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ianylbqfxqEB4TQQyX3naYXgDilsxVAuRcs8Rr2Yyhq6mBGW45e4lVQcmbQW50K17S0W76WsoCcgxWtfB0z30junLCRUfTzN7nje4VL6JgrAiuGxOmbgfIYTLvUm8lwX68etmqSx3GyX/7yPrR1lJi+tEI02Thi4MOIUgFP0jl02p8nttX/xi+t+nhz1xlsITGA1D90dz0aAQnwSwo3+n+TzI0S01pcjkA2hwCda2bvPRWvDUORWghltPmEfmWF+5xmmyXHw9kJd3dh6D7+T2zaVDvxHmVvtDJQRmQOS2Qdnja8z/a5xOUdD7/u+LLONSlFA+gi14pEEkbe1+fFYzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PboRSLo+FfOYd2giFHWC1ICTkbjy5pqEkmEGyznpxps=;
 b=xuXyKY+HXp+1In2AW4EAZzAiOMsA/a9Ymb+McOHl/4n9lN0X4kTRSo1OaYTKQnxasglMcuUNO/rNzc0jNZqa+HMvOasAvyv/SQzFYH9j7OQxj77eBQSGWv0CD6F9thfrbdhlg9DpDIXkSYic+PmQHhxojp2mr1aXChfcwQLCKJ9RACm/CCJ7nMlme3jq4iVL12QYboSJ2rC61bT7rEEEXH+9RVvj1phLdJWNbifYXLF6XWssVkqBqpbIvOTr3yhlMVSCEW/uQGyDPrlwRdCXP76m873punWDhnDUeOEWsdlM2SsB4cf2uHfzgJZhGUeOvG74Dj4cTLkJb78xnuF9PQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PboRSLo+FfOYd2giFHWC1ICTkbjy5pqEkmEGyznpxps=;
 b=IMHnYjpfaafo0i9sZCPUqcjfA2MYzQ0ZnV3sxd/e/179wPVEd6VD6J+12xn1Jomyki9ceU7RLp9gB3Ex+1VvUnf1jnv1oTVZWtDFP8wIeVpNSizR7nqJ09JqxcDb3OjMHcCuNUoQPdkEUF3HpscQock21kzyrV6s9akgJJQGvCG6z6oAYnJ1Dj+kaOUKpWLEEQQb/Ix34TGY42Tpn9vuf+6/M9FPcw8Kwn3XwI0JZTlNoJdQFzG+N6svb/1OJUOC0O2zUNQdFlay8Q7Es/5yZM1GkVsvYJtrGY1ivK2BhG6oY7E2Qh6+9YMN7PlujPdrV93el0TtT8JTyHsIt8UuTA==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by SJ0PR02MB7327.namprd02.prod.outlook.com (2603:10b6:a03:29c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.17; Mon, 28 Apr
 2025 15:26:09 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51%6]) with mapi id 15.20.8699.012; Mon, 28 Apr 2025
 15:26:09 +0000
Date: Mon, 28 Apr 2025 16:26:04 +0100
From: John Levon <john.levon@nutanix.com>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>
Cc: qemu-devel@nongnu.org, Tony Krowiak <akrowiak@linux.ibm.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Peter Xu <peterx@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Matthew Rosato <mjrosato@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>, qemu-s390x@nongnu.org,
 Tomita Moeko <tomitamoeko@gmail.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Halil Pasic <pasic@linux.ibm.com>, Jason Herne <jjherne@linux.ibm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eric Farman <farman@linux.ibm.com>,
 John Johnson <john.g.johnson@oracle.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Jagannathan Raman <jag.raman@oracle.com>
Subject: Re: [PATCH 12/14] vfio: add region info cache
Message-ID: <aA-eDAyp0ITO6feY@lent>
References: <20250409134814.478903-1-john.levon@nutanix.com>
 <20250409134814.478903-13-john.levon@nutanix.com>
 <1eb29556-a03d-48c2-91d0-b4934b226e51@redhat.com>
 <aApmSCNUQsDxh9hX@lent>
 <cc1c765d-2eab-4acb-a5e4-48521d51976e@redhat.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cc1c765d-2eab-4acb-a5e4-48521d51976e@redhat.com>
X-Url: http://www.movementarian.org/
X-ClientProxiedBy: AM9P195CA0020.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:21f::25) To CH2PR02MB6760.namprd02.prod.outlook.com
 (2603:10b6:610:7f::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR02MB6760:EE_|SJ0PR02MB7327:EE_
X-MS-Office365-Filtering-Correlation-Id: d1fd3ba1-0283-4265-bb20-08dd86690034
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?V2+cwoukl2yhp1P4WjRGF1E1c+dJHTpXMBY5VDmI7IxqfgQvzc7DD+zbSY?=
 =?iso-8859-1?Q?jxgDgNC3PpWjrPi83Ak9MVHm76PAy55FkhwKRyDoqDCpO14ho2oJgTsUJi?=
 =?iso-8859-1?Q?X335L1bJ18/dXNienfPuZ8D87etG87216mnhdXXEthbNtSG6fHTbhwQ2dC?=
 =?iso-8859-1?Q?SCQ7rcFP5G4hA3F7Drjowb7rqyJlPJRZALQny/6ou+IAUqMjNYNbPwRI5Y?=
 =?iso-8859-1?Q?ztbm1t3AMn3NmD/eeZJsxUCOjTBh90gdXVTa+HnNbOVNANYsS6OWdh+F06?=
 =?iso-8859-1?Q?heLyneC1xkq1nBBwJyTEjneAvjpWmKNSfXfs7YPXgmwCaaPSRwJ0+r+ka1?=
 =?iso-8859-1?Q?3ZgOFLga/XZzaH2bXSqQQjOrwFKw8FVKGOxriDRML10oo3/uK4Hg3F6U/W?=
 =?iso-8859-1?Q?fGO+b6vZF+Fd8rKkoNObyuFvPoqI/Qvo5YctMbegZt1gTHBicNXAwLk3Wr?=
 =?iso-8859-1?Q?GTSDiKOOk1f+Dw1BatBX/O40T7QKUvjq9EymcPzicT/H4pFKyEMnwtWHrH?=
 =?iso-8859-1?Q?vn87OTstHbnOTiE3gZCKX51RZPA7Qk/aelA/+Z/Sh+tfhmPA0pGGgcTJ7v?=
 =?iso-8859-1?Q?seDcoeeXqe5lt5a0TiAxoB2UXzCcHl2nQoFR4aYW+SFtc8e/rGDDZGcwBa?=
 =?iso-8859-1?Q?uj7RyLcM6iEyHgSoSdzl2sK4LYBRzOFFxjsInj7+nVAAd73mR5l03aRZft?=
 =?iso-8859-1?Q?RtIZyzID8KjIAvjT5cyKRxP/WTH4WNAYQPJcBDSCf0xKOjHw4jlmdx7fFn?=
 =?iso-8859-1?Q?I8USojUj5YEMZZqLyluhzhLXyNwQUJP/a5Gvx5Uo1pUFa4f2MEvzTWY3dG?=
 =?iso-8859-1?Q?oLIa1abCqUU3fSGI2Zx01O+GUr8Ipfpm6U5YvNV8WSCaA1lzsxlXaxPGJI?=
 =?iso-8859-1?Q?XlTX4JzyJKqqWOPnzp+ZkcT7KDPQ8Pv2NahGFiWqxVHq3RyH8Mzv71tYFP?=
 =?iso-8859-1?Q?PMVV0fXTOnTds1CabQ+TrlAs9k0s0lUfD0sSZEGM2yejeJjXJqwB+YvQxr?=
 =?iso-8859-1?Q?+TYf3sSE0sZIURBhzcx5/BiRi8gICtoE3b0BeY3+fOCVU94vpDAaNOcdFr?=
 =?iso-8859-1?Q?l/NPdtTeCLkcp3JUaf3woEY0mtlfmRqIsOQ29QtzfHBOyHp0vvz0lpePF0?=
 =?iso-8859-1?Q?SRf53Lh76cbrFFUAB87jJWq+cf+71yjMhANJb9JcM39H74/qNQ+tR6XNsm?=
 =?iso-8859-1?Q?FmWkAZE8+IX+8gULtDNnrj29N0GEKMjLpuTgHI/Vx25BSJqAoWEc9vuqj0?=
 =?iso-8859-1?Q?bfJvHSXksoHvW6wDuFTdWRXiUlSSpIW6HAO0gu+I244akuEq4c1P5yaQgE?=
 =?iso-8859-1?Q?kxdWHaXUNXfbGjrnd2MNHpdsLlAiKlFas8F8eTLOfCLFMksGiOF16X3rgS?=
 =?iso-8859-1?Q?CPAkRMjNtw8eNZH9l5TazSq19uJwXkaDTrBGgQaLLf9rzu3BiqwDnBr6jO?=
 =?iso-8859-1?Q?tSVAK137sJmXNYNvemhdt7NSKY/X5zWq5QlZZQSQ2bxqWbIOoMltWHa6g/?=
 =?iso-8859-1?Q?c=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(1800799024); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?++FxN+IhT9P2ss5EVGdsZuzp9E7NQxlFRp4D6ePR4jJMXS4lurjYclupFu?=
 =?iso-8859-1?Q?5mHW15SEmVzNn1KSkI38H57tDneTJCiL47kWPOH7cALOo13hWp+vt+7VyJ?=
 =?iso-8859-1?Q?EcZ7IAtHhr4GeN1xREd2tFJcBDRHFtQGnHov4jzsszb8EGJc4cn/9mlETM?=
 =?iso-8859-1?Q?WU5SXeebMR5QXuD95Yt46FaOvyosgKtOrk0ukMYjafg14Rof3vtOnTunnW?=
 =?iso-8859-1?Q?5Bhq99RetliObSsTBwXu0pjLWRxqIXicufUoTNol4YOBn/GGv5C91ElvPo?=
 =?iso-8859-1?Q?cYdh6MIbh1k5CAlhtUXuU299VxKJMwZOdjfbwr669zJstS/A15LE7q9GES?=
 =?iso-8859-1?Q?daFm24XAL1GnMumM+WbX5OJqyg8xnbkcz3bpaVot+X/gaLgXaGTC/7qj9F?=
 =?iso-8859-1?Q?bBIdD5pe2xkneEMR9vbh08H14fPPLKOlOKSK9Rh2SE7ufTLOHfi4ASxypu?=
 =?iso-8859-1?Q?rgBIbLsIRBm4eR6E1NUmBgAZEz7JPhpfIzBLSHe18Bba3YClBe4DYHUryy?=
 =?iso-8859-1?Q?iDiryyOiNXi5LOMrYUNiKs2bIBiHDN4BSKa4Fx0hU+nJh27MWklPcaeGfd?=
 =?iso-8859-1?Q?nEdWp4AU/0zNRmI17w2VA49KJQtH76XVXr/oYyJmohy8ORVUOvIuOGqYwn?=
 =?iso-8859-1?Q?VwO4Fu8cF6jU3bRLt24vmYQ1Ky7kxCrEFLD1nHCnrYu7Yrn1xf7SymFJrx?=
 =?iso-8859-1?Q?HBsGcIsQ44a6DFt7v5psUHvwuQeQMhe7/B6UmeeHDaALfJ2e17MhGCdlJk?=
 =?iso-8859-1?Q?yJWDTWphViiXZYiMaEBd9BK6bpbFpRC/jUmq+keVQi7hNNbbkcwM8XGmwa?=
 =?iso-8859-1?Q?z2EKaCf9J86F6Ork/zIE0saRpfsNmWmLi5EzK21jgPCVNwzJWlLq+2BuqK?=
 =?iso-8859-1?Q?lWOtmBz1PJXeV2DV7j/tIgYBv7YxXgr84uZdSvy4Phv5CJgmsrItB2UTPs?=
 =?iso-8859-1?Q?fR90Num4zcHgBUB/o6bPFCcA1m5XPH++0qp7V1ySDZuMAKiYqg/pL34HqD?=
 =?iso-8859-1?Q?qLso8+DaR99t4BFB4Llpv1AE3QzyvTxwaEYf5SAI/NkHs5/ztHjm9vRJZY?=
 =?iso-8859-1?Q?mcD0sMkq3XRE+KTfDgFDzQIz/OO+xejr4oPMEwUs6El1b6Fu2O3TQLH7t1?=
 =?iso-8859-1?Q?A7gMQOsdd6RY74PhhJVtRNb4quYa7d4hkwcC4sFqIm0+TtU+nDGWjypVp+?=
 =?iso-8859-1?Q?pur9J1niMSesu98A6i0Lrz2b2sjoJqIdfTrEQesVvWJmCAQHIJMH39sh7e?=
 =?iso-8859-1?Q?x9nvPuDnTyIa7l0rUMNrLRcGHY7mpS74BKcU2nPWzRFO4kdoG6SWruzBVo?=
 =?iso-8859-1?Q?aYAQeCLRBiUZNpr45NbQ/fwAOTVHph0jUcIeNNGvUt46eDxK8A/fR2qs/+?=
 =?iso-8859-1?Q?qtyrr1fbhtU/briOWTTyIAQQifrvfGz6HnVNshAYPdrhqNUGdIw22Uarmw?=
 =?iso-8859-1?Q?xz0Id9YHXS1I2gzJUUJowbtDBh9bwE0hg6tzeYWW4vrxcnNCCSO0l+cKQp?=
 =?iso-8859-1?Q?+oeD/ZMufrlMJ2ZDJkuKIjenRAYE4bMShXx4zXqwnS5XhS8jrDJ/zDyg9s?=
 =?iso-8859-1?Q?06NSLL+GHGYyBav1dDIDTMueCemDB73YBVULkFUHbLjVtZT6vCb4nBb/2K?=
 =?iso-8859-1?Q?lvEQDNzM1QBevdRHDQ1u9t85jv0prwZF7H?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1fd3ba1-0283-4265-bb20-08dd86690034
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2025 15:26:09.1208 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cMkhtadUhLQHpoK/MQ5zQ8HM9bBbVqKO1p3wMiTBTGcBSBjdoB9iCfVUA79qH8PBsz4mBODt/Hsycf4Sv2k04w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB7327
X-Proofpoint-GUID: 8K9wqYaWCeoQHq6EZ_tvBm_6OptNVbzQ
X-Proofpoint-ORIG-GUID: 8K9wqYaWCeoQHq6EZ_tvBm_6OptNVbzQ
X-Authority-Analysis: v=2.4 cv=RcyQC0tv c=1 sm=1 tr=0 ts=680f9e14 cx=c_pps
 a=aBehHGrvSf44cF3hBtnTuw==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=XR8D0OoHHMoA:10 a=0kUYKlekyDsA:10 a=kFkILWEV6sVq6p4-14kA:9 a=3ZKOabzyN94A:10
 a=wPNLvfGTeEIA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI4MDEyNiBTYWx0ZWRfX83VQxop2Sd35
 0sc2hrZqELrSp/Ufx0CwFKoyVE1o4sU4QY7gXAc0tR9x7SgdjuvitsidpAQrWxheXFqvxEDsaTL
 8jlbhJ2eCopDSCzNy6S2Lav1E4WOhKw3QAHpAqmAEdd5zI58LaL58hf0wH00+W2jOhdem+EXvnf
 N/14xC+ZmuNvGm5jIl07l+PVZewrRYG2y0JDlUasAEkEWy2LGaEmU89069dXqKTyVeVJ0Z7jDo5
 BjHXc54k8FrOc5LHt5jXNv0gOQQAg65wDKu8hGG+LV2OGVa8Z9CfwSMAI7EcKAj2Gbp19C6zIEE
 cGwqlDA8LeDUcq/9vk3V2jR8vmr+ipuB8SNDr6NGLIv5/2kQNTPkZs/SuEsX80zg8dQ3OvDRela
 7X4pb87DZx3FOkvxXWYvizU3nNi0Xnc/XhDuXaw82hr05uC6qPTVZDq23lz55pQqyaTE7SuR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-28_06,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=john.levon@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.484,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Mon, Apr 28, 2025 at 05:16:50PM +0200, Cédric Le Goater wrote:

> > i.e. every region read/write needs to look up info each time?
> 
> Oh I didn't this. So the introduction VFIODeviceIOOps is not seamless.

Correct.

> > If not, what are you suggesting?
> 
> vfio_device_io_region_read and vfio_device_io_region_write should come
> separately in patch 13.

OK, can do.

thanks
john

