Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73268CA5FC4
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2026 01:47:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xC5tR-0005pY-M5; Wed, 30 Sep 2026 21:47:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=727d860e1=Alistair.Francis@wdc.com>)
 id 1xC5tL-0005ov-Qn; Wed, 30 Sep 2026 21:47:23 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=727d860e1=Alistair.Francis@wdc.com>)
 id 1xC5tI-0007VK-VP; Wed, 30 Sep 2026 21:47:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1790819242; x=1822355242;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=spqbM9nqbkMkSbkqNmWDnGpw50agZksSVHxd7FGu0jk=;
 b=g5s3E/oc/WFO4VlALG3PgQsLpPEu5rL2/Ray+UuAJlXWfxoQJ1sSq0DE
 C7UFgDeN1rcve5U9d6UZ+VL7goVa8OBOKCM9ZkgVkmreJyjgB6KpPjVL4
 a6WvFZt3KoxGKzCLBPrieHtxNjvYWoVbxyq9s0nGbYoYeK6D4DQgIwvQ2
 EI1cOi/7dUs1OvtsSM7PJsI7QIUT9xqpNG05otdeeTSeVJgDUK6mWkHqv
 HV6ayZvShphWI3MPgwzrl4sOwBJIO8KG9AndSLESE6urbzgl1jf6jKJZl
 CYnG3AdrhapNiVMFcBhmgX1lW+nSKzYVxzd5d8gB7acoESI7ZYIX2+9G2 g==;
X-CSE-ConnectionGUID: KlPCWbKsRMun4HPteY21fg==
X-CSE-MsgGUID: Up6GtkOPQZy/bObWo3VI/g==
X-IronPort-AV: E=Sophos;i="6.27,133,1786982400"; d="scan'208";a="156032791"
Received: from mail-southcentralusazon11012018.outbound.protection.outlook.com
 (HELO SN4PR2101CU001.outbound.protection.outlook.com) ([40.93.195.18])
 by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 01 Oct 2026 09:47:19 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tQaQU2B5s3mYboKxteiUpV8sOsEKAhbL1xssiz8xBB6tdNf23doFdifpqA4vWtNeYwQlqgdlXh9cspLZtiK3E0BaeoBK2gHFBfw8x5oiuaSiKKGr6Vz0RMT3e77audoSaJ1YBnN7rhgns03linJF5v9jE5ziKtLb0rKrJLa8fJATs4joUjPUy4XbIrSGgGcTwxcJuJJ+42iiGahd3tDO7AvpV4COchr7hiMjl2icLw1Hjn4oiOJ6tUxVoglJcQJCv0o6hnsV6lqGupLbD0X5uIW5lT9agfV/JCyhfEF3MExxcpVP/zZcNklnUQ8V4oxTDYuJpS9yPypUwOBvdvX8DA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=spqbM9nqbkMkSbkqNmWDnGpw50agZksSVHxd7FGu0jk=;
 b=dcCacPke/7re2KL+fOBaATk3kB6vxntBlDcePTdj0QVA4QIDPTxZs6/aZxyzWxKVp2qB2/RhpxaGn+GEVD/knySZB0qpRDugRVzKNDKf/1zPjCIgDQdnsx4uLJTAjZLxBTgmi8qnXtkBJG5u3HdrYiBCM9Fsy+F1g+JIDnfTDz1Ax5kcjEXbW3htIxg+fvJ1aOd893aPh0cf1cUyUdk3WU6avc48WDDBz2OW+Q+LrVRsc/a4+gtL3lcul266xc/NvmZ0uj0+AL6RUDJ01CwI2ZuQwL5H40YyfFBqSEDbJOHzvak3fJnP7MV0XTqHvg3kchu+1J3UuauRGUrSg7tSHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=spqbM9nqbkMkSbkqNmWDnGpw50agZksSVHxd7FGu0jk=;
 b=d8lPsEWB54OCEAHSrFTz9v77qAz396AcdZxvoVu13wxOhrLMVpMDlC2K5kn32HHq5k2vCV0ceASjOW+BOT181Mg28s/KR9px/yVoXxiztNgUdSS4GuNy4W9JNRpokxHDdZ+Uxe03NvK4iPnfTo5DZ5d5HXrAH96NiqXwHoLJP5g=
Received: from BY1PR04MB9561.namprd04.prod.outlook.com (2603:10b6:a03:5b6::11)
 by CO6PR04MB7811.namprd04.prod.outlook.com (2603:10b6:5:35e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.26; Thu, 1 Oct
 2026 01:47:14 +0000
Received: from BY1PR04MB9561.namprd04.prod.outlook.com
 ([fe80::3869:e494:2fa8:9888]) by BY1PR04MB9561.namprd04.prod.outlook.com
 ([fe80::3869:e494:2fa8:9888%6]) with mapi id 15.21.0451.026; Thu, 1 Oct 2026
 01:47:14 +0000
From: Alistair Francis <Alistair.Francis@wdc.com>
To: "philmd@oss.qualcomm.com" <philmd@oss.qualcomm.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "palmer@dabbelt.com" <palmer@dabbelt.com>, "qemu-riscv@nongnu.org"
 <qemu-riscv@nongnu.org>, "daniel.barboza@oss.qualcomm.com"
 <daniel.barboza@oss.qualcomm.com>, "liwei1518@gmail.com"
 <liwei1518@gmail.com>, "chao.liu@processmission.com"
 <chao.liu@processmission.com>, "zhiwei_liu@linux.alibaba.com"
 <zhiwei_liu@linux.alibaba.com>
Subject: Re: [PATCH v4 3/7] target/riscv: Clarify riscv_accel_set_irq()
 arguments
Thread-Topic: [PATCH v4 3/7] target/riscv: Clarify riscv_accel_set_irq()
 arguments
Thread-Index: AQHdUQOBHJJeQ9LI4EeLD0nNQgCXgLbn64iA
Date: Thu, 1 Oct 2026 01:47:14 +0000
Message-ID: <52c0cc7fb2a863ffcb0cc43ae256e05329c6ddb3.camel@wdc.com>
References: <20260930174508.81497-1-philmd@oss.qualcomm.com>
 <20260930174508.81497-4-philmd@oss.qualcomm.com>
In-Reply-To: <20260930174508.81497-4-philmd@oss.qualcomm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.62.0 (by Flathub.org) 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY1PR04MB9561:EE_|CO6PR04MB7811:EE_
x-ms-office365-filtering-correlation-id: 1d488afc-0cb4-465d-75b1-08df1f5deaf9
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|10070799003|19092799006|1800799024|376014|23010399003|56012099006|11063799006|4143699003|10067099003|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info: ol7sZP1kI/IYwbtzqh1yGGAE8oGWWYVkfexVUHZq5NJXhxNLeH+KyNxlQjS0HjwoVBbkE+eAMlyRsfWSSd9d+TpkWACGB5jeST6IoNUcNv+nzkruLsdmTPWtjagVVLjAR7a/5q2R6nfVNcT6eVyAyazxDHvkEDean0BdHKZ8LPXBg+0O7GqHKWW3GxuBHYWJetHchnslX+E00TB8ZRoA4VEtjd3Zu7DNaj+npbqrvpKBbsdbSrCN8uDeB3b5+gXO3SxmlQS2GLH2+L1XTDiPKiSfvSa6Ooc9FyAI1QZtAjF30fcD/UJX3HBSqS7JJAB+Py59WthCpLU3McgYDBKYMvTC6PQ/DBidehNSTrGCiZv7jn/MKwNArjk1Lkd/FsqI0lHHMQKc1LY87lLvZwbvRIc3WU/GzuavOVPNOIJjgCIZ9F8xFFNvtV2gXjdoIdkTyObmveYZvp3tagXWjzuVMLSXFM2hTXpQXrny9ZTyUBnmO1WQrIPsaYT2WWPEyVMFPI0b5c65X59SgGXleS2jpGS6F2Y2Fq4vlcVJC6Cetoq5f5G4DQNZF1Jw4XB/L2mEa5RIo+TJN1Ji3KdcMVHqYiQed6ppQyMdwNt47gRybTTX0tGW6K5wThS92x+Mi1fG9CeLfnA06EHKhFPvy3QdK1x37KOubAVAbcXO1yz5P7+R0hmnO28Kubpki/gsbn5eh4oXQPiXPEaHXz4Gz8kMYsSKMyuKF8uYi9bWBfvowCM=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY1PR04MB9561.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(10070799003)(19092799006)(1800799024)(376014)(23010399003)(56012099006)(11063799006)(4143699003)(10067099003)(22082099003)(18002099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SXVia1gwOGdjWkN3ZVhXWjJvSStOdWZnVml5bC9jbXR6emhRK0JmdjR5N0lX?=
 =?utf-8?B?L2xmbUpiRERjd3E2ZDZFWTd5RUJQMThMQzlUeHYyWHQ0MU15STY4N0ttNTdO?=
 =?utf-8?B?d0RFa2lQeWtYOVNpY0RPdWNMR0s3ejdmcnk3dzA1a2JxVjNaNGc4aGNZbmZT?=
 =?utf-8?B?MC9KZHp4eUFLd0g0ZUpuVU1Qano1d3Q3STZ4ODNyMm9icXloTHdlMnhQMTJS?=
 =?utf-8?B?QmpVMHRvdmJwSWVSc21Yc3BIUG52czY1ekJWSVc2dzVxeWRuNGl2emtxZDda?=
 =?utf-8?B?ZE9uNHBNUkgzTzM0d1BPMEZOTkRHdi9NQ3MzUThIVG5GaFlJUXlLOFovbFlY?=
 =?utf-8?B?Mml1S3FleU96YTR5SitVdDk0YURmMytYSGtyb3Zscm43L3JoT3AyTVE2Y2Jx?=
 =?utf-8?B?MjdlUnN0KzlaZjI3dzk4RzQyMXhzOTFEamRCbGttWWRMcWh3S0ZyWVFoeFVw?=
 =?utf-8?B?TVlLcGRXdWYyd1Fudm00SGR2a3JBVWdGM2NnSDF6UG4rbGtnRWpPdEVNdUJl?=
 =?utf-8?B?bWJLemc5VWEyaHV0Wng3M0hKWmwwVzQ5bUUwMUp4Z0xFM05HY3BGNFVmMVd1?=
 =?utf-8?B?bXJETVRMMUJSbUNmV2dBYlVlY3dKSndPNFk2Tk10UW9XWG42d0M5a0piTE1K?=
 =?utf-8?B?WGRSNFVDU1QwSGdXN3AxYUJ2cUFYUjJaNm9PQ09FN2d5VEIyWGRHVlFIa1E1?=
 =?utf-8?B?MmRJZWVoYTRreHhvTGhtMFN6bnh0MS9CSWRPajFsZjVkUTVxZDhyK1RiNi9z?=
 =?utf-8?B?L0p1aVFYQ3F0L0N1NVZBMEpyTUE0TUgydUs0TnBnUjlKRXdzM1ZNTkp4NXpY?=
 =?utf-8?B?M3YzNkVENzBneXN2ODBKdmpwZVJhWkZmb3J3N1RkRnF2ejVFQkY2clVTV2o3?=
 =?utf-8?B?SFJjUW5MRW8vVEN4YmJzWStEMHhHam9SNnNXUis2bnRDWTl6SUQxdTdGQmds?=
 =?utf-8?B?c21QdzdRaUlidVJvOG9IRm4vaGhEb3J3VlBDWEhscXVwOG11bzFJbkxXQnNq?=
 =?utf-8?B?T1hMdTd1MmRIbmswZ2lGODNnN2c0TVdEN1pwZXJkc0xUcFBob1FwSlJrTnBG?=
 =?utf-8?B?bzlWck5vRGNpWG9PUXhsSm1nbjFkYW1vek1pcHdyRms0eXlPVkVFLzEzUjdB?=
 =?utf-8?B?dlBxYnBJNHllVTJNOXFnMzlTZzJHWmt2RHdyY01JUVNlblFnUHlVNEt5QVZY?=
 =?utf-8?B?cUtOeEoyakhEUFB3ZlRDQUYzczNicG9MVWlDem9RNkhwQUNsa0VtYmthSEZX?=
 =?utf-8?B?WXBER3JFN2ZpZWlVNyszRlRhRmExWUlEQWNjOTh5SEtCZU56UUsra2NXNzRi?=
 =?utf-8?B?cldiaGtkSDR5dXBGeUFTSjRYRzV5T1hmYTdhcXNVSWJpVk9meUppdzAway9s?=
 =?utf-8?B?eFVlZExtM2w0RlQreVlSeVVoMkVCTFhub3l0NFJxbDg5b3FSMXljQ2dJRSt3?=
 =?utf-8?B?TGZsV1pmQXYzOW82RlZ3SjJjRzBKK1BYQlh5TzFDNklRWENZY0V6VWJBU1Uw?=
 =?utf-8?B?NGp0OFRRZStTMnpoNXAzdGQwN0NvZFpuYnAya3FXSnJENGVxOER2bHBNR2Y4?=
 =?utf-8?B?RWkyR2YranZUaW9wWk5ySVhzUFpXaTJNQ0RVTUw0N0ZmelJlL0JOL1Z6UmtP?=
 =?utf-8?B?cU9jOUQ0NHQzVWt1UjFxc1lDUTNnemN2Z3hZeUlqOUR2WjdoN2xNM2o2M3FW?=
 =?utf-8?B?Njl6SElRTGpnNS9vL2k2WHcvUmRtU3VMdW1GODY1U1NvZlgxNDFCczh6MnZY?=
 =?utf-8?B?L3RUeHRGWlBrKzE1TzIxODF3dkRFYUtKRGgvNzVPOExpSTdMTTkvM3VjK25E?=
 =?utf-8?B?QklJSmZ3RHpIa0F5dENxNU91VWNLYjBlUHFjYjIyWGhhMlZxOWtvMzI3bWlr?=
 =?utf-8?B?aTB2YVYwY0ROUHIzYmVyM1RYTFVuNFVXempDRGc0aThZTjhUZmxzU0VWbGF0?=
 =?utf-8?B?aVNkRDhIMFBlOFVSbUxjZ1g0Q0lQT3FMcHRlQkFIb3Mza1hrRXNyYXVVOFJS?=
 =?utf-8?B?VTVJVC9yT2U2VHhDTlBiTC9ScjdtR1ZmWVhwSVNqZkFVTTkzbWd2SWdiT2Rn?=
 =?utf-8?B?a1FVWE44UFZFRStyQ05YVnJtQnJGYm9ZL1FXREtuTkloeSt4aEJWYVc4bDgz?=
 =?utf-8?B?OHg3THE4ZUo1V1pmUnRBSU4ydTQ5Zi9TaiswV2VpZjJFeFFIa3Nnc1BLYjZG?=
 =?utf-8?B?RkxoV1IvSGVBRmJlczIyN0xSdmZsc1kzQll4WGlkM1VQa2Y4a0ZUUkdSTiti?=
 =?utf-8?B?bGdWK1pSRjArWTJPNHN5RjVOK202bENtd2hYUXRVeUxZMjdLRGdVRFZqRVdD?=
 =?utf-8?B?MkN3V0NJSEl3eTRiSm9nQy9EbnhQSVhacHBVSlhUSW1CMjJNYzdvRFNZYXFJ?=
 =?utf-8?Q?9AkxmigeQBzXZ/kagB7PbT4Simr7CkKSEQ7tusDqJJ+P5?=
x-ms-exchange-antispam-messagedata-1: DumAvmi6sqFU4wvkbtzqXRxgcX549PO0PqI=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7B06F3D9AD0379448C551E9CE4DB3020@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: Z6JyHZE65Pzm0xPtpmiwqh/Rb3nXhNG7icTj1+6+1Lj8gZdDcLqIoyG4IzsHXUsosFSx0iyobu0NoFG8GymT27HNv5WvzIH4YHq38HKPmnjJ2kaLyyGx6oHpNFY6lb80prmcVbr8DkecuyZWYF0+jYp5gS34+izSe/7SGSy/NWAFkm33CtFnGDKTtHeWpHHeKl8WcldNojytxdHhaEze4JsG1rUbDkJ2SgdZNNcJB0m99utCxNow5im1G0g3es5hcGzYJKPtnRjmFiuhhqDHpBU7380X1no4KJlo0oFDzh02GBcH1fuMsO3JNTfde68HSxPYnIzLAG/YEcGS2KSCcw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: AJiWrbcKywcGq/JBZqHYDFlgKYclfPwD1KCo9FGeEfwSx116XAMDjoebnF6RclZLuN0FKIo9xs8NNc54zqjaWpSmiiv1YNnDhP/dwDYgCzUOw4Ft03d4ivZR2b1iRLXjmZ3hvkheNgCRxsc+eFjjbr0CgaPpNqeNjEpAHypkN8IO3m8XpB4ECLty8VpLzZxvnEpDSIwHU8BCPsiFTY5BB1ET4LGjeQYJPzSDor69/vyaQuDPxiyfilZrkocWeAxwcfMCMOUuOAEpxgTyvzAJj+DPTouolAyuyzJjcwjnQF4868L7gw+EvbG059jnujmvMEMIEITUyF52lGQR9v/mM0yPGGw2bFFii8bAmGANrnrGAWX1Hw+hSymF2njSLGl486VircgHY96Grlub4rFaACFA/dIQNUsCX2bOg2FoxbDq8xCi+SZPv4p5rKToyXyasuFbS1T+xdihTqJNUpNxExa0VYJGzMOrtdlCcBoXulKm24cs4MVc3wGLOqZ1SLTsXRe8jozEJOEIQU7cs7qYv0zWNpeoLNJ8fatOfb4L9fXO/lFsEgQhDpyVXuZQ9/zMS4Rfc4ber3ldWcAS4jFrBTKD9ksrYeDlxuHG2Id3alcy3lUj8mlxskwpgCkfWSkE
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY1PR04MB9561.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d488afc-0cb4-465d-75b1-08df1f5deaf9
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2026 01:47:14.4035 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TrN7EOr2S9zWUesmaaY4ovA46zD6U9q1PFL7+xWPbySje9SRK1W6JkxwMIXRh1J51FupOEUQluK1IYmuGSXD8VT2b48hAQJtKMakHY2cY5c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR04MB7811
Received-SPF: pass client-ip=216.71.153.144;
 envelope-from=prvs=727d860e1=Alistair.Francis@wdc.com;
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

T24gV2VkLCAyMDI2LTA5LTMwIGF0IDE5OjQ1ICswMjAwLCBQaGlsaXBwZSBNYXRoaWV1LURhdWTD
qSB3cm90ZToNCj4gVXNlIHBlci1hY2NlbGVyYXRvciBsb2NhbHMgdG8gbWFrZSB0aGUgZGlmZmVy
aW5nIGNvbnZlbnRpb25zDQo+IGV4cGxpY2l0OiBUQ0cgdGFrZXMgYSBNSVAgYml0bWFzayBhbmQg
dmFsdWUsIEtWTSB0YWtlcyBhbiBJUlENCj4gbnVtYmVyIGFuZCBhIGxldmVsLg0KPiANCj4gU2ln
bmVkLW9mZi1ieTogUGhpbGlwcGUgTWF0aGlldS1EYXVkw6kgPHBoaWxtZEBvc3MucXVhbGNvbW0u
Y29tPg0KDQpSZXZpZXdlZC1ieTogQWxpc3RhaXIgRnJhbmNpcyA8YWxpc3RhaXIuZnJhbmNpc0B3
ZGMuY29tPg0KDQpBbGlzdGFpcg0KDQo+IC0tLQ0KPiDCoHRhcmdldC9yaXNjdi90aW1lX2hlbHBl
ci5jIHwgMTIgKysrKysrKysrLS0tDQo+IMKgMSBmaWxlIGNoYW5nZWQsIDkgaW5zZXJ0aW9ucygr
KSwgMyBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS90YXJnZXQvcmlzY3YvdGltZV9o
ZWxwZXIuYyBiL3RhcmdldC9yaXNjdi90aW1lX2hlbHBlci5jDQo+IGluZGV4IGVkZTFhNGMyYTM0
Li4yOWJiZWJiOTZmYyAxMDA2NDQNCj4gLS0tIGEvdGFyZ2V0L3Jpc2N2L3RpbWVfaGVscGVyLmMN
Cj4gKysrIGIvdGFyZ2V0L3Jpc2N2L3RpbWVfaGVscGVyLmMNCj4gQEAgLTI1LDE4ICsyNSwyNCBA
QA0KPiDCoCNpbmNsdWRlICJzeXN0ZW0va3ZtLmgiDQo+IMKgI2luY2x1ZGUgInN5c3RlbS90Y2cu
aCINCj4gwqANCj4gLXN0YXRpYyB2b2lkIHJpc2N2X2FjY2VsX3NldF9pcnEoUklTQ1ZDUFUgKmNw
dSwgaW50IGlycSwgaW50IGxldmVsKQ0KPiArc3RhdGljIHZvaWQgcmlzY3ZfYWNjZWxfc2V0X2ly
cShSSVNDVkNQVSAqY3B1LA0KPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaW50IGlycV9vcl9tYXNrLCBpbnQgbGV2ZWxfb3Jf
dmFsdWUpDQo+IMKgew0KPiDCoMKgwqDCoCBpZiAoa3ZtX2VuYWJsZWQoKSkgew0KPiArwqDCoMKg
wqDCoMKgwqAgaW50IGlycSA9IGlycV9vcl9tYXNrOw0KPiArwqDCoMKgwqDCoMKgwqAgaW50IGxl
dmVsID0gbGV2ZWxfb3JfdmFsdWU7DQo+ICsNCj4gwqDCoMKgwqDCoMKgwqDCoCBrdm1fcmlzY3Zf
c2V0X2lycShjcHUsIGlycSwgbGV2ZWwpOw0KPiDCoMKgwqDCoCB9DQo+IMKgDQo+IMKgwqDCoMKg
IGlmICh0Y2dfZW5hYmxlZCgpKSB7DQo+IC3CoMKgwqDCoMKgwqDCoCByaXNjdl9jcHVfdXBkYXRl
X21pcCgmY3B1LT5lbnYsIGlycSwgbGV2ZWwpOw0KPiArwqDCoMKgwqDCoMKgwqAgdWludDY0X3Qg
bWFzayA9IGlycV9vcl9tYXNrOw0KPiArwqDCoMKgwqDCoMKgwqAgdWludDY0X3QgdmFsdWUgPSBs
ZXZlbF9vcl92YWx1ZTsNCj4gKw0KPiArwqDCoMKgwqDCoMKgwqAgcmlzY3ZfY3B1X3VwZGF0ZV9t
aXAoJmNwdS0+ZW52LCBtYXNrLCB2YWx1ZSk7DQo+IMKgwqDCoMKgIH0NCj4gwqB9DQo+IMKgDQo+
IC0NCj4gwqBzdGF0aWMgdm9pZCByaXNjdl92c3RpbWVyX2NiKHZvaWQgKm9wYXF1ZSkNCj4gwqB7
DQo+IMKgwqDCoMKgIFJJU0NWQ1BVICpjcHUgPSBvcGFxdWU7DQo=

