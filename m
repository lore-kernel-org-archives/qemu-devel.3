Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AC24CA5FA2
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2026 01:51:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xB0W3-0002g1-Qf; Sun, 27 Sep 2026 21:50:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=724888370=Alistair.Francis@wdc.com>)
 id 1xB0W0-0002fO-GW; Sun, 27 Sep 2026 21:50:48 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=724888370=Alistair.Francis@wdc.com>)
 id 1xB0Vx-0004wy-Ul; Sun, 27 Sep 2026 21:50:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1790560245; x=1822096245;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=HrLn3KXybmUyUgh2IKYbfrOYSdx8sgIyxnw/gELJgw4=;
 b=rRrEM69T5q9ueavZgag3UrjR221AQ7tYnfnHiltcH1MV9WPw/6sK2Gh1
 tKWCWjsOC3dAvTugnBpKKJpPrAjewCe5xLWN/UpGOf+DgUIoEk1qgs7MG
 N/1gH7Kot8oMUR1LjzIfODna8fUy2CyoynFIJv6wMm+jxTeTu7cntVXYu
 zz9PfHlL4YlHnwH6qcVCVana2t5wJ8zIV/wyUdMvfkqQsi/78n8+KLvKp
 LPagDLR/rmQDpY6tjjLA5o4extVbpNfZFiUnSd1e8QJlDluyjOLL2mbfr
 yPcg4B2HnOf4wBBu58yNMZbecc/h6bFDrVqZSHNwP3O5dMXskJP1/ARSi Q==;
X-CSE-ConnectionGUID: pFAiUcwMQASy9bzC2hi9gw==
X-CSE-MsgGUID: nwZ0tn3ASAqYPwOM4Y96Gg==
X-IronPort-AV: E=Sophos;i="6.27,127,1786982400"; d="scan'208";a="156534998"
Received: from mail-westus3azon11011002.outbound.protection.outlook.com (HELO
 PH0PR06CU001.outbound.protection.outlook.com) ([40.107.208.2])
 by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 28 Sep 2026 09:50:42 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aqrjI6eoFqBgKUyF71v1KXVuLZ1aKUFRC8mv6QrA3aCJ4SoFH/Ge3kB/bc1Y254ijP+1PUeDEB+L/mtqa0hRPpP89AgMlwZXmxyxGdIu3FxcbD1nENHNoqGO9VFscSt4kaerG8EoNGcvIWCFuB1wAH6/CPXElbaNXlFRP3PcbDqqFLQ2BtTKJTFrAHg6eVDTkWqCS8oQ4hY7pi1GwH1VclzpLXWHAUGIfn69l6AWmnbqj0DMHdghCoW+kdp1YBrmvJM5py/AdAtubAKxNiiWodp0GEdUvPbQWDNiHps7Wxlac5vVP3oOKx4iiWpheONTZGi3mBKnPb57US44G5ByHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HrLn3KXybmUyUgh2IKYbfrOYSdx8sgIyxnw/gELJgw4=;
 b=asCNmDKgDunErzVWFNLTRL3Js2gg3jQPg5dwLHSpQDOEuFRoSM49IIfNatDH/Z2ne20vlRpwBTGjnpQ2cJMzkd/S2M8GxbX5ZeXWLa9GeYLvtuoiNpMsXYxTg2ZwO+5Q8uG8OXs01IHR+yFW1GxUy3DKWhgQwMkADFwyz7tCJaemQgN2f2fN17ZD5E3SAZ0Fmzhnk42ykklpXsFE2ZkmOitGkojMZ0tnW9EmBqjmvu8HCsjFaq12/PrPKtri0hEfTSrAUceNDbTMdWjHgA5C9wzBsU6BjsX1691KJOn1cw0KEh5CErpEPWKEHDIy73YnLf7EO+K7+huyWxXs4DaeWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HrLn3KXybmUyUgh2IKYbfrOYSdx8sgIyxnw/gELJgw4=;
 b=IMj4F+2ClP5DWhotvOjg2dnrwy+jLm8wDT16DCO+cYLvlzbi6yUGVcnLg3Q0dyNSbP7jkd+7rYpKmmc6fs8JPB0BqdWgWjelc8fpFbHM/PWr+UGpFxdJxiG6eQVMLUAMVVeWRjEV4gQVsFGIkIKoBnZ7/EB4uHFkyUQwZnt2i+4=
Received: from BY1PR04MB9561.namprd04.prod.outlook.com (2603:10b6:a03:5b6::11)
 by CH3PR04MB8925.namprd04.prod.outlook.com (2603:10b6:610:1a6::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.23; Mon, 28 Sep
 2026 01:50:28 +0000
Received: from BY1PR04MB9561.namprd04.prod.outlook.com
 ([fe80::3869:e494:2fa8:9888]) by BY1PR04MB9561.namprd04.prod.outlook.com
 ([fe80::3869:e494:2fa8:9888%6]) with mapi id 15.21.0451.022; Mon, 28 Sep 2026
 01:50:22 +0000
From: Alistair Francis <Alistair.Francis@wdc.com>
To: "liumingliang.dev@bytedance.com" <liumingliang.dev@bytedance.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "palmer@dabbelt.com"
 <palmer@dabbelt.com>, "daniel.barboza@oss.qualcomm.com"
 <daniel.barboza@oss.qualcomm.com>, "chao.liu@processmission.com"
 <chao.liu@processmission.com>, "zhiwei_liu@linux.alibaba.com"
 <zhiwei_liu@linux.alibaba.com>, "liwei1518@gmail.com" <liwei1518@gmail.com>
Subject: Re: [PATCH v3 0/3] target/riscv: Add experimental Zvabd extension
 support
Thread-Topic: [PATCH v3 0/3] target/riscv: Add experimental Zvabd extension
 support
Thread-Index: AQHdPt0J14e5GWL34kyzIrbFgKE8WbbjWbgA
Date: Mon, 28 Sep 2026 01:50:22 +0000
Message-ID: <dcccc679bf36092d2635a47d8049682815add1ab.camel@wdc.com>
References: <20260907152301.1701394-1-liumingliang.dev@bytedance.com>
In-Reply-To: <20260907152301.1701394-1-liumingliang.dev@bytedance.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.62.0 (by Flathub.org) 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY1PR04MB9561:EE_|CH3PR04MB8925:EE_
x-ms-office365-filtering-correlation-id: c8dcf539-1d62-43f1-03ad-08df1d02dc15
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|19092799006|376014|366016|10070799003|10067099003|3023799007|18002099003|22082099003|11063799006|56012099006|38070700021;
x-microsoft-antispam-message-info: 2mHx6nrwLkQ0rsQJFpTtHeE7MOoRNBa09cEjLQ+4PIzCPU6O2xmrQY/H3POBmtEGWbCeWRgbfdhLqEKcIfT/lKbyVShF/TGKHGg+4gV66PIi0WHuuFDUqzOmM+PDyzgoD1T2n5LU1nt52G2gMUnEupg9099tJopnPgJy6U24EbQPEluxn+fP/FSjOrCQhjzJRTObOCXpWRLZ9axiuqzU0SfUJwCnK8919gAs28gUlVNPSHdqR8dPlvXKr/zvSk2K/aJbeJOGW1cPXdLwwuVt1y1knPkxvA0zure9htr0MWP20qcXFaFZm9XBss9eixi6rtrotBeF9YiLJz2TTM3qcj5TV62xZU58bIiGB/8fMJ5bFNScJFgVYhk3U3PZd9U2lGB3YLd1yWhohz2AczabpnFWBJRoMfc+zd5k4aKJh5P11piS7raqXdpgF3rW8Y8rB+YnZwI6A5l0bmoiPvWAWOwXXZgZ+DOsayjJ+cvLLhNt2trerhnwi5ZJTSZs1HepnyYtt3VggFVWGzfWYZdr7svdSXbHjgwWFtaEIwh4I8bBAO4+3Wxh5Hjn36fHYHx7KflUq6E2sDCE/m2AN078VPPggmECbzGFDvwDt44OwoGJEZdVpTfH2+9zhZicBcKu+C6evdTEUOXPksCB3cO8qCgtOelN6QqIT0fIrVcMSOR82icIZtkwOCl5dHDxx7FwotnOKpvjJ4EyXP9KGy3rIk5rI37wmJhubdFijbITRTw=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY1PR04MB9561.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(19092799006)(376014)(366016)(10070799003)(10067099003)(3023799007)(18002099003)(22082099003)(11063799006)(56012099006)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OERDalhNVmNLTGF0VXZxbzE3RXpqUDBWbUl6VjVacHpyNmxTMnJHSkJ5UXJl?=
 =?utf-8?B?S1c5ZEhJbFYxWDdialpSK3lsbWhKcVlQMWRQV2R3eXZ3TDh2YVZtWno3cVF0?=
 =?utf-8?B?eEJ1TUd2RDRnVDQ1endnV1RQOWluWlc5c3hjUkVoOW1PNjlRU29Ra0ZyUXkr?=
 =?utf-8?B?VkF1Rkt6UWdMc0RmQk85eVBxZDJsczQvR1I1Z1VHM3dUZWk5NlVrREVMbGY5?=
 =?utf-8?B?WnRSNml6amZhS2c3WVluV2FHdGFTcXhKK21CODVhbTZVQVNmU21VL3FyVEd1?=
 =?utf-8?B?RmJseURCN0N0RVNLZDFXcGhkTU1GZVBZc1A4dEZTNlJ0YVd2ZTRaNjNBOWR6?=
 =?utf-8?B?MWFJVEtMQXp1REdRbGdTc1ZYZEJNcmtTeUNCMXNDOGpFcW5lU1FxeDVHQnZs?=
 =?utf-8?B?K0w0UFJjWUJTVlNhbjFKaStVVGIwTGF0MWM4ZUFFVk40eXdFdFRsME42T3lu?=
 =?utf-8?B?UG1DZ1dVMmpWQTQyOHRIQmxNMGtjbWJuaENHM0J6RzdtRm1KelhLdFNCRnh0?=
 =?utf-8?B?cENzS05MOEt1aFBtdklVQnFHOU5rcTlkdER5eGxEM1dMZ0VGWUxlUGp6dTdH?=
 =?utf-8?B?Z2RtYXQ0bHpCVnhhNmZoSEt5SUNoQVVLU09nMWd0dGREU0dyN3laK2t1K1da?=
 =?utf-8?B?U2w4OWpXSzlNMEdLOGhJaFozODB3M2M3Nk1oSDRXSmdwNzVBdXJ0VnhIbS9J?=
 =?utf-8?B?VlRIS3hiek14VjBmR1N5LzI5Zkh6Wm1iV0FqRUg4WXFHTGdKYVQ3OVpPaEJM?=
 =?utf-8?B?ZHFTU1hrZ1pIbHJtMHhBNXlTbHhUU0hkTFRtb2ZWREE5Q2ljNEYvNzhEbU1q?=
 =?utf-8?B?UFI0NVk5Vitsd215NHJoaThYZ3ZBNHVFOEhQQk83Z1RUMWJoR2dVeE5PMlRx?=
 =?utf-8?B?YkRMVS8rWjQ4TE4vNHJob1dmYkdmWUQ4T2hPRTEyV3pheUFaYXRZSVFCclE4?=
 =?utf-8?B?TTNSb01WN1RDMXRmbkJwY2ZVZkl5enIrWXdMeVBpSjVXUHROZnViSUhZYmRU?=
 =?utf-8?B?RTJOekNySFlhZWJFcWZaYStPRkVmeStNSFhOaXE2YXNQMUZuemdRM25EODhs?=
 =?utf-8?B?SlpUbkdzOFAxQ3FyOFVSTkpHRXpsK3JVK1dVcEZtVW5BREh0UHpja0RDYkZY?=
 =?utf-8?B?bGdQOE11VzMzMXAzaW9mOVp1d1FVelVIN2F2OHA1THhOUDF5dUtWZmxmTEdr?=
 =?utf-8?B?bTEwL0FvUTdNTUUwT0dYQ1BWWkFXdjcxR1lwUTMyTzNVL0lqOTllSUNxQnNM?=
 =?utf-8?B?WmdOQVJva1B1bzRyMVhGeWZxUmFMYlBtOUI5aFNLMm1IaTlGOGpRNGNVZ3ds?=
 =?utf-8?B?bkdBemZTZFRncW96dG9kT1Nsc0MwUGxUeWtUbkZVWThJaENJaDZ1b1FXcmdQ?=
 =?utf-8?B?UVY4bGpWckJseUd1OVVYcHVqR3VidmlmdHRjK2dYdFRZSENtK0hTQVNxY0VH?=
 =?utf-8?B?ZGFqN2Fpd3c2eWtqS1BuNzZvR2cwZFk0RFczNmpPa2xTZU96ekNHMHBRYzZE?=
 =?utf-8?B?Q1lWVFU0Yzg1UDRmbUFKOXJabWVCUmI1eDFuR2kxMzRDYXdzVzBTR014ZU5o?=
 =?utf-8?B?d3lvc0QxTENPUlZjK1JyYThnQU81THZOeWMvWm9jS1pyQUlrVEFUOTZXVjU4?=
 =?utf-8?B?d0oxMGo2SFpMTnJnKzJHV0NmbEczQXViU2ZyZWlFY29iL0Q4anhiWnB2V0V2?=
 =?utf-8?B?OGNOdlU5aCtlb1liaytwZEg2MTRCc3Q5eFlzQzNQd3VBSWN4M2dGRWU5L0s2?=
 =?utf-8?B?Y2NNbHFtcy9SYU1BK3NISFlVUGhFNkE2SnIrL3BPTjdsSjh1blFJVDROU2N1?=
 =?utf-8?B?bC9kK1p2YzNSYkJwSFN4c0NpRnM0UDBReHd6Mi9wWW9RM1FKUUcrQnhLR0ZC?=
 =?utf-8?B?SVpXQzdJMWVDUU1IU0s4TGNhTnNxa1hyMnNvNEY3ZDBEV2RUWjFZWEZtSlVZ?=
 =?utf-8?B?c0l5enpRS2dtUVdpNTNvUytVblNsV0YvaDZzSGxvRnlzUjljenBKcG9Scm54?=
 =?utf-8?B?eFQrem04TmQyck1MdjRDSm9DRHlLRndZUDZmUzVnd2dyZnpGdFQ1bXlnbk5Y?=
 =?utf-8?B?ZEhURTlmOHdrZkZvV1M1WkVRMjZiaVU3QmxnUEdtaVNseWdSL2VycUNwWUw4?=
 =?utf-8?B?UkE1a3FYMnc3Q0szYnhMa2VwQWZSK2hiQ2xJbVlWcWhnaDFsZE10TmJoMEJw?=
 =?utf-8?B?dUVaUFBmaFBKMjM5K0IyNUxycjVFR1o4QW1DRUtCTjM5SWhZU21EZ3JlQWlS?=
 =?utf-8?B?Qlg2VnZYaHFZM3BGTkdRV1ErTXQ0UDBaR2l5SEM3SFVpRFdlZUxKL2VjcVpx?=
 =?utf-8?B?TXBic3ptUDNtU21kK3BxSk9aWUJkMk00c3ozL1EzczBvUHhFMlR3UDFoNk8r?=
 =?utf-8?Q?iYx2k/b9bt4daeHQZ31hnsP7vsdlUdYyuLi8YWsG3rQmp?=
x-ms-exchange-antispam-messagedata-1: ejAbzCwZVNnKFT8FZ6GsEcRYKSKIvZNtBsg=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A9F365A51139424EA64B339F494CF8D5@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: rACXhUMmXrAL/nTabjCCGB6CRAlOvdhUMtStCwUsXNx/ehpKl5zIyOP85XeCQakW/eAqEOvKPBYRBW/99f4XviPtcWCRcnoDD0DeTVoLAyL7D/6b4ygpr3nZKby2bqDyhqeDfOkYv0WSO+1+zpfHQRG4Pd9xPnlCZPKXYqdsewtNqtP1S+kCboqqs1GcjaSkV1be94Xt8RBv3KC7+Sut/+m+iqErIpPnJKDxI02Arw5DGK//hF0iSRKa2X1ZezvmmxvdSnmvEayDn54cyS02HcCQxqUzdAcgVGMaL2wCdKPeOfZXVE7x1pLuLOv7L0MQ7mNZYR3q9mmuK2IJSpvf/g==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: GgPYxl53CuvGLBuZNXurPvnuuf0B6Y/Gm4/nnkvPzjkPPQd3HnlNOz2wEIU3tPlm0VNWOojMjQ0L0Qr36BuOINsr85x/97Nt730gE04AkWj+LPK/AwyvmN8QE5IDYxnB3Ork80ZFlWz2YKni9lqIzuRbvNHFVKAeoQW1ZVi3CLZ0jwmdrF2OkO8bbcHKvycxTYFY23pbZRO5foBZzdHVbRgPy2G/3XjHPqIY1nZeouR4aFwIKrnw9Bst6Ju0RE+GP2RERcE2pmNlCqET9c97N1TSpHpHfhN1hY51wQhhOdYiPJzdq8lQ8oOnW+6lwtH0dvo2OjT1tWeaGxt6djgO96rS/JY8235ZOmZ2uuXrxnDAvVczQKX8R/WH13Ujoc+Z5M1rTMP8XvVyezOmvqsFJBykNTlANDHsM7qOuqAPoKfWb/LfCzQL+t7sQG6Ei3CnCT79g4MBNs8fviw1aBSMemiwPmFp0mTqNYJbYjEbz42bRlqeT9ouiZqfuPgn8bcbeajzfW76CUCe+IviD1rX0kPwbS7DE3LMg6bHmI4Bnz38qEidUIGiohJNkgfmWvI8EVEPsRyAZ3kBeV3RWhuDXabXZgblpeygUigl7ECG2eG44aI1WzuIoQRhjvI1LsdP
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY1PR04MB9561.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8dcf539-1d62-43f1-03ad-08df1d02dc15
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Sep 2026 01:50:22.8847 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZErYnmwdzowny+/+Z6JiC4ndAGJqy1HE4/6f3QffdPcQ2UmoijOVsoXXpNDt18wmbku5QTR18+0WWuSv38P+oBafza22jvdlHAMphaHgLWg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR04MB8925
Received-SPF: pass client-ip=68.232.141.245;
 envelope-from=prvs=724888370=Alistair.Francis@wdc.com;
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

T24gTW9uLCAyMDI2LTA5LTA3IGF0IDIzOjIyICswODAwLCBNaW5nbGlhbmcgTGl1IHdyb3RlOgo+
IFRoaXMgc2VyaWVzIGFkZHMgc3VwcG9ydCBmb3IgdmVyc2lvbiAwLjkgb2YgdGhlIGRyYWZ0IFJJ
U0MtViBadmFiZAo+IGV4dGVuc2lvbi4gVGhlIGV4dGVuc2lvbiBwcm92aWRlcyB2ZWN0b3IgaW50
ZWdlciBhYnNvbHV0ZS1kaWZmZXJlbmNlCj4gaW5zdHJ1Y3Rpb25zIGZvciBpbWFnZSwgdmlkZW8s
IGFuZCBvdGhlciBkYXRhLXByb2Nlc3Npbmcgd29ya2xvYWRzLgo+IEl0IGludHJvZHVjZXMgZWln
aHQgbmV3IGluc3RydWN0aW9uczoKPiAKPiDCoCAtIHZhYmQudnYsIHZhYmQudngsIHZhYmR1LnZ2
LCBhbmQgdmFiZHUudnggc3VwcG9ydCBTRVcgdmFsdWVzIGZyb20KPiDCoMKgwqAgOCB0aHJvdWdo
IEVMRU4sIHdpdGggU0VXIDY0IHJlcXVpcmluZyBadmU2NHguCj4gwqAgLSB2d2FiZGEudnYsIHZ3
YWJkYS52eCwgdndhYmRhdS52diwgYW5kIHZ3YWJkYXUudnggc3VwcG9ydCBTRVcgOAo+IMKgwqDC
oCBhbmQgMTYgYW5kIGFjY3VtdWxhdGUgaW50byBhIGRvdWJsZS13aWR0aCBkZXN0aW5hdGlvbi4K
PiAKPiBUaGUgc3BlY2lmaWNhdGlvbiBpcyBjdXJyZW50bHkgdW5kZXIgcmV2aWV3IGF0Ogo+IGh0
dHBzOi8vZ2l0aHViLmNvbS9yaXNjdi9yaXNjdi1pc2EtbWFudWFsL3B1bGwvMzI3OQo+IAo+IFRo
ZSBzZXJpZXMgaW1wbGVtZW50IHRoaXMgaW5zdHJ1Y3Rpb24gZXh0ZW5zaW9uLCBpbmNsdWRpbmcK
PiBpbnN0cnVjdGlvbgo+IGRlY29kZXIsIFRDRyB0cmFuc2xhdGlvbiwgaGVscGVycywgYW5kIHRl
c3RzLCBldGMuCgpUaGFua3MhCgpBcHBsaWVkIHRvIHJpc2N2LXRvLWFwcGx5Lm5leHQKCkFsaXN0
YWlyCgo+IAo+IENoYW5nZXMgaW4gdjE6Cj4gwqAgLSBBZGRlZCBzdXBwb3J0IGZvciByZWNvZ25p
emluZyB0aGUgdmFicy52IHBzZXVkby1pbnN0cnVjdGlvbiBpbgo+IHRoZSBkaXNhc3NlbWJsZXIu
Cj4gwqAgLSBBZGRlZCB0ZXN0cyBmb3IgdGhlIGVpZ2h0IFp2YWJkIGluc3RydWN0aW9ucyBiYXNl
ZCBvbiBEYW5pZWwncwo+IHRlc3RzLgo+IAo+IENoYW5nZXMgaW4gdjI6Cj4gwqAgLSBPcmRlciB0
aGUgc3dpdGNoIGNhc2VzIG51bWVyaWNhbGx5IGluIHBhdGNoIDEuCj4gwqAgLSBVc2UgLmluc24g
aW5zdGVhZCBvZiAud29yZCB0byBlbmNvZGUgaW5zdHJ1Y3Rpb25zIGluIHBhdGNoIDMuCj4gwqAg
LSBSZWZpbmUgdGhlIGNvbW1pdCBtZXNzYWdlcyBmb3IgcGF0Y2hlcyAxIGFuZCAzLgo+IAo+IE1p
bmdsaWFuZyBMaXUgKDIpOgo+IMKgIGRpc2FzL3Jpc2N2OiBTdXBwb3J0IHZhYnMudiBwc2V1ZG8t
aW5zdHJ1Y3Rpb24KPiDCoCB0ZXN0cy90Y2cvcmlzY3Y2NDogQWRkIFp2YWJkIGV4dGVuc2lvbiB0
ZXN0cwo+IAo+IFpoaWJvIEhvbmcgKDEpOgo+IMKgIHRhcmdldC9yaXNjdjogQWRkIHN1cHBvcnQg
Zm9yIHRoZSBadmFiZCBleHRlbnNpb24KPiAKPiDCoGRpc2FzL3Jpc2N2LW9wLmMuaW5jwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8wqDCoCA5ICsKPiDCoGRp
c2FzL3Jpc2N2LmPCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgfMKgIDE0ICsKPiDCoHRhcmdldC9yaXNjdi9jcHUuY8KgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHzCoMKgIDEgKwo+IMKgdGFy
Z2V0L3Jpc2N2L2NwdV9jZmdfZmllbGRzLmguaW5jwqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKgwqAg
MSArCj4gwqB0YXJnZXQvcmlzY3YvaGVscGVyLmjCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCB8wqAgMjYgKwo+IMKgdGFyZ2V0L3Jpc2N2L2luc24zMi5kZWNvZGXC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHzCoCAxMCArCj4gwqB0YXJnZXQvcmlz
Y3YvdGNnL2luc25fdHJhbnMvdHJhbnNfcnZ2LmMuaW5jIHzCoCA0NSArKwo+IMKgdGFyZ2V0L3Jp
c2N2L3RjZy90Y2ctY3B1LmPCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHzCoMKg
IDYgKwo+IMKgdGFyZ2V0L3Jpc2N2L3RjZy92ZWN0b3JfaGVscGVyLmPCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIHzCoCA1NiArKwo+IMKgdGVzdHMvdGNnL3Jpc2N2NjQvTWFrZWZpbGUuc29mdG1tdS10
YXJnZXTCoMKgIHzCoMKgIDggKwo+IMKgdGVzdHMvdGNnL3Jpc2N2NjQvdGVzdC16dmFiZC5TwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfCA2NTkKPiArKysrKysrKysrKysrKysrKysrKwo+IMKg
MTEgZmlsZXMgY2hhbmdlZCwgODM1IGluc2VydGlvbnMoKykKPiDCoGNyZWF0ZSBtb2RlIDEwMDY0
NCB0ZXN0cy90Y2cvcmlzY3Y2NC90ZXN0LXp2YWJkLlMK

