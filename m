Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7ABEDCA5FC5
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2026 01:54:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xC5zS-0007lK-Od; Wed, 30 Sep 2026 21:53:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=727d860e1=Alistair.Francis@wdc.com>)
 id 1xC5zL-0007jv-LQ; Wed, 30 Sep 2026 21:53:35 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=727d860e1=Alistair.Francis@wdc.com>)
 id 1xC5zI-0007ue-3w; Wed, 30 Sep 2026 21:53:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1790819611; x=1822355611;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=rgGiftfWoytQNEr7GRMLCgpfnzMUvAoDpQoAzwiZZ98=;
 b=OU6Ii27UERPAWbdDdcQT7WBMisDvLyxaPyL0mB9ZTjEKc9k+vmT4Y/6f
 rrjN66lsoBgMlDYUGMO8k46pfcXJKJBJ8hBO33+DsP0jYRihVbeMEJSzf
 naPn1yqUgXJpjJkozHwVo3MTMY/lPo9vM2HjwSoriOKXby1sw0XAeyVEJ
 QgnroQ4zFQ3EwA0A5uHVvAs/AkUl/2Q0Ne0gBSn0pub5sm3EaT9cF1fiD
 3CSTltS+cm3JA2+etCoQIGHMARtAlRVX7u3bNLelwi/oBARR+KIpubWbe
 JEdoiCxiOg+jbfXVPFTQ4lkapZILWUSV12/RSXaW24yLfxg/WISgwzNVY Q==;
X-CSE-ConnectionGUID: Tl+dTE2vT8qDZgL2DEh5mw==
X-CSE-MsgGUID: xtS7y1ttRaSGkzo6QwQsXA==
X-IronPort-AV: E=Sophos;i="6.27,133,1786982400"; d="scan'208";a="157931601"
Received: from mail-southcentralusazon11013005.outbound.protection.outlook.com
 (HELO SA9PR02CU001.outbound.protection.outlook.com) ([40.93.196.5])
 by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 01 Oct 2026 09:53:27 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LMtxFv97Cq9339xvyeWifKf8FwyT4YjJIWMXkP2DciPaT/YYnVsOfW/T1REud+g4thL6EObZo2O2VxHPeZ1eHGkNyBcC3Sl7Z6WoqJhE4ndAn5KUHYEgpuiukG1xBe0V+rHRnvbfqFmmDMXCznKKUDsXCbgTSwfO3grihBjGb/+W7AeK0xw2+Wt7iMAy/6V5V6bB8UaFezUTJ/YTFJFVZScNLZVlP/vmD3rl+FSXURewTXCt/ZRg6O9OGt75awAMUeYKKaCq7TNoCxyJ4XHpSQu5l9MZLtmboBnXHMI2FTGhCBBAKlHuD4V0w8F8mFIxXb47kV574nF6eljZMZbSQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rgGiftfWoytQNEr7GRMLCgpfnzMUvAoDpQoAzwiZZ98=;
 b=TztzjNizOHdk5PGpRsXFN4HYPXfMX377RNbxtX3x0xk86hoELtGk6SO0j+GPhVe7GGFkli+xKKbvnJ16gFMGqzc0bmdWE4ldkIfWp/U9gV1P8e1M2SyimEyAuTIpknzpNq04Wab2WCUzqf2Z1okWFaIfr6UgalgXoURn/0pijrNCq6Z5GytUjRuCawnGYvwyu2BgkC6o26rLhS8GHunGRc82Si5jM8u9lw4MdCyFGMKpAdy1Ol3U0f6mPlXjMbW9JMfCXYAmQ8LQHpn3Ivg/ezGTUBEkiHSvHBd1ASv2zBb2zxjCwq6Ekobmzj/wrhYOTwMiRsdQBy4V8d+phAGHMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rgGiftfWoytQNEr7GRMLCgpfnzMUvAoDpQoAzwiZZ98=;
 b=dYRouBK7E1D+TjfM1QYeL4zkWI87bNrsOy5KUPKDBuS3x0yNnZTOg59H7vX+A6A3oavBIPgEMn1NgHXyWnzt9TrrwMismXD4yf9zjr5lVwziDyeSpoNe9/In786bn9fz0IsWGG7KkeYKUgq5f42cDhveIsxCL8A5Z+Q5JZTdZeo=
Received: from BY1PR04MB9561.namprd04.prod.outlook.com (2603:10b6:a03:5b6::11)
 by DM6PR04MB6380.namprd04.prod.outlook.com (2603:10b6:5:1e3::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.15; Thu, 1 Oct
 2026 01:53:25 +0000
Received: from BY1PR04MB9561.namprd04.prod.outlook.com
 ([fe80::3869:e494:2fa8:9888]) by BY1PR04MB9561.namprd04.prod.outlook.com
 ([fe80::3869:e494:2fa8:9888%6]) with mapi id 15.21.0451.026; Thu, 1 Oct 2026
 01:53:25 +0000
From: Alistair Francis <Alistair.Francis@wdc.com>
To: "philmd@oss.qualcomm.com" <philmd@oss.qualcomm.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "daniel.barboza@oss.qualcomm.com" <daniel.barboza@oss.qualcomm.com>,
 "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "palmer@dabbelt.com"
 <palmer@dabbelt.com>, "zhiwei_liu@linux.alibaba.com"
 <zhiwei_liu@linux.alibaba.com>, "richard.henderson@linaro.org"
 <richard.henderson@linaro.org>, "liwei1518@gmail.com" <liwei1518@gmail.com>,
 "chao.liu@processmission.com" <chao.liu@processmission.com>
Subject: Re: [PATCH v4 6/7] target/riscv: Access MIP atomically
Thread-Topic: [PATCH v4 6/7] target/riscv: Access MIP atomically
Thread-Index: AQHdUQOVTjICbVzvVUChOz2HxgdLX7bn7UIA
Date: Thu, 1 Oct 2026 01:53:25 +0000
Message-ID: <b462b2dc99020f59dc73d3eea2028d10b41153ff.camel@wdc.com>
References: <20260930174508.81497-1-philmd@oss.qualcomm.com>
 <20260930174508.81497-7-philmd@oss.qualcomm.com>
In-Reply-To: <20260930174508.81497-7-philmd@oss.qualcomm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.62.0 (by Flathub.org) 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY1PR04MB9561:EE_|DM6PR04MB6380:EE_
x-ms-office365-filtering-correlation-id: d4bc7071-db80-428d-30bc-08df1f5ec813
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|19092799006|23010399003|10070799003|376014|366016|7416014|1800799024|38070700021|4143699003|10067099003|56012099006|11063799006|22082099003|18002099003;
x-microsoft-antispam-message-info: 34qlQKgMGdBmo96HuvHMg+1kK5KnMrrxJrI/QO1Jb5/+fNkng2prYsKyP2pahPfR7x1h7vGS9oLd2JNrfWoJRk5VcZUV0vyqGtloDrUdIhVv/a1wDZ8BJQKF6pIJh6hctbknJwu5StD8FteqycFzC3CJl83iB1ppIAwW66gvUoVyrhpXqpM34xFi0C7ivI1bzSR6orrEGP7hHSRX9DGTse5vx9EbfppHA1pvZADS7bJ2m1E2Dv19D+SUJnhDasSI1rYlO9PURLS9C0HXoAOfZy+yeR+qIBTKCFu8v3SfF2cVfo+YJij8btPEy0UDE3deMwwH6tktw0RLBEwD8ejmTcAUqYsPEZOpbu2yNaVuvF6zP1D0XfNd62xcOPIK0KPQGCAydd+/fBtKEaaXY9fhplpVD2m8kXf2QvTCp2ZKtRwFMU+v6I55DPn2GwG5q+u5wOQ1FJJw2nKAA/6ek2vbUFEhjKLijW6i8cgWjS0AS1wFaaZ8MAberd1oRasA1BQGEc8onOU/OyeKbTeFyJxMN7Ti54h6q5Cx1xOIfbkAzelwGO/HTbys05vVvec8T/x1EwDJ8bXswuFNuGGOqVVADby5ksFzj4r2AcvZAOYkecywKzaVPypAbfJHjS+iO82at1/6/YGWY3hKkH/qV3uST2knNT9ctUjuZLVsISE5sWWg9uNsv3BcUlTp2/d8V0z5E19IbvpQUoScwHe3Wc8neQFN5DpXMOur0SVXZRCw6yc=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY1PR04MB9561.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(23010399003)(10070799003)(376014)(366016)(7416014)(1800799024)(38070700021)(4143699003)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?akdGWVNqUzBmdFJxNUVFSEFjV3dZZDFhNlZIK2hDVkJNYkVQOWpHSmYwU1RO?=
 =?utf-8?B?bE9ZWldjYkgwOGllVFRWNlhJT0U2cVJxOFV2bE8wQmdCSGErL3FwcWRKK1d0?=
 =?utf-8?B?YVhBbU9iTUdMaUpvRDNicFVaZjFRcFRZMWtqUkd5NTZMTkpPNzVqOXYycUVT?=
 =?utf-8?B?dUl3NzRwdEc0VktvbVkrTUlqQjQ2azd6a2VuNmZrcjVjbVE2YTdua1ZIYitV?=
 =?utf-8?B?ZFczVGJRcWpwN3d3QXJBT0RXbDM3Qm9hNEtldTBXcjhxVVV2WENIWmZ0Ylda?=
 =?utf-8?B?MndMTGUzK1VjR0E2Z0VmYVZ2SVBpUG1qZmVXUW1GVjFkU241MjJQczVQL1Bo?=
 =?utf-8?B?dXhXRkw0b25WUzNVRGZ1MWZqWUlBN0pMczA2dEFXZ01TSnJKRzgwaE9kNEUz?=
 =?utf-8?B?VjJMVkd6bVVtc2FNb1pUdUF5ejZTN3B2Z2RQK1FsMndVdUw0TmRHVmY3aThH?=
 =?utf-8?B?VjVkOS9Kd21MZm1QRjloQXoyZlNZRFhXVnA4c2dPLytwWXlESG9vVUw5T0N4?=
 =?utf-8?B?QkgzcWNpS3pSNlY0aHdRZWRnakNlM3FCYW5HWGtLcnhabXppUmdMVElRaGI4?=
 =?utf-8?B?ZHV0cVpJYUpPUjBpeHdlWFZYWFFXbjRKdmIwemhqcVlWaUNFb1dUK1ZOcW5x?=
 =?utf-8?B?WDJ6S1BNc3pBTUZEK1dKRjRUc21xRzFYeWpIZUJLbC9FcTNPSHZBVE1SNVV0?=
 =?utf-8?B?V04yeTVHOWFYTStDYVNZUnJTU3VuMFZmNFN3ekxLZFVCUzRMUzRXNkZBMDlO?=
 =?utf-8?B?QzArbkZpTVB5RFBWK0d6bEVyUnN3QzJwZEJlaDF4SEM5anBoUVhXamJDWlNt?=
 =?utf-8?B?dG1hcEg4WURDdEV5VkN0b0NtWUppNmt3eWxDN3dVelE4cWw0TEdjTjhmWnox?=
 =?utf-8?B?c1Bzbldaem5TQ24zL3kyQzNIaTRDV3BuRW1XcVdtUEVFVE5kS3k1aUo1ZGZl?=
 =?utf-8?B?N0gyNmlYeUQ4V252ZldCUjE2M09tY28yWFhibVh0NHRLVDhQY0xJNlhmOE1k?=
 =?utf-8?B?ZVhhMWJJamdLMWRuZDZpajdSNkF3WGpjM3RVTFdFRTE1SnB6bEh0NU82ZjhI?=
 =?utf-8?B?dk5MZE41NEw1Q3VyK3J5NUtPT2pFSXRpMk1iSENENHp1cGdHVE5yM25oajdj?=
 =?utf-8?B?Ulh6NEREdnJhNWxGRFkzaXZjZEdkZkVUeGR2SHd2OUlpZDJCdVRmTW1rRXNN?=
 =?utf-8?B?OW5oTjMwejF2eVREdEtya3A3SEtBSXV4UTlzaTNIdEhwdUVsMlE3RWoweUNk?=
 =?utf-8?B?akZJcCt2clhxS2tFQWdzbXNHS2JpVjlHK0JaSFZwZUJVMTdTajBzL25uMnE0?=
 =?utf-8?B?VGhDOEJrcFlnKzVwMDZFVlNSZWN5S0RvV3RQaWtzbEp2cTBKMGN2Risvb0g1?=
 =?utf-8?B?djEyeXJxZ0g3T1E0WWExVFltWWZPbXl6N0pDZXplbHFTRkR0djdnN1JmaWUr?=
 =?utf-8?B?a2h0Yk11SmFUSytNRFVGNzFwaHltNUoyUFRXWDBEWG5tT2ZxYjcrSTdQMlZh?=
 =?utf-8?B?MWVzemtXbXRyR1JzNjlFemtwRTVsbU5zdFh0NVF3bGVEQUk4SlJKR2xNMU9V?=
 =?utf-8?B?ZWZCcDcwcUNOcUpocEpkVURqdGlBMTJFMTZhK3Zuemg3OW1Oc2hrSjJBNFdZ?=
 =?utf-8?B?VnM4Z2JEV3ZEOHZGVEFrWEZOOGVtMTJYR1VmeEh5ckZ6WkcwT3B5K0Y3QVQ3?=
 =?utf-8?B?VnJQM2wzdnNWNmFmeko3L1lwaVlVdm4xS0FLQjBkZGc2WnF1cktPeUlmRWln?=
 =?utf-8?B?Sk1rM2gyNTUxZm9rODRpMU55VUhuVFZFUFNSWDFCTzJpRHNiS0VnMTlUeGhU?=
 =?utf-8?B?MURHNHA2Z2QrbDdqdzBoNDYraEc2Mng2UnpDV3pGUitCWC9TbG55V0d3d01H?=
 =?utf-8?B?NUUzSCtjY0hHN0ZKaytmTDRVU00xWWhJVlpjRkM4NG1LMFJ1OGlrVDkyWHND?=
 =?utf-8?B?TU5XTEQycWw4RCs2WGxGWjlsclpJNHFlbjFMVHJzNTVoS0ZXcFd5V2RIMGhY?=
 =?utf-8?B?eGFBQTBhVW1oR2hEQkZ2aHRIa01LVitZakIzOVg1WlVxRWJEM0x2eUtDR1pW?=
 =?utf-8?B?UHJ0N1JSMlZFTG91b3B0dWpQN2p5Uzc0eEJiTVBwTnkrWkdDSUJKRlI5QlU0?=
 =?utf-8?B?bnVIRVEzMlZzYTJ2dkl2cndHSnU3eGFmeWJDZUtZMWtuclB2WlhnZFFCUlQ3?=
 =?utf-8?B?UmlYZ1E2U3ZVTlNRWjBUbUJ1TmRRSXFzaTF1V3drbmpORkRLM2V6cjJWOE9I?=
 =?utf-8?B?U2FSOUZLRllUaU1ZRG9qb3FIazFDZkpQalhkOGxCQWhxMFlQZ1crVHp0dE9w?=
 =?utf-8?B?dHhRWFF1QWd6blIxbUk3eCtZY1FrajJGVWhPeVJNSThlNzBSdjVjT3FHT0N5?=
 =?utf-8?Q?/AQf0xG2TLjlV26QsW7JgcCIPASKiloCYyfZKGPDwywGc?=
x-ms-exchange-antispam-messagedata-1: lOl99W0V9XfbcDbq/iZDfcMXMgZ1/Zryj+A=
Content-Type: text/plain; charset="utf-8"
Content-ID: <09DA7A4D41F2A04C849E9645939E2E55@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: FzBz1EVFDMreE8I5pFquWP10fn98tNme51oWI/X4hPh6Im4Cx0/mto0+VrWAFMkXmiEjgu9hXqoZ+j0g0SbQs9XAe8o5n4GxylydmtgA7gjrfqa7bZteexWoACf4LjMnQ4fAUyppRk492IgbtvNVdvgeEjiI0/W6JHFSgCtU74olyavdvJJGjnzlsRajj13XZoAZwNN+s+xqmu8VSur9ZRhp0QcourqRRrjKXZ1KCMkYKMP5tVY4remU1f+SQ1Rmq6CKcIf8RSwrNuN52Du2eTSiT6GOmjSS2E7imCnqOURtRIn4skde0vOgF7huBHAGfnDVh5VSrB6qmONEO6TxqQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: EgKqszCRrAL43i6hwfw00CC2Nq8Hxwk5RzUB7TGsIvUnhqVrdKaHoW+rQcOHntr2fn1Mt22v/J5sKoO9Hwg5S82ZqS1hpfiva3KFm7E9mxbpSbZohSEF2YOI5gDNYu9jbT7NuERSaiB0yXo9MdsHWhjQluux+aDyfSLNrkjrRnU53+SG4XYVpkZvFS09D5s+0GpqWBHam3I4bF50cnk/k2BUA4yxaQhibM48lRx7Fxo4TFN15TTxXzvvM6hkZmmwYglbZxzqywRBeo6/UXEdta8hmHwAiDAfWbO8Ptmv94xDZSDFyZvtfV9K0+sFGx1KFoVoibcpsRXDiO88P7zIUPgDPWE318DQKdsM4txRPdvKYxgid8JzpcLwwKuNMh4AXcCFbZdXvEDNDpRqgADTWpyMPiYHSjb+sIVOxPBLSwqUrL7GNe1ZvLYiclLSUWZyuJpp23PIHUff1+PB00oQsdWk4m2uK75IE/QCkcWhPJNjKapNGzpTjgtEFDtJYlUyyv+yRVg6N3/Kh1jc+717NLikTl7nZ1IIfSSNcvc1mzz1bAP2fp464cCToO5z85+Tb1dT6R3/gJS799ex1G5yMARkPwrsIJy09LrCx2vXH8a/44ebQwt+qkkLr6pezlIN
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY1PR04MB9561.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4bc7071-db80-428d-30bc-08df1f5ec813
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2026 01:53:25.3824 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: e+5NxSeIReUChN6tCQFwEsws7tG+lQjWJ1X/rvo1V/hL59MSk9IDZ8+eEuanVkR1EMUnKxhcW5eWz/3FKiesWp6QgRQyQilLcco5+lDNgGc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB6380
Received-SPF: pass client-ip=68.232.143.124;
 envelope-from=prvs=727d860e1=Alistair.Francis@wdc.com;
 helo=esa2.hgst.iphmx.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_PASS=-0.001,
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

T24gV2VkLCAyMDI2LTA5LTMwIGF0IDE5OjQ1ICswMjAwLCBQaGlsaXBwZSBNYXRoaWV1LURhdWTD
qSB3cm90ZToNCj4gTWFrZSByaXNjdl9jcHVfZ2V0X21pcCgpIHJlYWQgZW52LT5taXAgd2l0aCBx
YXRvbWljX3JlYWQoKSBhbmQNCj4gcmlzY3ZfY3B1X3VwZGF0ZV9taXAoKSBzdG9yZSBpdCB3aXRo
IHFhdG9taWNfc2V0KCkuIFRoaXMgbWFrZXMNCj4gTUlQIHJlYWRzIGFuZCB3cml0ZXMgc2FmZSBm
b3IgcmlzY3ZfY3B1X2hhc193b3JrKCksIHdoaWNoIG1heQ0KPiBydW4gd2l0aG91dCB0aGUgQlFM
Lg0KPiANCj4gUmVwb3J0ZWQtYnk6IFBhb2xvIEJvbnppbmkgPHBib256aW5pQHJlZGhhdC5jb20+
DQo+IFNpZ25lZC1vZmYtYnk6IFBoaWxpcHBlIE1hdGhpZXUtRGF1ZMOpIDxwaGlsbWRAb3NzLnF1
YWxjb21tLmNvbT4NCj4gUmV2aWV3ZWQtYnk6IFJpY2hhcmQgSGVuZGVyc29uIDxyaWNoYXJkLmhl
bmRlcnNvbkBsaW5hcm8ub3JnPg0KDQpSZXZpZXdlZC1ieTogQWxpc3RhaXIgRnJhbmNpcyA8YWxp
c3RhaXIuZnJhbmNpc0B3ZGMuY29tPg0KDQpBbGlzdGFpcg0KDQo+IC0tLQ0KPiDCoHRhcmdldC9y
aXNjdi9jcHUuY8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfCAzICsrLQ0KPiDCoHRhcmdldC9yaXNj
di90Y2cvY3B1X2hlbHBlci5jIHwgMyArKy0NCj4gwqAyIGZpbGVzIGNoYW5nZWQsIDQgaW5zZXJ0
aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS90YXJnZXQvcmlzY3Yv
Y3B1LmMgYi90YXJnZXQvcmlzY3YvY3B1LmMNCj4gaW5kZXggYjhkNmY5OTJiYTQuLjQ1ZTgyZmMz
MGM1IDEwMDY0NA0KPiAtLS0gYS90YXJnZXQvcmlzY3YvY3B1LmMNCj4gKysrIGIvdGFyZ2V0L3Jp
c2N2L2NwdS5jDQo+IEBAIC0yMiw2ICsyMiw3IEBADQo+IMKgI2luY2x1ZGUgInFlbXUvY3R5cGUu
aCINCj4gwqAjaW5jbHVkZSAicWVtdS9sb2cuaCINCj4gwqAjaW5jbHVkZSAicWVtdS9ndWVzdC1y
YW5kb20uaCINCj4gKyNpbmNsdWRlICJxZW11L2F0b21pYy5oIg0KPiDCoCNpbmNsdWRlICJjcHUu
aCINCj4gwqAjaW5jbHVkZSAiY3B1X3ZlbmRvcmlkLmgiDQo+IMKgI2luY2x1ZGUgInRhcmdldC9y
aXNjdi90Y2cvY3NyLmgiDQo+IEBAIC05NTYsNyArOTU3LDcgQEAgaW50IHJpc2N2X2NwdV92c2ly
cV9wZW5kaW5nKENQVVJJU0NWU3RhdGUgKmVudikNCj4gwqANCj4gwqB1aW50NjRfdCByaXNjdl9j
cHVfZ2V0X21pcChjb25zdCBDUFVSSVNDVlN0YXRlICplbnYpDQo+IMKgew0KPiAtwqDCoMKgIHJl
dHVybiBlbnYtPm1pcDsNCj4gK8KgwqDCoCByZXR1cm4gcWF0b21pY19yZWFkKCZlbnYtPm1pcCk7
DQo+IMKgfQ0KPiDCoA0KPiDCoGJvb2wgcmlzY3ZfY3B1X2hhc193b3JrKENQVVN0YXRlICpjcykN
Cj4gZGlmZiAtLWdpdCBhL3RhcmdldC9yaXNjdi90Y2cvY3B1X2hlbHBlci5jDQo+IGIvdGFyZ2V0
L3Jpc2N2L3RjZy9jcHVfaGVscGVyLmMNCj4gaW5kZXggZjhmNzc5YTAxZDguLmRiN2YyYmQ2ZGU3
IDEwMDY0NA0KPiAtLS0gYS90YXJnZXQvcmlzY3YvdGNnL2NwdV9oZWxwZXIuYw0KPiArKysgYi90
YXJnZXQvcmlzY3YvdGNnL2NwdV9oZWxwZXIuYw0KPiBAQCAtMjAsNiArMjAsNyBAQA0KPiDCoCNp
bmNsdWRlICJxZW11L29zZGVwLmgiDQo+IMKgI2luY2x1ZGUgInFlbXUvbG9nLmgiDQo+IMKgI2lu
Y2x1ZGUgInFlbXUvbWFpbi1sb29wLmgiDQo+ICsjaW5jbHVkZSAicWVtdS9hdG9taWMuaCINCj4g
wqAjaW5jbHVkZSAiY3B1LmgiDQo+IMKgI2luY2x1ZGUgImludGVybmFscy5oIg0KPiDCoCNpbmNs
dWRlICJwbXUuaCINCj4gQEAgLTU4NCw3ICs1ODUsNyBAQCB1aW50NjRfdCByaXNjdl9jcHVfdXBk
YXRlX21pcChDUFVSSVNDVlN0YXRlICplbnYsDQo+IHVpbnQ2NF90IG1hc2ssIHVpbnQ2NF90IHZh
bHVlKQ0KPiDCoMKgwqDCoCBCUUxfTE9DS19HVUFSRCgpOw0KPiDCoA0KPiDCoMKgwqDCoCBvbGQg
PSByaXNjdl9jcHVfZ2V0X21pcChlbnYpOw0KPiAtwqDCoMKgIGVudi0+bWlwID0gKG9sZCAmIH5t
YXNrKSB8ICh2YWx1ZSAmIG1hc2spOw0KPiArwqDCoMKgIHFhdG9taWNfc2V0KCZlbnYtPm1pcCwg
KG9sZCAmIH5tYXNrKSB8ICh2YWx1ZSAmIG1hc2spKTsNCj4gwqANCj4gwqDCoMKgwqAgcmlzY3Zf
Y3B1X2ludGVycnVwdChlbnYpOw0KPiDCoA0K

