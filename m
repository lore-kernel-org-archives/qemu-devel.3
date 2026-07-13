Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13B0AC43458
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2026 04:02:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wj7rY-0002lx-EX; Mon, 13 Jul 2026 00:01:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=64731fbe4=Alistair.Francis@wdc.com>)
 id 1wj7rQ-0002lc-Mh; Mon, 13 Jul 2026 00:01:42 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=64731fbe4=Alistair.Francis@wdc.com>)
 id 1wj7rM-0002Wf-30; Mon, 13 Jul 2026 00:01:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1783915298; x=1815451298;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=2CIVCuJcVHq0LzitYq1R3CjEuS29LGUARp4V/A92rtY=;
 b=F4FlZPP5OolUDW4WdwP69+XWSAlofWir3Ksm3yMW4m+qwY8X6j79oexN
 nRHQfXhZx0sSSecNUQlMfYymWjuOeRnEQJg921MFIHZ5cPanNvVaSOnAl
 VzLJWGXcFxgJEUTTmsp2tzrS0Ld8Lqw+O0n7T0iojfVGhjD0TVs/7OQDi
 q/SsQdS3rJUWIHTeGLW3uaTpkMc4sCb6o43wyxlbj4dHhmlyrImpNbZEb
 IA0N/TvtsFHF8XcghWYun0H8hPqzVknqT05FTbryFmeGPwe+01oYHbLTY
 undhmH6n0wDQUViZIL+nAwLrf+oL6Yymx46QBWFKz+y+dorTHYf7WgkR4 Q==;
X-CSE-ConnectionGUID: 8TxH/u3dRyONVWvP3L/wOA==
X-CSE-MsgGUID: 4OUIf0UgR5uiTnuOZNWMRA==
X-IronPort-AV: E=Sophos;i="6.25,154,1779120000"; d="scan'208";a="149364936"
Received: from mail-westus3azon11010056.outbound.protection.outlook.com (HELO
 PH7PR06CU001.outbound.protection.outlook.com) ([52.101.201.56])
 by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 13 Jul 2026 12:01:28 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Cilsu+JdsifO/zfj13vqZKH0uYOOddI7M41esJRli9ek7AVUfUto5eIv08Df5uqMOhp+uMkI2pRV4nfBJ94zpBEXONr/ev6HtiGGHP0j0RP0/NywI8N9XPvvykJcUPbNDOlM3JBVyr8Q7KtzDfrD8yrgVTiuHlYH5hv5hnT9lI63F5viO70v5u/EegW9MKFt+uzntR3CBRSYZuSnfY9DLF//o5pQ4nZcjIJc/ZaCH9rDYoAL0l+wYnDLIwiH7Iwq6yW2aKBzVGV5AKZ/zzny/S9v0szS/KvWtgtKI5zvRGyw5HKMuRvlhimt3vUSgyefPf5f9aP7VgtHFND+WoqWCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2CIVCuJcVHq0LzitYq1R3CjEuS29LGUARp4V/A92rtY=;
 b=jmdJN/sIJeKy8B6Cjqb3e2LJM3mOkTQi3BAizNE2ByPtP64gA3KgJbgcZZ1BhQxgvFTpMyQovKJiy5g15aj3ZA5fU+AodsncW6O9E3ZlaHkSk4WkIgwuLMGifCMG+S0RkNHm8oHEVsvkn7UAZVW5QYji19SOTg/mOsPb/JZL0ioRZZZKkDpuoRge3qbQofTcsSWfgwFlNopAVck4fzDkbReHyNv+2Up6AfSg1NHfAAfJmBNpPrXA/3yBeDekj9aiudn7N8L2ZbPHgLdcyO5jKRbbmV5H/AUQ/Ex7uPpEvtkA31cHykLZotjTdNkGtNyfCU//Duf5LR57wc8jr2rHpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2CIVCuJcVHq0LzitYq1R3CjEuS29LGUARp4V/A92rtY=;
 b=MosC8U3/c9xib33s2m4e7nfxIOrVGBuHDB5oGlrQVr2Z2bRkQmhvfqmKl402O2+4zHtMEUD59NIOi6eyoW1LI+K5EWC/HtZk0hzghiQi2KlXW1Z9t/JwoC3gEz61TKzor6DrPRJIQnhiqXe+Ro8tmpk6/iZ0wqxN8yArQ2GKPls=
Received: from BY1PR04MB9561.namprd04.prod.outlook.com (2603:10b6:a03:5b6::11)
 by BY5PR04MB6817.namprd04.prod.outlook.com (2603:10b6:a03:221::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.19; Mon, 13 Jul
 2026 04:01:24 +0000
Received: from BY1PR04MB9561.namprd04.prod.outlook.com
 ([fe80::3869:e494:2fa8:9888]) by BY1PR04MB9561.namprd04.prod.outlook.com
 ([fe80::3869:e494:2fa8:9888%5]) with mapi id 15.21.0202.014; Mon, 13 Jul 2026
 04:01:23 +0000
From: Alistair Francis <Alistair.Francis@wdc.com>
To: "frank.chang@sifive.com" <frank.chang@sifive.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "palmer@dabbelt.com" <palmer@dabbelt.com>, "qemu-riscv@nongnu.org"
 <qemu-riscv@nongnu.org>, "daniel.barboza@oss.qualcomm.com"
 <daniel.barboza@oss.qualcomm.com>, "chao.liu@processmission.com"
 <chao.liu@processmission.com>, "liwei1518@gmail.com" <liwei1518@gmail.com>,
 "zhiwei_liu@linux.alibaba.com" <zhiwei_liu@linux.alibaba.com>
Subject: Re: [PATCH v6 0/6] target/riscv: Support the true Zicclsm extension
Thread-Topic: [PATCH v6 0/6] target/riscv: Support the true Zicclsm extension
Thread-Index: AQHdEnrtu3l94Vx+A0O/GETZyuIR27Zq05OA
Date: Mon, 13 Jul 2026 04:01:23 +0000
Message-ID: <6c50f31be3a11f34f9cf9f507cb7a7d1fdea1532.camel@wdc.com>
References: <20260713035135.3996990-1-frank.chang@sifive.com>
In-Reply-To: <20260713035135.3996990-1-frank.chang@sifive.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.60.2 (by Flathub.org) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY1PR04MB9561:EE_|BY5PR04MB6817:EE_
x-ms-office365-filtering-correlation-id: 12c51334-4dd0-4c37-7b78-08dee09367c8
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|10070799003|19092799006|23010399003|376014|18002099003|22082099003|6133799003|56012099006|11063799006|3023799007|38070700021;
x-microsoft-antispam-message-info: ua0wRRUT9SbrLPOYY9+/DopiKjZg5JrLJdFXqid33RUpfNwRD/ra4x9e9P0gVKbGxcf1uKnvLsBfdoArVFLXB7kXnPk3e2FSxtyKweGwwgKqeb3eho47P5TV3QZoVAmTZEOlnlPxxbWLMBvOy47zy+qyJOrVARyPSxZA7X0hA4NbQ8cIYCDhVI7N8Ggq8aXNXVDunprwcVdVg/DfO7x79pK1jKDhLv4ux4PhKSyD7JrMm61TF2WRxhHLrBDtKoyi5Fo99Yg8Vd+Yod9K0DEzbM7a34jAKR62IKaEXKbWkKm0yWcpI/lly1FU+0JRRuAsILZeZEkLIF4LhjCfuyKkq4L7eYmSyoIr0lZ8amwxTL87uANrbxHz8/BnhhjawEtILouYpgQCb0GEhGRiXumvzMVuW4wlLgmWDh9I6ijbr+rwbZJSUP0oVuHbLR4Ogo7QxR9aOsDTsOKLI11avMrtQNM5fYxNR5LmGAe6BTHF84sIweI7omhRihVvbV0q96EgryarTRIhLKwgLc8SNTulPMGinzfWVjZIIKYTHaVTOIRcq1yIE0i+0JtDzV13dVIVY4AlP2H2Hy9FD343C2BCC6Kd+5CryJPeZ2GYJhXI4opu1MuAF8HsveBqOmDeMKZsibZ4iuPZJhU/SA21LX5t2CA4OZRmEw76xUMJm/FlHpg=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY1PR04MB9561.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(10070799003)(19092799006)(23010399003)(376014)(18002099003)(22082099003)(6133799003)(56012099006)(11063799006)(3023799007)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bXdJYUJrNzcwdG02T21ZZkVGUHUyZFdDNVdZaW5pUVpRMS9YcFlaQ3Rodlpl?=
 =?utf-8?B?STdQMFdJcm82S3R1Z2FGTkFhQzl4UlVCN1VSQllGKzlnUnNHdkR0MzhGaXZs?=
 =?utf-8?B?OXFpWitsR0J4VFY1Q01JeTVCUmdicHhVSzgwcUhidWdDMEdMUno5UkZTUURk?=
 =?utf-8?B?SGhpMW8wKzFiSjBQamJhb0Y1MXYrdGQ5OHZQR1M2RjlMTDhuY3B6ZXVmbGhT?=
 =?utf-8?B?dUoxTzdIZXoreTY0djFsVFNKMGxUUWJFZXJOVHdUSVlEeWY5dDZ3SWR5Q2Nj?=
 =?utf-8?B?SFJZUUtiMXN5WGhNMEhXallyRDBUeTFzTG4wKzJ0b3BoRTk0aW5JSS9XZFVX?=
 =?utf-8?B?eXVvS2F2QXB3RlZneFFEV0VjYjV5QUtHSVFXNklpRTVCVlZ0Y2s4NnJHR2ZF?=
 =?utf-8?B?cjM5UzJMOHl5QWgxRnREclJxUTlTTXdQK3NRNFNpcGhWY1RqbWFUS01FQ2tD?=
 =?utf-8?B?bVh4QTBJUXZmaUYyRWtRMW1ZblMxalZicEZCY0pNRGI4N3hHMG5SdVlmSDFo?=
 =?utf-8?B?a1FKRGJzRFJ4anFtb0ZYekJGUEh4RTFrdGo2b2xmbkgvS0lBSUdyaVdGUVR5?=
 =?utf-8?B?OEhnUFdNWFZveWFBaXZPRmhlMkRodGF6MVNWSkZmSlFob1Z0aGJvd0VmMTQx?=
 =?utf-8?B?MFNoRGxraVVkYituMjVjaHdlQlViMGoydTdtcWRkWDBwcGtBU3hmL0NCU2Fm?=
 =?utf-8?B?VGRGd1ZIWGVBekU2dVcrV0J5VFBZRnZzb1hJT05UaVVxdFR3ZEhKN0U3SElq?=
 =?utf-8?B?cVliU0F3d09pUW00RnNTU1FaUHp6YVB6UWgzUENxeExGQUJ1NDlJRi81Rysx?=
 =?utf-8?B?cnp0MUV0aFNEb3hqNHB6aHhZV2xzL2phNUhSbnFHem5idjIrS0thakI5WExL?=
 =?utf-8?B?WU9aMFFZUDRxTnVRTEJHaHNVSERJbE9MRGhKcjJvNFhETFA1RG9MSkF6Ukdq?=
 =?utf-8?B?WjdFU2pEYzh4cTdENGFlOTNuN3hYdmtoUk1MYktmcDJQbjRCNDdHQmE3dUor?=
 =?utf-8?B?bXJaT2UxYnRzRUlsV2ZzZnQ4WGFZNWZoR08rMi84OVpDUXJ0a2llVGNxb0VP?=
 =?utf-8?B?WjYwSmp2UGNhcEd5N0UrZTZqbDROdXJoWmVhNkNQalVCZWhRMFd0S0JEOFY1?=
 =?utf-8?B?N1kzYUo4NGZONXVmZklPVDh6WC92djFGTmFwMmhKNUlhNkgrZzVZVC9RRStN?=
 =?utf-8?B?eFVHU0pHYk1UQlJmeGpkcVdZbjNDZ2owWHhRQVVxb2VqVllEdXltcWJQUUNv?=
 =?utf-8?B?MFNrMVZOWEtFN0hpWWZNbHpYM1hLZXFmTkxNcmR2dFJMS0ZaQ0kvMk5KdFZB?=
 =?utf-8?B?d29jYjhFR0ZyeVpPSklCdEFhTWx1TEpFNkxseTJQQ1RSOXBkb3phQVFoVDFz?=
 =?utf-8?B?SmJTTDloanNaSzMzckpvNDVydWpBNzBnSmlXcUNERXJaUlRkVmg1azgyRWxN?=
 =?utf-8?B?eVVpWURVNHI2eXhiMHhkMVlLa1hDdFdwUitRUXovRVlQSTNGaE5YYkEwRDRB?=
 =?utf-8?B?K1ZNRXRsTyt4RnpUTjVJUGVxSlF2dkdaY1lULzVzVDNycWltWUkwaFNvYTFB?=
 =?utf-8?B?WDNqcHhmVGZxcVFTaEZsZHN2VzVKZnhxTzJ6TGc4TmVPOXNQeldHZm81d0ha?=
 =?utf-8?B?UXZvL0RvS21pd25ldHVOeXQ1WE9BcUVMUWJPdEd4a3RZT2d6aVdrTnNFc3dQ?=
 =?utf-8?B?RkM5QjE2b3NhWTl1aXFIWDhtQjYybGcvcmwyaU1UcXQyOWU2MG9pcHRSeHNt?=
 =?utf-8?B?aGxvUndicnRiVjFjU1V3dm9VK0lwNUxNSnkwbEt4K1liMmJFQU5vdkl2L3U2?=
 =?utf-8?B?TW16WnJCcTNIZTMzR0wzd2NmZE4vOWpGQ2MzMGZsaEdrWjYzbk1HR09Mc3FF?=
 =?utf-8?B?enFkcGYwaXIwRjNTakVTNEdJLzhMUmdTUTUrZGtFaUxMWDZtL05OamhkYURU?=
 =?utf-8?B?MnJuelNyVGpmb1J3ODVkRnZud0NQcUpnMlVEVlNwcnM4dlNtTHF2ZEZTOVhX?=
 =?utf-8?B?eU5zeXVETU1BcnM1dlFmWTlQY1VqUm50cmNrR3l1NFAxdVgvRVdyc0lwMVRY?=
 =?utf-8?B?dGdsSjdnYS9iM2hXdnc5Y05VWnp6Um9KTGRxd1FrQUUrY0xVM2dGbTRMNllV?=
 =?utf-8?B?bFRvSGhmSGZVLzVOeXJxL1I1UDdhamFiQlo0MlpKS3Vtc0ZtVXNwZmo4a012?=
 =?utf-8?B?MlBFa2dWNzExbTM1WW0xNkNLUGFUbGZGa2M5Rmw5RU1KSHJBU3ZIakJvRHBC?=
 =?utf-8?B?cCt2b1l3cG10YU5aNnZ2V25JWWkxTFVvbEVsN09wS0lueExabmd4aE04TWVn?=
 =?utf-8?B?U1EvNTZsM21nYmxqMEZHWkljWDFleGN5WWpEYXZpMkpSMHliU3VHOGdtVEJi?=
 =?utf-8?Q?xHWALh327myKJcQNlz8y3Oa7uWNUk0a93mVky2GSqbCSY?=
x-ms-exchange-antispam-messagedata-1: 1Jv8nnldNjsZhpEd9IMsU1BaC0jfwJx5aCU=
Content-Type: text/plain; charset="utf-8"
Content-ID: <98298246D0E3BC4094146EE361DEB02C@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: qin8YYLjeKqYDXbNK21MBZqxLcnT3+K55Bu+gDu5OACQ3XJYob8lSh1wskNL3Q0kj82xTQf97lbUoA5sMK42OVTvf2I7p3j6C0JnC27d2+zYi8hlGYL97lggJKhgQlNOqJJU+ok7rd+rCbXF6zSgbVkOE3N6dC5rcsX0L76pJ8MKsAlM8ntzX0hSMa5GmIhAMIJjT6H/fN1/DsrhyP3VMXdEXeNTC+BVO5uGOsI2Xp1FXDxNawIJcO7bV8FJ7LWVAtOt06VMa8Q7YTaeHJFsVTnKzcnNvq3+EPH8R5RayPtdhzJwJhCapqh7pVbmRoVjdCuC4UtW3fGiJ3tXYkVcXw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: r2gS3LmGnpvCQupvtyhEfmUWqvi1QUZWqrIUt2m3CuX1p/ff3T3F6viOyeVhSUH5WL0bJxuaH4I3EKWfc16EkKkpM7B6jHVAEeoHKx8PN3SAuu7jqpSVh1p4L4xq2OCyReZIyF7PX5OLW3RpgMhZhB6/XRMcPYaQLhCLgphPLq526d1odl8w0/iXvBYWMkN5uqPaWqIuR80oRaoKb2kiI7lvHbbSRuxIB1fNqKnk2XeCIcdQwBlauTSNJ5PmldjXhkVfhGPuB8GKqJHtNXryvSSHK6hf3x3YXzjiU3NVXXyAwiVo6Pfo1wB4CSggqmgq0UPYSdhKO7T/ULyg0bTdIHZ3Sqo+1sNvpkD1mPbGPOAkZ2x9c89Szk5N4gdavmKDPDFXY/vH05HUW6d2ncMtAtHrP/fl9eBPhyJ/Yo2upjoU6xrx6pT3IgqQ/JYWMD/jbRKt6NLbA4sXQj56HREULBQGOG/UJ/lEf+fk0MpGwEvYDC54aCI5lgrDaO+rgk11f0EKng1h+n5q4QYBjIvWhV+bqjQwXbmZdk/+9YI4KSiHgdzJjkDZXXtq6K7hD46lXl9G0r0ykFLPmUSTxhMIG0uamZxvlDuZv5G3O6wWyPd68WPKvdCATjs7AZCrpYjF
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY1PR04MB9561.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12c51334-4dd0-4c37-7b78-08dee09367c8
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jul 2026 04:01:23.8905 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 30ZUp7krcPzcW2JYqWdqqa9ZfGe2O9Mc7eUu1apG/QDHblyqc+1EbhA4kxUDb6TqtQCQrD2cz8i3WXAbyJ4zU2Cwt0SQwRekNSdoKhisGCo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB6817
Received-SPF: pass client-ip=216.71.154.45;
 envelope-from=prvs=64731fbe4=Alistair.Francis@wdc.com;
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

T24gTW9uLCAyMDI2LTA3LTEzIGF0IDExOjUxICswODAwLCBmcmFuay5jaGFuZ0BzaWZpdmUuY29t
IHdyb3RlOg0KPiBGcm9tOiBGcmFuayBDaGFuZyA8ZnJhbmsuY2hhbmdAc2lmaXZlLmNvbT4NCj4g
DQo+IFN1cHBvcnQgdGhlIHRydWUgWmljY2xzbSBleHRlbnNpb24gc28gdGhhdCB3ZSBjYW4gdHJh
cCBtaXNhbGlnbmVkDQo+IGFjY2Vzc2VzDQo+IHdoZW4gWmljY2xzbSBpcyBkaXNhYmxlZC4NCj4g
DQo+IFRvIGVuYWJsZS9kaXNhYmxlIFppY2Nsc20sIHNpbXBseSBzZXQgemljY2xzbT1bdHJ1ZXxm
YWxzZV0sIGUuZy46DQo+IMKgIC1jcHUgcnY2NCx6aWNjbHNtPVt0cnVlfGZhbHNlXQ0KPiANCj4g
UUVNVSB3aWxsIHJhaXNlIGEgbWlzYWxpZ25lZCBsb2FkL3N0b3JlIGV4Y2VwdGlvbiB3aGVuIGV4
ZWN1dGluZw0KPiBtaXNhbGlnbmVkDQo+IGxvYWQvc3RvcmUgaW5zdHJ1Y3Rpb25zIGlmIFppY2Ns
c20gaXMgZGlzYWJsZWQuDQo+IA0KPiBDaGFuZ2Vsb2c6DQo+IMKgIHY2Og0KPiDCoMKgwqAgKiBS
ZW9yZGVyIGFuZCBzcXVhc2ggWmljY2xzbSBDUFUgcHJvcGVydHkgYW5kIFJWQTIyVTY0IHByb2Zp
bGUNCj4gcGF0Y2hlcyB0bw0KPiDCoMKgwqDCoMKgIG1ha2UgZXZlcnkgc2luZ2xlIGNvbW1pdCB0
byBwYXNzIGBtYWtlIGNoZWNrYC4NCj4gwqAgdjU6DQo+IMKgwqDCoCAqIEFkZCBaaWNjbHNtIHRv
IFJWQTIyVTY0IHByb2ZpbGUgZXhwbGljaXRseS4NCj4gwqDCoMKgICogUmViYXNlIHRvIHRoZSBs
YXRlc3QgcmlzY3YtdG8tYXBwbHkubmV4dC4NCj4gwqAgdjQ6DQo+IMKgwqDCoCAqIEFsaWduIFJP
TSByZXNldCB2ZWN0b3IgZGF0YSBhdCA4LWJ5dGUgYWxpZ25lZCBvZmZzZXRzLg0KPiDCoCB2MzoN
Cj4gwqDCoMKgICogRW5hYmxlIFppY2Nsc20gZm9yIHRoZSBjb21wYXRpYmxlIENQVXMuDQo+IMKg
wqDCoCAqIFJlYmFzZSB0byB0aGUgbGF0ZXN0IHJpc2N2LXRvLWFwcGx5Lm5leHQuDQo+IMKgIHYy
Og0KPiDCoMKgwqAgKiBVc2UgKHNpemVfbWVtb3Aoc2l6ZSkgfCBtb19lbmRpYW5fZW52KGVudikp
IHRvIGNhbGN1bGF0ZSBNZW1PcC4NCj4gwqDCoMKgICogVXNlIChsb2cyX2VzeiA8PCBNT19BU0hJ
RlQpIHRvIGNhbGN1bGF0ZSBhbGlnbWVudCBNZW1PcCBmb3INCj4gwqDCoMKgwqDCoCB2ZWN0b3Ig
bG9hZC9zdG9yZSB3aG9sZSByZWdpc3RlciBpbnN0cnVjdGlvbnMuDQo+IA0KPiBGcmFuayBDaGFu
ZyAoNik6DQo+IMKgIHRhcmdldC9yaXNjdjogQWRkIFppY2Nsc20gQ1BVIG9wdGlvbg0KPiDCoCB0
YXJnZXQvcmlzY3Y6IEVuYWJsZSBaaWNjbHNtIGZvciB0aGUgY29tcGF0aWJsZSBDUFVzDQo+IMKg
IGh3L3Jpc2N2OiBzaWZpdmVfdTogQWxpZ24gUk9NIHJlc2V0IHZlY3RvciBkYXRhDQo+IMKgIHRh
cmdldC9yaXNjdjogU3VwcG9ydCByYWlzaW5nIG1pc2FsaWduZWQgZXhjZXB0aW9ucyBmb3Igc2Nh
bGFyDQo+IMKgwqDCoCBsb2Fkcy9zdG9yZXMNCj4gwqAgdGFyZ2V0L3Jpc2N2OiBTdXBwb3J0IHJh
aXNpbmcgbWlzYWxpZ25lZCBleGNlcHRpb25zIGZvciB2ZWN0b3INCj4gwqDCoMKgIGxvYWRzL3N0
b3Jlcw0KPiDCoCB0YXJnZXQvcmlzY3Y6IEV4cG9zZSBaaWNjbHNtIGFzIGEgQ1BVIHByb3BlcnR5
IGFuZCB1cGRhdGUgUlZBMjJVNjQNCj4gwqDCoMKgIHByb2ZpbGUNCg0KVGhpcyBoYXMgbWlzc2Vk
IHRoZSAxMS4xIHJlbGVhc2Ugd2luZG93IFsxXS4gU28gaXQgd2lsbCBub3cgbmVlZCB0bw0KaW5j
bHVkZSB1bml0IHRlc3RzIGFuZCBhIHVzZXIgb2YgdGhlIGV4dGVuc2lvbiAoc3VibWl0dGVkIHRv
b2xjaGFpbg0Kc3VwcG9ydCBwYXRjaGVzKSBhY2NvcmRpbmcgdG8gWzJdLg0KDQoxOiBodHRwczov
L3dpa2kucWVtdS5vcmcvUGxhbm5pbmcvMTEuMQ0KMjoNCmh0dHBzOi8vd2lraS5xZW11Lm9yZy9E
b2N1bWVudGF0aW9uL1BsYXRmb3Jtcy9SSVNDViNSSVNDLVZfRm91bmRhdGlvbl9FeHRlbnNpb25z
DQoNCkFsaXN0YWlyDQoNCj4gDQo+IMKgaHcvcmlzY3Yvc2lmaXZlX3UuY8KgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8IDExICsrLS0NCj4gwqB0YXJnZXQv
cmlzY3YvY3B1LmPCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCB8IDEwICsrKy0NCj4gwqB0YXJnZXQvcmlzY3YvY3B1X2NmZ19maWVsZHMuaC5pbmPCoMKg
wqDCoMKgwqDCoMKgwqDCoCB8wqAgMiArDQo+IMKgdGFyZ2V0L3Jpc2N2L3RjZy9pbnNuX3RyYW5z
L3RyYW5zX3J2aS5jLmluYyB8wqAgNiArKw0KPiDCoHRhcmdldC9yaXNjdi90Y2cvaW5zbl90cmFu
cy90cmFuc19ydnYuYy5pbmMgfCAxOCArKysrKy0NCj4gwqB0YXJnZXQvcmlzY3YvdGNnL3ZlY3Rv
cl9oZWxwZXIuY8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfCA2NSArKysrKysrKysrKysrKysrLS0t
DQo+IC0tDQo+IMKgNiBmaWxlcyBjaGFuZ2VkLCA4OCBpbnNlcnRpb25zKCspLCAyNCBkZWxldGlv
bnMoLSkNCj4gDQo+IC0tDQo+IDIuNDMuMA0KPiANCg==

