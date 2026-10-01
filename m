Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0490CCA5FCE
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2026 23:05:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCPq0-0007BJ-Ms; Thu, 01 Oct 2026 19:05:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=727d860e1=Alistair.Francis@wdc.com>)
 id 1xCPpw-0007Au-EC; Thu, 01 Oct 2026 19:05:12 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=727d860e1=Alistair.Francis@wdc.com>)
 id 1xCPpu-0007wM-5n; Thu, 01 Oct 2026 19:05:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1790895910; x=1822431910;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=/KuT3MVbjIpyQcUq/EhSMJYP4Zn1qFnKvtOJPbUdZw8=;
 b=EyeD2YThBYbIfaad396vHH2XuujUXGKIs0kbEU71wktzra0YTxTlN7w2
 4S2Pxz+athuHFTBtBBbcahHX4bb8PmH2eMSl7uqfWckHJNNDLHsFYfInW
 4o8EuRjVMj1qG4MzjYLsfPapO+g22rE6HrmvLg3keFFQ4ZKITTgu8J/r6
 cMsgqVLGip6TD8OxkrND1Ave0bLH4HmY/FwjOnkZb2nwEi2vvqRVdwwLe
 a26jb++o1eIP9qLoWeDKgVXHy5ouPMZUzt6OfHLBwk5kd5QyT706znCeM
 AtnUSaEfY4fvhts/q+GmoSVKUvV3hsHdDOnBhoBk/rIAb8LC8Ik6lEWSs A==;
X-CSE-ConnectionGUID: DH9xuc0ZQ6yEkJyJzyTzlQ==
X-CSE-MsgGUID: 1qC/xCmcSFmlklOw1DQ2Xw==
X-IronPort-AV: E=Sophos;i="6.27,135,1786982400"; d="scan'208";a="156120563"
Received: from mail-eastusazon11012011.outbound.protection.outlook.com (HELO
 BL0PR03CU003.outbound.protection.outlook.com) ([52.101.53.11])
 by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 02 Oct 2026 07:05:05 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aomSG3ctNhoOIDW/Opb+AmRXkliIAUdgZGoMkt7IM0B1pL6LAdgUJ+1i5GLx9dqwDh5/1J3NPWhnQYn2w+z5j0kkdOn1MwbHB98sl0mLd/q8DAe8ME9Fm3+LCGCywXpkUfpTf8kjlAhz8P29cLsaMfbeCXB5h1tWFaSpnF7esSeePaJRedunNIYqcw4O22e7zj28BJiEAGqxqA3bwpVFMUa56UtqGAVolLY0ums01LH+rAb4aJE2O7cEKv7k5HDqaOvUqSEKOuzYdwG8UEPm9xQQri3YYCkBNHtucrRjYtDYUeKaJC7lka9PNKdqlGUhz1F7L4rWTN24nCC3s69aNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/KuT3MVbjIpyQcUq/EhSMJYP4Zn1qFnKvtOJPbUdZw8=;
 b=OBkNLuWrgFfVBEScVPXZO6UHGa/+0GQPlT9hwoyRGJclGBCiPwj+883Weq5O3mB5R17lrXb09mk+RzHvp/4miKyTYrK7NJjijIKYzxgSE7SQx58QsEg4yhPZWtBYl6gl9e4+Gv7orKCVNk5aNtNIsMZbZdhoVzv25iYN44jKjfisuIIsu+jgvDIfRcPK47ZYAewF/hj0C2a7hWwJI9WGuMIH/iODfsWAm9euo9m5oIxDBPRC6RFeCeMiGB4+aSR4PpCE0Aqxq3ZiorXyJwFv62jYHTFCqhc98+1UBWBeManqxQsoP4kTJI85nyovO41PLzMJM3Mn1Sd0Qx5u94gb8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/KuT3MVbjIpyQcUq/EhSMJYP4Zn1qFnKvtOJPbUdZw8=;
 b=g9kIuA3HGHIme8OjoRCJbYxQCXXe77kssuqfeWzBPDnr83A+YiEdJzGzkauAvGurI5Zg2vgzRFOR1A87KjyLTdbggY1YKLZZbe3oNMjxX0YDe6RO2zU2Oo1ucbF4YmQFyy4OAv8kkUUqiFRi3szHPrPMkD5HZSez+kohGEX60DI=
Received: from BY1PR04MB9561.namprd04.prod.outlook.com (2603:10b6:a03:5b6::11)
 by CH4PR04MB9460.namprd04.prod.outlook.com (2603:10b6:610:23c::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.18; Thu, 1 Oct
 2026 23:05:03 +0000
Received: from BY1PR04MB9561.namprd04.prod.outlook.com
 ([fe80::3869:e494:2fa8:9888]) by BY1PR04MB9561.namprd04.prod.outlook.com
 ([fe80::3869:e494:2fa8:9888%6]) with mapi id 15.21.0451.026; Thu, 1 Oct 2026
 23:05:02 +0000
From: Alistair Francis <Alistair.Francis@wdc.com>
To: "daniel.barboza@oss.qualcomm.com" <daniel.barboza@oss.qualcomm.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>,
 "chao.liu@processmission.com" <chao.liu@processmission.com>,
 "liwei1518@gmail.com" <liwei1518@gmail.com>, "zhiwei_liu@linux.alibaba.com"
 <zhiwei_liu@linux.alibaba.com>
Subject: Re: [PATCH v13 0/5] hw/riscv: Server Platform Reference Board
Thread-Topic: [PATCH v13 0/5] hw/riscv: Server Platform Reference Board
Thread-Index: AQHdT4WFVhfxUL9n7UCRIZAS5d+HvLbpU4eA
Date: Thu, 1 Oct 2026 23:05:02 +0000
Message-ID: <24dcec0e5eab49f17e3948c066f5b2b8180312e3.camel@wdc.com>
References: <20260928201107.2049458-1-daniel.barboza@oss.qualcomm.com>
In-Reply-To: <20260928201107.2049458-1-daniel.barboza@oss.qualcomm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.62.0 (by Flathub.org) 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY1PR04MB9561:EE_|CH4PR04MB9460:EE_
x-ms-office365-filtering-correlation-id: 166c73fd-958f-4c42-b7b6-08df20106ced
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|23010399003|19092799006|10070799003|1800799024|376014|22082099003|18002099003|38070700021|10067099003|56012099006|11063799006;
x-microsoft-antispam-message-info: rwTbOncse4ni8Y64UMhia1N1hzBmAnxeqGzte24Be0cyNAbeXdXw7P5fX9RdzhfsZdWAoN3cIRN+z3+ame9mtbIpYITF2tK3dYlnizfV26BI55BxeID/jZH2sQPAYTUuEtCMx/TdS8OpvG+opYh0Ix5PyVlCrsUF8jRQUu6JwbORoMQW1+Xz8dsJpRsaf9e1L3aJoUD36ofhntdZ8S2yUU5/JZsPfXnocSGN1s+zK6T+HusX2QQOuRoO8FhwIufmhWzzJfgxlTSbrxcOGTzMBhl2PFLSndBnyDzTyEXNlhR3uoff4DO/bD9ou2mB7OMP1RKVwv8qJ1XR3F4CxkJCaT0/Yuh9sifJnIl8NMP2/ZOEY5VasXrtIzf7ZaRKhDfcCPeHaT1vTRRyNISDoUK+k6KTPAq82UdcSp+R3t6gXWrpbav+9OtlyjxyXdfm1VZudz1ZZwgkhMYEOg8oVJiS0IocoV8pLiNLauWVpkhPhz6Wo2FWM018YI0kjNs4KcaKA3aOzSidBoMmmj6ozcM3pjzNGDutwB5Vh3V6o+U/j47I6ARrGSBEn81OsxXsUWOy9br0f3S0Z6EMxphr2wKlIDb3uWWyvCfSS0kzXTRkv+5yJI4XiSli2bG89ugj2Unwy2Ko25N35rE9vMMtS1SznX2Rt4sqKLETezCOJVMo+wgpLSi7k0OaSu2M/OMX0RB8sTIpHUaqBZQpJXVDAktjV143PdlSI7xq449RtRzWupg=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY1PR04MB9561.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(19092799006)(10070799003)(1800799024)(376014)(22082099003)(18002099003)(38070700021)(10067099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QzA2M1JoRWJINGxoUHF3dlZ0WlM1NlRVQWJZeFBWWm4vVk0vMEMwY1FhTGY3?=
 =?utf-8?B?TFdrQ1JDcXFpTGlLUlhnNU4rZTdwaTBvOFBYQkI4YXJUUWw2eVNLQnJFOUtn?=
 =?utf-8?B?aXkzaTVwODFRYjkvQnppVFN0Y2NxZDh1ZDY0OTlRVG03dUJOOTZ4eUVRaG1i?=
 =?utf-8?B?cUFQUUJ0TDZLSVBubVdRVmZRcnBPMHd1Y09FMEZUb1orVE1YVmp3aktNZjEr?=
 =?utf-8?B?TGJCcnZSWEdzc3g2MVVCZ3M3WjlZOWJlSDVMWlVVckhUai82MTRtWkxQZER1?=
 =?utf-8?B?MXhzVlNINzczS2x5R1haODJXdXlnTVFHcC80K2c1TndVSVI1RzVBMWNaQXZ1?=
 =?utf-8?B?ZVhJUzhaNWFKR3h2K281ZlA4UVU4eE5oc3dVQXBtNWEremVUeHFQMGFtR2hW?=
 =?utf-8?B?NzFFNmtPS1gxVUlYR3FYRk9TYk9MakRCNXpJTEtIR0dwaCtSV21WWGc1R2Mx?=
 =?utf-8?B?VzRhL1pzV0pQOEZjOWFEaFdGTXpqT2dZZG9PczBuQ0ZxZm1TOWtqVmRjWlFN?=
 =?utf-8?B?alVRQ1kwQmQ3S1pEOGt4ejQyVlFUMkRCeEthWnZncmV3Q0tlNDQzOE1sZ0VN?=
 =?utf-8?B?YSszWExOM2tLZHlTM3RYN092Y0dwVTdEVkFFR3dhcllHZWZOSm9JSU43SWpx?=
 =?utf-8?B?RE9vYXVjMnhMODZlcGk4cUJRZlFZa2N4OGtNTUcyWDJQTEwra2hGQ0NkYjRW?=
 =?utf-8?B?NG9nOUtlSTR0dFJCQ3VHRTBrUENxY05WcDVhMEJReEhnaVFVbUM5WGREVWM1?=
 =?utf-8?B?b0dmcmhHWmpYN0JzV2FlZUZPbW5ubWYyVzZieWdZOXRFY0l0elhsbncvWFFG?=
 =?utf-8?B?UjR6cUFLV3puSFBFeDN5alU2YytYcDhKbG9ab0tsUXhjUWxDWFJYalQ0dXVJ?=
 =?utf-8?B?Nk1lek5pSnFBajI3ZEQ2REhvV081cnpVd0p0QzErd0VYanJ2blB0dW9sdDFh?=
 =?utf-8?B?amhTMzZWbUFWb2NRdWh1c3FBVjJZYWVTZW9PaTFNdWk2T1prTVRDSUJCZWFP?=
 =?utf-8?B?TjFBaHlac1ZOcTJZMklLeTB0bUU4ek81bk1walVBOE81bXg2dW5uNkw0amlo?=
 =?utf-8?B?RVVpcStCWktydUZLRWxXb1ExNEExb3pyUlR1K1hibWZTWkFUeEJtcEYzUEZV?=
 =?utf-8?B?eGhHWWxZaHJmWEN2MDZyM0RhRjc1K1NFRHlkWURBSFVxQitiaEZTeGhBVGI4?=
 =?utf-8?B?NmhrRjlvdFQyejlWWmplU2dEZ0F0eGovZll6bS9HUE8zRFpTdGVVUGdMa3Qw?=
 =?utf-8?B?bXo4ZDZzUkIwWGdBNU5rV0hDZ2dlOTVSajZiZGVWaHpOcFN0WUtOaldaMElU?=
 =?utf-8?B?amlydTg2RHJSUTdBa3QxeENJeWxwU0VZUVZZMDFJL1VZTzFHQ0VDOGYyNDNH?=
 =?utf-8?B?QWFHbkVESzFoVUIxeVY3TVJuZjJLU25BbFBaenVIUTNxYzJ4cGtDRTFHZERa?=
 =?utf-8?B?Yyt1clU4dE9xTmNDM2JoWEFtV3lZWkVtT2VrcjJ0bkhEZUdKVXRpUFYvN3FY?=
 =?utf-8?B?cDVsZ1A4YnZqV2l5Z2Z0MW51cFNxaEkyZm1JVlR2QUlUUGhkcDFvaE9CeFAx?=
 =?utf-8?B?OXNPSW9TODJiMFVJRUJJOC8yWm8vb2RHOGFnbE9pdGVPYmFtb2c4Yjl0VWov?=
 =?utf-8?B?ck9pZFIycE5sNi83RUpmaXBXK3A4SUl6QkNUWlQ5WmdDRE1kc255SnFlcHIv?=
 =?utf-8?B?Y21NOTc5aExYMlAxcE41Snk5TnVnK2xQWVhya0loeko1ZU11MS9qa3E3Wllv?=
 =?utf-8?B?THQxbUFlYUx1QjNQa3lMV0R3azhKWUFmOGdnaGhvR2xxV0dpNURlcm8wSUl3?=
 =?utf-8?B?aFNjUnpwMEtxbkpPNUNKZXdOR2pVaW42cjZaTWx4ZTBPMjMrbGNCaFlZWGZZ?=
 =?utf-8?B?d3ZUNkZ5VmpMNElzZzFOejhBV0l2NG5YS0ZtMlBURHpWR0c0QjE5UVg4MVRC?=
 =?utf-8?B?cHBQZWkrVzJNMVNMdEN6YzJTSDIvR0xRbXpFVHo2RDkrUWZxRzczb0U5SFJ3?=
 =?utf-8?B?QlhGcGVBM1U5TnVKOUZBZElWdG5IOWtuRHFGQURub0lQRnRzako1TGh0MHJY?=
 =?utf-8?B?QVltcFIzR0x1aUtqRytHZXpyOENhMXNMdDcrLzl4Zk1YY0xUSWxMNDZ6Q3hy?=
 =?utf-8?B?TzRkV2tFWkh5aXB1RnU3WnhFU1lrUUx4c2tqcGwxTXp2MjV1czZMeUJlSjM4?=
 =?utf-8?B?Lysza3JSSFBlalh5UGlqSlZleFhEc0FJOWwvd29kQzkxQ0p6b3U3Zk5ZL0h4?=
 =?utf-8?B?T2dKY0kwLzJkNE5yS005T2JTM3FtbmYxa2RpaFhiRjJ1VXltYTFyRS9XMXhE?=
 =?utf-8?B?NDRJdVRmZTJ4YzZTOTloTm8xT1FLUU9IVDZsK0FhVTJLR0NyeWpYZmRJY3pm?=
 =?utf-8?Q?/GUVnu2XzFfby5I8hIngQFD9dj6Qv8Xr7LfKZgeK6L1+N?=
x-ms-exchange-antispam-messagedata-1: L3FLYWlleuBzAMfyrH7VYWHx9tlIXiEgrqo=
Content-Type: text/plain; charset="utf-8"
Content-ID: <940398DC7D3C0849B065B3639417645F@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: A+yk7Kldbj/K6h5ZyhYDetI9Ql7Gz2ygMyvuggo50i/EiEVCcYEOM+SoUEZqqoRprLSsR1czmMwatRa/5XXgqb2S00hn3rwRTGjqZStoRhbsjzBaayV4meb3NIh76NaKcfSbL8xn0u6ZpIvEURmD7dj+WX4a+LxCFaPoNlzv3sFK83wMf/Mw8YISEOMqMUIZoBPpGrna0C6lAAwIdvJzm7PF8N9bGfN43LQFQ+FFvbiRsK1T1aelB8JIwzaQkvm/n/7+MfwEVipzzzZo9qryEc/pUUVZiB4smEGXXVfJWeRYOcpDg9wvLjHSFxZNa6M4xGp0hdYCe5wkWzGGpvcsSA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: VCV3WmtiL3cc30A6795drrFDFGwljI/jG/qRMkrTXaopptJcvcHgjMOWujUnLzH9VxscMxJ+BpQmv8zwwMBorKRPTqU5lpoZ5FSrDqfY3jROpNwZNoC50HK95Kq364TnzRnhac8oNXteIAilbuR6h4MiDgvqooyNzXk6WfS+V4QDKxJfXipl4RBqE9jMmRw1YPUE3hrNdD7ir6oAk5c/5xalB7Pp2h8O0jk0U6H2x0ygXNrB+CjP91ZRWzwIr39yRyZSVWP7ajTJmrD4wt6tu2u0vXTKCt/WDq4yUyEyx2OLNW/lNKnjxtwgl3dx9/eBw+J1eWxczoprCucBnPR6hGVTulN7YBZU04MX5tdm2AcWl1tRbYkN3bp46YAIld4AucAu1eGMzzl7qkfHbKNeobpz3KG3f/yOwSJJ1goCjP7MjsgJAsXVUSzoqtAWDmfcTw1tlcY0gb3uPWMNtIFzBcyBlbEA7zBKyNvgVPEzGPVmEVEwzHq5+ijXJwaq4m0zVVWg4ZYJ8UArUA8axfkqIX70TQ04V2edCFvNH/L0HDXI4mMmqvAeM8XhbaGhi7NE11DEGmxlqEvMumSaXg77TxNub9PTUSn53xlcy9DuDXsrqblIJLE7oetPOMi4UJ7L
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY1PR04MB9561.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 166c73fd-958f-4c42-b7b6-08df20106ced
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2026 23:05:02.8160 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dqZyBSgWNIH44Nxe8Wtujxq8QH7jqNZfqstn1iR9eCYZk2NLc3tICsevrX086NEPZEmcW8ahm1XFhOioXeUYmQd5w0je91NUObN7HBOYBhQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH4PR04MB9460
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

T24gTW9uLCAyMDI2LTA5LTI4IGF0IDE3OjExIC0wMzAwLCBEYW5pZWwgSGVucmlxdWUgQmFyYm96
YSB3cm90ZToKPiBIaSwKPiAKPiBJbiB0aGlzIHZlcnNpb24gd2UgYWRkZWQgYSBzbWFsbCBhZGRl
bmR1biBpbiB0aGUgcmlzY3Ytc2VydmVyLXJlZgo+IGNvbW1hbmQgbGluZSB0byBzaG93IGhvdyB0
byBpbnN0YW50aWF0ZSBhIGUxMDAwZSBjYXJkIHdpdGggdGhlIGJvYXJkLgo+IAo+IE5vIG90aGVy
IGNoYW5nZXMgbWFkZS4gUGF0Y2hlcyBiYXNlZCBiYXNlZCBvbiB0b3Agb2Ygc2RleHQtdjEwOgo+
IAo+ICJbUEFUQ0ggdjEwIDAvN10gcmlzY3Y6IGFkZCBpbml0aWFsIHNkZXh0IHN1cHBvcnQiCj4g
Cj4gQ2hhbmdlcyBmcm9tIHYxMzoKPiAtIHBhdGNoIDU6Cj4gwqAgLSBhZGRlZCAnZTEwMDBlJyBj
b21tYW5kIGxpbmUgZXhhbXBsZQo+IC0gdjEyIGxpbms6Cj4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5v
cmcvcWVtdS1kZXZlbC8yMDI2MDkxNzE3NDQwNS4zNDcxNzM2LTEtZGFuaWVsLmJhcmJvemFAb3Nz
LnF1YWxjb21tLmNvbS8KPiAKPiAKPiAKPiBEYW5pZWwgSGVucmlxdWUgQmFyYm96YSAoNSk6Cj4g
wqAgdGFyZ2V0L3Jpc2N2L2NwdS5jOiByZW1vdmUgJ2JhcmUnIGNvbmRpdGlvbiBmb3IgLnByb2Zp
bGUKPiDCoCB0YXJnZXQvcmlzY3Y6IGFkZCByaXNjdi1zZXJ2ZXItcmVmIENQVQo+IMKgIGh3L3Jp
c2N2OiBzZXJ2ZXIgcGxhdGZvcm0gcmVmZXJlbmNlIG1hY2hpbmUKPiDCoCB0ZXN0cy9mdW5jdGlv
bmFsL3Jpc2N2NjQ6IGFkZCByaXNjdi1zZXJ2ZXItcmVmIHRlc3RzCj4gwqAgZG9jczogYWRkIHJp
c2N2LXNlcnZlci1yZWYucnN0CgpSZXZpZXdlZC1ieTogQWxpc3RhaXIgRnJhbmNpcyA8YWxpc3Rh
aXIuZnJhbmNpc0B3ZGMuY29tPgoKQWxpc3RhaXIKCj4gCj4gwqBjb25maWdzL2RldmljZXMvcmlz
Y3Y2NC1zb2Z0bW11L2RlZmF1bHQubWFrIHzCoMKgIDEgKwo+IMKgZG9jcy9zeXN0ZW0vcmlzY3Yv
cmlzY3Ytc2VydmVyLXJlZi5yc3TCoMKgwqDCoMKgIHzCoCA2NSArKwo+IMKgZG9jcy9zeXN0ZW0v
dGFyZ2V0LXJpc2N2LnJzdMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8wqDCoCAxICsK
PiDCoGh3L3Jpc2N2L0tjb25maWfCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgfMKgIDE3ICsKPiDCoGh3L3Jpc2N2L21lc29uLmJ1aWxkwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8wqDCoCAxICsKPiDCoGh3
L3Jpc2N2L3NlcnZlcl9wbGF0Zm9ybV9yZWYuY8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHwg
Nzc2Cj4gKysrKysrKysrKysrKysrKysrKysKPiDCoHRhcmdldC9yaXNjdi9jcHUtcW9tLmjCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKgwqAgMSArCj4gwqB0YXJn
ZXQvcmlzY3YvY3B1LmPCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCB8wqAgMzUgKy0KPiDCoHRlc3RzL2Z1bmN0aW9uYWwvcmlzY3Y2NC9tZXNvbi5idWls
ZMKgwqDCoMKgwqDCoMKgIHzCoMKgIDIgKwo+IMKgdGVzdHMvZnVuY3Rpb25hbC9yaXNjdjY0L3Rl
c3Rfb3BlbnNiaS5wecKgwqDCoCB8wqDCoCA0ICsKPiDCoHRlc3RzL2Z1bmN0aW9uYWwvcmlzY3Y2
NC90ZXN0X3NlcnZlcl9yZWYucHkgfMKgIDkwICsrKwo+IMKgMTEgZmlsZXMgY2hhbmdlZCwgOTky
IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkKPiDCoGNyZWF0ZSBtb2RlIDEwMDY0NCBkb2Nz
L3N5c3RlbS9yaXNjdi9yaXNjdi1zZXJ2ZXItcmVmLnJzdAo+IMKgY3JlYXRlIG1vZGUgMTAwNjQ0
IGh3L3Jpc2N2L3NlcnZlcl9wbGF0Zm9ybV9yZWYuYwo+IMKgY3JlYXRlIG1vZGUgMTAwNzU1IHRl
c3RzL2Z1bmN0aW9uYWwvcmlzY3Y2NC90ZXN0X3NlcnZlcl9yZWYucHkK

