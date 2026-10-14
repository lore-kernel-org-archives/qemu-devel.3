Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 900EACC6B1A
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 11:22:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGx48-0006vJ-Hq; Wed, 14 Oct 2026 07:22:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1xGx44-0006v2-Bn
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 07:22:32 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1xGx42-0005Ia-Lp
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 07:22:32 -0400
Received: from pps.filterd (m0127842.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69EAYIrZ3386605; Wed, 14 Oct 2026 04:22:24 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=UntIQfcG69Yt7u5iVkMIcsZ3ycgkHq/G3KI1rc32G
 QY=; b=BqGloufSmgUFn7ahaGnx6UG4FjmEvnalPeUmGnNUetdK9Wu48p0zwW0l9
 cvRGaBNNngcZyZOiPZvK3kr4JpT2+pz3X8IQlTTlc5jyLL7CQW0G6twsOCcRSZ5c
 KCT/83/oEv17K/IJ8jbEofkLCkzIXpQnY9breO0F7Tt2C6voVWAAmDN7dk6AkGSB
 2YmGSwGhv52S32zKB9thTaGbnHcKAmkQGCovvINALt4zqRnWeoNhIKfeIjJtM8TU
 ZknOFhbC7/b1Iye4jELdnJBDTjAyYY86VUWBTTrF+IOLHkth8Owo/0hyMH0cFkdv
 SuZHhQ7ua7QcAhmDM7YfMdMEYWdiQ==
Received: from mw6pr02cu001.outbound.protection.outlook.com
 (mail-westus2azon11022128.outbound.protection.outlook.com [52.101.48.128])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4ha83mr3g5-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 14 Oct 2026 04:22:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZVsweAuqoYydf6q2FqQCJ37fkFvnTaxBtijuERGV2KJRPmcn/+ll+36+1EwDL9a6Giny5zYPqsYDp9eWHQNu3LYl7WRZX5ddIi6bJ2a09x//PZAVmu13Y7FUett1c3EmxsfUzhMrKMSam79xh6g6BocJJNpSkcLxP+blzF6OSZZuSarNP7vjJbg87u+blLng4/8R9SI5444Qp3shFdKIEBmpmbI1xlgR9sq2eCKJKrsHG8ylLqPTdNjRCiD/itV7diMjdWBL9x2zPLrLjiPcF+MMQQlxgILSd5J5lFQNpdllUVb5h7FUWLIXVCo++KzTafZ8vYT6E1suEbz5dOP0sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UntIQfcG69Yt7u5iVkMIcsZ3ycgkHq/G3KI1rc32GQY=;
 b=GRVMEeKRrQWlIPSjnCUiIkg+SsWm6UGNsyEXuZdDU9SMUojj75R+J/eaA39IPKJ9bnNnkpb3fjveArKPabfRq4132W//q932OeAw+7Ms8WmrWmKa2qmMLgDcgbHh2d36yPR9Rs+OoXSQrKPY9YTfLFnELw/cNiIS745IFh/NJJtqcgDbC+dBU1bvfw6Szt3L1ZPQTZS8XNdj6S2llWDtzkpDXTPkswD4ztlrT5N61bG82GWfaqxwxSHG3diGMAfY7W41ZYJuDCZBden406a+OMWXTvvNIyARpnPU5j3uYhQLep7ICQcu6eI0ZvHrew+3TvEVG9KmQPI9ozLjlBVnrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UntIQfcG69Yt7u5iVkMIcsZ3ycgkHq/G3KI1rc32GQY=;
 b=mrWyZHsZPZylhcODNQ87NxeZDVtBFtgFp/6EImj7x7aGuom6aybNsxGV47ngGYyV4KsZrh3ioGbxLB/3maFJ/o+DdUi0MqN0DRXCvUB8jo0PO6mPbuM101Oj7yovh5cN6C2QU8hIzY61Y6pH73/Z2uVKcBsltc+TvOM0ylYdHVZutkAvH0rgmrXcNJTCzzc5IprdrdmO1DHA3fuNonXvfrJ9ge/2UUtGJ/7XZb9bWd2lxfUzDiRJPBAPI7FJddxwWDJ6IwOd39MfI16JI09maK1RBPj9mnYeOEvhwxIQHgY6PfTFQLA1cX2rYZgdEzaNKNwYkR3rYUTghj3OQiIrKQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nutanix.com;
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by SA2PR02MB7595.namprd02.prod.outlook.com (2603:10b6:806:146::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.12; Wed, 14 Oct
 2026 11:22:19 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%4]) with mapi id 15.21.0522.012; Wed, 14 Oct 2026
 11:22:19 +0000
Message-ID: <bf4d91fe-9899-4bcf-9ed3-34705caab889@nutanix.com>
Date: Wed, 14 Oct 2026 12:22:15 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 20/22] i8259.c: switch isa_pic from I8259CommonState to
 I8259PICState
To: Peter Maydell <peter.maydell@linaro.org>
Cc: pbonzini@redhat.com, richard.henderson@linaro.org, mst@redhat.com,
 sstabellini@kernel.org, anthony@xenproject.org,
 edgar.iglesias@gmail.com, qemu-devel@nongnu.org,
 xen-devel@lists.xenproject.org
References: <20260916104435.600211-1-mark.caveayland@nutanix.com>
 <20260916104435.600211-21-mark.caveayland@nutanix.com>
 <CAFEAcA-BxUQAg6uVPn7EMP=xJ_J7oa6FD6hxZFrmQJmf=-VhoQ@mail.gmail.com>
Content-Language: en-US
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
In-Reply-To: <CAFEAcA-BxUQAg6uVPn7EMP=xJ_J7oa6FD6hxZFrmQJmf=-VhoQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0119.namprd05.prod.outlook.com
 (2603:10b6:a03:334::34) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|SA2PR02MB7595:EE_
X-MS-Office365-Filtering-Correlation-Id: ff002fc7-40fc-4c1e-9d0d-08df29e56900
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|23010399003|56012099006|4143699003|10067099003|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info: /mdbVpV0JpoXmAb2RFY3hrzuqX3Xlg/B4ChwbuX75S+i6DerfGil0XUmPDXgODVtAAqj6C8hO/PFDcLrUDheT3UIDJhX/plEVe/J0uRTsQH8Vl+jzBjslqSHJPW4FNj1bg0uFBUTeFDAr8gQgA3PZWT0XEf1i4+CqSqa00Sn3p+rNU4qtO3UKsouVE9qWEuUe0+V/WZ+XDbBNBDXtB1kY89g1r+QXMI/uxwdYh1R7eZwYKbz9Rp6ddq01HRLtkThvoE2yKkdK6XTEIKWbmUsATmwlTgkUzKEgn3kjokCjktxXdK1RDplXKCGPKjEFE7VF5O+/xy8zj7er2wWY+i3jZFob+lwpl+Dd6Fq+pk1dproppyl9oKI612Qdwsm8vn6QA+gL4vHo+bBouOFy7rGxT6pucaUY27HetXGrbp/mjNWqcdg21aJuIxAWSSY3klPZPNU/KIuDjoT55fTlbawBad/YCUsqhZQjkQ7ryRrBU2ofUaugmfPbgAivPtazdMaO0vYivsIa8qd9Paq9q93Tlr4EdY6Hu/Ph6mqkjRJQ8q0IRsiZ9HH65L8CJtKfC/ZxQYLLOE7/zPMMGtmIhr5XPzbnAZ+2WKWGVa1MOvIjmBSW/vM+BlGJTFx4tQtC8snfrN/n6IRqir7gXPW6p+99lZwFRKUTKYpiWsvXn2YXgM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(56012099006)(4143699003)(10067099003)(22082099003)(18002099003)(3023799007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V0lzY3FCOTltVmhQeHdHYTRsOGhvdy8xQ01MUWcyNWpJZDhvck1DOWhqYmZC?=
 =?utf-8?B?YjdJdmpVQ1NSYURHK29wb213TDhwbkYvcFpiTlhzbWRNaXRIamgxU0JjRm1V?=
 =?utf-8?B?UWJqaUJIWDVKeElZaHZkbVlhMko2cVJrN3RIc3RRNnNRYWNsSzE4Yk0vS2sx?=
 =?utf-8?B?c3dPZkxuOUV0enJsLys0YzZmSWJlNmVBczc1eXUzQmVvN3FxSTZtamZTdzNa?=
 =?utf-8?B?dzk2cllINVRVUkQvams2SHNjSGdyMk5MZ0FlMEZUMUIyR0dUUkVJcEFOOHlm?=
 =?utf-8?B?UDl4L21XQmhjOTBUN010QzZvOEFaNm9jdno1R3BXYW41UmZ5ODNSNDJ5R1dn?=
 =?utf-8?B?Tm1PZFBiWVhveEMxU04wTzJBaHZXODZEdjNVTTRhNCsxQ3dkamdCN1AwV2pn?=
 =?utf-8?B?Z3ZRcHVmSWM5MUpzTkhJOEhodC9wdEtFMUl1ekxCaFlNdHJVR0U1cTBsczJl?=
 =?utf-8?B?QjcvNkZYbWhmV2hxV0E3RlRVNmJBWXlYVktvellnNHpxRmJ0Um4rRVoxSWtF?=
 =?utf-8?B?WWZMUWlobzZmb0ZPcTJBdmlIUEpZVlo0dmZIQXdEZ1Q5a1BmU2hhMHk1NEJ6?=
 =?utf-8?B?NHhHWGdDd2E3RG5OSFFFbTN1TzlTV2JzTGFrcnVOTXE2Z3lkZEJFWnlQT1NO?=
 =?utf-8?B?Vk1XbFg4T2xhayswdVFTbzNxalV2cTN2d2xFWlI5dVBNZUZwUVhUZktNRDZm?=
 =?utf-8?B?VTRua0M0allSTzFwOHYvUy9qS3hQNWZtcjJnb0NSWk1SUk9TTjhLNEU1WTF1?=
 =?utf-8?B?QXdHTysrdDJWWnBoNHVZeFJhN0JMWk4rdVErVjFIV2JRc2hFZ05TRm9FRGNK?=
 =?utf-8?B?djBzdlFGejliVWVPRjZQbWEyajc5NEw3VHBTd3NodWdmdy92NVJ2dUd3MFI0?=
 =?utf-8?B?MlQ1UlQxZVZoRVZqK0Jrc3B2bDVXeU1SbkhXM25TeE1VMC94UlF5Z1B4K1BB?=
 =?utf-8?B?b2ZLMmYxNVoycm1MejVkaTZWdVJzK0JjdFFhaHJGZWJMeUdZVy9Pd1V3c3ZW?=
 =?utf-8?B?ai81T0FGU2tySUtQSkk0QkFGc1R2b295NVlLeEVQV1BXNTdOWCtvTVl4WjVm?=
 =?utf-8?B?L2ZldldxM01SUHEvcUFLN0VZQlc2VWZBbHh5U0Z4SUwyMkZndWNGVWNMQzNp?=
 =?utf-8?B?b3lmZkpVQ0FmcjV2WjBtNVJRNGN2SXFMeVVBMkFUNEVIQi9nU1dyNnR3Tzd0?=
 =?utf-8?B?NDNxVXhQNnpleDh3NmJqN253S3o4cVJ5RWhKa0swR3crZ2gzcThKZ0xON2ZU?=
 =?utf-8?B?eDViUEViRW5pQ3ZpN29pRnNWNUcrRlhBTTh2ZjlJYzdqc2RzMnJBMjZIcTRt?=
 =?utf-8?B?T0wyWDhWc3M0MmM2TE1mRGlCV0hKazZvUjZxTnhrWGFZdjQ3Q2duNm4vT0dv?=
 =?utf-8?B?QVRMcDhkUXFMMndhVkJ4SkxiNU02SU1kMkV4N1p0N2svNWt4bUprUGVsblhu?=
 =?utf-8?B?V2V4UVFFdUlxTmhYNzQ1SjdDanNWRHpVaDlOb25zLzNzc3YwRm16MUR3aUNF?=
 =?utf-8?B?bE5PN2tYc3B5RGZSYkxneXpMTi9IQ0M5RURYNUV1V0puNzFxbEdGdFZWc3Nu?=
 =?utf-8?B?eTVXVy9SeGMvZmNNeEkyWncrMU5jV3dlb0xhdldLNjU4TGVGdC9Db3JxQ294?=
 =?utf-8?B?SUcrSGFMU1VUTyt1SDViSEkybEd0N01LRFBaOHBCc1VBNHF2WEZWSVBDR0Qy?=
 =?utf-8?B?c0tNZGh5d3NyM3pUa3I4S3Z4SDdpS2J4K09iOEs0T0lpZERXSGd4dzF5eC9T?=
 =?utf-8?B?T3BkLzRiZ0JFYVl1a1J3TFpTY2kyL1FBeXFaRC9QcmVpL1pBejZTdWNIRDlj?=
 =?utf-8?B?b2diem5uS3E5bGdRYmI1MkVzTThVdHUvUnlaUzlCTWM4RFBoWWpZN0orUFVj?=
 =?utf-8?B?c3k1allGQ1FZcnhISG1najhJZkFDbDRSWjBPRnBDVWxwQlFnNkRHYW52cUM5?=
 =?utf-8?B?RW43WEtFTXpYbE9zVE5Ib1gxTVJvUUlFYlJBNGtXdUV4SU5ld3pNK2NlcU95?=
 =?utf-8?B?YXM4Nm9Nbmp2a2tFeWo0WUpCdTFtcjdtVU1MTWxDMGZWc09pQU5GcnIrZGhk?=
 =?utf-8?B?TllCREpKUVdMRU1OV0hvR3RSSGlseW4xcS9LT2t6Y25UZFlaZlRldVMycGhC?=
 =?utf-8?B?YUdyTVdtWWdKOWxpTFBBeS91RGRFSUZSM282M0ljeUdGM1FqM0RHUnRnTlRC?=
 =?utf-8?B?YzROeEdabGFzQ2dvaFgxZEYzelRDSnVyeGNsNXljMXZhZzdkZ1RuY2V3ekgy?=
 =?utf-8?B?RGFRZm5mb0U0TWI3andJaFhUWlBOaXZuSSs2TXgyWlJ3Y3VNNzVMeDN1WVlT?=
 =?utf-8?B?Zmt2dEFjOHRCQlFIdXRRMDQzakFWOUkzNXdEbituYy85TUhSaG1aYmxyUW40?=
 =?utf-8?Q?79A7NTN83y4P4YAc=3D?=
X-Exchange-RoutingPolicyChecked: 0T3v1sRxGngYg4lVFn+5vuZsnsdNsnAgE6aWHkIU+/wHe0rRzTdW2Zw3Nybu0fMdAb43uwzNPx/ziwlhNJZL1UrJyt+Gj44aYEdVgVkLETn9rE4eVruvucUqwWu7nZltfAyKyZSA4kIX96cTTB13yP6lt16pNLVNtqCCncTkOhadXLzWWqppOj5hPqfsHv/CfbL7b46sfl/g+HUQpVi+NJHPeGkC3zWoBWmoF4pDRfDOcFUgFNBVN7unnwYamIolP9ShkkS3bZcQdijI6V7DuO1nq1AJj3EUOj4xL6fTPMZJuff0PV4ZBLyOXl8XKtHtjrDDWfRlFEnZ99l5xTZ85w==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff002fc7-40fc-4c1e-9d0d-08df29e56900
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2026 11:22:19.7537 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EF26cXjKQS+gqaD7NPZWrDn4LEkovLoWq363xUxAeV4m63y+esgsaXvsRh7KHPz83Yw0ft3YU+LbqXZsH6BToMZLXJ5hJciA38aXal+cCrQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR02MB7595
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE0MDA0NSBTYWx0ZWRfX7AGoJLee5MsM
 xn/ff4R9P9vYQjyeEi/jcDWSM9s042NkrF53Roya7boAbxuwrGWdxAcF6FS8iW6QrLFCh/0/7wn
 w6Z2arOeiKF+WTvnA/DfsJx/za/OhvI=
X-Authority-Analysis: v=2.4 cv=BroIUoX5 c=1 sm=1 tr=0 ts=6acf65ef cx=c_pps
 a=YH7lkWZYaMs4szCCOGs1MA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=VUi8bpU7OL1Oj2-RSIOF:22
 a=64Cc0HZtAAAA:8 a=KKAkSRfTAAAA:8 a=u4KNI37tBQhSRKA6Y0EA:9 a=QEXdDO2ut3YA:10
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE0MDA0NSBTYWx0ZWRfXxD6Kbnxx7nX5
 xbvHX91OV1qUTzw532RnIEHGENN9Fi5HpEhx8kAZSkJcBscExK6sgIwGUyC1Sb83Lti0dnBYGuP
 fQ6M2aNcmtKiTIT8q4AcvtljReuo7ZbR8V4wo9Cmy152T+cmhX/3WNtmPVN9w+3lXuFgNhZhuYd
 GkiqCCsOKhmTGnWm+iZItfyI9yoRGhv1spBAIxHiEIJTatGozYhqFHPNcjTeCf9IbD3u3zCtLNY
 z2R7KUOr3U3TCDVs8NWStV+b9N+igA0tjyD4nagM/AudfC9pUk2SbRxTwdivtocXAN/zIC2G+aQ
 oYLppq1FzuGeTq+cWfQCj0sf5/XWCH6ZjQXeaM9FbekMD1ZQKx55u+ehv1Ip9iwFQ+qKbKywmWk
 BdN96f6DZpD/nMrmwzCDP1TenH6HAt4gei/9H6YW8GV7w4mSfP/daWnCL7idgICGkBq8+IehDgy
 Zh/q1W0HrFYCxNN242A==
X-Proofpoint-ORIG-GUID: T9GUL-4qYX6fW2DGlM3He4xezAoJSspX
X-Proofpoint-GUID: T9GUL-4qYX6fW2DGlM3He4xezAoJSspX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
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

On 13/10/2026 17:26, Peter Maydell wrote:

> On Wed, 16 Sept 2026 at 11:49, Mark Cave-Ayland
> <mark.caveayland@nutanix.com> wrote:
>>
>> The isa_pic variable exists to allow the output to be fetched or read (fetched
>> and acknowledged) from the x86 PIC. Since this can also contain a cascaded
>> interrupt from a slave i8259, switch isa_pic from I8259CommonState to
>> I8259PICState and update both pic_get_output() and pic_read_irq() accordingly.
>>
>> This has the advantage that a i8259-based PIC device contains its own internal
>> reference to both the primary and secondary i8259s, and therefore it becomes
>> possible to completely remove the slave_pic variable.
>>
>> Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
>> ---
> 
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> 
> (That isa_pic global is kind of ugly; in an ideal world the callers
> would have a pointer to the PIC they cared about rather than relying
> on there being exactly one in the system...)
That was actually one of the ultimate aims of this series, however I 
submitted the 8259 changes separately to avoid sending a much larger 
series :)


ATB,

Mark.


