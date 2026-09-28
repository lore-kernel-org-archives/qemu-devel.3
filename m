Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECBC3C9832F
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2026 03:34:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xB286-0004kO-IO; Sun, 27 Sep 2026 23:34:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=724888370=Alistair.Francis@wdc.com>)
 id 1xB27w-0004gw-57
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 23:34:05 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=724888370=Alistair.Francis@wdc.com>)
 id 1xB27u-0005OW-Gz
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 23:34:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1790566442; x=1822102442;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=qfaBK4PhgSk1m+aELgfRNyfN4R529dkQdxj9Dcp7XMI=;
 b=auWYQWfnGIWJDZqsXB5kvYmLoknHcvExiFn5Kp4wlAmcqdjQq/enxI2E
 WSXk35g2+7jMO5y/6PMNYx6KVk99HDlb+wQSXB7WPzmZ58cKj8zPk6PIP
 EtdCHShMWuedCqDI1hEuv7WIT/prDgRqgZ4OfS4aq/htuiHzS9FocWLcD
 hGU+er3QwzaNsesM2EcEgNdHcDOTXxpGib47WMuCtB4xRPFCbPrlDePBy
 584S4HFc4nDasDZobk61n13rDtfZ9trAWQcOucM388W3KOQCmVcYlRMQY
 4NN5F6vnA9m2hknFIa+RlezSj/LOYhDqNLFpkC+STaNUBvpIi8Vs2QPv4 A==;
X-CSE-ConnectionGUID: Lw8DsKzpSLe5AExmqIyGDw==
X-CSE-MsgGUID: 7H5qwcUkR2iAfcjJNAVN+w==
X-IronPort-AV: E=Sophos;i="6.27,127,1786982400"; d="scan'208";a="157647036"
Received: from mail-eastusazon11011050.outbound.protection.outlook.com (HELO
 BL2PR02CU003.outbound.protection.outlook.com) ([52.101.52.50])
 by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 28 Sep 2026 11:34:00 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fNyk/Nok6Udc3EtRrE/PZ7lvvbbaLQEqgi3IcrNcj5xpdsG0BH7xXYiGy1d42tOJawEm4TDrq8fUJAop7VcwY8q3qAW68DBRy0UJPgK+I5tlrk3pWypx1S7CTaC3IAqjMuE57kz7XdLf8UfIaHu0j74mrrCyLUuRalkHJtTG3SfSIcAIG5NlFE4t1gO84zVpG/w8KdWwkX958fX2pl4cjiyfwio6e4JtWrxamVoEXA1Z7dj2pjIxLNp22UyC2yqWHY/fosKQ+o32olpht0wGuPlPjonpZBtSuzs/J73ULd8DFwncWPZga3nDe/nlRVP/zYJHEAKj89sR7aLG8n7RmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qfaBK4PhgSk1m+aELgfRNyfN4R529dkQdxj9Dcp7XMI=;
 b=SIYF8Y2wOhVtlFbUBujQ+xHjayCZUDNKhjYoVqWiCwjQXn2JL/phD7k0Lr1dIrzH8p4jRQ5Il6xWvK9pPrhVGA+e1+lWNxe0jQh6/GLY9isGNUIxy4HlAGdZqVAV3XEHjShGp1wnDLddyGS5tRa0g38ppRvZ/8J53MwVQPCErhWz5vF9fxCF985J6moXO63vMkv7ghIbNpR5Cmn008GvtjCEA8cF+oeURfdZ1Kjcbntv69Zy2f2lgaNWdMx+QushT5VUOgKvxmfKlxmymFhUy4SAVH2vCnDgDmOmEWpgpxwPym3N7PyAG8mUL03RHHBIlV0ng4Gxw2UXllujazrG5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qfaBK4PhgSk1m+aELgfRNyfN4R529dkQdxj9Dcp7XMI=;
 b=E/Dn+grTPo9VL4xC3j6qKN3OpGWsee54HKexC6Hvv+ZL2PKrXFqK0TlJYuX5+phwJB9zTnFVJV4v+7hDrCRh0sBnjG0Gdnn1ONERroT02ifqK6K+UaU9k7jDd7gi5jMQR0oplWsxECK87PiEAwG+qBPmF+wIa7kaRxaxyLDrNz0=
Received: from BY1PR04MB9561.namprd04.prod.outlook.com (2603:10b6:a03:5b6::11)
 by SA3PR04MB8715.namprd04.prod.outlook.com (2603:10b6:806:302::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Mon, 28 Sep
 2026 03:33:58 +0000
Received: from BY1PR04MB9561.namprd04.prod.outlook.com
 ([fe80::3869:e494:2fa8:9888]) by BY1PR04MB9561.namprd04.prod.outlook.com
 ([fe80::3869:e494:2fa8:9888%6]) with mapi id 15.21.0451.022; Mon, 28 Sep 2026
 03:33:58 +0000
From: Alistair Francis <Alistair.Francis@wdc.com>
To: "richard.henderson@linaro.org" <richard.henderson@linaro.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "max.chou@sifive.com" <max.chou@sifive.com>, "palmer@dabbelt.com"
 <palmer@dabbelt.com>, "daniel.barboza@oss.qualcomm.com"
 <daniel.barboza@oss.qualcomm.com>, "philmd@oss.qualcomm.com"
 <philmd@oss.qualcomm.com>
Subject: Re: [PATCH v3 06/11] tcg/riscv64: Assert immediate in range for
 [isu]-type insns
Thread-Topic: [PATCH v3 06/11] tcg/riscv64: Assert immediate in range for
 [isu]-type insns
Thread-Index: AQHdQ90uU2HllmNXZE2Sqr9xvHyAiLbjbKiA
Date: Mon, 28 Sep 2026 03:33:58 +0000
Message-ID: <8913e7a05d0ffba348b9091701f09080f084a79a.camel@wdc.com>
References: <20260914000814.785155-1-richard.henderson@linaro.org>
 <20260914000814.785155-7-richard.henderson@linaro.org>
In-Reply-To: <20260914000814.785155-7-richard.henderson@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.62.0 (by Flathub.org) 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY1PR04MB9561:EE_|SA3PR04MB8715:EE_
x-ms-office365-filtering-correlation-id: 96071d19-0411-4ce5-e742-08df1d1154ee
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|19092799006|1800799024|23010399003|376014|10070799003|366016|10067099003|38070700021|56012099006|11063799006|4143699003|22082099003|18002099003;
x-microsoft-antispam-message-info: KyA+YAf1t96ewDDy4pzguf+FVUwMCAbthwPxAudlHJwDpaXbK6HkchSfiWSK7BBWqJJV3UrAR2lVV6tdDCJ+Kw9IZ09pv9f8FeNMs3BKOOHOP/SdlKJ+rjzqlEART3VJeExdwqenNT5jhi1GjaLyq5XGht28VZZ+NxBLobgEK8017Tq6/xwjVzrE8rFLDJYaIgRjqopHwae0zYC0orqyR4fDtWXWdJNdd7BGE1O/3QVsKwq57YRI0opu8BFdI0VxhbaaGa/b+LwgUx+Ui2Jxp0NvxjA3bApHS+gL2sEJweXfTLQdGV9DKjXO+bRVdCAMkK9PXxsljyHhdt/96jqev76pUZhEEhUNafa6U3sqopC7OhWlnZdfJjvV4/1WQndlYaz8cs94Vd9/UtoXR03RClGnYRq9g8vDclJIrjeNcIVgdj9Ps3PMhxAp1lZ9RhNgypq61bkG4itfBbjVK1+dg9IW3n1/n4JzorUTJt9P+eu4Pkle0gfmYXD6arVK7ihCmsctxyCW4t4Ooq2t7e6S2yoQ+gmEONsRYoHEqmm0cBMi+B4W6A1IVL2ulg3xHFetQr+4MfyopUJzYALj/cfPC3+lmF6HQ2pTCnkHFUkCShgi38yq8R3OoiMuWF1lY7GxReoAe6/tvLDBZ3VVcQcskKL5ASmwo5noR3PdmQySazd0rZQDKDfl3Y/2+i85YQkeS//53nBWylqvhPM3KFa3nLYzulCIlEiK2cK5OdnVCNw=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY1PR04MB9561.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(1800799024)(23010399003)(376014)(10070799003)(366016)(10067099003)(38070700021)(56012099006)(11063799006)(4143699003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?K2w0RGJ0ZlV6WURHcmhNZUlGOVVtYmprNHd5V1IxQmFaa1dhbE15cTNQMlZB?=
 =?utf-8?B?YXdXT25jcmxSc1pmN2JWQUtSUkV0SGpxenZ4R2NRcytKSEVIaEplTGZ6UkNm?=
 =?utf-8?B?YjJSZFZEd2VDT1o0ZEl3ZWtYVzNMejNDS1VDdUQ3Y1RCa2lJMFJmOXFsZmla?=
 =?utf-8?B?MWFpTWRJSGdwOERvektRYlNtLzUwcVdFU01IUlFFazZrZGVBcFZMVktQN2d4?=
 =?utf-8?B?cDhvM1BMYzFOc2Z5b0xsekNTNTlrTkswSTBzeTFtZ2pQb3F1UEdNWENPTXdl?=
 =?utf-8?B?bCtVT0xjb3FsTzhlZGtMazc1L2ZvUUdGUDhMdSswTkFCRWhTdVRVN2J4bTVT?=
 =?utf-8?B?R0FoaWU2N3BJRjJoMWFPY2xoRnZoQmxETG03YThKRWV0aUlqblQ3L1ViZ01s?=
 =?utf-8?B?ZFIxTVRXbG03dlhmejZ3OXJBRVJ6UXpzWTl4aUdueDNtcnVUVVRVMXFWK1dE?=
 =?utf-8?B?bmszTHY2cGpKcmJBZlZERXdTaE9oem5UbVl5TXEydWxBNldGOUo1SmQ3cmdn?=
 =?utf-8?B?ZENGQno1NktueDFGRlpXN2hzUlBIZmNzM0ZVUDFUenpDZXJ5Wm9IMUw2SGNh?=
 =?utf-8?B?cWRlNjJrZzJtL0MvN2Y0dlFQbkdlVk5pYm5DV256VnBVRXpRSlZhMy9Nb1Bu?=
 =?utf-8?B?RVdYc2UwZytpbmx2dVhmU2NQLzgxUU4vZXVZSFYzYVZHVVpRTDFNb2pkRFp6?=
 =?utf-8?B?TXBDbGs3Z25JTHE2SFJEWVpjLzFnRWNSaVNwQkdaMHJiYzl5aEZINWJnY3NM?=
 =?utf-8?B?d1FXSlRIOWljTFR4VStLTjZsMnBGZXNxNm9pZ1lIb0l0SHhuY25HOU9Db2tj?=
 =?utf-8?B?U0ZKQjlBNytJRjNrcGlhNHFwUmtDVzlDc3JqaTJHRE9hZlllRE5oU2h1VmFW?=
 =?utf-8?B?cGxncGE1UnJnM0JDaFphdWFMaENRbzdPc1ZPdm03WVZLcEp4SGw2SXJWZmFw?=
 =?utf-8?B?K0hHS1hEdE41K09sN2lBaDh3WlRMWEFFZzdDMktSUFdjS05PWWt2djJPYXp0?=
 =?utf-8?B?UzJBZlFTNGEvTjBTTDNtMzh0b09mOFhhM2lXdEN0Zm51SGN5bU94a0ROc3pT?=
 =?utf-8?B?TmdrZThndVEwQXRSNG9vSzhndWdyZDRzQzNHblZ6b3p4NXBCelArRllHdU1G?=
 =?utf-8?B?U0ZNN3BUcDVwWGN1dklYaEhBcWRmK25KUGVXbHpyWFF6dE51ai9IVkZ3ajR6?=
 =?utf-8?B?Y29kYWFMck1uT1RZa0J4K2NQN3Y1V0c2NzRNeDFhYXgyZW8zSEc3Qm9jbXRn?=
 =?utf-8?B?RzAzOWNHMTI5SFlaVUNMUG12UTJTVmlzdEZUdFNBRFpJZlJpVTV5K2lPYzRy?=
 =?utf-8?B?cm0vcm93L3NEeWkzOXdWWEZCTEhtL0pOTEViUmswc1ZSam9qTVRMamc2SHdB?=
 =?utf-8?B?STNpazA2UCtFQ0NTTU96R09CNHBESkY4S3hmQ3Y5VXJCbWVKK2tQLzBMY0oz?=
 =?utf-8?B?dHJLZ0lKVTVUdFFJMWtFRGpZd09ScXFmWDZkZWZxVGpXSUFaZ1hrdnQ1TFIx?=
 =?utf-8?B?QkVVL0Z4QjUyd2grUEJhLzhnbVh6di9FamcwZXh4YVJpNlkxUXFkUHFWYzdM?=
 =?utf-8?B?UFFuYVcxVkkrdzVGbm1NcGk5eUpBK3BqOGdMM29uTGE3bXN5QktXV2U5SVRT?=
 =?utf-8?B?U2YzSTZ0Zm1RYTkycHRDODRYT1JvSExkL2x3eHliV09IOUdxNnBUQkVTcHdx?=
 =?utf-8?B?T3RFcm8wT1d2WXlLb1JzMFUyb3NBL1hxV1dTRUdNRmxXeTJQck9JSk1iZ2tW?=
 =?utf-8?B?MExSZ2M5R2IzZnZzY05kS3FwcDlGTmxsaDZkWWZZTmtwaXhiM21hYkJOVUhl?=
 =?utf-8?B?NzFZSUl1L3F1QjFFNWNyNWZlWDFPWDk4Z2R6YjhvOTcwVkl4dTdocE1ocllW?=
 =?utf-8?B?Ny9rNS9RZXZ1YjhJQWFkN0V5RGVsV1BZUlE2bjRKU3pOaFhxa1pGQ1pBQWFq?=
 =?utf-8?B?b1A0U2J2R3daMlhraVFmQkM0dTBDdVB2Mi9menhOb3ptT1JyaUw5ckYvNTF1?=
 =?utf-8?B?Vncyei9iZlBlL3ByY1pPR3NEaUJ4WWpFQWUyMTNwWGhRdm10MGsvanZhWjgy?=
 =?utf-8?B?ZjRLeWZjcTdzWGw1UExvS2tCNEJVd2JiL1hTVEV0OFJrUmdhV0VVUXNkZno2?=
 =?utf-8?B?U25WbjI3Qk52VDVqY3F5b0kxUW5ZcmhIN0JxTXlxNW0vYTg3T3cwbVQ4RVND?=
 =?utf-8?B?NUlBK1N4NU8zNWF5ZVkzRW5OcnViN0dldEFzVGdIWU5lVmg1WE10L3A3OC9J?=
 =?utf-8?B?VC9rMDBhRFJuc3Z3dlRhaStCSk9USkNLc09oTW0rUVJCeHZvcXNCTmp6b1Ru?=
 =?utf-8?B?VHZhQjNEOThkamR4Q3hiem42emoyZFF5TnloWGtmM28ya0h4NlN5dmdVV1p4?=
 =?utf-8?Q?r8LU81H2RDy7CPgalVbtA/t9jwkVv9ZInfR9VCG8NgIen?=
x-ms-exchange-antispam-messagedata-1: jXJEPCPaENYOyv4fqQMWRYVMky/RcK3RxyI=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EBF7D4C0328EB24A9D3B9ECFEC7EE856@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: NAHM3dYlrKSs4tRCUCxUNkA6kF6MF0CSIcqTkLlUV0Z+d9LKhUI0CXu6sTsXQhIC6Jmb6yl/X0SUPnl+16bJ/B+dzYrAock0rN9nCaOgiq74N0LBSLevDm0PQKwZq+FAG19BCGa+6dmJziTqcnI2YNc/LfWkae5ZGzXdGg4joEFudyQZus0M81idhBf6UhpYX0H9EUavs9nyQ1SxWvY5K3sbE+Qh6iWSO3NwZsamQQ4a1yunI6HXSKZrxqurb6XejiJJ3W3CiGf/XlOJVeAsVN26vqCbTwgTwNNbydlmeIOE/+y/tP7Fv2rlf7KvmSP/hn/i1QO1tpFq5NxOIc/O+g==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: vxvC9a9HRERWdNA805pBSS8f0/OJ7SlrL1Sqii+haFTcXIT3wLUWMZniK1hkHizYZwcDP57RghWOhQ7SShGJx2+/iGIg98F49meAqnsAtoHTFGWBQLYHexKu0pEimjilgVHe7XX5bntt3NGOOEdpWBkk+B4gDEjXW9CWoE1v2MT4IgB84eDgEwi8x8TdBM7aFLRPHnMFktCOUV8dI6A8JgzoU6rmRhUXSCX7o72cvkFkyCOW0Ecp13CqxIpUlsQemXvQAZKqhjI6JGMNn8LIM7V5wMKE1/6FznZEsGVjuf/o1tiR6q7Bcq+3yhEzLcT2BS67jI6BfjBZz0kUGRe6PwdgmzN6obUBo2akh8peGBzlpHepjf3XbbCLVNB1yLt/+4CyAjzTO5h0M3C3ubhC5Pr+vvjpl/lCCjpmZrpim52kK0u8ARXI9JFwj+hEShj8Sk77SaKLgz0yFpCKGwKUJ9sOw4iulcMXpghLws698KqjGtDq4n2V/wnbNQjPGOtpJCPkPHQDMhwHhBI7vj6SXZx83uQURXHp13LoTC8u5K0Y9gaqeTklAGbKSgdCO0MG3okVIcjEEeGrJyMTfdmzTQbT/5oIh9YHaP5CrzPC0T/6XegbDLQDXqo3oDxm5YiH
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY1PR04MB9561.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96071d19-0411-4ce5-e742-08df1d1154ee
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Sep 2026 03:33:58.6104 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sgIHRK8fzB7UeohGmQZvvEy2Kk+sM05ZYuTGdS1GeN3OygPAfOainlC6UkHAwOwps0sinP0JytkBEm+5XAV/MicpRqRJmCxHBEvLoGEFuog=
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
ZToNCj4gU2lnbmVkLW9mZi1ieTogUmljaGFyZCBIZW5kZXJzb24gPHJpY2hhcmQuaGVuZGVyc29u
QGxpbmFyby5vcmc+DQoNClJldmlld2VkLWJ5OiBBbGlzdGFpciBGcmFuY2lzIDxhbGlzdGFpci5m
cmFuY2lzQHdkYy5jb20+DQoNCkFsaXN0YWlyDQoNCj4gLS0tDQo+IMKgdGNnL3Jpc2N2NjQvdGNn
LXRhcmdldC5jLmluYyB8IDUgKysrKy0NCj4gwqAxIGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRpb25z
KCspLCAxIGRlbGV0aW9uKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvdGNnL3Jpc2N2NjQvdGNnLXRh
cmdldC5jLmluYyBiL3RjZy9yaXNjdjY0L3RjZy0NCj4gdGFyZ2V0LmMuaW5jDQo+IGluZGV4IGQw
YzlkOGU5Y2QyLi5hNWVkMWU5NTcyMiAxMDA2NDQNCj4gLS0tIGEvdGNnL3Jpc2N2NjQvdGNnLXRh
cmdldC5jLmluYw0KPiArKysgYi90Y2cvcmlzY3Y2NC90Y2ctdGFyZ2V0LmMuaW5jDQo+IEBAIC00
NDcsNiArNDQ3LDcgQEAgc3RhdGljIHRjZ19pbnNuX3VuaXQgZW5jb2RlX3IoUklTQ1ZJbnNuIG9w
YywNCj4gVENHUmVnIHJkLCBUQ0dSZWcgcnMxLCBUQ0dSZWcgcnMyKQ0KPiDCoA0KPiDCoHN0YXRp
YyB0Y2dfaW5zbl91bml0IGVuY29kZV9pbW0xMih0Y2dfdGFyZ2V0X2xvbmcgaW1tKQ0KPiDCoHsN
Cj4gK8KgwqDCoCB0Y2dfZGVidWdfYXNzZXJ0KGltbSA9PSBzZXh0cmFjdDMyKGltbSwgMCwgMTIp
KTsNCj4gwqDCoMKgwqAgcmV0dXJuIChpbW0gJiAweGZmZikgPDwgMjA7DQo+IMKgfQ0KPiDCoA0K
PiBAQCAtNDYyLDYgKzQ2Myw3IEBAIHN0YXRpYyB0Y2dfaW5zbl91bml0DQo+IGVuY29kZV9zaW1t
MTIodGNnX3RhcmdldF9sb25nIGltbSkNCj4gwqB7DQo+IMKgwqDCoMKgIHRjZ19pbnNuX3VuaXQg
cmV0ID0gMDsNCj4gwqANCj4gK8KgwqDCoCB0Y2dfZGVidWdfYXNzZXJ0KGltbSA9PSBzZXh0cmFj
dDMyKGltbSwgMCwgMTIpKTsNCj4gwqDCoMKgwqAgcmV0IHw9IChpbW0gJiAweEZFMCkgPDwgMjA7
DQo+IMKgwqDCoMKgIHJldCB8PSAoaW1tICYgMHgxRikgPDwgNzsNCj4gwqANCj4gQEAgLTQ5OCw3
ICs1MDAsOCBAQCBzdGF0aWMgdGNnX2luc25fdW5pdCBlbmNvZGVfYihSSVNDVkluc24gb3BjLA0K
PiBUQ0dSZWcgcnMxLA0KPiDCoA0KPiDCoHN0YXRpYyB0Y2dfaW5zbl91bml0IGVuY29kZV91aW1t
MjAodGNnX3RhcmdldF9sb25nIGltbSkNCj4gwqB7DQo+IC3CoMKgwqAgcmV0dXJuIGltbSAmIDB4
ZmZmZmYwMDA7DQo+ICvCoMKgwqAgdGNnX2RlYnVnX2Fzc2VydChpbW0gPT0gKGludDMyX3QpaW1t
ICYmIChpbW0gJiAweGZmZikgPT0gMCk7DQo+ICvCoMKgwqAgcmV0dXJuIGltbSAmIDB4ZmZmZmYw
MDB1Ow0KPiDCoH0NCj4gwqANCj4gwqBzdGF0aWMgdGNnX2luc25fdW5pdCBlbmNvZGVfdShSSVND
Vkluc24gb3BjLCBUQ0dSZWcgcmQsDQo+IHRjZ190YXJnZXRfbG9uZyBpbW0pDQo=

