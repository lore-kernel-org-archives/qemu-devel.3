Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9310CCA490
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2026 02:27:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xId63-0007MC-87; Sun, 18 Oct 2026 22:27:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=7454c2a62=Alistair.Francis@wdc.com>)
 id 1xId5z-0007IK-8s
 for qemu-devel@nongnu.org; Sun, 18 Oct 2026 22:27:27 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=7454c2a62=Alistair.Francis@wdc.com>)
 id 1xId5x-0001oC-Lv
 for qemu-devel@nongnu.org; Sun, 18 Oct 2026 22:27:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1792376845; x=1823912845;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=6a3BH9CXK5NyG37vou1o7RG24wBYYWioTSAPz6micVw=;
 b=p3EMB8keGluHEel2eGDYC9SHQa2uJip7uTVScjjgxsExU+2/GpW8huXS
 fW0S46zFjFilZB4Z0HPpkB2LNH5h2SeGOuJ316kpXTvkt3VtvK3SdJwGj
 AupxK2Zp6Rtx4gUmAF+MCCDMriA0C8mijrlC6WqvKryFIa+X7Bc9p/aIS
 NCUCSc1/KgTl90vr/JHrfsIoVXvW/vA1kZ+19Iugq3bGpTjF/6oGgwpCN
 w6dXzy3kiFTCd4yESA1FVjpsrCu4hPPyQRSuXdW5/1nWZyDY2iBdGGYpK
 znoWgRqveMNnUc1sh0EU8FSONhEHQUgDZ5MNXrJ9eG0VCnTe7MjfX3RG7 A==;
X-CSE-ConnectionGUID: AiQ13gGATWOaZaJXEk5JBw==
X-CSE-MsgGUID: o5hJegIUTPefztNLeI5/cw==
X-IronPort-AV: E=Sophos;i="6.27,166,1786982400"; d="scan'208";a="158416871"
Received: from mail-westus3azon11010006.outbound.protection.outlook.com (HELO
 PH7PR06CU001.outbound.protection.outlook.com) ([52.101.201.6])
 by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 19 Oct 2026 10:27:24 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jbv0Bn67R4CFP7DIdEJGjltan99UodGHZVgeuf5Yq8KzZa11NVxz3O35q28oS4Y/qnksubWQtPkWB1h3n4SRh+3RhjzTPRmamdkc1bmEEXvlAQRXdVZtoFwcvphZfVz9+9Sp/RkSF6egVTrSWCWNn2yc2/5Hnnff7gbIWDkgGqRWQgw/p1ViGz56qFeMkPP0P0DOi2RcGF5FYm52SoCuH+5kptaZQ0MrEyT1MgENBSvU/ydAa9tm/KVsP6inpVmXYIu5ExubdrUWdiAGIX90ozgr48PEr/b9uy+fafpE7vqWpVuOjcB+tyfmDDUchHNwHfgXaFvdgwpIi2e1fCgfxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6a3BH9CXK5NyG37vou1o7RG24wBYYWioTSAPz6micVw=;
 b=SMd4by0QcVic6FhEGXmEaNCIY8NsfcQs2Fab+y5ObIdnJxI7NpBYPJi3OgN6+rZZ06zRxmOdeRMll3IjBP8m4veLmFx/DgHQrmqin9Nf5pHhAcmkg2+Zi9YRl+azj5Xt+4L+xr9X2gPyL6LJBVFmCQ88JYLk/QIoxRSEk2tiI3NPCh/ibF/79/HDk6t9WgjT4MaXSEb3oGs+Ra6Ohsd1GLjE3/k80UrLrgjD3l/ZP9IFo9X6nEMENpelVUqvuybXbfB9OaL6QaNdMXKHcrF1Wm6GiftM/u0BkGb3CJkv6Q+zUExvmSxptpLCB75M04MvLEJzvKlFMSZOVwFAAB32vQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6a3BH9CXK5NyG37vou1o7RG24wBYYWioTSAPz6micVw=;
 b=L/q1vjhDb9gyNKG/W0IindS8GTauqy445ETq9hbZLx4SRTTOFW7uxe5W89cI0taleyG57mYiOSNug9UfozG8yrEi6adgbKdQ1BGOsiSThKxVlRBpmnSRjz6nFMRBo+EscuMObiTp8UnYd0su5lRNs+/Zj4HcUO9fScQPfHYqOqA=
Received: from MN6PR04MB9359.namprd04.prod.outlook.com (2603:10b6:208:4f2::13)
 by MN6PR04MB9336.namprd04.prod.outlook.com (2603:10b6:208:4f1::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Mon, 19 Oct
 2026 02:27:22 +0000
Received: from MN6PR04MB9359.namprd04.prod.outlook.com
 ([fe80::e729:bbef:5a37:2e77]) by MN6PR04MB9359.namprd04.prod.outlook.com
 ([fe80::e729:bbef:5a37:2e77%4]) with mapi id 15.21.0522.017; Mon, 19 Oct 2026
 02:27:22 +0000
From: Alistair Francis <Alistair.Francis@wdc.com>
To: "pierrick.bouvier@oss.qualcomm.com" <pierrick.bouvier@oss.qualcomm.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "philmd@oss.qualcomm.com" <philmd@oss.qualcomm.com>,
 "daniel.barboza@oss.qualcomm.com" <daniel.barboza@oss.qualcomm.com>,
 "anjo@rev.ng" <anjo@rev.ng>
Subject: Re: [PATCH v2 7/9] target/riscv/tcg: restrict tcg-accel-riscv-cpu to
 riscv targets
Thread-Topic: [PATCH v2 7/9] target/riscv/tcg: restrict tcg-accel-riscv-cpu to
 riscv targets
Thread-Index: AQHdXcVX4Wk/wjCm70uqGNG5bXxfJLcEJzMA
Date: Mon, 19 Oct 2026 02:27:22 +0000
Message-ID: <e54b32268309dffe545fa181cee9205aed301bbd.camel@wdc.com>
References: <20261016232304.1215119-1-pierrick.bouvier@oss.qualcomm.com>
 <20261016232304.1215119-8-pierrick.bouvier@oss.qualcomm.com>
In-Reply-To: <20261016232304.1215119-8-pierrick.bouvier@oss.qualcomm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.62.0 (by Flathub.org) 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN6PR04MB9359:EE_|MN6PR04MB9336:EE_
x-ms-office365-filtering-correlation-id: 0b8ded90-634d-49d6-0b76-08df2d8881f5
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|19092799006|366016|10070799003|23010399003|1800799024|261009223027099003|10067099003|56012099006|22082099003|18002099003|11063799006|4143699003|38070700021;
x-microsoft-antispam-message-info: AXFeepMJCeXy6I+YrDhNwJom9L7ajmUpyhnDD+17PErpRTqHSHvojDJjEgMTlJlvzrq/lTAxVpcOSz2mih1p62qBRIt2O0oxTOefGyQ4CkGkKToQzirJ4IVtV/tTPOYfwSWV3M1H1kcCVqWsfAOqhwtPcxJlZHx9ZUBL40aTcx4+r7BPeeStuhA8eI7Dv/MIUQJmOml1tvQk/vRR3xnN1xWf6CbCMhKI6yDdN/QqSlDeJ6pFNfOWL5xAtz475i5wuf/4mtktxR6tgM47m5wKzM22LCIGQVZI95rr1l6Mhee6GVRNT6fqNAJ327XSDnNpjPhaziN6KNNrM6KPnH1SiD9yb7e1796MPQApb7A9NVZ3QofJDv2K8M7OOLzPdZPIZJ1xfXPRQHkkUJknyeafarGfrQxGapZ/bAlL+v8jp6HHiPOO/XNr5ndoRbgEfeR3Z/GWWet+UjvRvyoWWUnfBf+N7A95nOJSdQZyzirRTWxstpVriuw6MuKICNQdxYJAnti+o9YrgPnlvYORVdVxpZqJIv7geFbXoAzji7mNj8vl5wTQmI5lYpn/s39reHArwh2FwF8tKoCmblkPEn6Fjh5BLXascIbFM/UKcZA7G7G1Z7mf3FkVUND0kirkgP3FKSrldkGr69eoUofRVL6i3zeZiLczundkJEpM0oQfIPem/ptitDeckKJy8FR4Qw83z2zC2sdZ/VQ0+zNiHiIDyrFzqoHu7T7cMUcC1PBe02M=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN6PR04MB9359.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(19092799006)(366016)(10070799003)(23010399003)(1800799024)(261009223027099003)(10067099003)(56012099006)(22082099003)(18002099003)(11063799006)(4143699003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZnpCMmh3T2luZnp2RFZwUEdSTW0rYWFReXNzZ2ptbkFXcFVSVzIrWjUrV0I1?=
 =?utf-8?B?czkrTzU0UmxtVjdSenlUVXNUQXJ6RkM0NW9ncmNCZUVBV1AyYnd6TUNBdzRQ?=
 =?utf-8?B?aXRQaEhlVlBtRW5iVUM5dENMenRGTFdQd3JpUUpSTHoxR0lwTjNEQnhhOVVs?=
 =?utf-8?B?TC9lZzNra2R4TGV0RG92TDFEMVJQSndFNFZheHlSK241THpEVzVQOXFEOEds?=
 =?utf-8?B?aU15WmNBYlZOT0VoTkM4TTUrS0FUN1ozdDJHcWVNVmE4LzhtQVpwR3A1ZEZz?=
 =?utf-8?B?UVNwSzJOTnU2ckhpaDBDb3ZsbmZ6N0U1NDFZYzhXcWVBOHk3UlF3ME03eXUw?=
 =?utf-8?B?ZEpsWHNYL1VQUkYxREFLWWVJVGJSOER0N09qUzBLa3R1a3dkUHFVb1lHNTdS?=
 =?utf-8?B?UFZWYnZhNEdjT01nVDB2QWs1anY2cytmU2pEOWJsSFRhMi9JY2JsS2srZFcz?=
 =?utf-8?B?RHVaM0Y2NFNHRmlnV0l1dVBLVXdScDVSQ01RdU5WYTdVVk55WlF3Z054V0pw?=
 =?utf-8?B?ZDFhRDFXOXRvcmt4OVhMT1Q5YldOTzRNeWYvZlFoUTFzRzE2VjdFRm9CN1ZJ?=
 =?utf-8?B?c21OM1BmeUY1Kzg0RHVscFIxZGVUckxPTW1oOE52bFhsMkI4TTVqOUlIZ2pS?=
 =?utf-8?B?UFRrbDZEVFgyQlFyb21lVGcra3RRTStEZTR2Q25HaXBBV1dacG9iU1E0OU5u?=
 =?utf-8?B?WUsremFtVDBLalJuazl6MEp2TkxWQkpjYi9uMm9JM2hkUjdJRHFKM2hHeVBY?=
 =?utf-8?B?L0tNMUxhYVBGN2xmblE0cDJ0d0ZDb1Z5SDI1YmtCRWhwYXdrYkc0MW9RSHhU?=
 =?utf-8?B?VW9xbGlBU0VQV3JnaVlSZVRBZG1QZUw4dzRHWS9GVjdONGI2czJYTVdXeWc0?=
 =?utf-8?B?YTRHeVRocjBVV1hPY1dZTXlQU1VQZDFJZitmU0FpVnlFdDVuenBLaVpkN2Z6?=
 =?utf-8?B?OEp4cnZ0Z3E0c3VLbHIzanlVYksxY3l5SkhPY0NPVkNuaUwweUpueTQ4MzVV?=
 =?utf-8?B?OHVuNGtZRXh4MFVKZ3lPd3F2WW1QM0hMUDRmc0VhZmkrUEU5eFlENWFIVENh?=
 =?utf-8?B?RVgyVlI1ck05d045eWZDeXByUVBkYS94MlNYUGE3TlY5YSsxS0dFUDRWN25M?=
 =?utf-8?B?UUN2aUhFaGVMVkM3K0U2UXBEcVBRYk9iTExGUXJDd3FQcjBKVUlvaEhIZEx0?=
 =?utf-8?B?ZGdjL21xam1zUHo1alpkcS9RbnVJcy9FeHlURzhyWlFib1YrTU4vVU9sd0lv?=
 =?utf-8?B?MnhSaUxIdjRlKzgrc3NUdUNiT2dRbDZkTlNEaW5rUGY1czB6VG9SOVRVSy8z?=
 =?utf-8?B?b1hYQ05PcC9LYXhWTFlQM0w2OVpSMUdGQ09pYmwvTW9CbWEyUkFnL1B2Z0xB?=
 =?utf-8?B?cldESHVGK0I1MmIzUVFHNWxabGVKd3BQempwaXMrYnF6QktQakMrMG1ySjl2?=
 =?utf-8?B?SEs4TEhKTzd3SE56SHhXS0JOZ2dScU5RZWo1azBaWVl1WUJIQldSSG9UejZE?=
 =?utf-8?B?QlNmUlUzaEhyUkJZcVIvOVBNQU1aUUVueThaQ3hZNzYrVWVWamRDNEVnNmRq?=
 =?utf-8?B?UlpQYW4xTlp1MkZrcUNvbUxHVTU1Y2ZoSnY1K3RrTEpJV0Y2NHZCb3krQmpP?=
 =?utf-8?B?RElvbmYvOEN6ZzVIZXo0c1hjaHplSlFJb0plQktKTFVpNkVURTVwejJ4QUFY?=
 =?utf-8?B?MXpHRXFQZWtLUWJXNVQ5MjNLTSt2Z3h0RjNRbkhQdVVPc3hURUkxUHhvM0Rq?=
 =?utf-8?B?WExoMUp1MVZTSmJ6MlZxUERRRnVET3BMQXg4bnVlQVZXMzdXUXArM2QvdXZP?=
 =?utf-8?B?bmk2NXFKcnVSRzdROWhNSFBxVzc2MytyU2NJZkw3MjlpUkY1VitLdkJRRDNv?=
 =?utf-8?B?WnVXUUppbUxmaVFUbEJJN3U2amVtMXh2M2R1K2hvR2VTeE9aYmFNWThKR0lP?=
 =?utf-8?B?VGZ6VUJHanlhT2xCb3c5eDRrNkFMSWY3dXV4MkFhcmdmMTFMZG9MUEIxRFpa?=
 =?utf-8?B?YldZQldhMVRHa1hEKyticFYzYWptR2dkcVZHVHBhdld2MDVTVEdobEJXb1k2?=
 =?utf-8?B?MUpmZUs2SkZQNnAvQkdUOTJPWEJjck5NQXFXSjFoRTRkc01wUEZ5ZkhQdVUz?=
 =?utf-8?B?bFZQVWJUMW44bzFxRlV2dEp4VlFseHM4dzNiR0ZYNnBRUGlIK1dvNmE5SHEv?=
 =?utf-8?B?dkk0RkVHUE4rOWdXUzZjOWEzS0RBaDNvSHhvbm1aT09mbWpKQ2JwUDF3Zzhz?=
 =?utf-8?B?Q1hHbkp5Q1NpZFQyYmdIbXZ6MGpNUnFRanFJRkZaNlB5VG5CMnVSZUgyUkFq?=
 =?utf-8?B?NlM4TXhRVk5XTXgwc09PTkFQUXZLeXdRWWpGSEdyMnljTXRaQTJ4eUJRWDZP?=
 =?utf-8?Q?tHrODpB3kVmCur/uLKyeCApsFgNnNZkodPIPOvBAMnXzV?=
x-ms-exchange-antispam-messagedata-1: 8ZfCwPEU1v56/swo8AFHGSh/HMernYibpfw=
Content-Type: text/plain; charset="utf-8"
Content-ID: <28AF7BCF68735A4789EA3FADF35947F5@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: TS8aVFjzCcxy4S+MMtLFk0Ugc67WADguk2bVPk1VErASmGCCR0dIVsiU7G7H4bJxDasRudIYF1mipyPeePCSS55UhjhC87+4wk+FPQzbEek3W5IivpmWxTFoGsguYeVXBSPJfajLXQCAcn1Ijt59Hzc/s6KS3VYyn6QgQn+3IupDP+g9gVhixc6yd+ljzejsaV2btf/dZuinhTpBUIAzsS55CzmfzohxA4BcZUEKoCDCpJXmh6z/xVYcyPmxf5uRn8RKouyB66OaRBu+4myGAxNVaIM8KfXTGN9/sgkm3Nr7rP4fF58EYPx+sbZZ4sbqNVFqxKbAT3086jHzhiq01w==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 1BCofESwdDqroi5tZRUz4PBSkIHsUwzgSryVlSCgx7eg2XJWNQFznmQXKYtt1m06a2E0ZHmiRJCwwAKqHEfu3Sr1Sfipl74dEEvUt5cJY3NVdfixDHxtQbN1dasT4lKDXNBP2y75S2sG9Y55PU00eRYPfSLSmxoRBDz9anjwkZ3CSFj65fJ7G9ZsXlj6DW8CI1h73++8nDYFVbkott71X1c3CGc5LUUgZK3HsyUnWDD2fewLib2opFaddRwSxafTx5I+qdzb6p3TbBmtNlWS1YYJZCamh4ZGBqDMULi+sRkXvItwh/1B6iPQn1lFe7j/Zr5XN/1954DFsn2aYO28/DdXGFHkoUs6UyNPTMakQgr90RmUs0nekvU/UTy6yXMZw8bRVLpJHWg0UxZevrACRBl30PrtH5bp3xnCiAfbrJKizQtDC6FJIlNwulvAWKU5iB8pbPBB7YeDmxp0mo6crQvkJ5Hg8qFsUheCgq1UMbhdGBlq6Qeu9g0otQYNsY51plEh+W8cU/JkyiV6mkR3dEchG80j0uDREqbi2deN3gb34BtJCIlQ2ueKhJib+SU/V+FEaiKL8yotrW4uGNWUNypBlLxUAT/rM6OtolEGeoH0V7f7kNd4UEmWCQIncfd4
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN6PR04MB9359.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b8ded90-634d-49d6-0b76-08df2d8881f5
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Oct 2026 02:27:22.8730 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: G7ivXJXuSJ+xetnmX+y68Cq2MaZOFyMm520ZLtMMxIud0Tpz7NaMCRAAbJFWPDTIQ5rEeGdN2w0FgcC0mXYw+CQPnHuOiqcHez0l/oOm78Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR04MB9336
Received-SPF: pass client-ip=216.71.153.141;
 envelope-from=prvs=7454c2a62=Alistair.Francis@wdc.com;
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

T24gRnJpLCAyMDI2LTEwLTE2IGF0IDE2OjIzIC0wNzAwLCBQaWVycmljayBCb3V2aWVyIHdyb3Rl
Og0KPiAkIC4vYnVpbGQvdGVzdHMvdW5pdC90ZXN0LW11bHRpLXRhcmdldA0KPiBUeXBlICd0Y2ct
YWNjZWwtcmlzY3YtY3B1JyBpcyBtaXNzaW5nIGl0cyBwYXJlbnQgJ2FjY2VsLXJpc2N2LWNwdScN
Cj4gQWJvcnRlZA0KPiANCj4gUGFyZW50IHR5cGUgaXMgY29uZGl0aW9uYWxseSByZWdpc3RlcmVk
IGZyb20gY3VycmVudCB0YXJnZXQ6DQo+IHJlZ2lzdGVyX2FjY2VsX3RhcmdldF90eXBlIHVzZXMg
JyJhY2NlbC0iICsgdGFyZ2V0X2NwdV90eXBlKCknIGFzDQo+IHR5cGUNCj4gbmFtZS4gTXVsdGkt
dGFyZ2V0IHRlc3QgdGFrZXMgdGhlIGZpcnN0IHRhcmdldCBhdmFpbGFibGUsIHdoaWNoIGlzDQo+
IG5vdA0KPiByaXNjdiBpbiBjdXJyZW50IHN0YXRlLg0KPiANCj4gUmV2aWV3ZWQtYnk6IERhbmll
bCBIZW5yaXF1ZSBCYXJib3phDQo+IDxkYW5pZWwuYmFyYm96YUBvc3MucXVhbGNvbW0uY29tPg0K
PiBTaWduZWQtb2ZmLWJ5OiBQaWVycmljayBCb3V2aWVyIDxwaWVycmljay5ib3V2aWVyQG9zcy5x
dWFsY29tbS5jb20+DQoNCkFja2VkLWJ5OiBBbGlzdGFpciBGcmFuY2lzIDxhbGlzdGFpci5mcmFu
Y2lzQHdkYy5jb20+DQoNCkFsaXN0YWlyDQoNCj4gLS0tDQo+IMKgdGFyZ2V0L3Jpc2N2L3RjZy90
Y2ctY3B1LmMgfCAxICsNCj4gwqAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKykNCj4gDQo+
IGRpZmYgLS1naXQgYS90YXJnZXQvcmlzY3YvdGNnL3RjZy1jcHUuYyBiL3RhcmdldC9yaXNjdi90
Y2cvdGNnLWNwdS5jDQo+IGluZGV4IGUwN2NhOTVlNDliLi5iZTkxMzYwMjQ4OSAxMDA2NDQNCj4g
LS0tIGEvdGFyZ2V0L3Jpc2N2L3RjZy90Y2ctY3B1LmMNCj4gKysrIGIvdGFyZ2V0L3Jpc2N2L3Rj
Zy90Y2ctY3B1LmMNCj4gQEAgLTE3NDksNiArMTc0OSw3IEBAIHN0YXRpYyBjb25zdCBUeXBlSW5m
bw0KPiByaXNjdl90Y2dfY3B1X2FjY2VsX3R5cGVfaW5mbyA9IHsNCj4gwqANCj4gwqDCoMKgwqAg
LnBhcmVudCA9IFRZUEVfQUNDRUxfQ1BVLA0KPiDCoMKgwqDCoCAuY2xhc3NfaW5pdCA9IHJpc2N2
X3RjZ19jcHVfYWNjZWxfY2xhc3NfaW5pdCwNCj4gK8KgwqDCoCAuaXNfYXZhaWxhYmxlID0gdGFy
Z2V0X2Jhc2VfcmlzY3YsDQo+IMKgwqDCoMKgIC5hYnN0cmFjdCA9IHRydWUsDQo+IMKgfTsNCj4g
wqANCg==

