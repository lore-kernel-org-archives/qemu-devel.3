Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 820D8E7719A
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2025 11:58:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVUdX-0006UT-Df; Wed, 08 Jan 2025 06:54:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1tVUd6-0006PN-Kd
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 06:53:49 -0500
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1tVUd1-0002DF-1I
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 06:53:41 -0500
Received: from pps.filterd (m0127844.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50885pFG021537;
 Wed, 8 Jan 2025 03:53:38 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=gBp4yAV4zVQos1p2lAL0HCRy3wcK0mtDievm/YWpj
 AI=; b=Z4yNnscTyJHVOLKLlx9NPB6a2sETgwMXdT0/Ao4sSGAnyzJGcSkKq9YUL
 u+h/ucMDutTRU6oX+xPBoOxuIiwJg/vHMqFJgpBLJ6sX2ZUwBcDzqQtjOJI9rQyh
 ZLErI/hnYsK4VXCFtS+ymPUnrhjj/WUUirMSemP6jetU8t0lk0t7YCN+zkGqC7gR
 4BiFhU1T7RtnRRY8Ym2t9g7iPBpBPVHJFcxxiQggpDoE4Fo+gqkEz8tiXVhz0W99
 sag+IwGlXl3e6WyDUBr0e6MczhLLEwKuPFPU864w09b+waJivgRNAj/JQPQ5HVMX
 lIubqXXoqh0hzYDDf2DdtukCWkJ4Q==
Received: from nam04-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam04lp2040.outbound.protection.outlook.com [104.47.74.40])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 43y5d3rs7x-6
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 08 Jan 2025 03:53:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yLaBWws2PBEejkdoZJVlGMUjgm2ksIJ5//SY2W0TMzNuekGu1pGJTxTaecIIIU7U13UHyvkMvXj1bmy+Ahp3YvCSWXQjEdNtLsXQTqCNse+zhtOxUEw9pas538EIQ8tUseo57zEA3oVrneFWfpq9ka7UwVTXuF2DWhnyAp0RR6JLkViHiJQqfs5AcUdrQkouv6D5qf/cn/v/s1DlQ+QbBE45I1aoMAGmkHsxUcFOQtlWd8rlVGZ6iGVVqTXuzmlcITEvAxhtlnOvRqBSIik6NSpx6KnYNR8CJ5gXy5TRHPRVp5753MAB9q9DG214nfxdjqn+ABRDTweFBu8p4IExlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gBp4yAV4zVQos1p2lAL0HCRy3wcK0mtDievm/YWpjAI=;
 b=FiDoVdKCBpoXV+jCLxPwLCrCVo65ppsI9MSXr8pwJia2mj13NdYktE57zjIIf5OpZ6fucl1S8sya5DDZZqShVULbvsc7omL51XQiKkM96SNic/66GHG/bcWfO8a0NYzx4tbm3JHqj4cjdJMjY3Vjzu6JeyH9WTF/XC/lnjH4LDVvjSYK6othMRDU/ZZffdkEOJAVTVHLvum8go+pkJ9MNxlJGRYRi1uM4gJ8ciaFuB3JHYsBehoAqQBcLImx6s1cLlpU6KCaGcf3XwTkydjVT4O6RHnq70a4uXuhKW5gkkVL/lYSnFAQmf3q57OJislQz2Ib7LYpuubeWQHnVrUQtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gBp4yAV4zVQos1p2lAL0HCRy3wcK0mtDievm/YWpjAI=;
 b=l7gpf6q7LJWPcz+m2AfLqNY8v+ECnnp7WVClhwyYAIZTs8+jawWCPCxeLzZcLV4bFwg+M5NU/gihn7goOFpve7fmqHED2A/EKMhjTHLKa5HTQYRZ579fqpJ/fqpPi9InuH+S40OvcDCwOLxGWkU5aOZ0jx6kgdrpKRTIGgJjILQ2UfdeYimfxuhfxyeJreY7qq8svR2ickQyfwKUgvlJtsMHEiDrgZ8GH2fcjwgXSSIrmQy0zUm4e6r7sa7VCS4mXSGMRDl1QjgsCb4jw45hn6eENHVZDWu3nDjqGciqbUq4r/2o8S0Snmtb0lCNSnUVjj2Wuo+GQMnMaFp9Lopn2Q==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by SJ0PR02MB7502.namprd02.prod.outlook.com (2603:10b6:a03:2a2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.11; Wed, 8 Jan
 2025 11:53:36 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51%4]) with mapi id 15.20.8335.010; Wed, 8 Jan 2025
 11:53:36 +0000
From: John Levon <john.levon@nutanix.com>
To: qemu-devel@nongnu.org
Cc: elena.ufimtseva@oracle.com, alex.williamson@redhat.com, clg@redhat.com,
 jag.raman@oracle.com, thanos.makatos@nutanix.com
Subject: [PATCH 05/26] vfio: add vfio_prepare_device()
Date: Wed,  8 Jan 2025 11:50:11 +0000
Message-Id: <20250108115032.1677686-6-john.levon@nutanix.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250108115032.1677686-1-john.levon@nutanix.com>
References: <20250108115032.1677686-1-john.levon@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P189CA0066.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:659::14) To CH2PR02MB6760.namprd02.prod.outlook.com
 (2603:10b6:610:7f::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR02MB6760:EE_|SJ0PR02MB7502:EE_
X-MS-Office365-Filtering-Correlation-Id: 52a3c438-1eec-42bd-2df8-08dd2fdb155a
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?wjD848bw3j6wUKHyIF6G43ampA6sxCr7ZxyxtTN5ss2AK2ZmYEFvU4VD72QZ?=
 =?us-ascii?Q?mPsnkvGBsYY/pjyE9QZVLY26ypwdlbtW6AKKpIDVOq9RPMFEG2zmUFAGWgDC?=
 =?us-ascii?Q?MPwsP/6uwd6d2iPLFk9q3AMNScFhQXA1OjeSNrljQh6nqPqD7enuiQpHjIr0?=
 =?us-ascii?Q?gElv3+70MGY0duXNulBIY+TH2TSejPdkJhFbD3uxs4dy0gG70VP5mSg299eQ?=
 =?us-ascii?Q?wnnPmcY6NDdxB/Zn/1hMeTBCndqYeL+V2qeObAVKfy0ehRqImdvB3HFz2Jfn?=
 =?us-ascii?Q?Nub6g4UBy7MqrA1DWLcTUC8HLQMqqrOnjryJWXCeLAS5kaU0kicImtamOMb2?=
 =?us-ascii?Q?Q7L1lp/aMbZ9BEQ6VsACyU/yIGSYh8rzx5cmPOx7BinzxS7SCKEI5bk1fjK0?=
 =?us-ascii?Q?yHfPX2swXxM/BxrqyijBcrbl4nlBTSGbfnhcPCZVcDcJHzGdW0xr7NQgiK5w?=
 =?us-ascii?Q?H6egUcKa0dem2YlEFHg9+Yy/eneJ6sV0jfkZAnNoEJqp2zMArsyPLO4vf5zG?=
 =?us-ascii?Q?tda12IzUNEQ0HEUMHR0soSliFNA8Baw3NIetqJOPROgQZqNobc4T41cN8vo5?=
 =?us-ascii?Q?Fdc5WMGoYQr8vPqlSvhMuV4biKAMaXrAhnKHqoxoSCpCehwhy+4Heks2g6lp?=
 =?us-ascii?Q?H+focmYO8QjuvEsmLj0QBw5WOKQQt2Bxfuq/9x3tEjcWqXZt9FnhjhvmArc1?=
 =?us-ascii?Q?kTCHKToE7Fufb2hllI2KOoL64a41yUURvua6jcEKQv1A5QSH+b12uGsNGFE7?=
 =?us-ascii?Q?my2mVAludEGWhJOUkEsuS57Wwa7GjpmBGGGb7LX+SvUPtUugGK7FRM/uzBnl?=
 =?us-ascii?Q?ao8DZxv9TjFmiR1RGNd/x/yocHtHPHGTQAj34oQ/t4HYXhywR1gdHhgvDSQn?=
 =?us-ascii?Q?n57dKYYAOKqcKA1DK9gzs9pVwzbYg4dXG0M5wqgE/Kg3cW2QamhtaVoiHmpL?=
 =?us-ascii?Q?+MSDK9EgE2Z/iWhKuGcvPNCDlmHHAVP0KyfvQpSRFs8Li4wBOMHPAqLW87D9?=
 =?us-ascii?Q?e1ZqEPGE4JtRZX232IDf772u3WNq8oGpdNzrXaKEmAvtI2PMr2NaB/KRtUeH?=
 =?us-ascii?Q?WsLy6pIQeBiBDcc1lhPM0PerFVaC9Y/SDyTNF5ucm0r6FDVG7Q2a+tii7Y/T?=
 =?us-ascii?Q?vwW60i2kbRkVhdVJbK+rLL5M4pFHkuT2yZ252YfHNH818DUga83ai0OVz+GE?=
 =?us-ascii?Q?pLnItboy6vbJmvJ67YFt2UJ4VIz7prx/j7AwFq4thoQXhZZ+qvEL2OLJXETJ?=
 =?us-ascii?Q?TiYe+S6aUKvwgpFkI12GgWq0O/Cdl8kUs1DDv20OQ7ucZP6GpblGQpSOSAR/?=
 =?us-ascii?Q?bJvimFD3DVkKaU2/FmmvQrCXQUvDN4efN7N5IXohmLMHX8s9WmInUNHYjrtr?=
 =?us-ascii?Q?GSA5zZidHEi7xMiWtlj29YCTcT9J?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bQFCM3dGSQcNvyTeQ4Hm6ED00MoD/Z0BPYJH3Q31loB3CWAEaDTQqwL0n2aY?=
 =?us-ascii?Q?wcKjKuQAyXzSj8oZhfWIyzj6MPqcZPtdhAotOJ+lTZiIp+ntuoi5N4sgikPO?=
 =?us-ascii?Q?ECBxDaSeivsZrdKXzF6Jv2bfE6uZltnjmdixPTShjYFn9VTBfeH+woM2o3+N?=
 =?us-ascii?Q?iJPwikZAkTZdffen6JL5GYZFO7IGkixPeS3yR++puTyaLiv4zK/uQRUMNsVI?=
 =?us-ascii?Q?Dse4e3cO8u+kPxSkXDX7fMa0FMDFv6sKTkbACWJ6bxWyKxrgmtA+ZdP3URm6?=
 =?us-ascii?Q?sNz3ypVVg90e1Umeq8JhLQpoGusKNqBsaG7gFuQeY5sJfWB//7YRhF+U4gu6?=
 =?us-ascii?Q?n5bApG6jv3zvRgDAbPQHJIr7iI8gZ0/pgdSLnSYX6DnzeyToWyuPdSxrlI4u?=
 =?us-ascii?Q?p+iFFyolOWkrWH2BXfCOAs8nfpzvnd09S9x3vlwMK/bt8YF3Lb6aTzWz+PAE?=
 =?us-ascii?Q?XJV4Xk+n6pfpSmNlIq7oPpKE3gcSagwsJeThQE27633xdylg+NWna48DSoUx?=
 =?us-ascii?Q?MeDHP/aXZ7x/5epUky3vZN3bKS6bJ9p+7Lt85CF57an/aWGYZuB2jJ/N0987?=
 =?us-ascii?Q?uzrcebRptMPMo7mc5anlO5mGj59Tol9u0G9k3+8Cpdy5VEy4f2zbAVkCd/oL?=
 =?us-ascii?Q?kkeCwbchL2LpF23o90cZ9WW7HWzW4i9nATt1U0i98KIbH7hLv3n8mGT5Ma0e?=
 =?us-ascii?Q?6Ig7WvCfxc8fqPuVrcpaRgIgT2IQGiL3APA6Q31+ILBIHsEE3q98bPn/eH+c?=
 =?us-ascii?Q?mmQVmMwZ4QPCFmb3s6ZqA0kdNwqLcrwmGH9DBJDkS+0JZIgaiqKWKRznS0DV?=
 =?us-ascii?Q?HFuvwxOXI4EMiirqsrvgXZ/jZMC0CnBGnZ2n1FrMQgIaEp+jja9Tki1Zbt8u?=
 =?us-ascii?Q?gw736jLZ2sjGhao3Yvxd/aoDTPlDjaiHAT1A+lLF4yD7+lXGcDyKh8SeX8I8?=
 =?us-ascii?Q?n70ilQrQYB3dtyEgfdXD9btGS1y7pRCbwH/qDU5qr4yYazKlsKKi9TsKGj8D?=
 =?us-ascii?Q?njhCO5PvtyYUmXTxL6QPqRq0YXhzG0zt+C5/PmTnKRDC+QDiRyOoEWvb/LqA?=
 =?us-ascii?Q?UXx320Jq/jY1WSwC//HjIFuR/NXM7Po69cqz8M1iGnP2X39gv6BRudQbhxcw?=
 =?us-ascii?Q?EaxuF1fjpo51e/tx+M3EGdWVCq3YEW4ZwzUfbk7/uAJ8iIBr7XL2poqFDzaH?=
 =?us-ascii?Q?/vWidu7eP4LEqoA7kqWO+o0j89Drc8eC4KRUfx4rlLK0mRyNXi0Mrzh0LUzf?=
 =?us-ascii?Q?QhYnRaUMb8pm51EJ8nu79CyNrSpYOC0RqSsp2jcJo8+agB5x39H+1NOQEhsf?=
 =?us-ascii?Q?ObkMiQ/c1SVYDOdtfLlvg8YaQ0HvWa6pm1I4r+2QoNj+Pxr6+zfT43uLrWTl?=
 =?us-ascii?Q?C5qrDH+PL3JK8IBJqAJTTCuYZVJGHDwZCNt7YN54qi3M1t8Ki92NfK3fTxeF?=
 =?us-ascii?Q?679LYuM3ZWgm53Yo+JHYxQEwsxUW2e7IG0AyBjmU9Q4FW+pmhewUi5UV4a0B?=
 =?us-ascii?Q?fhmofkidxr49MXsfWhbxJ1E/brY1xMgM7/5fDqpoAXgml1MJKcAt0aFoTuSY?=
 =?us-ascii?Q?FA+dxSVtcYo96gwh0sAMmp0/sLmAATCyrKajGLGw?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52a3c438-1eec-42bd-2df8-08dd2fdb155a
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2025 11:53:36.0343 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Pt8UW0DzqzXpgzuuFPu9IoVyN3BdDOLbjWQE5O0hkIvTJQUkCQ8F1v4O4WPg/yGT1SAzecq3mwnlp+h8Az/yOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB7502
X-Proofpoint-ORIG-GUID: SBv15s84lpS9M1PzrzJBIefrZcDBcM_S
X-Proofpoint-GUID: SBv15s84lpS9M1PzrzJBIefrZcDBcM_S
X-Authority-Analysis: v=2.4 cv=YLtlyQGx c=1 sm=1 tr=0 ts=677e6741 cx=c_pps
 a=ZeveGGZnxkNpWlA7A6AaFA==:117 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=VdSt8ZQiCzkA:10
 a=0034W8JfsZAA:10 a=0kUYKlekyDsA:10
 a=64Cc0HZtAAAA:8 a=nsq3sfgFcGYXhcUyotgA:9 a=Bg_hFbzUHdN-jkeYMkSU:22
 a=14NRyaPF5x3gF6G45PvQ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-08_02,2025-01-08_01,2024-11-22_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=john.levon@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.432,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Commonize some initialization code shared by the legacy and iommufd vfio
implementations (and later by vfio-user).

Signed-off-by: John Levon <john.levon@nutanix.com>
---
 hw/vfio/common.c              | 19 +++++++++++++++++++
 hw/vfio/container.c           | 14 +-------------
 hw/vfio/iommufd.c             |  9 +--------
 include/hw/vfio/vfio-common.h |  2 ++
 4 files changed, 23 insertions(+), 21 deletions(-)

diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index cb299fc3bf..a8243c0c58 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -1551,6 +1551,25 @@ retry:
     return info;
 }
 
+void vfio_prepare_device(VFIODevice *vbasedev, VFIOContainerBase *bcontainer,
+                         VFIOGroup *group, struct vfio_device_info *info)
+{
+    vbasedev->group = group;
+
+    vbasedev->num_irqs = info->num_irqs;
+    vbasedev->num_regions = info->num_regions;
+    vbasedev->flags = info->flags;
+    vbasedev->reset_works = !!(info->flags & VFIO_DEVICE_FLAGS_RESET);
+
+    vbasedev->bcontainer = bcontainer;
+    QLIST_INSERT_HEAD(&bcontainer->device_list, vbasedev, container_next);
+    if (group) {
+        QLIST_INSERT_HEAD(&group->device_list, vbasedev, next);
+    }
+
+    QLIST_INSERT_HEAD(&vfio_device_list, vbasedev, global_next);
+}
+
 bool vfio_attach_device_by_iommu_type(const char *iommu_type, char *name,
                                       VFIODevice *vbasedev, AddressSpace *as,
                                       Error **errp)
diff --git a/hw/vfio/container.c b/hw/vfio/container.c
index 39c77d402c..b1a58b0579 100644
--- a/hw/vfio/container.c
+++ b/hw/vfio/container.c
@@ -878,17 +878,11 @@ static bool vfio_get_device(VFIOGroup *group, const char *name,
     }
 
     vbasedev->fd = fd;
-    vbasedev->group = group;
-    QLIST_INSERT_HEAD(&group->device_list, vbasedev, next);
 
-    vbasedev->num_irqs = info->num_irqs;
-    vbasedev->num_regions = info->num_regions;
-    vbasedev->flags = info->flags;
+    vfio_prepare_device(vbasedev, &group->container->bcontainer, group, info);
 
     trace_vfio_get_device(name, info->flags, info->num_regions, info->num_irqs);
 
-    vbasedev->reset_works = !!(info->flags & VFIO_DEVICE_FLAGS_RESET);
-
     return true;
 }
 
@@ -941,7 +935,6 @@ static bool vfio_legacy_attach_device(const char *name, VFIODevice *vbasedev,
     int groupid = vfio_device_groupid(vbasedev, errp);
     VFIODevice *vbasedev_iter;
     VFIOGroup *group;
-    VFIOContainerBase *bcontainer;
 
     if (groupid < 0) {
         return false;
@@ -970,11 +963,6 @@ static bool vfio_legacy_attach_device(const char *name, VFIODevice *vbasedev,
         return false;
     }
 
-    bcontainer = &group->container->bcontainer;
-    vbasedev->bcontainer = bcontainer;
-    QLIST_INSERT_HEAD(&bcontainer->device_list, vbasedev, container_next);
-    QLIST_INSERT_HEAD(&vfio_device_list, vbasedev, global_next);
-
     return true;
 }
 
diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
index 39c2b802b0..ef0a7f8ead 100644
--- a/hw/vfio/iommufd.c
+++ b/hw/vfio/iommufd.c
@@ -603,14 +603,7 @@ found_container:
         iommufd_cdev_ram_block_discard_disable(false);
     }
 
-    vbasedev->group = 0;
-    vbasedev->num_irqs = dev_info.num_irqs;
-    vbasedev->num_regions = dev_info.num_regions;
-    vbasedev->flags = dev_info.flags;
-    vbasedev->reset_works = !!(dev_info.flags & VFIO_DEVICE_FLAGS_RESET);
-    vbasedev->bcontainer = bcontainer;
-    QLIST_INSERT_HEAD(&bcontainer->device_list, vbasedev, container_next);
-    QLIST_INSERT_HEAD(&vfio_device_list, vbasedev, global_next);
+    vfio_prepare_device(vbasedev, bcontainer, NULL, &dev_info);
 
     trace_iommufd_cdev_device_info(vbasedev->name, devfd, vbasedev->num_irqs,
                                    vbasedev->num_regions, vbasedev->flags);
diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index 387854cb0b..da2c5947c4 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -250,6 +250,8 @@ void vfio_reset_handler(void *opaque);
 struct vfio_device_info *vfio_get_device_info(int fd);
 bool vfio_device_is_mdev(VFIODevice *vbasedev);
 bool vfio_device_hiod_realize(VFIODevice *vbasedev, Error **errp);
+void vfio_prepare_device(VFIODevice *vbasedev, VFIOContainerBase *bcontainer,
+                         VFIOGroup *group, struct vfio_device_info *info);
 bool vfio_attach_device(char *name, VFIODevice *vbasedev,
                         AddressSpace *as, Error **errp);
 bool vfio_attach_device_by_iommu_type(const char *iommu_type, char *name,
-- 
2.34.1


