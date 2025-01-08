Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 120C7E7719A
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2025 11:57:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVUdb-0006Us-Uy; Wed, 08 Jan 2025 06:54:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1tVUdQ-0006SP-NU
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 06:54:05 -0500
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1tVUdL-0002GE-GG
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 06:54:04 -0500
Received: from pps.filterd (m0127840.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5085doxb029507;
 Wed, 8 Jan 2025 03:53:57 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=QL9J/OlG6EPJwdAw/Q2NPHWl0j00g2towHkyvpToj
 NA=; b=JJG3Z7I44IkONXY32Ef2bvtedhe5YAstrY+5nVhc1bVO1bH6w9nuGiGRr
 D3sIBuibvolMscOV9+es7BIIOVjQSQNANnDrQrt3m/c+YoYfV1j5JfyuDxWFPYEa
 mkF2NJ2CEwF6gVEBxzXN1vEsvg1Ht/LYiOE11l6T26COiVYVOQTNk3CcXt3szV+Y
 P4L1bWryEuCJ4WeX3UpAiVoqon7GRmYilOS+ZFqAgL06RK/DihLdBohNQ+8pIcxi
 9RXM2M+zsihpFw5Si3wXdZmeREd7ODWUql8iH0nEKLUneAEUk9vINvRX6ncV/DCm
 8J7oylJeJEHf/8bvfxPqOjrFvmD6g==
Received: from nam11-co1-obe.outbound.protection.outlook.com
 (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 43y26xqhax-2
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 08 Jan 2025 03:53:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B73wroFO8dx0x3/2lxTkx21wWPqwWqcWNVkeTyZn1iTrAAdfHBTx3zsfFmcA1SxoNCKSRthUAYgNuph69lqKmJ7yv4uKD58tlwY0QCNwpmvu7m+KL3rZ5qQVk8vie92t2LefIInI4T4fTd5egoQwMfeo9PnvcLqTM+YApvX0eG+SCbxq0aNTQWb/FhpJPncEGI2mfjNoJs1zKiHGn+Q7tKHkN7rEbnn0oENy/erwkJRFZ5IPJZP/OWd1xeth1sZrt0tTfuBJu/MyiLFez8ZwWFPogkwKloVxn+5kSJBQ6fwhNSCmsrv/iUR4Ct1FwIPtBMbFi5F0hAu1K9tZZP9+PA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QL9J/OlG6EPJwdAw/Q2NPHWl0j00g2towHkyvpTojNA=;
 b=vGGVH4i5VnC0FGd4qz3hyyNv13ZdXTDWROr3rtezxn0FT34qSYU7SZulf4+NqF6PbVUjI7EdgY9FTNNUQBdSbUw3KmJsMzFA/0rovjJ76nXNVdccTBSu9UQOVTZey2ehrDxMYulyhqp5N22Y01IZQQnv5Ul98g8IP9PZVh1/Hu5Y5MCU92Ke7HUqC4wggZzVqFMGtYR32S+TnUoyN0/xupRK34icReC/k865aWs3hpwzwgocnoNiIquUpcX3CJra752fuPCS5a3WYNSOUyKL9AZSMPbuhrn1YBEVI8rwBFEuCpaypZJP4RCoxPlNRQ2nII9+cWF/gn8kXFWR1aaQjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QL9J/OlG6EPJwdAw/Q2NPHWl0j00g2towHkyvpTojNA=;
 b=biNiOAXMU8u+53ephOTjTJDb+5Gi/DrhP0EvGYv9n93dLS0T1Qr1KybhLShuzo3LuI4ri91mZtbPX19gbaDWe1fGv4fO7nXXKqZH7pxIL8/nTxuXd36BcHFk2KqeAN76zJR0B/YryLtGhtjTVAlOPvi2lCuaCYCiu4y0UgRzMd4s4wLcvV9RApKgAmBHBzaCVCU5OHCVJL2BNu1k7JLd/nKxicEaqvhau6bI8bbHdlKo3V8WycRT1CVbaDqgWLQsqKphBF5VWj/8VLrJPE8CMSPpuDAD19uie7JziulDwhS5e2unPzhMESLmLM7acxbt+k4WZ0oqBqi6e7AmtCWoCg==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by PH0PR02MB7670.namprd02.prod.outlook.com (2603:10b6:510:50::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.10; Wed, 8 Jan
 2025 11:53:48 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51%4]) with mapi id 15.20.8335.010; Wed, 8 Jan 2025
 11:53:48 +0000
From: John Levon <john.levon@nutanix.com>
To: qemu-devel@nongnu.org
Cc: elena.ufimtseva@oracle.com, alex.williamson@redhat.com, clg@redhat.com,
 jag.raman@oracle.com, thanos.makatos@nutanix.com
Subject: [PATCH 14/26] vfio-user: get device info
Date: Wed,  8 Jan 2025 11:50:20 +0000
Message-Id: <20250108115032.1677686-15-john.levon@nutanix.com>
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
X-MS-Office365-Filtering-Correlation-Id: 98f2280e-91b2-42e7-272a-08dd2fdb1c72
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?bKDgDuuYKRFWSYtUMJRjvpSxJEkwkIXFc565ZD135gw/CDSkZIC0+w1vKsYn?=
 =?us-ascii?Q?meb/efuwrjETCkuB3CA2mr2ZBX+9orGRJvX+/7vI/G8IBzqaihBsaFPMmx4K?=
 =?us-ascii?Q?t2MypZXJOwKw/HnewcHLdV0kpsRgi7NYdNiqYKeg8YZrQuXjDCaEj0RE9Jct?=
 =?us-ascii?Q?W1O8IXhLRrSu86KhjgYtIVOF0oqI+8u00kMTRnofA0Vi6xwhuXYQwa7qgkkI?=
 =?us-ascii?Q?Xd28nm/TgxXHKOuL+5M2vPG9dMM27M6HvkRXkLoB9GgkOGefR9RlLmTUCwKX?=
 =?us-ascii?Q?VQ+bkhHAagobQWYTbtTKhRBlUkZCw5B9/dHZvv9KVO9hkSlxq6Q7L0VdDTFt?=
 =?us-ascii?Q?pH0t8+AB5p9NMELGdEeCkF5bbWQjM8ZcyyQK2OGBNtgF97Q0sdKEY+MDrNgf?=
 =?us-ascii?Q?eetqPjbhNg3FDV3JfvShDY7Ael6TtKgAPAIk2N+PtR2VeP/7oHhvrpQAUG1G?=
 =?us-ascii?Q?hXsJtLPFPs5Q6oP50OqRrUTKFutvckhfTXgwjNJpBCeG8IVgmh6cfr3wlFpq?=
 =?us-ascii?Q?LkeKWjoZF4dUm9EOAqxsSDPTL9sJv6OOogXdMM9Uu853tqkQf8Ym0mLhE407?=
 =?us-ascii?Q?BMBlCKaZ5Ev/5dfy2C3mVkQz+nBAqzbSITyf1c1DuBIKQaQIJx9PnryprAIp?=
 =?us-ascii?Q?YvO9uqvVvy/H0abry1geHFwD7FVe6UjnW0qujiSsHf+mFpz868Fqb4en10u6?=
 =?us-ascii?Q?78dQQCt1oSnImybafJeMq5BE2hdXkEAGR3KHIE6FGLA8FUrjOmYjzrGsZQZ7?=
 =?us-ascii?Q?4jPs560odZ30qzTM3+mTvupb8MnBHcIU1ZEosnELgnA41aEkQvfJGvjgZxqF?=
 =?us-ascii?Q?NSBmC9xipG+XdgIxOL8denr8gtniS3LyLyBf1slnrVpxiqktaAtDBIqoFKQu?=
 =?us-ascii?Q?GDS01/spG8tZ6K6zIo3uGYjYIhE8NMShuXQ/gRJkyac74andw1+qynjM2Qnk?=
 =?us-ascii?Q?RQn5FAzOWAOzOO1Hyv1p32ADVzHmOO1qWwMLkZo3pyfEnpDNkJ5WbCWLS65s?=
 =?us-ascii?Q?mn35wru4dM7r1xh2tylW0i3zfh5Lxms5sA+DqOlbY1vsDTMdObKARFoIQOWr?=
 =?us-ascii?Q?LeavzW6L40oPxncv2XfDD/UnOyaSeF6z4KO1PvtPLWra1ggi9shqT/cSyS5r?=
 =?us-ascii?Q?24V/oE9bleW0a1/CDiyrBZFIrq/EoyrDH9MfuKS1EMl2Ra3TFmX8I1QlqZTG?=
 =?us-ascii?Q?BBYxpilcQKHLoCryCM2uHtNbG0Oy/T1bSp1hwdr2QggZAUrK//oD/WPzvGxZ?=
 =?us-ascii?Q?0fKzjxPX5KqrKRyr1B8qFfllQ/pKOhRgvFPbYDBc0kqZNEai7v/IyAae9r4u?=
 =?us-ascii?Q?Wvqa6qAUbnbcx3zZWad1YEOzpns3I8pFmVfqHJDpS25oloJN112YarOkwuK/?=
 =?us-ascii?Q?hj+CP1Z8HrLMadbx7jUNJkqdEZfI?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SNDTY3QlxK/l+wDmWAd9WgFypLU32VQloysUzvPrbU2CFgOUza3VZqA2NAnh?=
 =?us-ascii?Q?cv+J40CPvrAlBe+qP1UQ+L2G0/Xo7nC3gIZxye1QiH4KlynYe4FN8FM9Ztx9?=
 =?us-ascii?Q?GZgW9wUVoJzoX/PIeEJlNpRDZDgWu8CGEpJsekBfuxdscdw3pGOW//PIfEQy?=
 =?us-ascii?Q?djr8sQJVVGorIFhXvJNExYjmXLC+vmyrl77kQ9efACJalFnHLgEKvlg12VEn?=
 =?us-ascii?Q?9B1dymqM3qm8E/AafsgsZLJMZna1MJC98AHT1FH+UkQCJge7pudOqA0gsxhx?=
 =?us-ascii?Q?BIM5/j2gnU1uFsq3fA30zHlTzAYqwl5y3E0CWlZL7fgYt4ortj6XuR3AHXLS?=
 =?us-ascii?Q?GWCVcDITSjCt3aARAWGcRE8z3weQqFn+3ou38KlvXX/dCPnqFU5mNOhhQEr1?=
 =?us-ascii?Q?UpNBn3t4fr6rUsT0jIfm2DMt24/4kRMe1xTnV2oVnBv0aZbdL69oqjKIgD+I?=
 =?us-ascii?Q?jFmsPQ2YFxOFqmBMfN4MY9BWEKntU+BBr6vmbXuOhuYkWgPiwCb/+enAzYVb?=
 =?us-ascii?Q?TuQQ14hoQ5QAkdljlMbcKIWkQluNi0i60PGHegt3xMpbZol0PR0ZNJCVEdL9?=
 =?us-ascii?Q?coJfakXw3S8JytOjZv5o9gGr2NH+y0K2GNGehX4RWk+UjkTe14nCivNoPA27?=
 =?us-ascii?Q?HFYx1JssIZ8pduFZxSg1vkObXUvW1Ekwh5L53u1ZH8yHYX0lfpopWQCNM07i?=
 =?us-ascii?Q?YjJ3H0KPzMSHUeiWuJZFViwwjT/RQt9KUen6f8DjoVzvt1NT1IZnuWq5MOsZ?=
 =?us-ascii?Q?tqyeJu9etTj4SMVt5b6GH1qnwkOqQDeUdarY+QGp0Mxghy2ObV3Vn70JjOW8?=
 =?us-ascii?Q?QBxDbw0W7wtA93q+7wgwIIwSt1vOUUJ35xZQs+i0CPlG8Gc2IDIprOBR1cbn?=
 =?us-ascii?Q?tvTYO9kCid3E9yyN5OQhWe3/X8eTqlOEpnLseLU/fU3jb1g53osbhIat7SPs?=
 =?us-ascii?Q?TWpK+AFGB8vG6ynOtftz9Pe2F81RP7xXIiHOhTYJJXPNlz9iPQkOfa6CdF1v?=
 =?us-ascii?Q?/x/TKoSIIQobLELDJ+NDe7rKNnRSsTRN6W/eWyuw8ltXlH5IuGaX5uoAuUjA?=
 =?us-ascii?Q?sXRJU27usHoTFINzlooB6IRiyoLOhCF1oW93y76sovCjEiEzJILaIa37Ox/v?=
 =?us-ascii?Q?XXTokplVbIPs3NRoosjrCxOoEOy1vyTfp5nl3fUF7MNoXoReuPQ8D1L8wBbZ?=
 =?us-ascii?Q?c3XUVo9fNimkKtLWICHptPNCaVF9LoBK4jDN5Dde6jICrbsS0TlxKN1usRpo?=
 =?us-ascii?Q?n+/t2K7C+NDo2ajuc9tiwtijp8alYEjbTot5ZBS5j+/3Z+8+p8H02NFcINO0?=
 =?us-ascii?Q?tSfj/3PlXht6d8adrJm9KO9zqgY872zkyDyOZetnadsXZ/Dqj8CUsQOvlEbI?=
 =?us-ascii?Q?eQa7BTJnS3zFZnJV7QoxCc98KPzgAsjWFKGuztMF8lJ1MzvPj16hL73s5y0v?=
 =?us-ascii?Q?88mrqkI0g/A2BDaYSGROp0ALfq7EgzwFrZYAKwNR0xpUdru3yc3tDlqj+2z2?=
 =?us-ascii?Q?dmLRPCy7d0M/+TkqVabUTHyqUUmgH5TzDZ5qT4m21jBgqJw6cACL12nYlGBE?=
 =?us-ascii?Q?xrntjpU+KVvcOlKakc0d3TLNNrMPjp9XKUq1uhY1?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98f2280e-91b2-42e7-272a-08dd2fdb1c72
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2025 11:53:47.9472 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0NCHMTUJFBJACHM7Hg3ejx4VkfP1BQV/dPuE6hA9kcLwtPujYRzEB3FpB2WVUbMR6BR+b8rYM0okA3nuFCcStA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB7670
X-Authority-Analysis: v=2.4 cv=Z/cWHGRA c=1 sm=1 tr=0 ts=677e6755 cx=c_pps
 a=MPHjzrODTC1L994aNYq1fw==:117 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=VdSt8ZQiCzkA:10
 a=0034W8JfsZAA:10 a=0kUYKlekyDsA:10
 a=yPCof4ZbAAAA:8 a=64Cc0HZtAAAA:8 a=1OX1_22eDB2b9HH4iF4A:9
 a=14NRyaPF5x3gF6G45PvQ:22
X-Proofpoint-GUID: QWVHU4qTgvsLTJJ0Toxq51bhIB1rB9da
X-Proofpoint-ORIG-GUID: QWVHU4qTgvsLTJJ0Toxq51bhIB1rB9da
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

Originally-by: John Johnson <john.g.johnson@oracle.com>
Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
Signed-off-by: John Levon <john.levon@nutanix.com>
---
 hw/vfio/trace-events     |  1 +
 hw/vfio/user-container.c | 10 +++++++++-
 hw/vfio/user-protocol.h  | 12 ++++++++++++
 hw/vfio/user.c           | 34 ++++++++++++++++++++++++++++++++++
 hw/vfio/user.h           |  1 +
 5 files changed, 57 insertions(+), 1 deletion(-)

diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
index d66fc6c214..662bc4edfd 100644
--- a/hw/vfio/trace-events
+++ b/hw/vfio/trace-events
@@ -187,3 +187,4 @@ vfio_user_recv_read(uint16_t id, int read) " id 0x%x read 0x%x"
 vfio_user_recv_request(uint16_t cmd) " command 0x%x"
 vfio_user_send_write(uint16_t id, int wrote) " id 0x%x wrote 0x%x"
 vfio_user_version(uint16_t major, uint16_t minor, const char *caps) " major %d minor %d caps: %s"
+vfio_user_get_info(uint32_t nregions, uint32_t nirqs) " #regions %d #irqs %d"
diff --git a/hw/vfio/user-container.c b/hw/vfio/user-container.c
index f0e2dc6b6b..201755e3d1 100644
--- a/hw/vfio/user-container.c
+++ b/hw/vfio/user-container.c
@@ -12,6 +12,7 @@
 #include <linux/vfio.h>
 
 #include "hw/vfio/vfio-common.h"
+#include "hw/vfio/user.h"
 #include "exec/address-spaces.h"
 #include "exec/memory.h"
 #include "exec/ram_addr.h"
@@ -152,7 +153,14 @@ static void vfio_disconnect_user_container(VFIOUserContainer *container)
 static bool vfio_user_get_device(VFIOUserContainer *container,
                                  VFIODevice *vbasedev, Error **errp)
 {
-    struct vfio_device_info info = { 0 };
+    struct vfio_device_info info = { .argsz = sizeof(info) };
+    int ret;
+
+    ret = vfio_user_get_info(vbasedev->proxy, &info);
+    if (ret) {
+        error_setg_errno(errp, -ret, "get info failure");
+        return ret;
+    }
 
     vbasedev->fd = -1;
 
diff --git a/hw/vfio/user-protocol.h b/hw/vfio/user-protocol.h
index 5de5b2030c..5f9ef1768f 100644
--- a/hw/vfio/user-protocol.h
+++ b/hw/vfio/user-protocol.h
@@ -113,4 +113,16 @@ typedef struct {
  */
 #define VFIO_USER_DEF_MAX_BITMAP (256 * 1024 * 1024)
 
+/*
+ * VFIO_USER_DEVICE_GET_INFO
+ * imported from struct vfio_device_info
+ */
+typedef struct {
+    VFIOUserHdr hdr;
+    uint32_t argsz;
+    uint32_t flags;
+    uint32_t num_regions;
+    uint32_t num_irqs;
+} VFIOUserDeviceInfo;
+
 #endif /* VFIO_USER_PROTOCOL_H */
diff --git a/hw/vfio/user.c b/hw/vfio/user.c
index 4e48bc65fe..93c7eea649 100644
--- a/hw/vfio/user.c
+++ b/hw/vfio/user.c
@@ -30,6 +30,13 @@
 #include "user.h"
 #include "trace.h"
 
+/*
+ * These are to defend against a malign server trying
+ * to force us to run out of memory.
+ */
+#define VFIO_USER_MAX_REGIONS   100
+#define VFIO_USER_MAX_IRQS      50
+
 static int wait_time = 5000;   /* wait up to 5 sec for busy servers */
 static IOThread *vfio_user_iothread;
 
@@ -1072,3 +1079,30 @@ bool vfio_user_validate_version(VFIOUserProxy *proxy, Error **errp)
     trace_vfio_user_version(msgp->major, msgp->minor, msgp->capabilities);
     return true;
 }
+
+int vfio_user_get_info(VFIOUserProxy *proxy, struct vfio_device_info *info)
+{
+    VFIOUserDeviceInfo msg;
+    uint32_t argsz = sizeof(msg) - sizeof(msg.hdr);
+
+    memset(&msg, 0, sizeof(msg));
+    vfio_user_request_msg(&msg.hdr, VFIO_USER_DEVICE_GET_INFO, sizeof(msg), 0);
+    msg.argsz = argsz;
+
+    vfio_user_send_wait(proxy, &msg.hdr, NULL, 0);
+    if (msg.hdr.flags & VFIO_USER_ERROR) {
+        return -msg.hdr.error_reply;
+    }
+    trace_vfio_user_get_info(msg.num_regions, msg.num_irqs);
+
+    memcpy(info, &msg.argsz, argsz);
+
+    /* defend against a malicious server */
+    if (info->num_regions > VFIO_USER_MAX_REGIONS ||
+        info->num_irqs > VFIO_USER_MAX_IRQS) {
+        error_printf("%s: invalid reply\n", __func__);
+        return -EINVAL;
+    }
+
+    return 0;
+}
diff --git a/hw/vfio/user.h b/hw/vfio/user.h
index 9c3b279839..18a5a40073 100644
--- a/hw/vfio/user.h
+++ b/hw/vfio/user.h
@@ -93,5 +93,6 @@ void vfio_user_set_handler(VFIODevice *vbasedev,
                            void (*handler)(void *opaque, VFIOUserMsg *msg),
                            void *reqarg);
 bool vfio_user_validate_version(VFIOUserProxy *proxy, Error **errp);
+int vfio_user_get_info(VFIOUserProxy *proxy, struct vfio_device_info *info);
 
 #endif /* VFIO_USER_H */
-- 
2.34.1


