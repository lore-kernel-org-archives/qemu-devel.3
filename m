Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0D06C61DB9
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 14:35:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzbBt-0008Fi-Ql; Thu, 27 Aug 2026 10:34:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wzbBs-0008F7-Hx
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 10:34:52 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wzbBq-00021b-Kv
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 10:34:52 -0400
Received: from pps.filterd (m0127840.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67RE9u9e3909837
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 07:34:49 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=2nMeaB2FtHCvbEUV5YuIpZbhMfkuAyyQlKwYYxD9y
 FA=; b=04/ZK8VEYZD88R9IvkOX+KuovxYSoPnkORbsSjFrsDCusd2grG91/GU1z
 SLJgBmT8cdnNTtWp4Wf6cR9DjwJaEZHOYPr2V+QL/liZ9xfiStcQNDvgMnJAoXUc
 04+He5jJh3muXG9K507FhjsDmB/cPk50FOB+2aUWpkZlLq+dxJZojTyK0xYbP/ex
 pvJJ1shJQ+4JQf1P0mvkd+ye5n7PJ/s3Ium6jY2x9SjKHJ8Uoe+xQG5ENcMSm7i7
 xHIDNUc6HXCA4TKlSba4IPGFNuuqjNDSu15P1lOz+W5L5kxLYblXrgQtEDzNzPx0
 5CHjZ4ZiTtKwxuaLMZGE/LsrzZ8yQ==
Received: from bl2pr02cu003.outbound.protection.outlook.com
 (mail-eastusazon11021094.outbound.protection.outlook.com [52.101.52.94])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4g9fmmwkg2-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 07:34:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NTkRd5IN0ZPpqrZEyVQ7KnT89y93lGZI35cqDGVWdpTE6GNVo67yZMMvf9MkHQfLufrAvDz6TbNLbLvIDIValkIY555fM7iaQyysPJYrHxxTQgr0eg823zR8tza3sVi/+eU8qsPEKCVtc2m0LJkKK2ZiPleXojLHbYBk1NAFlV+EGT7n8c4j7DMY9XK56kjMQY5fJ/KQwA7iz/Xa8Ep56uMCeY5aArQ9zBIG3C/6aodz8cb/GqbERaYhk/hj8zManyy/bYxkO4W2LLEfXap8hyXr1b3yQKeaXk4OuUnp5flhcBHHhqjWW8UfksZZt5/QMhgmq762O/y/SqdQ+0CwMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2nMeaB2FtHCvbEUV5YuIpZbhMfkuAyyQlKwYYxD9yFA=;
 b=H3dFOZMnPIw4nGSLP5sLh8exa05o7MEOuKIohotZdYmp/MFZ3ZxhM0JPGTxwpCVIY5RkysL6AZVD/UsUrI8hNzbPDa3wyt2uiQlxscuacbMB381YsSr4Er4IRM2GQ8uQgVavUEwjgbD6TTSQ+xpHQCSNMyPfTvPf6vWDKZQ7lvhXaW2SrBF2rdBJUhmo+OwFgPz/oZ0uAwSCHShZglnSTXNblFtPHx5sUM8hsyXckmyHBH8WDm0uLn0EBiHfq3vadr80/nW40Hz27ug6Vvfrcy64VQjGygcJ+b6C3hNcW/e8/TeBFE+04c3fptVkC0sWfix8ceAusby4Pd+QY+YuCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2nMeaB2FtHCvbEUV5YuIpZbhMfkuAyyQlKwYYxD9yFA=;
 b=VJWR36hh3WInW2uLy0m31oiJ7Rx0Ssmy4fCdYV1JhQlD5hsQdSjqr92BOTrYSBetZI0GNQ0bAQqj7tr86KZSKCsEcw3ED0vKBn5qWABrHAoETYwq1s6/nlW/0GwVfj2Rx7xsaKYkpPQAdDr2r/EzKA8XweMojZLMGA5UkJPhqctHBLwYAVTasI/hixRhaChcAZneQy2d9RujcSU63vcEgTw2JPHVhp6Tep8oFFF56AjFBJrjAyQLm+a9F5qQBQMFPLCxZIrTYE/VxzvMI8o+ug4E0cP++g//CVk9nrhEZV2LSau4fI7ngqiw4hOZupaRZvpOeilwm2VFdExfh1FoBg==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by CY8PR02MB9251.namprd02.prod.outlook.com (2603:10b6:930:9e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.11; Thu, 27 Aug
 2026 14:34:44 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%3]) with mapi id 15.21.0360.008; Thu, 27 Aug 2026
 14:34:40 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: qemu-devel@nongnu.org
Subject: [PULL 10/16] qom/object.c: add object_class_property_add_bool_ptr()
Date: Thu, 27 Aug 2026 15:33:31 +0100
Message-ID: <20260827143404.1393166-11-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260827143404.1393166-1-mark.caveayland@nutanix.com>
References: <20260827143404.1393166-1-mark.caveayland@nutanix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA9PR13CA0125.namprd13.prod.outlook.com
 (2603:10b6:806:27::10) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|CY8PR02MB9251:EE_
X-MS-Office365-Filtering-Correlation-Id: c2f006ef-5112-4dd6-3d6f-08df04485441
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|23010399003|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 1crCM4C8G8XT90RPXsTCd6dFQQc31oPLgUlIT1l+rv64SStvDmMB2ssanKmKoT/yFwA/Fwe0Kl8RBDy6TXu7f+wN6FgbfmyiY7sZkOeXJ+dclrhur7b45e1p/70RfRApSR7/MJ/27hwHsNr6XZz6aVdKjqW3B8RH+/4T9aTFBh6r8//B9alcLjVvx5YXb48Z6n25irhptWwfoIvFaOem9YL4O7UV3j0pWZn/MjcK4RmBqRlC8Q9Y7H2ouNJc5Q3pJuHveWFNAU4EbrlxFX7hBhlfTfTxMDiQ5KxTYEV6urJOHwq1CM1v4KX6oUO2nkNv0v0FYImpb14LRTeHM95jsY/XUhebtESkDRGjzSCD1zLjLgByn9EpUKmeIT2SCjATffSQfv9LvWwkNCVvh4tba7bKjjwjONPoaTKzHgnApD3psdeW3fNcEBqNscpfwu+6dbxfyH3WcofP+9wQYhuTY9/S17cjfuciMETjWcWI13oxd7x7XkZYqkvvLotXiBrh/exYx4j3XoLqVI4PRvmnEKN0yiBgzrlWNar5TkSjNKH8Ig9NCdIHmDXrV9POnHTyLI5l29CQG3euY8MOqkiy8pHdbKOirbaEUjVsKuXnnTW8wnXVyHbnrIiLGTjP5VNyQ1865/5FX8N2mdQ6R3vdqUWz9KDW2/LlrXpRoNQ27uM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(56012099006)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eXZlU0RLTlgreDhlSmZhdWFQQ2ZvUTdibmp1Snczc0wvTTEzRlpkVTdVdUFJ?=
 =?utf-8?B?eDBLeDdtK0V1ZHRnRmVXN2kzVko2Nk9oMUVNaHhZNkFERkJ1ZEErRXAvVE0r?=
 =?utf-8?B?Y3NRcXpRYWxmS2RQamhhVThvdFdiZ1R1NDhWWGI5dXhoTWk2OG8wWmRGYTJx?=
 =?utf-8?B?Q2Z4NEZRUlBabFR6ZDNNd2F0TGJXRGxQTFkzbVBkYXhoR0ZCQ01YWU1uWGxF?=
 =?utf-8?B?YXFRSW1mTStuSjlRR0x6aTFKdU1naExqcDVheXV6UHozV1RvU2JxSU9rTlMy?=
 =?utf-8?B?TkI0OXdTYXdLRmg0bGlSdnlkSXVEMStnbEdVNFNJUGhDQ2x0bWQ5dUhlMnN1?=
 =?utf-8?B?SGdScU9mdk9uY3RMTk1UVk5ETnBWRkFCZ2lqT0hiMk0vWmV5VmZBVE9telhU?=
 =?utf-8?B?ZURmZHFmZzh1ZlV5azNmZFJKZGVVc3RmTi9WT3VUVVlvOHdHNkNnelQ5d2dv?=
 =?utf-8?B?SURlVGZQUWhxWHJsR2NqUHV4YlhQU0tLZXl6Q3FLU3d2cmE5L1NBdTQwcWd2?=
 =?utf-8?B?WEFXK2tIUk82UlVyUk8rSzF0OUVYNWNXcjNUWml0am1hVGp5MkxlVlM4Ynk3?=
 =?utf-8?B?WFl2ay9IdDQvMzVoYWJYa0t5WXRuUDBiTTFXdjB1VHU0Z21ZRGJVcmZacHFO?=
 =?utf-8?B?WDByNFJDRVZOUlRMS1Y1cmdsQXRWZXMxQm4yYy9wMC8ydWxFeG5MTkc4aTZq?=
 =?utf-8?B?ZDhia1YyZEoybUZuUEt3N3ZxQ2s5aGpEbkxRYVhDSDhma293dzU5SlBMSFBp?=
 =?utf-8?B?Tk54NUdXdzVtUnQ2d3I4d3lHU0NRcGk0OE1UYTM4YXZ4YXI0ZG8yWTlsN2R6?=
 =?utf-8?B?ZEo1VWg3MkJ3SXVMb2kxUisxZ1FESzNSN3dpMDUxTy95OGppRzBvRTB0Y0gz?=
 =?utf-8?B?L1RtQnMyK04vbG5xWVhWRXA0NXhrYWR1VDJLL0lnbTAybi9kOVdJa2ZDOUxt?=
 =?utf-8?B?VzBCaU53Z2kxeTZGdlhRcUF6dUdia0x5VWJkbGJSdVQrNysrcHJTNTlSUGkr?=
 =?utf-8?B?RXlOWUlzZS9UczlUOU1YQ21WZmptV1BhQUgrN3pqeUhNVk1JUUJXZFNWQ243?=
 =?utf-8?B?ZFk2WXMzVWxBbEt6NGlpYVhES21sWTdkWVlWWC9UNGpvSUJZejdqbHE4Vmg4?=
 =?utf-8?B?cStCWEpKd2VRRTU2aUgvK3R3T21kUUlrbEhUQktOZnNCMDR0ZEpRb1FQYUlT?=
 =?utf-8?B?TTc5VnNMZDFjeWJNZUR3WWVhSEpOT0ZvdkZ5ZWF6dWcrOGdBbW1TSnUySnhz?=
 =?utf-8?B?SkpZcWp3SXZ5bkJBbzROZ1RUVU5ST2Q3a016dE54TnBHRUVhMmJQOHhmb2NL?=
 =?utf-8?B?cUdzTU9vY25HdmVLUlUyc3lWS0N4blFldzlZRVRaYVVVM2hGb1NBbVNWNjBS?=
 =?utf-8?B?c1NWRm52ZHRjWkRkMzlDbFpidXRwNXdHa0I0ckE2Y1NiT3djL0xXelNEYk9T?=
 =?utf-8?B?T1hpbEVzOEt5VVFlbzlWakoxbThjTWRQN3dIbUVaSUZUUTdjdWNvdVZXTHNp?=
 =?utf-8?B?YmJGWCtFSHY3anhnUCtpT0U0dERjNUtrRko2NEYwa1ZSalRtYkFVOHlydHVQ?=
 =?utf-8?B?S2Q2KzZIN0I4ZGsrS1pyNGFmT2luMlB4V3JqMGF5NVJLSEZmbVR5UjVvTUZL?=
 =?utf-8?B?S3VwTHdPWmhZWGRDUlA0eXJKcHhxbFdibFpYS0NVNWEzZW1OTjF6dnFmMDBr?=
 =?utf-8?B?Q2dYQ2I2TUt0VjFjTHp2TGJkNzhLRmlPV1hEVVBQTTAvV3VUd08rQTNZTzZT?=
 =?utf-8?B?eHVtUzlFSFRnSEJ1YXZCQ1NEZGwranlJZ1lrMjNrWmluSWduUmJJNXByQUw0?=
 =?utf-8?B?SnUvMEYvRlBFQzBxQmcxci9McnBzUWE4bWNvZEpzL2F2b2hBdjA0eStYZUpY?=
 =?utf-8?B?VGU2MmFRb3hwY3Vlb24wcUVTcFliK21HSVptc3NJSHJjSHBlQjVBTzdmSWh4?=
 =?utf-8?B?aTcwRXNmOUJvbWxyN1Nkb1FrZ01ia2czYy81KzljSGFNQXQzeHVRQ2hCVS8x?=
 =?utf-8?B?TVlNN3h2Vlc2NE5ONSt2Z3ZKU21RS0h4VG1uTGloOFo2RXpxN1dnNGdDc2NP?=
 =?utf-8?B?UzR0ZU0xREpMOTEwRWVMUjVyTDEwQUdtMDhLTzRmSGNXWEI0R3QvRVpkUXlO?=
 =?utf-8?B?WlgyVExwTWJhQmZkK0xTVnpwQW81TmxhTHBWdnFxUU45SHlDeFpOUjFBazRN?=
 =?utf-8?B?RXNtbGlvMHlWUWhNOFdDUm9Zbjk4WTFDeWtubWpiU0o4d3loYklDRmZLVHhj?=
 =?utf-8?B?ZFAxVDFCbTd0dGNPblQxY3Z4Tjk1SVoxY1pzZ0x3cDZ4WDBvbnpPMVR0YXpD?=
 =?utf-8?B?MHE2WnBNOFROcFZrT3VrNTFBNkxZTjhmaTlaNFNsZVhGaXVDcXl6T3Voelhl?=
 =?utf-8?Q?w5XA+ZiG5UWlTQNo=3D?=
X-Exchange-RoutingPolicyChecked: vvFzZ7mb4K2nDtSJEgl8Begy2yZmCMi3XEoviXMP2W3h3GSgGODufPBxODLHTPkDk3pQM+tmn/04WyR2kWSEjjGbIcbtNUXAjYp8fS++QlCF1ercW6iI7jEPX1NWGS5ROch5XbxCXYKCdM1mM/0okXwi5xqSrTpfkjbR2Em08t6g7gSmsAWMijU0SnU8pw5VNyjyl1BGQRcixu+HDyKpylhvy57drdPPkxXP8YzZvq5b3coWuEeiWqD0BrtNcvDyl4BuTXWUCkcLuFfTZ5BLJ69HaIGnc04HiaWdLIZ3IJbYOq1z022ofzdXKzoLjDeI+1HnnnBowDGbPjIVH2KrXA==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2f006ef-5112-4dd6-3d6f-08df04485441
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2026 14:34:40.9508 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FMcvEJ9dIZ//Anf25h0BWEUeeeuI3K0PFkbOqmYAYgRm4Qizw9FRJZ3pPQOrEzzLQ9oTpVunBOrQhSdXcocUu3A0CPuSipEGy1NES5kMgxc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR02MB9251
X-Authority-Analysis: v=2.4 cv=GagnWwXL c=1 sm=1 tr=0 ts=6a904b09 cx=c_pps
 a=8OTw2qS5QgwVLUZ+0dTndg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=_-M8LpHI31CeLmyZm6wg:22
 a=64Cc0HZtAAAA:8 a=20KFwNOVAAAA:8 a=kDmwn9SJQQ73BrzAQp4A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDEyMiBTYWx0ZWRfXxqx22T1TyFLI
 v6DbikMK712GYdgbYSpbAxugQsF8EngnKdDY1vVo0YSomGTjEgFjcETQWI16dF0RdXR5whWMoIb
 aqJ5X5Qe1Xh7DjDyy2AsioP870520mM=
X-Proofpoint-ORIG-GUID: Y5x3eo8QVVAZGzhWJhY32CsneHcuBuwz
X-Proofpoint-GUID: Y5x3eo8QVVAZGzhWJhY32CsneHcuBuwz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDEyMiBTYWx0ZWRfX+JhZSj54tIj2
 6hGosC0Y6SOzb7xrB8CQD9QTfzOi68S+9DG459F3NVgm4UbV+/5DH15yz08q9nM5DCVxGLh+1E7
 ZLrRPxSE+PHy959qZK+y5UcGdJ8ddxjj6B+jre2BxjwMD+w66bMdPfCwy9erQghdrsAWe3CFeuu
 BsXmYE21R8lxaaT3FXBEYbfGP7yi8AeIakAC/Jp3vHds9mIRKbFVUaWCNzsIjlJJz8Sy6UJ0cFZ
 zy4KU8jhj4XJiG1mVZjIpDTNbz914nWRVMTUTwMET4bJZqCJnxP6qyEeDadtdFu3V6aFSawryMx
 Hi0w5B3EnXBRdH8bdqrSQ6xAsFwfix8EWCEqPgvyxaMC/YM7oXSwMcYEhsE2qc+dP1H65Wev5vh
 lMt7ZNAwjXgixakNYQ0csxKqrqBkrEKFvcpRRvoVyXH8johTVLsqD1AZJrOtdsw1eHgqII9NLmT
 TzHu2PwCHPnm9GGl5FQ==
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

This adds a class property that references a bool within the object instance
and is intended to be used as a replacement for object_class_property_add_bool()
where possible. Since bool is a macro then it is necessary to implement
property_class_get_bool_ptr() and property_class_set_bool_ptr() manually instead
of using the existing OBJECT_CLASS_PROPERTY_SCALAR_GETTER() and
OBJECT_CLASS_PROPERTY_SCALAR_SETTER() macros.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-Id: <20260825134320.1039012-11-mark.caveayland@nutanix.com>
---
 include/qom/object.h | 18 ++++++++++++++++++
 qom/object.c         | 43 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 61 insertions(+)

diff --git a/include/qom/object.h b/include/qom/object.h
index 8dead29284..de37016ba8 100644
--- a/include/qom/object.h
+++ b/include/qom/object.h
@@ -2017,6 +2017,24 @@ typedef enum {
     OBJ_PROP_FLAG_READWRITE = (OBJ_PROP_FLAG_READ | OBJ_PROP_FLAG_WRITE),
 } ObjectPropertyFlags;
 
+/**
+ * object_class_property_add_bool_ptr:
+ * @klass: the object class to add a property to
+ * @name: the name of the property
+ * @offset: the offset from the object instance where the bool value is
+ *   stored
+ * @flags: bitwise-or'd ObjectPropertyFlags
+ *
+ * Add an boolean property in memory.  This function will add a
+ * property of type 'bool'.
+ *
+ * Returns: The newly added property on success, or %NULL on failure.
+ */
+ObjectProperty *object_class_property_add_bool_ptr(ObjectClass *klass,
+                                         const char *name,
+                                         ptrdiff_t offset,
+                                         ObjectPropertyFlags flags);
+
 /**
  * object_property_add_uint8_ptr:
  * @obj: the object to add a property to
diff --git a/qom/object.c b/qom/object.c
index f91764aaa7..635eeeac77 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -2750,6 +2750,49 @@ DEFINE_OBJECT_CLASS_PROPERTY_SCALAR_METHODS(uint64)
 #undef DEFINE_OBJECT_CLASS_PROPERTY_SCALAR_METHODS
 
 
+static void property_class_get_bool_ptr(Object *obj, Visitor *v,
+                                        const char *name,
+                                        void *opaque, Error **errp)
+{
+    bool value = *(bool *)object_class_prop_ptr(obj, (ptrdiff_t)opaque);
+
+    visit_type_bool(v, name, &value, errp);
+}
+
+static void property_class_set_bool_ptr(Object *obj, Visitor *v,
+                                        const char *name,
+                                        void *opaque, Error **errp)
+{
+    bool *field = (bool *)object_class_prop_ptr(obj, (ptrdiff_t)opaque);
+    bool value;
+
+    if (!visit_type_bool(v, name, &value, errp)) {
+        return;
+    }
+
+    *field = value;
+}
+
+ObjectProperty *
+object_class_property_add_bool_ptr(ObjectClass *klass, const char *name,
+                                   ptrdiff_t offset,
+                                   ObjectPropertyFlags flags)
+{
+    ObjectPropertyAccessor *getter = NULL;
+    ObjectPropertyAccessor *setter = NULL;
+
+    if ((flags & OBJ_PROP_FLAG_READ) == OBJ_PROP_FLAG_READ) {
+        getter = property_class_get_bool_ptr;
+    }
+
+    if ((flags & OBJ_PROP_FLAG_WRITE) == OBJ_PROP_FLAG_WRITE) {
+        setter = property_class_set_bool_ptr;
+    }
+
+    return object_class_property_add(klass, name, "bool",
+                                     getter, setter, NULL, (void *)offset);
+}
+
 ObjectProperty *
 object_property_add_uint8_ptr(Object *obj, const char *name,
                               const uint8_t *v,
-- 
2.43.0


