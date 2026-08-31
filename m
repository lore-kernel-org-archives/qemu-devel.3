Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BD80C61DE2
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2026 01:17:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x0qe5-0000Ms-OJ; Sun, 30 Aug 2026 21:17:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=696fae14a=Alistair.Francis@wdc.com>)
 id 1x0qe3-0000MJ-JF; Sun, 30 Aug 2026 21:17:07 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=696fae14a=Alistair.Francis@wdc.com>)
 id 1x0qe1-0008Gs-Eb; Sun, 30 Aug 2026 21:17:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1788139029; x=1819675029;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=ILFoMEstayLjHytTUen++ebbAw8gIf8LKK1wn3P+vBU=;
 b=UYAU7RK5/G9fneg8tKlwyHfY/26MxUEBqDsG6ajxDm1l/R9gCaazTjsg
 dJ03xKmmjCF/HBj98G9N+AhnIjlT3/GkjJSM0nnn394BVJ7v+iucHvD20
 XsAbMdSKJ8UZjBwXR2HRqXo0pr6VBgqpvFTC6MhU4TX8yHAFIPe4hTdbh
 A9KviHPvsJ5QzEjPCkFrJzQZbq+OHNfAw8Izbx4I+c7ky1xmqxzqCFCt3
 pDDcWPe/M57CgdRqczYPooZnK/Qa13fEFRQGIAZl8WKZypFdzMBs4CGYt
 jRifXvgSeKPmyUKrbFkELgwNNtXA+hwfOPsYd4fZDsPYRQW4CQLNrrLgO w==;
X-CSE-ConnectionGUID: dULGOfw4RtCPrsP/DkS1Zg==
X-CSE-MsgGUID: NF99TV88TTKEO46itACVRA==
X-IronPort-AV: E=Sophos;i="6.25,252,1779120000"; d="scan'208";a="154586501"
Received: from mail-centralusazon11010067.outbound.protection.outlook.com
 (HELO DM1PR04CU001.outbound.protection.outlook.com) ([52.101.61.67])
 by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 31 Aug 2026 09:17:06 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Nyfr/1PZC2efgEI+Pa3ivXPXprifEojxIrwTtLauy4MAF88anretn4xPS5HDtf8BjCsEz27dyoJzcJb6WP3RPk6rQyb59E5thU/Pyy6MVi8GcLXrBGWzknvPYAg42gsRwdO2x45XxqMn0Mlm0W8+94YOou+pE6o18G8/ZSjYkW+egqI1EII8gnLHzzeO/ziJ4ZbRnZ2eeU/ltr+sZFzhWYf+ux2kg7LCtQ2M+2Kgjb390533Wa1oW0QdbWFk1xzme3Aaomi2ERZkd9BcFAx7vYWcaWTsrwEWx1XntHJDLj8czyewV2SoarC+5MrS9JFFwH4azYZY3fC1bxvxZn0Cmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ILFoMEstayLjHytTUen++ebbAw8gIf8LKK1wn3P+vBU=;
 b=rXgOD2tEK9vmPsdPRIRODovjMdlQ4wFkpPhhv+VimpewFWcXpA4tIja+MEWr7QYtTjrPY8olgXIdzL4vEPa5jPO3b8EYNQu/vbuZb0t4OCw75xOUAFf6ncrR+/boSEBP7s6APoqXJc5D27voHlPRggD8sExQgb9CfO4t3XX7DJfgyhkvDUdjIv1fHrRiAkhnqlz3HUbG1bpyQ1wVis/YyOej7DbHlIja5byRzfHCgvsQnnYffMJzefqK/lt7cNP1wwj4dKR5vxUabhLmEFx/WxdtshhxAbh7y8gSu2xNsM+fMJwVegK5YN8J1t/EhAc/ZmVgcjw8ZwqBrVy8VeDL1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ILFoMEstayLjHytTUen++ebbAw8gIf8LKK1wn3P+vBU=;
 b=ueYV/b5aM18mHE/lsa8Mauq4yxgX7xGqRfxIWWceBElDp1N9SnkL1P2mpv9N9zMUi8JfH/8xlXn+vdp1+ae38GWdVSRreIlxZZyVaWNrI+CO4aKCODNUg9aU1jFd+Dax2YBDQRlsJY2TU+YT9SrkV0dIOTqv7oH0uWPHE45Mu/A=
Received: from BY1PR04MB9561.namprd04.prod.outlook.com (2603:10b6:a03:5b6::11)
 by LV2PR04MB993975.namprd04.prod.outlook.com (2603:10b6:408:36c::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 01:17:00 +0000
Received: from BY1PR04MB9561.namprd04.prod.outlook.com
 ([fe80::3869:e494:2fa8:9888]) by BY1PR04MB9561.namprd04.prod.outlook.com
 ([fe80::3869:e494:2fa8:9888%5]) with mapi id 15.21.0360.008; Mon, 31 Aug 2026
 01:17:00 +0000
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
Subject: Re: [PATCH 05/12] tests/tcg/riscv64: Rework rules for semihost tests
Thread-Topic: [PATCH 05/12] tests/tcg/riscv64: Rework rules for semihost tests
Thread-Index: AQHdNeJt4ibCxJivK0mkGTenCd1KXba3YQ4A
Date: Mon, 31 Aug 2026 01:17:00 +0000
Message-ID: <e9d86198cabff72dfc521e3b8cfd322f5a263221.camel@wdc.com>
References: <20260827050953.67184-1-joel@jms.id.au>
 <20260827050953.67184-6-joel@jms.id.au>
In-Reply-To: <20260827050953.67184-6-joel@jms.id.au>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.60.2 (by Flathub.org) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY1PR04MB9561:EE_|LV2PR04MB993975:EE_
x-ms-office365-filtering-correlation-id: 84dc1d81-4d5e-4517-5cab-08df06fd8efc
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|10070799003|7416014|376014|23010399003|19092799006|366016|38070700021|6133799003|3023799007|10067099003|56012099006|4143699003|11063799006|18002099003|22082099003;
x-microsoft-antispam-message-info: ORN7q07PbABZbbNqigH46nz4i8D5QDvRBaVHYu292VJrsY+67/ryS85A7eieQl3SacG78HmqA7PhP3+ljR5dzFi2qL4wYmxXU46W1O85vRVU3U6ZRxLuGvhorbkptHFR4VjYhiiv0Vz3MWwTwUbKZ4D4mQR4gmQ2XL0KcISH1zhUzqFAHQCFfmb2z8I049zeQ7yc5aoDLuw7HF7IOfQgDrRQz35WkLcF61HViLlKgaJmXC/CMGNNmN1+CsE6/csoE12KanM82o6IJd9w1aRSX1za4+bobhs3GS557Wnn4/w/OsJKFUuyjAWYq7igEXJ/zSlimAClKphNhiEBcaLywLdREXQ6cQYSQIObisty2JejwpOu5Qx+cijKcYvlV1qLF0oahMnxKvQLLm85aCOULAAZP5kAaHSl3EZ8fNXJrFUrwvlL9w3Hcin9EZ9a9KyCY40hO9SVPfS0rhukeHxY45srWp5jrAbShTgyfDQf1n5bBVPq5b+/d1xKYTBhshAksD+wXbZF5eiqXcIUC9UZDG5vbZFUPdR1Um4yDyF8tIMa5PyYlKBS8IEqoZA36Mc9aHFX0QxhOkYUnxP+bynLEZSRYhyu4+7JIwpbYnq0KNfHYfcjp87S0rXPdxZrSeLQADN7bdhfDGxS6Q7We5Nj3aahdypCf+7QawB3mc7FDCG0nCCW1HhGff7DuYgUOTL4aEe0NxeswcK67x2zBNwHhw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY1PR04MB9561.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(10070799003)(7416014)(376014)(23010399003)(19092799006)(366016)(38070700021)(6133799003)(3023799007)(10067099003)(56012099006)(4143699003)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?N1BYV0paSjNIRktMYzQ5TW85Q3NSWEZrbm5VZEhkVTAyNHhvYk9DbWlJRmxT?=
 =?utf-8?B?OWttSlpmR2RqU3NQMVc1WkM2QkEvSEQzWE1WMHM3TE9VT0k3NktEODB2VElv?=
 =?utf-8?B?ejk3UGZqTTZLWHpUQnFPeDVJNUJ4RExtY3NPdUYxUU1aa1RPSUh6TnNJRk5H?=
 =?utf-8?B?U1lKVGIwNmd4TFFQcStvNVg5T2U5SFdZQ1ZacEp1SitHR1lTNDB3Zmx1N0FF?=
 =?utf-8?B?YTBkZmtVSHN6NXl1NEYvSlp6NW1XMU41dUtjOERSeWxWdGlrNUVvRkhHRnQx?=
 =?utf-8?B?dUM2cXpVc0FXTTNPemxEeEd2QWYvQXNKUXgvQUdOTEV3OXVFcVR2VUt6ekxY?=
 =?utf-8?B?RkUvZmdkYWxSSzZPREpIVVJob29sZGI3OHJmV1hwQ0Z1VzUyQ2xwUU1EUy9r?=
 =?utf-8?B?ZTVHT2hRc1U3WGpVd1FaL1JGd0FqT0ZRdVhzSnd6TGhFMCtDc3hMMDVWbWxT?=
 =?utf-8?B?aXBUYkVKUXFvODZTb1Uxd280dStPSUI2a2hreWZiejJFOHBZdmZ3eElyQllX?=
 =?utf-8?B?ZDMrZmI3U1hpdE9NSG90MEFmeXQrZTdkUFVHeGozK2JVcWwzeFA2MW1XcWVv?=
 =?utf-8?B?OWJXZm1vVFVJdEdWNWdJRGpYVWVVRlFNdmNQdHZ3a1JOajBHRmF5aHFnWW9t?=
 =?utf-8?B?T0hRbk9lQUtGYjRVdDRETUdpdkhJOFRMTHFEV3FncHpsZ3lMZTd6aXlJZ2R4?=
 =?utf-8?B?NzZ3Zm10djg4b282MWpnVkwwcDZEd2FNMlhxeTRrdXpaVVVBRFlaWXZIY2Yx?=
 =?utf-8?B?MTFtSUFzenIvUXRBOEtVWW1MbjFrdERGRmhyeGQ2eUExZnY1bysxemxkTWlt?=
 =?utf-8?B?NFQ5THA4bW9qbVBQYjB1Z1FLbjJTbTlpMWFIWFpRVXpNbjFYRmtuMEJKRndi?=
 =?utf-8?B?WGlPZ0dTSFo5QWJ1cFA5TmhCbkpmanRxYzFVUmJJSkNhVGg0MEg4V3JHOGNK?=
 =?utf-8?B?bUZXUnR2NWY2S28xdVNoZDVLOW92a1hEOFV0S0M4NU1RVUZlY0c1RHZkaTFD?=
 =?utf-8?B?b2FkKzY5d29tUzBzZVI2OGNTNkxRNjlHMHN3ampLMm12UWlKczA5UlNKTjlO?=
 =?utf-8?B?MHJ6b2ZabVc4cENiRlY5eEE0a09Ja2JsaG5JQ2dGVDBUcWtwazlCMVhPRGw1?=
 =?utf-8?B?ZHNRU011eElJWURLNHVUY0w0dFFTK1VhWE4wb0NXTnR4cUxQODRxeHlCL0tm?=
 =?utf-8?B?YTlaUE4vZC90RjhUekltS1ZMUkRqdnNqNWdsd2drYVpGMkR3SklrdGhZSC80?=
 =?utf-8?B?WnpmanhZQldtSXU0dDhnQng3UEVnMm43NEJQN2l1c2tnK1RVRmhpTmlIbWFF?=
 =?utf-8?B?ZGdwNC9vbDJsc2FPZklxVFNrd2d1REY5dWxSeE9MWWtqTlNUaHdkYkFEMXhj?=
 =?utf-8?B?U0lURXFEU01xYnBOWUNsekY1UC91Z01EVnRLcUlHd2h0cFVaSVB2eU1qUWxQ?=
 =?utf-8?B?S3FvTit3Sjc5SmZtSFhqOWw3d2FQU0hRcFpsUVNJU0dlOUE4a3EyM1RobEd2?=
 =?utf-8?B?MVhaYTV4UGhXUlVaUjMrSWU0V01oTnBzNWE2N1RHNU51cUp5TlBROFRFdjgx?=
 =?utf-8?B?L1B3Q3lucDNROTVQb2ZqS2liTW5qUHNNbjJwYVhIV2FVSGMrbDk5bFd4NTFR?=
 =?utf-8?B?RzdJY1VZRWJnbStCSSt5MTZzdTJoV2t5VlhiVVRXY1dNZnErTFdwZmo0Zmxm?=
 =?utf-8?B?Qkt4ZlJFY1BhT1FOOVExVWNwSWpiWk41bnVQNnhJSytXM20vbW4rTU1kWk82?=
 =?utf-8?B?ZTJoQkhCdVBpVnNYOFp3dDBkOUJVempLMktUcE1wL3pZVERZalVyKy9kamZG?=
 =?utf-8?B?Vi80SzZHZkVLNCtQRTdwbnN6VEZST0YxLzJUUk9WVXRXUnRIaFNVWUl4anJY?=
 =?utf-8?B?YXFab3B3aHZrV0N3bDNaRVhXNzE1OFNCSkRLWDVtYTJOZTN5S0ZmMmg3ODBU?=
 =?utf-8?B?TVVSbG1BY2RkMmZ1VEszZW5Xd000Y2RSbUhOWWxGSzVyWVJ5aU1abHBKYURm?=
 =?utf-8?B?TkF1aUFoWTJna2pJSmtDOHRpenAyZCtWZjJsbWpzSGJxc0FzRXF1OEFoL2Y5?=
 =?utf-8?B?SHpwekFIT3dDcGo1eEhXd1lJWUhQR3l5VnhCN2Nicit3MEllUVpibW1LbHQ0?=
 =?utf-8?B?WWxueHZPRjRSUkZaT2VzYWZKdmhiQ3E2VWFNemUzVEVBTURsMnRJRHA0TkNG?=
 =?utf-8?B?Mk9lSFJOQnNGQTlTdTlrd1YrK25aaGRaN3hDc0xjYVJJd0tZaUk2SU1CamZE?=
 =?utf-8?B?Y2tPVnh3TkJhQVpUaU5NMXZWSDB2SWpEcFcyeXVEYmY4SUt0R1pHYVk2UjYw?=
 =?utf-8?B?cFNvVXpFaXE3QTN6RG5SYTY2YzF5K25XY1V0SnlPMkd5ekY1RmEyTzBwbEhs?=
 =?utf-8?Q?r358YqSfs/Z7XXBd/0SPikB22CBKuTGsvjQHbZBtxfJMX?=
x-ms-exchange-antispam-messagedata-1: J4650ZgfPgJz51qpizTYOQtlMZidEziuXH8=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DF5F2121E6788243A7C9763361DD34E7@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: aXVDamG0p4sOQ/43YKaydkRsoMO1ZU7A5m/MUMAHZAQzRX1BvHZ95dzlMhdtf4FcxLWTOEn2k9g9lhEWBi2pGMZON/PximUCHx7xDB5MG/GCm7tKzPgqUIpI0d3YWU09oLuc+3BnUZBm/Edz+Y1uRPXU62TlEx9v8QlrFQEkmRbFwxUn8817otpmD8VnagWV91BdGxs+fe5iNrEW54k/zFNHGu3cRP8ARnhxkxEJqb6yx+Gv6HjrznFhSqQeSP55y3bxMAxzrk6B1kGW/ZyzIr4Ry80UtVWnEjA4G52zJNhEYP+xsu7jr7unGpPW/+vYLCIOSgnu2Wh/8uTroHEU4w==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: juErGq+nnk2829h86UOH9I5NJ3fqGqSpe7qysqA3+D58qIlE6t4D5KpW2P6xzvno4qvfJVdzsssFDAtQB1LW5Pq2AjXkkxZiT4Yyc5rjDmjHsiQ9fpn5EN5Pbpw70VgXLstoImTGr4L/Cf3YDhoerbtiuzv0KGvhijHdNOkECKqUuIlJZ0A484kAt9cP5ZcmrHVeJ4NZWxpjpeQfVZqAnOOcwUaA85HbbRoowx6nI5UJVwb8aYNIgwhG9FJcLdscUH3qVLrglM/F1/NS+17ROW7AI1tn593txGwaVkDDV7v3eQXX4mpWPVh2/XgZq2Y5YcpQHCJE/KDS4hVAcTyT3ke+i9AjQQ0v7NlZBpJhQ+vmkZ2w8CZqGgTr90R7CiwV6TknaVpUrWUXR1nwqjer8U37hHSr3lqHwoFgV0gtK3Qh+5SwixUCcExRDKYX/VAfCSJMaSe+nshb1aHHG5XCinenzAv2wR90gcfDhaHuNpICvFH3icIzaWCYvKO/40gHz+ooGW1LwdSAsyftT0d06K/Cmbvw91dUHU02U+BOrva2WQW4aloDFO2ScTOzZlbbXW9xfR8AwkzrRkm+ZewRdHYWe1Ry3diMByj/eGo7xE8RwJFc9pCRbihlGPzN/qne
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY1PR04MB9561.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84dc1d81-4d5e-4517-5cab-08df06fd8efc
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Aug 2026 01:17:00.5162 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YjSBGzlZbC74Cbi+fdGAskDBT0bkrATziib+D6m/HtTYGsVmdwAWp3hQZfnffeAq38T5pOD6CdLHNwDd1ipupXwGZxIwfgnWWeSwsMnZ3FM=
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
IFJld29yayB0aGUgbWFrZWZpbGUgc28gdGhlIHNlbWlob3N0IHRlc3RzIGNhbiBzaGFyZSBydW4g
cnVsZXMsIHdpdGgNCj4gaW5kaXZpZHVhbCB0ZXN0cyBvdmVyd3JpdGluZyBRRU1VX0NQVSBvciBw
cm92aWRpbmcgbW9yZSBvcHRpb25zIHZpYQ0KPiBRRU1VX0VYVFJBLg0KPiANCj4gVGhlIHByb2dy
YW0gb3V0cHV0IG5vdyBjb21lcyBmcm9tIHRoZSB0ZXN0IGZyYW1ld29yaydzIG91dHB1dCBjaGFy
ZGV2DQo+IGluc3RlYWQgb2Ygc3Rkb3V0LCBidXQgdGhlcmUgaXMgbm8gZnVuY3Rpb25hbCBjaGFu
Z2UgYXMgbm9uZSBvZiB0aGUNCj4gdGVzdHMgdXNlIHNlbWlob3N0aW5nIHB1dGMuDQo+IA0KPiBB
ZGQgcXVpZXQtY29tbWFuZCB0byB0aGUgY29tcGlsZSBhbmQgbGluayBydWxlcyBzbyBidWlsZHMg
cHJpbnQNCj4gQ0MvTEQgbGluZXMgbGlrZSB0aGUgcnVuIHJ1bGVzLg0KPiANCj4gU2lnbmVkLW9m
Zi1ieTogSm9lbCBTdGFubGV5IDxqb2VsQGptcy5pZC5hdT4NCg0KUmV2aWV3ZWQtYnk6IEFsaXN0
YWlyIEZyYW5jaXMgPGFsaXN0YWlyLmZyYW5jaXNAd2RjLmNvbT4NCg0KQWxpc3RhaXINCg0KPiAt
LS0NCj4gwqB0ZXN0cy90Y2cvcmlzY3Y2NC9NYWtlZmlsZS5zb2Z0bW11LXRhcmdldCB8IDk0ICsr
KysrKysrKysrLS0tLS0tLS0tLQ0KPiAtLQ0KPiDCoDEgZmlsZSBjaGFuZ2VkLCA0NyBpbnNlcnRp
b25zKCspLCA0NyBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS90ZXN0cy90Y2cvcmlz
Y3Y2NC9NYWtlZmlsZS5zb2Z0bW11LXRhcmdldA0KPiBiL3Rlc3RzL3RjZy9yaXNjdjY0L01ha2Vm
aWxlLnNvZnRtbXUtdGFyZ2V0DQo+IGluZGV4IDU2MmFjOWIwZTBmYi4uZjI4NTBhMTk0MDg0IDEw
MDY0NA0KPiAtLS0gYS90ZXN0cy90Y2cvcmlzY3Y2NC9NYWtlZmlsZS5zb2Z0bW11LXRhcmdldA0K
PiArKysgYi90ZXN0cy90Y2cvcmlzY3Y2NC9NYWtlZmlsZS5zb2Z0bW11LXRhcmdldA0KPiBAQCAt
OSw2NyArOSw2NyBAQCBMSU5LX1NDUklQVCA9ICQoVEVTVF9TUkMpL3NlbWlob3N0LmxkDQo+IMKg
TERGTEFHUyA9IC1UICQoTElOS19TQ1JJUFQpDQo+IMKgQ0ZMQUdTICs9IC1nIC1PZw0KPiDCoA0K
PiArIyBVc2VkIGJ5IHJpc2N2NjQgdGNnIHRlc3RzIGFuZCBzaGFyZWQgJ211bHRpYXJjaCcgdGVz
dHMNCj4gK1FFTVVfQ1BVID0gcnY2NA0KPiArUUVNVV9CQVNFX01BQ0hJTkUgPSAtTSB2aXJ0IC1j
cHUgJChRRU1VX0NQVSkgLWRpc3BsYXkgbm9uZSAtYmlvcw0KPiBub25lDQo+ICtRRU1VX0JBU0Vf
QVJHUyA9IC1zZW1paG9zdGluZy1jb25maWcgZW5hYmxlPW9uLGNoYXJkZXY9b3V0cHV0DQo+ICtR
RU1VX09QVFMgKz0gJChRRU1VX0JBU0VfTUFDSElORSkgJChRRU1VX0VYVFJBKSAkKFFFTVVfQkFT
RV9BUkdTKSAtDQo+IGtlcm5lbA0KPiArDQo+ICsjIFRoZXNlIHRlc3RzIHByb3ZpZGUgX3N0YXJ0
IGFuZCB1c2Ugc2VtaWhvc3RpbmcgZGlyZWN0bHkuDQo+ICsjIC1rZXJuZWwgZW50cnkgcG9pbnQg
aXMgdGhlIGxvd2VzdCBsb2FkZWQgYWRkcmVzcywgbm90IHRoZSBFTEYNCj4gZW50cnkNCj4gKyMg
cG9pbnQsIHNvIF9zdGFydCBtdXN0IHJlbWFpbiBmaXJzdCBpbiAudGV4dC4NCj4gK1JJU0NWNjRf
VEVTVFMgPSBpc3N1ZTEwNjAgdGVzdC1tZXBjLW1hc2tpbmcgdGVzdC1taW5zdHJldC1lY2FsbCBc
DQo+ICsJZG91YmxldHJhcCBpbnRlcnJ1cHRlZG1lbW9yeSB0ZXN0LWNyYzMyIFwNCj4gKwl0ZXN0
LXppY2Nsc20gdGVzdC16aWNjbHNtLW9mZiB0ZXN0LW1pc2Etdw0KPiArDQo+ICsjIC1XbCwtLW5v
ZXhlY3N0YWNrIHRvIGF2b2lkIGxpbmtlciB3YXJuaW5ncyBmb3IgLlMgZmlsZXMNCj4gwqAlLm86
ICUuUw0KPiAtCSQoQ0MpICQoQ0ZMQUdTKSAkPCAtV2EsLS1ub2V4ZWNzdGFjayAtYyAtbyAkQA0K
PiAtJTogJS5vICQoTElOS19TQ1JJUFQpDQo+IC0JJChMRCkgJChMREZMQUdTKSAkPCAtbyAkQA0K
PiArCSQoY2FsbCBxdWlldC1jb21tYW5kLCBcDQo+ICsJwqAgJChDQykgJChDRkxBR1MpICQoRVhU
UkFfQ0ZMQUdTKSAkPCAtV2EkKENPTU1BKS0tDQo+IG5vZXhlY3N0YWNrIC1jIC1vICRALCBDQywg
JEApDQo+IMKgDQo+IC1RRU1VX09QVFMgKz0gLU0gdmlydCAtZGlzcGxheSBub25lIC1iaW9zIG5v
bmUgLXNlbWlob3N0aW5nIC1rZXJuZWwNCj4gKyUubzogJS5jDQo+ICsJJChjYWxsIHF1aWV0LWNv
bW1hbmQsIFwNCj4gKwnCoCAkKENDKSAkKENGTEFHUykgJChFWFRSQV9DRkxBR1MpICQ8IC1jIC1v
ICRALCBDQywgJEApDQo+IMKgDQo+IC1FWFRSQV9SVU5TICs9IHJ1bi1pc3N1ZTEwNjANCj4gLXJ1
bi1pc3N1ZTEwNjA6IGlzc3VlMTA2MA0KPiAtCSQoY2FsbCBydW4tdGVzdCwgJDwsICQoUUVNVSkg
JChRRU1VX09QVFMpICQ8KQ0KPiArJChSSVNDVjY0X1RFU1RTKTogJTogJS5vICQoTElOS19TQ1JJ
UFQpDQo+ICsJJChjYWxsIHF1aWV0LWNvbW1hbmQsICQoTEQpIC1UICQoTElOS19TQ1JJUFQpICQ8
IC1vICRALCBMRCwNCj4gJEApDQo+IMKgDQo+IC1FWFRSQV9SVU5TICs9IHJ1bi10ZXN0LW1lcGMt
bWFza2luZw0KPiAtcnVuLXRlc3QtbWVwYy1tYXNraW5nOiB0ZXN0LW1lcGMtbWFza2luZw0KPiAt
CSQoY2FsbCBydW4tdGVzdCwgJDwsICQoUUVNVSkgJChRRU1VX09QVFMpICQ8KQ0KPiArVEVTVFMg
Kz0gaXNzdWUxMDYwIHRlc3QtbWVwYy1tYXNraW5nIHRlc3QtbWluc3RyZXQtZWNhbGwgdGVzdC1j
cmMzMg0KPiBcDQo+ICsJIHRlc3QtbWlzYS13IHRlc3QtemljY2xzbSB0ZXN0LXppY2Nsc20tb2Zm
DQo+IMKgDQo+IC1FWFRSQV9SVU5TICs9IHJ1bi10ZXN0LW1pbnN0cmV0LWVjYWxsDQo+IC1ydW4t
dGVzdC1taW5zdHJldC1lY2FsbDogdGVzdC1taW5zdHJldC1lY2FsbA0KPiAtCSQoY2FsbCBydW4t
dGVzdCwgJDwsICQoUUVNVSkgLWljb3VudCBzaGlmdD0xICQoUUVNVV9PUFRTKQ0KPiAkPCkNCj4g
KyMgVGVzdHMgY2FuIHByb3ZpZGUgYSBjdXN0b20ga2VybmVsIGNvbW1hbmQgbGluZSBoZXJlDQo+
ICtydW4tdGVzdC1taW5zdHJldC1lY2FsbDogUUVNVV9FWFRSQSA9IC1pY291bnQgc2hpZnQ9MQ0K
PiArcnVuLXRlc3QtY3JjMzI6IFFFTVVfQ1BVID0gcnY2NCx4bHJicj10cnVlDQo+ICtydW4tdGVz
dC1taXNhLXc6IFFFTVVfQ1BVID0gcnY2NCx4LW1pc2Etdz10cnVlLGM9dHJ1ZSx2PXRydWUNCj4g
K3J1bi10ZXN0LXppY2Nsc206IFFFTVVfQ1BVID0gcnY2NCx2PXRydWUsemZoPXRydWUsemljY2xz
bT10cnVlDQo+ICtydW4tdGVzdC16aWNjbHNtLW9mZjogUUVNVV9DUFUgPSBydjY0LHY9dHJ1ZSx6
Zmg9dHJ1ZSx6aWNjbHNtPWZhbHNlDQo+ICsNCj4gKyMgWmljY2xzbTogbWlzYWxpZ25lZCBsb2Fk
L3N0b3JlIHN1cHBvcnQuIEFzc2VtYmxlIG9uZSBzb3VyY2UgdHdpY2U6DQo+IHRoZQ0KPiArIyBk
ZWZhdWx0IGJ1aWxkIGV4cGVjdHMgZXZlcnkgbWlzYWxpZ25lZCBhY2Nlc3MgdG8gc3VjY2VlZA0K
PiAoemljY2xzbT10cnVlKSwNCj4gKyMgdGhlIC1EWklDQ0xTTV9ESVNBQkxFRCBidWlsZCBleHBl
Y3RzIGV2ZXJ5IG9uZSB0byB0cmFwDQo+ICh6aWNjbHNtPWZhbHNlKS4NCj4gK3Rlc3QtemljY2xz
bS5vIHRlc3QtemljY2xzbS1vZmYubzogQ0ZMQUdTICs9IC1tYXJjaD1ydjY0Z2N2X3pmaA0KPiAr
dGVzdC16aWNjbHNtLW9mZi5vOiBDRkxBR1MgKz0gLURaSUNDTFNNX0RJU0FCTEVEDQo+ICt0ZXN0
LXppY2Nsc20tb2ZmLm86IHRlc3QtemljY2xzbS5TDQo+ICsJJChjYWxsIHF1aWV0LWNvbW1hbmQs
IFwNCj4gKwnCoCAkKENDKSAkKENGTEFHUykgJDwgLVdhJChDT01NQSktLW5vZXhlY3N0YWNrIC1j
IC1vICRALCBDQywNCj4gJEApDQo+IMKgDQo+IMKgRVhUUkFfUlVOUyArPSBydW4tcGx1Z2luLWRv
dWJsZXRyYXANCj4gwqBydW4tcGx1Z2luLWRvdWJsZXRyYXA6IGRvdWJsZXRyYXANCj4gwqAJJChj
YWxsIHJ1bi10ZXN0LCAkPCwgXA0KPiAtCcKgICQoUUVNVSkgLXBsdWdpbiAuLi9wbHVnaW5zL2xp
YmRpc2NvbnMuc28gLWQgcGx1Z2luIC1EDQo+ICQ8LnBvdXQgXA0KPiAtCcKgICQoUUVNVV9PUFRT
KSAkPCkNCj4gKwnCoCAkKFFFTVUpIC1tb25pdG9yIG5vbmUgLWRpc3BsYXkgbm9uZSBcDQo+ICsJ
CcKgIC1jaGFyZGV2IGZpbGUkKENPTU1BKXBhdGg9JDwub3V0JChDT01NQSlpZD1vdXRwdXQNCj4g
XA0KPiArCQnCoCAtcGx1Z2luIC4uL3BsdWdpbnMvbGliZGlzY29ucy5zbyAtZCBwbHVnaW4gLUQN
Cj4gJDwucG91dCBcDQo+ICsJCcKgICQoUUVNVV9PUFRTKSAkPCkNCj4gwqANCj4gwqBFWFRSQV9S
VU5TICs9IHJ1bi1wbHVnaW4taW50ZXJydXB0ZWRtZW1vcnkNCj4gwqBydW4tcGx1Z2luLWludGVy
cnVwdGVkbWVtb3J5OiBpbnRlcnJ1cHRlZG1lbW9yeQ0KPiDCoAkkKGNhbGwgcnVuLXRlc3QsICQ8
LCBcDQo+IC0JwqAgJChRRU1VKSAtcGx1Z2luIC4uL3BsdWdpbnMvbGliZGlzY29ucy5zbyAtZCBw
bHVnaW4gLUQNCj4gJDwucG91dCBcDQo+IC0JwqAgJChRRU1VX09QVFMpICQ8KQ0KPiAtDQo+IC1F
WFRSQV9SVU5TICs9IHJ1bi10ZXN0LWNyYzMyDQo+IC1jb21tYTo9ICwNCj4gLXJ1bi10ZXN0LWNy
YzMyOiB0ZXN0LWNyYzMyDQo+IC0JJChjYWxsIHJ1bi10ZXN0LCAkPCwgJChRRU1VKSAtY3B1IHJ2
NjQkKGNvbW1hKXhscmJyPXRydWUNCj4gJChRRU1VX09QVFMpICQ8KQ0KPiAtDQo+IC0jIFppY2Ns
c206IG1pc2FsaWduZWQgbG9hZC9zdG9yZSBzdXBwb3J0LiBBc3NlbWJsZSBvbmUgc291cmNlIHR3
aWNlOg0KPiB0aGUNCj4gLSMgZGVmYXVsdCBidWlsZCBleHBlY3RzIGV2ZXJ5IG1pc2FsaWduZWQg
YWNjZXNzIHRvIHN1Y2NlZWQNCj4gKHppY2Nsc209dHJ1ZSksDQo+IC0jIHRoZSAtRFpJQ0NMU01f
RElTQUJMRUQgYnVpbGQgZXhwZWN0cyBldmVyeSBvbmUgdG8gdHJhcA0KPiAoemljY2xzbT1mYWxz
ZSkuDQo+IC1aSUNDTFNNX01BUkNIID0gLW1hcmNoPXJ2NjRnY3ZfemZoDQo+IC1DTEVBTkZJTEVT
ICs9IHRlc3QtemljY2xzbSB0ZXN0LXppY2Nsc20tb2ZmDQo+IC0NCj4gLXRlc3QtemljY2xzbTog
dGVzdC16aWNjbHNtLlMgJChMSU5LX1NDUklQVCkNCj4gLQkkKENDKSAkKENGTEFHUykgJChaSUND
TFNNX01BUkNIKSAkPCAtV2EsLS1ub2V4ZWNzdGFjayAtYyAtbw0KPiB0ZXN0LXppY2Nsc20ubw0K
PiAtCSQoTEQpICQoTERGTEFHUykgdGVzdC16aWNjbHNtLm8gLW8gJEANCj4gLQ0KPiAtdGVzdC16
aWNjbHNtLW9mZjogdGVzdC16aWNjbHNtLlMgJChMSU5LX1NDUklQVCkNCj4gLQkkKENDKSAkKENG
TEFHUykgJChaSUNDTFNNX01BUkNIKSAtRFpJQ0NMU01fRElTQUJMRUQgJDwgLVdhLC0NCj4gLW5v
ZXhlY3N0YWNrIC1jIC1vIHRlc3QtemljY2xzbS1vZmYubw0KPiAtCSQoTEQpICQoTERGTEFHUykg
dGVzdC16aWNjbHNtLW9mZi5vIC1vICRADQo+IC0NCj4gLUVYVFJBX1JVTlMgKz0gcnVuLXRlc3Qt
emljY2xzbQ0KPiAtcnVuLXRlc3QtemljY2xzbTogdGVzdC16aWNjbHNtDQo+IC0JJChjYWxsIHJ1
bi10ZXN0LCAkPCwgJChRRU1VKSAtY3B1DQo+IHJ2NjQkKGNvbW1hKXY9dHJ1ZSQoY29tbWEpemZo
PXRydWUkKGNvbW1hKXppY2Nsc209dHJ1ZSAkKFFFTVVfT1BUUykNCj4gJDwpDQo+IC0NCj4gLUVY
VFJBX1JVTlMgKz0gcnVuLXRlc3QtemljY2xzbS1vZmYNCj4gLXJ1bi10ZXN0LXppY2Nsc20tb2Zm
OiB0ZXN0LXppY2Nsc20tb2ZmDQo+IC0JJChjYWxsIHJ1bi10ZXN0LCAkPCwgJChRRU1VKSAtY3B1
DQo+IHJ2NjQkKGNvbW1hKXY9dHJ1ZSQoY29tbWEpemZoPXRydWUkKGNvbW1hKXppY2Nsc209ZmFs
c2UgJChRRU1VX09QVFMpDQo+ICQ8KQ0KPiArCcKgICQoUUVNVSkgLW1vbml0b3Igbm9uZSAtZGlz
cGxheSBub25lIFwNCj4gKwkJwqAgLWNoYXJkZXYgZmlsZSQoQ09NTUEpcGF0aD0kPC5vdXQkKENP
TU1BKWlkPW91dHB1dA0KPiBcDQo+ICsJCcKgIC1wbHVnaW4gLi4vcGx1Z2lucy9saWJkaXNjb25z
LnNvIC1kIHBsdWdpbiAtRA0KPiAkPC5wb3V0IFwNCj4gKwkJwqAgJChRRU1VX09QVFMpICQ8KQ0K
PiDCoA0KPiAtRVhUUkFfUlVOUyArPSBydW4tdGVzdC1taXNhLXcNCj4gLXJ1bi10ZXN0LW1pc2Et
dzogdGVzdC1taXNhLXcNCj4gLQkkKGNhbGwgcnVuLXRlc3QsICQ8LCAkKFFFTVUpIC1jcHUgcnY2
NCQoY29tbWEpeC1taXNhLQ0KPiB3PXRydWUkKGNvbW1hKWM9dHJ1ZSQoY29tbWEpdj10cnVlICQo
UUVNVV9PUFRTKSQ8KQ0KPiArQ0xFQU5GSUxFUyArPSBpbnRlcnJ1cHRlZG1lbW9yeSBkb3VibGV0
cmFwDQo+IMKgDQo+IMKgIyBXZSBkb24ndCBjdXJyZW50bHkgc3VwcG9ydCB0aGUgbXVsdGlhcmNo
IHN5c3RlbSB0ZXN0cw0KPiDCoHVuZGVmaW5lIE1VTFRJQVJDSF9URVNUUw0K

