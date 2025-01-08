Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B668DE7719B
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2025 11:54:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVUdo-0006YU-FA; Wed, 08 Jan 2025 06:54:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1tVUdU-0006TX-7b
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 06:54:08 -0500
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1tVUdR-0002HK-8O
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 06:54:07 -0500
Received: from pps.filterd (m0127840.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5085e2Rj029633;
 Wed, 8 Jan 2025 03:54:03 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=4VGnRreFjVOK/LVxPpNglaquqepYnR6KLteYjF/jl
 bo=; b=yFUuE62KTH+uslzfLlfpxb1n0FisuRyMU8KiClhU6PA0HPefCcPe7XAD9
 zsb+BMdjlVFJIZLjtRpM61epk579+rOAnSmAw9ZImVHgxqrcEzo1wXPZ9QqKwNR4
 9m6ewQAcbD8Q/xQAcA4VHem0XycrVgrqF6pMhJbmXnA3Bo3wvLZ59moFf5VawCCS
 Kdr9/gyOajjBo9h1ZdX8magnR2P0WSsoG8cmcV249DbdiVG9e1zqnlV1jevzDhVJ
 +M6viT8RjOt0o2TAF4R/0/t9xNScBf5mZeLkHrMIY9yk9Qh2dU4cz6VeT8La3Ebx
 7LKdoP0kJbmP88jRX9AVrJ4RzdTeg==
Received: from nam12-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam12lp2170.outbound.protection.outlook.com [104.47.55.170])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 43y26xqhb4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 08 Jan 2025 03:54:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i9VjAeKKW6WowCkoETm510PDGIH3wyPVYb1KE2/+c7jjonHLDys8ksn5BxECK/iM/YDAQM5tXBgCPhMyGiFxp3WWiJTW/ZuCWgHsMDASLRbPaJiPKpRuJoGw0Hap4nOMlLJQr+r3Gsl3m7PHI2SnDQaxcHgckETOli7XsgrbXI8Brp4nfJgwMTYw1StzuMxqGjnh134e5WnBBpPNM73J21ytYwF2Bc5bjiRSxb2NWRXD0luIa2U1j211HicJBAULoQOtQbVwpp9cTmaNdBNYod3Hixs7Eub6FHUvTBPWbC3InuPGEPaMjFM1TG81LU2HPqnpHPUB0VBSrZssDkB/0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4VGnRreFjVOK/LVxPpNglaquqepYnR6KLteYjF/jlbo=;
 b=Uu+Xa4tx7VNxtNKbJAil9FahoENU2eqvy6fmHuzNLL0k5KOBLywW5+0vdCZ3npEqo0brBZeDM2VaRkM5HESXVc+Wh9SfGPG2MKX76Bw/WVKKN2WJzPA+GTiWMSFrO1jfh2/2aaBhu4DTiS14xsQCT2BUaaap6rpUyjk5TOjCoWdz62xpMx0kAivqxmeKuz3KzhILFTujSL/J092MvFXW21kwgkos3WXohalv88wz5OWJHN/CRtKVKW15rUU2Q9bvl41h7qpV4RHYnqdEQdo1DG5kAG/GaWJ85eANEBWFfvbcDZJfd3B34Vxnzx/YfEALoiz1ZQneayn+cu2fxi0pAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4VGnRreFjVOK/LVxPpNglaquqepYnR6KLteYjF/jlbo=;
 b=pGwmy4YTtp6JzVU/TCAaTCVn1NWFShq6iwTpjz2xPLkxBl1Tiy17+KQaqSW8viCHxdr/ikIYHmrNHGih7NS7D1yrKlNr1un3Lc6RKdjM3vlDQWFqg3RVTeKZcu4kGrD/eCaXL8rNQqoozFixY8OVHbAaaqhIbrjkt+djkKGQ09IS8HlwLVjumlBLL+lXkh5YXi22xU5AheTJc4+ob8643thqNotEIDsEnJ7rV/l6J1rCEFHyDrLcnR4X3sx5m62EKTQZgEb16UpbmPc59u+hWFiJnfXED3aJuKMSqjdbt6BQxn1HqE0K/qmGdVZwXfgtmx5yfles9CznSJ7zFc/aRg==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by PH0PR02MB7670.namprd02.prod.outlook.com (2603:10b6:510:50::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.10; Wed, 8 Jan
 2025 11:54:01 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51%4]) with mapi id 15.20.8335.010; Wed, 8 Jan 2025
 11:54:01 +0000
From: John Levon <john.levon@nutanix.com>
To: qemu-devel@nongnu.org
Cc: elena.ufimtseva@oracle.com, alex.williamson@redhat.com, clg@redhat.com,
 jag.raman@oracle.com, thanos.makatos@nutanix.com
Subject: [PATCH 24/26] vfio-user: pci reset
Date: Wed,  8 Jan 2025 11:50:30 +0000
Message-Id: <20250108115032.1677686-25-john.levon@nutanix.com>
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
X-MS-Office365-Filtering-Correlation-Id: 2ede8e6b-9c28-49b9-a72b-08dd2fdb2478
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?VyVDWhmo2yeCxBEIsMCqB0pa4Cc9IPAD7p9z9hnwad5SKTV6s2pNRclGbvzt?=
 =?us-ascii?Q?kfkXVAb7BT2xLpXmjL9+OubZmEg+qMJiUbGGuvbNKE5wYryZJdfcFFhjaPYO?=
 =?us-ascii?Q?MXZgCYc8HSsc/LD7nPpIUgst+fEYilkobAVqIEdBtJ0qvkClF1YfObR+HTgX?=
 =?us-ascii?Q?DqO8eYo22MGI88W7PguUfvZdJ1dfnueTMGPtFlRRJgwgprF0r9lei5yeH9yz?=
 =?us-ascii?Q?WqWnTi4dcjRDbSKmmLxlyhGPugnkZQPpvJioKAH6Ja6cgB511QZ4caTKZuIb?=
 =?us-ascii?Q?05/HYw1lvCtTW+s5F8yKp09EN61BJYkRI+Rf7f7wHfek3lKl139p/cjMi0cm?=
 =?us-ascii?Q?jhxxT394KBmb8QqwmTDff7TcrbMey0WF9qLl5MSfpWbg/FR7//NAsa37Ww5g?=
 =?us-ascii?Q?F5A/bTTWLqQpLkbbhBJIIC1SVrjamjqfRJErlXZ2+GfCYAlWFQOLWeHG3wdg?=
 =?us-ascii?Q?9Cg97bk/k3H4ouZzoP1yC44s0kdkoBhHf+R20FiMG7X0vhQpY2T99on8+ChI?=
 =?us-ascii?Q?6e25CYQ34ay9Ed+EvrxDMMLAFtlgLfDt83QeIpsdctSBX8WXenBoRiQFu0b4?=
 =?us-ascii?Q?n+vVqVenM8j9PsqHMc2V1T3iLFVm57/ZPDvcEpmbAxfiBrvTsEJk/r7Qa7XL?=
 =?us-ascii?Q?RnvsaXI1HscW4Vco4hkvAigI3DxgKMUnUqrFpfkfTShfeQT/apWuFSz8qCh/?=
 =?us-ascii?Q?LOs/6RVqs2lmoYZoh7QuaU7Q9dS6HYiiT/Hj08HR6f1VJB1QFkjgBbp32W2P?=
 =?us-ascii?Q?yAXcWZxrrtl4UswRD9v5nOPjNCkzYI9dLwflPqcCPbyc0arA04eJn64wredJ?=
 =?us-ascii?Q?7i4tUpzliMd6zGsHN8CXIBqxTdQ7soUkEzqp+dSBGZam4p+ROzcSjwjtCCro?=
 =?us-ascii?Q?8IityPwOZkkdOuUjMKXrjg1sq6nwZzAFIA/0jbKdW1+1H3pwifEB+RXreS8x?=
 =?us-ascii?Q?zm76Er7swGw9X9SggMSoml8Lv/xDqGfR6fnuHx2XETcbLv36qsjOcW0TqKSE?=
 =?us-ascii?Q?EJDBsPuD3gjvjmfQRsIOswnZ57adGP+sPbRZ6H5jEUJrrp6ljvj1pfvaDqEL?=
 =?us-ascii?Q?P7i4hbllYtdBMdXjmeVUSoEueKceOzB7O1GA5udoAnJuz7fZNoxngAfHYbyt?=
 =?us-ascii?Q?kRPXBf8be7r1cACqXg5Q/bW/9XoP8sLXF9zrxuJ9udggjfzjNYhJrdgdEUs4?=
 =?us-ascii?Q?SEs99aJEXd1OC6EDved02PVQ3xOLIrR2d7k7OXE0YBrqMsPtZ2BSI8TRMd36?=
 =?us-ascii?Q?O3kXcvbe+OXKvTTHsbXrG0AQ4CsazpyKa2W5cxkqUeQgqRuf/02yzlco9Icg?=
 =?us-ascii?Q?iJNMCe4/VuIuulGosFmKaMPH4tvPtx+EvRxl4A097tsjldA3H4q+FPJcEvm8?=
 =?us-ascii?Q?g4WktwXkiWWqgCacgHehz6Rk9My5?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VVJkGB62BqB8SRg/mww5jmxnxGQ8m8B/mwmuylcNr0B807nJiPS0UewMt33f?=
 =?us-ascii?Q?2/clbuVvzGg8DVaGhKbZyK841oqMtJZhMMdRcKH27R4zZT/SmlaplEGVRJWk?=
 =?us-ascii?Q?reN7O6SCyn6a9KyucTrKdsxUwWEEACjv6xT3asVXs+1XxiDdlWzI0ck97IM0?=
 =?us-ascii?Q?t8Dv5XIEhfcCUVfe+8tSs3YzsnMPbpKM6QvuU6b4OCNGws1Kw81rvV8QmFvY?=
 =?us-ascii?Q?BJi9GBTGUKuf2Kh/I8a4H0werEznUeVVrG2Q18cnHm8F3V6GKXpdg5QySMNO?=
 =?us-ascii?Q?WJBcsChyR0cyTXT8D4msWOPctXK0a5AhfjwdP08Uv0Q830b+UPISXAesCnvh?=
 =?us-ascii?Q?KDolErOt0Pro8VoZcq5Q3B8pHNL+nmHQr6+E1FZgXY1RxP8orFsaxCHiP/w9?=
 =?us-ascii?Q?n/RAN3ZLXzE87ltlartJfWQj7ylz55Jwr73BF1DJ9hTIMFi95NuIJq2MDFBm?=
 =?us-ascii?Q?0BBU7spH+OHVEKfCkDQnmbHBTCm1W0SQu72iV+VdE2FHI3Ia6Ma9NGMWtqxm?=
 =?us-ascii?Q?e/I9hvhPN/d6sTPZFhbhOF2Shr6JK3bIVUcgazGdoksNcrJ07Trh4Po11R4/?=
 =?us-ascii?Q?jCxom5BPlIUC0/tVdg3Ly/ctEd6Qt2Vub/8/Lm8bLZO3IGX+u6qwyNdcGxqH?=
 =?us-ascii?Q?ajWSYyrviGeckTCEYjOjxuKgYYPKqD1k2/5tJgeoc14OTcWcEe6VIEVbDAT6?=
 =?us-ascii?Q?hBvlwAGmZRGcPkQgnqZWMFE++Eh+J4w3Q+nlcbXfree6zv9np2a0hq/T06cw?=
 =?us-ascii?Q?cnRg4ng+tF7N/KnsISWOO5EMf9RTnd0WWOFODtiI51ZpXpfMkaS3M6ccyBMG?=
 =?us-ascii?Q?JSxFj28uOr7z/tzVgaRUTaE2aN2NganDgPagooZxJYJDYI41CMbszMmxc9ej?=
 =?us-ascii?Q?mABefgJhrwSJlAjplrPwziuczQgThESIIOgE59nCnOyyAZfWljKn0ThNWTkX?=
 =?us-ascii?Q?hIHReaDtNBucmO/GjYt9mTJoVdQIHLK+mfb31S2JTlrUwg3XyDYkgfJgq3QO?=
 =?us-ascii?Q?p914fxrcfy+eYpLkoGlMIY1wzzOMaVC3IPoJcyO+jm8g1XN3k0nbWoNHEQa3?=
 =?us-ascii?Q?xiviGcjE/MIxH/Z2mrSp/M8Ey5/QfxvZAVrZCadp99jaZ8Du2Es9dWQ/Cj5E?=
 =?us-ascii?Q?G680vQusDWPpDS/JPg2O3+uofQvjEcovTetp08Ct+129V3LuyetKHbfsu3xp?=
 =?us-ascii?Q?8jYAmxR7ZVZMUyUnDgGLwqqM49/r2FstHYP00G2w4ZtoeOxerjeiHJMpC9oI?=
 =?us-ascii?Q?gNz2VKMpK5bAmdxE2COGfyf/xrtguGXr2SFnPfzvZYJipx2qPNi4IHzHFy9r?=
 =?us-ascii?Q?4Z4YjyKu5fg4xeWPKyB0YDN+fZY/5hcyOKYdGaFp01trjia68cBu2Bp0Fo7C?=
 =?us-ascii?Q?eHOPvgs5g8OO6EFEj4gAyXnK1jCZti7ocGLr8w1nvOsNnHH33RBW1GJZdw/n?=
 =?us-ascii?Q?vD4EZbprWQShZ6sgpJGEGIFC8xvisiyupONIPhQ8RFm2QHX2Mwv13UTBTx3m?=
 =?us-ascii?Q?U0eorH5dRgRDe0aVLnxuLRAYIq8TZk8a3ntKMmeCZkSUWPFCb8NG/ivFJRhz?=
 =?us-ascii?Q?mHlc8iQZPXuEcgUV3mOdCoVhuNKlJBgtyJGlS5F1?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ede8e6b-9c28-49b9-a72b-08dd2fdb2478
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2025 11:54:01.4012 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GbxcrIdk1YsYWdA17xyg1jkjMMEKvLr4u7xar+oowsgQmkWj0YkEk1v2REHgCSeNpmj1uI6+HpwvarCpkapEKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB7670
X-Authority-Analysis: v=2.4 cv=Z/cWHGRA c=1 sm=1 tr=0 ts=677e675b cx=c_pps
 a=2bhcDDF4uZIgm5IDeBgkqw==:117 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=VdSt8ZQiCzkA:10
 a=0034W8JfsZAA:10 a=0kUYKlekyDsA:10
 a=yPCof4ZbAAAA:8 a=64Cc0HZtAAAA:8 a=Vo7S2oCIfNTITXvqP7UA:9
 a=14NRyaPF5x3gF6G45PvQ:22
X-Proofpoint-GUID: eucTFqomGm6sbdzsCgTWcOtkrwmuvKFK
X-Proofpoint-ORIG-GUID: eucTFqomGm6sbdzsCgTWcOtkrwmuvKFK
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

Message to tell the server to reset the device.

Originally-by: John Johnson <john.g.johnson@oracle.com>
Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
Signed-off-by: John Levon <john.levon@nutanix.com>
---
 hw/vfio/user-pci.c | 15 +++++++++++++++
 hw/vfio/user.c     | 12 ++++++++++++
 hw/vfio/user.h     |  1 +
 3 files changed, 28 insertions(+)

diff --git a/hw/vfio/user-pci.c b/hw/vfio/user-pci.c
index 8cd397b75a..84802556e9 100644
--- a/hw/vfio/user-pci.c
+++ b/hw/vfio/user-pci.c
@@ -393,6 +393,20 @@ static void vfio_user_instance_finalize(Object *obj)
     }
 }
 
+static void vfio_user_pci_reset(DeviceState *dev)
+{
+    VFIOPCIDevice *vdev = VFIO_PCI_BASE(dev);
+    VFIODevice *vbasedev = &vdev->vbasedev;
+
+    vfio_pci_pre_reset(vdev);
+
+    if (vbasedev->reset_works) {
+        vfio_user_reset(vbasedev->proxy);
+    }
+
+    vfio_pci_post_reset(vdev);
+}
+
 static const Property vfio_user_pci_dev_properties[] = {
     DEFINE_PROP_STRING("socket", VFIOUserPCIDevice, sock_name),
     DEFINE_PROP_BOOL("no-direct-dma", VFIOUserPCIDevice, no_direct_dma, false),
@@ -405,6 +419,7 @@ static void vfio_user_pci_dev_class_init(ObjectClass *klass, void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
     PCIDeviceClass *pdc = PCI_DEVICE_CLASS(klass);
 
+    device_class_set_legacy_reset(dc, vfio_user_pci_reset);
     device_class_set_props(dc, vfio_user_pci_dev_properties);
     dc->desc = "VFIO over socket PCI device assignment";
     pdc->realize = vfio_user_pci_realize;
diff --git a/hw/vfio/user.c b/hw/vfio/user.c
index 6f0358bd8f..9fba36e196 100644
--- a/hw/vfio/user.c
+++ b/hw/vfio/user.c
@@ -1491,6 +1491,18 @@ static int vfio_user_region_write(VFIOUserProxy *proxy, uint8_t index,
     return ret;
 }
 
+void vfio_user_reset(VFIOUserProxy *proxy)
+{
+    VFIOUserHdr msg;
+
+    vfio_user_request_msg(&msg, VFIO_USER_DEVICE_RESET, sizeof(msg), 0);
+
+    vfio_user_send_wait(proxy, &msg, NULL, 0);
+    if (msg.flags & VFIO_USER_ERROR) {
+        error_printf("reset reply error %d\n", msg.error_reply);
+    }
+}
+
 
 /*
  * Socket-based io_ops
diff --git a/hw/vfio/user.h b/hw/vfio/user.h
index fa6bc9a9d6..d9aa1759df 100644
--- a/hw/vfio/user.h
+++ b/hw/vfio/user.h
@@ -119,5 +119,6 @@ void vfio_user_send_wait(VFIOUserProxy *proxy, VFIOUserHdr *hdr,
 void vfio_user_send_reply(VFIOUserProxy *proxy, VFIOUserHdr *hdr, int size);
 void vfio_user_send_error(VFIOUserProxy *proxy, VFIOUserHdr *hdr, int error);
 void vfio_user_putfds(VFIOUserMsg *msg);
+void vfio_user_reset(VFIOUserProxy *proxy);
 
 #endif /* VFIO_USER_H */
-- 
2.34.1


