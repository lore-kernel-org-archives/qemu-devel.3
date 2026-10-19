Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68FD4CCA490
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2026 03:14:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIdoO-0007ON-Fg; Sun, 18 Oct 2026 23:13:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=7454c2a62=Alistair.Francis@wdc.com>)
 id 1xIdo7-0007O3-Gy; Sun, 18 Oct 2026 23:13:04 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=7454c2a62=Alistair.Francis@wdc.com>)
 id 1xIdo5-0005S1-Mc; Sun, 18 Oct 2026 23:13:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1792379581; x=1823915581;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=1bAOpEfGgOIiz/eA5WDPovzB3PzMFz7K2JeWf0whLr4=;
 b=cnGaCmRPRyEnsveIRran6Yicb02QhOzd5nQ2afm4nPGkb7J9syZRx/HO
 8HsSINgh0sseXTg3W6M9wjMaokUkT6VTF32Xtmj/39H8Wb74mx7aRasBA
 JyRCkU1xo9kd9PvYEtIh+1utn+N46Uh344DIGhFWZvUNwbXYPtaEtcUWk
 uiInFDoJYfl3Y+EOKdlPBLSdkYDESFVx8MK2Ylu60ldMIqRCoNsI9Gu3y
 A2/6wdH0BCk644Lc1JcEQCGmwbHkBIYPS51U+qCiu9wTIRny8NVvsJ1fH
 nGjhNLVXdTpMUZijw8SmRHXwe3nQaNIm9XsFFxr+ypNAzo3Xn0dfFX67i g==;
X-CSE-ConnectionGUID: 2owswymMRNKh6Fy6GPBu5w==
X-CSE-MsgGUID: daCu2XAkTEuyF7W3utwPLg==
X-IronPort-AV: E=Sophos;i="6.27,166,1786982400"; d="scan'208";a="156806897"
Received: from mail-eastusazon11011019.outbound.protection.outlook.com (HELO
 BL2PR02CU003.outbound.protection.outlook.com) ([52.101.52.19])
 by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 19 Oct 2026 11:12:57 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nSEuhk2T6cTeoQuXhSlwwm6QEe7+hJXRmCZMZXDP9LOdlp2zqphMN11ib4YQjXC9CFj1PDOpUJUHll4YiGbD4iXWcZgXKIVvhhjo2AECxfs79IUBz82ZfSx9YHyWofv1xmZ3XlZ3xfG1u914MKy+EM/jMRda0jkY3jAm4JajJudPJC7TeI++801MpnQFU5II/hc3ZpD1UkXS/113QrY+bajL9gQlcz59Hvid45YjFliLdCtmyJRY105LYBlgWl+1bc4XBFFb/Fck0KBg7fObKKv8hdzZCy1ILKlb8r8PLXJcPwVK8KeaX1A2HzT22WVf4wRqLSy/TExLv+HV1/RxYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1bAOpEfGgOIiz/eA5WDPovzB3PzMFz7K2JeWf0whLr4=;
 b=gTT38pxoD1Il+hLk8tYXRxTxsrgziWYLyHmqISYtUcCvCZHFazlpG9mhMkxSVaJRl0hfQwYqiCiTMT4keqhlXmOIMmmAt4CcYpCl/gcix/1j3giD9B2LUI+o85PhDC1LuGdUtIx2TUBB0JwxowZqrEDgulggobbvEG7pdZ7XPeo8Fl4x/LxdnuWwSH83QOZAogYwCcbcPoG94WZIi4U8Faecr321dmsJ1Nyc1KcyYSEcszK4mKEZLi+nMTblIAdkKArMMOl9ORr/CTwSaDmEQhoSBjAEAMBoymTndQaf9xztl1ubu+9YH/vrct5Lq0lP2ci9sesKLHyGtBpSbEXhFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1bAOpEfGgOIiz/eA5WDPovzB3PzMFz7K2JeWf0whLr4=;
 b=0GzUCvLIxgxaqqXTExFXlatZYdviPbfD0R1nLKCOzQRenO+0VS+N/oyp5IggV9fcHQ80JdSDYmwT6muFPrd6JjaVc1yYNVOYNgPxA0w8qBEfOWRqx/PMfECr5U4iVtADnQ1bpOr6chIaPR5wC21VsziX5PbjmuVUT1DqZdzWZVc=
Received: from MN6PR04MB9359.namprd04.prod.outlook.com (2603:10b6:208:4f2::13)
 by DM6PR04MB6812.namprd04.prod.outlook.com (2603:10b6:5:240::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Mon, 19 Oct
 2026 03:12:55 +0000
Received: from MN6PR04MB9359.namprd04.prod.outlook.com
 ([fe80::e729:bbef:5a37:2e77]) by MN6PR04MB9359.namprd04.prod.outlook.com
 ([fe80::e729:bbef:5a37:2e77%4]) with mapi id 15.21.0522.017; Mon, 19 Oct 2026
 03:12:55 +0000
From: Alistair Francis <Alistair.Francis@wdc.com>
To: "portias@oss.tenstorrent.com" <portias@oss.tenstorrent.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "zhiwei_liu@linux.alibaba.com" <zhiwei_liu@linux.alibaba.com>,
 "daniel.barboza@oss.qualcomm.com" <daniel.barboza@oss.qualcomm.com>,
 "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "palmer@dabbelt.com"
 <palmer@dabbelt.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "mpe@kernel.org" <mpe@kernel.org>, "asrinivasan@oss.tenstorrent.com"
 <asrinivasan@oss.tenstorrent.com>, "richard.henderson@linaro.org"
 <richard.henderson@linaro.org>, "npiggin@gmail.com" <npiggin@gmail.com>,
 "liwei1518@gmail.com" <liwei1518@gmail.com>,
 "pierrick.bouvier@oss.qualcomm.com" <pierrick.bouvier@oss.qualcomm.com>,
 "joel@jms.id.au" <joel@jms.id.au>, "zhao1.liu@intel.com"
 <zhao1.liu@intel.com>, "alex.bennee@linaro.org" <alex.bennee@linaro.org>,
 "chao.liu@processmission.com" <chao.liu@processmission.com>,
 "philmd@oss.qualcomm.com" <philmd@oss.qualcomm.com>
Subject: Re: [PATCH 05/12] hw/riscv/atlantis: Create CPU cluster for Atlantis
 cpus
Thread-Topic: [PATCH 05/12] hw/riscv/atlantis: Create CPU cluster for Atlantis
 cpus
Thread-Index: AQHdXFPq23B4Jw7tGku0WNDTo2uWWbcENs4A
Date: Mon, 19 Oct 2026 03:12:55 +0000
Message-ID: <022b8682b47659bd4430ad7cbcd084ee26031f07.camel@wdc.com>
References: <20261015031804.2406055-1-portias@oss.tenstorrent.com>
 <20261015031804.2406055-6-portias@oss.tenstorrent.com>
In-Reply-To: <20261015031804.2406055-6-portias@oss.tenstorrent.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.62.0 (by Flathub.org) 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN6PR04MB9359:EE_|DM6PR04MB6812:EE_
x-ms-office365-filtering-correlation-id: 084cc22a-a2c6-44c3-96b3-08df2d8edeb1
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|19092799006|1800799024|366016|23010399003|10070799003|7416014|376014|38070700021|56012099006|260925021911599003|260925022911599003|260925021311599003|11063799006|4143699003|261009223027099003|10067099003|18002099003|22082099003;
x-microsoft-antispam-message-info: tiyF9LtC7oSzH7Q3WklnrK2d73UT4I9ySH7QbrRQT7NuJeNp8h1B2QvRRrG2BOyDtiOEtkHEGxaMULrz7lpMk3W5ErYlJ2+yqX7srkePUo/DFmoDfog+g819g+R4uc+mEe/Ck4Tla1XCpaNxqv/ExL8cCw2ZiNKG98+Q90bL9VgVZH6lHGD7oDlCczdPkjU14Hr9uvXW5sij7WFNNd/ni6uLDyNX75acKi4VvSFOjyN5m11h2rRIfp2sBg8BFImh24E62AlXYo7ZtzDi3EkStUo9wmVkaUA/IXBOr3p5ybBAoKUIEkEXdCrGdSqevmPed22K2SGCSePt1lkV7NDqJbfxpP+NkzDjkXKxkpiU5S+pKcIk9rY54dEJ6nEG/Du6/ccRRKLJ/FTOErfrL1nFUL6pEZm6CJYrQzkAtNlUkN72+qgzuHEBpoO3tdMzj2+ZDn+UQXd7nXVXp61or2yyMbrmmu56OYmmc1AsR42TK3Cbun88g0rPhRmLyAhjVyf7/Yo5loR3hBUb+LzkublndVQ3FN+NM283b50C39yz1ebGfZUEowgNpbxdz5i0siCkkcVCzFgBhzcBa+tXJr6hdExg7mDilQlHWgIRMTbK1od0gayIy+OJacRyXuGSapgwvcn/KooYZm+Ke4JsgDaki17qufX7cstzNnS8KlNpQazwwGgAtllOkWD8UGT5COJefa8TMNSM1XJZlMdEnMlXimvV+fTyOJx4CNddOKk9wK8=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN6PR04MB9359.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(1800799024)(366016)(23010399003)(10070799003)(7416014)(376014)(38070700021)(56012099006)(260925021911599003)(260925022911599003)(260925021311599003)(11063799006)(4143699003)(261009223027099003)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RS9yZ0FGNXYzdzBaaHo4bE95Yi9QRUdiWktZZlJSSzhaMHdZY0tHSzBIcENK?=
 =?utf-8?B?ckpSV0dRZXJtR2d3cmg0RGFiZy9WakdMT29Nci9kcmRJZ2s0QnhUQXh1UGht?=
 =?utf-8?B?RUhQQ3lYNGZiTVQ5ZFQ4YnNjZ0hLbk1xV29KeTNQRWtPai8rUHhJU21uc291?=
 =?utf-8?B?V2VCZ2ZFcEE4aTc0L05XNkVyNldBRmF5ZmR4OXdHNHNuVUpqOUxJMys5Z1J0?=
 =?utf-8?B?aC9tVlloR1haTmhRR1NWVnhKS1ByZU8rYThzU0ZNU1JacjR6ZElRTmYzRUZr?=
 =?utf-8?B?ZWIvbUp4bnllL1VrQlM5V3RJOXUzaitUazJMQ1p6L09vSFFiRmtuOVg2eFNw?=
 =?utf-8?B?YjhoWVhoNlN1MWlTamVBdk5oeUUxQjdWYlFUMGxSN2s2a0tkWDRrZmRKOFNP?=
 =?utf-8?B?WStiVlM1dS9DV0EzOFJtMU9lLzYzdnNBdXA0cUR3UU9TQjFkRkV1cnh3dUtT?=
 =?utf-8?B?aWNMeEM2d2NMSnZHYkJhWXNTamo5WUFTVmcwbVdHQXFEa005WGJDZnpqZ3ls?=
 =?utf-8?B?cndpMCtjR2RJYU9COWNCOVhVdnppQmhTSW5JTkhBSTBpOHFpT0E1bmswNHk2?=
 =?utf-8?B?UFZjcGVEdXFEb0hPRU5nVEsrR0xDL0F4ckNCdkFEdTZDTXJOcEI4Z3RPU3Z4?=
 =?utf-8?B?QzBteVFLUW5icXRBeWlsZk0ra3c0ZDdMaDdlSmY5emRpLzcyayttbGdydmU1?=
 =?utf-8?B?RThVSko3eC9rOUxTQnpXWnVKa1NCVFVyalI4dmp5aWxjN2lieENtQ09mNldr?=
 =?utf-8?B?OVFQdzhTaWJ3V3NXZXdTRTF3VjB2VWgyOTRXRXhwOTlWcGtqcHNWT0xmZDli?=
 =?utf-8?B?Zm52WEoxbUdEUFU2dWR3akQ2YVBrL3BFOTZnNWF5ejMza3ptRDh3Umc0aDBE?=
 =?utf-8?B?WjkwN3VPQThpWGdjWEtMTElyZkFWelZ1VCtqd25IdXNWbTJQKzc3bzBUeDF3?=
 =?utf-8?B?U0Flck9mSDJOVktWT2NMTlhKTkdKSFJ6Mmw3cFEwMndXWEtKMkxYekt3c3R0?=
 =?utf-8?B?ZGh6NEpJV2VvUUgyaWxQLzdKdHgxclZCMjdLa3had0tvMkVxL3hEVVJHT3l2?=
 =?utf-8?B?bi95WnlaV1M0Z0xRRWxjMlgxdGdOZVBBYnBHcFRURkhaTVYwV2hZaHZzM1J4?=
 =?utf-8?B?WS9HY3RTc2d2djZ2TlJFSFNvZ0tLNllPcXJ3YkdiOEg4MVY3U2hPSmpmaW96?=
 =?utf-8?B?dUxodEtCcmMybFZQM2NRNkE2aHUza2s0cVYwZnhDRXJ3YWRiM0VvNHp6ZWpO?=
 =?utf-8?B?S2NSQlNYeDU5OEhNQUJoOGk0VnFMTmY2d2kzYThmdldDQXhIT3lqUTFlRUNo?=
 =?utf-8?B?ckpuVTY0dy9BTjN6dFE1MmZ0b2VOckxUYUloSWM4QWJYTDJlaEdDQllTdmpp?=
 =?utf-8?B?T3VscG8yRWpXMUhOTitjakdtalRaY1ZCM2VNVXpxK2hpQUI1aGJkdWJpbWZ0?=
 =?utf-8?B?QTY4OFY1OUtsSkZYSU56ZUhTbUFFeTJiM0EvNjdta3BUeWU2NnlvNlg0dk5H?=
 =?utf-8?B?dkxNV0FtNFJKRzFtcXdtREtkaEgzQU9HYkZ2VUN5clJnY1JSYmpFZ0N6eGlo?=
 =?utf-8?B?QnRoaURFWC9qZ0NCQzVDVzhFNUpTSzN3RytqS3EzU0RHTFpJaThFWDdrODV5?=
 =?utf-8?B?WnB0SlRwQkE3Z0hEeENpR21BUkdPR2h0SmQ5ZHp2WjE1QURrdHZDcmNYeFQ3?=
 =?utf-8?B?ejYxQ1NEUE4vdXU4TUIybEZxd0RlVDRSVU4vWUdqN3JvUEVveU1UNWg4d205?=
 =?utf-8?B?ZmtLR09qRW1temY4MzQ4OTZiby84VGtBVXRVRGtpODVsUG50VWlMcDFTVXEx?=
 =?utf-8?B?NHVML25OMENaWTlBTWZJd2VrUkltc01IZ2d0TkNrRDFmYUVlL2Z0cE13ZnJu?=
 =?utf-8?B?dUEzVHR3Tk1KYUlFUEduYW8yK21kclRZd1VnQnVDTmxhcEdhR3hwKytBRlN6?=
 =?utf-8?B?Uzl3dnZvd3dONDhMV2g2MlVKTHdFQS9adG5HSmdCcVE3WUpnQ0JPTFdWMVVj?=
 =?utf-8?B?Q2pHSEc5Zi9FUFBBRG5QenhTdzVlZW9WYVk1ZnE2STdmaFExRWlGVnFCekg2?=
 =?utf-8?B?NnA1UlZuZmcwUVJXbHhiTmZ2L2FGMUorKzlhMDFTSDhUM244QzRhZ1I3OFpq?=
 =?utf-8?B?TVJheit4cjNQZkVRVVp0dno1elNwemFXblV2V1o4Ny82UitIMUE2cm9mT2M0?=
 =?utf-8?B?SlNPczJKYWNIQmpnSWVVdVhWWW1ZNGdvK0RDUncrTjFrWVZCWVBOT2FibnFR?=
 =?utf-8?B?UXEyUndwVGZnYXVYYnpkWU1WeFY5R1hjcVAxOGdrdUd5R1J3TDVDMXltUGl5?=
 =?utf-8?B?TG5FYWg4UWdtQkU3R0VsSFB0RHdlY2wwOXF4b0w1WDZjNjRaMWNMdEw5Y2hE?=
 =?utf-8?Q?FVQ/rW1OjZbQlgLxOG3tTI5pzUe7AycT8y3fhx30l5sdR?=
x-ms-exchange-antispam-messagedata-1: nmQB+XM7z1u0Loh3aweKD42nnaFrtFAoSn4=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3D2857FDA1E972498D09B8F0385F357A@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: M7sNons6kBK/96JCBqwXnXXmf9NXjulxV4R0ICo/R9jOAiXJ9QayBs/RHTlCgNh55+1IlVuiqCuO1hcxrY3m9Q5a9/BsLXCZjHKW96OecpkYcFvlreYtGdJv5usBJivglZ1V1Sx3uOfYCzCYevWNvFCkmZmr9YuUD93DcTQbH3SeY7Bw4+x8GXPUl0yMNjCHFq7gB30VN+4PwSMNpkWhGsZp1WIBcmL87tM4QlS4EIQp8sZOglXVfKVq8RZA9pypqGyYp474g9sUHL8sZHn+kFhofvU1oUHt1X5+YiPG+gDMUlCGVOVyL5UNtzZ4gjbc72q5MmmkLznpXyFzLvk6Dw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: zsnvJo1zeq/YFWKcB+z0tUnD6hfstYGWInB7oeeyHDdEc2woFQ6coAWSnx9aBlwDWX9V1M6f8jOfJSu/+uepefr1NVyspp0kkc4Vt9NhL7ldIfvpzXUHNDn6GSQg8f63zVyPQ10Faj3+Rm+FC/vInxG+Cp0F42ZpB3RUEynsHRw7IEFXy2T24amq5ZiKcETuPqrzjUD22tIbS4PT9SMVUAp8B+d6PCD2bBbcbdjJDYpY8eWYuwrF+i0/sTMCSZfsX00dYHhiADai7BALBJ14yCWLqSKofY0lkSQtLdySingihh+dhOYlfDzll620kGII53dNUadPr/3E81uX48PjUUCIuPTJ2QstJx5QnPGPfglhGCSykIMpsZN/HUPMY2xxpaX/Isx2p0tGrLvQCtZsAUy87mThNgK4UZAA4Eqc9v4AEACkQimLALYLhKVSTT2Txw2tQjeRHeVi3Qt8DoHR/0i/EN7ZFQrSl+az71w5s8xZDIRkygPPKJUsygO9MMSR9F7Zg7kdiVhAf2e/IxzO41H54qMaf+9XgoM7j0Fg9m5VZEwlYjat4jSP4VnzIcdd+hu2inKiLnQqhDM1w0qAYQcbenwXEUEUAe8ftHWArF5Pez8+MA/vSaQclp2EzbKC
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN6PR04MB9359.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 084cc22a-a2c6-44c3-96b3-08df2d8edeb1
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Oct 2026 03:12:55.4562 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Cr4QeHzydhjLypeIsptt0j+iENmIi9ZjOyvKGoDYHs/+ly0Zuu6tJywprZKzM7PxaVa7GUotkYMek0LTlQXJJCTD6NcHzYo+8NXHByn3C9I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB6812
Received-SPF: pass client-ip=216.71.154.45;
 envelope-from=prvs=7454c2a62=Alistair.Francis@wdc.com;
 helo=esa6.hgst.iphmx.com
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

T24gVGh1LCAyMDI2LTEwLTE1IGF0IDEzOjE3ICsxMDAwLCBQb3J0aWEgU3RlcGhlbnMgd3JvdGU6
DQo+IEluIHByZXBhcmF0aW9uIGZvciBhZGRpbmcgdGhlIFJDUFUsIHB1dCB0aGUgQXNjYWxvbiBo
YXJ0cyBpbiBhDQo+IENQVUNsdXN0ZXIuIFRoaXMgd2lsbCBhbGxvdyBnZGIgdG8gcHJvcGVybHkg
aGFuZGxlIENQVXMgb2YgZGlmZmVyZW50DQo+IHR5cGVzLg0KPiANCj4gU2lnbmVkLW9mZi1ieTog
UG9ydGlhIFN0ZXBoZW5zIDxwb3J0aWFzQG9zcy50ZW5zdG9ycmVudC5jb20+DQoNClJldmlld2Vk
LWJ5OiBBbGlzdGFpciBGcmFuY2lzIDxhbGlzdGFpci5mcmFuY2lzQHdkYy5jb20+DQoNCkFsaXN0
YWlyDQoNCj4gLS0tDQo+IMKgaHcvcmlzY3YvS2NvbmZpZ8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgfMKgIDEgKw0KPiDCoGh3L3Jpc2N2L3R0X2F0bGFudGlzLmPCoMKgwqDCoMKgwqDCoMKg
IHwgMTMgKysrKysrKysrKysrLQ0KPiDCoGluY2x1ZGUvaHcvcmlzY3YvdHRfYXRsYW50aXMuaCB8
wqAgMiArKw0KPiDCoDMgZmlsZXMgY2hhbmdlZCwgMTUgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlv
bigtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2h3L3Jpc2N2L0tjb25maWcgYi9ody9yaXNjdi9LY29u
ZmlnDQo+IGluZGV4IGQ4OWZkZmNjODYuLjRlY2NmYTQ0M2UgMTAwNjQ0DQo+IC0tLSBhL2h3L3Jp
c2N2L0tjb25maWcNCj4gKysrIGIvaHcvcmlzY3YvS2NvbmZpZw0KPiBAQCAtMTQ5LDYgKzE0OSw3
IEBAIGNvbmZpZyBURU5TVE9SUkVOVA0KPiDCoMKgwqDCoCBzZWxlY3QgREVTSUdOV0FSRV9JMkMN
Cj4gwqDCoMKgwqAgc2VsZWN0IERTMTMzOA0KPiDCoMKgwqDCoCBzZWxlY3QgVE1QMTA1DQo+ICvC
oMKgwqAgc2VsZWN0IENQVV9DTFVTVEVSDQo+IMKgDQo+IMKgY29uZmlnIFhJQU5HU0hBTl9LVU5N
SU5HSFUNCj4gwqDCoMKgwqAgYm9vbA0KPiBkaWZmIC0tZ2l0IGEvaHcvcmlzY3YvdHRfYXRsYW50
aXMuYyBiL2h3L3Jpc2N2L3R0X2F0bGFudGlzLmMNCj4gaW5kZXggZjA4N2ZkMTZlMy4uNWEyNjY1
YjIxMSAxMDA2NDQNCj4gLS0tIGEvaHcvcmlzY3YvdHRfYXRsYW50aXMuYw0KPiArKysgYi9ody9y
aXNjdi90dF9hdGxhbnRpcy5jDQo+IEBAIC01MCw2ICs1MCw4IEBAIFFFTVVfQlVJTERfQlVHX09O
KFRUX0lNU0lDX1NUUklERSAhPSAoMHgxMDAwIDw8DQo+IFRUX0lNU0lDX0dVRVNUX0JJVFMpKTsN
Cj4gwqAjZGVmaW5lIFRUX0FDTElOVF9NVElNRUNNUMKgwqDCoMKgwqAgMHg4MDAwDQo+IMKgI2Rl
ZmluZSBUVF9BQ0xJTlRfVElNRUJBU0VfRlJFUSAxMDAwMDAwMDAwDQo+IMKgDQo+ICsjZGVmaW5l
IEFTQ0FMT05fQ0xVU1RFUl9JRMKgwqDCoMKgIDANCj4gKw0KPiDCoHN0YXRpYyBjb25zdCBNZW1N
YXBFbnRyeSB0dF9hdGxhbnRpc19tZW1tYXBbXSA9IHsNCj4gwqDCoMKgwqAgLyogS2VlcCBzb3J0
ZWQgd2l0aCA6JzwsJz4hc29ydCAtZyAtayA0ICovDQo+IMKgwqDCoMKgIFtUVF9BVExfRERSX0xP
XSA9wqDCoMKgwqDCoMKgwqDCoMKgwqAgeyAweDAwMDAwMDAwLMKgwqDCoCAweDgwMDAwMDAwIH0s
DQo+IEBAIC01NTYsNyArNTU4LDEwIEBAIHN0YXRpYyB2b2lkIHR0X2FzY2Fsb25fY2x1c3Rlcl9p
bml0KE9iamVjdCAqb2JqKQ0KPiDCoHsNCj4gwqDCoMKgwqAgVFRBc2NhbG9uQ2x1c3RlclN0YXRl
ICphYyA9IFRUX0FTQ0FMT05fQ0xVU1RFUihvYmopOw0KPiDCoA0KPiAtwqDCoMKgIG9iamVjdF9p
bml0aWFsaXplX2NoaWxkKG9iaiwgImNwdXMiLCAmYWMtPmNwdXMsDQo+IFRZUEVfUklTQ1ZfSEFS
VF9BUlJBWSk7DQo+ICvCoMKgwqAgb2JqZWN0X2luaXRpYWxpemVfY2hpbGQob2JqLCAidHQtYXNj
YWxvbi5jbHVzdGVyIiwgJmFjLT5jbHVzdGVyLA0KPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIFRZUEVfQ1BVX0NMVVNURVIpOw0KPiArwqDC
oMKgIG9iamVjdF9pbml0aWFsaXplX2NoaWxkKE9CSkVDVCgmYWMtPmNsdXN0ZXIpLCAiY3B1cyIs
ICZhYy0+Y3B1cywNCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCBUWVBFX1JJU0NWX0hBUlRfQVJSQVkpOw0KPiDCoH0NCj4gwqANCj4gwqBz
dGF0aWMgdm9pZCB0dF9hc2NhbG9uX2NsdXN0ZXJfcmVhbGl6ZShEZXZpY2VTdGF0ZSAqZGV2LCBF
cnJvcg0KPiAqKmVycnApDQo+IEBAIC01OTQsNiArNTk5LDEyIEBAIHN0YXRpYyB2b2lkDQo+IHR0
X2FzY2Fsb25fY2x1c3Rlcl9yZWFsaXplKERldmljZVN0YXRlICpkZXYsIEVycm9yICoqZXJycCkN
Cj4gwqDCoMKgwqAgaWYgKCFzeXNidXNfcmVhbGl6ZShTWVNfQlVTX0RFVklDRSgmYWMtPmNwdXMp
LCBlcnJwKSkgew0KPiDCoMKgwqDCoMKgwqDCoMKgIHJldHVybjsNCj4gwqDCoMKgwqAgfQ0KPiAr
DQo+ICvCoMKgwqAgcWRldl9wcm9wX3NldF91aW50MzIoREVWSUNFKCZhYy0+Y2x1c3RlciksICJj
bHVzdGVyLWlkIiwNCj4gQVNDQUxPTl9DTFVTVEVSX0lEKTsNCj4gK8KgwqDCoCAvKiBjbHVzdGVy
IG11c3QgYmUgcmVhbGl6ZWQgYWZ0ZXIgdGhlIGhhcnQgYXJyYXkgKi8NCj4gK8KgwqDCoCBpZiAo
IXFkZXZfcmVhbGl6ZShERVZJQ0UoJmFjLT5jbHVzdGVyKSwgTlVMTCwgZXJycCkpIHsNCj4gK8Kg
wqDCoMKgwqDCoMKgIHJldHVybjsNCj4gK8KgwqDCoCB9DQo+IMKgfQ0KPiDCoA0KPiDCoHN0YXRp
YyBjb25zdCBQcm9wZXJ0eSB0dF9hc2NhbG9uX2NsdXN0ZXJfcHJvcHNbXSA9IHsNCj4gZGlmZiAt
LWdpdCBhL2luY2x1ZGUvaHcvcmlzY3YvdHRfYXRsYW50aXMuaA0KPiBiL2luY2x1ZGUvaHcvcmlz
Y3YvdHRfYXRsYW50aXMuaA0KPiBpbmRleCA1MmI0NDUwNGFlLi5lNWZjZTFmNjc1IDEwMDY0NA0K
PiAtLS0gYS9pbmNsdWRlL2h3L3Jpc2N2L3R0X2F0bGFudGlzLmgNCj4gKysrIGIvaW5jbHVkZS9o
dy9yaXNjdi90dF9hdGxhbnRpcy5oDQo+IEBAIC0xNSw2ICsxNSw3IEBADQo+IMKgI2luY2x1ZGUg
Imh3L2ludGMvcmlzY3ZfaW1zaWMuaCINCj4gwqAjaW5jbHVkZSAiaHcvbWlzYy90dF9hdGxhbnRp
c19wcmNtLmgiDQo+IMKgI2luY2x1ZGUgImh3L2NoYXIvZHc4MjUwLmgiDQo+ICsjaW5jbHVkZSAi
aHcvY3B1L2NsdXN0ZXIuaCINCj4gwqAjaW5jbHVkZSAiaHcvcmlzY3YvcmlzY3ZfaGFydC5oIg0K
PiDCoA0KPiDCoCNkZWZpbmUgVFlQRV9UVF9BVExBTlRJU19NQUNISU5FIE1BQ0hJTkVfVFlQRV9O
QU1FKCJ0dC1hdGxhbnRpcyIpDQo+IEBAIC00MCw2ICs0MSw3IEBAIHN0cnVjdCBUVEFzY2Fsb25D
bHVzdGVyU3RhdGUgew0KPiDCoMKgwqDCoCBNZW1vcnlSZWdpb24gbWVtb3J5Ow0KPiDCoA0KPiDC
oMKgwqDCoCBSSVNDVkhhcnRBcnJheVN0YXRlIGNwdXM7DQo+ICvCoMKgwqAgQ1BVQ2x1c3RlclN0
YXRlIGNsdXN0ZXI7DQo+IMKgwqDCoMKgIE1lbW9yeVJlZ2lvbiBib290cm9tOw0KPiDCoA0KPiDC
oMKgwqDCoCB1aW50MzJfdCBudW1faGFydHM7DQo=

