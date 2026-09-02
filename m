Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0D4FC624D6
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2026 14:33:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1m1E-00064b-7l; Wed, 02 Sep 2026 10:32:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1x1m1C-00064R-LB
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 10:32:50 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1x1m1A-0000bF-A8
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 10:32:50 -0400
Received: from pps.filterd (m0127837.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 682CXTsM1539021; Wed, 2 Sep 2026 07:32:43 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=KY2alyq0ezqOC8e//Gf0Kss0SR/XuyxHxs8TMVVM0
 aw=; b=MQJiWdneDr/XgkJwvI3tBi/2VgbqXvCAM0z3vdvasWYakgeTN7rEJPWSs
 7YaLKELlYUXlqKeyasRbyLqZIccswuKQx/PZh/g2jvpb4g2iI0pF/ATcIiDLyDm3
 ZXnTVCzuKYic6u4J324RJSLN+C26egxdq+ZYs9gE/cc8u0UsvZjV4RqczUc3+7jE
 1kf5RawgUYAqQz1PYOiC5jMLqXUILHBOKdJD5fG7ftaOtHq6NMKoS12IRYO0Tf40
 9hsCrRfwc2fxG6P2ow8LQRxNIiln/MS8ohG+E89ExnEGXg+xA0lL01nNxtukTngB
 irAxXjk65udFbSsmMN+yNVjUA+4mg==
Received: from bn8pr05cu002.outbound.protection.outlook.com
 (mail-eastus2azon11021091.outbound.protection.outlook.com [52.101.57.91])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4ge0sxb553-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 02 Sep 2026 07:32:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C7a21kZ3BstdLsfjR5I3PWjtvNqHWwxPKuboz8Hx89Eq4ydAAzXKe7mY8tx8A+cIuO7xfh5GWyjs/6BSl1JBNnlz8I6IPcdZK/F3Q1MKwdBgiSD9D4b6MkX/IjVcTbsb2QB/LI6svJhRZYZMmSjFFsRZpsQZ/baeCaKAgtkeV7iO0FboeO+ypYxwTaX/Z57NybM/SUXNMXpeS2+xY3DOMmgNIERfksjipn7n1SZF6yMX7g76HSaEz2R0Nz8xa3bjwqkF1OqzaaYwX2VcuFPYop57PX3e/jvReWWNwSdWubECseayWAEfNRSJ/euSlx+h0KihnAGm4Kj+FBnFfE+n0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KY2alyq0ezqOC8e//Gf0Kss0SR/XuyxHxs8TMVVM0aw=;
 b=ZyPbOFU+0HRyRbBMW53GTuw+wx/Au99BOQI7JXzUdZZyYHJTJmmmOdK8rvmv0v9me8ue7Kn/C42QY3BRadi7r26izSacYozos4cuF/yHyp/FPVn6LNvtL+L9N8eUxwPi1BjD4Cm5+QqY82006/UD5mxZrXc0DyqGyLfIBBTapll9nMuw1mjjnipy03TEUMs2gangjn1/oP9PfXeNLSwQJETFYm8KRaOBvGWmkRWDG+pyuyeKv+XcUjB+dS0jgdd0pQ7DKZFmXDYgaa6FUlN8yKKZjVXl6USHg8fQEA7f11huWZ37PL+U7X9yoEvD3/Us0S7VbCJWjuuPwxaecdTrNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KY2alyq0ezqOC8e//Gf0Kss0SR/XuyxHxs8TMVVM0aw=;
 b=sRQG6p4y5eXLg8wHhtCGnnqgKirFHTnYoU7dA+UWxSC/FxX21aerBzTm6+FLcuD1hys3cT9K8wvmNUz3sCNQCRVVMggNEm6EWJusI38voBhOsYwQFraGPiJs1cAX0p5vmNbLJGTrWyvrYXCBvAJZ4vzgHcfpG6NCtYp/Vi5gGTrt8SmQMQiWAvG3LFkTy7uWuAsIOZiiQmCzh9bEl6Q1WuIBB6bS5v7E2OKOy1dEYjANGxEFACJm3Ld6DRQT6gBSKSyImpN97i6yYNkjFo8t+TZqvph/NAw34hwj/9Gpuco7d8NRlqAyCPZiIgtOMcVOkP3hVt/CjSn7S2p5WbOwSA==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by SA0PR02MB7465.namprd02.prod.outlook.com (2603:10b6:806:da::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Wed, 2 Sep
 2026 14:32:40 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%3]) with mapi id 15.21.0360.008; Wed, 2 Sep 2026
 14:32:40 +0000
Message-ID: <9799d927-8e87-47d2-9d61-3e93b0863173@nutanix.com>
Date: Wed, 2 Sep 2026 15:32:36 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/8] qom/object.c: introduce
 object_class_property_add_alias()
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: pbonzini@redhat.com, richard.henderson@linaro.org, mst@redhat.com,
 mtosatti@redhat.com, marcandre.lureau@redhat.com, qemu-devel@nongnu.org
References: <20260828150313.1883999-1-mark.caveayland@nutanix.com>
 <20260828150313.1883999-3-mark.caveayland@nutanix.com>
Content-Language: en-US
In-Reply-To: <20260828150313.1883999-3-mark.caveayland@nutanix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0066.namprd05.prod.outlook.com
 (2603:10b6:a03:332::11) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|SA0PR02MB7465:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b76f5cb-a582-4116-931a-08df08ff0afe
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|23010399003|10067099003|6133799003|22082099003|18002099003|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info: d5dpxb8ayWVeQpPUSpZ9VEuBJv9zYj9eBklBe1Dj8FDFJn5VAShxt4Qp4w7bKzFB9O92+s2HrRYlPIgu5N0YJWtjSw1MHnPd7+AEukM1Io6L+19t3iEsgM1yPl4y75u+KwmPuRoOpc5UaqFtRhHb0A6oCY1IoZ5xiyuGIc9LIcwl58F239CkR1VP8zz6fNPZE545ZgoLC3EbwvSXnnliQWF5xl+QSJfBKZEY28p7XUInTFXvUT5dW0AdnFXh9/Dty7/yN5bgiGgKlcvDOGPRKN0V008/ysiBl1FdKMNzG0zmh1M5/xj+qSNVEpLWX4Qt3V/5lc0Te1zo1Ez9W2Ovl7LvpcxUDndP18Pq6ZXOmskvq6KaIsWKS665i2t8yiIFHbUaOsdcDGzpjVVb7zPaJ7Ln8RIfcl0VlIOlhHEaxqxO1SJtsY6bvmPVzB0XOiaveNLiSWya7F+2YmNIrMwJofIcqpuNVCkwR7uXYROqIPOianBD/ETkwXZfLLvxJ/wxJHk4K0LzxQxJGYj90hQVLbh7GHhwtEuKYATCEU+mL6tDtx8yhBPnHYlcgfv+qWTc8fTgOMXZOyDY0kkeGPkPnYOUR2J0b8aOlWmM2WhzVj5rkphE4SdpAbExYDT5ZrHKx/nEDSLXhtMW11LToClw/09X4XH/LojatxxP3ZKEiaM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(10067099003)(6133799003)(22082099003)(18002099003)(4143699003)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZUNpdWRTNlppS2pzemZDb0NuOWJTeXByaG5obGZYWnh1U0J0ZTltOU9pMWJh?=
 =?utf-8?B?R0tLV3o3bGdxWDduRkR3R2RIWEMzanV3dnBSRU5icENLVFd5cllqVWhlc0p4?=
 =?utf-8?B?OExYOWJMWDk1TWV2OFdnaGFyRURkZDA5UUN1L2dldURvc0s2dlJkTzNPK2Vl?=
 =?utf-8?B?cmpVYkNDK0swVjk4SThYdEM0SFAyMFkxUXRkdFZzVTdDUG5aNGNlSUZ4KzI2?=
 =?utf-8?B?eGoza3UxUEtJZFdRNDQvb2lmRkkxOFB1VHU3SUtmK1pnR3NGOXRpSUkwVGJl?=
 =?utf-8?B?S2RxdVdrclYrWHYvUVA5anNtbkdjcmRJNEZWbCtFRzBCYWljMWJLU2xUUnZ5?=
 =?utf-8?B?VXp1b0JwVXF2MXZId0dRZ21HWHN3VnRkd2dSNW5tTlIwalJLbnR0cE5JeHpX?=
 =?utf-8?B?RDlrakp1R0RPc00wLzZnZ3J6UGVsZXBtTUEyMnFDaTYvUnNjOFM2L2s5WHBy?=
 =?utf-8?B?bDJyOWdRcjlhalU0L0tWQ1YzYStWcGtBUUFneHN1ZEVLRk5vNEhzUnpEcFN0?=
 =?utf-8?B?bmttZ0NJSGFObkRTTGE3NHJqK3VUK2pjQWVWTVgzTVpiSWlkSFYzSE5MMGU1?=
 =?utf-8?B?SjBESFJjOTE2Rk9VdCtxc1VHTzdhK0tNTFlwMzNEWHVJSzNqMmxZTHhqYkdX?=
 =?utf-8?B?ZWpkK1AzVnY0U2ZpS25NMkx5SFY2UTZEaXY2LzUxeDU1cVlicFVkZFNmalJp?=
 =?utf-8?B?elRDNktzOWRVVkxidlRldDBVSGhTL0tXTmNDNmhNcUxZUTRUM05zVWlVV0Zs?=
 =?utf-8?B?Y0swUkpvS1g1MlVGVHFqZFJZZGZoVEEvdWt0S0l5RzNpa2RPMnRSS005d2pS?=
 =?utf-8?B?RSs0UzJZa01pRDg3MXJCOHBQdXZqQllCeDUvYVpyNDNZWCtvQWhGd2RMMXoz?=
 =?utf-8?B?Q01BTEtuengyZ1ZnUmhUNUU2MHI2MU9sMWYybGlwN2RJRERMSjdXT0R0cSsw?=
 =?utf-8?B?L3EvQ3p2U0lsd09NN25CV2gyQW1KTHJONzFiWWt4aTcyTlNKNUtxZHhsMUUz?=
 =?utf-8?B?WHVTWVExbGFCVER5Ymhsc3B4cVFRNnZNcTRwWTZyT0pOc0hUZk11cGlITENn?=
 =?utf-8?B?RG5pK28zY0xBc1l6Z3dpNVRiOFN6ZkRENWVhNkRvM3lTY3FBMWMvQTB0bzJS?=
 =?utf-8?B?ajViMldDT28rbWhkaTVzaDF3dXlnM1RnYlVXVDNaeUF1NEhZYzQyQWowbWsr?=
 =?utf-8?B?bkRSNWVYSnExTG1yNFdnT2dncUgvSm03ZmRoM0ZidTQzSE05d1didjd5bkpU?=
 =?utf-8?B?RFg4K0IzYWM2K0QwSDhjeWZqTE9xYkp3K0x6KzhpMTRhWmFOME9DYkREVms0?=
 =?utf-8?B?bUEyeU55N2wrTnZFQm9oZEJyQ0FWTmhidGI4ZVdDSVRYdllBWUFHcU5Md2lF?=
 =?utf-8?B?TkdLeUF1eGVGdDNSYVF3RTdLekpsL3ZWVGNwVlVlb0VFWU1Yckt3N0tyV1ZV?=
 =?utf-8?B?VytkZFVrOGVTbCs3VHhEYWw4UFEzdUw5aEZoamo1eklhcktHV1ZWRHNxVXZO?=
 =?utf-8?B?eEpZeDdnOGJaR0N3UDFoRGJkTnhZMmJRakJPUVNlVllGR0p5bXZQWXR6Mmls?=
 =?utf-8?B?OVozUmZsWG9VV0hWL0dPWHhWU0Z6R3RmYitJUy9ORElNS1J0c0VlQWdYZDVQ?=
 =?utf-8?B?NlEvcGIvTDMwaDRVVG9GNU9RZGtOaXIzUFdLT2pwZ0tSVjVCZ1JwZnp3QUR1?=
 =?utf-8?B?SjJuKzhNK0FvWkRuM21OSGozNmdhME5MWGZod3k5aURBTkxNWXU4QjMvM21V?=
 =?utf-8?B?aHpsaWMvajYwVG8vMWRiZlE1bWVORHVHWWh6bmRySm80SHF3ZEE0K2dnUUVh?=
 =?utf-8?B?SkdxUTZtUXBuS1RFcWJUckdwVDdJQ2V4WVp0bmhNMmlOUTltdDVxd2lxbm1v?=
 =?utf-8?B?QXVNNWRFcndIWXVDWVJYUVYrbU1pQ0doM3V0Mzh4Sm5SMkJVK2ZETi9ESHh5?=
 =?utf-8?B?bVo1UmpuWlZPQzN4RzQvb2RjQ1oyOVIwYXVTVnhLdHE4d3p4TzRNTUlOSGxi?=
 =?utf-8?B?V3pMU3ovYnh2RnhDYnBoWjFTZzB0L1U0MXlsY0xzcXZxeW9tVzNFSytRQVpR?=
 =?utf-8?B?Z1lXYUZtejJiQWxEdkNiZllFdHB2SU1NQWFydElqR2ZyZDFsZWhVNm1kTWlX?=
 =?utf-8?B?d3c0ZW1EeGE3bCtmdmRud0JDWElqVDVWYUYvbFlFRjZNRzNmbmE1b1Y0K0t6?=
 =?utf-8?B?VlhNOUp4QzQ4NVJQbjdzbldhbS9lWFZUTHNHRlNpZkxCUTF4QjB6R2d6NUFE?=
 =?utf-8?B?V05sd2NxUFVZeWtxeW9KQXpOaVR5MzRheHpGeWFyMnVSc0JuTHNvc29JM25I?=
 =?utf-8?B?ejNHbytEOGYxbWE1MExCU1UxZnVRbzg1NzVUMDRubk0vSmNQaUdIbXcyMHRP?=
 =?utf-8?Q?bamT89WwpuwE4zUM=3D?=
X-Exchange-RoutingPolicyChecked: CwqDHb7GWmA4pQVkm3UUyrqODm03L5gJ81Z1XXUJbVBWgfnyE3knmNLmwEsuLcfPvqmrekHIYubJenkwX3U2ivMA7rMWIKJ6b1/B9t/Kg8Xgp8y+8VPaErOEZMZEY4j9K2erDFLf7jefO1oTpUg7DmSVBaflR0KSadIpI6v/Uc+8huxoeSVliv4a8XeWLlikK17n1K/eXJAmOZX4GZh1bgU5AJuLS68E+QncHWK1uRAyUfxILu9ibEPvod3PRYV6+wRSr50Lqr0Q/hCjYKA0N4mrtrfvlNYpOdrU3OrGGTnCNKh2oonYT3oTEnW2IH/KP6frQG3kv4ey+3ezXTRddA==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b76f5cb-a582-4116-931a-08df08ff0afe
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2026 14:32:40.5642 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9jmHdCAJOFMCjm4eR9lgpwazfH7L6xdFafVbUBVfu69LcXkHDbu+ZRMDvN9nBSoTQxx4dtzv36/BthxMEVjgrKvVr+kr6oaoG0Olquhtpg0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR02MB7465
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAyMDEyOSBTYWx0ZWRfX3kVC0araJWKY
 1g5HgWhMYhA3HM2ZfdhewyRlVBpRIVdlxpCUjqOoql05tmprYdn2QuWwHLo2olIEPG3IoY2zU8B
 YD21ZwKYZjBzsQM6O/5JWyOi0GDRJNA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAyMDEyOSBTYWx0ZWRfX3I2j2Wj8lwj0
 izh6hqjUJ4+8yNahP4um8V3TSxabAvqO2YqOYPROPIZ5PGmjiIfblDyXjl9GRdGvUiPGljKB6Xv
 Lh1aoOpJI4ZFJW6+fogVwJ1P7xQSMUj2xy+/tUKMzdbJRqOPoc365azY16UIGBPY+aty7polEKZ
 tiW+Bo0ymD3+T0Ws370c1l0+iVW5y930hvzkKdAxIGgJxaImf0tTj3fuBmLtRt3IgCtHn6L0eZI
 epmGLZQZbPGKQpbux1RiIbt2r8ddTN1VhPSTkNYQjv/YKkke8/DGeawQcmOBCIFpZW5Q50pZJ7o
 QGDRd/XmhR34C1YqIdQtMHmTkOY+Oo9XV7ic1LQ6KJVAziEDeR8qRMDTmPp8xRW2N/qsIQ/vXXr
 F/CsYCIeIgqX1ZzlOmcKHBf4X4DL1DYIbV9ntNOzfwXRkiesDXsQIjyxLY+23T8P7xQdXj0IKkI
 K5YDNDR1lcffk9Wo8vA==
X-Proofpoint-ORIG-GUID: 2mYPD5nynAmwRxqQpCWAxfLaApIpG4TK
X-Proofpoint-GUID: 2mYPD5nynAmwRxqQpCWAxfLaApIpG4TK
X-Authority-Analysis: v=2.4 cv=E6r9Y6dl c=1 sm=1 tr=0 ts=6a98338b cx=c_pps
 a=swhzy8d5zJl5pBN+sEYk8A==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=Ap8k9tRZuQ82DLYWQqG7:22
 a=64Cc0HZtAAAA:8 a=2taQMi-KlgMfhHEsOwEA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-02_03,2026-09-01_03,2025-10-01_01
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

On 28/08/2026 16:01, Mark Cave-Ayland wrote:

> This is eventually intended to be a replacement for object_property_add_alias()
> which uses an object property instead of a class property.
> 
> With the advent of class properties, it is possible that QOM may attempt to
> set or retrieve the value of an unset alias property. Update the existing
> property_get_alias() and property_set_alias() functions to use the null visitor
> if the alias target has not been set, and property_resolve_alias() to return
> NULL for the same case.
> 
> This ensures that unset class alias properties accessed e.g. via the monitor do
> not cause QEMU to crash.
> 
> Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
> ---
>   include/qom/object.h |  11 +++++
>   qom/object.c         | 106 ++++++++++++++++++++++++++++++++++++++-----
>   2 files changed, 105 insertions(+), 12 deletions(-)
> 
> diff --git a/include/qom/object.h b/include/qom/object.h
> index e24f0a2b2d..1c51944786 100644
> --- a/include/qom/object.h
> +++ b/include/qom/object.h
> @@ -2263,6 +2263,11 @@ ObjectProperty *object_class_static_property_add_uint64_ptr(ObjectClass *klass,
>                                             const uint64_t *v,
>                                             ObjectPropertyFlags flags);
>   
> +typedef enum {
> +    /* private */
> +    OBJ_PROP_ALIAS_CLASS = 0x1,
> +} ObjectPropertyAliasFlags;
> +
>   /**
>    * object_property_add_alias:
>    * @obj: the object to add a property to
> @@ -2283,6 +2288,12 @@ ObjectProperty *object_class_static_property_add_uint64_ptr(ObjectClass *klass,
>   ObjectProperty *object_property_add_alias(Object *obj, const char *name,
>                                  Object *target_obj, const char *target_name);
>   
> +ObjectProperty *
> +object_class_property_add_alias(ObjectClass *klass, const char *name,
> +                                ptrdiff_t offset,
> +                                const char *target_type,
> +                                const char *target_name);
> +
>   /**
>    * object_property_add_const_link:
>    * @obj: the object to add a property to
> diff --git a/qom/object.c b/qom/object.c
> index a904f53ed6..873083618a 100644
> --- a/qom/object.c
> +++ b/qom/object.c
> @@ -34,6 +34,7 @@
>   #include "qom/qom-qobject.h"
>   #include "qobject/qbool.h"
>   #include "qobject/qlist.h"
> +#include "qobject/qnull.h"
>   #include "qobject/qnum.h"
>   #include "qobject/qstring.h"
>   #include "qemu/error-report.h"
> @@ -3039,14 +3040,22 @@ object_class_static_property_add_uint64_ptr(ObjectClass *klass,
>   }
>   
>   typedef struct {
> -    Object *target_obj;
> +    union {
> +        Object *target_obj; /* if !OBJ_PROP_ALIAS_CLASS */
> +        ptrdiff_t offset;   /* if OBJ_PROP_ALIAS_CLASS */
> +    };
>       char *target_name;
> +    ObjectPropertyAliasFlags flags;
>   } AliasProperty;
>   
>   static Object **
> -object_alias_get_targetp(Object *obj, AliasProperty *lprop)
> +object_alias_get_targetp(Object *obj, AliasProperty *aprop)
>   {
> -    return &lprop->target_obj;
> +    if (aprop->flags & OBJ_PROP_ALIAS_CLASS) {
> +        return (void *)obj + aprop->offset;
> +    } else {
> +        return &aprop->target_obj;
> +    }
>   }
>   
>   static void property_get_alias(Object *obj, Visitor *v, const char *name,
> @@ -3054,10 +3063,18 @@ static void property_get_alias(Object *obj, Visitor *v, const char *name,
>   {
>       AliasProperty *prop = opaque;
>       Object **target_obj = object_alias_get_targetp(obj, prop);
> -    Visitor *alias_v = visitor_forward_field(v, prop->target_name, name);
>   
> -    object_property_get(*target_obj, prop->target_name, alias_v, errp);
> -    visit_free(alias_v);
> +    if (*target_obj) {
> +        Visitor *alias_v = visitor_forward_field(v, prop->target_name, name);
> +
> +        object_property_get(*target_obj, prop->target_name, alias_v, errp);
> +        visit_free(alias_v);
> +    } else {
> +        QNull *null = NULL;
> +
> +        visit_type_null(v, NULL, &null, errp);
> +        qnull_unref(null);
> +    };
>   }
>   
>   static void property_set_alias(Object *obj, Visitor *v, const char *name,
> @@ -3065,10 +3082,18 @@ static void property_set_alias(Object *obj, Visitor *v, const char *name,
>   {
>       AliasProperty *prop = opaque;
>       Object **target_obj = object_alias_get_targetp(obj, prop);
> -    Visitor *alias_v = visitor_forward_field(v, prop->target_name, name);
>   
> -    object_property_set(*target_obj, prop->target_name, alias_v, errp);
> -    visit_free(alias_v);
> +    if (*target_obj) {
> +        Visitor *alias_v = visitor_forward_field(v, prop->target_name, name);
> +
> +        object_property_set(*target_obj, prop->target_name, alias_v, errp);
> +        visit_free(alias_v);
> +    } else {
> +        QNull *null = NULL;
> +
> +        visit_type_null(v, NULL, &null, errp);
> +        qnull_unref(null);
> +    }
>   }
>   
>   static Object *property_resolve_alias(Object *obj, void *opaque,
> @@ -3077,15 +3102,27 @@ static Object *property_resolve_alias(Object *obj, void *opaque,
>       AliasProperty *prop = opaque;
>       Object **target_obj = object_alias_get_targetp(obj, prop);
>   
> -    return object_resolve_path_component(*target_obj, prop->target_name);
> +    if (*target_obj) {
> +        return object_resolve_path_component(*target_obj, prop->target_name);
> +    } else {
> +        return NULL;
> +    }
>   }
>   
>   static void property_release_alias(Object *obj, const char *name, void *opaque)
>   {
>       AliasProperty *prop = opaque;
>   
> -    g_free(prop->target_name);
> -    g_free(prop);
> +    if (!(prop->flags & OBJ_PROP_ALIAS_CLASS)) {
> +        g_free(prop->target_name);
> +        g_free(prop);
> +    } else {
> +        Object **target_obj = object_alias_get_targetp(obj, prop);
> +
> +        if (*target_obj) {
> +            object_unref(*target_obj);
> +        }
> +    }
>   }
>   
>   ObjectProperty *
> @@ -3110,6 +3147,7 @@ object_property_add_alias(Object *obj, const char *name,
>       prop = g_malloc(sizeof(*prop));
>       prop->target_obj = target_obj;
>       prop->target_name = g_strdup(target_name);
> +    prop->flags = 0;
>   
>       op = object_property_add(obj, name, prop_type,
>                                property_get_alias,
> @@ -3126,6 +3164,50 @@ object_property_add_alias(Object *obj, const char *name,
>       return op;
>   }
>   
> +ObjectProperty *
> +object_class_property_add_alias(ObjectClass *klass, const char *name,
> +                                ptrdiff_t offset,
> +                                const char *target_type,
> +                                const char *target_name)
> +{
> +    AliasProperty *prop;
> +    ObjectProperty *op;
> +    ObjectProperty *target_prop;
> +    ObjectClass *target_class;
> +    g_autofree char *prop_type = NULL;
> +
> +    target_class = object_class_by_name(target_type);
> +    assert(target_class);
> +    target_prop = object_class_property_find(target_class, target_name);
> +    assert(target_prop);
> +
> +    if (object_property_is_child(target_prop)) {
> +        prop_type = g_strdup_printf("link%s",
> +                                    target_prop->type + strlen("child"));
> +    } else {
> +        prop_type = g_strdup(target_prop->type);
> +    }
> +
> +    prop = g_malloc(sizeof(*prop));
> +    prop->offset = offset;
> +    prop->target_name = g_strdup(target_name);
> +    prop->flags = OBJ_PROP_ALIAS_CLASS;
> +
> +    op = object_class_property_add(klass, name, prop_type,
> +                                   property_get_alias,
> +                                   property_set_alias,
> +                                   property_release_alias,
> +                                   prop);
> +    op->resolve = property_resolve_alias;
> +    if (target_prop->defval) {
> +        op->defval = qobject_ref(target_prop->defval);
> +    }
> +
> +    object_class_property_set_description(klass, op->name,
> +                                          target_prop->description);
> +    return op;
> +}
> +
>   void object_property_set_description(Object *obj, const char *name,
>                                        const char *description)
>   {

I just noticed that this patch was missing the corresponding kernel-doc 
comment, and in the kernel-doc for the following patch was a note as to 
how the refcounting should work. I'll post an updated v3 with these 
changes shortly.


ATB,

Mark.


