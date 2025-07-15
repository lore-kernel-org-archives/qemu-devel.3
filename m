Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD6E3C83F17
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Jul 2025 14:55:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubh2a-0001Qb-5f; Tue, 15 Jul 2025 10:53:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1ubgSA-0003Sn-9N; Tue, 15 Jul 2025 10:16:20 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1ubgS6-00023b-9P; Tue, 15 Jul 2025 10:16:17 -0400
Received: from pps.filterd (m0127838.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56F7qa94014171;
 Tue, 15 Jul 2025 07:15:59 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=proofpoint20171006; bh=KnPWW3WCM/vNAGU
 skrpXUF04nfSK0xEoSE9QoD0B7Qw=; b=mBmYhskZMmacwfp1C3yKSoCg1BwH86i
 U1RkkFoK2OwjIdNVkZc5oY7Is0mABUU8lucM6Njvl+E6kTTeKk4+RHDOL9/ysflc
 W6aOmHRGtTtLPVHXl/4IUaLYsjOGuPZzUPgqPZZX8XA7gcChYqIREbRsZtTN1gDg
 HgB4rIyT2Ksy5Ird4iKPjZMzxkxmNR2fafHz0wVpKBnpyinxmkexSrPlVsLdfzB5
 diQB8KMAeaH99ewgAwt9J2Zy+a9pS/4LGaHqpCF0YaTOayxuv/TVxa+PtF2LN6yQ
 bCpSNOJNKGYdpxlQfoYRRmck8KHz9sOMBY6e7ij8nThVNchnRFrBqeA==
Received: from cy7pr03cu001.outbound.protection.outlook.com
 (mail-westcentralusazon11022117.outbound.protection.outlook.com
 [40.93.200.117])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 47vscfccxy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 15 Jul 2025 07:15:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mfwEG2ErggyHsecDO2QMwdUN48L2MejKDeiTcaaTtsH7+nS+MV4kIfRAti59CeIJalbZfiWUrbJhkIZur4z4hG0ZZQmrPNvGjJbQNSEq9OmhITTdhTWY0/Ab0lSZcPcN7kEsfy33MSSqR7Lf2xNeaLt+3bLf1s2JyljCQHz0h9YcC546Ze0CIsUDhsvzE17xwk2j7Yhm4rJgei+qCU4N0wsqjxaG7DLKW2zR5B4n/ZKWK1vv5HkHSfHyZozk8KpCuA2or+s9EODecDoq6p0PC35Iuo3h2UvMNvtnFozFA658qg7tl6n4vC/ic07aAWJ2B2wr4SPGKT1Pr/h9BBpFXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KnPWW3WCM/vNAGUskrpXUF04nfSK0xEoSE9QoD0B7Qw=;
 b=QCLRATT2x9fK3w3dfcZKxlNhTTJDEviEINN0zxGiK6iPVS9qT/YtEfHPZMAj0sTjPrYQFVfGMKxSAwDsQLUMZVwOekON8N3s9/7JJ/H9O6DOB22VnkNJspQLFgN61mpR+8i4g1Et6zlJm4i22oDyQiap+n8dIXRxMADj8L+Op6Gt79S89B7z1RzEf/qJVC1BKEWaE+pYYdTIgubr3Q0Ew6KnmtXhTNQuGBySxQKsZAvnCzDlk/nM5BMPSD+d/nnWfWj7uI7+tS4TMVB/wk7CH3C+TuSPPunyPONmviwhoFVbZpu2XDJGLxwCJ8zM6GlInEovkJHcAoys8Zi/xrWMvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KnPWW3WCM/vNAGUskrpXUF04nfSK0xEoSE9QoD0B7Qw=;
 b=gltrcm2CNHENSSbvOLMUok9t9t6pvGYkhIgicn1kuDWVAtS7NWLw/q7N17EfjiPGCzEufHzutRXdV+kliBJIymYVeedEtd7osFMubZ/af9/t4X3HygkBgclEo9qUu9VtQ4rCvvq0RWpzCV9qWEUSPd0g7McNSO/SqGoKZ7dYGRKAKxYP9SYNBU8yAHTT2mp1ZkOhbUnyCWWFw/NDruHCnzV6tVC5jpVsvg5zvTkRbGWodUhxUrFnkkoObQUD/MRa/BzDT6uNPmZ6ccq8QVGvNtyAhv0qrdstwIR3wfCHSmQ7q1PLJLnOoh704XoHx/iXtswWQUzQ7lSoGJIJOUUsZQ==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by DS0PR02MB10760.namprd02.prod.outlook.com (2603:10b6:8:1fc::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.27; Tue, 15 Jul
 2025 14:15:57 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51%7]) with mapi id 15.20.8922.028; Tue, 15 Jul 2025
 14:15:57 +0000
Date: Tue, 15 Jul 2025 16:15:51 +0200
From: John Levon <john.levon@nutanix.com>
To: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Cc: npiggin@gmail.com, danielhb413@gmail.com, harshpb@linux.ibm.com,
 mjrosato@linux.ibm.com, farman@linux.ibm.com, pasic@linux.ibm.com,
 borntraeger@linux.ibm.com, thuth@redhat.com,
 richard.henderson@linaro.org, david@redhat.com, iii@linux.ibm.com,
 thanos.makatos@nutanix.com, alex.williamson@redhat.com, clg@redhat.com,
 steven.sistare@oracle.com, tomitamoeko@gmail.com, qemu-ppc@nongnu.org,
 qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Subject: Re: [PATCH 13/22] vfio-user/pci.c: rename VFIOUserPCIDevice device
 field to parent_obj
Message-ID: <aHZil8RyEkev5T-K@lent>
References: <20250715093110.107317-1-mark.caveayland@nutanix.com>
 <20250715093110.107317-14-mark.caveayland@nutanix.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250715093110.107317-14-mark.caveayland@nutanix.com>
X-Url: http://www.movementarian.org/
X-ClientProxiedBy: AS4P191CA0014.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d5::20) To CH2PR02MB6760.namprd02.prod.outlook.com
 (2603:10b6:610:7f::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR02MB6760:EE_|DS0PR02MB10760:EE_
X-MS-Office365-Filtering-Correlation-Id: 777406cd-3b5e-4971-7e1e-08ddc3aa1e01
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?rBptCC2bPPLpI5+mLit/DbuVQmkbzRrPBSCwSufpqQTtP9c8qo3ynzzBwxDR?=
 =?us-ascii?Q?CNT5pbE4xAMFzGJ4J8TaNW6fw6yFRKX7EVXbwtXYKkL+dPVJ2KvVFS80xTna?=
 =?us-ascii?Q?q4y6igyyTx9g7wKwq/uB78yVtsCKKDrfZhNSFFe2dKOy22HfIF2Db5BitSpu?=
 =?us-ascii?Q?UF6q0WxxtJhAWTqTrREj4Wnh43JrPVbxhWm5EiWC5iVGeHZzhoxEgrv68agv?=
 =?us-ascii?Q?8AwIhIF7xmzvOZ0UfX8wZ7Ap0Td0nziODeBZP+Q/dFDd+PumVI30MI6WJRkW?=
 =?us-ascii?Q?QFKivBoCo6pGf34W0J8GH8dTRuxReeH/KcaGPYQLbkeLOUWDNy7jPQKGVWqh?=
 =?us-ascii?Q?IWIzm05ph6pkCPIBE+9lg5gIuR7+MXZ1LGeEieCL2zBfigJT2vXJJFiZqARu?=
 =?us-ascii?Q?QJrfRHhPu5BiN1Xg+5umAzxdedRsKmebsktSPcjFja2p/e2Wf8AMyHOxsBYQ?=
 =?us-ascii?Q?/PpG3bQGnZTIXGJVVmsbqvymLXI+9NJjihZtDV1MS5OD0ps2E7V9jTvApeN9?=
 =?us-ascii?Q?JIawaIQQD/U7BbkjzQ50TM5DzNcjoL7wIaiMbOAsBzjJxs+P+ziFml7hCwZV?=
 =?us-ascii?Q?rbbfvZJ+B7MunSeKJ+yfhQSbAyoOkHC8VQ9+TC1qstdoxoiQ4SUQRKPOC71T?=
 =?us-ascii?Q?8akcxIW3PNAbzSxRPuJS9nwsZ5oMOdTMMhDs8WdICgpOYK16CLW+RxpvBShi?=
 =?us-ascii?Q?DpAXXYYoegGsfjm3Lh55TXkpZvV1ksOE9Wf6VYtaPYuQnVc+4ISZEZ6d1Eel?=
 =?us-ascii?Q?dVlbNa5rsvMhq8MRV7W7G8U3178skevYRd/ibjXJ7zzjCeN79czpx4xv4kZG?=
 =?us-ascii?Q?RQ8fOI5KAc1VmTlNXBJJulswi+PZsfAOndkzF4Uad1FgTwPBkvEXhCEao9sF?=
 =?us-ascii?Q?kMFkH1+iJWBWDYfvhuLhFGStdA238etydK4l9TDpHZogrxoSVfPjLSRJ2o3c?=
 =?us-ascii?Q?kDmp2tU+Sdl0RBeKpMQ3NaCfBEToCDZLi1ogITAVllLsamOmCgoiq4EWOVX3?=
 =?us-ascii?Q?8aq7/SpVsY/+51mwgUxjXNBmjqjkm8ROHMzeZ7sD6ukGjChbBUSNYBDBQ/eh?=
 =?us-ascii?Q?0r45ZVSeX8pclSOAVCcbiGsux28zB64IYDwqZ3z5uZWe2LDMqcJ4wBtH8gid?=
 =?us-ascii?Q?j4NLgJU+vpZ0wq9G0J8LWbjv4TTLLBYXlKPruOPLelFAyBtVxMS9waB+7xw0?=
 =?us-ascii?Q?VSSjmHUHUjTTIQisP7Dt9sN6DGBVIWOGgKnCMoSGBblw4p96say2/D3VbHiY?=
 =?us-ascii?Q?ndruGWzQuJPRyiwmQErkt4rxWmVTdGva+lxnPjSmlS+N5LTmXHz7P588+xja?=
 =?us-ascii?Q?1Fo5aQ8fSPAtdPSj+rOb2WPtWge51+3nOv4+yDwLR9HbQPsocowXiasURC1F?=
 =?us-ascii?Q?9GQsFo2SztYQcRKFCwT4/s3yF6s5hvn6b3IehTfg7dJxKZGO2JW9Mc5Nb+Wa?=
 =?us-ascii?Q?xkTgnWNgnyw=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(366016)(1800799024); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fBya7rf70qeSbyjAReBDpk7TXOtkUe9qUQ5LDlBbtSF/CUu1iJ+R00Wq0bu6?=
 =?us-ascii?Q?xjwQ9SUcVSXBnVd64ymHvwkCxG5/k/waX9pbcq2qIeA3nqJF2gV2kFJ+KvPF?=
 =?us-ascii?Q?zCnwBOzNheolRQx/aPdsDmQ6l/I4rNG+qzYSPIgUVKgK4X2A52wJjfPYhXC1?=
 =?us-ascii?Q?X6lG5AI/sorAWX1UQqgpGvkk6yXi0VnfzBt4lSQ4abNGfkf+t+dRZShxYT+o?=
 =?us-ascii?Q?pzrPb5WbNlt5HSokWlvKg+2fa810zBYVeLhR3gw9iipZfqTrPhz1CbT7mtr9?=
 =?us-ascii?Q?B8L2UCzKGXJscvwziM9Y0OTLtQLvbMYTGANyIXDQhR00HQKQafB2Ojcw+4Vj?=
 =?us-ascii?Q?wujvgc1Is8XBj32u1lne0s+2SL4t/z/zBVQhkqsRO57dC5g90ZtzY/ilfyFT?=
 =?us-ascii?Q?p4LYxwcnuzy9Dsjc7ayw2tBvt5rw7tYBbKcmkaQegdnmKj0MyFtdhORUeii7?=
 =?us-ascii?Q?Myspn3xkyydGGL9wegp88Feb8pYpXkfTEGWYP7SWed6XhBxD3UAINzg0kpSj?=
 =?us-ascii?Q?V2DoG4D0uOmjfvlKwM3Mp2g/7i4LDCs7bkeTGz+ZGuOb+opLnVWGuGIOu6WI?=
 =?us-ascii?Q?LxbftAH3kMN8+xVvO6jOnFHXgTlAtcrv2J64Hw4Oz1jYkh+j1LZhzZFOWZDd?=
 =?us-ascii?Q?R1G0B2UbxDsB0+iQ37XNLaWHRvPlhZEijKf/eege73IDyl0wnFFAXh4jvj9O?=
 =?us-ascii?Q?UdnY7exVQWwlSXWTyVVFQQQbxMwgtmdBdhkxjFQZ4dWcZPeRyOf3hFAqLcVo?=
 =?us-ascii?Q?EPFOK28H6UNrEoBAcMZGwpHDszAk3Jktw2R9Xi845MdSDxEluYo4HxGWGfZc?=
 =?us-ascii?Q?b/5tIdEPldjBk9D6aKDTBoIP3L37UhB69vmwMmcjkhdAwMchJQI+rnivW63d?=
 =?us-ascii?Q?AjXG0XhLAVHFjt1iIHefdrYRApUJm/MYQ9vLpSDC94WKga2SZ6Y7Uq+fnQvl?=
 =?us-ascii?Q?XGQViwjNmF6O8WtoemRoJZ/Fo9oELPw+X3Mbk9yi2sVJRyQu0z0XGsPAFr0s?=
 =?us-ascii?Q?DACujSW5JTzdFOIi5oKOhNTQ1rOWxdEEETK7EfiC4jW9ND0Nfp5kiPoVH4Ru?=
 =?us-ascii?Q?lbaqUQIL4TwMlikNqiU6OFkhNebB26Yzsl2Wh8L0463kIpAsMNXgqpNev+E2?=
 =?us-ascii?Q?/0LF8sFz6IEnm1xKZprfWgt0eqUHXP85hgrLuQCnbGA9k1R7HQlbEFvVMPqI?=
 =?us-ascii?Q?T+kvijGX8bnIntX6GJ7BjXOqgOovAX6PtrWkNWZiC96sVZbjAZBMRUBlXSKM?=
 =?us-ascii?Q?afPXthYGSGqJzmq4/tBTrjzFiuXqQDa0HgfZ6D1V1zteOeYVeMGzkBtNO+Pd?=
 =?us-ascii?Q?4QhuU6kGxHmWpd78uQOSXLOO6BgNgYkmTbg0/gZDJTDtdQDuOazSsBWaNGXl?=
 =?us-ascii?Q?I21BuSXNbW2MmvopPr3Cgh9chd7b2fKl/XSYDDlE+pi7790sldHE8BA51Q7J?=
 =?us-ascii?Q?I/4mHuRX6hxaOhkr8xkR7ql249oXJRoPGvVOOHosQgGGwtYtqJWAttiWJNmX?=
 =?us-ascii?Q?mdKAKRggpn7iJohJ4mc2nieN39TY+2Vf21bMEKcKmNcNMyP0ij74y+e8brkw?=
 =?us-ascii?Q?Oz7vppNkfTc0fR1mRBwOeNb1A9dYXHLuQgm9oui3mLtR8WWOotR2+tQqal9A?=
 =?us-ascii?Q?wQ=3D=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 777406cd-3b5e-4971-7e1e-08ddc3aa1e01
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2025 14:15:57.3079 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8+VLjO29CnlRhOUoRSbIFHyy+ajOGwD15YhElU2fBXk6NntwkPXU4qGYyfNBwryWoXuPAQb9fu8ODHWYj3YH2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR02MB10760
X-Proofpoint-GUID: 2FWtCRK9JNGLxcudYW8uHEUDXO_ds5oG
X-Authority-Analysis: v=2.4 cv=a+Mw9VSF c=1 sm=1 tr=0 ts=6876629f cx=c_pps
 a=yubZOcZ2lo++m6xvl598Qg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=Wb1JkmetP80A:10 a=0kUYKlekyDsA:10
 a=64Cc0HZtAAAA:8 a=3L1koqHROfab7wl7VHkA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE1MDEzMCBTYWx0ZWRfX7vy0c47bytbl
 yGoXNQ2RfiX0OJ3kPgAOg9cA3jhESe0wQlj4zurrzzGtbf914qWAug0nKFofTyZ+MJoxIjDpcPE
 SPXi256yysL2riZpd29NSQTJQ8JAcprmdAlDjNpXm0rRhXW7hy8bCQ4nUMpS0J3ebnGZ3Cp594u
 wT3Y/repp/8111fQRp8eYbdwLD9gRo5OD1i87QmLFRndOpnqZoRKQL32I026h+d+CBRPfuo55Ji
 i4rtFHsUH85XPFqlBJGVb20L9FWyEh32EzR3XqMnuC8fzHv2AwZyKCJ1rNS2pHPqxPlbm6YpNiJ
 A6yM8AdesFIAt2BIj07h+Wic+mT1UjLAOXnRO5cz2IC0d9zz3loML2UG/gCz+gEsITAVMNgBzvN
 QJ9+LkGL7UHTEYFY9++E/UTLlGzIoAS4Ue6shssV9B3xxzux0B+k92KRxYEbxEUXvLnE0P6c
X-Proofpoint-ORIG-GUID: 2FWtCRK9JNGLxcudYW8uHEUDXO_ds5oG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-15_03,2025-07-15_01,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=john.levon@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On Tue, Jul 15, 2025 at 10:25:53AM +0100, Mark Cave-Ayland wrote:

> Now that nothing accesses the device field directly, rename device to
> parent_obj as per our current coding guidelines.
> 
> Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
> ---
>  hw/vfio-user/pci.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/vfio-user/pci.c b/hw/vfio-user/pci.c
> index e23a941605..9380766548 100644
> --- a/hw/vfio-user/pci.c
> +++ b/hw/vfio-user/pci.c
> @@ -20,7 +20,7 @@
>  OBJECT_DECLARE_SIMPLE_TYPE(VFIOUserPCIDevice, VFIO_USER_PCI)
>  
>  struct VFIOUserPCIDevice {
> -    VFIOPCIDevice device;
> +    VFIOPCIDevice parent_obj;
>  
>      SocketAddress *socket;
>      bool send_queued;   /* all sends are queued */

Reviewed-by: John Levon <john.levon@nutanix.com>


