Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71A0FC83F03
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 14:12:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXh8R-00010w-Tm; Fri, 04 Jul 2025 10:11:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1uXh7o-0000kT-40
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 10:10:49 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1uXh7m-0004hE-CQ
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 10:10:47 -0400
Received: from pps.filterd (m0127839.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 564CLwts008830;
 Fri, 4 Jul 2025 07:10:42 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=HIDDp/ImnI5o3fK+jKitf52nowJEBqWm+3iG3Lt6g
 xk=; b=XXIRWsaBz9k01jyVwUrsI1hQCPxuKbOOavWoWJ05Ac8eVTvRojkchWB7P
 js87vAGCE51fsAwh1ENcpDqcoIJTWlETrq9LTCmLXISiJO8F0D8Sg3JUlcqqS53B
 U6az+HClR12XbuktRTqlnji5t5Vu/g/1TBqQgQOHIHOM3KORLrIORU94uVdOUWq8
 vWnX4a2wZWAIeLiLox9tXPIP0Vfr1o5lCkb/lHTSy26CylWelNs0TqFdaiRXqpwl
 lbVU0lYxrGS5f6jLbUi52h1kJrPs6+txXb4GmgbyqGiGKcZ4pjPhQhxpqpqNv07t
 l0M+I++lzrUsTsicp1b6hs9Rg5xsA==
Received: from nam12-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2139.outbound.protection.outlook.com [40.107.237.139])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 47mhw30fu3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 04 Jul 2025 07:10:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CMkBuBPzeBtW20Jvt9vQy1bMBgzM2S2ydJLT24AFtm4uIVYwlAWa893WHgF+w8LYT5nMw5XalFVoyQSrl5GfF44D0GBQNVcX9fkkP/I2PtqVy5kVBWfel8UwZJoWumIMEIJl5ch5Xv56sUolwjfBCIfe0pF46DnhxwguhcGInL+5qRs0iKKDHN2XXlW9xwDyMDQokJe92qN4POQf9AmzBvOuUSlZFZ0pBM4S11KfuGdKH4a5LX2AW5FEKulBiol2KNSMpHTTxMMjmotyjB5crPcRGzzmKQLJl5KJSmTQ4SMGfAzSgfjZGrdyXgfocVvWWkwSlXYQGE48KjWSv/ACqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HIDDp/ImnI5o3fK+jKitf52nowJEBqWm+3iG3Lt6gxk=;
 b=ejKTQ+jgpGrv/t4pTR0KJMumDLxJ115qLOQ+VpxtXJ2CcXsNSHhWTared9EJDrOmTksQejgptjoopNLt5KQ0Fff1LlfPU5ZbsfzB8Sqwdz/s4umdJIgG7ooaNGYI/ivJFKIb/uc86wRg/iKRxUPvXnB2e2k3JbCWNLwKE92g/E53DNeIlK8260rrxdr7xj4GQ8FbtuN72Dz+bQnZ8cVEGUeUFFfSNY5KaH/0Hn1nlhbi5LK0IVoGk2zGPoStNEis3esaKd4ca7/D0IEw54IvwgJR2AQ6zWeaH7g9dpiIkWTOANECHpP3yzH56mLB+cK+89seY++ZTF5AZdQECIES/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HIDDp/ImnI5o3fK+jKitf52nowJEBqWm+3iG3Lt6gxk=;
 b=YcwGV3MpHOGtQlrNfJlWe1718bR0sDUrqmE2FOpzCbUvbulREYKovXLWNGLJlOsx7XrEFTqzOcFyONYPmRQCfOV1wGgNukyKELkH/ixl3BXPxhadhbUCFRy0kXCvzEJipQB1We5GjaYkTO2IId//4TZyLWU2EB5HMoGY5vISUBkCrth6Q0ZsUxbj8PyLVH4bRA6vkEP2lul/iR0GT1EUY0+W8LT180QoAHO43vyBQxMcQDdf9Q7w1+3VsjTD5RU5RWCiY6OUNMgYdaP/V3vJ+c04j9DLy74dnbAQcVImQCE2hcRsWLMpqZj9/k7TX82Rk9PEIPafxP1mN2A3o5BagA==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by BN0PR02MB8045.namprd02.prod.outlook.com (2603:10b6:408:16d::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.21; Fri, 4 Jul
 2025 14:10:39 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88%3]) with mapi id 15.20.8901.018; Fri, 4 Jul 2025
 14:10:39 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: pbonzini@redhat.com, mst@redhat.com, marcel.apfelbaum@gmail.com,
 eduardo@habkost.net, imammedo@redhat.com, qemu-devel@nongnu.org
Subject: [PATCH v3 05/14] hw/i386/pc_piix.c: remove SGX initialisation from
 pc_init_isa()
Date: Fri,  4 Jul 2025 15:09:32 +0100
Message-ID: <20250704141018.674268-6-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250704141018.674268-1-mark.caveayland@nutanix.com>
References: <20250704141018.674268-1-mark.caveayland@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4PR09CA0007.eurprd09.prod.outlook.com
 (2603:10a6:20b:5e0::8) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|BN0PR02MB8045:EE_
X-MS-Office365-Filtering-Correlation-Id: 34bda3e7-2d2c-4421-0e84-08ddbb048e32
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|366016|1800799024|376014|10070799003;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?8uem179ZjS/mltGWSDDUqQUQBE1bdRS1LpOo9J1MZoTHcSk/aduciD5xndft?=
 =?us-ascii?Q?nObPpT2+Y+LDq9u1FalluYOX8JyEpOEMEmt5Gsi2yvItE/Xp0ClHchoXcjZi?=
 =?us-ascii?Q?7/PvgTzFPb4igD7eA8rJ7MTx/vytZ/ixMKzkxhpSn8/Ouc7YZqtX8MMrRScN?=
 =?us-ascii?Q?A/b4pVLkDMKxw+jaCy4s2Lj7wFbWGug0IdDYN5hB4LetA6d3UKvWXxb8M2sJ?=
 =?us-ascii?Q?5y1eQjwNobCwaxcASqWioEMjnNoYEWPrLADBcJdqFautX9NzaPq31EPM1+QM?=
 =?us-ascii?Q?QtRBPr4tiMcIHGTNKVg/g6Rfp9RnxJABBANdy2Li0roKBnpM2JzaaBoeKXKV?=
 =?us-ascii?Q?Y8Xj37bsXuItLOI8FKz5IrchLXyh5eM7qbz8HmHyFn89nMhYgso9IfBqoi/O?=
 =?us-ascii?Q?gexTRHDBCzz6Zw6Zsb7vA+rv1KAkPPQXXuoITPSPXuRpRyEXV0QRaUfz3FUd?=
 =?us-ascii?Q?0atTkUigachZPf9mmlaxqzjUgHXnGgaoPuisg/Bel8fUcf1EBkzk0tBElERO?=
 =?us-ascii?Q?fX7UpSK4IWl99v6n0RVIDUnJ2PEK1gIv1pyl2o8UXkaGWr4sxQSATuEGrETM?=
 =?us-ascii?Q?apygCG/hS6Yzs0c5Z//AJtiGIn5cI+5jSyq0ShKi2qwi2BW7fEVAto65FgMv?=
 =?us-ascii?Q?0zZi/y224sZlZyTx408fNw00eRpt6OezbTOKn4z4aLkLjwkyPyrBjMUIacui?=
 =?us-ascii?Q?exaibmlm9fd23rYlbOG7BxLzFTa2qS/OmJJHzbNd4h721LNqFnLaifX7FVp0?=
 =?us-ascii?Q?euqV8OufAx79J/QPYFc5xFL8qSTa7k1+VU1/cnEHRTt3DetJ6DoHRuJSWTL7?=
 =?us-ascii?Q?1oJxbieXGv2BXv8Y5caJUxtEAaRuBwFYtPyY0Cy/WfbYMHgc+iAEFzBlVXn1?=
 =?us-ascii?Q?Qd9Z9yxoUm08oth5cvvzscLBuSUpL7etqMLS+IXhQKc7RKP0z/tRPhkFekr2?=
 =?us-ascii?Q?7pPQUrdIzrUO3RBt1YSi3nrrqRTkJWhg3HK7yioxdnpge2BPTT5p80bZlg0z?=
 =?us-ascii?Q?kc5O0ZfLLa8MwE0+OxhXBHH2170lu62FDFgBGPFNkxbIo6eZo6ELBo4giF6j?=
 =?us-ascii?Q?oJHf1XmzaquRNJy71o8n8seLqog3fXNVXfUxg+qVMEV4GirsLRjgtkolBRLh?=
 =?us-ascii?Q?BIzAWbGqoabgLVmUXC+tVSGIv8DGDdqM4onRXUP80rdLZj+2VATapsGI3ryV?=
 =?us-ascii?Q?2mKQV3GqjJc6NomfE0Pn5bf869fHtfNSQAsnyfk50yX47Bd28TCXVPr71twq?=
 =?us-ascii?Q?zrZOV5qTdXhDrJIlFc2kWawY/DW32sUj4kgLXWpXLfFOgQTZmlHkay/asiFw?=
 =?us-ascii?Q?+lfaKohWLF5Is0x4Nz3hUpR5sC3czB5tUKMQGSfQKbBvlbMrkiRaRG6a+7M9?=
 =?us-ascii?Q?ApxvCXqYav0TtUKpB6GenrUdWcMKd8WgMW+QWh083W3JtgfXQg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(10070799003); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?r++qBkCnuuU8YY3nPZ9Psh8H3nLts/z0yPe5Jn7xsRhZFv2eb5bN5iqc65lk?=
 =?us-ascii?Q?bDCOIn+IJZ9UFCTXhx1t41R31u4daVyF+h1HPIHN2ljbgYp0mNm2TVJ//mBj?=
 =?us-ascii?Q?gZCRDEjFPsY2Ao3dyo+d/tn8UScRJzNni3y1GbuaUe1ThagnFWKu2v3alIaX?=
 =?us-ascii?Q?BT0Ek47vH1S7o7cDnvynHCyVH5Su+bHLZDQBSTZPG3uD2ZUHFRqeCv7+cRVA?=
 =?us-ascii?Q?qy+jcgxr7wWqUEm/pGltaSz2mwTXVi72dphcesJH7ftf+oXrnUKufdw0Los/?=
 =?us-ascii?Q?0LA3b6Y03hsQJYR+k7+35i3PUWa1Af1AaVPlAPPaFSwhj1oruFopg144itlx?=
 =?us-ascii?Q?U1HDB0mgXYqN+5yTqbfZQo9cwhlRMmN3YpwAlXq3E9DEu/Jd+ICJRITEmJzk?=
 =?us-ascii?Q?jmVu9dPrYDPRown6pQftBcvnuKW5gYUfzNs9khUTdYAOOSmvC1a3LmFNdio1?=
 =?us-ascii?Q?w/ataUAI/EO6dt8vlrOKgLGcXwTLMbj8/2sxV+omN3c5C27JwO1aOkmYY4rN?=
 =?us-ascii?Q?tQcQGpLlOHsE8i7PeJ8HXZB2SdGTmFZc6eNgGHLEA9uOzLn7/W/fgg6ujv27?=
 =?us-ascii?Q?yoHw3Y8HRq4xKJC36NXeII7jJVuF+CVLAk6RVB/oZf/CMVZ9nC8p7jDkaSyB?=
 =?us-ascii?Q?YaLOFmGg7KBqXJ+lCD81Fg+2Wx+afiMCBaOOWIt5yeIIpnfU9oKHsP9xuut5?=
 =?us-ascii?Q?zMMvePguW7y8rxNJV5eFLiHnPKPtnA2g7bfUOUUdhs+/OuI1fLAaCCjyRsMb?=
 =?us-ascii?Q?oTh/pnWn04ZhsPaumaOSDY6krIu2+y60C22bxkozV3Znf1N4VVcZG416f07l?=
 =?us-ascii?Q?XJeb/R6Mg+p5CPTHYCZvuonBcedmlHb8ZGMXUfox7N3xR666B3qW4aJSwfWp?=
 =?us-ascii?Q?dVgjXcpJWdPjITyQ/0ObCyIjWCG0atnfu310uaQWcRVxjWxQ96+rG9qnV2of?=
 =?us-ascii?Q?VghcehnF8+7TftcbwK6zN76Jiig+7WnLaejrUC6ZcrdLp5biD5BdXMwRY2Ng?=
 =?us-ascii?Q?9FJLXEIcU95112JKyD25MGqzTKShkExXPcq9QityrJF0xyNw8AVsF+Phg6n7?=
 =?us-ascii?Q?SwAoBQB2iCcrENPVIsCbd+nEgmpEDVw6iSfFLz5BsRZwhAu18V11JsgQIUWj?=
 =?us-ascii?Q?F5gI3axEXKqQEqtwaHj0zIZBZn9I2BJLhG/GR8VvGuXUn5kDVyBPk8zDwfNB?=
 =?us-ascii?Q?Tq4cYCWS+fiXcKuEdwDiS9IiRZi6w0hWrmmNyfZsfpMCvww8fEa6KjrEGWkl?=
 =?us-ascii?Q?K4HdJ3XAlMSuT8fpspf7L1PsjIMfN+eSvZYrlKrDWbvN6DOGYbAvwosQBWe+?=
 =?us-ascii?Q?InbxhGc+0E2eTyp5AJkqnhkEayuBy23SGNnivqroCq1N2djKSCkvWVMQXGOP?=
 =?us-ascii?Q?lDSMslqN5Y/MCtMKnOtzKim7s+JpkarRcd+FPLOFWC92mDG8zXCTVrY+7VJp?=
 =?us-ascii?Q?TCt5hKy6cQ+seZf10vYFSBA09F/WHZ16jgSgJFmOUX19qR/uQtNCp00tEq38?=
 =?us-ascii?Q?564F3h8F9tYTBPXCTCqB8pU3CJBqvvIDE7O3X39BvKcewiumEacRE9ikbFnH?=
 =?us-ascii?Q?J7AukCy9RADsJ3rxATBNhnhVPzLmFeK4NcP1A9s2Z3zjymbVVUjh5vOueqvC?=
 =?us-ascii?Q?gwTuDqgTUaJtxMHN+u5WV/YJv3Blf670URB86vdnPtWgudVhVywdhunK/zcf?=
 =?us-ascii?Q?O8yQJQ=3D=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34bda3e7-2d2c-4421-0e84-08ddbb048e32
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2025 14:10:39.7104 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Wp+7usAHDGiBbbLq2gWvFvCTo5TYImjdOAX0k7t5HQjsSndkREkPN3wjokfk4HxX/QSsNvNpc37HOJdNn5aZP7v+ltHSFJZC3VYSk3J9Ec0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR02MB8045
X-Authority-Analysis: v=2.4 cv=ctGbk04i c=1 sm=1 tr=0 ts=6867e0e1 cx=c_pps
 a=96FhCRI2SFwVpwxLm/ws/Q==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=Wb1JkmetP80A:10 a=0kUYKlekyDsA:10 a=64Cc0HZtAAAA:8
 a=yiTRickECGlooSfTVXsA:9
X-Proofpoint-ORIG-GUID: vY8-aGP3Kmu1jnebJls-O6j0egm5W7x_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA0MDEwNyBTYWx0ZWRfXxVfDpMmEhF/f
 2yOJtAwp+Pq/0+QPo/dy6OWPeg1P21fMMZ04bI8Ei/95HfpQ5pBZroEGZdjETG/Jtjfpgqjb83X
 caBlztxV6YpQ9nx2GE0Xn74NyclbmdyriA6WzD1dUZmmnnMmGMD4n4CP4OHA1aiK6nK/wWmHDCL
 PuyRr7Q7zw/RmrOrXXqt9lP+YTsnFctSJztcQZJmsYw39VBYJLtm96Yfxv8L7crkvE9nJGMGT7G
 l9faLmz8V8ipwdKSZw6/243JCpFd205s8M4iaFYCgQqzsk/rlfWNeGkK7Jj9gW3tex7uOcwcXCn
 BL0s91Z3XHTuGGFgoaGYerSCBdAKufs+q2Z4Pe7uvNsbgQ4sKXrRwXp6x6sobiIGEUDKkAM3KnR
 cm1PApFSVuWaOHImSVnoutuGMlPZ7qoM1M4+0h8/9uupN1FZNIgEbKixup+G1ergK2zk0YVW
X-Proofpoint-GUID: vY8-aGP3Kmu1jnebJls-O6j0egm5W7x_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-04_05,2025-07-04_01,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.218, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

The Intel SGX instructions only exist on recent CPUs and so would never be available
on a CPU from the pre-PCI era.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
---
 hw/i386/pc_piix.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index baaf744edb..75226aa775 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -492,8 +492,6 @@ static void pc_init_isa(MachineState *machine)
         }
     }
 
-    pc_machine_init_sgx_epc(pcms);
-
     /*
      * There is a small chance that someone unintentionally passes "-cpu max"
      * for the isapc machine, which will provide a much more modern 32-bit
-- 
2.43.0


