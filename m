Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9ADB6CD5BD5
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 23:21:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wS14o-0003RE-4d; Tue, 26 May 2026 19:20:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=599a94ef2=Alistair.Francis@wdc.com>)
 id 1wS14l-0003QT-J1; Tue, 26 May 2026 19:20:43 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=599a94ef2=Alistair.Francis@wdc.com>)
 id 1wS14j-0000AW-Io; Tue, 26 May 2026 19:20:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1779837641; x=1811373641;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=blyf/FaZ+qsgzUcJSQ94GqJRpYmZPxEhPZGZ4JgHeyQ=;
 b=nne7sxgM22bv97t0UVnXuzNRS+aChkBeYNURGJfxHYlTqyablYWJrOV/
 4bW3IrBymIRVGMRcTiNZ3/fdHwjv5EhKSlxsMfEk4JD8p7FyENyHHvXED
 YDUm4dLAJHEgL+K6DbNhnXgfZn2zosmpoJwxfNP6lnJkMX091xnAMyoJ2
 fvwsQxbDVFA70EhMV74oK/dZNL1mOfG9mTxlPJ1GxoC6Exak7iCs92wgS
 CNogpZ+xbbW4AQvTCvvFEbMBY2Xu9gir2mvCLqtInS+OhNqiFCao0far3
 Pk8tMKhVHlowXw9evRD4/mNFwgF+M02SU/JkfGDPBA+JmXvHaRzHCo4mZ A==;
X-CSE-ConnectionGUID: cZiFKsKzQsaCRDNiFM5AcQ==
X-CSE-MsgGUID: FBya+mESTregJoHRDUttGg==
X-IronPort-AV: E=Sophos;i="6.24,170,1774281600"; d="scan'208";a="143711627"
Received: from mail-westus3azon11010012.outbound.protection.outlook.com (HELO
 PH7PR06CU001.outbound.protection.outlook.com) ([52.101.201.12])
 by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 27 May 2026 07:20:35 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fDzTfIhXgp93pq6yR/e2SY2/6pEGE3RA+tHdrnEZfWec+YF9E7lKlphg/bggQYrY+ebcZmljCvQGDJGXOaUVRlNUdmWBP1GXy7X+OczQWvzbyEnYDV2H5DVYNzEaTh/Iqkii/Pv5rasaNOys5HWJz9Sc9ndF8XgUvhjM+Fx4QalUtWdM7xvs885ppDiVJ7dNbBtlB/o0GM4vEGgmgx4JJtAqY3nC/IWOesy5/eTEm48ECufB77cuxlybd3gAmUTiCFq/kBL6vmHvgeShyWtgBXKyyvvD/v+JIleirQaxmXGRTdB9n6eVVcm900xUBUx8b6fbCJH6FBICkoidoRBwng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=blyf/FaZ+qsgzUcJSQ94GqJRpYmZPxEhPZGZ4JgHeyQ=;
 b=UxG9BDAxa1eatlYyBzz20i7ViOoQBunerbzkREgV78eiUcxkLmd/gNJyEDZueeOpIy1oWE7pxhIlmJJkgct4QBlH5oX2thmyh4Ag70CQfc9ATWDOmui+C+/UKbJgUrQ70LkE5xPcQqqWrRSVisoPCcuFhkKTMtp1jEKtsPe0ZeJjYpHSL2eLicmXlHAEUvccGUJvs55cOiJqU1a1JVs+MhSOO9I19dlD11t8baulnVzctknl1Zo1s1toU8wN9NxFGook/WXvfYME8q3c7hE7S4MaYrFvgWDdxvSbuRvSnogQ5G33jRkIqLfGYvP4XRyQVywD/RZVt8nJi6gf3R1Q1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=blyf/FaZ+qsgzUcJSQ94GqJRpYmZPxEhPZGZ4JgHeyQ=;
 b=FaRKh56HflXZu/4n8ayTQcuGdp0PmLbczxNXAp9GHSRsQxyIKviEceTgG6QyqjxOVlmuoPJCK29iCRrmm+hCmaWe9SKG7B96mw5Fp/nVx5MMgZuQ04LTzF53VQNMTMFi4iPm0+Mv+1jZBuIxxPfB/b1sSOeDDvSvobmHO4GueAs=
Received: from CH5PR04MB9550.namprd04.prod.outlook.com (2603:10b6:610:20e::17)
 by LV0PR04MB9814.namprd04.prod.outlook.com (2603:10b6:408:331::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.17; Tue, 26 May
 2026 23:20:33 +0000
Received: from CH5PR04MB9550.namprd04.prod.outlook.com
 ([fe80::2dd5:1dc8:e3e7:5d31]) by CH5PR04MB9550.namprd04.prod.outlook.com
 ([fe80::2dd5:1dc8:e3e7:5d31%4]) with mapi id 15.21.0071.011; Tue, 26 May 2026
 23:20:33 +0000
From: Alistair Francis <Alistair.Francis@wdc.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "philmd@linaro.org"
 <philmd@linaro.org>
CC: "daniel.barboza@oss.qualcomm.com" <daniel.barboza@oss.qualcomm.com>,
 "chao.liu.zevorn@gmail.com" <chao.liu.zevorn@gmail.com>,
 "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>,
 "zhiwei_liu@linux.alibaba.com" <zhiwei_liu@linux.alibaba.com>,
 "palmer@dabbelt.com" <palmer@dabbelt.com>, "anjo@rev.ng" <anjo@rev.ng>,
 "sai.pavan.boddu@amd.com" <sai.pavan.boddu@amd.com>, "liwei1518@gmail.com"
 <liwei1518@gmail.com>, "pierrick.bouvier@oss.qualcomm.com"
 <pierrick.bouvier@oss.qualcomm.com>
Subject: Re: [PATCH 1/4] hw/riscv/spike: Use 'max' CPU type by default
Thread-Topic: [PATCH 1/4] hw/riscv/spike: Use 'max' CPU type by default
Thread-Index: AQHc7PYgP0n4XZbiykWfnCFYuxkdgrYg8pIA
Date: Tue, 26 May 2026 23:20:33 +0000
Message-ID: <9cdad47eb6abcbbf105b845af9509795c5702eca.camel@wdc.com>
References: <20260526095731.63525-1-philmd@linaro.org>
 <20260526095731.63525-2-philmd@linaro.org>
In-Reply-To: <20260526095731.63525-2-philmd@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.60.1 (by Flathub.org) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH5PR04MB9550:EE_|LV0PR04MB9814:EE_
x-ms-office365-filtering-correlation-id: 72adc65a-eeb9-4e51-8ef8-08debb7d629f
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|10070799003|366016|19092799006|1800799024|7416014|18002099003|22082099003|38070700021|56012099006|4143699003|11063799006;
x-microsoft-antispam-message-info: T4F6lPjuqKM9TCBRM6zMCGxV5aT8JAAOWPtWyXlqG6kXE2QmfZapYujOmePLhoA3KUyAcb00y6gPcXhmamhw3j0gWZJZuxPH1QJ+NWhbjUU+DslBxjsUU7s8A77ZrqwQ7puaRj/IObGRBsyq4uymPGno5TJ5D9zBH38snhZFj4yl7OY/YRs2e0hfyk0fnphSUoA/88ej/HxeMVvEDqjXKnOeKoIXuuFUR2oB6+LnK9ubOZDDjkfI/DLtr3EEeaETfSk5f57noTDqgScMtjU3QoUvZ4iw0DMir5KWVYHmD3uQLPSM8AvScM5AyvmfFV0PNTABbWkMlGGyBDjHQHZm1ZuBxAOg66Pq6lhO4ohGhDjGYl5Cj+ywKRXjuYf+VLj3CsKQHR8ud5e/ISeWMhvXfwV3H0Gq0BRQ9UhI3tj9XKcl9oM1BadbR8jiDVF88l9r6GdaDRog0o0owSl/ZU4c45uUDC4BmH/HJ/HhBaeAUKE5zDXwooFcVyWwYERFAtAtMWlmCK/rSRge+nHfsdG8w9whxhvGZFpcyhKM7FdDqawHwckXgUelqHy7mssUsPnXo8W12nK9z+ZD1iAr5nCiVyKRvfSfUW3Jgc0UNdzBVRl97076hdevIPQZQPYosx7jUmSRjDPsS+6xtC/aSBjfHX73lqfrZexLxRoyZHJizKt3GTnrJ/ukPmJUs9sg7oZMMePbumy68CuBmVm67XurcEgr49HVNAWbt3U+yQH15Fd809FmsLeU3anxPyvYMjv0
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH5PR04MB9550.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(10070799003)(366016)(19092799006)(1800799024)(7416014)(18002099003)(22082099003)(38070700021)(56012099006)(4143699003)(11063799006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eGlJakV6YWUvMEY1cWE3V3Q1Y0t4YzUzNjlGckZBOVJzMU4zdDdJTTl4bHNB?=
 =?utf-8?B?Y0d1OTBHTXowVzkxZWNoSk5yWlQzWE5qQ0dVL3NwSlFHb0h3UGlGSTFkN1Ay?=
 =?utf-8?B?c0lXSXJMc2Z4d0lWZG54TW1YN0d0U1VzYkxKSHkzSzJteC9wRERCTGREK3lq?=
 =?utf-8?B?UDg3ZEYzR1djY0RmZGwvQmVpcTBqOUYyWGhxTjJNaG5jS3duQ2FZaFc1VVlL?=
 =?utf-8?B?S3lGSzVNZTJOSzhRbm05Vm1DWGd6YVdPK0Vub29qaHp3U2dxMlpnaEJlaTg0?=
 =?utf-8?B?NUp6aityYk1ySHdQUERKK1ROK2xlVWVpc3FadjJiZmIvaitiSWtMdTc0SFlz?=
 =?utf-8?B?S09uZ3Fzb2M4bUgyUlQ4RG1ocW8rWkFEQTMyMkdDVUlkbEFaWDhMM0ZSK1B5?=
 =?utf-8?B?bkxGK2JhUkxtL1drYk1TM1JleUFCWU4yQi8yWmJrZ1FyQ0VldTg5R0ZlUnJs?=
 =?utf-8?B?am5tM1ZBOU5WdGZUQy9ReG8xeU5VcURwKytxZzFlbGFqYU1KLzdvei9TcGx4?=
 =?utf-8?B?amxCTjZJM2NLNXdlbzlFd01SNnFpVkMyckNWWi8xVy85MDUxSyt2SjRnZEg1?=
 =?utf-8?B?bnNpTVZBOHREOXJRc0ZOWVBMWmRUTFRXTi9mZHQxU3lNNzJVOVJHR3JzTU9u?=
 =?utf-8?B?MmIzNlowYzVSRjdGd3VPNHdwYlNtTm5Lb3d3YmpxVlZCbHVSSkc3UU80TVFz?=
 =?utf-8?B?Z3dPRUk2Z1BqSHovdEV3bzBNZ092ZTN2NnRQV3JiYjlDUDVDaDhDNG5ZYll3?=
 =?utf-8?B?aml4Q2RhcnhxVGYwdE1nR0RLS21pME9rc0FIY2JOQXRTYW1EMVZtRW5HWXlo?=
 =?utf-8?B?ZmZGcTJHSnRERWdrWTROUUk2QlJJS2ZyYlZEcDhrQ2l2c3hpTE1uUm9nRThO?=
 =?utf-8?B?YTlDZUxDUjVUc0hNRU1saXpsbkxGaXd5Wll4Y2ltSzZESm15emNEcUZwM3c2?=
 =?utf-8?B?OTJiZGhqZkorYkloZENFUEwvNkFGTUsyaDBVWVNsMU1HUTM0OStMaUF2Qklm?=
 =?utf-8?B?dEZ4dDZIWWJaT2dIQ05mS010eWl2NDlnUzBWYXA0LytJTXFvVGlFRkM0R0Nk?=
 =?utf-8?B?OUhzb0k0VHpYUFFaYUxsbWdpVVRERFFLQktva2JqbTRxWU4rUldYOGs0NWZX?=
 =?utf-8?B?NVpIRlZNTW5sblpXQnl0WTdYbTR6WHVRcWM0UUZubUFlTHNoMTJIL2dmSE1J?=
 =?utf-8?B?bFYvYkFzTHg2QThpaUNSM21yYlg3NGhmYkJ0d2p5eExlY2dMZVhuSDFWMmlW?=
 =?utf-8?B?UkxiTTU5aDh1dlhvcmkrK2NJRUgxT2E5RFdXZU5NaGJpZ2NPSXJjNUJwSkI0?=
 =?utf-8?B?VFFnYWxyYUx0dEsvSytNZXJ5LzZ3eWQrVEpVaVN6UkgxRE5rUjJqTE0rRjFl?=
 =?utf-8?B?NnovUzNwZ0g0QTZiZ051Zm5ZbWlkSHpoSUdCYSt6ell4NmFWK0E1aEN5MVhn?=
 =?utf-8?B?eFNxWTFGQU9kRHRUMnU5WHRYaFVpNkQxWWdQUitXYTJQRE0xcnA4am1XKzQ2?=
 =?utf-8?B?aDV2VWZGa2VTUVNHdEVJV1VwcEZxYnlZSHRQNm9iZ3EvaXlzUDFHQnRmbFJq?=
 =?utf-8?B?OWxoQzBiNEJXVnF5NVVxNFVvTWVVTFAvWG40bHBESUdTYUVpTWYzaTBQdW00?=
 =?utf-8?B?ZlE2NElIRG5BbDhYWTUrRXBJbGd1bEhzS2dYQ0xwZHZOSGd5T2xiYi9pY293?=
 =?utf-8?B?RldpWFJrbjlMRUNqcWoxZVMxNi9RcWF0YTQwMzdQbS90clNPcGNwSzBoWVor?=
 =?utf-8?B?ZDZ3cW0veUFDMlVnTGNvZHJaU0wwSmJieTJEQWdvcXdCRG1FRkFqZ1JBRGx6?=
 =?utf-8?B?M3k5SGh1ZS90L1hmMS9RUTdPaEl3MUdJZVVxakdMUmlBNHg5NE1vNUZnTldF?=
 =?utf-8?B?d3hNZ3NDRG1VdUxjQXUramM2ODdvd2RJTDJHTmpMdW5hZW1oWUhlZ3JSQ2E1?=
 =?utf-8?B?UjhtQ0J0anpVaW1jNVNvTjJYVUo3Zk8zbnorWVF2WXpyaXN4WnJzQWFVaGI4?=
 =?utf-8?B?ZmVMb09ZNHBnZzNpbWRtUXVwWTl5SHRtOHZoZHp0OGV1S25zSWFPRGFjRWlr?=
 =?utf-8?B?UUl0czZpQnNvR0JaNTFLMEc2aUEwNE1IdXFvcHloZXFPOEZlRzNqdEE4eGlJ?=
 =?utf-8?B?bEtVZ0UxeEtzQVE1aVZpa0dvUTQ1SkNTUWhqMThySzVnOWZZSTU1amMySVdD?=
 =?utf-8?B?Rmhkb2lBcVo1K1JqcHczRjRqcjZiVFJSQzl4Q0dnSU14SzVEdEltR1RhcXlP?=
 =?utf-8?B?c3l0RWVRRVROcXBiSkNjcnRXUndTdVhPUmNyRVhuN0tOZnRnRUlvWmtVa2RR?=
 =?utf-8?B?TVA4bk9MT0xKbjdFck8vOWlFSDR6Z05idlFYVWdDeTQ2OFBRS0xjaXBSanB2?=
 =?utf-8?Q?JITCymNJAca5q4BUP1HTj7kTW0P6BDXW7M7SeQMYR7iwi?=
x-ms-exchange-antispam-messagedata-1: PjkzZhLfQnA1sXWujCXjLA+7/innRUfUzJc=
Content-Type: text/plain; charset="utf-8"
Content-ID: <65371500444C054A9E93E5276B0496B7@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: FyxqlcfF3XSlWJ7FzT4V6mSH8MoD0ksQrWw/rAxyfK55rMlp6cXCHCy9AQtEvRUg7DkSoMWyBPWkvf2/GEb1NdD4tBhje4U7Rfe6FBX4m7mfvb7PJs3i3LtH3LT00aBYbYo+v23dDyaRRvQ3lV47f3Smb9aglUOS8K3HsIZYYE4MGLQDCYHOxzvNgUFwwAVHAzHWk+qeBPuOmT1I0p7C70ab/udYbjw9f2614WEnYJuzO5FdwArVoi5AZfQWzMoi9E7k0ETdmTuXfjRMn/SDIi1iCcZey5wXZ4sMI4lU9FKVWVZAJXzx9dN4jbqFPim/IKmlYpxKKT8i00d04R0y4Q==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: vd98Aj4g6C94p7DIaSNxWpvYE0ggj2rmbP/psDYEpU+hz8bosPJ/Dhe4LIGKY2qrc3sOVtdaXFYkIo1nFTX/0ivIJeEjXeFyjihE6x8pNqpS6jr1EIPJeOpnur/7dlXfXukX88s8fq1VSv76ikOKgQqRmRjTH+3CltPgbtZi/qVsrDLAYoNhN+2VCCgMxbFHkXmZvrtHd9LUsF7I0GnUKMW3rH2mtfNuM8FhszYTvBhNauJyycczeF/79m0YyTaPzYe+iaQW/DWhOhA0ooTAvNM/+yK4toMJlKyIbvV4iKs7FTh0ryvnaR1K1jT27hDJoqdS2AYi2Kxh2ZsmR3Nzdrhr8rWQl0nZzHKOvdJIB49ZSZkYnKMfME2ze0IqCYGq/zEhBedE/zz8H1FuY36Gv2v4Wsi64LloVkBqiYC1RZQgLVVd/0VhuR1TA3BkSg329bUTP/piKNkeSha947CyeVexxIP9dH20uHiapEEgj8XuOgNvOISMwPt4Oh51eMJVmISa1mZKbg1jouLtSkqE12FxhD5wVAzfmh7AHxlsYA76K7kOl4GHrSMy4pIYnFYZ6jb8gnZ1zDCF6DDB/y5gvP6JlNbRlH8hH7SoNjoiBrJZjhl8bX7LTk02cZ+fKYno
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH5PR04MB9550.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72adc65a-eeb9-4e51-8ef8-08debb7d629f
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 May 2026 23:20:33.2559 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: d7gP9G9XiTfK84ZB+jbTA9BaevRPSpnR5EGFqRuDhS41IlXeA2kzbWZDvFWkrc8y4P7nNP3wHj7YN7LqrtQOOocX8bheSm4DskubirojCz0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV0PR04MB9814
Received-SPF: pass client-ip=216.71.154.42;
 envelope-from=prvs=599a94ef2=Alistair.Francis@wdc.com;
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

T24gVHVlLCAyMDI2LTA1LTI2IGF0IDExOjU3ICswMjAwLCBQaGlsaXBwZSBNYXRoaWV1LURhdWTD
qSB3cm90ZToNCj4gVGhlIFNwaWtlIFJJU0MtViBJU0EgU2ltdWxhdG9yIGFpbXMgZm9yIG1heGlt
dW0gY292ZXJhZ2UsDQo+IHNvIGNhbiBzdGFydCB3aXRoIHRoZSAnbWF4JyBDUFUgdHlwZSBieSBk
ZWZhdWx0Lg0KPiANCj4gU2lnbmVkLW9mZi1ieTogUGhpbGlwcGUgTWF0aGlldS1EYXVkw6kgPHBo
aWxtZEBsaW5hcm8ub3JnPg0KDQpSZXZpZXdlZC1ieTogQWxpc3RhaXIgRnJhbmNpcyA8YWxpc3Rh
aXIuZnJhbmNpc0B3ZGMuY29tPg0KDQpBbGlzdGFpcg0KDQo+IC0tLQ0KPiDCoGh3L3Jpc2N2L3Nw
aWtlLmMgfCAyICstDQo+IMKgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0
aW9uKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvaHcvcmlzY3Yvc3Bpa2UuYyBiL2h3L3Jpc2N2L3Nw
aWtlLmMNCj4gaW5kZXggODdmZTBmMjQyZjUuLjA4ZWI3ZWRiOTJmIDEwMDY0NA0KPiAtLS0gYS9o
dy9yaXNjdi9zcGlrZS5jDQo+ICsrKyBiL2h3L3Jpc2N2L3NwaWtlLmMNCj4gQEAgLTM0MSw3ICsz
NDEsNyBAQCBzdGF0aWMgdm9pZCBzcGlrZV9tYWNoaW5lX2NsYXNzX2luaXQoT2JqZWN0Q2xhc3MN
Cj4gKm9jLCBjb25zdCB2b2lkICpkYXRhKQ0KPiDCoMKgwqDCoCBtYy0+ZGVzYyA9ICJSSVNDLVYg
U3Bpa2UgYm9hcmQiOw0KPiDCoMKgwqDCoCBtYy0+aW5pdCA9IHNwaWtlX2JvYXJkX2luaXQ7DQo+
IMKgwqDCoMKgIG1jLT5tYXhfY3B1cyA9IFNQSUtFX0NQVVNfTUFYOw0KPiAtwqDCoMKgIG1jLT5k
ZWZhdWx0X2NwdV90eXBlID0gVFlQRV9SSVNDVl9DUFVfQkFTRTsNCj4gK8KgwqDCoCBtYy0+ZGVm
YXVsdF9jcHVfdHlwZSA9IFRZUEVfUklTQ1ZfQ1BVX01BWDsNCj4gwqDCoMKgwqAgbWMtPnBvc3Np
YmxlX2NwdV9hcmNoX2lkcyA9IHJpc2N2X251bWFfcG9zc2libGVfY3B1X2FyY2hfaWRzOw0KPiDC
oMKgwqDCoCBtYy0+Y3B1X2luZGV4X3RvX2luc3RhbmNlX3Byb3BzID0gcmlzY3ZfbnVtYV9jcHVf
aW5kZXhfdG9fcHJvcHM7DQo+IMKgwqDCoMKgIG1jLT5nZXRfZGVmYXVsdF9jcHVfbm9kZV9pZCA9
DQo+IHJpc2N2X251bWFfZ2V0X2RlZmF1bHRfY3B1X25vZGVfaWQ7DQo=

