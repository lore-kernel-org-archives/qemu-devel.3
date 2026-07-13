Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B068C43458
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2026 04:14:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wj83I-0004pz-Mu; Mon, 13 Jul 2026 00:13:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=64731fbe4=Alistair.Francis@wdc.com>)
 id 1wj83H-0004pK-6X; Mon, 13 Jul 2026 00:13:55 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=64731fbe4=Alistair.Francis@wdc.com>)
 id 1wj83E-0004dV-Rx; Mon, 13 Jul 2026 00:13:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1783916033; x=1815452033;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=z0XvFMx3fFfrm4OzIDM0Ifa1DXVV1QP9CzS02snAwMY=;
 b=LB/IGPvv5ImMZmJmsWnjUOcCZ9CobbwhagQ0POpGApmsdzYwi+YGx/Wv
 oZA687em8gZOWyIkz9JOLvhDIF9umtSThFjGywS57JqFJ32VGckPoZ68O
 jywl3TOdCqFshFGcJNW64xZr3TZpP0bQ3YzTCWhKj6WiaXF25IIRCkJoc
 mB2GjNnY1KzHGDptM8zaebOQgoGMcwz+hh0TiwMN3tvAfaYR6T70s9TPv
 KL3b4cxO9MtqDpeq7mmlWKtggCTDeIgVcdJYJXHmvApLYiEFxPGAv6BWv
 0z1+jL6BS3erKNqcTH9qwjY9U/zKWsVZ2EUqEHne5icV4MjkdkEL4YwH4 A==;
X-CSE-ConnectionGUID: 4KWMj+t3Tt+t+5OnflHVpQ==
X-CSE-MsgGUID: KENb4VYbR8KG6OGXQ4qJZQ==
X-IronPort-AV: E=Sophos;i="6.25,154,1779120000"; d="scan'208";a="146746495"
Received: from mail-southcentralusazon11012038.outbound.protection.outlook.com
 (HELO SN4PR2101CU001.outbound.protection.outlook.com) ([40.93.195.38])
 by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 13 Jul 2026 12:13:50 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IuAzaYbitJXnWzkIOzz3wUVgK1Wcqyh+SmJ88Nkje8/wZ8zxFM1RItf1Pn/C1r87KANTgV2JmZUcJ5mvqulkyEVtqEUl18msWT2l0aahIVnpRJeBhv8/NfPooqTJ7o3Zej5gDrLx0oRlQwGd5ccuPjCPcfSOakhhXaOwU+qGp7LOX/t4PHSMWliYuVDB88EBgs1t03X9oQDnUoopappQ4G6k7PZ0dhSuyYZlH8tAKT7GfvTMaGOuolcX9mV0sPsqYQQ8bKoAuonEIM/zd0kyMK0wAZhhTvKxlFC+hjFggjXgC+i9bFr8ojOlmoLFryYNf0YgzfxDD+EFRcsECMJx/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z0XvFMx3fFfrm4OzIDM0Ifa1DXVV1QP9CzS02snAwMY=;
 b=Gz40Pz8W3LCIkwCzVS+skKDdag4PyTXYtwETgoMLEqmZrYMKc12bRxTU692ABXe4k7+U5gdIKx2EipkV3ba4n1LZM8OA4wR5r7WJR76+VzSg9LCzB3ofXaywlRgnZCb8A/mBcQQDB+eePoLE9k4hMTvvpRBYmpZ540BsHUTjDdEj8Y4yIiH1sfDvBIlxLNBoQZbwExqEb5+OncmgytxiihKW1trTocENQZaHGGG7/V6VVVzvUR/sAo0+PDcj4BO7jZD9yzLjcVpwtFd4u0WKBGt62vnm/RX+gFazgMXnLybXtxd69n2D/lu5OJa/aNra9Oj4UT/kDTpAtmrx9/rVzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z0XvFMx3fFfrm4OzIDM0Ifa1DXVV1QP9CzS02snAwMY=;
 b=SpCJIbp8VH+L+qkOaH57trfo61xS6Y63kT7oY1asktz5HiYC1DY7ud4Nr3Og1yXfpoc4tUOOEHTdZKaVgiu8kQas0oI3eNdPKU/xOIPul/W1hTDOI2JN4KsvLQLqtkoprXNRAxqI0qyldVmyR6rELiySCfqbXHtKkB79RLwzGco=
Received: from BY1PR04MB9561.namprd04.prod.outlook.com (2603:10b6:a03:5b6::11)
 by BY5PR04MB6659.namprd04.prod.outlook.com (2603:10b6:a03:21a::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.23; Mon, 13 Jul
 2026 04:13:47 +0000
Received: from BY1PR04MB9561.namprd04.prod.outlook.com
 ([fe80::3869:e494:2fa8:9888]) by BY1PR04MB9561.namprd04.prod.outlook.com
 ([fe80::3869:e494:2fa8:9888%5]) with mapi id 15.21.0202.014; Mon, 13 Jul 2026
 04:13:47 +0000
From: Alistair Francis <Alistair.Francis@wdc.com>
To: "phuong.lamthanhthao@gmail.com" <phuong.lamthanhthao@gmail.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "palmer@dabbelt.com"
 <palmer@dabbelt.com>, "daniel.barboza@oss.qualcomm.com"
 <daniel.barboza@oss.qualcomm.com>, "danlam@g.hmc.edu" <danlam@g.hmc.edu>,
 "liwei1518@gmail.com" <liwei1518@gmail.com>, "zhiwei_liu@linux.alibaba.com"
 <zhiwei_liu@linux.alibaba.com>
Subject: Re: [PATCH] target/riscv: fix amocas with rd = x0 followed by beq
 involving x0 is not taken when it should be
Thread-Topic: [PATCH] target/riscv: fix amocas with rd = x0 followed by beq
 involving x0 is not taken when it should be
Thread-Index: AQHdCrh20Hl2rf9bYUaFl1yMdvToPLZq5o4A
Date: Mon, 13 Jul 2026 04:13:47 +0000
Message-ID: <e3f2c15e6dc2c10880dced476e439d7cdba4912f.camel@wdc.com>
References: <20260703065152.23024-1-danlam@g.hmc.edu>
In-Reply-To: <20260703065152.23024-1-danlam@g.hmc.edu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.60.2 (by Flathub.org) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY1PR04MB9561:EE_|BY5PR04MB6659:EE_
x-ms-office365-filtering-correlation-id: bb4d9691-ced7-46fa-091b-08dee09522ca
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|10070799003|19092799006|366016|376014|18002099003|22082099003|38070700021|56012099006|6133799003|11063799006|3023799007;
x-microsoft-antispam-message-info: /XJXe6AUchWVpZCttgv8vjKuoUsHe8XQfkl1bEuwHMzsblRlsRlSy6LgsqRIT09jgA+y8uEjzUxu0FWDSF5538+v0z652IsN0eAVwjwhSamfRfBw7aPfzFZZRJv4eqXrj/uzGkp4V3W9Yi6B93U5YOzCGx5r6tQG5l9iZV8hPvwHvip9HEbtFiN+Mp9cz3m0UxFfCoBYKG5enYVE97FoYVLXjLFrwKQQ/3wPnx8ruO1ZyIKfA6zecTBYrYESBv9aGy77Khrx5F/xVZecvcMtIbBiqLJUE0D+aQIsXdcWoI6yGtC2+U73KZ07LfHakV1XWFuoqp3A/yfMLUG3OxD1X4bs0TRfB8FlGIS98A6U9kDRPSrv1ShoB7GDAKsMB+pLPtBZUUU+LxbY5YKuWUQZwjvva9xMIfOqH2Epc5geUHMR14q7CT0MxBa1XJ4jpz01ZzANbaPuoZkjQI+BvPAF+baDew3gTRDdgwVYNZCC8LwChnGBxzPdv6GzGvsL9OE959ohskjscRbZZBcdn3R+cN1CvYrjkHF30+PFC+CZPk5OW6OxRhkAuo5Q8wqRVR3OjcS/FkTNwWbR7ghQCgyldHU8oTlMuiGd4zGbog5bFtsZ/FLplj2cmr3sqO2vl4ggSi3t1gR1gWF2uNVxTV0ZIInXeXvDWIFl4p8vF+WOfw1+/H4f2gWeqy1vm12MBwmyb/ISmXZ28LQkGpri6jd3+PfsP+/P0OBPy/n9vwYKQ7A=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY1PR04MB9561.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(10070799003)(19092799006)(366016)(376014)(18002099003)(22082099003)(38070700021)(56012099006)(6133799003)(11063799006)(3023799007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NjdtVWhnZ2hreXhKbUhBL2J3d3ZHSituRGlETXhUTVQraXMzanpuQzBwMmp5?=
 =?utf-8?B?M3hSVEZGak1GWGFZSFpUM2VoNnNXOGMrWk93STVENVNzRHRtL3R4SWVTNWE0?=
 =?utf-8?B?bmpoNjN6YTRneml5bDR3RCsreElEMDlxVmpIRDVsRHl2dmZmYWdValA1Ullw?=
 =?utf-8?B?Y1hqdGw3K0RlaHdrTTRmZE1SQ2FjWnhRYXV3aHBBRFFkS3I0YWJoVHdSTWp1?=
 =?utf-8?B?VWhrMGxMdnV1akNEclFtZVFhU2l5WldFeTN1SklmcmJPRTJBc2UzQ0R0akRh?=
 =?utf-8?B?R2NuK1JpWFdtbXJPVCttQjBEZHoxQkIrdXZ4RnZtMGJucmFJS0puWGx4K3Bp?=
 =?utf-8?B?RGdGZ1JDTXFXb0pjMjMvM2ZsM2RPUjB1ekVQVUgzQUlVUStEQ2hIVGZqZmRT?=
 =?utf-8?B?S3E4aWQ4Z3Q2VVNJM0l6TmRVeXVWMmEwaWRWUXVlcUxUV3RQRjRMZGRqTkd4?=
 =?utf-8?B?a3VOWEUxSC9GbzNyeTRGMHk1WFRtVDRjZk1vZDdkM3pHSEJkT05VNDgxUWVD?=
 =?utf-8?B?ckdaQXI0bCtIelpSSmVnOVhuT3ZUYlBiWW5MVUtXOFRXcDhOTU5GK2NPeEs1?=
 =?utf-8?B?dHA3MEtUVlNDUmY5UGpSMWk5dzBKZEMvWWtyNjdiQ0NzUXJ4VmZxdThuZ3ZK?=
 =?utf-8?B?S3BOM3FHTDRxbVNoWjVQL3Fnc1dGdk83Rkw3NWMxYXJFMG5zd2ZoRTBoa2w4?=
 =?utf-8?B?RVlibWRhWGRBcmg2Y2hkdzJvYnovSW9nb1lnNE9nMk9ERGhNdnpIbFZmdXpG?=
 =?utf-8?B?MHFzQ0tXbFZwS2dSbjh2SVJBMFU3dWN2dm1vZ3V4ZXFrNmNWZytPK0xicGlL?=
 =?utf-8?B?aXNyUnFhOEF6MVg3bkVpcXBGZVl1MUYyUzZYUjI2NkZCTWxaY2pvZk4yOHNM?=
 =?utf-8?B?T2hURUo5NUZlbWw2YmprQkhOQkd4aVhJeWZnK0FRYmlIMnNONDBsRVdQUGJy?=
 =?utf-8?B?dzhsSG8vQ1RUN014N3ZjcStTK1Qxdjc0b1lhRnBVR0JIQk9HQ2RqK0pQeml4?=
 =?utf-8?B?K250QXArSUNlMjFqUXV5WHlET0xYZ0k0bzNLN3ZTZWE0bkpqbGtTNGRpb25X?=
 =?utf-8?B?dFAwSkt1Q2VSQ25SdlRYREdRYWF1b0VRTWx3RzlKcWhZSUx3clpEOUJJazJT?=
 =?utf-8?B?NTlSVW0rRGdRZWhseVVXdU9hMUdoTVljVmNvN2tIcTRnbmY2ZjhNVXVXTDRy?=
 =?utf-8?B?T21pcFI3TWRYNnZWSkpGOXpIN2ZJWVVEU0JlUUN3SWt3K1hKMUtHaFFjUDlJ?=
 =?utf-8?B?YjdDeTBIWTYzRDhoM3h1dDBrQWhuSHhlbGFhcHAvQ2FQYUJrTkdUVEJPYUpu?=
 =?utf-8?B?MmdjaDl6cVpndjFBVW85WVQzMXRTdnRvUENJR1poWHo0SXJrenorcEJBNkgv?=
 =?utf-8?B?TFc1OU5qSGZuMFFsL3VDODdmakRPWk9iVXBnRUlmU3VMM2VkYUk1YUN4Vmhn?=
 =?utf-8?B?dCtBZGF2c1FrWHNxS2dKd3FvZG9ET1ltQjExMFVvS3ZYOW1iZkRzQjEyQ0Rm?=
 =?utf-8?B?VzAwaTV0anVyVmVXUk9BdXNxdVY4bXlvZThoMUsrNE5HYXAreHRRcXFrT3ZI?=
 =?utf-8?B?UmxNL1JwcVFYVzlFb211K3kwTzc0R2lQU3psS2FmWWVrR1hDRy9MY1lwQUZK?=
 =?utf-8?B?cXp1ekhSTldjZnBya3NaeHJaVlVIWHBvcmFsNC8zcmQ0MzNORHJObU12YTUv?=
 =?utf-8?B?eWpFNDFONUg2RkFzbHZ3N1FjVTVraTVLd0ZvYmVqMmMrcW9QTHBwRmNSQXlZ?=
 =?utf-8?B?d2hnRmhINjV5N21DRmh4aS8zaTlvLzFibnFpcGlhY0ltZmVrVkc0ZTE5UEdv?=
 =?utf-8?B?VVZFdXFKNkJJU1FDZXV2Mmt3UUkxcmV2Qmw5QlZFWEtaWWJkem1PY2pvQW40?=
 =?utf-8?B?dkM4SHQwUWxEV2ZrK3NSbW92ejZBWjN2cThYUHIvcmtCenhZY2IzMVk5OGFX?=
 =?utf-8?B?YnZRQmpvWGVNRWRmVWw1VUpVaS90anN2V1JyMHZlTjVBT3IvQlB4K0grL201?=
 =?utf-8?B?WWI2Z2JqcTBJV3o2V2xyRzhMcWZZa01CVWNhL01ZYjRNWC84cnY0QzhPQUl5?=
 =?utf-8?B?SmJleTlWd2dXbzB4NWJnbkpOTFlvcGJzZ1dPZis4Njh1eXdEcmowYnFZYlZQ?=
 =?utf-8?B?WjVJc3U0OGI2R3JuQzY0VXJjNVE0cTRwbEt6My9QdEVwNm8wYURLZU9HRGNM?=
 =?utf-8?B?NUQ2ZVhycVBwTzZSbnNkYXJWSzJEKzNkaDZnR1VET25HSnNYaGtRYzhRZDJX?=
 =?utf-8?B?cSs2RXo4UVFVUUhjWnZEL2JtZ0R5Q2pZdis4eVo1MGU4VVYrOWpxbHRwbXBS?=
 =?utf-8?B?WFFvbFliRnBUQmJBYkEwVDFxdDZ4YWhyWE5CQWpXRlhJUHJWMmdITXlwUFJ5?=
 =?utf-8?Q?uZWQmtmnSNc2jqYHedVvi0ArOLqQRwahwTcjt20fATlvZ?=
x-ms-exchange-antispam-messagedata-1: V/1jh30B8QJO90SsFhZVBzUbQEWZXvJTL9c=
Content-Type: text/plain; charset="utf-8"
Content-ID: <61EA0B4A08C83D4091CBE9AF705AEF4A@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: T3ER2L3DLmYSKvD7LDJaNRTqX0cNSyHWJuYeK5LvGCsrVzQeKKdv8IXyNgQ62Y79L43y0T1Z4npJUGCShE2cTZPHJwdeBZYJ8Em0Sr+sxp28AXWeBIHCeDEUMArOSY0gkdpgfRWNQnYVuiFOYleszaCV0Me9p4LURp8xSOLqSaK2gc12T1nl4Mta/HGTFoW4HeRKApVrNcN5it4urjj7kB+N6vagJDx63SsRKzUSrfGfs3FHMq4URnJuh+EHe/ovH6BBqL6vsUchnw26MYasa7vAz/cpoo9Fd0IIyVOh3VJenTA7Hy0VW528erqUtW5RPxXbnAsNMRQCJQIc28zblA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: XtxVNziYjyJQH8d4s/dYBid5ZH5qoG1l+xU9e8Z2AtmQ/20fYAv5V7ArD1KQfXKgqvlJFiBuJaHiTV4D0+Wkl0J05NzJfrxWVr/xaTiD7XRAx9F3RfexXVw70dN5Ozd0DFpaZz3vZ7DTBVJfNfcQPJElLbw2Z816cox/V5q/p5hR2YMhImEmTr5Tnxep0aLUwZveuO/5dZtf+KMi6TYFeAzObebbUaDmg2U2fYj1qGrJGNYZWELlCWwO+4oLX1ldUdX23yfG898HIiBdckKxrSpU01Vl9a9vmBMgV/qSKe34zjD7f+zLkFFAxW8sNHVtrM5GqwPiI5QQUK4IPlikbZJl1r3hhOWJewGA8zGeoj9ClgW5gIN0lVsEwHNdHxW8rxwq3yl3R72GVaD+IgE5Fcmoi9Z9N3V54fZr2cSnJW1atl+3MQql419NDD4GIK/UwYgcIQxLRj9KhpimX66E7Y5zd1/JPPA2bufPVj3TIlmA96xPeSP0F3MWnQB0C/75JVLoaklq0/KV3zAzADWc8u0AuBreJbUONyCIZvxiATwYx6w9PRdnHZCdr+xchOiwC2NUiRKo3CzyLTLnqOxW8crh3ECFpjFWiuNg//cFIiMVtBpFK190BkjsZJwOdopC
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY1PR04MB9561.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb4d9691-ced7-46fa-091b-08dee09522ca
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jul 2026 04:13:47.1404 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BnY1lyPa2k8HS/VnLzJwywA3Ho0PQMJ5KVyQx+5PzHl0THuGHpLeLnNj74pGUX83fQsFGmvNQoJZJ0t/T6Le/Xzp3Nhudq0/AU0RorSUe44=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB6659
Received-SPF: pass client-ip=216.71.154.42;
 envelope-from=prvs=64731fbe4=Alistair.Francis@wdc.com;
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

T24gRnJpLCAyMDI2LTA3LTAzIGF0IDEzOjUxICswNzAwLCBEYW5pZWxsZSBMYW0gd3JvdGU6DQo+
IGFtb2Nhcy57dyxkLHEsYixofSBpbXBsZW1lbnQgY29tcGFyZSBhbmQgc3dhcCBieSByZXVzaW5n
IHJkIGN1cnJlbnQNCj4gdmFsdWUgYXMgYm90aCBjb21wYXJhdG9yIGlucHV0IGFuZCBhcyB0aGUg
b3V0cHV0IHRoYXQNCj4gdGNnX2dlbl9hdG9taWNfY21weGNoZ18qIHdyaXRlcyB0aGUgb2xkIG1l
bW9yeSBpbnRvLiBCZWZvcmUgdGhlIGZpeCwNCj4gcmV0ID09IGNtcHYgYW5kIHdlIG5hbWUgdGhh
dCB2YXJpYWJsZSBkZXN0LiBXaGVuIHJkID0geDAsIGRlc3Qgd2FzDQo+IGN0eC0+emVyby4gVGhl
biBzaW5jZSByZXQgPT0gY21wdiBpbiB0aGUgZmlyc3QgcGxhY2UsIHRoZSBhdG9taWMgb3ANCj4g
b3ZlcndyaXRlcyByZXQgd2l0aCBjdHgtPnplcm8gd2hpY2ggaXMgbm90IHRoZSBzYW1lIHplcm8g
dmFsdWUuIEFueQ0KPiBsYXRlciBpbnN0cnVjdGlvbnMgdGhhdCByZWZlciBiYWNrIHRvIHJldCBm
b3IgdGhlIGluaXRpYWwgemVybyB2YWx1ZQ0KPiB3aGljaCBpcyBub3cgY2hhbmdlZCwgcmVzdWx0
aW5nIGluIDB4YmFhYWFhYWQwMDAwMDAwMC4NCg0KSSdtIGhhdmluZyBzb21lIHRyb3VibGUgZm9s
bG93aW5nIHdoYXQgdGhlIGlzc3VlIGlzLiBEbyB5b3UgbWluZA0KY2xlYXJpbmcgdXAgdGhpcyBj
b21taXQgdGl0bGUgYW5kIG1lc3NhZ2UgdG8gYmUgcmVhbGx5IGNsZWFyIG9mIHdoYXQNCnRoZSBp
c3N1ZSBpcyBhbmQgd2hhdCB5b3UgYXJlIGZpeGluZz8NCg0KQWxzbywgdGhlIGxpbmVzIHNob3Vs
ZCB3cmFwIGF0IGFyb3VuZCA3MCBjaGFyZWN0ZXJzDQoNCj4gDQo+IFRoZSBmaXggaXMgdG8gdXNl
IGRpZmZlcmVudCB2YXJpYWJsZXMgZm9yIHJldCBhbmQgY21wdiBhbmQgYXNzaWduDQo+IHRoYXQg
dG8gYXRvbWljIG9wIHRvIHJ1bi4NCj4gDQo+ICoqVEVTVElORyoqDQo+IGdlbl9jbXB4Y2hnDQo+
IC5kIHdhcyB0ZXN0ZWQgYW5kIGl0IHBhc3NlZC4gLncvLmIvLmggdXNlIHRoZSBzYW1lIGxvZ2lj
IHNvIHRoZSBmaXgNCj4gd2FzIHNpbWlsYXIuDQo+IA0KPiBnZW5fY21weGNoZzY0DQo+IC5kIHdh
cyBub3QgdGVzdGVkDQo+IA0KPiB0cmFuc19hbW9jYXNfcQ0KPiAucSBoYWQgaXRzIG93biBjdXN0
b20gdGVzdDogdGVzdF9hbW9jYXNxLlMNCj4gDQo+IC5zZWN0aW9uIC50ZXh0DQo+IC5nbG9ibCBf
c3RhcnQNCj4gX3N0YXJ0Og0KPiDCoMKgwqAgbGHCoMKgwqDCoMKgIHQwLCBzY3JhdGNoDQo+IMKg
wqDCoCBsacKgwqDCoMKgwqAgdDEsIDB4MTExMQ0KPiDCoMKgwqAgbGnCoMKgwqDCoMKgIHQyLCAw
eDIyMjINCj4gwqDCoMKgIHNkwqDCoMKgwqDCoCB0MSwgMCh0MCkNCj4gwqDCoMKgIHNkwqDCoMKg
wqDCoCB0MiwgOCh0MCkNCj4gDQo+IMKgwqDCoCBsacKgwqDCoMKgwqAgYTAsIDB4MzMzMw0KPiDC
oMKgwqAgbGnCoMKgwqDCoMKgIGExLCAweDQ0NDQNCj4gwqDCoMKgIGFtb2Nhcy5xIHgwLCBhMCwg
KHQwKQ0KPiANCj4gwqDCoMKgIGFkZGnCoMKgwqAgYTIsIHgwLCAwDQo+IA0KPiBzcGluOg0KPiDC
oMKgwqAgasKgwqDCoMKgwqDCoCBzcGluDQo+IA0KPiAuc2VjdGlvbiAuYnNzDQo+IC5hbGlnbiA0
DQo+IHNjcmF0Y2g6DQo+IMKgwqDCoCAuc3BhY2UgMTYNCj4gDQo+IFRoZW4gc2VhcmNoaW5nIHRo
ZSB0cmFjZSBsb2c6DQo+IGdyZXAgLW4gIngxMi9hMiIgYW1vY2FzcS10ZXN0LnRyYWNlLmxvZw0K
PiANCj4gSSBmb3VuZCB0aGF0IGFsbCBtYXRjaGVzIHJlYWQgemVyby4NCj4gMTA2MTI2OTY6IHgx
Mi9hMsKgwqAgMCB4MTMvYTPCoMKgIDAgeDE0L2E0wqDCoCAwIHgxNS9hNcKgwqAgMA0KPiAuLi4N
Cj4gMTA2MTM4OTI6IHgxMi9hMsKgwqAgMCB4MTMvYTPCoMKgIDAgeDE0L2E0wqDCoCAwIHgxNS9h
NcKgwqAgMA0KPiANCj4gUnVuIGFnYWluc3QgdGhlIHVucGF0Y2hlZCBjb2RlLCBhMiByZWFkIGJh
Y2sgYXMgMHgyMjIyLiBUaGlzIGNvbmZpcm1zDQo+IHRoZSB0ZXN0IHJ1biBhcyBpbnRlbmRlZCBh
bmQgdGhlIGZpeCB3b3Jrcy4NCg0KQ291bGQgeW91IGFkZCBhIHRlc3QgY2FzZSB0byB0ZXN0cy90
Y2cvcmlzY3Y2NC8gaW5zdGVhZD8gVGhpcyBpcyBoYXJkDQp0byB2ZXJpZnkgdGhhdCBpdCBmaXhl
cyBzb21ldGhpbmcNCg0KQWxpc3RhaXINCg0KPiANCj4gU2lnbmVkLW9mZi1ieTogRGFuaWVsbGUg
TGFtIDxkYW5sYW1AZy5obWMuZWR1Pg0KPiAtLS0NCj4gwqB0YXJnZXQvcmlzY3YvaW5zbl90cmFu
cy90cmFuc19ydnphY2FzLmMuaW5jIHwgMTMgKysrKysrKystLS0tLQ0KPiDCoHRhcmdldC9yaXNj
di90cmFuc2xhdGUuY8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHzCoCA1
ICsrKy0tDQo+IMKgMiBmaWxlcyBjaGFuZ2VkLCAxMSBpbnNlcnRpb25zKCspLCA3IGRlbGV0aW9u
cygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL3RhcmdldC9yaXNjdi9pbnNuX3RyYW5zL3RyYW5zX3J2
emFjYXMuYy5pbmMNCj4gYi90YXJnZXQvcmlzY3YvaW5zbl90cmFucy90cmFuc19ydnphY2FzLmMu
aW5jDQo+IGluZGV4IDc5YmNhMWU5NTcuLjg2N2Y1ZTVhZGUgMTAwNjQ0DQo+IC0tLSBhL3Rhcmdl
dC9yaXNjdi9pbnNuX3RyYW5zL3RyYW5zX3J2emFjYXMuYy5pbmMNCj4gKysrIGIvdGFyZ2V0L3Jp
c2N2L2luc25fdHJhbnMvdHJhbnNfcnZ6YWNhcy5jLmluYw0KPiBAQCAtNzIsMTMgKzcyLDE0IEBA
IHN0YXRpYyBib29sIGdlbl9jbXB4Y2hnNjQoRGlzYXNDb250ZXh0ICpjdHgsDQo+IGFyZ19hdG9t
aWMgKmEsIE1lbU9wIG1vcCkNCj4gwqDCoMKgwqDCoMKgwqDCoCByZXR1cm4gZmFsc2U7DQo+IMKg
wqDCoMKgIH0NCj4gwqANCj4gLcKgwqDCoCBUQ0d2X2k2NCBkZXN0ID0gZ2V0X2dwcl9wYWlyKGN0
eCwgYS0+cmQpOw0KPiDCoMKgwqDCoCBUQ0d2IHNyYzEgPSBnZXRfYWRkcmVzcyhjdHgsIGEtPnJz
MSwgMCk7DQo+IMKgwqDCoMKgIFRDR3ZfaTY0IHNyYzIgPSBnZXRfZ3ByX3BhaXIoY3R4LCBhLT5y
czIpOw0KPiArwqDCoMKgIFRDR3ZfaTY0IGNtcHYgPSBnZXRfZ3ByX3BhaXIoY3R4LCBhLT5yZCk7
DQo+ICvCoMKgwqAgVENHdl9pNjQgZGVzdCA9IHRjZ190ZW1wX25ld19pNjQoKTsNCj4gwqANCj4g
wqDCoMKgwqAgbW9wIHw9IGN0eC0+bW9fZW5kaWFubmVzczsNCj4gwqDCoMKgwqAgZGVjb2RlX3Nh
dmVfb3BjKGN0eCwgUklTQ1ZfVVcyX0FMV0FZU19TVE9SRV9BTU8pOw0KPiAtwqDCoMKgIHRjZ19n
ZW5fYXRvbWljX2NtcHhjaGdfaTY0KGRlc3QsIHNyYzEsIGRlc3QsIHNyYzIsIGN0eC0+bWVtX2lk
eCwNCj4gbW9wKTsNCj4gK8KgwqDCoCB0Y2dfZ2VuX2F0b21pY19jbXB4Y2hnX2k2NChkZXN0LCBz
cmMxLCBjbXB2LCBzcmMyLCBjdHgtPm1lbV9pZHgsDQo+IG1vcCk7DQo+IMKgDQo+IMKgwqDCoMKg
IGdlbl9zZXRfZ3ByX3BhaXIoY3R4LCBhLT5yZCwgZGVzdCk7DQo+IMKgwqDCoMKgIHJldHVybiB0
cnVlOw0KPiBAQCAtMTE3LDEzICsxMTgsMTUgQEAgc3RhdGljIGJvb2wgdHJhbnNfYW1vY2FzX3Eo
RGlzYXNDb250ZXh0ICpjdHgsDQo+IGFyZ19hbW9jYXNfcSAqYSkNCj4gwqDCoMKgwqAgVENHdl9p
MTI4IHNyYzIgPSB0Y2dfdGVtcF9uZXdfaTEyOCgpOw0KPiDCoMKgwqDCoCBUQ0d2X2k2NCBzcmMy
bCA9IGdldF9ncHIoY3R4LCBhLT5yczIsIEVYVF9OT05FKTsNCj4gwqDCoMKgwqAgVENHdl9pNjQg
c3JjMmggPSBnZXRfZ3ByKGN0eCwgYS0+cnMyID09IDAgPyAwIDogYS0+cnMyICsgMSwNCj4gRVhU
X05PTkUpOw0KPiAtwqDCoMKgIFRDR3ZfaTY0IGRlc3RsID0gZ2V0X2dwcihjdHgsIGEtPnJkLCBF
WFRfTk9ORSk7DQo+IC3CoMKgwqAgVENHdl9pNjQgZGVzdGggPSBnZXRfZ3ByKGN0eCwgYS0+cmQg
PT0gMCA/IDAgOiBhLT5yZCArIDEsDQo+IEVYVF9OT05FKTsNCj4gK8KgwqDCoCBUQ0d2X2k2NCBj
bXBsID0gZ2V0X2dwcihjdHgsIGEtPnJkLCBFWFRfTk9ORSk7DQo+ICvCoMKgwqAgVENHdl9pNjQg
Y21waCA9IGdldF9ncHIoY3R4LCBhLT5yZCA9PSAwID8gMCA6IGEtPnJkICsgMSwNCj4gRVhUX05P
TkUpOw0KPiArwqDCoMKgIFRDR3ZfaTY0IGRlc3RsID0gdGNnX3RlbXBfbmV3X2k2NCgpOw0KPiAr
wqDCoMKgIFRDR3ZfaTY0IGRlc3RoID0gdGNnX3RlbXBfbmV3X2k2NCgpOw0KPiDCoMKgwqDCoCBN
ZW1PcCBtZW1vcCA9IE1PX0FMSUdOIHwgTU9fVU87DQo+IMKgDQo+IMKgwqDCoMKgIG1lbW9wIHw9
IGN0eC0+bW9fZW5kaWFubmVzczsNCj4gwqDCoMKgwqAgdGNnX2dlbl9jb25jYXRfaTY0X2kxMjgo
c3JjMiwgc3JjMmwsIHNyYzJoKTsNCj4gLcKgwqDCoCB0Y2dfZ2VuX2NvbmNhdF9pNjRfaTEyOChk
ZXN0LCBkZXN0bCwgZGVzdGgpOw0KPiArwqDCoMKgIHRjZ19nZW5fY29uY2F0X2k2NF9pMTI4KGRl
c3QsIGNtcGwsIGNtcGgpOw0KPiDCoMKgwqDCoCBkZWNvZGVfc2F2ZV9vcGMoY3R4LCBSSVNDVl9V
VzJfQUxXQVlTX1NUT1JFX0FNTyk7DQo+IMKgwqDCoMKgIHRjZ19nZW5fYXRvbWljX2NtcHhjaGdf
aTEyOChkZXN0LCBzcmMxLCBkZXN0LCBzcmMyLCBjdHgtDQo+ID5tZW1faWR4LCBtZW1vcCk7DQo+
IMKgDQo+IGRpZmYgLS1naXQgYS90YXJnZXQvcmlzY3YvdHJhbnNsYXRlLmMgYi90YXJnZXQvcmlz
Y3YvdHJhbnNsYXRlLmMNCj4gaW5kZXggOTY4NGRiZTc1Mi4uNjJhOWFmOWI1NiAxMDA2NDQNCj4g
LS0tIGEvdGFyZ2V0L3Jpc2N2L3RyYW5zbGF0ZS5jDQo+ICsrKyBiL3RhcmdldC9yaXNjdi90cmFu
c2xhdGUuYw0KPiBAQCAtMTE2NiwxMyArMTE2NiwxNCBAQCBzdGF0aWMgYm9vbCBnZW5fYW1vKERp
c2FzQ29udGV4dCAqY3R4LA0KPiBhcmdfYXRvbWljICphLA0KPiDCoA0KPiDCoHN0YXRpYyBib29s
IGdlbl9jbXB4Y2hnKERpc2FzQ29udGV4dCAqY3R4LCBhcmdfYXRvbWljICphLCBNZW1PcCBtb3Ap
DQo+IMKgew0KPiAtwqDCoMKgIFRDR3YgZGVzdCA9IGdldF9ncHIoY3R4LCBhLT5yZCwgRVhUX05P
TkUpOw0KPiDCoMKgwqDCoCBUQ0d2IHNyYzEgPSBnZXRfYWRkcmVzcyhjdHgsIGEtPnJzMSwgMCk7
DQo+IMKgwqDCoMKgIFRDR3Ygc3JjMiA9IGdldF9ncHIoY3R4LCBhLT5yczIsIEVYVF9OT05FKTsN
Cj4gK8KgwqDCoCBUQ0d2IGNtcHYgPSBnZXRfZ3ByKGN0eCwgYS0+cmQsIEVYVF9OT05FKTsNCj4g
K8KgwqDCoCBUQ0d2IGRlc3QgPSBkZXN0X2dwcihjdHgsIGEtPnJkKTsNCj4gwqANCj4gwqDCoMKg
wqAgbW9wIHw9IGN0eC0+bW9fZW5kaWFubmVzczsNCj4gwqDCoMKgwqAgZGVjb2RlX3NhdmVfb3Bj
KGN0eCwgUklTQ1ZfVVcyX0FMV0FZU19TVE9SRV9BTU8pOw0KPiAtwqDCoMKgIHRjZ19nZW5fYXRv
bWljX2NtcHhjaGdfdGwoZGVzdCwgc3JjMSwgZGVzdCwgc3JjMiwgY3R4LT5tZW1faWR4LA0KPiBt
b3ApOw0KPiArwqDCoMKgIHRjZ19nZW5fYXRvbWljX2NtcHhjaGdfdGwoZGVzdCwgc3JjMSwgY21w
diwgc3JjMiwgY3R4LT5tZW1faWR4LA0KPiBtb3ApOw0KPiDCoA0KPiDCoMKgwqDCoCBnZW5fc2V0
X2dwcihjdHgsIGEtPnJkLCBkZXN0KTsNCj4gwqDCoMKgwqAgcmV0dXJuIHRydWU7DQo=

