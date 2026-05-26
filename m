Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83BD2CD5BD5
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 23:45:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wS1S8-0008Ew-Jt; Tue, 26 May 2026 19:44:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=599a94ef2=Alistair.Francis@wdc.com>)
 id 1wS1S6-0008EV-Ue; Tue, 26 May 2026 19:44:50 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=599a94ef2=Alistair.Francis@wdc.com>)
 id 1wS1S4-0003Wx-FF; Tue, 26 May 2026 19:44:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1779839088; x=1811375088;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=hojMsVXw256x9k+WkqRxEdzGut61P0sP/cEteFqeYMA=;
 b=VdxCAJwC6rQ+lZWeLHoeJpaiM8yOVgg+314EwGgIG54O44D/njmVYus7
 HhTN3LrvVqDw6tlXf6CenOtP9gheubYlvFbv2LfIryqYwR4hsBUXhMf05
 oCPAIXOLQoxVN/3WphgKesaEau2DoDxhUAc1JFXXVpVhEJaz/ZGX0qZa+
 2xn0Xhozprq+tFc+u5CJ+yuq8vfZSXZj+8/QbarUqvDnxssbsqoDv20E6
 KVXICkVfYXGW/9YRScGQzOqtCmOitxEsFfVfL/TAefNjWifWrcTtzE/Ep
 bqYO6FHKpfAvbHP3DjsZq1DOgPJDHn3yxumQl81hUcKjva9Vk78dEMLYu A==;
X-CSE-ConnectionGUID: tQFw8iZ+RMm0xOJ4V68dgQ==
X-CSE-MsgGUID: UzK+fJboT+WM/ZYNOrnVKA==
X-IronPort-AV: E=Sophos;i="6.24,170,1774281600"; d="scan'208";a="147840920"
Received: from mail-eastus2azon11011054.outbound.protection.outlook.com (HELO
 BN8PR05CU002.outbound.protection.outlook.com) ([52.101.57.54])
 by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 27 May 2026 07:44:45 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PAR7DSbJymKf60cKJheJS+C7jgZSULahpb4bVAiPUhQhAq9O0xvkOb7scmMkbB4Os91XkbaHcYI/V7G4smIrFdxJn7Qq85DpV/PhKK/riBceaHqnIW38uK0bdotG8cN2VjWhh6jDgglIWdNJ6/gAUGSyU7tuFGZ2wFmZPG0aP7oyME58w+rucl40RMCA5V6iXuoUnVjavA4KntX9zP3V85Wzc0I4dV+Ebh7jcZnfr3Vmr4RF4uU3Yz8W91cTb4Gib0yXceoVRQ4wuJ0xHf+r9Q1fa3Mndcv0+ikA4WvrtXfuvZxZdfLv8JdcY10nI7FTmo//XW5ImkW94jdxKDnDwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hojMsVXw256x9k+WkqRxEdzGut61P0sP/cEteFqeYMA=;
 b=K4Dn0/RJNBU6Q++HpUcVkk3uE0O/dpCL5vPvsAzJ1jI4eh57fLyiyMvfvp7J5/ZgEo8pf3DcKBif3m26Xd7NI/ulYej/1eZzaFwTJ55ldEObRzN+H++w3m4syyXz4edM63QVK3YuGg1Un44FxleZJCSZf+qLm9SZnpfPKegv+LfMhX4DWQfS/9EFfIUZg9kP0psQ8pODAN7o6BAAnPDbF7b7uICbj2X8GfpiPkLoabUhAhRVtcPVPtpg4vXxVK8OMRXXs0MI6lJYmk2fjTpHeSF+mCWvPaHIC/1JBKsx7EACrKNucxI0x7gaetxsN0SVzolJSTlWNA8QzxGj3vk32Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hojMsVXw256x9k+WkqRxEdzGut61P0sP/cEteFqeYMA=;
 b=nDxrxxYzUdXBRIwuj0aZ2+mV6NX1PGzZfNzKRwrC4DWrBZ1XzVs///hEuehV2xVxcXzj8gPkfuIawcMGMDV7HpTtvr6nnf86dy9cvnPv0TLf51A0qfpMmoiySomhb2Z1SoVovNzr0+KaPqEEkx7E9Anifjw6BnhQ1/zcgtDC4G4=
Received: from CH5PR04MB9550.namprd04.prod.outlook.com (2603:10b6:610:20e::17)
 by DS0PR04MB8618.namprd04.prod.outlook.com (2603:10b6:8:126::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.20; Tue, 26 May
 2026 23:44:41 +0000
Received: from CH5PR04MB9550.namprd04.prod.outlook.com
 ([fe80::2dd5:1dc8:e3e7:5d31]) by CH5PR04MB9550.namprd04.prod.outlook.com
 ([fe80::2dd5:1dc8:e3e7:5d31%4]) with mapi id 15.21.0071.011; Tue, 26 May 2026
 23:44:41 +0000
From: Alistair Francis <Alistair.Francis@wdc.com>
To: "anjo@rev.ng" <anjo@rev.ng>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "palmer@dabbelt.com"
 <palmer@dabbelt.com>, "pierrick.bouvier@oss.qualcomm.com"
 <pierrick.bouvier@oss.qualcomm.com>, "philmd@linaro.org" <philmd@linaro.org>
Subject: Re: [PATCH v3 00/14] single-binary: Compile hw/riscv once
Thread-Topic: [PATCH v3 00/14] single-binary: Compile hw/riscv once
Thread-Index: AQHc6FnATayLZWme7EiIEzIixE3+qrYhAoiA
Date: Tue, 26 May 2026 23:44:41 +0000
Message-ID: <a5fd73bf8f30a9532e66d6cf1fe109bcb3eb41b2.camel@wdc.com>
References: <20260520-hw-riscv-cpu-int-v3-0-d1123ea63d9c@rev.ng>
In-Reply-To: <20260520-hw-riscv-cpu-int-v3-0-d1123ea63d9c@rev.ng>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.60.1 (by Flathub.org) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH5PR04MB9550:EE_|DS0PR04MB8618:EE_
x-ms-office365-filtering-correlation-id: c1facd24-2ba3-4cf8-3b63-08debb80c19c
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|10070799003|1800799024|376014|19092799006|366016|6133799003|22082099003|18002099003|11063799006|38070700021|56012099006;
x-microsoft-antispam-message-info: jqC7r00eMIBy4rQ3d+q7J3rSzCDtEuvApbm9kHQIOTrPclOtfS1PtliXZmZXToaNPSsZi24NvOviuI6+UJSG9YzZd3VXpQU4gmvVRL365JaJUvFXgW37zOek/RmwyXGlN3dtDfluKkES52EB/D2+zvJjbsUMB1beATl+BI9nIHyfru2XIPyqUAfMAgMdF8unP1emxLkE7gGLqUJKrS+hD/f+OZxp1jgmlJ8LeCxhhiYQI2Q1GAhZzFnxTP9kb4LBKjoh4Iv4mZFTH4LwJu7DDUSlDURmIbEf0oqTn1+pOxjp6wR+P8k36gSlEjzmfwDCX4MXFnYevqBCHjfBa++7eGjgEP0loGDYMbjhEvOAlXSOGwbAZa3CdAYCIIrU4sosWmNnD1hnmBfvWVgTyjuGUehhe2NaBTZgyT+eWKBiEWxZWWlY8gKN/ZTaeMTGn8jOifv3lPBpLj9HFPEG8M79wxmixxScHidowWD/9RNklb5ZcGQMkQWz2Pfl1SoJzCgq5cHo2NkkHA8m59b2fdU3Opzf44wZ7jFilzWuFyna0UQD21UGhX/jcvEaZXyWjvFID7GMCnRmpOxCwlaZ30jVk8LNoykCTMVxaMyW0OOGr8kp5X4ZYSk0zDF5b93wXjVIyxUnik40AdvNS/jn4VhYqAFqojBckfOUityP0P39CayBdvTbKNy1CPfXnTVfaTyu3JMANjCtsoqZCpkPdsdSBJD7DY59TqYUo0e7ylbXmo313j83UzBSoxbYpdFij0CL
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH5PR04MB9550.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(1800799024)(376014)(19092799006)(366016)(6133799003)(22082099003)(18002099003)(11063799006)(38070700021)(56012099006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bW5LUXhiNWFERW03QytVWFFjKzk0RE1ZYVdRK0hndVR0L1RUWXlOakgxbU1Z?=
 =?utf-8?B?TnVpSk5CUDROeDRmcjlpMi8vUGd2R0lqcDJvT2FDRk9ZbEJRMGo5a3k1V2JR?=
 =?utf-8?B?VXBjUisyMEhYTzBIdFd3cmd4NnoxUDJmSzNwR2VqVlFGaC9RdjRtWWtUSjFQ?=
 =?utf-8?B?bEtlLy94S2FOR0hQcFBKYzFRcUJ0aDRFVkhEazN5aEo4Q201TCtEZU9Da05L?=
 =?utf-8?B?Z0Q4MytDeVZpOFVkL3kvOUNlSlA3TVZMSWp6cTdaQkMybHBXTmxsS2I3MU96?=
 =?utf-8?B?WjBrQ0JpbU05ejRqWG5mcDgxK05LSEQ4N3h1RWR3Yy9YK0VRNWRYQnhDZ2VH?=
 =?utf-8?B?dnZBUmdzb1RZc1RnbjNHTTBRcS9QNDc2WUU2UmJjdFVjY3piTXk5N1U1OEc5?=
 =?utf-8?B?aUpIVUdSNHg0U1V4Z2o5ZDc3a3FPTlNEdjBUU1lMbGpLUnhvbHcvNFl2ZEYy?=
 =?utf-8?B?bHdKMGFjRW5mQ1R5NUVza2tQeWd6M0kxck9XaUlmR0Q5R2J3VUVxQlpleTBW?=
 =?utf-8?B?L2I5Y3QrdlBaOXUvdGtveGV6UHlYL2N6M1kwMTkyeFdKNGNWVk03MzBFNWYr?=
 =?utf-8?B?NVFCeGhHRDM2N2U3OE5LTHdrQU5yKzNlTjk4TG82aWNkaEk1Sm1ad3Y5WDhC?=
 =?utf-8?B?V0Y5MjlKWTFOMm80K05Za2F1ZWRSM2gxdWJDYlowdGNJTG1RWDJyOERuREd6?=
 =?utf-8?B?aWdGNXl0ZHRGUDZjSUYvazBHU1lEenFNWlFWelFXVGp6emI0TlZHek5GNlI5?=
 =?utf-8?B?cWMrRVY1OXkvdkI5YW5UckhzUGRIWm4wTzZuVlEvenI2U2k3WWMzeDN3bEkv?=
 =?utf-8?B?OEFNNFZQaUJROXA2TnpxaExPZWI5K1J3VUw4MldKTDhaT0s3dFdVdFpweEh5?=
 =?utf-8?B?RzJ2bWlBTXJDZ0VTM0VOcjd1OXREV1JWejM2V29GNVNUc25hbU9jMVFFVExj?=
 =?utf-8?B?ZFBOVnllV3JrUVJUaHMwazUwYW5KYjNPcWlOMm1WZzhRYnJsQkdiVXdLQUZa?=
 =?utf-8?B?aTFMWS96K3V6eW5LWnBhdEtUUlJ6eG5HY0kwa3VNQWFiNU1lUEdXZFBIaTVw?=
 =?utf-8?B?ZXdmN0ZWY3lwYTB1ejhXalpTTkpadngzVC9FU040RWdDajNzTWJkMzNEOGZX?=
 =?utf-8?B?TkNEYXRhcUlrWXZFMWVpWUhiYlRDMVlHK2lDZ0xIWThsNUxBL3VYM0ZRaXky?=
 =?utf-8?B?bEdnWmUwL0hqdWpacFBqLzh6bFY4QUdsOHVPWlh2Q1VLWEZPa25DMXNXZFky?=
 =?utf-8?B?blFJc2dZOE5GalBNNlllWkQxTWl5dkNERzc0WjJqNnpudGxabDd2MXEyUGhz?=
 =?utf-8?B?d21tWlZ6THBHcmdvK3dXeTkyc204bEdJYm5lUWFFS3QzaVlJaWt5QTdCTnJ1?=
 =?utf-8?B?ZC9od0d6RnZ2TEk0ZFk4alB5cW5VZEJRL2pzNU9JT01leHlRN1RsdStZMnVF?=
 =?utf-8?B?d1dEcnFkZS9Bc1hDUTROZmlhN1ZuZEIvTDVpNHN1SERRQ09ROVJaWUdsYUlw?=
 =?utf-8?B?TldGL1VmMEVQdDMrRDVYUUprNVFEWndKamNjMi8xb2ZjdlY2ZjkwOXBWQU9a?=
 =?utf-8?B?Y2s4WitZSDFabnNJTnlFbm56LzNNYnpsY2ZuTERBaDYvVlY5K1RHdTR1OEZa?=
 =?utf-8?B?QVl4V2ZueHBmejdNTHNRaFJhc1RBaklrVjNPakhDZ2VIcWVBV25UakliY2hm?=
 =?utf-8?B?N3hYc2FNczU5Y25JRlJxU0p1RmVxdGhxN2xlWFAvZlpaR01kMUUvczFNTUpS?=
 =?utf-8?B?clBhdlNwRFVKQWRlVXNpek5SbTV3a0R5Y21YY3RzdzdVdmpMUkZia1NWdVFM?=
 =?utf-8?B?NllPUTVrVEFXQjZUQThOL0dYY1dLcGsxN3FZWk16UzdVdnZBVlNLTlhuTlUr?=
 =?utf-8?B?V1ArSXlOQWNUQVZ6OEIwQ21qd2x3ckVBU29xdUlzRTBxdmloRGdYSGtKUkU3?=
 =?utf-8?B?ci8vOE94YzFibmJRd2NOcW9XYy94UmUrUlkzZUN6WWthZ1VsVTdHZFVoN2sv?=
 =?utf-8?B?WXVJWUR2dmxKOEViUllBOStsZ0hmSEozQ0NTektyTy9nMjYvV05vWmc3Nm5F?=
 =?utf-8?B?bUl1MmZ6R29sbE40eUVPQnc0d0w5RHFUZWVHZUNnamVqODlBUWwvWGF0Y01Z?=
 =?utf-8?B?WU9RcG13VytPZGlOSGl4RDAwSjlucHl6Q3dObzk4TzlsbGNQVnVLeWt4dTZU?=
 =?utf-8?B?OUpQYjBXbm9pV2xhMnczT1JzaGtOR2VYVmloR20rU09mVWRkMnNPNkI3T05U?=
 =?utf-8?B?NXBGNXgxYmhWTGNtOUpmaFh0LzVYV215ZGY2c3J6OHlLZlNMMWQ2Rys0RVFF?=
 =?utf-8?B?bTN4bFg2VGZPd1dGSGpOSmxSTThVWXZlRzFBY1AzMWFOQjErci9hbEwyN01L?=
 =?utf-8?Q?pZd3irF9QEEG6RgQjTNkX4KyIw3tf6tRLo5B4f3Ht7gF5?=
x-ms-exchange-antispam-messagedata-1: zZopJt+b01UP6zwIcMYRZd9z7q2Kbf8zAp0=
Content-Type: text/plain; charset="utf-8"
Content-ID: <45155B2E23F60F42A061E9D3EF96D81E@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: OKNF+KY18q8/Bz3qi9IJd8pzYkVRt8MXKR753aTir1cVAqO/G5HuO0AevzRwkNfE7tmthKhxLtS4gM5E7q5gZ35RyzgOPYkwmjCEMikzQ3HDq5UaQqkmdTvIj5rBh1GjtDLwN046Fz8YBmfjTJWMOm/ul9ht+JwFmEm/Vj1UJUT79KxAMy9KmoJIflykVKY/e5GM9WNCwO5Af+02H6GOCmKErLx6wLgm8fuFuxc3hoyAHZzn25j8Jlh5M2MHUHASd3XHXshGS+pR9yvlOmLntaC/TbflLV3uPKGJwj4SVGHXfiDSBLulHk6IbpMYzeDFpqsk9bfccFZyyCc3oiDV9w==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: /8/Bh2cA5hCU8gKr7TpexDkd3jwUIETdMwN4Pj4F6p4VG3f5NLXxRfajbJiNpVAcu11kr9B4l6O+nfawdcfWXAaO30gEcFnBWBwMXf13bzYPaXwvLn381Wl7cpCFL1dYWTK8GFB8ZGEn114RoTdhVkiiSGIQSFbcr8djAyPZg8XWpo3NdyVsHlzEnIvyT/X1bIYplI6A8EeHRRj+0sSte2jNHgXFNfSZ4661oSQQziksaaDi/PfgrckT9vNpXflittCOyXfdAgqqZJS3RhGrvBbPeLtChOTsDNRPVyGivv/XnKhdH21z2QhjrHrWBAuDWDMzUVEcH32nDqQQEQEL/rPCiYjdxzo58WBHbSF0ELqO9DlNOdF2JZvSEdOaRzsenVxA1tGyFm6jcrtNuRIGOPXRMPZEQLvBknwRzzgXdd+CkCIXEKl2mxhFN7C51CZCMI00dbSdgPZ6P02zs8QTekzgCywiJZync1xwaFReY9RSxI12Ysz4b8C/p5xg5OavQcf/0DBCpb+0v4ez4i7WvBS41r0rsFIk9KGm3OvHq4xvrOQv+jxfUSZfQ2wxEH7CMAonbzArLmmkVHLD8exKT10BY/ryQaWgf3po/G05eyoN0tSxQxY7XVW0izOQCNn9
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH5PR04MB9550.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1facd24-2ba3-4cf8-3b63-08debb80c19c
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 May 2026 23:44:41.1049 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ikQq/IXJJvE/cjnEhsBkKn+DrBG2mZ6cvKI5iwFAIwPMWqLOTxbuihSbo0Nx03lXmWFJkIjsdAiVuiTMy3uD9diAqmaQFprzDbUTzJyOOAE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR04MB8618
Received-SPF: pass client-ip=216.71.153.141;
 envelope-from=prvs=599a94ef2=Alistair.Francis@wdc.com;
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

T24gV2VkLCAyMDI2LTA1LTIwIGF0IDE1OjEyICswMjAwLCBBbnRvbiBKb2hhbnNzb24gd3JvdGU6
Cj4gQ29tcGlsZXMgaHcvcmlzY3YgYSBzaW5nbGUgdGltZSBmb3IgYm90aCBxZW11LXN5c3RlbS1y
aXNjdjMyIGFuZAo+IHFlbXUtc3lzdGVtLXJpc2N2NjQgYnkgYWRvcHRpbmcgdGhlIFRhcmdldElu
Zm8gQVBJIGFuZCBieSBtb3ZpbmcKPiBtYWNoaW5lIGRlZmluaXRpb25zIHRvIGdlbmVyaWMgUU9N
IGludGVyZmFjZXMuIFRoaXMgaXMgdGhlIHNhbWUKPiBhcHByb2FjaAo+IGFzIHRha2VuIGJ5IFBo
aWxpcHBlIGluCj4gCj4gwqDCoMKgICJzaW5nbGUtYmluYXJ5OiBNYWtlIGh3L2FybS8gY29tbW9u
Igo+IMKgwqDCoCAoMjAyNTEwMjEyMDU3NDEuNTcxMDktMS1waGlsbWRAbGluYXJvLm9yZykuCj4g
Cj4gQWxsIGluIGFsbCwgdGhlIG51bWJlciBvZiBjb21waWxhdGlvbiB3aGVuIGJ1aWxkaW5nIGJv
dGgKPiByaXNjdlszMnw2NF0tc29mdG1tdSBpcyByZWR1Y2VkIGJ5IDExLCBhbmQgdGhlIGJpbmFy
eSBzaXplIG9mCj4gcWVtdS1zeXN0ZW0tcmlzY3ZbMzJ8NjRdIGlzIGluY3JlYXNlZCBieSAwLjEx
JSBhbmQgMC4wMjYlCj4gcmVzcGVjdGl2ZWx5Cj4gKGNvcnJlc3BvbmRpbmcgdG8gNjVrIGFuZCAx
NGsgYnl0ZXMpLgo+IAo+IFRoaXMgcGF0Y2hzZXQgaXMgYmFzZWQgb246Cj4gCj4gwqDCoMKgICJz
aW5nbGUtYmluYXJ5OiBNYWtlIHJpc2N2IGNwdS5oIHRhcmdldCBpbmRlcGVuZGVudCIKPiDCoMKg
wqAgKDIwMjYwNTIwMTI1NDA2LjI4NjkzLTEtYW5qb0ByZXYubmcpLgo+IAo+IEJyYW5jaCBwYXNz
aW5nIENJIGNhbiBiZSBmb3VuZCBoZXJlOgo+IAo+IMKgIGh0dHBzOi8vZ2l0bGFiLmNvbS9BbnRv
bkpvaGFuc3Nvbi9xZW11Ly0vcGlwZWxpbmVzLzIyMTU1MzY3NzgKPiAKPiBTaWduZWQtb2ZmLWJ5
OiBBbnRvbiBKb2hhbnNzb24gPGFuam9AcmV2Lm5nPgo+IC0tLQo+IENoYW5nZXMgaW4gdjM6Cj4g
LSBEcm9wcGVkIG1lcmdlZCBwcmVxdWlzaXRlIHBhdGNoc2V0cy4KPiAtIHBhdGNoIDUvMTQgImNv
bmZpZ3MvdGFyZ2V0OiBJbXBsZW1lbnQgcGVyLWJpbmFyeSBUYXJnZXRJbmZvCj4gc3RydWN0dXJl
Cj4gwqAgZm9yIHJpc2N2IjogVXNlIG5ldyB0YXJnZXRfaW5mb19pbml0KCkgVGFyZ2V0SW5mbyBy
ZWdpc3RyYXRpb24uCj4gLSBwYXRjaCA3LzE0ICJ0YXJnZXQvcmlzY3Y6IFJlcGxhY2UgVFlQRV9S
SVNDVl9DUFVfQkFTRSI6IFJlbmFtZQo+IMKgIHZpcnRfZGVmYXVsdF9jcHVfdHlwZSgpIC0+IHJp
c2N2X2RlZmF1bHRfY3B1X3R5cGUoKSBhbmQgZGVmaW5lIGluCj4gwqAgbWFjaGluZXMtcW9tLmgu
Cj4gLSBEcm9wcGVkIHBhdGNoICJbUEFUQ0ggdjIgMTEvMTRdIHRhcmdldC9yaXNjdjogTWFrZSBw
bXUuaCB0YXJnZXQtCj4gYWdub3N0aWMiOgo+IMKgIFRoaXMgcGF0Y2ggcmVwbGFjZWQgdGFyZ2V0
X3Vsb25ncyB3aXRoIHByaXZpbGVnZV9tb2RlX3QgYW5kIGhhcwo+IGJlZW4gZm9sZGVkCj4gwqAg
aW50byB0aGUgcHJlcmVxdWlzaXRlIHBhdGNoc2V0IGludHJvZHVjaW5nIHRoZSB0eXBlZGVmLiAK
PiAtIEFkZGVkIHBhdGNoIDEyLzE0ICJ0YXJnZXQvcmlzY3Y6IE1vdmUgdGFyZ2V0X2xvbmcuaCBp
bmNsdXNpb24KPiDCoCBhd2F5IGZyb20gY3B1LmgiOiBNb3ZlcyB0YXJnZXRfbG9uZy5oIGluY2x1
c2lvbiB0byB0YXJnZXQgc3BlY2lmaWMKPiDCoCBoZWFkZXIuIAo+IC0gTGluayB0byB2MjoKPiBo
dHRwczovL2xvcmUua2VybmVsLm9yZy9xZW11LWRldmVsLzIwMjUxMjIxLWh3LXJpc2N2LWNwdS1p
bnQtdjItMC1lYjQ5ZDcyYzViMmZAcmV2Lm5nCj4gCj4gQ2hhbmdlcyBpbiB2MjoKPiAtIElubGlu
ZWQgc2lmaXZlX2NwdS5oIHJ1bnRpbWUgZnVuY3Rpb25zIGFuZCByZW1vdmVkIGhlYWRlcgo+IChQ
aGlsaXBwZSk7Cj4gLSBNb3ZlZCBJUlFfTE9DQUxfR1VFU1RfTUFYIG1hY3JvIHRvIGZpZWxkIGlu
IFJJU0NWQ1BVRGVmIChQaGlsaXBwZSk7Cj4gLSBBZGRlZCByZXZpZXdlZC1ieXM7Cj4gLSBMaW5r
IHRvIHYxOgo+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3FlbXUtZGV2ZWwvMjAyNTEyMTctaHct
cmlzY3YtY3B1LWludC12MS0wLWQyNGE0MDQ4ZDNhYUByZXYubmcKPiAuCj4gCj4gLS0tCj4gQW50
b24gSm9oYW5zc29uICgxNCk6Cj4gwqDCoMKgwqDCoCBody9yaXNjdjogUmVnaXN0ZXIgZ2VuZXJp
YyByaXNjdlszMnw2NF0gUU9NIGludGVyZmFjZXMKPiDCoMKgwqDCoMKgIGh3L3Jpc2N2OiBBZGQg
bWFjcm9zIGFuZCBnbG9iYWxzIGZvciBzaW1wbGlmeWluZyBtYWNoaW5lCj4gZGVmaW5pdGlvbnMK
PiDCoMKgwqDCoMKgIGh3L3Jpc2N2OiBGaWx0ZXIgbWFjaGluZSB0eXBlcyBmb3IgcWVtdS1zeXN0
ZW0tcmlzY3YzMi82NAo+IGJpbmFyaWVzCj4gwqDCoMKgwqDCoCBody9jb3JlOiBBZGQgcmlzY3Zb
MzJ8NjRdIHRvICJub25lIiBtYWNoaW5lCj4gwqDCoMKgwqDCoCBjb25maWdzL3RhcmdldDogSW1w
bGVtZW50IHBlci1iaW5hcnkgVGFyZ2V0SW5mbyBzdHJ1Y3R1cmUgZm9yCj4gcmlzY3YKPiDCoMKg
wqDCoMKgIHRhcmdldC1pbmZvOiBBZGQgdGFyZ2V0X3Jpc2N2NjQoKQo+IMKgwqDCoMKgwqAgdGFy
Z2V0L3Jpc2N2OiBSZXBsYWNlIFRZUEVfUklTQ1ZfQ1BVX0JBU0UKPiDCoMKgwqDCoMKgIHRhcmdl
dC9yaXNjdjogUmVtb3ZlIGlmZGVmcyBpbiBjcHUuaAo+IMKgwqDCoMKgwqAgdGFyZ2V0L3Jpc2N2
OiBSZXBsYWNlIFRBUkdFVF9MT05HX0JJVFMgaW4gaGVhZGVyIGV4cG9zZWQgdG8KPiBjb21tb24g
Y29kZQo+IMKgwqDCoMKgwqAgdGFyZ2V0L3Jpc2N2OiBNb3ZlIHJpc2N2X3BtdV9yZWFkX2N0cigp
IHRvIGludGVybmFsIGNzci5oCj4gaGVhZGVyCj4gwqDCoMKgwqDCoCB0YXJnZXQvcmlzY3Y6IFN0
dWIgb3V0IGt2bSBmdW5jdGlvbnMKPiDCoMKgwqDCoMKgIHRhcmdldC9yaXNjdjogTW92ZSB0YXJn
ZXRfbG9uZy5oIGluY2x1c2lvbiBhd2F5IGZyb20gY3B1LmgKPiDCoMKgwqDCoMKgIGh3L3Jpc2N2
OiBEZWZpbmUgU2lGaXZlIEUvVSBDUFVzIHVzaW5nIHJ1bnRpbWUgY29uZGl0aW9ucwo+IMKgwqDC
oMKgwqAgaHcvcmlzY3Y6IENvbXBpbGUgb25jZQoKQWNrZWQtYnk6IEFsaXN0YWlyIEZyYW5jaXMg
PGFsaXN0YWlyLmZyYW5jaXNAd2RjLmNvbT4KCkFsaXN0YWlyCgo+IAo+IMKgaW5jbHVkZS9ody9y
aXNjdi9tYWNoaW5lcy1xb20uaMKgwqAgfCA1OAo+ICsrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKwo+IMKgaW5jbHVkZS9ody9yaXNjdi9zaWZpdmVfY3B1LmjCoMKgwqDCoCB8
IDMxIC0tLS0tLS0tLS0tLS0tLS0tLS0tLQo+IMKgaW5jbHVkZS9ody9yaXNjdi9zaWZpdmVfZS5o
wqDCoMKgwqDCoMKgIHzCoCAxIC0KPiDCoGluY2x1ZGUvaHcvcmlzY3Yvc2lmaXZlX3UuaMKgwqDC
oMKgwqDCoCB8wqAgMSAtCj4gwqBpbmNsdWRlL3FlbXUvdGFyZ2V0LWluZm8uaMKgwqDCoMKgwqDC
oMKgIHzCoCA3ICsrKysrCj4gwqB0YXJnZXQvcmlzY3YvY3B1LmjCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgfCA0NCArKysrKystLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQo+IMKgdGFyZ2V0
L3Jpc2N2L2NwdV9iaXRzLmjCoMKgwqDCoMKgwqDCoMKgwqDCoCB8wqAgMiAtLQo+IMKgdGFyZ2V0
L3Jpc2N2L2Nzci5owqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHzCoCAzICsrCj4gwqB0
YXJnZXQvcmlzY3YvaW50ZXJuYWxzLmjCoMKgwqDCoMKgwqDCoMKgwqAgfMKgIDEgKwo+IMKgdGFy
Z2V0L3Jpc2N2L3BtdS5owqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHzCoCAyIC0tCj4g
wqBjb25maWdzL3RhcmdldHMvcmlzY3YzMi1zb2Z0bW11LmMgfCAyNiArKysrKysrKysrKysrKysr
KysKPiDCoGNvbmZpZ3MvdGFyZ2V0cy9yaXNjdjY0LXNvZnRtbXUuYyB8IDI2ICsrKysrKysrKysr
KysrKysrKwo+IMKgaHcvY29yZS9udWxsLW1hY2hpbmUuY8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
fMKgIDMgKysKPiDCoGh3L2ludGMvcmlzY3ZfaW1zaWMuY8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCB8wqAgNCArKy0KPiDCoGh3L3Jpc2N2L2Jvc3Rvbi1haWEuY8KgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCB8wqAgMyArLQo+IMKgaHcvcmlzY3YvbWljcm9ibGF6ZS12LWdlbmVyaWMuY8KgwqAgfMKg
IDUgKystLQo+IMKgaHcvcmlzY3YvbWljcm9jaGlwX3Bmc29jLmPCoMKgwqDCoMKgwqDCoCB8wqAg
MiArKwo+IMKgaHcvcmlzY3Yvb3BlbnRpdGFuLmPCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8
wqAgMiArKwo+IMKgaHcvcmlzY3Yvc2hha3RpX2MuY8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgfMKgIDIgKysKPiDCoGh3L3Jpc2N2L3NpZml2ZV9lLmPCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIHzCoCA1ICsrKy0KPiDCoGh3L3Jpc2N2L3NpZml2ZV91LmPCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIHzCoCA5ICsrKystLQo+IMKgaHcvcmlzY3Yvc3Bpa2UuY8KgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKgIDQgKystCj4gwqBody9yaXNjdi92aXJ0LmPCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKgIDUgKysrLQo+IMKgaHcvcmlzY3Yv
eGlhbmdzaGFuX2ttaC5jwqDCoMKgwqDCoMKgwqDCoMKgIHzCoCAyICsrCj4gwqB0YXJnZXQtaW5m
by1xb20uY8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHzCoCA5ICsrKysrKwo+IMKg
dGFyZ2V0LWluZm8uY8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKg
IDUgKysrKwo+IMKgdGFyZ2V0L3Jpc2N2L2NwdS5jwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIHwgMTQgKysrKysrKystLQo+IMKgdGFyZ2V0L3Jpc2N2L2t2bS9rdm0tc3R1Yi5jwqDCoMKg
wqDCoMKgIHwgMjMgKysrKysrKysrKysrKysrKwo+IMKgdGFyZ2V0L3Jpc2N2L21hY2hpbmUuY8Kg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgfCAxNyArKysrKysrKysrKysKPiDCoHRhcmdldC9yaXNjdi9w
bXUuY8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8wqAgMSArCj4gwqBjb25maWdzL3Rh
cmdldHMvbWVzb24uYnVpbGTCoMKgwqDCoMKgwqAgfMKgIDEgKwo+IMKgaHcvcmlzY3YvbWVzb24u
YnVpbGTCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8IDM2ICsrKysrKysrKysrKy0tLS0tLS0t
LS0tLQo+IMKgdGFyZ2V0L3Jpc2N2L2t2bS9tZXNvbi5idWlsZMKgwqDCoMKgwqAgfMKgIDEgKwo+
IMKgMzMgZmlsZXMgY2hhbmdlZCwgMjU0IGluc2VydGlvbnMoKyksIDEwMSBkZWxldGlvbnMoLSkK

