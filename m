Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AB35C61DD6
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 02:02:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1wmI-0001rI-Nb; Wed, 02 Sep 2026 22:02:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=6997dc6e7=Alistair.Francis@wdc.com>)
 id 1x1wmH-0001qu-Hd; Wed, 02 Sep 2026 22:02:09 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=6997dc6e7=Alistair.Francis@wdc.com>)
 id 1x1wmF-0004tK-NS; Wed, 02 Sep 2026 22:02:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1788400927; x=1819936927;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=eGg7heynMheL1phKV1OU7z4qIYj7ICtvbbzlw/8g7DQ=;
 b=qlXWZyEvvLNKqvHw+o/0rQYS4r2kaJaNeSed504/Rp26CPhLDfgQTd5d
 dWYJKnoZ77ZZPsBssDAGysffu8zaYYsB6Fm4i93pcTq26UUtoOzm+nhTd
 BuyDhThKbztmlrkUm6uNPR+mfSgvUMGwy7ddzuHuQ96hS6mnCnuZVEzHP
 VveyCm5vFjyEKd/6LnQBNxk4QUfXODTmEyY9JT6lVenLUNRfwCwjU6yy8
 dL3lcRObSw9NNaIJDtQvAko3+F1HAG76IfsG5mnId67wDjte2m5SBDxmx
 3ILCiHxXMDs7KCGnQl1LnSkDxMiFDhFA4ww95ogt6u5sKUxwiFRcPy368 A==;
X-CSE-ConnectionGUID: WmupvzcHQGqbHTyu+KK3EQ==
X-CSE-MsgGUID: G71Fc8jAQoGKTAEUYPt7sQ==
X-IronPort-AV: E=Sophos;i="6.25,258,1779120000"; d="scan'208";a="155757373"
Received: from mail-northcentralusazon11012005.outbound.protection.outlook.com
 (HELO CH5PR02CU005.outbound.protection.outlook.com) ([40.107.200.5])
 by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 03 Sep 2026 10:02:04 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a9fn4bVuV3y9JTCgydPoUFDlrpSI3Dk4MDgCkwXY2CWAoiRCwJeO7Zu8yGgH0H7nbChSxRI4D9pw2EZJfTdkWOMUk7iBwuzLFgNYcXd9u/8LbGI6YT66co7RNkiXzzwibDjsWX/EulKPTlIWY8s3WbqarWMRMnpRLbKTf6Y3+vY+On2JYPsldQJKFDrGK/Q0cZBQjxyAZv0O7GzAYVSMhYtsdmEnPALqIv5roGSBUoYG2ficL0QtxRXjck4WlJSjHQrmE/SE6NfvnU2fi40TVfuGAHBIn/P9sqN9KKsIxORWDrGPbLIIWiiqMLqABvxOkbEHnD8c2QYDa5jJnF+NKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eGg7heynMheL1phKV1OU7z4qIYj7ICtvbbzlw/8g7DQ=;
 b=cprGfzNYtUfQPfMFmodKibg6Gp0m4NLbY9JgCD1G6k6q0Hfn9e+wvXP64+8v844g6S0Fymx5kY/zlwkC+qm/23fAx5ibJcrg4rkHERUyba7OClhzBAdhMiCB8z0vI0gGuvDo4hbuvyhDDaWkgaGw8LcNtXt5yhK66lZ0HX1UeyBbRtYvi5Spb25+V6j7R2FPPjXv9vzE0hw/86aq0T2z7QKxZ33t8gKtvKHzftrb91/S4EmgANwsHim1qXf5q6ZTWgxjWyddlW36S0UKZfC0vn8J8Z9fuxIiPO3DmO8B0Nfkqc9u3EzevZDt6IzZUiTgLtt8yuOjL++fbcEHX1B8rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eGg7heynMheL1phKV1OU7z4qIYj7ICtvbbzlw/8g7DQ=;
 b=HBJThTo4NSQbgOGAX8Nie9N7LLCgHtTghAyz/70owfWxlDnBSyk0vuJttFQYT2Jm6G+qSSu20ShRo0IN7ws6Q6MHQ0qrXArCAnHV6pyBYtC+7Jd2VHhzrHsdPIiyMohiVUzdYPpRXbR6Vh3T/c9f7Y34omAVM6we5LzT2Z+iDEE=
Received: from BY1PR04MB9561.namprd04.prod.outlook.com (2603:10b6:a03:5b6::11)
 by EAYPR04MB9969.namprd04.prod.outlook.com (2603:10b6:303:2bf::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.7; Thu, 3 Sep 2026
 02:02:00 +0000
Received: from BY1PR04MB9561.namprd04.prod.outlook.com
 ([fe80::3869:e494:2fa8:9888]) by BY1PR04MB9561.namprd04.prod.outlook.com
 ([fe80::3869:e494:2fa8:9888%5]) with mapi id 15.21.0382.007; Thu, 3 Sep 2026
 02:02:00 +0000
From: Alistair Francis <Alistair.Francis@wdc.com>
To: "daniel.barboza@oss.qualcomm.com" <daniel.barboza@oss.qualcomm.com>,
 "joel@jms.id.au" <joel@jms.id.au>
CC: "npiggin@gmail.com" <npiggin@gmail.com>, "mpe@kernel.org"
 <mpe@kernel.org>, "portias@oss.tenstorrent.com"
 <portias@oss.tenstorrent.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "clg@kaod.org" <clg@kaod.org>,
 "chao.liu@processmission.com" <chao.liu@processmission.com>,
 "zhiwei_liu@linux.alibaba.com" <zhiwei_liu@linux.alibaba.com>,
 "asrinivasan@oss.tenstorrent.com" <asrinivasan@oss.tenstorrent.com>,
 "liwei1518@gmail.com" <liwei1518@gmail.com>, "qemu-riscv@nongnu.org"
 <qemu-riscv@nongnu.org>
Subject: Re: [PATCH v2 14/16] hw/riscv: Add property to hart to allow private
 memory
Thread-Topic: [PATCH v2 14/16] hw/riscv: Add property to hart to allow private
 memory
Thread-Index: AQHdOO7GUctGq80cw0iNNl7B3ZyGS7a8HoqA
Date: Thu, 3 Sep 2026 02:02:00 +0000
Message-ID: <2731941a4fab029e377e1edeb9275dd82dfe9990.camel@wdc.com>
References: <20260831021500.82565-1-joel@jms.id.au>
 <20260831021500.82565-15-joel@jms.id.au>
In-Reply-To: <20260831021500.82565-15-joel@jms.id.au>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.60.2 (by Flathub.org) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY1PR04MB9561:EE_|EAYPR04MB9969:EE_
x-ms-office365-filtering-correlation-id: 16638a46-01a5-41cb-68cd-08df095f5781
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|10070799003|23010399003|1800799024|19092799006|376014|7416014|366016|38070700021|56012099006|10067099003|4143699003|11063799006|18002099003|22082099003;
x-microsoft-antispam-message-info: f4iGbbhde8lrbPjisOMXEBCL40gVwMO3RtmWfdIUySVR2fa/xAw/LUxyM3sid/6JfQ1CCMmAA5YxCNcoosRXcxXS6HURG1SM52bpwn1HqxKO2bMnryC/XY0rEVaJQlczEu1b383Bq608p1/Sj9tF28cpGmjhd3Sa15+5YC4/r7SdAqLt5gyTCuYxY6aXvaja3inwiZVVEGLjfmID23WonsKcaRDHA0JVk/hO8crHwGcymfqc2p3N+OBpbI+KFQ7O1sTHunjSqAMGYDLFMpGOjwqchU4xHPLbpyEhLYYaZ6f9DzWLiXSP7D6rkhrtbngiFwBIbGs4khryPO/Mfz8yXRfqjntQLLWW1lKSzGQagSJ2B9C2xvNwv0ERJbf64BajO5I4vzAXT0D/b70KLZkJFs1ECWDfrOUrw+yYprTNWGDptdBK8O/E9zqCFjamkntARSN9ODn8PcY0CPkFFqi9as97CpVwV+T6hVE/X8+YcXxj3t7Fzrq12qzwZOMTm28+O7010TXIWvrHKra2A++CWmi3pJNaT92L7CdMOV8qKi0UOl4d3vepn88+bXg2E60Hs5lZlFrCQt0WgGNWrSruJQ/6QQ1a0mXaJxmkUmRl1PaiGdg2m8EhNkeVBAwbtkltgHj10pdiKycM6OQhWUA7lwr9+/9djO5EI3wadWkIMXmGkMmwfS29+SblyTY814S31MwTwZpTUPCeHrTCYxmk9Q==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY1PR04MB9561.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(23010399003)(1800799024)(19092799006)(376014)(7416014)(366016)(38070700021)(56012099006)(10067099003)(4143699003)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dE51Y2lhSnJ3QVlJelVhUzhheG0yTUFLeVgycU43ZTNHNkhZKzFoNTl5SEdR?=
 =?utf-8?B?U3BwUGhyNG9EYmIrRVVzeCtRemVsdmdyVnlTcmdzemtGOFc1OERUWDRsR2Fs?=
 =?utf-8?B?Uk1vNmpNaVVlc3NJM0NJY21hWWhLb2hYYTl2VXRQV09JQjJjRDQrSjlMSW00?=
 =?utf-8?B?S0wvNkpXTHcyTXRzc0VzUDI0VW4zaWp4S0hBb29tbE03clQ1bEdQUVJUUFkw?=
 =?utf-8?B?M3FEY1BwRUdJNStkQm4zM1NMcUJZcW5xUWV6OXBhbUFKWlIvdHV1MmJwMXFK?=
 =?utf-8?B?emgwSlBpeXRoMWhTdVBjMHQwd2dxeGc1UnZYWjNGVUtTd0xrdUpSUGFsOG92?=
 =?utf-8?B?anlOSEJWTW5qZGdXbE54eE1ZU1NTSEw2VWRBZ0F3eURlNTJWZmpDVzFIcTlD?=
 =?utf-8?B?ZEx2NFd0bWkxWnl0MUpoNENRVG8rQ0FscGQ4bjJmaWt4aDZGUDJoUTVNSDlK?=
 =?utf-8?B?RlhITlE5WkVvOXFqM1RyQkwyd3JGVTJ6NjZ4Yys5aXVxVnNVYXd2aDZDSWtN?=
 =?utf-8?B?ejNlZjI3Y0NqdVFsaTlGK08yaFVQTTM3WVREeVR2YTNydzB6MEVlY1RXL0hp?=
 =?utf-8?B?Mnp3d085QWIzTlpNemQva2dpakhVNXNJL1ZhQUVxWDgyRG5xNzA2WjNyTU5t?=
 =?utf-8?B?czZFSlBnSnBpUU1TMGE2elEvSjh5M2RXcERQVkRScnZMMG1rSWUvaHBQSTBp?=
 =?utf-8?B?dWpMT1NsRUxxSThURENOd1Vta1dJOHRZdzJrZ1V6T3l2WGZXckZ0SEZhUFM0?=
 =?utf-8?B?RWhyWnRxa2lzR05qaHQ3Y3hDanlNM3MzZU5WekpYckVwVTh3S2FLdmJ2OVpL?=
 =?utf-8?B?WnBJbXNYWGRoVHdhMmtTdlNuZlh5K1UxWWJkS091d1hzVUYrUGVPS3RDcFEw?=
 =?utf-8?B?aFlrMHk5bGJRek9LQUkwcmVveXZrQWM1MlVudUNaUTlyNzZWWGduTnNGcXBN?=
 =?utf-8?B?dExIWTlFVGZyaW1aamE2enNQbjFYem51bDNpaDBBSzd6RnREQXZBRkpHVzZx?=
 =?utf-8?B?Rm1mUFZIRVFHMmE2ODlTU1llSmhONzdwa001M2dUL1ZOQVIwdGZQMUVQZURO?=
 =?utf-8?B?RTVSeUY4Z3dWTURGWnJUaFovbXAzWVpjaUFmUnBPeHVqaTJ2Q3R1SUpXVGVu?=
 =?utf-8?B?SWtEc2Z4UU9iZUVGVEhVN3RveS9RUVozTkdiTjZJd1dKQ2RFOFYwVUNqa0xz?=
 =?utf-8?B?QlQ3V29TQWdmVXVERC9aY0dLRDNPZ1BNeGZIeXpzUzgyUFNjY3FNTDlHN1dl?=
 =?utf-8?B?bkw4bGttY0dFYVE4d0pCdjFNY2pzdEVjRXBPSnlld2lXbi82MVVGNjJzcFRZ?=
 =?utf-8?B?VkVzN21nY0FNeGRRb1ZlNkxFRkZXWGsrUUFJV3Q0cHdNN2l5YVNDOWdJQ29i?=
 =?utf-8?B?NkJQZitFZHY1RHlRVnhNbUtPYitEUDJ2eXF0VDRJRHhXbWJEUENSVVdXbVEz?=
 =?utf-8?B?UHo3MmNTTmZSUzhIL0VMYWRBc2g4eTQwV3lBczFMY3prTHU5eUxFbU1PNllZ?=
 =?utf-8?B?NU96d1J6eG1ST2g3VVpYcHZZME5qNWFBZXdjaEM5NzI0WGxOejZPYlRiYjMy?=
 =?utf-8?B?c29DUEFmWUQ3L0RlZGd6SnYvRU9JR2ZEQVZLRGtiT3NZZVNscEdnek5iRDVV?=
 =?utf-8?B?NmphTzR5UmhoT0UvVEpRbmlsRStDSnkyNWZtVmE5YnhKVlc0RGo1VjF5VU0r?=
 =?utf-8?B?RG5iUTVKOFowWnE2V3JYUzY0eFZrZVgzOGFqSmRlcnVrd2tyeUltdDdjakxT?=
 =?utf-8?B?ZXBEZkVVbEVmOEhzNWZZL2I2VVRUZ0FSZ0tuSlk0dEhYbldObEoyeDBQa3B0?=
 =?utf-8?B?TFI1c09PWG40VVFrTC81NW02a2FJSzVkVTF0OUphbkRqMVFpN2s3REFwMm1u?=
 =?utf-8?B?QWpHdDZ2MmJVeEl6U21kSkxvWElQS2x4T2RYZHNFRllncHRBU3NTZGNYeUth?=
 =?utf-8?B?c0JvWm8xZDloa1JoUndURlNLUUdodXNITlNDYVhacmdDaFNhNlVoeHFuR2JC?=
 =?utf-8?B?RUorZXM1N0xyeElZL0UxaEluOFNJU3lCZ3hFYXRtUjJROFRWTll1WkczQ0d3?=
 =?utf-8?B?aisxNTBOTmtuZGFZMW9sT2lYOURPTE5JV0pIbzgrSmUyVTNyckZUVHoyaURt?=
 =?utf-8?B?aTZLc2RWUThhdFFMTThsVGtxaENlTHVWR2QwUDdCVDBKd1BhdzdLVVdpU25Z?=
 =?utf-8?B?WkhLVFk0Z05vVmFIUW1LcGU4ZkZ0Q0ZzaHFnRVBvaXorcnNXYnRQRURlQUFS?=
 =?utf-8?B?ZU1ndHpRaFE5Q3B1R0pIeDhQamVrS2t4eW4vem4vMUFtUVUrd2FPWHlnQnBB?=
 =?utf-8?B?ZUwyQ2tEd1Q1RUI4SEMwSk1uMjc0Q3BGNFN4Y0lSOUZrY1JoaG9DZXFvRmti?=
 =?utf-8?Q?EbA+Zj4QE98Z+fldNwhmeZGplaIH9MDYeP5RIcjoAKQPD?=
x-ms-exchange-antispam-messagedata-1: 5qX1871ez4qxJ+H72aJ1uxgrz6xBtlV++fc=
Content-Type: text/plain; charset="utf-8"
Content-ID: <42BB41EBB6B9124986CC8FF227A38D30@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: J2mYvgXiFJUB+OEBRHUK728CwYkdbdZvNbEz0F+c7IU8/eX+qvJQw5dAp5I6+WcgED32a/wQS+0baNkgyX43CroYg+NRSrpetexkPqcqLSImzc+pEV7ezlnX6VrUzMXEkUMV0iUa2tnP3Uwc+2Z1eL9IWMqswtVa4EM92dhjVhex7J9bjylpouOVV7tWJus5NRxmkf2QMMlw5txuufLI34FfsS0ASLw1XWDMZSjEx9kEzqy2/H8IHHpxkDbFJPHcOPsOeYLhC1Sxq4NJ3rn2DwZzHQNlvF+k1nWxEN+SYhC3J+NDKzl9tOhxFttS0PHHVu1YkN4r1k7jBmFiaEKfMA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: vV++Y8C8Ks6Krw7PxkoPn5TnZ1EGBxy1XaHxg6dctkCgvFN1MwpROVIEEc4YVk4rfXOVrAHJqqcmUj/6XLc9U8+TzKW6EQMjlDjFO8thC2WbLTploWvWExV4m4TnMM9NTPpIuiOiGnKO+H191VHsDiIYcTh4Xe632jikL26sh/3EZhWX6rG+Y8alhWe3oBSvZas0rjGLuScF5ywZGnHsY9om6JgMzs2Oh9ADNxdNcLb8bNHREgGbfO3lnURt0lPZSENunSreVUS14ZAz0pgfN27GRC7hj5KAGiPBknw47EJ78zm3GbKOEt4t6yr6mKOHU1nPeGr9YP2uY/9s2G1Wksc92KUcJm79J7d5ue6fgr1oo7ZO4B+gmmfzTMTvFDgvh/+ixGtTzRTBFQEOaTlwJ4YPgxSVe29W2pXVdlXiudIDbNo9mBI9O9DB1INtiuoMB+W5qDrAEzpolPfu4t9P5rkxfsxiKc4mct1S8KDSjq8l3LtYDzMBhQu/qptk4+w1S4Wu2hmRlIsE+j0CN8RRfchWHsJmghLJs13l7wfY0q78sufAi1L2Oo8fe2XgjySLG8Oui/SQfkd2ImhPzXOPnI7otxzq9ApHtNQ30LYiEqlzKWqj4VLuf7EVzYYqhZrX
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY1PR04MB9561.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16638a46-01a5-41cb-68cd-08df095f5781
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Sep 2026 02:02:00.4192 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 53FiM9/Ba2P0DYI+1RUPpsV5rPPrt4Nei2Xc93swTU1/VicEkDXKKJgAfNEnJfTGtkWElnVA0jXh9tVlKyJa72tUIHGnem7Rs8CGIl6OjW0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: EAYPR04MB9969
Received-SPF: pass client-ip=68.232.143.124;
 envelope-from=prvs=6997dc6e7=Alistair.Francis@wdc.com;
 helo=esa2.hgst.iphmx.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_PASS=-0.001,
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

T24gTW9uLCAyMDI2LTA4LTMxIGF0IDExOjQ0ICswOTMwLCBKb2VsIFN0YW5sZXkgd3JvdGU6DQo+
IEZyb206IFBvcnRpYSBTdGVwaGVucyA8cG9ydGlhc0Bvc3MudGVuc3RvcnJlbnQuY29tPg0KPiAN
Cj4gVGhlcmUgYXJlIHBsYXRmb3JtcyB3aGVyZSBDUFVzIGhhdmUgZGlmZmVyZW50IG1hcHBpbmcg
b2Ygc3lzdGVtDQo+IG1lbW9yeS4NCj4gVGhlIGdsb2JhbCBzeXN0ZW0gbWVtb3J5IGRvZXMgbm90
IGFsbG93IGZvciB0aGlzLiBUaGlzIGFkZHMgYW4NCj4gb3B0aW9uYWwNCj4gcHJvcGVydHkgdG8g
YXNzaWduIGEgc3BlY2lmaWMgbWVtb3J5IHJlZ2lvbiB0byBhIGhhcnQuIFRoaXMgYWxsb3dzDQo+
IGZvciBhDQo+IG1hY2hpbmUgdG8gYWxpYXMgdGhlIGhhcnQncyBtZW1vcnkgdG8gc3lzdGVtIG1l
bW9yeSB3aGlsZSB0aGUgaGFydA0KPiBvbmx5DQo+IHZpZXdzIG1lbW9yeSBmcm9tIGl0cyBvd24g
bWVtb3J5IHJlZ2lvbi4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IFBvcnRpYSBTdGVwaGVucyA8cG9y
dGlhc0Bvc3MudGVuc3RvcnJlbnQuY29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBKb2VsIFN0YW5sZXkg
PGpvZWxAam1zLmlkLmF1Pg0KDQpSZXZpZXdlZC1ieTogQWxpc3RhaXIgRnJhbmNpcyA8YWxpc3Rh
aXIuZnJhbmNpc0B3ZGMuY29tPg0KDQpBbGlzdGFpcg0KDQo+IC0tLQ0KPiDCoGluY2x1ZGUvaHcv
cmlzY3YvcmlzY3ZfaGFydC5oIHwgMiArKw0KPiDCoGh3L3Jpc2N2L3Jpc2N2X2hhcnQuY8KgwqDC
oMKgwqDCoMKgwqAgfCA4ICsrKysrKysrDQo+IMKgMiBmaWxlcyBjaGFuZ2VkLCAxMCBpbnNlcnRp
b25zKCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9ody9yaXNjdi9yaXNjdl9oYXJ0LmgN
Cj4gYi9pbmNsdWRlL2h3L3Jpc2N2L3Jpc2N2X2hhcnQuaA0KPiBpbmRleCAxOTdmYTE2MjMxMTUu
LmMzY2QwNWEyYzg3NyAxMDA2NDQNCj4gLS0tIGEvaW5jbHVkZS9ody9yaXNjdi9yaXNjdl9oYXJ0
LmgNCj4gKysrIGIvaW5jbHVkZS9ody9yaXNjdi9yaXNjdl9oYXJ0LmgNCj4gQEAgLTQyLDYgKzQy
LDggQEAgc3RydWN0IFJJU0NWSGFydEFycmF5U3RhdGUgew0KPiDCoMKgwqDCoCB1aW50NjRfdCAq
cm5taV9pcnF2ZWM7DQo+IMKgwqDCoMKgIHVpbnQzMl90IG51bV9ybm1pX2V4Y3B2ZWM7DQo+IMKg
wqDCoMKgIHVpbnQ2NF90ICpybm1pX2V4Y3B2ZWM7DQo+ICvCoMKgwqAgLyogT3B0aW9uYWwgcHJp
dmF0ZSBtZW1vcnkgcmVnaW9uIGZvciB1c2UgaW5zdGVhZCBvZiBzeXN0ZW0NCj4gbWVtb3J5ICov
DQo+ICvCoMKgwqAgTWVtb3J5UmVnaW9uICptZW1vcnk7DQo+IMKgwqDCoMKgIFJJU0NWQ1BVICpo
YXJ0czsNCj4gwqB9Ow0KPiDCoA0KPiBkaWZmIC0tZ2l0IGEvaHcvcmlzY3YvcmlzY3ZfaGFydC5j
IGIvaHcvcmlzY3YvcmlzY3ZfaGFydC5jDQo+IGluZGV4IDc0Nzc1NGJlNjE1OC4uMzJmZDM5NzM3
ZmY2IDEwMDY0NA0KPiAtLS0gYS9ody9yaXNjdi9yaXNjdl9oYXJ0LmMNCj4gKysrIGIvaHcvcmlz
Y3YvcmlzY3ZfaGFydC5jDQo+IEBAIC01Myw2ICs1Myw4IEBAIHN0YXRpYyBjb25zdCBQcm9wZXJ0
eSByaXNjdl9oYXJ0c19wcm9wc1tdID0gew0KPiDCoMKgwqDCoCBERUZJTkVfUFJPUF9BUlJBWSgi
cm5taS1leGNlcHRpb24tdmVjdG9yIiwgUklTQ1ZIYXJ0QXJyYXlTdGF0ZSwNCj4gwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgbnVtX3JubWlfZXhjcHZlYywgcm5t
aV9leGNwdmVjLA0KPiBxZGV2X3Byb3BfdWludDY0LA0KPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB1aW50NjRfdCksDQo+ICvCoMKgwqAgREVGSU5FX1BST1Bf
TElOSygibWVtb3J5IiwgUklTQ1ZIYXJ0QXJyYXlTdGF0ZSwgbWVtb3J5LA0KPiArwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBUWVBFX01FTU9SWV9SRUdJT04sIE1lbW9y
eVJlZ2lvbiAqKSwNCj4gwqB9Ow0KPiDCoA0KPiDCoHN0YXRpYyB2b2lkIHJpc2N2X2hhcnRzX2Nw
dV9yZXNldCh2b2lkICpvcGFxdWUpDQo+IEBAIC0xMTcsNiArMTE5LDEyIEBAIHN0YXRpYyBib29s
DQo+IHJpc2N2X2hhcnRfcmVhbGl6ZShSSVNDVkhhcnRBcnJheVN0YXRlICpzLCBpbnQgaWR4LA0K
PiDCoMKgwqDCoCBvYmplY3RfaW5pdGlhbGl6ZV9jaGlsZChPQkpFQ1QocyksICJoYXJ0c1sqXSIs
ICZzLT5oYXJ0c1tpZHhdLA0KPiBjcHVfdHlwZSk7DQo+IMKgwqDCoMKgIHFkZXZfcHJvcF9zZXRf
dWludDY0KERFVklDRSgmcy0+aGFydHNbaWR4XSksICJyZXNldHZlYyIsIHMtDQo+ID5yZXNldHZl
Yyk7DQo+IMKgDQo+ICvCoMKgwqAgLyogVXNlIHByaXZhdGUgbWVtb3J5IGluc3RlYWQgb2Ygc3lz
dGVtX21lbW9yeSBpZiBwcm92aWRlZCAqLw0KPiArwqDCoMKgIGlmIChzLT5tZW1vcnkpIHsNCj4g
K8KgwqDCoMKgwqDCoMKgIG9iamVjdF9wcm9wZXJ0eV9zZXRfbGluayhPQkpFQ1QoJnMtPmhhcnRz
W2lkeF0pLCAibWVtb3J5IiwNCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgT0JKRUNUKHMtPm1lbW9yeSksICZlcnJvcl9h
Ym9ydCk7DQo+ICvCoMKgwqAgfQ0KPiArDQo+IMKgwqDCoMKgIGlmIChzLT5oYXJ0c1tpZHhdLmNm
Zy5leHRfc21ybm1pKSB7DQo+IMKgwqDCoMKgwqDCoMKgwqAgaWYgKGlkeCA8IHMtPm51bV9ybm1p
X2lycXZlYykgew0KPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcWRldl9wcm9wX3NldF91aW50
NjQoREVWSUNFKCZzLT5oYXJ0c1tpZHhdKSwNCg==

