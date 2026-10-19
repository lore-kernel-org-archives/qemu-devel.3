Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21B90CCA490
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2026 02:23:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xId2C-0005c1-Pr; Sun, 18 Oct 2026 22:23:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=7454c2a62=Alistair.Francis@wdc.com>)
 id 1xId27-0005bs-85
 for qemu-devel@nongnu.org; Sun, 18 Oct 2026 22:23:27 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=7454c2a62=Alistair.Francis@wdc.com>)
 id 1xId25-0001Tf-KS
 for qemu-devel@nongnu.org; Sun, 18 Oct 2026 22:23:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1792376605; x=1823912605;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=uA3hGv60fkd39KL1SSTYG7CUNdufnMAqXVfayfDnl5A=;
 b=QxtCdE9O+vRioF85aJJAILmOa0AYl6jEhOdZ73TP89m7wk+V4N6VrFZp
 awq0fvRTtGlRmIjaABfthAf6GfDKdnJwInl/8ZUqlxQ6oVXeTGGArgzRl
 prySyZOm77bU1e5C7RaMOumJHhlxd4lxBYww0+XjK9PH3LseLxtBdZ9LX
 nNPyRJsWZ4gwcGc7OVArXJagaOmMdQEErmh33sTkFJlD6/hp9/AgFWoL4
 +Ss0Y3Xo5qIL9WhPWCy9c7HhWGTfEaN9JbTKcXikhSHBe5S4/obG3D60S
 fKKMFkJeSSypg66qWFv7BE8o1PaBza+8uE6h3KCOGn6P2MTFX9KCkOIt7 Q==;
X-CSE-ConnectionGUID: EKRJEdgDRHe0+PBDY/Zo6Q==
X-CSE-MsgGUID: eBwMa1gYQmu1CQeQMb+ypg==
X-IronPort-AV: E=Sophos;i="6.27,166,1786982400"; d="scan'208";a="158416650"
Received: from mail-northcentralusazon11012059.outbound.protection.outlook.com
 (HELO CH5PR02CU005.outbound.protection.outlook.com) ([40.107.200.59])
 by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 19 Oct 2026 10:23:24 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C5nYHWqNBr25tFOOCe8TTXvYjcij4cMc9jLdrVlW0MtUMaM0EzTyYfFPxb6Uhvqsn4QhdtSzbhnkVJbaQeJN6kaMiled+iXglBjZrc3k72gJyMIhVWPryayR08Q6V3e0DxJL8IPjtc5GhBjSz46VIg3299dOfAt6v9ErEt2bcFC9GgFBr5D5wYBR2C0qVAIdv+xBEP1HzL/vChXVRVAo5+pch6pcNbUDdNKezN7y/5kwAeDzoQ6tTBfAaRYW5HEcLbK4TH4fo22/KZpqJg0NUu/vl3EH9T2baxlOhxVvqpaeoognFTcsHvdWFmNUy37e49KWbW7iggtDmt0+YWs5PQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uA3hGv60fkd39KL1SSTYG7CUNdufnMAqXVfayfDnl5A=;
 b=plFnbDLMDV7G9rFP0Pc52oCtQqSWTElczIA/zISTmjsaTTDWluul2AK8l0dVSLigRcyg0mEptQ4cbOiZdb7OnFD0CDA8EIoaebF8obKmzN4h1yEtHh+c/qMFYKht/g2q0UPBJh1TOeJOsAzlyZ+KCW+uh9dAiXp/M8llAubck51lnEzPdh2hM/UaPVroccJPjSOt4+VamRyqPAEa0PkN4oUwpT8aDvN/5lm7lqHs28/oQyHhhlx8f7ZLXdf96iyewGsXoD9i8Qzbv39wKP5HOMY4WnQyMwMPoQ+kiwsIZPYGs4vLsmuncA4gTOyWbU4LSf+JaCfGqpvp3qT8eGx1YA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uA3hGv60fkd39KL1SSTYG7CUNdufnMAqXVfayfDnl5A=;
 b=P1INhbpPx83l7+E9XhwxLxpny8iXspo8czI4qmUx/K0oELib7wYuAvw/qEUOM9lTaIwJgWs8MGNzCJ4y/x7KSOKmKtYCFd0JBkxXS+5FKOuCOt+kulsgf55+2FAA9pmsoKM3zqll7CnUqv77wJP9dNHESW+fOnFxkMRte/kFu44=
Received: from MN6PR04MB9359.namprd04.prod.outlook.com (2603:10b6:208:4f2::13)
 by MN6PR04MB9336.namprd04.prod.outlook.com (2603:10b6:208:4f1::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Mon, 19 Oct
 2026 02:23:22 +0000
Received: from MN6PR04MB9359.namprd04.prod.outlook.com
 ([fe80::e729:bbef:5a37:2e77]) by MN6PR04MB9359.namprd04.prod.outlook.com
 ([fe80::e729:bbef:5a37:2e77%4]) with mapi id 15.21.0522.017; Mon, 19 Oct 2026
 02:23:22 +0000
From: Alistair Francis <Alistair.Francis@wdc.com>
To: "pierrick.bouvier@oss.qualcomm.com" <pierrick.bouvier@oss.qualcomm.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "philmd@oss.qualcomm.com" <philmd@oss.qualcomm.com>,
 "daniel.barboza@oss.qualcomm.com" <daniel.barboza@oss.qualcomm.com>,
 "anjo@rev.ng" <anjo@rev.ng>
Subject: Re: [PATCH v2 1/9] target-info: add target_base_riscv
Thread-Topic: [PATCH v2 1/9] target-info: add target_base_riscv
Thread-Index: AQHdXcVSxPvqUDORmkaDLnNfUpZZx7cEJhOA
Date: Mon, 19 Oct 2026 02:23:22 +0000
Message-ID: <6e8bfc7ae4056186266477fd15711363456a6fb1.camel@wdc.com>
References: <20261016232304.1215119-1-pierrick.bouvier@oss.qualcomm.com>
 <20261016232304.1215119-2-pierrick.bouvier@oss.qualcomm.com>
In-Reply-To: <20261016232304.1215119-2-pierrick.bouvier@oss.qualcomm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.62.0 (by Flathub.org) 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN6PR04MB9359:EE_|MN6PR04MB9336:EE_
x-ms-office365-filtering-correlation-id: fdd604cf-e57f-4a3c-6195-08df2d87f2c5
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|19092799006|366016|10070799003|23010399003|1800799024|261009223027099003|10067099003|56012099006|22082099003|18002099003|11063799006|4143699003|38070700021;
x-microsoft-antispam-message-info: KadPQqpOc+RRxcJ/56IwIOcuZqpQwSQHCj8Ph2vVifh0yCM5jDDSPeGgfcFibfVvyRKEqYjjNyifsrPvs8pLcOZSlZKv3pgQd86fIXeDm3MWZChIfIVW9RM78imjPeQHbQ8gSD7F3HIxzGXuehoKv7btl3g5g/Ocg7ULA9Nq9dAAYsDRRclATq+McHLD/F2bY/59PDNyqzcLTTyaNWLBE2TfUUmxplMbz4i+oFcZWCiFG3QsjrKMlPitt4qZIZlU7dmAHIVAXNxGLK6AegQd6wSKesNGeoXHxnjdepPYatlaL4q66Hevbfzq+wnU2gV/kEG2Lqn6hzLQGZ4LdLGro3VXbyQnkmHWflBxJuidRJkJOHaqiIig2aJ0nCs9tH8zMqZkHl3UptzGxCdOga8zdl02bZHXmReed3+PyzzHP/KRo/f1as/ktYNhUPZPkVh7EZp1eP0N6KW6MJT62wpdYfcba4FdRDQkiUM6hQlKTVeXUvbOTSSXMeKEQ21GwWfYzr+f9EPRx30JRZXxB3dbTyTB/HvzQU2lAQ8ZnLoYJj7O3ZheGWmjIHhdmyhX3g561f7ApZwF9LwR8DMJp8YYiITpbQIdqiLYvrXrzi2/yrz6jBwWUV5yZDoaxrW4yPHGnMeAPiSQ7sClxkHldFecCiwrqNQ0J64tzYFEbNHH2UFMCMt1I0fEwJCLY/xJH+vTKk0spr3YZ+qiTOURIBSDhmWlOFxfbyo8HEtSU8RmFO8=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN6PR04MB9359.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(19092799006)(366016)(10070799003)(23010399003)(1800799024)(261009223027099003)(10067099003)(56012099006)(22082099003)(18002099003)(11063799006)(4143699003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RWVXSWhHWlgxM0tMdldFM1JrWS9FNjBRdnROZVJPN1lIbDc2czNlVXhBU2dm?=
 =?utf-8?B?SG9PbWZ1N2swQnNSWSswOE5pVFFKZzRxNjdtUTdDcGlwejc1MXI5YUx4OUgw?=
 =?utf-8?B?S1JsbVNKSE1GNTQzVldTcTNHMzMxMFhQT0pCWGM4SDUzQ1ZoK1FLWU4rVFN1?=
 =?utf-8?B?NGdQZ1lHZUxnbnhhc2MvTHlNTmp0QW14MUoyenZZdDVGOUZBRXJ2aEFyblZW?=
 =?utf-8?B?THZ0OWJYd2hTdXJuR1VPU1psbUFHTWdRc2ViMXlOSjMzMGhNVy8rR2VpbUx1?=
 =?utf-8?B?aG83QkUzelZqVXR6ZjR3VDk0NmwrbEJZalN6TmlzanFQblZaTDg0ZGNIcjNl?=
 =?utf-8?B?dnVpTjRWWmtQT1BzdndQNnB5bjBzTGZGVmVJOEJqWHZwMjZjWUlSV1BtSlJw?=
 =?utf-8?B?QkQrY2YxNUhhMGRTWDg4QXBJcjg3Q2hNNmNhb0Z0SnRSREdDa2VoenVkNEV0?=
 =?utf-8?B?a295em1ucG96eU8wS0RYaTIrRVVWeU1HOEtqKzBIaEtZZ3E3MWdSOVBETnhz?=
 =?utf-8?B?bWFCcHpIVEVQSGRDN0FYUGx3b0kyc1RoaVVuaE51OGVjVnp5Q1ZuNDd0eUZ2?=
 =?utf-8?B?cllvbFRYYjZJYWtucUszT0tpaUFuYmNwcWViN2RuZjkvNWJPY3ZGNnZhNUIr?=
 =?utf-8?B?b3RpcU5FTGhuZXNwUjd3L1BSS1FIck5CMkJoYUpxTmFCaFBFZHBLYktRT0Zz?=
 =?utf-8?B?T0IzZlVmUCtabFlmdDFkWjd2eDFRTG5GaExlNHkrekNXM0JLNW1sTG5iR0FX?=
 =?utf-8?B?bmhDMW5ORDBPcTJ6akxZTWJyaytDVUlLc0V4RFBUNElzdi9vM2I0RXBOcGJK?=
 =?utf-8?B?UEhQdTFsc1g3ZnlmSzhSc2NQZlFGbjdOMlJjUmp1SUNvTnRzZ0g2QkhWSmhz?=
 =?utf-8?B?bHNUa2dJM2wyb3BFWW1wSE8wOFkwUklvNEgzbGw5NksxdTJoQWMvY0o2MGdW?=
 =?utf-8?B?OHNlK3RDYXJtTFI2SXBjaWFxbEw4OUszL1Z4elN3VHc3eHF3Z0tESlhkcXhI?=
 =?utf-8?B?T3hOZXZaRUpTTko5UTFYZjJBQVJUN29Hb0E4NlpZc0FROTc4bFRKbzJqeHRJ?=
 =?utf-8?B?MTduS1gwcHBpdk1zNHQyTWZOWU12MElsSnFiWlozQTJtT0gxd0NsN0pRdWgw?=
 =?utf-8?B?cHh3eGl6TG9pNG41Uk5mSDNSdXNrRzMxMGtBaUZ2ZzdEcnZBdmtuc3FuR0FH?=
 =?utf-8?B?UWhDWUFBUUs2WFJ5amFneFZWOUhFQVNjbDkxajFuZkJMSkpzRlk5WFkrUk80?=
 =?utf-8?B?Nm5ZdWlXeHcrc1lWTjF4c1l2KytSSG14MXpSM0ZQUkNWWVlJaE5FVlZQaCtk?=
 =?utf-8?B?R3lPTmgzVFAwYWVUR2JyTzZTMVd3ZzIxRjRaYWJUeFljUWU5eFBMZ3F3Q21D?=
 =?utf-8?B?Z0tRd0JvendHeGo1L09abWF0OHZoQXRkS2NONVgxeEJwdXVYaDBjMDlMQkll?=
 =?utf-8?B?OVRLQXJWQ3E1OE9zSk45Rzl5SHhWejAxLzhKdFNOM0FRU0lIMllaVGkzN25i?=
 =?utf-8?B?a2dkdHdPNTg2Z0YxajN5WkhBWEdwR2pjSUt5d0JPaE9pWWJRNDdYaTFhODN4?=
 =?utf-8?B?Uyt1RXh0MFJ2aDZSZU1uTGw3RWQ4ZGdWNlNac0NPMnpzZHhWY3Jtb2RDOVND?=
 =?utf-8?B?NW1xZnZxcWtTSGdFb01JcGp0dzB1R3JZdW41U2VMNkhCMlc5bFhLUFhYZ1dC?=
 =?utf-8?B?a0RFdXk5UFBjYVRrL2JDVFBmQzU4dXpXcE8vb0pOdGlRQVBCMEJwVEc3cVZp?=
 =?utf-8?B?STRpMGJqaEV5WjVQRFlLZTRjR21qNHFtdkd1VUlwYTlMNENXcFg5THN5UkVW?=
 =?utf-8?B?U21pekdOSHNNYmg1dE5ZTWF5KzQ0OVU1MFA2RFZuOGVIbmpJbGZsMlhNZDB1?=
 =?utf-8?B?V1JscENsMTVSTlIwNGtQRHc5WFkwRVZCbmZrc1Z3S2FnNFczK3d2WDhrVGgv?=
 =?utf-8?B?TEt5QldIV2dXVEFVa3Y2YXVTTGdEbUR3K1BVU1dsS1F1WktrbjUrbXZqSHN1?=
 =?utf-8?B?aGwra0ZrbHI5THU4T09LMDQzOWg5aVJLSjZ1UmlnSFNiTElKellFWU5OMEFk?=
 =?utf-8?B?LzVNZXpMS0tCQ0NhNFNXaUZPcnZaYnZWcmtKNEw5Sm9ISjdFWjFtZWoyMUZS?=
 =?utf-8?B?cm85VkU5N0EyMFFNNFJGQnR6TXhNQjJXdU9kNndSZStwTzE4ZEcrYVQvNk5t?=
 =?utf-8?B?RDRVNW1HeFRqMUR3ZGtJK1J1dVJkRDYzdjBtZ0RyVVU0Z3lBUXM3RHRWaWpL?=
 =?utf-8?B?ekx2QkxFaHhPaHlCTFlkamtJdWl1bnFFRkx0cXVzUnU4cnllRzN4em9lVys3?=
 =?utf-8?B?ZDVkL3M4a0VIUEZBMmE0eWtxZkFUdFQ2RFlqbEQyZmF1Wk1WNWZOOUtIcG9v?=
 =?utf-8?Q?pcEZpyEKGz7KO60WH7XOrJCxbPXc9ydQfLvGQIK0w+g3K?=
x-ms-exchange-antispam-messagedata-1: MzoKIsv+9s95pVlQz/g2VWXPPR9QcwGQSLg=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7566CE4D9DFB104F8A1168408D0B7EB3@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: aWOn0VxkZMpiaqb+aAnRKARkR1yq2NxJb0FLvJvCazxdKwBMI6Wz9xi7O7ItsykWDMfeebi0z3M2+tDjxQnmY8kMphx2F3IQ9PnJ6i2ZQ+TrfcGgQm8WnqU0JS/6GxoxltL70H+KJiSe1HU8+d2SSTcenvf0nlIkN1dTGNv45CtkKxTncHV4jy2/81KgQqjg4y7efUiKvE10UbQ24pSeVPvvimOsW5Akhk8h/NAucGFF9II/FOUu3HgrcCT2yOBQe6HlSxP3JPtcXud39kX02/wYRDUC2thS/VSYeBj/mSEApkgVZPOMQkD+aQOUXd6PlgUqZqw/Ou/I8ayKfWW5mQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: suIaQUx4wqlFX4YVj30aY8hNAth3JM7HUMXhGEH7PYWGKaQhYegf8i6Hjn/fOGBRiMRwJqRP0UF3O1Ekd1Tox4y3K6tLFR8dQeagd9ulXuL5iUwXnOamRVPThX7MuTEy8mUV66vb4dIfKnZ2d/CSh5P+/tV7s+PtgYODfbsIlPRAtSgUIgwsQ15Ax+h83U5K96Qk3G8X9Ghi4k5/xtjY5dKuKbeQofGvZy9SK71BbWgHEkXDVH9H7yaBOWfN4r/Zy9ts3Rn0NsWRO/Tgp0O/vTLXUopIorvY+C2wI0qlK6qNabT1dcZAVH/NRuqP29slqwyhy9LVGaWHEB/qzHqmGyp3QbR9+pjlX0T2lb9vZ4oNrDu15IHfwvspMDLwOumE9ypLAa67um6K7pN4Si4zHE4Q4O6qbhGBUM10eD0VQWDd3vGbSzVzPJv0Ha95P3QYZ556Q5Hy+FByQxHGDqlhvC0Y0jiaGdn9Ytz9/hmkJPnnI45jdNFYqoeZBUKUcbcUtkpXRziKTAlTbZrzOpe2D0QYGKZW+V4WZ0HMgJ5i7A0sIhnnuxuhAeQTECV7Kh36FfbtcjVLKFNTMmQcstyhjTP6i/NNkgY6Keui7/GoMDSfHrXnuvSNItvs9tCiKFIl
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN6PR04MB9359.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fdd604cf-e57f-4a3c-6195-08df2d87f2c5
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Oct 2026 02:23:22.6414 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: B5QHzotDkQCy12TLIx4pu4umOCIZghgdgDon2gO21YeCwJXqcCIuf3isFy6tMwS+X+tb7PvNz6I4I3WlY5CrgSshnKCuQFiVOe2Vt5lBimQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR04MB9336
Received-SPF: pass client-ip=216.71.153.141;
 envelope-from=prvs=7454c2a62=Alistair.Francis@wdc.com;
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

T24gRnJpLCAyMDI2LTEwLTE2IGF0IDE2OjIyIC0wNzAwLCBQaWVycmljayBCb3V2aWVyIHdyb3Rl
Og0KPiBSZXZpZXdlZC1ieTogRGFuaWVsIEhlbnJpcXVlIEJhcmJvemENCj4gPGRhbmllbC5iYXJi
b3phQG9zcy5xdWFsY29tbS5jb20+DQo+IFNpZ25lZC1vZmYtYnk6IFBpZXJyaWNrIEJvdXZpZXIg
PHBpZXJyaWNrLmJvdXZpZXJAb3NzLnF1YWxjb21tLmNvbT4NCg0KQWNrZWQtYnk6IEFsaXN0YWly
IEZyYW5jaXMgPGFsaXN0YWlyLmZyYW5jaXNAd2RjLmNvbT4NCg0KQWxpc3RhaXINCg0KPiAtLS0N
Cj4gwqBpbmNsdWRlL3FlbXUvdGFyZ2V0LWluZm8uaCB8wqAgNyArKysrKysrDQo+IMKgdGFyZ2V0
LWluZm8uY8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHwgMTEgKysrKysrKysrKysNCj4gwqAy
IGZpbGVzIGNoYW5nZWQsIDE4IGluc2VydGlvbnMoKykNCj4gDQo+IGRpZmYgLS1naXQgYS9pbmNs
dWRlL3FlbXUvdGFyZ2V0LWluZm8uaCBiL2luY2x1ZGUvcWVtdS90YXJnZXQtaW5mby5oDQo+IGlu
ZGV4IDg2MjA5N2M2YzYzLi5iMGYzYjRjZmI4YiAxMDA2NDQNCj4gLS0tIGEvaW5jbHVkZS9xZW11
L3RhcmdldC1pbmZvLmgNCj4gKysrIGIvaW5jbHVkZS9xZW11L3RhcmdldC1pbmZvLmgNCj4gQEAg
LTExMiw2ICsxMTIsMTMgQEAgYm9vbCB0YXJnZXRfcHBjNjQodm9pZCk7DQo+IMKgICovDQo+IMKg
Ym9vbCB0YXJnZXRfczM5MHgodm9pZCk7DQo+IMKgDQo+ICsvKioNCj4gKyAqIHRhcmdldF9iYXNl
X3Jpc2N2Og0KPiArICoNCj4gKyAqIFJldHVybnMgd2hldGhlciB0aGUgdGFyZ2V0IGFyY2hpdGVj
dHVyZSBpcyBSSVNDLVYgMzItYml0IG9yIDY0LQ0KPiBiaXQuDQo+ICsgKi8NCj4gK2Jvb2wgdGFy
Z2V0X2Jhc2VfcmlzY3Yodm9pZCk7DQo+ICsNCj4gwqAvKioNCj4gwqAgKiB0YXJnZXRfcmlzY3Y2
NDoNCj4gwqAgKg0KPiBkaWZmIC0tZ2l0IGEvdGFyZ2V0LWluZm8uYyBiL3RhcmdldC1pbmZvLmMN
Cj4gaW5kZXggMjU0NTMwZDhlYTUuLmU4MjcwMjZiZDIzIDEwMDY0NA0KPiAtLS0gYS90YXJnZXQt
aW5mby5jDQo+ICsrKyBiL3RhcmdldC1pbmZvLmMNCj4gQEAgLTEwNCw2ICsxMDQsMTcgQEAgYm9v
bCB0YXJnZXRfczM5MHgodm9pZCkNCj4gwqDCoMKgwqAgcmV0dXJuIHRhcmdldF9hcmNoKCkgPT0g
U1lTX0VNVV9UQVJHRVRfUzM5MFg7DQo+IMKgfQ0KPiDCoA0KPiArYm9vbCB0YXJnZXRfYmFzZV9y
aXNjdih2b2lkKQ0KPiArew0KPiArwqDCoMKgIHN3aXRjaCAodGFyZ2V0X2FyY2goKSkgew0KPiAr
wqDCoMKgIGNhc2UgU1lTX0VNVV9UQVJHRVRfUklTQ1YzMjoNCj4gK8KgwqDCoCBjYXNlIFNZU19F
TVVfVEFSR0VUX1JJU0NWNjQ6DQo+ICvCoMKgwqDCoMKgwqDCoCByZXR1cm4gdHJ1ZTsNCj4gK8Kg
wqDCoCBkZWZhdWx0Og0KPiArwqDCoMKgwqDCoMKgwqAgcmV0dXJuIGZhbHNlOw0KPiArwqDCoMKg
IH0NCj4gK30NCj4gKw0KPiDCoGJvb2wgdGFyZ2V0X3Jpc2N2NjQodm9pZCkNCj4gwqB7DQo+IMKg
wqDCoMKgIHJldHVybiB0YXJnZXRfYXJjaCgpID09IFNZU19FTVVfVEFSR0VUX1JJU0NWNjQ7DQo=

