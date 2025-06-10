Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2D5CC5B552
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Jun 2025 16:55:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uP2Dz-0000hI-O9; Tue, 10 Jun 2025 12:53:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uP2Dm-0000Jf-LX
 for qemu-devel@nongnu.org; Tue, 10 Jun 2025 12:53:11 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uP2Dj-000108-Hk
 for qemu-devel@nongnu.org; Tue, 10 Jun 2025 12:53:10 -0400
Received: from pps.filterd (m0127837.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55ACotWk026285;
 Tue, 10 Jun 2025 09:53:03 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=e1/Za3aW8UtedA5no9sUlaZV43UWaEBAFZxWP3Rf9
 pE=; b=pB75h3BKergm9Q4TCHJvS+t+ar6OnAtuobDWntqJ0DgpUZM21qWafrBXz
 QjZSrUtD+ki710ilN3LmqvgzKDDc/RHo93AuwdRVt7W8XP60dAm2kbv950Mw/S/O
 I832esXwwOVs5+aApKcVRwURQrxnueZzgEjNoHyi7ZVOh+1FgxUlXpO9gxkV1qJk
 3XZ/OfU79H+AKBGgaF0Q4rcRiiF4uXzwl31zfgqEdI6f8sL+A6b4j8s9yqC8+HS3
 9CHG/d4V5xAndDFZanMVv9wcd08VSwpTuscL8LbmIi58oKkPVCvJu34UbnP2CqgN
 1PzoefQxb3Hy3KdbkIxGfIQPEC6MA==
Received: from sj2pr03cu002.outbound.protection.outlook.com
 (mail-westusazon11023089.outbound.protection.outlook.com [52.101.44.89])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 474hb9xgm8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 10 Jun 2025 09:53:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QwFoZGagsYTYuRqBAzoWHVgt0VmSulWl/SUewBUeiKpqPH4NxaSoaAhaQ4CTGHlk3yNGfWdNnSYoTBFCZaY0bPQFDop8EWwZggRoNwVoJL4CcvUEfDGqjPl31fXLh1sYrgN2LSDa9rw/Egsw+3o5bBvypeT1L9eY2LZhRxG7vRpA8gFFs8U8ZqswSlJ2D1S193m025jwN5OVdaGcAzMPEw0ARyg2WXMFeSVlHpua8x2xiadN/JMpX+RCHqtlzGTQDig+/kS749xwOxq5xiYF4R1w9B27TTIsjfLtE3nKzGUHOza7h1pmPluZBcCr5UB18fanY38hA0jZ5HvAFe9BwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RZEBPmkBZUcaN5BYWnBAbEVYycDCyHB8n9QhWrA9erw=;
 b=JEXsvpLxX/u8kdgvo3dRUJHgKS+Z/yjLkAw833hHd3zAfNXNMgdTOQojphL8nvbFbj8ThfblAwSvvAEfWYzvd/s1esF+74Xi1UK3FQ8QVuByJTU6wwfwlVp3QqErbwv52vGabo5HaLinkj1H/7u929PyINAnGvrGIZr/HBQB8Ewj9stD9cZ6ZlKWWqgh/XNQ6Gi9b9htPpoSFd3diCUgNdH7rDpJBcto1Nkvtx4visPJpJD2saIZnXCk5AtAt0tWyXAyje2mc3HU14cqVPTzqpIBI10rQabuH2xTvDtBMoDWKc4Fq+AmjmkkIF65grYbmmd0HE8pbJQKtic/jAr6bA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RZEBPmkBZUcaN5BYWnBAbEVYycDCyHB8n9QhWrA9erw=;
 b=I2aEg2aLV+a4bsKi6QUqs2XxCmaclMvVH1Ln7B/BLSmXtHyN39zMp3QqNC/eOLiHEcmPJIjUuEansVxsvsqXDuUEWroUoaRRRsi3daHzl7a8esj4r2inKNakzDIhBpFT6qyfNFzy7Ae9k24I7C6wxbUbf6W1seQOo2m1bY4lUlQIH/a4OzlnrKQvjM8EkHjD9w4fMNggGt1tf4gPvGeffxyGU0evEWuLBeD0hD1HfR07F2z3SJ8Wgr6D2WNVqdO8H0cHhjfRQoyWKdT4qOFKlhivUaJiWI79GzYlBB+F7iwfj/Zz+lnUjIFLig5/+4qlhJM//Y6gHe4GfHcUQ50AnQ==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by SJ0PR02MB7486.namprd02.prod.outlook.com (2603:10b6:a03:2a3::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.18; Tue, 10 Jun
 2025 16:52:58 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51%2]) with mapi id 15.20.8813.024; Tue, 10 Jun 2025
 16:52:57 +0000
Date: Tue, 10 Jun 2025 09:52:53 -0700
From: John Levon <john.levon@nutanix.com>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>
Cc: qemu-devel@nongnu.org,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 John Johnson <john.g.johnson@oracle.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Jagannathan Raman <jag.raman@oracle.com>
Subject: Re: [PATCH v3 06/23] vfio-user: add vfio-user class and container
Message-ID: <aEhi5cVljVfjTvJA@lent>
References: <20250607001056.335310-1-john.levon@nutanix.com>
 <20250607001056.335310-7-john.levon@nutanix.com>
 <c0fd6bf3-cf0b-4843-a7ea-6ac49480e7ca@redhat.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c0fd6bf3-cf0b-4843-a7ea-6ac49480e7ca@redhat.com>
X-Url: http://www.movementarian.org/
X-ClientProxiedBy: AM0PR10CA0019.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:17c::29) To CH2PR02MB6760.namprd02.prod.outlook.com
 (2603:10b6:610:7f::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR02MB6760:EE_|SJ0PR02MB7486:EE_
X-MS-Office365-Filtering-Correlation-Id: 5cda8fc7-f89a-44ef-3721-08dda83f407d
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?f0b0C7HwDozKD2uwQQhUAmn2L2OLpBfUVWn7ie0FyqJdDb4m+3DnypO/D6?=
 =?iso-8859-1?Q?pqELbgEcJzq5xUv7+I3O1f22PgUUSEzDOq6NXOczJcQLagARzRRJq2fjTV?=
 =?iso-8859-1?Q?FS8ly6wGBMmgfut+ttDgwSl+Lug3ZYQRviJhDcTNeJ60O9mIqSAuuqFKiq?=
 =?iso-8859-1?Q?+TP5lRpPs7yTa2aI82ko8/tu5+KqHn9fOTlLtXoL9dvl0BzZiRuZG5CEZW?=
 =?iso-8859-1?Q?PYvLYEgynYAt5BKpWS4get7XzRlGkXBh4n87Vp8yFxFVuhriNqAJpZQFlH?=
 =?iso-8859-1?Q?XPPKQaqvvc9wpUvJmvY3sUL6Qzyvp6Up+9d2ERaI0o1pj2EYEQirRS25+r?=
 =?iso-8859-1?Q?kH0heo1dMNUd8vWG7X6yPR8CSPVgWoCiotMzqtdJd1n30c93II6Kf7B9HE?=
 =?iso-8859-1?Q?IktsImk0rWGPcT+bRnAN3R5v6hUjTPW8EAyuGTkzXXBdmRx4XVY6Dfu6Eg?=
 =?iso-8859-1?Q?EuRa8izwTctQ0xXJEwfHLwhZGJkGhm8CgukshFbGzTsKYI915PzOVlMfqn?=
 =?iso-8859-1?Q?PRiEgw0YK/XYPRDfo3j+7v8U6g9PS2ek+zSiIYGVXhicdfLSYA71SORSVn?=
 =?iso-8859-1?Q?K1Kl7A11XDCXfF/jVdTf6qM7THQTGxCTSeEPDO858jzZEWoN1ACxmhVOld?=
 =?iso-8859-1?Q?XjJbbSTbhM0vHEVlseGQxe4zDNGaqMQpPMBTW+llhc0imSI2jQLnEMbr2q?=
 =?iso-8859-1?Q?sKcBrNdSfuu0FWLWVXPfKkawtcJkhNLalnqEUe4cQNCxeS+635vV+s/TVl?=
 =?iso-8859-1?Q?Q8LgBn1wajoPHKDzmGbRNqdb/hJUCqZUbYhXeXF5FdeoggrQd2fch59UW8?=
 =?iso-8859-1?Q?r04x963obakp+6qn2Cs47QlM7jNwfY5JDTideI+dC/ilVWYdblQTeX+tbC?=
 =?iso-8859-1?Q?fDe49hoC/UEWy1kzTHTOmiNqzT9kqa/JLK5sfDrJND2DY19j1oehyWj7jV?=
 =?iso-8859-1?Q?qOgXsdaZywZ91AaJpsEG6eUFKzV3MZ/wGsrJFWgEY5JDEXWOCP5nNdfqfu?=
 =?iso-8859-1?Q?PWlQUkT0qdf8SDD4OukSkUJmlLUnN8WucZ7iMU7e3/wOe7Aap4eVr9iu2W?=
 =?iso-8859-1?Q?G3TdNRr1AQ3bS1bnDjkv4k3395w2WtcZ8chTljj7/VurBsIHHIr29hEBdG?=
 =?iso-8859-1?Q?hqMJDLSJUpJ5jwyZjZNnEXpv7l0MvVlnSYry7uD5C4Y1x6mfQSH0Csl0o0?=
 =?iso-8859-1?Q?8biNSksUob6BAiJ7JrhPQewTyYCvr858y5CBwnPZDQaH3mzSxmb2PcP7gj?=
 =?iso-8859-1?Q?3RyjhoBzbYerewnxZ5SHa5GUIeq+aVSUHmXLuc2EZeQessYjhacWaOYTdI?=
 =?iso-8859-1?Q?SzMCHuL/8e46eqO97cBqs0agChUKhr95C/kQg0D5BdDIWcXCWl7nn7q/G8?=
 =?iso-8859-1?Q?PU7Y6yM0ZwiiNiM8XQuTKU0bvpJp1BAbAA+7Df0oSdUyq81+NIoqciYFHE?=
 =?iso-8859-1?Q?JPmLUrVkHdzJWiUR82ZkVUP6vmzj1zsM8VHWzrY3ChPIPlOl3ixd/bR7+Q?=
 =?iso-8859-1?Q?w=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(1800799024); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?XM2KlHwWd4r0khB1Wt7FqQo1mny1amNMhkrpN5b8OAr+4oBC+Mky0V+JEj?=
 =?iso-8859-1?Q?2hLvWS/yKAPV+c3RfkkP3QydwRsviO7BMvvWFlyKvRrpTxeJX/osQ1QUnf?=
 =?iso-8859-1?Q?QsYJ2JE7FLIB9xysrRzajUAMRDv5hNmGDm8oAQV+jI5nTuamp3Z7Fx3ThT?=
 =?iso-8859-1?Q?Nxl11ICPsMARfK73FxQaBN20Echk8Ni4Z9d39kshPon58sexKAq7+KppJE?=
 =?iso-8859-1?Q?/kIqbadD11qqM6DWE59s1A/+EHZQyqYwMdzKwj01jwb0wPz6zqszmyd0mA?=
 =?iso-8859-1?Q?ynu9nm0vWg+Scsa+xVqkmBvrBwZfNHYOPHrZO0vxDB1HHyUxDBw8tYnuZ7?=
 =?iso-8859-1?Q?xY0RXGov8TFTc9kYNW1r6agAuOnCdE9Lf3gsAwAhp4vTwKF1atzIqWR81v?=
 =?iso-8859-1?Q?uKjpsOFmleKUhW9lgvM6Oj5RJ+KPrr0YIZwIAQkucEVpUCk6yKrSEZkCtG?=
 =?iso-8859-1?Q?n20BSZHt8vEOkngPITa/XuEEVW8GBdYt7mFGPevPPaOVOJt4KiPesV9+Me?=
 =?iso-8859-1?Q?W9mLdcXfT1vKsfoTOLh1dMtqzx0DfBpvm+tNTbZjMULT4cRTqOe9IpaiDX?=
 =?iso-8859-1?Q?QMO30ess/Jdl28JQApB2mCUQBR4BU4E1YhARULKXp5JVvae0/eoQePv/Mg?=
 =?iso-8859-1?Q?8/rCsP5uJRb14MxuBAakBnI7/QKpSzwQrKx0C2GUcMvSS7uE19MZWCiJxe?=
 =?iso-8859-1?Q?ZlcqAb+jpqU4nojjFRaa8D0JLFCe2laPcwSBk5CMutfWvCmq9uX2pf+gKX?=
 =?iso-8859-1?Q?ubpkYeOWFVWfaOoztJoEFD0NY75mgeTyCEwiyng8BQ2qG8TIwp/4GpyQQp?=
 =?iso-8859-1?Q?cwMGe32Jj1G3tk08+5Kp/q/Ag6+4oHdVwJLsY2TjiTp1ZZEI/xvvoKtx2n?=
 =?iso-8859-1?Q?kjcskU0rmCPO6K24gx6CGz4fPdVCD1OcPVlMN4aczXPKF5SzL9mxotBwuB?=
 =?iso-8859-1?Q?czZe1rmadQPfQCmk67O8tvgesglKtKIFE6BiTZRWQz+2pLADuRnnc9+3Lz?=
 =?iso-8859-1?Q?zM4AYNBYxjSLdS/OwmaDaOl05G0Q+nl4L9lu5rxiZO+020llvAPAE4dC6L?=
 =?iso-8859-1?Q?oYTXS8Sk4FxYF/IC9bEQNMMHTc3VWsdeTL38f5XJtmwQHOiqwTLlC483+5?=
 =?iso-8859-1?Q?zYgkCL3jkIZimyHh1LHHn4FNMFSrDAXFNM00MkzKJOMLXymCjzMlBATNmB?=
 =?iso-8859-1?Q?C+fQ+5ULOA4Udie/2RM7CyuP7X787Hwtm2Bez0//TwqkOf1AKphdDvS6NV?=
 =?iso-8859-1?Q?pnHXjcdlVv3bZYgazlyM1yb3XarvAL/CVU1vREO4QAVUVPF/IRv+2eciHo?=
 =?iso-8859-1?Q?r9FJsBa1pHcoCC01DOX8iLrkhqFUdcDcd05ynUGg+v1MFacqEQwHcrgakp?=
 =?iso-8859-1?Q?qdCYn3qZJmY3Ml8+Vkjv0v7lh4sdciL4zruygrNJ6oVu69wWgYHW8/1BZl?=
 =?iso-8859-1?Q?bEAZQeGTyUhratc/pitZzKWv1bt/Gr/33B4HVvosClWQ6VhptXQuFQDK/E?=
 =?iso-8859-1?Q?/nFzOVxLMzp6vLfuASQqtVCvJsKXOHveF6x2DcmVPDuuArmeblwnXVxAR+?=
 =?iso-8859-1?Q?VW8kuGFzct+8EF84Rh3L5aLEEFRR8eeXz++E2COXEl9QRnUuM+lTszjWAa?=
 =?iso-8859-1?Q?ulcDOOI3gfsnqrrsXXoAKxQiWc7b6x8Ns8?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cda8fc7-f89a-44ef-3721-08dda83f407d
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2025 16:52:57.7344 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NTclVrgjg7df534lGLqEk901GJsEvSAF090U82MFdOHrdI+Ejbw1cZXctQ005AemHqHZshnjeW/TG7olMT8QnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB7486
X-Authority-Analysis: v=2.4 cv=UJ7dHDfy c=1 sm=1 tr=0 ts=684862ee cx=c_pps
 a=z0QN5Op/rnj6q1gqlpTUvQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10 a=6IFa9wvqVegA:10 a=0kUYKlekyDsA:10
 a=hr8cxo-3M2DT-3BTWrQA:9 a=3ZKOabzyN94A:10 a=wPNLvfGTeEIA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjEwMDEzNiBTYWx0ZWRfX7uMRJcrpOvXh
 teqHFgZGkpNXjlfF6+avAfHagCtdG6GHkTCjKijOfkxE0LWZrTjAJ8ApIzjscgHcta/nSJgiWdr
 bI/J/Z7p7eHqiCV2A5kiukg2jtMJRpka5scT+MR/f/lHW9tvpnCdFjeOpNzK18Jk/jDHv8u/gFL
 uidEQeJ/uIj2G3CnJRS8YLwaO9mxtwbEGsPKZMSSDRZ+L/u1T9SHf3vcT1AiAKz74zFKP1QwbiC
 iTb4nj17YPuShrSLjgglUGqTsLWCgT1MNGiBttAecUTI0kCjIWKVUWwA3IBu0RS6/hRLXBly9MW
 qZISj1v1pJHyM1VsMF9mvPUsIRAKEjbxpHZ1tA4U0IHGrpr1WqXfDCvirOtbfEaR0M/9tfH2Mhf
 J2r3KqGhkUYaVgzd5XZ5eYHg+uJYMiQukjmJMR5L2r8SoqmlY7PaezRcoD21ORmiURDZqb1y
X-Proofpoint-GUID: 5xluZYMsbjumtvu38aYSwSsrf-UJXjZG
X-Proofpoint-ORIG-GUID: 5xluZYMsbjumtvu38aYSwSsrf-UJXjZG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-10_08,2025-06-10_01,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=john.levon@nutanix.com; helo=mx0a-002c1b01.pphosted.com
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

On Tue, Jun 10, 2025 at 11:57:00AM +0200, Cédric Le Goater wrote:

> > @@ -529,6 +531,8 @@ _meson_option_parse() {
> >       --disable-vdi) printf "%s" -Dvdi=disabled ;;
> >       --enable-vduse-blk-export) printf "%s" -Dvduse_blk_export=enabled ;;
> >       --disable-vduse-blk-export) printf "%s" -Dvduse_blk_export=disabled ;;
> > +    --enable-vfio-user-client) printf "%s" -Dvfio_user_client=enabled ;;
> > +    --disable-vfio-user-client) printf "%s" -Dvfio_user_client=disabled ;;
> >       --enable-vfio-user-server) printf "%s" -Dvfio_user_server=enabled ;;
> >       --disable-vfio-user-server) printf "%s" -Dvfio_user_server=disabled ;;
> >       --enable-vhdx) printf "%s" -Dvhdx=enabled ;;
> 
> can't we simply have a CONFIG option and select the device on platforms
> supporting it ?

You mean always build vfio-user client rather than optionally? Why would it be
different from other optional components?

AFAIK all platforms (at least in theory) would support it.

regards
john

