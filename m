Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78BEDC5DF7D
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 13:57:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwKK7-00061x-3E; Tue, 18 Aug 2026 09:57:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lucas.kornicki@nutanix.com>)
 id 1wwKK6-00060u-1x
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 09:57:50 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lucas.kornicki@nutanix.com>)
 id 1wwKK3-0004jY-PI
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 09:57:49 -0400
Received: from pps.filterd (m0127839.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67IDudAr1560575; Tue, 18 Aug 2026 06:57:46 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=jN9b7QSBtgxq/Ur5M+Os874GBKmC0jiOIgbcEautX
 yM=; b=WmPfyz51gi/v/Cq5zfQTGwxiTVltk5g6nifunTiTzc4oYyko2YigLCSJ2
 McIFUAuqt1fmRcEiDOeeBlyzN4wZ2+dduhHsn5pWwL2MRwNc6oQROvxigWGjcVyK
 gSlC3hQPnM6fJSleXyR5EItDcglrFkcAL1zlVDkNne8m59F6w06bVSSSUNkmERHJ
 ScjDwOlhKugFDgMV+oYA894XFdiUCdJZGPEc9pNbaau12RJbKKxVpN3zOBQO8QCG
 cDQBvbWDCDRobAdB15VlNYMcJQJZgsXVrbFpbGurHu0QMnu7noCIVhzXY47YarMh
 gLnSpzo/TCnRGSS69cD0EP9DW25Dw==
Received: from ch1pr05cu001.outbound.protection.outlook.com
 (mail-northcentralusazon11020132.outbound.protection.outlook.com
 [52.101.193.132])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4g2q6cxntx-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 18 Aug 2026 06:57:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wz3vedYAf02nzvOGOCnAxd38Ti/JEAa4YJxwgrJaI8MNRCfw/18bIAffrYFz+hl4na6oln+t10FtkaYAYH5ot+e6tK78qJYnjIjh3KF9tOLlNIgWpbquhT37v8QeLMw9vSreJNMyrvnMCaMz0p/gMegAUdfU6TVNXLX8uj6DYNsfr1u9emZiuJHwTc0Ul3NOLSIOxbEWqDJmNJsjsTK9YGHxg7orIfF4rVnoxnDVRd7Rp8whAvl8PXAfLbKE2ycEl8Hhs5BlhFTsyMWhzdCOdXAC0rA6BytcV5AEzAs/plQRhJbz5Koaa+SxFitQ1SCAS8gdkZWAkHstzJTUooRBwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jN9b7QSBtgxq/Ur5M+Os874GBKmC0jiOIgbcEautXyM=;
 b=IWdWt3iUJa55Jrj3jqw1S5Emv3D5oWoaAPz3KvW9J0ZhrZ8NlLOz2+pqmU2S6Fm2kk4BLXT0h6OEVQ554XGwTFGim1Lwz7e2kwu32iq5SUwwWE/vR9QDRqImN9Y8gGT3wNYkGnM0NsaAGb5yzINBiXqcImEcHpK9ABtWp0EWiTWoRdYF4QXRYpjmwMPr5gIaPbPp9PAWjrcXt6xpE4pQX+9pxY9pXWvZxbtrD14k1KQNXc3ocMaIRYg7bQooXRmlgWatRpYbAeFrPMX/X91w7s+NH1co2/6JQhRQHzoDjF292dWy93vxHiH9s0RQkOjjLDHOWXMikKAjCwndqFznWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jN9b7QSBtgxq/Ur5M+Os874GBKmC0jiOIgbcEautXyM=;
 b=iUEAY/0NaZ38zlIVA7djp1zAMhuufqdMqfjxUoItvDnbWC46QzuJznO5z+T+EoXtr1JaoUQIXCClStO3MH0m4DxP8Y1uvahqMzG1pUj0eNUo/5zON2kS15OUUF6sR1wFi1RANcJ93kPsUOR+Q3i8RlUZac2AOHsDcH2Y/bw5yZNK0GXBneQa8pPh5MUjY5IhQX2t9yUHS3KxSbY57DjYnGeyn6miP9h74niaq4p9rmmm4hP+SSBdWUg1V7ytFsD5PVqlRH7SEjRxOjSrOPN8qOd4tQz64KZa5tvX+4yfbP9ZXuIn8Y2jbRGKrqAuT6UYMD2o2JYRlJcgGBLryGbr8g==
Received: from BL0PR02MB3827.namprd02.prod.outlook.com (2603:10b6:207:42::26)
 by DS0PR02MB9103.namprd02.prod.outlook.com (2603:10b6:8:131::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Tue, 18 Aug
 2026 13:57:44 +0000
Received: from BL0PR02MB3827.namprd02.prod.outlook.com
 ([fe80::5f5f:bb6:29f7:afd]) by BL0PR02MB3827.namprd02.prod.outlook.com
 ([fe80::5f5f:bb6:29f7:afd%4]) with mapi id 15.21.0339.007; Tue, 18 Aug 2026
 13:57:44 +0000
From: Lukasz Kornicki <lucas.kornicki@nutanix.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH v2 1/4] ui/clipboard: add clipboard peer update notification
Date: Tue, 18 Aug 2026 15:57:34 +0200
Message-ID: <20260818135737.2679311-2-lucas.kornicki@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260818135737.2679311-1-lucas.kornicki@nutanix.com>
References: <20260818135737.2679311-1-lucas.kornicki@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P250CA0009.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:20b:5df::10) To BL0PR02MB3827.namprd02.prod.outlook.com
 (2603:10b6:207:42::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR02MB3827:EE_|DS0PR02MB9103:EE_
X-MS-Office365-Filtering-Correlation-Id: 9dd8af66-9b1f-49b6-d2e8-08defd30ad18
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|23010399003|3023799007|18002099003|22082099003|56012099006|10067099003|6133799003;
X-Microsoft-Antispam-Message-Info: 4iA4PHpIWNQVNEzrWyOaUjI18T/fG84hKBWmg3DiKfyccrUtkLv/GJNUz4aCYJ1SlrleNwK9UMtfG0u4kbOajakunZa4Fz16spAuVpFyVL0ZmuaTR+th8bCk1zz+wAATGtMtjwmgFzGV/B/7hJxjrJF5si4dZOcPvItHBbFMNULEd56Y5GdO51s6dR0Hpm87+JrfMQE+uQgIhuhWuuEG+lfq6wZpf2IatnhhpOJDJYb9MUaXiirqzRryDCmR6x2iETSs2hfYTuh3AHcAxt3aBwlaCpvavr+sS1fuuCzajauQbtdY2ITI5FYwuFgBNSEDb9WoMJKZMIol8mgviMqd1maxEZnp4BoEa80GB0HoBDvHtL5lzXYfzh6Iqqp0ySZ8l8R7B3s2/rYHOMNIAOmA9ur5F3dh9gvAaZm2imfu69PJFHq2rRD2eumg2lBEoxkZUJ7jcNOaG4BItO5Djj8wN7zjSfk6aeBUiCjZ+rPDLKk5RTnodfjnzvCY1mqtYrZ1DwSzqD6Zn/PDUa1SMB1cc5/6fKWAXOkdHWrdH7fwrWrAAjAhJN6y3nUi7L9UZgHOjs+TtPyjwdekcgznBDoG5bNizta8V1UOVi7dBJK8No7WFyoqx2cKBT7uMwfdEWDq7C1+OgGTLxN4GPzoNGCTjbQyEzzO7GW7WMwSGOwshns=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR02MB3827.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(3023799007)(18002099003)(22082099003)(56012099006)(10067099003)(6133799003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?b16cCbwegpnou2oaZUeULdErMaB1gVj19E/APQEbD1bV7vYxAVTRPPo1P6SJ?=
 =?us-ascii?Q?eTafpsMcmK8F9CTtBWshugtIopIqBg5H+zRGD4eHU1wghq0a8bfmFgIC2e3N?=
 =?us-ascii?Q?cad/2mM9hB7wTWeWe4h4lzJY+VXc9Foqm0WVGjV1LOaKBrjHsZ77Z8+rjfov?=
 =?us-ascii?Q?vDWK0GBummEEyagnwI7k9wzpaBM7k/IyrqnntlAf/fVM2uycujsnBvjHRgv4?=
 =?us-ascii?Q?R7y12VGbUfOkzmH3mzuHKHWSmVfHPvTPMGKiLc/QWRv/qDV77tnJ6Sy/SKdK?=
 =?us-ascii?Q?EDDL37YfgYhEmCWIXYDSA1D6DqGEX6mbJsOZXllW13CdBtaSUtKYVUtZGB8r?=
 =?us-ascii?Q?EnrPqO7vYmsjvJyv2N24j4WoPOUo4zhJAq0Ymt7665NpGPxF3ECId07AboSV?=
 =?us-ascii?Q?2gcv/G8/O4KQ8z9dOF3Shj2LqbWAjwfIE8SVgXtNc1FVOwZMDcKuGpunbqEY?=
 =?us-ascii?Q?RKJvsU3JALWVJPvZEqpvEGHUgscB3Jo5shvEa4XjEaza3IZLP5iCMtOiHqDd?=
 =?us-ascii?Q?Npyw7Dk3o4u1ZcvOFrvFBuPrwXj//QzTFnbh7qJjrBwM/EbTrCMAU+CIA6IE?=
 =?us-ascii?Q?bUwVXyB93/qY47DDS5nPr0W1WNStA3O8vQJQQNZ7T6/1dy9ycvs2iPfYqIrp?=
 =?us-ascii?Q?qadJzAyFyUH2brsV3J2yJPJOAeMCPMF7+Mk6mMaW+Occh86OmlWvBX2tfSob?=
 =?us-ascii?Q?eldPcqBpZuI4HXK1OwJVh9LM1rDJ2hkD8rCuh55bDmFtANPfQf5ZGYhO7vKG?=
 =?us-ascii?Q?yQvOVs+oEPwAyr73TOp5kXyDt2YuNssNETf4mq0JzkwXbIpeDoPEEs3CsYyl?=
 =?us-ascii?Q?1TZ3TKWB9P0Bp9C6bNgdoOJHXsMITdeMNZ00Y8LhFalIE2Lx5CGueQG9rkIB?=
 =?us-ascii?Q?sI3c0em6AxbJRo5x3cF4x3ltUo6sYxV23BcTep7v1UiwCIK/9OUx4jaxAav3?=
 =?us-ascii?Q?mt1QIuK1mYoLUUMxL8P+U9yPbnHbqb2wnyskeJMxzqywU6h8L7sRkzhG2paj?=
 =?us-ascii?Q?G2EYVTNEKcf5yZQr0rzuJN/CbUrZ9Lfcef6YbSAi4PmvnLXSAFv4AanQOkcb?=
 =?us-ascii?Q?P1hMWFg/iffK8ctygD9LZS5kNfhPT3CRiWvBqs5lnA40cRy/crwkda4FYGvM?=
 =?us-ascii?Q?6ETb3VZ1m94jaJrmauhX6hQRJTzx6F+X8PWjJcmIjBEFIyWJU3pQ63+z3xtw?=
 =?us-ascii?Q?L80QldZ9agzqVfbF19OvIynVygJLFgymOa1/B0TDOCJqbuOiMqIBTbQjp9eX?=
 =?us-ascii?Q?gPT2RUevP5IVg5Vjg9oEJPwm9bg4/hA2oWLO8krqe9S8KfDt0sXaml7ssLRU?=
 =?us-ascii?Q?qgTIskc3DbMTBZ0PwnUuWV57PyyARt+4y30xFsZlY99SOWBP5Gt+e+YzMoMy?=
 =?us-ascii?Q?q/n0pJL2R2UPg1W7Ui8sxdZim4B/4yvM+LkhW8875FxCap3fzi1NcdiNsX2d?=
 =?us-ascii?Q?+o0BIfcaJIR2v08a9n15GcTWJ8en8QuMYVST+3odj61u0BwCtG+DSjQEnTwK?=
 =?us-ascii?Q?7dhTM4QBivie7cHo3OkXPeG+Sm121w6mm/m/vQSYNwcWu8GwNooEPzd/ND4G?=
 =?us-ascii?Q?7aVb0fRH8kkvEvIzEl1HdrOSKarJ/A5oVNxrv1csvU5Nvc3T6eacEQYJqza0?=
 =?us-ascii?Q?JIwUt18pHOfDonChE6gN6Sx6Zpbkt8dOW/88bOMf9G6NLzOBVzbHKnYADIKU?=
 =?us-ascii?Q?vjwmFb/SHD0EZJ466DoWwqCi+c7GS2UkHP2YyP2A0htxPUm9CYVUIAuQSg96?=
 =?us-ascii?Q?E/bNdtJM/Q=3D=3D?=
X-Exchange-RoutingPolicyChecked: XsCbzIYTsK90WMcXr5P8+1pTG2mSOmcr4Hk3O2k1Xwp4Ko8Yi185deckaLMx0oyLbgnD26n7v9igJHniBNBjrLB0rp85E9sw30erVQtvN1tizB8QdqXXr+RM9pMYKE83rAjd3B7vsa2xZFIaKujHTbP5W4G/VvB2g0IKBiCV+71HOR1Jo0GHt0a5tCDwFEjhLFr3vJWxBYfHgE5Ygj0uLhcLLDoyMsWi+1Xkm7cwRzM8yB+rnuGefz+QxFe/cNk/mfvlK/iVxC5xS05/dcSjqhTYvg84wvzfKQmo0SIep8g1uu28nMFWfUaW7np1fq41L/jDmMi/SRvaQHScaaX7+Q==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9dd8af66-9b1f-49b6-d2e8-08defd30ad18
X-MS-Exchange-CrossTenant-AuthSource: BL0PR02MB3827.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2026 13:57:43.9938 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vUs4w9HZ4RTfQvsTOeTdNzmLy0/3fZ71dH1iMvCc/70vNN1F9LtprHC80b+bv0hgtnJRQFhU71mmCNkCvfwS0NdgViwWtfJJbycIWl8dh00=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR02MB9103
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDEwMiBTYWx0ZWRfXxv8rq5TCNFDb
 4BN+E+A8axjTXgzkSwdT1pMF/c0nfqlkhP8OACjKuFkNswNwg9w93WC1V0IEm9cHYrwUzuOHgoh
 psfkqboU2IGLH8nCQ5b9d7wtf0CnGeiuBGlk+ogM83Wnpp0NmRDQP1pqgcKLvd03uLDd6y3Mnn1
 HC8n8P2Bb8a5SLZBcs2Ph/D2mEfIGnoHYMWXoktHfkqjdNKqWOnTupoMbeE1bOfIgksFO/x+/uX
 wqAYF5O0MFE/vVc016PTH/T4M1vcGH42PHMoGBbwDZwokJuongAU5lczBd4k2EEsBOmcS/RdsGR
 pjJ0NUOAeicytoWTvHcZOgciDuwDkZhOs4fVSgqf1Tlec1ENLt/ZRWDlG8/64uUhdJDfjdtD8fx
 3gIca0zJED8vfq/3HKYOJnr/+HWrfeQRp4iBUdKp+BPEZBfy/SNRA8istDQhtbGAa1hVZOMmANB
 0nOJ6RnpeGlBobtMQ2Q==
X-Proofpoint-ORIG-GUID: Vrdug8VTQYjIo92eqUmG8NdBSZMVIwAN
X-Proofpoint-GUID: Vrdug8VTQYjIo92eqUmG8NdBSZMVIwAN
X-Authority-Analysis: v=2.4 cv=X85i7mTe c=1 sm=1 tr=0 ts=6a8464d9 cx=c_pps
 a=wDYKio+nLET07hVCmQyIug==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=Sv0fKeRqtYgA:10 a=1FjsvbZJLK8A:10 a=0kUYKlekyDsA:10
 a=sWKEhP36mHoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22
 a=y4UcunY2MAxhM4LwGdWI:22 a=64Cc0HZtAAAA:8 a=P8QhtFtuV3VGHf9AuhIA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDEwMiBTYWx0ZWRfXxgYRkxi36zRe
 N4zp7rP1y3PSew8zugHtzWCJyPCe4pG+hkc3H5aAUGTQlMh4nwUq3wcVBxFaw65gxolLaUbkX7n
 ltquc1VNqhJ8yWNk+T/eOIa38hsRMeE=
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

Add a new QEMU_CLIPBOARD_PEER_UPDATE notify type which carries
a payload with affected peer and whether it just registered or
unregistered.

All existing notifier handlers are updated to explicitly ignore
the new event so that the enum switch remains exhaustive.

Signed-off-by: Lukasz Kornicki <lucas.kornicki@nutanix.com>
---
 include/ui/clipboard.h     | 19 +++++++++++++++++++
 tools/qemu-vnc/clipboard.c |  3 +++
 ui/clipboard.c             | 17 +++++++++++++++++
 ui/cocoa.m                 |  3 +++
 ui/dbus-clipboard.c        |  3 +++
 ui/gtk-clipboard.c         |  3 +++
 ui/trace-events            |  1 +
 ui/vdagent.c               |  3 +++
 ui/vnc-clipboard.c         |  3 +++
 9 files changed, 55 insertions(+)

diff --git a/include/ui/clipboard.h b/include/ui/clipboard.h
index 62a96ce9ff..6166af5139 100644
--- a/include/ui/clipboard.h
+++ b/include/ui/clipboard.h
@@ -25,6 +25,7 @@ typedef enum QemuClipboardNotifyType QemuClipboardNotifyType;
 typedef enum QemuClipboardSelection QemuClipboardSelection;
 typedef struct QemuClipboardPeer QemuClipboardPeer;
 typedef struct QemuClipboardNotify QemuClipboardNotify;
+typedef struct QemuClipboardPeerUpdate QemuClipboardPeerUpdate;
 typedef struct QemuClipboardInfo QemuClipboardInfo;
 typedef struct QemuClipboardContent QemuClipboardContent;
 
@@ -78,12 +79,27 @@ struct QemuClipboardPeer {
  *
  * @QEMU_CLIPBOARD_UPDATE_INFO: clipboard info update
  * @QEMU_CLIPBOARD_RESET_SERIAL: reset clipboard serial
+ * @QEMU_CLIPBOARD_PEER_UPDATE: peer registered/unregistered
  *
  * Clipboard notify type.
  */
 enum QemuClipboardNotifyType {
     QEMU_CLIPBOARD_UPDATE_INFO,
     QEMU_CLIPBOARD_RESET_SERIAL,
+    QEMU_CLIPBOARD_PEER_UPDATE,
+};
+
+/**
+ * struct QemuClipboardPeerUpdate
+ *
+ * @peer: the peer affected by this event
+ * @registered: whether @peer registered or unregistered.
+ *
+ * Clipboard peer update event data.
+ */
+struct QemuClipboardPeerUpdate {
+    QemuClipboardPeer *peer;
+    bool registered;
 };
 
 /**
@@ -91,6 +107,8 @@ enum QemuClipboardNotifyType {
  *
  * @type: the type of event.
  * @info: a QemuClipboardInfo event.
+ * @peer_update: a peer register/unregister event
+ *               (valid for QEMU_CLIPBOARD_PEER_UPDATE).
  *
  * Clipboard notify data.
  */
@@ -98,6 +116,7 @@ struct QemuClipboardNotify {
     QemuClipboardNotifyType type;
     union {
         QemuClipboardInfo *info;
+        QemuClipboardPeerUpdate peer_update;
     };
 };
 
diff --git a/tools/qemu-vnc/clipboard.c b/tools/qemu-vnc/clipboard.c
index f62b2f2949..b85a2d8b55 100644
--- a/tools/qemu-vnc/clipboard.c
+++ b/tools/qemu-vnc/clipboard.c
@@ -174,6 +174,9 @@ vnc_dbus_clipboard_notify(Notifier *notifier, void *data)
                 -1, NULL, NULL, NULL);
         }
         return;
+    case QEMU_CLIPBOARD_PEER_UPDATE:
+        /* ignore */
+        return;
     }
 }
 
diff --git a/ui/clipboard.c b/ui/clipboard.c
index e3d8a31ba9..beecb40e6f 100644
--- a/ui/clipboard.c
+++ b/ui/clipboard.c
@@ -59,6 +59,21 @@ static void qemu_clipboard_change_state(void *opaque, bool running, RunState sta
 
 }
 
+static void qemu_clipboard_notify_peer_update(QemuClipboardPeer *peer,
+                                              bool registered)
+{
+    QemuClipboardNotify notify = {
+        .type = QEMU_CLIPBOARD_PEER_UPDATE,
+        .peer_update = {
+            .peer = peer,
+            .registered = registered,
+        },
+    };
+
+    trace_clipboard_peer_update(peer->name, registered);
+    notifier_list_notify(&clipboard_notifiers, &notify);
+}
+
 void qemu_clipboard_peer_register(QemuClipboardPeer *peer)
 {
     if (cb_change_state_entry == NULL) {
@@ -66,6 +81,7 @@ void qemu_clipboard_peer_register(QemuClipboardPeer *peer)
     }
 
     notifier_list_add(&clipboard_notifiers, &peer->notifier);
+    qemu_clipboard_notify_peer_update(peer, true);
 }
 
 void qemu_clipboard_peer_unregister(QemuClipboardPeer *peer)
@@ -76,6 +92,7 @@ void qemu_clipboard_peer_unregister(QemuClipboardPeer *peer)
         qemu_clipboard_peer_release(peer, i);
     }
     notifier_remove(&peer->notifier);
+    qemu_clipboard_notify_peer_update(peer, false);
 }
 
 bool qemu_clipboard_peer_owns(QemuClipboardPeer *peer,
diff --git a/ui/cocoa.m b/ui/cocoa.m
index 3751be3792..4587547c98 100644
--- a/ui/cocoa.m
+++ b/ui/cocoa.m
@@ -1860,6 +1860,9 @@ static void cocoa_clipboard_notify(Notifier *notifier, void *data)
     case QEMU_CLIPBOARD_RESET_SERIAL:
         /* ignore */
         return;
+    case QEMU_CLIPBOARD_PEER_UPDATE:
+        /* ignore */
+        return;
     }
 }
 
diff --git a/ui/dbus-clipboard.c b/ui/dbus-clipboard.c
index 90318384ee..6940f719ff 100644
--- a/ui/dbus-clipboard.c
+++ b/ui/dbus-clipboard.c
@@ -125,6 +125,9 @@ dbus_clipboard_notify(Notifier *notifier, void *data)
     case QEMU_CLIPBOARD_RESET_SERIAL:
         dbus_clipboard_reset_serial(dpy);
         return;
+    case QEMU_CLIPBOARD_PEER_UPDATE:
+        /* ignore */
+        return;
     }
 }
 
diff --git a/ui/gtk-clipboard.c b/ui/gtk-clipboard.c
index 476e6b8303..6bb3d7f3fc 100644
--- a/ui/gtk-clipboard.c
+++ b/ui/gtk-clipboard.c
@@ -133,6 +133,9 @@ static void gd_clipboard_notify(Notifier *notifier, void *data)
     case QEMU_CLIPBOARD_RESET_SERIAL:
         /* ignore */
         return;
+    case QEMU_CLIPBOARD_PEER_UPDATE:
+        /* ignore */
+        return;
     }
 }
 
diff --git a/ui/trace-events b/ui/trace-events
index 339a61f341..917d116d90 100644
--- a/ui/trace-events
+++ b/ui/trace-events
@@ -171,6 +171,7 @@ xkeymap_keymap(const char *name) "keymap '%s'"
 # clipboard.c
 clipboard_check_serial(int cur, int recv, bool ok) "cur:%d recv:%d %d"
 clipboard_reset_serial(void) ""
+clipboard_peer_update(const char *name, bool registered) "peer '%s' registered=%d"
 
 # vdagent.c
 vdagent_fe_open(bool fe_open) "fe_open=%d"
diff --git a/ui/vdagent.c b/ui/vdagent.c
index b9784d4d9b..cc32a94fb9 100644
--- a/ui/vdagent.c
+++ b/ui/vdagent.c
@@ -477,6 +477,9 @@ static void vdagent_clipboard_notify(Notifier *notifier, void *data)
     case QEMU_CLIPBOARD_RESET_SERIAL:
         vdagent_clipboard_reset_serial(vd);
         return;
+    case QEMU_CLIPBOARD_PEER_UPDATE:
+        /* ignore */
+        return;
     }
 }
 
diff --git a/ui/vnc-clipboard.c b/ui/vnc-clipboard.c
index fa05d86f42..dfe830f819 100644
--- a/ui/vnc-clipboard.c
+++ b/ui/vnc-clipboard.c
@@ -236,6 +236,9 @@ static void vnc_clipboard_notify(Notifier *notifier, void *data)
     case QEMU_CLIPBOARD_RESET_SERIAL:
         /* ignore */
         return;
+    case QEMU_CLIPBOARD_PEER_UPDATE:
+        /* ignore */
+        return;
     }
 }
 
-- 
2.43.0


