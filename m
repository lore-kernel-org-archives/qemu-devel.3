Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F7CDC83F09
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 13:45:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWxm9-00066T-4Q; Wed, 02 Jul 2025 09:45:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1uWxlw-00061V-74
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 09:45:16 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1uWxlo-00027T-VH
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 09:45:09 -0400
Received: from pps.filterd (m0127841.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56274EHB001273;
 Wed, 2 Jul 2025 06:45:00 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=wzbd7MBD0NBDnIp4S96qEUXGSFvAXlbWGBKh6yloM
 H0=; b=g9QyPIzAcnbF5AohMu4rgbFrVFW4J+S58fnF88SM4Be8N4ucAiBIl4xX3
 3bdnws4wwHGnxRcMOxXwaHRf0ROgC0xYhnSOCRkO9B3UeAZYpLRkT+ck9FbzsOKE
 8RRqM7zDAiq14SUUDKOJe+PZv/m1tDsVCzn8Pj019OzNC80CWltqSnU7ve8pom5g
 V86nPRdwS4lLTO+reENBzR9rosqqKVo4Qk3jvdN8FOrL3CYJ6QIGulAjcZXJ5KCx
 fAsMlfQdniFVj2me1Qfn6TLuthHZxjI4A+meE4vcj546PZbcDARChrkc1xnDjSsw
 wDbovhH+r/OLz5hpsL5MyHOKeMErw==
Received: from cy4pr02cu008.outbound.protection.outlook.com
 (mail-westcentralusazon11021113.outbound.protection.outlook.com
 [40.93.199.113])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 47jdxb2u34-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 02 Jul 2025 06:45:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m1IjzxWyPJWIIumN+7bJrkUClz+xBl8CLD9cleZewoO3sBpVBWEG2ls89M7nSSp0QM1FK37EoZFdout57BVReycInN+sAUqyLL1361iDDpIgfPPSAPvznZ0Yxn2w6s484OYfohjvf/aPAxGnk9h7xujdMSxJTaKrjcC8gl/7NpEmhK/ejPsfw1Lf73yeRK6SfOzvKOLKj+mO+3B/kZz8fucyAg0jWab9VCdMySCBHM6iRkR4zX0RyStvDHNqyzXFq7qgiL+o21eJSbJIxEX7NMTtPU6MWOIj+qiVFSjsPH4WLGFKid00mDB5A0gNRSHrU7USAh1tJdnj4Sq2Rj1hww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wzbd7MBD0NBDnIp4S96qEUXGSFvAXlbWGBKh6yloMH0=;
 b=q5UacJtykorK0w807JFfIHOzxsph7GTiijrW/SEtaHFUjlfADL8s6BrQR6thsXbmaNxusi1J4UZfSVp/npFVuIEjooCjei5A03s/G0phWkRLKfY99CvP+ktaE+RMVlIC8Ac9ciDzq4G190bdsGEwwbq+wh/hPBt6rSQtKMcoVin8Cz39Br8UfX9Ikx07wLe/KeVnRgH2F8/4Gr2/NGInEvbmOdJxwZ7PE2V3+ZoFZGsv+EIMYKQkn1pkoKsyptCvIbeBGcwWxs7LrwVICImkjrg/niMDNwv2e8TidEbQtxtSPBndhb0pOS+Tm6z+TXknaSAjaY0vXGxSS4yOihB/ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wzbd7MBD0NBDnIp4S96qEUXGSFvAXlbWGBKh6yloMH0=;
 b=fBPVWdF0GzU61Z+BJ2RR13Y8PySzNjthWx0XYiRiITpvPon7xgMKSYU4ZK81FZ5lIhXsgbEYpcynJT5vbdst0cypLcDh/tKy/gGBjh79Jo30DS3FeSfeZdH1ig13arAFQ7ogGtj4rBsdCZngD6kun7h00DbSYzQvXKQVN1rOe7KXbhtC2L78PXQ2BcckHcezQRPrlPmBGerL2bMEHSoUqOSLW23OD9+tnQOiTUZODfuPAc63iuawJ2D3jowUzNpnSecsH61lol2o4IfloYPVLq1UmajBqE0fIKCJLx74vIbfyXEqCnTy9CWqAEU9O5RHtI0DgMwdE4wW/bZf3iQWJw==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by DS7PR02MB10964.namprd02.prod.outlook.com (2603:10b6:8:258::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.20; Wed, 2 Jul
 2025 13:44:57 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88%3]) with mapi id 15.20.8901.018; Wed, 2 Jul 2025
 13:44:57 +0000
Message-ID: <84f626a7-5b90-4eda-ab3e-7407da6d2e82@nutanix.com>
Date: Wed, 2 Jul 2025 14:44:53 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] vfio-user: do not register vfio-user container with cpr
To: Steven Sistare <steven.sistare@oracle.com>, clg@redhat.com,
 john.levon@nutanix.com, qemu-devel@nongnu.org
References: <20250702120043.267634-1-mark.caveayland@nutanix.com>
 <4543142d-de4c-42fa-9309-3f00ad44110f@oracle.com>
 <b2bb792b-183c-439b-90b5-9a2f6bcfe864@nutanix.com>
 <8b751d27-7826-48e8-9821-9a961e2f509b@oracle.com>
 <4d5973e0-b4d7-4201-bac5-495a12972de4@nutanix.com>
 <1e523e81-cdee-4331-8799-3d9220ec283f@oracle.com>
Content-Language: en-US
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
In-Reply-To: <1e523e81-cdee-4331-8799-3d9220ec283f@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR02CA0136.eurprd02.prod.outlook.com
 (2603:10a6:20b:28c::33) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|DS7PR02MB10964:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e27ac95-3010-468b-da5d-08ddb96ea20b
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|376014|1800799024|366016|10070799003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TXZaNnQwMFpkNEdiNys1eTRnUm1YMDczUGJaellMTW5oaGhMbkJFQWtiY0xC?=
 =?utf-8?B?aU4rcTlrcVd2UVN5MCtmQzVCVlNDQ1pZd2RDUmUvSGd4bURTU285ckVQWCtJ?=
 =?utf-8?B?Q1IwMm9Zd21YRE1VZHJ5QTNvcFF1OG1QT3FHeVMrbzBMNkJxYTlON1U1UU00?=
 =?utf-8?B?ZDdkamRqcjk5cStYWFo0cm0wYVRNbzJFUUJrVEk3OHFQeUZsYVRhTngxc0M0?=
 =?utf-8?B?UWxnRWNpUmxGZlpRTXNDWmp3WEVYZXBveDZYL2NJOGxGbGpzM3lrSTFFL2FS?=
 =?utf-8?B?dURkMnBTYmlkS2wwaGJHY3B3ajh1V2Z3OG9BaHFaY1RONG1ub09RNi9YaXN1?=
 =?utf-8?B?WUdTMnVPTHpibDFYVk5aZEdvdnZETFlyMW1Jcm5LQ3I4SFNaWjcybTFKYkpm?=
 =?utf-8?B?b2h2Zk16ZkZOYXByR0NYeWFKWnJCWEZyd2pMWGxscFR5ME5iQ2xTdU1qR1Bn?=
 =?utf-8?B?UmRkTEo1Lzd0OGpXSndXTVlOUlZYQkZydVMwaEJQNnFnUVFZU2NocGZVU2px?=
 =?utf-8?B?ZG8wVmQwVEV3cGxxTXcvU1dla2k4aXhOMFZsNGdiSHJRT0J0czNYMHB3UExl?=
 =?utf-8?B?ZXV3eUphRWxscEpCK3hGQXBxZk5Oa01MWnRTODcrU2tUNUpZNmNlQVdnVnZH?=
 =?utf-8?B?RkxLRDZZR2JFdVlLYWFHWXdaZlI4bTY5d3JNMVk2YnNkZ3Uva0M5cjIrdWNJ?=
 =?utf-8?B?bFhGKzZqeXFkS1hHWHMrWGRaZHBQU3ZZVXJmQ2JMVTZraWhyR0lsQi83cm5p?=
 =?utf-8?B?VDFsamRWdGdZSTJORWRSVG4zeTY4M2NQT3Y3S2lXV2FIMys2UXhGNUZydWtv?=
 =?utf-8?B?RTNNb0UzSG1Nck1kWmZXUURxWER4Q1lsWGZ1cEhvR2xuRnJmeCtja3RLaW9R?=
 =?utf-8?B?WVFER0lpcGZuVEREL3Q2Y2xJRGJMNzRCNWt0ejJZUk5hQTBvOTYzdWNJRkU3?=
 =?utf-8?B?VTkrdlk5blJmZnY0Y2M3L2RXVGFxMUdkSThkbytDRytzNmY5bjhYblNyQjRv?=
 =?utf-8?B?SW5YdlU3UDlkK1FKbXVob0lzU21wUlRtZXJhZTlWS1A5OHZmMXlzWFl6QWh0?=
 =?utf-8?B?ajR2L0xpeG1jb3JiaDFGdWRYRzVQejI0ZWRvSk5yRGJHV1ZLZXg5NFovZ2VL?=
 =?utf-8?B?TVhPTXpIQjlsZlVHejdydzZsa2JuVmVSNzBBc1FFR1krTTRMNjVvYUZWN3NR?=
 =?utf-8?B?d1FOd3dPajZtRUhXeVQ0ZHE0USt5SWk0SUtCNjRScElhNkhGUmtLT0xXY0s5?=
 =?utf-8?B?UnphNDNUVlJQaithSndXRmt6bnFTdVFYMzdoUllORmJNeWkrL1RjUHo5d3Nu?=
 =?utf-8?B?V0xEWlAwOHJQVmpIby9ZQTdoVTBNNVFOTXQxMVV2blpmWFV4dGlHNUVuajgv?=
 =?utf-8?B?dHF4ci9nTzZSWmZWWnd0emYydm5GRTFoMXR2Q3dkY2N4UG1PdmFjRkZpTVVP?=
 =?utf-8?B?NUVZdDNndm05dTNGOUhSTllVdGNGNk0wUzZaTENYTmFUZCsxTjB1eC9yU3Z1?=
 =?utf-8?B?MkVVbUhzRyt3UWE1VnJmY0RWYzdMNWhmMmo0a0ZtWVVMa1NoREJIb3RDL2p0?=
 =?utf-8?B?NUExNmJYOERFMmVuMDZ6WCttSHFLSHRnaldIaDFLdWFucHZTamFnMHltdjhK?=
 =?utf-8?B?YlVSb1RUU0ZhcE5YcmJpYVVtMzkrQ0N1NlVXalY2K01jSlkzNHFXOXZaT1d6?=
 =?utf-8?B?OGZhTS9wTCtudGg2VTVYb2E5ODZiYlIxN2RwamNwdUlia2o5UEhxSmg2SStE?=
 =?utf-8?B?Q3h6b2QyMk9YaFpCd05XQUZHalpYcGV2SlhqWWR3WVo1SXNtSTBYK3dGY1Z0?=
 =?utf-8?B?cDBocXBvSStibGQ5VnBTY2d2SGduWW9XK2JZWkp4RUV6ejlURDVSWlNYdmZt?=
 =?utf-8?B?ZXJKSUF5dDJLVEZ1OTd3MDkzbnRVcU4wMzZ6MXRQazd3SmYvcEhKSnV6OWMx?=
 =?utf-8?Q?oTutLjjn+Tw=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(10070799003); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eDJOK2ZvV1JwMUgwVGdvR3hHTWxuRWNXc2pYQzFSOUgvNnlIZ1ZneFdmdXFN?=
 =?utf-8?B?Y0NQeWQ2Qk92VmZxZFU3QlFpK01HVyt4V2U4WTg5NUc0Mmw0dnl6YmdIaUww?=
 =?utf-8?B?M054YTJmUW1HYUFaM3c4MFFCbmFZcTBvV2V4S3E2VGhnL2lkQUpVb2MrUG9V?=
 =?utf-8?B?TkdvekExM3d2c3dLT2tCU2lLT0RlY1IvZlpUY2Y0a2I4Y1ljaE9RYlIyRWNn?=
 =?utf-8?B?R3VtcVcrR3F4TUwxSXQvWVExdDdIOEJSYlZINitOSEVHanQxandYMkF5WHJE?=
 =?utf-8?B?T05ZNmtQcDQ0OWtvWUtoTEM5anNHL0lUMTlZYVFPa0lzaEtBZjEyTVBvSmZ0?=
 =?utf-8?B?V2dVeHh1VGVHbHAwSDRRbTNlaG54QWpNbXV6dUNEdkFMeTNraGptMTIzTkN4?=
 =?utf-8?B?ekFEZWVldzdXaWFlTlFLdmNuWUpqUTlvYnJIS1Y0bmJFUXU2aXBxOVJ0SCtM?=
 =?utf-8?B?d3IvVE9OZk93K2l2UmFrbjNIKzBWTUpFbS9LVEptdWJhbDVRY1Ruay8wNXJ6?=
 =?utf-8?B?WUNMWGNPc0tZUGhYdS84M3dYRDF0THcra3hqT2VXblJsOVJ3MVp2M01NbGhW?=
 =?utf-8?B?U0FTem5RVFVHQUg4d3A0aSsxRG9abVpEMkp3Nkh4T3dQS3U1ODBlalU1cEJD?=
 =?utf-8?B?bERiMTNTSTRlZ00yMmliWTUzZUlZUy9EVVdMdVFXdCtxVStlV3VKV0lRckQ3?=
 =?utf-8?B?SWFMbi9xYU9PcTFrYWVpWTZCKytERzE5ZjVxRzhaTURrNWhVOXJuUTY0OVBH?=
 =?utf-8?B?N3pHUWJXektSZHozMVN1Wnd3VXl1a043LytwS1FqdWpvb2wvWXdnN0RpZDhD?=
 =?utf-8?B?VE5pZUVCKzJnM1JiZUxpRGNmTHdvb0d6bjZsTy9vMXB0N0ExTWF1c1YyZmFD?=
 =?utf-8?B?TmN6bFh1amR2SldkanJ2Yyt3bTd1ejJJem4yWjJYK2Z6MEl4N3V4R1k4RE5X?=
 =?utf-8?B?NXEyazdScG5TT25tKzI0Ry83NDVISjF4Q3hBVkw3WG8vMU4xQThUL1JTZTN5?=
 =?utf-8?B?QzMwaDZYNlpEVVRZcCtJWWVkYXlHYTViQmVmMzNvK3NEM0phMFQ4VUdqa05m?=
 =?utf-8?B?ZUJJbDAybHlhWmJSSlNRLzBnMi9QbXk5WFM2ZEdkVHcyTEo5YXhabzNVR3NE?=
 =?utf-8?B?VU55bXVXM3NkMnpId0l5QXdQMWptek5KZXRCOUJjSThJUmZMcGtHNHpLeUpQ?=
 =?utf-8?B?Sk9jZW1Xc0JKY0E0S3V3bXFkZ01ITk1WZzhYMzdBVEpFQmVXb0Rsd09zS3NK?=
 =?utf-8?B?Wm9HektwNEk1VmFoM1FsaE9lS3JHc0tQTUh1cHlYUjVTdU1oN0R0WVpvcFBZ?=
 =?utf-8?B?djRtR25uOXYxQ1JId2FTa0g5eGkyVmZkRG5VY1ZUZ2drM1h6NHcwSk9qckRP?=
 =?utf-8?B?dGpzbGU5N0k1MGxjVjIyd1k2elBrdDgrbFBZMXNuQ2gyMWlEQ1BaL1l3dk1l?=
 =?utf-8?B?c0dudSt6Z2R2U2pneFVJVWl0T1ZLak5tVmc4NmF2NUtkRTRsNjRqY3pNRU04?=
 =?utf-8?B?OXNCSzNnSUhFQTdwdnRIbWVaeXZCMjQvT2tZanJnLzg1TjRlSmRuU1JwRU8v?=
 =?utf-8?B?QWVaVW5IdHF1bGZkOXJKSU5uSG56OE91UTBIZiszdFVsL1d3NFFyMmJEejhN?=
 =?utf-8?B?M0FraFdCYlM2Q1U4N3FlalBlY2ZickVCeHZuSHIzci9nc0lySlRJcGRLZjhj?=
 =?utf-8?B?NTBvaVRSMFFPQzdNRC9IN1JWUTFvaW02cEszTUtpaUQ5TGZRYVhGYkNvdVBE?=
 =?utf-8?B?MEl0U01sbjZGL1RraUtva1FLR1RhVUVFZGVmdnpDUFhlNFI0blZpbHdwVWsx?=
 =?utf-8?B?UEFwYjhYSldWYjg4WEFwSXk4R04zVXZBazIxOTN4OGJqWXJGVTdMd0ExRURh?=
 =?utf-8?B?MGVqK3d4Tm8reDlsekN1andQN3Npc0pCZFFIK0N2WXM0K0RLdHVwRGhwaTNZ?=
 =?utf-8?B?UDZoZVpxZ2pzeDBkSkR3UUF6MG9NcFZLQzAxZkNKTFhzbE14MXFDWnpMMHUv?=
 =?utf-8?B?NTE0Z1l1cjh6YlV4QldOSG5Lcmk0aHlZTVd6R09JeG83R25zejhRU0pZZmJX?=
 =?utf-8?B?aGpEK2xzWjBoZlIrZXJSdU9QMFBTUHNqQnIrQkE1cjJNMi9NSytxcERiWVFX?=
 =?utf-8?B?RDdnUng5VHRodmtvN3ZEcVN3Q09IT2lFY2xWaDZ6czZtdm9RRmpxY2lvS25x?=
 =?utf-8?B?MXlmcGRGcWxxOE5ZdzI1djY0UlJFbzZ3c3YwbnYvVUo2RmJQdDdUaU43MXdK?=
 =?utf-8?B?dmlqN2VKR0ZZQWcyY0RVd1JEZHJRPT0=?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e27ac95-3010-468b-da5d-08ddb96ea20b
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2025 13:44:57.3467 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A5fi1T9en6aT7iEaAjytWZ2Th7kvYyPTiz4DVC6JCfIZGS6DGAWXgrRtiYjVfhkitV3fGZod+AiPIrh7ry0miv2HleomJx/6qUXyTQxQx7o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR02MB10964
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzAyMDExMiBTYWx0ZWRfX3t7cKHUTz1QY
 NBYebJFmmCTZxxpTJWh2aJZ/5x/+cosmL8ozmb/FnYzb+4K0FpcyN9Yx4oXWxddwJd6vkuzuegj
 a3euG+Ge1Cw8Se45hwuw4aqH2HYHbUdBR9SyODQW0VDPTj39qKFVnd3FxGMgGoFNWB9zZTy9c2e
 gMZgcrr/0X36C6/ecnOhU48AT801Xtxfi4P6X/iYcxH0JlWHFgEF7rae3ZXmrGXMj3mmkMMS3AV
 eClp8+Lakv1vfqRq1NoAI9ASA64cO053keTZ0oMc8e5YrSJC9qbD4r/PRyykTm15JZb2PhwiqCV
 aV09s3e+Ty+2FthimPtTbm7Ok85k/KLAENwMx70YD6Oo61PL07ZVywgAUdBg0jZbhNFL923WLY9
 seE9jfz2qbizMe4k4oN+OHoerzQTOEBljp0jReiGtq4jREBy/Fs42Bf4TqRULUUrGnigZa14
X-Proofpoint-GUID: LAA7kFZBc07jffbcfcJ57if_NQ_gD3Rt
X-Proofpoint-ORIG-GUID: LAA7kFZBc07jffbcfcJ57if_NQ_gD3Rt
X-Authority-Analysis: v=2.4 cv=c+2rQQ9l c=1 sm=1 tr=0 ts=686537dc cx=c_pps
 a=TLx2/RJjNaqw+X/lYsMj3A==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=0kUYKlekyDsA:10
 a=64Cc0HZtAAAA:8 a=01JZcpf7RMLa5xi0CEkA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-02_01,2025-07-02_01,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.237,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 02/07/2025 14:39, Steven Sistare wrote:

> On 7/2/2025 9:30 AM, Mark Cave-Ayland wrote:
>> On 02/07/2025 14:24, Steven Sistare wrote:
>>
>>> On 7/2/2025 9:21 AM, Mark Cave-Ayland wrote:
>>>> On 02/07/2025 13:07, Steven Sistare wrote:
>>>>
>>>>> On 7/2/2025 7:59 AM, Mark Cave-Ayland wrote:
>>>>>> As the full cpr implementation is yet to be merged upstream, do 
>>>>>> not register
>>>>>> the vfio-user container with cpr. Full vfio-user support for cpr 
>>>>>> can be
>>>>>> merged later as a follow-up series.
>>>>>>
>>>>>> Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
>>>>>
>>>>> This is fine, or I could drop my pending patch "vfio/container: 
>>>>> delete old cpr register".
>>>>> Thus the vfio-user container would be registered for cpr-reboot 
>>>>> mode, which is fine
>>>>> at this time.
>>>>
>>>> Have you got a pointer to a commit showing how the registration 
>>>> should be done without using the old register/unregister functions? 
>>>> We are certainly interested in looking at cpr here at Nutanix, but 
>>>> since any work is in its early stages I don't think it matters too 
>>>> much if the old functions were to disappear.
>>>
>>> No.  cpr-transfer for vfio-user is going to be a bit tricky because 
>>> of the external process,
>>> and the existing registrations will not cover it.
>>
>> Got it. In that case I'm happy for Cédric to take my earlier patch to 
>> remove the old register/unregister functions from vfio-user to avoid 
>> blocking your work.
> 
> It will not block my work.  Leaving the old registrations in place in 
> your patch and
> mine allows cpr-reboot to work for vfio-user.  I would simply drop my 
> patch that
> deletes it, and rework the registration to support all cpr modes in the 
> future.

Okay, great! I'm happy for you to CC me on your future work to help 
review patches in this area.


ATB,

Mark.


