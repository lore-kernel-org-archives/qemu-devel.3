Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30573CCFA05
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Nov 2025 17:06:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vH3QU-00034D-NL; Thu, 06 Nov 2025 12:05:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jon@nutanix.com>) id 1vH3QS-00032L-Va
 for qemu-devel@nongnu.org; Thu, 06 Nov 2025 12:05:33 -0500
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jon@nutanix.com>) id 1vH3QQ-0000ty-PO
 for qemu-devel@nongnu.org; Thu, 06 Nov 2025 12:05:32 -0500
Received: from pps.filterd (m0127837.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 5A6FiLHZ1143749; Thu, 6 Nov 2025 09:05:28 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=rqyikG+9B27BjlzdD74KXvLfjhhICNoSC4H9g5DwZ
 ao=; b=NIJNfQLwvPZ0Kh+eENQz3qx/S3Qy6gdox9GpxwsVm6FmyVmZUBxpBuSue
 D1xNI7ew5OYNyv0XQy0260JexAnVb9vOBr196jXwj8pW1S2VTCSPrVEMRgTBI1db
 VxOumNaOE0dR7TM10c+3BrkeYgV7H/fxnx+N/uUT4/iQC8DGUfritolykuzx94SF
 pgppes66vWsWVYaDvASEDdEdhusdhADzJoFKFmdAtqHj2W5VbZnP72Q5gc2Qei+F
 NV+vMlezPv+LNLEZiIW30BZ/F4JbWext9bc51z65DDbCnFmBYpkhOluP0GocE9YQ
 ouff2V3B3DWS26+Nuxp54UAHaCykA==
Received: from bn1pr04cu002.outbound.protection.outlook.com
 (mail-eastus2azon11020091.outbound.protection.outlook.com [52.101.56.91])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4a8bch2y2s-5
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 06 Nov 2025 09:05:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t+SdJLa2IAAfOyowntG5u6Ne+1shtSfcqIn3LyIjClEfapmAdyyzimUHSPMs/epjGcEAXjQUGYR3X5y0ddUHa1xLVJswQRYnHcJXCC4gHwfvMXeEmdC9R9Q3mKEV/EtaXSBMUrdyiqcJZm7JQ91xRPytSEB+yIMCOU3UPmhejYU+gky9QiMlfLH72rjSyuAP+xBcvga6nUAAaCWxlsgr6MSCdMEkPONxtYBfCcdrnbAZyQvvC5wy0yyOJuQojwV7sLgYu0MY+EvwJX9cooQt8/jGUrMnOycNbHm8jt43Y/McfgFRLTa/fhfzK6PJ5JgLuZyTLToyH4UjT8tGvf/zMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rqyikG+9B27BjlzdD74KXvLfjhhICNoSC4H9g5DwZao=;
 b=ZmNXOlPmCoH9evHgK5+w7HLu9L7ZT9ZQBYQJstMyUf4hr3+fJ9WnygJziiNcVMb1P8NiAVIKc+A3IjI9s2CwgmlpH0xc7E9Nnejn0F6N3hIS+oVvVn0KW5X5wb1lMGU2ajgRVfT5E6hiwuk/ELt6ETnbW3nv4fZhMydzM1LY4+IyLsiKej969gs/eSHCHH2R4aWw7+nJJoN01LqU5+ahc5vRCGce7JfTq7Vn8P9A++BV5w5mgbbiZp7gUrJvh/MatVf9CGLEK2bDqQ/cHKJCq+zl2Y8P4CPvW/gX1+hJsVlDq8hKLR5nGblwJKmMO+kZ4RSRaGDPkgX4EBcIiZaRTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rqyikG+9B27BjlzdD74KXvLfjhhICNoSC4H9g5DwZao=;
 b=KVYtzHGSW4e3dfEkSlLvrTCrpf49/ZmsXRk4Fko2qPyaFTfnhhD4UPaB+vxPpZ/9O48Ao8VBiIuA5O19QEhtMWpqOBovvxpjU7FFu8lRGsSjDK/NMi/axbqa9WyT1d+lLO15MeZsSG9q6BxV9e5pPoMkzAJHU4Q5fRnUKw0qlmoK/K5KuP4zC4o4rKCwBGO+HuKdvQdxS+1jUfe4qsDJ6vhmVvkmUm7E1TaAVq//Piq+47+kOXhTs39JYcITQ6iOTlmlNOZ+km0zykPCvaE929EYx/MtTYg0iGSn1APZMqiecFyNiUSJIFi29u7MuOtHdVrHd7jN9IyJIKMa3cjMXg==
Received: from LV0PR02MB11133.namprd02.prod.outlook.com
 (2603:10b6:408:333::18) by BN0PR02MB8000.namprd02.prod.outlook.com
 (2603:10b6:408:16d::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.12; Thu, 6 Nov
 2025 17:05:26 +0000
Received: from LV0PR02MB11133.namprd02.prod.outlook.com
 ([fe80::10e5:8031:1b1b:b2dc]) by LV0PR02MB11133.namprd02.prod.outlook.com
 ([fe80::10e5:8031:1b1b:b2dc%4]) with mapi id 15.20.9275.015; Thu, 6 Nov 2025
 17:05:26 +0000
From: Jon Kohler <jon@nutanix.com>
To: pbonzini@redhat.com, zhao1.liu@intel.com, qemu-devel@nongnu.org,
 pawan.kumar.gupta@linux.intel.com
Cc: Jon Kohler <jon@nutanix.com>
Subject: [PATCH 5/5] target/i386: introduce ClearwaterForest-v2 to expose
 ITS_NO
Date: Thu,  6 Nov 2025 10:46:25 -0700
Message-ID: <20251106174626.49930-6-jon@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251106174626.49930-1-jon@nutanix.com>
References: <20251106174626.49930-1-jon@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH7PR13CA0016.namprd13.prod.outlook.com
 (2603:10b6:510:174::9) To LV0PR02MB11133.namprd02.prod.outlook.com
 (2603:10b6:408:333::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV0PR02MB11133:EE_|BN0PR02MB8000:EE_
X-MS-Office365-Filtering-Correlation-Id: d933061a-a6a8-4463-1c78-08de1d56ae9f
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|52116014|366016|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?g1AYkRnuQIn+mlnsOZL39CPjKhmOD9j3eiw/SBzGmU1PY/AW79pA0Pi9P028?=
 =?us-ascii?Q?JGJPHWs2+idT3QY/ZQ/hYLK69au5Ws1wVRuPT6mnes5AsAp7m9jrIw9Zs3n2?=
 =?us-ascii?Q?GzgIgGg0J3R1wcGMyTG4rQU5kVPX3Mg89e0DHA+GlW1QIzYkqP5Sxwkgwcjk?=
 =?us-ascii?Q?S5vfV2bjUZc1Y0ZofFqDXFuQ00RdphliUc+K86LwRdCdNu34EjWPAddLl4ky?=
 =?us-ascii?Q?J/Wb+mV8C0+ihCM6r48Vfan3mG8pjVe83KD61iAXKzODPHSkd+bH1W0j1nZr?=
 =?us-ascii?Q?xdvHaAJNKAUzyNG/9DCJyRhNVuDSUW8Et9NyN57H46cR0hi3tKLHl2LLfv54?=
 =?us-ascii?Q?s6ptFvkFAyxqRvpSc0FpoF7P9MqC0h6rvugg322P+msbCtsRyuHnBjbAwVb0?=
 =?us-ascii?Q?32U7lql6PxdJwWhjzAlSIJre4URLPbHQi0Dur7RD4dcu0lpefgVe5ZosHg6U?=
 =?us-ascii?Q?mnx+wN6JMRKvMmzch49hHBAlbjyvWq9lVnIwBF98pBCNf+JQ2EUMdcmQAbjR?=
 =?us-ascii?Q?32sBgBf6Cl6PkwCOzXJ/c8bREfMDYHigQmVreqr1Yf5Mdck98+Ny7vInGjrv?=
 =?us-ascii?Q?Za+SA/8Qjc1v1mUkpJ2zT+AHmkk1+7P4SJ0NvuK4KDUpoD/ZnL/vzeMT5OyP?=
 =?us-ascii?Q?t/6qrnLyv5M22M8q/XDDKAaOwV9osAto6L2NnafG/GC1uE5PO9fpJy4jgK7D?=
 =?us-ascii?Q?bqZ6xnx7U560I9g292Vju/X9dZ+8MAFLot/d7YWxirxXA3xGcR7mcmAv8Wv9?=
 =?us-ascii?Q?CSpZhR6EyuFdx39isSA5Oh7oXi381cL8AmQ+umJawYiIuRhjN3hCJp64uWoC?=
 =?us-ascii?Q?BYEioEIB5+6p2QnkOECHqg/neSmA43wTqGcXlWKgt6tFWLUI4TgNLl8KnF9J?=
 =?us-ascii?Q?vNOfr0bzLJp/p5TfxZnqI+Gj1iJN4S6ThaRYo11ZasXUp4qxhk6IdLSEWJuR?=
 =?us-ascii?Q?U5xumWOZhkDmgrSWEBmpLnSJGPCt532zFqHYYQtQTZHRrZii5XLGY5sXN1eC?=
 =?us-ascii?Q?1WRa/QQ2tBYHJV33hiPlBI6AhBRzwycEDcbm72DoWEXV85rpoNN70d4E7dtS?=
 =?us-ascii?Q?2qriYhfGuPgkcItb0kN6+7RdijJKH46cqoxzPzdVhJQTh9on4eko4KfJQDzH?=
 =?us-ascii?Q?Nj/Nk8EjBxzam8dP6Cf67i+SF6l7tHjGp4maztIiIp2Jd//OD3zsxKvDtryI?=
 =?us-ascii?Q?3DLmmOUi/F/AiTJyqhPwAb9csWnWJTbSM0PTYTvai9541FK5L2hC8hlU07/E?=
 =?us-ascii?Q?3QoZODmlCQgrSmdJ3MKVj++yLv56986d0BJfzuy3BktFxeI8yqtWcGar6a8E?=
 =?us-ascii?Q?4UwG8q+Bq5FPsYijGH8XBMs5aOy3gb0noVtWpc0Kj48KgtzY3/t8PNTzTb1e?=
 =?us-ascii?Q?EdHxEh22ioh/5XIHvvACe6cy7FZeC0xh4PYakC1ZPZOqvNfBF74XPacji9+B?=
 =?us-ascii?Q?U7+MAPCL5N4q3kVNFvCUGAl+koh8y6KFudAOAwZZ8+/3gd9Lot54+3jUUjiq?=
 =?us-ascii?Q?EOD2IFQznK714AX2HyoNSUJ/sGTBPWUQuUVN?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV0PR02MB11133.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(52116014)(366016)(1800799024)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?F7pxGtcSqDXXuXyKNnaCkrGSOGYyWitHcEllt06/x2FUt9KV4O85gvPOufwJ?=
 =?us-ascii?Q?P8Fa/sbIrsEh9wY+cnPByA0DiQoOrfQOIsJSP8bwo9paWq222TnksI4imlU0?=
 =?us-ascii?Q?MfxHYLflmWiZQdKJqBDfCNbNZWOqlqnVOMt1gqFF8f+CiZD9Ys4hLPMB856q?=
 =?us-ascii?Q?sn3o7uaix5Qf7P7d7o+K9Nz7jYsCG5yd+bvpbwtLy7OZNzxRF+oSRzGkftJA?=
 =?us-ascii?Q?mQXLn7ZCqXrDQdZNzTciboJHhkSwSAYBo1Rjh7NaiQRJ8AMZgXp1EuoyA0Jp?=
 =?us-ascii?Q?MfO/obhy0/X7gYD43j6kNOqQNCSUM44tik/8vDXSoGzg0s0c9IoQR+qzNYx/?=
 =?us-ascii?Q?omCPAobHP+I93/FnrYCBH8If9I5KjG8us9ro8cVMMYa3Z801UDmzYKlTcFsE?=
 =?us-ascii?Q?M8pE6j1hUc8U2SgNsm9nBDFpu2gjGtEkG6gxFdtTuv6viUaQp/C6MqfbB/eB?=
 =?us-ascii?Q?urOCOnL0zVSLSk1l9lAHJaLMh9dxc+if9in521lo/tuYpoOA5lk9kxildYMn?=
 =?us-ascii?Q?jRI3DvmGh7jRXDdl8fb43KZG6bBWZy4yICV/h/rukJAG/v7PDT1GI24YNXWh?=
 =?us-ascii?Q?yK8mao3MbZjWsDLmJTb6lEPd2gk+S2tQaMevw/okcJWcTBvDojgvnAsQBGqH?=
 =?us-ascii?Q?XIiaQv12WQ8CiDG92hLPBGyFudOmPvSwUQvKIrHRNdGG0AaWOH2CncNlgazR?=
 =?us-ascii?Q?X7kQEZV7tNizjbL9V3LyZqs1lnpxY8XxZmrv6/dADppJZkL3U+2FreTMKpP1?=
 =?us-ascii?Q?au09SJLvpkh0o8UblxZ8mol3mkyea7HsoszSWuO+fWMWtKNoVw0AQspkftZ9?=
 =?us-ascii?Q?dPLz5y1WccW2oj8Va+CCoWBYP/E1qXj2GtvuEtmvck3y4ydLoajHnYkIF181?=
 =?us-ascii?Q?bRpM8yxaJwgrX72kBUwkk9VCB1VLnNDLcyMIk9i4LRmsfhdrMNO2hPel02RZ?=
 =?us-ascii?Q?Sziv2av1HOGKsp4AZXVo+ki3+kj+4bapY6/Da4IvkltdREmqVOGAByuyllIP?=
 =?us-ascii?Q?sGOuMkVL8coPi69qpelWD0vYblWNYjpU42cAgjiwPsKnSCAc1P6TW9HsYslI?=
 =?us-ascii?Q?Q2Lr9cuXTQAIQJcmY23/Cgnyx1lnEwaau8jPS0vx2R54EiY0zhxT3auWhe7X?=
 =?us-ascii?Q?YtX+pkTGsTDIv65D8D8FGGqJ+BqHeu7nEAGOVdzS9FU5RsDigA95YQzPfWIL?=
 =?us-ascii?Q?Fz0MFa2eYfZsKqthz5yrpYuwxLZKbikydIXLx5YQA6a5GExJdYjWX0o2HWNv?=
 =?us-ascii?Q?UMe6mzrNuLVcgH7UAdZIobiFsrZcYUfJI1qHAU4Z1hXKfnl03bNLEqKBA8fc?=
 =?us-ascii?Q?pK1UgaGLW4j2dM680uXMFHip+8iRJ+vqIHmKqcKd6hfVX3UyF5W0xEF87cXG?=
 =?us-ascii?Q?8ZJBqs2jTq+FgXSbRGhWPz2h1oMBlXJVPU9aAgMIN0uEVBWI77s9Qnf0UNr2?=
 =?us-ascii?Q?xoTlPaY8PL6uRfPv8n3peogHxKdcfQjtO5gPoB+RW+xcx/dyZknGpQgwXJvu?=
 =?us-ascii?Q?afCtM25uus38CYjKYnXjFz9fm5BFDYjmjHA7jGZS0OxBLPg2zcBy3bzRg0kb?=
 =?us-ascii?Q?4zZZ+ftAB8+yhqrNA0YdMwHtgsEYQWEksx03nIzE/K1mNkrVzDSFiC3ligBj?=
 =?us-ascii?Q?Yg=3D=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d933061a-a6a8-4463-1c78-08de1d56ae9f
X-MS-Exchange-CrossTenant-AuthSource: LV0PR02MB11133.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2025 17:05:26.7741 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gHYzwGdUCNenMgTlEr9QZUVKhgJkTFAJhMseXnpDCu2Pg4rvhIMCxBWHlQPSFOS1oQx0GPYYwgq7JiPTaDDHLJh8Mm4PpFswvVs/H4NpJGw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR02MB8000
X-Authority-Analysis: v=2.4 cv=OvVCCi/t c=1 sm=1 tr=0 ts=690cd558 cx=c_pps
 a=DCeSEX+nBJmE/I7rcEuDsA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=6UeiqGixMTsA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=QyXUC8HyAAAA:8 a=64Cc0HZtAAAA:8
 a=54J7Uyz--kBMsIhK1cEA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA2MDEzNiBTYWx0ZWRfX9dnapbOa5Lt6
 ckHpzVBOOOZr2Z5nmfmITYA8ZK6CpY/MmBiCpXustcl0uDc4B0lAk/Sbqx5W9r9d2XrgATVcJ40
 ISB5CLxjwBrfiEnJuTjlFYFyaVecT8T0LR0sWHW/2GE9Af6xi9oTTd5ujYCCDwEpXfsjETTDbfo
 WwBucgoZ6w7J6PvSJCYdgv8Fs3/jOUuHjBTl01BLqX/b1883szGzFgp7Q/y5S0CgcfZcABiYF+l
 qHhbeaXbdSMYotRCOJH7RvDLfDESamQVFM/XKzJBV0eJ62DMvwQ/Z8Mtfffe4gpIUKtfb4RaIvf
 oPZWZof/eLgwmXtlNLV2xD01h5x7GmiN+/trJe03Yk6clgvqF/G95A1ygCkMleh/mONtcHO3ZHq
 7xKLimMZ7TSLrRzG2Kdxw6SQTQVsrw==
X-Proofpoint-GUID: CUzCb9cgCq0msttE0BjLS1iBxf5D-7Tr
X-Proofpoint-ORIG-GUID: CUzCb9cgCq0msttE0BjLS1iBxf5D-7Tr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-06_03,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68; envelope-from=jon@nutanix.com;
 helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.271,
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

Expose ITS_NO by default, as users using Clearwater Forest and higher
CPU models would not be able to live migrate to lower CPU hosts due to
missing features. In that case, they would not be vulnerable to ITS.

its-no was originally added on [1], but needs to be exposed on the
individual CPU models for the guests to see by default.

Note: Version 1 already exposes ARCH_CAP_BHI_NO, which would already
mark the CPU as invulnerable to ITS (at least in Linux); however,
expose ITS_NO for completeness.

[1] 74978391b2da ("target/i386: Make ITS_NO available to guests")

Cc: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Signed-off-by: Jon Kohler <jon@nutanix.com>
---
 target/i386/cpu.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index a522805233..9b66a19b7b 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -5589,6 +5589,14 @@ static const X86CPUDefinition builtin_x86_defs[] = {
         .model_id = "Intel Xeon Processor (ClearwaterForest)",
         .versions = (X86CPUVersionDefinition[]) {
             { .version = 1 },
+            {
+                .version = 2,
+                .note = "with ITS_NO",
+                .props = (PropValue[]) {
+                    { "its-no", "on" },
+                    { /* end of list */ },
+                }
+            },
             { /* end of list */ },
         },
     },
-- 
2.43.0


