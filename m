Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D5B7C61DD3
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 05:18:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1zpD-0001OQ-2O; Thu, 03 Sep 2026 01:17:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=6997dc6e7=Alistair.Francis@wdc.com>)
 id 1x1zpA-0001NN-Cb; Thu, 03 Sep 2026 01:17:20 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=6997dc6e7=Alistair.Francis@wdc.com>)
 id 1x1zp8-0002hZ-BC; Thu, 03 Sep 2026 01:17:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1788412643; x=1819948643;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=9k3VpbGrXVVl01KnlQziqjVZEvf7vIRAhTIExzI5Pt0=;
 b=LeM28ciQ832q7w0rOjr+bs457Fc51JwKbD7TvkIg+qRnKDyGUXHw40IJ
 crDDnOoqoSDwo7LNnkCP2F0JLKvTebJHeDMhlDuAl3kUqksayNu29/0CA
 lfHtyQtBewBXwfwSChSPsKGTubxQbfBAVeMeBJA4CCk8SoRspjQ1RerEz
 WUbYBOEsMiNm7DcJqL8CtRXwYoI37/mx2ImpKOa1L5wyBTygkTgHPtJ7s
 cxL1T83zx/4KhmvCe0UJ8l6+fzqFx02rTL9nt33kNNE/wKrARDmb+apM3
 qhM8reayDi73yaU3XOnLlODTqBIowktT5V3d3JcLHgNhyEtut4vH5wBF+ A==;
X-CSE-ConnectionGUID: U1SlA1ufQ86OEl+EZSYNAQ==
X-CSE-MsgGUID: dg0AB6SUS9e1IgbBvDHfmA==
X-IronPort-AV: E=Sophos;i="6.25,258,1779120000"; d="scan'208";a="154849113"
Received: from mail-eastusazon11011025.outbound.protection.outlook.com (HELO
 BL2PR02CU003.outbound.protection.outlook.com) ([52.101.52.25])
 by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 03 Sep 2026 13:17:18 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jXH9VETOX1fkC6QXIV/UsdJYCceJJOL1PHu5SissGvu0x+zZst8Ow8WvB15oA9xGjLUyoQp8fx4eUfc/26X7jflDZ+F/ezmYIUfxi9HgItMvqbLEFyxMCNLtqd82BuCJ8P4yMmzzu2ZJe0+2APioP4uA7QPlRkR9JVzPlV7kNx5kWZpmoZJSC80AHOjow8WxAwlDQ6pzQlcaivWY5HxnuEjGiiujMcx/FBl9oFu3AJb8HCigjnY2pok4FHLeMznXYzYaFFN4g/+ikGJQiL5/LyxvC1aXRIaj22NvgmdMPCP6H/x/M5Eip/zwtZqFoF13dswqBxZC+77zoB2tQnHNhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9k3VpbGrXVVl01KnlQziqjVZEvf7vIRAhTIExzI5Pt0=;
 b=W/evmD/MaTiknZZFmz1BliiwtCoyKfhgxCRlFXRFpi1f/2EF30vPddOrmeNr5kmLA6/5f2Mn1VBk2iwiJAJ0ePeuyQ0hQjDPGFZIvvHWYjKiaFUPiTRVjiQjUeEVP7+vRvy73i6w2sqZYfBlTB3l8nLz3XCXOZ4j1/KgO30PFkcSHrB8/lyaQX7zAOiJnm7jcY3v8uaIhoOs2Njnz7ftsxwTOF0qI756lXAkSDewNOZ/bHOOcdcZvCR5CK6TSPAHt5hAIkCia9Xx7LAMCNQmfly2nZ5VhariT7fsUrasCTAf9z8aMcdje4YBvSvDlWqDlSnEktadxc2LdkhJD3NV/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9k3VpbGrXVVl01KnlQziqjVZEvf7vIRAhTIExzI5Pt0=;
 b=W0H0A5Yx9Qe4xJe8J3WNzt3PhTsXlbw0UGPAC8hPraObuctA9ICnXmfWNxNI5RaD7YsyOOd1gizf4S6+3739AMe+Jx//tCjaaEZ6Br17sR6YdO5e1HGC1nC9kFfsWTOQbzc4lVAa9rQySocFSiQc9qCWVQxNYajUXTDDOjvqV5I=
Received: from BY1PR04MB9561.namprd04.prod.outlook.com (2603:10b6:a03:5b6::11)
 by BY5PR04MB6390.namprd04.prod.outlook.com (2603:10b6:a03:1e2::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.10; Thu, 3 Sep
 2026 05:17:11 +0000
Received: from BY1PR04MB9561.namprd04.prod.outlook.com
 ([fe80::3869:e494:2fa8:9888]) by BY1PR04MB9561.namprd04.prod.outlook.com
 ([fe80::3869:e494:2fa8:9888%5]) with mapi id 15.21.0382.007; Thu, 3 Sep 2026
 05:17:11 +0000
From: Alistair Francis <Alistair.Francis@wdc.com>
To: "mjt@tls.msk.ru" <mjt@tls.msk.ru>, "xb@ultrarisc.com" <xb@ultrarisc.com>, 
 "qemu-stable@nongnu.org" <qemu-stable@nongnu.org>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "palmer@dabbelt.com"
 <palmer@dabbelt.com>, "daniel.barboza@oss.qualcomm.com"
 <daniel.barboza@oss.qualcomm.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
Subject: Re: [PATCH v11 0/2] target/riscv: Fix riscv64 KVM migration
Thread-Topic: [PATCH v11 0/2] target/riscv: Fix riscv64 KVM migration
Thread-Index: AQHdJzTKnXWNXBjrB0eNTYcYF1SO57aucSiAgAS3PgCACVAggA==
Date: Thu, 3 Sep 2026 05:17:11 +0000
Message-ID: <89b68a0aaf599ff3c7fae83039f5c3d34b3412fb.camel@wdc.com>
References: <20260808125157.1220511-1-xb@ultrarisc.com>
 <20260825070309.1086125-1-xb@ultrarisc.com>
 <a630b631-8b51-4b8e-af87-1c0de546ea8b@tls.msk.ru>
In-Reply-To: <a630b631-8b51-4b8e-af87-1c0de546ea8b@tls.msk.ru>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.60.2 (by Flathub.org) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY1PR04MB9561:EE_|BY5PR04MB6390:EE_
x-ms-office365-filtering-correlation-id: 7a26793e-440d-4873-32bb-08df097a9b96
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|10070799003|1800799024|19092799006|376014|366016|38070700021|56012099006|11063799006|4143699003|10067099003|18002099003|22082099003;
x-microsoft-antispam-message-info: lNxmhgyYXYKMd91mGtLu6nU1ouSJhFJJXxyfmMkgb6DZmbr2wDHjueNueKGA4sUeciW/Xo5XhuPPHXSONdvLpVUiZke49DidgRFp26Tt4fWLiW8MCeOU6wWHhOKQo79yABBzr1KMJq4teMToTGNIgukmO7408tf3goK/Szl0obdsCpuVMfIWuCwhskSM0smtUgslwyNhuErazZ7l1lRyjdS3gYLEF9a6ShaKWO9a6kdUTUIzsqTx1a+9vy60nsvdHOlKCRxogu9D/TAoaMiM2Xc5e78pFXXorYGzp/5NaPb9VLJPC/onBZ7cQGhYQgBjT6EO+19TIuKfHdKWYWrq+AxujBCQQEUQ0DMqFWyNHwz+6OVwqql/ntaSDPA3xh8x4utRWf2URsbcRVP942XWQDsb6h3fikCsYKmPeW2NanAvZq6aa+6rfGEvcue6P9zv6ZahsW271pm3eStX6mWATFOHuLJUu7Hwpqh3ysHvhjEdd6Ov1QqwqWPv6WDkoGS1X/ljx5MFTu/ojfvAQ4rEUemlqz6Vc6skUpX1yDI6+K4z0RyZ62m2F1CJ/D352iCmLGavanvcs5n00bzxNgYqsNCPYUPtCeE8qGkxpx1aPVPiGIVOnI/esFImDGOf70tpaj6Nth1rWCWm8nyv6HhAtMx+kfS/GWS+FQPgzKvTxokOAVQYebdNK58tRd7+TdAuzuSwCOuHVRlK7LcfQWP4CmPeOqGYyyVdQ1QJ/ghmjGE=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY1PR04MB9561.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(10070799003)(1800799024)(19092799006)(376014)(366016)(38070700021)(56012099006)(11063799006)(4143699003)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VzBYeERJTXl2c2E1TjlQVFJTOXErdm1oMlhrSytOMk8rUFM1Rkg3elUyV3ZW?=
 =?utf-8?B?ZStSRDJVVFhXRTk1YmZldjZQUFRTcC9Hb0ZNWDBGQSsvTUE5QnV1N1FjTXlU?=
 =?utf-8?B?WkEyZ2JpMVBQYzJVdmFSNmMwL0hBejYzUlVzWnRGU1BiUlNDL25BTEFNVWFQ?=
 =?utf-8?B?dnZKdUhybVBrZlROcURYU2xBb0xYTDF3VytQRDhEbTVzVlAwZjNHVlVWTGhq?=
 =?utf-8?B?N2ExQk10a1AySFk1SHVscEU4UHZKZGNJZllTdS9ZYjRuUHBXQjF6ZjB1WDZF?=
 =?utf-8?B?U2dBcUhJVWFpbjlwSkVkNjNwSGRTVDFIUTdzQ3JDV3IxUFFwODlqTnV2VXlL?=
 =?utf-8?B?OHY5WEdsOGw3VWVjZTFWQ08yWHZwVFE4WmVzWUo1NUhuZVlqVFZuM21BOUd1?=
 =?utf-8?B?c2tmcDNNNFVQVkpKQmNsOE40Z2dYakhaM3MySWJBRFl5WmhoTU54Ylk5bjFl?=
 =?utf-8?B?WUlQNWUzejk5U2hrNDVjVjRIcmNBd0d5clk1UGwvdS9UZlU5RGV3SUQ4UEtJ?=
 =?utf-8?B?SXYvMDAvK0sxWHdzSDRVQUtzZVlNL2FYYUJKUGtVbndNSFhJQ0pHM3lyTlJq?=
 =?utf-8?B?Rkhwd2NYbG1ZLzNuTG5zWi9RZzZuZmtTWG9GcTBsMGtNbzd6dEJCcGVXRFdS?=
 =?utf-8?B?SUUyN2RtVVJyS01neDFEOGNjMXlmUHBGbVdUdmJOTExGVGRvalNjYVNxMEtZ?=
 =?utf-8?B?c1o4NnhBTG9NZkl6TU92QnlmeDVvR2FmdmlLeHdCdTBtZ1hWQUZJaWpjUHIw?=
 =?utf-8?B?RDFrV3Y5N0N4UW1UbGlBYUs4SERwSnBmVVk2d3F3SEQwZVAwSUs1NTJENXJS?=
 =?utf-8?B?NWZhWjdFdG5JOFUzeCtvZDdwREZUcVNkK0cwMHpmdmF6S3lBSWxmT0RtaHVW?=
 =?utf-8?B?ZVUwSnEvMDhIU1RoTlZVamR5akFyTFFJUU5BQkRyMlpXd1BHMThUZDRpTlcz?=
 =?utf-8?B?c2FUczFYcTh6MDZ0bU5hSVc2ODBoc0JtQ0ZsdTVGRXNpWVZOd3ZRV3V3ZXlU?=
 =?utf-8?B?emx1bld5bENhM1U2OGoxajU4Vll0VVVIVGs2MC9BN0tycVJHaFRWZzBxQWpt?=
 =?utf-8?B?ZERYN0RaS2M5R0xnSlJta1hxb0NKelBhWnNibk45ZWpld0xPSGRhU0tkQUl1?=
 =?utf-8?B?SnZSTUdveUlpQmN3ekptOTJoU3pnL0Nyays2dzIrWEJUSlhFS1BKc2FxdWJC?=
 =?utf-8?B?UW9oTXJKU3JMcmtDOFNpS3IrVVkwZWlCajBXcDRkZ2hvSXRSSG81SHJKQUZL?=
 =?utf-8?B?OXE1WDBYTU96bEtFMEJENGhKQmZUWUIwaFpoY3JKdGxOSThWRUo3dzE0NGky?=
 =?utf-8?B?Yzl1MzRsVmlPbUl6TWdrL2FrbFRnb080Y3VGM1cyelNzVVk2RTZ0aXF0SC9X?=
 =?utf-8?B?WnplWjFrdi9yd2RsSTR1b3ZlS2VlUXFUMUFoMlFoVGVCQnVMS3NWNUlyQWxU?=
 =?utf-8?B?c1dnTnRNRG9PbFBrR1JuSTBUVDlid0VLdCt3VTViOWFuYkFxNVMrd3FMK0tV?=
 =?utf-8?B?TTJ1WmJTOVBqR0c3aWdWZks0TmR0T2tWMThPZE4rL1JDZmk0SDVFZW1Qeld2?=
 =?utf-8?B?eUhXcituR253SzlRaS95UWVRbnNhTzRBSnFRVDMwSzM4RzBsNURjL20rYyt4?=
 =?utf-8?B?SmpIME9WYlZMVVcyNEZzQkRVNnhVeFlTTFVneWI0cGpraEd2UUc5ekZYQkhC?=
 =?utf-8?B?TXVKT3AxTEw1djNKQXNtZjVGMUp4Q3FZNU03YlF5aDVlNDNjMUYyczBGM1Q1?=
 =?utf-8?B?U2pRQ2krNTNtRW1POXdwMnZkYTZ2YThDWGdYZ3Rzd3duc3o2RzBYOXpmbVd5?=
 =?utf-8?B?WDJZcGFTRHpGV1VxWHROMGFRcTk2SDNMMmora3NUR0c1L2NxQXBGRUFaT0ox?=
 =?utf-8?B?TWhSR0lXU1VESEpKSzJlK21yOGU5WTRnOTlGdXR1UlJ3NmxvaUdhU1ZBTVQx?=
 =?utf-8?B?dklaQjF5eFJPUUM1ejlRWnNidjlLYndmTy9aU3V1VDdLVmgzN3ZneFU2Sngv?=
 =?utf-8?B?enpjWmMzRjFIcjRFd0xDNnY3MnpoOStWai93SWY0c3IxR3U0YjJwYk1nVlQy?=
 =?utf-8?B?QkZtTmFiNVpyYnZiNkNrdzlIRW5ndEtYNEw0QTBUbE41b1RENGNTZnEyNWlM?=
 =?utf-8?B?V3VBOUdpckpuYS92VFFIS1RhSTZqSDJabk9Cakc2LzdkdEZLQkt4UFZHTWZw?=
 =?utf-8?B?WDNsVmZJRFI2d1k5QlltbjUvTDB3cWtkLzF4TWVCM1dxbEtQT3RZRm5XWm9a?=
 =?utf-8?B?WVBSbXBGVk9jWVVuSGtkYWhMeXhvd0w5WlVTUHRWRFZJYzB5aDBDeUM1UXN1?=
 =?utf-8?B?aWxQVHdPYStjSXRZS0tCL1Z2MDRVZWs5UmZldzhobFc5eU5jc0JRaUt4aEIy?=
 =?utf-8?Q?dNUgR5Wv69WUXWzPp00ysqwFyZKKgvLsnkJp3j7YCF8JU?=
x-ms-exchange-antispam-messagedata-1: 74tURZGEXpSN6v9frWuGuYvccCnV7o0+W2Q=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8951275E85CFD946A01A7CCB7EA4B97C@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: m9IsIMcvr3QCUzwhlREY9QLYXoOfi6ANr7H0VBC+GnhU5VUq5Sdw3JJ38YPeJrAoIA/GCtHoF1NGeG3Yk5NFARnJLLScJXVN1nOUUxbo2o4S0feFi0jwicY8nLM0wP7qSKQyaIbY9Il1ErBs36MzEgc9rKLolDokiHYaeF+AQ726tMv2wJJQvMdps/1LeWOX0L4MZNzZ7k7jWyKE8mdH4nCuTjnUj50wZS+4WoaoRYD0ShjY3FRwkX8PWacbwuK87gJbz1YvyzMaj16cMPtKtVVs0vNxTv/ei6eCIHgRumwIz732QS0cNrFqQnv6ZI8HQDBS321b8gpJ20cK9r53DQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 65cfHS8yc6ausLZjYvoDdmnQxPpNYztd/dhYQnaj3Fz6aGUNcdSGhIbXri2qhBunpm4jct4O28sgQMCKuTJrQmrIrkrDbQ3y/YPN+ucRFmZmAO8vQBpBGrds3+4WXzWyWc8v4t/2yKSiKs9zxjL3jUqpAZekNmcr+bYc3Tfjbl/O1eiEVg7BrvU8c6NQ0JD76z/E2X6EAUpmNx8TQKQo8ThjKw0sTfVcjoJmd+VZSM6ZBCbItLLEac/sH4Jw2rYhFDsAE9+zPoKO9yoCqkOLpAcFNgWIuLM21bBOInDGR6m5XzYImwXCU0/wPZIt07zKMdDc4EzRkYkgswuKhZVHOAq3ImkikGcz01sVsZNVsP69kQA1xIb/JrMzPrvlCKdGO4m1ny2ZCxucwD8m5uvUyt2EUS3RjhsupxMl/kJa/4YyYWaDXmt+NWqzGIsxC4DGnGL99PskC8tEYTB8LeK5ZDpzQblj2Dc1qfomMaxkGxPX0xsug0aiCerGTeYoyZshHl53fWJ+7JqhttayjebMA/V6rv67A9Dlrh2JxbddvLiyWa1wsY+VXtf4S59x1szJ965z2MPe/KF61eTU5KgMdeLijgwMVYIXFSqXmZhIV0htUaMkjhteXr2uilHPrSPA
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY1PR04MB9561.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a26793e-440d-4873-32bb-08df097a9b96
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Sep 2026 05:17:11.0850 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rC5KzQm9R3Jky7oji5oNar5mv616UIwg21Te0EwB8ToGH4QRN5N7wokQ5aGfqv4fUIu09IpCy9hnP0CUUBT6oHoi1efa6zUQsyjxa3l3poQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB6390
Received-SPF: pass client-ip=216.71.153.141;
 envelope-from=prvs=6997dc6e7=Alistair.Francis@wdc.com;
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

T24gRnJpLCAyMDI2LTA4LTI4IGF0IDEwOjA0ICswMzAwLCBNaWNoYWVsIFRva2FyZXYgd3JvdGU6
DQo+IE9uIDgvMjUvMjYgMTA6MDMsIFhpZSBCbyB3cm90ZToNCj4gPiBIaSwNCj4gPiANCj4gPiBO
b3cgdGhhdCB0aGlzIHNlcmllcyBpcyBpbiBtYXN0ZXIsIGNvdWxkIGl0IGFsc28gYmUgY29uc2lk
ZXJlZCBmb3INCj4gPiBzdGFibGUtMTEuMT8NCj4gPiANCj4gPiBCb3RoIGNvbW1pdHMgYXJlIG5l
ZWRlZCB0b2dldGhlcjoNCj4gPiANCj4gPiA3ZGY5YWE1IHRhcmdldC9yaXNjdi9rdm06IFN5bmNo
cm9uaXplIHByaXZpbGVnZSBtb2RlDQo+ID4gZGRhYzdjZiB0YXJnZXQvcmlzY3Yva3ZtOiBQcmVz
ZXJ2ZSBNUCBzdGF0ZSBhY3Jvc3MgbWlncmF0aW9uDQo+IA0KPiBIZWguwqAgSSByZW1lbWJlciB0
aGF0IGJpZyByaXNjdiBwdWxsIHJlcXVlc3QuwqAgSSBwcm9jZXNzZWQgaXQgYmVmb3JlDQo+IDEx
LjEuMSwgc28gY2hhbmdlcyBmcm9tIGl0IGFyZSBpbmNsdWRlZCBpbiAxMS4xLjEuDQo+IA0KPiBI
b3dldmVyLCB0aGVzZSB0d28gY2hhbmdlcyBkaWRuJ3QgaGF2ZSBuZWl0aGVyIEZpeGVzOiBub3Ig
UmVzb2x2ZXM6DQo+IHRhZ3MsIC0tIHRoaXMgaXMgdGhlIGNyaXRlcmlhIGZvciByaXNjdiBmaXhl
cyBmb3Igc3RhYmxlIC0gc28gSQ0KPiBza2lwcGVkIHRoZW0gOikNCj4gDQo+IFBpY2tlZCB0aGVz
ZSB0d28gdXAgbm93LCBidXQgaXQgd2lsbCBiZSBhYm91dCBhIG1vbnRoIGJlZm9yZSB0aGUNCj4g
bmV4dCBzdGFibGUgcmVsZWFzZS4NCg0KVGhhbmtzIQ0KDQo+IA0KPiBZZXMsIGFzIEFsaXN0YXIg
bm90ZWQsIGl0IGlzIGJlc3QgdG8gaW5jbHVkZSBDYzogcWVtdS1zdGFibGVAIHdoZW4NCj4gc3Vi
bWl0dGluZyBhIHBhdGNoIHdoaWNoIHNob3VsZCBiZSBwaWNrZWQgdXAgZm9yIHRoZSBzdGFibGUg
c2VyaWVzLg0KPiBJIHVuZGVyc3RhbmQgc29tZXRpbWVzIGl0IGlzIG5vdCBvYnZpb3VzLCBzbyB5
ZXMsIENjJ2luZyBxZW11LXN0YWJsZUANCj4gYWZ0ZXIgdGhlIGZhY3Qgd29ya3MgdG9vLg0KDQpZ
ZXMgcGxlYXNlLiBJIGRvIHNraW0gdGhlIFBScyB0byBjaGVjayBmb3IgcGF0Y2hlcyB0byBpbmNs
dWRlLCBidXQNCnRoZXNlIG9uZXMgZGlkbid0IG9yaWdpbmFsbHkganVtcCBvdXQNCg0KQWxpc3Rh
aXINCg0KPiANCj4gVGhhbmsgeW91IQ0KPiANCj4gL21qdA0K

