Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DE26C28B28
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Mar 2025 01:16:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trRkE-0001K9-LQ; Sun, 09 Mar 2025 21:15:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manish.mishra@nutanix.com>)
 id 1trRk9-0001JN-0b
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 21:15:49 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manish.mishra@nutanix.com>)
 id 1trRk6-0003lo-Kp
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 21:15:44 -0400
Received: from pps.filterd (m0127839.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52A0m1bD025019;
 Sun, 9 Mar 2025 18:15:36 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=proofpoint20171006; bh=ExLczXFTIAuZX
 lG+aEsR/8uQAy3Z8Zv4XjUDJHLDOM0=; b=lG85fYYWbNCjdXgnif3SedeF24MFe
 rHFipoy/7ZMQEYGh57AB4XfF9pYUmj7B/BPDcWJkGkDrhosWy+1GhQsvBi8d6At/
 kucCTQMcKGdOgCu+kITmWXbtjpkfBgpIFQ8/+tvTn2v19zHa7g0ABh4xQ1oriaaM
 xF5j0gkFuLXDnnIjFqnxPPy8JSwKgwvZyWI/Q6IyH5UMPqh10Qd44EcskOrMNqta
 hwTzghhXY+Reva9gvaWI/SzdFC4Gj4kHjIrECQZDWVAO1BsHtLB8yZAoDfLvNd0R
 87aTuDSgdK6WVfQKB4k5nGXwMb8UcMFCR0AlGGhjjxvaDckwDXtwl8RVg==
Received: from nam02-sn1-obe.outbound.protection.outlook.com
 (mail-sn1nam02lp2041.outbound.protection.outlook.com [104.47.57.41])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 458nupjdp9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 09 Mar 2025 18:15:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jb58GT6CqA6kHx0PMRN96dDyJxnocpoL3ZDirQBwCeiUaXGQ3CNhZ7EjPyrvUT1MY9YbhnVt3rLvnKV2OCZazmrouc0Hx1BeKtIntRTut55Cl6VJgfgBU0cKtZsmm6iW6xDvj2wiwwSWiLOU7DePSjvZRCaGfZYU4Ot9Ih4kSD+hpV3omMvkwX9BmGR5KbtcGKV46B5WFgjd/TBsalObYNC3rWMN8ZKHotqa0B40RTK+TM6J9KqpcEYcWZvxVILvRuKaFEeeeH0gIEk6qR7MNncICBYMbu/djNrVVv3BXcx3F6Gyh4Hgv82Sk+rmSJKOFni4OHudSq7mmjlQohdzyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ExLczXFTIAuZXlG+aEsR/8uQAy3Z8Zv4XjUDJHLDOM0=;
 b=Sivw7FYW+jiIXPSKZsYqbSvWdAB3I7v//D3KKYPoBdHRkJh2VY3Rr/wL+s1GuQsnNhbv+xidYiRUdlm5f0wUoFzMExTzzWrbY5tcVIsWTu4fjlExJIN7GCE9/nBZO2qNOXw+LGU/aDZfoH57gnCu5zT1P6K+2Y6QvznxietUTHQhJfPAISAlfaao/+PPRrn7U5wyt8bfspoPqF+G0Wj8LpVUWNINoZmNKmK/kmYopm9y6PrEk4gcn3xEQvi9tHwz9HsnYi9UVumhvgynps81cui9Soo1A/4/Ooucb6k2uDTbhSE/sB18IRJlv1LJVJf3WZ7j/Q2LKr6+htQN9d64jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ExLczXFTIAuZXlG+aEsR/8uQAy3Z8Zv4XjUDJHLDOM0=;
 b=QGnvzNtfojX/tbjjsl67b74dUaiPnGX4TSA/598swz9Kut5qIF5qN7JmmgG1a5qfqmd7lKMwTH2Bai9gs4D4qnVzqUIkmc37UlG/ZO61DUqqFENHhT0RRQTniOnQ+sXxuhINR1Z4kpi7brgQqvXTnZyMVwn4ntTCLaH7NIGRemLZ7Al6n2CpnOEcioZkU4IOo1Ce+UdVotWUtuUmfdEIO9/GAANoTZw1guk0iJf/yBaNITDsuHiSqgc2JbpcR2SQYI79w07ka3YqeWaL4kfTSeH7srkibZKxGE5dLSopoG6UajJzx3CUdM5E1kn8R1HjGgVCcjLWy4NONooySCAPnA==
Received: from PH0PR02MB7384.namprd02.prod.outlook.com (2603:10b6:510:12::12)
 by CH3PR02MB9478.namprd02.prod.outlook.com (2603:10b6:610:122::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.26; Mon, 10 Mar
 2025 01:15:33 +0000
Received: from PH0PR02MB7384.namprd02.prod.outlook.com
 ([fe80::6bd7:e8f0:596a:4842]) by PH0PR02MB7384.namprd02.prod.outlook.com
 ([fe80::6bd7:e8f0:596a:4842%6]) with mapi id 15.20.8489.028; Mon, 10 Mar 2025
 01:15:32 +0000
From: Manish Mishra <manish.mishra@nutanix.com>
To: qemu-devel@nongnu.org
Cc: leobras@redhat.com, berrange@redhat.com, farosas@suse.de,
 peterx@redhat.com, Manish Mishra <manish.mishra@nutanix.com>
Subject: [PATCH v2] QIOChannelSocket: Flush zerocopy socket error queue on
 ENOBUF failure for sendmsg
Date: Sun,  9 Mar 2025 21:15:00 -0400
Message-ID: <20250310011500.240782-1-manish.mishra@nutanix.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR05CA0035.namprd05.prod.outlook.com
 (2603:10b6:a03:39b::10) To PH0PR02MB7384.namprd02.prod.outlook.com
 (2603:10b6:510:12::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7384:EE_|CH3PR02MB9478:EE_
X-MS-Office365-Filtering-Correlation-Id: ca3a5882-5057-4bcb-8789-08dd5f710de1
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|52116014|1800799024|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?uQWzrEjZAfs7/w2iVObefJywkMoVF6G/bzmusbjxxlamB/TBGAHuk4riLgxf?=
 =?us-ascii?Q?spoPK717FypqQBZFWeO9HhnTHMIqCVrLyWyLvG9+wJyXagDJhEYmPEIHNkKU?=
 =?us-ascii?Q?60kKEJiQWdU2eXPOksSKT/SQeP3ew9XmHa7Q0M3TI/nTPSbh1H1pfAKfbWre?=
 =?us-ascii?Q?bjZZqWY/wD0Ht+bpif17d3mrieTfkI8SWiXstZ1/+Fqnr2kLSBNZoy7wp3KN?=
 =?us-ascii?Q?0dy3T0KJe4j6TxNeUpcO9rcgLuzsErGKun5L3VlxdZZwjgdLEtcHegALmi+t?=
 =?us-ascii?Q?xJmH/rtaESmwg5VngL+XGAVocGR6z+4gqqZeHEprs0BLrXMukuWi/iUmFFfi?=
 =?us-ascii?Q?cDbwknbjGhlENPt/M1/Dmv1nCgq2J5i057AUrAXe0v5/NM+qR1VLzJ0oj+EU?=
 =?us-ascii?Q?L8X2FKHDBjR0iwEjz+DwX+Djd8s3+gwEH3j9NjDC5F8UvGoJIDwFaMgoA1vk?=
 =?us-ascii?Q?vshPIOWsNcYOVUWlKPSkCFFaEf1+1otlRdb77m0rYkyCZfdbmud9QN2QUZpk?=
 =?us-ascii?Q?V7v3jQJD+OeKxri6t9jiS/Cibt3N/mUeHF0o/i26EOF1jA5rBR325VaooaYZ?=
 =?us-ascii?Q?UmjMnp3utKIrCliDIdWGN76luldOmkQThFxPMUNoxVPvm077+GYUpwv9KPvW?=
 =?us-ascii?Q?bE7t+jSS6S0FVwGeiutiwqJlXCe34UfcVwZF/fV17PFfrAQqZ8raYaf/4tYg?=
 =?us-ascii?Q?xs5AqN9mBjq2rjzXkfAJ/jLKorGXwmZmOwVmXpLRsLjn5Og3oZ8fHBu+OkYO?=
 =?us-ascii?Q?nEC/aZbf//dCcKlO7uatEIHtPvw98jtblx0KZM3dxbVzDhY2Vp4fX8NfxrX+?=
 =?us-ascii?Q?OdinYZp4Mho+JQtyQ893ky2yJqFjks1E3AJ9lQntvvkOQap4PIXwL9+lX5Bt?=
 =?us-ascii?Q?smK4fI8eD4dYU28iSWCqmHmxeqj12KCo0YbzomIVTuE/w8tK+AsH2M5288/C?=
 =?us-ascii?Q?LjSXbO55WjNiTpqmZ5+p/OprBkJ/MVnzkKutrXz15St9dpG6L7sxR+er6NlC?=
 =?us-ascii?Q?Lr9jQUE1dP7i31arMOUGZV7v6nLGe0Kp4F49enLY9bcorm3sjXCoWfmHUbMx?=
 =?us-ascii?Q?nLnzfdLL7nbwjBwIyZLB4Hk867aKHb0nBK0FLbOYJiHJYMQdMN4xaA2D0oV6?=
 =?us-ascii?Q?ygbDcPUG6A7gkD1A76ILG2W56VaLlVAuYatCs8HaZaqtrDGr95DH0CqJaJk7?=
 =?us-ascii?Q?4YjBHpi1nFjpkpxvQUxIhpgqvoqY3yk0i32AoSQOeTAz8C7jxDhHe2FYPjl1?=
 =?us-ascii?Q?+FMAK/U0rBJXw6uKhD/UDaNPZ/FK8Uu1qTkMhHHY//sieKbvovtJbky29lIP?=
 =?us-ascii?Q?L3TVXgxMFl+F/10mJchFaS1tt6iqNuT6Cd2sySdJM2oP+o+MllVvwmFzHyTc?=
 =?us-ascii?Q?VhcglVFeImaMX28QtK95wkTSUqGRMv0hEtNq04ueXRpGY9lOmtQD0GFcIgMk?=
 =?us-ascii?Q?BgddomitM5BDVDReUy/fDZ1OZcMMQlD8?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7384.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(52116014)(1800799024)(366016)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0KcDUYjyRyGAlYw5v8E37pQnPHv0EV8YCS6rG+pcMfo2/VsN17JM0d6nxlRd?=
 =?us-ascii?Q?D+04Zh8Nc3+KukvG2z/+hIz+j7dJNOZRTAEpobHlQJG1N3SORz9VNjyC4hmg?=
 =?us-ascii?Q?uKOTyhE2ZE9SARAToii9nOTZ1XH/6HMf5vBea0DIkK5JmF1+28Iyy97ICk3m?=
 =?us-ascii?Q?IhKgfFmpBDLeaAHG9FoDWCCnaL/ytLcJYkNkAeGmcCYd643iMh6p5MpxFiwf?=
 =?us-ascii?Q?jrN/zr1ilch8/6ahl3yL66h0eOAe/45g+9Z7+ns0kHUKOw7Swx7BdAw2936v?=
 =?us-ascii?Q?wTIWjj+1WvTTEBemNG8gZ6jFNL8qeYuLpDi8OSgPuX/QVPbNC8ULRLZt0AH1?=
 =?us-ascii?Q?OOU7f7amaUN8RCuKx0o/aH8eabHMYvBOpXqdlDBUbj3gLHN8GdsHmpOSuvzO?=
 =?us-ascii?Q?9jiDeF9dBTqw6cfFSqkcBph8SMzXGeJvTHSjXldm8Ar0o1mQD5VbWpXBZXip?=
 =?us-ascii?Q?rQLKngp1mtk69bnl17qexTMI3IKgy7iF0Iwo1naaMMoVeuqPVi4EKuGeWKkA?=
 =?us-ascii?Q?JdIApvP0I216GfyyVFqJsnhzXgkgYV5oRqZpiq2Fpu5G59+iIP4lbRK2Fypl?=
 =?us-ascii?Q?Pw2C0j0fo7joUmaG8ME/7ifoxi3AO2wuoXRrfzzXlt5k4mXdkjzP9VrS6Rg7?=
 =?us-ascii?Q?l2UkRPUyQQ6FYXJ1j17mJQxhZJURhRsT3+gAp8j7R83uY3jFTfSP6Q3RKnTO?=
 =?us-ascii?Q?P6GAMaaV4rRIX4hVvst2pEmXWiocl+GXXqZIBy9RdLisgx8zl+9Nbc4b3SxY?=
 =?us-ascii?Q?yYYxeP9stu9FZhSb3qQXllSDvYDu/Jmb4rqu9u2p9VG1ByeM2Jb5vzAIDrBQ?=
 =?us-ascii?Q?X3rB4oufj/mFWalwjAZixYqCNPlu3ojavRAiVFxPzAnMff4bG8ydzjF11FfO?=
 =?us-ascii?Q?nv7SodmZlFXxc2nXkPoBrY73XDe+uEeWZFky8FbnxXqedcf63uKaEq0RVxeG?=
 =?us-ascii?Q?mUM3QG6XF1L0DWlKPGu+9xoklYhOhVfb1lKASTU65uzsouV6hENho54kL5Of?=
 =?us-ascii?Q?hMrVjD93vpWYNF3wJrHRyZ1VlmvjqaH4BNA8ZiaQqiTu8xO9Pi1PGMwR7YhG?=
 =?us-ascii?Q?2+XYVhSjc/s1YSDFrA5uzQk/btjIbOIzhCsV/Hj9qkn8iN1nYkMDpuiqI6nY?=
 =?us-ascii?Q?AwfNB8dCvl1nM/nqdouWpkAtoQVW3utETQ3Nw5JqM5hHR/RXcnqI88LvlVlZ?=
 =?us-ascii?Q?Z80HjO4xwkNPeamuBRUT1Qvty/kEbTd23LEGBkiMOrhanw9G9KRP/Cy1Os6O?=
 =?us-ascii?Q?dQ9g2wErCQDrvNSIXyFi9Loxjhc9IRsQgMKNhkssDjhzqtcYZVOCiM6hXQoJ?=
 =?us-ascii?Q?oAkMJf/3UvII9gu4EoL1WewsZ8d0z0Xm/3+UTyVPWw7GMun9uAetJNouXG/b?=
 =?us-ascii?Q?4hG9DgoZ2aZ/yuRto/76emL2wEx2aLt1YzTp9HieEbiRJap5S+pSFQtWAr8F?=
 =?us-ascii?Q?pgCe+86XEHoBtn0CutakqBOpGSrVh2z9TLVuvn2oasLlG/LduxBZhM3IsYDM?=
 =?us-ascii?Q?FM0AbGJEZmBpe2AxK08Hw8U8gejqZi2bpEZuWW0eKm1Qkv1CMkRlS5TeUlyH?=
 =?us-ascii?Q?Ytm8oG9hgQvwHDhIzjOvM2zVjZmUSfjsJJVYBwe8RJrmwiwwY/kcKZJ1oT0p?=
 =?us-ascii?Q?XA=3D=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca3a5882-5057-4bcb-8789-08dd5f710de1
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7384.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2025 01:15:32.7341 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L30caY06IrjvjKu9HMsTlwjjBi2mjtRfra9M8a5FOs4qNq1i7L3IAFs9rtRa1iGa1ftJqMBikuXUX7+QqRQAp1DtViyRxjCQbrvm+lYTPPc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR02MB9478
X-Proofpoint-GUID: s8phki-Q7opps98kkyU4kXspIRt66m2z
X-Authority-Analysis: v=2.4 cv=PML1+eqC c=1 sm=1 tr=0 ts=67ce3d38 cx=c_pps
 a=7V8mf9/socFTThwl5N0qNQ==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=Vs1iUdzkB0EA:10
 a=0kUYKlekyDsA:10 a=64Cc0HZtAAAA:8 a=naXZE5eY77Fpy_IgUEsA:9
X-Proofpoint-ORIG-GUID: s8phki-Q7opps98kkyU4kXspIRt66m2z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-10_01,2025-03-07_03,2024-11-22_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=manish.mishra@nutanix.com; helo=mx0a-002c1b01.pphosted.com
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

We allocate extra metadata SKBs in case of a zerocopy send. This metadata
memory is accounted for in the OPTMEM limit. If there is any error while
sending zerocopy packets or if zerocopy is skipped, these metadata SKBs are
queued in the socket error queue. This error queue is freed when userspace
reads it.

Usually, if there are continuous failures, we merge the metadata into a single
SKB and free another one. As a result, it never exceeds the OPTMEM limit.
However, if there is any out-of-order processing or intermittent zerocopy
failures, this error chain can grow significantly, exhausting the OPTMEM limit.
As a result, all new sendmsg requests fail to allocate any new SKB, leading to
an ENOBUF error. Depending on the amount of data queued before the flush
(i.e., large live migration iterations), even large OPTMEM limits are prone to
failure.

To work around this, if we encounter an ENOBUF error with a zerocopy sendmsg,
we flush the error queue and retry once more.

Additionally, this patch removes the dirty_sync_missed_zero_copy migration
stat. This stat is not used anywhere and does not seem useful. Removing it
simplifies the patch.

V2:
  1. Removed the dirty_sync_missed_zero_copy migration stat.
  2. Made the call to qio_channel_socket_flush_internal() from
     qio_channel_socket_writev() non-blocking.

Signed-off-by: Manish Mishra <manish.mishra@nutanix.com>
---
 include/io/channel.h           |  3 +-
 io/channel-socket.c            | 57 ++++++++++++++++++++++++----------
 migration/migration-hmp-cmds.c |  5 ---
 migration/migration-stats.h    |  5 ---
 migration/migration.c          |  2 --
 migration/multifd.c            |  3 --
 6 files changed, 41 insertions(+), 34 deletions(-)

diff --git a/include/io/channel.h b/include/io/channel.h
index 62b657109c..c393764ab7 100644
--- a/include/io/channel.h
+++ b/include/io/channel.h
@@ -980,8 +980,7 @@ int coroutine_mixed_fn qio_channel_writev_full_all(QIOChannel *ioc,
  * If not implemented, acts as a no-op, and returns 0.
  *
  * Returns -1 if any error is found,
- *          1 if every send failed to use zero copy.
- *          0 otherwise.
+ *          0 on success.
  */
 
 int qio_channel_flush(QIOChannel *ioc,
diff --git a/io/channel-socket.c b/io/channel-socket.c
index 608bcf066e..0f2a5c2b5f 100644
--- a/io/channel-socket.c
+++ b/io/channel-socket.c
@@ -37,6 +37,12 @@
 
 #define SOCKET_MAX_FDS 16
 
+#ifdef QEMU_MSG_ZEROCOPY
+static int qio_channel_socket_flush_internal(QIOChannel *ioc,
+                                             bool block,
+                                             Error **errp);
+#endif
+
 SocketAddress *
 qio_channel_socket_get_local_address(QIOChannelSocket *ioc,
                                      Error **errp)
@@ -566,6 +572,7 @@ static ssize_t qio_channel_socket_writev(QIOChannel *ioc,
     size_t fdsize = sizeof(int) * nfds;
     struct cmsghdr *cmsg;
     int sflags = 0;
+    bool zero_copy_flush_pending = TRUE;
 
     memset(control, 0, CMSG_SPACE(sizeof(int) * SOCKET_MAX_FDS));
 
@@ -612,9 +619,21 @@ static ssize_t qio_channel_socket_writev(QIOChannel *ioc,
             goto retry;
         case ENOBUFS:
             if (flags & QIO_CHANNEL_WRITE_FLAG_ZERO_COPY) {
-                error_setg_errno(errp, errno,
-                                 "Process can't lock enough memory for using MSG_ZEROCOPY");
-                return -1;
+                if (zero_copy_flush_pending) {
+                    ret = qio_channel_socket_flush_internal(ioc, false, errp);
+                    if (ret < 0) {
+                        error_setg_errno(errp, errno,
+                                         "Zerocopy flush failed");
+                        return -1;
+                    }
+                    zero_copy_flush_pending = FALSE;
+                    goto retry;
+                } else {
+                    error_setg_errno(errp, errno,
+                                     "Process can't lock enough memory for "
+                                     "using MSG_ZEROCOPY");
+                    return -1;
+                }
             }
             break;
         }
@@ -725,8 +744,9 @@ static ssize_t qio_channel_socket_writev(QIOChannel *ioc,
 
 
 #ifdef QEMU_MSG_ZEROCOPY
-static int qio_channel_socket_flush(QIOChannel *ioc,
-                                    Error **errp)
+static int qio_channel_socket_flush_internal(QIOChannel *ioc,
+                                             bool block,
+                                             Error **errp)
 {
     QIOChannelSocket *sioc = QIO_CHANNEL_SOCKET(ioc);
     struct msghdr msg = {};
@@ -734,7 +754,6 @@ static int qio_channel_socket_flush(QIOChannel *ioc,
     struct cmsghdr *cm;
     char control[CMSG_SPACE(sizeof(*serr))];
     int received;
-    int ret;
 
     if (sioc->zero_copy_queued == sioc->zero_copy_sent) {
         return 0;
@@ -744,16 +763,19 @@ static int qio_channel_socket_flush(QIOChannel *ioc,
     msg.msg_controllen = sizeof(control);
     memset(control, 0, sizeof(control));
 
-    ret = 1;
-
     while (sioc->zero_copy_sent < sioc->zero_copy_queued) {
         received = recvmsg(sioc->fd, &msg, MSG_ERRQUEUE);
         if (received < 0) {
             switch (errno) {
             case EAGAIN:
-                /* Nothing on errqueue, wait until something is available */
-                qio_channel_wait(ioc, G_IO_ERR);
-                continue;
+                if (block) {
+                    /* Nothing on errqueue, wait until something is
+                     * available.
+                     */
+                    qio_channel_wait(ioc, G_IO_ERR);
+                    continue;
+                }
+                return 0;
             case EINTR:
                 continue;
             default:
@@ -790,14 +812,15 @@ static int qio_channel_socket_flush(QIOChannel *ioc,
 
         /* No errors, count successfully finished sendmsg()*/
         sioc->zero_copy_sent += serr->ee_data - serr->ee_info + 1;
-
-        /* If any sendmsg() succeeded using zero copy, return 0 at the end */
-        if (serr->ee_code != SO_EE_CODE_ZEROCOPY_COPIED) {
-            ret = 0;
-        }
     }
 
-    return ret;
+    return 0;
+}
+
+static int qio_channel_socket_flush(QIOChannel *ioc,
+                                    Error **errp)
+{
+    return qio_channel_socket_flush_internal(ioc, true, errp);
 }
 
 #endif /* QEMU_MSG_ZEROCOPY */
diff --git a/migration/migration-hmp-cmds.c b/migration/migration-hmp-cmds.c
index 49c26daed3..4533ce91ae 100644
--- a/migration/migration-hmp-cmds.c
+++ b/migration/migration-hmp-cmds.c
@@ -138,11 +138,6 @@ void hmp_info_migrate(Monitor *mon, const QDict *qdict)
             monitor_printf(mon, "postcopy ram: %" PRIu64 " kbytes\n",
                            info->ram->postcopy_bytes >> 10);
         }
-        if (info->ram->dirty_sync_missed_zero_copy) {
-            monitor_printf(mon,
-                           "Zero-copy-send fallbacks happened: %" PRIu64 " times\n",
-                           info->ram->dirty_sync_missed_zero_copy);
-        }
     }
 
     if (info->xbzrle_cache) {
diff --git a/migration/migration-stats.h b/migration/migration-stats.h
index 05290ade76..80a3d4be93 100644
--- a/migration/migration-stats.h
+++ b/migration/migration-stats.h
@@ -50,11 +50,6 @@ typedef struct {
      * Number of times we have synchronized guest bitmaps.
      */
     Stat64 dirty_sync_count;
-    /*
-     * Number of times zero copy failed to send any page using zero
-     * copy.
-     */
-    Stat64 dirty_sync_missed_zero_copy;
     /*
      * Number of bytes sent at migration completion stage while the
      * guest is stopped.
diff --git a/migration/migration.c b/migration/migration.c
index 1833cfe358..2ab19ca858 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1231,8 +1231,6 @@ static void populate_ram_info(MigrationInfo *info, MigrationState *s)
     info->ram->mbps = s->mbps;
     info->ram->dirty_sync_count =
         stat64_get(&mig_stats.dirty_sync_count);
-    info->ram->dirty_sync_missed_zero_copy =
-        stat64_get(&mig_stats.dirty_sync_missed_zero_copy);
     info->ram->postcopy_requests =
         stat64_get(&mig_stats.postcopy_requests);
     info->ram->page_size = page_size;
diff --git a/migration/multifd.c b/migration/multifd.c
index dfb5189f0e..ee6b2d3cba 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -607,9 +607,6 @@ static int multifd_zero_copy_flush(QIOChannel *c)
         error_report_err(err);
         return -1;
     }
-    if (ret == 1) {
-        stat64_add(&mig_stats.dirty_sync_missed_zero_copy, 1);
-    }
 
     return ret;
 }
-- 
2.43.0


