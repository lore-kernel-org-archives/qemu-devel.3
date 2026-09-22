Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 390BEC982E6
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2026 01:18:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x8p8E-0006zQ-M1; Mon, 21 Sep 2026 21:17:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=718ae7c5e=Alistair.Francis@wdc.com>)
 id 1x8p8D-0006zC-8w; Mon, 21 Sep 2026 21:17:13 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=718ae7c5e=Alistair.Francis@wdc.com>)
 id 1x8p8A-0001Gf-5e; Mon, 21 Sep 2026 21:17:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1790039830; x=1821575830;
 h=from:to:subject:date:message-id:references:in-reply-to:
 content-id:content-transfer-encoding:mime-version;
 bh=z2gnNNRn1Wit/RQY9v45ITsTWqA0+TUeor/os3ptd68=;
 b=ppuBJuUnHwitO7pWI7+y58kB66ObnyXxZkafd7stL4E6rSy8mzZ6SNJY
 ndYYKbWCkMGyHy23MACIGCerxfkZSlnokv/IM3phcx7Qp7XOtcxQkDPjt
 F+Jo9PaSOnG35VPOOXiF1A9PGO1ATtkJ68aKzXPzFeQjQ8aeCcN0ZBNiC
 h/0AGgNnXbw6WJca7HpeL3kKlh4yrN36EDGHvEa0v00lQ+8UqAJ/wTiv8
 e2kPOYuEF6q744FT0LKfpErFUjwAAIRbzYUGqMCyGVmOdjUCbneWCkF6M
 bkFCI9MAvz9u2IAr2M9p4/pgxM5PA1hFVeetKOCrWsCat+wb0WVOgIAZJ Q==;
X-CSE-ConnectionGUID: nRb8y7cpT9afsKZh/iCAKg==
X-CSE-MsgGUID: c0dgBhNVREWW5HsT3G2GXQ==
X-IronPort-AV: E=Sophos;i="6.27,115,1786982400"; d="scan'208";a="152008025"
Received: from mail-eastusazon11011021.outbound.protection.outlook.com (HELO
 BL2PR02CU003.outbound.protection.outlook.com) ([52.101.52.21])
 by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 22 Sep 2026 09:17:06 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TQWXD1CLUVKZseTl8RHTrSMF44IzfZSYylKLBPBh1WSZr32VwvN55rqjxgsMCAGhJ/ZDG4uzHhe50pucYxxKFyH808YwqGg0RB5V1U5aFTgqJ5d/RFZwWPBFux/UyOYGA995wLm30NrenLFwKYnsxkSh+eETc+H2wmBh7b8Z55XpgCsfdypHGmDUlEY1BkvzVTPb9RnVKjzQThYMPruaWUiF8Ok8Ngo+L6yj4E4nmA/mUDl/e5xb6woKl+eYikeO+66dmUlnXiynFFa3bVbzcqv5IUmo4mzEshsjLYkesg7XxCvVfojmE8Ru8bX1aDVVffpw8tzjdBA2HQFoZa+CZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z2gnNNRn1Wit/RQY9v45ITsTWqA0+TUeor/os3ptd68=;
 b=bPDoV8M7CcDahF0W/XshaHRgeYmFxAv6YxddOOSJNjs3KJwWAQaH5RK3r0jhmQo2W8cbSSSUCVovU4sbtwZ+PEnZlQlyjhxBoUnlKyds3LNMsQc5bgcBUt63xlQICgM61ugLUuJ1AiJkfTs/tm82epJUrp3s811D2AempUatkox1AlsxsfQ6MW7E+a1BWixTuHM+Bvs2NVK0Xv8yZcfXs9C2A6ku/1/sc3yFHi4u3UPTc1jHZTSj3Hu10lSK+vt6mFw8cUQ4WnBoVndZYjGpo5J9M5gkayCsb4pke/Uv85rNLCessBXtbp/NjjsAyzH8eDelmSvz3uOmqZ9JpPBtkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z2gnNNRn1Wit/RQY9v45ITsTWqA0+TUeor/os3ptd68=;
 b=zPCUzHuvMT/WCUepuJrFh+PNE7bLrc23JxIfPp/vD03bXhAGif2vs/uX+d2TFnaM0xaKPSECUdQljK/Dv14Hu4NRzxvkcugkpi3LEFzcdR1TVUxLq21Imh/YueRL/WyP4+++l5yxo9XVC/Fsl9mgSUmxmWNKL/d4AbBWatuTAzI=
Received: from BY1PR04MB9561.namprd04.prod.outlook.com (2603:10b6:a03:5b6::11)
 by PH0PR04MB9901.namprd04.prod.outlook.com (2603:10b6:510:38e::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Tue, 22 Sep
 2026 01:17:04 +0000
Received: from BY1PR04MB9561.namprd04.prod.outlook.com
 ([fe80::3869:e494:2fa8:9888]) by BY1PR04MB9561.namprd04.prod.outlook.com
 ([fe80::3869:e494:2fa8:9888%6]) with mapi id 15.21.0428.015; Tue, 22 Sep 2026
 01:17:04 +0000
From: Alistair Francis <Alistair.Francis@wdc.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "daniel.barboza@oss.qualcomm.com" <daniel.barboza@oss.qualcomm.com>,
 "christianslima@proton.me" <christianslima@proton.me>,
 "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>,
 "chao.liu@processmission.com" <chao.liu@processmission.com>,
 "zhiwei_liu@linux.alibaba.com" <zhiwei_liu@linux.alibaba.com>,
 "palmer@dabbelt.com" <palmer@dabbelt.com>, "liwei1518@gmail.com"
 <liwei1518@gmail.com>
Subject: Re: [PATCH v3] target/riscv/tcg: svinval instructions raise virtual
 instruction
Thread-Topic: [PATCH v3] target/riscv/tcg: svinval instructions raise virtual
 instruction
Thread-Index: AQHdQioINeeryB2EoUapYfx3kIWmU7bZ29KA
Date: Tue, 22 Sep 2026 01:17:04 +0000
Message-ID: <e50a1d8f5169d6bdaa67397cf804dba24bd6b54a.camel@wdc.com>
References: <20260911201323.37757-1-christianslima@proton.me>
In-Reply-To: <20260911201323.37757-1-christianslima@proton.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.60.2 (by Flathub.org) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY1PR04MB9561:EE_|PH0PR04MB9901:EE_
x-ms-office365-filtering-correlation-id: 00e98d9d-c030-4ade-b194-08df18473674
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|366016|10070799003|19092799006|1800799024|376014|10067099003|56012099006|6133799003|3023799007|11063799006|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info: R6HDkrUriwDcUoaFZXvRhTL0WJZJHJ8jeHV+cFFe1zL9bA+F89qxh+46RwOWkPokC55X7yBqRUV89Fc20wKro13/lrcJapsK3FaOTO294mjetgRFra237RW8ZRMOHTkHU3574BzfMcmFwursfPbCCcuMFKp7e99r7IoQTiQXP73U81OVMzvOOLQmcyQo1D11cbHtFzNdVUvBj4Xm6mpU2wc/IlM/YRuh98OzuiMmWtiYuefxBEcmXQzoe5//FIe8iLSqlcGyOLSX8kObPX1YIVljBc0832HZcE8RUnZZ3/dRREVasT+s6+WT14Vgh3LfPSznMt30ufQQ5I/8og0+bloWi8aVdygaW1p4Oqhx1GQwBSWdkQI1cVY+36DuikRzfS/FE8naoNJXu+tfnEQkQ4ZrhxQpebS05WM5Bp80Q2V79Cmr2qaYEUs5126OTsZ4hk1IIB2938kVYPNg9cEEpF4Tqqq6axu8L9P8wh6jRGODblo0AxREJ25nfYyb7+xy7iA1Dwetpm23owNb2hSK/Pi22kNRm5JsEWogsyILoTOQaerUo3rerdbwL9mQdfB1U5eCNkSyEnE7ra29RptPVomiUx7dR/zVXhJG/5rc7nKwEl/iwV474597dIykCqdj4v3pBjFbGniEUrWt2HiZL6bUft1if7d3fUBtUqcIV+l9lpgAvgGIL5tKDCyCdKDk3ajKmSJp7KhggC6mOX+HfFID9nVmVD+YnS8A4BRT3Lw=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY1PR04MB9561.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(10070799003)(19092799006)(1800799024)(376014)(10067099003)(56012099006)(6133799003)(3023799007)(11063799006)(18002099003)(22082099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UmU3ZkMxcEF2NkRVSU4vSjZheHA5VXdZQzRUY3dCZW5pTU1jM0JXL2pJSXdL?=
 =?utf-8?B?UjIzUTlZd3RldGF6TmNaa2dOa29idmJIQUo3YmU1ZlBUU294akVhSFB2OHdK?=
 =?utf-8?B?R0FtbzlZeFVZSkpCMmtVZTBweFdQSE9LSVBPMU9Ca1VJb1VITzRWVHlvTzNq?=
 =?utf-8?B?QU1yMU4yRzRRNEFUVDd1bmplZW5IdjdqeWhpNlFmUk9wNWZ1cU1WMFd4SVhk?=
 =?utf-8?B?dEg0c3pPMHlSanJRWkZVMEorc2VkQ21ZNS91TTFVK3IwdjNPYWJMR3lwSzFD?=
 =?utf-8?B?Z09FcEZ2RnJmeHR2Z2phWXM5L3lIZ2FybU9XNXQyS1ljOGI1MXlROWV3WEs5?=
 =?utf-8?B?NDNvb1pEdGJKbVRFMDlRaGF2THpHaitYcEI5MTJ0WTdqanE5OVllbldrMC9h?=
 =?utf-8?B?RkJqV2UxUWVvdGphRlcxbSt5UEIyeVB4SERKbFV1NEsyUllUMlVsSjlBdjBm?=
 =?utf-8?B?cjM5K3dGZlNEOVFPbzZxSVp3blBrOWlvQitpOWhRLzk3UVF4Ry9GaFFKYWJi?=
 =?utf-8?B?SFRTUWJsWVZzYzVoTHVlMUgwMnZXaXFGaVQwcFViZmowRVRtRk1NcTc1cXBG?=
 =?utf-8?B?TWkzWGhpSlAxRSswT1Q3VG8ycnRvU1daNnpmK0wxVXFtZnpqTEc5ZGlndnpZ?=
 =?utf-8?B?cWRKd1VlSCtzaWhiZEhMMGdwM21UR1dRNncySDRSaXBKMGdMY3ExdGtQNndB?=
 =?utf-8?B?SVg3S1Nack9OR3hNNlVBdUdqTmo3dUZFRHhqOTJWSisrNDM4dFF4K3ErenNz?=
 =?utf-8?B?enNHVzNrdDYxRllBWE5IUXljTFArcVQyU0thR3FKNnFnL1lQSC9XOERCM2N3?=
 =?utf-8?B?VTY0ellKYUZXazVBOFRhbElHWWhLK3NBeWZWUFNtY2doVGgwcHB2QXNGVi9h?=
 =?utf-8?B?bjYvM0trVFFXUllKR3d5QTl1OUxTQ3ptNEhJQVNTZFFHRzhYTWxmdGVYQjFP?=
 =?utf-8?B?NXhJOHF3U0liVUIyMGhtYllLc0FuOCsvdmU2bGNzNWs3MXdkSDVJbENnR0oz?=
 =?utf-8?B?eUtZWEQyL0U5RlBDZlppVUJ4Q0hMcGRLbC9uVzFVby9mcDhyZ1c3TTJLQlVh?=
 =?utf-8?B?LzFzMzVSVWErZ2Z3UlZKRFdUNWFNZjhnZWpHS2E5ZUlRMlJuek9VNFJiSmJj?=
 =?utf-8?B?YnY4dTRUYkx0QlhDQVduQ0R6U2lxTW9GVUZoblZPUWtUNGhKYVlCZmFTbCs0?=
 =?utf-8?B?QlR0dktGVDhQN3BDb0M5OERvVXp6eVpsKytTdmN6cHR2S2RuckhobENETnZ0?=
 =?utf-8?B?OGYxc1pxR0lIcWdJM1l0aG5pWGFKajdST1RPV1VMTnpiUzVDVWE0Q0tNNVk0?=
 =?utf-8?B?Qjh2YkpIaUpRbnRFTEJoUXNyM0FobW9KVUpIODVCSlNGYVpiYVJtZTBhbFlj?=
 =?utf-8?B?aHN6eTVueFo2dFQzMmg3a002T3dvNFVPVUJxdUEyTXprMlIyMlN3RG51SmVP?=
 =?utf-8?B?UXlSOG9uTDE1YUJYaGJtZ3kxMlNld1VFa0kvSkhFMHhEM3BhbnozS1o1Ung2?=
 =?utf-8?B?SVF3TW5nYmk0c0JQNlVZb1Q2c0NndENob1h4Z1doQ01qc1g1ck96VUtpVzM4?=
 =?utf-8?B?V2k4RVl6b2ZUQ1A4dHBrVVFGamJGUlozLzBQSTk2YXFxenlNQnkzWmd5eWNU?=
 =?utf-8?B?aWxVSDJxVTFZcDdtZThiYnNqMDNkeWFqbTZ2b3N1RkVjZncvWmdqMzJKNUlO?=
 =?utf-8?B?bGNIYWkwMDFHdllBVjJIK2RwdjdVNVJoSzg4RUxySVRCQWtsWnV3cTlndTZC?=
 =?utf-8?B?ZzROK0xWSzhnZnNCZG8yUGtKSERtdzJMOEVvbVhnQkJQR2Evczg2d09GV0pT?=
 =?utf-8?B?RlRoOGh6UVJkcjBTSG1ORXVXbDJqSUZMQng0VWRRcnJ1VXdGUjdmcUd0Si9l?=
 =?utf-8?B?bEpWais2dWxsOFlVQnNMMXdQUjdxM1o5dUVpdzRHYUZTVG5YcFVRZ3I1ZGZ6?=
 =?utf-8?B?M0NHZC92T1FSMWdMU3Z6NnhDek41UnZzN2NkL2VRUEwwVWtJYkpFRFpKWVFn?=
 =?utf-8?B?TXNJNEhyWlpSdDZVQk1BR3N5bXpGc3BHdWpVR1dJWTFIYncvb0IwQlUrR1pH?=
 =?utf-8?B?bkpOWWZIQk9iUmtQbXhYVjIyakF4T3lVRktVQUhzdmROQ1dmT1F2L0NaQzBI?=
 =?utf-8?B?S1FJYUt3dWVkeTducFIzM1hFamtHaFp4aktIeTM2UWhlcHdQRHdEVjRZN2c2?=
 =?utf-8?B?QVZCaEJMRkZmTjZVd3c2b3dBZTBWbDVxUGJZdWVuKytHQmxBVkEzU0QySnFh?=
 =?utf-8?B?Ukx4UE5JUmhqcjgyTlcwamdWd3FIS2Z5VHlNZHU4Vi9kdTF5VmR5Vmt4NWla?=
 =?utf-8?B?UVpPNVovODR1T2hDTHRCajRiZDFoSTEyUmlodjZZTkZGL0xRZ3JKT3BDOEph?=
 =?utf-8?Q?ayZJGifbwed1AP1radYyZK+0jalPVq8WUbosC040t6uKC?=
x-ms-exchange-antispam-messagedata-1: g62HAKZOrV/a4Um+/Cim5J8h8zXHINGQV0M=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4B3E08EAD9E47C4C8D9C2154AE9D925A@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 4MXnh93f33PmCSenl2Y+NQb198FL+eTogwaVb6p5q2UZ/icTE/EVF6dW+KgdJVz2gNMe3QGZBTjvBqCyTEVwEk5tCAHWstOlPSlzfjld1tFDVgE7QOo148vDuoxzJvaRU6kte4lDF/ULyOxpF/MEWYVxcbpKqPsQNSY1r/iSOvOrQftDjwlAiQSXKjrVIrzeNcrBzBGbKEjpLYV3t0CSIUGAPcmcoN4kxyeSCj1HKKr+fhVJho1CXIA0NAoivVeFHyr03oeK0ZQvMgpM5RQ6F9oaXqiP5L0Oo6mVlVxT82JCsL1xHGCUVmASLCfPdjl7HoyVOgv0uIh3dJnNGt0AKA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 9XeDZxFnEryQ9H5LzimTscq9QbM+teiYsS3kmiNtuu+j7+3cnnJVxbH1usRh8OabRbK+l7uGlNzpqno9RJHeH0I5Sa4sHcmsXpWp0RyT2QeACXcsiuyD0ywe3xV9kjYWRtrNM4fsc5JCZyfnPrqAEafIzvHyrvICPaMFsVp3Oo608agS0AhTB86mu63j32shvSj8f+n1iT3oVAOm54XbocMTLFEMHQ6oowlw3fUs0BUKbgNGjn+qsbvOFtBJ9N9asI/HSd5gfdsgEYRrpRBsMnGSaJey6e3gdTLsTc2WdK7LmXwxOYNz/HYnmlytetXymJ9iAXmI2b1DgGLrRK/wpp6LIrRkLa7ypOw4wJ08HPaXl1qzqHZ99Gh4wmQtnfOkPRdJVeO3NHNKznytfG5Ja6GwIGYU3PbWBEq3Z+zXDDo8LuND7yrZj2A+9YNPQU34PaXFxsbJks/ZlCEQ352nrWxkeQZT1fVpToLlqLkpxJYkUrsYIkzfrXavvKD+I/SHrw0TJ1WixNPK/bOecpXxW8N5sa0DmwsSIfuq8S08L8F+e3Zik8q0vkIHisSUpEF6a7qWn5fcEDw1PvZ45yuB5wOwOZ7Iao9emE/6hwS8TH7k+wceE9M/qrqBRTX6cE3k
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY1PR04MB9561.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00e98d9d-c030-4ade-b194-08df18473674
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Sep 2026 01:17:04.4811 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AES71ttRDzkuf4MnVNfwR+QM45NHMKem8N6CWGRoZKJHYTzE4Ecupzi+nvM1XLt0GmdGsJh5Zz0hVkLJ3OokqzJnxwToGtHThMKgUoIGh5A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB9901
Received-SPF: pass client-ip=216.71.154.42;
 envelope-from=prvs=718ae7c5e=Alistair.Francis@wdc.com;
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

T24gRnJpLCAyMDI2LTA5LTExIGF0IDIwOjEzICswMDAwLCBDaHJpc3RpYW4gUy4gTGltYSB3cm90
ZToKPiBUaGUgcmlzYyB2IHByaXZpbGVnZWQgc3BlY2lmaWNhdGlvbiByZXF1aXJlcyBoaW52YWwu
dnZtYSwKPiBoaW52YWwuZ3ZtYSwKPiBzZmVuY2Uudy5pbnZhbCBhbmQgc2ZlbmNlLmludmFsLmly
IHNob3VsZCByYWlzZSBhIHZpcnR1YWwgaW5zdHJ1Y3Rpb24KPiBleGNlcHRpb24gd2hlbiBleGVj
dXRlZCBpbiB0aGUgdnUtbW9kZS4gVGhpcyBwYXRjaCBhZGQgdGhlIGNoZWNrIHRvCj4gcmFpc2Ug
dGhlIHZpcnR1YWwgaW5zdHJ1Y3Rpb24gZXhjZXB0aW9uIHdoZW4gaXMgaW4gdGhlIHZ1LW1vZGUu
Cj4gCj4gY2hhbmdlcyBpbiB2MzoKPiAtIEFkZCBtaXNzaW5nIHNlbWljb2xvbgo+IAo+IGNoYW5n
ZXMgaW4gdjI6Cj4gLSBSZW1vdmUgdGhlIHdyb25nIGByZXR1cm4gdHJ1ZTtgIGZyb20gbWFjcm8K
PiAKPiBSZXNvbHZlczogaHR0cHM6Ly9naXRsYWIuY29tL3FlbXUtcHJvamVjdC9xZW11Ly0vd29y
a19pdGVtcy8zNjIxCj4gCj4gU2lnbmVkLW9mZi1ieTogQ2hyaXN0aWFuIFMuIExpbWEgPGNocmlz
dGlhbnNsaW1hQHByb3Rvbi5tZT4KClRoYW5rcyEKCkFwcGxpZWQgdG8gcmlzY3YtdG8tYXBwbHku
bmV4dAoKQWxpc3RhaXIKCj4gLS0tCj4gwqB0YXJnZXQvcmlzY3YvdGNnL2luc25fdHJhbnMvdHJh
bnNfc3ZpbnZhbC5jLmluYyB8wqAgMyArKysKPiDCoHRhcmdldC9yaXNjdi90Y2cvaW5zbl90cmFu
cy90cmFuc194dGhlYWQuYy5pbmPCoCB8IDEyICsrKysrKystLS0tLQo+IMKgMiBmaWxlcyBjaGFu
Z2VkLCAxMCBpbnNlcnRpb25zKCspLCA1IGRlbGV0aW9ucygtKQo+IAo+IGRpZmYgLS1naXQgYS90
YXJnZXQvcmlzY3YvdGNnL2luc25fdHJhbnMvdHJhbnNfc3ZpbnZhbC5jLmluYwo+IGIvdGFyZ2V0
L3Jpc2N2L3RjZy9pbnNuX3RyYW5zL3RyYW5zX3N2aW52YWwuYy5pbmMKPiBpbmRleCA0NjE0YzE0
ODljLi4xMzQxYmViYTJmIDEwMDY0NAo+IC0tLSBhL3RhcmdldC9yaXNjdi90Y2cvaW5zbl90cmFu
cy90cmFuc19zdmludmFsLmMuaW5jCj4gKysrIGIvdGFyZ2V0L3Jpc2N2L3RjZy9pbnNuX3RyYW5z
L3RyYW5zX3N2aW52YWwuYy5pbmMKPiBAQCAtMjUsNiArMjUsOSBAQAo+IMKgLyogVGVzdCBpZiBw
cml2IGxldmVsIGlzIE0gb3IgUy4gKi8KPiDCoCNkZWZpbmUgUkVRVUlSRV9QUklWX01TKGN0eCkg
ZG8ge8KgwqDCoMKgwqDCoMKgwqDCoCBcCj4gwqDCoMKgwqAgaWYgKGN0eC0+cHJpdiA9PSBQUlZf
VSkge8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIFwKPiArwqDCoMKgwqDCoMKgwqAgaWYgKGN0
eC0+dmlydF9lbmFibGVkKSB7wqDCoMKgwqDCoMKgwqDCoMKgwqAgXAo+ICvCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIGN0eC0+dmlydF9pbnN0X2V4Y3AgPSB0cnVlO8KgwqDCoCBcCj4gK8KgwqDCoMKg
wqDCoMKgIH3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgXAo+IMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuIGZhbHNlO8KgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBcCj4gwqDCoMKgwqAgfcKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIFwKPiDCoH0gd2hpbGUgKDApCj4gZGlmZiAtLWdpdCBhL3RhcmdldC9yaXNj
di90Y2cvaW5zbl90cmFucy90cmFuc194dGhlYWQuYy5pbmMKPiBiL3RhcmdldC9yaXNjdi90Y2cv
aW5zbl90cmFucy90cmFuc194dGhlYWQuYy5pbmMKPiBpbmRleCBmNGUzMDUxMDAwLi5lYTRiMTY5
NDIyIDEwMDY0NAo+IC0tLSBhL3RhcmdldC9yaXNjdi90Y2cvaW5zbl90cmFucy90cmFuc194dGhl
YWQuYy5pbmMKPiArKysgYi90YXJnZXQvcmlzY3YvdGNnL2luc25fdHJhbnMvdHJhbnNfeHRoZWFk
LmMuaW5jCj4gQEAgLTI2NywxMSArMjY3LDEzIEBAIHN0YXRpYyBib29sIHRyYW5zX3RoX3RzdChE
aXNhc0NvbnRleHQgKmN0eCwKPiBhcmdfdGhfdHN0ICphKQo+IMKgI2RlZmluZSBSRVFVSVJFX1BS
SVZfTVNVKGN0eCkKPiDCoAo+IMKgLyogVGVzdCBpZiBwcml2IGxldmVsIGlzIE0gb3IgUy4gKi8K
PiAtI2RlZmluZSBSRVFVSVJFX1BSSVZfTVMoY3R4KcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgXAo+IC1kbyB7wqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCBcCj4gLcKgwqDCoCBpZiAoY3R4LT5wcml2ID09IFBSVl9VKSB7wqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgXAo+IC3C
oMKgwqDCoMKgwqDCoCByZXR1cm4gZmFsc2U7wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIFwK
PiAtwqDCoMKgIH3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCBcCj4gKyNkZWZpbmUgUkVRVUlSRV9QUklWX01TKGN0eCkgZG8ge8KgwqDC
oMKgwqDCoMKgwqDCoCBcCj4gK8KgwqDCoCBpZiAoY3R4LT5wcml2ID09IFBSVl9VKSB7wqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgXAo+ICvCoMKgwqDCoMKgwqDCoCBpZiAoY3R4LT52aXJ0X2Vu
YWJsZWQpIHvCoMKgwqDCoMKgwqDCoMKgwqDCoCBcCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
Y3R4LT52aXJ0X2luc3RfZXhjcCA9IHRydWU7wqDCoMKgIFwKPiArwqDCoMKgwqDCoMKgwqAgfcKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCBcCj4gK8KgwqDCoMKgwqDCoMKgIHJldHVybiBmYWxzZTvCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgXAo+ICvCoMKgwqAgfcKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IFwKPiDCoH0gd2hpbGUgKDApCj4gwqAKPiDCoCNkZWZpbmUgTk9QX1BSSVZDSEVDSyhpbnNuLCBl
eHRjaGVjaywgcHJpdmNoZWNrKcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBcCg==

