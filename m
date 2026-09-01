Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7FFDC624CE
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2026 05:41:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1HEl-0007FV-IQ; Tue, 01 Sep 2026 01:40:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=6977d653a=Alistair.Francis@wdc.com>)
 id 1x1HEi-0007F1-EL; Tue, 01 Sep 2026 01:40:44 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=6977d653a=Alistair.Francis@wdc.com>)
 id 1x1HEf-0000l4-MN; Tue, 01 Sep 2026 01:40:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1788241241; x=1819777241;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=laaFVm/lRxsg9nEfJgadAM0exJKg7KLSki+sZJCLWkA=;
 b=SnuhDpKiCDq8oROapuvaseHB3pv2pMrup8cb4Bbu+Y+A6l16UP4KGL+J
 krltGZpfgxNHWnFLUQt1ckb7RzYaTuJEWTRuEGz8dCu2sXH1nCD8XKHG8
 3oiPCvihcWT8LspsoXnECJrlpHnsR9as+TUZfQNMYin2rd03tm7jwTSgh
 VsmJDtDgLt7Clb/TR0LjkwWDB0GfiGSMfmuf3bx0pmT4LL5YnYXrOcBh9
 ZWDdfX8+AL0HUtqrDXg4HDdqkJdFXWGP8P5b/7ydNc/RtuJGzdb8BXHYe
 0yQ9UoozkQwJCSJAwk5E2z+BofCBneFZht5ysCPvdeI+wWRAnkKJA9ZSv Q==;
X-CSE-ConnectionGUID: ndhiNg4HQRCqOCWLfkfAmQ==
X-CSE-MsgGUID: s6a8qkRvTI+2E9ROVuSG9Q==
X-IronPort-AV: E=Sophos;i="6.25,255,1779120000"; d="scan'208";a="154675950"
Received: from mail-westusazon11012061.outbound.protection.outlook.com (HELO
 SJ2PR03CU001.outbound.protection.outlook.com) ([52.101.43.61])
 by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 01 Sep 2026 13:40:38 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BYy72VtF2sPvGkp/kxehm6w89bcOF1zus8n2SKXYHChqMgam6QF22WRRrZ/bA8qzE6zDxs6EPrAoJTVTQv4r87reeMIa1mPbPDAT5GmFNOIryEMIJsYDwQUYC08+5yP5qtnyjbqpcp+VFPUt+3hCYObqwNwMqdyUR9BF6e6w7/WBVW8mTWOtpThZ2tH8hAcZcicBqRNekYvyDjqTo8/wrn//DcVhffmr+wvNOzqk2Ws6xceoXEJUWl+4p99gezg/sbTCZMz+MBXcETLGVwfEGOjEQemxJzRGnbKzDGenjikifkm/464EZ2cL0woeIsD60K1cR0iY35uSPgH6vPoWkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=laaFVm/lRxsg9nEfJgadAM0exJKg7KLSki+sZJCLWkA=;
 b=pviktd4WRr3dKibl/2SCM+fKYekEkh/rJx8ck9N4xT81HsFxfsR9VD36mCXQ93vg62UZd/l5h0yG3HWer93sULHmT3mr3+erndrnDLa1P4omoHTHs89U4bEPgAznfmI2OWuyw1TThXNm00H2P+B2ryCbMEiM/awnesL/9D9sBw7xTF7vmTv2S7HDA/fyya431TS0VURxMlz2vYAiGKRJIwh+YECuDpiVWiOlLdbSjASMgZgl8/YMdlmettQuCGe1e/k0ktz9vowW0IHCmIQqWSrQU4djpGxEcHHlacL8Bxh9i90bm743VcFZBj9pRHHxyPG85OExgGjjLE9phSFByA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=laaFVm/lRxsg9nEfJgadAM0exJKg7KLSki+sZJCLWkA=;
 b=vVtgzEoZTXl/sCostE7c8RXrP20PMoC9s97wDcJ6VFpfFc2P0IxeXkbdBqAGMyWUXkTmwNEa9t8KtStZFYozW/DJM357fWzz73YXwn6Z0v2tN5Aggx14C3gC2AhJlwUTpZ8WVmO0pFc7ylttRrS7fPF9FRCCBjP2sXiiaADlLZs=
Received: from BY1PR04MB9561.namprd04.prod.outlook.com (2603:10b6:a03:5b6::11)
 by CH3PR04MB8928.namprd04.prod.outlook.com (2603:10b6:610:1a8::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Tue, 1 Sep
 2026 05:40:36 +0000
Received: from BY1PR04MB9561.namprd04.prod.outlook.com
 ([fe80::3869:e494:2fa8:9888]) by BY1PR04MB9561.namprd04.prod.outlook.com
 ([fe80::3869:e494:2fa8:9888%5]) with mapi id 15.21.0382.007; Tue, 1 Sep 2026
 05:40:35 +0000
From: Alistair Francis <Alistair.Francis@wdc.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "wangyang25@otcaix.iscas.ac.cn" <wangyang25@otcaix.iscas.ac.cn>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "palmer@dabbelt.com"
 <palmer@dabbelt.com>
Subject: Re: [PATCH 1/7] linux-user/riscv: honor zicntr=false for base counter
 CSRs
Thread-Topic: [PATCH 1/7] linux-user/riscv: honor zicntr=false for base
 counter CSRs
Thread-Index: AQHdKTA9b4C2+hQAqE2M4W545dY7P7a5VnAA
Date: Tue, 1 Sep 2026 05:40:35 +0000
Message-ID: <643d560cc2bd07aafd4f5a118652e14aaf12bfb1.camel@wdc.com>
References: <f73caf0640c1446db5c566f1bb005966@wangyang25.otcaix.iscas.ac.cn>
In-Reply-To: <f73caf0640c1446db5c566f1bb005966@wangyang25.otcaix.iscas.ac.cn>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.60.2 (by Flathub.org) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY1PR04MB9561:EE_|CH3PR04MB8928:EE_
x-ms-office365-filtering-correlation-id: d8abf37b-dac2-4f35-874a-08df07eb8c16
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|23010399003|10070799003|19092799006|18002099003|22082099003|56012099006|38070700021|10067099003|11063799006;
x-microsoft-antispam-message-info: KymKOJFGCz5jllUOAwHN6HX6MFBwXVLWUyrZ75f6Ghtlww9nAUfNAalZRqcTz9pDEtRFVgDHU9eXG9jXxjuoLLOtK7D2d2Ka4v8X32eHwjhGUjdUFR4H1sB2XEKsEO0nzlq8Ghn8Z8yOh1hh4jEvuWYlABDow0I3FwCiJ/GK/zpaohQBj51DctqCIlZTgMrjXPaK+VznNWVMACq6H+JpDpl/j9qDtHre6ps29TnZ9HBSJzz7BJbeI0XQBuN1PYNPH6Ztc10XhpvMpJLbsElD2Zjzbg7U/4hxNDxr1+n96VUYidqV7D74Opfo9wFjSv+8nZglHnh0SzPj6J5YzuGvbrIslqcLST7c5kRof7yMQLbSq5GDG83IJnmmc5IVWjIU3Uiepwln1n09dOxn968pgZIGbvMCKdyD6FJRwr6geer4te15YHDL9nyU0m0ZR+mujqsN0VEwuMx8SGRFrMfGAklS1w4IJBZLk8qbYrI8sT9JTYkFQ9s9+qKj4YWZPSKvZ4H94iaOMzzeuGm34dUy20RmsuK+bBtWs/j8NVo1maz69eh/is/hOBNk67qA5JsmzjlX9aDgg5YdPwRTo58TPBanYBfRqvWBQEgRN0r0T2pQJr0sM5RG4TcTLzgw7t+gZDLzvC2WEVSFNoC3rV4uLbaR/skJTN8QBS6ZQ5ZpKQf0VD/k/U8eSNNAC7nEoFMJ7x5/Q4GKREXi1EEMqIOtjk40Tf6ldsJWlcxu3utV1rY=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY1PR04MB9561.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(10070799003)(19092799006)(18002099003)(22082099003)(56012099006)(38070700021)(10067099003)(11063799006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NXlNV0xNN01QVXFEQlI0Vm11MG9LMmpUUlVZVVpsWmNIQ3NrSWp5VUdZS01Q?=
 =?utf-8?B?TU1DRUFRUnF5cnczMTVmNjkvMFA2RnlINnN3WFlKOG4zaEgwYWpURU8yaXFF?=
 =?utf-8?B?eGI3Zk1HQWZVS1F5Vkd4YnRITXorNGE2V3dPTUVBYWNiNzdYVW5sdEc2NkVa?=
 =?utf-8?B?cFF5NHJNZWJtMVJ5ODF5US9MZUhSRTgrQ1VyWTIwQXVaeXFsUkNnM1hyVFJO?=
 =?utf-8?B?bFVQRk8zMEhDNGdic2RnNjNBNDRwRlU4MXg1WmcvVkFIMVA0REU3a0VGeGpk?=
 =?utf-8?B?dEY0RVZFUDArdTFwRkl1aUR5UU5NdUtIRXdDaVFWdjlBc0xKckFlRzI5Ynlv?=
 =?utf-8?B?MlpJM1loZ3BpUStvN0pqOVlURjc4VDdzYldnbVZNa1FGcWwzM1lxT0MvNVJh?=
 =?utf-8?B?dE5QVXROcSs5dUMrK0VWbmpkbHhlOHlpRlFWb2h0VVVtRTZPOXNWNVh0eU45?=
 =?utf-8?B?VGJ3QmZoR0p5S1ZYbDRlYzg2blI0N3RtR25PQXVGYUlXdUMxOVVDMloxRDVI?=
 =?utf-8?B?K0tiRFpLZTJsZmlWSU5XZWZad2tnSS9XMnhPRzhuSC81S3R2VUJGQTNBRUlT?=
 =?utf-8?B?V3hPOFU5Y25mNlJ3NEpZZEdmS3F5RFg1ejNscUFYbWNCTHkwSnM2dkdJRk9k?=
 =?utf-8?B?VE03ZjAzTnU0a25LLzQrdW5xYjB4bG13ZFdpWGIxVFVRY1EzaEcwSnZiUDlO?=
 =?utf-8?B?Rys5T3l5YkRTeTdMdUthQWlYNWk4Qm1RMGdjV3RBbkZmSW16TTdtbThFS3Rw?=
 =?utf-8?B?Y0tLaExJVnVpMnJjWlk4U256NlkyVXZJYUhWSXlvUjc3YlFDR29pbGx4c0Ju?=
 =?utf-8?B?N1ZVazZSZEJ6SUNnSU0yNmg1ZXR4SnFLRGQxQ1Q4VDhiOHFJVlFkdlB5VU9T?=
 =?utf-8?B?ZHFjZis4NExoTWEvM05NMkxtMnR4ZVFpOURaMlM3NkptZ2RlcjY1MlBWZG5s?=
 =?utf-8?B?YWJaUUFLbVlWMXNZdWVjZGpBRnJVU296Qjh6aEU0RzI4MFQ2RDBZK1lkNk5x?=
 =?utf-8?B?RmUzT3VyVkorQjFtdnFDQUpTcXJuaG9zVTJyUE4rOStaYkd5eGUrSU9oMGJ6?=
 =?utf-8?B?c0RUQlBBN2R4UjB1ZmVKRmxocEdaMlczK2ZEenJlbkViaW05N0R5L01hdmNu?=
 =?utf-8?B?UjF0K3lKbnZLWHNQS1RqdHRiNFlQalkyOW5nNWxDWGUxZWdmUlRzajhBYXEw?=
 =?utf-8?B?amMvQzdQbkpKV2RMMTkxNUltUW9YNFhMZTVVOU8yRHlEVkplbnNScFRXdTNV?=
 =?utf-8?B?NzZqcmt3Y20rdGJNZVN4ZEg1NkQydGY5WEg2ZC82WGVGd0RMVmtLc1pwZHZL?=
 =?utf-8?B?dE4xdERHdDN5K1g4SEFON1FLMTVsRjI4WmlVbkxQWTB3bk5FOFkxZzNISUdX?=
 =?utf-8?B?eGQvUm53dEtpR1UvODl6enhncGNuYWwyZVFYZnBNQlZnaEs5TmNZV053dnVY?=
 =?utf-8?B?SXEzamVjd1B0OUI3bTZtUy9ha0wvem5CTTl6dUhiVWQxTWxRNmlqcSs4enpR?=
 =?utf-8?B?OVgrSEhPSVpuQkYrTlBIZEZ6U2hpV2hnR0p1bVhlN3lUM1AvSHBUdVZZSUdo?=
 =?utf-8?B?RTNoUlZ5V0ZlVGxBU1VaWlA2aVFWM0FwYjF0TEdsVmgzeVp1c1Fvdm5ubmpU?=
 =?utf-8?B?clkyaWtwVWY2V055Rlorc1FXTTN5aVhzbzN3c1dQRjBCRERVY29EekYrK3NT?=
 =?utf-8?B?NWNVNXpVdWhwQkIyeVIyWDV1QWtxUjRMcEZPaktRdndmZi9IWkwwNmxpUXE3?=
 =?utf-8?B?WkNYaERWQTdDNWY5eWNDZ3c0dW90MVVxSWI5dG9qcWZtTThSM0t1ZmlSNWdp?=
 =?utf-8?B?ZkdPRitOZUJHQlp0bTEwbnRONS9BbWJaSFR0bFFsNDVoUEhJS2d1VFg0cXZY?=
 =?utf-8?B?UXlPMEVDWmI0YzZ4RnNCQUN2NU1pTEhNTmdJOUtaTUY2UXJtWnR2cmluWDNp?=
 =?utf-8?B?U1JFYTMybXROcE5XdW9MUmRWeEFUdkF0NW9aNzNNejRSd2t1MUdyWDVhUmIx?=
 =?utf-8?B?VmMrZUgrcEkxcUkyQzdRUWxzNHA2QU51aUVVYTVJclM2dTg5T2ZGckVGN0Fo?=
 =?utf-8?B?SkxYWmUvcmoxallCeWYyTzhBQTlPWnhUUnNDM0Q3cHp6T0NXUkc4VW9SYTky?=
 =?utf-8?B?UUZsZmVvUFlIalpiQjFqVXByOHJBM1Z5QjNmMEZLQ0ZFd3BtQWNOZFRBV1BH?=
 =?utf-8?B?MGcxVm9Wdy9ibTFZQTAzOGJkWEw5WjFwU212VTB2VE8xOHM1RUFIVUZqNC9Q?=
 =?utf-8?B?ZDVVZll5SXNBTjdQTmdZSEI0dlpoL2hOYU9wMWF2aXQ2UkpXV1l1U2EzZWJY?=
 =?utf-8?B?STZCSlVkZmMvVmQrcEp4ZVRhQ2MzbWhkT0o4VUp6T1p4ZHRrS0xtbTlyYW5m?=
 =?utf-8?Q?dcxaaPDy+osI45R4Sz2hEpjmbmJKCKE81EM96+rUm98G5?=
x-ms-exchange-antispam-messagedata-1: WldtWY8OAeiTfA38yMpld/YVb2vlG7iQa0k=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4C4507BEA4A98B4FBB41209358E28B99@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: LfQyev+eLokCYnLVxPttetYGNLU9deHIWy+nOMjiMrvsWk+xEuiiGjS6ykHpFD8fYhAWkLaq0Q8FuAM2fE0H+n4s+5YNAuO5iewPzsz7wExy5LJIpx6xZBe8+gBPEXdADQGjSRpV66ohe5M/LuUDtvz/549tcLd7z/GvuMEw6MxIhUTNEMQhTbVro+9Cn8rFc3MdT8jMYuvY0WOXYlQzb/6gBOxMAFhAncWf5rb7ghDZeBKOgNjASQfr6T+TiPCoUDddlOWaFClsLclGGcg7dx0Yp4AX76OVWire7oKFYElD1br1gIwKta40PXmkj1N1B/99E1rTjgc8R7Xki1zhow==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: bjkXzuwAyUzRGa+cAXLp5einii3NES1lPEEAl3f4enB1CVVkKa3CGzeedd4w7jW9T2tilKGhQ8T2+SrhP6b4yhoDu+DIORpqHlc9lwOELLfgwGJBOY9TxjierZmgj/h1mC0V+oJxDG8dqsQ9wRcFDczij7HhyxWGi0I8lVDQCvDTPr294O8VHGlYzPjrfAWeDnewIpE05Nu1Rv4YpXRDwkirbO7o3IYhoaQ1hZgUrS5LrjX4mPT0UlUunMsOSN3juTCDIXuMLfqS3PXEGIUultoEVrpQbBfADaki2aRmSWgRMpw10bmhS5BhmYE3eTtU+w6wZ6//J/tUdYZaphlJC2CtCMGl9L6B2+rLhaWwNrZGxhYiFOzVTWv6v6vi4YNN6qJO0nLG4H1rNSNvE/zSe4eqWy3rNsOw7ySs+X3t5MiHLUa2e51w0x8JU3gxemxg1k5QwmWKQNj6RYRi+6NN1dMVA9O5xh4fIb9nAJgnzm6IIXbt3oP7BeDVDLwodpT5pnIUpDEwNRVwFex+IPUI2t2ZgbknMQXkuu2beiVeXcOFBFEXneq0Po7DIdoY808hvKAQ5wm1aKjgF2Kqmb82nECyidmSeiVFb29NzUjl2CLsH64/0+XYhnc7m6UYiRXM
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY1PR04MB9561.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8abf37b-dac2-4f35-874a-08df07eb8c16
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Sep 2026 05:40:35.8255 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nPKIwjkuKjmQMklRyylwCTgIhhXfSUfxTDyI6FWcWRq28sEN4VC7VRF3AMjbyTpi4J4A4iu1FXd7MAVT+y+RfgRvWVksjp27uTnYInArZQA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR04MB8928
Received-SPF: pass client-ip=216.71.153.141;
 envelope-from=prvs=6977d653a=Alistair.Francis@wdc.com;
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

T24gVHVlLCAyMDI2LTA4LTExIGF0IDA5OjI0ICswODAwLCB3YW5neWFuZyB3cm90ZToNCj4gSW4g
dXNlci1vbmx5IGJ1aWxkcyB0aGUgYmFzZSBaaWNudHIgY291bnRlcnMgY3ljbGUvaW5zdHJldCBh
cmUNCj4gcmV0aXJlZA0KPiB1bmNvbmRpdGlvbmFsbHkgYmVjYXVzZSB0aGUgZXh0X3ppY250ciBn
YXRlIHNpdHMgaW5zaWRlIHRoZQ0KPiAjaWYgIWRlZmluZWQoQ09ORklHX1VTRVJfT05MWSkgYmxv
Y2suwqAgLWNwdSAuLi4gLHppY250cj1mYWxzZSBpcw0KPiB0aGVyZWZvcmUgYWNjZXB0ZWQgYnV0
IGlnbm9yZWQsIHdoaWxlIHRoZSBzaWJsaW5nIHppaHBtPWZhbHNlDQo+IGNvcnJlY3RseQ0KPiBt
YWtlcyBocG1jb3VudGVyMyBpbGxlZ2FsLsKgIE1vdmUgdGhlIGV4dF96aWNudHIgY2hlY2sgYWhl
YWQgb2YgdGhlDQo+IHVzZXItb25seSBibG9jayBzbyBhbiBleHBsaWNpdCB6aWNudHI9ZmFsc2Ug
bWFrZXMgdGhlIGJhc2UgY291bnRlcnMNCj4gYmVoYXZlIGFzIHVuc3VwcG9ydGVkIGluIGxpbnV4
LXVzZXIgbW9kZSwgbWF0Y2hpbmcgbmF0aXZlIGhhcmR3YXJlLg0KPiANCj4gUmVzb2x2ZXM6IGh0
dHBzOi8vZ2l0bGFiLmNvbS9xZW11LXByb2plY3QvcWVtdS8tL3dvcmtfaXRlbXMvNDE0OA0KPiBT
aWduZWQtb2ZmLWJ5OiB3YW5neWFuZyA8d2FuZ3lhbmcyNUBvdGNhaXguaXNjYXMuYWMuY24+DQoN
ClJldmlld2VkLWJ5OiBBbGlzdGFpciBGcmFuY2lzIDxhbGlzdGFpci5mcmFuY2lzQHdkYy5jb20+
DQoNCkFsaXN0YWlyDQoNCj4gLS0tDQo+IMKgdGFyZ2V0L3Jpc2N2L3RjZy9jc3IuYyB8IDExICsr
KysrKystLS0tDQo+IMKgMSBmaWxlIGNoYW5nZWQsIDcgaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlv
bnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS90YXJnZXQvcmlzY3YvdGNnL2Nzci5jIGIvdGFyZ2V0
L3Jpc2N2L3RjZy9jc3IuYw0KPiBpbmRleCAzNmYyMDA0YmM1Ni4uYzA4MjlhYWIwNDMgMTAwNjQ0
DQo+IC0tLSBhL3RhcmdldC9yaXNjdi90Y2cvY3NyLmMNCj4gKysrIGIvdGFyZ2V0L3Jpc2N2L3Rj
Zy9jc3IuYw0KPiBAQCAtMTExLDYgKzExMSwxMyBAQCBzdGF0aWMgUklTQ1ZFeGNlcHRpb24gdnMo
Q1BVUklTQ1ZTdGF0ZSAqZW52LCBpbnQNCj4gY3Nybm8pDQo+IMKgDQo+IMKgc3RhdGljIFJJU0NW
RXhjZXB0aW9uIGN0cihDUFVSSVNDVlN0YXRlICplbnYsIGludCBjc3JubykNCj4gwqB7DQo+ICvC
oMKgwqAgaWYgKChjc3JubyA+PSBDU1JfQ1lDTEUgJiYgY3Nybm8gPD0gQ1NSX0lOU1RSRVQpIHx8
DQo+ICvCoMKgwqDCoMKgwqDCoCAoY3Nybm8gPj0gQ1NSX0NZQ0xFSCAmJiBjc3JubyA8PSBDU1Jf
SU5TVFJFVEgpKSB7DQo+ICvCoMKgwqDCoMKgwqDCoCBpZiAoIXJpc2N2X2NwdV9jZmcoZW52KS0+
ZXh0X3ppY250cikgew0KPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZXR1cm4gUklTQ1ZfRVhD
UF9JTExFR0FMX0lOU1Q7DQo+ICvCoMKgwqDCoMKgwqDCoCB9DQo+ICvCoMKgwqAgfQ0KPiArDQo+
IMKgI2lmICFkZWZpbmVkKENPTkZJR19VU0VSX09OTFkpDQo+IMKgwqDCoMKgIFJJU0NWQ1BVICpj
cHUgPSBlbnZfYXJjaGNwdShlbnYpOw0KPiDCoMKgwqDCoCBpbnQgY3RyX2luZGV4Ow0KPiBAQCAt
MTI3LDEwICsxMzQsNiBAQCBzdGF0aWMgUklTQ1ZFeGNlcHRpb24gY3RyKENQVVJJU0NWU3RhdGUg
KmVudiwNCj4gaW50IGNzcm5vKQ0KPiDCoA0KPiDCoMKgwqDCoCBpZiAoKGNzcm5vID49IENTUl9D
WUNMRSAmJiBjc3JubyA8PSBDU1JfSU5TVFJFVCkgfHwNCj4gwqDCoMKgwqDCoMKgwqDCoCAoY3Ny
bm8gPj0gQ1NSX0NZQ0xFSCAmJiBjc3JubyA8PSBDU1JfSU5TVFJFVEgpKSB7DQo+IC3CoMKgwqDC
oMKgwqDCoCBpZiAoIXJpc2N2X2NwdV9jZmcoZW52KS0+ZXh0X3ppY250cikgew0KPiAtwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCByZXR1cm4gUklTQ1ZfRVhDUF9JTExFR0FMX0lOU1Q7DQo+IC3CoMKg
wqDCoMKgwqDCoCB9DQo+IC0NCj4gwqDCoMKgwqDCoMKgwqDCoCBnb3RvIHNraXBfZXh0X3BtdV9j
aGVjazsNCj4gwqDCoMKgwqAgfQ0KPiDCoA0KPiAtLSANCj4gMi40My4wDQo=

