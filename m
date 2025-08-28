Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D798CA0EED
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Aug 2025 11:13:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uraXU-0008BW-8V; Thu, 28 Aug 2025 07:11:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1uraXS-00089H-DR
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 07:11:30 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1uraXQ-00057q-Mx
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 07:11:30 -0400
Received: from pps.filterd (m0127839.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 57S9m7CY3413914; Thu, 28 Aug 2025 04:11:25 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=PbFRNEaVoa7+oOm/Uk5dJlrTDqgoD/i9eSmj2G0Pm
 fs=; b=ihInhw1nbVd04Iri49sjpHidi3zxVkVw+Xn2B8b5fD3dd40mmWHHC67Eu
 0zssFL8jMREOgRNDXVI18Q3rOoy8ZHUJmlYwoAmaPM2LW+0Vuw3DeA6LSNvIEzPx
 RhDCXXiZuKEtiLOfPAUI60J74nnQWLt3yM3GiMzaeLTog0z54QhApI3ENMsnfMsz
 FgBO467QA9ImsuyYPCmzmRjMupeJeeXvt6hoAhL6/gwrnklzGTrrSjU3fZtHeCNy
 Sh8Dyz4XYqaXjFLTQzv1d32AXmlzDvNNH30Fj/l4AjNa5OEupkjboq9YvQlH9f1D
 JIeXtTY+3KHWhrl/OWRmVgHhEU6Aw==
Received: from sj2pr03cu001.outbound.protection.outlook.com
 (mail-westusazon11022136.outbound.protection.outlook.com [52.101.43.136])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 48tbd9s9aj-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 28 Aug 2025 04:11:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lFx/kWpMQtOI6DEkqRBDBhLpFfYjU0KEN2Sc0BhwcptM4RShmv4Mvo4OqTbPnaKYSL80tGvvHgGQxOx/mCKM/3h2ud64YdB6PipPFDiQRE2lUCtIdIo8g2r7/Jvf65fAyykvrTfAepJSEI/aM4kNVNOl9YkQ0hmmg3gw5f2FSXczf0a0fUn/53tiUjRK4sTysRJTTE/nxSpWcD1NrgF0fHr3xZwji9aRi3scVyqtTRnJpFaKe/3J26hi9zAOajQQYkVoeQ0L2aWA2fxLX8RZyRtlnF0KA9gDb4O2Qmv6OMCuLbjm+R3PCMj9mrbVOOwqMID/S4HoMPKpyH044qlUAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PbFRNEaVoa7+oOm/Uk5dJlrTDqgoD/i9eSmj2G0Pmfs=;
 b=iXhR5mLfuD8RKpQ4HsH5eYy/5dr+lqa+sK0i/IsjdUMKqprYKrBCNqeF09X5zXYJn4Qqm3Kiof0TLYy2vc5EjSk2rcgW9wfdcyRnEecUa9Bmcd0Xz7vRnUKryg+IiDcayDFYOr9hVmdASUhfwAUYNjgnq0oGF+7GZYIA05pofLtJhcccSX4gUQYC3NR6k6MOzRoKCf0k+5kPx+0afBkRnhyaHBH8e/q8dSjlczexxsYzF2aw+/7kGAi7T1n6iSQfxqgRbBOrmFdsO+R3dl5NXPaj32tGoXeOmYdsVFbCiWLiNa57zXCR4CJ/8gXbncbFwy3JEeIPTGToKrrwfa7bMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PbFRNEaVoa7+oOm/Uk5dJlrTDqgoD/i9eSmj2G0Pmfs=;
 b=y7WRq2nmZCgslNwjzMHCEp9kjSy2me4B5VjuhwCveiFRR8kQ36RAkvwURW5O/0OdEWGbux3R2t50JY3rru7/9BZyrksnQRpAVIPxAij4HcAp5F38vb+73/JxaPQ29dVIQkdSHSDgWkVtqwoEsmVj/d50QcWfhw58MxUUMPXe8qNAQr5dqcDWxkyHY0d2TEVdp2ACu4F/UFX+YzuASu/nPfh3UVTR/fE39j0W0qkS0piCOr+C5EoRFrkkmAYW43gYxAG6leJ1sW8dzM6cWFGdzHJzL2499Vol9wpQUu9FLwVxQnzktIgdoldPZ9SLJ9kqvsuKHmEE2K4T77tsiwxsIA==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by BN0PR02MB8077.namprd02.prod.outlook.com (2603:10b6:408:149::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.23; Thu, 28 Aug
 2025 11:11:24 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88%3]) with mapi id 15.20.9052.019; Thu, 28 Aug 2025
 11:11:24 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: pbonzini@redhat.com, mst@redhat.com, marcel.apfelbaum@gmail.com,
 eduardo@habkost.net, imammedo@redhat.com, qemu-devel@nongnu.org
Subject: [PATCH v7 07/19] hw/i386/pc_piix.c: remove igvm initialisation from
 pc_init_isa()
Date: Thu, 28 Aug 2025 12:09:50 +0100
Message-ID: <20250828111057.468712-8-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250828111057.468712-1-mark.caveayland@nutanix.com>
References: <20250828111057.468712-1-mark.caveayland@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR10CA0053.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:150::33) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|BN0PR02MB8077:EE_
X-MS-Office365-Filtering-Correlation-Id: f97e834d-82bb-469a-c201-08dde623a049
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|376014|1800799024|10070799003|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?SUb1ZLJ5cxsNm0Ym2RIE5fxCeMh1VFvmQ7Er7H1CNB7dPDbDkm66VjrWMPzD?=
 =?us-ascii?Q?571n7V3UYJwoeVXk+WxpK1BhQxfgo29s4y9aoDVkuYXm3pmWOqQGfHsjPnUT?=
 =?us-ascii?Q?OfWMMw0GeMly1vqyEY/+gqAh9JdumdJYrUiTLnZlyvdnK8afA8xgjegxO6Il?=
 =?us-ascii?Q?hvLDOrdhjUIahLBJh5hFdFyPHN84xo0vFA+KDHMkpyTqmU5mRIkb3o3Pb3eN?=
 =?us-ascii?Q?1vESUZfqTXB/nUe33/9aT5CGNyND4UfOReFjA0FQv0gbdKT47aWgWc04ehKY?=
 =?us-ascii?Q?mmdccLnnQhetCYVPzEql41zcDwp2PVrvN61cN65lEAn17RzPozNOeeYZ3sPb?=
 =?us-ascii?Q?3c0xTY4Sp5wgYIHczBb9E1/Dc8dBB9mVRNFiaGNSFJhybjcaZtZOAEQJ4WwX?=
 =?us-ascii?Q?DoAJbt5IFQpT6/J9pn1knvBggvyRPKa1IkykZufvMZPo8HwZ8MwIctr5+5wv?=
 =?us-ascii?Q?aBP+X45QF/4n2G75XzEnGggOxrC5nqemWk0/qurqIT+698DJDr7ry0UHgvrf?=
 =?us-ascii?Q?lqshaJTm3T9CpyNWvRdSLoVb7KrBZFsRHYlCw/PzJLBHUT7Te/VgSPDh2FcR?=
 =?us-ascii?Q?21b/AgYhDKry/OhZ7ATWtKJjdY1ANCetz7yzedM1jD5/8/vbszKLssT66Vpx?=
 =?us-ascii?Q?rhjDbtEH0dtzLIZGUbfvDLfyARA2s2mXhS38yMkNzK4K7jp/XRgI4NnPvijN?=
 =?us-ascii?Q?h2aR/ftamBvdh+zutapX0bPV0vTGmb8EsuKiYBUQFKwJT3ET4vX0fR2QHzEt?=
 =?us-ascii?Q?zNxyYiP5Y+/gcga+yI7a6XWGxIeeIwNr91/e4GC/sxjm590naHPdBjECPgyP?=
 =?us-ascii?Q?VxkFjhafWNM1dRsM7NSNXlhVGjcmt6yyWn8xpdewGm/NKBXFdWcNCefmysh8?=
 =?us-ascii?Q?Y9B7DlKOEqP0nJjMhhSmFIjZA5onKmyRO5cYGLpItwNUXxBGUDqWyAeT98Og?=
 =?us-ascii?Q?vEThTkQYWRoCgbovht0zU/J8BYXkXCwpHx/qj45foEaA0e7M5UMK9lg1bDF/?=
 =?us-ascii?Q?tpyp3/0HRHE6v4hWn4UylSc4tg/jgTfwF+6Wsl+sc8yAl1PyO5RfVK7XiEHM?=
 =?us-ascii?Q?qUKFaIQNWndmz/7VhnNZcP0CJ/WP4CkVpLf1QIozO4EUB1dzK2aTHPrJHIGD?=
 =?us-ascii?Q?cc9KmAUiuzK/yClY+j7ZX6mr0XJ9IjG6c7P1oOUAJ6CUFrzWy6AmpGTCJXjh?=
 =?us-ascii?Q?zUOd/HlChS2ZpGcZYzq/5fVrRAW6eWhBXKNYT12qrZsnot50PYMqGt8xWfd/?=
 =?us-ascii?Q?QcD91ALQh/utk2IQ2vbPnoir4/Yeui+w1JiOAUthsquWy+uy3WJVXFZwGF7Z?=
 =?us-ascii?Q?vug19Eiza1ralVJiSWgtTzkVgEa+9vdx7/VmonXIqyadmIC8Yqe8ohycbY4F?=
 =?us-ascii?Q?ZSGeEi8HH6xtKD8GDocTNWKL2+x8NlLyg1nGHmGME6qpRBWhIw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(10070799003)(366016); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?aFNWY90P5aBX1XXwOd+fWl+LtiUVfRj+66QbGSqeb7xePeNJkj22OV0xtFwE?=
 =?us-ascii?Q?NTUa+w4k68n6RlycWy29Tdr74cT5MzmVICA9PoAOCWRhSdGuAEHjdGFk8ZDg?=
 =?us-ascii?Q?uVARDOFtDtFl8AdkfNDFFephVE3HJiKTkcvJhFz/BRvBTY9vS/wmBPKfiZSR?=
 =?us-ascii?Q?GlmnPmziRP+MIHr5OpS1Jxqj2qw0A60gl3LkcbkhO2SBwICFhmeAlq18xkFc?=
 =?us-ascii?Q?UwoUVtvhuX96mIvm3BJZP/EJhSbcaPJ9WAp/1EBteNCDZjBZ8Pl1GOrrlXf0?=
 =?us-ascii?Q?G8qmYBQ1wUuu4WwbWbZ405T0oUa5bwc+f7Sgv+geaCTIOLF62gVhwNZ1Gyxu?=
 =?us-ascii?Q?GyiPMFudXUv5zeGenw61D9JMHaW7jiULiCov/991OHqlM2XPxggKpsho2uPC?=
 =?us-ascii?Q?iUVfBdGZc+3gW1QNyqrLH6Gsub55epiozCoLiUa09LxbYAIrnFZHRKLrrfoL?=
 =?us-ascii?Q?lQhLCoFw8jl0TXBKn1NQyjGWfd/NKXa4rxvDQLRPiE0DbjSXfb1bd3Zhvj9r?=
 =?us-ascii?Q?0lgYtP6lOaSBllafOSBoz1C4X5/suxTN2T0Gq3X49KGMFFeQml8OpXzfS5OM?=
 =?us-ascii?Q?KEDO/4QBFKnVNJa7gKODIAnAVlALbCL3V4oRN2cTwvmcmTpOPo2NYp2u1wlt?=
 =?us-ascii?Q?PR1XfGGU/MECLgVYvW1/2oV9CBJ9p21SY7E8NGN1sNplNY5i4hdOS4OlB0W9?=
 =?us-ascii?Q?t4kvVsur3RoyiuTT++DY5IJgk6Lw2CoUxChzMfyNxINy7pCfBvPVHxS7qBed?=
 =?us-ascii?Q?3x+PDyIkOWLNDku0K+Y6YcLgcUtpi5BXJyCylvUw6DHi6bFibVjbL2QRjpUF?=
 =?us-ascii?Q?YFdCqba0KhsK8L/BV3Q504G5N+8b/k1n+4jpXJBzjAEvvtMI+YuFzMY0TP/b?=
 =?us-ascii?Q?Y/50oseJ9afQ1jb+Ebs5hGpjp1O5XtRT6hkRa+wUdudbBN2T8jf5PZunIF4+?=
 =?us-ascii?Q?oTRAdYXgFKRJdO/ECEkIwX3/zE1HgJpk/NBLahR3X6MOP010R/ulH5Gvfm92?=
 =?us-ascii?Q?Sdjn9VXErwxW6oNOyKStTAKr04oUHij53mI324cm4VqR2nd2nn2l1AOTT0Ek?=
 =?us-ascii?Q?jXtFE6BURFFNss5MwWv4Ne3iBho2VEeZAp5TBCTp4OTLprroMzZoh9t1zEks?=
 =?us-ascii?Q?wX+zMiNdT8FYlAB3KjYNnpXJb822XfmWxcsMdhrRdIdQ6fyIDXFWvpCvango?=
 =?us-ascii?Q?dNi/UfJbVuVlyp1lwOq0PLSZ75nCvgqkRElEnALCMi6xJTTdKG1o8W0CXcE3?=
 =?us-ascii?Q?pFOi2QiZma5uzHPbnLOFmMBFA2zv9FfY+Z8Zhww7YupTvFvKKliNpyeacqxB?=
 =?us-ascii?Q?C5vXfBdJLdXXPxNm3PVpHLFX6vTRF8EI7kiv5NyOp6/QSq2l25D4lBgL4Asy?=
 =?us-ascii?Q?1/NgxQ3uIIqkouZq1GVMTQFJX9z+ezvlOCdhnwhLDyNi72cZ+yEQLlbYmx6U?=
 =?us-ascii?Q?O9XZo/73VGKthf09HW4Gm2XMe3s9in6sfoFLAfRKGVGjaFrC7liCyoeydhEd?=
 =?us-ascii?Q?Su657EY34QSf1trm2ZuvuEsxulummdGS1UV0Q+BzJwKsGmKqwflmA7PqKw7U?=
 =?us-ascii?Q?pFmuXf4mFiTU4ZYTZbeqYmBMWOO1KJvTJVsf8eNnRAuEvLlBaFpKr9rS6pBV?=
 =?us-ascii?Q?X3BcWX6S0ziCjrrqCjiavXp95IaiG7f/SOoqEnR7T2beDvstsK52K1pOxFs+?=
 =?us-ascii?Q?UYXX5Q=3D=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f97e834d-82bb-469a-c201-08dde623a049
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2025 11:11:24.4612 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sk7CYzJc/gQeJELIApasIxCkNML8iRBm8P5LK4MDMAVVLxCwIUYula1W4a6todip3OXTZQqHglyEcnUwPn07UoVKxOcG49wC5WAUzeqNu+I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR02MB8077
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODI4MDA5MyBTYWx0ZWRfXxmGnHYmT5OxB
 5q6y1Vz19X8lTHVGUMUn/E9oTOVV+5t2KWBcNmo/8Kz5s+SzR4nQ1aV62MbGwF6pKcikRuxNrtj
 sCcH/NQai5LAod5O1NRfPLdqoEmT25UyZSlT+errfFHFaycGqRi8BV8US4cgbJg9PWM9Rf8sfLD
 a2yhqKoBmWKQbxaHWBkf/pJb+g2ofx3E+HsRHSqMCy7uH13DFBMj2UUcTLVpaxDx3O7vi8mX7B2
 1M7PSTpx1p9WuCAyNMjG0wLxvNdiWu8E5brzTbosD9+Pd6DqPeaySRom3FGkSej3ZbCnJhpH0JO
 hpQnoKNI8jUZVUyfT2yWmnjmvE9vexTxtlMJ+v/VQ1cdjTc9pTi/Wlnjx7104o=
X-Proofpoint-ORIG-GUID: kgZT4dj_2exwtb71LOmfXDQwWbSvyfhv
X-Authority-Analysis: v=2.4 cv=IZ+HWXqa c=1 sm=1 tr=0 ts=68b0395d cx=c_pps
 a=/d/dYiFJ9j2vSnh1phFeww==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=2OwXVqhp2XgA:10 a=0kUYKlekyDsA:10 a=64Cc0HZtAAAA:8
 a=HV6HxWYAiGuMivAlcYUA:9
X-Proofpoint-GUID: kgZT4dj_2exwtb71LOmfXDQwWbSvyfhv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-28_03,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

According to the QEMU documentation igvm is only supported for the pc and q35
machines so remove igvm support from the isapc machine.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
---
 hw/i386/pc_piix.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index f1b4468d0a..5ae265bd53 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -640,16 +640,6 @@ static void pc_init_isa(MachineState *machine)
                                x86_nvdimm_acpi_dsmio,
                                x86ms->fw_cfg, OBJECT(pcms));
     }
-
-#if defined(CONFIG_IGVM)
-    /* Apply guest state from IGVM if supplied */
-    if (x86ms->igvm) {
-        if (IGVM_CFG_GET_CLASS(x86ms->igvm)
-                ->process(x86ms->igvm, machine->cgs, false, &error_fatal) < 0) {
-            g_assert_not_reached();
-        }
-    }
-#endif
 }
 #endif
 
-- 
2.43.0


