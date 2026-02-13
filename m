Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E8C3EDF150
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Feb 2026 10:28:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqqPj-00007G-Mj; Fri, 13 Feb 2026 05:28:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1vqqPh-00006I-Hr
 for qemu-devel@nongnu.org; Fri, 13 Feb 2026 05:28:41 -0500
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1vqqPe-0000LN-BC
 for qemu-devel@nongnu.org; Fri, 13 Feb 2026 05:28:41 -0500
Received: from pps.filterd (m0127842.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 61D53Vlu3415931; Fri, 13 Feb 2026 02:28:33 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=b+yQ1NxEVvKOcQG3UiUAkhtAcPc0WgmZzpYJgXqDY
 HU=; b=eJhg3j9i1CRj/uJtwOb0RqRL8/7upXDwSGzY9yi0RouAGz17e9zvQq6ew
 RpF6wUV/hCn37WU1tWZlglplINOXeaIh6RXETv05oay2UiNy7tjxzEX2HZrzsfAf
 6wh7KHoje2XoB/Y9TJ3cSdVBImEz3RITJqRy7zTo2XHgdPMTkmvgZMojp7wXjWok
 p87/q5q2Ya3FZBcSlDeQSg3gtn/QyE7mG7Bw6H9Q8YWE4wwGyabCEjUm+98EMSXq
 PtqnHffrOFm/6X0zZczRc9KD/07lSDEP4XN/taQS45mJzA8n5kurq3kYJKERzoQR
 drwcokFxQ/rSkrXZ4mlB2v6S5wJhA==
Received: from sn4pr2101cu001.outbound.protection.outlook.com
 (mail-southcentralusazon11022129.outbound.protection.outlook.com
 [40.93.195.129])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4c9jp9t806-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 13 Feb 2026 02:28:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RIbD5MJgunHK1z3v8U2yxS6AJIV3x3GsCkPjCpv+Ppis0n9UKJCIa3rBZR6jK6+vcYc0YN99mc4GjAAyc1XBp0d5CNX1MyvyUMgNC+Y1akqGs/uJ/TwaZ94LXbNLOHyWv+g8T2HFjHOcKq2CPltP/SJSRFUcuoOY7v2D8Ws9EDGa9rW5u5r7ZIJ6yvLQU0ouAmwN+b9OFicO9023QUSfgL3A3+Sl4ELPCrUiTRaeuso1+wYM0xAm9QAq+AoFiouEkYLG3Mq+zMgnY+sDQAXFOVyitHNaJq8ulRnOHLeL6epoMHfbkATjK8pqPPtU+BacQZMXd+jcvm6e56emT/KD9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b+yQ1NxEVvKOcQG3UiUAkhtAcPc0WgmZzpYJgXqDYHU=;
 b=OrVdN0c3VTY+76wMwp34W/f6bB+PRxqmfMMHEWavYaOiII6G2xBettyyFp74zQ35vc2LxENlnw/QgJ2ved8EKJecGeI0YUls2aig1CNpv0syY0UCMJjCtdjuuuLiuyr7311kKsXoNGl+uWyTNeQG2M9MNa+zNW849i99C9XTU3wIVy+AeUnyiuaFw12YLaaedG/QXezs6AUMMY9p9MmvwFkWOk2+HsNg17IaZbzSIN2rA+zRHokYlGe7+1NpOIH3uhiBYNV55GbA/hs6hLotlvycXndQ6oK1mpSBqAN1LXwNPs9XatH2Mkrv6liddFralmLwAWmP2jyYJ3WWeKUEXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b+yQ1NxEVvKOcQG3UiUAkhtAcPc0WgmZzpYJgXqDYHU=;
 b=BxX+cPiQqlmfPSlQjsBmxADZXVWqxzDH1d6DHNQazhuNBJa9ufdwKwrqp74y+ugYo+T304fFOqO5tqwdAVW7PSgOCsahu2H69ngjz5SkBWHuv7TD6M7DJwOe7t3ZP6Sre43FgdCouySnx95spK31si43B4F2/Rf9A+4VTd7djhtihoapUDe2MwOOoQhI/sZgjC0fEW6YArkWdCR3S6ufR9wBhPQ51NqVpDWBmlLncJfRVYHufzAK73Z5oEH56to8PY6QPVWnhdqG5NE1yIni0Q9iHjU7Jdmn2eIsCgGGP6MrIfoReI7DKufdG3Tqj2LitSqR6VyeNl4sNEnsFuxGwQ==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by SA1PR02MB8416.namprd02.prod.outlook.com (2603:10b6:806:1f7::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.10; Fri, 13 Feb
 2026 10:28:28 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%7]) with mapi id 15.20.9611.012; Fri, 13 Feb 2026
 10:28:28 +0000
Message-ID: <34a65ff0-62bb-442e-97e3-dc71f31daae7@nutanix.com>
Date: Fri, 13 Feb 2026 10:28:24 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/43] audio/sndio: convert to QOM lifecycle methods
To: marcandre.lureau@redhat.com, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, Alexandre Ratchov <alex@caoua.org>
References: <20260127182516.289834-1-marcandre.lureau@redhat.com>
 <20260127182516.289834-12-marcandre.lureau@redhat.com>
Content-Language: en-US
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
In-Reply-To: <20260127182516.289834-12-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0259.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:194::12) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|SA1PR02MB8416:EE_
X-MS-Office365-Filtering-Correlation-Id: 94c5dc4b-3e16-4b1e-66b4-08de6aeaa0d9
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OE1JQ0loY0tHejJXQ1ZpSVRBUUJKS2w4a0RXeTl3T0NnaUZBcDR2RjFlY2Zq?=
 =?utf-8?B?OGw0MDhwM2FoT3R5RGhkSXFWUHYxcERSVHlpMDgrODJjbjFCZUs4YlM0VWNX?=
 =?utf-8?B?emcrOWJVWEVvRkdDd1g2SU5tTEplMGlOUFpCZ0JnNHgvY3FBTmxTY3BPU3pF?=
 =?utf-8?B?aWZ3Q3dWM214dzdOYnRtNnVlU0Y1bWJ3UlZ3OXZTWFhLUWRtNGFWeW1lMkdk?=
 =?utf-8?B?MjdaSlJ1bXA1NzlpUVdsYnJYZjNaVmhZYU00M3VlcDJvcnFqNGUvczZBSXoz?=
 =?utf-8?B?VmROclNxWHExYW14YlhwY21DMXBmcHlxZ0RvU09kWHJiK000QUpOOUpzSnpE?=
 =?utf-8?B?VmhuNUZyaDVXeFJsa1AvZGhFUUZxOWM4Ulh0cFp6Y3JReWdyNTdTZnl0RmtM?=
 =?utf-8?B?UUsxSEdLZ2NxV2d0SDJVNS90Vkxvc1VnbW4yWHVxUWIvWXlDQjNoMThmWnp6?=
 =?utf-8?B?N2FZNmh1alBKdUpoVEdFcCtnN1pKREVwMTEvem1KQy95SXNMb2dkUmpiVkJP?=
 =?utf-8?B?WE1OMVBEd2RjTXMyaXRQcFFuUUFBWGxZUU1uREE2RXNPUk1VSzVTaHFtY1FV?=
 =?utf-8?B?aWF4SHJvUlNYNjBpQ0lrR1JEdkpYR0FBYmx2WEx4SmRFa3VzdGVWc3A4MDFR?=
 =?utf-8?B?UnBYUm5naUR1N29jSkpxejBFTi9OWHhhM0RlNjVWRVRCU1EwMW1pZXBUVzRu?=
 =?utf-8?B?ZitULzJseTZKZnBOdjRTaGMyTFVRaTZabVJ1YS9Eb1EraEhtcm0rN0pSRUZL?=
 =?utf-8?B?RlB2OFE0MGhFWW9nS05sdnlyUVgwVWNqTldjNUphOElnaXdjRXlPZGNHZTlK?=
 =?utf-8?B?Z2o1bUMrRTBKa3BJNjlvYlVibEdYNjg2UFI0NXJnY0dEUytWeWFqU3MreU9Q?=
 =?utf-8?B?b01scXZuMGNZZE8xUnBHWkovUE5XTFo0NmFPTWNRSzhpYTJCSnRkUWloVm84?=
 =?utf-8?B?R2ExcEFtWGk5Y3pjZEVnbTdhajhhZExYNGRrQ3c4WE9NZllwYUR2VXBaSVlL?=
 =?utf-8?B?SXNBaUd3VHlNVTBvTEdNVFdWMUdwRE9nNVh3ek01S2FuOGJSRU5wNDdrMWIw?=
 =?utf-8?B?SW9ST3IzTm1xSC94Ty9pdDVsSXIyVjFmMXl3MUVCSkRyUkZ4SHRrR2kwNWZV?=
 =?utf-8?B?SDFGRFBnalByRlQxODllYWZUSjFSbVd1VVROWnZlS0FOcUNpSlRtTi8xR2pl?=
 =?utf-8?B?Ujl1YUxkUjBlVlB0ZGlZS3hiaHhkU3REbGhCeGRVa2pZM0d5cjhpUDNpVFFs?=
 =?utf-8?B?elc1Z0tFT0tEWnhhTS84Q1cvN0RUYysxWDdQdWdoenZFTWJHaWJrVnZoMTZk?=
 =?utf-8?B?SWRrcmxWTm4rdFk5aWFGMTc0NlZra01scUlPWkhLcS8yRnFoMitBZTJzdUN3?=
 =?utf-8?B?MkU2Z1Z1R2dlZEszMjlDYmlWUDdRNksxYzZ1MTRpY3R1Z3VoOFNyamZLY0E3?=
 =?utf-8?B?eDFnZmJtWm5McmUwTVpzM003OVJHZ3FUR2xkQ2hpaVROc0JNK1pVMUhmSGFp?=
 =?utf-8?B?dGFBeFpPeU92ajFFd3NqNXlLOE5iVllab2M2RmhqRkIwb29qUUdxVlE0NU5G?=
 =?utf-8?B?eHJYNUJXQnFXVTJFeEFKUXA5T013SXA4ekdDekJJYUlWeWZYU3pUeWxJV1R0?=
 =?utf-8?B?QUh3VDdlK25lU1hzc1I5UWZFOG00Q2lzSVpMNFZBNEJWM050cmIraU42aXNR?=
 =?utf-8?B?dElFRkc1S05adWFVTFBaSlBXcVRDTk5lNlY2MGd2d1p1ZHJRejUyM3hKVXJ5?=
 =?utf-8?B?MUpWMUY0cUlnVmZJc0JlN3F0VUl2SzhHL3lROTdUS3B3VGtuMFQ3SFhPenBt?=
 =?utf-8?B?YmlCa3NnSXBmcHV2SU02elBXTXFCQ25MWjk3ay9CVFF1T2s5a1hpOW5YdXJT?=
 =?utf-8?B?clJhYmVqQVMrWTBIamRlQkVRZG9wT2gxVHBCWE9Ba3U4eWZwaG9udy9RUlU4?=
 =?utf-8?B?MzRzYUlyVXlOYzZWUTVETFgxLzZhUXNTTUhXS2Y1aFpubDlrT2pVeWs0VElY?=
 =?utf-8?B?d0c4T0o1QlBVbk1kVWFoU0FTUy9XS1Z4Z0FGa01lZFVBeDB6Q3FvcG1pQjdw?=
 =?utf-8?B?SG1ZVzRGUEN2WHlMOXRaN1FPSUdqd0Q0K2N2b01aZy9PM3E1NVRpMStXbTN1?=
 =?utf-8?Q?1oW8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RFFZNVlhOHNMOC9oU2VkWnZ6TnUvVHlUWEtTaG5qRXpreEFmaVdWK3V0cHFP?=
 =?utf-8?B?QzlMWnU1QThIWEtVLzdtUmpjUFdhZ2lvRFhCd2tUczVKT202VExxZU9zN0Ir?=
 =?utf-8?B?MGtRcmdnTm1paHZTSWdhWU03VjU0MDdqVnNCbmQ2eEg0VWp4bWFWWDdUMjdL?=
 =?utf-8?B?aVFyaEprd0cyVmV0cXU5Y3VTWkN1T0JnbVpJVGpJMkM5Wm5ia09qZ0hKUjNK?=
 =?utf-8?B?RFJDR25XVkFMelgrYTgycDNZcFZZY0ZzTXh3UGpiU0Q5VnJGT0I0Ull5NXZQ?=
 =?utf-8?B?NndUdTJrUitjVFlDUnpETllKRmt6NG5LVzFsMmJtNi9TUXJzYjVJYnRuSk5I?=
 =?utf-8?B?NUlZZzBqeU1XTUhHeWx2Uyt0UFFCNzdCdDFndWM1MUNNbVlueUVUbmZGZnVU?=
 =?utf-8?B?SnpMRktrVytCSUlYakpFZmE5UXZhMUJ3ajR4ejR2ZThERWs5akExSEJxL05C?=
 =?utf-8?B?cHNYNzVjbW00SFhud3VoWFBTL0N1czJ6WmNKVTA3NXJWSFFZZlU2V0hpZzlT?=
 =?utf-8?B?M21yMndGQ1ZzL25xZ2FFNDVJdUZBM2xYZmI3Zk1TcG5PeCt0YW5Bc1pWMm1H?=
 =?utf-8?B?WVRvMDZUYkdWWG1SbERreFVyRzl2WW5QcEtBQTdrYnl4MmNiYUFHSHdzc0ZT?=
 =?utf-8?B?MmovSDU3TGlKZnZEcTVmdXlOM1UzTnYrUzNMV3R6eHMrM1Z3LzAycWVDd1VN?=
 =?utf-8?B?SDExakNRQzFWcnQ5Q09EaFZYcWVyVHhweWY0QzNBaitaMldGb0orMGNQa0lw?=
 =?utf-8?B?VVJiakxWNXZLMDg2a2FYYVA2cnVBcWlxRUc2RUw5M005RlkxQWh6NVBMdCty?=
 =?utf-8?B?ai9UY3FzRFZab2hCdXRCdk9JdWdhMjBIdVVJMm51L042NkFPYkc3SGMwd2Vy?=
 =?utf-8?B?ZG9OSEI2bzMxL0pLRzFmWmxLaWMwZzR2NWZwdTduNzNmcFU2VlluclNiYmVk?=
 =?utf-8?B?U1NrdVE4VHhzQ0JZanY5QmsydGtYMVNKd05EZm4ySng3OHVqdW9WOENBcW14?=
 =?utf-8?B?WG5wVWtzbDR0YlF3TDRpWGIyaTdlQ08xSno0bWY3b25vbDdmT0g3aTNPTUli?=
 =?utf-8?B?QTJIZHByOGk2c2pyekJrWFZaUUx0SUE5Ly9TNHV1QTc3NmJPd29UT2dIVmhY?=
 =?utf-8?B?ZEg5YzBxY3lqVlk3WFk1R3JWOTJOMllqOFFaVU04bVVSYUhNbXp0dXZ6bVho?=
 =?utf-8?B?U2Y5UVFoWFYyWEJ0aXhqYStDc2ZaYkJRYWdBT1ozRThPNTJpTHR4aVVEektr?=
 =?utf-8?B?SS9ic0tOMUNHVXNqdldlK29PZWY1Unh2VlVWMmphaC9PRlNHNDh0eG1KclVK?=
 =?utf-8?B?OFRUSzFKb005di8ySFpWQWlEY2ZPYjFaUmNiYkNGL3kxbDBJOXNwcE5zbzhI?=
 =?utf-8?B?aU9IK1o2d1E1SDcxV1VqZGFrclF1TUMxNlBtQ3Jpd3d0cWVmQ0lYb2thS3Y4?=
 =?utf-8?B?NnV2VUQxNnlDVEZ0dVhVRXpKVU42dWZtN3FqMXdBYWRzVFhiNnVHM2JpeElD?=
 =?utf-8?B?T0R6ME0zQmZCT1JBV1lYZEdCQkZaYlpBbEN3TERKaUNzN3BNK1lSdi9KMEdF?=
 =?utf-8?B?cXdZUVpLbWZjalhPTmFoS0RTSjJlL0ozZ1p2WWFIZjlRaFlrVEhKNHUrVmVL?=
 =?utf-8?B?QWF5VjMya3c2UkFlcHROSkNrdTdvZkViQVlBYkQ4TEpCTU9JM082YjBQN0ps?=
 =?utf-8?B?RUdzRlJHcEd1WEZaUzZiSWE5YnlYaXhRQjR6ZVhXd2VMaDlrTU54dnBES3Vj?=
 =?utf-8?B?S1NBWjdFQlFPV1ZKQ0RRVW1PenZ3L0dTVVpOQS90WFIyQWUwbldyWEI4QkRs?=
 =?utf-8?B?OEVqUTg3cWIvRVpKQlBWczhaWlF6dWJRSlJ4VHF1WlJoZk9CMUErb2VPNWIw?=
 =?utf-8?B?UU1wNzBIeThTUUdEY2l2b1Z1WU9aczdNWWJCOTZ5YUNjaVB6ZW8xSjJmanRQ?=
 =?utf-8?B?S3hMSHlsWGczOHA0b3RNNldETGYybXRSWHM0dEJkbjl2YllkMWg0V25jWkdz?=
 =?utf-8?B?aWNtOEdHRUl0N1NHREFsaHdUVUE2NVFmNythSEdqc0tBMXl6YlNHMTNFVmRp?=
 =?utf-8?B?ZmNOWXZQc1Z5STdYcWZXRWJVb1lTRGlabkxBZzBjaC9EY0g5V1JRMVJQQXd4?=
 =?utf-8?B?WXh4VWZVdW5LVms2c3dsdnNqN1dEV3BtWUFQeUVvTElqaGkvQ0FOMDZlUkM3?=
 =?utf-8?B?M0lmSGgyRmZCUGZGaUFzT0xNOU9wK09DZ1NQVXZHbTF1ei94czF3M3ZRd0VO?=
 =?utf-8?B?UlhudWxiSHNoME1ZUGR2bXEvWk9sRmNTeWlUOGZXWitqaVQ5VUtpeFB0TUlO?=
 =?utf-8?B?REVUTUt0S0h4blVJZkQzTUN3UHkxTlgvbmIxY0xHN3NlQ2ZacisxWjFaclY1?=
 =?utf-8?Q?K+2t7JIAhaZshnmg=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94c5dc4b-3e16-4b1e-66b4-08de6aeaa0d9
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2026 10:28:28.7743 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g1e/9yLIMBLrySdAAHVCkbU9yYEjRlyU1/Ong4NPhbUS5tfrHQH80zT7O3HfD4oODhW/yGJgMGI1v4VqybBqTMh7CuQkbfY4me0uo33b/yk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR02MB8416
X-Proofpoint-ORIG-GUID: PCCxH73hw6Vt157Zd4eTBXpJmSNfTHAQ
X-Proofpoint-GUID: PCCxH73hw6Vt157Zd4eTBXpJmSNfTHAQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjEzMDA4MCBTYWx0ZWRfX1jDUfh7M16GC
 wpW6Si1TG7YwGqXPC5LtV92x9jQxnDhzc/Hc68TFOwXVHpkZQYSzScy5rrnkHV49fYjmn752vbT
 F0XBOfPQD9wT3mIXBJEgBA14Xrejuk4lIv73r7I2OoZMocHy1Z57+ZrZypkuhxti+XfcZZyItwd
 nHk4eY5IcQfgQSdQrkLUtiQS3IGIhgJP+p4A//X/5mAXVwp4Dd87HDxhoMpKPG17j38CbjTq6CP
 NVuEIpIYRXlw95aeDT5ROOeg3ZDzt3C6pMMQjCLLYvyOJ3LnhqPUrIVMIFvmJ6MDT1g+45sm7G0
 6YdI9bBPJdssnF7FKz2qMc3LeMQ5iRrxbTUoIaS1U7Pkcy+oru4AjVEdw+oYyiwd0/2HV7yM0Mo
 uvwBXN1CPrlOw9OutYqb6mUTaw4Urzyom/9uUDI0KSthGTTLaul014gOVGAMSeWb2tg26wDGGer
 6OSzkG7tgqAwr1Y6SYg==
X-Authority-Analysis: v=2.4 cv=SKJPlevH c=1 sm=1 tr=0 ts=698efcd1 cx=c_pps
 a=+AD+TCgY8d24af2vGjQMRw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=20KFwNOVAAAA:8 a=64Cc0HZtAAAA:8 a=qaICJNsSmycVGMvz6J0A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-13_01,2026-02-12_03,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On 27/01/2026 18:24, marcandre.lureau@redhat.com wrote:

> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> Remove the legacy driver init/fini callbacks from the sndio audio backend.
> 
> Both sndio_audio_init() and sndio_audio_fini() were no-ops that
> performed no real initialization or cleanup work. Access to the
> Audiodev is now through hw->s->dev instead of the drv_opaque pointer.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   audio/sndioaudio.c | 16 ++--------------
>   1 file changed, 2 insertions(+), 14 deletions(-)
> 
> diff --git a/audio/sndioaudio.c b/audio/sndioaudio.c
> index 2fa519e3eab..4c2acbcbb4b 100644
> --- a/audio/sndioaudio.c
> +++ b/audio/sndioaudio.c
> @@ -499,7 +499,7 @@ static int sndio_init_out(HWVoiceOut *hw, struct audsettings *as, void *opaque)
>   {
>       SndioVoice *self = (SndioVoice *) hw;
>   
> -    if (sndio_init(self, as, SIO_PLAY, opaque) == -1) {
> +    if (sndio_init(self, as, SIO_PLAY, hw->s->dev) == -1) {
>           return -1;
>       }
>   
> @@ -512,7 +512,7 @@ static int sndio_init_in(HWVoiceIn *hw, struct audsettings *as, void *opaque)
>   {
>       SndioVoice *self = (SndioVoice *) hw;
>   
> -    if (sndio_init(self, as, SIO_REC, opaque) == -1) {
> +    if (sndio_init(self, as, SIO_REC, hw->s->dev) == -1) {
>           return -1;
>       }
>   
> @@ -535,16 +535,6 @@ static void sndio_fini_in(HWVoiceIn *hw)
>       sndio_fini(self);
>   }
>   
> -static void *sndio_audio_init(Audiodev *dev, Error **errp)
> -{
> -    assert(dev->driver == AUDIODEV_DRIVER_SNDIO);
> -    return dev;
> -}
> -
> -static void sndio_audio_fini(void *opaque)
> -{
> -}
> -
>   static struct audio_pcm_ops sndio_pcm_ops = {
>       .init_out        = sndio_init_out,
>       .fini_out        = sndio_fini_out,
> @@ -563,8 +553,6 @@ static struct audio_pcm_ops sndio_pcm_ops = {
>   
>   static struct audio_driver sndio_audio_driver = {
>       .name           = "sndio",
> -    .init           = sndio_audio_init,
> -    .fini           = sndio_audio_fini,
>       .pcm_ops        = &sndio_pcm_ops,
>       .max_voices_out = INT_MAX,
>       .max_voices_in  = INT_MAX,

Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>


ATB,

Mark.


