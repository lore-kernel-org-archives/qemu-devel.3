Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 576EDC61DD3
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 23:36:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2Gxv-0003xJ-PN; Thu, 03 Sep 2026 19:35:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=6997dc6e7=Alistair.Francis@wdc.com>)
 id 1x2Gxt-0003wX-I7; Thu, 03 Sep 2026 19:35:29 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=6997dc6e7=Alistair.Francis@wdc.com>)
 id 1x2Gxr-00006a-3P; Thu, 03 Sep 2026 19:35:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1788478526; x=1820014526;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=A38iqQxL63eEbpsuLg5L2vfFIehhH0CwxrpyDlZZ0Gs=;
 b=M+rGX/YkP/D1RVReoRK5EB8uHEtEJKcXiAiCs3qc/IBfGCMxB/sJSGsM
 h9i/sbmldDpReur2ORiMLQS7c4ZNYMEy4tp7dIuPHhqh/ccHl4BUmaMET
 8GnVc0PgfwRkUYXeJLhJNhdAfccEO8eCmqBXwJJULLFiClLMurW5ZSZda
 V8yGCITffH9GGM4HxyC1PGiOzRm1KJislt3oW+V5Whw2nb3Cm2c8mTeuc
 vHEpnbz9UqDrjT7cBNXxo/X5sFN4MrQ6XA04CRCe2mNy+kirk837+JDuS
 UWCnQnHwUGN3zeoUHSrDHhUNa5Ak/51PZqjh8vy3TMFmJdyMdBmGAB94Q A==;
X-CSE-ConnectionGUID: C9SF0kl3RoWe0TdSVzn8ZQ==
X-CSE-MsgGUID: MgreSSYSRMizLMAB3iSZTA==
X-IronPort-AV: E=Sophos;i="6.25,260,1779120000"; d="scan'208";a="154704678"
Received: from mail-westus3azon11011025.outbound.protection.outlook.com (HELO
 PH0PR06CU001.outbound.protection.outlook.com) ([40.107.208.25])
 by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 04 Sep 2026 07:35:23 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hFiAJwayI3a99CL02anpSor4KMQ0JrGb9piaa4pYpigRCMcSkgTCi2qDFxtp67Pbdibyp1KmsyBrcVfkSjxVL/aWzvk9p/Hvv+9jpHrq5XlK/ozICXSC3qSkicAR5T8OaKsuSvz5+QT+0BgSsau7dHTt5Eo04OXmAWDd/qdb/5c+D7d0hwrrtQPPksQ0yS2Kr4dIrWyGgVLfVok8GtKJhyTUKKnXDdw62ihS0ySeKRNeCrWkX1FJB5eGcRE/HcasJNTyMcoemb/hwoyKxmB9RPAPUnTWXZJWEC1tvUimo3kCCjWxWJanA4LmouBKiI4tLz4YMtU6NjGQywe8osza6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A38iqQxL63eEbpsuLg5L2vfFIehhH0CwxrpyDlZZ0Gs=;
 b=UIb2LdZ5FZtYwmPDgF2gWLj3lOYEgfr0elinEw+KRbgHvbl0d7HqXhJ+au55VXcLWDJasRKfy81u+cqLsRLwKq/cnsCzwsPH6hzW9qhBUufgFNyKBsUbFkKPl7qOyWJo+0gJXaPzx07PU2GSVM5NnJhLXHNWRe0SXpxFpg6k9GRNZu3ovJ+kcz2lJXfFTeHSxw0FfgScEYKxyV2Pl0gu9eAqwvbL3lX/b/evt5l3G5+VShkH7/dpynDoOPsKAdT77vyCUf0yJFfFaQbLrthvSRpBFU+w9wDeTqQ13gTEhRATRVap6NjOcvJSI/I2ni1NjwujYlMxdm1Pto+2ZX7EXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A38iqQxL63eEbpsuLg5L2vfFIehhH0CwxrpyDlZZ0Gs=;
 b=hfsQ9SAcZXSKl87EJl+3WvO33u9GvWQIC0IKZYk2CdFVc1XjwGmJchMkffkPyj+gkidpUjdErmpRnBsfr1LohrP29MU/d9DfyQAUtXNbFnauzeWmu20wVSjK+TywhR7W708knhL7YtLuSxMmfBiLdVe488r2iO+uvICnUuFH/yg=
Received: from BY1PR04MB9561.namprd04.prod.outlook.com (2603:10b6:a03:5b6::11)
 by SA1PR04MB9018.namprd04.prod.outlook.com (2603:10b6:806:37b::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Thu, 3 Sep
 2026 23:35:20 +0000
Received: from BY1PR04MB9561.namprd04.prod.outlook.com
 ([fe80::3869:e494:2fa8:9888]) by BY1PR04MB9561.namprd04.prod.outlook.com
 ([fe80::3869:e494:2fa8:9888%5]) with mapi id 15.21.0382.007; Thu, 3 Sep 2026
 23:35:20 +0000
From: Alistair Francis <Alistair.Francis@wdc.com>
To: "daniel.barboza@oss.qualcomm.com" <daniel.barboza@oss.qualcomm.com>,
 "joel@jms.id.au" <joel@jms.id.au>
CC: "npiggin@gmail.com" <npiggin@gmail.com>, "mpe@kernel.org"
 <mpe@kernel.org>, "portias@oss.tenstorrent.com"
 <portias@oss.tenstorrent.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "clg@kaod.org" <clg@kaod.org>,
 "chao.liu@processmission.com" <chao.liu@processmission.com>,
 "zhiwei_liu@linux.alibaba.com" <zhiwei_liu@linux.alibaba.com>,
 "asrinivasan@oss.tenstorrent.com" <asrinivasan@oss.tenstorrent.com>,
 "liwei1518@gmail.com" <liwei1518@gmail.com>, "qemu-riscv@nongnu.org"
 <qemu-riscv@nongnu.org>
Subject: Re: [PATCH v3 00/16] hw/riscv: Socify Atlantis
Thread-Topic: [PATCH v3 00/16] hw/riscv: Socify Atlantis
Thread-Index: AQHdO2hnfIejyivOI0iBzgV/VE3rPLa9gvGA
Date: Thu, 3 Sep 2026 23:35:20 +0000
Message-ID: <5ae005b5968e375e341c7bcbc076c78f2d2bd426.camel@wdc.com>
References: <20260903055131.257903-1-joel@jms.id.au>
In-Reply-To: <20260903055131.257903-1-joel@jms.id.au>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.60.2 (by Flathub.org) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY1PR04MB9561:EE_|SA1PR04MB9018:EE_
x-ms-office365-filtering-correlation-id: 40281560-edf6-41cb-ab3d-08df0a1404cb
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|19092799006|376014|7416014|23010399003|366016|1800799024|10070799003|10067099003|11063799006|22082099003|18002099003|56012099006|38070700021;
x-microsoft-antispam-message-info: axvD3JWiVeB4W6sJc9jWX5LvUZ8UOopDToPsZM28ELGmsUKRj80re6ClXbCJwurr/99XZNsjwy7LPD70Dl34ySgbFk80l4/pztccyAd8Mq3NpcJ5BGhkjH5PocDnr/2JqqspvpU4Z+kBNYEeBevoEp8wfS6YDNAkGOrJviBvRSIAwq5r/NOQff38Vskf40mMNgzJ26u+BkR6JTs3g9e2wHCfmkp5fUUTJvWIoBM5p/tg6Ek2IAhEPCZBdyze+WHgdLE/vFAKzshA6cixGDkAdiZP66JxMm2lI9Vk/RGa6PRyELl4/w6BaZ+J3eE9bjdSKjfGNORIxDWgMruJc8YbUvxGEw1CRQLEtUv155zspVeWUrdIWs2dqOnWNr/I9xY5/wGbMrwh85cZ7mKw7SsLlK0srIjUNYMPrBX9s58vt+5lTis3W7QaO5u6qAHKFbmMWXWw57V3Mubhaxfs751bFbpPCM5z3ytLbFeIBObxT8BdCG0mdCTzZs/KpqWqOs7+I4oX7/XwstHDxiSvwo3oAo/2tfiUzjof9mdDMP3wfwvlFDEZ1CZ7/B6FCmkJoTr/QzG+96bEXLQxfzG+nFph290Wm4KtQsrkEYkNhGIOed22IqcE+0jMbP+s5BikTb5rhdgEH8wR7pKOdn3d+ukYe11sszLudNBoAVowf209mJjVnrAsKMCOGKQ/Vq/ue0WsaE+mnPpaEF6miEYte5d+NQ74ZN1HJDu2X1Tqf3Xa0wY=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY1PR04MB9561.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(376014)(7416014)(23010399003)(366016)(1800799024)(10070799003)(10067099003)(11063799006)(22082099003)(18002099003)(56012099006)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UW9WQlpsRGh2OU4wbjFUWWRmVjBCOUZXcVZ6YW1GZ3dUQ3A0RjhIWStEMjFt?=
 =?utf-8?B?NHRLUWpReFllcUFTMjRlSHY2TW0yN3FaZFQ4aVB6a1o2azN5bnZjNjEzUGpK?=
 =?utf-8?B?MmpKRmc3VXAxTE4xbGs4R1Y2MXVkWlJBQlgzU2pQZ1BJSkFhUU5BSzIrTnUz?=
 =?utf-8?B?RDNUVlZUaUt0c2dWSEQ4bXVYUE9BdTRwTTg2alNSaDNMMlBpaVhtazNZQ050?=
 =?utf-8?B?aXB2SERGYmhPNmFwNUtoN2pPM1IybXNuaG9GSXNJTzNtVGY0cE9GeGRsWlhz?=
 =?utf-8?B?TXhUcTU3SnFjeUE0RkFpSUhUajZHVGd5cXRrWXhDSm5MSkRKWFFIdjExMHhq?=
 =?utf-8?B?c3BBOFMwcENBUEhPSitCQ08wN2U1WEdrNERZVy9idS9QTFZHb3Z6R00yMmFG?=
 =?utf-8?B?NTBpcVhsM3M2b2VBLzNrYVlUeUlBTEhNTFBEN2VuUC84M0svbWs3RlBRT1pq?=
 =?utf-8?B?ZWx3eXFOR0VYRW5pV1FyU2NxK21lRHRWQWxnbEUvQjh0ZHFURGhLRUx0bEc1?=
 =?utf-8?B?d3NBekZrMmNvUlF2Rzh3T2VKdGxXUnhwUXNPSmFkVWVSMlJ1UURjMVdGbmZs?=
 =?utf-8?B?c2dGTWx6aW00RWFrakwvZHlFVzRtelIxR0N2OFNNTTF3b2hFOWhYeGdOT3d4?=
 =?utf-8?B?N05ybklkTk9NSlpQZGhDT2RDYjZDMlU5am5Feis2cGxuaDRUdnVLZFQ3YWhv?=
 =?utf-8?B?TVd2cWtpczZoSXd2NXU5VkhmYmRiV0lrSHF5UjNvQ0E3TWUvd0lwbnZrcWR0?=
 =?utf-8?B?UFhQS0EyYml1bzVubks4L1J6VGtuV05UUEtteVJ5UWZtcklTaE14Z0pMTFdC?=
 =?utf-8?B?cUFvNDUzbVFIWHFEblVxWFV3dy9MRWpUQjVPOW5pUWJvdlBHNjBnNE5scm92?=
 =?utf-8?B?amhvLy9WN3ZXR2dnM0FqbzUxMHVaN25HZzV0T2ZaRUpYSVBRRnBLOGZCczMz?=
 =?utf-8?B?bmdTWmtsRktwY0xmTFhlS29VcnVhZ052RjZpb1N0VW9PYzY2amRUanZQNndj?=
 =?utf-8?B?T3RQWXZDeDVBZkcyRjEzRFFpZ204YWt2UnZlWGxQbGVpR1NWaEExNU5ML21J?=
 =?utf-8?B?cUJtRG9OMEdJZi83dExNdm83R25sellYcnpPQmVOWExHYXpnT1hNbGpGcXRC?=
 =?utf-8?B?aUszQXpFL0Q0TURoblJSK01wQmNJTjBIbGowL3ljMzlMZERaN0dUbHoxd1V2?=
 =?utf-8?B?eVJ4SDk3SUhDQjFUZEpDUGd3MFBXcWlUak9NMjhqMStYcWZYUTcrYTlSZTk3?=
 =?utf-8?B?bTB4eWZUbnRsS1EvQklBOGhBY3dOVlh2TDJHQ05obVJ6QUMreDJPZW1JeGRw?=
 =?utf-8?B?N0dCUnpOV3NibzVXMDRtREZ4WFZGWWtxUWJraUF1ZHVNM1d0VEI0N1kwMGEx?=
 =?utf-8?B?djlUUFhVdVlPWGVzeGtwM0tnYlRPWmhWRXBjS3pZMDVXR1BQK2FVeVlLVFN1?=
 =?utf-8?B?aTY4Rm8zNnVUTlMrVjNQRGk3bGtpMTVod29FMVR2MUdGZk94d3ExRTJJeThv?=
 =?utf-8?B?YVo2Y3IzSjg2VW5rbVFoRTdLMnl3aU03TEpDbFlCUlBWMjJOeWFDaGZDYWVE?=
 =?utf-8?B?UDE5SHBrMVVUT0VCU1N2UmRZUEVTaWVvd2h5LzduWDF0UzZ1dVVVcEFLeE9C?=
 =?utf-8?B?cFIxUE1WTzJmbDhqUzNXZnQvbHppaS9KMHhYSUsrSS9WRU94ZVduM1lsand6?=
 =?utf-8?B?UkE2N3RHUUkwcmluVm41NHM5UWdRUW9MbGFkM1FiVW1pTTFHNzhnQTdhUExp?=
 =?utf-8?B?eFI0MWM2Rjh0ZTNEZkMvbDdGb3haTllXdWRBU0Q1VjR0ODY2SExGWkVGS29C?=
 =?utf-8?B?ZytBcUF2Wkp3bm9PMTA1UnZVdmRkUW5od1pDeEk2c1ZDUHk3MExzcTd1dmY0?=
 =?utf-8?B?R3h4NnptbjQ4aEU3Y0tFNkk2cWRNazlHK016bUV4c2wxVkRBbmcvaWY5QnBs?=
 =?utf-8?B?N2pEM1NmZkFlZGYyb3BhSWJtS250WUg1a2JBNysxZmF0ekkveC8xdUd5Y3Jm?=
 =?utf-8?B?dGFEMnJhUU1CbFhiWEdsOFpTbkVxb3VqUVBPUjNkWkpSYXR1QU9pcTRqSjd0?=
 =?utf-8?B?QTFnczZEYzRDNmRMMlZibE4wY1puczBXNkJPQkIzUS8vbE5jaXUzN0VKWkIx?=
 =?utf-8?B?SDBTQWtFOEtqR0piUGZMMGtjeW9KZ0N6Wm9KbzVMM0NlZ3d3TFc5YjRQQ21X?=
 =?utf-8?B?QUtzU1c1ZEZYb3l6Y2pUWGNGQXBwdGtGdTNlT3FESStMQ3FSTG5aK2RFZmxw?=
 =?utf-8?B?d1hmd3NXbTFEZHRiMmdDSmtvdVdGTmVPaURBM0J6THFLNlZaV0pkbDlycFZG?=
 =?utf-8?B?MGNuRmpEY3IwaVdpckZkSlBwRW1UaEp6clk4VTVtWEJreUlwTGJ6Y2JkYml0?=
 =?utf-8?Q?/1lmYkp6KmByDSisbngeX6dy1/G5ypPGmChCzWuZyHurp?=
x-ms-exchange-antispam-messagedata-1: hUheRed6rA4j8k6Z7hbEV9GfVcRRtzLcKwg=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8A0665865A8CDB44A76862AAEC31EF78@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: sbHIjcv/OIGDWlsicpfksDESC5cs9uhTDwL7anlMoDYuZi2mbdBqMTp0DbsLYAC+u4MJFrnMfYSXtARXxmIln6nIb9Ui174T/exIXIJ8a4PuS7wD+gvSf57JHJtCmgdRTl1jNCjz+ik3LD+Y1U1nO6PQ9ZziBs4/nucGnrlLX5YTm4sVZyJ8alQBujNtgycaq4TgZWD2u14w90kFHPSh1mTdmBtcPp4hPsRhUBWmATdrpzMOSaNmfAHCaFB2LU3AXZNwoTMAggE46jN/k8Xk6eMn95dwD+u6g7BL7Cr7nc+A/0bwLxoud3qZL9sDLik/n9Z8xSkGS8eFy+Voj7h6Zw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: VfJR22xXVSN3XAU/+jzZ21rdHlcmrG7xNtCdphc27i37Lo3sJHpsuYiD78XztzOL1gDkNSxKDW3sTwLngOgb8JLVwFV/8HKOXxwO9bTTxiF1GBjK+JTosfm/GvvRVrRwMGGHyiABkx7wcC8qlNlqLqvHXJZHbjI+nrEVDKhFtjxIU7eUDezRUFYtpPo4s8wem/cjWh9UhdBOyfv9AjXbpNhxw0tFs0etjXlzylkR9efe3uAgnCA2l69g+cXVIXVrWp1Q8FOq2HdP0elsATowxDYHnsqBspiSI7MA/kh6HBwgBChsBmGf0ansD3eYDQY8BlPZkvj5m57mcaAdcEN1s3OEVHOPKhjddSiMvmw6lzd50lDlrOAGjNh5V7nzsiqMY6P3e3d8gfiZiDom+pX+jmf2Q2A0IojZ1JLAFx0P5m/BktzAaSgU4HktNtgbG3KSqe5oQ+SjEhoFsIin7MUImXS7muo66vJXI6cMCMGZMhZRHmfT9TLQo6B0CLW5S8Mx9zzoGYCfCOcF1OdLVCL/KeyDNFINPnCWTco3y/n3C3csk2kpKu0M0lp9ZhN+4mJ5Ln1KD3jTud7+Nksnli8b+4G8anFF2BqJeyiQjqsqy5EG8cLbFdrVwdEKlcDgvjNR
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY1PR04MB9561.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40281560-edf6-41cb-ab3d-08df0a1404cb
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Sep 2026 23:35:20.5706 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VJT6ysVrrAKGjgzCsnxNR5aT9V422BC76FZHi+B8CFhLi9RoMTeg+cyAmdO0Gaw1h+aoscc2L5TxpdCmzrGrCvSin3vRz2iArhv7UuXr44Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR04MB9018
Received-SPF: pass client-ip=68.232.141.245;
 envelope-from=prvs=6997dc6e7=Alistair.Francis@wdc.com;
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

T24gVGh1LCAyMDI2LTA5LTAzIGF0IDE1OjIxICswOTMwLCBKb2VsIFN0YW5sZXkgd3JvdGU6DQo+
IHYyOg0KPiBodHRwczovL2xvcmUua2VybmVsLm9yZy9xZW11LXJpc2N2LzIwMjYwODMxMDIxNTAw
LjgyNTY1LTEtam9lbEBqbXMuaWQuYXUNCj4gDQo+IENoYW5nZXMgaW4gdjM6DQo+IA0KPiDCoC0g
UmViYXNlIG9uIHRvZGF5J3MgcmlzY3YtdG8tYXBwbHkubmV4dCwgZml4aW5nIGNvbmZsaWN0cyB3
aXRoIHRoZQ0KPiDCoMKgIGRldmljZSB0cmVlIHJld29yaw0KPiDCoC0gVGFrZSB1cCBQaGlsJ3Mg
c3VnZ2VzdGlvbiB0byBjaGFuZ2UgQG1yIHRvIEBjb250YWluZXIgaW4gdGhlIGZpcnN0DQo+IMKg
wqAgZml2ZSBwYXRjaGVzDQo+IMKgLSBBZGQgci1iIGZyb20gQWxpc3RhaXIsIERhbmllbCwgUGhp
bC4gVGhhbmsgeW91IQ0KPiANCj4gT3JpZ2luYWwgY29tbWl0IG1lc3NhZ2U6DQo+IA0KPiBUaGlz
IGFkZHJlc3NlcyB0aGUgcmV2aWV3IGdpdmVuIGJ5IENlZHJpYyBvbiB2MSBvZiB0aGUgQXRsYW50
aXMNCj4gcGF0Y2hlcywNCj4gd2hlcmUgaGUgc3VnZ2VzdGVkIG1ha2luZyB0aGUgbWFjaGluZSBh
IFNvQy4gVGhpcyBpcyB0aGUgcGF0dGVybg0KPiBmb2xsb3dlZCBieSB0aGUgQXNwZWVkIEFSTSBt
YWNoaW5lcywgd2hlcmUgdGhlIFNvQyByZXByZXNlbnRzIHRoZQ0KPiBtb2RlbGxlZCBoYXJkd2Fy
ZSwgYXR0YWNoaW5nIGl0cyBkZXZpY2VzIHRvIGEgbWVtb3J5IGNvbnRhaW5lciwgd2l0aA0KPiB0
aGUNCj4gU29DIGluc3RhbnRpYXRlZCBieSBhIFFFTVUgbWFjaGluZSB0aGF0IHByb3ZpZGVzIHRo
ZSBtZW1vcnkgY29udGFpbmVyDQo+IGFuZCB0aGUgbWFjaGluZSdzIFJBTS4NCj4gDQo+IEFzaWRl
IGZyb20gdGhlIGNsZWFuIGFic3RyYWN0aW9uIHRoYXQgdGhpcyBlbmNvdXJhZ2VzLCB0aGlzIHBh
dHRlcm4NCj4gd2lsbA0KPiBiZSB1c2VmdWwgaW4gYWRkaW5nIG90aGVyIFNvQ3MgdG8gdGhlIEF0
bGFudGlzIG1hY2hpbmUsIHN1Y2ggYXMgdGhlDQo+IFJDUFUNCj4gKGJvb3QgbWljcm9jb250cm9s
bGVyKSBhbmQgQ1BMIChDbHVzdGVyIFBvd2VyIExvZ2ljIG1pY3JvY29udHJvbGxlcikuDQo+IA0K
PiBUaGUgc2VyaWVzIGNvbnZlcnRzIHRoZSBSSVNDLVYgaW50ZXJydXB0IGNvbnRyb2xsZXJzIHRv
IHRha2UgYQ0KPiBNZW1vcnlSZWdpb24gZm9yIG1hcHBpbmcgdGhlbXNlbHZlcywgd2l0aCBubyBj
aGFuZ2UgaW4gYmVoYXZpb3VyIGZvcg0KPiBleGlzdGluZyBtYWNoaW5lcywgYW5kIHRoZW4gY2xl
YW5zIHVwIHRoZSBDUFMgZGV2aWNlIHRvIHBsYWNlIGl0cw0KPiBkZXZpY2VzIGluIHRoZSBtZW1v
cnkgY29udGFpbmVyIHByb3ZpZGVkLg0KPiANCj4gVGhlIG5leHQgZmV3IHBhdGNoZXMgY2xlYW4g
dXAgdGhlIEF0bGFudGlzIG1hY2hpbmUgdG8gbWFrZSBleHRyYWN0aW5nDQo+IHRoZSBTb0MgZGV2
aWNlIGFuZCBtYXBwaW5nIGl0IGluIGEgY29udGFpbmVyIHJlbGF0aXZlbHkNCj4gc3RyYWlnaHRm
b3J3YXJkLg0KPiANCj4gSm9lbCBTdGFubGV5ICgxNSk6DQo+IMKgIGh3L3Jpc2N2L2FpYTogVGFr
ZSBhIE1lbW9yeVJlZ2lvbiBmb3IgdGhlIGNyZWF0ZWQgZGV2aWNlcw0KPiDCoCBody9pbnRjL3Jp
c2N2X2FjbGludDogVGFrZSBhIE1lbW9yeVJlZ2lvbiBmb3IgdGhlIGNyZWF0ZWQgZGV2aWNlcw0K
PiDCoCBody9pbnRjL3Jpc2N2X2ltc2ljOiBUYWtlIGEgTWVtb3J5UmVnaW9uIGZvciB0aGUgY3Jl
YXRlZCBkZXZpY2UNCj4gwqAgaHcvaW50Yy9yaXNjdl9hcGxpYzogVGFrZSBhIE1lbW9yeVJlZ2lv
biBmb3IgdGhlIGNyZWF0ZWQgZGV2aWNlDQo+IMKgIGh3L2ludGMvc2lmaXZlX3BsaWM6IFRha2Ug
YSBNZW1vcnlSZWdpb24gZm9yIHRoZSBjcmVhdGVkIGRldmljZQ0KPiDCoCBody9yaXNjdi9jcHM6
IE1hcCBpbnRlcnJ1cHQgY29udHJvbGxlcnMgaW4gU29DIGNvbnRhaW5lcg0KPiDCoCBody9yaXNj
di9hdGxhbnRpczogTWFrZSBVQVJUIHVuaW1wIHJlZ2lvbiBhIFNvQyBkZXZpY2UNCj4gwqAgaHcv
cmlzY3YvYXRsYW50aXM6IFJlbW92ZSB1bnVzZWQgZmR0X3NpemUNCj4gwqAgaHcvcmlzY3YvYXRs
YW50aXM6IFJlbmFtZSBoYXJ0IGFycmF5ICdzb2MnIHRvICdjcHVzJw0KPiDCoCBody9yaXNjdi9h
dGxhbnRpczogUmV3b3JrIGRldmljZSB0cmVlIGNyZWF0aW9uDQo+IMKgIGh3L3Jpc2N2L2F0bGFu
dGlzOiBVc2UgbG9jYWwgcmVmZXJlbmNlIGZvciBzeXN0ZW0gbWVtb3J5DQo+IMKgIGh3L3Jpc2N2
L2F0bGFudGlzOiBEZWNvdXBsZSBSQU0gc2l6ZSBmcm9tIE1hY2hpbmVTdGF0ZQ0KPiDCoCBody9y
aXNjdi9hdGxhbnRpczogTWFrZSBUVEF0bGFudGlzU3RhdGUgb3duIG1lbW9yeSBjb250YWluZXJz
DQo+IMKgIGh3L3Jpc2N2L2F0bGFudGlzOiBFeHRyYWN0IGFuIEF0bGFudGlzIFNvQyBkZXZpY2UN
Cj4gwqAgaHcvcmlzY3YvYXRsYW50aXM6IE1hcCB0aGUgU29DIHRocm91Z2ggYSBtZW1vcnkgY29u
dGFpbmVyDQo+IA0KPiBQb3J0aWEgU3RlcGhlbnMgKDEpOg0KPiDCoCBody9yaXNjdjogQWRkIHBy
b3BlcnR5IHRvIGhhcnQgYXJyYXkgdG8gYWxsb3cgcHJpdmF0ZSBtZW1vcnkNCg0KVGhhbmtzIQ0K
DQpBcHBsaWVkIHRvIHJpc2N2LXRvLWFwcGx5Lm5leHQNCg0KQWxpc3RhaXINCg0KPiANCj4gwqBo
dy9yaXNjdi9haWEuaMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHzCoMKgIDMgKy0N
Cj4gwqBpbmNsdWRlL2h3L2ludGMvcmlzY3ZfYWNsaW50LmggfMKgwqAgNyArLQ0KPiDCoGluY2x1
ZGUvaHcvaW50Yy9yaXNjdl9hcGxpYy5owqAgfMKgwqAgNyArLQ0KPiDCoGluY2x1ZGUvaHcvaW50
Yy9yaXNjdl9pbXNpYy5owqAgfMKgwqAgMyArLQ0KPiDCoGluY2x1ZGUvaHcvaW50Yy9zaWZpdmVf
cGxpYy5owqAgfMKgwqAgNCArLQ0KPiDCoGluY2x1ZGUvaHcvcmlzY3YvcmlzY3ZfaGFydC5owqAg
fMKgwqAgMiArDQo+IMKgaW5jbHVkZS9ody9yaXNjdi90dF9hdGxhbnRpcy5oIHzCoCAzMiArKyst
DQo+IMKgaHcvaW50Yy9yaXNjdl9hY2xpbnQuY8KgwqDCoMKgwqDCoMKgwqAgfMKgIDEyICstDQo+
IMKgaHcvaW50Yy9yaXNjdl9hcGxpYy5jwqDCoMKgwqDCoMKgwqDCoMKgIHzCoCAxMCArLQ0KPiDC
oGh3L2ludGMvcmlzY3ZfaW1zaWMuY8KgwqDCoMKgwqDCoMKgwqDCoCB8wqDCoCA2ICstDQo+IMKg
aHcvaW50Yy9zaWZpdmVfcGxpYy5jwqDCoMKgwqDCoMKgwqDCoMKgIHzCoMKgIDcgKy0NCj4gwqBo
dy9yaXNjdi9haWEuY8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHzCoCAxNyArLQ0K
PiDCoGh3L3Jpc2N2L2Nwcy5jwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKgIDEy
ICstDQo+IMKgaHcvcmlzY3YvazIzMC5jwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHzC
oMKgIDkgKy0NCj4gwqBody9yaXNjdi9taWNyb2NoaXBfcGZzb2MuY8KgwqDCoMKgIHzCoMKgIDgg
Ky0NCj4gwqBody9yaXNjdi9yaXNjdl9oYXJ0LmPCoMKgwqDCoMKgwqDCoMKgwqAgfMKgwqAgOCAr
DQo+IMKgaHcvcmlzY3Yvc2hha3RpX2MuY8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKgIDEwICst
DQo+IMKgaHcvcmlzY3Yvc2lmaXZlX2UuY8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKgwqAgNiAr
LQ0KPiDCoGh3L3Jpc2N2L3NpZml2ZV91LmPCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHzCoCAxMCAr
LQ0KPiDCoGh3L3Jpc2N2L3NwaWtlLmPCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHzCoMKg
IDQgKy0NCj4gwqBody9yaXNjdi90dF9hdGxhbnRpcy5jwqDCoMKgwqDCoMKgwqDCoCB8IDI4MCAr
KysrKysrKysrKysrKysrKysrKystLS0tLS0tLS0tDQo+IC0tDQo+IMKgaHcvcmlzY3YvdmlydC5j
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHzCoCAyMSArKy0NCj4gwqBody9yaXNjdi94
aWFuZ3NoYW5fa21oLmPCoMKgwqDCoMKgwqAgfMKgIDE3ICstDQo+IMKgMjMgZmlsZXMgY2hhbmdl
ZCwgMzI2IGluc2VydGlvbnMoKyksIDE2OSBkZWxldGlvbnMoLSkNCg==

