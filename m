Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4429CA0EFA
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Aug 2025 08:33:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uqp5q-0003KJ-Od; Tue, 26 Aug 2025 04:31:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uqp5a-0003HQ-DD
 for qemu-devel@nongnu.org; Tue, 26 Aug 2025 04:31:35 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uqp5K-0007Vo-6c
 for qemu-devel@nongnu.org; Tue, 26 Aug 2025 04:31:33 -0400
Received: from pps.filterd (m0127843.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 57Q5jMWU1785161; Tue, 26 Aug 2025 01:31:07 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=uE7Bshe3Mn4Z3emcfE29xaUQyWYuWb5NF10akxGAo
 Gk=; b=QHQk+tcu3O0VmXetiR4vDajVFNDp6zjpJMNjFIpIpzcWosaQQNZVHzY2i
 uYGHttMFOo0YnGWCGhrzsuTw0IW1QNME3ZWPM2uZ+kSPPXMojGnA8yzclN2J+aQl
 sX5wxSap1g0fNyLyiMWjNQz0fyov7MvjPBrFDN7amsSNZz27pXLIIlGhltA5LBJW
 vFp6PmwgfktosT5Y8qogRbnBvWxODV/V+t1Ia4/hO0r/46763H4BxjU/gS2lSeH4
 jZxvIEAPe39N8TZvmo4EGtaO4gCIH94+E9WuhKbNsdoBicxFD/o7EEQSJUKBYoUe
 RkVz88MgZXp9Vnixn26UiY5bOaGGQ==
Received: from nam04-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2094.outbound.protection.outlook.com [40.107.101.94])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 48s7280bc4-2
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 26 Aug 2025 01:31:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MlVonQXznruZCY8UCUKWjTX4b5MI+fWwtXWWf5bxk+mCnDtt6A+RwBTKqdg27fzsbu06wLVTaLlsoo6E7oh3WpsZcPdlr8S6fOxl679qFnKLmHZ4GhYyueQrJkQtmVYDWdSblBAiRIwXrV1onlRVu8Av4fOjs7O/OOY8nTFZkANifhg1cTAvWJ0ncJsTg+NJ05SnUfG30JhOXxmrs10C2arzDRD6pRztLTwWkYgyUTAsnxu9+KYtHehJN6n028KnmqKwxSMrKGWe1k/vPVzYLJ0GCV0iKykfI1+mAOOmNIC+Geixcl++YpPIsgdwphJpHggzz1LyafthGbGR246/gQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uE7Bshe3Mn4Z3emcfE29xaUQyWYuWb5NF10akxGAoGk=;
 b=ZLLA1CXylALJTdwhfN+bDqJh7CKPEEeYGHRZkop1voZWzRppm7XgdeSAEQG6BreYYMhggavAPP58FxCgcQrDPi9V+oo2Fdbjv4RT1WyCNVIshz35JvzRlpmu07AO9r1bE6qrHnULn+1nK0/Ig2FOFasIfbbjuyHs1QYD2gdfn9pnoqajKWuF59/cZX7Ne0eUOanH1+uYHlWFB0nFBrVJ634NAadwMh/jg3DTfjG7aDktR39fv1q6WKU8UR6QXJ8JFfpAeKZodyBDnovJJ2esF5kUTPQDZNVn6pG0ABbM1SshLYJHQ4BhE9WE9xIfLQNLiob2uoLFUY15/IeQBDfujA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uE7Bshe3Mn4Z3emcfE29xaUQyWYuWb5NF10akxGAoGk=;
 b=DD+iGHFkIdlTriROUkETG413bna9qFNWReCzdJodKLpocHmXN/CiV9SMLyDsVIW4Nk37K+VO+OHc3yAjvWeEvwh6znOuLCq6fvn3It9u9hgzcdAjPp92BvT6Vgy1Oa4oeVXXttovcDtuPq6h6xBui6apW/Zqfq59rUpQDsdyk6aenGUwUxnt97z5liWagzI/Ez16lrHSRAI6N+dmnAVmgkU0gd6nr/I4/SvyHUZ3X9cOQjpWK3NRiAepyJDDOI8C7V1BW5AYmMnWBlhIHpPZL/vgHiEJOon68U/0qgUWn5hZq9hteoDLIWNSAnEa5NUylnQ12FIE0mOLUGZsjulDmw==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by SA0PR02MB7404.namprd02.prod.outlook.com (2603:10b6:806:ea::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.21; Tue, 26 Aug
 2025 08:31:06 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51%7]) with mapi id 15.20.9052.021; Tue, 26 Aug 2025
 08:31:05 +0000
From: John Levon <john.levon@nutanix.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 John Levon <john.levon@nutanix.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v2 1/3] tests/functional: return output from cmd.py helpers
Date: Tue, 26 Aug 2025 09:30:58 +0100
Message-ID: <20250826083100.1058305-2-john.levon@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250826083100.1058305-1-john.levon@nutanix.com>
References: <20250826083100.1058305-1-john.levon@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P192CA0016.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:5e1::11) To CH2PR02MB6760.namprd02.prod.outlook.com
 (2603:10b6:610:7f::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR02MB6760:EE_|SA0PR02MB7404:EE_
X-MS-Office365-Filtering-Correlation-Id: 36ccd4d0-d0b1-4244-fc6b-08dde47ae63e
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?yG41l/xHJGqBXdIBmlQhpNGZSyUcCGo4I40WooSZ6EPYWcfOfy6cZpQWdPvK?=
 =?us-ascii?Q?HlhOaAPXZfU48ke4brEephQq5SlOMFMZ5YNDuOYeuNeesgO3m9sNqilUY5z0?=
 =?us-ascii?Q?m3KLRODsMdAwz2S103XlwT0DIJTrMx5k+Wfg1zxogYTURkQw9/it2uWoiCNK?=
 =?us-ascii?Q?OWtKs7HRdnteCqGJZ54zmvmmHOGoSVJ3alEGtPz9wnBqR5eDMv+CV94XxLW5?=
 =?us-ascii?Q?cwyyg5fOV79Ika9+44NLxYYytju2XfEKt9y6KCAcQA6LQ1EfRQ3shSYYCAb0?=
 =?us-ascii?Q?+AClu/ESCW5ppTHTxfWoi6XqgRYkPCkp9djrccpTJrU+Me2tdKsaJWZt9hIj?=
 =?us-ascii?Q?dSLOG/SpezcYetn7SDib03FyBAdHcDLYNqU2pf3FEbjUznogH0JgJFl6hXxU?=
 =?us-ascii?Q?/h5vMjOUfFAJdh+0U8LQUp4yUZcAtHEN6bnfTLI9POHNQhjsCAixArta7Gyp?=
 =?us-ascii?Q?y8GMw+QSRAnYaXgpe2Hcm6kK6Tz1bPRYQz3jTeGJUBYeEf6KYW17ZoOtWfPO?=
 =?us-ascii?Q?OVFVkv83feBw5OtVH80IGXLcoR/cMz4+paDglHGup1rbDFVjuo3drc/c68PE?=
 =?us-ascii?Q?/ZjwDYaUCTzXcjD/dR4CVuESI51zZOxEFZDn752Wn4OzXqoXzFkMW2W39imh?=
 =?us-ascii?Q?fHx7ktj4h2N/sEGFQ6Y8jL8Z15lTqStOPJ8Tk7C9ivs3gIgFTZycw3ux2+OY?=
 =?us-ascii?Q?qDgLBm9EY9GfXvndJ434djs8G7XN6PJtcw7covHO80ScXoB5dtrFcLKK0Q3E?=
 =?us-ascii?Q?oylI1oiw1SXi7nY7KDGs/Wa2N+nMQfX4jkrsucF9VMh3rTUg9ZyzSQ7rdmfM?=
 =?us-ascii?Q?WE728ZAUwtzqXQn2BXzQehyVsLAnVDVbhSGEpagDrIBQz4dyJ5zz6XnUahtr?=
 =?us-ascii?Q?uH/WTDsZ54JHHUACh9MRMlp6zlNP1iKZ3k4uhWDFg8nkWWj+ZGHtzF/Uab4x?=
 =?us-ascii?Q?GwfPapKLsmrvPlRxcmF14cvMFLylZazNuCk06Bu1RN/EAt4AnDxNivrRtSlV?=
 =?us-ascii?Q?kQZfqK4E3a6D9ohN/x1qI9JO9sHXp2Yj3l+xlCrFO6mD3i8bfKYKkJJq/FSn?=
 =?us-ascii?Q?Z0l1Lwr0QNh8SVG4Ik6afF49XPY2jC5ewGg9s91PRNNlrb+ZRqhcRAhyZwxm?=
 =?us-ascii?Q?3GQykN4FtHnBO8QOoeOuB0HrrilIEH2oQcU/nnMwX0DT+QcUscJZjN5Prqil?=
 =?us-ascii?Q?N4m+SFdOQjGKUGPacxi9SfkFJ8XZxPgjA5Ns95UzDoNzm/hwlNXpvU1fETNA?=
 =?us-ascii?Q?EIK0AfuiDhInBacMN2W8hnalQTwUgXgEOd+vFZ0PrHossTF0suyK9tWfx7wo?=
 =?us-ascii?Q?zkXdxMP1C4eFnPi9KqkfSeNahb/A30DsmZmEFss8nP+ohbqgF1To850uQaQZ?=
 =?us-ascii?Q?TxVB8HJLQQ8Goc4XD8dcCvRabozIIi+qxFls0dEo2zOGaOrcZ0PrBYzjM2G/?=
 =?us-ascii?Q?bSS+KE494qE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?s/u/aIcAgg62upZ3VKacz6eUdnHcbX7jwKKfhCfq1Dutkee/NfauQsSufGQa?=
 =?us-ascii?Q?FdhZn38qDvKW852bFYWPiyhQPPu8S1WPlB+dzDju1UfTXTc70XzWfsM9eCR6?=
 =?us-ascii?Q?+88pee63IGzcR6eqbCGJgUdBVB8oontxuad8yWiUloMBnGnU8ZfKvOekIaZ4?=
 =?us-ascii?Q?zQhdqxKcdOT20H1BSH6RtcT2xwCzHBoJnnmJZAZ2n7VpcSEKWdwFRHmSf9of?=
 =?us-ascii?Q?vyuZWmZpqIAp6BAMMTn+sc6b1z+bgTvN+SPcNKJQRWV736k30RfVPnQ9Qwci?=
 =?us-ascii?Q?Yfi9TEh53sEiCB7RFpwpKJO1SvI/aox6Z3fI+oIiAlBMeJahLEBEqdEhVWL+?=
 =?us-ascii?Q?dQQG/hOmNx1GCnhFjhLVuF3/u2Irtfyqux8F7kCot9f/p2dn4kvJG8VmvjTH?=
 =?us-ascii?Q?QDUZqmFcVJMihhPL7g+3wIQfQ1IyG91THsgAtUwjnN6cE8L/U4frjunXPuju?=
 =?us-ascii?Q?h3K3jCyJbMe5OjljtQPcidmiMw7appxmW4JbbF6wuDz+NE+ND4xE4q9j7svp?=
 =?us-ascii?Q?bHps2M3mx7+lFyvy3DGteAmzoMMwwxIkzxBp5yrnJSJI52mMPr5aTrxcS8AO?=
 =?us-ascii?Q?IPt29Q+K0ARLsKBSgWveqLhfJH5zn08aNINOGMo5VN+/U4Uus4gB74Kjg8j9?=
 =?us-ascii?Q?fPE1zbX6BH7smK9bz5pJk36M62jwIh+ZyQB6xiow4UDaMxw0AyZZBi945SYQ?=
 =?us-ascii?Q?NmJ4qCYODkk17t1kYqW5UCSzs2VEQqt7jf/PYysyTJLjvoloivXvRryNU6rU?=
 =?us-ascii?Q?Eg8kleCjITCGccKk/9p5C5OaJXootqzcpgmjVNu1ab5FP4HthxWNdfy4mf20?=
 =?us-ascii?Q?4++QCAKQHlKlasnw7cm1a2TsFC3DGw2ZVhMS+W/dZNDKTiMukMC32b2LbyBv?=
 =?us-ascii?Q?1VLxBbQoY0Bk/aHAWp48Fm5ssQn9An5a91WxIFnx0u0uwGcibprtBhHwskHb?=
 =?us-ascii?Q?8xkaHeUs+4XqbqGvxW49jmF8NBsfxMktiJ9JzLLFTzqwtIGM2lSLzRiRaNUQ?=
 =?us-ascii?Q?HMhDafz5seBhzCkZnPxY3xmJa1zmqD2+VrmJc7RkdF8r0ju9BpSQKNIMWMAJ?=
 =?us-ascii?Q?ir1WXpHMgLvxM7C0BDltMu5F3W3A4galxl+T6w5Sg9wjZVKtCREHolOEU2H9?=
 =?us-ascii?Q?giW0czhO9+MdjJ/dLkn+xlOTlWk7zydXgtUO0yAfyXf/YxXY7IOCh9hw8CrA?=
 =?us-ascii?Q?5pson6iBv3BEHNLtM6n7fd1BuIKGjXLCWybjAF1O9KOiISkbtYsnxJlCRMPT?=
 =?us-ascii?Q?8y5bLcc5o/TkkIXK0Cx7Y06qR+WFSxqpa7OdX5GRxDHLwiPsvD4EE3fJbF8x?=
 =?us-ascii?Q?TRme+Iy2OaTCl3stLu2gGjUprtRrYsoZCZ7V+dn8mTrY8SEC5SgfYIPB2Raj?=
 =?us-ascii?Q?DCxHfcqs/AsaGtZLt97KhkM+bVvVyus2EzbcR2RiDSuQvI61nFxdSVf5pehU?=
 =?us-ascii?Q?awB6lFCChr8dA4zct6l21XzvFcJgHuWRYNM8hlLKZV/wniN6y5Gzct6ccBoO?=
 =?us-ascii?Q?qTTDrICoV0C1ENscUxyrp5LNybWS4WPh96Tz9WZuH7e1bFwcCBDxwr3mofEb?=
 =?us-ascii?Q?+Sp0wWgrmIqBY1lLCRtFwud/DyU0QU/bl+Zym01E?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36ccd4d0-d0b1-4244-fc6b-08dde47ae63e
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2025 08:31:05.8540 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lxdDOLyB1J3uszjNC1OGSLkvCEITUWck7qM3yMVkr1reoIFp6cLzg5o4duqMOaSg6suPolPURhHt+HKvpYIURw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR02MB7404
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODI2MDA3NSBTYWx0ZWRfX9nqy+cSghN/J
 VfESVG34drbe0JYD7c3qiREcyuj7JCSqOb4drv+0+2PFkM436JKiqiJTOBRnymzwNAvy7I9z0ic
 r4qUSqmnTJ+hiAsRXBQtuS+Ij0S5dTLUoqpFOF42+8OZkLh5jFgkXLYj2doeUDAf+fLg/9l9/4/
 mlICqGHmv8HfqsuBVYHYcQZySrm2XtRmlm7czdGgKju03TloH2LJHcc/WqvS5ulWgtnKaNXghIP
 /0dzcsa+fCT9Ty/bjP+rYWxfWt1/ywCbS0dJjWgAxsDG6Gai5QmlOTB6NjmlsS6WDyisZhH16Cc
 VuAIA1tgrrzc07J6xSYNuzHcG+BklpTuCiNVhENKTd+RyrJXMOppkjwk8tPl8U=
X-Proofpoint-ORIG-GUID: 6VhA716LbiKYTywC9lIfB2Ewdq9wLMsX
X-Proofpoint-GUID: 6VhA716LbiKYTywC9lIfB2Ewdq9wLMsX
X-Authority-Analysis: v=2.4 cv=Ae+xH2XG c=1 sm=1 tr=0 ts=68ad70cb cx=c_pps
 a=2CGiMo3D+WyQmyd9lmq5eQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=2OwXVqhp2XgA:10 a=0kUYKlekyDsA:10 a=64Cc0HZtAAAA:8
 a=AsuM2kbEzKHZIBb9HfkA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-26_02,2025-08-26_01,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=john.levon@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

Tests might want to look at the whole output from a command execution,
as well as just logging it. Add support for this.

Signed-off-by: John Levon <john.levon@nutanix.com>
---
 tests/functional/qemu_test/cmd.py | 53 +++++++++++++++++++++++++------
 1 file changed, 44 insertions(+), 9 deletions(-)

diff --git a/tests/functional/qemu_test/cmd.py b/tests/functional/qemu_test/cmd.py
index dc5f422b77..c19dfc577f 100644
--- a/tests/functional/qemu_test/cmd.py
+++ b/tests/functional/qemu_test/cmd.py
@@ -45,6 +45,9 @@ def is_readable_executable_file(path):
 # If end of line is seen, with neither @success or @failure
 # return False
 #
+# In both cases, also return the contents of the line (in bytes)
+# up to that point.
+#
 # If @failure is seen, then mark @test as failed
 def _console_read_line_until_match(test, vm, success, failure):
     msg = bytes([])
@@ -76,10 +79,23 @@ def _console_read_line_until_match(test, vm, success, failure):
     except:
         console_logger.debug(msg)
 
-    return done
+    return done, msg
 
 def _console_interaction(test, success_message, failure_message,
                          send_string, keep_sending=False, vm=None):
+    """
+    Interact with the console until either message is seen.
+
+    :param success_message: if this message appears, finish interaction
+    :param failure_message: if this message appears, test fails
+    :param send_string: a string to send to the console before trying
+                        to read a new line
+    :param keep_sending: keep sending the send string each time
+    :param vm: the VM to interact with
+
+    :return: The collected output (in bytes form).
+    """
+
     assert not keep_sending or send_string
     assert success_message or send_string
 
@@ -101,6 +117,8 @@ def _console_interaction(test, success_message, failure_message,
     if failure_message is not None:
         failure_message_b = failure_message.encode()
 
+    out = bytes([])
+
     while True:
         if send_string:
             vm.console_socket.sendall(send_string.encode())
@@ -113,11 +131,17 @@ def _console_interaction(test, success_message, failure_message,
                 break
             continue
 
-        if _console_read_line_until_match(test, vm,
-                                          success_message_b,
-                                          failure_message_b):
+        done, line = _console_read_line_until_match(test, vm,
+                                                    success_message_b,
+                                                    failure_message_b)
+
+        out += line
+
+        if done:
             break
 
+    return out
+
 def interrupt_interactive_console_until_pattern(test, success_message,
                                                 failure_message=None,
                                                 interrupt_string='\r'):
@@ -140,10 +164,12 @@ def interrupt_interactive_console_until_pattern(test, success_message,
     :param failure_message: if this message appears, test fails
     :param interrupt_string: a string to send to the console before trying
                              to read a new line
+
+    :return: The collected output (in bytes form).
     """
     assert success_message
-    _console_interaction(test, success_message, failure_message,
-                         interrupt_string, True)
+    return _console_interaction(test, success_message, failure_message,
+                                interrupt_string, True)
 
 def wait_for_console_pattern(test, success_message, failure_message=None,
                              vm=None):
@@ -155,9 +181,12 @@ def wait_for_console_pattern(test, success_message, failure_message=None,
     :type test: :class:`qemu_test.QemuSystemTest`
     :param success_message: if this message appears, test succeeds
     :param failure_message: if this message appears, test fails
+
+    :return: The collected output (in bytes form).
     """
     assert success_message
-    _console_interaction(test, success_message, failure_message, None, vm=vm)
+    return _console_interaction(test, success_message, failure_message,
+                                None, vm=vm)
 
 def exec_command(test, command):
     """
@@ -168,8 +197,10 @@ def exec_command(test, command):
     :type test: :class:`qemu_test.QemuSystemTest`
     :param command: the command to send
     :type command: str
+
+    :return: The collected output (in bytes form).
     """
-    _console_interaction(test, None, None, command + '\r')
+    return _console_interaction(test, None, None, command + '\r')
 
 def exec_command_and_wait_for_pattern(test, command,
                                       success_message, failure_message=None):
@@ -184,9 +215,13 @@ def exec_command_and_wait_for_pattern(test, command,
     :param command: the command to send
     :param success_message: if this message appears, test succeeds
     :param failure_message: if this message appears, test fails
+
+    :return: The collected output (in bytes form).
     """
     assert success_message
-    _console_interaction(test, success_message, failure_message, command + '\r')
+
+    return _console_interaction(test, success_message, failure_message,
+                                command + '\r')
 
 def get_qemu_img(test):
     test.log.debug('Looking for and selecting a qemu-img binary')
-- 
2.43.0


