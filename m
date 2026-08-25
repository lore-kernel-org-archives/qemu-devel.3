Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2D72C5DF81
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 04:06:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyiPt-0006Rx-DR; Tue, 25 Aug 2026 00:05:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=690dc056c=Alistair.Francis@wdc.com>)
 id 1wyiPs-0006RH-Kz; Tue, 25 Aug 2026 00:05:40 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=690dc056c=Alistair.Francis@wdc.com>)
 id 1wyiPq-0007ee-Gb; Tue, 25 Aug 2026 00:05:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1787630738; x=1819166738;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=WNenSRISv0kWURIsbtSIh41Xz6ciBxcnxm1EvWV/tE4=;
 b=CN0kz/mlUNpHFBfhDiDuFZ7H4jeFd41yu+OyjD9RilKGsQN8SZ3nDMt8
 pt88fkohE3Xv5EopGEbyZhdDSvyXGL74B7o7Ia9DZXwayruZZPMB5vsLH
 odvfWvxt7bdkvMC7k//0CA60CuXEhcWhSvC2n7RJgK0DFriPULATJAwtL
 OZvmZnFjOQ+c19902e+bjj3hgdzTneT2n0wl7VJmSr6RY2dVg7RokUmAF
 lLmMs8x8zawECBDatFSBeub6tta6zg9P8Egj6No7pJ0YF4dU6qImpQYRg
 PfylGbrGWDCo4WmMB/XO/tWyXSD6NjEYIVjizSyxQLaab/qQyCdrXVs1r g==;
X-CSE-ConnectionGUID: I3Rj/B0+RDSzbbQjkKR36Q==
X-CSE-MsgGUID: ItbvdzXOQtGNS6K6GEGifg==
X-IronPort-AV: E=Sophos;i="6.25,241,1779120000"; d="scan'208";a="150004085"
Received: from mail-eastusazon11012040.outbound.protection.outlook.com (HELO
 BL0PR03CU003.outbound.protection.outlook.com) ([52.101.53.40])
 by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 25 Aug 2026 12:05:35 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rvUT4tqsnMa1Xcylud8YQrWHxbEO/TqkWV91a5BO8iHWPIH5XNnjfwNcSF8LUn2sE2/y9MQNwZmHOQwcSCZCzw3CcrAHRjhd/bBqPpjBqmjCnzl4mssdwrOEenctEnZqLKyzGWcij8L41xk+PoCAMvurN0thxLBSo0wnW4OIG6dm8OAywexW11s4PtXkwGKgF0zIqFkdHrrppdSU0rEeKUGlkJPk0oKsXLsQZokIKadpOLCERoy94NXlwD++d6OSKTA6mGHyjJvL+0a7RTlbu3ubuDoefJ3viW7sqJFU7dUuxhULZkoHKNYfmUrKvm+ia+GWPkAiSz/QhyM7I+jWEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WNenSRISv0kWURIsbtSIh41Xz6ciBxcnxm1EvWV/tE4=;
 b=bD1OAcA0Dp+oAmnuRDvhhixOqWFzA7MEJTFWWvmqkGC6ZGNM9XTdqaRCaXLLkZCTiRwPmHJE0lY9+EHsNAc60HvH6RiqL6Axt8dh07oMnUaS86rpzb6+Ej+e34oBOS9JvkZMU3LAjl8aexqkov2vrexSFEaPJhWBtTxGrCVU64pU78XiuFLeKjBph1ypOGtmtUznBcu3VwWJ8eDTkClq4A9iFl37xUS1yA8FkcjpKfuSyixoBoJMPMggB2NmsGuw/kasc3JCQaVlk9r6fLECt9a0jMy3YZY0o3UZ+hUrikijiR6LtNn0E5E6gMqJU2rTC4zj/L2vv7OMeJwvhe7EVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WNenSRISv0kWURIsbtSIh41Xz6ciBxcnxm1EvWV/tE4=;
 b=XzqE0naYkSsq9E3VZ2laBMaFdCz3Gb6ndoF1rnyBuICmemnGl2qkbEVjgfzIA4JujwphBvA3GGRgqk1RmA03svk7Z7EnNIvciJXqnhGAsTMp1kuxlEnKFYB2VfCJZwCpNPick+10VOOdurna1jM95JBISflOfnLsJOfnZB3qeFI=
Received: from BY1PR04MB9561.namprd04.prod.outlook.com (2603:10b6:a03:5b6::11)
 by LV0PR04MB9859.namprd04.prod.outlook.com (2603:10b6:408:32a::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Tue, 25 Aug
 2026 04:05:32 +0000
Received: from BY1PR04MB9561.namprd04.prod.outlook.com
 ([fe80::3869:e494:2fa8:9888]) by BY1PR04MB9561.namprd04.prod.outlook.com
 ([fe80::3869:e494:2fa8:9888%5]) with mapi id 15.21.0360.005; Tue, 25 Aug 2026
 04:05:32 +0000
From: Alistair Francis <Alistair.Francis@wdc.com>
To: "daniel.barboza@oss.qualcomm.com" <daniel.barboza@oss.qualcomm.com>,
 "joel@jms.id.au" <joel@jms.id.au>, "philmd@linaro.org" <philmd@linaro.org>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "npiggin@gmail.com"
 <npiggin@gmail.com>, "mpe@kernel.org" <mpe@kernel.org>,
 "portias@oss.tenstorrent.com" <portias@oss.tenstorrent.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "peter.maydell@linaro.org"
 <peter.maydell@linaro.org>, "chao.liu@processmission.com"
 <chao.liu@processmission.com>, "zhiwei_liu@linux.alibaba.com"
 <zhiwei_liu@linux.alibaba.com>, "asrinivasan@oss.tenstorrent.com"
 <asrinivasan@oss.tenstorrent.com>, "liwei1518@gmail.com"
 <liwei1518@gmail.com>, "nieklinnenbank@gmail.com" <nieklinnenbank@gmail.com>
Subject: Re: [PATCH 1/4] hw/riscv/boot: Make RISCVBootInfo const where possible
Thread-Topic: [PATCH 1/4] hw/riscv/boot: Make RISCVBootInfo const where
 possible
Thread-Index: AQHdM41qstgPVicGjk2lZYxm1iNolLauJtWA
Date: Tue, 25 Aug 2026 04:05:31 +0000
Message-ID: <e4f114755bf752c15a06975871030cfb4e0a325b.camel@wdc.com>
References: <20260824055642.41098-1-joel@jms.id.au>
 <20260824055642.41098-2-joel@jms.id.au>
In-Reply-To: <20260824055642.41098-2-joel@jms.id.au>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.60.2 (by Flathub.org) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY1PR04MB9561:EE_|LV0PR04MB9859:EE_
x-ms-office365-filtering-correlation-id: 7f9f2fa7-f9e5-4ef5-a46a-08df025e1b73
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|19092799006|376014|10070799003|7416014|23010399003|4143699003|22082099003|18002099003|11063799006|56012099006|38070700021|6133799003|10067099003;
x-microsoft-antispam-message-info: iMami1baMOkW3tQqLe+pbrNPiX16ZVYJINXHxzchEuoK00QzG4ix8E5fwbyt+9AE+5nwQR+rmt9LW7661lA/ik71UhwdGw2PR3/h48KN5jmUjVnnojpZm/26cJJC1VMXfyTMkVUjqAnOwctGjAM5UYR2J5B0he8Bmql5mPFq77DRwNTjb8qy8nLxViW7fY46nKh7V7agJzz9Kp4BoD+3hvJ0nQfsW8RaCPdBxS1tLwTSH+j3oIs+wMmMa0bN/AW/ukr2cm8f3DBapMMKSCf+X+acYObHQYT/1pIr8oPn8fbgtNlB/s5+tpHK+38JIuuAlhwOWl+hTDKzMnqGcEXB18uG9CffHdCq9nLCv5ZRcpkzLmJeuiHSvVX1yuOPU6OKFNBSnvddWXgCAfXLZF2Myy7VkJrPlJXQywqjn/PiroN3QmT+y9rI4NgJl6Ki9/CvwnBganJvSNJKfhsgIZKC2dHpSRV2hlPilAn1389c9TVh3GenLn5cGCrcNTC9uqrzSutlM4Je0HlYh4bTI18vXg8rxl17lkrCmVPDdJH8s11d+DoubYsSRJbXOSQWYDwgE9100bBiLYaX/z/rSQ1XB7sH8NIwguJby4TnkzqXE8ioM5FoiyBhNjuTqvZgVLxmQ5Nz9Z+wqdJBAFusRSM75quJkkGe0u0QbO1LwnzK18Pi5Pj2Uy7QqmfwFiGAVHyITC1RVhuV+2RdycwTP4A8Wv/ZjwQt560O5wZCYcHOMGg=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY1PR04MB9561.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(19092799006)(376014)(10070799003)(7416014)(23010399003)(4143699003)(22082099003)(18002099003)(11063799006)(56012099006)(38070700021)(6133799003)(10067099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?b08wSUNMWW12U21TcFAxUFFjNGQ0TmszTXVTSHZOczR6dHNWMmx0Q0grbVJ2?=
 =?utf-8?B?QlRzOXY5UmV4TVo2OGtkNXZpMmxZRGZwQ3l0R3RuSENPWkZVV29hK1UwVFJp?=
 =?utf-8?B?azhsYWJZVDZ3Rmtqb1U4NkRLNkR0MnZVWWxzRGVwbVo3MjUvVEozbmJVTTNs?=
 =?utf-8?B?VW9Iakd0NWVnb3pReDY4dG9PbVRSdnMvYy9oNm51a3doU2tkc3BmbWpwckNK?=
 =?utf-8?B?TmRqT0dETEFSRDl6WWExVkNtaVR1RjlRVzcxbDdqWnBlUjZnTnJLZ2lDTmNw?=
 =?utf-8?B?VzdKL2FmWWtjYjRlQVB4SEJLaUdCRFpueGVuWkRsNFhHbmJ0TFFycVl6Mjdp?=
 =?utf-8?B?UlpzVE1zdHdnOHJzVkVuZVdTMmt2a01STndSN0F4MkJ5TFpWc3RaMEp2WS9O?=
 =?utf-8?B?blF1VDFNa2xaUm1QeFg2MCsrcGJxNElWTnNyVTM0ZDBMM1dUTzZtODZkdVl3?=
 =?utf-8?B?WkdzNTlTMFBlZkNLNVpGOUlDTHVoYVUxczJsQnRSRzEzV1FxT0U1YVUyNkpw?=
 =?utf-8?B?THcyTVcxNGlaeWRFNExDV1RWTmJROGJuTE9DLys4VXlsWEVJVnRQS2xPNGxu?=
 =?utf-8?B?M1Rja1hNVWI4NmF4ZlFtTmw1K0h6cWFKcC9NZXczVC9VazJuQUIwOW44ZDhz?=
 =?utf-8?B?S2ZidDFJOTV1MXdzQ1VuVnI5TEtWekxlNmE5alRITk5hcUdOanRGKzdNQy9T?=
 =?utf-8?B?bVZnSFdSOTRlYUQwME8vK01Ed3NwSWtjcE9ET3RTRjBjT1BoR2grWkZicDR4?=
 =?utf-8?B?L0M1d09jdlpIamVkRFo3clZMOHJOY0lJejliTVI3eHV1a21EMndSdVZNd2x6?=
 =?utf-8?B?UVAwWmZuR0xWZmpZUEkwVHhJZXd4ZTFyY1p3TFFJa2hoM0dBWE5rdGVPejUy?=
 =?utf-8?B?a2pPSzdudlUrbEg0M0NuOURwUFRaNTVPZVk3WUE1OGQwbDBZbmd0SjVZNWZn?=
 =?utf-8?B?c0w3RGdxZE1wVGF5VGpoY0NDTG1Ka1YwZEVLMCtWanNORjJOR2xOMmJ6SU80?=
 =?utf-8?B?WURVZGt1Z0dUbUJodnJFQ1lhTzhzbklTWUl1VmcyWjhocitaOG9VczdQWlBY?=
 =?utf-8?B?Z3A0M25pdGJ3dnFxTEoyVmxkVjBLYUVqQ1pNczgzV1B2QmRyME1VWE1EckhY?=
 =?utf-8?B?b1BIcHloWDZUSEtZY3VxZnZNZ0NmMG43ek1PTGZGZ29rY1F1NXk3Z3h0Q1pZ?=
 =?utf-8?B?Vk9PcFBEZmQrbmtHcDJXR3FqckRsZUZJcGpnNWR6bGJXSlgva2JYK1ZyWWIz?=
 =?utf-8?B?ejQ3aHlrRXdDbU1HN0p5OUx3RGhBSlR0a2xtbll3T1JDTWJOQTRYN3BWbkNz?=
 =?utf-8?B?TXU1dkZWSXc0aXZ6Ym45SWluMGVSa1hvNkhpd0pkSGFxdWdhNzBMMEpvL3Fm?=
 =?utf-8?B?ci9tTnVwNGlmUFYzd2V4M1NTN0FaQWV0ZzB6d1FBUTFkUWJvaFN2K2NreCth?=
 =?utf-8?B?ZmlVSzZUK01rZllIbmN6VnB1YzJ3UFN5VzBNc25ScitVb05JK1pjM05tTDMy?=
 =?utf-8?B?TmsvcnpjNWxFelVrSkhrUjRoV1MzMVRHNi9lYUZDVmUxTEdYSDdqV0pkMzFR?=
 =?utf-8?B?b05kSVpYT3ZsQVB2WkIzZ24ybXJ5b0F4TEoyQUFhYlBpb2F6MUtEV0lpZVhk?=
 =?utf-8?B?YXhoeEFaNHdpZjd3NDMzQndjZmEybGxJRmdSNGdEd25EV0E5SExCOEk0dmE5?=
 =?utf-8?B?clFFSFp0T3BuOHJyWlN3dmt2Q2MzMy9Pa3hXMFBPNU1XU3hSMFF2NE1tM0lz?=
 =?utf-8?B?Yy9mNW1HWEZWOE8ycnRGNmhobktqbEhiWlNNV2F5QjJKUnVSR1c3WW5pS3Jq?=
 =?utf-8?B?T0xiQVFMSk9yZGNtb0ljUzJ3bU5RUG80STJXazZoNmY1M0xOYjcwRDFjVlVL?=
 =?utf-8?B?Sk1vZW9HeXZDbnl2a2k2K1NMdUhjL2U1S3lQM3VmUUdFQjJ3a1gwV2NzbzMr?=
 =?utf-8?B?aGNRbkVCa3pzQ0FWQWFkS0M2UkxMOFBlTEJFdW82a0J0NCtSaFVtaWdBY2xL?=
 =?utf-8?B?SGlWMzhUcC91NkFWN3R3OW5FU1NZY0RscHhSaVBVa3Y2ZEJvVkw2TzlKR1pE?=
 =?utf-8?B?WWtYNFN2V2NtNDB6cHp3UFVBcW9sYUtrTEM3d0MzQmZKS1FHblNqeGo1cith?=
 =?utf-8?B?Um5pQmdBTjQwdWk5cVJLQXNlSDQzakhBVjlCYVBXMGVUV3Z1SlkvK1dxSTZh?=
 =?utf-8?B?S0hpSTlmRmVvMHJqYURKWEhmWnZqVXdZKzkrUVc1L0J5RnBrdWtOUTNNRHRt?=
 =?utf-8?B?aVc3SzBqYVIzMGJYRzFZMnZUdzllMGRPRnNsMUtaZXFLRVBWb2hWY25mVVVM?=
 =?utf-8?B?ejA5NXlBcExXVjlxNXA2YjNjakZTS3RtUnpLeUVYUThzTUcxazJhVFlnaFVz?=
 =?utf-8?Q?ZSOIlSCmXJLMzGe1eaNcDq7ggGtZyHnyD/pxo0jvpeJvx?=
x-ms-exchange-antispam-messagedata-1: m1BCo2/ksLFM+jOcXKXpDok5bHqF3vjeym8=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CAAE80B4F401B44E9D55EADF6E6E8357@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: lshUAt2x9ORxJuahjeyks16/kQyL4pD2/pcy48+FDKO+l6Ug0OMK3K7i46PZoJoqipEFtvGEbxBpf568o66YydroYMPLCQ20irkYNApk+UjnVsEAP0VbBd2Oc5MNc4eSewTuGPu2jzYECwQ/Uny9dYHnOHKyOJC3xvjDlITn14p4/gE0UXy24zgalrDUYVysUpZetQLmKgOkOSiVXODk181WYl2UsnwS4K4EOZqaBZak08Qkt6d04v//YUwGXHQSII2/FVTC3Tc7XG0k+wJ00H2KElPtpwJzz6CRjZ7hbC973rORJkXOmo7Yl/Nl15RLCxvU3W1vXn9iburhfg2gCQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: CQUTwoG+w9NAMMS4AwzsEhykqy7yYgF7pK1sqrghX3Ovs8TNb4zxQEXSup5AVfFvqnMX+sEEgLZnWxdeVf/EdiFuGsNSkrMawcxeyufqzTZsbDwCiS/wedwMeRvjctVH2XFJ7ioTq5jw6fuwYsgfp2qV9MO4PVAEFpYkJT30+vchNJsQERvQY38arEDGHHEL1em/0NzL7oNhop6BOlNuJ7Jy25lPvAlc+l10y87Co/8r2Mj4+cU5ocX0UVlB2EwUWrBk/63K5J2okfUisJaOx+0WNEBdZCzr8M2KwNTj8gJVlz54VDmht5wkU3Y1tThOEWJXjVjphIsl3anCSs80ciyWIkbxz6Jh+Py3WL3PKnNZ3rm+ifkAjr8fZH2SYLYRBdFWKDiDWYv+DcC1jG3JcIqSiPCWoHB6srvdnN1zBrb8/2qV4xFps2suBLUQG6dml/zdnUgjd26Pme3COFHSQjE8Z7VHWjeTlLLNR6MEclBN6FYOGR6KXbbXUyTrMByJeUcJkP/q882Vn+v6YXH5eMOEr+pw3gpWHSKLo3hxNQXkv3Hhf2SS94H3Z/sD6X3DumuxhgnreLkZgGtnsIhHYTrwlcZrZZEHVKtsJCZdriUxj5mzUuscnCJOM28iXOMR
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY1PR04MB9561.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f9f2fa7-f9e5-4ef5-a46a-08df025e1b73
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Aug 2026 04:05:32.0343 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: L1ydnLKuLW3ivcXuUDzCTagJQm/1N4tEbwXa6VsqL9J9K6uX5Pm6yTXWhoxwrj+2hQZ3l3ha6MeqLYJPLeG9eygL5Ng4f+SbmfzQ6Yt1Tks=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV0PR04MB9859
Received-SPF: pass client-ip=216.71.154.42;
 envelope-from=prvs=690dc056c=Alistair.Francis@wdc.com;
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

T24gTW9uLCAyMDI2LTA4LTI0IGF0IDE1OjI2ICswOTMwLCBKb2VsIFN0YW5sZXkgd3JvdGU6Cj4g
QXMgd2l0aCByaXNjdl9sb2FkX2Zpcm13YXJlLCB0YWtlIGEgY29uc3QgcG9pbnRlciBpbiBmdW5j
dGlvbnMgdGhhdAo+IHJlYWRzIHRoZSBzdHJ1Y3R1cmUgd2l0aG91dCB3cml0aW5nLgo+IAo+IFN1
Z2dlc3RlZC1ieTogUGhpbGlwcGUgTWF0aGlldS1EYXVkw6kgPHBoaWxtZEBsaW5hcm8ub3JnPgo+
IFNpZ25lZC1vZmYtYnk6IEpvZWwgU3RhbmxleSA8am9lbEBqbXMuaWQuYXU+CgpSZXZpZXdlZC1i
eTogQWxpc3RhaXIgRnJhbmNpcyA8YWxpc3RhaXIuZnJhbmNpc0B3ZGMuY29tPgoKQWxpc3RhaXIK
Cj4gLS0tCj4gwqBpbmNsdWRlL2h3L3Jpc2N2L2Jvb3QuaCB8IDYgKysrLS0tCj4gwqBody9yaXNj
di9ib290LmPCoMKgwqDCoMKgwqDCoMKgIHwgNiArKystLS0KPiDCoDIgZmlsZXMgY2hhbmdlZCwg
NiBpbnNlcnRpb25zKCspLCA2IGRlbGV0aW9ucygtKQo+IAo+IGRpZmYgLS1naXQgYS9pbmNsdWRl
L2h3L3Jpc2N2L2Jvb3QuaCBiL2luY2x1ZGUvaHcvcmlzY3YvYm9vdC5oCj4gaW5kZXggNGU3YmQ5
YTIyNWVmLi5kMjNmNDVkNzgwNzcgMTAwNjQ0Cj4gLS0tIGEvaW5jbHVkZS9ody9yaXNjdi9ib290
LmgKPiArKysgYi9pbmNsdWRlL2h3L3Jpc2N2L2Jvb3QuaAo+IEBAIC01MCwxMCArNTAsMTAgQEAg
dm9pZCByaXNjdl9ib290X2luZm9faW5pdChSSVNDVkJvb3RJbmZvICppbmZvLAo+IFJJU0NWSGFy
dEFycmF5U3RhdGUgKmhhcnRzKTsKPiDCoHZvaWQgcmlzY3ZfYm9vdF9pbmZvX2luaXRfZGlzY29u
dGlnX21lbShSSVNDVkJvb3RJbmZvICppbmZvLAo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIFJJ
U0NWSGFydEFycmF5U3RhdGUgKmhhcnRzLAo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGh3YWRk
ciBsb3dfc3RhcnQsIGh3YWRkcgo+IGxvd19zaXplKTsKPiAtdmFkZHIgcmlzY3ZfY2FsY19rZXJu
ZWxfc3RhcnRfYWRkcihSSVNDVkJvb3RJbmZvICppbmZvLAo+ICt2YWRkciByaXNjdl9jYWxjX2tl
cm5lbF9zdGFydF9hZGRyKGNvbnN0IFJJU0NWQm9vdEluZm8gKmluZm8sCj4gwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCBod2FkZHIgZmlybXdhcmVfZW5kX2FkZHIpOwo+IMKgaHdhZGRyIHJpc2N2X2ZpbmRfYW5kX2xv
YWRfZmlybXdhcmUoTWFjaGluZVN0YXRlICptYWNoaW5lLAo+IC3CoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIFJJU0NW
Qm9vdEluZm8gKmluZm8sCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgY29uc3QgUklTQ1ZCb290SW5mbyAqaW5m
bywKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgY29uc3QgY2hhcgo+ICpkZWZhdWx0X21hY2hpbmVfZmlybXdh
cmUsCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIGh3YWRkciAqZmlybXdhcmVfbG9hZF9hZGRyLAo+IMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCBzeW1ib2xfZm5fdCBzeW1fY2IpOwo+IEBAIC03MSw3ICs3MSw3IEBAIHZvaWQg
cmlzY3ZfbG9hZF9rZXJuZWwoTWFjaGluZVN0YXRlICptYWNoaW5lLAo+IMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgYm9vbCBsb2FkX2luaXRyZCwKPiDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHN5bWJvbF9mbl90IHN5
bV9jYik7Cj4gwqB1aW50NjRfdCByaXNjdl9jb21wdXRlX2ZkdF9hZGRyKGh3YWRkciBkcmFtX2Jh
c2UsIGh3YWRkciBkcmFtX3NpemUsCj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIE1hY2hpbmVTdGF0ZSAqbXMsIFJJU0NWQm9v
dEluZm8KPiAqaW5mbyk7Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIE1hY2hpbmVTdGF0ZSAqbXMsIGNvbnN0Cj4gUklTQ1ZC
b290SW5mbyAqaW5mbyk7Cj4gwqB2b2lkIHJpc2N2X2xvYWRfZmR0KGh3YWRkciBmZHRfYWRkciwg
dm9pZCAqZmR0KTsKPiDCoHZvaWQgcmlzY3Zfc2V0dXBfcm9tX3Jlc2V0X3ZlYyhNYWNoaW5lU3Rh
dGUgKm1hY2hpbmUsCj4gUklTQ1ZIYXJ0QXJyYXlTdGF0ZSAqaGFydHMsCj4gwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaHdhZGRy
IHNhZGRyLAo+IGRpZmYgLS1naXQgYS9ody9yaXNjdi9ib290LmMgYi9ody9yaXNjdi9ib290LmMK
PiBpbmRleCA1ZTJkZmEwOTFhMTMuLjRhYzBiOGVmNjU4MSAxMDA2NDQKPiAtLS0gYS9ody9yaXNj
di9ib290LmMKPiArKysgYi9ody9yaXNjdi9ib290LmMKPiBAQCAtOTEsNyArOTEsNyBAQCB2b2lk
Cj4gcmlzY3ZfYm9vdF9pbmZvX2luaXRfZGlzY29udGlnX21lbShSSVNDVkJvb3RJbmZvICppbmZv
LAo+IMKgwqDCoMKgIGluZm8tPnJhbV9sb3dfc2l6ZSA9IGxvd19zaXplOwo+IMKgfQo+IMKgCj4g
LXZhZGRyIHJpc2N2X2NhbGNfa2VybmVsX3N0YXJ0X2FkZHIoUklTQ1ZCb290SW5mbyAqaW5mbywK
PiArdmFkZHIgcmlzY3ZfY2FsY19rZXJuZWxfc3RhcnRfYWRkcihjb25zdCBSSVNDVkJvb3RJbmZv
ICppbmZvLAo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaHdhZGRyIGZpcm13YXJlX2VuZF9hZGRyKSB7Cj4gwqDC
oMKgwqAgaWYgKGluZm8tPmlzXzMyYml0KSB7Cj4gwqDCoMKgwqDCoMKgwqDCoCByZXR1cm4gUUVN
VV9BTElHTl9VUChmaXJtd2FyZV9lbmRfYWRkciwgNCAqIE1pQik7Cj4gQEAgLTE1MSw3ICsxNTEs
NyBAQCBjaGFyICpyaXNjdl9maW5kX2Zpcm13YXJlKGNvbnN0IGNoYXIKPiAqZmlybXdhcmVfZmls
ZW5hbWUsCj4gwqB9Cj4gwqAKPiDCoGh3YWRkciByaXNjdl9maW5kX2FuZF9sb2FkX2Zpcm13YXJl
KE1hY2hpbmVTdGF0ZSAqbWFjaGluZSwKPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBSSVNDVkJvb3RJbmZvICpp
bmZvLAo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIGNvbnN0IFJJU0NWQm9vdEluZm8gKmluZm8sCj4gwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIGNvbnN0IGNoYXIKPiAqZGVmYXVsdF9tYWNoaW5lX2Zpcm13YXJlLAo+IMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCBod2FkZHIgKmZpcm13YXJlX2xvYWRfYWRkciwKPiDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
c3ltYm9sX2ZuX3Qgc3ltX2NiKQo+IEBAIC0zNDgsNyArMzQ4LDcgQEAgb3V0Ogo+IMKgICogVGhl
IEZEVCBpcyBmZHRfcGFja2VkKCkgZHVyaW5nIHRoZSBjYWxjdWxhdGlvbi4KPiDCoCAqLwo+IMKg
dWludDY0X3QgcmlzY3ZfY29tcHV0ZV9mZHRfYWRkcihod2FkZHIgZHJhbV9iYXNlLCBod2FkZHIg
ZHJhbV9zaXplLAo+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCBNYWNoaW5lU3RhdGUgKm1zLCBSSVNDVkJvb3RJbmZvCj4gKmlu
Zm8pCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIE1hY2hpbmVTdGF0ZSAqbXMsIGNvbnN0Cj4gUklTQ1ZCb290SW5mbyAqaW5m
bykKPiDCoHsKPiDCoMKgwqDCoCBpbnQgcmV0ID0gZmR0X3BhY2sobXMtPmZkdCk7Cj4gwqDCoMKg
wqAgaHdhZGRyIGRyYW1fZW5kLCB0ZW1wOwo=

