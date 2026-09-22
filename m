Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79DBEC982FA
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2026 09:52:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x8x9Z-0004S6-2M; Tue, 22 Sep 2026 05:51:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=718ae7c5e=Alistair.Francis@wdc.com>)
 id 1x8x9U-0004Qj-2c; Tue, 22 Sep 2026 05:51:04 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=718ae7c5e=Alistair.Francis@wdc.com>)
 id 1x8x9J-0007SD-Ih; Tue, 22 Sep 2026 05:51:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1790070658; x=1821606658;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=BCRZupi5FeAcJJgwDoGsCdubDviEhvUlXNxVgQ2pg2Q=;
 b=nH4OdKr2HPV2RlYOwa5aNvdXAoY78e+mt34NDr1sTte/zB42F6C0T9RD
 HraCHFUWIDeyqUPEi+VJQbKM5bNHrTQ+HKxgzlV5jjqN4RZr1f0ysRunP
 Za9uFtg5Q19MSrKLx7MViNgsSUDtFmm2/r1fyTWoT8szcqDmF4itSzeCc
 V5VyY4l/itKV/ECq72Pmqv4mQdV+gHXGhdWaaW7btw9ym5UjIc87nbMuU
 qZIJfftw0+E2kbi3dTZ1/9UgoNnQ5mgu+yAjANh5Dn3khX2oJZJcQUYAU
 y7n3lw2aVippITcKB0JtHDsa9ma01bnbCtUbeOPlFUxBhdpjcQTRYl96/ w==;
X-CSE-ConnectionGUID: huF9OXcISW2P7rj9jrj0mg==
X-CSE-MsgGUID: jtWj4gsFQSGMbcWGVV5t2A==
X-IronPort-AV: E=Sophos;i="6.27,116,1786982400"; d="scan'208";a="156089036"
Received: from mail-westus3azon11012000.outbound.protection.outlook.com (HELO
 PH8PR06CU001.outbound.protection.outlook.com) ([40.107.209.0])
 by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 22 Sep 2026 17:50:55 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Lo85S1NL2dWIJvbJ5cS8TlOeGvv+qoHTEUAMJ/q9OZWvq7vn+cWptR0snvO3DzgVZsm+fAhwVIXL1jSoFr01WP5gPogO9Py4UCi+Ln5ZLiCqpHG6hlhu4OAzqhmbXCWb+pDoB+w15O4fJveCZsqMoQJdLojY3enB7DMCotXFRnnL1L0wMZm6glUlR+wPOifYwJceEJPrt74djwY9nBJzKQwJoRaRdDs+xX59xPOzUTdDpRUeKndlJ0YXhQSkm6HF32HiYXWrBxjJGR8QCetpafNxTszqkYpSUECgkNPAvQqhxlv+/3FCwmOBvC0LrBIAUi2HdvrICNQgBFut5SlMKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BCRZupi5FeAcJJgwDoGsCdubDviEhvUlXNxVgQ2pg2Q=;
 b=gJYXXPLPe/JxBFZGemPh5UPEXg7ildpSNz5tq7WgsEniBuBkAz08fOG3zjCKT7WbPQrVtU/jsrHVkLYstfOWoc9k/UT4E8E04JiLjsokYHaPCv7/LcspWAFchYc5HJz2/W6GF5mmwNeKxkjbGqpcwRSiSJSPSBf1AIjVoJ6aHM47//Ca/mfiUxxyMHLopo6uLoJ/RTVC4M1vK6C6R1L0+qOg5g9BsYMLOP5pwV25i8mIRMev0c4OHg+mYB3dvP0ZnQspcpdljvsbunQba6AMztmB67cXJa1yZGHVIsaJU+21ujTInHL4dpQWruLqBLQQSGwZFpKRb7pELA3336Ardg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BCRZupi5FeAcJJgwDoGsCdubDviEhvUlXNxVgQ2pg2Q=;
 b=HkpeOCK4fBfk/9kJQKT2tbDP5oU2tqyBthBMPILVQdnqUQBZZtmN4/QacPSC7QN2NLKCWFOCUWqxGZDNvdoZAAvBJZLm1mxK6u7I9La32xvwGhp7+jcvC2d92hfn/yxH6CZnfMenLKJ2Zm8Z1IM1f/+HVieH40T7W+nYfyPAFiU=
Received: from BY1PR04MB9561.namprd04.prod.outlook.com (2603:10b6:a03:5b6::11)
 by PH0PR04MB7176.namprd04.prod.outlook.com (2603:10b6:510:c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.13; Tue, 22 Sep
 2026 09:50:49 +0000
Received: from BY1PR04MB9561.namprd04.prod.outlook.com
 ([fe80::3869:e494:2fa8:9888]) by BY1PR04MB9561.namprd04.prod.outlook.com
 ([fe80::3869:e494:2fa8:9888%6]) with mapi id 15.21.0428.015; Tue, 22 Sep 2026
 09:50:48 +0000
From: Alistair Francis <Alistair.Francis@wdc.com>
To: "alex.bennee@linaro.org" <alex.bennee@linaro.org>,
 "daniel.barboza@oss.qualcomm.com" <daniel.barboza@oss.qualcomm.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>, "joel@jms.id.au"
 <joel@jms.id.au>
CC: "npiggin@gmail.com" <npiggin@gmail.com>, "mpe@kernel.org"
 <mpe@kernel.org>, "portias@oss.tenstorrent.com"
 <portias@oss.tenstorrent.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "chao.liu@processmission.com" <chao.liu@processmission.com>,
 "asrinivasan@oss.tenstorrent.com" <asrinivasan@oss.tenstorrent.com>,
 "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>,
 "zhiwei_liu@linux.alibaba.com" <zhiwei_liu@linux.alibaba.com>,
 "liwei1518@gmail.com" <liwei1518@gmail.com>
Subject: Re: [PATCH 00/12] tests/tcg: Multiarch tests for riscv64
Thread-Topic: [PATCH 00/12] tests/tcg: Multiarch tests for riscv64
Thread-Index: AQHdNeJa1/qTUfjzeUywIQYiUHkYxrbag+qA
Date: Tue, 22 Sep 2026 09:50:48 +0000
Message-ID: <276f8e037d139521738010615015f3df4bfb3132.camel@wdc.com>
References: <20260827050953.67184-1-joel@jms.id.au>
In-Reply-To: <20260827050953.67184-1-joel@jms.id.au>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.60.2 (by Flathub.org) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY1PR04MB9561:EE_|PH0PR04MB7176:EE_
x-ms-office365-filtering-correlation-id: 8e4c0eeb-a6af-4eb2-0d0f-08df188efaf3
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|376014|19092799006|10070799003|23010399003|6133799003|22082099003|18002099003|11063799006|10067099003|38070700021|56012099006;
x-microsoft-antispam-message-info: V6u5kcTLTpZlt4etGedlUH4YhmjqvHO6N7VqjMAVraZo1dIQqglUk70qhJMXe9CCp6ldfIw3bjpGcKY/NHTIABxV1LpbnccJC7ULfLr0pdacqulN5EoncBh6irITkiqs0KSkz3h/qL6AdY6zdMGOpi52Wbg1xzhrEcgIxfzFMCygN+cLNow5JACnUl8Zz60nyIJ8EKkdZBqfSoshilQ9P9wUxcGxN+W6Hn1JDt6k5dt96pzuV9R/2kWozDwUl7/LeAyPcTkE8W5jE0bm2EyCDOGtUw8qgMRISh/pbAsBSFXfxadsfaoRGlWG+rIs9GtDGDwAWofV6ReQqgcqKbAtNu/gg5hVrjWRfO06acKH94t/9aYr/aTDNyWXdiamCfwl1K2h4LDMHa6N+FkcXRFhul6K33TaLgFkA+ZoPnfuk8OJj6v8xZwQaBkQRsztczleg48YNNjX3rDGyCv0xFptgDMhbIN+ruhzLewWkhunguMUYCh6/BpoGTDNqLHwVMxB1Yml4ltYOZcZ3iCIK7SpvoXUGukbwV6eCC3RMA4vWwwBTbdaFsfEzk4AiP4eeQcSKiLXzcC7SWqpPB0GlPH9XB0ct712f2eVy9kP6pw5b4jEgLAGJ8QuEUwPe6mvEEMvZ0UrGgRg5KvHR+mZ120HrtMYPY5eMfHkwo3HI/eKfW9wAXB0mfVV0EQhKZmAMRmDxSrtXM2hA85ij5akYBG78w==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY1PR04MB9561.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014)(19092799006)(10070799003)(23010399003)(6133799003)(22082099003)(18002099003)(11063799006)(10067099003)(38070700021)(56012099006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dHBlS1dpd2VTNDFmaEswUGZoVnkxbmUzazVFaFRuWUxsV2lOMVFKRGVKOHg4?=
 =?utf-8?B?QndBVHlLQXJRYUlwTXhmUWg4ZnVkNHRqa2lYUWJSSS8yRDcyL3VBVmY4bHFE?=
 =?utf-8?B?YXozb296U1IwNmJ6R3RvMm15SHpFRVZndWFrY0k4eHNUbWVTNkdST2xla00r?=
 =?utf-8?B?UE4yS0pFUjBINGU2SkFTR3UzRWdJVjFzeHdtbk01ZXdyKzZna1V2STNVOUYw?=
 =?utf-8?B?UHZnSGpCSjlvaThLb3NoUlBHalk5ZmJZZXBaOWZoRFhJUUJkS2pzMEpqTWl4?=
 =?utf-8?B?eWRKZndnMUhnWGNGNG5aU2ZDeG1menI0OXVqUlpoQ2hUS1d5TG9NOGFodnVX?=
 =?utf-8?B?ZkxDWFJHSUk4NitiRHlqTWpRRTlBQ2xtWjc3WVZUMTRwOWM0bzU0SGx2NzBV?=
 =?utf-8?B?dllDaFFZQ0tSZS9MaXgxLzVjU0Z1WmR2Z2VHTVpXeHMxR3lYU3plMjBjdnRC?=
 =?utf-8?B?Y21ickhqMGhNZ3NLeEVyUW85ZDBVT0duV1VTZXZoMjBRcEYwS1pZTDAyeENp?=
 =?utf-8?B?QjJ4R2w0WGdqVmJLVndqY3Q1WEYvUnR0RFBQL3dhNWFkdHUxeWNRWjNVSE5y?=
 =?utf-8?B?dythYXJHVVBFODlhbGE4SWlYdkN1WXgyT0I3bFFGbXh3N1huWnlWL3doZDc2?=
 =?utf-8?B?ZEVlV2lzYVJCMzdGTnNHekVqZTE2RXptcTBCdFJwUlFnMWVpbDVicFZ6Z2NH?=
 =?utf-8?B?VDBsRDBWZEY3bkYrZitrQVdMaVJxL2dxNk84ZHJPbmt2dDZQYnB0YjBaZGNZ?=
 =?utf-8?B?RG1WcVpDb1lxTWU4dEh5Zm1TZ0hzcWlVbjdka3NCa0hXQkIyREhHTVlLUFRq?=
 =?utf-8?B?d0FwQTFnTXBpdUV4T3ZvQjFIODZpYkFQcXMzd2VnVHNWaDQvTVBnY09BUXVF?=
 =?utf-8?B?TjVlZytYcGU0emtZTVVGNlFCcEM0YkM4d3p4bEFZV25tSzV3bGVOaHpFS2ow?=
 =?utf-8?B?NmRjdE5SeHRTNmkyY0xlZGZKVkR2dVY0cWZibzM0c05ocmdzRk96eGhvR0xp?=
 =?utf-8?B?b1hmUVJhYlhNbkt4aFdJVHdYMFB6Q2VDSFVvUXE4ekdra2VoREszRGpDeDlZ?=
 =?utf-8?B?WEVXd3JLRTM4OUd3b0E4eVR4emUyckVpWHV0Q2xPWUJ3S043TXhQdTByMWxI?=
 =?utf-8?B?cUdEWTdML2NLcW9oZnNYNDd4VmU0M3hBZ2xkUFB3N0c1RVdobjJwWE02UHky?=
 =?utf-8?B?anR1cDFFMnFZMGNqL0IwZnZlY1pCby9haEVHZS9DK1ZUU3VFc0t4VjB6b2J4?=
 =?utf-8?B?UGIyOW9mcTN1aG5uYkN5MWM0MG5kdzR5U05iTVNQVjI4KzBWSzc3MmNXRlZh?=
 =?utf-8?B?T3RUVC9acUpsU3d3bG5kNXlUdFZSRm1hRXl6Tm5vY202VldkbGg0ZlVhVXp0?=
 =?utf-8?B?aTQ5TEgyekc2L04vMXVpRmhPYVpnMkppUUtVN0ZjcTJoS1k5T3kzQWluZFlV?=
 =?utf-8?B?S0VhNXcwSS83eWVqTWRKTkx1UTZCdTJxV05raUlsbm91ODVLa3lMV3FoZ0pq?=
 =?utf-8?B?ZjNlRTljUVZXMFJNRWt4dWRMV09ZdjlwdWtlaURoK2tBT3RaS3FOcmpVcDZ0?=
 =?utf-8?B?cDNBN0VzSlIyTGdSbFZ3aUxQZzVlWHJaVlI5dDFBSmFnazRCY3ArTnU5ZTJj?=
 =?utf-8?B?WXR5WnppNHZLelZaU3VTVTlSNFpGUFdjKzArSEErQXJOdzdFeUpmKzhONmow?=
 =?utf-8?B?N0Z0VG9Rby9WOEtlRmE0cUQxeXJlbzhBU24wTXEreXl0OEdSMThhWEYzM3Yy?=
 =?utf-8?B?a2I1RHY2Z0p3MkZLMDNXZkJhOXNRZlhpZ2ZjcHFiekZwYTRJb1lDd0RpRjhC?=
 =?utf-8?B?SS9mVzc3Z1UwNkd3dmNKRzRxYTZSSGZPYUJVS0UyamhTaUozcWoxYXF4QlVx?=
 =?utf-8?B?bkVkc20rUFpjQ3ExcTAyU1JTWFdBdDZqS1hWZk42VXBXck51OXZQU0VKY1RL?=
 =?utf-8?B?V1NGdzRUNFY4Q3dlYmNPdzdTTGZOWk90a0Uzak84OEpGUXZ0MUNBYTZDcUJy?=
 =?utf-8?B?QWR0bE9id0U1SktmY1lLNGpEcXZmS1lrTEMybDBCVnRiblB6T0F6Mm1LUW12?=
 =?utf-8?B?NC82TTh6emdQU3hla3cvdktibGJVOXNvV0FnNWRERVdvRnAzSHY5UisrSFRw?=
 =?utf-8?B?U2JCd0NXZkxzSnE4YkV1Rkxvclk1ZnlVTUVFNzMvT1I4QWpLOFpQZXZhSTkr?=
 =?utf-8?B?QWxtQ1ViWXJMWUcrNzh4WnVIMlVWbXFtcmtzV1NWcDRxY2Rua2RZdXh6MjBE?=
 =?utf-8?B?dC9PSWJXdS8yNDNFSmM4dWtRUWI1YkZraktVM0svZ0Z3RU1OZitrZ3V6eUFC?=
 =?utf-8?B?bzkrKysxT2hhaU44eExkbko5ZUNjZkgzdEMrNkc3dGo1T1ltUXkrZk9BNFBS?=
 =?utf-8?Q?t4/potCqEKxM0yDgIr3V5dy03v+EDLO0vbFl/ldEWo69a?=
x-ms-exchange-antispam-messagedata-1: o8UNS7wRiqXHGsGKx+gdmEuGThHQBPNmSkY=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A198C50BFECC8D458BD8D6F65F86F5C5@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 15Qu5D2Z/6mekfBIfTOZc5hZ7iUpxKeXiQAcIAmJXrzk5QRkTOSyJkVLymg6Ttn7BA68k/sl8Qq8httBOywuBj0S9yaR5iv31m6nLnQnB1ENT0zwXoRBIjeP+zm6nrlmRchuLxV8HcsEYi0ufmKfWzmdDf5P1bc6bURe5Q3KfmOoA3wKDm0hVS37iAEenxFUnEeIqaeNRuENsv64UWk+HGtXx0IeD6/UzZVSCTu7o+KUiXJV4nJSJbAbzc1no+cCdI1s0A7x7Wy7xaL8cz/IEmkYHEoxWCJlw7WZSBowR8G2VeostdbuF3o1RGZvoQDx3BUEOs1eRhanBv9X2EK1UQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: M3Q68KrtcN8sgUj974Q9OxccqZLqTiJ238kV5RCPwkH/vL/MmxJozGcMtbYc78qE0mIT5XmwtSFImqcVSTTrlzkPxVdhimut6jPaoGvmKkhDDej7nUnWv3yjH3nOzBeh9+Vl71QfO/aP7FVdhpN6nIqUfMFMtAa/2iUCLEPyIuRk6P51PC/52E5haSEpRRON0mBzaH3fJpzZzvdC07a3QcIQMDyfVvMvf6earJFLaAJnBzP5Qfhs2fT+fr6EnMC8TibBYKOG14HGM0hKhBYaaiOuf19DXvmwz9+sJGBja0GCOoQtREVnFxCJ2l5+2gTU2t4ObuFEtxHe3Tnd3DayK5nQX+5Q0ab4A7jrdeeHL/C+GoxHZGLskORUhs0APEiaTowUOrdsIKG4tVwh0RIWtxlY7JwaFIrMkj4G1j2fJgTBrGyyr1Q+VO1zBJBPH/LQkslsmgJ4gwJ+HNbQZYgN3DlmcrIV/2ALrfoOkhFQzDjtXOwDqm2iCP9EGNFGRdHLe/uw0wCo7D/GhQYBzwukGeecuIAEhHNZsUh1koZ8slXjfFHuie48Cn67v6MnJ378yXW8tMtxUVt/CJXCtvKbWpKXIwf55SfTlKnZ7WPUQ2Rx4h/8Iv9nLtT9mwG+aiYj
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY1PR04MB9561.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e4c0eeb-a6af-4eb2-0d0f-08df188efaf3
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Sep 2026 09:50:48.4034 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: w9vsgPqxBwT7JI5pT+h8NPTRLaD78qsy4V9iVLDyVFpsUFXHn75z2PxFHLVz7YSZcPOhiVmhrRW+zmSgigskx+4mFiXIfx1vyPg6KvBpl74=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7176
Received-SPF: pass client-ip=68.232.141.245;
 envelope-from=prvs=718ae7c5e=Alistair.Francis@wdc.com;
 helo=esa1.hgst.iphmx.com
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

T24gVGh1LCAyMDI2LTA4LTI3IGF0IDE0OjM5ICswOTMwLCBKb2VsIFN0YW5sZXkgd3JvdGU6DQo+
IFdoZW4gdGVzdGluZyBSaWNoYXJkJ3MgVENHIFJWViBjaGFuZ2VzIEkgd2VudCBkb3duIHRoZSBy
YWJiaXQgaG9sZQ0KPiB0aGF0DQo+IGlzIHRlc3RzL3RjZy9tdWx0aWFyY2guIE91dCB0aGUgb3Ro
ZXIgc2lkZSBpcyB0aGlzIHNlcmllcywgd2hpY2gNCj4gZW5hYmxlcw0KPiB0aGUgbXVsdGlhcmNo
IGFuZCByZWNvcmQvcmVwbGF5IHRlc3RzIGZvciByaXNjdjY0LCBhbmQgZml4ZXMgdGhlDQo+IG1l
bW9yeS1zdmUgYWFyY2g2NCB0ZXN0IHdoaWxlIGFkZGluZyBhIG1lbW9yeS1ydnYgdGVzdCBmb3Ig
cmlzY3Y2NC4NCj4gDQo+IFRoZSBmaXJzdCBoYWxmIG9mIHRoZSBzZXJpZXMgcGVyZm9ybXMgc29t
ZSBob3VzZWtlZXBpbmcgb24gdGhlDQo+IHNlbWlob3N0DQo+IHRlc3RzIGFuZCB0aGUgc29mdG1t
dSBtYWtlZmlsZSBpbiB0ZXN0cy90Y2cvcmlzY3Y2NC4gVGhlIHNlY29uZCBoYWxmDQo+IGVuYWJs
ZXMgdGhlIG11bHRpYXJjaCB0ZXN0cywgYW5kIGxvb2tzIGF0IHRoZSB2ZWN0b3Jpc2VkIG1lbW9y
eS5jDQo+IHRlc3QuDQo+IA0KPiBUaGUgZmluYWwgcGF0Y2ggYWRkcyBhIHZlcnkgY29hcnNlIGNo
ZWNrIGZvciB2ZWN0b3Jpc2F0aW9uIGJ5DQo+IGdyZXBwaW5nDQo+IG9iamR1bXAgZm9yIHZlY3Rv
ciBsb2FkcyBhbmQgc3RvcmVzLiBBbHRob3VnaCBpdCdzIG5vdCB0aGUgbmVhdGVzdCwNCj4gaXQN
Cj4gd291bGQgaGF2ZSBjYXVnaHQgdGhlIHJlZ3Jlc3Npb24gaW4gbWVtb3J5LXN2ZSwgc28gaXQg
aXMgd29ydGh3aGlsZQ0KPiBoYXZpbmcgaW4gdGhlIHRyZWUuDQo+IA0KPiBKb2VsIFN0YW5sZXkg
KDEyKToNCj4gwqAgdGVzdHMvdGNnL3Jpc2N2NjQ6IEluY2x1ZGUgc3RkaW50LmggaW4gc2VtaWNh
bGwuaA0KPiDCoCB0ZXN0cy90Y2cvcmlzY3Y2NDogQ2xlYW4gdXAgc2VtaWNhbGwuaCBpbmxpbmUg
YXNtDQo+IMKgIHRlc3RzL3RjZy9yaXNjdjY0OiBCb290IHNlbWlob3N0IHRlc3RzIHdpdGggLWJp
b3Mgbm9uZSAta2VybmVsDQo+IMKgIHRlc3RzL3RjZy9yaXNjdjY0OiBVcGRhdGUgc2VtaWhvc3Rp
bmcgbGlua2VyIHNjcmlwdA0KPiDCoCB0ZXN0cy90Y2cvcmlzY3Y2NDogUmV3b3JrIHJ1bGVzIGZv
ciBzZW1paG9zdCB0ZXN0cw0KPiDCoCB0ZXN0cy90Y2cvcmlzY3Y2NDogRW5hYmxlIG11bHRpYXJj
aCBzeXN0ZW0gdGVzdHMNCj4gwqAgdGVzdHMvdGNnL3Jpc2N2NjQ6IEVuYWJsZSBtZW1vcnkgcmVj
b3JkIGFuZCByZXBsYXkgdGVzdA0KPiDCoCB0ZXN0cy90Y2cvYWFyY2g2NDogRG9uJ3QgbGVhayBt
ZW1vcnktc3ZlIENGTEFHUw0KPiDCoCB0ZXN0cy90Y2cvbXVsdGlhcmNoOiBGaXggdmVjdG9yaXNh
dGlvbiBvZiBtZW1vcnkgdGVzdA0KPiDCoCB0ZXN0cy90Y2cvcmlzY3Y2NDogRW5hYmxlIHZlY3Rv
cmlzZWQgbWVtb3J5IHRlc3QNCj4gwqAgY29uZmlndXJlOiBQcm92aWRlIE9CSkRVTVAgdG8gdGhl
IHRjZyB0ZXN0cw0KPiDCoCB0ZXN0cy90Y2c6IENoZWNrIHZlY3RvciBtZW1vcnkgdGVzdHMgY29u
dGFpbiB2ZWN0b3Igb3BzDQoNClVyZ2ghIFRoaXMgaXMgYWxsIHJldmlld2VkL2Fja2VkLCBidXQg
Y29uZmxpY3RzIHdpdGggdGhlIG1lc29uIHRlc3QNCmNoYW5nZXMuIERvIHlvdSBtaW5kIHJlYmFz
aW5nPw0KDQpTb3JyeSA6KA0KDQpBbGlzdGFpcg0KDQo+IA0KPiDCoGNvbmZpZ3VyZcKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
fMKgIDExICsrDQo+IMKgdGVzdHMvdGNnL3Jpc2N2NjQvc2VtaWNhbGwuaMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIHzCoCAxMiArLQ0KPiDCoHRlc3RzL3RjZy9tdWx0aWFyY2gvc3lzdGVtL21l
bW9yeS5jwqDCoMKgwqDCoMKgIHwgMTEzICsrKysrKysrLS0tLS0tLS0tLQ0KPiDCoHRlc3RzL3Rj
Zy9yaXNjdjY0L3N5c3RlbS5jwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHzCoCAzMCAr
KysrKw0KPiDCoHRlc3RzL3RjZy9NYWtlZmlsZS50YXJnZXTCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCB8wqAgMTAgKy0NCj4gwqB0ZXN0cy90Y2cvYWFyY2g2NC9NYWtlZmlsZS5zb2Z0
bW11LXRhcmdldCB8wqDCoCAzICstDQo+IMKgdGVzdHMvdGNnL3Jpc2N2NjQvTWFrZWZpbGUuc29m
dG1tdS10YXJnZXQgfCAxMzQgKysrKysrKysrKysrKy0tLS0tLS0NCj4gLS0NCj4gwqB0ZXN0cy90
Y2cvcmlzY3Y2NC9ib290LlPCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHzCoCAy
MyArKysrDQo+IMKgdGVzdHMvdGNnL3Jpc2N2NjQvc2VtaWhvc3QubGTCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgfMKgIDQ3ICsrKysrKy0tDQo+IMKgOSBmaWxlcyBjaGFuZ2VkLCAyNTEgaW5zZXJ0
aW9ucygrKSwgMTMyIGRlbGV0aW9ucygtKQ0KPiDCoGNyZWF0ZSBtb2RlIDEwMDY0NCB0ZXN0cy90
Y2cvcmlzY3Y2NC9zeXN0ZW0uYw0KPiDCoGNyZWF0ZSBtb2RlIDEwMDY0NCB0ZXN0cy90Y2cvcmlz
Y3Y2NC9ib290LlMNCg==

