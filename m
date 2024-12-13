Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5639E7717D
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2024 08:16:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tM0q5-0000I5-EW; Fri, 13 Dec 2024 03:15:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1tM0q2-0000Gm-6F
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 03:15:55 -0500
Received: from esa16.fujitsucc.c3s2.iphmx.com ([216.71.158.33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1tM0px-0004ae-FJ
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 03:15:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1734077750; x=1765613750;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=nZUlHx2DbzBOgObNRDW9yAShRCiESzb8KMqz5totw0I=;
 b=hI+kkQ5nMEXvsO2Wfr6v/VgQGDDx9T3vXNbS2BEbyKeGvVx2LoiQpf2L
 4uoW3467UB+WiurN8qYZgNZ0qwHf26p9aF44i/ZwWsa9kALBdXt9nlHjX
 ANxAs2lZfEiwDuWvfl9A5sxaMWpXBwUFNBfhmPTwUCzYTKVEL3gjyikWO
 7yv8XEPD0sVKf+S6cOjwP05ByZb75KkgOLKS5ivdO0ighkJyV08ETrgM0
 KGJYt3uoOIP8fClIKcvsGybYCHoSvV1VV/UJYAyIKrMW1kTqZzEQXkyZn
 tcd2V9RDfmProade4TAHdzbybV49QfD3rfjz46u8FTo7GuyC7mqV8d2ob Q==;
X-CSE-ConnectionGUID: q/xAx9CHSUKswEaEDq4BnQ==
X-CSE-MsgGUID: jGpP13c/SNeJIPsiFdf4Og==
X-IronPort-AV: E=McAfee;i="6700,10204,11284"; a="140138858"
X-IronPort-AV: E=Sophos;i="6.12,230,1728918000"; d="scan'208";a="140138858"
Received: from mail-japanwestazlp17011026.outbound.protection.outlook.com
 (HELO OS0P286CU010.outbound.protection.outlook.com) ([40.93.130.26])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Dec 2024 17:15:42 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uaOciIiBJVfRrVEjteRgDYJmPtMl7jcG3GjHEmTWQk48/CGCxH7XDBYNnvWjGgVU2Bfauw45hOShdsw360BMldzbybuMrSRuiAE7LFK/VA1qqvApMJiJfFTxnmZx1AMYhq4lm4djiunuumvev9WTDaVBxvLvNaycl3Y+Zt+e8Tg+ZpFj87DItQtd5zNb1rO2pLc7gEpfDXDKUGqXAF8k/fxwWxhO+Nn0jskP5B+8JptQTC0DKbffsiF0eMoJtGjo0d5KvOMB1RQjyneKNUjbEnvXQo71a4/LpdEo+OpUJhSmcTcJZ0kp9JPB4I/W2pFJg2t9CE0Tsbf2hbQZ/9vslw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nZUlHx2DbzBOgObNRDW9yAShRCiESzb8KMqz5totw0I=;
 b=XnMdgDwJJPbbBxDk6sLC37QFzUP0GzxISLLppm2JAbovxWsfMY5WRCdrzrmW85fkCtWVY7hur6oeiU8sVOhjA8pZO7byUNzg9Aju2GVCSIgW4CC7z0wuJq0PaASRSD2x7wFWM4Bo1inNPLyzINRD/eGaVUEgn4BLVe6OlDl5EYmLkJmzfIxoVqhdyqak8mNryNcbRDObiz0wkys9IqQfOwvOwAQbYMJFxajn26Rcq0u3GK92o7PXVVqYToUXzMOhlLNHy07unzMfjo/fDCl2DO+kxzuO7P/Qj5544ekqxQ1QETZ+gb6Lo4vs5mpgU1paJel9Jjh6yPSeQ9D/CeXUeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com (2603:1096:403:6::12)
 by TYWPR01MB10983.jpnprd01.prod.outlook.com (2603:1096:400:394::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.15; Fri, 13 Dec
 2024 08:15:38 +0000
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::d9ba:425a:7044:6377]) by TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::d9ba:425a:7044:6377%5]) with mapi id 15.20.8251.008; Fri, 13 Dec 2024
 08:15:38 +0000
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Li Zhijian via
 <qemu-devel@nongnu.org>
CC: Fan Ni <fan.ni@samsung.com>
Subject: Re: [PATCH] hw/cxl: Fix msix_notify: Assertion `vector <
 dev->msix_entries_nr`
Thread-Topic: [PATCH] hw/cxl: Fix msix_notify: Assertion `vector <
 dev->msix_entries_nr`
Thread-Index: AQHbTHOkzqRZQlbfa0C/tJrgYkhtTrLigosAgAFQ+2Y=
Date: Fri, 13 Dec 2024 08:15:37 +0000
Message-ID: <TY1PR01MB1562C56B0C616DE986382970A5382@TY1PR01MB1562.jpnprd01.prod.outlook.com>
References: <20241212085534.2669377-1-lizhijian@fujitsu.com>
 <20241212120232.000056a9@huawei.com>
In-Reply-To: <20241212120232.000056a9@huawei.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Enabled=True;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SiteId=a19f121d-81e1-4858-a9d8-736e267fd4c7;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SetDate=2024-12-13T08:15:37.318Z;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Name=FUJITSU-RESTRICTED;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ContentBits=0;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY1PR01MB1562:EE_|TYWPR01MB10983:EE_
x-ms-office365-filtering-correlation-id: 1aeb77ad-f2ff-40ca-69a4-08dd1b4e538e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|38070700018|1580799027; 
x-microsoft-antispam-message-info: =?gb2312?B?WGxvSy9NY2ZOaVF4RTIwM2NRS3RGTXZQaVdvU3VCRWVOeEV1WEVhcXpCZzVP?=
 =?gb2312?B?aFh6dXpEN0VlQjJBdW94QlNJekl3K25XQm01aENNc2NBek0rNUZ0TXFBK2RM?=
 =?gb2312?B?VmM1ZUN1a0gxSk9ibDJ1M3NVZTlNRHQxeTlkMlplbDZ1eXBPc2pjWXdGUFIz?=
 =?gb2312?B?c2ttQ1dkRjZMMXNNV2tncjVMeWNvbE91UUt1RUI5NzMvRHl2NjI3c245SjM3?=
 =?gb2312?B?N3NjYVRBQ3I5VmJSa041b3RnZ1JuNnp2cmZ5bGlqcHR3M1lMcnI0dUxyUE83?=
 =?gb2312?B?T2thL1p5OXVhRlltMk1hV2crTjk5SHpoeHJwaDVIckp6RlJpTFBkL1RISm5Q?=
 =?gb2312?B?M3ZGQ3NlWkgvdkErZXhIMjZ1RTRvNkZXT0ViWFptb0FCYUo1VTZMVWhlOUFX?=
 =?gb2312?B?dFFlbWo0TFBlOVZOeElacWtGRWl4Rm9JQVRnMWROUEVDZmMvU3d1VGY0clV5?=
 =?gb2312?B?VDRpeldGVmZiTEpHWGxXeE90VWZlQmxXYnRsNkYraURGOTdHRzk3UWpHTlZw?=
 =?gb2312?B?aC9ESjlScllxUnlIWEluRWo5N2EzWlJONTlJZUFqbW5ERDdCbzJoS0hyNEFi?=
 =?gb2312?B?cU5IZFhLaVRxUUo5M1FlbEpxcjh3NjlZc0VOTzNUMWlhQXFDdmJiZGlYbCtF?=
 =?gb2312?B?T0F5ZlMyNjY4TW9SRSs1VHgwQk5iVVQ0bWdnSGZMT2ZTdzdLMkNrL0tKZkNL?=
 =?gb2312?B?d29FdkdkSFNRYUZRUDNlTkk4cUhOeFhpZUlVeXZmdTRYNDJaWllhUWVrMlZr?=
 =?gb2312?B?ZmVUaHVXQXJVY1pZb2xaalNGRGZRc1NBVWpYSTRmclpFUDdheFc3dWZUaHVZ?=
 =?gb2312?B?WUJoNG1lYkhZSDhGNG9HMVozdkdWSnY3RTk0ZC9FUTFDa1FzSTRPU0tOU3Fm?=
 =?gb2312?B?RDM0RGQxUWdtMm5IaXpaaVFvTGdpUWh5cDU3WDI3MGpuSGdaODVGazRvR201?=
 =?gb2312?B?RWpUS2JmYU1oaE5ETDNuMXZzWXNRS3c1bUxLNE9mVDBwb0V4a25DQnE4bjZr?=
 =?gb2312?B?VHY4b0ltSWxCNkZFUHdpYjd2Tk4wazZUUzM5Ym52emRZMEpkbUFoVUV5dTR3?=
 =?gb2312?B?a0ROK1BBVmI3UzJnZng4cWFUL3Brb2Jpay9rYi9XMWxvYXhpQjZUSjIxcXdT?=
 =?gb2312?B?eTdaSDU1a0NpUHVwV29xVzlzZTAwekFZRGhONG9NaW1MdW0wVnZXa1Y3MEwv?=
 =?gb2312?B?a2FaRkRrRXRlN1FhV0tjYW1kQ0xUQTlaNG02NlY5VnVxRlpOVHM5Y3BDeGlp?=
 =?gb2312?B?dUdWRVR6Z1FKWENvdlZYc0F4RnpkeDdQRWJ2ZENGakFQb3lHdFdrUW1qKzNm?=
 =?gb2312?B?LzYrS1k5SWU1eHFhZ0JlaUgxaCtRM0kyMzBRSHJXT1NidWFXN3YrMEpsU3Bs?=
 =?gb2312?B?bE1hSStMNEhvSFFTRHhnck5ibE1yV2JpWVNLWTRpc0pNVzBXakNUSFFzcjNi?=
 =?gb2312?B?TUtEeG9JZzA1VDdxYllXZG5GdnFLQk5OcWFSYjZVT0pkUTVXM1hzTWFFTi9o?=
 =?gb2312?B?d1VjZUF3QmNyVHpCdVhtLy8xRVVoUmJDRlQ3eUlMZ2FLckZYaHZKdnIxNEVB?=
 =?gb2312?B?MTE5TzdLY21JMmxoeUxRMDhrcGZpS1dyQjhLWkQ1Y0dPOU9HTUNrMTc5cUtK?=
 =?gb2312?B?d09wZjlIRWVhZHlBSnBGdVNMUkQrMVdPWEdlNW1pVWdXYkpWTk5ENk9nZTY0?=
 =?gb2312?B?LzBsTXFNWmM2MXl4NkF0ZEJCb241N0oybTVSNmVWaHlqTXdhckc4eFFGQ1NB?=
 =?gb2312?B?djZ5RmcxaU5MNkJmdGludW5QeHRFWnFPNjRlSUlxNlZlQVRPcnJpVHFvN3Jk?=
 =?gb2312?B?Q2RiRXlldUpMbGZ2Z0krb1FxTGpMRGJFOGI3c0ZLd21KR1YvRkZMZmZyUDl5?=
 =?gb2312?B?SnQ3UFlUMnIrYUJqcHhlbEdoUCtkSHVwQVo2OUFZVkNmREdFZnBDOXVhcGp2?=
 =?gb2312?Q?9IIInNIxDyU=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-cn; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:TY1PR01MB1562.jpnprd01.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(376014)(366016)(1800799024)(38070700018)(1580799027);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?UmpIdUh3bmpkTHlpVm5tMG1KVkdOZmd5TmJWeUY1QlcrdlRCc2RycHNUZUdw?=
 =?gb2312?B?enBZaFRTTmo0U0NaV2ZhbjBQNFJlT3A3SWJOZ0RxR0t4N3JKdWdnZXgwektz?=
 =?gb2312?B?amZrL1V5d2JhVGZSMEtjdUJlYWJGWHYyRjhDMWhWeUswS1RjS2tNVUxBWmdY?=
 =?gb2312?B?eFRtcWxCSnM0UVA0T09qZDUzRnRPSjdkQkRJL0JtbWFzdzI1SmRhak0rSkRH?=
 =?gb2312?B?WVpueFUxeGNsQ3I1Y3dKTncwYWk3cHA0UnhHV1QyOW5PUWxCY2owMWVFbS9X?=
 =?gb2312?B?VkZmemR1TXhGZEVUK1pyTlJOaE51M3daTzYwQTQyWjZlTWpYUUd6NkpydThM?=
 =?gb2312?B?ZkZqc1gwOFg2Q1ZPOU1IeWZQNVhoUndubmJaWG8yNnlZaUt4NTV5bU1PaVlO?=
 =?gb2312?B?dzdWTVJsdGx0b2wwckI5cERPU0tMOTlQK3dFNzBTZkZiNTNqTUpKeEJTaWRZ?=
 =?gb2312?B?YktzWmRRNWtKNnFQUTV5TlQxRExzNGMzc1FTSTBTRm4xd3RBYmJpcmhQOUwy?=
 =?gb2312?B?N3NvaEl6V1c1Wm5MZXU2SXhKSUxYSHh1UkdoNEwrZGc5RHNZNGhtNDdqbS8w?=
 =?gb2312?B?R3VXOUlXcU1rY2Y3RzBUMW5oOEsvVXhkQWVNRHlrM3JyTzVEU01OMWxVZkIz?=
 =?gb2312?B?aERSQytqYVNCK25jVUYvSXZCQjQ5a3BLTzdPK2FYbThILzFkeUNXK3VJVnMy?=
 =?gb2312?B?VGdTdncvM2wyZFNIYXFvNlFpRnRlNHl1aCszcEkrbUgwY0ZvNXZBQlR1eDNN?=
 =?gb2312?B?Nko5ZkszY2VSMnlUUFQ0T0ZrT2gwc09ua3kvZ083alZubW1qSXBZYUtXSVdI?=
 =?gb2312?B?TnRaTFpMV3k5L2dxSVpxZEhkZldhKzc4K1lrMTdkZ2pnbkR2WjlCLzZRZlpW?=
 =?gb2312?B?cC9VNFIrU3lFWWg0RVlKSnpsUklOeGhOUUVzUjVMT0dlWjEzc2xiYzhoL1lX?=
 =?gb2312?B?WTBGRFIyelhjbHFSdzJHY01WRmp1bHppUFhIRDFOVG95eG5VZ0ZCSUxlVEgx?=
 =?gb2312?B?K3RmTXNXVVpPK1VKamltY0p0UlRtcUJsNWUrSDJWZ3RYZ3ZNUmZZZlRYbk1s?=
 =?gb2312?B?T2Vhb0d6N3M1Zmt4MEVVUVBjc3cxVWVtZHpPUVFEeWVTcE5TR2pYcnBvTWFl?=
 =?gb2312?B?OGY5OXczWStHT0swSmQ2V0tiZW1hWTE4WC9sZ0xJcGJiZTNDR0NiNzdkY1VJ?=
 =?gb2312?B?VGZ6NmNPMzdLWDN4RVpEYktzMDNNcllOL1ZaaGVTbGlPaFdNemFLYnBoaWVj?=
 =?gb2312?B?VHJBODhWUVhCQU9SN3lPM1ZWQ2FrdklOY0V6aXJQeTEwTjVDUFdGNHFBMGl0?=
 =?gb2312?B?K2sxSThEM1drcGRRb1lqMXE4TXA2eEdLNDM5ejNKMXR5TkZGL3hMbEdxQ2Rq?=
 =?gb2312?B?TXJOeFVCQmZqdzVOdzd5T296VnlkbWl2TTFJSHdzMWNDYW8wcDJ6V2xOMXVW?=
 =?gb2312?B?em80RWRyKzZVUlQ3NEN6U0dSajErd1krMGIxZjVQdFJhK1dtRUFIZ3BFeVdB?=
 =?gb2312?B?dkFmRG8ycmo0em5ocjV2c2U0REdnOFBVQ3ltNkRJRVZaZjRsVkhtSUZWSDV0?=
 =?gb2312?B?eEwrU005b2pSZWRPTUtPNHArbUNmYklXbEN6QmJRUXZLMk11a1VmOEdOemZB?=
 =?gb2312?B?TFZ1T1gzWi9qeEJSL3B4a0g1aFI3eFVwZml0dE9GeHdzK05uRERpYVMvcFBL?=
 =?gb2312?B?ckMvWXYvTXkzNWpHcjhwa0I2RDF5SjNuYzcvMmo2RTZGQ0JWKzBLK0ZPTUtM?=
 =?gb2312?B?S2xHUU5Keldaczlyb3I4WktxbTdDR3BpQ1Z4dUF4Y3dlL2RjWFBHajcyRGdn?=
 =?gb2312?B?enNsQVRJK2JSQVdpYVBUUmI2NGFIUkpJbm5wTGVpdHhxQWl2eUJRZks4U2dU?=
 =?gb2312?B?WW1LTWdUSWIzbjNzRGx6ODkyTXB6Q1hvRnY1bEdkWW84MzFvZ3k0N3g2MzFW?=
 =?gb2312?B?M3NSK2oxQkd4dTdOWGFMbXBGY09QejA2a0hLWHZlbVFFejJSL3hhNk9EZU9m?=
 =?gb2312?B?eWJHMlg5WFZyd3JoR1Vhb3FkOGxJaWkwOSsxMlFENjBGWk85VlBJcGtuL2lk?=
 =?gb2312?B?ZHhPY01nZm4wc3B6c0dHNm9CL0xlRlRLbWwvemJUZGlmOUZYU2dXbkRHeVgx?=
 =?gb2312?Q?8hR5RIGRYtbin8yDwA6HpuYDk?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: RCjlJCdW+EpK4Nwadej39knb/jLePG694EdY4bNplSmgauqHsmhL9Mn4ZsXzPh20e8E0SpL6F/UEhXaH2054Bv7c7Fz7dwlcZaOrrnexImODyDtnar36GvbF7Ek8doCsu8oEZkI1VL7HBGxlDUQUWBbneR1R+5udaiZERaxbRbFT/8qa/9lj4buSUQNmRjhStfTEm4JyglU0C8dgcYMR2BC5Cn6+91GxCx/mfpD1FMGYNeF509aqdG4jDDPq7TPFWLutYRfUA6QIy3xtluofizTQJDIYkdqPcIODtAdnnHceet+eV6wY2VRAQdqYy1BT7zV9zVs+bUR049hsjty7ta2yNPQjISN7FCsb/8eW9F5a+NAs6afiCSBKRq1YLiOUnSmqXEMRLWBE1xzz07hzUFp486r+cr701w5bPh6LIHes685XyB9Iuj604kmZ59us/+RZWBWo+moWDoiGJaLjWvM9LttcB/uoVlJGkEulpd4ULXY8Ac8jIKD9WoM433o7Yw83wddx+654RSVQv+VO0wu3AbPKe9Oo69IotPfZGgKV9x8IT8wFjqvTBydXRHVEgR3kBqvtboklX2O2wmiwZmPqCmPMS7mfS6HmpX63zz6FBz0IWSWNWzeVrT3rSWGu
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY1PR01MB1562.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1aeb77ad-f2ff-40ca-69a4-08dd1b4e538e
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Dec 2024 08:15:37.9552 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NxQRGia9Msf8Ry7whxg/H1npmeghH1Yrz2erjeYdrin5dD4tsjha3Z09QxJL5sFyoy9T82oL7P80uL7H46oiSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB10983
Received-SPF: pass client-ip=216.71.158.33; envelope-from=lizhijian@fujitsu.com;
 helo=esa16.fujitsucc.c3s2.iphmx.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

PkZyb206IEpvbmF0aGFuIENhbWVyb24gPEpvbmF0aGFuLkNhbWVyb25AaHVhd2VpLmNvbT4KPlNl
bnQ6IFRodXJzZGF5LCBEZWNlbWJlciAxMiwgMjAyNCAyMDowMgo+Cj5PbiBUaHUsIDEyIERlYyAy
MDI0IDE2OjU1OjMzICswODAwCj5MaSBaaGlqaWFuIHZpYSA8cWVtdS1kZXZlbEBub25nbnUub3Jn
PiB3cm90ZToKPgo+PiBUaGlzIGFzc2VydGlvbiBhbHdheXMgaGFwcGVucyB3aGVuIHdlIHNhbml0
aXplIHRoZSBDWEwgbWVtb3J5IGRldmljZS4KPj4gJCBlY2hvIDEgPiAvc3lzL2J1cy9jeGwvZGV2
aWNlcy9tZW0wL3NlY3VyaXR5L3Nhbml0aXplCj4+Cj4+IEl0IGlzIGluY29ycmVjdCB0byByZWdp
c3RlciBhbiBNU0lYIG51bWJlciBiZXlvbmQgdGhlIGRldmljZSdzIGNhcGFiaWxpdHkuCj4+Cj4+
IEV4cGFuZCB0aGUgZGV2aWNlJ3MgTVNJWCB0byAxMCBhbmQgaW50cm9kdWNlIHRoZSBgcmVxdWVz
dF9tc2l4X251bWJlcigpYAo+PiBoZWxwZXIgZnVuY3Rpb24gdG8gZHluYW1pY2FsbHkgcmVxdWVz
dCBhbiBhdmFpbGFibGUgTVNJWCBudW1iZXIuCj4+Cj4+IEZpeGVzOiA0M2VmYjBiZmFkMmIgKCJo
dy9jeGwvbWJveDogV2lyZSB1cCBpbnRlcnJ1cHRzIGZvciBiYWNrZ3JvdW5kIGNvbXBsZXRpb24i
KQo+PiBTaWduZWQtb2ZmLWJ5OiBMaSBaaGlqaWFuIDxsaXpoaWppYW5AZnVqaXRzdS5jb20+Cj4K
PkhpLgo+Cj5UaGFua3MgZm9yIHRlc3RpbmcgKyB0aGUgZml4Lgo+Cj5UaGlzIGxvb2tzIGxpa2Ug
YSAgbWVzcyB1cCBieSBtZSBkdWUgdG8gcmVvcmRlcmluZyBwYXRjaGVzLgo+SW4gdGhlIGZpcnN0
IGluc3RhbmNlLCB0aGUgZml4IHNob3VsZCBqdXN0IGJlIHRvIGluY3JlYXNlIG1zaV9uIChrZWVw
IGl0IG1pbmltYWwpCj4KCkl0IHNvdW5kcyBnb29kIHRvIG1lLgoKCj5UaGUgcmVmYWN0b3IgdG8g
dXNlIGFuIGFsbG9jYXRvciBtYXkgbWFrZXMgc2Vuc2UgYXMgYSBmb2xsb3cgdXAsIGJ1dCBuZWVk
cwo+dG8gYmUgdXNlZCB1bml2ZXJzYWxseSBmb3IgYWxsb2NhdGlvbiBvZiBlYWNoIG1zaXgsIG5v
dCBqdXN0IGZvciB0aGUgbGF0ZXIKPm9uZXMuICBIb3dldmVyLCBpdCBtYXkgYmUgc2ltcGxlciB0
byBqdXN0IHVzZSBhbiBlbnVtIHdpdGggYSBfTUFYIGZpbmFsCj5lbnRyeSB0byBlbnN1cmUgd2Ug
YWxsb2NhdGUgdGhlIHJpZ2h0IG92ZXJhbGwgbnVtYmVyLiAgVGhlc2UgYXJlIGZpeGVkCj5udW1i
ZXJzIGFuZCBhIHJlc3RyaWN0ZWQgcmVzb3VyY2UsIHNvIGR5bmFtaWMgYWxsb2NhdG9yIGlzIHBy
b2JhYmx5IHVubmVjZXNzYXJ5LgoKQWdyZWVkLgoKCj4KPkxvbmdlciB0ZXJtIHdlIG5lZWQgdG8g
c3BlbmQgc29tZSB0aW1lIG9uIGF1dG9tYXRlZCB0ZXN0cyBzbyB0aGlzIHNvcnQgb2Ygc2lsbHkK
PmJ1ZyBkb2Vzbid0IGhhcHBlbiBpbiBmdXR1cmUgOigKCkFncmVlLCBJIHdpbGwgYWxzbyBjb25z
aWRlciBhdWdtZW50aW5nIHRoZSB0ZXN0cyBmb3IgQ1hMLgoKVGhhbmtzClpoaWppYW4KCj4KPlRo
YW5rcywKPgo+Sm9uYXRoYW4KCgo+IC0tLQo+ICBody9jeGwvY3hsLWRldmljZS11dGlscy5jICAg
fCAgMyArKy0KPiAgaHcvbWVtL2N4bF90eXBlMy5jICAgICAgICAgIHwgMTUgKysrKysrKysrKysr
KystCj4gIGluY2x1ZGUvaHcvY3hsL2N4bF9kZXZpY2UuaCB8ICAyICsrCj4gIDMgZmlsZXMgY2hh
bmdlZCwgMTggaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKPgo+IGRpZmYgLS1naXQgYS9o
dy9jeGwvY3hsLWRldmljZS11dGlscy5jIGIvaHcvY3hsL2N4bC1kZXZpY2UtdXRpbHMuYwo+IGlu
ZGV4IDAzNWQwMzRmNmQuLjhlNTJhZjY4MTMgMTAwNjQ0Cj4gLS0tIGEvaHcvY3hsL2N4bC1kZXZp
Y2UtdXRpbHMuYwo+ICsrKyBiL2h3L2N4bC9jeGwtZGV2aWNlLXV0aWxzLmMKPiBAQCAtMzU0LDgg
KzM1NCw5IEBAIHN0YXRpYyB2b2lkIGRldmljZV9yZWdfaW5pdF9jb21tb24oQ1hMRGV2aWNlU3Rh
dGUgKmN4bF9kc3RhdGUpCj4KPiAgc3RhdGljIHZvaWQgbWFpbGJveF9yZWdfaW5pdF9jb21tb24o
Q1hMRGV2aWNlU3RhdGUgKmN4bF9kc3RhdGUpCj4gIHsKPiAtICAgIGNvbnN0IHVpbnQ4X3QgbXNp
X24gPSA5Owo+ICsgICAgdWludDhfdCBtc2lfbiA9IGN4bF9yZXF1ZXN0X21zaV9udW1iZXIoKTsK
Pgo+ICsgICAgYXNzZXJ0KG1zaV9uID4gMCk7Cj4gICAgICAvKiAyMDQ4IHBheWxvYWQgc2l6ZSAq
Lwo+ICAgICAgQVJSQVlfRklFTERfRFAzMihjeGxfZHN0YXRlLT5tYm94X3JlZ19zdGF0ZTMyLCBD
WExfREVWX01BSUxCT1hfQ0FQLAo+ICAgICAgICAgICAgICAgICAgICAgICBQQVlMT0FEX1NJWkUs
IENYTF9NQUlMQk9YX1BBWUxPQURfU0hJRlQpOwo+IGRpZmYgLS1naXQgYS9ody9tZW0vY3hsX3R5
cGUzLmMgYi9ody9tZW0vY3hsX3R5cGUzLmMKPiBpbmRleCA1Y2Y3NTRiMzhmLi5kYmIxMzY4NzM2
IDEwMDY0NAo+IC0tLSBhL2h3L21lbS9jeGxfdHlwZTMuYwo+ICsrKyBiL2h3L21lbS9jeGxfdHlw
ZTMuYwo+IEBAIC04MzUsNiArODM1LDE5IEBAIHN0YXRpYyBET0VQcm90b2NvbCBkb2VfY2RhdF9w
cm90W10gPSB7Cj4gICAgICB7IH0KPiAgfTsKPgo+ICsjZGVmaW5lIENUM19NU0lYX05VTSAxMAo+
ICt1bnNpZ25lZCBzaG9ydCBjeGxfcmVxdWVzdF9tc2lfbnVtYmVyKHZvaWQpCj4gK3sKPiArICAg
IGNvbnN0IHVuc2lnbmVkIHNob3J0IHN0YXJ0ID0gNjsKPiArICAgIHN0YXRpYyB1bnNpZ25lZCBz
aG9ydCBuZXh0ID0gc3RhcnQ7Cj4gKwo+ICsgICAgaWYgKG5leHQgKyAxID49IENUM19NU0lYX05V
TSkgewo+ICsgICAgICAgIHJldHVybiAtMTsKPiArICAgIH0KPiArCj4gKyAgICByZXR1cm4gKytu
ZXh0Owo+ICt9Cj4gKwo+ICBzdGF0aWMgdm9pZCBjdDNfcmVhbGl6ZShQQ0lEZXZpY2UgKnBjaV9k
ZXYsIEVycm9yICoqZXJycCkKPiAgewo+ICAgICAgRVJSUF9HVUFSRCgpOwo+IEBAIC04NDMsNyAr
ODU2LDcgQEAgc3RhdGljIHZvaWQgY3QzX3JlYWxpemUoUENJRGV2aWNlICpwY2lfZGV2LCBFcnJv
ciAqKmVycnApCj4gICAgICBDb21wb25lbnRSZWdpc3RlcnMgKnJlZ3MgPSAmY3hsX2NzdGF0ZS0+
Y3JiOwo+ICAgICAgTWVtb3J5UmVnaW9uICptciA9ICZyZWdzLT5jb21wb25lbnRfcmVnaXN0ZXJz
Owo+ICAgICAgdWludDhfdCAqcGNpX2NvbmYgPSBwY2lfZGV2LT5jb25maWc7Cj4gLSAgICB1bnNp
Z25lZCBzaG9ydCBtc2l4X251bSA9IDY7Cj4gKyAgICB1bnNpZ25lZCBzaG9ydCBtc2l4X251bSA9
IENUM19NU0lYX05VTTsKPiAgICAgIGludCBpLCByYzsKPiAgICAgIHVpbnQxNl90IGNvdW50Owo+
Cj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvaHcvY3hsL2N4bF9kZXZpY2UuaCBiL2luY2x1ZGUvaHcv
Y3hsL2N4bF9kZXZpY2UuaAo+IGluZGV4IDU2MWIzNzVkYzguLjYyMjI2NWY1MGUgMTAwNjQ0Cj4g
LS0tIGEvaW5jbHVkZS9ody9jeGwvY3hsX2RldmljZS5oCj4gKysrIGIvaW5jbHVkZS9ody9jeGwv
Y3hsX2RldmljZS5oCj4gQEAgLTY4MCw0ICs2ODAsNiBAQCB2b2lkIGN0M19jbGVhcl9yZWdpb25f
YmxvY2tfYmFja2VkKENYTFR5cGUzRGV2ICpjdDNkLCB1aW50NjRfdCBkcGEsCj4gICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgdWludDY0X3QgbGVuKTsKPiAgYm9vbCBjdDNfdGVz
dF9yZWdpb25fYmxvY2tfYmFja2VkKENYTFR5cGUzRGV2ICpjdDNkLCB1aW50NjRfdCBkcGEsCj4g
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB1aW50NjRfdCBsZW4pOwo+ICt1bnNp
Z25lZCBzaG9ydCBjeGxfcmVxdWVzdF9tc2lfbnVtYmVyKHZvaWQpOwo+ICsKPiAgI2VuZGlmCgo=

