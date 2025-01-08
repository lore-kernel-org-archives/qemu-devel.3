Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABE01E77188
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2025 11:58:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVUdm-0006WV-05; Wed, 08 Jan 2025 06:54:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1tVUdS-0006TB-VM
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 06:54:07 -0500
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1tVUdO-0002Gy-Gr
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 06:54:05 -0500
Received: from pps.filterd (m0127840.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5085doxh029507;
 Wed, 8 Jan 2025 03:54:01 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=T3z+rFUHzBeYOjacS0b3mDpI0PQfvU22M2trcvyFy
 Eg=; b=iW4l3pERwa5qKdcS6OIqc3fqqn4wHuf6JVYvljIKO/EIKuHvcZVbTkBg+
 VmIl95IIa99spThOqUlc5RTHTB4xsJF3Ys+jfPkRt3QWCQu3AqepFDn/Std8iJuO
 /u77kk2a/zxp9rf/A07nTveXtqotvG0dt8kDv5BRz0J+FxQvTC2aZASKCx5oLp6Z
 MW/AAfF/+miN3GHwiYNyTOf485NC/UFoKqf4WACQMubhSsagyYYxNE0g8ptImsXB
 AdJVLYPqedlatitQTUsC0fZtA3UoANSRwPp1e/J3eJAgDM9dfRqDeou2LcNNnfBp
 +kK6Gg9swQDbqTF+Nzr9WeoYB2RTA==
Received: from nam11-co1-obe.outbound.protection.outlook.com
 (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 43y26xqhax-7
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 08 Jan 2025 03:54:01 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q7hygQHhhbM4qBXhQtpApMRCwB63KKMf26VgiiYz/60Xthd9o1AjhsR3U37c8vcRtMOurPs7df8aiTIiyJgW3d3cbgvmu79YshTbmvU+OyDvR9Q1q6cSlYWAe6tuOjGqNQh5kCJTmvRpPgrG5UBECGHH8UVuBK31TKcURSbmZeKfFN8q+pt+r/ofZ4v5WQu90/JcME43xvm+AjHdBeKgtUpAY/EwZjkeYto46iYo1f/yixmaw1X2/LZAwOLiTykeR5dEerVvy4aWl5CuE8p8N3n8WqdGt+4SDqPJZz8gyHLCjmzTGnMQGGQkvuGzsf55Mo8PtKwlHrqvVsaYgkJIdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T3z+rFUHzBeYOjacS0b3mDpI0PQfvU22M2trcvyFyEg=;
 b=l8Dp9BrrlsooZbUBwhi05RvyHA+CGlzBLyBo+YtHxPDn6kNwnXjynR72k0QOaxwtYHz6DPB+MjppVlmyQRm3IXczEkjCRGtBoX5Cz4jzMsxNBV7cA6Me+0Lj0BrcEUOGoZk05AqRbPoFHkJmnDaz2Zv614dpq3SlgBrMzkLrvBFobLUMvNS+RtlFk7EHhpBlwhlhR36BiON8ikG0ZRkxJIqKUw5d/Gt0FYddXaZst9YQped67BOwiWmanCQ/38NNzppjvEFRRw6WV5gSlOWMaFGO4HizIMvsBl9KgCGGv92qczsozcZdtsDAa2FDUiQblSGXmPQHIYBTSDEIqKzvNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T3z+rFUHzBeYOjacS0b3mDpI0PQfvU22M2trcvyFyEg=;
 b=p9BI20luLZVMV4GzmrHRfQZEPFmw7PJSUQ3emn1be1lCM8LS15zwEZ8UPWWhd+w/ZRGblUsJ8n04NunCQkbsfkICEhoQYkRPSLDmFUcNQcjuyUWeoO6YuU38muJxvLP0FEk8OSNJTmnRT2+yxZLTpBtCUDZhoLafyYJb7fIXTzFThLa6k8pyFBjVSJyVDI5ralYuNsvTRCzJNVejXIggc7xZBUeco7I3DosvB4WhgBxCDfElv2+TWosa+FxXLRpZVHHahD42lCk48XHDbaY26gpsmcUQNpRX/3MHOSLwyu49FqW6/hyp584sLm0WCj7nrgcGftqo+xP1mFT2nzSuzg==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by PH0PR02MB7670.namprd02.prod.outlook.com (2603:10b6:510:50::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.10; Wed, 8 Jan
 2025 11:53:58 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51%4]) with mapi id 15.20.8335.010; Wed, 8 Jan 2025
 11:53:58 +0000
From: John Levon <john.levon@nutanix.com>
To: qemu-devel@nongnu.org
Cc: elena.ufimtseva@oracle.com, alex.williamson@redhat.com, clg@redhat.com,
 jag.raman@oracle.com, thanos.makatos@nutanix.com
Subject: [PATCH 22/26] vfio-user: no-mmap DMA support
Date: Wed,  8 Jan 2025 11:50:28 +0000
Message-Id: <20250108115032.1677686-23-john.levon@nutanix.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250108115032.1677686-1-john.levon@nutanix.com>
References: <20250108115032.1677686-1-john.levon@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P189CA0066.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:659::14) To CH2PR02MB6760.namprd02.prod.outlook.com
 (2603:10b6:610:7f::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR02MB6760:EE_|PH0PR02MB7670:EE_
X-MS-Office365-Filtering-Correlation-Id: 6843e4ca-4a0c-403c-d03e-08dd2fdb22e7
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?E9ARDPAdyR/WNghYRSWIE6tZk/gHBEdgvcFTTvdq8kh4w4qTJ5tp03wgdqsr?=
 =?us-ascii?Q?OT3zfWVAe3t9sVPVmDOAWe/yPMzmC8/OZvLfjMKJu3dDsKrTwD+NQwZWKdNu?=
 =?us-ascii?Q?AjLsbPFhNN2sGVZ3ucY3O58PklnFnBsk0iuGsP2LPRxOgSWSTnDtsF5l0y3h?=
 =?us-ascii?Q?QNGH8Zx98CwBqY8UMEeWXKqq9d87xnlomK9x4jApVul4zDO0kg4X/rsiwmt0?=
 =?us-ascii?Q?0OAgX5m7LVLP7K+cTxZdBGZFMk3zEnEomvuTgixM2wEEfhR6oiL9/QO3x/Yj?=
 =?us-ascii?Q?WZXJbdAQh/qrF9RzRYTa03W0hoqMvTGkndRMEHJ9Mr0dk4MBRY83nqdRW1Gj?=
 =?us-ascii?Q?ksupf6Bkf1OGylktUnDBLqpIKbngfVVH8/6bDToWxiwgdltGfhcuIAeCwtz/?=
 =?us-ascii?Q?DYer28C30qoX4qVvCYZHoF75DbHaqKXsJZ++w2q/dJrg+pEtG+uaTNV47MBv?=
 =?us-ascii?Q?lC32rA8beBLEYCyptgXTRtFM7RbI4ZLxvihM6nXyl/kiB/bIQW6cnQc+lK/s?=
 =?us-ascii?Q?o8eKdNKDZ9nBc1M3GQSVlslgtHE5ZAJoK9ZYmzwwXjnuzoGJlxmCODQEc5Q8?=
 =?us-ascii?Q?xhPntZbcvLsF9GS5SNBqwHUkPQb0yG7Wru0HVxpKwGaFujWmN1Pwe7BTCXqt?=
 =?us-ascii?Q?YzxiYLB63b+NkQ3xgEUpxHFLdx9CIfc4fi/bFaYfrw5rQxGQLqtFUDWEhNAk?=
 =?us-ascii?Q?swkMXNij1gBnXTvLe7mcNwZ3SSug1wJgP7ZMgxkrImkYqsXrsX7kqY/zCs1R?=
 =?us-ascii?Q?Ql8V2nD9B79xgkiOcmiKwEfPCrsIXzBqQJMW5whNOyy3nM9o9vi83L0BsGTd?=
 =?us-ascii?Q?50Gwr3Q8duOIhCEZXm9Mpb4cnsW5HhuABCq81H6m/jJwWybelvaWsR1lJV0X?=
 =?us-ascii?Q?z+yv9WTiU4H2wdlkgURZAia2HPVECyKRh+bnzf3zc0WY6bXIMIb/6a60JDkf?=
 =?us-ascii?Q?T3Fvoz0VOtzmc1d9oJVlxQTyxrbLj5b4qR3iCIQ4pBwQKdY8im9S7fj+xv/a?=
 =?us-ascii?Q?pNKwlHAnJLlVaxqfDHknmxdso25c/cTYHl/v6bS6D5ohTWlibefFvfDj2o4X?=
 =?us-ascii?Q?uqlsMnAE6YKrwjMNh0TkYqsE65u0Sq9PpTiUGHwHaiR/S3iDSZR4wCYNzERw?=
 =?us-ascii?Q?QYVPYQiFh2FF1dxqKO4/DkG7oRoxU+EtS4HyuQ8zRUyeOAsEq83RApYEx/yt?=
 =?us-ascii?Q?/FwTwP2VvUNQNyyvSY7mKD9Z5FhCfJG6RkPEPTeL4h59QCZCZ87XFK6GzIyQ?=
 =?us-ascii?Q?NTVv5hbSeLcvdKBRS/4I/oas9Hj7eDYsZQ6e5mPdV1riQ7BJMT5jTWaF9wnt?=
 =?us-ascii?Q?qYcp53e6CExm3i98YgUaC2I9yuoAjedqMWvEFLX2+a6zdXbDajA/lxq3TnQ6?=
 =?us-ascii?Q?XqQsODmf6OZPotZniUis3Kx8h+uA?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?R+BaCnv9oQMPzhyyIA5iem+BpgkvQoKRH4Zsnu/IHY2F5WL+EVa2MBl229R0?=
 =?us-ascii?Q?BL4Zdv/hcZ+mlEANqaXo1EAT7BIRitdsQ36bB/SQdVcilr4sum3L3eTjw54m?=
 =?us-ascii?Q?cSoqF7jlVVU8tkGs1sJ2DzHcixbbhfUDJlgSjjyo99xj6HSWRImXowsZP8pt?=
 =?us-ascii?Q?ovqQ2VVbNSX0LTsuW+XInhiy6vTeEgnUBdVLbkSTqCdt4aom9fnHLpJRK628?=
 =?us-ascii?Q?LrNSDzqhdL8AS+06YRE0c3Zinm8ZLQJS9sRQXlqOe1y3uQA3CVN8UUFI8QOC?=
 =?us-ascii?Q?ui3OK3vO9+Xqm1VPL+zy3BNeo7HUyfkAUXcVAjdTXvlghP7PFbP8HR/YbkJ2?=
 =?us-ascii?Q?stSoewKh0ydJw7yleogjhHTDj0rCaRNCkLTQ69lL8wxx22Zcx0huaxFr0yEd?=
 =?us-ascii?Q?tD2RjtqacC6yCTU6ygC80ZuIBQttLhRyOyNa5e2RBGRvNNF3kfGYrBeYEfUM?=
 =?us-ascii?Q?rkgl1lUdV0Bh3izeLYbMkSvIpSgm4c+mr/CY5ynd302qomM3Qy1WbZKFO9gz?=
 =?us-ascii?Q?iPCimKozh1f9+t1KogqbRyQzsVkViFUBC9ztTGWGjAovJPIizALn1OvJ7QhV?=
 =?us-ascii?Q?LTjL9O4AGuJ20Yoz42w/y4HUtrzWOtiDU84l09/UdzsehZXnl/BwTO5X233C?=
 =?us-ascii?Q?XGAaSR4B18NUhcWszul2QtqTu1YE1ZdzHvJFT5ibPPxrNSfS0WIaqcj7iAKu?=
 =?us-ascii?Q?2r+C/BzP5Yh8e0oXEoO6d+azQRuZByeDqwFR67VCb9yGDHCG15YhMSmyn20V?=
 =?us-ascii?Q?ChAeWA30yqcRN1yEyeoovvTBXyP5Qdp+v+dwGVzibX+MEBksTI0zPkIrXM1w?=
 =?us-ascii?Q?3iNrJWRWF6eDlCVnlccHbOc7sylgaBT76eFKmfB9ZPOpnFrl2xQAbS2JIcbo?=
 =?us-ascii?Q?8/s1Pfi66GTgNLYqRujVXOTWK1oCAhdLV6XFdL+pqf13z/1ekBOuzLD4qSrP?=
 =?us-ascii?Q?Ac/6Kztq6dxKNphJZNDSbFi26QYVFrtUMYrzxLHZBtl2Is7aJG6Vy59MEvfm?=
 =?us-ascii?Q?g2f/ObMgUX9FQHiyRl+T/KpDgpIvYdg1ej/oky1QgOWzWCbk9VoFAkwmcddL?=
 =?us-ascii?Q?gfwjQIqI8HayLRud4ak8kjPbDqP+Bb7wShNwsiw8YwgRHPMeufOw3mgk778f?=
 =?us-ascii?Q?pCXciaL7ZbLLzPZsqBd4eb5cD1n24GaroF6itgpBsmNJdgxXIWzNDDcc2vC4?=
 =?us-ascii?Q?piXUirIhio22euSovFqK6SP3kGGF7i8CMTZuVq3LmwkNUux/MSvqp4yJq9g0?=
 =?us-ascii?Q?yI+1uQEEiEEij0psNX/WvYoC28ixwP46ZAquYT49pSS1n/LcL8YZqPThlBRX?=
 =?us-ascii?Q?VPlNsTKagCWtXXeQFVngIZ1a004i58rIxmk0S/L42xjzSbonkBnecruo4Ftc?=
 =?us-ascii?Q?T+QVon0rfNCiGyQUa7kMz1rIpIMuvjxKBJP8myd8wcQwpM3pEM8TD8C+G0zT?=
 =?us-ascii?Q?2jSC3femQifEXG1rdn9xWFF/aY51U7fta3B09IfI6zyP6DrN7W5ilwrEl72Q?=
 =?us-ascii?Q?92v/zBWoua4a6XRQNiCnojO8DnifjX7UTrSNCHT7AC3gvIEj0lwxKR+ctkz3?=
 =?us-ascii?Q?dvdHYULAbMAUHfTFg5QwDMhiE9udFADMTkmZhdSl?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6843e4ca-4a0c-403c-d03e-08dd2fdb22e7
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2025 11:53:58.7843 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eJY02zVKGle4fL8YcsBP1HiiRLU40zb6mSg0UAwox3yT1ZDxSB669lIIJxD9WnTwH/aRc6mnr+EQzltR1fqMxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB7670
X-Authority-Analysis: v=2.4 cv=Z/cWHGRA c=1 sm=1 tr=0 ts=677e6759 cx=c_pps
 a=MPHjzrODTC1L994aNYq1fw==:117 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=VdSt8ZQiCzkA:10
 a=0034W8JfsZAA:10 a=0kUYKlekyDsA:10
 a=yPCof4ZbAAAA:8 a=64Cc0HZtAAAA:8 a=9g9m8Zzpkuj7DW7ovtoA:9
 a=14NRyaPF5x3gF6G45PvQ:22
X-Proofpoint-GUID: JYj_VwsUt4IQc3jcSQqdl9hhb8RmLJ5F
X-Proofpoint-ORIG-GUID: JYj_VwsUt4IQc3jcSQqdl9hhb8RmLJ5F
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-08_02,2025-01-08_01,2024-11-22_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=john.levon@nutanix.com; helo=mx0a-002c1b01.pphosted.com
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

Force remote process to use DMA r/w messages instead
of directly mapping guest memory.

Originally-by: John Johnson <john.g.johnson@oracle.com>
Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
Signed-off-by: John Levon <john.levon@nutanix.com>
---
 hw/vfio/user-container.c | 2 +-
 hw/vfio/user-pci.c       | 5 +++++
 hw/vfio/user.h           | 1 +
 3 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/hw/vfio/user-container.c b/hw/vfio/user-container.c
index 77ffec9561..89bd1850ef 100644
--- a/hw/vfio/user-container.c
+++ b/hw/vfio/user-container.c
@@ -102,7 +102,7 @@ static int vfio_user_dma_map(const VFIOContainerBase *bcontainer, hwaddr iova,
      * vaddr enters as a QEMU process address; make it either a file offset
      * for mapped areas or leave as 0.
      */
-    if (fd != -1) {
+    if (fd != -1 && !(container->proxy->flags & VFIO_PROXY_NO_MMAP)) {
         msgp->offset = qemu_ram_block_host_offset(mrp->ram_block, vaddr);
     }
 
diff --git a/hw/vfio/user-pci.c b/hw/vfio/user-pci.c
index 53d230fdd3..b1125f7403 100644
--- a/hw/vfio/user-pci.c
+++ b/hw/vfio/user-pci.c
@@ -39,6 +39,7 @@ OBJECT_DECLARE_SIMPLE_TYPE(VFIOUserPCIDevice, VFIO_USER_PCI)
 struct VFIOUserPCIDevice {
     VFIOPCIDevice device;
     char *sock_name;
+    bool no_direct_dma; /* disable shared mem for DMA */
     bool send_queued;   /* all sends are queued */
     bool no_post;       /* all regions write are sync */
 };
@@ -157,6 +158,9 @@ static void vfio_user_pci_realize(PCIDevice *pdev, Error **errp)
     vbasedev->proxy = proxy;
     vfio_user_set_handler(vbasedev, vfio_user_pci_process_req, vdev);
 
+    if (udev->no_direct_dma) {
+        proxy->flags |= VFIO_PROXY_NO_MMAP;
+    }
     if (udev->send_queued) {
         proxy->flags |= VFIO_PROXY_FORCE_QUEUED;
     }
@@ -281,6 +285,7 @@ static void vfio_user_instance_finalize(Object *obj)
 
 static const Property vfio_user_pci_dev_properties[] = {
     DEFINE_PROP_STRING("socket", VFIOUserPCIDevice, sock_name),
+    DEFINE_PROP_BOOL("no-direct-dma", VFIOUserPCIDevice, no_direct_dma, false),
     DEFINE_PROP_BOOL("x-send-queued", VFIOUserPCIDevice, send_queued, false),
     DEFINE_PROP_BOOL("x-no-posted-writes", VFIOUserPCIDevice, no_post, false),
 };
diff --git a/hw/vfio/user.h b/hw/vfio/user.h
index 31d2c5abd9..fe24a881f2 100644
--- a/hw/vfio/user.h
+++ b/hw/vfio/user.h
@@ -94,6 +94,7 @@ typedef struct VFIOUserProxy {
 
 /* VFIOProxy flags */
 #define VFIO_PROXY_CLIENT        0x1
+#define VFIO_PROXY_NO_MMAP       0x2
 #define VFIO_PROXY_FORCE_QUEUED  0x4
 #define VFIO_PROXY_NO_POST       0x8
 
-- 
2.34.1


