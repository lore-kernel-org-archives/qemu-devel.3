Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09B32CA0EF3
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Aug 2024 21:05:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sk8oH-0007A6-TL; Fri, 30 Aug 2024 17:05:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <si-wei.liu@oracle.com>)
 id 1sk8oD-00079P-W9
 for qemu-devel@nongnu.org; Fri, 30 Aug 2024 17:05:30 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <si-wei.liu@oracle.com>)
 id 1sk8o9-0007dA-4k
 for qemu-devel@nongnu.org; Fri, 30 Aug 2024 17:05:28 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47UKDjDM020800;
 Fri, 30 Aug 2024 21:05:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
 message-id:date:subject:to:cc:references:from:in-reply-to
 :content-type:content-transfer-encoding:mime-version; s=
 corp-2023-11-20; bh=+76FBKUS4X0coB5AGzYFUR+pCrdkHzWm6TiNirmLFMc=; b=
 TquMzmFXb7YbEWak21AqT23Pc+ibIfOu/aW5GXA3MPpkfaMSGTDF2KwZ9jIbI+56
 7nDLnFfpBdEjm5LkCnBKiqOru5X19TjvwmzWglKt9aRw+VZN7Nw0idUHO8o9hikk
 S6AiCfnJeZnPMLXYssr0is3nfKNDg9iP+6YxPAE9SGAwNKUVVzYRZd2EN1PBGJuG
 LKoTINTJdniX+YaAdYFn47gARG/1lhavtILJAxaQlb76vQtBxBIJJ8U4C2rZ0GNC
 psmyvcBeJUPaC/HeBZn4mR5rv3LFFQRxyZ8B5RwbDE/JarFFoDvqQtIVGYgY/jzZ
 OzuTd6lWquWh4PLxW6ZQBQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41bmx4r2rb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 30 Aug 2024 21:05:22 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 47UKEmIw020430; Fri, 30 Aug 2024 21:05:21 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam10lp2044.outbound.protection.outlook.com [104.47.55.44])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 418j8s9bcg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 30 Aug 2024 21:05:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ufKUQCLejyP+Hs3Bm9r3IlqV3PjwhnqxWAevpG4Scm1h4YXba0O6MKvod1TbcZyG+9XJ6wBcsFMktB5XgU4W1FmPwLm/yf7O1vheDWF0bJOmbXCKWTJtU/uzL962MGPPlmU2xQMAriozeCixeA1Odkvezz6pilUKzsUZVHYFTuug/Y5Sy09vl0IdnnrMILYZQKlHy7ZkHN+yU4Yv/6mpeKNepsZepR6rODDNO3Nf2Uiw1ROQ7HffESFgdEAuYZX+WGYVuKvBNFlERnW7+wTCrMFGspSqid62UfH2uTr/hJZTO2j6lYAFSMlXEyAACrcEkBpsFz6NLU0rc9gazlO/aA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+76FBKUS4X0coB5AGzYFUR+pCrdkHzWm6TiNirmLFMc=;
 b=XnR841KIQIrG9q/DAT7wSRk7911Qf+15Tg8NjJEn4/VbLr0mpG9tnRKxf7cyxeZBV93OE7irzjaaNk3rg8QeqZ+zQa40ORXTOnmIWV7x18LZzN8QCU4JdrmaB7ceuvlreFMYClgm5jnuk6t4MXvpXwbxR4TsGWwn/FitRYxR4uz3EAxJfMP18IpMspT6RhOsEpVD2R6C6/RNnyNy9u+VCxd8/m28Gpj3TjRFG8/DJ7QZVLQtai7V5vRYwx6GmqCoS/VknZ1OIE+Zn9s4cAPlWPshR15M8ONxAkENTBHeobsBQSNWXzq4yivhYqdMl6Ze+4MEVZbUbMA3keyy7WdBHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+76FBKUS4X0coB5AGzYFUR+pCrdkHzWm6TiNirmLFMc=;
 b=tqXfmHwE+z9OCKeioHuDonnKJ9D60rNmGkIxkr70eyuXCzE7wl+slAySu7qloUg0iW6gW9ZBxNV6jlmxLkGQVJkLVjQ+jWGoIkQDpmXJi/EVp8FV6Z+u9JyzxT+G2T8WvevOfVC9I7LARlYiMMxSfTfepnUOEaKXouGrQ/ar6KU=
Received: from MW4PR10MB6535.namprd10.prod.outlook.com (2603:10b6:303:225::12)
 by CH3PR10MB7562.namprd10.prod.outlook.com (2603:10b6:610:167::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.20; Fri, 30 Aug
 2024 21:05:18 +0000
Received: from MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::424f:6ee5:6be8:fe86]) by MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::424f:6ee5:6be8:fe86%4]) with mapi id 15.20.7918.020; Fri, 30 Aug 2024
 21:05:18 +0000
Message-ID: <43277dbe-fb11-025c-fe99-8ee074a6a345@oracle.com>
Date: Fri, 30 Aug 2024 14:05:15 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [RFC 1/2] vhost-vdpa: Decouple the IOVA allocator
Content-Language: en-US
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: Jonah Palmer <jonah.palmer@oracle.com>, qemu-devel@nongnu.org,
 mst@redhat.com, leiyang@redhat.com, peterx@redhat.com,
 dtatulea@nvidia.com, jasowang@redhat.com, boris.ostrovsky@oracle.com
References: <20240821125548.749143-1-jonah.palmer@oracle.com>
 <20240821125548.749143-2-jonah.palmer@oracle.com>
 <CAJaqyWegFi5h56HQ2Ga5BsJ-UwMmxF5rQujE6ZAYJKEZaRy65w@mail.gmail.com>
 <436fc148-d1ac-17be-09f4-e776661c534a@oracle.com>
 <CAJaqyWeEgSar8f_O26aw+WoSKFGc8DoVkxTv-XEPPo_AeLXLSw@mail.gmail.com>
From: Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <CAJaqyWeEgSar8f_O26aw+WoSKFGc8DoVkxTv-XEPPo_AeLXLSw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR05CA0020.namprd05.prod.outlook.com
 (2603:10b6:a03:c0::33) To MW4PR10MB6535.namprd10.prod.outlook.com
 (2603:10b6:303:225::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR10MB6535:EE_|CH3PR10MB7562:EE_
X-MS-Office365-Filtering-Correlation-Id: 95832353-11e4-4c7f-6ee5-08dcc937739c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RGFrclpvdmpyL2ZlMEpLbzA3TER2anI4K1FvalNQcHdzMU1UKy92Y3o3bEV4?=
 =?utf-8?B?SGFLQWVuVXFkekhuUHBYWkh2aU5ubnJVRk02UGxJeCtkNzc1ZHZwM01BZ3Fu?=
 =?utf-8?B?Y3BSd1MwZURqTE9Rek5UQzAydVZpYUM2aEQzZGVBM1lLZVZwSUFVZStMWUhB?=
 =?utf-8?B?czZyQndVZ0g4TnRDS2s0QUt6R2RTSS92MzRZZnJqSHlNMnZLZTc2WldQa2E5?=
 =?utf-8?B?OHBtN1hBaWoyZEt3Mis4MzhmTUlZZkRwUHR3N1c4ZWhwVkRQY0xseTQzTm85?=
 =?utf-8?B?NFBjZlVhOW42bFJSSnBJVkNvOXdEZ0ZzNWRIOTh5bXpkS0Qvdk8yS1pzUjN0?=
 =?utf-8?B?TkRSSjJuTTNsaDYwOENsbUNZOFUzWjBEZWROTHhvRkJqMG92bVJxU2JaTFh4?=
 =?utf-8?B?OUJWR3dRN3ZxMHpTMHVjUXk2QVRXMXZlVGUwUDRid3ZRalZHRlpNN0NIOTli?=
 =?utf-8?B?bzNQRE9ScFgyMmdIY25uMkFFVjJUci9oajNJUExka1dGbzEyK2tIMFFyTExL?=
 =?utf-8?B?NEJqRlFkekxERFFEVW1zZFdHNVh3dWJZQm4rM0N5TXNiZHdhci95RnkxK3Jx?=
 =?utf-8?B?aGZ3T01hMHJmTEhyVUNGSUdSUjV1ZXFIMXJ6M0pFV1ZTTER6MldsQnBQWGxF?=
 =?utf-8?B?aUYxMHNWRmtVSytkZDFYZmxEYjYzT2RWQ0w1WFVRRzBUa0YwSVllMXpQQ3JX?=
 =?utf-8?B?eDE1dmJvdmltNGpvbEQ2RmpCUjlLeUZ1eXluZDJLTGNObEYvT3hSbFRtSjNR?=
 =?utf-8?B?QlF0aWp1clQzRWdqbm5ZRWdWYkNyUW5veUJGNi8xOTQySDY3elNEeGR5YUxx?=
 =?utf-8?B?WERCSDdWczdOcmF3cXhGd3hoSFpUU0ZEaFZ0ajFaSE40TUZDaWxuODZwd1lv?=
 =?utf-8?B?UGNJL2hNN0d3Q2F5Sm4xSkNkT0NvOGRXZXo3TnVFcU1RT2Z2QkR2YjVwZ2FJ?=
 =?utf-8?B?QngzTVRQR2FjUTRiaUtrYXpIZmtmaDIxVjMwWUVBNk1Ic2lSQXdCMlJRc09W?=
 =?utf-8?B?TmdDelNTa240aEkvSE1SbXliWTRmNXBUK2p3enpEZ1puOXVEMGpGVDRhRSs0?=
 =?utf-8?B?VGlhUWs5MFFWZ0ROVW5iNUgrVHlZSVNUZVorU3pkeWpRRGpubHczUmJFQWU5?=
 =?utf-8?B?ZndMUFpxdHUycDRWTFdYVzBiNmh1Z00rdmplakF2N2E0Y0grbmdvY2VZd05p?=
 =?utf-8?B?QU9TUmVvSzlHcEZTRXJsL2hiM1M4aXVLV3E3MWp6b1pCaVZIUmRYYnRRM0NB?=
 =?utf-8?B?ZGl3WnZzVXMrVGpRMzVoTXVzMUNIK0tEeDRrSTVTajRrSjBiU1JrR0ovK1lK?=
 =?utf-8?B?R1B6elFPRW1vNDV1YVNhWFFsNnEyV09vcjVidlA3QmNYbkpENHhCRElqWkxx?=
 =?utf-8?B?OWRSL0R3aG85QTg3bmw0T1UvVUR0anc0L0tGR0VpVzNPUHZaQUhRWGhEa1RL?=
 =?utf-8?B?aSs1bCtyQTg2M2dCU0ZRQkxHLzZpenBidHk1MjNOa2JzVmZ3SS82NkFXaU1a?=
 =?utf-8?B?dnVmeUxtRjcyTnFMeXRjZEpRYURuMUVYNVdhTXpTZDczRGxDM2RtMnhWTFhT?=
 =?utf-8?B?eWhSVWh0U2VFMVFJZDZUdUIrbGEwdDg5VTduT3pBUDV2UWdDdnJ4bWoyU2o0?=
 =?utf-8?B?NDlZcnhReFowdzd5VCtqMXV3VW5Dbnd1ZmZVaWRFbm5VQTdpSUJHdGFEenJk?=
 =?utf-8?B?eGY4SGN6WGNMMGdodkY1OHMyYTZsWkk2S1ZncnBqRVBSYStyMUFTNm91S0tw?=
 =?utf-8?B?T0l1NUNYR052N1liQkRoT3c0N2N4U3IyeHFuYi9FWEp2RDlKWGkxc0NjTTZS?=
 =?utf-8?B?aGt1MFlTd0ppQ0ZRbGhldz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR10MB6535.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NHlrNHhRM3Q5RjJqZ2VDSWJ5ZUtpWnNraHBvRis2bzRYNGt1bWs2NjdOYzA2?=
 =?utf-8?B?REthZWtLbUM0d0dRTzZGYjA5c3lmQkNRc1I2aGVBTnU5UTlIOXZ3bUhiL1d0?=
 =?utf-8?B?TDFJbWR0aUpPQjZ5NWpoeUI5SzhkdXFEY3pRQ1RYWStrMG5UNlN1WWtjVEZX?=
 =?utf-8?B?bVplYlpGbTlxNmlqSVhnbm91Z1J0UXg4WVhXaWtiTENEaVNtTDJOdDdxaUVE?=
 =?utf-8?B?aU5SVURpNGJLb2tUYTRiRWZISDdxTUFlWlQzUUwxQSthVjc1UjE2VzU0ODRa?=
 =?utf-8?B?SUpPR0lxKzUzTWM0bUdPenNZVFNvYUdHWHJhUk1iVFN6S1ZpRzdjb3lNQzZ6?=
 =?utf-8?B?NEI0UTdHeFAxWUwvT05ET2kzcTMyM1RteDdKd3ZZSEVHcUQ4VWg2THVFTGRw?=
 =?utf-8?B?K3M0VlZJR3VCZmF2Uko0RUZQWFJ1QllBbFBYTElBdXBrZzczeVdneFBKZVpX?=
 =?utf-8?B?dTd0SHV4enk1Q2dDYkdOa25kQUJTM1d0aEU1U1hCNTNCSjRtWVJadldwUEJU?=
 =?utf-8?B?bXA1elNZY2J3L29VeTdINTM5bVNXTjJzbHdIQU5KdDZYTmdPSDByMHR6NWRl?=
 =?utf-8?B?clZsSGVOV3AxbU9yMjJJZERVUmtpK1k1U1NNcjlScjdpcDQwVEJOeklQWXBn?=
 =?utf-8?B?OHNsd01UcXgrZGhQTHdpK1FjRjN2bDhJTndPUTZTKy9Ca3dtRVduTTd6cDhl?=
 =?utf-8?B?bjF3Sm80K3YvN2Ywc1ErY2FnaGF1eTZWSjNiVTFtUEFhbXBRaTNteHJtM0lP?=
 =?utf-8?B?dkJmYldPVWZmbHVVUXMwMWozWXZkcGhvaThjY0NiRUZFUWhsNmNqekxrTTZY?=
 =?utf-8?B?SjlDNXc1UVB6alZHUjBYOVRjNUoySmNoeGFmOGdlMkJKV0hEUlV2cmNrY0Ix?=
 =?utf-8?B?ZXBHdjdMbktyY2pVaElnOUV5TGhxNWtidFg3VnI0YlF4UDhDUVlrNzdRcDhK?=
 =?utf-8?B?MExKYlNkV3dqWE1Yd0RUN1BackV4MEdRT1V1eVQ3bDQ0aEh5YkVhNlFSTzZl?=
 =?utf-8?B?VGZzWjZENVFSOXlLSnR6SlEzYXVobU9SVS96bHRibU1tcHlWMENZbzNzRFhE?=
 =?utf-8?B?dndGbUZmc2xFM1ZVUjRQQUlRSnAxQnZDTXZCQTdYeUprV0tnZzZhY3V0ekJV?=
 =?utf-8?B?Y1hIaWptRGhkUGhrcE96WGQ5eExkWm1GM3RkUXFXUWlBT1FBS2pEdENhOUhz?=
 =?utf-8?B?ak04Z3dJVlptTlRhNG1ZWnlMbnA2QTl3Ly9IdDVwQzltSHhleEZ6RmRaRUZY?=
 =?utf-8?B?SWRzTmdFQXNURDYxOVZhYVpXdGJhUktrS09JUjdBNWE2M0k1SHhvaXQ0MFdh?=
 =?utf-8?B?ZnlrYk1WV3phRXVQcFY1T09uM1dPeDRLcWxYVjFFNlJpRUxPNFZSQWJSKytq?=
 =?utf-8?B?UzZoZERaV2ZiTE1UY01IbUhScFppR2FqSEZwWEdOVENZelBRdGF3Mmd2TmVD?=
 =?utf-8?B?TGZTLzc2eHQ1V0QvYzNWN3NQazhqaEJYVVdxNjFERU5rREo5TWhNenFkN2NW?=
 =?utf-8?B?U0VlSEUwenRYZTlkZUNSc0RkVTltVnlIVGhySzlZTldYT3AveU15bFkzYmdl?=
 =?utf-8?B?SWdLdnc5WjdoSE1qK0VGaFFsQ0hLUDZ6QjhWVkpkLzFEd29ZUzVrbmtVbWJY?=
 =?utf-8?B?WlJaREloVncyMmhPMThnTGt5SVNBUU5zZUsxT1hxdUZCUmhwYXlsb3dzbmFE?=
 =?utf-8?B?SWNGTTMwRXJqUWc1K1RGakxvWEMwR2k5ZWhpUFVjeHFvaXFITU1LT2sybEZ1?=
 =?utf-8?B?TURNdlduRXk1N0lpUmFkVzFJL3VLcXNNazcvVDVFbFZkZXlqOGZqeUdyRktq?=
 =?utf-8?B?RytqczErd1g3ODRnMnR2Ry85cFhwV0o2eTJxQWpWQUszY1JLZXQ5Sy9Fb2JE?=
 =?utf-8?B?Y2pWQ3FRdnIwczBKY0lCLytxSEJUY0hQZGpUdHcvcmFzNXZjRm96SUNPdkFo?=
 =?utf-8?B?TUF1MzZveVRhaGl5QVp5NDhNaHRXRTRDelFqVVlhem14R3ltSGZJM0hWUTJO?=
 =?utf-8?B?UkdjOU9UMDAwRmU3c3VoYmV6SWFiTjY5QjFSaWFHTUVTd3FlUEhMWFY2MmZC?=
 =?utf-8?B?UlpzNkQrdWtCYnZseXRBUVhrK3NlMUFuZmlMSGl3WU1vUDFDQzhpNTJmbWZV?=
 =?utf-8?Q?GsUcJy7V8WHqL7Uv93mUTo/K3?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: +jBLjEEMqlrgMlqRMRrwlu/WXIhze9gyrj3OcqaWX7LhXLDJ1/DmeSUZRQ9IjsC2OqC5FSxoRle4iAFN35xDhhns8X9zU5wIYmUGOwobPnc09bD5KXy/qsmMS4ndJ0lBvyRoKWDEGUl2u2/jHNtn0lUTUxG8D4qhzrsEJMcwfyi3Pcedye/s3/ArBvoFgxKkKcB5ujjymgnbKxd6sXcsbOgdNB1dkOqCByoqY/jx8q1PeyS1ByReH7YsfnFbhk44EL6S1hTZfR7NzLro/NPe1ZP/865YL7EX3K4DJz1HYoAE7rQxmzJpUxgiaoErGo7MujNfXweWjhOmGD1nsVqNv5mFkURvOSL6hF24kM3yTjQmBDuJYcJDjmmryVd0o/RCwR9gB3hDxdLAK0qmaPqOfAQIK2B/l8QKDs/OsQ6oDT7WwJ50KQAkTixtFru+Tn0At4a4vmrsfQMB50/p4vE8O5xK35+QoHPjnjHnUSURQxfUYhu134oAGp9vq5ZVmXDxi4l7iQWxkPV4cnaYe564tTR9L8WudTABDxzkq4LUFAfqlCf1cFwXj4I3Gf+rKDVVu4b97w7dvX2EFyuppeXiJO8FR1F14gw7Y40/Lj08oiA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95832353-11e4-4c7f-6ee5-08dcc937739c
X-MS-Exchange-CrossTenant-AuthSource: MW4PR10MB6535.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2024 21:05:18.1391 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QNh6YOWPzu50LwmVZgWV7E7fxBDvlF4F38DlTNFuf4B8htvHLbNit4biJUro3ADQJsdvMvlgKw5ON+dRu+FNFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7562
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-30_10,2024-08-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 mlxlogscore=999
 adultscore=0 mlxscore=0 spamscore=0 malwarescore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2407110000 definitions=main-2408300163
X-Proofpoint-ORIG-GUID: tdCAEtuMbVa8XHEGsIZ3J6Zwu-MyyE4O
X-Proofpoint-GUID: tdCAEtuMbVa8XHEGsIZ3J6Zwu-MyyE4O
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=si-wei.liu@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.937,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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



On 8/30/2024 1:05 AM, Eugenio Perez Martin wrote:
> On Fri, Aug 30, 2024 at 6:20 AM Si-Wei Liu <si-wei.liu@oracle.com> wrote:
>>
>>
>> On 8/29/2024 9:53 AM, Eugenio Perez Martin wrote:
>>> On Wed, Aug 21, 2024 at 2:56 PM Jonah Palmer <jonah.palmer@oracle.com> wrote:
>>>> Decouples the IOVA allocator from the IOVA->HVA tree and instead adds
>>>> the allocated IOVA range to an IOVA-only tree (iova_map). This IOVA tree
>>>> will hold all IOVA ranges that have been allocated (e.g. in the
>>>> IOVA->HVA tree) and are removed when any IOVA ranges are deallocated.
>>>>
>>>> A new API function vhost_iova_tree_insert() is also created to add a
>>>> IOVA->HVA mapping into the IOVA->HVA tree.
>>>>
>>> I think this is a good first iteration but we can take steps to
>>> simplify it. Also, it is great to be able to make points on real code
>>> instead of designs on the air :).
>>>
>>> I expected a split of vhost_iova_tree_map_alloc between the current
>>> vhost_iova_tree_map_alloc and vhost_iova_tree_map_alloc_gpa, or
>>> similar. Similarly, a vhost_iova_tree_remove and
>>> vhost_iova_tree_remove_gpa would be needed.
>>>
>>> The first one is used for regions that don't exist in the guest, like
>>> SVQ vrings or CVQ buffers. The second one is the one used by the
>>> memory listener to map the guest regions into the vdpa device.
>>>
>>> Implementation wise, only two trees are actually needed:
>>> * Current iova_taddr_map that contains all IOVA->vaddr translations as
>>> seen by the device, so both allocation functions can work on a single
>>> tree. The function iova_tree_find_iova keeps using this one, so the
>> I thought we had thorough discussion about this and agreed upon the
>> decoupled IOVA allocator solution.
> My interpretation of it is to leave the allocator as the current one,
> and create a new tree with GPA which is guaranteed to be unique. But
> we can talk over it of course.
>
>> But maybe I missed something earlier,
>> I am not clear how come this iova_tree_find_iova function could still
>> work with the full IOVA-> HVA tree when it comes to aliased memory or
>> overlapped HVAs? Granted, for the memory map removal in the
>> .region_del() path, we could rely on the GPA tree to locate the
>> corresponding IOVA, but how come the translation path could figure out
>> which IOVA range to return when the vaddr happens to fall in an
>> overlapped HVA range?
> That is not a problem, as they both translate to the same address at the device.
Not sure I followed, it might return a wrong IOVA (range) which the host 
kernel may have conflict or unmatched attribute i.e. permission, size et 
al in the map.

>
> The most complicated situation is where we have a region contained in
> another region, and the requested buffer crosses them. If the IOVA
> tree returns the inner region, it will return the buffer chained with
> the rest of the content in the outer region. Not optimal, but solved
> either way.
Don't quite understand what it means... So in this overlapping case, 
speaking of the expectation of the translation API, you would like to 
have all IOVA ranges that match the overlapped HVA to be returned? And 
then to rely on the user (caller) to figure out which one is correct? 
Wouldn't it be easier for the user (SVQ) to use the memory system API 
directly to figure out?

As we are talking about API we may want to build it in a way generic 
enough to address all possible needs (which goes with what memory 
subsystem is capable of), rather than just look on the current usage 
which has kind of narrow scope. Although virtio-net device doesn't work 
with aliased region now, some other virtio device may do, or maybe some 
day virtio-net would need to use aliased region than the API and the 
users (SVQ) would have to go with another round of significant 
refactoring due to the iova-tree internal working. I feel it's just too 
early or too tight to abstract the iova-tree layer and get the API 
customized for the current use case with a lot of limitations on how 
user should expect to use it. We need some more flexibility and ease on 
extensibility if we want to take the chance to get it rewritten, given 
it is not a lot of code that Jonah had showed here ..

> The only problem that comes to my mind is the case where the inner
> region is RO
Yes, this is one of examples around the permission or size I mentioned 
above, which may have a conflict view with the memory system or the kernel.

Thanks,
-Siwei

> and it is a write command, but I don't think we have this
> case in a sane guest. A malicious guest cannot do any harm this way
> anyway.
>
>> Do we still assume some overlapping order so we
>> always return the first match from the tree? Or we expect every current
>> user of iova_tree_find_iova should pass in GPA rather than HVA and use
>> the vhost_iova_xxx_gpa API variant to look up IOVA?
>>
> No, iova_tree_find_iova should keep asking for vaddr, as the result is
> guaranteed to be there. Users of VhostIOVATree only need to modify how
> they add or remove regions, knowing if they come from the guest or
> not. As shown by this series, it is easier to do in that place than in
> translation.
>
>> Thanks,
>> -Siwei
>>
>>> user does not need to know if the address is from the guest or only
>>> exists in QEMU by using RAMBlock etc. All insert and remove functions
>>> use this tree.
>>> * A new tree that relates IOVA to GPA, that only
>>> vhost_iova_tree_map_alloc_gpa and vhost_iova_tree_remove_gpa uses.
>>>
>>> The ideal case is that the key in this new tree is the GPA and the
>>> value is the IOVA. But IOVATree's DMA is named the reverse: iova is
>>> the key and translated_addr is the vaddr. We can create a new tree
>>> struct for that, use GTree directly, or translate the reverse
>>> linearly. As memory add / remove should not be frequent, I think the
>>> simpler is the last one, but I'd be ok with creating a new tree.
>>>
>>> vhost_iova_tree_map_alloc_gpa needs to add the map to this new tree
>>> also. Similarly, vhost_iova_tree_remove_gpa must look for the GPA in
>>> this tree, and only remove the associated DMAMap in iova_taddr_map
>>> that matches the IOVA.
>>>
>>> Does it make sense to you?
>>>
>>>> Signed-off-by: Jonah Palmer <jonah.palmer@oracle.com>
>>>> ---
>>>>    hw/virtio/vhost-iova-tree.c | 38 ++++++++++++++++++++++++++++++++-----
>>>>    hw/virtio/vhost-iova-tree.h |  1 +
>>>>    hw/virtio/vhost-vdpa.c      | 31 ++++++++++++++++++++++++------
>>>>    net/vhost-vdpa.c            | 13 +++++++++++--
>>>>    4 files changed, 70 insertions(+), 13 deletions(-)
>>>>
>>>> diff --git a/hw/virtio/vhost-iova-tree.c b/hw/virtio/vhost-iova-tree.c
>>>> index 3d03395a77..32c03db2f5 100644
>>>> --- a/hw/virtio/vhost-iova-tree.c
>>>> +++ b/hw/virtio/vhost-iova-tree.c
>>>> @@ -28,12 +28,17 @@ struct VhostIOVATree {
>>>>
>>>>        /* IOVA address to qemu memory maps. */
>>>>        IOVATree *iova_taddr_map;
>>>> +
>>>> +    /* IOVA tree (IOVA allocator) */
>>>> +    IOVATree *iova_map;
>>>>    };
>>>>
>>>>    /**
>>>> - * Create a new IOVA tree
>>>> + * Create a new VhostIOVATree with a new set of IOVATree's:
>>> s/IOVA tree/VhostIOVATree/ is good, but I think the rest is more an
>>> implementation detail.
>>>
>>>> + * - IOVA allocator (iova_map)
>>>> + * - IOVA->HVA tree (iova_taddr_map)
>>>>     *
>>>> - * Returns the new IOVA tree
>>>> + * Returns the new VhostIOVATree
>>>>     */
>>>>    VhostIOVATree *vhost_iova_tree_new(hwaddr iova_first, hwaddr iova_last)
>>>>    {
>>>> @@ -44,6 +49,7 @@ VhostIOVATree *vhost_iova_tree_new(hwaddr iova_first, hwaddr iova_last)
>>>>        tree->iova_last = iova_last;
>>>>
>>>>        tree->iova_taddr_map = iova_tree_new();
>>>> +    tree->iova_map = iova_tree_new();
>>>>        return tree;
>>>>    }
>>>>
>>>> @@ -53,6 +59,7 @@ VhostIOVATree *vhost_iova_tree_new(hwaddr iova_first, hwaddr iova_last)
>>>>    void vhost_iova_tree_delete(VhostIOVATree *iova_tree)
>>>>    {
>>>>        iova_tree_destroy(iova_tree->iova_taddr_map);
>>>> +    iova_tree_destroy(iova_tree->iova_map);
>>>>        g_free(iova_tree);
>>>>    }
>>>>
>>>> @@ -88,13 +95,12 @@ int vhost_iova_tree_map_alloc(VhostIOVATree *tree, DMAMap *map)
>>>>        /* Some vhost devices do not like addr 0. Skip first page */
>>>>        hwaddr iova_first = tree->iova_first ?: qemu_real_host_page_size();
>>>>
>>>> -    if (map->translated_addr + map->size < map->translated_addr ||
>>> Why remove this condition? If the request is invalid we still need to
>>> return an error here.
>>>
>>> Maybe we should move it to iova_tree_alloc_map though.
>>>
>>>> -        map->perm == IOMMU_NONE) {
>>>> +    if (map->perm == IOMMU_NONE) {
>>>>            return IOVA_ERR_INVALID;
>>>>        }
>>>>
>>>>        /* Allocate a node in IOVA address */
>>>> -    return iova_tree_alloc_map(tree->iova_taddr_map, map, iova_first,
>>>> +    return iova_tree_alloc_map(tree->iova_map, map, iova_first,
>>>>                                   tree->iova_last);
>>>>    }
>>>>
>>>> @@ -107,4 +113,26 @@ int vhost_iova_tree_map_alloc(VhostIOVATree *tree, DMAMap *map)
>>>>    void vhost_iova_tree_remove(VhostIOVATree *iova_tree, DMAMap map)
>>>>    {
>>>>        iova_tree_remove(iova_tree->iova_taddr_map, map);
>>>> +    iova_tree_remove(iova_tree->iova_map, map);
>>>> +}
>>>> +
>>>> +/**
>>>> + * Insert a new mapping to the IOVA->HVA tree
>>>> + *
>>>> + * @tree: The VhostIOVATree
>>>> + * @map: The iova map
>>>> + *
>>>> + * Returns:
>>>> + * - IOVA_OK if the map fits in the container
>>>> + * - IOVA_ERR_INVALID if the map does not make sense (like size overflow)
>>>> + * - IOVA_ERR_OVERLAP if the IOVA range overlaps with an existing range
>>>> + */
>>>> +int vhost_iova_tree_insert(VhostIOVATree *iova_tree, DMAMap *map)
>>>> +{
>>>> +    if (map->translated_addr + map->size < map->translated_addr ||
>>>> +        map->perm == IOMMU_NONE) {
>>>> +        return IOVA_ERR_INVALID;
>>>> +    }
>>>> +
>>>> +    return iova_tree_insert(iova_tree->iova_taddr_map, map);
>>>>    }
>>>> diff --git a/hw/virtio/vhost-iova-tree.h b/hw/virtio/vhost-iova-tree.h
>>>> index 4adfd79ff0..8bf7b64786 100644
>>>> --- a/hw/virtio/vhost-iova-tree.h
>>>> +++ b/hw/virtio/vhost-iova-tree.h
>>>> @@ -23,5 +23,6 @@ const DMAMap *vhost_iova_tree_find_iova(const VhostIOVATree *iova_tree,
>>>>                                            const DMAMap *map);
>>>>    int vhost_iova_tree_map_alloc(VhostIOVATree *iova_tree, DMAMap *map);
>>>>    void vhost_iova_tree_remove(VhostIOVATree *iova_tree, DMAMap map);
>>>> +int vhost_iova_tree_insert(VhostIOVATree *iova_tree, DMAMap *map);
>>>>
>>>>    #endif
>>>> diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c
>>>> index 3cdaa12ed5..6702459065 100644
>>>> --- a/hw/virtio/vhost-vdpa.c
>>>> +++ b/hw/virtio/vhost-vdpa.c
>>>> @@ -361,10 +361,10 @@ static void vhost_vdpa_listener_region_add(MemoryListener *listener,
>>>>        if (s->shadow_data) {
>>>>            int r;
>>>>
>>>> -        mem_region.translated_addr = (hwaddr)(uintptr_t)vaddr,
>>>>            mem_region.size = int128_get64(llsize) - 1,
>>>>            mem_region.perm = IOMMU_ACCESS_FLAG(true, section->readonly),
>>>>
>>>> +        /* Allocate IOVA range and add the mapping to the IOVA tree */
>>>>            r = vhost_iova_tree_map_alloc(s->iova_tree, &mem_region);
>>>>            if (unlikely(r != IOVA_OK)) {
>>>>                error_report("Can't allocate a mapping (%d)", r);
>>>> @@ -372,6 +372,14 @@ static void vhost_vdpa_listener_region_add(MemoryListener *listener,
>>>>            }
>>>>
>>>>            iova = mem_region.iova;
>>>> +
>>>> +        /* Add mapping to the IOVA->HVA tree */
>>>> +        mem_region.translated_addr = (hwaddr)(uintptr_t)vaddr;
>>>> +        r = vhost_iova_tree_insert(s->iova_tree, &mem_region);
>>>> +        if (unlikely(r != IOVA_OK)) {
>>>> +            error_report("Can't add listener region mapping (%d)", r);
>>>> +            goto fail_map;
>>>> +        }
>>> I'd say it is not intuitive for the caller code.
>>>
>>>>        }
>>>>
>>>>        vhost_vdpa_iotlb_batch_begin_once(s);
>>>> @@ -1142,19 +1150,30 @@ static void vhost_vdpa_svq_unmap_rings(struct vhost_dev *dev,
>>>>     *
>>>>     * @v: Vhost-vdpa device
>>>>     * @needle: The area to search iova
>>>> + * @taddr: The translated address (SVQ HVA)
>>>>     * @errorp: Error pointer
>>>>     */
>>>>    static bool vhost_vdpa_svq_map_ring(struct vhost_vdpa *v, DMAMap *needle,
>>>> -                                    Error **errp)
>>>> +                                    hwaddr taddr, Error **errp)
>>>>    {
>>>>        int r;
>>>>
>>>> +    /* Allocate IOVA range and add the mapping to the IOVA tree */
>>>>        r = vhost_iova_tree_map_alloc(v->shared->iova_tree, needle);
>>>>        if (unlikely(r != IOVA_OK)) {
>>>>            error_setg(errp, "Cannot allocate iova (%d)", r);
>>>>            return false;
>>>>        }
>>>>
>>>> +    /* Add mapping to the IOVA->HVA tree */
>>>> +    needle->translated_addr = taddr;
>>>> +    r = vhost_iova_tree_insert(v->shared->iova_tree, needle);
>>>> +    if (unlikely(r != IOVA_OK)) {
>>>> +        error_setg(errp, "Cannot add SVQ vring mapping (%d)", r);
>>>> +        vhost_iova_tree_remove(v->shared->iova_tree, *needle);
>>>> +        return false;
>>>> +    }
>>>> +
>>>>        r = vhost_vdpa_dma_map(v->shared, v->address_space_id, needle->iova,
>>>>                               needle->size + 1,
>>>>                               (void *)(uintptr_t)needle->translated_addr,
>>>> @@ -1192,11 +1211,11 @@ static bool vhost_vdpa_svq_map_rings(struct vhost_dev *dev,
>>>>        vhost_svq_get_vring_addr(svq, &svq_addr);
>>>>
>>>>        driver_region = (DMAMap) {
>>>> -        .translated_addr = svq_addr.desc_user_addr,
>>>>            .size = driver_size - 1,
>>>>            .perm = IOMMU_RO,
>>>>        };
>>>> -    ok = vhost_vdpa_svq_map_ring(v, &driver_region, errp);
>>>> +    ok = vhost_vdpa_svq_map_ring(v, &driver_region, svq_addr.desc_user_addr,
>>>> +                                 errp);
>>>>        if (unlikely(!ok)) {
>>>>            error_prepend(errp, "Cannot create vq driver region: ");
>>>>            return false;
>>>> @@ -1206,11 +1225,11 @@ static bool vhost_vdpa_svq_map_rings(struct vhost_dev *dev,
>>>>        addr->avail_user_addr = driver_region.iova + avail_offset;
>>>>
>>>>        device_region = (DMAMap) {
>>>> -        .translated_addr = svq_addr.used_user_addr,
>>>>            .size = device_size - 1,
>>>>            .perm = IOMMU_RW,
>>>>        };
>>>> -    ok = vhost_vdpa_svq_map_ring(v, &device_region, errp);
>>>> +    ok = vhost_vdpa_svq_map_ring(v, &device_region, svq_addr.used_user_addr,
>>>> +                                 errp);
>>>>        if (unlikely(!ok)) {
>>>>            error_prepend(errp, "Cannot create vq device region: ");
>>>>            vhost_vdpa_svq_unmap_ring(v, driver_region.translated_addr);
>>>> diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
>>>> index 03457ead66..81da956b92 100644
>>>> --- a/net/vhost-vdpa.c
>>>> +++ b/net/vhost-vdpa.c
>>>> @@ -512,15 +512,24 @@ static int vhost_vdpa_cvq_map_buf(struct vhost_vdpa *v, void *buf, size_t size,
>>>>        DMAMap map = {};
>>>>        int r;
>>>>
>>>> -    map.translated_addr = (hwaddr)(uintptr_t)buf;
>>>>        map.size = size - 1;
>>>>        map.perm = write ? IOMMU_RW : IOMMU_RO,
>>>> +
>>>> +    /* Allocate IOVA range and add the mapping to the IOVA tree */
>>>>        r = vhost_iova_tree_map_alloc(v->shared->iova_tree, &map);
>>>>        if (unlikely(r != IOVA_OK)) {
>>>> -        error_report("Cannot map injected element");
>>>> +        error_report("Cannot allocate IOVA range for injected element");
>>>>            return r;
>>>>        }
>>>>
>>>> +    /* Add mapping to the IOVA->HVA tree */
>>>> +    map.translated_addr = (hwaddr)(uintptr_t)buf;
>>>> +    r = vhost_iova_tree_insert(v->shared->iova_tree, &map);
>>>> +    if (unlikely(r != IOVA_OK)) {
>>>> +        error_report("Cannot map injected element into IOVA->HVA tree");
>>>> +        goto dma_map_err;
>>>> +    }
>>>> +
>>>>        r = vhost_vdpa_dma_map(v->shared, v->address_space_id, map.iova,
>>>>                               vhost_vdpa_net_cvq_cmd_page_len(), buf, !write);
>>>>        if (unlikely(r < 0)) {
>>>> --
>>>> 2.43.5
>>>>


