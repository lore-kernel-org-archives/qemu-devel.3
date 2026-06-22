Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07AD7CDB470
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2026 11:26:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbclq-0004K6-PU; Mon, 22 Jun 2026 07:24:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wbclh-0004Ih-QA; Mon, 22 Jun 2026 07:24:46 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wbclO-0001R1-FJ; Mon, 22 Jun 2026 07:24:27 -0400
Received: from pps.filterd (m0127843.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65MAoV7E012745; Mon, 22 Jun 2026 04:24:08 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=proofpoint20171006; bh=XZ8X4Jx7Jqwgr
 Cnzdl186AWj0FR5vTs6+lzxGeybm7o=; b=xUmN1BbVoIaL3eSyQKbyan7gBAENf
 Nth3UTC/Dr4wdZoqcV+G5K+mT7HQiqe/KTX30uw4u/gMuZLgRB45o/WKlRJ0UcZ+
 eUA1YWucMhlVlVoKHZArsd4adkJIG/9KqmLBGPPeHO78dav198352PWhImgqwGlB
 9Oazn8maCWQrJxFU0xWJnXclo14BflvEqKSBdvlWLT33XuDYMaR9f3BOS6qidnwf
 w8RiP4GBXGM4EfErRU903KQ6ippZIjM/LUQWgiZixKOMETIAqUycwecImYYjIWG3
 8EBLhDe8tG1D7iJSqyrwJf7pY27MbPMRIVKFwxokPolyySr9KaAucRi5w==
Received: from bl2pr02cu003.outbound.protection.outlook.com
 (mail-eastusazon11021086.outbound.protection.outlook.com [52.101.52.86])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4ewryh3hkp-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 22 Jun 2026 04:24:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AfzGEf5KU/GqSFPVtxeTE4I/KVSdR5JAYdCJgJ4Hd7UMj9EkyQL8MW3pzUngSXqiAgWAXg/pb4aQCDLqkwWoFx8kxDnCbV1+ZL0PrmyHrCNpTB91mfgd1twNSNCU/k0IxxZaBI7EY75jpf7niKPvuijeK7cXsrZX68rp1LVX5MeswgxPpPEpqKUZQQR/v5rtSH7AdgvailnbVDRSXGfL3waoW+X7Tegb4v4x3EotEaa7U70QhrTyzfJB34X3h6MrZmIV7UQQ1Zy4Xfo/pMOszN85rASLL9tCLd2MWZYfifXnV3IfolxLlX14XMvFe2zgSI7ON7hY6HuXQq1O7Dd8Rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XZ8X4Jx7JqwgrCnzdl186AWj0FR5vTs6+lzxGeybm7o=;
 b=gl7P08KZOs7iq+UjgupqH3jP3IVLJjLI9U/SX1onejhM9ECdqeNjYkROpSxtgAgUD6rgFNqGkYz9DoFFZ5i7OYYeM++cjwLj/XxsBzbQTG2oRZjA9nGVn9o+8b9CqEYU9rnpnD7TqEJbnsDHbES8NvUac428jruQjYP+usXhzFeZtKGnFv53qU/lTxaQj7kI4/cjSuw1CgIpq6L6+O9iq9lW4PswbqlnPtBHz5XIyZ2mr9NaU4I+LWs7Ey3cZ+912p9DVfyrXeqrHGTLIS17iQ6Fb/83r6v8KnKjblekrQNcuSirvrSR49xbUe+tTf/IrbL0lnzsMHgxsYZ5ThgMdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XZ8X4Jx7JqwgrCnzdl186AWj0FR5vTs6+lzxGeybm7o=;
 b=qREKu54H1jYYAAcJYDG2X/+xuu4jbGSQN43EkZeBbfw94FmoP5dhq31E2D1BQzEy+biWtlXtvQ2GlH+bcENT0Dt/UL8E2ajzizPdAqNw+7TlP6ThnAeAOBqy6MSqj3yKiaXaoG5Yg6Q9Td2GpPRLN/uV3CDdpTVfQkXjYjEv/h/hAKqU1nooRv0W8d0g3maPkdW1aG4RjF7xmnvlKUVXfOms6ve5hDn55cqvaqCziTmoK7TUFlu8apx9RlsP9hFyU5cNpcTdYRLbW7K5v6rmwI78CUC6hrlVYWvjt+p/Y3E7RhBFwcIwM3BPjY9sEPKn62Q2lxtGk5pmPqp/jAG7Nw==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by DS0PR02MB10661.namprd02.prod.outlook.com (2603:10b6:8:1f8::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.20; Mon, 22 Jun
 2026 11:24:07 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%3]) with mapi id 15.21.0139.009; Mon, 22 Jun 2026
 11:24:06 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: mst@redhat.com, imammedo@redhat.com, anisinha@redhat.com, philmd@mailo.com,
 aurelien@aurel32.net, peter.maydell@linaro.org, pbonzini@redhat.com,
 richard.henderson@linaro.org, qemu-devel@nongnu.org, qemu-arm@nongnu.org
Subject: [PATCH 0/7] hw/acpi: convert object props to class props
Date: Mon, 22 Jun 2026 12:22:32 +0100
Message-ID: <20260622112403.928954-1-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CY5PR18CA0024.namprd18.prod.outlook.com
 (2603:10b6:930:5::28) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|DS0PR02MB10661:EE_
X-MS-Office365-Filtering-Correlation-Id: 52942329-34b8-46f5-2863-08ded050c5cb
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|7416014|376014|23010399003|1800799024|18002099003|56012099006|921020;
X-Microsoft-Antispam-Message-Info: rlAqn3CB4dokLkDA+N0mRDh0MaMu4q5bJPUtRoCeBUzbYl3t97C1wX8sdL/L3cXDebSX41CnWUL+Hhww0GMBYRbrz47qU8oAOxNRBuA3IcR8HFfUvBdx9ce8nJjEU5/7PkCMDwn2lyoeR9WpEim+TsBLPaTT1JXjU2GEZ4pnDVV75NASGELuWquI3CITHf5ohALR/d6g3zd0PWKeyCj8YesZbPXxTEeV08IipHkNAZE30gyXx6oKAmKE7jMEnWUjhQIinYHTHXD7I7/lMNA6fdIjjwSWcjfI+O2wxsiXvvmPI9s7HvTf85IZ8VKyUIgumF+nz77n/q82d2n3M3Ad0IyYsApVcY+WpTu8U9zaZRVkbeCQhoqJCJ+wm+KrA75hdiAWFuLscdzyvcJG9FkLMlnw08h7TtovbAuieXojGznnozwRrVKGcR3Nn1pYg+e4+eNDYyMxSWVtiewhIoPr8GfWRhgtvNANgQRhvXAcqM1besXomTW2dOqrnLbYWiWXNPxUFU1QwoCnBzFF57H7paAun2/YQusWU4q2P8YWXTxeVT3r2O90umnAGCVi2FVNgVRx7b3D/jhcb9vFXylSFhQHjtl1eAC8/cGVtsb0xkk4Kp8EEM5hxjYXdRn0/71Sxl3djUwObqZeNpnByziOCK5zQI2IIhMrJnRQrGXlY/Do9AwAViKu6mxPNIuj4GsZdCnNYOsY4Pe6JhwemK3j4w==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(376014)(23010399003)(1800799024)(18002099003)(56012099006)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2x80lyluWgz7r6ryAFfdNhPUSmvHHh5Ap/vvbidVEDI4qaPvrW0bkb1L5io/?=
 =?us-ascii?Q?lgHoPMdPmKEr482SwaCx7DRQEvkFHj7avDi4C6CjtIwN6Lcyj+Cbhp29kGas?=
 =?us-ascii?Q?DvY0g6HbcJfq6ZkR4pLiVjXU/IiEwa5AyCexc0V8ONsJPdHDX7Lq48MC7RwY?=
 =?us-ascii?Q?f3s/mrsWHd7FclOycZeiyxQUrSZZ6xrTZRuWuCNBJnpaFSCS2jkST74LZGlP?=
 =?us-ascii?Q?WoQkFTS1aMxymqmFIzpuwXqBbpOkXQCxz+4JxQZEzJCtf+y8+0C3Zo9QNwWx?=
 =?us-ascii?Q?e2zFbyOKh39y2FqFuMs+9A9xGyWEbmtQ4m9lZJN/YyE/NhOZydnTPtJRK04e?=
 =?us-ascii?Q?5hSuiV9V8JXB9PxHYMwtQnH70krf9LD1Ogz9wvgxCYIoIrjO8AOwiAlU9T0V?=
 =?us-ascii?Q?skl/Mwv1b/rYqeQ47eihpxS8rvOSuR0BP2+8tb4iIv/dlCd3+dk6ehy7bNvg?=
 =?us-ascii?Q?1TUgcNA6N+32zcnSQAfbiFeBVEBXCMmoCLLDW/XMZtBmtKKR3tLejeB0uQkP?=
 =?us-ascii?Q?AlCHxyYBeao0GzYBmt7j3oRlMvpqC+vW3tnSPbDEc+pCJPLbC1L/D6E7x1On?=
 =?us-ascii?Q?QMpBcQI0Cj8uSU6x6x6+46AtOg9tJZLNn1+F/4iXl518l/5paFPm9hw1KPTs?=
 =?us-ascii?Q?r5ZY7mFSvC4dZRmLKxrrszVJx83ocsgYWH12Xy/HP9zJvSUu+g3Kl80oc+3r?=
 =?us-ascii?Q?N32nY1Hl5T4u7hoAKzFUL9X252EG/sAUYtAfaOiKBpLSNns0ohp0cMRJMBjf?=
 =?us-ascii?Q?QvD2UoX4fRKxsRRXtD7uUu0eSyustV175FgEmEQpwy0midrk3q3cHyCPRfH3?=
 =?us-ascii?Q?zeYMfVuqq8/sx0jIJKfRx+cXB135KGVZ0EF+niAaDDh0mDWWk4Hjgirp+fDY?=
 =?us-ascii?Q?+C6fn+C7n69aEihOWcGED8Vvv9umoiCWvmPcPKNrYeA2RvLM5ciqxAUztFND?=
 =?us-ascii?Q?s/q5YuEqri7jFjtCy3kQzTWQSmJPXp66i3oQFC1HCm1HymFgDoCqysrRpJK3?=
 =?us-ascii?Q?3+aZNqLc/43FXkbK8IyGXfofDgjIm4JPjFWp95Dv/HzDnKNLSnCHLeYusWIT?=
 =?us-ascii?Q?EvCED7VUcoSGjULvHas84L4uaiTvemzqlf2zLTV4fMcBwbK0GucRzenU873/?=
 =?us-ascii?Q?lHlB3XSYPlN2kq9b1AYJWJcYZcYpRIBXlqIbot9EXjEp/zDncrsEpAVGef9U?=
 =?us-ascii?Q?/WYw1MpRUcX4mELyPx0QJbRQK9moaJac/FlsbtzPvhNO9FXxH8p1fbpDsHgn?=
 =?us-ascii?Q?x+WFKB3/v02Iso42iPSLOKqBlxsdwDtzaLojjNK9WefmiuQSga/m67g7kQc8?=
 =?us-ascii?Q?X1Ix2HtXMUnYtKS0xeQjSXkJDIbs4CRJR4XXKBNjJ5QyxaLnjReLNE/0K39v?=
 =?us-ascii?Q?bo6KIJy2IT9kBlD5vemkU3EtcX1Vpy7hX/k7I9MbsCUvlaWjx9Y1yd3oN/Y/?=
 =?us-ascii?Q?ZS5SA3EDqyjlSI0BHOgDprWgC0wS2Ru3fcpTSO58to21AZ3J1nSy+TYqm0jk?=
 =?us-ascii?Q?KST+c3QLp0M6NlCWsDvp599RGYEbVgQg1ZLc+k+ol99mPlZpT5R6ta05n840?=
 =?us-ascii?Q?v361g8yduVfQWNWwOJ9nfBDPJi+/ovvnpyFfvfYGoEgoyrIu6CqV/spYkYDu?=
 =?us-ascii?Q?fEE37Ic+IjL7Gq7w6ux5MKQ2r4rPx89tEvHBH8XmTprWQSB/f4nOnHC03y9z?=
 =?us-ascii?Q?jZLvXoBQGgPOXpICH4+qVX4B9py9cJ+B7/GcAl0IBP4NjqksaKj8j7zUU6Yo?=
 =?us-ascii?Q?E2CWabtw9RtqGqFTVV3eYXl7TAcQ0lA=3D?=
X-Exchange-RoutingPolicyChecked: tHOiy2hs8tatSBQhBvcJXaZNxPZGGlA6mq+USjwkETKeVL4a+975qrnBHbktFkRE03IJESqPhhQI2gNcM09VIXmH8C0P1857GeEbtUM4uGKz8TUhHjPuY+LKhMXh3XddhB96Wlnwodop93SCzb4kVQOsp/SiUp6RzjFTjhE+Lx9TbHBKor2QtLPUdqL938mqwJbsTUoSC8OIsh/3l5eLgWZsXktLEkEJBq2BKvqLmRDGKg/RSfSfQs8mjGFHMikFnwWeYgRP65qT/bczqAyCmUd0+6nJyPcr8pQu6ZpXUrK9GSoK9k4ZDrzH+ymXpA42015b6NPBnWkZeL13gtMYZw==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52942329-34b8-46f5-2863-08ded050c5cb
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2026 11:24:06.9438 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1heL7kp+1+Ao/pyZg7bDN4mbgZG4zphRuTPFeHwm+g+lsy45Q3k+IBr591cU0pR6m2II2UGFYZPNczuYpnmsPBm2PC2QZ6diTCqPFc1IvGs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR02MB10661
X-Proofpoint-GUID: KyoeXnH38hNtvyVPErLTMdV0xgfWm-f7
X-Proofpoint-ORIG-GUID: KyoeXnH38hNtvyVPErLTMdV0xgfWm-f7
X-Authority-Analysis: v=2.4 cv=M6p97Sws c=1 sm=1 tr=0 ts=6a391b58 cx=c_pps
 a=cYh382HVqWHDP9j+lsVPNA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=FelO9ux0wxsA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=dEe9Ve2bX-KnNSUMM2s9:22
 a=64Cc0HZtAAAA:8 a=nEMlYpgs98Qurv6oBlsA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIyMDExMiBTYWx0ZWRfX9r60GL9CWFjL
 207rUbu8/96Q2g1xQwzqGT//znuJ76E3kpEM+Ik489F3qKZbA9Y85rAM0LawnyF57176UFuGV+S
 T3pf4otV2H8wkeyCL6Wy2en+zsh0QCA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIyMDExMiBTYWx0ZWRfX4plYt/Tb5718
 bCQEI2U98m+MM9qVhmnxNxv8Fwq2fsY7T5v1kA0JaK+adk05ozNZZBwANVTFiCPtdV3fImP39uw
 SS8SJhTnwp6uEh4LgvAeCArb5c2yyqXNDqrqvze90lWbwe4Rsw2/rGoAPtdzXUD/vmKe8CT3vLt
 HFkQcyoArAG5TB/3QAecrKgRtUB5H4t7+Q5L6Jbp0knqaJO9AO1TBT3AQ6y5pu/9Yjxsy5NKuLZ
 T5p63WcQ5coeOfhztEB7WU2MIvwOxwJrqZaBYLV3lFz8u8+pOLNJoI8VlyJO2pmgagBKrr/6I/J
 UntQ/Le5I4zxNattASzCHfAx72rahIZfYxY/qvqo8WksKoUFONGuDyok/qhfkkEHvIIVFD5R7ND
 RjRQdlxMIDh8HpHBsLxz+HwhjZzsPNFhiZYHjjXq9izkcqvyPJ+9CLEq4igo37Xo9ejTp73KKLF
 R5NnjBmvusId14KIHRA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-22_02,2026-06-18_03,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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

Since the use of object props is effectively deprecated, here is an attempt
to convert all use of object props in hw/acpi to class props. The eventual
aim is to continue working through the codebase, removing all remaining uses
of object props.

The series is lightly tested: it passes "make check", GitLab CI and some
simple local tests. I'm mostly interested for feedback on the conversion
strategy, and to get a feel for the best way to merge this series since once
the basic conversion patterns are in place, the same patterns can be applied
elsewhere and it would be good to minimise the merge window for such changes.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>


Mark Cave-Ayland (7):
  hw/acpi/ich9.c: move initial property values into
    ich9_reset_properties()
  hw/isa/lpc_ich9.c: convert ich9_lpc_initfn() object props to class
    props
  hw/acpi/ich9.c: don't pass ICH9LPCPMRegs via opaque for
    ACPI_PM_PROP_GPE0_BLK prop
  hw/acpi/ich9.c: convert object props in ICH9_LPC_DEVICE to class props
  hw/acpi/pcihp.c: convert ACPI_PCIHP_IO_BASE_PROP and
    ACPI_PCIHP_IO_BASE_PROP to class props
  hw/acpi/pcihp.c: convert ACPI_PCIHP_PROP_BSEL from object prop to
    class prop
  hw/acpi/piix4.c: convert object props in PIIX4_PM to class props

 include/hw/acpi/ich9.h         |   4 +-
 include/hw/pci/pci_bus.h       |   2 +
 hw/acpi/generic_event_device.c |  30 ++++++
 hw/acpi/ich9.c                 | 192 ++++++++++++++++++++++++++++-----
 hw/acpi/pci-bridge.c           |   9 +-
 hw/acpi/pcihp.c                |  37 +++----
 hw/acpi/piix4.c                |  72 ++++++++++---
 hw/arm/virt-acpi-build.c       |   7 +-
 hw/i386/acpi-build.c           |   7 +-
 hw/isa/lpc_ich9.c              |  68 +++++++++---
 hw/pci/pci.c                   |  32 ++++++
 11 files changed, 376 insertions(+), 84 deletions(-)

-- 
2.43.0


