Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00A96C61DE2
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2026 01:21:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x0qhM-0001XQ-C6; Sun, 30 Aug 2026 21:20:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=696fae14a=Alistair.Francis@wdc.com>)
 id 1x0qhK-0001Wg-HW; Sun, 30 Aug 2026 21:20:30 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=696fae14a=Alistair.Francis@wdc.com>)
 id 1x0qhI-0000LG-FX; Sun, 30 Aug 2026 21:20:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1788139232; x=1819675232;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=8bnv6ISPXuYs5MbUcWbhlLgE9RpbPODEs99KTGI92uU=;
 b=Uzggi4Si84tUlFe513zl6q00FO/9unIrWfIdeneAJTUJnRhkEo86bwXm
 fzOdTSHMCcb5KJJ9JIqby1LsaeaBzeqMmRbTwP/koDdHRkousONbbSkxP
 FGFN9zq+h+zvwFoSR57cYRfnnaxyBjujBJByz4z78cwBjNdjnFwA2VySi
 bHDtOCGW87CIdkTSS30jP2K4aa7DmJJHT14TXu7Zh0pCF2OhwqQ00NcWq
 cd2gV2GC192StAiPne1xlZZfBONSGOzyxxgXkfxOFxr8OIxErY3q75enw
 woEoNzQUYc57WjbHgiWPrwoMPdsi3VUGFViOj1ygUy2jw0Q/NEdymaWvJ Q==;
X-CSE-ConnectionGUID: Ie8ArxgdQMCklsgEHl4yvA==
X-CSE-MsgGUID: SvHXXVggQ12SfI5WjG6PJg==
X-IronPort-AV: E=Sophos;i="6.25,252,1779120000"; d="scan'208";a="154586651"
Received: from mail-westus2azon11012015.outbound.protection.outlook.com (HELO
 MW6PR02CU001.outbound.protection.outlook.com) ([52.101.48.15])
 by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 31 Aug 2026 09:20:28 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PvhUEj5jHmk5HDJUELuuQNmnxxHByo/nzbNyl1TY0jlIDdecicJJLnEKD+RYAIBlJV6Kw9ZoeETLTLyg9gF23II2u36BjNFQiuNbcvCdbRCWZgWDfzKm6RNjfHAvMD7i5DaNx6jsX/lssYSXllr7H25gjKA0vd2wo8NrwQ4tgpOZm7XxpTwTLYqNFblol2iSUhHmH11F5TBp17dBfnkvgtR6Zb5EbbyyxnqUBThG6x1kyi00TZAsa3WseAsxbcuI9BvLNpJSaUam2wRF+rNzs/Qw4Aysx1P86qGnA0hzvaSelBFQRe3kpLancwrFkoOwgIODGnacJH5K6Zw7DWUhsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8bnv6ISPXuYs5MbUcWbhlLgE9RpbPODEs99KTGI92uU=;
 b=dD8vYzfWxmE/sUonTEKn3CQPWxG08GiQyo9tcAnX/K3rcSMv2dp9nNqcPLBDSHk4G4ZX22rLY4EmYpzATjFtkq0DPzv4PtovPqyJISquAJfJNTrSgmRt2mRSpfDQ4iNKTzymJhgccQPdOHDpV8s0K/sHkacGQxzRhNUWuHimG8lThHYDccUa126ZjE/hyYQDgisk1IRBpHxS8vRee7Tk1TBSM41LdlGFQ/AYuqkCpTXzxlA/jsViP5XQtQn+FujQYKXa3BcShyBfmgnrkQl1VcM2+wgYfQ+Fpw1RcECPY2HPjvGYocyU7iIWARZEYctGPGttcDmDN+vKGUwuMpSKUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8bnv6ISPXuYs5MbUcWbhlLgE9RpbPODEs99KTGI92uU=;
 b=i+zTarh1jGjbr7XO2i/iXbIx0KcxiIYPLo7Md5vgIlOyiWBtVQ5jfR6mwDNIyCjvCGTauutXRahmSqlvxGnnYuFSf3rSDoLUTe5bVHD6F1gP2EC0Lg/EhWN1e0O6486urLEGvtW5IVbjRH6sOrUm94/EeRnUz4YSMmtwNkDytZI=
Received: from BY1PR04MB9561.namprd04.prod.outlook.com (2603:10b6:a03:5b6::11)
 by IA3PR04MB9402.namprd04.prod.outlook.com (2603:10b6:208:505::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 01:20:22 +0000
Received: from BY1PR04MB9561.namprd04.prod.outlook.com
 ([fe80::3869:e494:2fa8:9888]) by BY1PR04MB9561.namprd04.prod.outlook.com
 ([fe80::3869:e494:2fa8:9888%5]) with mapi id 15.21.0360.008; Mon, 31 Aug 2026
 01:20:22 +0000
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
Subject: Re: [PATCH 06/12] tests/tcg/riscv64: Enable multiarch system tests
Thread-Topic: [PATCH 06/12] tests/tcg/riscv64: Enable multiarch system tests
Thread-Index: AQHdNeJxvEXPcEQEyE66jxH93uOTi7a3YgEA
Date: Mon, 31 Aug 2026 01:20:21 +0000
Message-ID: <c06fb2b3b4792ad1d838571b124cde055dba2db6.camel@wdc.com>
References: <20260827050953.67184-1-joel@jms.id.au>
 <20260827050953.67184-7-joel@jms.id.au>
In-Reply-To: <20260827050953.67184-7-joel@jms.id.au>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.60.2 (by Flathub.org) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY1PR04MB9561:EE_|IA3PR04MB9402:EE_
x-ms-office365-filtering-correlation-id: 9e169a3a-986e-4b8b-bfab-08df06fe0719
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|19092799006|376014|7416014|23010399003|1800799024|10070799003|366016|3023799007|38070700021|6133799003|10067099003|4143699003|11063799006|56012099006|22082099003|18002099003;
x-microsoft-antispam-message-info: /SJM57gH4k6wuT6/n6eDCkZh/xZY15GolQ3pL6e9zri5VhUWe/EGYodzYZjcTQY/HJQaiE8S4Dmg7vsZtw7gm1UfTQYmp+SYM8Zn4RU+k4MIc2ludAcHD1EH3pH0s88Mnm4xQ8AgZnGQK2OSMxdcAWXxN+N30mb7mbQOjA82E0RaX85GROBsiJ6YMvLlJF63WC1GRvfJjxQEAS/mk3oR3V7tcR358CFZ2Uq9gZowN6IEdmFHmVLnkue8hHwG1ErZEOFq+Cey6Bx7XOjATNUsmfbxZCngVR0ggPdiuzm1GpHtTOMzeYkVfdc5Pe93aQ1LCHwMn6F8sgmC46SWHgKGdM4dSeNB4A8xY6/ZXpuXSiGNBySv6rhfBt1yByk6vejIBBPFloxIVYq2zN3qQBZaJKdPyWMda1UUSuUjmu9GojBSjhupBgXP7mw0/gbW9Vjtebc90SeqZy7PaqQMxZT5R8F0u8r+A9hjPHZb+YJ5fyeU+p4xL4DLyK34oaztFe0spIOMMxbb6pXsBNTnthZxMNzOZxky/oQ2pY5RlCKh6wwVUYQzGek53DB3eoZ9E/zeQBkEOQdVjX2OfO1EB/rz2OOmxGYgHws/F55QhDFzGNtBTwW8AyDRnx0VV5igtoqD39T66NizCt61tzcc+IqNI8Gq/Eu3kFftzZkhD7Y9A5aZKWD09qjxU3hkgTdr4vDKTVGoFDZKR9qgzS26FOjgdUXpZMHAKV++SjhjSASbRrQ=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY1PR04MB9561.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(376014)(7416014)(23010399003)(1800799024)(10070799003)(366016)(3023799007)(38070700021)(6133799003)(10067099003)(4143699003)(11063799006)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aXVPdjE2cGZNcGpBSitWdS96bDNRVjE4bmMzb3JtRWRHZXVhVTNOUUlXU2hJ?=
 =?utf-8?B?cmo2ODgrbGlRdFdZanhjSFA5d3FCMXhNbHRMbERkU1lpaDh4R1hPK28vb1dV?=
 =?utf-8?B?cHhWTCtpZjFKeXpLakp3clRwMmpiZ3J3VWo2YVdXTDREMW1DczdzSGc0SER6?=
 =?utf-8?B?UzQxdmJsUm83Tmc5NlNiZVpKN0g0RDdzdDY3cGd6clh3M1pndnRlR2F4Ymg4?=
 =?utf-8?B?UytIWnhTQVZDUDhjOXIwSFFEWVFCbTY2YjYwOXdsSjNTOEJRaVY2UUFqcmZH?=
 =?utf-8?B?Qm1NelliUkI0TXpuVmF5WlkrdUpiODhBd1F6ZmpNbXRKZ1FhcU51bFk4WFFL?=
 =?utf-8?B?MURmNVZRa2dTam9qUGdnRmtnLzVUMWFIRy9PMHVSSGlGWEVlVWNpYy9aTk1Z?=
 =?utf-8?B?MVBXT2pYM3kvRno0aFhvdnlzWW5lZjJ6SDR2ZWhTWlpJbkFRS1lJR1dmU1pD?=
 =?utf-8?B?dVUvcTduWmE4aEUvcTRHM29KdGRqK2RjMkxyeEg4dHZMamQyOWNQVUVNZ2JQ?=
 =?utf-8?B?bXpmS21ERWxIZ0NaQ2lpcHBxby9ycUZPTkphNDJwbWNFUHNTZWorb1dtMndM?=
 =?utf-8?B?ZFF3dm5nODcwbzV1ZG9KV29QaHo3MUUrcHFneXhBSVNCRytvS3RuL3krT09X?=
 =?utf-8?B?QkU4R0F3VGkrWVhMdmxZRDZ0dUM0Zit6RWVTVGFPUGVoenRCK1NGQzFNZUxi?=
 =?utf-8?B?QmsxUytNeVBTNExUTWlGS0QydkluUEgvNzFIdWttYUI3ZitLeUtlYnBOa1lP?=
 =?utf-8?B?Tzh0dDBzWXBhMXhTd3VYYUloaTBERHpLclp6OS96RG9IVGhtcGZHUStncXlB?=
 =?utf-8?B?WlpRdkFVMW5VbmRTVHVGVTNjMktneU1pNzBnSmcwRXhHMmhXQmM3bGo1OWI0?=
 =?utf-8?B?Z3dNSm9laWNFUFNaVlRvaHpSK3FLK3lib1o5NWQ2NlF2MHNybmpnTWZpN2ht?=
 =?utf-8?B?NndBK090Uy9yNVh0QVFPMzJyUGJuZlJoZ01zajNMU1ZhRlRueTgwT0szZkx4?=
 =?utf-8?B?RFhVd2E1ejZLU25JTXI3ejRTUDFtZk8xQnM3Wm51R01mMStPRGRMY2twUFV3?=
 =?utf-8?B?SFlIYnBWWG5EdGl1STFMME12eWc2ZUlKU3JJaWFiSnVqNmtqY0lGbmQ4WTBN?=
 =?utf-8?B?aEJGZy9reUxqM1ZWS3ZoMDRyZUZXbHZZWi80bzBtSjZCM3k1V2p5K3NUK0Y2?=
 =?utf-8?B?Q1dEdzA3aS9kSjQwTjFaZ3M0cUk2d2xJb3huR01BL09XeE9FM3Vqb1NRWmhC?=
 =?utf-8?B?SXRhT3NFc0dJa2J1UVdDbjE4NkFjTWN3V2hZaXJHUnNNL1FXQnFWcUx4WEV5?=
 =?utf-8?B?ak1iUnRCY0ZuRGt1YytMazFaMS9HM3VHaXZzMXdBejZMRTN5WHRRdmJiQkJH?=
 =?utf-8?B?QW5mZ1JuSnd5YlBiRnF2UklFQlEyOXpjdjdFUUl2cU5WL3ZrVlRSLzFGdjFh?=
 =?utf-8?B?MUk1c2hpYThjNEJkWVVyQXpEcHFaL204MTNsRXB5Sk5jQzJyNHYreDM4MEpy?=
 =?utf-8?B?VGJiYmQ2Y3RJbkhMT1lxYzdpNU4zMTh3NGZkZ3hSMG9uM0Z6cGdqTlczTW9F?=
 =?utf-8?B?MXdaZHJSak1XM1dWSGQzQlcrZnFFYnFxUWhJWU83OVpBWnozdjBKMEJZWlR4?=
 =?utf-8?B?SkdHT0ptQUZ6SnZEQlcxbS9MV2lqWk9mT0FsNmxxWU1qRDI4Mk9JZ1BjQWRs?=
 =?utf-8?B?a01nZC9FWHFETVJJSDFSc2JHU0M4cEZxb1RTM2dMTzhJa2xmazlaQnRCTVdX?=
 =?utf-8?B?aWFTQlh3SElFREkzcFpmQm56UXZLYWtUSXd2TStBNW5IYVlkOEJ0UHRmb1RI?=
 =?utf-8?B?M1N3SVhhMkJaRmZERWh0QmZ5RURMR0N5TlJOVTlnVnBHM3MzS1lyZ3plQ2R4?=
 =?utf-8?B?bjdXSUFlSEk3NDRqU3Qrb3JDYXdMQW94VHA1Mm1raHN0QWhKV3dsNkdrTC9U?=
 =?utf-8?B?eFg3TUIyRTYxNHZVc05CbDlvLzE1UU52Y2M5T1EzYUp2NkxrTUxDb1BXZEVI?=
 =?utf-8?B?SnNhb3pWUjhCdzJHNGZwTTh0TzlBb25nbStEazM4bjZmSVZBMWs1RWQzZVg0?=
 =?utf-8?B?VlN0THhoMC9BZ3pEMExYSVlzY2x5Z3N0ZDJaeXZNenJWUDlTYTZWMGVBTmlu?=
 =?utf-8?B?UnZjclpCWldtMDQxdVBZRHg2dzRoWUZjeGM2czhKVE4xaGlVSURBMWJqSlZl?=
 =?utf-8?B?aG5LZmtuaVlKeS9sRXJnSFk1VEQ0T3B5bWRKZXZiRThpemVRWk9Fa0pDNlU3?=
 =?utf-8?B?OUVuSDVtcCsrNFZiSWRIREgzZUJYQ1lObDg1bWR2T29LOW9BK1BBRXVuYmpr?=
 =?utf-8?B?bkJsRkw0UFM3cmxETGMxL01DT09qRThWV0pKWEpna285SFY2QWZFcTh3bUJm?=
 =?utf-8?Q?JdHW0a3nf3nltma2dh5rJfFRiMuZuE5YoiT192ca2VCUp?=
x-ms-exchange-antispam-messagedata-1: ybF4b8JUcMzAh78GtmdJgK8qLyE1Zez23fM=
Content-Type: text/plain; charset="utf-8"
Content-ID: <26D4A27C24DFBD4BB27A20469D91ED1D@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: oboZLCTzNhqTLlbyyXOlkEAw1A90cSmdj0YluCAsg+WlhsTtmxnyxF+frV0f5fu6Y5FjxIkzsvhlxrxOyJtUWg28P7eaP5UZLicjCpiENT1KffxkeDkQP3YP/4WQ+fpvdNUu8WU0MoXp1m0nS9EK+0020vgNhO7xEXXUT9moGqOF+f0hwPrg1wnYKe5+p+aMZ02hSGXPXvF/kMNVRcPeXQ2WNXCWO+I9pVvAW6A8GnN8G0a1h0GRqE91b+9sCjtSuxFiPYCgxyutqUEO7mzKrlS59tirE0lMa2DTfgj4hs9SULNPnB+6fSmGSS5w5ZqJgxXda2EgAOksku6BfmA5gw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: E9M9Tk5qh95QdG7S9VNG32GYlk+tICKYuSZ/tvpzPMU5WxG2EBl0eIjeT6agXibuiodTh0w8jO0CoaTknZ30mOrlSlvsVJMDYPW2uukRFiRR9tV5+LWaOdgxohPQhakOAgHwJU6dQfKFeB7IrqSKrTfbhQR3mSwx3HYkgJTo8rXiPTf/9TYAeOGSQRw4LVL7OQTs3dO9gkk8XnoGBC3AxrPcmJ/pk5A7J6dTjHX71O4vOR0ebiR8YY6xBKwvlzazz/BPicZJMlkQyY4t9GQDxe1N8aimO4NXNiSZ2y/hJPECBqtHUEOFhXeYGOs10pjaM/ZLSYBU5brItVAFV4Ev6RH7OKY9g0uGZLJStgQx/m0x7gG77lm/S28f1fk4y5tICwMD8JibSNFiq9w6AmkrMfS9Mx2ley4eu+eeUcuocyZ1CPGMtoQQJDTrh+vXHTyIhneYYSBd11I8YKfWrZOxm8ASCgxO6LY3TTrG13TmhYSFtP0MB3q/5Hw0tgkppx5eSE46WDO0GgCoGtK740r6kjqahHZIvSstdzEpS6Gze2eaa5+od3PkZh/afVeMSfFO23dhTF017xckz1VZVlIBP5qNErc3APdjbCOhjiZGnMAeo1GYnvE4HGRHhRbDJoec
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY1PR04MB9561.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e169a3a-986e-4b8b-bfab-08df06fe0719
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Aug 2026 01:20:22.0054 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 48P2cl2qG7mYxFsL/nE9A45I61ivmR+8h9AcCFkVvFpTq9jS8XTjGs+vw1qpoF3Ex9TsKeDeDOsz+CQ2Lri1rzebuj3CiROoRPoBDaSs1is=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR04MB9402
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
IEFkZCB0aGUgYm9vdCBjb2RlIGFuZCBzZW1paG9zdGluZyBoZWxwZXJzIG5lZWRlZCB0byBydW4g
dGhlIG11bHRpYXJjaA0KPiBzeXN0ZW0gdGVzdHMgb24gcmlzY3Y2NCwgYW5kIGFkZCByaXNjdjY0
IHRvDQo+IE1VTFRJQVJDSF9TT0ZUTU1VX1RBUkdFVFMuDQo+IFRoZSBhYXJjaDY0IG1ha2VmaWxl
IHdhcyB1c2VkIGFzIGEgZ3VpZGUgZm9yIHRoZSBtYWtlIHJ1bGVzLg0KPiANCj4gYm9vdC5TIGRv
ZXMgbm90IGNsZWFyIGJzcyBhcyB0aGUgbGlibWVtIHBsdWdpbiB0ZXN0IHdvdWxkIGNvdW50IHRo
ZQ0KPiBzdG9yZXMgYW5kIGZhaWwgd2l0aCBhIG1pc21hdGNoLiBJbnN0ZWFkIHRoZSBCU1MgaXMg
ZGVzY3JpYmVkIGFzDQo+IFBUX0xPQUQsIHNvIHRoZSBRRU1VIEVMRiBsb2FkZXIgZmlsbHMgdGhl
IHJlZ2lvbiB3aXRoIHplcm8sIHRoZSBzYW1lDQo+IGFzDQo+IGFhcmNoNjQgYW5kIGxvb25nYXJj
aDY0Lg0KPiANCj4gU2lnbmVkLW9mZi1ieTogSm9lbCBTdGFubGV5IDxqb2VsQGptcy5pZC5hdT4N
Cg0KUmV2aWV3ZWQtYnk6IEFsaXN0YWlyIEZyYW5jaXMgPGFsaXN0YWlyLmZyYW5jaXNAd2RjLmNv
bT4NCg0KQWxpc3RhaXINCg0KPiAtLS0NCj4gwqB0ZXN0cy90Y2cvcmlzY3Y2NC9zeXN0ZW0uY8Kg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8IDMwICsrKysrKysrKysrKysrKysrDQo+IMKg
dGVzdHMvdGNnL01ha2VmaWxlLnRhcmdldMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IHzCoCAyICstDQo+IMKgdGVzdHMvdGNnL3Jpc2N2NjQvTWFrZWZpbGUuc29mdG1tdS10YXJnZXQg
fCA0MCArKysrKysrKysrKystLS0tLS0tLS0NCj4gLS0NCj4gwqB0ZXN0cy90Y2cvcmlzY3Y2NC9i
b290LlPCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHwgMjMgKysrKysrKysrKysr
Kw0KPiDCoDQgZmlsZXMgY2hhbmdlZCwgNzUgaW5zZXJ0aW9ucygrKSwgMjAgZGVsZXRpb25zKC0p
DQo+IMKgY3JlYXRlIG1vZGUgMTAwNjQ0IHRlc3RzL3RjZy9yaXNjdjY0L3N5c3RlbS5jDQo+IMKg
Y3JlYXRlIG1vZGUgMTAwNjQ0IHRlc3RzL3RjZy9yaXNjdjY0L2Jvb3QuUw0KPiANCj4gZGlmZiAt
LWdpdCBhL3Rlc3RzL3RjZy9yaXNjdjY0L3N5c3RlbS5jIGIvdGVzdHMvdGNnL3Jpc2N2NjQvc3lz
dGVtLmMNCj4gbmV3IGZpbGUgbW9kZSAxMDA2NDQNCj4gaW5kZXggMDAwMDAwMDAwMDAwLi4wODE5
NmE1NDBmOTYNCj4gLS0tIC9kZXYvbnVsbA0KPiArKysgYi90ZXN0cy90Y2cvcmlzY3Y2NC9zeXN0
ZW0uYw0KPiBAQCAtMCwwICsxLDMwIEBADQo+ICsvKg0KPiArICogUklTQy1WIHNlbWlob3N0aW5n
IHN1cHBvcnQgZm9yIG11bHRpYXJjaCB0ZXN0IHN1aXRlDQo+ICsgKg0KPiArICogQ29weXJpZ2h0
IDIwMjYgVGVuc3RvcnJlbnQgVVNBIEluYw0KPiArICogU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6
IEdQTC0yLjAtb3ItbGF0ZXINCj4gKyAqLw0KPiArDQo+ICsjaW5jbHVkZSAic2VtaWNhbGwuaCIN
Cj4gKw0KPiArI2RlZmluZSBTWVNfV1JJVEVDwqDCoMKgwqDCoCAweDMNCj4gKyNkZWZpbmUgU1lT
X0VYSVTCoMKgwqDCoMKgwqDCoCAweDE4DQo+ICsNCj4gKyNkZWZpbmUgQURQX1N0b3BwZWRfQXBw
bGljYXRpb25FeGl0IDB4MjAwMjYNCj4gKw0KPiArdm9pZCBfX3N5c19vdXRjKGNoYXIgYykNCj4g
K3sNCj4gK8KgwqDCoCBfX3NlbWlfY2FsbChTWVNfV1JJVEVDLCAodWludHB0cl90KSZjKTsNCj4g
K30NCj4gKw0KPiArdm9pZCBfZXhpdChpbnQgY29kZSkNCj4gK3sNCj4gK8KgwqDCoCBjb25zdCB1
aW50cHRyX3QgYXJnc1syXSA9IHsgQURQX1N0b3BwZWRfQXBwbGljYXRpb25FeGl0LA0KPiAodWlu
dHB0cl90KWNvZGUgfTsNCj4gKw0KPiArwqDCoMKgIF9fc2VtaV9jYWxsKFNZU19FWElULCAodWlu
dHB0cl90KWFyZ3MpOw0KPiArDQo+ICvCoMKgwqAgLyogSGFuZyBpZiBRRU1VIGZhaWxzIHRvIGV4
aXQgKi8NCj4gK8KgwqDCoCB3aGlsZSAoMSkgew0KPiArwqDCoMKgwqDCoMKgwqAgYXNtIHZvbGF0
aWxlKCJ3ZmkiKTsNCj4gK8KgwqDCoCB9DQo+ICt9DQo+IGRpZmYgLS1naXQgYS90ZXN0cy90Y2cv
TWFrZWZpbGUudGFyZ2V0IGIvdGVzdHMvdGNnL01ha2VmaWxlLnRhcmdldA0KPiBpbmRleCAxYjgz
ODI0ZmY0ZTcuLmQ0ZGQwZmVjNjUwZCAxMDA2NDQNCj4gLS0tIGEvdGVzdHMvdGNnL01ha2VmaWxl
LnRhcmdldA0KPiArKysgYi90ZXN0cy90Y2cvTWFrZWZpbGUudGFyZ2V0DQo+IEBAIC0xMjksNyAr
MTI5LDcgQEAgZWxzZQ0KPiDCoEVYVFJBX0NGTEFHUyArPSAtZmZyZWVzdGFuZGluZyAtZm5vLXN0
YWNrLXByb3RlY3Rvcg0KPiDCoA0KPiDCoCMgV2Ugc2tpcCB0aGUgbXVsdGlhcmNoIHRlc3RzIGlm
IHRoZSB0YXJnZXQgaGFzbid0IHByb3ZpZGVkIGEgYm9vdC5TDQo+IC1NVUxUSUFSQ0hfU09GVE1N
VV9UQVJHRVRTID0gaTM4NiBhbHBoYSBhYXJjaDY0IGFybSBsb29uZ2FyY2g2NCBzMzkweA0KPiB4
ODZfNjQNCj4gK01VTFRJQVJDSF9TT0ZUTU1VX1RBUkdFVFMgPSBpMzg2IGFscGhhIGFhcmNoNjQg
YXJtIGxvb25nYXJjaDY0IHMzOTB4DQo+IHg4Nl82NCByaXNjdjY0DQo+IMKgDQo+IMKgaWZuZXEg
KCQoZmlsdGVyICQoVEFSR0VUX05BTUUpLCQoTVVMVElBUkNIX1NPRlRNTVVfVEFSR0VUUykpLCkN
Cj4gwqAtaW5jbHVkZSAkKFNSQ19QQVRIKS90ZXN0cy90Y2cvbWluaWxpYi9NYWtlZmlsZS50YXJn
ZXQNCj4gZGlmZiAtLWdpdCBhL3Rlc3RzL3RjZy9yaXNjdjY0L01ha2VmaWxlLnNvZnRtbXUtdGFy
Z2V0DQo+IGIvdGVzdHMvdGNnL3Jpc2N2NjQvTWFrZWZpbGUuc29mdG1tdS10YXJnZXQNCj4gaW5k
ZXggZjI4NTBhMTk0MDg0Li44MmU4ZmUyNjY0YjAgMTAwNjQ0DQo+IC0tLSBhL3Rlc3RzL3RjZy9y
aXNjdjY0L01ha2VmaWxlLnNvZnRtbXUtdGFyZ2V0DQo+ICsrKyBiL3Rlc3RzL3RjZy9yaXNjdjY0
L01ha2VmaWxlLnNvZnRtbXUtdGFyZ2V0DQo+IEBAIC01LDkgKzUsMTEgQEANCj4gwqBURVNUX1NS
QyA9ICQoU1JDX1BBVEgpL3Rlc3RzL3RjZy9yaXNjdjY0DQo+IMKgVlBBVEggKz0gJChURVNUX1NS
QykNCj4gwqANCj4gK0NSVF9PQkpTID0gYm9vdC5vIHN5c3RlbS5vDQo+ICsNCj4gwqBMSU5LX1ND
UklQVCA9ICQoVEVTVF9TUkMpL3NlbWlob3N0LmxkDQo+IC1MREZMQUdTID0gLVQgJChMSU5LX1ND
UklQVCkNCj4gLUNGTEFHUyArPSAtZyAtT2cNCj4gK0xERkxBR1MgPSAtV2wsLVQkKExJTktfU0NS
SVBUKSAtc3RhdGljIC1ub3N0ZGxpYiAkKE1JTklMSUJfT0JKUykgLQ0KPiBsZ2NjDQo+ICtDRkxB
R1MgKz0gLWcgLU9nICQoTUlOSUxJQl9JTkMpDQo+IMKgDQo+IMKgIyBVc2VkIGJ5IHJpc2N2NjQg
dGNnIHRlc3RzIGFuZCBzaGFyZWQgJ211bHRpYXJjaCcgdGVzdHMNCj4gwqBRRU1VX0NQVSA9IHJ2
NjQNCj4gQEAgLTUzLDIzICs1NSwyMyBAQCB0ZXN0LXppY2Nsc20tb2ZmLm86IHRlc3QtemljY2xz
bS5TDQo+IMKgCSQoY2FsbCBxdWlldC1jb21tYW5kLCBcDQo+IMKgCcKgICQoQ0MpICQoQ0ZMQUdT
KSAkPCAtV2EkKENPTU1BKS0tbm9leGVjc3RhY2sgLWMgLW8gJEAsIENDLA0KPiAkQCkNCj4gwqAN
Cj4gLUVYVFJBX1JVTlMgKz0gcnVuLXBsdWdpbi1kb3VibGV0cmFwDQo+IC1ydW4tcGx1Z2luLWRv
dWJsZXRyYXA6IGRvdWJsZXRyYXANCj4gLQkkKGNhbGwgcnVuLXRlc3QsICQ8LCBcDQo+IC0JwqAg
JChRRU1VKSAtbW9uaXRvciBub25lIC1kaXNwbGF5IG5vbmUgXA0KPiAtCQnCoCAtY2hhcmRldiBm
aWxlJChDT01NQSlwYXRoPSQ8Lm91dCQoQ09NTUEpaWQ9b3V0cHV0DQo+IFwNCj4gLQkJwqAgLXBs
dWdpbiAuLi9wbHVnaW5zL2xpYmRpc2NvbnMuc28gLWQgcGx1Z2luIC1EDQo+ICQ8LnBvdXQgXA0K
PiAtCQnCoCAkKFFFTVVfT1BUUykgJDwpDQo+IC0NCj4gLUVYVFJBX1JVTlMgKz0gcnVuLXBsdWdp
bi1pbnRlcnJ1cHRlZG1lbW9yeQ0KPiAtcnVuLXBsdWdpbi1pbnRlcnJ1cHRlZG1lbW9yeTogaW50
ZXJydXB0ZWRtZW1vcnkNCj4gLQkkKGNhbGwgcnVuLXRlc3QsICQ8LCBcDQo+IC0JwqAgJChRRU1V
KSAtbW9uaXRvciBub25lIC1kaXNwbGF5IG5vbmUgXA0KPiAtCQnCoCAtY2hhcmRldiBmaWxlJChD
T01NQSlwYXRoPSQ8Lm91dCQoQ09NTUEpaWQ9b3V0cHV0DQo+IFwNCj4gLQkJwqAgLXBsdWdpbiAu
Li9wbHVnaW5zL2xpYmRpc2NvbnMuc28gLWQgcGx1Z2luIC1EDQo+ICQ8LnBvdXQgXA0KPiAtCQnC
oCAkKFFFTVVfT1BUUykgJDwpDQo+ICtpZmVxICgkKENPTkZJR19QTFVHSU4pLHkpDQo+ICtFWFRS
QV9SVU5TX1dJVEhfUExVR0lOICs9IHJ1bi1wbHVnaW4tZG91YmxldHJhcC13aXRoLWxpYmRpc2Nv
bnMuc28gXA0KPiArCXJ1bi1wbHVnaW4taW50ZXJydXB0ZWRtZW1vcnktd2l0aC1saWJkaXNjb25z
LnNvDQo+ICtlbmRpZg0KPiDCoA0KPiDCoENMRUFORklMRVMgKz0gaW50ZXJydXB0ZWRtZW1vcnkg
ZG91YmxldHJhcA0KPiDCoA0KPiAtIyBXZSBkb24ndCBjdXJyZW50bHkgc3VwcG9ydCB0aGUgbXVs
dGlhcmNoIHN5c3RlbSB0ZXN0cw0KPiAtdW5kZWZpbmUgTVVMVElBUkNIX1RFU1RTDQo+ICsjIE11
bHRpYXJjaCB0ZXN0cw0KPiArVEVTVFMgKz0gJChNVUxUSUFSQ0hfVEVTVFMpDQo+ICtFWFRSQV9S
VU5TICs9ICQoTVVMVElBUkNIX1JVTlMpDQo+ICsNCj4gKy5QUkVDSU9VUzogJChDUlRfT0JKUykN
Cj4gKw0KPiArIyBCdWlsZCBhbmQgbGluayB0aGUgbXVsdGlhcmNoIHRlc3RzDQo+ICslOiAlLmMg
JChMSU5LX1NDUklQVCkgJChDUlRfT0JKUykgJChNSU5JTElCX09CSlMpDQo+ICsJJChjYWxsIHF1
aWV0LWNvbW1hbmQsIFwNCj4gKwkgJChDQykgJChDRkxBR1MpICQoRVhUUkFfQ0ZMQUdTKSAkPCAt
byAkQCAkKExERkxBR1MpDQo+ICQoQ1JUX09CSlMpLCBDQywgJEApDQo+ICsNCj4gKyMgRGVmYXVs
dCBpcyB6aWNjbHNtPXRydWUsIHNvIG1pc2FsaWduZWQgYWNjZXNzZXMgbXVzdCB3b3JrDQo+ICtt
ZW1vcnk6IHByaXZhdGUgQ0ZMQUdTICs9IC1EQ0hFQ0tfVU5BTElHTkVEPTENCj4gZGlmZiAtLWdp
dCBhL3Rlc3RzL3RjZy9yaXNjdjY0L2Jvb3QuUyBiL3Rlc3RzL3RjZy9yaXNjdjY0L2Jvb3QuUw0K
PiBuZXcgZmlsZSBtb2RlIDEwMDY0NA0KPiBpbmRleCAwMDAwMDAwMDAwMDAuLmI0MDM1NDkzNDVh
MQ0KPiAtLS0gL2Rldi9udWxsDQo+ICsrKyBiL3Rlc3RzL3RjZy9yaXNjdjY0L2Jvb3QuUw0KPiBA
QCAtMCwwICsxLDIzIEBADQo+ICsvKg0KPiArICogUklTQy1WIGJvb3QgY29kZSBmb3IgbXVsdGlh
cmNoIHRlc3Qgc3VpdGUNCj4gKyAqDQo+ICsgKiBDb3B5cmlnaHQgMjAyNiBUZW5zdG9ycmVudCBV
U0EgSW5jDQo+ICsgKiBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMC1vci1sYXRlcg0K
PiArICovDQo+ICsNCj4gKyNkZWZpbmUgTVNUQVRVU19WU8KgwqDCoMKgwqDCoMKgwqDCoCAweDAw
MDAwNjAwDQo+ICsjZGVmaW5lIE1TVEFUVVNfRlPCoMKgwqDCoMKgwqDCoMKgwqAgMHgwMDAwNjAw
MA0KPiArDQo+ICsuc2VjdGlvbiAudGV4dC5fc3RhcnQNCj4gK8KgwqDCoMKgwqDCoMKgIC5nbG9i
YWwgX3N0YXJ0DQo+ICvCoMKgwqDCoMKgwqDCoCAudHlwZSBfc3RhcnQsIEBmdW5jdGlvbg0KPiAr
X3N0YXJ0Og0KPiArwqDCoMKgwqDCoMKgwqAgLyogRW5hYmxlIEZQVSBhbmQgdmVjdG9yIHVuaXQg
Ki8NCj4gK8KgwqDCoMKgwqDCoMKgIGxpwqDCoMKgwqDCoCB0MCwgKE1TVEFUVVNfRlMgfCBNU1RB
VFVTX1ZTKQ0KPiArwqDCoMKgwqDCoMKgwqAgY3Nyc8KgwqDCoCBtc3RhdHVzLCB0MA0KPiArwqDC
oMKgwqDCoMKgwqAgbGHCoMKgwqDCoMKgIHNwLCBfX3N0YWNrX3RvcA0KPiArwqDCoMKgwqDCoMKg
wqAgY2FsbMKgwqDCoCBtYWluDQo+ICsNCj4gK2V4aXQ6DQo+ICvCoMKgwqDCoMKgwqDCoCAvKiBl
eGl0IHdpdGggbWFpbigpJ3MgcmV0dXJuIGNvZGUgKi8NCj4gK8KgwqDCoMKgwqDCoMKgIGNhbGzC
oMKgwqAgX2V4aXQNCg==

