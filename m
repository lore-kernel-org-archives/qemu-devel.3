Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29188C9830E
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2026 03:11:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xB1lh-0005xk-4s; Sun, 27 Sep 2026 23:11:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=724888370=Alistair.Francis@wdc.com>)
 id 1xB1lX-0005x6-MI; Sun, 27 Sep 2026 23:10:57 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=724888370=Alistair.Francis@wdc.com>)
 id 1xB1lR-0003pY-PM; Sun, 27 Sep 2026 23:10:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1790565049; x=1822101049;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=FBCBreLwcPZBi2R9uRrElG3fSv6LQhjJ0O9XuYpIHgU=;
 b=prGFsfgWLShQzlYZ1Su4rPohpzK/YqYa4qGdIY2GsWg2kTBlhiH1ngiU
 xFXb1UIE7YSaM7BAHAK5/hPX5Jn2ymNbo8ryRUK9NPIzL8QspKDtSStCr
 tqp2WpUNifbjmCggZoBhy7R2JxuucOeT51+bXAeps/CjPwXlrkA+M1zAq
 E9G5NohCkZp6wg+C6T1Xnq7HaYMyMPneKu0CT73+bXnzZcl24RaTe900E
 TkzQLoh8cSehHdEUGVF9RYwWSc0+syySN/34YgjndC05FwWqyBs+zSp8U
 W8h/O42M7iFBuYsjtiUEA4CayMpO9Q57iifXPfx9np4FYZaOKSda/4y/7 g==;
X-CSE-ConnectionGUID: c69U9UxkSEmxSlTaxFUHAQ==
X-CSE-MsgGUID: 4tIYrqLlRcGVpUZI8ATw5w==
X-IronPort-AV: E=Sophos;i="6.27,127,1786982400"; d="scan'208";a="155751012"
Received: from mail-northcentralusazon11010039.outbound.protection.outlook.com
 (HELO CH1PR05CU001.outbound.protection.outlook.com) ([52.101.193.39])
 by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 28 Sep 2026 11:10:46 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HD0zxuxfl/COTre3SvgyuARn0RSe3yBb3Nxl2hbDDqacWgEfu7pIQaBBW9wkIsTUP90gyjTsJzXeOHGonm1/TPwwgZtw7IpRy644we0X9o33jttcXpd8Z1Ob0r1QqLuO52DYXkP+nhx3QEaywdgauMgqavRrc400RioNWH4NEVXmvgbKiHYm3QHGXa5zFsIAj9H6L9r3KByKw8NR05aeMt8ckHCpMJOZS8N85/3rkN25WYED6fqjRZJT19tZ3X090OwKMW61KlV8BjUH/Bt8MdeSL6jXSjKtkfbFHN0RW04Jv49iEzx1A5qDWpfYYmeriltWkwGQhwAdS8BauF6G9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FBCBreLwcPZBi2R9uRrElG3fSv6LQhjJ0O9XuYpIHgU=;
 b=gzWc4Lawfd3bcXGPEIroWzwOi9GoineOIp4WgTNHssf13kMUTxnGjKSXL2yD32kLheGFewg1iti75nb2sOEhpJVYZ46E1PRu2KS4vr7FhmVhTQ6aa6eJ8JSUMB/VNA4KKBWoWY7k9L8qs3HqftJyMggSxXd+Ru6om/TATDyAaXhWMjvVNArNmGa1APhLgXpnCOyPbDL/cC+H9yyCYLkk+KbBgBeUfEVm+fKKt0ql9ORLJjSnW+XwDaK5Q0pjPhEOBkAdC2g2Edahe2am2oSaguDhT0nKg//ynjtivf7ywz/FFroXHVeM/INZx1DNiI3G9ETH4BUAr2zcyGW7RFwlrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FBCBreLwcPZBi2R9uRrElG3fSv6LQhjJ0O9XuYpIHgU=;
 b=onoF+PO1t3J/8Cr/Cszj+0SzTKlcR1oWylJypCPUFRz1JdoNxT+Z+7RwoMWdo0iBTo9lPAuWYrsU1rx+nd01Y4rNoSF6W2ofkWmltC6QAt3WS5xm5APXwVmdS5LyY5Kjj/08D0SWDGAxqJz3Bl/Ollc3/tLcItSXTjIczUAa0kM=
Received: from BY1PR04MB9561.namprd04.prod.outlook.com (2603:10b6:a03:5b6::11)
 by SA3PR04MB8645.namprd04.prod.outlook.com (2603:10b6:806:2fa::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Mon, 28 Sep
 2026 03:10:44 +0000
Received: from BY1PR04MB9561.namprd04.prod.outlook.com
 ([fe80::3869:e494:2fa8:9888]) by BY1PR04MB9561.namprd04.prod.outlook.com
 ([fe80::3869:e494:2fa8:9888%6]) with mapi id 15.21.0451.022; Mon, 28 Sep 2026
 03:10:44 +0000
From: Alistair Francis <Alistair.Francis@wdc.com>
To: "daniel.barboza@oss.qualcomm.com" <daniel.barboza@oss.qualcomm.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>,
 "chao.liu.zevorn@gmail.com" <chao.liu.zevorn@gmail.com>, "palmer@dabbelt.com"
 <palmer@dabbelt.com>, "chao.liu@processmission.com"
 <chao.liu@processmission.com>, "tangtao1634@phytium.com.cn"
 <tangtao1634@phytium.com.cn>, "liwei1518@gmail.com" <liwei1518@gmail.com>,
 "zhiwei_liu@linux.alibaba.com" <zhiwei_liu@linux.alibaba.com>
Subject: Re: [PATCH v9 4/7] target/riscv: add sdext enter Debug Mode on ebreak
Thread-Topic: [PATCH v9 4/7] target/riscv: add sdext enter Debug Mode on ebreak
Thread-Index: AQHdQGpbUq41qjzndkWij2WTlBRbyrbjbRCA
Date: Mon, 28 Sep 2026 03:10:44 +0000
Message-ID: <b5234e47fd25f0b1afb8ad69cf9caedfcf178b79.camel@wdc.com>
References: <20260909144841.1766921-1-daniel.barboza@oss.qualcomm.com>
 <20260909144841.1766921-5-daniel.barboza@oss.qualcomm.com>
In-Reply-To: <20260909144841.1766921-5-daniel.barboza@oss.qualcomm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.62.0 (by Flathub.org) 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY1PR04MB9561:EE_|SA3PR04MB8645:EE_
x-ms-office365-filtering-correlation-id: d948000b-47d2-494d-59c8-08df1d0e15b9
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|10070799003|19092799006|23010399003|366016|376014|4143699003|11063799006|10067099003|56012099006|18002099003|22082099003|18092099006|38070700021|6133799003|10086099003;
x-microsoft-antispam-message-info: WU9FBAmGopH17Am+YgKEVj6g0aIdOhrIpqwCFvkK2f65hPCM6Gp8mW0bEmX2QKYUpC9yybzZYYRoKZfxuRM1bPlXveV09h2uBS9QQw4LVR6GACQkE66e4dukvNdmwFTRKGgbUHDW1mOEauYHCW8UCsYSdWMmUNvhoygOrQfk6pLbQcvDKOqQYYRq79t2r2jMb8OMrkgIs6Wcq0d/7s4l2RFaubGGWW3gIxpmE6ej3qsn44b8qM05TmZq4l4kSFmZvatkr5r5WRp4E4ImhOAGQWf0tf2yO/zzzTeetv22hQ7bl26y0NObBGVuNHvp+DEnKiv2LjgBVbla2Or03QopxfsmP6QCMYmG/ybOb530MWVX9VaGrgW+U9ClpBTD0PmeKFFJRF10ZvHsjHxu86I5xTCM2xJNVbnCrW0rXospk37YkxmHzLpPRVxFVBtyAbW6qBBT51Gd/lueYf5CWojK66uhpiHG3cUdZK6IbHxRKDdMAblYV0zxUTd/928ckq1auUTcTB5ABue3QeyBnGFmDZf80GxT9peKkYcRZAa40iPe3d5p/kD+eFVlqlvru7Il81CrBNm9aZ6rkyRTQ7IoqxLftaRu0ENdbOMcS4ZwgctXGdVRafZYSMZFnXfdJpABOGOXIWusDr2+rL57T4dBKWiQEZK95g0DCVwuUgHmT5vsV4VpNndC0gEu2dRx+Tsbl9QJR4m3/BycFTX8+EYCF4wwTglrGY7L07kb3mBFikk=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY1PR04MB9561.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(10070799003)(19092799006)(23010399003)(366016)(376014)(4143699003)(11063799006)(10067099003)(56012099006)(18002099003)(22082099003)(18092099006)(38070700021)(6133799003)(10086099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dW41eEdaUmg2dDN3Q0JOb3ZXSFZyMDBtcW1OT0o5V3dKSU9qN25iRElTQno0?=
 =?utf-8?B?Nm1BL09KN0Z2c2ZZOGNnUmFYOTlTcU9TUmNESzNXUmJZM1ZVT2VTTkFxR0ls?=
 =?utf-8?B?SlFwM0tIUWN0RlFGR1ZVMkhzdy9ZMGFaZzE4WXZ0bjBBTzNYMmduS09Oc0RS?=
 =?utf-8?B?WnVhUjJDeW5waTRMcDVWdVJvMVh2bGlZdFIraWZyUEZOVzJmRCtHNi9PSEkv?=
 =?utf-8?B?SkpHRGlBdDY5SUFXMGxVZFl5S1dkUkFPb0QxdjZPdGNlUVFoTUxIYVc1ZExB?=
 =?utf-8?B?eW03MFJRQ2NYalBGc0U0R3J0c3dhYWdLckkvcUZqQVFIUG9lMkhGek5NMVA2?=
 =?utf-8?B?ald1dWRzakhqOTV6YTVHWXRvaTg2anE4KzAxYldra3RqYVZ0VjZJeE5rck1P?=
 =?utf-8?B?UnBEeTNqZkV3QnFmeEExVWNRYW0xN1FhZ2FWMHBlclNMR1lOYmk3RlY3WG1u?=
 =?utf-8?B?aFJaMGZjWW9qWXdFNXBJRzZzWWluQU9CakQyZDkvc3hKMHN0NlNqVDlMb1F4?=
 =?utf-8?B?RUsrRzFaNVZoTXBnWEZ3NFBEeXVmdG9WSTJCaVBlcHkrRXNZSkJWWjY0NU82?=
 =?utf-8?B?SmpTWFhlK3NmNk9CL1J3QSs5TUl2cXVON1IrYVU1SHBiR1NsV3JUMFNJZThz?=
 =?utf-8?B?eVRDTlI1WGFBK01tT1VCdytlajNpSkRZdWIyc254UTJyYkI0Wmo5VjQ5aEs5?=
 =?utf-8?B?dVRmcFdUaFV3ajVnUElkNzFvN1ZJUFBUMHB1Z1E2WEh2anlNVTQvYngzY1Bx?=
 =?utf-8?B?bzI1cG95S3NWZFNDVXRMWU1DUnVhNkJFVnRSVjFxK2g2M3lZZFY2Y095Skdt?=
 =?utf-8?B?RnFRNk83STFVS3U2Q1lBMkdEQUp5dUdia0FielZOcHl5K2wwK3JrNUw0UXli?=
 =?utf-8?B?VDZrUnFUbmlLRHowM2dTaWJFbHNwRjd6RXZIMTd4dzQvd0dObm9uT01HR2Fw?=
 =?utf-8?B?dXJLRnlYaUNBS1YzRTNaVndVRURUSHM1VjQwa21teVo2NmxuQk5CN3dBK2wr?=
 =?utf-8?B?NmJSTVFZSWlLYTRmbk1CSVh1OXhGNkZUWWVqdWtBR1JwRHo0STVMMTdKUE56?=
 =?utf-8?B?WVlvdVRWZzVrenZ6b1VORThLNTA0b3hueHI2a1NwdTNpa0JOOGNpRURZeEYx?=
 =?utf-8?B?N2xybHNsL0ExcUVxbXNSY3ArR0Z4dlNodjNiSFpyN2xqZVN2YWNVR05vM1lz?=
 =?utf-8?B?SjZ3T1pwZWdaZ2xxRjBVWU5LZDhFWEtaZGNReGprNkZBY0s4YnRGV21HSlky?=
 =?utf-8?B?dEpFVngrN1pXOXZzYjBsc3JFb0hQSGNoVStXSlg5dy9DQ1NoNmNmaFM0Q1lS?=
 =?utf-8?B?OTV6YktTWGwycys2ZEtVOUlYOXJwTTR0V2FKVnBRd0JvUzNBSFl2TVNETUtX?=
 =?utf-8?B?QVJPM0VnZ1YvV2lpNTBWcU5TU0s4ZUdIb24vUkFkUGt1QmdYKy9BbWNuWWJE?=
 =?utf-8?B?ZXlRM2c2ZnRDcDNkcXJ1Vk5hNDZObDhLWnBxS3laKzBXZTRSR2FMR2ZZQmlv?=
 =?utf-8?B?UHF1RUczaTl3MUsxNW5tVWx2NWl3bjk5MEIzSUhqaS9ra1lMSmM0N3JxdUho?=
 =?utf-8?B?eGVIdndySnE1Smh5UnJmK3hubDh5N08yV1VhUzkrOFV3NzNHZ3hJbXkwU0Zr?=
 =?utf-8?B?VDBSUHl1Tm5xOTZGaGNuQWl1cEc4TEk5akp3SHFSRVU3QVNwaHFPaWpwZXpW?=
 =?utf-8?B?am83WllnU1plYTIwOWJEMkwzWVpYK1RGclZxYnNWbkhZbjBTZTU3QjJkTWRY?=
 =?utf-8?B?Rjl5MG5GN2pqVjR0WXdnRFZyVi9jRzlzNDNvb2VDbW1oY3A2NGwvSTA0bkVT?=
 =?utf-8?B?UVl4UUt4a0YveFhRanUzUVcrSlQyNFlXZzlVdndMUWt1WWNMSnNUT05GTzd4?=
 =?utf-8?B?N3BjQUZEeHBJVWZEUXI3dnBHRFQ2S1pwNHdBTlZDdWlPVURBUDNHMnRoZzRO?=
 =?utf-8?B?dGNuL0NUSTZMTVJzbHJTZ3p5NTlNeXprU0d5ZWlUZVFKZzhKK0ozb1Jna0Zh?=
 =?utf-8?B?Y3BVZjVNNHhza2tEWlczZG1JL2VtTkIwc2F0cmFPN0Vud0hVWGxkbzJGTU9J?=
 =?utf-8?B?NUVLL2lkYlM1L2tFZWtFMXVzVjBINDZ6TzNqZkVDeGFVcDd6QXV0M0lFOGs0?=
 =?utf-8?B?MU45WHNzVGVsUVFmaWUzMk1qWGQ0Mm4vRjlpWVZJQnhLbWJrUzdTQVZhY0JH?=
 =?utf-8?B?RWY1YVh0cE1SK1FRV0ZoblpLZWVZa2RZZHptV0V4YUd3dXdMK3B0SE5XdklZ?=
 =?utf-8?B?TVFLejlGbDhiTGl6Z2JDMnpHejEydlUzQjJSeWdLMmVOVXRqWEErdkVXSUc5?=
 =?utf-8?B?V3JMOWQ2eHp2U2ZCTlJzM2FVa2liMFY3Yk5pdDZ1bXN5dkFMR1NRanhnMUpz?=
 =?utf-8?Q?rHJkz9+kCXKJ5uQpQdlkY9+vxnrKm17qjLUbcF8gHl4+C?=
x-ms-exchange-antispam-messagedata-1: JM+G7/Om+UYnWkDromEYdd6iFRTOPDK3KyI=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A44565197CC11344B7004E2B436CA9D4@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: ANHDjABqIfPC14tr8BIIo3UQ/3M62veOB5LEIqBj/yyXP7rIVWfgmBHNpwFZ85/cxXlGjaPGdi/LoBPGLY7deA0/jjX41g2YRW8HwxFNE5aa2mD2hw5Nhs8px34AAWB7s6Y+FdW8+Wb0XtnB+KAa0K3MClB4LMekxnD+1+exVBgfVserkime/M6kXP3i4aSj3wRuoncuA0nDA42UlendMvFGK7Cx9Nv5l25HFQYq8nL/vWOMe0xuATQx017SqI1urwYlH0fA8zXXJlxNC3P+9gT1G1w5OEzcGAx6Xx9VQxoR2zhvDlhLaBYP12y0dnfjzbE/DOeV9th51z40NeiEBg==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: I+DWbopfU/Vla0hzP5UsZyaRLDrJ02vfALs3KalMieHZrdDwt++r88wd+6hTnyzZT0Lha0CboSaGRxgqQHu4yoZ5s+Zbb7ZmgdruvFqI6JF7lnYgJhRy2I/qGRrXDGJmMNkw72bZeOSTk2jBcmIhoWAcrCzNWQEfWHLNUJZuCnAOshB/YewoeqQiQQK3r+ruMWiwzUb7MH7mFbCGpidxp4uwaUcyrxDqGT7HLBB43SJihWyNPscRKbs/Mh9hD88hZTagi+CTdfu6KbYIBcNYfn7MatMXhby0MBJb93g/a4jtdiG5ypARe5Wfb+qb5a5lYZwrhO1CxTYxBczBMDxuYk4SDdgwb/JAwpiPKGOGcP+k1lrTan2QWAdIsUT89YzULJZ4W8Q/nIN25897xH1AzJzlJOJb/aWQyecksYsPlod9FgVXIGfaNlR9uuK7zK9zFH99g1a1yQOohFLrsQY1LgvjMyOZ9Xsmub8R+rumUAortjo3BE5Nd9SZdWXOIdBlSlWscs1bapW7T+mI6zztrz2ANVN6EjofZMc4goKZM1Nozv0hKtoRk7IVYJJ3QzjBoMxD7tkVRBaO6fzRPn9A3mEzWrpYC5TyzToDYKFObJ8dC4JhE35S0r4oL7Id5HIn
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY1PR04MB9561.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d948000b-47d2-494d-59c8-08df1d0e15b9
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Sep 2026 03:10:44.0872 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9aJ8l1Xzg7vFc9CigujcH2YGnAz70mfGlY5FCxJ73/CtXjhODn6rgPyC1Aco7r1XrC0hHMm6Pw7DWFvWJOrmMMXPf7EGBfbYwqDMxt1WtBY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR04MB8645
Received-SPF: pass client-ip=216.71.153.144;
 envelope-from=prvs=724888370=Alistair.Francis@wdc.com;
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

T24gV2VkLCAyMDI2LTA5LTA5IGF0IDExOjQ4IC0wMzAwLCBEYW5pZWwgSGVucmlxdWUgQmFyYm96
YSB3cm90ZToKPiBGcm9tOiBDaGFvIExpdSA8Y2hhby5saXUuemV2b3JuQGdtYWlsLmNvbT4KPiAK
PiBSSVNDLVYgRGVidWcgU3BlY2lmaWNhdGlvbjoKPiBodHRwczovL2dpdGh1Yi5jb20vcmlzY3Yv
cmlzY3YtZGVidWctc3BlYy9yZWxlYXNlcy90YWcvMS4wCj4gCj4gUm91dGUgRUJSRUFLIHZpYSBo
ZWxwZXJfc2RleHRfZWJyZWFrLiBJZiBTZGV4dCBpcyBlbmFibGVkIGFuZCB0aGUKPiBtYXRjaGlu
ZyBkY3NyLmVicmVhayogYml0IGlzIHNldCwgZW50ZXIgRGVidWcgTW9kZSB3aXRoIGNhdXNlPWVi
cmVhawo+IGFuZCBzdG9wIHdpdGggRVhDUF9ERUJVRy4gT3RoZXJ3aXNlIGtlZXAgdGhlIG5vcm1h
bCBicmVha3BvaW50IHRyYXAuCj4gCj4gU2lnbmVkLW9mZi1ieTogQ2hhbyBMaXUgPGNoYW8ubGl1
Lnpldm9ybkBnbWFpbC5jb20+Cj4gUmV2aWV3ZWQtYnk6IERhbmllbCBIZW5yaXF1ZSBCYXJib3ph
Cj4gPGRhbmllbC5iYXJib3phQG9zcy5xdWFsY29tbS5jb20+Cj4gVGVzdGVkLWJ5OiBUYW8gVGFu
ZyA8dGFuZ3RhbzE2MzRAcGh5dGl1bS5jb20uY24+Cj4gU2lnbmVkLW9mZi1ieTogRGFuaWVsIEhl
bnJpcXVlIEJhcmJvemEKPiA8ZGFuaWVsLmJhcmJvemFAb3NzLnF1YWxjb21tLmNvbT4KClJldmll
d2VkLWJ5OiBBbGlzdGFpciBGcmFuY2lzIDxhbGlzdGFpci5mcmFuY2lzQHdkYy5jb20+CgpBbGlz
dGFpcgoKPiAtLS0KPiDCoHRhcmdldC9yaXNjdi9oZWxwZXIuaMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8wqAgMSArCj4gwqAuLi4vdGNnL2luc25fdHJh
bnMvdHJhbnNfcHJpdmlsZWdlZC5jLmluY8KgwqDCoMKgIHzCoCA2ICsrKysKPiDCoHRhcmdldC9y
aXNjdi90Y2cvb3BfaGVscGVyLmPCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHwg
MzQKPiArKysrKysrKysrKysrKysrKysrCj4gwqAzIGZpbGVzIGNoYW5nZWQsIDQxIGluc2VydGlv
bnMoKykKPiAKPiBkaWZmIC0tZ2l0IGEvdGFyZ2V0L3Jpc2N2L2hlbHBlci5oIGIvdGFyZ2V0L3Jp
c2N2L2hlbHBlci5oCj4gaW5kZXggYjRjNDdkMDczOC4uMGQ5YWUxNWUzZSAxMDA2NDQKPiAtLS0g
YS90YXJnZXQvcmlzY3YvaGVscGVyLmgKPiArKysgYi90YXJnZXQvcmlzY3YvaGVscGVyLmgKPiBA
QCAtMTQyLDYgKzE0Miw3IEBAIERFRl9IRUxQRVJfMSh0bGJfZmx1c2hfYWxsLCB2b2lkLCBlbnYp
Cj4gwqBERUZfSEVMUEVSXzQoY3RyX2FkZF9lbnRyeSwgdm9pZCwgZW52LCB0bCwgdGwsIHRsKQo+
IMKgLyogTmF0aXZlIERlYnVnICovCj4gwqBERUZfSEVMUEVSXzEoaXRyaWdnZXJfbWF0Y2gsIHZv
aWQsIGVudikKPiArREVGX0hFTFBFUl8yKHNkZXh0X2VicmVhaywgdm9pZCwgZW52LCB0bCkKPiDC
oCNlbmRpZgo+IMKgCj4gwqAvKiBIeXBlcnZpc29yIGZ1bmN0aW9ucyAqLwo+IGRpZmYgLS1naXQg
YS90YXJnZXQvcmlzY3YvdGNnL2luc25fdHJhbnMvdHJhbnNfcHJpdmlsZWdlZC5jLmluYwo+IGIv
dGFyZ2V0L3Jpc2N2L3RjZy9pbnNuX3RyYW5zL3RyYW5zX3ByaXZpbGVnZWQuYy5pbmMKPiBpbmRl
eCA0ZTU3OTAxODgwLi40MmJmMmZmYjUzIDEwMDY0NAo+IC0tLSBhL3RhcmdldC9yaXNjdi90Y2cv
aW5zbl90cmFucy90cmFuc19wcml2aWxlZ2VkLmMuaW5jCj4gKysrIGIvdGFyZ2V0L3Jpc2N2L3Rj
Zy9pbnNuX3RyYW5zL3RyYW5zX3ByaXZpbGVnZWQuYy5pbmMKPiBAQCAtNjgsOSArNjgsMTUgQEAg
c3RhdGljIGJvb2wgdHJhbnNfZWJyZWFrKERpc2FzQ29udGV4dCAqY3R4LAo+IGFyZ19lYnJlYWsg
KmEpCj4gwqDCoMKgwqAgaWYgKHByZSA9PSAweDAxZjAxMDEzICYmIGVicmVhayA9PSAweDAwMTAw
MDczICYmIHBvc3QgPT0KPiAweDQwNzA1MDEzKSB7Cj4gwqDCoMKgwqDCoMKgwqDCoCBnZW5lcmF0
ZV9leGNlcHRpb24oY3R4LCBSSVNDVl9FWENQX1NFTUlIT1NUKTsKPiDCoMKgwqDCoCB9IGVsc2Ug
ewo+ICsjaWZuZGVmIENPTkZJR19VU0VSX09OTFkKPiArwqDCoMKgwqDCoMKgwqAgZ2VuX3VwZGF0
ZV9wYyhjdHgsIDApOwo+ICvCoMKgwqDCoMKgwqDCoCBnZW5faGVscGVyX3NkZXh0X2VicmVhayh0
Y2dfZW52LAo+IHRjZ19jb25zdGFudF90bChlYnJlYWtfYWRkcikpOwo+ICvCoMKgwqDCoMKgwqDC
oCBjdHgtPmJhc2UuaXNfam1wID0gRElTQVNfTk9SRVRVUk47Cj4gKyNlbHNlCj4gwqDCoMKgwqDC
oMKgwqDCoCB0Y2dfZ2VuX3N0X2k2NCh0Y2dfY29uc3RhbnRfaTY0KGVicmVha19hZGRyKSwgdGNn
X2VudiwKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBvZmZz
ZXRvZihDUFVSSVNDVlN0YXRlLCBiYWRhZGRyKSk7Cj4gwqDCoMKgwqDCoMKgwqDCoCBnZW5lcmF0
ZV9leGNlcHRpb24oY3R4LCBSSVNDVl9FWENQX0JSRUFLUE9JTlQpOwo+ICsjZW5kaWYKPiDCoMKg
wqDCoCB9Cj4gwqDCoMKgwqAgcmV0dXJuIHRydWU7Cj4gwqB9Cj4gZGlmZiAtLWdpdCBhL3Rhcmdl
dC9yaXNjdi90Y2cvb3BfaGVscGVyLmMKPiBiL3RhcmdldC9yaXNjdi90Y2cvb3BfaGVscGVyLmMK
PiBpbmRleCA1NDI2OWVmZWUxLi41ZGI0ZjZhYWNkIDEwMDY0NAo+IC0tLSBhL3RhcmdldC9yaXNj
di90Y2cvb3BfaGVscGVyLmMKPiArKysgYi90YXJnZXQvcmlzY3YvdGNnL29wX2hlbHBlci5jCj4g
QEAgLTQ4OSw2ICs0ODksNDAgQEAgdGFyZ2V0X3Vsb25nIGhlbHBlcl9kcmV0KENQVVJJU0NWU3Rh
dGUgKmVudikKPiDCoCNlbmRpZgo+IMKgfQo+IMKgCj4gK3ZvaWQgaGVscGVyX3NkZXh0X2VicmVh
ayhDUFVSSVNDVlN0YXRlICplbnYsIHRhcmdldF91bG9uZyBwYykKPiArewo+ICvCoMKgwqAgQ1BV
U3RhdGUgKmNzID0gZW52X2NwdShlbnYpOwo+ICvCoMKgwqAgYm9vbCBlbnRlcl9kZWJ1ZyA9IGZh
bHNlOwo+ICsKPiArwqDCoMKgIGlmIChyaXNjdl9jcHVfY2ZnKGVudiktPmV4dF9zZGV4dCAmJiAh
ZW52LT5kZWJ1Z19tb2RlKSB7Cj4gK8KgwqDCoMKgwqDCoMKgIGlmIChlbnYtPnZpcnRfZW5hYmxl
ZCkgewo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGlmIChlbnYtPnByaXYgPT0gUFJWX1MpIHsK
PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGVudGVyX2RlYnVnID0gZW52LT5kY3Ny
ICYgRENTUl9FQlJFQUtWUzsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB9IGVsc2UgaWYgKGVu
di0+cHJpdiA9PSBQUlZfVSkgewo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZW50
ZXJfZGVidWcgPSBlbnYtPmRjc3IgJiBEQ1NSX0VCUkVBS1ZVOwo+ICvCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIH0KPiArwqDCoMKgwqDCoMKgwqAgfSBlbHNlIHsKPiArwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCBpZiAoZW52LT5wcml2ID09IFBSVl9NKSB7Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCBlbnRlcl9kZWJ1ZyA9IGVudi0+ZGNzciAmIERDU1JfRUJSRUFLTTsKPiArwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCB9IGVsc2UgaWYgKGVudi0+cHJpdiA9PSBQUlZfUykgewo+ICvCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZW50ZXJfZGVidWcgPSBlbnYtPmRjc3IgJiBEQ1NS
X0VCUkVBS1M7Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfSBlbHNlIGlmIChlbnYtPnByaXYg
PT0gUFJWX1UpIHsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGVudGVyX2RlYnVn
ID0gZW52LT5kY3NyICYgRENTUl9FQlJFQUtVOwo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIH0K
PiArwqDCoMKgwqDCoMKgwqAgfQo+ICvCoMKgwqAgfQo+ICsKPiArwqDCoMKgIGVudi0+YmFkYWRk
ciA9IHBjOwo+ICsKPiArwqDCoMKgIGlmIChlbnRlcl9kZWJ1Zykgewo+ICvCoMKgwqDCoMKgwqDC
oCByaXNjdl9jcHVfZW50ZXJfZGVidWdfbW9kZShlbnYsIHBjLCBEQ1NSX0NBVVNFX0VCUkVBSyk7
Cj4gK8KgwqDCoMKgwqDCoMKgIGNzLT5leGNlcHRpb25faW5kZXggPSBFWENQX0RFQlVHOwo+ICvC
oMKgwqDCoMKgwqDCoCBjcHVfbG9vcF9leGl0X3Jlc3RvcmUoY3MsIEdFVFBDKCkpOwo+ICvCoMKg
wqAgfQo+ICsKPiArwqDCoMKgIHJpc2N2X3JhaXNlX2V4Y2VwdGlvbihlbnYsIFJJU0NWX0VYQ1Bf
QlJFQUtQT0lOVCwgR0VUUEMoKSk7Cj4gK30KPiArCj4gwqB0YXJnZXRfdWxvbmcgaGVscGVyX21u
cmV0KENQVVJJU0NWU3RhdGUgKmVudikKPiDCoHsKPiDCoMKgwqDCoCB0YXJnZXRfdWxvbmcgcmV0
cGMgPSBlbnYtPm1uZXBjOwo=

