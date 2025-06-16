Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9E53C71136
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Jun 2025 20:58:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uRGtK-0005Wr-1G; Mon, 16 Jun 2025 16:57:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bchaney@akamai.com>)
 id 1uRGt6-0005Vv-9G; Mon, 16 Jun 2025 16:57:05 -0400
Received: from mx0b-00190b01.pphosted.com ([2620:100:9005:57f::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bchaney@akamai.com>)
 id 1uRGt2-0002Jd-Su; Mon, 16 Jun 2025 16:57:03 -0400
Received: from pps.filterd (m0122331.ppops.net [127.0.0.1])
 by mx0b-00190b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55GHZSXP009497;
 Mon, 16 Jun 2025 21:56:55 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=cc
 :content-id:content-transfer-encoding:content-type:date:from
 :message-id:mime-version:subject:to; s=jan2016.eng; bh=Kj1TlDCv6
 j0l7Jzr+ebEXM9kZzJ56F2P+cnc/u06pWo=; b=TyCm/QneWFglDtTVgkVRyo0DG
 acXbsOtF4eZkaDKb/9UY0pdQlbOh8LP1jQNep15z2cEri89CZUNFgeRgcMh4hCtv
 d9PD50Gl+RLtL1H518XVE3XDtEdS/NbrdcRZigTGP0XF85Q+4n6Go0qsIe0YTk8H
 SDBcOY8P99+0n3E7On01qtYiLqDJ3QJAJD4PV4AuM3WircT2+348jMJx1sUsQVb2
 Y+AxCTAXD/WssgCOI+dCMcTwpO0X4modvUk682NXMn32Jqdf/kBJWoO0/kti9opq
 g2dXJsBJ5noBNPFS4lwdGVGw6dKrHHe8mBKwvK84g260leNc4KUth+LEH2M2Q==
Received: from prod-mail-ppoint7
 (a72-247-45-33.deploy.static.akamaitechnologies.com [72.247.45.33] (may be
 forged))
 by mx0b-00190b01.pphosted.com (PPS) with ESMTPS id 4791jvnxaj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 16 Jun 2025 21:56:55 +0100 (BST)
Received: from pps.filterd (prod-mail-ppoint7.akamai.com [127.0.0.1])
 by prod-mail-ppoint7.akamai.com (8.18.1.2/8.18.1.2) with ESMTP id
 55GKt3xk025651; Mon, 16 Jun 2025 16:56:54 -0400
Received: from email.msg.corp.akamai.com ([172.27.50.204])
 by prod-mail-ppoint7.akamai.com (PPS) with ESMTPS id 4794dx4acd-2
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 16 Jun 2025 16:56:54 -0400
Received: from ustx2ex-exedge4.msg.corp.akamai.com (172.27.50.215) by
 ustx2ex-dag4mb5.msg.corp.akamai.com (172.27.50.204) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Mon, 16 Jun 2025 13:56:53 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (72.247.45.132)
 by ustx2ex-exedge4.msg.corp.akamai.com (172.27.50.215) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10 via Frontend Transport; Mon, 16 Jun 2025 13:56:53 -0700
Received: from SA0PR17MB4299.namprd17.prod.outlook.com (2603:10b6:806:e2::12)
 by MW4PR17MB5950.namprd17.prod.outlook.com (2603:10b6:303:1b6::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Mon, 16 Jun
 2025 20:56:50 +0000
Received: from SA0PR17MB4299.namprd17.prod.outlook.com
 ([fe80::2d2f:3703:1db2:1d95]) by SA0PR17MB4299.namprd17.prod.outlook.com
 ([fe80::2d2f:3703:1db2:1d95%7]) with mapi id 15.20.8835.027; Mon, 16 Jun 2025
 20:56:50 +0000
From: "Chaney, Ben" <bchaney@akamai.com>
To: Peter Xu <peterx@redhat.com>
CC: David Hildenbrand <david@redhat.com>, "Michael S. Tsirkin"
 <mst@redhat.com>, "yury-kotov@yandex-team.ru" <yury-kotov@yandex-team.ru>,
 "dgilbert@redhat.com" <dgilbert@redhat.com>, "beata.michalska@linaro.org"
 <beata.michalska@linaro.org>, "richard.henderson@linaro.org"
 <richard.henderson@linaro.org>, "alex.bennee@linaro.org"
 <alex.bennee@linaro.org>, "peter.maydell@linaro.org"
 <peter.maydell@linaro.org>, "junyan.he@intel.com" <junyan.he@intel.com>,
 "imammedo@redhat.com" <imammedo@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "philmd@linaro.org" <philmd@linaro.org>, "xiaoguangrong.eric@gmail.com"
 <xiaoguangrong.eric@gmail.com>, "Tottenham, Max" <mtottenh@akamai.com>,
 "Hunt, Joshua" <johunt@akamai.com>, "Glasgall, Anna" <aglasgal@akamai.com>,
 "qemu-stable@nongnu.org" <qemu-stable@nongnu.org>
Subject: [Patch v2] Don't sync volatile memory
Thread-Topic: [Patch v2] Don't sync volatile memory
Thread-Index: AQHb3wEuKOAPTPfla06nyx4MxiBBMQ==
Date: Mon, 16 Jun 2025 20:56:50 +0000
Message-ID: <1CC43F59-336F-4A12-84AD-DB89E0A17A95@akamai.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA0PR17MB4299:EE_|MW4PR17MB5950:EE_
x-ms-office365-filtering-correlation-id: 14376d05-2f6e-4ef0-a1b0-08ddad1850eb
x-ld-processed: 514876bd-5965-4b40-b0c8-e336cf72c743,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7416014|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?VWMvbCtaSVJNbWVGTGdsbmVQWG1pNHFCQXVoTk1DdVhHUnV1OWxHOHFMTDky?=
 =?utf-8?B?UXZ6YVhVMFNiajR2NnBXeHVCNDdsRm1EUlgvSUlxaE42aVUwc0FScTQvZ09l?=
 =?utf-8?B?VXdSVlBMT2h5MThITy9Fc1JyTS9vRmpSbXl1Vmc0WGI0U25iODdCZGtQQ2FP?=
 =?utf-8?B?T2pjM21NWFZkd05vYUhRNEFwSEF2clFnV1g3aGtJVmVMbGw4MTF0S0lYbU9J?=
 =?utf-8?B?eXFjaHRhVkRPSkpUZFlkcGxsS2hxa2RDcWJ6WFlFbWJxa1RhcncvTnM3OTZC?=
 =?utf-8?B?VGdNTUFoc3dLRDJDdnZMbWppdndLbzRmMk9lQnBweUJQSlowZnBscVlwOThB?=
 =?utf-8?B?Q1JWRWdkRVNpZm90dlRBWmRrRnVLV0Z0UnRnMXEzanVIZE8rVll6MGpmNnli?=
 =?utf-8?B?UUdXQ3lDT01pQ3lHWnVCZG1pSjN5UTIyS2J0MFdIRHVCUzRHbDR6S2FZUU5G?=
 =?utf-8?B?bnVpVjBzWkhQbU1wRUEwcFNPSGVKV1FPdURLWFFsaE9STUN3RExGQ0crWENi?=
 =?utf-8?B?SW9IbGpmNEhXUVJ2MjJWaWFDTkRBR2tCNEhldDZJQXR5anladk5ueU8weTF1?=
 =?utf-8?B?aXE0Y2Y3S2k0YnJEOW1ib2NaTmg2Z1dYYXRPbTJXRFRTQUE0WWZkN2VvNFEw?=
 =?utf-8?B?anFTQmV1UFFhN2FkQ2tVa0pSWDcvTDF3UjFoQnU3bk9wclpMdTlzMHVzMUto?=
 =?utf-8?B?bk5xWnVBTDZPU3NQRnFSMTdDTU1jRVY4aGtaWjM4MElyUFRtMnhYWUxZV3N4?=
 =?utf-8?B?ME9QNm4zNzBoL2JZaXNibXNwQUt4TW5Ib09RNlQ3ZWxVTlVWWlZpaktjRkll?=
 =?utf-8?B?eTgzeUNoSVQ1MEZLb1RWUTZnaVZCUFRFYmF1eXBiT1BoMUMrOERGRFV3QW1J?=
 =?utf-8?B?eXd5ZUt1aGh3UEJVb1VocFNzSVNOaGNqS0NwQ1A5dXFveUE5bWRXSEd1REJx?=
 =?utf-8?B?THpBdThNSXoxblZyYnVSTXJrWmwzbEtQL1ZWR1lxdGtWN2o0aXl4TWg0S2Z1?=
 =?utf-8?B?SjMwdTdDbzRueUg5UTlyZXBiQldabGdoWWxDRU04Tmg5aTlvTzdpWnJpL2lE?=
 =?utf-8?B?U05RZmFvUEFnRGxzdDl0S0VJSW85MXNqblkrNFdLbEQ1TlkyUnhjQ1d4Nkl6?=
 =?utf-8?B?Z2F3RTRHSGpiYzM2VHpUNVNPOVlSSE1laHliVk5BcGZ6Vjg0aC9YcHRPbjk0?=
 =?utf-8?B?cE1QbEkvZGZjbTRydUt3TUx6RjNkcnZmWk9mVnMrZ0hyMWQ5aFcxcWpXZS9U?=
 =?utf-8?B?bUtqaFVObGhWQVQwMVAxbzh4aU1VT09jSG82MlNKdHYwdDgrK1BCdTZmU1NZ?=
 =?utf-8?B?Z2FqWDdCUjlMd0NjSkRiU212eDJyd1VnSGpwaW1Qa3RMZ3BIK1BtSjFZdDhh?=
 =?utf-8?B?Q1llT2h1cnc4K3M3bUFGTHZ4NXhqUVhqZHBlenZKUXpSUVVsd3hpWFdFb0Jm?=
 =?utf-8?B?Q3RXMmlIMkJHOFZNdkhMcFZWM2hGWEoxZ2ZCQm15S2J5aG5YM256LzVLcmxr?=
 =?utf-8?B?UDhZQ0hxcEtEeURGcVBhaFB5bHdxVitwc2ZFY0lzemI3YUI5d3lMbDlDWEdz?=
 =?utf-8?B?RFlyWFNjQ1Fmb0FBTXJmN2NjQjQvQnBzdGNrOWZ1VENwSGxmeGZaSlFMOUZU?=
 =?utf-8?B?eElvbUR5czR6ek4zTFNWMHB3VnRxdnZ6Uk92OGxRc1l2S3kwbVVDVHN6UXRR?=
 =?utf-8?B?dWFINm5BZzVvQmk0Y29OcWVkcUNhVTVLMEt6emUrbnlUTXlBUEFqVmxnQldI?=
 =?utf-8?B?dTJrSjZsS215Ylk0ZFRUanp0K2pTU0JjNWlvYVFub3A3TDY2Njh0M1pRT2tr?=
 =?utf-8?B?UGhLc1ZySC9nM0FVU1lpbFcvWjdUc1lIUWFJRnMrbkZoeUdtK3k1UDBXaTV1?=
 =?utf-8?B?QzdVdHdOdGpHZVpKc2xvMFRLU1ZMS0lMZloxVllxb3d1MUZRcDJ2b3JDV0dQ?=
 =?utf-8?B?Mmx6dDRrT3BOSXFzS2xjem56LzNKVXZJOFZRbzNMaU5vaHFpTFY1VW5rM0RK?=
 =?utf-8?B?WkNGMmJURVhBPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR17MB4299.namprd17.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700018); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?b3dKbE1yUWtnNldNZlN5NVhUUWswR3JMa21SNGREWUVwbGFJV1FVKzlEekJC?=
 =?utf-8?B?RllSME0rMDFQTDBCMzU1KzYvdTFNNEpJcmhnN3VRY216dW1kcHFPYmdlSExv?=
 =?utf-8?B?SzNlUEdnOURCbEJ4eWVIaXR1V1hkWFVOVk93S1pyKzRrcGxYT01TdFQ0d1Z1?=
 =?utf-8?B?Rmw4b0hSaHVTd2FVMU5CbHNSQnA3VDJYQ3liT2ZYcUQraEVQZmszUVh3MWtS?=
 =?utf-8?B?TjNXMUlMOFozUUhiQ0Z6WnB6UjRLeUFHN0MraUtXTXkvTGRxeWNlTEZ1TXpq?=
 =?utf-8?B?alpTSW5KWHRPaUVYUkszZlh5cVd0bDUvVzZzcmppOXN2QWlDYkcxSGEyZk1v?=
 =?utf-8?B?VFVoeHpGWGtOdm1ZazEwcWNKNzI1NjEzREkwTHFxbkh0YlFrYStrSE1QeHJM?=
 =?utf-8?B?bTZqU0dkeERucENFbktsS1UxTWIxaTVDaDNwTUl1OTVubmt4TStYdW4zS3o1?=
 =?utf-8?B?K0RTY056U0x3eE53UnlyVXRkaERlSUc4THhqbFVYdS9Mam4ybDQrOGZvZFl5?=
 =?utf-8?B?V0tKc05HU3JTclJFNXJtT091SS85MXdyT1NYTUpXV1RCLytqRVpwd0kycGhW?=
 =?utf-8?B?TGlXNk1HRG9iSUliRzVPa0YyOEwyek1DaTl1ZlNCeENHRjYwc0FvWWlBZ2JU?=
 =?utf-8?B?ZUVmQktyempad2J1a3kzRHk2MkhzS2F4SldhUUVCdGo5a2Y1U2RiTHJ2ajBM?=
 =?utf-8?B?SVNvb3EvZklKd2VHSFVQREdqeFV6UjJQRWxkczRvRTdqTzFyUGFmb3JUelkw?=
 =?utf-8?B?TUpnemxCYXpkSTh5S29QY2QzcEpFcTFJUmhNWVJXZHN3ZGNWa1J3MEdtVjgx?=
 =?utf-8?B?VGplQ2h3UDFmYWJhSTVRcWVDY1JhNnZQUm1YWXhtZVI3RkFxd28xd2JBUFEw?=
 =?utf-8?B?d0xxNU9BRmRqK1VFbSt0R3ZlcVU5Y01TS0NVZEtMNzMzQmo5ejhEelBGaFMw?=
 =?utf-8?B?SFIwU0MwdVNiZkRTdk1sRWF2aWw1akVJTHdyTzFXekQ2dTVGcCt3OHFHdVpi?=
 =?utf-8?B?SkJVUUl4TTdIWXBuNU1Wc2ZEbkNXWkdwL2ZkVzVRaFhmenNzZjI3eURIL0lY?=
 =?utf-8?B?emdIYmpmQ2RyYXBTNjh2Mkp3aC9ZdSt1MjNUeFZNOEZzblF5SHV2eWQ2dFky?=
 =?utf-8?B?eWJHMC9OTllYN1RRWXdHS25PSTdRbGhsZTBXUVl3NTNQVGFuYUgyVFg2TXpj?=
 =?utf-8?B?eTJFOEU5WkppL0ltWDY4Y095WjJxcWxvVGo5amxBS0FrODdNLy9vQ25mM3Rp?=
 =?utf-8?B?bndYZ0VOSE41MDgvM0JrRjZiS2RTVm8vbXlWdDF1YzhtRHJkdEtsY2xDR3Jr?=
 =?utf-8?B?QmhOeGVRVXUwVDRIeGk3RnVNR1p0Nk44V2h0UjJPYmlDV1JucTNJTWNVaWpV?=
 =?utf-8?B?VUZtcTl3UHkzRVZXOTJtTk5LNStZSE9iMmNVR0hVT3htbk9BT3NRWTZQRms0?=
 =?utf-8?B?VjQ0OEpoMW1vSTA3NDRYVm10ODhkclNJYUNwYXdPMTM2UUtoemNBTkRnanQw?=
 =?utf-8?B?YW9pVmF6WDNEYnY1VmFUbmc3MnY3dWMwUVNpN1B3L3cwSm0rcC9FQjJxcmQw?=
 =?utf-8?B?UW5kWjltQU4rNHp5NFpzMzZabktqNUVwcU5tSVlJL1VHYVl5MnhzYXNrSVky?=
 =?utf-8?B?bXJrRU5mbzhWWWp2UzAxVFVaSTBDNXdlVkVoeUlZOG15bnNmZUsxS3BKMnFs?=
 =?utf-8?B?SEx0M3lYazNyT0wwM2xPVXFpOFM2ZitBems5aXBnNmZQWk5laTdGQmlCcUN4?=
 =?utf-8?B?clNZY0o1UlZBd3ZVZ2pDTW95bUxVandZVzNsZG11YmtVWklONEthUlpHTkl2?=
 =?utf-8?B?SzhKZnh5OTlOcUpNZSt2aWl1VGMxSmNqTVBaYVljM3l4VXppQXNLSEREVlZZ?=
 =?utf-8?B?bDAxZHRaOUhBTnk4ekxSTC8xVWpkaE13dUNYQ2ZtMTlUQTNqME00MjV6T1hr?=
 =?utf-8?B?Wk9sbTMvaDkzQ0tLSkVtUEMzQ3JzTXlIWmdvYzFSemROQmxLajE5a2IxLzZG?=
 =?utf-8?B?ME54MUdVVEJ4NU91UmRQS1VDVk1DTm9Mb0pmSm02N2RNS1hJSGlLRDFFSThB?=
 =?utf-8?B?ZGdrM28rNm5sVTdpenBVM3NIdnpVenEvSkRYRGFmb3VURkwvcC9LUERzdkYv?=
 =?utf-8?Q?MnBojwxbGBgHKYYkEKvZSx/pQ?=
arc-seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KjBR2hLwvT7byxxR0hJJY81iMC8P+wyed0WeEo7PBmGIqRm7Fq6lf73dSVPb/O5mpZIRlZpMG0B3WHG5dyy7TtUmXrv1J0eFhqRQ856laxhvwyFnaVT/eKKED6h9fDaP1v2eTY1ZZycyDyxkG4ZSILE3/HN8ASCu7rGG4VQkvMcT/CobraA4XlJkIy0CvngT9p+/EFkCzUb3DgbeifAPKQQ+OdI2AFF1irz6jO9xFsg+ops9+LUOEqYkll4fqSdJuFfqPBOfC4B+hi4oFoAqmqXJgr34HZ9mhaBBONwCE2f3k3wwYpTJHqPpOiWFySJbq8B7RiPOH+O8rAEJvw5kUA==
arc-message-signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=764odvYyYy12AE5NhuqxydHWQIJDHw9ep32BSNAw7Js=;
 b=LT6ug9JwAtK5heb+XMOvk2FTSN1wyQHKSJOEMaMW2mJjg059/0HS9+7JQt6tMAan7lrmLaaLsa0KZvpyJz0s90fZr7WkbbR+tBWPkm6SqkQJFdgo4ZaR/9vya1IWUyWeyOXbLYpYnXt04vdqsJiSAQmnwnVAqYekg2gtZkG5GqApNc7dL2SXCIezE7OHFXRtf4kO+97HqoZEpaGHrvhR6ImMkgiK2eyVq+1ZlY/su6PXkMfAcAZ+wib7Wd6Nkb0616AX3V4R5b0ZPjyx6RlZJ/ZVd9chAia8eoGpHtQ4DQHOe4YHXj3OM9KdxzSwGHyJJKgfmfKtx7ckRTfP6GQPxA==
arc-authentication-results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=akamai.com; dmarc=pass action=none header.from=akamai.com;
 dkim=pass header.d=akamai.com; arc=none
dkim-signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=akamai365.onmicrosoft.com; s=selector1-akamai365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=764odvYyYy12AE5NhuqxydHWQIJDHw9ep32BSNAw7Js=;
 b=QsbS0eY2vq2EdT1xnavbwNe9uqEKudjtlxLga71njh4BSP/km3afXFfAH2U2oJB7CPsvFr1zO/TGqRdV98qwWh23hxOcofSdG9cLBk6sltxJxyLW8fmssuI1cpYgL2SognhlK7a4tUz/ic30viH84cYvzX+cxgOs3vFuoGWLyO4=
x-ms-exchange-crosstenant-authas: Internal
x-ms-exchange-crosstenant-authsource: SA0PR17MB4299.namprd17.prod.outlook.com
x-ms-exchange-crosstenant-network-message-id: 14376d05-2f6e-4ef0-a1b0-08ddad1850eb
x-ms-exchange-crosstenant-originalarrivaltime: 16 Jun 2025 20:56:50.4302 (UTC)
x-ms-exchange-crosstenant-fromentityheader: Hosted
x-ms-exchange-crosstenant-id: 514876bd-5965-4b40-b0c8-e336cf72c743
x-ms-exchange-crosstenant-mailboxtype: HOSTED
x-ms-exchange-crosstenant-userprincipalname: pigXCjUMJO7RDRkChTD6l0fUJv35YxjpsCIHJYIoP8SnwLzu6FhgculzP6XZT05Qe3pi5v2W7OysJ+/nz6hH7w==
x-ms-exchange-transport-crosstenantheadersstamped: MW4PR17MB5950
x-originatororg: akamai.com
Content-Type: text/plain; charset="utf-8"
Content-ID: <1A25165309117941AC29FAF5D848C4BD@namprd17.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-16_10,2025-06-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 mlxlogscore=979
 bulkscore=0 mlxscore=0 spamscore=0 adultscore=0 suspectscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2506160145
X-Authority-Analysis: v=2.4 cv=N70pF39B c=1 sm=1 tr=0 ts=68508517 cx=c_pps
 a=3lD5tZmBJQAvN++OlPJl4w==:117 a=3lD5tZmBJQAvN++OlPJl4w==:17
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6IFa9wvqVegA:10 a=g1y_e2JewP0A:10 a=X7Ea-ya5AAAA:8 a=_e5o2aYZrnbTDTDJ3gUA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE2MDE0NiBTYWx0ZWRfX3wCPlrQIH5vB
 4qb0Gh4jGOLXZgCRH8GfJNNKCW/KDDa3ovZsoYDpekw51HawlBx+ecpglxKuHniXQrTIgIW3TsQ
 U9FAWDrQom6l/s5Btq7miKmx2RlNVtKyezhz3W+l1c27WRp+FbopNiCd8103+merqMV39xZVlZ2
 2qqnG/eTbuUSrELD+wQZJ9IVNBeOg2E141Mdn21FuqYvAM1W1aSrgJAm3fiXOv1yCNgBVjLth+T
 lOY9XOhm4CRxuH3THUxrIldgrIOcmsgYCXdlElzNKWKm+QWOZwacRIZ1qM7S9eiTQtUbHYARN3f
 +BsShvlVnUmvfSUpP9YblQ3Bo4N2cdI0qOoXmXBXNZV+lfPXH3Fv1fJYK1zq0cvowe0V7dPOETQ
 +o8vS2UUGWTjye3G14kGDyw5Ida4uvh2Ui1NgSOqGa3AfEIEmx4dEdLmZwQelGZUVSI4KNZh
X-Proofpoint-GUID: cq8McFqUWqVpSZSerDA4sX7KlCGZUvRS
X-Proofpoint-ORIG-GUID: cq8McFqUWqVpSZSerDA4sX7KlCGZUvRS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-16_10,2025-06-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 malwarescore=0 mlxlogscore=804 suspectscore=0 spamscore=0 adultscore=0
 mlxscore=0 clxscore=1015 bulkscore=0 impostorscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506160146
Received-SPF: pass client-ip=2620:100:9005:57f::1;
 envelope-from=bchaney@akamai.com; helo=mx0b-00190b01.pphosted.com
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.892,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Tm90IGFsbCBwbWVtIHJlZ2lvbnMgYXJlIGJhY2tlZCBieSBub24tdm9sYXRpbGUgbWVtb3J5LiBT
eW5jaW5nIHZvbGF0aWxlDQptZW1vcnkgcHJvdmlkZXMgbm8gYmVuZWZpdCwgYnV0IGNhbiBjYXVz
ZSBwZXJmb3JtYW5jZSBpc3N1ZXMgaXMgc29tZQ0KY2FzZXMuIE9ubHkgc3luYyBtZW1vcnkgdGhh
dCBpcyBtYXJrZWQgYXMgbm9uLXZvbGF0aWxlLg0KDQpTaWduZWQtb2ZmLWJ5OiBCZW4gQ2hhbmV5
IDxiY2hhbmV5QGFrYW1haS5jb20+DQpGaXhlczogYmQxMDhhNDRiYzI5IChtaWdyYXRpb246IHJh
bTogU3dpdGNoIHRvIHJhbSBibG9jayB3cml0ZWJhY2spDQotLS0NCm1pZ3JhdGlvbi9yYW0uYyB8
IDQgKysrLQ0KMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0K
DQpkaWZmIC0tZ2l0IGEvbWlncmF0aW9uL3JhbS5jIGIvbWlncmF0aW9uL3JhbS5jDQppbmRleCBk
MjZkYmQzN2M0Li5lODU3YjU3OWQ2IDEwMDY0NA0KLS0tIGEvbWlncmF0aW9uL3JhbS5jDQorKysg
Yi9taWdyYXRpb24vcmFtLmMNCkBAIC0zNjcyLDcgKzM2NzIsOSBAQCBzdGF0aWMgaW50IHJhbV9s
b2FkX2NsZWFudXAodm9pZCAqb3BhcXVlKQ0KICAgICBSQU1CbG9jayAqcmI7DQoNCiAgICAgUkFN
QkxPQ0tfRk9SRUFDSF9OT1RfSUdOT1JFRChyYikgew0KLSAgICAgICAgcWVtdV9yYW1fYmxvY2tf
d3JpdGViYWNrKHJiKTsNCisgICAgICAgIGlmIChtZW1vcnlfcmVnaW9uX2lzX25vbnZvbGF0aWxl
KHJiLT5tcikpIHsNCisgICAgICAgICAgICBxZW11X3JhbV9ibG9ja193cml0ZWJhY2socmIpOw0K
KyAgICAgICAgfQ0KICAgICB9DQoNCiAgICAgeGJ6cmxlX2xvYWRfY2xlYW51cCgpOw0KLS0NCjIu
NDAuMQ0KDQo=

