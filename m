Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 888F5C3DA6D
	for <qemu-devel@archiver.kernel.org>; Thu, 15 May 2025 15:51:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFan6-0000Sg-Qa; Thu, 15 May 2025 11:46:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uFam3-0006ne-52
 for qemu-devel@nongnu.org; Thu, 15 May 2025 11:45:31 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uFalu-0006Qo-JQ
 for qemu-devel@nongnu.org; Thu, 15 May 2025 11:45:29 -0400
Received: from pps.filterd (m0127838.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54FFP29G001036;
 Thu, 15 May 2025 08:45:04 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=VftbLE4bsz7OCy4Q8sPnflGuB3T4mqCxAfz5WEOgh
 B8=; b=MD7Yw/A5MWx/u7pjMA+78RDNWu9WxuF2fnGQ4Y4yA4Zkfc640BwX4V6d+
 I3w25G1IHWjfQA46uimbAkzipLsIQKnGQ06Qskj7nCklweDnA3ZTvcL6aH/tTy+P
 owMRYdieJFoWpyc8LgCKLZKyR7GoQZ1ZlDldD+71k5zr4WpimlFa5Yt0V6/SDQRd
 fWeFihqAYPXvTPfR+ZlUwq98vsKrLUgcttk/6+xVhjPgPVevnM80qgQmD4/35c4x
 0f7htHQ54V6S7/r5nJIDl0qqjXabzzKMq6/f3Bcr9OfIeGmJHVQ7waeI3LAZmyQS
 zEI6+7dYZ1C4t4rSnl99VdJDpfA+g==
Received: from ch4pr04cu002.outbound.protection.outlook.com
 (mail-northcentralusazlp17013059.outbound.protection.outlook.com
 [40.93.20.59])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 46mbcsdhtc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 15 May 2025 08:45:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DlFJUsrOnOWFEvQXx7oiNhpheAPVImAcShc7S10Ko01seGcW8n01sOjs7B71Dg9oUfkLcWm+CY0OHM5+gZuSUN81dgNZS2+VS9OXUUbVKxKi7REafuz1Ml2xLrWehQwNGKZJjXWtdi3nxihTYFxhyQmera4W4oNNM8ipUZAfywUR8NCHYAO/OxcxmXwJuvtBSumOmJ6p2nde4PdyorLd/F6FoeSN/fIO5Wd511A7LMaE2Oa5TkFuxU8kyKCe/t51WtZj6fMAuGcXnsQiM8iCjQzdIv+YwOC05HhWIbQVXQ1YbsQ27snKqdYRuBZ5iIZ0KQ3MxwmL/I4YhHUs4LbLag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VftbLE4bsz7OCy4Q8sPnflGuB3T4mqCxAfz5WEOghB8=;
 b=UphB7IliBLed5tJJ9pVADbVx27qOTaRvOxaU89hNSx4jvgt2Dq5MZ5cQuY+VARtQA09LN4UnV9/8Al+wa8wmNbAACx3TtQB2CCapMCue5j/tp/XSXnG1Z2O98dbXJbZ8dAsiPxAe8+sZSjHqd0QUR+ODadn1qBUw5x6xEcBPGSqOnaTRZz2zUHRE0fvD73W9S+8L1ihwsDTSWVSijKpcv7sUV+tKuQAB6Tr/9/MYp0yJ4hbMu4vLldtypAUnQ1vNHC1yignK3nEYX+kSSR3/p22J8g8R7xtxFVujWjZ9A62PkpWu85KmRMKxuYXU4NIbii9Dm+fxgybkknBxMo5Z8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VftbLE4bsz7OCy4Q8sPnflGuB3T4mqCxAfz5WEOghB8=;
 b=eI82LHYyJD+n93dZWIODc8Zvx9helpI/llIVyMIja+HgfiG9qFdGegT12YnD5+t69uX73QwC1AsRssdhjH2rI/DIgTymGOB40H8F81Hy8qNEcHhE4wJgQVCOnSXYsO0sYC1TY1E4UR9Zr9eryefsDv835Tf7C8eDD37EocRvWyE19tpocPi7RjQIqN+tGFVKydKJa1HP+dUNBSLnrgPpHVy7C8Hl329QqrHrrHVzK/Trj8a0kryOhDaHLoYD7YWc79o5+/YrtyerXJCPJYtYBw8IfE5+FQg9rManTcq24IW/jvnOLxzBuKd3/JxlUm8pHtli4+ZGiM9JYRXbcqE0Zw==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by BY1PR02MB10459.namprd02.prod.outlook.com (2603:10b6:a03:5a8::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.21; Thu, 15 May
 2025 15:45:01 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51%6]) with mapi id 15.20.8722.024; Thu, 15 May 2025
 15:45:01 +0000
From: John Levon <john.levon@nutanix.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 John Levon <john.levon@nutanix.com>,
 John Johnson <john.g.johnson@oracle.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Jagannathan Raman <jag.raman@oracle.com>
Subject: [PATCH 17/27] vfio-user: set up PCI in vfio_user_pci_realize()
Date: Thu, 15 May 2025 16:44:02 +0100
Message-ID: <20250515154413.210315-18-john.levon@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250515154413.210315-1-john.levon@nutanix.com>
References: <20250515154413.210315-1-john.levon@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM8P190CA0010.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:219::15) To CH2PR02MB6760.namprd02.prod.outlook.com
 (2603:10b6:610:7f::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR02MB6760:EE_|BY1PR02MB10459:EE_
X-MS-Office365-Filtering-Correlation-Id: 723f5b10-8288-404a-63b9-08dd93c7743d
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?vXkV3oYdvXjH6Z/0xhsrl5hnFB111xAgdyMU5bdKs7JlKz4fLbpV/xeWPUyl?=
 =?us-ascii?Q?UNOrQJ9KjE/xPsqofiFdx5xzfL57KLpo4GdlLlfIBswpbUMpw4BufaXLzyWx?=
 =?us-ascii?Q?k4YMA5aIFDATDUQ5s72x71Zf4o18BD7DyV7FjPMDktRbahZVj2aMwirbqsF9?=
 =?us-ascii?Q?XrTaRyYbf/aPIrWzuAZrLcRdhIq0DqC5nxpNG4OvHMHMEqTwZFq1x9CHklly?=
 =?us-ascii?Q?1Y4V7j7enFtWVrYBcgZfFL3MpphNRkzbLBN8gPG2bGU0awGt7p7SdyfiquvT?=
 =?us-ascii?Q?Zf2u2KnYVUb18l1WFFxEJ/McdPmDbzFnUO/2PS/lesWjhpcep63LzehXANg6?=
 =?us-ascii?Q?BJrxbH5+GprI+rJPtGwiX+14jjSGyozLkptn7MKaMA0gbB2Uv4oEnPLERsus?=
 =?us-ascii?Q?LeQpdL2Q2mEGQ6P3NLLNCvLKTsScTAZcBjDNxVCZXNSxIo9Ymn4iGakCZACB?=
 =?us-ascii?Q?16p2NYYrhmI4q6pyRxVvZgBrIMeV2Mmm3Kj/U0qhqjEXoLZNN2QKGgK4wbDf?=
 =?us-ascii?Q?33yyFNtkNnA5ccBCUzUHUUY7lZuow29FRWw45nCZT1bIaKNklD0j6gyQ6dO/?=
 =?us-ascii?Q?dAjveHDu+GGs4T8hIUNLqz2B45AFtZDoGuDJub/xiYxTwFzKdJW1LkZQ+JTk?=
 =?us-ascii?Q?OKcMLgAwHg1Fv/z45FmHwis/jed3JhZNgLnVnrN4oNxZC/of/VVDQinVXx97?=
 =?us-ascii?Q?uyPeiZ74EUFyIJZyoFRojDaUtv1H8y9gbatjLLNoVigEagI+oaOLwlv5GYqu?=
 =?us-ascii?Q?cl9twYfJicJ1S5B//PZrrBv9hg8bMT0MzsSsTqz4ivKQ/wO69Jb/VfqaxFe9?=
 =?us-ascii?Q?8twRG0LEzqwenM4IC8lOXpy0T/2R40tT/hNlk0BIrZvHOBoHhmWgOHMRBUjN?=
 =?us-ascii?Q?AUlYxuOKmLhdaSHb/nQzrR3BrlzuK9mj7wVHJHv7QnkkZzuFpg6uSGsIzpF+?=
 =?us-ascii?Q?T5XMHjm3ha91wC08Sgqnfc3MzR5eOYM+PxzYfCFB5FANejsccWn4V+m4jz9w?=
 =?us-ascii?Q?p6BBQCrwvP3YOxiOBiNe8ZkUnPzWVyAbnDct20Yj4V1HgJplAiAKjT8a4ycp?=
 =?us-ascii?Q?OHyCKPK04hoe71B4Kp89AINc/Ppn8LeI2AKUI/tskZleswS04tl0CIynfWCT?=
 =?us-ascii?Q?O8eC1DT12LXH1xeObovBVq3jtU7Lc8QmOo7kLf+6mZF4noej+tKw9+wK9lsk?=
 =?us-ascii?Q?cmUfcdXAHlvzULi1J6Bp5PfeCaFTU2psiQl1h+G1ZfkBFid07gSkdlSkqVuf?=
 =?us-ascii?Q?ardSd1kUVM6AHSr78yymAGfdDxNsQRTvXA3oKZ+PbITH4vFrxY9i8YcX9agR?=
 =?us-ascii?Q?ZlUB8rjgVYo/XhNLICnxR9ozoTNvvhg9QnPX6iqziU/4alqU4q9TNasAkvmG?=
 =?us-ascii?Q?708V36lg+s1fd5bhrk+icy28PlBrX4VcuD+x+hRy58BXTXROVqheP7RdwGKF?=
 =?us-ascii?Q?SYyGZwxGpFI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7416014); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?B4w5EjTVAZ77Q63qtiDXvwCMEafAEM2RcBvbQHtm/QUA2L+BOqtxUyjAcVio?=
 =?us-ascii?Q?KtM0eURRbVLNnlX1IvXz7N1lTpl0e5ZFGdalHhtQo35dHmPxSkHeL61Zi20p?=
 =?us-ascii?Q?U9lBDe+aguVZ+idXF+4lp6fzIb29IVNo9WkBi0XfDGUj8DF53fcmkTyMeuru?=
 =?us-ascii?Q?bucP1WoU7n9lxVk8aKCqRHLxCWQTZ5qXUNBfLT6h0E+wc6rhjgmU7tkL5VmM?=
 =?us-ascii?Q?tZAOV410r8fNHfVS8+K09AJnWOJMPeZAzNM4kYDhaaEJyV9yf3XZp/w4yKy1?=
 =?us-ascii?Q?1JvP6Ujny9AFM+qwgwUjo//sgiglMl927sZ4ot2dDXAETkXJkdCyrBe+Wp6u?=
 =?us-ascii?Q?KDwzTbNzoZQUwPmhTQrAHPWnvsSo5z8uQTywBF8NGLpR5rPCEeNpj4ePn89y?=
 =?us-ascii?Q?6suUOSIBRi2OVaT/RfQKivC1EkeqxqdY+oPnJqKZgw6qyVx07AIuhlFkHdNM?=
 =?us-ascii?Q?fVKES1+jND9wOIQ0L04Tv82rbVtSIijkaRTs3Bp1Fu01zkWAPvaHTq9P84M3?=
 =?us-ascii?Q?Tl6JGv5FJNpM0bj25YsSXD1pJ9JZvpbAZJNeFjvDVz//5XZVzcCmHOb7hbYi?=
 =?us-ascii?Q?yXPrTQKgoMznpp2vG4jcY7bypuu4Yy1DDxoaB/Opmz1dALblgXEXEpVueTYo?=
 =?us-ascii?Q?490SR8QRJMmzZ+5y8M+6OS1hxtWblmxjKxc8Fz96HnUMxEGLhh0WOzKnx57/?=
 =?us-ascii?Q?Hi35sfjLaRmKWf4xw82+bCdUnEm/EtoS93pT8ztkxYnSRWLyFhbDETF2kXfc?=
 =?us-ascii?Q?eRcI7oeXft37S/OIQDNZ3bK4/peJK80JHgO3GGRqeGSYuzdJWpXR/pM6IzF8?=
 =?us-ascii?Q?ReFvF5cfikkpaPLaW/IxojFZatpVUVjTSqum91KNIZ6hcnoBu58tNwWG5wGA?=
 =?us-ascii?Q?3DuuUEpwDyIlnc3kO/VEGyLTgXqH1TsFRHeEBVkjGp6y8VSftMOLS12JcHCw?=
 =?us-ascii?Q?q19PYW7tMH6VjjJX3pr3DD61mBmgbCHOrjDHmDw1YtyLyiTAU/NpRDoVmbG9?=
 =?us-ascii?Q?MH1Vn5v/NJxnyIPC0c052Wa4NMR3K4FRB4PbQ4rDNrfbgDzA8lqNtQesWRz5?=
 =?us-ascii?Q?T3sqv6/cmg17cRyQtcWfCAeox7Nv9SVnuOeBKP0RemwlnUATUA/3Kfl03UkR?=
 =?us-ascii?Q?kJUmQyQ6s4x8sbBYU7tfz+jUlA6NFxp0nQ8vIP0Skdg5D0rCfeyyuj3VvqSZ?=
 =?us-ascii?Q?2cm4QundtsB0eeOLqcbNoUe7QaDNs494nwl3dci3wyNa5viYVMDn5ZJCUcyd?=
 =?us-ascii?Q?LXzT8Gb/rqlbLwQQ86FnvunKExrZErzAHlf9VSOBme1inCjJUTPkViP91kPg?=
 =?us-ascii?Q?wjp9WfrauddD2UsMYmBpYMLhWdrG58kiKfaRRK2n8NV5fwYcADi0OnuZwrlJ?=
 =?us-ascii?Q?OkXB6l0iWU5hSjdK1IumFmrwFL0XIwparua+AIgM6NwH70ganYEyGmP7NIJw?=
 =?us-ascii?Q?IP+Y3hjjWXFWVFND8gpbH79mRcV0TsCE+ZUXI4DxJLHNjH6uqkZPx48pD12P?=
 =?us-ascii?Q?XijidUCRxxlOcEVBIdm89q6FxnLdCiTmB2RZlXRF/H5SblGAmddKXeUKiqZv?=
 =?us-ascii?Q?efkJlNefcirvxMg1To8KBZDRpe+YxHO8R+z03Ckq?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 723f5b10-8288-404a-63b9-08dd93c7743d
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2025 15:45:01.6194 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OQEU1gJb0HZ5aBnxl5FpN/clL5fQeOc1P8NRfBY8LNVZn92S8Y9rRzG5I7HxNK/mOShIlsm0u0NE3MuUDIGPMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR02MB10459
X-Proofpoint-GUID: Th9HaLYxZtmTUNTRx7y25l_ZBwPCGO6F
X-Proofpoint-ORIG-GUID: Th9HaLYxZtmTUNTRx7y25l_ZBwPCGO6F
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE1MDE1NiBTYWx0ZWRfX1WkmGtTyt0/3
 GYY7KU905qHJ65hEcZD4hwSoAn5+e0D9ZUXmRzyqF30g17ThZysB+0mj0tbAeNWLPwudyHlXb4z
 mPHt7Q48sKx86YrI9TsCA5u+TlYsUtwDTxN9aRW/55c0mEKWKedUJq/lXkjPIsoazYLLm+H73//
 ZBJ2gXs/kg1lOohxq6VVcw87qjfu23X+erRayMujb5LVuq57zHMXaZJOR5EvaI3LoylSyJhdFt9
 2sJ6vkJ5dG2rQZd98drio6yCH74pvIQFO6QQAppV+jrzI3Yz8pzb2W/R6e/LAlCyfVN5TOKUnYL
 c5Sl1iQim4U6yAbiJV42Zar6nik7gOBuJEeywc1Ud/tgMt7DaQh3hcwGkahTShMh75+QtXY5ZFX
 54MiCYXLHKzOLKcXvn6N3ET8qJp9lY0/o1gsrn4SnvFF1lpgLwX+RA3w1PtNlHpYlbXD2+VD
X-Authority-Analysis: v=2.4 cv=EKMG00ZC c=1 sm=1 tr=0 ts=68260c00 cx=c_pps
 a=rrMtUIbNwx6LnGB7sifIYw==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=dt9VzEwgFbYA:10
 a=0kUYKlekyDsA:10 a=yPCof4ZbAAAA:8 a=64Cc0HZtAAAA:8 a=y95Tuok1ttcdGOPXAz0A:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-15_06,2025-05-15_01,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=john.levon@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.686,
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

Re-use PCI setup functions from hw/vfio/pci.c to realize the vfio-user
PCI device.

Originally-by: John Johnson <john.g.johnson@oracle.com>
Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
Signed-off-by: John Levon <john.levon@nutanix.com>
---
 hw/vfio/pci.h      |  8 ++++++++
 hw/vfio-user/pci.c | 28 ++++++++++++++++++++++++++++
 hw/vfio/pci.c      | 16 ++++++++--------
 3 files changed, 44 insertions(+), 8 deletions(-)

diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
index c5fc4aa500..f6524cffb5 100644
--- a/hw/vfio/pci.h
+++ b/hw/vfio/pci.h
@@ -220,6 +220,14 @@ Object *vfio_pci_get_object(VFIODevice *vbasedev);
 int vfio_pci_save_config(VFIODevice *vbasedev, QEMUFile *f, Error **errp);
 int vfio_pci_load_config(VFIODevice *vbasedev, QEMUFile *f);
 void vfio_pci_put_device(VFIOPCIDevice *vdev);
+bool vfio_populate_device(VFIOPCIDevice *vdev, Error **errp);
+void vfio_teardown_msi(VFIOPCIDevice *vdev);
+void vfio_bars_exit(VFIOPCIDevice *vdev);
+bool vfio_add_capabilities(VFIOPCIDevice *vdev, Error **errp);
+void vfio_register_err_notifier(VFIOPCIDevice *vdev);
+void vfio_register_req_notifier(VFIOPCIDevice *vdev);
+bool vfio_pci_config_setup(VFIOPCIDevice *vdev, Error **errp);
+bool vfio_interrupt_setup(VFIOPCIDevice *vdev, Error **errp);
 
 uint64_t vfio_vga_read(void *opaque, hwaddr addr, unsigned size);
 void vfio_vga_write(void *opaque, hwaddr addr, uint64_t data, unsigned size);
diff --git a/hw/vfio-user/pci.c b/hw/vfio-user/pci.c
index 81fc91037d..08edb611ff 100644
--- a/hw/vfio-user/pci.c
+++ b/hw/vfio-user/pci.c
@@ -115,8 +115,36 @@ static void vfio_user_pci_realize(PCIDevice *pdev, Error **errp)
         goto error;
     }
 
+    if (!vfio_populate_device(vdev, errp)) {
+        goto error;
+    }
+
+    if (!vfio_pci_config_setup(vdev, errp)) {
+        goto error;
+    }
+
+    /*
+     * vfio_pci_config_setup will have registered the device's BARs
+     * and setup any MSIX BARs, so errors after it succeeds must
+     * use out_teardown
+     */
+
+    if (!vfio_add_capabilities(vdev, errp)) {
+        goto out_teardown;
+    }
+
+    if (!vfio_interrupt_setup(vdev, errp)) {
+        goto out_teardown;
+    }
+
+    vfio_register_err_notifier(vdev);
+    vfio_register_req_notifier(vdev);
+
     return;
 
+out_teardown:
+    vfio_teardown_msi(vdev);
+    vfio_bars_exit(vdev);
 error:
     error_prepend(errp, VFIO_MSG_PREFIX, vdev->vbasedev.name);
 }
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index ef4095b3ad..fce41cbf1a 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -1770,7 +1770,7 @@ static bool vfio_msix_setup(VFIOPCIDevice *vdev, int pos, Error **errp)
     return true;
 }
 
-static void vfio_teardown_msi(VFIOPCIDevice *vdev)
+void vfio_teardown_msi(VFIOPCIDevice *vdev)
 {
     msi_uninit(&vdev->pdev);
 
@@ -1869,7 +1869,7 @@ static void vfio_bars_register(VFIOPCIDevice *vdev)
     }
 }
 
-static void vfio_bars_exit(VFIOPCIDevice *vdev)
+void vfio_bars_exit(VFIOPCIDevice *vdev)
 {
     int i;
 
@@ -2460,7 +2460,7 @@ static void vfio_add_ext_cap(VFIOPCIDevice *vdev)
     g_free(config);
 }
 
-static bool vfio_add_capabilities(VFIOPCIDevice *vdev, Error **errp)
+bool vfio_add_capabilities(VFIOPCIDevice *vdev, Error **errp)
 {
     PCIDevice *pdev = &vdev->pdev;
 
@@ -2807,7 +2807,7 @@ bool vfio_populate_vga(VFIOPCIDevice *vdev, Error **errp)
     return true;
 }
 
-static bool vfio_populate_device(VFIOPCIDevice *vdev, Error **errp)
+bool vfio_populate_device(VFIOPCIDevice *vdev, Error **errp)
 {
     VFIODevice *vbasedev = &vdev->vbasedev;
     struct vfio_region_info *reg_info = NULL;
@@ -2943,7 +2943,7 @@ static void vfio_err_notifier_handler(void *opaque)
  * and continue after disabling error recovery support for the
  * device.
  */
-static void vfio_register_err_notifier(VFIOPCIDevice *vdev)
+void vfio_register_err_notifier(VFIOPCIDevice *vdev)
 {
     Error *err = NULL;
     int32_t fd;
@@ -3002,7 +3002,7 @@ static void vfio_req_notifier_handler(void *opaque)
     }
 }
 
-static void vfio_register_req_notifier(VFIOPCIDevice *vdev)
+void vfio_register_req_notifier(VFIOPCIDevice *vdev)
 {
     struct vfio_irq_info irq_info;
     Error *err = NULL;
@@ -3056,7 +3056,7 @@ static void vfio_unregister_req_notifier(VFIOPCIDevice *vdev)
     vdev->req_enabled = false;
 }
 
-static bool vfio_pci_config_setup(VFIOPCIDevice *vdev, Error **errp)
+bool vfio_pci_config_setup(VFIOPCIDevice *vdev, Error **errp)
 {
     PCIDevice *pdev = &vdev->pdev;
     VFIODevice *vbasedev = &vdev->vbasedev;
@@ -3162,7 +3162,7 @@ static bool vfio_pci_config_setup(VFIOPCIDevice *vdev, Error **errp)
     return true;
 }
 
-static bool vfio_interrupt_setup(VFIOPCIDevice *vdev, Error **errp)
+bool vfio_interrupt_setup(VFIOPCIDevice *vdev, Error **errp)
 {
     PCIDevice *pdev = &vdev->pdev;
 
-- 
2.43.0


