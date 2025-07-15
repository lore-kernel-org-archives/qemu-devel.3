Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB2E1C83F1D
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Jul 2025 09:38:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubc2a-0003QP-Gs; Tue, 15 Jul 2025 05:33:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1ubc1X-0001fi-5O; Tue, 15 Jul 2025 05:32:32 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1ubc1P-0005qs-8j; Tue, 15 Jul 2025 05:32:30 -0400
Received: from pps.filterd (m0127843.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56F0Rk07000393;
 Tue, 15 Jul 2025 02:32:18 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=PPnjQSehHMoahmHI3FzG5X/TvNo2Q68Lpt/M6auDU
 CQ=; b=kX2MJXT0NA2i4lbstdynQ+K0S1YQpzJDNSQTDwBtmsn59b5Uzaeh6jYR9
 ZJfttYppEeDAldlSta9SkLvSPd9zOBmemeKkoUN75KX0kzusKDykcFo7IsJ34oOd
 eZ6wc7jzzsxE3wHughV+NVf5vl/QNzPcIi1CWZHUiRDMa1tbUhCXYDcilPxPfYjs
 qW9GUGb+OGuM4uZycgvYMUkY5tlJjDAu9e+kaeg4jt+0yHINSZVl+7xAABw8yaLt
 wLBDKpf7ina5F8iwt1OOQtLUWAQ5lCMuNTrStCy4WFALg5NNqLzU002Tk62dGwTC
 icx0Y5tdJgn8+ONYuydrsll/urqMw==
Received: from nam12-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2123.outbound.protection.outlook.com [40.107.244.123])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 47untj5xbf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 15 Jul 2025 02:32:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xKjfqD+gtIzWgEUNZtkVaNznj6BVm7hkzOWCKL/AnjgOKGR8fwBcghiNQqN+xZC3eusWCrjUdcrRZObr4orhDtIVq/Rh5PuCaOy24AV3HRdYTkYyO9aVop48jP9h5XFAvNSbgQ7OxH951/avjqb7JwRObCQJaxn8dFlKW0i5icBCg13+U22PciJm/XBS2R/oy5Rbx/f1ER3i5kGw/goY7O3taqKq2HnrPmIIf3puVrx3MzaLltOvNZf/CmJFstE7ll4AvxrQV2HxLgIMb9FTvkVD3V3vLlGzLjqBW4UomqUvjpBp+p7X4WPHu51kAFIc4ksXozpgWJLlF0LB6EHtiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PPnjQSehHMoahmHI3FzG5X/TvNo2Q68Lpt/M6auDUCQ=;
 b=Cw1G8gI8fUHy/FfRMTXeZHUS60lVx29MtSTM9EHvxt4ty4iccCs0tje87f6ubYhr/rq4n4Agj2W1bajd7i+MIt7wQjO7KxzxjNUiT2koBywXyDfggvjEMhBSDHPvrbDcggfpVNiN38kusslYq0LvejduaVhCJVpZbNysicG699vexfw03vcVs5fJ4XH4E5GEcarvlja08ve4vKTxJR4BnO19gAruh9RtCMkPtL/JSyLHQ18oTsNZOD8B3rCYdrz9m4YdyeO7tNgtVaDHzA4oikKG9/F8yqphKqcr8i6oFWaaFObP5jif03dvC8JmebvxsyzrH0XBW/v8aYrvK8oKpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PPnjQSehHMoahmHI3FzG5X/TvNo2Q68Lpt/M6auDUCQ=;
 b=R3AM9ATqoWQC8N7outN7Ykm1Lmyt6lZwHXtoXHkjYeuWjrWMSAkbQREb/z+4zbRPuzj+h5Fa4APfOmjRlowhZ7efyDZoJwCwODVIeJafpFk/a67KKx7QGlyeumKovspIx12uFhj4l+/PgrABACM+40/LYA1YAUtYaqGeWABvXK3FfV6FJ1NvXFR3BMz/0xs69G33KWHxuuck0tefxpr0QwiMOGCfCNX7wn+QHlJkplvUBTEueLPHQqgH+70v7rTUX9boJN9UmT43SeLkDqtLhSi6wE6aGJ5HMG7IODTHgwLfepEksWfRb6NAGM9s1oMhh8s78rx0aIvleXw2Q+FUoQ==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by SJ2PR02MB9770.namprd02.prod.outlook.com (2603:10b6:a03:548::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.25; Tue, 15 Jul
 2025 09:32:16 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88%5]) with mapi id 15.20.8922.028; Tue, 15 Jul 2025
 09:32:16 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: npiggin@gmail.com, danielhb413@gmail.com, harshpb@linux.ibm.com,
 mjrosato@linux.ibm.com, farman@linux.ibm.com, pasic@linux.ibm.com,
 borntraeger@linux.ibm.com, thuth@redhat.com,
 richard.henderson@linaro.org, david@redhat.com, iii@linux.ibm.com,
 john.levon@nutanix.com, thanos.makatos@nutanix.com,
 alex.williamson@redhat.com, clg@redhat.com, steven.sistare@oracle.com,
 tomitamoeko@gmail.com, qemu-ppc@nongnu.org, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org
Subject: [PATCH 17/22] vfio/pci-quirks.c: use QOM casts where appropriate
Date: Tue, 15 Jul 2025 10:25:57 +0100
Message-ID: <20250715093110.107317-18-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250715093110.107317-1-mark.caveayland@nutanix.com>
References: <20250715093110.107317-1-mark.caveayland@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P250CA0018.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:20b:5e3::13) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|SJ2PR02MB9770:EE_
X-MS-Office365-Filtering-Correlation-Id: 5568ab7d-4d93-41d3-d822-08ddc3827c7c
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|366016|1800799024|7416014|376014|921020; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?J4i2Wr0SoQekvEf+Dwyl2Y6DVlzo08f7PUbHDUhkG3hSDl/Ep8ZI2vSLjAR5?=
 =?us-ascii?Q?Mtzr0mGXlvr5ebFgJJcsrlD7hou4FLNWlSTshdH6AcdfEY04RzKKjeYjXH6d?=
 =?us-ascii?Q?25Pr2LTDC4jwzSSDeoskbUkG2Zu2IyrSSh3lYJbe1JgT9k5PQ02wSiTZBpdY?=
 =?us-ascii?Q?ACdJYlGK3XIS/0zoAZETjaw2WyrEjEAsUiKZlrpr7MI5vTjaN+T3OEvchl7H?=
 =?us-ascii?Q?118jW550fdDGh2b2HuPKnGqVcm6aXiIJxaHNtHAhgNi1uQ0dfBtHdcYW/5Yi?=
 =?us-ascii?Q?v4ZDBvQfWtLTWvBKE1OA3K8KDc4gdcZdo0+vj+WO4LPCu7sLkhgd1B6Mh9bg?=
 =?us-ascii?Q?ErTDkqn+P0k2mG6DgQyJLWcrwkr6fkffSMkA8qTHI5nhvX8WM5ZrcdK1coRO?=
 =?us-ascii?Q?hivlgOgNHmdzmy2u7DxsKt86T3zkpeXRYgIHmg0lxlKIZTWYyA/SlJhuyrJ4?=
 =?us-ascii?Q?SaUviat4KWsWcAs8zRAm4yLB/Py5WsI4ShefwoUdA8dfEvb0dxDnkUfl/gVr?=
 =?us-ascii?Q?lEOXQtl7JURJ9KGHpTaGNLYfNu4lZv81LTkVOUJd1mWjbAfs+d4K7W/6DQn+?=
 =?us-ascii?Q?a5h1b+AgNXolIYF+cN/7nmkSF3an+ZySC0c+VYvmywccyPSW+/7vZ5V2Xh6q?=
 =?us-ascii?Q?QyZ348Zf6P4fbp/MqESNUZyqSHOT2bO/mxoFsf2lnfJ1+sLgymqt+mz4JtV0?=
 =?us-ascii?Q?Vgtv2JywRz0/Ai+X0HpjGNr2TpwtZd7UnBdv2pOtJEIUNqOrWHik9NvnWYRV?=
 =?us-ascii?Q?knIgEygT+XAHTAi7YIkFlua4QNGxwcxio/RdVTqE0LEVIS3HqQHw8lJZgZGb?=
 =?us-ascii?Q?jS/8GugvJxzUAKB8ZUPU1P5CqTRK8h6AAjv61th6DNnJEe/0HFIRaOM/TY82?=
 =?us-ascii?Q?GJF21xxdCeMf+dHZ2BvFnCMqc+mBxNa/wRiVO1BMnp0Uxhbc6qnek+KEK1vE?=
 =?us-ascii?Q?xkUniFr0s9vMERZQ3jHVbA+S328IoW0ElHI7QYwLwFduRvAPTgBCMYD3yPjV?=
 =?us-ascii?Q?sq/al2x2Q4O8/bTgmSKdLfFqU07PMBU6788KUfdbyMebQoB+NWqsLgMsoxVj?=
 =?us-ascii?Q?nrtJQY2Vkx4rGDBDg8Pf9VstKX/tJ5swFN9VkF76epO1vVH928zoctGs0eED?=
 =?us-ascii?Q?qQq8dadIT0AgnqOud29yx2pI7nbgOXwFGl8R1P0rZ2D5H4K+V5wslWW5n36O?=
 =?us-ascii?Q?rS9fh5+uQ+ETn7PGmIuTTpxor+r+8rUs+Bkxe1GANmasc6SxmpwNaOvWFcmv?=
 =?us-ascii?Q?y3GUj5gMAllvF1FJ8ueawA/OB8oQqZcOkRzNsnQKH4oWgtpoVwmOCH97gzyw?=
 =?us-ascii?Q?eDQhB3aYAMW5+4fy1JydZSQL6B9S1NxRj8yu2s8ZsJivUDL/JikihblHxXAM?=
 =?us-ascii?Q?a7/emeGw9/P32fr7mizx/mSuK32sdPMCJ0uh0pf6khesyTl14VyY0dvRh/+A?=
 =?us-ascii?Q?tJYnMuiMnq9sRULwjB4D4/IsdOGlgvd+E2Zo6DlaWGRU90RgA+nLyw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(366016)(1800799024)(7416014)(376014)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Arz7MgVFgg2Uyh3YsFwVPved9Xmdt+SX3kzt3xWG8C5GIeG8Bk6ub7tzuUba?=
 =?us-ascii?Q?Q50kiwOF85GBthLImMpUXKcrXZpWQkzZ03HVItRuHM5t3M4/DA2ln2ddEiTC?=
 =?us-ascii?Q?/u8cvpNvOyKH7iB/oy7fb+xoi8mTN0m0qk0OIqO2E0jGjtlapH7NpPpySAon?=
 =?us-ascii?Q?zE84+xyReqvEwgwv6TRn2X0zFmPW6ruPZpEPlKz8oXe1LyCGaS7p4lI7OSVw?=
 =?us-ascii?Q?8/orIKMq2qLxmGT6XfB4LWbxMfKlSTCIlO1rgPJYVszm4CZyFt20gl77IQF6?=
 =?us-ascii?Q?ACBMrxB97KSYdpTEHqUDqeWpBcIzaoX+5DkgdP01kYt4jukBYlbF4Bo+5CSq?=
 =?us-ascii?Q?1IQRAzFOIjPoGoug+KJdWIFl5HkPBNI5AmqXZ61/maxAZOdQR9sAC9wU0IzH?=
 =?us-ascii?Q?0K1ULVMYxkPQLR3vtalbeg6lqQFdnoAiyTCXtHD8C8DHD97fVO4WBulJ41is?=
 =?us-ascii?Q?sA4ih2YbSoK7LxfK5UbSQCbB0+x6YsS8hCFKl25zsFiZv1JTgHKdRHUA2JkG?=
 =?us-ascii?Q?H5ivjF91VJ0aCglRinf+XXqUc7EneDq/jHLTSCWJzfgHRqELZR3y9X6jdZCB?=
 =?us-ascii?Q?y3aZnBjMe8Lj1aW7BGlLg9WrBRMDnoZy+TsW5WMddxBAu4jQihaSOouC5Ibb?=
 =?us-ascii?Q?emBtF4zHompWPTCYnphp8jSPKrH9h7//BeSU1v+DBMUzU8rqoqGuG4mbgbtJ?=
 =?us-ascii?Q?pMOdKc5g5NsbMQ15GrhDcaM/I0itm6vtnw5d9wtTI00ISPgX0Cf+ooEjAy7k?=
 =?us-ascii?Q?IE9EMlSuH+3ngs0RBCJlwkdS2KfUtrZ+7tSZWl5tG0UygRVz8kfIhyzAENUz?=
 =?us-ascii?Q?MNKhECUWmhloqFfzhhgp8iivQ1jObmKvS5sS0a/VU6QjpPZf4rFPFsJHrHuk?=
 =?us-ascii?Q?TIpx7ZYfH292B2OqDKC76Nml73qBeNDP12db5IcL24t2svO46DK10frN5CKk?=
 =?us-ascii?Q?Xgf91c592uPonHdxjblu9Ilil9PYRiTm31Y7rxTUryi7auIOB/zWQsXgPjBP?=
 =?us-ascii?Q?/82LuVN1IBXR/Q+wu0R9eKBPw54/GHFqxPprDmO5Gm2Ho1Zj2L4jUvN0ZHSf?=
 =?us-ascii?Q?jqxl1KUqjoZK48W+HqI/lZllZTdkHIF4c+aEK44irfQzAppD0i7mjfTAKYDW?=
 =?us-ascii?Q?i8bt6uUdjQKuSmblKJWk+xPbtAwUHSYcim26dsF4PWDUGVIIIzdtToTp6Ft4?=
 =?us-ascii?Q?pmWOzLoTr2AObCzci9gYEoYvvhCUlqtpcBaPF3Rk6EsjFoE9I15vB6Cj1ydl?=
 =?us-ascii?Q?3ZFQ45JCt81YBN0aM8ZLi5XLlCKGaWHlFs6/2DRTbznkutVh4wqyjW0Bifb/?=
 =?us-ascii?Q?h3EtGI9OPAKcGkCEfSMFy3z2gPfqL6DhsEOFB7JPzbXjXvwvAofHkVv/TIgb?=
 =?us-ascii?Q?0Q6pXkhSK+PSD/s/oL8fHAsCT7/YF0qR6PDVETOVL3lkFdzN9dQkSOjiiIVV?=
 =?us-ascii?Q?UkdHdhvesgR+QuDzmomlcjJ9wOYPF2wW1cg5D/BCYpmm2ZneclmjgTfMKvX8?=
 =?us-ascii?Q?bi5t8uu017oPQ1zqaw8Uc0rJPR47Rh2SfSJpCHBD6qFYOy/bXNNb52gkrI3q?=
 =?us-ascii?Q?HD7rqAFjQSH0jqaLUZUr93pzrSuZsdFGonHBa5FsvORUQahe5Cpd9nGcwfsu?=
 =?us-ascii?Q?PZ3jlfZbelFruOQ+pkmOb3WuNZ62B7COOPSwuJ4Kwy6DS7tK/lhyGIfmwiZo?=
 =?us-ascii?Q?KmxpNA=3D=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5568ab7d-4d93-41d3-d822-08ddc3827c7c
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2025 09:32:15.9475 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WNLer6FThjAzQXQpwkW4NyI34Za5XJyZQwY+kAhHbG1yHkQbb4ixQ7/nxH4P4p8Syr1h74ULAEbjkkJPl/q7Te1wihN77b3rvOM8V4kExvs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR02MB9770
X-Proofpoint-GUID: f8yKuXvCzzB4v-KWJkWXvQ7rBYPY3Pxf
X-Proofpoint-ORIG-GUID: f8yKuXvCzzB4v-KWJkWXvQ7rBYPY3Pxf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE1MDA4NiBTYWx0ZWRfX8slWqoTYUXas
 iIVG1TY/EHTZnLQ5kBc7bABd/FP7jxnDqKpb/vP+uah1G5niN69Vn8V930896gMltmM09FITD28
 SJrDGOKrP4lWg5KAtS0i2FswKQXz+eUdrX4yZVg24UOL/gKpIsmQq+IIINDhCqeLKH9aV2xLk76
 bb6Kl6l3m9iIgQ+ouC0xjacm8TP0+FuHbMQGo8ghtoKOqtDUNUFQHkO05+mLUhtFe4CaGMLz4Vf
 +YHZgLASjw/ioBkFpjckLrecPQpFyGWcol80KJqay9siI1B4ItNCaKmsaslqjOn6b8HM8shM8Ft
 F1IofDsWkou9flpN/2F0LSKK7qpcuOdqLxC79hQ2/Fg3PM/qdHeFRFuYam28j4HRWw0QDRI6oUY
 o86QNlYRm/CATE9xXHktyPE5PU8DhLkWZRlZNVXX3/5zAk4GJI/C588QlPI8WIlAokBnPp5O
X-Authority-Analysis: v=2.4 cv=PYb/hjhd c=1 sm=1 tr=0 ts=68762022 cx=c_pps
 a=iT0IPLB/rXRz/LGl7erAeg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=Wb1JkmetP80A:10 a=0kUYKlekyDsA:10 a=64Cc0HZtAAAA:8
 a=h0RCa5q8ibN7Vs0B3LwA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-15_01,2025-07-14_01,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0b-002c1b01.pphosted.com
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

Use QOM casts to convert between VFIOPCIDevice and PCIDevice instead of
accessing pdev directly.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
---
 hw/vfio/pci-quirks.c | 48 ++++++++++++++++++++++++++------------------
 1 file changed, 29 insertions(+), 19 deletions(-)

diff --git a/hw/vfio/pci-quirks.c b/hw/vfio/pci-quirks.c
index 3f002252ac..c97606dbf1 100644
--- a/hw/vfio/pci-quirks.c
+++ b/hw/vfio/pci-quirks.c
@@ -113,6 +113,7 @@ static uint64_t vfio_generic_window_quirk_data_read(void *opaque,
 {
     VFIOConfigWindowQuirk *window = opaque;
     VFIOPCIDevice *vdev = window->vdev;
+    PCIDevice *pdev = PCI_DEVICE(vdev);
     uint64_t data;
 
     /* Always read data reg, discard if window enabled */
@@ -120,7 +121,7 @@ static uint64_t vfio_generic_window_quirk_data_read(void *opaque,
                             addr + window->data_offset, size);
 
     if (window->window_enabled) {
-        data = vfio_pci_read_config(&vdev->pdev, window->address_val, size);
+        data = vfio_pci_read_config(pdev, window->address_val, size);
         trace_vfio_quirk_generic_window_data_read(vdev->vbasedev.name,
                                     memory_region_name(window->data_mem), data);
     }
@@ -133,9 +134,10 @@ static void vfio_generic_window_quirk_data_write(void *opaque, hwaddr addr,
 {
     VFIOConfigWindowQuirk *window = opaque;
     VFIOPCIDevice *vdev = window->vdev;
+    PCIDevice *pdev = PCI_DEVICE(vdev);
 
     if (window->window_enabled) {
-        vfio_pci_write_config(&vdev->pdev, window->address_val, data, size);
+        vfio_pci_write_config(pdev, window->address_val, data, size);
         trace_vfio_quirk_generic_window_data_write(vdev->vbasedev.name,
                                     memory_region_name(window->data_mem), data);
         return;
@@ -156,6 +158,7 @@ static uint64_t vfio_generic_quirk_mirror_read(void *opaque,
 {
     VFIOConfigMirrorQuirk *mirror = opaque;
     VFIOPCIDevice *vdev = mirror->vdev;
+    PCIDevice *pdev = PCI_DEVICE(vdev);
     uint64_t data;
 
     /* Read and discard in case the hardware cares */
@@ -163,7 +166,7 @@ static uint64_t vfio_generic_quirk_mirror_read(void *opaque,
                            addr + mirror->offset, size);
 
     addr += mirror->config_offset;
-    data = vfio_pci_read_config(&vdev->pdev, addr, size);
+    data = vfio_pci_read_config(pdev, addr, size);
     trace_vfio_quirk_generic_mirror_read(vdev->vbasedev.name,
                                          memory_region_name(mirror->mem),
                                          addr, data);
@@ -175,9 +178,10 @@ static void vfio_generic_quirk_mirror_write(void *opaque, hwaddr addr,
 {
     VFIOConfigMirrorQuirk *mirror = opaque;
     VFIOPCIDevice *vdev = mirror->vdev;
+    PCIDevice *pdev = PCI_DEVICE(vdev);
 
     addr += mirror->config_offset;
-    vfio_pci_write_config(&vdev->pdev, addr, data, size);
+    vfio_pci_write_config(pdev, addr, data, size);
     trace_vfio_quirk_generic_mirror_write(vdev->vbasedev.name,
                                           memory_region_name(mirror->mem),
                                           addr, data);
@@ -211,7 +215,8 @@ static uint64_t vfio_ati_3c3_quirk_read(void *opaque,
                                         hwaddr addr, unsigned size)
 {
     VFIOPCIDevice *vdev = opaque;
-    uint64_t data = vfio_pci_read_config(&vdev->pdev,
+    PCIDevice *pdev = PCI_DEVICE(vdev);
+    uint64_t data = vfio_pci_read_config(pdev,
                                          PCI_BASE_ADDRESS_4 + 1, size);
 
     trace_vfio_quirk_ati_3c3_read(vdev->vbasedev.name, data);
@@ -563,6 +568,7 @@ static uint64_t vfio_nvidia_3d0_quirk_read(void *opaque,
 {
     VFIONvidia3d0Quirk *quirk = opaque;
     VFIOPCIDevice *vdev = quirk->vdev;
+    PCIDevice *pdev = PCI_DEVICE(vdev);
     VFIONvidia3d0State old_state = quirk->state;
     uint64_t data = vfio_vga_read(&vdev->vga->region[QEMU_PCI_VGA_IO_HI],
                                   addr + 0x10, size);
@@ -573,7 +579,7 @@ static uint64_t vfio_nvidia_3d0_quirk_read(void *opaque,
         (quirk->offset & ~(PCI_CONFIG_SPACE_SIZE - 1)) == 0x1800) {
         uint8_t offset = quirk->offset & (PCI_CONFIG_SPACE_SIZE - 1);
 
-        data = vfio_pci_read_config(&vdev->pdev, offset, size);
+        data = vfio_pci_read_config(pdev, offset, size);
         trace_vfio_quirk_nvidia_3d0_read(vdev->vbasedev.name,
                                          offset, size, data);
     }
@@ -586,6 +592,7 @@ static void vfio_nvidia_3d0_quirk_write(void *opaque, hwaddr addr,
 {
     VFIONvidia3d0Quirk *quirk = opaque;
     VFIOPCIDevice *vdev = quirk->vdev;
+    PCIDevice *pdev = PCI_DEVICE(vdev);
     VFIONvidia3d0State old_state = quirk->state;
 
     quirk->state = NONE;
@@ -599,7 +606,7 @@ static void vfio_nvidia_3d0_quirk_write(void *opaque, hwaddr addr,
         if ((quirk->offset & ~(PCI_CONFIG_SPACE_SIZE - 1)) == 0x1800) {
             uint8_t offset = quirk->offset & (PCI_CONFIG_SPACE_SIZE - 1);
 
-            vfio_pci_write_config(&vdev->pdev, offset, data, size);
+            vfio_pci_write_config(pdev, offset, data, size);
             trace_vfio_quirk_nvidia_3d0_write(vdev->vbasedev.name,
                                               offset, data, size);
             return;
@@ -815,7 +822,7 @@ static void vfio_nvidia_quirk_mirror_write(void *opaque, hwaddr addr,
 {
     VFIOConfigMirrorQuirk *mirror = opaque;
     VFIOPCIDevice *vdev = mirror->vdev;
-    PCIDevice *pdev = &vdev->pdev;
+    PCIDevice *pdev = PCI_DEVICE(vdev);
     LastDataSet *last = (LastDataSet *)&mirror->data;
 
     vfio_generic_quirk_mirror_write(opaque, addr, data, size);
@@ -1005,6 +1012,7 @@ static void vfio_rtl8168_quirk_address_write(void *opaque, hwaddr addr,
 {
     VFIOrtl8168Quirk *rtl = opaque;
     VFIOPCIDevice *vdev = rtl->vdev;
+    PCIDevice *pdev = PCI_DEVICE(vdev);
 
     rtl->enabled = false;
 
@@ -1013,7 +1021,7 @@ static void vfio_rtl8168_quirk_address_write(void *opaque, hwaddr addr,
         rtl->addr = (uint32_t)data;
 
         if (data & 0x80000000U) { /* Do write */
-            if (vdev->pdev.cap_present & QEMU_PCI_CAP_MSIX) {
+            if (pdev->cap_present & QEMU_PCI_CAP_MSIX) {
                 hwaddr offset = data & 0xfff;
                 uint64_t val = rtl->data;
 
@@ -1021,7 +1029,7 @@ static void vfio_rtl8168_quirk_address_write(void *opaque, hwaddr addr,
                                                     (uint16_t)offset, val);
 
                 /* Write to the proper guest MSI-X table instead */
-                memory_region_dispatch_write(&vdev->pdev.msix_table_mmio,
+                memory_region_dispatch_write(&pdev->msix_table_mmio,
                                              offset, val,
                                              size_memop(size) | MO_LE,
                                              MEMTXATTRS_UNSPECIFIED);
@@ -1049,11 +1057,12 @@ static uint64_t vfio_rtl8168_quirk_data_read(void *opaque,
 {
     VFIOrtl8168Quirk *rtl = opaque;
     VFIOPCIDevice *vdev = rtl->vdev;
+    PCIDevice *pdev = PCI_DEVICE(vdev);
     uint64_t data = vfio_region_read(&vdev->bars[2].region, addr + 0x70, size);
 
-    if (rtl->enabled && (vdev->pdev.cap_present & QEMU_PCI_CAP_MSIX)) {
+    if (rtl->enabled && (pdev->cap_present & QEMU_PCI_CAP_MSIX)) {
         hwaddr offset = rtl->addr & 0xfff;
-        memory_region_dispatch_read(&vdev->pdev.msix_table_mmio, offset,
+        memory_region_dispatch_read(&pdev->msix_table_mmio, offset,
                                     &data, size_memop(size) | MO_LE,
                                     MEMTXATTRS_UNSPECIFIED);
         trace_vfio_quirk_rtl8168_msix_read(vdev->vbasedev.name, offset, data);
@@ -1297,7 +1306,7 @@ static void vfio_radeon_set_gfx_only_reset(VFIOPCIDevice *vdev)
 
 static int vfio_radeon_reset(VFIOPCIDevice *vdev)
 {
-    PCIDevice *pdev = &vdev->pdev;
+    PCIDevice *pdev = PCI_DEVICE(vdev);
     int i, ret = 0;
     uint32_t data;
 
@@ -1454,7 +1463,7 @@ static bool is_valid_std_cap_offset(uint8_t pos)
 static bool vfio_add_nv_gpudirect_cap(VFIOPCIDevice *vdev, Error **errp)
 {
     ERRP_GUARD();
-    PCIDevice *pdev = &vdev->pdev;
+    PCIDevice *pdev = PCI_DEVICE(vdev);
     int ret, pos;
     bool c8_conflict = false, d4_conflict = false;
     uint8_t tmp;
@@ -1547,6 +1556,7 @@ static bool vfio_add_nv_gpudirect_cap(VFIOPCIDevice *vdev, Error **errp)
 static bool vfio_add_vmd_shadow_cap(VFIOPCIDevice *vdev, Error **errp)
 {
     ERRP_GUARD();
+    PCIDevice *pdev = PCI_DEVICE(vdev);
     uint8_t membar_phys[16];
     int ret, pos = 0xE8;
 
@@ -1565,7 +1575,7 @@ static bool vfio_add_vmd_shadow_cap(VFIOPCIDevice *vdev, Error **errp)
         return false;
     }
 
-    ret = pci_add_capability(&vdev->pdev, PCI_CAP_ID_VNDR, pos,
+    ret = pci_add_capability(pdev, PCI_CAP_ID_VNDR, pos,
                              VMD_SHADOW_CAP_LEN, errp);
     if (ret < 0) {
         error_prepend(errp, "Failed to add VMD MEMBAR Shadow cap: ");
@@ -1574,10 +1584,10 @@ static bool vfio_add_vmd_shadow_cap(VFIOPCIDevice *vdev, Error **errp)
 
     memset(vdev->emulated_config_bits + pos, 0xFF, VMD_SHADOW_CAP_LEN);
     pos += PCI_CAP_FLAGS;
-    pci_set_byte(vdev->pdev.config + pos++, VMD_SHADOW_CAP_LEN);
-    pci_set_byte(vdev->pdev.config + pos++, VMD_SHADOW_CAP_VER);
-    pci_set_long(vdev->pdev.config + pos, 0x53484457); /* SHDW */
-    memcpy(vdev->pdev.config + pos + 4, membar_phys, 16);
+    pci_set_byte(pdev->config + pos++, VMD_SHADOW_CAP_LEN);
+    pci_set_byte(pdev->config + pos++, VMD_SHADOW_CAP_VER);
+    pci_set_long(pdev->config + pos, 0x53484457); /* SHDW */
+    memcpy(pdev->config + pos + 4, membar_phys, 16);
 
     return true;
 }
-- 
2.43.0


