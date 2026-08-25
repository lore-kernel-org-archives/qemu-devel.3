Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C84AC5DF81
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 03:51:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyiB5-0001ps-KV; Mon, 24 Aug 2026 23:50:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=690dc056c=Alistair.Francis@wdc.com>)
 id 1wyiB4-0001pN-07; Mon, 24 Aug 2026 23:50:22 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=690dc056c=Alistair.Francis@wdc.com>)
 id 1wyiB2-0003Wi-2z; Mon, 24 Aug 2026 23:50:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1787629819; x=1819165819;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=24YHFLUyc0nou7Y0lfe2wuXksSC7B/DfW7rCYwMz/VE=;
 b=FP7pL9oNXAvgzdO3ZrtmWLHMxRIxAN2reRfyGBj/TwqLE0tS4n6KKXxO
 VWFXc6Dgu/74Ao4ciuB5s9VuZnLL0viutWWzQXy4fz4sFS2DLArRd2krw
 Qq1zm9yZBzhhlR6EowYrAzuxs0z1pH7NPp5lZiHbroW9/UKAkLfmP9Fo9
 XYTa2pTe/VKqaZ44MR5gh8KgbeOQzFnIe8GhfWpL8g4lvkLu75iodKVvD
 vy/0/9COebmsVjzzIfdntAmoMPiZhRLfm5iVxIt80ZqJMX/ivP/4lkeIk
 eYh+hvBqgGx72eTVXdDfZK5yojOAGxqFwbO3Mgto25+hJW6gsqFHOXLaa w==;
X-CSE-ConnectionGUID: Yu1o/3WkRtax9QDxNBVl0g==
X-CSE-MsgGUID: rQtit0dmR3SdK1r9ITEFcw==
X-IronPort-AV: E=Sophos;i="6.25,241,1779120000"; d="scan'208";a="152627082"
Received: from mail-northcentralusazon11010028.outbound.protection.outlook.com
 (HELO CH1PR05CU001.outbound.protection.outlook.com) ([52.101.193.28])
 by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 25 Aug 2026 11:50:15 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CSMbRiiNW2yL2yZTrftdP+j7Wf/AlZcXMafoLStp1LEPC6qKSRJ97FxmWBoZTEPESKqZlzkIcpwzeBzeDM67+ekxJd8We3P2EUgArRwcr8fbng6fY3Q0FyHhYl3biSzTk5aQf/Por+KK8U/e4n2jLmsznJSc18qLvD1N7p86vRGziz1iN//TrxABLu7KrwgB3OfNwcv8u+xhgy5OJmBAKeW38XIVXsevLNjfS9nSY/+PryAniKuERBnLh8Z2qcU3+uJEKg5dtr9+Kb6EV/NVUMDIE7sJm8rDnSyhjBRYlIhbDzQIyFaQvXqllVvmzuZ0GFhGsad5M4ixOCSmH4lSVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=24YHFLUyc0nou7Y0lfe2wuXksSC7B/DfW7rCYwMz/VE=;
 b=JUw+oMI0AWdwF3C1dUKGoMRl91df827VgAGW6zPwAgheQn/rt83adSNVpg/8f4zcbBUMijYtcVfV2yvCkuFr5Xwmg2QeEiqgFOHZuVHPBu5TRvOsrLWPtvG6tV4EK5K92rQL+RuE1V0UMWjaAhuo6UQa+l0xZMa25prtlyH2oCQRnb0oeO9Lp/D4ALjvv1GVwwnWbV+OCTbVbFwps/c0eYN+2FVjb9GQ6T0CaMmwz8dCf+PNiW2C/TH7G4PA0d9+qEga+7ugsaru5v05VzFwr5WOAC99pYup5RP9lmvJ7asp17AOk3dAr/VIh99FKJqX0cMcSu/fdoYo7iTW7KvA7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=24YHFLUyc0nou7Y0lfe2wuXksSC7B/DfW7rCYwMz/VE=;
 b=vum1yCTXOlW44+vhJ1K2bgnMhv7O2kz1n967gtHnPGUGi0UPy2Yj+Y3ZBfaa3eTrqqwfZL1MVA4OqHD/K5c59mQKBM7kcGwfmgq/PSo5EmonpF1/EFh/pcKbRgG1EhEhb7mv0/AHsWB0zf6vOy+8geSau8s0cHaDE/5LkktFmFU=
Received: from BY1PR04MB9561.namprd04.prod.outlook.com (2603:10b6:a03:5b6::11)
 by BL1PR04MB549746.namprd04.prod.outlook.com (2603:10b6:208:243::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Tue, 25 Aug
 2026 03:50:13 +0000
Received: from BY1PR04MB9561.namprd04.prod.outlook.com
 ([fe80::3869:e494:2fa8:9888]) by BY1PR04MB9561.namprd04.prod.outlook.com
 ([fe80::3869:e494:2fa8:9888%5]) with mapi id 15.21.0360.005; Tue, 25 Aug 2026
 03:50:13 +0000
From: Alistair Francis <Alistair.Francis@wdc.com>
To: "daniel.barboza@oss.qualcomm.com" <daniel.barboza@oss.qualcomm.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "palmer@dabbelt.com"
 <palmer@dabbelt.com>, "chao.liu@processmission.com"
 <chao.liu@processmission.com>, "liwei1518@gmail.com" <liwei1518@gmail.com>,
 "zhiwei_liu@linux.alibaba.com" <zhiwei_liu@linux.alibaba.com>
Subject: Re: [PATCH 2/5] target/riscv/tcg/debug.c: add Debug 1.0 'pending' bit
Thread-Topic: [PATCH 2/5] target/riscv/tcg/debug.c: add Debug 1.0 'pending' bit
Thread-Index: AQHdJQfJMsVA1MQ+bE6dgfdYtCyKvbauP5kA
Date: Tue, 25 Aug 2026 03:50:13 +0000
Message-ID: <004acecbb38818c28af2e1cd33551856e40eaea8.camel@wdc.com>
References: <20260805182506.2943757-1-daniel.barboza@oss.qualcomm.com>
 <20260805182506.2943757-3-daniel.barboza@oss.qualcomm.com>
In-Reply-To: <20260805182506.2943757-3-daniel.barboza@oss.qualcomm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.60.2 (by Flathub.org) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY1PR04MB9561:EE_|BL1PR04MB549746:EE_
x-ms-office365-filtering-correlation-id: a7feca8a-14b1-41dc-e20b-08df025bf825
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|10070799003|366016|1800799024|19092799006|376014|38070700021|6133799003|11063799006|4143699003|10067099003|56012099006|18002099003|22082099003|3023799007;
x-microsoft-antispam-message-info: 8spY6xi0UL/zF5rS+avQKlIByjOW6+IggmKMmgUS3Jx+FlhRPKu4X0GamdzZaGKY9cOm1WdYt4az2bKteth6h914w2SPbyk+gYhAX8ACLz3tgBKW20Txj4uzOmWz5XGv7n0havRhIaV9t8ga+w5TvCPWq4T4CDvV8KIpKji7F4456zneJkr/o9eq6FabXdDlMZO6LwyXIeUIw+OO8LcMvA/oPHB/1lLvjNcQwKvB+FnkEJwglF3QQvLSW5PNAjlTK97dzf/AonZkS4qjQhSgubpyKzfVRZecn/t3IqHeNNN+ttFPzlL+OpwbTga3S9Pgyk6rIPe8iQefcIqJj/zWZexnZG7Ns687WgjJfNXi6OQb9RN8f4m+vyb/+we6hkdf6AC50vsj6mDtJAFmBKaCbZj7X12xdYIrKklFz+3txBlo2IX7Tzbk7DkZulritTWDhDs3YZFOmwsIE2ZgcHpCTddYVlvzkGs6BxdWbp5hk7pWaD7U0A+9FwDdF2TRHOcqVyckjHCvfFrVvvg7/MBccamj1NHJ4nh70Dv6ESPYZ9g19Z1QtM43Kll15M10YKB8wAVkpSY80aNv5m8U1OKU0Ab4U0bfkLB7vsH0sFX1YZvblxO+Fl3Y6ybI/fmRPOPdAupSnPNqIbyxe6yxxTPP4JCQ1re2+CS5wuH+pcNIriariksffI/A1TL+5UuKJtwDgRd/P1T2PFCUA7T49+U/7WSDC+1ez4Tq6hlBsE7pfZs=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY1PR04MB9561.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(10070799003)(366016)(1800799024)(19092799006)(376014)(38070700021)(6133799003)(11063799006)(4143699003)(10067099003)(56012099006)(18002099003)(22082099003)(3023799007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OCtUNG9TT2JnKzRYL0VUTW5XOENqZWFIem5XTEhDZHR2ZFNoVEhzMUxJWmll?=
 =?utf-8?B?SnI0YzcxUDJsV1lSRDhrWXM2ZTFsM21tN3JkZVhnWXJxOHVHZ0dBUFBpd25w?=
 =?utf-8?B?U3gyaU9rb3JwMS90cjltMFo5bUdtZTB1alkzcXVSSG54eTZCOXUrSndzRGdo?=
 =?utf-8?B?aWticGhOUmJYL1FJcVYza0YyaGRQTldiZzhWYnVaNHdNeXZYWFMybUE5YmND?=
 =?utf-8?B?R0MyUWpuaEJxd1pleDFlRkxQMXkrMUwyYjV3Tm93bEtuS21nZUdlSEZhQjYx?=
 =?utf-8?B?Y3RnNC9JWW9Vc3lyS04zY05yWjlwVGMyb0lYUFJDdWRlY0ZkOUNDd2UvdWRz?=
 =?utf-8?B?VGswaUhHY1ZhWUtRc1JWUm9ucHJTcmVqOTZuV2IySHZyRFBKMU1wbnpRbmNn?=
 =?utf-8?B?UFlFOUU4WmJScGdkSTdiWlFObi9Xdkl0Q0lWM1pJRVZqL0huWWFGV0lEdGht?=
 =?utf-8?B?WURhSHQ5UTI4aGZTS1RleUpiajQ1OHUwaUlTRHBmazZtUUI0b1NLL1N6SE5n?=
 =?utf-8?B?RzF5YUlOUW45YVJ3NjBoL0tPOHRNSmV2RUg0bE1pZHFvdERGZ3BNQVJpMFZN?=
 =?utf-8?B?UXRzUEp1ZTZubTFEdjRVVUUvZXVuYmN6NWMxbysyRW5zTjB5MFI3Zk9DVFhk?=
 =?utf-8?B?cGJUK0VXeEo4VkxSWXhyS2NnR2JRakhkbUdwNDRmYU9mWDZTc3BITzBrazE0?=
 =?utf-8?B?ekFkYmVSM0Fzd2VzckhKUzhLYkpuWFJSV3RtNDFFQlBvanVFcTFiRnZyNzAr?=
 =?utf-8?B?NlNmNVljeEJPaEVLRkVEZjdLblhLNUpvMGdKdW1FdkZQa1A0alFhamNsRVNG?=
 =?utf-8?B?UzZYcWFhVmVMcWZUSmdlR2JxS2lCR3BGUUg3NVNKOE95YStUVmVPMWtyQlJ2?=
 =?utf-8?B?cVBrRE80R01iYjI4SkhZYlRIb0dLaDZPOUV2OWNaQXhwNDlEWmFoTU4zQWJX?=
 =?utf-8?B?UHBUeE42TkpGRE53akgwTkVmcUNZMG9iSThhK3QyaWh0QmpNVjRUNWdJUEx3?=
 =?utf-8?B?eU5tU3BuYTRmVUJ0WFJCV3I3UXVBcnFYT1IzK1FZQ0JMTU1ZNzR0RVVmUVd0?=
 =?utf-8?B?bWpJWklpTmJGeUFLVXlOdlhrRzVkcjFGRXVoM2ZtNTMrcVdBVEZVTlRMNEdT?=
 =?utf-8?B?YVNhZ0RpUmk5dndqUVZhSUJCQ1d2dktJL0g5ZTlyODNxYTZtZ29yV0w4UjIy?=
 =?utf-8?B?bXZ1MUdXV2JmdSt0MGJZWEZnK1NldVl0TXdkU2FhTFlaamFKaFJ6MjlhWHpw?=
 =?utf-8?B?N255NndTWjRNUUk2ZDBETmo4WGpKNlYzaWNKZktxYXlkaVd6WDdZQm1QQ3lE?=
 =?utf-8?B?QU9hWnoxbUFOYWY5OEZlNlRrVVl1WUZzanM1Si82NFN0TkNESXRHd2JpeXR4?=
 =?utf-8?B?b1V3RjZBayt5eU1GRmRxakY4QUNPV2tjTEo3MWN4Vmp3TGdzT3BsbTZSWTNn?=
 =?utf-8?B?M3dFaFhZYVQwS3lFM21hT0Y4cHh1REhEaE9CN1Q3b3QzUUJGVzRManZqbGxU?=
 =?utf-8?B?M0FsQ3lyTXlYQit6bVVVa2FMTHdrNDhCYkpYcmNUWVRsME1ZUTNRc3BaQXBF?=
 =?utf-8?B?Wk9Wb1B4NWNLRHZDQnhXUWdrMkRwaUJpVE04ZTNEZEZTRWtZWnFWVzBmTm8r?=
 =?utf-8?B?cGkyNXpTNUhRVzNRa1FMTm1TeGVLcFVYT3huMm05WnJ2MmlWL3Y3amRnQ3Rj?=
 =?utf-8?B?anFBc1RCeHM1UXRQWGxPbWNpanBGTXFQWjBEeGlROTJ5TDJHVExzOGNjOFp3?=
 =?utf-8?B?WFBMMjJCejlnd2srZUdJYU0xdDFuUWZiRnBVSXBJZlBaWEtTSExOd09pc2N6?=
 =?utf-8?B?TkhqWmo0L2QzaCtvVFJHVzRUaGxJeEp1VzIxNjhtdEVCSVR1TW0zMGJwWGtk?=
 =?utf-8?B?cFFwMmtOY3JxckJsSm0vblA3WldVWlNTdDlMS0N2dlBOdHMwU3gyc2VMdkk0?=
 =?utf-8?B?aEFrbEJzRVRuU3R3S1M5K0dqWDZ5eTdQYjlTQzJLNW9ENFR2OGt0dWtYbDVi?=
 =?utf-8?B?RnNrR1hiR3VnQWpjc2g5c3dXSkxHUE1vUnpMQWJUSEsrVFJtOUxlOWVaN0Vs?=
 =?utf-8?B?cHU5UHhESVYybHo4L1QxVnNtWWMwREgrajltVzZKRTBoK3ZodHdMVWE5YjJm?=
 =?utf-8?B?Q0x0WUpaeEhNbnlKZGV0bTQxL3JHQ0w4V2lRdjBlaWZJL3FZTVU3dmo1MlBn?=
 =?utf-8?B?Q3B5b2pXcjY5aDBxcTA0TTB3cGFSK3l6alpuK0RJYTN5aXZqUDJISTBGVlRq?=
 =?utf-8?B?VldiT1A2WXpxd1B3UUVKQi8wanYxMVYwOGpPL0pvcjVQOWFFbC9aUmc5c0Ix?=
 =?utf-8?B?T1hVWG44clVXVnN0T3NNVkdEM1RjSEkyazJtdzZ1Q2kyVUgxS3VnOXRhR3ZK?=
 =?utf-8?Q?Z+OIUCrHgdHEpP+ss9GK/rOsBR19ze1O/dK1qYm5CWTKz?=
x-ms-exchange-antispam-messagedata-1: pra4wAkk20350E6bPXn5v6y7mA2rUjf3XVY=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C9F0C2C45F017946A3692BEA900DE0C2@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: UU4mVJXkLZFrH0pkRQtKgLDx/8bifiC9AqlU4LPt5kDXpbz9gqDgSltLw/9FaoxwrO+7DT6QUejNferRwStQC/nrE+dR+beEIbLcCEKoALqhoaz7uU6R/FPbyl6vcd61hJrDeXvQxNZrOHGPB49iNGrGD/nBeWixfFivU2xc6vARDN+gYDWiTxLInX9+4Rt/vF5FEaciwFk2FXrcsci0SycPBvAWg7Umzms+a1c4PWk2q10kbdnkuaZZgEDFXMQUZLO0QbBJSrO4lHC2EPjlc16QCVtAsQdAjErcya7ydQelH+U3iz3iGkm2xlxEVQoF64qXEak0JP1nl1lRXWebhA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: SGGQJIVGROJBSQrwdQey8YS5lo75uqMrcsp+W9h+hS6X4HUHag1riZhPMpK6bI/8e2KVGz3o2LZxygx/EZrgWq0RmZ/sNz1vrS4YZPVQglDiLeSvsfwU26KS+tcEnCuwBmqAlJbPrjbj/m4dKQP3GhC82+KHihBeG8rPkwjZdvJShpy+x7gAznO2kNPXs3x7aHUPikQyKmiaZHlCxxqQsvzsjs+jBhx2n7/8dpLuRpLt0F4zwGk8gaKfBs/i5tfUc2+PHDFF8ZMdNV+AZwg1uPdHFi2X4MidKJiNdOG6QmCVRBRAXiSijtyCF8wrnY74EOY4Ifk4AmHKRp+vlziVFTnLL7wlsFuU4p7KnwKGkvhdMSMedFOtGZm1szo3DXfcV72jT3Puq4bh5g5ePUQGxAVoZs6uZ6wQgyUmGTSUhU83FiooeXsO9ONE7a4AFF9NTPs/gbo8BSfpBIY/S4idTLqigbDH5/3hK60wP9iQdNbPhC2u3jeI2sjeawa0Tay+PMOWK4FmFspuWlKxv95RzFN9EixRAG+Zz1lH5p2zp76KzCON+0TwyneNAzRezSVoR9Y0WrAL2ZblxIoDkoxQBNGm3XaNA9hHqcjFvKbTVNNdzqb7+9sERo6Ou3On7YtS
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY1PR04MB9561.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7feca8a-14b1-41dc-e20b-08df025bf825
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Aug 2026 03:50:13.7799 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5JbuWmMNyLOoOSAbFGoQaCeFfLeNOYjuR8Xt6+TNqiBuBi/9xqCa8J6kI2NXTWF5xhrc8CswrnCqR36g6yPK1Vz0gnguhU5LzK+u3GE128s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR04MB549746
Received-SPF: pass client-ip=216.71.154.45;
 envelope-from=prvs=690dc056c=Alistair.Francis@wdc.com;
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

T24gV2VkLCAyMDI2LTA4LTA1IGF0IDE1OjI1IC0wMzAwLCBEYW5pZWwgSGVucmlxdWUgQmFyYm96
YSB3cm90ZToKPiBXZSBuZWVkIHRvIHNldCB0aGUgJ3BlbmRpbmcnIGJpdCB3aGVuICdjb3VudCcg
cmVhY2hlcyAwLCBjbGVhcmluZyBpdAo+IHJpZ2h0Cj4gYWZ0ZXIgdGhlIHRyaWdnZXIgZmlyZXMu
Cj4gCj4gVGhpcyBpcyAxLjAgZXhjbHVzaXZlIGJlaGF2aW9yIHNvIG5vIGNoYW5nZXMgYXJlIG5l
ZWRlZCB3aGVuIHJ1bm5pbmcKPiBEZWJ1Zwo+IDAuMTMuCj4gCj4gU2lnbmVkLW9mZi1ieTogRGFu
aWVsIEhlbnJpcXVlIEJhcmJvemEKPiA8ZGFuaWVsLmJhcmJvemFAb3NzLnF1YWxjb21tLmNvbT4K
ClJldmlld2VkLWJ5OiBBbGlzdGFpciBGcmFuY2lzIDxhbGlzdGFpci5mcmFuY2lzQHdkYy5jb20+
CgpBbGlzdGFpcgoKPiAtLS0KPiDCoHRhcmdldC9yaXNjdi90Y2cvZGVidWcuYyB8IDMzICsrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKwo+IMKgMSBmaWxlIGNoYW5nZWQsIDMzIGluc2Vy
dGlvbnMoKykKPiAKPiBkaWZmIC0tZ2l0IGEvdGFyZ2V0L3Jpc2N2L3RjZy9kZWJ1Zy5jIGIvdGFy
Z2V0L3Jpc2N2L3RjZy9kZWJ1Zy5jCj4gaW5kZXggM2MwZmU3MDEwMS4uMjE5MTkyODc2MSAxMDA2
NDQKPiAtLS0gYS90YXJnZXQvcmlzY3YvdGNnL2RlYnVnLmMKPiArKysgYi90YXJnZXQvcmlzY3Yv
dGNnL2RlYnVnLmMKPiBAQCAtNzcsNiArNzcsMTEgQEAgc3RhdGljIGludCBhY2Nlc3Nfc2l6ZVtT
SVpFX05VTV0gPSB7Cj4gwqDCoMKgwqAgWzYgLi4uIDE1XSA9IC0xLAo+IMKgfTsKPiDCoAo+ICtz
dGF0aWMgYm9vbCBkZWJ1Z190cmlnZ2VyX3ZlcnNpb25fMV8wKENQVVJJU0NWU3RhdGUgKmVudikK
PiArewo+ICvCoMKgwqAgcmV0dXJuIHJpc2N2X2NwdV9jZmcoZW52KS0+ZXh0X3NkdHJpZzsKPiAr
fQo+ICsKPiDCoHN0YXRpYyBpbmxpbmUgdGFyZ2V0X3Vsb25nIGV4dHJhY3RfdHJpZ2dlcl90eXBl
KENQVVJJU0NWU3RhdGUgKmVudiwKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgdGFyZ2V0X3Vsb25nIHRkYXRhMSkKPiDCoHsKPiBAQCAtNjg0LDYgKzY4OSwxNyBAQCBp
dHJpZ2dlcl9zZXRfY291bnQoQ1BVUklTQ1ZTdGF0ZSAqZW52LCBpbnQKPiBpbmRleCwgaW50IHZh
bHVlKQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgSVRSSUdHRVJfQ09VTlQsIHZhbHVlKTsKPiDCoH0KPiDCoAo+
ICtzdGF0aWMgaW5saW5lIHZvaWQKPiAraXRyaWdnZXJfc2V0X3BlbmRpbmcoQ1BVUklTQ1ZTdGF0
ZSAqZW52LCBpbnQgaW5kZXgsIGludCB2YWwpCj4gK3sKPiArwqDCoMKgIGlmICghZGVidWdfdHJp
Z2dlcl92ZXJzaW9uXzFfMChlbnYpKSB7Cj4gK8KgwqDCoMKgwqDCoMKgIHJldHVybjsKPiArwqDC
oMKgIH0KPiArCj4gK8KgwqDCoCBlbnYtPnRkYXRhMVtpbmRleF0gPSBzZXRfZmllbGQoZW52LT50
ZGF0YTFbaW5kZXhdLAo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBJVFJJR0dFUl9QRU5ESU5HLCB2YWwpOwo+ICt9
Cj4gKwo+IMKgc3RhdGljIGJvb2wgY2hlY2tfaXRyaWdnZXJfcHJpdihDUFVSSVNDVlN0YXRlICpl
bnYsIGludCBpbmRleCkKPiDCoHsKPiDCoMKgwqDCoCB0YXJnZXRfdWxvbmcgdGRhdGExID0gZW52
LT50ZGF0YTFbaW5kZXhdOwo+IEBAIC03MzUsOCArNzUxLDI1IEBAIHZvaWQgaGVscGVyX2l0cmln
Z2VyX21hdGNoKENQVVJJU0NWU3RhdGUgKmVudikKPiDCoMKgwqDCoMKgwqDCoMKgIH0KPiDCoMKg
wqDCoMKgwqDCoMKgIGl0cmlnZ2VyX3NldF9jb3VudChlbnYsIGksIGNvdW50LS0pOwo+IMKgwqDC
oMKgwqDCoMKgwqAgaWYgKCFjb3VudCkgewo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIC8qCj4g
K8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAqIEZyb20gdGhlIDEuMCBzcGVjOiAiV2hlbiBwZW5k
aW5nIGlzIHNldCwgdGhlIHRyaWdnZXIKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICogZmly
ZXMganVzdCBiZWZvcmUgYW55IGZ1cnRoZXIgaW5zdHJ1Y3Rpb25zIGFyZQo+IGV4ZWN1dGVkCj4g
K8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAqIGluIGEgbW9kZSB3aGVyZSB0aGUgdHJpZ2dlciBp
cyBlbmFibGVkLiBBcyB0aGUKPiB0cmlnZ2VyCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAq
IGZpcmVzLCBwZW5kaW5nIGlzIGNsZWFyZWQuIgo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
Kgo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgKiBBbmQ6ICJUaGlzIGJpdCBiZWNvbWVzIHNl
dCB3aGVuIGNvdW50IGlzIGRlY3JlbWVudGVkCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAq
IGZyb20gMSB0byAwLiBJdCBpcyBjbGVhcmVkIHdoZW4gdGhlIHRyaWdnZXIgZmlyZXMsCj4gK8Kg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAqIHdoaWNoIHdpbGwgaGFwcGVuIGp1c3QgYmVmb3JlIGV4
ZWN1dGluZyB0aGUgbmV4dAo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgKiBpbnN0cnVjdGlv
biBpbiBvbmUgb2YgdGhlIGVuYWJsZWQgbW9kZXMiLgo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgKgo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgKiBOb3RlIHRoYXQgaXRyaWdnZXJfc2V0
X3BlbmRpbmcoKSBpcyBhIG5vLW9wIGlmIHdlJ3JlCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCAqIHJ1bm5pbmcgZGVidWcgMC4xMy4KPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICovCj4g
K8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaXRyaWdnZXJfc2V0X3BlbmRpbmcoZW52LCBpLCAxKTsK
PiArCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGVudi0+aXRyaWdnZXJfZW5hYmxlZCA9IHJp
c2N2X2l0cmlnZ2VyX2VuYWJsZWQoZW52KTsKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZG9f
dHJpZ2dlcl9hY3Rpb24oZW52LCBpKTsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBpdHJpZ2dl
cl9zZXRfcGVuZGluZyhlbnYsIGksIDApOwo+IMKgwqDCoMKgwqDCoMKgwqAgfQo+IMKgwqDCoMKg
IH0KPiDCoH0K

