Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C146C5B572
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 03:52:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyiD6-0002o8-5n; Mon, 24 Aug 2026 23:52:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=690dc056c=Alistair.Francis@wdc.com>)
 id 1wyiD5-0002nw-Fn; Mon, 24 Aug 2026 23:52:27 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=690dc056c=Alistair.Francis@wdc.com>)
 id 1wyiD3-0003xB-Vf; Mon, 24 Aug 2026 23:52:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1787629945; x=1819165945;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=lQ4ZtYQ1hnaFv/HbvgewnfWSsl06iVObi44lLletJLA=;
 b=r485vBfItvvTejcZshkV4xLKbM8MNiU0xg2HQUzww3ra4ZAHWsth3EFt
 WB++Iw4G03rQqrNbFDysjlorDEI3oFAXPxa4YNFjPUij1fBnomjFuUZYd
 1E90FvRk296L7dguMerk4zXnGfcRV6lLTHWAqL35LVosOQMKLkMnzTrOU
 sTOO9HUCxpEyxAO67DQ49/bL5mttqBr/kTArAyy5ECQBGn+EdO5+zsTTj
 /WGIof1ylx86/4jBd04in5i4MYI2KEUlgMIsOvfsjraJS4noU2uWJqmrJ
 ODafXOcoMuAVZ87P8lEx05+DbdpYfWqUpfrWfyedAs4i+3QENcnfCRKaD w==;
X-CSE-ConnectionGUID: V0F34RS6RUGm8uQn/6A0UA==
X-CSE-MsgGUID: SjMezdKzTZypCgK0Xb5EbA==
X-IronPort-AV: E=Sophos;i="6.25,241,1779120000"; d="scan'208";a="153242557"
Received: from mail-westus2azon11012032.outbound.protection.outlook.com (HELO
 MW6PR02CU001.outbound.protection.outlook.com) ([52.101.48.32])
 by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 25 Aug 2026 11:52:23 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FXSnCDnKmlGpFbqkvwiAd+XG9o+bdFgJFk/Kzn7JbimVzTZVMU0m1jeNYbEb5EDKc4teHvPjKc1EUlWdEJwQ/8o4MRtpfB7ZFeWG+NuiBfV3P6tP/nk2kGGsJzS2TWnpi5lvg3X/SmB6C7kA2B+mrmvE/WyumHnGwo3m2qHhtGowSYUzBVBb0+6WZCotOnoGaQaC0XGRIWLtQzz3fZmsW0GiZ5dLyroigIWJKQAYvU+HvIVlbTLYIpEUvpuD24PO0cQ48rPuqEbAgC7MlYDlNK7LOKVES0ScgOLDKi4e3EOIGs+OwK+zwuUbcWjpMMVdy7PvopLSsRO7W0Yfgg/VpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lQ4ZtYQ1hnaFv/HbvgewnfWSsl06iVObi44lLletJLA=;
 b=G1FVUSuuUGEMcPyz/Gjd7zbLkQ+N7e4P52V8r4qGml0mmqwAY7cn6vhe/Qh/LPGBK6e+TCkV0/7AgQ2mxyPd+WR6MvrubheRCoiouFNotclqdDHTZ8TySHxln/BnqTNkDzk+xJ5BdOqbXYLJxnjmoewyGhVJEW+Ce5PLnMGSjrzJsZnqd3IUUITwUApVFPkFquqJBpa27BdbK7BliPBiXOEIh1MSf+X/anD0+xrB+A9VUv5trhiKVcwBXd8GKYoZ4Xi0QUPIElFfMhrcxATZoaptQ8FRFGwNzd1+EcmeJmo9k8frvewiiT9pVAVlwMJ6hFmV6xxwZH+1rQo6AQbabw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lQ4ZtYQ1hnaFv/HbvgewnfWSsl06iVObi44lLletJLA=;
 b=vQkqDxxIuxVs2nyKPItoS3rQ7DnOM5V/l1EviF6xSYfXwKP1jDgKeg+sOTa58rbYqUYVqje4cafmA6RaErGKBJ0U7r9OZf4DJjJU3QC+45TYY9z1Em+ym/KZnVn991dJNEycYO1+vVTsWSabB1kdU4ARoxKGM3P+FCWdKRtO/SI=
Received: from BY1PR04MB9561.namprd04.prod.outlook.com (2603:10b6:a03:5b6::11)
 by BL1PR04MB549746.namprd04.prod.outlook.com (2603:10b6:208:243::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Tue, 25 Aug
 2026 03:52:21 +0000
Received: from BY1PR04MB9561.namprd04.prod.outlook.com
 ([fe80::3869:e494:2fa8:9888]) by BY1PR04MB9561.namprd04.prod.outlook.com
 ([fe80::3869:e494:2fa8:9888%5]) with mapi id 15.21.0360.005; Tue, 25 Aug 2026
 03:52:21 +0000
From: Alistair Francis <Alistair.Francis@wdc.com>
To: "daniel.barboza@oss.qualcomm.com" <daniel.barboza@oss.qualcomm.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "palmer@dabbelt.com"
 <palmer@dabbelt.com>, "chao.liu@processmission.com"
 <chao.liu@processmission.com>, "liwei1518@gmail.com" <liwei1518@gmail.com>,
 "zhiwei_liu@linux.alibaba.com" <zhiwei_liu@linux.alibaba.com>
Subject: Re: [PATCH 4/5] target/riscv/tcg/debug: set tinfo version if sdtrig
 enabled
Thread-Topic: [PATCH 4/5] target/riscv/tcg/debug: set tinfo version if sdtrig
 enabled
Thread-Index: AQHdJQfLTy+2/gQ5mkijQcbHTgYAurauQDIA
Date: Tue, 25 Aug 2026 03:52:21 +0000
Message-ID: <df5359907fbc96a8c3b53f2feb5648c120ff3088.camel@wdc.com>
References: <20260805182506.2943757-1-daniel.barboza@oss.qualcomm.com>
 <20260805182506.2943757-5-daniel.barboza@oss.qualcomm.com>
In-Reply-To: <20260805182506.2943757-5-daniel.barboza@oss.qualcomm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.60.2 (by Flathub.org) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY1PR04MB9561:EE_|BL1PR04MB549746:EE_
x-ms-office365-filtering-correlation-id: 64366760-7007-4ffa-1ca4-08df025c4457
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|10070799003|366016|1800799024|19092799006|376014|38070700021|6133799003|11063799006|4143699003|10067099003|56012099006|18002099003|22082099003;
x-microsoft-antispam-message-info: Jsrvnaz+VSWzaHOyEDLR6NMtpVcqtKw9D1pcL8XR/hZWejXFIY1+pLIMZ5l+4RLMKcfZ9Epzw3DHoTNJhJyiRzMewlguyoWQ3VwqZZiMHxyipawB3j5vr7H2/Cfp7oyzpgM2ah5EOHThpFjULw9VJ/ILynK1qI+SgY9q4WFr05vvKJdJ6+ll2+MYcJRPhf3AQt6NSFpdbK3yYzl0cSHSInTRMdwhUQFJ1SOpNu5PVYuuVusT9OeIFJuKA/Tx2r0MRiQ35D0s7A9/y1XTyBtzba5nPtgLkUUeTCEwAYOM0nQpeUpimgApEfwhb+7+cqJGarvc3YSzevUgyE2SMYHYVyggiWcdb7I6EIEMRV/k6PvQaWEbo0zE9SLEKVL2S1xOzRwZykAbZkgZki7nMFjQpyFA+uSQPYUwSAI+FiDtZ4rS+2hWXzC6tkrxmobK96R8dtxMGybHcuOyHEKuQ54XGb2R2BYcf4mJckgBqhFhAQ/0/c67MX6wvAOXdAv2Y2nsNUXHco4e0nMoYF9sBcoLDjqObzb5QX3vaT4DHmnA3RBCqsOvKFOV/y1+hdOele3KlpxPa7/gPPiIOzdFaX1y/OS4R7ndIEsnGNhyOa5rUg9sI5yzUguNjgjFbz25NZi/gmLmTA0FDhltbSrOc9/mtB8iM9UciOHvz3SmLK8R0hT0agmHOhjLxQgxWEgyG+E74lNi4VJW6UpXY5yL09gTxiZJTQQVVGew2H32JCN7OU4=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY1PR04MB9561.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(10070799003)(366016)(1800799024)(19092799006)(376014)(38070700021)(6133799003)(11063799006)(4143699003)(10067099003)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UlI1NWZWZ3NoVHFQMnpBS0JpZStEMHVRc0Q4TjMzVXQrcldQUnROQXdrLzRm?=
 =?utf-8?B?SjBYMFBwbXNZeUhpSHFmSlUzck5IQTMxeE5rem9HUzJkUTkyQVhQNEtZd2hV?=
 =?utf-8?B?SHQ4QVNYUXY3MWFod3Rib0pVMWl0VlZXMDA0OTdCR3lMR1laQ1pSVEZCRGtK?=
 =?utf-8?B?SUZnTFZmbG1kaENyNkwvWjJ4ZHNuemZ3STYraDVKY0UwL1FWZjlxb0hPc3Qy?=
 =?utf-8?B?QjlIQ3FkYUFpNTZlcnQ4cndLNFQraDZKZmQvZ0V5WVdoUGJKTFZmK3NVeUZP?=
 =?utf-8?B?blJjUmorcU9SdERXeWR6RHhRUnRVRmFRUW1Ibmpzc0ZBQzlHdk5sT01ZeDRa?=
 =?utf-8?B?UVhBbU92RDhZWWVOWTh6Q1k4ZkpEc0FXQnZRUVlpZERqendkWUo3Vjg2OStX?=
 =?utf-8?B?cURJb21qU0dMMkFEM2I3K2duUzhkeks4NHFSdmo1L2tGUFFQTnhnbnlsUXhM?=
 =?utf-8?B?UDZZcGQ0dnZ4YjJzb1JDNzhkbmN0TnREMUgyWkh5akZwL3hIUURVTlRHY2hZ?=
 =?utf-8?B?M0dpQjVSSWk0TlNtbERpaUNNK0NMQnNVNlhrQnZoWWFobDN2cDIyajZLREpw?=
 =?utf-8?B?MUd3dCtpQzloYzNObExER0lOT0J5ZlpsaVZ4YitkUENQYXNDZG8wOFJTU0Vs?=
 =?utf-8?B?c0ZkN20vNGltb2Q0K1JsMTNWVVJ0K2NueWlHQXE0RzhhVnBpWFZiYnlqTjFP?=
 =?utf-8?B?ODk3ZWRRK3ZwaERXUHZHQ0dVdnk5ajVWa1dQQ1Y3MjZ4SDZPNDI5NUpWNWgr?=
 =?utf-8?B?SGZXWHVVakhNejFmZDdxQlh5WEJ5eStGTDc4K0NOMW11T3k5d0dzcm1taFdN?=
 =?utf-8?B?N2ZtQVM3WGhVbmNGL01RT1E5VW5velBhVGZ2TGl4aDVsQW9IZ1IydHFuRERm?=
 =?utf-8?B?NXNNd2dNMi9Db1RNbG9rNHVhdjYrNjJPR1ZsaFVYOTVsUHc1SjBIV1k4NVIz?=
 =?utf-8?B?SjVIOWorMkg1bmR3TkRIMmNSTFZleG8xWTQwK2FUQms1c1k5bDF1ZmhwZE10?=
 =?utf-8?B?VFg1UHM5UE9OTTdxNjJDaFliY205R1RtTzRKUFRJeURNbXBWMDVSZjVxdXZG?=
 =?utf-8?B?bGtaUXloSTZ5QWV3NVFrMklHWWgybGcrYzhxUlFvUk9iQ1FrMlNJTFhjMHRw?=
 =?utf-8?B?OWpubGJzTU5rMzdRemp3VkNiYUUrVjk2VFV5clBkQVE4SzJZMTlYVUs5RDhY?=
 =?utf-8?B?ZTJHR1pheGRzQlJHditqclNwaEh5cjRXRmgrSjM1OVFXUStkS3Q2d2R5Y2tN?=
 =?utf-8?B?MXp2eTBiUk9aUXdabUtOc1hzVk8yTERZUktjaFJ0Z1Y1RHpHUmduUUdNQldB?=
 =?utf-8?B?ZEZGZVJna3M1SkVlLzY2UU9FbXFpR09Mb2R1dDdibFRBbkVjUm5Qd0VrRk9y?=
 =?utf-8?B?cGVyT2pPNzdtVFM2LzJwZm5rdUIvVXJCcVgvU2VVcGFRUkpuWlVtd0hwMXZh?=
 =?utf-8?B?U1h5VVdBZ1FuM0pzeEhUMWl0Ti9KQnJIRU55VVVmOExzZkF0Y3EraWREdjc0?=
 =?utf-8?B?M013REkxbVhzQnJMNjZscWI3UU51dmhyRlhMaVpiQ2RZNHlKRXVUcUM0eUNR?=
 =?utf-8?B?clFkeDlkeFZFUmk1cERkZGdzYjh3YWw5d0wyQTJMUG9RaCszUXNBTC9qdk1Z?=
 =?utf-8?B?RWk5NmcxMGVYY1B1OVBjdHd3b1BwRVg0RDNYZW9CbXR4Qkc3VHZWMmw1TFBZ?=
 =?utf-8?B?SGZ3a0d1bVFIbVl2Vk45eEtYejR0aDlKL1ZmdEtUTWp1eHljNytLU3F3WDFO?=
 =?utf-8?B?TDFTam5HMk1YTjFQQVk2UGRHdGhsQlNOVGlucnVqODRXZG5VWEs4VmdlNjJC?=
 =?utf-8?B?eThBTkF5b05tMEZVRG1reXBhT3Fxd3hwL1FiTmE2WmNuYjNoOUpaNVlBaEVl?=
 =?utf-8?B?ZHRLVUtOU1RTUzFQdlV0NjdjK20wNWZwWnBiU0cvNmU2cnc4Sm5SMmpSdkQz?=
 =?utf-8?B?MFJCVHhCejdGYTBUWTNDSjFpaUQrVnM5Rm4zTktuUjhSUXFhTDlybWl3NHJJ?=
 =?utf-8?B?V3dpNHQ4a1lidUxwQlBXY29raTZVT29RMTNQa0x3Yklja2ZqY2V2UWZnK2xL?=
 =?utf-8?B?a3ZiaE5McS94Q1ZEc05ySUZuUU9QbmlFdXBwWDVwRFl1dFlzVDI3TnM4YkpF?=
 =?utf-8?B?UUdLNGlqZmVKdkxveXFuOWxQRk5iSVlzSWdhNWhKeDZUQnJqNWZidmlpb2R2?=
 =?utf-8?B?TDlJdnpHRFRlWERRblZkUlpLS3IyazhtVmV1NGdSNEU2clVFeGQ1ME1taHRI?=
 =?utf-8?B?bWcrMFdSY1R0M3IrTFJqZlBiOTNFZTJGRElZREo4VXY4LyswU3BPUDJFZDlu?=
 =?utf-8?B?UEsvYkJEdXhKZ0lTWjh6cllBcXFmT3Y4UlhzYWZJUVg0YlB1YXZmVmNxMExJ?=
 =?utf-8?Q?Fl80W/+VCncIUhBv41abViTUlsBRbJbzXLyozWkE7BhPj?=
x-ms-exchange-antispam-messagedata-1: 4Se8iHY22cRGoCDUOkuPmw4+sfu1rhuSuWM=
Content-Type: text/plain; charset="utf-8"
Content-ID: <41684865B2C65B4C8BC0F8F88E615B74@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: ZcsfoNBDtt/W1pknoK7WBKf7zbVdJpjzdtI9cSgjHNZtBVcD9d4T3KInIvuAk0+u58cY1Q0VLioUDVaX72IMEyy4/afku3E5i1GMfVFzHTqgq0awMEEf/2Lx/FnaQ8vV5syDmrEYZaqTs6vlaP90zmUMySgEanrESi1wh8FM5BJ530KN35SICCXOvmjj8x4OsHmALyzZ7dCbP8WaomN6BCqqr8lv8DGugIL7WrtWe34xxzlN1oxzF6jhgN4wr80gXtPpjamZ0eXmRDqmaa05WgQeQ2bT/TXcpe02jMOt12KNCC3dnrWfO8i2+yx3LOi3zNLyXjH4S+XEjm7RqtDqdA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 3pMWqPB0+CctIBYktkk0OTbRrNhJnI4dYdKhLsWazuKjxnQ/+KdvV9malGasgjY3hmVFJipDJDU7Mwin4v8G18+ee57PKeFk8HY5fqNXpesGq4YkhAsa8vw8JaZNIkd56017XUQXAgvgcbNV41ULPOYf5pfDazLXC90iLe+tVycQv419uOXmDlHohb+dKAASYtHhajx7N48U/va3E6FsXhS5wYtHo5MOS735dmtjCZUapjALAPSI22zvG8RvYQroZtgB14DyI7KeZTQDBlMkYdN8/ARj9ru6wVVBzCvH3KjV/PaUVu6Ub2h6dhdHnnYoAjo636pOCwYdSfME1Tx9Gx9Zb1T/WSeP1llUsRq/SGtu7qV1BuAa/duOD+9YaY7fSve8GQVbn+EQnsKlf/6knhapyZwX7sn+t2PPfAfK/RUlRKbVFnnqBYqPwAxTG9xG6vaIfCPRQ7s6R4H+PzUSWtE4jP2/uj4vyot7+HUOFnNmIseE/pNkbk+BbS4lCvfpxZXh6zWfuXlT23H1iQtLtLFeVRrqZ7si4fRvxrswGRsHMkjCDBB+ngn/3L+eE6ZbxQB9RXcpDWeooWNtuWXPUGULy31KMx0tOyAlbWnsGTvbujGHS+i7WB4Si8WHdo19
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY1PR04MB9561.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64366760-7007-4ffa-1ca4-08df025c4457
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Aug 2026 03:52:21.6094 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5wRNGBp0qn8DpJ7Fcxi81/jyCdZYuVZpljO3j4eYBrXtjTMMZPyxN3v6nrjZ6ZZfWEhOW5hgBm9LXQdIMMwFZxJxozC8iAvxfcv5pylKCZ0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR04MB549746
Received-SPF: pass client-ip=216.71.153.144;
 envelope-from=prvs=690dc056c=Alistair.Francis@wdc.com;
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

T24gV2VkLCAyMDI2LTA4LTA1IGF0IDE1OjI1IC0wMzAwLCBEYW5pZWwgSGVucmlxdWUgQmFyYm96
YSB3cm90ZToNCj4gU2V0ICd2ZXJzaW9uJyB0byAxIGlmIHdlJ3JlIHJ1bm5pbmcgRGVidWcgMS4w
Lg0KPiANCj4gU2lnbmVkLW9mZi1ieTogRGFuaWVsIEhlbnJpcXVlIEJhcmJvemENCj4gPGRhbmll
bC5iYXJib3phQG9zcy5xdWFsY29tbS5jb20+DQoNClJldmlld2VkLWJ5OiBBbGlzdGFpciBGcmFu
Y2lzIDxhbGlzdGFpci5mcmFuY2lzQHdkYy5jb20+DQoNCkFsaXN0YWlyDQoNCj4gLS0tDQo+IMKg
dGFyZ2V0L3Jpc2N2L3RjZy9kZWJ1Zy5jIHwgMTEgKysrKysrKystLS0NCj4gwqB0YXJnZXQvcmlz
Y3YvdGNnL2RlYnVnLmggfMKgIDMgKysrDQo+IMKgMiBmaWxlcyBjaGFuZ2VkLCAxMSBpbnNlcnRp
b25zKCspLCAzIGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL3RhcmdldC9yaXNjdi90
Y2cvZGVidWcuYyBiL3RhcmdldC9yaXNjdi90Y2cvZGVidWcuYw0KPiBpbmRleCA4YjIzYzhkMDQ1
Li4wNjU3M2M3YjNmIDEwMDY0NA0KPiAtLS0gYS90YXJnZXQvcmlzY3YvdGNnL2RlYnVnLmMNCj4g
KysrIGIvdGFyZ2V0L3Jpc2N2L3RjZy9kZWJ1Zy5jDQo+IEBAIC05NTcsOSArOTU3LDE0IEBAIHZv
aWQgdGRhdGFfY3NyX3dyaXRlKENQVVJJU0NWU3RhdGUgKmVudiwgaW50DQo+IHRkYXRhX2luZGV4
LCB0YXJnZXRfdWxvbmcgdmFsKQ0KPiDCoA0KPiDCoHRhcmdldF91bG9uZyB0aW5mb19jc3JfcmVh
ZChDUFVSSVNDVlN0YXRlICplbnYpDQo+IMKgew0KPiAtwqDCoMKgIC8qIGFzc3VtZSBhbGwgdHJp
Z2dlcnMgc3VwcG9ydCB0aGUgc2FtZSB0eXBlcyBvZiB0cmlnZ2VycyAqLw0KPiAtwqDCoMKgIHJl
dHVybiBCSVQoVFJJR0dFUl9UWVBFX0FEX01BVENIKSB8DQo+IC3CoMKgwqDCoMKgwqDCoMKgwqDC
oCBCSVQoVFJJR0dFUl9UWVBFX0FEX01BVENINik7DQo+ICvCoMKgwqAgdGFyZ2V0X3Vsb25nIHZh
bCA9IEJJVChUUklHR0VSX1RZUEVfQURfTUFUQ0gpIHwNCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIEJJVChUUklHR0VSX1RZUEVfQURfTUFUQ0g2KTsNCj4g
Kw0KPiArwqDCoMKgIGlmIChkZWJ1Z190cmlnZ2VyX3ZlcnNpb25fMV8wKGVudikpIHsNCj4gK8Kg
wqDCoMKgwqDCoMKgIHZhbCA9IGRlcG9zaXQ2NCh2YWwsIFRJTkZPX1ZFUlNJT05fT0ZGU0VULA0K
PiBUSU5GT19WRVJTSU9OX0xFTiwgMSk7DQo+ICvCoMKgwqAgfQ0KPiArDQo+ICvCoMKgwqAgcmV0
dXJuIHZhbDsNCj4gwqB9DQo+IMKgDQo+IMKgdm9pZCByaXNjdl9jcHVfZGVidWdfZXhjcF9oYW5k
bGVyKENQVVN0YXRlICpjcykNCj4gZGlmZiAtLWdpdCBhL3RhcmdldC9yaXNjdi90Y2cvZGVidWcu
aCBiL3RhcmdldC9yaXNjdi90Y2cvZGVidWcuaA0KPiBpbmRleCBlYjYzNWJjMjc3Li5mY2Q5MmI3
NjhjIDEwMDY0NA0KPiAtLS0gYS90YXJnZXQvcmlzY3YvdGNnL2RlYnVnLmgNCj4gKysrIGIvdGFy
Z2V0L3Jpc2N2L3RjZy9kZWJ1Zy5oDQo+IEBAIC00NSw2ICs0NSw5IEBAIHR5cGVkZWYgZW51bSB7
DQo+IMKgwqDCoMKgIFRSSUdHRVJfVFlQRV9OVU0NCj4gwqB9IHRyaWdnZXJfdHlwZV90Ow0KPiDC
oA0KPiArI2RlZmluZSBUSU5GT19WRVJTSU9OX09GRlNFVCAyNA0KPiArI2RlZmluZSBUSU5GT19W
RVJTSU9OX0xFTsKgwqDCoMKgIDgNCj4gKw0KPiDCoC8qIGFjdGlvbnMgKi8NCj4gwqB0eXBlZGVm
IGVudW0gew0KPiDCoMKgwqDCoCBEQkdfQUNUSU9OX05PTkUgPSAtMSzCoMKgwqDCoMKgwqDCoMKg
wqDCoCAvKiBzZW50aW5lbCB2YWx1ZSAqLw0K

