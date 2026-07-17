Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDD82C4451B
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2026 13:58:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkj50-00020U-4T; Fri, 17 Jul 2026 09:58:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wkj4x-0001yc-IJ
 for qemu-devel@nongnu.org; Fri, 17 Jul 2026 09:58:15 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wkj4v-0003FX-Qe
 for qemu-devel@nongnu.org; Fri, 17 Jul 2026 09:58:15 -0400
Received: from pps.filterd (m0127838.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66HCJOoj3917895; Fri, 17 Jul 2026 06:53:04 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=qiauaviUT9fH9rFGNn8SGZUHprau/fULO95C778NA
 Hc=; b=rbyQiTvy62wWIq26k3i/YZMdTIbesUwr7g/qYIAGyMqzQJWTUUpiL2eD2
 1ZGGR/U86GuSlHHD43LBjJJen+A7Uk6nCYbj3GXtRvS8MKsRefoKHEJkcbTyeuDO
 OdQ5Vjy+I+EmOcnQX//Ek0akDe1An2pSNzr380AdA/7eNT2CndCWRT+UCwaa4VK2
 4fAkN1ilsLdZ/uubLXjorPitW3ev/qegTXwgxG7Ca05LSneSgaiakTHYFxM1K5vJ
 x+MtzGNZeV8KKskoqpmMi0HBumgMk9WyG10kPSc+WB+37J4eo2h5qdV//lhpSFX0
 xlAiV1LI34tJ5lY3K/iukpQoz6obQ==
Received: from sj2pr03cu001.outbound.protection.outlook.com
 (mail-westusazon11022119.outbound.protection.outlook.com [52.101.43.119])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4ffh4j0m44-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 17 Jul 2026 06:53:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LTzdXy/ze/C6zTO4mdPMEzOqtPLHdS+oYm8zmO0NOnWQvkHNIE15L52tR3CF36Wbd6eQ1ibfvYmlGYgONTHj8AWdeTyr41AWmvhmnWlW7fxyuRe/nYGwig6kn3Zf8dTWqigxXWSsqYxt9AGChtWn2ONw0ao2Ob1CMK2liRCMsoX+bRerBZsFw6aY9aaRzgvIxPdsb6pYdbyLZXkRYtNPaXOXL+n+BmlJYbIPmCCZ8XSS308fRXp8GfzOoFTn+FNXOYRDdgHUCJF7N9TPj96Yu+RqGqyo0/pDsjzn8rKcXLnW0kDUPJYXW5jSfmj172PVK7HXWlnwo3afNElTtP+rIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qiauaviUT9fH9rFGNn8SGZUHprau/fULO95C778NAHc=;
 b=jZt9Fo4MTQuEpA9I1OCDxEYE4BZ9TVdQ/ku8Bur1jDodrl/i+6W0N21J1+/d3tkYAE4yNcbAjbiT1qtsDRzjI2WKvlUwxfJJvv1pQIDbtFIHnFSxn1Pe/mXkF5SeWSMFJ3mjPvR9EZSz8pUWy0tpJVXRLQZaLzXWB9bvYxrmg1q2lAW9BRHErDBWS/RvpzfB9crgy0OQpQj3GNJxgO5i2T51RvEpNyaQUYt2wjd4T7e8XVrHqar8kfqdTKok4zmXjzSDRkYxNCAlBbltSpVC2k5f7qa09OPbup2x4exdP4sIWgzMwgfA6aypboClQ5UudA68rwB7JbNwOa1r68dfMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qiauaviUT9fH9rFGNn8SGZUHprau/fULO95C778NAHc=;
 b=bLyt40yXrbtMXisPsNsYcrauKHboyc/dZDZx+dXVkqMoKVvUdEWEbRhGorADhw2pFBzMC6xE/c1T8g0JRZzzJvvkbzDorvFmnMEkbPCrVkb5Yw0hbMbzz8RNtLg0TUe9vQaIaeWVerNfkWQXKynhm11jeOa5KTgzAMpRhccf4z91upy1rP6zkymkD90sUEPAkj5RavakINTwn7M6YnTcpujh13EQOx3ZYQV4gTh2ejEGTen6wvqcYQqQtfkyYxAxtRhU6c+S9CS01oxOmKAXF1tfacXHIWzrfFoWq/82QXGU84CB94wnQjbW4R5vi6Sl/DOtPsxDx2BhdYtNRvpNmg==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by CH2PR02MB6888.namprd02.prod.outlook.com (2603:10b6:610:86::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.13; Fri, 17 Jul
 2026 13:53:03 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%3]) with mapi id 15.21.0223.011; Fri, 17 Jul 2026
 13:53:02 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: palmer@dabbelt.com, alistair.francis@wdc.com, liwei1518@gmail.com,
 daniel.barboza@oss.qualcomm.com, zhiwei_liu@linux.alibaba.com,
 pbonzini@redhat.com, berrange@redhat.com, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org
Subject: [PATCH v2 1/6] qom/object.c: introduce
 OBJECT_PROPERTY_SCALAR_GETTER(type) macro
Date: Fri, 17 Jul 2026 14:51:41 +0100
Message-ID: <20260717135254.508701-2-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260717135254.508701-1-mark.caveayland@nutanix.com>
References: <20260717135254.508701-1-mark.caveayland@nutanix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CYZPR20CA0005.namprd20.prod.outlook.com
 (2603:10b6:930:a2::12) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|CH2PR02MB6888:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f076064-f52f-4382-8db6-08dee40ab7d9
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|6133799003|56012099006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: AbAIzBegtVMvl+5gAuH3NGGbtKQrvLMUObsRvmA0XyR2ots+OWXkZHcQco5nYu/ObzxJNuWlndAOD3UkTMPgWoflSuTKWlBPQxPkHo+TKleV5twvm40Zi4avvMezoV/KMEO+5w+vy1ZPaiTfOPFRVlVu42cIqkb3kgUQxc8yNZx3m+uWFXxkCD6uu76B9qp2TI241/pFDhx6T6XUL65zHogqi9YcMGhqrevTgraezI1iqfyI86ayWVXd7n2+rTpVkNesfNHWXKxMyPVck4t4y6NiSnYOvwf01HVCu+gpmn7bQBGS0GckhwacPXI7tf1oIZfkf9sbSfRERqrQNXs19tg30W+wBIvKbPuPwKFsnuXiACtBoz1Xn03jySgte7XRwKjmqzhYSsUw21iaNXQkN2RzFHBrCTOPzM2EFxARpSCciOdt4MCIUT0dDCdqGQ5abbgfVSGuaeuDdwvIR/0qWRRUKh8nz6aWHsxVAmSnpRUjOGtepbuMF5ij0VShky1TCcUhVdHxSX11shH7JhdmeYG8iHTYza/WmDfi7IpVa/mli7wJ8+r28gm2O31OSv1uGxhX+rL6+D8hlQGjaDbKRtvExMTeiobjXTJ4syKYptTsJoSMOBsF6184imcqqjTx8Vua5/1klECTaXl/hf/Npl0qp86vEhvbRiTFQywPuhI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(6133799003)(56012099006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eUdWZURBanFVWXJ5eFJBWTlPeXBlRTdVS2Mrb2piTm9GdzVyMXRlOFRyRFRX?=
 =?utf-8?B?WUZuaUdHZnlxQ29QeXoxaTlDWW5FazFyaEVhb05MN3dDeHRzd1RpR1RjdDJ4?=
 =?utf-8?B?R1paa0VnbWphMFNjaXlQNlFUZU1WSks1bk9peVdhNksydnFKQXFyQXp6Z2ZF?=
 =?utf-8?B?NzVvZzdJMTZGQW5qVmsxNVVoR0ZvR0dhUlFYeTloWmhxUVpXZW5GZjIwcGJq?=
 =?utf-8?B?a3UvRUpDMmFrRmROeFhLaG1SMHhYOThqZU0wTkw1ZEJqaXpnRmV0WjZiS0t0?=
 =?utf-8?B?elZrdk9wQUJNNnQ1eW9ocm1RL3VsZi9iSjJWdStpN3RPaFNwMUVLSnVNQzVD?=
 =?utf-8?B?SDc2K3lTeTY5aVN3S2hqUjFtd0FpL0dSVzVDRkFXL3NGU0VIQkZ5NlVsWG40?=
 =?utf-8?B?ODMrRXE5OUpxWDJqM0RLSVNZUS9jYWRhVnVJeG0wS0RpejFaV0hLVEFSZDVV?=
 =?utf-8?B?RVFrbExHdXM0QXlrN2NIY1drdFQrSXdWNEtSMXpGOHNUc01La2xmMURreDBT?=
 =?utf-8?B?ek1oWmJJYTYxMmRGQktzcFNmL3JBYWNMWktmZU8xaEVvT1NVL2tydm5PWEFC?=
 =?utf-8?B?dFR3Y2kwakxZMnFMWlhTK2dkK2JjcFpobEpIaHNXUkRDSi9SaVU0Qnc0TUNC?=
 =?utf-8?B?WkU0bzU5cU1aR1RBRDQ5a08rN3cxZXdvT3Nya1ZIRTlsS2NLOTJXcEMzczA5?=
 =?utf-8?B?RTdZMzJncWR3b0RuZTlYQU1QakxqNkVrbDhic01uQUlMdUdDWG9rKzZnZDhn?=
 =?utf-8?B?VG5zcTdmZS8xblRqVlNzTUJrWWZnOURTMDVjbitsNTgvMzNZQnBtKzBjTG1t?=
 =?utf-8?B?eWZEUEQ2b1h1NzdSVW5KS2pKVUxBWDlhOXZCUDFLRGZBdHZZRmYzdHRoMEZk?=
 =?utf-8?B?azFBMC82OWo3aFQxQlBzeEhLVXhFNEx6aytVQStLUGJqR3paclJRV1BFejNt?=
 =?utf-8?B?ZHhsZ0tTajlwd1lGUlVpbEF6NDBnKzlqWUtVdWJucGYrNGVSUk02cGNGN2l3?=
 =?utf-8?B?Q1BDaVZwY3BqcnR0MFRDT2pjNEZDT2ZYRGRpMS9GRnVTUFpVLzV6SFJlS1pU?=
 =?utf-8?B?WllJZm11NXBxU3l4V0xLSVV2UStFdFQ2MERjMm40cTZTSDcvNjBoVGpkYUdm?=
 =?utf-8?B?Q2haZDRiSW11UnhSanNuSU5VTWZ0dHZVQktUSHY5WnBJaWJLaGtZeFZmWkwv?=
 =?utf-8?B?WGFSN2JJVXhUdzlqdHRRQmhwZ0VERDJaT2JtcDNoOWhndzF1OXhYTWw4cDYr?=
 =?utf-8?B?NnI5TlkrRFUveXNqUXdPUWM2cENBYU9iQ0Q4VWljUTlNQUpwSDg5eVRMdHFI?=
 =?utf-8?B?b1FrNS9jWkxzMHRwL0JYcHBrSGI1MWFmRFlQcVJLQUN5K2VlODA1OUFNcWF3?=
 =?utf-8?B?NjBNQWVtcHVJRGR6ZW40N1lSZktsKzR0R012amwwQ09PWHdLUnA2ajBKNzZR?=
 =?utf-8?B?SHFwY3FSalpBUkkvNlArOUNnVjZNRGoxOGlXRnEzNmdiS2JnYzFodGRBMW5t?=
 =?utf-8?B?dUlranhINWgxNzZ1d2d1VlM3ZFlBVkNxL3phdFU1WU14WUZZbFh6M1dXMnQ3?=
 =?utf-8?B?NmxzR0U2Ky9MSmc1bDNZazE2cTJQL3BYUWVvVzhBcWtZQ1JkeXFveW9KRjJr?=
 =?utf-8?B?YnN1cDRET3JpTHRQczh2NExoWmtRTWEzdkE5MU9zTmlCdnZPV3R6WjNLWkxU?=
 =?utf-8?B?VTBINGNWVW1NU1dMZUFTNnNnS3lBdGZXRHFBaGRFK1YxMmN4YktNWGxqdnE2?=
 =?utf-8?B?UG1GN3RoY0ZmV1hQTWxDYlh6VHUrM2t5elpaRFFheDhwTmpYTHV6Ny9YamR3?=
 =?utf-8?B?ZUZXY0RyVFVOMGdTdXJicDNEOTl0MTJrbVVRcE1IdEQ0QzFoc0NoMnJTZm55?=
 =?utf-8?B?Y3JxQkpCSmRLS09PbU92bU9DenVTWVlIM1A4U3pLWHFDMzVsa0JscmV4SWdC?=
 =?utf-8?B?by9LU1UzKy9sN3kxU1lneDNDaEgrbVc1MHZVaWRKN1Z3b1pZbkdBOFd2TXVt?=
 =?utf-8?B?K1ZuV2VBeThuZEpBRHlLSGdrL1doUVBPY0c2K2RUU05QaXk4TVJJL3hIakdM?=
 =?utf-8?B?SUF6RDZkVzExRnYvQXFkUFNtVm8rZDlKWVhjQThDWGlBT2tlQWxCeXRKUERz?=
 =?utf-8?B?T0pXdE9nKy93N08xS3BOMVNUYXF2R1RCcHRmOTQvaEVQeEMxMURrMmE0VXRh?=
 =?utf-8?B?VnNyNTF3djhWYzkrSVpTTDY3QUk5Z1dHSURGbXNOVncyU3hIZVZWN1dRN1NZ?=
 =?utf-8?B?dklzaWtNTXF5ck1DK3FSQjJtYkNTYnE5UFhnNUREcURKODlsVlRwT1UrU0hW?=
 =?utf-8?B?aXowVVZrZ0QybmRQS2pVRnV0bXh0UFYvMS9KNEk3MExZWFR1M1dWMTJ2c0ND?=
 =?utf-8?Q?H1ve6jLiMrZRPtzY=3D?=
X-Exchange-RoutingPolicyChecked: WEPDO33PXX7lxJ22cduAwBalbNwVhUxqqZ8Ls/g0aDYrrvaVd1ovFmQD5K3z5d9zTjx0VEo2x8ragq5CHdPQi/Dm/Pie6xjR4QEQgWV4byrII0ZPWA1kbkjQoodnBHTfN+PQy12sOo7kbehDEE0j0tfSZ3SH1J/Vh1S1E67QrmQrjkQhaBrv4MiAN90a4IajcMGstzkCjJmZaiLMCm6bVjTQv1V1Dq1m0YrPCdNluTs/8B8p5ZMtWcLK+dKMyZorDlsGFhtaYS09pgt8YCF/C0J39GAW7xhzVtw2HeFIDY2+y9zp8JIcsxad+/4t8EKgxebek38wJRr9Gi62+Q2Jaw==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f076064-f52f-4382-8db6-08dee40ab7d9
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2026 13:53:02.2170 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u77Qx//GPgncUOf8pI+mG25ZRv3My65cAU/g4RkoHSVPE4z+9IyDQcoFcwul/ye4NIE5n9YgsgPq7XThIKOFoZn4/FxVwVIoiaf44gliQ+c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR02MB6888
X-Authority-Analysis: v=2.4 cv=FNgrAeos c=1 sm=1 tr=0 ts=6a5a33c0 cx=c_pps
 a=ONh++nyoOH37ENyuzPCuVQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=1L6crL_YRTbalZ11mEUO:22
 a=64Cc0HZtAAAA:8 a=20KFwNOVAAAA:8 a=DsYRqU8QP4ptd1Us8l4A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE3MDE0MSBTYWx0ZWRfX2SkvZb2wzBkH
 CHs9PLItaPo1MBS/6fUtDYH2MdXLAgrX5UOS91Wh0ibn7xa+hI2xMwNSH+Az2lX6oS+/Y3z/bBc
 FilvnAQ2rljtuppWMFow5fNpmm0d5h0mgSu0c3gGqs2YilHJ+DX96CVYIMDjslZH+AbW9bG8abe
 m7Ne9Vcw4Up523OPnTGst9zWSDO+uDQ8/KT5zPg8uQTZH1Ls04r3rgyLGs6DjqemvwscBkIotxO
 8CrQccVFsjzPgW+sRSZ3NDeQcLiyTN5zFD7qmXgNE6ekUv+njXJhmILqKhW/R9ZE2rCHluxdgS7
 WITOgLp9THy5J6CPT6Q6yhMLGtL71yGpf3u0OstjRpAkM7YSUP+dexGOadYQj38umXwAIHGUfhF
 dUTpPFSbxE3bqYL2W2QHb/uMShVL8Gn8zX9o1uOk7KZmjOhWSFJPl5m2Kfxpqhk9XGaQEJ/TIiK
 Zbz3k/QEBGqU7m9NDZw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE3MDE0MSBTYWx0ZWRfX6IwzvKno+QjI
 TA7Iywwiz4AUcHff9n7EVioSaiYMSblEk28Qfn7FUNnI6N3X5goBccAVQcJwa2GEs2MZlmA2nYS
 zRI0f+sygEaKIyyQlEXKEepVquMXC2M=
X-Proofpoint-ORIG-GUID: gmFlvImg5eC6cFhXGLOvlH00d35VI3-W
X-Proofpoint-GUID: gmFlvImg5eC6cFhXGLOvlH00d35VI3-W
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-17_03,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

This macro can be used to generate the boilerplate property_get_type_ptr()
QOM get function for the specified scalar type. Replace the existing scaler get
functions with the new macro.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
---
 qom/object.c | 41 ++++++++++++++---------------------------
 1 file changed, 14 insertions(+), 27 deletions(-)

diff --git a/qom/object.c b/qom/object.c
index f79b2cf361..34aef7ca9f 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -2661,12 +2661,20 @@ static char *object_get_type(Object *obj, Error **errp)
     return g_strdup(object_get_typename(obj));
 }
 
-static void property_get_uint8_ptr(Object *obj, Visitor *v, const char *name,
-                                   void *opaque, Error **errp)
-{
-    uint8_t value = *(uint8_t *)opaque;
-    visit_type_uint8(v, name, &value, errp);
-}
+
+#define OBJECT_PROPERTY_SCALAR_GETTER(type) \
+    static void property_get_##type##_ptr(Object *obj, Visitor *v, \
+                                          const char *name, \
+                                          void *opaque, Error **errp) \
+    { \
+        type##_t value = *(type##_t *)opaque; \
+        visit_type_##type(v, name, &value, errp); \
+    }
+
+OBJECT_PROPERTY_SCALAR_GETTER(uint8)
+OBJECT_PROPERTY_SCALAR_GETTER(uint16)
+OBJECT_PROPERTY_SCALAR_GETTER(uint32)
+OBJECT_PROPERTY_SCALAR_GETTER(uint64)
 
 static void property_set_uint8_ptr(Object *obj, Visitor *v, const char *name,
                                    void *opaque, Error **errp)
@@ -2681,13 +2689,6 @@ static void property_set_uint8_ptr(Object *obj, Visitor *v, const char *name,
     *field = value;
 }
 
-static void property_get_uint16_ptr(Object *obj, Visitor *v, const char *name,
-                                    void *opaque, Error **errp)
-{
-    uint16_t value = *(uint16_t *)opaque;
-    visit_type_uint16(v, name, &value, errp);
-}
-
 static void property_set_uint16_ptr(Object *obj, Visitor *v, const char *name,
                                     void *opaque, Error **errp)
 {
@@ -2701,13 +2702,6 @@ static void property_set_uint16_ptr(Object *obj, Visitor *v, const char *name,
     *field = value;
 }
 
-static void property_get_uint32_ptr(Object *obj, Visitor *v, const char *name,
-                                    void *opaque, Error **errp)
-{
-    uint32_t value = *(uint32_t *)opaque;
-    visit_type_uint32(v, name, &value, errp);
-}
-
 static void property_set_uint32_ptr(Object *obj, Visitor *v, const char *name,
                                     void *opaque, Error **errp)
 {
@@ -2721,13 +2715,6 @@ static void property_set_uint32_ptr(Object *obj, Visitor *v, const char *name,
     *field = value;
 }
 
-static void property_get_uint64_ptr(Object *obj, Visitor *v, const char *name,
-                                    void *opaque, Error **errp)
-{
-    uint64_t value = *(uint64_t *)opaque;
-    visit_type_uint64(v, name, &value, errp);
-}
-
 static void property_set_uint64_ptr(Object *obj, Visitor *v, const char *name,
                                     void *opaque, Error **errp)
 {
-- 
2.43.0


