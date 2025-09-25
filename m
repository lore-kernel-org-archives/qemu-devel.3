Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03262CAC5B1
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Sep 2025 16:06:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1oTC-00020B-6Q; Thu, 25 Sep 2025 12:05:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1v1oT9-0001vz-Aq
 for qemu-devel@nongnu.org; Thu, 25 Sep 2025 12:05:19 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1v1oT1-0008VR-E0
 for qemu-devel@nongnu.org; Thu, 25 Sep 2025 12:05:19 -0400
Received: from pps.filterd (m0127844.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 58PG3tea1101638; Thu, 25 Sep 2025 09:05:03 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=SSCgafJ4TKOGSfq4Lhfw5X/N7e2vLnVKUePiY1Tcm
 PY=; b=nhshG22K+rnnBmkYpziyU9woYPYMLeYjAHX3pliYKJ5nB7H1b8/H0Bukm
 i2GeVdLUD0FAtDaweRdGqVHPsW9P7IlWZJJ4+kPKIaIpBmG/Gcnzo+ajUiGtOojR
 OB2iqYDYIF2IthtjlpK59qSAtgc6a/vUV0ugh58XhJQt3iJxKyjGDqUPu778KC3Y
 Ut5NMswwAWw5dwGC57YgcpZcHHfm6DYsyQwmphoftWogmSfKDgZTNiNZ2HavikW2
 ekVuYqMztXX84wlzXTFWh8g+LJ8GVdIOLma5Ui1zObt9Pya6uRAwLxUOww9CW79g
 Vm61n6LB4Wc32ZQ+KmKtKvdYjgcWg==
Received: from ph0pr06cu001.outbound.protection.outlook.com
 (mail-westus3azon11021077.outbound.protection.outlook.com [40.107.208.77])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 49d8x7g04m-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 25 Sep 2025 09:05:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yxYetbBMMz8EOw8ziiWOvCTIbLOt6SwhH7yTd6HDnmsNe5I5uvSDILcYouOCS8nBEP5nDbvMWQF86Gj5TtOFexko4j/W3u5sLRHSRDWn9IABVrkVAPpu4MH8To07BZTd+yrI0blw/h4ltP5dVP6meEVPaKfQRgs2Evcd55quOwoGNbvHB4OVXGEkfepfCgldhnZS7Y+HlQ8FAdwGycMn/P3pK+3K3nwrdovG6qOHGp/tWhzQG3XvK4W0S9wqjlxp3ZumVo/qPcU7cLaAoMwmUNUl1VvFYLT718nPF3lP8SQTCnsxXNqP1CwmBAma9skj41qn43NuNeUEY88itBuLxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SSCgafJ4TKOGSfq4Lhfw5X/N7e2vLnVKUePiY1TcmPY=;
 b=XrNqGP/5fVz/5TyBNMoEByfRFu1HUukAJyJVO8n7H0NJuF2qL/s13HYMliiyO1XppvEXnLSiIgETpwFOvcKS+IC7/QXXSv53fPgPXhUmQu/WblAbRScehatV4tplohZ7bDwv9KD/TDYrc0uxtdgJa3zM77UkZeCh5HoJNLM2uU2amvO2GRNfDI5r4Ab+k9RvH8CB2O3vhRwTv8pw/EMjP36mZiiKoEYlQsCzXPRYwDiZvzRls8rUxI980Xhiyr5zdZ5aFYHO7mvvrrWnzOMrPaHH9EsOpvtSYaTc6ounATjH9Ee3sAxjtTuMQLTBFJQ0Nz9gPeCnklGOgCHY3vQjeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SSCgafJ4TKOGSfq4Lhfw5X/N7e2vLnVKUePiY1TcmPY=;
 b=HtyVxzm9zqQh3qGqpOF9vj4hRVQK8iN/j3gOAEyUw3ZLvE6YFWniXUh0zRWYq5alqXh5rsOU6517yuboHcibkHkRlnSRT0ExWsUZnseRJrYu1UkM3GdBar2kST1sC+vnRCUZNuXrFunszDjKqQYILyRUcYezCgYyhxzWLDSB/q2nVmdPHCBqX1jqZpMEDkLzDL7aWCE5O0+luOmMX4vqMJ0QxqUfCm5sqN0PrIOZif3iiofT2ff59ZPyFkvVqcKpKKbbMRrlUfbZ9W+5d4ubmb6nnYtiV1Zudmje9KfNOgbFEeTvofuRDtJrAXBWX7oxs2232ISFqgQqHNlBDfgc9A==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by MW4PR02MB7283.namprd02.prod.outlook.com (2603:10b6:303:67::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.10; Thu, 25 Sep
 2025 16:05:00 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88%3]) with mapi id 15.20.9160.010; Thu, 25 Sep 2025
 16:05:00 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: imammedo@redhat.com, philmd@linaro.org, berrange@redhat.com,
 jdenemar@redhat.com, armbru@redhat.com, pbonzini@redhat.com,
 richard.henderson@linaro.org, eduardo@habkost.net, mst@redhat.com,
 marcel.apfelbaum@gmail.com, qemu-devel@nongnu.org
Subject: [PATCH v2 1/2] hw/i386/isapc.c: remove support for -cpu host and -cpu
 max
Date: Thu, 25 Sep 2025 17:03:19 +0100
Message-ID: <20250925160453.2025885-2-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250925160453.2025885-1-mark.caveayland@nutanix.com>
References: <20250925160453.2025885-1-mark.caveayland@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LNXP265CA0014.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:5e::26) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|MW4PR02MB7283:EE_
X-MS-Office365-Filtering-Correlation-Id: ff4eb583-d39a-4928-81bc-08ddfc4d4794
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|7416014|1800799024|10070799003|921020; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?tw+TEAlBZOFnwpEiVPk2PmkrEgPLa7dFib1BGjSGod/0YvZkXfeBhE5TrAMh?=
 =?us-ascii?Q?oXwsdS0kPU37KnnBpdpGGvgONX+lMjZtMGlN2pzFmt7yCFF5Jgn3u4YUnbHh?=
 =?us-ascii?Q?3DyMtVuIXP1RD5ypX8naGUCzzsu4tEUPVSWP0OYTKLHY1Z+dfrV6m1C/1eYS?=
 =?us-ascii?Q?QIw86J6a4w2Bgl3OEuSktqRrYxlYaS13yoPTV1qnRa3fqYrWs7Bd96L/50Fd?=
 =?us-ascii?Q?B2JqhFAs+7n0hHJHKX4FhDfVRi0oEKW36AOtQxfXEbVdO6BrsZTPgHSPa8RB?=
 =?us-ascii?Q?E9aH3qlZaZ+fVJkvuDgIVheK/5z8Ai1WPM4f5oJsoRTYJH6vTtz1Oib5pP5V?=
 =?us-ascii?Q?BPZyQ+ixhEs39AwrlWLl1yUoJy8dssvKFt5HPof3JzNNSYttNtXBzMy+UN9u?=
 =?us-ascii?Q?w4hQqM1wyFUeMuJytlWRPGpdFlmqcv3W+r3fVDgDRfrG32kfNysdMf8lurqu?=
 =?us-ascii?Q?CLjd/LmEe3ryqXuu8UrbrOlAeP+M5Q1ikoGhWVjvSgU0lOrRiZPEIr85tldi?=
 =?us-ascii?Q?33YcoA9LGaiqPRLAq/QJta4MxCzVo53oiIA+wQD1GNrIw15f/RyubR5JWyzB?=
 =?us-ascii?Q?eiWxHz6kKQDzRn1Si6/iaJ+RxP5wxqWU01czO3Lu8mpbe73QCJpTtOcIZ8NY?=
 =?us-ascii?Q?b5e3NimvIQFRJH0zZhuGokDnfkFUyJsSHK2E5KKEvFZZmxBC4LnxTayeev2G?=
 =?us-ascii?Q?/uqR+NzQ7kfs5GLqtRSb87TpZGBTitQGCosZfZ5MXlnAxeQaT7IDqVCdm4PL?=
 =?us-ascii?Q?ZJnhh6uAkKO2RzLy7+1ceiqLC+POQ9Lvpf7qxokITBcbq45qs4lTz5cpgtN8?=
 =?us-ascii?Q?Hnqv7GVrChUtJy/OJW37sPRO+aUK7faTKa2ZtQYT10hNrlFvR6ZyRQDNXBNQ?=
 =?us-ascii?Q?52471S04qOnIPo+/LJDxsoZwWJ4oDExGy/GO919tLZk8dacSQrw6FdtztSL3?=
 =?us-ascii?Q?kwYKe0Cw3bHHB/cf4WrbXAbBg89Bvn//lB+bpUx0htfFwv9DpxT879dco2E+?=
 =?us-ascii?Q?te9woOAzocG+AY2cwSJNfqSliv1Lcz5c3l1UjJ7i0liFQoSZZs7tS6nt5sUl?=
 =?us-ascii?Q?xp/V4M+F6Mtw86Hbel59/WAGJUTwnVM2m0nqH94YAUr0jH3Z82OOpCDt+aRU?=
 =?us-ascii?Q?PGfxmfanCGwvKCns5Hp4l6bEFhttpZi6SaQcF1/VSKkwrqnTws6QEyiIiqdT?=
 =?us-ascii?Q?Z3sV8cqQ3LE6vSNnx8VGDofCrysyziyv4lHi0hBJxV3XrKG33E2w7d2auyWC?=
 =?us-ascii?Q?7BtA27AyR+5iWKiuU83S6lm6s5MGqDY2hqzYHe7BfKAuq7lwllXe01ABpvSR?=
 =?us-ascii?Q?5Rm63LZxHNhfqJkOwasLkDjR0SeUxmKSBxDIrcaXfDb40vpcjuXze7DzMgzh?=
 =?us-ascii?Q?JG1D7/1P1sv+CXqIoX1kXyg9XwzKrKn5ErrieWdGHFB/pTxIVBoO4JYHDp8e?=
 =?us-ascii?Q?MGEBvj1z/MECLyhH5YOvDlAQPabZ2F5ZnA/+vdr6eGfl9Wlu0nVX85k6tsMF?=
 =?us-ascii?Q?jPIiJG5znjjI8G4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(1800799024)(10070799003)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gs2XNkWQhCavxTJIMVyLMAxzS/wx/8W0gO79GW6JVNQOU19gfK7yzuaQB6tJ?=
 =?us-ascii?Q?7bbDk/WSedSK1Cnlt94Sufhv9bImtaU8kip9/Uv+MWruac6efYB0Ft3N/484?=
 =?us-ascii?Q?zESBvbarTAfZjOu3Qz7+ipQ1WOnQx3gcZckQgpD8bTmzG4BRyzoF7NVgVVQt?=
 =?us-ascii?Q?eIlE8x/LThXZEnx+UAP2KRxYYUnpgBygdruc2lTzv2zIwIHGPL8s7j36b31U?=
 =?us-ascii?Q?VNodCkK3YyhPQZrty1pgmnTbJtbROJ+Y4sOmv/UKIG3RaK1R/td97gUmmJoy?=
 =?us-ascii?Q?NN4KQvjjWJ1rwPaJn9EnMkKOsrK2HU/l2RcYrJe3QUD0LNKNNbBOnwGWJ8VN?=
 =?us-ascii?Q?6+QK8sKauO278K7CwpSoJOek2qyt1cE1wr5Yoc0XPf0nrRacWx/KY7cCgiuI?=
 =?us-ascii?Q?laR27Qb4uH2kDSaWFKZ4c5X+Eocf+Q57ezPMYEAYGClPaOtGJKc5f7nJOIsW?=
 =?us-ascii?Q?JHN6RG5EF16bRGnE25Cbe2kPaVbIh3iayuDNo6+oWgCgKCyY6LXsCmYoK2Hp?=
 =?us-ascii?Q?gm3QafX7etmrLZ5/3+Dkp7cynI16jQ+v3/e3IYwSiJXlBsbouyNRTbSf9TN7?=
 =?us-ascii?Q?MqYPWP9/4OSe8Un+ahQlYo2CD6bw73hEYhdZZixJAEaAUoOTx86WPSdWpIkX?=
 =?us-ascii?Q?G0EBbSc/58tQqcVcKIJUtrR+GG9t2P2I55oUHrptwv06DFNxtEagPt22XY54?=
 =?us-ascii?Q?Y0hNPP96BBbxIzj6tsUqHU0Y2RdC0JXzrg+GgssJ8AC8P0OwVtUO0XcxPSH0?=
 =?us-ascii?Q?WXRYFEcVJHSt4DGoz5kiA7+78xszZvWfqymfU/SpyLymqQL8SpEskzAO0dTn?=
 =?us-ascii?Q?+Gn7KYpilKEbd7p2g8lBHOjL/gjIIr7P+3Qxx/xSkDv6WG8zjsU3QPNQIoAH?=
 =?us-ascii?Q?U90lKfbBl41hqbYFA6Mo4fQN9vlhG0Wv3/k1KokDSGYnzzVko5jkBvrrsxwr?=
 =?us-ascii?Q?TZhwt6B+418cgYGJqW52RpAu+QUEV95JVnlOGHGdWLS5KgHr/3ntcS085eN9?=
 =?us-ascii?Q?N7NPH9f8TbC6HRN1ZBiBf2NMA3n6TZbTIGQrALymFoNOcydw3f5loa1wklUE?=
 =?us-ascii?Q?Qy+DDcuWmXI0L74r27HVV6vIPRkeZZ1jK8+o5c5QQ4gIuzXnJqj6kNxAOGHe?=
 =?us-ascii?Q?0z+GYYpabWq1HJudRiycfSTG9ezTMUH5gy/5NjoouWq1SvgPIu3YyzWigmUW?=
 =?us-ascii?Q?75zLmT0/mWru4aa8hjZ0CLEBBxEBYkZB9IGvzQ6RwiLp6R3owqZFxmg8jKeV?=
 =?us-ascii?Q?dIXrh8vrn2H8NMCT5j+lW01y3GJvZani9heb5WNEJJzZnIS7fcFddwLtMcQs?=
 =?us-ascii?Q?bjD/1EmTSwtRjjRNKdl071QolL9SzJ+Q2UwGswp+k4J4fOfhkdt8Qp+btcTp?=
 =?us-ascii?Q?k/VD7I+Dz6HYg3sYs53cq4CheyiPmzxBOUiSLAswK1kTJ0mHCnWLtHCdWnMF?=
 =?us-ascii?Q?8UBnORJ+fPiA6Un2kvZP3rCvIeZb95SqdBLP1nemOOIlVWx5Sl/AFCD4/paV?=
 =?us-ascii?Q?guN74jfwJuL0EI1pscTJIkWA0fCN7+HLjHMJmlTrAT8OkjzOzDOYs08qpbfb?=
 =?us-ascii?Q?Zv+6jGo2jv3C/FHNSgjBLagdR28ANljqbrlmDqMnLT82URC4n1AiGbI24q6P?=
 =?us-ascii?Q?Vg/nxLyPKP6X9auotdtoh4ETMv6AuRASl19/F7bHCMspuKp7ZMJbIyXAgcQI?=
 =?us-ascii?Q?4ryPhg=3D=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff4eb583-d39a-4928-81bc-08ddfc4d4794
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2025 16:05:00.1199 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cB3JuXzX6nYAvZ+AUpLSAZKKTI510TZsGh0DPxmbtxxJJWTstY3WjuWIZ4MT/QRqBdbAwyTjGuudPeybz74OecXlvu/g42hcyzuTfO0tuU4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR02MB7283
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI1MDE1MCBTYWx0ZWRfX39wLxZV10N/i
 C69LH5Bu4sdp00Jb7lchv+H4C035yBo2heR6Ee/QHWevC77UIeH+399kyWQuC3nQOPYEfQsLAXC
 fpZVKTw/xHl1qHXMeoNK0rRwUl8tS9bpd7xvD/w8JpK2EP89w9AAPPOB9s121WNo4Mxrpannc8o
 HVilRuU96m5URVDaaRq77yH7DeVaDjRSpBmXKbq+pMGsnbbFLuvSOA8fwM3kjHO7u1METTXfhdI
 4k5m1pfrUJRcbXSUCUgg+9U9Q3YbDPo5FhB3cee/w46dC10qXnYiSEW+i9BjYJyia79WqvLVpVa
 a/jbuDgya8bKzB5A7blskTPZlHpRgsKElAJPJdXRAa6QA623Z3TomM1kT50pL0=
X-Proofpoint-ORIG-GUID: dITIa3OLMqIiscEx8AiCRnq88gIbJyIv
X-Proofpoint-GUID: dITIa3OLMqIiscEx8AiCRnq88gIbJyIv
X-Authority-Analysis: v=2.4 cv=ar6yCTZV c=1 sm=1 tr=0 ts=68d5682e cx=c_pps
 a=56BXxs5GTVekWDSCh43ZEQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=yJojWOMRYYMA:10 a=0kUYKlekyDsA:10 a=64Cc0HZtAAAA:8
 a=9B8KroAGFL14IzxpYG4A:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-25_01,2025-09-25_01,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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

Following recent discussions on the mailing list, it has been decided
that instead of mapping -cpu host and -cpu max to a suitable 32-bit x86 CPU,
it is preferable to disallow them and use the existing valid_cpu_types
validation logic so that an error is returned to the user instead.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
---
 hw/i386/isapc.c | 27 ---------------------------
 1 file changed, 27 deletions(-)

diff --git a/hw/i386/isapc.c b/hw/i386/isapc.c
index 44f4a44672..6c35a397df 100644
--- a/hw/i386/isapc.c
+++ b/hw/i386/isapc.c
@@ -41,31 +41,6 @@ static void pc_init_isa(MachineState *machine)
     DriveInfo *hd[MAX_IDE_BUS * MAX_IDE_DEVS];
     int i;
 
-    /*
-     * There is a small chance that someone unintentionally passes "-cpu max"
-     * for the isapc machine, which will provide a much more modern 32-bit
-     * CPU than would be expected for an ISA-era PC. If the "max" cpu type has
-     * been specified, choose the "best" 32-bit cpu possible which we consider
-     * be the pentium3 (deliberately choosing an Intel CPU given that the
-     * default 486 CPU for the isapc machine is also an Intel CPU).
-     */
-    if (!strcmp(machine->cpu_type, X86_CPU_TYPE_NAME("max"))) {
-        machine->cpu_type = X86_CPU_TYPE_NAME("pentium3");
-        warn_report("-cpu max is invalid for isapc machine, using pentium3");
-    }
-
-    /*
-     * Similarly if someone unintentionally passes "-cpu host" for the isapc
-     * machine then display a warning and also switch to the "best" 32-bit
-     * cpu possible which we consider to be the pentium3. This is because any
-     * host CPU will already be modern than this, but it also ensures any
-     * newer CPU flags/features are filtered out for older guests.
-     */
-    if (!strcmp(machine->cpu_type, X86_CPU_TYPE_NAME("host"))) {
-        machine->cpu_type = X86_CPU_TYPE_NAME("pentium3");
-        warn_report("-cpu host is invalid for isapc machine, using pentium3");
-    }
-
     if (machine->ram_size > 3.5 * GiB) {
         error_report("Too much memory for this machine: %" PRId64 " MiB, "
                      "maximum 3584 MiB", machine->ram_size / MiB);
@@ -162,8 +137,6 @@ static void isapc_machine_options(MachineClass *m)
         X86_CPU_TYPE_NAME("pentium2"),
         X86_CPU_TYPE_NAME("pentium3"),
         X86_CPU_TYPE_NAME("qemu32"),
-        X86_CPU_TYPE_NAME("max"),
-        X86_CPU_TYPE_NAME("host"),
         NULL
     };
     PCMachineClass *pcmc = PC_MACHINE_CLASS(m);
-- 
2.43.0


