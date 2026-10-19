Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98890CCF2D8
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2026 02:11:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIcqE-0001Lj-1j; Sun, 18 Oct 2026 22:11:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=7454c2a62=Alistair.Francis@wdc.com>)
 id 1xIcq2-0001IO-Lf; Sun, 18 Oct 2026 22:11:02 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=7454c2a62=Alistair.Francis@wdc.com>)
 id 1xIcq0-0000St-DF; Sun, 18 Oct 2026 22:10:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1792375856; x=1823911856;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=nb6RxS0zhSAcLfTAIcPjf0oC1NFtbIcSoJR0YxHe+kU=;
 b=jvKV1cn48JK8urWciDjcBJWqZJU0LcC1IYh6ynXi9nDkU93TTReqyDj1
 OP6YI1j1QhYMuJqX8ahLDbHp01oerB+zC0p1VNEkCSyWSYOQDHrIMIq+T
 dOpLcrXFJwKtZ0WJon7v4Jnyt3WSldJSlRDk51Aiq2uD5qgUjQELe+j3M
 YWMOWWTVqp2eJsQ5ECKnJeCtMhbNZDQgW1Di3jaS+sIUbmFpJZ0MTX69X
 VaYUxFvGH8/aPvseYD3ec7ieyNPkV8ADvvKPE0PhBb4DGPiGR52lUqu7b
 ajzzdbthgoFnb+RUjH7xkLiHKbd6IVY3UngL6e5TMlFcb0zs+x3uC62dW A==;
X-CSE-ConnectionGUID: lUg81LMZSgCcMvbwCClZZA==
X-CSE-MsgGUID: 3Qz/iPIvTACXzhnXLi8z2A==
X-IronPort-AV: E=Sophos;i="6.27,166,1786982400"; d="scan'208";a="154187743"
Received: from mail-northcentralusazon11013045.outbound.protection.outlook.com
 (HELO CH4PR04CU002.outbound.protection.outlook.com) ([40.107.201.45])
 by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 19 Oct 2026 10:10:47 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=soY8G95U/QkRHNSBqNtkZKyNg+22Th+ek/4k+hf58NjokTzaSb/wvT+yl0yRdbTyUVjICEl/ZdhiYvj0dRfDbihrEyxMGLU2o1IUB9ocBguObBJTL1ueBwKpTScDE2jrDD1phPPlMQZQP2L+gGVKQ58LRLUyx6IUaxlRpnICPFI9j1WINFEWFHIfv/4RJ6vjIgIKgE8eaHZ0jJ8w/vipACWqNTKhjOZC2mxBloms4oywZDLpIlC83nw57Bj5Dliu8lcgrX3Gl4rcbn1NSzzjjyK/pbxXD/2cv0xW3zUR5QGJowUPJw7Ir/hjw7NItHg3vn4cBIecY9PGRMjOD0fD5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nb6RxS0zhSAcLfTAIcPjf0oC1NFtbIcSoJR0YxHe+kU=;
 b=IO52DEEezFqjrTN5gEi/SZY+FQuUpyS/vcbc3PmBf7mOQ6PUTBz4K+46p4MLmAQ6LMGsdmPugbvNJDAhnXOgoJnr9kyQ/ZeBKTZgXEHtr+Rs6mrd0lxhlQNlj0xYvfWgq4gAVMbxFtVFnzY/B0fyIxaWkyVwn4fRCG1yWUWahtfyxpJwnt4AplHYp0A8sVvpN2uPChZSRdtS69Y/W7Yt6b0pJaDmD0BcDBEjCfI6tVjwzozcIj25QTTpUrlVtPs0HkKKhoGUb9kK5HTO8Z7cPYhdtx7jCy6MQSim00YSEWqwWCTg50eLWJOcw1LrxnNt6na8g0VV+zaPJL9+eUxpqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nb6RxS0zhSAcLfTAIcPjf0oC1NFtbIcSoJR0YxHe+kU=;
 b=gPQEh2T/vWKsUtQ279AaiIgb2PvcGPLLNNjlSA51AORe9r24f2xmUoTt+5fLR0LhCdyBzSmtuDFjqMu/1cTSsRHq1p+r+N+veooQxaPggOocSmv7n/HxfW+/IGtOCodorDWesORmH9d9ucsoF63s8ci/ddR9sPfFywM4jS29nXw=
Received: from MN6PR04MB9359.namprd04.prod.outlook.com (2603:10b6:208:4f2::13)
 by DS2PR04MB993992.namprd04.prod.outlook.com (2603:10b6:8:338::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Mon, 19 Oct
 2026 02:10:45 +0000
Received: from MN6PR04MB9359.namprd04.prod.outlook.com
 ([fe80::e729:bbef:5a37:2e77]) by MN6PR04MB9359.namprd04.prod.outlook.com
 ([fe80::e729:bbef:5a37:2e77%4]) with mapi id 15.21.0522.017; Mon, 19 Oct 2026
 02:10:45 +0000
From: Alistair Francis <Alistair.Francis@wdc.com>
To: "hushunchao@bosc.ac.cn" <hushunchao@bosc.ac.cn>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "wutianze@ict.ac.cn" <wutianze@ict.ac.cn>, "palmer@dabbelt.com"
 <palmer@dabbelt.com>, "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>,
 "daniel.barboza@oss.qualcomm.com" <daniel.barboza@oss.qualcomm.com>,
 "chao.liu@processmission.com" <chao.liu@processmission.com>,
 "liwei1518@gmail.com" <liwei1518@gmail.com>, "zhiwei_liu@linux.alibaba.com"
 <zhiwei_liu@linux.alibaba.com>
Subject: Re: [PATCH v2] target/riscv: add hgatp-specific WARL legalization
Thread-Topic: [PATCH v2] target/riscv: add hgatp-specific WARL legalization
Thread-Index: AQHdTPc7X6lEbkfz1EO+RaWUOqZyGbcERCiA
Date: Mon, 19 Oct 2026 02:10:45 +0000
Message-ID: <40944b4df97f9aa6738e1560c8c33a414e462096.camel@wdc.com>
References: <20260925-riscv-hgatp-warl-v2-1-2aa9aa7718cd@bosc.ac.cn>
In-Reply-To: <20260925-riscv-hgatp-warl-v2-1-2aa9aa7718cd@bosc.ac.cn>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.62.0 (by Flathub.org) 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN6PR04MB9359:EE_|DS2PR04MB993992:EE_
x-ms-office365-filtering-correlation-id: bd0af417-6c61-499a-07a7-08df2d862f4c
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|10070799003|1800799024|376014|23010399003|19092799006|38070700021|56012099006|11063799006|261009223027099003|10067099003|18002099003|22082099003;
x-microsoft-antispam-message-info: c2dyYiAvPgvB2AKwfVC9YDMu9Df99JIZWzME3qLc1tmN3VHYePIuR3Z2rjAvBvcFCBxCGU7vdUzLErcezvmv+C5FClCV+6p3gDsYhieeFOU7wYRllWFmlYXGoU5dYkw9xW2MXBRh7GuwPspfbGETfw32kqu3qUmM8Q2B2wb9nzzyUhXi8d54zADHpjWuzyHOsKA5h5IZ8C2YBMQOZW+VNKKCKleyFVL9oL0T2jax6eUGS82I2irGbDw9Fr0PXnr2JGIBNCmdQoI/zpSz7jo40Qx3oNcwVcIQy+TJKNa24jn/CJE3oEiz9wmyf4JIe7PUMtuZL5RfhuMu2PIJruqxYButKaeG3DLNmpiBl2doVUDhZcpp+0LBfLpxnh2KWYvT10HOVwHoGwITEjlNVCf55zv3slBXOms1pJuw2jOCmyrWiKT64VitnF8qURmU0OmQmGeJa1n3MG5h76T2ktzqx7DgqofhfcP+CK7hBjH0gFrrjLBxb/M9q+YtoGqUG9RK1boknczyBiE7XSfJ4EItlTT4xFJFJ/evz/t9dW6nNtMP2GZGBVvqmKLw+pR1KSvZf4kdvyX9lFlF/pRWdz9nexcR4HvO1PSF9nFpkbatpYb6wovJFjBlf8Hf67Irlu1KZ6W1VsP+G7u1suuh2+rQV7GoB2j92w7pcRiyWfijtyc=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN6PR04MB9359.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(10070799003)(1800799024)(376014)(23010399003)(19092799006)(38070700021)(56012099006)(11063799006)(261009223027099003)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RkRPdERPQVpRNmZtUWx1U1paOXBmcmxVR1JjcjFqMXlGdkFMQ1QvN3hFYzJw?=
 =?utf-8?B?dk9IMk5ZYmcxenVDVFgrSFFTbXNwTlo3Ti8rMi9jNzJuK0hVZnpvNk9nUUJ1?=
 =?utf-8?B?OTUraXNwTVpnRHIzMG5oVTlIT3ZXdktxWlAvQVpJSjQ4TExiWjBXcENmY1FQ?=
 =?utf-8?B?U1RrakhQYk5iM0NHdTJKUVpKRmdoNTY3KzQvRDByd0dkai9xTjJRR3Y5OXFj?=
 =?utf-8?B?TXFxdU5kUmtHaHhDb3dveHE5aXNxY1hmQ0ViOHlVWVZPa3VLd1g5NDRpUHhK?=
 =?utf-8?B?TFh4bGVyelR2eC9lSk5hM1M4VndaU3QrdVVJTHpFNEpCL2NXZmtUZlZIbjla?=
 =?utf-8?B?QnpmUGxRRHFIKzh3bGJYYzl1ZTJxTlh0S1pkQVNPenUwZUxnQ2pZcldNa0h2?=
 =?utf-8?B?TitZNGtHUHRJNUY0bzhxTDYzZHU2eXVxZFg2WTRSdFNQL05jOHc4R1RlYStz?=
 =?utf-8?B?ZXhjbk5wUUphQWtYcXpOSzlnaFduc3p3UzBFS3h5ZXoxUjBhS1lvNDhoU2k0?=
 =?utf-8?B?eHNWSHY2YzNjQllEdHNtSmM5UnJLNnlYSWg3OWxzTXNpTTRvK1pkODJuRHdM?=
 =?utf-8?B?ZUtZSGhIbm50U3N2VWRicGhwWFdsbWowWnlwZE5CS0MwYmxSYytzcjk3a0dn?=
 =?utf-8?B?aWNCVGd2dXAyS1lCOG1menRvaDJuRFdyUHdyaktEZTdpeEN1bEorck1Vd2s4?=
 =?utf-8?B?K0RLNnJhN3RuMkIzYVFGM051RTRRM294aVJsSTJrRUxqNlc4ZzkvZlovb2lh?=
 =?utf-8?B?L0FuOVV4UUk5eXI2NnFVc2syczBGTkhyL0lOaGYvc0VNUTFldXBZZm5waTkv?=
 =?utf-8?B?UnVRektKU1hzNWRCK2Ewc3BHaU9qU2RCSEFSVElZYUlhN1c5dUNCQlVmdFRT?=
 =?utf-8?B?UHk1T2VTMFRCNWxoVnBOa1puZGZpZHpJRWtPc1QybXRSdTlqeGxGZUFHREZo?=
 =?utf-8?B?WnRGUjZyZHlNQmlHek9EQktJdU1NelE5VzZlZTl2bC9lcFJjT0ZiSzNEQVJs?=
 =?utf-8?B?bFdPLzhXTlB4b2Z0aHdaVnhsV2dvWXE0OFRtbDZQb2d6TmdGOUNaVURWSWJQ?=
 =?utf-8?B?T0dROHVOMWxlMFNicmNVNlVjWWcwc255ZURwVUNvd0FIenEyamlzUlVUNWdv?=
 =?utf-8?B?YzdqMFZOYURJUG5VeVJPNlk0TFJIUHorOVhYL3A2YzJKd1pDN3NBT05pR3Mz?=
 =?utf-8?B?ald6QW41ei9WWVIvK0Frbk9xaDBMcDJla0krSnRHY2JJVFUzR2J6WWZTaXYv?=
 =?utf-8?B?OEVYV3VwVUJ3Uy9EdS9yeTRIVFRwZzJ3TTFsbFcvbk5IVWl5ZTlhbXZYNWVw?=
 =?utf-8?B?bU1XNFpRNGxlbTdiUnRpNUM0OEYwNysyZksxYUZWRGdaUU5waGFwRVRVUFM3?=
 =?utf-8?B?YXZ0SFNwc0hUZ1B4eGJkK0JUM1NrRlVtekRVdG4zdURHYVk2R25MZkxudmNC?=
 =?utf-8?B?NmhuaUNHRjByS1daZnB1VE80Z2JjTzNtaFpLcVJiWDRTckQ4MGc1bTk5aEVC?=
 =?utf-8?B?M2JPQllYY0J6a0EwZnRRbURULzB4VnRodTB5Mm1TYVNwQmJvaldxZDkyeUtP?=
 =?utf-8?B?RkpLNWVsSGUyaVdEMi95YTR5S2d5cXBkQjMvYmZ2RjFuMHVDQmdHa1VmRXZS?=
 =?utf-8?B?QUJUTXA5N1Q5MVZHZnU0VzFnOWRMSGwwdDk5YWo3dWVpMUtGMUZCUE9KK1Bm?=
 =?utf-8?B?RUF5Y3JGQUVoc2h6TnVCZVVQdmhJRXY4L1FoZi82TmROTDRLVGx1NENZSHZ0?=
 =?utf-8?B?anpldi9nMDF5U2VMQmxjUXlZandwamdmZElhemV5M09XV3o2YW1ka1pXdzVE?=
 =?utf-8?B?a050N2xmdEpUSFI1bnlvakJnaGZ5bWVwK2lSTmhFN0p1NitmcUdONUo5THFV?=
 =?utf-8?B?aFhlaTNRWFZ3WTMvTE5YanNIMEcwOEJ2ZE5IbE1mR3BBODl1WFJldWJ5eDQ3?=
 =?utf-8?B?ditCTFlXTW05VTBIZk5ReTQrbWFGbmVOU3V1aVlzQWdQOTRiazJFdVZMTVhw?=
 =?utf-8?B?WGNPcmpOc1YzajRuVkV2SGNPeHZiTlRaSFBCcERBVkh1bEovMlREWVo1NXc3?=
 =?utf-8?B?YmtmRGJFSW9ZYThLUHYxdGFtUWVaWVJFemJQdXZoOG9mTGJmRG93NnJVenhM?=
 =?utf-8?B?dU9OYlVhOVRjdXRrMTNtSDNkcmtMRnhMeGdUSVduQm9HRzJGczVVTHQxM3A5?=
 =?utf-8?B?QzNjcjEyMldQMjdJZ3lvdlhyN3AxTmpnS0U2RU94L3BuNzZXajd0WEdHWjJi?=
 =?utf-8?B?Mytwdm42QjB0RFRBWFAxYVNleVZwMXJHemppK1NBdEhob3lwVDRxUG1Da1RF?=
 =?utf-8?B?OGZiMmhyaURNcmFGNnBCdzhsSCtjYXZCdWFFUTJZankrYnVaVmV3TG9lU1Rr?=
 =?utf-8?Q?Nf6PymJV4xw5XIdtq2ULawUWE+aipXz9c3EJIWasH2rRn?=
x-ms-exchange-antispam-messagedata-1: fAnsIqG5hE82pyRKDXg3hTYveYvwe2dBi48=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5E337FE2352A2441928F669241D4640D@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: uB1GysPmdBXKzWD4Z+1/9SejkL1o1k1tiOrMZaQsnzgZjGmbskv8vtb/ax+xOqxu/4HGrSN355pWGi7mWDOUQPIHqSuhCpkladlEddiJFXuvYC6WSNBNxofw1xjMd4n7v6QVG39F4W0Vdn8CmMNova2Hp2ds04UIrN1ckBJsXqblKQEXT2EHIoL+UInGSGYCPDuRwucAqODYxT73I9/pU0jPKJNjFttWxvX+fD/8pTaKVB0yoBBcTan4drtUSosVJrdV3nBykX0o5rkNMW9ofA+hULWYMLO0ganwKIde531y86SQibh2Wd7yNvzIIhNvm459MROWpib8NYe5XnUdIQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: vKyrSfr3W1W4boy11veYOMOKMRvpkhhT9KfTQGjtyRaOh2aNDpYreTq58O/9ZT+dfACUf4MgwraqWXnGXczgn2UOhsuDyKsmnE/DDiyGc1n5BIWMuBsMLiK8axYDiYfUiiJt8iqjGR1hwXembuuTH6YV00MI/JsQ4ujS6QKkQrFdFY1qDM0ghO9CQEAuP2zvysxAVoyGtVRG6jWRvQ5/5Pok/GoZoc7XyngS9QHpbSu70j9V2untstJJc9/k+EcXf/EjsevTJD8nrdXQp5WM0dw6ghdUbTx/yKIf95q0vENEmDu+QUonRJoJCpTea7mhELnWkWp3saoz1asiEUzc3ITXL/QGTdWnr8wgZQ4TRdgsRBAggfF5J3xl243nxnZnJSlVAzrnl69e7Gxu1ANZ9pr0/DKYRbUSLfw1pteMsLrY/CJSpmbjHVruIe5UWLY8/g5gFcnKqm8Qd9XZheD3629Ab6FZsMJIj+e7i8YPASbwI24s4EvAISvgD7wqu4n8+MxRnpJEBVG9T9+3e8XaL2r1ckO+mA1c/mPlgkcjyxEy5G8lwlSKzzfSvzXerwvWrv+AV4qPlGXQHImcBOrfeHpUetDSnaHbPnyYpAbN8dHcQ6zLU7+blGTPzmvfftDK
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN6PR04MB9359.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd0af417-6c61-499a-07a7-08df2d862f4c
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Oct 2026 02:10:45.1981 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qfZ5BuL8EIrxovOkG0WHJlHQeFe0wWSzdScW1SKQrN0/GWDC55QyfOOgRD27B27c8G6XzExm7ABiqeZnvkJdvcIrxosjB/Z1+HAA+44Z8CQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR04MB993992
Received-SPF: pass client-ip=216.71.154.42;
 envelope-from=prvs=7454c2a62=Alistair.Francis@wdc.com;
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

T24gRnJpLCAyMDI2LTA5LTI1IGF0IDIyOjA3ICswODAwLCBTaHVuY2hhbyBIdSB3cm90ZToNCj4g
QWNjb3JkaW5nIHRvIHRoZSBIeXBlcnZpc29yIEV4dGVuc2lvbiBpbiBSSVNDLVYgc3BlYzoNCj4g
LSBWTUlETUFYIGlzIDcgYml0cyBmb3IgUlYzMiBhbmQgMTQgYml0cyBmb3IgUlY2NA0KPiAtIHRo
ZSBmaWVsZHMgb2YgaGdhdHAgYXJlIFdBUkwgaW4gdGhlIG5vcm1hbCB3YXkNCj4gLSB0aGUgbG93
ZXN0IHR3byBiaXRzIG9mIHRoZSBwaHlzaWNhbCBwYWdlIG51bWJlcg0KPiDCoCAoUFBOKSBpbiBo
Z2F0cCBhbHdheXMgcmVhZCBhcyB6ZXJvcw0KPiANCj4gVGhlc2UgYmVoYXZpb3JzIGRpZmZlciBm
cm9tIHRob3NlIG9mIHRoZSBzYXRwIENTUiwNCj4gc28gaGdhdHAgY2Fubm90IHJldXNlIGxlZ2Fs
aXplX3hhdHAoKS4gQWRkIGEgZGVkaWNhdGVkDQo+IGxlZ2FsaXplX2hnYXRwKCkgaGVscGVyIHRv
IGltcGxlbWVudCB0aGUgaGdhdHAtc3BlY2lmaWMNCj4gV0FSTCBzZW1hbnRpY3MuDQo+IA0KPiBD
by1hdXRob3JlZC1ieTogVGlhbnplIFd1IDx3dXRpYW56ZUBpY3QuYWMuY24+DQo+IFNpZ25lZC1v
ZmYtYnk6IFRpYW56ZSBXdSA8d3V0aWFuemVAaWN0LmFjLmNuPg0KPiBTaWduZWQtb2ZmLWJ5OiBT
aHVuY2hhbyBIdSA8aHVzaHVuY2hhb0Bib3NjLmFjLmNuPg0KDQpUaGFua3MhDQoNCkFwcGxpZWQg
dG8gcmlzY3YtdG8tYXBwbHkubmV4dA0KDQpBbGlzdGFpcg0KDQo+IC0tLQ0KPiBDaGFuZ2VzIGlu
IHYyOg0KPiAtIFJld29yZCB0aGUgY29tbWVudCB0byBjbGFyaWZ5IHRoYXQgcmV0YWluaW5nIHRo
ZSBwcmV2aW91cyBNT0RFIGlzDQo+IMKgIFFFTVUncyBXQVJMIGxlZ2FsaXphdGlvbiBjaG9pY2Us
IG5vdCBhIHJlcXVpcmVtZW50IG9mIHRoZSBzcGVjLg0KPiAtIExpbmsgdG8gdjE6DQo+IGh0dHBz
Oi8vbG9yZS5rZXJuZWwub3JnL3FlbXUtZGV2ZWwvMjAyNjA5MjAtcmlzY3YtaGdhdHAtd2FybC12
MS0xLTJlNTJmNzhjODAyN0Bib3NjLmFjLmNuDQo+IA0KPiBUbzogcWVtdS1kZXZlbEBub25nbnUu
b3JnDQo+IENjOiBQYWxtZXIgRGFiYmVsdCA8cGFsbWVyQGRhYmJlbHQuY29tPg0KPiBDYzogQWxp
c3RhaXIgRnJhbmNpcyA8YWxpc3RhaXIuZnJhbmNpc0B3ZGMuY29tPg0KPiBDYzogV2Vpd2VpIExp
IDxsaXdlaTE1MThAZ21haWwuY29tPg0KPiBDYzogRGFuaWVsIEhlbnJpcXVlIEJhcmJvemEgPGRh
bmllbC5iYXJib3phQG9zcy5xdWFsY29tbS5jb20+DQo+IENjOiBMaXUgWmhpd2VpIDx6aGl3ZWlf
bGl1QGxpbnV4LmFsaWJhYmEuY29tPg0KPiBDYzogQ2hhbyBMaXUgPGNoYW8ubGl1QHByb2Nlc3Nt
aXNzaW9uLmNvbT4NCj4gQ2M6IHFlbXUtcmlzY3ZAbm9uZ251Lm9yZw0KPiAtLS0NCj4gwqB0YXJn
ZXQvcmlzY3YvY3B1X2JpdHMuaCB8wqAgOCArKysrKysrKw0KPiDCoHRhcmdldC9yaXNjdi90Y2cv
Y3NyLmPCoCB8IDQ2DQo+ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrLS0NCj4gwqAyIGZpbGVzIGNoYW5nZWQsIDUyIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25z
KC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvdGFyZ2V0L3Jpc2N2L2NwdV9iaXRzLmggYi90YXJnZXQv
cmlzY3YvY3B1X2JpdHMuaA0KPiBpbmRleCBjMDEwNTBjZTJiLi5jNGE5MTQ0MTFiIDEwMDY0NA0K
PiAtLS0gYS90YXJnZXQvcmlzY3YvY3B1X2JpdHMuaA0KPiArKysgYi90YXJnZXQvcmlzY3YvY3B1
X2JpdHMuaA0KPiBAQCAtNzExLDYgKzcxMSwxNCBAQCB0eXBlZGVmIGVudW0gew0KPiDCoCNkZWZp
bmUgU0FUUDY0X0FTSUTCoMKgwqDCoMKgwqDCoMKgIDB4MEZGRkYwMDAwMDAwMDAwMFVMTA0KPiDC
oCNkZWZpbmUgU0FUUDY0X1BQTsKgwqDCoMKgwqDCoMKgwqDCoCAweDAwMDAwRkZGRkZGRkZGRkZV
TEwNCj4gwqANCj4gKy8qIGhnYXRwIENTUiBmaWVsZCBtYXNrcyAqLw0KPiArI2RlZmluZSBIR0FU
UDMyX01PREXCoMKgwqDCoMKgwqDCoCBTQVRQMzJfTU9ERQ0KPiArI2RlZmluZSBIR0FUUDMyX1ZN
SUTCoMKgwqDCoMKgwqDCoCAweDFGQzAwMDAwDQo+ICsjZGVmaW5lIEhHQVRQMzJfUFBOwqDCoMKg
wqDCoMKgwqDCoCBTQVRQMzJfUFBODQo+ICsjZGVmaW5lIEhHQVRQNjRfTU9ERcKgwqDCoMKgwqDC
oMKgIFNBVFA2NF9NT0RFDQo+ICsjZGVmaW5lIEhHQVRQNjRfVk1JRMKgwqDCoMKgwqDCoMKgIDB4
MDNGRkYwMDAwMDAwMDAwMFVMTA0KPiArI2RlZmluZSBIR0FUUDY0X1BQTsKgwqDCoMKgwqDCoMKg
wqAgU0FUUDY0X1BQTg0KPiArDQo+IMKgLyogUk5NSSBtbnN0YXR1cyBDU1IgbWFzayAqLw0KPiDC
oCNkZWZpbmUgTU5TVEFUVVNfTk1JRcKgwqDCoMKgwqDCoCAweDAwMDAwMDA4DQo+IMKgI2RlZmlu
ZSBNTlNUQVRVU19NTlBWwqDCoMKgwqDCoMKgIDB4MDAwMDAwODANCj4gZGlmZiAtLWdpdCBhL3Rh
cmdldC9yaXNjdi90Y2cvY3NyLmMgYi90YXJnZXQvcmlzY3YvdGNnL2Nzci5jDQo+IGluZGV4IDA2
MWJjOWRiNzcuLmZjN2JkNjEwNzMgMTAwNjQ0DQo+IC0tLSBhL3RhcmdldC9yaXNjdi90Y2cvY3Ny
LmMNCj4gKysrIGIvdGFyZ2V0L3Jpc2N2L3RjZy9jc3IuYw0KPiBAQCAtNTA1MCwxNyArNTA1MCw1
OSBAQCBzdGF0aWMgUklTQ1ZFeGNlcHRpb24NCj4gcmVhZF9oZ2VpcChDUFVSSVNDVlN0YXRlICpl
bnYsIGludCBjc3JubywNCj4gwqDCoMKgwqAgcmV0dXJuIFJJU0NWX0VYQ1BfTk9ORTsNCj4gwqB9
DQo+IMKgDQo+ICtzdGF0aWMgdGFyZ2V0X3Vsb25nIGhnYXRwX21hc2soQ1BVUklTQ1ZTdGF0ZSAq
ZW52KQ0KPiArew0KPiArwqDCoMKgIHRhcmdldF91bG9uZyBtYXNrOw0KPiArDQo+ICvCoMKgwqAg
aWYgKHJpc2N2X2NwdV9teGwoZW52KSA9PSBNWExfUlYzMikgew0KPiArwqDCoMKgwqDCoMKgwqAg
bWFzayA9IEhHQVRQMzJfTU9ERSB8IEhHQVRQMzJfVk1JRCB8IEhHQVRQMzJfUFBOOw0KPiArwqDC
oMKgIH0gZWxzZSB7DQo+ICvCoMKgwqDCoMKgwqDCoCBtYXNrID0gSEdBVFA2NF9NT0RFIHwgSEdB
VFA2NF9WTUlEIHwgSEdBVFA2NF9QUE47DQo+ICvCoMKgwqAgfQ0KPiArDQo+ICvCoMKgwqAgLyog
Ry1zdGFnZSB4NCByb290IHBhZ2UgdGFibGVzIGFyZSBhbHdheXMgMTYgS2lCIGFsaWduZWQuICov
DQo+ICvCoMKgwqAgcmV0dXJuIG1hc2sgJiB+KHRhcmdldF91bG9uZykzOw0KPiArfQ0KPiArDQo+
ICtzdGF0aWMgdGFyZ2V0X3Vsb25nIGxlZ2FsaXplX2hnYXRwKENQVVJJU0NWU3RhdGUgKmVudiwN
Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIHRhcmdldF91bG9uZyBvbGRfaGdhdHAsDQo+ICvCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB0
YXJnZXRfdWxvbmcgdmFsKQ0KPiArew0KPiArwqDCoMKgIHRhcmdldF91bG9uZyBtb2RlX21hc2sg
PSByaXNjdl9jcHVfbXhsKGVudikgPT0gTVhMX1JWMzIgPw0KPiArwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgSEdBVFAzMl9NT0RFIDogSEdB
VFA2NF9NT0RFOw0KPiArwqDCoMKgIHRhcmdldF91bG9uZyBoZ2F0cCA9IHZhbCAmIGhnYXRwX21h
c2soZW52KTsNCj4gK8KgwqDCoCB0YXJnZXRfdWxvbmcgbW9kZSA9IGdldF9maWVsZChoZ2F0cCwg
bW9kZV9tYXNrKTsNCj4gKw0KPiArwqDCoMKgIC8qDQo+ICvCoMKgwqDCoCAqIGhnYXRwLk1PREUg
aXMgYSBXQVJMIGZpZWxkLCBzbyBhbiB1bnN1cHBvcnRlZCB2YWx1ZSBtdXN0IGJlDQo+ICvCoMKg
wqDCoCAqIGxlZ2FsaXplZCByYXRoZXIgdGhhbiBjYXVzaW5nIHRoZSBlbnRpcmUgd3JpdGUgdG8g
YmUgaWdub3JlZC4NCj4gK8KgwqDCoMKgICogVGhlIHNwZWNpZmljYXRpb24gZG9lcyBub3QgcmVx
dWlyZSBhIHBhcnRpY3VsYXIgbGVnYWwgdmFsdWUsDQo+ICvCoMKgwqDCoCAqIFFFTVUgaGVyZSBj
aG9vc2VzIHRvIGtlZXAgdGhlIHByZXZpb3VzIG1vZGUgd2hpbGUgYWNjZXB0aW5nDQo+ICvCoMKg
wqDCoCAqIHdyaXRlcyB0byB0aGUgcmVtYWluaW5nIFdBUkwgZmllbGRzLg0KPiArwqDCoMKgwqAg
Ki8NCj4gK8KgwqDCoCBpZiAoIXZhbGlkYXRlX3ZtKGVudiwgbW9kZSkpIHsNCj4gK8KgwqDCoMKg
wqDCoMKgIGhnYXRwID0gc2V0X2ZpZWxkKGhnYXRwLCBtb2RlX21hc2ssDQo+ICvCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBnZXRfZmllbGQob2xkX2hn
YXRwLCBtb2RlX21hc2spKTsNCj4gK8KgwqDCoCB9DQo+ICsNCj4gK8KgwqDCoCBpZiAoaGdhdHAg
IT0gb2xkX2hnYXRwKSB7DQo+ICvCoMKgwqDCoMKgwqDCoCB0bGJfZmx1c2goZW52X2NwdShlbnYp
KTsNCj4gK8KgwqDCoCB9DQo+ICsNCj4gK8KgwqDCoCByZXR1cm4gaGdhdHA7DQo+ICt9DQo+ICsN
Cj4gwqBzdGF0aWMgUklTQ1ZFeGNlcHRpb24gcmVhZF9oZ2F0cChDUFVSSVNDVlN0YXRlICplbnYs
IGludCBjc3JubywNCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHRhcmdldF91bG9uZyAqdmFsKQ0KPiDCoHsNCj4gLcKg
wqDCoCAqdmFsID0gZW52LT5oZ2F0cDsNCj4gK8KgwqDCoCAqdmFsID0gZW52LT5oZ2F0cCAmIGhn
YXRwX21hc2soZW52KTsNCj4gwqDCoMKgwqAgcmV0dXJuIFJJU0NWX0VYQ1BfTk9ORTsNCj4gwqB9
DQo+IMKgDQo+IMKgc3RhdGljIFJJU0NWRXhjZXB0aW9uIHdyaXRlX2hnYXRwKENQVVJJU0NWU3Rh
dGUgKmVudiwgaW50IGNzcm5vLA0KPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB0YXJnZXRfdWxvbmcgdmFsLCB1aW50
cHRyX3QgcmEpDQo+IMKgew0KPiAtwqDCoMKgIGVudi0+aGdhdHAgPSBsZWdhbGl6ZV94YXRwKGVu
diwgZW52LT5oZ2F0cCwgdmFsKTsNCj4gK8KgwqDCoCBlbnYtPmhnYXRwID0gbGVnYWxpemVfaGdh
dHAoZW52LCBlbnYtPmhnYXRwLCB2YWwpOw0KPiDCoMKgwqDCoCByZXR1cm4gUklTQ1ZfRVhDUF9O
T05FOw0KPiDCoH0NCj4gwqANCj4gDQo+IC0tLQ0KPiBiYXNlLWNvbW1pdDogYzFjMThkMWU2NDBi
NjQyOTI4NTljZTlmMzBmM2MzNDRlZGZiMDI5NA0KPiBjaGFuZ2UtaWQ6IDIwMjYwOTIwLXJpc2N2
LWhnYXRwLXdhcmwtMWU0OGZkMzIxMTg4DQo+IA0KPiBCZXN0IHJlZ2FyZHMsDQo+IC0twqAgDQo+
IFNodW5jaGFvIEh1IDxodXNodW5jaGFvQGJvc2MuYWMuY24+DQo+IA0K

