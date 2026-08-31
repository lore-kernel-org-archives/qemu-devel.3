Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A510FC61DE4
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2026 01:26:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x0qmi-000473-3D; Sun, 30 Aug 2026 21:26:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=696fae14a=Alistair.Francis@wdc.com>)
 id 1x0qmb-0003yV-Qd; Sun, 30 Aug 2026 21:25:58 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=696fae14a=Alistair.Francis@wdc.com>)
 id 1x0qmZ-0000v9-Tg; Sun, 30 Aug 2026 21:25:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1788139555; x=1819675555;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=x94Nu+1wjkXagm0PxmJ6bSEWJacOVOjm9Wx3XGN9crI=;
 b=W1ud/4PY6RfcDRi4YVI15JUW6w5aLlLxDvOXJNKoG/szqdozjP/8qbBP
 O6C3x9ja3F/YbxH7ISUkwtqnnlqJdTUyld/Mz+y+zZRQzhhKw8VUxHudC
 6ty20kgsPcWHbSD5cFckccbZa6QCeXoehUzDvAuOWSaCOT9lcVKm88tTv
 aZ8UxyXEP+nIEVoDK+VZPSf97q5w6IDZQRsakrmpyEEGix+ALzMOf2eOv
 GSZsYo3ikNIwCWAJSQVQLHP9B6FIAd20A5zxWSqncwsLCh4zrhdNDLcLT
 eVv+edgcKlbjniBZfWBmbpv3QKE9gB2KvcYi+mcmYM0KO5/3Fob+XR+e2 Q==;
X-CSE-ConnectionGUID: oljNxusdTju45fuIeYG28g==
X-CSE-MsgGUID: SFKmmfTDQF+84B94mfGdmg==
X-IronPort-AV: E=Sophos;i="6.25,252,1779120000"; d="scan'208";a="155504967"
Received: from mail-westus2azon11012051.outbound.protection.outlook.com (HELO
 MW6PR02CU001.outbound.protection.outlook.com) ([52.101.48.51])
 by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 31 Aug 2026 09:25:51 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bbnV/sDc8SwmY7MQEaf8mcKh6JZwc4vuf2XXhS3byFZju/8SSD+6GIL927WX8VfNIYmIpB/Rfk+4nWFfkoXR+Bp5PTrZH3ptTYUowqfpUFGKnxYyCdA4MsVtg6i2zNbDJT2B1E1sQjG4DxMb8q2RM65zoEP2b2gQwx4CwZaYr9qFyFoAXpbzVGvLpg5/EE95qcBWv/QHNidRu6c9uYjww0u18qeWrvBE2VQ4gTY5CDYbDdIgs+u3VYAxFfjclyOXfEl1E3CpYumI98+rBikPAoPIWxvJnNwaSEIJcCD8ImGJ57eERa1ZtTdw212YDMMTNBBa5e9LoimYO/YGOHiGtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x94Nu+1wjkXagm0PxmJ6bSEWJacOVOjm9Wx3XGN9crI=;
 b=wJV5VI4J5Wo5WAzOVZI6qD3xV26Nqra9flwU81ReaQYCc1vPEclHLvW3Kog5F5u8+aIUvyrqrAzqdNwc1A2vYIbPqlQXpRdOixP6CjAqFzxLgmyAvKyY3KkLJc0p1V4DS3XT8ClB8f4u0cONa5ht4w3HfBfyp9nZqAwVL9CraoJm/WKp+0L8XxAppN3Yfp0WMexEYIpseMEbDHAmNz59lzoeLYzHIHvU/vwGkeZZPE3zR947m2kiccv4VcaYdlNHn9GA8XNRHy4hJZzqj/l24l1vzTfapVDCKoF1Vzxtp+yr5G24X/zdLp4dxO9p36M2YnXCaiQTqyzO3VDv9D5VUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x94Nu+1wjkXagm0PxmJ6bSEWJacOVOjm9Wx3XGN9crI=;
 b=OeHzwOXzj3+1OW1Iq8bPm7P1fRupwP7hI5LaDyH0jzH5S5qdiLwZcW8p5dpZ2H3AMR2lmprjTqY1AetKNqwRaONS2bkR9/kiPQrm6cXLi/v1F2alhiZSHgp9WjwpXtveTLAlZdbGu6eCGmxeSjUkpMaGVsv1l7pcqMZfSbbgVkU=
Received: from BY1PR04MB9561.namprd04.prod.outlook.com (2603:10b6:a03:5b6::11)
 by IA3PR04MB9402.namprd04.prod.outlook.com (2603:10b6:208:505::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 01:25:49 +0000
Received: from BY1PR04MB9561.namprd04.prod.outlook.com
 ([fe80::3869:e494:2fa8:9888]) by BY1PR04MB9561.namprd04.prod.outlook.com
 ([fe80::3869:e494:2fa8:9888%5]) with mapi id 15.21.0360.008; Mon, 31 Aug 2026
 01:25:49 +0000
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
Subject: Re: [PATCH 11/12] configure: Provide OBJDUMP to the tcg tests
Thread-Topic: [PATCH 11/12] configure: Provide OBJDUMP to the tcg tests
Thread-Index: AQHdNeKCzoPphiBljkmXWkpxJ08Zm7a3Y4gA
Date: Mon, 31 Aug 2026 01:25:49 +0000
Message-ID: <5116d6da778b896ddddd38f4547d929f45cec888.camel@wdc.com>
References: <20260827050953.67184-1-joel@jms.id.au>
 <20260827050953.67184-12-joel@jms.id.au>
In-Reply-To: <20260827050953.67184-12-joel@jms.id.au>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.60.2 (by Flathub.org) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY1PR04MB9561:EE_|IA3PR04MB9402:EE_
x-ms-office365-filtering-correlation-id: f62beb76-f068-463a-1c92-08df06feca58
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|19092799006|376014|7416014|23010399003|1800799024|10070799003|366016|38070700021|6133799003|10067099003|4143699003|11063799006|56012099006|22082099003|18002099003;
x-microsoft-antispam-message-info: vVDfj8yCJs0OUQGRqC0UNhxSjZ5U1XCU76Y85rFrTPOWamJZ8BuBZ0hY/hjgJf23NghF0AoxCVCjgoWtt9tZdSzvQpSlOjT9Ft7wKtvaZxjJ6IBr1pSL7lfn8eB5jxmzfWZO1av41fWX28bTLZrH2ywoa5ap3iE5QMPslh1t955plwpcGnYSk0IHDi5A1ysisLrIWjhQVll0/ckKFO4XXC3nExnL1EAq5yd1o/CLs8u7M2nYGQwBnoE7bo/OyAVDJqhX5veDDe3hwwPnHSnPGV9Y4mU6MO+i0Aqqw4cYlTkM3/rPlcQJBlVO7BLwwIcBeUjWor/eyvbADq84cApF5c4UcZk+0eHJXzDXMI2IENFEO6LE8DEhf1AsQ0ytCb3xkSDb9UKTF3Ns6UsLWfBa6tZdJDoCytcd1U+i54/RvBOv/omuQgPexU5hCPCWKgcd0gofNE9EfnR1IQztmVcNCF2daf1rczY2iw90fN0WGEiM7WQZGeZIhArxkPwf7C3mv/YqWyllowR1g2zqghgyo5W5qLSomrtoGbOkRVmPbhPELoEnUibKGR1ZiBlsPbjCYJHV8jJdVw1mHCWXO8mS49MgcY5r/ZXZS4povKMBfxR+LfABEt7D2HtuPyWhFI7qargSRCqd6qcnOu/3dJgMX7V72mZbOpQxfHBYrk5APzDBEkTQCDGxYpPQSuJ2DNCdzkGQMwnqd1T9mPnVU77vX4aO1ZGdirGrtD1dHNjpWCE=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY1PR04MB9561.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(376014)(7416014)(23010399003)(1800799024)(10070799003)(366016)(38070700021)(6133799003)(10067099003)(4143699003)(11063799006)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bkFEZTU1SG9iTC96eDV4MkQyRUQyZ0Q3WDViYWlSWlptQnZsOWZtaldRSmly?=
 =?utf-8?B?bTNyNkE0alBoRjBjYUZwQ1FEaTlzT1JuQ2M0VUFvbCt2WGdaYnk5ZVBxOHBC?=
 =?utf-8?B?ZXJWclF3V1VVVVlpZGJQcUxyVFJKdWV4ZTJvUDZkMjdraTJ5VlpaVE1UQ0pT?=
 =?utf-8?B?MDJsOTlBZERjbTdpdVNXMGVvUWFRQ1FsbHZNVEE5MzErR01iYU5VMnl1ZFZD?=
 =?utf-8?B?aTBFc3N5ckVSWWhpVnRKQktObXN3Nld1Tkk1NStFL0NHd3BRbVorYStVQ2V4?=
 =?utf-8?B?RnVLQUJWTDZnNnk0dUw0eGhya1dVMVlacllBVENQODFLNEZlTWQxWGNEVkRj?=
 =?utf-8?B?OTlNNml0VS94aTVOc1VmTTltT29LWURkRU92cTIxYXlQWWh4S3R2Y2t5NFZJ?=
 =?utf-8?B?SlJrbHlsa0M0RUcwSVcwT2NUeHQ5bVlXSlJXamVqVHJ3MHZDN0toNWhKak9U?=
 =?utf-8?B?ekU5bGFaMG1yeVpmRi9jUnR4NXFTUmxDUFM2bEVlMDhqanJWNG1oVUJrWGZJ?=
 =?utf-8?B?VjIvdURSQXk1QW8vWG1CemkxSjYvbElVNWE0ZW1DczFLeXhXczBtMy9uemRJ?=
 =?utf-8?B?cnVqek5ESGYvRTJpMlhmZW5NdUZJQ2MyTlE3OVVyZURSclBMVlFUM0ZFbkRS?=
 =?utf-8?B?bjYvUUtxV0g5dTR2V1VSWTNubTF5TTNsMHVtUzVqYU85dmRSYkZWTVEvQVB2?=
 =?utf-8?B?a1hqeXkzT2Q0UWQ2SGR0SXhMTGdrSnNCZWFKbzE4bjQranc0K2NrSThEdjNx?=
 =?utf-8?B?VXpTbjQ3UlFHR2dVWjFxRmpsY0xvaDJMQXlsUjJ6U3Z4RjRvdHZ6THpuY0Yz?=
 =?utf-8?B?amRCUm5tRFB3dkduOVVpSm92MWlOazcvWisrck5FNmc0Q2JteC9jN1JUMWpx?=
 =?utf-8?B?eFVSNzhFWmZ3Z1dIT1V2ME16VWpEaFdSV1ZyekhiSlZjVFowdWZYU09DeFU5?=
 =?utf-8?B?YTBJNkVlOXRic2xzUGtzeXM2bGoySkNqV3JaQWNCbzNoSUZDMU05TzlxcjFk?=
 =?utf-8?B?aVBVcTBOQWFlcnFWQ1g4c1JYc05FRVBOdmdxUGtxWDRuRHhNNmVxZWg0UVk4?=
 =?utf-8?B?VlcvZStMVUMvWndFV2IvcnNaN2tDc3JzWHMxUkhIb1J0SVdqUjhweFhIQXVU?=
 =?utf-8?B?eGZodXJxekE4THptbS85V2ZVUitTbFdaVDJhRGF5THVPZVU3ZCtBMk05VHNw?=
 =?utf-8?B?cW5SZU1iejBRV05OVHVlMzUwS2c4b21wUVI0NEw4SjJGTkxNMVNWRzZCQ2hG?=
 =?utf-8?B?U0lEd2FvZ1VvWkhLQTMxQ3NidTVrR2JrUFVaSytucCsreXJwQmdoYXpjZTFO?=
 =?utf-8?B?bmdOWmNXNHBlRHc4L1g1amdjbWNpNmpTODFnSnZWUTJnNUlNaTZOZ1RYcnF1?=
 =?utf-8?B?SlhOdGpGTktKcW5kNGw1YW9FWGRGMkR1UW1HVklXaklGZkRxNFJ0dEtxdlg5?=
 =?utf-8?B?b3RrOEw1dFFaYVJOOHZFU1BmNFVZUDIyNHZhck4rUmpPbEFKY3VMUG1CaTh5?=
 =?utf-8?B?R3VxYTV4UVcyR1Jma0tjRm1Xa01OYVoybkFhL0pmWi90RlNDMnA0Q1N2QmRP?=
 =?utf-8?B?TW5ycXYydE42ZnpKNWFSdEtINE5ZelFLVFYxZ0Z0WktraUkzSnR1aUNibzJR?=
 =?utf-8?B?d094Y093Q25OUXNVbE1OYStxNk1wK3NYVGtZZUorb3J6TmVpU1hmYUhOUjBx?=
 =?utf-8?B?bWhuSUo1Qk1WdVhWQU5va0E5WDErS0l4UWFEMmdNb2hCUVFlZ25ES0k0VlBO?=
 =?utf-8?B?Z3lqRnI4bktrRG40SUpkazI1NjFVUmNaVWxsVU1lSVpVQXJCdTAwVUxJQUVt?=
 =?utf-8?B?U0dRNjZ0bUE2RkpUNHdVdy9zYXcrdUgyMUdSTFFhVUgybG9lMFJpZFVoSW15?=
 =?utf-8?B?ME80VVd3RkM2VnliYnI0L3RMWmRya0ZQS3ZnVFlOdmlzY2x4QWtMWk9vazFp?=
 =?utf-8?B?Zm5rSlJiNWx2UU8yK25CU29sZ0Y3WERhN29jOUpZb0pSZGE1TTBjZmdBcDV6?=
 =?utf-8?B?NGdDRUw3RXBCckhKbHV4c3FTemZPdHdNYll5ekpldGNUSzV0UjErVERmMTI4?=
 =?utf-8?B?bUFtQktYcUVScnZRYlVlTUc2R0p3QWFsSnVhNWJBcm96a1dwS1A0TnFlWnpi?=
 =?utf-8?B?akE1dCt4WGFPV0VuK2RTcHp3dDE0S3RuODlIeVk5cUhXZnRiRzV1bWNiVDZN?=
 =?utf-8?B?QXViUVB2WEZOaHZ4YkpHYktNQjI1U2p0TktUcTFkYWpaUkRDTnI3WGt6OTI0?=
 =?utf-8?B?aEFWVGZQRXFIVXZxRFBFNmZKbWllMzRnMUZmZDRpSFdKMmhyZDk2Z2VQK2Ux?=
 =?utf-8?B?ZERDN3NFL21FZDlYY1FmL2I5NXRoYWpiS0hxSno1dXl1ODNQLy9uSHRxRTlh?=
 =?utf-8?Q?r8m2M05szpLZKEtbS5VCSH+U/Bmr6TuEJCmcyaPKe/igb?=
x-ms-exchange-antispam-messagedata-1: VEGGs7Urdj8W4AAO658DobalyJJrVYGOeuQ=
Content-Type: text/plain; charset="utf-8"
Content-ID: <757DB2127BCE154C9717DFFA741A96AE@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: ymAoFENzg1uOKcQ33hYyRqjid7E15cLCVDI6kznfVKaj2PKA2+j+1CGixZNE8bi1fXGRRqIzmAiaFMZ+6OiiQZXWnE/oz67UfhAxue3dugUva98CSo9BcIIJoEDU9O3WonUBX7ds7L1orKEbAkhe2uuxVEmnnQqJxBIa7sbdt28DnLpGHW8l7OjekBalQt1vPB0fhRR5CD+B2kbMmHK5eqsQ2x5VPRpMTlZLbX/+UCRJ74+pnwUkYBkvfPUNU5I8nB9kbUJqB1Wa9geqW5jPajNKdTDN81jRZohjOw6RJ1552Zve2D0F8+uee8pu8xjU6cBYKeabsz6e9JdYwEnIBA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: gdDfXWXhmxXckRRijRNOGzK2kOj9to0V2Vj2jXgLHuiMPg1vpizFtY90Gk/aGz1jPUEim9tJtXmkLf/MJsD/ncpB8jRGh/z/i5DtijnTNI5FGnrdVka1Wuh4ns/YNRmanBe11kIDbaRFMTpgibSiFBa0D41O0BYHvJsVzQ8sGtbSCUmmOfadWqGYDnAsybvfEvEzWL23GMpll+oTxD/Kj2atweHgomX+pqFZmWrwFeo/5LfD33WRZ9mrLJOJW14vqnM0T399uKuCjL8MwymHpegdWJQ9w0HZ2umBPKGJtRyzl5xEpWkC65lR0ETSFEcHzvEu3gcZFgV/+Ei2uaYcustW/3zCc7ajtTNEbyjfcA3F35NE/GlxOxByFwNqkpK5r4LCAMFZj3P/oN+yMZN17X9BRcNwTxAQ8t4Qz2vQndhYgRxbrUhaUBItoCB13xBLjn3TBeSjwIezZWyBG99QzBVSp1iDfgxR3EEQyku4lwgYe+2QpN+lswaKK65ipDgbNnitOpdkG8NLKdnkZwMKpsXwBAdlo8dfmaWFrpLOm30OeNU+GbInpeSq/xOc2yvc9lXRVleF/Xkugo/HjXknb+dDFm5NwY73fvKk5exagq1zmvTOjnDZvR7XveaMZm7f
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY1PR04MB9561.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f62beb76-f068-463a-1c92-08df06feca58
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Aug 2026 01:25:49.5903 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IE+hpp3Y66yT9suS3DmqO6JLVF2KYb9dJblurdBhwRIsgRS8ObyNPUXGBSUxrLweWzUNJnlEFj+uCJwg+K/OxGs8Cc1mq5K39N5Xm7WX8W0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR04MB9402
Received-SPF: pass client-ip=68.232.143.124;
 envelope-from=prvs=696fae14a=Alistair.Francis@wdc.com;
 helo=esa2.hgst.iphmx.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_PASS=-0.001,
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
IFByb2JlIGZvciBhIGNyb3NzIG9iamR1bXAgYWxvbmdzaWRlIHRoZSBvdGhlciBiaW51dGlscyBh
bmQgYWRkDQo+IE9CSkRVTVAgdG8gdGVzdHMvdGNnIGNvbmZpZy10YXJnZXQubWFrIHNvIHRlc3Qg
bWFrZWZpbGVzIGNhbg0KPiBpbnNwZWN0IHRoZSBiaW5hcmllcyB0aGV5IGJ1aWxkLg0KPiANCj4g
U2lnbmVkLW9mZi1ieTogSm9lbCBTdGFubGV5IDxqb2VsQGptcy5pZC5hdT4NCg0KUmV2aWV3ZWQt
Ynk6IEFsaXN0YWlyIEZyYW5jaXMgPGFsaXN0YWlyLmZyYW5jaXNAd2RjLmNvbT4NCg0KQWxpc3Rh
aXINCg0KPiAtLS0NCj4gwqBjb25maWd1cmUgfCAxMSArKysrKysrKysrKw0KPiDCoDEgZmlsZSBj
aGFuZ2VkLCAxMSBpbnNlcnRpb25zKCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEvY29uZmlndXJlIGIv
Y29uZmlndXJlDQo+IGluZGV4IDU2MTU4Y2Q5NWY3Yi4uYjgyYTQzMDE4NTYzIDEwMDc1NQ0KPiAt
LS0gYS9jb25maWd1cmUNCj4gKysrIGIvY29uZmlndXJlDQo+IEBAIC0zMTgsNiArMzE4LDcgQEAg
YXM9IiR7QVMtJHtjcm9zc19wcmVmaXh9YXN9Ig0KPiDCoGNjYXM9IiR7Q0NBUy0kY2N9Ig0KPiDC
oGRsbHRvb2w9IiR7RExMVE9PTC0ke2Nyb3NzX3ByZWZpeH1kbGx0b29sfSINCj4gwqBvYmpjb3B5
PSIke09CSkNPUFktJHtjcm9zc19wcmVmaXh9b2JqY29weX0iDQo+ICtvYmpkdW1wPSIke09CSkRV
TVAtJHtjcm9zc19wcmVmaXh9b2JqZHVtcH0iDQo+IMKgbGQ9IiR7TEQtJHtjcm9zc19wcmVmaXh9
bGR9Ig0KPiDCoHJhbmxpYj0iJHtSQU5MSUItJHtjcm9zc19wcmVmaXh9cmFubGlifSINCj4gwqBu
bT0iJHtOTS0ke2Nyb3NzX3ByZWZpeH1ubX0iDQo+IEBAIC0xMzg0LDYgKzEzODUsNyBAQCBwcm9i
ZV90YXJnZXRfY29tcGlsZXIoKSB7DQo+IMKgwqAgY29udGFpbmVyX2Nyb3NzX2xkPQ0KPiDCoMKg
IGNvbnRhaW5lcl9jcm9zc19ubT0NCj4gwqDCoCBjb250YWluZXJfY3Jvc3Nfb2JqY29weT0NCj4g
K8KgIGNvbnRhaW5lcl9jcm9zc19vYmpkdW1wPQ0KPiDCoMKgIGNvbnRhaW5lcl9jcm9zc19yYW5s
aWI9DQo+IMKgwqAgY29udGFpbmVyX2Nyb3NzX3N0cmlwPQ0KPiDCoA0KPiBAQCAtMTQ4OSw2ICsx
NDkxLDcgQEAgcHJvYmVfdGFyZ2V0X2NvbXBpbGVyKCkgew0KPiDCoMKgwqDCoCA6ICR7Y29udGFp
bmVyX2Nyb3NzX2xkOj0ke2NvbnRhaW5lcl9jcm9zc19wcmVmaXh9bGR9DQo+IMKgwqDCoMKgIDog
JHtjb250YWluZXJfY3Jvc3Nfbm06PSR7Y29udGFpbmVyX2Nyb3NzX3ByZWZpeH1ubX0NCj4gwqDC
oMKgwqAgOiAke2NvbnRhaW5lcl9jcm9zc19vYmpjb3B5Oj0ke2NvbnRhaW5lcl9jcm9zc19wcmVm
aXh9b2JqY29weX0NCj4gK8KgwqDCoCA6ICR7Y29udGFpbmVyX2Nyb3NzX29iamR1bXA6PSR7Y29u
dGFpbmVyX2Nyb3NzX3ByZWZpeH1vYmpkdW1wfQ0KPiDCoMKgwqDCoCA6ICR7Y29udGFpbmVyX2Ny
b3NzX3JhbmxpYjo9JHtjb250YWluZXJfY3Jvc3NfcHJlZml4fXJhbmxpYn0NCj4gwqDCoMKgwqAg
OiAke2NvbnRhaW5lcl9jcm9zc19zdHJpcDo9JHtjb250YWluZXJfY3Jvc3NfcHJlZml4fXN0cmlw
fQ0KPiDCoMKgIGRvbmUNCj4gQEAgLTE1MTcsNiArMTUyMCw3IEBAIHByb2JlX3RhcmdldF9jb21w
aWxlcigpIHsNCj4gwqDCoMKgwqDCoMKgIHRhcmdldF9sZD0kbGQNCj4gwqDCoMKgwqDCoMKgIHRh
cmdldF9ubT0kbm0NCj4gwqDCoMKgwqDCoMKgIHRhcmdldF9vYmpjb3B5PSRvYmpjb3B5DQo+ICvC
oMKgwqDCoMKgIHRhcmdldF9vYmpkdW1wPSRvYmpkdW1wDQo+IMKgwqDCoMKgwqDCoCB0YXJnZXRf
cmFubGliPSRyYW5saWINCj4gwqDCoMKgwqDCoMKgIHRhcmdldF9zdHJpcD0kc3RyaXANCj4gwqDC
oMKgwqDCoMKgIDs7DQo+IEBAIC0xNTM1LDYgKzE1MzksNyBAQCBwcm9iZV90YXJnZXRfY29tcGls
ZXIoKSB7DQo+IMKgwqDCoMKgwqDCoCBjb21wdXRlX3RhcmdldF92YXJpYWJsZSAkdGFyZ2V0X2Fy
Y2ggdGFyZ2V0X2xkIGxkDQo+IMKgwqDCoMKgwqDCoCBjb21wdXRlX3RhcmdldF92YXJpYWJsZSAk
dGFyZ2V0X2FyY2ggdGFyZ2V0X25tIG5tDQo+IMKgwqDCoMKgwqDCoCBjb21wdXRlX3RhcmdldF92
YXJpYWJsZSAkdGFyZ2V0X2FyY2ggdGFyZ2V0X29iamNvcHkgb2JqY29weQ0KPiArwqDCoMKgwqDC
oCBjb21wdXRlX3RhcmdldF92YXJpYWJsZSAkdGFyZ2V0X2FyY2ggdGFyZ2V0X29iamR1bXAgb2Jq
ZHVtcA0KPiDCoMKgwqDCoMKgwqAgY29tcHV0ZV90YXJnZXRfdmFyaWFibGUgJHRhcmdldF9hcmNo
IHRhcmdldF9yYW5saWIgcmFubGliDQo+IMKgwqDCoMKgwqDCoCBjb21wdXRlX3RhcmdldF92YXJp
YWJsZSAkdGFyZ2V0X2FyY2ggdGFyZ2V0X3N0cmlwIHN0cmlwDQo+IMKgwqDCoMKgwqDCoCA7Ow0K
PiBAQCAtMTU5Niw2ICsxNjAxLDcgQEAgcHJvYmVfdGFyZ2V0X2NvbXBpbGVyKCkgew0KPiDCoMKg
wqDCoCB0YXJnZXRfbGQ9DQo+IMKgwqDCoMKgIHRhcmdldF9ubT0NCj4gwqDCoMKgwqAgdGFyZ2V0
X29iamNvcHk9DQo+ICvCoMKgwqAgdGFyZ2V0X29iamR1bXA9DQo+IMKgwqDCoMKgIHRhcmdldF9y
YW5saWI9DQo+IMKgwqDCoMKgIHRhcmdldF9zdHJpcD0NCj4gwqDCoCBmaQ0KPiBAQCAtMTYxNyw2
ICsxNjIzLDcgQEAgd3JpdGVfdGFyZ2V0X21ha2VmaWxlKCkgew0KPiDCoMKgwqDCoCBlY2hvICJM
RD0kZG9ja2VyX3B5IGNjIC0tY2MgJGNvbnRhaW5lcl9jcm9zc19sZCAtaQ0KPiBxZW11LyRjb250
YWluZXJfaW1hZ2UgLXMgJHNvdXJjZV9wYXRoIC0tIg0KPiDCoMKgwqDCoCBlY2hvICJOTT0kZG9j
a2VyX3B5IGNjIC0tY2MgJGNvbnRhaW5lcl9jcm9zc19ubSAtaQ0KPiBxZW11LyRjb250YWluZXJf
aW1hZ2UgLXMgJHNvdXJjZV9wYXRoIC0tIg0KPiDCoMKgwqDCoCBlY2hvICJPQkpDT1BZPSRkb2Nr
ZXJfcHkgY2MgLS1jYyAkY29udGFpbmVyX2Nyb3NzX29iamNvcHkgLWkNCj4gcWVtdS8kY29udGFp
bmVyX2ltYWdlIC1zICRzb3VyY2VfcGF0aCAtLSINCj4gK8KgwqDCoCBlY2hvICJPQkpEVU1QPSRk
b2NrZXJfcHkgY2MgLS1jYyAkY29udGFpbmVyX2Nyb3NzX29iamR1bXAgLWkNCj4gcWVtdS8kY29u
dGFpbmVyX2ltYWdlIC1zICRzb3VyY2VfcGF0aCAtLSINCj4gwqDCoMKgwqAgZWNobyAiUkFOTElC
PSRkb2NrZXJfcHkgY2MgLS1jYyAkY29udGFpbmVyX2Nyb3NzX3JhbmxpYiAtaQ0KPiBxZW11LyRj
b250YWluZXJfaW1hZ2UgLXMgJHNvdXJjZV9wYXRoIC0tIg0KPiDCoMKgwqDCoCBlY2hvICJTVFJJ
UD0kZG9ja2VyX3B5IGNjIC0tY2MgJGNvbnRhaW5lcl9jcm9zc19zdHJpcCAtaQ0KPiBxZW11LyRj
b250YWluZXJfaW1hZ2UgLXMgJHNvdXJjZV9wYXRoIC0tIg0KPiDCoMKgIGVsc2UNCj4gQEAgLTE2
MzksNiArMTY0Niw5IEBAIHdyaXRlX3RhcmdldF9tYWtlZmlsZSgpIHsNCj4gwqDCoMKgwqAgaWYg
dGVzdCAtbiAiJHRhcmdldF9vYmpjb3B5IjsgdGhlbg0KPiDCoMKgwqDCoMKgwqAgZWNobyAiT0JK
Q09QWT0kdGFyZ2V0X29iamNvcHkiDQo+IMKgwqDCoMKgIGZpDQo+ICvCoMKgwqAgaWYgdGVzdCAt
biAiJHRhcmdldF9vYmpkdW1wIjsgdGhlbg0KPiArwqDCoMKgwqDCoCBlY2hvICJPQkpEVU1QPSR0
YXJnZXRfb2JqZHVtcCINCj4gK8KgwqDCoCBmaQ0KPiDCoMKgwqDCoCBpZiB0ZXN0IC1uICIkdGFy
Z2V0X3JhbmxpYiI7IHRoZW4NCj4gwqDCoMKgwqDCoMKgIGVjaG8gIlJBTkxJQj0kdGFyZ2V0X3Jh
bmxpYiINCj4gwqDCoMKgwqAgZmkNCj4gQEAgLTE5OTgsNiArMjAwOCw3IEBAIHByZXNlcnZlX2Vu
diBMRF9MSUJSQVJZX1BBVEgNCj4gwqBwcmVzZXJ2ZV9lbnYgTk0NCj4gwqBwcmVzZXJ2ZV9lbnYg
T0JKQ0ZMQUdTDQo+IMKgcHJlc2VydmVfZW52IE9CSkNPUFkNCj4gK3ByZXNlcnZlX2VudiBPQkpE
VU1QDQo+IMKgcHJlc2VydmVfZW52IFBBVEgNCj4gwqBwcmVzZXJ2ZV9lbnYgUEtHX0NPTkZJRw0K
PiDCoHByZXNlcnZlX2VudiBQS0dfQ09ORklHX0xJQkRJUg0K

