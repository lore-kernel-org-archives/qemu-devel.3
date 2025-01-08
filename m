Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37AEDE77199
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2025 11:58:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVUdn-0006Xc-9h; Wed, 08 Jan 2025 06:54:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1tVUd9-0006Pa-DT
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 06:53:52 -0500
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1tVUd6-0002DT-BQ
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 06:53:46 -0500
Received: from pps.filterd (m0127839.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5085dSj1010866;
 Wed, 8 Jan 2025 03:53:40 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=8xEkQYfzqCzomLry3lIyC7TNElOKkQSjoHKbKYPKP
 ME=; b=JLG8WultFf7BB22ZIwtkLrUayXmn2ULxz0VynbJCWP2n48MPELP3WDrlr
 T88UDjKcgDXfIBNPQn2ekJiKYK7/nv2E+doIKoza+4G1XsZlbAKuLkd7+NFNxYTA
 9l7jnU3SCgIodFL5zVZ2gKsueau+f8z5pwcYTIL+99h/XimTqF7CntAWuw+tTHUx
 RsHyGR4WHS/H4TSzS+UXSnvusyrRIPzY2MAjNVPQRTTtbvzgzDeCUbbfCmqIfSug
 QSa6H9AXBkDkYO7yM3eMfvbmewnDBwnFDITiaKAS4a0Vgl/Whj/r1e3w4pYMZQnd
 wXEdcwlXiFQyHPU/S4WLVLAwUR86A==
Received: from nam04-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam04lp2047.outbound.protection.outlook.com [104.47.73.47])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 43y4xmyd10-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 08 Jan 2025 03:53:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WHglmIAbrfcPiiBjEYbAj4VVHpQ+62jbZNO0ZP0+8ebB+sQTz07VUjEGxxnTj5gZpbnG5DiE5Uyiacax/5qknam7R5CW2WZ+JymxWnLzmuYs39PWPQLig5zt8GqOa7ghbEchg+RKSyvhr9AGeEaahGF7RBP9uP3pVnNFdpa7WMN1dojS8IUHoJfYOtGKilQO3nSJfZ71+WKDz6RoK2PAMoiBKeflzKgLLGfNX2KmrcoSxmL+3fYphAmRyilia7dN9c3SEkzOtD24HMq5rTTWeKSY8mii5bKb0QKfGRNT80a6UGyQ/7YbaWIcOdhp1RHoCGyuAZEpW9TqYn3Kj3w5WA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8xEkQYfzqCzomLry3lIyC7TNElOKkQSjoHKbKYPKPME=;
 b=vX4Dc5Vv+4blibkkQpf0TkqbbLHxTiVquIZFE49mCJIJXlp/FB7HqyYLvfk4alcktt/F91zHHz6VyA82z8TIUAy2dVxYTuSYbmnOikLDCYvEj2CkmVaqMi9m4/7pij7Oo+FuzfBhtAz+1jcQi0C1YfQeiLlVewzeZoNCsv6lZxMPA3CgvZK/AjtMHyvmkmkUKT/1Uhm4eAKHOkweSnNuxqYrbu46deAez7yHdbehmchhEqfrGpMCqnN6f/SSfjWq/RG97qkGSYxrVmMvDYRld5BkRYbS1iWZYA4NzJUV8SqgvONvOplb7C2KSACqc2n8GeDZhRKVE9TrrX8MUS32IA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8xEkQYfzqCzomLry3lIyC7TNElOKkQSjoHKbKYPKPME=;
 b=wzyOBekctuo8iYvhnUmmNdXZXc5TikhtbaHYpkNNTxYKiPF8xSsMb6QVwB0an3dox9hUGXX5cwXTO7MZu1A0rOba4FGga4+/CEry5kA7o7+LSzvt4cx/thQ//0ahQbIJELuYSod1hhRlfeq433eRMftft6VQY8//NBTdlQvTU/M4UmfDOKw/sXcl0dMEvZzlU0H1Q8SBfyrVUIXc/tyA3zUq/WRT9XCOlLfKQfMeC2wzauVuVFjHOq9VXkpUggL0AXc+2t0yRRDRo4SkDGbnfxeHlIH7ujZTEkesSmw2W6Md0WFsoxQE8KpaSwYjBZR4zVsYIQpzCt/lRb7lr+Fjnw==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by SJ0PR02MB7502.namprd02.prod.outlook.com (2603:10b6:a03:2a2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.11; Wed, 8 Jan
 2025 11:53:38 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51%4]) with mapi id 15.20.8335.010; Wed, 8 Jan 2025
 11:53:38 +0000
From: John Levon <john.levon@nutanix.com>
To: qemu-devel@nongnu.org
Cc: elena.ufimtseva@oracle.com, alex.williamson@redhat.com, clg@redhat.com,
 jag.raman@oracle.com, thanos.makatos@nutanix.com
Subject: [PATCH 07/26] vfio: add VFIO base abstract class
Date: Wed,  8 Jan 2025 11:50:13 +0000
Message-Id: <20250108115032.1677686-8-john.levon@nutanix.com>
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
X-MS-TrafficTypeDiagnostic: CH2PR02MB6760:EE_|SJ0PR02MB7502:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a1ccd0f-8671-4757-8a3e-08dd2fdb16d7
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?6GZisQBSp4PfZvAN5645PVDRLRz0MZeSH2AI+ALe7sNcGAWpHZHmG8227h2G?=
 =?us-ascii?Q?lxCUKMWzzf8zKKasHT/UXQLMwJsJRRiN/QuBAgp0hz+eB4LMx30hXtyRuy/C?=
 =?us-ascii?Q?OWvgxOGEwvFsZa8VkT9MMrje2Ls1srTRtrQdapRWKw3hv6ehjvWltGIatteo?=
 =?us-ascii?Q?D9XL1zAyO60LGhAijQ3qBM8KfulciaRom+PAzuWGnfzrifQBYaCNGo+ZeRI9?=
 =?us-ascii?Q?QKXVX0IdHFW7M7TNmDQMwQ83nfrlfnc5mF3KAata1TFO1hpi6txlXZeGWdvK?=
 =?us-ascii?Q?zUCneFcONkw8M7U4fV5Q1xpFhkA26IXvi9DrG/WGiaKdqtu5FWLvYMe5kaSb?=
 =?us-ascii?Q?sC60/aqEWYKk6L7Z5oUB9qgT42Lc8Yu2GpWICtBLDKeH/NW6TGbvUXYiYiEa?=
 =?us-ascii?Q?KfKuzd5O1NA9yrNVPIN4R2MejeNyKgtbzsVRQGsOlzh2ONTu8w428aCwQThf?=
 =?us-ascii?Q?S/edEfaROag4vv/IrF7UKlzu/mjTcehplkkLyDZJ43ucrV55Lwbo03kmtD97?=
 =?us-ascii?Q?U5bWaoE7de8ywPAJ4FqONiWWqsAGlngHzFYjMBfdwpG4MEIEV6GT0bfGNJks?=
 =?us-ascii?Q?2eIvEcn1ZpbCmoEuLYPB9oiHp0si0nuiuWDZiypISFmMehiIcwcHuij9zCxv?=
 =?us-ascii?Q?9FB+MHdqWPqor6OYfVZkP3IBw3dwZXxc8OUZDOxZk7Y9X45Mk+uovAgha6h6?=
 =?us-ascii?Q?HB1rGVSIgw+D3A55SMJgxmSdhJtq9gvL56IIn1uq3oF+qJlamaGUUboMaGJs?=
 =?us-ascii?Q?k9Id+ep/wdHqBrVghqnNmg93ZzSjw8z70Wu+5vjd8wGolxg9A8VmVRMye/0B?=
 =?us-ascii?Q?KC4hm5Q0r2cGtb10yeQwGnBbJ3Cu4Rl+TSgA5Cf7SSxqxbHBB9cL8yG/dl/j?=
 =?us-ascii?Q?2yPvjLS0kwpSol7LFxcnzP/xWgLplWJ2NE2jRXEwPrhBHTkf34IAXYOEXoLw?=
 =?us-ascii?Q?DDyE6Ak7M7MB2J6e+bh3hOu06PIorq61JoSXLWZIfB77VKc8tmuKuzw/az5+?=
 =?us-ascii?Q?V79oBKHcWNsoN9UR24wdzp0M02KQ0/Ba+gJ71W4GPbUiy83+yUktfLA9CwDk?=
 =?us-ascii?Q?wbqu3N2YhKfKXfh5rmuJFYEkyXls4l66CtY5AwdOg5OZYnyzocV2g1AuGFH0?=
 =?us-ascii?Q?KV+WperZX1g8Cj8v+SjrPn4OUR8BzbKe4gWOlsF2Z6WrhMVbY6NtiOMb8bB9?=
 =?us-ascii?Q?SuGFlPLdyrM05dvzP3U7BvMp8Wp3uo4EvFtoSaynHVXlCAdMjqIQQbwviGMh?=
 =?us-ascii?Q?gZxBp6Ct3hkcai4UgrPWQ4cOAeCHWYGPucS9RocSr+oIVXpw8y3OMYCADVh5?=
 =?us-ascii?Q?JsDjnLOOZE2fwboQjURJ+hn9OcH9x578RHcJHwHYzzDZwL7kiAjxvmXoRejc?=
 =?us-ascii?Q?TfmcnhG/8aRTAYyOXURtJ+awNl/Q?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RBg7qCWSz2wIHSIbMmraNhS90caZXihQDCPHEyrlFsXQIBQ/CoTTfTTa6FoJ?=
 =?us-ascii?Q?C4o36374xGU4PNKTspiWg7sRUWa3Cf1gtntKaXhdIsGuaQ2W17kXAw/ClCHP?=
 =?us-ascii?Q?ZcA1d3wfT/sKo2VaduOUmlTijt23v9YG6TO+Nnju8RxvU9+yfj3h1F6c0JJ1?=
 =?us-ascii?Q?2oJH3+AeDOOrlCkOBdCcigmShoRp0eU1RB6AQNZaHOgGbyFKxT7KAsRdxOjS?=
 =?us-ascii?Q?/lpEGiMDddgO0J74+sVBrhd6oRezPwhezgl+V94jcJhRz4lbIIAuzV+8ioKW?=
 =?us-ascii?Q?JkbfnZ90PNhaciBD0JQbcw+/foiipYjmQdtMHy6Fq/h7AOrHwzYAKJBjGPIZ?=
 =?us-ascii?Q?cvSE6/AHJ+H51JsCnA72dXe6z3lt7D6+0AttEn89ox5/yfi06o7q9aW78HDa?=
 =?us-ascii?Q?SVypm/1F0OhNtQOOQjI+CPlvi6/K9ZlfRtsTVzP3nOhtvadtYMQ3alHPhJSv?=
 =?us-ascii?Q?WtXsIJdl74UKyr2FO3k13e/BKxbXVwIvzhH0X0Ev2GDxMVpH0/8jlLGMC52W?=
 =?us-ascii?Q?fbNudLiei4HLDpfDpkuel3+FA7MXPEoEmlgCtBuFKVNUJfbuqhJg9MgJgAs6?=
 =?us-ascii?Q?zXom5bcLlfK6KFVsddQyKll9ZFFyQ9/7mk8R/MsWyCl3GQ1IniS9bmLRjXbc?=
 =?us-ascii?Q?5giqnpwz/a8XcJg75VnDEhSMg4Dh6ePre6Qt5AiopdJhYPYBgQrmyrsXjCo2?=
 =?us-ascii?Q?OXmYXMbY2w0QtRZAIMR6N1P58xCz8LHxeHfLLbMwjJwP9iCoteGN9fGw1jDS?=
 =?us-ascii?Q?0dmXuAkqVXXi4jqJQgyrqHuMomqndhgYuHcsX7YMdQzZ9+gfLpNQTcETbq24?=
 =?us-ascii?Q?cwWYwz/f5CxM+rRtEivteTbSq5vGlrfX2OXjq9VcYTgfkfVU1/2HgrQXHvSL?=
 =?us-ascii?Q?3hn13elzQV47Mk85/xd+qDKLYTJMJ7hMlfAteDOgA+Bd6hivwQ0TaHPQYcFv?=
 =?us-ascii?Q?ukfx6pGuk49QJz60vYpsMbBNe+0PrALrwvkVgYBn4BewPIQ3pDfpnrCbuRv5?=
 =?us-ascii?Q?dRZcR+CV8rZCJGKYV4QzilWhkAUaqTmLBCtj5mbPtsJzPqAnN3SSp1agm4/o?=
 =?us-ascii?Q?2pM8BBktIMewhpMDH8leEUvxxwPP6fdpSciL9b1+w9n61u/xboYAU4WoRL0g?=
 =?us-ascii?Q?7iHBQ2nYs+3TGK0/Q4my5b9y6UZ5O2b1eShTIBzyL3uR+XgrJpRVWjQTXh1F?=
 =?us-ascii?Q?wN9F0J68bNXCkvgYh5Y4vjxdWrvIfNxnv4REGDvcmJwIJBsY2jw0XnorqVmQ?=
 =?us-ascii?Q?zKSnit/P2vPtQcJdbDwMqTWcl/IGcc6fZafSKjOU+X49/pIH9FopkTggwwXp?=
 =?us-ascii?Q?8g+R29uAHolLWF/4OsAF0Ikr0bpp3ph1KNaJ/4c6j83UoDue4Jhl48lckPmT?=
 =?us-ascii?Q?zEBChZIQ+jTle9MtR2V7bkqgjzZweZKveC84zgRA9U2wkToBbVVZeMoxW6pU?=
 =?us-ascii?Q?sL873vgizg2PmZPy7XfMB6gjdQAG1CyCjUeVxE/PAmNU89m2rftAGEe4kWgf?=
 =?us-ascii?Q?FYXNR+whFkvpbXB1WYwgk9VpZTLd795nDuWqxaCzrP8FV3AxWojKY+EJQs+Y?=
 =?us-ascii?Q?CV4xuElAb7l6tGbBUv9fTVwfqRcnzGXTQvbNnsLm?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a1ccd0f-8671-4757-8a3e-08dd2fdb16d7
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2025 11:53:38.6374 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: euS65IoPK9iwByq2OmRCJLjbYJ7jhc3OE8bdvLpq9fQkyxroWzM31D6YiuzRAEKmXPZ7MICySm9N5K+3xO3oaw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB7502
X-Proofpoint-GUID: 5rtlnJsrYQ0_mLDo-8iCRnL4TQ-RHTwl
X-Proofpoint-ORIG-GUID: 5rtlnJsrYQ0_mLDo-8iCRnL4TQ-RHTwl
X-Authority-Analysis: v=2.4 cv=aaybnQot c=1 sm=1 tr=0 ts=677e6744 cx=c_pps
 a=2scX5b6JGDBY9+deG5t9BQ==:117 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=VdSt8ZQiCzkA:10
 a=0034W8JfsZAA:10 a=0kUYKlekyDsA:10
 a=yPCof4ZbAAAA:8 a=64Cc0HZtAAAA:8 a=6NY-EL8SuTLSG1x2ugYA:9
 a=14NRyaPF5x3gF6G45PvQ:22
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

Add an abstract base class both the kernel driver
and user socket implementations can use to share code.

Originally-by: John Johnson <john.g.johnson@oracle.com>
Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
Signed-off-by: John Levon <john.levon@nutanix.com>
---
 hw/vfio/pci.c | 107 ++++++++++++++++++++++++++++++--------------------
 hw/vfio/pci.h |  16 +++++++-
 2 files changed, 79 insertions(+), 44 deletions(-)

diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 8e6f20b3ad..bb0d26915b 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -239,7 +239,7 @@ static void vfio_intx_update(VFIOPCIDevice *vdev, PCIINTxRoute *route)
 
 static void vfio_intx_routing_notifier(PCIDevice *pdev)
 {
-    VFIOPCIDevice *vdev = VFIO_PCI(pdev);
+    VFIOPCIDevice *vdev = VFIO_PCI_BASE(pdev);
     PCIINTxRoute route;
 
     if (vdev->interrupt != VFIO_INT_INTx) {
@@ -514,7 +514,7 @@ static void vfio_update_kvm_msi_virq(VFIOMSIVector *vector, MSIMessage msg,
 static int vfio_msix_vector_do_use(PCIDevice *pdev, unsigned int nr,
                                    MSIMessage *msg, IOHandler *handler)
 {
-    VFIOPCIDevice *vdev = VFIO_PCI(pdev);
+    VFIOPCIDevice *vdev = VFIO_PCI_BASE(pdev);
     VFIOMSIVector *vector;
     int ret;
     bool resizing = !!(vdev->nr_vectors < nr + 1);
@@ -619,7 +619,7 @@ static int vfio_msix_vector_use(PCIDevice *pdev,
 
 static void vfio_msix_vector_release(PCIDevice *pdev, unsigned int nr)
 {
-    VFIOPCIDevice *vdev = VFIO_PCI(pdev);
+    VFIOPCIDevice *vdev = VFIO_PCI_BASE(pdev);
     VFIOMSIVector *vector = &vdev->msi_vectors[nr];
 
     trace_vfio_msix_vector_release(vdev->vbasedev.name, nr);
@@ -1168,7 +1168,7 @@ static const MemoryRegionOps vfio_vga_ops = {
  */
 static void vfio_sub_page_bar_update_mapping(PCIDevice *pdev, int bar)
 {
-    VFIOPCIDevice *vdev = VFIO_PCI(pdev);
+    VFIOPCIDevice *vdev = VFIO_PCI_BASE(pdev);
     VFIORegion *region = &vdev->bars[bar].region;
     MemoryRegion *mmap_mr, *region_mr, *base_mr;
     PCIIORegion *r;
@@ -1214,7 +1214,7 @@ static void vfio_sub_page_bar_update_mapping(PCIDevice *pdev, int bar)
  */
 uint32_t vfio_pci_read_config(PCIDevice *pdev, uint32_t addr, int len)
 {
-    VFIOPCIDevice *vdev = VFIO_PCI(pdev);
+    VFIOPCIDevice *vdev = VFIO_PCI_BASE(pdev);
     uint32_t emu_bits = 0, emu_val = 0, phys_val = 0, val;
 
     memcpy(&emu_bits, vdev->emulated_config_bits + addr, len);
@@ -1247,7 +1247,7 @@ uint32_t vfio_pci_read_config(PCIDevice *pdev, uint32_t addr, int len)
 void vfio_pci_write_config(PCIDevice *pdev,
                            uint32_t addr, uint32_t val, int len)
 {
-    VFIOPCIDevice *vdev = VFIO_PCI(pdev);
+    VFIOPCIDevice *vdev = VFIO_PCI_BASE(pdev);
     uint32_t val_le = cpu_to_le32(val);
 
     trace_vfio_pci_write_config(vdev->vbasedev.name, addr, val, len);
@@ -2961,7 +2961,7 @@ static void vfio_unregister_req_notifier(VFIOPCIDevice *vdev)
 static void vfio_realize(PCIDevice *pdev, Error **errp)
 {
     ERRP_GUARD();
-    VFIOPCIDevice *vdev = VFIO_PCI(pdev);
+    VFIOPCIDevice *vdev = VFIO_PCI_BASE(pdev);
     VFIODevice *vbasedev = &vdev->vbasedev;
     int i, ret;
     char uuid[UUID_STR_LEN];
@@ -3251,7 +3251,7 @@ error:
 
 static void vfio_instance_finalize(Object *obj)
 {
-    VFIOPCIDevice *vdev = VFIO_PCI(obj);
+    VFIOPCIDevice *vdev = VFIO_PCI_BASE(obj);
 
     vfio_display_finalize(vdev);
     vfio_bars_finalize(vdev);
@@ -3269,7 +3269,7 @@ static void vfio_instance_finalize(Object *obj)
 
 static void vfio_exitfn(PCIDevice *pdev)
 {
-    VFIOPCIDevice *vdev = VFIO_PCI(pdev);
+    VFIOPCIDevice *vdev = VFIO_PCI_BASE(pdev);
     VFIODevice *vbasedev = &vdev->vbasedev;
 
     vfio_unregister_req_notifier(vdev);
@@ -3293,7 +3293,7 @@ static void vfio_exitfn(PCIDevice *pdev)
 
 static void vfio_pci_reset(DeviceState *dev)
 {
-    VFIOPCIDevice *vdev = VFIO_PCI(dev);
+    VFIOPCIDevice *vdev = VFIO_PCI_BASE(dev);
 
     trace_vfio_pci_reset(vdev->vbasedev.name);
 
@@ -3333,7 +3333,7 @@ post_reset:
 static void vfio_instance_init(Object *obj)
 {
     PCIDevice *pci_dev = PCI_DEVICE(obj);
-    VFIOPCIDevice *vdev = VFIO_PCI(obj);
+    VFIOPCIDevice *vdev = VFIO_PCI_BASE(obj);
     VFIODevice *vbasedev = &vdev->vbasedev;
 
     device_add_bootindex_property(obj, &vdev->bootindex,
@@ -3354,28 +3354,15 @@ static void vfio_instance_init(Object *obj)
     pci_dev->cap_present |= QEMU_PCI_CAP_EXPRESS;
 }
 
-static const Property vfio_pci_dev_properties[] = {
-    DEFINE_PROP_PCI_HOST_DEVADDR("host", VFIOPCIDevice, host),
-    DEFINE_PROP_UUID_NODEFAULT("vf-token", VFIOPCIDevice, vf_token),
-    DEFINE_PROP_STRING("sysfsdev", VFIOPCIDevice, vbasedev.sysfsdev),
+static const Property vfio_pci_base_dev_properties[] = {
     DEFINE_PROP_ON_OFF_AUTO("x-pre-copy-dirty-page-tracking", VFIOPCIDevice,
                             vbasedev.pre_copy_dirty_page_tracking,
                             ON_OFF_AUTO_ON),
     DEFINE_PROP_ON_OFF_AUTO("x-device-dirty-page-tracking", VFIOPCIDevice,
                             vbasedev.device_dirty_page_tracking,
                             ON_OFF_AUTO_ON),
-    DEFINE_PROP_ON_OFF_AUTO("display", VFIOPCIDevice,
-                            display, ON_OFF_AUTO_OFF),
-    DEFINE_PROP_UINT32("xres", VFIOPCIDevice, display_xres, 0),
-    DEFINE_PROP_UINT32("yres", VFIOPCIDevice, display_yres, 0),
     DEFINE_PROP_UINT32("x-intx-mmap-timeout-ms", VFIOPCIDevice,
                        intx.mmap_timeout, 1100),
-    DEFINE_PROP_BIT("x-vga", VFIOPCIDevice, features,
-                    VFIO_FEATURE_ENABLE_VGA_BIT, false),
-    DEFINE_PROP_BIT("x-req", VFIOPCIDevice, features,
-                    VFIO_FEATURE_ENABLE_REQ_BIT, true),
-    DEFINE_PROP_BIT("x-igd-opregion", VFIOPCIDevice, features,
-                    VFIO_FEATURE_ENABLE_IGD_OPREGION_BIT, false),
     DEFINE_PROP_ON_OFF_AUTO("enable-migration", VFIOPCIDevice,
                             vbasedev.enable_migration, ON_OFF_AUTO_AUTO),
     DEFINE_PROP_BOOL("migration-events", VFIOPCIDevice,
@@ -3386,8 +3373,6 @@ static const Property vfio_pci_dev_properties[] = {
     DEFINE_PROP_BOOL("x-no-kvm-intx", VFIOPCIDevice, no_kvm_intx, false),
     DEFINE_PROP_BOOL("x-no-kvm-msi", VFIOPCIDevice, no_kvm_msi, false),
     DEFINE_PROP_BOOL("x-no-kvm-msix", VFIOPCIDevice, no_kvm_msix, false),
-    DEFINE_PROP_BOOL("x-no-geforce-quirks", VFIOPCIDevice,
-                     no_geforce_quirks, false),
     DEFINE_PROP_BOOL("x-no-kvm-ioeventfd", VFIOPCIDevice, no_kvm_ioeventfd,
                      false),
     DEFINE_PROP_BOOL("x-no-vfio-ioeventfd", VFIOPCIDevice, no_vfio_ioeventfd,
@@ -3398,12 +3383,57 @@ static const Property vfio_pci_dev_properties[] = {
                        sub_vendor_id, PCI_ANY_ID),
     DEFINE_PROP_UINT32("x-pci-sub-device-id", VFIOPCIDevice,
                        sub_device_id, PCI_ANY_ID),
+    DEFINE_PROP_OFF_AUTO_PCIBAR("x-msix-relocation", VFIOPCIDevice, msix_relo,
+                                OFF_AUTO_PCIBAR_OFF),
+};
+
+
+static void vfio_pci_base_dev_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    PCIDeviceClass *pdc = PCI_DEVICE_CLASS(klass);
+
+    device_class_set_props(dc, vfio_pci_base_dev_properties);
+    dc->desc = "VFIO PCI base device";
+    set_bit(DEVICE_CATEGORY_MISC, dc->categories);
+    pdc->exit = vfio_exitfn;
+    pdc->config_read = vfio_pci_read_config;
+    pdc->config_write = vfio_pci_write_config;
+}
+
+static const TypeInfo vfio_pci_base_dev_info = {
+    .name = TYPE_VFIO_PCI_BASE,
+    .parent = TYPE_PCI_DEVICE,
+    .instance_size = 0,
+    .abstract = true,
+    .class_init = vfio_pci_base_dev_class_init,
+    .interfaces = (InterfaceInfo[]) {
+        { INTERFACE_PCIE_DEVICE },
+        { INTERFACE_CONVENTIONAL_PCI_DEVICE },
+        { }
+    },
+};
+
+static const Property vfio_pci_dev_properties[] = {
+    DEFINE_PROP_PCI_HOST_DEVADDR("host", VFIOPCIDevice, host),
+    DEFINE_PROP_UUID_NODEFAULT("vf-token", VFIOPCIDevice, vf_token),
+    DEFINE_PROP_STRING("sysfsdev", VFIOPCIDevice, vbasedev.sysfsdev),
+    DEFINE_PROP_ON_OFF_AUTO("display", VFIOPCIDevice,
+                            display, ON_OFF_AUTO_OFF),
+    DEFINE_PROP_UINT32("xres", VFIOPCIDevice, display_xres, 0),
+    DEFINE_PROP_UINT32("yres", VFIOPCIDevice, display_yres, 0),
+    DEFINE_PROP_BIT("x-vga", VFIOPCIDevice, features,
+                    VFIO_FEATURE_ENABLE_VGA_BIT, false),
+    DEFINE_PROP_BIT("x-req", VFIOPCIDevice, features,
+                    VFIO_FEATURE_ENABLE_REQ_BIT, true),
+    DEFINE_PROP_BIT("x-igd-opregion", VFIOPCIDevice, features,
+                    VFIO_FEATURE_ENABLE_IGD_OPREGION_BIT, false),
+    DEFINE_PROP_BOOL("x-no-geforce-quirks", VFIOPCIDevice,
+                     no_geforce_quirks, false),
     DEFINE_PROP_UINT32("x-igd-gms", VFIOPCIDevice, igd_gms, 0),
     DEFINE_PROP_UNSIGNED_NODEFAULT("x-nv-gpudirect-clique", VFIOPCIDevice,
                                    nv_gpudirect_clique,
                                    qdev_prop_nv_gpudirect_clique, uint8_t),
-    DEFINE_PROP_OFF_AUTO_PCIBAR("x-msix-relocation", VFIOPCIDevice, msix_relo,
-                                OFF_AUTO_PCIBAR_OFF),
 #ifdef CONFIG_IOMMUFD
     DEFINE_PROP_LINK("iommufd", VFIOPCIDevice, vbasedev.iommufd,
                      TYPE_IOMMUFD_BACKEND, IOMMUFDBackend *),
@@ -3414,7 +3444,8 @@ static const Property vfio_pci_dev_properties[] = {
 #ifdef CONFIG_IOMMUFD
 static void vfio_pci_set_fd(Object *obj, const char *str, Error **errp)
 {
-    vfio_device_set_fd(&VFIO_PCI(obj)->vbasedev, str, errp);
+    VFIOPCIDevice *vdev = VFIO_PCI_BASE(obj);
+    vfio_device_set_fd(&vdev->vbasedev, str, errp);
 }
 #endif
 
@@ -3429,25 +3460,16 @@ static void vfio_pci_dev_class_init(ObjectClass *klass, void *data)
     object_class_property_add_str(klass, "fd", NULL, vfio_pci_set_fd);
 #endif
     dc->desc = "VFIO-based PCI device assignment";
-    set_bit(DEVICE_CATEGORY_MISC, dc->categories);
     pdc->realize = vfio_realize;
-    pdc->exit = vfio_exitfn;
-    pdc->config_read = vfio_pci_read_config;
-    pdc->config_write = vfio_pci_write_config;
 }
 
 static const TypeInfo vfio_pci_dev_info = {
     .name = TYPE_VFIO_PCI,
-    .parent = TYPE_PCI_DEVICE,
-    .instance_size = sizeof(VFIOPCIDevice),
+    .parent = TYPE_VFIO_PCI_BASE,
+    .instance_size = sizeof(VFIOKernelPCIDevice),
     .class_init = vfio_pci_dev_class_init,
     .instance_init = vfio_instance_init,
     .instance_finalize = vfio_instance_finalize,
-    .interfaces = (InterfaceInfo[]) {
-        { INTERFACE_PCIE_DEVICE },
-        { INTERFACE_CONVENTIONAL_PCI_DEVICE },
-        { }
-    },
 };
 
 static const Property vfio_pci_dev_nohotplug_properties[] = {
@@ -3467,12 +3489,13 @@ static void vfio_pci_nohotplug_dev_class_init(ObjectClass *klass, void *data)
 static const TypeInfo vfio_pci_nohotplug_dev_info = {
     .name = TYPE_VFIO_PCI_NOHOTPLUG,
     .parent = TYPE_VFIO_PCI,
-    .instance_size = sizeof(VFIOPCIDevice),
+    .instance_size = sizeof(VFIOKernelPCIDevice),
     .class_init = vfio_pci_nohotplug_dev_class_init,
 };
 
 static void register_vfio_pci_dev_type(void)
 {
+    type_register_static(&vfio_pci_base_dev_info);
     type_register_static(&vfio_pci_dev_info);
     type_register_static(&vfio_pci_nohotplug_dev_info);
 }
diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
index 43c166680a..8e79740ddb 100644
--- a/hw/vfio/pci.h
+++ b/hw/vfio/pci.h
@@ -116,8 +116,13 @@ typedef struct VFIOMSIXInfo {
     bool noresize;
 } VFIOMSIXInfo;
 
-#define TYPE_VFIO_PCI "vfio-pci"
-OBJECT_DECLARE_SIMPLE_TYPE(VFIOPCIDevice, VFIO_PCI)
+/*
+ * TYPE_VFIO_PCI_BASE is an abstract type used to share code
+ * between VFIO implementations that use a kernel driver
+ * with those that use user sockets.
+ */
+#define TYPE_VFIO_PCI_BASE "vfio-pci-base"
+OBJECT_DECLARE_SIMPLE_TYPE(VFIOPCIDevice, VFIO_PCI_BASE)
 
 struct VFIOPCIDevice {
     PCIDevice pdev;
@@ -182,6 +187,13 @@ struct VFIOPCIDevice {
     Notifier irqchip_change_notifier;
 };
 
+#define TYPE_VFIO_PCI "vfio-pci"
+OBJECT_DECLARE_SIMPLE_TYPE(VFIOKernelPCIDevice, VFIO_PCI)
+
+struct VFIOKernelPCIDevice {
+    VFIOPCIDevice device;
+};
+
 /* Use uin32_t for vendor & device so PCI_ANY_ID expands and cannot match hw */
 static inline bool vfio_pci_is(VFIOPCIDevice *vdev, uint32_t vendor, uint32_t device)
 {
-- 
2.34.1


