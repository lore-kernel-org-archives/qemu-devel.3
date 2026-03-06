Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF676F513FD
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2026 05:52:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyO6H-0004fZ-95; Fri, 06 Mar 2026 00:51:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tejus.gk@nutanix.com>)
 id 1vyO6F-0004er-Qd
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 00:51:47 -0500
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tejus.gk@nutanix.com>)
 id 1vyO6E-0005ZX-8c
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 00:51:47 -0500
Received: from pps.filterd (m0127842.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6261tsqQ547682; Thu, 5 Mar 2026 21:51:43 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=proofpoint20171006; bh=1nFzDvd3Dl8fb
 W5LGhq+h5KlxnmgYw7XfX/AEUCRNT4=; b=dSq86GdcSbzA50abR1YLNpvs3syRo
 LFCAsafFbP5IvtjcHFem9Dlg62bobwarbz2LmWohrgNv1z2kOakTeI+GaIDmBnhR
 Qv7jjyWyYj4IayRaudx/wJsSanTLpIhDEXp2aBq6VLeqKCfbNu+fM6pa/QTgyvzL
 zROgp2+lenqocWf598X0sAkgp1+CHPJ7Y6TFEeGBYlnQdQBvGlw2UMpKDQODqqHa
 a1F63J1dB4U9CS1MNjGYiXRR+97F0fTiThUwhd/t6QDBBD/RxJMdkPj86O26DY0I
 TRKmmOj8+nVnMb4cUdg7PD1omyTn1yFkik+NI5Da1X/bnGAyZoVrfw5sw==
Received: from dm5pr21cu001.outbound.protection.outlook.com
 (mail-centralusazon11021085.outbound.protection.outlook.com [52.101.62.85])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4cpxy3v2f6-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 05 Mar 2026 21:51:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uCZutEhLp9h+7eFoIewzXf3/Buse/GDHeNr5Qly0fg0aQRvcCuI+2zCR9A7RUe1tUqlzIxhXjDX0moE7rfJu+eRLzgM6Kg6oZ4iL1pMuZ+shst4BKo1AUdu1s3yzSFlBrFpGcAbamYeL1YWxy3+4iqL2qnmyK4ijt+Lf+nqm2wjlgp2+eg7LpuiblpgJ1a/sV/AYyND0i5OyNpDMlq/zAo2JoczgwQVaVEDaLn00G1+misZX1/Ge+P0+19SzRVwF0orCTP4GrEQ15Z5Zque0t77CGq3nR1IwN5iMSdZN9Nw3OQddBWbxSO4oynBCRJznwk3JcR7udBxXSDF9vYDNIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1nFzDvd3Dl8fbW5LGhq+h5KlxnmgYw7XfX/AEUCRNT4=;
 b=pE4LRd4d/8tZrMVOXX1zTq6MtzGsgikex8GvMKYRFQdXeoWVWd4FhnV6T70icm6dP3aevUEfgqNoSjWjpYYi4YtzrERkzJUhlJtYvAwWDUV7TFthzdtt+Ax4mpH8scpfHlrpNMIbLlgsFUEo7Cuv4LKJ7QHvvmUXxiJluYOK1axTv8NvCXW3rMTeZ3kX+bRm7FjrcAykitVnW5dtmZpm7lEcOCGmJlMdgbiWa6zr+dL+/E45gUAbP2pvXTeRbMSQPfnYrBgj+pkSM14mkN9Xq04XA8I1c3Xe+1Rs4/9es4fdVjVzLbTfZ4GhO8HxDrdlkOP9lUZ+nLFLwvkL8ZVzvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1nFzDvd3Dl8fbW5LGhq+h5KlxnmgYw7XfX/AEUCRNT4=;
 b=fQWlAZMzRTHzTXTxSLfq8s0TvKrl/eALCUtarx6NrB0XDUMKG6/SoedkWDdGqFpLkNWEmrVtUwMfshPlDRgX3NdryFiw/KgEY8LMEnqHc9wjQXDjWZwHuAmn/y2wKh/saUpAuq6fLeWc/S2Qdgcns3s9w90FaJ2Mbxp+TZS2/p0ppHRO04w8rPNhIBlzILx3pNYV76LnI+iaqfL1U7hwX2/dfrW/qsQgxoyX6bTCv6CK62s3d9yEq4mMHy612Lwh+4uyg396gBv8vGh4ey+Jz7E9gn8RhZKPDkFpMsbCsZ4nn2rtWZZhLwFDogVBwHwR9/4hrfPtveJPLtI/CY6Usg==
Received: from MW6PR02MB9817.namprd02.prod.outlook.com (2603:10b6:303:23b::15)
 by BL3PR02MB8265.namprd02.prod.outlook.com (2603:10b6:208:344::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.16; Fri, 6 Mar
 2026 05:51:41 +0000
Received: from MW6PR02MB9817.namprd02.prod.outlook.com
 ([fe80::86e5:3449:a3f7:ee4c]) by MW6PR02MB9817.namprd02.prod.outlook.com
 ([fe80::86e5:3449:a3f7:ee4c%5]) with mapi id 15.20.9678.017; Fri, 6 Mar 2026
 05:51:41 +0000
From: Tejus GK <tejus.gk@nutanix.com>
To: qemu-devel@nongnu.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Cc: peterx@redhat.com, farosas@suse.de, Tejus GK <tejus.gk@nutanix.com>
Subject: [PATCH v1 1/1] io: avoid false zerocopy missed accounting on empty
 flushes
Date: Fri,  6 Mar 2026 05:51:17 +0000
Message-ID: <20260306055121.3277731-1-tejus.gk@nutanix.com>
X-Mailer: git-send-email 2.43.7
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH2PR07CA0054.namprd07.prod.outlook.com
 (2603:10b6:610:5b::28) To MW6PR02MB9817.namprd02.prod.outlook.com
 (2603:10b6:303:23b::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW6PR02MB9817:EE_|BL3PR02MB8265:EE_
X-MS-Office365-Filtering-Correlation-Id: 739d340b-50d2-44a3-852e-08de7b4470c8
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|52116014|366016|376014|38350700014; 
X-Microsoft-Antispam-Message-Info: KjaO7ccFDVXlxAML7Rlp9dKGDIisxqrQNWgfKyRjlOlwLuGYjSKoKhpv0g4XABKjdgUJlQniuTT4hR2cViRIWThnTpGMDzS6EcX+cRf3bJ3Najau/a6zRj8jMwJr4qSll5KbFWnCMldc+L0OckZv0rnKWUfRTsxo/ehfxPQ+fDuDWb+Xe6mDMaB9r0lTkBCq2UyMoP36rGYLYg+0qRwNkbd/LJPpjRwAtRKnDRkLrMJlCIIslsCz8DqAeYvtiwhX2UQcXi2+lFTM8d7sDvOKe81n2Eqa9JskfPiZwx3r1yGAvv9cidlmVrnAB6EMD30OJ0XZYCZxPx/4FUaLG1M/mcSj8drAimhjwNnn1h+HZ5sW/x2csgpsSzwoBEy587DJQSGm18wcJht6pGZ1WJqUILf+zHfnUF1zCEXQaY91OgINNnH0GpTAIYp4ToBvZrSZ95rYTgMbc31tqxGd//iIUFmziFrAQv1jodM4n9lYSp3tHr94t6GKY/UNbVRRolj/2BJztELG0hL8XyRexBfvHDbpQtyRNPjKwyze7gS2BiIS9BmQkO4tX6ar5Nt7QN4IJmuLSC+63WJvxFdPNO/kOGuHdEMpqsCXQSWLSBjBkzxJvj5XFUDmD6SMptFvZbV240DlKoGNLuYe49L4LqwurZ2htKUR+wK/yzPYaFt5+SlUXchJ8Qi3aP/e+Ao3EPJyPOemDPXtiv8ZhsKs7GgRWm4gqINXsE4I03y5EcvjosGe7awh/hbQX6YPwAE8THhJEXSvDZRhJAOixfXXWeQ2yyM5fZhFxZ48AdWLgGNTzMY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW6PR02MB9817.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(52116014)(366016)(376014)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dvysi7UcMrx7blTS8HqyM9hNKteoFNxb7v6o9oC3anXm3QCb7LF3zjBMaIev?=
 =?us-ascii?Q?h6ilSzzLPuw5jWc7EwuNNpuUPz75IJFaOfzuBrnYwUNB68SfXpucIcjboQgI?=
 =?us-ascii?Q?JfMeUplzQaw3zpYhS3oL4kGDNi8dXlbxMsd9dvDMZmPQWoJbs2jO5JclvEpo?=
 =?us-ascii?Q?C07WQN3juoIHtl0z6GiPWDVoZcQ2EOHge0OZHbU8OUhBndZggxK8MdD1VTpW?=
 =?us-ascii?Q?EI6PaH+Ethaju/ph3IAuu3lQowIImI2l+BmM5iiSw74f7gav6tqYLnycYJ2V?=
 =?us-ascii?Q?7lNrRTt7lXz2MaBF2lLnqyqvx6pPkkClROevGCLVBAkQmyHubeLcToiNMIeg?=
 =?us-ascii?Q?n/R8VK7P51Lpm6lzcCr4tyNc1ujDv/5TZ2/sk78UIFDcCaRSzGH7aGQbgF/3?=
 =?us-ascii?Q?JxiRPNmVzScuZUoivHhzPNRptcAUyy3dBWJbHEjo5VBKz5ccj78f8qhYsbXv?=
 =?us-ascii?Q?vl+HR/w3MnxPKnKytRgxm4D2Ln5kP4JBaPwphtlFs1B+cDXSmnMVkM0dNqN+?=
 =?us-ascii?Q?kObK7c1Hdpt8RmcfBByDBeMhkpj1W2TUT9az6ibifIOTjA01QwAHpkbrHBYi?=
 =?us-ascii?Q?x/dmsJIpCIKl1zahR5Aa+KifieFH9XA0050/fCKzcd+l8Evad/tn16perTQC?=
 =?us-ascii?Q?LPMPnxsaTiVzf/tfUNFYF3M0XNQgsesWH7fSnVqKdu56hklqYF4tp46fm9b1?=
 =?us-ascii?Q?d+YbcVsC9TbnLxNGO6l/Svef7whE389ZHTJkDYUTfBcBPoMiwCVSZ3u5+JBO?=
 =?us-ascii?Q?A/ZjjvfBqDMZYDJJffCtWxVUZ58j95BKzfOUFaqZ9kbew33kRPEBUx9QM1OM?=
 =?us-ascii?Q?xEJD16jpAE/kzTg1Zkfm3VzVPGwHMndeoOSyxEaHYVTOOGfOp2cterYgT45b?=
 =?us-ascii?Q?elp3VrqT5SccTk3efkGQM8zl1QR/rqKIHfidcjr9DVnLjZWBy25UItNTRw9i?=
 =?us-ascii?Q?DcCnfs2p2xYinDjrDKWnGP9kGoq6ERnWJTB+No46AKbBvtLmj675ZFTMNKeY?=
 =?us-ascii?Q?vajWR+oXZoJPdzUMqHKfO+uNLhR5zPX9WYnE/RxeP6igrhrQvhzze1+iIefg?=
 =?us-ascii?Q?hwz2MAavev+Km7j3GhszNKGrVrVCuvApdPs91bNUamReSKDy6uJkTf1N5PDD?=
 =?us-ascii?Q?0GaJ+9Rt9lO0QCUX096bJw3p0/6wCHRQ/3qMqnhJnBCdAVma4TjyVBId9VQO?=
 =?us-ascii?Q?+5ECLB3BFi3O9Bl8nuwBoyJnCXXdCJ5Adp+H+BI0P7A+E8hnmeC5QOlDL+w5?=
 =?us-ascii?Q?tgEVpjk0r7eBj1RGVDFNBNfTAOhWKKvNJEaLaksQz8pdCQhBRA7x02ir5SDh?=
 =?us-ascii?Q?fbPS+L2YMQ5+CzO9mywXme+G6FfPdPVgFEbPXzd69atVy2X3xzaXpVceK9n0?=
 =?us-ascii?Q?QdwQDSshXXyaUwyKiltlb3JGoi8iBnXiHL4xoUfN9PUesTW1/EvB1sQjzDdd?=
 =?us-ascii?Q?qcj6PcoicrJdDc7m+wJyF4TgSV9WIl0RbOE0q/hq3t13TTza+zNo3sA893PU?=
 =?us-ascii?Q?rNd2H0+TOvTaAvS57HUPoT6SHXrS95sLUKZqkthujG5C4XqqsapAR2q+7R42?=
 =?us-ascii?Q?9yeNCaWevPld66GQ3Btlo64T9o/d4tz90XQI1Yhx4TmZLzPZ/pMhlI5F8UoX?=
 =?us-ascii?Q?eIxo12exn+PAf+u/ldH2tcIIWdg7FmJrPx08pkWriThgaul1kgPgEEsLjRbo?=
 =?us-ascii?Q?i4GDCTnTD/cn0+DOg4yot5okRCd/iOXMfFfJWaLYjFST/brh8Nx9fcU/Hmb3?=
 =?us-ascii?Q?s5DvWh2c7w=3D=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 739d340b-50d2-44a3-852e-08de7b4470c8
X-MS-Exchange-CrossTenant-AuthSource: MW6PR02MB9817.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2026 05:51:41.5368 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P6njoqEJlTikPDqNZ+FPr7Fy27Oxg6CEPIeUwOGdhcxsZOpPVwBBQe+njD2j+AQFQipzGzCKZ4fJtgEOv54OCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR02MB8265
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA2MDA1NCBTYWx0ZWRfX/A1Uy5Y9+d5s
 scDi0Y9j4RNwvT6Fz97i80fNWqbxNkYsxAm0460RC1g7/p03eaOKqliI0vbjm8yiIizJhVYgDmp
 ietMDfGXPeR1D50VwYHgfth9EQBQuqIdctypKRK3HxH8F/YPlGDRc1A5mgct2htRI6OWq7lKTMP
 zfKO+b5waS5y8u5LGtXaGksyYr6ZSluBuOhgwkBzeak2gtuXPbgwQKznytawyZ9JeEmyugM7ruL
 3TwTv9+87YyUlnISulP0BxkGZBSlZthGctrcn9e+kwtAmvJrQAJ46Enz0mzp732NHiYSx9XRdgo
 hguOpfI04hhpZNNKmPlXkKtH4AZGoejxPuBGx3fk6tJpUBkrTXl1bMoqoStbwZKrNSC/M+/Kde5
 +8PC6/pLmNL5J+ViSG3WAiraoFaozfihWI6jMLpN59G50FNs+AHk3Zy6DkVNSPM4TS3wzIXeDDm
 XYA4dRTLkNKsx7fDDHA==
X-Authority-Analysis: v=2.4 cv=TqDrRTXh c=1 sm=1 tr=0 ts=69aa6b6f cx=c_pps
 a=1gZ91TOCrEl79GUrRCoc9w==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=Yq5XynenixoA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=VUi8bpU7OL1Oj2-RSIOF:22
 a=64Cc0HZtAAAA:8 a=qu98LU2OZziPfSONSQIA:9
X-Proofpoint-GUID: FRpVlsUbN0PSmtdUTUAY0kmwJRn2CHyK
X-Proofpoint-ORIG-GUID: FRpVlsUbN0PSmtdUTUAY0kmwJRn2CHyK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-06_02,2026-03-04_01,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12; envelope-from=tejus.gk@nutanix.com;
 helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -12
X-Spam_score: -1.3
X-Spam_bar: -
X-Spam_report: (-1.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.892,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.622, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

qio_channel_socket_flush could return 1 when no new zero-copy send
completions were queued, which incorrectly inflated the
dirty-sync-missed-zero-copy stat. Fix this by returning 0, when there's
nothing to flush, similar to what qio_channel_socket_flush_internal
does.

Signed-off-by: Tejus GK <tejus.gk@nutanix.com>
---
 io/channel-socket.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/io/channel-socket.c b/io/channel-socket.c
index 3053b35ad8..6f647e471b 100644
--- a/io/channel-socket.c
+++ b/io/channel-socket.c
@@ -895,6 +895,10 @@ static int qio_channel_socket_flush(QIOChannel *ioc,
     QIOChannelSocket *sioc = QIO_CHANNEL_SOCKET(ioc);
     int ret;
 
+    if (sioc->zero_copy_queued == sioc->zero_copy_sent) {
+        return 0;
+    }
+
     ret = qio_channel_socket_flush_internal(ioc, true, errp);
     if (ret < 0) {
         return ret;
-- 
2.43.7


