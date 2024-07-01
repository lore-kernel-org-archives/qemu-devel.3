Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2497BC3065A
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2024 03:14:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sO7Tu-00015B-No; Sun, 30 Jun 2024 23:13:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yaoxt.fnst@fujitsu.com>)
 id 1sO7Ts-000152-Ut
 for qemu-devel@nongnu.org; Sun, 30 Jun 2024 23:13:28 -0400
Received: from esa14.fujitsucc.c3s2.iphmx.com ([68.232.156.101])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yaoxt.fnst@fujitsu.com>)
 id 1sO7Tq-0002CB-Mk
 for qemu-devel@nongnu.org; Sun, 30 Jun 2024 23:13:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1719803607; x=1751339607;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=nzFTi4WpFyzFJWNa8dAMRDa9ioxtje0GgFSEy/iTKIk=;
 b=DqjY8TNJB45Geimq83Xtj1JoW89A6E+MVJUxIkCyo3RniL1Ral6gwkIv
 LJfk0S3D8flDBmWG2/Y0ZYL6cy2NqjmZeAK3W3Rzld2Hxrvsdlym52HMP
 o5Zmtr9cOKmcKW4A5yNRR0N7x35Tko/usJDdi3JSXRmm4MU2mGgZnhuIO
 7MHfD5+UlXdB25lHnFxABLRzDrTjfFfVGngc7iSrXtI8pDgvsTSAu12FE
 nsQCYjbTu65XMl1x51yv1EkLtLhjlh6eYJ7p0MafJGxgtdTJuVt86x/D1
 hxwk/8M1RQx+JeI6kZ6Y0etBojVzX8mNgsS82Sfm7qmHOjJ1s+Lz2ccYF g==;
X-IronPort-AV: E=McAfee;i="6700,10204,11119"; a="123408746"
X-IronPort-AV: E=Sophos;i="6.09,175,1716217200"; d="scan'208";a="123408746"
Received: from mail-japaneastazlp17010000.outbound.protection.outlook.com
 (HELO TY3P286CU002.outbound.protection.outlook.com) ([40.93.73.0])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Jul 2024 12:13:22 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J6mkta2U9duzJz5OQEfGaSW/Tc+AUIFzkLtBRNwFCNS+26TwuFMNGCyJGPWrT4InDvfd7aaEjzPnvR3MPxahM4VpkCn5jgBzxZGur7vjaJTduZ7/mluEFxPvO7QUwnOT7BccNA0lKUKrKTJvs0VhSPzkxpEcJsaAsxVz00rErSK1O8MuW/QFINNxH4Mz1NG5ihK59OaDtJknSVWsZ5VztcjYs+69yq7YvYO4L6u0U9QGnt1moM8Q3nebFtTS9DHNEYKR4Gj0+doIGlqRxELZKrFHjGvQ2ryPcR/olBCO04wXKnhv1OMeX1HVhITybP8ookSLGYxx+Hak3vsEwHKOFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wiY+7mAgckNONxL3l8ee43aEGiSsoGbni61wh7l2z4c=;
 b=Hi/BCpMETpYXLW1NdP4beggdIsW6H+SXLGdieDyEw1o+sJLg7VvAZhPoBur1aEAXDjcZAqS9+y01Gb9cxTPgY8hL+qUlqbstdnZB9PR/iOxVBMOgtAm8hKr+sAWeLKOGmgU9/wkEX+tIVMxx9Lk//hY5bNkb5mnFJ/dGXgNuGD/v0oyDm1HrU3oqWAYDHBm4plIveoZ/JlIxHQ699CUcjEmq69x/FlvchA8vS7x3C7PU/3vHsYj6tpMQv0WvNjiaXJ+MPW6INiiuTH9ULep/9ryGq5e3MmzRWzhmjz6TDtsKzHVXMw6D8k+KzEnLZ8XG5HDGN2DvT/jqtjX6smHDNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OSZPR01MB6453.jpnprd01.prod.outlook.com (2603:1096:604:ed::14)
 by OS3PR01MB6789.jpnprd01.prod.outlook.com (2603:1096:604:122::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.32; Mon, 1 Jul
 2024 03:13:18 +0000
Received: from OSZPR01MB6453.jpnprd01.prod.outlook.com
 ([fe80::9ef5:e83:9047:de11]) by OSZPR01MB6453.jpnprd01.prod.outlook.com
 ([fe80::9ef5:e83:9047:de11%6]) with mapi id 15.20.7719.029; Mon, 1 Jul 2024
 03:13:18 +0000
To: Zheyu Ma <zheyuma97@gmail.com>, Mark Cave-Ayland
 <mark.cave-ayland@ilande.co.uk>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: RE: [PATCH] hw/display/tcx: Fix out-of-bounds access in
 tcx_blit_writel
Thread-Topic: [PATCH] hw/display/tcx: Fix out-of-bounds access in
 tcx_blit_writel
Thread-Index: AQHayu5KH6Kad0am+kO34Xef1FHcP7HhK42Q
Date: Mon, 1 Jul 2024 03:13:18 +0000
Message-ID: <OSZPR01MB6453E079CFEB83C0577D37228DD32@OSZPR01MB6453.jpnprd01.prod.outlook.com>
References: <20240630130426.2966539-1-zheyuma97@gmail.com>
In-Reply-To: <20240630130426.2966539-1-zheyuma97@gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_ActionId=f2dfa0ac-17e5-431b-a51e-f01317b10018;
 MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_ContentBits=0;
 MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Enabled=true;
 MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Method=Privileged;
 MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Name=FUJITSU-PUBLIC?;
 MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_SetDate=2024-07-01T02:45:24Z;
 MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_SiteId=a19f121d-81e1-4858-a9d8-736e267fd4c7;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSZPR01MB6453:EE_|OS3PR01MB6789:EE_
x-ms-office365-filtering-correlation-id: 335e4b0c-1b07-4ca6-7eb4-08dc997bc12d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|1580799027|38070700018; 
x-microsoft-antispam-message-info: =?iso-2022-jp?B?UkRicGVod3B4V0JKTEhZcGo5bmNGNyt1U05DOHkyTEo1OVNzSDVBdXVs?=
 =?iso-2022-jp?B?TmhHdnRNcGJKVkdqWEJIVUZTWnB0cHV0bDFzN3lKRFJDRlV2UWdvNU1k?=
 =?iso-2022-jp?B?ZzNXcUF2Y1A1SUw4cjFDTi9yYmhZSEFwcjJibkUwSitMeEZ3U2FxMU9L?=
 =?iso-2022-jp?B?VUVGNkxmUDRPQkJhcXczN1ltbGtGRkYyS2EyVXBlajZyeVJXUHB4dTZj?=
 =?iso-2022-jp?B?dnVROUxrUXpXaHQwZ2pBSFdJU3N4cU1NTXNkNlVxMzdSTzZBazNsYTZU?=
 =?iso-2022-jp?B?d1RyL3o5eGlwaUkwS1JTNExRbTNodjVQQWRHZ2QrTTZ0RWREUm5uaXR3?=
 =?iso-2022-jp?B?b05LRXdVQXpHUDNHazV2amtzZ013U3h4TmdFMC9uTWZqeTc0eWZiMzI3?=
 =?iso-2022-jp?B?MG1UeU5rSFFNT3NycHRudjRMZkhlTloyUmlZNWpENldySHNXa1NMRlJn?=
 =?iso-2022-jp?B?bCt5SUoydWsxeklnM3pabktGL1RXc3oyWDRQOHU2YU4vR0VZcFl2THJn?=
 =?iso-2022-jp?B?cytxWGQ2OXM2WlhxWGZEZHpUNlFMb3hML3hHZ0crQ0dqNy8zcWk3c2FU?=
 =?iso-2022-jp?B?ZGFpV1VGZmJKdmp6SURNdmxEVk4va0lPb082N2plc1FNUW9CQjhBOWJt?=
 =?iso-2022-jp?B?WGdKSDRNa1BpN21BWmFITkZiUGpLdjdoNVAvMDNXM2QySkl0bW03TW54?=
 =?iso-2022-jp?B?K0E5anBtdHp5ZkdOR1g1K2lqaHg5M05wWjhwMy9LUEE2ZDU2SDY5cXV0?=
 =?iso-2022-jp?B?SWhJUjA1bHBPZVVwTlh0SW8vMEJSdmhMMFFudkhFeG1VUHpyYXFGWmFp?=
 =?iso-2022-jp?B?cXpoOGtvejljeVZpajRKeGVlUzBtZ2tubTQzTUJnWDJtTW14b3F4VlBi?=
 =?iso-2022-jp?B?OFRpeDh2YVljeTJGVnlWdm9FWXY4dUpsaW96dVdWaTJFR2VVK01hK2I3?=
 =?iso-2022-jp?B?c2FMakN5NkNIMFh2U2Y2SDJSZ1d5Q0U3RDFES0xwaFVKN1czUUcxaGVr?=
 =?iso-2022-jp?B?ZWRSQVc4S3hYRk91VEF5MEZFc2tQTUdiSGMrbGxiRkoyYlYyU1JVV3Z1?=
 =?iso-2022-jp?B?N1A2S2YrVTkrREl3SHNmZUJBMTZRcFRJWWwySUlRVmtOUk83Z0RKbXVu?=
 =?iso-2022-jp?B?b1VpY3BjQzRrandZeThKTmVNdkYvK3dLVnp0QlNUUDE3Z0p2Q2tPYS9P?=
 =?iso-2022-jp?B?cllaSUdvSURreHRWRXdqWW9aWUtWbGMvdEtsWWYvbVowdG9GWnRYTXB0?=
 =?iso-2022-jp?B?MmJod2FOUXdHcXVsTzRqdXEydWpxR29GT2pwREhrNFhtcHJlZktaNVhl?=
 =?iso-2022-jp?B?MkJQTm12YXJvaVpFK1hVRjhUb0dGYXJoU05oSHMreVl0VkNUUkMvQ0tC?=
 =?iso-2022-jp?B?TGJXWStxM1ZwaE5DeWxuR2h3L0dsalg3OGFVZ0hkRGZ1c1FuZVpFOUVD?=
 =?iso-2022-jp?B?SEhDaE51b3hCYUIydFMvdVUxckRLbk8vdnJaWmgzS0U0eTlVUG9aeDY4?=
 =?iso-2022-jp?B?L09PUmk1MklEenRUZldGNzZ6S29Fb0ZKM1A5MksrbzN1M1kzenlDeTJG?=
 =?iso-2022-jp?B?NmtXMk5RUzJXdmRRV1ZhQVpaWkhoQ0U1MkozYTMvQnFnZmFqcHRyb2Uw?=
 =?iso-2022-jp?B?OTdDREF4QkY5b0t4b1gyWFZBUG01cmpPUEx6NSsweXBDK3BOS0RsWStX?=
 =?iso-2022-jp?B?L1JaZWVxS2JhYm8zdkVmdTk5TUxDY0xRZnFud0EvSU0vc3ExWEdQTWJZ?=
 =?iso-2022-jp?B?c2FwQWcyUDUwNzRFOTE0OUFiSHlRbG1rRktycGVnSGRDenBnSlczOExN?=
 =?iso-2022-jp?B?VFZyanhKaTBMeXB6OVZiKythVUlhU2JGd1NMM3hTTW0wTmlHSTJ4OGl4?=
 =?iso-2022-jp?B?cUdLRUZPQzN0TSsvV0QwWDR3clBNQ2xaM3M2Y3RCQXZPOTNtMXhOeHI5?=
 =?iso-2022-jp?B?QnlkVm12RkNNWDl1d1hBN0loMWVVZDlVWVY2T1pud0VlMFF6QUtzSzkz?=
 =?iso-2022-jp?B?bU02YlloaGd6aE1nN2FSdjNIV21XdzZpM0kwSVhvZlltdE9CSDdEeWtR?=
 =?iso-2022-jp?B?eVZlVVNuYjB5NFdyaEZ6Q2lIYkR2NEE9?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-cn; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:OSZPR01MB6453.jpnprd01.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(1800799024)(376014)(366016)(1580799027)(38070700018);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?RHV0WUZpemFyVlhaakxyYzNqRUlVWWZQVVArTUJFNFVDbnc4cTA5emZK?=
 =?iso-2022-jp?B?VUhYLzJ5ajhOdm1Cd1hvUit0SWo0cDJNNExFcDM4SDFhL21RY09MYzZa?=
 =?iso-2022-jp?B?bW5PaURmOWQ4dmphK2czbnIxNVZTL0NRZ3hVbHptOTlZdnhhNUZDQUl3?=
 =?iso-2022-jp?B?UStnY2hDS21jMVU2YmxYZlZvbys0dU16NFF4SFpGRUtPZzZWTWhYODQ5?=
 =?iso-2022-jp?B?c0xjWHVCak5HRmcvTjY2YWR2eVVzOEVEeGpJSEttdnNiczlDa1RqVkxH?=
 =?iso-2022-jp?B?U29hRmx4aVpIVmd1L2UrcGxCNG9qTVlJYWE5aFlVaVJLQVpkS2ZDL2di?=
 =?iso-2022-jp?B?Rk9mZzVMMnV5eStxUFZTZEt6WEI4RFBPaUNHUytvTzRwT3I1UVJhemZZ?=
 =?iso-2022-jp?B?K1NHV0JHWDdxVkZiajhxb1RNcU5ZMjNoNS96eXk0aFovcTljQjJqSHlx?=
 =?iso-2022-jp?B?TytzVjZDWFVXVk1aOTA4YkY0Y1pkOXh1SU9yUTJydnRyNFMrWDVCRjFr?=
 =?iso-2022-jp?B?M3NaeDBFaWNPcDNSUG5NMGh0TTQrNDlOTDZZbHZFRXZISlJkYmZFU1Jq?=
 =?iso-2022-jp?B?R1k1eUNMM0xOalRSK3loMkdodWZlTWtYYk9uMjkvdlFDa211UVNHUmhp?=
 =?iso-2022-jp?B?ZTFBUDZsa0xhaVVzVUZNWHlEeVVmWnB5QWJabjB4clBzMTQ3bkkwbVl5?=
 =?iso-2022-jp?B?aHR0TkxQWFNucXI2QTEyck5sd0NpWVF2bmVrRFZkY1dLVmhNRXZncFpO?=
 =?iso-2022-jp?B?Z1hkMVFLZTErbi9FNzRpdUFoblpKT3N0a2p2U3pmN2V0UmNrSERTNGhP?=
 =?iso-2022-jp?B?dEEzVkV0c3dVUEZtMEdpbWt6WTFLekMwRjZwMnlVNzJzOGZsanEzSHZp?=
 =?iso-2022-jp?B?VFFCT0hyMTg3a0cxb0tGRThxVGpzejVJekRTb1ZsdUd5Z0I3eGR6Vkw4?=
 =?iso-2022-jp?B?WjJibHhDeHEycytXbENsMnp4SmIyOTJlUVN0anp0SFFrVUl1Tmt5QTky?=
 =?iso-2022-jp?B?Rjc1Tk9yRmU3SFc3NlhkdVZqVjU0cDhreldscVlzeG9OTmdZNFdhK0Rv?=
 =?iso-2022-jp?B?SG5JYkRzUEhwcU96bGQyYS90SE1DRjFQd01YY2x0cy9CL3hxbndEb0hk?=
 =?iso-2022-jp?B?WXQ3L2Y0YXZIR1ZjbkNhOWtXQVVvbUdKUmkvR0pId2pvbDcyZ3FkYzhS?=
 =?iso-2022-jp?B?QmhnK21HSHBFYXpsSGFPNytRVTd2eTBmeEJRNVZVNlNvRWc5Nm1SWUx1?=
 =?iso-2022-jp?B?MUJ2ZkxGTFJGVTByRCtvc3ZTeWVPOGVMcHV3elBRWWJoTHNXQmRtNk9l?=
 =?iso-2022-jp?B?UDV3QzF5eURiU0JMWVo3S1RHR2dzMlYxL2swTTA3VWNIRzgyVGlZRmRQ?=
 =?iso-2022-jp?B?TnY5MGw3U29pK0ExTGZKOUFxRno0dUcya2EyVnJRL1dwTHVQbXQraWV6?=
 =?iso-2022-jp?B?WGtYcDJTZ29scktOSjZET0ZhOWxyNWFOaUVnSTFHNWtSV1NQQ3BOY2M2?=
 =?iso-2022-jp?B?VFZTNFBGSGt2T25QQmV0aS9TekJwSUxBVTJ5RWFyMys2Y0M2a1lvWGs5?=
 =?iso-2022-jp?B?OWNGcElsOHVpcHdIUTFDVm12dmFBWXJnMVkwUzJ4aWd1ZnREUXFldTZx?=
 =?iso-2022-jp?B?OGxZenROT0Z5d1BWRW1wT3VOYVlvUjE4cUFJWUFnSzNlT2FHVTVORHRU?=
 =?iso-2022-jp?B?d2YxQ2YvbU9pSlppeUhOMWpQS1ZVdmx1bjIvNWZNVUFZVExJRW5MY1hF?=
 =?iso-2022-jp?B?WmlLekNIWU1FNnZiWlYzVFZzZmdJSDhpQzQ1SjlkSjJkaFh3VGluYk5u?=
 =?iso-2022-jp?B?NE9XN0ppb2c0VE9xVVZBd3FJbVFZT1p4cC8ra2pUMzUydzlSYUZteWtG?=
 =?iso-2022-jp?B?d3RZMG5ZVUI5MkdZY2FobGR4ZVptbG4xd1ZxR29qUlNtRkhXNkV4T3p3?=
 =?iso-2022-jp?B?WVBaaW14Y014cHBBbDlhM2dxT3FzdEg2dXBHSm1BSmVNa2NTbiswK015?=
 =?iso-2022-jp?B?TEE2VmFBYnVEWm9sY2tIYzRGbEJlaFRCdmszeHEvTThCWnhPT0NzSmhv?=
 =?iso-2022-jp?B?NFBTa3hBRFNSYnEwWDFMVzdrbVhvL21NR3EvU1RNU0RmYmdlWnVSQTFR?=
 =?iso-2022-jp?B?OCtOa2NsL012cklLZE9ZQU11TFFHL0dLcTd6SURaVGNvTFJxSit0aHZw?=
 =?iso-2022-jp?B?RnRTOTk2VGRvTVFnOGhlN3JKWW50YlRrMVIxR1owQTQrVVpyZjVaMjN5?=
 =?iso-2022-jp?B?UlNtc1gxdWkwMkg3N0ovWVk2VFp0cTk5eEphTzN3cTNhTFVUNkVrdU9K?=
 =?iso-2022-jp?B?OWVOeA==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: IBgCY2x09atlX+iJqrDZag3moPd03A7lYYYtP96Vtvq8GbUwfYiwKVYSo/8YNq6DW8oL+QulVt3khgb6k59d4I/P+9OmvSWYLk8pGXAFxl/tHSAWgpX0a7CjvHUTyN5vwO70iTdSi1eskWmDG21mIRQA3ou/vxvAOAbpZ4dphgfmk9pRy3fXtlJq0XaA8/YKt27ZK1a5qdSq+2iqNBtcrZ7/kH0uUiWEhbx3Zo4uw9bldD4j7EIjroyrbF8n0GCrfvqiUI12sjXbLITzgz+hXQwUqxeHR3Em6xKU27KRatCbJ0cylqgNa9gsWRXn0+G/lzykcqjdwxxIR8P0EiyD35CS5c6HucSw5O6C3YgrpGXw916PUJhlcmUVxXRUsMjE3a6TDHwmjrMdIsHrEko5eGIkXc6N7UZw+D0mHnC5S3DkDfZ9uMOKOtty3Sftx3/mMAXZ6+NeUtxEk9l4eyS5OTRaD8oazuChoeKqqkg+WWa8vAG86EW4L8hcY2e5U2To01wH6jh2v1BnexA7Zp++hyl26If3j50OX8LlkRTJkgkwAsXtVNGaX9yOBVrzB6LfVH+IXBdpQhiu8G70foyHG4627E0DB2Wku07SYlwzfL9QZ9j5VZHR1ue1kAP5QyoA
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB6453.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 335e4b0c-1b07-4ca6-7eb4-08dc997bc12d
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jul 2024 03:13:18.0673 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rYq9TPLJRiBGWV3EhnpkbuwaVc6jNUpIofgdRF5/vHSiIsfxyOj2Wct6GVXchXUfQOA6dVP+Qqh1HTDZkUzlxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB6789
Received-SPF: pass client-ip=68.232.156.101;
 envelope-from=yaoxt.fnst@fujitsu.com; helo=esa14.fujitsucc.c3s2.iphmx.com
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

Hi, zheyu

> -----Original Message-----
> From: qemu-devel-bounces+yaoxt.fnst=3Dfujitsu.com@nongnu.org
> <qemu-devel-bounces+yaoxt.fnst=3Dfujitsu.com@nongnu.org> On Behalf Of Zhe=
yu
> Ma
> Sent: Sunday, June 30, 2024 9:04 PM
> To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> Cc: Zheyu Ma <zheyuma97@gmail.com>; qemu-devel@nongnu.org
> Subject: [PATCH] hw/display/tcx: Fix out-of-bounds access in tcx_blit_wri=
tel
>=20
> This patch addresses a potential out-of-bounds memory access issue in the
> tcx_blit_writel function. It adds bounds checking to ensure that memory
> accesses do not exceed the allocated VRAM size. If an out-of-bounds acces=
s
> is detected, an error is logged using qemu_log_mask.
>=20
> ASAN log:
> =3D=3D2960379=3D=3DERROR: AddressSanitizer: SEGV on unknown address
> 0x7f524752fd01 (pc 0x7f525c2c4881 bp 0x7ffdaf87bfd0 sp 0x7ffdaf87b788 T0)
> =3D=3D2960379=3D=3DThe signal is caused by a READ memory access.
>     #0 0x7f525c2c4881 in memcpy
> string/../sysdeps/x86_64/multiarch/memmove-vec-unaligned-erms.S:222
>     #1 0x55aa782bd5b1 in __asan_memcpy
> llvm/compiler-rt/lib/asan/asan_interceptors_memintrinsics.cpp:22:3
>     #2 0x55aa7854dedd in tcx_blit_writel hw/display/tcx.c:590:13
>=20
> Reproducer:
> cat << EOF | qemu-system-sparc -display none \
> -machine accel=3Dqtest, -m 512M -machine LX -m 256 -qtest stdio
> writel 0x562e98c4 0x3d92fd01
> EOF
>=20
> Signed-off-by: Zheyu Ma <zheyuma97@gmail.com>
> ---
>  hw/display/tcx.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>=20
> diff --git a/hw/display/tcx.c b/hw/display/tcx.c
> index 99507e7638..af43bea7f2 100644
> --- a/hw/display/tcx.c
> +++ b/hw/display/tcx.c
> @@ -33,6 +33,7 @@
>  #include "migration/vmstate.h"
>  #include "qemu/error-report.h"
>  #include "qemu/module.h"
> +#include "qemu/log.h"
>  #include "qom/object.h"
>=20
>  #define TCX_ROM_FILE "QEMU,tcx.bin"
> @@ -577,6 +578,14 @@ static void tcx_blit_writel(void *opaque, hwaddr add=
r,
>          addr =3D (addr >> 3) & 0xfffff;
>          adsr =3D val & 0xffffff;
>          len =3D ((val >> 24) & 0x1f) + 1;
> +
> +        if (addr + len > s->vram_size || adsr + len > s->vram_size) {
if adsr =3D=3D 0xffffff, this condition may be always true, thus the branch=
 =1B$B!H=1B(Bif (adsr =3D=3D 0xffffff) {=1B$B!I=1B(B will be never
reached.

> +            qemu_log_mask(LOG_GUEST_ERROR,
> +                          "%s: VRAM access out of bounds. addr: 0x%lx, a=
dsr:
> 0x%x, len: %u\n",
> +                          __func__, addr, adsr, len);
> +            return;
> +        }
> +
>          if (adsr =3D=3D 0xffffff) {
>              memset(&s->vram[addr], s->tmpblit, len);
>              if (s->depth =3D=3D 24) {
> --
> 2.34.1
>=20


