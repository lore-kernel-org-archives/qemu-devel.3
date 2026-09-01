Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F272DC61DD6
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2026 05:29:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1H3R-0004fk-14; Tue, 01 Sep 2026 01:29:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=6977d653a=Alistair.Francis@wdc.com>)
 id 1x1H3P-0004e7-5d; Tue, 01 Sep 2026 01:29:03 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=6977d653a=Alistair.Francis@wdc.com>)
 id 1x1H3N-00070F-4b; Tue, 01 Sep 2026 01:29:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1788240541; x=1819776541;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=Finvc1jW/NXpTxEyRP//VDF1c5U489vkS53K8ps8WuA=;
 b=qSDyEiKcdg8Paxyf8/B2nqwJXXgBm3QxPrp5vz8vjd0sAaKbbp0Onn7J
 rZsNIvjLs/Icxf5fcJSe6hWdJApa5yg2/c7sc6OrwuGwjGeFKXGB75Rv+
 olHHNDv9WK/Z7pvLCyIiqiPym4D5BCcfO5ChLttV/FqM7vlatl3TJWoZl
 seBtLL/+mw6iDEQ3Nq4uU7VqQ6vgcmvFVP591YaCCMejBv/w88X6UH+02
 NI5jknVwEQcdag/s5Vkz8indoCm41T/c/zsdwpkzCVgF0nH6ypIZZoDYt
 86Z7ablLPlBdbMS12/wvJGlRFaZYQjVe1yftzf9+mMYDA0LxvMPyvWRpd Q==;
X-CSE-ConnectionGUID: 23fylebITpih0dUdC8Sjog==
X-CSE-MsgGUID: ztWsPkVhRJW4xyZ1e/JmbA==
X-IronPort-AV: E=Sophos;i="6.25,255,1779120000"; d="scan'208";a="150471927"
Received: from mail-eastusazon11011049.outbound.protection.outlook.com (HELO
 BL2PR02CU003.outbound.protection.outlook.com) ([52.101.52.49])
 by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 01 Sep 2026 13:28:58 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MboJ3hmAcyz/jPJE/rjGU1OvLi9IrCNOjikbQ9dsEEnF+WxklqxFd5BFptArN2ppUObmZ5l1DKP07UfR/lGQ09KI/rp+sK9z54pfb+JoiKkU6EQQxAVfFkpt5798mxMgOT+G4WSVKhAmNVcKCoZsT/lS4VXmPe4NmeSurFKmgiVHemYi0QwGhSfkcmWvIO/8W0pM7ZpeqMJfd+lkG6Z++iYbJGMdpuJN2kl4bWl2L3u/HN80/ywo0nUs6hYSmdLNRPPHLnCPZN/JsPJqkxKFw+2TArUFS1P2oSLckDdL9kxN6/O6vhvYbs+9O2oovLH61DXebhedArC+1dyM8sTEMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Finvc1jW/NXpTxEyRP//VDF1c5U489vkS53K8ps8WuA=;
 b=rJMSzB5+WuY48JCgKHzc811oYgVpbSpAyJmwa+ifWqlR401+KuYho41MnC4v3Y1++XtmOKwPoWCi9dPgcxXj6sN/JvEhk+NY7zrobEWhF/0jkHtz1pHg9C1gBar8yksPYlIdA50GFoYb8AfobPeKSLaFuYFUY2Oa1SisW+OJ0VcDW/zqRvYo8w9Xwirk9yaOL6BknwBpF0ZENb8tnfEjGKlyYunZJ2wtyoukPIRTTiRaVBuluoL501J28XDR+p+pDELWqL90HiVTLT3e+9XcQ9paFkD4BBWMLmJ/uyPSP3htzQ3CoaxetI51uQpK/aH6EBbsBqTY1UxRiQFJ5BPhgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Finvc1jW/NXpTxEyRP//VDF1c5U489vkS53K8ps8WuA=;
 b=PL8AwM6ZrcqQdnzx9s6n9dSPqQbkJo6mQ+rKG1tzlMXrOr20ekZnG9gBKuEqkT2b+iU8aTLaSKFdn0wZHylF/efc12Zz5jPK8nBlc6Vx3jzSXE58qeaesS8LDz0inBYNRxyoy2K1HHonA/Hjt/NsJIgGx0GqVQnJ3zAg7+enjHw=
Received: from BY1PR04MB9561.namprd04.prod.outlook.com (2603:10b6:a03:5b6::11)
 by PH0PR04MB7302.namprd04.prod.outlook.com (2603:10b6:510:1d::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Tue, 1 Sep
 2026 05:28:56 +0000
Received: from BY1PR04MB9561.namprd04.prod.outlook.com
 ([fe80::3869:e494:2fa8:9888]) by BY1PR04MB9561.namprd04.prod.outlook.com
 ([fe80::3869:e494:2fa8:9888%5]) with mapi id 15.21.0382.007; Tue, 1 Sep 2026
 05:28:56 +0000
From: Alistair Francis <Alistair.Francis@wdc.com>
To: "daniel.barboza@oss.qualcomm.com" <daniel.barboza@oss.qualcomm.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "philmd@oss.qualcomm.com" <philmd@oss.qualcomm.com>,
 "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "palmer@dabbelt.com"
 <palmer@dabbelt.com>, "chao.liu@processmission.com"
 <chao.liu@processmission.com>, "liwei1518@gmail.com" <liwei1518@gmail.com>,
 "zhiwei_liu@linux.alibaba.com" <zhiwei_liu@linux.alibaba.com>
Subject: Re: [PATCH v5 15/15] hw/riscv/riscv-iommu-sys.c, virt.c: add
 riscv_create_iommu_sys()
Thread-Topic: [PATCH v5 15/15] hw/riscv/riscv-iommu-sys.c, virt.c: add
 riscv_create_iommu_sys()
Thread-Index: AQHdNy1tNQNy6DWZJkS/b0etqkkQV7a5NzMA
Date: Tue, 1 Sep 2026 05:28:56 +0000
Message-ID: <e553f4eafed4c38390ba3ff0c2428daefb16f5e0.camel@wdc.com>
References: <20260828203918.350131-1-daniel.barboza@oss.qualcomm.com>
 <20260828203918.350131-16-daniel.barboza@oss.qualcomm.com>
In-Reply-To: <20260828203918.350131-16-daniel.barboza@oss.qualcomm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.60.2 (by Flathub.org) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY1PR04MB9561:EE_|PH0PR04MB7302:EE_
x-ms-office365-filtering-correlation-id: 4965ec9b-c5ae-4644-a908-08df07e9eb22
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|19092799006|10070799003|366016|38070700021|4143699003|10067099003|11063799006|18002099003|22082099003|56012099006;
x-microsoft-antispam-message-info: kOgFuZTYptSeQQ2brPdAuSxD0hzFtzKpSbVmNA92iEhjzQNx7yxWOoS5oAc44f35Mt+ntrD5uvVI2clSTBt+7+/XZpJf1zj2bvQE0SQeeVuB+aXqlPgQbn7EEfSGtIuQ5XggPdgoZtK3+9HhZ5WFKoAsQvpff+LcowpsU76OEAE7jCZ0T0hbAj45j8TfAeAhnInPr6P8LNffwt4tk+FOYA11yqZ3kQzgRxuM0Hck8Ftg2wxJSS/QTKtrJgCdJ2dg8addnZV7Sl1tI73ilyILsumbjnYPfiyOIjafpYZVa6vEbCAEikEjixpwM1/csXVr4WwshdBsYyFehls2vUlfqcr57Xg419Wpo3jqRr4zkXgjp/aFvQm/iwP2fC2vh1RrHFg6owBBNi5hCXLpAVFKdz0NEi0o71JXnZoNV8l8QXr5jg4Vmu3+Ap6Hbq7eL/4Kb5Jbi5ySaVJ+MeV9fJ3ZI1NC2MtBf03f4BMrVyQUUSlbouPD1vk95Ab3Omu3AZpsopKCimTOEJrh2EVqmeFv/oCuXUDRYaJ5nSgRoDJbarXtm4n/QTCDhmuWNO0JGK/BmOlyGy/VMHSZIq0dLNUTnGVb4m9LO0hbziA0tPFMIoTgfEs6PwyOSbL10eSGvEzzXoLQ4Lyr0sZ2AU/2tq41ummND0Z70ClwE6uBAwcCGDgC5MpJj47zRxN9oJR4n4f90bYnZEcCOaLWfRVoeqteohPj+LYfj5ZMTZmwJnXD49E=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY1PR04MB9561.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(19092799006)(10070799003)(366016)(38070700021)(4143699003)(10067099003)(11063799006)(18002099003)(22082099003)(56012099006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YURiaEs2Q0VvWHVHVEkrUWtPVUJoNkIwem8wL1dWVURrdkF3M0gzYjUvdkVJ?=
 =?utf-8?B?TS9QOTV0dmVGd0hqKzJFdnYzRUgvL1A4ZFRYdCtIQkcxcmE3bmRQS2hZb3Qy?=
 =?utf-8?B?Q3JtUlkxSXh6cVFZWlBHMlh2dVArSDdXQ0hJREpTaHMxSkw5Y0d6YzFmSHIr?=
 =?utf-8?B?bkVBNnBTZ2cvZzZKRzNueVIxYUVtd1hiU0xVYndOeXlmZkZoK2xCYmtlYjhZ?=
 =?utf-8?B?NmJDRmxaSVFIVTY2WnZzdjljTkNjelNCc1pZcEZxU25qVWJCcGNkQ0JOblpy?=
 =?utf-8?B?aXlHNkdIWXdVMCs0VGd1aU5GWVJVaDZqajNUNlhhSEhjWjE0UjYvQkFRM09S?=
 =?utf-8?B?VGlBWXhDY2dsTFh0WEdxTXZxN0g0Y3o0MkNma3kxSmRmZFUzN0FtdXliNHVq?=
 =?utf-8?B?ZVRzU3hXVGxJMkZxWFhZdzNTbk81SXhxelV3QVdpaXNvM3JiTUV3OEhHOUpW?=
 =?utf-8?B?U3Z4MGs0aVcrTzhkNFpreG03c1FtOThhNTEwa0U3RzJrRktNOWNMKzExeUc2?=
 =?utf-8?B?WVVpTzlEWmNkeEFMaW0vdFZpTzFXaU81bzZEaWtMSmhzWnczNWFoVnlxRVhj?=
 =?utf-8?B?blgrdFdlRXljYldWOUpVeFI1Uno3ZjNkNlcxaU9aNU1VbWtQL1VtcFN2VXF4?=
 =?utf-8?B?SGNyQ2RzUDNwQ2pPRFhYT0VJWWhVREpRTUx1aFY5Z3dmMUY4U0JxOStSeVhE?=
 =?utf-8?B?aDMyWmEwM0pNOWZPTUt0L04zUzhvOGRkOHlidm10K0h2UFFjYXA1aWw4bDJN?=
 =?utf-8?B?OHBQWHVhVW9ibkJMOFdYaUFQc2o2Mm5VTGlzRDd2SHJwTC9YdG5tU09kazJR?=
 =?utf-8?B?YXRHT2d4NHNpTU82T084ZEZacjVnUGp3SFFHcTJkaUNlOUpqUUcrakxPVEEr?=
 =?utf-8?B?NWtEL3E4NTBZdGpOcFFHaThJdEF3K2IvQ0pSOEMzMUprRktXQ1hXUmgyVzB0?=
 =?utf-8?B?Mnk4OFhkMHh0ZTVpZFl5bVI3UURwQm1iNzM2bDl2cUpESjJ4L3QwUEgzdUcy?=
 =?utf-8?B?Z0dENXdEVEExVUtzTUw2RWYyMEtKTnR3aUUrT09waVdQaFZBSEFmcXlJMkFq?=
 =?utf-8?B?cjJtSEtJSTlSU1JhNnl4UW5zVk1xR1lGYUtyQjI3Z3J1ZXl2TW1BdjZrVkky?=
 =?utf-8?B?NUxvSXpiNHd1dEtNMkxnQ1g1TjV0NHRGTGxvcUxaemR4S0RCeVliMHZNWUho?=
 =?utf-8?B?bnJkQlRaTXZteHA3N01McWxXV0xRMmRrNHFmT3pVZks3YytUQWJYOS8raU1W?=
 =?utf-8?B?T3Yya0pCNXF4VEkxRWF3WGswNXF5bDQrT3JUd29sbVM0WlNpNmdQcmNFcVI5?=
 =?utf-8?B?YlkzM3BYcnQ1bnlaSEU2VDkyVEdteFYzUzhqSmk3b2toZFBpbFRrZHBjUWhq?=
 =?utf-8?B?Q0VreWFHMUtFcVUxTjhIYncxMWhPR0lPYjR3eG81VHVZTW1kU1BFMlkyM0Jw?=
 =?utf-8?B?enlvS2J2MmNnNDdTVUQvY3Zld3d3YWNkODZBSFBNYTloRTZMOFpUb1g4VnBp?=
 =?utf-8?B?UlVaWkthZWhjNzdHMHlEem1wNkdMMmdLVWgzU0U1WmhMZTd0MU15bE1vRll4?=
 =?utf-8?B?NGJ3WEVjSHZRLzNwUlpLQkh0MXFnemRGZEJIUmlyOEw2ZTcrS05XSEV5eXRU?=
 =?utf-8?B?QjR2Nk9zMHRrYWQ1Y0xocTlxSjc1dGFySDN4Zit3R2hsSVZDUkx0YVdDZHhW?=
 =?utf-8?B?WUJ4cWlrbVBkWGFKN2ZxaXB4bldKUmtwWFNOM21jNWxKSGFvZkg2R3k2eklh?=
 =?utf-8?B?YjhzcERPK1RLZ2VDbjk1ZEVwaXBTTHAyRWdtbFdjM1FoeWpjYzArQ3RJbVBa?=
 =?utf-8?B?bDN1bU1mUWV6WVVidWgybEZDZGNuZ3c4VE96TC9SYkJETFkxVjFubUJNbkth?=
 =?utf-8?B?YkFaREJ6RXMvdGNzenpyY0taNGNZdWNhK2JoT2JYaG9YdkRteG5icW9NN3hr?=
 =?utf-8?B?b3RvZWtCOFp3eU9SQ2pocGU2L1pXQ2dkdEh2WitZNENoTDR5eHJnQWF2U0tw?=
 =?utf-8?B?VmIvNjJqZVExSU9wbXMyZmRBcHpRSVdnSnlJREFnMHd5MGp4dkp3V3E0NWM3?=
 =?utf-8?B?ZnE2Qko5ZTVGV0xnazlHY0tQaHlxYTY2TEY4bDFTZ3ZmTU16cTJscnUxaWNG?=
 =?utf-8?B?ck1BcGlDUlJtRk5mQUhLVlhtenJsZFZ3SGMxK1dSSTROZ2xrbExSMjJSdi9H?=
 =?utf-8?B?OUx3Sis2K1A3ZERob2t4NTFKQWJnVWpIVkZKTElCUmxGb3NrVjI4WmxDekQ0?=
 =?utf-8?B?dllydEVrK2dPMmp0STNFa2Z2L1BJak5YZ0d3RnlzbEdmKzVpTnV4OEwvR3Y4?=
 =?utf-8?B?aVlrYXJLS3h0d0xFM05FQVEvaWs4cXFNaXlTYUJRUS9SdmxJeitRYnV2S2Z3?=
 =?utf-8?Q?EMsFhOlr+1SbYXq34E3Pln6AjcJWJyh2lx7piszpZLAtN?=
x-ms-exchange-antispam-messagedata-1: ME9mN2VKGTkiJbGFlCupyS4TszCqa22tt5Y=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8EFF59BEB407874B90F67DEAB26FC69D@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: dMAlSOYJqGr5wPitAY96b1i1s28K3qTv7f13kz/PEd+h2uqqPQFmVvSP/x9/W1IE0jdkCm9B+3JyulLVy/O38JErgiI8Ptmlok/CwtKxLm7oqJyvT22O/VRGotxcqMJvKoHY8IHUUb3tSQagczHUPdpDTIq7jhfblR7/oS5SxYvDsKLxE2at6uXhq00KLEMWygAxyeHc824RE/ao+JkMfuqPsHuce5pykQptiheCt5VpYx3SNjZdWWdMlmsFDQ7v19G0JjRY7HAlAZ8Qu6giCwssFA4eyt2jxcws7cEXUl5P3H2FjTfpM8B21rMTeeYGQkVpL+Puc2bJLxbOnhrT9g==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 4zdkUVfZWpREtFxulm9piB41CNBIKNv5qcDA6rprFdFc5591q0GjH9K/2yJ5D5E19u0NC6A1QyykdILJidpfDXAXyDBXQ4fUbVUo4KYUi0b6HW7Srs0mnd8Mmw5Jr8/9LKgIEJZs8G7Iihg/eiWY/ulIMgc8O0f7WjsAm8TcICRyNCvc7FyODmut4TTURNwE0i399Q5f8w+NEi+Up8ZpaPpIItoY1wI15Vx2cJUOt0FWFQ48dvsUQMGYuxFy9Ixvp21vYUwCB2w6RcH9BF0dHkO0615yHWFlVGA5JkqFo4VOm9wprblDnGop1ZMzbtOX5TBJN/Y2AsvbkxavwzESlV1fKs5S9rD7hJ8wFoQcs6WguzNoJfzQ9K8zRxA3c98zAfcLnFl/tPh4HTUSDohoZhL78FIZxRTPbu2IVw+1YM1MNO+0LDfS5RNbiEuGtol9pjxK6D94tfsf9y5GCOM+p6m5YGYgVBgTj78mFEYD6MuUkKXuPoAOIHMgn9uyz6G7pq7bNlGiQlUnpkSsxs9rXHNlCgeTDWOhjETI0tTIOVThQsFPbXEQNo3hS8hnijrJeIcyOOGh7vkLOnsdzjfXRRTnZggF5oalcv7QX0ffzuv8fcw5SdB1/ATUwKmyVSZU
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY1PR04MB9561.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4965ec9b-c5ae-4644-a908-08df07e9eb22
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Sep 2026 05:28:56.3086 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fn6LxcxWGRgJAMnoh6X3+5gC6a00/PN2vEBA9vqtTI8CZOmFUrJy0WboB62At9adEFwpRa5rViLM01I4BWfGkA7z5C8ZJerSIRz2VnrSdp8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7302
Received-SPF: pass client-ip=216.71.154.42;
 envelope-from=prvs=6977d653a=Alistair.Francis@wdc.com;
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

T24gRnJpLCAyMDI2LTA4LTI4IGF0IDE3OjM5IC0wMzAwLCBEYW5pZWwgSGVucmlxdWUgQmFyYm96
YSB3cm90ZToKPiBNb3ZlIHRoZSBjcmVhdGlvbiBvZiByaXNjdi1pb21tdS1zeXMgdG8gaXRzIG93
biBmaWxlIGluc3RlYWQgb2Ygb3Blbgo+IGNvZGluZyBpdCBpbiB0aGUgJ3ZpcnQnIGJvYXJkLsKg
IE90aGVyIGJvYXJkcyBpbiB0aGUgZnV0dXJlIG1pZ2h0IHdhbnQKPiB0bwo+IHVzZSB0aGlzIGRl
dmljZSBhbmQgd2Ugd2FudCB0byBhdm9pZCBjb2RlIGR1cGxpY2F0aW9uLgo+IAo+IFNpZ25lZC1v
ZmYtYnk6IERhbmllbCBIZW5yaXF1ZSBCYXJib3phCj4gPGRhbmllbC5iYXJib3phQG9zcy5xdWFs
Y29tbS5jb20+Cj4gUmV2aWV3ZWQtYnk6IFBoaWxpcHBlIE1hdGhpZXUtRGF1ZMOpIDxwaGlsbWRA
b3NzLnF1YWxjb21tLmNvbT4KCkFja2VkLWJ5OiBBbGlzdGFpciBGcmFuY2lzIDxhbGlzdGFpci5m
cmFuY2lzQHdkYy5jb20+CgpBbGlzdGFpcgoKPiAtLS0KPiDCoGh3L3Jpc2N2L3Jpc2N2LWlvbW11
LXN5cy5jIHwgMjUgKysrKysrKysrKysrKysrKysrKysrKysrKwo+IMKgaHcvcmlzY3YvcmlzY3Yt
aW9tbXUuaMKgwqDCoMKgIHzCoCAzICsrKwo+IMKgaHcvcmlzY3YvdmlydC5jwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCB8IDIzICsrKy0tLS0tLS0tLS0tLS0tLS0tLS0tCj4gwqAzIGZpbGVzIGNoYW5n
ZWQsIDMxIGluc2VydGlvbnMoKyksIDIwIGRlbGV0aW9ucygtKQo+IAo+IGRpZmYgLS1naXQgYS9o
dy9yaXNjdi9yaXNjdi1pb21tdS1zeXMuYyBiL2h3L3Jpc2N2L3Jpc2N2LWlvbW11LXN5cy5jCj4g
aW5kZXggMzMxNGFkZWVkMi4uMjU4YzE3MWVmZCAxMDA2NDQKPiAtLS0gYS9ody9yaXNjdi9yaXNj
di1pb21tdS1zeXMuYwo+ICsrKyBiL2h3L3Jpc2N2L3Jpc2N2LWlvbW11LXN5cy5jCj4gQEAgLTIx
Nyw2ICsyMTcsMzEgQEAgc3RhdGljIHZvaWQgcmlzY3ZfaW9tbXVfc3lzX2luaXQoT2JqZWN0ICpv
YmopCj4gwqDCoMKgwqAgcmlzY3ZfaW9tbXVfc2V0X2NhcF9pZ3MoaW9tbXUsIFJJU0NWX0lPTU1V
X0NBUF9JR1NfQk9USCk7Cj4gwqB9Cj4gwqAKPiArRGV2aWNlU3RhdGUgKnJpc2N2X2NyZWF0ZV9p
b21tdV9zeXMoRGV2aWNlU3RhdGUgKm1taW9faXJxY2hpcCwKPiArwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBod2Fk
ZHIgYWRkciwgaW50IGJhc2VfaXJxLAo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGJvb2wgaXNfMzJfYml0KQo+
ICt7Cj4gK8KgwqDCoCBEZXZpY2VTdGF0ZSAqaW9tbXVfc3lzID0gcWRldl9uZXcoVFlQRV9SSVND
Vl9JT01NVV9TWVMpOwo+ICsKPiArwqDCoMKgIG9iamVjdF9wcm9wZXJ0eV9zZXRfdWludChPQkpF
Q1QoaW9tbXVfc3lzKSwgImFkZHIiLCBhZGRyLAo+ICZlcnJvcl9mYXRhbCk7Cj4gK8KgwqDCoCBv
YmplY3RfcHJvcGVydHlfc2V0X3VpbnQoT0JKRUNUKGlvbW11X3N5cyksICJiYXNlLWlycSIsCj4g
K8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IGJhc2VfaXJxLCAmZXJyb3JfZmF0YWwpOwo+ICvCoMKgwqAgb2JqZWN0X3Byb3BlcnR5X3NldF9s
aW5rKE9CSkVDVChpb21tdV9zeXMpLCAiaXJxY2hpcCIsCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIE9CSkVDVChtbWlvX2lycWNoaXAp
LAo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCAmZXJyb3JfZmF0YWwpOwo+ICvCoMKgwqAgLyoKPiArwqDCoMKgwqAgKiBGb3IgcmlzY3Y2
NCB1c2UgYSBwaHlzaWNhbCBhZGRyZXNzIHNpemUgb2YgNTYgYml0cyAoNDQgYml0Cj4gUFBOKSwK
PiArwqDCoMKgwqAgKiBhbmQgZm9yIHJpc2N2MzIgdXNlIDM0IGJpdHMgKDIyIGJpdCBQUE4pLgo+
ICvCoMKgwqDCoCAqLwo+ICvCoMKgwqAgb2JqZWN0X3Byb3BlcnR5X3NldF91aW50KE9CSkVDVChp
b21tdV9zeXMpLCAicGFzLWJpdHMiLAo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBpc18zMl9iaXQgPyAzNCA6IDU2LAo+ICvCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAmZXJyb3Jf
ZmF0YWwpOwo+ICsKPiArwqDCoMKgIHN5c2J1c19yZWFsaXplX2FuZF91bnJlZihTWVNfQlVTX0RF
VklDRShpb21tdV9zeXMpLAo+ICZlcnJvcl9mYXRhbCk7Cj4gKwo+ICvCoMKgwqAgcmV0dXJuIGlv
bW11X3N5czsKPiArfQo+ICsKPiDCoHN0YXRpYyBjb25zdCBQcm9wZXJ0eSByaXNjdl9pb21tdV9z
eXNfcHJvcGVydGllc1tdID0gewo+IMKgwqDCoMKgIERFRklORV9QUk9QX1VJTlQ2NCgiYWRkciIs
IFJJU0NWSU9NTVVTdGF0ZVN5cywgYWRkciwgMCksCj4gwqDCoMKgwqAgREVGSU5FX1BST1BfVUlO
VDMyKCJiYXNlLWlycSIsIFJJU0NWSU9NTVVTdGF0ZVN5cywgYmFzZV9pcnEsIDApLAo+IGRpZmYg
LS1naXQgYS9ody9yaXNjdi9yaXNjdi1pb21tdS5oIGIvaHcvcmlzY3YvcmlzY3YtaW9tbXUuaAo+
IGluZGV4IGRhNzBlOGJmYTguLjdjNDcwYmEwODQgMTAwNjQ0Cj4gLS0tIGEvaHcvcmlzY3Yvcmlz
Y3YtaW9tbXUuaAo+ICsrKyBiL2h3L3Jpc2N2L3Jpc2N2LWlvbW11LmgKPiBAQCAtMTA0LDYgKzEw
NCw5IEBAIHZvaWQgcmlzY3ZfaW9tbXVfc2V0X2NhcF9pZ3MoUklTQ1ZJT01NVVN0YXRlICpzLAo+
IHJpc2N2X2lvbW11X2lnc19tb2RlIG1vZGUpOwo+IMKgdm9pZCByaXNjdl9pb21tdV9yZXNldChS
SVNDVklPTU1VU3RhdGUgKnMpOwo+IMKgdm9pZCByaXNjdl9pb21tdV9ub3RpZnkoUklTQ1ZJT01N
VVN0YXRlICpzLCBpbnQgdmVjX3R5cGUpOwo+IMKgdm9pZCByaXNjdl9pb21tdV9mYXVsdChSSVND
VklPTU1VU3RhdGUgKnMsIHN0cnVjdAo+IHJpc2N2X2lvbW11X2ZxX3JlY29yZCAqZXYpOwo+ICtE
ZXZpY2VTdGF0ZSAqcmlzY3ZfY3JlYXRlX2lvbW11X3N5cyhEZXZpY2VTdGF0ZSAqbW1pb19pcnFj
aGlwLAo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIGh3YWRkciBhZGRyLCBpbnQgYmFzZV9pcnEsCj4gK8KgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgYm9vbCBpc18zMl9iaXQpOwo+IMKgCj4gwqB0eXBlZGVmIHN0cnVjdCBSSVNDVklP
TU1VQ29udGV4dCBSSVNDVklPTU1VQ29udGV4dDsKPiDCoC8qIERldmljZSB0cmFuc2xhdGlvbiBj
b250ZXh0IHN0YXRlLiAqLwo+IGRpZmYgLS1naXQgYS9ody9yaXNjdi92aXJ0LmMgYi9ody9yaXNj
di92aXJ0LmMKPiBpbmRleCBkNzVkZWMyZGQyLi5kZTdiOTljNmE1IDEwMDY0NAo+IC0tLSBhL2h3
L3Jpc2N2L3ZpcnQuYwo+ICsrKyBiL2h3L3Jpc2N2L3ZpcnQuYwo+IEBAIC0zMiw2ICszMiw3IEBA
Cj4gwqAjaW5jbHVkZSAiaHcvY29yZS9zeXNidXMtZmR0LmgiCj4gwqAjaW5jbHVkZSAiaHcvcmlz
Y3YvcmlzY3ZfaGFydC5oIgo+IMKgI2luY2x1ZGUgImh3L3Jpc2N2L2lvbW11LmgiCj4gKyNpbmNs
dWRlICJody9yaXNjdi9yaXNjdi1pb21tdS5oIgo+IMKgI2luY2x1ZGUgImh3L3Jpc2N2L3Jpc2N2
LWlvbW11LWJpdHMuaCIKPiDCoCNpbmNsdWRlICJody9yaXNjdi92aXJ0LmgiCj4gwqAjaW5jbHVk
ZSAiaHcvcmlzY3YvYm9vdC5oIgo+IEBAIC05MzMsMjYgKzkzNCw4IEBAIHN0YXRpYyB2b2lkIHZp
cnRfbWFjaGluZV9pbml0KE1hY2hpbmVTdGF0ZQo+ICptYWNoaW5lKQo+IMKgwqDCoMKgIH0KPiDC
oAo+IMKgwqDCoMKgIGlmICh2aXJ0X2lzX2lvbW11X3N5c19lbmFibGVkKHMpKSB7Cj4gLcKgwqDC
oMKgwqDCoMKgIERldmljZVN0YXRlICppb21tdV9zeXMgPSBxZGV2X25ldyhUWVBFX1JJU0NWX0lP
TU1VX1NZUyk7Cj4gLQo+IC3CoMKgwqDCoMKgwqDCoCBvYmplY3RfcHJvcGVydHlfc2V0X3VpbnQo
T0JKRUNUKGlvbW11X3N5cyksICJhZGRyIiwKPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBzLT5tZW1tYXBbVklSVF9JT01N
VV9TWVNdLmJhc2UsCj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgJmVycm9yX2ZhdGFsKTsKPiAtwqDCoMKgwqDCoMKgwqAg
b2JqZWN0X3Byb3BlcnR5X3NldF91aW50KE9CSkVDVChpb21tdV9zeXMpLCAiYmFzZS1pcnEiLAo+
IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIElPTU1VX1NZU19JUlEsCj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgJmVycm9yX2ZhdGFsKTsKPiAtwqDC
oMKgwqDCoMKgwqAgb2JqZWN0X3Byb3BlcnR5X3NldF9saW5rKE9CSkVDVChpb21tdV9zeXMpLCAi
aXJxY2hpcCIsCj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgT0JKRUNUKG1taW9faXJxY2hpcCksCj4gLcKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgJmVy
cm9yX2ZhdGFsKTsKPiAtwqDCoMKgwqDCoMKgwqAgLyoKPiAtwqDCoMKgwqDCoMKgwqDCoCAqIEZv
ciByaXNjdjY0IHVzZSBhIHBoeXNpY2FsIGFkZHJlc3Mgc2l6ZSBvZiA1NiBiaXRzICg0NAo+IGJp
dCBQUE4pLAo+IC3CoMKgwqDCoMKgwqDCoMKgICogYW5kIGZvciByaXNjdjMyIHVzZSAzNCBiaXRz
ICgyMiBiaXQgUFBOKS4KPiAtwqDCoMKgwqDCoMKgwqDCoCAqLwo+IC3CoMKgwqDCoMKgwqDCoCBv
YmplY3RfcHJvcGVydHlfc2V0X3VpbnQoT0JKRUNUKGlvbW11X3N5cyksICJwYXMtYml0cyIsCj4g
LcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgcmlzY3ZfaXNfMzJiaXQoJnMtPnNvY1swXSkgPyAzNCA6Cj4gNTYsCj4gLcKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgJmVycm9yX2ZhdGFsKTsKPiAtCj4gLcKgwqDCoMKgwqDCoMKgIHN5c2J1c19yZWFsaXplX2Fu
ZF91bnJlZihTWVNfQlVTX0RFVklDRShpb21tdV9zeXMpLAo+ICZlcnJvcl9mYXRhbCk7Cj4gK8Kg
wqDCoMKgwqDCoMKgIHJpc2N2X2NyZWF0ZV9pb21tdV9zeXMobW1pb19pcnFjaGlwLCBzLQo+ID5t
ZW1tYXBbVklSVF9JT01NVV9TWVNdLmJhc2UsCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBJT01NVV9TWVNfSVJRLCByaXNjdl9p
c18zMmJpdCgmcy0KPiA+c29jWzBdKSk7Cj4gwqDCoMKgwqAgfQo+IMKgCj4gwqDCoMKgwqAgcy0+
bWFjaGluZV9kb25lLm5vdGlmeSA9IHZpcnRfbWFjaGluZV9kb25lOwo=

