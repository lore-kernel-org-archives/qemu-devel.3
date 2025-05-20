Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 340FEC3DA6D
	for <qemu-devel@archiver.kernel.org>; Tue, 20 May 2025 15:06:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHOWU-0003Bg-Vr; Tue, 20 May 2025 11:04:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uHOWU-0003BH-0e
 for qemu-devel@nongnu.org; Tue, 20 May 2025 11:04:54 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uHOWR-0002QW-N4
 for qemu-devel@nongnu.org; Tue, 20 May 2025 11:04:53 -0400
Received: from pps.filterd (m0127838.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54K9ibSO028781;
 Tue, 20 May 2025 08:04:49 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=xyolPWjgzFxF5Ne4ELx4waxp81CD9zh7bT7r6noG/
 lE=; b=gcbDWI+nSxeo6BTIpDb4tky6Mj+x80u7KeNLhPTFCGzecvFyeqwnwsIOj
 LMeVnoEiI5HfCmPg4d6u3gGQAnz6J3xe+Q+7grjfwmX730k0svH1jL5MhYFYbDpF
 dq/sFjgDGKPR6o/ebpdP1HxxsDAEoUKSTOf9VeJNbcPUcn1s/mrHg0+V8kKAmJpV
 zA8VXblcRsPDmmz0ONQHrp89QBR/j6eGYdeRQKDY9fqXGFTqQl9RfCDo92MiZIzS
 N7UOgceas6JluV5Ewz7o0sEjtCeY6RdWNdqnZ47KeQrrg2fuoIMIzSV3FGQ2h9Gk
 /dAj6Nu4TElyNvGiIxnolQN0Haquw==
Received: from nam11-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam11lp2177.outbound.protection.outlook.com [104.47.57.177])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 46qvhvc71u-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 20 May 2025 08:04:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BKBEjzAa2QgfU5gUXosvMXoCpsOpM6e8gNV6Ox0BaOKfykLmurz1NmPwtDc4P3W15KvqNZvTfuw4WO3zoLQMnkf+OTLRqgiKOFZXDbhQblQVywvv8Nex4M8EkDNw2VsSOandifBDL3VoGJoxwDetTN8xls58LE/OFCYi2CtCbyPeZthPRtj1LoGL4Xpd69IEwYESU8hMO3nGSihY1YHzdBNrDzHPtgy2ceqSIba5Z8bV86t4XNjSWXstVghJb98nn4Fn+sDNejzRyzlKO83SnugAmvMORid1FlfYWfJTQ9znz00/hYwZjU/vAbFQTl0n/+wUgnpD2il6Or1uIgwlUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xyolPWjgzFxF5Ne4ELx4waxp81CD9zh7bT7r6noG/lE=;
 b=gqQSKvyPlOECqnVtxj0fTMU9Aoi4ohTPxZ8fZ4jovmNg1p5dERYNRcvsbf0Cy/XgvkzXqTGPjUgpbE2FpFp71/06z9rqufmJeLOh8SZF+jTOchCnUJpm+VN/SIXmhjmUJ203CWJs/VFnLWiXzX8YCoUC4fKipm5v2+D0Ff6hcjSbloinPSExMwC7hcbZpDcMNxvJXMSSFoRBOqtpIBTnCv32TaHYemAS2Kz3DYg/nipPsTuOCXdTqQdUZLCLC2ErYd/kS+8e8fMCrMA8siPMEzoZqQiFfxGAg/932/UeVB6Jt/nd9R9xYCiOMMfkw+tEg62+NeDqlTM/2knQV7FPRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xyolPWjgzFxF5Ne4ELx4waxp81CD9zh7bT7r6noG/lE=;
 b=h0OK82MX2Vfmu2AAnaw1Kyc8zbekL9B6lrxFwD+MWzWXjb4HxmwIwI6sNdDZuZprK4IHRHcLmBwL99PPvMuAnro7H8f3uqWLzVE8vGRg+7It5Ccq+dy1XEb9O4ACJ2yqMVP/G9LeYXFJRHgqDpcGSS05TD67ocC+doqrrX65D9wo4KoC3FC1kUsL25A0DBo7oPBwKQOJDvh3zcBHL2nbSWh+JpYL9f4uNTzlVbOKuR87OP/LxkppYukNar0RY0gXhhsE5KKTb06LQUXQIVjq/Qf1J1XUnIqySpdldN784BU+gjFnFdPiMFt6270OSPmmuR8mFaoc7o1ajrSHHc+J1Q==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by SA1PR02MB8462.namprd02.prod.outlook.com (2603:10b6:806:1f6::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.23; Tue, 20 May
 2025 15:04:47 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51%6]) with mapi id 15.20.8769.016; Tue, 20 May 2025
 15:04:46 +0000
From: John Levon <john.levon@nutanix.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 John Levon <john.levon@nutanix.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH v2 09/29] vfio: return mr from vfio_get_xlat_addr
Date: Tue, 20 May 2025 16:03:58 +0100
Message-ID: <20250520150419.2172078-10-john.levon@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250520150419.2172078-1-john.levon@nutanix.com>
References: <20250520150419.2172078-1-john.levon@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM9P193CA0021.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:20b:21e::26) To CH2PR02MB6760.namprd02.prod.outlook.com
 (2603:10b6:610:7f::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR02MB6760:EE_|SA1PR02MB8462:EE_
X-MS-Office365-Filtering-Correlation-Id: d6dc8f96-4c86-4670-0a88-08dd97afa8ec
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?yRklIHx1wyQmAvzihNrEgu8VdRwBH2Lq2GnnPmdW/BpFFgAlTKAwRKU6fg4U?=
 =?us-ascii?Q?SdEQ0lNGBs4sn+B1ws/vkQRH7xEa7Ed8z46redIM3kJVC3PhQ3B3aIv+zUm0?=
 =?us-ascii?Q?GH/akuROQ8TyJZlvTbfJs+iwCDf3EKf0ojLIslqcnLUiWmZYa84u6r9CIswa?=
 =?us-ascii?Q?Q1eP+plNMVjtJiRYr0rJ+WgRHQ2dDXVEvB9GNhkOLGXiY0CVyvzrHmpkwZdT?=
 =?us-ascii?Q?jke5quyR60jRm6p56okzDk5enDX3xEm55m1hpLvLRpCkIu7uYS0zpTpsSUUj?=
 =?us-ascii?Q?7s4wkbNcg3FmJGCADyJPIwQ8nwKp17uVnD9BTYa0rZXMnGUZMbtdh3K4J5XR?=
 =?us-ascii?Q?dfYwWqbYP52KOo3/0qwU3HNONGY4YOqZPVzSMD6Ucs0MgMqK3cSVNgoNFMZY?=
 =?us-ascii?Q?u2LKXl9xSV3ny2ATkG24Sn5mvlB077LukIfxCAxd/2WEY4A24AsYo/eDFFoI?=
 =?us-ascii?Q?oqeCUj7FAx/NsB5V+50i58IqHl+v/iAUxVTTzKfKuoUZWH40hh3S5sJ9N7a7?=
 =?us-ascii?Q?Ax2lu7T0UChA+IwUBAN85gBTBSFM0pwReqo6+uFb1np2mtIm00sRGNvju4w+?=
 =?us-ascii?Q?hVmjVEILYLdphL3Ta3YQLMM0mpZZToCtiVwadzT6/Z8REypTSyYhf4hH0FSZ?=
 =?us-ascii?Q?tgVxM5EiHk3qrBpkyrJZxk26h1C70azDYHz4AK9MLlhFD1jFuOWqW8Y0EigV?=
 =?us-ascii?Q?vR4FJvLWfgM6RJQhb+pazRh9KUrvICd7Bd1iGcynUUwYC8AgiumLnGeNowkT?=
 =?us-ascii?Q?vp8yS5EwZvZ9OEDvpCyhkB/OqRl8e0SQKHxq8Q9A06DA9CAFzH2/6KdlvWcA?=
 =?us-ascii?Q?uIPaZygsGLTRafa0mlamdh0bCf6FUqEvAugKRjGmeOw4T/jjbqNg2hT2jfka?=
 =?us-ascii?Q?wyOXIaDbXrZYy+/p1FHonNOohZyI2l+gUOeBcWB7Iwpo/SCXsSgNLcDk6qYu?=
 =?us-ascii?Q?EX+2cZDH72pI/v0uL/lmTQJAbKS3Yl4D45R72IPiakGsMGeTLxMegyAMvUTv?=
 =?us-ascii?Q?JmYIfKuZMSVFSBSlm1OqrwFjGcagOg2+xtETvqgkh/9nBgrL0yA8GhtBXGTs?=
 =?us-ascii?Q?Feax+9GIJnUWPWDisY3yNIdAZ+UOEjpc1TrrWOd0fe+J8KybhwEqZ8rsPNPi?=
 =?us-ascii?Q?qPkoCXwyPa2SELqWldTNv9ry5ttqcy2IMWtlnEujUOo5wW06cziECfXDV20x?=
 =?us-ascii?Q?hyG7TSbPLpFn2qHhvGbwIorwNioHaE5EUFEy6Ts4Km0PhOAzDleZ6galoZKm?=
 =?us-ascii?Q?PWfOL436EZCC+Lpt5jemoW1PpY+zNB7u28BLsJPXKp3H21YdpHnIRJPE4uQY?=
 =?us-ascii?Q?ssULpGmdg4dTtx2bNjSkjkUs4C73s1y2k2ky/2+Tk18Uvw3WOj1z4bNX457h?=
 =?us-ascii?Q?wSgq+XK1eoW/wLSO2vOypTn0yuQaW6DKBWEZPzuEslikVlIBcDeB9LbZb6G5?=
 =?us-ascii?Q?Bp+2lDyjMUs=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WI0Ijcj6kAlZZ0hgvRODUIjjNnSupArujttylGhyixWHZa81q6QOSI8kZey7?=
 =?us-ascii?Q?sDv5BTD7L/IFxNaEjjerG4Z3U4jXdytoAvmAsaSYlKREX6yxtbcPcinq5YBv?=
 =?us-ascii?Q?JRoPZM+nAU7YseyhQR1K6z1QFy8M1x2TW8MB9q+GE3wnLQM7l2en1ReR5Zb+?=
 =?us-ascii?Q?C8CN8sTYOiMCzjCjjbuGCB5939rmy4RNZEQvtF+lhiTpKAp/NCj0041r1qiW?=
 =?us-ascii?Q?6j9+cceEsSgDI2jgz9ntC39ucTRfxp1PkATDIZjWYTl0wrFo5guJy8k9ETFT?=
 =?us-ascii?Q?X/znnXsxl2in4Iqxp4DmE3kR6lpgUbpBGyfI7GTd9iNhggg4DuHqGs8KYmh6?=
 =?us-ascii?Q?TjUknzrLXaAmDC68iPtz/qdHHMLDOAK4Pt3orXkIEexREI8I7thccniy3+B+?=
 =?us-ascii?Q?OAQ67GLNYWfcg/ap7uxUTo6pPd54MTanGpdcq5iy/yIPh+49Mb2FpuxCFFvY?=
 =?us-ascii?Q?InLZ6VuFF2gXoP3LvLfSjgPpx1yJsG0JxZ2zDHiz7tYjlaT/tQxsjTQQNZUj?=
 =?us-ascii?Q?EjdeWzf6/qC+xKqMFXAbGCqKvhNBjc5hB//iZIkUgJ1Vydvy3dfnwVvvgaz4?=
 =?us-ascii?Q?67sBiWNNbyLbByN+PhZZNCpZJN5fubEkOH2htOrjXjVoudv65z3W9x+30tWd?=
 =?us-ascii?Q?vecCAq+lWcMz1AF1r995W6UWuDRrPplmkNnRVmSb6tWff+rKT61YxOYaemd+?=
 =?us-ascii?Q?RTFJWYy5hzgsYrW/+82DZG0lGetq4OxCwM1YNAXziHHQLhb4CevBnJgYqRzE?=
 =?us-ascii?Q?hG8TtGRKUsUZOFYuf+Vlb2UjkCOpw9XUpx3EkbkRHRoTivkkp9rVYThh5Spt?=
 =?us-ascii?Q?2GN13zmPAiqNCLXxsKRQa5y+jm7pIjnCC+TlYvj/UX1Z4zMBv6ahvK0JC6Vo?=
 =?us-ascii?Q?kL1Zo66mymduBCzO7h0PXCm3lrCM3pUZCxOSN+kv0Owi5KDj2WbgEy78yzL9?=
 =?us-ascii?Q?Vvk1cVSdhCX19Yl7VrXw2JdHkZl/yIvtHliYPzq68ExXzaIO7N1/ApSdZ/EY?=
 =?us-ascii?Q?2NdXScLrIx9dCKZjlatFz8gXNPRFeYneONJvgg9m4W/fgqHH4qN+RDSDj8KQ?=
 =?us-ascii?Q?9UgqNYCYLPolq0PjlxHYMRCUsbZHwBBv6wAToHwviTquDg/9yVoP0jBegNLL?=
 =?us-ascii?Q?bulDl8JrbQF+4Igh5IS3blAyH5/2q+kGEhYmT8vNulUQerbN4uR0I70hzqqe?=
 =?us-ascii?Q?ZgtUg2qPPchy1s3BrhqG3+umXqNAKrzSfeWhdlKzO62USHopnHr0Xe1Pg5y3?=
 =?us-ascii?Q?eQJRwabA08dJUGUFWvQRxlU1r0ahx5Juaj43sGVmiHMTEdk4/TN31rlLpCJZ?=
 =?us-ascii?Q?XUOMOqLeCq9nJOlgodOWmREOmlOFnpSamEm5d31xuKnVvK8Vk8BM550imRDB?=
 =?us-ascii?Q?Y6t3ekMH0fTaFlWoiECo3u6gC61OIGIK5/M/hHqdz1GgQ6Z1Y4Aab+/tNH+u?=
 =?us-ascii?Q?jzjYrvIrNqB6BJGKuKQTcbunChOiwZlSFbMWoJkZcuUCOQDRJfK24N249Tul?=
 =?us-ascii?Q?WWDhXPf6DW0JLvPNc26sl2NpcaAygAmmhd9Rb63GTVCl2kR5wJVtTRiv76r8?=
 =?us-ascii?Q?Zrl45vE1XtiJb4HzbgFG1Z+pf8vLvB9IJiAvL8MZ?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6dc8f96-4c86-4670-0a88-08dd97afa8ec
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2025 15:04:46.7207 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WHfvgs31ACDVDWb1WwuN2gFAZAxXcK+RX7nUDQ6UnKhohLtmp3MioRaoQJ0hGQWPtgC12hm3VuF90UJLuj+q+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR02MB8462
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIwMDEyMiBTYWx0ZWRfXy1/PJZ5sECBt
 nNNxZwaFu7+jBdpRSNu9/JYijmvJmsHvqrLkfxj1dch+TF+gEZP1/bfl7sIGsWpg+T3jS4XYZXg
 KKHFHNsaU/SpIZp25SmzNDxfeo464MlM8r8ojL2QIh07wXgEGOKBicP+To2f+s3BczhK2BKOWDa
 XTvQwoE+aqiDuGCukMqo0trcyx0Q4zKGghKyCdV3DSJPHODTCdreftbZ/laMSRFqnaDoJxcm7Mi
 Ks59x5A8N3he70+9yz/JvpIvh0GJPPEd2SwkiKGF2DCgDpi3Suef5IeE4SZqlS9Y8JoAME+Z/0Y
 i+vvWCALt0+kTrqUPlDpGHrUjVS3+Sk5X/xSwFIRUgK35Y7U6sqPDi+IXZlUDCOG2Vx8yyxOgFp
 TTeljNzlorUMoAVgK8pmRWMrDdg84ex8JZQO6dOJG/sECT6atB6D4N50FOgPRoW3p1VY87cf
X-Proofpoint-ORIG-GUID: 7y6fAZkm2S8b84-DpJx7HLS7pKDcFfiH
X-Authority-Analysis: v=2.4 cv=KINaDEFo c=1 sm=1 tr=0 ts=682c9a11 cx=c_pps
 a=XlWNgFwcAB8XWrBhwjv7Vg==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=dt9VzEwgFbYA:10
 a=0kUYKlekyDsA:10 a=yPCof4ZbAAAA:8 a=20KFwNOVAAAA:8 a=QNV_3Zso053vk46vt-IA:9
X-Proofpoint-GUID: 7y6fAZkm2S8b84-DpJx7HLS7pKDcFfiH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-20_06,2025-05-20_01,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=john.levon@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.487,
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

From: Steve Sistare <steven.sistare@oracle.com>

Modify memory_get_xlat_addr and vfio_get_xlat_addr to return the memory
region that the translated address is found in.  This will be needed by
CPR in a subsequent patch to map blocks using IOMMU_IOAS_MAP_FILE.

Also return the xlat offset, so we can simplify the interface by removing
the out parameters that can be trivially derived from mr and xlat.

Lastly, rename the functions to  to memory_translate_iotlb() and
vfio_translate_iotlb().

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
Acked-by: David Hildenbrand <david@redhat.com>
---
 include/system/memory.h | 19 +++++++++----------
 hw/vfio/listener.c      | 33 ++++++++++++++++++++++-----------
 hw/virtio/vhost-vdpa.c  |  9 +++++++--
 system/memory.c         | 32 +++++++-------------------------
 4 files changed, 45 insertions(+), 48 deletions(-)

diff --git a/include/system/memory.h b/include/system/memory.h
index fbbf4cf911..13416d79b9 100644
--- a/include/system/memory.h
+++ b/include/system/memory.h
@@ -738,21 +738,20 @@ void ram_discard_manager_unregister_listener(RamDiscardManager *rdm,
                                              RamDiscardListener *rdl);
 
 /**
- * memory_get_xlat_addr: Extract addresses from a TLB entry
+ * memory_translate_iotlb: Extract addresses from a TLB entry.
+ *                         Called with rcu_read_lock held.
  *
  * @iotlb: pointer to an #IOMMUTLBEntry
- * @vaddr: virtual address
- * @ram_addr: RAM address
- * @read_only: indicates if writes are allowed
- * @mr_has_discard_manager: indicates memory is controlled by a
- *                          RamDiscardManager
+ * @xlat_p: return the offset of the entry from the start of the returned
+ *          MemoryRegion.
  * @errp: pointer to Error*, to store an error if it happens.
  *
- * Return: true on success, else false setting @errp with error.
+ * Return: On success, return the MemoryRegion containing the @iotlb translated
+ *         addr.  The MemoryRegion must not be accessed after rcu_read_unlock.
+ *         On failure, return NULL, setting @errp with error.
  */
-bool memory_get_xlat_addr(IOMMUTLBEntry *iotlb, void **vaddr,
-                          ram_addr_t *ram_addr, bool *read_only,
-                          bool *mr_has_discard_manager, Error **errp);
+MemoryRegion *memory_translate_iotlb(IOMMUTLBEntry *iotlb, hwaddr *xlat_p,
+                                     Error **errp);
 
 typedef struct CoalescedMemoryRange CoalescedMemoryRange;
 typedef struct MemoryRegionIoeventfd MemoryRegionIoeventfd;
diff --git a/hw/vfio/listener.c b/hw/vfio/listener.c
index bfacb3d8d9..0afafe3464 100644
--- a/hw/vfio/listener.c
+++ b/hw/vfio/listener.c
@@ -90,16 +90,17 @@ static bool vfio_listener_skipped_section(MemoryRegionSection *section)
            section->offset_within_address_space & (1ULL << 63);
 }
 
-/* Called with rcu_read_lock held.  */
-static bool vfio_get_xlat_addr(IOMMUTLBEntry *iotlb, void **vaddr,
-                               ram_addr_t *ram_addr, bool *read_only,
-                               Error **errp)
+/*
+ * Called with rcu_read_lock held.
+ * The returned MemoryRegion must not be accessed after calling rcu_read_unlock.
+ */
+static MemoryRegion *vfio_translate_iotlb(IOMMUTLBEntry *iotlb, hwaddr *xlat_p,
+                                          Error **errp)
 {
-    bool ret, mr_has_discard_manager;
+    MemoryRegion *mr;
 
-    ret = memory_get_xlat_addr(iotlb, vaddr, ram_addr, read_only,
-                               &mr_has_discard_manager, errp);
-    if (ret && mr_has_discard_manager) {
+    mr = memory_translate_iotlb(iotlb, xlat_p, errp);
+    if (mr && memory_region_has_ram_discard_manager(mr)) {
         /*
          * Malicious VMs might trigger discarding of IOMMU-mapped memory. The
          * pages will remain pinned inside vfio until unmapped, resulting in a
@@ -118,7 +119,7 @@ static bool vfio_get_xlat_addr(IOMMUTLBEntry *iotlb, void **vaddr,
                          " intended via an IOMMU. It's possible to mitigate "
                          " by setting/adjusting RLIMIT_MEMLOCK.");
     }
-    return ret;
+    return mr;
 }
 
 static void vfio_iommu_map_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
@@ -126,6 +127,8 @@ static void vfio_iommu_map_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
     VFIOGuestIOMMU *giommu = container_of(n, VFIOGuestIOMMU, n);
     VFIOContainerBase *bcontainer = giommu->bcontainer;
     hwaddr iova = iotlb->iova + giommu->iommu_offset;
+    MemoryRegion *mr;
+    hwaddr xlat;
     void *vaddr;
     int ret;
     Error *local_err = NULL;
@@ -150,10 +153,14 @@ static void vfio_iommu_map_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
     if ((iotlb->perm & IOMMU_RW) != IOMMU_NONE) {
         bool read_only;
 
-        if (!vfio_get_xlat_addr(iotlb, &vaddr, NULL, &read_only, &local_err)) {
+        mr = vfio_translate_iotlb(iotlb, &xlat, &local_err);
+        if (!mr) {
             error_report_err(local_err);
             goto out;
         }
+        vaddr = memory_region_get_ram_ptr(mr) + xlat;
+        read_only = !(iotlb->perm & IOMMU_WO) || mr->readonly;
+
         /*
          * vaddr is only valid until rcu_read_unlock(). But after
          * vfio_dma_map has set up the mapping the pages will be
@@ -1010,6 +1017,8 @@ static void vfio_iommu_map_dirty_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
     ram_addr_t translated_addr;
     Error *local_err = NULL;
     int ret = -EINVAL;
+    MemoryRegion *mr;
+    ram_addr_t xlat;
 
     trace_vfio_iommu_map_dirty_notify(iova, iova + iotlb->addr_mask);
 
@@ -1021,9 +1030,11 @@ static void vfio_iommu_map_dirty_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
     }
 
     rcu_read_lock();
-    if (!vfio_get_xlat_addr(iotlb, NULL, &translated_addr, NULL, &local_err)) {
+    mr = vfio_translate_iotlb(iotlb, &xlat, &local_err);
+    if (!mr) {
         goto out_unlock;
     }
+    translated_addr = memory_region_get_ram_addr(mr) + xlat;
 
     ret = vfio_container_query_dirty_bitmap(bcontainer, iova, iotlb->addr_mask + 1,
                                 translated_addr, &local_err);
diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c
index 1ab2c11fa8..a1dd9e17a6 100644
--- a/hw/virtio/vhost-vdpa.c
+++ b/hw/virtio/vhost-vdpa.c
@@ -209,6 +209,8 @@ static void vhost_vdpa_iommu_map_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
     int ret;
     Int128 llend;
     Error *local_err = NULL;
+    MemoryRegion *mr;
+    hwaddr xlat;
 
     if (iotlb->target_as != &address_space_memory) {
         error_report("Wrong target AS \"%s\", only system memory is allowed",
@@ -228,11 +230,14 @@ static void vhost_vdpa_iommu_map_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
     if ((iotlb->perm & IOMMU_RW) != IOMMU_NONE) {
         bool read_only;
 
-        if (!memory_get_xlat_addr(iotlb, &vaddr, NULL, &read_only, NULL,
-                                  &local_err)) {
+        mr = memory_translate_iotlb(iotlb, &xlat, &local_err);
+        if (!mr) {
             error_report_err(local_err);
             return;
         }
+        vaddr = memory_region_get_ram_ptr(mr) + xlat;
+        read_only = !(iotlb->perm & IOMMU_WO) || mr->readonly;
+
         ret = vhost_vdpa_dma_map(s, VHOST_VDPA_GUEST_PA_ASID, iova,
                                  iotlb->addr_mask + 1, vaddr, read_only);
         if (ret) {
diff --git a/system/memory.c b/system/memory.c
index 63b983efcd..306e9ff9eb 100644
--- a/system/memory.c
+++ b/system/memory.c
@@ -2174,18 +2174,14 @@ void ram_discard_manager_unregister_listener(RamDiscardManager *rdm,
 }
 
 /* Called with rcu_read_lock held.  */
-bool memory_get_xlat_addr(IOMMUTLBEntry *iotlb, void **vaddr,
-                          ram_addr_t *ram_addr, bool *read_only,
-                          bool *mr_has_discard_manager, Error **errp)
+MemoryRegion *memory_translate_iotlb(IOMMUTLBEntry *iotlb, hwaddr *xlat_p,
+                                     Error **errp)
 {
     MemoryRegion *mr;
     hwaddr xlat;
     hwaddr len = iotlb->addr_mask + 1;
     bool writable = iotlb->perm & IOMMU_WO;
 
-    if (mr_has_discard_manager) {
-        *mr_has_discard_manager = false;
-    }
     /*
      * The IOMMU TLB entry we have just covers translation through
      * this IOMMU to its immediate target.  We need to translate
@@ -2195,7 +2191,7 @@ bool memory_get_xlat_addr(IOMMUTLBEntry *iotlb, void **vaddr,
                                  &xlat, &len, writable, MEMTXATTRS_UNSPECIFIED);
     if (!memory_region_is_ram(mr)) {
         error_setg(errp, "iommu map to non memory area %" HWADDR_PRIx "", xlat);
-        return false;
+        return NULL;
     } else if (memory_region_has_ram_discard_manager(mr)) {
         RamDiscardManager *rdm = memory_region_get_ram_discard_manager(mr);
         MemoryRegionSection tmp = {
@@ -2203,9 +2199,6 @@ bool memory_get_xlat_addr(IOMMUTLBEntry *iotlb, void **vaddr,
             .offset_within_region = xlat,
             .size = int128_make64(len),
         };
-        if (mr_has_discard_manager) {
-            *mr_has_discard_manager = true;
-        }
         /*
          * Malicious VMs can map memory into the IOMMU, which is expected
          * to remain discarded. vfio will pin all pages, populating memory.
@@ -2216,7 +2209,7 @@ bool memory_get_xlat_addr(IOMMUTLBEntry *iotlb, void **vaddr,
             error_setg(errp, "iommu map to discarded memory (e.g., unplugged"
                          " via virtio-mem): %" HWADDR_PRIx "",
                          iotlb->translated_addr);
-            return false;
+            return NULL;
         }
     }
 
@@ -2226,22 +2219,11 @@ bool memory_get_xlat_addr(IOMMUTLBEntry *iotlb, void **vaddr,
      */
     if (len & iotlb->addr_mask) {
         error_setg(errp, "iommu has granularity incompatible with target AS");
-        return false;
-    }
-
-    if (vaddr) {
-        *vaddr = memory_region_get_ram_ptr(mr) + xlat;
-    }
-
-    if (ram_addr) {
-        *ram_addr = memory_region_get_ram_addr(mr) + xlat;
-    }
-
-    if (read_only) {
-        *read_only = !writable || mr->readonly;
+        return NULL;
     }
 
-    return true;
+    *xlat_p = xlat;
+    return mr;
 }
 
 void memory_region_set_log(MemoryRegion *mr, bool log, unsigned client)
-- 
2.43.0


