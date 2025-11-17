Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A75ACEACEF
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Nov 2025 15:57:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vL1bU-0005Sd-4Q; Mon, 17 Nov 2025 10:57:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1vL1bP-0005Qm-2r
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 10:57:15 -0500
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1vL1bG-0000eM-Os
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 10:57:14 -0500
Received: from pps.filterd (m0127841.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 5AHAd9C8776355; Mon, 17 Nov 2025 07:57:04 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=hUg8MCOdkRKztLz01jIic76so/Ql/SYafk+7hRerE
 /c=; b=x8p00CwBHcNp6oQzPF/rV4XjQKa8x+/AyMhmraZ20gefvaD15NVdmgsxf
 7LrHYd1LCAOEQinPNy2OzvM+abXITquRwcXCy+CDQxVK2+wxW0NGy0XsiUEf+kTb
 OwpiK7KaM/Xm44nTkwkf0I7kLNUXC94lzTrJ9qSeiC3I4dNOG6g39lEkKsaog6Ah
 VT3WK46SkvUJ7ncWlO+3HzgQDeKhP4tHyt/SzWlPPc7Z3m9O5Z+b0P5TjOk9n9Fx
 3FiUvL3a6M5Pf2AODxJoeP4nxg5HtAdj47hLcHvnlAVzppSjIykC1Ikxe4hYZ6r/
 LNbayLi/Un51rOfgMuMVjmaw26EcQ==
Received: from sn4pr0501cu005.outbound.protection.outlook.com
 (mail-southcentralusazon11021102.outbound.protection.outlook.com
 [40.93.194.102])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4aeqxc3kd3-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 17 Nov 2025 07:57:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fp34RNXy0PkK+divj1RLL/ax3DkFqPntfTWPbTuUYMkugjbKPx8+q55PV+uzX5GD08a41w3UBBP7k5AAmf4f2g0iVdgfFqmi+cKKokYs0yNx5vr3UA/RpWhCsYqohuTFEq5dLESxUPJkRqzSQ8zrhpClfl+04GrwBFN67yl1FfzL4i1V26WoW1YqCX+TstcZnCP4S/4Gq7f6B22eKHSnJWL9MXM1pAJF1fXnLgSqRqvI/wCK5/IlT7fBuneFME/FxC1Go/SqNOeNuQwptENSnoIz/0qGudeTPm6vQvCceNuYHeffL2/kWk/X27u3xvawIzwj65uupG8rm35G3tvTtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hUg8MCOdkRKztLz01jIic76so/Ql/SYafk+7hRerE/c=;
 b=X0/7ULnxe+AHncUFiQ2vHY4g7NIx9ZSFfVJJryGBD4ki7y3fPLIoBiWt8vV8NOrOA8nvULk2NxGezZHdWRvXvD0+1Jt2ll1zjh1zoxmNj09IW/SnFpr0UU58omyWEm2wzbBdWhJUAPwjoqRGLNtX2zDnTOECpZlYf5yWfoZg9NzDsaE+ihoZ3dxMO0c65wnO2YTH9pDkZJh4Lz5gIV8w1/clcJETaKdr9bfN5bDkhv1TQHThyPhptdckMuNFl1Llqmd/RrDtOw8g8HNg/TP6K330yRyDDZiz2GwV/ZxspMsPgpGdkrZlorFw50jyu8PTVNT8IJ+WfaEvTs5q6YdTWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hUg8MCOdkRKztLz01jIic76so/Ql/SYafk+7hRerE/c=;
 b=VZkUc7h+i3/aQ6b6SLS9CgSM+LoBpi1R8eew4KesOHwPQrEg1EpsiDcLuNRkMFkNy6dnh32r0Sw1cwdudTAu2PrA+9U70RI9/C84PpVe9mtb2nUctXNrbqiQKXMCdlAzf8veSPaYp9ApmAwZs99VUCz/5Lh6evIhqFcrjYYxvP8W6wYHcqR8ENgkjlgImmAh9PFiJjao08O+UEb1RXnKvc8yFJgv1SMoU+hP2HUvbK3waJjJA8nA78cxDd+Bpf4Odm7zqKmnM0QS0loDhAbgzSfgDQXE876ycO2mLa4ZbkQkW7Om1Pijhp8Zb8KERHSqlK4698UBxEAIdZx+0CYmqA==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by PH7PR02MB10025.namprd02.prod.outlook.com (2603:10b6:510:2ec::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.18; Mon, 17 Nov
 2025 15:57:02 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51%7]) with mapi id 15.20.9320.021; Mon, 17 Nov 2025
 15:57:02 +0000
From: John Levon <john.levon@nutanix.com>
To: qemu-devel@nongnu.org
Cc: John Levon <john.levon@nutanix.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v2 2/5] vfio-user: clarify partial message handling
Date: Mon, 17 Nov 2025 21:26:53 +0530
Message-ID: <20251117155656.2060336-3-john.levon@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251117155656.2060336-1-john.levon@nutanix.com>
References: <20251117155656.2060336-1-john.levon@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0226.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a6::15) To CH2PR02MB6760.namprd02.prod.outlook.com
 (2603:10b6:610:7f::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR02MB6760:EE_|PH7PR02MB10025:EE_
X-MS-Office365-Filtering-Correlation-Id: 35385e5a-8d3b-4e4b-70d5-08de25f1f2a8
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?KhR/CTsE83nFZ1sGaWhD4MrbXx6j9PAttgdR8VPJVUTiWo6yh9iPmk5j7rEw?=
 =?us-ascii?Q?6MVuUSrOMejONphmqoTLCPCHIjL2RyTvK+0zePyvetpmc0Vyd0J6boAIAsBs?=
 =?us-ascii?Q?ip5Mq8SpCJxFUIgIbt8vkWjpojsKkzFqYuBowKXA9o+AvtptRrNndvRld3f9?=
 =?us-ascii?Q?a5fDZHBKFMFkUAaHG4wIaObhNHEutoIuQY0Ka0uGcfYV10Suxa+FCrsPXhfH?=
 =?us-ascii?Q?1NBqYOrSX/5IHg0w1cpfXWx2TfVyXDBdXLPnoSAZVWh/NAhWq7I7KyZ5M5ea?=
 =?us-ascii?Q?is6uEuLGtSGZ+UXPfEpJRq2u7t4QIDej2/YolE7UznnnQKk6l6XBGjziTCsi?=
 =?us-ascii?Q?DffQONZLKyrDJSJw5vHrsYLzPqX4OBKHjF/4q5H8mF/A99YdJuueEXennqhn?=
 =?us-ascii?Q?Q0fvZY91f1Vnaynm23OYnEbjzFWwxaV3pgDWJY+ILaKXWx+SXn9OI7IcLrBA?=
 =?us-ascii?Q?wy+WE4SZN7QneUPaVDv56UwWk6G3QrSBLrShWlf2M3wjTDSHGZVOzeFoMd/y?=
 =?us-ascii?Q?xnSsXAz41D5BKdI+z96JEZrxbf0AbFLDo726GJeVqW3GNxoxrsMadFvySJ/F?=
 =?us-ascii?Q?nQPoQSs9IbEjW8oNvjXvpeWpf7DmW+4qvhMMcSzPlSBqCWzIq7A1xCcedroD?=
 =?us-ascii?Q?6xFa9lAoHyiapZqJb3HrnVRqrgCfFPcG8Z26JQFEU6+Zsj3ahoyU99v3/QzG?=
 =?us-ascii?Q?8t7Kc4LhVTPCPCAIb9Ld71hzvYIhvXXpO33TyNCYXCQw8+NX8axKAxMMb0Vh?=
 =?us-ascii?Q?v+0v+pjS8j3cs+XovTtCJrHOb1QkzzKWe3Pqcr5kscGSF8DJPYw3cAWu1J4Q?=
 =?us-ascii?Q?9JdpD2TvtTBkeC853stXjNg7+pShCUVvjOJmBL24hFWv5LCOSTPNcKH1FAd0?=
 =?us-ascii?Q?ubwzb7pjPxvDMnOBTGQY/We2VZhX6zq2ypwIc3nu9mYnqIEBavs5BMybvy5R?=
 =?us-ascii?Q?w/1aB+iFcPxWVxCV4EvtFV5saCxrLi8+8AIPUiugqwOVyu+YsTF/W8vlfIaB?=
 =?us-ascii?Q?y8Oxpkf+MPgvMQyL6FPj2+oirWKEEjYFzn5lgRsq83IRhfXbqCS/p/SULLHo?=
 =?us-ascii?Q?QjQbM8en1nVBlD8wJ+rZfYE4+i6IbqRZWybYzz9XV89Wy9+VvJkOR3yC5Uvb?=
 =?us-ascii?Q?ixwCK+J2wi1J2iXWCDF7k6u11TJIZhtmGeOJmyxrqa0wd5UgKgzUb3Va/weu?=
 =?us-ascii?Q?jv2+qGspjVNoP2Nm2zgPJ3y9DR8nJB+ytQuG6dnv7TYa/yfckJpVSNhTUW87?=
 =?us-ascii?Q?edNisv90xwFLwqmrDlcCvt+KZMlxs28584tavk7bHJ4jrX+n+MnlIrb+rWE8?=
 =?us-ascii?Q?w+e6z0wtjoQdCkp/8rzh5jLSZ4mYsxUBMzaMswaB2gEiStPG86UTRqsew9SB?=
 =?us-ascii?Q?6+2OfIQ7hyZd6FLp+yeeGtAJ4fstkUt9fA1iwAddpQ8HGxabVytO+ucCZbpt?=
 =?us-ascii?Q?1ep4jb+mW5TBM5GAf5lx1KyUrbn+Z9l+?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ka7x7FP6SAOsJ9W/bkxfNHjy+Nox/+UaftThRJV4IbqDgebsyL506dXSfPRV?=
 =?us-ascii?Q?2mlBs5rY5q3r6m37afiqZUrEHN5cPlv+dDudbGsd7rseGLjpjxMSDTyxUBGz?=
 =?us-ascii?Q?2z2/3JHBy6Dq2G0JwdM2auqed5AikImg6d9e/f5aUedC1Impye795TAoc8x9?=
 =?us-ascii?Q?Fh8E1NI6mPYgvtMVc1UISJOFNjJX7uSIMHxAAtmuKr3QEuIpwFcdcb+EjjjB?=
 =?us-ascii?Q?UuHEw+mrURxEy1cP/+zxVzk++CWeCVpPX7GqYFDL3ef71vnXLMJcN9lGdKRh?=
 =?us-ascii?Q?W5ryT/rIsmMv6BQ4MDOW3HJZ4FHc3MK9+1KO7FwFIsB7Dd1gQl66zBAr5Fjp?=
 =?us-ascii?Q?X8et2JXQ+9bwxfgRXNHhC+4JVr1s0GU3qMa24l4VegT9oX9KldiFvMnJhH/g?=
 =?us-ascii?Q?5DAV8WwrfRXcHyW1/qgm/M243O96xw/en7ZfGK77gY8+Ei7hAz5BuxGX5tHH?=
 =?us-ascii?Q?PjNWgH291ja3zV25i8RwTNX9SD8w+P5hfmWOXauPhIckxuRcsy7M3VFg/odv?=
 =?us-ascii?Q?GVzslDwfv290seRp19LcW2H/zyL8RROdU6FJC/yF8wajsqlSEi2WvzH3RgGE?=
 =?us-ascii?Q?/iw6TrSEVSkh//2eIay9XcwvUEg/PCrz812YnJa4+doL5qth89Hec83mW0ll?=
 =?us-ascii?Q?+5qyXGI9Ofme8ZEU8SMibeO98FGM8nwexGDDAGyD4WZ3t0BD6ggMPdxtNgVl?=
 =?us-ascii?Q?wfV0tzTJ1wATv/maK5T7NBQbY1ekOZ5M7TGxXEdunqnOsxCLXOiocALwiDcW?=
 =?us-ascii?Q?8vTPNj67sK2P88PIIBa/JZC4nAA9wbffzdJuRp8DuxbTc+N7scHCktx56/z/?=
 =?us-ascii?Q?BMx+IEHKSQS84UV/hpuvuE01Ipdo0RY4Ff03jqkawSGhmmZMM2uW410cmyjq?=
 =?us-ascii?Q?rMbOqn79LAf5aj51+2GsPs63pEaeLWwaxWw2Qe3ZhNZYwPN2wCnTO2EuPjib?=
 =?us-ascii?Q?hN3Tnb90ePi/VSh0u5cCpZGNxPhiva4ZFwURJdGFIVnxN0AcL99bBH0QBEKt?=
 =?us-ascii?Q?9A2HJmGi+oet2x3cnc9fvYqFY6N6kX7vAlmtPlSUlXQ0fpEiQdzm9Xhe2eRo?=
 =?us-ascii?Q?NVJmSNf9sJE5+amztTbu0fjPlugfGfQxRx5ySCrAmXWyIs6Idxx/4CYwd1bH?=
 =?us-ascii?Q?Ef0/tQVyPGdMFef1ytGblNBwHjkt8cmd6y5ka5XHqZnYo6NVhHZwAN4j76n6?=
 =?us-ascii?Q?PEp0vCsQECJgGAmYOavcKzJtFeNayQuVmFToq9lWsZ0z5MDRwaqQx5ikOhkb?=
 =?us-ascii?Q?bElGQIkrQgnZXSa4ofVitFuYI1qJVGFagYglbSlGi8KMHCzDkxTFfvjvvKGF?=
 =?us-ascii?Q?3K02oND7BFzN1h8o47mT0GDTV3La3AKckL1KEEpoeH487+YhayxhJ9Wl132H?=
 =?us-ascii?Q?ROFvmtfO2fc/8KNCA14o0sywS4tN1kv2I/R4HZmGM/KPFp5u/z7Fm7EWUO0H?=
 =?us-ascii?Q?Ej0WDGb3n32dhwYUjcfpcH78MWYRKWvOoy8mD26bB1HzlW38WknkG/v7bDaS?=
 =?us-ascii?Q?X926OYQmy6LKXybpkbx4fqxCWrruNusDJEjcsoLSOkJyz29o9QWTuRvZ0jy+?=
 =?us-ascii?Q?SB8QGOBIHIZ3J6AoR8zmxh501IpNvlip8xgnrcvJ?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35385e5a-8d3b-4e4b-70d5-08de25f1f2a8
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2025 15:57:02.4233 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZJ31IR1Xc3vPIdnk6jMXtA7Q3TvnJQCi5wdqnc20yzV93xAGduSkhvu1dXOWPWzu+VmfsKnrMz3vB9jXB4ZBzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR02MB10025
X-Proofpoint-ORIG-GUID: cqELropH7PtSvMAo7SML5OyiMAUA_xFv
X-Authority-Analysis: v=2.4 cv=e8wLiKp/ c=1 sm=1 tr=0 ts=691b45d0 cx=c_pps
 a=2fL0C9zJp+sLGwJJ/WOg0w==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=6UeiqGixMTsA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=64Cc0HZtAAAA:8 a=UsTzQZW-myzRIYlug1wA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE3MDEzNSBTYWx0ZWRfXyPrJQKSIAefJ
 K75WxtPXrFUNhbruNSYIULTRa2aXLmYkvDBRJY52b1ywRI7LPFQ4M0BjE/AB6Yae3UKzZuCdXyc
 k9V1A4msngt6jwaAa0Nmal7HwAo0bo307gVteGEQwG/M1uA5W9iMPM95XnmB0lIMobWX42RTxEk
 mH/pKiq7Raw8SBOxKOXB9v/JIMAsfKbi04bD/r9QfbzMsTCxT6PyLuaQSmHsoEAxSAUyxlJ5yVm
 ThWFfsQtgQcluZRWnzO6zescO0mg69zYU7xcxnohFYZo3sb6f2Cxoi6Kr4n78Vt8pPoSE2JQPD1
 zQuS4PV36ppqftR84YoVHyguzxG4n/+LeI22MWJctOWu1X7gTPFomYm//pzKz6UC08wdvHiRokH
 O5DCUrVNC4gDg5nUGPBqvCUJzfa/SA==
X-Proofpoint-GUID: cqELropH7PtSvMAo7SML5OyiMAUA_xFv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-17_03,2025-11-13_02,2025-10-01_01
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

Improve a comment for this.

Signed-off-by: John Levon <john.levon@nutanix.com>
---
 hw/vfio-user/proxy.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/hw/vfio-user/proxy.c b/hw/vfio-user/proxy.c
index 75845d7c89..82c76c6665 100644
--- a/hw/vfio-user/proxy.c
+++ b/hw/vfio-user/proxy.c
@@ -362,7 +362,10 @@ static int vfio_user_recv_one(VFIOUserProxy *proxy, Error **errp)
     while (msgleft > 0) {
         ret = qio_channel_read(proxy->ioc, data, msgleft, errp);
 
-        /* prepare to complete read on next iternation */
+        /*
+         * We'll complete this read on the next go around; keep track of the
+         * partial message until then.
+         */
         if (ret == QIO_CHANNEL_ERR_BLOCK) {
             proxy->part_recv = msg;
             proxy->recv_left = msgleft;
-- 
2.43.0


