Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39DABFEFB4F
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Feb 2026 13:46:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvyAj-0000mv-JP; Fri, 27 Feb 2026 08:46:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1vvyAg-0000iP-GD
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 08:46:23 -0500
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1vvyAe-0004DH-FD
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 08:46:22 -0500
Received: from pps.filterd (m0127840.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 61R9qngU3562890; Fri, 27 Feb 2026 05:46:16 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=proofpoint20171006; bh=/5cFH9upydnY2
 VlSAG0gIRiR4DfFu0oNcMbE+gPNhZ4=; b=fejdd5ni5jdabcj5SyTW5JCRcPr5u
 eePf+hE3gMqEAise0sEPRzLxQJx4hIM9LhtyE3b1AEIQwnjDiI8KoEzD40BzL9xN
 cJWI86NO4kmZxGcYZyvZdvURysHJkRIq+FSU8Bln4sHvsqr8HmwWBeM/YN4XlPq+
 cpzUeD6PydHySIClBgFNiwuFGDcMpMZxn94OEwnnYn8rSXZFwHnU6Byfjkiw1/Wo
 upjUzN5A36OT8VFPdyvSjf/jCew5aSXlg5r8RqKIvpsok+MFOl0dWLhIzuy4vqSJ
 07YpV2VgLyVs7SucWcgkGfLvp8R4kgO9+QEVCwKi8+tsfY/BBMqjQyiIw==
Received: from sj2pr03cu001.outbound.protection.outlook.com
 (mail-westusazon11022111.outbound.protection.outlook.com [52.101.43.111])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4ck915rdbv-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 27 Feb 2026 05:46:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nRQ0z+ij3ArIFMjw7ccxVUmYs8SsSd8EYYGl52ZULGve1d5ek7xfwRjN0o6vD/L51BwJd0T8b+OZHLfdLYAlrtBRCjJ2wqfk64hIki8NV5kYrTJrgGzevmrnfuXHomF746+k8coB7JNXqct2b+MFCsJZRFSLoiPppwPp8/G7ue6XydZg/N5cwkIuVGv3Pkpo0jLdJEiZOJdZa9napU2paBG81+Fi8BUidsw9Ls/nBryFpxJAkmwMTUyrmE4LH0iQ/R47wmQpa9lqjQBceVxOQs5whvpAHWuoGdL1NVKE+JVq1OVWCeIIXK9BJsiK+DJ5+cR+aRyTuSYUwnVIDyErqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/5cFH9upydnY2VlSAG0gIRiR4DfFu0oNcMbE+gPNhZ4=;
 b=oBuP+8ge/R1wnh/fgKGWWx9fg94RSJNU3w/dtbdKIjdcuUIM1oc6EwoR+i4jLmen/nfuq8m+8z2VnLavYMU8KyoKXYDlZ2DyB9T8obiGV77E1dJc5I8n9gPN9YPz2MPnjB1kkdUMMr6EXqQhCrrHdKrtftvkPn0aIVi82YtflK42kjSt/xYEIBr2O5OU3kcFDIw0gOR07qAdVy7iWyh+/jy3vH7Gs+6OZEPaPIaFIvLX+AoaWd4sRHm03m0dfIPx+dgrDDChS/wW3tMHLxZSucnIWIJUtbqwrOruTNuTqiJx5w0lwKOFk6nsMK92eGffVdTXFYxl7X/Wbr/degqE2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/5cFH9upydnY2VlSAG0gIRiR4DfFu0oNcMbE+gPNhZ4=;
 b=iWK09X7BhZpmbGgRUZ9BJ78ggal8wXKe+/uYNzI/jb3u7kzg2Es0VL3BASnurxmcvAMxVVJpLqiPR4emAAde9MJDBW2SWF+UHIJlKVgbpxAbruYJCHfr95iwmHYbefMzt4S1MYfb2ygXUIbkUU1V8o1JiAVkOOI/5Q4J9n442swbg9xYwOheNHWaJ+/zqHBKLqqmz8pASGUfcGHB7XA/CJVwptlSJ1TaRtZO3rTnwRk8kes50zt4tSFtFqJfD0VhxoFQYqXHmMUog3T8YfPiqz7hCdGuo4S2/CMqZVWxSfaEFWnfhVSblTcjBCMMj15uh0R/7hsI4ceICfncQFPHNA==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by LV2PR02MB11277.namprd02.prod.outlook.com (2603:10b6:408:354::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.16; Fri, 27 Feb
 2026 13:46:14 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%4]) with mapi id 15.20.9654.015; Fri, 27 Feb 2026
 13:46:14 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: mst@redhat.com, imammedo@redhat.com, anisinha@redhat.com,
 pbonzini@redhat.com, marcandre.lureau@redhat.com,
 marcel.apfelbaum@gmail.com, qemu-devel@nongnu.org
Subject: [PATCH 0/5] isa-serial: acpi: declare shared IRQs for COM1/3 and
 COM2/4
Date: Fri, 27 Feb 2026 13:44:54 +0000
Message-ID: <20260227134611.1229390-1-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH2PR15CA0019.namprd15.prod.outlook.com
 (2603:10b6:610:51::29) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|LV2PR02MB11277:EE_
X-MS-Office365-Filtering-Correlation-Id: e0958eef-29b3-4161-1636-08de76069320
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: 0lnLhNaXA67j0ImCiVvRSlBkgso8g1PCQJGIAFLARutES3GeyEdjl3eSgcfXVm1UoxqUCWkMj3lJ135d+0yuBRbVMT15Mi1K+Dypk8hMrOhVt9NinhdTWKDDqv+BOeeQLt7hw0LjNHB5eRXVLOetVufJaSTQqDyn92/k0s93WY2Maz+28bMr4B7/fWVkB4glqt8O2x37qC+N2Ou2KTTQ5RYOUTlg4wg4Ii84I1Fe6giLWQY26bpiFB0w13exgTyYX4iom1izYJMj6eoZS/1D66Jril7ZDBxBVOuwGC7L1qrUSSoGGk4yTHuPZ3a7/C0wMUcdjT5CrUmX4fXXmJm9cEOGHyWs1z6vIEstzWwyhAerd+D67YRvFWUuIOjvsglLD/PXMWVZjAtIO8D8kUOJhW3S2+EoE81O9gRnbhOBDV8NvR+lIETjEwU+nx8fOTFn02XyGi1diE0QGvj89MPdGveG/ui8f19tWk2rj/i8hxH1UdS2jvQghVA4WoJNh1is3PoaLpXRkfVNVGXnzEOe40ONbtWiwuX0aXwgf64QhPlhJOqwjBtVJHHDcBN9Rqk6yR8I+rnwMfwjetIfZcZRCUCbh4UNMBZy/uTQPUrgBs42bjffjE2Q9q+cK/Fd4l5lZmxUGM0RmhuBLL59PzXhWqxAuiIRhg8g0NxY7qOoLweifc+7p/DQxpG7ORn4T5g56wyBZAPwbdS/+jPyzhZr2MBcCRGN4b1KZHasRyryA68=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?M6tVrs2Ap+ekyJZn/mrndehJYE3T1QhatcnzM0m5W+Fmvt5CGSt91pNUisov?=
 =?us-ascii?Q?jnFl8l15kPJjICT2fITpdrVQVP5U2/afWDg6SAVU/jjBMjR5RfsMX5/qhcOm?=
 =?us-ascii?Q?V0qYm4BrecJwkwoCpk/uABQl6mlSqJgtsxjoAvlX2T59lboCVIAaxn4UeU84?=
 =?us-ascii?Q?E5sR/wyfpgA/r2IaGFki31RtUnMtLkKfLTVKkB6gYL5GMU/AvALlf2f6yLPq?=
 =?us-ascii?Q?EIrSo29rhqHxqkG5kf3XR9jIj27w18+EIyS3de/a9s5DoD9f8vAFJL7Yb9Ey?=
 =?us-ascii?Q?cGgjFmpZbaCCJ0Aa3C9dQ/cEk125zUbuCb4xx/zaKA6QAL//iv3NdetjwCfn?=
 =?us-ascii?Q?GItfMIifVs7wbotZRP/G4kWge0UrM2wjeSWKn+y0azda1/jx79/pEgp8JU3y?=
 =?us-ascii?Q?YD8U/I//DAIoWRCfn6BKZZdup8csvqmm+JS0nfZxzTDDMJMiGSBNSt3Dibdx?=
 =?us-ascii?Q?1T8r0NgyD0nT8rk/VzHUWIbRHnHGO2n050tDB0zHm3u5SPvZF5Gh6c74ykLx?=
 =?us-ascii?Q?IvuMncltluuWREtoRMiUj0xG8GY/49nyjbWPJ9IwOOK92sh60A32W51MsfIc?=
 =?us-ascii?Q?32DO0S5OpUVLWGOHGUM50Njz+6PbRy37O8dVBrNGTwnlMrpWnrBPdFGxuuIy?=
 =?us-ascii?Q?8GDEv3rZaShL7zYwu8MjGMuaahebEsNw7sODmQmnBVM9d+a2VzXSnG6Fb8Vi?=
 =?us-ascii?Q?ZIAx2uRkmooGMf1VaBv8EBxh6mn/e+jrWCrrO3LXmL2yZEEr3nJrGOSTHr0/?=
 =?us-ascii?Q?7cE6rXx+pvTgbzVaEPxnQZoHQwvn1CySTwl2eyjjS5atXmoPKLSm2kdHiqaR?=
 =?us-ascii?Q?9eQRhcSexgij7ZKR13VnTn3kSP3TAQjFv2Tisu9E1jPf4FVTGBfsIr1Pov+c?=
 =?us-ascii?Q?JDLVQEoBTZAjXOMgimX8IDJ7rsdeVJ8uldIF6rC6z7EHFCY1iPB9RgW2UsPC?=
 =?us-ascii?Q?j7MyPDkFzEUfuVoY3ilg+2ShOBpiQouZeg6WtG+vbPLCPlGF5jYMCzLL+nMD?=
 =?us-ascii?Q?FAhY+aEYxX0PY3MF5A8mhOrEA04MpuMpQb22SZBn139Q21bM+5I9R/DUkQbe?=
 =?us-ascii?Q?Iou3XBUXHF3O3GuvKV+tTFqd4BHnsOe8IjmSePTHl8f5643QermpRIVFdHsq?=
 =?us-ascii?Q?COgJVwTuMIO3PJGFYb0kGYrjSmmCRPTlKuRjysvrtj7+hfqfRZWR8Cb4slef?=
 =?us-ascii?Q?Yu6kMS6vv+m2BNJs+JgGCgdh626dwUciNbQ4EYAGaHAJDFLHpPA1h4zm4G4y?=
 =?us-ascii?Q?V8FZicNyTuayI0jWo0CX2BY1zrkPiDDVmMHCL+oCSmxKsyUSCzM/KTAAblXq?=
 =?us-ascii?Q?F5BuMn+N4zhibdGWfm1l7g21U4AmRjgueu29pbykxEjAS3t4DH7sPtn/Spf9?=
 =?us-ascii?Q?sUbV7qVg/K+UWm3MbQEtEnATotiXGJfm6z8V+9sUZBAUAOyOq92We+umPwb6?=
 =?us-ascii?Q?W/0FV8+qDw1GqEIo9B/tpjAMIA1NiawlSwJMhU44l1MTCy/+evuVxBYaecAM?=
 =?us-ascii?Q?YU4AQ0aPqvxsHEpfwOCra9V2UHc1A08Q9hjhWVcgVRnv/KDdIpGr1TT4GeXR?=
 =?us-ascii?Q?DT+Ef/B8G91OPvYPFTHG/DH2d7Jok6jvX9XCQBFhQli3ijAEWFCd1D99Bqy3?=
 =?us-ascii?Q?RxT9UIwX6a7r08914ESSV+p/WrLg5mmwj/8Yn2W5d8bJktQygkXBvO88WHBS?=
 =?us-ascii?Q?iVvxy85QNJR+EUOhfmDbTsLHLJuWxumXSm5J3a/eq6pSjzahhfFk7hCJu4EN?=
 =?us-ascii?Q?hBHaKyEKdbMWEncGvOrMmbPktmgZtOs=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0958eef-29b3-4161-1636-08de76069320
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2026 13:46:14.5329 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Rc9W5yXD7AyjppZ5e4+yQzDYvPcOJl0wsTqD0z+JfbM8jxf4YM0maMSOJTUlKD+UcRyCtu+sITkVjjYuE6+6HR+dXgfzj6wqXDw9YRBGmDk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR02MB11277
X-Proofpoint-GUID: lIz4MPgslqBKzF-ZtKfxInlFMqU3-QfC
X-Authority-Analysis: v=2.4 cv=Y6X1cxeN c=1 sm=1 tr=0 ts=69a1a028 cx=c_pps
 a=Gg7HfhqIPUY1o8E1DfVvqA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=HzLeVaNsDn8A:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=_-M8LpHI31CeLmyZm6wg:22
 a=64Cc0HZtAAAA:8 a=KFzycwGgjxeSH2uxdHQA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI3MDEyMiBTYWx0ZWRfX61Uf5oCViYTh
 allGoRwMHajiz2SsOHN446aEVLTTNX8j+45EXdgDt08tpS8g+A0U4t9Gl5w9l9CT5XAWKwVKqOA
 JFOPUWSMve3iXtQQqc5BCRCzMuwLm0gTI+T9AZl7fnVwZ3BKbM3ZJR7fSsr3oKY199qikRYvAvX
 U2P2cXsnRpoldU5ruzRzE0/aPBOYGvsU1wyTwp67kqVqp7BMZKny2VopzpMP1oZU1Pf6BDw+X2M
 Jmvs3OboGbEpwHvwXM4smrwC6vIX3WCH7U749q7/W8cscdE7pYscx0pZS9d9uVvaQP17DcE6CZa
 7+UMVx50oZuUxc+3HA+NLguOgGr7S52gmsjGOgLnTd9hR15gZM41gculUMmmyVZ/z85k97yWfpG
 ftzLoPUeoUdtoas7bkmUCYF39G3RThwigrMvVqchY1w+uGUr5nFz/GKLbz13YfkxURX+h19SKo9
 ye/2UTZb6gtT02wqEqg==
X-Proofpoint-ORIG-GUID: lIz4MPgslqBKzF-ZtKfxInlFMqU3-QfC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-27_02,2026-02-27_01,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.706,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.401, SPF_HELO_NONE=0.001,
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

From Windows 8.1 onwards ISA serial IRQs cannot be shared when ACPI Revision
5.0 is used in the FACP table. The reason for this is that if a 2-byte IRQ
Descriptor is used then the interrupt is considered to be high true, edge
sensitive, non-shareable. Since legacy serial ports COM1/3 and COM2/4 share
an IRQ then if more than 2 serial ports are added, Windows indicates a
conflict in Device Manager and these combinations cannot be used together.

Add a new 3-byte IRQ Descriptor to the _CRS resource indicating that the
ISA serial IRQ is low true, edge sensitive and shareable, along with a
corresponding _PRS resource so that the legacy serial ports also appear
at a fixed address. This enables all 4 legacy serial ports to be used in
Windows without conflict.

Tested on Windows 11 with 4 instances of -serial on the command line and copying
data simultaneously across serial ports COM1/3 and COM2/4. Note that with this
series applied, if extra ISA serial ports are added to an existing VM then it is
necessary to go to Device Manager, select "Add legacy hardware" from the
"Action" menu, and then reboot the VM for the serial ports to be detected
correctly without Device Manager indicating a conflict.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>


Mark Cave-Ayland (5):
  hw/acpi/aml-build.c: add aml_irq() representing the 3-byte IRQ
    descriptor
  hw/acpi/aml-build.c: add AML functions for
    StartDependentFn/EndDependentFn
  tests/acpi: allow DSDT acpi table changes
  hw/char/serial-isa.c: declare IRQ as shared in ACPI IRQ descriptor
  tests: data: update x86 ACPI tables

 include/hw/acpi/aml-build.h                   |   4 ++
 hw/acpi/aml-build-stub.c                      |  16 +++++++
 hw/acpi/aml-build.c                           |  40 ++++++++++++++++++
 hw/char/serial-isa.c                          |  23 +++++++++-
 hw/i386/pc.c                                  |   4 +-
 tests/data/acpi/x86/microvm/DSDT              | Bin 365 -> 393 bytes
 tests/data/acpi/x86/microvm/DSDT.ioapic2      | Bin 365 -> 393 bytes
 tests/data/acpi/x86/microvm/DSDT.pcie         | Bin 2985 -> 3013 bytes
 tests/data/acpi/x86/microvm/DSDT.rtc          | Bin 404 -> 432 bytes
 tests/data/acpi/x86/microvm/DSDT.usb          | Bin 414 -> 442 bytes
 tests/data/acpi/x86/pc/DSDT                   | Bin 8598 -> 8626 bytes
 tests/data/acpi/x86/pc/DSDT.acpierst          | Bin 8509 -> 8537 bytes
 tests/data/acpi/x86/pc/DSDT.acpihmat          | Bin 9923 -> 9951 bytes
 tests/data/acpi/x86/pc/DSDT.bridge            | Bin 15469 -> 15497 bytes
 tests/data/acpi/x86/pc/DSDT.cphp              | Bin 9062 -> 9090 bytes
 tests/data/acpi/x86/pc/DSDT.dimmpxm           | Bin 10252 -> 10280 bytes
 tests/data/acpi/x86/pc/DSDT.hpbridge          | Bin 8549 -> 8577 bytes
 tests/data/acpi/x86/pc/DSDT.hpbrroot          | Bin 5087 -> 5115 bytes
 tests/data/acpi/x86/pc/DSDT.ipmikcs           | Bin 8670 -> 8698 bytes
 tests/data/acpi/x86/pc/DSDT.memhp             | Bin 9957 -> 9985 bytes
 tests/data/acpi/x86/pc/DSDT.nohpet            | Bin 8456 -> 8484 bytes
 tests/data/acpi/x86/pc/DSDT.numamem           | Bin 8604 -> 8632 bytes
 tests/data/acpi/x86/pc/DSDT.roothp            | Bin 12391 -> 12419 bytes
 tests/data/acpi/x86/q35/DSDT                  | Bin 8427 -> 8455 bytes
 tests/data/acpi/x86/q35/DSDT.acpierst         | Bin 8444 -> 8472 bytes
 tests/data/acpi/x86/q35/DSDT.acpihmat         | Bin 9752 -> 9780 bytes
 .../data/acpi/x86/q35/DSDT.acpihmat-generic-x | Bin 12637 -> 12665 bytes
 .../acpi/x86/q35/DSDT.acpihmat-noinitiator    | Bin 8706 -> 8734 bytes
 tests/data/acpi/x86/q35/DSDT.applesmc         | Bin 8473 -> 8501 bytes
 tests/data/acpi/x86/q35/DSDT.bridge           | Bin 12040 -> 12068 bytes
 tests/data/acpi/x86/q35/DSDT.core-count       | Bin 12985 -> 13013 bytes
 tests/data/acpi/x86/q35/DSDT.core-count2      | Bin 33842 -> 33870 bytes
 tests/data/acpi/x86/q35/DSDT.cphp             | Bin 8891 -> 8919 bytes
 tests/data/acpi/x86/q35/DSDT.cxl              | Bin 13218 -> 13246 bytes
 tests/data/acpi/x86/q35/DSDT.dimmpxm          | Bin 10081 -> 10109 bytes
 tests/data/acpi/x86/q35/DSDT.ipmibt           | Bin 8502 -> 8530 bytes
 tests/data/acpi/x86/q35/DSDT.ipmismbus        | Bin 8515 -> 8543 bytes
 tests/data/acpi/x86/q35/DSDT.ivrs             | Bin 8444 -> 8472 bytes
 tests/data/acpi/x86/q35/DSDT.memhp            | Bin 9786 -> 9814 bytes
 tests/data/acpi/x86/q35/DSDT.mmio64           | Bin 9557 -> 9585 bytes
 tests/data/acpi/x86/q35/DSDT.multi-bridge     | Bin 13280 -> 13308 bytes
 tests/data/acpi/x86/q35/DSDT.noacpihp         | Bin 8289 -> 8317 bytes
 tests/data/acpi/x86/q35/DSDT.nohpet           | Bin 8285 -> 8313 bytes
 tests/data/acpi/x86/q35/DSDT.numamem          | Bin 8433 -> 8461 bytes
 tests/data/acpi/x86/q35/DSDT.pvpanic-isa      | Bin 8528 -> 8556 bytes
 tests/data/acpi/x86/q35/DSDT.thread-count     | Bin 12985 -> 13013 bytes
 tests/data/acpi/x86/q35/DSDT.thread-count2    | Bin 33842 -> 33870 bytes
 tests/data/acpi/x86/q35/DSDT.tis.tpm12        | Bin 9033 -> 9061 bytes
 tests/data/acpi/x86/q35/DSDT.tis.tpm2         | Bin 9059 -> 9087 bytes
 tests/data/acpi/x86/q35/DSDT.type4-count      | Bin 18661 -> 18689 bytes
 tests/data/acpi/x86/q35/DSDT.viot             | Bin 14684 -> 14712 bytes
 tests/data/acpi/x86/q35/DSDT.xapic            | Bin 35790 -> 35818 bytes
 52 files changed, 85 insertions(+), 2 deletions(-)

-- 
2.43.0


