Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DB2DC5CFC1
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2026 11:32:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuq8W-0002Gq-4y; Fri, 14 Aug 2026 07:31:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wuq8U-0002GN-8K
 for qemu-devel@nongnu.org; Fri, 14 Aug 2026 07:31:42 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wuq8S-0006jB-4x
 for qemu-devel@nongnu.org; Fri, 14 Aug 2026 07:31:42 -0400
Received: from pps.filterd (m0127839.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67EAdu4X1548648; Fri, 14 Aug 2026 04:31:37 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=6EKDeBgS+5XljoSm5bz6csN+TNNJRuGUWT6mwUKc+
 Vo=; b=1jSynnKbdfuU3z3FqcKqO/A+oSfOJc4dZ+KOZ4dp8TSG6UMv4/YJQ5GV2
 76wcjkQaXTlDwXHX+YGZbA+cua0D71CtKdojJJ7nqIAxOKLSoAqJLl96vvJdx5PE
 slrYEaDLKuhLqDo61MSv6hjgpBGDLrTf697tvHJ384NZdnfh2tPTvfbQkuOUFs6n
 +79taa0+pj/f9PPISsq+R4CKXZX7o2vN/oYL7s3y2JgIzrfuX2TNSKtGY2eeCe4D
 FegSHnu+FX0eoKgsTP7WGeDVLQBsjWpQJkkQQKWmz5zkM/pBY4QZ4bp+5TTEPrOr
 6IJGVK5i8MoWQ/OBn7iHStPldFfyQ==
Received: from bn8pr05cu002.outbound.protection.outlook.com
 (mail-eastus2azon11021095.outbound.protection.outlook.com [52.101.57.95])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4g1p1d1dxd-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 14 Aug 2026 04:31:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mtdn+nf1kk/1/d3O1fCxQtiZBcTtXMgG0O1Fro6hwRZNKD99WveYTkVEgUP7EQFq7jOpUZ7rAQnKTzA04DRqG5wSPX5H4iEzLK1DE/zbHTGAG8+ydXybPV68ZLIiZyOGnKADBZqVlah2203vmVFuUyRCcpQvmwVseP9/nATFG5tkVxiJrNBTC7Gh4pNM1/vOq3Q3T6a+OCZX+XPpWdEyX3vPNAWMllfTAckuAHPaeYR2dsx68X5tSQcn91zOVfuvjx2vSHc2+AGgNI5csJHxiKmeOekld5nf3KrKIcxUAkOCGqDcCILSM/lItt+c/rs4CqU0kJNay2o2WooOoUP50A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6EKDeBgS+5XljoSm5bz6csN+TNNJRuGUWT6mwUKc+Vo=;
 b=u7h+ED17jmrTllzoYf3K5N0T8/+aSaZqdAPnXRor59cbxOz0XyqmVVExpIcmvbJzmttSdOI0aJXamSN3rw7IMyXwJNJVexpNZ2hR+E72ZJKSBoDEGEEeg7RIJs1E390H1HrsraCJUllULGq8lQnlW+Cw0nG+SZS76B0vJKo6oy6CYKlazpD7I3fPWXYSjgo22Wyj5qwco02XXCbrxqzkF7Az5IBpmmYyhAFqJ/xw8bVH5EnMvmB/p9pw1o3B9Fs5XJzwPiIJKaOWVKm66KplYDARLpdxseby7/0KqLnp1O9ZR8GOtXk4kF/19q4NBXyzjtVzV+/dCR2MZ+hPxMr6iQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6EKDeBgS+5XljoSm5bz6csN+TNNJRuGUWT6mwUKc+Vo=;
 b=oTPlOOJNRrtkrUdn/E0K9tqa/hf2tnW3Y522mXTl16+SZLWjIq/KY3uZ/osPhpoEnNchxLLjI3OsORilOW+MVRaVTI82RDFcVa8m0+63tDNDjj8TbjfSyofcQcgtEjf0VPQjWkMZCsXmam3+ayUw2zxzboMkUy1iPf7W3RpA9NInnMxmPS8TizB+2IpyPSgDyEV4lMZjnM9viKE6csgcWKJZFpqJXUHl8oyQ2F99pMo3BH9NZbmMNzM98CNCaVMaeG2vYI8frznpeJatNovDYuumcBpjUBerUEKdTSfJmvXECMxQrmLOoHSwWVOOkQu1YUi0srtrqLkdFIvy1A5N6A==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by IA3PR02MB11199.namprd02.prod.outlook.com (2603:10b6:208:542::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.16; Fri, 14 Aug
 2026 11:31:33 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%3]) with mapi id 15.21.0315.014; Fri, 14 Aug 2026
 11:31:33 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: qemu-devel@nongnu.org, richard.henderson@linaro.org
Cc: Mark Cave-Ayland <mark.caveayland@nutanix.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PULL 5/6] qom/object.h: add missing documentation for object_class_*
 property functions
Date: Fri, 14 Aug 2026 12:30:23 +0100
Message-ID: <20260814113044.2416794-6-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260814113044.2416794-1-mark.caveayland@nutanix.com>
References: <20260814113044.2416794-1-mark.caveayland@nutanix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PR1P264CA0084.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:345::6) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|IA3PR02MB11199:EE_
X-MS-Office365-Filtering-Correlation-Id: ef75426e-98e5-45c6-8c5b-08def9f7980b
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|6133799003|56012099006|10067099003|5023799004|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 5i/nBLyvPxBBUCGadRIU5MnubwwJgWQP7+p9oXuk0A6V6P3/z4yOr92LxE4D9e/sW/VYMFdydfuEALYJRJFRColo00SQeiURqEOl4sx/SafKgT0Pwsw4KuswDB0I/7TTkz7lcscNpdOMNPKEb1K4HKrlhFgsYCEQCMjPAHA/A2e4jX7fb/n4vQoc8juhXF4Gl9uQ8JT82RU1YtdRAUUtA6tyorzO3FZEyoXpYZ24sOKg1/ql5YtuoVDyrYnL1RZtDaA3XwpjqVHXS5xbAxq+756mASxKL9WyUteF4KlVLs/puUs22CFKcWn64+OyOSMy+HhH33WOzWdWoBvwq4WgMzjmNm0yBJdK4Ewvggrf5gun2nT8a0qA1qS+i8WfzBcSf0jlz+/a788hwJAYfnaqVNxqx67saudoWR7m0Zs2j8OVq2Tot/h/DKPoESl7RJuXtWSVG0sS76lnYQA64mzQmzG7XMWB0vx3t5B5oKBVEYwxvUyoUZdW1KRx+LBlbAEiGKnraFYOQUbzwUJ7ksMcWdEA8ejajDOYdOBBrHPyHKBUXE8KYmCiRrTgLdM1sOjiDGzC7yiToYEQufN4ocZ8TsZ9PsFDOG/lY2E0KhPD1hn2rVqn9REd4msTBbC2zOG5VIzR04zwvYTTbYSW0N4cPKb14mscePjuHRL1GHJPzm4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(6133799003)(56012099006)(10067099003)(5023799004)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z1ZES21lM2FJZW5zM1hMUTJsbFV0MVpIRVhSQW14ejQvZkVueVI4ZmZjQk5I?=
 =?utf-8?B?MkhuMXVKUkdGeUgwdCszRHNKOTVXVXkybmdzRDNBcUtNSXo0b1l6SVZ3c1BH?=
 =?utf-8?B?Zi8zZ21QNXJMZFg4VDh1Wm5iNnZjbUdTNEdHZXpIRmhxSVVhNU1Wdlg3bWJY?=
 =?utf-8?B?bmQ0UXRuc21YbVpwSkRvaWVEaFd5UGlRRGJwalBwWjBtai93akdHakc2RG5m?=
 =?utf-8?B?SExSZmUxcmtyRXRUREJTRHRtdTQ3dXBSTkN5Sm5HWGhFN3FKRGVpbzlvRzZ4?=
 =?utf-8?B?ZFp4M1JkOW9aRkxwTHJaNDlYelczdTZtSkZucjFFb01OK3dPc2w5cjVLZi93?=
 =?utf-8?B?L0RNdkdhOWFTL2wvem53Z0FYbVo2bmpOQjUwWGp5ZzJSTWErQmdUNTJuRnpT?=
 =?utf-8?B?WkZoKzNqVG9TZUhPd1VCZHNXTWgrNUJkVnFCYytvYkJ1bU5reTV1ZmFBUEZK?=
 =?utf-8?B?MVBoMU1JVlBqTElVNFdOdGdMcTVPNXFJaWZCOFJENlFzdjd2aXluTmxHTHpn?=
 =?utf-8?B?SVNVek1xZmpOQ3UwczYxL3hxVUhpdUp4SDBQSmNVQmFTN3BBaGYxbVJNTWZN?=
 =?utf-8?B?MFNaNG41OW9uR2NSTjJFRlpIOXZHWkZwMHY2YmszUW41Vm0xVEllNDNUazN2?=
 =?utf-8?B?RTBwOEtUc3JxeEZ1N1UxaW5EOXZQOUt4b0ZWTVdvMXRQaWo1ZnhZQktRSXds?=
 =?utf-8?B?L1RPTTRKYWVrUmtCZmhkeGw4N1MvWVZvbS9nZ3I0aXA1M1IwaVNLc1BjcHZV?=
 =?utf-8?B?N1BHcUdIUXRLMG5FMXlMVUk2d093akdNdDdwdUE4Njl5V2J6SzB4ZG1zZGZN?=
 =?utf-8?B?T1ZkZ3BEblNjQjRkWkI4NmtUalhCd1JzdVNtUjAyNEl0U1pGNWZjc0NaVHAy?=
 =?utf-8?B?bTQ3V2RHalMvRXJqQWVvTzk5NVR4Mlp3djhnSWZNdC81SUQ3NEhUaFhLTGtQ?=
 =?utf-8?B?R2MvVWdUVGFVSzRtVWRTcU5KamlCK0NPVGxGQmtZQnk5U3U0NUhBdjdvVVVO?=
 =?utf-8?B?SEpHUzBUQjh4d1ZENm1Wc0d2TEJQVmk4ZGlWc0VmQ0cxMnFWVDZDa29aUDE5?=
 =?utf-8?B?NHJTZDZJL1FKaGt2KyszZ2JmUjRJWFVwNmoxaVl1YXNsZ0k3dG9jcjM4R3ho?=
 =?utf-8?B?SDJwUGkvNjdoY3JjVTFvU09BaWtjenVIM1M1UUlLN2pZNE1ERk1URndNZytK?=
 =?utf-8?B?WGpLQWVRSUJyb3JicG04UHBrUFpGSkJ1S0ZOR3dRM1JBSXZVQ281RmxxUnVZ?=
 =?utf-8?B?TVkrKyt1ZEd1SmNWU1NlVXZGZTQ5eXpOWHNhMDduNmp6WHpPcFNxeXJnek5G?=
 =?utf-8?B?TXduMWhRbXpZVHNDQklvM2R1L09JZGY3UjhDNVA4N0NkSC9XY1l3VzFDZHlZ?=
 =?utf-8?B?aDA5V3QwTTlnNldGZEowQTlXM1lOWUF5K3FydGlGb3hMUEhWMkhnRXN4OWlK?=
 =?utf-8?B?M1NDdFovUlF6V1dOcDdKSU1WTFUyRmNSYjgwQlFpVlZZU1B4d0wzTWtwVHpx?=
 =?utf-8?B?MEdibW45WHkwOWtrb0NUSURLNHJydEJmNk1EK3hMQzFxK3J6S2hFZDJrQi9M?=
 =?utf-8?B?TGlnbXVYMlZwMGoxclM3K0VIL25DazJpbEtydUdLTjl2RkZ4czh1d3Jxbjl6?=
 =?utf-8?B?dzRXTUlYS0JNTHhuU1NPNkkwdFppMEhyMU51WUFUT0xLYlhYaG5OSSs0YTRz?=
 =?utf-8?B?NnR4YmgrU2hVYUloMlZwZitDR1NPZ2RTcVpGdEFLd3NjZ3Z5NHAwLzdKdWVZ?=
 =?utf-8?B?ekF1MTRjeTRBY3BDb2pSQnR6eWU4bmtOWmVFZHV4aUMweVI1WDR6TEYwVkVI?=
 =?utf-8?B?bHZyaXhLcVVTUGovc1ZnTUZ5cVhFdklBYVByUEdSdWlQSkJDallnL05oRWdD?=
 =?utf-8?B?ckNOZ2xUSDlEYndsNXB2emJ1V2NMMXpOR2FLdmx2YXUvUnBoaFdoNWQxMWFv?=
 =?utf-8?B?WVEyZU9SKzZRM3dYRmFPTzJaS2RIMk4wSlZDbmlyM09jUTEvTS9hMGJyRmtx?=
 =?utf-8?B?MHE5bEVXVFl1eFlFUFJuTWsrWmF3cm5RbytZTGlPbU1VYzJpMkQyUXVKdjBT?=
 =?utf-8?B?Q3N1ckNiQVlDaHhEeDNmeUdnbTlDSm1uMmJiUFBXWjkwWkEwNzFneWhRZ0Fu?=
 =?utf-8?B?Z2JtQnEyMGhhNlNTMlpVVndRaHk1UkxiOGNlalhJZVBVdERlSTNjcnI0VVdS?=
 =?utf-8?B?UGxJQXVDY1VmSVk2Q1JPdTc2VjlMOFhJUXNUOXNxdllXaFlRYTBub3BSQmtL?=
 =?utf-8?B?S1JTSlFkcjZVODBUemRpb2VLUjJ4MjhINzZGd0xCNFJ0OEZCSlIxNldtTkNs?=
 =?utf-8?B?UE83dXlIL3R5K3lscjFUQkFvZVhacHRITlpWTENOeEN3MHBsS2czUjhxL21G?=
 =?utf-8?Q?lXfWEuvOFL69bIoc=3D?=
X-Exchange-RoutingPolicyChecked: SItC1ElRvGal5NS46eGGmdq64sJVMVmw7UA5yhtvgm34B8BHot9NUHZ4X26+LCd5v+v+9ootSwgXm6fk/dQTvSfZNOt7Fa5XWM9aWyxuGsGEqfnpkphfi+bFZQLlyG8R5vz1tmXy58LqVujh3QaMAn/RpE9I3It/Kacnl0IhIADPRxU1AiLTwa0lHMJzqTIk2F4Ycaa/shrLOQgpXTVs2X316Kqqxu3CVwC4p/gfu9PqDawxvMx0+81ajECLvCi0LnbpMaM4GNsb/OW7VarJkQbw1vEwXVp6oeRJE82ZKhDTPFJpzh1LR0ke6VYK5HYEw2A02j2ca5fNzXwkyXOulg==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef75426e-98e5-45c6-8c5b-08def9f7980b
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2026 11:31:33.7444 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +NO391Iu4T1c1D2DKaZGSa2X2jOLNntXlF5sUtp9T2ruAAi0YuHdLfhoEDD8824+53XTezIgh3GkKi0u4CjaPANrzsJg6XZl5pdObtXyB6Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR02MB11199
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE0MDA4NyBTYWx0ZWRfX8uYHs96OVUNd
 sZbvMlX/zBsRpEJ/yKwIV4ydjcjuXo8Cnmc5Qma16ugKCESFxwDW4WiQEhJ/JqoePMWM5EuCZSm
 fAuNBaHwNls2J4CTP7s0Qkl4q3Et9QOW8z6kYWR5M8CXrCXnaVxnBdA+PINzffmfcIow7QNdcHF
 m/PJnMqlWCTsoH6NMj/xRjsL/l/CIUbc2maF/MZYjKJL7gkokpGk/2FptK2ZvpJkzvYHKjasPBx
 +Da/ZMYlGePhJNqW06VfO9yV9O/L9NNfMJXm8F6UdOcF+1fknUyVFtSSoNmVHvnHXhf8kl9eUks
 0SEvhhAUUMWC+AyMwe2E2mdVFkEJJvr7duTcWrhZNNjFNs0Z/O2icXLgpf04/LWfXTC6beCLACY
 Nulb2XDCR6NiZZEuWXxxjQwoYpbsiOnXrhI1NyHGmnyWpa1pHlFfAlDeJjssVEd8bMXk7FwQCQJ
 aUXOIpX8WMsUlRe0m4Q==
X-Proofpoint-ORIG-GUID: AnBr-AFYnwG7Nw_B-b3yM-3z0T3U4gm3
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE0MDA4NyBTYWx0ZWRfX4xfu7/98KQIE
 VLNkzYSU8GsXXPICSAWg2xRGS9EKNJUCH7zbUxMfnC1KMQOPEqCQu8pq6guVbmAnnjUc9BzYxIH
 Rav2BEzbCW2hfXQA8PtI0Ro4Tg9uqAg=
X-Authority-Analysis: v=2.4 cv=ApbeGu9P c=1 sm=1 tr=0 ts=6a7efc99 cx=c_pps
 a=OEfEZzoZvaPbKMfYjVMY3g==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=y4UcunY2MAxhM4LwGdWI:22
 a=64Cc0HZtAAAA:8 a=20KFwNOVAAAA:8 a=lESd7L1ileNoS6jXIgYA:9
 a=B2H1HY6s2cwHLFEM:21 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: AnBr-AFYnwG7Nw_B-b3yM-3z0T3U4gm3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-14_04,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.751,
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

This is so that the object_class_* property functions appear in the generated
QOM documentation at devel/qom-api.html.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Message-Id: <20260717135254.508701-6-mark.caveayland@nutanix.com>
---
 include/qom/object.h | 136 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 136 insertions(+)

diff --git a/include/qom/object.h b/include/qom/object.h
index 4e7fe2af7c..272c41cac7 100644
--- a/include/qom/object.h
+++ b/include/qom/object.h
@@ -1818,6 +1818,33 @@ ObjectProperty *object_property_add_link(Object *obj, const char *name,
                                             Object *val, Error **errp),
                               ObjectPropertyLinkFlags flags);
 
+/**
+ * object_class_property_add_link:
+ * @oc: the object class to add a property to
+ * @name: the name of the property
+ * @type: the qobj type of the link
+ * @offset: the offset from the object instance where the link object reference
+ *   is stored
+ * @check: callback to veto setting or NULL if the property is read-only
+ * @flags: additional options for the link
+ *
+ * Links establish relationships between objects.  Links are unidirectional
+ * although two links can be combined to form a bidirectional relationship
+ * between objects.
+ *
+ * Links form the graph in the object model.
+ *
+ * The @check() callback is invoked when object_property_set_link() is called
+ * and can raise an error to prevent the link being set. If @check is NULL, the
+ * property is read-only and cannot be set. Care must be taken to handle NULL
+ * values for @val.
+ *
+ * If the @flags %OBJ_PROP_LINK_STRONG bit is set, the reference count of the
+ * linked object is incremented when the property is set, and decremented again
+ * when the property is modified.
+ *
+ * Returns: The newly added property on success, or %NULL on failure.
+ */
 ObjectProperty *object_class_property_add_link(ObjectClass *oc,
                               const char *name,
                               const char *type, ptrdiff_t offset,
@@ -1859,6 +1886,19 @@ ObjectProperty *object_property_add_str(Object *obj, const char *name,
                              char *(*get)(Object *, Error **),
                              void (*set)(Object *, const char *, Error **));
 
+/**
+ * object_class_property_add_str:
+ * @klass: the object class to add a property to
+ * @name: the name of the property
+ * @get: the getter or NULL if the property is write-only.  This function must
+ *   return a string to be freed by g_free().
+ * @set: the setter or NULL if the property is read-only
+ *
+ * Add a string property using getters/setters.  This function will add a
+ * property of type 'string'.
+ *
+ * Returns: The newly added property on success, or %NULL on failure.
+ */
 ObjectProperty *object_class_property_add_str(ObjectClass *klass,
                                    const char *name,
                                    char *(*get)(Object *, Error **),
@@ -1881,6 +1921,18 @@ ObjectProperty *object_property_add_bool(Object *obj, const char *name,
                               bool (*get)(Object *, Error **),
                               void (*set)(Object *, bool, Error **));
 
+/**
+ * object_class_property_add_bool:
+ * @klass: the object class to add a property to
+ * @name: the name of the property
+ * @get: the getter or NULL if the property is write-only.
+ * @set: the setter or NULL if the property is read-only
+ *
+ * Add a bool property using getters/setters.  This function will add a
+ * property of type 'bool'.
+ *
+ * Returns: The newly added property on success, or %NULL on failure.
+ */
 ObjectProperty *object_class_property_add_bool(ObjectClass *klass,
                                     const char *name,
                                     bool (*get)(Object *, Error **),
@@ -1906,6 +1958,20 @@ ObjectProperty *object_property_add_enum(Object *obj, const char *name,
                               int (*get)(Object *, Error **),
                               void (*set)(Object *, int, Error **));
 
+/**
+ * object_class_property_add_enum:
+ * @klass: the object class to add a property to
+ * @name: the name of the property
+ * @typename: the name of the enum data type
+ * @lookup: enum value namelookup table
+ * @get: the getter or %NULL if the property is write-only.
+ * @set: the setter or %NULL if the property is read-only
+ *
+ * Add an enum property using getters/setters.  This function will add a
+ * property of type '@typename'.
+ *
+ * Returns: The newly added property on success, or %NULL on failure.
+ */
 ObjectProperty *object_class_property_add_enum(ObjectClass *klass,
                                     const char *name,
                                     const char *typename,
@@ -1927,6 +1993,17 @@ ObjectProperty *object_class_property_add_enum(ObjectClass *klass,
 ObjectProperty *object_property_add_tm(Object *obj, const char *name,
                             void (*get)(Object *, struct tm *, Error **));
 
+/**
+ * object_class_property_add_tm:
+ * @klass: the object class to add a property to
+ * @name: the name of the property
+ * @get: the getter or NULL if the property is write-only.
+ *
+ * Add a read-only struct tm valued property using a getter function.
+ * This function will add a property of type 'struct tm'.
+ *
+ * Returns: The newly added property on success, or %NULL on failure.
+ */
 ObjectProperty *object_class_property_add_tm(ObjectClass *klass,
                             const char *name,
                             void (*get)(Object *, struct tm *, Error **));
@@ -1956,6 +2033,18 @@ ObjectProperty *object_property_add_uint8_ptr(Object *obj, const char *name,
                                               const uint8_t *v,
                                               ObjectPropertyFlags flags);
 
+/**
+ * object_class_property_add_uint8_ptr:
+ * @klass: the object class to add a property to
+ * @name: the name of the property
+ * @v: pointer to value
+ * @flags: bitwise-or'd ObjectPropertyFlags
+ *
+ * Add an integer property in memory.  This function will add a
+ * property of type 'uint8'.
+ *
+ * Returns: The newly added property on success, or %NULL on failure.
+ */
 ObjectProperty *object_class_property_add_uint8_ptr(ObjectClass *klass,
                                          const char *name,
                                          const uint8_t *v,
@@ -1977,6 +2066,18 @@ ObjectProperty *object_property_add_uint16_ptr(Object *obj, const char *name,
                                     const uint16_t *v,
                                     ObjectPropertyFlags flags);
 
+/**
+ * object_class_property_add_uint16_ptr:
+ * @klass: the object class to add a property to
+ * @name: the name of the property
+ * @v: pointer to value
+ * @flags: bitwise-or'd ObjectPropertyFlags
+ *
+ * Add an integer property in memory.  This function will add a
+ * property of type 'uint16'.
+ *
+ * Returns: The newly added property on success, or %NULL on failure.
+ */
 ObjectProperty *object_class_property_add_uint16_ptr(ObjectClass *klass,
                                           const char *name,
                                           const uint16_t *v,
@@ -1998,6 +2099,18 @@ ObjectProperty *object_property_add_uint32_ptr(Object *obj, const char *name,
                                     const uint32_t *v,
                                     ObjectPropertyFlags flags);
 
+/**
+ * object_class_property_add_uint32_ptr:
+ * @klass: the object class to add a property to
+ * @name: the name of the property
+ * @v: pointer to value
+ * @flags: bitwise-or'd ObjectPropertyFlags
+ *
+ * Add an integer property in memory.  This function will add a
+ * property of type 'uint32'.
+ *
+ * Returns: The newly added property on success, or %NULL on failure.
+ */
 ObjectProperty *object_class_property_add_uint32_ptr(ObjectClass *klass,
                                           const char *name,
                                           const uint32_t *v,
@@ -2019,6 +2132,18 @@ ObjectProperty *object_property_add_uint64_ptr(Object *obj, const char *name,
                                     const uint64_t *v,
                                     ObjectPropertyFlags flags);
 
+/**
+ * object_class_property_add_uint64_ptr:
+ * @klass: the object class to add a property to
+ * @name: the name of the property
+ * @v: pointer to value
+ * @flags: bitwise-or'd ObjectPropertyFlags
+ *
+ * Add an integer property in memory.  This function will add a
+ * property of type 'uint64'.
+ *
+ * Returns: The newly added property on success, or %NULL on failure.
+ */
 ObjectProperty *object_class_property_add_uint64_ptr(ObjectClass *klass,
                                           const char *name,
                                           const uint64_t *v,
@@ -2075,6 +2200,17 @@ ObjectProperty *object_property_add_const_link(Object *obj, const char *name,
  */
 void object_property_set_description(Object *obj, const char *name,
                                      const char *description);
+
+/**
+ * object_class_property_set_description:
+ * @klass: the object class owning the property
+ * @name: the name of the property
+ * @description: the description of the property on the object
+ *
+ * Set an object property's description.
+ *
+ * Returns: %true on success, %false on failure.
+ */
 void object_class_property_set_description(ObjectClass *klass, const char *name,
                                            const char *description);
 
-- 
2.43.0


