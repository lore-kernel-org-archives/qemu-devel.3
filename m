Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60361C5DF87
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2026 11:18:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wxNEk-0006lm-8O; Fri, 21 Aug 2026 07:16:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wxNEi-0006ky-Dx; Fri, 21 Aug 2026 07:16:36 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wxNEg-0002FE-PY; Fri, 21 Aug 2026 07:16:36 -0400
Received: from pps.filterd (m0127844.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67L9Mll21901672; Fri, 21 Aug 2026 04:16:24 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=MN4Y1rdrBTrVK9KqX/e3vX+Q592g6DomBOdi7xye5
 +E=; b=a8kTu4YDLXpolno/0N8/G6SL5hDRb30mGCQpz3dshB/iConeUe/sm3dg8
 aLGS7owa4AprfbNUJB9earrafV1MKo80cPUvQvXKVAlHuXUm0RcXBc5J31D7STjv
 K2dzzpfa8YjTMQ050H8EFsviOr/gAc421aPqaEBUwsTXQ869shRNnLyrvaV4rB0q
 uoj0f65D8BO9PPmm3lWQGILs7iTrnKJI0k5xWQJb/jbKflnHW6jZDFBl277z+1qD
 ivkhx36QI/MseRoaBR6FutMA3g0WSElRlEM9DiK/fAMib+LV+0SiIt+XvJZzRnyG
 e5swJyvHP0lxFzYK442MpbRiAMixA==
Received: from ph0pr06cu001.outbound.protection.outlook.com
 (mail-westus3azon11021130.outbound.protection.outlook.com [40.107.208.130])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4g6cm1s0ts-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 21 Aug 2026 04:16:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CWJPlFfqVJ8zOcn/l/DtrV+NAdaVjyyB7bJlePOcZn/dL6tdK+80cIHmx4iwB7Ysd5zkVAjT3OLWFqcvBjxpTFKL6PxXYVaVy2/+X4bVz3QSCg1C1SYzEUmmB4SjQCL0IFiRDPCDdMjksa09vFrpAlYuko8j50ShcjC9kmZmOEfIchyeag7D6XJLx/jAzbbYGMUlBpqbq20W9QIuvHROEA5zoVrxgYSdZvAfkjJRTlPH5etFMqaju2T8nw9K36YJWf+NzfNHqFvQPNW8i3fEA7Q6i9aB5arbCh4eAiwSXCICx92afnSjqtpLpQmMJ3V0eGaH2TEqN5xZwrtt7QahWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MN4Y1rdrBTrVK9KqX/e3vX+Q592g6DomBOdi7xye5+E=;
 b=Lf+47i6doTbCSGciCyaZQPCRN8e38qbLmev9JMbCPuz4gTmofniuHYc/hbP/nQanTCBH/vkKcD7wgTqNCr9SA3MJwUfv4I/ulnNCYWLtepZFAgFGA2mwP7v6lD+3L0va+LrZJl6m0AON7dFFoj+KZ+NWKkNIhtWU6dLtJr72PI/BL17HIo8zf8ISZXdAXYkLawpYHprS7c2GZevyqNh0/zcKvsTj6jX7LTeV3AFrei+wSoZxFGs+PfzGRa0+7Y+1NKgyHgKBxVINihEBdoRHBRRwZR8rdj7V4AnYSYrLMJKgFcvGML47kuyYqt6z5h21ysfRQDU1hpNBWdwMVplG1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MN4Y1rdrBTrVK9KqX/e3vX+Q592g6DomBOdi7xye5+E=;
 b=Rl+q7smhH9MvlTr1xAvAa0e3wPAg/wVY12vhE92fPDigw+ezzQaDOwgF32F7elygAWIUKfFm+UXMXwwh9Jzp1OhFoU4PCggVz60UiC9REJghkL1sipBA2Kw5zkth2DuJTwCbP4IXtaF7R5+YovEFBOmC3c35DWekEkrqLNnKtPRCG+2mg+3ZcAAMNGpIw0j7uTQvc/Y/GGSZ4L0T7iFysDyIW4Jrs3UVWWQka67jDo2u1RpawuigN9yy2uCVZsVw7pUDhfNyLjydJFxRtGMeebAuI8eY+8H/Qko3XXStdXefCHebjcGIDsn1l+HQp9aUeA+py6q87qdr+MWFedU1BQ==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by CY8PR02MB9524.namprd02.prod.outlook.com (2603:10b6:930:6c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.11; Fri, 21 Aug
 2026 11:16:21 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%3]) with mapi id 15.21.0339.010; Fri, 21 Aug 2026
 11:16:20 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: mst@redhat.com, imammedo@redhat.com, anisinha@redhat.com, philmd@mailo.com,
 aurelien@aurel32.net, peter.maydell@linaro.org,
 richard.henderson@linaro.org, berrange@redhat.com,
 marcandre.lureau@redhat.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org
Subject: [PATCH v4 08/16] qom/object.c: add
 object_class_property_add_uint32_ptr()
Date: Fri, 21 Aug 2026 12:14:20 +0100
Message-ID: <20260821111550.276011-9-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260821111550.276011-1-mark.caveayland@nutanix.com>
References: <20260821111550.276011-1-mark.caveayland@nutanix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA9PR11CA0027.namprd11.prod.outlook.com
 (2603:10b6:806:6e::32) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|CY8PR02MB9524:EE_
X-MS-Office365-Filtering-Correlation-Id: f442cce7-cb00-4d9b-4b80-08deff75a060
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|366016|1800799024|23010399003|56012099006|18002099003|10067099003|22082099003|921020;
X-Microsoft-Antispam-Message-Info: XNe2HqnNRK4+KJ+bnJ2jWL/CvFJhdWsvxtj0LYfVHkiXNbC8cCCR3lOx9RCfRzQwhV7cJiQAKfkFeIvoBCKuYzywUtqBKrOY+QyoskuUHaUv4fYE7BD/ssI77gfU/cJFxHmSuzrnTh5ppsNVgr6NiJg6IFhFK1tBx68t7rfB7GVo0bYiBJWoCCtWmoQLTNVprz3OBdg22JvPKHtnLCH/JmYFSRFHD3YCtvogO3QF3bC99sCDthSHlf7JEmu+vJ/USIMvBP1E6gG/9uCTC2AEg2UWt5bm+as99iX4IqWD0KD15CrGXqPPTrheo0t+pYTAwbx5bU7Jf52EiQhMQf4xo7UfEPsSVItkBgeVfHeceKZt+RM/9p+lh3vlQDNx4PXvKHY6NtsSITmT45G08CZyI2o5rLpNcy1geVS08bkPN1+4G8hq+cPM0ANRBT4h9G6QyBrUw0xO6GTosGfGJDV1Q7HYkhWugTrmO8kNNt/QLKa9I2pXRtEl6nctUPHLNGGFJEg+qxkeQfYMKh+fNHaqLSg49q0weJKuJdhfUjEsbNKjp42lL26dvZ5VPV3bPGqzEhIODQoFiKbe6PAcXYV+PMFLrvS9hEoPa3cfUGEztVI/Rel+0ECmd3qRXKZUBuUdsoV2zevupI0H3hgxHZZt1QiyNtJaTUwi9t6jxxVeWlByZA+eZ2MfDPH0UJ9Mr3shqWltTk8+0vl92j4bdcbd5g==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(1800799024)(23010399003)(56012099006)(18002099003)(10067099003)(22082099003)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S0VSRG1XU3ZqbGkvOFZGSEhWcVpBM1pxaU5SREZmZXMyT1UwanU1S0V5a1Rq?=
 =?utf-8?B?U2I2N2VHaWovTWVMSHE0Y012aXFGbDlVSFlqeWlyb2pZaDVTcHFxK2hhR0Fu?=
 =?utf-8?B?bFM0YlJ4b0gvdmNJNjQyZHB0U2hwQkx4NlpxNWtZR1J4cFZVeFdqUld1cmRi?=
 =?utf-8?B?OXI3dnRkbDNvZlFRdlZMemY3aTY1TUR4WUZoSG02STZWNzlxekVScmZUcFlN?=
 =?utf-8?B?eWU5bEY3VThEOElqcTk0WXR2NWlyM2dDbkRaN1MrVFZncmlaUkdCOFFvWlFj?=
 =?utf-8?B?YlMwYW9VNVhHN1BUb3c4QWNhVXVGWTBKVVpBMHFGVkFja2h4WnFiYVZKM3Ru?=
 =?utf-8?B?L3ZUQkZ2UzFmdkkzK3Y2NmhZMm4vWXUwNCtIZmdCWVFWaXdSYlNSTkpma0hZ?=
 =?utf-8?B?MG8wSzJCV2RtUUNiK3dYNlA0ckxTZUs4WmxTMHI4R3pzc2VCSTlrVWltZEJm?=
 =?utf-8?B?Nk00RlB6MjhDNWovSnpaSHNKaWdhSlJyeW12cEZvR0t3OElvbHlmcUdaaFVR?=
 =?utf-8?B?UDlSZ1BNSUxkV1V2cFJYajA4STdjSkRwcXBwRUh3bDZtSlhUaEFUUCtuNUVX?=
 =?utf-8?B?Tk9GWUpvQzA5V3FvQjY4RzMraXpJQ1hnNEkrM3NTZjhhcVVYVFFWbnJFUlhK?=
 =?utf-8?B?ZGhRT0FlMGtObDgrUjM5eVhzSHBuNVBLcHp3a1FJZkZtL2wwRzU5Nk43Njdp?=
 =?utf-8?B?eVNQN1BERHRZMWZZM0RzZkUxb3hzOW9zY2VpMEN5NGlFTFhYakM2K284NVZy?=
 =?utf-8?B?MXRQaVVuVWNLTEhwODh2NXdEMHhPZ1RFaElyS1dIQlVCNzdMSWFIYmxheTYx?=
 =?utf-8?B?Yk5CMUUxV2c5NER2d1NNQ3hoa3NDL0kwbStGRU5YMHZHaWlBOVNBQVpwMGVj?=
 =?utf-8?B?TzZ6MHdwemFTekFFWmo2SXNkNnBoWkRTYVVpOUttSzhhM1d2eVJLbG43czJ0?=
 =?utf-8?B?WkZPQldzSU1mbWY4TkREUUZMRWpPeVd0dWQzZ3QwaG1JVldlRElzU3NlSU9l?=
 =?utf-8?B?NFZkVWtqZHVjcWMyKy9mbTZvWXlXcGordDlpNHRSdGtFTkJ2UmFzTU93K3c5?=
 =?utf-8?B?OXBDUi9IQWF0OXNmVDhGUG40bmFsNjBiY2VlQWFJbUt4bzlydnJKR0huRnJy?=
 =?utf-8?B?Mkh5Z1EwUGxCa2FtK2tYQzNDVzRST2c2V1F3THRyZGFweGE5OUd0UTR3SmIx?=
 =?utf-8?B?NUl3aUZWNjg2RXREQ2tQekZQQW1ZVjBTeFp2cWprRWU2ZDdRMEl0SmpPNFVa?=
 =?utf-8?B?YnBPcExsditBSUo3bVJEU1gyNEpkQzFGejB4bnlVNkJUV3Z2dVRWNkxvdFBy?=
 =?utf-8?B?TzRlZTNIb3kzM1FPU0N2azJvbUhpdFRpQis4Mzd5VmhXMzlIeUJLRjZUSHV0?=
 =?utf-8?B?NjhFeWpwajZ0Z3o2aWc3Sm1rU3MzMnRab1hHQndqMzdHWjBVcmhYOTdpbC9i?=
 =?utf-8?B?UzIvZXlVL2QrMDJsam9zdXdIaVlMMU82RDQ5dWpGZHJrZUt0M21TN0NCcUhE?=
 =?utf-8?B?ZEVYaElWYm4yRE5QLzJpQjkyaElMYkwvd3pCKzVuZ1lXcE92UHpiMDBDZ1JU?=
 =?utf-8?B?MHM0SzcrQSs3TmFmdUx0SkhxTityQS9CRGExY2ppRktpTDVDZUJWZXMwUXlo?=
 =?utf-8?B?TmJObzBVdUQwVEtodGYxd2RQejhtbDMxQ1pzckJpY3M4ZzQ0ajQzZWFTYVZp?=
 =?utf-8?B?OXI3Nmh6S1poRm5tMlFuSDlzQU1tdWpCMFI2VXYySEUvMlkvVmloNGJ6YUhH?=
 =?utf-8?B?cWo0NWh6L0RYZWJKbTdueG54QmxXaVJmclZlVm5GY1o2Yy9IaCs1TVNWR1ox?=
 =?utf-8?B?L05NQ2ZDZythZW1rTlE0cURTOWdyNmFxaDZ1U2Q2cnIzRWRVVldlV1FkQ2RE?=
 =?utf-8?B?TnJYaGRFeVlQWERjRXRKNmNHTktUN3FVMm1RNnJ0aG0vMHJkOEU2SjZIcXhZ?=
 =?utf-8?B?OGhaSkphZXpoTzZENmpFdzY5YnFWNDZuV05xck1aZ29wdVhzc2t0SzVLZW9L?=
 =?utf-8?B?aElVaFRQWVpEVlVNWEVDUitHNnJuNU1HN0pvdG41SXUzREE1ZnFsS2tsNFB4?=
 =?utf-8?B?aHhsTnZQUmkydVZnaDFoQjA3cXcrY2w4akF2eTg0UUZkMnV2RkhDVUhpbWxl?=
 =?utf-8?B?NmpacTB6YThFTlI0Ym45ZFNxWW96V2gvdzFzSVcxUURXN1lxUXZmaXJEQloz?=
 =?utf-8?B?dzJsTmlDb09sV0lLTHloYm9hbmdscUFDU2pMelkwTWdMV3lpUzRsWFFKbFB6?=
 =?utf-8?B?NG5zN3BkOWtNVUtNREJwb2NsZ0ZNQzNSSzE4TFZscWs2eGhydFNKT3NzZW4w?=
 =?utf-8?B?cEt0aTloV0ZsWjNzMkkyY2o3YjRmVU9rZ1h4aEoyc3Q5Sk5ta3BjcVZKWVE3?=
 =?utf-8?Q?QH9ZpA5PRF6vvnp8=3D?=
X-Exchange-RoutingPolicyChecked: CCrkDnzHOBcGd6JsHs6mSZgFInzgvoA/joLCWojAHsQMNdMqa7mN0TwyWP7oNRze/c6Tc/cjJRePv7Mq2VD7cJuB1arkMcK0TCVBDOiE8ZqIZ9FWYim0XPw1z4lGX3BHuZG80f8leWyeLYt9V5pfeGtFhMY9S9/gmUkMaz2aZ6mR/BTHl4yff3DAA8JFc8UBtKcAppwcowdpMJI2PBqWYtCDojwUszVZDGvEq3AiwiSo+PjtQ5NxHzybDJUaWYO2h+RyJvoVjt3OfG946NxpNlk3KTAYUujsZbW5r9VCxQ90X9XHfCbc/my4TsFJ4J+Eehjf3lhyQfGBs5ttnRG8gQ==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f442cce7-cb00-4d9b-4b80-08deff75a060
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 11:16:20.1761 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RJ45GEP0GDhXNAdDwInLH82fVJUhI6R7GpaX7ANIHVgpj3aXrobUtt6kD7JHOu8tqjjoaMv1BHBF3BA3YvE/9AN0DgqDTW0B/u/xMLaBMrY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR02MB9524
X-Proofpoint-GUID: EH3a-2YsSFY-1rTWg4XTMjRXVOjnR8Ai
X-Authority-Analysis: v=2.4 cv=J/qaKgnS c=1 sm=1 tr=0 ts=6a883388 cx=c_pps
 a=81r77geWhBIZzI7tvg4+jA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=0LlEyIVc8U2lsR7dKhuH:22
 a=64Cc0HZtAAAA:8 a=20KFwNOVAAAA:8 a=4QfE8SPBBHYfMhEiUa4A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: EH3a-2YsSFY-1rTWg4XTMjRXVOjnR8Ai
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIxMDA4NCBTYWx0ZWRfX1pvKOnqpuT5W
 tkdEcTf2CkckaMXIgDz2w8xO74MDIozdmAG7VUfCDDjajThJDoeQqU0A4XFfMIUQKNJaswwLPME
 a/WC7n7hExZyV5DjT3KuKV5uCj8zZFojV6yISmq2pGJ+i/a6EewhFgR3ox7bZ10nDAqedIQAurF
 OzWBGak3TeIH+EojUsnTOifGduxsYR02f1+Eo3GFItLSvugBJwB1VCWSxfRPIGa28dDRJIPdE7o
 tSYrQPiG7E8w0l9PAMcg1zli2hgJQp1ZMWaokX8GAGjCLMIWNZx7nRylpAgqtLFFRCafMBNGmX+
 Coewoh1nZrv3kT7mjPBGLxAqwSZEO8TkNpFPI6nTkjyJpSYSBn/A/NrOF+JIpDuYLbRC0add2kN
 W8KVO6Nz+mtyj40Zxp8NC/84Sw7LUN5M4Cxl6N/y9Kdv3HU7MniYc94SjVd7m6vxLnDeSGLoCxi
 ZsTfOfKizfTUFnfSuJA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIxMDA4NCBTYWx0ZWRfX3ipXM1Nxm4sW
 9HOm5nfggGPXdUq4ZXJdbe/tdG7f0BMJyExC7rF0ooDmzYIJ34qjyA6Q2iqqTwndey7ziyGkOlI
 GrzoCnD6fzXQN1hdE/RgssdmGnYH9/o=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-21_03,2026-08-21_01,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.341,
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

This adds a class property that references a uint32_t within the object instance
and is intended to be a replacement for object_property_add_uint32_ptr().

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 include/qom/object.h | 18 ++++++++++++++++++
 qom/object.c         | 21 +++++++++++++++++++++
 2 files changed, 39 insertions(+)

diff --git a/include/qom/object.h b/include/qom/object.h
index 67ccd2b08f..8dead29284 100644
--- a/include/qom/object.h
+++ b/include/qom/object.h
@@ -2129,6 +2129,24 @@ ObjectProperty *object_property_add_uint32_ptr(Object *obj, const char *name,
                                     const uint32_t *v,
                                     ObjectPropertyFlags flags);
 
+/**
+ * object_class_property_add_uint32_ptr:
+ * @klass: the object class to add a property to
+ * @name: the name of the property
+ * @offset: the offset from the object instance where the uint32 value is
+ *   stored
+ * @flags: bitwise-or'd ObjectPropertyFlags
+ *
+ * Add an integer property in memory.  This function will add a
+ * property of type 'uint32'.
+ *
+ * Returns: The newly added property on success, or %NULL on failure.
+ */
+ObjectProperty *object_class_property_add_uint32_ptr(ObjectClass *klass,
+                                    const char *name,
+                                    ptrdiff_t offset,
+                                    ObjectPropertyFlags flags);
+
 /**
  * object_class_static_property_add_uint32_ptr:
  * @klass: the object class to add a static property to
diff --git a/qom/object.c b/qom/object.c
index 271c2916b7..f91764aaa7 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -2742,6 +2742,7 @@ static void *object_class_prop_ptr(Object *obj, ptrdiff_t offset)
     OBJECT_CLASS_PROPERTY_SCALAR_SETTER(type)
 
 DEFINE_OBJECT_CLASS_PROPERTY_SCALAR_METHODS(uint8)
+DEFINE_OBJECT_CLASS_PROPERTY_SCALAR_METHODS(uint32)
 DEFINE_OBJECT_CLASS_PROPERTY_SCALAR_METHODS(uint64)
 
 #undef OBJECT_CLASS_PROPERTY_SCALAR_GETTER
@@ -2871,6 +2872,26 @@ object_property_add_uint32_ptr(Object *obj, const char *name,
                                getter, setter, NULL, (void *)v);
 }
 
+ObjectProperty *
+object_class_property_add_uint32_ptr(ObjectClass *klass, const char *name,
+                                     ptrdiff_t offset,
+                                     ObjectPropertyFlags flags)
+{
+    ObjectPropertyAccessor *getter = NULL;
+    ObjectPropertyAccessor *setter = NULL;
+
+    if ((flags & OBJ_PROP_FLAG_READ) == OBJ_PROP_FLAG_READ) {
+        getter = property_class_get_uint32_ptr;
+    }
+
+    if ((flags & OBJ_PROP_FLAG_WRITE) == OBJ_PROP_FLAG_WRITE) {
+        setter = property_class_set_uint32_ptr;
+    }
+
+    return object_class_property_add(klass, name, "uint32",
+                                     getter, setter, NULL, (void *)offset);
+}
+
 ObjectProperty *
 object_class_static_property_add_uint32_ptr(ObjectClass *klass,
                                             const char *name,
-- 
2.43.0


