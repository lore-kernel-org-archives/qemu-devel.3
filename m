Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B106C2BD09
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2024 06:11:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMiLs-0005Tj-F7; Thu, 27 Jun 2024 02:11:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yaoxt.fnst@fujitsu.com>)
 id 1sMiLq-0005TS-3Z
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 02:11:22 -0400
Received: from esa9.fujitsucc.c3s2.iphmx.com ([68.232.159.90])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yaoxt.fnst@fujitsu.com>)
 id 1sMiLn-0004KB-J0
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 02:11:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1719468679; x=1751004679;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=AxFEq5I646bhFJwuJnGnETpvRj6/4MI0x7frjZve+tI=;
 b=QF0rrUGz03lG5RECq3Wl96lfXv0Ln75dTsc0A2+UdvJzGwI2tm5xkAhK
 zBQr2JkGdkjvexOIahkaKZC0BJfo0H/c24UhWZD5z2ob1qrsyBu8I+XZ4
 /V/udzTT2sNEpLvWLcTVkcL5q9L8YkkYjVJqYkODw5Hz83l9+Nsy3FaNu
 flmk+W7U610A5zChys7eRYZ2CQ2gUN8wm022PFfHDNqes6B5bW0msAOHT
 K2nUX83P8QUg06KlB/KM56w8BgDzoHAZbJZjVUeIBF7zDrlZtFVThBRkW
 wOtTB1RDtsUnCv8TWuJYt9kBoC91ZwxPXs7XBAJQuw6Mpvl7B4bnOv3nY Q==;
X-IronPort-AV: E=McAfee;i="6700,10204,11115"; a="123666293"
X-IronPort-AV: E=Sophos;i="6.08,269,1712588400"; d="scan'208";a="123666293"
Received: from mail-tycjpn01lp2169.outbound.protection.outlook.com (HELO
 JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.169])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Jun 2024 15:11:15 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cu0dnuaNxlkt8OlH8TFas2fI58XHzZjHS1ww/gktaMxd3FOr1KBDjr1EKb6ilGAhEJTpOW1kAahFEne8MuZVQRvZnUgEWMI4TNUaskuCLIRdBXnN7Xm92IH/FRJbMe+i1Wa48YQ0hZzO0ntpInOqrfwrBRUe4VYCzvf6dFRfaTEyBwGI4BmzNggtNQ2uEZOY/gf0w6WxgnkpSxOLzG3WPBaC+/44q+RqRFE5XnMjN9SD8y15MhGXAECZA6JxSrYMZTx7VEqV/cUDPPIG/nQcxaPT9BTCMQcjv0rRL63xTDkoFxE+2DHFrIbC12WbzeRDdMnPoGjTGvtg6lV3rILtWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AxFEq5I646bhFJwuJnGnETpvRj6/4MI0x7frjZve+tI=;
 b=L/+N4gNPtbTZ2hfdEI3T39TvkkvTqbfRBPNLDEOssi1prkFFeRV+/NTVH6jl/15dxIamidege8MwlsmeIsnsEr3qf+q9yTwcnmQLJ6pQkp5rAafrTPloNRFcVymdxunGZr4b2yhhH2lsbIBkbtiwnyHolgAD4mukQchrlQiC5QQZv7X9rD6amSHipL46CaUCvyN6AP4/CEXA0jdCl30gxuaCQKJc2S75j3xBI1h0LHN1Zy/DIB5jh0mdWHo6M5MxSSJc4elqD9XMnbnBzlZ+2ja5dobN2VaTPy6mllgPug4UWpnQBUGWtd34h9IRc4NMtUlBZq5baYBYrtEGyMyh+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OSZPR01MB6453.jpnprd01.prod.outlook.com (2603:1096:604:ed::14)
 by TYBPR01MB5342.jpnprd01.prod.outlook.com (2603:1096:404:802e::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.32; Thu, 27 Jun
 2024 06:11:11 +0000
Received: from OSZPR01MB6453.jpnprd01.prod.outlook.com
 ([fe80::9ef5:e83:9047:de11]) by OSZPR01MB6453.jpnprd01.prod.outlook.com
 ([fe80::9ef5:e83:9047:de11%6]) with mapi id 15.20.7698.033; Thu, 27 Jun 2024
 06:11:11 +0000
To: Gregor Haas <gregorhaas1997@gmail.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "philmd@linaro.org" <philmd@linaro.org>, "richard.henderson@linaro.org"
 <richard.henderson@linaro.org>
Subject: RE: [PATCH] hw/core/loader: allow loading larger ROMs
Thread-Topic: [PATCH] hw/core/loader: allow loading larger ROMs
Thread-Index: AQHayEqI1jDVIa5FlEWiy9YcZkPkkrHbIHag
Date: Thu, 27 Jun 2024 06:11:11 +0000
Message-ID: <OSZPR01MB64532802F85690BB7C8BAA998DD72@OSZPR01MB6453.jpnprd01.prod.outlook.com>
References: <20240627020207.630125-1-gregorhaas1997@gmail.com>
In-Reply-To: <20240627020207.630125-1-gregorhaas1997@gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_ActionId=deb18a2a-2aa8-4458-8acf-2c04ecfec823;
 MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_ContentBits=0;
 MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Enabled=true;
 MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Method=Privileged;
 MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Name=FUJITSU-PUBLIC?;
 MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_SetDate=2024-06-27T06:09:15Z;
 MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_SiteId=a19f121d-81e1-4858-a9d8-736e267fd4c7;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSZPR01MB6453:EE_|TYBPR01MB5342:EE_
x-ms-office365-filtering-correlation-id: 0c640a21-ff98-49bb-3141-08dc966ff184
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|1580799027|38070700018; 
x-microsoft-antispam-message-info: =?iso-2022-jp?B?NTRhTWtBYmhuUVE3MzdpeDJlSk5xSEpYSktHWmVGYVlXR2xmdkFSVkFv?=
 =?iso-2022-jp?B?QmVGekV0MGN1bGc5ditNWklFczFaUjg1NVdoZHZRMHRoTjFyby9ISFlp?=
 =?iso-2022-jp?B?UTBPTWp0SVFSVVpNZkR3TzkraVplbXA3T1paSVBzRzMzYjk1T3hndnNo?=
 =?iso-2022-jp?B?RXFLWFhmUjkxdUV6VWkzNjFKQytIVWVSaWthM0p6WnQwV014V3BydnYz?=
 =?iso-2022-jp?B?QkFxeko2ZUhCYkwxT05sTi92UlBXYWN5VzFyRXZzN21QSDhWa3ZJSkVy?=
 =?iso-2022-jp?B?dXlhT0J5YjZhOHkva1psRStWODRSY2ltQTkrL1BmTjB6YnlpcWFvbXRs?=
 =?iso-2022-jp?B?ZENzK2YvWGF0K3NTQS9BNWpvZ3hsTS9yR1lvR29uMUJiendQUWVwdmtY?=
 =?iso-2022-jp?B?VGNJeTI0di9LcVdBdm9JbjBsWW5Yb2xPRDhzeGkzSmNMR3dBRnR5MUo3?=
 =?iso-2022-jp?B?QWlMR2hGVjRDZ0JnTEp4TTA3TzdhZS9POXBpTm4wSHBIblpCazRSWktC?=
 =?iso-2022-jp?B?UVpPTmV1dHpaZXRzczI0Y01DbWdtbERzZmY1WlZHWHUxVHJ5aGJYNFJs?=
 =?iso-2022-jp?B?U2d0a0syeEhZZ2RUcG9Bb2xUOW5QUkwrTEcwZXpPUkJFaWE3VTI3SnJq?=
 =?iso-2022-jp?B?S0FUbVlyKzFBL1QyMlduNG8rWWdQLzdlMkdvcEFuWHlvd1cxeEU4MkY0?=
 =?iso-2022-jp?B?aHdqSjdOK21USnNVeUludVpBYnZhM0orMzlNcTZYbm9HcjQ3MytrY05X?=
 =?iso-2022-jp?B?dlhjbUMwNGpWRFIzKzlnMGpiNWs4N01ISGs2L291RGgveXBtUTVyT3Fs?=
 =?iso-2022-jp?B?QU9STXhCWEhkaXdzZGFPZXkra0xtVnFpRHRodXhORnJ3cUYrOEs1d21a?=
 =?iso-2022-jp?B?KzN1REE0RXp3Z3VVazQyMWw3dEFyOTNsQkR4TkpQQmY5UHRCSklISzRx?=
 =?iso-2022-jp?B?b2U1TnhOcGhzRENUYWhHYUdxbUY5bzFweTZFcFBhTzVuaGd6MU1TcDVB?=
 =?iso-2022-jp?B?ZWNjdStUUTdZRDU2UjRRK0tsYkloOUZZQ3JmY3U4K3RzWHVjdHlBUkJl?=
 =?iso-2022-jp?B?Qmx0STd6azlldytiWHFaQ1ZXb1NPdTBZZFZORW00TUR2S2NyRnllYVVH?=
 =?iso-2022-jp?B?aFlBbCtlcDg2QXI5NmlvQnBTb3pQb3RUV2p4TzVpQUt3RFYxWjgwQThX?=
 =?iso-2022-jp?B?bWVJSWRZOVR2NmJodTdoMzB4MWZUd29IUzhxRGpib3RTMGVXRTVQdUJa?=
 =?iso-2022-jp?B?QVZ6MHoycFlyVlVoSnZHMlF1dnB1V0YrdS83OXhOY0VGVUVFdHplbG5X?=
 =?iso-2022-jp?B?L1hoZVJDVTN2bHYxRk5KaUR4SFZxa0lKc2JBeDhLTlhhNlBIMHVrcjNw?=
 =?iso-2022-jp?B?cGY5Rmp1eHJhYXZqcFA3TVVKaGxJMEVJOWVTMFhoU3A4ZGRkV25UMUMv?=
 =?iso-2022-jp?B?NjU3REsremxaNDFVL3MrcmQwQUorV093NVhBWnErWDRkZ2VUMmVHN2hD?=
 =?iso-2022-jp?B?aXVCb0ViTWxEeWwzSFB0TGRrcldYZkIzYm9pa1JjODNZc3FZRzJhejhF?=
 =?iso-2022-jp?B?T3k2VStPTU1DSjV2WDN0SlFSdmlDVmtqaUllTjVMRExoQ3FqcEZHbVp0?=
 =?iso-2022-jp?B?Y2FwaHZmSi9lQkdmSFBmQWZrQk9zR205WklEVzAwcVlMdXpLenRxaEZ3?=
 =?iso-2022-jp?B?VzkxQmVzWTlYc01Kb1BvdXM2Y3FvVWZZUi9WRkdtSnBENkJFMlpqNDQv?=
 =?iso-2022-jp?B?N3BsUElZZUZpUmNSL0pnRW1iZFVUOENudEp5bi96Zk8yNjllMm5lYXZ1?=
 =?iso-2022-jp?B?MFAveElrMExRRG52ek1FZW1TK2U2NW16Q1JRWWgyd2VoSDFXdTkwaXVx?=
 =?iso-2022-jp?B?WC95QnQ1Nk9pb2FWU1pwQnhUN0drMVpyRlBsY3lHR2hlRXljU2hXUnN4?=
 =?iso-2022-jp?B?WjNpYnJZSEpkZWp6VDdyQTQvcElPaDdINzNUWlliRzZiUGpFdGlGTlpr?=
 =?iso-2022-jp?B?YkZwQ3N0dnM3UGUzWGlvNlZBc216MlRBL3ZoaHkwU3ZNSVFrNFhhNnk3?=
 =?iso-2022-jp?B?Q0YyREZCZDRreGtBUy9tMVg1RmQyOTg9?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-cn; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:OSZPR01MB6453.jpnprd01.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(366016)(376014)(1800799024)(1580799027)(38070700018);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?Q2N2TkYxcUZLZ05Zd0ZTRWJpK0YvZ0FpSnpNNHlRbWo4dGMrRGkrK2VI?=
 =?iso-2022-jp?B?NjZ2S2RCRXFDY2hnTUV4cFl6UjZiVEF5NFNGdXNCdlZkaHlVNUxvajcz?=
 =?iso-2022-jp?B?NG9Sc3hMVlU4VlhueU90Ty82N2RQNFRzenFRNHVLSWdRNEFKVzMxaVQ1?=
 =?iso-2022-jp?B?Q21nblpwNm9hbVFWTEtWcmY4UGk5MjFtQk55TmE2dXU2LzhYM1kzQ0tl?=
 =?iso-2022-jp?B?Tm1lSlR6ZmVDYkt2WFVSMHEvMWcxUGw0UkljU1Q5R1hjMTh4ckUrWHpL?=
 =?iso-2022-jp?B?Z3M0bmdXdWZJNlhoVlRFb09vTkRlUlVWc005eFI4WW9SWUwwUzduOEY3?=
 =?iso-2022-jp?B?MVZvMDBtWmkySEdJeWxhTDdUWm9KcGgwcFdjcGQvVnNpL0VINHJEdnZj?=
 =?iso-2022-jp?B?R0tvSHFwOWtScVlzU2J4bmdKWjVyLzJIRjhLTDVwVnErMWFXcGxDVjNt?=
 =?iso-2022-jp?B?SDdvcHEzSTZaTHEwS0loU0hSMWxKV05mWjR3Ry9xVzNWaG5jVlF5Tmp5?=
 =?iso-2022-jp?B?WWxUYWpRVU02S21lNGlRTVAwRElDTDhtU3lBeHVWQm96UkxvVm1ENHpQ?=
 =?iso-2022-jp?B?Y0ZQK0pBWTdNaGQzV0JmM0NkQ292WmZ6TThrdVBCcFp0NXlmL253elN1?=
 =?iso-2022-jp?B?L3E3UHo5ZUxTMGpZL2pENG5TZWJFbEV2Znh4NHg0ZVZnck1TVkdGYWxV?=
 =?iso-2022-jp?B?QU44TEh5M2xTbHdzSE5LNEdZamdmUGJ2dnFwOXZzZFBxQ2ROZDVBazdN?=
 =?iso-2022-jp?B?R0Rta0ladml0c1JWSkx2VG5uN3RYZENOUzMwYkt2cXRVRkFMUVdUb0xN?=
 =?iso-2022-jp?B?WUZqR0hPdUZRSDFxZXRWbDZnTjZpNkMzZUNQTytqbVRyekE5aVUwUTl0?=
 =?iso-2022-jp?B?MlFnVjBmd09sY0hHL1JrTFBXckJvNFpZdWhieU1mNTBHamhGZTJOS0do?=
 =?iso-2022-jp?B?Q3plM2VLcnFaTStMaFAzYTM1TGY1bHQxVG9pYWpFQy80S0pGUCtGelh2?=
 =?iso-2022-jp?B?eTJBWWlMd01VQlZBcjhZZExFSWU3aUVZaUdKcnU3WGhuR24rK3lDem53?=
 =?iso-2022-jp?B?dVJMWm00RE1jckR1NjFaT1FPQzU1dUErZ3lVR0dVMVBVdnZWd3l2d1pL?=
 =?iso-2022-jp?B?emNqVmd5dVBzRWZQNGhiV1V1bHVMK0RDYm1XU0RtTU8wTDVoNWFuZXp0?=
 =?iso-2022-jp?B?T1ZiMjM1aFoyVm9nRm1vV3NCaExkSFlhbHVPN3FnSFd2UktVeERUWFNC?=
 =?iso-2022-jp?B?ZGhnN1FkR0pYUTRaM1dOdm5YOWQ1YXNpVHdYZkt2aWpJUHVua3g0cDQ3?=
 =?iso-2022-jp?B?eVhaWW1KVi9MWjhVMHlKZys5dHJVaG9QSWI1MWY0N1REeHBsY2p6QzN0?=
 =?iso-2022-jp?B?TU9wMXBMZHdtK0pURXZmY2Z1dFNaN0txTm5idENwOXp6K1ZYeTZzN3ZL?=
 =?iso-2022-jp?B?WGgyT2ducUpSRzRueXRkdGxRK3N4UVYzeEFNbzJ0LzhaT09YWEpKVTRu?=
 =?iso-2022-jp?B?akg1YjdMKzZCOVVmcnpaTDloNHlrcHlmcldFdHFSMDdwS2VvRWpMQzNy?=
 =?iso-2022-jp?B?MWNSQ0VjcDVLNnQ2ZGhuZlllM1FmTHlrM3loYUpmSFlsdVdnQlhQV1pL?=
 =?iso-2022-jp?B?N0lFbkNxbFFuU0lrVzQxbTRJbEREYkNhV2xQSW5vRVk5Y3BpWHhyeWtU?=
 =?iso-2022-jp?B?dU1BQTc0a1ZvcnFZcDh0WnN2dXlPVkNBc1l0b3RZaVo3WnlWYWJhTDVR?=
 =?iso-2022-jp?B?MW1Ock90ejZjc1NsK1dvVTFua1dMZnNlQWtZYzZMZG1NS3R5d29YSGox?=
 =?iso-2022-jp?B?TGdVSGtzbndWQlhOa2s4ZC9kbXRsdk5ZS1pUZnRtWUZwZjBCTzBrK1l0?=
 =?iso-2022-jp?B?bFlIUTJvbEE1V1ZsRzgvT1JTY3lpYVlqaEx3WVdXcFhBT1MrMVlqTmlu?=
 =?iso-2022-jp?B?ZmxSdFltb1YwSU1pa2ZIczZ0OXFzRS9rcjEwa2Y0UFRIUWZtdDZhWmtS?=
 =?iso-2022-jp?B?R0ZBSlFtc3BGZWZkWGFnTkpEazhnd3RUcURUN3VuYzhRSG1ReHpqWGNO?=
 =?iso-2022-jp?B?U1AwZlRMdkRFNjFVaElsRFl6eGIxWFdJNTZXL3g0ZW5vU2sxZWVxUzZC?=
 =?iso-2022-jp?B?YkhtN0YwS2dWa1djdUZEWHFidTRSN2JENWhOK0N1akdDVDhmUXFyd2V6?=
 =?iso-2022-jp?B?RjZxL25NL0pMQlpLaVZBUjFDa2o2QW5tYmFTV3d4VGlKdHhEU3YvSzMw?=
 =?iso-2022-jp?B?YVFRc0huOVhjdFhZbXBON1ZwcmRiaERxc1o3N1NKdEJTQWFML2lnS09Q?=
 =?iso-2022-jp?B?RHhSMQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: pru0o1ECyXtn9Vd/VlEzTTRBTT27eUONctmNbfyVg00zWVt+QCJQrM/bCeKWYmcDOlIe5+i7zer8pLQ1iBpxyANMfWe2mOVsenp8zak+v7VsjhgXYutlsA0wMJhzaWS/Wdwjh+RnocTRDuaszllrnidCB+FjhZjPIPnpwDiWzGHRLlfGagIkxFPlXJwTX0pm7TJYDkOwlwM5ZDXF8sKgSYQ/6VrqXCxzVtkE7lC0nHAYELLjpYVwpOSqKehTTjrVpl1PHrdKh6DUS3UqqlWru9WCaK1KqI95jzHJPPDacteMQUFxzZP+bXSRwEG9Nnt5GamHFgXf5FAEZGDFGsxzruWXFfKmEgisxixAk0N8zichpthNUu2SNObciZ0TjwIknWbHl6UOBjN0sTE5xwrGloqcdixjKc5H5dSrNqY6znVSCzrpK9HW2O3bCo0tOHm6WlMoCK6ZqH7vF+UCnHEGAvfSbYOfqR3Tm6j5mIIQNN64pnCspaRWBGD9X9U3dhqzWN7Wmq21AESc3S1bvHDdvzD9ecM5R8k/764/AlIO23YwJAFswwrL3d6A5lP9kUPlrXV0/qrcbWWRUZ5w1sPOhgcWGcG1iABLajlap+IJi1uyEDDKnubOzN6TLs5uQf55
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB6453.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c640a21-ff98-49bb-3141-08dc966ff184
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jun 2024 06:11:11.7205 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xuD/bZj6HpW5yigpisQIL88N/ocFmuWSdW8jEkvsSp352XIVHyAEq9monJlma8rfFWDeukJznSCmlk5GE9KATQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYBPR01MB5342
Received-SPF: pass client-ip=68.232.159.90;
 envelope-from=yaoxt.fnst@fujitsu.com; helo=esa9.fujitsucc.c3s2.iphmx.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-to:  "Xingtao Yao (Fujitsu)" <yaoxt.fnst@fujitsu.com>
From:  "Xingtao Yao (Fujitsu)" via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi, Gregor
>=20
> The read() syscall is not guaranteed to return all data from a file. The
> default ROM loader implementation currently does not take this into accou=
nt,
> instead failing if all bytes are not read at once. This change wraps the
> read() syscall in a do/while loop to ensure all bytes of the ROM are read=
.
Can you reproduce this issue?=20

Thanks
Xingtao

