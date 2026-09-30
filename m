Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D86DCA5FC5
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2026 23:53:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xC46n-0005QH-J6; Wed, 30 Sep 2026 19:53:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=726c96411=Alistair.Francis@wdc.com>)
 id 1xC46e-0005Pz-Rl; Wed, 30 Sep 2026 19:53:01 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=726c96411=Alistair.Francis@wdc.com>)
 id 1xC46c-0005dE-Py; Wed, 30 Sep 2026 19:53:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1790812378; x=1822348378;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=RWxDyfGMUl3KRgPpXJniOLuW8bXGkSVonucISv1Av7w=;
 b=dMEGT484MO7htVHmNOJh0ahq8eVfwjPzOmijh/QrC+8MMGg8yBGJmvNR
 VWiax5/YX7yyctMtTe5LuCv2fvuTYeo04SymNigt5V88xKwvc7Z1Sdkw+
 QTMfJ/f+B/1uaJnTUBPecPcCN2iHANm4wXnXqexJoPjuuDzL/qoVQMgB+
 ovQhpeoKJNr5gWdysyFRFukjU8NNGLrVIQt7QRFgf2tG6hrquuehzrZT3
 WtFeaFWUfAEFxwu/xYt73i66jydXX1uSdMzwy0ICJHhpUQ66LLf80ZRIt
 DZwTIuL0Wet73yWlai8nwI9KvWHOd5VS/3RUEm7qZ/XcRTFxZgD/mkXVS Q==;
X-CSE-ConnectionGUID: HudtFXmGRGamGV3ReBufOw==
X-CSE-MsgGUID: 2yWFAcCeSFaHFfDkIplchw==
X-IronPort-AV: E=Sophos;i="6.27,133,1786982400"; d="scan'208";a="152761591"
Received: from mail-southcentralusazon11012012.outbound.protection.outlook.com
 (HELO SN4PR2101CU001.outbound.protection.outlook.com) ([40.93.195.12])
 by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 01 Oct 2026 07:52:51 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z8TvfliLO0uDlq/zVKRIMBJpf94aToT6EB/oFZtI//X+GExr9JAkKBZ9JoZzOnYNAPdnULcX5DxDT51ENTiSchwLIsBR49G6IET8UVd7VzjyGUOSzVVtkY7Ndaqqr2Lf65TRU/oqw9DufN7cVk923+Ksb8xDB5DFb/whX7JSW1VBoqimiSxtpC7wKba+R7+inAqO4kOMiZcJzpLpw4jziWZGMuIloLTP5wD6G4dYSXrD+m3bdoJGY99WBlXXlv3jrPMqpCkQL754A4jXA8dYzghRabva26WGG7p/OECcksKWorgltHV9unyAlqJ3OxHF6HkO4nCN4mE+6iWKoMfAVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RWxDyfGMUl3KRgPpXJniOLuW8bXGkSVonucISv1Av7w=;
 b=ENHk/kPCdlM9/GkEfiEo/ZqAhh9aNoVmVXBKe8f2k+xIbClUZ16F6w14NyYaQp3HHNYhZ2SGMyN//VOLCNLz5iDYXsGJklivTCuSWwkJaIRizyWu65INthtqGhZpSpunBDrG0SixQYe0G4163kOKnXINWh6l22PdweaaypYAB6ehcYKP8Z1DPfrwQy4kFCMm2EZsaJXYbIFzMspOEi3HP7zq1bCwd4E4R0BQYX0qwmS54vXOO6GD6tvRyImiv58Vy2rp+2moj9OK7MU35HG0HgNYc3Ue/numF0WTr+xDYQ8ZxwCY4JC2lXNKv0bgfiBJytKxOZsrFtUwCS8fXRtekw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RWxDyfGMUl3KRgPpXJniOLuW8bXGkSVonucISv1Av7w=;
 b=BWjIkGf4MPsTz9TQiRU1TK9s2fEw7apumIHO/1aIE2zCofe2e8KPA+lXq5VJn/eSPxtAzUmvh35c5cU52daYj4ai6uyGqegIb68dlEGlp3P78FsdwAM4F0UhO7vLncfsqBu0F/PIkq4ZM69lEfbCId2IEZvJLEN4MMqTFTdV10c=
Received: from BY1PR04MB9561.namprd04.prod.outlook.com (2603:10b6:a03:5b6::11)
 by BL0PR04MB6564.namprd04.prod.outlook.com (2603:10b6:208:17d::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.15; Wed, 30 Sep
 2026 23:52:49 +0000
Received: from BY1PR04MB9561.namprd04.prod.outlook.com
 ([fe80::3869:e494:2fa8:9888]) by BY1PR04MB9561.namprd04.prod.outlook.com
 ([fe80::3869:e494:2fa8:9888%6]) with mapi id 15.21.0451.026; Wed, 30 Sep 2026
 23:52:48 +0000
From: Alistair Francis <Alistair.Francis@wdc.com>
To: "portias@oss.tenstorrent.com" <portias@oss.tenstorrent.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "joel@jms.id.au" <joel@jms.id.au>, "npiggin@gmail.com"
 <npiggin@gmail.com>, "mpe@kernel.org" <mpe@kernel.org>,
 "marcandre.lureau@redhat.com" <marcandre.lureau@redhat.com>,
 "daniel.barboza@oss.qualcomm.com" <daniel.barboza@oss.qualcomm.com>,
 "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "palmer@dabbelt.com"
 <palmer@dabbelt.com>, "chao.liu@processmission.com"
 <chao.liu@processmission.com>, "asrinivasan@oss.tenstorrent.com"
 <asrinivasan@oss.tenstorrent.com>, "zhiwei_liu@linux.alibaba.com"
 <zhiwei_liu@linux.alibaba.com>, "liwei1518@gmail.com" <liwei1518@gmail.com>,
 "pierrick.bouvier@oss.qualcomm.com" <pierrick.bouvier@oss.qualcomm.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>
Subject: Re: [PATCH 1/5] hw/char/dw8250: Fix leak when creating child device
Thread-Topic: [PATCH 1/5] hw/char/dw8250: Fix leak when creating child device
Thread-Index: AQHdT8D/GPf9WDWcgU6okvflWIweyrbnzhSA
Date: Wed, 30 Sep 2026 23:52:48 +0000
Message-ID: <072840f1db0162a7468f86509ff3cb0723a237f4.camel@wdc.com>
References: <20260929031644.1016354-1-portias@oss.tenstorrent.com>
 <20260929031644.1016354-2-portias@oss.tenstorrent.com>
In-Reply-To: <20260929031644.1016354-2-portias@oss.tenstorrent.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.62.0 (by Flathub.org) 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY1PR04MB9561:EE_|BL0PR04MB6564:EE_
x-ms-office365-filtering-correlation-id: 99195b77-09c6-43ea-0af6-08df1f4deeb2
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|10070799003|7416014|366016|19092799006|23010399003|1800799024|22082099003|18002099003|38070700021|4143699003|10067099003|56012099006|11063799006;
x-microsoft-antispam-message-info: 0Ja74xc4eklN1dzBzaMMbXLCSZDi9V/vVog9lK5cCSXNqsjYj4oL58zbK8a5yES3yOhRkgBJ+Rh3ejb0p2ZiD3RNVqDVTUsZvR+P14djN5Htws75uRGtqvhf2+2LgmD3DMGE6B697jd2YWwpPQC6AFlRB0BmCgL5ysuDfeNEafAxOR12OLbgMYATHgRq8pBWItF9ROSnuYZTBC/piXo3JwcStbAkCiXKSVeCXvN9KeqdhFJYIM5KdS2/lsPJ/ilQwdoheqwHbBy8zEPOgWrsFA8M/RExNMOx7uQ64S7w29fSpv+Uh/kbUFrS3/ounmFDVe8X32L7PZltHKm/zG71TIaocI+wOGDOj/hZtQXcpJ8Ekvw4v0XcaApEy1OsUDeNmuLYSR6u1RE6TsPuuQQ4NbWrjZBvjIR8wQB/sWnhGotBB3JDzAB0bc1t/qBaEKL20zqAJKn3JcVe0HQ+YcGHoFi9Fu/kml3S7yfdJuMYx5lAB+ASXrAmnRn7DCGT9QdL08BbbN8as48HxVHtFklx73xzm1iMmoMc9MlhceqQGtgaDVqhIuKuBVzcW1tzbaYEmLgxbTFz6qiNPRcvrE5HCIuD2mdTduKS54gBgtBOohvvQYGiJAl0guqrePu9meki6d4nXXH08T5X8KVX+onzrsOo5DUCXEdLr9uzMvngKXOsgQ17dkbMMwaSqM7g2rY3CetcX80tx7BUK6CfPd+gp6E0UeJsTmw/0jCHLN5THqw=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY1PR04MB9561.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(10070799003)(7416014)(366016)(19092799006)(23010399003)(1800799024)(22082099003)(18002099003)(38070700021)(4143699003)(10067099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bU5uTERkN3dsa2ltdXc4S0JldEtQVjRzM0V3ZXdQTXJjUXF4UWdhdTd2V3Ny?=
 =?utf-8?B?R3J5eXhyNHBURkViZkoySHZuSUVmZjlrOGFSZE9tQ3I5NExRcFk4eXpXMm1J?=
 =?utf-8?B?b3lKd1lKb0wzT3M1VmUxQlhkZDNkTmZtTHRHY3RUekl0MXJxQ04zSnZXVzd2?=
 =?utf-8?B?aTdzNE12L1lPWmJjOTR6U3VFOCtGV01vajJBN1JVRE5MM1ExWjIxZ0pFeXJm?=
 =?utf-8?B?WlFmNHVKcytGeTdqcWc5eWZyaE1BK2J6cWpsWDBuV3E2bTZZNWhCRFIxVk9F?=
 =?utf-8?B?bHlFdnJCMmtvUGErTXRySWJlWVpuNUJ4YTI2eGVsWHNuSXVNVFpydVcvTmd6?=
 =?utf-8?B?NUw3VUVQVFB1cW5uKzczalpEUFFwdDJpL1p6aFVDeXFpTTRHb0N3SWNHR0RG?=
 =?utf-8?B?ZDFBZ2JtMnRhRW05ZGMxNXdiMGFXMTJPc2YvbDVKZjBtdFk2QjJ0T3c3Wkox?=
 =?utf-8?B?YzZMZldrNDhGek9tM01GNGw5OFZmYkhmZTFSKzdrRHJNcFdJT05ROVJkMFhq?=
 =?utf-8?B?c2xrbzVTNWFmd3JtY1pTdEt1dUpVVmlpQUowbnB3eWNObmhweGdKdGV4M0Zu?=
 =?utf-8?B?Uk91eVlhNTJIQkVtZXFlMm1IVS9FeXpMbGNwZEt3SGptVmhZZmZoMWVtKzRs?=
 =?utf-8?B?MEhpSG4yOE1yczczWFpkUGFnYllkdVJSb205VnJjaExPYlRSYXAwQmlzckxZ?=
 =?utf-8?B?OFdqNTUrZXdta0hnMGU0YTVXZGt5enhOWmsvMVpXZ1BVZTdJK2ZIcXErYjJJ?=
 =?utf-8?B?NENRMTJzbXFDV1ZjWWRxOVNQYXYxanhvQ25kUnAwdkNVbS8rUHhCb0JVS3V2?=
 =?utf-8?B?a0RaODkxaWs3ODRVSFhHYUt2cE5yeU5Nd2huQ3hYK2JwK0R0M2NFMzZxeHFT?=
 =?utf-8?B?T1EvOW85VGFJNVEwUHFsOGtSSWFXODVqWE5wRTk1L1JpVVF2dHRkWDFkejFN?=
 =?utf-8?B?WEs5MVprcWYwQlJQZWQzWnpHQ0EzVnA3d0dGOHRrMHYwbWJob0c4OTRub3RO?=
 =?utf-8?B?QTFQRTcwdzZjNTBWeU4wUzJWUUFFTWYwak4rNm1uK1IwUTNYOTFGWW9BZGFO?=
 =?utf-8?B?NDJpNnVSOVN2WWI0YzVzaHVNRFpvc2tRQzlYNGowanIvSXhhdC96OWtNWitp?=
 =?utf-8?B?SUNNckt4SHRocGJTRVd3TTJDS05wYzI2YmtSR2c3VjFwRGhLWHJ5dmVhcUlK?=
 =?utf-8?B?YmV6VjIwNG03S3pKTXN5bXIxdTJZeFVFZ0NVc3VkSGsyeWJobWRlZ0VEeDVx?=
 =?utf-8?B?K0VVVkdubmtMZXFiRFFPVitBNUNSbkE5ZjJnd1V5RGlVbTJHWWVjcERTaHk4?=
 =?utf-8?B?Z2NZSW15T3B1ZnFXUVhSR3BVRlRIZ1IxNEZPYm1aV2JMcnlSaXdYOUNnOFJM?=
 =?utf-8?B?R0RGTGJvMVBrTHBmVVBVMEJqN1h2T3BQVEEwb1BGR0tQZ2htQ0h0UnlHb0lG?=
 =?utf-8?B?L2VPMUJyTUh3V0IvTnhDNTNzTVNFTWF4dXlBNitlbnVKaGFmSGhjK0ZMZWVZ?=
 =?utf-8?B?N1RlaEFpSncwUDBSZTlpdWZzaGhxazJRWGFsMm9ObjY1UDN2SnZhbDVxK2Ex?=
 =?utf-8?B?cTZaQmREdnBCdFhBbG8yN3ZycnpnVTl4S0xaMkg4ZVY2a09KekNwK2h6alVh?=
 =?utf-8?B?WUpvNGpENFZDYXllRy82eVk4NzFpclg3bzcvMFJuUkJSZjZMbUdmNXpQeTND?=
 =?utf-8?B?NGNHWlc2T09RU3FuYXF4OXh1US9uYTl3WlVHK3NDSVc1UGgxS1ZSc0lvVU1L?=
 =?utf-8?B?V3MzdFRGd2FGTjIrV1dqU2U0TVZlRTFlQk0reWhVWFA5MzgwVkIzMjl5THll?=
 =?utf-8?B?Q0JrRjlYZmtmMVBuWm1Od05FZklaNmhROHZMcHgrVXd4ZzkvZGRTYTg1Y2xF?=
 =?utf-8?B?RnhHNmR0LzNMbWF6QVhiR3BPYVJHaUUvbHg4ZjZ3cVRkZjVjUVNKbnNOVFRW?=
 =?utf-8?B?MUpReWR4bTE0VzBkMDlCRWIxL1hZMG1nUkNqSVRXY1pMTlNwOTJaRC9hTnJ1?=
 =?utf-8?B?RFhkS2c4ZFhLQWxFa1lMWm0zSnJXWVU0SDhEanpxbERxZGJ6TGFKUHluVnNL?=
 =?utf-8?B?dlFhbElySXZ5cXEyY2puQ0hHYXpIRWdtMkhVUmh4cGtkK2lMQm16K1JQWkgx?=
 =?utf-8?B?OXFzbUhoc3RrWDlTdVd0SDlzR2M0SDh1ZC9URnh4UXgzb2czdmNOWWtmbXNG?=
 =?utf-8?B?akk5UE83MERkMG5IdlM0NUV3QlprZDM0RVFwOEdaWWI4aVYxNEx2SjRxQWgv?=
 =?utf-8?B?R29pYWJZK3JpZjVoV2w1THJnOUtwTDFFNE5hYkwwVDU1NGFDTmJHK3kvbFM5?=
 =?utf-8?B?aStQeElIeHBhUTk0aFdid3JxUVl3V0M5YndVQW9WcTEyNUwydmVESWRlRXV4?=
 =?utf-8?Q?U+yYkCfKwdKPM4L8xV5Z/PkC9eMKy+7ci4ARKKSUwlaTI?=
x-ms-exchange-antispam-messagedata-1: EQEN2TEbApdF585qCp3fpwhUfXvbtiWb3DM=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E593C04DB2E04A49ABE5A3344F902CFE@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: DRKOJK11BYEOp0GFS1ZM3CyeXwbimAdV9NYczg3fCxNipxoIQcr6TGajosdMMK9FZLRo35CgJLDeDTm+vE/AD4WYvQqYPHlVESD1RzdVjgK8JLzcvVHc25jid7TJA/xZG14VxihnP0o0GqDkLP8e13G4ceQn8zuOQE8TCRuaWNDv0fRtYtCQQKMlJHCZEWKl7ExO2kMZI2Bl4ZoH5ZDHno27u60MHsXIUw3WAOQl9cKQkjDUxlptpA/MlkP6sFDVmy2YRs0tipA5f3u4wXeuTesO2u8SwN2CR8jzxoniVET7r339HU19j07JTgKZYZ+xAIXSpGrQzN7oV80BCjOFpg==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Vv6NoW0g0rYek6cbXmci6P29Sl4S4Y1IS091K8RY1c6MGIA5d/aefIdQ2ADvF9GWQzA0+j1cm0p/cSd171RqJWN3dDJ0+fNrPpc2k03SZZF8Wat8Wit+3buwntPtxgrdaIx1I4SiHu2SwyGukOY3cL7cF+QHfqgZj13avMtUgzfRh4Vwt2kTUiFfJTbpHPR7Psc24sCIGnQfmqgPScz+XTkEELVWx7N03rFssg8K3ctRjgtlwLO412EYDPUWRxY+UoIU20o4Ce527duX4Ie9NwJosfmLd8yrVLvmLPhDhaRRfspLXm7qt1AsBRZZOk5VVmofTTQbOxdfDCYypF98PWeOvS+uqkqS1peDWa6bkFpMgAsEbdHJkySMzPrIXn/biw0M25btSJb9X+1sYyhGaQaNlYy/tLtbyp9G+toVOmBQBYCfWClILOyBuoGl5bhbhoZ7lO46itDouF4IsHKYlFSZtg5uPlUcf1q8CHfRaP+1oYScUM/NB3AjZCZetb8QbvEOG5Cgu69xq0U69XBQJIsJ11GDd1o5qm5Myaq4OcL++HDHtW59zeKAzYJQplYRP4BK2I9pqLUZWfBWkMSjpZg/IG/6Jgf2i7WtSQCsf31zX4syU+oxHCl+Uiv+TayN
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY1PR04MB9561.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99195b77-09c6-43ea-0af6-08df1f4deeb2
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Sep 2026 23:52:48.7248 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: E/Pdv0AasDqbAMm9BvqWx9d21TSLTiZ5t4OKdaFWGzae76G2wFS5t8fikzVODdWeuftX+nKJM53xTIB06gEYiH+JGNdf5vtvAM+1MBUaoUc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR04MB6564
Received-SPF: pass client-ip=216.71.154.42;
 envelope-from=prvs=726c96411=Alistair.Francis@wdc.com;
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

T24gVHVlLCAyMDI2LTA5LTI5IGF0IDEzOjE2ICsxMDAwLCBwb3J0aWFzQG9zcy50ZW5zdG9ycmVu
dC5jb20gd3JvdGU6DQo+IEZyb206IFBvcnRpYSBTdGVwaGVucyA8cG9ydGlhc0Bvc3MudGVuc3Rv
cnJlbnQuY29tPg0KPiANCj4gZHc4MjUwX2luc3RhbmNlX2luaXQoKSBjcmVhdGVzIHR3byByZWZl
cmVuY2VzIGZvciBzZXJpYWxfbW0sIG9uZSBmcm9tDQo+IHFkZXZfbmV3KCkgYW5kIG9uZSBmcm9t
IG9iamVjdF9wcm9wZXJ0eV9hZGRfY2hpbGQoKSB3aGljaCBsZWFrcyB0aGUNCj4gc2VyaWFsX21t
IG9iamVjdC4gRml4IGVtYmVkZGluZyB0aGUgU2VyaWFsTU0gc3RydWN0IGluIHRoZQ0KPiBEVzgy
NTBTdGF0ZS4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IFBvcnRpYSBTdGVwaGVucyA8cG9ydGlhc0Bv
c3MudGVuc3RvcnJlbnQuY29tPg0KDQpUaGFua3MsIEkgc3F1YXNoZWQgdGhpcyBpbiB3aXRoIHRo
ZSBvcmlnaW5hbCBjb21taXQNCg0KQWxpc3RhaXINCg0KPiAtLS0NCj4gwqBody9jaGFyL2R3ODI1
MC5jwqDCoMKgwqDCoMKgwqDCoCB8IDExICsrKysrLS0tLS0tDQo+IMKgaW5jbHVkZS9ody9jaGFy
L2R3ODI1MC5oIHzCoCAzICsrLQ0KPiDCoDIgZmlsZXMgY2hhbmdlZCwgNyBpbnNlcnRpb25zKCsp
LCA3IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2h3L2NoYXIvZHc4MjUwLmMgYi9o
dy9jaGFyL2R3ODI1MC5jDQo+IGluZGV4IGNjZjA1ZGQ5YWQuLjUwYmFlYWU2MmMgMTAwNjQ0DQo+
IC0tLSBhL2h3L2NoYXIvZHc4MjUwLmMNCj4gKysrIGIvaHcvY2hhci9kdzgyNTAuYw0KPiBAQCAt
NzIsMjMgKzcyLDIyIEBAIHN0YXRpYyB2b2lkIGR3ODI1MF9pbnN0YW5jZV9pbml0KE9iamVjdCAq
b2JqKQ0KPiDCoHsNCj4gwqDCoMKgwqAgRFc4MjUwU3RhdGUgKnMgPSBEVzgyNTAob2JqKTsNCj4g
wqANCj4gLcKgwqDCoCBzLT5zZXJpYWxfbW0gPSBxZGV2X25ldygic2VyaWFsLW1tIik7DQo+IC3C
oMKgwqAgb2JqZWN0X3Byb3BlcnR5X2FkZF9jaGlsZChvYmosICJzZXJpYWwtbW0iLCBPQkpFQ1Qo
cy0NCj4gPnNlcmlhbF9tbSkpOw0KPiAtwqDCoMKgIG9iamVjdF9wcm9wZXJ0eV9hZGRfYWxpYXMo
b2JqLCAiY2hhcmRldiIsIE9CSkVDVChzLT5zZXJpYWxfbW0pLA0KPiAiY2hhcmRldiIpOw0KPiAr
wqDCoMKgIG9iamVjdF9pbml0aWFsaXplX2NoaWxkKG9iaiwgInNlcmlhbC1tbSIsICZzLT5zZXJp
YWxfbW0sDQo+IFRZUEVfU0VSSUFMX01NKTsNCj4gK8KgwqDCoCBvYmplY3RfcHJvcGVydHlfYWRk
X2FsaWFzKG9iaiwgImNoYXJkZXYiLCBPQkpFQ1QoJnMtPnNlcmlhbF9tbSksDQo+ICJjaGFyZGV2
Iik7DQo+IMKgfQ0KPiDCoA0KPiDCoHN0YXRpYyB2b2lkIGR3ODI1MF9yZWFsaXplKERldmljZVN0
YXRlICpkZXYsIEVycm9yICoqZXJycCkNCj4gwqB7DQo+IMKgwqDCoMKgIERXODI1MFN0YXRlICpz
ID0gRFc4MjUwKGRldik7DQo+IMKgwqDCoMKgIFN5c0J1c0RldmljZSAqc2JkID0gU1lTX0JVU19E
RVZJQ0UoZGV2KTsNCj4gLcKgwqDCoCBTeXNCdXNEZXZpY2UgKnNlcmlhbF9zYmQgPSBTWVNfQlVT
X0RFVklDRShzLT5zZXJpYWxfbW0pOw0KPiArwqDCoMKgIFN5c0J1c0RldmljZSAqc2VyaWFsX3Ni
ZCA9IFNZU19CVVNfREVWSUNFKCZzLT5zZXJpYWxfbW0pOw0KPiDCoA0KPiDCoMKgwqDCoCBtZW1v
cnlfcmVnaW9uX2luaXQoJnMtPmNvbnRhaW5lciwgT0JKRUNUKGRldiksICJkdzgyNTAtDQo+IGNv
bnRhaW5lciIsDQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgRFdfVUFSVF9SRUdJT05fU0laRSk7DQo+IMKgwqDCoMKgIHN5c2J1c19pbml0X21taW8oc2Jk
LCAmcy0+Y29udGFpbmVyKTsNCj4gwqANCj4gLcKgwqDCoCBxZGV2X3Byb3Bfc2V0X3VpbnQ4KHMt
PnNlcmlhbF9tbSwgInJlZ3NoaWZ0Iiwgcy0+cmVnc2hpZnQpOw0KPiAtwqDCoMKgIHFkZXZfcHJv
cF9zZXRfdWludDgocy0+c2VyaWFsX21tLCAiZW5kaWFubmVzcyIsDQo+IERFVklDRV9MSVRUTEVf
RU5ESUFOKTsNCj4gK8KgwqDCoCBxZGV2X3Byb3Bfc2V0X3VpbnQ4KERFVklDRSgmcy0+c2VyaWFs
X21tKSwgInJlZ3NoaWZ0Iiwgcy0NCj4gPnJlZ3NoaWZ0KTsNCj4gK8KgwqDCoCBxZGV2X3Byb3Bf
c2V0X3VpbnQ4KERFVklDRSgmcy0+c2VyaWFsX21tKSwgImVuZGlhbm5lc3MiLA0KPiBERVZJQ0Vf
TElUVExFX0VORElBTik7DQo+IMKgwqDCoMKgIGlmICghc3lzYnVzX3JlYWxpemUoc2VyaWFsX3Ni
ZCwgZXJycCkpIHsNCj4gwqDCoMKgwqDCoMKgwqDCoCByZXR1cm47DQo+IMKgwqDCoMKgIH0NCj4g
ZGlmZiAtLWdpdCBhL2luY2x1ZGUvaHcvY2hhci9kdzgyNTAuaCBiL2luY2x1ZGUvaHcvY2hhci9k
dzgyNTAuaA0KPiBpbmRleCA1OTM5NmFkMjAyLi5jZTBiOTc3MTViIDEwMDY0NA0KPiAtLS0gYS9p
bmNsdWRlL2h3L2NoYXIvZHc4MjUwLmgNCj4gKysrIGIvaW5jbHVkZS9ody9jaGFyL2R3ODI1MC5o
DQo+IEBAIC0xMCw2ICsxMCw3IEBADQo+IMKgDQo+IMKgI2luY2x1ZGUgImh3L2NvcmUvc3lzYnVz
LmgiDQo+IMKgI2luY2x1ZGUgInFvbS9vYmplY3QuaCINCj4gKyNpbmNsdWRlICJody9jaGFyL3Nl
cmlhbC1tbS5oIg0KPiDCoA0KPiDCoCNkZWZpbmUgVFlQRV9EVzgyNTAgImR3ODI1MCINCj4gwqBP
QkpFQ1RfREVDTEFSRV9TSU1QTEVfVFlQRShEVzgyNTBTdGF0ZSwgRFc4MjUwKQ0KPiBAQCAtMTks
NyArMjAsNyBAQCBzdHJ1Y3QgRFc4MjUwU3RhdGUgew0KPiDCoA0KPiDCoMKgwqDCoCBNZW1vcnlS
ZWdpb24gY29udGFpbmVyOw0KPiDCoMKgwqDCoCBNZW1vcnlSZWdpb24gZXh0X2lvbWVtOw0KPiAt
wqDCoMKgIERldmljZVN0YXRlICpzZXJpYWxfbW07DQo+ICvCoMKgwqAgU2VyaWFsTU0gc2VyaWFs
X21tOw0KPiDCoA0KPiDCoMKgwqDCoCB1aW50OF90IHJlZ3NoaWZ0Ow0KPiDCoH07DQo=

