Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C209DCD484D
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2026 16:31:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMTWl-0005a2-7K; Mon, 11 May 2026 12:30:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1wMTW4-0005Qd-4E
 for qemu-devel@nongnu.org; Mon, 11 May 2026 12:30:02 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1wMTW1-0004WI-45
 for qemu-devel@nongnu.org; Mon, 11 May 2026 12:29:59 -0400
Received: from pps.filterd (m0127839.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64BFuivx1958268; Mon, 11 May 2026 09:29:53 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=proofpoint20171006; bh=cTs3bc0nWcICnL/
 F/lE9xe49l4HHSov8DhSIFUa5Olc=; b=hWMIkD+bE949jF/KbCPS1/zJn1VVwGR
 qIbZ68NvXhWjgxyoCaEHlYW8YtqdNCxagK39tXgSeQ/E0/5+rCvfn+UXqgWBM99S
 VU+y0Dr16W0C9pDCQsMZe7ej2a9l57QCl8K7uLUkbI3y0Rp+0rHfBFofnobCek4l
 XgRANnrdx1JFKoKzmN2DBHw4DWycsoGB0/+y6saWWLLrblPelQGgtzsBSjRwDRhm
 f+6yh4uS7d6zFSbF5fBDiK0dho1H/JmaXcvshrTIKM8OAF/H2sx95Mp2OGrbsyj0
 ureKzIxpWeul75gk8P4g8WOUIe//qYUQFC4b9QmKRGUOULFc32kwrnQ==
Received: from sj2pr03cu001.outbound.protection.outlook.com
 (mail-westusazon11022085.outbound.protection.outlook.com [52.101.43.85])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4e240cc1h6-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 11 May 2026 09:29:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FCYNbPBxz6KuJfRLNygQikdzkusdKHfG6QG8N38JTnRFY4/YG0MhCP+FWZ9bY30LVjKP/w9eClnRlHsMVDKyyLPLc+GLQyNa+ncFN6c66+BO14e/w2HoH0YoxpLQKqNP5lUlJWiFFdfj1RC+WYVtsITagYN4rFYRK4uHKFO1pLl5ruaby5BB2ezU77Myeb2hL2y0w3gXMk7mr0Hk6YOcuTWBxVP0sWL6TWx4g3xEU7/gdKJm+4epbVTavQXN3MtVCwYnGYOuvjtOI+kONct0bYvUV8sY33vCTgjETa2/IZy4ahQRgdIiBOZYLQsKGvcoXtXaRgQn7H2wW87TBHqQ9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cTs3bc0nWcICnL/F/lE9xe49l4HHSov8DhSIFUa5Olc=;
 b=KMmdp4BzAzDCc2oSWCDXHkI/74P5U70E1JoBBb+txgrhr8Lsr0eCyuraKhsUcKiJ7siEjmGfSWEVD94T3hJpEBA+FqG4l/yXelYIM0R7K/OLHgYQPieuEE4hhdI/rauKyq120tVT465gUFzkwZzKPHKk4W8FsO1PLJfQ57VwmzA5C2AdLQBuNQ42ADX5kjDzxijYOIpJJOsghAFn+ntpXsri+B+KeR00XCfEldGr/jIRk0devNCm7PpiANwJu5HYL3dSe+igHHQfESb06g+4bfaFPJN2hry8jell9+YVjA9aFzHcHIUdjcriSwmCsbDdD5l/mI7vQ/syh+O05g+URA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cTs3bc0nWcICnL/F/lE9xe49l4HHSov8DhSIFUa5Olc=;
 b=lJxngxt4aySmUN/KAAlpHLJuUsUftLqpM2E0LA6wQ8rvbPSXDGVdq3Tj02v1S5jWPqqPz+pCx/T0taAgeOKkAVC2YH+NeQH0EFXGY2uKKsuvfxlVQygMfQSZOM1ICN6pE5I4bg/vOKJHowUtn/OmWrdQW0eM7zn6dP/pCRISbspZzoqlNRzTgyqBLK7W81eaRQs8LRuMrANCm+EsPthTVJ7De6MtBuvAISgb942ZSDcBz1WQC8F8FB77AN2Oqzuz+J0MlslG2qSai6FZ/xCsNhWEm0MfL792j+s/ruz4JlHxomDn2dCfKdk7TQLqnvk0muMJcmIZzFDXGSKi2lOCEg==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by DS0PR02MB10919.namprd02.prod.outlook.com (2603:10b6:8:296::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.23; Mon, 11 May
 2026 16:29:52 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::dbc1:9766:c58d:4887]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::dbc1:9766:c58d:4887%6]) with mapi id 15.20.9891.021; Mon, 11 May 2026
 16:29:51 +0000
Date: Mon, 11 May 2026 17:25:54 +0100
From: John Levon <john.levon@nutanix.com>
To: Jag Raman <jag.raman@oracle.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 "clg@redhat.com" <clg@redhat.com>
Subject: Re: [PATCH] Mark Multi-Process QEMU as Orphaned
Message-ID: <agIDElJbbToE4jWj@lent>
References: <20260508102657.644247-1-john.levon@nutanix.com>
 <IA4PR10MB8301FE3A10AA391212B387EE903D2@IA4PR10MB8301.namprd10.prod.outlook.com>
 <af3zEgHy7UMYN4Ow@lent>
 <IA4PR10MB83013C640DBB740BE8872FE4903D2@IA4PR10MB8301.namprd10.prod.outlook.com>
 <af31Oo6gXE69c7eb@lent>
 <d7c29d61-9146-4cf8-83f7-e650572b338b@oracle.com>
 <af3_CqQf1wSSWYYY@lent>
 <88BAE7FA-7DAB-4372-8710-C45E98178EBA@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <88BAE7FA-7DAB-4372-8710-C45E98178EBA@oracle.com>
X-Url: http://www.movementarian.org/
X-ClientProxiedBy: LO6P123CA0039.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:2fe::19) To CH2PR02MB6760.namprd02.prod.outlook.com
 (2603:10b6:610:7f::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR02MB6760:EE_|DS0PR02MB10919:EE_
X-MS-Office365-Filtering-Correlation-Id: ec1a3881-e56d-471d-b073-08deaf7a86cc
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|18002099003|22082099003|56012099003|3023799003;
X-Microsoft-Antispam-Message-Info: vUMWR6zIcYx2FltPkeckXAC4Oi/n71vp7hQk2aqvtHxZ0FWalvRYftEfJEXBEIB7MkduufQj0CrjQSCZxC6iEwLCE7t75atYonxoNP2IjPQ9ibBB0zZlXA5A4Nvk3/nxqHmLnyn3icRCvzFYdtCxropZQH0GN/1jyxy4FuJxexGqZFG6fnH/PFmeMFdFujQtsqJ5jqhmlr66VffZKtPodUU3wMU+silBi30t+qbEu48pFYczk7McU6cHVN+0TG5B84lgzw7SjuwwZm/hmwiNbV/6MOPkZrJI63z4lY4sYm4YoboniYuEwL6xArkHpC+UdolKVJjYP5RxN/81ekzphRTgPpSCD28NwyDEGseSag/8k/MdA4Q5VPJ3liAl2npIuqj+Jh42mLx7P1aqzr7k/wjWn2PXS3ID1RcxPpkbYHyqZuBF7DRxWv9COJS6gPUyhR2Lmr5SmoLKrfjJe6qwiN06WFlcPVv46OiJEdE/Ovpbo7Ksu6fJFKVdWd763kj27slenOqPEV2+8ptf2B430k2ffEetYfHGT4jDPivr7EiuDy8dRJVMR47knczc2qHgFQkf9qIOZ5htingLPwBDTp1fC4EBjAjOqjRnDNQd/GfQ2qp3lgqRQDqT6aWkgYxAKhgaYQ+2Cbcz9/LeB9s5tAfUef3WPzFawiSuZtclxHC6lRnpvT3tUBwAUxXiFbqk
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(18002099003)(22082099003)(56012099003)(3023799003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZmKLNC+x2kRSzbkIBApzlOEpSL7tDQDI/b9iGx6O5LxIfOuXWSN/IMc1eCly?=
 =?us-ascii?Q?NP2LdRFnpnypeh2Z4ZbYgje9h/wcnwkXbSfJS8BsLBpP9PXsJBXOrUXkXPLA?=
 =?us-ascii?Q?+u3lpdWQmp5NiF3QTuK9ZABmfF5OTYEqcLuPdKqSkoP1Yok0ttxMXwVoNqnM?=
 =?us-ascii?Q?vCx82WgyGX+DJxG2sfkfHgcb3E6LXYzwZhKjTFZRkor0JaUF/h73po9S5RQ7?=
 =?us-ascii?Q?KKxJnDM/KpfVy8SGgrqQW00hgaWHQYayxMfFS4ARnW3Jzvao2hd/aqEU5KVq?=
 =?us-ascii?Q?MoAGjaTCMAYZmFUO3E/aWXczQ4EYI3DbEEvlRQo6DQKgCWjQ3f7zfmI2jIE4?=
 =?us-ascii?Q?EsDyH92NzGyAvxJnA1TDxmTIF5sE3pLSwcgNLTN0T2HqGnD7+Cb/ZHuCXRWE?=
 =?us-ascii?Q?USRG2b68RtLS/BMNd4d2fQOOEYZAJcRcS4WNjciJZDmzE8aM8uOR3rGvyS1t?=
 =?us-ascii?Q?K4ImOcvUlAi0qcFvdz+3kv5gJZ/LAPNYKK7nH92PgCivKveM7gHcK2LEE03S?=
 =?us-ascii?Q?jcuPpU1jRYtqfd6fy8KudThtXpESdK5UugtlH9nOwQWahyQUmr2YUzAN5F9D?=
 =?us-ascii?Q?CgNlymwwIgxOn/gIoPYIOWWfibmAG2BoEiw2DBG5Mw3oZstEizWAvyqkaYM6?=
 =?us-ascii?Q?csNWEEgya9TG0zbxmridHV4Pxoe8N4uD/mgJOoxMSCXMpPF0wKiil2MbF9TY?=
 =?us-ascii?Q?+eVLY7dhleROtoKfvBBLfvDASIrLF1LvNUa4P4yZYaJOeiOjlLQyHqEitkWs?=
 =?us-ascii?Q?6WBn0aTdNM2wacrVUzUoXMK9K523o3InPxR3ZeUzfHUdo0e86k30/VPcTUSM?=
 =?us-ascii?Q?zgyGe3ZP1VkKIB3ia22a3q2xJUaaoeMsdIDv52pKMwrGmWgR8argiCEQ3wZF?=
 =?us-ascii?Q?hlXFAxaih20CSUFbe1foplTUDuiLFY/1iKCGPINcJ/j8qoxGoikZEoZVY9M0?=
 =?us-ascii?Q?T1zHRC2oeXgHTGohlCuqjg5FyyRGjZy51NoRiC0OQ9+zJT0av5eqVeI1ixNq?=
 =?us-ascii?Q?7V1vJMymChS3o4FfcacG+BR+/LQbqO8Ke/1bVat3r8ku4RGy4vGxSk7xiY76?=
 =?us-ascii?Q?8EP++BlFtHLnQwWxsnzuC9WOG7T5vdTFgMUl9gly1RgFLVZAjx1/zKzyGb/K?=
 =?us-ascii?Q?N0NBoz4fW1w75kbpI27us44A73cAQ626Cr5UQf2wqw2WDHQhemm2MkyoPO0Z?=
 =?us-ascii?Q?rW0jdahW8SFALpNeLUANBCbtU2j5/2G2tpM83C/+30QLNdwlxmDTmH2Va+yt?=
 =?us-ascii?Q?XRlWv68cKX24R8eRWQzKbfmqI5UxwbqOSisR+8FGzw+O5+fwrDGH8i9yFlpc?=
 =?us-ascii?Q?FF/9DMMyKobv5heiTjogIhry8/jB0i5MvHLmSJKyCervqu6jwhm6dMKo/5gR?=
 =?us-ascii?Q?GCvuShMN/gw/y90fap2t+QyFsbmwpxzkZb65Xt6+Bf2dOAGdOhzC09dSGRnB?=
 =?us-ascii?Q?z7r4GwekuCnGyvDlqMpdPoxN1tvXQA9JQ9i6lvSZ52fSFEPJZc6Rkx4ma2j3?=
 =?us-ascii?Q?eWntxCl3DVVzuYpzixQNL2IoGWM85AwKdyiS9H9CGEfQ+4/NmX6zrFMUt3uj?=
 =?us-ascii?Q?sK0vPvG0OKZrlysgETpV0rODpaFSONqUOyAMIIo6AYDugdq1xAgFcCRun6ug?=
 =?us-ascii?Q?RPyEdpVdtWFBjkC5w05TqUOUk0u9ZMfdwvL3sY9j7/FxE4tQm+WVBhU6GqRI?=
 =?us-ascii?Q?zrnDnv0bsPOjoy4KmXjlNPCg18mjEGa6fsCknL0ukUJjfKh4TffNLjlJgdnD?=
 =?us-ascii?Q?kYRpKgqbAA=3D=3D?=
X-Exchange-RoutingPolicyChecked: QxV6B7OHZ3yzbWx6YQ9OypqUAkBZfINu7tNITkGKtSdKWdKSGMRPD6UZafMQW2IfMLr7xxFAgrS49vXGIn5VJ1TjHG4VvteLkdHXqkou3wrSHesAcsGbJrWY+DDlpHJ9oJu4GXQhr1QVMMjmQaemQOIveOI6zDKs0uM6Nz/17vpZkAuH3UFnkHBmwAVBC4FX+nlQB2310FEQUlfkjAKYvneNSaEdRpuukPPkKV51cC3Pr+SWMRq3ksFX9t1AsKF5/aBsGvHC1kFg9cQoK+f0DEogM3Fg+zZ/Krv72pirT3BHDA2LzS9Sut8QTd13yKFPXI9c6ECFesyOxSAwe95PFQ==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec1a3881-e56d-471d-b073-08deaf7a86cc
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2026 16:29:51.7701 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B4GMBbQsSbOuHgAu7+OWsEDUnJd/Cv6lCs/LhCgZZT8yzB6wrXVJCUzutskbNpgspRmQLuG8g5/s/pRgs7qDjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR02MB10919
X-Proofpoint-ORIG-GUID: GF-qAfcJmgv2bnnLjNrHXVoiMYfDVkl-
X-Authority-Analysis: v=2.4 cv=OZmoyBTY c=1 sm=1 tr=0 ts=6a020400 cx=c_pps
 a=X1VVRxfiHTEfX2nbyi9Czg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=NGcC8JguVDcA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=y4UcunY2MAxhM4LwGdWI:22
 a=MII3tekdlR--kfO7ryEA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: GF-qAfcJmgv2bnnLjNrHXVoiMYfDVkl-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTExMDE3NiBTYWx0ZWRfX/ImzCgtL5YMA
 KIVIJaqbBS1my60DtsWzsw41Uus1vu3SERbRIavWKJNFOsVsJE0/TC2rRNvulIFGMeh/gbaU7MR
 CNu0KM22Z6qY45vDyZXStEgF5rlFVs1pYrkNg7/61CmfheopgvEaA0xqQvb6SWW2jkM+IdztzIm
 t3or/bCCkLoj0NI/FioVv/LKUAyfRntbvbA7pJISwcJUQ5dwY/jPsZ0iExqoofqEjHGWLD9gZbY
 SwbfDxRr1RPZetWJSbDXuT2jaBM7lT961E+C6/Fd/4F9VYMR8bKbfW6SvIHAd0E/3IHHppvnOSB
 1L6vZHKV/a62RYeZky+iWQkGVGK2sTMuRFj6PY4pSe+KCWEv92kcjTDxPTYYJ7SEbgGxGLe5tu2
 P78a9nlXI7DeyrK25iwi63BK8zOL63jRugggeq9yzU4O3ftFQPPIUcvECuV0DL36cFlc7o2zcSk
 CrC6jMr4C8O/2e1dZlw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_04,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=john.levon@nutanix.com; helo=mx0a-002c1b01.pphosted.com
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

On Mon, May 11, 2026 at 04:15:14PM +0000, Jag Raman wrote:

> > Confused by this comment, as we've discussed before several times that you were
> > going to migrate the testing across to vfio-user instead of the legacy protocol,
> > then remove the legacy protocol altogether.
> 
> John, just to double-check, we want the functional test to use the vfio-user client
> and use the x-remote object as the remote server, is that correct?

-machine x-remote,vfio-user=on

I think, which is what uses vfio-user between the two qemu instead of the
MPQEMU_* messages etc, right?

Then we can at some point look at retiring the non-vfio-user implementation.

thanks
john

