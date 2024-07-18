Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE558C3DA5D
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2024 00:42:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUFCt-0000Ep-RE; Wed, 17 Jul 2024 20:41:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yaoxt.fnst@fujitsu.com>)
 id 1sUFCr-0000C2-Cj
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 20:41:13 -0400
Received: from esa8.fujitsucc.c3s2.iphmx.com ([68.232.159.88])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yaoxt.fnst@fujitsu.com>)
 id 1sUFCo-0007my-Mq
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 20:41:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1721263270; x=1752799270;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=zDVAmALzlCQH/yXRtk5/C/qouDkAC4pskwhqUJSxzqM=;
 b=Y4VzduIEu7uGCf4eh0BysSShzxLWPRQWJQLz/d3yM8PRq9JZDnLNSRwa
 oKGTbTTUiR/yJ5YZTyTSYczoIsbH+WFVYqeWfMk4s0+Ko4lad25jRBz/F
 cfb23eHHud3nad+Q44Tg2cS/7QMZ6x9fyFM+kmDO4taHPXGBekDMJdZnw
 rEQdkXWGpKn+CrnL2gwzGPWlIZEBfpKe1c+ti1A1r03yiTH3eEm0WQtVK
 Gnu0ec4UsJ/1fQy1BJrkVSYTwrWpcRJwATuOZpjGxgV4HJusehyFKB59S
 ezMjMHxS7hUqtwPidjrw7dNJCQ0K2san1lzvewj2UEZ1S4q2QCa2QI0HK Q==;
X-IronPort-AV: E=McAfee;i="6700,10204,11136"; a="125515342"
X-IronPort-AV: E=Sophos;i="6.09,216,1716217200"; d="scan'208";a="125515342"
Received: from mail-japanwestazlp17010007.outbound.protection.outlook.com
 (HELO OS0P286CU011.outbound.protection.outlook.com) ([40.93.130.7])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Jul 2024 09:41:04 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JNNdRrUChFQzD5JBvEuVmXDU9joK0DzXl7u2YwlYIbF/PEGqbLMjD/K1+Ny2hMASIJSYJbLzMrt4oC/O3QOHPepLriHZygr5g1tkx5/tzY5sFmbc09A+rdAonexcV3HkgrgJN6Psoz280B8pYKxxXJCkxlZOcXVLXdbx1CWgoi6VAu0EBlXKLOo3jfi48O7e2KXqTBxk/9OSTEfc3fu5K2jdlh/DhFx1jyLiEFEEUnNBpkYRx60Nt9+u97WB9lqw9iTIDR3WAZ9sz9e1jrofpk5sPhUErdl4ofJXQibPk1haVyQ9S0FR4kMu23c6Ao1vYDX2Cf9Qa+OF/5JswyDOkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zDVAmALzlCQH/yXRtk5/C/qouDkAC4pskwhqUJSxzqM=;
 b=QZFQqBpyU1RvqYE4GxSozRC30A54HSJPzjHmMHBagFQsITfzBIDX81G4H09HHZsiibPyHI+e9KkfIDI+jl7+ID785/PZAbYLn1mugoHJk2aUITAmfuB1Df6cxw99xBE6CLzOZeCimRryX9OyN0ObSgWRdT7CHcszGOXRhUsCwT37tsaEloam1If3JI2zqspG92OmKcOS+D1Ur7j19Amd3+fpayyHaXkvxic4K/R1aLwFTONvGqN5QTdF5zUPiOTQxRPWEagYDoAYjxPAYHng7VvLZHtcfKyeI+lS9980Q6T4Tn/+a0uTEjVkGJDXAoMDExDdYgMZmRA7/cg79MgayA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TYCPR01MB6464.jpnprd01.prod.outlook.com (2603:1096:400:7e::7)
 by TYCPR01MB10666.jpnprd01.prod.outlook.com (2603:1096:400:293::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.17; Thu, 18 Jul
 2024 00:41:00 +0000
Received: from TYCPR01MB6464.jpnprd01.prod.outlook.com
 ([fe80::882:d445:280b:8484]) by TYCPR01MB6464.jpnprd01.prod.outlook.com
 ([fe80::882:d445:280b:8484%2]) with mapi id 15.20.7762.027; Thu, 18 Jul 2024
 00:40:59 +0000
To: =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>,
 "mst@redhat.com" <mst@redhat.com>, "marcel.apfelbaum@gmail.com"
 <marcel.apfelbaum@gmail.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>
Subject: RE: [PATCH v2] pci-bridge: avoid linking a single downstream port
 more than once
Thread-Topic: [PATCH v2] pci-bridge: avoid linking a single downstream port
 more than once
Thread-Index: AQHa2Cc2VreJNBdJJkewrW1WQKBmJrH6tNeAgADv0nA=
Date: Thu, 18 Jul 2024 00:40:59 +0000
Message-ID: <TYCPR01MB646414F0789321BC901B12258DAC2@TYCPR01MB6464.jpnprd01.prod.outlook.com>
References: <20240717085621.55315-1-yaoxt.fnst@fujitsu.com>
 <d9abd976-2e1f-4d08-a923-8fe983ff5c70@linaro.org>
In-Reply-To: <d9abd976-2e1f-4d08-a923-8fe983ff5c70@linaro.org>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: =?utf-8?B?TVNJUF9MYWJlbF8xZTkyZWY3My0wYWQxLTQwYzUtYWQ1NS00NmRlMzM5Njgw?=
 =?utf-8?B?MmZfQWN0aW9uSWQ9YjQyMmZjMGQtYzFlMC00MjA2LTg4Y2EtYjg5OTRjYmIy?=
 =?utf-8?B?OTdmO01TSVBfTGFiZWxfMWU5MmVmNzMtMGFkMS00MGM1LWFkNTUtNDZkZTMz?=
 =?utf-8?B?OTY4MDJmX0NvbnRlbnRCaXRzPTA7TVNJUF9MYWJlbF8xZTkyZWY3My0wYWQx?=
 =?utf-8?B?LTQwYzUtYWQ1NS00NmRlMzM5NjgwMmZfRW5hYmxlZD10cnVlO01TSVBfTGFi?=
 =?utf-8?B?ZWxfMWU5MmVmNzMtMGFkMS00MGM1LWFkNTUtNDZkZTMzOTY4MDJmX01ldGhv?=
 =?utf-8?B?ZD1Qcml2aWxlZ2VkO01TSVBfTGFiZWxfMWU5MmVmNzMtMGFkMS00MGM1LWFk?=
 =?utf-8?B?NTUtNDZkZTMzOTY4MDJmX05hbWU9RlVKSVRTVS1QVUJMSUPigIs7TVNJUF9M?=
 =?utf-8?B?YWJlbF8xZTkyZWY3My0wYWQxLTQwYzUtYWQ1NS00NmRlMzM5NjgwMmZfU2V0?=
 =?utf-8?B?RGF0ZT0yMDI0LTA3LTE4VDAwOjM2OjE3WjtNU0lQX0xhYmVsXzFlOTJlZjcz?=
 =?utf-8?B?LTBhZDEtNDBjNS1hZDU1LTQ2ZGUzMzk2ODAyZl9TaXRlSWQ9YTE5ZjEyMWQt?=
 =?utf-8?Q?81e1-4858-a9d8-736e267fd4c7;?=
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB6464:EE_|TYCPR01MB10666:EE_
x-ms-office365-filtering-correlation-id: bddd63da-9d5e-445d-ed9f-08dca6c24b67
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|38070700018|1580799027; 
x-microsoft-antispam-message-info: =?utf-8?B?YmhRRlBEU2NGTFo3Ymxwc0ZNZXBVS1VVMXlKb1A1SHlLekR5NG5DYzlHcDM0?=
 =?utf-8?B?dlVHSlJzcDFaOUp4VVNLL0ZrdzRjeFd4R1BuSWVwaHVucnZocHhrZWtLN0U4?=
 =?utf-8?B?Z3podG9ldXZ5QTFERjdKZDFLNVMzbTJOL1JWaDVwd2xXK000dEpHRnNtM3l2?=
 =?utf-8?B?KzVQcW1sUFRES3g2VzhzbENMVEtET1ZqMTVuMnhIRDFVZGpvR1JPT1FhOXg1?=
 =?utf-8?B?YjlBSGExS1BCaDdTTnFmaExKY2xmSWxVbm5XZ3E3d3FwY2RKYzNCeU1yZ24z?=
 =?utf-8?B?cTFqeStGTDNzd2w2elRva3d0VFhyOU5CSVRGT09pSTNUWDFRMVFqMFJKWktT?=
 =?utf-8?B?Yk0zdklPVDZMejM4S2VxejAvYmRJRmZQcmQ3UTJhOWJzZmRCd0oxaURWSHBv?=
 =?utf-8?B?T2RRSG4wbllNUzVPeC82azVnS1JGd0V3YzRpRmZGYjhaUGhVN2NTVUNMVlp0?=
 =?utf-8?B?cFdramtTN1hVVkYwTGd0alVKdEwxR09vc04xL1kySkd5WmNlbGgwbUNadDdn?=
 =?utf-8?B?WUcrR1JaQUpuTkFUYldvYXd5YlF0WlJ3bDRjZWthTzdlM3B1Q0kzOTZ2ZXpx?=
 =?utf-8?B?M2FaMEpRWDhjd1hyS1h0S05JOUpOWjh6bFFxQmdQcWF0NEl4NDRPMjRkVmNo?=
 =?utf-8?B?M01WZ3pSKy83SnJGamtOdmx3aHRNNzJPSGpqMzFyeXVQdjZHSmRrM2RqR2tH?=
 =?utf-8?B?NTRybVZyMEpscGlLbWwydEt1NU40NzhmWjhpN2Y1TzFURzBBTFZKa1kzRzJ3?=
 =?utf-8?B?b2l6ZEVFSnJZeWRraDFxVXllZjFMcml0N2NyRGJ1NlZ0TmhsZzRNaE9Ha2x2?=
 =?utf-8?B?S2ZOZ2laTXZKYW9NbHl0dis0WWxFUUdIVWROVHE1bUhPNnB3SUYxYm85Z2VG?=
 =?utf-8?B?dzN4YU5vVFkwQmFjTkwrRG02eTIyQTFkWFBNMWYzeGk5M1JYKzE0UFZORVRn?=
 =?utf-8?B?cjRtS0ZkUXdqNUtsQUJSRVNmOEE5U1hqdWJGMTFZMHB4TFVURjB6QkF6KzJv?=
 =?utf-8?B?WHhLeGNaUDlzdjFWTXpZRTBETlprNFN4TTFCN2FUbFg5L1JFZFRENlRuWVpC?=
 =?utf-8?B?U0hwdXpvczAxLzQwbk1sb1dGMTFmc0V1VE1GNTMrUU9zTDBCdEk2VWtTN202?=
 =?utf-8?B?ZjJmYytrTW5MZkp5TjJDKzc1aHpVakRqdUV2Y0ZqR3ZEMVByNXo5WFNlckdi?=
 =?utf-8?B?NHlpdTFlYkhoazN5UUsycTR1MVpyMkNuT0FRdjhaNFVXT2xCUHFnRGQ1bjEz?=
 =?utf-8?B?MWtaNXJwTWhkVjY2dk5UUmJZUUI1UWpKVVU1MC84NG1NWmlCeGgzSDZlUS9G?=
 =?utf-8?B?aHFCZjRYMU8rSzB0Vk9HeS9RMzU0NHhBR05XTFRqTlJDWDNBSGVMS0xOQkMv?=
 =?utf-8?B?UVJhZ01FVWxGeUFqZmFyRk85eDZKVXhKWGZQODJyTWg2bjRxako0c25xVmFs?=
 =?utf-8?B?QkRSbC9JbnRtR3JFcW42djRPdWI0M2hvdXhDNmphKzh5amRwWEV2ZHBwZkN2?=
 =?utf-8?B?N3VVWm8ydzljdkh3YXZHSlFMYzVZYkVXMmJBR2JCeXFTZ3FtQW51a1dKRTFN?=
 =?utf-8?B?TnA4V2VCemcxZzVxSmJROU5za1hsM0NGN04vNS90QnFZcHgwK2ZwdVNoekwy?=
 =?utf-8?B?aGhxSDFVVXZvZ2l3OEgyTE1JRko0ODFtR2VSKzZmQ2ttSFlZSnhaT2krMWtV?=
 =?utf-8?B?YVdQeGhEQnE1UUZ2MEFZSDZsK0s2WXpqQXFQRGlyenBsZndpZUFRR2x1MElC?=
 =?utf-8?B?YWFCdmgrM05sQ0RMYmEyZVRONHNvdHN6RElHMlhrTC9HVUFVckt0ZmR6KzV2?=
 =?utf-8?B?YWZkWTRqa3RIOWZkNXkvdHpvanl5eGg4eElTK3ptVTVVaDdudHdIMFY1T2hL?=
 =?utf-8?B?dzdsK3hzeFYwWEowVnlqTjBBQ1BKZTFsSjdHZXg0cHdzaVE9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-cn; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:TYCPR01MB6464.jpnprd01.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(366016)(1800799024)(376014)(38070700018)(1580799027);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZndHUWFlbksrTzM2TzJ6VThrRzhFWFlyNjZwWmtUR1NaNlRCNHgxelJKODlt?=
 =?utf-8?B?enhGNmhnSkh4N1pYWVNsb3J2N2JPb1VKNXoyeXF1aXIvb0lyczVVMUpNWlM2?=
 =?utf-8?B?cHFCMFd2cVpWK1RwVGtXU3RDTmJOMTV3b2dleWdlMzVMTVhxc2dzcmxBL2xx?=
 =?utf-8?B?cTZ3TE10Qis4a2VubS82K01UNmJNSXpFRjVYOGdNQWpRTnpXeXVoZE1tRVhV?=
 =?utf-8?B?WDVaT2thVTJkYi9YVkJzeldiVHplQWhpeHRkdEhzNXo1QlM3aTZ4WWpJWkFn?=
 =?utf-8?B?YUhCbG1xeTJiSFV5NzBRNjhUYkgvc2ZnVWNraCtaTUdrcllhbzJsd1dubFJW?=
 =?utf-8?B?dGVJK0VNMjhzME5rQUJ4b216K3J4UDlsczY2K3pHQTY1ZFNpQ0FLbm8wTURG?=
 =?utf-8?B?Ynd1VHJyQWlmeTRzN0tXWFhUa25yZjk2dGN6cXJXZ21BZ2U1NHlDWVNBQVRm?=
 =?utf-8?B?amZpWkxVejFjWCtKK1N6Y3IvUy9yaVE4ek1WUW5MeTlsR245MG1YQWNJWkwz?=
 =?utf-8?B?Z1UraEdhRmlSRzlUOHZ2S3U1RVRkUjJHZ0t1NFFnSmpyQzFhTmx0N0JDYnRD?=
 =?utf-8?B?SjF1V3FjYmd1UXYwTkZWQytBVWdCeTBkay9QQjl2Y0Z0Y0RKOWtGM3VoM1BP?=
 =?utf-8?B?aWI3Y1IyNStCVmc3OTlPNDlLaFovTXIyMGR0b24rRERNSllCY1RvWWRLLy9M?=
 =?utf-8?B?NHl5TGJuU2UvbWVBWm1BaDZMaWNreE51RnV4WHFsTzh6aWd3K0RrRVYzSXM3?=
 =?utf-8?B?SXFFNG5IQ0hQRGdjYzcrNEhUN3RrdnJ4bDM0L1pGNklZNXViN3hIdHRZd05z?=
 =?utf-8?B?K1BJSHkrOU81d2libk5COEN4ei9MTk0yTWNXdHU4L2MyZkZjZG9JOExKRzJS?=
 =?utf-8?B?NWEwdjNjWmlOMElpMXZCdWJ6ZVRZRVlvT29tUkh0c0E2OTRrb0hZblc4SDFV?=
 =?utf-8?B?UjNXWldHUGVjQUh0cFlBWTJZN1JKazJ5M29NTTR1SU5UcDh4cG5zb1BYNk1R?=
 =?utf-8?B?QjQrZk9YNlJSZnJzRzNna29xWjlYMXV0ZDZFNEFZZE9rTUtuTDBTT3ZNZlZ5?=
 =?utf-8?B?NjdOZ0o4VVprWm5TZ2tRaDM3UDJYWC9JRW1DMDNIOGJxc3J0bmkzcTRmbW5E?=
 =?utf-8?B?emhsY0JjeFZtejhBK2xzc3FmMHFLUDNhK2xzLzV6d3JNNHRkMUhIM0hiTkRH?=
 =?utf-8?B?TXN6bDNVRzBHMjBaR0l4bUZ2UGhvSHE3U3FnMUZJQkhaWkt1ejRlWmpORkhy?=
 =?utf-8?B?RWJpV2lBL1JUWWg4TWhaWW5iZE13cFJFQ1dBUTY5RVpiREZ3dTdXSVk5Qm9D?=
 =?utf-8?B?ajRsUVlpUWdyYjNGTjV1N0tkTmNzbk1EZGZCWlZSNlpydmJpL3didlZVait4?=
 =?utf-8?B?OTFCd3B6REJsVWhPNnFFQWZxVDhxaU1hUFN3NDQzSkNLQmhOZkFLQzR0dk9P?=
 =?utf-8?B?VFBCSndOa21WN0pnbVJhZTJQa29rQkRmYnNtdXo2cmJxUVlyWkh1RFphVFZx?=
 =?utf-8?B?RFpzMHczTEpOOGpTK05kQXhmbXhnTFJVbUsyN1RkMmJzdnFDemdXVWRNd3hr?=
 =?utf-8?B?UlRveExBVktIQWJQQUpVRHpZK05DdjVJdmpRZTR2MG8waXpjMXlYd1V5N0FP?=
 =?utf-8?B?YzBXditjbjNlQ0FZY1BoZVdNRk5OTE83bkFpZTlJK1NqcWx1SEUrUmFJWHZH?=
 =?utf-8?B?MDVDUzVKNHVQYytuUUgzcktSczZNR2FJWld1eEpvS1p6bTUwM2xGamljb0RN?=
 =?utf-8?B?T0szRUppVlF3KzR2SjgrK00xSWZzMXlGSDZMK1o4RTBqektudzRJYjVKZE9B?=
 =?utf-8?B?Z2tJdXlybUJwMnRBTmpST0hoWkhaVU02bnVUME1MeW1Mc0hVVUQxTXduZ2Na?=
 =?utf-8?B?OGdSRDBLVHd0YXQ1aEluRU9CM09wMy9HR1B5eXFtbnFFZTljQWJEejJ3Zjkx?=
 =?utf-8?B?RVpNaGpEcTJZdndLQytCaFZCVGw0ZmpnRllZTkxMZDlCWm5pbG1icWVoUVJy?=
 =?utf-8?B?UytJbWhITk5Odmo2SXZoaVM5aXhEVGlsTitPRmJtU3ZIZkRwVWkwYUZUL0Js?=
 =?utf-8?B?UDhQb2gvdkduZEVDRWRnZDBVRHJYMG9aVWZoR0ZwbVFXbjlnWDVydE1TM3d0?=
 =?utf-8?Q?49Hovkc3fJmSEvEool16rQK/c?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: sgOwi6LYoGCGyCJkdprQ/3OWUUbBG2MVnQjnkBjaAWBymYi91uKLZEeeb8jO+/vhu3/caJ4vKIU2EGmXOQGCdC6TtK0TolWbqGEaFey7vasrWCnr1spcxYpKh3QmJ/4+mE/Wm6V2AVg5UyDePf0sBValFOTa6MENjW86Ws4qfXoNBVVbooO4hKupAvrquwDkbbXXtEoemdQNv9P7sVk0YmiLNiuVI+TxZoQzkWJmzaHWFMrS9hNr3jSZgiVCzsLjFXRNvP6kmRDBJPApU3Xr7coXV9NGcEavIJN5tJV+hqKXMI3vTc6sigYk8tHCmAqz/HFnTdGWROMHgCrokWqj/OIW+f1X0I8d+hAZ+5IQ6F/A59jvDI4KKh1mW8I3KiiLGAbA8bK3Jvf8bX0zzZ1qys7SlMhggksN1WyG4DqZQoUEXkEK4kuXstVjt36bDm/Pzi959CIS0zyMZFMhCyokit0u2xAgJniC1OQpq+z9LIM07gN/9RIsKafa9gGi8pq+u/jnyxg5A8HWLAOgFL3kZ2rujXKX5BYo24j3WFLq/TPjaM6WgnOXKMI9sLyNpxQl5Du6dIcj1vHz/QpMXZU2O0N2f/DV0J65M9cKeT0URgnffnMo2S4W6J1QbF+I/zJc
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB6464.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bddd63da-9d5e-445d-ed9f-08dca6c24b67
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jul 2024 00:40:59.8205 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nOfzYB8Jbrshq/XQ5TiFyH8hNe6J4GL6l+OYySAti34KsTkdbEJhfgGoGED4mCIjpLnylwYeC/ybDd3ztRkZGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB10666
Received-SPF: pass client-ip=68.232.159.88;
 envelope-from=yaoxt.fnst@fujitsu.com; helo=esa8.fujitsucc.c3s2.iphmx.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Reply-to:  "Xingtao Yao (Fujitsu)" <yaoxt.fnst@fujitsu.com>
From:  "Xingtao Yao (Fujitsu)" via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUGhpbGlwcGUgTWF0aGll
dS1EYXVkw6kgPHBoaWxtZEBsaW5hcm8ub3JnPg0KPiBTZW50OiBXZWRuZXNkYXksIEp1bHkgMTcs
IDIwMjQgNjoxOCBQTQ0KPiBUbzogWWFvLCBYaW5ndGFvL+WnmiDlubjmtpsgPHlhb3h0LmZuc3RA
ZnVqaXRzdS5jb20+OyBtc3RAcmVkaGF0LmNvbTsNCj4gbWFyY2VsLmFwZmVsYmF1bUBnbWFpbC5j
b20NCj4gQ2M6IHFlbXUtZGV2ZWxAbm9uZ251Lm9yZzsgam9uYXRoYW4uY2FtZXJvbkBodWF3ZWku
Y29tDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjJdIHBjaS1icmlkZ2U6IGF2b2lkIGxpbmtpbmcg
YSBzaW5nbGUgZG93bnN0cmVhbSBwb3J0IG1vcmUNCj4gdGhhbiBvbmNlDQo+IA0KPiBIaSBZYW8s
DQo+IA0KPiBPbiAxNy83LzI0IDEwOjU2LCBZYW8gWGluZ3RhbyB2aWEgd3JvdGU6DQo+ID4gU2lu
Y2UgdGhlIGRvd25zdHJlYW0gcG9ydCBpcyBub3QgY2hlY2tlZCwgdHdvIHNsb3RzIGNhbiBiZSBs
aW5rZWQgdG8NCj4gPiBhIHNpbmdsZSBwb3J0LiBIb3dldmVyLCB0aGlzIGNhbiBwcmV2ZW50IHRo
ZSBkcml2ZXIgZnJvbSBkZXRlY3RpbmcgdGhlDQo+ID4gZGV2aWNlIHByb3Blcmx5Lg0KPiA+DQo+
ID4gSXQgaXMgbmVjZXNzYXJ5IHRvIGVuc3VyZSB0aGF0IGEgZG93bnN0cmVhbSBwb3J0IGlzIG5v
dCBsaW5rZWQgbW9yZSB0aGFuDQo+ID4gb25jZS4NCj4gPg0KPiA+IExpbmtzOg0KPiBodHRwczov
L2xvcmUua2VybmVsLm9yZy9xZW11LWRldmVsL09TWlBSMDFNQjY0NTNCQzYxRDJGRjQwMzVGMTgw
ODRFRjhEDQo+IERDMkBPU1pQUjAxTUI2NDUzLmpwbnByZDAxLnByb2Qub3V0bG9vay5jb20NCj4g
PiBTaWduZWQtb2ZmLWJ5OiBZYW8gWGluZ3RhbyA8eWFveHQuZm5zdEBmdWppdHN1LmNvbT4NCj4g
Pg0KPiA+IC0tLQ0KPiA+IFYxWzFdIC0+IFYyOg0KPiA+ICAgLSBNb3ZlIGRvd25zdHJlYW0gcG9y
dCBjaGVjayBmb3J3YXJkDQo+ID4NCj4gPiBbMV0NCj4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcv
cWVtdS1kZXZlbC8yMDI0MDcwNDAzMzgzNC4zMzYyLTEteWFveHQuZm5zdEBmdWppdHN1LmNvDQo+
IG0NCj4gPiAtLS0NCj4gPiAgIGh3L3BjaS1icmlkZ2UvY3hsX2Rvd25zdHJlYW0uYyAgICAgfCA1
ICsrKysrDQo+ID4gICBody9wY2ktYnJpZGdlL3BjaWVfcm9vdF9wb3J0LmMgICAgIHwgNSArKysr
Kw0KPiA+ICAgaHcvcGNpLWJyaWRnZS94aW8zMTMwX2Rvd25zdHJlYW0uYyB8IDUgKysrKysNCj4g
PiAgIDMgZmlsZXMgY2hhbmdlZCwgMTUgaW5zZXJ0aW9ucygrKQ0KPiA+DQo+ID4gZGlmZiAtLWdp
dCBhL2h3L3BjaS1icmlkZ2UvY3hsX2Rvd25zdHJlYW0uYw0KPiBiL2h3L3BjaS1icmlkZ2UvY3hs
X2Rvd25zdHJlYW0uYw0KPiA+IGluZGV4IDc0MmRhMDdhMDE1YS4uYWY4MWRkZmVlYzEzIDEwMDY0
NA0KPiA+IC0tLSBhL2h3L3BjaS1icmlkZ2UvY3hsX2Rvd25zdHJlYW0uYw0KPiA+ICsrKyBiL2h3
L3BjaS1icmlkZ2UvY3hsX2Rvd25zdHJlYW0uYw0KPiA+IEBAIC0xNDIsNiArMTQyLDExIEBAIHN0
YXRpYyB2b2lkIGN4bF9kc3BfcmVhbGl6ZShQQ0lEZXZpY2UgKmQsIEVycm9yICoqZXJycCkNCj4g
PiAgICAgICBNZW1vcnlSZWdpb24gKmNvbXBvbmVudF9iYXIgPSAmY3JlZ3MtPmNvbXBvbmVudF9y
ZWdpc3RlcnM7DQo+ID4gICAgICAgaW50IHJjOw0KPiA+DQo+ID4gKyAgICBpZiAocGNpZV9maW5k
X3BvcnRfYnlfcG4ocGNpX2dldF9idXMoZCksIHAtPnBvcnQpICE9IE5VTEwpIHsNCj4gPiArICAg
ICAgICBlcnJvcl9zZXRnKGVycnAsICJDYW4ndCBsaW5rIHBvcnQsIGVycm9yICVkIiwgLUVCVVNZ
KTsNCj4gPiArICAgICAgICByZXR1cm47DQo+IA0KPiBDb3VsZCBwY2llX2NhcF9zbG90X2luaXQo
KSBiZSBhIGdvb2QgcGxhY2UgdG8gY2hlY2sgZm9yIHRoYXQ/DQo+IA0KPiBPdGhlcndpc2UgSU1I
TyB3ZSBzaG91bGQgYWRkIGEgaGVscGVyIGluICJody9wY2kvcGNpZS5oIiBhbmQNCj4gY2FsbCBp
dCBoZXJlLCBub3QgZHVwbGljYXRlIHRoaXMgY29kZSBpbiBlYWNoIG1vZGVsLg0KWWVzLCB0aGFu
a3MgZm9yIHlvdXIgY29tbWVudC4NCkkgdGhpbmsgcGNpZV9jYXBfaW5pdCgpIG1heSBiZSBiZXR0
ZXIuDQo+IA0KPiA+ICsgICAgfQ0KPiA+ICsNCj4gPiAgICAgICBwY2lfYnJpZGdlX2luaXRmbihk
LCBUWVBFX1BDSUVfQlVTKTsNCj4gPiAgICAgICBwY2llX3BvcnRfaW5pdF9yZWcoZCk7DQoNCg==

