Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CF52C3271E
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2024 01:55:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPYA5-00062j-Lv; Thu, 04 Jul 2024 21:54:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yaoxt.fnst@fujitsu.com>)
 id 1sPYA4-00062Z-I8
 for qemu-devel@nongnu.org; Thu, 04 Jul 2024 21:54:56 -0400
Received: from esa16.fujitsucc.c3s2.iphmx.com ([216.71.158.33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yaoxt.fnst@fujitsu.com>)
 id 1sPYA2-0001TV-14
 for qemu-devel@nongnu.org; Thu, 04 Jul 2024 21:54:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1720144494; x=1751680494;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=9wgYE1nTZ0BDAQF7cqaReGwPuzNQ9D5rjYhZcEbr9lc=;
 b=dNcB1Oy2LRFeeL5CFSy/sMByBGUIxDjQ8c5waSZYoYARXn9O1bAa8V3K
 0ddNxLsYWNy61W3MrFpnVN3LT8xfA9idAyN8Xowk8nfsFesra3Y0J3dgC
 B+e8RZ7W/ssAn/VJkLR3cBerpLh0tzKuYLLOXmyhkT8288/R5OXCdjJPe
 XlHdHcWl72+Wl2Kk5Mc5kfd4718ss7N8WoBuQhH7ipiQJdsZtRnPpmmtJ
 Xc2zehobUNLdYhQE8nyrSX3k7Xz9tyj+6CBhH0WG9cJ8awX5mmaYh5/4z
 541zkMlXlfL+A2X6IrgiYsltwOznjM+Gdppxt5hzIAVLZnb4g2JPo2hbg g==;
X-IronPort-AV: E=McAfee;i="6700,10204,11123"; a="124256962"
X-IronPort-AV: E=Sophos;i="6.09,183,1716217200"; d="scan'208";a="124256962"
Received: from mail-japaneastazlp17010004.outbound.protection.outlook.com
 (HELO TY3P286CU002.outbound.protection.outlook.com) ([40.93.73.4])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Jul 2024 10:54:40 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eewi4l/x2TohBAd++ONoV5NnpPR/TlS85MiH2bAfSXLKLqh82UiPCHw/5raJBiadPVYgIbbUhAThzxROVCMc4TwpoJQ0mTg2ZkMcuKAwUcMgTO+aRqvU+why/g1WsGhxwBmeRxbiRNOMqIQ0PIk/g6sv2yB6CXk50J65ZQLm0TmbhQxcTb4q3CkRqHWg/tBRdD0nDlgP91J99w65ALn+4UyHkziVmqECLSuW+JxDo4ETHqsTDiciVDvrWM1w1rWoXuLwL6B9CJ/J89SwMUSlI1IBPxkrWp7wJD2TmbR8esbOVsD5Fvjm5h70Qf3gpblBLsNKDMGZ7Gs2zb7tMVjasA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9wgYE1nTZ0BDAQF7cqaReGwPuzNQ9D5rjYhZcEbr9lc=;
 b=PaTIJxELnJgBXR6OUfAL+L0yGuyI9D/BtQVBoCJjphMHiVdAvT29avOasY+3R27NqAZXmjqiqAZSipnMtOCAJEHgDGHOd2vatov4E8G1cUgxpqxpT9emLIiiNDOZu21AXGVfkgGx/qa0yTV0MBONeFClUJvqWQsMgVOOgzrLK3cudvM5LTA/6Oj2egD14JyYwTaOHJ6YqSNwsJCL9nqFvl5zy+fdxYx/nTR2WsiqurCVAvxeQ1O7cD/IAWJnkbexjDzPtdxzR2BzQVVwh63WXNr8lsIjQQxNI1MCzfdbK8uhw+hxaAEgw4cEff+aRAUICwNd8KbydJHsH5zENgjdfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TYCPR01MB6464.jpnprd01.prod.outlook.com (2603:1096:400:7e::7)
 by TYCPR01MB8062.jpnprd01.prod.outlook.com (2603:1096:400:11f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.31; Fri, 5 Jul
 2024 01:54:36 +0000
Received: from TYCPR01MB6464.jpnprd01.prod.outlook.com
 ([fe80::882:d445:280b:8484]) by TYCPR01MB6464.jpnprd01.prod.outlook.com
 ([fe80::882:d445:280b:8484%2]) with mapi id 15.20.7741.027; Fri, 5 Jul 2024
 01:54:36 +0000
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: Alexandre Iooss <erdnaxe@crans.org>, Richard Henderson
 <richard.henderson@linaro.org>, Marcel Apfelbaum
 <marcel.apfelbaum@gmail.com>, =?utf-8?B?QWxleCBCZW5uw6ll?=
 <alex.bennee@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Yanan Wang
 <wangyanan55@huawei.com>, Mahmoud Mandour <ma.mandourr@gmail.com>, Eduardo
 Habkost <eduardo@habkost.net>, =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?=
 <philmd@linaro.org>
Subject: RE: [PATCH v5 3/7] plugins: extend API to get latest memory value
 accessed
Thread-Topic: [PATCH v5 3/7] plugins: extend API to get latest memory value
 accessed
Thread-Index: AQHaznNiyQXKf1lu5kWS7fC6kusG+7HnX4/A
Date: Fri, 5 Jul 2024 01:54:36 +0000
Message-ID: <TYCPR01MB64642EBC36078062ACDA0ED78DDF2@TYCPR01MB6464.jpnprd01.prod.outlook.com>
References: <20240705003421.750895-1-pierrick.bouvier@linaro.org>
 <20240705003421.750895-4-pierrick.bouvier@linaro.org>
In-Reply-To: <20240705003421.750895-4-pierrick.bouvier@linaro.org>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: =?utf-8?B?TVNJUF9MYWJlbF8xZTkyZWY3My0wYWQxLTQwYzUtYWQ1NS00NmRlMzM5Njgw?=
 =?utf-8?B?MmZfQWN0aW9uSWQ9YWUyYjVmY2YtMDVhNy00YTg4LWE5YjYtYzJiZmI4YzQ5?=
 =?utf-8?B?NzY1O01TSVBfTGFiZWxfMWU5MmVmNzMtMGFkMS00MGM1LWFkNTUtNDZkZTMz?=
 =?utf-8?B?OTY4MDJmX0NvbnRlbnRCaXRzPTA7TVNJUF9MYWJlbF8xZTkyZWY3My0wYWQx?=
 =?utf-8?B?LTQwYzUtYWQ1NS00NmRlMzM5NjgwMmZfRW5hYmxlZD10cnVlO01TSVBfTGFi?=
 =?utf-8?B?ZWxfMWU5MmVmNzMtMGFkMS00MGM1LWFkNTUtNDZkZTMzOTY4MDJmX01ldGhv?=
 =?utf-8?B?ZD1Qcml2aWxlZ2VkO01TSVBfTGFiZWxfMWU5MmVmNzMtMGFkMS00MGM1LWFk?=
 =?utf-8?B?NTUtNDZkZTMzOTY4MDJmX05hbWU9RlVKSVRTVS1QVUJMSUPigIs7TVNJUF9M?=
 =?utf-8?B?YWJlbF8xZTkyZWY3My0wYWQxLTQwYzUtYWQ1NS00NmRlMzM5NjgwMmZfU2V0?=
 =?utf-8?B?RGF0ZT0yMDI0LTA3LTA1VDAxOjU0OjE3WjtNU0lQX0xhYmVsXzFlOTJlZjcz?=
 =?utf-8?B?LTBhZDEtNDBjNS1hZDU1LTQ2ZGUzMzk2ODAyZl9TaXRlSWQ9YTE5ZjEyMWQt?=
 =?utf-8?Q?81e1-4858-a9d8-736e267fd4c7;?=
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB6464:EE_|TYCPR01MB8062:EE_
x-ms-office365-filtering-correlation-id: 2f53cf19-b179-4bc1-8363-08dc9c956c6f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|1800799024|376014|366016|1580799027|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?MXNUa2JQWXJFd3ZNL0Y2THprNmFDdzAwR2d4aGxscXpwQnZRTkZiTGdrOERX?=
 =?utf-8?B?N1ZVbHpMUUI2RmdoN2pWdk9Kd05zc0VKUmZLcENJd0dyMFN5T2hJK28yaWl0?=
 =?utf-8?B?N0xrS0VpbUpqYjhEYUlhUG1YUHNkS2hUT0pjQ1ZpOFFjcmdmMnJHZENVV2R4?=
 =?utf-8?B?MnNGOFJjQnNwR1V5VTlIN1hEeUtNSkhNS3ptTlJvVFhNMEdRcUFzVHY4V1ha?=
 =?utf-8?B?alB1Q2VmakFWVHV6eENCRytONjgwNlV4dlZkdUFsVHNIT1ZLaUFrVVdaazdh?=
 =?utf-8?B?V0ZkdGNZVUdjYUo4WDl0dTNzcTFFZXJNMU9USGtXWnpReS8zWWt0WnBQbS9i?=
 =?utf-8?B?YkU0bTlCNisyb1Z4SmZpOHVyRTZPRUlJbXRVYmRUY1hWNEhvWGhJNCtVbmNh?=
 =?utf-8?B?aVF0TGlzQkR4MzUzcktmWTdMSTIvUWF3eW5PMkhZZFJaK2RKanplazJiWGln?=
 =?utf-8?B?cmJ3ZUNKY3FOc01FTEE3ZWJjTHZ6QWZoalFzZzJ6aSsyc0ZpTWU1VGU0UzR5?=
 =?utf-8?B?cElHdElid1ZweGcvZzVZNkNMUXVOYXM3aVpNd29QcitpcVRZcHVWbXViSWd4?=
 =?utf-8?B?SGt1NE9jRVF1VHZReGhKZGRDTDVxTEFQaStSblB2eVhsTFJWbVNlZnc3WERE?=
 =?utf-8?B?QS9ralBJRVhMVW12Mk1VTVp3aHZOSm03alladkVYOVVNTDR0cDVMT1k0L25N?=
 =?utf-8?B?STY4SXBtNW9BSmFUaWRzMFN0cGpJOE44NkNnMFdnUlFOdjhYUEJvZmlTblpH?=
 =?utf-8?B?ZkVGUWgvTjZVRE9WL0RXNm95T1JEVHVKQnVzKzdpSmZtQ21jTDlEd09nSHQw?=
 =?utf-8?B?d01SUTA0RVo1bGpQVHdmTFZwa0VuU25ZUzJEc1V6Z1YwQ1RBODY4aW1odmJ5?=
 =?utf-8?B?a3cxTy9OTUZTL3YzNHJYZUNFenZrbUJRTmVxdVd3QUZHMTE1Q3NINWVSdlJn?=
 =?utf-8?B?RGhDSjlIL2xQOWlOUHpNTXg4VEpVc3AwejIwVW5vU01aOEFVQS85OWNsb3Bj?=
 =?utf-8?B?aHN0T1k1YkxsRmV5blVYa0hoY0VZeFBTZGgxV3prMFBUQVF6bXlPeDd6dUdr?=
 =?utf-8?B?VDNvK0xyb1JLdUgzcHNLR3MyZGQ4TkJqMUc3QzI5WDkvWjJlWlViNU94czdU?=
 =?utf-8?B?Z2dneEJ4dTYzdUJqbUp6OW5WeTdYYm9UR0JXOEMxZkZZbENlbW94NVllMk9S?=
 =?utf-8?B?dlVHcnJNMklvb24zMGxjNlZpSHhxWlUySlZ3TkMzNWNPZFo0SU9MR05lNkdo?=
 =?utf-8?B?eDdjenprak1Id0lvT1ovTkdUYTJQaWZGR3RxbzFYQ0h2Zk5QdDhXY0dlczNX?=
 =?utf-8?B?YXFVK1FFUkdRblhxWVR6UWY5ZjNCczlFTlFlUmV2UzFoTTI5SDFYRzdDZW1H?=
 =?utf-8?B?YlBLcGg3SUtkc09yNFlGRzdaZC95M0VxVER5NUI5bVErOHVlNkEyV0wxUWJW?=
 =?utf-8?B?a0VnOFFzeHRwQnZjWm1uczZZa3lYa05ybmJjMlg4YVZGenljZlNBWE1PMWJp?=
 =?utf-8?B?aUNGOW80UzAyYUhWVGM4cTFRUXQrMGVaUUhHdEl2QUtFNmFFbVRKUUpYSmpk?=
 =?utf-8?B?NSt5UFY5b1BucjlCWDFURk1QdWVEVk9RUExjUHorQjlpSGRJSjR1RGRXS09t?=
 =?utf-8?B?OGp1R2JVYzhLZHpzd3hNdUlKbWI0YTNGTnJtcStJNk0yRk1ZOXFMNjVCOG80?=
 =?utf-8?B?RHowNGhoYzI4VkNscE1aK0NqZFM3dWhLTzVTeHE2c0RwWnVyUjEyWU5GTk1B?=
 =?utf-8?B?d2Y5Q1h2cHFjWHZIKzRGSEVucDVrMVAva2U3RWFWQ2dHSDZGY3o3b3UvUG1m?=
 =?utf-8?B?UHI0TjFNeGRoOUVoTjZVT0hIMjZUeXA4c2xmTVVRczBPUzIza3FvRlJwUnM3?=
 =?utf-8?B?ck4razlGZkNveHhIMjhEeHhmdHJNSGNKT3JJMjdsdTlyQkE9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-cn; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:TYCPR01MB6464.jpnprd01.prod.outlook.com; PTR:;
 CAT:NONE;
 SFS:(13230040)(7416014)(1800799024)(376014)(366016)(1580799027)(38070700018);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cW9Xelp4WThEemdRZ2VTT3gwWUVJSzJPZWVWODNOT0haTHo0VEdxSmxpVFla?=
 =?utf-8?B?cDBSV3ZPUnAyZHluQjd0ZEtyNlRiZzh3UlZaYWZuY3A3dU9sd2VRdDMrajNy?=
 =?utf-8?B?Ri8ybjFSTlptbkhIMEJpSmtQV2YyeGF0ejdFVEpnR3YrZlU0SWwxNXlyOXYv?=
 =?utf-8?B?SFROSGo4ZHZCc0lpc0s2Tnh6MVg1VGV2MzY3MmdZcDRjUmM3NGVqeFB1T0VI?=
 =?utf-8?B?SEdwdUZpazRYekVPZGRUTC9waE5FZmJ1Sk9ENGxlU0ljZFEvUEVvZ0dtSk5p?=
 =?utf-8?B?Y0h3VlJNYmI5cW96d1ZsVXlLU0ZTMGpra2VOTXdaRVlVRjR0R2lGZ2R2SHEz?=
 =?utf-8?B?cEVaRjdrdzVUa3hDcW1hZFJqajBMQzY2LzZRNmVVSXZzQTJMT1pZcXFPdW8r?=
 =?utf-8?B?TUtyWGhVMTA5VEp2TGFwSE5FcDArT2tPVzFPVGpzMDdpbmJBbHJiUW9BUTkv?=
 =?utf-8?B?endOZ2tMWW04ZjZvam8zT0haS2krMlN0cjY2R2pZTWNZTmRDTWpXdE1iVnBR?=
 =?utf-8?B?dGRFajY0NU1FNWVIeElOQ0txdjI2d1lxNlp2ckxRMlppUEdoODY1eXIwZ25L?=
 =?utf-8?B?YXFEQUNpZDFINmhCUDZFSDhuZk9BZWNrK1N6VWFYUEF3U3U1TlhPL0JTaFdy?=
 =?utf-8?B?TXo2dTBnWGJKLytjbFBCak1YMTJKZmpjTEhrOW0yOUIrUERzNGlnZ0c3M2Ry?=
 =?utf-8?B?d3pqZFFSTmtsVldaVHpuS09WMUhzeGw5bzBTMDRjRkxmaW1pMEk1OStDYStI?=
 =?utf-8?B?czI0WGNzTnlPUVhVVFVRaVhEbU41UXlqa0hJU3Vkc3ozN2x0aGczSUNoY214?=
 =?utf-8?B?aXNCSkdQSVcwamlBRFZ6a1JFUm1RaElxamltdUN6ZVZ2RTJzQkNnclJVVFg0?=
 =?utf-8?B?WDdxeUNmWFdWUzh3SUJRMVVRZnQvMHZ5UkJFUnhvUHd4bGVyS2Njc2N3bzJL?=
 =?utf-8?B?SFFEclBRTXdhRTFpQ2NsV0JNbjdZZFREOUZFQXYyaXh2b29WZytFeTFCVnNV?=
 =?utf-8?B?UEhoUHhzS1A0Y1pQcG00eWs2Q0lETXZsK293ZlhhdndyYlh6YVhmMThreDFx?=
 =?utf-8?B?RmZtQjNYRVRYb2FNdlAxT2tlaUUreml0RFlwUVpHaTVSTXBETmhUU0VveXNw?=
 =?utf-8?B?MDIyczJCUnB6d2pWWlRmM3pvUTA1UUpxRWNTejcxTHVJdjY4VlZ1anRoVmk3?=
 =?utf-8?B?OHRrbzhUTmM3ZHZVNENKbTFzT0JuMmxIYWxaWnEwSTlDa1RDb2FFVDF5VTE2?=
 =?utf-8?B?VEgrOGd0cUhkZ0VFM0xzdFF1YW9FMUV1K3RBZVNjUFBZalFMQnN4Tk5VbHEy?=
 =?utf-8?B?eEFJSjJ3N3hFdnpKTDJYKzViamtQcDYxdHhIcW9kTEpLQVZMaWpVbFk0Tkpx?=
 =?utf-8?B?dCs3YkF5MlNVai9hZVcydmF2ZnlTcGdETm9KanB6NUtUc0VteFRKQWdhcEJl?=
 =?utf-8?B?Z2xMd3lWOXZvcVlFV1N4VXZvaDIwUVpTMUN0OXgrZUluLytDYURFMURMN1o0?=
 =?utf-8?B?NGxNSGxPcno3ZVM2SW5WMDVPYjNKS2VSR0xVY3NqcGVNWXlhQlRXbFYvcWVO?=
 =?utf-8?B?TmIvZGhaaERtOStBNmxITm82bjlXS1FPNWMxbEhqTlVEOVhCbVA5eXBmOHB5?=
 =?utf-8?B?VmF2eTFWblRrc21SdTJNMXpteVlDZWVZQzdDNU9IMVpQR3FnNHFFem5iREVs?=
 =?utf-8?B?ZTZockppRG1wZko2b3g5c3g5dEdCcm1DaVdaQkZManowODRUZmNkd2VNRVcx?=
 =?utf-8?B?am94b3psV3RCY0sxYUl4SEZ0TmFSczNveXJwTXNSNkhZUzVjTkxQVURNRnor?=
 =?utf-8?B?TUZBZDAzQXBkR1lZV2dINjVNbmEzQWlndlNES0JNMjVKcm5OTlZzV0RQTEtI?=
 =?utf-8?B?aWd1ck5CeDNIalZUMC9rSjVpMzRnRjRITmNsNmNSSWl6TmFiSlZKTjJKdHpO?=
 =?utf-8?B?eEd1bGVSZzdUNFQ5ZnJQNy9MMEN5aU9pOGhBQllJRU5HbGlMQWhKd1hhUE5l?=
 =?utf-8?B?cTljNTd3M3R6QjEySHQ2YWdIN2cwWUNMbi9mM2NpbXhibVNJeE5SV2lxQVU0?=
 =?utf-8?B?ZzFvNVVwdllwYXF0OTd5bmwyaENleldZWjVnQm9Ldm15VjJ5VU9odjlVSTJO?=
 =?utf-8?Q?WDhCCxxAJ0ABbLcTJQqoDcnuR?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: q55D9kzo3/5k2Z8wwh1A1UMBdaahw8DdGSZGorF24TK9hJ0z6x9rDUSuGI2kEMu2rVdKAL7vRhMg/an5sJgj28YDNZ8m9RAn0OEQEICE+pFhKOCPn06qesQT4kLIylYD8qyAv3R9wvPrVdvUIymQCKWbgRYuYfpyniNVTDWdF0OetkPDilnaRzj4Cw+Rqrgw3s0EGkBqfPMwgHLofqStBR/wafrmDE5+eKDX3jIdoIWwcBwsU7c3l09BVbk5m52YbbTpeYiRD8DH97jt7xknlhN1k4JDqOVPMMMWRXw/WuSneyyeiBWjQ65hdKAUJdbciVT3CCIAGElSS/j2WJV/9IqUsWmPpIi03fjprhLPLUhQEIPC+bhjMCkXPhvK21yVwwMQLVyV11Rs7uPy56sxS35gRvVavMcNqnLk9aXJIcn7OLymFXcN+apw91AMFKhpHzugForYJwH2Hl1qW1bPvO/nSZGxDwEEUcAKk795Ro/Q/aZoqXWso/b6uiZ141kcHe6Tini3qiC0E7NvnBjycvl3YdukTp5GsdR7xRY5eBsZKMjIIUC251OvwqX+vUCZ3ye09+j3bvAXZ0IoVZ/XS0lwG7YUakbArv9LJ2qk/1q4KiLmBpIJ9YXjQoOni9Jt
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB6464.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f53cf19-b179-4bc1-8363-08dc9c956c6f
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jul 2024 01:54:36.2710 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xdOojWWy0UgbNIP3eGCGTsyyKN7h6Y1IG4Gl8B0m09nA4atJ8SUfUbE+RwjRSuRUtndwbZipGXrcr+KMffxmdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB8062
Received-SPF: pass client-ip=216.71.158.33;
 envelope-from=yaoxt.fnst@fujitsu.com; helo=esa16.fujitsucc.c3s2.iphmx.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-to:  "Xingtao Yao (Fujitsu)" <yaoxt.fnst@fujitsu.com>
From:  "Xingtao Yao (Fujitsu)" via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

UmV2aWV3ZWQtYnk6IFhpbmd0YW8gWWFvIDx5YW94dC5mbnN0QGZ1aml0c3UuY29tPg0KDQo+IC0t
LS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IHFlbXUtZGV2ZWwtYm91bmNlcyt5YW94
dC5mbnN0PWZ1aml0c3UuY29tQG5vbmdudS5vcmcNCj4gPHFlbXUtZGV2ZWwtYm91bmNlcyt5YW94
dC5mbnN0PWZ1aml0c3UuY29tQG5vbmdudS5vcmc+IE9uIEJlaGFsZiBPZg0KPiBQaWVycmljayBC
b3V2aWVyDQo+IFNlbnQ6IEZyaWRheSwgSnVseSA1LCAyMDI0IDg6MzQgQU0NCj4gVG86IHFlbXUt
ZGV2ZWxAbm9uZ251Lm9yZw0KPiBDYzogQWxleGFuZHJlIElvb3NzIDxlcmRuYXhlQGNyYW5zLm9y
Zz47IFJpY2hhcmQgSGVuZGVyc29uDQo+IDxyaWNoYXJkLmhlbmRlcnNvbkBsaW5hcm8ub3JnPjsg
TWFyY2VsIEFwZmVsYmF1bQ0KPiA8bWFyY2VsLmFwZmVsYmF1bUBnbWFpbC5jb20+OyBQaWVycmlj
ayBCb3V2aWVyIDxwaWVycmljay5ib3V2aWVyQGxpbmFyby5vcmc+Ow0KPiBBbGV4IEJlbm7DqWUg
PGFsZXguYmVubmVlQGxpbmFyby5vcmc+OyBQYW9sbyBCb256aW5pIDxwYm9uemluaUByZWRoYXQu
Y29tPjsNCj4gWWFuYW4gV2FuZyA8d2FuZ3lhbmFuNTVAaHVhd2VpLmNvbT47IE1haG1vdWQgTWFu
ZG91cg0KPiA8bWEubWFuZG91cnJAZ21haWwuY29tPjsgRWR1YXJkbyBIYWJrb3N0IDxlZHVhcmRv
QGhhYmtvc3QubmV0PjsgUGhpbGlwcGUNCj4gTWF0aGlldS1EYXVkw6kgPHBoaWxtZEBsaW5hcm8u
b3JnPg0KPiBTdWJqZWN0OiBbUEFUQ0ggdjUgMy83XSBwbHVnaW5zOiBleHRlbmQgQVBJIHRvIGdl
dCBsYXRlc3QgbWVtb3J5IHZhbHVlIGFjY2Vzc2VkDQo+IA0KPiBUaGlzIHZhbHVlIGNhbiBiZSBh
Y2Nlc3NlZCBvbmx5IGR1cmluZyBhIG1lbW9yeSBjYWxsYmFjaywgdXNpbmcNCj4gbmV3IHFlbXVf
cGx1Z2luX21lbV9nZXRfdmFsdWUgZnVuY3Rpb24uDQo+IA0KPiBSZXR1cm5lZCB2YWx1ZSBjYW4g
YmUgZXh0ZW5kZWQgd2hlbiBRRU1VIHdpbGwgc3VwcG9ydCBhY2Nlc3NlcyB3aWRlcg0KPiB0aGFu
IDEyOCBiaXRzLg0KPiANCj4gUmVzb2x2ZXM6IGh0dHBzOi8vZ2l0bGFiLmNvbS9xZW11LXByb2pl
Y3QvcWVtdS8tL2lzc3Vlcy8xNzE5DQo+IFJlc29sdmVzOiBodHRwczovL2dpdGxhYi5jb20vcWVt
dS1wcm9qZWN0L3FlbXUvLS9pc3N1ZXMvMjE1Mg0KPiBSZXZpZXdlZC1ieTogUmljaGFyZCBIZW5k
ZXJzb24gPHJpY2hhcmQuaGVuZGVyc29uQGxpbmFyby5vcmc+DQo+IFNpZ25lZC1vZmYtYnk6IFBp
ZXJyaWNrIEJvdXZpZXIgPHBpZXJyaWNrLmJvdXZpZXJAbGluYXJvLm9yZz4NCj4gLS0tDQo+ICBp
bmNsdWRlL3FlbXUvcWVtdS1wbHVnaW4uaCAgIHwgMzINCj4gKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysNCj4gIHBsdWdpbnMvYXBpLmMgICAgICAgICAgICAgICAgfCAzMw0KPiArKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysNCj4gIHBsdWdpbnMvcWVtdS1wbHVnaW5zLnN5
bWJvbHMgfCAgMSArDQo+ICAzIGZpbGVzIGNoYW5nZWQsIDY2IGluc2VydGlvbnMoKykNCj4gDQo+
IGRpZmYgLS1naXQgYS9pbmNsdWRlL3FlbXUvcWVtdS1wbHVnaW4uaCBiL2luY2x1ZGUvcWVtdS9x
ZW11LXBsdWdpbi5oDQo+IGluZGV4IGM3MWM3MDViNjk5Li42NDljZTg5ODE1ZiAxMDA2NDQNCj4g
LS0tIGEvaW5jbHVkZS9xZW11L3FlbXUtcGx1Z2luLmgNCj4gKysrIGIvaW5jbHVkZS9xZW11L3Fl
bXUtcGx1Z2luLmgNCj4gQEAgLTI2Miw2ICsyNjIsMjkgQEAgZW51bSBxZW11X3BsdWdpbl9tZW1f
cncgew0KPiAgICAgIFFFTVVfUExVR0lOX01FTV9SVywNCj4gIH07DQo+IA0KPiArZW51bSBxZW11
X3BsdWdpbl9tZW1fdmFsdWVfdHlwZSB7DQo+ICsgICAgUUVNVV9QTFVHSU5fTUVNX1ZBTFVFX1U4
LA0KPiArICAgIFFFTVVfUExVR0lOX01FTV9WQUxVRV9VMTYsDQo+ICsgICAgUUVNVV9QTFVHSU5f
TUVNX1ZBTFVFX1UzMiwNCj4gKyAgICBRRU1VX1BMVUdJTl9NRU1fVkFMVUVfVTY0LA0KPiArICAg
IFFFTVVfUExVR0lOX01FTV9WQUxVRV9VMTI4LA0KPiArfTsNCj4gKw0KPiArLyogdHlwZWRlZiBx
ZW11X3BsdWdpbl9tZW1fdmFsdWUgLSB2YWx1ZSBhY2Nlc3NlZCBkdXJpbmcgYSBsb2FkL3N0b3Jl
ICovDQo+ICt0eXBlZGVmIHN0cnVjdCB7DQo+ICsgICAgZW51bSBxZW11X3BsdWdpbl9tZW1fdmFs
dWVfdHlwZSB0eXBlOw0KPiArICAgIHVuaW9uIHsNCj4gKyAgICAgICAgdWludDhfdCB1ODsNCj4g
KyAgICAgICAgdWludDE2X3QgdTE2Ow0KPiArICAgICAgICB1aW50MzJfdCB1MzI7DQo+ICsgICAg
ICAgIHVpbnQ2NF90IHU2NDsNCj4gKyAgICAgICAgc3RydWN0IHsNCj4gKyAgICAgICAgICAgIHVp
bnQ2NF90IGxvdzsNCj4gKyAgICAgICAgICAgIHVpbnQ2NF90IGhpZ2g7DQo+ICsgICAgICAgIH0g
dTEyODsNCj4gKyAgICB9IGRhdGE7DQo+ICt9IHFlbXVfcGx1Z2luX21lbV92YWx1ZTsNCj4gKw0K
PiAgLyoqDQo+ICAgKiBlbnVtIHFlbXVfcGx1Z2luX2NvbmQgLSBjb25kaXRpb24gdG8gZW5hYmxl
IGNhbGxiYWNrDQo+ICAgKg0KPiBAQCAtNTUxLDYgKzU3NCwxNSBAQCBib29sDQo+IHFlbXVfcGx1
Z2luX21lbV9pc19iaWdfZW5kaWFuKHFlbXVfcGx1Z2luX21lbWluZm9fdCBpbmZvKTsNCj4gIFFF
TVVfUExVR0lOX0FQSQ0KPiAgYm9vbCBxZW11X3BsdWdpbl9tZW1faXNfc3RvcmUocWVtdV9wbHVn
aW5fbWVtaW5mb190IGluZm8pOw0KPiANCj4gKy8qKg0KPiArICogcWVtdV9wbHVnaW5fbWVtX2dl
dF9tZW1fdmFsdWUoKSAtIHJldHVybiBsYXN0IHZhbHVlIGxvYWRlZC9zdG9yZWQNCj4gKyAqIEBp
bmZvOiBvcGFxdWUgbWVtb3J5IHRyYW5zYWN0aW9uIGhhbmRsZQ0KPiArICoNCj4gKyAqIFJldHVy
bnM6IG1lbW9yeSB2YWx1ZQ0KPiArICovDQo+ICtRRU1VX1BMVUdJTl9BUEkNCj4gK3FlbXVfcGx1
Z2luX21lbV92YWx1ZQ0KPiBxZW11X3BsdWdpbl9tZW1fZ2V0X3ZhbHVlKHFlbXVfcGx1Z2luX21l
bWluZm9fdCBpbmZvKTsNCj4gKw0KPiAgLyoqDQo+ICAgKiBxZW11X3BsdWdpbl9nZXRfaHdhZGRy
KCkgLSByZXR1cm4gaGFuZGxlIGZvciBtZW1vcnkgb3BlcmF0aW9uDQo+ICAgKiBAaW5mbzogb3Bh
cXVlIG1lbW9yeSBpbmZvIHN0cnVjdHVyZQ0KPiBkaWZmIC0tZ2l0IGEvcGx1Z2lucy9hcGkuYyBi
L3BsdWdpbnMvYXBpLmMNCj4gaW5kZXggMmZmMTNkMDlkZTYuLjMzMTZkNGEwNGQ0IDEwMDY0NA0K
PiAtLS0gYS9wbHVnaW5zL2FwaS5jDQo+ICsrKyBiL3BsdWdpbnMvYXBpLmMNCj4gQEAgLTM1MSw2
ICszNTEsMzkgQEAgYm9vbA0KPiBxZW11X3BsdWdpbl9tZW1faXNfc3RvcmUocWVtdV9wbHVnaW5f
bWVtaW5mb190IGluZm8pDQo+ICAgICAgcmV0dXJuIGdldF9wbHVnaW5fbWVtaW5mb19ydyhpbmZv
KSAmIFFFTVVfUExVR0lOX01FTV9XOw0KPiAgfQ0KPiANCj4gK3FlbXVfcGx1Z2luX21lbV92YWx1
ZQ0KPiBxZW11X3BsdWdpbl9tZW1fZ2V0X3ZhbHVlKHFlbXVfcGx1Z2luX21lbWluZm9fdCBpbmZv
KQ0KPiArew0KPiArICAgIHVpbnQ2NF90IGxvdyA9IGN1cnJlbnRfY3B1LT5uZWcucGx1Z2luX21l
bV92YWx1ZV9sb3c7DQo+ICsgICAgcWVtdV9wbHVnaW5fbWVtX3ZhbHVlIHZhbHVlOw0KPiArDQo+
ICsgICAgc3dpdGNoIChxZW11X3BsdWdpbl9tZW1fc2l6ZV9zaGlmdChpbmZvKSkgew0KPiArICAg
IGNhc2UgMDoNCj4gKyAgICAgICAgdmFsdWUudHlwZSA9IFFFTVVfUExVR0lOX01FTV9WQUxVRV9V
ODsNCj4gKyAgICAgICAgdmFsdWUuZGF0YS51OCA9ICh1aW50OF90KWxvdzsNCj4gKyAgICAgICAg
YnJlYWs7DQo+ICsgICAgY2FzZSAxOg0KPiArICAgICAgICB2YWx1ZS50eXBlID0gUUVNVV9QTFVH
SU5fTUVNX1ZBTFVFX1UxNjsNCj4gKyAgICAgICAgdmFsdWUuZGF0YS51MTYgPSAodWludDE2X3Qp
bG93Ow0KPiArICAgICAgICBicmVhazsNCj4gKyAgICBjYXNlIDI6DQo+ICsgICAgICAgIHZhbHVl
LnR5cGUgPSBRRU1VX1BMVUdJTl9NRU1fVkFMVUVfVTMyOw0KPiArICAgICAgICB2YWx1ZS5kYXRh
LnUzMiA9ICh1aW50MzJfdClsb3c7DQo+ICsgICAgICAgIGJyZWFrOw0KPiArICAgIGNhc2UgMzoN
Cj4gKyAgICAgICAgdmFsdWUudHlwZSA9IFFFTVVfUExVR0lOX01FTV9WQUxVRV9VNjQ7DQo+ICsg
ICAgICAgIHZhbHVlLmRhdGEudTY0ID0gbG93Ow0KPiArICAgICAgICBicmVhazsNCj4gKyAgICBj
YXNlIDQ6DQo+ICsgICAgICAgIHZhbHVlLnR5cGUgPSBRRU1VX1BMVUdJTl9NRU1fVkFMVUVfVTEy
ODsNCj4gKyAgICAgICAgdmFsdWUuZGF0YS51MTI4LmxvdyA9IGxvdzsNCj4gKyAgICAgICAgdmFs
dWUuZGF0YS51MTI4LmhpZ2ggPSBjdXJyZW50X2NwdS0+bmVnLnBsdWdpbl9tZW1fdmFsdWVfaGln
aDsNCj4gKyAgICAgICAgYnJlYWs7DQo+ICsgICAgZGVmYXVsdDoNCj4gKyAgICAgICAgZ19hc3Nl
cnRfbm90X3JlYWNoZWQoKTsNCj4gKyAgICB9DQo+ICsgICAgcmV0dXJuIHZhbHVlOw0KPiArfQ0K
PiArDQo+ICAvKg0KPiAgICogVmlydHVhbCBNZW1vcnkgcXVlcmllcw0KPiAgICovDQo+IGRpZmYg
LS1naXQgYS9wbHVnaW5zL3FlbXUtcGx1Z2lucy5zeW1ib2xzIGIvcGx1Z2lucy9xZW11LXBsdWdp
bnMuc3ltYm9scw0KPiBpbmRleCBjYTc3M2Q4ZDlmZS4uZWVkOWQ4YWJkOTAgMTAwNjQ0DQo+IC0t
LSBhL3BsdWdpbnMvcWVtdS1wbHVnaW5zLnN5bWJvbHMNCj4gKysrIGIvcGx1Z2lucy9xZW11LXBs
dWdpbnMuc3ltYm9scw0KPiBAQCAtMTMsNiArMTMsNyBAQA0KPiAgICBxZW11X3BsdWdpbl9pbnNu
X3NpemU7DQo+ICAgIHFlbXVfcGx1Z2luX2luc25fc3ltYm9sOw0KPiAgICBxZW11X3BsdWdpbl9p
bnNuX3ZhZGRyOw0KPiArICBxZW11X3BsdWdpbl9tZW1fZ2V0X3ZhbHVlOw0KPiAgICBxZW11X3Bs
dWdpbl9tZW1faXNfYmlnX2VuZGlhbjsNCj4gICAgcWVtdV9wbHVnaW5fbWVtX2lzX3NpZ25fZXh0
ZW5kZWQ7DQo+ICAgIHFlbXVfcGx1Z2luX21lbV9pc19zdG9yZTsNCj4gLS0NCj4gMi4zOS4yDQo+
IA0KDQo=

