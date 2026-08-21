Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D69F1C5DF89
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2026 11:18:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wxNFM-00072g-ON; Fri, 21 Aug 2026 07:17:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wxNFB-0006vL-ED; Fri, 21 Aug 2026 07:17:11 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wxNF8-0002OH-Uk; Fri, 21 Aug 2026 07:17:04 -0400
Received: from pps.filterd (m0127844.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67L9MgOe1901485; Fri, 21 Aug 2026 04:16:52 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=h2EalW+QGwDD3KApNfE1C3Y+2tnEMHAGqcNXVAvn7
 IM=; b=IQN8Q93ni1tB01fMo8vb+sfEi74AdeGM87Uvlz7Va0ZCn13ps7fcB/Gt8
 lN9PX+EwaN9ZxXkjLr8gvAObeBeGqp5JtsJ3L5S5eK1nuFeP0BHO3iT4e9ZgF6kp
 4K6xciIdsBCjclvuzT3BtYBwl7GInfqTZl+qtFOqPVdJrNRj7mb6AQL6/Ru0jx1y
 zvYYZjsgkwh3IUPSyvdhXGFO21uzyqW196N37tz+sbJwz0iMzXduGk30zLjHvOat
 TapTIWXWKgB/SwYgtDK/++4+BKL0mOXPRSdT12Jd46W54X/A1CC26y3Yk39yWaVF
 KqTGAdepqCTdoAFUrbwmB2o9HIB0g==
Received: from mw6pr02cu001.outbound.protection.outlook.com
 (mail-westus2azon11022108.outbound.protection.outlook.com [52.101.48.108])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4g6cm1s0ur-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 21 Aug 2026 04:16:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=imGqz4D/t7Dk1L8KBtGSV6/+652s0liealN//V0fvFWV6gvxVjZNM24GihBNW2TTTnCYG95Xb6oSxqEnYj090zzMwpqcIJ+XbcwZzxLl3LPYAqrs+2DDccZlQKZkp6ilJwnbKCzKSAnzfUhWwDqW4+3PhwSh4KCLCjlhGYJz7hZ0yqVhCKWiYcrSAL9/8EJc+N8Jsa2hJe3hHxwPz7XwERKHzWYp0I56VH/bjOlQ5yW928zA2uJwYf0zDbH5Z6WIGPmUCPycQs/f6QarW6eaTPK3feu+ibsp3AWE6Bljr6xZXCnpgCq2xBcd9El+VHE/l29Zg4YBm5KXp8HRwHzx1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h2EalW+QGwDD3KApNfE1C3Y+2tnEMHAGqcNXVAvn7IM=;
 b=JuJAF+r8Zdn+0FZ1p8OdOhRflyhmSVYw+/Rw/BtOXRrABGN5MaYhmzysq6j3oMhgUI40FQ4Z29V5csOdYj5cB+ZFFlT7grN1vsNhu4PnUL52fuCZvmZ9Yr1Xa5jNJg3TmFXkji13S8iXYBAQcj22TYzh4ToMGJzp9Wp1lQeEC1N3J7j37P7pSuafy9DC0+BnGAO/HeImuwPi2XADUR9C6foyBCWYjQtVTg+1MpXKFpAiCm/SWwtEIYPQbbXk2PUFes5ifNjbADkBpVusEJ/jOgZeFxR2ZJdV263pY1UgbNEQtwsWMUTj3t1arpNFN2EOulNY6YvXGKm1sFUfEP8rpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h2EalW+QGwDD3KApNfE1C3Y+2tnEMHAGqcNXVAvn7IM=;
 b=BCmKLByYl7DddCrdVWr2w4D3wbwd2N7G0XLetAx+Ci37NVCqww//d16eJ+jHBI2TEll7W6gDLB2PMJh+ip8qhJdvyauYcAFhCJNtRv8d5iOdQTSO0kup9C0W3prRd4YP+ULHI/i4APDI0QWq52taXwrujR8Rs0Kab6Emq2/mz2MlVGt+O7y248GfF626oUTzoOTRmMGNlIfqzRBI85/Ub5N52g9jlmDWtZCu/lDhHAPenF7O8p+khZDn3xM+dZfmVkz6N9XsuFNyyuxfamqsdqRmNg2ssjlzQe0ybDur7VVMZc15HWwYj5U/ZWXxreww57nHEkuuejKL9FEhOYPSjg==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by CY8PR02MB9524.namprd02.prod.outlook.com (2603:10b6:930:6c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.11; Fri, 21 Aug
 2026 11:16:50 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%3]) with mapi id 15.21.0339.010; Fri, 21 Aug 2026
 11:16:49 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: mst@redhat.com, imammedo@redhat.com, anisinha@redhat.com, philmd@mailo.com,
 aurelien@aurel32.net, peter.maydell@linaro.org,
 richard.henderson@linaro.org, berrange@redhat.com,
 marcandre.lureau@redhat.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org
Subject: [PATCH v4 15/16] hw/acpi/piix4.c: convert static variables to static
 class properties
Date: Fri, 21 Aug 2026 12:14:27 +0100
Message-ID: <20260821111550.276011-16-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260821111550.276011-1-mark.caveayland@nutanix.com>
References: <20260821111550.276011-1-mark.caveayland@nutanix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA9PR03CA0028.namprd03.prod.outlook.com
 (2603:10b6:806:20::33) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|CY8PR02MB9524:EE_
X-MS-Office365-Filtering-Correlation-Id: f09877be-1f77-4284-f7fd-08deff75b1f2
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|366016|1800799024|23010399003|56012099006|18002099003|10067099003|22082099003|921020;
X-Microsoft-Antispam-Message-Info: NwiHzjY3KTHT4L1amjSLRyaDB3kRxdZXeUqG7tC/6i/RuzxjiQ3BW1Javnh4gaVrm5jTU5obWaqFTfWVKAWucy2ORBdYgmAInn33EEOsLwVvX9dW7pcni1PDhmizi6+y9WeF0Btpno6RQqiiWQMMK3F1YbQxNNoyZnsO8jpfOF+67Gq0aJxTV1FPjlrE+AZj8KcHuxeV+v7zXHHBKTjWnMgCFm1zRjA4CNsyXJ+ZwEhg2uVPJnZEniDt9k5zsbfJ4e1Le3P2YGfRmx1OSrbXRKBr+1cFJ2M8tDbMEzxS2aZ+YZXP52RkO+n22eRlwdQA2lp/ctgJU8BsUzyxskLJSORAdzL/LCvIND9AhLuYWZ87Qa5ZysnganAPrjgMkyfy9zLLEtZ9md1g34XyATsyGbfm+PANvQD+mOl7GkwnZERqSRHhXEy/hbmB6kId7nc1yi9x2MItZ7ZfXNOIQlkKl+EwJYgF+6MrwqzsAwvjSOOv7ftc51EDbkljtc0uqURaU+toZi/+Tr77zGw3OZhO9xU2BMmlu/6J/iMWMjb1Vcyyy9Sz61XZu8Rddnouu9hjH/zw1cMLu86jtpeZSR/iyqZWxF4nwVeZ0N8Y8ERLxFIkUmA6msdkUlV4ZfU77hjVkaUvzdN/bDUqzL6eWQNue6cO6HilzrEA4MEY9zBDhnwygqLqZAFfRG80tEhPfajvzqdFch4Xp4Bj05aovjplmA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(1800799024)(23010399003)(56012099006)(18002099003)(10067099003)(22082099003)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NHIrSEMzTUdpd3BGMWdQdE8rTEp4dU9aU3JabTZOUXB5cUdCWm8zSFQ0TXJS?=
 =?utf-8?B?aUFZV1k2YUpxR0s0cU1sdEZRMlhjZHlOSko5UTVPZExTZzN0aUtiVElNVjU2?=
 =?utf-8?B?ZGdPZXg3U3NtMnBDb2lIaWlDbThpbUx1QUtCNUROWlU5ZlloZFVCbzBwSDVk?=
 =?utf-8?B?amNDM2pjN1g0OEp0U0FRRWhlem9VYnlHekdFTXdXMkUrSis1SW5DZUJLc2Nk?=
 =?utf-8?B?d3hPRjhmT08vQU13aFdpMWlwMlNqQ1NOeEs2WkpEcnA2TTQxRW1hMVBQUW1o?=
 =?utf-8?B?ZUdidlg0cWpoMUtyUitaMFROOCtTK25FcVMyenJON2V6T3BnUDhOQ0JFOTh1?=
 =?utf-8?B?bHE3Rm43RWlnM3A3UzFjZE1FbmJ1TmFjeXlQcmxWZmtoeTNLZkhRNmhubHJX?=
 =?utf-8?B?aEwyR05TRnVQV0szODk5MU05UVJBaDljTVk4dWtlcXkvQjZOZUdEbDhxVU00?=
 =?utf-8?B?SXpoczh4VEg2WjFpajJlZVRlQU9hRElFUVJISUl5OEJ0N2lDMnRVSUJQSWJw?=
 =?utf-8?B?SUtRY3VCK1N2bnRYUkdTTHlqU2RVVkRQTmZTcTRnQUFJeHJFQUt5ekxtaGo4?=
 =?utf-8?B?Umw3MzU0eU1GcEkyUWpLc0I0V3NxcnNKWGdidXc4NUZuUVowQjFtTlRNdVdX?=
 =?utf-8?B?dGV4UGo4Tk1KdjdJRWt6K1BaU0w5dkYwcUhkYnpsL0RjUnF1UnFRa3NUTW9C?=
 =?utf-8?B?MnJHaDFzL1BrdHRIMFRsMHdnTVp0Z0ltYmhxaFh5ZDhVSTlaZjhIeXhXZE9I?=
 =?utf-8?B?TWZsRHk1eXJYK1lIQkVyNzFRdXNHVjBDQzZuOFduUXpSbWlGby8wWHpwVUJD?=
 =?utf-8?B?NjU2aTIvNkhWVE44UTBJd0VDeEVpR2FyVGJUajROeWpQTE1SeCtFL3RPYkI0?=
 =?utf-8?B?QXpLMkIxQ2RsQTlROEJVaUEycTVFeWllazVrSGxqWUk2ZlVTVXdnWUtBbWh6?=
 =?utf-8?B?cENveGY4ODVyZ0wrdVdSOTlpcm9Zc2pzNkxaczVGN1FUK0dadTEwMnRzbndm?=
 =?utf-8?B?YTJZeGk1ZEpUYmpmZWR1c3BSeWM1aXI3Z3F0VWZxU2JuNW93Mi9ZQW5WR3d0?=
 =?utf-8?B?clFnc2d3TTVOOGYxNkx4b3VpNUk4cWRIdDUvVWRWNXBxV21aWUcvSVZwWWpm?=
 =?utf-8?B?SHFTRkx5WHM2S01VeWVHeEZBY3Mxcmw3TldGck15Y2tsaVMxV3pqV21tNHBP?=
 =?utf-8?B?ZEszMEhRTExnaE1UZmx6UUdyay9iL0hsMXBQSnJuaWUwNnJjVmhEck8zWWtT?=
 =?utf-8?B?U0FUV2xwSlVDZkIyQ0VLRWNyQlNRZ0J3ZlptTEhEQVQ2Uit5TFFyWU5vRXpt?=
 =?utf-8?B?b3ZDM2VmQmdMK1pYSTZaYjVUNGw4VWF6UHJveXo5RHE5Z085VHp2U0NmNHVG?=
 =?utf-8?B?ZW1XelFhV0RVR2tBUmprMnZ3dTJJSkpoQ1NzdGUycW9jY3RyZGUzcnRzU3M1?=
 =?utf-8?B?YVNhNXdXVGxxVVZueC9sdmoyZnM5d1Nsc29SWDNwU0d6ZzUzYmRBVng0c2FI?=
 =?utf-8?B?MzB3aElUUllIWTBEQlRmaDNNajZDeXUwdFZPMDdYaXJqdnh4N1d1Y0d0UGkw?=
 =?utf-8?B?UUtwa2M5TExsdjlvdU41YTdLZ1Y2anVzZGNVNTd6K3R5UGNwT3RIKzJmR04x?=
 =?utf-8?B?QTc0UHgvcmdOVlJUclk4UE5FUVRFOTJmZ2hiTWxVSE5DMW41NVRQcE9IVkE1?=
 =?utf-8?B?OEhXUlMzdjNBcmcrM0t5MFRHUTgrRFRUWlkwOHFUOWg0ZkJPZTdROXJwQVhE?=
 =?utf-8?B?a2RPaVVpL3ZrUk8xOVJnaDVRK3UwQm5ORy9qVjU1TDF6c2xFU05IZWhMdExY?=
 =?utf-8?B?MS9UUFZZQmRiai9tZjBHTEkrcVZPcUFZblhkNWRHclVwSjV5Vjd4ajFZMmMv?=
 =?utf-8?B?aEtLbnBWRUdCbkhERWFlc1ZvRGowNkRrSTcxSG9YMUpIeVU5d2dzbTErQXF3?=
 =?utf-8?B?S2ltUUhIY0p5enFTelZ2MjZrSGVmNFMyZ2N4K3BqMmg1eHNoUFRzOWdlZEdH?=
 =?utf-8?B?ZjlXM3ZsaEJIaGZUWmxJaTFrZzhaNTAvMDNUbHZwdEFMZ0RNSVFxNVc0VjZU?=
 =?utf-8?B?WElhVzFpbHRqWTIxQTRrOU9OeGdtYlhNbTFRd2JPWll6OTRiaU1ndElCdkkx?=
 =?utf-8?B?SDF5N2IzSXI1MklvYXlqRzYvTlpVOWg2WGRDWTNxbkxyWFFzUHlUS0NQZDJX?=
 =?utf-8?B?b1NCUStQOGxoV0Fic2RtcTJTVjBOUS9odGNWREpubkZ1KzhQTHhxT1g0MTcz?=
 =?utf-8?B?K3l2dk50STE0QWF6OEN4anZxcHBlWGlia2RjbFR6ZE9CRUp3L1JGQUNjc091?=
 =?utf-8?B?S3g5RUlHcVpld3ZBOS8vdDd1NGNHMGo4ZEo5bS9hMDdHQjFQcVoxSmJhejR0?=
 =?utf-8?Q?RZcz3r8h2GIMd89E=3D?=
X-Exchange-RoutingPolicyChecked: lFShGmYbAOgOP2aiik5TTGszu6en1wf8guuPZmGo6h26XQ66s/NSvB1zrxiR3PdPj7bFXbo8e67aj+XbBzgmzorV+/dGkSNFZDMVBjRP0jM6rsyEPQLlv4NOFm5iTF67nRdIqmcxkj5IVRBIH2P/hi011sMdr5zSLsweliIv5M6uCjOKRS+Wyp1/gf6DHG8HCmDGIqgS9Xxcp8npdXJUH+gkJ/T79k+jtCyfYlyuo+v2hzWLvs8TCoxTr98/ZNaxkeHhEmhjb35/LJ/OLGdTwXMs45/7+I7HKrs4972ly+HWeCuL4Kbu4TkkMGpa8i6joNDR37ywzNjaWLQXpr/lzw==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f09877be-1f77-4284-f7fd-08deff75b1f2
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 11:16:49.5675 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: duRyiVFHLGN2DjS7j9F6nX9jjcO/mbbgLk2fxONJitwDcfYHjQf0NC0kKcqjyBQpyRH+Y65bGdw+u8MHu9UYrKyLXiIjU8bnN1OP0Xmh6bk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR02MB9524
X-Proofpoint-GUID: GIQjCuy2n41HNobBZNVvFZ-GdAai3z2N
X-Authority-Analysis: v=2.4 cv=J/qaKgnS c=1 sm=1 tr=0 ts=6a8833a4 cx=c_pps
 a=0vs9Akrd78aydvmXS5/lXw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=0LlEyIVc8U2lsR7dKhuH:22
 a=64Cc0HZtAAAA:8 a=20KFwNOVAAAA:8 a=zWFTgipdAxScIl1IxHgA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: GIQjCuy2n41HNobBZNVvFZ-GdAai3z2N
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIxMDA4NCBTYWx0ZWRfX64Ma5iopdk38
 x25I2CNKjPi3UeI+7UXLc0crBhyXb9wc7klb8WEFqUon65mirNncspYQimy97+KYr57x6ZYejhC
 sSNHYW2e4AFNK5abLgqiSoXreauJM908dCJxGwHCIjl6iU3JsrvG+8b8tXzZtYuRdl6UxyrTaBJ
 8XlimG8+IoNRfwuJfhkaP7u3MIJS5lgjx3ooPy59OtNRQp3pdoHLflpeEPCbm2R+cfG3UWUqBTU
 v+nqklw3L4opXDKV6j5Exf0iDs0vTcOeOTUPddiaiNmdZooH3ASpgbYKNYWl8Bsz5wUD/+olV00
 sxs321Y5E9yQb1QwGS4/SWqVYI8NLVRC1j96CEMrIjJsVQPbdBhCTS2DfeuVu3q98hA7Tr1D7Ip
 aIM7o9/8UuvFlirwYfrvazTSyriCNNTDuafIBU/IUJBcvd3WDQvLymF+SWMQbCtPMeqhVEiApeo
 YvSWnQZ83AWkQeZeIFQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIxMDA4NCBTYWx0ZWRfX081gRxN+SOjN
 bZA3NSARhlLu8Cfzp1VQZrFbBGwyZn4tPpOB6JSrPESnSZmmfgx1okk/yYHsxg5XEIesfgmN4fV
 qiO20ITbnBL50pyswJOEvuAoF5v4wxM=
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

The majority of the properties in piix4_pm_add_properties() are assigned to
static variables and so can be converted to static class properties. Introduce
piix4_pm_add_class_properties() to hold the static properties and soon all
other class props after they have been converted from object props.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/acpi/piix4.c | 40 ++++++++++++++++++++++++++++------------
 1 file changed, 28 insertions(+), 12 deletions(-)

diff --git a/hw/acpi/piix4.c b/hw/acpi/piix4.c
index 1d209ac96d..6462ba970c 100644
--- a/hw/acpi/piix4.c
+++ b/hw/acpi/piix4.c
@@ -406,6 +406,12 @@ static void piix4_pm_machine_ready(Notifier *n, void *opaque)
 }
 
 static void piix4_pm_add_properties(PIIX4PMState *s)
+{
+    object_property_add_uint32_ptr(OBJECT(s), ACPI_PM_PROP_PM_IO_BASE,
+                                   &s->io_base, OBJ_PROP_FLAG_READ);
+}
+
+static void piix4_pm_add_class_properties(ObjectClass *oc)
 {
     static const uint8_t acpi_enable_cmd = ACPI_ENABLE;
     static const uint8_t acpi_disable_cmd = ACPI_DISABLE;
@@ -413,18 +419,26 @@ static void piix4_pm_add_properties(PIIX4PMState *s)
     static const uint32_t gpe0_blk_len = GPE_LEN;
     static const uint16_t sci_int = 9;
 
-    object_property_add_uint8_ptr(OBJECT(s), ACPI_PM_PROP_ACPI_ENABLE_CMD,
-                                  &acpi_enable_cmd, OBJ_PROP_FLAG_READ);
-    object_property_add_uint8_ptr(OBJECT(s), ACPI_PM_PROP_ACPI_DISABLE_CMD,
-                                  &acpi_disable_cmd, OBJ_PROP_FLAG_READ);
-    object_property_add_uint32_ptr(OBJECT(s), ACPI_PM_PROP_GPE0_BLK,
-                                  &gpe0_blk, OBJ_PROP_FLAG_READ);
-    object_property_add_uint32_ptr(OBJECT(s), ACPI_PM_PROP_GPE0_BLK_LEN,
-                                  &gpe0_blk_len, OBJ_PROP_FLAG_READ);
-    object_property_add_uint16_ptr(OBJECT(s), ACPI_PM_PROP_SCI_INT,
-                                  &sci_int, OBJ_PROP_FLAG_READ);
-    object_property_add_uint32_ptr(OBJECT(s), ACPI_PM_PROP_PM_IO_BASE,
-                                  &s->io_base, OBJ_PROP_FLAG_READ);
+    object_class_static_property_add_uint8_ptr(oc,
+                                               ACPI_PM_PROP_ACPI_ENABLE_CMD,
+                                               &acpi_enable_cmd,
+                                               OBJ_PROP_FLAG_READ);
+    object_class_static_property_add_uint8_ptr(oc,
+                                               ACPI_PM_PROP_ACPI_DISABLE_CMD,
+                                               &acpi_disable_cmd,
+                                               OBJ_PROP_FLAG_READ);
+    object_class_static_property_add_uint32_ptr(oc,
+                                                ACPI_PM_PROP_GPE0_BLK,
+                                                &gpe0_blk,
+                                                OBJ_PROP_FLAG_READ);
+    object_class_static_property_add_uint32_ptr(oc,
+                                                ACPI_PM_PROP_GPE0_BLK_LEN,
+                                                &gpe0_blk_len,
+                                                OBJ_PROP_FLAG_READ);
+    object_class_static_property_add_uint16_ptr(oc,
+                                                ACPI_PM_PROP_SCI_INT,
+                                                &sci_int,
+                                                OBJ_PROP_FLAG_READ);
 }
 
 static void piix4_pm_realize(PCIDevice *dev, Error **errp)
@@ -616,6 +630,8 @@ static void piix4_pm_class_init(ObjectClass *klass, const void *data)
                                          offsetof(PIIX4PMState,
                                                   acpi_pci_hotplug.io_len),
                                          OBJ_PROP_FLAG_READ);
+
+    piix4_pm_add_class_properties(klass);
 }
 
 static const TypeInfo piix4_pm_info = {
-- 
2.43.0


