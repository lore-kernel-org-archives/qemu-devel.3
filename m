Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D5B4C98306
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2026 04:02:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9x8A-0007fD-Bb; Fri, 25 Sep 2026 00:01:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=721c190f3=Alistair.Francis@wdc.com>)
 id 1x9x89-0007ei-7V; Fri, 25 Sep 2026 00:01:49 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=721c190f3=Alistair.Francis@wdc.com>)
 id 1x9x87-0007Nr-8p; Fri, 25 Sep 2026 00:01:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1790308907; x=1821844907;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=djxIK2MBhRREVbRFKFSe4jhDBtQHSlpXa/Lvuu8eePA=;
 b=Q6opyctUDe3FRGYuYgMNcHb6DjdqWCcFabaCde762VEBnjMLCZ7nu6yB
 I6LLBYisOirBRmaphKjOhYZ1giKZmbQFFFZRZUWOnSaiZIPZ0LpxHGBbd
 oYGhnBTF8AxBvKHehP1Ye9LKqKBl7oFhzXkIOSfeScR4p0whXCDl7+CGS
 7/5dCBQKXbbgPaoYHdeuO+z1xM/GOA+FD5rrhIDKAbp0gNTq2xc312/V0
 5gojStGclcMeKZBEQVhVcGsyMqvl7LN9vrLeFCK2h7MKZtTzkGUxlLU9+
 qA2z1o3++D31xr941ZVs+gH110nfYvn6UeR9iwCQr7eeoRveHd+Fdz+1P g==;
X-CSE-ConnectionGUID: EoQ8AvjKT0mb4EAI7kJQMg==
X-CSE-MsgGUID: aQan7WWdQ9aaScaUdnMMLg==
X-IronPort-AV: E=Sophos;i="6.27,121,1786982400"; d="scan'208";a="157452332"
Received: from mail-westusazon11012051.outbound.protection.outlook.com (HELO
 SJ2PR03CU001.outbound.protection.outlook.com) ([52.101.43.51])
 by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 25 Sep 2026 12:01:44 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GaKUC/2txBUOOMO93WsCgtgTaskIyvIoEywMJ1HLXk7SRWE9HWoMukr9RMYgwmniCjl6vtw5Ea8V3233YVUJkpkcYqNPkAgCtKTTerxQZbHowHVoRAfOuzov+cYz+hSwy40VegatkrqodiTDXLWHMdvioxzEosZZa065g06QNRX9HQk1rX/vZk8RBuQ2m+GLfhYbOYGvY3VAY83UlRn+F/Cv+6LhE0VkN8caOVBYyP9I5GO6RW8azOZzeAjliRc7hOlqocvki7NtyDBmfxEmQZx/uKBZ/V92SMp8SCdYimx4u11cEq2eyYUQXR1Aa64LUL5oXRrPwxaAJe5oca5CUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=djxIK2MBhRREVbRFKFSe4jhDBtQHSlpXa/Lvuu8eePA=;
 b=M5M+xGnCh/yauFfVteRuvNC5fQZdPxL+13HGHcLf+QxcN4GwjRfNlNPnYKtahd52s3ZuXEb6zQZ38gUBs0K7fqNjr4jN6/4KTlKcxidQe1Yn+6VzhumRa+WEjnrsYAEggKZq4eoJSZsrR2TlXY0W0YXKdznp1+x3ExyXA5BKsC6kKDjTnjgu+1Bq2Oef7VDrYAh2KjA3Jwy8//wGWWqBzT+OVRF6FE//kgnzIX+/7n/JxFTQiHV8T0xuHob9jWVBRmYqzXSRG9Dta0zUIKi6yxfHqLbEflFo01dfKpxtAoSanfeH7Bwc9V2/NnxCp21iGIvTPgV6eXSOpGWQf3bNoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=djxIK2MBhRREVbRFKFSe4jhDBtQHSlpXa/Lvuu8eePA=;
 b=fddXx7Hse8QoYOXuxPO3cVFD/Ut08Qe/Pyi6ZQP8Jq3NKGsxYCXQ95b3XxjCfhN+fVwz9YwotLY47ox3B8Yqya+iJbrhoziMZfmBEO8a/HrBw2q+IFl2yE+ewJwCLtB/MzouCX1zmk1yyQaEPF8nmLfyl1lZVw/MDRifbtF2JBk=
Received: from BY1PR04MB9561.namprd04.prod.outlook.com (2603:10b6:a03:5b6::11)
 by CH0PR04MB8194.namprd04.prod.outlook.com (2603:10b6:610:f9::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Fri, 25 Sep
 2026 04:01:40 +0000
Received: from BY1PR04MB9561.namprd04.prod.outlook.com
 ([fe80::3869:e494:2fa8:9888]) by BY1PR04MB9561.namprd04.prod.outlook.com
 ([fe80::3869:e494:2fa8:9888%6]) with mapi id 15.21.0451.014; Fri, 25 Sep 2026
 04:01:40 +0000
From: Alistair Francis <Alistair.Francis@wdc.com>
To: "marcandre.lureau@redhat.com" <marcandre.lureau@redhat.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>, "farosas@suse.de"
 <farosas@suse.de>, "pierrick.bouvier@oss.qualcomm.com"
 <pierrick.bouvier@oss.qualcomm.com>, "almer@dabbelt.com" <almer@dabbelt.com>, 
 "visitorckw@gmail.com" <visitorckw@gmail.com>, "lvivier@redhat.com"
 <lvivier@redhat.com>
CC: "wxchen0913@gmail.com" <wxchen0913@gmail.com>, "marscheng@google.com"
 <marscheng@google.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "daniel.barboza@oss.qualcomm.com" <daniel.barboza@oss.qualcomm.com>,
 "jserv@ccns.ncku.edu.tw" <jserv@ccns.ncku.edu.tw>, "qemu-riscv@nongnu.org"
 <qemu-riscv@nongnu.org>, "chao.liu@processmission.com"
 <chao.liu@processmission.com>, "zhiwei_liu@linux.alibaba.com"
 <zhiwei_liu@linux.alibaba.com>, "eleanor15x@gmail.com"
 <eleanor15x@gmail.com>, "liwei1518@gmail.com" <liwei1518@gmail.com>
Subject: Re: [PATCH v4 5/7] tests/qtest: Add qtest for Milk-V Duo board
Thread-Topic: [PATCH v4 5/7] tests/qtest: Add qtest for Milk-V Duo board
Thread-Index: AQHdMm6Xjoaj8y2bFk+rxzn/DWKF+rbe4EUA
Date: Fri, 25 Sep 2026 04:01:40 +0000
Message-ID: <f8e5f2865e31de583f3c8538006df6665496c031.camel@wdc.com>
References: <20260822194315.2550260-1-visitorckw@gmail.com>
 <20260822194315.2550260-6-visitorckw@gmail.com>
In-Reply-To: <20260822194315.2550260-6-visitorckw@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.60.2 (by Flathub.org) 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY1PR04MB9561:EE_|CH0PR04MB8194:EE_
x-ms-office365-filtering-correlation-id: bcd474e0-4fb8-4a2f-7318-08df1ab9b46e
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|19092799006|376014|7416014|23010399003|366016|10070799003|22082099003|18002099003|3023799007|38070700021|11063799006|56012099006|10067099003|4143699003;
x-microsoft-antispam-message-info: sHYOFMYpjavU7O+eHYdZsmNP8FWgTBS5F4XKdKhu+/WC/rcOk8v1Ek+UYiBgKq0LbLjQKyEbLaE75mU3e7coxPR8Z15e4EHMpm3OhzWDhL9mkrfrzCgTmKX+LZODQaOjF9f5OVRoVS7f4wX7P4dR7iPcXUdfxitOYx9xBC6bGbaAcEjV+oNO/cj48cxNsm94OZB43F9yU83iyxhUXdHc09Xrg+hMBFCadw518MRCpMDQLX1/F3cwDHcE7pE8qX77ldOiK1WY03Anrmdur9mFLs2dr0vGVlUuNtbbv5pI5VWxraVLb15iKISLsCKRq2p9WtabCqALAuJfHtO5l4jigIDZQh73qmDT9TyfR2T+WZD2YQaTIkE1SRzgeP3SEdVXju9D75wqBdkIPEQg1orE+JbdEyLdBT2Q2BP67xCGFTG6NvbDNy677n4f1+RaT315tcRh0gdrERwtAMCiPqptYRq4VHREnn1lQcI4UdmPq9anoJiOLToN0fmgi+6AoXBL+qr00/YBE6MopRLshE0fOht6WqUr1FHhGFj8Dq+PgQ8Zd/Rtuud9QWS8+L338fAgaNWtog0i6wCglF6roZPWxkHLOwB8m/C7n22zDIKEQ3VOD/6Tcj9PViy+fU+SCB73qWeZ5HLXZEGsMyuZQPNSSBKpG4LbppO3Ek9jX18wd9a/FQ2XW7snTZc/66Rx3mPN+oIo5WFQjoG+IorGfSkAJicuCHBcMif4KWd2XHAuZIw=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY1PR04MB9561.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(19092799006)(376014)(7416014)(23010399003)(366016)(10070799003)(22082099003)(18002099003)(3023799007)(38070700021)(11063799006)(56012099006)(10067099003)(4143699003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SGVKN0RPQ2tSSEtyVkFZQ0FCa1k1UWp5dTYwNmxEakt2K1Q2QTkxNGk0MWo5?=
 =?utf-8?B?cTd0WC9FTHlObnlFcEFTNjFwV0MyeW5EcHpxWUhoMytrREdlQXh0ZU9ldGFD?=
 =?utf-8?B?di9rRUZGeldLbEhZWTlIRXJmVFhZelA2aU9DaGU2WnVEQXBjTVg2V01HTWhn?=
 =?utf-8?B?bWtablBhWlhOODFpcXhuMWRvUDJ6WlZYME5WNnRudnp6Mzk5czRwZXhSd3dG?=
 =?utf-8?B?bkNYU1JrM3h0SjRYVE5Nalhwa0xHTmpzbUJKODhKNENPeWVkUUNuSUxZSXlj?=
 =?utf-8?B?SG40Y3ZtSDVORGYzS0c3SERFQ1plbGo4ZjFNNGVPUVVXeEtUQW01QklaV1g0?=
 =?utf-8?B?VWw2TG9aYk9WVG5ZN0Jwazl5VnNBZXVNWFNwcXg1N3VrQzc2dlVVK1h6alFH?=
 =?utf-8?B?QzJQZWhqVjhaeTh4dFN2bmQ2M2dCYjVPSlBWeGtxYnpSdEcwbC9xdWhUYzRL?=
 =?utf-8?B?c0hMcHoxUnpvRE5EUEtJaUY0MGFkaUJGSTYxM2t3ak56VXhTcnpDc1B6WUMr?=
 =?utf-8?B?amgwWWVReElaam5EMmlHcVF5RzgrTjVmdWN2dXlPQVY3b2tGYmtQdk05emRo?=
 =?utf-8?B?TFJ0amNEV2dzWjZ2V0h0Vyt4LzJWVXVoSnZ1S3QyRXlJSjRFUXZTYWllVnpx?=
 =?utf-8?B?WXhyRjU0UjBlYzM2SjRFRXpoUmlQc0t5am55ZmorNGVxcXBxWlIxdlZ0SzYv?=
 =?utf-8?B?U3IyRXAwRWpCQlA2OEtnVktJU05uTjlPUWJmdzE1VDRldTNjN09tRHRUbDVu?=
 =?utf-8?B?Ni9jNzAvNnNsU1EyUHVCSVdTbXVNSHFXQkRiZ3IreHBPYVJtMFdVWUh0a3hF?=
 =?utf-8?B?NGFKMUNidEFTSHBYTjVBNXdBWlNKTHJUckF1SVBlUkcyZFc2c1N1S2hyYkgz?=
 =?utf-8?B?MHQ4N0tqS1JhZVpSSUpLY1FBM2RzSTFyWUo4OElBU3h1TDBmTVp4QlVnU3Fj?=
 =?utf-8?B?T25ibzg3eVpWblJ5N2dhSFpBbW9OZDZtL2ZreXZCeXkvdmxZZTNpVklQT3pS?=
 =?utf-8?B?UXR2Y2NRelByMFRsWUtnaHVDdFh4VFVLdzNCNzVnRUxRSEg1SnpwN1dBSXdq?=
 =?utf-8?B?RUFxVUNGblhQYkdtVEIrNzE2eTNEVTBuUC9RK1g4U0JHbmEzckk2b08ra2Jw?=
 =?utf-8?B?a1RNMVFqbzlZTkdoSHRjVzRzekdQNXNDc2xaN2dFblRQenFDQ0lmQTZZd1pP?=
 =?utf-8?B?VFR0ZFVXWFZYMEY0WTdQTmdzcXgyQXYxVTBnVFhHcmxycE9yOHRXMlZpbzhz?=
 =?utf-8?B?NldzYlZySEVXUUZoNTVYeDN5d3NhYms0TXVZakdnQkZKWjA1OUZmelVJT3Zw?=
 =?utf-8?B?TzFMcGh2MW53WmZHNnBOZHJKUFNYS25Bbm9zWnV2OUN5NWpFMzc4MmwxdjE5?=
 =?utf-8?B?RGpUVGFYUnE1Z1BWa2ZNT291TUVMbG1vYm9iRFIvQ0hWR0tBM1VKKy85cnpm?=
 =?utf-8?B?ZTVUcWN1WGw2VmwwV254QnM3ZVpqd0RVSHhKNktRVVdPZ1pVcGh3WFFBWlZq?=
 =?utf-8?B?NlJjYUVrb1QvUkcxcjhzOGV5VUVMMStCZ1RwbGphYjMxR3lKT0FGazJhWnhZ?=
 =?utf-8?B?Vk9uU01hK2ZvUjQ4YWwvR2ZaRkx1ZUFlZjA0VGVVSVRoL2cwSGVtUTd1Lzhv?=
 =?utf-8?B?YkJwTUUwaklNS2R0ZDNickRqZnRoU3RxTW9ZOEQ0TExGRVJsR0VpZk5KS0pi?=
 =?utf-8?B?Z1pldWM5L1JLUWs4eENZZ0NYb1NoZWErMHpINDVvdUJzVG5ZU1RXZ29UeC9Z?=
 =?utf-8?B?VFVqWkpOUjZiazErTERWcHJ6YzNKZXZ6SmxTOG1QQk5URG51MGlyTndscUtv?=
 =?utf-8?B?eHRUZzF2cnJjT3NLbm4xZGp0N1U2VFhpMFZmQmhJMk9oSGpFUHcrNGZUUmZv?=
 =?utf-8?B?NlRyTUk2enB2UU1nQW44NzJnc2lsRUgzK1IxelRIeVcrbUV3eUk3aVVIZmJw?=
 =?utf-8?B?R0ptSVU2ekpRMFpicFBMVE9PdEluS2RtUERvbUlWQytqdTF5cDlLVlNLQ2dO?=
 =?utf-8?B?eXBMbDVEV2F1Q2JtdFlZSHQyQWw1VEVISHkvRFJJNytibWZwYXMrRGxqVCt6?=
 =?utf-8?B?SURPVGNRbWZCQ3BlTW1ScUZySkowMVIxRUcvR0c2ZTBEUlZtd2twVWY0bEFo?=
 =?utf-8?B?M29uYk1HZ21uUlRwSGlBNDlBbmVXL09BWk5QZlZOSXBUZDIyNDBUdFBUL1FQ?=
 =?utf-8?B?K2FxaTAvc0pYbXdYcERzQjFwUXRYSWdzbU9aSURrOFdzNWd0VnVrNzNjNUNW?=
 =?utf-8?B?OVBWRVZkVnF5Q0hSb3JFUU1tSjREMXRKYzIzeUNpSTYvWlFZaFFVeEdRYlhW?=
 =?utf-8?B?TkdWcFVQdjVENUdaYk5TZEt2OWNHZks0bWFWV0FQUDlCK00xcVEvK2lPTjA4?=
 =?utf-8?Q?6nel9Ik/2mEdVWez8i8z5/LakighogZS2CgN9b2HLZS/A?=
x-ms-exchange-antispam-messagedata-1: rjJdjv8gdDHqdIBQAhhOvULrZZEBRIfFPus=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6625B2601B0D68489E5F7602CD286B90@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: q7/lYK5arTIVo0x5CpkpaQjkhmQCeoL5CQml88zqEPn6pWdC2NNDMFsiFoGo5lmWnTkkMrFvXCREGPq7lmLOYOL8hFGbA9uYXR8n3qD0NJbAqKSzjXcyh8MwCXOW9J5CbLdOGNXgkDbfB+35Xuq498vb9tM+q4/KSPkN1DJlvyW25hba+PDcJvrFazWNzA2sHYLvmxtVtRCKPdsEONJTBP/lj2x/skH3/Tpn+MAMsez/UxuGDZ0ap8BawozQnXQpOXI2jXt10+UeAdcP3bKlbdA147hi7kIpImLF1RoMhKTs4Es4cUDUixrOYQhjCr/hJIoRYWuV+ItVdpaMR7bsoQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: z+t13iZwJs7xQIjEZ1FvxQc2AbDvUKMMbv1buTeWPDDP28qeWXNJLusjC/4bZGIxNvSLC2QLB4G19/YqoB89dBRJ8AzqlVkH1oNM5EFqWTaGxPVfv+NDuE41TwOafSZ7GtZyp2Bi1kBT0vU/yVf+7iQaWkFIUKAwEmRklQLz5+BjqYlcAnoDUdRptGOAi6isSC5m9YJm046C0nPmxWS0pZnHMPaVe/jMqjf8mh3UyDY4NRm2cQIT0pqj2XoUKf7T/X0tr9wYUBA4BQttZSFdS1kZZGiE2YHMs10X70ilYd7BUZKC1E6J9fER5KuRgS17gkoDaRF7axc0AhplV9TdA4mmLxpm+Dxick8Q8fxhvmNYkKCRIRPABXzQz5EbDC9vin7MXIPT7NOQcc/SMAoRR+8flQXdJGA786qkL31R7LtEBRtf9yrCanmOnkFcKzboLiK+bbPKZUre91mW0c3BPlPPgzNXyryGXfKuKoAl+Jc6ih3ukA5hezgre1UjzLXW1HMaTZfiAeCtWV1U6iyoMoUcK+nHuiWS0357Po51KKi/n2DY6gHVh6smJQRRE7tBrVvByde9dMtNmjrjMxW8WS4JpLUC4h78hEMj8RnaL1jprDe2fjXxMJyZD8beh1FA
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY1PR04MB9561.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bcd474e0-4fb8-4a2f-7318-08df1ab9b46e
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Sep 2026 04:01:40.7806 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EzKFRNNpo0s10wfGXXvj3bVPSyogTRdodNtPfhvth/aqk/RSr477JEKAwaqNoQoKDGyL774oQW8RKvHF33qUYGocIJ4oXmsnIbohAGw7M/A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR04MB8194
Received-SPF: pass client-ip=68.232.143.124;
 envelope-from=prvs=721c190f3=Alistair.Francis@wdc.com;
 helo=esa2.hgst.iphmx.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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

T24gU2F0LCAyMDI2LTA4LTIyIGF0IDE5OjQzICswMDAwLCBLdWFuLVdlaSBDaGl1IHdyb3RlOg0K
PiBBZGQgbWluaW1hbCBxdGVzdCBjb3ZlcmFnZSBmb3IgdGhlIE1pbGstViBEdW8gbWFjaGluZSB0
byB2YWxpZGF0ZQ0KPiBiYXNpYw0KPiBNTUlPIG1hcHBpbmcgYW5kIHJlZ2lzdGVyIGFjY2Vzcy4N
Cj4gDQo+IEN1cnJlbnRseSB0ZXN0ZWQ6DQo+IC0gVmVyaWZ5IERXODI1MCBVQVJUIGNvbXBvbmVu
dCB2ZXJzaW9uIGFuZCB0eXBlIHNpZ25hdHVyZXMuDQo+IC0gVGVzdCByZWFkL3dyaXRlIGFjY2Vz
cyB0byBDVjE4MDBCIGNsb2NrIGJ5cGFzcyByZWdpc3Rlci4NCj4gDQo+IFRlc3RlZCB3aXRoOg0K
PiAkIG1lc29uIHRlc3QgLUMgYnVpbGQgLXYgcWVtdTpxdGVzdC1yaXNjdjY0L21pbGt2LWR1by10
ZXN0DQo+IFsuLi5dDQo+IE9rOsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIDENCj4g
RmFpbDrCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIDANCj4gDQo+IFNpZ25lZC1vZmYtYnk6
IEt1YW4tV2VpIENoaXUgPHZpc2l0b3Jja3dAZ21haWwuY29tPg0KDQpBY2tlZC1ieTogQWxpc3Rh
aXIgRnJhbmNpcyA8YWxpc3RhaXIuZnJhbmNpc0B3ZGMuY29tPg0KDQpBbGlzdGFpcg0KDQo+IC0t
LQ0KPiDCoE1BSU5UQUlORVJTwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8wqAg
MSArDQo+IMKgdGVzdHMvcXRlc3QvbWVzb24uYnVpbGTCoMKgwqDCoMKgIHzCoCAzICstDQo+IMKg
dGVzdHMvcXRlc3QvbWlsa3YtZHVvLXRlc3QuYyB8IDcwDQo+ICsrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKw0KPiDCoDMgZmlsZXMgY2hhbmdlZCwgNzMgaW5zZXJ0aW9ucygrKSwg
MSBkZWxldGlvbigtKQ0KPiDCoGNyZWF0ZSBtb2RlIDEwMDY0NCB0ZXN0cy9xdGVzdC9taWxrdi1k
dW8tdGVzdC5jDQo+IA0KPiBkaWZmIC0tZ2l0IGEvTUFJTlRBSU5FUlMgYi9NQUlOVEFJTkVSUw0K
PiBpbmRleCBkZGU4NWVmNDIwLi4yNDVlYjdiYjU4IDEwMDY0NA0KPiAtLS0gYS9NQUlOVEFJTkVS
Uw0KPiArKysgYi9NQUlOVEFJTkVSUw0KPiBAQCAtMTg2MSw2ICsxODYxLDcgQEAgRjogaHcvcmlz
Y3YvbWlsa3ZfZHVvLmMNCj4gwqBGOiBpbmNsdWRlL2h3L2NoYXIvZHc4MjUwLmgNCj4gwqBGOiBp
bmNsdWRlL2h3L21pc2MvY3YxODAwYl9jbGsuaA0KPiDCoEY6IGluY2x1ZGUvaHcvcmlzY3YvY3Yx
ODAwYi5oDQo+ICtGOiB0ZXN0cy9xdGVzdC9taWxrdi1kdW8tdGVzdC5jDQo+IMKgDQo+IMKgUlgg
TWFjaGluZXMNCj4gwqAtLS0tLS0tLS0tLQ0KPiBkaWZmIC0tZ2l0IGEvdGVzdHMvcXRlc3QvbWVz
b24uYnVpbGQgYi90ZXN0cy9xdGVzdC9tZXNvbi5idWlsZA0KPiBpbmRleCAxMmVkMzY4OTk3Li5k
MDJkYmY3NDMzIDEwMDY0NA0KPiAtLS0gYS90ZXN0cy9xdGVzdC9tZXNvbi5idWlsZA0KPiArKysg
Yi90ZXN0cy9xdGVzdC9tZXNvbi5idWlsZA0KPiBAQCAtMjk5LDcgKzI5OSw4IEBAIHF0ZXN0c19y
aXNjdjY0ID0gWydyaXNjdi1jc3ItdGVzdCddICsgXA0KPiDCoMKgIChjb25maWdfYWxsX2Rldmlj
ZXMuaGFzX2tleSgnQ09ORklHX0lPTU1VX1RFU1RERVYnKSBhbmQNCj4gwqDCoMKgIGNvbmZpZ19h
bGxfZGV2aWNlcy5oYXNfa2V5KCdDT05GSUdfUklTQ1ZfSU9NTVUnKSA/DQo+IMKgwqDCoCBbJ2lv
bW11LXJpc2N2LXRlc3QnXSA6IFtdKSArIFwNCj4gLcKgIChjb25maWdfYWxsX2RldmljZXMuaGFz
X2tleSgnQ09ORklHX0syMzAnKSA/IFsnazIzMC13ZHQtdGVzdCddIDoNCj4gW10pDQo+ICvCoCAo
Y29uZmlnX2FsbF9kZXZpY2VzLmhhc19rZXkoJ0NPTkZJR19LMjMwJykgPyBbJ2syMzAtd2R0LXRl
c3QnXSA6DQo+IFtdKSArIFwNCj4gK8KgwqAgWydtaWxrdi1kdW8tdGVzdCddDQo+IMKgDQo+IMKg
cXRlc3RzX2hleGFnb24gPSBbJ2Jvb3Qtc2VyaWFsLXRlc3QnLCAnbDJ2aWMtdGVzdCcsICdxY3Qt
cXRpbWVyLQ0KPiB0ZXN0J10NCj4gwqANCj4gZGlmZiAtLWdpdCBhL3Rlc3RzL3F0ZXN0L21pbGt2
LWR1by10ZXN0LmMgYi90ZXN0cy9xdGVzdC9taWxrdi1kdW8tDQo+IHRlc3QuYw0KPiBuZXcgZmls
ZSBtb2RlIDEwMDY0NA0KPiBpbmRleCAwMDAwMDAwMDAwLi4wNjA2NGI4NzMzDQo+IC0tLSAvZGV2
L251bGwNCj4gKysrIGIvdGVzdHMvcXRlc3QvbWlsa3YtZHVvLXRlc3QuYw0KPiBAQCAtMCwwICsx
LDcwIEBADQo+ICsvKg0KPiArICogUVRlc3QgZm9yIE1pbGstViBEdW8gQm9hcmQNCj4gKyAqDQo+
ICsgKiBDb3B5cmlnaHQgKGMpIDIwMjYgS3Vhbi1XZWkgQ2hpdSA8dmlzaXRvcmNrd0BnbWFpbC5j
b20+DQo+ICsgKg0KPiArICogU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjAtb3ItbGF0
ZXINCj4gKyAqLw0KPiArDQo+ICsjaW5jbHVkZSAicWVtdS9vc2RlcC5oIg0KPiArI2luY2x1ZGUg
ImxpYnF0ZXN0LmgiDQo+ICsNCj4gKyNkZWZpbmUgQ1YxODAwQl9DTEtfQkFTRcKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgMHgwMzAwMjAwMA0KPiArI2RlZmluZSBDVjE4MDBCX0NMS19CWVBBU1PCoMKg
wqDCoMKgwqDCoMKgwqAgMHgwMzANCj4gKyNkZWZpbmUgQ1YxODAwQl9DTEtfQllQQVNTX1JFU0VU
wqDCoMKgIDB4RkZGRkZGRkYNCj4gKyNkZWZpbmUgVEVTVF9QQVRURVJOXzVBwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIDB4NUE1QTVBNUENCj4gKyNkZWZpbmUgVEVTVF9QQVRURVJOX0E1wqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIDB4QTVBNUE1QTUNCj4gKw0KPiArI2RlZmluZSBDVjE4MDBCX1VB
UlQwX0JBU0XCoMKgwqDCoMKgwqDCoMKgwqAgMHgwNDE0MDAwMA0KPiArI2RlZmluZSBEV19VQVJU
X1VDVsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIDB4RjgNCj4gKyNkZWZpbmUgRFdf
VUFSVF9DVFLCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAweEZDDQo+ICsjZGVmaW5l
IERXX1VBUlRfVkVSU0lPTl8zXzIzQcKgwqDCoMKgwqDCoCAweDMzMzIzMzJBDQo+ICsjZGVmaW5l
IERXX1VBUlRfVFlQRV9TSUdOQVRVUkXCoMKgwqDCoMKgIDB4NDQ1NzAxMTANCj4gKw0KPiArc3Rh
dGljIHZvaWQgdGVzdF9taWxrdl9kdW9fdWFydCh2b2lkKQ0KPiArew0KPiArwqDCoMKgIFFUZXN0
U3RhdGUgKnF0czsNCj4gK8KgwqDCoCB1aW50MzJfdCBjb21wb25lbnRfdmVyc2lvbjsNCj4gK8Kg
wqDCoCB1aW50MzJfdCBjb21wb25lbnRfdHlwZTsNCj4gKw0KPiArwqDCoMKgIHF0cyA9IHF0ZXN0
X2luaXQoIi1NIG1pbGt2LWR1byIpOw0KPiArDQo+ICvCoMKgwqAgY29tcG9uZW50X3ZlcnNpb24g
PSBxdGVzdF9yZWFkbChxdHMsIENWMTgwMEJfVUFSVDBfQkFTRSArDQo+IERXX1VBUlRfVUNWKTsN
Cj4gK8KgwqDCoCBnX2Fzc2VydF9jbXBoZXgoY29tcG9uZW50X3ZlcnNpb24sID09LCBEV19VQVJU
X1ZFUlNJT05fM18yM0EpOw0KPiArDQo+ICvCoMKgwqAgY29tcG9uZW50X3R5cGUgPSBxdGVzdF9y
ZWFkbChxdHMsIENWMTgwMEJfVUFSVDBfQkFTRSArDQo+IERXX1VBUlRfQ1RSKTsNCj4gK8KgwqDC
oCBnX2Fzc2VydF9jbXBoZXgoY29tcG9uZW50X3R5cGUsID09LCBEV19VQVJUX1RZUEVfU0lHTkFU
VVJFKTsNCj4gKw0KPiArwqDCoMKgIHF0ZXN0X3F1aXQocXRzKTsNCj4gK30NCj4gKw0KPiArc3Rh
dGljIHZvaWQgdGVzdF9taWxrdl9kdW9fY2xrKHZvaWQpDQo+ICt7DQo+ICvCoMKgwqAgUVRlc3RT
dGF0ZSAqcXRzOw0KPiArwqDCoMKgIHVpbnQzMl90IGNsa19ieXBhc3NfdmFsOw0KPiArDQo+ICvC
oMKgwqAgcXRzID0gcXRlc3RfaW5pdCgiLU0gbWlsa3YtZHVvIik7DQo+ICsNCj4gK8KgwqDCoCBj
bGtfYnlwYXNzX3ZhbCA9IHF0ZXN0X3JlYWRsKHF0cywgQ1YxODAwQl9DTEtfQkFTRSArDQo+IENW
MTgwMEJfQ0xLX0JZUEFTUyk7DQo+ICvCoMKgwqAgZ19hc3NlcnRfY21waGV4KGNsa19ieXBhc3Nf
dmFsLCA9PSwgQ1YxODAwQl9DTEtfQllQQVNTX1JFU0VUKTsNCj4gKw0KPiArwqDCoMKgIHF0ZXN0
X3dyaXRlbChxdHMsIENWMTgwMEJfQ0xLX0JBU0UgKyBDVjE4MDBCX0NMS19CWVBBU1MsDQo+IFRF
U1RfUEFUVEVSTl81QSk7DQo+ICvCoMKgwqAgY2xrX2J5cGFzc192YWwgPSBxdGVzdF9yZWFkbChx
dHMsIENWMTgwMEJfQ0xLX0JBU0UgKw0KPiBDVjE4MDBCX0NMS19CWVBBU1MpOw0KPiArwqDCoMKg
IGdfYXNzZXJ0X2NtcGhleChjbGtfYnlwYXNzX3ZhbCwgPT0sIFRFU1RfUEFUVEVSTl81QSk7DQo+
ICsNCj4gK8KgwqDCoCBxdGVzdF93cml0ZWwocXRzLCBDVjE4MDBCX0NMS19CQVNFICsgQ1YxODAw
Ql9DTEtfQllQQVNTLA0KPiBURVNUX1BBVFRFUk5fQTUpOw0KPiArwqDCoMKgIGNsa19ieXBhc3Nf
dmFsID0gcXRlc3RfcmVhZGwocXRzLCBDVjE4MDBCX0NMS19CQVNFICsNCj4gQ1YxODAwQl9DTEtf
QllQQVNTKTsNCj4gK8KgwqDCoCBnX2Fzc2VydF9jbXBoZXgoY2xrX2J5cGFzc192YWwsID09LCBU
RVNUX1BBVFRFUk5fQTUpOw0KPiArDQo+ICvCoMKgwqAgcXRlc3RfcXVpdChxdHMpOw0KPiArfQ0K
PiArDQo+ICtpbnQgbWFpbihpbnQgYXJnYywgY2hhciAqKmFyZ3YpDQo+ICt7DQo+ICvCoMKgwqAg
Z190ZXN0X2luaXQoJmFyZ2MsICZhcmd2LCBOVUxMKTsNCj4gKw0KPiArwqDCoMKgIHF0ZXN0X2Fk
ZF9mdW5jKCIvcmlzY3YvbWlsa3YtZHVvL3VhcnQiLCB0ZXN0X21pbGt2X2R1b191YXJ0KTsNCj4g
K8KgwqDCoCBxdGVzdF9hZGRfZnVuYygiL3Jpc2N2L21pbGt2LWR1by9jbGsiLCB0ZXN0X21pbGt2
X2R1b19jbGspOw0KPiArDQo+ICvCoMKgwqAgcmV0dXJuIGdfdGVzdF9ydW4oKTsNCj4gK30NCg==

