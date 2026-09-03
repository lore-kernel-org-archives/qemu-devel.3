Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 598BAC61DD6
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 01:59:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1wjn-0000gd-EL; Wed, 02 Sep 2026 21:59:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=6997dc6e7=Alistair.Francis@wdc.com>)
 id 1x1wjm-0000gJ-6h; Wed, 02 Sep 2026 21:59:34 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=6997dc6e7=Alistair.Francis@wdc.com>)
 id 1x1wjk-0004OL-DI; Wed, 02 Sep 2026 21:59:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1788400772; x=1819936772;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=XvIvv5sGheQ1vtZDjcYuwCg+FwYpN3fJfj23dLSQbqk=;
 b=cqWFv7/iZ5xibMUt9t2l/pKRjYD79Q3qGQoallFcM9YzZ4ew6i484gtS
 W0u7+SgFniUGtBO7+Q2i3Bdb/s1CUwlmLTG10xTAqEof08RXN8S0AVlVC
 yNN6k8qjG3zkCjXSlPshvryQjEa8TUzZrk7gfFUbiYiVu+MDL4iF8UzSq
 bKIN1YBwHhmprbdKoFfQbPozy2C2B0vw3shCe4ZMRypgyTl/XLovQ9Itn
 6IIuA3oBwBGiXa73sYCV9SfeUO9Rs4diPZwj1GFP1t42X2Ce/RL29AvBv
 0V3wG0kHE8/kL2VfeOiKGrgWj+eEQcDY8hwfqFtTlpGuxZ2odHpp8j7iu g==;
X-CSE-ConnectionGUID: pt/w0wubRkesT5G2w2jS/g==
X-CSE-MsgGUID: 3qtbjLc6Sfu8qm7/F1YM1g==
X-IronPort-AV: E=Sophos;i="6.25,258,1779120000"; d="scan'208";a="155756779"
Received: from mail-northcentralusazon11012048.outbound.protection.outlook.com
 (HELO CH5PR02CU005.outbound.protection.outlook.com) ([40.107.200.48])
 by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 03 Sep 2026 09:59:28 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xVtu4azTvRpQyiLv9nNvY1GRcX9pzA2nvl9LkZG03gizypVhc1ERCLZQLv97lqRNeijR54W6ce/mW08BSuUmG+6fLS1jFDhIRCaFxkAlPqCOUGUR4SWh3BqjxC3G1uw54kuhpeN4/my5fQbzPI+rY4kIDen9fUKzC8k74l2bLH/s0VCcbMp0pS5nbIOWpY8iJi06ljxWIaQD54yQqT6/jdjceyx0hRSJGSAQCrqeyqxbb8KPANZ55sdDjV9KxrtEfefzCsRATYrOiLYKpCPkWUSEF3z3ucptyOWxa5u89srFmsE0dG8PP1ttXU1LdsOuRRyeHaSBUM7qSFKMMBCh4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XvIvv5sGheQ1vtZDjcYuwCg+FwYpN3fJfj23dLSQbqk=;
 b=bb29vy3YdLK47koIsOynXKHJfGaOJoehUWx43bPc8au9HOhGekvIJNtNd0Fu7O2vKOkMDlXHgxjcGX9NzHgjAFQqS39Y+30BhJNDqkZnoOR48FbgMD6OIcjb/EMlCnP/QuJ+OABtQoeKjPbVa6SECCBpKSZZ3dnMyxKB2IRKQ+84clCB6/fO/7+XsyX/pJg85WGDNs/8XNyfuPvZVy81/21/xdFjov+5JliMlCjRLxIht3d9/7JeH4BnAbGMznEikLkJL7mH2w2Ipe8pXUtYmoc0yTIAnx3KzHKEpEl9a6uF4RfG+o+og5HNqNtuvoQM0fN3wXLvtK3YWyIse5HGtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XvIvv5sGheQ1vtZDjcYuwCg+FwYpN3fJfj23dLSQbqk=;
 b=p1gCSQFhUVu1xM11LfJLUBqIHGuiucrDvtxGEWJEDkbMvaJjJsuMuH21O74Wygg17d2cIKfXk7xp5K/IV4EUwYssrQ4awkDP0MZ06CVrLKFcJOnlE2nm2X2IgkHJQqcIwJ7BAE93A/OVVPTy4hbQ2ALSFdJ4/+b1v+Xl2GTDf+g=
Received: from BY1PR04MB9561.namprd04.prod.outlook.com (2603:10b6:a03:5b6::11)
 by EAYPR04MB9969.namprd04.prod.outlook.com (2603:10b6:303:2bf::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.7; Thu, 3 Sep 2026
 01:59:26 +0000
Received: from BY1PR04MB9561.namprd04.prod.outlook.com
 ([fe80::3869:e494:2fa8:9888]) by BY1PR04MB9561.namprd04.prod.outlook.com
 ([fe80::3869:e494:2fa8:9888%5]) with mapi id 15.21.0382.007; Thu, 3 Sep 2026
 01:59:26 +0000
From: Alistair Francis <Alistair.Francis@wdc.com>
To: "daniel.barboza@oss.qualcomm.com" <daniel.barboza@oss.qualcomm.com>,
 "joel@jms.id.au" <joel@jms.id.au>
CC: "npiggin@gmail.com" <npiggin@gmail.com>, "mpe@kernel.org"
 <mpe@kernel.org>, "portias@oss.tenstorrent.com"
 <portias@oss.tenstorrent.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "clg@kaod.org" <clg@kaod.org>,
 "chao.liu@processmission.com" <chao.liu@processmission.com>,
 "zhiwei_liu@linux.alibaba.com" <zhiwei_liu@linux.alibaba.com>,
 "asrinivasan@oss.tenstorrent.com" <asrinivasan@oss.tenstorrent.com>,
 "liwei1518@gmail.com" <liwei1518@gmail.com>, "qemu-riscv@nongnu.org"
 <qemu-riscv@nongnu.org>
Subject: Re: [PATCH v2 12/16] hw/riscv/atlantis: Decouple RAM size from
 MachineState
Thread-Topic: [PATCH v2 12/16] hw/riscv/atlantis: Decouple RAM size from
 MachineState
Thread-Index: AQHdOO7DLxCUJSz17kObB5pr21i/uLa8HdOA
Date: Thu, 3 Sep 2026 01:59:26 +0000
Message-ID: <c4476acc32d05deb33de3ae19f6123d364777fd6.camel@wdc.com>
References: <20260831021500.82565-1-joel@jms.id.au>
 <20260831021500.82565-13-joel@jms.id.au>
In-Reply-To: <20260831021500.82565-13-joel@jms.id.au>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.60.2 (by Flathub.org) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY1PR04MB9561:EE_|EAYPR04MB9969:EE_
x-ms-office365-filtering-correlation-id: f43a1853-b165-4aaf-744c-08df095efb82
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|10070799003|23010399003|1800799024|19092799006|376014|7416014|366016|38070700021|56012099006|10067099003|4143699003|11063799006|18002099003|22082099003;
x-microsoft-antispam-message-info: yfaCCBQqSn/WVWFYZKywqop+mfwSVKL8G5mFGvMQHJJM/aiWJvID7+6sgvN1mfpe3rw+cbnAu3nCZrGEOSNVx8osNdDHaFOs9W912BXTyJSzM2rp8x+bBdlaLBjYrroSAkSlt2bhzYKTq9QCzIHIdQNqHSK8Ht0devaYd7m6R9+A1TkiwhHhBTexzJOamn/V1YxLVD+Cv6fmxH4gmjWnCw0yJ96YLQ0gEEM+smkNut29ChQjFtvdSQpG6IdSughESSyuLKR14y0Uvsdp2qF1ycCyCs0NGZY+PhP5y6blPNVA+naiR1DU5ySj/6cOpGHGY8KLmz9TqjFcwdA9STBMrqTWflveIhaVkAdE2XmFgosoDRqr3Tx7NqvHg+NBhDQ6vaBNPxzAxto4yRxQx1dr7LA5HMDyqbWJeTwsUPuFOyD+FsDrSJBl8CnSWNNfXd+T68CPyfTmlnBpG0CEfCZJrK+E1zoxs9xZmDcnefr8lNiLF1lSRFMb2hDxEib/LF5chNR805L5C9T81NT7RIQVWc1SLIoENoWIeOuFjsTe+Iy2Mf6SYZKgPQCTY6AIAcbQtbcm3ef/uYN/mx2HKZ0WywMhWsz+u1APH7Wi1ABvu564dlXYgqes2xh/N5+yJ4htbla4arWLY+pMkMZquuIZ9jVaXNFRKCB+KMq49CP3jR7I2wFnj+zbsvVye8lwnevYmdHHtm82CfIRUYo8PyG8P8uKGMq/ddpE9TKe64Kv2X4=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY1PR04MB9561.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(23010399003)(1800799024)(19092799006)(376014)(7416014)(366016)(38070700021)(56012099006)(10067099003)(4143699003)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YXJFbXc2c3Z3TkdmeEVrVjkxaWlKV09GZERSZ1pCTEJzaXFHcG9vd3dzM0gr?=
 =?utf-8?B?UnVWWjR1bTFyOHlMMjNvUWcxU0hINk1HUXQyVjZydTVaRGhmZmVQZWswYjFq?=
 =?utf-8?B?b3Z4NWhyMjNPL3JaV3R0M2dFR20yZHVzVG85VnlqazNlZVY1bnZCdGl0KzRi?=
 =?utf-8?B?RFZPREFzOVlFU1JndzVVb2ZRWTBsbldDK1RKK2MyODFhMWE1bFFnWUNja0N6?=
 =?utf-8?B?WDhYUGxmYlc4bVNIckMwQnQrSzdLTHNNeS93R3I1WmRKbithaUtRdnJ3VnJ4?=
 =?utf-8?B?aHYyL3I3WkI0QjlOU2V5dkJsWDBNdVlORTgxUUcyRExnNkNjQTNNcmFWRWZW?=
 =?utf-8?B?eDlsdkxaSElaNGltTTNXdi9KNFFRKzFLWnpEL3RsYlFxTHo0SEd2ekdNRWxa?=
 =?utf-8?B?MkVZdVlHeGhtN3JQckpLeW1tTDhqZnlCMzFPZnprckJYeUlWU2dlejlxaVBR?=
 =?utf-8?B?Qjk0c3pjcDFaT1lEL0ZFbjZkRkN0ZjJIVEJTWSttVC9hUDl6d21CdnovNG1q?=
 =?utf-8?B?UmJ5YzhkbFhvUDI4OFZrQlMzTTI3bWk0NllHaitYU0ZkejA4aFZ3SkhFVlVj?=
 =?utf-8?B?eCt4Y0tFVGQ1aXZJckU5SlFkQ28wTDQ5cVdSNlFwVkRKendITFZ3S2lPZ29h?=
 =?utf-8?B?Mm4ydmtLUmVzRHlaYzBEajEzdmxyaUdwTnpVNWw5WkRwVW56Z2dyM0lTWjdR?=
 =?utf-8?B?TGIyQ2NLOWRqNkVEcmdqb1NESkhSbTFiUDk0Z08weGNHNGViNHpnZ01WdEVq?=
 =?utf-8?B?KzJiUUpPRENPLzNiUFozTGhpY0lxWStpMW9oRFNpbkU3L0VKMCs4ZlB4RnFy?=
 =?utf-8?B?NE1EaXk5emxwaWlYVFhsRlNaZU9NRzg5MWxJd3pnMGlkMUE4MlpuZ1ZOTUdo?=
 =?utf-8?B?eTBsYm93UEFzMDRsZGI4S2hHMTM5UUc1OGlUVC9BbU9jaHNudVY2UU9ENytL?=
 =?utf-8?B?bG9vcld3ZVJlNTNHRW9wUjViR1lIOWFuUkNCYWhITjRMNXlFNDhCZS9GZnUy?=
 =?utf-8?B?Ny9kdE5iOEoxQlZDazUwbGFmN1JTZUZOakE3QkFQYVJqeU9DVGRwS0hUZ0FW?=
 =?utf-8?B?bTh4QndsRTVmSENxQlRKQ0orQ1hDM3pVN2hVSTF4b3ZxSitqMzlzK1U4cDY4?=
 =?utf-8?B?N0hFanVlSVY1V0pPQjRVZVFkUExSNW1iQnRSRWJPOFNZdFNkNGRpaWxncTVM?=
 =?utf-8?B?RFFGdmJGdnhrREc4c1lmQVFueFdjdVhNYXBER0c3cEdKb0JQdDR5aFFEcVhh?=
 =?utf-8?B?VzEySU5ubUdmak9PbmxpZDFRcWYyRXYweVlLdk1nem1LZ3o1RFFtcFRZL3lz?=
 =?utf-8?B?aGhrYk94eGVwWUJ4Y0dZRmNPM3cvdGJOcmpqbDFZL094MnoyTTJSdGhQcitz?=
 =?utf-8?B?UllHMysyWmlTVjllK3VVbUlhcHdCSlRQNXBLWnNzMnduOVhJeURpT1pVc01t?=
 =?utf-8?B?TVlRbXNxcnFia0t1TU1GWjhXZWdvS0ZRQU1PK2V4Y0I0WmtLemJ4bXQ1VEdE?=
 =?utf-8?B?UmJQN2IvaE9TQ2pRSlV3K24vRE5BZG05ZE1HcFM3STEvRmZmMm1HZnFIL2VE?=
 =?utf-8?B?UmFvdHFpdnpxQ3I1TUhEclFDQnY0Ri9FcElsSUozcXc3cWk4T0RROW03Z3Ey?=
 =?utf-8?B?eFA1dmpZOEpOS3dZZ1FWY3hmSHFyY1E3QUs5MEJkM0pvZmQ0bEtWem1nRVVW?=
 =?utf-8?B?QjZiTExqd2hsNTZmb1l5d0ViclVtNk1QSFA5ZisvUmRwTFNLbXpqY29DUmRE?=
 =?utf-8?B?d2RDTUg3RC8zZkpyM3ZsOGRzK29Jb2RZUWUxL2RYZGY5UURLL0EwblNHQ3Jo?=
 =?utf-8?B?bW5vQW5Ua1gzU1ZFTGNLZXRZVXFsd2N2UFNNQXRMUDhvS29kaUZscmhVSGhN?=
 =?utf-8?B?d1RCTTBnUG1oeEl3UTlQdnc4cE9hQ091WUh4Nk1qSDJEVHM1cG4vQWZUbXBn?=
 =?utf-8?B?Y0dHaXozNURxd1V5N0sxaDJjTnBDSHhCcEUycXhPd1dmSGZvbEl0TTV6VkV4?=
 =?utf-8?B?SlBkNE5UcWJEOHhqakdwOTF2SW9sQVlzMGV2cklNRVp6RG96MXpOeHp4YklI?=
 =?utf-8?B?Yyt6elhkOWgvOXBEQmIvOEtXMFV4ekpWNGdUbDRMdk5HcFRneU94cHZUMzkr?=
 =?utf-8?B?dGNFSmN5U0NEbm01MThlZHZ1WGxQeEd4cU1FVDBqMnluYnpoL0FUK2d0bDNx?=
 =?utf-8?B?VlEzTUFSQnFtaUJHc2NTVEwwSHMrNEpLT29vc0gzM3Y3cFdiZlJxQm1BZ3VO?=
 =?utf-8?B?NTdXT2FZclFRNzJHVytLcVFGNUk2U05GR1FqN0ptMnk2L2N4WVhwQ3FFTHFj?=
 =?utf-8?B?UGk0R1hUb3lmSzI1Tis4cTllZTAvL0w2eHdzMUZzQThVSTJ6MkVkTlMvR2Nr?=
 =?utf-8?Q?D21h7GM9ejB6NwreBCQ3tNxhwZSpWCSVXY1BGNS3tQpfA?=
x-ms-exchange-antispam-messagedata-1: PG/alQ6xleCSwenrrzlmrJ0pqiR5eQ1qHic=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F97438DC87DD3A4683D9BBBE7906B991@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: CkmWtC0h/8SR7beXSwdXT3bZ9ddSlsqEqC6BJzccLDDa3kujOEsCgETW97SCP8BsSAyEZme9qlX5bq5Uz92f+DoCBd/ODVP+Ni/LYDYLkd8d839XZbT6gmtFonAGiFbRezn80PaUZbtfBOw0ryVXmPhY6eX5TKk/HOuQ7fnwhvQOz7JYSDP8SlUUcOv8DjxTD1LPehaWWSOuZ+AefXaVltw4J/PAVo6OBTKrEdhq4Yedn+rtO16LtpyiCEsHl/5/zD8nMbvLILTp8qNNXK9wdZCXtNSM++9tO9/BxXjATtqZsxyDHu2OsfUGATxUSyBQLxyiegHn3p5P5F+rOxvHmQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: v96xiKYWfYvbwMKUi1S/MSWGhGTdV0xvKNfqZ8oRv8hD6n5PZmyvr3vIM7bLCikPS+aX5f3kFPHwiQm3NcjJFMlEl3+4rIxNJsm2pIHhQRn45JGBh5ZZr0gGWlOlEd0GTIV7OhzwT6wflMVRxNQ62E+rluNNqjgLSYcusg10X9doUwlGh0tECmnjWRgd2nPAJg4AYKx8WoC3sG6Z+7ns2EA9eCxemqEJ1SK93DdSlX12UIsyg30tLdi1OCL5/0DdORLf3bDZYZ2d/qkoAtfwJ0n2Ix6WKQY0emMCMFqZNgxBiZWfPLr1ym4ChvYnXPwY097+Rl0P9yBcq0cWSq3HmcbRcKDzik39jlb/UdHxrjNi2TLKgJU3xwnsXIaJgSWP4NCLPrqyEaosFinpm6wNjCc3VQ7qFnOQsQ7qB460quYiGkbc1X4DHkxo/9dMjmp6a+fJpwjQ0YP8LlDmifMEyS64hOzqRzx+MgQkXCrS4KeTNaanyaufOGwtW/K4HWQkKbirW/xfws94dO9+6P63Dhdak/QUdyd86u//KeeRfPc1YgHnuN7IZlIthh81Arawcfk4B53WL+vEDEFSb6UrWc9weixbLpZcYfQRLAkGJayY4hvjGX75gW5/bEF+qvIx
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY1PR04MB9561.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f43a1853-b165-4aaf-744c-08df095efb82
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Sep 2026 01:59:26.0597 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Me4R1BRxKRNw8nowcRQJiNNKEPbt8xsDTULOexDEHZYESWL5LdiOnOqc8T4EbP+OU/ehzjCvn2SC3Lvp1idGzW3rLtoNyeKuk1BhdAHRutk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: EAYPR04MB9969
Received-SPF: pass client-ip=68.232.143.124;
 envelope-from=prvs=6997dc6e7=Alistair.Francis@wdc.com;
 helo=esa2.hgst.iphmx.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_PASS=-0.001,
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

T24gTW9uLCAyMDI2LTA4LTMxIGF0IDExOjQ0ICswOTMwLCBKb2VsIFN0YW5sZXkgd3JvdGU6Cj4g
S2VlcCBhIHJlZmVyZW5jZSB0byB0aGUgbWFjaGluZSdzIFJBTSBNZW1vcnlSZWdpb24gaW4KPiBU
VEF0bGFudGlzU3RhdGUsCj4gYW5kIGdldCB0aGUgTWVtb3J5UmVnaW9uJ3Mgc2l6ZSB3aGVyZSB0
aGUgY29uZmlndXJlZCBSQU0gc2l6ZSBpcwo+IHJlcXVpcmVkLgo+IAo+IFRoaXMgYWxsb3dzIHJl
YWRpbmcgdGhlIFJBTSBzaXplIHdpdGhvdXQgbmVlZGluZyBhIHBvaW50ZXIgdG8KPiBNYWNoaW5l
U3RhdGUsIGRlY291cGxpbmcgdGhlIG1lbW9yeSBsYXlvdXQgc2V0dXAgZnJvbSB0aGUgbWFjaGlu
ZS4KPiAKPiBTaWduZWQtb2ZmLWJ5OiBKb2VsIFN0YW5sZXkgPGpvZWxAam1zLmlkLmF1PgoKUmV2
aWV3ZWQtYnk6IEFsaXN0YWlyIEZyYW5jaXMgPGFsaXN0YWlyLmZyYW5jaXNAd2RjLmNvbT4KCkFs
aXN0YWlyCgo+IC0tLQo+IMKgaW5jbHVkZS9ody9yaXNjdi90dF9hdGxhbnRpcy5oIHzCoCAxICsK
PiDCoGh3L3Jpc2N2L3R0X2F0bGFudGlzLmPCoMKgwqDCoMKgwqDCoMKgIHwgMjAgKysrKysrKysr
KysrLS0tLS0tLS0KPiDCoDIgZmlsZXMgY2hhbmdlZCwgMTMgaW5zZXJ0aW9ucygrKSwgOCBkZWxl
dGlvbnMoLSkKPiAKPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9ody9yaXNjdi90dF9hdGxhbnRpcy5o
Cj4gYi9pbmNsdWRlL2h3L3Jpc2N2L3R0X2F0bGFudGlzLmgKPiBpbmRleCBhMjljNjdjMWNmY2Yu
LjJlYzI4M2QwZmQ3YiAxMDA2NDQKPiAtLS0gYS9pbmNsdWRlL2h3L3Jpc2N2L3R0X2F0bGFudGlz
LmgKPiArKysgYi9pbmNsdWRlL2h3L3Jpc2N2L3R0X2F0bGFudGlzLmgKPiBAQCAtMzAsNiArMzAs
NyBAQCBzdHJ1Y3QgVFRBdGxhbnRpc1N0YXRlIHsKPiDCoMKgwqDCoCBjb25zdCBNZW1NYXBFbnRy
eSAqbWVtbWFwOwo+IMKgCj4gwqDCoMKgwqAgTWVtb3J5UmVnaW9uICptZW1vcnk7Cj4gK8KgwqDC
oCBNZW1vcnlSZWdpb24gKmRyYW07Cj4gwqDCoMKgwqAgUklTQ1ZIYXJ0QXJyYXlTdGF0ZSBjcHVz
Owo+IMKgwqDCoMKgIERldmljZVN0YXRlICppcnFjaGlwOwo+IMKgwqDCoMKgIERlc2lnbldhcmVJ
MkNTdGF0ZSBpMmNbVFRfQVRMX05VTV9JMkNdOwo+IGRpZmYgLS1naXQgYS9ody9yaXNjdi90dF9h
dGxhbnRpcy5jIGIvaHcvcmlzY3YvdHRfYXRsYW50aXMuYwo+IGluZGV4IDFjNzVmYjVkOGQ1Ny4u
N2E5ZjU4NzJjN2MwIDEwMDY0NAo+IC0tLSBhL2h3L3Jpc2N2L3R0X2F0bGFudGlzLmMKPiArKysg
Yi9ody9yaXNjdi90dF9hdGxhbnRpcy5jCj4gQEAgLTgyLDEyICs4MiwxMyBAQCBzdGF0aWMgdWlu
dDMyX3QgbmV4dF9waGFuZGxlKHZvaWQpCj4gwqAKPiDCoHN0YXRpYyB2b2lkIGNyZWF0ZV9mZHRf
bWVtb3J5KHZvaWQgKmZkdCwgVFRBdGxhbnRpc1N0YXRlICpzKQo+IMKgewo+IC3CoMKgwqAgaHdh
ZGRyIHNpemVfbG8gPSBNQUNISU5FKHMpLT5yYW1fc2l6ZTsKPiArwqDCoMKgIGh3YWRkciByYW1f
c2l6ZSA9IG1lbW9yeV9yZWdpb25fc2l6ZShzLT5kcmFtKTsKPiArwqDCoMKgIGh3YWRkciBzaXpl
X2xvID0gcmFtX3NpemU7Cj4gwqDCoMKgwqAgaHdhZGRyIHNpemVfaGkgPSAwOwo+IMKgCj4gwqDC
oMKgwqAgaWYgKHNpemVfbG8gPiBzLT5tZW1tYXBbVFRfQVRMX0REUl9MT10uc2l6ZSkgewo+IMKg
wqDCoMKgwqDCoMKgwqAgc2l6ZV9sbyA9IHMtPm1lbW1hcFtUVF9BVExfRERSX0xPXS5zaXplOwo+
IC3CoMKgwqDCoMKgwqDCoCBzaXplX2hpID0gTUFDSElORShzKS0+cmFtX3NpemUgLSBzaXplX2xv
Owo+ICvCoMKgwqDCoMKgwqDCoCBzaXplX2hpID0gcmFtX3NpemUgLSBzaXplX2xvOwo+IMKgwqDC
oMKgIH0KPiDCoAo+IMKgwqDCoMKgIGNyZWF0ZV9mZHRfc29ja2V0X21lbW9yeShmZHQsIHMtPm1l
bW1hcFtUVF9BVExfRERSX0xPXS5iYXNlLAo+IHNpemVfbG8sCj4gQEAgLTQ4NSwxMSArNDg2LDE0
IEBAIHN0YXRpYyB2b2lkCj4gdHRfYXRsYW50aXNfbWFjaGluZV9pbml0KE1hY2hpbmVTdGF0ZSAq
bWFjaGluZSkKPiDCoMKgwqDCoCBNZW1vcnlSZWdpb24gKnJhbV9oaSA9IGdfbmV3KE1lbW9yeVJl
Z2lvbiwgMSk7Cj4gwqDCoMKgwqAgTWVtb3J5UmVnaW9uICpyYW1fbG8gPSBnX25ldyhNZW1vcnlS
ZWdpb24sIDEpOwo+IMKgwqDCoMKgIE1lbW9yeVJlZ2lvbiAqYm9vdHJvbSA9IGdfbmV3KE1lbW9y
eVJlZ2lvbiwgMSk7Cj4gLcKgwqDCoCByYW1fYWRkcl90IGxvX3JhbV9zaXplOwo+ICvCoMKgwqAg
cmFtX2FkZHJfdCBsb19yYW1fc2l6ZSwgcmFtX3NpemU7Cj4gwqDCoMKgwqAgaW50IGhhcnRfY291
bnQgPSBtYWNoaW5lLT5zbXAuY3B1czsKPiDCoAo+IMKgwqDCoMKgIHMtPm1lbW9yeSA9IGdldF9z
eXN0ZW1fbWVtb3J5KCk7Cj4gwqAKPiArwqDCoMKgIHMtPmRyYW0gPSBtYWNoaW5lLT5yYW07Cj4g
K8KgwqDCoCByYW1fc2l6ZSA9IG1lbW9yeV9yZWdpb25fc2l6ZShzLT5kcmFtKTsKPiArCj4gwqDC
oMKgwqAgcy0+bWVtbWFwID0gdHRfYXRsYW50aXNfbWVtbWFwOwo+IMKgCj4gwqDCoMKgwqAgb2Jq
ZWN0X2luaXRpYWxpemVfY2hpbGQoT0JKRUNUKG1hY2hpbmUpLCAic29jIiwgJnMtPmNwdXMsCj4g
QEAgLTUzMiwyMCArNTM2LDIwIEBAIHN0YXRpYyB2b2lkCj4gdHRfYXRsYW50aXNfbWFjaGluZV9p
bml0KE1hY2hpbmVTdGF0ZSAqbWFjaGluZSkKPiDCoMKgwqDCoMKgICogVGhlIGhpZ2ggYWRkcmVz
cyBpcyB3aGVyZSBSQU0gbGl2ZXMuIEl0IGlzIGFsd2F5cyBwcmVzZW50IGFuZAo+IG1heSBiZQo+
IMKgwqDCoMKgwqAgKiB1cCB0byA2NEdCLiBUaGUgbG93IGFkZHJlc3MgaXMgYW4gYWxpYXMgb2Yg
dGhlIGZpcnN0IDJHQiBvZgo+IHRoYXQgUkFNLgo+IMKgwqDCoMKgwqAgKi8KPiAtwqDCoMKgIGlm
IChtYWNoaW5lLT5yYW1fc2l6ZSA+IHMtPm1lbW1hcFtUVF9BVExfRERSX0hJXS5zaXplKSB7Cj4g
K8KgwqDCoCBpZiAocmFtX3NpemUgPiBzLT5tZW1tYXBbVFRfQVRMX0REUl9ISV0uc2l6ZSkgewo+
IMKgwqDCoMKgwqDCoMKgwqAgY2hhciAqc3ogPSBzaXplX3RvX3N0cihzLT5tZW1tYXBbVFRfQVRM
X0REUl9ISV0uc2l6ZSk7Cj4gwqDCoMKgwqDCoMKgwqDCoCBlcnJvcl9yZXBvcnQoIlJBTSBzaXpl
IGlzIHRvbyBsYXJnZSwgbWF4aW11bSBpcyAlcyIsIHN6KTsKPiDCoMKgwqDCoMKgwqDCoMKgIGdf
ZnJlZShzeik7Cj4gwqDCoMKgwqDCoMKgwqDCoCBleGl0KEVYSVRfRkFJTFVSRSk7Cj4gwqDCoMKg
wqAgfQo+IMKgCj4gLcKgwqDCoCBtZW1vcnlfcmVnaW9uX2luaXRfYWxpYXMocmFtX2hpLCBPQkpF
Q1QobWFjaGluZSksICJyYW0uaGlnaCIsCj4gbWFjaGluZS0+cmFtLAo+IC3CoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAwLCBtYWNoaW5lLT5y
YW1fc2l6ZSk7Cj4gK8KgwqDCoCBtZW1vcnlfcmVnaW9uX2luaXRfYWxpYXMocmFtX2hpLCBPQkpF
Q1QobWFjaGluZSksICJyYW0uaGlnaCIsIHMtCj4gPmRyYW0sCj4gK8KgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIDAsIHJhbV9zaXplKTsKPiDC
oMKgwqDCoCBtZW1vcnlfcmVnaW9uX2FkZF9zdWJyZWdpb24ocy0+bWVtb3J5LAo+IMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
cy0+bWVtbWFwW1RUX0FUTF9ERFJfSEldLmJhc2UsCj4gcmFtX2hpKTsKPiDCoAo+IC3CoMKgwqAg
bG9fcmFtX3NpemUgPSBNSU4obWFjaGluZS0+cmFtX3NpemUsIHMtCj4gPm1lbW1hcFtUVF9BVExf
RERSX0xPXS5zaXplKTsKPiAtwqDCoMKgIG1lbW9yeV9yZWdpb25faW5pdF9hbGlhcyhyYW1fbG8s
IE9CSkVDVChtYWNoaW5lKSwgInJhbS5sb3ciLAo+IG1hY2hpbmUtPnJhbSwKPiArwqDCoMKgIGxv
X3JhbV9zaXplID0gTUlOKHJhbV9zaXplLCBzLT5tZW1tYXBbVFRfQVRMX0REUl9MT10uc2l6ZSk7
Cj4gK8KgwqDCoCBtZW1vcnlfcmVnaW9uX2luaXRfYWxpYXMocmFtX2xvLCBPQkpFQ1QobWFjaGlu
ZSksICJyYW0ubG93Iiwgcy0KPiA+ZHJhbSwKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIDAsIGxvX3JhbV9zaXplKTsKPiDCoMKgwqDC
oCBtZW1vcnlfcmVnaW9uX2FkZF9zdWJyZWdpb24ocy0+bWVtb3J5LAo+IMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcy0+bWVt
bWFwW1RUX0FUTF9ERFJfTE9dLmJhc2UsCj4gcmFtX2xvKTsK

