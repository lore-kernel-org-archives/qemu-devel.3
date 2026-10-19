Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2193BCCF2DA
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2026 09:32:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIjia-0006uu-Nq; Mon, 19 Oct 2026 05:31:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1xIjiX-0006uH-Bz
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 05:31:41 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1xIjiV-0003fX-1P
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 05:31:41 -0400
Received: from pps.filterd (m0127841.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69J8OtXa3169505; Mon, 19 Oct 2026 02:31:22 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=qT+xoMU5DdQzgmI2sVD9hkL+V19lhJieKAElBE3tG
 P0=; b=KpYpwDzlEtmdZbGLDhmZRQU8TbuIUXAtmafhFM+8gTpQFsWWGkAXz0Q/D
 9dCocTmvZlwa/Gv7vLuKzXKceJQXpr9nBKwz4DuxP8Zogf3kgRNVRt6L4WwPvD03
 UnX1uXPubsp6n2h1jbRF/1dR/K4Khwly7m6N8xwczfoca5jqTm5W0I42rhcxUaRu
 gQ0FkOzf7PSPoNDkWFqXUktpcLVKNUK0AYEHgcOiyfQbwxdVE+SwXFFTeFxwdsxf
 zxK9kYLcAEEKNikzgcw0RwX8tu5igBMbn6wgJV0ckVYehed3GrvttiSssoxad8HI
 1wduwzuMGxJ0cq+OWUC1WQxZwva0g==
Received: from ch1pr05cu001.outbound.protection.outlook.com
 (mail-northcentralusazon11020081.outbound.protection.outlook.com
 [52.101.193.81])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4hc6j5k6kx-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 19 Oct 2026 02:31:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TSOSZDVP7nbEZHVlC3UZoYj7bOdit0x3IsBihUkehxFwZm1pjYquJQyvpAEORZy4GInArFJ54QkMzGwHFGFhn6gLVAWr/NB7iGH93sqnxV6aUlL0ADC9RnVy6SdRmf5SoLFJpUqIUIFLETiAhNPR8vUWuFH4vxrAwYuI1Ce2IWdKSFedIY0XzmPhVVrEsG67kxSHFwp/K2leP8m34C/D/K801WHY/JYNybSbb93lr9Z4atpdQPxxYHdH+2Hdlv+3ACSgYLIYq2jq3WZYdhCWhuOO+zRjYhzmXelwFeqU8Tcnt96RjN7t8VCqgT0awBPZ9j4MY+d0vkdsTwkzMaiYkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qT+xoMU5DdQzgmI2sVD9hkL+V19lhJieKAElBE3tGP0=;
 b=DnD/AT29JVI3tQPPghljsA7dxjvnJKv/7XqjcSKS2amu8ehDWmSmgjvgK+ukhF1EHVoM76XdJhCIJ7sK+4eHf9wv5xXJt5+0mQ83PfQSKlkmvTohHOXVqAjVXpla9lnucTbIxq4BP4HdTwb6IGeY0r3d4gsFB6UfCsOupyljTX3U+PuRwP1BMNgjnpQkW4CWkEQsfNnNxx8jJSr5jz+P2z6c3A1T6HzuYajEHNUcX50SrcNOL5VDk86xP/lVvj8sYTNUMGq5VsLNNBIo+fd7HKlCoa4sPmGEoxGQg4qHH3P7JE2ip4r8/ojIk9ycIkHZe5QCMn+jQQLrFhBqaGdInQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qT+xoMU5DdQzgmI2sVD9hkL+V19lhJieKAElBE3tGP0=;
 b=XMdc82Ado7BdP2ota9LZzeSUBS137/vfZP/XRwOsGPQ/lh+dHLKq1NhnUEisUblME5FH57OQCTRyPZiJNr7/vQlNI8Wwom3VLIoD+Lv66dN1GtRwUnBuzBiMKqjcGNyKmuj2xk5kKifV5Dw3diGNjRu9VPtWi1p7VTMSFC/uVFvfxdz1tG+zj1FihIG1xF0bOo0WXCFr6NKh00KnZkTkeMnyI5yOIlb1OCw29uwz0sM46eMr31fMqFDpJucphhsRLjnWxBasFiAtxxm1eJYZXHMWsHLE/c/vtn4PX5oFBIFZ9ymmeCLkvokUxYY8FGOhCpA1erNjcXdikVY3sn3sBQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nutanix.com;
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by CO6PR02MB7700.namprd02.prod.outlook.com (2603:10b6:303:a7::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Mon, 19 Oct
 2026 09:31:20 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%4]) with mapi id 15.21.0522.017; Mon, 19 Oct 2026
 09:31:20 +0000
Message-ID: <5002a7a5-3627-40bc-b0b6-404262106e3d@nutanix.com>
Date: Mon, 19 Oct 2026 10:31:15 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 18/27] i8259.c: introduce TYPE_I8259_PIC device
To: Peter Maydell <peter.maydell@linaro.org>
Cc: pbonzini@redhat.com, richard.henderson@linaro.org, mst@redhat.com,
 sstabellini@kernel.org, anthony@xenproject.org,
 edgar.iglesias@gmail.com, qemu-devel@nongnu.org,
 xen-devel@lists.xenproject.org
References: <20261016142031.1204281-1-mark.caveayland@nutanix.com>
 <20261016142031.1204281-19-mark.caveayland@nutanix.com>
 <CAFEAcA-bEvYdgzoqAsop7XU+aii+78R3WpwqmU_M_2dZXqA0kA@mail.gmail.com>
Content-Language: en-US
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
In-Reply-To: <CAFEAcA-bEvYdgzoqAsop7XU+aii+78R3WpwqmU_M_2dZXqA0kA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0032.namprd05.prod.outlook.com
 (2603:10b6:a03:33f::7) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|CO6PR02MB7700:EE_
X-MS-Office365-Filtering-Correlation-Id: f0bd79d0-e202-40a5-c955-08df2dc3bbbf
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|10067099003|56012099006|6133799003|22082099003|18002099003|4143699003;
X-Microsoft-Antispam-Message-Info: Q7T3qi+B766DUbt3/EKs5L8KkvtuARzXburSNK4UJylxw6ZWHLxBhBb3Fx3BT9URgk8kICUfwy/fm4uPvDWOB/tLoJPHHIQmzd5dPvn3xQ5SoS1akBlt9eFppIvxm54lkoCw6InnXFDKTyt/0aQEfK0d6rqJQBi5Xalr60MsBP9Q/t1CC1HRJf2SfX6033J8qc+Y3U1ObiHExX9jBMKH2pV3GuwowNLbx5MnqEA0VNuVrKkxXtG+U79ocwvqUPmgQHYSamp8551RIrKwq4uGLUE0ZqIAdb6YR0xd6I0fRyrMHDa78i2qiAvNqbExlKKVJLyvwslxiaOb/999LvI59mK7Xt2LAkhZsfHmi4VMLk373oKWXtLjwzNGnWJayN9EtY5g5dofIJz8rHAtufvPVpJnfNQQtc/RSFL8vZq26OEk0zGD75xGXdR4eyksyDkS/SmQ9HknaZ1zujwoBDPHnSQeKckAUnPppC6+IwbVKkeTjQ9gJLAjobcv2tXInLCs4O4XpuNk79eSJyrNXHHDUUD4iXQTOLhrPItB8HYSPNTjiK2RumGxLUpD1UoGrLv3DDteJT1xcH/UvSDSvPBndeVPF/Y7ZW6InGkllJZylxnPg8ybcfAyQWWIbODn3pgCFxBMmpqlRqfqhV1XT7fGEUdpnBlnRdGUR7HnryKPTbo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(10067099003)(56012099006)(6133799003)(22082099003)(18002099003)(4143699003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bVk2VlJCcyt3SFJBM1NGRHZXUytQaWRMUVM0T3REZkRBVXd6anRRTUJIcUNG?=
 =?utf-8?B?ZHY1SitIalhka2V1T0tYVDlEN245TGxDbVFJN0ZXMmwybXUwRE9ES0tRcEpp?=
 =?utf-8?B?d2NGUGcraExCZkdKdFZtcEQzVWNBb29ETEx1d2xmb0lOZlYrNENyRE11ZWlQ?=
 =?utf-8?B?SmNVMzBBN2YwWndYaXFEaFFkRk45UldxZjFMMWpjaE41SWhKeVloVUlQMmlW?=
 =?utf-8?B?UEJzbjFTWHNtN2VaMFViQ0lyWG00VDVQKzZXRm5Fc0JiVGxZMGVsczFHNHRE?=
 =?utf-8?B?L2h6OGtPcVpObjdydExITHFHY0hZMCtRZnRaeTd4c1lkZ0U4d1RKNlZWSWc1?=
 =?utf-8?B?c21TaTlEQlE5UStjekdraXU0RnhUYitzT1hpSGU1QWRiRXlaTVlaMVRsZExV?=
 =?utf-8?B?RHcrWWhuVkFzRkVJU2gvN3g2RVpGRjVJUWljWGMxZHQ0eXFIUURDQm9lYTNH?=
 =?utf-8?B?aGJndzdIVHdPdlFESGR6VG5oekNpbExmdzJIZEZkcWEvbWRlZGFmRVZIOWxu?=
 =?utf-8?B?cGtMZlB0cHV3dFR1cDhtcHBNajJKRnE4ZVNISmY1M3VHdkRicHVqdzdQUjVq?=
 =?utf-8?B?WmhzMTlNT1EyTDBKdUNkS09SYVZYN29TTVhFa1FUNTRmcmxPbk5UNjkvYVRG?=
 =?utf-8?B?Q3ZCZmxWdFZTR000eVJ1MzhiZ055QVk3YWJQOE1kbGdEdy9iK3Mrb1hwWDB3?=
 =?utf-8?B?MmU5bGd2OVd4K3duSXMrZjUvN1dEN093eVZsNU9lL3ViQS9CK2d6aHRONVRJ?=
 =?utf-8?B?WTg3ZllYbmZhTUdrTGlDL0JoTW9PSUZJZU9OeVNUT0JvVkwrckxrZVJCUThC?=
 =?utf-8?B?WjdnWklDV2w4UHFneHlSbmN1UVdiSUNNZENEMGpMV3czQmQ4QkxxL1lJR2VT?=
 =?utf-8?B?Qzh6WTNRQXY4SUFyclhsZTZ2b3JCRWs2QlNEQnpYdTdZTHhVYUppOTZPLzk5?=
 =?utf-8?B?QisyYVlEVFJ2WXhJNHpTV2ZvSHhPNE5aUTNDT2xoZi9zSlIvcTBTUTgrc1B0?=
 =?utf-8?B?MzV2SmFweEJ6ejlhUWt3ODEyMWJmVnp2eEFZaHovZlByMVp1eTdFMHFNUllD?=
 =?utf-8?B?QWVCd2dpSENpVWdNN2h2WitmeGFNeVp4T2o5U2lGemNQTlVoV2k5WDFrVSt5?=
 =?utf-8?B?Y1psT05WQ0JDZmZ2NExEckx1dWdacW11aFVtWFZrYnpXelNhSWErNFhBZzFn?=
 =?utf-8?B?dVhFWU5id1BQdmg3Nm0vWFU5ZUtZQ0NVTTV0MDlQRWVnL2pudm4rbjNKU1Zh?=
 =?utf-8?B?N1hya3EzWjFqY3lKV2lnTHVGU01Vb2xtbDFXd05Hd3ZlOWd3cnpxNlREOEVZ?=
 =?utf-8?B?MitaUTRDQkpzVCtEWDRjRmQ1V1lsUTAxUmZGeFN3WWhxbnc1dUd3N2lMNjdZ?=
 =?utf-8?B?UmJlSk9oQm9UMTVNWVR0MzFUUkpPQURNcVdzblpBOCswYU1KSTRjRytaaW8x?=
 =?utf-8?B?QmNJQzVQeENHMjhBT2pINit3b3lTOXVmSkFtdVlZNHNEOUdmUS9CeXZvVG5T?=
 =?utf-8?B?N1E3K0FEQ0FicTROK3A2cVh2Nm51M3JmWXFGbFRuYmJFZEd4d0F0SmNCOFBU?=
 =?utf-8?B?RXNqNlVLOXJwL1BmRlNiNnN0UlBaZ1hobUNjeTJDWjlSbWFlWVduQ1FZTW1Y?=
 =?utf-8?B?Z0JDZTg1VVRhS1RxRWhiNXVhQ0dqblE2TTZIMkxpdEdtNnBodWxsMTFjN1BV?=
 =?utf-8?B?MkJzWVlGVU9RYTIrRWNuS2ZDN0Y3L0kwL3RpWTRPdzdWeXJkOXgzemJPdlcr?=
 =?utf-8?B?MkFYUmpjN2l0dGE5aHFSeitsVTRsVmZ0c25LNWcyZXlWVUZtQkxjVVg1VStv?=
 =?utf-8?B?Q1dZdEJkRkZvZkVYZVk4NUNQQ3R1d2F5Z3VVS2tjTDcySW5Qd3ROeTBCcjZ6?=
 =?utf-8?B?aFRGa0t2SUowNjN3NFdySlg1N3BoakhKc1NZWVlQZ2pJOWhmTFBJQmlYaERN?=
 =?utf-8?B?cjloL2ZZazlqemtMZDBHZjQxSUNSeVA4MkhFbEhFaDIwM1E3UVNXR2R1bm02?=
 =?utf-8?B?RmF1YWFIZzJEMlc3K3daUjgrTVFQQ1N2VnNwRCtwZGhMRkU1SkRxaitpY2No?=
 =?utf-8?B?MU9YN0x4SDRTSk5aeEYvQVVZbjJSdXZxV0ViTDZ1ZW9YRitnSVNKSFVvdjhI?=
 =?utf-8?B?YTB0Sm42ZDgrMjlrNkpsUjZKU21PMGRYN2tCYVhwbGJmSktYeEhGQXd6R1Bt?=
 =?utf-8?B?cjVkMUQ3UHhPTU1UVjBKY3dhRU1Yc0YzcFdHeis0V1hiSGFnMnorUktYbHlK?=
 =?utf-8?B?VzFMdEhMRmI0MEIwSm5iV1F3WG9CVGxBSVpiSzQzSThnTXZuSU1XaXRubmZv?=
 =?utf-8?B?RFRPaEhKSUtRRmI0Wldra254VXh1SVAzZzRYZkRnaTRMSk9ScEI3UjJOUnZB?=
 =?utf-8?Q?etqeK8ZfYcN853A8=3D?=
X-Exchange-RoutingPolicyChecked: I9O/itQLqObpZQYf0kQLHrPcjo3zyN36V6z13EvcdwPy1fRpoxO2kAE2pqmV93eNuHiYukPk5yK99MExHVHnoGhX/jCcjhUtHf9hGq8ERQa5xCHshD0s+NS8iK54dHfxTVhtFPQfitJ03Nwq8UPnCkCG37+FBkbO/A5it8AXRpat3MhfqJJiBMe9KEWMfDRU35GZzw327McwFgdYzjycCC846y0uEokEt7/chxNwtGhYoOh5GVQ7v4GH5q8sjswUrNiH81Pk/3ITaCPpl2UMFCnvTCWsik+iLVFi1aCjdRntdGXr5UW0Zrx4sdrjJmkKCcUjYWoWdyhdevu0oA8FYA==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0bd79d0-e202-40a5-c955-08df2dc3bbbf
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2026 09:31:20.3097 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +WmI5Fc3YBR2wukl7O5/EEiKWAWTYM993LKcgR4C283ycSVw1GVCjmSu2H/8xOXgd1ZnAugD9mx/jzbChS7bymgY+dNEvyzNngB88yKHK2w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR02MB7700
X-Authority-Analysis: v=2.4 cv=S+NMU4sP c=1 sm=1 tr=0 ts=6ad5e36a cx=c_pps
 a=6CsdduS81u+lxnadr1BEog==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=jxMXjlTPpCISP5mWtjnE:22
 a=64Cc0HZtAAAA:8 a=Y7PUAx_Gt6IB--uV870A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDAzNyBTYWx0ZWRfX7ppgsvCK6De3
 Rjk+mNdbBYYtaSaUrqrTloDnqyPEGciK6X4wzXWgnl5DvGoQQolfLnGrWysGkWs8u5AtMsXD994
 9B+r2GpTXrNwGrXIIHrqXF0kgYbQpWo=
X-Proofpoint-GUID: NNG7sLeqspMfz8MzdHNubRPqAV8UlXkS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDAzNyBTYWx0ZWRfXxlwGmCXrAz2k
 tF1rizApd/iLQv9EgcAm+C2RAub0xcMXw2Ljj+HZOMUN+xj5dJMpHbu8erM1Xyto1u78uRosa2h
 EIs50q5kl4Amp47gm5FKvIa+8NjekLkhHs6r86Jvm+b9yO3L3fWUP/jzS6GyyiV1Ge35e3F3Ovz
 8ldenpbeaRU1Cqz7BO5Xp5IRg4bVIgJVuP+TTj8NUGjkKYnSCoKdcr7VGijsJ6WTqva62yYlhDf
 XDUC+FPholsYZJLA5U3aJFVtX3Zguu5maCAvJ2dSm3DzcMWyhC6foaGd6dFZvfHtw5n4rwe1Kno
 k+fU104uL/nlvpy677WWq96vWh/O3IKBIxn1yQ5aWhWK3Fw4xVZP/QXAPOuo2EcW6KFSTEvH86r
 Yh/BSqQPFqnDBecE4we8Z7/aJhSs7rLfvYNYqyhKDlFb9sjWeNHhgxgYfgh+QNOPcAhJX04yMQ7
 FxaklMf8q9LZGFWqxbg==
X-Proofpoint-ORIG-GUID: NNG7sLeqspMfz8MzdHNubRPqAV8UlXkS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_03,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.01, SPF_HELO_NONE=0.001,
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

On 16/10/2026 17:17, Peter Maydell wrote:

> On Fri, 16 Oct 2026 at 15:23, Mark Cave-Ayland
> <mark.caveayland@nutanix.com> wrote:
>>
>> This device represents a PIC for an x86 machine consisting of 2 cascaded i8259
>> devices wired accordingly.
>>
>> Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
> 
>> +static void i8259_pic_init(Object *obj)
>> +{
>> +    I8259PICState *s = I8259_PIC(obj);
>> +
>> +    object_initialize_child(obj, "primary", &s->i8259[0], TYPE_I8259);
>> +    object_initialize_child(obj, "secondary", &s->i8259[1], TYPE_I8259);
>> +
>> +    qemu_init_irq(&s->i8259_primary_out_irq, i8259_primary_out_irq, s, 1);
>> +
>> +    qdev_init_gpio_in(DEVICE(obj), i8259_pic_set_irq, ISA_NUM_IRQS);
>> +    qdev_init_gpio_out(DEVICE(obj), &s->pic_out_irq, 1);
>> +}
>> +
>> +static void i8259_pic_realize(DeviceState *dev, Error **errp)
>> +{
>> +    I8259PICState *s = I8259_PIC(dev);
>> +    DeviceState *pri_dev, *sec_dev;
>> +    int i;
>> +
>> +    /* Primary */
>> +    pri_dev = DEVICE(&s->i8259[0]);
>> +    qdev_prop_set_uint32(pri_dev, "iobase", 0x20);
>> +    qdev_prop_set_uint32(pri_dev, "elcr_addr", 0x4d0);
>> +    qdev_prop_set_uint8(pri_dev, "elcr_mask", 0xf8);
>> +    qdev_prop_set_bit(pri_dev, "master", 1);
>> +    if (!isa_realize_and_unref(ISA_DEVICE(pri_dev), s->isabus, errp)) {
>> +        return;
>> +    }
> 
> I'm not sure the _and_unref version is what we want here. The
> documentation for qdev_realize_and_unref says:
> 
>   * If you are embedding the device into some other QOM device and
>   * initialized it via some variant on object_initialize_child() then
>   * do not use this function, because that family of functions arrange
>   * for the only reference to the child device to be held by the parent
>   * via the child<> property, and so the reference-count-drop done here
>   * would be incorrect. For that use case you want qdev_realize().
Yes indeed, you're right - I missed this when porting it over from the 
old i8259_init_chip() function. Even more amusing is that there is 
currently no isa_realize() function, so this is obviously the first 
container device being implemented for use on the ISA bus.

I'll add a suitable isa_realize() function in v3.


ATB,

Mark.


