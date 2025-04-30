Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9891C369D9
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Apr 2025 19:42:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uADIh-000866-W2; Wed, 30 Apr 2025 15:41:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uADIe-00081Y-Ia; Wed, 30 Apr 2025 15:40:57 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uADIc-0006Eu-Ib; Wed, 30 Apr 2025 15:40:56 -0400
Received: from pps.filterd (m0127840.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53UJaWv3001285;
 Wed, 30 Apr 2025 12:40:50 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=h+Uj8iE7DGovWgXv7Wf5Nlgs7XnUqdRkOql7LB3pH
 HA=; b=dmS3AmFGhI6/iVYC04a5CAmrAEGW82rg6N1r+PrpvbCq9M2x6JJSkbjjt
 Lp6VpC/NsqMgb8Kji7hvsAhJ9XnqPx+hCyohlZlZfEZdvaWvGWxdP7s3/6OvS5cl
 SWejYoiS1KfUNW8Hr6/Q6L/X/mz1kzw+tmb1De6WfQKpE3vHMH9oPFNOTKyF6BAp
 DNcyaBT2H2hQ6IgCnfrlioD/jemeDEWj09MPPlg9VpsMc5J4wndVd3ThVvv8Wwd+
 eeV7R9UQ9myWC4xVIRv0UFTapQYhMYQPu1vP2aMcgnYy7y5jTZ6UD9rvGLVZTAr1
 lItVo9ZbXwnXuBiZwrTZcg8v6CKeA==
Received: from byapr05cu005.outbound.protection.outlook.com
 (mail-westusazlp17010002.outbound.protection.outlook.com [40.93.1.2])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 468utu9tqv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 30 Apr 2025 12:40:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Aa9rvmpSqidOJi8Oe+0cx3mkjhSr/fNSLPndcs3+ZQq9P63pMf8NNU4sflyPasgtEgAjZcAb9d4HKBooG057Knd3r274ITtdoSGzW4J7IYrnFl182zJl+dSAENOGzKoozgHnaSa85Pk6VnrHKt1Bw83my8Z3IOniuctK+RLWrM523KSMvTFzw6Ksc1ajy62Fvhv4IM24A0KwO+jpm1w2PEkzh7BA53006vliiGv3OkX2E65TtkL4HyQSwvJxNCZgX+/QWp+oYlzi6+GH2Kk9zaqHA8n3yQw0EiftQNtTun0/ugYKZHWOqs1tvqrw/3q+i1Un9zZMv4BAjIth1nuqhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h+Uj8iE7DGovWgXv7Wf5Nlgs7XnUqdRkOql7LB3pHHA=;
 b=XiZwxNWdqQnv9gjp0j0FzYXRrUxqx6pwEUXLjwaeTegOTDrd3GjdaWjSaCxBar24dDVoxywc57EZBjlp3PZVlMfs6hvnVTfF0Ru9o8NfWNnrTE1qHXsWJGQawiOeud2O55xlEqECTnV4NZw2HesKnwNnnF4e47vOG7hkW7E324SBtHe6Emna9DWpbvUSrN1JYGgV2djRBMwW12d3bHiHFaQDDfhcLqNBWuAt60YxCvwrIpMXMbdF6R6b4HD7KkdqCmu1INnXmeflM2NEk6E2t99khSP96aLz/XHhrpEsywXgPGMUtoSoa8iKTAEL0NyrK3S9KTewWZ+g9StIN3fO8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h+Uj8iE7DGovWgXv7Wf5Nlgs7XnUqdRkOql7LB3pHHA=;
 b=dQLMZ+tzX32msMfpLGRncmjv3+0cre45rIyQUKVdDhO2J4m0WY96wcoY6rhxKKPJUYHyZsn8glpKWhI0QpnFeF4UN0erBKHvOss4k9KFypnStLMK/k+GCi/tQ1B1Wnu2F1vMbxxySPefL+84rkemTEaJqL8sgdv+Hqfd5rlyz6UJJZuDyIVXIaIOq8Z7v2eyhVDbgRwY5XazRFYBS3lTLw+prRCeMoFIxWZlDmlTWKR9RWM/+wJenGLIBecZ+gPX18b7WTauJSo/gB6m8qhVD9Co9xmUQgOb33nbXBL21WRJGg/JGu1fz12Vv0o5LsGP3FzF+y04LmU95ej58ZsxjQ==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by CH3PR02MB9931.namprd02.prod.outlook.com (2603:10b6:610:177::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.9; Wed, 30 Apr
 2025 19:40:48 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51%6]) with mapi id 15.20.8699.012; Wed, 30 Apr 2025
 19:40:48 +0000
From: John Levon <john.levon@nutanix.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, qemu-s390x@nongnu.org,
 Jason Herne <jjherne@linux.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Tomita Moeko <tomitamoeko@gmail.com>,
 Markus Armbruster <armbru@redhat.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Tony Krowiak <akrowiak@linux.ibm.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>, John Levon <john.levon@nutanix.com>
Subject: [PATCH v2 12/15] vfio: add read/write to device IO ops vector
Date: Wed, 30 Apr 2025 20:40:00 +0100
Message-ID: <20250430194003.2793823-13-john.levon@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250430194003.2793823-1-john.levon@nutanix.com>
References: <20250430194003.2793823-1-john.levon@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM8P189CA0029.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:218::34) To CH2PR02MB6760.namprd02.prod.outlook.com
 (2603:10b6:610:7f::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR02MB6760:EE_|CH3PR02MB9931:EE_
X-MS-Office365-Filtering-Correlation-Id: 7be3e002-0123-48e6-785e-08dd881ee80d
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?PPvninh4zk5zsmUcJ0q6iTj8YVtWl9xLfJLjdpfekSzFmaLnjnYWniR/E7Fb?=
 =?us-ascii?Q?oI4099bUfXknnr0gUKzd1S8RSt0ANUxp9tOt42RVFobCAxmDBJem4q4cdmkj?=
 =?us-ascii?Q?jx4ECiN2KOHRAiIYpxfqkBvknAp75OAHE+TsKdVXqXfdgQrhMB+11uXFzo7+?=
 =?us-ascii?Q?rAmD7MhX4nfP/792Cfh59fkpX0bI/hdGhHZTIvkA27hgxYHhvlZUg687QIrP?=
 =?us-ascii?Q?SM17QVYoCf116MvKP3rt1M9OwN3iY9+q2UsQ8HN3uimBM5m5VZKolCUPGCBP?=
 =?us-ascii?Q?MrASwDy+RtXzLgvpG56Dxxss8xStAQD4fm2iNELMPs9QgnGifT3dwCaNOmgR?=
 =?us-ascii?Q?jeR7wha2nQqG9BvsqMxTcoljdHb+qMrJ19CVZ54pUFuAt9rmRZIL/oxaukDE?=
 =?us-ascii?Q?IaBsAWxPj/c/cufRZloERv1UIpLGQrcW/nuwMW9dEZ9nq+h8Km9IrVqulJth?=
 =?us-ascii?Q?Phptq6piwCMdZ4OgBSeEvvYmtPBuMPmaXtZJrpHrPxz2mvcCvfW6t2tlUjz9?=
 =?us-ascii?Q?zWs8AQS7TPcs8R/Y/wmKM8rRcyzjvsCjDMBd1Tq3biSD2GfnCkKboKh7IziV?=
 =?us-ascii?Q?hpJZf0IWlOqjLeUgA71zsb3kVDjsmHm11UaV5wG+0i0OaMRfAv0QUkgpAlT8?=
 =?us-ascii?Q?oEEveRJvVEgQMOJTcSs/mNVZeWnRE0zmDiT3bWEiNGHx8jBkJqa6elqSeboE?=
 =?us-ascii?Q?5egFOeSOECYSFSxVi7ft8kPKRlvdPeT150EQjm/qOqOk36VRimzccMEqont4?=
 =?us-ascii?Q?2UhEmZGDQiG0J4ueWoVhnXRQT26VUBq0VAcCpQbuBWfRbYGRL60hHdZzDDFT?=
 =?us-ascii?Q?USSfyfOJCwK1yAWVFZHNCSqluYwK+Bo84js8dPwx0czCEq8oNzCi2+HEbMqG?=
 =?us-ascii?Q?dTiC6YPnFpGSE+bSoOZGBCRVLFk1WubkEWdjheafeRiE/sBqVdZcirzQf+A6?=
 =?us-ascii?Q?fdYfaAih2QvKRsjSuoy8eA0e3LuE6lm+gg9aOPVNP4B4YnC+2VDlNUSTQKtN?=
 =?us-ascii?Q?surFfvKw1UvrwTtvvlGS5jmY+FpeI4MrMoLhgzAsnkIUxEl6FmCIJvGAd6T+?=
 =?us-ascii?Q?G/PbcjRg0bQ8PX9WLzEITPpMolqI5ME1jvuTmggY4XNKAanhxpQoitha52Jy?=
 =?us-ascii?Q?gNeziZeI1CoK81oPwZnc7SrOTL2oE8mbdlf+frB6q2Y3yTuKKJTLqxwW9oCE?=
 =?us-ascii?Q?HUUjAwskOToZva13IeZPAS3KIUjGBMOjq2mbseZR8vqayMJFWFjIFwqpRVcQ?=
 =?us-ascii?Q?e+fD4Ykip7WJQx6DkSetTxi4urTUmBuOaiOikDXb07GtLYn2If5cdjHSqzC8?=
 =?us-ascii?Q?m07xeDxTCuUdA2ZNWUUYmlz5GX2hHQqlIlwokbXDsIPZQJr8ClAcAWGX7882?=
 =?us-ascii?Q?dqHhIRizI5LTJIqyiZDjF8oGbLv6RNUqqmLwR2tiYXlJ8pUqp/XS72wcjnTs?=
 =?us-ascii?Q?ttRrAtnuCoA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(1800799024); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Mb8z7Bso+r8+a1KvmJHYUu2RMjka3gQHGOo9Js093UMddxojT04QAnpYKaoT?=
 =?us-ascii?Q?vA9pICDkz3mjt/TGAvQXnIjYaxlA26NEHKcDs7brOaXlWkHuhFuKbY4739Dz?=
 =?us-ascii?Q?WHgFT65fx5ysz5DUmELa4dP+whHc5jJqwALDwXavMz9HyzbiH7ziCPktHG2s?=
 =?us-ascii?Q?oYffY8YU3l7QXXjPh0ytUqFeuPtqCyH78FPvG3YOr+YeYkstxEqgMfr9olAx?=
 =?us-ascii?Q?7/BVn2usXJuNijC9UTdrLh3s3fv21zsWVIB/op/zIo3KXNvy+KGFXJK3cE90?=
 =?us-ascii?Q?rWBUCHY7OumJghHTzC9ocJUdmexo5Atu+gBAC9SVDy+VYYJKHHWaZ1jxBaFo?=
 =?us-ascii?Q?JYq4BMvx0vHUvkncJY525xQhBplgTo2rEDBO9hd43dDa3IcfYB8W+vpzfA41?=
 =?us-ascii?Q?rgnnreEbSs0H59S6K1+vUV+Lmvbz71HvsGwCae9vatqAv9nuTvCyUCTeSP71?=
 =?us-ascii?Q?GoRBlcbj+YeRACeAYfEDBgssv71e2SnT1ItiN3W5kJHORSCK+H4JEvOcaEL4?=
 =?us-ascii?Q?94qJIV+Tm6yvb1bkUCg1VEFfJSXdGe0fok07AaVX64UCOw7xIVWZ5s7zYUzw?=
 =?us-ascii?Q?83qTPgAYsboOz9NJSS0P2Aq2TMyGc8FG4GvrRjlsXwdxL62LSj6Q72tN5IoU?=
 =?us-ascii?Q?gW03Dv4ywOyxZHzh+OqWPPwnkmTCuJN3KaUp1eN0l8vJ1YS3VgHEseksPRav?=
 =?us-ascii?Q?mrZPgqKNglvvXkaJ55NY8JJWDrr0mTnc+DGkcFFzUk5KOV73R+EW66mQBsWo?=
 =?us-ascii?Q?Oe86Qta+tmdmLxj5gc1E7OQ+dG5E017mxHBaiVUcSfO/aoc0DUa9pz26oQRs?=
 =?us-ascii?Q?HTaTk0S+08+U9TLMLz3lRYX+5dBAEBu+h0iVBdZbGdi+T2RQfRPMehf5mGdl?=
 =?us-ascii?Q?WGbDw5sabYIVtRdowHO/LtgYRrfbyozouNEnT43glD3kq4THRibZkUZaL/4o?=
 =?us-ascii?Q?X6/+wOABy/uCULKRsYHrc4/XZHlab4SZrjpbj4kp93jmC/Ld0Fxp7navl61R?=
 =?us-ascii?Q?Twm+7Foico7AZvpC9HfbewmvvkQ+Ut0iXEDMyUnJd1JnPSDu0fvt2HFgEKNm?=
 =?us-ascii?Q?2wbDs/F+TChoguyloB/vzdJk3MtGRhDzeEhy2uQ3hSeJbv2tQp2IcxOV5yk3?=
 =?us-ascii?Q?nQhxyzYSuKGl4toZmNyYOKUxpsUT6CyL7NDG1x/SCDVW6bTlFEL/I64YOTLY?=
 =?us-ascii?Q?wP10EjvBj2UfuQhfwpBuPmBZSNER4ihHyOaSstNLVnP2ccGmbBE4YHXtIKKq?=
 =?us-ascii?Q?ik2fGjv9c3uFKkVmgHRFf/fMtXNsU83gRQKLxvRBwQsTDC3eAc/Gdfd2zV8T?=
 =?us-ascii?Q?S506ijounKs2IyNtfLpG9RO6WCg01Y2UIAJ0Lm51UIxkbSIgTIt9Lh3/2Tdm?=
 =?us-ascii?Q?i5HaLOpo4gDaPrU9baPTJqN/GS4PicoVns70G03/YTPvOEY1u1BeSCpbYUl1?=
 =?us-ascii?Q?/q4WNIfC68GEkn8/8KmRFYloqNZyErzfiBOw6wnY4azrTkStk0IZHs/zdGDB?=
 =?us-ascii?Q?Cs6+DWwqOAAi17uelJAEVvl/wjpHJKwe/gyQVbuuAV8/uOnBFCA34UJ0mZQe?=
 =?us-ascii?Q?e4hDU9R/boTXvVHXO+UuwzKCPH8dbQMcUotLlWU2?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7be3e002-0123-48e6-785e-08dd881ee80d
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2025 19:40:48.1869 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D0Jpvc/2Otr5vcfHN9c8PhQAoY5RyFq8HyjpgjSIlaa8rqcradrOf2DzgVo2/Z0SDsifhs9HbM4Jrh14nlLABg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR02MB9931
X-Proofpoint-GUID: 81fFr-B8r6Rj1y11-bDc27oCnoVsvRbU
X-Authority-Analysis: v=2.4 cv=GcIXnRXL c=1 sm=1 tr=0 ts=68127cc1 cx=c_pps
 a=Ku5Q1SXtyGRHaGBacwLxwg==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=XR8D0OoHHMoA:10
 a=0kUYKlekyDsA:10 a=YUCnVxA6LD9_ozL8f6kA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDMwMDE0NCBTYWx0ZWRfX8fqifdIdHaSO
 YaOCMrG0K/rs1N9Lvkk3iIlOhJZSn1A9FOZdi7/yW8n1nusvFEvjiNjgPU3d5kL0jTln8Jwp3hj
 ykr1iKzKX5fcO8wbEMlbPpA+SiXvqONM5PY9tW53O8olpbxUPiBqMOk0y/Cirt0GWJScXQtoeHQ
 Squ84+wSy1puMr91Oi1dfz7kqfKYavYanqhKRHH5QJT5IGvEB+18j3CfrhQey0ntvUf265CtcJp
 jPkRugKusWvo8AiGFRNPEJ9IWjLXaBbQRKh6fHXNfmdRrhNCQMM4Em7Nw+OYEfgBYVpOcmzgLYS
 GqZEuvDYUl79Z7dvNpg8qnRLmte+m2ChR94nvmPOiC3TyFcn2xSR16Z/NAwx50FsgV2f1oXE5oF
 uuXlG2Xi50DEwzzFhPARXFh5h+TcYn0Dj20aotv09LYYwYexXAItGkoHB+GV/aREa0VgOks0
X-Proofpoint-ORIG-GUID: 81fFr-B8r6Rj1y11-bDc27oCnoVsvRbU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-30_06,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=john.levon@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.483,
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

Now we have the region info cache, add ->region_read/write device I/O
operations instead of explicit pread()/pwrite() system calls.
---
 hw/vfio/device.c              | 38 +++++++++++++++++++++++++++++++++++
 hw/vfio/pci.c                 | 28 +++++++++++++-------------
 hw/vfio/region.c              | 17 ++++++++++------
 include/hw/vfio/vfio-device.h | 18 +++++++++++++++++
 4 files changed, 81 insertions(+), 20 deletions(-)

diff --git a/hw/vfio/device.c b/hw/vfio/device.c
index d08c0ab536..ceb7bbebda 100644
--- a/hw/vfio/device.c
+++ b/hw/vfio/device.c
@@ -510,9 +510,47 @@ static int vfio_device_io_set_irqs(VFIODevice *vbasedev,
     return ret < 0 ? -errno : ret;
 }
 
+static int vfio_device_io_region_read(VFIODevice *vbasedev, uint8_t index,
+                                      off_t off, uint32_t size, void *data)
+{
+    struct vfio_region_info *info = vbasedev->reginfo[index];
+    int ret;
+
+    if (info == NULL) {
+        ret = vfio_device_get_region_info(vbasedev, index, &info);
+        if (ret != 0) {
+            return ret;
+        }
+    }
+
+    ret = pread(vbasedev->fd, data, size, info->offset + off);
+
+    return ret < 0 ? -errno : ret;
+}
+
+static int vfio_device_io_region_write(VFIODevice *vbasedev, uint8_t index,
+                                       off_t off, uint32_t size, void *data)
+{
+    struct vfio_region_info *info = vbasedev->reginfo[index];
+    int ret;
+
+    if (info == NULL) {
+        ret = vfio_device_get_region_info(vbasedev, index, &info);
+        if (ret != 0) {
+            return ret;
+        }
+    }
+
+    ret = pwrite(vbasedev->fd, data, size, info->offset + off);
+
+    return ret < 0 ? -errno : ret;
+}
+
 static VFIODeviceIOOps vfio_device_io_ops_ioctl = {
     .device_feature = vfio_device_io_device_feature,
     .get_region_info = vfio_device_io_get_region_info,
     .get_irq_info = vfio_device_io_get_irq_info,
     .set_irqs = vfio_device_io_set_irqs,
+    .region_read = vfio_device_io_region_read,
+    .region_write = vfio_device_io_region_write,
 };
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 1aeb4d91d2..5e811d5d6a 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -918,18 +918,22 @@ static void vfio_pci_load_rom(VFIOPCIDevice *vdev)
     memset(vdev->rom, 0xff, size);
 
     while (size) {
-        bytes = pread(vbasedev->fd, vdev->rom + off,
-                      size, vdev->rom_offset + off);
+        bytes = vbasedev->io_ops->region_read(vbasedev,
+                                              VFIO_PCI_ROM_REGION_INDEX,
+                                              off, size, vdev->rom + off);
+
         if (bytes == 0) {
             break;
         } else if (bytes > 0) {
             off += bytes;
             size -= bytes;
         } else {
-            if (errno == EINTR || errno == EAGAIN) {
+            if (bytes == -EINTR || bytes == -EAGAIN) {
                 continue;
             }
-            error_report("vfio: Error reading device ROM: %m");
+            error_report("vfio: Error reading device ROM: %s",
+                         strreaderror(bytes));
+
             break;
         }
     }
@@ -969,22 +973,18 @@ static void vfio_pci_load_rom(VFIOPCIDevice *vdev)
 static int vfio_pci_config_space_read(VFIOPCIDevice *vdev, off_t offset,
                                       uint32_t size, void *data)
 {
-    ssize_t ret;
-
-    ret = pread(vdev->vbasedev.fd, data, size, vdev->config_offset + offset);
-
-    return ret < 0 ? -errno : (int)ret;
+    return vdev->vbasedev.io_ops->region_read(&vdev->vbasedev,
+                                              VFIO_PCI_CONFIG_REGION_INDEX,
+                                              offset, size, data);
 }
 
 /* "Raw" write of underlying config space. */
 static int vfio_pci_config_space_write(VFIOPCIDevice *vdev, off_t offset,
                                        uint32_t size, void *data)
 {
-    ssize_t ret;
-
-    ret = pwrite(vdev->vbasedev.fd, data, size, vdev->config_offset + offset);
-
-    return ret < 0 ? -errno : (int)ret;
+    return vdev->vbasedev.io_ops->region_write(&vdev->vbasedev,
+                                               VFIO_PCI_CONFIG_REGION_INDEX,
+                                               offset, size, data);
 }
 
 static uint64_t vfio_rom_read(void *opaque, hwaddr addr, unsigned size)
diff --git a/hw/vfio/region.c b/hw/vfio/region.c
index ef2630cac3..34752c3f65 100644
--- a/hw/vfio/region.c
+++ b/hw/vfio/region.c
@@ -45,6 +45,7 @@ void vfio_region_write(void *opaque, hwaddr addr,
         uint32_t dword;
         uint64_t qword;
     } buf;
+    int ret;
 
     switch (size) {
     case 1:
@@ -64,11 +65,13 @@ void vfio_region_write(void *opaque, hwaddr addr,
         break;
     }
 
-    if (pwrite(vbasedev->fd, &buf, size, region->fd_offset + addr) != size) {
+    ret = vbasedev->io_ops->region_write(vbasedev, region->nr,
+                                         addr, size, &buf);
+    if (ret != size) {
         error_report("%s(%s:region%d+0x%"HWADDR_PRIx", 0x%"PRIx64
-                     ",%d) failed: %m",
+                     ",%d) failed: %s",
                      __func__, vbasedev->name, region->nr,
-                     addr, data, size);
+                     addr, data, size, strwriteerror(ret));
     }
 
     trace_vfio_region_write(vbasedev->name, region->nr, addr, data, size);
@@ -96,11 +99,13 @@ uint64_t vfio_region_read(void *opaque,
         uint64_t qword;
     } buf;
     uint64_t data = 0;
+    int ret;
 
-    if (pread(vbasedev->fd, &buf, size, region->fd_offset + addr) != size) {
-        error_report("%s(%s:region%d+0x%"HWADDR_PRIx", %d) failed: %m",
+    ret = vbasedev->io_ops->region_read(vbasedev, region->nr, addr, size, &buf);
+    if (ret != size) {
+        error_report("%s(%s:region%d+0x%"HWADDR_PRIx", %d) failed: %s",
                      __func__, vbasedev->name, region->nr,
-                     addr, size);
+                     addr, size, strreaderror(ret));
         return (uint64_t)-1;
     }
     switch (size) {
diff --git a/include/hw/vfio/vfio-device.h b/include/hw/vfio/vfio-device.h
index b4a28c2a54..d3ab13ca6a 100644
--- a/include/hw/vfio/vfio-device.h
+++ b/include/hw/vfio/vfio-device.h
@@ -178,6 +178,24 @@ struct VFIODeviceIOOps {
      * Configure IRQs as defined by @irqs.
      */
     int (*set_irqs)(VFIODevice *vdev, struct vfio_irq_set *irqs);
+
+    /**
+     * @region_read
+     *
+     * Read @size bytes from the region @nr at offset @off into the buffer
+     * @data.
+     */
+    int (*region_read)(VFIODevice *vdev, uint8_t nr, off_t off, uint32_t size,
+                       void *data);
+
+    /**
+     * @region_write
+     *
+     * Write @size bytes to the region @nr at offset @off from the buffer
+     * @data.
+     */
+    int (*region_write)(VFIODevice *vdev, uint8_t nr, off_t off, uint32_t size,
+                        void *data);
 };
 
 int vfio_device_get_region_info(VFIODevice *vbasedev, int index,
-- 
2.43.0


