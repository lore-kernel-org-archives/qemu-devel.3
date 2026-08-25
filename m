Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE506C5B572
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 04:27:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyikr-0008HC-IO; Tue, 25 Aug 2026 00:27:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=690dc056c=Alistair.Francis@wdc.com>)
 id 1wyikp-0008Gt-Dl; Tue, 25 Aug 2026 00:27:19 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=690dc056c=Alistair.Francis@wdc.com>)
 id 1wyikn-0004i3-TA; Tue, 25 Aug 2026 00:27:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1787632038; x=1819168038;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=RhBXMNo3b3OJIrvphpSG8bLbhebR66lZAcCe9NPcR80=;
 b=IrSnu7KEXcIqmMT+NmoXOTiDG9233xr8UARpD0ICpIsaBwLQg46eiv+8
 Gk3EOfNB3zLeDse7/rIFt+jKNAlShWgl3GVhgEHd0DwciAfhEpPjejED9
 GHfnp/+GyI+HMaLtQI/sOHuaA4mit0x2XcMjjrIsj16tFo51vVS3NThWX
 5HxL2Huim5HTyhyhYXRTGlCRnId1cYroNWQCbfC9hQJqnZ2ULDB8J1fuu
 PKKl3dUdB7doJAotD7xNyrOKCEU/uLaKbwpGE+PB2az1o2AleKX9zyZxq
 kb/FyTxXZC4Mvbxq/HUCD/jbxvCb+pdyFdIUP18PnCn2OnLzape/VtnZR w==;
X-CSE-ConnectionGUID: C0RZfS08QuWecQAHoAoJ0Q==
X-CSE-MsgGUID: F6nAhqXhTIWfYPxaLPmIeQ==
X-IronPort-AV: E=Sophos;i="6.25,242,1779120000"; d="scan'208";a="150005026"
Received: from mail-centralusazon11011016.outbound.protection.outlook.com
 (HELO DM5PR21CU001.outbound.protection.outlook.com) ([52.101.62.16])
 by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 25 Aug 2026 12:27:15 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SYAC2LX+mXCxsq0uQogbiYnFZph0WmMGd9mXABqCL/16v3ww3zBH33daZMAZ2CqeUICsd53MSq96hCOAAYAUzCLzAuJLiY+W/zGg1Cb1sYP6whBzK1ugWxFx8VxRJHOxTJeFRc/lzHwWKypjPhUZ76ybvOui3K9YRLKq+zfLv/bVitox+IdNH8t9TOFkoDtsQF/g9ocs2bJqihju6yirI7Xe/UDgjsEDnBrS8ZTlcTAgfdRwJOfRjI96O806ooP1BjDa60GbGFs6Ca3MQw0GTxZBybJYNPk6z+hze9lraKQAHBNxyHgBJkZMZXDJRfo1hbRBA9JI55JuT2c1r9X9Jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RhBXMNo3b3OJIrvphpSG8bLbhebR66lZAcCe9NPcR80=;
 b=Sd9zqDD6L6NW1AVQaZc66yMYVsQckj5RPKn39x0BK3qh1fbFBMMxNlFohUlbU+mc2mSorfgFBNy3oLL1JBE7IViqp3jfLI8MpoUZyrfrHcQP6n1px0MDRcQlo/EwYDOgFJPyjHF3I6ib1kmQtQOF5Dj15ShCLOmGbS0ngXVgzUcsK6Nk+le33K0p2J7SKr8JIuyp+hhUu/X630Vipd9xU11xkL77nXsRF3bDs1hmAg/FOPScR6VSnxyK/yDKHt9b3jhsL3ywT5Hsx3+GnPX8l2h/E8z3GVIof9tNQR+8IJw1pVtLj4DqfKUDwQ1wHpOLHUrXSOkgeFN1ZySkSi8F1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RhBXMNo3b3OJIrvphpSG8bLbhebR66lZAcCe9NPcR80=;
 b=g8pYl/mnkkPVv6djDU9gjOcvNhkd2XHu3lJJDuHy4dB1IA6Ldu9tfocoZj52kEZHlZG4CW5nRqBmndfzvhjaedb1Cm9nW3hDsFcCFC3x15sDv2lky4/yemFt0dW2caAsfHWCP/qeQZaiZE2quLzwma6LH4iD9NDsUPBFbiBLXZE=
Received: from BY1PR04MB9561.namprd04.prod.outlook.com (2603:10b6:a03:5b6::11)
 by MW4PR04MB7203.namprd04.prod.outlook.com (2603:10b6:303:7a::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.6; Tue, 25 Aug
 2026 04:27:13 +0000
Received: from BY1PR04MB9561.namprd04.prod.outlook.com
 ([fe80::3869:e494:2fa8:9888]) by BY1PR04MB9561.namprd04.prod.outlook.com
 ([fe80::3869:e494:2fa8:9888%5]) with mapi id 15.21.0360.005; Tue, 25 Aug 2026
 04:27:13 +0000
From: Alistair Francis <Alistair.Francis@wdc.com>
To: "max.chou@sifive.com" <max.chou@sifive.com>, "qemu-riscv@nongnu.org"
 <qemu-riscv@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "palmer@dabbelt.com" <palmer@dabbelt.com>,
 "daniel.barboza@oss.qualcomm.com" <daniel.barboza@oss.qualcomm.com>,
 "chao.liu@processmission.com" <chao.liu@processmission.com>,
 "frank.chang@sifive.com" <frank.chang@sifive.com>, "liwei1518@gmail.com"
 <liwei1518@gmail.com>, "zhiwei_liu@linux.alibaba.com"
 <zhiwei_liu@linux.alibaba.com>
Subject: Re: [PATCH v2 3/6] target/riscv/cpu: Add SiFive custom int8 matmul
 extension implied rules
Thread-Topic: [PATCH v2 3/6] target/riscv/cpu: Add SiFive custom int8 matmul
 extension implied rules
Thread-Index: AQHdKoJHmBEnHzURM0e0NlZPadgb8LauPvsA
Date: Tue, 25 Aug 2026 04:27:12 +0000
Message-ID: <d3357e11c9495df27ad956908383a212eaea4def.camel@wdc.com>
References: <20260812174417.2468981-1-max.chou@sifive.com>
 <20260812174417.2468981-4-max.chou@sifive.com>
In-Reply-To: <20260812174417.2468981-4-max.chou@sifive.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.60.2 (by Flathub.org) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY1PR04MB9561:EE_|MW4PR04MB7203:EE_
x-ms-office365-filtering-correlation-id: 3eed4bac-fbdb-4c33-621a-08df026122dd
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|19092799006|10070799003|1800799024|23010399003|366016|376014|56012099006|10067099003|18002099003|22082099003|11063799006|4143699003|38070700021;
x-microsoft-antispam-message-info: 8KojcutDBy/oJlmPaIUKdkWzHlyw+WHLuQV7PHdO7hyWdfCCFgxip04L11j97GyQvpTkUMR43BLKIHMbk1t186In6CJHZZr+Hpu+naK6x+oezTs73wYSmyAbH6ou4i0vf232c9pDxTrKdoLKzNImU3OQK+ekW0gCQJw05i4v9TCyhVKkXj3sPPibQ4x1MyNmZppsK7J1x8UHRhzbat0CrG+wbES/Jgtxu6QUx9BKkuRbK/2jTnCNXOCx6POl69usTVV6sf+YwRAMwaHQH/6UCxOc6Gh0N4/h49jk4fTANxTOvhvYH1kMbXWCf57iDgS6UgPODDRhRKKXyDZVPiLeAibv/mHYvjUQJEj9gx1UUsLclor7Ku0kA7OCKThgAeuS0CFxTOZWG+S8UAouArg0Zdv4KJ+c9nGHhJqX5j1p102U3ZV/ComOeZ3WCZxdXl8wKQuYQbE5t818dIzTu9ZYi3hhrJDQaiwuAy24IuxibE62rVoXR0qdzMo3K9piRxsbRkBFokcVH2UzZCVLcVQQUsJ+Wpm/fbna+6NN2vwb7+H+ysL/PUe3Zp17MGgKeuAqPbA8mlfcWWazhDvdlVCKDmTn5csTavFPh9SnsZdHp0laiBxOvUIJpN7+L4QA5LccAnwX38nvRt8gVVv9EL1oWiJBAr7lUmFA35okcDLInT8LzVVSjJL5N17KzbyY/SYFacPO6YuHq7Q9ckYJWnqn6lTWP5kUp9hJQ2FIL8Hcifk=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY1PR04MB9561.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(10070799003)(1800799024)(23010399003)(366016)(376014)(56012099006)(10067099003)(18002099003)(22082099003)(11063799006)(4143699003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aXZ5a1JQN241bEI0TjhtTlkxK0w0OUtudHhUS2tuSXozNEt4eEEyOTArM1dL?=
 =?utf-8?B?b2cyVkRwaHUyOFZhRHM0KzVqY0tTWXRtelhYRXBGQTlib09xWTBUVm5lVHBR?=
 =?utf-8?B?T2x5bGdNWkYwWEplT3hLT2Rtd3JsTkRraVBEZDhsS0dSNXg1NU9KR2FXb092?=
 =?utf-8?B?MzdsZk5rNUVjRFpkWjhieWFXU0xweW41aEc1andVMHdmS0RJUW5OUFlJYnc0?=
 =?utf-8?B?aS8wS0t3OG41RGNIU0d1MXRocjRaa1VYTktLSjZyN3dWMy94VkFFRy9yNGJQ?=
 =?utf-8?B?MVRneDZQajdtdURMclQ1VzAzQm85SXJBYVQzSXgzRlE1akFZNUdmMmx5eUV2?=
 =?utf-8?B?d296S3RQTHJBVEJHQVo4Uy9yekxSckZzcG9tRllLVExYZ2g1d3RGcG85TEJx?=
 =?utf-8?B?VUY3S3QxTDhCcDJDZGwwVFFyZkZ2SEY0UFhteXdkQkpmR084dmVwdUZscDdl?=
 =?utf-8?B?S3Jkd295SkZZYnFCZ0l1Z2xWRDZCMHRoNnAxUnVVVWZ4cDU5RHZ1K3JEU2NS?=
 =?utf-8?B?Z2t5QmNlTDEyRVB0UUpWRGFnSGc0eWNtUjZhb1VMSzV6Yit2MkdyaFI1ZGw1?=
 =?utf-8?B?R1F5TTlMV1d6WVg4UjE4YksyYURVVUFuS3I2cHlBVnpRZEl5QldYdWF0dlk3?=
 =?utf-8?B?VVg3RWRac2xtK2poeG12aERCdWI0YURWbTQ3dE9iZCtBSkF0cDBwRmZOeVpU?=
 =?utf-8?B?eFNuZnFZdGpreC9BQXJ4eVVNcGJTRlN2N3NkTW52ZmtoTm91cHhDSkFXZW5x?=
 =?utf-8?B?S3Z5QVovc0gyaHcvL1JtdWJkTUJ2RjY2ZVhPd0ZTcGwvTE1XNHZFZkMyNzlx?=
 =?utf-8?B?UHlYRzV4enNyTDRWc3Z2dUl5dmNZMDYwZ2h5VWxrZG03NXhKUUNtRlFsby9x?=
 =?utf-8?B?S1plaUFjdmFHM3BHYnJab0tkS2ZZYi9KVUZOVWhMbXJEWmg1VVFXS3dKMC8v?=
 =?utf-8?B?a0U2UkpJMWdEQ01pSkZLMkZxdE13VVBXWFFWdGhnVzJ4N01hVnhRNlV1WUI3?=
 =?utf-8?B?UkM3bW96ODJDc2NYSzAvSVR6emlucjF3bVVnYjgvTVFMb0VFMjUxT3hDUXpL?=
 =?utf-8?B?N2J3bmhBcXNYWmsrcmliT3VFazNEOWNlOVFZSEgxak4zVVlhb096MW91dFUw?=
 =?utf-8?B?QUlQVlNRUkpkZUxPVTM4NjBIMjZVYUduWXFSZG1rZUVYVmdyZVkzdkhwejJm?=
 =?utf-8?B?T3E3dlR6TmovL2QyZnpLRmdHbTlnb0h6eUpVV1JKaWpJL1h1VHBaZnhwZ250?=
 =?utf-8?B?dlZMckZWdElFOGY2dE81c2x5V1NDOGl4YkZpcCt2emNPNVUxNG1FTGN3aEJm?=
 =?utf-8?B?em5iY000TnhTK2toUmh5ZDJ6TzlVbnp6SWxuZ3FyeHkxakR6ZGZ1YlNXUm1S?=
 =?utf-8?B?aGo5cFhEeDNmTWs4THFVWnNuSHBDcmtBSzhrc2VFaDAyRm93N01MVitVZits?=
 =?utf-8?B?QTFJNHduWURkSjRuZW80N09OVFJsQ3lQMlJoUmpNbXpMWWRyeEdhd0FZZVFv?=
 =?utf-8?B?NUpndjUvYllkVUkvSW14WEdOdUM0Zi9ySkk5b1A3aDRlZDFmUVR1dmMwYmNs?=
 =?utf-8?B?UVhXek8rZ2hnSzU5a0dIM1BHbFl1eWs1VDE5RUxsYjBpbWRkNnZDWGV4bGo1?=
 =?utf-8?B?ZlQ2RFp5WDAwMXJEK2FNNTVKb2hIMlJ2K0xyT0N1NDZraEpKYm13RHVJTGhl?=
 =?utf-8?B?N3ErN3ZCd0R0Y2FGcGIxQ3AxVXFuS2gvaG5LYkpmQkZLL2xBQVpBNTB5YXJD?=
 =?utf-8?B?OUpBVE8yaDhlOXdReFh3RTZjRmRSRWZnM2dmZmRCV0ZmR1cxTVF5Y2dxYlhW?=
 =?utf-8?B?SmZEemxDRnp5dVFPMzZLdnN2UXIwZTNQYXFWL3dDaE16K0lmanJZTHhnOFBX?=
 =?utf-8?B?amNHM3dUSk1hNDhITGhzcU00d21ObmZRcnVmdjRqaUZZUnZoMFE3dkUxc3Fz?=
 =?utf-8?B?T3A3SG5WRCtlSUI0Z1g5MXRpc3U2dCtQRlEzNjRNZmljYVViK3daSW9wSVRx?=
 =?utf-8?B?b3lWTWdhVnNXTzJ3S0EveHpOb0V4YVVJemR4VGQ4Sm41TEs5QXRFUUxUVlFi?=
 =?utf-8?B?VXRxL3pCQlJpMEZBTUozVFV5bFFNVU9WRW9UUlhaQnlweTdjK0NNS0dmbFpB?=
 =?utf-8?B?OE9tRExLWmtoUEhJSTlKYW14UFVhSmRncGlyS2J1Wk5CRWJkbWp3NXhHcUFq?=
 =?utf-8?B?QmpzWHVzQjltT0tDdnZSTkRuaCtBUVltVGFvQ2p6emh5d1VCVEhWQ2ZyV2t4?=
 =?utf-8?B?Z3l6QlBEZm4vSnVSeEI3Y0E0ZkJKMWhHN1V1UjdaMTUrRkhIRW1tSlFEaERE?=
 =?utf-8?B?ZDQ5R0IxenJmZitxSDBpN0hrVDNnaVR1djNXQTdLUkxaUkhKSUVrTU4veXZ2?=
 =?utf-8?Q?b6+rkFmewPj1cwZqXtiNp5eDZHxMU3a5b2961DT7FhmDy?=
x-ms-exchange-antispam-messagedata-1: UUWrTLZrCj62qls9hisnPG9vDfsV3Yusag8=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D218E0DC6290DE4BA73B21C7D74D2691@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: FLpu5/hNTUrGrcepc3TBt00TX+9c7EV+3SZXRSfH8UAzrZFjuoepJjMRF1kppKzfZD4M9zoQQr0ugAB5g3z+eRJYGYMMQCJH8Vu6rsU2D4Uu8tdSJm5Qb2xiLwdP3Rh1vkz11qUAY1iSx9MoraKvfJcvtOdg+PLbMWU7TBLKiPWbtHooL2xVw/k0pA28AMulRL9QzWjtVSBOnZ95NlrX50scARazNzZH8iGBGkmuF5uLIizelJEEXlOemJoWv2Ezd+LjRSN5rsqN8Vpd08z6Au2O6VNv8Zvjp6SisswIy39i5xeX1sXw3ykw8XdiGbEYx0Z8IqTqd8+bwn8rVqynlQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 6KPyrKkbOVUmwOTxgrPT2en4/ccU6Khkzi2KP9VLxYs8m/gSkLdoMzuQgU2m0RbjlWVv8CJJDFJ3rHjzlR4Lta/7pcf1xzUXY1XMQEW3OHccZGIDTXNh2949YlI6zckmSFuCQI60Saa/n4lriwnUof09IcLSMQiDGwG7LQJ7VlF6fTw/NCxMbKO/FLtIlqC+wj3OWTT38jkdH6CqeeecGpWAlV2bfhRq4DhjqjDgBLdDNCeiDFkkB+fnLV6Q9RjR4oz046q4UV06Q8AkcS9pZVvvHfkdNJ5WnJJxVqCvBbK0NAuhbLiHj2o3volwgnGRMtbNln2BkOV1z9tzD+OaJZqu1EpeQix4Zv+fU1NODGMxWZSnkVWeBexxM+cxGtuUaS46Xn5Uf7w2Dnoz9LiUT7OChPDQFmlkhXGAiwJIYD/vSwwQTpVPvYuugEn42JzIyWEdZwKU0yrSNxTaE4QaEVWHJ8GENspBLn7f0ZD+bGzLwHJwLlZ9Ge+S3C6DP1jChCq6JrVbde1vR5j6EHT8fiP6CYfBmqJb6qie4z6EpKxc9U/Zdyha5nnKP7ndewsDjVhAxKwwFWtHWVnqfY3xbOsCfq9QyTscSS0C/4rSINWmGmvElvN4z181Y4hOZ4J7
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY1PR04MB9561.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3eed4bac-fbdb-4c33-621a-08df026122dd
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Aug 2026 04:27:12.9775 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: j2AfaU7/3i1zGFRLWTs8flBR95Md6CxV8HiGhDz6k0i8G/4khp7W4sBmgpZq4ayUhsWn/rH0Donibk7Cyk8iPunsCJoyN9MScx7iAhf7v1E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR04MB7203
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

T24gVGh1LCAyMDI2LTA4LTEzIGF0IDAxOjQ0ICswODAwLCBNYXggQ2hvdSB3cm90ZToNCj4gRnJv
bTogRnJhbmsgQ2hhbmcgPGZyYW5rLmNoYW5nQHNpZml2ZS5jb20+DQo+IA0KPiBBZGQgU2lGaXZl
IGN1c3RvbSBpbnQ4IG1hdG11bCBleHRlbnNpb24gaW1wbGllZCBydWxlcyB0byBlbmFibGUgdGhl
DQo+IGltcGxpZWQgZXh0ZW5zaW9ucyBvZiBTaUZpdmUgY3VzdG9tIGludDggbWF0bXVsIGV4dGVu
c2lvbg0KPiByZWN1cnNpdmVseS4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEZyYW5rIENoYW5nIDxm
cmFuay5jaGFuZ0BzaWZpdmUuY29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBNYXggQ2hvdSA8bWF4LmNo
b3VAc2lmaXZlLmNvbT4NCg0KUmV2aWV3ZWQtYnk6IEFsaXN0YWlyIEZyYW5jaXMgPGFsaXN0YWly
LmZyYW5jaXNAd2RjLmNvbT4NCg0KQWxpc3RhaXINCg0KPiAtLS0NCj4gwqB0YXJnZXQvcmlzY3Yv
Y3B1LmMgfCAyMCArKysrKysrKysrKysrKysrKysrKw0KPiDCoDEgZmlsZSBjaGFuZ2VkLCAyMCBp
bnNlcnRpb25zKCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEvdGFyZ2V0L3Jpc2N2L2NwdS5jIGIvdGFy
Z2V0L3Jpc2N2L2NwdS5jDQo+IGluZGV4IGZmZmI5MmZmMTEwLi4yNjVhOTJhOGI3ZiAxMDA2NDQN
Cj4gLS0tIGEvdGFyZ2V0L3Jpc2N2L2NwdS5jDQo+ICsrKyBiL3RhcmdldC9yaXNjdi9jcHUuYw0K
PiBAQCAtMjgxMSw2ICsyODExLDI0IEBAIHN0YXRpYyBSSVNDVkNQVUltcGxpZWRFeHRzUnVsZSBa
VkZCRkFfSU1QTElFRA0KPiA9IHsNCj4gwqDCoMKgwqAgfSwNCj4gwqB9Ow0KPiDCoA0KPiArc3Rh
dGljIFJJU0NWQ1BVSW1wbGllZEV4dHNSdWxlIFhTRlZRTUFDQ0RPRF9JTVBMSUVEID0gew0KPiAr
wqDCoMKgIC5leHQgPSBDUFVfQ0ZHX09GRlNFVChleHRfeHNmdnFtYWNjZG9kKSwNCj4gK8KgwqDC
oCAuaW1wbGllZF9tdWx0aV9leHRzID0gew0KPiArwqDCoMKgwqDCoMKgwqAgQ1BVX0NGR19PRkZT
RVQoZXh0X3p2ZTMyeCksDQo+ICsNCj4gK8KgwqDCoMKgwqDCoMKgIFJJU0NWX0lNUExJRURfRVhU
U19SVUxFX0VORA0KPiArwqDCoMKgIH0sDQo+ICt9Ow0KPiArDQo+ICtzdGF0aWMgUklTQ1ZDUFVJ
bXBsaWVkRXh0c1J1bGUgWFNGVlFNQUNDUU9RX0lNUExJRUQgPSB7DQo+ICvCoMKgwqAgLmV4dCA9
IENQVV9DRkdfT0ZGU0VUKGV4dF94c2Z2cW1hY2Nxb3EpLA0KPiArwqDCoMKgIC5pbXBsaWVkX211
bHRpX2V4dHMgPSB7DQo+ICvCoMKgwqDCoMKgwqDCoCBDUFVfQ0ZHX09GRlNFVChleHRfenZlMzJ4
KSwNCj4gKw0KPiArwqDCoMKgwqDCoMKgwqAgUklTQ1ZfSU1QTElFRF9FWFRTX1JVTEVfRU5EDQo+
ICvCoMKgwqAgfSwNCj4gK307DQo+ICsNCj4gwqBSSVNDVkNQVUltcGxpZWRFeHRzUnVsZSAqcmlz
Y3ZfbWlzYV9leHRfaW1wbGllZF9ydWxlc1tdID0gew0KPiDCoMKgwqDCoCAmUlZBX0lNUExJRUQs
ICZSVkRfSU1QTElFRCwgJlJWRl9JTVBMSUVELA0KPiDCoMKgwqDCoCAmUlZNX0lNUExJRUQsICZS
VlZfSU1QTElFRCwgJlJWR19JTVBMSUVELA0KPiBAQCAtMjg2Miw2ICsyODgwLDggQEAgUklTQ1ZD
UFVJbXBsaWVkRXh0c1J1bGUNCj4gKnJpc2N2X211bHRpX2V4dF9pbXBsaWVkX3J1bGVzW10gPSB7
DQo+IMKgwqDCoMKgICZTTUNUUl9JTVBMSUVELA0KPiDCoMKgwqDCoCAmU1NDVFJfSU1QTElFRCwN
Cj4gwqDCoMKgwqAgJlNTU1RBVEVFTl9JTVBMSUVELA0KPiArwqDCoMKgICZYU0ZWUU1BQ0NET0Rf
SU1QTElFRCwNCj4gK8KgwqDCoCAmWFNGVlFNQUNDUU9RX0lNUExJRUQsDQo+IMKgwqDCoMKgIE5V
TEwNCj4gwqB9Ow0KPiDCoA0K

