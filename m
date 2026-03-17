Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 327D0FEDA1D
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2026 19:54:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2aUI-0006Fb-1y; Tue, 17 Mar 2026 15:53:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1w2aU5-0005su-At
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 15:53:48 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1w2aU2-00070o-RF
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 15:53:45 -0400
Received: from pps.filterd (m0127844.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62HH9Elh1688081; Tue, 17 Mar 2026 12:53:39 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=KlRc5Xean7JfGnqIvZf4vp+YYW4VNkBJzi08AHO6a
 zc=; b=NrArkcBcHlEGJ/YmgJ09QRLucCj8oKedMXDNTilLSv3OtEGgaXhnTjFXq
 jO3ykGF8dSvh0Sv5aXpjS6vEVsjqxY0l9EHMJTcV8GLfm8IWW11+WfrciBVhseFn
 7RG8Xn+02Vd6Kx1AasnmeC9GDZ4OD+qBsh+jurrWOfRDh+WJQKETlYf5Pt7edrhk
 Pv2HtgZMfZQKVlWQn/CKQ1WCconesewEL5MgGHXnVpoxteOt1xGggRWIhJYKqyoj
 oZ6WfwaImx/80gteLW+2MQDmZuLwwUEnCUvPfcpvK0q1CYKtEESSYbBtjkPQ0N1x
 DhXY4foprGTzaSo3/Qq4bRuv0fMww==
Received: from cy3pr05cu001.outbound.protection.outlook.com
 (mail-westcentralusazon11023100.outbound.protection.outlook.com
 [40.93.201.100])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4cyb3wgd8a-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 17 Mar 2026 12:53:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iAIvhRWfUULwqRG5Qe+KFrbWfoEsk8fE6uLnU5ppL/7SX6TPFuwx2Jws8+O8HAOra2YNVZhPUuzQFKTrhpDGTdOJmjQ/zjBXhgqZFPbRXOk7rX48CDX4ysmK8nSoqH+Jn0i/hVj4/5vLlPWU8HJHD5D5mko6+84ZrmF9cxL1mSBU2Jde2P34xVr0Koj1KCRauj7zUlcO15DWAQKPQCjD7mQ1I16qAGn3pG9NJdeBoCvkknZTfGq2xPJcUjZTkY/0//ta1D/G0CVRpQhI7g3Wg7GIFeQkHhot7dKeP9xM7+mZyIwZFwbcGqD3XEh/pjPFN+R8GiZfY9+NSauyI54JgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KlRc5Xean7JfGnqIvZf4vp+YYW4VNkBJzi08AHO6azc=;
 b=fDg/pDPhO8HSDRS3sOCSEtsIvxyfTzwKOyVeSJSRmxX5J/aTtG1eh5zrjXAIm7KPPSajHOrxW+uAITxsyOANAWzBoBoEyJnqFCIm1AFDxqQnQTn4WvGOjme6lmZkWyu96iuDBtBwrEm2mklNRJZyQ6ITFsWj8SECEeOceOhsZoa/Zw8TkXs/V02ELuwANp7UeeS+FYC5YkZ0zYgYDWN2EiZri7FRoM+gkXcmYGGM3skAjgcD34zTzHfyyyaQ8uV+MAzuWmTRUkG5h2prfdjc2xZl2fb8xZprB4G5GAaFS+OumSHtnOxUps7iXV5TAORL+qVspsCTqe65vzwvQ1F6fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KlRc5Xean7JfGnqIvZf4vp+YYW4VNkBJzi08AHO6azc=;
 b=myZh4cziB66fv4hc7ztR2Sx2WvVRgE6UyVmIeRqSgw+jDZN+VdS5cCQKIjNU5UhGmBzUdvsTJtHpBPSDW6/qu8iGUmDhdSL84xakjRvBlQajgTybJE5pssRY1mkqitgUmdDffvkaZq06ZoRcOyJcGHUJKz81fcCXY1nwQ4l6Uf+LS1e05b9QETrPiYqfjPWq2LbsOoEPiQ6SlIyAR0q7ILPBnKOIVEbGrfDlbNaJDNZ1YWhAnwdQj8w9A4VkFeMCtckLIl9Ff6zXvJNK2kE4B951GBYWMLhZ4Rhk5zUdvMrGCZVJ8zkNZ59QFDFnzOtuBfGVvtyMEUbExdYO88RfcQ==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by DM3PR02MB10293.namprd02.prod.outlook.com (2603:10b6:8:1af::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.22; Tue, 17 Mar
 2026 19:53:32 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::dbc1:9766:c58d:4887]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::dbc1:9766:c58d:4887%6]) with mapi id 15.20.9723.018; Tue, 17 Mar 2026
 19:53:32 +0000
From: John Levon <john.levon@nutanix.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex@shazbot.org>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 John Levon <john.levon@nutanix.com>
Subject: [PATCH 1/2] vfio-user: support VFIO_USER_DEVICE_FEATURE
Date: Tue, 17 Mar 2026 19:53:22 +0000
Message-ID: <20260317195323.776669-2-john.levon@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260317195323.776669-1-john.levon@nutanix.com>
References: <20260317195323.776669-1-john.levon@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0631.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:294::17) To CH2PR02MB6760.namprd02.prod.outlook.com
 (2603:10b6:610:7f::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR02MB6760:EE_|DM3PR02MB10293:EE_
X-MS-Office365-Filtering-Correlation-Id: dbbc3658-8f85-4477-4fed-08de845ede33
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|22082099003|18002099003|56012099003; 
X-Microsoft-Antispam-Message-Info: CCTboYq2W8juRYlEYLX4J05O7jjFAnQwmqCpgC0GlK9qpwIy8FdFfFRMoHF3kVbsdHH5GgOicy0qiU5rJ9Ra4eVYY/7axq7TW67KaSd/T/UemskkYmgibW3hYacuQv0E40QT06X88GIN1ddMAlbhmjIhoI1YBX/UZXcP7LBc5AhZcm/H0lbXPpkFgpURVJqaS2Kvuu3aR3r0cqZWYuH4YrrBecUrhG56tlxAtuGm8ma9Se3GDx/tFdoJUWZgvYtlZviTXnvTlRk0gIqbV4CN5XtzXkipPE5RcEQzam1S434bmLWqrwG3GtaSQUn7NFUb6hcYCg16wJN3RAnCgRJ+1yHzG2LgHWqdI4IO9lbbfUnNQHRCiYLDZOOiT3Uf/68XM2i8ezKZcD8lyz0kgAFXpq81sup59frPFIAY6Ay5tsHkRqMdsEBYb3xx37+tSNtAWQXi606pHxtn0ZEgR7JF3lDIZxprTV5yrTNBax9sNHPXDGGpq4HaCTnGEiTrwBHHibZSwF5lcl6GXZOd8CfxXx7brRLQrZ6WWtRNPP4oDhX3bKui0gaNh9OqODBepxIntiaPUkOuQ8DS+89KjKNUE5LYdfj58ftEy7+Baa4ujl37xes6tE24pr76T79Gc4EfWsnKL4kTw2oTXw8GiAe8WHw6Z2DJUUAy05FHMLWa6GFwxvAb9hn1zRdSUs0uPNVuzTmqSjuqvU0ggSIHVUwyv6tAV5cT18+5LlgElije+QA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/EGon5ciPuP6G4tZw+bPZwIO3IV88FyovlmnmFnlotKgfv8y+/v2jWhWSRtI?=
 =?us-ascii?Q?q/Hwkxi97wrZvEjeMhvITSbB+v4dJLOE8qLn18fUV0FzhpBA3M7+OT5Ftwh1?=
 =?us-ascii?Q?JHH4L07gGyGWKmO5fCalXGJkMDsS982QaA5D99/sQQ80Lxo+ycR0TcFo5yrs?=
 =?us-ascii?Q?7MDF1zvffVth457NdbDQ0GjBQj+Dqt8OdYp1w+uCheq0uLe1T6lVEA8rTUi7?=
 =?us-ascii?Q?siTsFxLwjqVBqT0yiAMzFdwLUarCeSPKC5wLqAmNV6l1gIEqH7uzglXxyTEy?=
 =?us-ascii?Q?Gq+AnkGfW7nw5rHBL1S45Qw+5AKw0l63RtdrApk/gKGUgJbnEaggV/Yhc1C7?=
 =?us-ascii?Q?QJGO+R6jV8nq23fiuUmRqd1jqvoCVas36sXsec67hvImmtEd7w9h10Iw6vvH?=
 =?us-ascii?Q?wv1cZa8fB6H/vtvvE8dXk4FtjOHVr5L+980+6qnPZM+jkLsFwi7UMEZ2dbag?=
 =?us-ascii?Q?Phax0pXVkH138OeRB/NaihVD+dtI9lq6uFVpda8q/0iyZjfc2xTG+l2vTbIB?=
 =?us-ascii?Q?RrL0UwBKua6XMUbwf+45TFK+T1plGtU2uokSiFA8XVaeY6ijGEqwUoEhpJga?=
 =?us-ascii?Q?lR1woOYfeZIHyJrwxqGBD7DrlOlxsr0fmsaHIZdwm8FIUAE9ml3hloT3A+EB?=
 =?us-ascii?Q?jZVFciPOAP7v/dBhGGCw+0xPxhgJ0sQQRpvQynbo2zYSla6/YA8F+S4Xvf/b?=
 =?us-ascii?Q?vKXXDx52X2BR0ZJJLRQE4S2rNGZn703oYr8uZ/9fpyGzWWwIM33U7DSaFCwq?=
 =?us-ascii?Q?TGak+mA0FnhtJtzmN0YaXP8EYUMRvGV3XPQyuyAs7htVmHllrCPVCIu8P/Nr?=
 =?us-ascii?Q?nDWu9RRFM3Dt7sN6YKPhZEdT4EBv8SVNA0GEBC2/+++f+3qVnpgWypow17/Q?=
 =?us-ascii?Q?4Ez+TCe4AAHppQkdg3sfxPDR+HL9UyhckD8llk/ayH52vm6VFB1mgBSbI98T?=
 =?us-ascii?Q?Kt0QGaaOTg0HxeL5saZ92kjqsstZlZ9mMcjSSzhHCym6yDpqvUNPhFdrPDhe?=
 =?us-ascii?Q?KAcqWZsNHRXmNj0ZDJIQuElORb2Tb/PQ9KVc0TmmZgMwploeBgx9DN3wAzNb?=
 =?us-ascii?Q?YUee6sqiSBTMgX27SmhUT4nRsX95pi8PZmWL08odGmyWv+XR0Q31nL60PrdU?=
 =?us-ascii?Q?gO7xPTwR6v/6vfk4HxBH+P84WA152BsT3rVvHm/UwfO3CeoZ/UYkdq9nk7I5?=
 =?us-ascii?Q?Rf7m0Rn9HvKbsGcEA/QkkfnnEvUzHbERWbYWhjVp8G/vvdyR8D4u1DZlgOf2?=
 =?us-ascii?Q?w8gyvR9AcUSDSGzBub7f+6AHBY4dRj6TPNq++diuY2bchCIdHc9j9v+RRkdF?=
 =?us-ascii?Q?2pjDzf/1VZ0QVQZjBeXJOEwvrkNV69a+L10yjRPovBOEW9Vg+GKIeiWbAbe6?=
 =?us-ascii?Q?aSIb1DQ271B/0bsSuMg1Q5euNtkZvPKvKOYA6JDHc0kj+QTBxIjLo4uWdIAn?=
 =?us-ascii?Q?VdciHno4fAy6FCyrM1ae9iF+fr9X6SggdYtEUhyW34j3Waz9fSCsPb3sGGzE?=
 =?us-ascii?Q?t1IuMnQsOb0zHeJxJ805H5l7nSLYX9wYL7XS4lJUkxY+OIbSnrFMCmEUdzuF?=
 =?us-ascii?Q?PAXXF6QleOK570dxrsxxr60nW2pE/KlqIV8wjoCD1/rpL4YG88On85jSH0Dk?=
 =?us-ascii?Q?PveX/sjNqSNfaPCb4TuS384Sem/QJoMtI1eRxgXGNYsHjCvc8HAN9E2Jbzsv?=
 =?us-ascii?Q?luQmTr3tIxNDmgonBxFDrn4RKMQOIqBR2aB235yNV/jt+BsrNNdj+DYFK10U?=
 =?us-ascii?Q?3TdQaR5KBA=3D=3D?=
X-Exchange-RoutingPolicyChecked: WT8SUJ+ImGn26YcSCiC419jqHl7KrmByNYkxKBtugGjsjnZxq7O+NywUsjdJqHD0SjO6jgTe9zRUjXI/m1E4uWoB4cLfnnbGIlWao8p26L6YH0J0QYpsan36BuYjKuneNVeqik53V1NiSrUPJ1HKPtwYbhLM3xKwMREsXqMDGFoEiZPO0NpZB+ZtBbYY0L6xcpYhXRHSj1qWbCQh/u1k7ud/bBsGwkOnJqf9nOBN4NAQuPBBG5NqSFuLByQhDYL/SmpWBTE4aRE+sFYR78VLqogRfPkYblfhAlE91dLJsInXlVfLFQgZulyVFx7ECZxtksrG9Q+duZZ2IefQ9NBUdg==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dbbc3658-8f85-4477-4fed-08de845ede33
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2026 19:53:32.4611 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /8htL68MpkCaLsCvOrhvuWIf9lhbpDOuNYv+7Ukk9YFjw4+VOs0BM50N4+XAL//Wia+jRcedtlpeFD+DMrRMmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR02MB10293
X-Authority-Analysis: v=2.4 cv=Wv4m8Nfv c=1 sm=1 tr=0 ts=69b9b142 cx=c_pps
 a=RZStT+UEo2YVQxgsfJfMbA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=Yq5XynenixoA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=0LlEyIVc8U2lsR7dKhuH:22
 a=64Cc0HZtAAAA:8 a=T81NyV3NmCtce8DGP3IA:9
X-Proofpoint-ORIG-GUID: GAyKiOEHTZa1rBPVG05MaP882e7gv_vw
X-Proofpoint-GUID: GAyKiOEHTZa1rBPVG05MaP882e7gv_vw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE3MDE3NSBTYWx0ZWRfX7U+xVXsC1FSf
 SR4+TEcVrwUKq4CkbQHAvWZraAyPJ2XxzkRSFaxELRn+7BvE35W2OYDPLcX7vJqwsz0YYiUm3pN
 bfG45db/ClbGf79OSgPYjMTMrMWe3J0a49Dly/hgSolsmSG77z7NSk9t20USZT0j4VY1XaE54NV
 byogfpFTaZlIrOw9wDQSWiy+sp39egWRoJWZm8yK1dxDm7aseebBGA9zO589q2k0l1bsio2RsZo
 Gm/AKWA3Lhu81EQnjVMKLTZ1ssp82SNzzvodi+avZc/mN+GOnegtq+0Vl51qjDULk8lDEmxSaYl
 TB/Ls78ov7Gupkd3AFdq/2IVghd+JBSdRZYpOsWLp/wWYXubnO0+oUzh1+4mZ/380kayC/W1PXN
 fQ01yE33QeT+nuqdv2LCNLz6+wkHaSAgDc1Fnd5Ar1FAMPliyJSQG5e0/kmhtlcAP3VpGY8kTpg
 j/uN9QlrGUhkrN/xkeA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-17_04,2026-03-17_02,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=john.levon@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Plumb through vfio_device_get_feature to the vfio-user server. Note that
we translate EINVAL into ENOTTY, as the existing generic vfio code is
expecting the latter to mean "unsupported".

Signed-off-by: John Levon <john.levon@nutanix.com>
---
 hw/vfio-user/protocol.h | 12 ++++++++++++
 hw/vfio-user/device.c   | 39 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 51 insertions(+)

diff --git a/hw/vfio-user/protocol.h b/hw/vfio-user/protocol.h
index 3249a4a6b6..2a0c31e7c5 100644
--- a/hw/vfio-user/protocol.h
+++ b/hw/vfio-user/protocol.h
@@ -40,6 +40,7 @@ enum vfio_user_command {
     VFIO_USER_DEVICE_RESET              = 13,
     VFIO_USER_DIRTY_PAGES               = 14,
     VFIO_USER_REGION_WRITE_MULTI        = 15,
+    VFIO_USER_DEVICE_FEATURE            = 16,
     VFIO_USER_MAX,
 };
 
@@ -239,4 +240,15 @@ typedef struct {
     VFIOUserWROne wrs[VFIO_USER_MULTI_MAX];
 } VFIOUserWRMulti;
 
+/*
+ * VFIO_USER_DEVICE_FEATURE
+ * imported from struct vfio_device_feature
+ */
+typedef struct {
+    VFIOUserHdr hdr;
+    uint32_t argsz;
+    uint32_t flags;
+    char data[];
+} VFIOUserDeviceFeature;
+
 #endif /* VFIO_USER_PROTOCOL_H */
diff --git a/hw/vfio-user/device.c b/hw/vfio-user/device.c
index 64ef35b320..6910d183d7 100644
--- a/hw/vfio-user/device.c
+++ b/hw/vfio-user/device.c
@@ -74,6 +74,44 @@ void vfio_user_device_reset(VFIOUserProxy *proxy)
     }
 }
 
+static int
+vfio_user_device_io_device_feature(VFIODevice *vbasedev,
+                                   struct vfio_device_feature *feature)
+{
+    g_autofree VFIOUserDeviceFeature *msgp = NULL;
+    int size = sizeof(VFIOUserHdr) + feature->argsz;
+    VFIOUserProxy *proxy = vbasedev->proxy;
+    Error *local_err = NULL;
+
+    msgp = g_malloc0(size);
+
+    vfio_user_request_msg(&msgp->hdr, VFIO_USER_DEVICE_FEATURE, size, 0);
+
+    memcpy(&msgp->argsz, &feature->argsz, feature->argsz);
+
+    if (!vfio_user_send_wait(proxy, &msgp->hdr, NULL, size, &local_err)) {
+        error_prepend(&local_err, "%s: ", __func__);
+        error_report_err(local_err);
+        return -EFAULT;
+    }
+
+    if (msgp->hdr.flags & VFIO_USER_ERROR) {
+        /*
+         * Client expects ENOTTY for "not supported", but the protocol may
+         * return EINVAL.
+         */
+        if (msgp->hdr.error_reply == EINVAL) {
+            return -ENOTTY;
+        }
+
+        return -msgp->hdr.error_reply;
+    }
+
+    memcpy(feature, &msgp->argsz, feature->argsz);
+
+    return 0;
+}
+
 static int vfio_user_get_region_info(VFIOUserProxy *proxy,
                                      struct vfio_region_info *info,
                                      VFIOUserFDs *fds)
@@ -432,6 +470,7 @@ static int vfio_user_device_io_region_write(VFIODevice *vbasedev, uint8_t index,
  * Socket-based io_ops
  */
 VFIODeviceIOOps vfio_user_device_io_ops_sock = {
+    .device_feature = vfio_user_device_io_device_feature,
     .get_region_info = vfio_user_device_io_get_region_info,
     .get_irq_info = vfio_user_device_io_get_irq_info,
     .set_irqs = vfio_user_device_io_set_irqs,
-- 
2.43.0


