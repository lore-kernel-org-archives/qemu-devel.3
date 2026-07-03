Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D20BFC43458
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2026 13:55:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfeMo-0002Mu-VM; Fri, 03 Jul 2026 09:55:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wfeMn-0002M5-3L; Fri, 03 Jul 2026 09:55:41 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wfeMl-0006TJ-61; Fri, 03 Jul 2026 09:55:40 -0400
Received: from pps.filterd (m0127844.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6638mBVW2339081; Fri, 3 Jul 2026 06:55:24 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=IH5EZL78YOwW9sdJ+lgxWDyhDvz1ZakojyQzh3XxJ
 6E=; b=m5yNjkQQgDoC4JeNGRjN/gM7gsrnoZDXjp+mpmHLEJuH5qTpKz2LmkPj7
 2HGlNziskPok2rPaXnaOVWBo6l7jUzpDncaFOnNl7LeF8WbHOq1pQLObN8HI6k7I
 zjEwUufisUhHlxghuHNqbHPdrbBlYvHdsuGBwUOGQBAuTTb+PyKIQy9US/xRjJHp
 ICWx/TPhlU5wYE9hF79V96pnBIHWjhYxKRM+F/dG0tYoKdpisUVzyhLiK4X/FFMp
 1i9ItLOpQY+ogxIpGYXMmmJLxLQmM46tkaSLtT2ek8c+0evk/AN2WIYZ8KDbDqOp
 CM1laanWqgATktEYngWQNgK4a6zBw==
Received: from cy7pr03cu001.outbound.protection.outlook.com
 (mail-westcentralusazon11020112.outbound.protection.outlook.com
 [40.93.198.112])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4f69w1rhhm-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 03 Jul 2026 06:55:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ysCo6F7ZG5tq4rTs1GRdRGKXpSKoXC+tP0PJKJCA6+Kxdp0Odqr+v4E32MpRfjqUgeQ7EUFZM1iBChciTyhr1PjUooY85TyRyNAripSlsCRufWW4vl0zkIT9mofPpB6kutEqtfVvMaFDFcot+DltUs5oXkp2Hj960B0+R0yPjDopJ8Xv9xFHWvaKgYHTh/EuaUq18q3g0ENUITwUxjy9j/B4pxrzmdglCGvEshBF1oMa3jxpdB0tlIZ38UPNOj3cmStRoJ0KIR9GEA3hRggcOqRl4fKQq+yvUYnHy1LbKdUzQXEkh9VL9ZwSYH8FOVQtrZReznwwQSTNMJuSNgSsFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IH5EZL78YOwW9sdJ+lgxWDyhDvz1ZakojyQzh3XxJ6E=;
 b=VEKUTQawVPzZAU5uxDl60/lSwLwTFaX9paCAZ7ix/g5TODelIo5ruAexn6OfdBybAMa60tzywgw635s3l6oBu/b1Obgb3rfuaz80ru/mIzAjCToMSD66op7lDzxk1v8fbgQC5drzhZVEu6m+jas/4nwNg5k5i/P9fzWRy4zoVAalhJEgEAOXEQDkz9j0fZGSDlQLyu22J9Eo7JQVDvKfrk9+qqZvveIN6pJY0MCO8tbO5aOumYi6a4iEVHkUTtJItbaR07FY9sUQgnQPW31X28kLHeKM4krm36EgZm8NaYs35GyeCdKwyX0VOMRc6rhRprR2c8amtiqqgVdOxrSvcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IH5EZL78YOwW9sdJ+lgxWDyhDvz1ZakojyQzh3XxJ6E=;
 b=v3m6LXMxlxlyUP54pukysgMcaQd72JGlo1HMoHetjmNLfhRfCc7hSJwD6BFWyo/y4ckoKZZKMc9tYm+q1R1/hUefS1K6mVxFOrhOe4XanE89wn0hSWjG53ob0QRQhLvIsL/EInqZhrcZu6t3F5gBtjOdsIyXD2PMEeN5ARKbkZMeC+vKyqyFV/6ymSRvKLrkclApZAS7XJNFfJ9sCL/v3kxi3kCSXocjKoaOTH3bMiyTbYj8e0QNdBY/CZA3ZYN6h7mETnW2EnlMloNFNpi9Q7VaPaoOSxtlfCbAtUWyxOZAaTRTuOr3iBiucI021JbssYvK5enyjA8jhnnqGTs85A==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by DSWPR02MB11394.namprd02.prod.outlook.com (2603:10b6:8:353::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Fri, 3 Jul 2026
 13:55:23 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%3]) with mapi id 15.21.0181.010; Fri, 3 Jul 2026
 13:55:23 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: mst@redhat.com, imammedo@redhat.com, anisinha@redhat.com, philmd@mailo.com,
 aurelien@aurel32.net, peter.maydell@linaro.org, pbonzini@redhat.com,
 richard.henderson@linaro.org, berrange@redhat.com,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org
Subject: [PATCH v2 02/12] qom/object.c: add
 object_class_property_add_uint8_ptr()
Date: Fri,  3 Jul 2026 14:53:04 +0100
Message-ID: <20260703135512.3213964-3-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260703135512.3213964-1-mark.caveayland@nutanix.com>
References: <20260703135512.3213964-1-mark.caveayland@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PA7P264CA0219.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:374::13) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|DSWPR02MB11394:EE_
X-MS-Office365-Filtering-Correlation-Id: dee30ff0-f78b-4655-718b-08ded90aba3f
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|1800799024|23010399003|366016|56012099006|18002099003|22082099003|921020;
X-Microsoft-Antispam-Message-Info: EhEaV6vO58t52ApSOevMWFSZJINU7kyf+6Okg1GDDQxEV4jaWD2p9FbxzYIELSNjhcvju53R3mDmMHmP4IdfGH8YOcE4jKy+8XXmBUH9TZgtn2Lx5tLwi8yHMiWych/pJ5ibkWW6aCZFvyS0LDQq82wFhbKrzc16/sDeXdb+5oWPaVJNKKyDuLCboDFGlkRRMvSqLD6iR0sMDgIiWeXkgoRXVfgsNrGtO1I+JIoIi8uATXaDRAscQUCpzS1sMvHAWtFRMiIROxqyefepmXbG5hEVPo6Z/ZsbqnAy5HkYjlR/uWiG+o+OgImTY9QCGbKPE+aD4JL41yHl1y8aA2jlFCN5XUkj4XD9CCosAzz4K87RFCYsNdXmaNZ4PbmKDPPLzJJBOS3Pw6q3a1mB63tsgLqQK/AmMLtcCZC5ChnZTPikmcr8JrJAQ/fb3q4JcdDzcxValTMijjLNmRMup1Aeq1PNG9LGahb0cIVwT5uzoN86fWWGSeAd+b0nlb3acOQeSMtgJCpGMLBPxaGIGoFxI0i3nk457DNr3kAAYlyNjdacYyIWbqAJ8GAQ5AIuTINNnkymUbA5LwEj8h6pfYe4lcSA4NEg522z46v27ZO+LRPU4iV1J5wtqVyShfNoxqAUUcDpm6n6PkWiTIRk16bUzI5Z2xQEt+mruH/5geZex1GttWV/CLRVU7mrG0bscmBZvLUMJsMI1dbYd8YwIXyGtA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(23010399003)(366016)(56012099006)(18002099003)(22082099003)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gdZkFY2vBB8uFvEUCUGwFiS6btrh0rRwAENPu/oAvCg+IBykBi7MKzqqLlk8?=
 =?us-ascii?Q?LIsdW1zsAX+LpT4QEJLqcX92me1B0Y9DM3TWixewQy0bOvvC+zyRUAGU2Msy?=
 =?us-ascii?Q?wRr3EPecIo5o0+z5eS65llH48eFFgL+Gd9a18erGK5456CJts9evQQlqwCo6?=
 =?us-ascii?Q?u1D0EkBF8ufJCYMc+MkQwh8lsjmjdvkbNqfZ2PeLx1USLkDudmEHA5PtNKTR?=
 =?us-ascii?Q?dBuTFXdYjSmqbb719YcRW73CQJMz+2Zx5Le3ff+qgZUP5gXqFCUJhVHaWGWm?=
 =?us-ascii?Q?4QsUGiZi+iMTubW9meywTTDe/PrrPn34/8pTZBAyCAZR9mBgp68S9MEegWip?=
 =?us-ascii?Q?1xH/M62a6WTTIEaWuLpEIOldpOJajOB28EtznogZpnuf6L1L/1chxifQ+z3g?=
 =?us-ascii?Q?CViBMRJ+Xqt4UyAUPPmRHLg7BxdL4Ykhq6bdZYQmUVQMd5Lpwjx5thmFE6zH?=
 =?us-ascii?Q?Oo2Lv/8XZfD+R9s7JgLEyg4zeTRzB/kJACQFvQPfb4l2KLL+dFcOwt1F9vhM?=
 =?us-ascii?Q?c29PNTFwiOB9j20SRtB7LqBi0lWofnH9t2+ZL0nnuxxWZveWDRfIcrMJ5n/G?=
 =?us-ascii?Q?L0cCxfM3udV0+blV3GlR4TlEVkxzt/WvXD8wQ+wNx3i6FN1RZYRXekN8AX6U?=
 =?us-ascii?Q?tAjwN1aKVhXLwh9konG1nXf21qYbQNDAFKgTFw6sS+ZCOmIjXSvHuiBq2BRx?=
 =?us-ascii?Q?mh0VI7xLtq7Yz/txthTY2AdXL5yfCrvaKIcUctczaTLM2GuqNeF/IdfDKIUu?=
 =?us-ascii?Q?737jVUbXAdnXOztQbVxzpJYInHTukFdZYrN4dDiDdaHJ7JH9wDcInvZO1nwp?=
 =?us-ascii?Q?D7LQ7wIIz/A1TRu09NUYm5f9PO+/IhSfJZ9SWXrShKLzAu4229fZmZFXWJor?=
 =?us-ascii?Q?a3/Vhtvi2Lr1E5s+2Eb9+YOOZjEi/93WQZD5h0d8oNRNQWL90oa18fiess8P?=
 =?us-ascii?Q?f9FOmyN/Nv8rgVWszelisPRPssid78t/dMmLVOhSTz9AfEmlqI7H/xxAg++a?=
 =?us-ascii?Q?LcgniFekdQ4jLSHGGnq4I0c7mmJPOWxVfhyj0M6WJnvd+ValyMOLioLMyzeE?=
 =?us-ascii?Q?1MSLxzg1mrtHyrSU5oow669kRRrTtm7HBnbvQPRYRAtzzlFEHFrLqgMliV+i?=
 =?us-ascii?Q?DJo+GGyeCXOhjATSmWw+QCNmzUudI/KENtTrBt/EsAPCuUWxcQcbmGDlYj/t?=
 =?us-ascii?Q?+yhQuGP7oA2lW7WVlJ9ZmWSkZ8TWVy2dxUzKrMSH73oVD7fIGdohVp0OBEVu?=
 =?us-ascii?Q?Jy3yE9pJGMRpRuivpXRwzWXOyo5M5Qa3Z8zhJN31mbzGoCsRLr3nBSb8UzX/?=
 =?us-ascii?Q?wvSb9E6rrMllH+/Wq+cySj529+io0930gKQYJhmUuE1EnsQ++8ntIL44pNbK?=
 =?us-ascii?Q?znx2RD0cEZEipb+LBcdoN5j9fWV9+u2OcDaGAm2JFH6ieP2s9VP7U9wGiT9F?=
 =?us-ascii?Q?OR0uBhOsZ+lfx4Uj+f1NjM2O0VSQPcF73hBM+9w4vNgu6hv/FovyXfxWKFkE?=
 =?us-ascii?Q?YzbkweVTCrlOHOX8tggsW60fdqoqblDTH+Dk4KA/E7iTrVS8TK8hxXBHZaBl?=
 =?us-ascii?Q?xDAqg2+udytx/ssiA8qdNIb20wE5OhprCSvEBAL9yaFYcrYS8RUlX/g1cnRW?=
 =?us-ascii?Q?+5KObqr/PivmWqZ8sUUScIhMzz7FNX0idnY1xIrBpC+lBtzxgBE8NO9n/WCZ?=
 =?us-ascii?Q?EKgyFz3kLIU/NDkYCx4y2U5R2FQd8T5VxHJ1Xx/FlS0uWOwNXoKyKmIlU6NL?=
 =?us-ascii?Q?o7ZU5zexwalDk9Crj9qsl+xiPcAoySE=3D?=
X-Exchange-RoutingPolicyChecked: BJL09nIG823cxWJoxwhzOJlisC5gLyLdEm7lTtE3qG4YM7D4pxoqpLj5AFjDHH8r2RBw7s0WEXnEnbX8y+zjb5XjbCG2RKmpCeJnCBkrVE7SUvhRJUcJ2Dk0wkvKdvMNbHMKDeAmTHUTtquRV2oiA8ViaeDX3AqVIecE+XXw0oORVQ+Jf+F6fyXiSIuiD1E2GfqxpRgHCqe1uUjnfeG3d+qZMp4b2/Pckmy7g6Dp8A69zBBvSlNqIDxSSArhaaxjmQsHgZ2MgPOqAGsuUJ6GYVDsSMQJ5JdzM8KPNISNmFsBIasKt679wphpLvd16OKa4ni2NINytHpIuqcTwuzk+A==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dee30ff0-f78b-4655-718b-08ded90aba3f
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2026 13:55:23.3255 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9JNNJDSp269z07ON/+ulAidCcuW0Rz/cZnWReS3ILyhp9Epjfdv8YmLtrtAy3MX2huW1zTAIdxAzJS2HFtdWYJPYtsQlLYE3v/hHW9RUrHk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSWPR02MB11394
X-Proofpoint-GUID: PkwOXjDg9m9ktTtLYuZzrJ4W-twnjWPz
X-Authority-Analysis: v=2.4 cv=dbWwG3Xe c=1 sm=1 tr=0 ts=6a47bf4c cx=c_pps
 a=waeEY1lgPsvMgfEg+IY2ww==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=RAioF0-LDSMA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=0LlEyIVc8U2lsR7dKhuH:22
 a=64Cc0HZtAAAA:8 a=4QfE8SPBBHYfMhEiUa4A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDEzNyBTYWx0ZWRfXzTsZSiD9ee+g
 wdhzzHj3KLtr0WD8cZ/nWpsWCr3UmY52f/V5lxor+N2akSBKeFKW8s4WCEZN3o+gpmSsgXQRgqs
 gt1wG94LCmb+IoIFcdj2u2ZWPrkiuJg/Kb7w6SmTstCT4dNHqrViOzCduWVC3vXLVZUnzzc73U+
 2hJs65JivT7eMKuuCs4SPRTlFWvucVZo/+/9lvAA0R5rsOYegGBJz9/X0iSv2l4knb14+yc8HcT
 UTfkyRg2D80b2O6yt9S+xbWbPO9qZmApdWZE29MyBPXQTBjSCq2tpUIo6ESc/arQnT6dIRGuFPb
 kQH/Wa4TJf8okVfGpUQwBPq4/DEIEqMQnM5BoeKoJZANZA2wS8s7h95+0GMM/Bx7BugueGHrs8V
 LiVAQoaDeLKperYfbzfTt1CE6dIXa4paY34FbAdLf5oG9HL/Yq46nCEp28QbHEsH2kLD/q9h7x8
 oIUwaouYEnibIkCBpnQ==
X-Proofpoint-ORIG-GUID: PkwOXjDg9m9ktTtLYuZzrJ4W-twnjWPz
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDEzNyBTYWx0ZWRfXwFytgr1ebNDs
 xQwkndoJSXQWTOUo1b54ftGUnWGh5SX9zuKbnSrOwNT/FdHJs/NmL4dNk7cG4/h+WaZIjvM7OFC
 Dg9c3NijgaKAA3hoVuIfFYCBfku42Rw=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

This adds a class property that references a uint8_t within the object instance
and is intended to be a replacement for object_property_add_uint8_ptr().

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
---
 include/qom/object.h |  5 +++++
 qom/object.c         | 52 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 57 insertions(+)

diff --git a/include/qom/object.h b/include/qom/object.h
index 89c23d45ab..a55f9d0e97 100644
--- a/include/qom/object.h
+++ b/include/qom/object.h
@@ -1956,6 +1956,11 @@ ObjectProperty *object_property_add_uint8_ptr(Object *obj, const char *name,
                                               const uint8_t *v,
                                               ObjectPropertyFlags flags);
 
+ObjectProperty *object_class_property_add_uint8_ptr(ObjectClass *klass,
+                                                    const char *name,
+                                                    ptrdiff_t v,
+                                                    ObjectPropertyFlags flags);
+
 ObjectProperty *object_class_static_property_add_uint8_ptr(ObjectClass *klass,
                                          const char *name,
                                          const uint8_t *v,
diff --git a/qom/object.c b/qom/object.c
index d10bf848c0..263c313cd2 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -2741,6 +2741,38 @@ static void property_set_uint64_ptr(Object *obj, Visitor *v, const char *name,
     *field = value;
 }
 
+static void *object_class_prop_ptr(Object *obj, ptrdiff_t offset)
+{
+    void *ptr = obj;
+    ptr += offset;
+
+    return ptr;
+}
+
+static void property_class_get_uint8_ptr(Object *obj, Visitor *v,
+                                         const char *name,
+                                         void *opaque, Error **errp)
+{
+    uint8_t value = *(uint8_t *)object_class_prop_ptr(obj,
+                                                      (ptrdiff_t)opaque);
+    visit_type_uint8(v, name, &value, errp);
+}
+
+static void property_class_set_uint8_ptr(Object *obj, Visitor *v,
+                                         const char *name,
+                                         void *opaque, Error **errp)
+{
+    uint8_t *field = (uint8_t *)object_class_prop_ptr(obj,
+                                                      (ptrdiff_t)opaque);
+    uint8_t value;
+
+    if (!visit_type_uint8(v, name, &value, errp)) {
+        return;
+    }
+
+    *field = value;
+}
+
 ObjectProperty *
 object_property_add_uint8_ptr(Object *obj, const char *name,
                               const uint8_t *v,
@@ -2761,6 +2793,26 @@ object_property_add_uint8_ptr(Object *obj, const char *name,
                                getter, setter, NULL, (void *)v);
 }
 
+ObjectProperty *
+object_class_property_add_uint8_ptr(ObjectClass *klass, const char *name,
+                                    ptrdiff_t v,
+                                    ObjectPropertyFlags flags)
+{
+    ObjectPropertyAccessor *getter = NULL;
+    ObjectPropertyAccessor *setter = NULL;
+
+    if ((flags & OBJ_PROP_FLAG_READ) == OBJ_PROP_FLAG_READ) {
+        getter = property_class_get_uint8_ptr;
+    }
+
+    if ((flags & OBJ_PROP_FLAG_WRITE) == OBJ_PROP_FLAG_WRITE) {
+        setter = property_class_set_uint8_ptr;
+    }
+
+    return object_class_property_add(klass, name, "uint8",
+                                     getter, setter, NULL, (void *)v);
+}
+
 ObjectProperty *
 object_class_static_property_add_uint8_ptr(ObjectClass *klass,
                                            const char *name,
-- 
2.43.0


