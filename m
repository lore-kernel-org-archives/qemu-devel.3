Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EC1FC53219
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2026 09:07:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woHIG-0003Z2-7b; Mon, 27 Jul 2026 05:06:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <flosch@nutanix.com>)
 id 1woHHc-0003Vc-AG
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 05:06:03 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <flosch@nutanix.com>)
 id 1woHHX-0008Pg-1X
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 05:05:57 -0400
Received: from pps.filterd (m0127844.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66R7RZYt244002; Mon, 27 Jul 2026 02:05:49 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=6nKnpHJhkzwlLbUtH+omzupiMGh83Qjx0I4QICyef
 z0=; b=hrpaHbjWKSFYXSrpZFmHdsDYJ4BtV0S8PXcldjgqeQTbynD1vaPLyzLDu
 ps53JB/pTmqgZZOie/149qVTwJ+1fWFqOvWzWP6+MJ9U8se9Jz8TgiY0TDFBrPpU
 iNo8eJYRskdYcTzj8TocZjOZIOBjgul3+bwgHE2aO7ZPUKjePhk5wRgSc8HXsE5h
 KMGfdExQAQnJqRZe8eO3YRSxE6aXZpZy4B6T4wKHkXqC02CE60vtR+0mHFWJFRTD
 lzZNRf5R9yRS+mR1++mCXpVU+wbGJwUuDj231V6lGO+IHmRnTfEXR7l+EohEfeu6
 DgqLOMf+O51R20QfFjebXmjof7vbA==
Received: from dm1pr04cu001.outbound.protection.outlook.com
 (mail-centralusazon11020095.outbound.protection.outlook.com [52.101.61.95])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4fmvp0js7e-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 27 Jul 2026 02:05:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F8uBFHu0n9Qbmp7twM85KYH27IYQL5G5DSOQXQ9nb6VIKVtvjhvmqGQIjSsF99HZQwFspA81Y9suNXfYwFMXSdg5w14hxxLZlDAE7Z2q1vCoONojFNse8D6QIIH7jjIROiBX3RuwpP7lLYaIp8HE2DsspYz+e7fXedklmVvWDQs/9Y/YsO+hnS4vIWI0+tsrUNczBag2jBBiWkI4c73wZng5irOo1fTq9vzDlsJPTw5bVxyXw+pFhBoIHvfys66OZSTiKJBR1fxAws8kdDu05nCEeM7Dl5sHEn8Pk6NFeg4GMUTRWUpGslHmBMb7aF/7xeY1T7reP/xAmi08BtZkGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6nKnpHJhkzwlLbUtH+omzupiMGh83Qjx0I4QICyefz0=;
 b=BgVG3g5RGOCdJoSSwDPMAIzi3wg5llHEHJLS+UUEj2NqpsZSvaQf39LmxqCWC6PQ7gyq2UsJ93ykw8/F+zQcx6KA7eEjueQ16oK2uOSGbxE+foeh5Qj0wD+b0an906ddL3swuEXDRnMfasELGV/duwr5cd5e7Vc09D1obkdj+fpBRRN97MEwlSHJAu3Ml4W2vcYIrj2H5v6xOB+3YBOBU16G1gqNRUKTsv0RNG66FfRSpNoKJklSUjEfhnqPZEqc4/D9Co+fIg16ZMiGtXTMsq0Uj/rPZLKz/TlbpPAL8Wsch5kVBB3g2/7+bfNZ8TmLSDWlh0ELNAx/mWo+2JrDwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6nKnpHJhkzwlLbUtH+omzupiMGh83Qjx0I4QICyefz0=;
 b=LINsArHlWnLxYDcVvONnuNdjRvuzJB6WnvGFEUsymzAz5jMJrBmXKenXxiW/7QHVUfr4vSKirU37Gr6Q/C2eZrSIfgSzc2xa51fK3OBo8T399gwVqhc6b5rACPlpJXiOMkh9l6gwTbKmt96765P+GiCKBnfZ+wd/Htgi+nBXcwyGGYdOaOtWAAfkFcWm+CbII9kzHK0N2wAT8kgwX3E8qEy8etxNOqrpEWieG9nogCY35MPe0LONag+hBm1Vi7kY3Up7H69dnKY7c6ldkoVpdtcDc8AzbSjANcQTz0rijTmyKsNg5zTJXTSK15AC1motFbZu3LlvaAyZips022EoJg==
Received: from CH2PR02MB6197.namprd02.prod.outlook.com (2603:10b6:610:4::25)
 by CH8PR02MB10840.namprd02.prod.outlook.com (2603:10b6:610:26b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Mon, 27 Jul
 2026 09:05:46 +0000
Received: from CH2PR02MB6197.namprd02.prod.outlook.com
 ([fe80::90e9:29cb:631d:9ab]) by CH2PR02MB6197.namprd02.prod.outlook.com
 ([fe80::90e9:29cb:631d:9ab%4]) with mapi id 15.21.0245.012; Mon, 27 Jul 2026
 09:05:46 +0000
Message-ID: <939dd72d-80cd-4cd7-b9d2-e245afbaefeb@nutanix.com>
Date: Mon, 27 Jul 2026 10:05:40 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Add option to disable building tests
Content-Language: en-GB
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20260724135413.1716872-1-flosch@nutanix.com>
 <708798a8-3d43-48d9-a4f6-210eb88a88cb@oss.qualcomm.com>
 <92358092-080b-4b1d-82e5-733d2531ff38@oss.qualcomm.com>
 <6c79c79f-1bff-4914-9e42-dc077885f718@nutanix.com>
 <amcbxTQXOwIJPPpo@redhat.com>
From: Florian Schmidt <flosch@nutanix.com>
In-Reply-To: <amcbxTQXOwIJPPpo@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM8P189CA0026.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:218::31) To CH2PR02MB6197.namprd02.prod.outlook.com
 (2603:10b6:610:4::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR02MB6197:EE_|CH8PR02MB10840:EE_
X-MS-Office365-Filtering-Correlation-Id: 4dc510a6-dd89-4f2b-7235-08deebbe3e93
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|23010399003|1800799024|18002099003|22082099003|56012099006|4143699003|10067099003;
X-Microsoft-Antispam-Message-Info: fJwfqDqvfLKgTHFpXkCLDvYuDKIHy6RrogIyBrQGopcVnrL0Q0tZfYpqNT7XWuytHk5YXc3KEB2uPftj21ucSHQGocyn4SK1+VT0eKdzAwirCfLH/auctyp7ZH44/xBKH2I7jyFlEAcvKzloCKOYeuUYbvRvw4W7v3K0o13jhx8/PhB7w6EQE0bXalqVdB7faLjyPEvkBCoxWSxjImuAzg61PLfFw6OpuzpupWYHUaaT6jWJZvSnyCGbj0aPcfj9xHw2bJ2W8SIgQKNR7tkKFsdfdvkyTt8Ty777E6z9loaVdkjP2P4Blcjp/QGaLj4QdmK24n5YV2bQDibSV006ngilSU2cxYzH+etWXz8YjL7W6DGm+pAKRze/qs3GCS1IeCyx9IeDGD6O0x7HqMpwcrL37OAXc9LHZw6tPskX3wCznrXaR9VoGWLV+fcF31Ae3DZKRx0IYVmNQSpOSXPcb5pqC/nDg/fi37TjFUs9U/TctFKnYa9BAdFLpb4bUNKuaBVzW5syAZhOQbgs54QAXNps/CQZ3rkf5uQliQhUqfgf5hBAlJkRf13fH+fatLlWvHw++w45Cdtk+3cs1npuVhIl2mKMKR7sRawcvpjMG7tzsThnqcXWk1YhMr8Rpjy5hSH3FMOkgA3BuvOK/44S+kpYJav5a9ySJq8kM0BqENA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6197.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(18002099003)(22082099003)(56012099006)(4143699003)(10067099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SERWYlY5R210MFAzeDFOZFNIc253UkxzMjdjUlA1aVRveFpIUHl5U0l5d0xP?=
 =?utf-8?B?dFBMS2VCeFY2ZW9QM29uZTVtTGxCVjBnWm5DZGZSeDFMN21IVjRua2VtMi9D?=
 =?utf-8?B?OEc5Qlk4UXY5eDFYb2wycThQQXhlYXdHNnhXcTFJb2g5a3crKzVzbVFkUlFK?=
 =?utf-8?B?U2Y2QVNaMlhxNEVwVjFrdXI1Z0JlUFJxRVhIODFFMlZyZGJpeEpQTGlWeUl0?=
 =?utf-8?B?dFl5YXdMb3BhNnFYTVhVdUQ0SS9Fa1VWc1ZsVXlkSHJ2ZXNXanZ5a1hkMmxW?=
 =?utf-8?B?b2puWkxEZ2N6OUhtSDZZaC83Vkx6emJZeDJxK2xKN2hvWS9pMUFCNDNOOWQ3?=
 =?utf-8?B?YUl6TVVwMFdTY2d2UkRMVWZ5WEs1aDkxaS9xTnJQOWNGendGODRZa0k3bTl6?=
 =?utf-8?B?RTlZY29RUitnYWU4V0d5RDhaMHZOdUc2dXZibVZPNFREOGxBV1BVc2lRYVo0?=
 =?utf-8?B?SjdabUhqOTJYeEM0QkpiUUpQOG01WXhOUUFYWkhBTGZYd0htSFlPdUtWV2V1?=
 =?utf-8?B?SkdlaTB1T2EzVGpWdlRweWZGVGNiYmkva1RBTDVRdldTS1ZCM3l4ZVEzSW84?=
 =?utf-8?B?aklaZUE4M0s3QXdwNzd2bUROR0xkVGluY2p1dEFOcjUxSTZCOFJWalNpOTdS?=
 =?utf-8?B?WGk5bkhVc0I4aXQvZGtpb2l1bDlXc28ycERKNU91eHNvTjRuNWovMGxtZnk1?=
 =?utf-8?B?UHE1eHdiRUlzMTc2YWh2L21YdjZXOHB0dmtpUkgrRHZmTlVtT056TC92Ny93?=
 =?utf-8?B?ZnZIVjQ2aE9OVEt1SUdQZlRTV0FzU3h3TlNvNkV0OVhJdzNTelRuTzN2TWhk?=
 =?utf-8?B?RjhPUjd0VFlZdlNCSHVpTG94VDZJWFN6WHFSSTlrQkNZSmppQ0VVUHVBUkQw?=
 =?utf-8?B?K3c4ekdMRm1SbjBNTitZS2RUYUdBc2Y2Z2ZVUVdlVHFKMjJlMncxNlF5ZElH?=
 =?utf-8?B?a3RxUXhCTDUxVkpUOW5tVFBkSm95c0crZmZOUUhDTHpBd28zejlxQXJZTEJp?=
 =?utf-8?B?QzFQa3IyWXBDdjZPMXZGZ1RMMU1CaS9CZ0ljVmc0dHFlT2JodFBMQVY4SG9K?=
 =?utf-8?B?NFp1dWh4KzZMZk1pRXhrV1RlMDZ0NVNMMTZ1TzYyWTM1aWRLWXp6MGxVLzVq?=
 =?utf-8?B?ckhBL2UzS2JpSlY5bVpjM0s4UGdiZVVZYzNPdEwwVW1NNWVDTlU3ZDdtSW9W?=
 =?utf-8?B?dXhmS1FsQU5QL0RyVWFlZW1tL1ArM1JoME0zZVlaTG9VRjYrU1RFaE1QUy9O?=
 =?utf-8?B?ekdEZ3Z1RVdrUU9MRElhNVh3clQ5ZTlBVkZBREtMTEMzbitteVhZUENac0lP?=
 =?utf-8?B?RHhUZ1B3TU9ZVVdKdE1mY2dyOHBwRFVjc3dPWG5mUVZSNDBKbTJDV25NbHJK?=
 =?utf-8?B?MEE4anRwQytFWGpRSlduQS9GSzF2UEFUZkxid3lKUzRueHZSSFJienJTaXBy?=
 =?utf-8?B?SHNWSjhwSTlreXJOL1ZZdGJPdWtJQmlEZHB1K1g1My9ORTRGd0FTbk5pMUJh?=
 =?utf-8?B?NUNGNFBYV0o1YnlzQlQ1UDJ4amdpek5pNEhVdmhmRmJQK1A5Q2NRZWR6VEp4?=
 =?utf-8?B?Q2VXOHpBRGJ0bWlPSXYwUXZGWFQ4cDFLbXVJbm5jaE5FTmJocyswbWE1UElG?=
 =?utf-8?B?a0t2ZC8yWVZFcDhOUUpBU1BCRFFJVTV1REZqR3FXWExjV3JjdTE2c3RDdjlM?=
 =?utf-8?B?eHVNam9pSW10UVR1U1loRGJnVzJNR0N6a3FMaHRKMHUvclBPeEFjMTVuaVhE?=
 =?utf-8?B?bWZjaENxMDAvMWx6ZU1TOTBjZVQzTytid0pLN1lXODlQS1d6K1lSbC9oNmxF?=
 =?utf-8?B?NHltTDFPN2NRekJ3MXpWYTZ5L25sL2RJV2RyVnZuM1AyeHB1L25xTllYc3NB?=
 =?utf-8?B?UFlTWFpLdmF3MmhERkluUzR2eEZhRFpteGdrT0JXUXFqR2pGSUpoeVdvdnFS?=
 =?utf-8?B?RlJFUW9sUHhvSWFNcWxpNDJwbWMxTnFvY3RzVmFTU2luNmRtdUNJSGJsNHhD?=
 =?utf-8?B?WjJBUzVoY3FKdUtUZlI0MUVOYWNtUXhCZkNEdlNlVmwxYnpMbWJDSllIdFhT?=
 =?utf-8?B?M081YllRek83WXRTWTU5WHQ5Y0dSUnRHcXFvZnhDbXl3OUJ4WkM5dGJyZTdq?=
 =?utf-8?B?MVhWUmxDMDhEQXhIWFh1dCtid3dQYXMzTWZvcUlCY0lpRUd5dDNTNGdRTUt3?=
 =?utf-8?B?bHVJTlgrY0VJUWlWbEFJSFFxMTFGMjduakJ3MHhPbi9lV3VpazZ2WTNhRkFI?=
 =?utf-8?B?THlqY0gyNDhwRHZLNGFBd0RXZWQyaGF1QnJOOGZwZ0tSZnRYK3dYaEt1S2gw?=
 =?utf-8?B?SHpPV3NtdjF4Rzl5SUM2Q3Z4bDV4WUxBMmdBVDFRTjUrM1JtSXFQTlRnQzVk?=
 =?utf-8?Q?OIYfxY1rqES1M/q0=3D?=
X-Exchange-RoutingPolicyChecked: I4wh8Vhkh0kSYcQmnF6yVOs1zuf2fxEVd0Ik2G9/B16Zmwm3N0//VSxnWlKpxQGBzO1C+D7wzS7TmLZUx4kfvgvamBA0MBYTHyChZBq9BUgF5eajdfdibxXRa6jr/L/eYHdydaNyvHs6TAGiv5Fl5tGWmcRdj2JQ0sTZITGzHBJT31PgiOFyH4jA1TA/TwS6/HKWYhsXs5MsmZON9B7vAZ0VETUUFQUUTQeZyd7WbYvYHKQZJfOKSB0xCDhmUrOCKAHig3CMgrUc/ctw+d27UVHE6QQuRMbeq1lXXNkr+RWhVH1U6cbZxndPE49JNXoft4vzNLi60gQ6o6F7I6FPzg==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4dc510a6-dd89-4f2b-7235-08deebbe3e93
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6197.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2026 09:05:46.1499 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ukH2KIcUJD9BWtFGIE0EHLQEtsQn3UsA9zsUMSoBwTzfoLwN7nYnSLwJT87f3ovu9ZNuirZT7ajD6zWSHnS/+8uVtsd2sxod7IJFE1vrjxs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH8PR02MB10840
X-Authority-Analysis: v=2.4 cv=btl8wkai c=1 sm=1 tr=0 ts=6a671f6c cx=c_pps
 a=5EyciH11kPx6gLClVK4sKg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=0LlEyIVc8U2lsR7dKhuH:22
 a=OBAOrx_FVqGdsqcXfSMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: s69jfO5grT6YAGMpoNucOD9_j5lpJrD_
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI3MDA4OSBTYWx0ZWRfX7qlhvogIxA2I
 flHHW2HbL3o988N2oz9a6DwFSjPyZsff5Feq9alrDrKkE+LWx5UDhdKJsfmJgnbsgK+8MKGdic7
 xgb8ysXj8DZUupIxfr/SrWWT/indzXw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI3MDA4OSBTYWx0ZWRfXy2s9RKvsFFyB
 9GAf1aZShua18eUdOE+QuABN484+3kkM9JkM/PVDbUGcBB2V4kickgoOeZy7LYewrcDfo2V9DaF
 KICMtg4uJprquqAfKR4r9DYVfydWsiw2DbwAWLrFhpT1y0c5RjwYxga1F9ptr3nbH5jwC3ifbgX
 SJZYk6wuWL3zLBa5ke+eskJhRVqUwnTlU1X7Y7T0Jc7AWRpuHOgab9OMxnD2A4PDZPNmofUAESi
 y7ZIi+hvQjO8Ec3rY9OhqftSvkq3PYsEopR2LtwqzTYcZTbtcfR7HeaCFtXMWgB79Xt2Bedr2hZ
 rfnQa1bf0a4dXjtmLWBicJ+7FFqHgecbniNcX6ikl/jTMgZPMb/xbfvGMxDDOU9kB24X+WlXFNk
 j0iZhIqAMWpNVj1spxfoe7Jz3ZWTElSTxx55ZmEcBJQzK/2soTZCF0N2Jni8XFOcHCb891TOh2u
 ErE2KnDEqn8/lN81P3Q==
X-Proofpoint-ORIG-GUID: s69jfO5grT6YAGMpoNucOD9_j5lpJrD_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-27_02,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12; envelope-from=flosch@nutanix.com;
 helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.58,
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



On 2026-07-27 09:50, Daniel P. Berrangé wrote:
> I would suggest that building a second time is wasted effort too. If
> the 2nd build is byte-for-byte identical to the 1st build, then it is
> pointless. If it is not byte-for-byte identical, then you'll be taking
> binaries that have not been tested.

You're absolutely right. They are bit-to-bit-identical, and it is wasted 
effort, too. That is something we'll look at internally.

However, it felt like a genuinely useful feature to split build and test 
phase more strongly, by having the ability to only build the product 
binaries if desired.

There are other options, of course. A new build target such as "make 
bin" or similar could only build the product binaries, and a following 
"make test" would then build + run the tests. This could be combined 
with Philippe's idea to run (and not only build) the tests by default, 
though I'm always wary of changing the behaviour of default targets. 
That's obviously a maintainers' decision.

Cheers,
Florian

