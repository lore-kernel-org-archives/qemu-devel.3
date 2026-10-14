Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4225DCA9EBD
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 04:00:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGq9K-0007nd-HL; Tue, 13 Oct 2026 23:59:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=740cf4029=Alistair.Francis@wdc.com>)
 id 1xGq9H-0007nH-WE; Tue, 13 Oct 2026 23:59:28 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=740cf4029=Alistair.Francis@wdc.com>)
 id 1xGq9F-0003Mz-PB; Tue, 13 Oct 2026 23:59:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1791950365; x=1823486365;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=oDVECGz11FkUalEPJsH2vbHTCHTdPzYNwM7nl55sOdk=;
 b=YhuxRnlvQ5Z9x8pgwGRRAaTsp/h5fotIC17WTyabslPeKQE85RfQ+XdS
 W+4en9u5uTpAQzVY+bfLDmder+HgyzLLBJDEeEa3d1Oq3xf6caY9bG5js
 PmA2JS832QJWYwrn9i6BA5f9Z7/mkY2a/1GWGTiZaEV0yBbCC0ElZWDb/
 ZpY2zGWFjDBtWpJYpJ7IKvlTU24yMEes1tvgvgswfWRWkNpCoYM5lbZHn
 ZeIj0q2+7gIE7YPaeaFRbhnU/4RuKj738BUhV8j9rbTT7BRxUrt065FTX
 FFoPTBPRxr0O2YsUSdbXvy3gH+3eUhljDNsApDOEl5Pq0zfGCjlruhqrt w==;
X-CSE-ConnectionGUID: sayybN/0QYqlNXbkw8HRow==
X-CSE-MsgGUID: FlFKHj9rQ/a14A6eJ/u8qQ==
X-IronPort-AV: E=Sophos;i="6.27,157,1786982400"; d="scan'208";a="157085910"
Received: from mail-northcentralusazon11013003.outbound.protection.outlook.com
 (HELO CH4PR04CU002.outbound.protection.outlook.com) ([40.107.201.3])
 by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 14 Oct 2026 11:59:20 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j4GtdjIj2so6PHhWwAQ1Z/HKoA/THZ9NVRne6+cRemiCkE3rX48ayZm45va02iIVzXms+uVzOMc6V1Iai5F20Zg2KYc7sEjE9T7QZ7POC1Ag5sVmGZP/9RiylderkaMhHqI9xVKFUQr76eKTaK2LBdm+XHTccb15j3KJi8ZFIqtPNhb95+ZrEL3ZbwP8ONy0aX54eY+Bi59KdFteQ0jxB3aTGdAQrDCdckBhCkZ6hlfGgwN44rsZbEXzW1XJIyUhZ5FS2apWK85MGGIx1cw4jfeVUfPTVn2Bw/N+74LnvCXmL16l0ZriyNNDayYMWPsiNJHMhNcc73p7vPDz4Cpa8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oDVECGz11FkUalEPJsH2vbHTCHTdPzYNwM7nl55sOdk=;
 b=VPRY0wfrQ3VhoSBZdM9kIz8MhTAcxEOeOhN3HFYa9wVdWX85yancG+bXECd8wYOH0F9XbYhVr2MSDKmnWXomr4Ne1oOqNA8grmz5Wjhh2uII1auCuDKwGTLScmlsI5SY21jhOhMB51Zvp6s8xKnOYvXv2qeT/tXndgHJ7eq8KKx3kJ/AFATh0LXX116TrKU+5pVcxx3a/fmfmdrOUZTThwmk+qkYqXyHLSwwU67Uj43Tf69W7xWfB1T+fK6P/NL/1tWMBIeI5eHi3z6/Lt4nH2Oyv4lR4pcNVDMd6SNJ7FZvUmOer1hpX1SptBP5tJwG5qq0e/3lYHW58AD22iH7/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oDVECGz11FkUalEPJsH2vbHTCHTdPzYNwM7nl55sOdk=;
 b=OqHjjFVb9ojhMa8AGnJ5gaPcbcfBJCbdMT6FNA08ypeEIxy9NjZ8cr5q9goRiM7XGcUv1GhL7DCyJzEz0og38GZlKx0y0s8z71yL7xNB4iHs1pIHdUUuWtsVoD5iz/kYB4J0fdcDfYFNBCgjabpTiWGsKJTE5T5+YpY/wt7vlFc=
Received: from MN6PR04MB9359.namprd04.prod.outlook.com (2603:10b6:208:4f2::13)
 by PH0PR04MB7687.namprd04.prod.outlook.com (2603:10b6:510:56::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.12; Wed, 14 Oct
 2026 03:59:17 +0000
Received: from MN6PR04MB9359.namprd04.prod.outlook.com
 ([fe80::e729:bbef:5a37:2e77]) by MN6PR04MB9359.namprd04.prod.outlook.com
 ([fe80::e729:bbef:5a37:2e77%4]) with mapi id 15.21.0522.012; Wed, 14 Oct 2026
 03:59:17 +0000
From: Alistair Francis <Alistair.Francis@wdc.com>
To: "portias@oss.tenstorrent.com" <portias@oss.tenstorrent.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "joel@jms.id.au" <joel@jms.id.au>, "npiggin@gmail.com"
 <npiggin@gmail.com>, "mpe@kernel.org" <mpe@kernel.org>,
 "marcandre.lureau@redhat.com" <marcandre.lureau@redhat.com>,
 "daniel.barboza@oss.qualcomm.com" <daniel.barboza@oss.qualcomm.com>,
 "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>,
 "chao.liu@processmission.com" <chao.liu@processmission.com>,
 "asrinivasan@oss.tenstorrent.com" <asrinivasan@oss.tenstorrent.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>, "liwei1518@gmail.com"
 <liwei1518@gmail.com>, "palmer@dabbelt.com" <palmer@dabbelt.com>,
 "zhiwei_liu@linux.alibaba.com" <zhiwei_liu@linux.alibaba.com>,
 "pierrick.bouvier@oss.qualcomm.com" <pierrick.bouvier@oss.qualcomm.com>
Subject: Re: [PATCH v4 1/3] hw/riscv/atlantis: Use dw8250 UART model
Thread-Topic: [PATCH v4 1/3] hw/riscv/atlantis: Use dw8250 UART model
Thread-Index: AQHdW4t4ISsD2cQXCUG/+t839iE6Wrb8aakA
Date: Wed, 14 Oct 2026 03:59:17 +0000
Message-ID: <909a298130043a59f8f1cef6a43abdea12e31ce5.camel@wdc.com>
References: <20261014032346.732257-1-portias@oss.tenstorrent.com>
 <20261014032346.732257-2-portias@oss.tenstorrent.com>
In-Reply-To: <20261014032346.732257-2-portias@oss.tenstorrent.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.62.0 (by Flathub.org) 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN6PR04MB9359:EE_|PH0PR04MB7687:EE_
x-ms-office365-filtering-correlation-id: 12ef3e1f-e27a-40e9-3f44-08df29a78490
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|19092799006|23010399003|376014|7416014|1800799024|366016|10070799003|22082099003|18002099003|10067099003|3023799007|38070700021|11063799006|261009223327099003|261009221227099003|261009221727099003|261009220027099003|4143699003|261009223027099003|56012099006;
x-microsoft-antispam-message-info: 9H3fdsC2wnBltwLm0oKygNanWRP6TEjC7G1j6RS9QV59npPqoYUdMbNPYQ5QQXGWqRUT9yRZGDkcDEw4fqdf6uWpfVt05pzMMHSqKmb6tN2fJ6hxlUAv4c/dmINQLrhAMcVJwHpP1xKhPbfPnGLb3HP+sdIMjU5ZkglIVxVr8b7jnTk0z0apqOuD5zaaH/oIsEBHmrdQNyVqiG9P+NbZw3djKu3BxUwMqkrvLxA5lpK04r74Eq2W0HWWeaJr6GSzH5GSA4/R6B2HYMzGNI8uJai4K+hOb+4EBEp4FHwykYxSFYeh2jb9Heuq4XfK3EbVP84eI7lXgwZXOtaBoXosNy0ONPRTFann/wRhXW5+/LlKDQjDAohjvM9X2YjYwykISqOcoRcVLnTUfZhuU+RttYvuSyVrq/P/YTtcm9/H598A693N700cduvaTCHzK4RhJOS80dWHGRiwadEJs4+JpKDruqRO1OkOG1mps0iL/nlluW0e95zTIbrnB8hK8C2IXO1ck+OEDDs1OGhTREHp7QGRjpXA+tdHt2pLObdcUO5PGh1JlyShZ5rzy7KRKUDkwnPKzUuDwRTPQRcl1ug9QYvOUDNCzxSyhbVn5j6TDy/pwbygCq+r3//GLxyDV9+UzB7Vj7Fh20QsAmyujQmLAM4rVucOYVGVHxAJDI0p5Dwv+bqpKfDkOtYW7SOszVW7zImpAgiAN127vwSgvpZo4q02A245umxzJUYS32Fq07U=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN6PR04MB9359.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(23010399003)(376014)(7416014)(1800799024)(366016)(10070799003)(22082099003)(18002099003)(10067099003)(3023799007)(38070700021)(11063799006)(261009223327099003)(261009221227099003)(261009221727099003)(261009220027099003)(4143699003)(261009223027099003)(56012099006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Y0hyK0ZVWkxaS1NTanpHbitKQ2FUb3Z3MVRFYy82MXo3RHVWUWJqR3duVjFp?=
 =?utf-8?B?YnI0cFZEVmVablpnQTlrbERRY2dIVy80NmZZdVJ5THFZSytYT01WY1VxWU1t?=
 =?utf-8?B?Q3NKbVFEMmtqSXA3dnI2VFdrVEE4WjZyTTU4TjhOTmZjaGt1Wk52eXpiMFVi?=
 =?utf-8?B?c0l6R3piRC9TNmRKYU9KZmNqcHI3emdwUmFpRTNiV1NRdGE4ZDFuQUdOb2pO?=
 =?utf-8?B?Zld2YUROajdCTXEwMEdLNmE2ZDBIRlQrVm9TdHNNSkVOdUdkQXdKR1FnTTgy?=
 =?utf-8?B?Q2VnUkRIWnhBNGlycDVhd3JYZGtFUEdQeEtHTjFVUlN4V2gzUE9USDRwd0ps?=
 =?utf-8?B?ZjJEMGZxWXpLNkZ0TGtLSHMrWnd6WDl0bjE0dlJxZzE3UEFwMWRsZ3BUQzdQ?=
 =?utf-8?B?L3dmTU5JZyt6ODdqdTkzUFVnN0xRa0tUMXJxRXVJbG5mSWZvcExoejU2VXpp?=
 =?utf-8?B?NjQ2dWFNWFczRXI4OFlxbWs0dVQ5UnlzdmxVOVJHdHI3Z2hic0h2KzJvQ0xX?=
 =?utf-8?B?N2M0NG1YajU1dVpNeVQxcWdQa3hOcFlZOFVmL0dWemFteUpiTEcxY2tFbENF?=
 =?utf-8?B?cnNLeW4yTWNsN3AxOU5OeTdqZzBoZGRMZnh3eUttak9JWHRZcGFrSjhhTnRy?=
 =?utf-8?B?REZDSzFvMm9KcmdiUmdSUkIwS3FBOUNSS3ZERkVQaXh4alpadDRYaXo2RURi?=
 =?utf-8?B?ZUVXRWEra2FPSkNZMnp0bkNTeml3VHI3ZEgyWkZiNURtU0dRTWJ2cDlyR2Fv?=
 =?utf-8?B?SXVlUSt0bGxWWVdrTm9VdHk1OTBMUWp4cm5QOXA4SFhGLzFRTnYwaTMyK1pz?=
 =?utf-8?B?dWxkb2o1VmlNVFgzcFpFYkNGRklWaThNbmFTMlMyazBqZTlUSXVOSFlIWUFm?=
 =?utf-8?B?bEFacDR2dEdIS0MveXJPRk9EeVpBVkFOM1JhdDdPbVkzZElXV01qN2RYc1FJ?=
 =?utf-8?B?Um5EQmJFQUJwS29wSE9LT2lvNHYrbXFFeGFiMlNscDYrQmdxT3VybXlkUDB3?=
 =?utf-8?B?REJWWHJaWS83dmNLbEs3VlI5NjQ3V2IwRWhyTW1ZbS81OHpwNE0wcnF5OWVB?=
 =?utf-8?B?TVExY3VhUDhINlh1Z1lsempXWnVCWE1vTmNnVDRpajZWWGZWOU1PTUd3NzBi?=
 =?utf-8?B?QTM3QkxPR1J4ZE1xSVZEV3kwRlJKNExMNlRNUWxNM1JGOWc1dFppRWlBZ2lF?=
 =?utf-8?B?WXhVaG4rbEpDMlVOMm5VUFF1YkRWeXJRaTcrTXAycHJSU0lvYjdPMlBoV0o2?=
 =?utf-8?B?dCtXVnMzQXNOcm0yemZKSmRKWjV4TFJnSjliYjF5ZDBLbGR4WWJEbGJTNngr?=
 =?utf-8?B?akRVODNiVGxCN3hHbmhMVmYxOTczM2cvMGlWYnUzbHY3eEt3NXZUMVptWGhs?=
 =?utf-8?B?U2Y3aHlWNFU1V2FVdjdPZmN1ZkhzdjFESUZ4TittR25Oc3NrMGQzNHlrekV6?=
 =?utf-8?B?V2dRM0JNMHFtUzZzM2VmbkJKRUlia1NxbmtWY0dTQkFTbjdtL051dnBWYmhY?=
 =?utf-8?B?Q09GQzR4cE8wRTdqOWJQRys2ZW1IeDE4YkgzdjlReFU0L3AxbkZOajl4WW9G?=
 =?utf-8?B?b1l5S3YreXZDU3dlWFU2cElNTVRMcDFjcUF4Q1Z0bVpaUWtPM2ZzOVg2T0VL?=
 =?utf-8?B?SkNTclpBemErUndDTlJLcGwwZjVWbkduUkZqOG5Cdmt4bHB6N1Z4bzZNSERI?=
 =?utf-8?B?eFptOXVmUHljdHREellxT25pZkdwRXlybGNUaXBLcVNlVlpZUWtXLzFGNzkr?=
 =?utf-8?B?WmRka1VNVWVOa1JEam85NFplL3MzSTZmZi9rVEM1eFNCSkMzbnVSSGpyMjVJ?=
 =?utf-8?B?WE1lRU85TTUyWXMyRjBQWVVkeXJXbEpmQm9BY2NGaEpzNWsxcHBEL1BMUStH?=
 =?utf-8?B?eVh0TmF2RHQyWnJ2UFkrSVh3VDNXRm1qZTJpeVhSRXorb2dvYVJiemdDU1Ix?=
 =?utf-8?B?a05CZk1BYjhCMFBtUVoyeFhKbVZpbWJPZHNYZy9SMUNXcFpsOXh2ampKdkhv?=
 =?utf-8?B?akpDbkp6dE1ZWUxCcjJwZGpFd25zOGFlaDdEV3Q1NlRjS2Q3dXEyUWd2b3VG?=
 =?utf-8?B?L3R5NlVHRi9VMUEybkNQZVZmZ251cWowcWJ3Q1NSamZBSEdQZUlQQzFoYmlZ?=
 =?utf-8?B?WDA0bkhYUUx5Rjl0Ni9RTXQ4ZmRDU0pLZk9zTFFIZVVGVTdHRFRmVlFSL3BF?=
 =?utf-8?B?bnVWNFpRNFpxbzR4UE10ejIyQ3FWS0hKZEYrZUJSbm9tdDVKNTNLb0R5Qk9H?=
 =?utf-8?B?cy96Q2dYZ0VFTmNCZzYwZTFuYkRnTlNBWEROUzVOczQ0RU9XL2taQUtDUXZO?=
 =?utf-8?B?dkFMZTZ4VWF4U2hPOFQ1djFrMVlJWEJST3EyM1d2WWFJNmRSa3pvS3Y2dDVi?=
 =?utf-8?Q?ShiRHLbCRf1glDJKsVr4gCqeATDBXz5OVUxOko9Q20pyy?=
x-ms-exchange-antispam-messagedata-1: dEPeFc7UpATNkdgfTpX/2U3QQrnydMGEx60=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3E036AAFE33E744685F8DDF7B4D0B7E1@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: QmSgaZEmZW12pMDnzJWvT0lGVExb45CQnmE+2wWGtHqNgb9MXOHu2iFMm3poJRjYzm3T0yf71qtiBSE8b2B6+1ULr4yulv/uCc69fw9Y5ptuVOlHLJ5S19le8Yxl7FKypF4hphGA6+8uH2c5ORikwl7LebX2WqTAb32mQmn8PKrXOIPmi6cWXjrVypQNSiS5vHesjcDIR/Qo1+OYA2y+E7PXfc7xKSFBdkB8980Jmw7Gx/SOZX+7Gsj+r7AlJxLq98uN1wQkqQEx3WIeOmA+PhWZ186WuR7kI8d8Ibz6ezG1V8Bk2icnnPJUXB/wZSdy82SW2rDWxPD4d9+gT3Wsew==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: LJTTIe+tIxVg89bFvsoOCERd4uToibvLCTuraUIeYll3YFvVcb8fnNfLzFGvUUhuI+g7fL6cnGWHYGNct8fusPDOH7gNzePmU6pXW3Zqo4iGzOh28DQgF3NHFP/FMJEBOOl7ltF0jHTYtaDs7XpGsjL/zj83umyMq2rMq/oTJo7+Us3KWg7uwLmVLhPszwvvngFDrqm6N7xXIKEZQAc9aCz+eylrkWjdWvni+IEv764qfc7FS/CoqsnryeMAzFptfvohM8oVJrDSnq08y6TBSD+2pBDpuFxb7GdXpQeAB/WfTVEwBspFmYOiFjZsInJQSDV7858f31zOgQx25Z53pqJhuAiGokaQztMPFyMh++1xOHW33m0O7RCNX5RTsLFObjSYjs9EAsD7a87gq3+ip6GjLdGCJSBT8OaTaRWPQQv6Cto5bCe+YJTSAZfWvHmcfQEXRUr6x3XrKJTgen8yylR67KuNJnHXh40iZ1gSMxIwvV8HsjmjRAbXEYKeE2p0gPfHRpSwcO1S+nCAxnAdwxu24mjp61pNvzpEHJz8YZ0QLRV1XKKHXBBXvV/RsR03vopOPeHIMyUW2yU6D4+FSIej7aJp1IwJgh7gLPcf/p3t31Vfe2r1z4W0N2GraCKl
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN6PR04MB9359.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12ef3e1f-e27a-40e9-3f44-08df29a78490
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Oct 2026 03:59:17.0159 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1vz24aK9JEHrigaDpjMe8LizuNe9rF0rSPTeSrA8zDK6ROp5zs5ICMrcNQlp0rRHldJ2GGOHA3WPEm2zg7wTTEKX5AZnFJ+PAIQn7fqcuik=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7687
Received-SPF: pass client-ip=216.71.153.144;
 envelope-from=prvs=740cf4029=Alistair.Francis@wdc.com;
 helo=esa5.hgst.iphmx.com
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

T24gV2VkLCAyMDI2LTEwLTE0IGF0IDEzOjIzICsxMDAwLCBQb3J0aWEgU3RlcGhlbnMgd3JvdGU6
Cj4gUmVwbGFjZSB0aGUgbnMxNjU1MCBVQVJUIHdpdGggYSBEZXNpZ253YXJlIFVBUlQgbm93IHRo
YXQgYSBtb2RlbCBpcwo+IGF2YWlsYWJsZS4gVGhlIGhhY2sgd2hpY2ggc2V0cyB0aGUgcmVzdCBv
ZiB0aGUgVUFSVCByZWdpc3RlciBzcGFjZSBhcwo+IHVuaW1wbGVtZW50ZWQgY2FuIGJlIHJlbW92
ZWQuCj4gCj4gU2lnbmVkLW9mZi1ieTogUG9ydGlhIFN0ZXBoZW5zIDxwb3J0aWFzQG9zcy50ZW5z
dG9ycmVudC5jb20+Cj4gUmV2aWV3ZWQtYnk6IERhbmllbCBIZW5yaXF1ZSBCYXJib3phCj4gPGRh
bmllbC5iYXJib3phQG9zcy5xdWFsY29tbS5jb20+CgpSZXZpZXdlZC1ieTogQWxpc3RhaXIgRnJh
bmNpcyA8YWxpc3RhaXIuZnJhbmNpc0B3ZGMuY29tPgoKSSBoYWQgcmV2aWV3ZWQgdGhlIHByZXZp
b3VzIHZlcnNpb24sIHBsZWFzZSBrZWVwIHByZXZpb3VzIFJldmlld2VkLWJ5CnRhZ3MgdW5sZXNz
IHRoZXJlIHdhcyBhIG1ham9yIGNoYW5nZQoKQWxpc3RhaXIKCj4gLS0tCj4gwqBody9yaXNjdi9L
Y29uZmlnwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8wqAgMiArLQo+IMKgaHcvcmlzY3Yv
dHRfYXRsYW50aXMuY8KgwqDCoMKgwqDCoMKgwqAgfCA0NSArKysrKysrKysrKy0tLS0tLS0tLS0t
LS0tLS0tLS0tLQo+IC0tCj4gwqBpbmNsdWRlL2h3L3Jpc2N2L3R0X2F0bGFudGlzLmggfMKgIDQg
Ky0tCj4gwqAzIGZpbGVzIGNoYW5nZWQsIDE3IGluc2VydGlvbnMoKyksIDM0IGRlbGV0aW9ucygt
KQo+IAo+IGRpZmYgLS1naXQgYS9ody9yaXNjdi9LY29uZmlnIGIvaHcvcmlzY3YvS2NvbmZpZwo+
IGluZGV4IGQwNmFjMjY2NDguLjVkMmFiZGJiNjcgMTAwNjQ0Cj4gLS0tIGEvaHcvcmlzY3YvS2Nv
bmZpZwo+ICsrKyBiL2h3L3Jpc2N2L0tjb25maWcKPiBAQCAtMTI3LDcgKzEyNyw3IEBAIGNvbmZp
ZyBURU5TVE9SUkVOVAo+IMKgwqDCoMKgIHNlbGVjdCBSSVNDVl9BQ0xJTlQKPiDCoMKgwqDCoCBz
ZWxlY3QgUklTQ1ZfQVBMSUMKPiDCoMKgwqDCoCBzZWxlY3QgUklTQ1ZfSU1TSUMKPiAtwqDCoMKg
IHNlbGVjdCBTRVJJQUxfTU0KPiArwqDCoMKgIHNlbGVjdCBEVzgyNTAKPiDCoMKgwqDCoCBzZWxl
Y3QgREVWSUNFX1RSRUUKPiDCoMKgwqDCoCBzZWxlY3QgREVTSUdOV0FSRV9JMkMKPiDCoMKgwqDC
oCBzZWxlY3QgRFMxMzM4Cj4gZGlmZiAtLWdpdCBhL2h3L3Jpc2N2L3R0X2F0bGFudGlzLmMgYi9o
dy9yaXNjdi90dF9hdGxhbnRpcy5jCj4gaW5kZXggOGEyMTlhZmVmNy4uNzA4MTVlMTJlZiAxMDA2
NDQKPiAtLS0gYS9ody9yaXNjdi90dF9hdGxhbnRpcy5jCj4gKysrIGIvaHcvcmlzY3YvdHRfYXRs
YW50aXMuYwo+IEBAIC0yNCw5ICsyNCw4IEBACj4gwqAjaW5jbHVkZSAiaHcvcmlzY3YvZmR0LWNv
bW1vbi5oIgo+IMKgI2luY2x1ZGUgImh3L3Jpc2N2L3Jpc2N2X2hhcnQuaCIKPiDCoAo+IC0jaW5j
bHVkZSAiaHcvY2hhci9zZXJpYWwtbW0uaCIKPiArI2luY2x1ZGUgImh3L2NoYXIvZHc4MjUwLmgi
Cj4gwqAjaW5jbHVkZSAiaHcvaW50Yy9yaXNjdl9hY2xpbnQuaCIKPiAtI2luY2x1ZGUgImh3L21p
c2MvdW5pbXAuaCIKPiDCoAo+IMKgI2luY2x1ZGUgInN5c3RlbS9zeXN0ZW0uaCIKPiDCoCNpbmNs
dWRlICJzeXN0ZW0vZGV2aWNlX3RyZWUuaCIKPiBAQCAtMjYyLDExICsyNjEsMTUgQEAgc3RhdGlj
IHZvaWQgY3JlYXRlX2ZkdF9jcHUodm9pZCAqZmR0LAo+IFRUQXRsYW50aXNTb0NTdGF0ZSAqcywK
PiDCoHN0YXRpYyB2b2lkIGNyZWF0ZV9mZHRfdWFydCh2b2lkICpmZHQsIGNvbnN0IE1lbU1hcEVu
dHJ5ICptZW0sIGludAo+IGlycSwKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBpbnQgaXJxY2hpcF9waGFuZGxlKQo+IMKgewo+ICvCoMKg
wqAgc3RhdGljIGNvbnN0IGNoYXIgKiBjb25zdCBjb21wYXRbMl0gPSB7Cj4gK8KgwqDCoMKgwqDC
oMKgICJzbnBzLGR3LWFwYi11YXJ0IiwgIm5zMTY1NTBhIgo+ICvCoMKgwqAgfTsKPiDCoMKgwqDC
oCBnX2F1dG9mcmVlIGNoYXIgKm5hbWUgPQo+IGdfc3RyZHVwX3ByaW50ZigiL3NvYy9zZXJpYWxA
JSJIV0FERFJfUFJJWCwKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIG1lbS0+YmFz
ZSk7Cj4gwqAKPiDCoMKgwqDCoCBxZW11X2ZkdF9hZGRfc3Vibm9kZShmZHQsIG5hbWUpOwo+IC3C
oMKgwqAgcWVtdV9mZHRfc2V0cHJvcF9zdHJpbmcoZmR0LCBuYW1lLCAiY29tcGF0aWJsZSIsICJu
czE2NTUwYSIpOwo+ICvCoMKgwqAgcWVtdV9mZHRfc2V0cHJvcF9zdHJpbmdfYXJyYXkoZmR0LCBu
YW1lLCAiY29tcGF0aWJsZSIsCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgKGNoYXIgKiopJmNvbXBhdCwKPiBBUlJBWV9T
SVpFKGNvbXBhdCkpOwo+IMKgwqDCoMKgIHFlbXVfZmR0X3NldHByb3Bfc2l6ZWRfY2VsbHMoZmR0
LCBuYW1lLCAicmVnIiwgMiwgbWVtLT5iYXNlLCAyLAo+IG1lbS0+c2l6ZSk7Cj4gwqDCoMKgwqAg
cWVtdV9mZHRfc2V0cHJvcF9jZWxsKGZkdCwgbmFtZSwgInJlZy1zaGlmdCIsIDIpOwo+IMKgwqDC
oMKgIHFlbXVfZmR0X3NldHByb3BfY2VsbChmZHQsIG5hbWUsICJyZWctaW8td2lkdGgiLCA0KTsK
PiBAQCAtNDA5LDE3ICs0MTIsNiBAQCBzdGF0aWMgdm9pZCBsb2FkX2ZkdChUVEF0bGFudGlzU3Rh
dGUgKmFtcykKPiDCoMKgwqDCoCBjcmVhdGVfZmR0X21lbW9yeShtcy0+ZmR0LCAmYW1zLT5zb2Mp
Owo+IMKgfQo+IMKgCj4gLXN0YXRpYyB2b2lkIG1taW9fbWFwX3VuaW1wbGVtZW50ZWQoTWVtb3J5
UmVnaW9uICptZW1vcnksCj4gU3lzQnVzRGV2aWNlICpkZXYsCj4gLcKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGNvbnN0
IGNoYXIgKm5hbWUsIGh3YWRkciBhZGRyLAo+IHVpbnQ2NF90IHNpemUpCj4gLXsKPiAtwqDCoMKg
IHFkZXZfcHJvcF9zZXRfc3RyaW5nKERFVklDRShkZXYpLCAibmFtZSIsIG5hbWUpOwo+IC3CoMKg
wqAgcWRldl9wcm9wX3NldF91aW50NjQoREVWSUNFKGRldiksICJzaXplIiwgc2l6ZSk7Cj4gLcKg
wqDCoCBzeXNidXNfcmVhbGl6ZShkZXYsICZlcnJvcl9hYm9ydCk7Cj4gLQo+IC3CoMKgwqAgbWVt
b3J5X3JlZ2lvbl9hZGRfc3VicmVnaW9uX292ZXJsYXAobWVtb3J5LCBhZGRyLAo+IC3CoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgc3lzYnVzX21taW9fZ2V0X3JlZ2lvbihkZXYsCj4gMCksIC0xMDAwKTsK
PiAtfQo+IC0KPiDCoHN0YXRpYyB2b2lkIHR0X2F0bGFudGlzX21hY2hpbmVfZG9uZShOb3RpZmll
ciAqbiwgdm9pZCAqZGF0YSkKPiDCoHsKPiDCoMKgwqDCoCBUVEF0bGFudGlzU3RhdGUgKmFtcyA9
IGNvbnRhaW5lcl9vZihuLCBUVEF0bGFudGlzU3RhdGUsCj4gbWFjaGluZV9kb25lKTsKPiBAQCAt
NDg4LDggKzQ4MCw3IEBAIHN0YXRpYyB2b2lkIHR0X2F0bGFudGlzX3NvY19pbml0KE9iamVjdCAq
b2JqKQo+IMKgCj4gwqDCoMKgwqAgb2JqZWN0X2luaXRpYWxpemVfY2hpbGQob2JqLCAiY3B1cyIs
ICZzLT5jcHVzLAo+IFRZUEVfUklTQ1ZfSEFSVF9BUlJBWSk7Cj4gwqAKPiAtwqDCoMKgIG9iamVj
dF9pbml0aWFsaXplX2NoaWxkKG9iaiwgInVhcnQxIiwgJnMtPnVhcnQxLAo+IC3CoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgVFlQRV9VTklNUExF
TUVOVEVEX0RFVklDRSk7Cj4gK8KgwqDCoCBvYmplY3RfaW5pdGlhbGl6ZV9jaGlsZChvYmosICJ1
YXJ0MSIsICZzLT51YXJ0MSwgVFlQRV9EVzgyNTApOwo+IMKgCj4gwqDCoMKgwqAgZm9yIChpbnQg
aSA9IDA7IGkgPCBUVF9BVExfTlVNX0kyQzsgaSsrKSB7Cj4gwqDCoMKgwqDCoMKgwqDCoCBvYmpl
Y3RfaW5pdGlhbGl6ZV9jaGlsZChvYmosICJpMmNbKl0iLCAmcy0+aTJjW2ldLAo+IEBAIC01ODQs
MjEgKzU3NSwxMyBAQCBzdGF0aWMgdm9pZCB0dF9hdGxhbnRpc19zb2NfcmVhbGl6ZShEZXZpY2VT
dGF0ZQo+ICpkZXYsIEVycm9yICoqZXJycCkKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICZzLT5ib290cm9tKTsKPiDCoAo+
IMKgwqDCoMKgIC8qIFVBUlQxLCB0aGUgc29jIGNvbnNvbGUgKFVBUlQwIGlzIGZvciB0aGUgYm9v
dAo+IG1pY3JvY29udHJvbGxlcikgKi8KPiAtwqDCoMKgIHNlcmlhbF9tbV9pbml0KHMtPm1lbW9y
eSwgcy0+bWVtbWFwW1RUX0FUTF9VQVJUMV0uYmFzZSwgMiwKPiAtwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIHFkZXZfZ2V0X2dwaW9faW4ocy0+aXJxY2hpcCwgVFRfQVRMX1VB
UlQxX0lSUSksCj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAxMTUyMDAs
IHNlcmlhbF9oZCgwKSwgREVWSUNFX0xJVFRMRV9FTkRJQU4pOwo+IC3CoMKgwqAgLyoKPiAtwqDC
oMKgwqAgKiBBdGxhbnRpcyBjb250YWlucyBhIERlc2lnbldhcmUgdWFydCB3aGlsZSB0aGUgUUVN
VSBtYWNoaW5lCj4gLcKgwqDCoMKgICogdXNlcyB0aGUgc2VyaWFsX21tIG1vZGVsIHdpdGggdGhl
IGJhc2UgbnMxNjU1MCByZWdpc3RlciBzZXQuCj4gLcKgwqDCoMKgICogTGludXgncyBkdyBkcml2
ZXIgd3JpdGVzIG91dHNpZGUgb2Ygc2VyaWFsX21tJ3MgMHgyMCBzaXplZAo+IC3CoMKgwqDCoCAq
IG1hcHBpbmcgYW5kIGZhdWx0cy4KPiAtwqDCoMKgwqAgKgo+IC3CoMKgwqDCoCAqIENyZWF0ZSBh
biB1bmltcGxlbWVudGVkIGRldmljZSByZWdpb24gc28gd3JpdGVzIGRvbid0IGZhdWx0Cj4gLcKg
wqDCoMKgICogYW5kIHJlYWRzIHJldHVybiB6ZXJvLCB3aGljaCBrZWVwcyBMaW51eCBoYXBweS4K
PiAtwqDCoMKgwqAgKi8KPiAtwqDCoMKgIG1taW9fbWFwX3VuaW1wbGVtZW50ZWQocy0+bWVtb3J5
LCBTWVNfQlVTX0RFVklDRSgmcy0+dWFydDEpLAo+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICJ0dC1hdGxhbnRpcy51YXJ0MSIsIHMtCj4gPm1l
bW1hcFtUVF9BVExfVUFSVDFdLmJhc2UsCj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcy0+bWVtbWFwW1RUX0FUTF9VQVJUMV0uc2l6ZSk7Cj4g
K8KgwqDCoCBxZGV2X3Byb3Bfc2V0X2NocihERVZJQ0UoJnMtPnVhcnQxKSwgImNoYXJkZXYiLCBz
ZXJpYWxfaGQoMCkpOwo+ICvCoMKgwqAgc3lzYnVzX3JlYWxpemUoU1lTX0JVU19ERVZJQ0UoJnMt
PnVhcnQxKSwgJmVycm9yX2ZhdGFsKTsKPiArwqDCoMKgIG1lbW9yeV9yZWdpb25fYWRkX3N1YnJl
Z2lvbihzLT5tZW1vcnksCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHMtPm1lbW1hcFtUVF9BVExfVUFSVDFdLmJhc2UsCj4g
K8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgCj4gc3lzYnVzX21taW9fZ2V0X3JlZ2lvbihTWVNfQlVTX0RFVklDRSgmcy0+dWFydDEp
LCAwKSk7Cj4gK8KgwqDCoCBzeXNidXNfY29ubmVjdF9pcnEoU1lTX0JVU19ERVZJQ0UoJnMtPnVh
cnQxKSwgMCwKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
cWRldl9nZXRfZ3Bpb19pbihzLT5pcnFjaGlwLAo+IFRUX0FUTF9VQVJUMV9JUlEpKTsKPiDCoAo+
IMKgwqDCoMKgIC8qIEkyQyAqLwo+IMKgwqDCoMKgIGZvciAoaW50IGkgPSAwOyBpIDwgVFRfQVRM
X05VTV9JMkM7IGkrKykgewo+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2h3L3Jpc2N2L3R0X2F0bGFu
dGlzLmgKPiBiL2luY2x1ZGUvaHcvcmlzY3YvdHRfYXRsYW50aXMuaAo+IGluZGV4IDM5MjMzMDhi
N2MuLjAwMDk4OGMwMzcgMTAwNjQ0Cj4gLS0tIGEvaW5jbHVkZS9ody9yaXNjdi90dF9hdGxhbnRp
cy5oCj4gKysrIGIvaW5jbHVkZS9ody9yaXNjdi90dF9hdGxhbnRpcy5oCj4gQEAgLTEzLDcgKzEz
LDcgQEAKPiDCoCNpbmNsdWRlICJody9jb3JlL3N5c2J1cy5oIgo+IMKgI2luY2x1ZGUgImh3L2ky
Yy9kZXNpZ253YXJlX2kyYy5oIgo+IMKgI2luY2x1ZGUgImh3L2ludGMvcmlzY3ZfaW1zaWMuaCIK
PiAtI2luY2x1ZGUgImh3L21pc2MvdW5pbXAuaCIKPiArI2luY2x1ZGUgImh3L2NoYXIvZHc4MjUw
LmgiCj4gwqAjaW5jbHVkZSAiaHcvcmlzY3YvcmlzY3ZfaGFydC5oIgo+IMKgCj4gwqAjZGVmaW5l
IFRZUEVfVFRfQVRMQU5USVNfTUFDSElORSBNQUNISU5FX1RZUEVfTkFNRSgidHQtYXRsYW50aXMi
KQo+IEBAIC0zOSw3ICszOSw3IEBAIHN0cnVjdCBUVEF0bGFudGlzU29DU3RhdGUgewo+IMKgwqDC
oMKgIFJJU0NWSGFydEFycmF5U3RhdGUgY3B1czsKPiDCoMKgwqDCoCBEZXZpY2VTdGF0ZSAqaXJx
Y2hpcDsKPiDCoMKgwqDCoCBEZXNpZ25XYXJlSTJDU3RhdGUgaTJjW1RUX0FUTF9OVU1fSTJDXTsK
PiAtwqDCoMKgIFVuaW1wbGVtZW50ZWREZXZpY2VTdGF0ZSB1YXJ0MTsKPiArwqDCoMKgIERXODI1
MFN0YXRlIHVhcnQxOwo+IMKgwqDCoMKgIE1lbW9yeVJlZ2lvbiBib290cm9tOwo+IMKgCj4gwqDC
oMKgwqAgdWludDMyX3QgbnVtX2hhcnRzOwo=

