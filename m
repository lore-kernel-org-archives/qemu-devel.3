Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 469BCC5DF7E
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 13:58:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwKKD-0006UT-7n; Tue, 18 Aug 2026 09:57:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lucas.kornicki@nutanix.com>)
 id 1wwKKB-0006Ja-9J
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 09:57:55 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lucas.kornicki@nutanix.com>)
 id 1wwKK9-0004kF-Hd
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 09:57:55 -0400
Received: from pps.filterd (m0127839.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67IDullD1560700; Tue, 18 Aug 2026 06:57:52 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=GkN5MiXkfjtGOwQE+blVI6MACFEP9Z7RruF5XH0/R
 8U=; b=Qq1Gw5RsiklGbWt8NasSUGINFeivT3xZYSY4px0RTYReYPBpwDbk8ay/p
 epMWTg2k+RmVppkzkc0h3L2Fh2GOaYj+ZgkJkjSuKkJLxb72sVX3DYLTvP4IcGSQ
 9IWFkAqh1Qhh4/tNfnCv2fPBEavQUJqVsD7DcfQcRQICh5YVEB4FEN4CVcP0e9sw
 uNffciuR0jytR5ylLlADG107/6sSh6Yr4C31uZIU2v2nfk4bBC8rfB2sMOOUihw+
 kxnU++uxbiO6GrhfXb0kfsgWSmiLuNAkn3f+kP/tHM9ia6pg/DKN3OENkB4ItwRg
 6IaZn1BnY8gzeYkJL2YXHmikhsACQ==
Received: from ch1pr05cu001.outbound.protection.outlook.com
 (mail-northcentralusazon11020121.outbound.protection.outlook.com
 [52.101.193.121])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4g2q6cxnu3-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 18 Aug 2026 06:57:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=luAEk8naafp15B1hF3b0kfRRSKSZBKtaze4L/6gVRRHLwEsjv7o+KPcCu/nF5vlUzoA7pS5WD0PpG/w/Ge/uJVR5GXDrG7SmFsFGX7SbPCYulBupOVg63HQlKvXDY79/Hky6UI5bh//A3hLykCIJugTf/Z2u/GUO/EP2SfgTxeuT63Ky7G6uUJWgP1yQbtBbQCMc39hamJ1QGfmvxJkgXNg2gNh5VpYpaOUSTwOAc+Nsz3ZYZ8P7CizUTJvbSYE8GAYxUpnAFufE67auEbOMvCKjZA5grokvSwniW543uyoSBwucQ0tmlHVV0duXgJ7ewWk4sA4Rumad9fgILffgpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GkN5MiXkfjtGOwQE+blVI6MACFEP9Z7RruF5XH0/R8U=;
 b=KC5HvmBtypTQ49QN+bkfuGAeAJtMlFiR50piQvSl2/LIH6YgI50R8/JliDzStlMUQhZYp+YJ4tP4d7TG5brOb5STLqiC35fgH+uq/2O7Gx2FAUxI8Y0j3PaTyVCGgEi86sTZhUiANeq60TpknXJDlhuNQb2HsgfyRZMFdX52InSUeFA3mKy1Ty4EF0iIzqCqQBhBHLz8ol6Y9TAF/wMchcYCzjqXC4hTxHmf5i95yuSaTKC6+FC8jCn/E3lBdcr4oam9jELOF+OYnrBw6jMTpRObvsyiZJUo1GUVtMmfb/TZJ4wp/86EeSXCoRXTFwGZhLlKWvDE9/VtlMbNS2sPxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GkN5MiXkfjtGOwQE+blVI6MACFEP9Z7RruF5XH0/R8U=;
 b=FqBnBfrL6eIOCxWOVtG5OMbQgKKHD9KbfN7kuiVquEudzOJ0Bvn0YFeuZRw63nfXdIUoKB2XQnnkG8Uinj7U/um2Rwy3emxOiHrCzZHwBdC4WX1rkrPtQ96Vptuu7L4Y9BaR9a4c4sgIk3C2CIsjtbe4eBjKZwxSVaNEji1MrTV8QZLJmg4YTHJooDSk7ZMvz/eVQbSWvGABUOfOb14uDBuaXoGEv47RTxZJZ4uKEqz9QDc6PR5AP/T2U4enqtV1EyoNkzk4vQ8vLeMFDs0PdbWxYvEcRxJEL4qPofZ1rZzOi+KWzjFZiIYPnPrhU1z81GXTwpCp1DPp6L9NcHfuyw==
Received: from BL0PR02MB3827.namprd02.prod.outlook.com (2603:10b6:207:42::26)
 by DS0PR02MB9103.namprd02.prod.outlook.com (2603:10b6:8:131::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Tue, 18 Aug
 2026 13:57:50 +0000
Received: from BL0PR02MB3827.namprd02.prod.outlook.com
 ([fe80::5f5f:bb6:29f7:afd]) by BL0PR02MB3827.namprd02.prod.outlook.com
 ([fe80::5f5f:bb6:29f7:afd%4]) with mapi id 15.21.0339.007; Tue, 18 Aug 2026
 13:57:50 +0000
From: Lukasz Kornicki <lucas.kornicki@nutanix.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH v2 3/4] ui/vnc-clipboard: factor out clipboard peer
 registration
Date: Tue, 18 Aug 2026 15:57:36 +0200
Message-ID: <20260818135737.2679311-4-lucas.kornicki@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260818135737.2679311-1-lucas.kornicki@nutanix.com>
References: <20260818135737.2679311-1-lucas.kornicki@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P189CA0019.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:5db::10) To BL0PR02MB3827.namprd02.prod.outlook.com
 (2603:10b6:207:42::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR02MB3827:EE_|DS0PR02MB9103:EE_
X-MS-Office365-Filtering-Correlation-Id: 5fdfbd49-77bd-49cc-c910-08defd30b0e5
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|23010399003|18002099003|22082099003|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info: GVGJHB77cbLC+zaWzqkTbjQnpauzX64m1JwQIXUevpV8SVTrKfImnhJru9I2NGi0nXSgmUZjvdiREOD0KcX5f3OhWHdWA6XxIbvPlFsZvqQGWL3wCmrgmkK7s+RETVAGhiwcBHy41ASiNDMKSfcR164aSIDmrWXKLxteA1JZXEZm2Dgw5kWnjhEJp7sf4xSU9VVUry+QdgLaqi2tnEVND4XiZgObgHzdAsGH6au50h0jX6c6p5CroTDOYZf7kB46GO8UQ+0ZA0Of+iay3c9+8N1NQHB7QXst07MpE4q6+7ayPdqoDEbpsKk23DeBwF3522QRXumJgdvEYDv3eFUMNSv0NbSUU9b0QmJrSoQS9KYppzGGxyoQwbDuJ6WZGb4kdtSslllwq4MoCVFABDtPikN94Gs6VSCplNnnoWs1GkwQxhAPpC1LlS7bBraVNh3P6qbMuaAE024ByxTNMyjm6A37KxU8GmIGMG5NPBiTU5e6q33bSzdehYG9L/TQqJzmgrree95THUSKlp8TrFbysB6Mpjbx5eVXpBJVPefz4JtdEHobb8bhbnV03isi6TT0KBTX3p4J73OREVo3UouCXF5ZfP3kB/rzvhg1s710Xqa3mhqR9pxDtfcpVqc+0Bz8Lozm5zsFh+dH5v6GlLa6UthzZCpp3KGAjy8K7YsmVr8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR02MB3827.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(18002099003)(22082099003)(56012099006)(10067099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6jLZxJV7fNpBAHpgGZEN6GgzwsWswLdMFBxteD01aOXIIwSBJJ4gk5a2oj6G?=
 =?us-ascii?Q?A0u/bBJTGoUpA50OHVv6EqzMVeJCQliNkuVOyfdFUG3twp21wIMM09vVLCdj?=
 =?us-ascii?Q?RlFXDV06U9Xus+XXyMsQW5dcvxGNVZsuqRk9RG7yY/ZguaRMuO84gNP2O6ve?=
 =?us-ascii?Q?vKFcHqucs5PGG2+FGEPiaIuPEw4GERextpq7VdHck/zy+MwRk/Be4AQdvHSe?=
 =?us-ascii?Q?uNoa4XnkBE6jhfVRL+6N5UmsUg3h8N+h2zqxcvmRHnGnzKsjLAzks0Pg46Pn?=
 =?us-ascii?Q?ojSMP9cpERocpT841gdRUtUttxuf92i32kBUIDMYRh8bQJlsBslJIoBiCOtz?=
 =?us-ascii?Q?oC0rEkWRBHmY4cRFekF8UB9JLuXgGS8s5tGQ5zjjUglop78rZZzM5pF5nAi7?=
 =?us-ascii?Q?L3GR/gSS4CmBmdhsPe6c4V6RA0NgaYsxmfLIeuDcExUGJGWR5rNuzwHMpbJ9?=
 =?us-ascii?Q?l5cW1H3UHv14F59wMJDVz/Ob4WHGHKQlbtErW4R+iMXHGdzmwvDNebOup9GL?=
 =?us-ascii?Q?XD8LGbGE8ROHW5XRFbcCGDUYW8KGl6iSrPzUXAP2tDAQsJeCWYoYT7yRNySM?=
 =?us-ascii?Q?bJiLqLhFpWkGUl6Kasj1byZ37H+NMsnjx8Jw/dr1rC39rOo0MSv/AN6K9xbM?=
 =?us-ascii?Q?7e8HQd9sS8sNOVtSU2vmeSXwu5+l540xHU6zsbCPN8Z7Nu1GWP6OQ3gI0ha8?=
 =?us-ascii?Q?5ka0I++TP1u+CyVmN3MLJ18nD0j1cHVphACVxlkvsOtkgHBHUo6B5SSEmE6P?=
 =?us-ascii?Q?OiRlnOrDu4OkwjF4OmN5I9TE2pCzpyTd37BEQNYV0ZZ8pw5p91aeX4rnr9qp?=
 =?us-ascii?Q?gwUGqQwv46NVKFZzytGTGJVUS0O1q1GiZu4zoSmx05jXJJghunHKMBXCoDpU?=
 =?us-ascii?Q?0CH2rmDR/kNhHEFCukLVpSJlUU9VZ7kj/isQWkPamUBn0fTYHTWFo4Ask9ew?=
 =?us-ascii?Q?pZusIgXihcHueQ41mF2Kj/x8R8ZloqjIj1FY8OhooO51YjaKzLB3gVjUcK7H?=
 =?us-ascii?Q?GD43df9YALqwQGAURjqXVdCnPI+lHh19eQ0paXm2blNh8Ia4M9p+d0TwaCge?=
 =?us-ascii?Q?Hs2WAlh0ye8FLJzjxxn4rmrPq/GN3U4rcP8YwCDWkoXe120nQdMEHKLxgwBc?=
 =?us-ascii?Q?1py+wCRb/PwBwtaD0bd9G+sEJYk5/k6jbmNad7IOUZBeSdBrcRo2qLw8dTNT?=
 =?us-ascii?Q?tv1+GEZsJbW6rPR4OBaaTFdtreSfHq3p96hRmzSLkxloBAaU1ycznGU0JMXP?=
 =?us-ascii?Q?zmRiEqP47mBrDMOQahlP3UK1IH3dj+ZDCKHn2gX1C6otwpXsZoDqIjs7VL4n?=
 =?us-ascii?Q?sQRaJkKN/aV/GY4PEbq4ZIugL6MUxBBFqC9AhxJbrT+e38iJcZic4/D1+iq2?=
 =?us-ascii?Q?YPO9C++6oDmFyhdF4wOM/+aNdb+8mMqsLJhlg8RQxvfIFktFqmQOu0E6YZ00?=
 =?us-ascii?Q?F3nRnVeGMfpjqm+4Q2CMtn+kgGCOdFP2PkYQvdSoWOHXvPLptMXiUTkqOcAF?=
 =?us-ascii?Q?SyR6qxzcvB7iEDIfeht4Z/iESIdh8ETZHwNYiYuTeD1vp/ZwG8BWqKD1BUR0?=
 =?us-ascii?Q?tNl2HDkDuj+rs+BR4RPEhAIdsxHRyrzJYkr/xLLtJfI1k11HKKFd8Zej8Xam?=
 =?us-ascii?Q?iTiHSgSFvFYolC5YimfuSR4s0STslnQZ1paSXZ13BkXUa0J7bpypkjHhjs9D?=
 =?us-ascii?Q?YaHBakdjfZQF2AOEaQXEXIt+CNC6TvtG8Bz7m9SdOaydmlZ1OKB7cqk21Jjs?=
 =?us-ascii?Q?LmHDQUcrkA=3D=3D?=
X-Exchange-RoutingPolicyChecked: Z6inbiO2B9KD2eWQYI0QWqreOXJB11fvXTWr3/PG9cl0ngfGcPkqJneUFJzruSltubA7aH60uesFaTcNdS5MKrNWagEceMGMh9Hq8gr6v6Ky+Ifq7kwZ6A1/fij/+Tx1pB2VaKH0MFXIHTb2tAmow16OKUMXzeTvhqGLdqgCVeKd5lgrPbbgXE1pxHwBnEfHMo834T/gfcJkBFfmw/1n25UwFbGkomdOrshdVZfCF7MQnWGGveitiF9U7H8mzMuw6LnhAAOaCyYtp3gE8nQKb8COpezpwkiOJwIJTGyLCWfAxGzh+PAnY4jG+q0GzUpPbZVQYmGXTnIJslCjrIij2g==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fdfbd49-77bd-49cc-c910-08defd30b0e5
X-MS-Exchange-CrossTenant-AuthSource: BL0PR02MB3827.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2026 13:57:50.2317 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FxmHDGfC/Ms7z4ZbBEMtDvvWCl0tivhI4UC9JEBCYNuDGZLg0ya94QmG1qJEwcmDxW48i2l+9Ke6+nN6XLPYKh/dCKfH8nXwMnWTgdoj3hQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR02MB9103
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDEwMiBTYWx0ZWRfX4HD/8Lywn8Yk
 oVFTft0JEiO2dg/Ar7Lo7Pu+RJYlsokE5SKkg9V04DQK6WWHJ05cQMIbSy65G7qaGk85Vuh7DKj
 eX+JcpqBRGVsEJ9az6VoMkETGiv/m6doC9rRg/ri3N68ujUGWHcRB8xy503tT+Fq8QlQ3IBnl+c
 ZhqZ6BTCJiTED9JB5urCzkedtziYHOAvO5cP6A+6nIoDYRdOMLYF1GeRXi7dIrMZzJMU4bdEZ7l
 qhl/chr7sz14cBG6kbwGm17NZri+JpWYM3wywFMVVQP4MA/vx1SwZjxNZCizn+MP964E/anxyJL
 hn5Gu9LwzBD7whGngfyFEgMILkRQlEodERsV1FDMS4z2aD41cfEBX96wW3h1H88V2VYJ78GPxb4
 lIMbs9mpbfxLxcHJEpWLvWNJ40q5mSys3uVMpclsxUYqjO5N7LhV/jbF1O33KARSRwLBH1oltxm
 /OfiO1ujn7uNFaRR1ZA==
X-Proofpoint-ORIG-GUID: 0twUlcabviI4C58dIG9Ge7XqYL-C6qTX
X-Proofpoint-GUID: 0twUlcabviI4C58dIG9Ge7XqYL-C6qTX
X-Authority-Analysis: v=2.4 cv=X85i7mTe c=1 sm=1 tr=0 ts=6a8464e0 cx=c_pps
 a=EgIJVKDiB2rM9xu8Bbqf7A==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=Sv0fKeRqtYgA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=y4UcunY2MAxhM4LwGdWI:22
 a=64Cc0HZtAAAA:8 a=PIACHJi0fWsG_2wZ9OsA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDEwMiBTYWx0ZWRfX0qnkNKn9O9dn
 DLDAMvBc/KLDN26KyzEWUuR/nmQMkJlhfmbk1OhjnWmFZAPvah5nKJipBh+jXkgR2/c5taGOb/Q
 c2C6dPJp9DOXpGe/yYMh5OdM1Ns4zoQ=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-18_02,2026-08-18_01,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=lucas.kornicki@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.343,
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

VNC clipboard peer is registered inline from vnc_server_cut_text_caps.

Move the registration logic into a function so a subsequent change can
register the peer independently of extended clipboard capability.

No functional change.

Signed-off-by: Lukasz Kornicki <lucas.kornicki@nutanix.com>
---
 ui/vnc-clipboard.c | 17 +++++++++++------
 ui/vnc.h           |  1 +
 2 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/ui/vnc-clipboard.c b/ui/vnc-clipboard.c
index dfe830f819..67f710f6ed 100644
--- a/ui/vnc-clipboard.c
+++ b/ui/vnc-clipboard.c
@@ -325,6 +325,16 @@ void vnc_client_cut_text(VncState *vs, size_t len, uint8_t *text)
     qemu_clipboard_info_unref(info);
 }
 
+void vnc_clipboard_peer_register(VncState *vs)
+{
+    if (!vs->cbpeer.notifier.notify) {
+        vs->cbpeer.name = "vnc";
+        vs->cbpeer.notifier.notify = vnc_clipboard_notify;
+        vs->cbpeer.request = vnc_clipboard_request;
+        qemu_clipboard_peer_register(&vs->cbpeer);
+    }
+}
+
 void vnc_server_cut_text_caps(VncState *vs)
 {
     uint32_t caps[2];
@@ -341,10 +351,5 @@ void vnc_server_cut_text_caps(VncState *vs)
     caps[1] = 0;
     vnc_clipboard_send(vs, 2, caps);
 
-    if (!vs->cbpeer.notifier.notify) {
-        vs->cbpeer.name = "vnc";
-        vs->cbpeer.notifier.notify = vnc_clipboard_notify;
-        vs->cbpeer.request = vnc_clipboard_request;
-        qemu_clipboard_peer_register(&vs->cbpeer);
-    }
+    vnc_clipboard_peer_register(vs);
 }
diff --git a/ui/vnc.h b/ui/vnc.h
index 88293ef497..d8b0070396 100644
--- a/ui/vnc.h
+++ b/ui/vnc.h
@@ -636,6 +636,7 @@ int vnc_zywrle_send_framebuffer_update(VncState *vs, VncWorker *worker,
 void vnc_zrle_clear(VncWorker *worker);
 
 /* vnc-clipboard.c */
+void vnc_clipboard_peer_register(VncState *vs);
 void vnc_server_cut_text_caps(VncState *vs);
 void vnc_client_cut_text(VncState *vs, size_t len, uint8_t *text);
 void vnc_client_cut_text_ext(VncState *vs, int32_t len, uint32_t flags, uint8_t *data);
-- 
2.43.0


