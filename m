Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EF44C5DF81
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 04:17:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyibQ-0004hn-5A; Tue, 25 Aug 2026 00:17:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=690dc056c=Alistair.Francis@wdc.com>)
 id 1wyibO-0004hV-Jv; Tue, 25 Aug 2026 00:17:34 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=690dc056c=Alistair.Francis@wdc.com>)
 id 1wyibN-0002nd-0m; Tue, 25 Aug 2026 00:17:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1787631453; x=1819167453;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=73zxhYPvWiDEEtSQhrkI9Gt4P6qOA2FzE+UBvLQA6+k=;
 b=qteD5C2EBo7uMeIN4a+s9I1oK3Hu1yKZTv34sSVCQEkPBDP3poQcQR4U
 7parKpV1nQd4WB0L8kIcvBq0ufvnxt69EgPEaIKqv1AfZC548xI+c0KZF
 0a6VD2Wl5Fggx+ne3bxGjqQOdf5qcbngcnDyUcrMrx4c0bWeaOQq+7zci
 9gO31rVa2Z8mRQmN7NOsi31UbO+UD2zfA6iknJuQJTiBTPzEudRwN4eY6
 vxgXdup6rzrN9AJ/o0WJt96ov9gxDgkQjNfNngBWgiErgTQi9gk1pGACd
 Y8YcLyEzg+mCg2vfs1+HnT+eIwPjT49mjKscHkfhfwzKTjQS2izy/B+Vh w==;
X-CSE-ConnectionGUID: eDgP5HJ6RdSqLybJ8TDFBQ==
X-CSE-MsgGUID: C5nfOa14QpKqBo3sZA9XFg==
X-IronPort-AV: E=Sophos;i="6.25,242,1779120000"; d="scan'208";a="150004680"
Received: from mail-westusazon11010036.outbound.protection.outlook.com (HELO
 BYAPR05CU005.outbound.protection.outlook.com) ([52.101.85.36])
 by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 25 Aug 2026 12:17:31 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WO9ORv4rI5en0QRu48cs9FpkW3r/whqAzs0TrS1E4hxZGZR8cJf+V6LdzqddjFdZZysDdcJbTUNn2HCli97XTkIAB3gonY0CAKp1vDFdSVDPS63he/w84YJOeOAS6NeMLsSg2D4TpQPbBlwbwuiJhFLIYHyv+rL4d9/iDWkuqy2aNTs06NZ6RJG1Ewuc5tgBlWrDmFD2uTiMowwfmCTdFePVHPfKDsukPcGubwq/8s8r++eDjT9qVwz4rZvjILhS4TzzWuJBqMLGKgsIo6vRiYpJO/XjfmoBDATRICOYBrDrqljSGFOzAxA/IZzo2hNXQc03an2Kx/eDsJkHljCEKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=73zxhYPvWiDEEtSQhrkI9Gt4P6qOA2FzE+UBvLQA6+k=;
 b=M2XSXbI9ckWDQGU5m3uG/UTSeTwjd6ARlQq0IyU0lb2qXhDAVJW1T+j1z6/qzanV+ywM0d7w2mpeYZmM8Bpdsl4BOgQDqoZr/wFmpPXpOQjMtrLRtNjxJoFcas4XZs1a5Sf7iIpvRr57pRMjdgNa2jX17TgK1khWeoI1oMXroMk1c5dPVrqbgNy8mZ2nA/eY82+NmaWpRxzFycRFu2JTLEzbCXCXiYHUz/Ry9K0rf1IQFOEF2T6XKds2qQq7WoT4HB7q6SDz+N2gzyrMYRCMPaQm8Egk3GCJDDRkvLDBFLQM+LeRnVEiCzs6x52BTaz7lNFyUCZq7nr5tXvmBj32kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=73zxhYPvWiDEEtSQhrkI9Gt4P6qOA2FzE+UBvLQA6+k=;
 b=UJE+IZR1HfkNrAJNJGqXSe9w5uYfkZwA23uMitjANa1EFDTPUBAg56G/9DIG61te6tqzKCoSlllJU5Ffgvgz5XvS4Z54ILT/6W+xenuptUPGjM7ft0tTY+H+Zl94RlT4/BZRkEQ7PFgpUIZ1XbkZs27kYSsgD/eQRzrahqW1OeQ=
Received: from BY1PR04MB9561.namprd04.prod.outlook.com (2603:10b6:a03:5b6::11)
 by PH0PR04MB8475.namprd04.prod.outlook.com (2603:10b6:510:29f::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.6; Tue, 25 Aug
 2026 04:17:29 +0000
Received: from BY1PR04MB9561.namprd04.prod.outlook.com
 ([fe80::3869:e494:2fa8:9888]) by BY1PR04MB9561.namprd04.prod.outlook.com
 ([fe80::3869:e494:2fa8:9888%5]) with mapi id 15.21.0360.005; Tue, 25 Aug 2026
 04:17:29 +0000
From: Alistair Francis <Alistair.Francis@wdc.com>
To: "daniel.barboza@oss.qualcomm.com" <daniel.barboza@oss.qualcomm.com>,
 "joel@jms.id.au" <joel@jms.id.au>
CC: "npiggin@gmail.com" <npiggin@gmail.com>, "mpe@kernel.org"
 <mpe@kernel.org>, "portias@oss.tenstorrent.com"
 <portias@oss.tenstorrent.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>,
 "chao.liu@processmission.com" <chao.liu@processmission.com>,
 "zhiwei_liu@linux.alibaba.com" <zhiwei_liu@linux.alibaba.com>,
 "asrinivasan@oss.tenstorrent.com" <asrinivasan@oss.tenstorrent.com>,
 "liwei1518@gmail.com" <liwei1518@gmail.com>
Subject: Re: [PATCH 0/2] hw/riscv: Make s-mode IMSIC stride explicit
Thread-Topic: [PATCH 0/2] hw/riscv: Make s-mode IMSIC stride explicit
Thread-Index: AQHdM3WJgDuaOzXLf0qJeIuPhov8q7auKlwA
Date: Tue, 25 Aug 2026 04:17:29 +0000
Message-ID: <cce3bece6f388860972fe008702cb327c0816b10.camel@wdc.com>
References: <20260824030509.18078-1-joel@jms.id.au>
In-Reply-To: <20260824030509.18078-1-joel@jms.id.au>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.60.2 (by Flathub.org) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY1PR04MB9561:EE_|PH0PR04MB8475:EE_
x-ms-office365-filtering-correlation-id: a4b6f426-bc26-4a0b-a841-08df025fc6e0
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|19092799006|10070799003|1800799024|23010399003|366016|376014|7416014|56012099006|10067099003|18002099003|22082099003|11063799006|38070700021;
x-microsoft-antispam-message-info: LE5c8FUxpUcnLzjIArYWqH5RCZ8X3bS0lA0vFSBlJiEsb6rhR3NBDWNXXlPK3kAA8CTNytJJpSnaegQpY+4lK10AHGfVfq79+Td68OiQj35C4FW55XGZrVHtAlguV9tVQX6eHjnYecDJ1MkEc8NEppDZm01t0Cs+9Bdrakw+c8k8f/MJij8fYaZHkB6zhXeq6Q+jO5xgj1l3BvoMpEkSGN6x+S573diEE4HQAvwvLVhC+Q3FfSYXgiehX97UuQ4Gv/ifqj1h+aFhqzF/4mCtDOM0bazf5fd84JBZqZU6SGpsAvB9Et/Sv8mgTriTeCoOCSwVMhOuQzmGyJuGOzeBZvhp6etsOglO6VdVjGTaNjRvm05Pi3bkwEyE/5Twtc00qZhtzlL8EzIofM+9eQGimyKXFy/FONCiQHq39eikq6BsmGpMY/jPJGBZUPASvBcfqb2oeVWXkoCrmP/cvnJV7J2moCb+7JDlwzldEFx2SPsVle+Ln5vCMf7SD5OX0MZPvqM+0P0KlEpqeZgr6cr46/sYm5PUl3QilCeshfQ4kl/STaoDN6gpz94EogI5FTS+8cuy3KzS7KuyHg1cJb3xQfcN6sNZE88cIKClc3mLc+59pvl1z2Qwm4264OmvGIg5mKhVp50Ff0Ur9ccx3Y8b5JrlRk/XDBviWCG1Ju5M5qrfQ29kLnF1L7R7N8c7qtL/Z9X89LH9gkgWp/RIYg1iOwRzy55L+kncA5XjKyXIoR4=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY1PR04MB9561.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(10070799003)(1800799024)(23010399003)(366016)(376014)(7416014)(56012099006)(10067099003)(18002099003)(22082099003)(11063799006)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RG1VdjNGdmc3RWlKQWdjMmpNSCtpZVM2SEI4eWdQS1ZuOXJQQmZSYmdiM2Vo?=
 =?utf-8?B?ZXBYWmxoSEdVRW9zWjVSVHZlSmpLaE03UUNKMml3UVZoZnVNaDhXeDVUSkRk?=
 =?utf-8?B?MXc1UXdBODNZTDFHMzQxcVBGMkxhS2cvNkx3ZGFBZWRydGlKLy9wRUNweGt3?=
 =?utf-8?B?YldCd1YzUUNPaFVBbk1UaVVvRTJwdVM4Ri9nQVFCeWFFYVFnTDBoSVZmaGFu?=
 =?utf-8?B?T3V1ZG9SV3UveVd1aFpidnpheUc1UUZ5ZWRwV3dvTlpmY0QrOGFBL2Q0bW12?=
 =?utf-8?B?RUVrblRrY2U3NlpGcW5aeXVPSDlmN2htWmhjc0pJT01qbzdTM2VPbFpnZmZi?=
 =?utf-8?B?eWRFQjlIZHppOHhydEQ1WXArdElIeFk4bnlEMm0zd3dkWUVIM0p5aWxJcVIx?=
 =?utf-8?B?MjVqMm5nR0hXODVwQWVQY240emNZN0F1MkhFSmxlS0dSZzNzby9aRmJ1K2xF?=
 =?utf-8?B?bDFqejQ0MjdkZVFqTDhacVBQYmtSWWF6Uy9qUkJnYWxNbnk2LzI1dTNMZFhF?=
 =?utf-8?B?WTQ0V0xCUTNVVFNpd204R3EwejI3UEpVUlpiZzRkemVoaTdnQjdsMUhEazVJ?=
 =?utf-8?B?ZDBLclJIOFBVWmxZTTZiVGxnVFhVMHV5cTdKWnliMEhMWW85ZjFUMUErVnRW?=
 =?utf-8?B?Si8rY05zcDBYTTl1NksxVmR2QnVWSjJwNGpLc0lVM2NZMm5FWEJvcGQxUzYx?=
 =?utf-8?B?YlNTRXI0d1hGRHdsbDJKc3VyWDhpeG93emdyNWNRWUg1b0pWM0MvdlJnM3Zx?=
 =?utf-8?B?Ym9KL0MyajFJRlBvRnNYM1laMlZlVmpYaDNkSDlxT0d3eUtkRjhpTEJHM1lM?=
 =?utf-8?B?QU04bmFGajBxdWxtUE9qL2ZtQlhuUEsvRVJBRWRwam5COU1qQjZET0h2T3Rp?=
 =?utf-8?B?TGcvMGM4NlFaM1JqRXJJSjVUYitEVCthN09UU2JGSHdsaDRCYmZCdC82Wksy?=
 =?utf-8?B?TlBmTlBkTkNsVS9TVmdkczQzc2FPbWZvbWZPTVNWS0pHdXgvM1RpSVlTRXZS?=
 =?utf-8?B?REcwZ2tmSk1hcklkdkI0VVlmUTRBSjQ5RDcyZnpmYUgybUlrRVdLSjZjRzIx?=
 =?utf-8?B?Y05QcERIZkxLMkROb3hJNi9rUHluSE5Gb3RSd0R6N2c0VEZIR2drZVdkVllY?=
 =?utf-8?B?cXdhUVpiL1VzWVhGdFptbWR0QTVua1RQbzlnbVhKYnhJRFNwUlhSeE0rVmox?=
 =?utf-8?B?Q0E0YlIvMk8xT2hMUE02MWpSMlA4cnhHVUV6aWhUVXlROXdZa2VpOWJOK2ZY?=
 =?utf-8?B?OUtybTdWb3V0dHQrUXpEM3Zqa1hib3dnM1pxbCsvaUVjZW5vdDU3czBVbURn?=
 =?utf-8?B?K1hmQk1kVFZINzcyR09qS2xhbnRCLytnbWovQ1FPYVk0NnMvTnYzQzlabjY4?=
 =?utf-8?B?a0s2UEsxVG5acUZDdDJVWUlvRE1qS0U4VzFxc01WU1Y3WUdLbkJxS29mMUx0?=
 =?utf-8?B?czdtUksycmRPT29ra2FyOXB2OTJRam1YUU1iVlpSc0d0RlpwTmFDVDNXTThI?=
 =?utf-8?B?Zm1SQkxqMm9LbW9sckJpUm1QanZXV1JzY201NGxQbmVwcVNMaWpjNkFIblNT?=
 =?utf-8?B?N2Q1NGhiOEhZYkhyaFc1OVM4bkcwYy9Zc2RBL3JIdWZNVmdkUWFZNWkwV01T?=
 =?utf-8?B?ZjZua3FjYVZaZnRlWHBub3BKZU54dHJndmN6UkRNR3ZoN0dENHQwa2dDWENk?=
 =?utf-8?B?eDc3d1NiRnVlZTdRZ3Jva3JSTUhqdGVYSmVGTldwZEFiUExXWmk2Tmd5L1lK?=
 =?utf-8?B?ZVVtZVVxdzVlV3IrME9mUVYvc1dKMEdBaFp5NDVIU2IvQ1VBU0NjTVk2bTVO?=
 =?utf-8?B?aXVJUDJuWm5KQmIweEZScjNvMlpEaXllUW1BRGpKejVXRWFjK3NnTFVRMFVq?=
 =?utf-8?B?Q2NvNjR5bUxpWHdDWjVCS3JaTm42dHZhZTQ5OEtvaUpNcklKS3kvalZGeGVa?=
 =?utf-8?B?TnN4WUh4VUo0dk9tais2cEYzaWJjTlJuSVpLOVhsUHIrUnZzZVF2enVjeWUw?=
 =?utf-8?B?ZG54T3FnckphOFdLZVJqam9Ta1hhU1pZSGRLRUxPeWpoWC9QaEhkVVltQnhr?=
 =?utf-8?B?WGdPNmVyS0oyT2R2UVcrcHo2MzROdHdDNGtXenpZaEJhK3FqT2VjQjFkYnNx?=
 =?utf-8?B?UHhpVHlPTElCbVVibElRZGZ6dUs1NkxaZ1M1VnU2NExkdnc3Z01VRzJOaFpU?=
 =?utf-8?B?WUVWYndteC9rVFVnUmdVMmxodWhMTGkvUDJLVitQYUdDNFZsZmpMb0MrVkxr?=
 =?utf-8?B?ck9XS0YrYjhwbzQ3NFNPaWF4cnE3aTExWm5QZ25pUXErRUE4UHB1ejk3OXRj?=
 =?utf-8?B?N1FvSnJwYU1EVi9xVWM1R3VqYm0vTDZ6aEM1c2ozMHhPNFFNQkFaTjVtdEhz?=
 =?utf-8?Q?nBZI3YnQ/bOlcUb0NtkKqRnWUk9idGPX4+P+RbZSJXutp?=
x-ms-exchange-antispam-messagedata-1: PzzGOeuifqOalvXMaLzxO2VsS2EvEgjoJ1k=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6B232E3165ECA14D80D9BD055635AE4C@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: YyKlrmbiJzpMOB7lkJZQijuoniljKEw/h73wih++igqtUpawXlX6q5yzqvNftJCZnKoVpP91o956KD2ODpaaZhwpIblrT2sDHnIHlYyWlyBHGtuCxQuMkd6rmxVgVuICuuW4ZQ7MlZ/NG3aDA//gmrDjY4Yt0l2O3ZB/guWbv8RQbFD3lKvz9UeYyVs8Wnc1g0VYT4Okk8kPMsHpfD3mgMVBgHLD1SAHh/r5zIW3JKpsghGSv6Hbo2eq2Iaq0rWQeK0n33q8Tlfj/5S0IxFq3drT9/QoMtJ/nv/yMulr5zv9GX/HRZEWNnxD4HAIofoozU+3ktbmhkGH5j5D9CY1DA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: XvnS2GpG5NSzpwI3x6hnfSzfZ1jMKM36OQXTeZNZM9L8Sf/4zqWdE3y3qIQhncvZYvLVim1qB0KO0o3EqPVtfMGOL1HvGnKyYRgxOmcoiCD/azo0JALynBG965xD0rwPQuz+PstTux7Xd3iBiO8Hk/JSOD06fsYVMgcl5gCK1TpKxcaD87dIqgv0rDLvG4as4CPhxIR7cYqZcOn4/3DCz5P7nAIyQt71oVjPq7n8XKzPivezdlbJg3gKKS5UVGKDPgBuSmfeToDRZuPNQ9UOjm6dDhNavu4ffB0ib7GBE6HJyGMs+GmfpOtOQJzyO4nFjZr1shCuNezd8m1nu8SeN7NvGBfVxh7ngkOdzk2ZuHi+YAHbohh/QGJz2QDeApe5WxDH4jScp30sAcHmXIu08Fjhe1xiWbQ5tPeZl8obdIMyzCdlimRFG9VQ2EUO7NZhCRsGTHCTKHkWObNQKjTKVx48K4KVZ0GfHuAu5CG7M+RgSqHJW7GLMiPxtx7wREfgM6MuDI5mVVKXV1Yi0SAZoQVY127E1BOxm/oQtgdCsDH1OTL84Z1h3RMod/AB719LrNMr2Six8iKVflpFXqcq40Su09BtVg5U5syZx0pLEnSBzKbsrRAEtXrzxNQGQj3P
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY1PR04MB9561.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4b6f426-bc26-4a0b-a841-08df025fc6e0
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Aug 2026 04:17:29.1473 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: k8jP9WJZsW+xv33BVrV0URM10EMxmzPTsVijjcGQvZRqtzUJ2/7VwZrAz/7zo8O/35cb6i3UP02lkLU1fj5GbKA7hSXLCgDe8CqJuq2s6fw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB8475
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

T24gTW9uLCAyMDI2LTA4LTI0IGF0IDEyOjM1ICswOTMwLCBKb2VsIFN0YW5sZXkgd3JvdGU6DQo+
IFRoaXMgYWRkcyBzX2ltc2ljX3N0cmlkZSB0byByaXNjdl9jcmVhdGVfYWlhIHNvIG1hY2hpbmVz
IGNhbiBzZXBhcmF0ZQ0KPiB0aGUgcy1tb2RlIElNU0lDIGxheW91dCBmcm9tIHRoZSBndWVzdCBj
b3VudC4gVGhleSBhcmUgcmVsYXRlZCBidXQNCj4gdGhlDQo+IGxheW91dCBpc24ndCBuZWNlc3Nh
cmlseSBkZWZpbmVkIGJ5IHRoZSBndWVzdCBjb3VudC4gRG9pbmcgdGhpcyBtZWFucw0KPiB3ZSBj
YW4gZml4IGEgYnVnIHRoYXQgd2FzIGluIHRoZSBBdGxhbnRpcyBtYWNoaW5lIHRoYXQgSSB3cm90
ZS4NCj4gDQo+IEpvZWwgU3RhbmxleSAoMik6DQo+IMKgIGh3L3Jpc2N2OiBNYWtlIHMtbW9kZSBJ
TVNJQyBzdHJpZGUgZXhwbGljaXQNCj4gwqAgaHcvcmlzY3YvYWlhOiBDaGVjayBmb3IgaW52YWxp
ZCBJTVNJQyBjb25maWdzDQoNClRoYW5rcyENCg0KQXBwbGllZCB0byByaXNjdi10by1hcHBseS5u
ZXh0DQoNCkFsaXN0YWlyDQoNCj4gDQo+IMKgaHcvcmlzY3YvYWlhLmjCoMKgwqDCoMKgwqDCoMKg
IHzCoCAxICsNCj4gwqBody9yaXNjdi9haWEuY8KgwqDCoMKgwqDCoMKgwqAgfMKgIDkgKysrKysr
LS0tDQo+IMKgaHcvcmlzY3YvdHRfYXRsYW50aXMuYyB8IDE5ICsrKysrKysrKysrLS0tLS0tLS0N
Cj4gwqBody9yaXNjdi92aXJ0LmPCoMKgwqDCoMKgwqDCoCB8wqAgMiArKw0KPiDCoDQgZmlsZXMg
Y2hhbmdlZCwgMjAgaW5zZXJ0aW9ucygrKSwgMTEgZGVsZXRpb25zKC0pDQo=

