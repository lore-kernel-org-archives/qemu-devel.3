Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABC3DCCF2E4
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2026 12:09:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIm87-0000Lb-Ft; Mon, 19 Oct 2026 08:06:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1xIm7o-0000A2-Ke
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 08:06:01 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1xIm7f-00043V-QW
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 08:05:51 -0400
Received: from pps.filterd (m0127844.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69J8P1Sl3073472; Mon, 19 Oct 2026 05:05:42 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=YGZ6jjLz+ak7jj7H3A1G8RT83dDt2Z6yz4mqrp8m0
 xw=; b=slY2JDdHiyb6U1I08LRdy1Iae6Z8aJZWQKVZMD/8qSSn9yKf2RnrPfPE3
 NFHySu/11fY+1cB5fK0gc2j5nxQXS8jieXllcIUxgkSDlHjDKwUqnbdx7uQi2YVs
 6Q9B3DpfRg0YH4Wl6iPqo7JATMiwKh5Ucr6x6XYTYxcpbgFNly7UWDAoT3EcI9wF
 4PcIG9lZ+0orOFgk82JGI7cHXVmX/Yv9EdwWlzo3GpZm3lmFwgO8KV55jRbgO2Dj
 nvwI5PxvfRlkEh0T9qsUC3sfakahKgP/Ci9bvCfb4VAu1kPzkLbJt12qgyjQNWI8
 1NXZ068V31tbr9w12zkdKBQbAXXag==
Received: from sn4pr0501cu005.outbound.protection.outlook.com
 (mail-southcentralusazon11021126.outbound.protection.outlook.com
 [40.93.194.126])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4hc8hyuftb-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 19 Oct 2026 05:05:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vPNj01AzRtoXuhG+On1aEB2kxFymilYbAZJi1D+LO1Fxd5Wg8mrZhKZbIQf3bA1HJcZozpX4HlCgCBH64p9sL9ckO84zRDh5mO46qP43uDlW9tHORIvfx/NHdnP7DCDLRqcIqcXN1TrnPbCBGqUZUbGwqYi639mfbGkd00XUBAhNX3xK6ZPQGy4BhS6zwpPbb9ORa8ppH4agqnCycs+clZ2eC12xwLoEH9JBccxpM20Xblik+fZROBD5zbGH/G3f7C00xE2Tt9qB23x35WOEMZ8WQt0GqxapovJicCZgGWbfpdJqLOoSB5jc06gjJFbYLQF3ahrGsJc7bpgBMof5qQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YGZ6jjLz+ak7jj7H3A1G8RT83dDt2Z6yz4mqrp8m0xw=;
 b=waJC1IZyy59jfo/jwV/P7f8iBuZ2ksuRm0QH7TgIBAceg61f5f7vmW8arsbLglnLPakFsa0u6rDx41GuheBUOKEvCKy/g1Ej4z+vIboE0XuGT4u6nIUoPF24/+yYgVetPlr1NlHQqGA/Ou6kOiQa0n5r4paEkv/yQEZJvIm65vt7gdagMimrSHM1feCLLwBhMNODmRNlwNlCR2+X6JzbXqxsOh/CwR3lknf8QISRdJei9O3tQYmKPx27UXkKjqll5BxxzEt8/Pm33Tv9SaCDIh5paI9DD5EBzDmUpHrHbdfmlfs5yIwjKCg3STSh/YdVx1XWIBZBqwIsdfg5eSb4hQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YGZ6jjLz+ak7jj7H3A1G8RT83dDt2Z6yz4mqrp8m0xw=;
 b=mm3k/k94XsCKPKA5STHduOcppR8cMiScHOW+AsexHurJQS3Z0oo7iECVPin2InyvKp6ulhdk8qOwc2SHvAiYREh2ZjOSsGXXmIezMCjdcp020KEoeYNHncaSXdgtKTAxymUomMq9ElyfAdPfOspTayom4aeHpm1WaBAqzFkMbkO24kWbwCbQIwYpxQx6EZO9FlLFNfy+VaYzxVRZCVTVoWpxDgszKyd0sig0DWSg8msfYiAzE5zPa4C7QK8RaNr/GO5BGdvprqB08HQjCCRBjfuWpotH746rH03OAFEalxEUaS6aPZLTxEFUdDGlRW/3ZMeGqUFeLsRvTyyP8QfVdg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nutanix.com;
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by DSWPR02MB11441.namprd02.prod.outlook.com (2603:10b6:8:354::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Mon, 19 Oct
 2026 12:05:39 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%4]) with mapi id 15.21.0522.017; Mon, 19 Oct 2026
 12:05:39 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: pbonzini@redhat.com, richard.henderson@linaro.org, mst@redhat.com,
 sstabellini@kernel.org, anthony@xenproject.org,
 edgar.iglesias@gmail.com, qemu-devel@nongnu.org,
 xen-devel@lists.xenproject.org
Subject: [PATCH v3 06/28] i8259.c: introduce TYPE_I8259 device
Date: Mon, 19 Oct 2026 13:04:38 +0100
Message-ID: <20261019120517.1448687-7-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261019120517.1448687-1-mark.caveayland@nutanix.com>
References: <20261019120517.1448687-1-mark.caveayland@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ2PR07CA0002.namprd07.prod.outlook.com
 (2603:10b6:a03:505::25) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|DSWPR02MB11441:EE_
X-MS-Office365-Filtering-Correlation-Id: 525295ea-35f0-4e80-d9e7-08df2dd94aca
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|366016|22082099003|18002099003|3023799007|10067099003|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info: kB8zqPCyQbbDY4eNX0IA4ddah9A5qwuwBjW6te3PSRcAf5ZXKb2lCvpsttnaNyiHNUGLo4GroIbiqYlB1H6XDeL0hnpJEGBlrbWUmc7br/SaJvxK4F/5aAI2/k0r1+Y4ofMoOfD6ZKDs7pbcoHdMH8c+0oOd0W9f5fyz9JmqJ7fh3+w980WiKTibnGARJDzalM3zxsIYzZF39wRScibKCctKeny/WGBEiev6NUGKJS1Ussk8Ika6RGt5lTny6eHhes2dcHmFTO4EyfXdkchTAjFyivg1gLvO7k22ACHm57k6y1Ys+SibVPYda24FfeFcJEBexcEz8YkckWk+MwfrpS8L15E1Y95vVo4GexsvVYYd2dON9Ky0x8iqQhBTnBkjGbBM3N4WLp5t8k5suZ+2EF5y7nzDU+QRL5UYALutHGtmq7lix+o+Y+CUMWXDMZ6r18UyqaFDKFKnsC6L/rBdnEq4J4Y8m/0RwT39dezlEZi0ZhmYgXCL5muX9Xb0CBfet7wmYQqSEejnm1GMB+aVO2wkd/Z2EgpuojiIbYinJwvb3j8Q+Nu9lBNWLA2i8YxQjVcJhJDJyj7s4bbOqMe/QlMtMRtxnHAu2X/5mtQMeW6oiRd7rzOtiUEy4UsAcS7b4PILeKruRwM81Gm3seDPI9hAwVeEul8gO5VXUz/yb4U=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(22082099003)(18002099003)(3023799007)(10067099003)(261009223027099003)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Lmxka98ceNDtdqTcSShLiyaH0jyrryvWY6J6K3hZ+34wn54nFoCiCCl4ZAAw?=
 =?us-ascii?Q?VY2ac6BoO+pkUzIZWAcY/T2td1Fy+uQsD3ONPaxs1nvqt1oXlNWdOhfrF0k3?=
 =?us-ascii?Q?P1BSL2xd4oX+fSw3+efHlZS6cgftTigeNjV5ytXVZbYUmY3CfmSbdKiLiK5l?=
 =?us-ascii?Q?LSllk7wJTlQq0JH9/jyslVKSLRemaKg1SW8Col03IuqJFnn3clMwa99Y3LyK?=
 =?us-ascii?Q?2s/GyiGdxwNC3BsYUlaoZFMNFnq9z+fKkmqAUGtGLdJBq8C9U6qc+fPL4vLA?=
 =?us-ascii?Q?7LsUbATvdKfzM64uho08WVE2LqwIiVtl+nfBn1QUYSBppyqxpcDaJh705PhR?=
 =?us-ascii?Q?yHNJkqqjLf4aMw8bdIohspNonIER7vmcDrO9MPJ2E/9l0Y0Hq9c4OShE8L1X?=
 =?us-ascii?Q?QAMAYv3gTcHzs5pPeMzh7Wo7596FEJIapur5IknKgCa8Eb7d7A3g/LV06mWf?=
 =?us-ascii?Q?hIvbKtlekFjDBm9c0ZeeSfVkZopVVmUYJDbCdiy9fBq29SgPwM9o8E1YVauF?=
 =?us-ascii?Q?d3ygB9cS2PztJdhiz0FbHwZomm9jtRUBc8ByHjCYuZBVGmHQEB7PmKLnFKy1?=
 =?us-ascii?Q?HxTVnyoijQo3HUdzm4yXI81p3sibU76D6xtX17BBpaRYQoqg1TZVIif0ku8G?=
 =?us-ascii?Q?q9tKqsfP0AhJmfp0rCmWHnN8LLIk6SFYaS6EosSFoqBp+oofhv9Y4HkJPY6Q?=
 =?us-ascii?Q?+9iod+0mrUpaHN1ZoNFvhQQIQXRz0AZEIYd+6ta2oQHbhtuPgpuJrZ3+YS8+?=
 =?us-ascii?Q?/1pbObY6T4W2j9MCrlgoTjmIHZo/afiORrTbs5wkluxnSn7J96VN9dvgygRw?=
 =?us-ascii?Q?ng6XZy1kWimYerouQeT5EBWcaF16RqufUviDqpKJlZBjjJVSF5U/m9xY6jTP?=
 =?us-ascii?Q?UUITgTsGOOhqQGhOiTFT6MdyKbVnv2Z9RUFOVvHhIX96TMp12tSOx477bP5E?=
 =?us-ascii?Q?W0a4KLuphqbU2BI1Q5nygGYO5aJ7MvO+5vhu1OPnlxSrl8M5HbIF5UnJEaiX?=
 =?us-ascii?Q?EqUlPyEpFCdp5UxTv+WP2g1epDAHfr4cStzlh27fBEqqSOcu+HRgDV5vygnA?=
 =?us-ascii?Q?NO4+Z7ERarNyiXPYhbGK7/4d2TwrZyVzx7oZdvJ/HZGrS8t2gMC+tQV6Kpsc?=
 =?us-ascii?Q?U2l+FAurhK6/G3/5unDLR+j9HC6kv53p270fp0qVE0JpRWgLDMXZ6VSDuDg+?=
 =?us-ascii?Q?+OStdJnJ+Ws5UHH9p79mXSZUExKh/9OV33Qgz8BWRUIxNDJuRbRwHoTWoD8o?=
 =?us-ascii?Q?oOFl9P7WJFmMBIIY4fV701xOOrqAAE3PJfMr5CmW0OozW0U3ZMc43xadC58Q?=
 =?us-ascii?Q?U9PO0h29RwscT0KyGWC86Ew6hCWUsQ1j7x4DXE8NCu3Hn+jd5TtT9fGp/VL6?=
 =?us-ascii?Q?OLegDnO1tn/x53qKi/aX7uVzwsmXS2XAtB+0WEjjdTM7B/VeIW9UXRKD/kO+?=
 =?us-ascii?Q?gXmszt/M1h4A5Uc3f0GJxbyLXoWtD4iLNJGEMW7FAMPHX/rB/SGBSdIQSABa?=
 =?us-ascii?Q?Oug43E8u7ROEGO4xUsI7KvybgFJgokpjOydL+BF1k7meZnxsKBzYxCWA6nVW?=
 =?us-ascii?Q?/0wn45XNckoYBC2QM5x5iIfZ3nWiwbbugafyLCdkLVpZjxq7p5Sv0CqHH3cF?=
 =?us-ascii?Q?mOb9WK5ArP4BcFuQsRYeCfW7y63AdyiPJbxelNSOf1lcHKafqt+fEE+itbL/?=
 =?us-ascii?Q?d0NnCm68tUQ73FHH/RULT3OGXMjhITvBKd2jcfxncfDOzGT4kofkKQEVPOqU?=
 =?us-ascii?Q?pBXXT+A8naChHvy51p+NBbGrTnFujhQ=3D?=
X-Exchange-RoutingPolicyChecked: DbHCi4orR44/yv9P3Lfd0WDTgEKEztu4hoczghI9RvHDco/3l02LtvILnb4M6wuselegc475ezCo9Ku/J74Jj5nMFRTfdHepp56k1RIIDShzEfOLdMf4cUaKfwIjSvgtxjBIjgtHYNOFEgOiGvdp5ATgqOBx9mB3NolMIH7iuPnsAesU9KCMlee7v7XiKMg9Ct2HFJRZYJkBfTOY4SRi43EIVodVZVuppHm5jicVkwkZL2OVp4rg8f5RnefLoxphCpBOr4zKWvmdpBKsE2oBaIEteKogsa7H1gwe+jTUt27M4krknakCigb4RZeyNI+0X66AKXYqnfAWbCCnb84XgQ==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 525295ea-35f0-4e80-d9e7-08df2dd94aca
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2026 12:05:39.8148 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0CUHHnzwDBRch3z3tIQrntSsVJSk3xqBp/ColQt6ScJ9EzQBBwdA3g66kpuFoS6rXGinKTDAzc350i+vONxl0GVeJQp4n7zTOWzIhQCbzpM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSWPR02MB11441
X-Proofpoint-GUID: fETJ6sWnMpPBljEfzz3tQAM_5PC1jssB
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDA0OCBTYWx0ZWRfX37I1KdVv1TnN
 QKt88BesoLwIHscQIENzPILP5H4j8lRDl/KX4fXlLRQ/ulC9WtwrCXqz6fRWUf2klXwIvJrykvA
 Oxsn5NZZ/IIhKmtbR/RyEsDLhsYaWfI=
X-Authority-Analysis: v=2.4 cv=E71YNqdl c=1 sm=1 tr=0 ts=6ad60795 cx=c_pps
 a=JUKW06bhoGHkwkYQWyoyLA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=660iZSQnnn4A:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=0LlEyIVc8U2lsR7dKhuH:22
 a=64Cc0HZtAAAA:8 a=KKAkSRfTAAAA:8 a=RO_YwWr2CJXTu7lAkVcA:9
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDA0OCBTYWx0ZWRfXyoVAkzyzjvOr
 8otQFT8X8+ezDSLsr2T5j8C1/nUKtJTr3Yz3B2GY1R9gaEwO3zldOJFZvIpVQYwl9pQ9tfgRCNy
 Xm5onV6sbidBfYF8ZuWYv2ICgK1XnFtRcPLux4uv2ZAORpPFlleftyvnhmPoHPyOcDTlhhOkIWE
 Fzts3e7quoRg/yUL380vRmZAstNCuP23OkoTvcgj9vpmsDL4K0eg1oknZuoXwUe6ScnW2EriavL
 lzNhAXAL1XxRzt4hTviPJJ0s9/ZGNu/LVqOyfRb4x6Yn9SGz/wt2t7HDKrmVVkTFWCvuJLY9A2X
 SyLNXFHYSTGc+fPwqhmFG0eEZtnQx22czakIGhqAOXBESb1v8afjTHCYou8OFVTcNAQMKUgSslP
 hVrN2RgVxOcMMm/4HCKw1X683IZvlbIq4Dq+oiAs01gLyCHD2Fqui4BIYs5H890upkra6DCWWEC
 YM1KC/xzffLcv2pXiNA==
X-Proofpoint-ORIG-GUID: fETJ6sWnMpPBljEfzz3tQAM_5PC1jssB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_03,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.329,
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

This device represents a single emulated 8259 PIC and its associated class and
ensures that we can safely embed the device within a container device.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/intc/i8259.h |  8 ++++----
 hw/intc/i8259.c         | 33 +++++++++++++++++++--------------
 2 files changed, 23 insertions(+), 18 deletions(-)

diff --git a/include/hw/intc/i8259.h b/include/hw/intc/i8259.h
index 1921a30371..87ccd55a4d 100644
--- a/include/hw/intc/i8259.h
+++ b/include/hw/intc/i8259.h
@@ -3,9 +3,9 @@
 
 /* i8259.c */
 
-typedef struct I8259CommonState I8259CommonState;
+typedef struct I8259State I8259State;
 
-extern I8259CommonState *isa_pic;
+extern I8259State *isa_pic;
 
 /*
  * i8259_init()
@@ -16,7 +16,7 @@ extern I8259CommonState *isa_pic;
  */
 qemu_irq *i8259_init(ISABus *bus, qemu_irq parent_irq_in);
 qemu_irq *kvm_i8259_init(ISABus *bus);
-int pic_get_output(I8259CommonState *s);
-int pic_read_irq(I8259CommonState *s);
+int pic_get_output(I8259State *s);
+int pic_read_irq(I8259State *s);
 
 #endif
diff --git a/hw/intc/i8259.c b/hw/intc/i8259.c
index 856075a754..81827f2734 100644
--- a/hw/intc/i8259.c
+++ b/hw/intc/i8259.c
@@ -35,9 +35,11 @@
 /*#define DEBUG_IRQ_LATENCY*/
 
 #define TYPE_I8259 "isa-i8259"
-typedef struct I8259Class I8259Class;
-DECLARE_CLASS_CHECKERS(I8259Class, I8259,
-                       TYPE_I8259)
+OBJECT_DECLARE_TYPE(I8259State, I8259Class, I8259)
+
+struct I8259State {
+    I8259CommonState parent_obj;
+};
 
 /**
  * I8259Class:
@@ -52,7 +54,7 @@ struct I8259Class {
 #ifdef DEBUG_IRQ_LATENCY
 static int64_t irq_time[16];
 #endif
-I8259CommonState *isa_pic;
+I8259State *isa_pic;
 static I8259CommonState *slave_pic;
 
 /* return the highest priority found in mask (highest = smallest
@@ -170,11 +172,12 @@ static void pic_intack(I8259CommonState *s, int irq)
     pic_update_irq(s);
 }
 
-int pic_read_irq(I8259CommonState *s)
+int pic_read_irq(I8259State *s)
 {
+    I8259CommonState *cs = I8259_COMMON(s);
     int irq, intno;
 
-    irq = pic_get_irq(s);
+    irq = pic_get_irq(cs);
     if (irq >= 0) {
         int irq2;
 
@@ -187,16 +190,16 @@ int pic_read_irq(I8259CommonState *s)
                 irq2 = 7;
             }
             intno = slave_pic->irq_base + irq2;
-            pic_intack(s, irq);
+            pic_intack(cs, irq);
             irq = irq2 + 8;
         } else {
-            intno = s->irq_base + irq;
-            pic_intack(s, irq);
+            intno = cs->irq_base + irq;
+            pic_intack(cs, irq);
         }
     } else {
         /* spurious IRQ on host controller */
         irq = 7;
-        intno = s->irq_base + irq;
+        intno = cs->irq_base + irq;
     }
 
 #ifdef DEBUG_IRQ_LATENCY
@@ -348,9 +351,11 @@ static uint64_t pic_ioport_read(void *opaque, hwaddr addr,
     return ret;
 }
 
-int pic_get_output(I8259CommonState *s)
+int pic_get_output(I8259State *s)
 {
-    return (pic_get_irq(s) >= 0);
+    I8259CommonState *cs = I8259_COMMON(s);
+
+    return (pic_get_irq(cs) >= 0);
 }
 
 static void elcr_ioport_write(void *opaque, hwaddr addr,
@@ -418,7 +423,7 @@ qemu_irq *i8259_init(ISABus *bus, qemu_irq parent_irq_in)
         irq_set[i] = qdev_get_gpio_in(dev, i);
     }
 
-    isa_pic = I8259_COMMON(dev);
+    isa_pic = I8259(dev);
 
     isadev = i8259_init_chip(TYPE_I8259, bus, false);
     dev = DEVICE(isadev);
@@ -444,7 +449,7 @@ static void i8259_class_init(ObjectClass *klass, const void *data)
 
 static const TypeInfo i8259_info = {
     .name       = TYPE_I8259,
-    .instance_size = sizeof(I8259CommonState),
+    .instance_size = sizeof(I8259State),
     .parent     = TYPE_I8259_COMMON,
     .class_init = i8259_class_init,
     .class_size = sizeof(I8259Class),
-- 
2.43.0


