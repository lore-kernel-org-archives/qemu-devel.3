Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 104C4C369DC
	for <qemu-devel@archiver.kernel.org>; Wed,  7 May 2025 07:03:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCYnI-000071-RG; Wed, 07 May 2025 03:02:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1uCYnG-00006H-9g
 for qemu-devel@nongnu.org; Wed, 07 May 2025 03:02:14 -0400
Received: from esa8.fujitsucc.c3s2.iphmx.com ([68.232.159.88])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1uCYnE-00044n-3F
 for qemu-devel@nongnu.org; Wed, 07 May 2025 03:02:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1746601332; x=1778137332;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=7c1o6s3Fs7euAys0yWcrgoPwfWqg18hkbW0CnhgZw+c=;
 b=fsljQIEVqQnibJommMWpEwMHi5A5SRUHNkd2p1rYdl+Rc4Tnmm9JgN7d
 hjdf/Nl2V/qUVHcXRYlHhdq/in9dvp88GvaLxAzRHF6pMPTmILdu+9auZ
 SQK1d1rVrVojyz9gq8Pv7ToicpL7uty0iG4eAPwdsK0OjQcydWlrY/Xw1
 5z9Z5LJPQH6ZXTZ6PmVduPZxJq1eTqDDAl5WqBJpX2Sm1BhPudYsVTePI
 pcL+FuwjiX5SFBsZy66/F/kotDQIIaIYfKkJ+Ka2eIVgXgTR6I6a0o6Hn
 mH1SfQDuKJFdmmYtnPw6w1/COuzV3fA9Ykb4Jd50sOjft7wML6rvjXgcH Q==;
X-CSE-ConnectionGUID: 5dQMGDdyQP+0zB/41cbCkA==
X-CSE-MsgGUID: 8+nROC85QTGi5ztRIPL71g==
X-IronPort-AV: E=McAfee;i="6700,10204,11425"; a="154733656"
X-IronPort-AV: E=Sophos;i="6.15,268,1739804400"; d="scan'208";a="154733656"
Received: from mail-japanwestazlp17011028.outbound.protection.outlook.com
 (HELO OS0P286CU010.outbound.protection.outlook.com) ([40.93.130.28])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 May 2025 16:02:04 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PRSGYHLbIYjlJsuRwtZK/q1O+A+XVAA2qXztL9KvYJk03CiU1By59gOTGt5htLQdSQwJtvmwSXLRuTx5EyrmnPuKqO36snjr+j6rbgohsCzMxfL778FR3sXgPS2qOowpv7huC2G8pdLlGwvqUoAZ5EZgBbac7OMoNrjZaysGqiM7mYGdndICIUmnmbaA76+C5xLy6X/SwLqrGeJK3rmvj7Q/iheU8pBnxKSPQ+ofGyTAs+xUlioh6GM0pcotBsSiBaHMO/sSEV1p0rx5qOPTGU/UjA1ghupwcgOga6TzFjYfy7hyzoH54vrliZA4ZIpC0bgTbBT4SOCJpw5alxJphA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7c1o6s3Fs7euAys0yWcrgoPwfWqg18hkbW0CnhgZw+c=;
 b=JGoXAsxZoxsq7oMJSxTYhrtVWdwYQVfOuI7SZ3NGb35fQIdVsHW10owBCmYQKGEC7J7GPfl5i7JSlf7GbqQYQCvqJvFyHu+l2Jw7DZfqd2bquv1u1dLuAbhoCpxXshIdGzFYJvzfGNGD5H6+iGoIVfUEHYYCpR4JyHa0d6ZBtj/N+IHl5MaLo+Y7F/uEceh5KdumKOSqycFJfwchXqHtPK3hPITwmSrk932mBMJl1/T884YNdiximRiP8JBgz6LUfkLYFZ+EXqlcRPrzz8ya6H6m9LKqc1QUeFMu2+q99wf/EpkNWpnd2kLyQuo+C2101tpWrPD2KCq7o5bTqtDioQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com (2603:1096:403:6::12)
 by TYCPR01MB5632.jpnprd01.prod.outlook.com (2603:1096:400:47::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.25; Wed, 7 May
 2025 07:02:01 +0000
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::d9ba:425a:7044:6377]) by TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::d9ba:425a:7044:6377%5]) with mapi id 15.20.8699.022; Wed, 7 May 2025
 07:02:01 +0000
To: Peter Xu <peterx@redhat.com>
CC: Fabiano Rosas <farosas@suse.de>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Jack Wang <jinpu.wang@ionos.com>, "Michael R . Galaxy"
 <mrgalaxy@nvidia.com>, Yu Zhang <yu.zhang@ionos.com>
Subject: Re: [PATCH] qtest/migration/rdma: Add test for rdma migration with
 ipv6
Thread-Topic: [PATCH] qtest/migration/rdma: Add test for rdma migration with
 ipv6
Thread-Index: AQHbnr3GPFM2rsTaa0SkDCwflcGbZrO7WJ6AgAC9noCAAAWmAIAAEQCAgADKDYCACgCQgA==
Date: Wed, 7 May 2025 07:02:01 +0000
Message-ID: <9ecf5d03-a64d-477a-9dc0-a02b567c92e5@fujitsu.com>
References: <20250327021234.264161-1-lizhijian@fujitsu.com>
 <aBFAIflmJns_nVIm@x1.local>
 <78c811ed-d6a2-4811-9ac8-48c5c93a2fed@fujitsu.com>
 <6aaafc7c-9876-45da-8cca-5b670b8ccc50@fujitsu.com>
 <396fcfe6-7ddb-41e7-ae28-e5210dea7dd7@fujitsu.com>
 <aBKbr3aVAxAwt2rD@x1.local>
In-Reply-To: <aBKbr3aVAxAwt2rD@x1.local>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Enabled=True;
 MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_SiteId=a19f121d-81e1-4858-a9d8-736e267fd4c7;
 MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_SetDate=2025-05-07T07:02:01.137Z;
 MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Name=FUJITSU-PUBLIC;
 MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_ContentBits=0;
 MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Method=Privileged; 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY1PR01MB1562:EE_|TYCPR01MB5632:EE_
x-ms-office365-filtering-correlation-id: d242f2b1-c2c5-4863-32b0-08dd8d351114
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|1580799027|38070700018; 
x-microsoft-antispam-message-info: =?gb2312?B?WThuU1BCZlFSaWhienRxYU1BRHN5UWp1dUdDTGxPVFBLQ21SU3NxdXlhaEVF?=
 =?gb2312?B?YWdacDBxQjJJY1BpNmxyS0Q3Nll5dnFadHJWcUxxb2xOQ3J6eUYwdWdBUC9a?=
 =?gb2312?B?RXJoME44YlFxemlKQjZMSTJwdjk5UkJqRnpYOTlKK3h4c083OGlHSm1JWWVL?=
 =?gb2312?B?Mi92YmhISTZrMWk2SlJwazYybmwzemUwNzRyTXF3ZnFMV1phSTA5WS9maUNs?=
 =?gb2312?B?Q3BTeDcwQ0hRLzB6U3ZSVXVYRmpzc29NMno1NHRMcjFwRzh1Q0JsUEt4OFlq?=
 =?gb2312?B?VWQzUjk1QnVXT0FBdHNEOC9sNDZqd3dKdTVoYlVvTkFFbFgxMnV6Qk5vb3hm?=
 =?gb2312?B?ZzROR0xPVjdrL0NyRTVlRlZROEJpd1dWUWd4MjdHNmI4Vm0zMVZxbkdyTmxE?=
 =?gb2312?B?L1JSZXloUldkUUNSTnlLKzdDVTNNWFBVVkFkV0VkZmF0WDRZenM2RDZjZU9Q?=
 =?gb2312?B?R2UvOEdnVE43SmdwQVpIdTZYTVJwQlAwdEdCRVBuc25DZ3gyem1EK3ZXaUUw?=
 =?gb2312?B?S2VZeHo4eFlpR09hMVQwaUtvaGxLUnhWL3EzYTNUTHArZGxRdTFKS2dzSDhO?=
 =?gb2312?B?ZFpHV0RnYTJvd0JmNjJMUFBBRFowRnF3WjlCeC9DTzJRYTVVWXJyM2ZrTkJW?=
 =?gb2312?B?MHJpM0loRlduUE8vL2ZkRHJ6WnVkcjBCVFZFaCt0S3ZvdW1LZEFKODk3L0dK?=
 =?gb2312?B?K2ZLR0drOVpXN3JNNnVYR0cxaHVuYk00Q1J3dlVuL1c1MERFd2JqQTRKV0g0?=
 =?gb2312?B?eW1OQ283azNJWmFKbENQVlQ5NnkwcysvY3ZFdzAvK0ZVS3NLT1VqdWVKMElW?=
 =?gb2312?B?VC9QT3hqeGV0YUloQUtEZVhnYU5YR0UxTjFkenltQjRwWXNpSWpoQnUxRTdN?=
 =?gb2312?B?c1ZHWmhDNjdXL3Yzd09TTmlKMEFCQkU2Y0oyQVR6aFdkM2htME1VSDlPNGN6?=
 =?gb2312?B?RW95ZFpOWnQvaGNwZXZhenBBR0dmVG1uamo3ajcybG1tazJYbWdqby9hWGxr?=
 =?gb2312?B?T3cxT1E3ekludlc4SFpMd29NRFg0WSs1czBlaERqQUFRRWVQMFkxeWM3aW9k?=
 =?gb2312?B?VWFvTk9FTis5SzhaZEcxT0VYN041R2FTbEcyMUVTVjVuUGw0aGFEclBIZktC?=
 =?gb2312?B?YW5Za09uY0tPbVUvZCtZMFdvc2NvV0k5SUdyRTRwSWY0aHY3cUdOTmQ0OTVP?=
 =?gb2312?B?YW5LdExDNkFseWV0dTQ2SEJXek9QMXhFUkhaL01JMUFMcFoyTXBJcFk4dUYy?=
 =?gb2312?B?SGpWcUgzNXlNczFPRGM0eXdrL2MxU002R3lDYWYvbTRlK2hwNitKSjk5Y3Nw?=
 =?gb2312?B?d0JVSGRtY3ZZUWxYYzZlZlh0U0RHU0tHOWJYRkJkYVVYU0NtRTg1bkxTQjRv?=
 =?gb2312?B?UmZJa2VWbHVmV1NGSTIrTnZxT0dYamx4YWVDSXFWeFNoREVIbmVINnBWMnY3?=
 =?gb2312?B?bUVicXF5TTlXU1g4c1ZkUzNFcW8yL202NXhVZE9wMG5qeDhYTUFYVmRsMjZ0?=
 =?gb2312?B?ZG84amFaMm0wOWJSbFl3aHRxa2QydXpOa2F2MHA0NU13THdVOVBBV2hWWHFr?=
 =?gb2312?B?bWdOb0p6KzZHSXMvNmZqUm5naU1VYjk4THFuaTZac2l6aHd1c2FzMW1Odnkr?=
 =?gb2312?B?ditISi9DZlYyUkF5aGpjN21pclBVa0wwc0h3RkZIYVVPK3VYZWxvVjBOVy9v?=
 =?gb2312?B?WVlJajRQU0cveU9NK0F3bGpjS1dtTFZkWVNMY01kQUJ1bU5OUjFSYXFWY3ox?=
 =?gb2312?B?OG9wSmR2QkJ6NWRZeWdpZGlWQlhBOXU5ajE1Q2RzckNIaHdQWWdGRHcvdXlK?=
 =?gb2312?B?cllJb2ZhM3ZDYmU5RGFyWmV5YnRNcFVGYzRudUxFTk8xRkV5MU9HWlNsVllp?=
 =?gb2312?B?YXZxUlVEZTlEY0JXWEFMQzRNK1JJWWtmUFFhcjRsVHc1bW04c3NDN1E5d0Zl?=
 =?gb2312?B?YjVHa1pla0szam14dDlYUnhWc21mYzJNb2FNZzFBK3VnaDVTUEhHRnZhSmU3?=
 =?gb2312?B?T3k0TlhIc0EvTlJ5aFJ2cnNpZGUyOHRGdU4vc21Tb091M1FCcmZOeGZoV0lh?=
 =?gb2312?Q?TpHCV7?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-cn; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:TY1PR01MB1562.jpnprd01.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(366016)(376014)(1800799024)(1580799027)(38070700018);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?R2Zkb1kvbXU4QkRMTk9uMUdrUnhtd3M1VndoUHczTU5jcVUrcDIwRVpMa21O?=
 =?gb2312?B?TlovVUFMZzI1QjdvRVhTa25sNXkvRE1aOWJYQmVpOUFOWmxRZnhBQXNPUENZ?=
 =?gb2312?B?d2lOcGd2cGFFbnVLdGZnOXA2OE9WUlNvaE5hMjczOWdkTGg2aXlBMVRjY0Nr?=
 =?gb2312?B?VjAvZXR1WWVicDVwbjhGcU91OWQ2dUI4KzdJSW5KZGNCWTBMamd4U0o1Yk1L?=
 =?gb2312?B?NGNXUFRSUW4xU2RaQjJlNFAvMUhtbkl6bFhrZGEya0RZR21OTVF2anZ5KzVw?=
 =?gb2312?B?aXYwVkxJQzg3NWdPWFN6UVRBNlJ0c1dEVWcwQTRTdG0wTzNTdTRwNU00Zk8z?=
 =?gb2312?B?THZOcmlpOWpYMWdLV0IyNHhiQzlBTEtucmVJODlPc2hzU3daQ1VOUXRzdHI0?=
 =?gb2312?B?TDFVWmZRc3dJek5Hd2JpOXNvR2FSd2U1NndsRi9vdWtaQU45bkdOWkdPQ0pJ?=
 =?gb2312?B?UStEMXpyWlBHbUNJTXcyQm1tOTdCOTFka0xhLzRCZThjVkNVWWliQnZDT0Rn?=
 =?gb2312?B?Z0tPYXo3NlFlNVR3YjBHb0VhOVNxNEg3R1ZOcVNGTnk5eEpMMmNiNTZlbzdl?=
 =?gb2312?B?OVhhWEViWnVXQ1BFZkFrK2ZEeUlSdnY2OU5aRU9EckFrekhFT1c0UjQya0pN?=
 =?gb2312?B?bWM0UkJBNlY2dDF0cFlsS21pSWZuS0dVc3FxdnRBZmdsYU5zeTFpVXZjZlkz?=
 =?gb2312?B?SFJLdnNNdHArNW9KZ1o5OEUrMWJGZlFlWi9pZWNWa2x4N3VlcU4wVis4T2ZB?=
 =?gb2312?B?RzNFejNwcFU4YUVON3Bqd3lFUzN4OUR6R043SHVzYjFEOFc5L2phbDNpU0RO?=
 =?gb2312?B?YTdkODUxSE1DTEVMMVZNMno5ekl3TVk3VGQ4TnNYeUhNaXBwUHdPb2c0OVVL?=
 =?gb2312?B?REFYM1VSOTlLbEJoczJrUURSaGhhY1ZPbjNwRVg5czdadXpocllES0d2Nm1z?=
 =?gb2312?B?dEFCdWwzZjU4SWtzRHNNQkFsSEhJSUtDM2g0YzJoOTFLY3FIbUlUUWJzSnBE?=
 =?gb2312?B?eDVMZWk0cERpamxsQUxVSERGVDExSUg3d3NNbGdKL2RXTDdGMlB4MVpZVjNL?=
 =?gb2312?B?QjhaNHJMVFB2b2Z5bEF1dTdHd0F5aGxBZDFWWDV2ZVlENU9uWTRGek52UEtz?=
 =?gb2312?B?bzdFTW1iVkxhL3NsUTNjMzNxZjNiMG1FNjU0TDlCSTl6VkI0cUE1UFMzdjkx?=
 =?gb2312?B?RXR1TFdUQm1QdnNZM0VFYmRWMHFUdkZ1ZlJ6ZldpRXE4UXE4MU8wRVo2aTQr?=
 =?gb2312?B?YjY4NWtlOXVKdUtPdjZTcE5mZ0xuVWxqL3BMZ2JDa1MyUE8yb2RWamVwdUU0?=
 =?gb2312?B?Qi9WWTFsL2I2Y2RlQ21ieENPNllWV0I1T0xicjlXVDUyR0hGbVBlSVFrTXQr?=
 =?gb2312?B?cjRXcGlEbjBZd3VxMnZFZWZBNEtGSUY3djloTjVTa0cwRVYvQzFlSlJWaFRh?=
 =?gb2312?B?L2Q1M0NDM0xodDlTeXJ5TnhPanB6NXlqS0tGcC94bU82SC81blVKeGEvakxJ?=
 =?gb2312?B?a1pnRG9qK0d4WWJTZll3U3h5SE9nUDh0QmJRSmdnNC8xTzE2a0xXaTFZTnlS?=
 =?gb2312?B?OEpiOG5RK09nRE5YUkpWb0lPellWVzI5T1doS0xQRG1vQ3QyN0RnTStoNXVW?=
 =?gb2312?B?MnFTa25VWDhXV0tpWGtYcXk2WGRhNWt1eDZkdXlBU0lLcEtydVZoajdqUmFS?=
 =?gb2312?B?RGRpNTVmL3BPVjhBSnIvOEJCazRBKzlPU3RhQVdkZnMzZTVlcEptbE9Ma1BG?=
 =?gb2312?B?aVhXT203aGRDNFZYbDZPd2pOWFhEdkJ6eGtkWFNCQ0hMK3hqYUpSb0ZreG5K?=
 =?gb2312?B?N0N6a0IvMDhIZ3NNVGU4YWJRQ29JU1pTb1liTWRlN0E2Snh6TG9NdjlsTFdJ?=
 =?gb2312?B?elMxaFFrbUs5ZlFlclZxaHQzZGl5VUF2WVowWnFXRWJRa1dOZ0k4NHBPaW8y?=
 =?gb2312?B?V25Ndlh0MnJudHRMcFRTQnJBdjROLzVELzFZQnZlWDRpR3UrMnBXZW9TUE0r?=
 =?gb2312?B?TiszVXhLdlVOdGVZUjFSaWVtZ1hFWWpYaVBYdkZKd25IOS9zUFVxWnpCSlBr?=
 =?gb2312?B?aHFMWWdiRTBlWUlheTUyMHFkdlpmY3UrVm9KSWxHWUlXbEw4bmFPQW1Id1NI?=
 =?gb2312?Q?D+RGuMcGH23LSf4WTsypoXryH?=
Content-Type: text/plain; charset="gb2312"
Content-ID: <BDC66330B824EC418534E05F06943EF0@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: +S8fKm+h2o7qfg6/v0h1zOvXgfihp6tDUVKAHkrk2JHVhSBvgqXhJp9f96IMI3YBNo6qC2JA6xxlP0PpSs9AQiZ5f/dKW3OVrNyl9XSY+bxyJ3t9kjEygsGjdDF8Gr4zL6cNeSd5xKHy+z6AkmPgjVxHoBzRzY5SfuXB5L8j16J2icAGsSeJ+6dVNazR1jK5m59xMJ8to+VRA2FAtkAm06RXG0PBSe5cwv7bpy6Bo2bDRg88aG55V1Z0a9s5aOjj6wygWOjLlMpBhfrE59YSm0c7ij6CuF10XvkmwWVROS7rc9zwqC1ULnWXpj/pHzXgs57cDsZBAJLCoCbjVldOE+99mAom7gdbYTbvB0OUMEBMnKSwd1o9P1Zay5szBsQjJIK8mLu3KY/WvqHdyNsxskbkIhMld6AOcEziNfbdAASnwNKRJM7gDL/0bZ26HH5nUamTfyONPsjBFbia+zBWBpKVMGTtoOZXPhIhfMA9oa4S419yFufxyBHxSAJ0WdbyyxXQ3pnEWIs/FgwJ8PpUZW00dcWI6hLayecZMDDK9b779AAj7syPMSI2gJaFtMsFfsuWGNXaGJIQQKUQpK0ASD+DQ7BQXmBYdGOqnlwQPdZ9E8bxRLLArRulY+1GEbJM
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY1PR01MB1562.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d242f2b1-c2c5-4863-32b0-08dd8d351114
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 May 2025 07:02:01.5268 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6yDSk8RDkYSNlae3mFH3fKgPFZu5Tt6qB1x48MnUsoIejvXs+4DfS/OXcmYQFmjAGSNsE+rNLDLzpZtyspdpXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB5632
Received-SPF: pass client-ip=68.232.159.88; envelope-from=lizhijian@fujitsu.com;
 helo=esa8.fujitsucc.c3s2.iphmx.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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
Reply-to:  "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
From:  "Zhijian Li (Fujitsu)" via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

CgpPbiAwMS8wNS8yMDI1IDA1OjUyLCBQZXRlciBYdSB3cm90ZToKPj4gKyNpbmNsdWRlIDxzeXMv
cmVzb3VyY2UuaD4KPj4gKyNkZWZpbmUgUkVRVUlSRURfTUVNTE9DSyAoMTI4ICogMTAyNCAqIDEw
MjQpIC8vIDEyOE1CCj4gSG93IGRvZXMgdGhlIDEyOE0gY29tZSBmcm9tPyAgSXMgaXQgY29ycmVs
YXRlZCB0byB0aGUgVk0gc2l6ZSBzb21laG93Pwo+IEJ0dywgbWlncmF0ZV9zdGFydCgpIHNheXMg
Zm9yIHg4NiB3ZSB1c2UgMTUwTUIgVk0uCgpHb29kIHF1ZXN0aW9uLCBBZnRlciBhIGJyaWVmIGRl
YnVnZ2luZyBzZXNzaW9uLCBpdCB3YXMgZGlzY292ZXJlZCB0aGF0IHRoZSBzaXplIG9mIG1sb2Nr
IHJlbWFpbnMKcmVsYXRpdmVseSBzdGFibGUgYXQgYXJvdW5kIDEwME0gaW4gdGhpcyB0ZXN0KGV2
ZW4gdGhvdWdoIGVubGFyZ2UgdGhlIGd1ZXN0IG1lbW9yeSB0byAxMDI0TSksCndoaWxlIHRoZSBy
ZW1haW5kZXIgaXMgdHJhbnNtaXR0ZWQgdG8gdGhlIGRlc3RpbmF0aW9uIHVzaW5nIHplcm8tcGFn
ZSBjb21wcmVzc2lvbi4KCgoKPiA+IFdoZW4geW91IGZlZWwgY29uZmlkZW50LCBmZWVsIGZyZWUg
dG8gc2VuZCBhIGZvcm1hbCBwYXRjaCwgaXQgY2FuIGFsc28KPiBpbmNsdWRlIHRoZSByZXBvc3Rl
ZCB2ZXJzaW9uIG9mIHRoZSBjdXJyZW50IHBhdGNoIHNvIHRoYXQgY2FuIGJlIGEgc2VyaWVzLgo+
IAo+IEl0J2xsIGFsc28gYmUgZ3JlYXQgaWYgeW91IGNvdWxkIG1ha2Ugc3VyZSB0aGV5IGFwcGx5
IG9uIHRvcCBvZjoKPiAKPiBodHRwczovL2dpdGxhYi5jb20vcGV0ZXJ4L3FlbXUvLS90cmVlL21p
Z3JhdGlvbi1zdGFnaW5nCgpObyBwcm9ibGVtLgoKVGhhbmtzClpoaWppYW4KCj4gCj4gVGhhbmtz
LAo=

