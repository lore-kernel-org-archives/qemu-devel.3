Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E4C5C5DF81
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 04:09:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyiTE-00018j-Es; Tue, 25 Aug 2026 00:09:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=690dc056c=Alistair.Francis@wdc.com>)
 id 1wyiTB-000187-L0; Tue, 25 Aug 2026 00:09:05 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=690dc056c=Alistair.Francis@wdc.com>)
 id 1wyiST-0008Mo-Q4; Tue, 25 Aug 2026 00:09:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1787630901; x=1819166901;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=7u1NSP8Le36V0WEtRF4eFLtCevaMOtINi9RFQBnR0us=;
 b=oHqnmFujJhQSF56DoY+gLcazWylb74ATLwfctgTRAyE4q1j+Sl1sfooN
 VJSFrWw4gOM1sz9g/mo0sbV3BiWt264QQbLx+82SGkBNzJQ/wtxxUL4PE
 FQwny7OOUCApkuMZM9mtKGNABMIXrhSLWZn2lSy2novabpkDgAVzPQ6rS
 iarNowHCG/D4pvEyOf1kT4N9NuF05dALNlDvRoN1/vht4RNJJvRQQA0Sz
 AeUtrqn985F+MpeFt1Q4nI6xJJP20gsQC61ENQFsToRxjgw2lp8fdv/hf
 WC3883UqT5ucsVApWTVrGsYFNHdpL4wPIlze13RvYab/T0Mpuqy+aiWP5 g==;
X-CSE-ConnectionGUID: Ko5daIG7Ruql5TTxWRvmVA==
X-CSE-MsgGUID: lgBGooxjTS6YQewwFbNrxg==
X-IronPort-AV: E=Sophos;i="6.25,242,1779120000"; d="scan'208";a="153243348"
Received: from mail-eastusazon11012029.outbound.protection.outlook.com (HELO
 BL0PR03CU003.outbound.protection.outlook.com) ([52.101.53.29])
 by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 25 Aug 2026 12:08:17 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mhyBV1Df+YB3+JfwHvz/inzQ8eQ8skpH2VxTIA4ffuy4NRpAE0F4saC77KXBm5nyQckeN3kn5F9jAhbYPwcc3qXjHX2FGhmw527Yu7/8/n7O/sUEt/VmScO06TKcLLRGbKHXMwDvNZwYZNOYSaVYBgwGpbRZFzIWQudmIOQ0DkL2EFgKkWekRA59Gnq/GldAKMkkf9T4E6pY1vOYkmC5yrS8ZZ4K+3jhSzjn03OM6R5equfoYPgxbgv6JIuqsPsQaTUu9zDPAhMRvlpO5Rmj5E7mXCwvC8s7s7D8VSHTxN0kz8MlokJMZZDiAcvw6zk1ZQCIlhhQYKZyOQziZOWVvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7u1NSP8Le36V0WEtRF4eFLtCevaMOtINi9RFQBnR0us=;
 b=ClCI3+Re/RicjBZ5Xg4PhaU7tRMy3GesB0J3jPNo05391ZWBNQEKE1WplX1J7/T4iYwyBqXSVNNl+/wowx24RBxjGPYV2ztMoMt4NXIIPp5gX3+Y1CItSPF08sQ7WshwCB/RCsg2ACpm7vjj/9lbQ7g/RAt9DedQmY0NOME2WUeqVN7voQTTu9JIfuRMoReytgb7idf1/hxqXHPP3FKM4pBASG8ZD33yhUn0kxdqbUMcWAXqBfuA32iVhJhGxdAZd2tXkkXguL05h+3u+pRIaCH0l8ZOA0n1qXsSUFllnBmO3FtJJFlVvp8fbFEgOFAlXtz+XBuHD/jhCaFaAS661w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7u1NSP8Le36V0WEtRF4eFLtCevaMOtINi9RFQBnR0us=;
 b=KbA7DMogBvlAU1zAEIJ2ieEbvp4YGRmL1CwpJ1lQYEjJiukAXXJ4AsXUi4gocY4XTaJ4tzDd2/FdEjIXf9i2WoBeWn80UNYqAxhbudKrT8E3b2KT6fwmGuDG56tDYdVyV25VzA37h3LMsaKHOrzAcSmZo2W7O5drc7KTwsSZbKc=
Received: from BY1PR04MB9561.namprd04.prod.outlook.com (2603:10b6:a03:5b6::11)
 by LV0PR04MB9859.namprd04.prod.outlook.com (2603:10b6:408:32a::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Tue, 25 Aug
 2026 04:08:16 +0000
Received: from BY1PR04MB9561.namprd04.prod.outlook.com
 ([fe80::3869:e494:2fa8:9888]) by BY1PR04MB9561.namprd04.prod.outlook.com
 ([fe80::3869:e494:2fa8:9888%5]) with mapi id 15.21.0360.005; Tue, 25 Aug 2026
 04:08:15 +0000
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
Subject: Re: [PATCH 4/4] hw/riscv/atlantis: Document QEMU-only I2C device tree
 nodes
Thread-Topic: [PATCH 4/4] hw/riscv/atlantis: Document QEMU-only I2C device
 tree nodes
Thread-Index: AQHdM41zBg0RFY19Uk+uAZhyLWhDQbauJ5gA
Date: Tue, 25 Aug 2026 04:08:15 +0000
Message-ID: <bfe9adaeb3b7d22ce4b51319db483120f146d6a3.camel@wdc.com>
References: <20260824055642.41098-1-joel@jms.id.au>
 <20260824055642.41098-5-joel@jms.id.au>
In-Reply-To: <20260824055642.41098-5-joel@jms.id.au>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.60.2 (by Flathub.org) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY1PR04MB9561:EE_|LV0PR04MB9859:EE_
x-ms-office365-filtering-correlation-id: 103f9d0a-f385-42c7-3101-08df025e7d1e
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|19092799006|376014|10070799003|7416014|23010399003|4143699003|22082099003|18002099003|11063799006|56012099006|38070700021|10067099003;
x-microsoft-antispam-message-info: i8L0ulLWPXCrO3rgEuBrxGIh421DscSt9yWIonalOWH5ne2bdTnb5501bo2KhESDDLyq9N7YKa6EKANQTuwiyhAl3zmHpmHMUxZfCz/qJCO1SgZOA38HQs7GfYUVmjxz0lQJVCWaOSpUZUf6s+usFsh89X45i0Bh2O0NBrXbZ/fu2qf5LbfX9vvpGPds6J7ziPcgiBXo3HAYG03/rXjBnefEK+uq6haNTLZyBbuu5tx6rY7hIEWh4tEt6rf3I/s+K2RkMPwwc65BlGxe5ARKur6NgLSyEQ4VGKBI74Zu1IUkjnKqId7iAK8oGHv5e+qgct3djsxM3R0qmQcwS2Uwxfi6kEUcSoRVcjzQKkdWbSHz75IvCkd1RnqMDFJ5mz9E8abCAlCXnX6diP/9erdPW3uUvm3jQFp3/bdjIkZepLUPD0tx/aBz2g1F5w1zEfgHVibtMk/1S/ZuFy15sfHErlmS5WRN8ZTqFjeaflEDF/fQb47wzXEOz7vJwaHJNjtmdSORLhyfyrxtIFAtc9veHggnEoUONzj5r+LJpJHxL4r49lpuvrSuV9GqX78KAGwY+fBomsNgc4TWNF3qGVB21amorQNeNNhSVqVeTG+lYWwgym3VPyiWrOfbB8zqOZtMSyba3VTwPfKgNeWYA8JPd8wEI5j8jpI0tFTe2iHcjtyoM778wFwlWtLLUY+cI+SxwU9JXKlJ5oZGtbAjT6nOmoZkBgKQ3DEvEm6Ai2Emsi4=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY1PR04MB9561.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(19092799006)(376014)(10070799003)(7416014)(23010399003)(4143699003)(22082099003)(18002099003)(11063799006)(56012099006)(38070700021)(10067099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NWhEM1RNUlVMTWR6S05RMHlpY3ZtTnpDeGkyVyt1WHZGK0Jmc0ZCRFJtQkJO?=
 =?utf-8?B?akwwaEw2c0l0RGpBYTVWK1BDaGdyQ3gwQS9MZ2I0K21WYlJsOStBUmtNSHVy?=
 =?utf-8?B?dlJaTFFtWjVZKzFHWVhSWVVabElJcHlBTWVVOFN2aDhtL2Vya1grYjVJNnVq?=
 =?utf-8?B?QnVUOVJSM3NhTFdaOXRaT20zMGZXeG95Vi9WRHhFcTI3eHdUelgvdzRKa1VC?=
 =?utf-8?B?RmIwSFQ3TFpSbFllZGE4ekkzMXB6WGJBck5pajlRWllJZ1VhQjBDU2dHUzBq?=
 =?utf-8?B?ZmFZRmpBcmhTRXpienZCZm5qWW9PTm9BSUZXK0NCbDZjb3ZNUzAvTUJKNjcx?=
 =?utf-8?B?cGllY29CR1BvSCt1SG1WcTV3MktINXZMYzZHRUxEK1Z2aXp5cEcvOEEvZXVG?=
 =?utf-8?B?ZUhQRWxkVVhsMkhzVCtrVUVmbWR3K29oR1BnaWxyYmRQK0NiWnU3SG9wQ0Iz?=
 =?utf-8?B?VVV3ekNUSnZqVDdaODJhS0s2ZElham1UYWxwNjZjd3grWkxkakZlQUtNcmZN?=
 =?utf-8?B?MUFLZnp5R0NOWTgxdGRGRzU2WUt5YVNFM0V5bDdNYkZGTDVMZkl0TW8vdFh3?=
 =?utf-8?B?NFV3ZmFrdWN0V284YzMxWFhtS1hJSWpIbk54ZVBoQzRzQXM3Y3JST1Mwa2dO?=
 =?utf-8?B?YzdjL3o3S0ZkZ0h2QnpDMXFZbXNaNzdiVXlxUFVVRktsSDRDRytXRnZtd1Rs?=
 =?utf-8?B?NytQc0JSbUVXRGR3aC9rRDhmMy9EWUtTL2ZWY3hIKzgramRLcnlPQUt2VEFP?=
 =?utf-8?B?NHcya3ZBY1dtRm8yRmkxRzFLVEVXSmU2YW9KRGZRcGh4RnUvd2RsUk9JR3RD?=
 =?utf-8?B?OTN0SXk2ZEp6T1pwUzlPSlJ0dkE2MDFablA3ZVdDV2l6L0tINDYxQ1BnMVhG?=
 =?utf-8?B?bkI1NFd3bFFBWU9WZXdzRVFTR0c4NEdTSnpBdTNiL3lOb3I2SDgxd2l4Ty9Q?=
 =?utf-8?B?V0RmM0ZwMjY4MFBuY0k2aGRMbWhyTGFWcGZVd2dOVG5Qbk1ubm5mK2c1NHR1?=
 =?utf-8?B?RWtOTXNna2M0bHYzcTFKb1RSN3QzRWZEc29sQWp5MFpNSFduOTQzcUJOSytx?=
 =?utf-8?B?VFRSVWVYWC9walcxRkJpR29WYXlXNlRWR3QyanpzaFNtMTN3cHEyejNMcXV2?=
 =?utf-8?B?MEZ6ZWJPU1dQd0Q4dmxQb3dzZXoxb1I3WlZrdlFGRTViUWNQcGgweFlrM0c2?=
 =?utf-8?B?Ylcyallvck5saE01TW9kWmpjU0Z5SndZTjZxMkJxZXB1OWVZWVpFSjE3QUlS?=
 =?utf-8?B?djlrTWJBNUtRdkNYbFZ6c1FwWGUwaDA5OGVFdjgzcDJNWXBjVHNFVTdUTUYz?=
 =?utf-8?B?YWtHaWhjZEo2UjFOR3NpcWQxaEZIU3RxM0pZWW5hRFpNRWd4QVJIb3pqQTdI?=
 =?utf-8?B?MFlnTXIzeXhhaVVYUjhSTHRaaHNsVjRwZXR5OHkwWVJ1bXRna01XQ2h1WUNF?=
 =?utf-8?B?U05kVnlXOFVpQUNIaTFDcDlzVEpmelhMdEJ6eGJZYlFueDUrNDZac3g5aVNX?=
 =?utf-8?B?YzJHZkpQdkhYYitUNThMVkE2UGMvRHBDL2RDdDRnMTI0cVNDMTZEOHdka0FN?=
 =?utf-8?B?YjA1cjN3a0taKzNrYlVHUVVxdmh5ekxiUmpFVDlMcGIyYzA1TkQ3YW9CdEpZ?=
 =?utf-8?B?Umdaazh3aVNDRyswbU5md0NuM05DM3R2T3UwMnY0ajdqQ2MzT0t2T2hhRFBm?=
 =?utf-8?B?bk0vUHduTFpmekJrOUVqcXROdWFzcW9vdnBOT2ZWQ0Zuclk1Q2w5Y0lLWHM5?=
 =?utf-8?B?bm9wZ0hhNDhZbGxXNUdRNFFaQ0xYU0FsSmJrbzM0ZFVxd3M1NzNaeDJFRE43?=
 =?utf-8?B?Q045OFVGaG1WQy9Ka0t6UGsvc3I3VFNvNlg4MEVYMWhmRGkvRERhQTNjcUlG?=
 =?utf-8?B?L1lnWE1VS0xQUFZCVEl5d0drZGFsMTFwL0xRNkRlMkJ5TkI4L0FtTEp3dTUw?=
 =?utf-8?B?QzU2bkM1cXFPWE1UYXdZY2hLRUtEUjZTSXBJdUsvWXFuUmQrOTgyUkpWRnNz?=
 =?utf-8?B?aWQwTEJkbzU2Q3haL0cvQzZFUXI0VjFSVER6UlRzc3JqcUNVaWtsYW1RMHY2?=
 =?utf-8?B?QUQzek9wN2FFZmRRL0RqRkJKQW9uRFhtRE5RTXN6bGY5N1Q5ZjFrdUdweXh1?=
 =?utf-8?B?L0VMK2grRm5xTkswNE5XaHpZUHVnTXFkUkJNTS96WnF0dmdsWUhvYzdWL1Z4?=
 =?utf-8?B?enBYRjJ1VWhTVWthd0tscjdZSnBDVlprbTVSV09idHEwZUs5WllndXJtSGx6?=
 =?utf-8?B?R1VuS0dwS2p6SnYydUhBcUlpM0FIREVzVExPT25oOTgrUzYzcXhpd0VtdkJB?=
 =?utf-8?B?Y3phbnZ2bEs1STNGdmRoVUlCVDBINHBwNVNISTNoTnhtdmh1cnA4L2d3ZFZy?=
 =?utf-8?Q?+Dty2A9elf3Ot3E+yxl07FxRkjYi2Brv5txbptBRn4JUF?=
x-ms-exchange-antispam-messagedata-1: xAzPOfmbFHdiH4F/nVxnB3BFUchg6uL91Ls=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7536948968AB8D4DB86EB6E98D22279C@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: rRZt+XjcalNnNh5FfLvMSiVkMbA5jiV77DapnxxyvPDquyt8KuXF0eEOqul1N1hhIFfHUXJqWliFglk+8CAugkb/cVI0dkCn4iHs1FvVXeu5JRPqd1ORCkPifN9OEke33sCDHUgDCw8rn0wbQVfCELGzvzvHvFMKuVu2bGMWN2qKGzTgWjkAkD9vMg5R7+V3M51VmfWksvbmD2nS3nI6GrE2AHoH4WGeQMaEaPNpPJJd2qIxbK5g4e4Fc1STIsjTs2rCB3pS4jdA+yy8ndBSeLwt762e7EPh4JFGLxo8srxIsjlQt+4VHKKzhKQb9Nml3GS0pH2qITtHM00kNe5Zeg==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: reUpKJ1UmrUjG0LmlVa0mRhbEueaoo/o/VLLixyjSFk20tnoQdTO6UIqLJ3Fv2FO8lJKn68M6jSYCIGJhmh2bmpcLdSewkPJk4PLRbS83SLODOo83fLUtrQcTng7WMgFmTWeFbOzGw8VKVoSF5hZHkd78irz5YZQcf8jt5GTfG0fYFXnnjabJFd8TfSnEKqmF2q4OH+aVz/JD6z3BtFk0HRDtBpZM14HuaXJlIo9dn5Gh+aaSHd1nRSbl3lGjUEg8NXdk/RtIjYOXwHb6otPvjMriMDyiwUvmf7RsjKE95EWpGYhdwzqNKbNRsn5i9P3x1WRJRCAYEvNlYB0ZbCK5ZEhx3a5xkTySyUzhM8XIsyPZvcReyCPlCjhjtKvjF7phB7ePJ5H2qncXpfDgwpA9DlrPyC/wAjO1bKR7DtoFzTEGGqX99PbXzPriGfRrxpehRLkPrFMg3E9R+uHPKa9myl6gi/CVSVQn0dS/z4ycoXpDCljlD115DfsD8155GW55dFOm/sEPusN9iYpIePhNeQsp+/85j0uWa9Of6OlR+WN86/VxjB9sVi2VTE/ZCcAzN86TRdhV4yQe2PZEQFOIhxjuU3GVipZF0V86h3Lp0Qkqa5W7aKkLEuZFRk09TZ4
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY1PR04MB9561.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 103f9d0a-f385-42c7-3101-08df025e7d1e
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Aug 2026 04:08:15.9083 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MBtP/ODW3KxmN/0/po4euu2Cncsyv+Q3NEZHul5omsVNu+0IgJ8o9Yl2IGu1siKWAWPSOZ8gxQCjUP65HGk8xmXGP67lVX+NVRFNYusHlFs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV0PR04MB9859
Received-SPF: pass client-ip=216.71.153.144;
 envelope-from=prvs=690dc056c=Alistair.Francis@wdc.com;
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

T24gTW9uLCAyMDI2LTA4LTI0IGF0IDE1OjI2ICswOTMwLCBKb2VsIFN0YW5sZXkgd3JvdGU6DQo+
IFRoZSBRRU1VIG9ubHkgSTJDIGRldmljZXMgaGF2ZSBhIGNvbW1lbnQgbmV4dCB0byB0aGVtLCBk
byB0aGUgc2FtZQ0KPiBmb3INCj4gdGhlIGNvcnJlc3BvbmRpbmcgZGV2aWNlIHRyZWUgZW50cmll
cy4NCj4gDQo+IFN1Z2dlc3RlZC1ieTogUGhpbGlwcGUgTWF0aGlldS1EYXVkw6kgPHBoaWxtZEBs
aW5hcm8ub3JnPg0KPiBTaWduZWQtb2ZmLWJ5OiBKb2VsIFN0YW5sZXkgPGpvZWxAam1zLmlkLmF1
Pg0KDQpSZXZpZXdlZC1ieTogQWxpc3RhaXIgRnJhbmNpcyA8YWxpc3RhaXIuZnJhbmNpc0B3ZGMu
Y29tPg0KDQpBbGlzdGFpcg0KDQo+IC0tLQ0KPiDCoGh3L3Jpc2N2L3R0X2F0bGFudGlzLmMgfCAx
ICsNCj4gwqAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKykNCj4gDQo+IGRpZmYgLS1naXQg
YS9ody9yaXNjdi90dF9hdGxhbnRpcy5jIGIvaHcvcmlzY3YvdHRfYXRsYW50aXMuYw0KPiBpbmRl
eCBkODA4YmNjMTFjMzQuLjgyZjA4N2M4MzZkYSAxMDA2NDQNCj4gLS0tIGEvaHcvcmlzY3YvdHRf
YXRsYW50aXMuYw0KPiArKysgYi9ody9yaXNjdi90dF9hdGxhbnRpcy5jDQo+IEBAIC0zNTYsNiAr
MzU2LDcgQEAgc3RhdGljIHZvaWQgZmluYWxpemVfZmR0KFRUQXRsYW50aXNTdGF0ZSAqcykNCj4g
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBhcGxpY19zX3Bo
YW5kbGUsIHBlcmlwaF9jbGtfcGhhbmRsZSk7DQo+IMKgwqDCoMKgIH0NCj4gwqANCj4gK8KgwqDC
oCAvKiBJMkMgcGVyaXBoZXJhbHM6IHFlbXUgc3BlY2lmaWMgKi8NCj4gwqDCoMKgwqAgY3JlYXRl
X2ZkdF9pMmNfZGV2aWNlKHMsIDAsICJkYWxsYXMsZHMxMzM4IiwgMHg2Zik7DQo+IMKgwqDCoMKg
IGNyZWF0ZV9mZHRfaTJjX2RldmljZShzLCA0LCAidGksdG1wMTA1IiwgMHg0OCk7DQo+IMKgfQ0K

