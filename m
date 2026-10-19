Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44293CCF2D4
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2026 02:23:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xId2T-0005dR-Rq; Sun, 18 Oct 2026 22:23:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=7454c2a62=Alistair.Francis@wdc.com>)
 id 1xId2N-0005cz-44
 for qemu-devel@nongnu.org; Sun, 18 Oct 2026 22:23:47 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=7454c2a62=Alistair.Francis@wdc.com>)
 id 1xId2J-0001UF-32
 for qemu-devel@nongnu.org; Sun, 18 Oct 2026 22:23:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1792376619; x=1823912619;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=ICpNg6QwPBf0ZNtu9qEU5znYcjXpDlMcqQb988ExzIo=;
 b=SokTbWTuqMp4szgQgBclpouyXoCSl60Cy8EemBHckivbbtHRAl4uVLFT
 aI0K78jl506UiowkeNm5V3aj003K4xWVdooBgxLThpuAymsNTD7EAVk1Q
 VPy85hX/gLC31u9B1umxUTW00pDBz/D0glZ7mrJNPUrq+ZYP+MReWR9xc
 +SEn7fjkIvbzhfv/elKb1yumH71zZ8fItOlpSCF2veuujdtSdE6k5UW2k
 n/x5osuoOOrXDTiA/uoXKcYVF3Rlneo71sOrEHpdX113N489qwIo7VNC0
 egXYKEnXU6tsMwxIwlMtJOOKS5ooStafz7jO5bOotE9EHT53WN1rxz44X w==;
X-CSE-ConnectionGUID: bF/7cmJxRkWcUeNpXJEZfA==
X-CSE-MsgGUID: hpi3Gh/bTwujzwASLKagnQ==
X-IronPort-AV: E=Sophos;i="6.27,166,1786982400"; d="scan'208";a="158416665"
Received: from mail-westus2azon11012017.outbound.protection.outlook.com (HELO
 MW6PR02CU001.outbound.protection.outlook.com) ([52.101.48.17])
 by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 19 Oct 2026 10:23:37 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DWr3LVL/HvGi5RiSFrucEq77d7xGQie81t3NpZxqWWA4ME/O3TmAV1WrZ15ncKqIi4YAmcT4OoMMLfJTZmYDbyxsYNtALm47MKuJUbXvWZAZ2fo/pNvhBxEOkuEKxdVGXMM7ikS/f9ObAEuHMOrFyAzahlTxipayXcHq6aiZt6X5TXA/xuD+WJmjIvg0bcbR8gIO3AdzK9lfxJQSSDI6thIzwZWMfV9U1JqcagpdKiVTNcLFdmggzd+k9Uk48v0bGrOOK8XETuYE2cW6mpDqrq/JuZmolB56nvnx78KXyPmHQ5JKaXOc7HHLQePZRAB53KLQsh6rPHTmS54AsIZPIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ICpNg6QwPBf0ZNtu9qEU5znYcjXpDlMcqQb988ExzIo=;
 b=Ty/TCv6RKoqloZ2xcG2d6LLoIQFlhn9b3uziww5J9Se1B7bOGOoPc3v0EJQjBRQR7Htobcg8nzfCz/jZ3n7MDXdUQbYJlDxD34gWIa+ZnACFnGItuTwNCrKmgMQzGZLadrcW7t3lwT7w00D2o8J/feSAebnvD+0gIScS8ZFeOeA+dJPJgc9KCGspREQav27AOvmcaK+4M+8PAiCZfNnJQZUWqcw/qsyfHGFQJsUhGoP9t0RQktfnmiRjDAEDeLCujQJIMYP3dH/BOQflki6m3qwv0i7Bl4gTcNhv0slxVXFe7xq7EtbFYrAkl7sqSwiHL6YeB1K2KyC6G8NZjMAQhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ICpNg6QwPBf0ZNtu9qEU5znYcjXpDlMcqQb988ExzIo=;
 b=ZNnIbOwnFr9ducY9/YbJMw2gah5XXf+mUNaJcICRZHBWNnGGCkAA5DdczGFMfZ9PikPHo6/zfWhig67BdxBKqxvuA3joRHIU2B3JWCRlOQAYayoMGXtNvutpsleO5GDZRTde3RWQxihaO/do7HHaO2LCwCMVvLrov1WGuqn0WLo=
Received: from MN6PR04MB9359.namprd04.prod.outlook.com (2603:10b6:208:4f2::13)
 by MN6PR04MB9336.namprd04.prod.outlook.com (2603:10b6:208:4f1::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Mon, 19 Oct
 2026 02:23:36 +0000
Received: from MN6PR04MB9359.namprd04.prod.outlook.com
 ([fe80::e729:bbef:5a37:2e77]) by MN6PR04MB9359.namprd04.prod.outlook.com
 ([fe80::e729:bbef:5a37:2e77%4]) with mapi id 15.21.0522.017; Mon, 19 Oct 2026
 02:23:36 +0000
From: Alistair Francis <Alistair.Francis@wdc.com>
To: "pierrick.bouvier@oss.qualcomm.com" <pierrick.bouvier@oss.qualcomm.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "philmd@oss.qualcomm.com" <philmd@oss.qualcomm.com>,
 "daniel.barboza@oss.qualcomm.com" <daniel.barboza@oss.qualcomm.com>,
 "anjo@rev.ng" <anjo@rev.ng>
Subject: Re: [PATCH v2 2/9] hw/riscv/virt: make machine available for riscv
 targets only
Thread-Topic: [PATCH v2 2/9] hw/riscv/virt: make machine available for riscv
 targets only
Thread-Index: AQHdXcVTnlPNvYWxRkmOvBohwkETM7cEJiSA
Date: Mon, 19 Oct 2026 02:23:36 +0000
Message-ID: <579c6c6c65198657c20bd6632da2b8f7a0697a54.camel@wdc.com>
References: <20261016232304.1215119-1-pierrick.bouvier@oss.qualcomm.com>
 <20261016232304.1215119-3-pierrick.bouvier@oss.qualcomm.com>
In-Reply-To: <20261016232304.1215119-3-pierrick.bouvier@oss.qualcomm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.62.0 (by Flathub.org) 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN6PR04MB9359:EE_|MN6PR04MB9336:EE_
x-ms-office365-filtering-correlation-id: 7c2b1bb0-fd30-46f7-2333-08df2d87fad4
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|19092799006|366016|10070799003|23010399003|1800799024|261009223027099003|10067099003|56012099006|22082099003|18002099003|11063799006|4143699003|38070700021;
x-microsoft-antispam-message-info: YFxC+Xe/6zXRWppCfokeCfDsI7JXyvSESfyLpPKyEZgW2wU2LBfDemdV4WK1bn+BaMj9ktzZ4Ee/wF5nbOGn5WBTKX8TEgvgYlC6kkfa23w5HJVYbYFs9BgLGHKvllOEXU0JaneEsB43bYe9v3SY8GNGBe2KCGqUsVebG2HxknYJNTkL1eLAH41J1voEsSpF8VOxaguB2YekGhcP5rXhHTx4qf7qh5Crv1gI240NLwVBfGadsfjE3wczQNgBOkboGJUuCmozd5Gzq0Sup9AedOovkvGphbyqYaRi1HjvHnqtj10eH6zSyRedSDZVOBfhwkXdKVnw8DqCPAQK74HYbB89gzs7tr8KXd6f5OMMiu0AxPw0QkurKbVWKuJRD3SrNOXpaWJE7IB3eDahAEaAshzXbIA4QQQhu3TcIvaLzSXXSUSoCBmA3NPMELKEOLiFqwdoxVFdsLNErWpcEfQ0NAt7OzPj7sA8ZPSk6rKv+BJqj9iXmBRmHW+GI7ntIIqUEwiaiZT5N6JsN/vc//R5SaisGQdzJUahcBQzRG+0oSVsDXv8LepOcR3xQNPdK3dExJ83aCeoaDWi1iuKO1WWFPQTmNKl45WskwYpmEjLsidI/ENTHxSlanZ+sVqkupTXwf9LSlkKzO9ltXZAwsnJMhJlrcTJmgkJweBuunp+7cTbdx5cL1rxPs3Db/QLGC5IXlTQWRGPpSzGFA66DG8flLU1ponk5y+QRWWOVSqR2do=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN6PR04MB9359.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(19092799006)(366016)(10070799003)(23010399003)(1800799024)(261009223027099003)(10067099003)(56012099006)(22082099003)(18002099003)(11063799006)(4143699003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Y0dmVWhvelBRUWxCejRORVVoZXpSZUJyWU0vYUQxV2tNOXVzU2xsRjVWcmFz?=
 =?utf-8?B?TXBaOGFUYU5OSE1uYURFcXV3YXV5UENCRUM2dTFHbEYwTjEwSldGQkFCRGFo?=
 =?utf-8?B?eU4vdEw5RXdZV2lYMEgxd3BLWDRXcy9DeXU0QUdnV090OU1LN3JCczVhdkZm?=
 =?utf-8?B?WDJ0N2Y4bjVGTXFNMGlDeWFSOUp5T2JPamhlOFhVRU4vWmlCRWNyWVNGU0xG?=
 =?utf-8?B?TithcFgvaDNiUnkxcnZvUk5OSlNqRU81YUdxKzlyYTE3ZnRHaWoxMHlXVkIy?=
 =?utf-8?B?OFB5Y3Z5Y0RwZVczcGFtYWtyaHNmWjUrWExES2hsUWZjWURYR1llZWpvMklh?=
 =?utf-8?B?QlhSZ3lRaXpOak9pd3F4YlhWWjg1cUs1bC9mZEcxU01vc3RmS3RFZ3lWMExt?=
 =?utf-8?B?blMwSnNPeWdVTUlheHhVdEtudEZqV1B6NjM3QzhkbGRMNFFXY2E3YTc1VzFT?=
 =?utf-8?B?TTZnbUZQSC9RMS9venBYUTBoVUNOTXNJYys1N1AzSXVzbjhwS1dVNFhOTjI4?=
 =?utf-8?B?RFBISHFZUnFMWEZrancxdWRLNkpEM2YvZFVMeDY0K1pjdDZ0d3FobEtWWVBX?=
 =?utf-8?B?dEhaYUg3Zkp5ZmE5T3NQc3ROUy8xMUMwRnZQR2dLUk8xbVpRaVhVQ0UyM0R2?=
 =?utf-8?B?MXBJTmNQdW5WSlE0SFIrNmJiS3BHcndBT2U5WnRWeVRvNWxPWEtaQU1abm94?=
 =?utf-8?B?UFJFQ04yak94eGtsemR6a1Y1RTg2OGhNZmlXc1IyMkpoeHZUQ1pPdVNnR3E4?=
 =?utf-8?B?dWtib3hCWU5ONVNrblFLSnBRemVvQWNuakxRYVZrejFHZnRrbEcwazRsdHV2?=
 =?utf-8?B?UXhGVHB2ZDB4cmh6V3N0ZWl0KzdPL2pnT0RBRTh6bmpLWHE3VGhmUStJbGJX?=
 =?utf-8?B?TE1rc0J3VkFYcG1xZXdBWENRZzV2bW9sS0tzNjZVZy92MU83aUh5VysybW5S?=
 =?utf-8?B?a1pLMUtEdnI0OERXVnVMRUh3bGNXblNaOHhCbzljVUdvSUNQUXNjaWZVZk5M?=
 =?utf-8?B?VmY5elRHL0UxQ053SHJVSm4wekd6ckphTmgvdlF4WTIxKzkyTTdTY2xUdlJv?=
 =?utf-8?B?UVlDR1B5cWgzMlIrSXcyTGtvNUlwNHdpS2dROTNIbmxjcU5RMENtR24rNXdT?=
 =?utf-8?B?YlBLUStiUlhqYkJET21wK2kxc2h1NFNtUkllYmpWb3M2S000eVo0MkpSTDZz?=
 =?utf-8?B?a0JubGdoTklXc3c4a3czNFNvS3Q4Ym03aW5WeGJUWEFDRlZOT0h2OFR1bkZu?=
 =?utf-8?B?RDJKRndpUHB2ZUU2N3EvNENmUlU2dHUwMDZxajNMd0VUdmxlWUlzRkpLK2JB?=
 =?utf-8?B?ODVMOE1TV0lraVZqQVRQcDE3bnJLaFNvR0V1MzhkWkc5RTlqUUhrODU4SWFJ?=
 =?utf-8?B?RzkwbUZBRjFkSjM4c1J2T0Q3U1o5YkQwVVpTSlg3UzNoMmk5NTlNbTA2N3JD?=
 =?utf-8?B?Tlh1VnFZVkRSOUpadUNyekUxL1kzeEowU2RvaGVFTDZKNjRJTWlVd083emp2?=
 =?utf-8?B?MzlaUFNzTHRJcnNhK3oxUlVFV3FzNUNiVmZtSnphdW9GMkZoendGWWtNZm5F?=
 =?utf-8?B?VUZveEZPUlJLZ1dDVVRrTXpMVWxCM0IwN3hxNFdrQVM2aWpmay9qb0liaTZt?=
 =?utf-8?B?c0gvOFZRNE4wd0xXLzVmZGtFNjMzNWg5SzRJMnZQdVZDRUVMaG5xcmlUSjk2?=
 =?utf-8?B?YnhDRnJtaE5LVWhONEJTcVpERzU0OEFjNm91ZDFsVzcyTHJ0Ryt0UWVqRG94?=
 =?utf-8?B?bVpOMjNPV0JhVnNXY2hrZ21rSkc3Zk5hRUpKdGEwUzRubUFvVW1rdnhuUVV4?=
 =?utf-8?B?UUUwdGh3elhqamZYeFBhRDNPdDcwNnNKaUtINVh2QkNySUhGTXZGK1lIL1FW?=
 =?utf-8?B?RDAzUlA0TlEzVW9tNlFoRXhYNzM4eGtlbVJPblNJRk9qamlxdC9SbkpxSERW?=
 =?utf-8?B?VFFaZXVsNk9UcGdKV2dkck1LVVA2UU11MmtuWDJaTEMzOUViWU1qREE2MjBk?=
 =?utf-8?B?V0UzWWl6aFpkenRRSWwrNTdEMXNMSmx1UGovQ2xkWmx4SGQvdHVyakdYbFFi?=
 =?utf-8?B?bVRBMDJiL2JTcEovaHRQdm1KWkRHeGRUcEZtRW5xOVVpZmhFc2tDWGpYellm?=
 =?utf-8?B?ZnNMKzdiZ3JzRnNtNnBkQjNMSEhXelpZdlNERHE2eUZKVndlTGFkOXVBaXd1?=
 =?utf-8?B?Ui8zNlNsYVBiS2ltUzVWQllYMFM1QUhCTEtkYk5CcFVyc0pvRVFqV2ovOUJa?=
 =?utf-8?B?QVY2YWhDWnJCWkpjaW5vYUN6Sk51anpGZTdkanM4UUZYaG5qRjlrZGI0N2cz?=
 =?utf-8?B?cHVqY2NOald0UXBoU3liQnB4dzVQOHI0VWpWMVFMZXV2SmpnZnlFeDJVcnZi?=
 =?utf-8?Q?/05DsAK2yU0m/y0ccG2NmCCTKAPEddeZGm0KDMExLi2n5?=
x-ms-exchange-antispam-messagedata-1: xOvPdt/+Cpl3sFdCgs4E6Nr6k9CuZO/5S7o=
Content-Type: text/plain; charset="utf-8"
Content-ID: <05C4D3DEEF44A644BF69EFFDBEC58FAF@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: kkQXSGzwpNcyn87SbHLr9MwoOxreOMCNg5laUWZIpsPnAsG5mZnYLrTFI+0y3v880V4Gmbn1I8gRvtFxpWOiz3Q9/2mKTx25nhM5Pi1CIQGAT54XavTg3CrmoG4oWXEFipXS8SbxaPpli7iVPvXnRF3lOfY/nxtIBJQqfmiMcONUnubRTqPQ71t0uorJxtfFNpov0kDUY8u5BIyMXZR5SHVKcIAg3NFFbmyVRvNfydP/ySbp4rmnWoiJ+LYvhX6DfSLKD2mhf15VJQub6qx6A5Q1RKfT9a8DLJqnnscG3xcGUF152zvEqmKVyyJ167LV+GNuKEm8AEthXpMIoKwQQg==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: TktY1/O0x5G31wG3CPUCPX3/+1BCWtm/xQs5W7JgPatmzQ+c4FzKTzeQpD3Wpj/KiWfnai42Uh9HJV5yKIg9e6MbHYnFh5rfgIhB+kqhbbaaAaFB7mj1+UEz3DczWlnbtfD3rxWw3BtfQ7ZsyAMkWe/5FWdFqVVVYsn7XZoXUDHJWqrvgu5mqbjaa55iV1r0xr6O7xyVJlX7ATlK4LpeI6529ZlNmVQ6j9eunVD1hkqJ8gFx+kLanzobATboO0whaYz/lHA/AfUY0CefKXNvrP9QTqs8r3ph49thoWOH0Q4FHybgYcusOlC5lLGiZUVTJ7a2inKYzgp69JFZ7+a9UtrcXJ2s+SxvNyWZbf3NzqpZfCq3I28+34Gw8xKdPlsCuaAH+lBHTVCeTVy4RWbfyhrOJLjZEWVC8SFEHnN9jOZn3Y+W2ZkhoSd6618Lj17/XMy7Q7ni953qRLvYeu5bsxcxRfKnCnhsIL45OoICMVwQXhaxZ8HTKGjGD8Rmjnx9RHhUWYLsuCfbzFuJ/zd3PN7yHhN+1MG2Z0/ts97Ef9SYJzty4xV6D0i99YToXj2GGzHCAdtPpLLpBe1atFUsGCxDW40ZnSDZgA/pF24YSh7FG0vXNalJntKJ6h9bSAe/
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN6PR04MB9359.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c2b1bb0-fd30-46f7-2333-08df2d87fad4
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Oct 2026 02:23:36.1635 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LrsVIFiTj3OqXc232zTBVjSB9WKkpdil7i2muyMfAOjeWsjHddVUDghoOo0/rMccGFTZMcs71rwiGEHp0SCXuDqreS+0xSTPPzjiTIEUm+E=
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

T24gRnJpLCAyMDI2LTEwLTE2IGF0IDE2OjIyIC0wNzAwLCBQaWVycmljayBCb3V2aWVyIHdyb3Rl
Og0KPiBTaWduZWQtb2ZmLWJ5OiBQaWVycmljayBCb3V2aWVyIDxwaWVycmljay5ib3V2aWVyQG9z
cy5xdWFsY29tbS5jb20+DQoNCkFja2VkLWJ5OiBBbGlzdGFpciBGcmFuY2lzIDxhbGlzdGFpci5m
cmFuY2lzQHdkYy5jb20+DQoNCkFsaXN0YWlyDQoNCj4gLS0tDQo+IMKgaHcvcmlzY3YvdmlydC5j
IHwgMiArKw0KPiDCoDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKykNCj4gDQo+IGRpZmYg
LS1naXQgYS9ody9yaXNjdi92aXJ0LmMgYi9ody9yaXNjdi92aXJ0LmMNCj4gaW5kZXggZDRiNTAx
ODAyZjYuLjg5NGNkZDk3OTc2IDEwMDY0NA0KPiAtLS0gYS9ody9yaXNjdi92aXJ0LmMNCj4gKysr
IGIvaHcvcmlzY3YvdmlydC5jDQo+IEBAIC0yMiw2ICsyMiw3IEBADQo+IMKgI2luY2x1ZGUgInFl
bXUvdW5pdHMuaCINCj4gwqAjaW5jbHVkZSAicWVtdS9lcnJvci1yZXBvcnQuaCINCj4gwqAjaW5j
bHVkZSAicWVtdS9ndWVzdC1yYW5kb20uaCINCj4gKyNpbmNsdWRlICJxZW11L3RhcmdldC1pbmZv
LmgiDQo+IMKgI2luY2x1ZGUgInFhcGkvZXJyb3IuaCINCj4gwqAjaW5jbHVkZSAiaHcvY29yZS9i
b2FyZHMuaCINCj4gwqAjaW5jbHVkZSAiaHcvY29yZS9sb2FkZXIuaCINCj4gQEAgLTEyMDMsNiAr
MTIwNCw3IEBAIHN0YXRpYyBjb25zdCBUeXBlSW5mbyB2aXJ0X21hY2hpbmVfdHlwZWluZm8gPSB7
DQo+IMKgwqDCoMKgIC5pbnN0YW5jZV9pbml0ID0gdmlydF9tYWNoaW5lX2luc3RhbmNlX2luaXQs
DQo+IMKgwqDCoMKgIC5pbnN0YW5jZV9maW5hbGl6ZSA9IHZpcnRfbWFjaGluZV9pbnN0YW5jZV9m
aW5hbGl6ZSwNCj4gwqDCoMKgwqAgLmluc3RhbmNlX3NpemUgPSBzaXplb2YoUklTQ1ZWaXJ0U3Rh
dGUpLA0KPiArwqDCoMKgIC5pc19hdmFpbGFibGUgPSB0YXJnZXRfYmFzZV9yaXNjdiwNCj4gwqDC
oMKgwqAgLmludGVyZmFjZXMgPSAoY29uc3QgSW50ZXJmYWNlSW5mb1tdKSB7DQo+IMKgwqDCoMKg
wqDCoMKgwqDCoCB7IFRZUEVfSE9UUExVR19IQU5ETEVSIH0sDQo+IMKgwqDCoMKgwqDCoMKgwqDC
oCB7IH0NCg==

