Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96EB1E77188
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2025 11:58:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVUdj-0006Vz-9x; Wed, 08 Jan 2025 06:54:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1tVUdR-0006Sk-H2
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 06:54:05 -0500
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1tVUdL-0002GN-KK
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 06:54:04 -0500
Received: from pps.filterd (m0127840.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5085doxd029507;
 Wed, 8 Jan 2025 03:53:58 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=XmcaJ+Jl5ZNUEeGhmZ8/MV6gYbOCVd+eV5KYQgpNF
 js=; b=hXN9HSdnNrTcK21z3asx8lSd1e+UoTB5/o964PxGDF4dFi2lHGVqLG0Na
 aAROxCg1NpaCSQWv8UMsqKjSQOIjSP/PkfN0JAmlkIcxywVgJqHNjIOXySBBjm5Q
 uxcW10BgXlpRl3AWuT3xAnULi/ECG8ZUMmzUb6gEqsxQ3RaRJ0NZa/Ku3Si4SERB
 8+RyWyQ4MORK7U7NWGFRWj5SBpOV4p4FrRNaF4J46liXvcWKbj4eHOW9NcHJCP1J
 6kJYAthQff2afsj6bR8p5ssJiwF1TvnYhomK70LQev+GAVboFquyOQuqE7xP4+lS
 FGsJepDauujc+KFVl4fW/WU66Xs6w==
Received: from nam11-co1-obe.outbound.protection.outlook.com
 (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 43y26xqhax-3
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 08 Jan 2025 03:53:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fiLxpxfnOt7MSxoLEofR/sE8kmh5KQ4FptsIubtNrHqAMm7wj4tFqce0u/imjyq6RjImo8+Mb8Cbj6sa2DZnRedvuoKX9mgFX3yHk9pYhxJNTfOqJJTDcg5SgjPeaBJVuSLByzH2kMB825HaPYgXbtILNjsGi3Rh9JKq0gITQbCpWoSb1FXCUIooIm6dH7+ovie9rioCSFC5fdGxOqc+xiH+WoGRDS1Iw8BvtmUSPuvY4YcwmuPPi4JR6JxjVo+6G2lUIPu347+QZOI1p8SnhzQ7cHnKcAy0dL+uotwe0utKlnGaChbvIli+21xEkQor5PoC//RpKxUMqz9GoKAMtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XmcaJ+Jl5ZNUEeGhmZ8/MV6gYbOCVd+eV5KYQgpNFjs=;
 b=yr77+wyvjcXtjcOW69Np2PM0zMdNSo++1/YcpW/vyS9QDziFR4ygir91jf9aQIbx8rFL/77kbwVQGRL4Al/NkuR7dDX0Br/t+By0SugJh6kDP865WVBWSmdzrpX6eRMKNgawgk8HWeG+LUC8ZBRhL27Br41LtQl+6dd5Wqfs+57lJNPKPNX4nnbUjirJOC7rsBq253nnd46ZmOu0mMYXgJPXjUjffVYuX3IBzsiwwWALX/TDXCVMId3xzwXVRPEdYN4mm50ZScANbKG115a98XBq4hmagFyfboXfchPHr03xfDF8P4RwDdWgkEZxDoqYTcyWvFURAmBI0EdrakRtbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XmcaJ+Jl5ZNUEeGhmZ8/MV6gYbOCVd+eV5KYQgpNFjs=;
 b=S8Ehjb3sGTbuu9eqBWJVlIpKy8vSaZackZ4EH029tEeRlo73JU51MHQDnVKYN9kJkYsr8BOhqJUDroKO9OvmuPFbycgaNmuSOs0BzFwRKUlfVHuyZiz4lI4fj1ZCAIcwzeNiO/RqXb+44T16UyNt10shbThKcBdSKr0cwgknDxCVDDYdFrX1M2pyz7hIebxsEaK6jEvu4+g85/YPG6RyqwinY8zRDiGA4xkPLgY7u1JE65JIFSn1qHpwBop0UTfXAgIX2hE/siqcSKWWjmfmFWrZvnq5o30zbxIHBdsTdNaIwGntWgzsPaEm0IkJy73p6nGHjeLaFf48L9SFBLfVhQ==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by PH0PR02MB7670.namprd02.prod.outlook.com (2603:10b6:510:50::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.10; Wed, 8 Jan
 2025 11:53:49 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51%4]) with mapi id 15.20.8335.010; Wed, 8 Jan 2025
 11:53:49 +0000
From: John Levon <john.levon@nutanix.com>
To: qemu-devel@nongnu.org
Cc: elena.ufimtseva@oracle.com, alex.williamson@redhat.com, clg@redhat.com,
 jag.raman@oracle.com, thanos.makatos@nutanix.com
Subject: [PATCH 15/26] vfio-user: get region info
Date: Wed,  8 Jan 2025 11:50:21 +0000
Message-Id: <20250108115032.1677686-16-john.levon@nutanix.com>
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
X-MS-Office365-Filtering-Correlation-Id: c89450c1-2ec5-4fb0-5e3d-08dd2fdb1d37
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?lsR0BZBL/JR2x/F1TRobj5mIfOuI+qhXKMkugg9exjBbey+v7CS1IjWcKg0x?=
 =?us-ascii?Q?hd00oHMimIx8urraxwxPJXDprgn+8KgBAWu+EKQstSFls8RqH2rQmujTFzj8?=
 =?us-ascii?Q?CLFEVgE1ZpTLWQnBv4N6PExFwVUDfGi/iVpJLKwcXfhuBIgDXF3SiwNYPv9G?=
 =?us-ascii?Q?i1A7YsMV1rNSgNKBMpBOx7PYteDLVZVGm1kiRe8D4ES0gJbXEFH/XzoP8KQ6?=
 =?us-ascii?Q?IOxlGWb1GxQvIc7dqicz9I6BXsx+18v6JlL0rosCrO1L6dY4A2cfSooX8RVh?=
 =?us-ascii?Q?2wrINPn/OwsFGtALYnSsr8mYXhxrV1hzQNpz0P9AmaytdDTlUYP4JG5oXC0k?=
 =?us-ascii?Q?pzro31lVJaSAsdU0+wDmz4eaNUE1C/qt+qZJvivyYGwVdUsD5YtIOPH3wJZT?=
 =?us-ascii?Q?BCWoAjLONZQs/3noMc+NlTKiA+OFIk09kwN+u1nh5fbpi2KSf2wO6/I6CCi/?=
 =?us-ascii?Q?GXvbczR8+kWTkIDwzYUJzZQaT6KZ3qroIOV10Bcda8PzPbTTzvy1DPnumcUR?=
 =?us-ascii?Q?dSPQWDwLFJh+PxZUc5zwxnSjV5zULVTiCHqZsB2w4TwEu7Y4dcnmF4CG28+r?=
 =?us-ascii?Q?wWkn1W+W3LEdDkpHFaQ9TrYhRat9Uh4YROjRPRqortcXdbYStZ4emVRiHMqs?=
 =?us-ascii?Q?7Y7AQCihOjXnNb5Yg4p0mDelZQhQhEId2RoWux+3RM+PtuaAMIK91anDQgYV?=
 =?us-ascii?Q?W34wVCw83qk7jB+kTuXb1Dko2c1/JULR5B8+aOAGYwMySVdArm6RvD6XJdts?=
 =?us-ascii?Q?oL1f3brqcay+hnG1EAX6wMG4Sj/OaXx1AWJx5HaKUFO0XMVuYj3YiBSuv5dJ?=
 =?us-ascii?Q?aJCz9/6czB3TcjRgSaDHhZlV87i2qWpk7VQYa9hgj0+jIj4xNiJGC7Murlly?=
 =?us-ascii?Q?az2mIRZXHc7L3x4RarI8C20U3NCLYC6rCGojyDIrmqe396HCw+w6uNT1GbeI?=
 =?us-ascii?Q?ynFjC3ajOrtxMN+HDU+Opp1xCJO0lAEivFCnYyVHomTjPC2fV78Q7k73z+sk?=
 =?us-ascii?Q?ppdFlxI0dyW8qMBYFlhKobHDMClW2E+kHVUFX/UEHiaQfMCM5UqsIc2efLAC?=
 =?us-ascii?Q?18LCkKg0Qwm6jIIpdDl8AJ+44snPnDDJ304OkH/Ditdkv7PpZJuz8GLk4tf3?=
 =?us-ascii?Q?bOkfCmoy3aPlU+dDYxjkFJXbsrW/vPkTLqDQXav9ZoKqCHwWHUX2hTmsoy2+?=
 =?us-ascii?Q?vmT3K/KdEPh5qxvjumEBb42/M4cx1WLCSkO8Sm0VG188ET+LgEH4sXHuO22N?=
 =?us-ascii?Q?9rp3wV3fmT7WjBroFE1KmhwxmoNxlcrb7DZ4tpfR35oJOi/Nq9gr9x+tNIqU?=
 =?us-ascii?Q?fzr7MVuTA8R/wIbanndRP7O51c6ErV+CC5pK5Xtel9QFXEFVf3hAbF5zy/5p?=
 =?us-ascii?Q?7lI4JdFXNIXJY8UiUWgjRtoQF0bm?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CC+X0lTZwxbLF0IENz+to3bPE7uUpqO6GrBj9oHtTQ7ZqEGS3k43/tBdwhuQ?=
 =?us-ascii?Q?T9yggTQ1xHspEDwbYreWR8oEsgNDwgL50oA8Z53y2+lVy1K5lSX9QAu3cV/m?=
 =?us-ascii?Q?R4qnsqXsMzazgxuksCjQI+qx8iw14OGPQPI+W106Vwq4r+mmxRawRZHQQmiZ?=
 =?us-ascii?Q?pcwRVuqucwlO9iTVMWdmtfOVemI76FWYB/NHOl2NG1FNClw2HzaJwvX6huJe?=
 =?us-ascii?Q?dJrxfJZPYLjvwFt2NSwBlNV66vw+LujzvMfSkQudGjLkOv7WfaOcF8k/d2Gh?=
 =?us-ascii?Q?66e5FbvvB02pr2MlMeXCbydVL1/kCj5PjUH/kHNCMwacydOpVrLTa8md9RFj?=
 =?us-ascii?Q?LjPWws25LvEI6Q/NWvKxuI0y+vVC3FMA5rk/wyyt68GCzIJNqdOK/e6tT5XX?=
 =?us-ascii?Q?aB7kf+68MNU+FMc0puyOLqD00V8t5gDBWaknnA5CpnS88cV0vOlnZ6Yb5P98?=
 =?us-ascii?Q?39lCLGfelrgo4Ux4sk4+zT9wpPWJ3y1MPB0jDuo1P3mqhB4/tt6dB+aZMOgQ?=
 =?us-ascii?Q?LoFw8itCfnu4TRx6NAslGhdzStACcISQLLv2nNLhiEcuT/Rz/vB0nM8Tsft1?=
 =?us-ascii?Q?mBUbVN9G4aCbvScOm6vNgbbzq5BCAarFmyMS6EFKlhgmAjSNIqdfMKxZzCb3?=
 =?us-ascii?Q?EbbTxBBiapJdUjqIPXOUcRHu5UrL1apcl21o9+dwMHb/b/+UJ7itJ1yoztiQ?=
 =?us-ascii?Q?w3CQ5j4OfVMimcVH+UoSBRTM1xQjOgHSQJRr3SNzo+o+HfvckcYY45Z3Cu0K?=
 =?us-ascii?Q?ZGeE8ajaUWgyR7246D6wYOiffIFQPs4gSbr47h+flNpR8HROp+esCPTOh6bf?=
 =?us-ascii?Q?PEriQFOePiHnZukn/4T7OuBaDgwSrT2wbDSNmp3g50eDQ2LAdUou2VOo1RKH?=
 =?us-ascii?Q?cyjoPCDT+YpXuM7/DVi6kh74PAK/LYUKIFBJymqkoVo9NEXFUH5mJzxiw3Pr?=
 =?us-ascii?Q?fbJ6/77loRx9MjA20m9wLZkzv41nUbQqszOYz7fESl+iuaRK2Efnw730nYVR?=
 =?us-ascii?Q?zzMXIQe1v8U5SffVaFmbcLqdtk4tCQyUAfECf+JM6zhWbcQHFV7whreDVg9e?=
 =?us-ascii?Q?Wgjh6ranj/SX6jQlWDYDaDh8xuI+sKmEwGbisGqtGKRDx4pnI4SjQfjLJAHV?=
 =?us-ascii?Q?f375Nghjm9dGPclm338q5/jXMuDusbRWWIbmKzmj9UldMLuzId6sLNxZfo+G?=
 =?us-ascii?Q?h3LolFb6y9WqOxkw02lUQvDvVAWdhJszAFtqHr2sF0VkCKQJYJsVLnsawOa0?=
 =?us-ascii?Q?5O0eXhmhKSCi3TkP/pDAuJW52JAP5kbZjaEdJ1qONvefGG5PWF0aPOoexLJA?=
 =?us-ascii?Q?4wRXvF9lhqcRmIQJhLbB3Fgy/LLlMwrKyouSJiJ87ltgF0VLB628vXBY7mbC?=
 =?us-ascii?Q?iJmZGena5YlA1DlaoLBb30d44n8hAPrh8mwfTUV3VeyZ9ZwRTWAaABSJAVul?=
 =?us-ascii?Q?vfvKhDHrG7MBB8/da9FFlabtJR6t26c+jgl1lWOuVDPS+EPipZZDaOxy9YWO?=
 =?us-ascii?Q?d37LFeppoHwE8qsbJwNnGe0oJYeYeEQb+tycPHtWAX3yKJaByQKotjKuRT/E?=
 =?us-ascii?Q?aqkN5LeQXwoxB8wLHb3RkJbOlnuCnHptIEcApvIe?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c89450c1-2ec5-4fb0-5e3d-08dd2fdb1d37
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2025 11:53:49.2505 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /fRSWCoR5LRTrrqWM1nOuzoeTZ3FUS5YHtNiZ+jwAu/C6vU67qzBNI4pDjeCyS25vph7RQCkL1wfsdDOrInVUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB7670
X-Authority-Analysis: v=2.4 cv=Z/cWHGRA c=1 sm=1 tr=0 ts=677e6755 cx=c_pps
 a=MPHjzrODTC1L994aNYq1fw==:117 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=VdSt8ZQiCzkA:10
 a=0034W8JfsZAA:10 a=0kUYKlekyDsA:10
 a=yPCof4ZbAAAA:8 a=64Cc0HZtAAAA:8 a=t8GBkXr_Z3fVsEiobiEA:9
 a=14NRyaPF5x3gF6G45PvQ:22
X-Proofpoint-GUID: sYlGEDHRKCNfWmztNnu7AzPUHET5gT2O
X-Proofpoint-ORIG-GUID: sYlGEDHRKCNfWmztNnu7AzPUHET5gT2O
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

Add per-region FD to support mmap() of remote device regions

Originally-by: John Johnson <john.g.johnson@oracle.com>
Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
Signed-off-by: John Levon <john.levon@nutanix.com>
---
 hw/vfio/ap.c                  |  2 ++
 hw/vfio/ccw.c                 |  2 ++
 hw/vfio/container.c           |  7 ++++
 hw/vfio/helpers.c             | 28 +++++++++++++--
 hw/vfio/pci.c                 |  2 ++
 hw/vfio/platform.c            |  2 ++
 hw/vfio/trace-events          |  1 +
 hw/vfio/user-pci.c            |  2 ++
 hw/vfio/user-protocol.h       | 14 ++++++++
 hw/vfio/user.c                | 68 +++++++++++++++++++++++++++++++++++
 include/hw/vfio/vfio-common.h |  6 +++-
 11 files changed, 130 insertions(+), 4 deletions(-)

diff --git a/hw/vfio/ap.c b/hw/vfio/ap.c
index 1adce1ab40..54b1815f1d 100644
--- a/hw/vfio/ap.c
+++ b/hw/vfio/ap.c
@@ -162,6 +162,8 @@ static void vfio_ap_realize(DeviceState *dev, Error **errp)
         return;
     }
 
+    vbasedev->use_regfds = false;
+
     if (!vfio_attach_device(vbasedev->name, vbasedev,
                             &address_space_memory, errp)) {
         goto error;
diff --git a/hw/vfio/ccw.c b/hw/vfio/ccw.c
index 8c16648819..085a3fc6e6 100644
--- a/hw/vfio/ccw.c
+++ b/hw/vfio/ccw.c
@@ -586,6 +586,8 @@ static void vfio_ccw_realize(DeviceState *dev, Error **errp)
         goto out_unrealize;
     }
 
+    vbasedev->use_regfds = false;
+
     if (!vfio_attach_device(cdev->mdevid, vbasedev,
                             &address_space_memory, errp)) {
         goto out_attach_dev_err;
diff --git a/hw/vfio/container.c b/hw/vfio/container.c
index 039241c9c5..e017cd4b08 100644
--- a/hw/vfio/container.c
+++ b/hw/vfio/container.c
@@ -892,10 +892,17 @@ void vfio_put_base_device(VFIODevice *vbasedev)
         int i;
 
         for (i = 0; i < vbasedev->num_regions; i++) {
+            if (vbasedev->regfds != NULL && vbasedev->regfds[i] != -1) {
+                close(vbasedev->regfds[i]);
+            }
             g_free(vbasedev->regions[i]);
         }
         g_free(vbasedev->regions);
         vbasedev->regions = NULL;
+        if (vbasedev->regfds != NULL) {
+            g_free(vbasedev->regfds);
+            vbasedev->regfds = NULL;
+        }
     }
 
     if (!vbasedev->group) {
diff --git a/hw/vfio/helpers.c b/hw/vfio/helpers.c
index 529520c1d6..802d6ae101 100644
--- a/hw/vfio/helpers.c
+++ b/hw/vfio/helpers.c
@@ -364,6 +364,12 @@ int vfio_region_setup(Object *obj, VFIODevice *vbasedev, VFIORegion *region,
     region->size = info->size;
     region->fd_offset = info->offset;
     region->nr = index;
+    if (vbasedev->regfds != NULL) {
+        region->fd = vbasedev->regfds[index];
+    } else {
+        region->fd = vbasedev->fd;
+    }
+
 
     if (region->size) {
         region->mem = g_new0(MemoryRegion, 1);
@@ -442,7 +448,7 @@ int vfio_region_mmap(VFIORegion *region)
 
         region->mmaps[i].mmap = mmap(map_align, region->mmaps[i].size, prot,
                                      MAP_SHARED | MAP_FIXED,
-                                     region->vbasedev->fd,
+                                     region->fd,
                                      region->fd_offset +
                                      region->mmaps[i].offset);
         if (region->mmaps[i].mmap == MAP_FAILED) {
@@ -567,12 +573,16 @@ int vfio_get_region_info(VFIODevice *vbasedev, int index,
                          struct vfio_region_info **info)
 {
     size_t argsz = sizeof(struct vfio_region_info);
+    int fd = -1;
     int ret;
 
     /* create region cache */
     if (vbasedev->regions == NULL) {
         vbasedev->regions = g_new0(struct vfio_region_info *,
                                    vbasedev->num_regions);
+        if (vbasedev->use_regfds) {
+            vbasedev->regfds = g_new0(int, vbasedev->num_regions);
+        }
     }
     /* check cache */
     if (vbasedev->regions[index] != NULL) {
@@ -586,22 +596,33 @@ int vfio_get_region_info(VFIODevice *vbasedev, int index,
 retry:
     (*info)->argsz = argsz;
 
-    ret = vbasedev->io->get_region_info(vbasedev, *info);
+    ret = vbasedev->io->get_region_info(vbasedev, *info, &fd);
     if (ret != 0) {
         g_free(*info);
         *info = NULL;
+        if (vbasedev->regfds != NULL) {
+            vbasedev->regfds[index] = -1;
+        }
+
         return -errno;
     }
 
     if ((*info)->argsz > argsz) {
         argsz = (*info)->argsz;
         *info = g_realloc(*info, argsz);
+        if (fd != -1) {
+            close(fd);
+            fd = -1;
+        }
 
         goto retry;
     }
 
     /* fill cache */
     vbasedev->regions[index] = *info;
+    if (vbasedev->regfds != NULL) {
+        vbasedev->regfds[index] = fd;
+    }
 
     return 0;
 }
@@ -765,10 +786,11 @@ static int vfio_io_device_feature(VFIODevice *vbasedev,
 }
 
 static int vfio_io_get_region_info(VFIODevice *vbasedev,
-                                   struct vfio_region_info *info)
+                                   struct vfio_region_info *info, int *fd)
 {
     int ret;
 
+    *fd = -1;
     ret = ioctl(vbasedev->fd, VFIO_DEVICE_GET_REGION_INFO, info);
 
     return ret < 0 ? -errno : ret;
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 27f82d6517..b57059d676 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -3048,6 +3048,8 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
         name = g_strdup(vbasedev->name);
     }
 
+    vbasedev->use_regfds = false;
+
     if (!vfio_attach_device(name, vbasedev,
                             pci_device_iommu_address_space(pdev), errp)) {
         goto error;
diff --git a/hw/vfio/platform.c b/hw/vfio/platform.c
index 1194e55807..6e19573b3b 100644
--- a/hw/vfio/platform.c
+++ b/hw/vfio/platform.c
@@ -575,6 +575,8 @@ static void vfio_platform_realize(DeviceState *dev, Error **errp)
     VFIODevice *vbasedev = &vdev->vbasedev;
     int i;
 
+    vbasedev->use_regfds = false;
+
     qemu_mutex_init(&vdev->intp_mutex);
 
     trace_vfio_platform_realize(vbasedev->sysfsdev ?
diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
index 662bc4edfd..ee6d7a0d0a 100644
--- a/hw/vfio/trace-events
+++ b/hw/vfio/trace-events
@@ -188,3 +188,4 @@ vfio_user_recv_request(uint16_t cmd) " command 0x%x"
 vfio_user_send_write(uint16_t id, int wrote) " id 0x%x wrote 0x%x"
 vfio_user_version(uint16_t major, uint16_t minor, const char *caps) " major %d minor %d caps: %s"
 vfio_user_get_info(uint32_t nregions, uint32_t nirqs) " #regions %d #irqs %d"
+vfio_user_get_region_info(uint32_t index, uint32_t flags, uint64_t size) " index %d flags 0x%x size 0x%"PRIx64
diff --git a/hw/vfio/user-pci.c b/hw/vfio/user-pci.c
index 62259db473..60cd9c941c 100644
--- a/hw/vfio/user-pci.c
+++ b/hw/vfio/user-pci.c
@@ -111,6 +111,8 @@ static void vfio_user_pci_realize(PCIDevice *pdev, Error **errp)
     vbasedev->ops = &vfio_user_pci_ops;
     vbasedev->type = VFIO_DEVICE_TYPE_PCI;
     vbasedev->dev = DEVICE(vdev);
+    vbasedev->io = &vfio_dev_io_sock;
+    vbasedev->use_regfds = true;
 
     /*
      * vfio-user devices are effectively mdevs (don't use a host iommu).
diff --git a/hw/vfio/user-protocol.h b/hw/vfio/user-protocol.h
index 5f9ef1768f..6f70a48905 100644
--- a/hw/vfio/user-protocol.h
+++ b/hw/vfio/user-protocol.h
@@ -125,4 +125,18 @@ typedef struct {
     uint32_t num_irqs;
 } VFIOUserDeviceInfo;
 
+/*
+ * VFIO_USER_DEVICE_GET_REGION_INFO
+ * imported from struct vfio_region_info
+ */
+typedef struct {
+    VFIOUserHdr hdr;
+    uint32_t argsz;
+    uint32_t flags;
+    uint32_t index;
+    uint32_t cap_offset;
+    uint64_t size;
+    uint64_t offset;
+} VFIOUserRegionInfo;
+
 #endif /* VFIO_USER_PROTOCOL_H */
diff --git a/hw/vfio/user.c b/hw/vfio/user.c
index 93c7eea649..44e8da8aa1 100644
--- a/hw/vfio/user.c
+++ b/hw/vfio/user.c
@@ -1106,3 +1106,71 @@ int vfio_user_get_info(VFIOUserProxy *proxy, struct vfio_device_info *info)
 
     return 0;
 }
+
+static int vfio_user_get_region_info(VFIOUserProxy *proxy,
+                                     struct vfio_region_info *info,
+                                     VFIOUserFDs *fds)
+{
+    g_autofree VFIOUserRegionInfo *msgp = NULL;
+    uint32_t size;
+
+    /* data returned can be larger than vfio_region_info */
+    if (info->argsz < sizeof(*info)) {
+        error_printf("vfio_user_get_region_info argsz too small\n");
+        return -E2BIG;
+    }
+    if (fds != NULL && fds->send_fds != 0) {
+        error_printf("vfio_user_get_region_info can't send FDs\n");
+        return -EINVAL;
+    }
+
+    size = info->argsz + sizeof(VFIOUserHdr);
+    msgp = g_malloc0(size);
+
+    vfio_user_request_msg(&msgp->hdr, VFIO_USER_DEVICE_GET_REGION_INFO,
+                          sizeof(*msgp), 0);
+    msgp->argsz = info->argsz;
+    msgp->index = info->index;
+
+    vfio_user_send_wait(proxy, &msgp->hdr, fds, size);
+    if (msgp->hdr.flags & VFIO_USER_ERROR) {
+        return -msgp->hdr.error_reply;
+    }
+    trace_vfio_user_get_region_info(msgp->index, msgp->flags, msgp->size);
+
+    memcpy(info, &msgp->argsz, info->argsz);
+    return 0;
+}
+
+
+/*
+ * Socket-based io_ops
+ */
+
+static int vfio_user_io_get_region_info(VFIODevice *vbasedev,
+                                        struct vfio_region_info *info,
+                                        int *fd)
+{
+    int ret;
+    VFIOUserFDs fds = { 0, 1, fd};
+
+    ret = vfio_user_get_region_info(vbasedev->proxy, info, &fds);
+    if (ret) {
+        return ret;
+    }
+
+    if (info->index > vbasedev->num_regions) {
+        return -EINVAL;
+    }
+    /* cap_offset in valid area */
+    if ((info->flags & VFIO_REGION_INFO_FLAG_CAPS) &&
+        (info->cap_offset < sizeof(*info) || info->cap_offset > info->argsz)) {
+        return -EINVAL;
+    }
+
+    return 0;
+}
+
+VFIODeviceIO vfio_dev_io_sock = {
+    .get_region_info = vfio_user_io_get_region_info,
+};
diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index afc67a3a77..50b136b7dc 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -59,6 +59,7 @@ typedef struct VFIORegion {
     uint32_t nr_mmaps;
     VFIOMmap *mmaps;
     uint8_t nr; /* cache the region number for debug */
+    int fd; /* fd to mmap() region */
 } VFIORegion;
 
 typedef struct VFIOMigration {
@@ -146,6 +147,7 @@ typedef struct VFIODevice {
     bool ram_block_discard_allowed;
     OnOffAuto enable_migration;
     bool migration_events;
+    bool use_regfds;
     VFIODeviceOps *ops;
     VFIODeviceIO *io;
     unsigned int num_irqs;
@@ -165,6 +167,7 @@ typedef struct VFIODevice {
     QLIST_ENTRY(VFIODevice) hwpt_next;
     VFIOUserProxy *proxy;
     struct vfio_region_info **regions;
+    int *regfds;
 } VFIODevice;
 
 struct VFIODeviceOps {
@@ -209,7 +212,7 @@ struct VFIODeviceOps {
 struct VFIODeviceIO {
     int (*device_feature)(VFIODevice *vdev, struct vfio_device_feature *);
     int (*get_region_info)(VFIODevice *vdev,
-                           struct vfio_region_info *info);
+                           struct vfio_region_info *info, int *fd);
     int (*get_irq_info)(VFIODevice *vdev, struct vfio_irq_info *irq);
     int (*set_irqs)(VFIODevice *vdev, struct vfio_irq_set *irqs);
     int (*region_read)(VFIODevice *vdev, uint8_t nr, off_t off, uint32_t size,
@@ -219,6 +222,7 @@ struct VFIODeviceIO {
 };
 
 extern VFIODeviceIO vfio_dev_io_ioctl;
+extern VFIODeviceIO vfio_dev_io_sock;
 
 #endif /* CONFIG_LINUX */
 
-- 
2.34.1


