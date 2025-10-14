Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1784CCD192
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Oct 2025 14:39:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8g9n-0004LF-Pr; Tue, 14 Oct 2025 10:37:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1v8g9M-0004J3-R8
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 10:37:17 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1v8g9D-00009V-Q0
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 10:37:16 -0400
Received: from pps.filterd (m0127841.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 59EDV6LM032806; Tue, 14 Oct 2025 07:36:58 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=K1Ilg6ndsfYveaHapEZuM+lN9zx7LA4utFTem6XPj
 Y8=; b=d35qu9RBp7YPXUeudbauWWo4GX5uURQvtxUbJgjS03LeH94MdchyIFenk
 wQV0jTh9I3Vc5PBtaLbvu6TfP9SIjSXQVjiNOwr1FtQfBHrlQLHZRiESMuCnt9zj
 PUjZo+gNvOXICzi+7/WP8Xlt50yxx/n7ajN8RPx+4qM433eJ81VzuKHtOp6Iw5aJ
 8G9RuRWSdfy74m/u41RdKCHNxuIhawjEiPceDHyXJDF5hStKu/Vag8ttfE/HM8Se
 FpFpqE117GvmU2yK8ZxUrNQ3IeEL1BSpIbjqqolvzm5ooOAsufWTA9CsHe3F5U5W
 Pyl02+APICdgn96A7h3J+pJkoHCBg==
Received: from bn1pr04cu002.outbound.protection.outlook.com
 (mail-eastus2azon11020074.outbound.protection.outlook.com [52.101.56.74])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 49sfucs9v6-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 14 Oct 2025 07:36:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t55ZU1h/NXB7eIc5nHSmXwUBPbP1HZ4fDaqBlnSNm6mrp3ZuCmtHqtXqZvl48Dmhdv6GwFg07VKoSfjF7JCkRNd2cdNxh1D6pP+BXF69RPbJ8QM/Oogq1SjhJ5WpkunbYnWk31ByxrULrING+TpbsEnk6o+CPT4gcOmECxAwPV7DhorTLM2j+l/t24OC3SZxtlwPfL8HmysyXhurG4thsRvz2vX6RN0IzXpLdT0IxA/yVnFkY90UFfeGKcvKYMgcbSjIM8CMdSsDqAEw8CWeiMCetJtnDW+JUubgYSgc+Qy11x9EiplyWwX1dEc8MUZWi9lrriGJQtdhvK6FidwNCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KjJ8yNHN3oJnqnwzDzGstLi2E8s1V26zGyLTUMbvWbU=;
 b=KKZNzDCosanrzmibd9uOtxKHID3c+MmUGoTgxts91/oBe7794+JCLoxGisN+RiMzCiCPi661f+STXZPgHKc1FvllqgRBnfMEEMZKwrmPTmLbsAOp4vaIyA251Yg5WaULtgDSAxuRk0NX9N5OFNWsiHvMjvFwsRldOycMsMuNASgoygwh7jenVQZjfPr2ZljYgP1b6j5aGEoT8eSvP+1mJNLkU1hBPIFs8W3RK1IqsOQohRFBGg1tRCoCtmCc+pemceZFXHEOZWFAljeknhTUFXMPBuQ36G1iGb0KGww0DRITQsDD4D3dX3T5fhE0xdMYJ/nGkOE+jYfp3ZEnL3F5Ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KjJ8yNHN3oJnqnwzDzGstLi2E8s1V26zGyLTUMbvWbU=;
 b=ygT6NmxVUTajOcFk3s3KFx2JFtZKIFCcEZT3JWgo7Krv6D0ax26dzXNMEXGkVdLvnQ8FmJFmm08MpfKTZEvACJ3AVRAbBeujNJ19L3LdQ90wZNEzZQGe/yikoiLCP4MFhKXeR0BaKJyupARZ73D6A4VTjeR2v4U/XD/6iLKyUr746zsDRr4cLZvWvaYlbHAZtBW9udadDb2kkPiGmTWCBalRz77dU09gU0gxK7t1hr/Q1vuzdH4w5MxcxFPdfWhHwGhwkdE151+c8HlWu8eXUKl9uDLfLiVZWOLSout8mQjq2xHvHICaW4VeBwVIqbEvs5aEDBzv0Y6jU4oNnR4eCA==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by BL3PR02MB7939.namprd02.prod.outlook.com (2603:10b6:208:356::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.13; Tue, 14 Oct
 2025 14:36:56 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51%7]) with mapi id 15.20.9228.009; Tue, 14 Oct 2025
 14:36:56 +0000
Date: Tue, 14 Oct 2025 16:36:52 +0200
From: John Levon <john.levon@nutanix.com>
To: Alex Williamson <alex@shazbot.org>
Cc: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>,
 qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>,
 John Johnson <john.g.johnson@oracle.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Jagannathan Raman <jag.raman@oracle.com>
Subject: Re: [PULL 25/28] vfio: add region info cache
Message-ID: <aO5gBOLVt9R4BFnW@lent>
References: <20250509131317.164235-1-clg@redhat.com>
 <20250509131317.164235-26-clg@redhat.com>
 <6519c5b0-46d2-4097-bb37-7a78f9087f68@redhat.com>
 <aO5RAIX6WI0MerI-@lent>
 <cb4b8412-f1a5-4c7c-b2f4-d65b72194412@app.fastmail.com>
 <aO5XeknOrUtvLJO9@lent> <20251014082937.7de6f960@shazbot.org>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251014082937.7de6f960@shazbot.org>
X-Url: http://www.movementarian.org/
X-ClientProxiedBy: LO4P123CA0592.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:295::9) To CH2PR02MB6760.namprd02.prod.outlook.com
 (2603:10b6:610:7f::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR02MB6760:EE_|BL3PR02MB7939:EE_
X-MS-Office365-Filtering-Correlation-Id: 849aef00-86f1-4735-f66e-08de0b2f1fd1
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?5PJ1FzzJXyE4BN+PoKcjmbTEaujv8PLIFmUffrjn+JNWtl4M0xto4PeuRP?=
 =?iso-8859-1?Q?QFIWuvlki3kTYbuHiLrMhQEIT57eZU/nD/0N/ce0xY/pES32sU0iHXrn5B?=
 =?iso-8859-1?Q?mkoxuvBkjvvHKxzo1UeJLUe1jim1oGNrAEDgV+oRmVD+20KcLixUdw+KlR?=
 =?iso-8859-1?Q?TKPgjlxDsqQynYjKgJeKDoiXsd/NcnQZkEAm+ULAXGNPkUph2iVwghHYaX?=
 =?iso-8859-1?Q?xPLcCTp+QrVlPkw9HZGallIPPomkd1MxXS7Sf9HYsc6zsT+vCma3xIqa3p?=
 =?iso-8859-1?Q?wGA9DZaXf3f2YxQ3IFrHqPHmvfx/mypS1+ziX+V2G+EUF0HuRsBx+Kijq0?=
 =?iso-8859-1?Q?y2ih4Ac8h1dVJ2Wl5m17lxiIp9cTiJCPE/fs0DcG8zmQMnVpfEddweGOsV?=
 =?iso-8859-1?Q?rknvTdCI4MqT+YfYckym2dxCCzwZQZabUR0w9KTO5uOazg3I+IwA0iWzNm?=
 =?iso-8859-1?Q?tsL1nXxhK1wFUzYSrus2XRsCDN94rbxa/bwrspniCGjypIyRMwHEvcEsd/?=
 =?iso-8859-1?Q?Ed5c/1HreizM4LcVpn/Uz+pCRnU4d/JdxfCMmbgDJN3GjZZV++xMcdI29W?=
 =?iso-8859-1?Q?u8uat5YoGDS+nSK5PmUzNVrof91TQsrsZ9r8GOPWpu5KdpoqTdoBzf8DuB?=
 =?iso-8859-1?Q?oVryHq7OH6J1uEskJGM96nKszfseQWa3Hf6K/aBFzs9zFU/PRlgg7Rsi+g?=
 =?iso-8859-1?Q?5yhp46mmkXSJftrnr47yOJvEv/OdoDWOHak3Vf4cxZ22u06ehER+mfgvdR?=
 =?iso-8859-1?Q?OO+Bsa0jfutNxVwndAdqzszBApO1YlwxttQiZhTld1CfONhN9rTSjE5U2f?=
 =?iso-8859-1?Q?kcohiJJI24eX56moCje+0wTpKZVZCnCnnHUjK0vwM5LQMMKw9CAx7seZGF?=
 =?iso-8859-1?Q?Q/zeK5gsdA7St396W8JslZpUkD8dkPKqh3c01XBZ2dOsyj6sZVO8FbBi4l?=
 =?iso-8859-1?Q?T+7g+BZMEUPCIdhoZ0SlH6zciYSHJaP1Ej7di9ZunExo7/S1ldo5iKli4A?=
 =?iso-8859-1?Q?0EQZ0AlSceXx2MxWVYW8j3yiEMncpvqPTOUHnqNUFV02ma5hx5pwWCAL53?=
 =?iso-8859-1?Q?92UKXubAppRMRhnPHbAAj4dQd+rsrbW2d6MLQBl4hmkNP1VZeJL4pBsIt8?=
 =?iso-8859-1?Q?SwfA/cctNf47ql2m66ubyyW8pPWaHFYUk9/i18x3Z3S8TRDqTk3jW5BFRL?=
 =?iso-8859-1?Q?vk5kfLwtlhtb18e12kYQxHzXQoYXSbhhYqgCwMeGbl9fvNtP62DXWW9NrZ?=
 =?iso-8859-1?Q?AoKXLIkGK3WO0n5GEX86OWB/eYoP4bFHdOY19DDo4rpiGU4lIhfRF+D9LP?=
 =?iso-8859-1?Q?GZbu83xlxk0MDsdO0mXXoEOqU50YTdY+BmduJnvqAL0Hq9mYR8zztMehcX?=
 =?iso-8859-1?Q?RB1Ti4krZcumulc+j9SVfT2Q0CQv89YC6BZmugrkuMRxIhYfgCQWARg9vs?=
 =?iso-8859-1?Q?QG6QSJORj1+QqrLiTvOPI+fdje9jfXH1eproV/26n42R8SzGwKQcMnVJVf?=
 =?iso-8859-1?Q?1UZtjL1jJmy2ZEWY8lMRLg?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?ozewhaGEAPuki/fjsrlM/9bU3YrTPi7qSgnEr2QTP7E5j0D6EdsfxQ1yo0?=
 =?iso-8859-1?Q?9DfXuuHehmgZDbgexUDdK5V0ZP2b/Ec9xKTK17DzfoG5WwfulF3lpwzWy9?=
 =?iso-8859-1?Q?gLvt5klSTueCcUQXKQ2QimapTQQQRVccytfT2Dbyomcp9ziMD470Uog9Ff?=
 =?iso-8859-1?Q?8J8fXnAHo3glTrK14s/nF9Cj9WbnEbR+MzQ9vJMzQe6HkTudQxlZKRp7Vc?=
 =?iso-8859-1?Q?YaqElb5ywI/Y/7IqZCDvb5cG1/0E9w/yHo8tFbsSVuk+GwNchyVX13yIH1?=
 =?iso-8859-1?Q?DlLnwUGYKS6XcDP550JAzHbW90OvCKxvwpyqRUetdfXl1LzzosxO0/JJ1o?=
 =?iso-8859-1?Q?BRGAUrRx/HDRxXB/rTJddHfyuYxOiJs0/qrEviECzTOx0Ue/Nj7xNr2KMd?=
 =?iso-8859-1?Q?T9z8dgRirbKRWVWomvWWJmh5sAkgm8e00u4s3aPfJHSd1uTXkEtgKymoBZ?=
 =?iso-8859-1?Q?VYnwYZ+MBoc+qiYg6j+5gc0hB6y4bS6JKhS4OsazHhydXNPqXJp4AFcRTn?=
 =?iso-8859-1?Q?5u1Ppth2dOUrwCugKjMjOYoOUlrGzI2UBdMAAXUdd3En8QP+nSfKWFgILc?=
 =?iso-8859-1?Q?XRVoGjeXSlShPMhUs/aUL2rw6C0HCT9e2xrRJpUbDaBcSK4N68rPCzMNMe?=
 =?iso-8859-1?Q?q1uEryjWyC51XBpLAtQ561OKdK/+umnngPGWxOQh4/Aqst1C6yc8cXCj6c?=
 =?iso-8859-1?Q?b/sLyhdQbaxYCpJxCBqdtO2E8SiFqjNZW2tqYjqiSWNpnyfX14OrM6iXiB?=
 =?iso-8859-1?Q?G1TspzG9swl9D8pFTU7lpkrLBI6yGdGDx09Wewlm7K46+oD+79AzqJ2L0g?=
 =?iso-8859-1?Q?6lMtxtm+t4qS1Sp4EcSx1g/7JNSSNawkP2t5l/pwXs8oOeZrX7/pCUvnSd?=
 =?iso-8859-1?Q?hOMlC6nsXHub0gGxJWAmqJv7tCEvOnbIO438mCR4U6CHbZYIiZT/E2M1Sn?=
 =?iso-8859-1?Q?Q1KqHowNmxdla2tGwyPJpB9xN2ONyBw23uU2kwTbNyy7XSRMU7g7yguyI/?=
 =?iso-8859-1?Q?c8uoo9R96/+MiAtOSwCEMNml8zgljdFoMePPmlSbsRaKLg439muoKRhQFh?=
 =?iso-8859-1?Q?eH+EaFIMGy5JTLjtNkfrl/JBYSn60XNfPl0tGWWTP7qERPSUCgKZkLAAAL?=
 =?iso-8859-1?Q?1oAWPfTYSO9f4Ar3DQ/lPgBDZ0L8PAK3Xz+MIe+gRg5qCWKeOEhVmWuQvO?=
 =?iso-8859-1?Q?M67GJex3MOKzWFW4Q0GTN3B/8qwQompZBmEp25ugU8jbuUXwxv1Enr3LrO?=
 =?iso-8859-1?Q?/ImvlraIZH7YzE1p8LI50a4vbAu6bKxTx4e3s/D4nAT/nWI+TqiOj5bnj9?=
 =?iso-8859-1?Q?H+n6oCI9raunC4Z/Kg1bJld3dFxM9qdUmvvNCQ+A/9v+puYIzrOhP9nRdl?=
 =?iso-8859-1?Q?7IH9vrMIck6U5dAJDrUuWr+E4BTiFaM30N+k6c6GYNx4E59RmbogK0jfHt?=
 =?iso-8859-1?Q?yhwFa1HVnGRcTzux2mktcXpjDcbtJClhl5AJyd0/jowHIa8jTN3IPCXKaO?=
 =?iso-8859-1?Q?ge65UNkYyTPCI/zFNmAqyxQIvg4GsgtQzu2EYxPvJmxIFhvKa3tMcBNHCN?=
 =?iso-8859-1?Q?4oYPtjYUMA3Oa7ntO/uy52dJXmi8/e3lg+YxyRx6YNPKa9Rt0MAUzdUiBv?=
 =?iso-8859-1?Q?H7JsEQLDkyzyfVFQ7elb6VdybPM1QZVaXi?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 849aef00-86f1-4735-f66e-08de0b2f1fd1
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2025 14:36:55.9740 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W6vM2ZJDonJItvSg660H1pMcu6vu/X4R+PLhnGp9pshuiiE+D5J8XOptMfCggrvO+GNqfcUTgD5AOkSBrwyoeg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR02MB7939
X-Proofpoint-GUID: 1Lw5IKG0hHnkBeYbdv8CVGTNn_tW6Ftc
X-Authority-Analysis: v=2.4 cv=KtdAGGWN c=1 sm=1 tr=0 ts=68ee600a cx=c_pps
 a=Syn3MuHMyA8lBdxmL2NqkQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10 a=x6icFKpwvdMA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=o3ZPg64E6oGhTdjHphEA:9 a=3ZKOabzyN94A:10
 a=wPNLvfGTeEIA:10 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: 1Lw5IKG0hHnkBeYbdv8CVGTNn_tW6Ftc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE0MDExMSBTYWx0ZWRfX3uSsrbOd3p4x
 +JAPGw/XRKu+1Efnh3ncsDqz/GiCgh5dP35Sd9Z5XoCK7koPkbzQvYcLAkLYum++r9UCAypyqk2
 lVHKR2vrD9UBeKFvtteWavahUkNH8AuqhO/kZlhJG4MnY1bEXlSTA2m2/A3ScWFUw6hDZThWi3B
 vlWB5PsFpWgp8VRCh3EeMvWgUVnEUaRXGZ3xNQiPQ9mP0SKy+t7/bfujVAXhQMD1kL8paB5spCO
 kQ6jSFpDjJ2B9T2TA6muO5rVjuQQslyzxIeMTkmjdoXdRPi9RULBMkOz9s3t4/owh0p5SE2YJ6B
 Zchz5k3K1ZGQnNLAEN5PbskPMS1e/lmlMc27r4smbrz0Bj2tC3OtoHVe1rdBGxBchP9gm4/3jU8
 TfT6OLAXllMTOCyg+J53CTwE2BPRUw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-14_03,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=john.levon@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On Tue, Oct 14, 2025 at 08:29:49AM -0600, Alex Williamson wrote:

> > Ah - is this documented somewhere? And do you have an example of where this
> > varies over the lifetime of a device currently?
> 
> It's more the case that it's not specifically defined as static over
> the lifetime of the device.  I don't think we want device spontaneously
> creating new regions, we have no device-check notification mechanism to
> userspace to reevaluate regions, but a user initiated action defined to
> create a new region seems like a fair vector where num_regions could be
> updated.  Also the current working idea would be that regions are only
> added, not modified or deleted.
> 
> > IOW, are these devices actually changing the num_regions value they report
> > sometime after initialization (namely, can it change after
> > vfio_device_prepare()) ?
> 
> In theory, yes.

OK, thanks. So the question over whether there's an nvidia bug or not here seems
to be moot, since anyway to support this kind of case, we need the region cache
guardrails.

This means that such "dynamic" regions are never cached, but that's not a
specific issue for vfio-user at least.

I will prepare a patch if you can help test it, Cédric.

regards
john

