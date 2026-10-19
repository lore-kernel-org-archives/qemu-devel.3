Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24DC0CCF2D4
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2026 02:53:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIdUU-0003kY-Og; Sun, 18 Oct 2026 22:52:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=7454c2a62=Alistair.Francis@wdc.com>)
 id 1xIdUS-0003kJ-7G; Sun, 18 Oct 2026 22:52:44 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=7454c2a62=Alistair.Francis@wdc.com>)
 id 1xIdUQ-0003vm-5H; Sun, 18 Oct 2026 22:52:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1792378362; x=1823914362;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=yjToDrICI4NRBVTk/T4PwCtnCobAayU0LHz7KwURkIg=;
 b=J5xBUyYLOm3I8Use0KeyZfCyX9s6Dj1BHVaBYYklCaMjyTA/Lx2GizRZ
 XUYkgD/TiFnywq3xAryMNcuJ4wLtiFzcFihBDtZBDxNNHtxjpFztSqSW3
 YH8hxLvtlkVJQai91bEzdEtFDP/6FjFyYwRzCh8W3YdzoYF/gLPPDQ8CZ
 Er7RT47NX2KfW4PwhJgRbm2ir3akDLdZFSualNqVUa8UYlLA7/MW1JRYA
 cONYH08LOC6uLZUTvEsk5DqHz+eJwfSvYiwn+26jSCcyhCVppXGUOZ0HG
 zmmQLGENtvnGHIguG9W/6RUZVHpUHpACrQZV4RuOPxrneNgGXy4LzrhFw A==;
X-CSE-ConnectionGUID: Y04/qZ3QTmC67+xc8nXK1g==
X-CSE-MsgGUID: tBBWkl7OTT2L5KulaViLDQ==
X-IronPort-AV: E=Sophos;i="6.27,166,1786982400"; d="scan'208";a="154190378"
Received: from mail-westus2azon11012016.outbound.protection.outlook.com (HELO
 MW6PR02CU001.outbound.protection.outlook.com) ([52.101.48.16])
 by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 19 Oct 2026 10:52:38 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Al+u+wTq/y8l2LdfLUwDO9r7qjU2I7M4B+nAqrk2A+31heKYrd+T42sYPnLsje0Smkqa1/zuyIcu3xjnT6vx8zE/55DVpDtIkQYIR57eY2idZE/gbWtrksoQ+9N2UbPlcJkL9TSjCpSTJn0YDU34aOENJPsYvgWc1kdnlYRazaRRgyz3rStECOrG793S/kCx1hfq7wdg6W1SBFlRSH+0urMvCWgCJ/bIK4YCoCJLGBeX2Sn6mVuhY0sXhXlrsCcMnuOvBq3PP/ZDfU5NnOX+XFdpWH/aeYW0Siaavl8LCeej0eP2GlH6Fut5YXxi7gIqd8VuZjcUaCm3reFpGvn/BQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yjToDrICI4NRBVTk/T4PwCtnCobAayU0LHz7KwURkIg=;
 b=bZ2U3dFELetie2nroQuereJPhSNccvDUWlAuXC4OcuudD1qOygVEaxLdYar3Bq+qjggb1BeFj2rACPaWE3qhr+816UCxJiFBDnXZXmEhHwSrZKld/uyrcV9swh44HgvcWe4lcDnwKEUCFZtEd70rsBpf++1h881qOtesfQo4SN1pHxDzCloVJNXEGMToK0wYxc1lA55F+9WEsznt/llJpy/Hc+yRl/K3GF7POT5D0k8lnZifGc4fKoIKlbQG4qPhZVJhvqN5iHJRulWBZyH9dHnNwna/Kw7H46ixEm3KuGH9/NSmfSkaB42Rw5TofuTdRZozXCmfBVoqyt62zA6wNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yjToDrICI4NRBVTk/T4PwCtnCobAayU0LHz7KwURkIg=;
 b=DWCW8JLUXWCBdG7xufcFtnkSSiyFVqF89ZgLPXxkzwGTb6/MtPFTajEj7+qcs9jltpzvDWKkRGzJW/AxfrpdJWV0x1FUngAScmPJq91ZowNt7l3b8OuTtX3n/iSsbfPFZ92qKDSNxrapvy59ywjVm1uGMxHVAMjkp4JFwWlXhb4=
Received: from MN6PR04MB9359.namprd04.prod.outlook.com (2603:10b6:208:4f2::13)
 by CH2PR04MB6789.namprd04.prod.outlook.com (2603:10b6:610:a0::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.15; Mon, 19 Oct
 2026 02:52:36 +0000
Received: from MN6PR04MB9359.namprd04.prod.outlook.com
 ([fe80::e729:bbef:5a37:2e77]) by MN6PR04MB9359.namprd04.prod.outlook.com
 ([fe80::e729:bbef:5a37:2e77%4]) with mapi id 15.21.0522.017; Mon, 19 Oct 2026
 02:52:36 +0000
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
Thread-Index: AQHdTPc7X6lEbkfz1EO+RaWUOqZyGbcET9uA
Date: Mon, 19 Oct 2026 02:52:36 +0000
Message-ID: <1a97cc314a69c935f0b46452fe1a778b5d1c7c13.camel@wdc.com>
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
x-ms-traffictypediagnostic: MN6PR04MB9359:EE_|CH2PR04MB6789:EE_
x-ms-office365-filtering-correlation-id: d2b230d9-fade-4f3b-9e7b-08df2d8c07f4
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|19092799006|376014|1800799024|23010399003|366016|10070799003|10067099003|18002099003|22082099003|11063799006|260925021911599003|260925021311599003|260925022911599003|261009223027099003|38070700021|56012099006;
x-microsoft-antispam-message-info: NF6denGyy4YkBdn4tGDxzLL4ebjdYfP+vdQxuRlIPQWwryQIYQmoVcFrboy/PWoR6bWwRfPqgV+2MPGKJKEDHwbC/4C0UhT098harrVtXLFncpfHEnxCvKlxh55VyT5M+5R/bfd9CVfIWaau2sRrHc1HMXDzClOJQx5QeDoFfbVewn26EZTc4J8aZF6maVx/plXEFvJEqjyHEa9v0jKLkaTyJwaiThl2jmkg7nLrtW7EXBWvBtcLv4iOb3aUh2X/sFJp5cAnNUSZdac3bXORDTvCbZGw+m75DsrHZQMRUdySGUUe2NDEU9yIvXm0o8Wqh/djQeSBwU9QHvASM6SXeJxTxhTj9vdZFLLOKgtADqfFmRqat/7HUsvCX70koMLOjznu+PTgmbHl6UnPePfkA01qrC7u13v90f70s2iSXU4yDXEA3q4E1atx0Z5jdG3ACCJZJOeaiV/USkgcZvuvjSeTOxxg/7wTQl964lC68cjqii6FFwaDGcnMDno2CWwMeBEYoY9nlVrJj+LbDeWa7Xfaw8DUGKnXOKliDoywxE9RrU+I3uwzwkYN8NazoLHxKPpKJozK0q1xOtyfE+3m7+SXWv82vBrpr3jKkL9KPMOygTFMYHHCNnXX4SbAll3JgG5PITAUqEBehwLPDAz1yskHtdaEu2M7Ag47TTjT4sg=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN6PR04MB9359.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(376014)(1800799024)(23010399003)(366016)(10070799003)(10067099003)(18002099003)(22082099003)(11063799006)(260925021911599003)(260925021311599003)(260925022911599003)(261009223027099003)(38070700021)(56012099006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OHB2UVQ5Uk92dDNzL2dTcnpXeE54TWFRU0szUHFDWWhybEo0QmhZYnYzbjRY?=
 =?utf-8?B?akU2b21BaThnUmdjYzZqaXcramFXb2s0Nm9UTTQrUEhGdlJQcVJuNDl2emRP?=
 =?utf-8?B?WnZ1cmxMRTVaZWZHZllEOUxQSUVFYnltOW9nUUROTU9tVTVFbHpYeWJsR0I3?=
 =?utf-8?B?VW5KcGhmVEV2VWI1UnQwQlFUSDJpaDhCekRwTXlMN3F1dUsza2svY0grWW9p?=
 =?utf-8?B?STExWkRHS3h6c2lzMCs0RU1UUDA1bjV0N083cWwyT1FkYmVvVkVsMnQzOUpi?=
 =?utf-8?B?Ny9iLy9Hanp6T2I3T2VacmZBblBTVkt6WDhrNGdlQ1Y3eWdLbUZld0ttMHpL?=
 =?utf-8?B?RnF3RzlQbGMxa0JsRDJjZ1JaY1JzMVVDMUJBZ1NNeXpIdXJtUjlKTmdVV2RK?=
 =?utf-8?B?MlVvM1FZUTN6TWFibFJMdlV6RTc2QmM3K2w2cVdTMzVnR01XcWptOHdMZEJW?=
 =?utf-8?B?TGh2eWZ2YWpHcWFDR0tuUHFielNlT3JXRUpjQms0WTRoMXVEQ2w4OEJxSWJz?=
 =?utf-8?B?cWRlczM1ZWJOZDg4UXJyeXpENG1sRVExQ0NhYldkYkV6MUZ6OFBrSHA3OWkz?=
 =?utf-8?B?SmFtYVE2S2FGdm9xNG9DVDIvSWNvbXlodlRybFJIVmI5V3FDWm5URTlMMzlq?=
 =?utf-8?B?OEw0M3kxd2Z3dURnODViQm9HdHFQTWZoMEhKRXkwcENvTlRtRnpaeU9HYWc3?=
 =?utf-8?B?UUljYnhhUXJrbmlienFQWlhiVkJoMmlzY3pTUFhFRWdRbzFSZnQwZnc2WG52?=
 =?utf-8?B?SlkrRktTdXFDcTdvai9rTkpkd21LRE9tYXFSRGtzOE02Y2tUWk15MFltZlVw?=
 =?utf-8?B?ZlhqcUhIbDdmRmZTM2thNkl4OVYvRTlhN21iaDFYQnVTUis5TjAzdFpIUjRa?=
 =?utf-8?B?b3pQc01kZ0Y5ejdLQ01xYTUyc0xkbU9UQ0hlcGlidER2dm93TFNZMld1eGI2?=
 =?utf-8?B?eDhtSWdCNnZmT0tNNWg4Q0xqWThkTi9RYzFxbU9FdkJnVnRQL2ZaTHkrQWhm?=
 =?utf-8?B?ellCWkFjR052eGNPeEtJK2RIVWdFYm9BNm1iaGpVWXVHTmd1cXRKeWRBdk8y?=
 =?utf-8?B?c1U5N1hyQTNsdnZrNkpxYlZYU2hKLzBNM1ZZdFR0d0taVk93THBwVHE5WW9O?=
 =?utf-8?B?UFQ5R0lNQ0pQSVlNM2FsRGQ5N2JZUitQTW42SHh5OVptaUEzRXE3ZGw5WGpk?=
 =?utf-8?B?R21PREt4dzltYnBoNVdzT2J2bHR4WXlDOENLdTlwMFhsOXZQZVdXb3kxZXYv?=
 =?utf-8?B?d3VueEFXUWRiT2hublZHRlpvaEFDWk5nNkdkQ1plNUtpejhURk01b0dOYVBt?=
 =?utf-8?B?dmxERFlBWjBFNGxZVEU4RFFGcnk5R2tCdGxHZnFQamlzY1JXNWRRTGxXRENn?=
 =?utf-8?B?aG0vZmJ5a3hxa3orUnNFQ2w4UlhEOTVyamYwZnRvUERJQTVhY0R4OVZEejAx?=
 =?utf-8?B?K3BVMHpvY0dhWEF4bWhWMXJSV3hBUzBsTjZvblN3VGgweFNPK09Gd2xKbnZs?=
 =?utf-8?B?Qkh4RzdVdVczOVo3WUY2aDZudnYxV0ZHQU8rQmpuK2lvLy94WXlpc0gvNzk1?=
 =?utf-8?B?alk4R2szTHFiaFpXQ2xKRXZmcnROT0RiK2M1c1J5MnI5bEpZczYrZ01CR3pa?=
 =?utf-8?B?VU9xc1puM2k0L09ZTFhPTlhXa3M5bVRJZjZBazJmbC9NaTRYUW5UdllaYWVI?=
 =?utf-8?B?ZW50ZGIyVFN1NmJ0Tm5CM04yM21LM3FITEpwV3h0VW5kSUFZQUFLRCtCSW1G?=
 =?utf-8?B?bTRqUWVaUU9QQ1J1dzhHYjBZVmRNM3BhZjZNTm9McjFVKzl2NGkzOTcxeDVR?=
 =?utf-8?B?U3RGYnRYeGhJdGc4d1hZT2IxRG0wKzd5a1k4ZGc4a3N1S0lnNXVrTFpPMnZs?=
 =?utf-8?B?MDl4MjhPMkZ0eDVZN1BkSlhjcFJuVTRIZEJnY3lUNDlQOUZ5cThZcURnY25H?=
 =?utf-8?B?cWpvYlIzV0htOWh1U2EvZ1p2Uy9EZERHT24wUkMyZTRkNEZxTFRjTU9YU3E4?=
 =?utf-8?B?V21aSXNDdDNZMWxjajFhdTdQMEQ1THg3dVNqaHJVS0lQSzFNQ21XWkFHQUJz?=
 =?utf-8?B?b3ZzYXg0OHpDVm1rYW5lVFVHVHlJN09GUUJ2UzBSRTVmNmZMT0tHSFY1TWpu?=
 =?utf-8?B?RGdUeHBVYXo4eTRLRHphdEl1d1J1b2pTUW1RZldheXArZElLVlFYYU1XNnR0?=
 =?utf-8?B?QlZPcGhwZS8xbCtud3dnTENKUGtYMzg3M1BLQ2FUMkZQRnFVajFFSDZ3Zjlj?=
 =?utf-8?B?bjNReEdPbFB5STU5ZlpxZ2VtV1JDa2JKQ2RkckJwWWQwcnUya1ZmWkw5Umls?=
 =?utf-8?B?ZUhDeTgyWlJvMys5eloxZU9VQkNSc3M3c01WelhVYjBHRWswbFlMRFYrcUZn?=
 =?utf-8?Q?y4PUpt3w9N6sUhIGlY4JxGfrXhPLACraYb7Qz2Ybtt7an?=
x-ms-exchange-antispam-messagedata-1: K0SxJU71t2u5KtREoFYSXS+Mh1JJ62VciLs=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B21837023B89AA40BFF9B79EB27A968D@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: M/iotD8Yod3gcXtQASVXAgLC1i9ChqDic+gClsLbM7X8vOyPK/RC6IXG5Qn/9a+Ici9NfOQglt2gH2wFftcWIuhfEtQIpYqagzHmaVIbKl4b+tlyldbV3gutGgvmzyQBiETHJMArI+CRZYjtGuGg55BvaX/u8Ol6h0yq4B6RIBKl0hHFrmlMO+WaLfvCogIon1STs8Hb0yuePk6n5rr4+BQjhjgsNtDelEQijC34AreYFsyAiJSglUvWbqe9JjTHA4PNWGptX/olXTYfNPR+Gv3cJPAZDzzllWxmZDw5zQoBMJtf7/P9LR0slAkqZjsqlo/6nwR94+52S5bNggUp7Q==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: ecxydLytRzfcdvhps0+zbAZNI0xp8giqqPT1mw7qvThwo+6OsDIzoY8kYmM67MyTgGhTdYv9o/EqrtAwkc9peamhQqTDHFxg0ifLUKXBhejwgeVA/mWTi8Rz+NXTPMhDg09UPMnWsyWzxFY+RtQ8tn0pR09u9UPr/W7fZRFT1q0zz3dVHqNYPiWtvKom0AcKzjM7JVG3Nm03ZyMt0aWq5jjYuom2bgAUpDr3nAlZf+njv/GM5WKwUeuUU1rxURnbPRSSQAPLe4jCjm59JHmsFB+xucskgquUrUW3KNIrZV0zTKzFN82hRLAB/i0wF5w0+N4Fvuluc8mhKziLrFYBBOAYFpmAl+qRLr2xZGjnydt+EtjKe+jhgGakNcjxleigPXmyyF+SQ7uU5UXG32B5v+Fhhto/fiFqzwcGYeN8ez4EWac/NPgZ9wQCQ9v/vhwldklV9aPMfxXqDZzDb+DTyMzuyY5P+JRcvT2ixXM+E/tAVyAxFXyQgMqzw3Q89945Q71jh3gJYMa+jW/9baqAFYUJB0wkSOeWOntrC7QG8p8iHRsQ5FLb2vlip9secIsaWOT2PVf0w40uL3mhT7z9Ynv3qcvCmm8fnhRG4GqB3RLTtzeE9CUt1tixK47WXh6H
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN6PR04MB9359.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2b230d9-fade-4f3b-9e7b-08df2d8c07f4
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Oct 2026 02:52:36.1701 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AqhutS5kOihd/gPDs1dv1Bf9pgh7lRoGZfy1v5I1vpJ9Kh2DbrPRYNu9ecFhc7HTHE8K+cvGXofimR4wGFHIidVgc7s9q3bHw5p5RceaHrw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR04MB6789
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
aHVuY2hhbyBIdSA8aHVzaHVuY2hhb0Bib3NjLmFjLmNuPg0KPiAtLS0NCj4gQ2hhbmdlcyBpbiB2
MjoNCj4gLSBSZXdvcmQgdGhlIGNvbW1lbnQgdG8gY2xhcmlmeSB0aGF0IHJldGFpbmluZyB0aGUg
cHJldmlvdXMgTU9ERSBpcw0KPiDCoCBRRU1VJ3MgV0FSTCBsZWdhbGl6YXRpb24gY2hvaWNlLCBu
b3QgYSByZXF1aXJlbWVudCBvZiB0aGUgc3BlYy4NCj4gLSBMaW5rIHRvIHYxOg0KPiBodHRwczov
L2xvcmUua2VybmVsLm9yZy9xZW11LWRldmVsLzIwMjYwOTIwLXJpc2N2LWhnYXRwLXdhcmwtdjEt
MS0yZTUyZjc4YzgwMjdAYm9zYy5hYy5jbg0KPiANCj4gVG86IHFlbXUtZGV2ZWxAbm9uZ251Lm9y
Zw0KPiBDYzogUGFsbWVyIERhYmJlbHQgPHBhbG1lckBkYWJiZWx0LmNvbT4NCj4gQ2M6IEFsaXN0
YWlyIEZyYW5jaXMgPGFsaXN0YWlyLmZyYW5jaXNAd2RjLmNvbT4NCj4gQ2M6IFdlaXdlaSBMaSA8
bGl3ZWkxNTE4QGdtYWlsLmNvbT4NCj4gQ2M6IERhbmllbCBIZW5yaXF1ZSBCYXJib3phIDxkYW5p
ZWwuYmFyYm96YUBvc3MucXVhbGNvbW0uY29tPg0KPiBDYzogTGl1IFpoaXdlaSA8emhpd2VpX2xp
dUBsaW51eC5hbGliYWJhLmNvbT4NCj4gQ2M6IENoYW8gTGl1IDxjaGFvLmxpdUBwcm9jZXNzbWlz
c2lvbi5jb20+DQo+IENjOiBxZW11LXJpc2N2QG5vbmdudS5vcmcNCj4gLS0tDQo+IMKgdGFyZ2V0
L3Jpc2N2L2NwdV9iaXRzLmggfMKgIDggKysrKysrKysNCj4gwqB0YXJnZXQvcmlzY3YvdGNnL2Nz
ci5jwqAgfCA0Ng0KPiArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
Ky0tDQo+IMKgMiBmaWxlcyBjaGFuZ2VkLCA1MiBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygt
KQ0KPiANCj4gZGlmZiAtLWdpdCBhL3RhcmdldC9yaXNjdi9jcHVfYml0cy5oIGIvdGFyZ2V0L3Jp
c2N2L2NwdV9iaXRzLmgNCj4gaW5kZXggYzAxMDUwY2UyYi4uYzRhOTE0NDExYiAxMDA2NDQNCj4g
LS0tIGEvdGFyZ2V0L3Jpc2N2L2NwdV9iaXRzLmgNCj4gKysrIGIvdGFyZ2V0L3Jpc2N2L2NwdV9i
aXRzLmgNCj4gQEAgLTcxMSw2ICs3MTEsMTQgQEAgdHlwZWRlZiBlbnVtIHsNCj4gwqAjZGVmaW5l
IFNBVFA2NF9BU0lEwqDCoMKgwqDCoMKgwqDCoCAweDBGRkZGMDAwMDAwMDAwMDBVTEwNCj4gwqAj
ZGVmaW5lIFNBVFA2NF9QUE7CoMKgwqDCoMKgwqDCoMKgwqAgMHgwMDAwMEZGRkZGRkZGRkZGVUxM
DQo+IMKgDQo+ICsvKiBoZ2F0cCBDU1IgZmllbGQgbWFza3MgKi8NCj4gKyNkZWZpbmUgSEdBVFAz
Ml9NT0RFwqDCoMKgwqDCoMKgwqAgU0FUUDMyX01PREUNCj4gKyNkZWZpbmUgSEdBVFAzMl9WTUlE
wqDCoMKgwqDCoMKgwqAgMHgxRkMwMDAwMA0KPiArI2RlZmluZSBIR0FUUDMyX1BQTsKgwqDCoMKg
wqDCoMKgwqAgU0FUUDMyX1BQTg0KPiArI2RlZmluZSBIR0FUUDY0X01PREXCoMKgwqDCoMKgwqDC
oCBTQVRQNjRfTU9ERQ0KPiArI2RlZmluZSBIR0FUUDY0X1ZNSUTCoMKgwqDCoMKgwqDCoCAweDAz
RkZGMDAwMDAwMDAwMDBVTEwNCj4gKyNkZWZpbmUgSEdBVFA2NF9QUE7CoMKgwqDCoMKgwqDCoMKg
IFNBVFA2NF9QUE4NCj4gKw0KPiDCoC8qIFJOTUkgbW5zdGF0dXMgQ1NSIG1hc2sgKi8NCj4gwqAj
ZGVmaW5lIE1OU1RBVFVTX05NSUXCoMKgwqDCoMKgwqAgMHgwMDAwMDAwOA0KPiDCoCNkZWZpbmUg
TU5TVEFUVVNfTU5QVsKgwqDCoMKgwqDCoCAweDAwMDAwMDgwDQo+IGRpZmYgLS1naXQgYS90YXJn
ZXQvcmlzY3YvdGNnL2Nzci5jIGIvdGFyZ2V0L3Jpc2N2L3RjZy9jc3IuYw0KPiBpbmRleCAwNjFi
YzlkYjc3Li5mYzdiZDYxMDczIDEwMDY0NA0KPiAtLS0gYS90YXJnZXQvcmlzY3YvdGNnL2Nzci5j
DQo+ICsrKyBiL3RhcmdldC9yaXNjdi90Y2cvY3NyLmMNCj4gQEAgLTUwNTAsMTcgKzUwNTAsNTkg
QEAgc3RhdGljIFJJU0NWRXhjZXB0aW9uDQo+IHJlYWRfaGdlaXAoQ1BVUklTQ1ZTdGF0ZSAqZW52
LCBpbnQgY3Nybm8sDQo+IMKgwqDCoMKgIHJldHVybiBSSVNDVl9FWENQX05PTkU7DQo+IMKgfQ0K
PiDCoA0KPiArc3RhdGljIHRhcmdldF91bG9uZyBoZ2F0cF9tYXNrKENQVVJJU0NWU3RhdGUgKmVu
dikNCj4gK3sNCj4gK8KgwqDCoCB0YXJnZXRfdWxvbmcgbWFzazsNCj4gKw0KPiArwqDCoMKgIGlm
IChyaXNjdl9jcHVfbXhsKGVudikgPT0gTVhMX1JWMzIpIHsNCj4gK8KgwqDCoMKgwqDCoMKgIG1h
c2sgPSBIR0FUUDMyX01PREUgfCBIR0FUUDMyX1ZNSUQgfCBIR0FUUDMyX1BQTjsNCj4gK8KgwqDC
oCB9IGVsc2Ugew0KPiArwqDCoMKgwqDCoMKgwqAgbWFzayA9IEhHQVRQNjRfTU9ERSB8IEhHQVRQ
NjRfVk1JRCB8IEhHQVRQNjRfUFBOOw0KPiArwqDCoMKgIH0NCg0KVGhpcyBmYWlscyB0byBidWls
ZDoNCg0KSW4gZmlsZSBpbmNsdWRlZCBmcm9tIC4uL3RhcmdldC9yaXNjdi9jcHUuaDozMywNCiAg
ICAgICAgICAgICAgICAgZnJvbSAuLi90YXJnZXQvcmlzY3YvdGNnL2Nzci5jOjIzOg0KLi4vdGFy
Z2V0L3Jpc2N2L3RjZy9jc3IuYzogSW4gZnVuY3Rpb24g4oCYaGdhdHBfbWFza+KAmToNCi4uL3Rh
cmdldC9yaXNjdi9jcHVfYml0cy5oOjc0MzoyOTogZXJyb3I6IGNvbnZlcnNpb24gZnJvbSDigJhs
b25nIGxvbmcNCnVuc2lnbmVkIGludOKAmSB0byDigJh0YXJnZXRfdWxvbmfigJkge2FrYSDigJh1
bnNpZ25lZCBpbnTigJl9IGNoYW5nZXMgdmFsdWUgZnJvbQ0K4oCYMTc1ODIwNTI5NDUyNTQ0MTYz
ODPigJkgdG8g4oCYNDI5NDk2NzI5NeKAmSBbLVdlcnJvcj1vdmVyZmxvd10NCiAgNzQzIHwgI2Rl
ZmluZSBTQVRQNjRfTU9ERSAgICAgICAgIDB4RjAwMDAwMDAwMDAwMDAwMFVMTA0KICAgICAgfCAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgXn5+fn5+fn5+fn5+fn5+fn5+fn5+DQouLi90YXJn
ZXQvcmlzY3YvY3B1X2JpdHMuaDo3NTE6Mjk6IG5vdGU6IGluIGV4cGFuc2lvbiBvZiBtYWNybw0K
4oCYU0FUUDY0X01PREXigJkNCiAgNzUxIHwgI2RlZmluZSBIR0FUUDY0X01PREUgICAgICAgIFNB
VFA2NF9NT0RFDQogICAgICB8ICAgICAgICAgICAgICAgICAgICAgICAgICAgICBefn5+fn5+fn5+
fg0KLi4vdGFyZ2V0L3Jpc2N2L3RjZy9jc3IuYzo1MjQyOjE2OiBub3RlOiBpbiBleHBhbnNpb24g
b2YgbWFjcm8NCuKAmEhHQVRQNjRfTU9EReKAmQ0KIDUyNDIgfCAgICAgICAgIG1hc2sgPSBIR0FU
UDY0X01PREUgfCBIR0FUUDY0X1ZNSUQgfCBIR0FUUDY0X1BQTjsNCiAgICAgIHwgICAgICAgICAg
ICAgICAgXn5+fn5+fn5+fn5+DQpjYzE6IGFsbCB3YXJuaW5ncyBiZWluZyB0cmVhdGVkIGFzIGVy
cm9ycw0KbmluamE6IGJ1aWxkIHN0b3BwZWQ6IHN1YmNvbW1hbmQgZmFpbGVkLg0KbWFrZTogKioq
IFtNYWtlZmlsZToxNzA6IHJ1bi1uaW5qYV0gRXJyb3IgMQ0KDQoNCllvdSBwcm9iYWJseSBkb24n
dCB3YW50IHRvIHVzZSB0YXJnZXRfdWxvbmcsIG9yIG1heWJlIHVzZSBhICNpZmRlZg0KVEFSR0VU
X1JJU0NWNjQgaWYgeW91IHJlYWxseSBoYXZlIHRvDQoNCkFsaXN0YWlyDQoNCj4gKw0KPiArwqDC
oMKgIC8qIEctc3RhZ2UgeDQgcm9vdCBwYWdlIHRhYmxlcyBhcmUgYWx3YXlzIDE2IEtpQiBhbGln
bmVkLiAqLw0KPiArwqDCoMKgIHJldHVybiBtYXNrICYgfih0YXJnZXRfdWxvbmcpMzsNCj4gK30N
Cj4gKw0KPiArc3RhdGljIHRhcmdldF91bG9uZyBsZWdhbGl6ZV9oZ2F0cChDUFVSSVNDVlN0YXRl
ICplbnYsDQo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB0YXJnZXRfdWxvbmcgb2xkX2hnYXRwLA0KPiArwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgdGFyZ2V0X3Vsb25nIHZhbCkNCj4gK3sNCj4gK8KgwqDCoCB0YXJnZXRfdWxvbmcgbW9k
ZV9tYXNrID0gcmlzY3ZfY3B1X214bChlbnYpID09IE1YTF9SVjMyID8NCj4gK8KgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIEhHQVRQMzJfTU9E
RSA6IEhHQVRQNjRfTU9ERTsNCj4gK8KgwqDCoCB0YXJnZXRfdWxvbmcgaGdhdHAgPSB2YWwgJiBo
Z2F0cF9tYXNrKGVudik7DQo+ICvCoMKgwqAgdGFyZ2V0X3Vsb25nIG1vZGUgPSBnZXRfZmllbGQo
aGdhdHAsIG1vZGVfbWFzayk7DQo+ICsNCj4gK8KgwqDCoCAvKg0KPiArwqDCoMKgwqAgKiBoZ2F0
cC5NT0RFIGlzIGEgV0FSTCBmaWVsZCwgc28gYW4gdW5zdXBwb3J0ZWQgdmFsdWUgbXVzdCBiZQ0K
PiArwqDCoMKgwqAgKiBsZWdhbGl6ZWQgcmF0aGVyIHRoYW4gY2F1c2luZyB0aGUgZW50aXJlIHdy
aXRlIHRvIGJlIGlnbm9yZWQuDQo+ICvCoMKgwqDCoCAqIFRoZSBzcGVjaWZpY2F0aW9uIGRvZXMg
bm90IHJlcXVpcmUgYSBwYXJ0aWN1bGFyIGxlZ2FsIHZhbHVlLA0KPiArwqDCoMKgwqAgKiBRRU1V
IGhlcmUgY2hvb3NlcyB0byBrZWVwIHRoZSBwcmV2aW91cyBtb2RlIHdoaWxlIGFjY2VwdGluZw0K
PiArwqDCoMKgwqAgKiB3cml0ZXMgdG8gdGhlIHJlbWFpbmluZyBXQVJMIGZpZWxkcy4NCj4gK8Kg
wqDCoMKgICovDQo+ICvCoMKgwqAgaWYgKCF2YWxpZGF0ZV92bShlbnYsIG1vZGUpKSB7DQo+ICvC
oMKgwqDCoMKgwqDCoCBoZ2F0cCA9IHNldF9maWVsZChoZ2F0cCwgbW9kZV9tYXNrLA0KPiArwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZ2V0X2ZpZWxk
KG9sZF9oZ2F0cCwgbW9kZV9tYXNrKSk7DQo+ICvCoMKgwqAgfQ0KPiArDQo+ICvCoMKgwqAgaWYg
KGhnYXRwICE9IG9sZF9oZ2F0cCkgew0KPiArwqDCoMKgwqDCoMKgwqAgdGxiX2ZsdXNoKGVudl9j
cHUoZW52KSk7DQo+ICvCoMKgwqAgfQ0KPiArDQo+ICvCoMKgwqAgcmV0dXJuIGhnYXRwOw0KPiAr
fQ0KPiArDQo+IMKgc3RhdGljIFJJU0NWRXhjZXB0aW9uIHJlYWRfaGdhdHAoQ1BVUklTQ1ZTdGF0
ZSAqZW52LCBpbnQgY3Nybm8sDQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB0YXJnZXRfdWxvbmcgKnZhbCkNCj4gwqB7
DQo+IC3CoMKgwqAgKnZhbCA9IGVudi0+aGdhdHA7DQo+ICvCoMKgwqAgKnZhbCA9IGVudi0+aGdh
dHAgJiBoZ2F0cF9tYXNrKGVudik7DQo+IMKgwqDCoMKgIHJldHVybiBSSVNDVl9FWENQX05PTkU7
DQo+IMKgfQ0KPiDCoA0KPiDCoHN0YXRpYyBSSVNDVkV4Y2VwdGlvbiB3cml0ZV9oZ2F0cChDUFVS
SVNDVlN0YXRlICplbnYsIGludCBjc3JubywNCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgdGFyZ2V0X3Vsb25nIHZh
bCwgdWludHB0cl90IHJhKQ0KPiDCoHsNCj4gLcKgwqDCoCBlbnYtPmhnYXRwID0gbGVnYWxpemVf
eGF0cChlbnYsIGVudi0+aGdhdHAsIHZhbCk7DQo+ICvCoMKgwqAgZW52LT5oZ2F0cCA9IGxlZ2Fs
aXplX2hnYXRwKGVudiwgZW52LT5oZ2F0cCwgdmFsKTsNCj4gwqDCoMKgwqAgcmV0dXJuIFJJU0NW
X0VYQ1BfTk9ORTsNCj4gwqB9DQo+IMKgDQo+IA0KPiAtLS0NCj4gYmFzZS1jb21taXQ6IGMxYzE4
ZDFlNjQwYjY0MjkyODU5Y2U5ZjMwZjNjMzQ0ZWRmYjAyOTQNCj4gY2hhbmdlLWlkOiAyMDI2MDky
MC1yaXNjdi1oZ2F0cC13YXJsLTFlNDhmZDMyMTE4OA0KPiANCj4gQmVzdCByZWdhcmRzLA0KPiAt
LcKgIA0KPiBTaHVuY2hhbyBIdSA8aHVzaHVuY2hhb0Bib3NjLmFjLmNuPg0KPiANCg==

