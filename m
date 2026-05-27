Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2C32CD6E43
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2026 01:29:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wS33u-0005Jj-M6; Tue, 26 May 2026 21:27:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=6009f06ea=Alistair.Francis@wdc.com>)
 id 1wS33t-0005J0-Cs; Tue, 26 May 2026 21:27:57 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=6009f06ea=Alistair.Francis@wdc.com>)
 id 1wS33r-00072E-1d; Tue, 26 May 2026 21:27:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1779845275; x=1811381275;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=vSlN44IOH6DeLpS8ZvVfEf6da74CdLo/4D13Y8VAQTI=;
 b=SHe/44mkAvwrVC+PmK+Z57pYKcPl9gz+RxlZA+9XDaCu5SYbYQVjAGkO
 q77l/AEB3eKswptEzmwcmIsNQ23H5ase9oEgrrFi+eLlC41p693TL92T7
 CkdTg7ORW1i/dz/mgG7IeHWozCLOnsmLAwSafpnOq4tyTqbxWL6bfTJd8
 zSj++GIKh99c0g+gh/5yIpi5NnaYL+BR4s9OeiogXH1HXQwq332SucvFw
 y4/w+KTowkbPd7iz1BmBUgJxhUfywBkUfJXYAJWuRCNxvLIoFcGGQ1dDa
 zfb4X2UnbvFrN2qI/mKB+NoLhYRsQKaPs8c6cICa5Y6fg21bgor2ABfen g==;
X-CSE-ConnectionGUID: oa1bC68FQSaBUDVl1s3VKg==
X-CSE-MsgGUID: FRPZWcNKQvi/EElOkiTBTA==
X-IronPort-AV: E=Sophos;i="6.24,170,1774281600"; d="scan'208";a="147473792"
Received: from mail-westcentralusazon11013042.outbound.protection.outlook.com
 (HELO CY3PR05CU001.outbound.protection.outlook.com) ([40.93.201.42])
 by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 27 May 2026 09:27:40 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aYPgFalWkeFoohJYHdBtuQDXTARAlYxVBJekYAMn2UJqgYjwSDo/57m26nMgVBjcmKO5gN7zH1dVAu+SZ7q0cOPm1kG4sK2qb2Kswh+IQN9Qx36p6j+AwLh8vIGi77Ws2n42ZepdXa1kzW/+HaW3yrOtA5JfGT7os9ETUaUvPM6weO3YvKTGXgxl/9Uwp/E6mzWns0MkkC4emKoUSVkxQkqj0smdP512CbRXdy/AjUajif1Rp+izpCd1QcH5wDZJox7NWKUA8d6LdqeU/gSdRliCYM0JXicr0Kf/gYCdV4pFjOpsXgwMMEs6SiBmUMXinCX1xjtkaMST4IXPaEMy8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vSlN44IOH6DeLpS8ZvVfEf6da74CdLo/4D13Y8VAQTI=;
 b=l8FKP/EUmV/NjHu8iZvMq1qwM7vaDgVEqHnhHhZ2V4fKO2jmJqFtVlW0nctb+VF5Oah+8QrBmLpVggIcU7ok0UkuczBQbqlDRprUnuPMsfaCZ5TFl4A7ZuQzx9r4BhTkT0J140xGf7pTEEY35yFqYnCmoBb7xtY4U78J6LGzP2lPT3bezVWzBcbOmXHmtCU8VKAkwhsktGPAEXHwrXWPlkan0MPxJrWWQ6jSvb5I9araNvsAw/5/SPHyDompcCIm0xW11sOuJJAFrAzJ4Wjl1iE+tc1LoRYIToVgehCYKSkxcYGl3J27n84sgz/c2C0XDSYDEzQRPVF+m2numft6sQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vSlN44IOH6DeLpS8ZvVfEf6da74CdLo/4D13Y8VAQTI=;
 b=TFIKDLRj51KKV6/NYcRwxqMg3n9cDJj+fmF0/xvKDxQmRZltr/NMm84OQ+i6AXXuLG4muDUMQEbn3dW6JULyJzTUQ5UWCfTwqalHnVAihCw6tRtLvw4sHUDdss402H5XBhbTOAR48hNdts7eg1cBGdNc7CJSd1WjA5VWsw3Zgpc=
Received: from BY1PR04MB9561.namprd04.prod.outlook.com (2603:10b6:a03:5b6::11)
 by MN2PR04MB6973.namprd04.prod.outlook.com (2603:10b6:208:1ed::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Wed, 27 May
 2026 01:27:38 +0000
Received: from BY1PR04MB9561.namprd04.prod.outlook.com
 ([fe80::3869:e494:2fa8:9888]) by BY1PR04MB9561.namprd04.prod.outlook.com
 ([fe80::3869:e494:2fa8:9888%4]) with mapi id 15.21.0071.011; Wed, 27 May 2026
 01:27:38 +0000
From: Alistair Francis <Alistair.Francis@wdc.com>
To: "daniel.barboza@oss.qualcomm.com" <daniel.barboza@oss.qualcomm.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>,
 "chao.liu.zevorn@gmail.com" <chao.liu.zevorn@gmail.com>,
 "liwei1518@gmail.com" <liwei1518@gmail.com>, "zhiwei_liu@linux.alibaba.com"
 <zhiwei_liu@linux.alibaba.com>
Subject: Re: [PATCH] target/riscv/cpu_helper.c: fault with reserved PTE.PBMT
 val
Thread-Topic: [PATCH] target/riscv/cpu_helper.c: fault with reserved PTE.PBMT
 val
Thread-Index: AQHc6SLStPtYEzHEwk2PCRKqM+Us2bYhHbqA
Date: Wed, 27 May 2026 01:27:38 +0000
Message-ID: <a0a839891ff7a44de6ec1bbf793f06c907879b3c.camel@wdc.com>
References: <20260521130727.2311629-1-daniel.barboza@oss.qualcomm.com>
In-Reply-To: <20260521130727.2311629-1-daniel.barboza@oss.qualcomm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.60.1 (by Flathub.org) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY1PR04MB9561:EE_|MN2PR04MB6973:EE_
x-ms-office365-filtering-correlation-id: 625c10f6-db14-4a36-074e-08debb8f236b
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|10070799003|366016|1800799024|19092799006|38070700021|11063799006|56012099006|22082099003|18002099003;
x-microsoft-antispam-message-info: fE10Bm0WRgnT8qPs/QrK0oFZN34zmHoPJ4g5c4NukTr4Egwyzpe0YGQpbtzI9fRQ/q8TtplNLiEw/pApFT6oczo4moH/Ah6dqmKZokX+6WbDpUPbI1DjpbCXWwbhhB20IkWaeNMQAELlHN8faaJ81TatQXi3yPbZNWav4P64Q6bvQ+t7l/x3Caea42z2eOIyqHGDB3Et0IMscXYb8D8f9QNN1KUNyS0W/fWqRil69wuLrizb4QeEfY7041MUoOCSqYPUDefugMGmrgyhWF4PgdCtV5jUIiTFBr/7vYOY/CEDb+r2oFQsKyrzYz3U3ji9Y3jRoeIiEFdPXkajQmg3tAsWfvt7TugHDEeayvTShNI1iyI4YMTr03kKmIuGe0FBfPLZMvqRtVGjX4EIJ3uE5NdbXM8IIYGfcCVeKYXZemfVYIDZ4tZMfDldkqVceMkdWhcfEnh4xg7XCBcjmxS4BhBBPyRazHIoK6wofevazytZ3Pki3vL0fRKu95/tztXfK1P/Arqg6A275aTpjcKoS8Jjws17wU1ZfpGfyWWsPOfsk53zZN1+uv8pD1EmjgkmSszFx4dhe/9ua0XGJ8+SXHSY6WMPt7VypifqofTGG2X56Qm9C/Wu2xEYLijZ79mdcdPdQzlbz4T8TJelZFAQUzoBAnQTi6gq0ItVAMhWeFQIpxmaDipR6PPt1DgStoAQE/3445trQvpQLUBrCfRSHzCQir4faq9y4VsO1xRlMCZnANCekD60SP8vOQU1ZjzY
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY1PR04MB9561.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(10070799003)(366016)(1800799024)(19092799006)(38070700021)(11063799006)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RlB0Nm41Z3pieHI3bmdzM2hmWUx5MEQ1Z01oUER2eE1xZ21XcldDcEYzTUdV?=
 =?utf-8?B?SWZZdVJQTWFZREhGakQzbEdVS2tzKzlIVlFDMUpnaFlHWmJqMUVuTVliZ05i?=
 =?utf-8?B?VFRqZ1djOE0rWDM0dVhXVDVaSGJqYnVpVEVYOGFObFZTNXhjT0M0MWpVVlp5?=
 =?utf-8?B?Skhub09SOEtuQkdWbFFia0IrQzhFVW9HYjF0WStlOHUxWDRkUlQyVlRtTXVZ?=
 =?utf-8?B?cHJrNnVvOExHamQrOWQ1SnJhK0Z3YVphL1p5ZDAzNFBaNGduU3BKeHIvMjh1?=
 =?utf-8?B?QmhUWC8wZXFVaXhtMGFkcHUyZlRUTjV2a2xHWE1iZGsrbUFheHB1bCs0dGRM?=
 =?utf-8?B?SlRGRXlCSUZIbGhzVVJWdmdLTDhXeUdkRHN2THl1TDFGOTRvRXM1NElTVmM5?=
 =?utf-8?B?dldpdnNDRkFRa2t6bXdiVFBZTDhjMGIwUDVsWklnbksxeUJsK09TcktsMVIw?=
 =?utf-8?B?ZG40WEh6dWE3QXpRZHRFNEIxVi9nWk1IUmNQUzJBM09JdWJtWlM3ZEkzTXow?=
 =?utf-8?B?bWNmS3h6SWswS3ljUXBaUnRuM0kzOTdXeHNLL1M3Ty9KTWpSYUI5eFB0QU1m?=
 =?utf-8?B?MTkrTVVzY0hqV2Zma0MvNVJ6SnNZUUtlZnFSaGE1cDBnVkNBOUd5T3pVL3pa?=
 =?utf-8?B?ekVrcmlzK3JtMDQydzZKU0VKL3prMXhPNSswWFo5ajNtUS96Qkx6YUN6WVU1?=
 =?utf-8?B?dWJ3YURkaGNnWlQwOGZkU2gvejUwQ05rVmc5ajdDY0NKVmhNcTRNcVBDaHMy?=
 =?utf-8?B?S1p3MXZoRTZVbnRWVTQ4d2R6d0ZNY1RCNU55M2dXaHBBVE5zRWNkdFNRejE4?=
 =?utf-8?B?RmJreUM4dmVHYXplMi9pSnI3cE5Va3c3Ym9pV1ZoaEs1SXJnY0N3TzNBKzls?=
 =?utf-8?B?WGx1NHR2enNUdUVTdjBGVkJuMlF6b29abjJBbEs2dEhIZUxxOUJOMTlGbjU3?=
 =?utf-8?B?SFNuVnVHcDNaSjdZVzN5dllaeXU3c1dSLzNsbHAzQWh5b09iYjJFT1lTRUxL?=
 =?utf-8?B?c1pZeVVrQXZ1OTU2elh0ZE1uV0piRXZGNEZnYkx6OFJ2dkJ3VTVBbEFjWllo?=
 =?utf-8?B?OXpCUk14YUJPcFBBbVRHQjJyaS85ODltdHZQNUh1RlR2L1F0VnJPRzFzUGpa?=
 =?utf-8?B?MzJnTWFuclhxQXYzZFZWRW9WZFVCcmJETHVvODRaZ3drNWJnTmNpZWFsZGtY?=
 =?utf-8?B?cVI0K2ZuRTRGZDdEdStDNzlSSXlhRjVRdTRJUGJOakJVR0EzM0xucTFzL2xs?=
 =?utf-8?B?NTlsTkJnVjhEc0JuK0dRbE94SFE1MVdBcnQ5VzlaUGhhTExVZzZFTnR2WWZ4?=
 =?utf-8?B?SnppTG00MVZLT0lpYjBEQ2xOVFFGMmtVaWdiWmpKWFBlc015RVlKM2c1Mjhw?=
 =?utf-8?B?UkZFdDhkNjg5dHY4T2xYMWQ0YzE1VzNKelFZYXJDN3pFQXFjajdIeVowMDdl?=
 =?utf-8?B?YzVUM1grcmtnUmQ3UVFzTnd3cGJ3MXdIQW9VRHBiTUVCRVVwTFQwMXNXNW42?=
 =?utf-8?B?YXJDbFQ4T3NKNFgyQ2ZkeXp6dGxUN1lpcnN6ZGkzYkhHOTJTbis5Z3JUZDdk?=
 =?utf-8?B?dkxoT1F5c0tMV2RjSTYvaStaWUJzSkJTY0FiMS9MNXQzNnJzY05iamlRa3JH?=
 =?utf-8?B?TUcvenJhRUVlUVRzRHhpRnEzaW5qWmdBSWl6Wm5CSEZCSTdqMWQ5azBpZXRM?=
 =?utf-8?B?RjlrTFNRSGhoMGpMb25PbVEydSs2ZUNzTWZwMkIveXFsZlkxM2oxOVdlcEcv?=
 =?utf-8?B?eDd3M21yYzYxQ3Y5bkUxM01sVi9kZXV0QzN2WEppVHJDdTNmNEduSVpuSGoz?=
 =?utf-8?B?REptaGpNNzhYVTY0akJNUkcxTnJhckN6Q2UrSnNLZXRVaDRaa1hpVlFnZ08r?=
 =?utf-8?B?S2EvNW5DMnhUNXdhNDVVQmNkVkd0b25vdU52eWJrTExyKzVnbHdYVTA1UWZa?=
 =?utf-8?B?bUt0ajhoNGxUb29GRWxGUFNIQ2gvdncwVlEvVlBYVURYRkhjM3lvZEUxQjdU?=
 =?utf-8?B?VnpLL094ZFVaditqZmZ3ZlV2bHc2UFlLb0RsVWppZVgwTjdSWG1xTmxlWm95?=
 =?utf-8?B?T0Evc2k4dTNENVlZVEZyamwzZTd5c0R2aDVLdTFHTXBCQXlTMExjcW1mcm56?=
 =?utf-8?B?eGtnUnhDQ01FMTF2MHkvSEpjUlQzWDQ5emlIc1JSckttRGJvRVdKdk15RHVY?=
 =?utf-8?B?SldOTjArL0dka2pWQnRxcUNaRlZoM2VmVklBZFEvemI4MEJLY2V4ZVkrN0JB?=
 =?utf-8?B?VXZZRDlXMzBSejdTdXVnc3NUcnE0Y282eFFMbndpWU51SVR4RkpyL2xUYlFn?=
 =?utf-8?B?Mzk1ckZUcG9pZVpBaXlmZytWYkNJaDY2ZGxwY2I5U3U0RVFiWE5IM3JNU1BW?=
 =?utf-8?Q?aymQZqhjHvyIBkKFGWHN7vAIlnjO3KLtGg1iPu53DSWhy?=
x-ms-exchange-antispam-messagedata-1: kzZvz8Yc3XU/V3cDH0Ig/JEC1g9nMhos4Zo=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2D8110A50E204E4F99E6A0D0B66D579E@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: fDFXRtMOhC4BsU0lYlmyImUv/Z1c6FuG6N9zu1cYvFcssYHaby/nAtWXZrf1J5Zwqf1aUc9M3MZ2T8ZBQm1vNZVsRqWMvFxseWFqhVzFCugVSIuQM+UNWK+z8sw7MXkXdOBaD/wJPCiFWalLfTZPLWlnZKZTBA0dm2NZx7F/awcCkv5Opit6kVVtpxYS7/iB1zVZWlU/43hO/BL3lVm1T4Tf256DWhI3e3lN1ePKLOktEyDKNK2ZNTfYP1yIzlT+JA55Z4mZk7TaYp8MzG0gQcAN6YHf4cV4U8DgZ3dd8UOjw7g6giC8e63odn8coHmLvh8Qp6zTcsdubd24tJMnXg==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: jY42CubvemmvwEgt5/pCun30CaAwgEZWlDebnrMR72MuUA0/fgQODP/cTKRDF5q6bscOsNUitwwezZyIzJmyFgFO9UumJdAZEHjg2+hMmYkhoIqNbtKp9TDUne4VeID9FvWbX/bYpQV8lN5g4LUqNPR7eDinfnn6BchsdF9bnVX1IzTlDk8hr9TsK7PH2mD3tXuJM7hBFp+NQ0OTum1L5IhM3SIA0aH9YX3iPlnvGOkTGUDF+arL+UgDhuWh6afKueQY98QnXGeYZebb1nQ2LFATXTdZBF2enGU/ruW7RE7ObFJ37C3HUwjNuFhQFQiKNJM8/Q9AVVvlcY8W1W/7XNTMuLyUWuaZ25HBnlZ7GNOupwirdkP24mWilX97mDJRNzyPmgQKwjgny98o1M2Vf9VMEfJNZx2G1lomwGGH/zvu3q4AbmHmLxekmIOgcY7LlbFll5l7xsse77SruIHalOCTxJWYu5NBJVlCDWgQ/iTkqsYJSlFnmQa0uIlQezcU8LXFUdECu0ZJcIEpyEA9XChP6kllJpt31xyPqgcQeRjvWnT1k9EGQTMER2U9sLkLEgkdsQ/nsmlMYWfdTbQtNAOJ87mu8Ram0c4VMi+FrpFFF8Wv9pjXi5X6pedS4vZz
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY1PR04MB9561.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 625c10f6-db14-4a36-074e-08debb8f236b
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 May 2026 01:27:38.1880 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ES5BYUZokPSbqERudCprhAgRbEXmRzQh683XDMZYn36xkkmkr3u7RvR+p1WCTjHKR0GIUVoo4Q4JZgZzVz84N66FhFH7i+UjdNT5HoUkxH8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6973
Received-SPF: pass client-ip=68.232.141.245;
 envelope-from=prvs=6009f06ea=Alistair.Francis@wdc.com;
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

T24gVGh1LCAyMDI2LTA1LTIxIGF0IDEwOjA3IC0wMzAwLCBEYW5pZWwgSGVucmlxdWUgQmFyYm96
YSB3cm90ZToKPiBXZSBuZWVkIHRvIGZhdWx0IGR1cmluZyBhbnkgYWNjZXNzIGRvbmUgd2hpbGUg
UFRFIGJpdHMgNjItNjEgYXJlIGJvdGgKPiBzZXQsIGFjY29yZGluZyB0byB0aGUgUklTQy1WIHBy
aXYgc3BlYy4KPiAKPiBSZXNvbHZlczogaHR0cHM6Ly9naXRsYWIuY29tL3FlbXUtcHJvamVjdC9x
ZW11Ly0vd29ya19pdGVtcy8zNDk0Cj4gU2lnbmVkLW9mZi1ieTogRGFuaWVsIEhlbnJpcXVlIEJh
cmJvemEKPiA8ZGFuaWVsLmJhcmJvemFAb3NzLnF1YWxjb21tLmNvbT4KClRoYW5rcyEKCkFwcGxp
ZWQgdG8gcmlzY3YtdG8tYXBwbHkubmV4dAoKQWxpc3RhaXIKCj4gLS0tCj4gwqB0YXJnZXQvcmlz
Y3YvY3B1X2hlbHBlci5jIHwgMzYgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
Cj4gwqAxIGZpbGUgY2hhbmdlZCwgMzYgaW5zZXJ0aW9ucygrKQo+IAo+IGRpZmYgLS1naXQgYS90
YXJnZXQvcmlzY3YvY3B1X2hlbHBlci5jIGIvdGFyZ2V0L3Jpc2N2L2NwdV9oZWxwZXIuYwo+IGlu
ZGV4IDE3MzA1ZTFiYjcuLmJjNjM3MTNkZGYgMTAwNjQ0Cj4gLS0tIGEvdGFyZ2V0L3Jpc2N2L2Nw
dV9oZWxwZXIuYwo+ICsrKyBiL3RhcmdldC9yaXNjdi9jcHVfaGVscGVyLmMKPiBAQCAtMTQ0Niw2
ICsxNDQ2LDI1IEBAIHN0YXRpYyBpbnQgZ2V0X3BoeXNpY2FsX2FkZHJlc3MoQ1BVUklTQ1ZTdGF0
ZQo+ICplbnYsIGh3YWRkciAqcGh5c2ljYWwsCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgcmV0dXJuIFRSQU5TTEFURV9GQUlMOwo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB9
Cj4gwqAKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAvKgo+ICvCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgKiBwcml2IHNwZWMsICJTdnBibXQiIGNoYXB0ZXI6Cj4gK8KgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCAqICJGb3Igbm9uLWxlYWYgUFRFcywgYml0cyA2Mi02MSBhcmUgcmVzZXJ2ZWQgZm9y
Cj4gZnV0dXJlCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAqIHN0YW5kYXJkIHVzZS7CoCBV
bnRpbCB0aGVpciB1c2UgaXMgZGVmaW5lZCBieSBhCj4gc3RhbmRhcmQKPiArwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgICogZXh0ZW5zaW9uLCB0aGV5IG11c3QgYmUgY2xlYXJlZCBieSBzb2Z0d2Fy
ZSBmb3IKPiBmb3J3YXJkCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAqIGNvbXBhdGliaWxp
dHksIG9yIGVsc2UgYSBwYWdlLWZhdWx0IGV4Y2VwdGlvbiBpcwo+IHJhaXNlZC4iCj4gK8KgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCAqCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAqIEZvciBs
ZWFmIFBURXMgdGhlIHNhbWUgYml0cyBhcmUgYWxzbyByZXNlcnZlZCBidXQgaW4KPiB0aGF0Cj4g
K8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAqIGNhc2UgdGhlIHBhZ2UtZmF1bHQgaXMgbWFuZGF0
b3J5LsKgIE1ha2UgYm90aCBjYXNlcwo+IGNvbnNpc3RlbnQKPiArwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgICogYnkgYWxzbyBwYWdlIGZhdWx0aW5nIGhlcmUuCj4gK8KgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCAqLwo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGlmICgocHRlICYgUFRFX1BCTVQp
ID09IFBURV9QQk1UKSB7Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBxZW11X2xv
Z19tYXNrKExPR19HVUVTVF9FUlJPUiwgIiVzOiBQQk1UIGJpdHMgNjIgYW5kCj4gNjEgYXJlICIK
PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAicmVzZXJ2
ZWQgYnV0IGFyZSBzZXQgaW4gUFRFOiAiCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgImFkZHI6IDB4JSIgSFdBRERSX1BSSXggIiBwdGU6IDB4Igo+IFRB
UkdFVF9GTVRfbHggIlxuIiwKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCBfX2Z1bmNfXywgcHRlX2FkZHIsIHB0ZSk7Cj4gK8KgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCByZXR1cm4gVFJBTlNMQVRFX0ZBSUw7Cj4gK8KgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgfQo+ICsKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaWYgKCFyaXNjdl9jcHVfY2Zn
KGVudiktPmV4dF9zdm5hcG90ICYmIChwdGUgJiBQVEVfTikpIHsKPiDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCAvKiBSZXNlcnZlZCB3aXRob3V0IFN2bmFwb3QgZXh0ZW5zaW9uICov
Cj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcWVtdV9sb2dfbWFzayhMT0dfR1VF
U1RfRVJST1IsICIlczogTiBiaXQgc2V0IGluCj4gUFRFLCAiCj4gQEAgLTE0OTgsNiArMTUxNywy
MyBAQCBzdGF0aWMgaW50IGdldF9waHlzaWNhbF9hZGRyZXNzKENQVVJJU0NWU3RhdGUKPiAqZW52
LCBod2FkZHIgKnBoeXNpY2FsLAo+IMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuIFRSQU5TTEFURV9G
QUlMOwo+IMKgwqDCoMKgIH0KPiDCoAo+ICvCoMKgwqAgLyoKPiArwqDCoMKgwqAgKiBwcml2IHNw
ZWMsICJTdnBibXQiIGNoYXB0ZXI6Cj4gK8KgwqDCoMKgICogIkZvciBsZWFmIFBURXMsIHNldHRp
bmcgYml0cyA2Mi02MSB0byB0aGUgdmFsdWUgMyBpcyByZXNlcnZlZAo+ICvCoMKgwqDCoCAqIGZv
ciBmdXR1cmUgc3RhbmRhcmQgdXNlLiBVbnRpbCB0aGlzIHZhbHVlIGlzIGRlZmluZWQgYnkgYQo+
ICvCoMKgwqDCoCAqIHN0YW5kYXJkIGV4dGVuc2lvbiwgdXNpbmcgdGhpcyByZXNlcnZlZCB2YWx1
ZSBpbiBhIGxlYWYgUFRFCj4gK8KgwqDCoMKgICogcmFpc2VzIGEgcGFnZS1mYXVsdCBleGNlcHRp
b24uICIKPiArwqDCoMKgwqAgKgo+ICvCoMKgwqDCoCAqIFJhaXNlIGEgZmF1bHQgaWYgNjItNjEg
KGkuZS4gUFRFX1BCTVQpIGFyZSBzZXQuCj4gK8KgwqDCoMKgICovCj4gK8KgwqDCoCBpZiAoKHB0
ZSAmIFBURV9QQk1UKSA9PSBQVEVfUEJNVCkgewo+ICvCoMKgwqDCoMKgwqDCoCBxZW11X2xvZ19t
YXNrKExPR19HVUVTVF9FUlJPUiwgIiVzOiBQQk1UIGJpdHMgNjIgYW5kIDYxIGFyZQo+ICIKPiAr
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICJyZXNlcnZlZCBidXQg
YXJlIHNldCBpbiBsZWFmIFBURTogIgo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgImFkZHI6IDB4JSIgSFdBRERSX1BSSXggIiBwdGU6IDB4Igo+IFRBUkdFVF9G
TVRfbHggIlxuIiwKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IF9fZnVuY19fLCBwdGVfYWRkciwgcHRlKTsKPiArwqDCoMKgwqDCoMKgwqAgcmV0dXJuIFRSQU5T
TEFURV9GQUlMOwo+ICvCoMKgwqAgfQo+ICsKPiDCoMKgwqDCoCB0YXJnZXRfdWxvbmcgcnd4ID0g
cHRlICYgKFBURV9SIHwgUFRFX1cgfCBQVEVfWCk7Cj4gwqDCoMKgwqAgLyogQ2hlY2sgZm9yIHJl
c2VydmVkIGNvbWJpbmF0aW9ucyBvZiBSV1ggZmxhZ3MuICovCj4gwqDCoMKgwqAgc3dpdGNoIChy
d3gpIHsK

