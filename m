Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08B75CD5BDE
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2026 00:09:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wS1q1-0007Kt-Rn; Tue, 26 May 2026 20:09:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=6009f06ea=Alistair.Francis@wdc.com>)
 id 1wS1pt-0007KW-0Z; Tue, 26 May 2026 20:09:26 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=6009f06ea=Alistair.Francis@wdc.com>)
 id 1wS1pr-0007a8-BX; Tue, 26 May 2026 20:09:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1779840563; x=1811376563;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=Nv8ewmASDDHRfvra+BWRRZpV2WjDMiBbLNJstpFVgNA=;
 b=nFKjagOgtOAQ4SG0HH+sWXu24zb6o+rK3QZmjBAMUkzlntXO+tHbTfUT
 FHruIAcS6FkcF5ckP6vLctNl81KZkhUfWAk3MaWExwStCGY64Ik9pAmRs
 wt1OlRyUOQ01GNsiQ2mp4/PNXzzj97oT7iVbSo3W6iKivwV7IuN8eOaY6
 f1UCqGAqPjgH9N/jbNl/Vvin0zqF0gOHITiis7gjNme/GZKp0gfYDY72n
 jLa1ZD38vlVo3LzO1JYiljv+F0ZiFswDJtzGkHP8i86GMKrktc5OOnmBb
 BcDyQBfzPIoBeThAtYOeHCQYOSZEBUYN0P+0cePUBdRGKEHXdQ7KFoDlF g==;
X-CSE-ConnectionGUID: HSY5MCgaSUOJ0K0r7GUlpQ==
X-CSE-MsgGUID: lXAX+4uiRpCaFP8bLUZpbQ==
X-IronPort-AV: E=Sophos;i="6.24,170,1774281600"; d="scan'208";a="146342520"
Received: from mail-westus3azon11010033.outbound.protection.outlook.com (HELO
 PH7PR06CU001.outbound.protection.outlook.com) ([52.101.201.33])
 by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 27 May 2026 08:09:20 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HFTCRyXVs9otI3KoCyXXMB4Hlx5exQ67lZcRD892zrjiEAVq/R6z22hjjfdjZ9woHevvDFqLanTsfPRLkRDkyMzK6+IMj1U7Hw/628Z3JecL51uHQTy/V6iLyrnDugLa+0eNdMnr32CzyYCGu7kjdSkxhdHNJtd2wBDT6SrLSouzAbuTPJ9CeajR8UcR/9RNApBBYPCF59xHzmkO/g1FWCRwMUUDTahyjdP2FDKcsYJq74uzaE0wuc7toqJB2OaUTvdTJbGhTWh0zeb88MgjBgICX4iX/zCG6N6Ld2sZZfWu6lf7jrtEgTnQhF82aFq1+GNwgonHhmileO88WGaoZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nv8ewmASDDHRfvra+BWRRZpV2WjDMiBbLNJstpFVgNA=;
 b=P1agEuaU1Y5ksKCebJqeW2Hvf7LwMOO076hzXudHKheSlLU+2PRtXrN1s33+6cZruGKkbn6effZqbplhx/rC9nYadMO2mYBvqjvTmfKJQVEjLjIJPLg80dcQg1eGqAHjvCoT2H8ZE757OXaXghTR96swjMkyJhCEFXarJmqeJwpbv0MIZAclj+63jjhzGjpJTQes+OV49GmnkIPTcrBDx/inHDKVHHNx3A12dtlQJO5CZkJsyEnZx7MHA9EwDpw1+gPZFmo0lTf/+8ULvBP9PLDTb2RZqDhJYEmcsy0mhFjK5VbN7qZ9/MNIvLqgO+HTivnljqna9fOfHrjOZCMiag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nv8ewmASDDHRfvra+BWRRZpV2WjDMiBbLNJstpFVgNA=;
 b=eBLqRL79+xwZlAEIcpwJonuGGIL0GHvWv+f7GxgkJicBOKKVITZE5yg9FRbnFbeArStke5KH0VDkRc0fHd1cCeYRRMGid82odpiY6FM55oGmFMzXAirCdxRAib85L4eArb5hUN1onoZXrNm+zaQbqL+7N/7B8AOZmGFjDGzKBrI=
Received: from BY1PR04MB9561.namprd04.prod.outlook.com (2603:10b6:a03:5b6::11)
 by CO6PR04MB7876.namprd04.prod.outlook.com (2603:10b6:303:138::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.11; Wed, 27 May
 2026 00:09:18 +0000
Received: from BY1PR04MB9561.namprd04.prod.outlook.com
 ([fe80::3869:e494:2fa8:9888]) by BY1PR04MB9561.namprd04.prod.outlook.com
 ([fe80::3869:e494:2fa8:9888%4]) with mapi id 15.21.0071.011; Wed, 27 May 2026
 00:09:18 +0000
From: Alistair Francis <Alistair.Francis@wdc.com>
To: "fritchleybohrer@gmail.com" <fritchleybohrer@gmail.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "palmer@dabbelt.com"
 <palmer@dabbelt.com>, "daniel.barboza@oss.qualcomm.com"
 <daniel.barboza@oss.qualcomm.com>, "chao.liu.zevorn@gmail.com"
 <chao.liu.zevorn@gmail.com>, "liwei1518@gmail.com" <liwei1518@gmail.com>,
 "zhiwei_liu@linux.alibaba.com" <zhiwei_liu@linux.alibaba.com>
Subject: Re: [PATCH] target/riscv: Do not hide Sstc CSRs from gdbstub
Thread-Topic: [PATCH] target/riscv: Do not hide Sstc CSRs from gdbstub
Thread-Index: AQHc6/ArKlcZwID1aU2b+3imczrqfLYhAj2A
Date: Wed, 27 May 2026 00:09:18 +0000
Message-ID: <11b74aa0375e0d8ffc159cf32e9e3ba187a5d482.camel@wdc.com>
References: <20260525024220.39027-1-fritchleybohrer@gmail.com>
In-Reply-To: <20260525024220.39027-1-fritchleybohrer@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.60.1 (by Flathub.org) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY1PR04MB9561:EE_|CO6PR04MB7876:EE_
x-ms-office365-filtering-correlation-id: 3a2f36bc-0986-4a93-cd13-08debb84322e
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|10070799003|366016|19092799006|6133799003|11063799006|22082099003|18002099003|56012099006|38070700021;
x-microsoft-antispam-message-info: HaHDKHEuv4LMOTIEaGLs5Ip/k95nY0z8QJPjrpgCzlafnVXXVz98ap9+dUKkfjRh3LGKDaai1BmDSEUM4YKki0zzWq2eYD0vZ+OSPOh3dQpLnj9jWZo30prNDeaeGGJG5JugJpyU+MIQmRvTX9oFu+xcWm6GZEjHVIntbCcAfFbIt4yePlIFEGq3LIekpAOSKhvCFu7huGbWYRlwCR72ACbTbwSfg5VwQFX0vJrP9ju33NL3Sj9SOZQPJhcnj0hc4AxBOxuVGqnIslzsP30jW4lAkqaT1KTEoP2hc1Sonn1HWTFz+Z4eYhYPj/45fG9Suf9/A5iJ/i+kLCVJ6ypu7wz7KTgu/OtpzcFhcPe2/kLAUcyCvzKsaY13ffo9V6iYS7TpgVhCkRRwzrfDfHaEmPlcdWMF75U7MkSHwCI0kHEZJM9/ThB3vrXZdJW9yknGOtX+LwdBWXgc9FeSrn9SIqtpKusq3rG37NQzs7EVzW6B3KNViVN4jN7V2T4xc0d0lwi+QeC+ZDE/UQg2Fmwz9BtU8fa770NQeGsN1f0eOuGukGtuTn74+XneIykv8FtrNi/hPCiTSQpoHkTgEocKIbLgzFvMBgHjIhztf8I+GF1g+5kpGNrUyfEGkWkmnQ+RUFYgHoLKff2PeJQY3ZX2YMnuQqRjU8fnnZznY6yF1maS1PRVBAmNFd9XcE1a02fefCHhnjcKKtCARPD7pW0GY5OrrSlbG0kozeJrsKhuCodaI+qVWMAVMueyZgE08gIZ
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY1PR04MB9561.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(10070799003)(366016)(19092799006)(6133799003)(11063799006)(22082099003)(18002099003)(56012099006)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VGRtaFdVSDZBbG8zOEgra1VRUG53SFR5VTg5YTRHMExoS0RKMnlsWlliR002?=
 =?utf-8?B?Wnk3akhFaVBScDlLcmtFOTQyVVpseWR2NkhWQ09VbVUvYWpTZGo0N2RqQjcv?=
 =?utf-8?B?dnZEajRXbDgyeERrV25SYXJtWWJpaTNwMTR0U2dCQnVQY1JQQUVRWG00TWMw?=
 =?utf-8?B?TGtGTFpEbGQwWmpHaDVObFhmbmxJY1l1WU1RcklOWTFkYmxXZHhkWmRBSkRL?=
 =?utf-8?B?ZHhTWFBnRG5pOFlrOU5sMy9kbWo1Qi9xRzFURmYveDRHeFZpaUtrSXA4anNk?=
 =?utf-8?B?emlOWDR2MEl4WGVMWlNKRmU1Ukd6RUZ5bU0yVVFrUEsyTlFDejhuN3lpdVJi?=
 =?utf-8?B?NEo0MldVV1NTOHJXYld4ZGtNL3BjUUtlZlpRMXVEa0JzQjhEdTdJWklMWDYv?=
 =?utf-8?B?QklOb29hS2hOM0xNc3NOK2l5T2ZoWUhiYlpibzZrSDIzcmRMaWU0cUp2aDlU?=
 =?utf-8?B?NnFPdDdodGN0MnMrZjhISEJ2aTBhdUR6bXFmYVlLMld2T2w2MTMvN2VNREVa?=
 =?utf-8?B?cWF2TjdPakJwc1BHZjd3SFJHNG1ETm8wa0RDNmpKckhndWRzY0pWeVc1bWVt?=
 =?utf-8?B?RDV6WFZYcGJOR0xzNTVLZDFwRFRqSCtZRFh6MEU2Tk5PdmxKOFl2SVd2UktR?=
 =?utf-8?B?VHk2cnQxa2E5a0lVaDNsYU8xOGRWY21XV3JPeEVVNktWRnFmR1Y3U3dUY3Qy?=
 =?utf-8?B?ZS9xR0xOUHhZL2YrV1FOQUtZbVNmZlhObTQwam5wUEk2NmZsL0E4QjZNYjJE?=
 =?utf-8?B?SGYxbTlsSEFBdlhTc2lJRm16ejV1eHpWeUgxSGJEMnV5cnhDcWtsWVdxa0sw?=
 =?utf-8?B?OHFPZlFwd1dMcTdXdWpubVc0QkNlbDNhdDc1SDJTS1ZpUk10dVN4eHk2dWUx?=
 =?utf-8?B?UlJDK1dEOXRDTURLKzdHNDlweElZeFhCd2poQVhUa3JnZElYbW5MR0IvVW1N?=
 =?utf-8?B?VzBjZ2RPOTlvdGNlSmVDZVFHV3hRNG5jelVGK3BuZDMyOG9PMi9lbGxVTkNQ?=
 =?utf-8?B?VStpVkt4alpaOXYybmZLMGxsYXZidG1yOG1sVHZ2eWFCdGYzNnVoRkcxYVEr?=
 =?utf-8?B?YzZEMjNYajNjdFdBLzVpdjd6QjJMTG1NUERHbGxBSzcrTjd1MlNTcURXK2lF?=
 =?utf-8?B?dzJScVlpdnB4cE9tSFo5T1NzRGZvbElGaFA4MHk3ejNWOC9jT0NwMm5KTnFW?=
 =?utf-8?B?MzBNT2RxMUtkU3p1dzEwTGVhdVNJc3YvRGE4VGhUODU1RDlCYWRvcE45MUcw?=
 =?utf-8?B?SEI4TDZjQjBXVmNIVUMwZlEyaHo4RktpWWo0ZU9VVUZ3T0wrZzRyOUxsUnY2?=
 =?utf-8?B?VnFKZWRKOUtUMWhlQWtIcmdGSmRCL2tDcmxXUVRWTVV1TVZyL28xRXA4WDQr?=
 =?utf-8?B?NnZndVhrcnI1eVVhaHZIbVVtNlYveE1qVUJyN25CS0lkK3F1Sm95NklLNGtz?=
 =?utf-8?B?SHh5TG51eENOeXR0Z2htc01lc2FzRlhOczZvUlV6eUNRTjNVTHNLVm5yQzJI?=
 =?utf-8?B?TGZpODdzd3RuOFlXRjMxZW1JaThCK0hWYnMyMXc4ekYxWEIyYVFhd083U0p4?=
 =?utf-8?B?bFBzU3pQVFVPR0dWMWp3T2R0emRhVXVuM21PNUtpUjFWZi9IaDJiL2MyU0ZD?=
 =?utf-8?B?bkNhZ2NRTUI5aHNoaERiR3VpWDNQTHcyRjZCUnFHUHBySDlPZE42M2IxLzEw?=
 =?utf-8?B?WjRQRUZSQ21EZDdVV3hYOUQ0bHhvQ0RPMlVjOGloclFSajVlWWNZYTdycExn?=
 =?utf-8?B?WG1YaGphWVRWVnVONDdsUktHREd2UGRHZERXMlcyN05sTFNXQ1FaSHdmSVJJ?=
 =?utf-8?B?Z0RtZGpsSzNXeW4rdHJ2YmpFdGh2UXdKUmZtZ1hDS1RzdXU2RXVMcVBaM2FV?=
 =?utf-8?B?bnZRRTVlMStFcFpSZ1dYQzJiNFZpQkNOdXpWNENPRnJQV0ovQkhibUNNTG9P?=
 =?utf-8?B?ZStrcndHaEtVanc4ZmVRVjI3RHhnc3FYUjl4V2wweStQNThER3lMb01CTnhP?=
 =?utf-8?B?ZUlaNFl4dmpvOEtLd3dhaC9oRmRYMmpDVFhPTWZXdE5pMnlaNHM5dW1XNHgr?=
 =?utf-8?B?TjBObnJzc2RZV2hJREg0eGZvU3ppUzRmZUhyYnpQY2ludnNMNmN3YVFVbllO?=
 =?utf-8?B?Uy9ldXlxMGdmMFJlOXRKc3pJNTF0UlhUU1p3ZVIyUzJVMFo5NEpRK2traHpr?=
 =?utf-8?B?eWd6Z093R2Jsbm9Ta3hDTkVxbTRvTUtpbTQ5VXdieTZOdGFDVWRMaHhEZ2Mx?=
 =?utf-8?B?dlRhaTl0cndFZm5qL3Q0TDcyL3ZPU0JZTGRGNkc2amQxV21PdGZKakY3cXVj?=
 =?utf-8?B?ejNjL2hqQnpCSWxreGJvZGowT1U2NUhnK3JNOVJYNlQ4ZVhacW5TNkpzSndN?=
 =?utf-8?Q?vq/azrUu/OSar0bpfvmAG5wXkHC3t44UdLHrlg6taKOJ6?=
x-ms-exchange-antispam-messagedata-1: dTfKVnVRJdcXcxrSzKpG4PKLhwfTARhO/Ks=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F0595C1E9809A944846F96BD88CA34A8@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: dQ1xkXkzJ8HcT0hCu/OQp6ys+q6CR58intyOgY8RbMAAzautObceuH2WcWFE1/iuwAJSYe5uh12DOmEa/QRnSXJVeOn+e2/RyAWRype4aGSv3gcIQEnoS3iEVy5BcX7arqbGvuqqw48kUU6m410n5yQ88xGV5kyaXlF5QNtj2sDoMAyXr9L4BLcQ41K/rBFBLHG4Dqyuq8TAconLVvY48yuT2dY2W+kCz02J1Cj/oHxTUfQFX26duYY1Cp1KG1L6WK21ENprHTqchUPxv14sBslqXWNLx5zlO51q/vu5UPh8MZqU+Y5MKLOYJPHLkiMv+KKspjnvROvbZK3HqdG66g==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: d1xwUfrD13jCRkulO1kgvoU6dQX79togsATe4JiQui1i/1RA+gm0s4WNEVwTN2oBZwLgPKI769VNr/DASrpPek8fcpYlD5CjcZHJdrucj+8JPKAKVztPVu0oCd9jYoX7G2IYgHqmWK2DHyU6aR60voTg3p7YFHaFAFzD7RWygPZMzgwvJNVI4peqGasakc1CzWAiVoR6JInzD+Sf1ZLA/nzBVKRTVpIsTTtCK+MTgApby7U1ClI0lX3ADJbic4E+mz6iQZH+MXhR0CPj4lZZnxPdfTgE6JS2TCMy7aUhLWs4/suC51KzNwFlKb/lBsvILgSsMtUdDGB3KcKqr+wNh5oLqDIRR5Zyu3xS97TTzgDODORiH0+QNo9/xr0L4gMebxFbOGt1juBxkW/0vm6aFCiUPnXotck2XFotw2NxOehDwXT/EtuHHTiOriZ9QIaHQfoMJ/kBDKCm2MVKZvU4dOZoHKoUf+R1OWRwCNyXKcoi6qrzrCVhmU1b7qxIk46E/5NVRFYDqJEvICw4bzzv2IVHcym6sLkgYgsbjbCuV2bbBUBSAYmK+kNa2JdGx2zwn70sGW0DbFamrVCktOM919ZDPBEJfL7heNkzpClffyF/1Zdf/ToNbVE6zuChjTGp
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY1PR04MB9561.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a2f36bc-0986-4a93-cd13-08debb84322e
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 May 2026 00:09:18.4856 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: coLL7AeLQcQSZraQfsjp24Pp8RXSE6kDgZqPhJrCjSfDnL1LkDLWdiQLFuBChHodE3EhwoSWJDJPiCuGeWUl6ITUq3/xitGk4W6CjLNnhk0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR04MB7876
Received-SPF: pass client-ip=216.71.154.45;
 envelope-from=prvs=6009f06ea=Alistair.Francis@wdc.com;
 helo=esa6.hgst.iphmx.com
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

T24gTW9uLCAyMDI2LTA1LTI1IGF0IDEwOjQyICswODAwLCBaZXBoeXIgTGkgd3JvdGU6DQo+IFRo
ZSBTc3RjIHByZWRpY2F0ZSBjdXJyZW50bHkgY2hlY2tzIGJvdGggZXh0X3NzdGMgYW5kIHJkdGlt
ZV9mbi4gVGhpcw0KPiBjYXVzZXMgdGhlIGdkYnN0dWIgQ1NSIFhNTCBnZW5lcmF0aW9uIHRvIHNr
aXAgU3N0YyBDU1JzIHdoZW4NCj4gcmR0aW1lX2ZuDQo+IGhhcyBub3QgYmVlbiBpbml0aWFsaXpl
ZCB5ZXQsIGV2ZW4gaWYgdGhlIENQVSBzdXBwb3J0cyBTc3RjLg0KPiANCj4gQXMgYSByZXN1bHQs
IEdEQiByZXBvcnRzICRzdGltZWNtcCBhcyB2b2lkIHdpdGggYSBDUFUgdGhhdCBleHBvc2VzDQo+
IHRoZQ0KPiBzc3RjIGV4dGVuc2lvbi4NCj4gDQo+IE9ubHkgdXNlIGV4dF9zc3RjIGZvciB0aGUg
ZWFybHkgZXhpc3RlbmNlIGNoZWNrLCBhbmQga2VlcCB0aGUNCj4gcmR0aW1lX2ZuDQo+IGNoZWNr
IGZvciBub24tZGVidWdnZXIgYWNjZXNzZXMuDQo+IA0KPiBSZXNvbHZlczogaHR0cHM6Ly9naXRs
YWIuY29tL3FlbXUtcHJvamVjdC9xZW11Ly0vd29ya19pdGVtcy8zNDk2DQo+IFNpZ25lZC1vZmYt
Ynk6IFplcGh5ciBMaSA8ZnJpdGNobGV5Ym9ocmVyQGdtYWlsLmNvbT4NCg0KVGhhbmtzIQ0KDQpB
cHBsaWVkIHRvIHJpc2N2LXRvLWFwcGx5Lm5leHQNCg0KQWxpc3RhaXINCg0KPiAtLS0NCj4gDQo+
IFRlc3Rpbmc6DQo+IMKgwqDCoCBTdGFydCBRRU1VIHdpdGg6DQo+IMKgwqDCoMKgwqDCoMKgIHFl
bXUtc3lzdGVtLXJpc2N2NjQgLU0gdmlydCxhY2xpbnQ9b24gLWNwdSBtYXgsc3N0Yz10cnVlIC1z
IC0NCj4gUyAtbm9ncmFwaGljDQo+IA0KPiDCoMKgwqAgQmVmb3JlOg0KPiDCoMKgwqDCoMKgwqDC
oCAoZ2RiKSBwICRzdGltZWNtcA0KPiDCoMKgwqDCoMKgwqDCoCAkMSA9IHZvaWQNCj4gDQo+IMKg
wqDCoCBBZnRlcjoNCj4gwqDCoMKgwqDCoMKgwqAgKGdkYikgcCAkc3RpbWVjbXANCj4gwqDCoMKg
wqDCoMKgwqAgJDEgPSAwDQo+IA0KPiDCoHRhcmdldC9yaXNjdi9jc3IuYyB8IDYgKysrKystDQo+
IMKgMSBmaWxlIGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPiANCj4g
ZGlmZiAtLWdpdCBhL3RhcmdldC9yaXNjdi9jc3IuYyBiL3RhcmdldC9yaXNjdi9jc3IuYw0KPiBp
bmRleCBkYTM2NmNmNTYyLi5jMTdkZjE0N2Y3IDEwMDY0NA0KPiAtLS0gYS90YXJnZXQvcmlzY3Yv
Y3NyLmMNCj4gKysrIGIvdGFyZ2V0L3Jpc2N2L2Nzci5jDQo+IEBAIC01ODYsNyArNTg2LDcgQEAg
c3RhdGljIFJJU0NWRXhjZXB0aW9uIHNzdGMoQ1BVUklTQ1ZTdGF0ZSAqZW52LA0KPiBpbnQgY3Ny
bm8pDQo+IMKgew0KPiDCoMKgwqDCoCBib29sIGhtb2RlX2NoZWNrID0gZmFsc2U7DQo+IMKgDQo+
IC3CoMKgwqAgaWYgKCFyaXNjdl9jcHVfY2ZnKGVudiktPmV4dF9zc3RjIHx8ICFlbnYtPnJkdGlt
ZV9mbikgew0KPiArwqDCoMKgIGlmICghcmlzY3ZfY3B1X2NmZyhlbnYpLT5leHRfc3N0Yykgew0K
PiDCoMKgwqDCoMKgwqDCoMKgIHJldHVybiBSSVNDVl9FWENQX0lMTEVHQUxfSU5TVDsNCj4gwqDC
oMKgwqAgfQ0KPiDCoA0KPiBAQCAtNjAzLDYgKzYwMywxMCBAQCBzdGF0aWMgUklTQ1ZFeGNlcHRp
b24gc3N0YyhDUFVSSVNDVlN0YXRlICplbnYsDQo+IGludCBjc3JubykNCj4gwqDCoMKgwqDCoMKg
wqDCoCByZXR1cm4gUklTQ1ZfRVhDUF9OT05FOw0KPiDCoMKgwqDCoCB9DQo+IMKgDQo+ICvCoMKg
wqAgaWYgKCFlbnYtPnJkdGltZV9mbikgew0KPiArwqDCoMKgwqDCoMKgwqAgcmV0dXJuIFJJU0NW
X0VYQ1BfSUxMRUdBTF9JTlNUOw0KPiArwqDCoMKgIH0NCj4gKw0KPiDCoMKgwqDCoCBpZiAoZW52
LT5wcml2ID09IFBSVl9NKSB7DQo+IMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuIFJJU0NWX0VYQ1Bf
Tk9ORTsNCj4gwqDCoMKgwqAgfQ0K

