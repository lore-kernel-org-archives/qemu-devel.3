Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E119C27C4F
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2024 00:28:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sO4tu-0001Uz-7r; Sun, 30 Jun 2024 20:28:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yaoxt.fnst@fujitsu.com>)
 id 1sO4tr-0001Ud-Jd
 for qemu-devel@nongnu.org; Sun, 30 Jun 2024 20:28:07 -0400
Received: from esa1.fujitsucc.c3s2.iphmx.com ([68.232.152.245])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yaoxt.fnst@fujitsu.com>)
 id 1sO4tp-0008Nq-8b
 for qemu-devel@nongnu.org; Sun, 30 Jun 2024 20:28:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1719793685; x=1751329685;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=4HDF5oGlx7NpFU+lQrFmIV8qbDsJQimz0TATo2Ct3Mc=;
 b=aXp6Z/YEQNxbLWFJgVn80/3cytPxAJkrPDXbRRLp0EqXuIdr0nYj3yQf
 gFNVD/JJuDIotGjxbecFK66vVbRkF41cuU1jCJMuMuT6F8mGAA3NJVGQq
 HA7Kh6Gel2VdBnyRU4at+XClKrV8mR0UxpAUiskmOdyz99hi9yfUyU7pX
 KcM62y9m3LzHoyCIE4MP554cYx6MTKRyKg+moQdStD4leP5eJLyHs2xBF
 3A9jDCjsq8vH/FJHynEP8jqc8zfboKz+0Ld64waRMv0PKyGUzQnnqAwre
 WVplZgm7vb/OK1JL2KEwEsY9aqzZU8fro5sk4GwSUH5vqQf70/js6akhJ A==;
X-IronPort-AV: E=McAfee;i="6700,10204,11119"; a="34942457"
X-IronPort-AV: E=Sophos;i="6.09,175,1716217200"; d="scan'208";a="34942457"
Received: from mail-tycjpn01lp2169.outbound.protection.outlook.com (HELO
 JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.169])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Jul 2024 09:27:56 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SnlKF+PfRS0RdUDOzrHrk7SE3ZdkoCbN8J6QUI+GRbr3A3yabsZuibapiJokC+Q6XL8gf7SSR7fQgRlSN+mquJY4mgN0YPuoOqXHxXueuwVGuhWyfD2U8g6A2t7mu30G9TYBaUlDPB1dVHnn3ZgjgrHbUlpiiHJlFstC6VkgiwhjvKwpAIKqUCQ2jmxQfn8OP8aAHnRR9GU6k79D8SV2lXYZlIXOe6PIjtPd5SdHrf2/+SAWebG1RjHeiCQNFLNpInImRS2ewUnyShBMmVuVE4GJbt9miE+W+iZurJm7lSnILeSWEUhKf1Yp62ErWJIbULKT1UsQT0UlWDbAihWM6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VebGogzcRpHflXMLxx7f/7UHNbUmpn2CR3jsTWHKkJ8=;
 b=Hz2trINlyWhXEROFEmMDnr52iPe91K3WFPXxHjQP2yAL0y3cNmeW2poV+qXKRoA1nrAOw/jJ8D7twf/rEMOwR2v3P3ygnUZMgzBO48y3bu+fIgt6fDy3qS4Hs7iURQDmRzgHN2hvZiWiEjhbk0NKoKI0p76s5tJ4WloktBtaRM/I3f8NKlpad0BBalN0J2vNsBT76i0UG/jo9vdHz26nWx0+GrFaG+Je9XIAYhoPa9etWFe7u9Pa7WB8G6lwlSFAB6SaThBP0dq69WC3SsSn2LE3Vfpf+f8C1UjyVfeyKAR28nOUuoWPc5RplJBviQGLDQLkE1bm1JWmOG5rpLilnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OSZPR01MB6453.jpnprd01.prod.outlook.com (2603:1096:604:ed::14)
 by TYYPR01MB8149.jpnprd01.prod.outlook.com (2603:1096:400:113::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.29; Mon, 1 Jul
 2024 00:27:46 +0000
Received: from OSZPR01MB6453.jpnprd01.prod.outlook.com
 ([fe80::9ef5:e83:9047:de11]) by OSZPR01MB6453.jpnprd01.prod.outlook.com
 ([fe80::9ef5:e83:9047:de11%6]) with mapi id 15.20.7719.029; Mon, 1 Jul 2024
 00:27:46 +0000
To: Zheyu Ma <zheyuma97@gmail.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: RE: [PATCH] hw/usb: Fix memory leak in musb_reset()
Thread-Topic: [PATCH] hw/usb: Fix memory leak in musb_reset()
Thread-Index: AQHayws9KaHdND97+0WEHxpszfxoj7HhBI8w
Date: Mon, 1 Jul 2024 00:27:46 +0000
Message-ID: <OSZPR01MB6453E71AEA534CFE85CCBF238DD32@OSZPR01MB6453.jpnprd01.prod.outlook.com>
References: <20240630163225.2973081-1-zheyuma97@gmail.com>
In-Reply-To: <20240630163225.2973081-1-zheyuma97@gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_ActionId=c04c5d34-2272-470c-8fba-3fbb63e31585;
 MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_ContentBits=0;
 MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Enabled=true;
 MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Method=Privileged;
 MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Name=FUJITSU-PUBLIC?;
 MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_SetDate=2024-07-01T00:26:39Z;
 MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_SiteId=a19f121d-81e1-4858-a9d8-736e267fd4c7;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSZPR01MB6453:EE_|TYYPR01MB8149:EE_
x-ms-office365-filtering-correlation-id: 2aadaf13-3a6a-424a-76bf-08dc9964a1b5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|1580799027|38070700018; 
x-microsoft-antispam-message-info: =?iso-2022-jp?B?Y2N4VklaWWZmSG9GcEg1Z3h4Qmx6a3BoRU1jMU1GL2xhQ0VjOWlTRmM3?=
 =?iso-2022-jp?B?RFAwY0l6b0ZENjBuUEpacHp3cFVzNW8zaFhuTmVWbnQ1dUIvZmlwcUUz?=
 =?iso-2022-jp?B?TUJ3TkZRaGJZMXc2cEp3WnlFT21CRG4zNVJqY2pGb3ptdlAzRC9JcjMw?=
 =?iso-2022-jp?B?YnZwN1M4ZXRNQnBFRVlHc1RQM1lncnFSOEJZdWxjSllEUFVaY3UzWENi?=
 =?iso-2022-jp?B?WlliVzh0WHpob3ZvWVpndzJKSUNIWnBWRERabzdkYVp5ak1pbzdsV1Vs?=
 =?iso-2022-jp?B?YnZzR05YMnlpSVhQQXpTM05nUkYxY1Myc0E5WU8vcFpUMVNQdURRWGFP?=
 =?iso-2022-jp?B?cUhFUU5TZWdod0FrRDFaTWYvRER6NjFETWlIa0haSndQK2FBU3dtYXp4?=
 =?iso-2022-jp?B?anFsNElJT1BPVnhSYzlSbDBCOVZyY01YVS9sckx6MHVVSnBZOWE3dEl6?=
 =?iso-2022-jp?B?dm1nblVXdFJYV0ZkamkvbnlDblQ1WlA3NmtzK2ZBOWtsVHpDb1dMaWpL?=
 =?iso-2022-jp?B?azd1eHF6a2JoV3VLRGk1ZUFJWlpkUU43ZEJNaU9KNkFLU1JLTEJPV1Vu?=
 =?iso-2022-jp?B?M3crYVJCcWFHR3pUWU1RWFphSzRLUjRmNjhxeWU2RzJEbXlWQjkyZjh5?=
 =?iso-2022-jp?B?b05uS2E3WVR1VnJqQVdHamJvd0dpbkI4cWpLd2MwL2NWektNcVNwLzdz?=
 =?iso-2022-jp?B?d29yRlp2akRlV1JnbEJkT2x0QjVlN2hlY2JzT1NiUk1qUTZiTGpDWHg1?=
 =?iso-2022-jp?B?a2diZStoS2wzRWl6WmlwYzJCa2xUYmJVeTlnL1J2ZmRlK2trM29CQ3gw?=
 =?iso-2022-jp?B?MXVLZTdrSXB4czdISlFxY29sMk5SdDArZjZlQmV2MTVTdWQ4UDVrTDdN?=
 =?iso-2022-jp?B?cFRFV2ptK01kemhpQUxmY1BjTHlXbWEzcndjYkVMZjZ1eXNBL1hydm9W?=
 =?iso-2022-jp?B?QTE2M0FrR1B2MXU5MlpGQkNmbUtBSjNrSHA4Yk9PbHkvb0NHVnZGTitv?=
 =?iso-2022-jp?B?VGFDMWdYamxjVzdVNkNlbFNqbWZBWlVUTzdqTWttbEJlRlc2NC9xRFBG?=
 =?iso-2022-jp?B?WVhZRE9udGJxY0YzZE5rRUxvQ0VHeTRlKy9scHFMM1pkL3pMeGZvdnho?=
 =?iso-2022-jp?B?UkJDSjdsQ0tjMHNmM1VZQ3drWWp4czE1TU42dFZzYjdHYVYvSFJqbUx6?=
 =?iso-2022-jp?B?T28wT2xLYnI2NUR3eEVEY0RGQ3JxQmhKaU1US2FvNUxTY3l3Um5tUEsz?=
 =?iso-2022-jp?B?aEEwd0hBOUVyN0lNOE40WFcySGFIcHJ4UFlueDRiVlZNSkE1d2c5RStx?=
 =?iso-2022-jp?B?Sm80dVBLTGl6RXJVQ2J5TCtPZVpjVEhQemlzcEhPeFpzYys1ZnMwMkgy?=
 =?iso-2022-jp?B?ZGpRMEx5bWF5ZmUvWUlKUDQ1djdXbEIxWUR6TE1YTWdLZGtFSDNONWc1?=
 =?iso-2022-jp?B?b3lucXIrSENxY1BhWDI4bWVDSDNxYkFJdzB4aUwxOWVvbE9VeDFuZXZW?=
 =?iso-2022-jp?B?azdIWHBiTkJWUnRSYXRUTlpoRDRvd0cxOFd6cUsrbENHcnozRExLeTda?=
 =?iso-2022-jp?B?Y0xzb2VQVVRka1JiUHJWTFBHcGtiai9Ndjk1dGl2NW5JOS9yOFhiUTFL?=
 =?iso-2022-jp?B?ZVhkd2FBVTBpcFJBQkthWUxIb0NYWWRWdlJjTnpxeDBjdnNKZnRjQXdz?=
 =?iso-2022-jp?B?aEtnSFU0ZjJyVjkxcGxlbGZCQmRyb2t2elRKTVR5cElraVBlWjBuc2JM?=
 =?iso-2022-jp?B?YkE2ckJEZklnSk1CR29yRGlHQThjYUFrVGpnZGhRMW9DMFlIcENYeUY3?=
 =?iso-2022-jp?B?ZDhnZ1N1NHJEam9vejBJN01KS2I5ZlFTNnZXSUdKYkhjYjFkS0RCSFVJ?=
 =?iso-2022-jp?B?ZERRendLVWNnYmdmeDRacFZrRjdwOE1JMXN4SklSQzVPa0dMdHpRU3Bp?=
 =?iso-2022-jp?B?ZW5HTVJaODVhd0wycm83d3JJcjRodHRNcTRuN2c4c0xHdDREaFF5T2Jz?=
 =?iso-2022-jp?B?RUI4aytOMDJQeS9oOWRMUW1iaWNJS1FVb2p4TEIzaEpmZ0lkRDFnUHFI?=
 =?iso-2022-jp?B?VGZrZDhoK3JpL1FtajkvK0t0SGNZbm89?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-cn; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:OSZPR01MB6453.jpnprd01.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(376014)(1800799024)(366016)(1580799027)(38070700018);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?R3ZCbzhSb3poNEU5aytaR1VZTlVtUkZSRDdxTTRyTmlrUktPakdtTlRB?=
 =?iso-2022-jp?B?SEVwNW50WVNzZGhuenBtd2s2NHBYN2hjSkNjdDZKN0t4NFhuWVpxaWJK?=
 =?iso-2022-jp?B?SHpUQ3ZTVWVkS091MzNLSFVFcWJyMDhjM1lSeTNQUnVBbENGelE3c2N4?=
 =?iso-2022-jp?B?VDcwTmJjTUdGZGxUekhaR0RRMU9WTG9TdldkZjVJK0NYR0dFNHY5YjF3?=
 =?iso-2022-jp?B?TWJCTENhOHB2ZnRuN3loWUtxOGpqamhXZ0dlQkZhM3lwS1BqNEtKRHZB?=
 =?iso-2022-jp?B?RlM3VXZQd3lPeE5ibUlsSGwwVlVvNmRIL3ZjNXlZdkw4TWYrTTJmeS84?=
 =?iso-2022-jp?B?M1hOZ3BPVzFraVBvR0tTSHRFVUpVajExSUtPbXhwMnM1NmswdE04M1dk?=
 =?iso-2022-jp?B?NFBrWDNtYmtpcU9vcis2U3pTOEFHeXJEUGp5WStxSWpMSWk5bVhJWXY0?=
 =?iso-2022-jp?B?OWdLWmJKQnpqOHVQY0M3QmlQZGJCOTFwRzNjMFQ3Ymd5ZVQveDdNOFJM?=
 =?iso-2022-jp?B?cWhwV3lqSGxBdjFFVGFpa0hhcm5Od2F6WjBhVEFaa21QUTNycW5CSUZ5?=
 =?iso-2022-jp?B?MUllbXNaamhyTUVZdDhGdVB3TnRoaTFXWjRxQ0lob3AyOEprZUlEOVBq?=
 =?iso-2022-jp?B?cG5rbm1JRVN5bHFSeE5CS1VLcm0vUW1PNlhIdDlWRWM3YW1OS0FnbWVm?=
 =?iso-2022-jp?B?T2wyU0tIZ3hmYTVpQ2c1OFBSYjg5alZwM2ZrVFBzWHBRSzRuSloyRHl2?=
 =?iso-2022-jp?B?OXZJTnhiR3J3Nk1Nd0xEU21UZ0RRTHk3aitWU1BpR3lvZTRPQ2ZrbFU4?=
 =?iso-2022-jp?B?Z2MzWFAwN0Vqc2JEYTNXV3haNGlDSkZKSmR6V1NMeXEvM242ZGh1cG00?=
 =?iso-2022-jp?B?bnlQWVd2NDgvaWVsaVdrN2lESzBmYWhqMUxndnNhSHAyeGpYandiWWcx?=
 =?iso-2022-jp?B?M0plQTNhY2ZmUHMvK3d1a3owbGFBd3J2NkszVXIzdU0xeVAxRVBtUTdU?=
 =?iso-2022-jp?B?UThONDQ5azRrZjNmMnZMdEVsVWVPYTBTWW92R0kwaHJwVjNjUExzUVpQ?=
 =?iso-2022-jp?B?ZmUvZVk4a04zU1BWVHI1dVplK2pQOWFLZ3U3RDloVUlVZThQVU9CWTBt?=
 =?iso-2022-jp?B?U2lKU2ltQmQ4eU5ITjlBWUJpUG9xeGRQaTNvdHRtZnhsall1a0tQOWly?=
 =?iso-2022-jp?B?Ly9oeTFTWThLM0NXWmppNUFKbHBhNWNCNUQzVmpERVptcVkwU3RUOEFF?=
 =?iso-2022-jp?B?cGk5czJRYi9udmdqSjl4Z3Q1L0VkRVZMY0lPMWJ6S0dHajFaUG95RGpa?=
 =?iso-2022-jp?B?UWN5QmxzNndDZmxrbE5ZZ3RpN1JNM1d0R3pwanE1aU1QY3dac052OUNN?=
 =?iso-2022-jp?B?eXVMQzZ1bEp5WGF4K0hYODdQTTIwNzYwSm1YOGUxSUIvS2U1N2lheGVS?=
 =?iso-2022-jp?B?V1N0WEdQMGtwYXdYbE9nd2dsYi9mRHNJTGNoWm8wUXUzcVVIcjNzL0RD?=
 =?iso-2022-jp?B?cFpBR0hyRVdwZUVaYk04ZlBCdldzaUJUbml5ZEtadFROWm5aRjFLaGM4?=
 =?iso-2022-jp?B?R1dZUklYeFhYSHVTTk43QWo1c1VBU2c5ZDNObkxuS2VsYWtZUnZKM0ZK?=
 =?iso-2022-jp?B?WEN0VEpBdEZkREM2clZ2OFhGNWZjRWdVL1VBRU5nNHAzZEgyT2c2VmNU?=
 =?iso-2022-jp?B?QVRpREowMEQ3WnRLRnlmaDJQTFcyRGIzcThrSmpRUlRZbmdqWWl4T0JH?=
 =?iso-2022-jp?B?R0pueTRCUWF0MlRiRXZGTmo1RGRJbTdSY0RGZnlZNVVUZnJpQjcrcjBQ?=
 =?iso-2022-jp?B?REhSRW8xUkIwUnU2NHFSTjA4ejk3cVJ6QzA0YjZ2bjRGaTRTdytJam5o?=
 =?iso-2022-jp?B?eEVlVjFOVW5WQjBSVk5JWVlsdnIvWnBnSVh6L2VRVEswL1Y0cmdka2tK?=
 =?iso-2022-jp?B?UlJ6RkQ2dkVwUlUyV3QrcE83RUg1RXRMdXN2YkZwWHp3K2lBS3Z0WUJw?=
 =?iso-2022-jp?B?SGx5UHRCSzZGbCtzMzQ0Qm82S3JyYk1wU1hsV3BBZlE4MkJhTnN4NnZl?=
 =?iso-2022-jp?B?NHBuOXhsaVNocjdBWHo2a2tGTDJTeUU3ak4wTEh0YnZ3VWo1OFBNNk5n?=
 =?iso-2022-jp?B?TXkzTWRKT3hyaU50R3ZEYXoxck1FZTBvenc3YmxENlRMRS9DeWpVYlFw?=
 =?iso-2022-jp?B?cFYrWlBDRjdDNDdBQ1dCNk1VYm9RMGV0dk5YQS95WkZmSXpjTUJNT0Fu?=
 =?iso-2022-jp?B?SFo0Y2gyWlE2a2h3SG4wTHlMKytvYU03Znh3SjBMVDhxdE9qeGg4Vmhn?=
 =?iso-2022-jp?B?cHgzaQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 1ZHc+ly8HCymIZ2ZlHGG12yHTOijYqsvtviKZH+mMFqOxz3sOkB4MISBZvMqk7DOB763w1FbLQ9njbskZ6MDXkNckQkNxqL8IOjZaRPHhCjtpGaEIRG5aCj7abW2W+80qDUvd+jdeZEsXUMo/XpRqGw1kOeCNfT4BBc2+OoackiDbTXXRj5Lt/PwH2Zk35zYiDedJeX9fms698D29Fd7JlQkORd3nbcDxGQi9ehJIrBvyosx/H4EXgYtY9fE+tNdRn+40EX7IwXE76b2ftwTAV2kF19VaQESCjVTpvU8jU4NYhtl6p0fyrUC+AC+4SWYpJkmABCwFmE3iZffw5+eFpVDD0b4rAb6RcHm0Hl3FSS6LcSS8X5xHJRfoed8yyuky3fvD1EHg2G7famByxSFVLYUumEXuOQwBWY0EqY2xkMqLKQH4NPyxvya0/3sj+KlGKQaL1592PzRP1Z6vk7HHzgE6Q45PhExur9vcZIIjNt6EKyayN9WVEpcWXVWJSRsddOoczv4hsfoxi1kuAcxptxjhqT3lBX+UsdCSuDIPWU+G+s1UNjkhLE6kOkXaxrYUZWICvtw/lgD5waUX4yGQR+dFctKzFuOiAPAq76vSC+xl7QAdoTqb58FuZ3pgTnW
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB6453.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2aadaf13-3a6a-424a-76bf-08dc9964a1b5
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jul 2024 00:27:46.8323 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FVHMqLBc2b09LXjvo41MbTeoPV83cAN2Nusu/SDbi3wey1buv6s+5/1pRERg0pl3BWvFcBH8jaxzETXKoTuUQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB8149
Received-SPF: pass client-ip=68.232.152.245;
 envelope-from=yaoxt.fnst@fujitsu.com; helo=esa1.fujitsucc.c3s2.iphmx.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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



> -----Original Message-----
> From: qemu-devel-bounces+yaoxt.fnst=3Dfujitsu.com@nongnu.org
> <qemu-devel-bounces+yaoxt.fnst=3Dfujitsu.com@nongnu.org> On Behalf Of Zhe=
yu
> Ma
> Sent: Monday, July 1, 2024 12:32 AM
> Cc: Zheyu Ma <zheyuma97@gmail.com>; qemu-devel@nongnu.org
> Subject: [PATCH] hw/usb: Fix memory leak in musb_reset()
>=20
> The musb_reset function was causing a memory leak by not properly freeing
> the memory associated with USBPacket instances before reinitializing them=
.
> This commit addresses the memory leak by adding calls to usb_packet_clean=
up
> for each USBPacket instance before reinitializing them with usb_packet_in=
it.
>=20
> Asan log:
>=20
> =3D2970623=3D=3DERROR: LeakSanitizer: detected memory leaks
> Direct leak of 256 byte(s) in 16 object(s) allocated from:
>     #0 0x561e20629c3d in malloc
> llvm/compiler-rt/lib/asan/asan_malloc_linux.cpp:129:3
>     #1 0x7fee91885738 in g_malloc
> (/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x5e738)
>     #2 0x561e21b4d0e1 in usb_packet_init hw/usb/core.c:531:5
>     #3 0x561e21c5016b in musb_reset hw/usb/hcd-musb.c:372:9
>     #4 0x561e21c502a9 in musb_init hw/usb/hcd-musb.c:385:5
>     #5 0x561e21c893ef in tusb6010_realize hw/usb/tusb6010.c:827:15
>     #6 0x561e23443355 in device_set_realized hw/core/qdev.c:510:13
>     #7 0x561e2346ac1b in property_set_bool qom/object.c:2354:5
>     #8 0x561e23463895 in object_property_set qom/object.c:1463:5
>     #9 0x561e23477909 in object_property_set_qobject qom/qom-qobject.c:28=
:10
>     #10 0x561e234645ed in object_property_set_bool qom/object.c:1533:15
>     #11 0x561e2343c830 in qdev_realize hw/core/qdev.c:291:12
>     #12 0x561e2343c874 in qdev_realize_and_unref hw/core/qdev.c:298:11
>     #13 0x561e20ad5091 in sysbus_realize_and_unref hw/core/sysbus.c:261:1=
2
>     #14 0x561e22553283 in n8x0_usb_setup hw/arm/nseries.c:800:5
>     #15 0x561e2254e99b in n8x0_init hw/arm/nseries.c:1356:5
>     #16 0x561e22561170 in n810_init hw/arm/nseries.c:1418:5
>=20
> Signed-off-by: Zheyu Ma <zheyuma97@gmail.com>
> ---
>  hw/usb/hcd-musb.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/hw/usb/hcd-musb.c b/hw/usb/hcd-musb.c
> index 6dca373cb1..0300aeaec6 100644
> --- a/hw/usb/hcd-musb.c
> +++ b/hw/usb/hcd-musb.c
> @@ -368,6 +368,8 @@ void musb_reset(MUSBState *s)
>          s->ep[i].maxp[1] =3D 0x40;
>          s->ep[i].musb =3D s;
>          s->ep[i].epnum =3D i;
> +        usb_packet_cleanup(&s->ep[i].packey[0].p);
> +        usb_packet_cleanup(&s->ep[i].packey[1].p);
>          usb_packet_init(&s->ep[i].packey[0].p);
>          usb_packet_init(&s->ep[i].packey[1].p);
>      }
> --
> 2.34.1
>=20
Reviewed-by: Xingtao Yao <yaoxt.fnst@fujitsu.com>

