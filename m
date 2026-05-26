Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33927CD5BD5
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 23:27:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wS1BK-0005CY-05; Tue, 26 May 2026 19:27:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=599a94ef2=Alistair.Francis@wdc.com>)
 id 1wS1BD-0005AC-0i; Tue, 26 May 2026 19:27:23 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=599a94ef2=Alistair.Francis@wdc.com>)
 id 1wS1BA-0004FF-IL; Tue, 26 May 2026 19:27:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1779838041; x=1811374041;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=RJokAoYhvjFCEFJm5qEXS5mJiKEhtnMK9H6L63Kwx2g=;
 b=hcIAfBjuxaZRkpLamoqLr5/gOhN4IljSc/lyz3HaXYPZlcEZjhToq4lW
 nnUxuvtvc7qjFkJiHifieYWY1JRRPsUCX8OG3h4V4trJL49Afz9KQ45Wu
 dnTRL4k2w75RZH6+oF/jQDE3Z6NAfwEie+Yvo9REl0APsUDk90vRlLoF3
 qLXf4cPwnH01bDS5rjPT1AN7SYGGA6qzyiYzgbLMBLr+XwX9moy68QJ+w
 2dm5XCN7OyNWsQyxWzlq+Ob3dDGv4x5vMzirexkPjaRhfw68vFHLkU1db
 3uh3GKK+8d3TszYPzwQGKcQYQjL4EofcBgbKW5gWegszR4khZnjB07mJ4 g==;
X-CSE-ConnectionGUID: Qmh4xvngQIWj5rkkRdGVgg==
X-CSE-MsgGUID: 4JZtLMngSPOHVO+VH/2KbQ==
X-IronPort-AV: E=Sophos;i="6.24,170,1774281600"; d="scan'208";a="143711832"
Received: from mail-westcentralusazon11013066.outbound.protection.outlook.com
 (HELO CY3PR05CU001.outbound.protection.outlook.com) ([40.93.201.66])
 by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 27 May 2026 07:27:16 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fs1cTQa7uYydpsuCN0mfbDSDjUabbrIhvs/S3ALMNXmH7cwkf3/4PEe7dXXx2gP+EVKhGzOASEkr8mnBw/3iD9jea/btsZdxHshrT7omykQb4zZm2Dtw7UWZ49reT9ODwUGh7kMYt0f3jx30v/uXL5m/7UfNbvrmeFOJFPPm2vyekhUBGGSKkcIvPgG7Xz3AakWitVxXWqwf2NH9sb6doxgufFyddJJ+8yysrtPB/C2+bn2GNzIRwzkjRpTul+85D07m/pRx970XISqbshEV8dnyQSZBDmSJT0XpCwW7LeF03fFuZKiMxS0kCG8VlNJ1AtqYiF4GJ2gP2AxMLPyDXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RJokAoYhvjFCEFJm5qEXS5mJiKEhtnMK9H6L63Kwx2g=;
 b=vwIQD4fVOdGXxOLoCw+YuzyYLFjuJaxzU/oucoR7Puai6UenhI+9X/BaQtyZKT6icEKEqTwswdaWq7jleFEtmB1U7uGsAj5T6CZSPn4/xK3gSf30a5GG6mEd5VJMELzpptEdOmf0pcsA24tKrGyPC2dpqcu65nw1YTl5BH2hN4ul51yM89Ahb6qSW51yWDRIbq+AjOiSSrBWxhJEad9Pauk3ACQxtS3WUND9e2TKCcnqt1F+8mIWykSroaxscpCtTuhjopZrXI7IiF/lI7wrPwcTjJ//YthvzG7gK6lAw+HsYbN9L2oyD1rrzaVPpecFCi6tkKOuV0uGdtc6MQY5OQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RJokAoYhvjFCEFJm5qEXS5mJiKEhtnMK9H6L63Kwx2g=;
 b=MJPqXKfBF4r0Jn/oye3kaUslRSKdr03yxRii9U3u9OgJ9t6dL1x1YkNc0XHPtvemYo6wR/aY2IJ3gHcf9ntr/Dta+mEZKGeh4O81TOmYn8H3o42mdFvAxBcncfuald9jmMvMtZ7XEwAqatAeCyAJXnBhesMFe6cc1vnRtB2/LMk=
Received: from CH5PR04MB9550.namprd04.prod.outlook.com (2603:10b6:610:20e::17)
 by MW4PR04MB7346.namprd04.prod.outlook.com (2603:10b6:303:65::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Tue, 26 May
 2026 23:27:13 +0000
Received: from CH5PR04MB9550.namprd04.prod.outlook.com
 ([fe80::2dd5:1dc8:e3e7:5d31]) by CH5PR04MB9550.namprd04.prod.outlook.com
 ([fe80::2dd5:1dc8:e3e7:5d31%4]) with mapi id 15.21.0071.011; Tue, 26 May 2026
 23:27:13 +0000
From: Alistair Francis <Alistair.Francis@wdc.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "philmd@linaro.org"
 <philmd@linaro.org>
CC: "daniel.barboza@oss.qualcomm.com" <daniel.barboza@oss.qualcomm.com>,
 "chao.liu.zevorn@gmail.com" <chao.liu.zevorn@gmail.com>,
 "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>,
 "zhiwei_liu@linux.alibaba.com" <zhiwei_liu@linux.alibaba.com>,
 "palmer@dabbelt.com" <palmer@dabbelt.com>, "anjo@rev.ng" <anjo@rev.ng>,
 "sai.pavan.boddu@amd.com" <sai.pavan.boddu@amd.com>, "liwei1518@gmail.com"
 <liwei1518@gmail.com>, "pierrick.bouvier@oss.qualcomm.com"
 <pierrick.bouvier@oss.qualcomm.com>
Subject: Re: [PATCH 4/4] hw/riscv/virt: Inline TYPE_RISCV_CPU_BASE definition
Thread-Topic: [PATCH 4/4] hw/riscv/virt: Inline TYPE_RISCV_CPU_BASE definition
Thread-Index: AQHc7PYnX1potmbVwUmGXxvdPSPvDrYg9G8A
Date: Tue, 26 May 2026 23:27:13 +0000
Message-ID: <89a6a3cf18de8e64840490a52255d55e4073f30f.camel@wdc.com>
References: <20260526095731.63525-1-philmd@linaro.org>
 <20260526095731.63525-5-philmd@linaro.org>
In-Reply-To: <20260526095731.63525-5-philmd@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.60.1 (by Flathub.org) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH5PR04MB9550:EE_|MW4PR04MB7346:EE_
x-ms-office365-filtering-correlation-id: e680567a-03bf-4a8a-200a-08debb7e514b
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|19092799006|376014|7416014|10070799003|38070700021|4143699003|11063799006|22082099003|3023799007|18002099003|56012099006;
x-microsoft-antispam-message-info: FAOcu8fNMCIrgj1R8knAFyN4zbVYVRbpuuwv+lQ4jvuVzu8e+12qVbzTgu17xP7U5BtTdfWpHdOL8kuinr4H51CdRcolY/Kh2FLetsdRAHkV+7p8C8Q/iqCV1gEm0eS/HwHpkXY3eMGaeqiUyeil58zT5R6GCVxWHECACXHHCQd12EhrXDbPI+WXyofBfgH6s6TMs/kWx0AzAzG7dNigby9hgJIwYMMGw52c23OsBKLTroOhak+3JyRPf3R8KgnHuJEvKTeVmJu/e38tHRPRmuZH+71RFMtGfcgD8OCbSKJKOFp8WtP+19w7Z5AnvU/uoLdkCxdGeQxs8d+CKOReruZibXJkD8SU4x2lR2w2HalfwiH/kxl1xXW60PUQZtgOX7vRtDn+5U/gUyuoL6WnGpzn0MOuaAVjWZAVFH7VpTBi3H95ITSQt3vcTSfVIFpkZIctUQFPMVp/f8ZPjkDEoidMY9tZ4iZMwgW8OfeWCJrPt8bSCz/RpnydUXGUZ8j2lpN4KU45Ds+M4xw9FOb9JmlgsU6TgAulvb7Jhe+xq1K8UtbbWW1pJzK0gC14cVdyjK5S26o2Msm7gKkuEAi/9DxTI8RwDfAoOr969nQ2gwrgN+J0PNfc2xcwu0Czt3AoWifBtE4rzTm7igK9J/IUBRpPY0CLSKZdil1G6DKleE+/+NQcAgvEtxhBodnDwGFA0TFc1OeoHFhSJxHdtPima8tVQ5VjPV/6JsS2mOvJA0D+lSIYP2wC1FPn9HyZWXda
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH5PR04MB9550.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(19092799006)(376014)(7416014)(10070799003)(38070700021)(4143699003)(11063799006)(22082099003)(3023799007)(18002099003)(56012099006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dGdvM0swdVNPTjJnejBtS3JPaE42Rkk4TGhOblB5TWx2TVM0czVGT0w0cHQ0?=
 =?utf-8?B?ZFQrTVRFM3gyZGVSSTV0TDhaS3RpVjJnbW1BRVJxRkwxVEc4M1poMGphL0o5?=
 =?utf-8?B?MEdHUzNBWmYxdHNQRWluVDkzVFBCVzUvWFVQUWxWVExablF6SEFrUXJOREEw?=
 =?utf-8?B?N0wySVYwOCtyeWMrMGZ6ZjZRS0lqKytibXZGRllWdElzTmQ2Y3BmWVNIbytL?=
 =?utf-8?B?NEM5ekt2cHNGU2dqaVhZRmIrVllaSkpTNklIWVhxVmhuUU1hYm5rQkt3SHJS?=
 =?utf-8?B?ZktYdVpCK1pLOVhZc044UHpyODhZSGFYblBjQzUxUHVnZ3NRZTNtdXpvY3Mx?=
 =?utf-8?B?QXRJckJlNFFOWFRwQlp4NkFmYTM3VGVCQzg1QXA4T2QxSzErd2tuVHJCeFlh?=
 =?utf-8?B?ckwvWXVGOGMrTy8ycGxOcm1mMWlrT2l4ZmI3dnpLeEJBOEpYaUxBMTkxSG45?=
 =?utf-8?B?bW15ZkxYYWwyVVE2em1MSDBuNWl0Mm5nRWQ0bnN5am1mNzErUm1YbDVjUllv?=
 =?utf-8?B?YWM4NUJCWlI4TFh2WVorZlI3eDdSeXhXVzRwUlRwNzFlYzN6U20xcWhkNUxY?=
 =?utf-8?B?OUNLVXJESnFvSGkzTTlxK2NJYlRwQ2YyNEpCNlZURys1T0xtNWh3a3NseExj?=
 =?utf-8?B?S3hrQVVFSE1XWm96SFFMSEpxMktqNDVvbzdlYmFSVThNenVPcS9FYU9wZ3Bt?=
 =?utf-8?B?NFB5aWVQNzlza0RlSGN3NWErY25oWmFzSnhUZVFjRUt3TnAyOGtrdVhGVlcz?=
 =?utf-8?B?OTVJNDc2ZUVuNmhNTDlWalRHbFZyUENyMUhqdk96VXBydXFxaGJlQ1BBWGIv?=
 =?utf-8?B?VjZ1c0EyL2RaakdrNnA4ZzFDRVArWWc5ODE3NE05NlQ2WVFJRENFcTRhV0g5?=
 =?utf-8?B?eUVia0dDQjF0aHJlaVB6N01zZnpSMmdnamlVTGdmQ1E4Z1lVL3hjaVNCdHFY?=
 =?utf-8?B?OUlVUW9DblBsbjJjamZybWhHLzJ1WDJ1U0tVeW5vQkk5T2c2Z0VtVDJaQjRT?=
 =?utf-8?B?Mkg0SnM3bm9SWk1EenhCdVdaTGtJc21sUDhGRXB6dXorM1JDaDkxZDcwaldK?=
 =?utf-8?B?dERaOExPSjJIZUw0cUlIaWJTUHJNQ1o2aE9aY2Rianl4amNBUzRXZ1F4eVV6?=
 =?utf-8?B?aXVOVExJNkRPd1R6UVRicGpmUUJ0cXA2UVVrNG5JMUlkVDBFWkliQS9RQjFX?=
 =?utf-8?B?OCt2Q0dZMHk3Y0t5aTEweGUyU3ZVUmE2Mmg5QjBTa3NGTFovYUFHa0IrRkU3?=
 =?utf-8?B?WmtIaGtGU1F2UGdwbXZLYlRLV2xVd3R1M0V0ODgrclQzSmR3SUxsWEtxem9T?=
 =?utf-8?B?VW1zQ3hhelhLZ0FGR3ZFNFVUNS9KM1ZOdVZtLzI1Und2UE1TWmpKcDVSaWJj?=
 =?utf-8?B?b1lPTmpuTjVUTGtaRVdpVU90QWdmMUluVVdyWUVMcUJmMUp2UGJRa0tIRG1J?=
 =?utf-8?B?SWdwcnR2U01tczRuVkFyMm5JZzBXdXdnYU9Pbm82UUZMc3h5Y3ZoWjVJVXR1?=
 =?utf-8?B?UzlZdzRnbS94MWt0R0tzdzdzYTJVdERwMjM4N3NLN3pCbVhVdTJ0S3IyQkJB?=
 =?utf-8?B?QVRCVmkzQlZtVy84UlZzNjRaQWIwdDZPUHhNUmVYZnk3QXVPMW05VTNFS1Qr?=
 =?utf-8?B?RFNmdlAyazlnOWd2RUJOdWNLKzQ2aURpbzRFdFhpa2V5RFlnUDhGOHhxWmdB?=
 =?utf-8?B?dnFzT2lOTk1iTHY0aVBJcVBqY2gxbXQ2OWp5OUVVRytoRGV6T0ZRbm1qdFND?=
 =?utf-8?B?Q0h5Z2RaRmx0UnFTSGN6M0FjaGFFSjNxREljKzJNTzlHQndvZlpkeGxIQURD?=
 =?utf-8?B?YzFnVFBwRkN6SlM0aVI5UzFoWXZCUS9KZnQzTkNjWEd2RmNRbEdGR3gwQ0RS?=
 =?utf-8?B?eFl1VHJEMFMxU2dhTFAyV29GaEN3ZGFYQTNtbjZtV0FqV3EzbGhyVUhETlZ5?=
 =?utf-8?B?Tjczd2hxQU5yTzlSMVFnTzNtaXdzUlEzWFhoYm85ZGYxZSt2eGlKTzYvRHlM?=
 =?utf-8?B?NUNVYWNucGViT2tTdy9mMmtNd1dlZmlsdHhqMTVkOHdqTTAwVk5xK1R2TDlH?=
 =?utf-8?B?TU5sakowdVZBd1VVU1ZTeXlid1FISFcvWXJrcGtFT2o4TU50VkxDd1gweVZj?=
 =?utf-8?B?aXVNWDhnWVNJR3VadG9sRm1UK1N1a1R1T0lWZUhzRDRoVnFLSnhXcjNjQkpm?=
 =?utf-8?B?UkVzdEh2UHgva3RoUFUzNlNNRFVXSnhxaDMxaGt3K1p2Y2ZSM1k1Z3NQSGRa?=
 =?utf-8?B?WXRrUm5jOUZiTDRFb0crUkw2eThiQnJ6dkFta0JyRmpnbU51RU9ad3V1VGhC?=
 =?utf-8?B?cTdDajM3THYvNnkxak9icDZUME45WjhIbE41aGl6ckNYYzhYbEhFUEQxdzdC?=
 =?utf-8?Q?Dnq5ibOXEQ56ZiXbnkZJR/2x0w+dj9NseRPRDO5j8lOfR?=
x-ms-exchange-antispam-messagedata-1: EMaBQ1DtRLJumeNh9A30cHP+w2JmlhfWkck=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DD376425C3F68849ABE9C4F8E36B5926@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: BAOo9n7XV0FD5tBfruMoZt7x5FVzKF/B/rBZzOGesMZcdpTBTW38fiazQLRq5Q3vpZAec1rSvq7Qzujab+c76GmpdL5ZDMsFNAq7VtpQxK7ZWZMFzAJ8p1c2Gh+ppzJt8zcqxsS6JdmtELqn6J5sgGFQA7jfwg4pyzeL7gVWzwD5HCgvfK+cQNwFa8LNi+XywpHxAXe6LdsCiKqNG0+2yC8P8HX1lYwm0TUjeOw45ZKOuwxluXdQ1vdtVtfiA7NNX5/jMI2aGPHr9Z3zMEwrxvvXgaRVFbzUJuD7O4dcoQftiQlfBsdtImtGICnGRPIm72XIRnyR3gMycxVasnhtlw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Pc4WzsqEkY6DGmKqKgtTwncR+LQgwFNgDlNOXMwurQXiwiQbAIPPUh+wtllFq1yPQLJv/0kiC//iEnSIKfRLnf67r1RjyXgmGFsTE4RU9L1ET2K9M8y4s7+PZ8FSScnPqQrWN/yJU8uoxq/S1KXu46p28Ud7FVo8Yj7TfmCorKNnBUyWQZiF0qZoR9NhhKE8tdCXQsJwTWy4rC6VKghRuoLoXxUJYMILhpUGE/fswz7RPhisyIpMOdJmUW7ukQQKhSRtNyDwVNtHqnut9rwUdziHTXCg8UCzecEN74jQrdSR8tvoZDS55a9T5OuWGkCM9xDbMiYJc1OT2nKCdNuVsxNGdVwsJ6k/Ned5R0+pGhMSQttkyJeNnEBKdJPYMANPa91uJJQ2/IYBWt4kciunvUax9DD8GSt1CacfI/0hszgB9d5ztkYTnKEtM/5jYQzuLjBMKVUpKCk0DML7RrDHNhck/QP2w+R9ismoFRmBdEVB0awxeyjOVdha3h9EwW+pVpIopGFRbQfSH/VfJD+w+Aw/ccVvil5SpsgoHUICZ5WX37dd3M8Zwsl0GVnivUTDG9kiF1+XOLHa4tCNqmB5liMzwRYGWeIHLZ26OTGs6CDgg7+DXQ3T0Er3O7AjQLFm
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH5PR04MB9550.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e680567a-03bf-4a8a-200a-08debb7e514b
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 May 2026 23:27:13.7312 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Wl1TPklf8hnQWfzCpWwjruJY9XyfUEnGbfd4CW7RfrFplKvmFAb0TFkIjVwqyQZabU7IdhKr06OSO34iUj5iHNT2qWgQkGctgWvd2Z8gDJU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR04MB7346
Received-SPF: pass client-ip=216.71.154.42;
 envelope-from=prvs=599a94ef2=Alistair.Francis@wdc.com;
 helo=esa4.hgst.iphmx.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001,
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

T24gVHVlLCAyMDI2LTA1LTI2IGF0IDExOjU3ICswMjAwLCBQaGlsaXBwZSBNYXRoaWV1LURhdWTD
qSB3cm90ZToNCj4gVFlQRV9SSVNDVl9DUFVfQkFTRSBpcyBvbmx5IHVzZSBieSB0aGUgJ3ZpcnQn
IG1hY2hpbmUuDQo+IElubGluZSBpdCwgcmVwbGFjaW5nIGEgYnVpbHQgdGltZSBjaGVjayBieSBh
IHJ1bnRpbWUgb25lLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogUGhpbGlwcGUgTWF0aGlldS1EYXVk
w6kgPHBoaWxtZEBsaW5hcm8ub3JnPg0KDQpSZXZpZXdlZC1ieTogQWxpc3RhaXIgRnJhbmNpcyA8
YWxpc3RhaXIuZnJhbmNpc0B3ZGMuY29tPg0KDQpBbGlzdGFpcg0KDQo+IC0tLQ0KPiDCoHRhcmdl
dC9yaXNjdi9jcHUuaCB8IDYgLS0tLS0tDQo+IMKgaHcvcmlzY3YvdmlydC5jwqDCoMKgIHwgNCAr
KystDQo+IMKgMiBmaWxlcyBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKyksIDcgZGVsZXRpb25zKC0p
DQo+IA0KPiBkaWZmIC0tZ2l0IGEvdGFyZ2V0L3Jpc2N2L2NwdS5oIGIvdGFyZ2V0L3Jpc2N2L2Nw
dS5oDQo+IGluZGV4IDdkNzljN2E1YTdlLi4wZDJlY2Q5ZDZiYSAxMDA2NDQNCj4gLS0tIGEvdGFy
Z2V0L3Jpc2N2L2NwdS5oDQo+ICsrKyBiL3RhcmdldC9yaXNjdi9jcHUuaA0KPiBAQCAtMzksMTIg
KzM5LDYgQEAgdHlwZWRlZiBzdHJ1Y3QgQ1BVQXJjaFN0YXRlIENQVVJJU0NWU3RhdGU7DQo+IMKg
DQo+IMKgI2RlZmluZSBDUFVfUkVTT0xWSU5HX1RZUEUgVFlQRV9SSVNDVl9DUFUNCj4gwqANCj4g
LSNpZiBkZWZpbmVkKFRBUkdFVF9SSVNDVjMyKQ0KPiAtIyBkZWZpbmUgVFlQRV9SSVNDVl9DUFVf
QkFTRcKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgVFlQRV9SSVNDVl9DUFVfQkFTRTMyDQo+IC0jZWxp
ZiBkZWZpbmVkKFRBUkdFVF9SSVNDVjY0KQ0KPiAtIyBkZWZpbmUgVFlQRV9SSVNDVl9DUFVfQkFT
RcKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgVFlQRV9SSVNDVl9DUFVfQkFTRTY0DQo+IC0jZW5kaWYN
Cj4gLQ0KPiDCoC8qDQo+IMKgICogYjA6IFdoZXRoZXIgYSBpbnN0cnVjdGlvbiBhbHdheXMgcmFp
c2UgYSBzdG9yZSBBTU8gb3Igbm90Lg0KPiDCoCAqLw0KPiBkaWZmIC0tZ2l0IGEvaHcvcmlzY3Yv
dmlydC5jIGIvaHcvcmlzY3YvdmlydC5jDQo+IGluZGV4IDNkMDZjOWM2MTA0Li44MzcxYjI4YzI3
YSAxMDA2NDQNCj4gLS0tIGEvaHcvcmlzY3YvdmlydC5jDQo+ICsrKyBiL2h3L3Jpc2N2L3ZpcnQu
Yw0KPiBAQCAtMjIsNiArMjIsNyBAQA0KPiDCoCNpbmNsdWRlICJxZW11L3VuaXRzLmgiDQo+IMKg
I2luY2x1ZGUgInFlbXUvZXJyb3ItcmVwb3J0LmgiDQo+IMKgI2luY2x1ZGUgInFlbXUvZ3Vlc3Qt
cmFuZG9tLmgiDQo+ICsjaW5jbHVkZSAicWVtdS90YXJnZXQtaW5mby5oIg0KPiDCoCNpbmNsdWRl
ICJxYXBpL2Vycm9yLmgiDQo+IMKgI2luY2x1ZGUgImh3L2NvcmUvYm9hcmRzLmgiDQo+IMKgI2lu
Y2x1ZGUgImh3L2NvcmUvbG9hZGVyLmgiDQo+IEBAIC0xOTMyLDcgKzE5MzMsOCBAQCBzdGF0aWMg
dm9pZCB2aXJ0X21hY2hpbmVfY2xhc3NfaW5pdChPYmplY3RDbGFzcw0KPiAqb2MsIGNvbnN0IHZv
aWQgKmRhdGEpDQo+IMKgwqDCoMKgIG1jLT5kZXNjID0gIlJJU0MtViBWaXJ0SU8gYm9hcmQiOw0K
PiDCoMKgwqDCoCBtYy0+aW5pdCA9IHZpcnRfbWFjaGluZV9pbml0Ow0KPiDCoMKgwqDCoCBtYy0+
bWF4X2NwdXMgPSBWSVJUX0NQVVNfTUFYOw0KPiAtwqDCoMKgIG1jLT5kZWZhdWx0X2NwdV90eXBl
ID0gVFlQRV9SSVNDVl9DUFVfQkFTRTsNCj4gK8KgwqDCoCBtYy0+ZGVmYXVsdF9jcHVfdHlwZSA9
IHRhcmdldF9yaXNjdjY0KCkgPyBUWVBFX1JJU0NWX0NQVV9CQVNFNjQNCj4gK8KgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIDogVFlQRV9SSVNDVl9DUFVfQkFTRTMyOw0KPiDCoMKgwqDCoCBt
Yy0+YmxvY2tfZGVmYXVsdF90eXBlID0gSUZfVklSVElPOw0KPiDCoMKgwqDCoCBtYy0+bm9fY2Ry
b20gPSAxOw0KPiDCoMKgwqDCoCBtYy0+cGNpX2FsbG93XzBfYWRkcmVzcyA9IHRydWU7DQo=

