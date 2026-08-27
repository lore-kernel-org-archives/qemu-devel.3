Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83CA7C61DB9
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 14:34:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzbBS-0007sF-BB; Thu, 27 Aug 2026 10:34:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wzbBR-0007re-6e
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 10:34:25 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wzbBP-0001yw-CJ
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 10:34:24 -0400
Received: from pps.filterd (m0127840.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67RE9wNr3909899
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 07:34:22 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=hC8MH7H8dLrMEt+6whkZK3e563bbVs2wNInp+Lt0w
 cw=; b=vR9ODuK4dt5E60LDFO9zaxGeCfhPPzoqf3uzDUjSF7Tt37gv4Yw1igXu0
 jX5iXGpopYPV1H7o/Icay2LL01lGNpiu4daYYw/dwfHcFz+Mmenq7vHBe49FlpAt
 WHKMjxyp3UaDIF5HgHjdKKXiTjH0uo+LqXISbJPNS4i5pCfh6uX3lu6ym5wIFNVo
 BQlbxDFJj7KCGW136a25bUdR/n0Wntf5zPC6rKfBi2MaVLoYgUPY3OZKCC7E7goi
 ogxycKJLMKFto0ZAsE5PxiadjWoUP47Y9e9qBgkG9frcfRxoR9clCjDZJCnwIZGX
 QN5o9YhJQPWNY7JYyWyZhxgU0rY0Q==
Received: from sj2pr03cu001.outbound.protection.outlook.com
 (mail-westusazon11022123.outbound.protection.outlook.com [52.101.43.123])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4g9fmmwkf6-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 07:34:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=io6haoq9e4QlB6bgM9jy+XDGXR4XzDHiDgGru0mWdzmcF0O05jLyDYncAqGBEF9H5SkrrZe4W8r2ckmDQ/QALiZk95pO3rwrip7EAKViElaLBcGOCI5QT0p/mp0lenj6vk/tSsJXMZ44mQfwZ2gEhiXMlpkX9gtJ6cBovwCU0HH9KxBPxHAoiRpeGdaNXvb7fVVdyCsvBIKi7s9UmX/CcE5DxyHPGnizaavZfsIa4zaHNtwTMAbT8r6UZ540+i2lzVxKIurSMHHiTcSh5GLFmMySY7jOlYUNcns4p/i9yyWhuGbJPhCRlvwe60wvY9r6vAAyHyfY1/nYVfzF0mFOcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hC8MH7H8dLrMEt+6whkZK3e563bbVs2wNInp+Lt0wcw=;
 b=CPzi+BtYYx4wwBERx8rreR77+avT9S2FnHJz6yNMqOyQOjSp3GpTyxd777Enyko888GJ752I4g98Ss+OnYc8o5255kXVs+xojZydaUQlbVT4D5gHuF7cmIGsTNQNnhudb2UGKmpLOBDfKtpudWnPOKz5XNiW7RrTBelMWLLniqdr9ZpMWbiExzX+rk00s8CQLOCtRfukaooSMKJNQ1Udr+4hwY32V5JQDzpv06Ib3ILVC93qnxkpvA8NThXmVTIxAJkqildyNHrLbKexWKxwT+xWgP6i2o1S0E715fEoCxn/oHqVp6iYk3h+8YUDI++89+vgOm+8zTYwQrHqZ93mdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hC8MH7H8dLrMEt+6whkZK3e563bbVs2wNInp+Lt0wcw=;
 b=rZdhRVcEDXfDKwlL8ncKyPIz4ww3LjxFXtoA5vKShzS7eEqn9yoF0ZXt+woayBF0V8ZrTTT9kS97zvqWR4iWDOjK5fVyC8AHWgURH/jNLcC+3jQIy839zH+Esh87atnX+JvqKS0v5xV98ZzmgDhaMGILCy7PVycZcNc5fWRMetYZ9mHULiqTrs4wujjZPMr2oKylVHTN8drvntxcM6sEbiL2L/XztMpcUJ4vZQZFL0U6WbOyLOBxgqHU0Cl9C9dbG0CLkHOcd2HO4OgqUx3C/qh4q8emkGTCttg2A6wmh/cBXwrZCfzqRv6AghciHza33vMdXw5nBUrAeIGX3OotQA==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by BL3PR02MB8114.namprd02.prod.outlook.com (2603:10b6:208:35d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.10; Thu, 27 Aug
 2026 14:34:20 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%3]) with mapi id 15.21.0360.008; Thu, 27 Aug 2026
 14:34:20 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: qemu-devel@nongnu.org
Subject: [PULL 04/16] qom/object.c: add object_class_property_add_uint8_ptr()
Date: Thu, 27 Aug 2026 15:33:25 +0100
Message-ID: <20260827143404.1393166-5-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260827143404.1393166-1-mark.caveayland@nutanix.com>
References: <20260827143404.1393166-1-mark.caveayland@nutanix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA9PR11CA0009.namprd11.prod.outlook.com
 (2603:10b6:806:6e::14) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|BL3PR02MB8114:EE_
X-MS-Office365-Filtering-Correlation-Id: 4429d02a-b601-4e97-bb0d-08df044847d0
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|366016|10067099003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 1eVaNVomar6rGy6OstIzHuneAU2v13mHVFf8LpPs0LJCptwCkznw6dcyrofDH/qjL8hqO5d+K3W/Y7tW3yuV0ZfN0vI5qJMg48AXEQW5GSOnIGF4zTxX9kukRHaXKXy6lPQuMGmuXZDum5/trnQq3vBSmlKvhYJ/wNsx42IWqoKcuvuMrZYgBckkxVYhZ3GIx2kEIImJ/L2cpuhdXj56dbYyPyvqzE9Aqtw66Ri8JQ2EmQ3HXqwcskRkv9TtFLzn/fiY1OaD6n/hTlBf0hNABCWxijRV5jVmKr1MPor356c+qOd0MAapgT3brWiFG627+sEg5dNcY2w3SmqdDrLQSSJa9R9hDyu6pkdrQKYeSH8YNlEgwVnzoKwYz1hyJ3FlUIfV6g7frnovOPkaBkcC+7fQvQ1nbzQH90PPTsiRxoE0CMnPB2tep8w3QtjJCYCfMUPGE69hLdKhyruieMXFmtrDmzeqWLw6+bCOZxO/QWx92h0EYrkLFMjRUmgD7pdT1WjZzJotJZJYnaMGLIa0eSyYHLTZsG9vK0bfwDqMMwfi8JJYGZtdMGngeQRZntlMNv6B5Jm3BLg0ZzbEWl16GVPBsleJN+OjGvLVPDVtQOGERTnXreiwG/OqEOfudihKOfNm34Hm4vQaZpcjAWkOOSUPH/+IPzvH8HHweqYvvJ0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(10067099003)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eWxMbU9rTmhzS3ZBOHZjVmZKcnAzS2Y0eE82Y0dQT1VXOWFXWGFMT2VRdHY5?=
 =?utf-8?B?c0h4NzhJcjRVaDRvMHlkSVRGWUw4TWlhUEN5ai91SnJBSW9hQVl0QkplTHZT?=
 =?utf-8?B?MnV0K3RqZzVYcTE1RElQMmxSYzJzdzdvalhMaGdweTZqcnY0QktJR2ZVZUx3?=
 =?utf-8?B?czk1MG95K0I0SmJqcHBKcnNTRm5pald5K3Z6eVI1S1MxVTUwS2I3Z2hHaG5z?=
 =?utf-8?B?SG92VXMrN1JuMS9rU25kTjdqSi9LMmc3eXdSM1c0bDFMb0ZZLzA4MzNaSUNT?=
 =?utf-8?B?RG9GVXBSZFhiUXNHMllkZk5mNFJYekxielNTY2dWcWtjME02RjZhRVMvckFN?=
 =?utf-8?B?cU0xcEtOMWtvenJlU1hUQWxGaTB4MzdBaXlWVTdUc1hHdzZEc1BQRDdHWnoy?=
 =?utf-8?B?SUx4aWhnaXpmbVBtdERCVTZGcWJra3MrY3BLQ0QzS0hpWHdqa0ErZUhwQ0Iw?=
 =?utf-8?B?TEtaUGR0M1NwUlNDTEswYkJEQ0ZSSHBoc3IrK1BaVitVK0p6azlxRjg3YUVJ?=
 =?utf-8?B?cmJ6UThWNUpJZ2NmcUxTVG0xUlRpeFplV2swZlpGR0gxVzhES3A4bUtBdENI?=
 =?utf-8?B?aXRTLzdHY2JvZzBSbncreU9DL3VFTGNjSmJTOUI4UkNXcEZCZGhSMmdMdE12?=
 =?utf-8?B?dEtJSHFQNC85MGdEaitaT1IxSzE1aENMTWJhV2F3VTdBTXZYYVA2alVySTFi?=
 =?utf-8?B?ZXlBbmx4NFJ6b0twZmkreHRTQTlzZ1QzL1NTV21BWk5ZNGc4RGptMkYySkl3?=
 =?utf-8?B?TmV1dXhBdkxtSC92QjhoTERuNk95Ui9ESjZBbnZGU09BWk81Q2p0cjhCa2Jq?=
 =?utf-8?B?M1BlREhiY2FYaHh0N1NCTis5Y2RsZmhUaGpsSkQ3TXY5WmN5STA4S004MER0?=
 =?utf-8?B?UjQvR21QeXlNYmdBYTB4RVV5NzVna3BZNVI3LyszSlRwUmhEbmVMazAyWEhD?=
 =?utf-8?B?V0Z4WkxFMU1IeVpiS1RsNjZXTzBqMDhaYmNLK0ZBM2dwZ0FFSG1JU1pXQ1Rq?=
 =?utf-8?B?ZDFUbTkzc0N6MHk1STZ0N3A5TjJDSDlSWnZySnVRSGpoeWFtcEQ4LzB2Ujk2?=
 =?utf-8?B?aWl3OHFCczd0TmhqdDlic3E2bmxuemhTb2lYbG1aUmhJbzM1R3lRYTJTbXNh?=
 =?utf-8?B?WFduWEROSGE1QmdjTWRlQzBMandxNnFMT09MdXRxaUxIRFQvYzFIT0JNVERJ?=
 =?utf-8?B?V20xTmYvcVRoL2I1TVdSZTA2QVVWL1F1WEE0WWJmTVlMdVc5a0dteTcwQWRE?=
 =?utf-8?B?MFlZY0ZqeGd6K0dlNDV6WlJlNFBPTGN2dzFXcDhvcVpxL0JOY0tRSnpoOHl3?=
 =?utf-8?B?VDFrQy8rZytkYnBSRXRpYnZ6cUI3aVRYS3BBL2lHaHo4QS9yZFgxanBuRVg2?=
 =?utf-8?B?RE5kc09MVDRBZzJhcVY4UUZDNlA3L1hkc2EvVGdIeVlOai9rK3RZMW1lNk04?=
 =?utf-8?B?L1E1TkJJSjdGNDNKNmoyR3dCb0NiVE1ZVkVIRlpiNGhPbUxjd2VlamlGWlVx?=
 =?utf-8?B?TVpwL1p3aDdWQzJWVUdJUkMxcURLNUIveW5ZOXZhL0pSbW1FTEtzUmpsZ2x0?=
 =?utf-8?B?VkxDRzR2bFREeEx1M1orbWVCZm1MTFhxTGpxOVU1Nm0zY2QxdncvSU56Z0Uy?=
 =?utf-8?B?bXZkMCtZOS9HbkEvNHVzTG5paXA3aHZZTzVBMGRXWjYwcE9LZDJsdllxSFBx?=
 =?utf-8?B?QU82T1lGUE5MNnlRb0lQUXl1LzMzS1ZYcHdZYVZiYnRqd0YydlRMOEc0bXZN?=
 =?utf-8?B?RHB3NURIWVBNcTBEUkxRdWpQc2pCZ3dpRlNXbVJVb1MvRmNBUWRYSUZTcEFv?=
 =?utf-8?B?MVQzeldvT3didVNkTWdtZWRvSTNVM2YvemlwQ2llU0h5ODhseXB0UXFLQzhz?=
 =?utf-8?B?N2EyVFFVTmFRcXNpWVArNVdXOTBwMGh5bnpZZUkyYzNrYit4ZEpLUUUrOUhT?=
 =?utf-8?B?bDN6WlE0cDEwNkovWFY0OS9qNFZSM2d6Vmdzb3BUdnJhWlZIR1I2aUx5bmZr?=
 =?utf-8?B?VG02UFN2MWdtUDhMbFUwMVNiSDAxWU1rbXJzOC9FM3NGK3hDcmRZTG45dFVR?=
 =?utf-8?B?aG9XNWF6Y3NHNExuZFpockc3Ry9HSERLTzBKZ0p3aktkRE5TOVJGS3NZcis2?=
 =?utf-8?B?dW1tN3JHeWVCQUltMjR6dVdEaGJKdEtLaklkODBZVHNKczk4cGJxWlgyTCtz?=
 =?utf-8?B?TmdlSGdZWVB4V0R0UDNUSUZ6Q3MzWWp5eThqb1VyQlpLSGFPTXNBZzZ1Y0M2?=
 =?utf-8?B?TFRCc0RBSWJYZmI3dlB6TVpnSlByUks3bExzYkxZdEUvZUx3WTQxM3BGYXBT?=
 =?utf-8?B?b1o5dlUxMU83d3htRkRjdWw4aGQ4ZjNCbVlaeHFMK0FYVmxXV2ZTejA0MEh6?=
 =?utf-8?Q?/DssR+KgqFg3qv5Y=3D?=
X-Exchange-RoutingPolicyChecked: KOnjXubu3xLEEej+Bv82LZs7hmAtdSY9kJdyPDx0tLTGik6lsN415qnBTb+dsmwONJIWnhyVSIQi90fS4FT0FL5K+gfeA++5VpIqxSuX6hUTn39jMR7s8eEWYKlkkE+s5cZKQOGOnSHxDqnqU6uia7mB/uHppGbJ13Ji4zS/q0D295+otMRq3gGHWeavjH0TbymQsQ5c5HtWF72JQZl5KMC4LoRr9WJA0TM3BwGey7vkWE2UT4dM3MSlgCzZx73avBqEa4at/2ZRVmILzbcDR9CTiuhMI66+mWGw6k2ay2DJbxBagibYlhhrQq2gD/0Q4xTeKGlUMOH9RThGinw1Mg==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4429d02a-b601-4e97-bb0d-08df044847d0
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2026 14:34:20.0672 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wy9zAtVkm/N0/r5Acz2THTTZLkNHgqOgw4UvX3qzz7OV7Z90hAKKX3bEFKpd8fgGUn/TV5XbMRL7wfNQjs3G6RIJypJWHvN7Vy2dKYsSuvk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR02MB8114
X-Authority-Analysis: v=2.4 cv=GagnWwXL c=1 sm=1 tr=0 ts=6a904aed cx=c_pps
 a=0vj9JdGoO5ZFtW877mlItg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=_-M8LpHI31CeLmyZm6wg:22
 a=64Cc0HZtAAAA:8 a=20KFwNOVAAAA:8 a=4QfE8SPBBHYfMhEiUa4A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDEyMiBTYWx0ZWRfX4Rnarx+n7GSS
 H7CdNKX789AKhGT3Kt6YqNT2jNBRbYWz9V5OxjCzRt4GSX2C01mP49WUTu0b0RV8GSiaeZRAY6i
 ZIlcnbk/zjFLlebDlxd4WEMZimmmVGo=
X-Proofpoint-ORIG-GUID: JLwbbQhZa35y0tuxAAVyIP5K_Bfq4CSq
X-Proofpoint-GUID: JLwbbQhZa35y0tuxAAVyIP5K_Bfq4CSq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDEyMiBTYWx0ZWRfX9B6t5XqGNrPY
 Mg0y2c8SSQCTLbOJESKsceibCHHl4vaRARQtBTWnPu0Oi6R5IYsfMpA/fOOgIqc2Khh0y0Adwl5
 KZWMjudnZN1xWpBdKHkVCf50GPs94FZgH02sB9mVEcMsgqWs6W9+TtyMvGMg0nS8VJshaQTv5PU
 d42L1UtZAbidm9pQvtsRskDbWuffLpRQcDfJeVJg3ppm6uCJcls5hf47Su18VPvgrK4bqs7iPlv
 CyPaGFkE1m/zGyvQbe+xez5NrtSgJfjPeIVKX3mFH34F6mjmxrMyQe6SFAE7lkNdZllktw8eoi6
 JF880c3+ulMUkJDhTrUCJIs8h9pjfRt/eqaa9S9oPvZBlQ9w/uPGs/O/5ybaHHNcQaZONNFDIFt
 Q4UfYXPuPo5iSfRQuMIjSlPAUY79zLkGD44tEd9P/8gndoWoqtW6GNQmRpWlFHql5bg9i/CjlMV
 ZAxGc63D+2ZipnB28RA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_05,2026-08-27_01,2025-10-01_01
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

This adds a class property that references a uint8_t within the object instance
and is intended to be a replacement for object_property_add_uint8_ptr().

This commit also removes the __attribute__((unused)) annotation from
object_class_prop_ptr() which is no longer required now that the previous defined
DEFINE_OBJECT_CLASS_PROPERTY_SCALAR_METHODS() is now being used.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Message-Id: <20260825134320.1039012-5-mark.caveayland@nutanix.com>
---
 include/qom/object.h | 18 ++++++++++++++++++
 qom/object.c         | 23 ++++++++++++++++++++++-
 2 files changed, 40 insertions(+), 1 deletion(-)

diff --git a/include/qom/object.h b/include/qom/object.h
index 11b1c9d2dc..eba675d218 100644
--- a/include/qom/object.h
+++ b/include/qom/object.h
@@ -2033,6 +2033,24 @@ ObjectProperty *object_property_add_uint8_ptr(Object *obj, const char *name,
                                               const uint8_t *v,
                                               ObjectPropertyFlags flags);
 
+/**
+ * object_class_property_add_uint8_ptr:
+ * @klass: the object class to add a property to
+ * @name: the name of the property
+ * @offset: the offset from the object instance where the uint8 value is
+ *   stored
+ * @flags: bitwise-or'd ObjectPropertyFlags
+ *
+ * Add an integer property in memory.  This function will add a
+ * property of type 'uint8'.
+ *
+ * Returns: The newly added property on success, or %NULL on failure.
+ */
+ObjectProperty *object_class_property_add_uint8_ptr(ObjectClass *klass,
+                                         const char *name,
+                                         ptrdiff_t offset,
+                                         ObjectPropertyFlags flags);
+
 /**
  * object_class_static_property_add_uint8_ptr:
  * @klass: the object class to add a static property to
diff --git a/qom/object.c b/qom/object.c
index 9cb2cae4a7..a480fdd400 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -2703,7 +2703,6 @@ DEFINE_OBJECT_PROPERTY_SCALAR_METHODS(uint64)
 #undef DEFINE_OBJECT_PROPERTY_SCALAR_METHODS
 
 
-__attribute__((unused))
 static void *object_class_prop_ptr(Object *obj, ptrdiff_t offset)
 {
     void *ptr = obj;
@@ -2742,6 +2741,8 @@ static void *object_class_prop_ptr(Object *obj, ptrdiff_t offset)
     OBJECT_CLASS_PROPERTY_SCALAR_GETTER(type) \
     OBJECT_CLASS_PROPERTY_SCALAR_SETTER(type)
 
+DEFINE_OBJECT_CLASS_PROPERTY_SCALAR_METHODS(uint8)
+
 #undef OBJECT_CLASS_PROPERTY_SCALAR_GETTER
 #undef OBJECT_CLASS_PROPERTY_SCALAR_SETTER
 #undef DEFINE_OBJECT_CLASS_PROPERTY_SCALAR_METHODS
@@ -2767,6 +2768,26 @@ object_property_add_uint8_ptr(Object *obj, const char *name,
                                getter, setter, NULL, (void *)v);
 }
 
+ObjectProperty *
+object_class_property_add_uint8_ptr(ObjectClass *klass, const char *name,
+                                    ptrdiff_t offset,
+                                    ObjectPropertyFlags flags)
+{
+    ObjectPropertyAccessor *getter = NULL;
+    ObjectPropertyAccessor *setter = NULL;
+
+    if ((flags & OBJ_PROP_FLAG_READ) == OBJ_PROP_FLAG_READ) {
+        getter = property_class_get_uint8_ptr;
+    }
+
+    if ((flags & OBJ_PROP_FLAG_WRITE) == OBJ_PROP_FLAG_WRITE) {
+        setter = property_class_set_uint8_ptr;
+    }
+
+    return object_class_property_add(klass, name, "uint8",
+                                     getter, setter, NULL, (void *)offset);
+}
+
 ObjectProperty *
 object_class_static_property_add_uint8_ptr(ObjectClass *klass,
                                            const char *name,
-- 
2.43.0


