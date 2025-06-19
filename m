Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 013D3C7115C
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Jun 2025 13:36:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSFNh-0004HM-PS; Thu, 19 Jun 2025 09:32:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uSFNe-0004F0-2w
 for qemu-devel@nongnu.org; Thu, 19 Jun 2025 09:32:38 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uSFNZ-0008Ea-6W
 for qemu-devel@nongnu.org; Thu, 19 Jun 2025 09:32:37 -0400
Received: from pps.filterd (m0127838.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55J8A062013187;
 Thu, 19 Jun 2025 06:32:31 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=OAko/TheJzo+jExbY7mQx1qoRlsB8FX27i+Yx++LB
 MQ=; b=sZGoVnWe3Rjq4vcadU0eaGxdd0FMVucO8fosXGfVCAc+ZT/crYZtfZhRO
 3LBbSbxkLguR/cXXJsIi2bajV4czI4iB/8ugbw4rXwiLPJcRJ6IKJLxtVETgOwFp
 L8/+WkPZJXscojV8tdj+Z0eZhKYLxtwvBJEntqYWXF6nvuHdmmbR/UVviFqkpkNm
 XcH5LbtlrJABzf/YrsDYCyNrrz37mk457MLg6hG8w14kk0EIMJ5/DnN3Rd8v/29t
 i5vmMtcN1Sto1B6xrmPTEzdcsYqmRRDeDdug4ruZRVUycEALYWc5mutG1wu7px1w
 E4D8wSa6tW4G4vfCvQs3ZF3Yxyv5w==
Received: from byapr05cu005.outbound.protection.outlook.com
 (mail-westusazon11020121.outbound.protection.outlook.com [52.101.85.121])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4798mykwq7-6
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 19 Jun 2025 06:32:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AQ4vaLbPEEcYxKGU9HzNJZz/F2UcXOW4FFXZ80htZzlmpfavLlHRLbm94SBFEW4aTYesQnYoY5vr2cTXQ/WSM1iXzUS60G7rWnrXMDw/XrwDKOSlQ7/HctjGwS+cWbCA7v33IysJ+9qfoytABCU59XFRsBCEJThcZNtix5t9Swip4OKWEmw5ElfyySA6htOKt0JlJjhQzzgvgzRdEy1ZmX1rKIMDhYdSOVtFilR4Ht6GmkFGo7tHj8UDG6H6cJ7gjtOTAKwfrTrG/OANV9lXezmkwNY+DAU4zHEHpfa3ZwOUQNPTeRRY8h/aTxw8JpcvFeXN44shRhuxMPPY6Tp+jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OAko/TheJzo+jExbY7mQx1qoRlsB8FX27i+Yx++LBMQ=;
 b=k+4+ybRO0zp1f1fjXSGw/MVPSXrddrFl5LeG/H6e5rvmHGWnIFMB/WKPG8GoLNH/KQQtbyHlNOFWOKHl0xeJwWX/YyS+kt5sR50U/+pl5LAhOPbz3ah+CtebT6vbRp8jtKJH7IaShi27lXwtjg/zL2z7LJvoia0TSdf5N59BWu6tawraTY++F6NV+/obU7iXdFf+sxMFGs9ahIC2u1DygICz2uzv5Swyfozla1WNGkqgsxPLV9VYe7bEoMYLB6mrkNzMnZanTV6a3w3jtU4KbU1YJExrksXOrrQBG2uV+ek2gKAlbQmWz161oNbM8qlNNa/s2a/J/X80pSygvBNnyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OAko/TheJzo+jExbY7mQx1qoRlsB8FX27i+Yx++LBMQ=;
 b=nc3A7ySfASC0JTKcAF/an4ij3n6RGDgzYTQXISs+7wQ1QSLjj3grZQ2tm3IQkCLXOS/RDCbHKrpQxW4t9LhjNS02uzg11aWVroLJ5gap4rtzzzPNFszYnl11lWBhzd0xSj5yUYzWSTs5RZMRiy7E7nG1jPjKIVbWXPtpd5d69NUVJcWhLpBvtmtIGkszyHfLz/3XpgbreIUi1/BEz0x8I2lmIkudJe2fGyhSGpUKNdZUHzb15BTfjncSTafJjKz9y14HHdJqD1Z05tmeCUDifV8c/7hrUVwwBH/m/toSYrxcg1q43k8V8pXwiFOfk9ty7+V7RmwycPqpoA7sV4jnzw==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by PH0PR02MB9383.namprd02.prod.outlook.com (2603:10b6:510:289::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.19; Thu, 19 Jun
 2025 13:32:26 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51%2]) with mapi id 15.20.8857.016; Thu, 19 Jun 2025
 13:32:26 +0000
From: John Levon <john.levon@nutanix.com>
To: qemu-devel@nongnu.org
Cc: Thanos Makatos <thanos.makatos@nutanix.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 John Levon <john.levon@nutanix.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 John Johnson <john.g.johnson@oracle.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Jagannathan Raman <jag.raman@oracle.com>
Subject: [PATCH v4 11/19] vfio-user: set up container access to the proxy
Date: Thu, 19 Jun 2025 06:31:45 -0700
Message-ID: <20250619133154.264786-12-john.levon@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250619133154.264786-1-john.levon@nutanix.com>
References: <20250619133154.264786-1-john.levon@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO3P265CA0025.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:387::6) To CH2PR02MB6760.namprd02.prod.outlook.com
 (2603:10b6:610:7f::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR02MB6760:EE_|PH0PR02MB9383:EE_
X-MS-Office365-Filtering-Correlation-Id: 60eb8384-cd29-4cbe-7af4-08ddaf35bad5
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?YgJyDDTrYcRTTIRC3qktHs5T4xZa75k1SjzuxyDx8FiLxPe+lgwZbOohL6Wk?=
 =?us-ascii?Q?PeJWCJ7ZjltChydKONP1JZRN7i2RkXjqvkSo7OUHiKVhmhUkQvAzTQPmqPwP?=
 =?us-ascii?Q?h/piQfnfzkt8QgqH2JBKjy2XbTq/lzHsTzBhs3fcqcmVJ3TwM7h230suh/9A?=
 =?us-ascii?Q?aGcrCKVauhY9yPe6Rm3Ccj6s5qfaUNuaeQf3WZmrwuNQ0QH5yfDwJUxflhYo?=
 =?us-ascii?Q?moldQuXumZoinIfuWj3Qs6X9SR7uJFFwJW8DJPx+lhcthwJpyQ8vV3Kt/RJ9?=
 =?us-ascii?Q?Ksomk1JnVeM8DpBVA4WvCPQ2eS7NyLKKCM0LIh/m3uPToDoAnbWn9OQ+7qyI?=
 =?us-ascii?Q?txnxmBgKX5x1S8lumj2wZKXB4v7moCG8nwKAH2RpibiGSkuP92WIizzvFvgw?=
 =?us-ascii?Q?jT90d5VGClYtb229jPcwVMJVRYaZO4uIvZt1rTg8vHTFT0pLgmA0h7Zz/Ukh?=
 =?us-ascii?Q?nPhW1/iHaSdM3K1HK9iMd7z9Xnfu4UiofEKdrPBQS/RthkOzC3tEXhtaD8+C?=
 =?us-ascii?Q?BqTxT6nnJMJqHthXy/HHnaWItWbofVYMwHeRt1/l+3mqBZd1b8GDKgUy4XGZ?=
 =?us-ascii?Q?OhLDK0yR8+AAXWNWErNa+5vzQUCa0vM8OVeoqH3eE4OCqpZZEpgStOItJiE7?=
 =?us-ascii?Q?JrMFUDa+farIYkOhX4I5oWYiwAAXQctfkWPwy7tXJXRjmQ5f7mZpckBNqC9d?=
 =?us-ascii?Q?5tTEt+4tqsnEJjyf/IsdwnBfpjAW+Obj21x1oPiX9f0uhL83MqwQ09UqYfdb?=
 =?us-ascii?Q?HUO1vgiHgE7rfTVJt7KIEjlmJ+2bb6N4+HTuJsKyh1ddZv28oc5SAiyETDm/?=
 =?us-ascii?Q?SvQfhlFY/8MeVCEe2kM5lzT8p5FxnqqGZkYVvPDGupgbQm2jMAJtTqSXZ19n?=
 =?us-ascii?Q?kF0ev9A1LqaZ3pz4QN9vaFqJYxhXCXi0Wabt4JydG8t40dUKSP2SNquXZz/9?=
 =?us-ascii?Q?WEAe0XuquWbA+zi6aO1IY5smbgxc0cDRGLugj5uwGt2fUk/WdrNIsJzDs8hr?=
 =?us-ascii?Q?3gNMmHitBBpudH4Y09qk2X2wlxBIDxF05HERc1W2FzDnYvSfq+lJPUF+Mb/m?=
 =?us-ascii?Q?xPi4UnzQLCc82HwqxxpmahRcHaiW8XM2C27r8pVn7Np4Z8mKTTXHzkdbZ3kq?=
 =?us-ascii?Q?WPIu/IoAnfu0Yu6IvID4C0RzEPaaFqegdCISV9HNrULV4C43L5miM3NLw9B0?=
 =?us-ascii?Q?Ys7AZU67/+b53uNSQO+NfYRMF6erskyjqbEHlx8T4JdAVuPHESf/+S3luaDZ?=
 =?us-ascii?Q?L5thPTpgS6zR2jVRV05ldC8jnd1wOmvYNXb6r5aXZV1OSvF6qHtVcU0SBgtI?=
 =?us-ascii?Q?HndvWBNLEaSBUTwUPP4e070QQ3DYoNaX6FL3Vfb3XzLTzHr/yVawJzvnc7vk?=
 =?us-ascii?Q?rntnnVuRfQu0mc2lI647z7duu8OXOk8ceHHKZ2mCMJ4RZVeOs+kPBdSVqK+X?=
 =?us-ascii?Q?eqWM8iCdZgc=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(366016); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?L4CTOr6xBmDjxGLFsBByCK8faDYlIYPrD5PRnxBtcXmeSrDhCSfda5vg5okb?=
 =?us-ascii?Q?T1lwRxykfB9AjELcRVOYNsNiJCLWTKWNoDnuFthen0+oVQRWk9KV5I5Dniic?=
 =?us-ascii?Q?Ll/3TPGvBTK4n0A7DVpk5zBCBUDAU9vSFAK9YuvPoPxUBDzhKQzm9CiPuRUj?=
 =?us-ascii?Q?XC5YaDSxDNm7NLEe6LpUcT8AT/GMKKs+UXMiA+Vjl5oOMEkxFku8Rxxx9DmM?=
 =?us-ascii?Q?OCN78pv3UMHKaey7zcmBYbP1eIgFA0Q+Vxcbt7+m7NOavDddmIRrF/SqTAv5?=
 =?us-ascii?Q?M2t/62UWu047npUH6AkXCbwGpknUdj3lUM1xrs82NDihMMxYInLJTd+acRAY?=
 =?us-ascii?Q?1br2KvaCFima/EO7nFUM3sYhFADRnZ2tnRcjKZUCFLAkYPXJhRE0mXnKLRFD?=
 =?us-ascii?Q?REYfO3q+twT23w2SXGn1D74Sm3MG7V5bcvF0mWN3RlufWhFjzO3/AcDYEdzy?=
 =?us-ascii?Q?hSDutRANpJuG6Tuq/DaV1OYzatOgpAfJnmMDFq35ooBd5QuUZlfPwKfaUsnb?=
 =?us-ascii?Q?Ow48nLtZRliWJkC6XvAikCxTjVq1M0IWekSZhgg3kVBoxVGNT+GsIrKF++ou?=
 =?us-ascii?Q?p32OZGC83sqV3LDLRydLoAYSEWoRnBPZ4zrHvpOkrosgmNhfh2Fl0YKOKZ2L?=
 =?us-ascii?Q?El5QhRwxVpRhz93nS0/pnMBTFSRwNF8ubvtTC0vRj2fm1Ily1yF9E5BrgaSn?=
 =?us-ascii?Q?+gDNkZ79QUvKHpmglwDVKAiVi29WsQZh633Hks5NqXT1h3Nd18xD+WC31ZU1?=
 =?us-ascii?Q?0iJBPW5bA44g+VoLw8MxO2rQCmFzbRXxsKXmMTZ2NFQ8w8B/7H5SaXn0CowP?=
 =?us-ascii?Q?vrJQao5IKlh57YX7FbnlTOWXrhO5C3jEtlzrwqTq+ZhvBM8/s+6dw353afO3?=
 =?us-ascii?Q?6n8QeBR70R5nYDsj+geft8dV/pw6wKU5yMvdGmCbagLiquw2eyeaviuGDHqK?=
 =?us-ascii?Q?+YdmKayddmNgAiz84tyYVmN6Ur3iFmM/1DOUWdKQOzRLZAtn9xaSo9FFf9TI?=
 =?us-ascii?Q?hFW3L2flGnRYcvgsqsjLC89Mfc7hAAvQfmhB/QrrGlsu9TL2DiPyTR9N7kNk?=
 =?us-ascii?Q?C2GngXK/MtpDt3m5ELLI9DZzw2bSY3+edclmVHH/UyUikPqwVgnfZeKi6rLl?=
 =?us-ascii?Q?c8m4dp7IieJJJ+c3q9sPxFzcHp5aieoUTs3nOopv9bFwZNXVxBDMOs+YeHLh?=
 =?us-ascii?Q?C8Jh7qWxEz1JH4ZdcRx143jDkJIwcHxEOqqqPhuu/KG47glFYLjNwugrltTY?=
 =?us-ascii?Q?vSVWMpgr9fFNwz+3zOR7UjyRQfI8I28CZ/jbv5LxHjMt1Ki2j73RJk4eUdHk?=
 =?us-ascii?Q?sLZ1lDfpyWb29Ve+Vkq6sE9IlGbfrl0JC0xgGp0cp3ijF8zXlMuNiRb4HDFA?=
 =?us-ascii?Q?5HfOxxCx6GYixJusVuvPDTXl2HQZ7ogJmIn3O/78pujETdIxwyX6CUkvoVwp?=
 =?us-ascii?Q?3faiuUeyqTgSn7m+r1URecdjczgrcTsYT1gaLvHR8sYrHvND5q/kCZzFeZRp?=
 =?us-ascii?Q?dKYEo43kWoLP9q5tZ4WABXnE6sSSu38g/imC56a/XLPdTbqE4Xx6ou5r5Hn7?=
 =?us-ascii?Q?PZ+NQryY7+tbxogZBi5OdaYO1B4D+veZ6pLvQ45f?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60eb8384-cd29-4cbe-7af4-08ddaf35bad5
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2025 13:32:26.2353 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QjLDyXK34r/gpOeIH/cjZMVp3QL2jhxhqITAfnBefzVKI+v2Q29qmuQSE3aAGCrGvViTIuVQwnuikA+JkF/L4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB9383
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE5MDExMiBTYWx0ZWRfX6+DBhrQ8FH33
 +LjkPez1KFy6+nv1MU9+VtAOyEnkzUs/xHubGfPl2g/Ora45fZqMghUyGt9YISwMGmr/gSey38k
 Udp3JbLPHYNEgYgUe6vHPYSa7xZYEDLDiLLdlXfZEkQF5sSe3TnrSmPQXQAStCeXphaCqaFTjkH
 cKptEpXJtCFNNZyGzUys+2knSWAtNSnLgo+KAAI9abPVRnFiDjjT7gSci5W3LjMWUd0kg3xgNyn
 GpBmNbfp2WYgZY8u9vpa7pCLHFLNQ0Ak3uQCTvOcQaz4n567MKxWzgBcWDuQwSM+8woF+fHbPkj
 QsbxY0QWp3LRh/W93p1weGcyBa4JC4cdV0g8w/To6OGZqcLDqINmLBf/P7vyxDXPD/25V22CQ6m
 Vaj5acu6JOoqjLWU6D3AU75Lps0I5pPOR7qL+CvL0flSsH5w/li/s4t1XBjKBLMQdn5YmdYM
X-Proofpoint-ORIG-GUID: zDg-rph7kgY659cf1JE-NrII6GqdavAv
X-Proofpoint-GUID: zDg-rph7kgY659cf1JE-NrII6GqdavAv
X-Authority-Analysis: v=2.4 cv=LIxmQIW9 c=1 sm=1 tr=0 ts=6854116e cx=c_pps
 a=Yi5XoY1Pvk1/bV4Hj+lk7Q==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=6IFa9wvqVegA:10 a=0kUYKlekyDsA:10 a=yPCof4ZbAAAA:8
 a=64Cc0HZtAAAA:8 a=7VGmajfop4gqLxerqI0A:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-19_05,2025-06-18_03,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=john.levon@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.897,
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

The user container will shortly need access to the underlying vfio-user
proxy; set this up.

Originally-by: John Johnson <john.g.johnson@oracle.com>
Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
Signed-off-by: John Levon <john.levon@nutanix.com>
---
 hw/vfio-user/container.h |  2 ++
 hw/vfio-user/container.c | 43 +++++++++++++++++++++++++++++++---------
 2 files changed, 36 insertions(+), 9 deletions(-)

diff --git a/hw/vfio-user/container.h b/hw/vfio-user/container.h
index e4a46d2c1b..2bb1fa1343 100644
--- a/hw/vfio-user/container.h
+++ b/hw/vfio-user/container.h
@@ -10,10 +10,12 @@
 #include "qemu/osdep.h"
 
 #include "hw/vfio/vfio-container-base.h"
+#include "hw/vfio-user/proxy.h"
 
 /* MMU container sub-class for vfio-user. */
 typedef struct VFIOUserContainer {
     VFIOContainerBase bcontainer;
+    VFIOUserProxy *proxy;
 } VFIOUserContainer;
 
 OBJECT_DECLARE_SIMPLE_TYPE(VFIOUserContainer, VFIO_IOMMU_USER);
diff --git a/hw/vfio-user/container.c b/hw/vfio-user/container.c
index 664cdf044f..f7c285ec2d 100644
--- a/hw/vfio-user/container.c
+++ b/hw/vfio-user/container.c
@@ -49,15 +49,28 @@ static int vfio_user_query_dirty_bitmap(const VFIOContainerBase *bcontainer,
 
 static bool vfio_user_setup(VFIOContainerBase *bcontainer, Error **errp)
 {
-    error_setg_errno(errp, ENOTSUP, "Not supported");
-    return -ENOTSUP;
+    VFIOUserContainer *container = container_of(bcontainer, VFIOUserContainer,
+                                                bcontainer);
+
+    assert(container->proxy->dma_pgsizes != 0);
+    bcontainer->pgsizes = container->proxy->dma_pgsizes;
+    bcontainer->dma_max_mappings = container->proxy->max_dma;
+
+    /* No live migration support yet. */
+    bcontainer->dirty_pages_supported = false;
+    bcontainer->max_dirty_bitmap_size = container->proxy->max_bitmap;
+    bcontainer->dirty_pgsizes = container->proxy->migr_pgsize;
+
+    return true;
 }
 
-static VFIOUserContainer *vfio_user_create_container(Error **errp)
+static VFIOUserContainer *vfio_user_create_container(VFIODevice *vbasedev,
+                                                     Error **errp)
 {
     VFIOUserContainer *container;
 
     container = VFIO_IOMMU_USER(object_new(TYPE_VFIO_IOMMU_USER));
+    container->proxy = vbasedev->proxy;
     return container;
 }
 
@@ -65,16 +78,18 @@ static VFIOUserContainer *vfio_user_create_container(Error **errp)
  * Try to mirror vfio_container_connect() as much as possible.
  */
 static VFIOUserContainer *
-vfio_user_container_connect(AddressSpace *as, Error **errp)
+vfio_user_container_connect(AddressSpace *as, VFIODevice *vbasedev,
+                            Error **errp)
 {
     VFIOContainerBase *bcontainer;
     VFIOUserContainer *container;
     VFIOAddressSpace *space;
     VFIOIOMMUClass *vioc;
+    int ret;
 
     space = vfio_address_space_get(as);
 
-    container = vfio_user_create_container(errp);
+    container = vfio_user_create_container(vbasedev, errp);
     if (!container) {
         goto put_space_exit;
     }
@@ -85,11 +100,17 @@ vfio_user_container_connect(AddressSpace *as, Error **errp)
         goto free_container_exit;
     }
 
+    ret = ram_block_uncoordinated_discard_disable(true);
+    if (ret) {
+        error_setg_errno(errp, -ret, "Cannot set discarding of RAM broken");
+        goto unregister_container_exit;
+    }
+
     vioc = VFIO_IOMMU_GET_CLASS(bcontainer);
     assert(vioc->setup);
 
     if (!vioc->setup(bcontainer, errp)) {
-        goto unregister_container_exit;
+        goto enable_discards_exit;
     }
 
     vfio_address_space_insert(space, bcontainer);
@@ -108,6 +129,9 @@ listener_release_exit:
         vioc->release(bcontainer);
     }
 
+enable_discards_exit:
+    ram_block_uncoordinated_discard_disable(false);
+
 unregister_container_exit:
     vfio_cpr_unregister_container(bcontainer);
 
@@ -124,14 +148,15 @@ static void vfio_user_container_disconnect(VFIOUserContainer *container)
 {
     VFIOContainerBase *bcontainer = &container->bcontainer;
     VFIOIOMMUClass *vioc = VFIO_IOMMU_GET_CLASS(bcontainer);
+    VFIOAddressSpace *space = bcontainer->space;
+
+    ram_block_uncoordinated_discard_disable(false);
 
     vfio_listener_unregister(bcontainer);
     if (vioc->release) {
         vioc->release(bcontainer);
     }
 
-    VFIOAddressSpace *space = bcontainer->space;
-
     vfio_cpr_unregister_container(bcontainer);
     object_unref(container);
 
@@ -165,7 +190,7 @@ static bool vfio_user_device_attach(const char *name, VFIODevice *vbasedev,
 {
     VFIOUserContainer *container;
 
-    container = vfio_user_container_connect(as, errp);
+    container = vfio_user_container_connect(as, vbasedev, errp);
     if (container == NULL) {
         error_prepend(errp, "failed to connect proxy");
         return false;
-- 
2.43.0


