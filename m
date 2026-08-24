Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 470C3C5DF97
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 00:35:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyIex-0000cN-QQ; Sun, 23 Aug 2026 20:35:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=689c12928=Alistair.Francis@wdc.com>)
 id 1wyIew-0000XM-1a; Sun, 23 Aug 2026 20:35:30 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=689c12928=Alistair.Francis@wdc.com>)
 id 1wyIet-0008VV-KT; Sun, 23 Aug 2026 20:35:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1787531731; x=1819067731;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=CY5PPjdJlhKS99dD1kufTkcIGqjnSufA86sjlMorFO0=;
 b=EpHJSiAGwuCQYwZfjTT8wq8P09A5NPepq0s5zasqHQKxt5b+XWn2Wp83
 dhhHvUYOqixuO55aAIEoGuJPy9uvn20caRr6XcTlu28RVdJlNEDcLc3ew
 hnVn5pvkC+xNeLX2v4sVCL8JVXm1EsOvQvqHEzRl8A4pB3JymYnphT5G9
 k3YxGzhKEpejVM1VmuNCxELTkUVuQmSazuqit6xPJxnAa+M/2p4bbtzZg
 J0DZbdZCgO9dJlsOqI6JT9vZQrfYJTbukKF0Xy0pF1mIwOqrM9VpsdVEC
 Bmz+3Sk+ppJpR2mVSncMYkvx0k6FF2zF9OX5ManroJd/tiv1CCSDiD2gn w==;
X-CSE-ConnectionGUID: I+qX8LQkQeOt60btlXmTFw==
X-CSE-MsgGUID: SMNFuNUnTmeN1H39IBJVBw==
X-IronPort-AV: E=Sophos;i="6.25,239,1779120000"; d="scan'208";a="154114970"
Received: from mail-southcentralusazon11011058.outbound.protection.outlook.com
 (HELO SN4PR0501CU005.outbound.protection.outlook.com) ([40.93.194.58])
 by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 24 Aug 2026 08:35:26 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kA4+zR5risTlb/odrpQDYVY+Xg8XhlfFgSAAScfrGhfPUg9TtTYD8MWO1JYuKBvmBOvonAUj0dSESkS/FbaZoE+t7maL6itQxpUIMel+bBm1WDirGwJX7H2MJKqzHEyjmPQf3bfeycJKh2f1hNNPabNM2FSVnaZ3i3mt3Lspq1XWfoarQX8n2lpGjD3r8C9CPMcrxAhSNtyN6DavrlhOjC7ikYv9i/fbwgcTVmDjDxAMzsGwmkHBt/pCSNR3A2jrX+XsfTwfZrWTLPZuRqbNF8+8FkNbETnzXdnxTUbsov0fqL93TwRTSlqBtUvYJKO6F5+BE3z3GowrQDlZwi53mA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CY5PPjdJlhKS99dD1kufTkcIGqjnSufA86sjlMorFO0=;
 b=Isll/fel5VN/DvC6febnu2geGn4yriMi6fpWlMg7kDZ1mVjMaoC5ooJuSnCcsFaOHkKnv6Jl4SrFWCWLJnAHPamjIRAD+i0iD4wJaazC+8uYOkKajGW2fZ1CW59T2vRInHCdObrsNKal1RnAVQT7YpmMEQBRmbbwPJ82DW3KReDCG0gCCyqiOHx+1nsU75QvkYsOYuZC5wUpeol3MCKMPoz4vF5NOOkVLa4eagBCtxCX8+Q+3r0HNtq/bZEqU57zTD9iotRv9lfrjkGV1a7fgksIrGdEwIf1O5BtqmafHdZ0B02OC7DSX40pJaXoR/5nX8lwoSjmmSGBnubH24jbLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CY5PPjdJlhKS99dD1kufTkcIGqjnSufA86sjlMorFO0=;
 b=h+0h3ODi3wqoyR+5TTnwAiGH+Dcvvfdo0JZfTM6ORyFn8FWjdixCiXELEFsd11pGvI1wMkHrhC5/xYr6+KsVBIhJnRyqsBW5UpJqZfDu1gJpBCYLRb+gxu3uY8eSE/IZUM3NQAbezE44VjZ5S9YzOODFaVMYI0pOc5/2lsP2nfs=
Received: from BY1PR04MB9561.namprd04.prod.outlook.com (2603:10b6:a03:5b6::11)
 by CH0PR04MB8052.namprd04.prod.outlook.com (2603:10b6:610:f0::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Mon, 24 Aug
 2026 00:35:19 +0000
Received: from BY1PR04MB9561.namprd04.prod.outlook.com
 ([fe80::3869:e494:2fa8:9888]) by BY1PR04MB9561.namprd04.prod.outlook.com
 ([fe80::3869:e494:2fa8:9888%5]) with mapi id 15.21.0339.012; Mon, 24 Aug 2026
 00:35:18 +0000
From: Alistair Francis <Alistair.Francis@wdc.com>
To: "joel@jms.id.au" <joel@jms.id.au>, "yfliu2008@qq.com" <yfliu2008@qq.com>
CC: "sunilvl@ventanamicro.com" <sunilvl@ventanamicro.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "daniel.barboza@oss.qualcomm.com" <daniel.barboza@oss.qualcomm.com>,
 "chao.liu.zevorn@gmail.com" <chao.liu.zevorn@gmail.com>,
 "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>,
 "zhiwei_liu@linux.alibaba.com" <zhiwei_liu@linux.alibaba.com>,
 "palmer@dabbelt.com" <palmer@dabbelt.com>, "liwei1518@gmail.com"
 <liwei1518@gmail.com>, "pierrick.bouvier@oss.qualcomm.com"
 <pierrick.bouvier@oss.qualcomm.com>
Subject: Re: [PATCH v3] riscv/virt: Add optional UART1
Thread-Topic: [PATCH v3] riscv/virt: Add optional UART1
Thread-Index: AQHdFlt6BaYTdbzdckSrt/642/QtAramn3+AgAX0qIA=
Date: Mon, 24 Aug 2026 00:35:18 +0000
Message-ID: <9a7807f5c9f6ed8c55860ebcacb403fe14a920ee.camel@wdc.com>
References: <tencent_4EEBFC805F3E59863BEDC38094EF5A109206@qq.com>
 <CACPK8XefKWYjBqZrhbgf62QaSGqdgGMFwVbB4uwoWz+4ZfhmkQ@mail.gmail.com>
In-Reply-To: <CACPK8XefKWYjBqZrhbgf62QaSGqdgGMFwVbB4uwoWz+4ZfhmkQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.60.2 (by Flathub.org) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY1PR04MB9561:EE_|CH0PR04MB8052:EE_
x-ms-office365-filtering-correlation-id: 0b6a0269-6ae5-4d9a-3a8c-08df017792fa
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|7416014|1800799024|19092799006|366016|10070799003|23010399003|38070700021|10067099003|56012099006|11063799006|4143699003|18002099003|22082099003;
x-microsoft-antispam-message-info: qwAcPnYi6Yq0L/K0atZcPXde1BnFACcYusG+ZiL71MmB3OK99xquCwsjg5MafBQRMIwZUwYKLBuOR1n+7KWcTYXlGJ6XgRkq6H3xqKQNFeMnsJIZadcQy/G4hHGkrQB7hxVwSaRlgC5PQdLTTEB1J6PiwWIk9eZ41RC6XW8SGHNax1Gd1cGO6VUrBVQSFzbPS+xesEPm2PP4rr30FrsIdr00iOQgfqYJGx39oQt0BQ3JbiV3xZV7a/W6Pb6FGHyrbsvBs2dm/Kxy1x7CpWLOftyFU7XfCKOCJAw2fcUslIjFmPwqA5zzVKKTawrbywpkSFEJiWWFmSkYqsAGkS8hw8ZgIkWKeI8za13zPuXRanxdSsS3REqiGuVGq7fiV7ITDkT4ArcfRgW0o8ySGGCya0+DrzSZNxVS7C82wtE6Kyp3ehI1w49MpM2xle6vvgRBXTK5CiRFPw8UXx3h/L3BKuJRe9sJyUq+Z0A95qFlkMPDnMXHiD99wVQG3JprwsobInBw07nC+ZKJDxNc1oXZP5rAmHEHUbBbbVJ9GctyCCiYL1g/mj8Wjjkfj4Dl86xEE59QK6imr5ZLcsbHm1nozLRlszXYvM5RGRE97i3LGPBcNZrMdZdw0pZICN9Tc7mW4IrFm3tJ4U4EWNNMrarOhggqXn3TI37PqMzuUk1SNPRZ97ezekQ88cJYHcwWsw1YM65L+wTh+KQWBrjNjEXbKt55J4f+8ML1YxebKykHZsc=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY1PR04MB9561.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(19092799006)(366016)(10070799003)(23010399003)(38070700021)(10067099003)(56012099006)(11063799006)(4143699003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bkN2dW1zSGd5YUViQzNSSzBDRFNWc0MrbTh2alRURjZ2YS9sbm0wRjNCTXow?=
 =?utf-8?B?L0taQzdGTDVzQWdtR0RPV3dlbUIrRmZGOWdtZWdVb0dLZ3M5NmFEa1ZlQlJm?=
 =?utf-8?B?NThYaXFjQnFiZ0RPUzFMakRqcVRENmpBK29pUVZGT1NiTG1HU1UrVnJFUkxO?=
 =?utf-8?B?ZFZjRnlJQ1R0ZDhrdWNSK2lMRjlCTFhkaEl0SXU3TGNQd25HZlNjZWlFZFFU?=
 =?utf-8?B?Q0ltSDBuQktQL0w1R21na0NaZkpBNWNaTFo1Y3VUTmlod3czSTVpUkRNMGZx?=
 =?utf-8?B?UWdYc2dkb0ZVeXZ1RXlvSE5zR2R3am1ROFNYYWlLUVNJSk9KMjhPK210bytn?=
 =?utf-8?B?cEpyVzNtbnF3QVdrOTRhcGZTUjYzVkZHMnF0cjdVMEdnZFYrT0Y1OWdUZitF?=
 =?utf-8?B?R3Rlem9CQkdJWmVESmptN3VjZmE5bTVWdTBLQTY1RTFqRHVLcDJzMVdpN2Mx?=
 =?utf-8?B?OGhLcmJQVmdjTDJmODBEMjRHcWU5bm4wRUdMR3ZrMTF5QmxHQ3FLdm9IR2Zu?=
 =?utf-8?B?aTcyN2tieXp3dUp4OUEwblJsTG9YL21YM0EyWmZEdU9VaVdWZi9lNkQyZUIv?=
 =?utf-8?B?ZkNTVkszK1g5WkQ0YVpYSFhacEEwalZraHkzY2srOHFkMHg3bHFETHJDQUhr?=
 =?utf-8?B?YUJPMEx2SnhtVURLWnFleG5SUXZCdndJbmRJSEpvNjhXWit0d0ZWVDRKNUcz?=
 =?utf-8?B?QWhIR0s1Ukd3LzdTSVJVVFdtQUN4eE91MnJ3QW9Oa1ZYTW5QSGx0Sm4zYXVF?=
 =?utf-8?B?L2EvTkZINHgycUxHdDBuNGY2TUZKRm9yYkxXVzk3ZXcwNWNqQjdseWYyWWZn?=
 =?utf-8?B?ditrL0Q4Y3lkK0xBK0kzNzlBVGRQMDdueHRpZm4yTE5rNjNiaXlUN1RXMzVO?=
 =?utf-8?B?NG5jQVVBb1A3ZTJFNGV5enFKWUpiN3JNY1JyMmZDOWhuSW10QjRoYTlRWDR0?=
 =?utf-8?B?aTdNLzZPbkJUVjQ0M2ZvTFBsZzNPKzNJL2RLZkpOemFXV3RNTFNNZDgyYU8v?=
 =?utf-8?B?amJERlM1dU9VTDE0NGZNMGpsaEZFS28rcStERWRTeUFabWQ2N2hyUVkwVVRZ?=
 =?utf-8?B?Q3FVUWhjVzNtVCtlcnFIa3VCaVcwamNVTVljTHJnbTNZNGtOS2NORU1VYlNj?=
 =?utf-8?B?N2FGSlhnVk8wT3l1VlBHV0kvM1V2Yk0zMDJDRDd4UW9neEV3WHVteVZRemsv?=
 =?utf-8?B?QUNUVk5wZSsvMEFLVDVkVFJPU1lXRmhkWkRUQ0tyRkVsdVpoT2laVmxKbnc2?=
 =?utf-8?B?emVyNGJUMmZFY2I5OWhSTG81Uzhvdy9ITXBJY0h3RjhtM3dPeEVHM3dkR0hu?=
 =?utf-8?B?L0JvYXkvaFMxckREMEhCSEZxNDJIYlhsVDRZT2o3cU1oZXR2SjN3ZkFINWty?=
 =?utf-8?B?NEZ6b01tVFNiZHhjTlg0a010V2ZycFByWHNVLzRvYTV1MEUzWXpONFdzWnVV?=
 =?utf-8?B?Q1NTMmFyOTFGNFFuOGg0cE54SEZTVVppYW51WUZabUxsaDU4Z1U2NEVVeXdj?=
 =?utf-8?B?WFVUMFNrdGZMajhzVWE5QWRKV0VTb1hPbWlSdnVBMGZ5SlJ6ZVlBRHk1cDZ0?=
 =?utf-8?B?Z0pFeG5BditmZzRRejZlNXhDQWtpTFdMM2liZ3o4cUV0V2h0ZmxCaWhyTEpL?=
 =?utf-8?B?UVI0bXZkeVdnKzRhMHV1UU9QeTM2L0FyRVdwSWEzMU5YbHRDcEQ3TnFMR05a?=
 =?utf-8?B?UmxkZjZGOVpoYUE0RnZ5UXRxVERHcXh5VlB3Mk01aCtkS2FVTll0bDRwakpG?=
 =?utf-8?B?a29zeDMxMGViZkNadnU2SGgyR3AvNEhuS3JobkpScmVYUmJpOXFObHpWTUND?=
 =?utf-8?B?U05MY3NEMUpJR0d1cXlVUjJQYXV1UGhRd29KcG1HSGhyRHVrZHhsVG1xaXYy?=
 =?utf-8?B?ektEcTFud3o0aWtjbVpCcWF1VXJhS0RNUGV4VFNab1JHMDdpQUtuTmgzY0tt?=
 =?utf-8?B?TVhObHlSbURvbUFHZDg3M3d1bTZ3eTV5VXZIL0tLcCt2bzdYdUN0R1UxQ20v?=
 =?utf-8?B?OWxkM0tyMDJxK0lOdXo1YXBqNUNTeDB4VFNodk8vM1lDbm1HN1VpdStSZ2NQ?=
 =?utf-8?B?ckNTWCtTUGlaQi9QelF4S2R0RW5Ta3JEUFNLK3hIK0dLZnNaTjlwaXkxa3NU?=
 =?utf-8?B?cS90ZTVqams3RlRPYkJ2TklzMDV0QTlnK2VwS3RsWmFvZk9zUFNpU0djK0Rh?=
 =?utf-8?B?N2ZhWTlzNVRzQXlpZkREdU0vUk5rUTM1ZmQwbHdVekRhQTNURUFLb1dzajl5?=
 =?utf-8?B?LzUrd1VpQ3YvVmFhWVVvYnJFWVRFUE9wUW42dTc2SHF1OFk2dHFJcGs5VWhj?=
 =?utf-8?B?aDlDZ25uaHRRUy9EUVpybTgrSXhiS3hqdDFQWE5Gc2Z3QVJaZkFER284ZjdS?=
 =?utf-8?Q?yrlRoSDlS5+3MWjcO+10jn3Q6mk4S/9APJyVTm1vUGAHm?=
x-ms-exchange-antispam-messagedata-1: 3DAKskI7Imnu3N08jCg8Cee2f7TlKpU73bQ=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8A2A8F9C58A147489DE0F0536E9DE083@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: Y07FFxd2qUTHUrSbUFq4xS+2968i+nhoYBvT66r1BIsM5clZ6olVBOdjT6JAO74k65/OYH6PqxmKi4RSzcXMicAG7XWgq21jYroeAyZyY9EY7EoGuifpdPnTCzXs0WlRAI4z30oBLFyiuXV11Heoc7lBDM8fR/KKUiiP92H03mia3Xe0vBfST3cTXhDIgrnyzW98za5sXXTf+lkB8uyzEGdcqFjec55rWMhJydGVXDgHnTcTgR0SK0BGFC3OE+WhOuZqjy9CpgjHsAhTKyBOxuij/ur2fnrtv+XJo2SBRjjHw8iODf594qurioSKeqWcRSdg5yeyd3+xbF4a1w3gRA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 4ZJeYlWqkYHpQpXCgtLoRMDssXCHvMPndGc8OFpkSp8Qc/mVh7A/q9oRfQMFhATPVZY98AGD+PfQQ6n7tIDLeAGg2zcRGHLTCzBDIpE0kjHiN/fi1R5BbPIhYbVPowDuZITYPuONpGpdvAVlSnESjL1x17vIaP3PP7KtOxNreeEM4GhJkhndsjoeJOTJNtTzR0ThYqzvlRvxJZY17w+VNcB8SvbugZjTwtWgdtz8ejgKKmPnbgOUo4iAJ+My67z+T+bHPfqP7rPt7E6EuqryNmlcBgIXoOyEyrHtjJAFg0ezHmRK6Da5uSpSilUFhp7Cb6XGGKYShWGY/KluR2L0XskHonQuiPGC7vW6c63beNymhbhr/KGycTtUAL691fKuHYBmtrDL2xK54q4ypkTChZBIea5y6BH17hIkyr692DCGHlp0BuHPyB14aS4qpK3KWvNPcU12hx/0ULr067XD680BOJMmqtp+jGw0qofRWc2u+3JjG2LiKkxEUox/lftcv1aGGZjmQB7pDrdgIUg8INx4FxpP3ZXH9jnrMI08cYRkk0CDaduPm8oBizcKFWKPLHUUgsqt/Wr8ihjtJuZGl/CyCLDFiEI9M1ei/APAxQ+htcuZ02ibKQibBl878QO3
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY1PR04MB9561.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b6a0269-6ae5-4d9a-3a8c-08df017792fa
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Aug 2026 00:35:18.8026 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OzDwsU559BKpKE4WSk1JHB5MeNgSHhR4cVLDpl5HC33wtbA/fwjrVYLKHlgVsE3HWn77AKj4i8mqmfHyE4t5TxS+VmfQYs+PwxTP8FUrsVQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR04MB8052
Received-SPF: pass client-ip=216.71.153.141;
 envelope-from=prvs=689c12928=Alistair.Francis@wdc.com;
 helo=esa3.hgst.iphmx.com
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

T24gVGh1LCAyMDI2LTA4LTIwIGF0IDE1OjA4ICswOTMwLCBKb2VsIFN0YW5sZXkgd3JvdGU6DQo+
IE9uIFNhdCwgMTggSnVsIDIwMjYgYXQgMTE6NDYsIFlhbmZlbmcgTGl1IDx5ZmxpdTIwMDhAcXEu
Y29tPiB3cm90ZToNCj4gPiAtLS0gYS9kb2NzL3N5c3RlbS9yaXNjdi92aXJ0LnJzdA0KPiA+ICsr
KyBiL2RvY3Mvc3lzdGVtL3Jpc2N2L3ZpcnQucnN0DQo+ID4gQEAgLTE2LDcgKzE2LDcgQEAgVGhl
IGBgdmlydGBgIG1hY2hpbmUgc3VwcG9ydHMgdGhlIGZvbGxvd2luZw0KPiA+IGRldmljZXM6DQo+
ID4gwqAqIENvcmUgTG9jYWwgSW50ZXJydXB0b3IgKENMSU5UKQ0KPiA+IMKgKiBQbGF0Zm9ybS1M
ZXZlbCBJbnRlcnJ1cHQgQ29udHJvbGxlciAoUExJQykNCj4gPiDCoCogQ0ZJIHBhcmFsbGVsIE5P
UiBmbGFzaCBtZW1vcnkNCj4gPiAtKiAxIE5TMTY1NTAgY29tcGF0aWJsZSBVQVJUDQo+ID4gKyog
RWl0aGVyIDEgb3IgMiBOUzE2NTUwIGNvbXBhdGlibGUgVUFSVHMNCj4gPiDCoCogMSBHb29nbGUg
R29sZGZpc2ggUlRDDQo+ID4gwqAqIDEgU2lGaXZlIFRlc3QgZGV2aWNlDQo+ID4gwqAqIDggdmly
dGlvLW1taW8gdHJhbnNwb3J0IGRldmljZXMNCj4gPiBAQCAtMjcsNiArMjcsOSBAQCBUaGUgaHlw
ZXJ2aXNvciBleHRlbnNpb24gaGFzIGJlZW4gZW5hYmxlZCBmb3IgdGhlDQo+ID4gZGVmYXVsdCBD
UFUsIHNvIHZpcnR1YWwNCj4gPiDCoG1hY2hpbmVzIHdpdGggaHlwZXJ2aXNvciBleHRlbnNpb24g
Y2FuIHNpbXBseSBiZSB1c2VkIHdpdGhvdXQNCj4gPiBleHBsaWNpdGx5DQo+ID4gwqBkZWNsYXJp
bmcuDQo+ID4gDQo+ID4gK1RoZSBzZWNvbmQgVUFSVCBvbmx5IGV4aXN0cyBpZiBhIGJhY2tlbmQg
aXMgY29uZmlndXJlZCBleHBsaWNpdGx5DQo+ID4gKGUuZy4NCj4gPiArd2l0aCBhIHNlY29uZCBg
LXNlcmlhbGAgY29tbWFuZCBsaW5lIG9wdGlvbikuDQo+IA0KPiBUaGlzIGJyZWFrcyB0aGUgZG9j
cyBidWlsZC4gSSB0aGluayB5b3Ugd2FudCBgYC1zZXJpYWxgYC4NCg0KVGhhdCBzaG91bGQgYmUg
Zml4ZWQgaW4gbXkgdHJlZSBhbHJlYWR5IHRob3VnaA0KDQpBbGlzdGFpcg0KDQo+IA0KPiBDaGVl
cnMsDQo+IA0KPiBKb2VsDQo=

