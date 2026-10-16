Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF165CCA462
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2026 02:01:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHXFJ-0002LN-Bh; Thu, 15 Oct 2026 22:00:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=742cbab99=Alistair.Francis@wdc.com>)
 id 1xHXFH-0002KQ-GB; Thu, 15 Oct 2026 22:00:31 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=742cbab99=Alistair.Francis@wdc.com>)
 id 1xHXFF-0001Sn-Sa; Thu, 15 Oct 2026 22:00:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1792116035; x=1823652035;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=j89K5kdoCgt1y6vJCiyP5mV7ovetIMvdWqumBKGH2Ds=;
 b=lyOQncExVmVy3NXUnFVyQF9ILJB9iURChgBB4i97vloKqJiMEqFobqlB
 DclNnRMb7uJu5ebannFnxJgqcDkR/GPx+4CWkQvQRLZEoQW65mLyJZHVV
 zmhAeuJcBChjqqOmr0jpNqa1YridcXNBBi3M6IDRIN3a6/yh2gHbnwabU
 /Vnmjr5wkoD6G5UeFT9jv8zewP0T5tVCYnp4Og0m5lBZZE0GzqPtfLiq8
 v5QYFXySj+G1kiWCcpF11oDVELMtzCDzdUwXySx/PXhsIKLqfEmADp9ej
 5UkQEg7sEUuHsNXvzJ0dC/3TRLK+mz73DjOcEIkGJEqyptqRhv5NbfYQP Q==;
X-CSE-ConnectionGUID: /JYRqe3/R+mnVdUe8R3IIQ==
X-CSE-MsgGUID: wtOEka2hQjW2TMuOYV2dQw==
X-IronPort-AV: E=Sophos;i="6.27,160,1786982400"; d="scan'208";a="157267331"
Received: from mail-southcentralusazon11013069.outbound.protection.outlook.com
 (HELO SA9PR02CU001.outbound.protection.outlook.com) ([40.93.196.69])
 by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 16 Oct 2026 10:00:33 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mz8B9oaEODMvsKYapz5b8E20slPhnzAEqH4ovy0M4YpAupMLAZMvza8eYqNoLk9zWNoO3E+I1HMCzvI+RTLBiXfZ83lnuZeaXtMjBDubkYeBegbG4a1u278NO6C81WBAJq4uIiacPQoGiN+5ON8Pi3AMPFRJejJ1bzLt/Y4civ9N1gT7RwGXo4afi+Oq0O1nu1rL2rmZGkaT5PFO0K1liAqCksOhOvTB8pJmwapnAS4qxkHYVncR12kL7Whq6ndfiH2FR5XkLkhyXpp2cIK/3g/cL/hKfZ2zgT5bxRTMEgWMUhTFeVMSs/bnmigxzG7nuj7hL9EjuKmn7wIyuLXOYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j89K5kdoCgt1y6vJCiyP5mV7ovetIMvdWqumBKGH2Ds=;
 b=F8HNjeEYu7Aw33U1XkxHKVDu18b6Bd+31/JbJc4/0thlOa/zYCdQfMnHmoPApTznBwdCR+wyATMZXAuj6sdcNDcAJZVe/n3xKLulQ/p9qKv8Mh/ipwaM2jnhE3j/wBPNhXWw3LFTkPNIgn5W2VtVSzLSY9ANhYdwYJnMEuLHc2ZsemqRBNLcLuIm7vUWYGTeswE6eMpnR1cWAN+oF8zSvwNmkYXMRU7s+MI6hb/Fxpg+H7N+qzLI0nFFjPRlBfwH74og/0wI+GuqiWckVQiDnYCPKWb9Ye1PKTgkpjDml9QZbCKUAJtdG0IIqBCuY7bkgGD7XMhsgSi12ckhWFDGhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j89K5kdoCgt1y6vJCiyP5mV7ovetIMvdWqumBKGH2Ds=;
 b=cDGDcKJrSbIYgvRV+oBw7P8yFVAUyuDZy9qjs7pzWfpOUKs4gJznHALC9CuTR57q2ytnNHnDwYUNp6+RfcqQKhcgJ81Mydr4AIa/wzqiWeODLJm+y6o9iTYGnYWzL2JaDx8gKblKqn8VpHB1C1HVKghnlhXv8PSM+sxbVMJC4FE=
Received: from MN6PR04MB9359.namprd04.prod.outlook.com (2603:10b6:208:4f2::13)
 by SA1PR04MB8886.namprd04.prod.outlook.com (2603:10b6:806:386::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Fri, 16 Oct
 2026 02:00:25 +0000
Received: from MN6PR04MB9359.namprd04.prod.outlook.com
 ([fe80::e729:bbef:5a37:2e77]) by MN6PR04MB9359.namprd04.prod.outlook.com
 ([fe80::e729:bbef:5a37:2e77%4]) with mapi id 15.21.0522.013; Fri, 16 Oct 2026
 02:00:23 +0000
From: Alistair Francis <Alistair.Francis@wdc.com>
To: "dingtaodtdt@gmail.com" <dingtaodtdt@gmail.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "dingtao0430@163.com" <dingtao0430@163.com>, "qemu-riscv@nongnu.org"
 <qemu-riscv@nongnu.org>, "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "farosas@suse.de" <farosas@suse.de>, "chao.liu@processmission.com"
 <chao.liu@processmission.com>, "lvivier@redhat.com" <lvivier@redhat.com>
Subject: Re: [PATCH v2 2/5] hw/misc: fix calculating input address overflow in
 k230_decomp_gzip
Thread-Topic: [PATCH v2 2/5] hw/misc: fix calculating input address overflow
 in k230_decomp_gzip
Thread-Index: AQHdUnbB4Dy2MqSiHU2j8AuAjqJMc7b/f0YA
Date: Fri, 16 Oct 2026 02:00:23 +0000
Message-ID: <c2edbdf2dabc476781b86b68be10a4211fb75ec5.camel@wdc.com>
References: <20261002140245.30214-1-dingtao0430@163.com>
 <20261002140245.30214-3-dingtao0430@163.com>
In-Reply-To: <20261002140245.30214-3-dingtao0430@163.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.62.0 (by Flathub.org) 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN6PR04MB9359:EE_|SA1PR04MB8886:EE_
x-ms-office365-filtering-correlation-id: a1f6e5e4-4ec8-40a0-97ea-08df2b293d86
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|10070799003|376014|19092799006|23010399003|22082099003|261009223027099003|38070700021|56012099006|11063799006|4143699003|10067099003|18002099003|3023799007;
x-microsoft-antispam-message-info: O3sonzCAs+fDQAFjgi92FXhwOys/zI1iaelt7jvX57iNsdPGpPUO7gK0wE74DN7FC0LVufLAB07LVDGBHOizZb5ps1C4C3GMAn/lvnMAL8FavljIhfdKrSmFJmSYxdBQiuNz1TChO2qCjQPXd4Wrou3/nScCFMrFVtnAwUIIglp3LoMVTg6sd7OH5rZCSMeSSBy6QicJZ34/LG18ciWGMrhWr/GAJtWqiErccuMTGwQjUvjVV6hczOq2ivYga+8y4TEK/gJeB6SAo5FMExVHiwUgZQmnSUegrQEVOVTrot7KsOX2XdLB7XBfwf9HQaXwA+tLhoAMGFoO+DEEX3GLm3dv5AFO8xjWxQhHBqdngycXc3omnwLyNbYcZZfeZwzI4ezrhw18WFo7CrJXm8VuaC+pUL2GYJJCeJte7zQe/SMr4wOIY7FrpZC1JM/InEFkHJ/7ONTFuoi+5bI9vasdcCB9x+LtcbnIi6e42Flb6g7BDS75SfLg13V0zuRfuj5L+AWI48KYoOY3q4ugmdQUlFi2D0k4kFdV7BWpWNGYNZSHNfjKKTTpiKH+T/4Y76MK5+iyw9H1wFZ3Bjd4s80B/ujLyZBl60y/jQxSOZZnY9ey8YFyqrH+pOpaobmXJ9e7ESKbxLkYadmSLQkqwfsYJWUU9cX1LepMylGXO34Octxh4WZAY562QWVSt8oQbNd4brrS7VB59Fat6PvkWq2DoSbWIBsoGO9JIMhoX/lnTxk=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN6PR04MB9359.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(10070799003)(376014)(19092799006)(23010399003)(22082099003)(261009223027099003)(38070700021)(56012099006)(11063799006)(4143699003)(10067099003)(18002099003)(3023799007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OERhbEUyTDhvSExoVjhqMm9yaHl3Smt4NnNHNGxCVFIxMkUxSzZvOGY5Mndh?=
 =?utf-8?B?RkhGdDdxYUFUSkdnZ2hsT1p3bHBIaGRTQmg4OFk0djhib1FGcDZQUDJUb0FZ?=
 =?utf-8?B?SzRRcGFTS0pRUkYvT1RlV3RnTnMwTzN3OURoc1E3cnJKeFlFTnNsM0FXTFdi?=
 =?utf-8?B?WE5hYXFiQ3IrZ1hjREwramRtZll0WEtjRnNOczlTN01aNnFUN25QYUtFMkpl?=
 =?utf-8?B?K3Q0SmFBYlhlNEpHT2Y1OVJlWnhvZlJHbTNEaEN0MlJYQ05INXJUSWk2SXBu?=
 =?utf-8?B?Vi9RS2VGM0lZdFJzYllxQW1tRmp3eFI4djVzUlVxejlNYy90UlorWWN5ajNX?=
 =?utf-8?B?TU4zbC9lcVFabndON2k3M2lOb3M1NUlxQWliRWVUSDgyV1YwNGhuWlRZWFFZ?=
 =?utf-8?B?Zis5M2VINkZnZ21HdHlYM3FzYitHbGtBNCt2QzNjbFYxTnRZMHZFd0tnMnNh?=
 =?utf-8?B?WHd5dVVoV1BFME44NWIxZyswaVIvdTJoM1Q0U085TTJMZ2UyYktSZUV6N0dz?=
 =?utf-8?B?Y2QxM25EbExybTFNRW4zdWZiZ3RMSDUreng5c3MweCtYZmdpMTV6d2JhQy9j?=
 =?utf-8?B?Njl0L1B4Y3VaZVJkR3I4OTcwVEF3QmpBcEU5UlZoL0tJQWQ0OFBQbmYrOGFy?=
 =?utf-8?B?clE2S0t6UGFVUnc5SzF5dXFzNmNPY0lHTlE2citZSXV5YjNwb1BScTFOTHVu?=
 =?utf-8?B?RDlZY2IxZWsrVmd0a25oSFN5OWRXMG1ZYk9TOUJrNjBqdVp4Zy96Z0JPNS9T?=
 =?utf-8?B?VnpYSGRCL21BVEZZUlJxT1N0QXJldFVUSWRYQlJuczFUaWVkTEpFUHJUYVpK?=
 =?utf-8?B?U0FQNzVTSWlTVEh5am5oK3NUa2NXVjlaNTdLZlFUYzJ0U2UraFVONXppN0Nt?=
 =?utf-8?B?dy9FM1VvRHB4cXU0REF5YisyNXMvb3lNenJGVjczdHczcmMxb1g4cms2VVVw?=
 =?utf-8?B?OTZWZDRGYXhDU2Y1ZU1zc3FlWklPV3E2a3czSkdxR2srcW15R2MzcUNEcHlp?=
 =?utf-8?B?aGJTVXVrck4wNEJrK2F1QlcxMmdiakE0eDBhLzdOMTJKc2JUQ0VDVEx5c0RF?=
 =?utf-8?B?RGpqL2xSRTBpdWpWTDBTUGRoWmFLdWJ3WmpmeC9iN0s2QzRhN3Rob05kYmk2?=
 =?utf-8?B?TU1TVzNGR253K2Eya2lSb1l2Q2NWT0RmeHl1ZW03TkJvUXZ6eVNkQzk2RUlM?=
 =?utf-8?B?Vm9PdWtTMG9zRUxPZ01TVXhFRy9oMFJkZlE5U20yYlhPTHdlY25ETXh4SUho?=
 =?utf-8?B?dVNFTnV3QlVtYWIrWXBoTTN5UnFxVzZ5WlJib1ZDeEFVU0U0Sm4rT3FCbDRo?=
 =?utf-8?B?b0NsbnJxOXQzNnRlV2d5U1pCOE5tSzhSdHZuY2xTTVZwY0NmZVVlVjJWVTNJ?=
 =?utf-8?B?Y3RlRE85ZlBjK084YzFhcVAzdWt4TTZQc2lJTFlwODlTNFN6ZFVrZ2ZqMTN6?=
 =?utf-8?B?NU1STW5PcTAvKzFCcVZEQWdKNFlXcE9QRXlwNjVzc1NURUhyYTArd3htYUp3?=
 =?utf-8?B?U0k1NnNFUzBuZHh0Qm41a1RhVG1pc25EUHQzUkwwV0JQS1dmSG1wOW04UndL?=
 =?utf-8?B?b3ZtV0QveEFFb1pRdmJ5MTIrSWZSaDkyNEpCVWlhRGxuYk85ZkoxSXpuTkhx?=
 =?utf-8?B?ZDcrUFNvSy9hd1RKdkRNaHlPREMva0FEOU1KVCtIRGI1dks2R3lYb0ZmbTRy?=
 =?utf-8?B?M2w0NUlVZnYrWUdHSGFkMk1oSVl5QjZSTHZQb2RBQ3JvTUU4U0pXQ0VjaEI0?=
 =?utf-8?B?Zzc4WlU1RlpYNkxBNXE2eE51dzZwZHI1TGw3bXlmdzY3YnVld2ZlbFBwc09m?=
 =?utf-8?B?TlNOcHJFc2YrVTM0UjFLeVBaakYzVVdXSG9VY3U5SFVQOEpibEdYbjZ2NnFt?=
 =?utf-8?B?WmN5a2U5UjZPeXlydjlvOU1ITWZhUHdWWXhkbzYwV29HU2xUTEFOcGlZRmV4?=
 =?utf-8?B?elZjZ0dIcVdhTEQzTDd2WTkvWm9XVGF5NzhlaVR2bmVpUTlMeldBb3lNY3k3?=
 =?utf-8?B?N3BOM2VCbUhySDgvT21nSm11MzNQcU5YZHU4WHJrcmovNERIWHVhMlRxZ2ly?=
 =?utf-8?B?ajJqMndWQzVNTzZYeHFCZUJOanVsMGxNWGpwUDcrM0ExTkw3TUlmV1JORTZT?=
 =?utf-8?B?d3RpaFdCRjkwTWZkMjc1MFJDUXVTeDZ5empvbkNzRm1ISkRwaGh1VWQ3Mzl1?=
 =?utf-8?B?K0w1OGh0cmpSRCtEdXBrd0Q1QWM3aGFSYlRVR1RVNHBvU0hlbVM5NVZrb1o2?=
 =?utf-8?B?b3pWeGRjUG1DYmdSVFdseTdhS2pXckw5dWFEK2RIRHN3QVVVRHNzeFVXRmo4?=
 =?utf-8?B?ZU4vcWY0d3NLN0pYdk44eUFOK0k5a2VuT1kyL21jblYzcWREanQ3bTRXdHd6?=
 =?utf-8?Q?xYmHNLuhflI+0huqyU4+fHjqK1x0FNVDLVrsb4QhyAob4?=
x-ms-exchange-antispam-messagedata-1: 746cKpJrj20Gg9n8bHXwHQoPeGmsxfoTRwg=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CFCB027CE429D44DB45EE3992B499F2D@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: d/r8agVG7Om6C55qaQAYaIXD0i/WJtetMIcKGXtnHfWpYdIAwOUwSnUhpMWv8t5fzEoP7xd5jdTFfsmPuAlbVOg9NgVgKg26WGtt9BGQVSmvAyHgrpmQk7N6Hf4cPMJYfuuDwZB3uxr4+VRhKxIcsLIbR89/8cXkp/b5j66RGJ9H8sc8oQuUh4H9Btn5H90Sh4VIouJyRRcChdLN+nQdWiLjmirwTnR2x/RtpWCClMuCFUGps+N3oEXAzVH9jDgYjqHi4jghod/zN8cbQ++qm6tpFYayTPt13OO2fP7Kz+xtmFk6j5sIxzzfQG+xiCzSqLvdf9xDUT6R7Uq9eBkdnQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Bai1AHhua71Ybci1PsrSlQ11+mS+pNHjX/m7rtp51R6VGUE+gih00QnSAIrbR26Egf17WWbq7sWbYV3/qfmIZS4kb/rxeqrv3tU+wt1GaLuAukstXiT9I6u7D2e2Jk83VoYVgvOpfdgjYQsBK90tgU9tXJ7akGoxz1efeXtXyBZuUNhilAzltzEIMDMy+s9pdXSt5PgwGxUm9eXmfv7OCy0bx0iMsS9AfQwEOMQjCJlr+ODGxSGXbGWqWbWv+41hDiJddVrVPPL9l+oCFZjfa8QnrxGeZwQHwladL1hK/3Myh1K2LOZG5bYzGDnprvSwtdJ8/Bg+2MdHNA/ahIVxd5KFlFKWq64CpaERhLqO7ti3mYVFXUsuRYEWQeQbvhVgdgOgGr/vQMr7kp18JZ7n4nt2KTQB+BgxHZWG8WQjuLYKZLsSt5T7kWm380DdubSwsWAyyfnjUNvXN8INxEl1Dgxyb9eTV/MRK8CLZEhqwM1X8kQK20fJbsy0NlxHxV/Ulg3CexhAPaeoGjRCZKu6i6uF6n0x6Zrm/ZS2uKTwXPQuBwyt6tXe4yEUgtKBjA2Z51seTol/qP9D1uHpNgIP/3BHczkSQHZrfiRg/ea+T5vILxl6y41qqNrmHvvCp/jB
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN6PR04MB9359.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1f6e5e4-4ec8-40a0-97ea-08df2b293d86
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Oct 2026 02:00:23.5308 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: C91dCKNyRWJ32Zdqh+WChaqfpvD+qyOC5m0vkf+JaRyG4dh7qM6rrC6GoV2vd/hW6BJDp//ZUHsb+4noHR+Rk8v3IrUI+8QeoQBVKhv202A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR04MB8886
Received-SPF: pass client-ip=216.71.153.144;
 envelope-from=prvs=742cbab99=Alistair.Francis@wdc.com;
 helo=esa5.hgst.iphmx.com
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

T24gRnJpLCAyMDI2LTEwLTAyIGF0IDIyOjAyICswODAwLCBUYW8gRGluZyB3cm90ZToNCj4gVXNl
IGh3YWRkciBmb3IgYWRkcmVzcyBjYWxjdWxhdGlvbnMgdG8gYXZvaWQgMzItYml0IG92ZXJmbG93
Lg0KPiANCj4gUmVzb2x2ZXM6IENvdmVyaXR5IENJRCAxNjg1NTE3DQo+IA0KPiBSZXBvcnRlZC1i
eTogQWxpc3RhaXIgRnJhbmNpcyA8QWxpc3RhaXIuRnJhbmNpc0B3ZGMuY29tPg0KPiBTaWduZWQt
b2ZmLWJ5OiBUYW8gRGluZyA8ZGluZ3RhbzA0MzBAMTYzLmNvbT4NCg0KUmV2aWV3ZWQtYnk6IEFs
aXN0YWlyIEZyYW5jaXMgPGFsaXN0YWlyLmZyYW5jaXNAd2RjLmNvbT4NCg0KQWxpc3RhaXINCg0K
PiAtLS0NCj4gwqBody9taXNjL2syMzBfZGVjb21wX2d6aXAuYyB8IDIgKy0NCj4gwqAxIGZpbGUg
Y2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkNCj4gDQo+IGRpZmYgLS1naXQg
YS9ody9taXNjL2syMzBfZGVjb21wX2d6aXAuYyBiL2h3L21pc2MvazIzMF9kZWNvbXBfZ3ppcC5j
DQo+IGluZGV4IGFjMDZjYzE1NzEuLmRhNGRjNmY5NTQgMTAwNjQ0DQo+IC0tLSBhL2h3L21pc2Mv
azIzMF9kZWNvbXBfZ3ppcC5jDQo+ICsrKyBiL2h3L21pc2MvazIzMF9kZWNvbXBfZ3ppcC5jDQo+
IEBAIC01OSw3ICs1OSw3IEBAIHN0YXRpYyBod2FkZHINCj4gazIzMF9kZWNvbXBfZ3ppcF9vdXRw
dXRfYWRkcihLMjMwRGVjb21wR3ppcFN0YXRlICpzKQ0KPiDCoA0KPiDCoHN0YXRpYyBod2FkZHIg
azIzMF9kZWNvbXBfZ3ppcF9pbnB1dF9hZGRyKEsyMzBEZWNvbXBHemlwU3RhdGUgKnMpDQo+IMKg
ew0KPiAtwqDCoMKgIHJldHVybiBzLT5pbnB1dC5zbG90ICogSzIzMF9ERUNPTVBfR1pJUF9CTE9D
S19TSVpFICsNCj4gK8KgwqDCoCByZXR1cm4gKGh3YWRkcikgcy0+aW5wdXQuc2xvdCAqIEsyMzBf
REVDT01QX0daSVBfQkxPQ0tfU0laRSArDQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgSzIzMF9E
RUNPTVBfR1pJUF9TUkFNX0lOX0JBU0U7DQo+IMKgfQ0KPiDCoA0K

