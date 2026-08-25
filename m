Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57737C5DF81
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 04:16:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyiZy-0003m7-Iw; Tue, 25 Aug 2026 00:16:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=690dc056c=Alistair.Francis@wdc.com>)
 id 1wyiZt-0003lh-Lg; Tue, 25 Aug 2026 00:16:02 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=690dc056c=Alistair.Francis@wdc.com>)
 id 1wyiZr-000270-JA; Tue, 25 Aug 2026 00:16:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1787631359; x=1819167359;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=3x0EIQXxpVJN3GLGeEkunEnFfKM7ylUD3fE3kCpAOjc=;
 b=KpDzj+vkIaTn58v+Com1lGGfK0pNkKWRX6F8lspXQqzlR8gHP5gXOwHm
 ONLXY6OVWBzJPXLhr6D7o1xyZCz+oo16R05mk1I0ctGStAURQ4+6gQxtG
 qrsIbnusmEq7nhJdbijeyGx9ABCDz9SNxv6FU738/+gXOIzxSqR3T+EHA
 m1fgyPHryg7ONod2nQWjMaouy8sUmAoWSyT/A73nSKspnkrn1SjLztz87
 GkRRhNodDO9oRiAc9mHaF8btEykBYHowUFX2pzH+LzWnDH5YQacv5P414
 sZmAsxNUon63Uv3WUi4oRPqLrrWm9djcxDK9zCHwGIUJgyfwvHHMdqoo8 g==;
X-CSE-ConnectionGUID: S3HpvyzFS7uHxFFRy7KSMQ==
X-CSE-MsgGUID: IGu74LmcSQaFpUQn0B+vZg==
X-IronPort-AV: E=Sophos;i="6.25,242,1779120000"; d="scan'208";a="150004614"
Received: from mail-westusazon11010010.outbound.protection.outlook.com (HELO
 BYAPR05CU005.outbound.protection.outlook.com) ([52.101.85.10])
 by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 25 Aug 2026 12:15:57 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Huf2cuAMg2T1J91zvZ7SLSxf9J1MdSWFIuG64vTTqTRduPrXr0ujj55R6bjQ1xyu/Z3mV5Fj04aag8nMJjYND7K201ucbqP3HzA7espj/nnpn6/n5ceYK/VaRRb3kVGt0D8nstIuXlsesnhoO0b64nzRkQdIS5SihOC3DmPihd8lIAE9aFRctnIlbLh/H7ZWnd93ZrXXTQU7RoGEcOj8sHFbOQsA0h4MgsQGPj/b67Exkdlj9N5xXlnuBbNWA8jZ7GMNiaSuUpuu3/ybMMqwZzYlvp81/2Uo4FmkmYLo7F+EH1Ok3bqYMYSZ3hm69Xpm7hok+/wo4zXEcDDx12kzSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3x0EIQXxpVJN3GLGeEkunEnFfKM7ylUD3fE3kCpAOjc=;
 b=ALodzJDrEK6dVMMshZ2+UF4v5PsKjSEGSmglksSw/kKJ46Grvi8aDINUdSevI+c8qcVgcsq7ci3SQeKTOAKZEO8qPQUp+QyUvKf1ux3m5jL+9swgjk5er3vOPgngm9F69QuPnOJ3I4Hgyqx53FVm0v8ZWjlMX9Rgjfw7OcJYo+vrDnUp7zHCeH8qTNJnF3eZUpSINh6cnz9p7JedPZiT6xQK74yOMZuQx+gqMpYpvmitYUtwdgBnaJ52Te1NC4vxpD3Mx9r5c9RGOBVZb65JjCjn2j+CTT5WyWaJtVqaur/peAkd5nnFch5XNM9Nx7UO5s11qmBayDTS9pRFrCmIvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3x0EIQXxpVJN3GLGeEkunEnFfKM7ylUD3fE3kCpAOjc=;
 b=UE1tFE4K8PLeeQ1HE7VAFPrJ+nI1syX5szyGjPBy8Gm/plbJ5O7vAhSbJovt0bp1sdCSeeK6ms+G25/veC/Rfo920maB5+TpLREd7Mn3q4LfrCc5xEAF0h1uc2Tr6+owhSJi29cJCXDM63P00L7wOuUuehhmz2sSK3anYlNh5sQ=
Received: from BY1PR04MB9561.namprd04.prod.outlook.com (2603:10b6:a03:5b6::11)
 by PH0PR04MB8475.namprd04.prod.outlook.com (2603:10b6:510:29f::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.6; Tue, 25 Aug
 2026 04:15:55 +0000
Received: from BY1PR04MB9561.namprd04.prod.outlook.com
 ([fe80::3869:e494:2fa8:9888]) by BY1PR04MB9561.namprd04.prod.outlook.com
 ([fe80::3869:e494:2fa8:9888%5]) with mapi id 15.21.0360.005; Tue, 25 Aug 2026
 04:15:55 +0000
From: Alistair Francis <Alistair.Francis@wdc.com>
To: "daniel.barboza@oss.qualcomm.com" <daniel.barboza@oss.qualcomm.com>,
 "joel@jms.id.au" <joel@jms.id.au>, "philmd@linaro.org" <philmd@linaro.org>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "npiggin@gmail.com"
 <npiggin@gmail.com>, "mpe@kernel.org" <mpe@kernel.org>,
 "portias@oss.tenstorrent.com" <portias@oss.tenstorrent.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "peter.maydell@linaro.org"
 <peter.maydell@linaro.org>, "chao.liu@processmission.com"
 <chao.liu@processmission.com>, "zhiwei_liu@linux.alibaba.com"
 <zhiwei_liu@linux.alibaba.com>, "asrinivasan@oss.tenstorrent.com"
 <asrinivasan@oss.tenstorrent.com>, "liwei1518@gmail.com"
 <liwei1518@gmail.com>, "nieklinnenbank@gmail.com" <nieklinnenbank@gmail.com>
Subject: Re: [PATCH 0/4] hw/riscv: Post-review cleanups
Thread-Topic: [PATCH 0/4] hw/riscv: Post-review cleanups
Thread-Index: AQHdM41n/hsjjpXy7k2Tv9fnaLckkrauKZQA
Date: Tue, 25 Aug 2026 04:15:55 +0000
Message-ID: <5e55fbdc1ae64af87b4084a65a0b946958ae6990.camel@wdc.com>
References: <20260824055642.41098-1-joel@jms.id.au>
In-Reply-To: <20260824055642.41098-1-joel@jms.id.au>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.60.2 (by Flathub.org) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY1PR04MB9561:EE_|PH0PR04MB8475:EE_
x-ms-office365-filtering-correlation-id: ab0aefc9-0c9c-460c-eee4-08df025f8f0d
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|19092799006|10070799003|1800799024|23010399003|366016|376014|7416014|56012099006|10067099003|18002099003|22082099003|11063799006|38070700021;
x-microsoft-antispam-message-info: rlXa7aGB85W1m/Fn9lugmEEmc5lkVZKMLo34Ij7pf2uNKnv0h+Cp5rHOE/czgpQeJ0cbJeIc0vhwh7i5IBlRNG+Bnth0zKxSUQs1fCCpls6AL2HQwtwKLmRz6H75gcScCzZhGJkgjebrtWyFOsKI8yxBQGjo3nbkFvoj/MT2S90bXhdDDNCpNlsg+GYYsg2tfUOOZy6JmZjG3LPDzXBBNEGWw3vEX5wQJSfllJl86OB6lWdHrGFXi7uL5D/nDG3wmbIDmcjo0dmyJqHSObkLivBcfCWaewm6MhuIxMdWu9mae/lfOYghm7sJkbkeT711t7MCcU76hqedoDqSPQ+Txmmq3BtQcW0Gyvp8IBVB+JLkIyp7iO6TPdAdf9uNaf1GuATQtDOySqMg2sJeJFhhjB2BtGm6HRhbnk5MsfwdJuxWlDGmMAKs64UU4sNccifu3qXPcGsEEdCwISigHIewR9FaE/5q94LNE/EeLI851N+ivZ5oJ3SvgCZZZCf5jioBBsa1WjDYVeM2vWzHmQuhtZGnWUcixK+ytFOfo2iDyUgDOxvBOFceX1vwL6y9SUPv8MhoUXec/rZeBS8bwZg56gsLiHqhkOkRlG4koNOF8SrS7TGvoVacON7zUfF63p5gFbLsG4SFvo7Fdxw/YuqVOahNi/E6TPFc5Ozzh4EphNwkQJNdJLnkvzq+dAqUiPuNp3RIsRjvRW2wh0qx233nre7vU5+AEZL8ZhmaEWoD7sg=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY1PR04MB9561.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(10070799003)(1800799024)(23010399003)(366016)(376014)(7416014)(56012099006)(10067099003)(18002099003)(22082099003)(11063799006)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aGRzUm9EM3RXVWFPU0xxVHovNnVzSkxDZjhGUlFEWjdROUZ4RjhnZy9IWnJY?=
 =?utf-8?B?MUdNWGhTNTc4K2IrckxHQnRpeW1VMmhRanlPZkpNYUNkcDVia1ZuRFhWRmF1?=
 =?utf-8?B?RWQyRmpaME5wYkNQaDlRT3dDQTliNjRBUHFTaUJpbkV3ck04dS9qRCtvb1Ja?=
 =?utf-8?B?VlE5cGg0aUZQMnQ1dEErNEFWTHhaSHFiK3ptSDIxdCs3MGNNWlZXY1RBeEFU?=
 =?utf-8?B?eFhiejdsRnBDTTNEZ3l3YzNuNjh5emRwYm9KRUxGV3JKVlJUQ1lrMHlDNDNT?=
 =?utf-8?B?MWx6MldFNkdrL1JJOWZEOHNGcmhKVU9KbEZjUUErMkhQRUJwMmJrYXJ6TWpF?=
 =?utf-8?B?b2JmQ25Gb2xuZGVCVFFoMUUxSUQxNDYwbHpEWHdJZEROcC9YYTlobmRpMXpM?=
 =?utf-8?B?TFc2aDRNaGR1M1RqMzJGQlErYUlPMmd5RXMxbWwxMjBuNjRiVGpBMVFIMG1U?=
 =?utf-8?B?R2MweEhTRHZmUFlmbWxEZzRNa0ZzM1VXQjJSbXVyUjA0UGhzRk4rZnNQVTFu?=
 =?utf-8?B?WUszY2t5b3E4VFA0RkNZYncyeHBvc2RJeVFLa2hkOFg2YjZJYlZDU1lRUmVW?=
 =?utf-8?B?TThQekFjTzJIaHFBTmM4ZVN6ZFlod0VGeGVvdUpJNUpkNnZINlo5QStleVd4?=
 =?utf-8?B?UWYrV3JOcWNqakpPdGRyb1JENFlySGtUOVJ4d1hpRGc5ZmFyaWt2STh5Qkc4?=
 =?utf-8?B?Z2kzeHN0WnMrQ0tMU1MvSVdXVjF1V3N5VUZpZDdmdW9nMkowTmFCTkczK05r?=
 =?utf-8?B?M0dLYzI1N2xtbHBnRFNwWmZKekJnM3oyekF2am1ydk5kRVZsb1VLNFNOVXlp?=
 =?utf-8?B?dGEzdEFGcEl5OG1SRmJraU4xbExsL2U4OE1WS0ZNMXZlVlpRTzF2TXM5cXpa?=
 =?utf-8?B?b2ErRXk0cnkrZjJHWjhINThDSDM2dnFmMHhlL0VzZWljTWw1R1dHNVRZS0I3?=
 =?utf-8?B?RCtEd2dwVjBxQW9DNU00b012SG4xM3I4aHFtNTBZUzBZVzRlZTEzYm1mVXBs?=
 =?utf-8?B?N1V4R2RjM2NhUkZGRDFPRDBMbkxEL0sxWWlVSVVVYVEvNWtjUlVEN0dGN2ZM?=
 =?utf-8?B?YzJjRC94WEY0RlhSVkE0U3NWakN4WDlMVEhYNU1mdW9KQmdFcjcrVHRKVWZ0?=
 =?utf-8?B?ZDlLWVJ3M2RlSWl6MG1BOUZWMU9lRjJyd3laOFhkZUo3R2N1RDczZ3dhWmZt?=
 =?utf-8?B?NWU2d0lSVERBN08wV2RGWWdkT0taSEdhMU5TWlY5QmxOSjdXMVFObkU3OFhl?=
 =?utf-8?B?T2FLWjQ2dmhWYTZaNGd6U0JvdDQyaFZaN2M4RzZXazR4SHJlRG4vdVp0alpx?=
 =?utf-8?B?M0o4a1paQVUwOWkzWk1Bbzg5TjJuaXhGR3d2ajRFNEd5TzBjWkhiNzFYb2RJ?=
 =?utf-8?B?ZjhXNVAwNjVPKzIxYVZ3M3VKS0ZuREQ1MVJTSVEraHMxaEJERFJEcm83N0p4?=
 =?utf-8?B?TFBoNEM1QzNuZGVQWUROZXR0SzI0VEZmSHVkVDlOTjdLdlUyTjFtc1p0ay9u?=
 =?utf-8?B?L2wwNDNEeUg2eXpIWGh1TWg3b3FsVi9WOTFGWG0wRUV6RlVMRlRxMWw5UXhW?=
 =?utf-8?B?bmJJekRsN2JMSk5YR1JzZG5CaWY5OEZZZEZwcVFXbFNLeWNhbHVEZGJEc2Vx?=
 =?utf-8?B?dWhFYlFKc2dOZ1FNVldEMW1BUlc4NGx0VERpUVdRRU5CUzR5TlVJcFlJVCs0?=
 =?utf-8?B?bnFGS3hqY0M1YVVzWmVtN1dOeEpiREx3WS9Yc1p5djhNUmFhdGpPcSthRTBx?=
 =?utf-8?B?bm8waklMZkEzN3dzZG8xZmZXc3ZEcVE0RjRLazNTMWxoMlVHY0t0cEtwblBO?=
 =?utf-8?B?YWtiN0dNZXkydzR5VExaWDZBTy8wRkhzWDlhTi9YL29PU2QxSVNZTTNUS2M4?=
 =?utf-8?B?SzVQcytIYVAxRUpMMFovSUh0dExwS0c0ZUo3T3hUbi84dW1rTXVVMFBYd28y?=
 =?utf-8?B?b0M0UUE0TXpPZVdXd2lpSVJDRmtJYTdKUVltNlFPelJMQ3pmb2dUYXdtbkUy?=
 =?utf-8?B?QndlUWxzdE1pS1dHVldCZEJJZEE5L1B2bENLaXlKdHZJMVUwUThlVUZ3QUln?=
 =?utf-8?B?R2JRakFzbktlaTcwUlFWWUVSQ2RYMVc5WjRKZmt2QTZHbm5jNW1XamVVRndH?=
 =?utf-8?B?bTYrRjJ4M2o3R1dYK05rb3B5SStWZ2VINXUzejFFZjFxNGNSK0JwY2JKV2Nj?=
 =?utf-8?B?cFlWRTJ4Y3NZSHh3M3ZmSHh3NmQwQzJ3Z041elF3T2ZCbWFML09pdjdXaHNY?=
 =?utf-8?B?N1N2RHkxNlV0RURQTGlmWkZKWkxzT0ZBTTVad3NXKy83YWVZTDlzaUVHWnps?=
 =?utf-8?B?QWx5b0RNd3lseWFxNGIzVE9CVGdsUWd3UzFLSFhyaDhhRlE4K3lwUS9kYmZu?=
 =?utf-8?Q?yRdJ8Jcm9v3uQMWe7diiKfF4NktHv8WH5J7aQRdEVkTvb?=
x-ms-exchange-antispam-messagedata-1: 87+FpmiE0lt4aPsEnn1Ei2TFHGM5DdlIis0=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B3109AF9C3A86C449746970E70537E6C@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: ZpX5ZFlyZ7kjseoG5ZJBt51wb/lei+dss7xBcPZJpatgd2arGUDXPD9MLSiLzSDGPgiQyXxLU9nt7CEeyzTesiOSzNQdRDc/cQEzU7Gn0Ho8bOsOo0upIPJ3B4j38ClQqCuTL7OJI+wp3euDVRUJabQ/D8DMYFlNj05I2PSj0/hdISa6MGT7mlugiqqgaouUxncD4lkoujDd5xoYD5asUyoxceHKCN/nlcmt7bvylSOj6u8YNudaC9hmaSebij+Uqk7q8h0n2+Mw4L5vopPWsb/V0+IsQdSmqz5Vo3BvxyQ+5L2ScDfLLqEZ8XBJKT3hl/VA6+QtxZSxvGnBWwfzFg==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: nbZxhbYEUppt/0iI95Vz8PSok69Df7iERLhZWxNU8d30bXvKLi7eJaeT6L2pd/5lQZzy/pk7dOnnLPFGjHGg/YNjnrzIaWIBMGOF7TJ5zuya6+kov7QFMxxX0Sp/ASiIib+bzFfm39gzrCQ7muQodNXSTYgPLzN3Gjqm0vUkuJ03A7CmpcTw44x2HkbTF1d5XcAjSW7gKOAdEizhCOZuG635Tjg3T+C0IsA419/z3qotGnLQ9repYOabZBqYH6OEQ1ou9dVyzEnvuaejIaetM56Uosr0dvmNIyocjIH8lqUo0xQp4z84JjbKyK6Lk0sLlBJxcN2V6ZyCz6mFc9sWjtNMztHaDifvKPQesx8AvLEEFyfTwy8AV3Mw4HgYjXOocruglb3UGZZTw6VbWPTyuWS7xDKn1eguoAu4jp3PXvBdsQNMiABE/PhECnH4CJuiOq9aOdicJRgCUKxZWsHjb0G3D0AmYRX4gVR4+iRFFsjv9pyG5RlShUSFddmzPWuTCCxqBkyCH7RRn6/BB6/LsoUki262E65Kt948anRLYh2Au5LX/6oqNEn7hGMRFmf15/gu2XL8Z9qktomXUrWpX3M+QnTmGZHYSMBZuRgJq+GTGHZ7Pamx1tH4szHcYL2X
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY1PR04MB9561.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab0aefc9-0c9c-460c-eee4-08df025f8f0d
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Aug 2026 04:15:55.3912 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eXODHWJejXYwGUL4k8Nxg7y5pnHxjVp37WDxdIqvvVccVJ53e/oy+atTs7PKRCMMc3cyEcre5uKzRCwxW85j4zGrPYuDEf3KFkTsJOt8bSY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB8475
Received-SPF: pass client-ip=216.71.154.42;
 envelope-from=prvs=690dc056c=Alistair.Francis@wdc.com;
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

T24gTW9uLCAyMDI2LTA4LTI0IGF0IDE1OjI2ICswOTMwLCBKb2VsIFN0YW5sZXkgd3JvdGU6Cj4g
UGhpbCBtYWRlIGEgYnVuY2ggb2Ygc3VnZ2VzdGlvbnMgZHVyaW5nIHRoZSBBdGxhbnRpcyByZXZp
ZXcgZm9yCj4gdGhpbmdzCj4gdG8gY2xlYW4gdXAgYWZ0ZXJ3YXJkcy4gSGVyZSBhcmUgdGhvc2Ug
Y2xlYW51cHMuIFRoZSBwYXRjaGVzIGFyZQo+IG90aGVyd2lzZSB1bnJlbGF0ZWQuCj4gCj4gSm9l
bCBTdGFubGV5ICg0KToKPiDCoCBody9yaXNjdi9ib290OiBNYWtlIFJJU0NWQm9vdEluZm8gY29u
c3Qgd2hlcmUgcG9zc2libGUKPiDCoCBody9yaXNjdi92aXJ0OiBVc2UgaHdhZGRyIGZvciBJTVNJ
QyBkZXZpY2UgdHJlZSBhZGRyZXNzCj4gwqAgdGVzdHMvZnVuY3Rpb25hbDogQXZvaWQgdW5uZWNl
c3NhcnkgcmVtb3ZhbCBvZiBzY3JhdGNoIGZpbGVzCj4gwqAgaHcvcmlzY3YvYXRsYW50aXM6IERv
Y3VtZW50IFFFTVUtb25seSBJMkMgZGV2aWNlIHRyZWUgbm9kZXMKClRoYW5rcyEKCkFwcGxpZWQg
dG8gcmlzY3YtdG8tYXBwbHkubmV4dAoKQWxpc3RhaXIKCj4gCj4gwqBpbmNsdWRlL2h3L3Jpc2N2
L2Jvb3QuaMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8wqAgNiArKystLS0K
PiDCoGh3L3Jpc2N2L2Jvb3QuY8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgfMKgIDYgKysrLS0tCj4gwqBody9yaXNjdi90dF9hdGxhbnRpcy5jwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKgIDEgKwo+IMKgaHcvcmlzY3Yv
dmlydC5jwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCB8wqAgNSArKystLQo+IMKgdGVzdHMvZnVuY3Rpb25hbC9hcm0vdGVzdF9icGltMnUucHnCoMKg
wqDCoMKgwqAgfCAxMSAtLS0tLS0tLS0tLQo+IMKgdGVzdHMvZnVuY3Rpb25hbC9hcm0vdGVzdF9v
cmFuZ2VwaS5wecKgwqDCoMKgIHzCoCA5IC0tLS0tLS0tLQo+IMKgdGVzdHMvZnVuY3Rpb25hbC9y
aXNjdjY0L3Rlc3Rfc2lmaXZlX3UucHkgfMKgIDQgLS0tLQo+IMKgNyBmaWxlcyBjaGFuZ2VkLCAx
MCBpbnNlcnRpb25zKCspLCAzMiBkZWxldGlvbnMoLSkK

