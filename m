Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15CEEC88E5C
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 10:49:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6n8j-00012u-S2; Wed, 16 Sep 2026 06:45:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1x6n8Y-0000XB-Fp
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 06:45:11 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1x6n8W-0002ny-6l
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 06:45:10 -0400
Received: from pps.filterd (m0127842.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68G7x2ou3215142; Wed, 16 Sep 2026 03:45:01 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=b4a1VVZQ1aZOauQn24XOWH2/qUfMYMvEynGh+kmjS
 lA=; b=y+/5AS/N2zk9y5fdI5wfAb97v8e+ELn7SYJ4vwpgoPnIzcczycY7gGvQs
 3/pPrSOYGQqAVo0NuWwndRO0ngKhvmZ2qij80i5msmEYMoLbECD11K6thlRloJbN
 LpGzEi6qQzLhhXpYEcjB/z+nfUMgM5by7IQz+cP1GKJEdl76TigRAo93wvinqiPq
 y2mEA60afVjalh3ytcmCG6fcuDoh/jK9LHrSa6QqMW9dqskhoiLjL5JpGSe9PJSu
 tKNTiuCxIxWsNJD5BE6IlWKZURWxFH/VDu2VGRG8PlmL4Bx/GKWrRelStPBtumsU
 JPaStMkDUhzsPSU2fA33Dy1NiW8Kg==
Received: from bn1pr04cu002.outbound.protection.outlook.com
 (mail-eastus2azon11020125.outbound.protection.outlook.com [52.101.56.125])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4gqbt7a0e8-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 16 Sep 2026 03:45:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JVrSN/8qfPXU7fBMOlJLhPTSEqOqIZV6uFR0YaEk1v7DBKKvkWVp7Oppi4YzYyBXfT9I//iZE0OADALjnMuK9Yciho3Xe8uQ1OpFAUe9e6A1RAV8h4kX8X7slC4F1cUrC4pfzsBo1tBc5HToYlMpuICr/YJOVohWi0RGNPQglRuhWsONJfhXIuNWS0M/eQHKsqU8zkoL4ft+Gxyb3QKTz+EOqeq+blwkWV/kFXRVQC6WHGTUjs4be/u5KuuDR8TaZewMUvKGLJ2Z87KzCNUxYwElQXwtX99d4itct/z0gegpOn86y1caBxxsFn+689lXSVb9Il2zQrLg/AC7G57bww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b4a1VVZQ1aZOauQn24XOWH2/qUfMYMvEynGh+kmjSlA=;
 b=XJmJEYb1XbNefDZHTOgbzcddC3unWyAYyPY7p9eF+eQJsuRGhhBX4eReBa23o5DHl2WOYt364AlgAmRkw9fZM+m35RsbuDG/stfkbpi/gUKdy91Bg/o5c72fbrPXXqsUIVhok0TYTfRVGJzIZ1gXazzrLAiDDtnMkGWU7EZ7Ho10kRTxD67KALL4gcNxV4nG18UBVMuTbaJCL9xvqqQjcnrtrm+EA8+MIXo5EmPM/ASP9h3PhUzllk3Xp0k/houNuWUVUH1tabDNdFLvjvO1T8p3H5NDuaZZSon+lnuC5WWkkMv95TtqAs1SJtzFEFEfWQvlhmGOOqBSFb6PBq3i1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b4a1VVZQ1aZOauQn24XOWH2/qUfMYMvEynGh+kmjSlA=;
 b=sNPeExw1tAdIH9+QfxnsDQ4DwtMJfvsIBb6qIjki+eUC11DGcFWZ4ni2qYOQQZ74ODNLKTsmf6+knzjL/fXJu0RCIyAsF0SFg3FpYcJ8YFnG9kFOJ1xIY8nZr/yNhLrM9n80WNNP1VDMlfMBvYSQX7Qrv808l7oWe61DR5q/xeX41BwVaKI4cfDTjoZpAJVtGkVmEWhk926rzF+I5bCoofEY9L1oANkclQ2oLv46unB1428lWfQM5r7IEJMWlgrFPqerXU4ih0mZyYvQZCNjO1enoOU05RW9j3ctyqlx/dMzj471cJQizFd/2yXQn4Zk28BBQ5rXJPcGGnUVNIqKNg==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by MW4PR02MB7380.namprd02.prod.outlook.com (2603:10b6:303:74::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Wed, 16 Sep
 2026 10:44:59 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%3]) with mapi id 15.21.0406.007; Wed, 16 Sep 2026
 10:44:59 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: pbonzini@redhat.com, richard.henderson@linaro.org, mst@redhat.com,
 sstabellini@kernel.org, anthony@xenproject.org,
 edgar.iglesias@gmail.com, qemu-devel@nongnu.org,
 xen-devel@lists.xenproject.org
Subject: [PATCH 06/22] kvm/i8259.c: move parent_realize from KVMPICClass to
 I8259CommonClass
Date: Wed, 16 Sep 2026 11:43:34 +0100
Message-ID: <20260916104435.600211-7-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260916104435.600211-1-mark.caveayland@nutanix.com>
References: <20260916104435.600211-1-mark.caveayland@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0252.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::17) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|MW4PR02MB7380:EE_
X-MS-Office365-Filtering-Correlation-Id: e108a641-3265-48fb-48b8-08df13df8e4d
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|22082099003|10067099003|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info: JiKH92oK2ZnSvZA2C36llbjqvWUHpdy/5Tlkt2075BxWtew+XOBkirf9oXYeXeYJRO0xu+QaHwLbeT9LKOqzkmNdXMA9EXzj8hD8xuZ64fIuH5Xu5Hlts0waUtr6Ny7Oj+P05heEfnHCH4Q2BQigKyGyOcvQ03/39qUUG3i6Axd1IZBvCq8QBZEwQ2VMmq8yLXzQkgj/3WJLXqZvEOfYO+Zu3QeBui/qjb5+u1ySzMxixF+bw0IKUiEHrsVAC9vYMIOqll6eKCYtUS9FKTFduPWJMBnOmM2ojy3UrHRRCUgVmcW3iR4lPmzaYetrCqDm6sfv4PkHq0NpuMnWvbjQsvph+3ktyv+2zmAPE8u2bVJYsWWjIDB9LXIXWyzk4YDVKgFykhb4SVXx57sXeXbfGSCRx8WkWFl66dRjIGzRqSG/Hf28G0bm4ZU1zcAfLG5YqyMSbUeJEHV5VWEkrmaE57x7Mb52zPba3IkIh6tmkD95flvMJJIzMRjnFJ4aM3JJHd1CjN8cmcq52MjkZqBwaVLYcakC/f3NWB8LiJczxotfw4QI4/H1/rLXAjAT9t1dunfui5HXIBqiyP/B+69N/7THFEl3rv/RbOJj14OQeXCErGWVm4eFu2bgLsyLFR0UgsqFd2oo9tpd2T7tgFPQS72zbAE3OkzT7lB7/hyLF5M=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(22082099003)(10067099003)(56012099006)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zPPLT7lKRItLPOrDAIBZqd3XWcAmH3wHY6dyeVzBLM3/P7u8Bcx0TrdgsEed?=
 =?us-ascii?Q?M2tjS1mTcT6hwCjQoD+I1dLT+uQc57zLmlBI6T29w+flFRIScvOTVs9s0yFq?=
 =?us-ascii?Q?Ld3MEUD9jl7unsaN3QHcfMwcR6sB7akL5TvFSNuhzkuZW3MQQzLKDeRJQCWf?=
 =?us-ascii?Q?tduU4HdpIjlf9vzszOEHI0eWriKCH40v/5HxSPhM/xMGbSUngMdmQpiH9reC?=
 =?us-ascii?Q?CNR5Ug/RczUwF4zbc7bzMD9JQWfhODHh3MBYdtmuSQyqyNpbRTQ41o/dsoXW?=
 =?us-ascii?Q?qlpAolxrDKBnpV2qvVm38aRbT48hM3u0wZwYPxmdKh8kQNgaKie6bvwAn7JC?=
 =?us-ascii?Q?DGzIdY8C4YXs/JL6Zv8JGUt6HOcfTx5mu2Jd4mVh5+7skzeNLqGcfqJjjn7F?=
 =?us-ascii?Q?Ge1vRl2oC0dz3BC1mDPW7qKW2RC/LGZKAQzXIW2H+KcOHyeq8TI93hon7qSj?=
 =?us-ascii?Q?NqFfRl2Abn8/d1pCmCLBUs4ZhPZoKLicsbD9WB4cM95EAcbgVI7be1MTTNn6?=
 =?us-ascii?Q?ocrPBgJ+m+aei7ygKecX6FRrHpVysT+FtTJlruwrZXBfV9B08l0CzCTUo9Wb?=
 =?us-ascii?Q?dIng8Q8wPwpRtg1DFWo+i/bD7Xnud6HuiL1Biaw4U/qlE+e2u1NO775OG3rc?=
 =?us-ascii?Q?kRqYFR2Fc+qcdOa5/4qlVYHMoCo0wsjj443hPGUlfK4J0R0yipDcDMMvep8s?=
 =?us-ascii?Q?fTov7gMVVnr1nUy5pMSTUw8qBdl8g+CVKIcjc6diUgTFkWbSVjsUc/cfBCgZ?=
 =?us-ascii?Q?WoXArF/DoNvtdh03u4yC4/K2eYcseh8wkJ+/m0N7Sr7N/zLuyAcHOV0qijyt?=
 =?us-ascii?Q?BSLRq3b0CTlqj1ufYN9DErY717b2/sdDPieM+Hn7W5XTnp8LHIBvCKGs4Y5M?=
 =?us-ascii?Q?po/R/5ZZazCZ7l53u12+dajHDTui5eoimRrTI8cBFo8zRKOyxsbGB9VQzfTp?=
 =?us-ascii?Q?MRQHc+c8tOpWQUiXMTfEO3z24Scm8cWR/J4JKIDkLLgIcXhtwerniKd3P1/S?=
 =?us-ascii?Q?foORxOmVw5hDe++ArAHVaecvrDrYAeGRgUyYY0AGFLPV0cGmPkjcxncK93gJ?=
 =?us-ascii?Q?czPY1A/f8qx2qIqg4GZrMAgVIFio98vev7UEZlohL9UMEUSY7sL9FGyZ47Q1?=
 =?us-ascii?Q?jvFtxn1/8vftfVnonXI0Ofq2img95C2JX+yADYK4ixiuuAzA8MjYyaQG+ue8?=
 =?us-ascii?Q?K1lbrXOqV+4Gz7WHRztdB+7H4hLuEhWmn80fGetZKRcpOKcTOKayZDUqHRkA?=
 =?us-ascii?Q?ETINou+l4KdlMjMHz4tnt1ZgjLtKM6Jh9iJPVJnP52iMEXeaDhAHERAiXzGr?=
 =?us-ascii?Q?Konxe8a2m6WlLMt5PmXCGKHbqdYiGoXbtslcK1vhbPP42KiPzOVDLB0Ly0zH?=
 =?us-ascii?Q?yNqd+sQtHK6j3WYnk1XzcvRyjkjX9dcqtZ/fopJU+XXryUrEehpSIyrYR2Me?=
 =?us-ascii?Q?knM+8UQNWZ6iWeZXrffGO8z9s/P1QlRcNT6UyDmsX5Xaw2M79JYjX/g5OlD5?=
 =?us-ascii?Q?aBA7zf9PFUKFC0/Sy8YIRHFWrMEs7SE9S4FbS6h8eqLpimDIYDiZtcVHxAMk?=
 =?us-ascii?Q?aNAA3uK7fHkamHKKkOrd4UHrNmGfraUK0A79yRbH43DjwtwW/W0RFoIhg2QQ?=
 =?us-ascii?Q?dLE6DXkgpl/ccpBzc5Mpk8VKpRvz7Sv5Tza0uTTnMuf4iX41y4e1nfTrSVqS?=
 =?us-ascii?Q?+pYPaapwo6LZmUXTguLEx6oIpstk+BmD9sH2eh/klSTXZgM0y8371tiRsl6b?=
 =?us-ascii?Q?174Tr6MgZnWtv4Vs5RAay/F3zjPFqZ4=3D?=
X-Exchange-RoutingPolicyChecked: UbL2DofvExxBA5nP2qQWuCNHhJJ3/cceT9t7VlbFNhr5TnlccQeB/FqX/G3iJ3JpKrSjUyzk4lQuQ/9zg1DjrZOQQ5MnE/3KGtxIvGrShI0x98Si2ddcyXw4T12j+x1yEpzoYxr7dyYho0hUe7F4qPYr644hWp2zw2j9ZY9oojy109S2FVnDyhEJQzxeGExmFTceYHKaa6G6D6D1+y+R9A54+z7jDxKnJjv8Iw5jdZmxjjPuAOgQxs2ts5Vhz3Gihi5TF6v1kJ4/xeIPNFx8Lv7VPv4/iIsyJ9yQuJbyAg0IbYwGjf5sVWMpx7UDoFtm2becNGl3Tf6IFx8CuV97Ww==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e108a641-3265-48fb-48b8-08df13df8e4d
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2026 10:44:59.6645 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uiieCWXnTHntT4i2VSTPG3vfEsPGdlT5+h+L8d7yW/A6N06OLQm9dIWtaN1MNLmJCbw7hen27r0ChvG3tExPXzH+h+Lhjv7ztQc2/hAi/FE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR02MB7380
X-Authority-Analysis: v=2.4 cv=d+pgWhjE c=1 sm=1 tr=0 ts=6aaa732d cx=c_pps
 a=qoAvcrxUHY3FHMzwJxUv3w==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=VdqzKS8jKosA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=VUi8bpU7OL1Oj2-RSIOF:22
 a=64Cc0HZtAAAA:8 a=JoGAwIMGT5QChKfUXAUA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE2MDE0MSBTYWx0ZWRfX7V5uxCAVch/A
 FB9NntY0sY7NiMCrVuy9asnh832qZCQ/k2D/k2AW58C3PjbuNkRLmLngGrgaMALSaTF1bvb15Af
 SrzWLe7sGT+DRHlrzycYNQOyt2vRtp4q5N5b65LjL65jId07QZNLr2RkStOQ9Z4vVxou3BzyQjl
 oJW1dr7/w83swce2VcdPRkrDiYk6eGFDpQNw64UStKazF51p8QRygpuchE0tvgC+w6LBNTi6AmU
 cv6xMkQ+xXu5FqXofGTAV5xhD9NZPp6UWiS3UEswDzBTz5EEf+wAWicniN9KnEWJQuquciS0fCl
 gPm7j3rQuJtg741i+SL0Njw88cDbujmVvhawoha30nYK2UO/8MbtfP6oBBeiPlqp+iMBCF67yDV
 raFVw8Qn1o2Ax+S23KCpcelTpBSFI0nDDqjIcTY9c660EjaqSmxb6Oai3XqAq9keuaE364brpqu
 5tqjKzKzBWYNxQq2BKA==
X-Proofpoint-ORIG-GUID: LN-aDWzHnMxDCbWYLG6YZL1HgNvVKXCH
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE2MDE0MSBTYWx0ZWRfX4YCkNzbTRQeM
 dbXql7nub+BF83MsqbvArBUT8J4K8R7EC3LCm0UGU+HbdBRS8gEnM9WalX5/F/ezOIU6Z967Dov
 jUZCb2SS5LwvGc3tFNhZazx7de85xgQ=
X-Proofpoint-GUID: LN-aDWzHnMxDCbWYLG6YZL1HgNvVKXCH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-15_05,2026-09-15_02,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

Move parent_realize from KVMPICClass to I8259CommonClass and remove KVMPICClass
since it is no longer required.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
---
 hw/i386/kvm/i8259.c | 22 +++-------------------
 1 file changed, 3 insertions(+), 19 deletions(-)

diff --git a/hw/i386/kvm/i8259.c b/hw/i386/kvm/i8259.c
index 68607d721d..bcfed11a3a 100644
--- a/hw/i386/kvm/i8259.c
+++ b/hw/i386/kvm/i8259.c
@@ -20,19 +20,6 @@
 #include "qom/object.h"
 
 #define TYPE_KVM_I8259 "kvm-i8259"
-typedef struct KVMPICClass KVMPICClass;
-DECLARE_CLASS_CHECKERS(KVMPICClass, KVM_PIC,
-                       TYPE_KVM_I8259)
-
-/**
- * KVMPICClass:
- * @parent_realize: The parent's realizefn.
- */
-struct KVMPICClass {
-    I8259CommonClass parent_class;
-
-    DeviceRealize parent_realize;
-};
 
 static void kvm_pic_get(I8259CommonState *s)
 {
@@ -123,12 +110,12 @@ static void kvm_pic_set_irq(void *opaque, int irq, int level)
 static void kvm_pic_realize(DeviceState *dev, Error **errp)
 {
     I8259CommonState *s = I8259_COMMON(dev);
-    KVMPICClass *kpc = KVM_PIC_GET_CLASS(dev);
+    I8259CommonClass *k = I8259_COMMON_GET_CLASS(dev);
 
     memory_region_init_io(&s->base_io, OBJECT(dev), NULL, NULL, "kvm-pic", 2);
     memory_region_init_io(&s->elcr_io, OBJECT(dev), NULL, NULL, "kvm-elcr", 1);
 
-    kpc->parent_realize(dev, errp);
+    k->parent_realize(dev, errp);
 }
 
 qemu_irq *kvm_i8259_init(ISABus *bus)
@@ -141,12 +128,11 @@ qemu_irq *kvm_i8259_init(ISABus *bus)
 
 static void kvm_i8259_class_init(ObjectClass *klass, const void *data)
 {
-    KVMPICClass *kpc = KVM_PIC_CLASS(klass);
     I8259CommonClass *k = I8259_COMMON_CLASS(klass);
     DeviceClass *dc = DEVICE_CLASS(klass);
 
     device_class_set_legacy_reset(dc, kvm_pic_reset);
-    device_class_set_parent_realize(dc, kvm_pic_realize, &kpc->parent_realize);
+    device_class_set_parent_realize(dc, kvm_pic_realize, &k->parent_realize);
     k->pre_save   = kvm_pic_get;
     k->post_load  = kvm_pic_put;
 }
@@ -154,9 +140,7 @@ static void kvm_i8259_class_init(ObjectClass *klass, const void *data)
 static const TypeInfo kvm_i8259_info = {
     .name = TYPE_KVM_I8259,
     .parent = TYPE_I8259_COMMON,
-    .instance_size = sizeof(I8259CommonState),
     .class_init = kvm_i8259_class_init,
-    .class_size = sizeof(KVMPICClass),
 };
 
 static void kvm_pic_register_types(void)
-- 
2.43.0


