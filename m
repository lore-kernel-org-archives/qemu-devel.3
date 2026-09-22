Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B35E1C982F1
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2026 05:38:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x8tCg-0008F8-TZ; Tue, 22 Sep 2026 01:38:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=718ae7c5e=Alistair.Francis@wdc.com>)
 id 1x8tCT-0008EE-BH; Tue, 22 Sep 2026 01:37:53 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=718ae7c5e=Alistair.Francis@wdc.com>)
 id 1x8tCP-0007y5-GC; Tue, 22 Sep 2026 01:37:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1790055469; x=1821591469;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=q8h/K91Y8xVmJEPbPQC+ehuomlLg9uChp5pJXIKP+xM=;
 b=grOIVs1MZikaGgy8tvV7jn0KtR0nnCmy8WCa3KqLPj4k/MbTpPzGRlR8
 RjDXTmjNAAfrsUUS+dY9+RFFVzLF8nDCedCWulVvoAHXeTxL8ilGJHZo8
 RTBQjTw03sYz1BEnUjItPh4ymanmnxSWz5SrI+SDGlIPuVdsA64NwB6X3
 npYxX9yyj298pnAl1AyRcJBFkyr/j4/EgB9fMeATKibegSTm0i86wQufL
 ym30D0CFCGqb05znYepFwNpNIrDKcioPTBcwgons8snXmh2nRhZtnLqRj
 8KNj1o8OHwpMcwsDxoSgFioJfT/uz/luMCMDejSrJmAe2F0L2u33yZQQE g==;
X-CSE-ConnectionGUID: Euii88BiTcy56ZcXlhZUpg==
X-CSE-MsgGUID: Zn3YzHTyTQqreo6P4Bzk1w==
X-IronPort-AV: E=Sophos;i="6.27,115,1786982400"; d="scan'208";a="155283191"
Received: from mail-westus3azon11010066.outbound.protection.outlook.com (HELO
 PH7PR06CU001.outbound.protection.outlook.com) ([52.101.201.66])
 by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 22 Sep 2026 13:37:45 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oAmSFp/oZsDZ4Ki+/O2IVYpiC6k1jMlD40JGi/SIh+DLdq/4/1asNklsIyWJrsJKoM3dBWfuvJceJqIhjr8G+jy2WWiRSTf0c0xVDC0PWdq3IuXBTAd1Iev5tlcjKLPjaZ4OKBn1I3ymzpuK5QjVYoD719/9YnJtGXzQWSuuaeeOCp2jMTg0fpU9sNuTZPVT+AkwPN5Ss1DyaRBCfjBS8Q2toEzxW7CIPT86zotW/4Bd5nKbSwDl5O5dUPVuJkt0p53J5VA/orF/FGOCSmUX3qDak06wE6H4E/JM7yrmTdf4CU9xB8ftJxBUQbBUjgoa3MpcUeSPTmR2HFu5QwYIog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q8h/K91Y8xVmJEPbPQC+ehuomlLg9uChp5pJXIKP+xM=;
 b=Eb0DdOcRnigsEnbQEeD6JkalARs+8JwtTuNaEXJjd4oVvPByB6bzbd0nX09IyKf+Q6jdxYUFFjOfpzGL7JGAhx77sAREyseHPh1mrjm8IzIM/dNnjF8yasTRTp1sV80oYQ4CEQVDku1FR0jusfbFADsrzLHksr1dLRWeSMf0fMgbDLnd4cCRMA2Iqk820F2/dptKuQo+4U+vksVNYIii9Nv3+c/+xl+X3boAZJlrAE2hvln2SjGFX4rfEUmiWR3ZYIeJC8OOz9MRA4r1mBZjx7tWCf/hrjVLzQ62l4smGv61HBYHlJFnGk/C9V51wYOgUM2MiHzdbZ0cXZwrrQc81A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q8h/K91Y8xVmJEPbPQC+ehuomlLg9uChp5pJXIKP+xM=;
 b=TqFfsPHXyvF9pR3jxpilUpe5BLnfnX/h2iqDS8L/cKfBfBD6IDoU5N7UTjuLNYGfopoVDStmP/Z1ousxZyUYlkyU4Ma/zo0NHgtbO2P3JvkwDF+/Xzn4UAvLBVu9EgMSVqrNVA8a3CDFxerG0KpAVZebG5T6ON0wqQGnbjwJISI=
Received: from BY1PR04MB9561.namprd04.prod.outlook.com (2603:10b6:a03:5b6::11)
 by DS0PR04MB9318.namprd04.prod.outlook.com (2603:10b6:8:1ff::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.14; Tue, 22 Sep
 2026 05:37:43 +0000
Received: from BY1PR04MB9561.namprd04.prod.outlook.com
 ([fe80::3869:e494:2fa8:9888]) by BY1PR04MB9561.namprd04.prod.outlook.com
 ([fe80::3869:e494:2fa8:9888%6]) with mapi id 15.21.0428.015; Tue, 22 Sep 2026
 05:37:43 +0000
From: Alistair Francis <Alistair.Francis@wdc.com>
To: "fritchleybohrer@gmail.com" <fritchleybohrer@gmail.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "palmer@dabbelt.com"
 <palmer@dabbelt.com>, "daniel.barboza@oss.qualcomm.com"
 <daniel.barboza@oss.qualcomm.com>, "chao.liu@processmission.com"
 <chao.liu@processmission.com>, "liwei1518@gmail.com" <liwei1518@gmail.com>,
 "zhiwei_liu@linux.alibaba.com" <zhiwei_liu@linux.alibaba.com>
Subject: Re: [PATCH] target/riscv: report WRS.NTO opcode in tval on illegal
 instruction
Thread-Topic: [PATCH] target/riscv: report WRS.NTO opcode in tval on illegal
 instruction
Thread-Index: AQHdOfKiWDFr+n3s3kG6AXb7UEJxq7baNRKA
Date: Tue, 22 Sep 2026 05:37:42 +0000
Message-ID: <445bc28cc8aa67d89099a7faec6d358618d565a3.camel@wdc.com>
References: <20260901091622.88113-1-fritchleybohrer@gmail.com>
In-Reply-To: <20260901091622.88113-1-fritchleybohrer@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.60.2 (by Flathub.org) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY1PR04MB9561:EE_|DS0PR04MB9318:EE_
x-ms-office365-filtering-correlation-id: e0cdbe22-5ec7-4856-9166-08df186b9fbb
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|23010399003|10070799003|19092799006|366016|1800799024|38070700021|56012099006|11063799006|10067099003|22082099003|18002099003|6133799003|3023799007;
x-microsoft-antispam-message-info: kcXeB2fmWjzByrOHRwsu1XLFibcc05uNuMagACtvfzKMnaPQry1pnvvkwNnewIdsFOEtJGLKFHMILvAdRVzcJhV2AipxAGzhERrLcx6W4FJ2aMKEoNpovdectDu1uKKPJaW6/pfrwrrzaOqjvMtkoV+aQy17eYlioiaMmMA37ayhPxOglk+5eaPRSahJsvI15mLskd2s8opnA/x0aY4h65VhmkFLMIWvnzd7OLRakKhNv5b6qO3YIm9BKn+9jF+HYFwDS8PF6bQKskjtugws8UO1FRrQarqkMEjEc9aHu//ycu1m/lWU9gg3t8+WAr0ZXVIcn5eD8LKbIGdGTzMN0fsY/qrSKuV9/g5Pg7SsUyVLDM5j/qr4aLm4aCbFTNga9G/fWDmJO2YDmOEB6WrwN7WF/ZyAMqJEEdt7qBAyKsYQzVv1XHOz/9kVr7Xa5+MlBlp3haICYhJ+YyJYcnaPT2rNnLWMjoEc/NsvhZ+/6fGCUg1BQjznLPwWVrTmM21c1qxaBsmk0PBrkrYgGOshBiAtIqosR8fH+CxPD/aTr4jVEcNu0H96Y+KVdDZWLjPgKVVHXdJo1QolIBQdxWT3P0yLaxmuWPszXA3rPvg7XZmyARKGENquloQ7GTsk4rFY7j87y94yb0R5QriO8CGgNDB48xq/k8brfRnLj+0aarMwOoS4p93N3P0yGBtRP+xUpG9DWQPD8bfClK4nKaEql/Vym5G1nHB98yuIinnMYO8=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY1PR04MB9561.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(10070799003)(19092799006)(366016)(1800799024)(38070700021)(56012099006)(11063799006)(10067099003)(22082099003)(18002099003)(6133799003)(3023799007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?U2g2WGNiTUxuVmFKR0VUZDFqdTJNSkF5a3J4WFFQWEFjY0JPZnhVVUhFYXpV?=
 =?utf-8?B?NXR1UWtJZTFmUFlTaGp1OVNYQ2NwYlE1cHZzdWh3RTIxTGErNUwxOUtzMHlU?=
 =?utf-8?B?RjZwSzZQQ2pxbkdiZzFneUl0QWhzZXp3Sk5JRXZzU200Z1BWNlU3SWZwQlZP?=
 =?utf-8?B?ak1yMEh3bmhXQUd3a0wzZFA4UENPU1VzVjhwa2tvd2I3bFVtOU5sZ3ZiaEZL?=
 =?utf-8?B?VE1hbHNHVUtmdTRiMGpUZy9CTkwvclMvdXZuMTUzRmRiS2xWdEVMSTFQb2RI?=
 =?utf-8?B?OUNHcGI0eTlwVTZzOW12aStHYk5hLzlFbEJOYWJyL3BIUm9RUDRmKzVxRk9L?=
 =?utf-8?B?Q2Yrck5VVGdPK3BCbkpBV1JWWXBEWk1XcHZZdUVoRGRoeGRSV3BrcUI5dU9J?=
 =?utf-8?B?aVNNb25qNGtCYTRkaTQ3endQMGNlVDBFOUpHZjQ2Z01Ea3VzbVNKcnFHL3I2?=
 =?utf-8?B?dUh4ellaV1pLWHAwVHZTQ0pFT1ljMm95UklvbUNCazhQZXhUQWtoK0lBOUU2?=
 =?utf-8?B?b05mQnNFRG1PK3JXWDdCeHc5ODZzWWNicEVoQXRpM1lZUENmcFZLYTdVeXd6?=
 =?utf-8?B?cHJ0WXNtdWZWeUNQOE80Ni81MlNOL0lIS2hCZlVrRTh5Wk9ydWZtaWFMNlhE?=
 =?utf-8?B?ZzNoeTN1eGNOQk9qdFNJZXVrc25oWm1NT1pJUDNBelRWTXJLaXNXNU5leGUy?=
 =?utf-8?B?SjJYRTlyNURNSTdDT2o4Z0NxZW5qU24vUmc5SGdPMnFEeXZ3aWNxcVpZbDJW?=
 =?utf-8?B?SHE5TjVRZUV1WTJQNjN0eUswQ2pqeDFVNnVNYXA0QVI4SGQ2RExBd2ZScWM5?=
 =?utf-8?B?cWp1VWg2c1ZEb0VJUVJzd2FiOWNuNTBXTXZVdkpOWVdsV1NEU1Awb2FuWWFL?=
 =?utf-8?B?RnpmR0ZzcngwZlVJVmsvZWM1WWx1OTAzNHZBemQ2cjJ6bUFVcTF1a2k0bUwr?=
 =?utf-8?B?WXFKNWFyMmRRVVJOcHJ2S0M0RWtsRE85NUhUQXE3b00zOHZrOW9aVGZlTFpO?=
 =?utf-8?B?RjBjNTdTWXRkcmkzd0dpQVBtR1U5d1R5bTlIRTNhTnRiY0ZUUEFCQ3VDQ2NP?=
 =?utf-8?B?V2F5QlRrL2JiY1FrMGJ5TjBXaDRZc3NYVkhDejJzdlZvOFhUOFNCWlh6QVZC?=
 =?utf-8?B?UXFFME5zZGVuWU8wTXNIVFQzTCtVN2xvK090NmZHdlpSbGFrWXdFSG14NW51?=
 =?utf-8?B?dFhVckRVQUpuWmdxQjBpY0EzdTUzMmRlSmk1cDcxekYvQnNQMW5EbGtpZXNQ?=
 =?utf-8?B?ZWI2UnExc0VnRmZBUm1sMjRIdW5wL0lkTlg3UmZ3Slc5SndHcjA5SXAzbS9z?=
 =?utf-8?B?UmFmT1h5d0YzSVlqOERYL3dseFZJTjA5ei9RZ3pEYU00MDBKdUlOQW8wM2NJ?=
 =?utf-8?B?OHhTNmJ3Y29kcG1NL3N4ci9KMVhlNnZMci9sY2FjRGtWMG1ldXE0ZUNkSUtV?=
 =?utf-8?B?cmJGd3JQeHpLSlNQcXZPMU1ISDd6MFVaQ05XeUxRSStzVW8zSFRPL2g1WjM1?=
 =?utf-8?B?MlRkNW9lZ1hUeFlVcTJWcS9adHVkUzBEbFhMaU5XZ1krTExiZEhIaWVzdC8v?=
 =?utf-8?B?dDBWc0UyV0hlbWFpZW0velJsVGVSMThESTROVkY5c2U5cURXV2ZaNlNRYnht?=
 =?utf-8?B?R1NIMXZOOSthaE9NUGorTkpEYWxxSVd3c2prbWFrYXhQNkQwcWJjZWU2UCs2?=
 =?utf-8?B?OGJmeFUzYjFiYkRRMlY3b2t2bE1ib2QvMlJIakhVUEcrTnBUcGdyazd4aGdv?=
 =?utf-8?B?em9taXRTVzlKL2Vwc056SmhlS3Z5Njd2RG54cGF5UUF4TlpuSUZIaElCUlBk?=
 =?utf-8?B?K1VKNkEyVUpVeVc2aEUyaG0wSitJOTNJMEhOUzdvWXpmU2ZrQTdMTjhLNURa?=
 =?utf-8?B?bkZNR3E4azArMnBsWkRwZWdGdnJZek1ZbjFYSUVQQ3NuOVFWbzIwWnZmdWI1?=
 =?utf-8?B?RnV3MjFsbEpxZE5Jb05NWWltWHU2dGZRcUVQdEtQZFFkQkRzNSttOUcxK2pX?=
 =?utf-8?B?WkZGNDdpUXh3eWsvZHpaUW1pZkc0RnNiSlZrbXFEdUQxVFpYeHVOTlNxYitp?=
 =?utf-8?B?SjdHVHM1dUxNZVNSTkNZdjQyZGVLaExreWQ0RGMxZW5JTXk3QWFndHZMUS9I?=
 =?utf-8?B?OUpldGJidVRKK2lhbHNUempZdkY1ZUwwZTBZa0dHOEg2amNYa09PanZPUVlo?=
 =?utf-8?B?eU9iWU5hck9HUDlER0s3NTU2V2lYSHdpU2VPL1ZLYnZzalppeVMyLzRGREIz?=
 =?utf-8?B?SEg3b2hZaElSWGQrTWhWUlZpeTNJM1ZpL2pERjFSWXpDWnZrb1p2TkZJNUVo?=
 =?utf-8?B?VmY0bGUzSDgyYlZXcldUclJsSGtzbmdJOW9nTUJPNDZZZXBLakZnUEZxMEc0?=
 =?utf-8?Q?5IgxHvw1vXSLOAvNX7XTsruYY7PBFoMZptROZ/Pk4GRqS?=
x-ms-exchange-antispam-messagedata-1: cB0qzuJGoDePj7izbOhXwyeSXWCy9mI4lNY=
Content-Type: text/plain; charset="utf-8"
Content-ID: <473F05C97EC92D40AB806A2975EC4E83@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: WaL3ddBerBsBIKWNwtFF01DJZ8VyDpwFste1Slri/KBKB+Z2GY8Qs7IJ31ZzpueX4RiI7VEmJkIXHTxyGh/5VDkgyOyRuRg/DHLiH4dPIDz+4ttRpCKsjCbONP8h/sX9GWjRD5vUGtxcEB7ycTFsSdlGz5WG/jmRWK/LaOeMvMqYPUSgv3ZQlgRr7VTeaN9/TO/drImyCSdFBPAbd5v7CLMSy2h6NRyK9NZBp6bUbb5RydFkPQy3FiwPQr+rAAkq2wiGrcQ2NcwCQ+d2niflhup2o2S2I39farDhKN/ABNyhlgBArjFZwrbJuXkoGAlpVC1mMffaUP41H42BuEtckw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 6XnsH4j2AOixF+1giz8uj3/ks91Stnry5lrOe8BPcpfmSLiLmX4/yFE2g5hYG7gkANoeIcoztpa53Z6D9KcPEsbC3ypEaKzDTIqGagUR6KU7o8D7SEi8b1UctwSl5NAeTbN4eQY7cNIK8/xxdwg6iz97al/zMYz1QCGxeJA+szrIP96NnWSYWhFeEBayzEgz9HV6wOutRlW3+HORBFaezB22wwngzwEk/5SRWYlIpVeJZPVoiMG1+Yy/XpqQdZYbty5dsuyuBegos0SczZh3k2CNu+MIx3euCGAAcxZy1UwE5WqSDQN55yKiTlmVDYTdKDrg1RslIy2lxxxXKva9H9J6us4e8ZIrnhAaosHFcTpdWKIB2V7/ykixQXFEhPaaRFu2BtW4jtEtAY3uLVUrtO0UNsp6FizafrlpaOI3oqz1YtqilpiO52FBgIMpHfo7A6fyXd2eswycl0FJJ2EKSOpuXeHpqiRe0sw4RCTH2RsJVXmJy/q/FTB6Rzd0TeoovuXz9wezKHpDy2k+DIkfsc1YW4Ph0B0Ur8aNkD972CXd3bv+8XBpCa5dldcF5Z7SldoVOPSpN4O9V2Z1CRQ+7vbeE/ZkO/3mxtTDyJyfZuevfFPkzxsKOFALIcls+y42
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY1PR04MB9561.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0cdbe22-5ec7-4856-9166-08df186b9fbb
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Sep 2026 05:37:42.9863 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2ZSUyCV3IpdPrSDz/qkIdJGWPuDU+z0uVK5vuxY9jGxfhdFIqa/N+Bdg6MogIrVkUfC/cha6xPM3t7PlfGC+Fnannam6iiHOFz1qoAFlj2Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR04MB9318
Received-SPF: pass client-ip=216.71.153.144;
 envelope-from=prvs=718ae7c5e=Alistair.Francis@wdc.com;
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

T24gVHVlLCAyMDI2LTA5LTAxIGF0IDE3OjE2ICswODAwLCBaZXBoeXIgTGkgd3JvdGU6DQo+IGhl
bHBlcl93cnNfbnRvKCkgbWF5IHJhaXNlIGFuIGlsbGVnYWwgb3IgdmlydHVhbC1pbnN0cnVjdGlv
bg0KPiBleGNlcHRpb24uDQo+IEhvd2V2ZXIsIHRyYW5zX3dyc19udG8oKSBkb2VzIG5vdCBzYXZl
IHRoZSBkZWNvZGVkIG9wY29kZSBiZWZvcmUNCj4gY2FsbGluZw0KPiB0aGUgaGVscGVyLiBBcyBh
IHJlc3VsdCwgZXhjZXB0aW9uIHVud2luZGluZyBsZWF2ZXMgZW52LT5iaW5zIHN0YWxlDQo+IGFu
ZA0KPiB0cmFwIGhhbmRsaW5nIHJlcG9ydHMgYW4gaW5jb3JyZWN0IHZhbHVlIGluIHR2YWwuDQo+
IA0KPiBDYWxsIGRlY29kZV9zYXZlX29wYygpIGJlZm9yZSB0aGUgaGVscGVyIHNvIHRoZSBmYXVs
dGluZyBpbnN0cnVjdGlvbg0KPiBlbmNvZGluZyBpcyByZXN0b3JlZCBmb3IgdHJhcCBoYW5kbGlu
Zy4NCj4gDQo+IEFkZCBhIFRDRyB0ZXN0IHRoYXQgZGVsZWdhdGVzIHRoZSBtc3RhdHVzLlRXLXRy
aWdnZXJlZCBpbGxlZ2FsLQ0KPiBpbnN0cnVjdGlvbg0KPiBleGNlcHRpb24gdG8gUy1tb2RlIGFu
ZCBjaGVja3Mgc2NhdXNlLCBzZXBjIGFuZCBzdHZhbC4NCj4gDQo+IEZpeGVzOiBiNjJlMGNlNzYw
OTggKCJ0YXJnZXQvcmlzY3Y6IFJhaXNlIGV4Y2VwdGlvbnMgb24gd3JzLm50byIpDQo+IFJlc29s
dmVzOiBodHRwczovL2dpdGxhYi5jb20vcWVtdS1wcm9qZWN0L3FlbXUvLS93b3JrX2l0ZW1zLzQw
ODANCj4gU2lnbmVkLW9mZi1ieTogWmVwaHlyIExpIDxmcml0Y2hsZXlib2hyZXJAZ21haWwuY29t
Pg0KDQpSZXZpZXdlZC1ieTogQWxpc3RhaXIgRnJhbmNpcyA8YWxpc3RhaXIuZnJhbmNpc0B3ZGMu
Y29tPg0KDQpBbGlzdGFpcg0KDQo+IC0tLQ0KPiDCoC4uLi9yaXNjdi90Y2cvaW5zbl90cmFucy90
cmFuc19ydnphd3JzLmMuaW5jwqAgfMKgIDIgKw0KPiDCoHRlc3RzL3RjZy9yaXNjdjY0L01ha2Vm
aWxlLnNvZnRtbXUtdGFyZ2V0wqDCoMKgwqAgfMKgIDQgKw0KPiDCoHRlc3RzL3RjZy9yaXNjdjY0
L3Rlc3QtemF3cnMtc3R2YWwuU8KgwqDCoMKgwqDCoMKgwqDCoCB8IDg3DQo+ICsrKysrKysrKysr
KysrKysrKysNCj4gwqAzIGZpbGVzIGNoYW5nZWQsIDkzIGluc2VydGlvbnMoKykNCj4gwqBjcmVh
dGUgbW9kZSAxMDA2NDQgdGVzdHMvdGNnL3Jpc2N2NjQvdGVzdC16YXdycy1zdHZhbC5TDQo+IA0K
PiBkaWZmIC0tZ2l0IGEvdGFyZ2V0L3Jpc2N2L3RjZy9pbnNuX3RyYW5zL3RyYW5zX3J2emF3cnMu
Yy5pbmMNCj4gYi90YXJnZXQvcmlzY3YvdGNnL2luc25fdHJhbnMvdHJhbnNfcnZ6YXdycy5jLmlu
Yw0KPiBpbmRleCAwZWVmMDMzLi5lY2ViZWMwIDEwMDY0NA0KPiAtLS0gYS90YXJnZXQvcmlzY3Yv
dGNnL2luc25fdHJhbnMvdHJhbnNfcnZ6YXdycy5jLmluYw0KPiArKysgYi90YXJnZXQvcmlzY3Yv
dGNnL2luc25fdHJhbnMvdHJhbnNfcnZ6YXdycy5jLmluYw0KPiBAQCAtNTQsNiArNTQsOCBAQCBz
dGF0aWMgYm9vbCB0cmFuc193cnNfbnRvKERpc2FzQ29udGV4dCAqY3R4LA0KPiBhcmdfd3JzX250
byAqYSkNCj4gwqDCoMKgwqDCoCAqIGV4Y2VwdGlvbiwgYXMgaGFuZGxlZCBieSB0aGUgd3JzLm50
byBoZWxwZXIuDQo+IMKgwqDCoMKgwqAgKi8NCj4gwqAjaWZuZGVmIENPTkZJR19VU0VSX09OTFkN
Cj4gK8KgwqDCoCAvKiBTYXZlIHRoZSBvcGNvZGUgaW4gY2FzZSB0aGUgaGVscGVyIHJhaXNlcyBh
biBleGNlcHRpb24uICovDQo+ICvCoMKgwqAgZGVjb2RlX3NhdmVfb3BjKGN0eCwgMCk7DQo+IMKg
wqDCoMKgIGdlbl9oZWxwZXJfd3JzX250byh0Y2dfZW52KTsNCj4gwqAjZW5kaWYNCj4gwqANCj4g
ZGlmZiAtLWdpdCBhL3Rlc3RzL3RjZy9yaXNjdjY0L01ha2VmaWxlLnNvZnRtbXUtdGFyZ2V0DQo+
IGIvdGVzdHMvdGNnL3Jpc2N2NjQvTWFrZWZpbGUuc29mdG1tdS10YXJnZXQNCj4gaW5kZXggNmEy
MTljMy4uOTc5ZGYyYyAxMDA2NDQNCj4gLS0tIGEvdGVzdHMvdGNnL3Jpc2N2NjQvTWFrZWZpbGUu
c29mdG1tdS10YXJnZXQNCj4gKysrIGIvdGVzdHMvdGNnL3Jpc2N2NjQvTWFrZWZpbGUuc29mdG1t
dS10YXJnZXQNCj4gQEAgLTIwLDYgKzIwLDEwIEBAIEVYVFJBX1JVTlMgKz0gcnVuLWlzc3VlMTA2
MA0KPiDCoHJ1bi1pc3N1ZTEwNjA6IGlzc3VlMTA2MA0KPiDCoAkkKGNhbGwgcnVuLXRlc3QsICQ8
LCAkKFFFTVUpICQoUUVNVV9PUFRTKSQ8KQ0KPiDCoA0KPiArRVhUUkFfUlVOUyArPSBydW4tdGVz
dC16YXdycy1zdHZhbA0KPiArcnVuLXRlc3QtemF3cnMtc3R2YWw6IHRlc3QtemF3cnMtc3R2YWwN
Cj4gKwkkKGNhbGwgcnVuLXRlc3QsICQ8LCAkKFFFTVUpIC1jcHUgbWF4ICQoUUVNVV9PUFRTKSQ8
KQ0KPiArDQo+IMKgRVhUUkFfUlVOUyArPSBydW4tdGVzdC1tZXBjLW1hc2tpbmcNCj4gwqBydW4t
dGVzdC1tZXBjLW1hc2tpbmc6IHRlc3QtbWVwYy1tYXNraW5nDQo+IMKgCSQoY2FsbCBydW4tdGVz
dCwgJDwsICQoUUVNVSkgJChRRU1VX09QVFMpJDwpDQo+IGRpZmYgLS1naXQgYS90ZXN0cy90Y2cv
cmlzY3Y2NC90ZXN0LXphd3JzLXN0dmFsLlMNCj4gYi90ZXN0cy90Y2cvcmlzY3Y2NC90ZXN0LXph
d3JzLXN0dmFsLlMNCj4gbmV3IGZpbGUgbW9kZSAxMDA2NDQNCj4gaW5kZXggMDAwMDAwMC4uNDJh
OTkwMQ0KPiAtLS0gL2Rldi9udWxsDQo+ICsrKyBiL3Rlc3RzL3RjZy9yaXNjdjY0L3Rlc3QtemF3
cnMtc3R2YWwuUw0KPiBAQCAtMCwwICsxLDg3IEBADQo+ICsvKg0KPiArICogVGVzdCB0aGF0IFdS
Uy5OVE8gd3JpdGVzIHRoZSBpbnN0cnVjdGlvbiBlbmNvZGluZyB0byBzdHZhbCB3aGVuDQo+ICsg
KiBtc3RhdHVzLlRXIGNhdXNlcyBhbiBpbGxlZ2FsLWluc3RydWN0aW9uIGV4Y2VwdGlvbiBpbiBT
LW1vZGUuDQo+ICsgKg0KPiArICogU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjAtb3It
bGF0ZXINCj4gKyAqLw0KPiArDQo+ICsJLm9wdGlvbglub3J2Yw0KPiArDQo+ICsJLnRleHQNCj4g
KwkuZ2xvYmFsCV9zdGFydA0KPiArX3N0YXJ0Og0KPiArCS8qIFVuZXhwZWN0ZWQgdHJhcHMgdG8g
TS1tb2RlIGZhaWwgdGhlIHRlc3QuICovDQo+ICsJbGxhCXQwLCBtYWNoaW5lX3RyYXANCj4gKwlj
c3J3CW10dmVjLCB0MA0KPiArDQo+ICsJLyogRGVsZWdhdGUgaWxsZWdhbC1pbnN0cnVjdGlvbiBl
eGNlcHRpb25zIHRvIFMtbW9kZS4gKi8NCj4gKwlsaQl0MCwgMSA8PCAyDQo+ICsJY3NycwltZWRl
bGVnLCB0MA0KPiArDQo+ICsJbGxhCXQwLCBzdXBlcnZpc29yX3RyYXANCj4gKwljc3J3CXN0dmVj
LCB0MA0KPiArDQo+ICsJLyogR2l2ZSBTLW1vZGUgcmVhZCwgd3JpdGUgYW5kIGV4ZWN1dGUgYWNj
ZXNzIHRvIGFsbCBtZW1vcnkuDQo+ICovDQo+ICsJbGkJdDAsIC0xDQo+ICsJY3NydwlwbXBhZGRy
MCwgdDANCj4gKwlsaQl0MCwgMHhmDQo+ICsJY3NydwlwbXBjZmcwLCB0MA0KPiArDQo+ICsJLyog
U2V0IG1zdGF0dXMuVFcgYW5kIHNlbGVjdCBTLW1vZGUgZm9yIG1yZXQuICovDQo+ICsJbGkJdDAs
IDMgPDwgMTENCj4gKwljc3JjCW1zdGF0dXMsIHQwDQo+ICsJbGkJdDAsICgxIDw8IDIxKSB8ICgx
IDw8IDExKQ0KPiArCWNzcnMJbXN0YXR1cywgdDANCj4gKw0KPiArCWxsYQl0MCwgc3VwZXJ2aXNv
cl9zdGFydA0KPiArCWNzcncJbWVwYywgdDANCj4gKwltcmV0DQo+ICsNCj4gK3N1cGVydmlzb3Jf
c3RhcnQ6DQo+ICsJLyogV1JTLk5UTyBtdXN0IHRyYXAgYmVjYXVzZSBtc3RhdHVzLlRXIGlzIHNl
dC4gKi8NCj4gKwlsaQlhMCwgMQ0KPiArd3JzX250bzoNCj4gKwkud29yZAkweDAwZDAwMDczDQo+
ICsJaglfZXhpdA0KPiArDQo+ICttYWNoaW5lX3RyYXA6DQo+ICsJbGkJYTAsIDINCj4gKwlqCV9l
eGl0DQo+ICsNCj4gK3N1cGVydmlzb3JfdHJhcDoNCj4gKwlsaQlhMCwgMw0KPiArDQo+ICsJY3Ny
cgl0MCwgc2NhdXNlDQo+ICsJbGkJdDEsIDINCj4gKwlibmUJdDAsIHQxLCBfZXhpdA0KPiArDQo+
ICsJY3Nycgl0MCwgc2VwYw0KPiArCWxsYQl0MSwgd3JzX250bw0KPiArCWJuZQl0MCwgdDEsIF9l
eGl0DQo+ICsNCj4gKwljc3JyCXQxLCBzdHZhbA0KPiArCWx3dQl0MiwgMCh0MCkNCj4gKwlibmUJ
dDEsIHQyLCBfZXhpdA0KPiArCWxpCXQyLCAweDAwZDAwMDczDQo+ICsJYm5lCXQxLCB0MiwgX2V4
aXQNCj4gKw0KPiArCWxpCWEwLCAwDQo+ICsNCj4gK19leGl0Og0KPiArCWxsYQlhMSwgc2VtaWFy
Z3MNCj4gKwlsaQl0MCwgMHgyMDAyNgkvKiBBRFBfU3RvcHBlZF9BcHBsaWNhdGlvbkV4aXQgKi8N
Cj4gKwlzZAl0MCwgMChhMSkNCj4gKwlzZAlhMCwgOChhMSkNCj4gKwlsaQlhMCwgMHgyMAkvKiBU
QVJHRVRfU1lTX0VYSVRfRVhURU5ERUQgKi8NCj4gKw0KPiArCS8qIFNlbWlob3N0aW5nIGNhbGwg
c2VxdWVuY2UuICovDQo+ICsJLmJhbGlnbgkxNg0KPiArCXNsbGkJemVybywgemVybywgMHgxZg0K
PiArCWVicmVhaw0KPiArCXNyYWkJemVybywgemVybywgMHg3DQo+ICsJagkuDQo+ICsNCj4gKwku
ZGF0YQ0KPiArCS5iYWxpZ24JMTYNCj4gK3NlbWlhcmdzOg0KPiArCS5zcGFjZQkxNg0K

