Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 872FCC19F32
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Mar 2025 02:11:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tovGS-0003PF-2p; Sun, 02 Mar 2025 21:10:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1tovGM-0003Nq-VF
 for qemu-devel@nongnu.org; Sun, 02 Mar 2025 21:10:35 -0500
Received: from esa12.fujitsucc.c3s2.iphmx.com ([216.71.156.125])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1tovGK-0001BD-EE
 for qemu-devel@nongnu.org; Sun, 02 Mar 2025 21:10:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1740967832; x=1772503832;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=fDS7lKVkylz0TUao4c9i2z1tCjbcR01iY8TJFdb5684=;
 b=YDMMTc28wOtsW/vRERNxY962zQ6ZyixVhKizDzdqhJMwIGjTtKrix8EW
 j/KRgsFjEt7CkewY0ynqiOeDIFkGNIJrhYsJr4V4sEbQ5fKP8l9feBwQW
 rHJmaXQ1iUW3EaBIyIcPf+vbnIdtWZR5wN98/aNf9vWpm/G1xKArRDJSA
 /nfbjY/p5bSR9EsmXhOTlFMxsdn5V+gdyLSSdr6B9pW0SGHztUHtctPgR
 9eePsZDfNxiYvGWt7Z1ea719ZjtPNP9nSh+cN9/qlc40+KVHR33IRrd2V
 0+hoQVAz0ZCyp+DHeMlkJKZhl+KKBCV+EzFhDS6uoFyKeEatyufvS04Zh A==;
X-CSE-ConnectionGUID: x2tosFm/TCWCsP5uhYGpMw==
X-CSE-MsgGUID: PMtiJHqzSI2SVSff43UH1w==
X-IronPort-AV: E=McAfee;i="6700,10204,11361"; a="148252662"
X-IronPort-AV: E=Sophos;i="6.13,328,1732546800"; d="scan'208";a="148252662"
Received: from mail-japanwestazlp17010003.outbound.protection.outlook.com
 (HELO OS0P286CU011.outbound.protection.outlook.com) ([40.93.130.3])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Mar 2025 11:10:23 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bhfyxZoKitRSYV+admU0ybGqPHrswSEqj3R0B93AGYSSZplfjG7Sir1w4tC5Y7uTa6XLujpdA87Hd9S6p3R/ho+NVzcWS7NL1t0VuPW4xqyPMVe7JEknQpzsjFFWwfWKLSvmBN6tXyG/frFwO8zBO8v+cE/zcBRgK6T1rKM7vtO8oYQt2SV7d3+e8R8Sfb6nbBdFQ7t7NJENqw/Da4YeD6SEtVOCjkO4kmQR8BT6krZx01Gh4V9JzV1S3YiMiCk6vLtoRVa1tGFKJ71vV882hbGqPEOhH902kPYbpJlAgOCrLMNFupEi2T2MpQ8gQcTjlCuq2Ce6tBA5nx36y/Qjag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fDS7lKVkylz0TUao4c9i2z1tCjbcR01iY8TJFdb5684=;
 b=Acpn7lHRzxMg/uQXS2cwhikerCanpiy4XjbZ1vvdKGcmO9S4HE7yWahnzlz2hh6DN/hlVbuUXctBn2sbL6CphKEo9wte8YynT3HfEq8PoNaMW/Qf8Ubh0pKC1zR0L0d/Ysu4x9kag8eFMORP4zQBgc/Uhkxpcg5Z9MQKFxhH/HDu8CA9YnYeyLac+uRBBH+cm7GIurx3aITwsGpRuEn3/2A27Jqq88kZ/HYGd+86As9HFEPaqHKTjj9TU+WksmFX0wff4+4f6pSXErzJUYKqeY1jD68jqglVwFlktLBXP52HsHOFI1gxJbDDgEYQCpXsm0FVAu3Em2E+E236N4hVPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com (2603:1096:403:6::12)
 by TY7PR01MB14722.jpnprd01.prod.outlook.com (2603:1096:405:255::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.25; Mon, 3 Mar
 2025 02:10:20 +0000
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::d9ba:425a:7044:6377]) by TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::d9ba:425a:7044:6377%5]) with mapi id 15.20.8489.025; Mon, 3 Mar 2025
 02:10:20 +0000
To: Fabiano Rosas <farosas@suse.de>, Li Zhijian via <qemu-devel@nongnu.org>
CC: Peter Xu <peterx@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Paolo
 Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v4 6/6] migration: Add qtest for migration over RDMA
Thread-Topic: [PATCH v4 6/6] migration: Add qtest for migration over RDMA
Thread-Index: AQHbiBfEbFzozuFRUEydh8Gzq9QSW7NcvtwAgAPzxgA=
Date: Mon, 3 Mar 2025 02:10:20 +0000
Message-ID: <e6e5f477-f3c6-459d-959d-2de410104ea5@fujitsu.com>
References: <20250226063043.732455-1-lizhijian@fujitsu.com>
 <20250226063043.732455-7-lizhijian@fujitsu.com> <87ikou2n8x.fsf@suse.de>
In-Reply-To: <87ikou2n8x.fsf@suse.de>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY1PR01MB1562:EE_|TY7PR01MB14722:EE_
x-ms-office365-filtering-correlation-id: e8f32075-5525-4045-a961-08dd59f88cba
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|38070700018|1580799027; 
x-microsoft-antispam-message-info: =?utf-8?B?V1J0NkJuMytjajVIRW9aam5rV0M1enJsVWxrcWtlQ0FzVm9hdlpjYldRTVNr?=
 =?utf-8?B?RGlyU3c3UCtyUzRudlB4WFFMTU1lbXk3QjZ5bkFMY09zSFpvN1Y3TDRUZFpt?=
 =?utf-8?B?eWdWdlpnK3l5UDI5VHhrWWRxYXJrOHRiR25BZElWK0NaZThuS1EzWU9LVW4r?=
 =?utf-8?B?a0Fua3lsaVNkZHYybmk2NDF3VkxIYkFZRU1nQXcxb05JQk5Wa2sza0VJZDkr?=
 =?utf-8?B?Y2hSZWliNUJQOVpTSE5CdmY3YWFEWjlteVVTeGJjbkpmLzYxRkdvZktMRWRn?=
 =?utf-8?B?Vm0yb2ZQdHNaNktDd3loc3VUZXJldy9rMi9MZjNRSmYwSVJFRytrZ24yTmxi?=
 =?utf-8?B?dFVURy9nMHNsRzdHQ2hrMElTeW1HMjFmWDBWS2JLTGN4Y0xTalFQTWNwbkh0?=
 =?utf-8?B?c3ZVWWlnTFhYMEZid0cybDVDMzg4UmlnM3BNaG0vZTlnSnhHbHNYazdvdjgv?=
 =?utf-8?B?S2Z4S2kvdkNzNFZOZzVuemUvRW5hUTYvbHVaV01BM1B0aGwxbTBVZnZ4ZGhH?=
 =?utf-8?B?Y2gyVUtOYkEzZURLMGk4alc3Y0JpWUpjNVpsQWlaczlLMW1TM3Vtb1h1Nitq?=
 =?utf-8?B?S1VjVEN3SU40dzJDTjM2QVNBbHoxRWFaREptTHBQbWxnYnNPcitlVTJCSGVV?=
 =?utf-8?B?YUliTjNwdUJFVjZ2MWFFMktmOURiTU0rNDR4YkxLTk4zNkdMTDVUbmRFVXRY?=
 =?utf-8?B?OGVXS0FJQnBuN1F1WXN6VitLYXpaMkZvQ2lFeVh4RVVOMklycUNibDRabVRr?=
 =?utf-8?B?N01TM094Z2dEMEJ2VTFESEswTExzdkZGb0g1dDQ5N0M5M2xjU2RiMDJTUDZ3?=
 =?utf-8?B?RDR2L3FuK0ZBQXBhemgrTXl4Zkl3OVpuanlTZEd2MVdNWnIrY1NFOWhuTzFk?=
 =?utf-8?B?SXZLaDZNMEo1OVhENDFVUTQ4b0w4TDNpbUMwRTZqZEhxNVoxUEVOY0FlSWtv?=
 =?utf-8?B?bS9rYzN4ajF1RU45T3ptL2g0RE1EcWhwaE1YbTBPM2UrZ0RaMUlPTUcwbHln?=
 =?utf-8?B?YnJvYzVQUGZaNVdOMkpDNjNJYWU5NG8yblp2bHRPT3djRk9kaVAraTRDRWl0?=
 =?utf-8?B?RDBoL1pxbVovWXFBaW9kWEd2WUtFbityNFBWMjgweVRKNlg5WE8zcU5uRTNy?=
 =?utf-8?B?d3M2NEY2UTMvQmQweXFqcTRKa0VSVEF3bmRIb3NhYUxzMEF4Zm4yWm9FNWlD?=
 =?utf-8?B?Mm8yR1JNdmVqc1hJWmFSNC9iYjEzVko5OEdWR2hUZVRHZGVIT0tqci9RM0hr?=
 =?utf-8?B?NG1jOTZCUmlSNWd0U1dNTE5yQU40RUpPOXprYlEvOGpUcTlNZ3hTM040QWls?=
 =?utf-8?B?SStCVitKa0hPRFdzSFB4NG9Db0czYzJjcVhKeW5VK1JBSEg0SXZmaWxkWkVX?=
 =?utf-8?B?QjJuWGVMVlZBT3B6TUdMb29QL25QYXBIRFBwS3pwUnZ3eHdPRlNSL0YxeEJO?=
 =?utf-8?B?WWRnY1FOcEhUN0pFc3BIUWU5aitLMGxjbGoxSlF2eCtrc25od2trdk1KY1RZ?=
 =?utf-8?B?M1I0YklWWDlqNFNZNk80dGNCTXhuREF6TXJTVm5RTlJSY0R3TjdSYk00WnRP?=
 =?utf-8?B?VEM1REYyRVhNdmtZaGg1NzJVRFltVk1tQ1dOVGtKbGxJL3NuS0p5d2xKMUxx?=
 =?utf-8?B?TkNrTTZjNk9oSnBITlJLWmNYdnRpWkY5eHEwSUUzU3JFMUI0bElPdW9IaXg2?=
 =?utf-8?B?RWV3clp4V05DMU05SnBmYkNIZ1hzaGZnRFM5ZS95ZW10Z0xQRVBiUWlkTjlT?=
 =?utf-8?B?bDczeDZQNXJmS3g2bkowanUxOFRKTmxWcDJBT2JKbzRBcG9hREh3a2pUYklP?=
 =?utf-8?B?eC9VazFPY0c0eVVNU25naU0xcXRZeGhZVE5jOE13cmZaaFdub25EWGpwS0pY?=
 =?utf-8?B?UmR6T0tVRmRPMUxlN2JhQW9lVWlic1c0K3hJTTdKRFdsaVpNTHNCcWh5Q1lN?=
 =?utf-8?B?d0dTTTNGS0N3ZVRPcEhtcEEzMnhiUXhhTGY4YXRCVlNQMDRvSkg2dUdHeEI5?=
 =?utf-8?B?cFZJQzYvbWJBPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TY1PR01MB1562.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018)(1580799027); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UDRYa1JrVUZwQUtnNU1HNlNwenN3Q0E0VGlISm15bFVyc0xqSVRMOHNnc29U?=
 =?utf-8?B?dDZvOXVzVGFVeXZrNTN5VURqemg2Ui93MTR3KzkxUEhjSHZTZ21OMUhvUWFq?=
 =?utf-8?B?aXZscm9hMDNpU0s2NFZ2ZnhGcFprVStCakNsc3JrVFo0WE1UanYweWYrK1lO?=
 =?utf-8?B?Z1hIODVIMkpjY0dVb1U2SkFXTFVjd0JUUFliYjY3aFAxWmdKTkZPdHYvdEp1?=
 =?utf-8?B?bzVieW9BZWVldlRic2JVaW5UVy9KSzF5cUNYaFB0TXBBalk1RlROK1NpYjNK?=
 =?utf-8?B?ZXl5ZG5QMmd2TGdjMDFUcjJkdmxmRE82MGg3Q3JKcTNKQVI3aTl5Ni8wYWV1?=
 =?utf-8?B?M1ZJbTZ3dHhrVFBqcUZ1TVl6MkN0MXRLRzh1Wlc1TWN0aXFVbitleEk4OThj?=
 =?utf-8?B?R3ZHNUZURDhaVURQdDJGVHM2dktOOEs0Zk1ES1pFc25KWWwxVFB5WklnSjRB?=
 =?utf-8?B?TWtONUhnTVlaMmxkejlSckVSbEhTMlo1cGFVUFY3UHMwYnpFWk54WldOeEZn?=
 =?utf-8?B?U0pDc0dDTFVOcy9Fa3YrTkt0L0tSMjNvUEt2TWV6SVVuc001UHVTcXVxb0o2?=
 =?utf-8?B?Wlk0TC9obHpvR1YxaVJseGhxMWt0R1R0WWNJWDJtbldTUlFLdUNUK2plNStl?=
 =?utf-8?B?NHBrYTZHTVllUW0rZmFySjc1NnlJWjFyMk16dXJDcnlZU0NuemlMMWFodVV1?=
 =?utf-8?B?SFg5T0twSFcwUDJtUFJLODBERjh5alBaVVAzQkk1UEF3bmZsaGVNcFhDZjFE?=
 =?utf-8?B?eDVBbXNDUURkMkhoMTU0UmV4d1NQaUxlc1pQS1lFRHFYNHFzdVlUZW1ydHpj?=
 =?utf-8?B?YkxKM05MU0pPOEFKdTBWZ2MvQ291L1l6RUJsRElXMWVST2pVMTlDc2kvS2Jp?=
 =?utf-8?B?dXF3aW9acHhqTk1HcDVHZGxIYjlITHZIeE9PWU5WSXhGeDJYd0tLR09FRWFE?=
 =?utf-8?B?ZktjMGNlNnhoNnd6Rmthc0JmUFN3QTFHbVlXc21MQWFhVUdGODdhd0ljRCtz?=
 =?utf-8?B?N2o4TEVITWVDcGpDd3RnQWxvdTFic1VVT0dhMjNLRnZ2VnRvQXRyVUhtQjBH?=
 =?utf-8?B?NXppM09BbjZVVXJpVVNLTlZIcU52U2lMbjZzNUlNUFBsYytyaS9hZmE5MzV5?=
 =?utf-8?B?NlVKd1crREozSFhhSElaTVBVTXROTGFkYSsxbHUzTXNlcmtnVGRKV0cyRUR5?=
 =?utf-8?B?VWFlaFVuRFpXZTRBZ3RHOEh0Zjhvek9KY2xvZ2hwOXNTSU1CNzZURkErSFpw?=
 =?utf-8?B?eTZUT0FxMGJRZFJzejlud3VNL3JjV3BhR3ZRWVRoSmU3NmlMZm94cERHT05M?=
 =?utf-8?B?eHl4dkYzZmtGWkJiRUFmcmJPeEZ5N1BGYThmQTVRYkdzS3Iyc1RzZFQ3Y2dG?=
 =?utf-8?B?ekNnZW5INGtBL1pva3VOdXRhWkhtMDRKK2Z3OGZuMFRmd2x0VDhRLzRhSUxu?=
 =?utf-8?B?OUQ3RzRLcUJFT1ZEZ1pOaTdhd2w3U1pyVGZHMG1wQmtyZDZPcjZSTW93RUJH?=
 =?utf-8?B?ZTZ5QW1FeFk3R2Y5TUZneWllOVA2WitQSlNCQzJNTXlDbUQ1Q250dXc4NFFJ?=
 =?utf-8?B?MnB5NEZqYVRtb1J1NncvRUE5TTN3dklpbU1HeXRCWUdTSUU4WDdJdkM3OXBI?=
 =?utf-8?B?WEJ5K24rMlo2b216TUFmWVhOMUZ0b1dUUVZ6NjJ0L3B0dEJvSmJYakRnZWp5?=
 =?utf-8?B?T1JFS21TYUViYmlOMDRMRTRIelVTQ0xQampOYW9jR1g1aGtnWXlTN2xmK202?=
 =?utf-8?B?N3JvaGFFMmJqSnB6TE9oTktWdjRDZ3B3bDRMV296eE1laGtON0tFaWU5ZWpZ?=
 =?utf-8?B?dWEzMzdNS0lFbngweDArOEgzTFRzQzdBenIwUzREOE5OaElYYlBLVFlrNGNw?=
 =?utf-8?B?dU50Vk91c1M5dTVxdkdKRkFmaHd4Kzk2UWY0RTF3Y0E1NVR1RUV5ZUdWQXk1?=
 =?utf-8?B?dlE2R2VPTHhDRzh4SFY4cUYxT2dMZ2dxR3hrUDNvbExXcGN3K1hITEowTFdD?=
 =?utf-8?B?aVJoZnVvRzRxSjhRRStmUjRtdlRrd0RhVk9TRTBqTTlYNDR3STlFd1A4QjFk?=
 =?utf-8?B?TUllcUY0R2NYOUViUXFaZjBMSXZDSm5KRk01SXNYZmRIZ2tXMVAvYmZSRkhE?=
 =?utf-8?B?WGVMZm90Ti96a3c1djkyK053eHYzUzV3OWUwNldXUUVURFlNRU9oaUNjMVNx?=
 =?utf-8?B?WXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CF1B7A3972724C46A13690DDD39AC92C@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: tQqvqwsxVYNiHpJ4tm37MJ3vES4yKJMXSK1kHMgAqeyO9onovLIxsoFS8A9eNWXQYU6glDnZ/xRn8iCftetJobY5HfDEzCOMmWYxvnRNHi0W1wsSTygoVIJ41IUuNwq1wFB0HKU07vnlbaS2cVrKEeluOc4SdnUV8ea9ekKGFJgu3P4bP0xZnnnz6lLnmi21tYDeSPk0Ogirc8MWFG0d7fVf2+s3nV+L1Tjw0K0LFSKJ0c4hARZdSonXJBKHqLbB6VGfyQFtXycM7ApwsWSFNPyieRDrd8Jk4M9VEs02umSxvn+wok4ymS2XZJCwAy/vLP7uu4uFyrdY9i8bXLxjmYSDmDSoY+AdUyB7NJtRIWz759vZlLqns2bYlaeu6fQfo6cjg14pZWjNuj2GQPvgbhOixz0r2CGNUbRdB0yo0p7OhwBpEsKEYgudn3eZE0R1VDjYgOlICtecr0GiSx1LpI/Hl0iUSxu4GnNlIi3a0f20eOUHK2RtNKFAhwd4gxYyRVU18+tty/sNE9h4J9pS6WVMykC/GLUKaiz2Ng3BQCV5WOeqvUZDWSFIsoGbpPGo/eRlu7XIt9BVwxq6GaBjWuJ1Zb3gQ7/aVMgoQ6dMxaHQitNatOyYrnGlDTPnO9ap
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY1PR01MB1562.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8f32075-5525-4045-a961-08dd59f88cba
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2025 02:10:20.3736 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5pkGTEFLvcJbG7D1WlSgkY2f3qMwKayCMMssu+rr44ZtqPFHYQiA5lXg9vZTt//fv+QwnBava9UxIch9bFdH+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY7PR01MB14722
Received-SPF: pass client-ip=216.71.156.125;
 envelope-from=lizhijian@fujitsu.com; helo=esa12.fujitsucc.c3s2.iphmx.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-to:  "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
From:  "Zhijian Li (Fujitsu)" via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

RmFiaWFubw0KDQpUaGFua3MgZm9yIHlvdXIgdGVzdGluZy4NCg0KT24gMjgvMDIvMjAyNSAyMTo0
OSwgRmFiaWFubyBSb3NhcyB3cm90ZToNCj4gTGkgWmhpamlhbiB2aWEgPHFlbXUtZGV2ZWxAbm9u
Z251Lm9yZz4gd3JpdGVzOg0KPiANCj4+IFRoaXMgcXRlc3QgcmVxdWlyZXMgdGhlcmUgaXMgYSBS
RE1BKFJvQ0UpIGxpbmsgaW4gdGhlIGhvc3QuDQo+PiBJbiBvcmRlciB0byBtYWtlIHRoZSB0ZXN0
IHdvcmsgc21vb3RobHksIGludHJvZHVjZSBhDQo+PiBzY3JpcHRzL3JkbWEtbWlncmF0aW9uLWhl
bHBlci5zaCB0bw0KPj4gLSBzZXR1cCBhIG5ldyBTb2Z0LVJvQ0UoYWthIFJYRSkgaWYgaXQncyBy
b290DQo+PiAtIGRldGVjdCBleGlzdGluZyBSb0NFIGxpbmsNCj4+DQo+PiBUZXN0IHdpbGwgYmUg
c2tpcHBlZCBpZiB0aGVyZSBpcyBubyBhdmFpbGFibGUgUm9DRSBsaW5rLg0KPj4gICAjIFN0YXJ0
IG9mIHJkbWEgdGVzdHMNCj4+ICAgIyBSdW5uaW5nIC94ODZfNjQvbWlncmF0aW9uL3ByZWNvcHkv
cmRtYS9wbGFpbg0KPj4gICBvayAxIC94ODZfNjQvbWlncmF0aW9uL3ByZWNvcHkvcmRtYS9wbGFp
biAjIFNLSVANCj4+ICAgVGhlcmUgaXMgbm8gYXZhaWxhYmxlIHJkbWEgbGluayB0byBydW4gUkRN
QSBtaWdyYXRpb24gdGVzdC4NCj4+ICAgVG8gZW5hYmxlIHRoZSB0ZXN0Og0KPj4gICAoMSkgUnVu
ICdzY3JpcHRzL3JkbWEtbWlncmF0aW9uLWhlbHBlci5zaCBzZXR1cCcgd2l0aCByb290IGFuZCBy
ZXJ1biB0aGUgdGVzdA0KPiANCj4gc3VkbyBzY3JpcHRzL3JkbWEtbWlncmF0aW9uLWhlbHBlci5z
aCBzZXR1cA0KPiBRVEVTVF9RRU1VX0JJTkFSWT0uL3FlbXUtc3lzdGVtLXg4Nl82NCAuL3Rlc3Rz
L3F0ZXN0L21pZ3JhdGlvbi10ZXN0DQo+IC0tZnVsbCAtciAveDg2XzY0L21pZ3JhdGlvbi9wcmVj
b3B5L3JkbWEvcGxhaW4NCj4gDQo+ICMgew0KPiAjICAgICAiZXJyb3IiOiB7DQo+ICMgICAgICAg
ICAiY2xhc3MiOiAiR2VuZXJpY0Vycm9yIiwNCj4gIyAgICAgICAgICJkZXNjIjogIlJETUEgRVJS
T1I6IHJkbWEgbWlncmF0aW9uOiBlcnJvciByZWdpc3RlcmluZyAwIGNvbnRyb2whIg0KPiAjICAg
ICB9DQo+ICMgfQ0KPiANCg0KDQoxMzMzIHN0YXRpYyBpbnQgcWVtdV9yZG1hX3JlZ19jb250cm9s
KFJETUFDb250ZXh0ICpyZG1hLCBpbnQgaWR4KQ0KMTMzNCB7DQoxMzM1ICAgICByZG1hLT53cl9k
YXRhW2lkeF0uY29udHJvbF9tciA9IGlidl9yZWdfbXIocmRtYS0+cGQsDQoxMzM2ICAgICAgICAg
ICAgIHJkbWEtPndyX2RhdGFbaWR4XS5jb250cm9sLCBSRE1BX0NPTlRST0xfTUFYX0JVRkZFUiwN
CjEzMzcgICAgICAgICAgICAgSUJWX0FDQ0VTU19MT0NBTF9XUklURSB8IElCVl9BQ0NFU1NfUkVN
T1RFX1dSSVRFKTsgIDw8PD09PSBJdCBmYWlsZWQgaGVyZQ0KICAgICAgICAgICAgDQoxMzM4ICAg
ICBpZiAocmRtYS0+d3JfZGF0YVtpZHhdLmNvbnRyb2xfbXIpIHsNCjEzMzkgICAgICAgICByZG1h
LT50b3RhbF9yZWdpc3RyYXRpb25zKys7DQoxMzQwICAgICAgICAgcmV0dXJuIDA7DQoxMzQxICAg
ICB9DQoxMzQyICAgICByZXR1cm4gLTE7DQoxMzQzIH0NCg0KDQpJdCBhcHBlYXJzIHRvIGhhdmUg
ZmFpbGVkIGF0IGlidl9yZWdfbXIoKQ0KICANClRoaXMgd29ya2VkIG9uIG15IFVidW50dTIyMDQg
YW5kIEZlZG9yYTQwLiBJIHdvbmRlciBpZiB5b3VyIGRpc3RybydzIHNlY3VyaXR5IHBvbGljeQ0K
aXMgcHJldmVudGluZyBNUiByZWdpc3RyYXRpb24gd2l0aG91dCByb290IHByaXZpbGVnZXMuLi4/
DQoNCg0KDQoNCj4+ICAgb3INCj4+ICAgKDIpIFJ1biB0aGUgdGVzdCB3aXRoIHJvb3QgcHJpdmls
ZWdlDQo+IA0KPiBUaGlzIG9uZSB3b3JrcyBmaW5lLg0KPiANCj4+DQo+PiAgICMgRW5kIG9mIHJk
bWEgdGVzdHMNCj4+DQo+PiBSZXZpZXdlZC1ieTogUGV0ZXIgWHUgPHBldGVyeEByZWRoYXQuY29t
Pg0KPj4gU2lnbmVkLW9mZi1ieTogTGkgWmhpamlhbiA8bGl6aGlqaWFuQGZ1aml0c3UuY29tPg0K
Pj4gLS0tDQo+PiAgIE1BSU5UQUlORVJTICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgMSAr
DQo+PiAgIHNjcmlwdHMvcmRtYS1taWdyYXRpb24taGVscGVyLnNoICAgICAgfCA0MSArKysrKysr
KysrKysrKysrKw0KPj4gICB0ZXN0cy9xdGVzdC9taWdyYXRpb24vcHJlY29weS10ZXN0cy5jIHwg
NjQgKysrKysrKysrKysrKysrKysrKysrKysrKysrDQo+PiAgIDMgZmlsZXMgY2hhbmdlZCwgMTA2
IGluc2VydGlvbnMoKykNCj4+ICAgY3JlYXRlIG1vZGUgMTAwNzU1IHNjcmlwdHMvcmRtYS1taWdy
YXRpb24taGVscGVyLnNoDQo+Pg0KPj4gZGlmZiAtLWdpdCBhL01BSU5UQUlORVJTIGIvTUFJTlRB
SU5FUlMNCj4+IGluZGV4IDM4NDhkMzdhMzhkLi4xNTM2MGZjZGM0YiAxMDA2NDQNCj4+IC0tLSBh
L01BSU5UQUlORVJTDQo+PiArKysgYi9NQUlOVEFJTkVSUw0KPj4gQEAgLTM0ODAsNiArMzQ4MCw3
IEBAIFI6IExpIFpoaWppYW4gPGxpemhpamlhbkBmdWppdHN1LmNvbT4NCj4+ICAgUjogUGV0ZXIg
WHUgPHBldGVyeEByZWRoYXQuY29tPg0KPj4gICBTOiBPZGQgRml4ZXMNCj4+ICAgRjogbWlncmF0
aW9uL3JkbWEqDQo+PiArRjogc2NyaXB0cy9yZG1hLW1pZ3JhdGlvbi1oZWxwZXIuc2gNCj4+ICAg
DQo+PiAgIE1pZ3JhdGlvbiBkaXJ0eSBsaW1pdCBhbmQgZGlydHkgcGFnZSByYXRlDQo+PiAgIE06
IEh5bWFuIEh1YW5nIDx5b25nLmh1YW5nQHNtYXJ0eC5jb20+DQo+PiBkaWZmIC0tZ2l0IGEvc2Ny
aXB0cy9yZG1hLW1pZ3JhdGlvbi1oZWxwZXIuc2ggYi9zY3JpcHRzL3JkbWEtbWlncmF0aW9uLWhl
bHBlci5zaA0KPj4gbmV3IGZpbGUgbW9kZSAxMDA3NTUNCj4+IGluZGV4IDAwMDAwMDAwMDAwLi42
NjU1N2Q5ZTI2Nw0KPj4gLS0tIC9kZXYvbnVsbA0KPj4gKysrIGIvc2NyaXB0cy9yZG1hLW1pZ3Jh
dGlvbi1oZWxwZXIuc2gNCj4+IEBAIC0wLDAgKzEsNDEgQEANCj4+ICsjIS9iaW4vYmFzaA0KPj4g
Kw0KPiANCj4gSSdkIHByZWZlciBhIGNvbW1hbmQgLXYgcmRtYSBjaGVjayBhcm91bmQgaGVyZS4g
V2l0aCB0aGUgd2F5IHRoZSBzY3JpcHQNCj4gcGlwZXMgY29tbWFuZHMgaW50byBvbmUgYW5vdGhl
ciB3aWxsIGNhdXNlIGJhc2ggdG8gZW1pdCBhIGNvdXBsZSBvZg0KPiAicmRtYTogY29tbWFuZCBu
b3QgZm91bmQiIGluIGNhc2UgcmRtYSBjb21tYW5kIGlzIG5vdCBwcmVzZW50Lg0KPiANCg0KSXQg
c291bmRzIGdvb2QgdG8gbWUuDQoNCg0KPj4gKyMgQ29waWVkIGZyb20gYmxrdGVzdHMNCj4+ICtn
ZXRfaXB2NF9hZGRyKCkNCj4+ICt7DQo+PiArICAgIGlwIC00IC1vIGFkZHIgc2hvdyBkZXYgIiQx
IiB8DQo+PiArICAgICAgICBzZWQgLW4gJ3MvLipbWzpibGFuazpdXWluZXRbWzpibGFuazpdXSpc
KFteWzpibGFuazpdL10qXCkuKi9cMS9wJyB8DQo+PiArICAgICAgICB0ciAtZCAnXG4nDQo+PiAr
fQ0KPj4gKw0KPj4gK2hhc19zb2Z0X3JkbWEoKQ0KPj4gK3sNCj4+ICsgICAgcmRtYSBsaW5rIHwg
Z3JlcCAtcSAiIG5ldGRldiAkMVtbOmJsYW5rOl1dKlwkIg0KPj4gK30NCj4+ICsNCj4+ICtyZG1h
X3J4ZV9zZXR1cF9kZXRlY3QoKQ0KPj4gK3sNCj4+ICsgICAgKA0KPj4gKyAgICAgICAgY2QgL3N5
cy9jbGFzcy9uZXQgJiYNCj4+ICsgICAgICAgICAgICBmb3IgaSBpbiAqOyBkbw0KPj4gKyAgICAg
ICAgICAgICAgICBbIC1lICIkaSIgXSB8fCBjb250aW51ZQ0KPj4gKyAgICAgICAgICAgICAgICBb
ICIkaSIgPSAibG8iIF0gJiYgY29udGludWUNCj4+ICsgICAgICAgICAgICAgICAgWyAiJCg8IiRp
L2FkZHJfbGVuIikiID0gNiBdIHx8IGNvbnRpbnVlDQo+PiArICAgICAgICAgICAgICAgIFsgIiQo
PCIkaS9jYXJyaWVyIikiID0gMSBdIHx8IGNvbnRpbnVlDQo+PiArDQo+PiArICAgICAgICAgICAg
ICAgIGhhc19zb2Z0X3JkbWEgIiRpIiAmJiBicmVhaw0KPj4gKyAgICAgICAgICAgICAgICBbICIk
b3BlcmF0aW9uIiA9ICJzZXR1cCIgXSAmJg0KPj4gKyAgICAgICAgICAgICAgICAgICAgcmRtYSBs
aW5rIGFkZCAiJHtpfV9yeGUiIHR5cGUgcnhlIG5ldGRldiAiJGkiICYmIGJyZWFrDQo+PiArICAg
ICAgICAgICAgZG9uZQ0KPj4gKyAgICAgICAgaGFzX3NvZnRfcmRtYSAiJGkiIHx8IHJldHVybg0K
Pj4gKyAgICAgICAgZ2V0X2lwdjRfYWRkciAiJGkiDQo+PiArICAgICkNCj4+ICt9DQo+PiArDQo+
PiArb3BlcmF0aW9uPSR7MTotc2V0dXB9DQo+PiArDQo+PiAraWYgWyAiJG9wZXJhdGlvbiIgPT0g
InNldHVwIiBdIHx8IFsgIiRvcGVyYXRpb24iID09ICJkZXRlY3QiIF07IHRoZW4NCj4+ICsgICAg
cmRtYV9yeGVfc2V0dXBfZGV0ZWN0DQo+PiArZWxzZQ0KPj4gKyAgICBlY2hvICJVc2FnZTogJDAg
W3NldHVwIHwgZGV0ZWN0XSINCj4+ICtmaQ0KPiANCj4gV2hhdCBoYXBwZW5lZCB0byB0aGUgY2xl
YW51cCBvcHRpb24/IEkgdGhpbmsgSSBtaXNzZWQgc29tZSBkaXNjdXNzaW9uIG9uDQo+IHRoaXMu
Li4gV2UgY2FuJ3QgZXhwZWN0IHBlb3BsZSB0byBrbm93IGhvdyB0byBjbGVhbiB0aGlzIHVwIHdp
dGhvdXQgYW55DQo+IGhpbnQuDQoNCk5vdGhpbmcgc3BlY2lhbCwgb25lIHJlYXNvbiBjb3VsZCBi
ZSB0byBrZWVwIGl0IGFzIHNpbXBsZSBhcyBwb3NzaWJsZSBpbiB0aGUgYmVnaW5uaW5nLg0KDQpJ
J20gZmluZSB0byBhZGQgaXQgYmFjay4NCg0KDQo+IA0KPj4gZGlmZiAtLWdpdCBhL3Rlc3RzL3F0
ZXN0L21pZ3JhdGlvbi9wcmVjb3B5LXRlc3RzLmMgYi90ZXN0cy9xdGVzdC9taWdyYXRpb24vcHJl
Y29weS10ZXN0cy5jDQo+PiBpbmRleCBiYTI3M2QxMGI5YS4uYmY5N2Y0ZTkzMjUgMTAwNjQ0DQo+
PiAtLS0gYS90ZXN0cy9xdGVzdC9taWdyYXRpb24vcHJlY29weS10ZXN0cy5jDQo+PiArKysgYi90
ZXN0cy9xdGVzdC9taWdyYXRpb24vcHJlY29weS10ZXN0cy5jDQo+PiBAQCAtOTksNiArOTksNjYg
QEAgc3RhdGljIHZvaWQgdGVzdF9wcmVjb3B5X3VuaXhfZGlydHlfcmluZyh2b2lkKQ0KPj4gICAg
ICAgdGVzdF9wcmVjb3B5X2NvbW1vbigmYXJncyk7DQo+PiAgIH0NCj4+ICAgDQo+PiArI2lmZGVm
IENPTkZJR19SRE1BDQo+PiArDQo+PiArI2RlZmluZSBSRE1BX01JR1JBVElPTl9IRUxQRVIgInNj
cmlwdHMvcmRtYS1taWdyYXRpb24taGVscGVyLnNoIg0KPj4gK3N0YXRpYyBpbnQgbmV3X3JkbWFf
bGluayhjaGFyICpidWZmZXIpDQo+PiArew0KPj4gKyAgICBjb25zdCBjaGFyICphcmd1bWVudCA9
IChnZXRldWlkKCkgPT0gMCkgPyAic2V0dXAiIDogImRldGVjdCI7DQo+PiArICAgIGNoYXIgY21k
WzEwMjRdOw0KPj4gKw0KPj4gKyAgICBzbnByaW50ZihjbWQsIHNpemVvZihjbWQpLCAiJXMgJXMi
LCBSRE1BX01JR1JBVElPTl9IRUxQRVIsIGFyZ3VtZW50KTsNCj4+ICsNCj4+ICsgICAgRklMRSAq
cGlwZSA9IHBvcGVuKGNtZCwgInIiKTsNCj4gDQo+IFRoaXMgbmVlZHMgdG8gYmUgc2lsZW5jZWQs
IG90aGVyd2lzZSBtZXNzYWdlcyBmcm9tIHRoZSBzY3JpcHQgd2lsbCBicmVhaw0KPiBUQVAgb3V0
cHV0LiBJIHN1Z2dlc3Q6DQo+IA0KPiAgICAgIGJvb2wgdmVyYm9zZSA9IGdfZ2V0ZW52KCJRVEVT
VF9MT0ciKTsNCj4gDQo+ICAgICAgc25wcmludGYoY21kLCBzaXplb2YoY21kKSwgIiVzICVzICVz
IiwgUkRNQV9NSUdSQVRJT05fSEVMUEVSLCBhcmd1bWVudCwNCj4gICAgICAgICAgICAgICB2ZXJi
b3NlID8gIiIgOiAiMj4vZGV2L251bGwiKTsNCj4gDQoNCkl0IHNvdW5kIGdvb2QgdG8gbWUsIGkg
d2lsbCB1cGRhdGUgaXQuDQoNCg0KPj4gKyAgICBpZiAocGlwZSA9PSBOVUxMKSB7DQo+PiArICAg
ICAgICBwZXJyb3IoIkZhaWxlZCB0byBydW4gc2NyaXB0Iik7DQo+PiArICAgICAgICByZXR1cm4g
LTE7DQo+PiArICAgIH0NCj4+ICsNCj4+ICsgICAgaW50IGlkeCA9IDA7DQo+PiArICAgIHdoaWxl
IChmZ2V0cyhidWZmZXIgKyBpZHgsIDEyOCAtIGlkeCwgcGlwZSkgIT0gTlVMTCkgew0KPj4gKyAg
ICAgICAgaWR4ICs9IHN0cmxlbihidWZmZXIpOw0KPj4gKyAgICB9DQo+PiArDQo+PiArICAgIGlu
dCBzdGF0dXMgPSBwY2xvc2UocGlwZSk7DQo+PiArICAgIGlmIChzdGF0dXMgPT0gLTEpIHsNCj4+
ICsgICAgICAgIHBlcnJvcigiRXJyb3IgcmVwb3J0ZWQgYnkgcGNsb3NlKCkiKTsNCj4+ICsgICAg
ICAgIHJldHVybiAtMTsNCj4+ICsgICAgfSBlbHNlIGlmIChXSUZFWElURUQoc3RhdHVzKSkgew0K
Pj4gKyAgICAgICAgcmV0dXJuIFdFWElUU1RBVFVTKHN0YXR1cyk7DQo+PiArICAgIH0NCj4+ICsN
Cj4+ICsgICAgcmV0dXJuIC0xOw0KPj4gK30NCj4+ICsNCj4+ICtzdGF0aWMgdm9pZCB0ZXN0X3By
ZWNvcHlfcmRtYV9wbGFpbih2b2lkKQ0KPj4gK3sNCj4+ICsgICAgY2hhciBidWZmZXJbMTI4XSA9
IHt9Ow0KPj4gKw0KPj4gKyAgICBpZiAobmV3X3JkbWFfbGluayhidWZmZXIpKSB7DQo+PiArICAg
ICAgICBnX3Rlc3Rfc2tpcCgiXG5UaGVyZSBpcyBubyBhdmFpbGFibGUgcmRtYSBsaW5rIHRvIHJ1
biBSRE1BIG1pZ3JhdGlvbiB0ZXN0LlxuIg0KPj4gKyAgICAgICAgICAgICAgICAgICAgIlRvIGVu
YWJsZSB0aGUgdGVzdDpcbiINCj4+ICsgICAgICAgICAgICAgICAgICAgICIoMSkgUnVuIFwnIiBS
RE1BX01JR1JBVElPTl9IRUxQRVIgIiBzZXR1cFwnIHdpdGggcm9vdCBhbmQgcmVydW4gdGhlIHRl
c3RcbiINCj4+ICsgICAgICAgICAgICAgICAgICAgICJvclxuIg0KPj4gKyAgICAgICAgICAgICAg
ICAgICAgIigyKSBSdW4gdGhlIHRlc3Qgd2l0aCByb290IHByaXZpbGVnZVxuIik7DQo+IA0KPiBn
X3Rlc3Rfc2tpcCgpIG5lZWRzIGEgb25lLWxpbmUgbWVzc2FnZSwgb3RoZXJ3aXNlIGl0IGJyZWFr
cyBUQVANCj4gb3V0cHV0LiBZb3UgY2FuIHR1cm4gdGhpcyBpbnRvIGEgZ190ZXN0X21lc3NhZ2Uo
KSwgcHV0IGl0IHVuZGVyDQo+IFFURVNUX0xPRz0xIGFuZCBhZGQgYSBnX3Rlc3Rfc2tpcCgibm8g
cmRtYSBsaW5rIGF2YWlsYWJsZSIpIGJlbG93Lg0KDQoNCkRpdHRvLg0KDQpUaGFua3MNClpoaWpp
YW4=

