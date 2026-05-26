Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84E70CD5BDE
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 23:53:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wS1Zk-00035i-1k; Tue, 26 May 2026 19:52:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=599a94ef2=Alistair.Francis@wdc.com>)
 id 1wS1ZU-00031X-62; Tue, 26 May 2026 19:52:28 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=599a94ef2=Alistair.Francis@wdc.com>)
 id 1wS1ZS-0006ye-K1; Tue, 26 May 2026 19:52:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1779839546; x=1811375546;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=L9KaV+ebBY5jX4qRdm1izFMcxJbgUoGR+yAcTarj9dg=;
 b=JRIzyOhwn6csR3G2C8LfKRivBTANYIp7rMV+Jy3Q4IaF4x92K2kj/Ang
 2TpTe/rDrRvWQU6mysUU15x12+9gIjUh/PFHdJbqAK6XTw0UC8C96foaF
 eW00JZR7HpeN/4iUFT06ncv7+FLRyRJPdPmpQ32A7Io6fQt29Cd/HRi9R
 KLH+EFJw48hu3ZP7tPoQMebZXnEwA1u69F/sGcDJnPKLjdhxKoD0TuLr+
 YYeKLZy65NsJ7b93MKB0T/67/3cmke/zsMWRuVDqOeuGZZvZ+63tSDVI5
 l4MbWS+EedPl64FJ3OuFTFGpRJ0/WHGEU6AZZfYuIGGUlXHkB0/lm3iDO Q==;
X-CSE-ConnectionGUID: NkoiSqSVSVOdSEM3gAftSA==
X-CSE-MsgGUID: 4ae5Cm0WQZS1OZH7D+o0/w==
X-IronPort-AV: E=Sophos;i="6.24,170,1774281600"; d="scan'208";a="146341441"
Received: from mail-westcentralusazon11013045.outbound.protection.outlook.com
 (HELO CY3PR05CU001.outbound.protection.outlook.com) ([40.93.201.45])
 by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 27 May 2026 07:52:23 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RQUNXjnsX7bnSgK5pmnZcHCQAtP6d04cL+Intw93q908R3AD/IxUud4CZtatQtLIL8shcou6f91haJI+/f0FysOBjqr9mCGXUk40n3ktjRrPYzKNJ2mtMlzzfMTz9NDjDdbQTDRU9tQABtSRGb3iVL6oxsjt+zS+u+lhYS06tscX+cVDc4SvA4yG8L6ar6vQBypgJkfS22j3km33XvdEUhJYZonCEHiXkIXgH2MyNNPErT4eoIL/jvfnSoDDOs5FFYS5xvQVLIxBoAQS2Pid9isuA3OqFpeOvLPlIyibCOPuiklC5SboPCzoTUb5CEhG0IXMJig6ufViVFmZPEEtLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L9KaV+ebBY5jX4qRdm1izFMcxJbgUoGR+yAcTarj9dg=;
 b=bBpWD0SpLazxpidd4Ch6hdcd0dMMTWrPsMmqQj6mxIr0jy38CHGNBE8KRO+cbBClt8LuQz13iVUnfL9IqhaUJe1VaF+LsTuDS2VwmVyCmKNQkd0S5g/yA7U15aTftO4NEpasxOA/2JFOE2Zp8y+W4RoWuR73rRTL3uyGeHPYmUrfmz1nNMeSSZyAsescDzozLVxXszMZ5v5vScDTorlb+j4GFi0eRD5HRqErL2VvV+4hGiO+WoI3nDfwfInmJkAKOoC+6WIgTaN34F5XlO/LROSm3PZWo+5lDPufdn/+6jNLlPCviSTNSyfRSOS8wBxJ9cEjfax/33/K5jazGnVA+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L9KaV+ebBY5jX4qRdm1izFMcxJbgUoGR+yAcTarj9dg=;
 b=vX9oUORCL7vtdHAOsEbowaXIl+2BOV95FZKDg4ZCjf17bCTqxkqKlKF5L02fDNHIDskCN5OG5dAs8SmfCsw/EKBtGDgvOzJ0b1dpYGPBr2aZNml/MvQTPKtMFDkBaWDIbExx0nxuPcGjN19y2Wrd3HK5Z+kRcE06UCHmbeWz4lY=
Received: from BY1PR04MB9561.namprd04.prod.outlook.com (2603:10b6:a03:5b6::11)
 by IA3PR04MB9087.namprd04.prod.outlook.com (2603:10b6:208:525::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Tue, 26 May
 2026 23:52:21 +0000
Received: from BY1PR04MB9561.namprd04.prod.outlook.com
 ([fe80::3869:e494:2fa8:9888]) by BY1PR04MB9561.namprd04.prod.outlook.com
 ([fe80::3869:e494:2fa8:9888%4]) with mapi id 15.21.0071.011; Tue, 26 May 2026
 23:52:21 +0000
From: Alistair Francis <Alistair.Francis@wdc.com>
To: "fritchleybohrer@gmail.com" <fritchleybohrer@gmail.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "palmer@dabbelt.com"
 <palmer@dabbelt.com>, "daniel.barboza@oss.qualcomm.com"
 <daniel.barboza@oss.qualcomm.com>, "chao.liu.zevorn@gmail.com"
 <chao.liu.zevorn@gmail.com>, "liwei1518@gmail.com" <liwei1518@gmail.com>,
 "zhiwei_liu@linux.alibaba.com" <zhiwei_liu@linux.alibaba.com>
Subject: Re: [PATCH v2 1/5] target/riscv: Remove unused tcg/tcg.h include
Thread-Topic: [PATCH v2 1/5] target/riscv: Remove unused tcg/tcg.h include
Thread-Index: AQHc7P+J3adNrott9kqgNUbY3Ozuo7Yg+2GA
Date: Tue, 26 May 2026 23:52:20 +0000
Message-ID: <3c1e036d171d260c58b79bac79a665000875af4d.camel@wdc.com>
References: <cover.1779792111.git.fritchleybohrer@gmail.com>
 <32c6c8ac5e0eb7a8da660054bb9e59ddfc154e25.1779792111.git.fritchleybohrer@gmail.com>
In-Reply-To: <32c6c8ac5e0eb7a8da660054bb9e59ddfc154e25.1779792111.git.fritchleybohrer@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.60.1 (by Flathub.org) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY1PR04MB9561:EE_|IA3PR04MB9087:EE_
x-ms-office365-filtering-correlation-id: 73832867-b5c8-48ee-d08c-08debb81d3b4
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|19092799006|10070799003|376014|366016|1800799024|38070700021|11063799006|4143699003|18002099003|22082099003|56012099006;
x-microsoft-antispam-message-info: BCpkJQDAK2DvaYXLFPvRlIrE711FccnynoFYX8pUBhZXqqm+1HYLU6wyHntTEgyGvnXnFWS40KGRAsPzo9lH5Cwtki1AtgdozbzzmcjpKPXOvuIJ6gxOi+1n5p7v1JCZeCX45ESw4p6p9FmrJh1E25hc0F6E4+VsYts/BG6ECa5FjYCauMKAeR78g5Tjpi0IXiTY0N66hnfBZAkZR1FRH6IVliB3Dobfk0gHRpOAsqC7WbcID1zI1rwNZm1Tr6rrSmVR69RlvOmO69v9DdvWWDYqmqZnlE2XcCGpAgGb/6Wchtbp9C08BajMpIq0Z3Od0c7UmIEc12z6zfWAZKnkMnrxhLgr7hLfneYL8JEzPGbJghGkmmtcRvwyLEKtfKXMzN7rq3zOADejEM/iCYScmvQyi9y7qqbBXIEOYhppWz4LeqqwI03CsF8XBBNy1k5rbG7vd4z0C5Vo1AgEreYyeBfb7JITOhi3eJHy30b88MkE1LfBAlRk/Lw7SefpK8R6UAR2hn6kJxOjhK/YpkGT30X6w33DO/LuOtyPhX7JBTfCnhLlGZa8pikY/IHotUUEDxteJ9/F38VqM02mmwuKRzkANV6NcWZ5ARvbfciu/Vq9LYI2NNS6gINVdJFprT/2b1eywSQEOJNCfnu+jCceyGhg/QxaLIOo3RHixo6kMr8SQjR2Mh9zp0g3DYo3GPrybDkZj0wgyNhcM0ZaafglJtJeFeA9lDotyS2wbw64Z4djbkAi+lOuhf0ZRRETfT8q
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY1PR04MB9561.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(10070799003)(376014)(366016)(1800799024)(38070700021)(11063799006)(4143699003)(18002099003)(22082099003)(56012099006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?S05CRVBKd0tINzRuSHdGdkNIbGVlcDhiVjZlUEdhckczMzAyelNmUjkrMk41?=
 =?utf-8?B?YW1OcVZkdFQxZHhzQmV2WXFFUW1KR1VYaldxWFZyb0dObU1sOFc0L3BZZmR5?=
 =?utf-8?B?aFhYbXdsMTRIcjZocmNJc3FCUGUvKzhWWmtya3RzblZUWlVRQS9LZExUczh3?=
 =?utf-8?B?V3pERitUTnhVSElVMUFWTDVBTm5DbjIvRjlEdithYzBabHpZcXpYWnBleld6?=
 =?utf-8?B?NTNZbWhCcmFOWVdHVVR4Mi9OYWllaVRKcXp0eHEyWGZvK05IK1c5T1FhblVs?=
 =?utf-8?B?aDNoS2ZLaXF0QUVXejNIOTQybzd2Uyt0d0Y4YUhZRk9QdXA5MHU4bzlLMHdK?=
 =?utf-8?B?VVlpamVOTERENjZzSUV0UVZvbXV4eWNMUmV0U2Z5YTdUNUpQY3RCWDFIQXhU?=
 =?utf-8?B?SmFqNkw5YXNnQ0tUK0pITW16a1VmT1o2WEx0V1ZpZnRkeituWjdMWGMzRUNh?=
 =?utf-8?B?U1c4Z1phYjhrSmtuTHB6TTZEQWF3U25pTW0wcU50WXhHdkYxRnJYWDlzRnJN?=
 =?utf-8?B?NFByVGJGZmlRLzU0SlAvUzhwdU1qZEJmeC8yMktiTnhqai9Lbm0yRG1tU1dw?=
 =?utf-8?B?bUVOWkYzeW02dE1ybUNsOHRoVFZOR1R4Y1lWWXByWHlRZ0ZUMzViR05rSmZq?=
 =?utf-8?B?Qlg5N0FIa1hrYXBUMXUwbnZTS2pGcUs1Q3FEaWJWMjJPUXl2d1dDVzRIeDZy?=
 =?utf-8?B?dWcrVm5vYmFOaXpOQWdvU0VwNFZ4SGorVmFOZEZyMS9qS0RUWnBWYzJPTkJ2?=
 =?utf-8?B?eUtRRDQ2SnNCRWQ4Z2FGT1FINTJ6cTgxLysxVGNWamFOZFRiZy9rYS9rYmRP?=
 =?utf-8?B?UVlXcWlFSVV5U3E1aFMwTjdHeWtzbWpFbEZWdVl2UWx4ais4TUJuTjZsT2p6?=
 =?utf-8?B?RkpYTzRMdVVHemFNQk83clhaT2cyV3BGMnJ2dXRIV1BXb2p1alFaQ09KU2w0?=
 =?utf-8?B?SlVoY1kySGVQYmlDMDAzSzB1aGNGcjhSRThrNzF3STlGSWs1SkxnL3IvS3VW?=
 =?utf-8?B?R2lMYjNDU2lBQnNNSC9SWlBDZ0YwaFBDQkFDZXR5ZHQ0cSsvMmQ0LzZQR2s1?=
 =?utf-8?B?eXZQMUxlQ3Zvb3FBS1ErRG5pU3JNdnFSUC9OUGFZU0E5dGk2Z3hRZ0Zaemxk?=
 =?utf-8?B?MHYrbFE0V3BkdW9WRkRlaTVyaWdPYWVsR2FkaUhRSHJmTGsxRE54d1d4T0g3?=
 =?utf-8?B?V3pNa0F6TFhRbHA4c3lBQnlNUS9jK2FwZVp1cnBFdVdEUjZrVTBCZ1VwQkZp?=
 =?utf-8?B?QXdvK1FlakhjNmorMG9YbjV1MlJCNk4rbCtZUmh5d3dNdlljUHRLTHVWYVEv?=
 =?utf-8?B?RXdQMmJ1ak5TK2lPZm10UDJtYml4YnhkaWN0cXFUbEFUNlB4R2hPaTgwZUJF?=
 =?utf-8?B?OERuVkh6ZUNyckdvSEtNazZ2cjBEbHpGbGp0T0hCMjhmOTRPMk5MYkRoMW1Y?=
 =?utf-8?B?MHp3Q0xDSUVYWm5ORDZDdlA1KzU4clZRUGVuVVpvT3hsblg0Z0ozb3Z2N3ZS?=
 =?utf-8?B?M3BMdGlQTXNESmpyaFRhMVV3ZEhDVG1Pd3pXN3hEbWcwdWk3dkVvNjE1WTJ6?=
 =?utf-8?B?Ui9aYzd1MWI3czk0L25rNmxZaHBzTEMrRGN3VHVrVWpsb2pwdzVuM05UTVVT?=
 =?utf-8?B?aXFhSWU0M2YvK0oycFlsMC93RHlzejdkVkZ1WWRVTkE0NDNldkwrM2lDSTk5?=
 =?utf-8?B?VVE2T0hDajgyRldOUDdvUDVLUGp5NnVKNExwbVdYelFyTnRTeWRmSFozbFJx?=
 =?utf-8?B?T2N6WG1WYWswL0hzMmZPamI0Q2VKWTNLd0JBWE5UZW41WFN2am85aGtJeFVB?=
 =?utf-8?B?TG10NWxkUnRtVGxIQmJWMHB1NjFvbWdXRlhMNWc5R2tUM3Z1L0hDTTNJQUpK?=
 =?utf-8?B?aVVyNklqUkFCMWQ0RlU5cXBjQlREZDhrbk1hRGRYenBqVzJtajdFL1Ewb29H?=
 =?utf-8?B?M2tTcXRCMkNzaWtlczhXd3VMdTdUSUpuNCtSN3Eza3M2YkR3YnZ4TkNPK0J6?=
 =?utf-8?B?WjVBVzlEaEJsSUtrOEI1TjJLRVRscStCUm85NlpHZTJ2ZG5yMzYwdUt2ZHcr?=
 =?utf-8?B?NStDNzlrV1IwMGVRdzcrbTY1U0ZjM0RLU1IzMmNEMERVMjNnTG8xUWJ1VHk3?=
 =?utf-8?B?azNvdUhaMFg1MFI3dUMyVnZML3daaTh1VWk4YXZnV1VzQ0JwNXlwQ1Z3VGVu?=
 =?utf-8?B?WE9FN29nd2xPSXptSjBVaG9tVk9BNEpEMEw2ejZNaDhLT1NESWRSVHdEcWRy?=
 =?utf-8?B?bTR4enZZTTJVWUZ2Qmd2cjJWcUl0L2lOZXlaQU41WStCWi9YZFZFMUhJVmZG?=
 =?utf-8?B?bzl0UkxGTzlXbUl1RDhnUWx5OThMQVV2YytnQ2NoQlpzVStOVllJaEtMbkho?=
 =?utf-8?Q?SWEB4Gd3IO5mZpe8iG1qeKT6GtAKEMiEJ/CKnCHmZ4Kvp?=
x-ms-exchange-antispam-messagedata-1: t+PhgQkf3J1idKjLeioxjTWna3NR2duRf2c=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A4D2F27FA6FA9444A0AE8AD19419AF41@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: lyOwa6GAnzXKqeary974VCk7eH5sLfjfdX8SEug9NvCZD6Ds7VZD3+/L333FDjd76H274QSjXfE3uxrJtJByHrhk1e+63jJ8BVw33zSe7QASyX8ArwvlqMORoSV+fWOqgYe7r08mlea6amJmvFo5cFnB2skAMIPBB92DK8Vp/eDf3kETQSFinGu+Nrjsw1JEr7yw/BEsTFB9MJxxclFbQOIjOoeynU2VnOKtyjDlpc+z3d0w/eJ1uKVf2Vq/vWAK5BepDYhIAfOKnpFkcm7cP/XBogty6eS2/QEcfn+/j6HVLBY7LK+MfAhhN6qQC4S50XOZc6a8kCP0gMd9QofS2Q==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: qL03NJhiuVFQ/xHyaj9v0Lj1nN94p9PXcONMy1o74aVyHM/X6TtkRxYDSSyLQcmMYfN+at6PnIuW7dDMGjMOs0Iuy2p5ynW9xkqjATBwpeRdT/NwY7tD7DCLQUe3Wz0rzAAIopXGxDudFR7DVaJREaW100KR1QiNlcnGJfVhfHs6GTm0m7HUjcDUfBCCPQ7E5a6MI/9nw3ovhnJAo8X5/5KkxoH/ybMUoyH5/WBB/DzxlFEzJq5Czl4Di9ZRMW7hx0UY2dju646172HWHjFjvCF5qnjf+X6huARvOKy2cr/THJEIrn7Ls+8JePfUENXEnd34dShE9DZzLqe3J5YlUPe2Z03TUuqAeH50nJomNO0eMt7k3cbyS2HROvRJAmrrl1WTbb5RpdiyHEs6WLmWkF1GauhJvrzl4Tb1kHUgIfDqXxxaNlTJ5gAr96dHJqBwFm7yFt+tZtddQ0yrD0w/osGZC3OIfVIF57AyalzcBRTwzu8Xm/Xo9l3RYl5jcRxXqvn9Uz9OGNZP13SA3T4boK8xAZHIJACqLizuwngYVC8cTHB1NpUUmJ3eKKcCFfP/qZKagOPkpo6NOojMaQUco0h1UOnVzqPLHZne6S8OQtLcby9UMyq1EoNL3DKp3i6D
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY1PR04MB9561.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73832867-b5c8-48ee-d08c-08debb81d3b4
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 May 2026 23:52:20.9337 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8r4aBiJn6BVyUYOeKdZ+yNZxT5hOq7OCaFGEHUpWyMjlSjSNyssDGBb/x0AkKQb6c/UWvtbkKiexQ3YzWis/hH+GtEh4rKx3prUn00DyxzA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR04MB9087
Received-SPF: pass client-ip=216.71.154.45;
 envelope-from=prvs=599a94ef2=Alistair.Francis@wdc.com;
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

T24gVHVlLCAyMDI2LTA1LTI2IGF0IDE5OjA0ICswODAwLCBaZXBoeXIgTGkgd3JvdGU6DQo+IFNp
Z25lZC1vZmYtYnk6IFplcGh5ciBMaSA8ZnJpdGNobGV5Ym9ocmVyQGdtYWlsLmNvbT4NCg0KUmV2
aWV3ZWQtYnk6IEFsaXN0YWlyIEZyYW5jaXMgPGFsaXN0YWlyLmZyYW5jaXNAd2RjLmNvbT4NCg0K
QWxpc3RhaXINCg0KPiAtLS0NCj4gwqB0YXJnZXQvcmlzY3YvY3B1LmMgfCAxIC0NCj4gwqAxIGZp
bGUgY2hhbmdlZCwgMSBkZWxldGlvbigtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL3RhcmdldC9yaXNj
di9jcHUuYyBiL3RhcmdldC9yaXNjdi9jcHUuYw0KPiBpbmRleCA4NjI4MzRiNDgwLi4xZGVhNjY5
NzJkIDEwMDY0NA0KPiAtLS0gYS90YXJnZXQvcmlzY3YvY3B1LmMNCj4gKysrIGIvdGFyZ2V0L3Jp
c2N2L2NwdS5jDQo+IEBAIC0zNiw3ICszNiw2IEBADQo+IMKgI2luY2x1ZGUgInN5c3RlbS90Y2cu
aCINCj4gwqAjaW5jbHVkZSAia3ZtL2t2bV9yaXNjdi5oIg0KPiDCoCNpbmNsdWRlICJ0Y2cvdGNn
LWNwdS5oIg0KPiAtI2luY2x1ZGUgInRjZy90Y2cuaCINCj4gwqANCj4gwqAvKiBSSVNDLVYgQ1BV
IGRlZmluaXRpb25zICovDQo+IMKgc3RhdGljIGNvbnN0IGNoYXIgcmlzY3Zfc2luZ2xlX2xldHRl
cl9leHRzW10gPSAiSUVNQUZEUUNCUFZIIjsNCg==

