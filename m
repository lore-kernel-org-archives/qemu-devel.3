Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79B19CCF2E3
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2026 12:07:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIm8S-00012U-IN; Mon, 19 Oct 2026 08:06:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1xIm8N-0000oL-ON
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 08:06:31 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1xIm8L-00048w-Tw
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 08:06:31 -0400
Received: from pps.filterd (m0127842.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69J8OqF81634767; Mon, 19 Oct 2026 05:06:25 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=PnqtO96A9vYIZxbUx2QdtGXp0O4R5cO7m2kz08fWd
 Z8=; b=Vrujwd/vQl1EMumpl/HDswL+rUVPEV82c/yFbKbO/j4S64HDOK5rbXSHB
 W7DZlTOxuXvfZzrzlKMKaMeFwYMA7JZ1BgIkip2VED9VyH1aOZUJOjVsGcwnFoM2
 LFreQVKDcr4a8VMFyU9L/UJhi/BZ8fcURbLrtdQC0rL4QJP2O/htUCe9IPFi721n
 ixC1+xxYbghlQtfLeUiRP5rx8vyRPYcT3i86PCabd8xl0lWnILycamJb/3TzQkVF
 LnLIhfwmHQv6petXXTSQtCc9EQwr0myR9/S5VBXf2iuUcygA05fvCwYto+BiPjsd
 N+dQb53Lp6NuOrO16w1AjWpEBNAUQ==
Received: from bl2pr02cu003.outbound.protection.outlook.com
 (mail-eastusazon11021101.outbound.protection.outlook.com [52.101.52.101])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4hc8bckgb7-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 19 Oct 2026 05:06:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ob6Ks8mvE4h+Wk71W0UHvTkIfn2uFV5s0VgAwxH/RPpQUU0hxNqsU3EDh60vA61368iQyzmq3Mpz/9WM/VmaeJWVj0MyMPf8BwcpDdLjZP6f0ePyZVS0T6EVT65AfwN2exVIqjextcKm5rUhlQYXLhQXfZJ3kSvi/eWDvmjwwYoKLi4fuYzcx4WKHM96BlpzjbF+4wG/9NaXN6x8NW9iq73IH79XGMs9YXd+oELbrbzfSA95rgx6c1TKdnGGg70hx+Bm/Sz3qDhL4W2vdos3CFhaqt+qVInCsAW9ao+yYMjt5nTOkifHIqsIx/Hb41b1qGkVbSmp8t5TybE2x01jBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PnqtO96A9vYIZxbUx2QdtGXp0O4R5cO7m2kz08fWdZ8=;
 b=IkqZMo89dKA6MAhd/EPIjLPJuGDBuSQMugBTOxkORru4eUzugWz15P2K11X3yyxkN6AH9Bb5QZImJLPn17t7RcOkPGWO4RJ1P/tD3UN3W3qaumSKMJfreGDF+l6VWyEi0P+BZaAajEmjVfMts+lijqmSke6SCxahvhn0zmqnypjxq2s/c9eG1armpedjBeQfFPUTzcjEYiOnYkGaW7cITyYVtQuvI8FNR7b2jpFTvS1+FsBtPF84Z6KnNCibjeq/ab7eledAMnkp+6bXL7QyJvBGWIEvsP3IVsIR9ChIOTXvsv1Umk2RH6QRSFB7o7uOMEaKvJcVgl7vkROBs8NL3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PnqtO96A9vYIZxbUx2QdtGXp0O4R5cO7m2kz08fWdZ8=;
 b=TBf/XUfArf69zV5vIIphaoFqQvpL+uM/f+29q21DkCo7OtU0l9LnI6XBaNS8DXR+A7r1Z8qi2BX35Hj5R8FtRDImY+pIQ5yQN2H2J7f4Fkq0Datrh2Pyv6BxBLvO/4SpEqZEDWoebv8m9mTTFoXbMHBOBbAqTQ1rtgI5lbGTWnG1v1VCFgNFmy1vvtNKWrCi9+/aUQTMPgrszEvJdIhBrYzCYCGyhOI5NQIODhECvwi8FPL9K1sSOwE4vnPKzMLYrg3LGGbmeFzv3YoxapRmbbgGl+rO8gIK3+FMI4pJx/F/SeBfQcHWEs3qsmpkHvhNh41H3WOpJKyrTnpq/6/mTQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nutanix.com;
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by MWHPR02MB11820.namprd02.prod.outlook.com (2603:10b6:303:2aa::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Mon, 19 Oct
 2026 12:06:23 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%4]) with mapi id 15.21.0522.017; Mon, 19 Oct 2026
 12:06:22 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: pbonzini@redhat.com, richard.henderson@linaro.org, mst@redhat.com,
 sstabellini@kernel.org, anthony@xenproject.org,
 edgar.iglesias@gmail.com, qemu-devel@nongnu.org,
 xen-devel@lists.xenproject.org
Subject: [PATCH v3 19/28] i8259.c: introduce TYPE_I8259_PIC device
Date: Mon, 19 Oct 2026 13:04:51 +0100
Message-ID: <20261019120517.1448687-20-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261019120517.1448687-1-mark.caveayland@nutanix.com>
References: <20261019120517.1448687-1-mark.caveayland@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR04CA0001.namprd04.prod.outlook.com
 (2603:10b6:a03:217::6) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|MWHPR02MB11820:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a628b17-e706-4a9f-b2b4-08df2dd96474
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|56012099006|261009223027099003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 7ogPhNT0QqcZW21xLpnTLe3tvz0S/fIEw52he+O1GgYKJFpovlMVEvvrBrivZikRNvktnl6QaGTpR/+qudjYiOXmf/UPBF0M3dd496uI4yFX7kUejo/ncOz9xdWHMg1oGMR8qmEsqwHKvnqRP3GU+BQsIKa2SEZl7UCj6gQG/xLWIIsxQbvvIjeMFKXc5Wg6XZibnpAwb3XHhlq8psf0AuyFSeO4NrOjh9e0MIHxr8L54Vu5wGnVHt9Szp3WZ/spYNfcWPCreHzEULS/z8lFpe5s2H6k0E9xTGWVNXeNkCgxy64ucfZdARXxM+avgczP+nTTj1qgwWMjTw/XPD0xn7ziDwsbDl0qG69OULTOmOlS5KKJjLFL5muJcckFsa+tLvKtIfQa0lgoTnFZC1TRyWVJPcx3f6JmmnIWAdmyI/qlTaMFOI1U0jNyDTK7PUuql0OKIVqDaWWXV1QKrA929Sn5841KTQp44rJ5Kw9eiHJ6TAM7UKKbTZWNEy58Q7980sIys5I/jd8D4ybN/KSXDQ6E+8Lze7uZZ1PCZboMOD/nO3vW/d36yl8/8YYmsFvvqLLJIsj29CH2kUPMxGlqP63iXRZT9DrpPEiFT1VC7UY4rh6XYTwg5QKZ903h6pmlUzou6STSAMzZ58aUfBv7t0pq5EUKZRWkEgJNZosui78=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(56012099006)(261009223027099003)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ewAcqArovDFtY6ZtLNv0SoVny7QcS1JjL0O6e0/qX5+3o7LkE3T2m8ECAese?=
 =?us-ascii?Q?rqZbVusp0KngbBuWhH+dfWxwYctVTBNOo1CwOba/RIPAf6nIbVT7/OJSjcYo?=
 =?us-ascii?Q?oUf6vRmr6ZKY0qT8xin+0XzUUVmvoG2hMKLMH9+oURmvy8hBECPkUfth8kwL?=
 =?us-ascii?Q?4+dMeaefMfZu7g72UUzqmng/fHpaAvU0BHv+Wg4a5IFLY2l90NTRV6VRm+LQ?=
 =?us-ascii?Q?dxdFrlHgRvtIUM0wurhBtA3kB3cTzSsEWN5EuP9uXbFzDUiq5ykUTm6ief+I?=
 =?us-ascii?Q?wB4wnrlslf44a9gHe6Ku3YyHvfhNfuKk98aIIb8GUQKT7uODe+jHkD714CNd?=
 =?us-ascii?Q?PIhOEmUtvsY8JmZxeO4ok442aE3cwSvcCvmHYJRFEjDjsKGDos1rc0mmJmCo?=
 =?us-ascii?Q?wY1wwPYMnOcTEUdrcDMy8+lCMzGHQXyZuO9dVIJ7qxOk7/AfU3A+TOQx92wq?=
 =?us-ascii?Q?km/cUGEjlhK/p9RW7kQ6sYTwpnJsyXXTvEzFraM9wm0yT1xZMou0zoaRcbOD?=
 =?us-ascii?Q?BJ4ENPe9/6zTTWjUHmBsbm9XLaVkeIvjkhWI7Y1s5scbA3BBPlHEERGxMjnn?=
 =?us-ascii?Q?dz72ZPU7mFyJ9EEZpik7E7BTZKh9vGzxs7GnubOQmcm5EjktGDTdot4KSp7D?=
 =?us-ascii?Q?TCGjx1mmqBaUTVpqU25oalKsQmGyjlACrEWrWnxIyFBWqdfm5M2Xret2bAm5?=
 =?us-ascii?Q?dQwqW/vGPhiBj8LFMIFmeg+pa3jxgF9sFJrpc12gyCiKVl4wF9TIzOR0mPif?=
 =?us-ascii?Q?lKHio/atXx611H9b2s3LhUWpDd/8IpEgyI8r8UllfT82qoBBzTGqD57YkZxv?=
 =?us-ascii?Q?uQVRWhTXsdTbpbe92xHo90T4rS7LBOXxJw8BogwCMDcDxUUqZ4aIjzjWzuuY?=
 =?us-ascii?Q?Dd232yDfzbJqMnszv2BL9kYGAeppV+RMxkg1WgeL4gTPMan+HKSMZ6IIlcM9?=
 =?us-ascii?Q?R/ohwBGi4wKQb4A1qlFnCPlGsEEIyPmZ6WrPSGrc6PWskhNwsUWS2z5lh5PD?=
 =?us-ascii?Q?x8WBEbwsEk7rTYUNRSrwBt6DeZLBbPy3nVBwyLYrjWQBipkyaC1ge+1dWcr5?=
 =?us-ascii?Q?lm+GAjC7nsH5IpzaMJe9eWLzUsoFapNFokemxNR21L+ScqVa53kmiDEoRoWn?=
 =?us-ascii?Q?mXmX8QMGpwybX8bDjXHU48MIO1y6RtDx7mTFIqTQeLKYC6+X7tBl7MMmh9Vw?=
 =?us-ascii?Q?zdP5+Ppn/0vZnrh7n7ZWukyt2xTnf5h4JDkO5D3Ym4ieGjqFGv0kgJ+4MHXG?=
 =?us-ascii?Q?LjjfOZJ0PwyvdLPxSR4QAX1dg+orIA52re3dKtM+LDqlcYkV8331/k1IVzAL?=
 =?us-ascii?Q?lT2ZC54/zH2pEKypijcZbwoRywz6LmtSkRYYoMFH8Ju4B51UOuneYBSkMeUW?=
 =?us-ascii?Q?GdCVmZ55a5DDUtckXuSkGijLstWWxNeXoHB3sAzEJstriRjSZXr6vUv4egVm?=
 =?us-ascii?Q?DhgeqAFpda1E0XNPwG3kwc4cXtFWEBlL+s8MDtjMJqd5AjcAftBk7wCcPZj4?=
 =?us-ascii?Q?81Uggjyl33E0k0OH0C0XPLtkrrFDMZF2i1U1LwipLVvLaqCesHCJsGjzDwta?=
 =?us-ascii?Q?xq+jXYiGKXzx8scd0nE2y77TDAM5/kcyap2+/mom/YQ37cDwjdR4AbRg11uC?=
 =?us-ascii?Q?8o5kbUpC+ERa1Z24bQ8kDaazQrBW57yNpDc2OJr71+V1tmp1RwgCS/7YZy99?=
 =?us-ascii?Q?76v8GlQO25NwZqtkWWGD55hTG8S+RQPSWyNS1BW/7tVL/o1Jm74aMURxSJs1?=
 =?us-ascii?Q?79psT9oILjPrQw9nLDj+dEVmwJTBZsI=3D?=
X-Exchange-RoutingPolicyChecked: eW/0aws4iyAoOaxTHlaVJCMeXtKaOhLi12cA+HTgifsRmdd76H1rc4Fmhwi7yaYux4hySs0+KUvEk5XwPCEH4Hd/z8BInlZr/VYUSeDPTqPYqMieQuX7FeRX30tLEGoyyIaIDGdhwoI90NtEnIBDZuMaiqz/OxDNtMGK1zL1qfLF/tZiMSJ64evBxTRy688s7J4jlsTV0TQ6ecJg5+wFIQiCMdufhlo2pcpkOyWk8BhP9WQ+1H+UPb4W5Ij+Ou4JEgpWwEI6Ebr0S1sXQXoTGmnhRldMIUsB3CrICJbt0vPGjeoRSJDRB0nFqSp/MkT1YS3nYm72N5CIthOW2X5oMg==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a628b17-e706-4a9f-b2b4-08df2dd96474
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2026 12:06:22.8969 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qfWXiv9nneuSltgrweCnWhhx5r8xpYe4O8dbxGeynNdTtNphTx0ZCRL5NCmPEYN/YG2IUmdG1i6pD2G2l6vT3T5jvlHx7Ux1AVk4RsTDxA0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR02MB11820
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDA0OCBTYWx0ZWRfX79uJ7V3Q9vnK
 QHN51xjTKm3anOGzTTogGrXyOTNr0TPr5EJHRed2DAvnuaFp0NfoWXthhQsHTJMuVNFnnBWBYzG
 RRfxZaV/L08ViXga7OcKL6b0eP1qUsk=
X-Proofpoint-GUID: CyIYS5U_ySI0bavRSdkHZYVHZEAXeOhe
X-Authority-Analysis: v=2.4 cv=V8joQuni c=1 sm=1 tr=0 ts=6ad607c0 cx=c_pps
 a=3cYuoP5kWG2k1oDcrssWdQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=660iZSQnnn4A:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=VUi8bpU7OL1Oj2-RSIOF:22
 a=64Cc0HZtAAAA:8 a=0XGB6JmbSUb4YdcodAIA:9
X-Proofpoint-ORIG-GUID: CyIYS5U_ySI0bavRSdkHZYVHZEAXeOhe
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDA0OCBTYWx0ZWRfXwK9brB+mcXBd
 YdUKBZ9oUtDRJ/dReeGnzxK1NpacdvVnE6VXqJTudm77xA0g2Fcb5VnVMVAsF9Xyw5RMMLernH2
 AmbCZSa3PrSzxgRK7X9B/7Ef9yZfGc4+cq+sX0OldXM9iJH9KvVM2grNSHTN7oqBPLCJuXAWjjf
 VEzMz8FDj1yUcZB8hJXuSOEqdm80sExlifQtFSDqBFfkhYeP8MHMrSmSh9AI9siRIHuqPSAzcYT
 DJYsIxtNFffdItX+dAsfjQ6FiA3RpFsRfp69pIRyVTALM57T4JTpa9mv4okYqyAeB3wWHGcF4Xv
 Ihm42qE8/QVpctm5q5Gp3tn8eb86s18ToZDJxwqyl7ootXIeR936i+Rs1KzDrc+tZ1tj9ESvyox
 Z0gMJvhWsmGGnSCYz5FxR8fAxEfTm2m4LKmgeCTmlDzyBptNWy8t7rtn4YMbijpLfBWy9MyT6BJ
 Swm9sUFwnYDRt72x66g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_03,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.329,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
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

This device represents a PIC for an x86 machine consisting of 2 cascaded i8259
devices wired accordingly.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
---
 hw/intc/i8259.c | 133 ++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 118 insertions(+), 15 deletions(-)

diff --git a/hw/intc/i8259.c b/hw/intc/i8259.c
index e5fa0f2e5e..fe524efbce 100644
--- a/hw/intc/i8259.c
+++ b/hw/intc/i8259.c
@@ -25,7 +25,9 @@
 #include "qemu/osdep.h"
 #include "hw/intc/i8259.h"
 #include "hw/core/irq.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/isa/isa.h"
+#include "qapi/error.h"
 #include "qemu/timer.h"
 #include "qemu/log.h"
 #include "hw/isa/i8259_internal.h"
@@ -51,6 +53,22 @@ struct I8259Class {
     DeviceRealize parent_realize;
 };
 
+#define TYPE_I8259_PIC "isa-i8259-pic"
+
+struct I8259PICState {
+    DeviceState parent_obj;
+
+    qemu_irq pic_out_irq;
+    qemu_irq pass_irqs[ISA_NUM_IRQS];
+
+    ISABus *isabus;
+    IRQState i8259_primary_out_irq;
+    I8259State i8259[2];
+};
+
+OBJECT_DECLARE_SIMPLE_TYPE(I8259PICState, I8259_PIC)
+
+
 #ifdef DEBUG_IRQ_LATENCY
 static int64_t irq_time[16];
 #endif
@@ -410,30 +428,24 @@ qemu_irq *i8259_init(ISABus *bus, qemu_irq parent_irq_in)
 {
     qemu_irq *irq_set;
     DeviceState *dev;
-    ISADevice *isadev;
+    Object *pic_obj;
     int i;
 
     irq_set = g_new0(qemu_irq, ISA_NUM_IRQS);
 
-    isadev = i8259_init_chip(TYPE_I8259, bus, true);
-    dev = DEVICE(isadev);
+    dev = qdev_new(TYPE_I8259_PIC);
+    object_property_set_link(OBJECT(dev), "bus", OBJECT(bus), &error_fatal);
+    qdev_realize_and_unref(dev, NULL, &error_fatal);
 
     qdev_connect_gpio_out(dev, 0, parent_irq_in);
-    for (i = 0 ; i < 8; i++) {
+    for (i = 0 ; i < ISA_NUM_IRQS; i++) {
         irq_set[i] = qdev_get_gpio_in(dev, i);
     }
 
-    isa_pic = I8259(dev);
-
-    isadev = i8259_init_chip(TYPE_I8259, bus, false);
-    dev = DEVICE(isadev);
-
-    qdev_connect_gpio_out(dev, 0, irq_set[2]);
-    for (i = 0 ; i < 8; i++) {
-        irq_set[i + 8] = qdev_get_gpio_in(dev, i);
-    }
-
-    slave_pic = I8259_COMMON(dev);
+    pic_obj = object_resolve_path_component(OBJECT(dev), "primary");
+    isa_pic = I8259(pic_obj);
+    pic_obj = object_resolve_path_component(OBJECT(dev), "secondary");
+    slave_pic = I8259_COMMON(pic_obj);
 
     return irq_set;
 }
@@ -447,6 +459,90 @@ static void i8259_class_init(ObjectClass *klass, const void *data)
     device_class_set_legacy_reset(dc, i8259_reset);
 }
 
+
+static void i8259_pic_set_irq(void *opaque, int n, int level)
+{
+    I8259PICState *s = opaque;
+
+    qemu_set_irq(s->pass_irqs[n], level);
+}
+
+static void i8259_primary_out_irq(void *opaque, int n, int level)
+{
+    I8259PICState *s = opaque;
+
+    qemu_set_irq(s->pic_out_irq, level);
+}
+
+static void i8259_pic_init(Object *obj)
+{
+    I8259PICState *s = I8259_PIC(obj);
+
+    object_initialize_child(obj, "primary", &s->i8259[0], TYPE_I8259);
+    object_initialize_child(obj, "secondary", &s->i8259[1], TYPE_I8259);
+
+    qemu_init_irq(&s->i8259_primary_out_irq, i8259_primary_out_irq, s, 1);
+
+    qdev_init_gpio_in(DEVICE(obj), i8259_pic_set_irq, ISA_NUM_IRQS);
+    qdev_init_gpio_out(DEVICE(obj), &s->pic_out_irq, 1);
+}
+
+static void i8259_pic_realize(DeviceState *dev, Error **errp)
+{
+    I8259PICState *s = I8259_PIC(dev);
+    DeviceState *pri_dev, *sec_dev;
+    int i;
+
+    /* Primary */
+    pri_dev = DEVICE(&s->i8259[0]);
+    qdev_prop_set_uint32(pri_dev, "iobase", 0x20);
+    qdev_prop_set_uint32(pri_dev, "elcr_addr", 0x4d0);
+    qdev_prop_set_uint8(pri_dev, "elcr_mask", 0xf8);
+    qdev_prop_set_bit(pri_dev, "master", 1);
+    if (!isa_realize(ISA_DEVICE(pri_dev), s->isabus, errp)) {
+        return;
+    }
+
+    for (i = 0; i < 8; i++) {
+        s->pass_irqs[i] = qdev_get_gpio_in(pri_dev, i);
+    }
+
+    qdev_connect_gpio_out(pri_dev, 0, &s->i8259_primary_out_irq);
+
+    /* Secondary */
+    sec_dev = DEVICE(&s->i8259[1]);
+    qdev_prop_set_uint32(sec_dev, "iobase", 0xa0);
+    qdev_prop_set_uint32(sec_dev, "elcr_addr", 0x4d1);
+    qdev_prop_set_uint8(sec_dev, "elcr_mask", 0xde);
+    if (!isa_realize(ISA_DEVICE(sec_dev), s->isabus, errp)) {
+        return;
+    }
+
+    /* Wire up secondary cascade */
+    qdev_connect_gpio_out(sec_dev, 0, s->pass_irqs[2]);
+
+    for (i = 8; i < ISA_NUM_IRQS; i++) {
+        s->pass_irqs[i] = qdev_get_gpio_in(sec_dev, i - 8);
+    }
+}
+
+static const Property i8259_pic_properties[] = {
+    DEFINE_PROP_LINK("bus", I8259PICState, isabus, TYPE_ISA_BUS,
+                     ISABus *),
+};
+
+static void i8259_pic_class_init(ObjectClass *klass, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->realize = i8259_pic_realize;
+    device_class_set_props(dc, i8259_pic_properties);
+    /*
+     * Reason: must be wired to the ISA bus via the "bus" property
+     */
+    dc->user_creatable = false;
+}
+
 static const TypeInfo i8259_type_infos[] = {
     {
         .name       = TYPE_I8259,
@@ -455,6 +551,13 @@ static const TypeInfo i8259_type_infos[] = {
         .class_init = i8259_class_init,
         .class_size = sizeof(I8259Class),
     },
+    {
+        .name          = TYPE_I8259_PIC,
+        .parent        = TYPE_DEVICE,
+        .class_init    = i8259_pic_class_init,
+        .instance_init = i8259_pic_init,
+        .instance_size = sizeof(I8259PICState),
+    },
 };
 
 DEFINE_TYPES(i8259_type_infos)
-- 
2.43.0


