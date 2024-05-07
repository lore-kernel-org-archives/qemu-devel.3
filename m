Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B77D9C25B10
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2024 00:23:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s48bC-0000nl-K9; Mon, 06 May 2024 20:22:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yaoxt.fnst@fujitsu.com>)
 id 1s48b4-0000nF-SO
 for qemu-devel@nongnu.org; Mon, 06 May 2024 20:22:18 -0400
Received: from esa17.fujitsucc.c3s2.iphmx.com ([216.71.158.34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yaoxt.fnst@fujitsu.com>)
 id 1s48ax-0005RM-0H
 for qemu-devel@nongnu.org; Mon, 06 May 2024 20:22:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1715041331; x=1746577331;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=24QLhws4cHC8qelWJsvcwh3/gvcMHl66+soi+Z9m0Lc=;
 b=QVNKR68IerCnWp3CLhb5rYZ5GQhZbOhV9EJKNSD8QT4RanWK4KngrGfc
 XXJgXJpukCPjcHFgEq6BSPP2ZI89TXOt3yAwVz6BJtDcroWtQN6fT48dV
 BzpKyiXP1Eo22eJgrz6xavRfhdxnrkgYmeomVeHs5IlFjJ2yvHI577SNt
 zuD92efQfUf8dceOJCt7Qn/zyP+F+EP7YTg16Nf2O0qPm1YMgq5tnbTRU
 nsyNvGfGnbFq/akBxMrIt98pnXrxaGccNC/FOk1A/LUMxjQW59j7h2ynY
 QrMsykqbwhjwAOIjH1Kc9BGP/mUedL1yPkZYWeScPTrPT5yFAGqPS7ndN Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11065"; a="118525291"
X-IronPort-AV: E=Sophos;i="6.07,259,1708354800"; d="scan'208";a="118525291"
Received: from mail-os0jpn01lp2104.outbound.protection.outlook.com (HELO
 JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.104])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 May 2024 09:22:03 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fjcTc3RrmET+fltnSbT7I+ULe9uqZaUdgqlOj8osMm17oAtwslyg5UDArlQfdbmbzh0Uh25e+g8c/yBjJXapBah0+p9pvpBZFfEiYDAv3y9JZ7VShjIAh0Iqp7bcz0933bwrvP3ShTDvtXBLuWmOGI5zrQM5I2x/R1enW4I2SICaZ8R/uk5Plc4xDrFn/BKM+I9madLx8RhCW+kHZybs4PKQ2IvRvMMeeyqnfV5CFolz5r9dgCmI3Ap8SAQRlcSjDQuoTG5p7M+tsYA9bcsostOMVlUkSfjg8AeXUzgLyAvrxH0ywKG5sKw9nDO0y3A5It9rfC/y1+T7HMyfBIwHow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PO1Mu+WKsw0ounfpBGZ5uPuHuxfhtjabSkgMmb5vn9s=;
 b=DLCk6YQEHx53jl9sAe5pIIJ9bjhI3pfhOuCxzvP53Q5FYeMsmYPMxSPqhL4LrpWJnckyk07mXuNL74hLOZgLCmm3bpMcXtd9fx0k8krWpBLv0uM+hC0L6oOEO4bzaqIVaDAaMhWa60HexM7s2CmwiDeUTsrs3oaAoQdeRB2pt1AQyZ8gX6BPHyQV0rtsmA0AxtjscbQRuZG1VCL1P0ERZLaZC+ghIYsl4uqsg4XBWr7trBR4PfF3daobyxVoAMWRTJQV3jdKitv30Yv007MI+bcnlawKVu/zWnHfXMp//IVg6YMJ09yq9sppo49Iv1ygtwEk0naFoCOgvw91UDMkjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OSZPR01MB6453.jpnprd01.prod.outlook.com (2603:1096:604:ed::14)
 by OS3PR01MB6405.jpnprd01.prod.outlook.com (2603:1096:604:103::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.42; Tue, 7 May
 2024 00:22:00 +0000
Received: from OSZPR01MB6453.jpnprd01.prod.outlook.com
 ([fe80::3a1c:a3fe:854f:2e1d]) by OSZPR01MB6453.jpnprd01.prod.outlook.com
 ([fe80::3a1c:a3fe:854f:2e1d%6]) with mapi id 15.20.7544.041; Tue, 7 May 2024
 00:22:00 +0000
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
CC: "fan.ni@samsung.com" <fan.ni@samsung.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
Subject: RE: [PATCH v2] mem/cxl_type3: support 3, 6, 12 and 16 interleave ways
Thread-Topic: [PATCH v2] mem/cxl_type3: support 3, 6, 12 and 16 interleave ways
Thread-Index: AQHaiJjASti3D6SWj0SM7FILST9OMrF2vnZAgApJxoCACgzPsA==
Date: Tue, 7 May 2024 00:22:00 +0000
Message-ID: <OSZPR01MB64537247C2BEC1980937EC198DE42@OSZPR01MB6453.jpnprd01.prod.outlook.com>
References: <20240407030642.24861-1-yaoxt.fnst@fujitsu.com>
 <OSZPR01MB6453EAAAA6C5CDCF87422A588D102@OSZPR01MB6453.jpnprd01.prod.outlook.com>
 <20240430154307.00002879@huawei.com>
In-Reply-To: <20240430154307.00002879@huawei.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_ActionId=4bdd554a-f874-4930-a06c-4947149a53d4;
 MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_ContentBits=0;
 MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Enabled=true;
 MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Method=Privileged;
 MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Name=FUJITSU-PUBLIC?;
 MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_SetDate=2024-05-07T00:11:39Z;
 MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_SiteId=a19f121d-81e1-4858-a9d8-736e267fd4c7;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSZPR01MB6453:EE_|OS3PR01MB6405:EE_
x-ms-office365-filtering-correlation-id: 20f302ef-2d8f-43f9-487d-08dc6e2bb691
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230031|366007|376005|1800799015|1580799018|38070700009; 
x-microsoft-antispam-message-info: =?iso-2022-jp?B?VEJ5RGRmb1lhVERIY3lkcFlPZmZ6NFlGQ0V3K3VSSm93QmtDQzhaelQ5?=
 =?iso-2022-jp?B?OTFEZ3BmZlNDV1dYODdUcE5nQnc5U2lUeWc2bElwcHpqUWgzbGd5aDRB?=
 =?iso-2022-jp?B?TmdDeUo0dzlkMExJUTFRWXl1dUprWDlEK29Bczk1TGNteDdYclZzdlRq?=
 =?iso-2022-jp?B?Mms4blFXMHIrWXMvWVdZQ2kreXJyeUNjQlJacmJOTnZKYnpQYVlnUFpO?=
 =?iso-2022-jp?B?ZTVnTXE0SlcvSkRtZlovV09CUjFKOE0vdWN1L3hNbitBVDJ2eDg3Y0xC?=
 =?iso-2022-jp?B?SlN5UFFmckZmRXpzSi9yQkF2WGx0VzFNdE9tSmtuNTZTUlp3ak9UUlpG?=
 =?iso-2022-jp?B?SXUxZFFEeEZRdEdsVFdXMTI3WnBKTEplWUYzU2N6U3g0WjRGS216RGtH?=
 =?iso-2022-jp?B?RVc5ZGxpRFFHbUo0VjBVb0dOMHBZOEJvNytQcDRlZmhHZ2V1Z0FWT1BJ?=
 =?iso-2022-jp?B?VXRQZ1doME9NanF6WS9jVzJXMXE0TXl3ZGZpWXhWL0hjOXFnb1lVMHRj?=
 =?iso-2022-jp?B?bkVrWjV3ZE9YQ2NmWWxGOWJkbUhlazZ1TzJrWTlTYnhjQzhVdDVkRHFS?=
 =?iso-2022-jp?B?b1dUTFB6eC85VkpQMWRkWUVQSldWNmpRSkx6WVRidEVxMFNMbEpnS0Rh?=
 =?iso-2022-jp?B?MWNqWCtHUDY3QXF2czkzYkkwTkY5U3p3bGovc0dhczBGZnJzVUdMR2xE?=
 =?iso-2022-jp?B?SUZUMnNwUUd5b0owRHYycUQwb0JVVTYyd0V1WnQ3ZUFqYmNXeUNHaTJ5?=
 =?iso-2022-jp?B?UHc4SDViMDM2ZnZ5UGZEOVdJQXpyV0dLNlhQcHpzRjVaa2tKOFU3ajdE?=
 =?iso-2022-jp?B?WU4rOWRyRUVDSVNyYWdtaTNGUGdRTVB4MGNCS0lvR2MxQXRUeDNidEww?=
 =?iso-2022-jp?B?bXFpdFYyK0c3eVJRS2ZoTXp3VWwxRS9RTnVBN21tenFSSlN4cHFjSkEz?=
 =?iso-2022-jp?B?Z3Axa2lmYStjbzliaUUrODNHQ2Q4dHNHbXlKTTd0RWZNUC9lSmRKWExu?=
 =?iso-2022-jp?B?SUN6YmVCODVhVlZiRWRYOUdoaU1VdDVZanQ1SmNQQThlZVFaVHJUZHV5?=
 =?iso-2022-jp?B?SkNNdE5GK1JPU2M2Z2ZIY3lZOGdteDVZRUJtNEN2WkgvL1lnSkRTME8r?=
 =?iso-2022-jp?B?eTlnVDRlaSs0TjA1ZjFMblNyamkzN1ZmL3Q4aU0veWJGaTYwNW1TUTQw?=
 =?iso-2022-jp?B?aCtrREkyWHJrUVlSVWM5NmNMQjRYOUNFQ0d2LzFBaWlLdzJSZkhqUE0w?=
 =?iso-2022-jp?B?VnN4bGhiMUk1bEsyTHhEOC9oaWwxRHpIeHlTaVBRZHBsUDdHRHVmVE9u?=
 =?iso-2022-jp?B?SWlzYXV4aFk2NWhNSkVaNUdYWFdCZXpSa0QyNXJoYmZBQVBzZnRaZjdF?=
 =?iso-2022-jp?B?ekNTTkhvSzdTL0dqaWc2NkN4Qi9aRVlGZ1VrbCtzR2QzRHdPUm5raG80?=
 =?iso-2022-jp?B?RGZnU0lGaUJzR084NHlyV0VLZWFHL0F4S2k0bVZFc1VtMlYyTTRwK2dH?=
 =?iso-2022-jp?B?WjBJMGhtenRoNHhZRjI2MDQzZEZHcFBtc2xJck5YZEJNL2FwUzdKSWR6?=
 =?iso-2022-jp?B?bXl0dXdxNUI2MHpnUHpmR2lHanErcTRpYmZoZ29ocG9nRmN4bjRoTk9x?=
 =?iso-2022-jp?B?dGRkdEhWWHM2NVFkYk5DQzNRT1pFczRoRW56R2VuY2ZZSk5lZTBFTy9j?=
 =?iso-2022-jp?B?YkhxRGNpMkZMQWFsQ2lvNU9TYnl4dml4VHlvWWsvdStvb1ZXL1VTbHpQ?=
 =?iso-2022-jp?B?RWN3UzgyTmJsd1FYTDB4MjNWNnU0TGtGY2daWWFvbHlwQlk3NGJEUkdO?=
 =?iso-2022-jp?B?NnEzTUdpQ1BnandNVVptMzJhVk1yVmVWZFp2cGZ2VDh2ZmQvcm41WGxF?=
 =?iso-2022-jp?B?R1psZ2swcSsyc0drODF0R1NkNWNFczZmMTF0YVZzVDEvT0t4aS9QSW1E?=
 =?iso-2022-jp?B?MCswN2tRb1BpYVh6dTBSMXcwNmptQ3p6dVRyOEdpY3JXUUYraXhNOXRT?=
 =?iso-2022-jp?B?bz0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-cn; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:OSZPR01MB6453.jpnprd01.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230031)(366007)(376005)(1800799015)(1580799018)(38070700009);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?SjFFb0xnN2EyWjdEbFk1WXdjdDFwU1VockZnNDcxN25ZRndoNnVJK0FV?=
 =?iso-2022-jp?B?dk9zTXFFMmhUOW9VZys2ZTlyRkFjK29wSWlOWm94dkhwVnFPcjEyWm9X?=
 =?iso-2022-jp?B?cW9DUUU5OEc1NWhuWkNDeEgzU3kzNlhxUmVaM1VpeVdQMTNqRkdNVzZz?=
 =?iso-2022-jp?B?RUFwaE5wSkZ0OGFPMTNaalZETzFRZzlKNXpHZHlyK2JZdWN3empCMVNO?=
 =?iso-2022-jp?B?SWFocHVtWUZLb2d3b2V3UVlRc2l6QW1IQ093bXVlbmtaYk1XTW02MFNF?=
 =?iso-2022-jp?B?RDFnM3ZWa3BTMUpEOTI4R1hsamo5ZFl6TFhka2h5OXFxdjNmWG5uVUkz?=
 =?iso-2022-jp?B?eTdPRnJPRWNwblNZNnF5U044U2cvaUo2UHlqcW9YS1pOdjd2MWF3QVBk?=
 =?iso-2022-jp?B?eDhEYzJiSEtXL2d5ZE5NUTk1VWNudjJ1eVZmK0FGL0hTVytYMm1tb3lS?=
 =?iso-2022-jp?B?QjRycUtvTFYwNXdDcm9COUN1OHFyTTNFejRCZmhFOUljYmNBSUFURzcy?=
 =?iso-2022-jp?B?V0hZSXJhbno5allsQzRoN2VmRDRvbWtmMklzSG1NQVFDYVVSdnN6c0dz?=
 =?iso-2022-jp?B?UnpqRlBFc0c5d1ZYb3daWVN5VVpqcUYvUDhzcldMK1Avb2ZwMlU0MnE3?=
 =?iso-2022-jp?B?QW9qRVQ1eDZZZTFZdVkreVcrck5Xa0pNUDcvS2lBckZpRW02Z2l4RzJG?=
 =?iso-2022-jp?B?aVpWRWxlcFRFU2RKQnNNSFB5VldGNDVETWtlOURnZjhJZm9wMTdQa3VN?=
 =?iso-2022-jp?B?Z3BCU1VkaHUyREhzVlFGUUFzUzZ2dnBwZkR1LzZ5bjBGeENYSi9YZUND?=
 =?iso-2022-jp?B?VXQzaFhnS3dKWVcrc2JvWTFrdERTNVFHNm5XUHJvaEFlSTVFalRhZVlv?=
 =?iso-2022-jp?B?Q0Q5WHBFRk5hUExjR0xTdWdHcEVhZ2pRNmJiUm42RUluZnFncldXWGw0?=
 =?iso-2022-jp?B?QXluUE9sVGFwMU9EUjE3Sm9yNDhNWXlXRzhodjJwZXovQVo4MTZIZFFX?=
 =?iso-2022-jp?B?ZExETmtFSXU3RXlydzFmUENxZW1DclMyTk53SU52ZVFXNWY1VlBVYmxu?=
 =?iso-2022-jp?B?dFdNVTBqQmh1R094WGQyMm5xVnlFNktpcytWNUxMOW1LYjdRZnVlNVVJ?=
 =?iso-2022-jp?B?REl2eTk0aDUvTG12TTJOS2QyeGFGcUg5blJjd05GZnViQVdodjh3Z2xM?=
 =?iso-2022-jp?B?b210ZVhjb0lVNG9lajhCR0lJUXFuSEREMG9nWHVGd2JtWTNGS3VWS0VO?=
 =?iso-2022-jp?B?bzZzS2Y4MDVYbTE4VkJ1elZZV3ZqM2dWclFDNXJrSEZHaXY0K09ILzJN?=
 =?iso-2022-jp?B?T2FxVlB2U2t3R1pYWERxR1R0dzJjNUNpbldRa2N3Q1Rzb291em52TjRQ?=
 =?iso-2022-jp?B?Q1VzaG42UTZSVllOcm93MFcrbXprV1FhamZVdnlYVjkyaWI0c0p1QW82?=
 =?iso-2022-jp?B?dTRyZUxwbEhIWGJqN1IwRndBSXpocTJHNDFqdERNMjhZNmpFN0xtMkI5?=
 =?iso-2022-jp?B?bWwveEVsSHVBWGJMNk1NWTJxdDhkNk0zODdKN2czUDFyUnJFK0JBZWFx?=
 =?iso-2022-jp?B?NlNaNVdSdjBMNmFWZWlsaVRvTExSa1FEM0RLazhmd3hxSjZJM1g0Y09s?=
 =?iso-2022-jp?B?bi8zbFBXMitPb1hhWjczSElmS3BGZEV6SFJUZzlSUTBWR2tXWDhnU2hF?=
 =?iso-2022-jp?B?dVp1bnpZa0lVbXg3MnhXQ25Qd0lWc3JyMXE5Q3RwWitQMnBrSUxUcFVp?=
 =?iso-2022-jp?B?RncvL3pqRmhmQ3lIUjJhMnc0eUFQbWlJc1cwWndnV3ZCNHNQKzNVejJM?=
 =?iso-2022-jp?B?OEVNTThtQmtROXlRbHpkRW9lMHRPYWhtaUFnMEJ6Zjc3N3BybmJGTFAx?=
 =?iso-2022-jp?B?M1RpbGo4bXorbU9PY0JzQ3kwV3lIcCtaNmhYT3crRUhZaXNKcFhVMUE1?=
 =?iso-2022-jp?B?U2dtQTVHV243K2JrV3QwT2VqY1JBM3ZrclFWNW1PK2FDVUduS05vVnVx?=
 =?iso-2022-jp?B?ZDFTeWV0NUNIZy9xV0RBckJualRXbzFaKzRNR01vQzA4WVNQMW1zTndq?=
 =?iso-2022-jp?B?bG5qWjQzTHU5WWFZMW1JeVAxdjNMbjFML1ZVbzkzU09Na2ljSElLbWx3?=
 =?iso-2022-jp?B?QjB2UjdXTmIyL1AvZXBlVklEWmszOENTdlRlbzlsTy9RTStrU29aWFhC?=
 =?iso-2022-jp?B?dGZiZlFrTFlmdkp2bnhZcDJKZVdNaUphY2xTdCtyZm1pZ29QRVUvbldN?=
 =?iso-2022-jp?B?OTQ2Y1FZQmhZQStrZ3pTbU9GVnNVd054Q2I1eDRwdG5wbCszMTVvZ3kw?=
 =?iso-2022-jp?B?a3pyZw==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 3dsmyWg3GNT/UeNm7iuPtjLT5QcU7P+sCBBHkT6nF++Ixu/PPPbS+V7GWyLL3Po+FuvEl0M7TfLExg4GzIo1hz85JZaQfc08aR8c4w9M5CawI9cA0z8QgWyim8A9/25Twh9dZtxeK69W6ah0bpwsP18ghmzipj32oF8YAPg5cnl6QsX6O5hAha6uUsl4rkE0zACaI59+UiY88XBIgP453yhwxl5fs0VQUuT/cljdJGy9piUMmBGxYbOFJ0/hszw3jPT456hyK77o8GtyzqyiRkiUn0ooI4psxigrTycno30BixIR1Lr2EVMkIRaF6S7f9UGu8fJBCoTiBccqMV7yX66T0mqHynRF2qe4JjznC29EqqJl3CGTmozQBb3qxchXrqqfruYHKpxcqP4PUKjaXbJ80GWndEc6kA0WEQO4XcX/tcEs9ENZjUV6WwgF25MVXmVcG3MXCJdp21vsFcy2jeXffnbwwav9SVW7qyhl1km+2YZDVL26k4OU7Ss7Io7cAMl+jM9c/XXiLX0SH0VJ0VilUdnX75uULRJWSUVVj9wqWE2QtFFj9xY5I6dDSuK4VgpTRZxfTIsteHL6lmcGM7x79MCVT+LGmbM2zp/MHR3pC5dXkm+Kz9xyRsV43Aut
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB6453.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20f302ef-2d8f-43f9-487d-08dc6e2bb691
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 May 2024 00:22:00.4921 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DmyCgYOrf1nQkIv7jlkPCZe59KyD3m0aEdGQbRPgq8tbGw9Dgogf3he+whAq4NLnOWcORL4s7RXFIk9adtMibA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB6405
Received-SPF: pass client-ip=216.71.158.34;
 envelope-from=yaoxt.fnst@fujitsu.com; helo=esa17.fujitsucc.c3s2.iphmx.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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
Reply-to:  "Xingtao Yao (Fujitsu)" <yaoxt.fnst@fujitsu.com>
From:  "Xingtao Yao (Fujitsu)" via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



> -----Original Message-----
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Sent: Tuesday, April 30, 2024 10:43 PM
> To: Yao, Xingtao/=1B$BU-=1B(B =1B$B9,Es=1B(B <yaoxt.fnst@fujitsu.com>
> Cc: fan.ni@samsung.com; qemu-devel@nongnu.org
> Subject: Re: [PATCH v2] mem/cxl_type3: support 3, 6, 12 and 16 interleave=
 ways
>=20
> On Wed, 24 Apr 2024 01:36:56 +0000
> "Xingtao Yao (Fujitsu)" <yaoxt.fnst@fujitsu.com> wrote:
>=20
> > ping.
> >
> > > -----Original Message-----
> > > From: Yao Xingtao <yaoxt.fnst@fujitsu.com>
> > > Sent: Sunday, April 7, 2024 11:07 AM
> > > To: jonathan.cameron@huawei.com; fan.ni@samsung.com
> > > Cc: qemu-devel@nongnu.org; Yao, Xingtao/=1B$BU-=1B(B =1B$B9,Es=1B(B
> <yaoxt.fnst@fujitsu.com>
> > > Subject: [PATCH v2] mem/cxl_type3: support 3, 6, 12 and 16 interleave=
 ways
> > >
> > > Since the kernel does not check the interleave capability, a
> > > 3-way, 6-way, 12-way or 16-way region can be create normally.
> > >
> > > Applications can access the memory of 16-way region normally because
> > > qemu can convert hpa to dpa correctly for the power of 2 interleave
> > > ways, after kernel implementing the check, this kind of region will
> > > not be created any more.
> > >
> > > For non power of 2 interleave ways, applications could not access the
> > > memory normally and may occur some unexpected behaviors, such as
> > > segmentation fault.
> > >
> > > So implements this feature is needed.
> > >
> > > Link:
> > >
> https://lore.kernel.org/linux-cxl/3e84b919-7631-d1db-3e1d-33000f3f3868@fu=
jits
> > > u.com/
> > > Signed-off-by: Yao Xingtao <yaoxt.fnst@fujitsu.com>
> > > ---
> > >  hw/mem/cxl_type3.c | 18 ++++++++++++++----
> > >  1 file changed, 14 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
> > > index b0a7e9f11b..d6ef784e96 100644
> > > --- a/hw/mem/cxl_type3.c
> > > +++ b/hw/mem/cxl_type3.c
> > > @@ -805,10 +805,17 @@ static bool cxl_type3_dpa(CXLType3Dev *ct3d,
> hwaddr
> > > host_addr, uint64_t *dpa)
> > >              continue;
> > >          }
> > >
> > > -        *dpa =3D dpa_base +
> > > -            ((MAKE_64BIT_MASK(0, 8 + ig) & hpa_offset) |
> > > -             ((MAKE_64BIT_MASK(8 + ig + iw, 64 - 8 - ig - iw) & hpa_=
offset)
> > > -              >> iw));
> > > +        if (iw < 8) {
> > > +            *dpa =3D dpa_base +
> > > +                ((MAKE_64BIT_MASK(0, 8 + ig) & hpa_offset) |
> > > +                 ((MAKE_64BIT_MASK(8 + ig + iw, 64 - 8 - ig - iw) &
> hpa_offset)
> > > +                  >> iw));
> > > +        } else {
> > > +            *dpa =3D dpa_base +
> > > +                ((MAKE_64BIT_MASK(0, 8 + ig) & hpa_offset) |
> > > +                 ((((MAKE_64BIT_MASK(ig + iw, 64 - ig - iw) & hpa_of=
fset)
> > > +                   >> (ig + iw)) / 3) << (ig + 8)));
> > > +        }
> > >
> > >          return true;
> > >      }
> > > @@ -906,6 +913,9 @@ static void ct3d_reset(DeviceState *dev)
> > >      uint32_t *write_msk =3D
> ct3d->cxl_cstate.crb.cache_mem_regs_write_mask;
> > >
> > >      cxl_component_register_init_common(reg_state, write_msk,
> > > CXL2_TYPE3_DEVICE);
> > > +    ARRAY_FIELD_DP32(reg_state, CXL_HDM_DECODER_CAPABILITY,
> > > 3_6_12_WAY, 1);
> > > +    ARRAY_FIELD_DP32(reg_state, CXL_HDM_DECODER_CAPABILITY,
> > > 16_WAY, 1);
> > > +
>=20
> Why here rather than in hdm_reg_init_common()?
> It's constant data and is currently being set to 0 in there.

according to the CXL specifications (8.2.4.20.1 CXL HDM Decoder Capability =
Register (Offset 00h)),
this feature is only applicable to cxl.mem, upstream switch port and CXL ho=
st bridges shall hardwrite
these bits to 0.

so I think it would be more appropriate to set these bits here.

>=20
> > >      cxl_device_register_init_t3(ct3d);
> > >
> > >      /*
> > > --
> > > 2.37.3
> >


