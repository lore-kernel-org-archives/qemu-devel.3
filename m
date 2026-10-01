Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CC80CA5FB3
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2026 05:06:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xC8zc-0005FH-Fm; Thu, 01 Oct 2026 01:06:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=727d860e1=Alistair.Francis@wdc.com>)
 id 1xC8za-0005Ez-Qz; Thu, 01 Oct 2026 01:06:02 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=727d860e1=Alistair.Francis@wdc.com>)
 id 1xC8zX-0000FZ-Rk; Thu, 01 Oct 2026 01:06:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1790831159; x=1822367159;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=f6lqjfkcCEKZjWaDPT9uA2Vz/vHaH/7Ibv/N0oEGg+w=;
 b=I+vfXTMwogb7zFkrSf4CwoQ2Ry2Fxk7b+4gPDEhyFeyddEfY+BO+Zexr
 l7eabaZM3tDtk5AQRxX5qOXriCeB8ShUmmoYH0SW7sN9T/Pey7o2CJJqb
 MRlfXOsa+9+xi7kBVciDvW1jbwsHPTKe3oFyKvo7HTp0CDmlbVIiaIrf3
 zI+HUIT1Xrjeptzzl5YzkJgyRa+20bc+Gg5ym6LjJVOLg2tbXiELOgtZr
 EkGR+1VBBk7xtZTzNHHVAmKMn7yHHaa7wAEuPZi6lhRLLEY5RuIJ7tl9m
 2ENM2j8ynR0YlWIFPS8483Z3nwlrkTbtVFFcIDVMcUbFe4PvV8J5+IsNl w==;
X-CSE-ConnectionGUID: pmWRzp41RwiukaW8bE28NA==
X-CSE-MsgGUID: plA5/YkNRaCRR5mcUJPTiQ==
X-IronPort-AV: E=Sophos;i="6.27,134,1786982400"; d="scan'208";a="156047182"
Received: from mail-westus2azon11010041.outbound.protection.outlook.com (HELO
 CO1PR03CU002.outbound.protection.outlook.com) ([52.101.46.41])
 by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 01 Oct 2026 13:05:57 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RWGcevBWcIMxVEuwrtNXdhXWlpRoHPe2Xzh+naefJHwTQSRwd33lasoHrk5VZzOqJ7rZcvS3VXZgrhbr9wu3/WPp52i8CKr2XwpLvCSfgUaBA2VrsAnlD5Wn9SqWO5QcmAFPCiWQqzTsakoUBEmQkBrgcf8HwUnTl53Bdl+QDwZpQtDgiScy9xDU7dUUK08TJi/hxSTJ8QUb1jTrNXEjJ9c0+cGbPZ3kjMKPuDUwc+VMuORuD2JVG351vJBRpqlE5SaRkV5VRu2DZ5CWxPqA/TuEXGQuAu37GOVRNPOxAb5OS5JBaPCseok0vwGB2lw7IEO32eRmX2z4IJV0mW9/Aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f6lqjfkcCEKZjWaDPT9uA2Vz/vHaH/7Ibv/N0oEGg+w=;
 b=ZDGbWJuFqduuim7VeopjKacVv/i0SqTLH7kCbCPiY9AZ8q8XbPhAuK3dI251Uwx0W5wAuMxMpm/BVID8As2dOBvZQVYGK/chQsGJHhwZdzGbRjDfBfAeFtfgch1z7Z2jH+Pl+H5rrIvAdAON0FWqJ6rM7qkIOHekqeFa+TTYiCliJATLKMw+l/GuF0EhfBIXCPMNVSfxxHtzo0Z0yPtSLQ0Q2XkigWDVN5H0xFVY1TMWaIBkApulYZtyKj+DQE9uWwxFkegiMZcAv9D7bybn/L9gjZQ83NYyxEryU8MFlVKJ/y30flbkkL4yD8FxKw+05aXFM+VnP6JafStOGTpX+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f6lqjfkcCEKZjWaDPT9uA2Vz/vHaH/7Ibv/N0oEGg+w=;
 b=FusrxicqKELmQ7waeMO2U4TgSr63l06yZCZu0QJcPCy/UofAfWeT22sEk3l7CRM/BRTCzZwzmmA/88z1rWYOB+sa+1+jGVHOWzJx6u6ScFZ9Qo41V/WYdmIU+xg6Dg4UF90qQzP9fLZU+A4tWXUMRC7ZuGIsmUvs3tBneq7YhRg=
Received: from BY1PR04MB9561.namprd04.prod.outlook.com (2603:10b6:a03:5b6::11)
 by CO1PR04MB8297.namprd04.prod.outlook.com (2603:10b6:303:154::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.15; Thu, 1 Oct
 2026 05:05:55 +0000
Received: from BY1PR04MB9561.namprd04.prod.outlook.com
 ([fe80::3869:e494:2fa8:9888]) by BY1PR04MB9561.namprd04.prod.outlook.com
 ([fe80::3869:e494:2fa8:9888%6]) with mapi id 15.21.0451.026; Thu, 1 Oct 2026
 05:05:54 +0000
From: Alistair Francis <Alistair.Francis@wdc.com>
To: "max.chou@sifive.com" <max.chou@sifive.com>, "qemu-riscv@nongnu.org"
 <qemu-riscv@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "palmer@dabbelt.com" <palmer@dabbelt.com>,
 "daniel.barboza@oss.qualcomm.com" <daniel.barboza@oss.qualcomm.com>,
 "chao.liu@processmission.com" <chao.liu@processmission.com>,
 "liwei1518@gmail.com" <liwei1518@gmail.com>, "zhiwei_liu@linux.alibaba.com"
 <zhiwei_liu@linux.alibaba.com>
Subject: Re: [PATCH v4 0/6] target/riscv: Add SiFive Xsfvqmaccdod/Xsfvqmaccqoq
 int8 matmul extensions
Thread-Topic: [PATCH v4 0/6] target/riscv: Add SiFive
 Xsfvqmaccdod/Xsfvqmaccqoq int8 matmul extensions
Thread-Index: AQHdTlnLqZyb2SfscEqNk5hEoRV5NLboKF2A
Date: Thu, 1 Oct 2026 05:05:54 +0000
Message-ID: <ba2da499b3e410f8e4be9bdd0b27c44963dccd58.camel@wdc.com>
References: <20260927082534.3228237-1-max.chou@sifive.com>
In-Reply-To: <20260927082534.3228237-1-max.chou@sifive.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.62.0 (by Flathub.org) 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY1PR04MB9561:EE_|CO1PR04MB8297:EE_
x-ms-office365-filtering-correlation-id: 8cf024b4-af1f-4684-bdef-08df1f79ac0e
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|19092799006|23010399003|1800799024|376014|10070799003|366016|10067099003|11063799006|56012099006|3023799007|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info: vce84EM2gopp/ZACVUmnGT1F9FFdJFK69yA6atbGhHvUU/4y/H6CKm4CERYdKwskWQAcTXMhz1BvIbSIVthZ1FWilt8PZqBi/CN1R2BzX+ix7Sj7zOLcUv6wIj1N8qXosP7evHHmUIss9eW5fGJosOew3W/A0+25ftuvVxoceeXvyENPyt/b/SiW64mB3xY89b89e8phbd5AxZGEE8EApLTueYYZczdyusnpMMZVKrD5eDFiGy1Mlzdm6SVjcX5hu8Vuq2aOaIL1c/QOoWetVbhc+h9Hb16h+6Fo49li8azCtBqbIeXChoio+vLIkuEW83r2b1UKFrKls3U3YF5wyRLXt/JfuK6HD+/dGQS6cFUCMsJ3f/6mPKGrEBpJrUGODVMEDjsARTso4Ii0xq9t66va+WBpTRs6KVJTNgJnfaGtNCJAi+0VKocbiuvVNdCFl1/iWZbmwV2PoKkwwq5lZECQIOblX+Syt0SHtz7iGsyCfngvj52vTdO4gi2mN228NhtC/zVAzE4bwU0AegXS2+CRKIXD5rPgbXYKKtOw0CQLp6xPiBa2aAm7kJysPxRHFbHL1s7nbYqdJKG/01h7I/m/8/Pu7mm2T0RG2/eVyeQ1wybzO8RG2MJhlL9D/YIh5kIA/+lsfBSVR/7DZ+u5fKKX86k1+fj1nBegvkif7HQ=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY1PR04MB9561.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(23010399003)(1800799024)(376014)(10070799003)(366016)(10067099003)(11063799006)(56012099006)(3023799007)(18002099003)(22082099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZGR5VDdRWUtTMkxraTNCNjQ4WUI1dHZXbzdHbXQ4ckF3ZTJETmhDcGpXb1lV?=
 =?utf-8?B?ZnhaNWhrcmZpVUI4UTRwaWowVWlHRmpMT1BZL3FNTXQ1VE93Qjhha0pGS1Fa?=
 =?utf-8?B?d250aGdONm5JV2hyRVhRWGRIc0VMdmtkeHYxUW80bXNoUzcwcU8xUlFqWTMz?=
 =?utf-8?B?UUVXKzZpNEZqaFgyaW9WdFpvSlF3L3pVL2FlcTRXc3I2TXpCREtZTXBGaWcw?=
 =?utf-8?B?QWhJZERnOTBNZUdxL0FGYnVlY1VRVUhkWEpxeGNadXd5R3p0YnYvOEpNVGwx?=
 =?utf-8?B?cS9WSU9Id2JDYXdEcWlSVDdFTDZ0NVJIMXRlWEJHanI4Tm1IRGpBSmh0b0dR?=
 =?utf-8?B?RnN2cStpVUcvUFF6Z1pDazlrTUtwL0ljanlnd1NSOU1JMlV4WmdxSCthUlB5?=
 =?utf-8?B?NEFMbGdZZ2ttUnpJM0lBZnd2dTVreVJLTkorYWJyMmlSTkxKcXA0bWozTWl4?=
 =?utf-8?B?bnZpM0RCVUI2L1pqUEk1c05heDluZ3dpQUd0Sk5lWWtpSU0waHo2dDdUY2Zx?=
 =?utf-8?B?Q29sUHdGRGJMMzdiaXFZUWNoSnFsQ2JrS2ZJRFhxTWErdHc0dk5VV2phcFVZ?=
 =?utf-8?B?NVNxbGhKK3c0QnlCOEZTZjdxYWxlUVdPdE02Z0ZCNGlzTmhkekF5b09VQjQ0?=
 =?utf-8?B?ZzR5Nk1iUVprV0NwUzBWNnI2Vkl0R1dQOUZLc3BBbG1tZ0Zaam1lL3MwNzBO?=
 =?utf-8?B?Q25RUHZBZFdFTHVjL3B3L1NGLzNxYkd4eWdaRWVQZWxXQWJIamhKVDk2Z3dP?=
 =?utf-8?B?Qk1RcG9aeGRSaWoyeEU0dlpNS3JaOE5TcS9WMis4VFAxemNGdFlBdGZ0N3Vr?=
 =?utf-8?B?cjJiVmMyeWJuME1Zb1duaGlUT2I2aHNsSkM1TnBlYytlaFl1YVNnclByOE43?=
 =?utf-8?B?YTRJMy9oMWJDeDF1MlZrcW9vTUFEVHhBME5McVpURDFqczJmY2YwODg5ZnVT?=
 =?utf-8?B?MTZBMC9IK29oRXp5clR6b0hyZGlUOGh1T1RCNEY5Y1c2dVpCSGR2NFNSa3Y2?=
 =?utf-8?B?WlgrVmFoNHRoay9TMFVBOUtpd1FEVU9uT0M5L0lXVmFPSmRNNy9sSW8vbFNC?=
 =?utf-8?B?NVZ5T2JYdmhCdFhGYW9YMzRqSDlGV0lxVXdWd20ybWJVWTRHbUJnZy95TTNk?=
 =?utf-8?B?dzY2aC9xSjZ2VzZTVDRQOEVldnN1Z0l1KzByQUN3WXh5UkpQR0hLQU9rOGsy?=
 =?utf-8?B?eG9iK0RKTHBMN3NLTjJkRUQ3bDA3U25qeWRvVUFxdHVzSFc5QTZnaDV1Y3Nu?=
 =?utf-8?B?aWZQQnpMYnFoR1BDbEg3YnNEUHMvaVJJM2NaSmlrMEttMzlySEFjanN0aXpw?=
 =?utf-8?B?d1I3NHBDV08rbUJyK3IwTnNXeEZtUVltR2dGUWt4enBiZmxUSjFTcUhNSDJm?=
 =?utf-8?B?d3R1dmxvRG9lQkhiU1pUOWJYOTFBT0Exa1RtWUxpZ2ZUU2tLUk9IU1lrZFAr?=
 =?utf-8?B?U3BwYzR0U0hmRVI4eE5rK3lkeXZSUmZXZnJqQmVLTnR4NHNNZVpoRGphTlla?=
 =?utf-8?B?dlArTnNPVUw5TjIxMFlTS012Wjd2K1MxdWQrWm5wU3prelVvcnVXOEMvRWIz?=
 =?utf-8?B?YkpVbHMxcm9nYmREUnlwVUJUWVBMZTFjdTdXSWE0RmFGbERDS3FIQ3pJNUxD?=
 =?utf-8?B?TGxMS2psT1NWZzYwMTdEaWc1RTVPOTZycHY2TUgxOGZwUGFTTlp6REx5bE5I?=
 =?utf-8?B?SU5LQkhxT1UrNXlONXJPdW13QTNJc3hWdDVtRDd3cFlYZ1p3aFJ3SlpDMURr?=
 =?utf-8?B?NzV6VWgzY3U1cVpkc1JnNTV2d2ZIYVVDVTRnclJ2cnVtam1DaWllYURLZ0ZY?=
 =?utf-8?B?VnFNZVArZjRGNDBWdDArMkdncGxPQUpQNmR6bEFQWWNNbjNCR2FWSTl2YzJh?=
 =?utf-8?B?YlJ1eHBnYlVxRzZ0L0tUeEpTaE82M2tZdTJ1N1NrN3ZyL08wWHhyUGd0a0tH?=
 =?utf-8?B?eWUrWmN6V3E2d1ZFQk5nUjFsdmxkUDM4QkMzQ0o2RHJlUVRMOUtlc1AwaDFm?=
 =?utf-8?B?V29WeVVSSlB1bTkrbGhpY0RQSUFFdSthMmhJL2JpSkVvNzZLYzRpY01ySUNv?=
 =?utf-8?B?bVBoMXpIeitYWEFyMGhxaDZQTzVJQ3pwM1Mybm50VVFJN2hJNXlvcWYxV3ZE?=
 =?utf-8?B?U0IzbmljWDY4QzBjdVUzNHJGWlYwVWNObEEycjVTaVBIY1lCQ3Y4WkQwSURM?=
 =?utf-8?B?WjJtMXZiRHJTRmg3MTFydGNUUDZ4UzlVM2JOZmVrQXJybzJYdFBEVStINVdG?=
 =?utf-8?B?bFllby9rV3JWTjkwV3NEMnE4WHh2aWVrZnVobElQbUJtSDdOeWVwVVh0UFBO?=
 =?utf-8?B?c1hHMm5BVU9Qb0dpcTlRTUJSWEdtUHBiT3RyTWdjTWdHc0JUamFKVTBhYU1O?=
 =?utf-8?Q?UD1+sg5a0QOzfHgo1rS2qCQAfBYTiWFW7F5r+R0R+dqtS?=
x-ms-exchange-antispam-messagedata-1: r0rE5BELyz7Qc+/rXk+Pif6HHSlecRs6kAY=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1445E09E27114F43BDCA2E0FF211964B@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 4oZn6dpPwMBXi38BvETM6UwXOCeh4F5TqIsQ8h1Ve/MQo0X9NwNRvM1GRtQZTWO3EBKAwTkt0YHzDsqSLQJ7g5NpDyQ0kaeDOjm8wLaV+MDD8KDuHRAi8nyVrUcbElExvfaBrYDJxZMFbdd2clOulbEi+PSNkbvaGkPn3KMsLCydsB7MTYoY09xsLCgJIAwDsDWtX7qSDuy2ESg36UWPiSiJucEu8Fti1eW2wtzzMdMEY+u/MoykXNCtGRPsoU26tIo8nHfa3q4A+JsJMSRt77BBczP/CNGSv8h5samcv8k5d+h8Y4uHceuL7KWSMrAHYQoe25LZaAzjK7oMSRzCMQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: zgAbRZ8cHID9WXuD0HfvZCZw5NTPpiY6aYnG+WPcP0ZVeJcQqcU819HmP8u8aQJMhFdJ+mvIjJeVO7WTpKiKsbysG2GfVgzRCgRc9t38KIq9dM20FFB3bqWt2G/FCLy0s9Mn3jKPL53LottEdD0spTj040pPKs4a6TeFuFGhWtgiksnekPXLDJ0P2/aP1ah/Mqrnmm2d37Y9Ajsp6dopImYcX8PW7AU6vqIRp26A9lE/LmgQdpWgfCBwLBQuYB/XsVPyCwqaOAjMw66N3wPVXFeJLejz4rNRwr5NeKPuei1OC8mjolfw9rZix7j+9YySs1i3yKm3MAfaLUQGflmQ2yZkUUYg87u6edDAF+hOLzeb7+kKB2PJ67SjJxi3chQrXbf02xNJsy9tV4CWDPblpUOVhVBbtgZDYuv1pSpQmprIMXH3tCSbobc3/Cdu2RuH/um0n9pYPMQA2KE/dwYrFF4wEGJ62Lk8Q8xoA0l/KuqYkaQ2nyJGbh/gC95fI2v28NaLEadzSnVdetHYbGc5V47e3OwurjcOYsc0SGBNjn15NWR2Ezi3yV0MlUGz54Q0zFMIlwYeI9EeAhuKlSR2rhR2B3Mef+HWV6Dg2uPHhxcSxQEfF0pNy1jKoq9DUdwl
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY1PR04MB9561.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cf024b4-af1f-4684-bdef-08df1f79ac0e
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2026 05:05:54.7970 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WRkPzaVMbLBiarpn78JwfA/ZG2gISJQwPcbve6QnmRGrLEH0oIyibFCFU5Q6eINJzF0hzS2GOmB1ITMViDU/TkrFKrEi2w7yDIW2hT5ySdk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR04MB8297
Received-SPF: pass client-ip=216.71.153.144;
 envelope-from=prvs=727d860e1=Alistair.Francis@wdc.com;
 helo=esa5.hgst.iphmx.com
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

T24gU3VuLCAyMDI2LTA5LTI3IGF0IDE2OjI1ICswODAwLCBNYXggQ2hvdSB3cm90ZToKPiBUaGlz
IHBhdGNoc2V0IGFkZHMgU2lGaXZlJ3MgY3VzdG9tIGludDggbWF0cml4LW11bHRpcGx5IHZlY3Rv
cgo+IGV4dGVuc2lvbnMgWHNmdnFtYWNjZG9kIGFuZCBYc2Z2cW1hY2Nxb3EuIEVhY2ggZXh0ZW5z
aW9uIHByb3ZpZGVzIDQKPiBzaWduZWRuZXNzIHZhcmlhbnRzICh1bnNpZ25lZC91bnNpZ25lZCwg
c2lnbmVkL3NpZ25lZCwKPiB1bnNpZ25lZC9zaWduZWQsIHNpZ25lZC91bnNpZ25lZCkgZm9yIGEg
dG90YWwgb2YgOCBpbnN0cnVjdGlvbnM6Cj4gc2YudnFtYWNje3UsLHVzLHN1fS57NHg4eDQsMng4
eDJ9Lgo+IAo+IFRoZSB0b29sY2hhaW5zIHN1cHBvcnQgWHNmdnFtYWNjZG9kL1hzZnZxbWFjY3Fv
cSBleHRlbnNpb25zOgo+IMKgLSBMTFZNIDE4LjEuMAo+IMKgwqAgLSBsbHZtL2xsdm0tcHJvamVj
dCM2ODI5NSwgY29tbWl0IGQxOTg1ZTNkMWZlZCwgbWVyZ2VkIDIwMjMtMTAtMjAuCj4gwqDCoCBo
dHRwczovL2dpdGh1Yi5jb20vbGx2bS9sbHZtLXByb2plY3QvcHVsbC82ODI5NQo+IMKgLSBHQ0Mg
MTUKPiDCoMKgIC0gY29tbWl0IDEzOWJkMzE5OGE3MyAoIlJJU0MtVjogQWRkIHRoZSBtaW5pIHN1
cHBvcnQgZm9yIFNpRml2ZQo+IGV4dGVuc2lvbnMiKSwgMjAyNC0xMS0xNy4KPiAKPiBSZWZlcmVu
Y2VzOgo+IMKgLSBTaUZpdmUgSW50OCBNYXRyaXggTXVsdGlwbGljYXRpb24gRXh0ZW5zaW9ucyBT
cGVjaWZpY2F0aW9uCj4gwqDCoAo+IGh0dHBzOi8vd3d3LnNpZml2ZS5jb20vZG9jdW1lbnQtZmls
ZS9zaWZpdmUtaW50OC1tYXRyaXgtbXVsdGlwbGljYXRpb24tZXh0ZW5zaW9ucy1zcGVjaWZpY2F0
aW9uCj4gCj4gQ2hhbmdlcyBzaW5jZSB2Mzo8MjAyNjA4MzAxNjAzMzUuMzQ0MTA2OS0xLW1heC5j
aG91QHNpZml2ZS5jb20+Cj4gwqAtIFJlYmFzZSB0byByaXNjdi10by1hcHBseS5uZXh0IGJyYW5j
aCAoY29tbWl0IGY2ZDM1ZDUpCj4gwqAtIE1vZGlmaWVkIHBhdGNoIDYgdG8gYWxpZ24gdGhlIG5l
dyBtZXNvbiBidWlsZCBzeXN0ZW0gb2YgdGVzdHMKPiAKPiBDaGFuZ2VzIHNpbmNlIHYyOjwyMDI2
MDgxMjE3NDQxNy4yNDY4OTgxLTEtbWF4LmNob3VAc2lmaXZlLmNvbT4KPiDCoC0gUmViYXNlIHRv
IHJpc2N2LXRvLWFwcGx5Lm5leHQgYnJhbmNoIChjb21taXQgYWVlMThlYykKPiDCoC0gTW9kaWZp
ZWQgcGF0Y2ggNSB0byBhbGlnbiB0aGUgbmV3IGRpc2FzIGZsb3cKPiAKPiBDaGFuZ2VzIHNpbmNl
IHYxOjwyMDI2MDcyMTEyMjAzNC4xNTY3MTQ2LTEtbWF4LmNob3VAc2lmaXZlLmNvbT4KPiDCoC0g
UmViYXNlIHRvIG1hc3RlciBicmFuY2ggKGNvbW1pdCA4NGYwNzIxKQo+IMKgLSBSZWZvcm1hdCBy
aXNjdl9tdWx0aV9leHRfaW1wbGllZF9ydWxlcyB0byBsaXN0IG9uZSBydWxlIHBlcgo+IMKgwqAg
bGluZSBiZWZvcmUgYWRkaW5nIFhTRlZRTUFDQ0RPRF9JTVBMSUVEL1hTRlZRTUFDQ1FPUV9JTVBM
SUVELCBzbwo+IMKgwqAgZnV0dXJlIGFkZGl0aW9ucyB0byB0aGUgYXJyYXkgYXJlIGEgcHVyZSBh
cHBlbmQgaW5zdGVhZCBvZgo+IMKgwqAgcmVmbG93aW5nIHdoYXRldmVyIGxpbmUgdGhleSBsYW5k
IG9uLiBTcGxpdCBvdXQgaW50byBpdHMgb3duCj4gwqDCoCBwYXRjaC4gKFRoYW5rcyBmb3IgRGFu
aWVsIEhlbnJpcXVlIEJhcmJvemEncyBzdWdnZXN0aW9uKQo+IMKgLSBNb3ZlIHRoZSBTaUZpdmUg
aW50OCBtYXRtdWwgaGVscGVyIG91dCBvZiB0aGUgc2hhcmVkCj4gwqDCoCB2ZWN0b3JfaGVscGVy
LmMgYW5kIGludG8gYSBuZXcgdGFyZ2V0L3Jpc2N2L3RjZy94c2ZfaGVscGVyLmMsCj4gwqDCoCBz
byB2ZW5kb3Itc3BlY2lmaWMgY29kZSBubyBsb25nZXIgbGl2ZXMgaW4gY29tbW9uIHZlY3Rvci1o
ZWxwZXIKPiDCoMKgIGNvZGUuIChUaGFua3MgZm9yIERhbmllbCBIZW5yaXF1ZSBCYXJib3phJ3Mg
c3VnZ2VzdGlvbikKPiAKPiBybmF4Cj4gCj4gCj4gRnJhbmsgQ2hhbmcgKDIpOgo+IMKgIHRhcmdl
dC9yaXNjdi9jcHU6IEFkZCBTaUZpdmUgY3VzdG9tIGludDggbWF0bXVsIGV4dGVuc2lvbiBpbXBs
aWVkCj4gwqDCoMKgIHJ1bGVzCj4gwqAgdGFyZ2V0L3Jpc2N2OiBydnY6IEFkZCBTaUZpdmUgY3Vz
dG9tIGludDggbWF0bXVsIGluc3RydWN0aW9ucwo+IAo+IEphc29uIENoaWVuICgxKToKPiDCoCBk
aXNhcy9yaXNjdjogQWRkIGRpc2Fzc2VtYmxlciBzdXBwb3J0IGZvciBYc2Z2cW1hY2Nkb2QvWHNm
dnFtYWNjcW9xCj4gCj4gTWF4IENob3UgKDMpOgo+IMKgIHRhcmdldC9yaXNjdjogQWRkIGNmZyBw
cm9wZXJ0eSBmb3IgU2lGaXZlIGludDggbWF0bXVsIGV4dGVuc2lvbnMKPiDCoCB0YXJnZXQvcmlz
Y3YvY3B1OiBMaXN0IG9uZSBpbXBsaWVkLWV4dCBydWxlIHBlciBsaW5lCj4gwqAgdGVzdHMvdGNn
L3Jpc2N2NjQ6IEFkZCB0ZXN0cyBmb3IgU2lGaXZlIGludDggbWF0bXVsIGV4dGVuc2lvbnMKClRo
YW5rcyEKCkFwcGxpZWQgdG8gcmlzY3YtdG8tYXBwbHkubmV4dAoKQWxpc3RhaXIKCj4gCj4gwqBN
QUlOVEFJTkVSU8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgfMKgIDEwICsKPiDCoGRpc2FzL21lc29uLmJ1aWxkwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8wqDCoCAzICstCj4g
wqBkaXNhcy9yaXNjdi14c2Ytb3AuYy5pbmPCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCB8wqAgMTEgKwo+IMKgZGlzYXMvcmlzY3YteHNmLmPCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHzCoCA0OSArKysrCj4gwqBkaXNhcy9y
aXNjdi14c2YuaMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgfMKgIDE2ICsrCj4gwqBkaXNhcy9yaXNjdi5jwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHzCoMKgIDIgKwo+IMKgZGlzYXMv
cmlzY3YuaMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCB8wqDCoCAxICsKPiDCoHRhcmdldC9yaXNjdi9jcHUuY8KgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHzCoCA4MCArKysrLS0KPiDCoHRh
cmdldC9yaXNjdi9jcHVfY2ZnLmjCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgfMKgwqAgNSArCj4gwqB0YXJnZXQvcmlzY3YvY3B1X2NmZ19maWVsZHMuaC5pbmPCoMKg
wqDCoMKgwqDCoMKgwqDCoCB8wqDCoCAyICsKPiDCoHRhcmdldC9yaXNjdi9oZWxwZXIuaMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHzCoCAxMCArCj4gwqB0YXJn
ZXQvcmlzY3YvbWVzb24uYnVpbGTCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCB8wqDCoCAxICsKPiDCoHRhcmdldC9yaXNjdi90Y2cvaW5zbl90cmFucy90cmFuc194c2YuYy5p
bmMgfMKgIDk4ICsrKysrKysrCj4gwqB0YXJnZXQvcmlzY3YvdGNnL21lc29uLmJ1aWxkwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHzCoMKgIDEgKwo+IMKgdGFyZ2V0L3Jpc2N2L3RjZy90
Y2ctY3B1LmPCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHzCoCAxNiArKwo+IMKg
dGFyZ2V0L3Jpc2N2L3RjZy90cmFuc2xhdGUuY8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCB8wqDCoCAzICsKPiDCoHRhcmdldC9yaXNjdi90Y2cveHNmX2hlbHBlci5jwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCB8wqAgODcgKysrKysrKwo+IMKgdGFyZ2V0L3Jpc2N2L3hzZi5kZWNv
ZGXCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHzCoCAzMCArKysKPiDC
oHRlc3RzL3RjZy9yaXNjdjY0L3N5c3RlbS9tZXNvbi5idWlsZMKgwqDCoMKgwqDCoMKgIHzCoMKg
IDcgKwo+IMKgdGVzdHMvdGNnL3Jpc2N2NjQvdGVzdC14c2Z2cW1hY2MuU8KgwqDCoMKgwqDCoMKg
wqDCoCB8IDI2MAo+ICsrKysrKysrKysrKysrKysrKysrCj4gwqAyMCBmaWxlcyBjaGFuZ2VkLCA2
NzcgaW5zZXJ0aW9ucygrKSwgMTUgZGVsZXRpb25zKC0pCj4gwqBjcmVhdGUgbW9kZSAxMDA2NDQg
ZGlzYXMvcmlzY3YteHNmLW9wLmMuaW5jCj4gwqBjcmVhdGUgbW9kZSAxMDA2NDQgZGlzYXMvcmlz
Y3YteHNmLmMKPiDCoGNyZWF0ZSBtb2RlIDEwMDY0NCBkaXNhcy9yaXNjdi14c2YuaAo+IMKgY3Jl
YXRlIG1vZGUgMTAwNjQ0IHRhcmdldC9yaXNjdi90Y2cvaW5zbl90cmFucy90cmFuc194c2YuYy5p
bmMKPiDCoGNyZWF0ZSBtb2RlIDEwMDY0NCB0YXJnZXQvcmlzY3YvdGNnL3hzZl9oZWxwZXIuYwo+
IMKgY3JlYXRlIG1vZGUgMTAwNjQ0IHRhcmdldC9yaXNjdi94c2YuZGVjb2RlCj4gwqBjcmVhdGUg
bW9kZSAxMDA2NDQgdGVzdHMvdGNnL3Jpc2N2NjQvdGVzdC14c2Z2cW1hY2MuUwo=

