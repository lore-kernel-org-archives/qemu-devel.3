Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD980CAC5AC
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Sep 2025 13:56:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v13VJ-0000kB-Me; Tue, 23 Sep 2025 09:56:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1v13Uw-0000Dw-VL; Tue, 23 Sep 2025 09:56:06 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1v13Uu-0004Io-KB; Tue, 23 Sep 2025 09:56:02 -0400
Received: from pps.filterd (m0127839.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 58N6QHLi4104495; Tue, 23 Sep 2025 06:55:23 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=hFdJxjpOUOrjZbfPETMvFHPeGq5QqvVEp0vzKce5s
 s0=; b=lY6y2a+xl1auGQg1vmoQSZTvLK33eGN2LAuDYeNlMZRXGIZERqd6su8KT
 D8hw+iFkutGsYm00EyZJoa6rR14ADbcFutqvzBZL8TS6WTaIko+XH/7SWqEVOvIB
 lZ2/m0OjVc2uQ+eAxppcabrmEElKPyBGNXKm5UIz8B4tSI9QP0p3Xrj5Do5qg4wO
 ogzCNuKsml60f6UVhy921pZEwGTV3eP3mjsy6f2+78q0uKx1lUFwZg7Nca+2S00I
 Pv0s7xok2wj6TYKuzqcunjeCjnQxavpO5zPjneKkyIraxgrHUpP41V0V12valZ2C
 YPb6XwrRBqNFZusEtCj7Yom6uO3Gw==
Received: from ph7pr06cu001.outbound.protection.outlook.com
 (mail-westus3azon11020091.outbound.protection.outlook.com [52.101.201.91])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 49bb1fa8b1-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 23 Sep 2025 06:55:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kkHp+ZThj8yfCrj7RRzRimwHEUe6AlawwxR4iSOldWD4YKH5jTwt0GePyu4jxMTpDdxtvQEdORrlFDc/1AvGgYAHuo7Dmi9q8mEhPQ3r0eYw8qncWmmidT68ghQnVez72kPV/0CxpSrqFGoaZ9LR10TiAEZBiP2hSk9eZ9pnN60usxfH0x+S5GTB0KsLKGc201peRI19GHCVc+eO2xK+vDMMS8cu5vs8sNyOybmi4igUevGeInB6hG2zi3XdYtmXn8JNrmCxeMxeptIFdxT7xIds9CrDsYd6PHxwGQV2Po5c/AcjIq+WWObbpeIFV9GSMqUGs7LqcAFaARb+GPzFYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hFdJxjpOUOrjZbfPETMvFHPeGq5QqvVEp0vzKce5ss0=;
 b=L9oiK0at1PSHC2WKc4E6iK938l/+wcOSniRfzp2Xml0/+IMLBF/pQnasuS2B7Gj/2ZxZl9YcyAD2LvQWGAuSri/S5S57GDpAdzkxyltTArLCucTuZ3CxiN3yMhbm1qc6sNZZb6tMuZ9/16kT4BxeEv0PrnB9ltGFdCtvM37jUu004xw8COw55u7IEgBhalEtspmTLWKgCXQpMEHQsYLDz2P6UcbQ5J8JFIAuvBy9wl7pNJC/dmjMJzmtjeJ4jvaP/HbfF/AaH95kY8GZFIlv6nIbv0iUrevEEBMwuOTW1IzznlbdVwaYTMQSqcSNMwmEcw6uGf2c215jbmUMYeMy7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hFdJxjpOUOrjZbfPETMvFHPeGq5QqvVEp0vzKce5ss0=;
 b=il/kLeyuGCaIgnDTpRIevNKDynI/qjaP3saZD8t/D1uPBHbC92zJuav7cP44KaYG40q3KKkR/fVjka80mEftd4V0qivoVkZYOyoWOsrBIfgqEpubR1zOjj7R7AuXgwUQl2miPIJFUQqm7hA0hMy1p/B4pW6iB43g/weDzah6IDzrowmks+2fSMsRcL/+p0+DP7BrqzzkvwbyuBxKvZ0hvYlap5NygDPbZDa+xX0WNvq8PVfo2m/qaQoNYWC9zMz5Nr88lWYUZrjH79i2yRIBPGZTPUO94xSzU8SHMhZnm3O1AmX1CKoTcpeyCwMh499kHqsZmLAy5+NUgZTzpY7HIA==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by SJ0PR02MB7742.namprd02.prod.outlook.com (2603:10b6:a03:320::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.20; Tue, 23 Sep
 2025 13:55:22 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88%3]) with mapi id 15.20.9160.008; Tue, 23 Sep 2025
 13:55:22 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: npiggin@gmail.com, harshpb@linux.ibm.com, mjrosato@linux.ibm.com,
 farman@linux.ibm.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 thuth@redhat.com, richard.henderson@linaro.org, david@redhat.com,
 iii@linux.ibm.com, john.levon@nutanix.com, thanos.makatos@nutanix.com,
 clg@redhat.com, alex.williamson@redhat.com, steven.sistare@oracle.com,
 qemu-ppc@nongnu.org, qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Subject: [PATCH 23/27] vfio-user/pci.c: rename vfio_user_pci_dev_class_init()
 to vfio_user_pci_class_init()
Date: Tue, 23 Sep 2025 14:53:29 +0100
Message-ID: <20250923135352.1157250-24-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250923135352.1157250-1-mark.caveayland@nutanix.com>
References: <20250923135352.1157250-1-mark.caveayland@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P192CA0027.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:5e1::17) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|SJ0PR02MB7742:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b103c14-dd15-443c-7a9b-08ddfaa8d68e
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|10070799003|366016|1800799024|921020; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?cvOAobYV5dSP+c7ZFlvEHZJ4kq5PqWVLQwdIKllhGnM7C2E6pIQSWFDRJ82i?=
 =?us-ascii?Q?jc3phshE0hoSHtvpAt01ha0tOLzfgPiTIq+tYFy3khY8Q0nc07E8TYJBGaYF?=
 =?us-ascii?Q?dLnvKCpt6JLvZ4eCtZGTQIKltmc6ZwggDy45D3Wj3i19/3NzzNLy+biVt9Ml?=
 =?us-ascii?Q?yGbF1uwXmV+FgB0jKH0aTISV2IApMgAzmVhCrATU3ewMlv6HL+CPK+OHFjMf?=
 =?us-ascii?Q?feBUGXVGpuZr/d0PnRaVlQi9nLfAobRueNQbc31OydkBShY0GTzP2Tpz8KX1?=
 =?us-ascii?Q?Z/eRd0Mwk59W3OzIH5E4V+iTPHsY7MuYj2o6KN3Ida91ARTzn1MVXmIkDqgw?=
 =?us-ascii?Q?7imfEqNRe+71vWOxqbWMfD+2YeO7NrVEE+ozBBo/xBh0AK+CeLKkKolVQuXs?=
 =?us-ascii?Q?/YEQiYoUjiHV68lBs5LkzTFI9gyp9SjtlEVQ0Ds+jSpubp8CmYb6s7hTf30R?=
 =?us-ascii?Q?sJc1V9gSMK0jL2Om6zKDNWJclNrPvwxGOeS9srPjvFko4YUJFnEkJmgkLS2s?=
 =?us-ascii?Q?b1EVkbUnnEFh2nfEPswfM7k6tMVToyXfbmJ+FBTh0pyd3epJklsSa4xrsZ7U?=
 =?us-ascii?Q?bCeTs/Y73ysggVwBWmxml75njXUxmpBfReoQKBn1vddiBXDHy7vjyDa2vg9m?=
 =?us-ascii?Q?OSISIcPfBxcpEQM9QjX5Jm/rud9chEVo5u9a17EbaTHFAJhspfHo8GVIIZQl?=
 =?us-ascii?Q?viwCrySqOt4wdE5Pl6V5WTI/d5LO4vhTR0PT0hanPw40UJCNRVGpV4GBuynW?=
 =?us-ascii?Q?hJB1c1Iw5deV8PIlhU/kVOEjEl6WGAIerLd54lHKz7AZPOw8Mq/VcOMwoAmw?=
 =?us-ascii?Q?bOQRAbyfXc/ogW4JZKdPO2b9fKpbUu38D+ITmH6PQwP81OP4oF4dpkWTqshe?=
 =?us-ascii?Q?tQCgmSAlLEfBW5pVY2tuarwtLv84h3xFVvmeK7XODX9h4V1VVrppV2NIdhgM?=
 =?us-ascii?Q?ie8yTxDbrOnAuXfWURUR0NxmBlci7u2hhMlRj4rPtmqY4xENnNRYWIBvd1kX?=
 =?us-ascii?Q?GTg0dVhiapNs4AhuShnrX+ekE15061f6fPMrGFoWBMu7YEwt/JjCngYK6ERE?=
 =?us-ascii?Q?YcT22/LX/83t9TrO/g8w5ThnK5GCqjKArNnAgAS+86cdUgJjPcRaXnMwORd2?=
 =?us-ascii?Q?y2OKcfpJhiHIDJLgKEEOSQKGgCIDqAncipkgaHA3PO+u9HHknMOMCIXfQzsH?=
 =?us-ascii?Q?KWqCQzisl3f3cfsq/4x+PDE8Y4TNCbJxHXdeP3xFGDH7k/8hSzSjXKXd+tlJ?=
 =?us-ascii?Q?D473cYDx3CnW9fxnfWzooRtg061frGIbHS6Bsz5hdWBsaspz0Jo9HwBKkl6i?=
 =?us-ascii?Q?oI3M2gSkEu2U/X+xCjBOerGovLII6KF0V5aPEkYcVqx3nOC9vpJMPXMtjLL+?=
 =?us-ascii?Q?PBL0RiLrNLOkBf9aFdIpVuppQVQWt+HKgJsDAjC/B+YijfQ38FYSFm7Ibb/B?=
 =?us-ascii?Q?WWPdi2hm7PGHRQv383Z9Q1uswkc4BFaF?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(10070799003)(366016)(1800799024)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UGFm5Z/+XD0n8iVM4bnyS01OcLP+EAM1tnsmNp+OYGfSa5NT/VWzO8ga7FMA?=
 =?us-ascii?Q?BfNDd6Xu0BCLkXT//gzuC8ZY93Ia0sPJne564GqpYW6tNxsqVukQSqm1E4rL?=
 =?us-ascii?Q?l6YxdmA3NszR5coJ1m0mp+vHDZ6QoerBXAPLT4zRu/F9bVGsPrQtQPp87Jdl?=
 =?us-ascii?Q?6ZdYpi5ktxviRU8QyaCW/GjqjotCSb4g7smnYDrdjCPFDV3Jf09e+cmoUgAT?=
 =?us-ascii?Q?XzUZs+wk7DFE4iZ5l5q/GNtJN/FU3uqzVTl73bZGkee7XkXctc9sB1LgSNmc?=
 =?us-ascii?Q?OkD6yanvCmEFGy7azqUO8Z3Zob/wwTCzKsxa3JuhrD7all2HpXIwL+7bDXCG?=
 =?us-ascii?Q?mLIe0vy9davN3+FGSa5lQ5lhfAbzv1rnRVNv25CEQ+limadVOpxkzw6jl19g?=
 =?us-ascii?Q?PBlIirSL4ysilY0aWyhHZbMb/Y54WE24E+DCaF69gUNq1hfyJMc4pJYQHD3v?=
 =?us-ascii?Q?N8t2Q2AY9fSNQyaoGGNoFetHyY7zplSWuW/ACEEnKA257biIp7o209iQVIbe?=
 =?us-ascii?Q?5rz7/TX5GRS+A0G3L11Cq3Eb+A6ccoLvlwAzowu7aiDdtjyfU4CscM92UvCN?=
 =?us-ascii?Q?jgLsjdfXVPX12PGFwEpfOomhdBgWlKfwLzefCgKR79YbyVG7J1PYJqq6QjsT?=
 =?us-ascii?Q?bvLuSLSaRzcvopkN/hdNWKOUe2jPjM5vTMMyss42v/JI0fmWe5Cq8qOReSOl?=
 =?us-ascii?Q?V9V5EhCeQXFMAbqk+ztEq+kmYrfd5Iv68UEiYGMWNGkc3Fu4wSYol99L9goB?=
 =?us-ascii?Q?J9AZM06ioPn9r/hQLHuxC6sygwBz/n+3c2Ga3dP/n1p/xuFzeYrd3A3KJr3S?=
 =?us-ascii?Q?gS0Gkqcuck4IZWMxDijZllMSjSiZjXAqKPHYwtUYjQhhxYlf04I6v8ybRBFM?=
 =?us-ascii?Q?KOoTkfFcuWjpdKmC3t1YcS81mVEx18S7HlYw5ZcOgx4Ly0yrOiAoA+c6r0zL?=
 =?us-ascii?Q?whpYVMC3LZjdUrhXyvk85u7n2EJNvFq6SjN/H5zW9CoR0m/9ja+7WjO4zBWb?=
 =?us-ascii?Q?V4zqS4rTAvO1CtHGf3tTTSiO5u9DPyjE0fmLjFFbgT785Blro6LJC0bKFfH1?=
 =?us-ascii?Q?DVlsm0+XqQ0mK+dxM0hEqsCA0P85UtLjo51FTBjWkZPPzfJjtO1gVLpNW2QF?=
 =?us-ascii?Q?I78q9pB367he+dV8sBGJ2ZyESUOoBRSNanYRwCfwDUomDGuXOndbL4CEfSxN?=
 =?us-ascii?Q?bCFZT24tiE2/GTaEMSPx4TNQBIZ7VUH02e/dYGKCd100H7yd18h7o22PjQDx?=
 =?us-ascii?Q?LezwbPq0ZF33TnoUNNrixK/5nSmD/ZF9EHyYdjS0j3LuQuGi+EhQ3TWIRWve?=
 =?us-ascii?Q?5UF0IMbz3/IFcFRP0wNTgkyjpmUF+ZUy6Rghz8XFu3jGUE10Q9SW3IQrh2By?=
 =?us-ascii?Q?OkBQmvRa9t/4qmdjOtlvuPSwcTzB9PR6Y3kf3MLPOsj9uMnzdYLjJTX7Rr/A?=
 =?us-ascii?Q?/Hkp5G7Vmm7PHMNjCukAiT6/vZqubsOheP9Kk0D33e0H+tlDhSKIhZof2sJB?=
 =?us-ascii?Q?8QyUnZQMAoLnlRA43onGNS3WGjEKapSY7xRg6nbyCzG2aEpoiUy9sknyv8Cp?=
 =?us-ascii?Q?cTdQgKHEofBWNLGG+bqij7BTJYk/xBH22u2oYHJwubWVNlEniz9KMIAlaNBD?=
 =?us-ascii?Q?hlUSYY3tAqauWgxzkXvJGiF49uPIGkqTn71zYeO/m1pIau/ATUNdXer+eKcp?=
 =?us-ascii?Q?2VKfBA=3D=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b103c14-dd15-443c-7a9b-08ddfaa8d68e
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2025 13:55:21.9240 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EyIx7AGw1BA2VQrNxqzkdxUFdaBHG6vtu9cJ3CwEEIs8o4DzRQ5ly6p0IxpnK0bj2pSt+FCB4dZ0ILkMvP16cWyBe05IXIMmmJ/MlDz4WLg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB7742
X-Authority-Analysis: v=2.4 cv=C5PpyRP+ c=1 sm=1 tr=0 ts=68d2a6cb cx=c_pps
 a=XRAB2LWAunOdTDivPrw6VQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=yJojWOMRYYMA:10 a=0kUYKlekyDsA:10 a=64Cc0HZtAAAA:8
 a=udP_5BOVWkZL6ct6w7QA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIzMDEyOCBTYWx0ZWRfX7T8AWmHWqxGj
 OhSUhM196mdlSZr1J3HrG+9aYGolaLVZMa+0n6j6lapE+RgmMHSniOqcho6v6yHPRLbX4hOE25m
 hvyfshHAVaX0z1lzxdtO9n7jKkQzqQd7fvnW1taCN3DClTMI0csSylsKxVU7VPvTfBjIHunKmWt
 0MU+A3FRrhhGkk7hZMuk7e4nYqCuNJnDEq5p8R5Yb82mcz2nwqhFOpSDwxefUfIdJs9iVyS6DAM
 iDGfYQSQjE4oEkMjW9JkpZAgNwyvkflV3bX5psgDbBG+lsuUky+R/GFhU4dmrKgVDglZ0E/JumT
 FXH9ojlMmNa5bqYccMdq2nQm9UyVqBw4cJz4qCHWi2OMK90eG0H/4Xyl2E6ywM=
X-Proofpoint-GUID: ackHuc1-dLHEVeMXoZV8_HusZNkKRJzg
X-Proofpoint-ORIG-GUID: ackHuc1-dLHEVeMXoZV8_HusZNkKRJzg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-23_03,2025-09-22_05,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This changes the function prefix to match the name of the QOM type.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
---
 hw/vfio-user/pci.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/vfio-user/pci.c b/hw/vfio-user/pci.c
index efceae69de..e2c5b5744c 100644
--- a/hw/vfio-user/pci.c
+++ b/hw/vfio-user/pci.c
@@ -446,7 +446,7 @@ static void vfio_user_pci_set_socket(Object *obj, Visitor *v, const char *name,
     }
 }
 
-static void vfio_user_pci_dev_class_init(ObjectClass *klass, const void *data)
+static void vfio_user_pci_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     PCIDeviceClass *pdc = PCI_DEVICE_CLASS(klass);
@@ -467,7 +467,7 @@ static const TypeInfo vfio_user_pci_dev_info = {
     .name = TYPE_VFIO_USER_PCI,
     .parent = TYPE_VFIO_PCI_DEVICE,
     .instance_size = sizeof(VFIOUserPCIDevice),
-    .class_init = vfio_user_pci_dev_class_init,
+    .class_init = vfio_user_pci_class_init,
     .instance_init = vfio_user_instance_init,
     .instance_finalize = vfio_user_instance_finalize,
 };
-- 
2.43.0


