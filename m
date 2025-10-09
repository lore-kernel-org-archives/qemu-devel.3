Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE517CCD187
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Oct 2025 10:17:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6nfq-00022d-J7; Thu, 09 Oct 2025 06:15:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tejus.gk@nutanix.com>)
 id 1v6nfo-00021Z-DW
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 06:15:00 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tejus.gk@nutanix.com>)
 id 1v6nfj-0007hw-8d
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 06:14:59 -0400
Received: from pps.filterd (m0127841.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 5998YN1Z417137; Thu, 9 Oct 2025 03:14:49 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=xXI2a/dD/sesjm2ZdceVR0cWik4pHx5E5+bT3vjBr
 Gc=; b=ROA1mWAzM33mOGf0I1lhNWohgerPrsXdIgY7ILaLS3cNoMVICl2ZvmBTM
 92F+nd2EGPcyw2PyxgjKmrZJ1+4j+j6tNM3Aq0QmP9nrMNcFKPJMYnMb6WiUrduL
 GMbt5CQZYVu4kLg7EulpWhE4VvpBqUMO2yExu4UgU532X4wuypByb46RLmMeHrZm
 fa/GjxY/mbGgpfhDRhXxk3efOX5VHMTsb28IZXtSmZPwWxkNdJu87Zc3THaGFMhR
 Js8L/tFZa1EE5qpdSBxz7Bsa/8m6oPVrOhDUjCv8CBkP8iDCb+0pCLj7t6Lxp+j8
 kWWCNU304T+/Pu93n+R5Kz/ASplqw==
Received: from sj2pr03cu001.outbound.protection.outlook.com
 (mail-westusazon11022140.outbound.protection.outlook.com [52.101.43.140])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 49nx1tskah-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 09 Oct 2025 03:14:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s1ptMeDZKapa7abNJGav0bl2IFSSIw2rflx2cBxa1SR3lda3LlRKxNAxgWdLHywItBGPMgPjpltaGa4BIPb87tB0VLWjwEkbprbo5c4sv89wB4JIWmiaZmyRMXBQAEZKPy11dQmZd2/jMGpS017qAYrtkmi9FrTJhAcIergB7NxbUtI5Vb9Er3o6x+0sZR5zLw7dZahcV06TNGWogK5j8AylX8rgLU+RqEdTv5siwbvym0NI1T9xNMtKOlQfC+yPHX4BTTqGqzG9aoiNnIsV5eFNe8kqcg5v+N6KSzTkVap5fpfi4ONGlw1M1BSbwl2c8cIu98Pd3n7KFwxAovnDKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xXI2a/dD/sesjm2ZdceVR0cWik4pHx5E5+bT3vjBrGc=;
 b=HB7HSmzXFO6wf8SRIjPJm23pC1HGEgP2MhVIVPpy4dlR9ytzTMN1f0NzyMMSVjF5eP2jTnV6KHY7Ldwy8ixDQK2caS330EoIIeVvNlvpeY7LhnqQQsPVQDqxlK0K2HOr7FjEOJcpYHsTNbCmHlqc0/1bcBGpRiNJASMvSWfo5wdTfqCBk+1jCVO/+qF+/jl1WMfmJ/ut9fulK65KPrQ9DKxTQ04iOALZ++W2Unz4F1MWf9B4Ktuglpz1uW1i2mPrRukt5pswH3w/nRzGAjwl3j46J1N+oWcDcOcbVcvU3ls47QxO/QWYWvCju/5lHHOQn7OEoi1Rxj31iQnFOQNkzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xXI2a/dD/sesjm2ZdceVR0cWik4pHx5E5+bT3vjBrGc=;
 b=dVJfOEhPKg185P0dUFS5YKx75A1l3rGexDCxqsjlfMEHoJK7aOuc99mrqtaj8usFp2sSHEpsbueL9OUPK2wSWsvECGPGEtM4w46mJDsvjjzeo6SD5+4hO/V6pHWnOHpJ60Pm5qsrjHGcbyHPJdDZusUsALKFFyLaQXJCuJwaakVOcRrxvYm5UAG1D3GRDqdJ/+wpmDk+FSH2Qt9jGsrY/3c0W4iTfK+6KgksvtXrZhVZvXjRGN5606/9GFy9c368j87czoXrRtAwnX93qhuSn8zSIVb51CxSoIot71eBtb9YhkCndDbd7DgynrPuN+jilZW07UIfNtgAVMWLAZgEdA==
Received: from MW6PR02MB9817.namprd02.prod.outlook.com (2603:10b6:303:23b::15)
 by MN2PR02MB6973.namprd02.prod.outlook.com (2603:10b6:208:20d::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.9; Thu, 9 Oct
 2025 10:14:47 +0000
Received: from MW6PR02MB9817.namprd02.prod.outlook.com
 ([fe80::86e5:3449:a3f7:ee4c]) by MW6PR02MB9817.namprd02.prod.outlook.com
 ([fe80::86e5:3449:a3f7:ee4c%7]) with mapi id 15.20.9160.017; Thu, 9 Oct 2025
 10:14:47 +0000
From: Tejus GK <tejus.gk@nutanix.com>
To: qemu-devel@nongnu.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Cc: Tejus GK <tejus.gk@nutanix.com>
Subject: [PATCH v5 1/3] QIOChannelSocket: add a "blocking" field to
 QIOChannelSocket
Date: Thu,  9 Oct 2025 10:14:16 +0000
Message-ID: <20251009101420.3048487-2-tejus.gk@nutanix.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20251009101420.3048487-1-tejus.gk@nutanix.com>
References: <20251009101420.3048487-1-tejus.gk@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH8PR07CA0015.namprd07.prod.outlook.com
 (2603:10b6:510:2cd::20) To MW6PR02MB9817.namprd02.prod.outlook.com
 (2603:10b6:303:23b::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW6PR02MB9817:EE_|MN2PR02MB6973:EE_
X-MS-Office365-Filtering-Correlation-Id: 77548d19-cdc9-4782-9dec-08de071cad06
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|376014|366016|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Qg7AuVbrFFwIUOgCRzg5cq3gqtiFWirhVHRmDyHHRuuOpwKwmyAAXUVAZiUN?=
 =?us-ascii?Q?EaW1qLKmmAYpzQ++wLW7HJiHDr8tBk2i0t/Qut5msHgfRcjp3FyNys1hXn6O?=
 =?us-ascii?Q?TzYWF4dCnRpDWAuMQRLnooviuh+OR2GeTOesXPtHx/xzXB9bGrsaU10CFv3O?=
 =?us-ascii?Q?G5+c9fEQL8irMOcN4/f5vEDL0UXVpS3UNhAcyGE8liPkfNpTGI3xnbm9jXnp?=
 =?us-ascii?Q?uX8RhpZliYadWn82oFeeFFi8+u9ot4MEUDkWRmTABYjf24bs51n2Y9RC/Q4z?=
 =?us-ascii?Q?k6CIEcmyNhU5rlSxBVAP8yYNLwLsITQZ7P/hxQ23+ptP6ER6Au1dk8xIMSuU?=
 =?us-ascii?Q?WrC+vjIDb7695eXA/vRE56u6xYQR98FBXiUJL3sid3sSgnuprBJww/BZ4nrs?=
 =?us-ascii?Q?zy7blDjtchkCs/MAsIRarxCdO6c435AzCfyIIsT6N2jHJak5N4zEZ6mtycL+?=
 =?us-ascii?Q?cZeNxs2VV/4ByVQF4OHF0AnbDC6DpBB+/BTPSRDze2L0dvpTT9arLpNpdYs0?=
 =?us-ascii?Q?HDgsn/t39QHenTD+tHl2QPHvOG1C+ye3R15j3avsC2+vjaAxOzUfDHtONNjm?=
 =?us-ascii?Q?jxOEHcL5hRSAO5JG66Niy4ToNXE0FjaUafYa3HU2/SUrVQIzEm6dKbriRS//?=
 =?us-ascii?Q?rqq4Plj9DAVCPTRNFT5/AKhPUYY0o9J9xPHOHAdH35SLuI8zfASW8lAxPnZQ?=
 =?us-ascii?Q?TUgx+EAW+WrqtW/1TyA3IlIZ9rptkm1InoyzP6aQ8ZOcALcg13kGQtUxo5YQ?=
 =?us-ascii?Q?IBe1ry9gAs559DcbUdhOqQDv3i29aY7tqT7GJ+cNEpj66LIVNYGAHqyPZW9F?=
 =?us-ascii?Q?nAbmGS0DznsPMQMeFRV1LQp1ABkzUtoHNfSSJDcs4ZbOqCckTyeb6lzuHJ75?=
 =?us-ascii?Q?IhDy8m9oDBidyzAd8K/qV7W2c+upKusGGReNBRNTRSBRfUrHDPT2ze1OpG3F?=
 =?us-ascii?Q?ufIPVH1okDYwtm6iNXKz4/YISEPNhx0SimZb7g6cDgCyNIvc/R9JuA6TRLKe?=
 =?us-ascii?Q?qEL/CKOTsKzBerDi+wD/YtFiPzavPJToz2NNC6VZxlK1SaXUoKeog4SrLrgn?=
 =?us-ascii?Q?QhznA23LtH3Ju4t9SKpn/NLRmiGQ3+hyllgj+9Zef4D5t+oFAHf8fyABWafI?=
 =?us-ascii?Q?2bBdhfXbe9Es9VCWeiwWucyJ32Z/ScqSolqpCPHndid09I+lhtBKJ3ZIefpp?=
 =?us-ascii?Q?2QDiXAH1SV8qwHB6oGXbHECw7gRAyMzDL7RUEnShRnhSlkEcxvjlnHWyrDXP?=
 =?us-ascii?Q?qccm1rHr8qseLQvKN0TZCMureb4q7c3gJt9T7QwilF+HVzGBF7kGwWxO1PEi?=
 =?us-ascii?Q?4NVRLa/6h2f5sxRhp8ZJG+j6kmuMcBUdbG7nZBaFXH2CGoAvtjWCJTJBWN8d?=
 =?us-ascii?Q?mwTQp4/KM5NoTOdO4roBA0XcDlfpjIfhpkXagLl35v4ib9Q703B9uOERQ4wf?=
 =?us-ascii?Q?Pl7zoodh/lKaxsPQd3Dk6qLpKj4anZH3KAMDTlMWfBil2CXyjLRXAiawSktp?=
 =?us-ascii?Q?QmodQrhW3RGz0DKTnPrLpoCloYUEzBlDIfgh?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW6PR02MB9817.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(376014)(366016)(1800799024)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mpQlCHcfYfz+H2Ot52BXzKgyZTQHMU0ja9TZKDQXSiNu+7OMaCFBcVliSiOD?=
 =?us-ascii?Q?ekpy65lhYD91Fn5WVBHR6vaVDbjcm7EP4vHY6JRP9w1Qcr0C2ucUZTSmj4tl?=
 =?us-ascii?Q?4MImhQQ/qE8QxIAPECXkhL78H7YRGTQfbgqvdhQsBcjbm051ZBguc9+JfA8c?=
 =?us-ascii?Q?rFZXJdP4se8JpUJtifh3XAPoeTFbLzG2G3GSysuKnB6eMv08VqXIKLQW2L4P?=
 =?us-ascii?Q?mnn2Fr6FKYaTmpr9O27mEhOAJManpECOi2FQOUEWEBORtCufXQh4dqyudy+0?=
 =?us-ascii?Q?xor7Tlz1VbmSfvlY16A0QVtvM1De8BaPx8k7pBL+pesz7l9Antdj3aftnyhA?=
 =?us-ascii?Q?AM0P7Z3dPDPhy5reZpLrNzRe7CTKlSeMNxsG/d4ypoIqsZXUlzTAbFNgLuPH?=
 =?us-ascii?Q?ghwi9hq8Jsfas5/5YcZuL0T6kZytsa3NQnmclZjAhSsiC+ic8uqdlNAebOP9?=
 =?us-ascii?Q?0RnQKt5iPeW0SKqQqI3rvCEcxEkDxd3xcHkOtGCgx9qJ9Xz+wNtIOb14+v5w?=
 =?us-ascii?Q?jnG1G/gUvYfzvvHd2aCiSIwFgAdzj6HcTtJWy44XDvGTApYc2pHfN1HYFGWt?=
 =?us-ascii?Q?3wHxn8fvMSqrSpRbl1p9R8cYwiHuAJEWtDXs3QlAPOiMoEj3XLqSmoeG6W9o?=
 =?us-ascii?Q?kvAos2/LWz8cF3P9EqnIHZKd+9LTySt4ujtNhhx5ZE+xvy3EwzxFpbLvup28?=
 =?us-ascii?Q?8Wm10h2mSzWNHuXUAPrTAtysgtWiCKE2U2V+TNAhUu3+QcidPeqJyPv7f+8M?=
 =?us-ascii?Q?Ki/Mri4QEwamLUXBxqHmzgwKnHwYvMwzhFAgDIviINiEpmGjf/OUHNPD7dZD?=
 =?us-ascii?Q?7++S4/amjvuWec+BRMrdSiOajZWzKEEN++/MSFIA6NH75YFDAdJcOEu+npiT?=
 =?us-ascii?Q?m5gl0NhIUEbwqOFqYDf1NcplvIq7T6j9IkhcOCDw9gEfbeiO8a4yqDKEc3dA?=
 =?us-ascii?Q?BvdSF2D7J21ti1gQ9N1w+j+mf34urS1SRwtDu7idEcRwvpWtuWmppCzIClO3?=
 =?us-ascii?Q?Bspg4iKETZA2cI34lPyk/mi5ukmq4n7dVjY8w/c8yPmunWt1Dc3If9TCtaLQ?=
 =?us-ascii?Q?yQdteCr6zqN9RRqo278kr3oP1xNbcYFJiFVLXDt7c2JPHnrB1vyZ49POUAAe?=
 =?us-ascii?Q?LY3kFdopEUaE3hggzNbGmLb5h2VcGU/M7oPxH4T6N2dxJwULhE9di0JtjtK1?=
 =?us-ascii?Q?S84xB8o3O09eO6T4emlzJTi/RDb8/vidaFcQfGsExAETpl1GGzz8l1o4QJGD?=
 =?us-ascii?Q?Aj9a1OUTDhzhEiS9mCWTu2m/AeqE1zM+Zcy0ueuGdMyFJZ+/6r0tkFgcfy23?=
 =?us-ascii?Q?+BhACMPhZUZeRCatlUyzegeuvlUGaBR4tsXdG8m1j5sl7Q0SCndzJFpjGiPF?=
 =?us-ascii?Q?o3YAg6hfrhdCOKEesgDiwf/Vxt38P7uhPzW5tmQmDuqj/GvITr5GpRm87pAp?=
 =?us-ascii?Q?Kw2NAV1S7/f4ql9azjV/bKnGkHpLIxHBSQ2gji2o4oIANNkpHe8mCS73NByv?=
 =?us-ascii?Q?WFC0oCqHCcqFur5wZPavLPLjSKdrOachcmvM9p5ChI61WWAGHOeABL2/futJ?=
 =?us-ascii?Q?czELq8XKRDFtzy7zay8c3k6KHKqDKv2yr1QE11f/d5LRlnUY/kkW0mwq3Yg5?=
 =?us-ascii?Q?Bw=3D=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77548d19-cdc9-4782-9dec-08de071cad06
X-MS-Exchange-CrossTenant-AuthSource: MW6PR02MB9817.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2025 10:14:47.8396 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nF5mHOiNxFcsdW58bNT2+8tLCWPMl/sFsW9qAjS17lOTLw0773Mr5WJC9k43UOkuSwbMBSTVjjgSajyMDn26+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR02MB6973
X-Proofpoint-ORIG-GUID: kxoVtoqbkNXA8Cu9wfbd56Jp1AjrdEkq
X-Authority-Analysis: v=2.4 cv=OdOVzxTY c=1 sm=1 tr=0 ts=68e78b19 cx=c_pps
 a=Qna4ymSQF555k3G5Ibg6fg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=x6icFKpwvdMA:10 a=0kUYKlekyDsA:10 a=64Cc0HZtAAAA:8
 a=pg60GzFlFQrSi9hmcNYA:9
X-Proofpoint-GUID: kxoVtoqbkNXA8Cu9wfbd56Jp1AjrdEkq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA5MDA1OCBTYWx0ZWRfX6wymg79++BBj
 8l35uVVlTcTAJRcLqsmejKKi7H09NeAj02m785fcQeMTfvomA1lyqW/4m9WAOxQYnnYgsYyaw6K
 ujUIpq9ExHFiKEaWxkGI/vrAMhDXRu61pZ0BqP9ch67xN045AFwygpF56HdUBmVvhg2kMkBbxNp
 bIK9FiXxlrZuTK4VEq8gfkoTfNzJ5709udegOx0QZRwUcGHz7/tMn1LF4V2JeH+eWwX6Z8awAtu
 TJn67Z55V9Z4Vyh1diMlcAli3GU4JZeTGPK5Qsoe9SDeL6aVSYsoE8dcJtCryAaXmqTRXSGJMS4
 3q32mxDk0p/HQIlRzVYZ0b/nGkqtWENx9sKh/RQn8MKFculqnuf6CUDWegrlXNKCTyr6W11Qe4Q
 N6B6eWBF56UbnJksbB6EJGlMnr819Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-09_03,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12; envelope-from=tejus.gk@nutanix.com;
 helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Add a 'blocking' boolean field to QIOChannelSocket to track whether the
underlying socket is in blocking or non-blocking mode.

Signed-off-by: Tejus GK <tejus.gk@nutanix.com>
---
 include/io/channel-socket.h | 1 +
 io/channel-socket.c         | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/include/io/channel-socket.h b/include/io/channel-socket.h
index a88cf8b3a9..26319fa98b 100644
--- a/include/io/channel-socket.h
+++ b/include/io/channel-socket.h
@@ -49,6 +49,7 @@ struct QIOChannelSocket {
     socklen_t remoteAddrLen;
     ssize_t zero_copy_queued;
     ssize_t zero_copy_sent;
+    bool blocking;
 };
 
 
diff --git a/io/channel-socket.c b/io/channel-socket.c
index 712b793eaf..8b30d5b7f7 100644
--- a/io/channel-socket.c
+++ b/io/channel-socket.c
@@ -65,6 +65,7 @@ qio_channel_socket_new(void)
     sioc->fd = -1;
     sioc->zero_copy_queued = 0;
     sioc->zero_copy_sent = 0;
+    sioc->blocking = false;
 
     ioc = QIO_CHANNEL(sioc);
     qio_channel_set_feature(ioc, QIO_CHANNEL_FEATURE_SHUTDOWN);
@@ -859,6 +860,7 @@ qio_channel_socket_set_blocking(QIOChannel *ioc,
                                 Error **errp)
 {
     QIOChannelSocket *sioc = QIO_CHANNEL_SOCKET(ioc);
+    sioc->blocking = enabled;
 
     if (!qemu_set_blocking(sioc->fd, enabled, errp)) {
         return -1;
-- 
2.43.7


