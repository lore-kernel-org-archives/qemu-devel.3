Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B358C9832F
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2026 03:39:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xB2Cf-0006qj-Tr; Sun, 27 Sep 2026 23:38:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=724888370=Alistair.Francis@wdc.com>)
 id 1xB2Ca-0006q4-W1
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 23:38:54 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=724888370=Alistair.Francis@wdc.com>)
 id 1xB2CY-0005hc-FY
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 23:38:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1790566730; x=1822102730;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=fsG5vpErJVJSCKqMagmmhACylEdeFfyIYH4RViRJ0Pc=;
 b=TKXxMezHpPB+OKTB8nrREBAu9ZEj4qbxe9rbMfD2jjo7uQ/wY/FPLrZ5
 mVPmdYioxiympZyMO+5FPl+matkpjmtWaG/BcnYbSKzQ3LgmyndYHMshj
 k6Ie/IXp41kG5EVmeg9TEcIniW0mMpe9cKMdcErMAxTT8IRHWO8+ZS2LD
 T+LObFTex6E++3eY+/DorXKeOUXGEklZjBPm+ovuRmaMg1xhkrAZisnrR
 t8JFP5zXrZLngXlcCGl4OI69X15PCmUOJ/VpG9TT49pV6laAfRUF+J+eY
 6LiZDW6tT0KuM74acJx/EJLTJdoLiGCZOqhkOPcavYLkZrXUV7CCK/x3Z g==;
X-CSE-ConnectionGUID: TxU2Xgy8SlyJwxgLecqX2Q==
X-CSE-MsgGUID: CzAsefmjSYiSHKpDJ8QhrQ==
X-IronPort-AV: E=Sophos;i="6.27,127,1786982400"; d="scan'208";a="157647307"
Received: from mail-eastusazon11011003.outbound.protection.outlook.com (HELO
 BL2PR02CU003.outbound.protection.outlook.com) ([52.101.52.3])
 by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 28 Sep 2026 11:38:48 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X3IhDhCMJ0v1ewp2V/XetE25YNcKlOA0aj0Y72x8wpyiWmodUo0XIVMQcJ/0gBjH/25Nvi3Pmn1UysK5tg0yNMFFM1HrWDXdRZ1TJloNgcwpc9O34/+TtOXQ2eYfqvImqSFK7OqfPD4tXsJi17lnFQzUbvLZI3+FwrPjKDoajjd9gEYBXF/jI1ZCFMo7Qf1wWSZlwdCRZsrfkIzHl4Eg63NnwSMptOnUwcGFC3rcSS8D7FS4N8gKq/bYSyGyJiJF+GU//dGTd6k9jky2qpVNzleEV3kQvsTJdbkTkukVwHdRCkStydCK5jH2kyR65LZn93rhBVcoe+tdmRtAjUivzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fsG5vpErJVJSCKqMagmmhACylEdeFfyIYH4RViRJ0Pc=;
 b=q4WWMbv2BgK2ZJ3oGOPsWcVyHdUotFllHkod7369NUEUs2Wj1ss+sQzdy9GPL181//UOT7Bni4rOH1D05RYrjfq2ESwSFxa77BPgR77g8C/ZT8Uk5erCw9vmUOoy6WY02yFktTJkG9bXAlH4+ip3UGxrkTmbv0eWpYIAbrG+qvPJd6mtPLu0vGJEKYN3w6pQz+3s3nGCiy9xv2sffSD7CSTM6ru6x9nsK5h3Tycsu4OXIhr00bkaLAjVFg5pTs7ylo20ZvsbtfJJ9UmUBPjc+MU+syhxHf54oa1CifobbcG/6K11o9Ka+KXjsph723P1tyJig04dXqNpoqkEZ4lNWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fsG5vpErJVJSCKqMagmmhACylEdeFfyIYH4RViRJ0Pc=;
 b=Ys6ai2C7OcnHxIBMZfMzRWnaoU5gTheRdeUrlfO4ObXUNIIAG/skk2jY9l7CkqcifHIskXR8e2hHFJQ+rk9p+PyULjiYrVGbJhaalwANSbjWugpP0N6fF6Z1CK/+RI7VKMMw2zu1dCLHNlJu55A9m9qYiXXFyOtAcGoARkMozxo=
Received: from BY1PR04MB9561.namprd04.prod.outlook.com (2603:10b6:a03:5b6::11)
 by SA3PR04MB8715.namprd04.prod.outlook.com (2603:10b6:806:302::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Mon, 28 Sep
 2026 03:38:46 +0000
Received: from BY1PR04MB9561.namprd04.prod.outlook.com
 ([fe80::3869:e494:2fa8:9888]) by BY1PR04MB9561.namprd04.prod.outlook.com
 ([fe80::3869:e494:2fa8:9888%6]) with mapi id 15.21.0451.022; Mon, 28 Sep 2026
 03:38:46 +0000
From: Alistair Francis <Alistair.Francis@wdc.com>
To: "richard.henderson@linaro.org" <richard.henderson@linaro.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "max.chou@sifive.com" <max.chou@sifive.com>, "palmer@dabbelt.com"
 <palmer@dabbelt.com>, "daniel.barboza@oss.qualcomm.com"
 <daniel.barboza@oss.qualcomm.com>, "philmd@oss.qualcomm.com"
 <philmd@oss.qualcomm.com>
Subject: Re: [PATCH v3 04/11] tcg/riscv64: Use signed type for encoding
 immediates
Thread-Topic: [PATCH v3 04/11] tcg/riscv64: Use signed type for encoding
 immediates
Thread-Index: AQHdQ90vjjBsyWlosEmBPCNa6aWKEbbjbgEA
Date: Mon, 28 Sep 2026 03:38:46 +0000
Message-ID: <5e1515aa94e17e7cc15dec45cdf3305e7bb4ad0f.camel@wdc.com>
References: <20260914000814.785155-1-richard.henderson@linaro.org>
 <20260914000814.785155-5-richard.henderson@linaro.org>
In-Reply-To: <20260914000814.785155-5-richard.henderson@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.62.0 (by Flathub.org) 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY1PR04MB9561:EE_|SA3PR04MB8715:EE_
x-ms-office365-filtering-correlation-id: 6e671cf0-7383-4cfb-6cb5-08df1d1200a3
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|19092799006|1800799024|23010399003|376014|10070799003|366016|10067099003|38070700021|3023799007|56012099006|11063799006|4143699003|22082099003|18002099003;
x-microsoft-antispam-message-info: 54UcA17XFD4k7HqOxAi6Y0hEAWAz5t/bdEqGViz8kGPim5H4u6WJTE2YuKwK+wTdBmwxPOd9tRZOf2WxN9+9cw5TchtID6SMT6TG4u1d5gEhjUcX+S9FvoE0Xkg6U2JXHhT/lsqfVqic1vDwJIvmxhaKz6bAW3p6OTph7h59p70KAlxZba1kc1kGRb2996Z4YZAUZ5OdaAIBXa3kHEJ+Z5jjBEzym4Pgq7xTK7sqxGDXGzlnR6v1gj7bo7oTsXNceCRFGTKTBusZjfH8xGsL3ZwXPR8M++qbJ67VbBeMPwmyG2ahdESqGMLMyag+UI2Dv+Wm8JI1TJVSgOgpe+/O69HA6LnqRoJxzhLcNj0rPkFcV0lZABE3xt3uU60eV3vcZniS0JBdJRZYBoZqPd+iB6R+4wUGxZbU+NXAJLJTMyzTZ/LqIwm9IKG41zZ5yTbQDzR77i42L+TtXIrI3YsljjSg2fB/2Ig4os+LK/d8hupE8vDwRl5aQUiVIV/vDQOC2ew58lQHvA31Wx3w9GPWYIgkp2XuQe4GVhOFzpPChT8YWpU1ygCs6kxuUWJDjB6R3CYcWZWhba1DsPzImX0/VXBTQYOdqpJfmMX8J822o5MYFT9ZL8IbZyeoytxCHVb2vLn7UibJhDqL4K4GoVRyvXYEuqsEoZl0d66sE+2fhStPa7qvHrZjcQhk4TksF7TLn+29/v88M6dlPMmvDdr/vXYr4CZKEYqGVsieE5MSLC4=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY1PR04MB9561.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(1800799024)(23010399003)(376014)(10070799003)(366016)(10067099003)(38070700021)(3023799007)(56012099006)(11063799006)(4143699003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SHhCMDlTYUlNWnRIMWxSSnhHamNLZUpITGN2N0dwTnErWEtWL3pmaVA0NXQ3?=
 =?utf-8?B?VjM5am1UaklOQTdsZnpvalRnYXJMb0p5MkkvUTNBamRIbVVDNVVjWURsc3ZF?=
 =?utf-8?B?WEswcEJsVDZQUXZwMUpvQVpJQU1hbEczNStETDQ2ekUvallhbGZUbWR3TnJk?=
 =?utf-8?B?MnlUMERqK1NqdFJwQ1I3NmEwVC9WT3hJczh0enB2Y3o3QW1jT2FhNDlvdjdq?=
 =?utf-8?B?TUJ3cEo2U1ErZ2xDYTViVmpQbUFpYWpKeU1tc2had3o3czNhNG1TRHhiUkJw?=
 =?utf-8?B?aEY3N3NRdG1rVE9SM3JXTWdMREhiZDFmK0NRN0RwWHJBZy9jK2w0T0g2Y0Rz?=
 =?utf-8?B?dmdmeXQwcWV1TEJXcW5KQkJyS0gvMDRIUFYrQTcrbk93VGtGaVV2ZmZEZE85?=
 =?utf-8?B?S01oZDdSUFhFN0FhUlBta3FlN0VTcGtLK1lCbzkraDJLKzlib3NVQ3NRdDFm?=
 =?utf-8?B?MVBVUWMvN3lvYjQ0TS8wdW00cE55dVk2b1hSMGZDcWdwZEZBWEJhMkNtampk?=
 =?utf-8?B?QUsvdmFvZTdhdVUrQUdBcFl3emJQUFFScE80L3NVL2xIbUpwUVYwVWZ5QnFF?=
 =?utf-8?B?dkNXZWQ5ZzhCeVB2YXlueUFEaENKM2tKRzhJNDJYNXRMaHRYM1JwOXBla3Jt?=
 =?utf-8?B?emxqdG1lU0dYNlJhREdMZWtFT1pkWEhvYUVwZG00Z2tjcXNGSE82Y2w2NDJI?=
 =?utf-8?B?V1BZS2wrVkxDSitkYUtnVEV5aTduL1FjZEhKbGRwajExbExWSHN1UDFpRldx?=
 =?utf-8?B?RFZWS3JrNEJtQmFQMlR3a2syR3lHMTNzWERoclAyRUFUYkRUcFc4amhYb0I4?=
 =?utf-8?B?amZqeVVhcHpmTW4xcDAxT3RxSUhMQU9BbmR2Q0Jnd05BUEI2RWN0SGswb0dR?=
 =?utf-8?B?VzF3cWU3cGxaUS9xb3dTL1VqRmVhWUVDWEY2VHZlbktaQjd4UmMzYVQ4YzZV?=
 =?utf-8?B?M3FnM0t0SlZlQmo0NEVUcTZSSE02eVNOLzRmR0VET0MrWnRNeURFeWFrTDFN?=
 =?utf-8?B?djNmMXFFUE5iK3JQL2h4cTRxYmttWnNaUU9UbW04S3Bwc2hXUFpQK0NjMnha?=
 =?utf-8?B?SlJ4aXUvMkR0bUY5Y25Tb3Fkdk5TdlpCSGN6Qnd0SXZSdnQ3aEt0eEJEUVMx?=
 =?utf-8?B?WU9lb2NORm5VS0diT0lyU0ZGaWFGS20vM0NVcGtyaWFDVERwcmVRejJOZFRu?=
 =?utf-8?B?S3V1S0lZUlFrZ2MvUHFrN1VEc1RXdVJMb09WL3ZGREJhRFNrWFFETjBHWDM0?=
 =?utf-8?B?U2lzVkdaVGtla1UxcTdlQ3RsRzE1TjZUTWNqcEJVbVFvdDgxSERjK0NLaUxl?=
 =?utf-8?B?WXQ4Q3RQN1YyTEYxdGo4d01rNmp1cU5wU1U1dUg0Smp3REduaHczaWNKTUh2?=
 =?utf-8?B?akRMYnlQYkJEczkzTG1HVlZQdnpBVG9IYW9wZTNLWW9pbVhSMHdXa3NsMHNC?=
 =?utf-8?B?V3ZzQTF3RHZ2dHh5aVpYREhORmNoVUtFc3ZOd0cvSDZoNEY4UDRsQmNTUnAr?=
 =?utf-8?B?NFdvZ08xVnd2M3Rva2kxZ3o4d0FUWHNHY0dNa3Qxa3hFMGVaSUgrdDNON0ZY?=
 =?utf-8?B?QnN0emlaQTViTHlmZ2FxZVNjaklHemtuRGpoU29KR0FXZUdhTFpCWVRLb1hm?=
 =?utf-8?B?eVNlUlowTDhDT1V1QnVBUUdkTkRlVmpneGw4WURXWHV3M1VGUmoxOVJaTDFK?=
 =?utf-8?B?UmpDSHlWTi8zTmtvV1BFcWN5eTQ2WC8zeVdvMWV4cy9UK29UeEhFTlJ3T0Fn?=
 =?utf-8?B?VHBSSlA5VjQ4SEtEME13VDg1WW1yOUZzRzIrZXlYa1JUM1lTKzU3N0dEOG1X?=
 =?utf-8?B?b0xaWHZEOXpDQmROcFZvQlZCTDVxTGZkUURONlpVdVVTT293QXB3bmgvNFl5?=
 =?utf-8?B?dk9xTWkydVhnL3VWcWwxeFAxRFphUGdXbHVCK3lGREtGT2VYaG9JVVJCQ28z?=
 =?utf-8?B?Si9HM25vb3hVV2Y4WnZzY2NKRFQvMU1qUTFwSFliN3NGWFJIU2x1OERQQTBp?=
 =?utf-8?B?Q1l6cW9qV1FKa2t1c2tzWTV3akQzUlYvM2pZdTFyNlRKVWN5aGdEYWRYZ2NH?=
 =?utf-8?B?Tkd6aWxKaG01RTZaK2dGZFp1RzQrZFZXcDREcHh2UjJKRFo1WXVnTzU3YUNj?=
 =?utf-8?B?V0lDSkl6RXFUdzU2N1orTmJQdlpDNFg5YWQ4eXYvTk8vaGhDQ3lUT2dVMnQ4?=
 =?utf-8?B?ZG1ZVmFmMFYwOHVGR2tWWFZHWUhGS0IweGhLcXQ4TitvMWFlSDd1akxyZzJr?=
 =?utf-8?B?YnBWSzZWOFU0M3gvWWdGZStaREZEVjZFTElpNVRKajlUdTNvUHQyZDA2VWh2?=
 =?utf-8?B?TW4wTTBteUNzcTNKNjdSNWtKR0FqRFAyWmdYcUhaRzhVcWtYWlMzM04yckxs?=
 =?utf-8?Q?KIwxs+TkVl1F14OhL+fAcpbl01TOs7p7NUTSpkyvjOoHn?=
x-ms-exchange-antispam-messagedata-1: WWs/Qm1eFq+FU3uRUsdIjgm2dHPUT2vxeyw=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A393CB49024F3F4D8D8D1F8AD6A0B31F@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: EzRhWZLxdbxhPCkw6WMXfv+gxm+dd1b2nyp8BnS5POijdOFjiwDfy0HY+R/pUBeI/IxlbgUuYozfHB+sDTDYbVRHbEF/WhXC6IKGTcrRF7No9i0kNR2wtkHnTubthtfYSPgxIJzjYpquzKcdm3dkD1rbRq5YC2l1O2H1IvZTL3X6MbSpdrZL+2rrK3eC3sM0wsbpD02sQUpWvviu5gU6g1k4Q+rffDyRYtIg+R1VoBI6CeUQgbhaKJQ9T2qA1KoCqb02mTpJsfKTvKNehHBdgDZZHJCyoHpfdIbvvUpjg8UTZbPiABACuT1AV18aDmzUT6k8flh4I644kojsnjOSZg==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: eNq3sw4WUyP0UMebWT0fhBCms/YqdsGys1lAfaA8MgJPSeFFBclVR5pG4anpHcj7GCcafxWgYLfmxXWMtFYvatPH8DiuWwgLhze8gVo0BpZ16jFWcD/jEDpxMLKeyBYv82vBPjtEIWJmg/4ls05aIrUZl55RfT9Lf1VHAacfhN7e9r+5ATz1k+uTnK2Vl4qg2TqibfWesIy7ye9ZSAqWWI7fDluu4zPWAJVPtg6wRXBYncNR0plx84bTMsKnrx5soka2Z7tJp1ArAKeDr5nza6hUHFypASieh+Yn8fAwxT4q30Ow5aoLlrXqE9lpnS5oLCHgyaphd8lgqfMek5ykIlHrUruwPIDQPWtpisBtEMHONTn7DXHi8cPhJWLso6dMgYvv5P27VOvGi8WOcvR62MuAocP8BCVnjArI0gaCfwCyRPEv6WcclsBQOjPUuwcHoMUE9XSOPZhYK5Gly1l3juaDIomOze6Rg47ZQ8A4Wcd4MkfYF1o87b9EbahBk5chZ0nYnXem9bICqUIxdqNDzyV2cwGzv5MYXW++1FqwhVR+GXggcJ7YyiroSCSHGS+lykvN9R+7GipJDVXO1qtrM5PBFmWzgnXC3NBCZgoZmvow7cYl66VVeIUkoze4Drfo
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY1PR04MB9561.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e671cf0-7383-4cfb-6cb5-08df1d1200a3
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Sep 2026 03:38:46.7140 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3+M4y+Ne/59vDAn0HiAhgMmK1BMnkZu5kRH9e8Mrwu5Lkv8VbADnwZHezism15eid7nbs8zK8X2d4GaijJoQwJnDidkjgACna/doR5gH7Hc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR04MB8715
Received-SPF: pass client-ip=68.232.143.124;
 envelope-from=prvs=724888370=Alistair.Francis@wdc.com;
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

T24gU3VuLCAyMDI2LTA5LTEzIGF0IDE0OjA4IC0xMDAwLCBSaWNoYXJkIEhlbmRlcnNvbiB3cm90
ZToKPiBUaGUgaW1tZWRpYXRlIG9wZXJhbmRzIGluIHRoZSA1IGJhc2UgaW5zdHJ1Y3Rpb24gZm9y
bWF0cyBhcmUgYWxsCj4gc2lnbmVkLAo+IHNvIHBhc3NpbmcgYW4gdW5zaWduZWQgdHlwZSB3YXMg
bG9naWNhbGx5IGluY29ycmVjdC7CoCBVc2UKPiB0Y2dfdGFyZ2V0X2xvbmcKPiBub3QgaW50MzJf
dCB0byBhdm9pZCB0cnVuY2F0aW9uLCB3aGljaCB3aWxsIGJlY29tZSByZWxldmFudCBsYXRlci4K
PiAKPiBTaWduZWQtb2ZmLWJ5OiBSaWNoYXJkIEhlbmRlcnNvbiA8cmljaGFyZC5oZW5kZXJzb25A
bGluYXJvLm9yZz4KClJldmlld2VkLWJ5OiBBbGlzdGFpciBGcmFuY2lzIDxhbGlzdGFpci5mcmFu
Y2lzQHdkYy5jb20+CgpBbGlzdGFpcgoKPiAtLS0KPiDCoHRjZy9yaXNjdjY0L3RjZy10YXJnZXQu
Yy5pbmMgfCAzMyArKysrKysrKysrKysrKysrKystLS0tLS0tLS0tLS0tLS0KPiDCoDEgZmlsZSBj
aGFuZ2VkLCAxOCBpbnNlcnRpb25zKCspLCAxNSBkZWxldGlvbnMoLSkKPiAKPiBkaWZmIC0tZ2l0
IGEvdGNnL3Jpc2N2NjQvdGNnLXRhcmdldC5jLmluYyBiL3RjZy9yaXNjdjY0L3RjZy0KPiB0YXJn
ZXQuYy5pbmMKPiBpbmRleCBmNzdmZGVkMWRmYS4uOTliYzY1OGMyNjQgMTAwNjQ0Cj4gLS0tIGEv
dGNnL3Jpc2N2NjQvdGNnLXRhcmdldC5jLmluYwo+ICsrKyBiL3RjZy9yaXNjdjY0L3RjZy10YXJn
ZXQuYy5pbmMKPiBAQCAtNDQ1LDE5ICs0NDUsMjAgQEAgc3RhdGljIHRjZ19pbnNuX3VuaXQgZW5j
b2RlX3IoUklTQ1ZJbnNuIG9wYywKPiBUQ0dSZWcgcmQsIFRDR1JlZyByczEsIFRDR1JlZyByczIp
Cj4gwqAKPiDCoC8qIFR5cGUtSSAqLwo+IMKgCj4gLXN0YXRpYyB0Y2dfaW5zbl91bml0IGVuY29k
ZV9pbW0xMih1aW50MzJfdCBpbW0pCj4gK3N0YXRpYyB0Y2dfaW5zbl91bml0IGVuY29kZV9pbW0x
Mih0Y2dfdGFyZ2V0X2xvbmcgaW1tKQo+IMKgewo+IMKgwqDCoMKgIHJldHVybiAoaW1tICYgMHhm
ZmYpIDw8IDIwOwo+IMKgfQo+IMKgCj4gLXN0YXRpYyB0Y2dfaW5zbl91bml0IGVuY29kZV9pKFJJ
U0NWSW5zbiBvcGMsIFRDR1JlZyByZCwgVENHUmVnIHJzMSwKPiB1aW50MzJfdCBpbW0pCj4gK3N0
YXRpYyB0Y2dfaW5zbl91bml0IGVuY29kZV9pKFJJU0NWSW5zbiBvcGMsIFRDR1JlZyByZCwKPiAr
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCBUQ0dSZWcgcnMxLCB0Y2dfdGFyZ2V0X2xvbmcgaW1tKQo+IMKgewo+IMKgwqDCoMKgIHJldHVy
biBvcGMgfCAocmQgJiAweDFmKSA8PCA3IHwgKHJzMSAmIDB4MWYpIDw8IDE1IHwKPiBlbmNvZGVf
aW1tMTIoaW1tKTsKPiDCoH0KPiDCoAo+IMKgLyogVHlwZS1TICovCj4gwqAKPiAtc3RhdGljIHRj
Z19pbnNuX3VuaXQgZW5jb2RlX3NpbW0xMih1aW50MzJfdCBpbW0pCj4gK3N0YXRpYyB0Y2dfaW5z
bl91bml0IGVuY29kZV9zaW1tMTIodGNnX3RhcmdldF9sb25nIGltbSkKPiDCoHsKPiDCoMKgwqDC
oCB0Y2dfaW5zbl91bml0IHJldCA9IDA7Cj4gwqAKPiBAQCAtNDY3LDE0ICs0NjgsMTUgQEAgc3Rh
dGljIHRjZ19pbnNuX3VuaXQgZW5jb2RlX3NpbW0xMih1aW50MzJfdAo+IGltbSkKPiDCoMKgwqDC
oCByZXR1cm4gcmV0Owo+IMKgfQo+IMKgCj4gLXN0YXRpYyB0Y2dfaW5zbl91bml0IGVuY29kZV9z
KFJJU0NWSW5zbiBvcGMsIFRDR1JlZyByczEsIFRDR1JlZyByczIsCj4gdWludDMyX3QgaW1tKQo+
ICtzdGF0aWMgdGNnX2luc25fdW5pdCBlbmNvZGVfcyhSSVNDVkluc24gb3BjLCBUQ0dSZWcgcnMx
LAo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIFRDR1JlZyByczIsIHRjZ190YXJnZXRfbG9uZyBpbW0pCj4gwqB7Cj4gwqDCoMKgwqAg
cmV0dXJuIG9wYyB8IChyczEgJiAweDFmKSA8PCAxNSB8IChyczIgJiAweDFmKSA8PCAyMCB8Cj4g
ZW5jb2RlX3NpbW0xMihpbW0pOwo+IMKgfQo+IMKgCj4gwqAvKiBUeXBlLUIgKi8KPiDCoAo+IC1z
dGF0aWMgdGNnX2luc25fdW5pdCBlbmNvZGVfYmltbTEyKHVpbnQzMl90IGltbSkKPiArc3RhdGlj
IHRjZ19pbnNuX3VuaXQgZW5jb2RlX2JpbW0xMih0Y2dfdGFyZ2V0X2xvbmcgaW1tKQo+IMKgewo+
IMKgwqDCoMKgIHRjZ19pbnNuX3VuaXQgcmV0ID0gMDsKPiDCoAo+IEBAIC00ODYsMjYgKzQ4OCwy
NyBAQCBzdGF0aWMgdGNnX2luc25fdW5pdCBlbmNvZGVfYmltbTEyKHVpbnQzMl90Cj4gaW1tKQo+
IMKgwqDCoMKgIHJldHVybiByZXQ7Cj4gwqB9Cj4gwqAKPiAtc3RhdGljIHRjZ19pbnNuX3VuaXQg
ZW5jb2RlX2IoUklTQ1ZJbnNuIG9wYywgVENHUmVnIHJzMSwgVENHUmVnIHJzMiwKPiB1aW50MzJf
dCBpbW0pCj4gK3N0YXRpYyB0Y2dfaW5zbl91bml0IGVuY29kZV9iKFJJU0NWSW5zbiBvcGMsIFRD
R1JlZyByczEsCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgVENHUmVnIHJzMiwgdGNnX3RhcmdldF9sb25nIGltbSkKPiDCoHsKPiDC
oMKgwqDCoCByZXR1cm4gb3BjIHwgKHJzMSAmIDB4MWYpIDw8IDE1IHwgKHJzMiAmIDB4MWYpIDw8
IDIwIHwKPiBlbmNvZGVfYmltbTEyKGltbSk7Cj4gwqB9Cj4gwqAKPiDCoC8qIFR5cGUtVSAqLwo+
IMKgCj4gLXN0YXRpYyB0Y2dfaW5zbl91bml0IGVuY29kZV91aW1tMjAodWludDMyX3QgaW1tKQo+
ICtzdGF0aWMgdGNnX2luc25fdW5pdCBlbmNvZGVfdWltbTIwKHRjZ190YXJnZXRfbG9uZyBpbW0p
Cj4gwqB7Cj4gwqDCoMKgwqAgcmV0dXJuIGltbSAmIDB4ZmZmZmYwMDA7Cj4gwqB9Cj4gwqAKPiAt
c3RhdGljIHRjZ19pbnNuX3VuaXQgZW5jb2RlX3UoUklTQ1ZJbnNuIG9wYywgVENHUmVnIHJkLCB1
aW50MzJfdAo+IGltbSkKPiArc3RhdGljIHRjZ19pbnNuX3VuaXQgZW5jb2RlX3UoUklTQ1ZJbnNu
IG9wYywgVENHUmVnIHJkLAo+IHRjZ190YXJnZXRfbG9uZyBpbW0pCj4gwqB7Cj4gwqDCoMKgwqAg
cmV0dXJuIG9wYyB8IChyZCAmIDB4MWYpIDw8IDcgfCBlbmNvZGVfdWltbTIwKGltbSk7Cj4gwqB9
Cj4gwqAKPiDCoC8qIFR5cGUtSiAqLwo+IMKgCj4gLXN0YXRpYyB0Y2dfaW5zbl91bml0IGVuY29k
ZV9qaW1tMjAodWludDMyX3QgaW1tKQo+ICtzdGF0aWMgdGNnX2luc25fdW5pdCBlbmNvZGVfamlt
bTIwKHRjZ190YXJnZXRfbG9uZyBpbW0pCj4gwqB7Cj4gwqDCoMKgwqAgdGNnX2luc25fdW5pdCBy
ZXQgPSAwOwo+IMKgCj4gQEAgLTUxNyw3ICs1MjAsNyBAQCBzdGF0aWMgdGNnX2luc25fdW5pdCBl
bmNvZGVfamltbTIwKHVpbnQzMl90IGltbSkKPiDCoMKgwqDCoCByZXR1cm4gcmV0Owo+IMKgfQo+
IMKgCj4gLXN0YXRpYyB0Y2dfaW5zbl91bml0IGVuY29kZV9qKFJJU0NWSW5zbiBvcGMsIFRDR1Jl
ZyByZCwgdWludDMyX3QKPiBpbW0pCj4gK3N0YXRpYyB0Y2dfaW5zbl91bml0IGVuY29kZV9qKFJJ
U0NWSW5zbiBvcGMsIFRDR1JlZyByZCwKPiB0Y2dfdGFyZ2V0X2xvbmcgaW1tKQo+IMKgewo+IMKg
wqDCoMKgIHJldHVybiBvcGMgfCAocmQgJiAweDFmKSA8PCA3IHwgZW5jb2RlX2ppbW0yMChpbW0p
Owo+IMKgfQo+IEBAIC01NzEsMzEgKzU3NCwzMSBAQCBzdGF0aWMgdm9pZCB0Y2dfb3V0X29wY19y
ZWcoVENHQ29udGV4dCAqcywKPiBSSVNDVkluc24gb3BjLAo+IMKgfQo+IMKgCj4gwqBzdGF0aWMg
dm9pZCB0Y2dfb3V0X29wY19pbW0oVENHQ29udGV4dCAqcywgUklTQ1ZJbnNuIG9wYywKPiAtwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIFRDR1Jl
ZyByZCwgVENHUmVnIHJzMSwgVENHQXJnIGltbSkKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIFRDR1JlZyByZCwgVENHUmVnIHJzMSwgdGNn
X3RhcmdldF9sb25nCj4gaW1tKQo+IMKgewo+IMKgwqDCoMKgIHRjZ19vdXQzMihzLCBlbmNvZGVf
aShvcGMsIHJkLCByczEsIGltbSkpOwo+IMKgfQo+IMKgCj4gwqBzdGF0aWMgdm9pZCB0Y2dfb3V0
X29wY19zdG9yZShUQ0dDb250ZXh0ICpzLCBSSVNDVkluc24gb3BjLAo+IC3CoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIFRDR1JlZyByczEs
IFRDR1JlZyByczIsIHVpbnQzMl90IGltbSkKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBUQ0dSZWcgcnMxLCBUQ0dSZWcgcnMyLAo+
IHRjZ190YXJnZXRfbG9uZyBpbW0pCj4gwqB7Cj4gwqDCoMKgwqAgdGNnX291dDMyKHMsIGVuY29k
ZV9zKG9wYywgcnMxLCByczIsIGltbSkpOwo+IMKgfQo+IMKgCj4gwqBzdGF0aWMgdm9pZCB0Y2df
b3V0X29wY19icmFuY2goVENHQ29udGV4dCAqcywgUklTQ1ZJbnNuIG9wYywKPiAtwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIFRDR1Jl
ZyByczEsIFRDR1JlZyByczIsIHVpbnQzMl90IGltbSkKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIFRDR1JlZyByczEsIFRDR1Jl
ZyByczIsCj4gdGNnX3RhcmdldF9sb25nIGltbSkKPiDCoHsKPiDCoMKgwqDCoCB0Y2dfb3V0MzIo
cywgZW5jb2RlX2Iob3BjLCByczEsIHJzMiwgaW1tKSk7Cj4gwqB9Cj4gwqAKPiDCoHN0YXRpYyB2
b2lkIHRjZ19vdXRfb3BjX3VwcGVyKFRDR0NvbnRleHQgKnMsIFJJU0NWSW5zbiBvcGMsCj4gLcKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
VENHUmVnIHJkLCB1aW50MzJfdCBpbW0pCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgVENHUmVnIHJkLCB0Y2dfdGFyZ2V0X2xvbmcg
aW1tKQo+IMKgewo+IMKgwqDCoMKgIHRjZ19vdXQzMihzLCBlbmNvZGVfdShvcGMsIHJkLCBpbW0p
KTsKPiDCoH0KPiDCoAo+IMKgc3RhdGljIHZvaWQgdGNnX291dF9vcGNfanVtcChUQ0dDb250ZXh0
ICpzLCBSSVNDVkluc24gb3BjLAo+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBUQ0dSZWcgcmQsIHVpbnQzMl90IGltbSkKPiArwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgVENHUmVn
IHJkLCB0Y2dfdGFyZ2V0X2xvbmcgaW1tKQo+IMKgewo+IMKgwqDCoMKgIHRjZ19vdXQzMihzLCBl
bmNvZGVfaihvcGMsIHJkLCBpbW0pKTsKPiDCoH0K

