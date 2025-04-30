Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0B07C369D9
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Apr 2025 19:43:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uADIU-0007ti-6N; Wed, 30 Apr 2025 15:40:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uADIK-0007oF-RZ; Wed, 30 Apr 2025 15:40:36 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uADII-0006Ba-Bd; Wed, 30 Apr 2025 15:40:35 -0400
Received: from pps.filterd (m0127841.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53UJPRsc031241;
 Wed, 30 Apr 2025 12:40:31 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=1CBuDYSti8UgkeCHP+Bwa5i368bO7/UQoR+qz975b
 jw=; b=tlb40u4w/nLDNv/BKGzfjSWFq+g+q+nShk2IjHOJux0twr5Lwb+IuRI8O
 uhVsP4aCEA204+blFMWm5uZocf/T9zCXrADpoTh7tCJeN2C3haRtKfka848Vc9yE
 yHKTY7xSMs/KsSIPGBuWcKGBrH8D5Z9E07s6FekdBWjNHXlnoK9JO0C+rlVXaVvP
 SXdmwvqlNKWCDuK8/Vazxo/QnSY1ZSb2c+Kjb/142C7+zPMuVX/+/Xjnm6anHf3Q
 rNHnO5NO/KY5LwEDfYXFceiRGUmL0SIzEd+Xn7mGc2L0PS5OAqj1r/3UMC1Zrnq6
 YoqDJy4hwVOM6CYr6uv91V46YBvYw==
Received: from byapr05cu005.outbound.protection.outlook.com
 (mail-westusazlp17010006.outbound.protection.outlook.com [40.93.1.6])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 468w182472-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 30 Apr 2025 12:40:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t5b4wJILnYTLAF5PQ8gpH80aJPLa8y03GnrDHMNqYI3nTpLkvumkjbXH+gxnh9BVuI2ebV75qEZ9bb5iqqZAdVHSRVD2kpurWZXzfx3rraJZLijnY2PdD0pOzguy/AqFnMMpQ6LIKebBBxbW/Ih4un6Y22PD/WtIyMX3bFTW2BKdXGASRf89NgekDA91mZI1JJog72dO3ayqaxfjMIVTVSX2IgAcGIATOe01danP+eqVv76ZXbtJFCBOCzW6cIpG7boEQeRI3CbhO0hJ9Dlna6WOhEV3tFUylfh8ccpPJw5clqjfjgsCMOURbLJMmket/6snrsu9yf0def1J/jwekA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1CBuDYSti8UgkeCHP+Bwa5i368bO7/UQoR+qz975bjw=;
 b=Wv6oGOdf1ljGxVYPtX5GNW6h4vhnpSTti+aMTd4udc4OipVUQPNJ2mMzOZN9+9jKmC6fDefyxnU23AZcZ5SYomkTpJvCskZMK5UlbFp3fK+21WHfqSVKQjSYq0Lmc5QjdDUOBD8dT6npZw7XOF94Xr9sad+54mcHKlRpkXkOLvvB87o9Bs+SVRMKC5o86GM5nUC6iUzW3MN63H2zQtYXlLO8FgTJnRNx0fhptE0khpWkQb7xxy16W+sz9JjrlOtznznXIcOTh1kE1MIkEB7gpyYHrwniIaH3erufa//lh8YHyQxYoKMKkyxOU5zRy4JYudhosPmZC04DaVvUIs5i8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1CBuDYSti8UgkeCHP+Bwa5i368bO7/UQoR+qz975bjw=;
 b=RJNEM4k930PRviefqKY4+ZYn6ayubgdOTLaKLMVmFZLuPoLRvXYXOYN2VSBU8yXZ10U2ygDXksqJ0fD1WU8UnwKgIqEXKD9JTPFKD5DDbPO0VH3ew/Kny6PWdGVyJk4Eh3b6sfcTht0Y2JX3ylWXnJeSia/qAWz3qJIbePfp2AoPVii0OFvjkCdiiphScigEqp1zQvL3XyH+W1mWeg8veQ/74tdbzxQTMeViXgsG31Sy6Rii7zbAOz7nCs79PQ8+Q5f92+Ifv6HESb6HTLBEa6kQ4ym4c82Hk5JOb1tZzgrWjJzRF6F8MidiYraQM5qgFJMxnHHLNSuLFSQ7xJ4jzQ==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by CH3PR02MB9931.namprd02.prod.outlook.com (2603:10b6:610:177::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.9; Wed, 30 Apr
 2025 19:40:29 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51%6]) with mapi id 15.20.8699.012; Wed, 30 Apr 2025
 19:40:29 +0000
From: John Levon <john.levon@nutanix.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, qemu-s390x@nongnu.org,
 Jason Herne <jjherne@linux.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Tomita Moeko <tomitamoeko@gmail.com>,
 Markus Armbruster <armbru@redhat.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Tony Krowiak <akrowiak@linux.ibm.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>, John Levon <john.levon@nutanix.com>
Subject: [PATCH v2 06/15] include/qemu: add strread/writeerror()
Date: Wed, 30 Apr 2025 20:39:54 +0100
Message-ID: <20250430194003.2793823-7-john.levon@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250430194003.2793823-1-john.levon@nutanix.com>
References: <20250430194003.2793823-1-john.levon@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM8P189CA0029.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:218::34) To CH2PR02MB6760.namprd02.prod.outlook.com
 (2603:10b6:610:7f::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR02MB6760:EE_|CH3PR02MB9931:EE_
X-MS-Office365-Filtering-Correlation-Id: d1f0fbd4-39d8-41e1-d19c-08dd881edc82
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?o8N2kNKY1lZKmBm7qf94K7Xg1QVZyY4ZRRj2qMPk2bC+snLWonXPbjiPDrCI?=
 =?us-ascii?Q?00CIc2+duRRsh/k1ytqnr2djWuZDu1lqiZ8IHujwLh0+1avC/O00IRyE/7z9?=
 =?us-ascii?Q?ORJ9wxFCkZ1whA0+haP6HZ0Nxg2rn5qFFSmz6voYzDyCzcDrhkcKYU2mGErV?=
 =?us-ascii?Q?vRnMKV9YmbMUjb/0OZzIGzTrUnEKQCdEsaTvjgbT32j/uO/YUIqOBS5fc5kq?=
 =?us-ascii?Q?nq3maWaNxNThNKnTuZuTLX8cykiwyrugM65E9sQUrew5soD/OR4j0Xh11M9i?=
 =?us-ascii?Q?40o/bHIIW+tutibkAgnzoCEXXg0G6A+5/oy5nsadCCKkvKIkgVUvEtUMAb0m?=
 =?us-ascii?Q?zWdfkO0j7mXDGTNSBEaUZ1s5xepTnSwWWbgve4Kvv5MC9OxqrECGs4Z+ogal?=
 =?us-ascii?Q?9aF76P73SsXDf4dak7qdHuELaFTGewjDwVdgeqCNGdwmnE6TTeP9KTCmzA6/?=
 =?us-ascii?Q?JqpCQ+VOfOni66eGGMesxTaJNOgIuzP+eznaFKAmqFtHX0uqsanFj1mZAGBB?=
 =?us-ascii?Q?uT7EBdls2CyzYKaF+nwXf0kKY8a1QgAa5meRtCBNLI4segFshbsF7jHiIq1D?=
 =?us-ascii?Q?tdcrZL4PsbmjyXQfsrXRAQxmtRr1GwEyRQ+hjc+zrHrmrevLvRv5Ka0FlDKM?=
 =?us-ascii?Q?1UK6zncHXCzEAB03LcuLvoEW07J4EoT9elCkYsruwHMzv5qMkUczCR1PWNtI?=
 =?us-ascii?Q?+dhes19r29Pr0vOkVLjUAm3dnA9CyzLa5PUHwpdITMZhflLLZrIKlxatteUd?=
 =?us-ascii?Q?GsKd0acqZGF/jaVcrIz2mE2fpHHIX5AkeYZn+0vksSTjZR7yBVt4Y4mpx/9Z?=
 =?us-ascii?Q?IoQ5GHYTyzB2/B3dCnBY0kcqWWnVF6qqeGPJXd22AQ06Uj8lMY1AKVtX9wtM?=
 =?us-ascii?Q?JueSJF/BG2ti59aIe0hZuXio7ODyfovulqhNWmYzJMMCOpf2LtCCX9XWVw3L?=
 =?us-ascii?Q?KAyCmKMsFJ7lyPU7Qm5uc269aUhqS+sJecHPBwxx10Rd8rq5BUxJzLIHSMt1?=
 =?us-ascii?Q?P7pt2UbQS1kNpGyGxogOnwmp0OQ7k4XpItsLtvYB/VQbDY+tzLeQc3Zyzzjf?=
 =?us-ascii?Q?JXqfvhWCS4IVZLxykpgu39VmUZ8BBpiD1SvFhOnJBkfHppXWIJn6B9x5MgQn?=
 =?us-ascii?Q?KaNR7KE0US/RG07nOWNlRC/ILHNOOECsskVJhI/rUEfyDTGKy+VRnXEvYiLt?=
 =?us-ascii?Q?ndchhuFve4uf4i8KYGhpTGeVp0aArDzUmfKMFrwwDkfLMteM98SWKPXJRVQQ?=
 =?us-ascii?Q?s4dqbA/jsQD7TV8K28z1oG2BPXdV/fPJ24nxAKN5T5HbY9CKVE2KUdP74iEA?=
 =?us-ascii?Q?7/bO83QWk4OIphTPSclsGIPgc1gCancfN/muR6E5KJixjWX5Aj6/HFuoQ4dS?=
 =?us-ascii?Q?BH4+QS/kyurNQA0I4DI/kl+2RlLwtE82aeaaHo8ZM5qjdkelkOWkuwlZnZrA?=
 =?us-ascii?Q?gJqUTMG1kAI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(1800799024); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?icyAZH/SjU406Ouot8bHtvJIb9poqF3Tr4gPzz/DTgFNOiak230UG1EWuzi7?=
 =?us-ascii?Q?ZoVLpUaQXmbjsYu/M3f3K84rXuoZ71571RL62LFGaBmf59RgYODB4YJB0pUB?=
 =?us-ascii?Q?l0tKzg9V53ogq60tnAEUP5N45VIFabhExNNz86NF+4rXgo5Hi9CnW2xfxpOU?=
 =?us-ascii?Q?QSdOL8KOp6rqq8s5CTFmHb+wHfOgqqTFEsCruiLQ98yTHPNBxY1RtY4ydRF4?=
 =?us-ascii?Q?IDajsX+aO1RBdNbRa4/rwpAiAdW97GyqQTdmBskKutEEqiKa9NhZkRAsuKcC?=
 =?us-ascii?Q?6OiHdzRZf1ZYMGoIjKAXKUb1FLvddJihD53v3pfx7lapBYD/G6/klrvUiFNT?=
 =?us-ascii?Q?qF6CtK8Y8DGY1C+heuikJwCbD4V7Y2DiRZgskEF08pQpAB+AogyBYCrxT+cz?=
 =?us-ascii?Q?kGBFUl7XbFWsvC0hIGODkEX5uQzQtcktnMZQTCJPcuV4w2+z+JAAvzOFxPIm?=
 =?us-ascii?Q?OSZcRU9D6Uqk1Hed+WsCqKfNPPSNSawYp8yO9QlvXLy5dz4oYRP0WSZiYhAG?=
 =?us-ascii?Q?73iN7gzoDrMWBLlnZ8JXxbdTs7D56giOL6vcladtCqJEx6cTXnNHE4AdA1Q0?=
 =?us-ascii?Q?8LjmeSHY4NubbcYDchsHBaWGOG3Pq1Xcm8JSZWQqhkztpQdhtSRzT7QntjI+?=
 =?us-ascii?Q?HEcKTy00fi77Gl1svJNArRE+QHKshzUvMALxz/vfs3ZF7ALJ9+ecz+0Oyrc+?=
 =?us-ascii?Q?Ap+F+E+GPJ+0qBTGD9gxyp8aHL+1vdy11QPk2Y5Idi4xUFGLkpDXwfmee20t?=
 =?us-ascii?Q?Ku1rKmWaVwGBh+JHcELlfYNmZEBz6PcwQpOe9j+nLxmJj/QeNbj9EUiNPoap?=
 =?us-ascii?Q?mMQN/Ko+MtZFD5TRSRMq8UpYlv7t1fC5n3rlmUGNslR/L91qJIpSYULNb1PI?=
 =?us-ascii?Q?FfRwoAENb/oiV5+STQ6EW3tClZlyew4aACJ0irUdWqAMpdoxEFmOsywLGTce?=
 =?us-ascii?Q?qo1F5tbwPzSovPosj24I5HF36JBorrmmroAzCQXikBoikqkrSkLsgF1qsOVL?=
 =?us-ascii?Q?o31Vo5RAWIlDwzDa3q/LCW9ftjEDcLjE5S2qDcl1n0HzU5y6uB8gOT3WKK+y?=
 =?us-ascii?Q?10F30ALtH9OX/tM1gJq8+3p0XqzDuJsweXcTsDuvJgZ0CiO7dfQFi4MthV3w?=
 =?us-ascii?Q?VVs98Rw2uQBPf4HjRX0/EmhvMbDGpie6d50NodGJ2pI9bOlO2TCmMrPWfjeH?=
 =?us-ascii?Q?6pIuF0pwK558CqNhgtEISrYcV2Ilv7gDF9F+Px/z20LYv6l1OnuAMX8Kw5Dg?=
 =?us-ascii?Q?+QoMpD9bj9cDObcKpfOdT/BX7tHXiZFXJQD4b/Nj/yqqfdszzPP0uZdplOk5?=
 =?us-ascii?Q?5sVrIdcY2Uept+Upa6qX1QpuncWcMH7/52KDduetzfO+YBkxp7Hkw6hGnIeH?=
 =?us-ascii?Q?gxKzTGOgZ7CsJVojJCWBHGvEuw8R3KezbTwcnIhSJcIw5LZ/UyO9oyBHHn/H?=
 =?us-ascii?Q?nwqVmLB25ivpRbWae0RnoXgu23iQVh/tdb+hiOyAxTjNhePhszLqH2TEl+SW?=
 =?us-ascii?Q?4j0IJdHjKnFbSNubnUVI2wYHr9yH+kJCI7yghDi1EDrv/FscYGgKIKuObjwC?=
 =?us-ascii?Q?d8b8bQSmmr1qMwmJKIMlezwBj2KyTPoxteUR5pCF?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1f0fbd4-39d8-41e1-d19c-08dd881edc82
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2025 19:40:28.9168 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pu3WCwQt5ZBmpC7MvPbQJ7tc4O63vl0qCHuQ5W0JPStYxBn1mhrlKx1eN5GEP4TX4uKCBr5bER6mImXALYTU+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR02MB9931
X-Proofpoint-ORIG-GUID: Ycdwzmlt6j5Ed6dOuSZ6NZD40g-AVIrd
X-Proofpoint-GUID: Ycdwzmlt6j5Ed6dOuSZ6NZD40g-AVIrd
X-Authority-Analysis: v=2.4 cv=VITdn8PX c=1 sm=1 tr=0 ts=68127caf cx=c_pps
 a=CbxOEkXH4sIw/lcH++vrDQ==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=XR8D0OoHHMoA:10
 a=0kUYKlekyDsA:10 a=64Cc0HZtAAAA:8 a=peWRwobBIUiJGWitIvgA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDMwMDE0NCBTYWx0ZWRfXx+N1Z6QAkxcZ
 9tMdAtFtyQCTztALLrVkk93/rk8/AUdrVsE6m1Dy/GJfrrlID0+3H+SmavU8YhP3E2Nmj/4GBow
 /gEdYPq/bEOZWfl63/xIWT8dEHC8Juc1zvNrrc3hTtR0o09VsOg4phCLL85HjSGfYQX+9QstLKH
 kR08xpnJXgMrLuYMFQRNDDaKegWBXB6gRom+DdWBjABPnNp5NhS8lFFYh6dOO/Ufh+gquLYdH/U
 Uzh1cXSBa01BTQA5u/810Oor6hzvwQ7tljBjp1FgNCU971ytCeINdPOUJnXxfyiZMfiE7ogQLdz
 nyQYlzAozADAthln9V3R+ACSmx+wxSfje3ZWy1bvQ8Jl3U2IlHJPdh5pPb2M9cvZ+icPmqMyaPJ
 SFAV7FaAojXLfZp2kKNKfdv3dGWGGhZqCAC6v2s+oyco0R4aQyzptoBWtTyaalaSWvUpyQZM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-30_06,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=john.levon@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.483,
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

Add simple helpers to correctly report failures from read/write routines
using the return -errno style.

Signed-off-by: John Levon <john.levon@nutanix.com>
---
 include/qemu/error-report.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/include/qemu/error-report.h b/include/qemu/error-report.h
index 3ae2357fda..67afe5a020 100644
--- a/include/qemu/error-report.h
+++ b/include/qemu/error-report.h
@@ -70,6 +70,20 @@ void error_init(const char *argv0);
                               fmt, ##__VA_ARGS__);      \
     })
 
+/*
+ * Given a return value of either a short number of bytes read or -errno,
+ * construct a meaningful error message.
+ */
+#define strreaderror(ret) \
+    (ret < 0 ? strerror(-ret) : "short read")
+
+/*
+ * Given a return value of either a short number of bytes written or -errno,
+ * construct a meaningful error message.
+ */
+#define strwriteerror(ret) \
+    (ret < 0 ? strerror(-ret) : "short write")
+
 extern bool message_with_timestamp;
 extern bool error_with_guestname;
 extern const char *error_guest_name;
-- 
2.43.0


