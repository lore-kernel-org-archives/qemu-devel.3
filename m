Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA704C83F03
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 14:11:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXh8S-00011C-Ut; Fri, 04 Jul 2025 10:11:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1uXh7y-0000qL-EZ
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 10:10:59 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1uXh7u-0004jm-SS
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 10:10:56 -0400
Received: from pps.filterd (m0127838.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 564BNITq023062;
 Fri, 4 Jul 2025 07:10:49 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=83pCADihsfBGAEwCDs6Ti1u2XveTZAv6qJcjLTQdT
 b8=; b=KXqUG1b2pTXKucyqEq6ra0TUIR/hkpoQLSm9VpMZHVLyfP7hl0x6G+tvO
 qs9MZnSMt3IPhQQeVZThu3WzkgtQcJgIKcykOIiyqvp9cxeND2+JQkR4iMqMw1/3
 eWIKkpOT6E4lsIYe0TfPVFmUc4xRzTxWjmXmWfYUuHkAoPcrxef8XNyXU4O2pBL1
 4IXz/+Blv4g0HNTPqqa6qWWT1jXi0Gl2PgWNlZtHB+bNQd+PlfLqJ6+7ihApuRIK
 4NE+F5L/YmQfW/bcYLxssSK1BZzN4lX87OT7kh90aHI5Goik9dg+ePugo2+CMFtX
 24oCS/2YTGJ+pgazIOOgwV8W1d/uA==
Received: from byapr05cu005.outbound.protection.outlook.com
 (mail-westusazon11020134.outbound.protection.outlook.com [52.101.85.134])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 47n1x96a4j-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 04 Jul 2025 07:10:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MvatoCKKxcbmZon58uZ8sRT0JjGw3SidTWHFmDZAhA4SGn7lQWgHlWAEz4i0XQ1oRBtPirnCeS6mqo7YgWDwFsS/qIwNigNcHZe0zEsIeyZ+Ryp/l1y0K5GMcquNFXoFzC2pv2z3VhFj1mfjzFi02My7YGz/irmkH0q3qwXaE+cbn/VUpVnNeeGTjq4D9N0cn/bznJW3Bnhmys/mJA9OAE/wEI5oqVKLj9CSPs4sZUuKLcLgpCCuH2e5/0KJ+xl6/scb7OADNtNIMVV1AwhHg4FHnyhPqWx1rI1yqENIJVwpOpFCv83KuMN6O1kmjpMD3wszn5VC/axaE+IcZwuDDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=83pCADihsfBGAEwCDs6Ti1u2XveTZAv6qJcjLTQdTb8=;
 b=e0OIXvvaZ64ndJ/2K7pEE5WyiEswpzxPspsVvfds3pk0w+zyqdpJV4bW91ahvUZ6Wp06JtUKysOeTsrBoT22sQftoFdTAK+EH9HyjVTYki9Y46VlendxQiOoOeBE6a5Il8OFAUCxS97q3ebPJ36Dk+Pmz4gt5wkbcWhcB79HHioHCBxsz/NUEgaYylk9b1aZOS82mDjih89s+8a6TLOjSqcq/sNhKum1SpCb4xbEfPBGQQ2kU/uTtpT6Q9FIqWad8sQ0CvudFt9rDv7YMd+T1AN/HO79CQD/1G5ZcxO35AZZy8jGaI1FV1V42XZ0qEcaau3m654hq6EKmSpyKb2bQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=83pCADihsfBGAEwCDs6Ti1u2XveTZAv6qJcjLTQdTb8=;
 b=IxrxqzL1vnN9YLrC4/KZPxlCHXCwQUuspEmm/4xlW5eDOpMzAk2U7RNkWqcPe5FQp6gnqYl6pnIveWmQgQ5B1e7cJfhGx2py3SMQ5TqDeeOzZ6mpvId3Qm+hvvFsobXWvKxAdaVnLGbiZRr7+NOM3EYclSa3Tow6s/LvyWdU8/rfeG48Fxj3MbN8zhkR9Qf9HB4VUmAKyyfmb60/9n/j1ArOYPYJnqVB8+WdedIWFxsY1rkAr2aL9zXxYp1wGBNJ5HBo9a2qc2e9Kw9NGQvmg4S+TDY9eggdXlyrSaM2TxdSMgNgfbHaDAGeMZGHWRXM4Hyp9+GEGoDcxDBkd+6NRQ==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by IA1PR02MB9087.namprd02.prod.outlook.com (2603:10b6:208:419::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.20; Fri, 4 Jul
 2025 14:10:47 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88%3]) with mapi id 15.20.8901.018; Fri, 4 Jul 2025
 14:10:47 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: pbonzini@redhat.com, mst@redhat.com, marcel.apfelbaum@gmail.com,
 eduardo@habkost.net, imammedo@redhat.com, qemu-devel@nongnu.org
Subject: [PATCH v3 07/14] hw/i386/pc_piix.c: simplify RAM size logic in
 pc_init_isa()
Date: Fri,  4 Jul 2025 15:09:34 +0100
Message-ID: <20250704141018.674268-8-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250704141018.674268-1-mark.caveayland@nutanix.com>
References: <20250704141018.674268-1-mark.caveayland@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM4PR0302CA0025.eurprd03.prod.outlook.com
 (2603:10a6:205:2::38) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|IA1PR02MB9087:EE_
X-MS-Office365-Filtering-Correlation-Id: 01de785d-9d44-46a8-a611-08ddbb04927a
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|10070799003|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?hK2W0sz2s8pbtKSeywCOMbQZ09wQjxuHUPop4uZ0ZQwt8kunJ6C/DfbI15GE?=
 =?us-ascii?Q?pbiqR8RB/X0wkMxyLjkLtpsCejTpX1Sj9H/hVy+jaSoDzyNtfgAu48CrUCTo?=
 =?us-ascii?Q?yTJEXn+/B60CgcFfSOklh5ugetsgphDCDEAzInwsLp48jpMQX2Gne3PXPRNl?=
 =?us-ascii?Q?oFVrfj4X0ImICIua+bn66y2sUtiGlWHGLTuZ7aMsEBbLMGbxpbzwYmAWVWAy?=
 =?us-ascii?Q?4q/xuEbff6Hp/Zvfre8YXthw0vCOKEKJ3NJEmPDembdNxbftlqiMBaQahzSR?=
 =?us-ascii?Q?t2vU5FaSzrHCRhMHSLdDmV4g3mrg2Dbd5wWVv9Lq30GvDDJHUtdwEQHBAcBO?=
 =?us-ascii?Q?5736rdx0haeH2SHxoppVEPuUxkMpbvsyUp3RwnAvGL0FgGEHbdYdvXev+oOv?=
 =?us-ascii?Q?9mShyDX92fYip3xDoPZzNbw3y2Scm81vDAT9xJPhdFI0ccNU0o+xqQ0Qa0m8?=
 =?us-ascii?Q?wvNMgdWZokThD3PhTsi85PnbvOlNUG2xcBCa0cn7torTdOY6gVrPk+clMsVq?=
 =?us-ascii?Q?v9A2+TTMbIyFT/QQP503UqKUlSlL23aoTIJ0TzCbMjmDxwzHBHr6I1ik6rkn?=
 =?us-ascii?Q?Qf2ygw/rTfyWFoTvG+3gZEilrXU83C1SrVSyIhZiGf+MpgKM2dz8Kqag3l/z?=
 =?us-ascii?Q?vECOHfPoS4GbpF+uFDIhjuUgEoBSPhcof7u7qI6nKlpWmjgxpl3fRtnPKwDc?=
 =?us-ascii?Q?+0L31eGHUMQqw1IzrtlhVE3pO2n+NiG1xoUnbP0AVpQssXS3+U6GHrTkAEXA?=
 =?us-ascii?Q?GocaNn+PZJ3rf2kQJupLSvfhc/sDtFGDGclHE2xA8pn2juzw/FbMhYZI3uWc?=
 =?us-ascii?Q?2wCLngWJg+Jlng+GOOwt9cYCWRBcCM2zKSeMAT9SpMmm1ZduQ8IhZnjP37S5?=
 =?us-ascii?Q?xJkmSY4R4C5bJTIR2kRgGLczDzQ746OuYokc8jZsi7AlaBysf6i2ja6/uCCa?=
 =?us-ascii?Q?/8fGFYe+PI+99cofaArvuW8P4+3BqSi+sMHo1uasQT+vebNpPnsjuCQmi5T0?=
 =?us-ascii?Q?KfDf5mPqWmxo1TrnaTG7PbqZQm4A47UeA2kPkBlNnZqujOThOAXOUbF/KYmJ?=
 =?us-ascii?Q?5Bzyp3WbEsH7TJlWQZ2jUF6KIEm0A4tPx8cDH39ZBqfa5ZWxbwViCbSWcJB8?=
 =?us-ascii?Q?AAOlchyw0zCDHlUbv40r3qPFPG2GPiVrtwxr51KNaaxzta5qSQv73PbsJiqz?=
 =?us-ascii?Q?o690YToDvAVAdLL2M4IPaIvAtsWFLaHFjPnAtWD4DbRCPV3rXYb6/FxlIn/4?=
 =?us-ascii?Q?D5Bf+qoVoqlTgF4nLNId/k7J318OJ33FHErPfYuHsXCHPIfaJRD5Vj4U3nP3?=
 =?us-ascii?Q?xW5rv5uenUFQT/l2PlihDOkhNPRyjC+nDaIMerWYrLCf0NAviNYzewqyiAYC?=
 =?us-ascii?Q?NJviSgmSOrdOKvKitWS/zZjNHOewqlqEobu1qNC6/1o1MmXUfLOJ0NgSOyVF?=
 =?us-ascii?Q?p+n7t3N+ygI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(376014)(366016)(1800799024); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Wsi7bD9PzY/yFtgXXn5t2Wwxd94/oUVmy0wmfwrK9T2Rv6HgnMWP19WCiXOz?=
 =?us-ascii?Q?+iGGYYIBrfwNhbaItIJs3FEhlfJCtxECbLlBpB0p8Af485wXmeFHteqkkcEA?=
 =?us-ascii?Q?GinJ7uo0UfoVFdZBFnKPmR52kNpAPEeaGPKbWcvtdwNl/pVx4KHZ6Ud1b49b?=
 =?us-ascii?Q?uyG3PMnCuo4LKSxaw6cMfBzuXJtdx/gM4+j5Y9UtkjX5DHV34+HUnIUAJz9l?=
 =?us-ascii?Q?pCsuPQa2ov63n1yZzRUq7w9paLi+JY0mtt/qNl03NDkyqPVq6FXn/30fGC+q?=
 =?us-ascii?Q?nC4zvw1Kq67WgLTXsshSCWlXulHkF5b1PhoefXwGXAP3GUfvxBfRRSVntJly?=
 =?us-ascii?Q?gxIM1C4tVg9No0c2ORj4uUOkybGki4HWk62wDucWYmy6Fx6dQUoUKrU/Z00V?=
 =?us-ascii?Q?TBPzjgLsHoRdbtiPCfucd8/vvSLWXAYRQ/6BfUif6XkirsyVjE8Zgo0ebBkb?=
 =?us-ascii?Q?G8nFpIotuHTZATxxnzSXwQSNF7sfQzY2wGtNtafFEJWLJfXvBNBjHtEuH0um?=
 =?us-ascii?Q?qxumf834y8j/JR2ecDKUKj2L5zCf7E4ww0cfeBU6N3Wlqc5zC8YXtD8u4C7l?=
 =?us-ascii?Q?1CcYB0KccnP/ZqunkoiMwUwC7+AHgQHJstnTeOVzoekdbCUCR91UuETEueSX?=
 =?us-ascii?Q?n4Q8XSGz+OdPMkAiqxnKfvEyscumYEuO6OEdogHeUcx7oYyvvvoLkU3DRW4u?=
 =?us-ascii?Q?nEtWV0b7TTlKKft8CNV8A1sq7SrfhqStPkHleIyFYqq0G7Swvs3NmRr+8vBk?=
 =?us-ascii?Q?vnIJPiQ/cyyyvWovH49km9qUp2CLdeIrjmJlYJ0wj2Y3bGH9jSjk3evSmLxO?=
 =?us-ascii?Q?QH0W6EDbV+A0ioSdw7PLvkCOcu6H9uA0a9OKrWWgF4r1++6XpgYtydQl5sKF?=
 =?us-ascii?Q?zj4/ijwU6RrY9DTSj+Z3kdkEM8sp/sdzlJMqLESljyEOkagC2gnhDvdJa2sO?=
 =?us-ascii?Q?2FRPLEXT6Xl0NoiUvLk3y6CzLL49XhRi4d1JyalHR3lvm3d+AWhT8XA+AvO9?=
 =?us-ascii?Q?x1MepLpA5ltDNLiFCGQAVG5opNzQtOCfdbO8hdxAJWPfQ+uztY2MYkSrjfOq?=
 =?us-ascii?Q?CCa2gP3wVylrFYrQM8zO4BOeLsjdtj7c6m9lHFT+kQBOOQOz6HSjvyeXxh5s?=
 =?us-ascii?Q?LdmEOMK+6YaII4l3tgU31iEEnQo8FKwLNeGkO3PwK2DZyhAWmbhYzGZOGRkS?=
 =?us-ascii?Q?3AOQOKKUX9mbFlu8+OoCbprjhsggoXEeuKvjofB1xd7t8rEsPF2mBTc+BBj4?=
 =?us-ascii?Q?+iEUigz6khYQFuNYPNO2bzFlhCHP7afMeeS+OgorN/B4TJ17EYuWtuxMLn4V?=
 =?us-ascii?Q?mmt5U+rmN/RNsp+s/qNJGe1opkn+HVxO8dPW39ITh9l19Xh+XXUf4cbSx5WE?=
 =?us-ascii?Q?rrn5Jn6tn+LrDPxdCo7KJ4MlrQ8RAzVqlQsf8twhAAz6SBls5XBXszJxpgG+?=
 =?us-ascii?Q?cViWQhFPHEFjs5LyuOho1tOR1Auy/bKQomuBM2v8hkrM8woWYSh/KtPef3nc?=
 =?us-ascii?Q?72k34KQmDC9R1ddLafwnm+ouqvKuw7RRJyRIq5SmTyPQYP4eguxwfI5wYNPX?=
 =?us-ascii?Q?pKcMSSn7nRG7jYZQueoU+YmVV5UBYfMWQeQggO3xx6S075mikITH8TJOT7xW?=
 =?us-ascii?Q?PDCAHN8FYweOPPJ4T+CcVur+4sp5NADQzHOEgiYfTdyG3hZPWYoM84ViNO18?=
 =?us-ascii?Q?Dq0xFw=3D=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01de785d-9d44-46a8-a611-08ddbb04927a
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2025 14:10:47.1798 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FTyeX8SCC3tpBc90JOL7J8vvHOQJJdTwn5fUa7UHWTJu3BZxcOb6oUtwBJAU9RPdMMxLxRC07Tnflzn6F/4mcmQKDOrvekQBfieF0+pKJPU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR02MB9087
X-Proofpoint-GUID: wGia42RkypkFc3zipYlKbZrfqxcJblrG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA0MDEwNyBTYWx0ZWRfX6fljznWgPMEQ
 0jxszWqos7Fnf0hmkmKPOQEW9g49hOBtCSO5gTYw+PFIMml8VinrdhWSmpiL1Tf1D8r1LmYLhxh
 hRGe9nuL1yFhyYYla4NuX70JmUafvnR40cx03QbThMTmR+gzWqiH7CrtIXky1jzTClW727B/zg+
 bJk63yftwfA2zTvWNnV9ejWJxg9Sxdb2HoUbdMYe4VUV/O2X27YXpau+IoMr5sgyJfUad5WJbXM
 L4h72o1vPuIDa5JYG0XTkQkf59Pz2y80qw8FKgWYwsN7KlyPVC4nf4zfZNZ5LwmKTq5bkZlWIGB
 I8+HKL6OC9Rv9G+cHKdg/p7CVEWUCO4rFMXUa5MvLGN2W6GDiTxG/eTaVqP1bMxg8/ekUYhfrXb
 ToUUnOaId/78gRiBzmsA+yiavDSuCYceqXVOlvIgJ6PuK2D2XdB5bbPd01gIA4MrPLAfEkPw
X-Proofpoint-ORIG-GUID: wGia42RkypkFc3zipYlKbZrfqxcJblrG
X-Authority-Analysis: v=2.4 cv=V7190fni c=1 sm=1 tr=0 ts=6867e0e9 cx=c_pps
 a=yr4orNQqY5sPVMLupZgypQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=Wb1JkmetP80A:10 a=0kUYKlekyDsA:10 a=64Cc0HZtAAAA:8
 a=puX-rZ3iWx3qy-NnaecA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-04_05,2025-07-04_01,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.218, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

All isapc machines must have 32-bit CPUs and so the RAM split logic can be hardcoded
accordingly.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
---
 hw/i386/pc_piix.c | 58 ++++-------------------------------------------
 1 file changed, 4 insertions(+), 54 deletions(-)

diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index a6a35405ba..838ab9e15e 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -427,69 +427,19 @@ static void pc_init_isa(MachineState *machine)
     GSIState *gsi_state;
     MemoryRegion *ram_memory;
     MemoryRegion *rom_memory = system_memory;
-    ram_addr_t lowmem;
     uint64_t hole64_size = 0;
 
     /*
-     * Calculate ram split, for memory below and above 4G.  It's a bit
-     * complicated for backward compatibility reasons ...
-     *
-     *  - Traditional split is 3.5G (lowmem = 0xe0000000).  This is the
-     *    default value for max_ram_below_4g now.
-     *
-     *  - Then, to gigabyte align the memory, we move the split to 3G
-     *    (lowmem = 0xc0000000).  But only in case we have to split in
-     *    the first place, i.e. ram_size is larger than (traditional)
-     *    lowmem.  And for new machine types (gigabyte_align = true)
-     *    only, for live migration compatibility reasons.
-     *
-     *  - Next the max-ram-below-4g option was added, which allowed to
-     *    reduce lowmem to a smaller value, to allow a larger PCI I/O
-     *    window below 4G.  qemu doesn't enforce gigabyte alignment here,
-     *    but prints a warning.
-     *
-     *  - Finally max-ram-below-4g got updated to also allow raising lowmem,
-     *    so legacy non-PAE guests can get as much memory as possible in
-     *    the 32bit address space below 4G.
-     *
-     *  - Note that Xen has its own ram setup code in xen_ram_init(),
-     *    called via xen_hvm_init_pc().
-     *
-     * Examples:
-     *    qemu -M pc-1.7 -m 4G    (old default)    -> 3584M low,  512M high
-     *    qemu -M pc -m 4G        (new default)    -> 3072M low, 1024M high
-     *    qemu -M pc,max-ram-below-4g=2G -m 4G     -> 2048M low, 2048M high
-     *    qemu -M pc,max-ram-below-4g=4G -m 3968M  -> 3968M low (=4G-128M)
+     * There is no RAM split for the isapc machine
      */
     if (xen_enabled()) {
         xen_hvm_init_pc(pcms, &ram_memory);
     } else {
         ram_memory = machine->ram;
-        if (!pcms->max_ram_below_4g) {
-            pcms->max_ram_below_4g = 0xe0000000; /* default: 3.5G */
-        }
-        lowmem = pcms->max_ram_below_4g;
-        if (machine->ram_size >= pcms->max_ram_below_4g) {
-            if (pcmc->gigabyte_align) {
-                if (lowmem > 0xc0000000) {
-                    lowmem = 0xc0000000;
-                }
-                if (lowmem & (1 * GiB - 1)) {
-                    warn_report("Large machine and max_ram_below_4g "
-                                "(%" PRIu64 ") not a multiple of 1G; "
-                                "possible bad performance.",
-                                pcms->max_ram_below_4g);
-                }
-            }
-        }
 
-        if (machine->ram_size >= lowmem) {
-            x86ms->above_4g_mem_size = machine->ram_size - lowmem;
-            x86ms->below_4g_mem_size = lowmem;
-        } else {
-            x86ms->above_4g_mem_size = 0;
-            x86ms->below_4g_mem_size = machine->ram_size;
-        }
+        pcms->max_ram_below_4g = 0xe0000000; /* default: 3.5G */
+        x86ms->above_4g_mem_size = 0;
+        x86ms->below_4g_mem_size = machine->ram_size;
     }
 
     /*
-- 
2.43.0


