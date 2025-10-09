Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26E47CCD188
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Oct 2025 10:16:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6nfz-00023s-9f; Thu, 09 Oct 2025 06:15:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tejus.gk@nutanix.com>)
 id 1v6nft-00023Y-8H
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 06:15:05 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tejus.gk@nutanix.com>)
 id 1v6nfl-0007i9-6P
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 06:15:04 -0400
Received: from pps.filterd (m0127842.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 5998QNUx524941; Thu, 9 Oct 2025 03:14:53 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=eioBov/B4+y0gSwdIHLvkHTtdtK24LXBesIEmFG4v
 08=; b=YmH/VlJNGkkXf7j5SYbY2LPKLhCxbk8H9bFziROPYd0M8xrC/fRBvFs9z
 p/cGwDGpL0q2q5HFR2oNIFfGT/NeREPSWiHIofd9JJSkZpALtImAOLTTLeVd8ttb
 hMtm3tyK7uS130pAneE0AlEu6f/48oE+8CkRdTgngPunRlkUaFgy05rNhmvTdjix
 r+sLrBrGv5BmTSiyen/G5vqgjt31GZN4KVrd3TNai2eMxBh8/AFFsLwi98M564gO
 mOcgYGst92DXvB9ub6C8olDLul+VXCcF08NONEe53FPV6omUUInuS8QWHmC39g9b
 wFP9YcpV50LwvwsONOJElftmw6Qsw==
Received: from sj2pr03cu001.outbound.protection.outlook.com
 (mail-westusazon11022078.outbound.protection.outlook.com [52.101.43.78])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 49nx1qhkfv-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 09 Oct 2025 03:14:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nhXNPXg7ygbasy7EcWSfSvcJc8FXsrFjnvxe35iw1t8/VRibWyjDTUQsB0Gc+mLLgLy+9dfDlG+rnfLCmdbJ1pC2dEWLXrcJKDhLY83mngA9yfsnMbUH6eq/cpJqm2ulPNV2n/N54Sri7gaFIzrnz4+GKu7UzNqegsE51IjERH+qU96eI3D5ytJ5ZQ5Zoo9nVFXUsMHpZNIL8g/YOcUZTsrC0xlWt+6VK/D/Z/FH1ICDTgRfA5PVDReeEWHBJ/65yao/mIv6vYW7/qvstQPEwIH5zG3jQhs3ig9L63vTwt7ePRmRsE4UIUxBBBkjreudnjBSgpp+ILkYzhc7waQclQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eioBov/B4+y0gSwdIHLvkHTtdtK24LXBesIEmFG4v08=;
 b=O0vQU9o7g4Zjpm/5FGAU/za6Hd+LZYDYG1KMfky4Pe+JaX/yOEVlAWRwxlPjkfrEI8ra2d38uvn0+5nJ5CkEGXDi3wBfxEts+yew2DdDnTApL4zd+aAvFIai0tPPBqwKu/J5BC9SrT/Y9DfZkn8XuzrBQnQU6aQe8BsnGsIWufBXdzXi7rG5BdD2qhN/PYv8ZSGJrocQ9lGAHQAVwoH/8TMOXXjvaZ6oAiFcLEh8o6ES3wDDH12YEmIvr9kfjXV5xQ5lLEo137X+ZQ9oA1Yfk/unWDImX5HkaQYrtof2f+6noOk5vh0GDHxCLKyeXDRKrhjzSygByrGtFN3C06XSdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eioBov/B4+y0gSwdIHLvkHTtdtK24LXBesIEmFG4v08=;
 b=EtnGyhhVEj03kSYflDKn/qlfGQADQhEVtx4gDg4pM9twtmttZbpym+OCzFO5HklOb+odscHPFwfTEOOLlOx8K8ALBH3Oyf5ZfUM0B+12RGw7cJ8ZI5yAUdw2XV9MWvkUBt/hydCcPz6UvHplQQcI6hwL/o17DUkHpdU/LLSjdbm1444eOJpcE6KK5QWTz4ii3LcMjTN8A38c4tKT/ZxGfY4u9/mTN9ZKeV2x428XY2K8luiqBTHRXtTSw8s3CzSuVPOo7B7INoaqdCNLg7dinVhYLsQp5qvCgp1QgE6ovHa5ykYJF/U24Fsn9JaAwnbdxaQqZny47xs69kgjgs3koA==
Received: from MW6PR02MB9817.namprd02.prod.outlook.com (2603:10b6:303:23b::15)
 by MN2PR02MB6973.namprd02.prod.outlook.com (2603:10b6:208:20d::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.9; Thu, 9 Oct
 2025 10:14:51 +0000
Received: from MW6PR02MB9817.namprd02.prod.outlook.com
 ([fe80::86e5:3449:a3f7:ee4c]) by MW6PR02MB9817.namprd02.prod.outlook.com
 ([fe80::86e5:3449:a3f7:ee4c%7]) with mapi id 15.20.9160.017; Thu, 9 Oct 2025
 10:14:51 +0000
From: Tejus GK <tejus.gk@nutanix.com>
To: qemu-devel@nongnu.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
Cc: Manish Mishra <manish.mishra@nutanix.com>, Tejus GK <tejus.gk@nutanix.com>
Subject: [PATCH v5 3/3] QIOChannelSocket: flush zerocopy socket error queue on
 sendmsg failure due to ENOBUF
Date: Thu,  9 Oct 2025 10:14:18 +0000
Message-ID: <20251009101420.3048487-4-tejus.gk@nutanix.com>
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
X-MS-Office365-Filtering-Correlation-Id: 156d87b1-4731-43f0-c0f2-08de071caf24
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|376014|366016|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?+v6psWT5/XILk/SLheFJouAiHgrmC568VuvsFgN+pdNVGHzx2XG3FDPRHWWY?=
 =?us-ascii?Q?kJPhYHdAm47gvf3yTke1s7h7uxDIUVNk5Im/IYhxm4cJSBouwZwuH3Wn5+W1?=
 =?us-ascii?Q?J2VUCp+ZZ6/Qj1fMixH+AUnrBc2L5KVAm1pF91wvIPHtCsTbpSXsLDa1QiuW?=
 =?us-ascii?Q?kVPEuTKuWYhcKgJdIkVPJYqT0hu3SGA29zKGzwszB57c22/wEkNv0zjlO3yW?=
 =?us-ascii?Q?pElCjP2QvpUMfHcDRqwsCrOM6eUiPOHyMfCuab39pKzTm6aQQCXMv5HVqNaR?=
 =?us-ascii?Q?77B/slvKgcMilwgJ00fLN+UNQIlJ+GuNfYL+BsqHWo1k6U8BdqR6XQNNrpsg?=
 =?us-ascii?Q?HN3/h98WXfqwehbZ9Tp611+pVaMqLZ2pZ/8vtcVS6KfE2MU1yq5seB1GFtgT?=
 =?us-ascii?Q?YRxtGC4j6qrBKdajwM18cOD4ud9bun8Cwr0R53xKKU0sEbubwn3QI4d1stiG?=
 =?us-ascii?Q?z4LhSXhbMmByAZygWkyAxt7PtRYdqX9IRPWZZtnA7UThVpzB9D2lAQwU+itH?=
 =?us-ascii?Q?cYVqpW1kDNt68MyLirNbDZlsbAo2CkgdqZEpaG9o1WJu/5kj3JO2NpjiO+Rj?=
 =?us-ascii?Q?DO+D93FtC7/+Qcb8irqChkUQYl7vazptufo8TxdGSp3HdTP/QPqve3dxvzUn?=
 =?us-ascii?Q?SwFrPMAq9rLXC3cQveVTg25egHCFgCVvB4QkY806J/0HelbKfuRzQUjzlFfl?=
 =?us-ascii?Q?SUshAk6cVoPISoHm5owouDIUqaMx8PQXPGN6f1udVnr8yjxMOy9KO/WLWkh2?=
 =?us-ascii?Q?NaYDJggruL7jBlXYRRqc3fGjvGTH3ZP4DDI3sRIMLjAY21/c33aWauXozYEl?=
 =?us-ascii?Q?ytlS0e09Swy72gwd+23Pabvglz0mdhY58q4AofKIxUlNc2JUhmTsZ7h3HJUX?=
 =?us-ascii?Q?FSYM8l/vLhpxfPEn9mhcd3G/igzbDbqLvY38gGCfTU/PWJe389h1KQR6FkbV?=
 =?us-ascii?Q?/kZLlLwSYcpQPj65XA3XWs49CLYqrOVFOUquSXQi1JwkVykKJyKal4V6qwuq?=
 =?us-ascii?Q?ky2iDGawUlLmf/+V3smaqM3Lnaoe/QstDVvwGgzXoV7Fob03RZq6P/5O7gKU?=
 =?us-ascii?Q?QPCf9yy05PQanv36bwhuvqKyYFsxaLK7ydVE/YkPTx+rVQcvPy0yplHxxxWW?=
 =?us-ascii?Q?FxToCq3dVm+hyGlvrd1VjycqigdOzz/mSXgf+DGWF40OxNLruNAuNKX1mCox?=
 =?us-ascii?Q?R7N2lQLimwZmnAWrNsshpDKnoTG013Eo07r7/yEDOYBJgW4L8WCKQC2lI46B?=
 =?us-ascii?Q?HqlmpBLuX5dC3PjAzOL3tCPnlSR3Ln55xzyfTSYXJ/s1wXzwBF8Rrv8tSZau?=
 =?us-ascii?Q?PBlEUsazbyC0lQR3laMf+2sPNXYKj2i+L91jGOm7IFAYfxN1xQGzRVxse5+1?=
 =?us-ascii?Q?haAEyBuU5x+heiitgCiqry7ZMMV9OSmwNnuNbl4d4iDywsAj8dn4sXRzUchR?=
 =?us-ascii?Q?OAE3J46OTFzbVIQ6TDh2Xe4KvXgIe4SjmEo6TZkupqr6vqKwrFzRY/bFIKjB?=
 =?us-ascii?Q?SVZojld3laJRTGqxtSnO0P5yBobZsAel3ZXo?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW6PR02MB9817.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(376014)(366016)(1800799024)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/0BlCuMBC6WDOzBBxoASho6X5bgAzrGcPMVvQiA77gciC8U2BDYx1WQhc0ZW?=
 =?us-ascii?Q?qtitiLRbg9Azlw2cHXn6M+UNdGx0r1krfx8HvCt1p+l7JCjz6NzAL2d6zJhi?=
 =?us-ascii?Q?u320vNq6vgdY14qY6sxcJgnvn3i0Swd5++Nh/DN6bNdO1365hdX7gcrTs173?=
 =?us-ascii?Q?YkdPniNqfDHkIXuIqTILYvaSAGRP8yZ691QUflRp1yni0sCLrpyrdNlugeQa?=
 =?us-ascii?Q?lAZhsMd1YTIQ1fBNIKz2w7FjiBe7DfNNsw28e5mcanDoaidI1SI5TXDUunAu?=
 =?us-ascii?Q?DJo1VeTCauQND3wpa3yp/w/6+wMaJpjyeYUFeYVY49eDSco/iS8KSp+A1W9Q?=
 =?us-ascii?Q?q/O3/OWDC6SUlXELgM8lR6vYXS5u661LBUSq27qeAIVwUvr3ALsYrPxFqE95?=
 =?us-ascii?Q?LgbIARmgUjExLc73SOi3vK/CrJpNUUiEqN4+cLjkd0NYIpZaXa8503ud8VTG?=
 =?us-ascii?Q?a0t8sOZO2g4EQzsEaIWs3i2YxtJBIhDD80PuYt99H2snp90CT3BfQ5YQRlEF?=
 =?us-ascii?Q?coOtIuDWF9ZUnhFRzUDib5gnzL9gTS4nprqRaRR2fR/h3771iya/dpHaUvGC?=
 =?us-ascii?Q?Kh8ni5nTd7HpviQcdn4F9og0ZUD5uSC/iZafABAlE6rMEoYKXouGF1ewWuyG?=
 =?us-ascii?Q?l1Q6Q9dLbAdlTzmy+w3bof7YeBbK5qgXlMoG9eCLJ91DFK09dRidTnAxawXU?=
 =?us-ascii?Q?6eAIyCEQiun5oQzkRF3gj9qoDi9TAt7vGa5ALt67hb5PZi5ZPj0PBPocIzYn?=
 =?us-ascii?Q?jp7xMKfmDu2BpZHQK7YWtN7LgWX7/iygsY2vTvbWT44mj1wv3qLlh1yycUCV?=
 =?us-ascii?Q?eOyEzKhsPIlyDJyew3dcfdsMQlJwTZ6O/BD/SYK+RkRUa+0QfMCjWMDN0/hA?=
 =?us-ascii?Q?3xAW2FQkEY3nIVjEaV7/D9j3wXhMXfUFVaRUN/Ju2zbwfNo3hoGWz050qu2a?=
 =?us-ascii?Q?oYUmTioTXocFOVmvuC0R46F1qQyxx7hSW2U8pQFeOzXCEP0Bdn/rm/1w5JhS?=
 =?us-ascii?Q?ZMl00W8TTykUg9qXVmnTBZJVxu+tG3vTk1qV7YfsHYWAVb2QuGz7xSS7h8n+?=
 =?us-ascii?Q?OBRL+i2f1hHF2XlkVUOfPmZP/oT/MKuVKwy4yEBwQD+vzNyRC5MDep1pu+ny?=
 =?us-ascii?Q?VlZtn+gagzf57sbiz//BU/qcU3AZGkVMhsYIxeFJ9SRYEAfMibtRSu1KdoC6?=
 =?us-ascii?Q?V9FqKN92wOp6NkndLJ5cN1ifHqsOITI0Q3tlcXohjAhQPsImg73hiNx5TSDx?=
 =?us-ascii?Q?2qAw2UQUf9RTnJrwXd3njY+QFEuKvcLLCRdAV2rY+aAKBPFv1wbmPLfHldsb?=
 =?us-ascii?Q?mF63hFbcKQ2BopKFOycQDZOTTp9ZkLPUdEwANQ/4FkEtTJzBbiB6gHsp1Cd6?=
 =?us-ascii?Q?JfoduByefdq9ucztLxgJxoDjXgSL244NSNZdUZzsvcc5eK0sq2ByenNE+DN0?=
 =?us-ascii?Q?5URiNp2TExCFfpTozGBE6OXh1vd0pzzWXLkMK0+TmDZR2+eZP2RVwmw7Kj45?=
 =?us-ascii?Q?Y/n11s+KwHIgNnCQnYtDtKgi8ZEGQvOZQNegRpPlMNsUigfJcseTinIncpTA?=
 =?us-ascii?Q?m7ftuP+NHROlyxr4K1gO82QxCwiNSSIf2IucTtR2IJ80vCmfoODVKuyP761i?=
 =?us-ascii?Q?8A=3D=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 156d87b1-4731-43f0-c0f2-08de071caf24
X-MS-Exchange-CrossTenant-AuthSource: MW6PR02MB9817.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2025 10:14:51.3343 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d8BKnYtoq31PgQ+h505C9vEHcs59+CxIKZIR4JWqpuNioUrHhxfGd7ql9JCpynUVLpbiyAeP70DxWfn5je3Pkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR02MB6973
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA5MDA1OCBTYWx0ZWRfX+gCvOB54ca6X
 XgXe514ezofAqQz7UG3R+VuvbxbqZ5TLD5v3fQ6t6J+1Yg6MN17tceh9/q6g8EfMqvB7DDQPbXn
 7xIZC8nWKP0FxYMR4ecxLILUfH9xguhiu1pJcI8DliGX+mDC8GXH+Md4vJT1MjWsaSexruZylsf
 UKO8SFtXWL7B/ccHm8pMrFEXteSJOOuR/3t62ZxWAVokZQV9dSKWAOr09ZCxAcEBJI7cB7fXgCZ
 kWspecbcsL9QB2hEdrl7naV5OFX7oqOtMSH/fsEIGvL2kApppA3GhORUwaXDqt6RwLsTRoLEBWP
 mCNiHI638oFyvR5mCj8c1x1PA+LV7hGgCt9OwRyzzUQA57GFg8jmiw4N7ubYE4koGYs+1rT4YQa
 cLmrGTLP544gti63kwQhoXCt9CVMmg==
X-Authority-Analysis: v=2.4 cv=Fr0IPmrq c=1 sm=1 tr=0 ts=68e78b1d cx=c_pps
 a=hJoePaVs+Aefu24hhViaWA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=x6icFKpwvdMA:10 a=0kUYKlekyDsA:10 a=64Cc0HZtAAAA:8
 a=BpdRU-NDIjJX68E94XgA:9
X-Proofpoint-GUID: qyc85A_RYwmd0btWc6nFpYRFRaG5SvIb
X-Proofpoint-ORIG-GUID: qyc85A_RYwmd0btWc6nFpYRFRaG5SvIb
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

From: Manish Mishra <manish.mishra@nutanix.com>

The kernel allocates extra metadata SKBs in case of a zerocopy send,
eventually used for zerocopy's notification mechanism. This metadata
memory is accounted for in the OPTMEM limit. The kernel queues
completion notifications on the socket error queue and this error queue
is freed when userspace reads it.

Usually, in the case of in-order processing, the kernel will batch the
notifications and merge the metadata into a single SKB and free the
rest. As a result, it never exceeds the OPTMEM limit. However, if there
is any out-of-order processing or intermittent zerocopy failures, this
error chain can grow significantly, exhausting the OPTMEM limit. As a
result, all new sendmsg requests fail to allocate any new SKB, leading
to an ENOBUF error. Depending on the amount of data queued before the
flush (i.e., large live migration iterations), even large OPTMEM limits
are prone to failure.

To work around this, if we encounter an ENOBUF error with a zerocopy
sendmsg, flush the error queue and retry once more.

Co-authored-by: Manish Mishra <manish.mishra@nutanix.com>
Signed-off-by: Tejus GK <tejus.gk@nutanix.com>
---
 include/io/channel-socket.h |  5 +++
 io/channel-socket.c         | 78 ++++++++++++++++++++++++++++++-------
 migration/multifd-nocomp.c  |  3 +-
 migration/multifd.c         |  3 +-
 4 files changed, 72 insertions(+), 17 deletions(-)

diff --git a/include/io/channel-socket.h b/include/io/channel-socket.h
index 26319fa98b..fcfd489c6c 100644
--- a/include/io/channel-socket.h
+++ b/include/io/channel-socket.h
@@ -50,6 +50,11 @@ struct QIOChannelSocket {
     ssize_t zero_copy_queued;
     ssize_t zero_copy_sent;
     bool blocking;
+    /**
+     * This flag indicates whether any new data was successfully sent with
+     * zerocopy since the last qio_channel_socket_flush() call.
+     */
+    bool new_zero_copy_sent_success;
 };
 
 
diff --git a/io/channel-socket.c b/io/channel-socket.c
index 8b30d5b7f7..22d59cd3cf 100644
--- a/io/channel-socket.c
+++ b/io/channel-socket.c
@@ -37,6 +37,12 @@
 
 #define SOCKET_MAX_FDS 16
 
+#ifdef QEMU_MSG_ZEROCOPY
+static int qio_channel_socket_flush_internal(QIOChannel *ioc,
+                                             bool block,
+                                             Error **errp);
+#endif
+
 SocketAddress *
 qio_channel_socket_get_local_address(QIOChannelSocket *ioc,
                                      Error **errp)
@@ -66,6 +72,7 @@ qio_channel_socket_new(void)
     sioc->zero_copy_queued = 0;
     sioc->zero_copy_sent = 0;
     sioc->blocking = false;
+    sioc->new_zero_copy_sent_success = FALSE;
 
     ioc = QIO_CHANNEL(sioc);
     qio_channel_set_feature(ioc, QIO_CHANNEL_FEATURE_SHUTDOWN);
@@ -618,6 +625,8 @@ static ssize_t qio_channel_socket_writev(QIOChannel *ioc,
     size_t fdsize = sizeof(int) * nfds;
     struct cmsghdr *cmsg;
     int sflags = 0;
+    bool blocking = sioc->blocking;
+    bool zerocopy_flushed_once = false;
 
     memset(control, 0, CMSG_SPACE(sizeof(int) * SOCKET_MAX_FDS));
 
@@ -663,10 +672,26 @@ static ssize_t qio_channel_socket_writev(QIOChannel *ioc,
         case EINTR:
             goto retry;
         case ENOBUFS:
-            if (flags & QIO_CHANNEL_WRITE_FLAG_ZERO_COPY) {
-                error_setg_errno(errp, errno,
-                                 "Process can't lock enough memory for using MSG_ZEROCOPY");
-                return -1;
+            if (flags & (QIO_CHANNEL_WRITE_FLAG_ZERO_COPY |
+                QIO_CHANNEL_WRITE_FLAG_ZERO_COPY_FLUSH_ONCE)) {
+                /**
+                 * Socket error queueing may exhaust the OPTMEM limit. Try
+                 * flushing the error queue once.
+                 */
+                if (!zerocopy_flushed_once) {
+                    ret = qio_channel_socket_flush_internal(ioc, blocking,
+                                                            errp);
+                    if (ret < 0) {
+                        return -1;
+                    }
+                    zerocopy_flushed_once = TRUE;
+                    goto retry;
+                } else {
+                    error_setg_errno(errp, errno,
+                                     "Process can't lock enough memory for "
+                                     "using MSG_ZEROCOPY");
+                    return -1;
+                }
             }
             break;
         }
@@ -777,8 +802,9 @@ static ssize_t qio_channel_socket_writev(QIOChannel *ioc,
 
 
 #ifdef QEMU_MSG_ZEROCOPY
-static int qio_channel_socket_flush(QIOChannel *ioc,
-                                    Error **errp)
+static int qio_channel_socket_flush_internal(QIOChannel *ioc,
+                                             bool block,
+                                             Error **errp)
 {
     QIOChannelSocket *sioc = QIO_CHANNEL_SOCKET(ioc);
     struct msghdr msg = {};
@@ -786,7 +812,6 @@ static int qio_channel_socket_flush(QIOChannel *ioc,
     struct cmsghdr *cm;
     char control[CMSG_SPACE(sizeof(*serr))];
     int received;
-    int ret;
 
     if (sioc->zero_copy_queued == sioc->zero_copy_sent) {
         return 0;
@@ -796,16 +821,20 @@ static int qio_channel_socket_flush(QIOChannel *ioc,
     msg.msg_controllen = sizeof(control);
     memset(control, 0, sizeof(control));
 
-    ret = 1;
-
     while (sioc->zero_copy_sent < sioc->zero_copy_queued) {
         received = recvmsg(sioc->fd, &msg, MSG_ERRQUEUE);
         if (received < 0) {
             switch (errno) {
             case EAGAIN:
-                /* Nothing on errqueue, wait until something is available */
-                qio_channel_wait(ioc, G_IO_ERR);
-                continue;
+                if (block) {
+                    /*
+                     * Nothing on errqueue, wait until something is
+                     * available.
+                     */
+                    qio_channel_wait(ioc, G_IO_ERR);
+                    continue;
+                }
+                return 0;
             case EINTR:
                 continue;
             default:
@@ -843,13 +872,32 @@ static int qio_channel_socket_flush(QIOChannel *ioc,
         /* No errors, count successfully finished sendmsg()*/
         sioc->zero_copy_sent += serr->ee_data - serr->ee_info + 1;
 
-        /* If any sendmsg() succeeded using zero copy, return 0 at the end */
+        /* If any sendmsg() succeeded using zero copy, mark zerocopy success */
         if (serr->ee_code != SO_EE_CODE_ZEROCOPY_COPIED) {
-            ret = 0;
+            sioc->new_zero_copy_sent_success = TRUE;
         }
     }
 
-    return ret;
+    return 0;
+}
+
+static int qio_channel_socket_flush(QIOChannel *ioc,
+                                    Error **errp)
+{
+    QIOChannelSocket *sioc = QIO_CHANNEL_SOCKET(ioc);
+    int ret;
+
+    ret = qio_channel_socket_flush_internal(ioc, true, errp);
+    if (ret < 0) {
+        return ret;
+    }
+
+    if (sioc->new_zero_copy_sent_success) {
+        sioc->new_zero_copy_sent_success = FALSE;
+        return 0;
+    }
+
+    return 1;
 }
 
 #endif /* QEMU_MSG_ZEROCOPY */
diff --git a/migration/multifd-nocomp.c b/migration/multifd-nocomp.c
index b48eae3d86..9a28ccafd6 100644
--- a/migration/multifd-nocomp.c
+++ b/migration/multifd-nocomp.c
@@ -66,7 +66,8 @@ static int multifd_nocomp_send_setup(MultiFDSendParams *p, Error **errp)
     uint32_t page_count = multifd_ram_page_count();
 
     if (migrate_zero_copy_send()) {
-        p->write_flags |= QIO_CHANNEL_WRITE_FLAG_ZERO_COPY;
+        p->write_flags |= (QIO_CHANNEL_WRITE_FLAG_ZERO_COPY |
+                           QIO_CHANNEL_WRITE_FLAG_ZERO_COPY_FLUSH_ONCE);
     }
 
     if (!migrate_mapped_ram()) {
diff --git a/migration/multifd.c b/migration/multifd.c
index 98873cee74..ccfafa6505 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -703,7 +703,8 @@ static void *multifd_send_thread(void *opaque)
                 multifd_device_state_send_prepare(p);
 
                 /* Device state packets cannot be sent via zerocopy */
-                write_flags_masked |= QIO_CHANNEL_WRITE_FLAG_ZERO_COPY;
+                write_flags_masked |= (QIO_CHANNEL_WRITE_FLAG_ZERO_COPY |
+                    QIO_CHANNEL_WRITE_FLAG_ZERO_COPY_FLUSH_ONCE);
             } else {
                 ret = multifd_send_state->ops->send_prepare(p, &local_err);
                 if (ret != 0) {
-- 
2.43.7


