Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C85F0CC6B38
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2026 00:08:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHVTm-0000i6-8Z; Thu, 15 Oct 2026 20:07:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=742cbab99=Alistair.Francis@wdc.com>)
 id 1xHVTh-0000hY-O8
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 20:07:18 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=742cbab99=Alistair.Francis@wdc.com>)
 id 1xHVTf-00078a-3V
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 20:07:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1792109235; x=1823645235;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=xz6to/MjeWuICdyhhoYMM+rqv7jz+da0OnhCfRJWkr0=;
 b=Vm5E7pW04hemuK7pLLhg2qKS8/7hd8IZYqVRggTMraHJWPMg/3figjX3
 A/bku2U8H00STRvD+wNPsCVUGzwndvVZK1WAx138562zFK8jhsgplLqzK
 AWdnBwceF67gBoaYzSH1dsqQSauaJAuwGZR58yKtIhAN/EIjCW212STAN
 OCJDN8Fgi26uEWxbMyekESdAHZLM3w4pU5shJrXoWslgXO4AX8hDG/Eha
 7iKorAEXRpscMspWJL6ohQ+e+2xXLYbx8JFCuygDadUNI9nQPDPzhLMUm
 lDzi4/QdQyO2lbNmnjbc0PSqcUmpfLMopSWnexPvw+/j9J7YPOm2TtFqW Q==;
X-CSE-ConnectionGUID: ArOSeNw6T5qH8YzOaVWG6A==
X-CSE-MsgGUID: Az4SHrEaToay30+lqGLhRg==
X-IronPort-AV: E=Sophos;i="6.27,160,1786982400"; d="scan'208";a="159170537"
Received: from mail-westus2azon11012005.outbound.protection.outlook.com (HELO
 MW6PR02CU001.outbound.protection.outlook.com) ([52.101.48.5])
 by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 16 Oct 2026 08:07:05 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bapzU0nh4nxUdNi1YUxGjE8W7mD/v/K+KQZTZX9EF3BJBYh7FKoOi0Khmwyq4NW31T0MNDpGk/nd65vyGYF5RdbV0y2u6Sky4b9vd72H/Z/C+Iy57w402anyg717LFVtf73wAQMBt7VrJKghn9Px3g/d8zh8s6FY7ninY8YEXMhcKdyYlstTzGrWR8oC7qvcqiyAa16u5ypTybTsyn8aaCwWEJqhjGvdRdsDdGjvzX9+1l1ObIIlUFbrihiel5T6PCfyFXJ7Df4of9ulcSBy07b0x1VeK4GIUt2T7TTfT/OSXLhDZPTLLHMXGcqphRYO+ZjknCMiq4jm8HUDXoj3Hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xz6to/MjeWuICdyhhoYMM+rqv7jz+da0OnhCfRJWkr0=;
 b=qX6zTHgEEpYFMxIBCa02Eywvp7UUxf18EwANyDm/dOj2zg9LroMT2+O7b2bKA/xHqUtHI0HuxpHJkLPf4b2S6jtyDlqhg+8+HVQowycacsP8qEh/T9Z2Y4RfbVEW7+BF/M1QPqhpp2UnxPcmqTi6PUND5IxfYvmGjCKzhewkkiq3R24hKemxXjayDIgJSA0eZpKQdDL4KmgV22kEGduVOtRyDOPrgzoBTYNG95cVixqqPWn6Czx90Vyh/pPqSqWAZXFJ8BU1s4bD81G/SLZkPk1DW4cAQnn7IzpEMNmBHb1o6lQcWazU9n/nHOkfkbHB2q5Kwx6e7xvBPe0ZH2AIfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xz6to/MjeWuICdyhhoYMM+rqv7jz+da0OnhCfRJWkr0=;
 b=TzHocvSdmS7Sp6cCyL1DoqjdYLUZWQ7sRPH5GlP/IVriBs+WZcZ0nA9HA9onmnFygRoTWJMFPsLfqiDiVFTsAgSfHL9mV7z/4/aUlopNWJN9Y4Kw4bLrV8M9LluB2I76wgYAoSRVs1lqVSkOLLpiN+Nkm2awKutzXp27YKa4w+k=
Received: from MN6PR04MB9359.namprd04.prod.outlook.com (2603:10b6:208:4f2::13)
 by BN0PR04MB8078.namprd04.prod.outlook.com (2603:10b6:408:15d::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.14; Fri, 16 Oct
 2026 00:07:04 +0000
Received: from MN6PR04MB9359.namprd04.prod.outlook.com
 ([fe80::e729:bbef:5a37:2e77]) by MN6PR04MB9359.namprd04.prod.outlook.com
 ([fe80::e729:bbef:5a37:2e77%4]) with mapi id 15.21.0522.013; Fri, 16 Oct 2026
 00:06:58 +0000
From: Alistair Francis <Alistair.Francis@wdc.com>
To: "philmd@oss.qualcomm.com" <philmd@oss.qualcomm.com>,
 "pierrick.bouvier@oss.qualcomm.com" <pierrick.bouvier@oss.qualcomm.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "brian.cain@oss.qualcomm.com" <brian.cain@oss.qualcomm.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "daniel.barboza@oss.qualcomm.com" <daniel.barboza@oss.qualcomm.com>,
 "anjo@rev.ng" <anjo@rev.ng>
Subject: Re: [PATCH v3 06/12] target/riscv/cpu: constify cpu parameter for
 riscv_cpu_mxl
Thread-Topic: [PATCH v3 06/12] target/riscv/cpu: constify cpu parameter for
 riscv_cpu_mxl
Thread-Index: AQHdXB/N3kLQBDmY70mWYbWMC+y7/bb+32CAgAABdoCAAAHNgIAAaaGA
Date: Fri, 16 Oct 2026 00:06:58 +0000
Message-ID: <34e5abbf7831c4280caf5e800677a2ea9f69a8e8.camel@wdc.com>
References: <20261014210526.104215-1-pierrick.bouvier@oss.qualcomm.com>
 <20261014210526.104215-7-pierrick.bouvier@oss.qualcomm.com>
 <b99355a2-a424-41b2-978b-8938de06cbda@oss.qualcomm.com>
 <9218a003-b19d-480e-ae11-cf3ed2b9e592@oss.qualcomm.com>
 <56883c4c-dd87-41f2-8e71-1bb8fb65844d@oss.qualcomm.com>
In-Reply-To: <56883c4c-dd87-41f2-8e71-1bb8fb65844d@oss.qualcomm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.62.0 (by Flathub.org) 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN6PR04MB9359:EE_|BN0PR04MB8078:EE_
x-ms-office365-filtering-correlation-id: d06f2990-75dd-4b2f-3fc1-08df2b19657d
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|10070799003|366016|1800799024|19092799006|23010399003|38070700021|56012099006|11063799006|4143699003|261009223027099003|10067099003|18002099003|22082099003;
x-microsoft-antispam-message-info: kl54gtDYRhn2DOJS5vGzsNotuhOGKTLvNdW7WDvIPjK4NpdJAzGvztzlNm5oVCQHmifNkTXBXQ3m6aN+Eu+F35Duo7s/PMCQv/XmKAMQNYSkRaYu7vbzGIlJLaltZrh0hOE7SGdKjXmx0s5jnkdAZ/G9EWWTDCUF/uGx1ExKZ4vwADRcb+L/Cx7GxkW+kpgsLJuina/rJnjWAwIA2ffmTP3NmcNQ/zCUBjHtqgHDiKNd2oal2oPDefYjKuYgwjZHI/bcHTOacV7/xkYnLHqiwKlAhYJKApkg9v1T/1epPJjYq69sQ+xVa4rvLCQkWhaFSBFt0Fy39MM16TqgUKwuNvTrlkw36Hvt4QqlD1/6132S6dhE8absPyxUTRyF2aMUDUdYjty9acX2Lh2kBYNpiUYXOyezBkUT1cu6CZL0GhjuWhhlPRAwrp1DKnP8YUnlF0suZ8BLL36XNtpjZgh6uPTkUQySUYnEK6TNb8uPQY7WpEX0kLUCM3sBRsbV8mgXWxQnk7Vb1DjUx3ZYFiB0u/dtvvXQYyQIa7baZcXsmMhr1y8Lmso8lEneTEhrraFC9xpDXjOMbXY2y0jJnWwuFH2ToCzuX92MBpVyDGixoMmtbHBMZ77F4mcY5yMQAyxxkXKyR+kvtsPqfsYHJqeey+SZPxlvnsmmZMMh0BDKeIA=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN6PR04MB9359.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(10070799003)(366016)(1800799024)(19092799006)(23010399003)(38070700021)(56012099006)(11063799006)(4143699003)(261009223027099003)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?c3hsYThhNUk3VGlTbEl3V09hcE1yYTBGUHhRQVNpOVhwK25hWjIxaGVHTXFk?=
 =?utf-8?B?ck0xdnNpMUVsVVlERS9SYkZFZ3Fndno2OUkzbEdpS0p1UkROcVFvRjVEVktp?=
 =?utf-8?B?Zjl2USszWmwzY29odWxHR2VvczluSzZwMW5YWUlyNldhSWRwS01Ka1lmQ2Zr?=
 =?utf-8?B?RHFGNElwSlJiMC9QYjlOQ2RvU2FqenFsMjZWQk9lcXBhNHR1UGg5ejFOcE9Z?=
 =?utf-8?B?MGU2MmNJV3loeVhFbFA1bmx1MEJTN2V2VURDWHpURlkvSlBPaEpMZU9DQjdz?=
 =?utf-8?B?REVSRk9SeW9kR1FDb2xUeFcwRkpVOE1HVjBYR2FZcmg3VTk5eHNkZlc1dXhN?=
 =?utf-8?B?eVVXRlIxRVozODJiUWxHQ3krb2NYWGlmL1p3Qm52dFJaMG1NcEhSRXpTek15?=
 =?utf-8?B?azZSdGhhcllTRUtVYWR6ck5OblJNc1dWWnV4bVNuZ0h1VlBRRlJQVE1SR0Fu?=
 =?utf-8?B?U2p6RVpHcXplMDV6WHkxWFJITU53N0FSZXNkVGRVUGxOQzcxcENSemkzQzBz?=
 =?utf-8?B?SG5ZZENGUmdNelNFaVNVUklmUjNCTloySlExdGxEZTFQbmgyRGRTRXJSekpy?=
 =?utf-8?B?SDVzTVp4bGFOYUZ5dW92UDdlT0lsMVg5WTkvNk53Q2Y3TGdheDh2dENpcTBF?=
 =?utf-8?B?YmNSYWVkMlNXT0FUdjJGakVpZDFabHFMb3VxQWczemZMdk5sYkZZQnJSMTZ4?=
 =?utf-8?B?TllNWkE3ekFTSnNQOHhjTmFmVW14RU9FcVJZY21raGdtMHVJNUhESUVxK0hB?=
 =?utf-8?B?b2dTTjlsNXk2TjNrRGQ0L3Vqb1g1Q0k2R0VnUlAxTzQyT3ViMTZFcWowc0l3?=
 =?utf-8?B?b3UyNGwxSmxiOCt4bGlmTVBVeUgrb3hnUmVEd2dPbDRncUQ2M2V4bmlVV3Rw?=
 =?utf-8?B?UFFFYVM0bGhUQmdGNWw0SzlXWXBZR0RzY3poeFp0V3pGTjM2U3ljWEdFaVE2?=
 =?utf-8?B?L0lqajZrZHBaQVYxUnhIYnpZbHRIc1prNUUyN3Q2dXpQMTlRNStGR3FwcTlY?=
 =?utf-8?B?TUVXRlQ0ejhHbDIxdm9RajZEU1U3U0d4UVREbFRTY3FDc0VJbW1QbXBJZEl0?=
 =?utf-8?B?V0pEUUNiQ1VwNWNteWtSUVduL3dHeDFoaHBxWmZ4RmNxZlUzeFdtRTU2cGlD?=
 =?utf-8?B?T0ZzZC8rQjl2RmJ2NndGQnZLcGd4WlVJMEk5b1ZlUTUyZWMvVkFhbHFVeUFo?=
 =?utf-8?B?dmVTQWc2a1lWREtkSUdUQUduN3JBY2lnN25EckliSVh4U2QvRkY3M1luNzV5?=
 =?utf-8?B?UEFCU1NIZWNaSVBDTFR1Q2lGTUt3NW9BRVJzQ0trYmRMcnZTTE5sMVUxZEd2?=
 =?utf-8?B?UXMrRCs3QThyOGtGcUV4Ymg3dWgrUjR0UmVMNjdzK1VQUWRpSVFBOGRGaFEr?=
 =?utf-8?B?QjRDTGc1ZDFpKytKUDRQcVQrc0dqTXNnMFFtYk52b1NNWmFqNlBwUjJ5bGw0?=
 =?utf-8?B?a2psUDNTU0Q0MGtQcUpSajIvWElENmpTOGdLWGlWbHkzdzU3Snpoczd1VU9D?=
 =?utf-8?B?R3pveHpxUVkvMnNWOWNxeDYvUk5JNUFCeExMbUpmVDdCVzh2YjZjTVpoOUNj?=
 =?utf-8?B?VnMycUJ0cTB0Ty9WM0ZMVGtCeWtwSjFWL05ObS85TlFaWHJQTFRGOUNuM3dv?=
 =?utf-8?B?UGFNVWpEWlllTDJuZ0xMbTNQaGhBN0xWZ0ZQcHZPTnJhNnlZSGZjU0V1bFZD?=
 =?utf-8?B?RHZxeFRFNFV6Yk1RVllYblVCN0JML0FCTHYzbnFFRWlhMWsyc0ZqTThneHkv?=
 =?utf-8?B?WlRUcHJyc1lZZFRCbTBDTUtESENoRmZEV1NwVmRvaGM1dnhXWm1MR1VlMkpG?=
 =?utf-8?B?eU1xdFJiSmRmQzlYb0swdER0endFTW5BVkcrd29GQXBtdm92MXA0V2ZWWUVK?=
 =?utf-8?B?SWtyNzgyMDFYaTNJb0xwd1IwcFFSQXVjTUJCOENWMU1TVEowYStMQXZxWGdT?=
 =?utf-8?B?M0NCOG9maGMwejVENzdFUlBjZ1JHTDliZjJkYVN2WGtKVFpaZGd6d1Q2ME1w?=
 =?utf-8?B?ZEYyMDJQZUhFV0liMW9ZbnJHZmkvUlFncGFBaGltWnVhZlFadTdGKzhOd3Qz?=
 =?utf-8?B?UGhRU1JsdDBtMG9tZWVpWVFvV2VXVXdCc2VudXN2Q2pRMG5yc1RYWnJRU081?=
 =?utf-8?B?WWVaRFJseTZQWU0xSG1RNm1IRVpIRUZhN2VYcEdyYVJuQ3VVT2NpSms3bDZV?=
 =?utf-8?B?UFJEU1Vxdm96MGJ3NWt4Zkt3dkQ5ZE9jTVFmdWh6R25nYTJRWTBUQ1NIWm9j?=
 =?utf-8?B?ZzhNdy9NS0ZjMXBtY1h0NElpTzJyNWNzK1U1K0ZLNWRCWHBQUnZUaGdlV1px?=
 =?utf-8?B?TXEyT1VvQ29iYTJQSUwzdVZLRGdmOHI3QVAzMTZMeFQ4TTZ1aHNyVjlGK0R4?=
 =?utf-8?Q?JWVP/RnuYTrXVfXKcHExa02MGGLfbNCuO1chCnQjGveoy?=
x-ms-exchange-antispam-messagedata-1: /qLX7GVHLTTU6lEcNm8CaOTx0u6iDAPTeoM=
Content-Type: text/plain; charset="utf-8"
Content-ID: <79E6C379FC6DE94B827B12753694F44C@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: kILI1+BbanOvQeQmg38TBt3rnE9foRYoO8jM6g4BxpxQ2uNgGxsJsPAFsL0dsVJph8iEKT5Av1WLT03y2MlYjSrX2eXgAjfuJ6+aIm/6YK1Rgj/LvVfhCqgrOTG258wMs+THMbM+zdHVWDYrXzTr2HPtn7trNCqZEg6tM0D7WPiRXpaJ5kdjCk10SPFmKVm0aGkHb/16ytRJ3uj1tCaz0ze6qL5VZUhWjGgMisxLfY+eh9hkPmUEKAjgmKBlqU8P6FtGzr42AuroY38BoAwp/2PvrTpANTw3fqkWmMFc3dTIapTAZw3gtr03cnEgkl0Z36JqpSnu1W/NcHU+vtHPMA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: RgAX+pkbo6uinJZVFjrAq0zcEPl7CTuVlwIAxNntyu4bFZXN7mdqny/wFBV/GUWJUZJhj3uJ5zkQ6MpJAwOHtOMc3uoYsybmMLRInUTaLAIehG62euKRhPb/dffx+lK6m9/UA4uGn0G80Ew2FGfpyjGB7B+rS1hroT60MPESfiV96vbsOXf9yNMdSUzkp6ZK4ETB0aLtfm8M69ZU0nA01loHh8vDVgm0A8uXlzMAhO2SaylUXMQTuyxyEjI8/HUBuozoagrzW3snXOCtwSEaACc86TF7T+kL94OgzrXZj0whdTIRvI66LFdtXnsUIJdCs256SAD2LzepquIYSy1gJYr2X0LoQeWWebYQoQkVNQ3+VRYJxlvGaNHNvM80kbHk2MU7rvFGOLiL6ERG/FrSjMZ+4/qyTKw6pQ8zp4qPvkKfZmMdIjY4dvzGv1XonwO3Vi6kYhpphPKq30wFTgb4UeeyL0StrSOFm4hSQ6588uCcqFqk1UgX6SzXGELHe0dLv4Wgsv/17uA0lg6YteRx2vvsqdpRIh23Rx0XR3gBIWdmmwQRZc7sdHN/JIngn+1OnfksaburgorztYcA0exZLBBsiuadGCXueebAgai4NoN/XjjzIDKnAcGU068WtWrq
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN6PR04MB9359.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d06f2990-75dd-4b2f-3fc1-08df2b19657d
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Oct 2026 00:06:58.6491 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aZAhRdMZ2hEN6fQB0CcWw10pnoOvqwVhQLLxWXSntsao8iLAlcHtUQX2iDtqxBpC5SkFbztJZE3IY1+bZy8MXW7jGVtNzlc9KiP8mri7KYE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR04MB8078
Received-SPF: pass client-ip=68.232.143.124;
 envelope-from=prvs=742cbab99=Alistair.Francis@wdc.com;
 helo=esa2.hgst.iphmx.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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

T24gVGh1LCAyMDI2LTEwLTE1IGF0IDE5OjQ4ICswMjAwLCBQaGlsaXBwZSBNYXRoaWV1LURhdWTD
qSB3cm90ZToNCj4gT24gMTUvMTAvMjYgMTk6NDIsIFBpZXJyaWNrIEJvdXZpZXIgd3JvdGU6DQo+
ID4gT24gMTAvMTUvMjAyNiAxMDozNyBBTSwgUGhpbGlwcGUgTWF0aGlldS1EYXVkw6kgd3JvdGU6
DQo+ID4gPiBPbiAxNC8xMC8yNiAyMzowNSwgUGllcnJpY2sgQm91dmllciB3cm90ZToNCj4gPiA+
ID4gU2lnbmVkLW9mZi1ieTogUGllcnJpY2sgQm91dmllcg0KPiA+ID4gPiA8cGllcnJpY2suYm91
dmllckBvc3MucXVhbGNvbW0uY29tPg0KPiA+ID4gPiAtLS0NCj4gPiA+ID4gwqDCoCB0YXJnZXQv
cmlzY3YvY3B1LmggfCAyICstDQo+ID4gPiA+IMKgwqAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0
aW9uKCspLCAxIGRlbGV0aW9uKC0pDQo+ID4gPiA+IA0KPiA+ID4gPiBkaWZmIC0tZ2l0IGEvdGFy
Z2V0L3Jpc2N2L2NwdS5oIGIvdGFyZ2V0L3Jpc2N2L2NwdS5oDQo+ID4gPiA+IGluZGV4IDhjOGZm
ZTk0Y2Q4Li4wMDY1MGE2NmRjYiAxMDA2NDQNCj4gPiA+ID4gLS0tIGEvdGFyZ2V0L3Jpc2N2L2Nw
dS5oDQo+ID4gPiA+ICsrKyBiL3RhcmdldC9yaXNjdi9jcHUuaA0KPiA+ID4gPiBAQCAtNzU1LDcg
Kzc1NSw3IEBAIEZJRUxEKEVYVF9UQl9GTEFHUywgQklHX0VORElBTiwgMzMsIDEpDQo+ID4gPiA+
IMKgwqAgI2lmZGVmIFRBUkdFVF9SSVNDVjMyDQo+ID4gPiA+IMKgwqAgI2RlZmluZSByaXNjdl9j
cHVfbXhsKGVudinCoCAoKHZvaWQpKGVudiksIE1YTF9SVjMyKQ0KPiA+ID4gPiDCoMKgICNlbHNl
DQo+ID4gPiA+IC1zdGF0aWMgaW5saW5lIFJJU0NWTVhMIHJpc2N2X2NwdV9teGwoQ1BVUklTQ1ZT
dGF0ZSAqZW52KQ0KPiA+ID4gPiArc3RhdGljIGlubGluZSBSSVNDVk1YTCByaXNjdl9jcHVfbXhs
KGNvbnN0IENQVVJJU0NWU3RhdGUgKmVudikNCj4gPiA+ID4gwqDCoCB7DQo+ID4gPiA+IMKgwqDC
oMKgwqDCoCByZXR1cm4gZW52LT5taXNhX214bDsNCj4gPiA+ID4gwqDCoCB9DQo+ID4gPiANCj4g
PiA+IFJldmlld2VkIDYgd2Vla3MgYWdvIGFuZCBpbiBBbGlzdGFpciByaXNjdi1uZXh0IHF1ZXVl
IElJUkM6DQo+ID4gPiBodHRwczovL2xvcmUua2VybmVsLm9yZy9xZW11LWRldmVsLzIwMjYwOTAx
MDk1MjI5LjcyMDE4LTE3LQ0KPiA+ID4gcGhpbG1kQG9zcy5xdWFsY29tbS5jb20vDQo+ID4gPiAN
Cj4gPiA+IEFueXdheSwNCj4gPiA+IFJldmlld2VkLWJ5OiBQaGlsaXBwZSBNYXRoaWV1LURhdWTD
qSA8cGhpbG1kQG9zcy5xdWFsY29tbS5jb20+DQo+ID4gPiANCj4gPiANCj4gPiBEaWQgeW91IGZs
dXNoIHRoZSByZXN0LCBvciBpcyBpdCBnb2luZyB0aHJvdWdoIGFsbCBzdWJtYWludGFpbmVycw0K
PiA+IHRyZWVzPw0KPiA+IA0KPiA+IEkgZmVlbCB0aGF0IHN5c3RlbSB3aWRlIHNlcmllcyBsaWtl
IHRoaXMgc2hvdWxkIGJlIHNlbnQgb24gdGhlaXINCj4gPiBvd24gYXQNCj4gPiBvbmNlIHRvIGF2
b2lkIGhhdmluZyBhIHN0YXRlIHNwcmVhZCBhY3Jvc3MgbXVsdGlwbGUgcGVvcGxlIHdpdGgNCj4g
PiBkaWZmZXJlbnQgbGF0ZW5jaWVzLg0KPiANCj4gTm8sIEFsaXN0YWlyIHF1ZXVlZCBwYXRjaGVz
IEknbSBkZXBlbmRpbmcgb24sIGFuZCBJIGNvbnNpZGVyIGENCj4gbWFpbnRhaW5lciBzZW5kaW5n
IHRoZSAicGF0Y2ggcXVldWVkIiBtZXNzYWdlIGEgbG9jayBvbiB0aGUNCj4gcGF0Y2guIEknbSBz
dHVjayB3YWl0aW5nIGZvciBwcmVsaW1pbmFyeSByaXNjdi1yZWxhdGVkIHBhdGNoZXMNCj4gdG8g
Z2V0IG1lcmdlIHRvIHJlZHVjZSBjb25mbGljdCB3aXRoIEFsaXN0YWlyIHRyZWUuIE1lYW53aGls
ZQ0KPiBteSB0cmVlIGdyb3dzIHNvIEknbSBub3Qgc3VyZSBhbnltb3JlIGl0IGlzIGEgZ29vZCBw
cm9jZXNzLA0KPiBtYXliZSBJIHNob3VsZCBoYXZlIHBvc3RlZCBhIFBSIGFuZCBsZXQgQWxpc3Rh
aXIgZGVhbCB3aXRoDQo+IHRoZSByZWJhc2UgY29uZmxpY3RzLiBXZSBzdGlsbCBoYXZlIDEwIGRh
eXMgdW50aWwgdGhlIGZyZWV6ZQ0KPiBzbyBJIGd1ZXNzIHdlIGFyZSBzdGlsbCBpbiB0aW1lLg0K
DQpTb3JyeSwgd2l0aCBhbGwgdGhlIGNvbmZlcmVuY2UgdHJhdmVsIHRoZSBsYXN0IG1vbnRoIEkg
aGF2ZW4ndCBoYWQgYQ0KY2hhbmNlIHRvIGdldCB0aHJvdWdoIHBhdGNoZXMgYW5kIHNlbmQgUFJz
LCBzbyBpdCdzIGJlZW4gYSBiaXQgZGVsYXllZC4NClRoZW4gdGhlcmUgd2FzIGEgY29uZmxpY3Qg
d2l0aCB0aGUgbWVzb24gdGVzdHMgaW4gdGhlIGZpcnN0IFBSLiBBbg0KdXBkYXRlZCBQUiBzaG91
bGQgYmUgc2VudCB0b2RheSBhbmQgaG9wZWZ1bGx5IG1lcmdlZCBzb29uDQoNCkFsaXN0YWlyDQo=

