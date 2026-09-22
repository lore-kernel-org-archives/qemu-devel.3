Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21674C982F1
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2026 05:38:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x8tCl-0008HK-8A; Tue, 22 Sep 2026 01:38:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=718ae7c5e=Alistair.Francis@wdc.com>)
 id 1x8tCi-0008GK-Gh; Tue, 22 Sep 2026 01:38:09 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=718ae7c5e=Alistair.Francis@wdc.com>)
 id 1x8tCg-00080E-CT; Tue, 22 Sep 2026 01:38:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1790055486; x=1821591486;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=WQUxLrUQCevNwt/tAlNdQfihcKn7t/jR+TT1vptUjmY=;
 b=kK3h/rfiFJLwadsGFE9gKqOsKM68eH2i38d0EcGAHsdCSV6RUugytn2K
 oepUhvFd6HMAhMNDBxHL+N5k6qEbDW5voVYIK8/86zaLq09fLY0okl1d1
 UfOmo/C6i/LCgC+03qotP6P1wsiQTBfMZs4t9V0t7Ew6KIdiWi6itE+My
 f4Qlnc6LSEPzF4NvncUjZo48j/2EJbFuRUujkmQmF6umQ6iY1l2WKABSP
 4qurEBZ80Hk5SWyDYQa6poSevfD/A4yoPRX8RWNvgEc4szKm4VAi/HLLg
 cOULYg2w8RaL86AvLQJmJfFSMf3sdB79EDLmTyQMt2z5sdVjx90qf6Uvg g==;
X-CSE-ConnectionGUID: jbZYu6QCRUm7Uuy+RB9KEg==
X-CSE-MsgGUID: 44WA+rlnRPWx8hmVehELwA==
X-IronPort-AV: E=Sophos;i="6.27,115,1786982400"; d="scan'208";a="154648227"
Received: from mail-southcentralusazon11013009.outbound.protection.outlook.com
 (HELO SA9PR02CU001.outbound.protection.outlook.com) ([40.93.196.9])
 by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 22 Sep 2026 13:38:04 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HaVrWwbLh8z4/VAaB8Vgfk9GpjihysdXpOgbV/4hVW/0AF2f7BNsP1rS6vuFV8cm/5IldUugOGbAHnbwym+OuyBZWZEhZdkqEtLEY6tPn29gbRvl+IDDswjRmHJ6TQo5gNxTubHhtFG8wWXSMOJzl7c61QvPcbc3rucuLE2/7OU9jvYc8jSOyh1IIUr5LK/A0ArVPT6lBHj2mX6hCxDSDgYf76W0cXI9YdU8USVUwExRgr/TvkAj+Jur+w5vfAokpGlD62T1pHRf8ESXi3LQ5rKYq8AvwTz6w5ZFSIx5d474pXa4RXyK0yY0jyt20uHGFBP2lT5QGXPx+mg+cXTbDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WQUxLrUQCevNwt/tAlNdQfihcKn7t/jR+TT1vptUjmY=;
 b=qvxW7xlBIyDl9GqGSYVkpquH8B+GpLndvpPEScyk7ERwbToShIKZ8KRQw6+DkOZJBfVeFoH6GmMlDg+b6v3iUE1ngJ0dTjhnuUxLJxQdmMQe/bE5vCgVNiqu3WUO6F8EoDbaxZ7MC81vvYTQBLUL96XRSqv7I4iwiCPIP9TOkMYCKYPCrDDbnF31G57hyKbNV09QhTHpo35k2Z4QZXXy/zea+OQ3wElpT8OJssSioYRs0nE0DPbr6Lb4XSN3LG5Q0vkF8JU1OOX4f1hhQ/T53ONnQUH4bGkCYEIqPdYyAir2Eza1Ikoyvc7AAdS0wakmNGsfb/3O3KnCP0mLZExiGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WQUxLrUQCevNwt/tAlNdQfihcKn7t/jR+TT1vptUjmY=;
 b=q0MuQlM6gCc4f6PulBkumW7mnwdvYvvDeH9ou4uh+WjRhngiIOQ392qC1Wdurru34O6NQggtvzaKLZfuyVzxlNj8Vp94rUX0qCpiAb8SpnAuu/KReWJPrb0orAk7//GKqE0mmexAbW+ELdOI/XCyk5pFuX3hcMTb+8unAP+Bu1I=
Received: from BY1PR04MB9561.namprd04.prod.outlook.com (2603:10b6:a03:5b6::11)
 by DS0PR04MB9318.namprd04.prod.outlook.com (2603:10b6:8:1ff::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.14; Tue, 22 Sep
 2026 05:38:02 +0000
Received: from BY1PR04MB9561.namprd04.prod.outlook.com
 ([fe80::3869:e494:2fa8:9888]) by BY1PR04MB9561.namprd04.prod.outlook.com
 ([fe80::3869:e494:2fa8:9888%6]) with mapi id 15.21.0428.015; Tue, 22 Sep 2026
 05:38:02 +0000
From: Alistair Francis <Alistair.Francis@wdc.com>
To: "fritchleybohrer@gmail.com" <fritchleybohrer@gmail.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "palmer@dabbelt.com"
 <palmer@dabbelt.com>, "daniel.barboza@oss.qualcomm.com"
 <daniel.barboza@oss.qualcomm.com>, "chao.liu@processmission.com"
 <chao.liu@processmission.com>, "liwei1518@gmail.com" <liwei1518@gmail.com>,
 "zhiwei_liu@linux.alibaba.com" <zhiwei_liu@linux.alibaba.com>
Subject: Re: [PATCH] target/riscv: report WRS.NTO opcode in tval on illegal
 instruction
Thread-Topic: [PATCH] target/riscv: report WRS.NTO opcode in tval on illegal
 instruction
Thread-Index: AQHdOfKiWDFr+n3s3kG6AXb7UEJxq7baNSqA
Date: Tue, 22 Sep 2026 05:38:02 +0000
Message-ID: <785332ce34902db010247c07f7faeed3277c3031.camel@wdc.com>
References: <20260901091622.88113-1-fritchleybohrer@gmail.com>
In-Reply-To: <20260901091622.88113-1-fritchleybohrer@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.60.2 (by Flathub.org) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY1PR04MB9561:EE_|DS0PR04MB9318:EE_
x-ms-office365-filtering-correlation-id: 5a2122bc-5559-4d84-7a5f-08df186bab74
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|23010399003|10070799003|19092799006|366016|1800799024|38070700021|56012099006|11063799006|10067099003|22082099003|18002099003|6133799003|3023799007;
x-microsoft-antispam-message-info: /PNUqPl78l2U/u9PvIPMSO2exlsQmfA+zdO/ZM5+XmXyGWw5m71pdWVPrwhPKqjGyFMtWShaO8A54E8yDTjWNs41LkDrSWGnzF/yOtz2eATPEe1wt8Hyq5zZOyoLmFhELXIhlKP5skdoTojZJVf/HhiJFwyEd/iqGcYYRmx62GlP52poIxpq5ee2KnRCsWuzuHWqCSNoYqQlUr8creo5X+imX3Z2X+XCxfFD+euwZ15LgXJyABH6ulVR94tBT5u+QD4nbbacKo/dvNEg7m/fJxrxAKOckOqbI46e/DUTnPQJ5nRSiKiVbdcQMA6OxffeUKy8cv1UqkRkUq+1v4Rg7N0VlMJ05W+4nG4u7lNvz1hMLsriXteXq8L/VgjCiMnSeobqEY8h+r9Ru6QwTDAY7eIDB1C/DEnTpyGU+mg6aMmUzkeItlal8EOpKS1WejnRWQ4BKed8xoNVBiJTI7hhgo+TVhdeSDlB8CUtVwLy3Y+yj597gpZN8NmIo05vSQzoPb8+becI0dOIle0gvR92CZCXFuWfNb4o9V973gUQ4qKeqbZG9wGi3p+8QAM9eMBUbfhhJf9tv899PgDvGL8vGY6QdDDLN44pojnq5YffVJyog+qR353iqfICnfnQADvhypfsybVnwPJ/g4HS1ZOs7IVJ65iafQLi7wh5+3RQ+mM3DI2AuzIBsRN/TMSAspNm+GIUblHVSuZrdI/sohThkBXkNldy5AHT3CuXARIGQUQ=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY1PR04MB9561.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(10070799003)(19092799006)(366016)(1800799024)(38070700021)(56012099006)(11063799006)(10067099003)(22082099003)(18002099003)(6133799003)(3023799007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?d2NEa2RtcVUyOUF5YXowS0p5MXlwMFhDcnJpOW9wOHpqaFJpUFY0NUtGNW5S?=
 =?utf-8?B?YzdjcmVSb3c0aDYxVUNBZlUwQTV1bVZuSUwwc3FRbzczVDh6U3VoOWRqTFNF?=
 =?utf-8?B?K3FVNnpGd2lNSUt0ZXdWMzVkWWgraTZzVjhnYm02QTBZRnQ1NVpweXlRRTFM?=
 =?utf-8?B?TG5sb05RS0xOS1JuYUlJRVMxUzMxeXgwTE85eGFQMEdEYjVEVXVycmhjTnhB?=
 =?utf-8?B?VTE2dVNVQnFrMDgzVWRidGJKNS9LOFJLSzlLcWF6aHlCd3R0ZzlaU3dMTFRz?=
 =?utf-8?B?TVFEZW9IRzB3bVhqQTJYVXZWRlRyYTNveTNmdGhjbElxenRpYk9VMXh0b3lT?=
 =?utf-8?B?dVV1Skowd3VSYzBmdUhVVkFuQm1kckxNTkUwbGtEUGdteFUzRFlDR0JDTjhV?=
 =?utf-8?B?VTRnTmFvNjBLcnRBSzljSmNPRVR4UEppWVo5MDQ3bkZaUzNTczJabkV1YmdT?=
 =?utf-8?B?cm5SZmQ5cWZabWptWGxQR3pWS0dzd3E3WkR6bTl6c1FoVEd1K0dVVlI3MEZ4?=
 =?utf-8?B?OE5HSTVUOENpV2pBOGF3OG40UVNIN29pSmMvWU14M29la1NjRTJJN2d4Nkx4?=
 =?utf-8?B?eDVUSjhSbS9xRjRJSGZWZS9KYjJQUzBNTFE5RUJHa0xxNFNhREQ3Z2hGdW4w?=
 =?utf-8?B?dzJ6R1IyaVc4aWpJcVFDOHFPMEhXYkRPenBBbFlORDJBOTI1SmZqYXVYNkd0?=
 =?utf-8?B?NGpsaWkrQlNGRm9TdTRHU1NYTi9rU2xpRVlyL0haZVlHL1VYbk90RjFxNTUw?=
 =?utf-8?B?alNxNHZWYWh5YXZnUGpwRzZBRnZ6QzVZQ3pCN0ZJOVFKanVyYlAwRHVnMFk4?=
 =?utf-8?B?d2owaXd4SjJoYnhteHdUT0NoTGltMkx5K1ZRRjFPSmNJa2RLLytqMjZnQ3hK?=
 =?utf-8?B?YnNza3dFVDF1aG1nK0pqNVhERmZCZGJMdExiOC9MTHE1TmVmY2oyTTlreXpI?=
 =?utf-8?B?L3VVeWJNQlVqRGtSUGx4aktGL2MwZnFxQ3huRHdSSlQvNW0xMk15alJVSk9U?=
 =?utf-8?B?ck5NY1RiWE96TThzdFJTTjlQQzYvc2tIa2pYaElVSnFUWU9CVGx4MjJ4Mk5V?=
 =?utf-8?B?UU9MZmt6bWhOZm4rbC9wSGg5Yjh2TGxYNFExNU5iLzdjUllwMExYb09qVHBR?=
 =?utf-8?B?SThSM201VTRObWpLSitsTGp3UUFUUUt6RFJvQWFBOW8yaVB6d2xFSCt2cFcz?=
 =?utf-8?B?SE95Q2ZRVUdSd3BZK0FzUXNMN21kZk96TXIzSnF2N0J6L3RqekJsTlViVkVm?=
 =?utf-8?B?Mm1oeWlTYkh0dXdqVVZvbnFGUlhlYmFtbHVCV3M3dHpkZnJOd3VLZ3NET29Z?=
 =?utf-8?B?Y2dmWFdWZVNtWEdWVS9tenhkYnhETHdFQU1iUHdQbTB6bkN0aHdZajlnaGlu?=
 =?utf-8?B?cU9NVmJKOE84OWs4cVJyLy9iTXJtOU1TUDdwMGFLaGhVMEttamMrcHJJbXNs?=
 =?utf-8?B?RTlmdFo2Zk9ralh2T3VrTTB6Yi9aa1FtZDV3a09iZlhvMXZlWTByU1RxNERt?=
 =?utf-8?B?QWtJQXdXM3lkKzc2ZkpwNkhWM0hlQmtGRXAvR21vdmZvZ2wxUXFmQTRGY2tS?=
 =?utf-8?B?RjdlanprL2M5dFlhdHY3RVhDU0R5QUlVUXl2QnYwb3ZMZEgwS2hzRmlKcVda?=
 =?utf-8?B?Q0RWZ2pwUTJWSTFmUFNxTEt4bGVDVVA4a0xPUTQwcTg4SzIvOXdHakpqKzE3?=
 =?utf-8?B?alpyODlZZHNRejR4WDlMS0c5VGdOUGloNWpUeXZ5bG53ak9PTDJuc3ZpUWww?=
 =?utf-8?B?S25XZzlJS2NzWURpbTVqODV1eEc5eVpreWhLY3ArVUFqdTdBZS9RZ1FHU2lY?=
 =?utf-8?B?Wlc1YlVBNml1dzFhUTFHaTZmeW9vRGVsTFBFUXpXcFVTempmc0JPdjA0UDVS?=
 =?utf-8?B?TWxZTUt6MTY2UjI3TENaNE11MjBRUmJlQ2pFYkhYUGh3Ky9Pcnd6djVjYk4y?=
 =?utf-8?B?cU9sc3IwRU1XWnJOMDcyWmdMYTYvVVIvTGQ5Q2lIazRZOGZaVFY4L1dqdEdG?=
 =?utf-8?B?dXAyTzhqa3ZkZ1ViZ09hWUtybmVLSklMWWp5amlEcFhjYjVQaVFnT29ZUkk2?=
 =?utf-8?B?WVZxaThxNzdNeUZRMXhlR01wdjMyZ0lPdUl6dnRNRjlrUUJQQ3d6WmhDREl1?=
 =?utf-8?B?K005RThIK3VpRDlPditqRStTcFhJYnF3TnpZNnRmL1o3RUlpam1xVW9CckR3?=
 =?utf-8?B?dzFJV3RVK29RempQSmFXd3kyNXhKOUJNR203RENFQlFjcEtjbUpUalNwNHNa?=
 =?utf-8?B?emhMZFNwdGV5QjFETUt2RXd5dW0wLzZhRTlPT3BvbUthZHFmN1NDcW9TQ3hB?=
 =?utf-8?B?d3czTEgvMG8wTXIxSmhjbjcxc0E4NVlNRnJmS2FlQ2h2WFpRajlxdEN3aGtF?=
 =?utf-8?Q?POpt55galP2H8JhZOuRa2Sq1jKo42A9QE1giuAgZITxlN?=
x-ms-exchange-antispam-messagedata-1: uvZpKmOYBvXZsY8YkHtyesRBEZ9qmEPwAIA=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4B9CDCCDFC30D144A79FAF92B0770CE9@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: BRlv56YU6sN1OwvALx2S3mpWmBWv9Z+Ibe+htqOTXHwWwUA2I2SDUh/M9FyZCbEOCedvp9hcjGtus1Vui5szYudOzIEQXF3NMmduDvOiytm1/y44h6L69/3eWW6bD3bElnJiPwFS2GJ4O2WV8Qb5VsfqWrkY11Dw4L23QsB9zZ90VHPj2P6yHb69o+pdaDJf8mwYyWPwxOQfSdUFbqHY4zcmb8A6FqyEGVbbZQBSkrlEt29VVm3oA2RsMs/H8zUL8gxtRiSk8ncgQj9yiiRQ6GZ5jyYjadjvZvH5dZnHVaofUcPl9yyLD7AND6UUl2wqoX7h6FnfsmWF5rMDe89Vmg==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 4Q75e/xeOy3M7KiYv4Y5qstSBAdZ3RLOPwkGx/GMCXlAv3R/TXJm3T2UyPPX/aqN5iaxD5J48WVjXblsGYR1WUxF7tXHe6UGWncDNAByi7/ta7MMc8FaujTYR9gJ2YaiC79OGNkFjptiex4fKSdrUs3WVC1KLyXKsWmUIGs9LiVQYZlJ4+STiLJQEU4hQd39xZ9Qcp0ZPF9lXzeGxjrhuhLr3sohc/MLNNIw75RyTYFy8WzDega0/FGfEygBoQlmRTS6tksbppXWBTW95D81K0NLcN0jDOp/6Xgju4f85jzmzyEuHQHSc0uHxIuvUK5UfD4lHEp2V7Ac37fTGXN3XZRS29gh65eoJG9xezcxIUvDx8yLjkIwmHlzAfEAC7cWcqzG86AsVmHYXq+JwFHzGcAmHAe3Ogc+jQ5lvPI4DeJh1dzPzY6w28yg4qyQ+cI15VW1JHs3Ty91iSpJgkdKvwRTUEnf/fKK8dwfz1bAv8C/A7pkSynwRMhj1QD5HDwBRCFccp2ruhYQ76MesAuhdU8jiBWCIusK4iDh0kZXo8eMzhc3dXRHetfUz3SNwJ3mL7CzifrdEu0qgJuS3WCAvmrugFpIoHWXXs3bSaP55O7pabUsFueyV4xA+sR4XKif
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY1PR04MB9561.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a2122bc-5559-4d84-7a5f-08df186bab74
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Sep 2026 05:38:02.6398 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DRbDOpAGYC3sKjQw/iosmNTEXMFzsMzXC3MZbPF0iPMs5UhLqUW7s5GSSAfFmJ0MpD0IzfvzDh3JcBk5yV0O2/0ZqfaCWGUjyXH+8SPGslk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR04MB9318
Received-SPF: pass client-ip=216.71.154.45;
 envelope-from=prvs=718ae7c5e=Alistair.Francis@wdc.com;
 helo=esa6.hgst.iphmx.com
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

T24gVHVlLCAyMDI2LTA5LTAxIGF0IDE3OjE2ICswODAwLCBaZXBoeXIgTGkgd3JvdGU6DQo+IGhl
bHBlcl93cnNfbnRvKCkgbWF5IHJhaXNlIGFuIGlsbGVnYWwgb3IgdmlydHVhbC1pbnN0cnVjdGlv
bg0KPiBleGNlcHRpb24uDQo+IEhvd2V2ZXIsIHRyYW5zX3dyc19udG8oKSBkb2VzIG5vdCBzYXZl
IHRoZSBkZWNvZGVkIG9wY29kZSBiZWZvcmUNCj4gY2FsbGluZw0KPiB0aGUgaGVscGVyLiBBcyBh
IHJlc3VsdCwgZXhjZXB0aW9uIHVud2luZGluZyBsZWF2ZXMgZW52LT5iaW5zIHN0YWxlDQo+IGFu
ZA0KPiB0cmFwIGhhbmRsaW5nIHJlcG9ydHMgYW4gaW5jb3JyZWN0IHZhbHVlIGluIHR2YWwuDQo+
IA0KPiBDYWxsIGRlY29kZV9zYXZlX29wYygpIGJlZm9yZSB0aGUgaGVscGVyIHNvIHRoZSBmYXVs
dGluZyBpbnN0cnVjdGlvbg0KPiBlbmNvZGluZyBpcyByZXN0b3JlZCBmb3IgdHJhcCBoYW5kbGlu
Zy4NCj4gDQo+IEFkZCBhIFRDRyB0ZXN0IHRoYXQgZGVsZWdhdGVzIHRoZSBtc3RhdHVzLlRXLXRy
aWdnZXJlZCBpbGxlZ2FsLQ0KPiBpbnN0cnVjdGlvbg0KPiBleGNlcHRpb24gdG8gUy1tb2RlIGFu
ZCBjaGVja3Mgc2NhdXNlLCBzZXBjIGFuZCBzdHZhbC4NCj4gDQo+IEZpeGVzOiBiNjJlMGNlNzYw
OTggKCJ0YXJnZXQvcmlzY3Y6IFJhaXNlIGV4Y2VwdGlvbnMgb24gd3JzLm50byIpDQo+IFJlc29s
dmVzOiBodHRwczovL2dpdGxhYi5jb20vcWVtdS1wcm9qZWN0L3FlbXUvLS93b3JrX2l0ZW1zLzQw
ODANCj4gU2lnbmVkLW9mZi1ieTogWmVwaHlyIExpIDxmcml0Y2hsZXlib2hyZXJAZ21haWwuY29t
Pg0KDQpUaGFua3MhDQoNCkFwcGxpZWQgdG8gcmlzY3YtdG8tYXBwbHkubmV4dA0KDQpBbGlzdGFp
cg0KDQo+IC0tLQ0KPiDCoC4uLi9yaXNjdi90Y2cvaW5zbl90cmFucy90cmFuc19ydnphd3JzLmMu
aW5jwqAgfMKgIDIgKw0KPiDCoHRlc3RzL3RjZy9yaXNjdjY0L01ha2VmaWxlLnNvZnRtbXUtdGFy
Z2V0wqDCoMKgwqAgfMKgIDQgKw0KPiDCoHRlc3RzL3RjZy9yaXNjdjY0L3Rlc3QtemF3cnMtc3R2
YWwuU8KgwqDCoMKgwqDCoMKgwqDCoCB8IDg3DQo+ICsrKysrKysrKysrKysrKysrKysNCj4gwqAz
IGZpbGVzIGNoYW5nZWQsIDkzIGluc2VydGlvbnMoKykNCj4gwqBjcmVhdGUgbW9kZSAxMDA2NDQg
dGVzdHMvdGNnL3Jpc2N2NjQvdGVzdC16YXdycy1zdHZhbC5TDQo+IA0KPiBkaWZmIC0tZ2l0IGEv
dGFyZ2V0L3Jpc2N2L3RjZy9pbnNuX3RyYW5zL3RyYW5zX3J2emF3cnMuYy5pbmMNCj4gYi90YXJn
ZXQvcmlzY3YvdGNnL2luc25fdHJhbnMvdHJhbnNfcnZ6YXdycy5jLmluYw0KPiBpbmRleCAwZWVm
MDMzLi5lY2ViZWMwIDEwMDY0NA0KPiAtLS0gYS90YXJnZXQvcmlzY3YvdGNnL2luc25fdHJhbnMv
dHJhbnNfcnZ6YXdycy5jLmluYw0KPiArKysgYi90YXJnZXQvcmlzY3YvdGNnL2luc25fdHJhbnMv
dHJhbnNfcnZ6YXdycy5jLmluYw0KPiBAQCAtNTQsNiArNTQsOCBAQCBzdGF0aWMgYm9vbCB0cmFu
c193cnNfbnRvKERpc2FzQ29udGV4dCAqY3R4LA0KPiBhcmdfd3JzX250byAqYSkNCj4gwqDCoMKg
wqDCoCAqIGV4Y2VwdGlvbiwgYXMgaGFuZGxlZCBieSB0aGUgd3JzLm50byBoZWxwZXIuDQo+IMKg
wqDCoMKgwqAgKi8NCj4gwqAjaWZuZGVmIENPTkZJR19VU0VSX09OTFkNCj4gK8KgwqDCoCAvKiBT
YXZlIHRoZSBvcGNvZGUgaW4gY2FzZSB0aGUgaGVscGVyIHJhaXNlcyBhbiBleGNlcHRpb24uICov
DQo+ICvCoMKgwqAgZGVjb2RlX3NhdmVfb3BjKGN0eCwgMCk7DQo+IMKgwqDCoMKgIGdlbl9oZWxw
ZXJfd3JzX250byh0Y2dfZW52KTsNCj4gwqAjZW5kaWYNCj4gwqANCj4gZGlmZiAtLWdpdCBhL3Rl
c3RzL3RjZy9yaXNjdjY0L01ha2VmaWxlLnNvZnRtbXUtdGFyZ2V0DQo+IGIvdGVzdHMvdGNnL3Jp
c2N2NjQvTWFrZWZpbGUuc29mdG1tdS10YXJnZXQNCj4gaW5kZXggNmEyMTljMy4uOTc5ZGYyYyAx
MDA2NDQNCj4gLS0tIGEvdGVzdHMvdGNnL3Jpc2N2NjQvTWFrZWZpbGUuc29mdG1tdS10YXJnZXQN
Cj4gKysrIGIvdGVzdHMvdGNnL3Jpc2N2NjQvTWFrZWZpbGUuc29mdG1tdS10YXJnZXQNCj4gQEAg
LTIwLDYgKzIwLDEwIEBAIEVYVFJBX1JVTlMgKz0gcnVuLWlzc3VlMTA2MA0KPiDCoHJ1bi1pc3N1
ZTEwNjA6IGlzc3VlMTA2MA0KPiDCoAkkKGNhbGwgcnVuLXRlc3QsICQ8LCAkKFFFTVUpICQoUUVN
VV9PUFRTKSQ8KQ0KPiDCoA0KPiArRVhUUkFfUlVOUyArPSBydW4tdGVzdC16YXdycy1zdHZhbA0K
PiArcnVuLXRlc3QtemF3cnMtc3R2YWw6IHRlc3QtemF3cnMtc3R2YWwNCj4gKwkkKGNhbGwgcnVu
LXRlc3QsICQ8LCAkKFFFTVUpIC1jcHUgbWF4ICQoUUVNVV9PUFRTKSQ8KQ0KPiArDQo+IMKgRVhU
UkFfUlVOUyArPSBydW4tdGVzdC1tZXBjLW1hc2tpbmcNCj4gwqBydW4tdGVzdC1tZXBjLW1hc2tp
bmc6IHRlc3QtbWVwYy1tYXNraW5nDQo+IMKgCSQoY2FsbCBydW4tdGVzdCwgJDwsICQoUUVNVSkg
JChRRU1VX09QVFMpJDwpDQo+IGRpZmYgLS1naXQgYS90ZXN0cy90Y2cvcmlzY3Y2NC90ZXN0LXph
d3JzLXN0dmFsLlMNCj4gYi90ZXN0cy90Y2cvcmlzY3Y2NC90ZXN0LXphd3JzLXN0dmFsLlMNCj4g
bmV3IGZpbGUgbW9kZSAxMDA2NDQNCj4gaW5kZXggMDAwMDAwMC4uNDJhOTkwMQ0KPiAtLS0gL2Rl
di9udWxsDQo+ICsrKyBiL3Rlc3RzL3RjZy9yaXNjdjY0L3Rlc3QtemF3cnMtc3R2YWwuUw0KPiBA
QCAtMCwwICsxLDg3IEBADQo+ICsvKg0KPiArICogVGVzdCB0aGF0IFdSUy5OVE8gd3JpdGVzIHRo
ZSBpbnN0cnVjdGlvbiBlbmNvZGluZyB0byBzdHZhbCB3aGVuDQo+ICsgKiBtc3RhdHVzLlRXIGNh
dXNlcyBhbiBpbGxlZ2FsLWluc3RydWN0aW9uIGV4Y2VwdGlvbiBpbiBTLW1vZGUuDQo+ICsgKg0K
PiArICogU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjAtb3ItbGF0ZXINCj4gKyAqLw0K
PiArDQo+ICsJLm9wdGlvbglub3J2Yw0KPiArDQo+ICsJLnRleHQNCj4gKwkuZ2xvYmFsCV9zdGFy
dA0KPiArX3N0YXJ0Og0KPiArCS8qIFVuZXhwZWN0ZWQgdHJhcHMgdG8gTS1tb2RlIGZhaWwgdGhl
IHRlc3QuICovDQo+ICsJbGxhCXQwLCBtYWNoaW5lX3RyYXANCj4gKwljc3J3CW10dmVjLCB0MA0K
PiArDQo+ICsJLyogRGVsZWdhdGUgaWxsZWdhbC1pbnN0cnVjdGlvbiBleGNlcHRpb25zIHRvIFMt
bW9kZS4gKi8NCj4gKwlsaQl0MCwgMSA8PCAyDQo+ICsJY3NycwltZWRlbGVnLCB0MA0KPiArDQo+
ICsJbGxhCXQwLCBzdXBlcnZpc29yX3RyYXANCj4gKwljc3J3CXN0dmVjLCB0MA0KPiArDQo+ICsJ
LyogR2l2ZSBTLW1vZGUgcmVhZCwgd3JpdGUgYW5kIGV4ZWN1dGUgYWNjZXNzIHRvIGFsbCBtZW1v
cnkuDQo+ICovDQo+ICsJbGkJdDAsIC0xDQo+ICsJY3NydwlwbXBhZGRyMCwgdDANCj4gKwlsaQl0
MCwgMHhmDQo+ICsJY3NydwlwbXBjZmcwLCB0MA0KPiArDQo+ICsJLyogU2V0IG1zdGF0dXMuVFcg
YW5kIHNlbGVjdCBTLW1vZGUgZm9yIG1yZXQuICovDQo+ICsJbGkJdDAsIDMgPDwgMTENCj4gKwlj
c3JjCW1zdGF0dXMsIHQwDQo+ICsJbGkJdDAsICgxIDw8IDIxKSB8ICgxIDw8IDExKQ0KPiArCWNz
cnMJbXN0YXR1cywgdDANCj4gKw0KPiArCWxsYQl0MCwgc3VwZXJ2aXNvcl9zdGFydA0KPiArCWNz
cncJbWVwYywgdDANCj4gKwltcmV0DQo+ICsNCj4gK3N1cGVydmlzb3Jfc3RhcnQ6DQo+ICsJLyog
V1JTLk5UTyBtdXN0IHRyYXAgYmVjYXVzZSBtc3RhdHVzLlRXIGlzIHNldC4gKi8NCj4gKwlsaQlh
MCwgMQ0KPiArd3JzX250bzoNCj4gKwkud29yZAkweDAwZDAwMDczDQo+ICsJaglfZXhpdA0KPiAr
DQo+ICttYWNoaW5lX3RyYXA6DQo+ICsJbGkJYTAsIDINCj4gKwlqCV9leGl0DQo+ICsNCj4gK3N1
cGVydmlzb3JfdHJhcDoNCj4gKwlsaQlhMCwgMw0KPiArDQo+ICsJY3Nycgl0MCwgc2NhdXNlDQo+
ICsJbGkJdDEsIDINCj4gKwlibmUJdDAsIHQxLCBfZXhpdA0KPiArDQo+ICsJY3Nycgl0MCwgc2Vw
Yw0KPiArCWxsYQl0MSwgd3JzX250bw0KPiArCWJuZQl0MCwgdDEsIF9leGl0DQo+ICsNCj4gKwlj
c3JyCXQxLCBzdHZhbA0KPiArCWx3dQl0MiwgMCh0MCkNCj4gKwlibmUJdDEsIHQyLCBfZXhpdA0K
PiArCWxpCXQyLCAweDAwZDAwMDczDQo+ICsJYm5lCXQxLCB0MiwgX2V4aXQNCj4gKw0KPiArCWxp
CWEwLCAwDQo+ICsNCj4gK19leGl0Og0KPiArCWxsYQlhMSwgc2VtaWFyZ3MNCj4gKwlsaQl0MCwg
MHgyMDAyNgkvKiBBRFBfU3RvcHBlZF9BcHBsaWNhdGlvbkV4aXQgKi8NCj4gKwlzZAl0MCwgMChh
MSkNCj4gKwlzZAlhMCwgOChhMSkNCj4gKwlsaQlhMCwgMHgyMAkvKiBUQVJHRVRfU1lTX0VYSVRf
RVhURU5ERUQgKi8NCj4gKw0KPiArCS8qIFNlbWlob3N0aW5nIGNhbGwgc2VxdWVuY2UuICovDQo+
ICsJLmJhbGlnbgkxNg0KPiArCXNsbGkJemVybywgemVybywgMHgxZg0KPiArCWVicmVhaw0KPiAr
CXNyYWkJemVybywgemVybywgMHg3DQo+ICsJagkuDQo+ICsNCj4gKwkuZGF0YQ0KPiArCS5iYWxp
Z24JMTYNCj4gK3NlbWlhcmdzOg0KPiArCS5zcGFjZQkxNg0K

