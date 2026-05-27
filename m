Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 736DDCD5BD2
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2026 01:29:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wS35i-0005nf-E9; Tue, 26 May 2026 21:29:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=6009f06ea=Alistair.Francis@wdc.com>)
 id 1wS35g-0005nR-AV; Tue, 26 May 2026 21:29:48 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=6009f06ea=Alistair.Francis@wdc.com>)
 id 1wS35d-0007uX-N8; Tue, 26 May 2026 21:29:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1779845385; x=1811381385;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=6mVpbD4BlDJ0bNLyLMlCmf3bCU+68xbm5ovjugK4e6A=;
 b=a+qbtzdfUARP11UPIeSqPFeR6kRunfHyEUJXKiNa1YobcrNXEfvxWsbd
 +mIrcwZJ6714WX+sTm62lSFZiR6IwFjxHXsyuY7hmEN3L+d0Iw78dHW0M
 y4wZBbNVlCybUfxlu4FwMzs8m5hjdxH1Omn+K+HLJZuZu7byfPySQlEPb
 Aa3KbvuLe2ECFweX9mXAaVQxLUA1ItUny9AZJYYyHI+gd2vo0HStmeRWn
 UWztZWKq5HvlhL1eej26yaBaQbo0yyIlDzJ4B+fy6c92cYuKrkwa+fbEm
 4UcjR2rtUGVrUV40s0TG/5I3Eq822+lu6qyvpUNlk6AS/rV/B2ZtFxPzI A==;
X-CSE-ConnectionGUID: 12/AooDsTrObgxONIoFgAQ==
X-CSE-MsgGUID: qQH1y73GRBmYDZDIHvHHmQ==
X-IronPort-AV: E=Sophos;i="6.24,170,1774281600"; d="scan'208";a="148684406"
Received: from mail-northcentralusazon11013060.outbound.protection.outlook.com
 (HELO CH4PR04CU002.outbound.protection.outlook.com) ([40.107.201.60])
 by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 27 May 2026 09:29:42 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FkKeW/bfdbqoBlQDn4RA1j2B0Li7hB1eERZZ4cwM1XYescWk+UEgJPyGssxcAi/Yd8pFzqtIQh8Ibnf3AwNocWrceUamEZsAB+hwvBQZbput7nZT7fYWbbXh7TkLZqk8gfOJ7pQhU3DiDwrlvhN3g9sY2PLZhtJPHG79aA/8VQmL+iMYnqaLDNIWximHghQ0KwSHNPbI3mIBAH8aDNtL8/ar3TMi5a4i3lKT59mpHGr42Jc69N4bH5bXwi2lAqrBih6/FzvcgDD1q0BGapkTOnC07Cx6L4MaOozet9TyFoVOmj33wswIP31KURJgXWvluRfuesO4155KHMZqjUMrMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6mVpbD4BlDJ0bNLyLMlCmf3bCU+68xbm5ovjugK4e6A=;
 b=tzXkRC3ERHeOkabcgcw2+Z0u6vXVsDosoZB1SraxDNQig/gAcFkWh4lRifJMHlvMu6qmNfB8aVBTYYalYshwtYO4dScRSUEUGFruMnYhZJNQyHrzS1KbzCYf8Tgcj1wdne0xIOke6CXUGkcVH6KzT7lRATE9+pM8L8VJ8A3osbKSib442T/THjQ6FmoIWgvYqjFf7/SQiIp/QTIW0vnwNK4RJspJxA6CD13XZHtlG0Zj4MOYVWCxNNfScR/RFkIuEjTftUgufdtcADwcnx8UiKbJToy2fovcDlyVFXK0lL9M7Qxul76dRc/0VnpoxYDnf2Q2UCgqtR/Fkt9x0lmjoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6mVpbD4BlDJ0bNLyLMlCmf3bCU+68xbm5ovjugK4e6A=;
 b=IIAEcUMTzK0Ef3Y3uU0bej9YCIbvACNTVCMXTIwWthOipBs3jkDj99vKUIBv/BHDlrY7nbWF6pbwfF4gYUro8QR544K5gZ84wkvu5huqORDF9hYq7jSy6HDZmt79GdAxdtcKOnncGbTARenWHG7XoAI7RcdHMiywwWz7xE5Ke8A=
Received: from BY1PR04MB9561.namprd04.prod.outlook.com (2603:10b6:a03:5b6::11)
 by PH0PR04MB7624.namprd04.prod.outlook.com (2603:10b6:510:5e::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Wed, 27 May
 2026 01:29:39 +0000
Received: from BY1PR04MB9561.namprd04.prod.outlook.com
 ([fe80::3869:e494:2fa8:9888]) by BY1PR04MB9561.namprd04.prod.outlook.com
 ([fe80::3869:e494:2fa8:9888%4]) with mapi id 15.21.0071.011; Wed, 27 May 2026
 01:29:39 +0000
From: Alistair Francis <Alistair.Francis@wdc.com>
To: "daniel.barboza@oss.qualcomm.com" <daniel.barboza@oss.qualcomm.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>,
 "chao.liu.zevorn@gmail.com" <chao.liu.zevorn@gmail.com>,
 "qemu-stable@nongnu.org" <qemu-stable@nongnu.org>, "liwei1518@gmail.com"
 <liwei1518@gmail.com>, "zhiwei_liu@linux.alibaba.com"
 <zhiwei_liu@linux.alibaba.com>
Subject: Re: [PATCH] target/riscv/cpu_helper.c: allow LOAD_ADDR_MIS promotion
 to AMO fault
Thread-Topic: [PATCH] target/riscv/cpu_helper.c: allow LOAD_ADDR_MIS promotion
 to AMO fault
Thread-Index: AQHc6hbHoHyAdiTIvEKeWW+ERz4/o7YhHGMA
Date: Wed, 27 May 2026 01:29:38 +0000
Message-ID: <5eae90ad80b2de9e241a85716780bbce3f2860cd.camel@wdc.com>
References: <20260522181353.429782-1-daniel.barboza@oss.qualcomm.com>
In-Reply-To: <20260522181353.429782-1-daniel.barboza@oss.qualcomm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.60.1 (by Flathub.org) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY1PR04MB9561:EE_|PH0PR04MB7624:EE_
x-ms-office365-filtering-correlation-id: f08d385e-0ac9-420d-f7c7-08debb8f6b67
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|10070799003|376014|19092799006|366016|38070700021|11063799006|56012099006|22082099003|18002099003;
x-microsoft-antispam-message-info: xYcRovm+b6F63WzCoPOXQaZ5C/pAqqfJDIZqIwuKV+SG0z/ogGTiMht96VdJHiA9qZlp6WODDr1ez+VWrcxbLyftRCfOLqhM4BE7DHxWuA1WjqDA1oXosL3E9jBpIm+FyurUYy++ZonM0QaWSOhGENEVbhgCJq0wkSY2MzAHk8EZm6j/GELZ3IncN+MA0HzOFleAxwppS4rn7s422pDzS6OYP4D7Qxbabi/Ge6C8YOU7JTvhNcdBOr8BWyfrnsJec8tjXxY6nsAcgPSxgbCPy0t1PeBnLpGNnk040gPypvNPDFYsGAp/+phaubj4McmrqxVwz0h54sNfksqs4BVEwtNJ+7+2M44pDQaCyRqfwVRjGw/f8akRa9WxLfRwY5SXRQvu8AmKuhfeE7VYjciTgVCxuynVUE1Uur9ocX2wYIAzfj9zwKqgFtdo8xEBE9kmMLWZKtYX30wAuXD6uL9TtMwiUwaFH/ud4ebr6svrvkIiHb9oeKhDeLeVkVSNZVhkJ68Qh00J74Hht0r7Oy88Q/JnSytZJEomekZqT65hqEUjl4IivscDGvgXVWVmIvvfNXD5xitbsEMqsYQM9nlF/MD8ug3xxQhebdudOqv+B5LwOeCOpAO2X4XaOTAQkHzx1/Kb+u/Viwt8ac37dshw3sfhNm9yxrSefnfM+LmBR3nAO0vveyj/0T/43EYoE3OKQg251mZx9EGOttj2mIKxwz1qjkkTgzKHfLuDlakygqRG41wtGvnBwJqtKp0a7ZKQ
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY1PR04MB9561.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(10070799003)(376014)(19092799006)(366016)(38070700021)(11063799006)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TXozYXNlcTA3MEhSZGM0ZlN0MGc5SDBlRFR0VEk0MnRIdU5pRHVUMUl5c1Ey?=
 =?utf-8?B?NVZiQitDUEtvUlBIOTQxUTNzTXMyd296alJNUWJReXlrbHB5Ullvd1ZUYjF1?=
 =?utf-8?B?OHF4d1crNkt2U0hHblZuemk2WWxLNlB1SUMrRlZIQXVCeXgxZEQyWlo5MzMv?=
 =?utf-8?B?WmdjNVpac0o0L3VJMUp0eFd0VCtuajBqc2g3STdmdkgyTjUrVUUyR2FvajFU?=
 =?utf-8?B?TGFSNlRwTFAvbUtqcEJ1ZHhSUXFMOVh1cVppVXoxUml1eWg3TWZtN1YzRU9i?=
 =?utf-8?B?aWJlMVRzTExYK1BlMWxWOWwwdjBtU2ZrUlBmOTZneDVtMTRtR015K2xPMkNK?=
 =?utf-8?B?STIvQUF5LzdUZ2w1UnR0MFBUeGt2ZTl4Rit3SFFIQ3prUXZoUVRUSXRRdHNn?=
 =?utf-8?B?RXZLZzE3cmFFZkZ0dGw5MUxuYnk4ZzhUWTBPdVMybVFueUFuNGJyT1loblNP?=
 =?utf-8?B?UEp3emUvM1NTYTJuYXVnZjNEb3ZOQStnSmpHVnRYRmlPWWwzSGVxK09FV2J2?=
 =?utf-8?B?UHJoUXNWSklQWlJ6cW11dk9qRDRhUVNBejBVNlliaytjSGI5OVYyZVQ4aEZ4?=
 =?utf-8?B?Q1Y4UnB3aWt4WkpqSzJOZU5NbEYvMVN2V29xZlc2T29KaDYyTHNmRzJESkpW?=
 =?utf-8?B?eXBuRmQraVo5dURiWUhCcXRTd3RsTkFwRVp3eEtkRUFScnJvZi9QMUE3UmRo?=
 =?utf-8?B?SDRiWXdMM05FemtqM3JyS3lXbjc0L2pwcjhnUnRHS3NGdW82bkY3MU1CUmxW?=
 =?utf-8?B?NGp4Z1dGUjd4T0Q4UFY3RVpWQkJMYVJ5bDA5T3IvNmtjRmx1UmEwTG9MMTRS?=
 =?utf-8?B?alZpYWxQbVgzdlhqZUs3L3ZvVCtWa29WclhwREtPdmFGRnNLNDRhV2dYa3Rw?=
 =?utf-8?B?TllmT2F3bHpZMnVvcVdIZWxmdGtDc1BvUzJzL0F1ZGxoM08ySVR1WWJkbUND?=
 =?utf-8?B?RUExQUZobityditCek5TYnU1YUJ1M2ZCVFhVcFl5Zm8wNWFiVnQrSy9zbnhn?=
 =?utf-8?B?eVUrTTBUV1BoZXdQR0pFWjRmdGFQbWFmSVowd3M1aWNkMFdwblpuNTNhd0hV?=
 =?utf-8?B?WDQwUDBaWUtMUUF0akN1N0MxZ0Z5VHpqZE10NmRkeThzNTdwbDNwdnBzZkRr?=
 =?utf-8?B?bUdZQVRnbStvUUV6c2VHNDZidlBBQ1NVWXFRMEdWMGpJQWVSMEZ0TUNzUXN4?=
 =?utf-8?B?aU5pd3lmMDZhek9ITmQxcERQRFE1VURuemFqRGdLSWxHN3o2Vnl0MHZMR3g5?=
 =?utf-8?B?Ti9IRFJST3BhM01OUnVnVFFYb0U5NDJUVGQ0S0puVFFkOGsvVk9jZlg0NEd3?=
 =?utf-8?B?T3R4aWxOeGVla2w5eVhxa0J6Nm5IZFRyWHl5UCswMkpsQjE3Y3Q4VmhENW1v?=
 =?utf-8?B?cDBQNlQyMlBqbkhpc1JFTDhXM0JUbVVDMWNOT09FQjlIQnNtTUFYY2g4TTlL?=
 =?utf-8?B?ZnBCQTdiWHFEWTlvSENTMUZNdlNrdVprdXNEWHlCeDY0R0YrZSs4cVoyUXJD?=
 =?utf-8?B?SEFMTmtycEw5c3lIN0NiZFdseFI3U0N5eDlTbzAzYVlDRjYwbW5WSnZmUnla?=
 =?utf-8?B?c1JxWXlrSGlHUUtneW56WW5nSkJ0ODdxaVQvanllTzVaS0k1K2FDdFF2Qk9G?=
 =?utf-8?B?Z25IbDcvZndveFJNYkxUNVJCQkh2ekVsU0hkaDZad1ZmU29xVmtLS25tanhT?=
 =?utf-8?B?MmM5SnZwVUxHUFJZTFpZcmVLYm96MEQ5R3RsQ01zdmJUVXlMalcwSmRJR1Va?=
 =?utf-8?B?aVFlYk9sM1l0U3QzVzA3VTNmc2FZTlIrSFJmZktlQjNvanhJMUtvdTUweEhG?=
 =?utf-8?B?SERPOXhNcnRsaVA5dE54TVB3VnBISTBKU1hGS2pvYjVRMHFBSEwwVU9WODcw?=
 =?utf-8?B?ajlSMDl3RmpwY3pvakZhaFMyUnF2TGxjTW16anptSU9rUndiY0lGcG0xRlZq?=
 =?utf-8?B?YmQ1NUhLbGVJamZDUGNBT2FTeVcvZWFHQmRtelN3ODV4dHluTTI4QWZzbG1W?=
 =?utf-8?B?aXpPb1dwb21maFA0RmRLcFlXRE9EN3FMbjNYRzcvZWpvMEQweThNakcxZURi?=
 =?utf-8?B?TDBHMHpKYkdlSDRmYlh3dHl2VG9CcjJNMUdQVjlNd2JMT3lrNWFyWEwwUUNu?=
 =?utf-8?B?NG9zRHh6VFcxK0JUTEhqMEZpbXpVMVB1YzdYR25ONHFxbWhDN2VSbjVuMFB6?=
 =?utf-8?B?UFFUQjdzY3JTNkh0MlhPZ0F3ZnQ3c2RkTzVtWjdzam9zV2lKeHpJb3RkQThp?=
 =?utf-8?B?QThsOERSaHptLzBaSjVIaFZ5M2FJR2cwNzQ3NFJJVUVHUmpkWXlTaHJDa29i?=
 =?utf-8?B?eUdkQlR2MVVYVVhjY1lMeFdJSUg0RW5nY0I5VlZLYndqUGtBWnVkaktiemRV?=
 =?utf-8?Q?9pI6ahRp36yT/dUoXSsxN5ob7LWlFvhm2He+2iuo/R25u?=
x-ms-exchange-antispam-messagedata-1: db1ELNoyBNI3DZwrpzFFGkEwch664tcKUBk=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3AE1B4C75C8C3A42AE502AFDE7BFF8E2@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: bSHpBQ4CBbbJUu3ujjKD/zis5ipfAFkZnb1wMrWo9gB+Ihz6Rx81gY+g6qrycL+1MZnDajx6wZrA/NYCqkCKRXAPdt8i4NvqUIf/CAhlsUJl0M/MPPdd61amP8HkR1rw1DtynJ4KeJNQgD3o+YzobkkPy6kZpx3u1ZmhTG9yCjLFZmHkKEVDySko9oa55yDUgY/zGkffa4am57hnGz+e20dCBminhtbViHH5fZ/PJLAaNVTxEUBk42X+g85yXUDKplYzi7gXkmJpLrCV2uS2FvD4+mi+vq+dXFQpV6QDxhVvdbDC8YxAHl8Ez5wXblOyxCrsXyq4RJMsHWm0rYOAaw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: G9oUGlIxKG7IyaMWsycwLdWa50nv+qdZ8iw9gt2GVaQ7LHd6jHCyNpE+OsLrkMgptri7XDWFdSxAozQ+KAC3PAV087upwzuMLRB7+WBuzfGK53PZgoV7Krv/l7dxAzWnDhcJ8iWAP6Ce1RwrI8ACtL8uz3W9LrzbWrJRd9MgNgjPj71P6unkxY9vVd1ZGFpfGl6dt6kkPT2ItkvjM9Gp6V1yqEww5poJ1hiLClJlSWl6VToVXa6M5iWvu6KQeDH2+ccQgvmrzFcalBpzkPiP5pMLJWaEpLSxsU7PHyO/ewX0FL/K6gM9rGz8gX1K1+GjfaOMXPCMqjodyHlbXh5HmqXWMPwE4OvzjMF+CkNTRw01mehz9QRK5ueBJjD54qEH2xpiZq3aA6axMZpLu1I45HGy4fKVnHgyRbyMy+ZivENcuns93jS4Zf1gFpExwucGJb6OYiQ814OWkuw+d99x7yUFGhAqV3HLBvsWgfOQIPlup1GboyMg2GJXNMWLPyDYcOXoo0hSP8dduv7s0LoR40sBP1Mw9HbB9JXkI5xHw1az0fxFZ14CtjXM9U+6BaTje8fDgmWIXce2XJa+NAoDLmiaOKslYxr3Ph7sa4wST0GiHELMggC9xHl9XyxBx5lS
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY1PR04MB9561.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f08d385e-0ac9-420d-f7c7-08debb8f6b67
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 May 2026 01:29:38.9578 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: X6vNJH2OrcdZqfk0vpTU3qenPfeOhEkHUWyRQ7EaQgd1ZihdHKdQW1B0bymixXirLKSMQDxAl+3yYvgB3fJOoZjmN1efGPyzxwkNcyDYcQI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7624
Received-SPF: pass client-ip=68.232.143.124;
 envelope-from=prvs=6009f06ea=Alistair.Francis@wdc.com;
 helo=esa2.hgst.iphmx.com
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

T24gRnJpLCAyMDI2LTA1LTIyIGF0IDE1OjEzIC0wMzAwLCBEYW5pZWwgSGVucmlxdWUgQmFyYm96
YSB3cm90ZToNCj4gcHJvbW90ZV9sb2FkX2ZhdWx0KCkgaXMgbWlzc2luZyB0aGUgcHJvbW90aW9u
IG9mIG1pc2FsaWduZWQgQU1PIGxvYWQNCj4gYWRkcmVzc2VzLCBpLmUuIFJJU0NWX0VYQ1BfTE9B
RF9BRERSX01JUyBzaG91bGQgYmUgcHJvbW90ZWQgdG8NCj4gUklTQ1ZfRVhDUF9TVE9SRV9BTU9f
QUREUl9NSVMgd2hlbiBSSVNDVl9VVzJfQUxXQVlTX1NUT1JFX0FNTyAoaS5lLg0KPiBhbHdheXNf
c3RvcmVhbW8gaXMgdHJ1ZSkuDQo+IA0KPiBBbGwgb3RoZXIgbG9hZCBBTU8gZmF1bHRzIGFyZSBh
bHJlYWR5IGJlaW5nIGNvdmVyZWQuDQo+IA0KPiBDYzogcWVtdS1zdGFibGVAbm9uZ251Lm9yZw0K
PiBGaXhlczogOThmMjFjMzBmNSAoInRhcmdldC9yaXNjdjogQU1PIG9wZXJhdGlvbnMgYWx3YXlz
IHJhaXNlDQo+IHN0b3JlL0FNTyBmYXVsdCIpDQo+IFJlc29sdmVzOiBodHRwczovL2dpdGxhYi5j
b20vcWVtdS1wcm9qZWN0L3FlbXUvLS93b3JrX2l0ZW1zLzM1MDMNCj4gU2lnbmVkLW9mZi1ieTog
RGFuaWVsIEhlbnJpcXVlIEJhcmJvemENCj4gPGRhbmllbC5iYXJib3phQG9zcy5xdWFsY29tbS5j
b20+DQoNClRoYW5rcyENCg0KQXBwbGllZCB0byByaXNjdi10by1hcHBseS5uZXh0DQoNCkFsaXN0
YWlyDQoNCj4gLS0tDQo+IMKgdGFyZ2V0L3Jpc2N2L2NwdV9oZWxwZXIuYyB8IDMgKysrDQo+IMKg
MSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKQ0KPiANCj4gZGlmZiAtLWdpdCBhL3Rhcmdl
dC9yaXNjdi9jcHVfaGVscGVyLmMgYi90YXJnZXQvcmlzY3YvY3B1X2hlbHBlci5jDQo+IGluZGV4
IDE3MzA1ZTFiYjcuLmFhNGNiZmNmNDAgMTAwNjQ0DQo+IC0tLSBhL3RhcmdldC9yaXNjdi9jcHVf
aGVscGVyLmMNCj4gKysrIGIvdGFyZ2V0L3Jpc2N2L2NwdV9oZWxwZXIuYw0KPiBAQCAtMjE3NCw2
ICsyMTc0LDkgQEAgc3RhdGljIHRhcmdldF91bG9uZw0KPiBwcm9tb3RlX2xvYWRfZmF1bHQodGFy
Z2V0X3Vsb25nIG9yaWdfY2F1c2UpDQo+IMKgDQo+IMKgwqDCoMKgIGNhc2UgUklTQ1ZfRVhDUF9M
T0FEX1BBR0VfRkFVTFQ6DQo+IMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuIFJJU0NWX0VYQ1BfU1RP
UkVfUEFHRV9GQVVMVDsNCj4gKw0KPiArwqDCoMKgIGNhc2UgUklTQ1ZfRVhDUF9MT0FEX0FERFJf
TUlTOg0KPiArwqDCoMKgwqDCoMKgwqAgcmV0dXJuIFJJU0NWX0VYQ1BfU1RPUkVfQU1PX0FERFJf
TUlTOw0KPiDCoMKgwqDCoCB9DQo+IMKgDQo+IMKgwqDCoMKgIC8qIGlmIG5vIHByb21vdGlvbiwg
cmV0dXJuIG9yaWdpbmFsIGNhdXNlICovDQo=

