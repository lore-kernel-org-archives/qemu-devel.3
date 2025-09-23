Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC179CAC5A7
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Sep 2025 14:04:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v13TP-0006K8-Em; Tue, 23 Sep 2025 09:54:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1v13TL-0006HQ-LN; Tue, 23 Sep 2025 09:54:24 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1v13TG-0003wJ-1I; Tue, 23 Sep 2025 09:54:22 -0400
Received: from pps.filterd (m0127837.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 58N9HOcw2985801; Tue, 23 Sep 2025 06:54:10 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=RAUueBrjvE/oSTclWJbcOf1/JSu5pbZrgAEI2cAdu
 mU=; b=ut9NCcf9UKcMOsQ/gMr0EZCixHxC/zdg+bUORpK2uA2hdQ3g2QbCypheu
 HB/XQzqW3uO1pQ+PeGIK8nluMSI5JK3n6ELjQKX2WV/AjYKtcUdybApoFgtnBiyq
 NBaKU2WW0sUSxguR2gzxPhXxWLUjSSmlGahA0E7OUEn3Khyx4dQhOTKIMTalg7SI
 JjhCav/837vFl61/t+rAQVod7NF3u9SW0s4WsvRZhxegcteHUvUH2UyqQVBJA1Xb
 OcE3LAsBYX5G/kVcMZSDJgSLAIivK5VoGvWhlMKVpREgk379Xi2Qm54ThSmecjxN
 shB4ON8YRCcHI5d+MdoumKP2GLz3A==
Received: from ph0pr06cu001.outbound.protection.outlook.com
 (mail-westus3azon11021089.outbound.protection.outlook.com [40.107.208.89])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 49b6tju00x-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 23 Sep 2025 06:54:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rzIEMDY7/zwTmQ85zppOHzNNs2uGtIlu62gyDB8VC0u8AVWb6jSoEna18wbbHVeV6l40awBwDFxH2ip7qY2MqPi8cqEWTSpDM46qZACZeuXVOoRaI9F5SvZJmDVXEcgcLvJtSN4I/GgcGaHWvTT+hfMgSDz++WrV4HMLOdvRZjeC8CkoYEMbf8LLVVXX5smZAgAj6h4FbCCua5je6zTXuYXjLRqFmQXSdzzh1ptFsjZbevXj1SWchJ2ycZHyLnD9BDipg/g6IUkVr59/T7ZXrEJnF8Bl3m4QpFr1wGW/0bfG3IIuFFyIrLnFnF3PuHJkz2dHowaAtwH+3Y0us+PmZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RAUueBrjvE/oSTclWJbcOf1/JSu5pbZrgAEI2cAdumU=;
 b=lQ4exJGLzGeGhvpc2omBdnwzPAOngmErNC4aK7/WtgbmcwAS7whYzGN0kDxx0V1Up6fzxxq8GZtv2xQYb/VCH9+5jYckPwL3Gep5Rb888X4fuE/WrH9SlTWes6wyJkGHCHOIyXrOm0djo31pBHpHaQ+X1OmZ2r7tXrYMrf2BmXXImEZnhqLB6p6+2CVgNvfi0t6/nLzbPiifquLjm+ut/kdGtvlAAFet7ckckfj0zo0mp0DGLhFW84y1WJQVGBuWJq0w+q/rzMoHdI9maRKbGYOPyVE/Bo2FbRqawyaTTYASZoPy+ra9UrBVL5YHVwfIESJgA6gcwo27iy/7tW87Vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RAUueBrjvE/oSTclWJbcOf1/JSu5pbZrgAEI2cAdumU=;
 b=yVqqRiQqv73ts1ssYO/z7HCpVU2CAlIY4uMjetswaDNZ6QOANCoKcmbYWg/NzD5QSciV6lof26sU2ZAuxJRWZRcqhJ/TX/tz4d6fjw2YSO/hMqdkiknTXhz5gdXOw/zqcf6bSLSz8q92kINTqXraXD7m4xMz5s0t2AOT5uop4po7JzOsc5e0vzFm7iVXxPbue2xAP8EWMHUyfMSujS8P50YwMD9v/930+5zISEUx1Oe9FU2kldxYiEt7mGuW1KR8Izmby8F1Bpsb4gnPjySNUtQKc5Gr6G08fBgTc1b44/KBZG3ISQbQLNyYudwn3yoKBGrbnP4yc3eWZwF6HTN42A==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by MN2PR02MB7037.namprd02.prod.outlook.com (2603:10b6:208:206::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.19; Tue, 23 Sep
 2025 13:54:09 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88%3]) with mapi id 15.20.9160.008; Tue, 23 Sep 2025
 13:54:08 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: npiggin@gmail.com, harshpb@linux.ibm.com, mjrosato@linux.ibm.com,
 farman@linux.ibm.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 thuth@redhat.com, richard.henderson@linaro.org, david@redhat.com,
 iii@linux.ibm.com, john.levon@nutanix.com, thanos.makatos@nutanix.com,
 clg@redhat.com, alex.williamson@redhat.com, steven.sistare@oracle.com,
 qemu-ppc@nongnu.org, qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Subject: [PATCH 03/27] include/hw/vfio/vfio-container.h: rename file to
 vfio-container-legacy.h
Date: Tue, 23 Sep 2025 14:53:09 +0100
Message-ID: <20250923135352.1157250-4-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250923135352.1157250-1-mark.caveayland@nutanix.com>
References: <20250923135352.1157250-1-mark.caveayland@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM4PR05CA0013.eurprd05.prod.outlook.com (2603:10a6:205::26)
 To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|MN2PR02MB7037:EE_
X-MS-Office365-Filtering-Correlation-Id: fb8341e0-aaaf-407a-9430-08ddfaa8aa6c
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|7416014|376014|10070799003|366016|921020; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?XkzSa4QYz4UYIEv6vSG/nErmpzytBYNTDk5Sm0JtsMZl5OpkN2Z8Y0QkdomO?=
 =?us-ascii?Q?aMiNUyIxIRcJlMmzj8pixP1gbRtkhu47vwjZWdTqHdocOpGlMXDMz/xYRwKl?=
 =?us-ascii?Q?BRf0aQ5Pn3ubmCQwWjrWFtQN6GOlhf+uvlMSZouZHuvH0bZqf/V1j7A8dHYj?=
 =?us-ascii?Q?Ceh3Eer1h4TD75kpNZur+JOJ6As7Fl/fjYEK7YZQGf2ktYGLd2j4IMjIL/V+?=
 =?us-ascii?Q?6GLdTddGZe3nnciuBFVX+H6CDOgZJwbD0rs3ufDwnLPM64rWlKNbLBWkEl68?=
 =?us-ascii?Q?mGrmAkHAR84a0CeoSox6ViTKADsqD7nYhHpoymj0fn9VYuErDAd6JA/X6puD?=
 =?us-ascii?Q?rrQjxTsmcCaVwf02Fcg0e124Ih7y/2kKr+9murlfplGICt2UjVu+dbRF5V/7?=
 =?us-ascii?Q?1dxzhiQpBax0MWgXL4tM55qPxwrZNzBMVjJA8jd3ewc4/P7/vqfW1xZBm4Pz?=
 =?us-ascii?Q?K1xcUzni7pt8ve86lSKy7nEIYfRpJfymDy7FIIK64bTeFevHOIGzztJE2tuJ?=
 =?us-ascii?Q?OvnTgbO8s7QaqYulptiNvaIQqJGxZ2JWHpNQrbjV6733zuS9iL5SKISNvKyk?=
 =?us-ascii?Q?EkY0am3oeLo9KclylCb0zUSmGKOYX9PpbqDJUBRaSdcd7eZEtj1rTqy1a/VR?=
 =?us-ascii?Q?eO46BKXV5uxezthO5xqeAQ8+LNkrSiQaZFjKtAuxIHm2Q/upg2gyR+s3XOoA?=
 =?us-ascii?Q?MX25uXuK/Mm1umR4k7rgOVS3aShwLhghrA0CjrQaSODB6Fd0GVb0zTq5OTAB?=
 =?us-ascii?Q?KrJpPKBLOf+nyPSJKN4BHEHSE2zGixcip5PZ67zv3L5aebz4U6hLF8EwbxtW?=
 =?us-ascii?Q?MaSyZga1dUwELy5LIHPBMYDhsLgT5SVi6mEl2M+8qUAnVMxMlc1nO4wmO6Fc?=
 =?us-ascii?Q?hbEJx226jrAsT29Mmi3OR4652CfiSdX55JIEoGdw7DHB5P/IeIAw6LLUtjPh?=
 =?us-ascii?Q?54IW0fRvVmHY+DylIqnqCVlbYZpp013ypbY6s4UwObM1Anjr6pW/HX8SHw1U?=
 =?us-ascii?Q?VsYbXgUBX/D5BZzR9y89Y0ysr+GNRz4K0BkWweze3datQSt7xVePh5uSswHB?=
 =?us-ascii?Q?4uYnra3lxsD0JafOiKmykKA1R70I1xwmMKjSHVAa7HtuTDFmqGNlAchAxUuG?=
 =?us-ascii?Q?/VL5o5KeuwNcLy0MBNm3SxEW4n+Ap/mx6i8qccKF2W2EZiP1KzgGQJQfBjEV?=
 =?us-ascii?Q?PFe9RAmRThYW63MYcMmSJodLCO1xZukwswlgbZXYIb0Q+KUIbpd6+wXsshft?=
 =?us-ascii?Q?dOtWYWsW0+lSTiHjI7IeSp2zkHyXT575D2Tu21fvgdL5/aZz3vz93/VnyoqD?=
 =?us-ascii?Q?5wOkE0co66/AK9ehX182X3MjuL6uUen715/QtGiXu5Xb2xsnF35H96hFzckX?=
 =?us-ascii?Q?wlBclp+m+QuFDhdeJ9Jbj9jzcmf1i+VYiRsneyVUEKXYND3+yzhKnG3edeEb?=
 =?us-ascii?Q?tpUMKWytjQsStY25eeWfGKsFBZyRic6PBQuHBWLTbbTUTb2n85FeoA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(10070799003)(366016)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zsGX9wcd+r1swQDlPTUK5YMia3gpxTSYqjbFEWshbd2rc+JmEIKkE4gM0TqW?=
 =?us-ascii?Q?hi8HoNLDLTUQI/5AKC0JTnDPVCcZp2tLkmN513D1dChKfG0tw8MtMAg5XXCe?=
 =?us-ascii?Q?3Du8tqJ3mqxPXrVMuNgEZdmsytWLL0pwvOBPFZHnpToxjAU6OrBYOyFpyjuH?=
 =?us-ascii?Q?Zehb1NTRt7+7lRNnX87L9bp/bKsqIJVHte6tvFEXTKXx13pMZgqYY6KIKmoF?=
 =?us-ascii?Q?SAi8+gyPOUZyQnHXCt67kpKNcp1CpMhnINkN7KqPJEqEYrTDaRm2vU4zYyIy?=
 =?us-ascii?Q?fNPeTgRupVKGLfQ0yxwsNmzZeM/QFAEKut2vFH003LGYRjW1D+2o6c0mXTu9?=
 =?us-ascii?Q?+QjROGujs21JU1PIcTCXualidOqq/YzCJZP6eZ2G4+4iIYYC3m5UKfUHO5kF?=
 =?us-ascii?Q?sTg+POWHZbYB2Hh22WXj9OSHtO+5dVY2LrcjQAQM1JpI0zqJbZVpCH4gX1+S?=
 =?us-ascii?Q?tePYTcINbvkznbeVwWrgBrRnTlhWWIEDlOrrh1JtAqwpZW+weUF0YfW8Ir7J?=
 =?us-ascii?Q?7JTxouA6lvbZnx25fM7zkIpbVshUb/S2ftwEuILmfzzzSFSwkGHLyE5m4evP?=
 =?us-ascii?Q?bA+gmVyu+IFDDUsRfBfDt3Yogzll3DwDhZc/eM1YMAtoy38YAAe/PzdDIhBF?=
 =?us-ascii?Q?hxNImrkfIPjXad/kgO0xQb9pfPfiAMEbGqdkruVd2qNx41xlTYhns+8bnusm?=
 =?us-ascii?Q?fdFNlXnVuZ/ezxPsGCZ8BsdvppmQWIfdStO1UpEE82W/dcVlkzszSiD/WPK0?=
 =?us-ascii?Q?SJlipq6lw1ulg+d54zKXDrjcSInl2ov6thzTLvI06F5EWmrRJmAP6R54t2Nz?=
 =?us-ascii?Q?s43iS52ofIKVnbEBqEyOJjG6gpIY8GVnemMK0W1wi101qXpNKbC3MU9gFEe9?=
 =?us-ascii?Q?7jC/54J7ueBZ73vvYW1glPAIeo2hTuyGo30mGIIi5+oJVtakDip7+pvquoiI?=
 =?us-ascii?Q?KG62dL13JzeP09h7ayLVcCbJx0Il5ZXm2kOPQU2m8PZBAgRr5qT9Q5Z15sks?=
 =?us-ascii?Q?uYcNXD/E4LmU4/JoEygx0dgy9gNMDcrOovEAzzflZF4h5htcXmdOdun81jiZ?=
 =?us-ascii?Q?XbfkcaM9E9795y4iGm7dPo3+awT4Gt0wfhUg61FEeamRvhxq0g17AHTIuhpX?=
 =?us-ascii?Q?SeguXuhzx7upq0jmZEWxycFTMajCERvVUroS7uTduNUn03gNqWyR7eEI1M2f?=
 =?us-ascii?Q?QnbSy6zlp8J64r47ybo2mhp6w09/wTtB6o9BONv9LdMEWBeGTf8YoSF6zEZX?=
 =?us-ascii?Q?KNeELH/thLlfQz1FbaG4smUZpGR21CRtSBKpfUFJea7Hr+ySRzMeKpX5z6cG?=
 =?us-ascii?Q?lbAgVbdE2Y1mBv5hmqx0pOTVKskUIfU3h8tgd1gE9op2FU9pE2m0VVrOCV33?=
 =?us-ascii?Q?CUxizhJ9ClCUwSDgfp1zvHrgKHHi9WC2WAn286DEB2K1pNv4TJTx3LVZikoI?=
 =?us-ascii?Q?i/+F48OfSw6fG4YgS/jMH0GaUlscKY3enKgwPUoGwJrjRX/UYPUwEFvFS3hW?=
 =?us-ascii?Q?ljGZw4m0kFZ/tJsput0dcL7jyfKOWqmxzwGl8rCscDoVfY8fsb6vwwguN0E0?=
 =?us-ascii?Q?NmGOyl42FbipVMuhtkG3h1F/YV8L8RgDAPbJhBTWJ1hZkamP9q0zCsyL/95I?=
 =?us-ascii?Q?GqKESqkn8qzjAxGEZSzbcpxqK2Wv1AjEDab1DtSXfbS4p+rSadbJxR8OA5Cr?=
 =?us-ascii?Q?MWCFRQ=3D=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb8341e0-aaaf-407a-9430-08ddfaa8aa6c
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2025 13:54:08.5957 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MHrqi2tbs8l2Gr7SEj17ZGxuXmWiT2ynmeYw0xDvIOVO05V7iq+fnAg2iyCAjIDy+ogZAPoFAwFqc5nsKzHflEmdlxkLOTZitKBsJSupe44=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR02MB7037
X-Proofpoint-ORIG-GUID: BAo9zJ5moNvhGLA-4WCMEsmiqpzcqbgV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIzMDEyOCBTYWx0ZWRfX2S5dzn4VYEJQ
 7l1HtBG7vb+H0xCJRIbewrXHDZ4D6rVi0BfpcQoHwGuBbliLy1NqonWt1NEO+fNTymoKQOehLzB
 DmDL2VVfMssS67Hxq53BT1aQdEU6Ae4b3C7P1Smli7DRvdre6MKzmrAQFay5JFjy6blaiR/6qkr
 0XCjaO1YjJNK6e5/oMb/Y2CFo6zZth3rBbuY1pwu4u3iOatdYcIvBVz0oCr2twdQ+KA6HPTsP+V
 v7O5rYCxTndlMXpfs3fpmPYSclVgI1bJsY3QwDiYdpB/bFLkK+wZGna8JQ2RMtGe2k67lqwnKF0
 eWrt1dL6xMa0hPin5zMhAhq6TSHxFva8XofEJIJ/7/PfRRlOMOE7P+0r9/4y2I=
X-Proofpoint-GUID: BAo9zJ5moNvhGLA-4WCMEsmiqpzcqbgV
X-Authority-Analysis: v=2.4 cv=BJSzrEQG c=1 sm=1 tr=0 ts=68d2a682 cx=c_pps
 a=rgmdkwC1tPsVJMj+r4rvFA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=yJojWOMRYYMA:10 a=0kUYKlekyDsA:10 a=64Cc0HZtAAAA:8
 a=txMtgCL7_LO3UPI1MXEA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-23_03,2025-09-22_05,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

With the rename of VFIOContainer to VFIOLegacyContainer, the vfio-container.h
header file containing the struct definition is misleading. Rename it from
vfio-container.h to vfio-container-legacy.h accordingly.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
---
 hw/ppc/spapr_pci_vfio.c                                       | 2 +-
 hw/s390x/s390-pci-vfio.c                                      | 2 +-
 hw/vfio/container.c                                           | 2 +-
 hw/vfio/cpr-legacy.c                                          | 2 +-
 hw/vfio/spapr.c                                               | 2 +-
 include/hw/vfio/{vfio-container.h => vfio-container-legacy.h} | 0
 6 files changed, 5 insertions(+), 5 deletions(-)
 rename include/hw/vfio/{vfio-container.h => vfio-container-legacy.h} (100%)

diff --git a/hw/ppc/spapr_pci_vfio.c b/hw/ppc/spapr_pci_vfio.c
index c8175dd8a8..a748a0bf4c 100644
--- a/hw/ppc/spapr_pci_vfio.c
+++ b/hw/ppc/spapr_pci_vfio.c
@@ -24,7 +24,7 @@
 #include "hw/pci-host/spapr.h"
 #include "hw/pci/msix.h"
 #include "hw/pci/pci_device.h"
-#include "hw/vfio/vfio-container.h"
+#include "hw/vfio/vfio-container-legacy.h"
 #include "qemu/error-report.h"
 #include CONFIG_DEVICES /* CONFIG_VFIO_PCI */
 
diff --git a/hw/s390x/s390-pci-vfio.c b/hw/s390x/s390-pci-vfio.c
index 938a551171..7760780aff 100644
--- a/hw/s390x/s390-pci-vfio.c
+++ b/hw/s390x/s390-pci-vfio.c
@@ -20,7 +20,7 @@
 #include "hw/s390x/s390-pci-clp.h"
 #include "hw/s390x/s390-pci-vfio.h"
 #include "hw/vfio/pci.h"
-#include "hw/vfio/vfio-container.h"
+#include "hw/vfio/vfio-container-legacy.h"
 #include "hw/vfio/vfio-helpers.h"
 
 /*
diff --git a/hw/vfio/container.c b/hw/vfio/container.c
index dc8425efb1..c0f87f774a 100644
--- a/hw/vfio/container.c
+++ b/hw/vfio/container.c
@@ -34,7 +34,7 @@
 #include "migration/cpr.h"
 #include "migration/blocker.h"
 #include "pci.h"
-#include "hw/vfio/vfio-container.h"
+#include "hw/vfio/vfio-container-legacy.h"
 #include "vfio-helpers.h"
 #include "vfio-listener.h"
 
diff --git a/hw/vfio/cpr-legacy.c b/hw/vfio/cpr-legacy.c
index bd3f6fc3d3..bbf7a0d35f 100644
--- a/hw/vfio/cpr-legacy.c
+++ b/hw/vfio/cpr-legacy.c
@@ -7,7 +7,7 @@
 #include <sys/ioctl.h>
 #include <linux/vfio.h>
 #include "qemu/osdep.h"
-#include "hw/vfio/vfio-container.h"
+#include "hw/vfio/vfio-container-legacy.h"
 #include "hw/vfio/vfio-device.h"
 #include "hw/vfio/vfio-listener.h"
 #include "migration/blocker.h"
diff --git a/hw/vfio/spapr.c b/hw/vfio/spapr.c
index 6d462aa13c..acaa9c1419 100644
--- a/hw/vfio/spapr.c
+++ b/hw/vfio/spapr.c
@@ -15,7 +15,7 @@
 #include "system/hostmem.h"
 #include "system/address-spaces.h"
 
-#include "hw/vfio/vfio-container.h"
+#include "hw/vfio/vfio-container-legacy.h"
 #include "hw/hw.h"
 #include "system/ram_addr.h"
 #include "qemu/error-report.h"
diff --git a/include/hw/vfio/vfio-container.h b/include/hw/vfio/vfio-container-legacy.h
similarity index 100%
rename from include/hw/vfio/vfio-container.h
rename to include/hw/vfio/vfio-container-legacy.h
-- 
2.43.0


