Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27F40C48BF6
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Mar 2024 12:41:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rh7cb-0001Wz-30; Mon, 04 Mar 2024 07:40:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=786567a07=Jorgen.Hansen@wdc.com>)
 id 1rh7cZ-0001Wd-DA
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 07:40:43 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=786567a07=Jorgen.Hansen@wdc.com>)
 id 1rh7cK-0001YJ-Bq
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 07:40:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1709556028; x=1741092028;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=USTqQwNv7ZycD8gdFTFCYjvm11nPQGyUSREQ8wxf++w=;
 b=YPeBXbTciUiMFyb+qm9r4CAdsZ3o5d0SiS2rybL0zCCqjimceweiA+gK
 fUJC7/CdqzTqO+Z3sG1SYBR0HIs7hcMsFD9fNejxzQ4GaN0Qs14M1/w4X
 M4FObooZtriby05fqEeIi+gTwG1bWDdzsTKhP/nYq1Jmhl6QrTAIPl5Xx
 RM/PnzS5FvVlOrruwtQanTpZAf8YAeObdBnj9iSDDLeGRQBkX7Y1RcuyE
 ua7jzY+QIHekpUlbIJSpCwEfGy/EuBpcbb53bYr27D4BxeXecy/0kzyrb
 U17b4c8yDiXF8P2BGa+FhLCiGmJVuU/70Omg+FSwv2xQQ6vnYQhkDHN+5 w==;
X-CSE-ConnectionGUID: 7+Ti7lXsSiGhisnEp8FL/g==
X-CSE-MsgGUID: aRzoL+iiTWGje4BCu4COqg==
X-IronPort-AV: E=Sophos;i="6.06,203,1705334400"; d="scan'208";a="10747310"
Received: from mail-centralusazlp17013022.outbound.protection.outlook.com
 (HELO DM1PR04CU001.outbound.protection.outlook.com) ([40.93.13.22])
 by ob1.hgst.iphmx.com with ESMTP; 04 Mar 2024 20:40:20 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CMFo3gRZ9prwjXTs1D2I2inbbtCSo9+hLVe/1mWAgqMOg2k8cNVDtezpt/Oy5zybXouo1OhDlTS6bpwEjUDGx8ZSdOp3XFqo1oZw1ZwNKh1OultWBN3qDbyDHs2dRn1Z5uKGHTHJhcasJr8D+el6Tdi6FAj0kFuGM5Z3vzjLH+LbPl0/zcOXjy8+lAV6FCRGLrwNZoilq7l9Ry3yszF4LwCWTwElasFeZZcoqAu8rVbeVjIkWxJ396jh/4v4BgD3qWMsQJLwqYCvQOvIUQyxrgSWTyWAFdtHViuX+eKt5z9Bx5++FCS/MJBAJiE+IPD8BH3/YPwZhFd9M/FUNFo4yQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=USTqQwNv7ZycD8gdFTFCYjvm11nPQGyUSREQ8wxf++w=;
 b=F1C7R5LIGzqJrUaZzavz4acPow5jRylDBLPkPTJjZyIqqBpEnp4q9GWCtP7MfB7cUqvCdo61y3uGCfrCeEsbRvnrPjQyCdBF6E1yjYy2cVFD1l2750w6kzYpcCt/Wb1+NX0Q6XT4tiiQX0MzIaP+8d+TsTHVglQ/yN7WGu0MEfQw+tlgnoYqnxynf0wzo7uOCJFzOz6RxaA9oBVlWrtl9wkRuAXQixUVSHwqxHH4X4/k6TMuj5AJFDO8DhxAZVX2o22zVAm1DI+zvskJ/w4cBzZ0r6w6AK+BYXGle1kaf/Rbb/4oQ3L/jyWoFXAjGQmZtY4bbF0nfWna4K4/Xo+vtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=USTqQwNv7ZycD8gdFTFCYjvm11nPQGyUSREQ8wxf++w=;
 b=de98X+TZxD6KawnqX6jskjL5TlewOSlfaiZhUkOqtJTq23eEfBi5xLmnINGH99AXVxaq+4v02hDmzl9hVfwsGPKersWj+GAyZuTfcEGMZ9ll6onj3PDHtcfHLTSq1li0SEAaqLTSWdstJZMNCYroPTJZSeAZj8E2PThbKZR2jEY=
Received: from BYAPR04MB5431.namprd04.prod.outlook.com (2603:10b6:a03:ce::16)
 by BN0PR04MB7965.namprd04.prod.outlook.com (2603:10b6:408:154::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.39; Mon, 4 Mar
 2024 12:40:19 +0000
Received: from BYAPR04MB5431.namprd04.prod.outlook.com
 ([fe80::eeac:1074:a93:a99d]) by BYAPR04MB5431.namprd04.prod.outlook.com
 ([fe80::eeac:1074:a93:a99d%3]) with mapi id 15.20.7339.035; Mon, 4 Mar 2024
 12:40:18 +0000
From: =?utf-8?B?SsO4cmdlbiBIYW5zZW4=?= <Jorgen.Hansen@wdc.com>
To: "nifan.cxl@gmail.com" <nifan.cxl@gmail.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
 "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
 "gregory.price@memverge.com" <gregory.price@memverge.com>,
 "ira.weiny@intel.com" <ira.weiny@intel.com>, "dan.j.williams@intel.com"
 <dan.j.williams@intel.com>, "a.manzanares@samsung.com"
 <a.manzanares@samsung.com>, "dave@stgolabs.net" <dave@stgolabs.net>,
 "nmtadam.samsung@gmail.com" <nmtadam.samsung@gmail.com>,
 "jim.harris@samsung.com" <jim.harris@samsung.com>, Fan Ni
 <fan.ni@samsung.com>
Subject: Re: [PATCH v4 02/10] hw/cxl/cxl-mailbox-utils: Add dynamic capacity
 region representative and mailbox command support
Thread-Topic: [PATCH v4 02/10] hw/cxl/cxl-mailbox-utils: Add dynamic capacity
 region representative and mailbox command support
Thread-Index: AQHaZPLJNszLQYKukUWnC1H4DaYR/rEnmEeA
Date: Mon, 4 Mar 2024 12:40:18 +0000
Message-ID: <8a141940-86fd-43c8-8834-a25b0d1e79fe@wdc.com>
References: <20240221182020.1086096-1-nifan.cxl@gmail.com>
 <20240221182020.1086096-3-nifan.cxl@gmail.com>
In-Reply-To: <20240221182020.1086096-3-nifan.cxl@gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR04MB5431:EE_|BN0PR04MB7965:EE_
x-ms-office365-filtering-correlation-id: a70f8f55-26c1-4b91-3c76-08dc3c483fbb
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cc4dEM+mQM9OYZVKN4J89i5Iax5RIbSFhhnlTf3F3e8E6PZHHYt9xU7ux6f142X0TARr0145/GxL0raaF9ZTklHGKYfXir7EnBG6YwyyY+Jwvy4aCxMb++mrvhzx6VZdFBmdLQ1oeTVsKLGBZ135PBuuxIS0fbS5DsOraqEAM3++7qpAqugMWjF5oLyINDU/zL1Zx8xPhVqrV8aNQJRSdI7kmCNJlfxca2f4ZHMyNnVHt3YdtjgIJvRYus8+yCQpLIkqtuAz0onj11Pn8RMnFG/s+aqj3bVJshEMzcmfgqa7Fjiw9zJjp8oJs2j9jiY38PvdlEqnpu2GuzCeX/px+9bRq9oaW1bisIHT+1mz7xgG532xlIIhlNP/51AQi0x9Co3GgjpIlx0sE24TQBtAElZ8861+CttZ1dOT/q74LdM/pjgDE4IremCaPOndjMG3xP0l/v0hmjZQwXowrz+UgziD6u48cUMJ1O8CyOrdkXzmXK/YwjFzUgOM3PU7Woy9Mr8SS4GjvjJE5t+PABJrMV9xrahhSw4AmaHSgvKXDGcFED6fjNPeAIryoAnNOf2bpPlJFtioJTL25HS5lCf2RsYqmcQXT5QgPkuani5KgH+3+EXWBbUxEDBlZ368sFu7t/S3mJWxTdu+XdYrgGpDBTFGv8z4MEur56uMg7G7o83sQYogEYb0TCrN5q3gMe5SAbh1Q/jRwIZVELA9ccuzxQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB5431.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?R0RMaXYwU2podDNFdkVGMFRFUnQxcWgrb1RCbnhhc3pCUW11Z3Z3N3lOVnEv?=
 =?utf-8?B?c0FjeXpicGI0MXBWaXhLNFlYWCt6dVgyN205cFdoL0Q4TnJ4TGdSbEY1ODI3?=
 =?utf-8?B?bWhJTGRCNGJ0eXcwR1NORmVCZGR6d29FWDZ1eHVsUVlldjBTMm9iUmVSZEFQ?=
 =?utf-8?B?dlBUanZ0cDE3Z0RPWGJQeW83ekRnZklkdFIxWWE3cUIvTnhDK2ZTc1RlR09z?=
 =?utf-8?B?RXBZK1FHa3pJdHhZT05uSXY4RHhOM3dOWmI0emgrRlpFUHlLc1VpMHdWVWRa?=
 =?utf-8?B?UkZqY2toSXJXTFJKQ096LzF2U1lXa2dsRWtVMEkyVWMzNG1admM3QTBTVlNr?=
 =?utf-8?B?OUxlTnNhQVZiN28xc1RtWHo0d0dNM3JWZExWa2pSWXA5Y29WWnpvMGhNdEQr?=
 =?utf-8?B?WW8rV3RaREsrUUxNQzJvc01ISlZhOSthQTZ5bG9vODM5TVhFVnV5ZjNnSElG?=
 =?utf-8?B?TWlnd0NFMngrSGVNQWRVaGpFS3M0K2p2Tllpb0xyWTRXSnNmbkY4UFUvaHd0?=
 =?utf-8?B?VlkrNzkwVDRXLzBPd2ZNaE1YOGY2dGs4Uk9KUkVMUkl0RjBYSHBveFE1SjBv?=
 =?utf-8?B?SVdndVQ4dzIrV2xUUnBqRDRwWm0zM3dMRnp5Rk5EQndQazZrcEpuNDhYTmFH?=
 =?utf-8?B?aFJBbGtibUtLZExDekZsekt3ZzZhRGErdjF4WFhldXBtQnlUK0hXRHBVR1FS?=
 =?utf-8?B?Ry85Z0t2NGEzNFBrU1JwVk82eTRYV01CSjZocmp1N0VCbWt4Tk9aQmNxcTA4?=
 =?utf-8?B?V1Q3cTVlSGZFd09YUlBOMHNJd0IyQ2pFNCsxUXhScHhPdWkxWmxXWjgvL3lO?=
 =?utf-8?B?Ui9ma3dGR1NLeU9IMllxcm9QdEsvUW14YTFsWjcyNlhyT3RXM2xOcnhZb0Nz?=
 =?utf-8?B?OEZEVEJ1NklYeVdSRnMvc3hGaEhrYVF3VXZpVkZlNHJwd2pVU3hObVpPUHhE?=
 =?utf-8?B?SkZzN3QzNFZBVUErUFJKWllhbDNuZU9Da1A0dkVMRFF3bDVzVlJmMnZ5TmM1?=
 =?utf-8?B?ZjIydDFKUldWZWQ5VkFoUjNEekIrMGJsOE43WTNsRFdsdTRvelhQRkVZdjM0?=
 =?utf-8?B?MEFvRUZHT1FIVG9Bb1JKeHd0SnJnYW56aU8yV1FsQ0VmTUw4ZGdHbyt0Q1Jv?=
 =?utf-8?B?M082eDJ0WkFCdEo0Uk9ic1lDTzVCeGJPZGd6YTd4bHRDUzVXVlpnODdmN0lV?=
 =?utf-8?B?OTZqL2tIb0pET1E2d2dqY0R4clRyWmtBaXFyVXoyQlI1VzZnNzFzSXVZU1FG?=
 =?utf-8?B?OEtJOVdoR1hrbHZZUkZYT1RMSUs2OHM5NnpXSXI5UklKVHZabVQxUWZGR2ha?=
 =?utf-8?B?YzFHUlV6SXZxYnJDRUtScTcxdTR4NW84Z2EydnQzSmJqbjNBQU5MNWw1WFNm?=
 =?utf-8?B?TEJIdllMSmhWU3pGTVNZeDVVRStzcmszZERmcDhRTHpBeWJDTTA3aDI3WUo5?=
 =?utf-8?B?ZzV0N3R3NjFuenA0MFZLaC9WWlM0Q0ZXT0NMbXJOVWp1QjlIa3E2SUVTTi84?=
 =?utf-8?B?SUsxOE1ubzQreUtJU1Z3UFFvQW9pbTJ3K1VZRWlQVEdOKzlCU092eHhkcEhE?=
 =?utf-8?B?dk9DMHA0bEJGUGJWZTliWjVJYWF5cjNkOTFQUDlNcXpXM2VqNE12YmcyaHNY?=
 =?utf-8?B?THRiWGRacThvUDZtQlFCeDQ1UGRORFdaajFRYnNuc3VXWUV6OENBN1J4TUpE?=
 =?utf-8?B?dk1FQ1ZOaEEvSU5iT3BtU2YvWGlNQ2k2dk1RYXY0VENPR3dia1A4bzdLVFZz?=
 =?utf-8?B?SmR1dDlXbEFDUVp1S1ZFVDdlLzEwc2ZHN1JDSTNzL0s3bXc0WXY2Q3pIYUtt?=
 =?utf-8?B?RllSQ09VTy80Y0daTUhMN1lBbTM1bGlheG0zYmo2RTZHRElmTzgyV1ExVHZQ?=
 =?utf-8?B?SXZ5TGxvZDRwck13MEJOZ2RtZ24xUmZIQzFpMThnWERIRWE2K1JUUy9rNlhH?=
 =?utf-8?B?SVcvbzVLZjA2UWxlVlBCVWRwZWpTRi9uTGk3ZXBWd25zU3kyZ1ZIMHNKcjky?=
 =?utf-8?B?MGlrbHJ0Z0ZRdkZYb3FNay9TOUdqd2NtTEROWHkyaWJUZWtHcU1NRnNFcGNn?=
 =?utf-8?B?amljOTBBbHJpaFQ5RkJpTnlGWERtTG1FWmt3dlhUMzJyK1cyYldWQ1N1Rmdl?=
 =?utf-8?Q?pj3ALPtdIATHUgKxW9QScxo/M?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <73AB94607055484B82438CF0E42712EF@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: VKbMDCKlSdAfYK8ykyq0lKuzdUEsbuYqJ9uU7mM6rQuAW4RtydTjPQYvE5Kxr/ArDvt0m1F054PJy385XvJSMRrY1Wjx5ukSL6YZPyao+8nxbZv+NK9hDQsJQKdHKqnIaawyfOR/VQ5E2U1mWdmPKAe7x5t5GxeT8vwoUDgkJkSC9OMrlC6LQpAtoQzBLxHL6IpkQWiIb5k5eGpZSswYQvhMxRkDhwM/Hdt64YqTJruRJeBulsVts7jlESS0TQaTUQu4g8TlYvT8adhjB5se/NJzi1SIQA1NYJ7gKMN1XHMsyTR1qKQS6/jcsY/+nYgvMBZOKPX81VsctbsVhbXgWijHnnW9EFN/m4vKCkURlUHCMB5gOXGwZnMvJUsR48Nkioz+HMqpXtpDcPjmigFG/H/3Ha+BHRw9g6jnm7bGYwVt6nQ8EvMgynJZM+OFJt/4aLWB/BWbZ2mEA2TmCvLdx3w4VsHd8a8ZYUTJc8vZWSDF+gafoaRbrH0XLNVDsXtCmDyRLRnNNW/dGtst4BHEcxfCwVWrU3glZLUaPfBLCvb5zjkiTn1Iwyhx6YzVlhkXn0lC9mzHu9xrGUXksEL1blJi51Ax1XU6PIkJC2KQ2Axq14FCxemG8IJjyQ0MPcrm
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB5431.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a70f8f55-26c1-4b91-3c76-08dc3c483fbb
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Mar 2024 12:40:18.3734 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DUseNkYP9QYgsvTAhgWXbH4nUpt2xMxjeq4pFaR96q0l6LpK8Av3k+IIFy8UrBrI01R3rnjmpsOLLaJ0tvPx0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR04MB7965
Received-SPF: pass client-ip=216.71.154.45;
 envelope-from=prvs=786567a07=Jorgen.Hansen@wdc.com; helo=esa6.hgst.iphmx.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

T24gMi8yMS8yNCAxOToxNSwgbmlmYW4uY3hsQGdtYWlsLmNvbSB3cm90ZToNCj4gQ0FVVElPTjog
VGhpcyBlbWFpbCBvcmlnaW5hdGVkIGZyb20gb3V0c2lkZSBvZiBXZXN0ZXJuIERpZ2l0YWwuIERv
IG5vdCBjbGljayBvbiBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3UgcmVjb2du
aXplIHRoZSBzZW5kZXIgYW5kIGtub3cgdGhhdCB0aGUgY29udGVudCBpcyBzYWZlLg0KPiANCj4g
DQo+IEZyb206IEZhbiBOaSA8ZmFuLm5pQHNhbXN1bmcuY29tPg0KPiANCj4gUGVyIGN4bCBzcGVj
IHIzLjEsIGFkZCBkeW5hbWljIGNhcGFjaXR5IHJlZ2lvbiByZXByZXNlbnRhdGl2ZSBiYXNlZCBv
bg0KPiBUYWJsZSA4LTE2NSBhbmQgZXh0ZW5kIHRoZSBjeGwgdHlwZTMgZGV2aWNlIGRlZmluaXRp
b24gdG8gaW5jbHVkZSBkYyByZWdpb24NCj4gaW5mb3JtYXRpb24uIEFsc28sIGJhc2VkIG9uIGlu
Zm8gaW4gOC4yLjkuOS45LjEsIGFkZCAnR2V0IER5bmFtaWMgQ2FwYWNpdHkNCj4gQ29uZmlndXJh
dGlvbicgbWFpbGJveCBzdXBwb3J0Lg0KPiANCj4gTm90ZTogZGVjb2RlX2xlbiBvZiBhIGRjIHJl
Z2lvbiBpcyBhbGlnbmVkIHRvIDI1NipNaUIsIGRpdmlkZWQgYnkNCj4gMjU2ICogTWlCIGJlZm9y
ZSByZXR1cm5lZCB0byB0aGUgaG9zdCBmb3IgIkdldCBEeW5hbWljIENhcGFjaXR5IENvbmZpZ3Vy
YXRpb24iDQo+IG1haWxib3ggY29tbWFuZC4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEZhbiBOaSA8
ZmFuLm5pQHNhbXN1bmcuY29tPg0KPiAtLS0NCj4gICBody9jeGwvY3hsLW1haWxib3gtdXRpbHMu
YyAgfCAxMTAgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrDQo+ICAgaW5jbHVk
ZS9ody9jeGwvY3hsX2RldmljZS5oIHwgIDE2ICsrKysrKw0KPiAgIDIgZmlsZXMgY2hhbmdlZCwg
MTI2IGluc2VydGlvbnMoKykNCj4gDQoNCltzbmlwXQ0KDQo+IA0KPiAgICAgICAvKiBObyBzZXBh
cmF0aW9uIGZvciBQQ0kgTUIgYXMgcHJvdG9jb2wgaGFuZGxlZCBpbiBQQ0kgZGV2aWNlICovDQo+
IGRpZmYgLS1naXQgYS9pbmNsdWRlL2h3L2N4bC9jeGxfZGV2aWNlLmggYi9pbmNsdWRlL2h3L2N4
bC9jeGxfZGV2aWNlLmgNCj4gaW5kZXggM2NmMzA3N2FmYS4uNmRmN2ZlY2RmMSAxMDA2NDQNCj4g
LS0tIGEvaW5jbHVkZS9ody9jeGwvY3hsX2RldmljZS5oDQo+ICsrKyBiL2luY2x1ZGUvaHcvY3hs
L2N4bF9kZXZpY2UuaA0KPiBAQCAtNDIyLDYgKzQyMiwxNyBAQCB0eXBlZGVmIHN0cnVjdCBDWExQ
b2lzb24gew0KPiAgIHR5cGVkZWYgUUxJU1RfSEVBRCgsIENYTFBvaXNvbikgQ1hMUG9pc29uTGlz
dDsNCj4gICAjZGVmaW5lIENYTF9QT0lTT05fTElTVF9MSU1JVCAyNTYNCj4gDQo+ICsjZGVmaW5l
IERDRF9NQVhfUkVHSU9OX05VTSA4DQo+ICsNCj4gK3R5cGVkZWYgc3RydWN0IENYTERDRFJlZ2lv
biB7DQo+ICsgICAgdWludDY0X3QgYmFzZTsNCj4gKyAgICB1aW50NjRfdCBkZWNvZGVfbGVuOyAv
KiBhbGlnbmVkIHRvIDI1NipNaUIgKi8NCj4gKyAgICB1aW50NjRfdCBsZW47DQo+ICsgICAgdWlu
dDY0X3QgYmxvY2tfc2l6ZTsNCj4gKyAgICB1aW50MzJfdCBkc21hZGhhbmRsZTsNCj4gKyAgICB1
aW50OF90IGZsYWdzOw0KPiArfSBDWExEQ0RSZWdpb247DQo+ICsNCg0KVG8gYmUgY29uc2lzdGVu
dCB3aXRoIHRoZSBuYW1pbmcgb2YgZXh0ZW50cywgYW5kIGZ1bmN0aW9ucyBkZWZpbmVkIGxhdGVy
IA0Kb24sIHNob3VsZG4ndCB0aGlzIGJlIENYTERDUmVnaW9uIChEQyBpbnN0ZWFkIG9mIERDRCk/
DQoNCj4gICBzdHJ1Y3QgQ1hMVHlwZTNEZXYgew0KPiAgICAgICAvKiBQcml2YXRlICovDQo+ICAg
ICAgIFBDSURldmljZSBwYXJlbnRfb2JqOw0KPiBAQCAtNDU0LDYgKzQ2NSwxMSBAQCBzdHJ1Y3Qg
Q1hMVHlwZTNEZXYgew0KPiAgICAgICB1bnNpZ25lZCBpbnQgcG9pc29uX2xpc3RfY250Ow0KPiAg
ICAgICBib29sIHBvaXNvbl9saXN0X292ZXJmbG93ZWQ7DQo+ICAgICAgIHVpbnQ2NF90IHBvaXNv
bl9saXN0X292ZXJmbG93X3RzOw0KPiArDQo+ICsgICAgc3RydWN0IGR5bmFtaWNfY2FwYWNpdHkg
ew0KPiArICAgICAgICB1aW50OF90IG51bV9yZWdpb25zOyAvKiAwLTggcmVnaW9ucyAqLw0KPiAr
ICAgICAgICBDWExEQ0RSZWdpb24gcmVnaW9uc1tEQ0RfTUFYX1JFR0lPTl9OVU1dOw0KPiArICAg
IH0gZGM7DQo+ICAgfTsNCj4gDQo+ICAgI2RlZmluZSBUWVBFX0NYTF9UWVBFMyAiY3hsLXR5cGUz
Ig0KPiAtLQ0KPiAyLjQzLjANCj4gDQo+IA0KDQpUaGFua3MsDQpKb3JnZW4=

