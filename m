Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9915CC44501
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Jan 2026 11:01:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1viVxY-0007G6-OI; Wed, 21 Jan 2026 06:01:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1viVxT-0006a3-PL
 for qemu-devel@nongnu.org; Wed, 21 Jan 2026 06:01:08 -0500
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1viVxS-0008KY-6Q
 for qemu-devel@nongnu.org; Wed, 21 Jan 2026 06:01:07 -0500
Received: from pps.filterd (m0127838.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 60L31KxT3650920; Wed, 21 Jan 2026 03:01:04 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=gOXRHJXlw/yL430pqbij6vs9I6cyCfcqS3EeW+FzV
 J0=; b=CMvBI+h4kRQbrn+Hn82yqd/SysAk+B0mAN9BmA2qW5TFV4kSw47/K25fl
 JRVnRQ7jZopUkhEab0Xmll/duCeFgUJ999ugPy15arg5xQAKlgXVV8Nh94XxQwKJ
 YxHJ7VynuQcf9NUnBViAoDGXlEDnYEbeWhyUPnHudRiUSWfPj+SJ/dmbU6lkGR8R
 8XU/NNEh3P0FzemR/6HlyNBidHkQ/kAxilNa1fIdBJRAeo2E6MtbpqCBTYsJWEpS
 gWy3Qwucf6FVZVmlabh9hUvlhnjObE0PMKY8tlTZLzgqnft98D+b/CmtOoN4Lfqx
 N4FSc4sWLy3V6QePpv9hKwQ4tUFQA==
Received: from ch1pr05cu001.outbound.protection.outlook.com
 (mail-northcentralusazon11020080.outbound.protection.outlook.com
 [52.101.193.80])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4btde7td21-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 21 Jan 2026 03:01:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M8eq7slULNPXRG8EMee3NDPuPFmo0qxj9qAu2S7aQ4QcFdFk0ze1r907km+onpYx+wwFQ2HV3A80PvS3bzvvtIMc6jqbGwIb9xMRQkseuznIgZvZL5pxloyUHKsvvVkojZ2rVNkG8oaO8qXuk+U5yn/N1Sr+Sba9mfVVITHMlq2dDUjDgPxhP7wvY+59tk825n60FDKlHS2rHtGuGTxkX29PBS5J/JQJSAUn6reVcXbBICN+E6NAFI0z0daSItM0bWwqfHvgXqSvhtsxoV8leYCtSbFEtjZnHe1lfxiPX17ZagUhYelm2dGCfcFv6wOth5Z+IW231nGeRKYuyTrZiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gOXRHJXlw/yL430pqbij6vs9I6cyCfcqS3EeW+FzVJ0=;
 b=OhroS0JolDR6mo55IVM3F+lLaXh5NwhrtF7NWrG2tLB6y7MlKMqSCQaiI5YTf8QZPkAy0fdHswy8821i0rO0LRqMAlCOkQ9tf2xh0dH5YyZ7sGdmx1xDV5LqloQr+bsG6HFQfETC5OFANmyP2i5Z0c4nHhoxWpTUmQbDYyoAksfYJ9ZEQR2XCxErQJ6xeASFa5VDHCMU3UopPyKUpPMLxucClw7ljBKQ2CbXuCQSVADph2mGzqSrisr28DbdSONjzvzGYSypCUAFefVOok6RaZ5OEotoDu/MKPr/E2GzBQW5uYSxDP8zxbbICgyoN9t6FKjSwzN9skESN5wWggiHWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gOXRHJXlw/yL430pqbij6vs9I6cyCfcqS3EeW+FzVJ0=;
 b=iwpW4Juu9YAUymyj8W5pLsMYJHlCg0UmXfVKo0ehGaa8nqjSb/ClsqcOr7UTrdiGcZDXto1JqnGJ3MQj+hqAUv+Qd2eGus+O92I82Qhx9g+c3Xmbpmk3iQd/wR0rHeIpBA75BW7XWYE4ttb4jHgSc2nHqjxEuM/W5bcb2gX9/F6EVHTyGNx9IKkEkJTc/4XvpWz2aCkT7BOJBxbzlvFav8lNbyj+D70hRoXE33ffk3XCKXPNM4df8Bm4KcF++5utWpBCwrQKeQb+TmRoJct0oyYXBBGHGYb0g8z/SaHQxX+x8Ts+OT5TfNcPefbUinfcrMTg9N2OVOr96wPctgGgig==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by CH3PR02MB9939.namprd02.prod.outlook.com (2603:10b6:610:1a1::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Wed, 21 Jan
 2026 11:01:02 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%6]) with mapi id 15.20.9542.008; Wed, 21 Jan 2026
 11:01:02 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: clg@redhat.com, john.levon@nutanix.com, thanos.makatos@nutanix.com,
 qemu-devel@nongnu.org
Subject: [PATCH 1/2] vfio-user: fix VFIO_PROXY_USE_MULTI constant value
Date: Wed, 21 Jan 2026 10:59:45 +0000
Message-ID: <20260121110055.2333711-2-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260121110055.2333711-1-mark.caveayland@nutanix.com>
References: <20260121110055.2333711-1-mark.caveayland@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0139.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:9f::31) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|CH3PR02MB9939:EE_
X-MS-Office365-Filtering-Correlation-Id: 16ffdd41-9c84-4a4c-1dbb-08de58dc5dc8
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?0nbYVSty7jFwly75mzUiZJxmRGQt/+e5RtvotXXCCak/jsH8J22Xz866km9B?=
 =?us-ascii?Q?imgh2WM2zAGNHDxckT5tRU0hR2PqOs1QD9XWkMa9ZDv7gKTGI6p55KWyyCPQ?=
 =?us-ascii?Q?5yk6KgvA6j4WnVqyuyOGUkc7sZdYyNJHZVJmhyuQMpjvruq/8TyoEVm1vjmn?=
 =?us-ascii?Q?vixWSqCD8qZE6hm0HMWH4iPncM5dhG2oRIQP1e0lOHN7VQCYuybO+vnU24eD?=
 =?us-ascii?Q?0rw92kDpj7EBjtEZuLHOBa6I99rrEMdJHnckJNXjsn2Idm+jvvhJ0ujEf2lE?=
 =?us-ascii?Q?hqXUkKewsrOx0oXH/SJUtD9A59zXMCoeuSD/DOzpN0/W1ih6AmAF4kfq7wT3?=
 =?us-ascii?Q?Jg/FDZbTWJQL4Qp1KrRv79SybCg3kMekHVDsoP5QLYKcb8oj+PTx0yFirkqu?=
 =?us-ascii?Q?Ue1bq2JrCpbCJL5SoVliLx0KmDqB4O4BIHaSIaFz/3tk9+yDQZKXH2Wk6c0D?=
 =?us-ascii?Q?/wuHhc0Ehy+6PQvVg1O2RYfke1iERz09oWQtfK+EZnMhfnWDDleZtp98Ne74?=
 =?us-ascii?Q?QK+2rHmu9Asj4nGbw/+81X3PcI8n6o0qFPFGDkCNvs2JBv4q00R9xLdpI+zA?=
 =?us-ascii?Q?HIO6B2+Ni9JYkYXPCgoVJ46iWKdskkzscUJzfw3u9QGEm2FFyGNneiPxltOQ?=
 =?us-ascii?Q?BvqZGGIrm9oaj1wdBRysiz/rB8i9tMi3Pcd3IGYRG7ufsTqhDAYuoTrT5geg?=
 =?us-ascii?Q?dl1xSnWJmMceOom7HINEV8EQZEPiCUQVE0jSe6gjIgFhL+ZwY8gvax/ofYfw?=
 =?us-ascii?Q?nVkn6SXgEnAKsMCXyqH2VWgANrjE9ROQXQOICI139bGOYxUqdDQ3+xFaQawv?=
 =?us-ascii?Q?5rSekonCG5uDlAHd9Iu192Ck02fJ30NGPKYQxyoIwOZySBiprW5bi67r6sl2?=
 =?us-ascii?Q?0iCo4R0oSE10i9nHV8rhLlMORjyTwnc4+mQ+uBCDm5FOUqhtfN5rBzC/5Z0I?=
 =?us-ascii?Q?YQph69EB4QjpHXi0MW72YjWF5IryLnPwZQL/aEuaIMyAawXq0yUE2xlqAK1F?=
 =?us-ascii?Q?2FM9/oSYvZwgJKClEPXFfQJJw8JWZgensXMQVr8/asY2uomvQK683OugH1Jv?=
 =?us-ascii?Q?GyG2aCwaTAx1QpsNxLgp2eaPsY4DbyDW3BczIL/JownIi//0AGXswUyJ9xvK?=
 =?us-ascii?Q?eRSb0lsaX5D2QZgXh/9zqpp2siI+rLQI/cJcGmDwAr+NX75PWUa6xDNPsUAK?=
 =?us-ascii?Q?71QiILe0WfQX3X7XTmayWOqZ4E3nL4UmEFtn1lUs965e1Q3m9i2l9VL0Bcs7?=
 =?us-ascii?Q?d8dDk98CF3LQIfA5wDZNMuuMYLEm3vPlA7KU85eHgb0MV3rtIP/qgPmGo+8P?=
 =?us-ascii?Q?HvZk9TTkyFleuY2WzngGixRHyK/MzxxMyG9UZIzMQkoIXgCCMd+Y629eWsrF?=
 =?us-ascii?Q?T1wU1hr6VmUfK9Hn2tZjiPFCzFc7AlHBWRYhuTwfboDHGP7kKXepl+cw0zv6?=
 =?us-ascii?Q?1q4Nnsm1KMWuGPWyXDs77rqKRrLX6OloZFgX77NzPrIRelrkHh2oufDY3qd5?=
 =?us-ascii?Q?0Y19rxzKft9pFWEWr/74mqTUZ1ccNvSodQREBH5nmvBJXb9W5AknoqIz4thj?=
 =?us-ascii?Q?5oustUwevIx5WxVNlN8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Efhkx1oYl5szYS8RoSEjWyRrRU3L5K+xsnLGyb6NCdW0r7ctpx6ptVm+I+b8?=
 =?us-ascii?Q?IXilZwozaSPw46GFhnpkZH8cXCBoYfvn+nLZfpxPvGMZ7LLuQbwAsWi4pVh8?=
 =?us-ascii?Q?8ZCMfun/i+T678oVVBCsK6/xqm0RUGUA2K7Z8t82lC0E4kkKT2uyxUSPycIk?=
 =?us-ascii?Q?5PIXw4Wk6OmK3S/vseTysE2BJWa/subrK092thlweNIKHULdHpxaMbO+zEt+?=
 =?us-ascii?Q?B6OMUScR4DYhuokm1dLoYSiY1bMFThTStH7DpN0jfgh58L64+CuWWptRf9uf?=
 =?us-ascii?Q?iGe+V52Q3k5oTJvcUf5KZIHQ6AR/wWyMRXLAdgVfzARJElpR54OYjFyLgWRq?=
 =?us-ascii?Q?uLic9P1NXlo55KeAuX3F0lVs/+oK75fFGkfrvRT7a1GTKhtDQ0AsjCNDS22l?=
 =?us-ascii?Q?VpG1KdwQjvQzAGziu6u6ROj5wcdI0r+z1KqEXqK9OLNQTNBBlFb68EaN2/oe?=
 =?us-ascii?Q?GQzp5JKHkGxpynaFLxkJfp5g9ZbsYLXgZG1fgJ6i+G0BGj/DBGV34kqC+JBu?=
 =?us-ascii?Q?tgAWxikVVxrvAXH4iribefWt+WC+xVpLM486XfjfjTvge0O/EWoCO33kmWfo?=
 =?us-ascii?Q?M3F/pHgPiF9gHR37vJcwWb5QcsrMZTUsCOlRTslg5C6KSEZwVb8TMThhT7T8?=
 =?us-ascii?Q?c7TPM4x32wd1Q6zRW0R+bTtv+qhjr9gvKbgNCBRW7EODomjmAw9akhW312D2?=
 =?us-ascii?Q?JRNppBb2jXldFrlHl5813xuFAiZdZEtU0RzRybum8lPguajMkOZI7fs35pge?=
 =?us-ascii?Q?f3PZBYCnyFrBxV8vNBgB0a7zCRtzqV1vNkQnI0hxTBvM2Atkk9+sRcRf8vXO?=
 =?us-ascii?Q?twNRqzx/YWnwgQ7kWw6ps7reC/RR/zYcEpv/Hlov/ivy4aMY5Gob0DWjxXw0?=
 =?us-ascii?Q?j8uowFWbmlKWJtqULdckgw3giCMVT6UHBNmg7jMvSqHkaomh5n1O8IbBufGx?=
 =?us-ascii?Q?WWNFWQLbXix/6i7jq79s2+C8zRrvdFbAY7Ssq0sYMQOZkvJJU4jzO02TYH3L?=
 =?us-ascii?Q?ycWck3qytZqRtQK0ybbQmqNaZwbueptemlTolhuJGbrTjLqwZcyN+TipxBwE?=
 =?us-ascii?Q?hl7ZXjhNeDCnXoTrPp9dAbKQRSHaRJWXzrCtvgBimx0jubWiNeLBwEOnDG68?=
 =?us-ascii?Q?kcXIPe9Wf711A4drjSFBCDyno7zT3WmWZ2v1yJRLfR9+n5335AQSJ76Xx9qj?=
 =?us-ascii?Q?CgWf/7K3SZx+CLkAcP/9YFVqd54qSrL6TyPQe7JFFwFevxsAjU4tQcCm21UC?=
 =?us-ascii?Q?5OcERliLCnBYVWgZ2sgRS+/33w83diejRz5LO9XHOUtC3C4GEn3Ykf1Ogdgc?=
 =?us-ascii?Q?DXuX2OfaVgWueLx2QTX0fh5mjUufj5T0bZrHMbfnJJf1EVsLz7/mq+1miVKS?=
 =?us-ascii?Q?gy6RPS8uj2tT6JHKhxzF+80i0o0yL32jJkmwFpLtMehiZSRH0jn0JTRLFxoB?=
 =?us-ascii?Q?Fl7h2FqHWI9QOW+OaWcZqs7IXy78+YHUiHk1qCUQkJfPRR8Y+wCGsFMidXqC?=
 =?us-ascii?Q?pD3gBZlrCfaS2PY7Z81isy2kHLA/bj+hJgRIKg6gE8imLG32b2MeAVeLuaZZ?=
 =?us-ascii?Q?s9NISlbHlQS84ohDhGLRlRtyARoojnL32zte1QkSR8XK0OnFzYLL0OmfeuTB?=
 =?us-ascii?Q?hcgsQIVqkgHiEx09YarLNFZGV6sXPvuh2zaT5nPoR5oYsQhrcVtHtYVLV57q?=
 =?us-ascii?Q?46OnUVpvadEjciwjVxDCwRbG9TT47cERpvQb4F8VX97kgf4h7N0cO/VlnovW?=
 =?us-ascii?Q?/jQ/N2r5kj/P5U+2E2vv3ULscwbFP7M=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16ffdd41-9c84-4a4c-1dbb-08de58dc5dc8
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2026 11:01:02.4807 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7tbuC1zY4K0r1mYNwdKiAJ8lu7tCMGg+L5laMO41yjOAuAxLisSzKFWIRwIVzFYJI8F/NZzisXsAajHJEIpW2r7wp9sjaMjvj5ZOLGVq+fY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR02MB9939
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIxMDA5MiBTYWx0ZWRfXx5GCbBoFUmuL
 EimlNnEjiSBJt3GiXKaichKy0UX9o+AFs0+69FLDWv2iJdbwVqQ0nyZtTx2ZRwQtKx+GUpPKzfG
 Cp7C3VtSPAWNWaP03z0y92E4+5RSAHw7xZdNAdTuEjDPSM5hWdEyzgmrL3teq+UbOwcG+Mq+zrH
 f3YWsHnNJG7j1Ep2UinGTjR9VPKMaCbA86zzJNkM8pyc1V1jtq77+z0oI2kzdPtoqMOjyyUo2PY
 hiO+KdTPmT3aFn1xv30OkLkno0IGYfBWvf9TIoc+c/Vhtel2gZl0+E9U4qPI+iARrzNRiZEtpAy
 EZOzyh6Xnj4/cXINShsKCtZlAuy+6bFm7XlnTVpQRXnKXktdfOTL9eMzFf00U3p/+Vbmux2JO3o
 9hiPk4cSd6OGsVlDJPANHYqvKzIu/2IHDnQIe1jGJQtqKJqpg14SkBhVB/t+ofD8iSKyebRL8UJ
 G3PMzdBr1F33jK99tQw==
X-Proofpoint-GUID: -fV0Vkssgrlur-CpBTpTTeLpYAKQqSvZ
X-Authority-Analysis: v=2.4 cv=aaVsXBot c=1 sm=1 tr=0 ts=6970b1f0 cx=c_pps
 a=n2zAzoV7tkZwqkXj9vfx4A==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=vUbySO9Y5rIA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=64Cc0HZtAAAA:8 a=DxMLEdJzfgGGCeEhJ7oA:9
X-Proofpoint-ORIG-GUID: -fV0Vkssgrlur-CpBTpTTeLpYAKQqSvZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-21_01,2026-01-20_01,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.087,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

The constant value should represent the next bit in the VFIOProxy flags which
is 0x10 and not 0x16.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
---
 hw/vfio-user/proxy.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/vfio-user/proxy.h b/hw/vfio-user/proxy.h
index 61e64a0020..b09fd886f1 100644
--- a/hw/vfio-user/proxy.h
+++ b/hw/vfio-user/proxy.h
@@ -94,7 +94,7 @@ typedef struct VFIOUserProxy {
 #define VFIO_PROXY_CLIENT        0x1
 #define VFIO_PROXY_FORCE_QUEUED  0x4
 #define VFIO_PROXY_NO_POST       0x8
-#define VFIO_PROXY_USE_MULTI     0x16
+#define VFIO_PROXY_USE_MULTI     0x10
 
 /* coalescing high and low water marks for VFIOProxy num_outgoing */
 #define VFIO_USER_OUT_HIGH       1024
-- 
2.43.0


