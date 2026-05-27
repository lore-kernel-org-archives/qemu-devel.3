Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31F63CD5BD2
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2026 00:07:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wS1mh-0006j4-9q; Tue, 26 May 2026 20:06:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=6009f06ea=Alistair.Francis@wdc.com>)
 id 1wS1mc-0006iS-VT; Tue, 26 May 2026 20:06:03 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=6009f06ea=Alistair.Francis@wdc.com>)
 id 1wS1ma-0005dO-Jo; Tue, 26 May 2026 20:06:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1779840360; x=1811376360;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=7LRvM9VMjY8u1LT5a2smUqwL5zXiivMNLClWJEyCWns=;
 b=bcUBEtYTAm5MjwZyUM2oJY3FIv7gw4R/SaQBlW+iRTfLw1UQzyYNucAc
 gM7ASDZvl/TXbYqErTxOB9QlrXrN6xpXFMst8ke1iVNOTSJyeN+8oMQ3v
 0KvckVdVQjroZ7d6Lhf+4+ouJLzzuX5mEEhwGpaaiVW5Y71OIsVCeKEGZ
 9gjCqQPDOUYlnK2FNr+QIOLHWaMAOQOEktph9HGO2CcO3rIUYj+nq1wc+
 ftB7u8HD+9UiPSmw+EWLjLJCOcB6RT8ivJR2b4+qVh08mWuk4LWfqHm88
 RfEp1zYZqX61P0baNdcJZuC0Rzx+Glae1GguXfRCTq7j6YBpg3ybW0sjf g==;
X-CSE-ConnectionGUID: x39H9qMZQU2pZmObyZ/5QA==
X-CSE-MsgGUID: LJ54bKOPRsaIvfk3I4CTeg==
X-IronPort-AV: E=Sophos;i="6.24,170,1774281600"; d="scan'208";a="146881905"
Received: from mail-westcentralusazon11013005.outbound.protection.outlook.com
 (HELO CY3PR05CU001.outbound.protection.outlook.com) ([40.93.201.5])
 by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 27 May 2026 08:05:55 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KgLELUIk6Tg2HyNVNFp5qTycbW/brwlERuqYQ0vyFriIEU0ZNFC1rZ9GFiWWecYQiHp7aEvFmpyaVFOFirQRfxPS8M0RwiJ5SFrWTnAXj2GvRfFW1R6LpNVdv4tGYMcPLao427/PM8Wi7oBiwIr5iofqyHq3OVbUyrp/owPnP2NNOcj3NAbgAXR/gphKEghOw3v7lTlDFynzWAnqUuCAlsqoXdqWFOQGQ6YF3dcj9yAWhmOBct/nZRsDZq84DFpAmQxNn/rqhr3VF4tlg0wdfB5mfPnqgnyc7EZ3DIt0d2qQ0XE5Tmc2Wev5G6C7tG9Dre02+RyfZY+YwPdB4fIWjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7LRvM9VMjY8u1LT5a2smUqwL5zXiivMNLClWJEyCWns=;
 b=QNvzRY6QiREAM6m1mQKdXgyurMt+9n+XAvAacl0X9qtJmBAVXnXTW/hkrMeolT4O1bffqvX6W0qsMmY76K7p4INBX8P/zNlOWA4UA58b/Zet1lWSdSU0PESzVpMO1XzBN5X2iNlHs3D+kZnIRxyVGAPiQMjbEtV6SBEEAHwpDR+SWhwlqjGGerw7MKfUCLOe5bTEN2u12VDPJkTl2OW6MjmQ2LdpHSmIttH0qMYg/5b9iFXtnFEpDIIqnTxh4E9H/PrZIP14HoLu/F2XVY3PEYhRUDl4ZkQCm0hBRQwHUevSGY6i9A/IlRTGtACEtiGWnOpv00DdCZcWvSB0uvdimg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7LRvM9VMjY8u1LT5a2smUqwL5zXiivMNLClWJEyCWns=;
 b=wZlQjTBdb2rrrhjVjC5y5+gd+ZB2TPA8suwfJEogN9clWtqqj0SusF6mYYW5pJbwonn0KNN64uxZrZ5L2BVxCdUujguCaikIrW1WSRTNMttlG0nZxQmRYt2GYQLiY8PFSl1c6jHheZ0IE9M7l1+83k31Rqzq7GP5lOb+yoqkvAk=
Received: from BY1PR04MB9561.namprd04.prod.outlook.com (2603:10b6:a03:5b6::11)
 by CO6PR04MB7876.namprd04.prod.outlook.com (2603:10b6:303:138::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.11; Wed, 27 May
 2026 00:05:53 +0000
Received: from BY1PR04MB9561.namprd04.prod.outlook.com
 ([fe80::3869:e494:2fa8:9888]) by BY1PR04MB9561.namprd04.prod.outlook.com
 ([fe80::3869:e494:2fa8:9888%4]) with mapi id 15.21.0071.011; Wed, 27 May 2026
 00:05:53 +0000
From: Alistair Francis <Alistair.Francis@wdc.com>
To: "fritchleybohrer@gmail.com" <fritchleybohrer@gmail.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "palmer@dabbelt.com"
 <palmer@dabbelt.com>, "daniel.barboza@oss.qualcomm.com"
 <daniel.barboza@oss.qualcomm.com>, "chao.liu.zevorn@gmail.com"
 <chao.liu.zevorn@gmail.com>, "liwei1518@gmail.com" <liwei1518@gmail.com>,
 "zhiwei_liu@linux.alibaba.com" <zhiwei_liu@linux.alibaba.com>
Subject: Re: [PATCH] target/riscv: Do not hide Sstc CSRs from gdbstub
Thread-Topic: [PATCH] target/riscv: Do not hide Sstc CSRs from gdbstub
Thread-Index: AQHc6/ArKlcZwID1aU2b+3imczrqfLYhAUgA
Date: Wed, 27 May 2026 00:05:52 +0000
Message-ID: <528c3bd4deaa41e9b29df1000bd8cb534ce5cc21.camel@wdc.com>
References: <20260525024220.39027-1-fritchleybohrer@gmail.com>
In-Reply-To: <20260525024220.39027-1-fritchleybohrer@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.60.1 (by Flathub.org) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY1PR04MB9561:EE_|CO6PR04MB7876:EE_
x-ms-office365-filtering-correlation-id: 9a54e0ad-ef48-41eb-670b-08debb83b7ae
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|10070799003|366016|19092799006|6133799003|11063799006|22082099003|18002099003|56012099006|38070700021;
x-microsoft-antispam-message-info: U/0KDTslj2qnc4wbVFpazSTIQ6DwnZ77fmwc7Ush6CXSpAvhOUMsOadXLXZ9GJmoRbU+q1xzb+DJ9YxA4Fqkh2cltmwbkQQhFupvmnwOJSNmXzYADCB9Gh9YmLRgB0yxqPr5VcycPJ6aoUinHXscPrGqbzX2xPUExirq4xolcrr32Jie3wb+y2MMxzDQXSgORQcEemwSxZpBU9V5uL1uYHCYWvnj0zNqJOdt6ah2gXIBM5tvgJeofGbRrpr6h3ciZ/oxQcc9BUpCA4P8ZlQCPKHUBBlo9s0jle8klu3NzoIgIl3tc1EJLHh1LljLMLnuATi3mF4TJJioAw9gy3L3dbe96bybRTsoNsap3MeobG0lO62UaXH0oNCi4KdUV2bLZ9NxVkjpjIZkiJGg9rzMY1lmsOZGPWY7rx0dMY5A9VwI4Y2+p27DPziFH/RwJc3UZv1jSDcAfVDnzAxIeqgZDbWwok2b73S4TcY/7Wm0iLeS+cwnaFvClttnu507SnODBHm8j6satMAAFYWDdJpBbPhPVoNc7lbSB/Xk5X244ahWPPXirJynBj9RQcxw6s+UMNWFwnvIdz4ZmoM2z0vnogSxTlZyJ1/fnK4cnvtw/jQxoqtEiLnQDykzIqix8u5IxOjq1nzfRGlEoZcw/97/RhjUN7303ZbQIB8ynDFH8x9akGZ38C3WqhvTpLUlSgaGM1gIV54Og9rn6ANrlo7EHzxVYZvZdV4yY4Ur8mH0bbBocEIiCWbFyBRLvUNz0lKL
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY1PR04MB9561.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(10070799003)(366016)(19092799006)(6133799003)(11063799006)(22082099003)(18002099003)(56012099006)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YkdwMHIrYUFuWFdLK0VZblRFaU1jUUl5TFNBcEVONU5vQVdSMEJ4OWZ1K1J6?=
 =?utf-8?B?WWdMM2hjSCtiTmIrT2pxYjZpZkdrOXlRYzVXdXpBUksvMFUrUVFLM2VaaUFV?=
 =?utf-8?B?U2VGeGxMSXFSZHduUGZxc253WGthVVhCRWxiZnVuUDZacXRtWVdwSUQ3cVpY?=
 =?utf-8?B?YVhuek9NTzEyeTBBYm54R1dCY0NRUkxySlc5ekR3NzNITkJ1Rm82UEh4TlN2?=
 =?utf-8?B?OURaUjJZRnd2RGg3KzNDK2dNbVFKMmZvbXJHMlRtOWpEVFJKVUlNRTJPRjVF?=
 =?utf-8?B?MGtjT3dzM0JnWXJUSHMwWExuT3ZwRjkxL25uVTIwMzc3eXFQZnZZUVhPVnVN?=
 =?utf-8?B?c3hnbDlzT0JGNjF2U1VlaWNsNlhwYXd1cno3MGxRelRRMW5lR0hBejBuU0l1?=
 =?utf-8?B?QzhOK3FCWjZtOVFUZE4xNlo2TmRJY3kyQ2I4eVdmZFgzQVdWVXRsRDY2Ulhm?=
 =?utf-8?B?aU51RFRkUEwwcmhvMkg4Y0JHdU84THhCdE9aQTZkcDdPWlJqV202Q3BIblV4?=
 =?utf-8?B?RktKRysrRTBDQ0hwWmp5Rzh5dU1JVmRIVnpwbTh3K2Jkbi8veEp2d29kVDFQ?=
 =?utf-8?B?Rk1EL2hNUHMxMWtWQWI2Rjl0S3g3bzFNWEwzWTRHRE1MWjdXdU5ZTWhJTkNE?=
 =?utf-8?B?cnFWTEV6aVE5NVIybnEvcTZLYmtyOUFMVVYxMDhLMzg4Vm05Nkxqd2ZNWkdR?=
 =?utf-8?B?blE5TTRyeEdjQUFsWUE4NU56dW9GTWIrZGd3dVc4cXJINFRUSUVwSk91UTFl?=
 =?utf-8?B?VUlkM3hjcWtTSm91TE5WUXJSQlFwM2d4VE1ZYURWSkRVajRzK3RjN1FmR2FH?=
 =?utf-8?B?UlpOTlFKc1hndG5HYVRHUUowWmQ5UmdiSWlTNzFwUFBWNXBrWWd2WXVyakRB?=
 =?utf-8?B?cElaL0p3ZCtNcGtEM1RqOWhLbFAva2c1MU1PS2RIemtZd1JuZ1cyU2g5TzBY?=
 =?utf-8?B?NS9vUlpEMERjc1hiczJSaDl2NDFvTkxKSWZkanQ4UnBOQ2J2eTJ5VW9zckE1?=
 =?utf-8?B?VGxFbmdaWWp3NS94aTh5UVF4MG02aEptdjJZTVIzcHZ1ekVtaklOdzJ2a3gv?=
 =?utf-8?B?c3Z3L01Yc2FRbkRNUUd5dFNCc3FDdHJjaURTbkNUVVk4RjF6UWRscXE5cnBz?=
 =?utf-8?B?SmFHUDBQY2RQaXpwaG55a3NIVnhaMlpIRE5POVBtSHlXN2EvZ2s5TWl5UTdF?=
 =?utf-8?B?b21JM0lpQkFPRzROdGNKaEgyaHFHamttejl5NjUxcHVpUmR1RHh4SVNaN1M5?=
 =?utf-8?B?MnlPdzhLQWdPc2NWZ21sYklWLzNYVVV0dU1kMENydE8vRTc0b1B3VVdKazRs?=
 =?utf-8?B?K3J6TFliL2ZIVUN0U3NxbzhUcnBEWkJXOXcxV3NUUFVaVHYwN2ZhZ0xvSWRJ?=
 =?utf-8?B?ZnBCWGEzNWVjZndNaXZsRW1SSldiazZPeDFQM0YzVWYwZ1c0eDFuWnBMc3pw?=
 =?utf-8?B?Njdhc2dDTWxEWWF3UHRaVWdLL1RZQ0FVcVBjeG9QOVBnNEdCcXVSQVpldUVz?=
 =?utf-8?B?NTc2MXl1NmoxMm1EalRkdUJuL2d5ZDlUMGl2bU40ajh4Y05ZSlAwMTQyTDVy?=
 =?utf-8?B?cUVCSG9DQUVPUk91cGRMd3FHZ3phMUE2Y1owMGgxVjVINTdiKy9kU2J5QnRh?=
 =?utf-8?B?RXVmdWdxdFI1RlV6Y01CcnRjbURTTWJjSEpocHBOYmpIbkZ5WldmZlZ1WjdV?=
 =?utf-8?B?L3ZyWHJhd1gzN1NjNTFCWnFDSXRub05FaS9UQ1NCZ2VwejdaWVcyaEFwTE9O?=
 =?utf-8?B?WHEzZno4RFJCbVFYODFQS0lQMEYyZGQwQ0xWSVJHRzQvcDJTUnFQUXFtS0Q4?=
 =?utf-8?B?VHAzWUxHR1FMZ0lxUVJxT0o1R2NpQUxManhRVFlHa2p2ckRiVUYvQmtUSFUr?=
 =?utf-8?B?MUQwV1NwNE1mVFZxMzBXNlp2Q21TMXRrNmtpQ2JqSUxJcjl0T3E1N3BYeVZW?=
 =?utf-8?B?cGFROFgyRGIycHJyZ1NMOVViZkh1cEExUHhsTWt1SFRaVkcxSURveDJtZnFy?=
 =?utf-8?B?WVIrd05OWndLSU5jSU1mRUZsMmttVk42eUNQa1ZITXJPbTFhR1pBM2txOHk0?=
 =?utf-8?B?YWltM3d3eWtKUjg0aE1idlRBODR4WjU2dnNvUXg3S1UwV3hROTFldHVKOVdX?=
 =?utf-8?B?cHl4S1VEZEFicEJNbzhYdzcyREp6K1dNb09EeVA0cVJTTytNeW9NNHFZMEMr?=
 =?utf-8?B?bjliSlduUnhOdHhVYTViTDdQM2RCQUNwR3FyWFFRelh2djhoWHVyVGN0aU1m?=
 =?utf-8?B?OUxValFscHJiZkhQTnc1RnM5UkY1N0JTYS9uR01CYmRjZVZKOGJtRzFjZWJ6?=
 =?utf-8?B?c3Bwak12dVpaRHhHcDlqRnMwWHV3aEZvWWVZQTdXVjEva1hURWdVeU96RkVp?=
 =?utf-8?Q?MLSWSCASyBqMwUfIkUWHatUrzdNkpXslbQNVal3qGPUnT?=
x-ms-exchange-antispam-messagedata-1: +EH7vEqta7Oo+JG/LgdWfhqMFwhqeKtXbY8=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D3E86587BE491849BCD37505B274FA2F@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: TW30rgSHZ7eVDGvO/WAURMohFpIt3IR/lDmNzkZVFdt4aLSE8dx4G95UOfMMIo7KGq3+hZKbySxGphXasLPFDSs2OKiLG/mANs/qmJofFwb7DOI0lt6Cvk5Lk1Id+xRCxAxzpF1By7p0Q5D8J4MlmPEL7FuEAJLYFqB0fdJTtm7EHW66NeE1s4/I0upX/rL1aJLj1M66kV4PQws/jjgVxi5Ix2/uF+gpdmXKVR0FV+vR1JonQJfc42KdGTLIN/SdPVbIy+mTPvkh1WP1mySyurNQPHhMrQFk2TQ0q+cSX8N+4JRXi4pqVoXZENkxnGlm+bbF9knuhVLs+N2s7d5IUQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: /5dnfgGiMPc5e7B0F33yE10xIduAWdRqRIY4YLwPZeNeD4yuxYmn1NT/isnAtPbVO5wneQpFNfi/toDAiM9PAJtfwTORm9vjKFNEREkt0h9YOxbTWb26B2SF2W6MPskkJ2XYYjcfW5aEQ9FWykWSL1qTDHC5Cu2MzpSp7ImumYLnzT4GOe1Nhum+3al7EFjcv5dUGIEqUVaCFOZBXcLQmgktRZR1EdpTd95OgeAFC3z+tr2J18m+gfak3J6mgW9FM0xBJyxv6DrAwUIjCMAgfxRvUNi2QABGMmLQRzUZt9BDTDberBiiAUdizdE5koD1fJO7ehhYCv/bObizJ6sCnMXq6AzUd3N7YxkuE47XVyXeFvx6JbUCLCkFpwLKkZzhrGfkimYtaBRqtsmLtjY7jEQRsWq7edohrrCCJAKMNwC4m2XZ7lagEdoNPDvJy4kukxy9x2LkDvldWBZMaUAtj+9MuyZ3tyopz5s7GYXk/rHMSREuGcARHfHE0fGg3F6zvD5k5zwgVfRsEqHnI3CBB0oIxrc6lbbkPwev9XHSaBm8Tgu6uyYe6Is3/xl33FG6HOzGhlUtEvc1AAPQI+CRgCTVQxwC5W8ggKYLrv1SZ12ekdK+bH0y9KdA1+XGHAys
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY1PR04MB9561.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a54e0ad-ef48-41eb-670b-08debb83b7ae
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 May 2026 00:05:52.9656 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0Wyx+OGmmu6Qol1b65gHuW54Xhcn0WNTSfcHlTDwIVtNb71NK4TV7AJSy9IOlDJi2vIv2GVAFN2Sf0T7FIldukpZ7qNhNtj1g9bacLsnVtE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR04MB7876
Received-SPF: pass client-ip=216.71.153.144;
 envelope-from=prvs=6009f06ea=Alistair.Francis@wdc.com;
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

T24gTW9uLCAyMDI2LTA1LTI1IGF0IDEwOjQyICswODAwLCBaZXBoeXIgTGkgd3JvdGU6DQo+IFRo
ZSBTc3RjIHByZWRpY2F0ZSBjdXJyZW50bHkgY2hlY2tzIGJvdGggZXh0X3NzdGMgYW5kIHJkdGlt
ZV9mbi4gVGhpcw0KPiBjYXVzZXMgdGhlIGdkYnN0dWIgQ1NSIFhNTCBnZW5lcmF0aW9uIHRvIHNr
aXAgU3N0YyBDU1JzIHdoZW4NCj4gcmR0aW1lX2ZuDQo+IGhhcyBub3QgYmVlbiBpbml0aWFsaXpl
ZCB5ZXQsIGV2ZW4gaWYgdGhlIENQVSBzdXBwb3J0cyBTc3RjLg0KPiANCj4gQXMgYSByZXN1bHQs
IEdEQiByZXBvcnRzICRzdGltZWNtcCBhcyB2b2lkIHdpdGggYSBDUFUgdGhhdCBleHBvc2VzDQo+
IHRoZQ0KPiBzc3RjIGV4dGVuc2lvbi4NCj4gDQo+IE9ubHkgdXNlIGV4dF9zc3RjIGZvciB0aGUg
ZWFybHkgZXhpc3RlbmNlIGNoZWNrLCBhbmQga2VlcCB0aGUNCj4gcmR0aW1lX2ZuDQo+IGNoZWNr
IGZvciBub24tZGVidWdnZXIgYWNjZXNzZXMuDQo+IA0KPiBSZXNvbHZlczogaHR0cHM6Ly9naXRs
YWIuY29tL3FlbXUtcHJvamVjdC9xZW11Ly0vd29ya19pdGVtcy8zNDk2DQo+IFNpZ25lZC1vZmYt
Ynk6IFplcGh5ciBMaSA8ZnJpdGNobGV5Ym9ocmVyQGdtYWlsLmNvbT4NCg0KUmV2aWV3ZWQtYnk6
IEFsaXN0YWlyIEZyYW5jaXMgPGFsaXN0YWlyLmZyYW5jaXNAd2RjLmNvbT4NCg0KQWxpc3RhaXIN
Cg0KPiAtLS0NCj4gDQo+IFRlc3Rpbmc6DQo+IMKgwqDCoCBTdGFydCBRRU1VIHdpdGg6DQo+IMKg
wqDCoMKgwqDCoMKgIHFlbXUtc3lzdGVtLXJpc2N2NjQgLU0gdmlydCxhY2xpbnQ9b24gLWNwdSBt
YXgsc3N0Yz10cnVlIC1zIC0NCj4gUyAtbm9ncmFwaGljDQo+IA0KPiDCoMKgwqAgQmVmb3JlOg0K
PiDCoMKgwqDCoMKgwqDCoCAoZ2RiKSBwICRzdGltZWNtcA0KPiDCoMKgwqDCoMKgwqDCoCAkMSA9
IHZvaWQNCj4gDQo+IMKgwqDCoCBBZnRlcjoNCj4gwqDCoMKgwqDCoMKgwqAgKGdkYikgcCAkc3Rp
bWVjbXANCj4gwqDCoMKgwqDCoMKgwqAgJDEgPSAwDQo+IA0KPiDCoHRhcmdldC9yaXNjdi9jc3Iu
YyB8IDYgKysrKystDQo+IMKgMSBmaWxlIGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygrKSwgMSBkZWxl
dGlvbigtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL3RhcmdldC9yaXNjdi9jc3IuYyBiL3RhcmdldC9y
aXNjdi9jc3IuYw0KPiBpbmRleCBkYTM2NmNmNTYyLi5jMTdkZjE0N2Y3IDEwMDY0NA0KPiAtLS0g
YS90YXJnZXQvcmlzY3YvY3NyLmMNCj4gKysrIGIvdGFyZ2V0L3Jpc2N2L2Nzci5jDQo+IEBAIC01
ODYsNyArNTg2LDcgQEAgc3RhdGljIFJJU0NWRXhjZXB0aW9uIHNzdGMoQ1BVUklTQ1ZTdGF0ZSAq
ZW52LA0KPiBpbnQgY3Nybm8pDQo+IMKgew0KPiDCoMKgwqDCoCBib29sIGhtb2RlX2NoZWNrID0g
ZmFsc2U7DQo+IMKgDQo+IC3CoMKgwqAgaWYgKCFyaXNjdl9jcHVfY2ZnKGVudiktPmV4dF9zc3Rj
IHx8ICFlbnYtPnJkdGltZV9mbikgew0KPiArwqDCoMKgIGlmICghcmlzY3ZfY3B1X2NmZyhlbnYp
LT5leHRfc3N0Yykgew0KPiDCoMKgwqDCoMKgwqDCoMKgIHJldHVybiBSSVNDVl9FWENQX0lMTEVH
QUxfSU5TVDsNCj4gwqDCoMKgwqAgfQ0KPiDCoA0KPiBAQCAtNjAzLDYgKzYwMywxMCBAQCBzdGF0
aWMgUklTQ1ZFeGNlcHRpb24gc3N0YyhDUFVSSVNDVlN0YXRlICplbnYsDQo+IGludCBjc3JubykN
Cj4gwqDCoMKgwqDCoMKgwqDCoCByZXR1cm4gUklTQ1ZfRVhDUF9OT05FOw0KPiDCoMKgwqDCoCB9
DQo+IMKgDQo+ICvCoMKgwqAgaWYgKCFlbnYtPnJkdGltZV9mbikgew0KPiArwqDCoMKgwqDCoMKg
wqAgcmV0dXJuIFJJU0NWX0VYQ1BfSUxMRUdBTF9JTlNUOw0KPiArwqDCoMKgIH0NCj4gKw0KPiDC
oMKgwqDCoCBpZiAoZW52LT5wcml2ID09IFBSVl9NKSB7DQo+IMKgwqDCoMKgwqDCoMKgwqAgcmV0
dXJuIFJJU0NWX0VYQ1BfTk9ORTsNCj4gwqDCoMKgwqAgfQ0K

