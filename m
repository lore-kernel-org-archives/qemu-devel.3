Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAE24C61DD3
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 05:41:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x20Bz-0004eI-2D; Thu, 03 Sep 2026 01:40:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=6997dc6e7=Alistair.Francis@wdc.com>)
 id 1x20Bx-0004e2-Fs; Thu, 03 Sep 2026 01:40:53 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=6997dc6e7=Alistair.Francis@wdc.com>)
 id 1x20Bv-00051M-LW; Thu, 03 Sep 2026 01:40:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1788414051; x=1819950051;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=MhlAEDlGr17on7A4GpFt2F4mSEZXSKufcVhVsGqwmAw=;
 b=poWl93EIFFKYlUh54vUMjF87p2XsdwjvvfX3NsgFrpCAzmWs4W+yns3M
 GIeUPX4f3UYQSQlg67gZu4wEHoSUS1sFru4CnaA+dBmcuntDEenOyHi+V
 V+SYjNXKFPBjcjqkQxHcZ3zom+fq6L4V67kAzKnet1FP8thmbr+BMlaI8
 OPX8O32MGfzDHIwKuJ/hcQK/2HcY7xILJU3h/qiziy1w8vmnVuTPPaA8G
 l/B+Nr8kv/ShxVcmt0f0xyEZhtigIXHEFjPHTd5pvOkQHZd1LXRFcCLcv
 XFqcklmIrAqDK/a6DRm1xDMgtrJGPhFdy9XQ2VzrrtrLlxhHqIpbjiBjl g==;
X-CSE-ConnectionGUID: Nc4Ponh8TFq2/aliAloU6A==
X-CSE-MsgGUID: 98J+P+mJR86oedSf1NhZ2A==
X-IronPort-AV: E=Sophos;i="6.25,258,1779120000"; d="scan'208";a="153889565"
Received: from mail-northcentralusazon11010000.outbound.protection.outlook.com
 (HELO CH1PR05CU001.outbound.protection.outlook.com) ([52.101.193.0])
 by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 03 Sep 2026 13:40:45 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AYGb/1vl1dGNePqKVwsIPBf9YKAXqZRvmKK3GJENnfPq5ExFwfBt4wbE/6jpvudmnyJBgEy8PA4tV6InP7uMNHPoZTDUvs27ambbmwpdl7hpazCxe+L2KE6yxfJZjY0vG+0mrP5b9pkj0uf5dW1Koqo1/lWO4+K5Bbrrrc+vqy/vC/aW4vQyTRkfjmB9SJYvDTqvTjmQYEjvrxG7nx0hL3Y8SdjoBIyUaAZ3jIs6PBPtcUD7t4e3MxmBJNZq9rWMMEAWwkc8CiujBrM/21xcSBQMaERW+s1uXY1anTamjHOOIuV/gkQEtWEhGL8Sn474MccPtjC9zTP8GsV410qi3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MhlAEDlGr17on7A4GpFt2F4mSEZXSKufcVhVsGqwmAw=;
 b=H5mCaLiNs/RckG0RnwShc8ZWGQMUIQQtBERQsoTFRUkOsThY2yXQjVQd+QT23TzrGk8qouWl0w8zP/4x7fWTYo7dFTlrrU3LHA40BSV4Vgf2OP8Z4lIXAEFS+1Y82t3CNACb0pVkJg1aJpj7GbepXp6awH4HEiZXVzZzAU3K+eg6qxxFiBlyidJZqfdLq/z5TsIHPLTiTGgcLicpHDpjtL4ZoPfMwCRB89LALq1Gq3hjPmaa5XKOU/NemSpwOj43QsJfyfWYGRtadbWn37J7MHn9YkN9EA1xXYsogtLNdhgol50AnS4BlLvS4cNxS2o7fw99H4gyR29QCjPZGAAGiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MhlAEDlGr17on7A4GpFt2F4mSEZXSKufcVhVsGqwmAw=;
 b=Hoz2AqlaXlRxa2doqcaus1bnxs88sAGB2str4Wqmx8U9+PSYvXzgqaXraiZ7KB+6ILzcISl7ohX4EV0YSkiWnWprLfe+/XB+9/jwC66dGzzzfrRW6BKQDtM5NZwQe2BMCK9eKHnnNSMMYXCBDZRYfOOn2EEvqM4YbLVHgyd4ygQ=
Received: from BY1PR04MB9561.namprd04.prod.outlook.com (2603:10b6:a03:5b6::11)
 by LV3PR04MB9260.namprd04.prod.outlook.com (2603:10b6:408:274::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Thu, 3 Sep
 2026 05:40:43 +0000
Received: from BY1PR04MB9561.namprd04.prod.outlook.com
 ([fe80::3869:e494:2fa8:9888]) by BY1PR04MB9561.namprd04.prod.outlook.com
 ([fe80::3869:e494:2fa8:9888%5]) with mapi id 15.21.0382.007; Thu, 3 Sep 2026
 05:40:43 +0000
From: Alistair Francis <Alistair.Francis@wdc.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "wangyang25@otcaix.iscas.ac.cn" <wangyang25@otcaix.iscas.ac.cn>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "palmer@dabbelt.com"
 <palmer@dabbelt.com>, "daniel.barboza@oss.qualcomm.com"
 <daniel.barboza@oss.qualcomm.com>, "chao.liu@processmission.com"
 <chao.liu@processmission.com>, "liwei1518@gmail.com" <liwei1518@gmail.com>,
 "zhiwei_liu@linux.alibaba.com" <zhiwei_liu@linux.alibaba.com>
Subject: Re: [PATCH 1/5] target/riscv: make mnstatus.MNPELP writable with
 Zicfilp
Thread-Topic: [PATCH 1/5] target/riscv: make mnstatus.MNPELP writable with
 Zicfilp
Thread-Index: AQHdMwFiNFscldWzS0ihwuaK01PL2La8Z4EA
Date: Thu, 3 Sep 2026 05:40:43 +0000
Message-ID: <c37702fefe7188c171eb724d7fb51a3240d662d1.camel@wdc.com>
References: <cover.1787489230.git.wangyang25@otcaix.iscas.ac.cn>
 <78f6f0b01d79a18cfb3a2a64f5219ae043243dfa.1787489230.git.wangyang25@otcaix.iscas.ac.cn>
In-Reply-To: <78f6f0b01d79a18cfb3a2a64f5219ae043243dfa.1787489230.git.wangyang25@otcaix.iscas.ac.cn>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.60.2 (by Flathub.org) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY1PR04MB9561:EE_|LV3PR04MB9260:EE_
x-ms-office365-filtering-correlation-id: 837c33a8-19fc-4d19-1971-08df097de5a5
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|10070799003|366016|19092799006|376014|22082099003|18002099003|56012099006|38070700021|4143699003|11063799006|10067099003;
x-microsoft-antispam-message-info: a06/h7vI9rbQyBjGDmOPBdUHf81tPU3evNclBi70HysLe8KVbkU0+R6wc7RoVWo6t8AXSIi7GJkPBN7dPbP/k1+Fn/S9WXY0F1y/zGWKGDFAWatvMG6ZmNEewJjKBAaqxvfLEJDtpbeKZ1j8WAqE5jk8yP2RNGQWqrBQutTQlF3cV41ZuTpx9OBqECLT+Ce8AV3AxdjVrybH0dnTNnrWrVzjPnxdOqlfaZOq1oJ5hNCenDWA7w1k1IgDq7DHakZaWa3CIvQmRtw0Nq2YYnisxHmTGA2GSRkMbgg95TxtyEgyHKk6C1Wu9Vk+QkIJs/5gUCB3FCPYIgGtbycODFXBhulyeccCjuIzA65VixKsZgC5tHeY/fZOFczYy1QTMD95fmo7mIqnaLgCz6Qa2zDkCbYujnSBh5pc44AWg8b18AIK2AUMiLR1PLP9xlNYeDS+n5eL4o1gppz7eUwm6t6u00Vgd5+nzKNn8yU8vIqU7NzIy8mM3UeM69DmoLTRD/iJQMCOVI5lzPK71qtR+iJ9vje7eyhR74a+Pq1DtAG6amU4NCIRCpVTrhiFZ1DB3OpfdCz11SVdgrcRbtxo8DxTHhez4naZdcPGrXSGPVkXm93AODmYfvPvfalXusF89YFA1O0Q0qHmI7hWlvuopwbiejNZEzd5hw+k3qPqBW7+0Stc/iYQGdkkxabaDc3HhLWqlc+QN9YJVyocP7C67Ugv/6XsdfVZ6vRzrPz8HhAOf5s=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY1PR04MB9561.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(10070799003)(366016)(19092799006)(376014)(22082099003)(18002099003)(56012099006)(38070700021)(4143699003)(11063799006)(10067099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SHd0VEwvZHlZMjFxWmpqVHZrSVIyeVVjUldVSGVkVXExUjM4Z3dkNW0rTG1G?=
 =?utf-8?B?cy9JTlQ4QitNYkVDZWNBd3R4WFBrcUlkRDFUTWFGaHg0MVhlUVlOUm5wdnRZ?=
 =?utf-8?B?RVdPTlNEcUI4WDQ0VEJTZ3VCcnhvS3ZRWlpnNkFPelp2SDdzRmFmcHpTRStw?=
 =?utf-8?B?SmZGcTZ4QkRlQTdtTHc5Tjk1R1YxcnZ0R0FWSjlGcGxXQ1BmVy9WMzBhZkdh?=
 =?utf-8?B?UzNKdHVXb3JrUUhRZ29DbFFISzhNeWRFNjhYRDF6c3lWSEdqWU94aDV5TDZt?=
 =?utf-8?B?OHhld3J6NVRLdU1tRTRCVjBMRlJXdnNJeUxLZTNaUkZmSFlKcGQxcUgzSUxt?=
 =?utf-8?B?WDhocjVZdTlaSkl4OUVLQXpaZWFwK2Fxb2dLV2ZwZittUkZWdW12WDJWY1JQ?=
 =?utf-8?B?K0gvbmJoSnNqdFlnaVlrWEdCd1F3Rm95dUNRSk5zcXA5N3h2V2hpblltOXk4?=
 =?utf-8?B?MHl4aXM2OXpFeXV1UUZCOFhmR24wUjZ6M2NqT0h5N3pTbVdQUjI5MHpMRlBI?=
 =?utf-8?B?NEIvMnVyMGRiM0pxcEc1andzcVhDbVIvSDNKd2lHS202dU94bkErVXI5YldE?=
 =?utf-8?B?akhucUs1QmpNNFoyeCtVSDZZZmNsU0tuQ2N2ZkNtYXJSUnBycDh3Q0Y1VWRD?=
 =?utf-8?B?b1FZNmlDeVdrcmdQVHQzZFZmNlczTi9FRlhIbWRxc21ZYnVCcnNIa29CRmVK?=
 =?utf-8?B?TTkvQ2ZaV1pCbHlZT1BBWkxvdGJtYVliMVJ0NmZCd0xpN1JhWjBDNHZWVUhF?=
 =?utf-8?B?eGJNNUxCaHRnTTdmcEpWZGRJR2M5ZkZGNWs5M2hBaHc5TUdIOUVNbXBMK2wy?=
 =?utf-8?B?Vnc4U1lNeUtHckhBSkN6Uk5TSTRlYy91anhieDN3TWxrOXoxRW1WNDd6N0Ri?=
 =?utf-8?B?YVpkK2ZoQXVLdTh5REptWXRTVDh1bXNLbHN1OGJNeGJjS1RmRlNwM3NvV1pO?=
 =?utf-8?B?U002d0QybUtGcUtQQlJXRERGUGV1aUpwclBWd0NxcHNWZlVGTWdCaWhzOG8w?=
 =?utf-8?B?WXV5TUIvUGQwakp6dmladmxNY3c0dkt5LzVIOGErT203Q2xnNnZYSithQnd0?=
 =?utf-8?B?S2x5Z1NQWmZNTlVicXVOZkdpVDFadVBNbytWM05DQVJaNEQxa0IvUG5KeGMy?=
 =?utf-8?B?Z3FRUDFlajJIS0Z3bnNhcjFuYjZ3eEoxYWx6Zm5UWFFpOTlwblJsRmY3Uk9G?=
 =?utf-8?B?cDFBMWk5K2p3Mkord2o3N2t1aWsxUk9nODJqd0RjWW14Ymxtckd5dEdhOFNI?=
 =?utf-8?B?Z2ZHMk5ESWNVQmVTcHJ2NjlhVmJFWis0RFlPQUhoMnN6OHRIVEF2RTR3THRo?=
 =?utf-8?B?bE4vUENBQ2Z6UFlRajY3UlVockErQjBqR2p0aWswc3o5SEl5UE5mZXZMYm1a?=
 =?utf-8?B?MEw4TmJVdkx2RVIxZ1F2cHVDUGVqbTJLKzkyZHQxV3pxem9KdmZJYmtBUHll?=
 =?utf-8?B?c3RUdnIwYnJUL1BLblY2Q1lOb2RzWkNXbWpnaGl0S2g4OTkwYmMybHk5Z2VX?=
 =?utf-8?B?UjJYNnh4RElidGxXbm5ibUtJeWx2UGx3blV1RkQrSTRwcUFWS09kVUtpeExv?=
 =?utf-8?B?bWRHd0dWS21SZ0FWRmQ0a1I5b2ZzNXdxOSsvQ3ZNMWVkNmlXSmk5T2ZxZytT?=
 =?utf-8?B?aE9NUHUwSENXVVVaTFZ0U0IxdjQ4OG5WU25XNlY3SHVDR1VYMUlybWZ1Qk52?=
 =?utf-8?B?T3ArUjA4QWZySUF2Znk0QWtNYUZKTG1iYzZqcXlYV0g2S0lMUnVwd0hTUE96?=
 =?utf-8?B?clFBN3hMUGNlVFp1OTBjRTRjUHVzZUI0R2ZGTlhHYjNrSG1nU0x5ZEJzVEhX?=
 =?utf-8?B?MXVRc01DV1JKQTZudnpJOHdqVDhrRkhPR2p3NHdUTEljU1NXYk1MQnJUQ0Qv?=
 =?utf-8?B?R2c3SGVwSmRsQTNSK2E2TmhlTC9LbzR1b1hQV1VPandTY0xGZjluUUladFVN?=
 =?utf-8?B?elRraVRRNS9LY1FhVitDQXhyVnNrODNZWlFpUTF3T3lrM3VpUXdYL3NBK2xs?=
 =?utf-8?B?VkM4aTd1MlhVWDFpSWVGMWovN2hMc0RoaDErMVZYd1dVaXBXWnQzZVJVZmV2?=
 =?utf-8?B?cEYxMmc2MjZUdENqaVB6ZExRck1xN2diTlVhMGJxUUZKcmRSc3VTdE5GVDFC?=
 =?utf-8?B?WFVYMUZQaXh4M2p1eUJFazZxeU9lK3NqTjlybGFQVUJBVWRET051UzgxcG42?=
 =?utf-8?B?akt2cVY3S2dnUlVRZ1c2bkVLWjMycGNpYmxESjhiZGxWK3dZU3hnOGY1b0J4?=
 =?utf-8?B?THB6YTEvSlZxOERqclRXeVVTanpBWisreC9GSDUyQUZlK2g4eXovS1VQdWlH?=
 =?utf-8?B?STM1eGpNdnJ3NDk5cEpRaXR3aTcwYldETTBKVHNCNGRKTEJBZTdjT201NWIy?=
 =?utf-8?Q?Jl6a8riA91WOz/f7rqAhbHs8Ba3FXobTwePsgkdPkwj7b?=
x-ms-exchange-antispam-messagedata-1: EVtXTGag6c6sJcQHIE2snHRgDgvnPD3DnlU=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4CEDE0864E965E42A121526307EB6D64@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: xsTumNfCJRmyAUl/J/ODLhKUtT0t8vyY0cJ+N3MRVtB/yK6liAMIquRZnozOgEv4RrPXa1y0YUudUOLC0Hg5ZlbzWCXgd02eTpn48L4xDx5wmZjeb0yi9oJo65/Pzbj3ESr1JkRMnCnU337iCY2qeN0pHpd/oQUf7VchEqTSPj0BifcAUqf8UViFOLZMZYu3z8bvUT4CH1eq96/9zdybzrQ+/bM1adNNvDNAkU4pyZXnP0nHxpx4zbwqi691QN1VlwWtnCPz6rjKz/J/xbLEvOsZY7qWOB6nYa1PyctTI6vXLrpzwGGS1laCf5a4zh85CMLmh4Az8IlS1BuEGq2yYQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Z48NPiJQ0NfzjD2ldouTCC1iN5AybL/LuUBKKgnBn2+9n6ktrKseXNjHqPYoA8Zkxw5etEPjYxDQupLlJTY5QChKSKbYEmMZ/evwjwj/oiYdll7+wxRP64PYzAcWX37N805t/eSVMnfgh5LnS0eBjO5n6tILQlfdSp/1v5vtLYKto+RgLXyD4T2JoxNBF3tpEHmI8SPoaKopeFZLyCe69RNAnly4qrBWxZ+8QOXY4L08d4ongq2mEMMC3f84uapToJvGQBl+ASLKDpX/gPilsqPA/lANMhfYErtxX4szK4Z/uQRoV6CfqZFDy4bj0HbE6uTqT8VZRTsM3navdp5SDLIlizUIXHBzsHDj/aPuiikE4DaRFttaUiLsuiKsujvWysNI/saknWRGBdTdCcgb+LFjw0a8UyZ1D+bFVLDmuPnVoWeftaKjZmbb4W9sPjp9cckX3ijDY5jBRmkv8Eq9nFcORK81587YH7uyyYKNTo9Gf169XHcmmO2r1gmCuYhJfc/QAYopB+CPMhQ6UFghglzsJc10h0F+68AK6TGFiOm38qsX2Y4IpC3ckLYEd044Bcp+clGBx5RvAC5RMjEfKXqU14m/uuo9x9CGiyx+GJ9RyBbRLknO92zbhuCivTZu
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY1PR04MB9561.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 837c33a8-19fc-4d19-1971-08df097de5a5
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Sep 2026 05:40:43.7898 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: n44yug8YRztCOL6yhRTj3hCoJIL9qVOMIivusDq+e4K+w0HAGL/38bVri/wQiP1az1Ovm2XuoO1r0nAMoQpPoQ8Qco9B4h4EQhYH1SC13jo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR04MB9260
Received-SPF: pass client-ip=216.71.153.144;
 envelope-from=prvs=6997dc6e7=Alistair.Francis@wdc.com;
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

T24gU3VuLCAyMDI2LTA4LTIzIGF0IDIxOjE0ICswODAwLCB3YW5neWFuZzI1QG90Y2FpeC5pc2Nh
cy5hYy5jbiB3cm90ZToNCj4gWmljZmlscCBhZGRzIE1OUEVMUCB0byBtbnN0YXR1cywgYW5kIE1O
UkVUIGNvbnN1bWVzIGl0IHdoZW4gcmVzdG9yaW5nDQo+IEVMUC4NCj4gSW5jbHVkZSB0aGUgZmll
bGQgaW4gd3JpdGVfbW5zdGF0dXMoKSB3aGVuIFppY2ZpbHAgaXMgaW1wbGVtZW50ZWQuDQo+IFJl
c29sdmVzOiBodHRwczovL2dpdGxhYi5jb20vcWVtdS1wcm9qZWN0L3FlbXUvLS93b3JrX2l0ZW1z
LzQyMjINCj4gDQo+IFNpZ25lZC1vZmYtYnk6IHdhbmd5YW5nIDx3YW5neWFuZzI1QG90Y2FpeC5p
c2Nhcy5hYy5jbj4NCg0KUmV2aWV3ZWQtYnk6IEFsaXN0YWlyIEZyYW5jaXMgPGFsaXN0YWlyLmZy
YW5jaXNAd2RjLmNvbT4NCg0KQWxpc3RhaXINCg0KPiAtLS0NCj4gwqB0YXJnZXQvcmlzY3YvdGNn
L2Nzci5jIHwgNCArKysrDQo+IMKgMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKQ0KPiAN
Cj4gZGlmZiAtLWdpdCBhL3RhcmdldC9yaXNjdi90Y2cvY3NyLmMgYi90YXJnZXQvcmlzY3YvdGNn
L2Nzci5jDQo+IGluZGV4IDM2ZjIwMDQuLjVmZmQ4NTggMTAwNjQ0DQo+IC0tLSBhL3RhcmdldC9y
aXNjdi90Y2cvY3NyLmMNCj4gKysrIGIvdGFyZ2V0L3Jpc2N2L3RjZy9jc3IuYw0KPiBAQCAtNTU2
Myw2ICs1NTYzLDEwIEBAIHN0YXRpYyBSSVNDVkV4Y2VwdGlvbg0KPiB3cml0ZV9tbnN0YXR1cyhD
UFVSSVNDVlN0YXRlICplbnYsIGludCBjc3JubywNCj4gwqDCoMKgwqDCoMKgwqDCoCBtYXNrIHw9
IE1OU1RBVFVTX01OUFY7DQo+IMKgwqDCoMKgIH0NCj4gwqANCj4gK8KgwqDCoCBpZiAoZW52X2Fy
Y2hjcHUoZW52KS0+Y2ZnLmV4dF96aWNmaWxwKSB7DQo+ICvCoMKgwqDCoMKgwqDCoCBtYXNrIHw9
IE1OU1RBVFVTX01OUEVMUDsNCj4gK8KgwqDCoCB9DQo+ICsNCj4gwqDCoMKgwqAgLyogbW5zdGF0
dXMubW5pZSBjYW4gb25seSBiZSBjbGVhcmVkIGJ5IGhhcmR3YXJlLiAqLw0KPiDCoMKgwqDCoCBl
bnYtPm1uc3RhdHVzID0gKGVudi0+bW5zdGF0dXMgJiBNTlNUQVRVU19OTUlFKSB8ICh2YWwgJiBt
YXNrKTsNCj4gwqDCoMKgwqAgcmV0dXJuIFJJU0NWX0VYQ1BfTk9ORTsNCg==

