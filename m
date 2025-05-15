Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC108C54754
	for <qemu-devel@archiver.kernel.org>; Thu, 15 May 2025 15:51:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFamm-00009f-HE; Thu, 15 May 2025 11:46:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uFalx-0006gd-Qe
 for qemu-devel@nongnu.org; Thu, 15 May 2025 11:45:28 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uFalb-0006Fc-Uv
 for qemu-devel@nongnu.org; Thu, 15 May 2025 11:45:06 -0400
Received: from pps.filterd (m0127844.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54FBMJ3t017677;
 Thu, 15 May 2025 08:45:01 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=zxCsFErulNbPOxCKbF3UavilB4wcwM+IwtZ/BHwWH
 H4=; b=1ajlk7Ynm90iNClko5kn40CLv6xVrBOYns2cJ4P1x4QPWoI/1tRpMPr1f
 4fSoSuWIoCpuQMf4NdMm+Yd3gsF93MVb4CwRpJ/JEQE9Hob5m87BYSKYYle1ttpM
 QbjpsU6RJp+PyIaHQKgJ2zzklwN7LGJv8WsOiXlrUsbh8Bzx/GyuM294PasJrSOc
 uu0vpq/QuRGqbXXxoTaeMAmjkBKswFeGM4d8E1jqhfgrDaboBBnGamaDb0poSpMG
 V6tKfrTnLO0NpjoQdvKMvMYRVrTIeel+LnWgu98klT/WUEAyxD8Sg4DbjY9n7pd9
 8JLZ+Pe/MGbNivLnjzb1kVvRXcBaw==
Received: from byapr05cu005.outbound.protection.outlook.com
 (mail-westusazlp17010006.outbound.protection.outlook.com [40.93.1.6])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 46mxgjawge-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 15 May 2025 08:45:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ESYx6E8EWRb4wPFptfPWc3Ho7N98a806U6vZ1+oTOwEPjZWqB+D29WlwaYE0rUrplh8bNkR+0eMjUUzGV7zXdmJoPHB7mDkc9Hqy5Jua4WUhDzOdujFLJvdL7dz9CmxREOhFmPTnKClGDDO21QhsLJNKEWzzqSEeS7M0ODfwbwzw05GXVlHDqiy6oS7AvBY6vLqo6OezU/K4nkaAfiOPFGuatk62TUUkTfWZYsBzfqd0Zb1PznY1W9T/4nny6f/xsvgVnoQPn9gPnRHJZnfnjtzK7gjGmTo+8iarJLIbxvn0+gwttrf5lWDb2unnLGec80DZ57smKHSjVABXjAY8RQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zxCsFErulNbPOxCKbF3UavilB4wcwM+IwtZ/BHwWHH4=;
 b=WuQ1XfcRzaTqB99hYVysVATRDMwHdeg41qJTjm9ccZkh7S6oUC8Mfy1gYgQ86vtHqOs618399Z0PFP4OhRl9HMxWwJPcsFGXqWUFJ0mPk2tQrS3cm6eDf0SwquFkKjGm9PnAVwQUIgZyy97nGS++vUsBhJYTs58t3KfaNdFaAN4kZuFydfaMead5dkPdVWwaf3I+k2xxtCCh31BQ8+ZV+zyp3XTdsl6KfBP8ZJD0XeGArXy1+kIj96sHB0rTUm4VvpdNmEgYe9/pPiqZZOE/OG22bhbIoDAjH1ZMGd4pshcr3AGnJ9xIgEsJTkClOjYZxPipWg25RfS2e0Oh2zrnEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zxCsFErulNbPOxCKbF3UavilB4wcwM+IwtZ/BHwWHH4=;
 b=Di1XxnHXEUkkQ1UC6GVNfCS92xh6GPRhRUgGKBamlq4+Sq296+uPmx765JqtBAFwCpGJpPvPVAEixgWh7G8CKDXr+oavBZq0OagnE+IpM01SobOyg+/YMb9AagD3BqtAVlniXYmTlyLuEe6gz9lXgyCBtsxFx+6yHA7J2QLMYG3WTS+PeP4qljX7P02jOeacMGqHPNVL8EmRGh9HmYzHOzSK5DZlV1iqKhh5eBCTGsk1TxkdwnWHoz7LcgIFiYmTMsA1d+Kjxof4fcJhXfj6GtG9m9zgoo6KoZzvTgMU3gvekPF3TmpEfIr0QFrDFhuVjfb0sQvqOSGBFyZ4MKpBog==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by BY1PR02MB10459.namprd02.prod.outlook.com (2603:10b6:a03:5a8::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.21; Thu, 15 May
 2025 15:44:59 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51%6]) with mapi id 15.20.8722.024; Thu, 15 May 2025
 15:44:59 +0000
From: John Levon <john.levon@nutanix.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 John Levon <john.levon@nutanix.com>,
 John Johnson <john.g.johnson@oracle.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Jagannathan Raman <jag.raman@oracle.com>
Subject: [PATCH 16/27] vfio-user: implement VFIO_USER_REGION_READ/WRITE
Date: Thu, 15 May 2025 16:44:01 +0100
Message-ID: <20250515154413.210315-17-john.levon@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250515154413.210315-1-john.levon@nutanix.com>
References: <20250515154413.210315-1-john.levon@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM8P190CA0010.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:219::15) To CH2PR02MB6760.namprd02.prod.outlook.com
 (2603:10b6:610:7f::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR02MB6760:EE_|BY1PR02MB10459:EE_
X-MS-Office365-Filtering-Correlation-Id: 34e783cf-a32b-487a-d7d1-08dd93c772b9
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?LX0TzCKq5tVefVc6W9vxu+bhQhqUvcXK/HlSsCLK/r7CVMiFuxMyb9hV1n+k?=
 =?us-ascii?Q?pugquyzckyoMA8xNpsb0f00GXn6rYQg90qhSQDQhgFfyPY0ZwYHGHOp2U00j?=
 =?us-ascii?Q?5Ny348WCA+c/Ctz/BsRCr0rg9VZmrYBs+gR6NmsHQBCuiC7L0YgQMmeuQT2q?=
 =?us-ascii?Q?cIhM0XaIVz73T0RjqKC2KDf+f87/CtdDvLp012j7qp8++m5/id52g0TnTQEL?=
 =?us-ascii?Q?mSLX5efITxNU8ZDY6MOaix6wlh0kqE9LLO9AFco1sZelqxmpn49XoD9ccUOe?=
 =?us-ascii?Q?1QVEXVU3CrJHqWZufPrC2USt1qt+qce3GxnFt7Hx/gud0PXoiz0OW4pwrM9+?=
 =?us-ascii?Q?TASpzr88jYAVhZU5lAhYs33oJHjhcnZsude1+FZ3XlZcvfeczIQCBLMlwGdV?=
 =?us-ascii?Q?92FCnDngFFrYUEu8v5an/iX9XZVeTfp9pOSRW/dF65gcd6JgF4rbCD4X5CPk?=
 =?us-ascii?Q?czxFhaTkvjd+UZd61xATn6QHVJ4t01b+4ANr0+kEkRHWy0jFW1DeDUrv7UyH?=
 =?us-ascii?Q?VRkr9FwL+5TvexjuyAThP6Oe0jWCtzOUK6ei7rKpDZPkebZ29WQ73M/vvhyW?=
 =?us-ascii?Q?PJEoFVDgbyaD/Gv1REPwDDkdWDlVCTfHAdnMLmWzM7DU4GNxIWL5fo6DcjAY?=
 =?us-ascii?Q?hzf0f6GsTnPEyBWLrb9ib3W4ucckuMfOTwudE8zx/B2ZQrXijPEOI/e6GZ2a?=
 =?us-ascii?Q?fP3c1H5h462ebYyVsZSpAhTRkPpyJNHEzNZUucRycaxz9cNye+AdnEDouvUY?=
 =?us-ascii?Q?J8WfeS333sWQeBGMpFrxx4ermau0/j87FuEO+PuCBnU7QNVopDTyVAcoXA3O?=
 =?us-ascii?Q?ArtEKIdxdP4tTAuZJPEpyO2rwq2zdA1QPclf6dwR/kNbXWslvSp8yIxxKZM2?=
 =?us-ascii?Q?6j6aBggCi+GkTEU8iReW/GCxU2ZWJZ0RMlt/5baD1Pna2SLMmtg5Gu/5R917?=
 =?us-ascii?Q?GXOFGMxyGKj6MbUlZqg1uF2dbolUikKY5gANfqEKj342Z8eVBtbXLQR31uLN?=
 =?us-ascii?Q?ydwfcv/ETeA6/QR8Wb12fkn7E5TH/ZTv39eTnzuB23OhAL3fl3RPC2CTmh9P?=
 =?us-ascii?Q?aKjhB+X136K6aYNCbLBteWGL69sPOxMxtLzFRzZIpUp9tvpcj342q5JyDGLf?=
 =?us-ascii?Q?gwOrWulBPRmXa1CO07NGN69lGAX+Cwt8QSnWOJbrnCxIUlQVWJHvstLyEwdL?=
 =?us-ascii?Q?5s4lxp0vUqL369S2gOoWROVPMlfjzjeCptzOKdDZ/BYzWqQcU5vu+0K9qvk4?=
 =?us-ascii?Q?Wb23rTI+cPRBUBotgF7m50TpLjNFX5VocVzM4L2zIVUh9MCAKr6iwHvwcFd4?=
 =?us-ascii?Q?7ZBdG6qkAFWqmxFlQeVFpXDrKxwHF3O0uUbrEf+98tJJr0eLZxDH3SF/RfIN?=
 =?us-ascii?Q?NnyVvbZ8uX9MeanRySs3gj/eEhSyNzhrxyAeeJT/c+3oLjhe6jpcyIcf/euB?=
 =?us-ascii?Q?sj7euo4D+/0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7416014); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gfupo7ZzNWPYcZVypsqLPH+Nc2QeUyFctUVJuqvMve0CD/ntJe3sWwZI0MYK?=
 =?us-ascii?Q?Nj07WkLAJtno3d1pPJmVnuJlyJAHRrEAOqIk6V1V4NZBZXRiWlEy2dKnGbHX?=
 =?us-ascii?Q?YZeqecciAeZBgj87gNEVzr0qlbEjvYZF+nDOV23vV291QIgxHYKtQ9iFaLPu?=
 =?us-ascii?Q?aDXsUHLytsdyadIUVCOMsTKiSQSqDSar7Elc/5rlVKu/KofOr2BbBrjFInoF?=
 =?us-ascii?Q?Sra/NQNZrZJCifhQrlBxKatvPKr6mSWlYJl3xlig3fu8aOBmuZXP7ysEHNmK?=
 =?us-ascii?Q?GCvwAiccEnLF2VN/i9s9c5A5smpBDXOeFKP9CMd5xQn/YE63ux9AeghPNvob?=
 =?us-ascii?Q?xCpJcxQ6elD+gp6+mhC+ZBmTBZH87SKP4QLH0OwAe231l4VaCPqZK2CxqJAz?=
 =?us-ascii?Q?gwXETiNCzn/NEdyregKUxVMLGHMVD/DfxAUmKm16STf8h9XD0oOepdbjAKzG?=
 =?us-ascii?Q?HApQ28wspQDsYuiWDJzF/66Lt9lwus3aaScHGGQA0c5z/28ilpTmo7iHuQpb?=
 =?us-ascii?Q?bFF8rkax2GaqsYXvY+F1XvQuvkkP56IZLMJKOojT6H7CABJvyfisvmrSQpt/?=
 =?us-ascii?Q?VR5Ui8btPQXtMTOBvvxNsqkDTuE2NvrmvTx3qAXo/z4jYo+NTNAvFe6Neqca?=
 =?us-ascii?Q?UWAtYUY/B/VD8NPVg59wYCk97cvcdkLXpsX3TKJe4YwH72cZbEkIKAkcQMiC?=
 =?us-ascii?Q?s+BEFuz4jU5MJxsDFtkUeK20lCwHe+gyGGoVgAjLxI4bZJkwwWdcTs0Loc4I?=
 =?us-ascii?Q?A7+BCRUvoxZScJq22IYl8q41tbWzM39c4dNNmNOYtCwyuBg3z4rQs6FWBvYD?=
 =?us-ascii?Q?UTcCuN4fAHGODe4AHFXyn3GEO/FnMBXkkOktlWIPa1a5Tgw2bd/XeVANIkNa?=
 =?us-ascii?Q?kBx3P57AZp0DhByPPSawYttq2U12u8IcECrRyToJlqrmDFxG1QYc2g84uxMP?=
 =?us-ascii?Q?gUQ/UV/RoiOiqSpDJ16VZr9gLHrQ4t0wcAWmcNt+wbKUZ3K2J7I4Ol7jCdrU?=
 =?us-ascii?Q?mAlzd8qL+bHVLlFmpdi5jaIgi8dbwNScYgSCFHaPhF0WrrQmyadOueqsAp0m?=
 =?us-ascii?Q?lF8YfNn12Z77xlg4bO6yYyoRoIR0LasgrdsDQ3CcGOFgkMHAsIyaQpVe63ZD?=
 =?us-ascii?Q?C6an7ITgeBvqfGh0yxRpsYmAZZ2KFfgrPhabXpgwLCCANB78ViYD3pgjOa2C?=
 =?us-ascii?Q?oxbOiuvGbBhbOyompqyvMZAd2vIJGGkov3mOBw7HD/hieQxf3Q/j6pd3azc4?=
 =?us-ascii?Q?GDclrUsfrvYMQK8hmG3gWdXAO7RBc9jOdsNgAn4Lf1+GV7ECcqzorrGu5ZTi?=
 =?us-ascii?Q?kGhuGAUg6DigngWFgquCKAoEqU0JGqjbUMANuTTSu/CKPNLGksL1SIZ0Gz8R?=
 =?us-ascii?Q?d6/5SBT4i7I/CPcptO1EbbuB+Hi87T2ITArnmcWFP+y7Z9iXDTMUJ4hqiLBT?=
 =?us-ascii?Q?+Si92H0RI3Dbr4YyvHR3zMYgZG5RXBHeG3P1CGzMuPmI9p0dE083FYl9Spof?=
 =?us-ascii?Q?pYujLIhu2lAIckr1pNft6j1MkTKjbDDo4kV58i/KlTCJRT9gVB85B34cFYl7?=
 =?us-ascii?Q?aj0Ztg3ldxUVpJRPIv1y0dHPxaSpXr2TlDRb84Vp?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34e783cf-a32b-487a-d7d1-08dd93c772b9
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2025 15:44:59.0652 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lREoE3cimwW4YIN9uwkLlZp8J2rpnr16WEcLsfRxftwpg7N8SVI3G7BgfZNgMYLmqcnrcol5EOV66ytYG8FYCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR02MB10459
X-Proofpoint-ORIG-GUID: qK_hSzYJxEtPzCipf4B6JrxT9j6XjQSs
X-Proofpoint-GUID: qK_hSzYJxEtPzCipf4B6JrxT9j6XjQSs
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE1MDE1NiBTYWx0ZWRfXx95/tb+iOHMl
 deTdmpShrolhE/OOZVKFVSwijpelBaD7JxCnNJc/qvZwF+l3lJUjaEl7rPjrBrqdAm6AUvAAG1C
 nIVEZS4927lHOqYusYgaJNQRdeHM2ux6u/MhU86NbCS696OeG3woukzxU+I/Y6VceXcJXOSqsM3
 xuu445r9oLL3M92I4D0g84ETDU4Pwb2l6jDyW5EFJ6mR2GgtrIRzGHGTB+1rqBbOjWPwjBEzFrE
 mbqWFsrKJFfTSZSzDLEN3apHxDrGqX5faScuQ6t0rDuxLBVK0VkFR+4ZGfGZqmLCpX5LJGhnpKR
 rU66ASIjfgjPCYeApSBS+It3qvNDmowpaR5Oc+XSlYKWd1jrwXnaJk43N/WmeiAnL8vFgYqPlEO
 Yjs2aMgZ6XeRXySvT6XbzsBs31nIgftJOB87+SCFUXhM9wHad7ACDZ7bF4n7Un8bSoGPO34c
X-Authority-Analysis: v=2.4 cv=U6aSDfru c=1 sm=1 tr=0 ts=68260bfd cx=c_pps
 a=CbxOEkXH4sIw/lcH++vrDQ==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=dt9VzEwgFbYA:10
 a=0kUYKlekyDsA:10 a=yPCof4ZbAAAA:8 a=64Cc0HZtAAAA:8 a=lEmlVuBv_BsZ2DPd9E8A:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-15_06,2025-05-15_01,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=john.levon@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.686,
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

Originally-by: John Johnson <john.g.johnson@oracle.com>
Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
Signed-off-by: John Levon <john.levon@nutanix.com>
---
 hw/vfio-user/protocol.h   | 12 +++++++
 hw/vfio-user/device.c     | 67 +++++++++++++++++++++++++++++++++++++++
 hw/vfio-user/trace-events |  1 +
 3 files changed, 80 insertions(+)

diff --git a/hw/vfio-user/protocol.h b/hw/vfio-user/protocol.h
index 1878d44c51..8e6ccbe9e8 100644
--- a/hw/vfio-user/protocol.h
+++ b/hw/vfio-user/protocol.h
@@ -141,4 +141,16 @@ typedef struct {
     uint64_t offset;
 } VFIOUserRegionInfo;
 
+/*
+ * VFIO_USER_REGION_READ
+ * VFIO_USER_REGION_WRITE
+ */
+typedef struct {
+    VFIOUserHdr hdr;
+    uint64_t offset;
+    uint32_t region;
+    uint32_t count;
+    char data[];
+} VFIOUserRegionRW;
+
 #endif /* VFIO_USER_PROTOCOL_H */
diff --git a/hw/vfio-user/device.c b/hw/vfio-user/device.c
index 57793e6b2b..a767e4fb01 100644
--- a/hw/vfio-user/device.c
+++ b/hw/vfio-user/device.c
@@ -110,9 +110,76 @@ static int vfio_user_device_io_get_region_info(VFIODevice *vbasedev,
     return 0;
 }
 
+static int vfio_user_device_io_region_read(VFIODevice *vbasedev, uint8_t index,
+                                           off_t off, uint32_t count,
+                                           void *data)
+{
+    g_autofree VFIOUserRegionRW *msgp = NULL;
+    VFIOUserProxy *proxy = vbasedev->proxy;
+    int size = sizeof(*msgp) + count;
+
+    if (count > proxy->max_xfer_size) {
+        return -EINVAL;
+    }
+
+    msgp = g_malloc0(size);
+    vfio_user_request_msg(&msgp->hdr, VFIO_USER_REGION_READ, sizeof(*msgp), 0);
+    msgp->offset = off;
+    msgp->region = index;
+    msgp->count = count;
+    trace_vfio_user_region_rw(msgp->region, msgp->offset, msgp->count);
+
+    vfio_user_send_wait(proxy, &msgp->hdr, NULL, size);
+    if (msgp->hdr.flags & VFIO_USER_ERROR) {
+        return -msgp->hdr.error_reply;
+    } else if (msgp->count > count) {
+        return -E2BIG;
+    } else {
+        memcpy(data, &msgp->data, msgp->count);
+    }
+
+    return msgp->count;
+}
+
+static int vfio_user_device_io_region_write(VFIODevice *vbasedev, uint8_t index,
+                                            off_t off, unsigned count,
+                                            void *data, bool post)
+{
+    VFIOUserRegionRW *msgp = NULL;
+    VFIOUserProxy *proxy = vbasedev->proxy;
+    int size = sizeof(*msgp) + count;
+    int ret;
+
+    if (count > proxy->max_xfer_size) {
+        return -EINVAL;
+    }
+
+    msgp = g_malloc0(size);
+    vfio_user_request_msg(&msgp->hdr, VFIO_USER_REGION_WRITE, size, 0);
+    msgp->offset = off;
+    msgp->region = index;
+    msgp->count = count;
+    memcpy(&msgp->data, data, count);
+    trace_vfio_user_region_rw(msgp->region, msgp->offset, msgp->count);
+
+    /* Ignore post: all writes are synchronous/non-posted. */
+    vfio_user_send_wait(proxy, &msgp->hdr, NULL, 0);
+    if (msgp->hdr.flags & VFIO_USER_ERROR) {
+        ret = -msgp->hdr.error_reply;
+    } else {
+        ret = count;
+    }
+
+    g_free(msgp);
+    return ret;
+}
+
 /*
  * Socket-based io_ops
  */
 VFIODeviceIOOps vfio_user_device_io_ops_sock = {
     .get_region_info = vfio_user_device_io_get_region_info,
+    .region_read = vfio_user_device_io_region_read,
+    .region_write = vfio_user_device_io_region_write,
+
 };
diff --git a/hw/vfio-user/trace-events b/hw/vfio-user/trace-events
index 1860430301..3f5aebe7ac 100644
--- a/hw/vfio-user/trace-events
+++ b/hw/vfio-user/trace-events
@@ -8,3 +8,4 @@ vfio_user_send_write(uint16_t id, int wrote) " id 0x%x wrote 0x%x"
 vfio_user_version(uint16_t major, uint16_t minor, const char *caps) " major %d minor %d caps: %s"
 vfio_user_get_info(uint32_t nregions, uint32_t nirqs) " #regions %d #irqs %d"
 vfio_user_get_region_info(uint32_t index, uint32_t flags, uint64_t size) " index %d flags 0x%x size 0x%"PRIx64
+vfio_user_region_rw(uint32_t region, uint64_t off, uint32_t count) " region %d offset 0x%"PRIx64" count %d"
-- 
2.43.0


