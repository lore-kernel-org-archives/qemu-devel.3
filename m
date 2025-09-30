Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A625CCA470
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Sep 2025 23:54:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3k96-0001ud-Pv; Tue, 30 Sep 2025 19:52:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=36184fce2=wilfred.mallawa@wdc.com>)
 id 1v3k95-0001u9-G5; Tue, 30 Sep 2025 19:52:35 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=36184fce2=wilfred.mallawa@wdc.com>)
 id 1v3k8s-0000pF-8F; Tue, 30 Sep 2025 19:52:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1759276342; x=1790812342;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=g7usvt/chsp7FA01nR067MRVfEIO+AOo471jCecP69c=;
 b=M6aazN36TbU9nChI60hf9iXiee9xgz2+qEApkQjdndrRD5JX1FjZqwuF
 p7GdKckIPo7BEiZ9o1r6JdQ/PvK1F1p+EQ2HbGpCAXEXkcw41MD2fHTcV
 JZNIf7cMYYjaLx0W5IrKMl3cX0evWsLA2gpcKw70JDp2XdGb1EZE1jYs6
 xt7itW1Kz+M7yaT10NDy+ycEk/1xYtn79zV/+jrXVgoRauQkikxS7Dwqm
 ne75yiencrB/DYDvhDb7Nmbo4/i7QqQanmO1NKaedSVa2SAbz+Lc3cuBn
 cpxexowXvwMRn/PZZ3LZseP3Zwjj0XfhoD4OBq3dMUGaI5iHviCe6iwex Q==;
X-CSE-ConnectionGUID: NRNNWW1hSeWw32k/ENd+ZQ==
X-CSE-MsgGUID: pjBK76vSQNOdGExI5Jtr7g==
X-IronPort-AV: E=Sophos;i="6.18,305,1751212800"; d="scan'208";a="132038346"
Received: from mail-westus2azon11010071.outbound.protection.outlook.com (HELO
 CO1PR03CU002.outbound.protection.outlook.com) ([52.101.46.71])
 by ob1.hgst.iphmx.com with ESMTP; 01 Oct 2025 07:52:02 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sZeSt8dsO0rjvaiNrOucqUiK+IdNJuTqVJKvWI/BGM5qd6P4rc6CJEAn4Dr+585oiV1srIGefMXEVFE8tgNUnKYf+b3UwKdj8+Mgz8Q//ZN/3Fdhxc7SWiNUUgN9QDE4rGj/w+20xLkvBDORXhma/yPSW9pcT3iOn//V6pFPNpGvwkS7WYs3OocLR3jmUdJyLRuL3WaHvTbRjN7ACFCpmzO6nODWOSGoPVLGJZxBKSHsL/Dcyk4sgcdokqR4vPBsnshHCAcUfDdsUysmHs1cCoZAY5PpoRvjN/nRpVOwB3CdtgTak+at4BvYVLQ+Qs1pNe7kDzum/IyIcn3U8YTpMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g7usvt/chsp7FA01nR067MRVfEIO+AOo471jCecP69c=;
 b=d4YhgFU9PGVmsqdRAzNw4+0AUEjqoBwKA2QjxA1Y8JNQmguwrrbCM3aOxpLxzCLIzA6il1WxnDyJOkR0QqtZhJoTZJTgcTAnfU28H5HY+fKHP0x4sPCxFuflMPvfxQ2wgZpimvqWcUwW5EzFxvcuXG05OqwzCA2BRCwS0APO3Uv26Coev2sf7lAS/oMVrv5qSC5xG/QCIMzHAw0Bev25drr7RXVQLnaKs8ZGtbg0XAn7VWpdV9kCYpLCBGDs6FpQWgdQ34fnhYTJmOs/4O2PQtiZxkhbmG3IncAukddBRtXU1jPEipYrsepqL7P48uyoObRgxNsWNf5fg2dmlnxFDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g7usvt/chsp7FA01nR067MRVfEIO+AOo471jCecP69c=;
 b=S8kfH+y0dKr2+MZCapeVnL9i7VaVOQ0VWDI6J4NL5CxIXDC13iG4N7wMwVfpQa5KKwaKU+WUzucF7omgjg426eIsb1ql9NQ4YeY2q7a14/uHH7Fd6wQkmHkN43vv6uxYj7SAszdreiHQT0T9LhKqH0Oo/c6YDAmg5vJIip4xVxg=
Received: from PH0PR04MB8549.namprd04.prod.outlook.com (2603:10b6:510:294::20)
 by CH4PR04MB9508.namprd04.prod.outlook.com (2603:10b6:610:242::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.18; Tue, 30 Sep
 2025 23:52:01 +0000
Received: from PH0PR04MB8549.namprd04.prod.outlook.com
 ([fe80::5b38:4ce0:937:6d5e]) by PH0PR04MB8549.namprd04.prod.outlook.com
 ([fe80::5b38:4ce0:937:6d5e%4]) with mapi id 15.20.9160.015; Tue, 30 Sep 2025
 23:52:01 +0000
From: Wilfred Mallawa <wilfred.mallawa@wdc.com>
To: Alistair Francis <Alistair.Francis@wdc.com>
CC: "its@irrelevant.dk" <its@irrelevant.dk>, "hreitz@redhat.com"
 <hreitz@redhat.com>, "philmd@linaro.org" <philmd@linaro.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "stefanha@redhat.com"
 <stefanha@redhat.com>, "fam@euphon.net" <fam@euphon.net>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>, "foss@defmacro.it"
 <foss@defmacro.it>, "kwolf@redhat.com" <kwolf@redhat.com>, "mst@redhat.com"
 <mst@redhat.com>, "Jonathan.Cameron@huawei.com"
 <Jonathan.Cameron@huawei.com>, "kbusch@kernel.org" <kbusch@kernel.org>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>
Subject: Re: [PATCH v7 0/5] NVMe: Add SPDM over the storage transport support
Thread-Topic: [PATCH v7 0/5] NVMe: Add SPDM over the storage transport support
Thread-Index: AQHcI4qoFOHPgbzS+EKYBkVNTBt75LSsg1aA
Date: Tue, 30 Sep 2025 23:52:00 +0000
Message-ID: <d3b0354cce6afaf9b679796aeff3837b907cdc04.camel@wdc.com>
References: <20250912021152.46556-1-wilfred.opensource@gmail.com>
In-Reply-To: <20250912021152.46556-1-wilfred.opensource@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB8549:EE_|CH4PR04MB9508:EE_
x-ms-office365-filtering-correlation-id: 0688cc65-2d2d-42bd-69ee-08de007c5980
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|19092799006|7416014|1800799024|38070700021; 
x-microsoft-antispam-message-info: =?utf-8?B?S05NVWZJbTV1dk9OY3VmUngyQXpIZjdmUGZYa3IrY2xKbHF5Sno3bGQwZS8z?=
 =?utf-8?B?bDFtUEh3ek5xR0pVdHlYOVVFa01hc1R4RVZTQXFUWWx2UEZTVjBSdVdsQmM5?=
 =?utf-8?B?N2d1N0d6cVRlcUc2MktkcmI5MHRnY1dpNVFuTjdJbzREblh2WDlLU3lVZmRl?=
 =?utf-8?B?WjdQMnZ4bFBJRDJYcHZoSkFEY2EzNHEyRG9RNVV4eXAwTzFKbmJBbzdvRW5h?=
 =?utf-8?B?ek9QZm5lUHM2NURsdzUyY0krU3hZckpzUUUvcEh0VnlwWldYR2NWU2FTVENs?=
 =?utf-8?B?bTBSUk0ySWxUVmo1cklQVkEyN085T1BqTUo5T1llTWExdUNWdEp6UmpNOXNr?=
 =?utf-8?B?aHRFZG9rVEFyWHVFUk1pSlpEdFlMS0FrZS9PSzZyYzZwc1Nwa243VFAyOXhT?=
 =?utf-8?B?NWRrc1J3QlhaMEo2Mm1FRzZYOHJsdGhYSXYvZEtqWFdZUHVVbys0SkMrZHN6?=
 =?utf-8?B?YlY0UlBXRE53SVhiNWFpaC92LzZrdi9zWkdXLzIrSVdZRkdmLytKNzRGYS9q?=
 =?utf-8?B?amI3T2Z1M3FyalU3UVFFMGZNbENEcVJKK2xNT3ZZcGRidmNPSXZmejJDb2pK?=
 =?utf-8?B?Tk5WbmZSVmJUTWZDNzhxOERzZElaL0NLN05nOTR4MTR1dEVpWW5yNTg0eXdC?=
 =?utf-8?B?V2crM0V2c3NSZytDUzN1cElUSXZ4Y0I3WnBTRm9QbWpGK0J3MXR0ZVkzaElq?=
 =?utf-8?B?M01aOE9Pc2xJRTVGVm1IeWtmQjUzay9qbVJ5dkdQZ3NwUThac2t4RlMvTDcw?=
 =?utf-8?B?aFN0ZjBEaC9VMms3aHlncjZsamU3aE1EUTNpNFJHV21PaG9rVU8wRVZTQUoy?=
 =?utf-8?B?QVRjYXJ1VVEwYzRXODFCNzhDQWcyOFdtQllEaWJiOFltMUhWOVRKOWZBUHZI?=
 =?utf-8?B?TFZVSk5UbHRxWDk3cEdCdzRlUXd3SWtpZ0UxWk9sc0FJSjV0cTQ5dnJVWTRL?=
 =?utf-8?B?dDF4dS9DcU92MVRHRVpUeDlEK0VTR2VEeE5xZzFIVkZHRDhJR2g3T1VtRHRB?=
 =?utf-8?B?dUk2aGZnS2Y1d1ZVVXQ1a2pEalcyQ2NBMzRBRGhwM0dueDhhU0NONlI3Lzdz?=
 =?utf-8?B?blFOcFFiTldZUTJCTWZTVzU1L2F1NS9oOHd5SlF4VGc4ZmZBeksxcmFDMkM4?=
 =?utf-8?B?ckg4eUVRenJWMFp4ZW5ITVF1ckZmckxFRExhQTVqOExpbGRYY0J1NldqWXlZ?=
 =?utf-8?B?d2lmSFBpQXRmSGxubFZxNm15QmJZcDRVbUdaWFRWaEJMclBib05MQVA1R28z?=
 =?utf-8?B?YUxRV0xlUjFZNDlNTkVwdmE5RnErNmVNbzkwakhqUzNmVmpwOVBDVEg3VHNF?=
 =?utf-8?B?ODVZZWFFL2czb2gyWkt2NVM3cy9ZWXg0cCtuVmJqdURQNE5FZDdWSXgycjU3?=
 =?utf-8?B?OXRMYkE1VlR6dGE1elNhK2lZdXI2eUhEOWQzOHljc0tiT1FibjE5bkRJaEti?=
 =?utf-8?B?dGVLYkhZM0JNMzEwRG4wS3g3Y25ZbDlhZGFNbTI3VFh0Q3FnQjZ5ZVZPUGpD?=
 =?utf-8?B?UDMxTFVuMlg5NC9mbW5HdU5rKzJScTNPM3ljaU5qZjZxVSs1SDFVQ1RsMmE5?=
 =?utf-8?B?WWh2bFQ2bExuSFdubW0xL3N6MlpxUVl4NzZyS1VtRk5nNVRTc2ZPSnJVd2pN?=
 =?utf-8?B?dTJNQ1NZNVozbDZUOHNtSXFsVGxybGk1Qmk0VlpSZGdncTBKYSt2cFZraGlG?=
 =?utf-8?B?bW1GWW05dU1IaCt4YjNvRWdwRUdhaEt2RVlBZ2hFRVFnNTZqVUVhcEtZR3hh?=
 =?utf-8?B?MUd2cjZreVBiN2RhalFSSUR2V1Irdzh4a1cvZEVUOUpiMTNkWHNXblhhcC9W?=
 =?utf-8?B?OVFXTkFYcXFodEM1N0hycFFsMmp0a0s0cGZzQktHRTVZS1lvN0dWQjZDNnVz?=
 =?utf-8?B?NEp3NXlJSGRrZUxwUnF4SlZxc3NleFFadHBaMVF1Q29mbFJOK2tab0VpbWo0?=
 =?utf-8?B?ZjZPTmtpbFU5Z0hpQ2RyWlJLT0dxZGJhQytGNExoNUZvNGQwWFUyOFFKQVJV?=
 =?utf-8?B?bkhqZEw0cm1lclNOQWI4NTRWNUQyZFNOOTl5QlY2aFFrSVZpdzR6WnFtd2VK?=
 =?utf-8?Q?I5kY0t?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR04MB8549.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(19092799006)(7416014)(1800799024)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OWhlWjNzNmd3eXFBcjdHUHp3NXQrUzRYZTRrT05qT3pvRHVDbUJKbEcxeHJD?=
 =?utf-8?B?WC84LzErYm5Da25nQWFTa0VtRTNKNDV2MFBVUlp1bG9YOC9tZTI2WVI4WHc1?=
 =?utf-8?B?cWpyOVJoKzlhcW1LK3ZHdG5pNnhMWW45QmJZdUJtTlVJbkZvTFpmS2dyZnN4?=
 =?utf-8?B?OGdBZm9kSm5ORXFvSTZmMkZVUWxnMk9zb0FpTHJNOWNXK0MxOXdZSnZma2VD?=
 =?utf-8?B?dVhTVEpXVnp2Zm9hdktGUFNXUXd0UEZ2c1hsUkg4NCttU1dFeEdtazFybFNI?=
 =?utf-8?B?ejdjc1BTVTZIK0U5eDBqUnVXWSt0QlcxM1dIcXBhRkxjcDdrUi8yeEF3ZEZC?=
 =?utf-8?B?SE5kc1cwV2czaGdKbWF4NjVWNXFRbXVxNkhaUVlRS2lya2NNUkZFdzdmSkkw?=
 =?utf-8?B?dStjVHlKQTNFTGpXaXRHOUw0VUNlWTlhK1c1czRxemRaSzdrd3ZwWnNSU2Yv?=
 =?utf-8?B?S3BCNnNRcmtOZWNabStmQ0NhQWUzVGxoaG1vcG1jL0J6aGM2cXdHNDQ4NVY5?=
 =?utf-8?B?WXhraDY2ZzNkcDdoajdSNkt5bWtVZXhXUTFTOGpmNm16dTNlTmU4QW5RVER3?=
 =?utf-8?B?d04wcjNsUzk5b21kL3B3aEg3YXEyc2FkRlROK3Zmb1JoYmJ6U252SmlydEFr?=
 =?utf-8?B?QVBKditFZEl0eUhpSWIyeGI1M3R4enB4WnR2T0UyTlRQYm1LQVc0cDUxRHk0?=
 =?utf-8?B?WTBoNG9vWCtoSWYrY0FzM2llbXg4ZmdlNU13eDFISEFZdGNWN0p6bGF4em1Z?=
 =?utf-8?B?Qk9reDAwdU9MZGFuN0I1NlEveXUycTFKTUhkYk5YdFFjQndKcEVMTDZ3NEVU?=
 =?utf-8?B?Wm1xVGFIa3c3UkQ5Q2xVMS9rbVdObTg5ZDdKWFhGcjJiVTVpeGp3K2xSTzdh?=
 =?utf-8?B?QXZEaGZxM0Qxcm9NUzlFUkMvWUdRZzZXanVsRnJrTzdBUSsyaWdGZGlZRC9t?=
 =?utf-8?B?WFhZclJEdDI5NlZ1QU5xdmErbGNMd1RUc1lLVFBOK2dDUThYRzJteXJUVFVJ?=
 =?utf-8?B?aEErWXYvTXhuS3lqczBmSnZsYnd4SE0rZU1sd0JqRGcyL1B1eVYzUUFwYkdD?=
 =?utf-8?B?SkRrYmdlaitvWW1mUjE1SkFaU2M3cUM5L1ZLR0ZlMkFmQTd4QW1pL2c1OTFH?=
 =?utf-8?B?YUxRM1FIaW9QNDlwcFZVYzNWRjdIUXRFZHJ5eEtMZWVvb0dUQW9FWEw0VERn?=
 =?utf-8?B?UFlRZStZS2MvZFlJNjVJM1QyTHJDZkNPeDNOSCtiTTNvZDFiS1ZpODZKQ2JU?=
 =?utf-8?B?UTVwU0VnY21Sa2FFVk83cWpqa0FOeDJ4MFhNWHEyS1p1TGs3Ry9LbVdseWI0?=
 =?utf-8?B?Nnl1djZzMW5rZk00V2NOY3I5Mjh6Skh0cm0rbys4dTNlUG1RTXRLNGlOTE1s?=
 =?utf-8?B?bmxUREdnMzluYS9NZzVPL2pCREl1NHU3U0Z6T2VrZ2VrQVdPK3ZTcEZnaFZN?=
 =?utf-8?B?b3BMVG4vaUpscmJxa3pKb1d1alRpSnJYMzEzYTZJOXRpKzltb1BKc202VlFr?=
 =?utf-8?B?TGNqdkp6aktTdDJXek5MSW16QmIxcXIzUlR3Sk1hRWVLQnp6enBMV0lXdXhU?=
 =?utf-8?B?Z3hVSzFReVkrUXVNNDNFcXNqN3p1WFUwSHBkdGRCSmhzbDVhbGdKWTFjUDdV?=
 =?utf-8?B?aXJuMnM0VlVEUUduenRCVEVaeE5Mai9VWmxpMngwU0sydFU1UjNqRkE5QWFC?=
 =?utf-8?B?Q0pNK3BRWjBIRmluQ05FT1hZb3FveWVqYkpMN3o4aklmY0R6NThDbm1kVFY0?=
 =?utf-8?B?alRyVncwSUxlUzNrRUl1Nk0raStyZjhNY3EvOEJOU2ZmZDZPa05GSDZBeWRz?=
 =?utf-8?B?R2l2cWxFRFM4a1g3RFh0MDVuYS9xeEJGMVB3N2pjbnNJeEJqSXBrTHVMdndw?=
 =?utf-8?B?R3kyTFkyNXArQzZRdy96Z0ZxMFBaSTZITXo2ejgzam8vNDFRWGltRUhtazUz?=
 =?utf-8?B?b3YyamVFdk4wKzRLYjRwT2NtQlh5cUZ6b1QrT0pHQ2VQZTdmVG8rcXI1bzZU?=
 =?utf-8?B?Z3RKWkt2eFdVd3YvRmZVcDBra2t6aFFRNUNMOHFQTXovbG8xUTlUaFhPdjd4?=
 =?utf-8?B?U2YyQ0VIOTMxTWUyRjRDV1hubVQ5cmtyK2tLV1g0bndXWXdRVjM3L3F1TEVE?=
 =?utf-8?B?QzVRazhnTnp0ZDltc01tUWQwbnRGVkFXU2Nlek9XOG5wWFJpczBkYnhRdnE3?=
 =?utf-8?B?V1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3A05B4D2598B784585EBCE3C84F1A594@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: YFhdjB6aIXsvGXZ4hgl9b7JGoiWWF59mA8eNFjrCPXfTEvo3m/q2/rVKVrvG/uge9MJIT26RILQ3iu3T3zKggi9kEn0UgnrQ25ZKNQEMacuEuQpE81/vzdMRkWQ8OLm3NO8pVVrKB3IkOlXrMIMdPq8+GE4aPpbM5Ud5B4lg4Zr/4jk6yIkbkpqkm2V8YCutoO1wv36tyBJf8dnjO73Y//Ve76syO86PvjSwG1R+sqdMrEGk+jGyLA1NLyGmID0hDnOyYgy1fFAcX15IXf4ljL5gPmQEvjJUOFOHsIZrCz48JsAdymcNymVn6Rdn6WsrzrMYJwPUKsZv7LCwJuc/Tnk0J+6GoF/VM1KWVr1UbeeG4dNK5ObERT/ALsDbkSOzgQ5bnoyKnqozxWuKII6xs0+rsqGI7X0wp31PKsQR6HxMR/GcYSvy4tFlax9E4TI+VbLcoV0RQ+rGW3lsEF4ZVONLaMc9pe+Wda7TouSd05wiOO2J3Sv1xgiDaFb22tY+HDgHe36IfoJ9IeB0dDmEzteWqyI3+7A6Klapv60ZMx8Lw5PBzsQQmGkzkKECb8YlsoxsxkOkfnbxL0dIpogrCFhAZYUl14fMJQUHWd17iQYdmOxj4PtVGSqyrZufEZRv
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB8549.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0688cc65-2d2d-42bd-69ee-08de007c5980
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Sep 2025 23:52:01.0439 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pLPUaJcVNvhkjsZCPUk0RRZmsKjF41tQ+Z6Xli8U3+4CipZkJh1OrvOJJlGuGO418wnhrxQBn4Oqi5uIWGY9tw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH4PR04MB9508
Received-SPF: pass client-ip=216.71.154.45;
 envelope-from=prvs=36184fce2=wilfred.mallawa@wdc.com; helo=esa6.hgst.iphmx.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

R2VudGxlIHBpbmcgOikNCk9uIEZyaSwgMjAyNS0wOS0xMiBhdCAxMjoxMSArMTAwMCwgV2lsZnJl
ZCBNYWxsYXdhIHdyb3RlOg0KPiBGcm9tOiBXaWxmcmVkIE1hbGxhd2EgPHdpbGZyZWQubWFsbGF3
YUB3ZGMuY29tPg0KPiANCj4gVGhpcyBzZXJpZXMgZXh0ZW5kcyB0aGUgZXhpc3RpbmcgU1BETSBz
dXBwb3J0IGluIFFFTVUgdG8gc3VwcG9ydCB0aGUNCj4gRFNQMDI4Ng0KPiBTUERNIFN0b3JhZ2Ug
VHJhbnNwb3J0IFsxXSBmb3IgTlZNZS4gU1BETSBTdG9yYWdlIFRyYW5zcG9ydCB1c2VzIHRoZQ0K
PiBOVk1lDQo+IEFkbWluIFNlY3VyaXR5IFNlbmQvUmVjZWl2ZSBjb21tYW5kcywgYXMgc3VjaCwg
c3VwcG9ydCBmb3IgdGhlc2UNCj4gY29tbWFuZHMgaGF2ZQ0KPiBhbHNvIGJlZW4gYWRkZWQuDQo+
IA0KPiBXaXRoIHRoZSBhZGRpdGlvbiBvZiBhIG5ldyBgc3BkbS10cmFuc2AgQ0xJIGFyZ3VtZW50
IGZvciBOVk1lDQo+IGNvbnRyb2xsZXJzLA0KPiB1c2VycyBjYW4gc3BlY2lmeSBgc3BkbV90cmFu
cz1udm1lYCBvciBgc3BkbV90cmFucz1kb2VgLiBUaGlzIGFsbG93cw0KPiBmb3IgdGhlDQo+IHNl
bGVjdGlvbiBvZiB0aGUgU1BETSB0cmFuc3BvcnQuIFRoZSBgZG9lYCBvcHRpb24gaXMgdGhlIGN1
cnJlbnQNCj4gZGVmYXVsdCwNCj4gYG52bWVgIHdvdWxkIHNlbGVjdCBTUERNIFN0b3JhZ2UgVHJh
bnNwb3J0IGZvciB0aGUgY29udHJvbGxlciwgd2hlcmUNCj4gU1BETQ0KPiBjb21tdW5pY2F0aW9u
IGhhcHBlbnMgb3ZlciB0aGUgTlZNZSBBZG1pbiBTZWN1cml0eSBTZW5kL1JlY2VpdmUNCj4gY29t
bWFuZHMuDQo+IA0KPiBTdXBwb3J0IGZvciBEU1AwMjg2IGFscmVhZHkgZXhpc3RzIGluIGBsaWJz
cGRtYCBbMl0gYW5kIHN1cHBvcnQgZm9yDQo+IHRoZSBRRU1VDQo+IFNQRE0gc2VydmVyIGlzIGJl
aW5nIHVwc3RyZWFtZWQgZm9yIGBzcGRtLXV0aWxzYCBbM10uIFRoaXMgc2VyaWVzIHdhcw0KPiB0
ZXN0ZWQgYnkNCj4gdXNpbmcgYHNwZG0tdXRpbHNgIGFzIHRoZSBxZW11IFNQRE0gc2VydmVyIHdp
dGggU1BETSBTdG9yYWdlDQo+IFRyYW5zcG9ydCBzdXBwb3J0DQo+IGJ1aWx0IHdpdGggYGxpYnNw
ZG1gIHYzLjguMCwgYW5kIGBzcGRtLXV0aWxzYCBhbHNvIGFzIHRoZSBTUERNDQo+IHJlcXVlc3Rl
ci4NCj4gDQo+IENoYW5nZXMgVjEgLT4gVjI6DQo+IAktIHNwZG1fc29ja2V0X3JzcCgpIG5vdyB1
c2VzIHRoZSBuZXcNCj4gc3BkbV9zb2NrZXRfc2VuZC9yZWNlaXZlKCkNCj4gCSBmdW5jdGlvbnMu
IHNwZG1fc29ja2V0X2NvbW1hbmRfdmFsaWQoKSBpcyBhZGRlZCB0byBwYXJzZQ0KPiB0aGUNCj4g
CSBjb21tYW5kIHZhbHVlIGluY2FzZSBzb21lIGJ5dGVzIHdlcmUgcmVjZWl2ZWQgKHJlc3VsdCA9
DQo+IHRydWUpIGJ1dA0KPiAJIHdpdGggYW4gaW52YWxpZCBjb21tYW5kLg0KPiANCj4gCS0gQWRk
ZWQgaW5saW5lIGNvbW1lbnRzIHRvIGRlc2NyaWJlIGZpZWxkcyBvZg0KPiAJIFN0b3JhZ2VTcGRt
VHJhbnNwb3J0SGVhZGVyLiBDaGVja3BhdGNoIGdlbmVyYXRlcyB3YXJuaW5ncywNCj4gYnV0IGxv
dHMgb2YNCj4gCSBleGlzdGluZyBjb2RlIGRvZXMgdGhpcy4gVGhlIFFFTVVfUEFDS0VEIGF0dHJp
YnV0ZSBub3cNCj4gZm9sbG93cyB0aGUNCj4gCSBTdG9yYWdlU3BkbVRyYW5zcG9ydEhlYWRlciBz
dHJ1Y3QgZGVmaW5pdGlvbi4NCj4gDQo+IAktIFVzZSBleHRyYWN0MzIoKSBpbnN0ZWFkIG9mIG1h
bnVhbCBzaGlmdGluZy9tYXNraW5nIGluDQo+IAkgbnZtZV9zZWNfcHJvdF9zcGRtX3NlbmQvcmVj
digpLg0KPiANCj4gCS0gVXNlIGdfYXV0b2ZyZWUgZm9yIHNlbmQvcmVjdiBidWZmZXIgYWxsb2Nh
dGlvbg0KPiAJIGluIG52bWVfc2VjX3Byb3Rfc3BkbV9zZW5kL3JlY3YoKS4NCj4gCQ0KPiAJLSBB
ZGRlZCBleHBsaWNpdCBmYWxsdGhyb3VnaCBjb21tZW50IGZvciBjaGVja2luZyBgc2VjcGAgaW4N
Cj4gCSBudm1lX3NlY3VyaXR5X3JlY2VpdmUoKQ0KPiAJDQo+IAktIEFkZGVkIGVudW0gc3VwcG9y
dCBmb3IgU1BETSB0cmFuc3BvcnQgdHlwZSwgc3VjaCB0aGF0IGENCj4gdXNlciBkZWZpbmVkDQo+
IAkgdHJhbnNwb3J0IHR5cGUgc3RyaW5nLCBjYW4gYmUgbWFwcGVkIHRvIHRoZSByZXNwZWN0aXZl
IGVudW0NCj4gZm9yDQo+IAkgaW50ZXJuYWwgdXNlLg0KPiANCj4gQ2hhbmdlcyBWMiAtPiBWMzoN
Cj4gCS0gRml4ZWQgdXAgdGhlIGluY29ycmVjdCB1c2Ugb2YgYE5WTUVfTk9fQ09NUExFVEVgIHRv
IG1vcmUNCj4gYXBwcm9wcmlhdGUNCj4gCSBOVk1lIGVycm9yIGNvZGVzIGluIFBhdGNoIFszLzVd
LiBOb3RlIHRoYXQgRFNQMDI4NiBkb2VzIG5vdA0KPiBkZWZpbmUNCj4gCSBlcnJvciBjb2RlcyBm
b3IgdHJhbnNwb3J0IGxldmVsIGZhaWx1cmVzLg0KPiAJDQo+IAktIFJlbW92ZWQgTlVMTCBjaGVj
ayBmb3IgZ19tYWxsb2MwKCkuIFNob3VsZCBhYm9ydCBpbnN0ZWFkLg0KPiANCj4gQ2hhbmdlcyBW
MyAtPiBWNDoNCj4gwqDCoMKgIC0gQWRkZWQgaW50ZWdlciBvdmVyZmxvdyBhbmQgTURUUyBjaGVj
a2luZyBmb3Igc3BkbV9zZW5kcw0KPiDCoMKgwqAgLSBVc2UgZ190cnlfbWFsbG9jMCgpIG92ZXIg
Z19tYWxsb2MwKCkNCj4gwqDCoMKgIC0gRml4ZWQgdXAgZW5kaWFuIGNvbnZlcnNpb24gZm9yIGNv
bW1hbmQgc3RhdHVzIHJlY2VpdmVkIGZyb20NCj4gwqDCoMKgwqDCoCB0aGUgc2VydmVyLg0KPiDC
oMKgwqAgLSBBZGRlZCBjaGVjayB0byBvbmx5IGFjY2VwdCBTUERNIHNlbmQvcmVjZWl2ZSBpZiB0
aGUgc29ja2V0DQo+IMKgwqDCoMKgwqAgaGFzIGJlZW4gc2V0dXAuDQo+IMKgwqDCoCAtIE9ubHkg
c2hvdyBTUERNIGFzIGEgc3VwcG9ydGVkIHByb3RvY29sIGlmIHRoZSBzb2NrZXQNCj4gwqDCoMKg
wqDCoCBoYXMgYmVlbiBzZXR1cC4NCj4gwqDCoMKgwqDCoCANCj4gQ2hhbmdlcyBWNCAtPiBWNToN
Cj4gwqDCoMKgIC0gSW5pdCBzcGRtX3NvY2tldCBmZCB0byAtMSBmb3IgTlZNZS4gQWxsb3cgMCB0
byBiZSBhIHZhbGlkIGZpbGUNCj4gZGVzY3JpcHRvcg0KPiDCoMKgwqDCoMKgIGZvciB0aGUgc29j
a2V0Lg0KPiDCoMKgwqAgLSBNb3ZlIHRyYW5zcG9ydCBkZWZpbml0aW9ucyB0byB0aGUgcGF0Y2hl
cyB0aGV5IGFyZSB1c2VkIGluLg0KPiDCoMKgwqAgLSBBdm9pZCBzcGxpdHRpbmcgU1BTUDAvU1BT
UDEuIFVzZSBhIHVpbnQxNiBpbnN0ZWFkLg0KPiDCoMKgwqAgLSBGaXh1cCB1cCBpbmNvcnJlY3Qg
KHVpbnQ4X3QgKikgY2FzdGluZyBpbiBjYWxscyB0bw0KPiDCoMKgwqDCoMKgIHNwZG1fc29ja2V0
X3JlY2VpdmUvc2VuZCgpLg0KPiDCoMKgwqAgLSBEZWZhdWx0IHRvIFNQRE0gb3ZlciBEb0UgaWYg
dHJhbnNwb3J0IGlzIG5vdCBzcGVjaWZpZWQuDQo+IMKgwqDCoCAtIEZpeHVwIGFsaWdubWVudCAo
c3R5bGUpLg0KPiANCj4gQ2hhbmdlcyBWNSAtPiBWNjoNCj4gwqDCoMKgIC0gTWlub3IgY29tbWVu
dCBzdHlsZSBmaXh1cCBmb3IgdGhlIGRlc2NyaXB0aW9uIG9mDQo+IFN0b3JhZ2VTcGRtVHJhbnNw
b3J0SGVhZGVyDQo+IMKgwqDCoCAtIENoYW5nZSBzcGRtX3NvY2tldF9yc3AoKSB0byBkaXJlY3Rs
eSByZXR1cm4NCj4gc3BkbV9zb2NrZXRfcmVjZWl2ZSgpDQo+IA0KPiBDaGFuZ2VzIFY2IC0+IFY3
Og0KPiDCoMKgwqAgLSBBZGRlZCBhbiBhc3NlcnQoKSB0byBjaGVjayB0aGF0IG9ubHkgb25lIHNw
ZG0gc29ja2V0IHdhcyBzZXR1cA0KPiBpbg0KPiDCoMKgwqDCoMKgIG52bWVfZXhpdCgpLg0KPiDC
oMKgwqAgLSBNZXJnZWQgc3BkbV9zb2NrZXRfY2xvc2UoKSBjYWxscyBpbnRvIGFuIGVsc2UgaWYg
Zm9yIERvRS9OVk1lLg0KPiDCoMKgwqAgDQo+IFdpbGZyZWQgTWFsbGF3YSAoNSk6DQo+IMKgIHNw
ZG0tc29ja2V0OiBhZGQgc2VwZXJhdGUgc2VuZC9yZWN2IGZ1bmN0aW9ucw0KPiDCoCBzcGRtOiBh
ZGQgc3BkbSBzdG9yYWdlIHRyYW5zcG9ydCB2aXJ0dWFsIGhlYWRlcg0KPiDCoCBody9udm1lOiBh
ZGQgTlZNZSBBZG1pbiBTZWN1cml0eSBTUERNIHN1cHBvcnQNCj4gwqAgc3BkbTogZGVmaW5lIFNQ
RE0gdHJhbnNwb3J0IGVudW0gdHlwZXMNCj4gwqAgaHcvbnZtZTogY29ubmVjdCBTUERNIG92ZXIg
TlZNZSBTZWN1cml0eSBTZW5kL1JlY3YNCj4gDQo+IMKgYmFja2VuZHMvc3BkbS1zb2NrZXQuY8Kg
wqDCoMKgwqDCoCB8wqAgNzkgKysrKysrKysrLS0NCj4gwqBkb2NzL3NwZWNzL3NwZG0ucnN0wqDC
oMKgwqDCoMKgwqDCoMKgIHzCoCAxMCArLQ0KPiDCoGh3L252bWUvY3RybC5jwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCB8IDI1Nw0KPiArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KystLQ0KPiDCoGh3L252bWUvbnZtZS5owqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8wqDC
oCA1ICsNCj4gwqBpbmNsdWRlL2Jsb2NrL252bWUuaMKgwqDCoMKgwqDCoMKgwqAgfMKgIDE1ICsr
DQo+IMKgaW5jbHVkZS9ody9wY2kvcGNpX2RldmljZS5owqAgfMKgwqAgMiArDQo+IMKgaW5jbHVk
ZS9zeXN0ZW0vc3BkbS1zb2NrZXQuaCB8wqAgNjMgKysrKysrKystDQo+IMKgNyBmaWxlcyBjaGFu
Z2VkLCA0MDIgaW5zZXJ0aW9ucygrKSwgMjkgZGVsZXRpb25zKC0pDQo=

