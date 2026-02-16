Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C312EF5860
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Feb 2026 09:41:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vrv6R-0003Vq-1E; Mon, 16 Feb 2026 04:41:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1vrv6P-0003VY-MK
 for qemu-devel@nongnu.org; Mon, 16 Feb 2026 04:41:13 -0500
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1vrv6L-00033s-20
 for qemu-devel@nongnu.org; Mon, 16 Feb 2026 04:41:13 -0500
Received: from pps.filterd (m0127837.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 61FIrX883602531; Mon, 16 Feb 2026 01:40:57 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=hXAuA615qKYxJaUZaYslV+89ympEtTfdzazKDKF4b
 iY=; b=HjFD968GQOP5Zm8OZy2lwd4jWgqO/PWlyrq+R3siU/wV1OdBgT+Z1/oTc
 qUDeklM2Wd2C7lqvtrjCw14E4wCI00vMzI0zr/t8nTfi3EymiTg/2nAucU37W457
 z/C4z6m//MSmdngrPURCyaNw+C/pq2dC6LctKcZjNneU5ZCxYOpr+JMDXTgnHq5s
 wrPgd8MEBXZtFpW1mCuHuDBcvRSq87+5Dn04SJ1ZOlDx0/7IH7CGtwoZIIuag5ID
 /rfbLhCFHjANmhwAUf7OC3hruGJl1pZ1kyoC71PIZDdNBZQRN2aEVldM9o6icVqm
 DUHkMobGQIpP7oBaKelZ+MKOuITaw==
Received: from ch4pr04cu002.outbound.protection.outlook.com
 (mail-northcentralusazon11023133.outbound.protection.outlook.com
 [40.107.201.133])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4canu7u69b-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 16 Feb 2026 01:40:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kS5cygFslTwcooG9KhXb9lbca53jp32uXnP0iOIug6cMuWFpDcjZn8d9Bd1hDjYcZ0J2dgYcwDui7mjBGiDpjX0fvTw6T61CkcF7za5ch0GD7+ifSYpx9eZX77y+YZgWTIDjNVCmtwFdO7Ikw4JBWHj2Yr4VcmdwhfM7Lvo1G0YjDlaQhO0DBgep8GNaz22gjefLj6ATrVKnKb0DTHzvWKiy11NnKUZbVszQgabn0WWrEwMpqnXgESsW3A78PJGqQdItOyOhrVQvSrpizmrys8kiBDCgUsT5OgNntr06IuYwYwdrxQ+jrrdYBQCa0KU4JVkftBGQXsD1V6yF2nCQKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hXAuA615qKYxJaUZaYslV+89ympEtTfdzazKDKF4biY=;
 b=AH+nZVIDd0WM9Xy2x16Wfsn9qNNYt2YP9qQ/GSseqp1rZx1EnVJ19Q4OEe0JPqcbnEKYF66nwpzIczgdqwKvIhi9j46x09iPtAG/LWi1LlySbTcJ3Z8aqH7XI9Dj+0+8NLysn805aBXm2dioW7uU0DSEi/y+nAWKnfHf6piIYqSs6PFrHdP9QMW+VCqEc/fBQwviyS5txU8HhEAIMoA7Hsr+Gb/uMNEw7YLiARn35PxNrbFLo5DfCGNwrDSBrWY6bQ0T/j8xsAHnrj3UUC6CClPSseox5Yf+0tACJV656uWDiQMBGU+S+LZbkEKZ590T//wPNiCXf68VvI20wpT1lQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hXAuA615qKYxJaUZaYslV+89ympEtTfdzazKDKF4biY=;
 b=BYTWoxPQuleForFkdbIyGt2DzBKoofZyS1qFE4zVtSlskAg7AypTXNAbJWY9X9W7egPSqIQHljuPpqUrbOE5iWZUVghtM70So+P+S/gNCpMkeO2BSMKd+9PAAkrV27GW7YS3DS3osubw6jQQBEXgtNEsm62qYBwMEWg6Ug7T9Lj/7FGuWB3xL9Hft+w66o0wvKWqXqNKuavxywkJkwqjftQ10xMvo9NegOB/prWbv9E2rpQBuPQtduoFaiB2dDAAqcE5BToOvKTgi7W07zHqS3UhBC28BV/5bI90LZ0/ieE2Ax5pXluEb7+xjSXAVtESTNEe3dAftlBvQSsE/9mirw==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by CO6PR02MB7732.namprd02.prod.outlook.com (2603:10b6:303:b1::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.16; Mon, 16 Feb
 2026 09:40:53 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%7]) with mapi id 15.20.9611.012; Mon, 16 Feb 2026
 09:40:53 +0000
Message-ID: <f7769ff3-0d69-4d18-949d-6f364be9eb92@nutanix.com>
Date: Mon, 16 Feb 2026 09:40:49 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 16/43] audio: move pcm_ops into AudioMixengBackendClass
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Gerd Hoffmann <kraxel@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Thomas Huth <huth@tuxfamily.org>, Alexandre Ratchov <alex@caoua.org>
References: <20260127182516.289834-1-marcandre.lureau@redhat.com>
 <20260127182516.289834-17-marcandre.lureau@redhat.com>
 <2429b419-80dc-46ff-a12c-05974b812bed@nutanix.com>
 <CAMxuvaytcFa8=bPLRXfs+C-KSVoSySHgP69ig5i_eDcpBECnGg@mail.gmail.com>
Content-Language: en-US
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
In-Reply-To: <CAMxuvaytcFa8=bPLRXfs+C-KSVoSySHgP69ig5i_eDcpBECnGg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO6P123CA0026.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:313::17) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|CO6PR02MB7732:EE_
X-MS-Office365-Filtering-Correlation-Id: d967049f-9ba0-442c-b96d-08de6d3f7a56
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WVNvZ3J6SDBUOWRNeHAxMmJTSEVRWUZqajhjVVlDamZ3OEZjZSthMXNBdXJL?=
 =?utf-8?B?UEhxcGNVUm5ZS2RnZmVxS0J6WFJ5SGwwd0ZmRUV3dW1HMnlvTlRDZ1RWZ0U2?=
 =?utf-8?B?aEE5b0VXbnlteTRtcFFXNmJ2MW1uNXI0M0dod013S2p0aWRidnhKTU1YaTMx?=
 =?utf-8?B?czQ5czduN0tNUXoyT29sdUhxbjBwQVZOOXVIaTk0bzkwVVBqbmY5V2ljZnZh?=
 =?utf-8?B?eFgxVEF5TC82Q215M0JFdHlwOXRLY2NMT1U1RThFUHNOTmZpUVF1elZWSnlL?=
 =?utf-8?B?endlakpxcm04VnozQ2VuVVU0cmxJS0hJenNIMkxiVnNpWnp6b212SWxMYTAy?=
 =?utf-8?B?aXhLdk1HL2hadWhUUHFvU01kZkhJdG1GY2Z5Yzl4dENXWnVPN1gyODlOT085?=
 =?utf-8?B?bWxCWlpESDZQeXVNQWNmd2RyVG5ZK0xxS1IyU3ROd1c2N2RDditjMFFLN0tG?=
 =?utf-8?B?UUY0L2N4MVVGaE8xVUpMbThJUHAxL0RFbGk4RCtaTnoyS25taUxyUHBEQXFs?=
 =?utf-8?B?VXg5Zm43QVNOQXFla1BFT1ZTdjlSWngxSnJGN1FXTmxiU3NwVEJFSnFEZkQr?=
 =?utf-8?B?S041cmFRb2V0U1RtN1F2MDYxL0JNeXdnVEVjWlFmOXNCaStNalJTYzYxa3pE?=
 =?utf-8?B?ZVh5ZDVKdTkvS3NJWXVwV2JnRjJyV3ZOc1FGUlUvM09ialRLNnFKZkEzakYy?=
 =?utf-8?B?N3phZFlGZnp5a0dWcnYwQi8rQXpocFB1ZmVKOURwMHRYOVl0R0xvOHdtN2t0?=
 =?utf-8?B?aFliOHNRMDhGRStDMGl3MzRicEIwSXNkbmN3Qldsa3dSUk12M3ppSWtTdjlY?=
 =?utf-8?B?YkJ5NU5xQXZzUXZEVm4yOUo0RWI3UFB1cEQvRFdzMS8rWEJNYXhHYUpSZ1Ns?=
 =?utf-8?B?Zk1YSlBJcm9Pb3ExNE43Rnh6UlpyYUt1M2hRcHA4cVlXbG11aEVwaEsxVmsv?=
 =?utf-8?B?SkxrR0cxREVEeHl1U0svOGlaNUd2OEw3Z2xtZGh6UDlHSnR6SzVmMGxhK2Nk?=
 =?utf-8?B?ZDBPdG5aUDZFVGlCQVNTazRsQUk0cHRTbzRVVnRZTWc2Tk8rcWFGbE1nenRL?=
 =?utf-8?B?SGpDWkpySEZ6d0pMUGRIRTlwT013a2RXWDduOVVBR2VwNklycDZXcHk1amZS?=
 =?utf-8?B?eFhReFNycVJwK0t1VUtGL0MvbkNFMVBwbDllZW5BdGtjRXhzL0JvdHhqZWMy?=
 =?utf-8?B?NlJlcUlmWTBhTEtabkhFVkthVFdNeGtNZDByNHhQNHR0Z2UvN2lQdWZaOFB5?=
 =?utf-8?B?VXpkcHV5akR5bndsZTFIQk5raUtwbEVZYU9Zd1piRW1Oc2ppaUdBaDBVQ0hM?=
 =?utf-8?B?cW5JOGdHWUhxeWVRVmI0UVdidGgxSXBHU2Q1WTQ3L0pSaHFrMHYvMTZaSlZt?=
 =?utf-8?B?eUY1Y1F3Sm81d0VRQ0VGdy9ZV0g4UUJrQm5JK0xORGVWbDQxemZIS2FtbWgv?=
 =?utf-8?B?UzR0aThuNVgvTkhPa3lwazlhODhtMXdzZ1E2bnNpbmpmQmZ2emJsckNMNk5K?=
 =?utf-8?B?S3RtUy8xM2RqZFFMTlQ0clp1Rm5wR3hCdUxJTkJtZyszWkRoWXhkMmZKNnhM?=
 =?utf-8?B?ZjJvdHJSK0xHVWo1bHBzd1pUaVVvM0NQUzUvYjJlZFR5b3pZMVZtQjFhdUN4?=
 =?utf-8?B?YU9JWEF5cFU0eXFWdkxKVTJGcnN6M3l3cUpEbjFhaDErTDNrcGg1ZHBvaVZO?=
 =?utf-8?B?a1MwenRFdEY4cHNrblFuVHQ5UlJwa0ZKZlhLdVo3YXJDMEYyMjBEZ1MzTzNq?=
 =?utf-8?B?d1orODhMR0syaVdkWEJSVWRLYkRaaCt4K0MwVnVRTGhQTmFrNVdsN1dlYUJR?=
 =?utf-8?B?dlRtWmdFeWZFWmw3Wk02RzlVUnlsTnMwMGxJTGpwbnJaU01wZGJka2xEV3lX?=
 =?utf-8?B?L0FqdEk1Wm1WN3hsWUh6UHhlUHR3eWphM2QrQzBuL2ZQd29xVk52NFVxZXNm?=
 =?utf-8?B?MVNFZDdwd3lCelJ4M3pySkYzVXV6QjF4SEpvTHBYT2s0dEhPZ05oY0IwMVNz?=
 =?utf-8?B?L3oyU21GVkJnUU9MQi9ZQlZZdmJLeUtPejB2ZVo0YlBJb3djM2FYUDJTZis1?=
 =?utf-8?B?Uk9tVlBIZGk2Mmp0UlFSaXFYdVNXUWkxQ2JZaCtxQThMR2ZUTDZBbHAxWDdq?=
 =?utf-8?Q?WVl4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ek90TzJEQ0ovNENwUjV1Y3hNVTBIaVRNMjVWbWdsYk9pZXArK3h0RW9sYmZu?=
 =?utf-8?B?MzJSOTZLazZVV0o0dXVJaHc0LzNBYTJzUXllUGFmR3cvTC9CN01CYkowamd4?=
 =?utf-8?B?QUQzQmlFdnc3MUJrb0hSQlZLeHQ4NkQvRGoxMEltb1FuSWtsN1ZkeGd3N3B6?=
 =?utf-8?B?ZXNtN0ZLRVpMR0orZTJYeVR1WWttclR3d3M4dG5GTitMbm1TRlYxUjY1d1Fj?=
 =?utf-8?B?WFE5UGhFWGxWUmNoNGtGTTM4a2xzbmlUK1RSTzRNTnM4dU1XQUxvdGJLWTZi?=
 =?utf-8?B?N1BVcENMSSs2RUd0aXRkTGhrS0hJT0pSeDhkaUc2MDZaQlU0YnB5aFRDUW1z?=
 =?utf-8?B?Sk11dzJubWFaUVVqdjBDZjc3WUNLZFdZLzlTbEJvMmZSaWhObGNVTzZyVllp?=
 =?utf-8?B?SmxOSmowRkpOVkJUTE41K1RWVk9wQzhCTTBHVWMybk1taHB0d2NMdHQ5cFRm?=
 =?utf-8?B?RTVWU2pSRDl4c0l5WG9Ra1dNNnVKNTZTQTBWdjBCV01sdEo4SzJOMlJzcVVD?=
 =?utf-8?B?NndqeHdQUTBCV0c0bS9EVkVjSEhkZUI5T3NhR21aY1MvU1F5cXJjYkFmSWpF?=
 =?utf-8?B?SWpVWkk0UTU5UVZaaDJEWDRFMDc0T3FoNkRHQTZjTndoMlJua2M4TWR0MjBO?=
 =?utf-8?B?eUhMRG13WVRDK1JnRXFtTnZkdUM4aG9xL3RaT1lEZXpHZlVXb21JdCtjSGJs?=
 =?utf-8?B?TFk4emtZNHpwL1lKeG9zc2RlWVpEQXZhcm5UZ1lQcHIvSEFvM0N3R1QzMC93?=
 =?utf-8?B?ZWdKU2I5cGxuQWZjcHplVk5LbVpFMUtITHBwYlhyY1JOUjNNKzVsWEY3eE5Y?=
 =?utf-8?B?M2R6NTZBYUk1NTZYZHE5ZVArb2JyTVdzWUd2RXBYR2VqRk5PcDZlMzlLVGhW?=
 =?utf-8?B?VU9ublBUbCtPRktJcmN1STM2SGlDMzlnaENBQWVra3ord3dmVTduL1hFQW5V?=
 =?utf-8?B?eTQ2NjFlcUViVkFIa1NBbndYOVdlcXJuMHVZU1FmTU1OejlKa3FhaElOY3pv?=
 =?utf-8?B?ZDF3KzdTU0lGK2M0NkhuVjdCSXFUeHI0M0dYdmNzUEo0bDhORVh3L2lkK2dx?=
 =?utf-8?B?MXdTVUtZL2Z0Mlpha09xNFpCRkRydHJCMGpXTytTcis3ZXhmNnk5RU5jZldp?=
 =?utf-8?B?L1lrWGJETWpZK2JCSVk4bnJwczl1WFdTU2xVc29tUTRQdzB6ZDJncFBFOW9Z?=
 =?utf-8?B?cFpBNVAzV2NFampaMU1IWk41RklEQ3FGWmpJbS9sVmI3dk5CbzNOOHRTaXZD?=
 =?utf-8?B?WjRJK0VhZDNWemVoQXFBb0MwOE9yNDFMOWFoNkhERTZHM3JLcWt5b25DSm9C?=
 =?utf-8?B?N0pPYno5ZkJva0EwSU9WQXNqWi9TQlNRZWRpREZkYkl1enU0OHhSSFUrcW05?=
 =?utf-8?B?TldKeCtPQ2Fnc1hRTFJMYWNjUzd2MGkxWlEzYWY3cjM4QkZxY3IvVUZsWGVy?=
 =?utf-8?B?dU1HVmtiT0xwMXVTT1FiT1VYYlc3V1VubTZCNmt2L2JwWUxsL0k1bWxDQWJn?=
 =?utf-8?B?R1pBalQxOEEwdW5HZ3dTQmtpdnUyblNDZy9IYWU5Y0JydUxjanQ3MEFPSEJR?=
 =?utf-8?B?UGNKY1REZEg4VnZETGxwZC9yLzFKdXRRQnMrMWxNeVUwL284YVdyZkhqM0xz?=
 =?utf-8?B?R25BeHZJci9RYldFcFpNT01WTXY0QUZEem9UbHFYNVVMSG1CaWFpVGNnMEpB?=
 =?utf-8?B?N05YZXdZc2xEeHEwTXB4b0hYaFQ2emJuaEZLSHQzM1FHYy9YckIzTjNCMUZo?=
 =?utf-8?B?RlYvYWZVekJmRjVFSnAxdVcxU1RwakdFNDliS3g3NVJaQWMxT1g1T0dQaDlM?=
 =?utf-8?B?Mis0c0ltRGU1SzdFM29mSnBvQ1d1dllKUkVvT2lQRHN6di82VFk1OG9BNWtW?=
 =?utf-8?B?dVA1THhCK3Y4cTJzOExyeHJHaGpIcXpDSEFQTi9CYkNWUUNRMGRJeEV2d0ZE?=
 =?utf-8?B?NnBxQkhnL1pJa2hBemtVWFltM1lXc1o5V3ZTWXU1YkorMFRyeXVoaDI3L3hQ?=
 =?utf-8?B?U3gxUmRpaTJrTE9UMnNDNDgyUUxpTm9PUjZIU2F1MDdDa2RrRmJJUXo2ZGxP?=
 =?utf-8?B?Ry96VHp3azJETDhiQm9jZmZwaEJ3amRDYlBKR2NoUEdEZk1xc3RIMWRnelh5?=
 =?utf-8?B?eEJrcEtJQThhcmVZMWxxWmZGVFkzTXNpVjBzWjkwb2dsYW45Y1NhUFlYYzZy?=
 =?utf-8?B?Y05USTZoRXNVU3lXWW5zSlBSNXBERzAxMGpEWnZLM3B4djJ3Ukd2NGhMUldl?=
 =?utf-8?B?WDZIYzRoQ3hNZzY1cllIc0NPd3M1aDRGV21RNnNLcmlyZVZ4VzdrVXNqcjlL?=
 =?utf-8?B?WEdzY3NvaUtydWgvazIxOTB2am5kUC9mTzNHWlJESk9aamVRQ3VsalFmTXor?=
 =?utf-8?Q?MXijQfU5IG1wgzME=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d967049f-9ba0-442c-b96d-08de6d3f7a56
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2026 09:40:53.8296 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 23J7ZCypkn4Tuz/zEQKK3CxILXMQSiXBf7KrgfKTihQGnByjn+cwM8GI+Wilk8V5lEqQASTS/VH5XkVEOm+TxXEenjhlgmYaEl1JTxOZWXw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR02MB7732
X-Proofpoint-ORIG-GUID: fZrlY1Hmf3KYtYF0S5UfhxxpqVo61OPM
X-Proofpoint-GUID: fZrlY1Hmf3KYtYF0S5UfhxxpqVo61OPM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE2MDA4MCBTYWx0ZWRfX9yUn87+Ki4VL
 t6C/8jyS/23joj8BgBRPMXhXkTlaRFqDgmi5ARm9W9tJh3p9Rp21bNdqbm7Ma5Fnx3paIKiV0Dc
 2fhcjEapeg+vGrdqY5pUbJPi9A3FMPq1lqm196kICfwbtpWBI3kjuSl8o2cRBWQQdt0KUT121A9
 KUhQPnKtFBE6C0gX6VfJjiKZLAdUabyDthIP4xyyr8RUTMXf1vRp3BQKmc2wV/gMqHxLJX4Yyyl
 jRns/P2tlXnmCHMzSPGc82OjcVHsj/5eDYT52ZuaUkJzKPf5ZI+bdzTbfrQLJDjtm2+QcuIdWf2
 SfdCBn+eKoNImIeXIXBe4O+dd7zBswABiW5nhA/J9TGisIiihNNvBJ9UYa7BxP3K6y24hRGDHir
 u7lt+CM0tgQcrmVhuAJrGpNX+bfmrENvfg334LmDKkSQFzVEfhJMYi016QDpAj/OQwHDuddbh13
 kJ3IaU6SAF8tkV/GMeQ==
X-Authority-Analysis: v=2.4 cv=T5mBjvKQ c=1 sm=1 tr=0 ts=6992e629 cx=c_pps
 a=4JgRTaXVPfESfdVeiImlhw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=64Cc0HZtAAAA:8 a=20KFwNOVAAAA:8 a=tJwIOWVRvXP4f1c1RKsA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-16_03,2026-02-16_01,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 14/02/2026 07:39, Marc-André Lureau wrote:

> Hi
> 
> On Fri, Feb 13, 2026 at 11:50 AM Mark Cave-Ayland
> <mark.caveayland@nutanix.com> wrote:
>>
>> On 27/01/2026 18:24, marcandre.lureau@redhat.com wrote:
>>
>>> From: Marc-André Lureau <marcandre.lureau@redhat.com>
>>>
>>> Remove the separate audio_pcm_ops structure and move its function
>>> pointers directly into AudioMixengBackendClass. This is a cleaner
>>> QOM-style design where the PCM operations are part of the class
>>> vtable rather than a separate indirection through hw->pcm_ops.
>>>
>>> The HWVoiceOut and HWVoiceIn structures no longer need to store
>>> a pcm_ops pointer, as the operations are now accessed through
>>> the class with AUDIO_MIXENG_BACKEND_GET_CLASS().
>>>
>>> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
>>> ---
>>>    audio/audio_int.h       |  71 +++++++++-----------
>>>    audio/audio_template.h  |  16 +++--
>>>    audio/alsaaudio.c       |  29 ++++-----
>>>    audio/audio-mixeng-be.c | 139 ++++++++++++++++++++++------------------
>>>    audio/dbusaudio.c       |  33 +++++-----
>>>    audio/dsoundaudio.c     |  33 +++++-----
>>>    audio/jackaudio.c       |  29 ++++-----
>>>    audio/noaudio.c         |  29 ++++-----
>>>    audio/ossaudio.c        |  33 +++++-----
>>>    audio/paaudio.c         |  33 +++++-----
>>>    audio/pwaudio.c         |  33 +++++-----
>>>    audio/sdlaudio.c        |  46 +++++++------
>>>    audio/sndioaudio.c      |  32 +++++----
>>>    audio/spiceaudio.c      |  45 ++++++-------
>>>    audio/wavaudio.c        |  17 ++---
>>>    audio/coreaudio.m       |  27 ++++----
>>>    16 files changed, 308 insertions(+), 337 deletions(-)
>>>
>>> diff --git a/audio/audio_int.h b/audio/audio_int.h
>>> index bd9c7a29e41..5334c4baad2 100644
>>> --- a/audio/audio_int.h
>>> +++ b/audio/audio_int.h
>>> @@ -39,8 +39,6 @@ AUD_vlog(const char *cap, const char *fmt, va_list ap);
>>>    void G_GNUC_PRINTF(2, 3)
>>>    AUD_log(const char *cap, const char *fmt, ...);
>>>
>>> -struct audio_pcm_ops;
>>> -
>>>    struct audio_callback {
>>>        void *opaque;
>>>        audio_callback_fn fn;
>>> @@ -81,7 +79,6 @@ typedef struct HWVoiceOut {
>>>        size_t samples;
>>>        QLIST_HEAD (sw_out_listhead, SWVoiceOut) sw_head;
>>>        QLIST_HEAD (sw_cap_listhead, SWVoiceCap) cap_head;
>>> -    struct audio_pcm_ops *pcm_ops;
>>>        QLIST_ENTRY (HWVoiceOut) entries;
>>>    } HWVoiceOut;
>>>
>>> @@ -101,7 +98,6 @@ typedef struct HWVoiceIn {
>>>
>>>        size_t samples;
>>>        QLIST_HEAD (sw_in_listhead, SWVoiceIn) sw_head;
>>> -    struct audio_pcm_ops *pcm_ops;
>>>        QLIST_ENTRY (HWVoiceIn) entries;
>>>    } HWVoiceIn;
>>>
>>> @@ -136,40 +132,6 @@ struct SWVoiceIn {
>>>        QLIST_ENTRY (SWVoiceIn) entries;
>>>    };
>>>
>>> -struct audio_pcm_ops {
>>> -    int    (*init_out)(HWVoiceOut *hw, audsettings *as);
>>> -    void   (*fini_out)(HWVoiceOut *hw);
>>> -    size_t (*write)   (HWVoiceOut *hw, void *buf, size_t size);
>>> -    void   (*run_buffer_out)(HWVoiceOut *hw);
>>> -    /*
>>> -     * Get the free output buffer size. This is an upper limit. The size
>>> -     * returned by function get_buffer_out may be smaller.
>>> -     */
>>> -    size_t (*buffer_get_free)(HWVoiceOut *hw);
>>> -    /*
>>> -     * get a buffer that after later can be passed to put_buffer_out; optional
>>> -     * returns the buffer, and writes it's size to size (in bytes)
>>> -     */
>>> -    void  *(*get_buffer_out)(HWVoiceOut *hw, size_t *size);
>>> -    /*
>>> -     * put back the buffer returned by get_buffer_out; optional
>>> -     * buf must be equal the pointer returned by get_buffer_out,
>>> -     * size may be smaller
>>> -     */
>>> -    size_t (*put_buffer_out)(HWVoiceOut *hw, void *buf, size_t size);
>>> -    void   (*enable_out)(HWVoiceOut *hw, bool enable);
>>> -    void   (*volume_out)(HWVoiceOut *hw, Volume *vol);
>>> -
>>> -    int    (*init_in) (HWVoiceIn *hw, audsettings *as);
>>> -    void   (*fini_in) (HWVoiceIn *hw);
>>> -    size_t (*read)    (HWVoiceIn *hw, void *buf, size_t size);
>>> -    void   (*run_buffer_in)(HWVoiceIn *hw);
>>> -    void  *(*get_buffer_in)(HWVoiceIn *hw, size_t *size);
>>> -    void   (*put_buffer_in)(HWVoiceIn *hw, void *buf, size_t size);
>>> -    void   (*enable_in)(HWVoiceIn *hw, bool enable);
>>> -    void   (*volume_in)(HWVoiceIn *hw, Volume *vol);
>>> -};
>>> -
>>>    audsettings audiodev_to_audsettings(AudiodevPerDirectionOptions *pdo);
>>>    int audioformat_bytes_per_sample(AudioFormat fmt);
>>>    int audio_buffer_frames(AudiodevPerDirectionOptions *pdo,
>>> @@ -220,11 +182,42 @@ struct AudioMixengBackendClass {
>>>        AudioBackendClass parent_class;
>>>
>>>        const char *name;
>>> -    struct audio_pcm_ops *pcm_ops;
>>>        int max_voices_out;
>>>        int max_voices_in;
>>>        size_t voice_size_out;
>>>        size_t voice_size_in;
>>> +
>>> +    int    (*init_out)(HWVoiceOut *hw, audsettings *as);
>>> +    void   (*fini_out)(HWVoiceOut *hw);
>>> +    size_t (*write)   (HWVoiceOut *hw, void *buf, size_t size);
>>> +    void   (*run_buffer_out)(HWVoiceOut *hw);
>>> +    /*
>>> +     * Get the free output buffer size. This is an upper limit. The size
>>> +     * returned by function get_buffer_out may be smaller.
>>> +     */
>>> +    size_t (*buffer_get_free)(HWVoiceOut *hw);
>>> +    /*
>>> +     * get a buffer that after later can be passed to put_buffer_out; optional
>>> +     * returns the buffer, and writes it's size to size (in bytes)
>>> +     */
>>> +    void  *(*get_buffer_out)(HWVoiceOut *hw, size_t *size);
>>> +    /*
>>> +     * put back the buffer returned by get_buffer_out; optional
>>> +     * buf must be equal the pointer returned by get_buffer_out,
>>> +     * size may be smaller
>>> +     */
>>> +    size_t (*put_buffer_out)(HWVoiceOut *hw, void *buf, size_t size);
>>> +    void   (*enable_out)(HWVoiceOut *hw, bool enable);
>>> +    void   (*volume_out)(HWVoiceOut *hw, Volume *vol);
>>> +
>>> +    int    (*init_in) (HWVoiceIn *hw, audsettings *as);
>>> +    void   (*fini_in) (HWVoiceIn *hw);
>>> +    size_t (*read)    (HWVoiceIn *hw, void *buf, size_t size);
>>> +    void   (*run_buffer_in)(HWVoiceIn *hw);
>>> +    void  *(*get_buffer_in)(HWVoiceIn *hw, size_t *size);
>>> +    void   (*put_buffer_in)(HWVoiceIn *hw, void *buf, size_t size);
>>> +    void   (*enable_in)(HWVoiceIn *hw, bool enable);
>>> +    void   (*volume_in)(HWVoiceIn *hw, Volume *vol);
>>>    };
>>>
>>>    struct AudioMixengBackend {
>>> diff --git a/audio/audio_template.h b/audio/audio_template.h
>>> index 7187571c668..08d60422589 100644
>>> --- a/audio/audio_template.h
>>> +++ b/audio/audio_template.h
>>> @@ -223,13 +223,14 @@ static void glue (audio_pcm_hw_gc_, TYPE) (HW **hwp)
>>>    {
>>>        HW *hw = *hwp;
>>>        AudioMixengBackend *s = hw->s;
>>> +    AudioMixengBackendClass *k = AUDIO_MIXENG_BACKEND_GET_CLASS(s);
>>>
>>>        if (!hw->sw_head.lh_first) {
>>>    #ifdef DAC
>>>            audio_detach_capture(hw);
>>>    #endif
>>>            QLIST_REMOVE(hw, entries);
>>> -        glue(hw->pcm_ops->fini_, TYPE) (hw);
>>> +        glue(k->fini_, TYPE)(hw);
>>>            glue(s->nb_hw_voices_, TYPE) += 1;
>>>            glue(audio_pcm_hw_free_resources_ , TYPE) (hw);
>>>            object_unref(hw->s);
>>> @@ -274,8 +275,8 @@ static HW *glue(audio_pcm_hw_add_new_, TYPE)(AudioMixengBackend *s,
>>>            return NULL;
>>>        }
>>>
>>> -    if (audio_bug(__func__, !k->pcm_ops)) {
>>> -        dolog("No host audio driver or missing pcm_ops\n");
>>> +    if (audio_bug(__func__, !glue(k->init_, TYPE))) {
>>> +        dolog("No host audio driver or missing init_%s\n", NAME);
>>>            return NULL;
>>>        }
>>>
>>> @@ -285,13 +286,12 @@ static HW *glue(audio_pcm_hw_add_new_, TYPE)(AudioMixengBackend *s,
>>>         */
>>>        hw = g_malloc0(glue(k->voice_size_, TYPE));
>>>        hw->s = AUDIO_MIXENG_BACKEND(object_ref(s));
>>> -    hw->pcm_ops = k->pcm_ops;
>>>
>>>        QLIST_INIT (&hw->sw_head);
>>>    #ifdef DAC
>>>        QLIST_INIT (&hw->cap_head);
>>>    #endif
>>> -    if (glue (hw->pcm_ops->init_, TYPE) (hw, as)) {
>>> +    if (glue(k->init_, TYPE)(hw, as)) {
>>>            goto err0;
>>>        }
>>>
>>> @@ -330,7 +330,7 @@ static HW *glue(audio_pcm_hw_add_new_, TYPE)(AudioMixengBackend *s,
>>>        return hw;
>>>
>>>     err1:
>>> -    glue (hw->pcm_ops->fini_, TYPE) (hw);
>>> +    glue(k->fini_, TYPE)(hw);
>>>     err0:
>>>        object_unref(hw->s);
>>>        g_free (hw);
>>> @@ -495,6 +495,7 @@ static SW *glue(audio_mixeng_backend_open_, TYPE) (
>>>        const struct audsettings *as)
>>>    {
>>>        AudioMixengBackend *s = AUDIO_MIXENG_BACKEND(be);
>>> +    AudioMixengBackendClass *k;
>>>        AudiodevPerDirectionOptions *pdo;
>>>
>>>        if (audio_bug(__func__, !be || !name || !callback_fn || !as)) {
>>> @@ -503,6 +504,7 @@ static SW *glue(audio_mixeng_backend_open_, TYPE) (
>>>            goto fail;
>>>        }
>>>
>>> +    k = AUDIO_MIXENG_BACKEND_GET_CLASS(s);
>>>        pdo = glue(audio_get_pdo_, TYPE)(s->dev);
>>>
>>>        ldebug ("open %s, freq %d, nchannels %d, fmt %d\n",
>>> @@ -513,7 +515,7 @@ static SW *glue(audio_mixeng_backend_open_, TYPE) (
>>>            goto fail;
>>>        }
>>>
>>> -    if (audio_bug(__func__, !AUDIO_MIXENG_BACKEND_GET_CLASS(s)->pcm_ops)) {
>>> +    if (audio_bug(__func__, !glue(k->init_, TYPE))) {
>>>            dolog("Can not open `%s' (no host audio driver)\n", name);
>>>            goto fail;
>>>        }
>>> diff --git a/audio/alsaaudio.c b/audio/alsaaudio.c
>>> index a49da32cc4e..d3697a148da 100644
>>> --- a/audio/alsaaudio.c
>>> +++ b/audio/alsaaudio.c
>>> @@ -922,21 +922,6 @@ audio_alsa_realize(AudioBackend *abe, Audiodev *dev, Error **errp)
>>>        return audio_alsa_parent_class->realize(abe, dev, errp);
>>>    }
>>>
>>> -static struct audio_pcm_ops alsa_pcm_ops = {
>>> -    .init_out = alsa_init_out,
>>> -    .fini_out = alsa_fini_out,
>>> -    .write    = alsa_write,
>>> -    .buffer_get_free = alsa_buffer_get_free,
>>> -    .run_buffer_out = audio_generic_run_buffer_out,
>>> -    .enable_out = alsa_enable_out,
>>> -
>>> -    .init_in  = alsa_init_in,
>>> -    .fini_in  = alsa_fini_in,
>>> -    .read     = alsa_read,
>>> -    .run_buffer_in = audio_generic_run_buffer_in,
>>> -    .enable_in = alsa_enable_in,
>>> -};
>>> -
>>>    static void audio_alsa_class_init(ObjectClass *klass, const void *data)
>>>    {
>>>        AudioBackendClass *b = AUDIO_BACKEND_CLASS(klass);
>>> @@ -946,11 +931,23 @@ static void audio_alsa_class_init(ObjectClass *klass, const void *data)
>>>
>>>        b->realize = audio_alsa_realize;
>>>        k->name = "alsa";
>>> -    k->pcm_ops = &alsa_pcm_ops;
>>>        k->max_voices_out = INT_MAX;
>>>        k->max_voices_in = INT_MAX;
>>>        k->voice_size_out = sizeof(ALSAVoiceOut);
>>>        k->voice_size_in = sizeof(ALSAVoiceIn);
>>> +
>>> +    k->init_out = alsa_init_out;
>>> +    k->fini_out = alsa_fini_out;
>>> +    k->write = alsa_write;
>>> +    k->buffer_get_free = alsa_buffer_get_free;
>>> +    k->run_buffer_out = audio_generic_run_buffer_out;
>>
>> Is it possible to set k->run_buffer_out to
>> audio_generic_run_buffer_out() in audio_mixeng_backend_class_init()?
>> This would probably make sense as a follow-up patch to this one.
> 
> Yes, in principle we should be able to make all audio_generic fns
> overridable default methods. However, this must be done carefully,
> because each backend mixes or wraps a different subset of those. Also,
> having all audio_generic methods together is not a suitable default
> (audio_generic_run_buffer_in would be called recursively through
> audio_generic_read). I'll leave that for another cleanup series :)

Okay that's fine. Having read through both series, I think what you have 
done is in fairly good shape - there are a few things about the QOM 
modelling I'm not completely sure about, but IMO these series are such 
an improvement over what is there already that there are clear benefits 
to merging.

Thanks again for all the effort that you've put into this.

>>> +    k->enable_out = alsa_enable_out;
>>> +
>>> +    k->init_in = alsa_init_in;
>>> +    k->fini_in = alsa_fini_in;
>>> +    k->read = alsa_read;
>>> +    k->run_buffer_in = audio_generic_run_buffer_in;
>>
>> Same here?
>>
>>> +    k->enable_in = alsa_enable_in;
>>>    }
>>>
>>>    static const TypeInfo audio_alsa_info = {
>>> diff --git a/audio/audio-mixeng-be.c b/audio/audio-mixeng-be.c
>>> index 9d16fb5e654..8f06afba821 100644
>>> --- a/audio/audio-mixeng-be.c
>>> +++ b/audio/audio-mixeng-be.c
>>> @@ -526,7 +526,7 @@ static size_t audio_pcm_sw_read(SWVoiceIn *sw, void *buf, size_t buf_len)
>>>
>>>        audio_pcm_sw_resample_in(sw, live, frames_out_max, &total_in, &total_out);
>>>
>>> -    if (!hw->pcm_ops->volume_in) {
>>> +    if (!AUDIO_MIXENG_BACKEND_GET_CLASS(hw->s)->volume_in) {
>>>            mixeng_volume(sw->resample_buf.buffer, total_out, &sw->vol);
>>>        }
>>>        sw->clip(buf, sw->resample_buf.buffer, total_out);
>>> @@ -579,8 +579,10 @@ static size_t audio_pcm_hw_get_live_out (HWVoiceOut *hw, int *nb_live)
>>>
>>>    static size_t audio_pcm_hw_get_free(HWVoiceOut *hw)
>>>    {
>>> -    return (hw->pcm_ops->buffer_get_free ? hw->pcm_ops->buffer_get_free(hw) :
>>> -            INT_MAX) / hw->info.bytes_per_frame;
>>> +    AudioMixengBackendClass *k = AUDIO_MIXENG_BACKEND_GET_CLASS(hw->s);
>>> +
>>> +    return (k->buffer_get_free ? k->buffer_get_free(hw) : INT_MAX) /
>>> +        hw->info.bytes_per_frame;
>>>    }
>>>
>>>    static void audio_pcm_hw_clip_out(HWVoiceOut *hw, void *pcm_buf, size_t len)
>>> @@ -673,7 +675,7 @@ static size_t audio_pcm_sw_write(SWVoiceOut *sw, void *buf, size_t buf_len)
>>>        if (frames_in_max > sw->resample_buf.pos) {
>>>            sw->conv(sw->resample_buf.buffer + sw->resample_buf.pos,
>>>                     buf, frames_in_max - sw->resample_buf.pos);
>>> -        if (!sw->hw->pcm_ops->volume_out) {
>>> +        if (!AUDIO_MIXENG_BACKEND_GET_CLASS(sw->hw->s)->volume_out) {
>>>                mixeng_volume(sw->resample_buf.buffer + sw->resample_buf.pos,
>>>                              frames_in_max - sw->resample_buf.pos, &sw->vol);
>>>            }
>>> @@ -806,7 +808,7 @@ static size_t audio_mixeng_backend_write(AudioBackend *be, SWVoiceOut *sw,
>>>        if (audio_get_pdo_out(hw->s->dev)->mixing_engine) {
>>>            return audio_pcm_sw_write(sw, buf, size);
>>>        } else {
>>> -        return hw->pcm_ops->write(hw, buf, size);
>>> +        return AUDIO_MIXENG_BACKEND_GET_CLASS(hw->s)->write(hw, buf, size);
>>>        }
>>>    }
>>>
>>> @@ -829,7 +831,7 @@ static size_t audio_mixeng_backend_read(AudioBackend *be,
>>>        if (audio_get_pdo_in(hw->s->dev)->mixing_engine) {
>>>            return audio_pcm_sw_read(sw, buf, size);
>>>        } else {
>>> -        return hw->pcm_ops->read(hw, buf, size);
>>> +        return AUDIO_MIXENG_BACKEND_GET_CLASS(hw->s)->read(hw, buf, size);
>>>        }
>>>
>>>    }
>>> @@ -863,12 +865,14 @@ static void audio_mixeng_backend_set_active_out(AudioBackend *be, SWVoiceOut *sw
>>>            SWVoiceCap *sc;
>>>
>>>            if (on) {
>>> +            AudioMixengBackendClass *k = AUDIO_MIXENG_BACKEND_GET_CLASS(s);
>>> +
>>>                hw->pending_disable = 0;
>>>                if (!hw->enabled) {
>>>                    hw->enabled = true;
>>>                    if (runstate_is_running()) {
>>> -                    if (hw->pcm_ops->enable_out) {
>>> -                        hw->pcm_ops->enable_out(hw, true);
>>> +                    if (k->enable_out) {
>>> +                        k->enable_out(hw, true);
>>>                        }
>>>                        audio_reset_timer (s);
>>>                    }
>>> @@ -908,14 +912,15 @@ static void audio_mixeng_backend_set_active_in(AudioBackend *be, SWVoiceIn *sw,
>>>        hw = sw->hw;
>>>        if (sw->active != on) {
>>>            AudioMixengBackend *s = sw->s;
>>> +        AudioMixengBackendClass *k = AUDIO_MIXENG_BACKEND_GET_CLASS(s);
>>>            SWVoiceIn *temp_sw;
>>>
>>>            if (on) {
>>>                if (!hw->enabled) {
>>>                    hw->enabled = true;
>>>                    if (runstate_is_running()) {
>>> -                    if (hw->pcm_ops->enable_in) {
>>> -                        hw->pcm_ops->enable_in(hw, true);
>>> +                    if (k->enable_in) {
>>> +                        k->enable_in(hw, true);
>>>                        }
>>>                        audio_reset_timer (s);
>>>                    }
>>> @@ -932,8 +937,8 @@ static void audio_mixeng_backend_set_active_in(AudioBackend *be, SWVoiceIn *sw,
>>>
>>>                    if (nb_active == 1) {
>>>                        hw->enabled = false;
>>> -                    if (hw->pcm_ops->enable_in) {
>>> -                        hw->pcm_ops->enable_in(hw, false);
>>> +                    if (k->enable_in) {
>>> +                        k->enable_in(hw, false);
>>>                        }
>>>                    }
>>>                }
>>> @@ -1040,12 +1045,13 @@ static void audio_capture_mix_and_clear(HWVoiceOut *hw, size_t rpos,
>>>
>>>    static size_t audio_pcm_hw_run_out(HWVoiceOut *hw, size_t live)
>>>    {
>>> +    AudioMixengBackendClass *k = AUDIO_MIXENG_BACKEND_GET_CLASS(hw->s);
>>>        size_t clipped = 0;
>>>
>>>        while (live) {
>>>            size_t size = live * hw->info.bytes_per_frame;
>>>            size_t decr, proc;
>>> -        void *buf = hw->pcm_ops->get_buffer_out(hw, &size);
>>> +        void *buf = k->get_buffer_out(hw, &size);
>>>
>>>            if (size == 0) {
>>>                break;
>>> @@ -1055,8 +1061,7 @@ static size_t audio_pcm_hw_run_out(HWVoiceOut *hw, size_t live)
>>>            if (buf) {
>>>                audio_pcm_hw_clip_out(hw, buf, decr);
>>>            }
>>> -        proc = hw->pcm_ops->put_buffer_out(hw, buf,
>>> -                                           decr * hw->info.bytes_per_frame) /
>>> +        proc = k->put_buffer_out(hw, buf, decr * hw->info.bytes_per_frame) /
>>>                hw->info.bytes_per_frame;
>>>
>>>            live -= proc;
>>> @@ -1068,8 +1073,8 @@ static size_t audio_pcm_hw_run_out(HWVoiceOut *hw, size_t live)
>>>            }
>>>        }
>>>
>>> -    if (hw->pcm_ops->run_buffer_out) {
>>> -        hw->pcm_ops->run_buffer_out(hw);
>>> +    if (k->run_buffer_out) {
>>> +        k->run_buffer_out(hw);
>>>        }
>>>
>>>        return clipped;
>>> @@ -1077,6 +1082,7 @@ static size_t audio_pcm_hw_run_out(HWVoiceOut *hw, size_t live)
>>>
>>>    static void audio_run_out(AudioMixengBackend *s)
>>>    {
>>> +    AudioMixengBackendClass *k = AUDIO_MIXENG_BACKEND_GET_CLASS(s);
>>>        HWVoiceOut *hw = NULL;
>>>        SWVoiceOut *sw;
>>>
>>> @@ -1092,8 +1098,8 @@ static void audio_run_out(AudioMixengBackend *s)
>>>                if (hw->pending_disable) {
>>>                    hw->enabled = false;
>>>                    hw->pending_disable = false;
>>> -                if (hw->pcm_ops->enable_out) {
>>> -                    hw->pcm_ops->enable_out(hw, false);
>>> +                if (k->enable_out) {
>>> +                    k->enable_out(hw, false);
>>>                    }
>>>                }
>>>
>>> @@ -1102,8 +1108,8 @@ static void audio_run_out(AudioMixengBackend *s)
>>>                                    hw_free * sw->info.bytes_per_frame);
>>>                }
>>>
>>> -            if (hw->pcm_ops->run_buffer_out) {
>>> -                hw->pcm_ops->run_buffer_out(hw);
>>> +            if (k->run_buffer_out) {
>>> +                k->run_buffer_out(hw);
>>>                }
>>>
>>>                continue;
>>> @@ -1146,8 +1152,8 @@ static void audio_run_out(AudioMixengBackend *s)
>>>    #endif
>>>                hw->enabled = false;
>>>                hw->pending_disable = false;
>>> -            if (hw->pcm_ops->enable_out) {
>>> -                hw->pcm_ops->enable_out(hw, false);
>>> +            if (k->enable_out) {
>>> +                k->enable_out(hw, false);
>>>                }
>>>                for (sc = hw->cap_head.lh_first; sc; sc = sc->entries.le_next) {
>>>                    sc->sw.active = false;
>>> @@ -1157,8 +1163,8 @@ static void audio_run_out(AudioMixengBackend *s)
>>>            }
>>>
>>>            if (!live) {
>>> -            if (hw->pcm_ops->run_buffer_out) {
>>> -                hw->pcm_ops->run_buffer_out(hw);
>>> +            if (k->run_buffer_out) {
>>> +                k->run_buffer_out(hw);
>>>                }
>>>                continue;
>>>            }
>>> @@ -1202,16 +1208,17 @@ static void audio_run_out(AudioMixengBackend *s)
>>>
>>>    static size_t audio_pcm_hw_run_in(HWVoiceIn *hw, size_t samples)
>>>    {
>>> +    AudioMixengBackendClass *k = AUDIO_MIXENG_BACKEND_GET_CLASS(hw->s);
>>>        size_t conv = 0;
>>>
>>> -    if (hw->pcm_ops->run_buffer_in) {
>>> -        hw->pcm_ops->run_buffer_in(hw);
>>> +    if (k->run_buffer_in) {
>>> +        k->run_buffer_in(hw);
>>>        }
>>>
>>>        while (samples) {
>>>            size_t proc;
>>>            size_t size = samples * hw->info.bytes_per_frame;
>>> -        void *buf = hw->pcm_ops->get_buffer_in(hw, &size);
>>> +        void *buf = k->get_buffer_in(hw, &size);
>>>
>>>            assert(size % hw->info.bytes_per_frame == 0);
>>>            if (size == 0) {
>>> @@ -1222,7 +1229,7 @@ static size_t audio_pcm_hw_run_in(HWVoiceIn *hw, size_t samples)
>>>
>>>            samples -= proc;
>>>            conv += proc;
>>> -        hw->pcm_ops->put_buffer_in(hw, buf, proc * hw->info.bytes_per_frame);
>>> +        k->put_buffer_in(hw, buf, proc * hw->info.bytes_per_frame);
>>>        }
>>>
>>>        return conv;
>>> @@ -1367,6 +1374,8 @@ void audio_run(AudioMixengBackend *s, const char *msg)
>>>
>>>    void audio_generic_run_buffer_in(HWVoiceIn *hw)
>>>    {
>>> +    AudioMixengBackendClass *k = AUDIO_MIXENG_BACKEND_GET_CLASS(hw->s);
>>> +
>>>        if (unlikely(!hw->buf_emul)) {
>>>            hw->size_emul = hw->samples * hw->info.bytes_per_frame;
>>>            hw->buf_emul = g_malloc(hw->size_emul);
>>> @@ -1376,8 +1385,7 @@ void audio_generic_run_buffer_in(HWVoiceIn *hw)
>>>        while (hw->pending_emul < hw->size_emul) {
>>>            size_t read_len = MIN(hw->size_emul - hw->pos_emul,
>>>                                  hw->size_emul - hw->pending_emul);
>>> -        size_t read = hw->pcm_ops->read(hw, hw->buf_emul + hw->pos_emul,
>>> -                                        read_len);
>>> +        size_t read = k->read(hw, hw->buf_emul + hw->pos_emul, read_len);
>>>            hw->pending_emul += read;
>>>            hw->pos_emul = (hw->pos_emul + read) % hw->size_emul;
>>>            if (read < read_len) {
>>> @@ -1415,6 +1423,8 @@ size_t audio_generic_buffer_get_free(HWVoiceOut *hw)
>>>
>>>    void audio_generic_run_buffer_out(HWVoiceOut *hw)
>>>    {
>>> +    AudioMixengBackendClass *k = AUDIO_MIXENG_BACKEND_GET_CLASS(hw->s);
>>> +
>>>        while (hw->pending_emul) {
>>>            size_t write_len, written, start;
>>>
>>> @@ -1423,7 +1433,7 @@ void audio_generic_run_buffer_out(HWVoiceOut *hw)
>>>
>>>            write_len = MIN(hw->pending_emul, hw->size_emul - start);
>>>
>>> -        written = hw->pcm_ops->write(hw, hw->buf_emul + start, write_len);
>>> +        written = k->write(hw, hw->buf_emul + start, write_len);
>>>            hw->pending_emul -= written;
>>>
>>>            if (written < write_len) {
>>> @@ -1458,10 +1468,11 @@ size_t audio_generic_put_buffer_out(HWVoiceOut *hw, void *buf, size_t size)
>>>
>>>    size_t audio_generic_write(HWVoiceOut *hw, void *buf, size_t size)
>>>    {
>>> +    AudioMixengBackendClass *k = AUDIO_MIXENG_BACKEND_GET_CLASS(hw->s);
>>>        size_t total = 0;
>>>
>>> -    if (hw->pcm_ops->buffer_get_free) {
>>> -        size_t free = hw->pcm_ops->buffer_get_free(hw);
>>> +    if (k->buffer_get_free) {
>>> +        size_t free = k->buffer_get_free(hw);
>>>
>>>            size = MIN(size, free);
>>>        }
>>> @@ -1469,7 +1480,7 @@ size_t audio_generic_write(HWVoiceOut *hw, void *buf, size_t size)
>>>        while (total < size) {
>>>            size_t dst_size = size - total;
>>>            size_t copy_size, proc;
>>> -        void *dst = hw->pcm_ops->get_buffer_out(hw, &dst_size);
>>> +        void *dst = k->get_buffer_out(hw, &dst_size);
>>>
>>>            if (dst_size == 0) {
>>>                break;
>>> @@ -1479,7 +1490,7 @@ size_t audio_generic_write(HWVoiceOut *hw, void *buf, size_t size)
>>>            if (dst) {
>>>                memcpy(dst, (char *)buf + total, copy_size);
>>>            }
>>> -        proc = hw->pcm_ops->put_buffer_out(hw, dst, copy_size);
>>> +        proc = k->put_buffer_out(hw, dst, copy_size);
>>>            total += proc;
>>>
>>>            if (proc == 0 || proc < copy_size) {
>>> @@ -1492,22 +1503,23 @@ size_t audio_generic_write(HWVoiceOut *hw, void *buf, size_t size)
>>>
>>>    size_t audio_generic_read(HWVoiceIn *hw, void *buf, size_t size)
>>>    {
>>> +    AudioMixengBackendClass *k = AUDIO_MIXENG_BACKEND_GET_CLASS(hw->s);
>>>        size_t total = 0;
>>>
>>> -    if (hw->pcm_ops->run_buffer_in) {
>>> -        hw->pcm_ops->run_buffer_in(hw);
>>> +    if (k->run_buffer_in) {
>>> +        k->run_buffer_in(hw);
>>>        }
>>>
>>>        while (total < size) {
>>>            size_t src_size = size - total;
>>> -        void *src = hw->pcm_ops->get_buffer_in(hw, &src_size);
>>> +        void *src = k->get_buffer_in(hw, &src_size);
>>>
>>>            if (src_size == 0) {
>>>                break;
>>>            }
>>>
>>>            memcpy((char *)buf + total, src, src_size);
>>> -        hw->pcm_ops->put_buffer_in(hw, src, src_size);
>>> +        k->put_buffer_in(hw, src, src_size);
>>>            total += src_size;
>>>        }
>>>
>>> @@ -1521,13 +1533,13 @@ static bool audio_mixeng_backend_realize(AudioBackend *abe,
>>>        AudioMixengBackendClass *k = AUDIO_MIXENG_BACKEND_GET_CLASS(be);
>>>
>>>        be->dev = dev;
>>> -    if (!k->pcm_ops->get_buffer_in) {
>>> -        k->pcm_ops->get_buffer_in = audio_generic_get_buffer_in;
>>> -        k->pcm_ops->put_buffer_in = audio_generic_put_buffer_in;
>>> +    if (!k->get_buffer_in) {
>>> +        k->get_buffer_in = audio_generic_get_buffer_in;
>>> +        k->put_buffer_in = audio_generic_put_buffer_in;
>>>        }
>>> -    if (!k->pcm_ops->get_buffer_out) {
>>> -        k->pcm_ops->get_buffer_out = audio_generic_get_buffer_out;
>>> -        k->pcm_ops->put_buffer_out = audio_generic_put_buffer_out;
>>> +    if (!k->get_buffer_out) {
>>> +        k->get_buffer_out = audio_generic_get_buffer_out;
>>> +        k->put_buffer_out = audio_generic_put_buffer_out;
>>>        }
>>>
>>>        audio_init_nb_voices_out(be, k, 1);
>>> @@ -1546,18 +1558,19 @@ static void audio_vm_change_state_handler (void *opaque, bool running,
>>>                                               RunState state)
>>>    {
>>>        AudioMixengBackend *s = opaque;
>>> +    AudioMixengBackendClass *k = AUDIO_MIXENG_BACKEND_GET_CLASS(s);
>>>        HWVoiceOut *hwo = NULL;
>>>        HWVoiceIn *hwi = NULL;
>>>
>>>        while ((hwo = audio_pcm_hw_find_any_enabled_out(s, hwo))) {
>>> -        if (hwo->pcm_ops->enable_out) {
>>> -            hwo->pcm_ops->enable_out(hwo, running);
>>> +        if (k->enable_out) {
>>> +            k->enable_out(hwo, running);
>>>            }
>>>        }
>>>
>>>        while ((hwi = audio_pcm_hw_find_any_enabled_in(s, hwi))) {
>>> -        if (hwi->pcm_ops->enable_in) {
>>> -            hwi->pcm_ops->enable_in(hwi, running);
>>> +        if (k->enable_in) {
>>> +            k->enable_in(hwi, running);
>>>            }
>>>        }
>>>        audio_reset_timer (s);
>>> @@ -1627,16 +1640,17 @@ static void audio_mixeng_backend_init(Object *obj)
>>>    static void audio_mixeng_backend_finalize(Object *obj)
>>>    {
>>>        AudioMixengBackend *s = AUDIO_MIXENG_BACKEND(obj);
>>> +    AudioMixengBackendClass *k = AUDIO_MIXENG_BACKEND_GET_CLASS(s);
>>>        HWVoiceOut *hwo, *hwon;
>>>        HWVoiceIn *hwi, *hwin;
>>>
>>>        QLIST_FOREACH_SAFE(hwo, &s->hw_head_out, entries, hwon) {
>>>            SWVoiceCap *sc;
>>>
>>> -        if (hwo->enabled && hwo->pcm_ops->enable_out) {
>>> -            hwo->pcm_ops->enable_out(hwo, false);
>>> +        if (hwo->enabled && k->enable_out) {
>>> +            k->enable_out(hwo, false);
>>>            }
>>> -        hwo->pcm_ops->fini_out (hwo);
>>> +        k->fini_out(hwo);
>>>
>>>            for (sc = hwo->cap_head.lh_first; sc; sc = sc->entries.le_next) {
>>>                CaptureVoiceOut *cap = sc->cap;
>>> @@ -1650,10 +1664,10 @@ static void audio_mixeng_backend_finalize(Object *obj)
>>>        }
>>>
>>>        QLIST_FOREACH_SAFE(hwi, &s->hw_head_in, entries, hwin) {
>>> -        if (hwi->enabled && hwi->pcm_ops->enable_in) {
>>> -            hwi->pcm_ops->enable_in(hwi, false);
>>> +        if (hwi->enabled && k->enable_in) {
>>> +            k->enable_in(hwi, false);
>>>            }
>>> -        hwi->pcm_ops->fini_in (hwi);
>>> +        k->fini_in(hwi);
>>>            QLIST_REMOVE(hwi, entries);
>>>        }
>>>
>>> @@ -1694,8 +1708,6 @@ static const VMStateDescription vmstate_audio = {
>>>        }
>>>    };
>>>
>>> -static struct audio_pcm_ops capture_pcm_ops;
>>> -
>>>    static CaptureVoiceOut *audio_mixeng_backend_add_capture(
>>>        AudioBackend *be,
>>>        struct audsettings *as,
>>> @@ -1736,7 +1748,6 @@ static CaptureVoiceOut *audio_mixeng_backend_add_capture(
>>>
>>>            hw = &cap->hw;
>>>            hw->s = s;
>>> -        hw->pcm_ops = &capture_pcm_ops;
>>>            QLIST_INIT (&hw->sw_head);
>>>            QLIST_INIT (&cap->cb_head);
>>>
>>> @@ -1817,14 +1828,15 @@ static void audio_mixeng_backend_set_volume_out(AudioBackend *be, SWVoiceOut *sw
>>>    {
>>>        if (sw) {
>>>            HWVoiceOut *hw = sw->hw;
>>> +        AudioMixengBackendClass *k = AUDIO_MIXENG_BACKEND_GET_CLASS(hw->s);
>>>
>>>            sw->vol.mute = vol->mute;
>>>            sw->vol.l = nominal_volume.l * vol->vol[0] / 255;
>>>            sw->vol.r = nominal_volume.l * vol->vol[vol->channels > 1 ? 1 : 0] /
>>>                255;
>>>
>>> -        if (hw->pcm_ops->volume_out) {
>>> -            hw->pcm_ops->volume_out(hw, vol);
>>> +        if (k->volume_out) {
>>> +            k->volume_out(hw, vol);
>>>            }
>>>        }
>>>    }
>>> @@ -1834,14 +1846,15 @@ static void audio_mixeng_backend_set_volume_in(AudioBackend *be, SWVoiceIn *sw,
>>>    {
>>>        if (sw) {
>>>            HWVoiceIn *hw = sw->hw;
>>> +        AudioMixengBackendClass *k = AUDIO_MIXENG_BACKEND_GET_CLASS(hw->s);
>>>
>>>            sw->vol.mute = vol->mute;
>>>            sw->vol.l = nominal_volume.l * vol->vol[0] / 255;
>>>            sw->vol.r = nominal_volume.r * vol->vol[vol->channels > 1 ? 1 : 0] /
>>>                255;
>>>
>>> -        if (hw->pcm_ops->volume_in) {
>>> -            hw->pcm_ops->volume_in(hw, vol);
>>> +        if (k->volume_in) {
>>> +            k->volume_in(hw, vol);
>>>            }
>>>        }
>>>    }
>>> diff --git a/audio/dbusaudio.c b/audio/dbusaudio.c
>>> index d78d5799952..9d5331b8c47 100644
>>> --- a/audio/dbusaudio.c
>>> +++ b/audio/dbusaudio.c
>>> @@ -691,23 +691,6 @@ dbus_audio_set_server(AudioBackend *s,
>>>        return true;
>>>    }
>>>
>>> -static struct audio_pcm_ops dbus_pcm_ops = {
>>> -    .init_out = dbus_init_out,
>>> -    .fini_out = dbus_fini_out,
>>> -    .write    = audio_generic_write,
>>> -    .get_buffer_out = dbus_get_buffer_out,
>>> -    .put_buffer_out = dbus_put_buffer_out,
>>> -    .enable_out = dbus_enable_out,
>>> -    .volume_out = dbus_volume_out,
>>> -
>>> -    .init_in  = dbus_init_in,
>>> -    .fini_in  = dbus_fini_in,
>>> -    .read     = dbus_read,
>>> -    .run_buffer_in = audio_generic_run_buffer_in,
>>> -    .enable_in = dbus_enable_in,
>>> -    .volume_in = dbus_volume_in,
>>> -};
>>> -
>>>    static void audio_dbus_class_init(ObjectClass *klass, const void *data)
>>>    {
>>>        AudioBackendClass *b = AUDIO_BACKEND_CLASS(klass);
>>> @@ -718,11 +701,25 @@ static void audio_dbus_class_init(ObjectClass *klass, const void *data)
>>>        b->realize = audio_dbus_realize;
>>>        b->set_dbus_server = dbus_audio_set_server;
>>>        k->name = "dbus";
>>> -    k->pcm_ops = &dbus_pcm_ops;
>>>        k->max_voices_out = INT_MAX;
>>>        k->max_voices_in = INT_MAX;
>>>        k->voice_size_out = sizeof(DBusVoiceOut);
>>>        k->voice_size_in = sizeof(DBusVoiceIn);
>>> +
>>> +    k->init_out = dbus_init_out;
>>> +    k->fini_out = dbus_fini_out;
>>> +    k->write = audio_generic_write;
>>> +    k->get_buffer_out = dbus_get_buffer_out;
>>> +    k->put_buffer_out = dbus_put_buffer_out;
>>> +    k->enable_out = dbus_enable_out;
>>> +    k->volume_out = dbus_volume_out;
>>> +
>>> +    k->init_in = dbus_init_in;
>>> +    k->fini_in = dbus_fini_in;
>>> +    k->read = dbus_read;
>>> +    k->run_buffer_in = audio_generic_run_buffer_in;
>>> +    k->enable_in = dbus_enable_in;
>>> +    k->volume_in = dbus_volume_in;
>>>    }
>>>
>>>    static const TypeInfo audio_dbus_info = {
>>> diff --git a/audio/dsoundaudio.c b/audio/dsoundaudio.c
>>> index b8bc6c8c7be..afd901518cc 100644
>>> --- a/audio/dsoundaudio.c
>>> +++ b/audio/dsoundaudio.c
>>> @@ -667,23 +667,6 @@ audio_dsound_realize(AudioBackend *abe, Audiodev *dev, Error **errp)
>>>        return true;
>>>    }
>>>
>>> -static struct audio_pcm_ops dsound_pcm_ops = {
>>> -    .init_out = dsound_init_out,
>>> -    .fini_out = dsound_fini_out,
>>> -    .write    = audio_generic_write,
>>> -    .buffer_get_free = dsound_buffer_get_free,
>>> -    .get_buffer_out = dsound_get_buffer_out,
>>> -    .put_buffer_out = dsound_put_buffer_out,
>>> -    .enable_out = dsound_enable_out,
>>> -
>>> -    .init_in  = dsound_init_in,
>>> -    .fini_in  = dsound_fini_in,
>>> -    .read     = audio_generic_read,
>>> -    .get_buffer_in = dsound_get_buffer_in,
>>> -    .put_buffer_in = dsound_put_buffer_in,
>>> -    .enable_in = dsound_enable_in,
>>> -};
>>> -
>>>    static void audio_dsound_class_init(ObjectClass *klass, const void *data)
>>>    {
>>>        AudioBackendClass *b = AUDIO_BACKEND_CLASS(klass);
>>> @@ -693,11 +676,25 @@ static void audio_dsound_class_init(ObjectClass *klass, const void *data)
>>>
>>>        b->realize = audio_dsound_realize;
>>>        k->name = "dsound";
>>> -    k->pcm_ops = &dsound_pcm_ops;
>>>        k->max_voices_out = INT_MAX;
>>>        k->max_voices_in = 1;
>>>        k->voice_size_out = sizeof(DSoundVoiceOut);
>>>        k->voice_size_in = sizeof(DSoundVoiceIn);
>>> +
>>> +    k->init_out = dsound_init_out;
>>> +    k->fini_out = dsound_fini_out;
>>> +    k->write = audio_generic_write;
>>
>> Same here too?
>>
>>> +    k->buffer_get_free = dsound_buffer_get_free;
>>> +    k->get_buffer_out = dsound_get_buffer_out;
>>> +    k->put_buffer_out = dsound_put_buffer_out;
>>> +    k->enable_out = dsound_enable_out;
>>> +
>>> +    k->init_in = dsound_init_in;
>>> +    k->fini_in = dsound_fini_in;
>>> +    k->read = audio_generic_read;
>>
>> And here?
>>
>>> +    k->get_buffer_in = dsound_get_buffer_in;
>>> +    k->put_buffer_in = dsound_put_buffer_in;
>>> +    k->enable_in = dsound_enable_in;
>>>    }
>>>
>>>    static const TypeInfo audio_dsound_info = {
>>> diff --git a/audio/jackaudio.c b/audio/jackaudio.c
>>> index e69b313afe5..681eb17df55 100644
>>> --- a/audio/jackaudio.c
>>> +++ b/audio/jackaudio.c
>>> @@ -652,21 +652,6 @@ static int qjack_thread_creator(jack_native_thread_t *thread,
>>>    }
>>>    #endif
>>>
>>> -static struct audio_pcm_ops jack_pcm_ops = {
>>> -    .init_out       = qjack_init_out,
>>> -    .fini_out       = qjack_fini_out,
>>> -    .write          = qjack_write,
>>> -    .buffer_get_free = audio_generic_buffer_get_free,
>>
>> And here?
>>
>>> -    .run_buffer_out = audio_generic_run_buffer_out,
>>> -    .enable_out     = qjack_enable_out,
>>> -
>>> -    .init_in        = qjack_init_in,
>>> -    .fini_in        = qjack_fini_in,
>>> -    .read           = qjack_read,
>>> -    .run_buffer_in  = audio_generic_run_buffer_in,
>>> -    .enable_in      = qjack_enable_in
>>> -};
>>> -
>>>    static void qjack_error(const char *msg)
>>>    {
>>>        dolog("E: %s\n", msg);
>>> @@ -682,11 +667,23 @@ static void audio_jack_class_init(ObjectClass *klass, const void *data)
>>>        AudioMixengBackendClass *k = AUDIO_MIXENG_BACKEND_CLASS(klass);
>>>
>>>        k->name = "jack";
>>> -    k->pcm_ops = &jack_pcm_ops;
>>>        k->max_voices_out = INT_MAX;
>>>        k->max_voices_in = INT_MAX;
>>>        k->voice_size_out = sizeof(QJackOut);
>>>        k->voice_size_in = sizeof(QJackIn);
>>> +
>>> +    k->init_out = qjack_init_out;
>>> +    k->fini_out = qjack_fini_out;
>>> +    k->write = qjack_write;
>>> +    k->buffer_get_free = audio_generic_buffer_get_free;
>>> +    k->run_buffer_out = audio_generic_run_buffer_out;
>>> +    k->enable_out = qjack_enable_out;
>>> +
>>> +    k->init_in = qjack_init_in;
>>> +    k->fini_in = qjack_fini_in;
>>> +    k->read = qjack_read;
>>> +    k->run_buffer_in = audio_generic_run_buffer_in;
>>> +    k->enable_in = qjack_enable_in;
>>>    }
>>>
>>>    static const TypeInfo audio_jack_info = {
>>> diff --git a/audio/noaudio.c b/audio/noaudio.c
>>> index d1fba117133..2f4c3a77457 100644
>>> --- a/audio/noaudio.c
>>> +++ b/audio/noaudio.c
>>> @@ -110,31 +110,28 @@ static void no_enable_in(HWVoiceIn *hw, bool enable)
>>>        }
>>>    }
>>>
>>> -static struct audio_pcm_ops no_pcm_ops = {
>>> -    .init_out = no_init_out,
>>> -    .fini_out = no_fini_out,
>>> -    .write    = no_write,
>>> -    .buffer_get_free = audio_generic_buffer_get_free,
>>> -    .run_buffer_out = audio_generic_run_buffer_out,
>>> -    .enable_out = no_enable_out,
>>> -
>>> -    .init_in  = no_init_in,
>>> -    .fini_in  = no_fini_in,
>>> -    .read     = no_read,
>>> -    .run_buffer_in = audio_generic_run_buffer_in,
>>> -    .enable_in = no_enable_in
>>> -};
>>> -
>>>    static void audio_none_class_init(ObjectClass *klass, const void *data)
>>>    {
>>>        AudioMixengBackendClass *k = AUDIO_MIXENG_BACKEND_CLASS(klass);
>>>
>>>        k->name = "none";
>>> -    k->pcm_ops = &no_pcm_ops;
>>>        k->max_voices_out = INT_MAX;
>>>        k->max_voices_in = INT_MAX;
>>>        k->voice_size_out = sizeof(NoVoiceOut);
>>>        k->voice_size_in = sizeof(NoVoiceIn);
>>> +
>>> +    k->init_out = no_init_out;
>>> +    k->fini_out = no_fini_out;
>>> +    k->write = no_write;
>>> +    k->buffer_get_free = audio_generic_buffer_get_free;
>>> +    k->run_buffer_out = audio_generic_run_buffer_out;
>>> +    k->enable_out = no_enable_out;
>>> +
>>> +    k->init_in = no_init_in;
>>> +    k->fini_in = no_fini_in;
>>> +    k->read = no_read;
>>> +    k->run_buffer_in = audio_generic_run_buffer_in;
>>> +    k->enable_in = no_enable_in;
>>>    }
>>>
>>>    static const TypeInfo audio_none_info = {
>>> diff --git a/audio/ossaudio.c b/audio/ossaudio.c
>>> index 15fdf54eb3e..95b7963ed0c 100644
>>> --- a/audio/ossaudio.c
>>> +++ b/audio/ossaudio.c
>>> @@ -755,23 +755,6 @@ audio_oss_realize(AudioBackend *abe, Audiodev *dev, Error **errp)
>>>        return audio_oss_parent_class->realize(abe, dev, errp);
>>>    }
>>>
>>> -static struct audio_pcm_ops oss_pcm_ops = {
>>> -    .init_out = oss_init_out,
>>> -    .fini_out = oss_fini_out,
>>> -    .write    = oss_write,
>>> -    .buffer_get_free = oss_buffer_get_free,
>>> -    .run_buffer_out = oss_run_buffer_out,
>>> -    .get_buffer_out = oss_get_buffer_out,
>>> -    .put_buffer_out = oss_put_buffer_out,
>>> -    .enable_out = oss_enable_out,
>>> -
>>> -    .init_in  = oss_init_in,
>>> -    .fini_in  = oss_fini_in,
>>> -    .read     = oss_read,
>>> -    .run_buffer_in = audio_generic_run_buffer_in,
>>> -    .enable_in = oss_enable_in
>>> -};
>>> -
>>>    static void audio_oss_class_init(ObjectClass *klass, const void *data)
>>>    {
>>>        AudioBackendClass *b = AUDIO_BACKEND_CLASS(klass);
>>> @@ -781,11 +764,25 @@ static void audio_oss_class_init(ObjectClass *klass, const void *data)
>>>
>>>        b->realize = audio_oss_realize;
>>>        k->name = "oss";
>>> -    k->pcm_ops = &oss_pcm_ops;
>>>        k->max_voices_out = INT_MAX;
>>>        k->max_voices_in = INT_MAX;
>>>        k->voice_size_out = sizeof(OSSVoiceOut);
>>>        k->voice_size_in = sizeof(OSSVoiceIn);
>>> +
>>> +    k->init_out = oss_init_out;
>>> +    k->fini_out = oss_fini_out;
>>> +    k->write = oss_write;
>>> +    k->buffer_get_free = oss_buffer_get_free;
>>> +    k->run_buffer_out = oss_run_buffer_out;
>>> +    k->get_buffer_out = oss_get_buffer_out;
>>> +    k->put_buffer_out = oss_put_buffer_out;
>>> +    k->enable_out = oss_enable_out;
>>> +
>>> +    k->init_in = oss_init_in;
>>> +    k->fini_in = oss_fini_in;
>>> +    k->read = oss_read;
>>> +    k->run_buffer_in = audio_generic_run_buffer_in;
>>> +    k->enable_in = oss_enable_in;
>>>    }
>>>
>>>    static const TypeInfo audio_oss_info = {
>>> diff --git a/audio/paaudio.c b/audio/paaudio.c
>>> index 056158755c6..e98b4a33b68 100644
>>> --- a/audio/paaudio.c
>>> +++ b/audio/paaudio.c
>>> @@ -913,23 +913,6 @@ static void audio_pa_finalize(Object *obj)
>>>        }
>>>    }
>>>
>>> -static struct audio_pcm_ops qpa_pcm_ops = {
>>> -    .init_out = qpa_init_out,
>>> -    .fini_out = qpa_fini_out,
>>> -    .write    = qpa_write,
>>> -    .buffer_get_free = qpa_buffer_get_free,
>>> -    .get_buffer_out = qpa_get_buffer_out,
>>> -    .put_buffer_out = qpa_put_buffer_out,
>>> -    .volume_out = qpa_volume_out,
>>> -
>>> -    .init_in  = qpa_init_in,
>>> -    .fini_in  = qpa_fini_in,
>>> -    .read     = qpa_read,
>>> -    .get_buffer_in = qpa_get_buffer_in,
>>> -    .put_buffer_in = qpa_put_buffer_in,
>>> -    .volume_in = qpa_volume_in
>>> -};
>>> -
>>>    static void audio_pa_class_init(ObjectClass *klass, const void *data)
>>>    {
>>>        AudioBackendClass *b = AUDIO_BACKEND_CLASS(klass);
>>> @@ -939,11 +922,25 @@ static void audio_pa_class_init(ObjectClass *klass, const void *data)
>>>
>>>        b->realize = audio_pa_realize;
>>>        k->name = "pa";
>>> -    k->pcm_ops = &qpa_pcm_ops;
>>>        k->max_voices_out = INT_MAX;
>>>        k->max_voices_in = INT_MAX;
>>>        k->voice_size_out = sizeof(PAVoiceOut);
>>>        k->voice_size_in = sizeof(PAVoiceIn);
>>> +
>>> +    k->init_out = qpa_init_out;
>>> +    k->fini_out = qpa_fini_out;
>>> +    k->write = qpa_write;
>>> +    k->buffer_get_free = qpa_buffer_get_free;
>>> +    k->get_buffer_out = qpa_get_buffer_out;
>>> +    k->put_buffer_out = qpa_put_buffer_out;
>>> +    k->volume_out = qpa_volume_out;
>>> +
>>> +    k->init_in = qpa_init_in;
>>> +    k->fini_in = qpa_fini_in;
>>> +    k->read = qpa_read;
>>> +    k->get_buffer_in = qpa_get_buffer_in;
>>> +    k->put_buffer_in = qpa_put_buffer_in;
>>> +    k->volume_in = qpa_volume_in;
>>>    }
>>>
>>>    static const TypeInfo audio_pa_info = {
>>> diff --git a/audio/pwaudio.c b/audio/pwaudio.c
>>> index 7cadf7121bb..39b2b8f0a0d 100644
>>> --- a/audio/pwaudio.c
>>> +++ b/audio/pwaudio.c
>>> @@ -822,23 +822,6 @@ audio_pw_finalize(Object *obj)
>>>        g_clear_pointer(&pw->thread_loop, pw_thread_loop_destroy);
>>>    }
>>>
>>> -static struct audio_pcm_ops qpw_pcm_ops = {
>>> -    .init_out = qpw_init_out,
>>> -    .fini_out = qpw_fini_out,
>>> -    .write = qpw_write,
>>> -    .buffer_get_free = qpw_buffer_get_free,
>>> -    .run_buffer_out = audio_generic_run_buffer_out,
>>> -    .enable_out = qpw_enable_out,
>>> -    .volume_out = qpw_volume_out,
>>> -    .volume_in = qpw_volume_in,
>>> -
>>> -    .init_in = qpw_init_in,
>>> -    .fini_in = qpw_fini_in,
>>> -    .read = qpw_read,
>>> -    .run_buffer_in = audio_generic_run_buffer_in,
>>> -    .enable_in = qpw_enable_in
>>> -};
>>> -
>>>    static void audio_pw_class_init(ObjectClass *klass, const void *data)
>>>    {
>>>        AudioBackendClass *b = AUDIO_BACKEND_CLASS(klass);
>>> @@ -848,11 +831,25 @@ static void audio_pw_class_init(ObjectClass *klass, const void *data)
>>>
>>>        b->realize = audio_pw_realize;
>>>        k->name = "pipewire";
>>> -    k->pcm_ops = &qpw_pcm_ops;
>>>        k->max_voices_out = INT_MAX;
>>>        k->max_voices_in = INT_MAX;
>>>        k->voice_size_out = sizeof(PWVoiceOut);
>>>        k->voice_size_in = sizeof(PWVoiceIn);
>>> +
>>> +    k->init_out = qpw_init_out;
>>> +    k->fini_out = qpw_fini_out;
>>> +    k->write = qpw_write;
>>> +    k->buffer_get_free = qpw_buffer_get_free;
>>> +    k->run_buffer_out = audio_generic_run_buffer_out;
>>> +    k->enable_out = qpw_enable_out;
>>> +    k->volume_out = qpw_volume_out;
>>> +
>>> +    k->init_in = qpw_init_in;
>>> +    k->fini_in = qpw_fini_in;
>>> +    k->read = qpw_read;
>>> +    k->run_buffer_in = audio_generic_run_buffer_in;
>>> +    k->enable_in = qpw_enable_in;
>>> +    k->volume_in = qpw_volume_in;
>>>    }
>>>
>>>    static const TypeInfo audio_pw_info = {
>>> diff --git a/audio/sdlaudio.c b/audio/sdlaudio.c
>>> index 90867c0c11d..4fb9abd66c3 100644
>>> --- a/audio/sdlaudio.c
>>> +++ b/audio/sdlaudio.c
>>> @@ -468,29 +468,6 @@ static void audio_sdl_finalize(Object *obj)
>>>        SDL_QuitSubSystem(SDL_INIT_AUDIO);
>>>    }
>>>
>>> -static struct audio_pcm_ops sdl_pcm_ops = {
>>> -    .init_out = sdl_init_out,
>>> -    .fini_out = sdl_fini_out,
>>> -  /* wrapper for audio_generic_write */
>>> -    .write    = sdl_write,
>>> -  /* wrapper for audio_generic_buffer_get_free */
>>> -    .buffer_get_free = sdl_buffer_get_free,
>>> -  /* wrapper for audio_generic_get_buffer_out */
>>> -    .get_buffer_out = sdl_get_buffer_out,
>>> -  /* wrapper for audio_generic_put_buffer_out */
>>> -    .put_buffer_out = sdl_put_buffer_out,
>>> -    .enable_out = sdl_enable_out,
>>> -    .init_in = sdl_init_in,
>>> -    .fini_in = sdl_fini_in,
>>> -  /* wrapper for audio_generic_read */
>>> -    .read = sdl_read,
>>> -  /* wrapper for audio_generic_get_buffer_in */
>>> -    .get_buffer_in = sdl_get_buffer_in,
>>> -  /* wrapper for audio_generic_put_buffer_in */
>>> -    .put_buffer_in = sdl_put_buffer_in,
>>> -    .enable_in = sdl_enable_in,
>>> -};
>>> -
>>>    static void audio_sdl_class_init(ObjectClass *klass, const void *data)
>>>    {
>>>        AudioBackendClass *b = AUDIO_BACKEND_CLASS(klass);
>>> @@ -500,11 +477,32 @@ static void audio_sdl_class_init(ObjectClass *klass, const void *data)
>>>
>>>        b->realize = audio_sdl_realize;
>>>        k->name = "sdl";
>>> -    k->pcm_ops = &sdl_pcm_ops;
>>>        k->max_voices_out = INT_MAX;
>>>        k->max_voices_in = INT_MAX;
>>>        k->voice_size_out = sizeof(SDLVoiceOut);
>>>        k->voice_size_in = sizeof(SDLVoiceIn);
>>> +
>>> +    k->init_out = sdl_init_out;
>>> +    k->fini_out = sdl_fini_out;
>>> +    /* wrapper for audio_generic_write */
>>> +    k->write = sdl_write;
>>> +    /* wrapper for audio_generic_buffer_get_free */
>>> +    k->buffer_get_free = sdl_buffer_get_free;
>>> +    /* wrapper for audio_generic_get_buffer_out */
>>> +    k->get_buffer_out = sdl_get_buffer_out;
>>> +    /* wrapper for audio_generic_put_buffer_out */
>>> +    k->put_buffer_out = sdl_put_buffer_out;
>>> +    k->enable_out = sdl_enable_out;
>>> +
>>> +    k->init_in = sdl_init_in;
>>> +    k->fini_in = sdl_fini_in;
>>> +    /* wrapper for audio_generic_read */
>>> +    k->read = sdl_read;
>>> +    /* wrapper for audio_generic_get_buffer_in */
>>> +    k->get_buffer_in = sdl_get_buffer_in;
>>> +    /* wrapper for audio_generic_put_buffer_in */
>>> +    k->put_buffer_in = sdl_put_buffer_in;
>>> +    k->enable_in = sdl_enable_in;
>>>    }
>>>
>>>    static const TypeInfo audio_sdl_info = {
>>> diff --git a/audio/sndioaudio.c b/audio/sndioaudio.c
>>> index 8be0efbc2d6..bc62f670a33 100644
>>> --- a/audio/sndioaudio.c
>>> +++ b/audio/sndioaudio.c
>>> @@ -527,32 +527,30 @@ static void sndio_fini_in(HWVoiceIn *hw)
>>>        sndio_fini(self);
>>>    }
>>>
>>> -static struct audio_pcm_ops sndio_pcm_ops = {
>>> -    .init_out        = sndio_init_out,
>>> -    .fini_out        = sndio_fini_out,
>>> -    .enable_out      = sndio_enable_out,
>>> -    .write           = audio_generic_write,
>>> -    .buffer_get_free = sndio_buffer_get_free,
>>> -    .get_buffer_out  = sndio_get_buffer_out,
>>> -    .put_buffer_out  = sndio_put_buffer_out,
>>> -    .init_in         = sndio_init_in,
>>> -    .fini_in         = sndio_fini_in,
>>> -    .read            = audio_generic_read,
>>> -    .enable_in       = sndio_enable_in,
>>> -    .get_buffer_in   = sndio_get_buffer_in,
>>> -    .put_buffer_in   = sndio_put_buffer_in,
>>> -};
>>> -
>>>    static void audio_sndio_class_init(ObjectClass *klass, const void *data)
>>>    {
>>>        AudioMixengBackendClass *k = AUDIO_MIXENG_BACKEND_CLASS(klass);
>>>
>>>        k->name = "sndio";
>>> -    k->pcm_ops = &sndio_pcm_ops;
>>>        k->max_voices_out = INT_MAX;
>>>        k->max_voices_in = INT_MAX;
>>>        k->voice_size_out = sizeof(SndioVoice);
>>>        k->voice_size_in = sizeof(SndioVoice);
>>> +
>>> +    k->init_out = sndio_init_out;
>>> +    k->fini_out = sndio_fini_out;
>>> +    k->write = audio_generic_write;
>>> +    k->buffer_get_free = sndio_buffer_get_free;
>>> +    k->get_buffer_out = sndio_get_buffer_out;
>>> +    k->put_buffer_out = sndio_put_buffer_out;
>>> +    k->enable_out = sndio_enable_out;
>>> +
>>> +    k->init_in = sndio_init_in;
>>> +    k->fini_in = sndio_fini_in;
>>> +    k->read = audio_generic_read;
>>> +    k->get_buffer_in = sndio_get_buffer_in;
>>> +    k->put_buffer_in = sndio_put_buffer_in;
>>> +    k->enable_in = sndio_enable_in;
>>>    }
>>>
>>>    static const TypeInfo audio_sndio_info = {
>>> diff --git a/audio/spiceaudio.c b/audio/spiceaudio.c
>>> index 4f20f7f73a9..fa1cb04dbf7 100644
>>> --- a/audio/spiceaudio.c
>>> +++ b/audio/spiceaudio.c
>>> @@ -296,29 +296,6 @@ static void line_in_volume(HWVoiceIn *hw, Volume *vol)
>>>    }
>>>    #endif
>>>
>>> -static struct audio_pcm_ops audio_callbacks = {
>>> -    .init_out = line_out_init,
>>> -    .fini_out = line_out_fini,
>>> -    .write    = audio_generic_write,
>>> -    .buffer_get_free = line_out_get_free,
>>> -    .get_buffer_out = line_out_get_buffer,
>>> -    .put_buffer_out = line_out_put_buffer,
>>> -    .enable_out = line_out_enable,
>>> -#if (SPICE_INTERFACE_PLAYBACK_MAJOR >= 1) && \
>>> -        (SPICE_INTERFACE_PLAYBACK_MINOR >= 2)
>>> -    .volume_out = line_out_volume,
>>> -#endif
>>> -
>>> -    .init_in  = line_in_init,
>>> -    .fini_in  = line_in_fini,
>>> -    .read     = line_in_read,
>>> -    .run_buffer_in = audio_generic_run_buffer_in,
>>> -    .enable_in = line_in_enable,
>>> -#if ((SPICE_INTERFACE_RECORD_MAJOR >= 2) && (SPICE_INTERFACE_RECORD_MINOR >= 2))
>>> -    .volume_in = line_in_volume,
>>> -#endif
>>> -};
>>> -
>>>    static void audio_spice_class_init(ObjectClass *klass, const void *data)
>>>    {
>>>        AudioBackendClass *b = AUDIO_BACKEND_CLASS(klass);
>>> @@ -328,11 +305,31 @@ static void audio_spice_class_init(ObjectClass *klass, const void *data)
>>>
>>>        b->realize = spice_audio_realize;
>>>        k->name = "spice";
>>> -    k->pcm_ops = &audio_callbacks;
>>>        k->max_voices_out = 1;
>>>        k->max_voices_in = 1;
>>>        k->voice_size_out = sizeof(SpiceVoiceOut);
>>>        k->voice_size_in = sizeof(SpiceVoiceIn);
>>> +
>>> +    k->init_out = line_out_init;
>>> +    k->fini_out = line_out_fini;
>>> +    k->write = audio_generic_write;
>>> +    k->buffer_get_free = line_out_get_free;
>>> +    k->get_buffer_out = line_out_get_buffer;
>>> +    k->put_buffer_out = line_out_put_buffer;
>>> +    k->enable_out = line_out_enable;
>>> +#if (SPICE_INTERFACE_PLAYBACK_MAJOR >= 1) && \
>>> +        (SPICE_INTERFACE_PLAYBACK_MINOR >= 2)
>>> +    k->volume_out = line_out_volume;
>>> +#endif
>>> +
>>> +    k->init_in = line_in_init;
>>> +    k->fini_in = line_in_fini;
>>> +    k->read = line_in_read;
>>> +    k->run_buffer_in = audio_generic_run_buffer_in;
>>> +    k->enable_in = line_in_enable;
>>> +#if ((SPICE_INTERFACE_RECORD_MAJOR >= 2) && (SPICE_INTERFACE_RECORD_MINOR >= 2))
>>> +    k->volume_in = line_in_volume;
>>> +#endif
>>>    }
>>>
>>>    static const TypeInfo audio_spice_info = {
>>> diff --git a/audio/wavaudio.c b/audio/wavaudio.c
>>> index 57a2e686785..090f3f4dc60 100644
>>> --- a/audio/wavaudio.c
>>> +++ b/audio/wavaudio.c
>>> @@ -190,25 +190,22 @@ static void wav_enable_out(HWVoiceOut *hw, bool enable)
>>>        }
>>>    }
>>>
>>> -static struct audio_pcm_ops wav_pcm_ops = {
>>> -    .init_out = wav_init_out,
>>> -    .fini_out = wav_fini_out,
>>> -    .write    = wav_write_out,
>>> -    .buffer_get_free = audio_generic_buffer_get_free,
>>> -    .run_buffer_out = audio_generic_run_buffer_out,
>>> -    .enable_out = wav_enable_out,
>>> -};
>>> -
>>>    static void audio_wav_class_init(ObjectClass *klass, const void *data)
>>>    {
>>>        AudioMixengBackendClass *k = AUDIO_MIXENG_BACKEND_CLASS(klass);
>>>
>>>        k->name = "wav";
>>> -    k->pcm_ops = &wav_pcm_ops;
>>>        k->max_voices_out = 1;
>>>        k->max_voices_in = 0;
>>>        k->voice_size_out = sizeof(WAVVoiceOut);
>>>        k->voice_size_in = 0;
>>> +
>>> +    k->init_out = wav_init_out;
>>> +    k->fini_out = wav_fini_out;
>>> +    k->write = wav_write_out;
>>> +    k->buffer_get_free = audio_generic_buffer_get_free;
>>> +    k->run_buffer_out = audio_generic_run_buffer_out;
>>> +    k->enable_out = wav_enable_out;
>>>    }
>>>
>>>    static const TypeInfo audio_wav_info = {
>>> diff --git a/audio/coreaudio.m b/audio/coreaudio.m
>>> index c7602dad223..af614144bd1 100644
>>> --- a/audio/coreaudio.m
>>> +++ b/audio/coreaudio.m
>>> @@ -646,30 +646,27 @@ static void coreaudio_enable_out(HWVoiceOut *hw, bool enable)
>>>        update_device_playback_state(core);
>>>    }
>>>
>>> -static struct audio_pcm_ops coreaudio_pcm_ops = {
>>> -    .init_out = coreaudio_init_out,
>>> -    .fini_out = coreaudio_fini_out,
>>> -  /* wrapper for audio_generic_write */
>>> -    .write    = coreaudio_write,
>>> -  /* wrapper for audio_generic_buffer_get_free */
>>> -    .buffer_get_free = coreaudio_buffer_get_free,
>>> -  /* wrapper for audio_generic_get_buffer_out */
>>> -    .get_buffer_out = coreaudio_get_buffer_out,
>>> -  /* wrapper for audio_generic_put_buffer_out */
>>> -    .put_buffer_out = coreaudio_put_buffer_out,
>>> -    .enable_out = coreaudio_enable_out
>>> -};
>>> -
>>>    static void audio_coreaudio_class_init(ObjectClass *klass, const void *data)
>>>    {
>>>        AudioMixengBackendClass *k = AUDIO_MIXENG_BACKEND_CLASS(klass);
>>>
>>>        k->name = "coreaudio";
>>> -    k->pcm_ops = &coreaudio_pcm_ops;
>>>        k->max_voices_out = 1;
>>>        k->max_voices_in = 0;
>>>        k->voice_size_out = sizeof(coreaudioVoiceOut);
>>>        k->voice_size_in = 0;
>>> +
>>> +    k->init_out = coreaudio_init_out;
>>> +    k->fini_out = coreaudio_fini_out;
>>> +    /* wrapper for audio_generic_write */
>>> +    k->write = coreaudio_write;
>>> +    /* wrapper for audio_generic_buffer_get_free */
>>> +    k->buffer_get_free = coreaudio_buffer_get_free;
>>> +    /* wrapper for audio_generic_get_buffer_out */
>>> +    k->get_buffer_out = coreaudio_get_buffer_out;
>>> +    /* wrapper for audio_generic_put_buffer_out */
>>> +    k->put_buffer_out = coreaudio_put_buffer_out;
>>> +    k->enable_out = coreaudio_enable_out;
>>>    }
>>>
>>>    static const TypeInfo audio_coreaudio_info = {
>>
>> Regardless:
>>
>> Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>


ATB,

Mark.


