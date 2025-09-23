Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A942BCAC5A7
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Sep 2025 14:00:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v13Vb-0001Z0-1F; Tue, 23 Sep 2025 09:56:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1v13Us-0000AW-94; Tue, 23 Sep 2025 09:56:00 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1v13Ul-0004Ho-Tq; Tue, 23 Sep 2025 09:55:57 -0400
Received: from pps.filterd (m0127840.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 58N80i7R1645142; Tue, 23 Sep 2025 06:55:16 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=EaehfVkKfYE3eViPIbaW7AAGr0lh+zWocTEeMnFrl
 l4=; b=gPXX7jdPJBZ5LpTeEe7OBBC9oHlRWP0WtFEz/87tHTU8WaYljyUFIgVwj
 dlK/BD/bL18/98xcn87fx6KBn7GB5kDsvEft1aYUzFMHOSv/AQL2fXKeCLFkhE+4
 cd0h7cFF1d+0aQC/XGgDd9zoYX68GDEzzpLGpBLhp5OAwIvyvQQssq+xUD9DA5cU
 HpuCGS2cm+ZJWCeVFkaWZ7O8DF9V9OYsoq3mgXZfdx79E7O2xNVxQNcF9NzCio54
 5OsGipxNb7vGSY8uxRMcuCvJbUF1u4VvWpC6rugWzsSpc9osfmKV/Mr9CJA+i7AS
 3O+bCTBReCA16a2ZGd/a+NPXqataA==
Received: from ph7pr06cu001.outbound.protection.outlook.com
 (mail-westus3azon11020091.outbound.protection.outlook.com [52.101.201.91])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 499rkrp5xk-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 23 Sep 2025 06:55:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vv7o6aHoFvvaYVA1F1jyxeEfn2SfpscyUWTS4SNsQVJofhUf4hHl+3dxWvQdxQ8+WQwN57REXfHL9zDYrPSTysxeVR/TS2xA6A2XQla6mWThtpXUYiwsvlI/mEbAgl4mky1pY2aG/ojfY/wSFqZcbeIqSDHRqiJMZS+LQNjRCfRYnboI1nawR7/spb9OYgrJ5S/3sbHNnM1T0U7giMKZRDNHmhe4xYoUL5GUXai5AzifHt8cO4Y6//VmY4MXDdgKzURR4uee8crBjJLv6/mpT83wrZMIpaOwyAV+10FetxGbVXB/85MmP6gY+dRrGfztR/tszf2g//IwUDWeOf2OJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EaehfVkKfYE3eViPIbaW7AAGr0lh+zWocTEeMnFrll4=;
 b=g5R3/t82QlKqW4zuG1F3ha/jC4cqej5GshLYXk5xuYG5fnoeQaSQmBobI4+TumFOJR2AK4UfbzgqcAdr2Zc2C0G3EJVZhLFQQTHBjwRhervN4jmB81+nLyQrBoqU324b0/KEhhIjWQ85kp4JN43WSbvi+j9yK1eVSO/4nHPIDhVrWGAprcwQkcMxC6OUatlmN6Wh7Y0StljueOBGwWeFOabXT9P6v7iVwizJ9xM4a1sYmhAmjM9vxfQUAD9h5rFBNfoTJ8y7tHkcBVpWzPQEwug+W3FpF+ZkO3QO8lN+9uNGYoG+6Dh9C72HTGAN0Iwd0Ty/RK+7WBoKcNRCNzwBeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EaehfVkKfYE3eViPIbaW7AAGr0lh+zWocTEeMnFrll4=;
 b=m/It4e4EZWmuYvsfBqa2BIykBRbx10NA/AlbUKosLyzhCCRvclQeiTRVmTRhJddl3VKfSDzlZVrqRpLFgeJmVO5FfRnUo6AzttwcEt6x7WNYuLu8C0M1k7AhLY+geWv00h2AkaQa7NedB2nwuPsKTNnnIxeakzPwQJm9exZMEbGVP9ocLHyNAAQAMuZ/+OzX3Gnmg8Nf0kAFvRb08rasNU27fPGR/6+eOZUqqxD469rh4U7XRwKMj7Hz0ehnRVKppHrflTBjx1H8ka8m2aXt7/JsoNWIOgKqiuWbzTXge0ID9/Lwi2dqo8uLak0d04CJ8AAp3YmoDPd9MzzLUvGBtA==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by SJ0PR02MB7742.namprd02.prod.outlook.com (2603:10b6:a03:320::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.20; Tue, 23 Sep
 2025 13:55:14 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88%3]) with mapi id 15.20.9160.008; Tue, 23 Sep 2025
 13:55:14 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: npiggin@gmail.com, harshpb@linux.ibm.com, mjrosato@linux.ibm.com,
 farman@linux.ibm.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 thuth@redhat.com, richard.henderson@linaro.org, david@redhat.com,
 iii@linux.ibm.com, john.levon@nutanix.com, thanos.makatos@nutanix.com,
 clg@redhat.com, alex.williamson@redhat.com, steven.sistare@oracle.com,
 qemu-ppc@nongnu.org, qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Subject: [PATCH 21/27] vfio/pci.c: rename vfio_pci_nohotplug_dev_class_init()
 to vfio_pci_nohotplug_class_init()
Date: Tue, 23 Sep 2025 14:53:27 +0100
Message-ID: <20250923135352.1157250-22-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250923135352.1157250-1-mark.caveayland@nutanix.com>
References: <20250923135352.1157250-1-mark.caveayland@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR04CA0114.eurprd04.prod.outlook.com
 (2603:10a6:208:55::19) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|SJ0PR02MB7742:EE_
X-MS-Office365-Filtering-Correlation-Id: c6673a02-eea1-4504-a973-08ddfaa8d1fe
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|10070799003|366016|1800799024|921020; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?d7J5tsVD8JDEs8IteV/EuSaBdY863UaH8QPBavgfARSmcuBcOqnrt0sVo4tF?=
 =?us-ascii?Q?p0lGJfDfzG0ckRnhmMqZEv0epJ+QHMjT2DeSTvFBQJRGf5dQSxp4Ld/Gk567?=
 =?us-ascii?Q?QPyEqwCviV5YxmpTWZOPSgCtMAg6F/WbqRbkns9V5Fdd4v4taG9Y6IQjq57z?=
 =?us-ascii?Q?Wp4fsAAvsd2f+oeDXUxOc//TqkKrN8/HGK2nsbi0/5JXHKIm/8I0XUH4/9hs?=
 =?us-ascii?Q?7OcaLjBIkX5hKRzT2gXv0kseIMRlmzXpRly9fngmK/FNqckk7+WcBRRDYTa4?=
 =?us-ascii?Q?IpXUzdu8MqOdXKi1fHldeROL83Yo9q7NWjWiheMNLoLXm5NAMJJzbtIJBTJY?=
 =?us-ascii?Q?mccXsMnbcb+LX7U4UiinqvWqjBRFjOi1J/eqpFZ+ZKytzr6A79K4/+ciyvL0?=
 =?us-ascii?Q?Pbqe3XWehnVCiDillzkX0fXhXmQZv4rHnWl5s+BwZQnyHLGOV9dOw8FNVHnw?=
 =?us-ascii?Q?x8hSpIuZuBB04sootueQkAtBQOe3hCvntTHpOP+3IYOIxw2t2azU75Ui1XhS?=
 =?us-ascii?Q?I9KJOuPrGCjgUQBZOEZHF2UUrLP8n+hdb99YK/Ob8EBkrzW6f/kyuzgCNaYE?=
 =?us-ascii?Q?owXBQqQScw6AYU79uK6XnXnrFO0RGa7dySpb5MO8HuuyFHG/zZM/73xbJ7uR?=
 =?us-ascii?Q?0ax8C/EMfoF76h63wGoqYDCCOIBh89KKGcrEQ0dpIPjInEfTk0ejuinvYKFt?=
 =?us-ascii?Q?FPYwFRCtRXD3QjmdUHvwLI3Uqxt2N92k1mxN8fZG/jl4Q6Cirvk/+zwJ6Tal?=
 =?us-ascii?Q?zt+l0bYUY871Kc8WoGzIZ+jwkthQ1+g91y2bPM01MeXKeeBvyI9Ybe8kpbD2?=
 =?us-ascii?Q?ZTJ5ZCcZKY+U/JysKrIiwjCEogrj38zJruDZz5BuKE7tdMFpldfWBJuEQ0Z0?=
 =?us-ascii?Q?waS6x3gyEIG16q27WhnYHz6O31+yrFq7GLcE3HTPGEUUIL5riOpBqgA0c7TG?=
 =?us-ascii?Q?rcQ9LVcaLQQ5qZFE5LkuKrXGmUKaOL8TZb95GJQJicgDPSsUsIG1EkNZH1UX?=
 =?us-ascii?Q?nxOWufZMVLCfCswU4RhjjBQEkmv1SwoBskNkQFxJZcHllSuMcU4SWuh4U/JC?=
 =?us-ascii?Q?hAeh6MLqQ/3lNdLMyXPtMaQtums+Zt1wZlfguaxI5ZGAMvOmtrpOQN6/1Gwd?=
 =?us-ascii?Q?qg+7iYc/nlcCUPEMHw73C2GSghqPfYLN2pFa8vQT+xRcyA0p3Uo6/Lr8U7LX?=
 =?us-ascii?Q?ce07f3dQJbu7IIuVEA2CzC83mo9kFXg7MZkKvTS9DHMJuJbRV8tYyOp3kmeP?=
 =?us-ascii?Q?yESr2pkrY2P80Wcvy48vsl5GihBMjno6Zj1Uqxi6bFKfbSL1dlBsa3eCz5cK?=
 =?us-ascii?Q?GKfrL5/QueohqK17behZinsP4R/Vz34GSPfz+84Zs8V65qsYvICF7TJgTn+C?=
 =?us-ascii?Q?lVXmoNwOUUI1Y/mw35d5M56jWSwA9e0YdTfHE3asMVtmaECGj+yRxWgKAPPN?=
 =?us-ascii?Q?iGjPAI6eVnGkhuHgbDc3puVBfPmQZYOWLd3ZyKQY0QZbhMpdt7sERQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(10070799003)(366016)(1800799024)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?c86xgTMc/rBP+1ocWbWFzSqxQrIgxv4ZjivORhaFmmQ8XtZ9YMdYgxfgUPNQ?=
 =?us-ascii?Q?/mPlN4SphHN3awMt0y8wxr1BckRcO7wJEsS4U1vfKBcIhvsYSDb0owvWuYHw?=
 =?us-ascii?Q?1AvAqD16XYFJcf3oMzAlkfVZhWCDBy0SWg+GRyXG4V1/gtDmHh2p12S34kib?=
 =?us-ascii?Q?ZH+WcDUCV5iBa4UV8zmdUQrzcWP6O66E535Rbxdb6nn/DLCFTiGSK9Z9Wmhc?=
 =?us-ascii?Q?F5ML4UD4Vr1EhbfSBZlPl6J67gRRO6MonJtRcZQh0xWBP6QqCHY5qvD3h8iE?=
 =?us-ascii?Q?85R3oYv2Jl/E7BL6d5TosZAuE1m3PcuucNACotxvUmAFr3nQVg1kSUT546sQ?=
 =?us-ascii?Q?K8JkQvmF0E5SqCwrg0BgnwzawXkNTEZU6sLZvwxUVc6W+UxX3Eq2vt3I6SEz?=
 =?us-ascii?Q?zWbVePkxhAfAHly9m1wToQ/HknSTHHEAJvEaLgFVl50/RudsCp3DKarIwWHP?=
 =?us-ascii?Q?UrQusf3/rufAYByf8ohKDrEFkHMuzDZ7R6FB1onPsUzxYjpoIwT67LZ00Wtj?=
 =?us-ascii?Q?bCb+MK3Xb8EnFOHdCrw/e8TjUOy/Y37zBnprIH/OchCVg16KjtI0hPb/x8sg?=
 =?us-ascii?Q?SxqEvuxcmRIoaDOQLhJAQxOINF0JBUR0E5EOwPoDNUW2T6eJJT1BkTpt5BDx?=
 =?us-ascii?Q?az7MYL0lpvVycs8oAZiF/GlYAWFxppmxo0p/AmF1XS94N3lZH0QDQt8RY5C+?=
 =?us-ascii?Q?+A8chnZOFFkgmzLQcKSsugRSXhdVlegOcvoqv4GkRiiICIxc5dsrlLoRHd4U?=
 =?us-ascii?Q?w2rcP5YO9mUr3QmxnILw6p9X1PLCclJajyjOuCeEINyXPvyZXjIr1I3QgDtP?=
 =?us-ascii?Q?MX00xPHSV5D9BQKI2vLr5B1x2LCOskYpAt/o6FCdisR9R3txSPVjHWV3nXl0?=
 =?us-ascii?Q?EpxSnsinrKSQ+ddpRCQ0GeafR9+i6aoAkCOUu6YK6C59YkAxMLwVpd6brUcA?=
 =?us-ascii?Q?gxNqJ9fT9DF87vp4D/UP7rc5AMlegijyNMAdxsLoKTrW51loxuYloVngAbrQ?=
 =?us-ascii?Q?XG03u8KmDaLdQ7xAS1k/rulhX+JfCqHo/Rk7ZxFMEtGcoLxHlDYvLjnN2UGW?=
 =?us-ascii?Q?d/R8Gky06Ko/pBeheVQbLt6eAacTNjz9cRr5ynFQw5SfLPeKuq1Pi5T/kTTF?=
 =?us-ascii?Q?wtUu7lIN/mhL0O+7NXVC6Ywuzpcz/mr7pwZ6m6QxD4zHnzregRMTkMgL4WFD?=
 =?us-ascii?Q?G51DUWxN2bvEIrk2qyiFTUbyCdu+0O8ycvye42NG5urkA76bWJKfJhXbIhAN?=
 =?us-ascii?Q?290JVKmtTFgKej4ZWL3IptXoXUWiR1nBLjJ/ulgVin2ZXF5i7I3sksxqaber?=
 =?us-ascii?Q?Pre6mnQo1r2Ia/REeN8BGslsCsLh0lvdkktQL0cQK0spN6KB8Gm21RpFglWV?=
 =?us-ascii?Q?TLC2fm1wq4iVzyINUB222wG8FvbUdERDEcWZ4tLLNHMQ6CcC9R2fOWr0wJL/?=
 =?us-ascii?Q?Z0xPX22W8JLtqJ/U+kA7SKrpHy+hroGxI3DnFSEqYJ1jIs8FXnkXbyqDtpQn?=
 =?us-ascii?Q?9OzV/NV55ZLdaWpzCRTT8VdQfsQbfdRK2Y+yYh9IqBQA1ae+JO6rsiBxaab1?=
 =?us-ascii?Q?GH0StVuWi3D/2rh7ePSiUshqbxD+pIqr7EBriOZG4raQLLCxYz9yRThNpHJZ?=
 =?us-ascii?Q?qyrNtmlvFea3ygRawjGGgqCgJZ0JENiWW6BBjBMcyMqOor1JvtHRvfz3kYgr?=
 =?us-ascii?Q?3OMrIQ=3D=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6673a02-eea1-4504-a973-08ddfaa8d1fe
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2025 13:55:14.2065 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cJVYJ3kBkwqdJXUuLlYUMMjitzjQrQcf7wDCdf0BSy0YRQ3dppTSQiZ9SlN/WgXfaOVnK6qHVH9Nza3OkFhFZxojZ/TdUhpotR2NPQPRPAA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB7742
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIzMDEyOCBTYWx0ZWRfX7/WD6HykgnDu
 qKGCl/+aCXxs+IZFyHjsPYsxMaYGMmexz3cDLLhXgWmzbFUWchh9r4Zdmsq8HKVBPK+2Tk17NWh
 hmqFC+oFod3Eikid5spwxcM3gnSpCvXm6DnG8KMV5PpTiOhN3HKQqKk46waxjADHTgw29F5xGU8
 Xw7ebeiQRxvk/dI9Oh1elowzfUIVRKvBYSMhTNQXkeHqMuvlJ6+UZx2yRTPdGjgtPcvIM0H6fyz
 DkoxMcLJgTLEKJyVuTA2X94iRmIaNpb/XxDF4myeThM4CTZry8Hld3MzpGHs1cgvfnrewyoWBaN
 9zMpzpFlRQ8Drm5tke0bTuqX0dgtIBI7mQ77DiQIyFL4yL8LZ6Wd1YAndmFd8E=
X-Proofpoint-ORIG-GUID: V6hvXAXE8N-3OPWtcmuDTbZcyt2nps5_
X-Proofpoint-GUID: V6hvXAXE8N-3OPWtcmuDTbZcyt2nps5_
X-Authority-Analysis: v=2.4 cv=eaM9f6EH c=1 sm=1 tr=0 ts=68d2a6c3 cx=c_pps
 a=XRAB2LWAunOdTDivPrw6VQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=yJojWOMRYYMA:10 a=0kUYKlekyDsA:10 a=64Cc0HZtAAAA:8
 a=udP_5BOVWkZL6ct6w7QA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-23_03,2025-09-22_05,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
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

This changes the function prefix to match the name of the QOM type.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
---
 hw/vfio/pci.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index a32a507059..ec60bc3907 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -3932,7 +3932,7 @@ static const Property vfio_pci_nohotplug_properties[] = {
                             ON_OFF_AUTO_AUTO),
 };
 
-static void vfio_pci_nohotplug_dev_class_init(ObjectClass *klass,
+static void vfio_pci_nohotplug_class_init(ObjectClass *klass,
                                               const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
@@ -3957,7 +3957,7 @@ static const TypeInfo vfio_pci_nohotplug_dev_info = {
     .name = TYPE_VFIO_PCI_NOHOTPLUG,
     .parent = TYPE_VFIO_PCI,
     .instance_size = sizeof(VFIOPCIDevice),
-    .class_init = vfio_pci_nohotplug_dev_class_init,
+    .class_init = vfio_pci_nohotplug_class_init,
 };
 
 static void register_vfio_pci_dev_type(void)
-- 
2.43.0


