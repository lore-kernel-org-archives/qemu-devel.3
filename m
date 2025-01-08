Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A06EE77199
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2025 11:56:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVUds-0006hh-KA; Wed, 08 Jan 2025 06:54:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1tVUdR-0006Sl-HR
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 06:54:05 -0500
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1tVUdN-0002GR-9s
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 06:54:04 -0500
Received: from pps.filterd (m0127840.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5085doxe029507;
 Wed, 8 Jan 2025 03:53:59 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=jT5vc9RMxKHNpMOVEYQJ7CKcShkwSZKdcqR06HbFd
 P8=; b=V7TOLyGBKBv7qFlGUVCbv8CiZjrH60iIzvYcaXgG3JVONuXv96rpSctjm
 K5xIqdmD+aaG6z3azCJkoCd3T0w4Hv+MZ3SeoL3tMNAFlD/aYol3wFW4gI+vK8qI
 abb3h4dSZ9ZrUu9l/K74a8TDcXlHcxBFBSQ5EAJ0d9o83YFZ0SyMFMIleh/pas0x
 DyhHQFnB2s2ukfWiNWU/Qr2xeK/lrXj1mE4Ehez6am1p5N78TMj8PGA7ukOmLQPO
 1uUudO2yZwsmCuSqXuH9bJ+uLzMQx9rfjwO2srKDgks4Fa+cL0HMIcDDFA5dl/Df
 VDlLeGR5ICd7Va43fx4ez+UTpf7dQ==
Received: from nam11-co1-obe.outbound.protection.outlook.com
 (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 43y26xqhax-4
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 08 Jan 2025 03:53:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X0GqRQxNqLN12SeBpK1y6Tzps0jBYMNi85p+ltZsrlXlqOvV8ITdPaMkILoNCc5MK0KZkcgzBDnamQpEZlDpK1LeSBrZZFqlWgkuoNwpXLz3EYePnunkbXeGi421S18625oBKWkNpODN7FF2qar82tFhEGR7c69QGja6RF7btjbcFOZrcnFFxmWqGJVjROmPlh5Z2xkFyJUynlXcX7XSc1B4n30LxEsKbBRC71RYev4yfTiY5s9nmcp77K1QbodDGImeEchedegZbhngHJmqYbNeo+X4dajGLS37wjuVKrgmwPXmAGRsZnnkRFlsmF4mxA+Y7KasTknPMU1DtQqeXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jT5vc9RMxKHNpMOVEYQJ7CKcShkwSZKdcqR06HbFdP8=;
 b=gHZMuqT7wHC70wuNzElt+YJb9wNye/LM1vaK5sV6o26BkTjwIMLa15baxBcRQyabm+KTO3L9yWKaOc3NIcWv1sayL5YkFUpIfGhOYiSic2Grb5xSglNZbP84idQSud4Td9zhtBmAVJvXg7G71lEmlTbXYVzkg0ktrhnwrqKhnHIF+rFjllnf7Fcfavy9C2rFtnPY3RYHv95RYa+zzNQDo5wvbkw6T/UhRJ1KJTMQ2PUOszLDuIWvZLDwy/uypClnp2lAM+o3nZg9uPH+g8nbeHHhQO4/e4+fT5mLB1hMDY+AZrEXJO8bxoaUR71J+OR4gLkXDEhKWd0WWiBnImSdJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jT5vc9RMxKHNpMOVEYQJ7CKcShkwSZKdcqR06HbFdP8=;
 b=GOjXqNfYujuIl/GQ/Jbj211uR88VjAujAmh4gFFITQE2nfxUIZL/JXASl3WMi5qApfExjuE6LiB7Fevpue7Zt/vGp3fZeCHvg/apjPP65w5LOybgVZ+36VQk+IsKD4TR4JXkA6LTvSgWTvESKvTqNQ0EOuB1j90A4qs0MKZTq5WxMLY5tvzgf4sOyn7vAk8esQdLDZ0/JRba9BJ2lDM9h/VgqRPZzfZMa0jDUZcMuq6kWB94YIhw9znEY5t9M8SQXHawu+nFrU2VBWwHLttqvgs0oamUCR60iXFcWq+nBXAS88h+OxchQ2rn75Ly4VFH/ZtdHNfpEZV0/kAMxIECEg==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by PH0PR02MB7670.namprd02.prod.outlook.com (2603:10b6:510:50::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.10; Wed, 8 Jan
 2025 11:53:50 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51%4]) with mapi id 15.20.8335.010; Wed, 8 Jan 2025
 11:53:50 +0000
From: John Levon <john.levon@nutanix.com>
To: qemu-devel@nongnu.org
Cc: elena.ufimtseva@oracle.com, alex.williamson@redhat.com, clg@redhat.com,
 jag.raman@oracle.com, thanos.makatos@nutanix.com
Subject: [PATCH 16/26] vfio-user: region read/write
Date: Wed,  8 Jan 2025 11:50:22 +0000
Message-Id: <20250108115032.1677686-17-john.levon@nutanix.com>
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
X-MS-TrafficTypeDiagnostic: CH2PR02MB6760:EE_|PH0PR02MB7670:EE_
X-MS-Office365-Filtering-Correlation-Id: 77154de9-c376-4381-4402-08dd2fdb1e01
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?uv34jXyx8C3+6XJPNbtfNZcz5OzPsCVlJ0M4VRv7FNAXcK2wwxPQpYfgg6LV?=
 =?us-ascii?Q?hxTRYI9F1qXj1MEd63o5X7jpqt8QnmMdfHkLLVQdV8y3vhZFA7okVjAuto3m?=
 =?us-ascii?Q?VB7xdIT5X0HoNSY5/Sv3ghtYvWwISzGySjPwoMWLIirr41+EEOe/r8+eGFPk?=
 =?us-ascii?Q?dzPOV6MtIelBTjQwxnoB/ZOc3P4JcwuCghBhEfFXrBuh3ll5FwEGQA0rcIsD?=
 =?us-ascii?Q?CQuXm1VpvfB3VBpAXgiaBtEtVs58eGIVIbtj4lR5fGmnP7Ezf7yU3O7l14L6?=
 =?us-ascii?Q?27mFomytSMRfLvTKooup7lTfOKYuFZ0ybeFmkp427hDuY6cowT2XofxyI6o5?=
 =?us-ascii?Q?SeCfOJinVAjsZSipVM3pnCoheNquU83J55mmLVzqrKZGzHG04rYtQMcOM5kq?=
 =?us-ascii?Q?eG+MiguSssQzm935vm9LLx4v0RZp9WGSr4vIWAcPjLiZN0KeEtNFhgQdG4N1?=
 =?us-ascii?Q?jvkhtSKXZRV3b/BJJB4CyvEpvfrCnMU6HfbIjlxkKy2qvSfuBByrfM7nUiYR?=
 =?us-ascii?Q?bm7f8iONXaVLZ/dhbcfxWWG1BycXK+IxptuCbMhFVW8EDRLq17uZgqVX5cDj?=
 =?us-ascii?Q?/P6B3snB4SLeYLPCL+K7WJD4YAFhBZLNjQsGeRxzHP31sji+tQTDqDGhsxkl?=
 =?us-ascii?Q?e+Uyp5ibQ9CanNFSFqV18/lR60KFozxuFIvKVcM8bEQSERaeyuJQn/+80oun?=
 =?us-ascii?Q?eCAMU+5PrmAfETAD+3iaN5DG4Dm1TiBWINhKt6GQ38jHjdD26Od4VXgLbL8P?=
 =?us-ascii?Q?H+ROTE6svzUshQfEkorvYkMexSdoJ+rvq5/XXfKQX2ogPc7l55PUQ8P2l6br?=
 =?us-ascii?Q?AbTgCfvew7ADULd8hNaZE78MiF/EKjU5pjeM5ClI5GSi5brG9oLWr1ieU68+?=
 =?us-ascii?Q?0MNgCa0ZLErHUmCWTAQU9a/hDR0d2ZwDK2gwKK5jH/AKwRm6zAf95k8SAv+L?=
 =?us-ascii?Q?8IvuQ34ttk+bO4ze0fhO5fU0Fyt1CWnL3xWvENPP0LMqRUvuMVm9H9LzAY/5?=
 =?us-ascii?Q?XMB9Q848aqZtBhjXWbC3A4R3oCb5muTeLsKjtt+pv0+GOvkqVEL5FmAth175?=
 =?us-ascii?Q?DKRsPLa6f/RWk6uDCfBLybMqR7kxjBUlh8OAdxZXbSJ84AiqSMOaalfgxqD5?=
 =?us-ascii?Q?EZ+poQcM4uqTuTYIt/zmu4BN1rwxT/uPI0Mt9ZpBWwolzItfinsrv6+B8J6r?=
 =?us-ascii?Q?aYKfPkMgJiVsulUc2W9vyMcFL+Uoxv/aqrgrD7vlQiAW7u7fEPSorfsynczR?=
 =?us-ascii?Q?55i7jYD9vFL/npgo1tchiro61zqqlm/YfftYtbWJ8N/0t9u2SuqqEXYgU/7G?=
 =?us-ascii?Q?v6wngc9jSgpKVMdHFMP6/pqrJn87O5/Ud0RuJeJol9HM7nzJP63TH/h1C6j1?=
 =?us-ascii?Q?89bzH1ewCJYxqyjA7JvJrNLsqm0r?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Iy5ZqNugzptxqCcnj/8Kn5Ihkn2JFWkZYgtxLzA4jU0tvf0N1fsK4mkxQM+X?=
 =?us-ascii?Q?PtKZymD3ZQGxm1TxbfDmHtcyD19OvHj5GuQcqHJ/PtAa4GIF32FIsi/6H2rz?=
 =?us-ascii?Q?zEoCNL52mVeFi+vBPL9bn1GmNRXVuOnQQtO7YMsdn7pQ+oK8wIlHWLMGlfyG?=
 =?us-ascii?Q?axD6HvmAAxaAU+G91xf173XQ0yiY9iU3cCQt1Lr8JtwMvKGF0MRPaMRRBsWW?=
 =?us-ascii?Q?EeD5wPCu0hiY2X7ukKirwfJtwWLHKXTJqcNp+vN87ZbyZ1PM8NH09vWDwp1p?=
 =?us-ascii?Q?KlPyGj19uAb27iwbnS+6iqHbEuO2yECDwF7B3by4/hzXKi6GlYBlf36FHa4X?=
 =?us-ascii?Q?Eu7z7m/cVv/7JSCBRE/IDBRmZ3LLJXKfZ8/BCZM8jYVBDUsTdDM/l8w2hpwA?=
 =?us-ascii?Q?VpXsTZAVKwpw3ue99YSWPgt5ICmoQ7rXhdfC+c10m3NKksX2Fv5QAqnTELjr?=
 =?us-ascii?Q?R5py3XjCcMwEOqfau9XYISe4nVo6BoOHPFhnLRW+DSo+gCQutfvYSF6dMQUL?=
 =?us-ascii?Q?+R3R6ZFfCfTYbHpjiEqhCb+w6PzCFMcQ9ra8PMhmkc4qVEEWwcdBXm/LRAzh?=
 =?us-ascii?Q?mJvaPGxHr4E0KVesPCAPGwCW85mrmCKkM6+CtXUUPpNYT9pGRfQ6qBKJvX4K?=
 =?us-ascii?Q?GEvNpZLgQvCHvKcwmfmeYrzLkm78ZPKwdounuKrvSGK/4prx313T0BHl1gFq?=
 =?us-ascii?Q?QOlpMb9V0L+Vq3ZMHIqug2o21Tl/gN9O/KnIXpk8eXOgW8DYe2Du7wCESwCF?=
 =?us-ascii?Q?vaHcrSfJ//OD1DtCHVLYE57WMfha8zZ8skBWiDAZEQ8jN8vcFAnn18fBwkFy?=
 =?us-ascii?Q?HUc8WKQB2RXFkea8lNchVkuP9/GHgPM46aFaPViqdM9VdYvPkctMcCjUpHOO?=
 =?us-ascii?Q?AVIt0Ah6chK4MwhtJKHk5dsFyjKpEXji9k8SakADFwIy+KQAJNVKEKIQ41J2?=
 =?us-ascii?Q?p5ZorPaigzwH8j5a6gb0xhsTvlz1K+3aCgMD1fS50VONURavv7//OPt5PKp2?=
 =?us-ascii?Q?BKAbYAmbE0J/P/yX3sOchuuDr1PrcLy8D+kCQVC9P6dqRQigcbB/HmQ4J+6/?=
 =?us-ascii?Q?VffQqe4Jc+ojVkcocoMYRhp8ttBXziXKkddWpOvars9vvDy0tj0E+12SECAa?=
 =?us-ascii?Q?RO3uE+VeunSTbm2m9ZKTY56yGo+s+6LoJUB4dHay3JQ78FYgTC564JgnAoHa?=
 =?us-ascii?Q?MnWENseqMx02lzuXXmVOv8BoQMQhcE78xbLfwiN6zeD5XpCY31UH4WK3A05m?=
 =?us-ascii?Q?GkhFfHc1fF7O4W7s70i4qjvQFlKhl8nGEziRe2vMoQ9BdXTt7EJv8SNqYrip?=
 =?us-ascii?Q?m+bZR1LUME8bOzjVaJsZSzOEt01g2aBLkgw0fGoqGvdJVG9gJ9/o1J9Kr+vH?=
 =?us-ascii?Q?kk/c109RJteYfHyGlx4dBdA/tvffKN6EYpguaXsKInBXekvejR06gkv2+aej?=
 =?us-ascii?Q?QGOef27L6L7G4dEckA7/SwGXvu98XygD2WlLZzV1Cqn6BDeSMqEUvqA4hzfu?=
 =?us-ascii?Q?O9vrG9vbKpQgP0mjkm7IghRMd6JZQOlUVQGdDO7JvpZBWGEqUX6rYKdmqOId?=
 =?us-ascii?Q?nJF0giuzLq/Z4oWhTb5zsKDvf3m9TjO6SrT33ptN?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77154de9-c376-4381-4402-08dd2fdb1e01
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2025 11:53:50.6338 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FIDup80bF8xyiIfmv7Lo0/iNTazaC8YnQsbuz53xOGSFZRQt9winMu0QE0OMSEk75wiI/6Vcro2TJkFxouRyJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB7670
X-Authority-Analysis: v=2.4 cv=Z/cWHGRA c=1 sm=1 tr=0 ts=677e6756 cx=c_pps
 a=MPHjzrODTC1L994aNYq1fw==:117 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=VdSt8ZQiCzkA:10
 a=0034W8JfsZAA:10 a=0kUYKlekyDsA:10
 a=yPCof4ZbAAAA:8 a=64Cc0HZtAAAA:8 a=xcYbaV23Nb4-Kc-IWXIA:9
 a=14NRyaPF5x3gF6G45PvQ:22
X-Proofpoint-GUID: K-m487dTmzcl1PXWPaLiOmI4XM3_vmcO
X-Proofpoint-ORIG-GUID: K-m487dTmzcl1PXWPaLiOmI4XM3_vmcO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-08_02,2025-01-08_01,2024-11-22_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=john.levon@nutanix.com; helo=mx0a-002c1b01.pphosted.com
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

From: Jagannathan Raman <jag.raman@oracle.com>

Add support for posted writes on remote devices

Originally-by: John Johnson <john.g.johnson@oracle.com>
Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
Signed-off-by: John Levon <john.levon@nutanix.com>
---
 hw/vfio/helpers.c             |  20 ++++--
 hw/vfio/pci.c                 |   5 +-
 hw/vfio/trace-events          |   1 +
 hw/vfio/user-pci.c            |   5 ++
 hw/vfio/user-protocol.h       |  12 ++++
 hw/vfio/user.c                | 120 ++++++++++++++++++++++++++++++++++
 hw/vfio/user.h                |   1 +
 include/hw/vfio/vfio-common.h |   3 +-
 8 files changed, 158 insertions(+), 9 deletions(-)

diff --git a/hw/vfio/helpers.c b/hw/vfio/helpers.c
index 802d6ae101..ea3dbfa96d 100644
--- a/hw/vfio/helpers.c
+++ b/hw/vfio/helpers.c
@@ -183,12 +183,15 @@ void vfio_region_write(void *opaque, hwaddr addr,
         break;
     }
 
-    ret = vbasedev->io->region_write(vbasedev, region->nr, addr, size, &buf);
+    ret = vbasedev->io->region_write(vbasedev, region->nr, addr, size, &buf,
+                                     region->post_wr);
     if (ret != size) {
+        const char *errmsg = ret < 0 ? strerror(-ret) : "short write";
+
         error_report("%s(%s:region%d+0x%"HWADDR_PRIx", 0x%"PRIx64
-                     ",%d) failed: %m",
+                     ",%d) failed: %s",
                      __func__, vbasedev->name, region->nr,
-                     addr, data, size);
+                     addr, data, size, errmsg);
     }
 
     trace_vfio_region_write(vbasedev->name, region->nr, addr, data, size);
@@ -220,9 +223,11 @@ uint64_t vfio_region_read(void *opaque,
 
     ret = vbasedev->io->region_read(vbasedev, region->nr, addr, size, &buf);
     if (ret != size) {
-        error_report("%s(%s:region%d+0x%"HWADDR_PRIx", %d) failed: %m",
+        const char *errmsg = ret < 0 ? strerror(-ret) : "short read";
+
+        error_report("%s(%s:region%d+0x%"HWADDR_PRIx", %d) failed: %s",
                      __func__, vbasedev->name, region->nr,
-                     addr, size);
+                     addr, size, errmsg);
         return (uint64_t)-1;
     }
     switch (size) {
@@ -364,13 +369,14 @@ int vfio_region_setup(Object *obj, VFIODevice *vbasedev, VFIORegion *region,
     region->size = info->size;
     region->fd_offset = info->offset;
     region->nr = index;
+    region->post_wr = false;
+
     if (vbasedev->regfds != NULL) {
         region->fd = vbasedev->regfds[index];
     } else {
         region->fd = vbasedev->fd;
     }
 
-
     if (region->size) {
         region->mem = g_new0(MemoryRegion, 1);
         memory_region_init_io(region->mem, obj, &vfio_region_ops,
@@ -827,7 +833,7 @@ static int vfio_io_region_read(VFIODevice *vbasedev, uint8_t index, off_t off,
 }
 
 static int vfio_io_region_write(VFIODevice *vbasedev, uint8_t index, off_t off,
-                                uint32_t size, void *data)
+                                uint32_t size, void *data, bool post)
 {
     struct vfio_region_info *info = vbasedev->regions[index];
     int ret;
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index b57059d676..90cf29325f 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -51,7 +51,7 @@
                                  (off), (size), (data)))
 #define VDEV_CONFIG_WRITE(vbasedev, off, size, data) \
     ((vbasedev)->io->region_write((vbasedev), VFIO_PCI_CONFIG_REGION_INDEX, \
-                                  (off), (size), (data)))
+                                  (off), (size), (data), false))
 
 #define TYPE_VFIO_PCI_NOHOTPLUG "vfio-pci-nohotplug"
 
@@ -1780,6 +1780,9 @@ static void vfio_bar_prepare(VFIOPCIDevice *vdev, int nr)
     bar->type = pci_bar & (bar->ioport ? ~PCI_BASE_ADDRESS_IO_MASK :
                                          ~PCI_BASE_ADDRESS_MEM_MASK);
     bar->size = bar->region.size;
+
+    /* IO regions are sync, memory can be async */
+    bar->region.post_wr = (bar->ioport == 0);
 }
 
 static void vfio_bars_prepare(VFIOPCIDevice *vdev)
diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
index ee6d7a0d0a..da8af45ee9 100644
--- a/hw/vfio/trace-events
+++ b/hw/vfio/trace-events
@@ -189,3 +189,4 @@ vfio_user_send_write(uint16_t id, int wrote) " id 0x%x wrote 0x%x"
 vfio_user_version(uint16_t major, uint16_t minor, const char *caps) " major %d minor %d caps: %s"
 vfio_user_get_info(uint32_t nregions, uint32_t nirqs) " #regions %d #irqs %d"
 vfio_user_get_region_info(uint32_t index, uint32_t flags, uint64_t size) " index %d flags 0x%x size 0x%"PRIx64
+vfio_user_region_rw(uint32_t region, uint64_t off, uint32_t count) " region %d offset 0x%"PRIx64" count %d"
diff --git a/hw/vfio/user-pci.c b/hw/vfio/user-pci.c
index 60cd9c941c..aa5146db0a 100644
--- a/hw/vfio/user-pci.c
+++ b/hw/vfio/user-pci.c
@@ -40,6 +40,7 @@ struct VFIOUserPCIDevice {
     VFIOPCIDevice device;
     char *sock_name;
     bool send_queued;   /* all sends are queued */
+    bool no_post;       /* all regions write are sync */
 };
 
 /*
@@ -102,6 +103,9 @@ static void vfio_user_pci_realize(PCIDevice *pdev, Error **errp)
     if (udev->send_queued) {
         proxy->flags |= VFIO_PROXY_FORCE_QUEUED;
     }
+    if (udev->no_post) {
+        proxy->flags |= VFIO_PROXY_NO_POST;
+    }
 
     if (!vfio_user_validate_version(proxy, errp)) {
         goto error;
@@ -173,6 +177,7 @@ static void vfio_user_instance_finalize(Object *obj)
 static const Property vfio_user_pci_dev_properties[] = {
     DEFINE_PROP_STRING("socket", VFIOUserPCIDevice, sock_name),
     DEFINE_PROP_BOOL("x-send-queued", VFIOUserPCIDevice, send_queued, false),
+    DEFINE_PROP_BOOL("x-no-posted-writes", VFIOUserPCIDevice, no_post, false),
 };
 
 static void vfio_user_pci_dev_class_init(ObjectClass *klass, void *data)
diff --git a/hw/vfio/user-protocol.h b/hw/vfio/user-protocol.h
index 6f70a48905..6987435e96 100644
--- a/hw/vfio/user-protocol.h
+++ b/hw/vfio/user-protocol.h
@@ -139,4 +139,16 @@ typedef struct {
     uint64_t offset;
 } VFIOUserRegionInfo;
 
+/*
+ * VFIO_USER_REGION_READ
+ * VFIO_USER_REGION_WRITE
+ */
+typedef struct {
+    VFIOUserHdr hdr;
+    uint64_t offset;
+    uint32_t region;
+    uint32_t count;
+    char data[];
+} VFIOUserRegionRW;
+
 #endif /* VFIO_USER_PROTOCOL_H */
diff --git a/hw/vfio/user.c b/hw/vfio/user.c
index 44e8da8aa1..118314b363 100644
--- a/hw/vfio/user.c
+++ b/hw/vfio/user.c
@@ -55,6 +55,8 @@ static void vfio_user_cb(void *opaque);
 
 static void vfio_user_request(void *opaque);
 static int vfio_user_send_queued(VFIOUserProxy *proxy, VFIOUserMsg *msg);
+static void vfio_user_send_async(VFIOUserProxy *proxy, VFIOUserHdr *hdr,
+                                 VFIOUserFDs *fds);
 static void vfio_user_send_wait(VFIOUserProxy *proxy, VFIOUserHdr *hdr,
                                 VFIOUserFDs *fds, int rsize);
 static void vfio_user_request_msg(VFIOUserHdr *hdr, uint16_t cmd,
@@ -626,6 +628,33 @@ static int vfio_user_send_queued(VFIOUserProxy *proxy, VFIOUserMsg *msg)
     return 0;
 }
 
+/*
+ * async send - msg can be queued, but will be freed when sent
+ */
+static void vfio_user_send_async(VFIOUserProxy *proxy, VFIOUserHdr *hdr,
+                                 VFIOUserFDs *fds)
+{
+    VFIOUserMsg *msg;
+    int ret;
+
+    if (!(hdr->flags & (VFIO_USER_NO_REPLY | VFIO_USER_REPLY))) {
+        error_printf("vfio_user_send_async on sync message\n");
+        return;
+    }
+
+    QEMU_LOCK_GUARD(&proxy->lock);
+
+    msg = vfio_user_getmsg(proxy, hdr, fds);
+    msg->id = hdr->id;
+    msg->rsize = 0;
+    msg->type = VFIO_MSG_ASYNC;
+
+    ret = vfio_user_send_queued(proxy, msg);
+    if (ret < 0) {
+        vfio_user_recycle(proxy, msg);
+    }
+}
+
 static void vfio_user_send_wait(VFIOUserProxy *proxy, VFIOUserHdr *hdr,
                                 VFIOUserFDs *fds, int rsize)
 {
@@ -1139,9 +1168,84 @@ static int vfio_user_get_region_info(VFIOUserProxy *proxy,
     trace_vfio_user_get_region_info(msgp->index, msgp->flags, msgp->size);
 
     memcpy(info, &msgp->argsz, info->argsz);
+
+    /* read-after-write hazard if guest can directly access region */
+    if (info->flags & VFIO_REGION_INFO_FLAG_MMAP) {
+        WITH_QEMU_LOCK_GUARD(&proxy->lock) {
+            proxy->flags |= VFIO_PROXY_NO_POST;
+        }
+    }
+
     return 0;
 }
 
+static int vfio_user_region_read(VFIOUserProxy *proxy, uint8_t index,
+                                 off_t offset, uint32_t count, void *data)
+{
+    g_autofree VFIOUserRegionRW *msgp = NULL;
+    int size = sizeof(*msgp) + count;
+
+    if (count > proxy->max_xfer_size) {
+        return -EINVAL;
+    }
+
+    msgp = g_malloc0(size);
+    vfio_user_request_msg(&msgp->hdr, VFIO_USER_REGION_READ, sizeof(*msgp), 0);
+    msgp->offset = offset;
+    msgp->region = index;
+    msgp->count = count;
+    trace_vfio_user_region_rw(msgp->region, msgp->offset, msgp->count);
+
+    vfio_user_send_wait(proxy, &msgp->hdr, NULL, size);
+    if (msgp->hdr.flags & VFIO_USER_ERROR) {
+        return -msgp->hdr.error_reply;
+    } else if (msgp->count > count) {
+        return -E2BIG;
+    } else {
+        memcpy(data, &msgp->data, msgp->count);
+    }
+
+    return msgp->count;
+}
+
+static int vfio_user_region_write(VFIOUserProxy *proxy, uint8_t index,
+                                  off_t offset, uint32_t count, void *data,
+                                  bool post)
+{
+    VFIOUserRegionRW *msgp = NULL;
+    int flags = post ? VFIO_USER_NO_REPLY : 0;
+    int size = sizeof(*msgp) + count;
+    int ret;
+
+    if (count > proxy->max_xfer_size) {
+        return -EINVAL;
+    }
+
+    msgp = g_malloc0(size);
+    vfio_user_request_msg(&msgp->hdr, VFIO_USER_REGION_WRITE, size, flags);
+    msgp->offset = offset;
+    msgp->region = index;
+    msgp->count = count;
+    memcpy(&msgp->data, data, count);
+    trace_vfio_user_region_rw(msgp->region, msgp->offset, msgp->count);
+
+    /* async send will free msg after it's sent */
+    if (post && !(proxy->flags & VFIO_PROXY_NO_POST)) {
+        vfio_user_send_async(proxy, &msgp->hdr, NULL);
+        return count;
+    }
+
+    vfio_user_send_wait(proxy, &msgp->hdr, NULL, 0);
+    if (msgp->hdr.flags & VFIO_USER_ERROR) {
+        ret = -msgp->hdr.error_reply;
+    } else {
+        ret = count;
+    }
+
+    g_free(msgp);
+    return ret;
+}
+
 
 /*
  * Socket-based io_ops
@@ -1171,6 +1275,22 @@ static int vfio_user_io_get_region_info(VFIODevice *vbasedev,
     return 0;
 }
 
+static int vfio_user_io_region_read(VFIODevice *vbasedev, uint8_t index,
+                                    off_t off, uint32_t size, void *data)
+{
+    return vfio_user_region_read(vbasedev->proxy, index, off, size, data);
+}
+
+static int vfio_user_io_region_write(VFIODevice *vbasedev, uint8_t index,
+                                     off_t off, unsigned size, void *data,
+                                     bool post)
+{
+    return vfio_user_region_write(vbasedev->proxy, index, off, size, data,
+                                  post);
+}
+
 VFIODeviceIO vfio_dev_io_sock = {
     .get_region_info = vfio_user_io_get_region_info,
+    .region_read = vfio_user_io_region_read,
+    .region_write = vfio_user_io_region_write,
 };
diff --git a/hw/vfio/user.h b/hw/vfio/user.h
index 18a5a40073..1f99a976d6 100644
--- a/hw/vfio/user.h
+++ b/hw/vfio/user.h
@@ -84,6 +84,7 @@ typedef struct VFIOUserProxy {
 /* VFIOProxy flags */
 #define VFIO_PROXY_CLIENT        0x1
 #define VFIO_PROXY_FORCE_QUEUED  0x4
+#define VFIO_PROXY_NO_POST       0x8
 
 typedef struct VFIODevice VFIODevice;
 
diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index 50b136b7dc..3a2e3afaaf 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -60,6 +60,7 @@ typedef struct VFIORegion {
     VFIOMmap *mmaps;
     uint8_t nr; /* cache the region number for debug */
     int fd; /* fd to mmap() region */
+    bool post_wr; /* writes can be posted */
 } VFIORegion;
 
 typedef struct VFIOMigration {
@@ -218,7 +219,7 @@ struct VFIODeviceIO {
     int (*region_read)(VFIODevice *vdev, uint8_t nr, off_t off, uint32_t size,
                        void *data);
     int (*region_write)(VFIODevice *vdev, uint8_t nr, off_t off, uint32_t size,
-                        void *data);
+                        void *data, bool post);
 };
 
 extern VFIODeviceIO vfio_dev_io_ioctl;
-- 
2.34.1


