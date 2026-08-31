Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE9C6C61DE2
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2026 01:09:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x0qWW-0006Vy-UC; Sun, 30 Aug 2026 21:09:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=696fae14a=Alistair.Francis@wdc.com>)
 id 1x0qWS-0006V2-3x; Sun, 30 Aug 2026 21:09:16 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=696fae14a=Alistair.Francis@wdc.com>)
 id 1x0qWQ-0007KL-64; Sun, 30 Aug 2026 21:09:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1788138554; x=1819674554;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=iQl+69OeOADJ5WdARguu/BlAfrbmCgI/ApnPOkU9YTg=;
 b=noBjgD3qzaV9shuhkMdl5+Vai0zaje7FUucBo7h6O47sqW1DLSAtC3ui
 8fS8lD9R0I3JlzsPJrkR+0Axus39Fa69Rh71LnYlyKREglBHmvtlevAkj
 pflcc3bFkIQq43sXhDGfC3I4AtshAnZRmp891LS+vHnzT381UIN99ezqO
 m5CX5/dMozEKvkLM24rNpcwLcLcU0sZu3Cd8rs8Jw0GNKQ+vRI46Y834v
 9GKxCa8fjsbvH8y4flqFxyssjEBzdR7WAPaxdqsAZZKe/1/6urJEYK3n/
 IOD2Fm+bOKW3T9dkFeOEbHA8RTFZ961+4wryFqAgdphHawvAZtJICIPNt w==;
X-CSE-ConnectionGUID: drzTonVdTGm/HMDIkcVI6A==
X-CSE-MsgGUID: xt/2vLX8TWeqQaBYcv9c4Q==
X-IronPort-AV: E=Sophos;i="6.25,252,1779120000"; d="scan'208";a="154585958"
Received: from mail-westus3azon11012065.outbound.protection.outlook.com (HELO
 PH8PR06CU001.outbound.protection.outlook.com) ([40.107.209.65])
 by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 31 Aug 2026 09:09:11 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZFYBEKZ+2Iykil10pXVwVzxhSMVCTbxPuFFeQpTMZNK3gdhSYYBovrPV5nOta5lNUce6q044NI9V3a5/Lgv+3gxv84x4RCG5eObND2A6wEdPPYlG0ngZQmaGZKNtQk0DObbqdAmr7ADkFOiIdpK9DG5egGlwBD20xQqugtwfWpcHdHj2N8fe5F5yZ9Bisyr5GshnDNHrnFcg5nH7XbUGU+uPclptExFg7IrBgRxe80Rralvmdx13EKWJXt65O0klOlv+zXeCnfxqm7i1MUowpgKDfgMe+C+WVLAq7UR/4e6WBUq3GKfRssI4K7+4WEWDbo9TVtBrlL90ll9LANDjAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iQl+69OeOADJ5WdARguu/BlAfrbmCgI/ApnPOkU9YTg=;
 b=MtimnhrVGpNoL1PP7CjQ+BVHWIpyo58VvOwPwPO7h31wohospkqiIDZeWe2QJa3HIrFCAsvMlxnXG3zvzqEIv3TklnHFxcoLxS8flr6hrlEK2YcBMmUN/mmMYPeVEGqAuXPFy1TwGhLPR/SeYsVXy9Q7Hm2f+5coVbXlPX17g+F7FehUaGHwpzyc70u0c7p5nOqpAbjebJtXlN5mk6Tw7y1e1eqLsjIjGRfNfygOFF7imLY/53b1fbfOPTxgZTKjXpFoNYYmGrR6QW92D2ERzsU16JQ+YjVDG7pbZeBYjuBOJjCzo/MYBeWMFWGz0MLrWFNonPwxdf/LVmGuNsn54A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iQl+69OeOADJ5WdARguu/BlAfrbmCgI/ApnPOkU9YTg=;
 b=psEL4prrAP0zxIDYQq37MYN68xcwSyuPfaL53Io2E5J1qH9AP10gufyfV2iAahLjDuhedcWQY2LZXAuCZGyaNaP2jsohdjCsazsAEgv9LtYQdf6kZBcPJY/pXlAn882SRqJRs7IzQ2OsYLF3QpvZDEutiTiqrqEQxEjcOcqxVQ8=
Received: from BY1PR04MB9561.namprd04.prod.outlook.com (2603:10b6:a03:5b6::11)
 by LV2PR04MB993975.namprd04.prod.outlook.com (2603:10b6:408:36c::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 01:09:09 +0000
Received: from BY1PR04MB9561.namprd04.prod.outlook.com
 ([fe80::3869:e494:2fa8:9888]) by BY1PR04MB9561.namprd04.prod.outlook.com
 ([fe80::3869:e494:2fa8:9888%5]) with mapi id 15.21.0360.008; Mon, 31 Aug 2026
 01:09:09 +0000
From: Alistair Francis <Alistair.Francis@wdc.com>
To: "alex.bennee@linaro.org" <alex.bennee@linaro.org>,
 "daniel.barboza@oss.qualcomm.com" <daniel.barboza@oss.qualcomm.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>, "joel@jms.id.au"
 <joel@jms.id.au>
CC: "npiggin@gmail.com" <npiggin@gmail.com>, "mpe@kernel.org"
 <mpe@kernel.org>, "portias@oss.tenstorrent.com"
 <portias@oss.tenstorrent.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "chao.liu@processmission.com" <chao.liu@processmission.com>,
 "asrinivasan@oss.tenstorrent.com" <asrinivasan@oss.tenstorrent.com>,
 "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>,
 "zhiwei_liu@linux.alibaba.com" <zhiwei_liu@linux.alibaba.com>,
 "liwei1518@gmail.com" <liwei1518@gmail.com>
Subject: Re: [PATCH 02/12] tests/tcg/riscv64: Clean up semicall.h inline asm
Thread-Topic: [PATCH 02/12] tests/tcg/riscv64: Clean up semicall.h inline asm
Thread-Index: AQHdNeJjMsIVgqn6mU+WUtv7g3i0t7a3XuKA
Date: Mon, 31 Aug 2026 01:09:09 +0000
Message-ID: <43a83d68a4d7bd8e6bde568e4d35a060c0b11a37.camel@wdc.com>
References: <20260827050953.67184-1-joel@jms.id.au>
 <20260827050953.67184-3-joel@jms.id.au>
In-Reply-To: <20260827050953.67184-3-joel@jms.id.au>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.60.2 (by Flathub.org) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY1PR04MB9561:EE_|LV2PR04MB993975:EE_
x-ms-office365-filtering-correlation-id: 8c8c5c50-cedc-46ae-cec1-08df06fc7667
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|19092799006|1800799024|23010399003|10070799003|376014|7416014|10067099003|3023799007|11063799006|56012099006|4143699003|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info: NyP6fzicH6lJtTOsrOudsJYPDldk+1yaXAhjE17z85aCNvJk0+VQ/pMj531yrToA3hjY0TTds3gTgDV99rOnZ5uI1/qiMC5SoPD4B3K7fmRXoOKxB8/JdJQC6IoZ5z64sGbzUr5UZdyKn36l1sXvnKhbYmXC2zHLjB4IW/+/V0ZoTKEfr8JDL1CzQPUsXVWLcJgwX3MUecPu0xcmPC5WlEBMXzxHULwc14SLkFEkc/MoJtJagR2n4kNqI2UMxxgJqxH9+c1BFsyzoXQD7xiUalT2HAY7fP+7zX3EfOQTrJm6N/JSExnSzyuk1vXDFS0YnAwJ2LNmwufaYQ5NCCgl/PFtXH28cTbZ/HF2m8W7+4LCeWd3YCQRirbT1p359y5Ie+b1Iph1GC2exF3a75qHZqxogp+5NLLQ7Ym4P3n7p2i1KZCNVwaZ9lOYNKuK13EUPu3mkK+IPZtJYv+sXuA5tyN+Rt5f40MltXfFTN2vr9LVHSDrxUmwNpvla9ca1O7XuZmvTcsLSCHTwgACajFqqQchrFpBpm+8L3UUVSOEdc00pr3CanbhpmdqdOFu2hxGZrWblWiqlKIVOT1T3CUw+BO6lNN0X0regJWwEcu3pob5lucjNGdUYGZED5zj3hBy3iwSQO8bj0OUBVHXHaP2nhli2tgX0MNjLo0DqOXtQ0obPpS5fMmI9ieiRdm8M3TpTuadp/OPUc42uPgrzV3280B9kNY7mu0XBA0zp/m6iuE=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY1PR04MB9561.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(19092799006)(1800799024)(23010399003)(10070799003)(376014)(7416014)(10067099003)(3023799007)(11063799006)(56012099006)(4143699003)(18002099003)(22082099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VWJRaHl6bDdwTnE0SU1zdFRTNitoM0xIeHA4Y2lVWVdmU21RZ25MOTR6Z2ll?=
 =?utf-8?B?NzV4SXAwMDN2TjdRaFU0YWt3OTJTdUNEdFZyN1IyWHBBSUFJUXVBWlArL1ZK?=
 =?utf-8?B?Tkh2bGY5Q2N3UnNVeUVHYmc2SHViTDIvRWQrWGlvMU1JaGpzWkxoVk5BcFpY?=
 =?utf-8?B?NTBIVjlrR1g2Ulg0Sld2M29UM3VsaUdEOEVOUFlheHJXazlyd2t3S2c5VXBY?=
 =?utf-8?B?SWtKVmpPbWdqN3RuUjRaQkMxVFRpZHhGVEc4ck5UbEZuQWZIa3RLckUwT1RY?=
 =?utf-8?B?Mk05VE5WYUw0ODRWbWZOZGg5ZGhqejZhbndYVWwvSVdGUkRVcnpiWWdRSE5s?=
 =?utf-8?B?K2JGTTBDcGV4YzBucGhtZ2dpV25idFlnMUVSZDVVZVdOUUp2aDJEdERENlJY?=
 =?utf-8?B?bmFOYnQ3TjJPSGY4YUxyb25DTUg2NTNBM21oQTBDYWJKUGxaVlBjYmd3YUVh?=
 =?utf-8?B?bG9qcVZJQjVpWkZNcFlaZlVjdC9pWHlud0JCMzdOV0JqWG13bjRTT01tY29h?=
 =?utf-8?B?TWVZcndGT2dGeHZ1YnlTczZzTFNYMlVIN29FMEV4V0pzS3RVcGw4N2kvalow?=
 =?utf-8?B?UjhHLzY1aEY5NDN3ZFhHT2NreUxySlMwc1FlU0ljSG9UR3k2VmtEdmJReUo2?=
 =?utf-8?B?bCt2ZTIwVjZWd21haFMrcXJUSGtIMUs5ZWQ1cHd3Ym5hOTFlYnZXaTg4bHEz?=
 =?utf-8?B?TnpmSHlJVm1LWjBpeE9iRWFkbzRwYUR5MjRTcHQyVTIreTB4Nnk2NWlCVWdj?=
 =?utf-8?B?RUV6VzdzMXpHeERrQmErK0hRWUhaMCtHR296aHU3Y1BkMktVVG1IbXI3U0xL?=
 =?utf-8?B?cHNycHlwRCthOUpXOS9hM1phVll5NzU3UDhoS0JwR3RQUjY5Mk5iM3lWdERn?=
 =?utf-8?B?bnpHM0d6YW1XL295Ynk4QWpDd2IyRVdYbXNTU2JwRENNeStTMUdiK1RMYzl4?=
 =?utf-8?B?cnlldXZWa1hkeWpsemFpWEdUVnMyb2REOHhuVGkyTytIMHZXV1BVSWRsYTVQ?=
 =?utf-8?B?My9odFp6dzhRYTZwSDJ3U0pwYkRnOVNjaWVqWjNYMlU4ZmR4ejJ2czAyeHVF?=
 =?utf-8?B?cmNlTk9tdHM5VUZkTWh5cXd3U211SUVoaEtUSDM1a2FSODUzbWVWLzMzOWNo?=
 =?utf-8?B?STgxZ2pEbmg5M25QRWx5V0lLbFo4dUU5RnNKWnl5UE13RTBnZ2toYlhYWUxQ?=
 =?utf-8?B?Y0hYbEdFV29BOEtQZkRITXBHSWJPWDk2dGV0ZWtrNHYyYzN2N3RET1pxQldU?=
 =?utf-8?B?dWIrbFJWOUljUlYrSkxxbnN5RnJyMStWUnVldGJEVDNLWTFaQjhnSnJtNm5K?=
 =?utf-8?B?cmdJeWxIYTBKSGt3TnE5ajA2SDFWQW1xU3pQdk82eERrSk04dEVWbnpxQmJX?=
 =?utf-8?B?U3kxSU1EV0JkVXUrRVBwT2gvMStQT0F4TkVCWjN5c0FadGJsRnlnTUdkSTh0?=
 =?utf-8?B?VkdJNnRMQTNiTmxGQnFwWXVydlRReWtOUC9uRWpseDE2YURNZ2NweHJhVzhK?=
 =?utf-8?B?VzJNMzlrTTdYck5Ebm13SnRoNm8rV0JGYVRpWjVOcitHcXhsQ2pEZjA4R2hY?=
 =?utf-8?B?WWZlSlgzR0JSMkd2YTFJNERJZ3Z4RytwSlhRMDVTZWN0Y2tTNlFvblJTK2Z1?=
 =?utf-8?B?V29UeEN2Y1hJdE1wVHBsT3k0MkRlVlpWa3dHZEpJSUFmbzA3bkk4Y2cxYWZR?=
 =?utf-8?B?by9yWDFYWUdBdlRjVjFFS25Lbm4yZ0dDUmtJSGZJSllhaEhOeHREMVNRS0Ro?=
 =?utf-8?B?ZE1DbFhkYUo5SHh2QUhrd1JRdjMxaUxtNjJCbUVNSXBUeWVkMkMxam1GSHpV?=
 =?utf-8?B?Ym5nUXpLWlM4cWNIUk9WUSt5S1N3ZkdEcjlFc2x5ZTYwSkh1SHUvcUNNZE8z?=
 =?utf-8?B?OC9UUXZXa3BrWnhCTkVLWFc2WWQ1T3JkeVJ6TFZvaGlCSHFLVUVvUWkyV09H?=
 =?utf-8?B?YnpIT0dnZG1jSmRsR1ZtZjY4KzlwTkQzaDE5azUyZmFJRnEzcjNCbTZCVXpZ?=
 =?utf-8?B?bEZFbTVIZldJd1VDdUJmZ1hITkZ0NWx4VHZNbnN3QUdVVy8zdGJzWUR1TUxB?=
 =?utf-8?B?OVE4RlU0R0gvN1BMZTE1aEdTMldkN3NRUDl2RWdzR0tCSDhiV0F1amN4djZ3?=
 =?utf-8?B?cWlMRzkwRExWa1NXL3ZNbXQ5SU9INTlXbjlXWjlFaE9yd2VRZTZ3Zk9UNDM2?=
 =?utf-8?B?bXFQT2RPVm4zMlFNK09Ed0w4VVNRMzI5R1dCYTBTTldQTHVEQXVmekM0TmJK?=
 =?utf-8?B?djhkcklleTduUWluSTRLMGRQaGxCdktEMVdsRmxhQi8zbTdRRS9Dd0Q5dzhm?=
 =?utf-8?B?WWhLa2lGMkN4VHdLSitIMW51TnFzbGNLVHBQL0VETVJ3YzM4TEovQUJpRVRX?=
 =?utf-8?Q?fNYYHAMMendgRqJhNWcxIsTNUlUceISxEaBLjwbPVghFg?=
x-ms-exchange-antispam-messagedata-1: inYbLzBe09s4CmnEsAYuart46rrEcl6IYM4=
Content-Type: text/plain; charset="utf-8"
Content-ID: <39FFB886D470F34E921C517825B900BC@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: xD4/wTzvrL6MhC5aH9Q30tkmZKntV1qOORXSeEPnPC2UsKbbyo80RFywPct6sg7TZ1xLcDlWHPH7Vf88dPF+Z2d3+xaFoDTr9Rdp/VUxzyHXi7cO9CJQdWwm3WEPoPFXturkVDbuV0yy429RIuG/BZoJp1gM4c62Jg0yd60czIgEjhoLgEn2oeJn6cepQarXwXVK2U9wmD9g5AXDyAuzjVpML5q6sdn/CHBEC72NKxDNRMgI/+53uEUm2CxEkPndaIvmzj/j1swjrKoB2LIwjdgJNrWwJaLMekyo2ao7n6U2rd4yRYTxStMtyfwuMBZLb+62cCv4itPFLZXGvtLlAw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: yrk/qLGOCNJJXAmRgz5d2FPPAUV8BB0uD3pZZQDxQuNh9D4PspLrI4rU3ztys3GtKACT1Lb0chNtooIVuwqU+vsM7yV5eoHjEpF1Y3Rmv4ozHKidOYuMz/m9QHmL76T98hrUKqJPkSmCAf4UMBNS2VBS5lkPbCBH7gR3i/eoev4AMNpmqoEyREbVOfNBs2BClK9NtAwibReEi3MLdt4rWrLRbJMQmJ4YPf31CAYKkqaVx5eSymCZ0cXkRj2h/6il1k4gZVCBsa0jdqta7mXPXnAzBgEPfOjvSez/HmyDS9cl9MpXm6NhcW7lxY+DIqGemwXNBu00hWqD9ZuHtXKe0THDwNdacvTHuPzTvT0IK25rWmlaLrxbTqRlkftJSyme+AfLz36tqlKIg4pjiuvacGu8y2ySKdhB5Cey4YqPTEU6A3OGhJUaxmSg6tD9Hd8zNL/8U0Dk1L8x++HnDu1nuhnTknxa5T6+j3cTsVhnUGJz/c8cFyy3E4x+RZpGwSAsPDGu4/oycCHxPBUXKEG1cUcE+y85uzyKi8pp1GcPacKDd0qT+DelCG4PDbx43p07PYDaUv3mk3mVi7G5X4B7Bjta9C6WoppcP3IZ7ekqGbb9sXNq8wv8payvVJx431Gs
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY1PR04MB9561.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c8c5c50-cedc-46ae-cec1-08df06fc7667
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Aug 2026 01:09:09.7723 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GZTU+sSnLSwI2SsSm5LAUybOrUOqQ4SBQ7ojz/7ENAX+8Q1afwsJnreXX020sv/ahLOm0bBbVdseylZi4QnN+DHox9aLQXJ8iZchalw3UBc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR04MB993975
Received-SPF: pass client-ip=216.71.153.141;
 envelope-from=prvs=696fae14a=Alistair.Francis@wdc.com;
 helo=esa3.hgst.iphmx.com
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

T24gVGh1LCAyMDI2LTA4LTI3IGF0IDE0OjM5ICswOTMwLCBKb2VsIFN0YW5sZXkgd3JvdGU6DQo+
IE1ha2UgX19zZW1pX2NhbGwgc3RhdGljIGlubGluZSBzbyBzZW1pY2FsbC5oIGNhbiBiZSBpbmNs
dWRlZCBtb3JlDQo+IHRoYW4gb25jZSBpbiBhIHByb2dyYW0uDQo+IA0KPiBVc2UgLm9wdGlvbiBw
dXNoL3BvcCByYXRoZXIgdGhhbiBsZWF2aW5nIG5vcnZjIHNldCBmb3IgdGhlIHJlc3Qgb2YNCj4g
dGhlIGZpbGUuDQo+IA0KPiBTZXQgdGhlIGNvbnN0cmFpbnRzIGZvciB0aGUgYXNtIGJsb2NrLg0K
PiANCj4gU2lnbmVkLW9mZi1ieTogSm9lbCBTdGFubGV5IDxqb2VsQGptcy5pZC5hdT4NCg0KUmV2
aWV3ZWQtYnk6IEFsaXN0YWlyIEZyYW5jaXMgPGFsaXN0YWlyLmZyYW5jaXNAd2RjLmNvbT4NCg0K
QWxpc3RhaXINCg0KPiAtLS0NCj4gwqB0ZXN0cy90Y2cvcmlzY3Y2NC9zZW1pY2FsbC5oIHwgMTEg
KysrKysrKy0tLS0NCj4gwqAxIGZpbGUgY2hhbmdlZCwgNyBpbnNlcnRpb25zKCspLCA0IGRlbGV0
aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL3Rlc3RzL3RjZy9yaXNjdjY0L3NlbWljYWxsLmgN
Cj4gYi90ZXN0cy90Y2cvcmlzY3Y2NC9zZW1pY2FsbC5oDQo+IGluZGV4IDJmZGQzMjJhZjkxZi4u
MzRlODczMzJkZTQ0IDEwMDY0NA0KPiAtLS0gYS90ZXN0cy90Y2cvcmlzY3Y2NC9zZW1pY2FsbC5o
DQo+ICsrKyBiL3Rlc3RzL3RjZy9yaXNjdjY0L3NlbWljYWxsLmgNCj4gQEAgLTgsMTYgKzgsMTkg
QEANCj4gwqAgKi8NCj4gwqAjaW5jbHVkZSA8c3RkaW50Lmg+DQo+IMKgDQo+IC11aW50cHRyX3Qg
X19zZW1pX2NhbGwodWludHB0cl90IHR5cGUsIHVpbnRwdHJfdCBhcmcwKQ0KPiArc3RhdGljIGlu
bGluZSB1aW50cHRyX3QgX19zZW1pX2NhbGwodWludHB0cl90IHR5cGUsIHVpbnRwdHJfdCBhcmcw
KQ0KPiDCoHsNCj4gwqDCoMKgwqAgcmVnaXN0ZXIgdWludHB0cl90IHQgYXNtKCJhMCIpID0gdHlw
ZTsNCj4gwqDCoMKgwqAgcmVnaXN0ZXIgdWludHB0cl90IGEwIGFzbSgiYTEiKSA9IGFyZzA7DQo+
IC3CoMKgwqAgYXNtKCIub3B0aW9uIG5vcnZjXG5cdCINCj4gK8KgwqDCoCBhc20oIi5vcHRpb24g
cHVzaFxuXHQiDQo+ICvCoMKgwqDCoMKgwqDCoCAiLm9wdGlvbiBub3J2Y1xuXHQiDQo+IMKgwqDC
oMKgwqDCoMKgwqAgIi5iYWxpZ24gMTZcblx0Ig0KPiDCoMKgwqDCoMKgwqDCoMKgICJzbGxpIHpl
cm8sIHplcm8sIDB4MWZcblx0Ig0KPiDCoMKgwqDCoMKgwqDCoMKgICJlYnJlYWtcblx0Ig0KPiDC
oMKgwqDCoMKgwqDCoMKgICJzcmFpIHplcm8sIHplcm8sIDB4N1xuXHQiDQo+IC3CoMKgwqDCoMKg
wqDCoCA6ICI9ciIgKHQpDQo+IC3CoMKgwqDCoMKgwqDCoCA6ICJyIiAodCksICJyIiAoYTApKTsN
Cj4gK8KgwqDCoMKgwqDCoMKgICIub3B0aW9uIHBvcFxuXHQiDQo+ICvCoMKgwqDCoMKgwqDCoCA6
ICIrciIgKHQpwqDCoMKgwqDCoMKgwqDCoMKgIC8qIE91dHB1dDogcmVhZCBhcyBpbnB1dCwgd3Jp
dHRlbiBhcw0KPiByZXR1cm4gdmFsdWUgKi8NCj4gK8KgwqDCoMKgwqDCoMKgIDogInIiIChhMCnC
oMKgwqDCoMKgwqDCoMKgwqAgLyogSW5wdXQ6IGFyZzAgKi8NCj4gK8KgwqDCoMKgwqDCoMKgIDog
Im1lbW9yeSIpO8KgwqDCoMKgwqDCoMKgIC8qIENsb2JiZXI6IG1heSBtb2RpZnkgbWVtb3J5LCBk
ZXBlbmRpbmcNCj4gb24gdHlwZSAqLw0KPiDCoMKgwqDCoCByZXR1cm4gdDsNCj4gwqB9DQo=

