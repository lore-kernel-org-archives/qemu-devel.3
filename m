Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 625E3C5DF89
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2026 14:52:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wxQaV-0002cl-P3; Fri, 21 Aug 2026 10:51:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wxQaT-0002UR-Vt
 for qemu-devel@nongnu.org; Fri, 21 Aug 2026 10:51:18 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wxQaR-00048Q-S9
 for qemu-devel@nongnu.org; Fri, 21 Aug 2026 10:51:17 -0400
Received: from pps.filterd (m0127838.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67LCkYXv2467787; Fri, 21 Aug 2026 07:51:11 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=proofpoint20171006; bh=UAdPHYdnLoOCH
 kyt2ynitII0IPd5sEjTl+NsD6mQ52M=; b=yDWUGu4q89RsDHC7H4vF7tkj8znhO
 YDryEB1nl99P4wCFkkRL3hN+/UUYo9aaVuaU15NaJYNYOqRhhVaeRTvAokFxrljn
 8Cv9T1FSg9yVutPHSBuGS4ZqPAUugGcHjoy1XOBlMZjqXuAXxttCmhxCxMVBCbC6
 fkRMkEH9cIleYPRsC40jS4/HU4n8CRcPr/PJl/cVNrjCZb0WIgmACK66Z7Ott+CN
 UwJoE2GouuuWK2Vd4iT7e7roKV7I2HmEEg63CAFVKGzTjLr8n4ukd6kq0nQF55nN
 4QJzzKqWsKkExVGF5760BDH9EKL8HdayNLNMO4UFsF6mMA1Rf1L6GpLJA==
Received: from dm5pr21cu001.outbound.protection.outlook.com
 (mail-centralusazon11021093.outbound.protection.outlook.com [52.101.62.93])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4g6p0y0b6q-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 21 Aug 2026 07:51:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ajARkPrdPam+ETJJ23OCVP0zO5Cku3UNARx4gl6YAPYwEZ+SQ/E8mI4tWCxmizSQebTKKhRHgiVxk3LlItZ0B+KgbgpQnRw+bhh99bEsyftPMOPwNnfVkl6uoduVjfLL39AtSw3E/hoKzT9qhjUpsoffk76OtIF4vlp8cgqZEtQy7p7qq9vwy75vyvI1Med07LyKRyqu7ktMuukM/r15hlpTOFn4jip5CKXmewQRDB3NHLF2YVu1NZI9pak3AdnR7r7zvjxt+QkUat/ZdUI22ocHzRn962pwMizUGEVmWDW2ijgWABgrQgL+E/9GEVSZS/Scbpgr2JnmBk/IAM5Q/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UAdPHYdnLoOCHkyt2ynitII0IPd5sEjTl+NsD6mQ52M=;
 b=mJhtgmeaAQUeOUD2FM4EGdwtsxdVxRrTG1RtT20JJD0YHl+K8W3SvpCVUv+Sb9L+0sb7x3d9fhws4nAzVDgOydTe5nRRBPHBlxOWOWJyhrEbb2+hl6bLTvu1tzQGIu1DFDTgplJKuQJulHypjQUXVnEfahI6vnwrFspoh344tTY6cz2NrEAxFhMwa+SwZRNg7KeYmq8/G2vw/YAq26nJTMDX3h0UwWWCnmWVVZgxZq7d4DSAatQfZ/Ci4dl7Ow05COSuseAixJXD3XRhkERPlByF52SQf1X/PgZixzev3IW50wWi7Wh+BLZEjjryPPQyfR4hCCWwqwzIz8/GjazXdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UAdPHYdnLoOCHkyt2ynitII0IPd5sEjTl+NsD6mQ52M=;
 b=RS0t0pnnfsOonFLNsM9fUo2QKgwLZyZvOJMncDmL4aIS4y4JRqxDPmqGLmyR0Ltu+P4vI1SxZZp1sbs5e31U2kbbPNpWxCNQSR/xqRp55Xq554xAG1b7P90K1TMPo5Yk5XIu4IKmEtT4eRIwBOfX0j93QX2RKO6vnvWiJRKswLcxNHM7OJ6Md1WKw2MTEfEybG6IrdSqzNN6Q0GcnMzY40r3zKS6MvZaMdqa5K52K+C2hfVC3PrkRlaY3xSjb8FOTz/qn+B1gDxeoO7lbT/beWTQE7KQgLNRjddPg6NoLxbVe1lL97s760+z5rvrc3m9VBx1kC4P5nmRcc7d7jphrw==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by CH9PR02MB12078.namprd02.prod.outlook.com (2603:10b6:610:355::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.11; Fri, 21 Aug
 2026 14:51:08 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%3]) with mapi id 15.21.0339.010; Fri, 21 Aug 2026
 14:51:08 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: mst@redhat.com, pbonzini@redhat.com, zhao1.liu@intel.com,
 khushit.shah@nutanix.com, qemu-devel@nongnu.org
Subject: [PATCH] hw/intc/ioapic: deprecate version property
Date: Fri, 21 Aug 2026 15:49:37 +0100
Message-ID: <20260821145104.364283-1-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SN7P222CA0029.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:124::23) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|CH9PR02MB12078:EE_
X-MS-Office365-Filtering-Correlation-Id: 03c39abe-b71f-4842-abb7-08deff93a213
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|366016|18002099003|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info: HMb/hFv9asMl1WJb9I0CXYoK8pPi3FvWGtarBc+Ico8KkJjCqYhNWesGMzYhY7oKWWHoaL9DFfYsnRR7LLwbsOTVqlLfNR57i4Y+v5DKrz0CC293bfUxWlhMYQ+WQI+rXdX5n1WaxLNucAmonNefZcH7B/aMaJ7VK0OsQRgtas151XW/lX9nt5GkIo5EV4cWLaaEGNvK9xsumWyGqKXrTa4S6b4bJMYVoVmNecg83JMHO/bENyvqTBZzNRE5QnLcludVG9bKMRGyozcal6fkNpmw5tM8SITz5O8GmkWUsXn/JC5jXZvMufy1YswKMBsDg1khGg1JYI8jN9Z6kuX1+enDRYMW5YIJsviuTEH/01Ps25pwe3F/Zr1SHZYA6yGQZvcc6g/KIx3KWfPdfQjKkw+nE84dhq+YNO5g8XXsWFmaPrFTAAc4T7ZElAWfAHc2hei2eqUIXVmlaAg3mRBMcMBPss4Gr8e89LP326dhqCQ3iTDuyfWuFcEdXu6Y1kozxOn+mJV2Vmgy9d5OZzL/8D6OXK6At5GKniZji7H+RYOziwiPWRCXK6iEveRDa4Ex13zZkYiUOgfQFxMwIPyfQ3/yrNq+omrxa7ng1Br9CA625vab6IBapOra/znCzD06
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(18002099003)(56012099006)(10067099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4fR8yXPSWB5jPUwZGQG+eKKDG7CWTVDt1+9+XavXKshiTTrqGGp5uHb5l8LY?=
 =?us-ascii?Q?tvZjwcXPDUSr+OJJRjwQogKR4YTBuOv6sSczdDLus3snxFX9Qc1tyMFJtgfH?=
 =?us-ascii?Q?sDVzSjgYLqn0YFCyPQyPdy+S4mUqvtX0lFBWiGcXaTm3pmff4H8U3USaHk99?=
 =?us-ascii?Q?mk/NuiMh4TS/Uzk4EDntlXLZskdSRhTppbFAkGlYuWsUeidtbnFCvN6WfhIa?=
 =?us-ascii?Q?0fNmepYdfaECN+vos0GJcUm8Gyrior+E8UoiBaLallq9uZyY9AOaeHN8PYaj?=
 =?us-ascii?Q?jBxKvaFDXUE1zlrNUVLyqLfCr+kerrrmTlJCYX+BXXU5FLuNRWzNrxodzhoM?=
 =?us-ascii?Q?jYRXqBI8ws3lq1Y7WOUcS4FovlA/VhZ0jv/uRigguL1eHcUJ51bsjqHs/+Hw?=
 =?us-ascii?Q?RCQRXoyWksDxAPkYnCKDlJKb1lGjRwnwsBVNgz8IaZgBaEg1h1mKvDhcRgMC?=
 =?us-ascii?Q?GjHgySsEAyaeeJ1j6SaTXIE4QEQ3mCgWrGSvo7/5pZm21kfO94IjaaiDh984?=
 =?us-ascii?Q?N53ZuDBAZ57iZl7hjOVUtCduuBzg87AIjSzRYpp6tuMPmFvgDFJrRa4VL+ES?=
 =?us-ascii?Q?ZLOKwZ4JMMfEBY1Ot9mNoDuS411Dvcp4bRTkB8DZQygzMHJrjaVUg/prOvde?=
 =?us-ascii?Q?pIY7j/s0DoDLRZsvtK3WTED8FYOEeFt9VOqLSkcpQ1L1i4Im6Oo9QZ62lmFA?=
 =?us-ascii?Q?QXHhU5Zxc0AAdB9rUmYfsppE6ZDkVemp86AbHJoQi5SRdB+AyMgmT/ljfurv?=
 =?us-ascii?Q?X82BLgwNFcJof70GNHecTzOOZU4yTlG05ZO0SA41/UELZkDnapprRagMPfMx?=
 =?us-ascii?Q?yjp2hxI84wnhQjfipJzYKihSLon5sOnmrTxv6We4gjHggbj+pvwPNHe9Ee1n?=
 =?us-ascii?Q?LMNChcVOGpXg27/b3JbjDQ5cLiaf6tLxEbf1FAh5ynfpwx+f6R9rXKjQsRGU?=
 =?us-ascii?Q?pU3gV2G8oEce9kLnCDJHkI5w+cFVVfcuLxCN3BieY5i1K8hCvvBGJmkGAr0p?=
 =?us-ascii?Q?p8S9tZRgVdEhMB4/ZcF1DlnKuJuIqZc6ulUozNk1BL/O1UJWywYNoPTn5/g1?=
 =?us-ascii?Q?hxTvCvCZkp/o6JW3WQWRznyMEFB8phirbO47p0103X/Etm0BUbSdgPFWGuRE?=
 =?us-ascii?Q?cXQcEicCIThHsZZjrRqckBSs834+kxd3gZYR42w3SEAl4252XFyfFkZE8Hh4?=
 =?us-ascii?Q?/xeIN509IFCxETzmoPwXsRs4g6LabdTeVhWs92Fh8g72rp34zQv49xSJI0ju?=
 =?us-ascii?Q?GBqzBia5NQ75pcpaVArhCn4BBs7oAPMZezZ55EG1ghNifE2bZ6qt5ZmwglVy?=
 =?us-ascii?Q?pprDSbDAs3F86RmsONEV+bdchGrUOUjOEIM+mK7HzjoFZ2RXchHlElNnMqGB?=
 =?us-ascii?Q?Euclh7A+sRn5XeDMglLCUbL39T5HlVx3kGk75WxFd3804hMyUqG/+X50Ko0X?=
 =?us-ascii?Q?VMaVFBUFhMyjW3HeOFBnbJLUENjLJED36J9M8f5yXySKqg3RWjgNZ9mMWkom?=
 =?us-ascii?Q?Uq09hP57GTlzJ69dfGWsfbdNbHpPJa74jCMv/sP3t3WRRiB79p1hPS+n0e2T?=
 =?us-ascii?Q?jLJZtQt8Dy416kv/Adx57Ilb6TSUkKl9slL32LXYOgkfvnl7re5+5HKYqPjT?=
 =?us-ascii?Q?plj/oxobFaIg95/MAHXvubaf+1xZxr4ubjzsHEyc6WYAKYe9Cdf3a+D2/Jl4?=
 =?us-ascii?Q?M91bR8drewXZyaB9aG0j3En+e4gIWq8kEBEcBpcf+uGBOuiut0yI6SebyVVS?=
 =?us-ascii?Q?c1YavlDEnVPCW8X+GjKs2xxx6Mb/Vz8=3D?=
X-Exchange-RoutingPolicyChecked: nS/jZot4K68P6ttJS8fXRXr8SZqCyvYgSIYNCDfnts2Wg3Y4ZBXmB7tJiOurtjaihEmiFl4gElU6fBwxgem9lIkhzJIIimneac13sESWhUV9da/liGK9A05qWCt7L9//BQ27v+Ft/iAjmhRjagb8kl7DE7K1tAqy1ewlRcyWhjVL1e9QTM4xytK5LUYLsppvWB37m99eMaUjDTJ/mcj5QGJ5NmIT9Y3IzY6WUZI1Ig6g+Wi5XMgzIzH0xEFUqjsACa0s+rXr7EXsez872yvKsillDQLTG3VuGPl2vhTYyDCVZT973N5NU5dZdrfRPLufkvNNSuHBpqSIXaquNUURLA==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03c39abe-b71f-4842-abb7-08deff93a213
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 14:51:08.3712 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uqfTAWi92IGks37aICv1ZiZB2wki2YAJms4KoWo5B51805PyXkssJgPaUFZzEEUFJF+xDI2GVI32Bl/Xp+bdGrUN/pgnw1m5zueBpcRDh/Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH9PR02MB12078
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIxMDExNSBTYWx0ZWRfX37uYY3ThqC2r
 d2FZoVULPrg8j5aK5+KffPCc3v2Zl+aUDA3k0aFsSr02sZo72Am8u+HHbsEMVO0yJ7laUk1DrY3
 T5NcM52XNpCWUl/WknNL1ZVHKuWmm4w=
X-Authority-Analysis: v=2.4 cv=XvTK/1F9 c=1 sm=1 tr=0 ts=6a8865df cx=c_pps
 a=y4zkFa5omBjxxVHSBTJAWA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=Sv0fKeRqtYgA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=1L6crL_YRTbalZ11mEUO:22
 a=mDV3o1hIAAAA:8 a=GaQpPoNlAAAA:8 a=QyXUC8HyAAAA:8 a=64Cc0HZtAAAA:8
 a=nzTY5fZSdGACR-6gu0YA:9 a=xF5q_uoM5gZT5J3czcBi:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIxMDExNSBTYWx0ZWRfX6ov7FdcAFNk4
 OTyB+v3Lz68EO0viJJqUrLDTYpARVMoe84PHZHV7OfQYCASA4FuFXzfC5Cv85ksQwiY++Sk7t1s
 u9HQotSRrveNswlcfJXZW16oih6XzAphsksxbBMUIjk8ehmQl4fY9i6oLjSuawe3al+ZL8UZ80x
 NjpQvV6Ktgc+KFtpx3+mqxZhvLfC+xS/c10HVBxwj/ok7YR3HEkzfx0UHSSImu7sgZrwi8oJkGH
 F81aa/KFX2cETD+RRdIsI+40nNih1h5qSfEszzfYHEVv+iNxvIHBvAnqPU0op2Yz0a4qYhix3oo
 933/xa1GGAS2XMqHTgAjUgUJRana6u+xl5BlB5AyCF3NexclZ7PcuWjLZWocOqz1fAZ/bNUCK30
 fci3GpnfbGCHPrt3M67pkNjDWqiidBLNqq3EgRJcpnYRHkd1LIsx/HPy3aD7FzjGAbg9rO+z0NF
 n80ksXfY+FCV3s2c60g==
X-Proofpoint-GUID: k5YI-3-NUwXy8-7ouatMj-iOEFtpG17V
X-Proofpoint-ORIG-GUID: k5YI-3-NUwXy8-7ouatMj-iOEFtpG17V
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-21_04,2026-08-21_02,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.341,
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

The version property used to specify the IOAPIC version was originally set to
0x11 when it was first introduced, but has been set to 0x20 since v2.8. Since
all machines before to v4.2 have now been removed, this parameter is no longer
required so mark it as deprecated pending future removal.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
---
 docs/about/deprecated.rst | 10 ++++++++++
 1 file changed, 10 insertions(+)

Following on from the discussion at https://lists.gnu.org/archive/html/qemu-devel/2025-05/msg03027.html
it was suggested that the ioapic version property should be deprecated. A patch to deprecate the
property was proposed at https://patchew.org/QEMU/20260210032348.987549-1-zhao1.liu@intel.com/20260210032348.987549-18-zhao1.liu@intel.com/
but was never merged.

In the context of Khushit's patch at https://patchew.org/QEMU/20260804091827.3203086-1-khushit.shah@nutanix.com/
it makes sense to formally deprecate the ioapic version property.


diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
index 0c656a968f..bfe7240040 100644
--- a/docs/about/deprecated.rst
+++ b/docs/about/deprecated.rst
@@ -305,6 +305,16 @@ the addition of volatile memory support, it is now necessary to distinguish
 between persistent and volatile memory backends.  As such, memdev is deprecated
 in favor of persistent-memdev.
 
+``ioapic.version=xxxx`` (since 11.2)
+''''''''''''''''''''''''''''''''''''
+
+The ``ioapic`` device ``version`` property configures the IOAPIC version for x86
+machines and is typically set from the command line using
+``-global`` as it is an in-built device. It was originally set to 0x11 but since
+version 2.8 all x86 machines have defaulted to using 0x20. As all machines prior
+to v4.2 have now been removed, this property is no longer required. Deprecate the
+``ioapic`` device ``version`` property so that it can be removed in a future QEMU
+release.
 
 RISC-V CPU properties which start with capital 'Z' (since 8.2)
 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
-- 
2.43.0


