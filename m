Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49C61C61DD3
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 05:47:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x20HN-0005Xh-Gb; Thu, 03 Sep 2026 01:46:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=6997dc6e7=Alistair.Francis@wdc.com>)
 id 1x20HL-0005XR-ER; Thu, 03 Sep 2026 01:46:27 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=6997dc6e7=Alistair.Francis@wdc.com>)
 id 1x20HJ-0005dA-HZ; Thu, 03 Sep 2026 01:46:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1788414389; x=1819950389;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=ZHEmQFMEpYxzdOChPCb7nBRvn9AtOblA9mbe5BdDN5Y=;
 b=FRTRxnXuV6AA9+LWmWNoGbJ3YKzqijtH5KYsac72YxcmkA67hBePDGYq
 a39lcipA92xSd+RouWIm8z3MFl6JlX38tVcAKZNou85IeT7JYyNn0hDFb
 fIC+kHfpOi5U9ovGBbC7ere4P02UgUjjdtt1DpKinXGL/72vwGZ9FkMfc
 70Kf1iScCDIrMFQm84o2dG8/xkE/AgbMDcuCg2Lzf0QncMRDoO76gsC9o
 EF3hz1wiggGDHNgFIXsj2F0DsOmHLtKuZZZ6mLTjkUaRscU2dWJDU7/2k
 Y1Lcu3irmZvYdQ+5FG+Y6f8O64j9f07tltxP9C3bVuZH4NUAvxbGGpmt4 Q==;
X-CSE-ConnectionGUID: 1mYj41nOSPGv6aVCy83JAQ==
X-CSE-MsgGUID: Do/V2VuzRseNplg7EwtbjA==
X-IronPort-AV: E=Sophos;i="6.25,258,1779120000"; d="scan'208";a="153270088"
Received: from mail-southcentralusazon11013021.outbound.protection.outlook.com
 (HELO SA9PR02CU001.outbound.protection.outlook.com) ([40.93.196.21])
 by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 03 Sep 2026 13:46:25 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D8wa/wwQOvLS2B2I6/Xnga4vd2+Jz4d+nHnC4DoGLESKV9pnnZU5I4+b8oOny443JcIkxMuyYiaFu1eZ3NBSyAAU0Z6MKhonbkxw1whMnvabN+tn31FedcvnKd/zlzQMopm7mpkPVrex+WkPiJMx46RXUpZEEm82JMT37j2iKBSJj+XPbC3QpH7TeP+SbZFl3gweto+Y/5Wo5/R6Gc5fYxKj/Kwxe0dgIyEGLcKEdvZngIs++vdDh8c5PtCqKnp6sZbO6TqLOpnGfD8wzdXjl7RNEjy5n/aP/Y8e0Nxgr/hxGyhHdGVFxjK8kTxKGOgvRzvRdVpw0Gy1qQSg9VurxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZHEmQFMEpYxzdOChPCb7nBRvn9AtOblA9mbe5BdDN5Y=;
 b=cntdK0MaQHdTlyR2bArszscDMmUzyPftr7n52DvhHQ5rc6Ud3rT54Or6ZlXiedJSRaqO3N7Dn/Y1PSXq9wbO5/OOCNXGJQBJZtFCwaEkykGDCcXFSryKFzVh2sRpVbMdbabGIylEFf4wfwzd869AxhHyDEVZvlpwvQEdki9NnU9a+i4T6Oi2pEvMwcn2yOLp8yYE77d51HQfnWElSxSVhEVyi98C2KUEPVNMFkxEVI6uJXYqbvLSlIkZs5ykMq8vUrbSKuheT/D2zCIjGFUiAaFAcdxz4C9rJwJVd2+Dq8GnAIBUMuH8GxiS3YkYaDmwo2lQSFKmaWJpeaVHGc2PDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZHEmQFMEpYxzdOChPCb7nBRvn9AtOblA9mbe5BdDN5Y=;
 b=w4GrwFCSi6yw1ecUeajm48BCXN/DoQzjJtFZq4msH+wiv8lB1lHsnLd0xieDeX4XMUtkRAyb5/DJp1IRVtvplo+SmE1txJZS9JM0ptIOzoDkmCs0PiHJzxahiat9vIYJY0q3+cbNvr2LNp83CopP0Y1roZP9xOSa+4RfWsSKoeg=
Received: from BY1PR04MB9561.namprd04.prod.outlook.com (2603:10b6:a03:5b6::11)
 by LV3PR04MB9260.namprd04.prod.outlook.com (2603:10b6:408:274::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Thu, 3 Sep
 2026 05:46:20 +0000
Received: from BY1PR04MB9561.namprd04.prod.outlook.com
 ([fe80::3869:e494:2fa8:9888]) by BY1PR04MB9561.namprd04.prod.outlook.com
 ([fe80::3869:e494:2fa8:9888%5]) with mapi id 15.21.0382.007; Thu, 3 Sep 2026
 05:46:19 +0000
From: Alistair Francis <Alistair.Francis@wdc.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "wangyang25@otcaix.iscas.ac.cn" <wangyang25@otcaix.iscas.ac.cn>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "palmer@dabbelt.com"
 <palmer@dabbelt.com>, "daniel.barboza@oss.qualcomm.com"
 <daniel.barboza@oss.qualcomm.com>, "chao.liu@processmission.com"
 <chao.liu@processmission.com>, "liwei1518@gmail.com" <liwei1518@gmail.com>,
 "zhiwei_liu@linux.alibaba.com" <zhiwei_liu@linux.alibaba.com>
Subject: Re: [PATCH 2/5] target/riscv: save ELP in MPELP for RNMI exceptions
Thread-Topic: [PATCH 2/5] target/riscv: save ELP in MPELP for RNMI exceptions
Thread-Index: AQHdMwFhz9TJHrYHHES5RwU1sAdSp7a8aROA
Date: Thu, 3 Sep 2026 05:46:19 +0000
Message-ID: <d0de80b7fbf7981fceb58f921580616e3751745b.camel@wdc.com>
References: <cover.1787489230.git.wangyang25@otcaix.iscas.ac.cn>
 <ce36a27e6346228b12c926a6f95835521ba56f86.1787489230.git.wangyang25@otcaix.iscas.ac.cn>
In-Reply-To: <ce36a27e6346228b12c926a6f95835521ba56f86.1787489230.git.wangyang25@otcaix.iscas.ac.cn>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.60.2 (by Flathub.org) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY1PR04MB9561:EE_|LV3PR04MB9260:EE_
x-ms-office365-filtering-correlation-id: 2ca508f1-78c7-44b7-a923-08df097eadfa
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|10070799003|366016|19092799006|376014|22082099003|18002099003|56012099006|38070700021|4143699003|11063799006|10067099003;
x-microsoft-antispam-message-info: 4fU9Tn2dT5oD9VWEt3S2/OwocdenBlbav1q7oaD6eoa8RVnlJjLlyCcN7Ld4lmhaZXprPD4BIqeFVnzw66BEL0JyFmhc1rfd2ztmHeRxyoPTtJpyfyj9M7B6+/lKhBN1bagL5sPwJxQRWlCU50YlE40RkLPzWQywI1OOEI37y9aHGRryJvbWIZUQdbnlSghyLZJqMWN2PUUVJK6Ck+IlJ3isXXZV2oOgRzveEn1FnCtTd9+W9E7pqYPaH6q3TKdkt071pMETdbVK8FCFJdP98OL7FxwmrLIQVvk6IAx2UD+793kkX/irOgqCzlRThfgyGYDI2quxX7tQGNRY2BT7+bP3Rj8BgQfwodyrntyduyFwcxkodOcbv9nknArCwLJARDUsJ4eqMiXQlQESe+77ItOIw1CSYxVzDvGIeFkgAt8XVuwAfljNWEwDvfUaersOhTUdwkQbv03aor0gkttGIid2vIjxxfYFmM23ndPPJ4qiY8cs/D6L6lkG1yNS9jRIr0NHDbJPhqNc4FYkkYQUNqkt7t2X4DWpRQjLPddEeBC+ZX/4xu/RlUl66Ivj1wGaRBsJSYViFuFNvVMxbZgpFy/g9rN9EYto2pp84IzheHhiwfi3V+tjt9LkCH6drwstq2KtztMq181JC7B9Tgvyrh/6oOxsJdm6n1UhT9KGi1In9vFMxGR0hCzJ1i27k+QbJkpEbXEgSdU4ZE7/C8krTUkDN3+FE0HNmfG144mGlfM=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY1PR04MB9561.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(10070799003)(366016)(19092799006)(376014)(22082099003)(18002099003)(56012099006)(38070700021)(4143699003)(11063799006)(10067099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?a2xPb0xRb2lJNWtBdzNxdGZYdEF3VnAzaFlLZ2JXU0Z3dXFSOFlSdmNDQzFG?=
 =?utf-8?B?SlVvYXBBUU81L04rU1FKejdET2NiNHMrNmJpbWZodEdlaU1seGptM29aUXMy?=
 =?utf-8?B?cjZseVFOd090RU55V1pjR0Z4MmdyWVR5Z09aOFk5UVVUSTk5b3MxTk5lS05V?=
 =?utf-8?B?SFdtOWhSeEM4ZTNrckM5WnFoNCt2dnlzcHhPVE91Q3VYUDByOFJ5aThjT2du?=
 =?utf-8?B?MS9qZk1PMGkvTzZSQXhZck1vYlpkOGNaaHY1NWRwdktYS3RGaWFsR3RxazlS?=
 =?utf-8?B?dWY4MmtkNFFmbExEM3dQaU5mZHE0dkxvWEpWT3N3Q1p5Z21aaUQxSE1kVjlt?=
 =?utf-8?B?SWxaeWxLWmMvREhTYm5WR1VhOHlnZkhnZ3NoRFlSU1hkN1A5ckltbUNYU1Fv?=
 =?utf-8?B?c3lNYTM3aXFUWGpJMXQrYnM0RVdhWVlScUl5Z3NMenY3SVRuZmx1Z0ROMGwv?=
 =?utf-8?B?aDZtMExKYStOT3pKMWNPYUVTZjYwYkdycUVzWXM5V2xyRExIbVpDSE9nS2ta?=
 =?utf-8?B?L3lHMVhva0x6eTlNN0dKRTdMSzZKSnY0c0ZVaHNkbzdERkVzUHFVVFR2R01u?=
 =?utf-8?B?enN6ZUFHWVVrUjlUaUJzc3FzVXpHVzVPcUpFYlFYWXNxeVFkeVloK0VMREZL?=
 =?utf-8?B?dngwOXR4YXU0NFNDMnFMQnJKeTdKMmVVcWRNeHA0Yks4VmJLd2hvdHY4TUM5?=
 =?utf-8?B?TXA2QjlhWEU0eTYyOXZJbHA0NU1lajFITCtYU0ZsSkVud0k2WWh5a0t3OXlh?=
 =?utf-8?B?Qms1UVNBQURoM25wa3puZVlVRVVVRGZWN2NzQ1h2d0tIZnIzb0FMYzhMMS85?=
 =?utf-8?B?YkFLUUFHMWE0ODVrT25oUDNaa2xMVXl0UC95eXJqeUlLK3NwZ0FzOUxueVY3?=
 =?utf-8?B?TnAvRCtTekZ5QWpPQnlNdGQ1QWI2SFozSENJNkwvV29rMkh3VlNOL1I1dXFu?=
 =?utf-8?B?OVRHMXZrcHNvbmIwOVlOMzFuWkhubVpmWlI1dk53T09VUTJEY0w2ajBtdmw0?=
 =?utf-8?B?UWdLbHBBK09PY3pIUndCdDczWldSc1Y1WXBNMUQyTVNtZ3ZVWjE1cXZsUXFC?=
 =?utf-8?B?SlNKUFVQbTlVdjF6OGxsSVVSSHZDSlQwc3RWK1ZaWEVVWE0vdFJJb1JkMHFp?=
 =?utf-8?B?UWNCZVAwV2hWSHRwY0JWVDBLV2JQczF6MVR2Zys5bnJ0bFhlSW9UUWlXSHhl?=
 =?utf-8?B?VEdzS052YWpTZWJyQjIrdXRhT25FNXdtNnVTUlllT1BiZTdHL2JKNXlSRm55?=
 =?utf-8?B?c3U5b2E1NWFxUWpDVFh4VCtCRU8zWU4zTFJSZy9kNThaTFE0NFZ1RmZJZUNw?=
 =?utf-8?B?bTNXaVdoVFNjaHBER045RVVKamRIbElPNFM5b1dNdExsdXZ6b3BJTXRMTExF?=
 =?utf-8?B?VnExbWMvUlhmb3ZCSERaSVY4OG9pVDVQejM1emM3dlFuWldOdmFnU05IbVRy?=
 =?utf-8?B?ME0zQisrb25XVjZmN3BLb1lqaVlaN1ltL1BKNVdmeGhPVXlJZDRzQ0xwMXVK?=
 =?utf-8?B?cmJpTzZDN3pIalZFRnZVaW52dlZuZTFOZ1FSVzFmcHV0eVFMYk12enk1M0pS?=
 =?utf-8?B?MUNTVGo2OEZhbTBIbldZckJjTEZqWHFqOWppUzdEZUk4eUtxeGlBUVM4ditu?=
 =?utf-8?B?QXJIcVdkK1NTc1RHdXBZU3hscG94SVFkaEdNbVo1dDVFbmU5bUVEZEZDL29p?=
 =?utf-8?B?Tk14MDRuUld0UEgzNG1hVWlIby9lVUllb1kwUE1ZR3cyWXFtTVg5YjN6MGk0?=
 =?utf-8?B?MENrWnFDV3RHOUtOQWlRYWFTaXZRU0VjL215czBJb2FZMjh1ZzNDaDFSeWl4?=
 =?utf-8?B?QWM2K0ZENEh3eUpQV2NzMW5ONWdkY3NEbkpGQjhBRTV6MTdWVHA2Nml0T2Nq?=
 =?utf-8?B?OEZPcCtmZ2M4d2J6di8xd0RlaE9ES09KdFdUek95dVRkcEsxRk5XaVdVOVJW?=
 =?utf-8?B?Y0x6YnRlRU8rVWxENGhGdzBDWmExUHVjT09aY2VEMW9IRFRFblRacG9SQ1FZ?=
 =?utf-8?B?NTZJSGl6M1B4b1ZwMExkN1FlOG9WajR5b1JUKy9FWDE5b205SGxyRVRjRG9S?=
 =?utf-8?B?WHp1N2FKR2pOb0tsN2o2Mis2Wkcrbm9PYm4rNWgxYTA3bUVuc3d6OXpmU1Vl?=
 =?utf-8?B?dDBSd1hTSW5QMlpDblV4UldrWnBxMHcyVjRJT0tuMldLRkpKSnRkZnp6Y0pt?=
 =?utf-8?B?VittbXN0bHlCWlRsT0hPWE03VmZIYjBuME11bzJHUWs1VlRhckpabFlWenph?=
 =?utf-8?B?R1BOOGM0UDlsS1lrNkRFSlQyRU9rZitXWU1NNmE1cjRtQjlESm9FR1VsTmZI?=
 =?utf-8?B?TUliT2ZCY3ZVWmQ2YnVkMFRIeThRZXNwNVRsYjJNNHQzRFZjeHlCaURjNFdE?=
 =?utf-8?Q?PUA7Lp5jgChrkH0jOAXKqzCs/EuSD5smtKJ6ywNgK2ZIb?=
x-ms-exchange-antispam-messagedata-1: v52qt76FNr6BuOhlEQ62BmrTxKMZ/WG4WYw=
Content-Type: text/plain; charset="utf-8"
Content-ID: <946A358F1281894F83D8672D884136CD@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: o6kE4x72RShE7EaC/yAb3HHzKKTDgFpeyCj2oceh7QodLAnqI6HsrLRPR2ePqyiWumgGrzJB0rbweN2BzqUKKAEgf+UPE0fsPFnjUl3Bl9MxaiOVPfEV/LhmHS6oypc+zFKZeeQaGq1Qx5NLRTG4TjCMvjpJ4rKwdbtV15kLbnWKt6leMq5l9MP8p0R8SjWzFNrMwjjPJoJ6WT3dBB3c3p1eWqXO/Dyn4MhB2FqxQHoXtKWuzzmk2rjogZ2KwBVYjMoeHLOuX3+5YyJx/OwgsyHPkMlCfKBdrG37HbQNuR2s3HeRLjf1mdRbgQfCQBGzPwTc/HyFqLrVfQXxHYWbUA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: hhZ9OcgZmMn6pTrYYw02dU+bty0KwijGMa/JYi+7KwUGS/1qMHfkZiIth0ZRJmOIibDRAO7IZrYS+rfYpQNKAV3KN3SuXS1PF98lK6mLFif/c47IjVzTBRbxlYwqMWn7kme7W7+oYrVxwauR/5K14xuSTTju2460sb2jFz3mAiZmjCJvAMg+YvyEEZCvo/Sq+6E94R9gRmCecm8/OLOUB7FGdo9hCi1UZYMxKj5QIY0TmfoA4Fl0bzwDnXW8iikGIkokVlAtOTsi6pwRv6cOCpgpjcgWd27H+QJxr5r16QUkGru/DY668wynNeuJg4Mul19zcJ5SnT6rU92OTafqiUF4Cm6g8KPBGDc60ejJTvI6SBSUh4QgaujOqj9Rt0R9RJfK7d3OL7GciqVlrvth1sNk79gsZbXU5hhUDrG7mZkdlg1gRjlZLzw8tYWWyh+yYrroJ+N/C7w6pQpk3gurvKnN8yiRljA1eRII4gW3iL9CYKoFZ7NwrlfE3dDNeAxk6uQD9p/HTOywd2QHJs4HGyWiffKls2XQNoU5L64yKh/0F4XI3vuYJ4DiQjcliuiC6xgSrxFE9JZqVe0f+Eo3pwNUPxAXuZxfyfW7UleePIcvbtZkXVFOb/oTaYeJI0Xw
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY1PR04MB9561.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ca508f1-78c7-44b7-a923-08df097eadfa
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Sep 2026 05:46:19.8872 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rMlHtMw2RUC9bYNzITBlNWaZ6YUvTTjr4aWUWC/FYyzWHuae6TsbIJ9AKS6mNm4vyT5NEVzu0mMxfBK93nPAkV78fVw995bRPmwQt54dkGA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR04MB9260
Received-SPF: pass client-ip=216.71.154.45;
 envelope-from=prvs=6997dc6e7=Alistair.Francis@wdc.com;
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

T24gU3VuLCAyMDI2LTA4LTIzIGF0IDIxOjE0ICswODAwLCB3YW5neWFuZzI1QG90Y2FpeC5pc2Nh
cy5hYy5jbiB3cm90ZToKPiBBbiBNLW1vZGUgZXhjZXB0aW9uIHdpdGggbW5zdGF0dXMuTk1JRSBj
bGVhciB1c2VzIHRoZSBSTk1JIHZlY3RvciwKPiBidXQKPiBTbXJubWkgb3RoZXJ3aXNlIHNwZWNp
ZmllcyB0aGUgbm9ybWFsIE0tbW9kZSBzdGF0ZSB1cGRhdGVzLiBNUkVUCj4gcmVzdG9yZXMKPiBF
TFAgZnJvbSBtc3RhdHVzLk1QRUxQLCBzbyBzYXZlIGl0IHRoZXJlIHJhdGhlciB0aGFuIGluIE1O
UEVMUC4KClRoaXMgY29tbWl0IG1lc3NhZ2UgaXNuJ3QgcmVhbGx5IGNsZWFyLiBXaGF0IGFyZSB5
b3UgZml4aW5nPwoKQWxpc3RhaXIKCj4gUmVzb2x2ZXM6IGh0dHBzOi8vZ2l0bGFiLmNvbS9xZW11
LXByb2plY3QvcWVtdS8tL3dvcmtfaXRlbXMvNDIyMwo+IAo+IFNpZ25lZC1vZmYtYnk6IHdhbmd5
YW5nIDx3YW5neWFuZzI1QG90Y2FpeC5pc2Nhcy5hYy5jbj4KPiAtLS0KPiDCoHRhcmdldC9yaXNj
di90Y2cvY3B1X2hlbHBlci5jIHwgNyArLS0tLS0tCj4gwqAxIGZpbGUgY2hhbmdlZCwgMSBpbnNl
cnRpb24oKyksIDYgZGVsZXRpb25zKC0pCj4gCj4gZGlmZiAtLWdpdCBhL3RhcmdldC9yaXNjdi90
Y2cvY3B1X2hlbHBlci5jCj4gYi90YXJnZXQvcmlzY3YvdGNnL2NwdV9oZWxwZXIuYwo+IGluZGV4
IDA3ZDkyMjIuLjYzMzdlOTEgMTAwNjQ0Cj4gLS0tIGEvdGFyZ2V0L3Jpc2N2L3RjZy9jcHVfaGVs
cGVyLmMKPiArKysgYi90YXJnZXQvcmlzY3YvdGNnL2NwdV9oZWxwZXIuYwo+IEBAIC0yMjc1LDEy
ICsyMjc1LDcgQEAgdm9pZCByaXNjdl9jcHVfZG9faW50ZXJydXB0KENQVVN0YXRlICpjcykKPiDC
oMKgwqDCoMKgwqDCoMKgIC8qIGhhbmRsZSB0aGUgdHJhcCBpbiBNLW1vZGUgKi8KPiDCoMKgwqDC
oMKgwqDCoMKgIC8qIHNhdmUgZWxwIHN0YXR1cyAqLwo+IMKgwqDCoMKgwqDCoMKgwqAgaWYgKGNw
dV9nZXRfZmNmaWVuKGVudikpIHsKPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBpZiAobm5taV9l
eGNlcCkgewo+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZW52LT5tbnN0YXR1cyA9
IHNldF9maWVsZChlbnYtPm1uc3RhdHVzLAo+IE1OU1RBVFVTX01OUEVMUCwKPiAtwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCBlbnYtPmVscCk7Cj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfSBl
bHNlIHsKPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGVudi0+bXN0YXR1cyA9IHNl
dF9maWVsZChlbnYtPm1zdGF0dXMsCj4gTVNUQVRVU19NUEVMUCwgZW52LT5lbHApOwo+IC3CoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIH0KPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBlbnYtPm1zdGF0
dXMgPSBzZXRfZmllbGQoZW52LT5tc3RhdHVzLCBNU1RBVFVTX01QRUxQLAo+IGVudi0+ZWxwKTsK
PiDCoMKgwqDCoMKgwqDCoMKgIH0KPiDCoAo+IMKgwqDCoMKgwqDCoMKgwqAgaWYgKHJpc2N2X2hh
c19leHQoZW52LCBSVkgpKSB7Cg==

