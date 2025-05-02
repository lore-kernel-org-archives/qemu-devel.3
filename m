Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCE2FC3ABA3
	for <qemu-devel@archiver.kernel.org>; Fri,  2 May 2025 08:55:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAmAZ-0000gi-59; Fri, 02 May 2025 04:54:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1uAmAW-0000gT-QG
 for qemu-devel@nongnu.org; Fri, 02 May 2025 04:54:52 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1uAmAU-0003so-07
 for qemu-devel@nongnu.org; Fri, 02 May 2025 04:54:52 -0400
Received: from pps.filterd (m0127840.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5422MIL2028202;
 Fri, 2 May 2025 01:54:09 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=Tb7Lhn+uwzFGuq+zsQjEwS6A53LnmZvQIek4pM3iz
 t8=; b=EXMqetb1iev4hRG7qPtzliTkdsHPGe16zuT9+eZ9/lGPkCUcONpeaHbot
 R5d51E8nui9Bdp/yLzkak060gwFiwJZ8Ch52kf2W72cwnN5b7pa/6i53dma4+pHy
 ulSGHWMkILMmr9ekZl9wTds1P9KhSWOGPt9tzYXxWvQWsv6rnVin22ocl4yqP65o
 cj2umCfRUXM4Cm30nULZ4y9srt0dzMB1064U9JRkNU4+V/tzRC6G77YRB8gwOnFQ
 /Apup24ks10uv8CzwUhz+yG3TX5tIRTCC+5EgvSN2ww+5w7Zdv0E/eMREaH6q+Fu
 WOI+3BQuDDJgklg2L+GKtYr/uMr8g==
Received: from bn1pr04cu002.outbound.protection.outlook.com
 (mail-eastus2azlp17010023.outbound.protection.outlook.com [40.93.12.23])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 468utudd5y-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 02 May 2025 01:54:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g9Ov55vuE7+jHBNZSgucTWJUhImALYJBwxaXJxDvVB2lcvjS3S5vYylO5lliKJ0b3YgExfGKo7hBu22ReXGihCDNs022xlGuhAoKDoG2VQDr0i+Jd7G50cb49FHgMac2dC4eZzdF8j1DdBxVpNO2jWVjQ8q8YN2HlRFCHtUOTjNG4xFTUhx2t0CPaaoUmh6GlKsX/c25+T7fidi8+4h7VpuZQjS9GiXe8L2gkLw4M6pj0lp5ktK/9kcvU6hIoNr5DDdH6ii5NyeLTgqzzjaMbsIam3nkh9ryYivFolq1FDQ+22i9FvGbwiZOgZJ+Fjnwm92vxxy/G9OawNkQXzlscg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tb7Lhn+uwzFGuq+zsQjEwS6A53LnmZvQIek4pM3izt8=;
 b=MJoowbk3wDnfgr/wZJDUXiIdmEfC7rwyElSttxKchgExXd2zyG7lpyiHx/QW3AtbIHUu8rSpmXY+hOXin4TcZsT48O8fv0xeSJkwxbWk3ahhJPhuxvxMnaerDVK5NLzfvsgupRofWHzfxbwa4wreR7odx4wkFhrm0PE1TUTBLhMyrv9gZYgZslTLF+eceRL5xAUp8bQnYX42yb4dE9jIZ52WYqjbO/0Qa/t4Ni2JN1SqX7qHMPfHOisuMWxHTJq8jODQIFj7Ab9iuYRq/4xn8rYSKYRbudTqINL7zXK2KuWzs2/Qaw/tZH7Llv1pZqJG9xvjn0vjJfAa5vTMTs19BA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tb7Lhn+uwzFGuq+zsQjEwS6A53LnmZvQIek4pM3izt8=;
 b=c7Hx0oDgufehc/cv18mgyRmD8jxD8K3tm5jFVtkxQE7w/khe8sEJXLb0gmpySSYlgWpvwVLxbCybtU8woOOM2PVryWPVq3ztezXfmYQ+cqOXGEXxRqjVYfwtlfYJrYIUIHnpd2PPN50SDGrkFxOGjDDOW7zLLaAHq2Yy5/NCBcOmma9FzkAd0STaC5PwTNDIr8GDCqL/e5eAJtluemUGLbgfq1LjboxL5TyMgNe5yIwKdw4R/QckeDw+HPWNKnz5qttFu9gZORAWdslWxklx+sJzU9K89uTdCBH8IjEhmsLf8AB3xdJRlGqTSNRYCYwGToFmo3k5T5LiUdkZG9VTIg==
Received: from DM5PR02MB3356.namprd02.prod.outlook.com (2603:10b6:4:61::16) by
 PH0PR02MB7319.namprd02.prod.outlook.com (2603:10b6:510:1e::14) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8699.19; Fri, 2 May 2025 08:54:04 +0000
Received: from DM5PR02MB3356.namprd02.prod.outlook.com
 ([fe80::72bd:6790:f9e7:f241]) by DM5PR02MB3356.namprd02.prod.outlook.com
 ([fe80::72bd:6790:f9e7:f241%3]) with mapi id 15.20.8699.012; Fri, 2 May 2025
 08:54:04 +0000
Message-ID: <5d4158af-1063-4edc-ab58-0decad5bd57c@nutanix.com>
Date: Fri, 2 May 2025 09:53:57 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/16] hw/i386/pc: Remove deprecated pc-q35-2.6 and
 pc-i440fx-2.6 machines
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Igor Mammedov <imammedo@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?Q?Cl=C3=A9ment_Mathieu--Drif?= <clement.mathieu--drif@eviden.com>,
 Yi Liu <yi.l.liu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Amit Shah <amit@kernel.org>, Zhao Liu <zhao1.liu@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Sergio Lopez <slp@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Yanan Wang <wangyanan55@huawei.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Ani Sinha <anisinha@redhat.com>, Thomas Huth <thuth@redhat.com>
References: <20250501183628.87479-1-philmd@linaro.org>
 <20250501183628.87479-2-philmd@linaro.org>
Content-Language: en-US
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
In-Reply-To: <20250501183628.87479-2-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS4P189CA0016.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:5db::8) To DM5PR02MB3356.namprd02.prod.outlook.com
 (2603:10b6:4:61::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR02MB3356:EE_|PH0PR02MB7319:EE_
X-MS-Office365-Filtering-Correlation-Id: 33bcee5b-fe24-4c0c-3d32-08dd8956e360
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|1800799024|366016|376014|7416014|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?T1ZZNE90T1JPb0dwOTV1ZHFQMXluK0JnQkVteVJOTE9IUDJSVWF1Sk9DSU4r?=
 =?utf-8?B?djhwYUFnaWs5YVRGNnlHbEN0Z1RJM1Q1M3BXZ3JxY3pPMDFsUGJudjJvenN2?=
 =?utf-8?B?N2FyUFNJQnhJRVp0ZmpYbS9rVFdzZW1PR2sxR1VQZTRIZ3VxeXJVYVN4S3Zi?=
 =?utf-8?B?bWtFQlRBYkNDenVlNmJwbUt1RktPcFZXdGpRdmJOUlNvcFBsTE03elRxOU9t?=
 =?utf-8?B?dHJJMGV4QmlaTUVSNHdIV3ZyZjFOdTlnUUg2RmtNdXY5M1NrK2RZTDRScjZ6?=
 =?utf-8?B?T1pEdzRGUk9VcjBIZGlab05IWWhPcjU0cndvS1FSRTlPOFlhZndycXUyY0NU?=
 =?utf-8?B?NUl4RVVoY1oxK0xwR241bU1GLzNZSFBSMnV3UHFydGFuMUNqV1BUSTBjMDhB?=
 =?utf-8?B?U01zd2J6cVZiWU9BNW9ZSURFL1lIcHNKYWllbE96MHpsSFM0a21EdDZNWDJv?=
 =?utf-8?B?OGFNbTI5WGJIVlBEVUpQUEd0aVloeDk5cVF5QmF2MlprYWhwT1lrOHpyK01B?=
 =?utf-8?B?dlo3WHpVaHdzZEl0c0J2SmEvY0Z0QUhaaU03UXRaNVNYZXE1c2V0bjZhTGNr?=
 =?utf-8?B?NXY4QzNxaTZ5d0x3MHFhTU9LWGpMaDljMmcya3IwNHkwZWJya3BQczVBZTds?=
 =?utf-8?B?Y2dWdmp6cDM2WmswZ1hpWjZHd05RakN1M0U1R3V5RTVxcEYrbWVjUTBsMURy?=
 =?utf-8?B?MFY0TjRXdDZZU1l3WFE1RlBpdExVcU1Zd2VaaHVxZ00reWZPYnc4d3lKQjNX?=
 =?utf-8?B?QzVXRk5tRklGYVpvVzhvQzl1QlcvUWl1WkFvMTdZUTNtTVJTT0xMdkdsTEFr?=
 =?utf-8?B?byt1N3J0MC80a1BLVmltcVl2NDRTMGpPL0ZNYmc2VlNQS0Q2aGdRUnRuWDNV?=
 =?utf-8?B?RTlUd2ZVb2QvQW9wTG9od2NoUE9tUzZHc0c5WU5sTUJjN0RVdURVYjNxUXRE?=
 =?utf-8?B?MjcydTBHYUpHd1VIUGtnS0s1Z0JNMmJNRFZvLy8zLy9sTnhoc1cvTW11Q0Ir?=
 =?utf-8?B?K1pWS09aeDZFdDgwbUZRdFFScHIvRHJ5blFZSDhyQmdkbjdLSkcyampBemc5?=
 =?utf-8?B?Z2M1MTJxSGhsdThnYVhvZllnVXVGelNlNUo0SGlBL3JSZysyTUVTUHlLOW9h?=
 =?utf-8?B?emtJUEZsYnlEKy9hZjh4MnVxQU5FT3VRU0lDanRvWWtuSFRBbU41NVpKaVBP?=
 =?utf-8?B?aHoxTW1SWlhjbVhPU0ZtTGtiYlpsQWdZcnc5d0VvbFN4NGVpZFlSR3BqL3o0?=
 =?utf-8?B?aWxuZGs5MlRCQURNam1UcXcxM0M5blBjVVhoWUU4d2pFZVc2RW9kYTE5TEpS?=
 =?utf-8?B?UGliU0ZBUE5DUUlBV0NFMTZPcDRVRzNWTmM1eVBmRVJUR04zZitmVEpOUUtQ?=
 =?utf-8?B?eVEwMzRqVzhhV2t0NFU5Q2xJWm9Sdno0b0VwajgzblUwazNzNjNQRzFwVndz?=
 =?utf-8?B?enVlcms3VGlxUnZlcEFuc25WakF5M2xpbVhYdk1Na2RsVUpoUmMvVDZBS0hR?=
 =?utf-8?B?dEJ5U2JFOFRYN1lncWJDWkY5K09aYXhHQVNRZnVPYmVDb3VqSTlwTkp4MWRE?=
 =?utf-8?B?Q1pZeWE4MUorYkh5Uk9JRkhnN0k1M1BBVGcvZUQxNWNSUHRidFd3YW43Q0tK?=
 =?utf-8?B?Y245MHdDRE55bG9sOStmM0VFVjN6cEFwVzBwcEt3U2JWTGxoWDRaaU9HbEdh?=
 =?utf-8?B?dFIxdCtZcm9SMDFHVzJidWgzUHNYTFZQVlZ1TnJCQVRmbk5XSG1XaG1IVmZQ?=
 =?utf-8?B?T2ZTR0o1RFd5aTBZeFM4VEphbVo2NXY3UFRSd1lCenV1OXIxM0lqdTlzUGl0?=
 =?utf-8?B?MHUzaEoyU0UxcTNjQXMrWHNqMEZtWmpLZFA5aWFvc0l6ZWRuNFVnQXRlR2Nw?=
 =?utf-8?B?b2VHeXV2Lzc1OVV4SGdSeDY5L3FEKytCZU8vNGc0V1JkYll3ZGowR2t2b01a?=
 =?utf-8?Q?T/Xeqp34MaQ=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR02MB3356.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(1800799024)(366016)(376014)(7416014)(7053199007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NWNSY3l0amwvTlNrZnZnRmE5eGNSWkhTa0lyeW1MZEpVaXB3YmNCdEpvMW5p?=
 =?utf-8?B?OXIyWEpnSGplZ1dMWlljOVZrVWFoNFo4SlVJQjJ6ZlNzcDVyOHRYeVV4R2wz?=
 =?utf-8?B?SldYV0xwdTZNTXJ0b254UUE1Nk04b0lISTRKZVdhcFgyOGp6NUVUOVZ0aUxG?=
 =?utf-8?B?YXp5RmFUaGNyNUdxRG5NSEFocGw4SnBmb09uaDhQaHlmZkdBclUyR0FXZHZN?=
 =?utf-8?B?VzhtdHJEVjFMc214ZnV6ZDJtSjRlalVBQmZpM0Z4NXl3bVNTakxlcTN6ajFq?=
 =?utf-8?B?Z0xTeVc0VW5ETk1yd3N2WHFOV29NRzFneU43UlhETzljbVJWNkRBNmVvMVpP?=
 =?utf-8?B?ekdCSGJqMVY3VGlPdVVYRXdEeUthc3g5V2xwTUVUY0tQMDdlUFp6dFRSL2VY?=
 =?utf-8?B?OElLTkxZM0dmN3dpZFpQOGIvd09mbDlFNWVlN2hOUG1GSDduT3Y1Ny82MEJY?=
 =?utf-8?B?Y0xkeXBsSFpZWWFIMDBZMlpNVGx3WGVkSnhJOW5jTkx2T0plR0xIVWdFS1VO?=
 =?utf-8?B?NGV2aHRCL2t3bVRzdGtCTzBnM091U0xxWGhub1NmSlF1d1hBRlk1VjJvMUd2?=
 =?utf-8?B?ZW1BQTZWVEd2c2U3VUIzSWdQbVVOZ0cvRDl3MkY1MUNYZUJic21zL3JseFdj?=
 =?utf-8?B?anZFWjJUZzJ0cDFvOWVjbFJIVEVSWjdONDJHMU04Nlc2TFljMHZDZWRzSkw2?=
 =?utf-8?B?d0hGV3VwRWJDL1NYMy9wWlkxWG1pYWgxT2RFNlBuRVVvbVkzNDZxTXBuTVNT?=
 =?utf-8?B?WERkVlNwNE4vUCtVbEZyc3lPd1hhK0FINWhIS0JnemlDOUZoajJCNUE2UE9o?=
 =?utf-8?B?ZHQ1cVJUOHpydk56OU9VZTRuclh3MkNwTTlOUmZFdVoyQll3Vm9QbzN1WjZ2?=
 =?utf-8?B?dFlyZ1U3ZXRpaXVuekNaY0Z2OVZ6Q0ozK0orNDhEVVZuSlJBOEloZHpaOXJs?=
 =?utf-8?B?d0RVTFdtakxYSldjb1lOLzgwU3diaFJNRjJHL2NHdmZjTXdJNzZoeUFFRDR4?=
 =?utf-8?B?dXVJemVBVU8yZW1kYnNLOUVMNndFMnJzTEp2QmRnNmRaTmRqOEs4K0ZlbFZV?=
 =?utf-8?B?U2NFQ1k3UzcxUjEyb29uZXd2dU1mQVIzdXpyMENFUVRRWTFJQk1Ta1dYanhR?=
 =?utf-8?B?RUNJVGtBNy9XMjlPV21tczF6VGtiTTdZcC9rc2swMjJheVBCczk0OEkra2Fr?=
 =?utf-8?B?dzNxR2ZBN0lZV3NZWUVJN2FvRnE5M2VMK3A4Q3FYWUtNSEM0WDQ3MXN4L3V6?=
 =?utf-8?B?QjdNSFFhNE9kTE5DVFZBMUpLSGhXYXlLTU1IWDNWU0dMZ3ZKY1UvY1hNTFNz?=
 =?utf-8?B?cU9YcGQvZmhqMjRUeE5pSmo0dGZxM3pmSytFRm9kRUh6MktBb1NMdy9mQkxG?=
 =?utf-8?B?Q0xvdC80eUJUek9QZXBzUWcwMGZ3bzFGR2NlYlhqUjVjZ2JQcjJwcnRuVFZl?=
 =?utf-8?B?dUpKK0ZBRWJ6UTh0ZlYyNkh1SVZnbGpiM2JXQUwzOWVhQ1JBdk5OcW9nQ3lx?=
 =?utf-8?B?SUVGMEk1SHNPVGpjSE9oRXpIbWpNb1NRS1k1Tm8zSmYwVkV0dlBZVDJXd3Nk?=
 =?utf-8?B?anpxbUxIbVFmby9MWW81WHVLVmtaWnovVEl3aWVuRk9rSWhreVk4K0pKUE9s?=
 =?utf-8?B?cGhxQkZEeUR5NzkvNkdEc3RPMldVNjJmcmtMK2lQZzlrSlRwMzhEQ0U0TjlO?=
 =?utf-8?B?dHJjVG9sUW5PWElNV3F4Yk42N0l3WGQ2OER1djZsenlxNkhPV2lNam0rUEo5?=
 =?utf-8?B?MHdIaVZxc1NyTkRVV051M1NYSmkzRUM0ZWFFYXU2UkFhUXExYmwvRThIV0hU?=
 =?utf-8?B?ZFVvclE5ak5LWGZ6b0VneWs3SjhZcFZhaDVZaSt6YUt2c0FZdkNCWHNSWTJU?=
 =?utf-8?B?QWU5R0lTNkhRMkZnN09vR2Vnbi9CSWpndUF2MmlWR0hxUUgrOHAyZTZHcWcy?=
 =?utf-8?B?RUhrNXVScmpOdUJqcmdyMVNpRVhweVh6emtIM05jelp2eU9pcHBpTWsxRVdo?=
 =?utf-8?B?TDlMQ2ZQKzUrWldWYnFvRDJNRWNaUjNIT094S0paVVJqa3RMYnJZTE9Ob2tS?=
 =?utf-8?B?T0RZRnJDa0FCYzlqbDdsTXU5TDE3SWx2S0hiWS9rOXYzQXFWeGFHdFN1c1hP?=
 =?utf-8?B?R1ZlS3k2MVNCMlB1Z01BRnN4QzNtSkhUQ0JlZE04d2MwbGVFYzdad3ZlZS8w?=
 =?utf-8?B?Yk5Vd0VEdXhxVUNGSUQvc1lBK0VOTVdUV2pZbThJZWtPK0NnQmMvNHFjY1dR?=
 =?utf-8?B?VkVSY09qWUpGZTJ2dm1vU09ZUXRnPT0=?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33bcee5b-fe24-4c0c-3d32-08dd8956e360
X-MS-Exchange-CrossTenant-AuthSource: DM5PR02MB3356.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2025 08:54:04.2360 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cOPuGm6ZJ2E/J7GOBOPhsAOeISX/fqwPshh61gfA/V8ndu1qDhQ3T4xNt8Jd/6C6Fei8p+j+0lAuVu2HxYvk4wzoEcxYiwOkDnsngBrXkCQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB7319
X-Proofpoint-GUID: FMUicqx0KvuplQO2LlTT-D33Avzai5IN
X-Authority-Analysis: v=2.4 cv=GcIXnRXL c=1 sm=1 tr=0 ts=68148831 cx=c_pps
 a=AwHzoy/LmQvuowsjLxKu5A==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=dt9VzEwgFbYA:10 a=0kUYKlekyDsA:10 a=KKAkSRfTAAAA:8 a=64Cc0HZtAAAA:8
 a=0GIqHX18s04_JbnTTRgA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTAyMDA2OSBTYWx0ZWRfX8GfPOqYWvQsm
 7fUwB53EpFaQ0f06QbDjpB3rdFty0FlLYjUU0I+ZOwRiOqVq1rWEXnaNQb+w8+1yK8UUiBFz+T/
 RqPOTxgD2P42NYJ44WhjGBHeQiWefjgQiDHlt/oykN86RhmVdq0bvklRN5eFs4vOr7ed9gk+To3
 WYQ0sMFHw0zsBzvheQk6qUJPoNX8I2ceCXrr863gFcs4DeW+cKIY8r6o9Dp1T79l7M1PCCUwBFc
 lXl5PMbazBSWJDScZFxwLR9JyT3pteYZxd3nHBOAahYIjgz2XVjTFFrLU4ghJxKBFtoD6EEnZ+y
 7+mggn/lnkeMQ0XMIUcZu7xZcqGMIMuu5ZO6HKIS7I9eu4LUOQYcYs5ln23xx8VnWI8nM36xMe2
 LEP1pAHv9257Y+BsoSVUS8DwnPbyW2LV8kDFQexbH3jPiRG0o3hoO6MOp+ZKylHzXLuHpRor
X-Proofpoint-ORIG-GUID: FMUicqx0KvuplQO2LlTT-D33Avzai5IN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-01_06,2025-04-30_01,2025-02-21_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.644,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On 01/05/2025 19:36, Philippe Mathieu-Daudé wrote:

> These machines has been supported for a period of more than 6 years.
> According to our versioned machine support policy (see commit
> ce80c4fa6ff "docs: document special exception for machine type
> deprecation & removal") they can now be removed.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   hw/i386/pc_piix.c | 14 --------------
>   hw/i386/pc_q35.c  | 14 --------------
>   2 files changed, 28 deletions(-)
> 
> diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
> index 7a62bb06500..98a118fd4a0 100644
> --- a/hw/i386/pc_piix.c
> +++ b/hw/i386/pc_piix.c
> @@ -764,20 +764,6 @@ static void pc_i440fx_machine_2_7_options(MachineClass *m)
>   
>   DEFINE_I440FX_MACHINE(2, 7);
>   
> -static void pc_i440fx_machine_2_6_options(MachineClass *m)
> -{
> -    X86MachineClass *x86mc = X86_MACHINE_CLASS(m);
> -    PCMachineClass *pcmc = PC_MACHINE_CLASS(m);
> -
> -    pc_i440fx_machine_2_7_options(m);
> -    pcmc->legacy_cpu_hotplug = true;
> -    x86mc->fwcfg_dma_enabled = false;
> -    compat_props_add(m->compat_props, hw_compat_2_6, hw_compat_2_6_len);
> -    compat_props_add(m->compat_props, pc_compat_2_6, pc_compat_2_6_len);
> -}
> -
> -DEFINE_I440FX_MACHINE(2, 6);
> -
>   #ifdef CONFIG_ISAPC
>   static void isapc_machine_options(MachineClass *m)
>   {
> diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
> index 33211b1876f..b7ffb5f1216 100644
> --- a/hw/i386/pc_q35.c
> +++ b/hw/i386/pc_q35.c
> @@ -658,17 +658,3 @@ static void pc_q35_machine_2_7_options(MachineClass *m)
>   }
>   
>   DEFINE_Q35_MACHINE(2, 7);
> -
> -static void pc_q35_machine_2_6_options(MachineClass *m)
> -{
> -    X86MachineClass *x86mc = X86_MACHINE_CLASS(m);
> -    PCMachineClass *pcmc = PC_MACHINE_CLASS(m);
> -
> -    pc_q35_machine_2_7_options(m);
> -    pcmc->legacy_cpu_hotplug = true;
> -    x86mc->fwcfg_dma_enabled = false;
> -    compat_props_add(m->compat_props, hw_compat_2_6, hw_compat_2_6_len);
> -    compat_props_add(m->compat_props, pc_compat_2_6, pc_compat_2_6_len);
> -}
> -
> -DEFINE_Q35_MACHINE(2, 6);

Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>


ATB,

Mark.


