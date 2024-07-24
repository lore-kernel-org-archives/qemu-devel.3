Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEACBC3DA61
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jul 2024 11:14:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWZwV-0003cj-OZ; Wed, 24 Jul 2024 07:13:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1sWZwT-0003bt-99
 for qemu-devel@nongnu.org; Wed, 24 Jul 2024 07:13:57 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1sWZwQ-0003CQ-5k
 for qemu-devel@nongnu.org; Wed, 24 Jul 2024 07:13:57 -0400
Received: from pps.filterd (m0127844.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46O0wnZG006156;
 Wed, 24 Jul 2024 04:13:47 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=proofpoint20171006; bh=b9559+5rha7lrc1
 LqH+9iQChY1jygmY27oGBqv+tHs8=; b=0P/I8x3h9p2g0QibFTb85T9sdJV/TB/
 ua/lam02Gk2Z7gwL72ATz0+fZNQqKgFrU3LTb0RX6M78fsk+5MGvzSG0aqsbnnnl
 hv8u23G7vYwg9d7FMZY8JEs1cVCqnzsXigjDqHP4CMS5prPN7raWOAx0tIYARoL3
 sn87ER0yo8jNfGHn84vy+ougWIjgnKzYX6fhmFQjEZoMs9wZF3lvf3hKSuf9fyv1
 yzrGxND2ZT7vPt6zuhtpva06BHbJ9ZWdnsIurSbgdNm9MJwhsWV21/oJ1whq4y1W
 8deW6RiKQZE2lrlWRnfUh90OqqZKgLHvs2NGKL6wefaJmlsUCgAojZw==
Received: from sj2pr03cu001.outbound.protection.outlook.com
 (mail-westusazlp17012039.outbound.protection.outlook.com [40.93.1.39])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 40j8etjy4y-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 24 Jul 2024 04:13:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OXgeInX96/HomnILKYKIHm11TdIp5ajtcbPrNr37JHp0SbKwGBi3wRh/7kKpEmFzQeWWOngljGpzGP/0AyLmNDz2Y7iY0w0vGXGoi7Wv9Bte0qaE7sqyPFluqxTlJVr08UpcldUnbvGUekxSEoqPwtWixqqApa0F8iQqAtiOnLP8wdHqDSl8yAQp+rBG4Vuo4te/s7McJz0f4YNDAC5mhMr0RzZMxdIA+WKJ9Met9Zjk0cJ2ZmlGyYi+aU9yo9dcma6FW4vYRYCzhF7/y8AX4c8O2v8xXIXAbr+FK1ADy1w6w/U50Ir6ofZMwg48jt+7N1h4eN+wJyVbMjL2SQJT9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b9559+5rha7lrc1LqH+9iQChY1jygmY27oGBqv+tHs8=;
 b=L6kIkiMQ1RQHgVmW2nklg94lqMKcoG0UdMikcbXcKGB1oy8UrMdRswkAYkFaWtw3NjMju8R5e/cuYnhIn4KR+8AOCyecgJ4hTwXcOiKnVncaEi0BTdHalCaVdjj/Ki+G3D+o/HQajdE286T/kmTJn4/YH34f+3vgQNdOyO6WK5HPmR2347Jtn471etTnUTrVufQvPILJ7qvxUS+dPrIfq3wfQkiTs4h7wNyJAnrdySjRV3L4S+W/JnVfypr4FEDlp1ILBTbGvKMrtFIsFzm9Tb5/Fd8ON7DyKS9n+BU1wf8JswByEIMUWtXYpl0wPElxv/3LRUgzY6E5Jn6TsnfDGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b9559+5rha7lrc1LqH+9iQChY1jygmY27oGBqv+tHs8=;
 b=hMsSM2lRIcqVnhoxKCdGF31gl+Agqrr2vVcdOpxiTwFPZSWFU5JjQ74RMgd0bTE9Fxw7/Go5L5N0fyZutTivHTzemJHrPMO4ndpIoMH0rVXtxZMVErAojK9IarhsrtWlASfKWmwCw1Tk0TR1AD35VQpZxOQ/XVAh3IFTbDsgmnabH8Lh+GEhixOeWGDbJgcKuScGU1j7/xZKSwWz/O+f1YrswuZ2IgE33JXate9BvGyTiZfvknyiuggqB5Z8qk/dos5YkjyxH5rni6de9u45EQiA3stXf6Mo0fTP1/QeoHeyR00XYJT4/LoeEGzOnvKkeFtbqgIAtiMmKOkcOfxDjA==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by CH2PR02MB6507.namprd02.prod.outlook.com (2603:10b6:610:67::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.16; Wed, 24 Jul
 2024 11:13:32 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51%4]) with mapi id 15.20.7784.017; Wed, 24 Jul 2024
 11:13:31 +0000
Date: Wed, 24 Jul 2024 12:13:28 +0100
From: John Levon <john.levon@nutanix.com>
To: Manish <manish.mishra@nutanix.com>
Cc: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org,
 berrange@redhat.com, zhao1.liu@intel.com, pbonzini@redhat.com,
 bob.ball@nutanix.com, prerna.saxena@nutanix.com
Subject: Re: [PATCH v1] target/i386: Always set leaf 0x1f
Message-ID: <ZqDh2NIE2ELRcwq6@lent>
References: <20240724075226.212882-1-manish.mishra@nutanix.com>
 <20240724110004.389c1a0c@imammedo.users.ipa.redhat.com>
 <21ca5c19-677b-4fac-84d4-72413577f260@nutanix.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <21ca5c19-677b-4fac-84d4-72413577f260@nutanix.com>
X-Url: http://www.movementarian.org/
X-ClientProxiedBy: AS4P251CA0016.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d3::8) To CH2PR02MB6760.namprd02.prod.outlook.com
 (2603:10b6:610:7f::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR02MB6760:EE_|CH2PR02MB6507:EE_
X-MS-Office365-Filtering-Correlation-Id: deeced87-e9f2-4834-b5a2-08dcabd1a6e0
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?4Zk5St/NmJnm9MeT0nPLbQle34rSf37u5fxl7VEgRhMOBQncbNiXw/ujn71b?=
 =?us-ascii?Q?m5cZjkttQO8JkxDNkdPncuH+25ZX6TZ+XCh7lyIA0YvCgTO2PD4Q/ihL7bO1?=
 =?us-ascii?Q?H0zfSq1Tj0y1GfWiPxofm+9XlUSp/4doWysw0Y6sxXahnuF90/UTjR/Oc9Gv?=
 =?us-ascii?Q?7z/3v5CwAX0ALdw+0sqb/E7DXdGj6BJl1DqHuCi4x6ifrkWHYjD6etzqeTto?=
 =?us-ascii?Q?tRXsMiiMU3YLAXdY5Jx+4iex+/zyGIl+oReSSkezHQlbW7uzkLxvygEzbvUj?=
 =?us-ascii?Q?Q/WAgqPXlr8alYUTImloeOb3Dmw92FWwJKITAx3KZ5ig2tYxO6Ra5NTOLZDu?=
 =?us-ascii?Q?OriH+08BhZblRHcIYI/81lxzUA6gMdGqwdchBO8OYUQu7inVUx9JK/yXKUec?=
 =?us-ascii?Q?Meom9IfkA7TAakOCC5V2jwhNOBeXOsI2NWK/cf+uH8QUA6fw2iGLm3E6tWWx?=
 =?us-ascii?Q?z086xOP+xKNY9ah1BV31Ay++1YHpAEaTvUnqtZr/B97TTkM4q7I9ss3J9n1V?=
 =?us-ascii?Q?1vDEpiPdyRSvWVK3GCCtWcKqZr6cSGf7STWrkgEGIXjIigHgLJgAlNc1BISk?=
 =?us-ascii?Q?tfiamKn5PZ6HV0+T8M6DcTfZDfsL/k5862Gm96zfkyUuf8hHOuoW29Yv6umX?=
 =?us-ascii?Q?pjQ/BTTm98gUXZ1vTWK0r86HGLSd6iX/GaJbdrWSUAWV+Fnu9mFLLp8H8trX?=
 =?us-ascii?Q?vL1rYtYOBb4LwmXPY2rkEqtC7TOUefbl21ofjwXdojUHd3m1vhAULWCLXRix?=
 =?us-ascii?Q?2fbC2azBZcl31HxLGNCbFKqL2WQ32fQppXAeX+0CIJrwzSydpDIqpuYcTgH8?=
 =?us-ascii?Q?oBwFnJypwr1Lx5NN8lyQLR+WcQBcmUAqbm2VA8QhnPjb2b03/0pSTptYgGph?=
 =?us-ascii?Q?ysGJCLY+t/iYRO5ADBbNb0oXQn6X33wZMGC/E4Vrt1Ikir/Wc3t4xgecopUJ?=
 =?us-ascii?Q?XmkZlwEuNIDs1UOh0ghXo00OUHvMuQjvokWowSsSQdEnRCtMGSu5oUxsn9+t?=
 =?us-ascii?Q?kjb9a/3pDag/seBrcVYwVnI/fQ51SimY0LUlthvJG9v6eHg3gfkT6tVCMYTm?=
 =?us-ascii?Q?YfwhwypgxZdwvASLRaDHQUpDT53TtAy9wHjG+YvcmF8tZS7DlrI9arSEp8AI?=
 =?us-ascii?Q?OwemL4FTvyqExl1nt5Dwg5JC/esXw6vnYM5BezCt/XlC2KF8ud3+MQ9RoKkd?=
 =?us-ascii?Q?+tBZG4pUOUI9JYEgxnD8eWSkpqVzN9i1bL1E39lc3AKf8lE1QlMsYg7MS4rE?=
 =?us-ascii?Q?z6Pg1kz4YkNDO8ZdZp18C03y4zyzke6iWXYkWgspc3Gz+ZuuZDadkhIg5JXW?=
 =?us-ascii?Q?emT9Xl/YMAjWQ5FJaSlv2OU6asDaLgJzy3NIw9GoGju7Eg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tTdEDB+Xxmpmvvwa6i/Z/ed1qRN2sY+FlK0+BP6hoDR1DFylRa5Gv/EE34BE?=
 =?us-ascii?Q?tgfg0NZvVr7LK7pg0p0Qjv72OUL7SvQ7S5Mf8iJ3a8jn13AuDNS4TTL4Infp?=
 =?us-ascii?Q?S1DIGL846nU1AP5IKHOwDEOtILqOFxk22UmlDy3pcai2mnqghxdvICFBwRBC?=
 =?us-ascii?Q?PkFo0sKDutXEw/GLpa6ixt6gTAQBWMLW17hhtPIkwcrlfQVsmGoR37rS8YxO?=
 =?us-ascii?Q?GgUOGuPmBFz75mY6C6qHtj5RuK5sfycotqDE84Qukw1rFbrCnLc4apailCiJ?=
 =?us-ascii?Q?erdbKYrHJ+qAvsnLvsoT3YbuCy/d5as8rCF3K5PjHT6XJHJdri66QfKEBZVZ?=
 =?us-ascii?Q?OdVqRS6Ux4ghWXjxeFnsA64vVX5iYxZJuu0mog/dvIFe6itSk/Cur+JhB7sr?=
 =?us-ascii?Q?yNcQ/2lJ7+w3+0nlsHd5DIDaeQ8YSMdqsBFAMsGrX/di+rqee2GCK4D8Dond?=
 =?us-ascii?Q?iiyhNRFL4V4lHFpbXc8bdma9VHSrnws5vzptE5Egode/wQulYrW0baYATxSy?=
 =?us-ascii?Q?0yrJyQnzYHC5b/8n3ufH9H9ThRtqeXuMul+3M+zjqQGXQphmy7hnFeUPyXoY?=
 =?us-ascii?Q?1utS3+XPYy48cFkPp2TAJDAGHDcVbFDcLcX9F3qkU7BKekO+kFhffsL4feWi?=
 =?us-ascii?Q?VxUDJIX+lYixte/kDU2G3PB84BV503vZaszvXlKHsBkNOsFG5UyK29uzJnFX?=
 =?us-ascii?Q?f8H6e2iAASHjFPtT2ATsVEXw7OyMgh3GBORZxMvc8GIoG9axi3ZB7M4DfBpP?=
 =?us-ascii?Q?u63dUNE+JLTxIYSC+qAAibykhsjllXIkZGnzmoBx7WTwSDawqnYq7Zleg49u?=
 =?us-ascii?Q?m+AaxsRLx/pgf8xvZXgYv9NFvWL81vfPFKODQZyHU+U+pVgOFEPQZl6R3kq4?=
 =?us-ascii?Q?8/rHzjA6qC2CbyNbE85Q4czbnSEga7nQn97D9wu0+O+ppkwqC1K5F6bHuv4M?=
 =?us-ascii?Q?Mqsxpqq+dT55nG68A4qR57kbWmgXfyaIrjeX7L7u39ARoEtDpBXLHt+3A4UG?=
 =?us-ascii?Q?LXcB/V+/fCn2G+Q5FcrDop1T8pXfPmGGGkWs83dfwCMq/aJlq4qjG75V68B6?=
 =?us-ascii?Q?8U3NeJm9W7WdDEfF1yKftpd9pslrszs9aQCDYTiybViTe9E+WWBseY4aU8Gz?=
 =?us-ascii?Q?ctiw8CLeNGdhu6STKXcvm6F/WX5vfBSvfwBw3e8JTVrQhd9Kl9qKzSlmlPAj?=
 =?us-ascii?Q?DaDPIGYbUxi1dpQFsslL1lF7L7dURpzABi7cOOm2N+7Xq99Xtfll3IaHpGnr?=
 =?us-ascii?Q?7ndFixHTzktST+BkXJxffWCykOE3j8FVnBM1kH8NQzSDibFSlInVfimi1Pq1?=
 =?us-ascii?Q?+aZRcC1cfyePezyxyJyjDnBrKm+o5EYw4Lt/53MdRTI42uSpvJp/vI7JzbNT?=
 =?us-ascii?Q?0FAZWdaaoGkyNy2Z4AIHUny+5jMmlaqOb9DgMlhXdgNd4T/O+xFvPQYUIM66?=
 =?us-ascii?Q?VTUApXuvU4OEFZfhz2m3siXP+XKFI7bCRl04Y7AvCnm3md+9R3/fjsx5oxfK?=
 =?us-ascii?Q?467qGEJ/qAdt0p89mStWm6+rpYljguYwSV4HOPespGGLHE/GD1FYlIJJSj3X?=
 =?us-ascii?Q?t2hXTPF+YGBsTGLzwTnVZvLpzx1t+ZOOYK9Eyv85?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: deeced87-e9f2-4834-b5a2-08dcabd1a6e0
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2024 11:13:31.7293 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NcKEzXkehN6ZptJHGAu66hklZfg7VwpTmArWd8sKC3EkSb1CR4YN11Ii4pvaN+yLOFPThByqKVSbnn5Rw56fgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR02MB6507
X-Proofpoint-GUID: FiC6KPjwRZAONp6dbr4wC4wMmBFRPXGO
X-Proofpoint-ORIG-GUID: FiC6KPjwRZAONp6dbr4wC4wMmBFRPXGO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-24_09,2024-07-23_02,2024-05-17_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=john.levon@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.136,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Wed, Jul 24, 2024 at 03:59:29PM +0530, Manish wrote:

> > > Leaf 0x1f is superset of 0xb, so it makes sense to set 0x1f equivalent
> > > to 0xb by default and workaround windows issue.>
> > > This change adds a
> > > new property 'cpuid-0x1f-enforce' to set leaf 0x1f equivalent to 0xb in
> > > case extended CPU topology is not configured and behave as before otherwise.
> > repeating question
> > why we need to use extra property instead of just adding 0x1f leaf for CPU models
> > that supposed to have it?
> 
> As i mentioned in earlier response. "Windows expects it only when we have
> set max cpuid level greater than or equal to 0x1f. I mean if it is exposed
> it should not be all zeros. SapphireRapids CPU definition raised cpuid level
> to 0x20, so we starting seeing it with SapphireRapids."
> 
> Windows does not expect 0x1f to be present for any CPU model. But if it is
> exposed to the guest, it expects non-zero values.

I think Igor is suggesting:

 - leave x86_cpu_expand_features() alone completely

 - change the 0x1f handling to always report topology i.e. never report all
   zeroes

Yes, that would mean that if something requests 0x1f leaf even though the max
leaf is lower, they'd get data back, but it's not clear why that'd be an issue?

regards
john

