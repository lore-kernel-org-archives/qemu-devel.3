Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CCEBC61CE3
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 04:15:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyiYZ-0002ox-3j; Tue, 25 Aug 2026 00:14:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=690dc056c=Alistair.Francis@wdc.com>)
 id 1wyiYX-0002ok-OL; Tue, 25 Aug 2026 00:14:37 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=690dc056c=Alistair.Francis@wdc.com>)
 id 1wyiYW-0001n3-0y; Tue, 25 Aug 2026 00:14:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1787631276; x=1819167276;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=IFptMM5MQQNyEJvsppgKqSn5MGNICqsiOmblhPaaSPI=;
 b=KZlP5/e25RqYs9M9pqj4SBiVjHZBBzSvLHDhGm/rVkoUA5vY6t2kOmIX
 4+0CX7Jz1a4YRWYfRBuLs4QaIhT4D16ycu/kZQVL+S4pXF280aTvdZxe/
 lDG8uiKme90JE9NnSiyDolcWX0LXyRYZ9cnqNsl6aXYs0g9YnqCdtb105
 q9mjP9PEAEq9PXNbF55z1Oa+wYLg3cZBfydFDbrBcotA/tIK0imIO+/17
 7bGYpLzam7RBfjtMLr2hnqUgUxNFOH0OJPPO4krKgPvvVuYVRvH00st2f
 ho5lZZDIVUt5WSksII8447UQQn77uO362bAJjq+6pJiBuouZlTruAN6+A g==;
X-CSE-ConnectionGUID: W+MD5LxQRkWCwyY5bKVi1g==
X-CSE-MsgGUID: jPk3ANZbQfiv/dbnLrgCOw==
X-IronPort-AV: E=Sophos;i="6.25,242,1779120000"; d="scan'208";a="150004507"
Received: from mail-northcentralusazon11010062.outbound.protection.outlook.com
 (HELO CH1PR05CU001.outbound.protection.outlook.com) ([52.101.193.62])
 by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 25 Aug 2026 12:14:33 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TVjpDk1sB3nnT9tOLtLt+vcB8kKPqAdy9H8gtcD2wrQn2CRcUsZgvm/mlzphJ//lGT+/ouGcY8GNG1ICUqzzOd+gmqujUsFpRwuvyOCr66ltnajH8FUNAMTRI5omEV4cJf0B35WIjINpI/j+KVJYpDuB6DkDvxfXIHdt/Naw1Chpyeyj4J6/47ej9HLAvyPHKLq3xudCkFFJiQh2R/tYhV+EIdBbx+9j5vasYZ/Bhd/bMB3f2RcR5npFiYTtqefroxuBKXb7/llS5Mqizh689scxPWafKAIaKEHs/B7CBdXW4t9/IQjMTkqR6YP8PCvh7qSXrdru9YjwUDrnRYiFHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IFptMM5MQQNyEJvsppgKqSn5MGNICqsiOmblhPaaSPI=;
 b=q83b1S0Z52p/vdqY86nBLwmFhKCleJ6cQzBuhQNKR0MVQpXVXKw5njGCZgqte2yh9Yf1GlFMTRcKWN/wgeRx1Qp5CcJHDF+P0sEJb/Uv3JetpbbAeoRnN0JG/bz2UCNia5577ij8ltzsBHmZLZLvL63lJPUwkdq7wD33Zj30b3E22a5e5mGKCTxzagv76X840asml2vB2JBfd02oy1YgAVjjoaweJFvVXCo/JUUm3QRbH54IfOJ1A4UlqB5U/H2C178YKGT/Pd3g30g6XhA6BYPhKuKnxFIYNBiMUqEjhCoLWS7KeZKqLVK2hj3EHOcdNCgM1EM8CsZdQWz7w/0Jtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IFptMM5MQQNyEJvsppgKqSn5MGNICqsiOmblhPaaSPI=;
 b=bjvrouyfpcUoTjk0Jw5helH0KHGEt/wWLpcEKce3xKYz6Dcai+zzKFzegWzsuqxvwrF1jVDgj/4FBPi3nuDMjlxq+iKmXxDcX48gN7JfnTfOUcVhymCFcU9EL9Ye1cIKj3POgZD2wwRHk3biyV1IaSGmPoAbwIpIhQzUqP3ov1E=
Received: from BY1PR04MB9561.namprd04.prod.outlook.com (2603:10b6:a03:5b6::11)
 by PH0PR04MB8475.namprd04.prod.outlook.com (2603:10b6:510:29f::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.6; Tue, 25 Aug
 2026 04:14:29 +0000
Received: from BY1PR04MB9561.namprd04.prod.outlook.com
 ([fe80::3869:e494:2fa8:9888]) by BY1PR04MB9561.namprd04.prod.outlook.com
 ([fe80::3869:e494:2fa8:9888%5]) with mapi id 15.21.0360.005; Tue, 25 Aug 2026
 04:14:29 +0000
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
Subject: Re: [PATCH 2/2] hw/riscv/aia: Check for invalid IMSIC configs
Thread-Topic: [PATCH 2/2] hw/riscv/aia: Check for invalid IMSIC configs
Thread-Index: AQHdM3WOv7BA1PkWN0q10EVYo2omJLauKYUA
Date: Tue, 25 Aug 2026 04:14:29 +0000
Message-ID: <7a3f7a45e518387bb1796b212d410bc39de53ea4.camel@wdc.com>
References: <20260824030509.18078-1-joel@jms.id.au>
 <20260824030509.18078-3-joel@jms.id.au>
In-Reply-To: <20260824030509.18078-3-joel@jms.id.au>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.60.2 (by Flathub.org) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY1PR04MB9561:EE_|PH0PR04MB8475:EE_
x-ms-office365-filtering-correlation-id: 1f04c006-7236-4eea-5c7b-08df025f5bb6
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|19092799006|10070799003|1800799024|23010399003|366016|376014|7416014|56012099006|10067099003|6133799003|18002099003|22082099003|11063799006|4143699003|38070700021;
x-microsoft-antispam-message-info: /vwb/No+MjsIv4aSUlvVD4wQO7kdee8Ggd80Hxs4omgIcmbPRJvYwIXa8tB8S/7sPH1g0OJNNegTaz+ATxExqMVyaW/5/e5AzB0ypbxmBAbHrMl4ALltL6qFT0jdpd10oJcUe2wYQoigC8pCg0X6oRm7LoWVPoIvQ8F2nAamCAEefwxvEOjYVeWXXMiRAWNhEMQiPyqYJzUmIwsAC9ddp+0VLtt/eXsoCeJCp+4Wc1D2zqvve9+3uBWMypCz7mOakfwolf4GezWM6AB/I9BrMYaIU0zF00qkGRsIV4PD1Y+d0NrfAQaBy8e2UIoXuzeRhTtNnutWCqBDC53NV9S+wBWTQ+tFmiGlmWqUG6wQrNWQZ9gdyrXgGtMSptdsyzpfBX/8LPWt14t1WY+dNDTkTIkBl6/g6XeN1ZE2FKnYhVoJ+/sTF6/WuvcJrJKAbNLnNvBwqHNz40Tx9h7oRn+Ip5DDE9jmXt41ob+B4FGc6tc3WljwQvYFsMhDLTtqUBShO64wUYCWNC+JzZirNApRB5f3VDLW7Yf/NDWWAs1vZobh2+CLDjnDBYEXDRNc+finVOXo8kThl4Y7PXkZ3kyOOo0vVRUwSYNTvPqczUeacYj/tW9htDF7ZRZvrNjcq+cPQa38BddV+gLdUMsjMFfctPPQ/9YFUc45wI0XoRQKsTLQjwcWxsUkmng79s8Fmn0Gtw/TyIsxXT6IWja/s3iD8g==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY1PR04MB9561.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(10070799003)(1800799024)(23010399003)(366016)(376014)(7416014)(56012099006)(10067099003)(6133799003)(18002099003)(22082099003)(11063799006)(4143699003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OE5iWVlwVGxaMWlEdkhFRHVMVW0xcEJPNkowa3VDNm5EZlZTSXB2Wm5TWW1D?=
 =?utf-8?B?a2oyeVFsQk9lT0xjcENFNkMrckd4VFhjYmVKOFFzeXNkbDFtRExiaTJ6RzF3?=
 =?utf-8?B?MzFhaVkrS1B2YWpLTkFjMm1wUzZCZU54dVNDSjdaRjFTMExHckZNZnF6V0Jo?=
 =?utf-8?B?Nk04NGhDNmNxVUo2UHNLd2RuNDA3aFpHMjR3MlJ1UlhZWTAvVnpDeU9tbUhI?=
 =?utf-8?B?Y1NvQzVsQmRVNjh3UnFOclZydVdVQnJTWXM1LytYS3BnOWllb1BRNHhIQ2F5?=
 =?utf-8?B?a08rWmtLMmtzanJ6Vk9TeVRlUHcxNEVHNlIxbytPQytoa2tFSzY4ZHdpMG1X?=
 =?utf-8?B?Z050cHhPZ2wxVEE3dTljaUx4MFZxbGV3eFJtcERzV0toL1k1YzU4UHlhUTNR?=
 =?utf-8?B?U3o2RzM1ZFgrWkNRaXV2WUlMb2FJRzNjNS9ZMTJJeXUvSUllbEZmazJJZk9m?=
 =?utf-8?B?MGNCcVByYmlxRWJ3VGtNNXBKbVQxY2lCTU9Sc1ZCUWRacWU4YmZqaE8vbDBz?=
 =?utf-8?B?YzhaSXMvdkhuZVEzbEZZTkUwcFZOSmEwZ3BCZDdzSlc0MXhOa0RxaGdtbDIw?=
 =?utf-8?B?aStPdm15Z0EzR2sxYXV6aUhiMmkrek55U01YNDZUdGlkMlZWU3dLQlJZOXFO?=
 =?utf-8?B?T3YwT3NXUUtoeWk0Kzk1VFNXWVdnSlovclptTVd4TzRNT1pRVkM0TDVyZENE?=
 =?utf-8?B?OWhFditsc0RvdjdTQ0V6bm1CRjlPTG9KV3NYaFF3b21KcXIxV1psaEZsbzVS?=
 =?utf-8?B?UERmYWdHdFJ0Ulo0SEtEc3ZjQUU0TFJyM1J6MjFSQTR4U1JpMDZRMXV5Z21J?=
 =?utf-8?B?MlQvYXNOOXVNRjFDMzVsaFFLZGRLWkNaWXJMcmMrcXRuSWEwWDhCT0FNRVVX?=
 =?utf-8?B?QllaYXRaSVVuQWpQSDM3amZ4aThqNEZJT2dPQWZ3NFpZaFBhS2F3bVVnWWNG?=
 =?utf-8?B?ZU5mWEQ1eUxDdk1zNHZGOVZwUG9TaDg0VHFLWXB0Z3ZMTHEzR3ErVnlHUFZi?=
 =?utf-8?B?UWE4QUE4YkJqaXBvYzBoYjc1RllMOHIyMU5COUtJVTREK1hscnJDemtwQk5X?=
 =?utf-8?B?SlJRK2xkdkRseWJPN0c2cXF6c0xKYmY1Rm9JM29wcDdrVU02ZWNvc1d6RnNo?=
 =?utf-8?B?Y3o0aG5OQWdWaHg3OEZuSFZLdG9qRG5IU3MzNTFXQWFkdFZHRXY2bFRNSEZO?=
 =?utf-8?B?ZGl0RERSaDJwNnRXQU5mMnZLWjdscU5mV1ZqUnpuVXlzMU9HWFFCZk03OGRO?=
 =?utf-8?B?NGVnTWJMaFhmd1l0UEkzL3llMnNvOXF0STBjbXNMRUF0bVJCcnlYd3dRSnFh?=
 =?utf-8?B?MzJCYnZqUzI2NDRoZFF0amVwc0Nzd2YyT1hnOG9wcW55SmI4MS8xMUFTNWV3?=
 =?utf-8?B?WHFIQkdkZlVKS1JZQURJem1SRFNKYmlWK0syR1FoVkxYeG50eE45YkxHRm9u?=
 =?utf-8?B?SnRXN2pjMGVnbXR5NUhCa0xlbVFIMnphbUtTMTcyUXVlWll4TTRWUm9aZy83?=
 =?utf-8?B?elA2M3duT0lYYkJKK0RmM1dKNWJFWTVMaUVpUHBPVGtsaGRpUktsbkF3UUNm?=
 =?utf-8?B?SlFWMVFiM2NkNFYyRzBDQkdmNll0a1ZSaXZIcDdKWHdoMC94L0FmSFpYVDFq?=
 =?utf-8?B?T3hDRG83U0NhTVVkR20wYlQyUVJsS1NxN2s5dUZMb3krd0VYTFpKbzNvN2Qy?=
 =?utf-8?B?L0lZbFBnUkMxMS9QV3NBU3VRZzZIZkFrOXhEUU5Ub2FVNkFuU2t4SzhscVZD?=
 =?utf-8?B?bWxvaWtBUklrT2NmTzQvNXFkQWlHMDREMnBQRjNIa3UzVTU4OEpWaUtlakov?=
 =?utf-8?B?K1hlMy9OMXlRYmgvNzJGdEFoMlR3NSt5UEFhL0VLS2ZCUE11Wld5VTlpRk5n?=
 =?utf-8?B?NzZOSnEvS0lYNVcrMHQxSWJqeENvRlpmZ3lMakdaVnJQbUV1K1dxOTV4TUMy?=
 =?utf-8?B?d0hSSW1RdHpXTHJjZk9uQytudG5nMUVJeHozZXVJYngzbCtqWkNyaWdqVTZa?=
 =?utf-8?B?dHBpWHJDbjhLSE9JbkVnT1drVi9ZRHpidlg4NGh2QmtCaTZ3U1BSMHhzODBK?=
 =?utf-8?B?R3g5Ri95aEpubTNMOHZHbWJ6YnZ4THhXaFVHdkd0RGk4T2VwZXhGNmpKd0wx?=
 =?utf-8?B?NlhBL1VOMUJIMVN1V3YxaWoyNGVSSHIrd2M3QkYzaDUrRFNHdFBpWTVMSkJH?=
 =?utf-8?B?b2s4RDA4aVZDYk9WZ0hMQWZwRGJnTGFpRXBBZlFVMjN3Q0hmTUxIR2h4WVdu?=
 =?utf-8?B?aExYYzVaQ2cySTdIRDZiU3pHeDd0QVhPUDlJdWsxeXdHRUIxVFU0cW9wcHY2?=
 =?utf-8?B?bGtSRDAwd2NjL0g1WFpoeXBRczNDN1VrZkZHbzYwRG9ZYVZUNkVDaDh6Z3Vk?=
 =?utf-8?Q?+z0OG5YJR3I1QHDuNWVN1w9rhsPUk2/serSC8nv04MawZ?=
x-ms-exchange-antispam-messagedata-1: uzmBUcydSwuSQU6G0l2VndvoEaZNT0nJAXU=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B2B974A71F0174468D4CCF5A704DD7E4@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: Qn4Qzrcc4Kf+yBBYVJsEvwyhvkSL2+ycYgZGceWANbdCxWdcOuDV7XFqBMi1rlzSmAtTdL/W9sOPT7Xqep+i2CYTxPwPTwyeBieS/qmCayvZGK/mE1cYaGQ7QZJjEol1sfK6Kr0+/kcsHhxHY7WmkEYrX22vBMgEsaFO7AjbKv7rPU+7X+I/BUEdsgq6RVxu4rls+Md5Ml7+tOnrQtBVuZ/JAr62/S5g9Z16i9ubfkzhbgkCzdytx/xLBtVD1JQpd2Q+7c/IN31HKB7ZafebYDAlnxg3qjwY7Q+nqEsncXVWudxztO7vA26onWeIkUnWmuERIhBqH/2umzPH/TbK+w==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: UjqEx97N/kLz8jcFMylGuRP2mqX1rNAztTOIk5zTtw8uGWAaflL+f9sVzjihYNDiPqBf7K0MDsBFmZHLD5hpEDdI7YfiAUlArDtLdN5Qql0SzFUWxV6MQWHxQizgGXdFxw5TU0ifZ4sLN+tpqtPGit0y42XOyMg0ar+wKqXOt+LWU2yhyWxo3go2cx3LMeelbaKWaus07DPdciVIp4yY9pBJYfxBz2aHrG0ghSKTwwyQbT9NNW1YUmHbPvhWukBm5FiubO6cVeofc4mDHzOEByKBw/mnvq/aQD4f+nrMcQOVYaL0K/6sl3TfyK6B+OoBV+QBVl21p6rt8El9hMvbjVWqYG8EH/873IBucrs4+kUdQvrCQzQRUx56OKREelvEdT8xwRMQNI3+7Q8K8FU16SgOFY3systdIQbB3D9hxdxOxG7VrVI6qNV5Lwzx6u8qYzYd+Kl16J2fEOJ2qlw1eFsN/BnjNfmec8qj0KpCnN3BWdutP2fDzkZ2pTM4EWBmvUXwdutVWDr9hzR00Z51CZpTYL9YtA+VjNBQ+Yrh69WEE0kklhlhzF6HFHwJr2vUcLhvLy72uUMZTCpJinQUzBtmo3Waa8CtuytcMCiyziryecMxmRLi5Rfg1IOhfmn6
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY1PR04MB9561.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f04c006-7236-4eea-5c7b-08df025f5bb6
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Aug 2026 04:14:29.3409 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uCti6MkgVxBJ3ILcRauH/e1umBngEFGLsXmlKP/zEpuLs80AAGyMN26IsEEcpJaLIGS6ZSJsDRYFRjG9QeZg4T3gcq64ObgLsm/BB6lAJUg=
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
IEFzc2VydCB0aGF0IHRoZSBJTVNJQyBsYXlvdXQgd2lsbCBiZSB2YWxpZCBiZWZvcmUgY3JlYXRp
bmcgdGhlDQo+IGRldmljZXMuDQo+IA0KPiBhaWFfZ3Vlc3RzIGlzIGEgY29tbWFuZCBsaW5lIHBh
cmFtZXRlciBidXQgdGhlIG1hY2hpbmVzIHRoYXQgYWxsb3dzDQo+IGl0DQo+IHRvIGJlIHNldCAo
Y3VycmVudGx5IG9ubHkgdmlydCkgc2hvdWxkIGJlIHBhc3NpbmcgdGhlIGNvcnJlY3Qgc3RyaWRl
DQo+IGZvcg0KPiBhIGdpdmVuIG51bWJlciBvZiBndWVzdHMuIFRoZSBhc3NlcnQgaGVscHMgY2F0
Y2ggYnVncyBpbiBmdXR1cmUNCj4gY2hhbmdlcw0KPiBhbmQgc2hvdWxkbid0IGJlIHRyaWdnZXJh
YmxlIGJ5IGFuIGludmFsaWQgdXNlciBjb25maWcuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBKb2Vs
IFN0YW5sZXkgPGpvZWxAam1zLmlkLmF1Pg0KDQpBY2tlZC1ieTogQWxpc3RhaXIgRnJhbmNpcyA8
YWxpc3RhaXIuZnJhbmNpc0B3ZGMuY29tPg0KDQpBbGlzdGFpcg0KDQo+IC0tLQ0KPiDCoGh3L3Jp
c2N2L2FpYS5jIHwgNCArKysrDQo+IMKgMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKQ0K
PiANCj4gZGlmZiAtLWdpdCBhL2h3L3Jpc2N2L2FpYS5jIGIvaHcvcmlzY3YvYWlhLmMNCj4gaW5k
ZXggYzMzYTNiMzJiZDQ1Li5jMWE1OTgyODU2YzUgMTAwNjQ0DQo+IC0tLSBhL2h3L3Jpc2N2L2Fp
YS5jDQo+ICsrKyBiL2h3L3Jpc2N2L2FpYS5jDQo+IEBAIC00Myw2ICs0MywxMCBAQCBEZXZpY2VT
dGF0ZSAqcmlzY3ZfY3JlYXRlX2FpYShib29sIG1zaW1vZGUsIGludA0KPiBhaWFfZ3Vlc3RzLA0K
PiDCoMKgwqDCoCAvKiBUaGUgUklTQy1WIEFkdmFuY2VkIEludGVycnVwdCBBcmNoaXRlY3R1cmUs
IENoYXB0ZXIgMS4yLg0KPiBMaW1pdHMgKi8NCj4gwqDCoMKgwqAgZ19hc3NlcnQobnVtX3NvdXJj
ZXMgPD0gMTAyMyk7DQo+IMKgDQo+ICvCoMKgwqAgLyogUHJldmVudCBJTVNJQyBNTUlPIHJlZ2lv
bnMgZnJvbSBzaWxlbnRseSBvdmVybGFwcGluZyAqLw0KPiArwqDCoMKgIGdfYXNzZXJ0KHNfaW1z
aWNfc3RyaWRlID49IElNU0lDX0hBUlRfU0laRShpbXNpY19udW1fYml0cygxICsNCj4gYWlhX2d1
ZXN0cykpKTsNCj4gK8KgwqDCoCBnX2Fzc2VydChtX2ltc2ljX3N0cmlkZSA+PSBJTVNJQ19IQVJU
X1NJWkUoMCkpOw0KPiArDQo+IMKgwqDCoMKgIGlmIChtc2ltb2RlKSB7DQo+IMKgwqDCoMKgwqDC
oMKgwqAgaWYgKCFrdm1fZW5hYmxlZCgpKSB7DQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAv
KiBQZXItc29ja2V0IE0tbGV2ZWwgSU1TSUNzICovDQo=

