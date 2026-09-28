Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E9DAC9832F
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2026 01:44:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xB0P9-00066F-UJ; Sun, 27 Sep 2026 21:43:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=724888370=Alistair.Francis@wdc.com>)
 id 1xB0P7-00065c-GR; Sun, 27 Sep 2026 21:43:41 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=724888370=Alistair.Francis@wdc.com>)
 id 1xB0P5-00043w-Al; Sun, 27 Sep 2026 21:43:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1790559819; x=1822095819;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=ZZUAsd7r2+kCF0kXh9RvC5xw0wknX3n9KnZGoputy0g=;
 b=qVAFQo1xg7HD36bK1LPixLO8IulvWUpIfEv2OhYxKn+PDPKL4FeRb0Bc
 kbA4caoVvg6zeQ3iguZuVtjaKupnaGr03oUtbREWvGNlVRwvUDOFAnEop
 KNZi7orXO5zjuDC8NK6rjPpNAvIdPJAhMGLKauz9YvurY2RmiHvdoocB2
 FnoCXT5XNUTHXoLdCxf3qpdu4tHlqOpfEnmTP6UBXlvBFk4NG1j7V1FGE
 7jI6psCalcbVWFRAPkT3XnQ0ps3NChQVYvw4QT4OYDtwD6O5Fm//r90YX
 Ge8/13WtPHClG9G+lugIicbVqz+Sqcm/9ZhMeBP8QQeOw7UeHvHNGVRiP Q==;
X-CSE-ConnectionGUID: ipb1BY9bQc+qQTfNNX9HAQ==
X-CSE-MsgGUID: JKxuh8NKSYmECCutjfd01Q==
X-IronPort-AV: E=Sophos;i="6.27,127,1786982400"; d="scan'208";a="155744850"
Received: from mail-centralusazon11011041.outbound.protection.outlook.com
 (HELO DM5PR21CU001.outbound.protection.outlook.com) ([52.101.62.41])
 by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 28 Sep 2026 09:43:36 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VjHvdh1XkN3SnH1L+gBnIHaUJc1e5a00iNTaqorEKPWM13aC7f+sQNuqEOqBztsEEBqledu8GAXJcKe/dMisMDez7zIsb14GswT3w6ld5oSxGDqiJZ5QFz7raWEd7Dh6dFvwi/uRO+Drfg9/xIm6PYP36qb0cJZOx9ZBi0QDKHOHs7GJIvxwVPtxmpB6JeFejMlPTlbFrSxr4g3hYqu1fnMXC9MoSFjp1WlaKaUJW7VLyylyyNqtlAhXzGgWzJcxBho44RE1ZCppiwO+vTNef+8qhQ0luSMeIQMZ1sXiiJdz4sJVg41aiSOFsnNo8W89nVU8txsMDyxspV0S/p/A/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZZUAsd7r2+kCF0kXh9RvC5xw0wknX3n9KnZGoputy0g=;
 b=o7REM9qvockMuCv6x6JSaVBcjKQU1N9pYr1d3lT5ly2uKsdF/CfUgHseSqOzHdyXtUpC/Yvq/vFwyFUtFAf9pnKcMx1OhMq2Wast6ZLV8mHY0O1rjitiEqSQclYCuQ3Zy4ag0Gzk4CyFaC1Rdm0sh2ooHeTk8A782zSCsX7756g8J/yNWj/WaAgxVkliqVTiVR0BX+TNhpz1VGhra3d1w5VdnEuZA7t1gfyd8NSbw/BagRSZVOqBIxsnt8isjxbKtOtOKjYdKE7qQIU7d+JlNgKovIKEyvH515R2xduJjcBJ6lWhJ7D9zatBcuKeQTDVzbva6U1Qu8dtOg7LdVuyXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZZUAsd7r2+kCF0kXh9RvC5xw0wknX3n9KnZGoputy0g=;
 b=VrdAMK+zVHGISJSsBbGGtuWHcAbW9MTvpO7F23bbMy5pbMa0FZQ7R7/h6X4mpMwb799PDeeft/JqZx4eWo7kD46UeiDlXAMjD671lRW87LskLsGpt16TgvBW7veIo4O3pZoiWbEum6FZX1Qv+YiC7WxMJ/ape4swCr+AkDAehfw=
Received: from BY1PR04MB9561.namprd04.prod.outlook.com (2603:10b6:a03:5b6::11)
 by CO6PR04MB7651.namprd04.prod.outlook.com (2603:10b6:303:a5::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.23; Mon, 28 Sep
 2026 01:40:03 +0000
Received: from BY1PR04MB9561.namprd04.prod.outlook.com
 ([fe80::3869:e494:2fa8:9888]) by BY1PR04MB9561.namprd04.prod.outlook.com
 ([fe80::3869:e494:2fa8:9888%6]) with mapi id 15.21.0451.022; Mon, 28 Sep 2026
 01:40:03 +0000
From: Alistair Francis <Alistair.Francis@wdc.com>
To: "marcandre.lureau@redhat.com" <marcandre.lureau@redhat.com>,
 "palmer@dabbelt.com" <palmer@dabbelt.com>, "pbonzini@redhat.com"
 <pbonzini@redhat.com>, "pierrick.bouvier@oss.qualcomm.com"
 <pierrick.bouvier@oss.qualcomm.com>, "farosas@suse.de" <farosas@suse.de>,
 "visitorckw@gmail.com" <visitorckw@gmail.com>, "lvivier@redhat.com"
 <lvivier@redhat.com>
CC: "wxchen0913@gmail.com" <wxchen0913@gmail.com>, "marscheng@google.com"
 <marscheng@google.com>, "portias@oss.tenstorrent.com"
 <portias@oss.tenstorrent.com>, "daniel.barboza@oss.qualcomm.com"
 <daniel.barboza@oss.qualcomm.com>, "jserv@ccns.ncku.edu.tw"
 <jserv@ccns.ncku.edu.tw>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "chao.liu@processmission.com" <chao.liu@processmission.com>,
 "zhiwei_liu@linux.alibaba.com" <zhiwei_liu@linux.alibaba.com>,
 "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "eleanor15x@gmail.com"
 <eleanor15x@gmail.com>, "liwei1518@gmail.com" <liwei1518@gmail.com>
Subject: Re: [PATCH v5 6/7] tests/functional/riscv64: Add boot test for Milk-V
 Duo board
Thread-Topic: [PATCH v5 6/7] tests/functional/riscv64: Add boot test for
 Milk-V Duo board
Thread-Index: AQHdTupI2uSXk8UpxUu8NLQEs3j0kQ==
Date: Mon, 28 Sep 2026 01:40:03 +0000
Message-ID: <2a09d99ee0169095f65ec5d7b22c607e154686ed.camel@wdc.com>
References: <20260927201326.650943-1-visitorckw@gmail.com>
 <20260927201326.650943-7-visitorckw@gmail.com>
In-Reply-To: <20260927201326.650943-7-visitorckw@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.62.0 (by Flathub.org) 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY1PR04MB9561:EE_|CO6PR04MB7651:EE_
x-ms-office365-filtering-correlation-id: e8e24c05-3f9f-447f-0cd8-08df1d016af5
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|7416014|23010399003|1800799024|19092799006|10070799003|38070700021|4143699003|10067099003|260925021311599003|260925022911599003|260925021911599003|56012099006|11063799006|22082099003|18002099003|3023799007;
x-microsoft-antispam-message-info: ClFoBrAvGOE1lIOKzvo05VejtDOtZ5N/9VE1999WFWtdWnB2OKzJV8ZPIOcbyqUGb0/egf3BR90pGoPq95GusxVWkHeuGvjmfUWc9aAyURGrKIDSxD0D2KHbrWKr6hU4PVblQPvwxmbKFe2VXuqe//STLLsSKxlC7gM34+saJv6bVy1CEXHG8Q2nZY31P4hvhMz3r92tvkQ/u2KsIfVftlzVOPUaubgH+KNhoWtvsTXNozqzPe9bU7TOQvbgraDARbVf1ek0Ya/uArBEjlvj8umh/AyfZglJTNlGbi9jC5dZ2WI5ccNdIC1iiXxkJ6yqO3krYFW3rNGKqUA8RbHUOC6oOebAd5EXG/oeGr6crv+ekZeJwdEtWmLTbBTxC2pzVGcxeWt434JjDY9JJdimpHQAM7L8nZZReuYccdmrMdchsn/h0xi/EkgSnA8JC+pFGjLPJGRkHhruZoe8J032trXpLb/uH/nscs+fNY7a0PUfzTysZ2tD97PN/w0/uGMvHMKEHgkBu0clai5JDFHV4y79uzlJRWqQhp/zBbdrJ0UNWnJKMmB/RAunDp3vL7fLcofJJXt+wMAN+rR/esh3mwxiEr/N4cUNIYgIyTowAnVV48XDWGe8AK+in7T+/rmQU2Fs6qTOl4bZVcsfiCczOeGkgVzuaF9R0MaAWLYvEr8=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY1PR04MB9561.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(23010399003)(1800799024)(19092799006)(10070799003)(38070700021)(4143699003)(10067099003)(260925021311599003)(260925022911599003)(260925021911599003)(56012099006)(11063799006)(22082099003)(18002099003)(3023799007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VWl3bVE2bVNtT3lZUnNPRDJWZFNzbXdERE10NFZNMk4wR1NKMnZndUZwb1I0?=
 =?utf-8?B?R0RYVENySEc4VitMU1hjaUhwbnVkTnZFeFA0ZjFpbllJU3kyVHQ0d0dFWDhu?=
 =?utf-8?B?dWVnTTJMem1RTm9LVDJmUmxoQVFXSlhzT2JDNlZoV0JCNTIwZVc5NkFqZ0Z6?=
 =?utf-8?B?a0kzd1dtMjExTnZpTmtSQXJTVmxSUFk1RkM5cExzbkVqOTNxSCtrUkt0MWJL?=
 =?utf-8?B?NUw5cktGVFNyQlhhWUJqVkU4dG9DcnhJQUtJUU5qQk5EbXh5aWUvZXJOWE9l?=
 =?utf-8?B?a1ZWbjQvNllIYTlxdVVNVDFPSXlUdmQrTW5lc2lHaDUxdndqbkZpcmFSR3hu?=
 =?utf-8?B?bFJsbldsQzBCVm0vQnhlcE8zem91RGJJQ3dBRFhyVk83WjdVaHl6Q05HOGpJ?=
 =?utf-8?B?TmtRVUt0U0JhNTRzdmwrdHZ5RXFnSEpKUjJFZmZLTlhoT3NoclQyL0YySUpZ?=
 =?utf-8?B?NVpkbWxCZjFJdmJrak5Md3Z1UU1WNlRhejdGbVAwSG5wWHZLK1hXdjNDbnph?=
 =?utf-8?B?ZGVJS0QvYjlCdTdaNmNxd1Q4enJvUUUyMCtzSmhsRng2QUNPbEJMTnhxZ1A4?=
 =?utf-8?B?ZnFBVFAzdm5VNFplaFlsU0tJcXE3THBJc0xHVDEvYjNWcjVtamxqMmJOS3Q5?=
 =?utf-8?B?WkhjZkRUUk9neHI2andLeVAwQTlEZU1ZRTMxNFpOdnoveXJ6eXMyTGxkbCtw?=
 =?utf-8?B?Y3JKMElxNGZnZmNiWm1XeHRsYmNlWDRXMmU2aXR4YUpLWEp4cmVUTVVTMHVQ?=
 =?utf-8?B?Y2YzZWZhU2xDRHZreTlIQnU1RWtZQmpsY3V2YlNpUW9zSUtNVnM0NFBuN2x5?=
 =?utf-8?B?UDFoa3piOWdDb0xjdzlMeTFPN3AycjFBeXFFVG9Rc2VHYUwyWmdYZW9DQ1JR?=
 =?utf-8?B?NEVzKzJrU1ZMS2ZicWRZenh3dXBxbW50TGZ2bHZ1U0ZlK01aWGFVaTA2ZzUy?=
 =?utf-8?B?aGRpbzJYTThmbDBsL082Sm1YVkxERGpaVkhDYlhzVHpEdWRPT2lDTmw1bG1E?=
 =?utf-8?B?eUN6eUxmT01jdzN4Q3pJWk9iT3c3VG9kNm1VMExBQXhNUGRhMFp4WjJrRmFM?=
 =?utf-8?B?amdEVGM2M3JmWjZsQnQ5TlgyOGUzRVZ3OFdXZWhuMGxua3kxaFUyMjdwdEo2?=
 =?utf-8?B?QndHWWdwR2h1bmRmVnowMytDMHA4TkRBazE4YWJ0eWFia3RyVzVFMlRYanBW?=
 =?utf-8?B?WVRjaTlZem0raGZ4ZkI3WEdQa1FzNUlsUzkvcXhGeTRxcjMrL0VnWFp5aWlZ?=
 =?utf-8?B?NzRIZHdWYWtCQXByb0RjRnJCOWJQZjlZMzdKZnliZUxLQ0dWTFFaNmpVbU8v?=
 =?utf-8?B?VGtpL2w1T3hsaTNSTnNtTEdjdTJGMHVIVjVZcmxwVXdvOEpURVROTm9kODdm?=
 =?utf-8?B?QlJ2QjhiK0FYajNqdUhWTWdtaFY2cDV5Wm1RWGdrRVg4UGk4Wk1GazJHVmxy?=
 =?utf-8?B?RjVrSCt5aTJvdXVQZXNNMTBEdFdIZ0lPM0FyUTVhMTZYazZxV0E3eTk0WlZR?=
 =?utf-8?B?UzRMZkZMYVJOOERndXNWaVRQdmhkK09uaDNVSy9JYWtWdkh3alh6WU5EU1p5?=
 =?utf-8?B?MlpQUXdWUFJRenhYc1lKREhWeXA4Y2dLdGxuNTI3LzBpL1cxd0svTm9QeFht?=
 =?utf-8?B?QTlBOGY5SnZPSHJ1RFNwSU1iU2djSjEyNzVDRHhlVXZXYXJyNDVTcS9ZemJV?=
 =?utf-8?B?cm9Tb3VUTUY1Qm8zOFkxRXh3aDdEVkRoWHB2M2FwTFlzY2JCSmxmZkZMbVh6?=
 =?utf-8?B?bnVVbzdURUhUTk83Z3RUa1FGYVJrUEk1NVY3SUpyWWp6NTdUa1NBaHR5T1BP?=
 =?utf-8?B?cStmdGZCcFpoTEhKRjNKVEo1emIzVzdDNnZRYldDRk1CWGx3R2wzSlJQNEpN?=
 =?utf-8?B?ZnNZVDM2ZVdsaEZhdEwvZUp2NHlwdEtFTitROTM1QnJBK0x6amVhS29DM01X?=
 =?utf-8?B?NkIvM0Z4WFd3OFgrbHMzcENMMUdFakhQUHpHTjV1Z2hNeTRoZDdmajJsbkZy?=
 =?utf-8?B?NjdvQXBSdW5wVkdLckM4Wk5XUUwxcXVpeDlwVkJnOFpnNTZPdG5ZYWw5MFFP?=
 =?utf-8?B?MzVGTUZpK3VjY2I4SEFpVTZqcXZBR0lNREM1S2xvQVJJeENYTU4wd1ZJM1B4?=
 =?utf-8?B?NHU0aHZDMWwwRmNlRnhlTHpMaURQMHB5V25ES2Y5TUlNYklKaEtEN3Y4UnVO?=
 =?utf-8?B?MG92cXdqeHJBQzd6OTRmaGRoZXVBSTVJVk5TT1djOGpZQXlkczIxRDlJT1VG?=
 =?utf-8?B?VzVvTisvdFVzY21RZnhRNHRPUC9uNTNMcVlMSlkzUmc3S3NMQjczZVhJVFB2?=
 =?utf-8?B?VTVZbFRCRkdGNitiMER6MUZwM2lhWUFsREZnTE15elQ0OFJMakpMMUgvY2J5?=
 =?utf-8?Q?n3NeDgPkXEd1XH5WOpVwVJoCXQROyZi6YxmdBk/YZ0sGo?=
x-ms-exchange-antispam-messagedata-1: QOhpMeWQQw39lzj1+h2MwLjI0yvAgXBFFhw=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8564543042AF13439BB50BD7B2202C81@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 1CS82WZJQjdMFtGc8FOop5KyzK32TlKtktdAGZzE5xRW3dqnftEqk04SgeyC7lHlmiRs3PcQ+T30V0gQcS4uQ4/fi1eAQgLmqsID2I6OXBTIkSMnODZjDKLAxt/P4CVABgQIvQcX2zlHRqtrbH81X0clJxEZVLvYW4BbOIyKka8MySyeilBCKd0kFR4Jj7c1fDLT0QyMXhTuvb2S/mVUqffrFtvWNyVZTGN1dCW0YAVVJFXms1JTmdSum6sqOqAvl/e0uwnd98hbIHbdZNdOV+Uv5HjAhokngo1vC924VASoVqa9b1ywXr226GGCpT5VD+blG8f8uxgFsbxDuEl16w==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: AXTHbARDMO3NjjN/TQxG9sKMm56NCSEE7FOV0pcTi3ydpXatkRwoXel/5q2gEEWQw4ITSLBmntNO3vEUYS8KIbl+ovhqoRos+iMwxDJ7Ri1JyK949sXbB5H6CwQwqy/cSPxYeqcUBJJGaHuEB5p63+sOtR1WCc2UbSSRUKsUOjpCBj8cptLcc7Y43f2gzKS+yv6WFkjtg95aceyqaS61hKka8e00lbKFELq0Az9VU2lteXf2mboI2Lqly/PeyhutWSkqocAT4Um1X1GPiNdmV1HDatxTw6PCJOeAfGfmIauctA96OsEkWW/bC7MYxg7s6ktnz6ozgoZwKdEOsrOn7kkAqH+D2frudWVgvVJyzzkb1YGk9NIGMpWJKcg4ZJxKOHob0k6pqiaHXdIPrx5p9uAhVnGG33I6mNEFLrV5p3KE+zWZeNyaS6aqtAfaort/8t+e5ccesNINvxqOBsRJPpd0MWk5U3DIWFhjF19ImVQi/z2ehbesRjZbeQiluIV+Z4sJNl091lRFhdJTxH+3j3K5gM8yhVP3r+7LWgoaZQsQCS5lL6V3MOI7bB2jR1QBI/ZJSjxBaog49BAGo/rs5RYnnhmH5FAQatNunUzHpn+TefKGJduCnSGcUVjKqswt
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY1PR04MB9561.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8e24c05-3f9f-447f-0cd8-08df1d016af5
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Sep 2026 01:40:03.6048 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kQOsHxq42/0Zx1KQLIgnLgBHDmkooJFVOCd6r0A0C636/haNI18rw21IGWLYpAEKwg3QAJ1i6Z4LKT+8MQIwhYSLHNoGqdRTUm04KhhLJaQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR04MB7651
Received-SPF: pass client-ip=216.71.153.144;
 envelope-from=prvs=724888370=Alistair.Francis@wdc.com;
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

T24gU3VuLCAyMDI2LTA5LTI3IGF0IDIwOjEzICswMDAwLCBLdWFuLVdlaSBDaGl1IHdyb3RlOg0K
PiBBZGQgYSBmdW5jdGlvbmFsIGJvb3QgdGVzdCBmb3IgdGhlIE1pbGstViBEdW8gYm9hcmQgdG8g
dmFsaWRhdGUgdGhlDQo+IGVuZC10by1lbmQgYm9vdCBmbG93Lg0KPiANCj4gJCAuL2J1aWxkL3J1
biAuL3Rlc3RzL2Z1bmN0aW9uYWwvcmlzY3Y2NC90ZXN0X21pbGt2X2R1by5weQ0KPiBUQVAgdmVy
c2lvbiAxMw0KPiBvayAxIHRlc3RfbWlsa3ZfZHVvLk1pbGt2RHVvTWFjaGluZS50ZXN0X3Jpc2N2
NjRfbWlsa3ZfZHVvDQo+IDEuLjENCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEt1YW4tV2VpIENoaXUg
PHZpc2l0b3Jja3dAZ21haWwuY29tPg0KDQpBY2tlZC1ieTogQWxpc3RhaXIgRnJhbmNpcyA8YWxp
c3RhaXIuZnJhbmNpc0B3ZGMuY29tPg0KDQpBbGlzdGFpcg0KDQo+IC0tLQ0KPiDCoE1BSU5UQUlO
RVJTwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgfMKgIDEgKw0KPiDCoHRlc3RzL2Z1bmN0aW9uYWwvcmlzY3Y2NC9tZXNvbi5idWls
ZMKgwqDCoMKgwqDCoCB8wqAgMSArDQo+IMKgdGVzdHMvZnVuY3Rpb25hbC9yaXNjdjY0L3Rlc3Rf
bWlsa3ZfZHVvLnB5IHwgNTMNCj4gKysrKysrKysrKysrKysrKysrKysrKw0KPiDCoDMgZmlsZXMg
Y2hhbmdlZCwgNTUgaW5zZXJ0aW9ucygrKQ0KPiDCoGNyZWF0ZSBtb2RlIDEwMDc1NSB0ZXN0cy9m
dW5jdGlvbmFsL3Jpc2N2NjQvdGVzdF9taWxrdl9kdW8ucHkNCj4gDQo+IGRpZmYgLS1naXQgYS9N
QUlOVEFJTkVSUyBiL01BSU5UQUlORVJTDQo+IGluZGV4IGY3ZTQxNTk2NzkuLjY4OTQyNGZkMWMg
MTAwNjQ0DQo+IC0tLSBhL01BSU5UQUlORVJTDQo+ICsrKyBiL01BSU5UQUlORVJTDQo+IEBAIC0x
ODgwLDYgKzE4ODAsNyBAQCBGOiBody9yaXNjdi9jdjE4MDBiLmMNCj4gwqBGOiBody9yaXNjdi9t
aWxrdl9kdW8uYw0KPiDCoEY6IGluY2x1ZGUvaHcvbWlzYy9jdjE4MDBiX2Nsay5oDQo+IMKgRjog
aW5jbHVkZS9ody9yaXNjdi9jdjE4MDBiLmgNCj4gK0Y6IHRlc3RzL2Z1bmN0aW9uYWwvcmlzY3Y2
NC90ZXN0X21pbGt2X2R1by5weQ0KPiDCoEY6IHRlc3RzL3F0ZXN0L21pbGt2LWR1by10ZXN0LmMN
Cj4gwqANCj4gwqBSWCBNYWNoaW5lcw0KPiBkaWZmIC0tZ2l0IGEvdGVzdHMvZnVuY3Rpb25hbC9y
aXNjdjY0L21lc29uLmJ1aWxkDQo+IGIvdGVzdHMvZnVuY3Rpb25hbC9yaXNjdjY0L21lc29uLmJ1
aWxkDQo+IGluZGV4IGQxYTNlNmMyYmYuLjhhNGYxZDAwZjkgMTAwNjQ0DQo+IC0tLSBhL3Rlc3Rz
L2Z1bmN0aW9uYWwvcmlzY3Y2NC9tZXNvbi5idWlsZA0KPiArKysgYi90ZXN0cy9mdW5jdGlvbmFs
L3Jpc2N2NjQvbWVzb24uYnVpbGQNCj4gQEAgLTE4LDQgKzE4LDUgQEAgdGVzdHNfcmlzY3Y2NF9z
eXN0ZW1fdGhvcm91Z2ggPSBbDQo+IMKgwqAgJ3NpZml2ZV91JywNCj4gwqDCoCAndHRfYXRsYW50
aXMnLA0KPiDCoMKgICd0dXhydW4nLA0KPiArwqAgJ21pbGt2X2R1bycsDQo+IMKgXQ0KPiBkaWZm
IC0tZ2l0IGEvdGVzdHMvZnVuY3Rpb25hbC9yaXNjdjY0L3Rlc3RfbWlsa3ZfZHVvLnB5DQo+IGIv
dGVzdHMvZnVuY3Rpb25hbC9yaXNjdjY0L3Rlc3RfbWlsa3ZfZHVvLnB5DQo+IG5ldyBmaWxlIG1v
ZGUgMTAwNzU1DQo+IGluZGV4IDAwMDAwMDAwMDAuLjZhN2UyYTVkMTkNCj4gLS0tIC9kZXYvbnVs
bA0KPiArKysgYi90ZXN0cy9mdW5jdGlvbmFsL3Jpc2N2NjQvdGVzdF9taWxrdl9kdW8ucHkNCj4g
QEAgLTAsMCArMSw1MyBAQA0KPiArIyEvdXNyL2Jpbi9lbnYgcHl0aG9uMw0KPiArIw0KPiArIyBG
dW5jdGlvbmFsIHRlc3QgdGhhdCBib290cyBhIExpbnV4IGtlcm5lbCBvbiBhIE1pbGstViBEdW8g
bWFjaGluZQ0KPiArIw0KPiArIyBDb3B5cmlnaHQgKGMpIDIwMjYgS3Vhbi1XZWkgQ2hpdSA8dmlz
aXRvcmNrd0BnbWFpbC5jb20+DQo+ICsjDQo+ICsjIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBH
UEwtMi4wLW9yLWxhdGVyDQo+ICsNCj4gK2Zyb20gcWVtdV90ZXN0IGltcG9ydCBMaW51eEtlcm5l
bFRlc3QsIEFzc2V0DQo+ICtmcm9tIHFlbXVfdGVzdCBpbXBvcnQgc2tpcElmTWlzc2luZ0NvbW1h
bmRzLA0KPiB3YWl0X2Zvcl9jb25zb2xlX3BhdHRlcm4NCj4gKw0KPiArY2xhc3MgTWlsa3ZEdW9N
YWNoaW5lKExpbnV4S2VybmVsVGVzdCk6DQo+ICsNCj4gK8KgwqDCoCB0aW1lb3V0ID0gMTIwDQo+
ICsNCj4gK8KgwqDCoCBBU1NFVF9LRVJORUwgPSBBc3NldCgNCj4gK8KgwqDCoMKgwqDCoMKgICdo
dHRwczovL3N0b3JhZ2UudHV4Ym9vdC5jb20va2VybmVscy82LjExLjkvcmlzY3Y2NC9JbWFnZScs
DQo+ICvCoMKgwqDCoMKgwqDCoA0KPiAnMTc0ZjhiYjg3ZjA4OTYxZTU0ZmEzZmNkOTU0YThlMzFm
NDY0NWY2ZDZhZjRkZDQzOTgzZDVlOTg0MTQ5MGZiMCcNCj4gK8KgwqDCoCApDQo+ICvCoMKgwqAg
QVNTRVRfRFRCUyA9IEFzc2V0KA0KPiArwqDCoMKgwqDCoMKgwqANCj4gJ2h0dHBzOi8vc3RvcmFn
ZS50dXhib290LmNvbS9rZXJuZWxzLzYuMTEuOS9yaXNjdjY0L2R0YnMudGFyLnh6JywNCj4gK8Kg
wqDCoMKgwqDCoMKgDQo+ICc5N2U1ZTY1YTdlNmM2ODMwM2U1MzQ4NmFmMTIwYzA4NDZlZThkZjU3
MmU5YzE1ZjBjNGRjY2I4MzFkMGNlZjRiJw0KPiArwqDCoMKgICkNCj4gK8KgwqDCoCBBU1NFVF9S
T09URlMgPSBBc3NldCgNCj4gK8KgwqDCoMKgwqDCoMKgDQo+ICdodHRwczovL3N0b3JhZ2UudHV4
Ym9vdC5jb20vYnVpbGRyb290LzIwMjQxMTE5L3Jpc2N2NjQvcm9vdGZzLmV4dDQueg0KPiBzdCcs
DQo+ICvCoMKgwqDCoMKgwqDCoA0KPiAnYWE0NzM2YTk4NzI2NTFkZmMwZDk1ZTcwOTQ2NWVlZGYx
MTM0ZmQxOWQ0MmI4Y2IzMDViZmQ3NzZmOTgwMTAwNCcNCj4gK8KgwqDCoCApDQo+ICsNCj4gK8Kg
wqDCoCBAc2tpcElmTWlzc2luZ0NvbW1hbmRzKCd6c3RkJykNCj4gK8KgwqDCoCBkZWYgdGVzdF9y
aXNjdjY0X21pbGt2X2R1byhzZWxmKToNCj4gK8KgwqDCoMKgwqDCoMKgIHNlbGYuc2V0X21hY2hp
bmUoJ21pbGt2LWR1bycpDQo+ICsNCj4gK8KgwqDCoMKgwqDCoMKgIGtlcm5lbF9wYXRoID0gc2Vs
Zi5BU1NFVF9LRVJORUwuZmV0Y2goKQ0KPiArwqDCoMKgwqDCoMKgwqAgZHRiX3BhdGggPSBzZWxm
LmFyY2hpdmVfZXh0cmFjdCgNCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgc2VsZi5BU1NFVF9E
VEJTLCBtZW1iZXI9J2R0YnMvc29waGdvL2N2MTgwMGItbWlsa3YtDQo+IGR1by5kdGInKQ0KPiAr
wqDCoMKgwqDCoMKgwqAgcm9vdGZzX3BhdGggPSBzZWxmLnVuY29tcHJlc3Moc2VsZi5BU1NFVF9S
T09URlMpDQo+ICsNCj4gK8KgwqDCoMKgwqDCoMKgIHNlbGYudm0uc2V0X2NvbnNvbGUoKQ0KPiAr
wqDCoMKgwqDCoMKgwqAgc2VsZi52bS5hZGRfYXJncygnLWJpb3MnLCAnZGVmYXVsdCcsDQo+ICvC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgJy1rZXJuZWwn
LCBrZXJuZWxfcGF0aCwNCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCAnLWR0YicsIGR0Yl9wYXRoLA0KPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICctZHJpdmUnLA0KPiBmJ2ZpbGU9e3Jvb3Rmc19wYXRo
fSxmb3JtYXQ9cmF3LGlkPXNkLWNhcmQsc25hcHNob3Q9b24nLA0KPiArwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICctZGV2aWNlJywgJ3NkLWNhcmQsZHJp
dmU9c2QtY2FyZCcsDQo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgJy1hcHBlbmQnLCAnY29uc29sZT10dHlTMCwxMTUyMDANCj4gcm9vdD0vZGV2L21t
Y2JsazAgcm9vdHdhaXQgZWFybHljb24nKQ0KPiArDQo+ICvCoMKgwqDCoMKgwqDCoCBzZWxmLnZt
LmxhdW5jaCgpDQo+ICsNCj4gK8KgwqDCoMKgwqDCoMKgIHdhaXRfZm9yX2NvbnNvbGVfcGF0dGVy
bihzZWxmLCAnTWFjaGluZSBtb2RlbDogTWlsay1WIER1bycpDQo+ICvCoMKgwqDCoMKgwqDCoCB3
YWl0X2Zvcl9jb25zb2xlX3BhdHRlcm4oc2VsZiwgJ1dlbGNvbWUgdG8gVHV4VGVzdCcpDQo+ICvC
oMKgwqDCoMKgwqDCoCB3YWl0X2Zvcl9jb25zb2xlX3BhdHRlcm4oc2VsZiwgJ3R1eHRlc3QgbG9n
aW46JykNCj4gKw0KPiAraWYgX19uYW1lX18gPT0gJ19fbWFpbl9fJzoNCj4gK8KgwqDCoCBMaW51
eEtlcm5lbFRlc3QubWFpbigpDQo=

