Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3C7BC3ABC0
	for <qemu-devel@archiver.kernel.org>; Wed,  7 May 2025 15:22:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCgaC-0004kV-8r; Wed, 07 May 2025 11:21:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uCga9-0004i9-8b; Wed, 07 May 2025 11:21:13 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uCga7-0005sO-3f; Wed, 07 May 2025 11:21:12 -0400
Received: from pps.filterd (m0127844.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 547C9sYC012900;
 Wed, 7 May 2025 08:20:57 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=ZlcmJJmwMej0G3K/H369wdbiuR6o4yHiPZ+2WlUlH
 VY=; b=Xz+c2rscG2byxLxG5gNsHve51VABEDNUHoGmJwCrPRzGSq3FG7FWPqNQ+
 0bjJm808yjmdWp9Y99Z98aABvnPlgh6bBb5it+OuOEMHzfekMTpy8/kvwOJhJbON
 CEq3rZTkhOkPaDJHZbseV7jS4BBtekQv01utys/TJzQfu+uAuJ4Qo3CFVWWwr2DS
 VRX9S45iuoUjy1vFYJKH+ViwhNCAjNl+uEtP4vZEtqbK7HpQ/sye1sDNpDTh2EkA
 lmkfiTT8Ff+hK+ktvs3rrs1PDrI1h7XgjBjhhSuiJuM99q9wJTC6RepT7cw3qR48
 0zckscwOMxx3kH7UTFmCxHkaswkmw==
Received: from sn4pr2101cu001.outbound.protection.outlook.com
 (mail-southcentralusazlp17012010.outbound.protection.outlook.com
 [40.93.14.10])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 46djp118vw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 07 May 2025 08:20:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gyATRB7fe9h0dZnlR/A/B9+FFOLo+HkTKmLRvNG3jfXjXeLnmidKFe0gDEVlOoSh8i1CGwmiTGhNEas8lRHX1NqKtBeDOBl45swEaBl0RyJ5GFqOK63gMJ3hqFV8fM1SWzdxhU8V1qr2Dr4Gx/Nd/FroiDYN8BhOaGpbcJunde2+a4tSv8xP4FjWLokMfTM09OQd/16cmCHK28EA/R9KUHpQwV+xweOxyuUvqShGMkPArKsgXRmNA3/yFdPxSeWnkMKjxsP/RHEjNrwxi1Up1PDkc6RF/HNwd8homs0aHbwageVrslu7zTZhA53pzsir5AV4Yr3C4eLBDTbpWq2czQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZlcmJJmwMej0G3K/H369wdbiuR6o4yHiPZ+2WlUlHVY=;
 b=rBuIQtxCtWonmfFMNEWQ5GG02l/vUJCOtcoROp5pZpD75EYNAUp7gLSTWjXco++2eGOA0ex1zzlGdCcc32AeXqsv8SFMGnvDzl+sqdpjH3+kIEPeRH+5maFsMeDf+yUjkLXOeKu/enoXWD4cbrkNcY89svgjpcdNZR7bgPQ7G5P72ABudellks1hhzWTeSDc+1SBD7cpsEDDNFX+QLsfb0cEV8p47OpsGjyWN49rhJo55PAtcTm3YN1uym7VBI5azCtLF5o6Teg9q+UQ7KiYHiSzMqU5lKjCo9B2qrDww6kr5En8tMTF9OdmFQzHVcc6dpNKX3uu9x3rNrlk8GPYTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZlcmJJmwMej0G3K/H369wdbiuR6o4yHiPZ+2WlUlHVY=;
 b=Ftm7hsKWrRTSzVKyCMUWQNHkPgyUGjHnc61Vo/yXI6ygoHzB0OQ5oiyoSLdRy2J5xXH8LbwcoFF7B4bJ2a+fsZCGVsahL881Ct8MypyHkhiEdeGYfA00Ic05HvONkNy+l1NeBa3L62ah8vKbOuzldIerakyQJw4tx+p5jhhWJzfnzZeEC1P4YQpAkIEE+S6ivsmpki4tZ1uUG2hJAqKQx9b7ZiyeUDrskwOiL1W+tDPqw/SEh0rGPrc0zf8n1qwGO/zoeu/8+APL1pcr8DdxWWafr6aqwa+jNCWZxDHHF6gfssT7bYkpuys286+fuAUlJF7kPqY7/65HlYcDRVO4Yw==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by BL3PR02MB8220.namprd02.prod.outlook.com (2603:10b6:208:342::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.17; Wed, 7 May
 2025 15:20:50 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51%5]) with mapi id 15.20.8722.011; Wed, 7 May 2025
 15:20:50 +0000
From: John Levon <john.levon@nutanix.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Halil Pasic <pasic@linux.ibm.com>, Tomita Moeko <tomitamoeko@gmail.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>, Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Tony Krowiak <akrowiak@linux.ibm.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Eric Farman <farman@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>, qemu-s390x@nongnu.org,
 Jason Herne <jjherne@linux.ibm.com>, John Levon <john.levon@nutanix.com>
Subject: [PATCH v3 08/15] vfio: add unmap_all flag to DMA unmap callback
Date: Wed,  7 May 2025 16:20:13 +0100
Message-ID: <20250507152020.1254632-9-john.levon@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250507152020.1254632-1-john.levon@nutanix.com>
References: <20250507152020.1254632-1-john.levon@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P189CA0055.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:659::22) To CH2PR02MB6760.namprd02.prod.outlook.com
 (2603:10b6:610:7f::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR02MB6760:EE_|BL3PR02MB8220:EE_
X-MS-Office365-Filtering-Correlation-Id: 889dfb6b-7884-4f66-68af-08dd8d7abfdb
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7416014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?2/hy0POi/HdTwoH3Hjy07iAINNwiulBr1AFwHtieU+w71o0iaJtmgdl2TLxn?=
 =?us-ascii?Q?GDZqx+8dA/Z3osh7fxXfgSPayx9ESlOYmcCNvKdh0h/84yS6nEpkhWrCeX2U?=
 =?us-ascii?Q?z6QYEs4Ue2sA7uyh4GkQpDlLFPcmeCNmFTP7nDWjP+6S1VVc6mVcSovnpW4Q?=
 =?us-ascii?Q?rG8EjtW4pOaqsMCCvLqn5zSJ+GaTbzzmZJHx7cA/fFoLldZ9nqBHJUDBltb+?=
 =?us-ascii?Q?9n8j2fzgjJp2G6TLD4Md4av5JewzetdunR9S6ack0aeWWrS5wfLj/0FaS8RP?=
 =?us-ascii?Q?oVlW79V8eJm+jrksNsBXiHiMhrDbRFM9/H7KNzF4hCiClkHAcBkIAIv25xl3?=
 =?us-ascii?Q?vqk8ZFR53EhHkpy472nt6C598UFB4RJA3svQrDoPZPDN93KXkseLIoSkSj81?=
 =?us-ascii?Q?hV8Hdk7CllTqbbz9kQPCcYPx7ieZkZqwJKgJgg4f6PjfLq3fSwfRY2q/WOxP?=
 =?us-ascii?Q?UjNVPw4BqPCKBtrNYtDDwRT1g/vCj6DInEWCf+ycjHzo5dveJ1uG4e+N/6ks?=
 =?us-ascii?Q?x6uN/FBgoCc2F3Jd+ucG6W6lB0lFuC1ieWU6j6zEcN4BAUznyHoWhyI4vLME?=
 =?us-ascii?Q?AKO/8UQptS0BAGZUMbIvX8PkQj+ETjY7+NpeWHSNZT+KTtiems0ElwX2HT3O?=
 =?us-ascii?Q?BPkqHq4gJ9x3/M4GWAt+RI/KeTCS0iCoHRd5/Lh/3VNZUzUq6Tkklhc8Z5s8?=
 =?us-ascii?Q?qsBbJPyjuhhyaYiXvQKwYl23jg7s6iaBUAPdFLt09sbGOAxlRhkF8JZNK1c4?=
 =?us-ascii?Q?1zrjkjNHDQ7RSRu6dicFx43NANo7fNmXjObPIdbXm4vGQfU4XheytjRsulo9?=
 =?us-ascii?Q?Zr/RQ8iaIIdLWfzQx7MbLZKRq4Q2rfdcDlCzDCokw4rs/N7cklxIDZJLPo59?=
 =?us-ascii?Q?QzZBQbHUMdAX1+rONJjC01CZrzxiuwyjKGV7E8caKmDoVFDAqsFEMOxZNp4n?=
 =?us-ascii?Q?CYVsmopKzxXbMajGjeWAovgoH3azjjs4VbFPrzVfPl2s4S2Ioqu+6tpVMzsN?=
 =?us-ascii?Q?QaojR4qD6DTo4b+hSfRORda1Q17ndsajFpT+ANSHgcO6dOz2Oz2HOqYBlTcN?=
 =?us-ascii?Q?yaov/DQCDMnYHf1JcHF7TTn7Ml+R+YXSk9J/8iRSb9U1CIDI6VUEt3Wf9FlT?=
 =?us-ascii?Q?Wg/qus2lo2KKoUfolkScUuCNwuJ4ljcghX8u959abVGnJtIKF3gQUg1UTnUy?=
 =?us-ascii?Q?3CI4BlyHNOuX/BMVRoktjOjkP1am20zeW6hOW5VQabScBGsYCH19sj86KDFt?=
 =?us-ascii?Q?cLBvCBuQqaMRwPY6+7uYEE5Lu4xwjqxlw9yxBL4GH5OAQ0CgT2Ksn7AUESJd?=
 =?us-ascii?Q?EnLKyOpnbRUwX7gasNNpppVWPNUvli9MN5AWMG8q8bNELJ7c0FGedH32sgnU?=
 =?us-ascii?Q?z3QF9AvRqz9L1y8CZE605mW+XQ7dS1MUL2d5TDBn+B2sOvEKTpBTfV/kY7Fd?=
 =?us-ascii?Q?boZF4V5dbrs=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7416014); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+4QyVRg/twf2IimpAm3vLIw8wOHtM3Vpcv08eSoeYosP24zFHB1pMUaSK3Y7?=
 =?us-ascii?Q?huZPHgdBHuIxeG7Z1O5gCKK+WLkMBLrIia8Ie6CZ/dHdOFS/kkLBVVlCGCFJ?=
 =?us-ascii?Q?qXXnK6kmoTge0bLNTBV5Os9jW0rE02+KChA6PyHuJqiKWoXeZvztA80PehK6?=
 =?us-ascii?Q?4r+izggrs9ssJSmAzX/Cx/jg0hQuQ3YXMtufHCOrykihys/yBOUO+0KZ+E8W?=
 =?us-ascii?Q?hTphuIrC4KsGWebQ7ccu29x6pFaEsVq+U04H35OtN5MjxqKONR5mjrQ/cIs0?=
 =?us-ascii?Q?6zccMR0g+wKqsYSpwp1Mt8/ZOxvfpibFARh7yD+rVDRxtp2OYPm6uZrQwMRN?=
 =?us-ascii?Q?bu0M9KJUcnLRA6yb8o2fjgU2+1QgFWH2MIDXL4IDIvTsDosl/btX0uMAWd+Z?=
 =?us-ascii?Q?wx0F+w/HWLF9QXshS0MN18J+MCU9aSMxpwE3JfVIKafU9u/V18MjM2mMP0ge?=
 =?us-ascii?Q?gmk3GMpkcxRIWghnJxX7LUmYWJHThcCvZLqi6CTaBFkXnwXyV5np931aj8tj?=
 =?us-ascii?Q?PquNZrsJ6ZHvBDn5rlOsi6K2qDo7M8OnzKE5FyATadFpnwMT3kZfvlsMZsLA?=
 =?us-ascii?Q?2sJGUO+35h3Fq0olRtMI+xAr85Bir6lFHJ3DXbSJj6GVRhL91zmtIath4Haa?=
 =?us-ascii?Q?UevVcUbK6+EwEy9dKJcaD6FpJLJatmhRNvqtHpD//I/qpuYajp6JNqkYPbTZ?=
 =?us-ascii?Q?ToxYN7rYVswmrybcrNN4px8alKgJlWySTPoMlDPY0Qi0qpByJ3XORZzg99bR?=
 =?us-ascii?Q?+F7dZKvnL9fAigLcFBnkTSER/1Ro/OYrk0i4Xn70y0iS2vOJrBVnd0zp6QX+?=
 =?us-ascii?Q?nWeRapDbn/XK1xaAHn29ppSviJVZLaziC/3yq0bC5rCEP7MkJBJrG6xhyefU?=
 =?us-ascii?Q?dEAQHDOpNVQXimkbjzNRtMk19Z2xkz9ynkEmCzC8bYDbeKjpjq0hmh/wJGV1?=
 =?us-ascii?Q?GnojMkgu9UP4JjxuIAYA1BD8pvOyewbbNdbqZbbdPiATQl/PpaW8zPk1XHBB?=
 =?us-ascii?Q?/YS60SaLZShJPTOp3EzwxU5Iy0DMZsD7h96GUmvSyiu6hxFLFadVYNnxpCY9?=
 =?us-ascii?Q?nIcPgnJBRqEM252tJG0b2VUO4UGToS6YH0GXxxuzIT+EGb74XbUxuP8moOzV?=
 =?us-ascii?Q?GMYuyqgsHRFpk4idOXu4ibffIfwaJ+4EaKzf2jrESomXZ8J6iaJt8d91eQcj?=
 =?us-ascii?Q?p97IhL6bHhlb0VmWq42WIZYW5CoJbYR6G76gSRbKYAFkBtCrOT7NWlEyjg1X?=
 =?us-ascii?Q?IKvxpUS3ISwdEz3uXWfyW7WEkaGswzNX/3tt2T3JO6tnfhM4CehwLETWnvfv?=
 =?us-ascii?Q?KorWDpCJZR2IRGR3JyFpfAMd3zNBcPqGuEFmzgmCkJ5bYD/T7ja/CrgZC6eQ?=
 =?us-ascii?Q?5R+T5ieNIYGhL5x3Iz6JQXSGOtkKEW0dI44yLjDVXIWg7eq7ghGFOV71kjIa?=
 =?us-ascii?Q?RwZV8ZhUYZceDLyvdwvrQMCReNEusu/WckuumwV+3EciOm9aW/3LB6AHg2QI?=
 =?us-ascii?Q?kpTEDYJ6eF6ccySh4wEiYt12lt8I0IgPESMKHCrPnMLbO3LmvLMxkDsax79U?=
 =?us-ascii?Q?XGl1qYd9nSO0QNYdt9YvUEgLU9IQ7Wmyshks870E?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 889dfb6b-7884-4f66-68af-08dd8d7abfdb
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2025 15:20:50.2152 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yOCfdP33//K7z5RwDGSeFLFJcqRXV95ImI2h2p1cbDFRkq9mcGltkDxx6nh5FvVXdcRKIlaoJMO4f9Ev+NRAkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR02MB8220
X-Proofpoint-ORIG-GUID: ikpC5QxOHBekpFLKOhoeuE-PwoK4kugb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA3MDE0NCBTYWx0ZWRfX28q+wypgFg1p
 0wJcMglVzgSp/skMD0Ec6IhjL0LSbZmR5j49+HN+eXDKmuuql5NliSo1xzm1aMte7tCcvInmmXa
 StQNL8nIEmDcm0qnI3lYagyyRbLYMEWCEUKcRUhxraF7tpFajTsUYffPc/0qIDvuCN1ULkCYahp
 OcQXTz/jVK+vmW+synKpD/Eq8+67Y3XwcU4GO47O4vJh8hu2b+1etSZNRblxRE3ysMQ0IUBxcSC
 DUivEhrnrYvawygyxyur3CxkB9w6vb985oZOyLZnoYygOLShFy0yuSbWu7Z1B8HLQ6Uz+1sbTum
 FMzw7chnGftezb9sLmtSQHq0qGRbCwHiU+6tqII9a97qaf6kZqpqHd/QQhK1c+LJD3UOv58E/Uj
 P6DbsCzvp/tr7X++Hle2cFhPEsysgUHs29GT1UMYRby3lJnugIYntBdedEGJ6YLqAdMBh/Yv
X-Proofpoint-GUID: ikpC5QxOHBekpFLKOhoeuE-PwoK4kugb
X-Authority-Analysis: v=2.4 cv=J5yq7BnS c=1 sm=1 tr=0 ts=681b7a58 cx=c_pps
 a=5L1ZokDb34JZJib1CqSWiA==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=dt9VzEwgFbYA:10
 a=0kUYKlekyDsA:10 a=64Cc0HZtAAAA:8 a=wde--jvB7j7_KyCsUAYA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-07_05,2025-05-06_01,2025-02-21_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=john.levon@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.414,
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

We'll use this parameter shortly; this just adds the plumbing.

Signed-off-by: John Levon <john.levon@nutanix.com>
---
 include/hw/vfio/vfio-container-base.h | 15 +++++++++++++--
 hw/vfio/container-base.c              |  4 ++--
 hw/vfio/container.c                   |  8 ++++++--
 hw/vfio/iommufd.c                     |  6 +++++-
 hw/vfio/listener.c                    |  8 ++++----
 5 files changed, 30 insertions(+), 11 deletions(-)

diff --git a/include/hw/vfio/vfio-container-base.h b/include/hw/vfio/vfio-container-base.h
index 5527e02722..59f07d26e8 100644
--- a/include/hw/vfio/vfio-container-base.h
+++ b/include/hw/vfio/vfio-container-base.h
@@ -81,7 +81,7 @@ int vfio_container_dma_map(VFIOContainerBase *bcontainer,
                            void *vaddr, bool readonly);
 int vfio_container_dma_unmap(VFIOContainerBase *bcontainer,
                              hwaddr iova, ram_addr_t size,
-                             IOMMUTLBEntry *iotlb);
+                             IOMMUTLBEntry *iotlb, bool unmap_all);
 bool vfio_container_add_section_window(VFIOContainerBase *bcontainer,
                                        MemoryRegionSection *section,
                                        Error **errp);
@@ -120,9 +120,20 @@ struct VFIOIOMMUClass {
     int (*dma_map)(const VFIOContainerBase *bcontainer,
                    hwaddr iova, ram_addr_t size,
                    void *vaddr, bool readonly);
+    /**
+     * @dma_unmap
+     *
+     * Unmap an address range from the container.
+     *
+     * @bcontainer: #VFIOContainerBase to use for unmap
+     * @iova: start address to unmap
+     * @size: size of the range to unmap
+     * @iotlb: The IOMMU TLB mapping entry (or NULL)
+     * @unmap_all: if set, unmap the entire address space
+     */
     int (*dma_unmap)(const VFIOContainerBase *bcontainer,
                      hwaddr iova, ram_addr_t size,
-                     IOMMUTLBEntry *iotlb);
+                     IOMMUTLBEntry *iotlb, bool unmap_all);
     bool (*attach_device)(const char *name, VFIODevice *vbasedev,
                           AddressSpace *as, Error **errp);
     void (*detach_device)(VFIODevice *vbasedev);
diff --git a/hw/vfio/container-base.c b/hw/vfio/container-base.c
index 09340fd97a..3ff473a45c 100644
--- a/hw/vfio/container-base.c
+++ b/hw/vfio/container-base.c
@@ -85,12 +85,12 @@ int vfio_container_dma_map(VFIOContainerBase *bcontainer,
 
 int vfio_container_dma_unmap(VFIOContainerBase *bcontainer,
                              hwaddr iova, ram_addr_t size,
-                             IOMMUTLBEntry *iotlb)
+                             IOMMUTLBEntry *iotlb, bool unmap_all)
 {
     VFIOIOMMUClass *vioc = VFIO_IOMMU_GET_CLASS(bcontainer);
 
     g_assert(vioc->dma_unmap);
-    return vioc->dma_unmap(bcontainer, iova, size, iotlb);
+    return vioc->dma_unmap(bcontainer, iova, size, iotlb, unmap_all);
 }
 
 bool vfio_container_add_section_window(VFIOContainerBase *bcontainer,
diff --git a/hw/vfio/container.c b/hw/vfio/container.c
index cf23aa799f..d5f4e66f1c 100644
--- a/hw/vfio/container.c
+++ b/hw/vfio/container.c
@@ -124,7 +124,7 @@ unmap_exit:
  */
 static int vfio_legacy_dma_unmap(const VFIOContainerBase *bcontainer,
                                  hwaddr iova, ram_addr_t size,
-                                 IOMMUTLBEntry *iotlb)
+                                 IOMMUTLBEntry *iotlb, bool unmap_all)
 {
     const VFIOContainer *container = container_of(bcontainer, VFIOContainer,
                                                   bcontainer);
@@ -138,6 +138,10 @@ static int vfio_legacy_dma_unmap(const VFIOContainerBase *bcontainer,
     int ret;
     Error *local_err = NULL;
 
+    if (unmap_all) {
+        return -ENOTSUP;
+    }
+
     if (iotlb && vfio_container_dirty_tracking_is_started(bcontainer)) {
         if (!vfio_container_devices_dirty_tracking_is_supported(bcontainer) &&
             bcontainer->dirty_pages_supported) {
@@ -205,7 +209,7 @@ static int vfio_legacy_dma_map(const VFIOContainerBase *bcontainer, hwaddr iova,
      */
     if (ioctl(container->fd, VFIO_IOMMU_MAP_DMA, &map) == 0 ||
         (errno == EBUSY &&
-         vfio_legacy_dma_unmap(bcontainer, iova, size, NULL) == 0 &&
+         vfio_legacy_dma_unmap(bcontainer, iova, size, NULL, false) == 0 &&
          ioctl(container->fd, VFIO_IOMMU_MAP_DMA, &map) == 0)) {
         return 0;
     }
diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
index 62ecb758f1..6b2764c044 100644
--- a/hw/vfio/iommufd.c
+++ b/hw/vfio/iommufd.c
@@ -46,11 +46,15 @@ static int iommufd_cdev_map(const VFIOContainerBase *bcontainer, hwaddr iova,
 
 static int iommufd_cdev_unmap(const VFIOContainerBase *bcontainer,
                               hwaddr iova, ram_addr_t size,
-                              IOMMUTLBEntry *iotlb)
+                              IOMMUTLBEntry *iotlb, bool unmap_all)
 {
     const VFIOIOMMUFDContainer *container =
         container_of(bcontainer, VFIOIOMMUFDContainer, bcontainer);
 
+    if (unmap_all) {
+        return -ENOTSUP;
+    }
+
     /* TODO: Handle dma_unmap_bitmap with iotlb args (migration) */
     return iommufd_backend_unmap_dma(container->be,
                                      container->ioas_id, iova, size);
diff --git a/hw/vfio/listener.c b/hw/vfio/listener.c
index 6f77e18a7a..c5183700db 100644
--- a/hw/vfio/listener.c
+++ b/hw/vfio/listener.c
@@ -172,7 +172,7 @@ static void vfio_iommu_map_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
         }
     } else {
         ret = vfio_container_dma_unmap(bcontainer, iova,
-                                       iotlb->addr_mask + 1, iotlb);
+                                       iotlb->addr_mask + 1, iotlb, false);
         if (ret) {
             error_setg(&local_err,
                        "vfio_container_dma_unmap(%p, 0x%"HWADDR_PRIx", "
@@ -201,7 +201,7 @@ static void vfio_ram_discard_notify_discard(RamDiscardListener *rdl,
     int ret;
 
     /* Unmap with a single call. */
-    ret = vfio_container_dma_unmap(bcontainer, iova, size , NULL);
+    ret = vfio_container_dma_unmap(bcontainer, iova, size , NULL, false);
     if (ret) {
         error_report("%s: vfio_container_dma_unmap() failed: %s", __func__,
                      strerror(-ret));
@@ -638,7 +638,7 @@ static void vfio_listener_region_del(MemoryListener *listener,
             /* The unmap ioctl doesn't accept a full 64-bit span. */
             llsize = int128_rshift(llsize, 1);
             ret = vfio_container_dma_unmap(bcontainer, iova,
-                                           int128_get64(llsize), NULL);
+                                           int128_get64(llsize), NULL, false);
             if (ret) {
                 error_report("vfio_container_dma_unmap(%p, 0x%"HWADDR_PRIx", "
                              "0x%"HWADDR_PRIx") = %d (%s)",
@@ -648,7 +648,7 @@ static void vfio_listener_region_del(MemoryListener *listener,
             iova += int128_get64(llsize);
         }
         ret = vfio_container_dma_unmap(bcontainer, iova,
-                                       int128_get64(llsize), NULL);
+                                       int128_get64(llsize), NULL, false);
         if (ret) {
             error_report("vfio_container_dma_unmap(%p, 0x%"HWADDR_PRIx", "
                          "0x%"HWADDR_PRIx") = %d (%s)",
-- 
2.43.0


