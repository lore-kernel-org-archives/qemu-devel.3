Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46F72C982FA
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2026 10:53:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x8y79-0004EE-OT; Tue, 22 Sep 2026 06:52:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1x8y78-0004Dx-7d
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 06:52:42 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1x8y76-0004VT-Ij
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 06:52:42 -0400
Received: from pps.filterd (m0127839.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68M03mYk2448359
 for <qemu-devel@nongnu.org>; Tue, 22 Sep 2026 03:52:39 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=sgqo6gwyPLCyef4R/qGy6M9EPOIe0an64YGsZqfFv
 LI=; b=rXd+YkAKWaHm4ilVrsCdcxbv9J5lv6ZulfdeegGoJ3QUUYanf1OFBORPl
 Ihroy811ktby3jmBt8QB/p1DWpm1QT++bFRa8cTCb0KgbE35gfUlOBWCM2oAdres
 Mot57dlUjjjR+0XHIfj+bM+r6LfFadUCSERNBqJz36IMK8WtJ4X/S1w29NcVjquO
 fDkRZiqqEOFvDhlYdmYF0SXT3qXaG83zUSYKdYHrZjoyrqI1WhlUAGvlZl20LU0e
 c+YWLy6BJYxW1ImXaTjb4bmhSklGxzPUx20BdJhpUDShnnod/i/dDM9k5/WMwXTM
 S5rbYS16e05fQBlTt2FvTbX25mJ9w==
Received: from bn8pr05cu002.outbound.protection.outlook.com
 (mail-eastus2azon11021113.outbound.protection.outlook.com [52.101.57.113])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4gu8cwj5t5-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 22 Sep 2026 03:52:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eI/xryZQp0cPzMTG3VsLAyj90tETCicLQtQtr/w1OskLW5RiBajpF7JVlXFXts6CXU0TSkbqfjGvDgt4WEQwhc984By9QNvMPJDjrXJ51+DRMTcsVfQSPZYZQ3gYLwPi6UkLanxPllgPQ6nIIA7FhA4BMvO6X9h5Fas2zBG7h5FzTZLhPpFhLq8Zv1Moj035yYhcobX9uAwOF+B0rt/0/VS7YKSlV0bbuWWCCdkzUWqqny30Jd3gDKoyxcPTmN8P89ekN+j80iCK9As33Uig4O3LoShDTLe6x/e5MxM9bRpv8iCsGPvVtgMtYfMW4YgRlKd5s8UX+etQHuALID8rqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sgqo6gwyPLCyef4R/qGy6M9EPOIe0an64YGsZqfFvLI=;
 b=MP0c3wxvFfTlfKK0CPPLSb4atpMuxyKYfp0P1B8VZHm/DwYhUbMLNmtZ0tEYf07VrEq6A3pluGYC/HWKHfEmEoiN0pY8owed/M7OwZUqY/5+HYdYrsIEwy7TkCUAJguhdoOaCDXvQQWNasYTq6x1stASzd795LJh4HWnARZbvnlfbFHRlb+rlx7J5dgrHGn0LCjkKpNuOVy4//0nhg+dH6vNF4Rxtow5Ep7raag6nbmPixdEe0R+G4cpQLk3Lz7ZsnljsazwBAkt0ST3ddEi0XtizW+ycHGefva56Y07jtTp/CtDimMZkbuM86ZsEVtKcHJ4cG+YMRelA6FVyX8/1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sgqo6gwyPLCyef4R/qGy6M9EPOIe0an64YGsZqfFvLI=;
 b=gjXraEGQADBr+Qa+kfi2kFkZsQl4VMkFre51ysZbI62qWii07swMrrqFIgmgMKqeKlFGTXTpd5tUB52IoAWzFqLWTLe0d1yXoAHC1z6F0LpRpFI6QTxcEK+mKBLQ04fFpRmyUQkQRcTFxe8WhKYWIk6PrvvzaMJg/9ixbIqJuqkH5ar/4X1VECill1j0Rxq2b48bUf3K6Yt0ftbmr1hKpmUrXiZCZWxRUF9rIfyLqTWsFMFruipHVFcZKyGYNZ6R7fDEsuzOkpUTCA5fh/MiTTmSPhA06YhFowrO+7LF+wVbCDg5JXJ6FqQ7rl6oHdvhNCNIzUxVhGPcmJxFwR40Hw==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by DSVPR02MB11939.namprd02.prod.outlook.com (2603:10b6:8:420::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.14; Tue, 22 Sep
 2026 10:52:37 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%4]) with mapi id 15.21.0451.014; Tue, 22 Sep 2026
 10:52:37 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: qemu-devel@nongnu.org
Subject: [PULL 03/10] qom/object.c: introduce object_alias_get_targetp()
 lookup function
Date: Tue, 22 Sep 2026 11:51:31 +0100
Message-ID: <20260922105223.1607725-4-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260922105223.1607725-1-mark.caveayland@nutanix.com>
References: <20260922105223.1607725-1-mark.caveayland@nutanix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0071.namprd03.prod.outlook.com
 (2603:10b6:a03:331::16) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|DSVPR02MB11939:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a1063e5-4f3c-496d-42f9-08df18979dc9
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|366016|1800799024|56012099006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: Nok1cFRdLbyaBrm6qajNfIXgnP6CUXGGsFmidqlFER0A3pOb3ZFlNvXP8f+uRjf8yMAtqQshrHdqSkW7nAZ6zg5jCi7RIfoCFNk1u562+xr7RC3ImEw6bzIMY0s31gDz/dUMYJE8gIu1YTK8WKZHMKc1w0w6ydCVqUjkTY+Rr2quYKdRZORcnBeqw9KQLQXj9TS6jU1fWxLcGgZ6qAH60p8lGkkn+gCH7Dr9xtY3aq/9rBsBgs943NTkp+9QbgkazfbQTdUH4OTeo6lL1pXjztDCNSyGWWoWou3pUCxKpeHg5hJXQ82XOgyJrKd2ORfxk2oQrUcvVVfl0/fV+op5thWAlXbll5SliQFVpxQkokWPBAudANNgwN50OQM3VyaR3FDU4xZt7NzDpu915fHigyhsF5zSqCsqQicWXc3aXsZ73kb2IUr7WCn8K9VNNNBAsqZoS5gbDJEkyYkt8G5EvO1B5Z2pc0B2gIqA4mzo1wftVuRKWRiYX2wjqqV8TGFNC2eQ9HiGg8OE6UmnKi0YoL5c53cFcqEelHIeOmO1wrQM2xYuFUCH0i02a/A1ZO4NgKDAqaSDub1LumdbIsdbr+Beh4YsAHJwkrKVmh5ZY+ZyAPriOfl3RDo8PMr+4c8K5tN2r1aUMTHQOQQSdVbnqw+h/UKhlt+rov9YYoKVrvo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(56012099006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZFoxVEU1MEtxVWlKaFNlOXladFpacTRQSDd1VGQ3Nlg4emVER3Q3VzkvUzlq?=
 =?utf-8?B?cDZTK3RvOEJ4K2tmeVBLZk5LZng0NWdJcHU4azBicXpFL2c2NlJCNU14cVpy?=
 =?utf-8?B?NmRXSmUyaEdIcmFuTllsR001MWtEaWhCZjlKQUFrQTNseDAzRksxdHE4OEt5?=
 =?utf-8?B?empPczhyc1hsSCs3djdyb1llaUpJQ0c3am9NV2pKd2s1UnpTRmxQM2VURW1P?=
 =?utf-8?B?NForcHdqdzBGTHo4S1JYVTFmTjJiaXlOVUlJLzdLdlZxVFVmWDRHaFhuU0hI?=
 =?utf-8?B?bkVVejhnaWpXOXIyRzMvYVJMSVJYM1UwUG5EbEJVY2lKelpsWU1WL2JKbVNC?=
 =?utf-8?B?TjBUSkhEYzFMMFNPaEo5WlhSRGdsOU9MR3o2WFNhc0ZtdnJkaTlDaHFTbUhN?=
 =?utf-8?B?RGt2VkFWZzBTeDdUOWNSeDdrLzA5RG84K0o5VkgxczhWR1ViL2I4cGtsek5w?=
 =?utf-8?B?TmVnK2w2SCtjZzlBKzNXSzd2T0xCVWhtUW1jc0U2OFozdUFXVjdCNEdoc29Z?=
 =?utf-8?B?RVhZV3Q2WWNUTGJsLzFBdHZ3UHFPSVByODhvcURReFZEbXJ2Z0RTZDlOTjI1?=
 =?utf-8?B?M3FXZkY5Unc3WWdleDhWb3BwS2ZOK0J1QU9jQ0s1VDZZb2I5STRObUNNbm5X?=
 =?utf-8?B?TWhoU3BlWnQ4Mk50ajc5aFpSVExFVDVkY1gydU5JSjhwdGNTWHFZZEZyM1Vy?=
 =?utf-8?B?dWZUaFkvMmtYZkpacnBPOVA4V1FHSWphSzgwL3BucUV5MVR4dGtkNHAxVEhE?=
 =?utf-8?B?QXViQ3JBNlA1SHp5KzF3Z0ZiUTFEYm1mdFFLU0pscXFUdTNLaHlTdnlKaHVw?=
 =?utf-8?B?VnlKU0ZMUThEVXp4d051RURpSnZIMHB3MTlLVEoxMk5XelAyd1Rtc1pLVXB6?=
 =?utf-8?B?dmUxTUFENXBRUUYzcjl5bjhBUmN1b1F4cXhyS3ZaSkVqQmRwdEpGS1NnM3ZL?=
 =?utf-8?B?WkE0MDE0bk9xbzJMeXVMMU5BQzJPQTlMZThFRnYwYkhXRjJGTURqbWU0Mmsx?=
 =?utf-8?B?YmlLUzYvajduMVhsRzdLMXZiRUROVTIrQlAzQjdIWE1XWjdtYmxSbmJHK3R0?=
 =?utf-8?B?Ymh5NkRzckpuSVpxM1ZTWHJNb0p0R29uOWNCREFSZFpDeXg2dldUbUhyS29P?=
 =?utf-8?B?UXEwalNtbEhwTmVGc2VYdm9pNmFYckJLY0U0bTdzTWI4a0pHbjZlZ0hpZzRr?=
 =?utf-8?B?SGxiMXlwR2pGaXhScWphT2NPaGVsUjZiUmZnRkRtYU9ONHArK1NKaFE1T1Y2?=
 =?utf-8?B?ZE9FemJYYlpuK0lTcHFQZzJqSlVwMDVDSm9Pa0Nvd25jWCt2Vzd5cVlqV0lw?=
 =?utf-8?B?b1Z0UWRwcVFaMklTbU1MblNyN3lVcmNCV3huaHdnVU11dHdsTjN6L3pVa0hi?=
 =?utf-8?B?ZXoxMThCcGVHQ0ZHeEt5Tm1FV0xIMDhidXhlUGFNY0ZLYUgyRnExaExJdHN0?=
 =?utf-8?B?ek9hL0VSb0VzUk5BQ2pEUlZ0WGlmUkV0cXlzZm5KYWxqOW9GcUllVUgwR2Vm?=
 =?utf-8?B?TDJjUkFFZmJKbmRQQzRqcE9BUE9MUjFMS0VLeFZoQ3JhcFVuZ2ZpZ0tTeENT?=
 =?utf-8?B?Qy84em1Zc0xmQUlFVnBmYVQ0VlNQeUhwT3ArZ0d6RDRrTmpUSmsycUlyeUc5?=
 =?utf-8?B?aFpCT2tudmtsU2VYbFBRZWpyNnFTaWQvUDVKTmV3YitMZ0hpOCtmNUM4VFZV?=
 =?utf-8?B?cVBXZWVoQ1M5UEh2dkJVMGZtRERCRFZmWkptbDVoUFRaNGZCbk44U2pJdDFR?=
 =?utf-8?B?ZjcvTnk3RVBSRitKVWtycU80MTB3a2MxS3planRlalRzYUJVa3I1Tis2eXU4?=
 =?utf-8?B?ay9KL2Z4QkpFTHBoQXB4dFEzM2FKb2NTVkFhUUgrYUZCQ1YxY2xMZWlFcEdN?=
 =?utf-8?B?TzVXcjdQeHN2ZXRzU1BwVHNWT2crVG5KdCsrRW0zOEpDaVAvNUd6ck1Mc1VF?=
 =?utf-8?B?Y1d1QzJOd21KVjZZb1JHN2VOZmlrOTE2YXIrQ1A1ckVQN2NpS25Fc1F1aVVJ?=
 =?utf-8?B?Z0dsWTA3ZlZZdkl1TVQyRUp6UkVyRHlaSFNJclZpRTVJVnB6Zm05REVxcW1U?=
 =?utf-8?B?azJQRTgrRWVSS2hrNjJvODBLanFBbmNVbTNTRnRvbXExTVpIejB2blVzZUhN?=
 =?utf-8?B?VHZVbjROQ2JzN1k0QnppUWU0bGFoSWZ3SjNqcmlHL05OUG5zMWxiQnB3Q1VL?=
 =?utf-8?B?YzdmTHFHQmx6NzhKL1ZVZFU4MGx3Z3JBUWJMeTgveklOVDl0cmFuSCt4SWZW?=
 =?utf-8?B?a1hKMFBqaW90dlpNdC9sMEZmVjE1SUdJcmFLbStUcDNXakUwLzVsbGJBMnRD?=
 =?utf-8?B?dUFNU09nT0ZjSHZPYUhSbUc2dVM5VjBkQTlkckw1UG8zVDBVQ0U2c3RpL3hn?=
 =?utf-8?Q?4KFfTr6ow634RjyE=3D?=
X-Exchange-RoutingPolicyChecked: erdV3RSydT5dGjQb858HzoEt2rcdvXZpOupI5ul14vsykdbmP2WIvnahPj3ckZulCIAIJPeghbuHYXcLyGSZL3d4jLaGS7qt45aJPyMjddtjzfJWovYGQu3/XTs1o5PR1/LYVl+LNDYGrKRMQ/6lPn4wmoDW1xvMzSLnMZoYCHht16Sg8IfoTnN+kugU8YqmbpA0MdfUj/NysfQ7I64tnCh0ffDxeefnDIi+ZSmZ0HnZDuB1YZ5eoVhrW+o+/sz1FzGdVdbS/KIigUK1zfvLgeH+srL8ywKMLf7Yl4loAJxThGkI0bXM4lxOlSDFheXsoqkyOeigwROsjIuEIsYoVw==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a1063e5-4f3c-496d-42f9-08df18979dc9
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2026 10:52:37.7190 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qN+nM+jgXMzLI8mEaI6fksE/90Z0fQS6rn9nQAol8cZbUXOhs80ISz00y2tatY6BHF3u6v4xr2TnJaA3JnOI7vBemt2BFafl7+dvyWtBp+s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSVPR02MB11939
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIyMDE1NyBTYWx0ZWRfX1G7cFvhtZ3+Z
 SiCtnKhXoUIqSPUBJm7CzammCEITSlQ7AVSm5lyDgK5PxDe/ocTuTWHOZZvqVsG7P+a7UK7s+yy
 m/qt6yesUP+5pigbe7szWp1CyoUfOV6n0EsVx6qbskwwvp/It2ie0tOlSF0iqK5AnWZCBcAcvT9
 vU4as4tkfrmn17vpE1le5DHXXK6pohzIVgXQMn62RciD6wsFV08EPQpVryjNNk+PuaKTit9S3w5
 FgGOdDPiLNizO0McJgZhWlD7DRL5ydHSWoKbIkGor9luqOkGgDysxPfqWCE6tl99iFrsUjKI2/N
 p02ajMEa6XY01wTqbzOCvIkdBdDNkSQnS7iN9VcCmikWuOPTO/lKBtUWjc1o0ZtHBoscyOu6pJ+
 iuO8ynzOyX33m2ayBVOfptxMl/FwKLuI+qpXZi5Hxn/fTxXf+ciIL8wH5WXjC/pUWBKY/JEuQbW
 YWu72o1eG+Y9kT+zw+w==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIyMDE1NyBTYWx0ZWRfX5dW4D3zvqUYw
 s0h5VuJnQQ/depFkDutbf1X5/Azux9C2M/zQPES7caJ+lgUkTbTnxfH0mq6u18v/JMPVvu+uw/e
 0GGQq1mr3rzMEWwHVB39c3W+LrKXWLU=
X-Proofpoint-GUID: 7csGVCrjm9oa68_2vi2sfd3YPUveftgy
X-Authority-Analysis: v=2.4 cv=c9I+0h9l c=1 sm=1 tr=0 ts=6ab25df7 cx=c_pps
 a=I4gKhz1MVFc1Ib3WWZpdnQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=y4UcunY2MAxhM4LwGdWI:22
 a=64Cc0HZtAAAA:8 a=20KFwNOVAAAA:8 a=bLxKGtcusTcs4WrYLd4A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 7csGVCrjm9oa68_2vi2sfd3YPUveftgy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_07,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

This will be used later to add support for alias class properties.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Message-ID: <20260921113559.1299740-3-mark.caveayland@nutanix.com>
---
 qom/object.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/qom/object.c b/qom/object.c
index 914d1228ca..eb5f74fc74 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -3056,13 +3056,20 @@ typedef struct {
     char *target_name;
 } AliasProperty;
 
+static Object **
+object_alias_get_targetp(Object *obj, AliasProperty *lprop)
+{
+    return &lprop->target_obj;
+}
+
 static void property_get_alias(Object *obj, Visitor *v, const char *name,
                                void *opaque, Error **errp)
 {
     AliasProperty *prop = opaque;
+    Object **target_obj = object_alias_get_targetp(obj, prop);
     Visitor *alias_v = visitor_forward_field(v, prop->target_name, name);
 
-    object_property_get(prop->target_obj, prop->target_name, alias_v, errp);
+    object_property_get(*target_obj, prop->target_name, alias_v, errp);
     visit_free(alias_v);
 }
 
@@ -3070,9 +3077,10 @@ static void property_set_alias(Object *obj, Visitor *v, const char *name,
                                void *opaque, Error **errp)
 {
     AliasProperty *prop = opaque;
+    Object **target_obj = object_alias_get_targetp(obj, prop);
     Visitor *alias_v = visitor_forward_field(v, prop->target_name, name);
 
-    object_property_set(prop->target_obj, prop->target_name, alias_v, errp);
+    object_property_set(*target_obj, prop->target_name, alias_v, errp);
     visit_free(alias_v);
 }
 
@@ -3080,8 +3088,9 @@ static Object *property_resolve_alias(Object *obj, void *opaque,
                                       const char *part)
 {
     AliasProperty *prop = opaque;
+    Object **target_obj = object_alias_get_targetp(obj, prop);
 
-    return object_resolve_path_component(prop->target_obj, prop->target_name);
+    return object_resolve_path_component(*target_obj, prop->target_name);
 }
 
 static void property_release_alias(Object *obj, const char *name, void *opaque)
-- 
2.43.0


