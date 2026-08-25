Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E970AC5B572
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 04:38:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyiud-0003bA-Mx; Tue, 25 Aug 2026 00:37:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=690dc056c=Alistair.Francis@wdc.com>)
 id 1wyiuc-0003ar-1K; Tue, 25 Aug 2026 00:37:26 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=690dc056c=Alistair.Francis@wdc.com>)
 id 1wyiua-00067T-3e; Tue, 25 Aug 2026 00:37:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1787632643; x=1819168643;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=EjkQWFs3Ckk7yqNYPWOPQyT2shz677yKsIjfyq74Kpw=;
 b=i+49eCK6uefaL5YpBkD2nL9g+pQ2AXtq7+peMMFZ1gLJVPhah9QgBIiy
 k6PYm+RnHhqKGwXq8QX4rCxrQvWUqM6S+zP5U2NYxB6ePTL/P12R+x5Ye
 bxbBJ8zOJzTSFPLilrKCOcew+8okaryb60L9BrB5peJIlYKqLCFptGP0h
 QChC2shihz6Xo4evH9kTB9J56+aebdeRMkY9F/6XXEZ8NZYz6QeKzCI+l
 iXbC0KFYZuy3RV9lP4fNWKlzWJH1I4xBsGDAFgqoc1X2oMPGt3up7T2Ep
 7G9hxQYRjjWJOyedX+S52xykvnAMbcb/rTmvh4qF5DXpL6XvnU6CNXpF8 Q==;
X-CSE-ConnectionGUID: CV+8tmivS36lKVvgsWZVSQ==
X-CSE-MsgGUID: g0WL2L0gT2Oa7IxGKL5owA==
X-IronPort-AV: E=Sophos;i="6.25,242,1779120000"; d="scan'208";a="152629300"
Received: from mail-eastus2azon11011048.outbound.protection.outlook.com (HELO
 BN8PR05CU002.outbound.protection.outlook.com) ([52.101.57.48])
 by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 25 Aug 2026 12:37:20 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Py5EUWUC1szZAsH38GyP5T+dm53WSfiRZsx7YuoaawTz8fkevOol4k/dY7PAmdj8OIIq1IBVyU2V8T0Rew+VLSE+6Lze7FZC2z3tH0x0KqmRy67uBmY9WxRaD4E1A9lGSOwgka+bA40uIUaYa9nc9VzdtWGRpCdXK0tCFJ00mB4d2413X3asFgZSMez+LqWImq5uV91GnYZGYKmFpTT+2r6ygKuloPtKCGS4fJkE9bxAoHJ76OX70nipCTMo1AhTs7ck8KE8EQy2PyxOBUUpPd4zbfR6gwjPOs5X82NnZjIU9v3loyyq/e7s85poG9D1DaWkm4SeIaJ3GHe3r9ngBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EjkQWFs3Ckk7yqNYPWOPQyT2shz677yKsIjfyq74Kpw=;
 b=KztZt0qTNQyrn9+eZOVBVfUBfF+pQLkQaNAKmC3GCF8hlom4eBTsceyQ/gepEbYjvn+b3qb939u2RZRfBF/7je4UPMhoZDkhCJ+G0mpk5x7EOYJZ9RwRurioMXmo0fo9buC493620sSAjk8DHTRetmmfe6SIFNgbcPFYcGeCZQHfDcxnh/v30PCT6fZ+LX4BllqbdyJzPNrwAQ6nyXnyThbZew3d4ADzcb38N7hf69PYBrfKRwsxIu38EQazjJWjzO/ZV4a+dkIKCJHbTSiEilPYk50GiZvevB/H66UoPg54o73lVbQNgoDMN0O5K+9yu2QgS9/z7cO26vFHQzeP7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EjkQWFs3Ckk7yqNYPWOPQyT2shz677yKsIjfyq74Kpw=;
 b=ZQd8ERejcfv3c2RAxjF12Mskpqu9AaZukB/YrANjjgXvGDMl2KlBdTnmZ7FHdHAkI4QtswgtgbKgutTfFkTBXk59COvwPRz0a8MMQMzmCwH/xB0YMpWLvo4fi0KREBn4x3977fXeS4Jw4SeGbbbY7HQddr7XMu8aPTRpEgH0kxI=
Received: from BY1PR04MB9561.namprd04.prod.outlook.com (2603:10b6:a03:5b6::11)
 by BN8PR04MB6450.namprd04.prod.outlook.com (2603:10b6:408:d9::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Tue, 25 Aug
 2026 04:37:18 +0000
Received: from BY1PR04MB9561.namprd04.prod.outlook.com
 ([fe80::3869:e494:2fa8:9888]) by BY1PR04MB9561.namprd04.prod.outlook.com
 ([fe80::3869:e494:2fa8:9888%5]) with mapi id 15.21.0360.005; Tue, 25 Aug 2026
 04:37:18 +0000
From: Alistair Francis <Alistair.Francis@wdc.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "daniel.barboza@oss.qualcomm.com" <daniel.barboza@oss.qualcomm.com>,
 "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>,
 "chao.liu@processmission.com" <chao.liu@processmission.com>,
 "zhiwei_liu@linux.alibaba.com" <zhiwei_liu@linux.alibaba.com>,
 "palmer@dabbelt.com" <palmer@dabbelt.com>, "liwei1518@gmail.com"
 <liwei1518@gmail.com>, "frederic.petrot@univ-grenoble-alpes.fr"
 <frederic.petrot@univ-grenoble-alpes.fr>
CC: "julien.thillard@univ-grenoble-alpes.fr"
 <julien.thillard@univ-grenoble-alpes.fr>
Subject: Re: [PATCH v2 1/3] disas/riscv.c: Correct indent for checkpatch
Thread-Topic: [PATCH v2 1/3] disas/riscv.c: Correct indent for checkpatch
Thread-Index: AQHdFTpO506Rew3cqEi5Tng0kcYqwrZwdliAgD32AwA=
Date: Tue, 25 Aug 2026 04:37:17 +0000
Message-ID: <0c94a932dd3c82700fb14256171605ab0af5a75f.camel@wdc.com>
References: <20260716154615.1545145-1-frederic.petrot@univ-grenoble-alpes.fr>
 <20260716154615.1545145-2-frederic.petrot@univ-grenoble-alpes.fr>
 <ba4ea9a1-dd4d-4a96-aca5-1c14193420cb@oss.qualcomm.com>
In-Reply-To: <ba4ea9a1-dd4d-4a96-aca5-1c14193420cb@oss.qualcomm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.60.2 (by Flathub.org) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY1PR04MB9561:EE_|BN8PR04MB6450:EE_
x-ms-office365-filtering-correlation-id: afd12dbd-f374-4ba0-a5be-08df02628b82
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|19092799006|366016|10070799003|23010399003|376014|1800799024|10067099003|22082099003|18002099003|11063799006|56012099006|4143699003|38070700021;
x-microsoft-antispam-message-info: r7+5fdl4lSHH4GtN/aMLp9XPHssMDrIjDKqLPCGod71h4YExypUlVdtINlucEWmePjT8rcRY/eluvEXAOIWtXBaIvX8U4rEOffRT3+mEQN9vvjWaXak8JBPaVtnvW+xGkW/L6/rcGSsWqXdSNjiT7YlrRHlXLA/rcbnTkqxlYFNa0EBvc1JdMjBHhZot2qbUHFdtS8wNzGilAoXMWRVN34NTOj/Ara8HUN6yvkOECsuRbZvmJB6dvwO/qpj+EYieyhhyuAn3Uc/dLWIrAEB3omwMHF191EmQ8aTBT/5U/5iZ7aG6dEGDCcqS/d5uYz9fN+L93MuvINnUFWUii1xuqDL6kK2/2/vjSw94hava2dmeGCEfIhVjZoiFSafDVAF0QwACz1WXdf0evwGr1EJJFYXTDeBOGHvwU76rM9LEz/iaolcHi1c0FDxJ+6cF4Z2AdmQKzY9Zc0bNWGIPu/ywXQo0joKZPHhar5NOZmEhnL7DLtBWUiZPpIJU6wPeC3n3fDC5UhqzHziglMBIaoJreFmJPf0OYya57JEG0uetSddLm13hal/FGgi4mLPEeun+sDMcX68RipY2usJ3i1VDvgKIbbKvsjwzYpw7UUeWn73Ln0QkUsWz2pBUmcTN7rXAvDRH78gNPyrcIlz+o9yOVHp6hMiHluhpsb8BIfWqq6luJ9voA9DvPsD0+v+irFBcgxywB37SHkvt9Y2HbjkoTDBjvN6AWEGvVLb99lDUVJc=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY1PR04MB9561.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(366016)(10070799003)(23010399003)(376014)(1800799024)(10067099003)(22082099003)(18002099003)(11063799006)(56012099006)(4143699003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aGZSVVRSZVBVSXpNQUZGR1JaanVxMkhzN09XR2RPRTR4OFJRUko4bWNsM0Zq?=
 =?utf-8?B?Z2FXTFg3UGhBRWZUQ25qY0JtaFBueThlSGlqVzF4dE5VckxrSVlOem95cDNr?=
 =?utf-8?B?eXQwWDcxdnpZNkhEVGdtYXhvbSsyZXhIZjllSnBrT0kzWXZsWXFVYlFhbG5k?=
 =?utf-8?B?clgxbHE0OWVXVUZoV2JWRlRqTWQyZ3czaDZEVUUzRTMxRVRlcVFEVW5jQ0Ru?=
 =?utf-8?B?K21iR3REVEFLZDJvZ2s0RVN5OVNnWlJRTzJmT0hWenF2YTd2ZlBRSUNvd0Ja?=
 =?utf-8?B?YUk2a0RaTXFvWlNVNXF0ZG1YOUxCcUlBaUszUzdZcFdnVitmMUZOL0JqSS9Q?=
 =?utf-8?B?aUE1dDRUbGovY08vK3R0Vm1DRnl2U1FFb3J5WkorQ0FaUW1FbTUrN3ZSeDFC?=
 =?utf-8?B?NzNVbHhVcm5jVXVrVUIrbFMwV3Jid2JpdzQxclZzRUtKNDRNUFYrTmJYeDU4?=
 =?utf-8?B?cXNTUWxCY0NwUTIyZlpkRFhHdXdBWDV4U1lLbytTajFZNEliNVprcy9tS0pJ?=
 =?utf-8?B?RTVNSjJ5WEoxZ1JDcW1NYkNaVUsrZnlPeHU3VG1waHBNQ1VrQTluRlgzWm5m?=
 =?utf-8?B?UFRGMFBpbTNmc1dvcFpKZWk1Smw4aitYNHVBV3V4ZzVtU05McWRvbTBxODVF?=
 =?utf-8?B?TkJZZmtEcWlpeFJvWlFaMmRPZDBVV2xVUlRNM3AxdzBoYmN0QldNbnF1NjB2?=
 =?utf-8?B?eVZiT0JWbGdDL0t1UmdmcXBnWVVQb3g0UTNxSmU3ZCtXY21XOFJ3ZFA1TEQr?=
 =?utf-8?B?VklUR2xWcEw0eHZ4OXFnc2p2Q1BDaE9lL05ES3JoQ0IrMlpVbGFSRjJvdi9P?=
 =?utf-8?B?SWF0QU5oRzM2Nzd0K3Z6bi80cXpKakc5aytPZDFncVRuMW9ESXQ1SVhVNlhX?=
 =?utf-8?B?MEJsSGpDVnpLblZOVDlZMlpEdW0zc1RjSXVoWmdERVBiVmhyaWJ0OHdoVVkv?=
 =?utf-8?B?NTV5amRpdGdiS24vZlB4YUVrcmhpU1crUGFBV2ovL0ZiRHNsSVNLY2xUMEN3?=
 =?utf-8?B?dkh1K1NPL1YzZnA0RFpZS1IxVnhYN2tTT0ZHdjFpZ0NFMlN0MFQwajN1YTdz?=
 =?utf-8?B?SkVuR2hnbzlIU1RMczg0L2lPckcxRzhCeHR4SzA3Y09kMlVTalZXblVSdDNH?=
 =?utf-8?B?S2lOVFlpc2RzVkxyZGIrUmlMSHRodjRkc2dSUHczMlNaVmNDL2Z0dUNzOEdZ?=
 =?utf-8?B?V092QW9KOGJJZ2p2OTZ0dEl2WFlPZXhMdkdsSTVGb0ZIaEtJeXIwbkxKN1NK?=
 =?utf-8?B?eEhqbW1mS080R2VDdWdROWFpSS80Y1JSUE1sWDVJbnVxZ3pqYlJZT29TVFNY?=
 =?utf-8?B?REdvSVlJd0RDSUc5eDlyS3QvQ0RzT0p5WHFkVUhPMXR4N1ZpTzhDOE5iVTlC?=
 =?utf-8?B?K0FGYWs3bzhJdDlUL1kvRWpIdk5memVFZFZrWk9sTHoyKysrYytHbDRjbkti?=
 =?utf-8?B?Z1R2OFB4aXd2ZmxHeHA1THpvdWZHS0NsL0pRRlpsWkdyWG5MbGhTRlFicGV2?=
 =?utf-8?B?aXFtYmpJeFVOWHZYek4zazJXT2VWRk56MUM3Smg1eVBuUm5vYzhYeGFCNURG?=
 =?utf-8?B?aUN0bXdPblhuOTlIWHE3T3RSSkdIUmsxRFhnc2VoWmhDcUMxaFZsUnVRUEUx?=
 =?utf-8?B?R053NUdOdmx3WCswQmU4ZkVlSEpGcnlxQXRWWFVxNmU3cUtKUEw1MkJUUnJz?=
 =?utf-8?B?NkdLM3I5SnV5eU96OHdFQzliOFo5dmVtNFFpV3ZyRXJWalZ6UDA4SGhWYzdw?=
 =?utf-8?B?OThrMnFGeDQvZG9oZFdsWU1RMFNTZHZVajQzamRtcEFGQ2lUdXFuZkx4ZGpl?=
 =?utf-8?B?ZDdsR2pacnAwMS8yc0J0QjVpdDZsekI0NGRYWkMyKzFPTllFckFxUHA3VDgz?=
 =?utf-8?B?MmtrM1dnZ3RZaUtGZDlLUFNkcTFNWWtKcWZnYkNEVUo2YUdmMmZ1ejJTQWor?=
 =?utf-8?B?c0lPUzlaZEQxTXY4VXpMRnUzNWkwTEovd0tVWUVmQnRvS1BjaHczRERxblRE?=
 =?utf-8?B?cUJIQ3BJYnBZVWl0MXEweEx4VCtqMmZKWVEyRWZrU0dSS2RPLzFsbnkyMlU5?=
 =?utf-8?B?bm5nVEdpeHRpNW5IZzBQU3IycHdueldHUW1BV2N3WGxXUERIQ3VZbDlidFNk?=
 =?utf-8?B?czhwdU4zcnZkc093anRaays4L3Fjb2c2R2liYkZvNlJIWkxDV2VIWS80Z2FE?=
 =?utf-8?B?TmkxSlhpQ2h2VlFRYXJCUWFuZk1ELytqWVdaZUdoUHVocHF6RlAvTzJqRm8w?=
 =?utf-8?B?bXRjUGVDU0p1TFNHdVdEanFNMU0wT1AzL2hJSmc5Njl2MmdBUUorUU03WnIw?=
 =?utf-8?B?UWJJbDV4RC9mbHlIT3Boek4wTjgxT0FJT2g3cDBjT3BvenQzL052MWdFcUI0?=
 =?utf-8?Q?LUkda6ioRYzHYdW4KtxSJx3B1Dz3cB2IqTwXQPh7nXyjj?=
x-ms-exchange-antispam-messagedata-1: 5qPT7rd4c44dsWT9H9i9UcprtserT5ko21g=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7DD3A6A6CD2F3E4FB35F878864264FA9@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: ISzqy16p/tJQ6QnLCDYaKt1kFZNuuXl3MVR5sPJfJJvOZwuGHhVE5CV51cdtjGdgiHy1kU9/uTUHCz48vbf7F8k5NnO7KN3NvqikbgpbpnTTDk1lsVDIPR5BgzHBSlbAmYvBJFnFE2btVaDdMkjXplYoXNMoH0wEbdFxgrVsYckDWW6knIHGN/9Y5KDB/0ykKvAHt81XFFoQxAfKCdBApwONZaNjwsueiue7MATRq30pmP338Odmo1TpWca02DV4OmE3KRm0NUyREv4yECyBC4b10wqYxv20JmWmC38++9EI4swrhFJqAENVcKKthfTLfRgC25vs88q1utQrDhg8IQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: +8kdkdFLnpa6Xg92Ie5VktYsIVcLkaWmTZvMC1o0f4w4n8msJotu7u95Lp80hBZiJLZtnWlUScr+cjnjR17/cL5s8c3W9z9k3l2KE3fxWQjYQFaGhSvP6HH9WzKuHTRFokeM0r/H0g3xzUkDKWd45WPcDJ0JUhgZbtNcsgTO94ENFAfiXJUazempw4h0/bpIeJFRDlPdp304Y5f4RgxGyFwB1lOxLcpdtxN+Kcq3vHzH23kVGBUf/nP44JrRSSSRDR0du2cJB76BnDVnNpThvCiLu+de0bPTbLef1K+hk+ReK73gbqKirsmolUK/E6t7CK7Hzu+qwWAfuMWVwUWZiOO6KEtLRegszPlBDFcDjQzH8NdnLFIbgggMUHAssRECn5BXaFhWAE43ZHOSio8sp2f7CmDM6acKIo9eXrwHjKcc1ydlMpa+imazbV15bJZDy4+ZZIT9zp3zdiTlvgE8ioDLWHoXbLlU1u/y1aKuaMt0+mHHdRZKNRz3rQkjcLqIO0c+dpRBeedzSlfLpINni9NQrhlzuLOpusAxkcaZCJfGcQK9A5nir2I2NS0TbjQJ/ivgH01q5fkr4sgMOOyd33lq6Gs43uXK+BPUUa0OF8jbRKT47fAl9+K5AZ7+9rk0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY1PR04MB9561.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: afd12dbd-f374-4ba0-a5be-08df02628b82
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Aug 2026 04:37:17.9877 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7YaOxpJPeOvGZGUKawQn+tkK2mUbinbIo0lsIOmTDxRpAJt/FinkfSqfqFo2UolZUGmFaqhXzVUcyf+1QQNDPWHywaR34iCl4AMJP96HVBo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR04MB6450
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

T24gVGh1LCAyMDI2LTA3LTE2IGF0IDE1OjI0IC0wMzAwLCBEYW5pZWwgSGVucmlxdWUgQmFyYm96
YSB3cm90ZToKPiAKPiAKPiBPbiA3LzE2LzIwMjYgMTI6NDYgUE0sIGZyZWRlcmljLnBldHJvdEB1
bml2LWdyZW5vYmxlLWFscGVzLmZywqB3cm90ZToKPiA+IEZyb206IEZyw6lkw6lyaWMgUMOpdHJv
dCA8ZnJlZGVyaWMucGV0cm90QHVuaXYtZ3Jlbm9ibGUtYWxwZXMuZnI+Cj4gPiAKPiA+IFRyaXZh
bCBpbmRlbnRhdGlvbiBwYXRjaCBvbiB0aGUgY2JvL2xxIHJlbGV2YW50IGNvZGUsIGluCj4gPiBw
cmVwYXJhdGlvbgo+IAo+IHMvVHJpdmFsL1RyaXZpYWwKPiAKPiAKPiA+IGZvciBtb2RpZmljYXRp
b25zIGluIHRoYXQgcGFydC4KPiA+IAo+IAo+IAo+IEZpeGVzOiA5MjczY2RhNzIyICgiZGlzYXMv
cmlzY3YuYzogYWRkICdjYm8nIGluc25zIHRvIGRpc2Fzc2VtYmxlciIpCj4gCj4gPiBTaWduZWQt
b2ZmLWJ5OiBGcsOpZMOpcmljIFDDqXRyb3QKPiA+IDxmcmVkZXJpYy5wZXRyb3RAdW5pdi1ncmVu
b2JsZS1hbHBlcy5mcj4KPiA+IC0tLQo+IAo+IFJldmlld2VkLWJ5OiBEYW5pZWwgSGVucmlxdWUg
QmFyYm96YQo+IDxkYW5pZWwuYmFyYm96YUBvc3MucXVhbGNvbW0uY29tPgo+IAo+IAo+IAo+IElm
IG5vIG1vcmUgY2hhbmdlcyBhcmUgbmVlZCBJIGJlbGlldmUgdGhlIG1haW50YWluZXIgY2FuIGZp
eHVwIHRoZQo+IHR5cG8gYmVmb3JlCj4gcXVldWluZy4gTm8gbmVlZCB0byBzZW5kIGEgdjMgYmVj
YXVzZSBvZiBpdC4KClNvcnJ5IEkgbWlzc2VkIHRoaXMuIERvIHlvdSBtaW5kIHJlYmFzaW5nIHRo
aXMgb24gdGhlIGxhdGVzdCBtYXN0ZXIgYW5kCnNlbmRpbmcgYSB2Mz8KCkFsaXN0YWlyCgo+IAo+
IAo+IENoZWVycywKPiBEYW5pZWwKPiAKPiAKPiAKPiAKPiA+IMKgIGRpc2FzL3Jpc2N2LmMgfCAz
OCArKysrKysrKysrKysrKysrKysrLS0tLS0tLS0tLS0tLS0tLS0tLQo+ID4gwqAgMSBmaWxlIGNo
YW5nZWQsIDE5IGluc2VydGlvbnMoKyksIDE5IGRlbGV0aW9ucygtKQo+ID4gCj4gPiBkaWZmIC0t
Z2l0IGEvZGlzYXMvcmlzY3YuYyBiL2Rpc2FzL3Jpc2N2LmMKPiA+IGluZGV4IDdmMWIyNjI3NzMu
LjY4OTUwMmYwODMgMTAwNjQ0Cj4gPiAtLS0gYS9kaXNhcy9yaXNjdi5jCj4gPiArKysgYi9kaXNh
cy9yaXNjdi5jCj4gPiBAQCAtMjg4NywyNSArMjg4NywyNSBAQCBzdGF0aWMgdm9pZCBkZWNvZGVf
aW5zdF9vcGNvZGUocnZfZGVjb2RlCj4gPiAqZGVjLCBydl9pc2EgaXNhKQo+ID4gwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgY2FzZSAwOiBvcCA9IHJ2X29wX2ZlbmNlOyBicmVhazsKPiA+IMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGNhc2UgMTogb3AgPSBydl9vcF9mZW5jZV9pOyBicmVh
azsKPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGNhc2UgMjoKPiA+IC3CoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIC8qCj4gPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
ICogJ2xxJyBzaGFyZXMgdGhlICIoLi4uKSAwMTAgLi4uLi4gMDAwMTExMSIgb3Bjb2RlCj4gPiBz
cGFjZQo+ID4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAqIHdpdGggJ2NibycgaW5z
bnMuwqAgQ2hlY2sgdGhlIG5leHQgNSBiaXRzIHRvCj4gPiBzZWxlY3QKPiA+IC3CoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgKiB3aGF0IHdlIHdhbnQ6Cj4gPiAtwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgICoKPiA+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgKiBj
Ym9faW52YWzCoCAwMDAwMDAwIDAwMDAwIC4uLi4uIDAxMCAwMDAwMCAwMDAxMTExCj4gPiAtwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICogY2JvX2NsZWFuwqAgMDAwMDAwMCAwMDAwMSAu
Li4uLiAwMTAgMDAwMDAgMDAwMTExMQo+ID4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCAqIGNib19mbHVzaMKgIDAwMDAwMDAgMDAwMTAgLi4uLi4gMDEwIDAwMDAwIDAwMDExMTEKPiA+
IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgKiBjYm9femVyb8KgwqAgMDAwMDAwMCAw
MDEwMCAuLi4uLiAwMTAgMDAwMDAgMDAwMTExMQo+ID4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCAqCj4gPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICogQW55dGhpbmcg
dGhhdCBkb2Vzbid0IG1hdGNoIHRoZXNlIHdpbGwgZGVmYXVsdAo+ID4gdG8gJ2xxJy4KPiA+IC3C
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgKi8KPiA+IC3CoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIHN3aXRjaCAoKGluc3QgPj4gMTcpICYgMGIxMTExMSkgewo+ID4gLcKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgY2FzZSAwOiBvcCA9IHJ2X29wX2Nib19pbnZhbDsgYnJlYWs7
Cj4gPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBjYXNlIDE6IG9wID0gcnZfb3BfY2Jv
X2NsZWFuOyBicmVhazsKPiA+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGNhc2UgMjog
b3AgPSBydl9vcF9jYm9fZmx1c2g7IGJyZWFrOwo+ID4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgY2FzZSA0OiBvcCA9IHJ2X29wX2Nib196ZXJvOyBicmVhazsKPiA+IC3CoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIGRlZmF1bHQ6IG9wID0gcnZfb3BfbHE7IGJyZWFrOwo+ID4gLcKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfQo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCAvKgo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICogJ2xxJyBz
aGFyZXMgdGhlICIoLi4uKSAwMTAgLi4uLi4gMDAwMTExMSIKPiA+IG9wY29kZSBzcGFjZQo+ID4g
K8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICogd2l0aCAnY2JvJyBpbnNucy7CoCBD
aGVjayB0aGUgbmV4dCA1IGJpdHMgdG8KPiA+IHNlbGVjdAo+ID4gK8KgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgICogd2hhdCB3ZSB3YW50Ogo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgICoKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAqIGNi
b19pbnZhbMKgIDAwMDAwMDAgMDAwMDAgLi4uLi4gMDEwIDAwMDAwCj4gPiAwMDAxMTExCj4gPiAr
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgKiBjYm9fY2xlYW7CoCAwMDAwMDAwIDAw
MDAxIC4uLi4uIDAxMCAwMDAwMAo+ID4gMDAwMTExMQo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgICogY2JvX2ZsdXNowqAgMDAwMDAwMCAwMDAxMCAuLi4uLiAwMTAgMDAwMDAK
PiA+IDAwMDExMTEKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAqIGNib196
ZXJvwqDCoCAwMDAwMDAwIDAwMTAwIC4uLi4uIDAxMCAwMDAwMAo+ID4gMDAwMTExMQo+ID4gK8Kg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICoKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCAqIEFueXRoaW5nIHRoYXQgZG9lc24ndCBtYXRjaCB0aGVzZSB3aWxsIGRl
ZmF1bHQKPiA+IHRvICdscScuCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
Ki8KPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgc3dpdGNoICgoaW5zdCA+PiAx
NykgJiAwYjExMTExKSB7Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGNhc2Ug
MDogb3AgPSBydl9vcF9jYm9faW52YWw7IGJyZWFrOwo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCBjYXNlIDE6IG9wID0gcnZfb3BfY2JvX2NsZWFuOyBicmVhazsKPiA+ICvCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgY2FzZSAyOiBvcCA9IHJ2X29wX2Nib19mbHVzaDsg
YnJlYWs7Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGNhc2UgNDogb3AgPSBy
dl9vcF9jYm9femVybzsgYnJlYWs7Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IGRlZmF1bHQ6IG9wID0gcnZfb3BfbHE7IGJyZWFrOwo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCB9Cj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB9Cj4gPiDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCBicmVhazsKPiA+IMKgwqDCoMKgwqDCoMKgwqDCoCBjYXNlIDQ6
Cj4gCg==

