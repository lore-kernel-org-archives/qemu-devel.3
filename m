Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 159C9CA0FF2
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Aug 2025 11:13:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uraXu-00009R-PV; Thu, 28 Aug 2025 07:11:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1uraXs-0008VT-4C
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 07:11:56 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1uraXq-0005TS-Dl
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 07:11:55 -0400
Received: from pps.filterd (m0127844.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 57S77Yjh2726376; Thu, 28 Aug 2025 04:11:52 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=t/aq3Kyfbbbp2v/c+E04KedQxfbtJa87qBRWGYV8T
 Ec=; b=R+ETV4NFjwSjNtoSBsUGiAYhcOGj1fVyNUTELlFi/0uXTxSvesoiDj0Nr
 fnG2IWzuDQC2e09qTaQFpwUznNfKqnJ3p2ZBJACf7rANGIXbfvzQAV8wxkANGHs7
 t3b8O1IQjMwUJid67St8OuVV1AZCsjBK3tfsSyM+oHg7WFot9uGFIZBKVprtNFas
 IZV588JAVXCWGUP/GUC3l7E2yQ/w8LwYfqQUZ/ZsWaMI/TzlkKQbaJRxyY8v70s7
 oP/mPIS+bGBw/OqoSXYr37poBe2Y4kww8tV4F9cZ+HYtu2efp2cCcy5g4fMHYk8z
 XHu7CimqdscBhTUC3FUl8NAqwn9dA==
Received: from sj2pr03cu001.outbound.protection.outlook.com
 (mail-westusazon11022143.outbound.protection.outlook.com [52.101.43.143])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 48t6kjswgm-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 28 Aug 2025 04:11:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MABOxmJ+XXNREsRpnGY1QqmumkskiIg5LcEmYD3PhxSIjvI7EeYLOO6Z5+tw3nVX0SYv9eBa5h6bGqg6QWcFsUsjV/yX9wWc9BZ8YZYw5Gr91jbqqcAPKRAHjODONh2dKklzALZ2VB1YmdvljRWhUkKe/yf/yIbflYu8f2KcnbIRE872bLp1j3znCgCu4APN732VCzztdlcWhPMt3RSZUqaSaZ9ApWsUc1U08lLZkdxoYpZfLpuAspi8xkmALXv/QB09rxDt6dIKsVaH2mYXyr2xqOHiqMFwbGUAFWob8ye+sMzzPm8wZ6T+z2EXiEYTRJbCzSUq4pLvJC95vVFnYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t/aq3Kyfbbbp2v/c+E04KedQxfbtJa87qBRWGYV8TEc=;
 b=q5UMVXIIHibwcjd2EXlbg35TDAP8obxOv4BnjYUSI1+1bIgy7Db89Q8vYWK07jkz1fVTPFS1L4YOUnOotoX4hxPQUSsI8dgX8qJ0ucJBkgVwfzZCCocClLvQmoPVwobyLNKwce4/fCL12cXT0Ny0vVRdCgX3KjG7uQszw1Q23ZHRFQAyBZSnRWa/dHi45crcWs+eytH18BwE1LA1Eho8Z3kJQ2EsintTZQvUlDYG7y2ATZPg/WI+wPyXnMHo2DhipDLghe7dbvuc7/S7rVytLYZ06FUWSHvq2aEbINqJ82NVklVkjVedIxvE6QXtUw4HYODB3Gk0pPvOYTErfLhCSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t/aq3Kyfbbbp2v/c+E04KedQxfbtJa87qBRWGYV8TEc=;
 b=NUA0mwzMVEKcxM7K/3mwwjG8+WMlFzzi4AclB3fgmWB/OYwdTWX0j1Wv5297q3z+5BmZjT3CJ0+kRCrKCD3OlH41uifggMZ6+Wy9maMOg0PaAfYy5pWX0gb67ypOhktnFtMb7wSU6MLAlonYwF3JAKTWhViv0NEox666a0vjW+RA7x8uXRLp0Pwvz37wwYsd78vFq6Ugio9MHHP8w3VCnBuUOlq6hvQfS7af/sCUg2b+qnfc7mu5r3eFdAfYW8NYiDESOQHbxxCBfBXzaBuI7ZCMGFkX5OClLhmDgqr0nmziNnyX1NIMEaaMhfxlEkc/OCce4KNy1lQgrb66nsIzyg==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by BN0PR02MB8077.namprd02.prod.outlook.com (2603:10b6:408:149::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.23; Thu, 28 Aug
 2025 11:11:46 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88%3]) with mapi id 15.20.9052.019; Thu, 28 Aug 2025
 11:11:46 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: pbonzini@redhat.com, mst@redhat.com, marcel.apfelbaum@gmail.com,
 eduardo@habkost.net, imammedo@redhat.com, qemu-devel@nongnu.org
Subject: [PATCH v7 14/19] hw/i386/pc_piix.c: always initialise ISA IDE drives
 in pc_init_isa()
Date: Thu, 28 Aug 2025 12:09:57 +0100
Message-ID: <20250828111057.468712-15-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250828111057.468712-1-mark.caveayland@nutanix.com>
References: <20250828111057.468712-1-mark.caveayland@nutanix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0P190CA0023.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:208:190::33) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|BN0PR02MB8077:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a89a0ef-a89c-4d62-b93d-08dde623ad71
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|376014|1800799024|10070799003|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UEFES0QxRytPYm41bU9KaG5XM3BadzdBSGx1VE53M1N4OUIweUtpWnRadjFP?=
 =?utf-8?B?amJ0aHhVYi9iTGFQQ0ZzTEJYeGx4Um5hOEZxOUhYNjlhK0M5OWxLUENEdmN4?=
 =?utf-8?B?WnhxWktzVndjamFPc0Fqa0xWVmc2QVhuWW4yb2RKa3dxQmxGRUw5ZllEa1dX?=
 =?utf-8?B?RnVCSVRGb2s4YkhXTEg2VU5BT3BHRDBOYnZmbjdGMkVwaEZYOXBsWitMZkFx?=
 =?utf-8?B?NHFndDhvQUI0aDF1bXU1bExtbG92S0VHSWNnNDUwMXlUc1RlZzlJRjA4aHZz?=
 =?utf-8?B?K2hGZTVRY2MwZ0RUYjNma2ZtNGRMem9MM2V6SjlFQTdwQk9pZ3g2Z3M4ejN6?=
 =?utf-8?B?UFhNWXJHNXVyUjVwc1hOaTlhNTlkRFFzN1dTTEJLbWtkWndnKzVvUWhsMDR2?=
 =?utf-8?B?N3RVWk9ldXloWXJKd2UxbjFDdmlsakh1UENUWjRoUzFpNTFiQlYyZUZEQnNi?=
 =?utf-8?B?aDNKWnoxNTMremtDRjBiZ0xjNkVtbzd3dUlRM0VjNzF5R1NEdW5lcFFZYmEx?=
 =?utf-8?B?NUpWb2JrUE5haXJmUTZvNUM3R3U3RW00YmZwWjEvOE5yS0h3Q2NQaDNpZzVo?=
 =?utf-8?B?NUJWbmNyNlJQR2VVMTJVSXNLZXNHeXltY1JwQUR5b0J2NmJQMTJHVHRsNi9P?=
 =?utf-8?B?QUFKL2l6M3VQNVRKVjZUZmNxQ1JmRUI1ZGo2ZWxDU1YvU3AvUGUycmV1OHRx?=
 =?utf-8?B?TUpwTnJUTmYrR0JPNXVQczBuR2YzSjZSTHRNSDBzT0tReXZMbHM0VGc0a0hS?=
 =?utf-8?B?RHZ2VUV3UW9tNTAwQTFtS3ZTdTdWaHRNVm0vTC9EYmNmeU9hUHVpd0FmVmpR?=
 =?utf-8?B?d2E4MFA1WG9iL2l6T0ZIbDJQTWZxdnBWK2p0S2xITzVSK05abWd0aVJCbXA5?=
 =?utf-8?B?UlBlWVNOS0xtZUY1UW5kS0U1WTdFVHdrTURXSEU3YnZBVUdwK2FPUndOVU41?=
 =?utf-8?B?VnBjaFBGTnpsL3c3bjh1dkl2aFk1QUVjVS9EbG96c0lwYzg1K2lySFZ5cUVR?=
 =?utf-8?B?aHFFVmdOc3F5alV1V1JDckppR093UGltRElHSG16RE1va0s4L0JEejRDTDY1?=
 =?utf-8?B?UDJubFVlSWkvR3FpWXE2a3h3M3Nkc2xVNWVQRHVNVCt0dnRVcjExallFZ3Yv?=
 =?utf-8?B?R3J1YTljd1pydC90SDVUT0ZURmFPcEJXOXJWR3V4Z25UeVROWENjdVQ2YldD?=
 =?utf-8?B?aENnUG5iWTFMRkhqOXh1ZmRhYUJ3cElFdTFQUDJaZ0liMS9PNjh2WDhXUS9S?=
 =?utf-8?B?SUNxanZDRVR6RGFrdDFybHpCK2o1MTRSSjNGL3VTaTJ3K1Vhd3BiOVhsSm9O?=
 =?utf-8?B?Vi9rYVBreUN2MDAxd1doMTAvWnVmSTdNQWFVVDhRSHFwSUpLbWgwb09MbVFX?=
 =?utf-8?B?MlNDbHF1bi9wQ1dTWUtCdmQrMG1LTXF6RTM1K0xVaGNHQmt0UUlUTW9GN0p1?=
 =?utf-8?B?YTVpR2llWi9paDM1LzF2K0R1My9IRERpdi9VMWZsZzNFT29lZ2JXdURuWGpE?=
 =?utf-8?B?a1FyT1hvRi8vaTJFVmtaa2hRa1BjT0w2djhEUWFmbitOdXV5MlFDMnY5Rm01?=
 =?utf-8?B?T1loZ3ZVcVVtOEN4VUhKeldPbFRLUnExS20rNzJMcnZsNmFvbE15V005djNw?=
 =?utf-8?B?MW43WHg2OTNnRzZXR0Y4Z1dTNmlBY2I5aWd0aHArUVNSUFVtMXFLdzc0U0x0?=
 =?utf-8?B?bnhYSlFhY2huRVhyZE5XQ2J5VFVXTnY5U2h4UlVkU25Ycm9LeThxUUF0aWdn?=
 =?utf-8?B?OFFDQnIvRlBhSzNSKzFzNkVUNVhTbHpHSmxuNUNpSDNEc01NVEhySFZDcEtO?=
 =?utf-8?B?WkhSZis4RFphTldrUGVpc2taRFhoN25JR0dsZitnTzd5ZEdmb2U5Ulp0emFO?=
 =?utf-8?B?Zmg4a3Job2ZteFlWek5adTJ6d3pDMzRDL0E1YnBaamlGNGc9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(10070799003)(366016); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RVp3VkMwUE5MV1Fway9kaEpNOEEzWXlmaVJ2Rk9GcW54TWlhc1pDTGVGRit2?=
 =?utf-8?B?QkdlM2pNL2E5dHhKMHNSRExRV0Y1Vk83eGRvQkV2bENzSmJsRk5xNDRHUXZx?=
 =?utf-8?B?aHBLbnY1R3NEZlFaL3pmNnozQTlIR0ppRHNpT2lGVHBhRkkxVU5KcmhpcE9r?=
 =?utf-8?B?OHF4Si9MYmUvdy80d3RPMmdZU3VxT1N3NXV5QXNHSzVScGM4MmdoUmJuVk5U?=
 =?utf-8?B?bTJrckFWbUlEVFpGSC9jaTh3VlVOVERwdVAwaEVxS1c1Mk5EcmZZT2ZDR0tE?=
 =?utf-8?B?Mk9YeHM3SnVtVDI4Q2V0c3EzSC9WVVArejd4VDNSV0hpbEhSV21CQmk5dnNt?=
 =?utf-8?B?QVhQMWhMZi9yWUV0Z3d1a1JWcHU4RnppY0lROGFUQkN4azNkdm1lamRaamVY?=
 =?utf-8?B?VG5HaWxxMU5FNEV4QU5BS2RxSUJxeDJKNW43NkVOVFh3a0I5VTIvVXQ2M0xH?=
 =?utf-8?B?cFNtNlZFVVpIdUZtZ2VuM2RIUXEwMzRqYjcreFFCdHI5bDRzOU9STXl6djll?=
 =?utf-8?B?amxDYm4xMjZva1JzL1Erc1NETXNuSGQ4dzFaNUFuNDFLcStEY01IODQ3RmEr?=
 =?utf-8?B?TlBoSDN2V25kM092MTZXb2N5MmxEODhRRmY4MUFEZjNNZG04ejZWcWVQTTFo?=
 =?utf-8?B?LzNxMDU2VTdiRVUxcU53TUE3Z1VqSU55a3BBVDBqb2c0c2c3ZXhqMnZ2QWJH?=
 =?utf-8?B?SDdSc01PZkE3UDY2Rzd3WEJ6cDc3MFRzVlU4cnM3b0g1dVpzSTViVURWVGZv?=
 =?utf-8?B?YStwL09udVRnK2RiMnhGa3dQeUowek42RGpCbkFrLzBENVcrSC9iWVIyLytu?=
 =?utf-8?B?MHVJTjJ0UEVBZGxWUklEOTVUMHpHalR4K0h3L21lUjA3OGYrK09YNXo1WHh1?=
 =?utf-8?B?R3c0aDVYSmVFeVNCNXpWRWNFeDlQbi85VC9HZkc0bjJ6dEFOcjVpSm8vYkc1?=
 =?utf-8?B?NFlpOWNCb1dBSWkxd0RnNUxnSzZyVUt3L3B3TWZ0KzFqTmRodzhjLzlyblgz?=
 =?utf-8?B?Smw4WmV4cUdqUjZ6ZnRtQ0V6UUIwK1JSTHk5UnpwRnZEQ3lxWTZMQ1ZWbk1O?=
 =?utf-8?B?aGdmUC8raTZscEVPMURENStUZVVpdGs5amlZOEcvaXZQd1VRY2V2U3BtOWtH?=
 =?utf-8?B?U1UxWnAxNzdZVTdZOVhMS3MxWlkyV1ZnMjJZSTNtSUM2cDFMNnZBUVBNK0hE?=
 =?utf-8?B?UzVlVmtOY2Q4UW04VG5FTXMxSEpoVEVYKzNRZkJXWHloZTJ3TFFxdWwxb2NF?=
 =?utf-8?B?ZzlRSWVGWXJEeEExdllUZ1NYcmdNd2R6dmJSeWpYVWFSWTJTK2t0aFliT3li?=
 =?utf-8?B?ck95L3JkeFU0R3lOOVFiZ1ZSVWxsUE15VDFSQUVIUlU0OVpYcElva1RSZFZZ?=
 =?utf-8?B?ZjVwOTI0b2lMV1R2eGpjOXc1S0tIUlpIQXhLZHRiS21ZTHdpQm1CcnBqWU9o?=
 =?utf-8?B?RitKUTVmYWJIdUFOMmVIYk9EQ1VweDhHN3p3VzhoMUJ1QUNNV0k1NkE2Tnoy?=
 =?utf-8?B?b0o3OERGbHYzbHdGeXpLOW9lUitScXh6NTlWRTRVWVpEeWVta0E1WG1uU25X?=
 =?utf-8?B?S1VGcmE5S2x4UkZxaEFlOE9LYVd5VkhVYmQwdG5OVWFlWENoZGNpekxFT1ZN?=
 =?utf-8?B?WjRTYU9JYW1XWWMreXV1Nk9STXIwN3UwbFdQbHUvWmR5Z0lQanF6VW5zNDBL?=
 =?utf-8?B?RTJXaUtienQ5ZzRBRmRERGVjQjR3MWdNWCtMcHllanVVUisxS0pMS1RDS3Rx?=
 =?utf-8?B?c2JnVy8xU3NXUUc1VUpkVDNBK1ZoM2I4MGZWZFBRL1BGYTZvam94RDZXNTdP?=
 =?utf-8?B?UVd3cTJPeTFCWk1lS2FiaEhWcG9mZFZKOU9uYVJ5eHp2Rm45K05NakIxdU9X?=
 =?utf-8?B?d3FLek11enloVGxYY1VNdE93cFUrWWVLa0Foc3BqNGVKUW5Cb2JlQlNqRFV0?=
 =?utf-8?B?V2lERTFkUlpGcGZOMlJoY09lK1JZNjVTWWFlUFpvUnBzdElMQzI0VDgxRk5o?=
 =?utf-8?B?VkVSUVVHT3IvbVlDNnd3dmhNek01SmJwWmhOZzV6WVJadXZucnFjQXd3dFdF?=
 =?utf-8?B?R2RLdzYxVDBKbXNpajQxdXlYbnp5cXg2eG1lOGtRaGFCWnlQeUI0K2dPd0Nr?=
 =?utf-8?B?MkRXY01Sb0pVZmtyU3cyU2lzek1Md1lqbGp0YUlZdk90SEJUTjN0NmU0SS9h?=
 =?utf-8?B?ZlFPSFNtQzFKM0dKdURYdzdaT3gyMHk3NG50RTlWc2x1UnV1WkF2dk0yRzdN?=
 =?utf-8?B?RlkxVy9GaTB4Qi80d2dLVkRaYUFnPT0=?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a89a0ef-a89c-4d62-b93d-08dde623ad71
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2025 11:11:46.5223 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cNp8aHM/FYpnG1Pmdwb4u047kkhW5iGCXFT9c67A6upX/bVo/A9ydLQFDXaUljRp1/V/JmGDFqwAAwKZeqO+sXN/YW7w7FYn6ko1usLc3GI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR02MB8077
X-Proofpoint-GUID: P1MGptFVdlL2u2kG8XUuEhYfc5DBQlhH
X-Authority-Analysis: v=2.4 cv=c+WrQQ9l c=1 sm=1 tr=0 ts=68b03978 cx=c_pps
 a=ofxP+VRvIeXlqxG7dm9PvA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=0kUYKlekyDsA:10
 a=64Cc0HZtAAAA:8 a=KKAkSRfTAAAA:8 a=QyXUC8HyAAAA:8 a=jCzY28RqhW9EaxlX9oYA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: P1MGptFVdlL2u2kG8XUuEhYfc5DBQlhH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODI4MDA5MyBTYWx0ZWRfX13sExPD9NYyQ
 st4YG6Dguz5UQasBliqfL8ZFc7zWQOe9v64lTyUmsnG7MrtqVuT1botCmm9FhTkJXaBkeZjn6lV
 GYRt3ITSe8VBDx7QL0EExqsXXNUG1uHXqSCZ/EYJlJgSv1tZqlmQxt3iVchIJxibdnoWjScpHin
 p6oii191L3h5Q2nGrboJT8X0IkI4N98aS8ErDJbCyAKlj0dm9CZHrZtzdEf0Fd/Y+2GN+vZFj57
 qkThdxm66WmjzT7147DzBKx1pr36LQpesXA/tbX6gkFVhA9wsA/Nig6sUMG9Ipt8DwoktnhQMZW
 GmGMR0V1qt+D5RYZ9sjbv/nuP67GBm5QiST/WHG+eeRPPVBn+aPSuy85KC4mBQ=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-28_03,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
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

By definition an isapc machine must always use ISA IDE drives so ensure that they
are always enabled. At the same time also remove the surrounding CONFIG_IDE_ISA
define since it will be enabled via the ISAPC Kconfig.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
---
 hw/i386/pc_piix.c | 35 +++++++++++++++--------------------
 1 file changed, 15 insertions(+), 20 deletions(-)

diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index fb936748bd..72ddd9b149 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -445,6 +445,8 @@ static void pc_init_isa(MachineState *machine)
     GSIState *gsi_state;
     MemoryRegion *ram_memory;
     MemoryRegion *rom_memory = system_memory;
+    DriveInfo *hd[MAX_IDE_BUS * MAX_IDE_DEVS];
+    int i;
 
     /*
      * There is a small chance that someone unintentionally passes "-cpu max"
@@ -541,27 +543,20 @@ static void pc_init_isa(MachineState *machine)
 
     pc_nic_init(pcmc, isa_bus, NULL);
 
-#ifdef CONFIG_IDE_ISA
-    if (!pcmc->pci_enabled) {
-        DriveInfo *hd[MAX_IDE_BUS * MAX_IDE_DEVS];
-        int i;
-
-        ide_drive_get(hd, ARRAY_SIZE(hd));
-        for (i = 0; i < MAX_IDE_BUS; i++) {
-            ISADevice *dev;
-            char busname[] = "ide.0";
-            dev = isa_ide_init(isa_bus, ide_iobase[i], ide_iobase2[i],
-                               ide_irq[i],
-                               hd[MAX_IDE_DEVS * i], hd[MAX_IDE_DEVS * i + 1]);
-            /*
-             * The ide bus name is ide.0 for the first bus and ide.1 for the
-             * second one.
-             */
-            busname[4] = '0' + i;
-            pcms->idebus[i] = qdev_get_child_bus(DEVICE(dev), busname);
-        }
+    ide_drive_get(hd, ARRAY_SIZE(hd));
+    for (i = 0; i < MAX_IDE_BUS; i++) {
+        ISADevice *dev;
+        char busname[] = "ide.0";
+        dev = isa_ide_init(isa_bus, ide_iobase[i], ide_iobase2[i],
+                            ide_irq[i],
+                            hd[MAX_IDE_DEVS * i], hd[MAX_IDE_DEVS * i + 1]);
+        /*
+         * The ide bus name is ide.0 for the first bus and ide.1 for the
+         * second one.
+         */
+        busname[4] = '0' + i;
+        pcms->idebus[i] = qdev_get_child_bus(DEVICE(dev), busname);
     }
-#endif
 }
 #endif
 
-- 
2.43.0


