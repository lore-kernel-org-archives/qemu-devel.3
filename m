Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05E4DC3DA4A
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2025 14:50:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tklOD-0003G0-8Z; Wed, 19 Feb 2025 09:49:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1tklO8-0003FE-Nf; Wed, 19 Feb 2025 09:49:25 -0500
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1tklO6-000796-Ch; Wed, 19 Feb 2025 09:49:24 -0500
Received: from pps.filterd (m0127840.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51JBqX0u018818;
 Wed, 19 Feb 2025 06:49:18 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=WylXG2VuACek6zvTWwOOVI3eu3kl1mG5PKZWuLrkI
 4w=; b=QdTmCqP6OTH6b8zEW7RyTBLqu12g5i7wDOOvghvivrSPckP3xig2WJ1cU
 u070DuQP1m9ncLnqmPTCjQoRJLD7b/dbbaeWacSCt63+NfHQCKYWTHGng3zDV2++
 HxjNj0cdabyssy2WNsQS1IHZqj2fw0iUJ03xjPKxAEA3YYHONEzn/eUgZlYGEV38
 G7fVvioVsyPmYvhAFU4pz1DXGDp8K5Qr6lqdoGYh4uM6Xf1HIBq363h4PjEDkNJU
 AWVPMsVJDrE9DUcl6x2Pjqf8r2cr73MWB9yeyyxzwsDcU9KsYzr+v0k1/TlqvOwP
 idNTSmZut6EY1tcxk9/oEl/OORgQQ==
Received: from bn1pr04cu002.outbound.protection.outlook.com
 (mail-eastus2azlp17010019.outbound.protection.outlook.com [40.93.12.19])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 44w4basxqq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 19 Feb 2025 06:49:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lxwYFMQCq6LYSMbz5MMXeMvBlcgotoPBmaI68Jf27LuMjAVXTED8pUIOkMCiBIN6tW0bC/87LxXHYD9UMVEeFyIiuwu9vaTr0xf5HFOT2S4TB+iLpOwMl3ffbKTyqY9KUUWSa3AlbPZKOJRDxm504jnpY9F8gOlpmWoNq/vHTGVbj90IBBcE/AO9oE2iZctlaWYWNNdAPVrIGe8/b7AZkZHgilu6S2zFDv0pFV7aeAwadnM0cFsfEYeLzxoLsLT2FJOk6FhCiNjEhUkQeFqd0otEetdAFGv2Unrllj/fPT4AWQcB3pDUun7WqvFTC8NNwqTFrtL+vIeW3jtf4QEyLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WylXG2VuACek6zvTWwOOVI3eu3kl1mG5PKZWuLrkI4w=;
 b=g7BUtPF9qkyZvkd7qJk12H2EvD8AkTxnrmMa7uN4+M7NhlYSOk25fj5TRtr4QdJ955IyeZYZpqkZhUShQBbWIkBZBCQr2gVW8uaOtAw8HbUGT2+IBgwpAl5UDeZwQ9k21OgMHah7zmfo0gFT7FatS5L5VA9Ie71U4tdbEVRFnVVrWKsskH9mZSC9W7lwKZGfXQDml1ossjJMuCAcSQVyw6hqgn8vQl9CTI+vDNznCK1hwaMrbJ+gHvx9cvYlCf3ZmqV2p8GcNanghoFcXoWnsGkt1KWpHLcdoqrK9zLd/TVLtmrH+qMQp1KYHH0PxMwRXQVmb59jYPUGRHKXIGK5iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WylXG2VuACek6zvTWwOOVI3eu3kl1mG5PKZWuLrkI4w=;
 b=HmBbXfN8CVB1QVYNcLHIxM0E35DZA3eVKTi491umHui8jBSsHwq+RFdEfIsb/6hs5aGl5SyWhE2YJ7HtDzzPx1Z356eu62tu4uJ1n7Wll2pGPkZbeaKpujbB127eOY7cyGowrYH1Kz649md/3BXTfpQjSPAVnqQU9Aw7s9+l0sI1lgbw0zbsjCSc4TbGPwvr6noD3YrAHuSSsW1gglOo9PtWEJ6NXEa/PMBtmWtkE2z5bzyDGvknLW5FM6fR7kZ4wBbF3GA/4WQbBls4V/RB/m27u/KU+wvyuI+28WIkQZPysP91usJaBxnDYkrnR6e3ceZBAPwQ1H6A7Dq3FtyVCA==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by CH3PR02MB10559.namprd02.prod.outlook.com (2603:10b6:610:204::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.18; Wed, 19 Feb
 2025 14:49:15 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51%7]) with mapi id 15.20.8466.013; Wed, 19 Feb 2025
 14:49:15 +0000
From: John Levon <john.levon@nutanix.com>
To: qemu-devel@nongnu.org
Cc: Jason Herne <jjherne@linux.ibm.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eric Farman <farman@linux.ibm.com>,
 Tony Krowiak <akrowiak@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 qemu-s390x@nongnu.org, Matthew Rosato <mjrosato@linux.ibm.com>,
 John Levon <john.levon@nutanix.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Jagannathan Raman <jag.raman@oracle.com>,
 John Johnson <john.g.johnson@oracle.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>
Subject: [PATCH v8 01/28] vfio/container: pass MemoryRegion to DMA operations
Date: Wed, 19 Feb 2025 15:48:31 +0100
Message-Id: <20250219144858.266455-2-john.levon@nutanix.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250219144858.266455-1-john.levon@nutanix.com>
References: <20250219144858.266455-1-john.levon@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR02CA0154.eurprd02.prod.outlook.com
 (2603:10a6:20b:28d::21) To CH2PR02MB6760.namprd02.prod.outlook.com
 (2603:10b6:610:7f::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR02MB6760:EE_|CH3PR02MB10559:EE_
X-MS-Office365-Filtering-Correlation-Id: 51ec3733-7726-475e-644c-08dd50f4946f
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?RVHBoTMQ1Eem3eR/A9d2gauubU/g8Ay7wBEWeIQZpWnFpksV2N+VNB34IGgc?=
 =?us-ascii?Q?KvsIS5ZUvxNJkoMKBrMJJIIza++cF6s+WX92QDFdlMUz8R9NZ9M0/T1C9qTm?=
 =?us-ascii?Q?hwk3UGsPAwLSyEstD3vJWNaSGHrzEvF9dFngh0EJMuSH/DPEviDyJPRqOrkF?=
 =?us-ascii?Q?hqjmbLx4oirddFh033xTO+UcUFbAgTcK6F98S6rqcdaQE9WsUpVGiXtY4r6W?=
 =?us-ascii?Q?d5C0VhTTZKAknQTLifzMdAAGMnM9ga6V2CXhRZQls8h8pCtnRC2duJ939PTc?=
 =?us-ascii?Q?mB1ewu4W/EzBaWCKWlpadXd2LXXn8JlqawLdh1XoktAuZgLWYlYqTK6yu6UU?=
 =?us-ascii?Q?V73aZqPHJSDW/zOaSXYClbIBmVanPJyDlMGW1QiknGjF0AGANnfSKsfAnY+Q?=
 =?us-ascii?Q?K+ul/iqWnPRIUewnIpij9EoqPVC6R7fWqmc8Z6hem5KPUUx+Pqb0qUS8KDlo?=
 =?us-ascii?Q?zAEpG8keNFXOrzrmLROorisxxUT4hOfykCUqyJ+Fn8G7g+aSqigY2Bq8O+jE?=
 =?us-ascii?Q?+meAA3XYgCMvBe4e8Z4/kmGW6DGZJUowCTFOPNoJXattbG/Yu9JNV7oISP41?=
 =?us-ascii?Q?P6Krrrbm56Zq9j+43jLP8XriyRfB2oRjhsBcrFnlDB3OWpHOeKWQA4buYWIw?=
 =?us-ascii?Q?CLSO/ccAYsk9509C719rZvR689OaLXIIrns3YqdcfQYlEeXUt5PnWZJRyEDM?=
 =?us-ascii?Q?+KO88hsDJ/uIs4XaQjdO+bfb2T+xrQwbkO/U7Qlx7UQV8jBlRwZt59hUKkJv?=
 =?us-ascii?Q?sqE8iMTyPG9QmNT+i8f/G53tNW5H6sAk7Gg2wODmDgKbf3wSTsxhvVsjmums?=
 =?us-ascii?Q?KYNwpzD5U1IIKe5ZT9TcF1yeCJ/7VVb02lCekJ/T3l2EWoJxTCt6XUWptaHI?=
 =?us-ascii?Q?QDunFVrYP0HYV+EBjm2vk2oqeYZDgJSgL2OhkFQqgc7xOZYYbUS0CcGTMNrF?=
 =?us-ascii?Q?x6HJHgVp7e/Pfyh4+7KWav5I/ZL0bcY/hYckIe83QWsgqAqEoatjz+OQKCyN?=
 =?us-ascii?Q?zTYUmdc+f107xq89tjNsKlhDbrJzmaLT+3TxUqrPe6jMyWansH3yK7wUdK8Z?=
 =?us-ascii?Q?MHkYol+iiMxCgbhZwRS5ETJyHkpusG5EL1mVuh/cB7Us+Ri32hdbip2ZwaAZ?=
 =?us-ascii?Q?LL6B+jgUj0OWbmXTClW45fVQP+u2SQ19RTkK82F/3nIhAPGBcodAv+KnMw5q?=
 =?us-ascii?Q?M22AmDICQNUVU2HIZ1cSL2S3FGIe54sM87ZytdmpJvZWg5nkPbMulM2/kJdU?=
 =?us-ascii?Q?jgSWSr8GhPxe/7wmSSLM3y19GEBvylQD5sTn2WJyRP5eK+PGBk3J44hrkJgu?=
 =?us-ascii?Q?xEPA0X09itpSfyfWF1T26UzH2cWJiHzhG10AmmN7mc5LZZatVGddBbZG/8ko?=
 =?us-ascii?Q?6XmYuE2wDWYLxFWveKxT+d9Gw1ZX?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VUirwcQNfvwXnJC5+wq8/EL8VYBithYK1fWD3GCz9vR29Edcpy9+BFSaW6hT?=
 =?us-ascii?Q?8tzu3nbhT/Cuw8G9X3xt8Q64SnBEHtmCvB+wZl9lF8qZiw0tLhQbSf4DKBwc?=
 =?us-ascii?Q?0Nq/f9cdX+zNF9si6L4/1MG4ugf5ekwILw9EGbNjgu410tGzEaxw7kFTeGRO?=
 =?us-ascii?Q?JFpOZbJzmPCMmd8FDoHvAa/DmM52hq18CpUChPK6sCQsHWc8uuhENAtkIZNJ?=
 =?us-ascii?Q?BqAfB73d9uhSDEhL+3FJJ6srorSA4LEW3SAR/6qzVRjLb8Pkv7MUAZ4p3SIE?=
 =?us-ascii?Q?Diz61TsjJ0s0JqHgGAOG4ccMRAbHduSk7rSDM78Gt3ssfPQjBU9p0C1t4Kth?=
 =?us-ascii?Q?kS13hU9f0GI8I7g5LOSzrlsfC1a1xCmnrokmGJZUh1RqfbzXCYQQwWkh/oYL?=
 =?us-ascii?Q?OSjhJgkTVf+dFxWcaChr0CKekjrYZDmqLh9amGCtvoU84gZqc7CootZtr25c?=
 =?us-ascii?Q?sfSjVbDhV6vNw9dcZ7ZphYuZ4pHlQ1Jc0ZKcuQ7BPhxafzvnJAFwOpETkuZm?=
 =?us-ascii?Q?vsakR83/8nDanRKEQwed/FLZPa6rjLx8B4A+hF1/w81YhXVpBo8rHUG5/cL2?=
 =?us-ascii?Q?V4YExT1TP5voIpJiMaSuSQDmwKsGbyFrVMyaU2m/CmOAQY7YZ2h6xL6YKH2i?=
 =?us-ascii?Q?JgGqguGSwV+t0hI9uGNP8+39dk4AyqzALj8d1JLQ/1+Tpct5wYVZMQRPb5gb?=
 =?us-ascii?Q?+kBKZhXUlLu/By1M3LoLSoJyRz+XyMMA6BB90RX/vYRG/ncHuxoHxgc01Crv?=
 =?us-ascii?Q?SoOXWNp0uxpcsyk8DaoF6qwWFm7nL3Zn1thtute83Lw5b08uPERZskb6Ogdb?=
 =?us-ascii?Q?kHYK40leLi/AEq4y1LyL1x+CLTzJnjHOlNEJRpVP4Il5F1/uXD3TqZZBTN6B?=
 =?us-ascii?Q?abDs6d5hoBVStKsNK/1PMF8UZOXdqXK1wjIevJQR+fipA88Gy3AqMwtRDFw3?=
 =?us-ascii?Q?nLxrDXlOuRWfNgNiWSVtofmU7k9Mf3Tux0W/FIw11S9NDSAnO5xP3Sy54ciu?=
 =?us-ascii?Q?UX3RBJLOqXpOcsXKUVhX5s14Cy4OVU+WtzjpWv0EQ0QmslQ53Ty1OjMWik4u?=
 =?us-ascii?Q?npMGYlb8PN43zbe0ju6WwK4XcQKOD+a00H7HTgpiW8OdDSrYLj2TAYQQLBRb?=
 =?us-ascii?Q?wbPJbXryiS9F8/ef2a6ngpa6OnjJbuRA/RZC/9MeGyOqWsqRKPjniKX/A5xW?=
 =?us-ascii?Q?MX+kE5GP877CR/DNrIECweSCJDUfv56NtdPT0mSktINhxJzp0Q+z9moB4SUi?=
 =?us-ascii?Q?Jhuhg0Fx+eUoiVKXzOrpDyMF9ggcG/mXZx38/dvdlRCi1zf+fBsbTwYK+qw6?=
 =?us-ascii?Q?Yl53MzazZ5F0pwPAqPja0qQMdL1t+O506KWEyr0tMQ/Vtp2JPOjVHmvwgVd1?=
 =?us-ascii?Q?GtrWJPzBU7ls47QyD5FJYBw3H5QDPGDlEjOcuDG6YELz32QrMpm1VC0iI7aG?=
 =?us-ascii?Q?kqsP9UmwsNyhmTWR2LFQPnvNKiloL7moxWJZP+j8mHtbHBvePX/iLThWzzS1?=
 =?us-ascii?Q?HS1ikslpeWrEJTobZXjrEuu8suya7cXZe883i5zG87dU9Div56aVjkAZ+YKK?=
 =?us-ascii?Q?BMRL4H7Hqrj6xSjf2d65kKm4YY/hcQjgDNT3PkqH?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51ec3733-7726-475e-644c-08dd50f4946f
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2025 14:49:15.0885 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yJmdVgZ0yJhScNK+i5FHQIQhHgWQg4FqinbjUq40t5V54LRAAfiryZFtOPdxxxa76lPbnjpH+Prr0c7+nJYLCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR02MB10559
X-Proofpoint-GUID: UjCI9QZtG5i5eKJPhovyrtaK7bLy7wVw
X-Authority-Analysis: v=2.4 cv=bfyRUPPB c=1 sm=1 tr=0 ts=67b5ef6d cx=c_pps
 a=b4GTUaH8bIYRMqSiyTmTYA==:117 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=T2h4t0Lz3GQA:10
 a=0034W8JfsZAA:10 a=0kUYKlekyDsA:10
 a=yPCof4ZbAAAA:8 a=64Cc0HZtAAAA:8 a=DMMBb2U3yOgPCP8cz6YA:9
 a=14NRyaPF5x3gF6G45PvQ:22
X-Proofpoint-ORIG-GUID: UjCI9QZtG5i5eKJPhovyrtaK7bLy7wVw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-19_06,2025-02-19_01,2024-11-22_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=john.levon@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.191,
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

From: Jagannathan Raman <jag.raman@oracle.com>

Pass through the MemoryRegion to DMA operation handlers of vfio
containers. The vfio-user container will need this later.

Originally-by: John Johnson <john.g.johnson@oracle.com>
Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
Signed-off-by: John Levon <john.levon@nutanix.com>
---
 hw/vfio/common.c                      | 17 ++++++++++-------
 hw/vfio/container-base.c              |  4 ++--
 hw/vfio/container.c                   |  3 ++-
 hw/vfio/iommufd.c                     |  3 ++-
 hw/virtio/vhost-vdpa.c                |  2 +-
 include/exec/memory.h                 |  4 +++-
 include/hw/vfio/vfio-container-base.h |  4 ++--
 system/memory.c                       |  7 ++++++-
 8 files changed, 28 insertions(+), 16 deletions(-)

diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index abbdc56b6d..8d3d425c63 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -248,12 +248,12 @@ static bool vfio_listener_skipped_section(MemoryRegionSection *section)
 /* Called with rcu_read_lock held.  */
 static bool vfio_get_xlat_addr(IOMMUTLBEntry *iotlb, void **vaddr,
                                ram_addr_t *ram_addr, bool *read_only,
-                               Error **errp)
+                               MemoryRegion **mrp, Error **errp)
 {
     bool ret, mr_has_discard_manager;
 
     ret = memory_get_xlat_addr(iotlb, vaddr, ram_addr, read_only,
-                               &mr_has_discard_manager, errp);
+                               &mr_has_discard_manager, mrp, errp);
     if (ret && mr_has_discard_manager) {
         /*
          * Malicious VMs might trigger discarding of IOMMU-mapped memory. The
@@ -281,6 +281,7 @@ static void vfio_iommu_map_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
     VFIOGuestIOMMU *giommu = container_of(n, VFIOGuestIOMMU, n);
     VFIOContainerBase *bcontainer = giommu->bcontainer;
     hwaddr iova = iotlb->iova + giommu->iommu_offset;
+    MemoryRegion *mrp;
     void *vaddr;
     int ret;
     Error *local_err = NULL;
@@ -300,7 +301,8 @@ static void vfio_iommu_map_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
     if ((iotlb->perm & IOMMU_RW) != IOMMU_NONE) {
         bool read_only;
 
-        if (!vfio_get_xlat_addr(iotlb, &vaddr, NULL, &read_only, &local_err)) {
+        if (!vfio_get_xlat_addr(iotlb, &vaddr, NULL, &read_only, &mrp,
+                                &local_err)) {
             error_report_err(local_err);
             goto out;
         }
@@ -313,7 +315,7 @@ static void vfio_iommu_map_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
          */
         ret = vfio_container_dma_map(bcontainer, iova,
                                      iotlb->addr_mask + 1, vaddr,
-                                     read_only);
+                                     read_only, mrp);
         if (ret) {
             error_report("vfio_container_dma_map(%p, 0x%"HWADDR_PRIx", "
                          "0x%"HWADDR_PRIx", %p) = %d (%s)",
@@ -378,7 +380,7 @@ static int vfio_ram_discard_notify_populate(RamDiscardListener *rdl,
         vaddr = memory_region_get_ram_ptr(section->mr) + start;
 
         ret = vfio_container_dma_map(bcontainer, iova, next - start,
-                                     vaddr, section->readonly);
+                                     vaddr, section->readonly, section->mr);
         if (ret) {
             /* Rollback */
             vfio_ram_discard_notify_discard(rdl, section);
@@ -675,7 +677,7 @@ static void vfio_listener_region_add(MemoryListener *listener,
     }
 
     ret = vfio_container_dma_map(bcontainer, iova, int128_get64(llsize),
-                                 vaddr, section->readonly);
+                                 vaddr, section->readonly, section->mr);
     if (ret) {
         error_setg(&err, "vfio_container_dma_map(%p, 0x%"HWADDR_PRIx", "
                    "0x%"HWADDR_PRIx", %p) = %d (%s)",
@@ -1232,7 +1234,8 @@ static void vfio_iommu_map_dirty_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
     }
 
     rcu_read_lock();
-    if (!vfio_get_xlat_addr(iotlb, NULL, &translated_addr, NULL, &local_err)) {
+    if (!vfio_get_xlat_addr(iotlb, NULL, &translated_addr, NULL, NULL,
+                            &local_err)) {
         error_report_err(local_err);
         goto out_unlock;
     }
diff --git a/hw/vfio/container-base.c b/hw/vfio/container-base.c
index 749a3fd29d..5e0c9700d9 100644
--- a/hw/vfio/container-base.c
+++ b/hw/vfio/container-base.c
@@ -17,12 +17,12 @@
 
 int vfio_container_dma_map(VFIOContainerBase *bcontainer,
                            hwaddr iova, ram_addr_t size,
-                           void *vaddr, bool readonly)
+                           void *vaddr, bool readonly, MemoryRegion *mrp)
 {
     VFIOIOMMUClass *vioc = VFIO_IOMMU_GET_CLASS(bcontainer);
 
     g_assert(vioc->dma_map);
-    return vioc->dma_map(bcontainer, iova, size, vaddr, readonly);
+    return vioc->dma_map(bcontainer, iova, size, vaddr, readonly, mrp);
 }
 
 int vfio_container_dma_unmap(VFIOContainerBase *bcontainer,
diff --git a/hw/vfio/container.c b/hw/vfio/container.c
index 7c57bdd27b..0db0055f39 100644
--- a/hw/vfio/container.c
+++ b/hw/vfio/container.c
@@ -175,7 +175,8 @@ static int vfio_legacy_dma_unmap(const VFIOContainerBase *bcontainer,
 }
 
 static int vfio_legacy_dma_map(const VFIOContainerBase *bcontainer, hwaddr iova,
-                               ram_addr_t size, void *vaddr, bool readonly)
+                               ram_addr_t size, void *vaddr, bool readonly,
+                               MemoryRegion *mrp)
 {
     const VFIOContainer *container = container_of(bcontainer, VFIOContainer,
                                                   bcontainer);
diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
index df61edffc0..583b063707 100644
--- a/hw/vfio/iommufd.c
+++ b/hw/vfio/iommufd.c
@@ -28,7 +28,8 @@
 #include "exec/ram_addr.h"
 
 static int iommufd_cdev_map(const VFIOContainerBase *bcontainer, hwaddr iova,
-                            ram_addr_t size, void *vaddr, bool readonly)
+                            ram_addr_t size, void *vaddr, bool readonly,
+                            MemoryRegion *mrp)
 {
     const VFIOIOMMUFDContainer *container =
         container_of(bcontainer, VFIOIOMMUFDContainer, bcontainer);
diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c
index 3cdaa12ed5..a1866bb396 100644
--- a/hw/virtio/vhost-vdpa.c
+++ b/hw/virtio/vhost-vdpa.c
@@ -228,7 +228,7 @@ static void vhost_vdpa_iommu_map_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
     if ((iotlb->perm & IOMMU_RW) != IOMMU_NONE) {
         bool read_only;
 
-        if (!memory_get_xlat_addr(iotlb, &vaddr, NULL, &read_only, NULL,
+        if (!memory_get_xlat_addr(iotlb, &vaddr, NULL, &read_only, NULL, NULL,
                                   &local_err)) {
             error_report_err(local_err);
             return;
diff --git a/include/exec/memory.h b/include/exec/memory.h
index 9f73b59867..adaf1d1ca4 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -747,13 +747,15 @@ void ram_discard_manager_unregister_listener(RamDiscardManager *rdm,
  * @read_only: indicates if writes are allowed
  * @mr_has_discard_manager: indicates memory is controlled by a
  *                          RamDiscardManager
+ * @mrp: if non-NULL, fill in with MemoryRegion
  * @errp: pointer to Error*, to store an error if it happens.
  *
  * Return: true on success, else false setting @errp with error.
  */
 bool memory_get_xlat_addr(IOMMUTLBEntry *iotlb, void **vaddr,
                           ram_addr_t *ram_addr, bool *read_only,
-                          bool *mr_has_discard_manager, Error **errp);
+                          bool *mr_has_discard_manager, MemoryRegion **mrp,
+                          Error **errp);
 
 typedef struct CoalescedMemoryRange CoalescedMemoryRange;
 typedef struct MemoryRegionIoeventfd MemoryRegionIoeventfd;
diff --git a/include/hw/vfio/vfio-container-base.h b/include/hw/vfio/vfio-container-base.h
index 4cff9943ab..c9d339383e 100644
--- a/include/hw/vfio/vfio-container-base.h
+++ b/include/hw/vfio/vfio-container-base.h
@@ -73,7 +73,7 @@ typedef struct VFIORamDiscardListener {
 
 int vfio_container_dma_map(VFIOContainerBase *bcontainer,
                            hwaddr iova, ram_addr_t size,
-                           void *vaddr, bool readonly);
+                           void *vaddr, bool readonly, MemoryRegion *mrp);
 int vfio_container_dma_unmap(VFIOContainerBase *bcontainer,
                              hwaddr iova, ram_addr_t size,
                              IOMMUTLBEntry *iotlb);
@@ -113,7 +113,7 @@ struct VFIOIOMMUClass {
     bool (*setup)(VFIOContainerBase *bcontainer, Error **errp);
     int (*dma_map)(const VFIOContainerBase *bcontainer,
                    hwaddr iova, ram_addr_t size,
-                   void *vaddr, bool readonly);
+                   void *vaddr, bool readonly, MemoryRegion *mrp);
     int (*dma_unmap)(const VFIOContainerBase *bcontainer,
                      hwaddr iova, ram_addr_t size,
                      IOMMUTLBEntry *iotlb);
diff --git a/system/memory.c b/system/memory.c
index 4c829793a0..de4f955a66 100644
--- a/system/memory.c
+++ b/system/memory.c
@@ -2185,7 +2185,8 @@ void ram_discard_manager_unregister_listener(RamDiscardManager *rdm,
 /* Called with rcu_read_lock held.  */
 bool memory_get_xlat_addr(IOMMUTLBEntry *iotlb, void **vaddr,
                           ram_addr_t *ram_addr, bool *read_only,
-                          bool *mr_has_discard_manager, Error **errp)
+                          bool *mr_has_discard_manager, MemoryRegion **mrp,
+                          Error **errp)
 {
     MemoryRegion *mr;
     hwaddr xlat;
@@ -2250,6 +2251,10 @@ bool memory_get_xlat_addr(IOMMUTLBEntry *iotlb, void **vaddr,
         *read_only = !writable || mr->readonly;
     }
 
+    if (mrp != NULL) {
+        *mrp = mr;
+    }
+
     return true;
 }
 
-- 
2.34.1


