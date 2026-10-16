Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47818CCA463
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2026 01:11:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHWTi-000704-80; Thu, 15 Oct 2026 21:11:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=742cbab99=Alistair.Francis@wdc.com>)
 id 1xHWTL-0006qw-Sm; Thu, 15 Oct 2026 21:11:03 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=742cbab99=Alistair.Francis@wdc.com>)
 id 1xHWTI-0005LM-Nk; Thu, 15 Oct 2026 21:10:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1792113057; x=1823649057;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=go5Ap/qHd5KTppGV77oj83R/K340TBe+XLlWr5amAoI=;
 b=hwXWhlOMt6GeEbaSRucXsKzRQDPb2GB+cP5F8ewwjwfBDoJxkqVHo+KW
 SUQGjjUXTkXSVF/hk9oqLcL8n8A7ClIgXP493Gbi4xSNFQ1ijzi4roQt7
 Hgu7SqPxBsNQ5JPosjGSG2Kp0tWNsBeKW1+haJ2L9Ub+Ai16szpfZ1l21
 iJK68dAPsMHO1lut7lVNnZpmh0EtHkXq3E6m9QuXXqEItZDyEYLSsatvU
 1afx71Qp3Ql7GhasyO9aZw+2TxiND3CL4+JHn+S6ZUpeuI7iQuUyXtgMG
 scBLBbIByIlYYwpsmuFtgzKBilXU4CN5MZRFN9wKHufQOeKW22gEeEEkq w==;
X-CSE-ConnectionGUID: l3Xh+PitQEyOHNfci743Yg==
X-CSE-MsgGUID: lhXnCHIBQcSOQnUi2QGHug==
X-IronPort-AV: E=Sophos;i="6.27,160,1786982400"; d="scan'208";a="158227576"
Received: from mail-westus2azon11010056.outbound.protection.outlook.com (HELO
 CO1PR03CU002.outbound.protection.outlook.com) ([52.101.46.56])
 by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 16 Oct 2026 09:10:55 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I6LatFHEg3MS+oF60guEmgO8dWsa2mjuqwzlmGCEREXyx/4mv5woEgPFJRhOGeLjkhSqU2BTw3V9VqgWO66FNIVoEKSkkW50Y6kYMwatiuBGo1XM9zLD/13WdXFCvsrdchhnvVgr9aQUPAmQ4ySKYH7jSzxNntHL/iEOnjZqeBTy539irxIyXF3Hmd98CnRvEqSVJE6n03Ad2HOCzcHvm4s11ukHTCtJ7Cj5OBfyeGlukIX57/qv0m/Tf3G67GWROa0gtQgBtmbx4SQn/WwX3l2feNhblDYKkM4eeczwexvaLA4zQXlhncUCQE6UnvL6V+24FG1tlVKPX1bvNqZ35w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=go5Ap/qHd5KTppGV77oj83R/K340TBe+XLlWr5amAoI=;
 b=J6OQG4qvSq2U9VagmDc1o3B5Dc/G8X3nmBxwn/FP64NN2hU01FIhEAsn4Mf95kZ+1AqB94ilRv8udhwfiF5pLCj4tCEmPsuSajK95rMG1cSEFqCaVK67dqmbGHvnals0DKiKglTWDXVq7wqxejZJM6ICGciBu561gEEl7ck4TY5y8gqvpd+m6PsFQ13H3qj7dyf0JPVEQOyXGfW7LjWxvYddD+zME2oq/oWZXnS+0SVLmX6p8Vq39oDqqBYmQ/zE6/tJQba3LoF7U4Qu/tzkt7LnBzqAJQbytO60QkvJ3HIB/3XmIvMY+7/yQJh3gNMEQKg/vbcZPyFQTrHi8oCdKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=go5Ap/qHd5KTppGV77oj83R/K340TBe+XLlWr5amAoI=;
 b=M/EJGpydCMg612t2DuT7dUGXOyvrK7iYKDrW0pAfN/yuKdMU+CS/i34b1+eqS0E588cTnhJFbQrr3EoTy8DdG8G+GbrF4rXXVZPeRSrvGEEDW9UROcJSGJBCITmkaPFWry/zbQs3yKgD+f3rynbI4g8ohUrzD5u/M8CStakyHvk=
Received: from MN6PR04MB9359.namprd04.prod.outlook.com (2603:10b6:208:4f2::13)
 by CO6PR04MB7476.namprd04.prod.outlook.com (2603:10b6:303:ac::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Fri, 16 Oct
 2026 01:10:51 +0000
Received: from MN6PR04MB9359.namprd04.prod.outlook.com
 ([fe80::e729:bbef:5a37:2e77]) by MN6PR04MB9359.namprd04.prod.outlook.com
 ([fe80::e729:bbef:5a37:2e77%4]) with mapi id 15.21.0522.013; Fri, 16 Oct 2026
 01:10:51 +0000
From: Alistair Francis <Alistair.Francis@wdc.com>
To: "liumingliang.dev@bytedance.com" <liumingliang.dev@bytedance.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "palmer@dabbelt.com"
 <palmer@dabbelt.com>, "daniel.barboza@oss.qualcomm.com"
 <daniel.barboza@oss.qualcomm.com>, "chao.liu@processmission.com"
 <chao.liu@processmission.com>, "richard.henderson@linaro.org"
 <richard.henderson@linaro.org>, "zhiwei_liu@linux.alibaba.com"
 <zhiwei_liu@linux.alibaba.com>, "liwei1518@gmail.com" <liwei1518@gmail.com>
Subject: Re: [PATCH v4 0/3] target/riscv: Add experimental Zvabd extension
 support
Thread-Topic: [PATCH v4 0/3] target/riscv: Add experimental Zvabd extension
 support
Thread-Index: AQHdXKtL14piVa9c/0mcDxSXLXTdpbb/XQWA
Date: Fri, 16 Oct 2026 01:10:51 +0000
Message-ID: <9522dd9fcb7f364c5b587377b0b8f9c03e6ef732.camel@wdc.com>
References: <20261015134337.3354723-1-liumingliang.dev@bytedance.com>
In-Reply-To: <20261015134337.3354723-1-liumingliang.dev@bytedance.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.62.0 (by Flathub.org) 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN6PR04MB9359:EE_|CO6PR04MB7476:EE_
x-ms-office365-filtering-correlation-id: e50fd677-9fd5-41c3-6596-08df2b2251de
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|10070799003|23010399003|19092799006|38070700021|56012099006|11063799006|261009223027099003|18002099003|22082099003|10067099003|3023799007;
x-microsoft-antispam-message-info: ompgERNOViPNNUzrZYCXlcQGKto22eRJ6WIjMTXFyvaTfDdxGjea3cJj+SzfPFtfFi2rTaE5Vf20LQXilwVkBDIvPCDqmGXBoDvM/1oXMERcNwgnc08jSI771pkHBeJMgq3C6DOB6AN25LkPzVXRnzRp5n7XYAr5ydSpGSl8kU89UKFN8jaaxLT9tYRs+DSZ3nEmTovYvNVjq64R2zS4UWitbExwJOrRqZsdGZyVEJZsgHsmvSGfvfbCHxp+TBOU//VbMDIPR65nuiP9Mu+0LclMknHjg9lkI/xDarDp6Rtmewqc45r3SraOuakstKsZCpvGjDTbiKs4lb2dfGfNyaSSXUbnzwn6VF/XlE05pMd1s/nzflqquARxuBbH/ozo/Om5hzt6B6TG6IvhnuxMkN6tK61khdu4G1kPn0FvU7u2KJSF8Wr9Pwl5CezT+cIO0JgyzxSGN/uZWVzC719Zi+s5TKX8z3AGb0PiaGnab0O/D8PbOoe4YURzcUdAG42GBt2j+BOCvYtpMU9LAfRowpIOPmLWRT2e3S2Ybif+YgubxAmgc9RXDsUC1igmXvlscZ46eV/6QMwfzfu4VNf9uXFU2WZsbVG5ZI0Pud8Ig8By11Q4eIbBvFJBh3DwHfTZ+Ma/qJKLFO7oHrFWd+TO2EBR0Ix+2pPuh9Zlw6QJioNB8yFlrVLgmL/BBiiDYRk7D+NCgVWbFAFfoQ2040x71zlaix2n2g+qPh2TcPfWfpc=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN6PR04MB9359.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(10070799003)(23010399003)(19092799006)(38070700021)(56012099006)(11063799006)(261009223027099003)(18002099003)(22082099003)(10067099003)(3023799007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cnZjMmRzdFNTaXBPYUt2UlAyWE1Vd1MwNUt2QVdmbnBlN0txTjkrdUxWYmY3?=
 =?utf-8?B?WVhOaHJ0RWZ4Q2tueVFOQ2s4Vm1ib3JJS05QSjFJSzZSNXpEM1M0UkJ1WXk0?=
 =?utf-8?B?SDhGbTFPTHl5Q1N5K3BSVENSUXZ5YjkwNXNLdHB6V0lSaDBkS1pXV2RGYzM2?=
 =?utf-8?B?d2pLMURYTGRCcHBHdEZmN05OdTJLMUs1R25xQVlDdHNOTG1MMGl2UjYyZGJB?=
 =?utf-8?B?aXZZb2svNnUvNnk3Z0YyWjN6aHJDa050aUhTUCtMcm9XU1dQbHdyVEdVSmRm?=
 =?utf-8?B?WXBlZ2l5UWZyMzFsSFFmZUlyRkw3bFppSjJHeEdZbTZuL2ZnK1VnSlRpWXFN?=
 =?utf-8?B?YmFkMEppQk8vV1ErRVZkY2pxUUsySXl1ZHZQZS9nTk5LcTl5VjhMa0JCcHdV?=
 =?utf-8?B?UEpoK1c4Z1dQMUxHMC9JdzhiQ0pNSXR3cUlXYTJpeXdmUExsUnNrQjVKS0hC?=
 =?utf-8?B?UnIwMUtLTklGb21XUXVFSHYwTG1lWEc4U2QxMmF4MXZLbFFpSkxHUjQvRDJX?=
 =?utf-8?B?MkdURlNoZURsU2ZHYnhzcTRhZU92QWV5S0JGRXdiaStXc3hGNkswRHNUd2tl?=
 =?utf-8?B?a1I3ckNURjdmQTd2cWoxV0hXK0NDVFM3Nnp6WURIYXcxUGlBdzhtZkhDcStR?=
 =?utf-8?B?bWkwakg1dVlFRE14VWczR2ZrYUYrdXE2dWtRbTdMV0ZXMzdObzNVMnVqODJy?=
 =?utf-8?B?SkhFdTZaVzBXaU1BalFFOGJ4K3NUNnNqUjMwdjRYMHVBNnA1c2N4SjVRZEEy?=
 =?utf-8?B?NnZXdVZSeUhYSnNoRVdvR1piTWtrcXZpQmQ3OGkvdDlla3pIOGR5WFdFL3FS?=
 =?utf-8?B?N05aY3RlUHEyR045TFh4bzRSQWNISmZkVVJXaTZQRThDNXJycmsxamR6WjNj?=
 =?utf-8?B?bnNDNTJhbnptMnpXbDgrcjJjTUlXMnRtSjRGaWtNNngzQU80WFdGNVFieGt6?=
 =?utf-8?B?U3l5dDRoRTZMSG0zd0VwT25kcWRncVV0RU1MZmpSMFUzcFNaaVJOM1F1REdL?=
 =?utf-8?B?MzduNW1tR28zRi96YzQzbXFSQ2JwSmtKWVBTNkxjVU1rQVFUcEYyU05reVY2?=
 =?utf-8?B?T0FwaUZYMFk4OUR4NzNFTzBDWnpBZUI1YTVySThzL2hSNDNIQkNPSHN6ZlNt?=
 =?utf-8?B?aU1zbUtidzR6dkJadlI5MnhtdUswMVNaZXVPVHlDeXE5RS9kZGJzdlB4Y2xq?=
 =?utf-8?B?TjFoMzlDQzBoajZTUVM5b2JKUGRWaGgvbVE0bVRleUk3VzdQL1JQZVQ0Z2FT?=
 =?utf-8?B?TWhMTUZaTjlKODkzeXFRdUlkYytSUDAvK3VRWm9Fb2dFb3dRWlR1UGE1dWxh?=
 =?utf-8?B?U2VScHRHL2NkSkJCcjRPZEtFN3JmN1VIeVdmeEROYU5zcXBFQVIzeCtLcU1G?=
 =?utf-8?B?YStWOVFTRy9OR1JRajlvR3pyNUFXZVFxOHc4OFpwLzRqMWt2bDM0dzFmMnFN?=
 =?utf-8?B?VDVPb3ZPNmlOVlk2SlQrejdiRHRRU0RNMHhodG1remxkOUxSQ3BPUzBIRkdW?=
 =?utf-8?B?QnlBRjhXTXZSZWFlUUYvODFUWHNXWVRKcTNROWRubmdXVmNLd3NCcy9aN1N6?=
 =?utf-8?B?cGswYjc4SE5seENGcDYrRUpoN05QQklTMDFrWU9BYzU1OEpSRXY2UVRVRFNo?=
 =?utf-8?B?RGh6dHlWS3QzYWhWYmc3SXlyWVlqNXZzeTVoWFhQOTNpV29DY0dFeEZUVUtr?=
 =?utf-8?B?cjFBRFc1dUJqR1JMTjBWNHZkcGMzcWNqcFd5eUJxcGVwTzVwU2xjVjlVQXB3?=
 =?utf-8?B?bUovOTRidTJicVlvYVpFVTRsQXBBWXhNREFaUkVCNGR3WkdKMG5KZnN3VUJP?=
 =?utf-8?B?ZzhFQ0lBUzRHMlgzaHdmZGUySU5XZzV4ZHc1WTVaM3ZHelVSWWRYUXROaVBu?=
 =?utf-8?B?dkp0aTRselJ6ODA1TFlaR1pUdGNlTXlDbFA1U0h3TG1oR2J6djZKR3pGdC9F?=
 =?utf-8?B?eE5uWi9CeU9iZVZLNkdxWU1GRU9DTTVnV3FzV09RWThkK3lZUDluaTE4NFNp?=
 =?utf-8?B?R1UvYkxueXM1ZjcxZXJUZWNYZzBRY09OMkJvem85eTErdXc2T2I4blczN2dk?=
 =?utf-8?B?dGNkVndpNTFHMEpqdG55OWhNRkUxUFprQ1ZaVC8xV2VGT2JrOFZNTUtUUXN2?=
 =?utf-8?B?YllEcDh3M1UxbjNXU3Jyd0FlVk9TTEx5NDJid3hGcHUrWWJJa2NWSjlyUnJC?=
 =?utf-8?B?aW8rMEdmN01IMmYyTktIOHd2a3VqRTVjQWttajNEVDNkZG9TbG5PM1VpSnpj?=
 =?utf-8?B?V0I5NmJmWDBxdHJSUUVDL3pHc2hVMjNkN2c0ajZ1S0MwR1F0NTZXc1cyeHcv?=
 =?utf-8?B?eUxhNVBOOEJtOG9YaTFMem01a3BoQ2Y4K29HWXYrenFJeDJoL1FDL0owdFlu?=
 =?utf-8?Q?fkvDEoCr2VeMLO7XBK3w1oyRMB9eXGofLBkz+wf0OkJB6?=
x-ms-exchange-antispam-messagedata-1: 03//RaEeiKZY6F415a0TEC7Xhb7bB154oaU=
Content-Type: text/plain; charset="utf-8"
Content-ID: <63EBA1C5DDC3E24CB0EC88D992DCC1E4@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: sD2Dm08fI+ZgM1iRiAZWEGKHcH52SiMeKm1sEuAkQaIZRcICmOhn3ILOZ+KIFg+di9QQJCfOsIk9906yG2XHwwMubZsKbpjLM6dUaptF8r2zQWeuUKSNd+my4GcJr/Mn5Mo5ABptH5VcVhgYLBnD5PFhKaiW2TT6lU/uOhPdg794UaEUd9VHOKA6LcvsbDc/X+bMckdHjcebzgwWI7HZriffk/1egSVWlyr+3D4KUUrFK4e4AyEttUEAsSm+cBNCQSpMe6mU/UCdL5Hz5UmzQOlN1lJ4pPrPceVOMSRlidKbuZsVO5VGYIOtJ1TeQ5Q8uRDEyNscv4/b2A87/UnWbg==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Gco4U2hgyNP9NSECTieoMkHGmEgI3VDG3FNEuyqMShsQO3NJfHUZKGW9DXKWoY3Um++0wI+0cU0YWEqgyXBG8BXKnhgFaa1zVhjelZepONhEV7euJg29Qk1oAuz5p9I60ALl4zx/++mUSpFPjN/7Gi7KuvHuWvNn7osio4QlUbF3KSs2N43FIDnABGM2qW5p/7IYuNIFWr+LT5RYRKECx/MmQBCQ1Vl0zytiqn1dddhoaPSzxrsP3qo2KfaPsUMtyAz2n8BaD/SdGQKQuD9KWRCZQo/u3XpI4lPVDsOsQoNty9/2I5USP0b/K5Jt/wiblYRaQ9RuxfF5hSduu7S1zwcjoMNML3Jzpv2JSyLbQyF1afGtYDhwAvwhOVAKq8pjiI882NeFHfgGXlUgWNBQsNZ3ANHAVw0ckVunC78dJKPoaK6rRHz4ywWCezAA7JwpW2vZm6qrHhNS6ZVJyvJe2qIGXdL9gQGRrOntvu+8TJESGEspEgYYvMYsA0b4T/MmeVQ8RCKRJNGEpS6IhRnTM3HxA60s4Xc/WHeG8ERamfC/SURfd/AizRXWls4LqKFvQ9oiFm3GMHADtcOtNHRQtv0SRK501pHKbrT6PplemPRZZMz2/QJEjGvfQA1Z1a60
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN6PR04MB9359.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e50fd677-9fd5-41c3-6596-08df2b2251de
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Oct 2026 01:10:51.1714 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bFTf8Uty6g2/eqIThNJbzBeqCMDgdZ6hJZh+ay4C3u7IhrjgoWIDVS3c0x50FykbZ4/aOOxrKWaLMeP0DrpqDqNzbWPkERzZLwPxxn/nqEM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR04MB7476
Received-SPF: pass client-ip=216.71.153.141;
 envelope-from=prvs=742cbab99=Alistair.Francis@wdc.com;
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

T24gVGh1LCAyMDI2LTEwLTE1IGF0IDIxOjQzICswODAwLCBNaW5nbGlhbmcgTGl1IHdyb3RlOgo+
IFRoaXMgc2VyaWVzIGFkZHMgc3VwcG9ydCBmb3IgdmVyc2lvbiAwLjkgb2YgdGhlIGRyYWZ0IFJJ
U0MtViBadmFiZAo+IGV4dGVuc2lvbi4gVGhlIGV4dGVuc2lvbiBwcm92aWRlcyB2ZWN0b3IgaW50
ZWdlciBhYnNvbHV0ZS1kaWZmZXJlbmNlCj4gaW5zdHJ1Y3Rpb25zIGZvciBpbWFnZSwgdmlkZW8s
IGFuZCBvdGhlciBkYXRhLXByb2Nlc3Npbmcgd29ya2xvYWRzLgo+IEl0IGludHJvZHVjZXMgZWln
aHQgbmV3IGluc3RydWN0aW9uczoKPiAKPiDCoCAtIHZhYmQudnYsIHZhYmQudngsIHZhYmR1LnZ2
LCBhbmQgdmFiZHUudnggc3VwcG9ydCBTRVcgdmFsdWVzIGZyb20KPiDCoMKgwqAgOCB0aHJvdWdo
IEVMRU4sIHdpdGggU0VXIDY0IHJlcXVpcmluZyBadmU2NHguCj4gwqAgLSB2d2FiZGEudnYsIHZ3
YWJkYS52eCwgdndhYmRhdS52diwgYW5kIHZ3YWJkYXUudnggc3VwcG9ydCBTRVcgOAo+IMKgwqDC
oCBhbmQgMTYgYW5kIGFjY3VtdWxhdGUgaW50byBhIGRvdWJsZS13aWR0aCBkZXN0aW5hdGlvbi4K
PiAKPiBUaGUgc3BlY2lmaWNhdGlvbiBpcyBjdXJyZW50bHkgdW5kZXIgcmV2aWV3IGF0Ogo+IGh0
dHBzOi8vZ2l0aHViLmNvbS9yaXNjdi9yaXNjdi1pc2EtbWFudWFsL3B1bGwvMzI3OQo+IAo+IFRo
ZSBzZXJpZXMgaW1wbGVtZW50cyB0aGlzIGluc3RydWN0aW9uIGV4dGVuc2lvbiwgaW5jbHVkaW5n
Cj4gaW5zdHJ1Y3Rpb24KPiBkZWNvZGVyLCBUQ0cgdHJhbnNsYXRpb24sIGhlbHBlcnMsIGFuZCB0
ZXN0cy4KPiAKPiBDaGFuZ2VzIGluIHYyOgo+IMKgIC0gQWRkZWQgc3VwcG9ydCBmb3IgcmVjb2du
aXppbmcgdGhlIHZhYnMudiBwc2V1ZG8taW5zdHJ1Y3Rpb24gaW4KPiB0aGUKPiDCoMKgwqAgZGlz
YXNzZW1ibGVyLgo+IMKgIC0gQWRkZWQgdGVzdHMgZm9yIHRoZSBlaWdodCBadmFiZCBpbnN0cnVj
dGlvbnMgYmFzZWQgb24gRGFuaWVsJ3MKPiB0ZXN0cy4KPiAKPiBDaGFuZ2VzIGluIHYzOgo+IMKg
IC0gT3JkZXIgdGhlIHN3aXRjaCBjYXNlcyBudW1lcmljYWxseSBpbiBwYXRjaCAxLgo+IMKgIC0g
VXNlIC5pbnNuIGluc3RlYWQgb2YgLndvcmQgdG8gZW5jb2RlIGluc3RydWN0aW9ucyBpbiBwYXRj
aCAzLgo+IMKgIC0gUmVmaW5lIHRoZSBjb21taXQgbWVzc2FnZXMgZm9yIHBhdGNoZXMgMSBhbmQg
My4KPiAKPiBDaGFuZ2VzIGluIHY0Ogo+IMKgIC0gRml4IHRoZSBjb25mbGljdCBpbiBwYXRjaCAz
LzMgZW5jb3VudGVyZWQgZHVyaW5nIHRoZSBQVUxMIHN0YWdlCj4gwqDCoMKgIGJ5IGJ1aWxkaW5n
IGB0ZXN0cy90Y2cvcmlzY3Y2NC90ZXN0LXp2YWJkLlNgIHdpdGggTWVzb24gaW5zdGVhZAo+IMKg
wqDCoCBvZiBNYWtlLgo+IAo+IE1pbmdsaWFuZyBMaXUgKDIpOgo+IMKgIGRpc2FzL3Jpc2N2OiBT
dXBwb3J0IHZhYnMudiBwc2V1ZG8taW5zdHJ1Y3Rpb24KPiDCoCB0ZXN0cy90Y2cvcmlzY3Y2NDog
QWRkIFp2YWJkIGV4dGVuc2lvbiB0ZXN0cwo+IAo+IFpoaWJvIEhvbmcgKDEpOgo+IMKgIHRhcmdl
dC9yaXNjdjogQWRkIHN1cHBvcnQgZm9yIHRoZSBadmFiZCBleHRlbnNpb24KClRoYW5rcyEKCkFw
cGxpZWQgdG8gcmlzY3YtdG8tYXBwbHkubmV4dAoKQWxpc3RhaXIKCj4gCj4gwqBkaXNhcy9yaXNj
di1vcC5jLmluY8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
fMKgwqAgOSArCj4gwqBkaXNhcy9yaXNjdi5jwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHzCoCAxNCArCj4gwqB0YXJnZXQvcmlzY3Yv
Y3B1LmPCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8
wqDCoCAxICsKPiDCoHRhcmdldC9yaXNjdi9jcHVfY2ZnX2ZpZWxkcy5oLmluY8KgwqDCoMKgwqDC
oMKgwqDCoMKgIHzCoMKgIDEgKwo+IMKgdGFyZ2V0L3Jpc2N2L2hlbHBlci5owqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKgIDI2ICsKPiDCoHRhcmdldC9yaXNj
di9pbnNuMzIuZGVjb2RlwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8wqAgMTAg
Kwo+IMKgdGFyZ2V0L3Jpc2N2L3RjZy9pbnNuX3RyYW5zL3RyYW5zX3J2di5jLmluYyB8wqAgNDUg
KysKPiDCoHRhcmdldC9yaXNjdi90Y2cvdGNnLWNwdS5jwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCB8wqDCoCA2ICsKPiDCoHRhcmdldC9yaXNjdi90Y2cvdmVjdG9yX2hlbHBlci5j
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8wqAgNTYgKysKPiDCoHRlc3RzL3RjZy9yaXNjdjY0L3N5
c3RlbS9tZXNvbi5idWlsZMKgwqDCoMKgwqDCoMKgIHzCoMKgIDEgKwo+IMKgdGVzdHMvdGNnL3Jp
c2N2NjQvdGVzdC16dmFiZC5TwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfCA2NTkKPiArKysr
KysrKysrKysrKysrKysrKwo+IMKgMTEgZmlsZXMgY2hhbmdlZCwgODI4IGluc2VydGlvbnMoKykK
PiDCoGNyZWF0ZSBtb2RlIDEwMDY0NCB0ZXN0cy90Y2cvcmlzY3Y2NC90ZXN0LXp2YWJkLlMK

