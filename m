Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B8CCC5B572
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 02:56:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ww9zn-0007b0-Tf; Mon, 17 Aug 2026 22:56:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=683e62043=Alistair.Francis@wdc.com>)
 id 1ww9zl-0007aa-Er; Mon, 17 Aug 2026 22:56:09 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=683e62043=Alistair.Francis@wdc.com>)
 id 1ww9zj-0003gv-6t; Mon, 17 Aug 2026 22:56:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1787021767; x=1818557767;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=4s9t4Nh5rv1PYjJ+ja8gl4KuJUp4Ql1m6sjE+gOhFm4=;
 b=oInyQmi96gKb0c87gN5/NowErT4UuGW+9OQPi7s/ZYEu4nlpBQgnHXmz
 IQqTer1CS44YhqEwgVi1bJjoda3l79hci5oR0TY/1Ax+/brSssHCgDdSx
 0ba/Lj5LBbEIaiMLiqdqpVbnzwuqEhXuq0on7mecDIIVLyuKMCcvWi3I8
 MlnZCMOsJw99IiDqHWCXugyJy2VfVTIlNeatVisrE1uwvc1mBgp6TDLSS
 Xr9RtFLQgyuwgmDBBO1zC5GN3ISOxxYzaOtDr3oIlw9QTpe4fzYiBenIw
 NyC5x3r7gsJhT3onwEtj0oxxl2jyd5wbwlrfJDc/gHe3Unq8YXImgSebu g==;
X-CSE-ConnectionGUID: /og91N4tR3qOiZhMWJpyeg==
X-CSE-MsgGUID: LtzAS0WOQM6kX91cJZg5uw==
X-IronPort-AV: E=Sophos;i="6.25,230,1779120000"; d="scan'208";a="153181036"
Received: from mail-westus3azon11011003.outbound.protection.outlook.com (HELO
 PH0PR06CU001.outbound.protection.outlook.com) ([40.107.208.3])
 by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 18 Aug 2026 10:56:02 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UtQr1TN92TDwaPfp8SicIKE+tszXRHhLynx0Dv/BNpu53+tfqnR/GAKRkTU4xRWW0w6N83JHRJtvTZTE8sRsV3WKIrRYAQIN+Oi4SNhwdNhfThU60t9viGQZrjJNMoqBIgxqPQOM0+tJMqhKjzDreaRBfR18o1GYy+3KbY4D44UVbxTcSL2KWopdsf4BH0tqR0US+da87JapXuzQUjlqSgfHRTj1MonPm/pMYraVTGVz8ruB0gj7dyujzxFPNJbNZCXhMYZgdRAnIQAYOzLQE1O+Q+3YUAblJfeCksVnapIzG7c1IYQlV+YJEw/Euw5assL93pHOFem3rqG6GZLESQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4s9t4Nh5rv1PYjJ+ja8gl4KuJUp4Ql1m6sjE+gOhFm4=;
 b=Xl0fuBqXmAtt6IG5oWuCL82Is6PN19IJTlkoP0Hvw3XNPS+O4iBA1KG0zsBq8A+InT6FbieHrmw3138P6b5oThVihRVzP6U8KBqd0Tg2gYA79LfbYSg2NrUM1vdfxcTAi/ufqgPqrrkCpYrnVRWOgceMPX8rLuX4b2ASF56W1Nd0/NKPfWXDIlzyWMWsHwJBAikVR66Io46iKPQwiyCTbiqvELgxqAIW9KXZpnRZmXXT2+B8mV+S9RUk+08oDPTxYz5xl2Q8jpnV+5Awwo1Mzoxdia7pFsDDw3eRzFZTAN5gNNX7lzEHodyMvf6RrVjjtMgniK55975jILGoQXcVMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4s9t4Nh5rv1PYjJ+ja8gl4KuJUp4Ql1m6sjE+gOhFm4=;
 b=Or3T69X6dA90LAtPck36LUwRKDdLgYTd2OO9HcxQot5yYOkvmwm/DvMe1r6TkuoZO5RxmVmEi5Dp2rTjkYXowrlzY65+zE4kEhpZudrPzWVLyCMoTFPsrksxr1aMSdEQNHFoaDfWUTuqZ4LXEFxUPXpdBarM3gCFoIKtOK7wFV4=
Received: from BY1PR04MB9561.namprd04.prod.outlook.com (2603:10b6:a03:5b6::11)
 by PH7PR04MB8609.namprd04.prod.outlook.com (2603:10b6:510:240::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Tue, 18 Aug
 2026 02:55:57 +0000
Received: from BY1PR04MB9561.namprd04.prod.outlook.com
 ([fe80::3869:e494:2fa8:9888]) by BY1PR04MB9561.namprd04.prod.outlook.com
 ([fe80::3869:e494:2fa8:9888%5]) with mapi id 15.21.0315.016; Tue, 18 Aug 2026
 02:55:56 +0000
From: Alistair Francis <Alistair.Francis@wdc.com>
To: "visitorckw@gmail.com" <visitorckw@gmail.com>, "joel@jms.id.au"
 <joel@jms.id.au>
CC: "wxchen0913@gmail.com" <wxchen0913@gmail.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "marcandre.lureau@redhat.com"
 <marcandre.lureau@redhat.com>, "chao.liu.zevorn@gmail.com"
 <chao.liu.zevorn@gmail.com>, "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, 
 "palmer@dabbelt.com" <palmer@dabbelt.com>, "zhiwei_liu@linux.alibaba.com"
 <zhiwei_liu@linux.alibaba.com>, "lvivier@redhat.com" <lvivier@redhat.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>, "liwei1518@gmail.com"
 <liwei1518@gmail.com>, "farosas@suse.de" <farosas@suse.de>,
 "daniel.barboza@oss.qualcomm.com" <daniel.barboza@oss.qualcomm.com>
Subject: Re: [PATCH v3 0/3] riscv: Add K230 DW 8250-compatible UART
Thread-Topic: [PATCH v3 0/3] riscv: Add K230 DW 8250-compatible UART
Thread-Index: AQHdJt5VdyYJpQ0ZlUiu5ArxiI9M97abzPAAgAGn1gCABbeoAA==
Date: Tue, 18 Aug 2026 02:55:56 +0000
Message-ID: <13ca6b387820082d5b80cc30f31a028d35c5042a.camel@wdc.com>
References: <20260808-feat-k230-uart-v3-v3-0-d73b31f0034b@gmail.com>
 <CACPK8Xfgj+AUx0h_46f=qG_UEE_o7kTZ0=Buxr7+bdHDODHpgw@mail.gmail.com>
 <an797N3cUZj5EX0h@google.com>
In-Reply-To: <an797N3cUZj5EX0h@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.60.2 (by Flathub.org) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY1PR04MB9561:EE_|PH7PR04MB8609:EE_
x-ms-office365-filtering-correlation-id: f6f20eb5-1f62-4985-3032-08defcd439f0
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|366016|376014|19092799006|7416014|1800799024|10070799003|56012099006|10067099003|3023799007|22082099003|18002099003|4143699003|11063799006|13003099007|38070700021;
x-microsoft-antispam-message-info: 6QHe0+gn3LGNx3pTmMzSX9FWuXirPpWxEK9LqWK4CGoOXe1a4kSSEK21rZLH9EBENBWtOPa9tngNclsPfoNs3bYUS7s/g9vWkwplLiqPzvhogwiSyiwCMX5N+E+Hf6+HkqJdy9Qm4BfJg+cz6cUW2fVHj9LTUo/8zmN+l6jpOXcWgZx6tyJJ5tFfEmQYr2cQlR/y0RJ1m6jQp5PQYe+4+mA0WY9d7TCp3UhkRJzMd2ivJvKowVngNU5tgp9F61DPnfxLP+eKiOeUl1tV79qDayUbIteOFPo/ZB+q6LQfNS5uyAXTocJHqkU43omjAXMrJ5iLw2vDFJXydUfKKenOmzQAheuvTVmcPVZ9l31LI9r26m/GUoLTcKP/uwON5HtxF6DDf6M2iy7MO0rXPv/zuFuZVh/t9PiffTshzw7dgPRpoD61UuMM6ThBqkzBN3t5JKwSImBQSpJkmABVY5k8dozMjLK92lnOpcigtvE8emYk1hXl3lobGLdTcPtHksVImg6JH0a2RtNZozQzuoDz2AH0UzIrjBvDHLngekoscoFhOACg9VFl9eTSwsNuVmZatle+fCvosu93w1beY78GJBZyI8w+u2XKC3QxXll+TJ4cjAxz9kEK3KzdcGFH2UDf8+PQZQEu9gngxPAC9bOAM8jSb+fpiQe8FhG8heEqGkTK9fr9NSz3B80+QPgx1QBwJn06JW7Y96slc0RTaljwaheIlD1VHR0Cqft+QM5VkMM=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY1PR04MB9561.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(376014)(19092799006)(7416014)(1800799024)(10070799003)(56012099006)(10067099003)(3023799007)(22082099003)(18002099003)(4143699003)(11063799006)(13003099007)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RXhCcmdscDZUcWhHM3plTk1OSTk3MTlxNFdOaG1oV1BYUTlEL3BHZFVzSEc4?=
 =?utf-8?B?Z0dkSVBEeGR5OThNUVhuVVBxeGRSYkpVWVJLalEvWnlHVFZaY0V3dTFOaXdL?=
 =?utf-8?B?UWZsSFZ6cXJmYUptaXZlTHB5OTFLRWNoYTdwSDY5OUlVRTRBN2U4YjU5ekNY?=
 =?utf-8?B?MXBZNjc3d0pXQnJHVEpuc1RUSHVCOVJQR2ZGTG9LVnRrd2dXOW1xWVp6KzJX?=
 =?utf-8?B?b0VjWkhHZWZEYitqR3Z5c2tON3FkZzNwbmxrR0RldE5hZlBoSjRnSi91a1px?=
 =?utf-8?B?a3puWEtnT0JnWTZMWXlKeUdyYks5aXBsQmo5UEp3SzRqaXR4QVBaOG5uNWZj?=
 =?utf-8?B?SHBUenZ2YW1pUzZDSzVzdHQwRXY2emRlalY2ZThnU0hmNUZ5L2ptNGdTRWx2?=
 =?utf-8?B?K0RNeW05a0VwNGNzWEZKeEJ4eEJNdmdLdEt3N2ZIQkp0TkJqbUxyNnpjVDFV?=
 =?utf-8?B?c3JtMDNaTU5mY0V2NWVSZEVmbnZEblNzUEMvRFd2Uit6NlVMWXNaOUpOdXJ1?=
 =?utf-8?B?VExOdUNQMlhIQjR4MzJSeWVyazRFSGxXWm5aWnl2K0VYY05QRitaSjJ3enNG?=
 =?utf-8?B?VVZkQmNmU1g4TzArL3U5SVQyZVFJclZtb2dLcStiQmZHUVJudEgwZHZEZnFx?=
 =?utf-8?B?d0pPOUYxSldrU3VSNWFwN0Z5eFlPYWwyaittbG5XM2tmK21FRnhDV2tVSW1v?=
 =?utf-8?B?T1FydjFJZHRESi9taTdobzBydUR6Mk8rbXJiSmdmNlhXSG8vMytCSFRSYlFZ?=
 =?utf-8?B?blA4bUM5RWIzbDhZQ2NjMEtaRm5GUG9WQ096SUYvOU1nZUo5Y1JKQ2VnM2NX?=
 =?utf-8?B?eEFxL0VGeVB2ZXBRVlFUU2tJRVZhODRSWmsrYjdyS1lZOUQ5UHhuTDhVZTk3?=
 =?utf-8?B?alJlZXdGZkxtcGlYclk3aWN5NlJkcFNuTldkZExVb3hnSjI3Z0w5SW8rVCt5?=
 =?utf-8?B?VVgyWW4rdkRzZTc4dkZNVjVTajdSNFovU1hHMFUxMzE4SEhVVkQvSDNvbGZT?=
 =?utf-8?B?cWtDNWhIRUxncE1zdTdqeHRWeE1ZcjM5WW5NWGxTcXRneTNYYWplMDBOaDhX?=
 =?utf-8?B?VzJadUg1MGFLUUNPQWp5aXVJamhFUVhCMyswWXFVajVqYXRUOEl0TE93R1hI?=
 =?utf-8?B?aEk4MG9Nb2E0V0pNOHRMODBENkR6QTg1emh0b1FkbXlZTyt1RlNST0IrVFFU?=
 =?utf-8?B?OCtMa1lDMnVEYlVrRDVsa2NDZjZtNjh0N1NibWFRWVNZdm9hOERBdVlWTG03?=
 =?utf-8?B?ZExPaDA5L1VTbXlpSVFPeE1GQWJiMVA0SjJTVEgzc1RFaUVGSVEyTWxUdjhD?=
 =?utf-8?B?MEQyZTFrQTB2SlNCRVJOMnVkMU5pTlNrNFZnaGl2L0xrTUVNSVloMUN2R1pw?=
 =?utf-8?B?VWxOamFNS2VJajdWbVEyWUtLcmRjV1A3eUFnalkwNnJTVHpnZGZ4Ym50L0lM?=
 =?utf-8?B?NE1RTzZtQS9RUUtwanVFUzMwdVBhNVpYeHNmS29vR0pNWDR0SjVQL0FxMUov?=
 =?utf-8?B?dXpkdkJScGJxM3UrUml0WFE1UE9PeHlBSG4zSGFET2w1TzBIdGFuSE9qSXFq?=
 =?utf-8?B?ZUV1MVhZdGw2TXJZdWcxem1NRVN6VTZUMGdseXUxVHZaN3lLOGc4UUoxbkVh?=
 =?utf-8?B?ck5tS1RzTzhTbzc5RHM0RGpFdHllMW9IMGxjUisxb2pSUG4wSkVYS0FjUndx?=
 =?utf-8?B?VmVrYkVMejh4UHVmem9CWjBJSnEyUUprd0pxeEZ4dU5mUkdZUThsTW9lZjcy?=
 =?utf-8?B?d082U1VMampHaVp1YWFXY2xCV0VPU2VDT0tVWW52OHJZZUNadElMOU9SMHhI?=
 =?utf-8?B?Z0ZwNHl3aGFoNHE3aTJ3d3NYcW5QcDlkUC9nUUtLTHN5aVZrNVA0akNqVUpx?=
 =?utf-8?B?ZThrRHdsZ0orbElBMVZRNzZpRktod204WU1waS9xTWoxb1VqVjhYRWdKeWlw?=
 =?utf-8?B?UDRGMHl0MHBvSUMvOVhxWXk0ZGxFbitDbFpoUHVFVXNrRlVMTVh2SWJlcEc5?=
 =?utf-8?B?MWNZWGdvMHdqdE51SGRnVFVKdGpnOWpvNVY4b1VhNVU5RUxUWWFEcG1wb2Ev?=
 =?utf-8?B?Q21MRjFMOVlJYThTdlV1Z0p2WTl5SnQ3RjRqakp6NzQvNDJ0UXRnbXc5ZDNM?=
 =?utf-8?B?S3M3M09kTkxwZy9QWjdCK1VBWk9URGVwekFxckpUbDFIZmJLaURyb25tMGJy?=
 =?utf-8?B?K0tpdWZmNFkyOEd6MEZpd3NKdUNJZ0I5QUtqYlI0RmhTNmxMcjg0UjZIVGtP?=
 =?utf-8?B?a2hlWGFKSStKTnI5N3RycklVUWlzVzVlMEFxNE0vc2NNMVJ1Qk9qNkJkaXl6?=
 =?utf-8?B?dmwrdmxqdEE3UGtqYyszQTdCa1ZxRjlZMUloNWZQbEZaa0duaDlQcXgybU5n?=
 =?utf-8?Q?2FrS8spAdXsv+u7OE8qffMFmT+g7dM5KK0WCFrleNJwIA?=
x-ms-exchange-antispam-messagedata-1: P54sGEsqYeZa1MgLZBri6Y3JiGK493hWWGo=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6FF413F83377024E8137A9A8BDEBB310@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: p5u2LcOElNwR+U+qW6gVJUdVxCyHPq6RYCx/o9w0mH3cX6cHnCPYW1X8Nuha3xe+AWLZZRoXO9v81Si0dquQ//M6xEOcUG1gmX57KBdwHxoK6OlIrdx4pwZ4x38ICWC6fzk+VelHXkxUlocxRaJPcqXOvrMeav5gO6GxtHY4zmZktgk2MQTvGxIfnL8gWPWEVQXCQrTltXz+t4XpzO3C363MWAM3ElBmbUPv58/lknSxMfTUy4OQz0u3Wa+I6ym+frU8DnlG0M8N+UuWsCn0ZoC9avjKZZvQeGkCAuCrPPkNAVYHDkpIUFHW5GLh7uXYUKzLYaz1gzjJehgsoh0zEA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: AWtCs0qKtD52eO3qkM8nKuq5mxDWBf1GNUsqTL6vVStx7DHUkXNR4HsEqOmTz5K+NTLoD6EGxlZbaGrkbRXKRKy+yA/6ogHO/4a/fOSH8sW8Y0zEGlYYRAUELcCs7WdHC5gjWGrc2fUBMn9VYorunoEndm3eQLPfLgsarInJ5wFy81G8+ZmiO5xkmQblDCoSWVNKiJ7iJLydE2osixlO2RJDDlEpmVmzQNT23V3BDS45gcTOrHJdcNRqZPFMfdg7hHW94pLTnRiKfvwhjS1i+cbK3ck+whg8PUPH90Ef6qfT6HceV2hPsotDw+1mAYiEOVWk7B3VzqI/1EEJ55wfKvIRuG4Kc7znNzZsu89hpkre4Jzwpf62j6CLHjkRuBYjv7zvoa2LROG6HVTG7feZvzET3hemQ2WqqP2heWMrtzz3SGxB4vn1ObFpL9MHsNxjL64EWFGpBIah+0SLAp8etYA3LHRr19p7NppD9rPHwPzSE4kM/FI2vfylJkZ/r90wNjXQkbucid6nhqvgqOE1fjXIF3TX09XnG13nV43vTZFfPgxPtPEBMY23eco6Q7nqDhcHYAFd8vStOPQaCXVjziEjiWZi6+B0DP7qdoU385E371w88pX8gAFvSk/z80RY
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY1PR04MB9561.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6f20eb5-1f62-4985-3032-08defcd439f0
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Aug 2026 02:55:56.7853 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hrTEjueK5Cnu5bdtu0IL+JmEIcmYWVk/WQtGYSWdlC4LVtXlTqOIwrClQuWFbVgtDy4J1Wfdn4Ky5sI8BpbE/wyifqjgblj+s3othqInwv0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR04MB8609
Received-SPF: pass client-ip=68.232.141.245;
 envelope-from=prvs=683e62043=Alistair.Francis@wdc.com;
 helo=esa1.hgst.iphmx.com
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

T24gRnJpLCAyMDI2LTA4LTE0IGF0IDE5OjM3ICswODAwLCBLdWFuLVdlaSBDaGl1IHdyb3RlOg0K
PiBPbiBUaHUsIEF1ZyAxMywgMjAyNiBhdCAwNzo1MDoxOFBNICswOTMwLCBKb2VsIFN0YW5sZXkg
d3JvdGU6DQo+ID4gT24gU2F0LCA4IEF1ZyAyMDI2IGF0IDEyOjAyLCBXWCBDaGVuIDx3eGNoZW4w
OTEzQGdtYWlsLmNvbT4gd3JvdGU6DQo+ID4gPiANCj4gPiA+IFRoaXMgc2VyaWVzIGFkZHMgYSBR
RU1VIG1vZGVsIGZvciB0aGUgSzIzMCBTb0MgRGVzaWduV2FyZSA4MjUwLQ0KPiA+ID4gY29tcGF0
aWJsZQ0KPiA+ID4gVUFSVCBjb250cm9sbGVyLCB3aXJlcyBpdCBpbnRvIHRoZSBLMjMwIFNvQywg
YW5kIGFkZHMgcXRlc3QNCj4gPiA+IGNvdmVyYWdlLg0KPiA+ID4gDQo+ID4gPiBUaGUgaW1wbGVt
ZW50YXRpb24gc3VwcG9ydHMgdGhlIHJlZ2lzdGVycyBhbmQgZmVhdHVyZXMgcmVxdWlyZWQNCj4g
PiA+IGJ5IHRoZQ0KPiA+ID4gTGludXggODI1MF9kdyBkcml2ZXIsIHByb3ZpZGluZyBhbiBpbnRl
cmFjdGl2ZSBzaGVsbCBvdmVyIHRoZQ0KPiA+ID4gc2VyaWFsIHBvcnQuDQo+ID4gDQo+ID4gVGhp
cyBpcyBhIG1vZGVsIGZvciB0aGUgc2FtZSBoYXJkd2FyZSBhcyB0aGlzIHBhdGNoOg0KPiA+IA0K
PiA+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3FlbXUtcmlzY3YvMjAyNjA2MTYxOTAxNDcuMTI4
NjMxNi0yLXZpc2l0b3Jja3dAZ21haWwuY29tLw0KPiA+IA0KPiA+IEknbSBub3QgZnVzc2VkIHdo
aWNoIG9uZSB3ZSBlbmQgdXAgd2l0aCBpbiB0aGUgdHJlZSwgYnV0IGl0IHdvdWxkDQo+ID4gYmUN
Cj4gPiBnb29kIHRvIG5hbWUgaXQgZ2VuZXJpY2FsbHkgc28gb3RoZXIgbWFjaGluZXMgY2FuIHVz
ZSBpdC4NCj4gPiANCj4gPiANCj4gQWgsIEkndmUgYmVlbiBhIGJpdCBidXN5IGxhdGVseSBhbmQg
dG90YWxseSBmb3Jnb3QgdG8gc2VuZCBvdXQgdGhlDQo+IG5leHQNCj4gdmVyc2lvbiBvZiB0aGUg
bWlsay12IGR1byBwYXRjaHNldC4gSSB3aWxsIHByb2JhYmx5IG1ha2UgdGhlIGNoYW5nZXMNCj4g
YW5kIHNlbmQgaXQgb3V0IHNvb24uDQo+IA0KPiBBcyBmb3IgdGhlIGR3IDgyNTAgdWFydCBwYXJ0
LCBJJ20gbm90IHN1cmUgaWYgSSBzaG91bGQga2VlcCBteSB1YXJ0DQo+IHBhdGNoIGluIG15IHNl
cmllcywgb3IgaWYgSSBzaG91bGQgd2FpdCBmb3IgV1ggdG8gcmVzcGluIGhpcyBwYXRjaHNldA0K
PiBhbmQgZ2V0IGl0IG1lcmdlZCBpbnRvIHRoZSByaXNjdiB0cmVlLCBhbmQgdGhlbiByZWJhc2Ug
bXkgcGF0Y2hzZXQgb24NCj4gdG9wIG9mIGl0Pw0KDQpZb3VyIHBhdGNoIHNlZW1zIHRvIGhhdmUg
YmVlbiByZXZpZXdlZCBieSBzb21lIG1vcmUgcGVvcGxlLCBzbyBpdCBtaWdodA0KYmUgYmVzdCB0
byB0cnkgYW5kIGdldCANCg0KaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvcWVtdS1yaXNjdi8yMDI2
MDYxNjE5MDE0Ny4xMjg2MzE2LTItdmlzaXRvcmNrd0BnbWFpbC5jb20vDQoNCnVwc3RyZWFtLiBU
aGVuIHlvdXIgTWlsay1WIER1byBib2FyZCBhbmQgdGhlIEsyMzAgVUFSVCBjYW4gYnVpbGQgZnJv
bQ0KdGhhdA0KDQpBbGlzdGFpcg0KDQo+IA0KPiBSZWdhcmRzLA0KPiBLdWFuLVdlaQ0KPiANCj4g
PiA+IA0KPiA+ID4gU2lnbmVkLW9mZi1ieTogV1ggQ2hlbiA8d3hjaGVuMDkxM0BnbWFpbC5jb20+
DQo+ID4gPiAtLS0NCj4gPiA+IENoYW5nZXMgaW4gdjM6DQo+ID4gPiAtIFJlbW92ZWQgYWxsIGhh
cmR3aXJlZCBwcmVwcm9jZXNzb3IgI2lmIGNvbmRpdGlvbmFscyBmcm9tIHRoZQ0KPiA+ID4gbG9n
aWMNCj4gPiA+IC0gQWRkZWQgYSBoZWxwZXIgZm9yIHRoZSByZWNlaXZlciBsaW5lIHN0YXR1cyBp
bnRlcnJ1cHQgY2hlY2sNCj4gPiA+IC0gRW5jYXBzdWxhdGVkIENQUiBhbmQgVUNWIHJlZ2lzdGVy
IHZhbHVlcyBpbiBoZWFkZXIgbWFjcm9zDQo+ID4gPiAtIFJlcGxhY2VkIGdfdXNsZWVwKCkgd2l0
aCBxdGVzdF9jbG9ja19zdGVwKCkgaW4gdGhlIHF0ZXN0DQo+ID4gPiAtIExpbmsgdG8gdjI6DQo+
ID4gPiBodHRwczovL2xvcmUua2VybmVsLm9yZy9xZW11LWRldmVsLzIwMjYwNzI1LWZlYXQtazIz
MC11YXJ0LXYyLXYyLTAtZDVmZTgyYzQ3YzI4QGdtYWlsLmNvbQ0KPiA+ID4gDQo+ID4gPiAtLS0N
Cj4gPiA+IFdYIENoZW4gKDMpOg0KPiA+ID4gwqDCoMKgwqDCoCBody9jaGFyOiBhZGQgSzIzMCBE
VyA4MjUwLWNvbXBhdGlibGUgVUFSVA0KPiA+ID4gwqDCoMKgwqDCoCBody9yaXNjdjogazIzMDog
Y29ubmVjdCBEVyA4MjUwIFVBUlQNCj4gPiA+IMKgwqDCoMKgwqAgdGVzdHMvcXRlc3Q6IGFkZCBL
MjMwIFVBUlQgdGVzdA0KPiA+ID4gDQo+ID4gPiDCoGh3L2NoYXIvS2NvbmZpZ8KgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIHzCoMKgIDMgKw0KPiA+ID4gwqBody9jaGFyL2syMzBfdWFydC5jwqDC
oMKgwqDCoMKgwqDCoMKgIHwgODE2DQo+ID4gPiArKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrDQo+ID4gPiDCoGh3L2NoYXIvbWVzb24uYnVpbGTCoMKgwqDCoMKgwqDC
oMKgwqAgfMKgwqAgMSArDQo+ID4gPiDCoGh3L3Jpc2N2L2syMzAuY8KgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIHzCoCAzMyArLQ0KPiA+ID4gwqBpbmNsdWRlL2h3L2NoYXIvazIzMF91YXJ0LmjC
oCB8IDE5OCArKysrKysrKysrKw0KPiA+ID4gwqBpbmNsdWRlL2h3L3Jpc2N2L2syMzAuaMKgwqDC
oMKgwqAgfMKgwqAgNiArLQ0KPiA+ID4gwqB0ZXN0cy9xdGVzdC9rMjMwLXVhcnQtdGVzdC5jIHwg
NTE0ICsrKysrKysrKysrKysrKysrKysrKysrKysrKw0KPiA+ID4gwqB0ZXN0cy9xdGVzdC9tZXNv
bi5idWlsZMKgwqDCoMKgwqAgfMKgwqAgMiArLQ0KPiA+ID4gwqA4IGZpbGVzIGNoYW5nZWQsIDE1
NTkgaW5zZXJ0aW9ucygrKSwgMTQgZGVsZXRpb25zKC0pDQo+ID4gPiAtLS0NCj4gPiA+IGJhc2Ut
Y29tbWl0OiAzMGU4YTA2YjY0YWE1OGEzOTkwYmEzOWNiNWQwOTUzMWU3ZDI2NWUwDQo+ID4gPiBj
aGFuZ2UtaWQ6IDIwMjYwODA4LWZlYXQtazIzMC11YXJ0LXYzLTBmZjM2NTFkNzBlZg0KPiA+ID4g
DQo+ID4gPiBCZXN0IHJlZ2FyZHMsDQo+ID4gPiAtLQ0KPiA+ID4gV1ggQ2hlbiA8d3hjaGVuMDkx
M0BnbWFpbC5jb20+DQo+ID4gPiANCj4gPiA+IA0K

