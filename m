Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48331C0218F
	for <qemu-devel@archiver.kernel.org>; Sun,  2 Feb 2025 22:23:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1teiN2-0001Ym-KH; Sun, 02 Feb 2025 17:23:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=121babd3c=wilfred.mallawa@wdc.com>)
 id 1teiN0-0001Xy-8F; Sun, 02 Feb 2025 17:23:14 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=121babd3c=wilfred.mallawa@wdc.com>)
 id 1teiMy-0006Sg-04; Sun, 02 Feb 2025 17:23:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1738534991; x=1770070991;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=zrhqiWUadxw7hgT26zGx/qC+n+QQtrflUlwbGZqwbzI=;
 b=ao+faZwxW9GLKKAHFrrm3fxP1f2qewMHHL12qZhvTCptyHeR2YI7d9iM
 0f3DlUd9u6RmczjevY7zx9s72pu8iijjG1+6Cge0h+T7eXS1q19a2qOc5
 m+M8R8qSkfh2kxIsVLYyF6XCUnWuf8FCbCFQDfw+2zBnE9Y4UOJ9MHw9s
 dTwtAcLx6J6mq/CFVl8vJogV+UJBPa3wQoE0A5JvnqB+wBHb6M/dsGCVq
 8dJM3/j1ekwZ2NK9wRV0yqfsg7Ag3LEqL+SaAKU972miLYuQ6tOs/N0D3
 EB3ady77IGSMS6/umZMQ3PNbFp3BqcZidqIq18b6bEfn9+Go4jHdg+yV1 w==;
X-CSE-ConnectionGUID: Cbq/K71xQKSfl5ADyw5Wpg==
X-CSE-MsgGUID: tRSSW9NrQCmWYbsZ3khnvA==
X-IronPort-AV: E=Sophos;i="6.13,254,1732550400"; d="scan'208";a="37947779"
Received: from mail-northcentralusazlp17010002.outbound.protection.outlook.com
 (HELO CH1PR05CU001.outbound.protection.outlook.com) ([40.93.20.2])
 by ob1.hgst.iphmx.com with ESMTP; 03 Feb 2025 06:23:03 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sCnwBiR/WYOg2gxY/cK83+C/tAt+tXvxGV2DJ7P54VR+A1CGbOi4CBXnRZ69BEGBmfHO1Deq7bdvscSVFulQp3O+5gGIFZBs+zfIanMQ2nqGEpdtsrjNGiJuHwR8PbwZV6Z+BOzcSszufypfhyd31oX+4sVdKfL3sp2Z0RDfb/mBi46J9Agw1uttcrigC4OIOZsmT/4nIN4Hc3uGdZm8HDKrgAsLE1OOkawrISmUAwyKJn7guS7g2oeUpVtZOgaZpM7NGR49TzgyLNVD/b25yGVQR9yyCQ8IefNrDMMkaub5hDhkk3HjUGBig2Dj/mJtsJ2zGsa9YXzu22WESxQofw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zrhqiWUadxw7hgT26zGx/qC+n+QQtrflUlwbGZqwbzI=;
 b=xkMyh+KO8FqOdrdiwlHnRrT9ME4dJc11euZ++T+OyxLV8TOBYvMch0W8TiplgYhwllIo3HDcHqaQwHt6Em4uX84rtcVNWgH0hveou73JixjFejhJBL5EdWN3rjAwEJFyossyom9MVVPkIdSoy8COhbchcn5XJ1gMV+qVan0jjwimq5aElvw7OvCid8PLU5TlokXYjQjQ3XshAqZrL9xHZxKod9AuGnc7n3CE33S8plntU7aulop6Wji0b8uxMwH6rO94+8WgowBfFZIH/2cpZpUhv8OKix/5v8aw2VIvW3evs/CRJcRBHXaS9Mv38Icipe7p4b8bZQFmg6/uVYCZ+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zrhqiWUadxw7hgT26zGx/qC+n+QQtrflUlwbGZqwbzI=;
 b=uMZjrkmtNtjl2HF0tcgjet3plRmIH73X0yI/ge0yDSCtR2P/edhty2azXcd9bqWif7LmkLpY0UCJlACYEZYjoafQYM5xAg/YYChOrN4ZD8Y7JDWCdm49v0nijFZH7r0KFWCZ67JZi8NJh2QjWoGAFfB86bft03Du/BejE/FKdL4=
Received: from PH0PR04MB8549.namprd04.prod.outlook.com (2603:10b6:510:294::20)
 by SA1PR04MB8920.namprd04.prod.outlook.com (2603:10b6:806:38e::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.25; Sun, 2 Feb
 2025 22:23:01 +0000
Received: from PH0PR04MB8549.namprd04.prod.outlook.com
 ([fe80::5b38:4ce0:937:6d5e]) by PH0PR04MB8549.namprd04.prod.outlook.com
 ([fe80::5b38:4ce0:937:6d5e%6]) with mapi id 15.20.8398.021; Sun, 2 Feb 2025
 22:23:01 +0000
From: Wilfred Mallawa <wilfred.mallawa@wdc.com>
To: "its@irrelevant.dk" <its@irrelevant.dk>
CC: "hreitz@redhat.com" <hreitz@redhat.com>, Alistair Francis
 <Alistair.Francis@wdc.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "stefanha@redhat.com" <stefanha@redhat.com>, "fam@euphon.net"
 <fam@euphon.net>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 "foss@defmacro.it" <foss@defmacro.it>, "philmd@linaro.org"
 <philmd@linaro.org>, "kwolf@redhat.com" <kwolf@redhat.com>, "mst@redhat.com"
 <mst@redhat.com>, "kbusch@kernel.org" <kbusch@kernel.org>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>
Subject: Re: [RFC 2/4] spdm: add spdm storage transport virtual header
Thread-Topic: [RFC 2/4] spdm: add spdm storage transport virtual header
Thread-Index: AQHbYNI7AkxXRPqkYE6RKcFFxr4P97MPu48AgAdp5oCAFM8kgIAIy8sA
Date: Sun, 2 Feb 2025 22:23:01 +0000
Message-ID: <64a5f22fb9d410135b7175326300f32722cb1373.camel@wdc.com>
References: <20250107052906.249973-2-wilfred.mallawa@wdc.com>
 <20250107052906.249973-5-wilfred.mallawa@wdc.com>
 <Z4DihskLy0wS9ts3@AALNPWKJENSEN.aal.scsc.local>
 <6b521ea30dfae69b447cb7c5d158ffcd0dbbf2d6.camel@wdc.com>
 <Z5iPUztJrvJs-9A7@AALNPWKJENSEN.aal.scsc.local>
In-Reply-To: <Z5iPUztJrvJs-9A7@AALNPWKJENSEN.aal.scsc.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB8549:EE_|SA1PR04MB8920:EE_
x-ms-office365-filtering-correlation-id: a4d8c83b-e778-4fad-38f8-08dd43d8279b
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|7416014|376014|366016|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?VmtvbXFYWEkweVNOYnFXZDAxSXpGUlhIbWczTzgrQllhVnFDV0NGSzRHTXk2?=
 =?utf-8?B?WGhWNFhZS0NZMkNxT2ZNSzdiMDhCSFhFNWhZOHRtMlUxZGh2VS9yMElUenEw?=
 =?utf-8?B?NFhjTVc4N21zQnY1N3RyK1Rnb2ZCUzhuOVRYWVRoeUcvUlcxaW11c3VpWjhS?=
 =?utf-8?B?Z3pXajVTM2pZd1l3V29IR2ZLOFVnd3FMRnl3OE1ZbWQ4UkRmdnRHNHd5Mlla?=
 =?utf-8?B?d3U3aVdhb3orMlQ1UEJsY2NLZFZucmFTNGQveFAzYzhCMG1RWCtzQnU1bTF5?=
 =?utf-8?B?OUFhdkFNYld0YmhxRjFCOVZZWHZyWWdwMzhKNVUzdUMwRXVncC9yRVkzUDN3?=
 =?utf-8?B?c2dVbGNFVk4zWjhJOGJMM0QrOGEwTFNjd1dkemNSeGRsY25WZng1THFuRGp3?=
 =?utf-8?B?UGllVS95U0FmTlorcnhZZFBvYUN6WjVDSHRPRHFYUnFRemdBa3hPOXBUSlY4?=
 =?utf-8?B?Zk1Yb2lqRjRhN1RzcWtFaGtLRkZUM1hvSER1M1RNZTRJVFhCaVlYdkFzbTNj?=
 =?utf-8?B?TmxpT3Z5YS9EV1p1RzhtcmdQMDBNcFk0MVhQVU5manIweVRFY3BkY3hUUXdG?=
 =?utf-8?B?VzVNUVoxK2w0QXBXdzB3dWpnMkg0S2ZWM0lPdC9LZmgwYkVkbERsZ2VRSDgw?=
 =?utf-8?B?QjJPQjJmVDUrVDlmLzlGN2Q4RWF2TllNRUt4ZTBNRU41amhmeDhVZzdxcTF3?=
 =?utf-8?B?WjZwVXBVRG9aYmF6YlExUUx1aFhOaXlRaGZCcGIrMmk4RWJlQkhNNWxGSVJi?=
 =?utf-8?B?bEhTRTFRb0x3RDVlUkM1WDdKckYzUzNTMHptalhSZlk4WWV4RC9VaDNEODJK?=
 =?utf-8?B?UGZ2dlVyeGxlTDQ2aVJ2QUpWSE1GTFlnMUFRdXVYbVpheEU2TUJZSGU0VzY0?=
 =?utf-8?B?TnBjb3VEdU1OQXc2RmZYRHptM2VTSFdLOXlRUmNPUDBkeTRhRmFndy9GcjZP?=
 =?utf-8?B?WjUwbER5TVUrOUtPWXN1NWlnaloxcUR4RHhQNmF4Q2tla0Y5VlQxK3FLQi9z?=
 =?utf-8?B?UDlxNC9JUW1GMHljRTB4QVBjU1VxRXc2NlBHZmsvdWNMMDJ1QXIzU2hkenp4?=
 =?utf-8?B?RjdlQmtuYUoydnZDQmhsSU9IM1U1QzVwRkNVU3JpaFlXL3dlckRHYkh1K05l?=
 =?utf-8?B?N2J0N1RiMGIrRkFLNnhMUlBTVnM4Z1I1UHA0NzJza1pSMWoyZUozMlArME9l?=
 =?utf-8?B?YytuV0VWOHRIN3pTSUJCYWJ0QkhLdncyam1lVEx2ekVLRFVGMkJxOWE2L0tX?=
 =?utf-8?B?WEdobWZHNVJFWHA3YnBOVnV1K2c0WFV5Z1ZETTMzZWZsWVB0cW9DQWpiVFZv?=
 =?utf-8?B?NWVrN2Y5eTM4c1hwa2szMS9jRVJoRmFPbnkrY2RWeFVjTitYTlA3Z3hmeXFU?=
 =?utf-8?B?ZDRuYXJuVUQ3d2R4T1FQNVZZcFQraUtaOS9GTTZBZThsTlBPMWh5V1lnTUp4?=
 =?utf-8?B?MVZuYmErUm9qSGlUamxMQ2U0VmxyV3V0ZlBxYlRjdTh1NTA1a2hwTHJaY1Vh?=
 =?utf-8?B?QW5jZEhhTlpiczhPcXJwUFZIYStWcTZqZllXWHAyYzFnRG5kNjhKVzhhS2d2?=
 =?utf-8?B?eko1SW1oNFBubm00RjJTYVg3aGRKTzJpQVhsRVBRbno0WDJqcnFVWXdGRm4x?=
 =?utf-8?B?SDh3SjhkTlpPM0IyOThzaG91eE1CckFwaE1KR3B1T3FXOXMreGh1TFhhS0tM?=
 =?utf-8?B?c2xrM1B4RzlOWEsyQVRWdG1hQVgwaFBscEp4SmNyazE4Q1BmckRMM1pzeWZJ?=
 =?utf-8?B?NmVMN3UzMm1aZFdpUTN4NFNUekZDL3ZheUJ0NzdzWUFsdDcxK0ZEMHJrY3cw?=
 =?utf-8?B?cDZDeGUzcUtEazB6dmN1bEhTRWJ1YVNxemhWSWdNeS9yZGdRZXNUd0s2SXY2?=
 =?utf-8?B?Z0Z1Z3lLOFpnZE8ydDZoZGgyb2dYd0dBMnJiOHBjRG5BNXFzZ1d6UGZ5T29U?=
 =?utf-8?Q?s5ifqKyeM2uguRBtnYLr4f4tEOPakeCj?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR04MB8549.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dGlwUWFHaFlIWmlzRThIM3FBbm9aL3NJY0o0UU1XYUxldXRDUFJGVllKQ1hK?=
 =?utf-8?B?UDdCMnRTTzh5aFQvbUJZbm9iN01SNzRheG5HV3A3ajFiTWI0UUNqclkvS1V4?=
 =?utf-8?B?Z3I3elMwNlhLUFdxZVphb3RqamRsMFdLTVpkY3dXa000bm16c0Y2S1JTRnpO?=
 =?utf-8?B?M0tXQ0x0cUVXeDhaYW9hWjlHdXNPdTNTRmRBVE5LaTkwekhPanJMd1lmMVVG?=
 =?utf-8?B?MWMzYmVreVlKNTBrUFhsRzA4VU9RQWVjd3BjL3g5QjZNSHdoeUQrVHRaRTU2?=
 =?utf-8?B?MFY1bHIvV09RWlJ4RjgvMjNoSEZCc3NuZHFlUk5oOU44KzBlQkw5QlJDWEJD?=
 =?utf-8?B?bDdKWjVZN29GMGFsV1N4UUVCZ3FFenp4SUxzOHJmNTRoOEw4d1M3SGtGNjFF?=
 =?utf-8?B?Wklaa3g5aG1mRWdOaEtqS2E5L2NkdGFKZWd2ZjZ2TGtiNXg0S00rV0FyS3NO?=
 =?utf-8?B?bjQ0cTdiNlVHU2lCc1pRYURxQkMvQnlnRWcwb091c0RGck8rYWVkM2xWWVNQ?=
 =?utf-8?B?dklEWTlsdXNjN1NXZmdUVHlOTHFvYzNGc3BIcjVlVVJJQTRERWNpS3FlbUxr?=
 =?utf-8?B?c1RqMWIzZ3JQU1QwZUw1c2dZU280bGJxNWNQRjdNcm1lbE9wcXc1NmxPUHpH?=
 =?utf-8?B?WlExMUpBeEFOcXljb25OTjkvVWI0elQ2eXQ3YTVpckN4bnZpMnd4QkhGc2xO?=
 =?utf-8?B?U04yYXhlS0JUWEdzR3RYWjhpSThSK3c0b2xrWVFQMDhhSzJHS0dEd0xRSlpv?=
 =?utf-8?B?NHVzd3RRVE9hSnpjczJSMmFhZmxjT1JNMFNmZEFYSmkxdU1mRW5CMndrMzZk?=
 =?utf-8?B?bzNBcFNzV3dyZDZPaTNZQlZvVTczU0o2RFJNUUFnTXVmOW1MdjNoOHM1M00y?=
 =?utf-8?B?NHorVXZjalo3UTljbnY0blJjU2FMQThLWmhqSW95WHF0Zys1UG03WUdJQ2dw?=
 =?utf-8?B?ZGtFOTBXMlBtSFc2b01hdEZrdG1uUERUMGx3NzFEMkd2a2J0OWJMWjJzM0dN?=
 =?utf-8?B?VmRTbzNUZXdEbTE0YTU2NmVlL2prdVp4RmVmeUJzdm1GVWkwMWZ2ZmI2dCtL?=
 =?utf-8?B?S1JNVnJJeVM0TFR3RitlTTJJeXBPYzVaQ2Y4TEVFYTVIWmNGdEhxZnhSUTFK?=
 =?utf-8?B?Q0hLYWo2aXRTbXB6Z2c0ZEJyY1ZtNnkvaW9vVlRFN29IVWh6SlUwME9xTVB6?=
 =?utf-8?B?NXkzS204bkJtSGVrREZlUHRzRkM2NFZDVys2bVJiVUFFcmVWR1JNSC9XSzF1?=
 =?utf-8?B?dmZHU0pWaFUrRDhQUkZLcFRoV3RrT0ZqNitmZGVLVHNXZWpPa1htK0ZycUJV?=
 =?utf-8?B?TlpPejNPNEZUVTRWckNCTVZ4MXJVdEJjYlExRmVFNHlsdHpjUzlpSHRJSlNw?=
 =?utf-8?B?RU1xbDkva3Axb1ZqaG1DSVZ1T3RzR21kdVdxSzZoYnUwd0ZucEJGa2ZUVHFm?=
 =?utf-8?B?bXNuWEpaV1lBdTRZa0JUUU8xVXNIYVc4am9LL21RQW1NQ1F6TFBnV3FwRzBw?=
 =?utf-8?B?T0FvU0krUXhCTXhZMTQ4NnVicEZJaGxZQWdnd2c2VWFNMEYrcmdnSFIwMXQ3?=
 =?utf-8?B?TnhmZkJKU3RXWW9NZ2Y2L1Vuekk4SXRJaVc0bGhMZzQ2MmcvVC9TbHlHRlR1?=
 =?utf-8?B?emNsZ1EzVjdoNjFPRDVnbTdPWjV4RTc2My9RZUlFR2gzdTF2dTV2cFU4ajdY?=
 =?utf-8?B?OEl4NmpnREk5MnNxQlJoMHhScE1RanJXOXI5bW9XdWRibEpTY2U4UmZqd3Zi?=
 =?utf-8?B?azRwNGhPWm1OYjNGWXpndmR4L0MrNy90RkRzQXlXRWRvbXFIUDJDcGR5UWtZ?=
 =?utf-8?B?bWVxOFBESlFlRUFBbDZxaG9HUHBpU1BkQmZIczAwUnVmK2dZVjhWRzVKR2Rs?=
 =?utf-8?B?WUpVVm5pUXFBZFhQRHJjK2FSV0lXYlZNZDR2Zld1RTFoRmNWRUxqeHBDd3VH?=
 =?utf-8?B?all6dGN1S01tQXpEVWVTOUVsc04xOVJNTmYyTms2VUc1cEZ5b1Z4Z0dQK0o5?=
 =?utf-8?B?MEJPVWZWaTk2N3c3cjJndzZkSXU0UUxqdkpFeW1PalVXbyttcmoyaXNzdllJ?=
 =?utf-8?B?ZmVpNmJEZkVSSmExSGZQaURLUTZOWGQ4dTVVVkdTWkZZNTJ0UVdhaDBtdmx0?=
 =?utf-8?B?Kzl3amZrRXlsVmpEdnhOR2o0V0gvdUs0SXRCVVdJUGMxNXBGV3hIdWpJOENF?=
 =?utf-8?B?bVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4E1F9D7055931D4FBBC43BA253C60D70@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 0cZD6NXBnEu1JxhPZwct2MZLYbQLjV0NoSwocckok3K30LUHsbx9sORXmYJDgXh/1c8YoikboPUAM6egkp48IhsxecKtsILeLJtXzY9lFwCuV/7m0NtUZCA+zj5+UxPFUbGrX+D9yRHxpF3mqI6gzHDH2+HYWcmXMPDQt6uooQ9Xxn6UEiyQUh0/J0z7o8KF6Xnefb56HcaYfx9CEIYkSAvSme4wOYRBjAS/6RiEHHctEAl4feVLAwkwftNWD42dKgsT1TwdjC20wtlwyK5BgbS/3yYlvFhcSUektd+dGRwUNJ0Dr81yV21597Wsl8fBdgrFHvB3iSKUxR9vZ48tLwrtpvlu4yz83k/3BYIPVvsW4ilag2qMOehW3kClyyIYVCtgndcn8d+Iq95cdTcePz62wiSiAjdgO9f23giqssxtf6/gdsA0nlWy17AcVC3q9DqZjxtJUYr69XAeBZlkxI72LEe/MtGSPquH/84yGf5dPvshmkw9vI1QSSBYDQr1WtmGbH0ZuFc9DV2ZN5skxeDw07CVT57tbr71vvG8DXPm0MJKhQ8hGoLYuHjVO9wG57wQQrVDhYGHUfB3wUP5pFlK26bd8zdbbGyfXl3Qk6RB7s/KX9L4+Zy1jR42z7EY
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB8549.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4d8c83b-e778-4fad-38f8-08dd43d8279b
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2025 22:23:01.2821 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NEUwd33iZ3JNbFvoRvy8WjAtAViTbo2uL3gAolv9Tv3KD5oHJxtxrrrPjJ3qymtK/5JrpuMS5WHeL3fJyHd+Cg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR04MB8920
Received-SPF: pass client-ip=68.232.143.124;
 envelope-from=prvs=121babd3c=wilfred.mallawa@wdc.com; helo=esa2.hgst.iphmx.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

T24gVHVlLCAyMDI1LTAxLTI4IGF0IDA5OjAzICswMTAwLCBLbGF1cyBKZW5zZW4gd3JvdGU6DQo+
IE9uIEphbiAxNSAwMjoxNiwgV2lsZnJlZCBNYWxsYXdhIHdyb3RlOg0KPiA+IE9uIEZyaSwgMjAy
NS0wMS0xMCBhdCAxMDowNCArMDEwMCwgS2xhdXMgSmVuc2VuIHdyb3RlOg0KPiA+ID4gT24gSmFu
wqAgNyAxNToyOSwgV2lsZnJlZCBNYWxsYXdhIHZpYSB3cm90ZToNCj4gPiA+ID4gVGhpcyBoZWFk
ZXIgY29udGFpbnMgdGhlIHRyYW5zcG9ydCBlbmNvZGluZyBmb3IgYW4gU1BETSBtZXNzYWdlDQo+
ID4gPiA+IHRoYXQNCj4gPiA+ID4gdXNlcyB0aGUgU1BETSBvdmVyIFN0b3JhZ2UgdHJhbnNwb3J0
IGFzIGRlZmluZWQgYnkgdGhlIERNVEYNCj4gPiA+ID4gRFNQMDI4Ni4NCj4gPiA+ID4gDQo+ID4g
PiA+IFNpZ25lZC1vZmYtYnk6IFdpbGZyZWQgTWFsbGF3YSA8d2lsZnJlZC5tYWxsYXdhQHdkYy5j
b20+DQo+ID4gPiA+IC0tLQ0KPiA+ID4gPiDCoGluY2x1ZGUvc3lzdGVtL3NwZG0tc29ja2V0Lmgg
fCAxMiArKysrKysrKysrKysNCj4gPiA+ID4gwqAxIGZpbGUgY2hhbmdlZCwgMTIgaW5zZXJ0aW9u
cygrKQ0KPiA+ID4gPiANCj4gPiA+ID4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvc3lzdGVtL3NwZG0t
c29ja2V0LmgNCj4gPiA+ID4gYi9pbmNsdWRlL3N5c3RlbS9zcGRtLQ0KPiA+ID4gPiBzb2NrZXQu
aA0KPiA+ID4gPiBpbmRleCAyYjdkMDNmODJkLi5mYzAwN2U1YjQ4IDEwMDY0NA0KPiA+ID4gPiAt
LS0gYS9pbmNsdWRlL3N5c3RlbS9zcGRtLXNvY2tldC5oDQo+ID4gPiA+ICsrKyBiL2luY2x1ZGUv
c3lzdGVtL3NwZG0tc29ja2V0LmgNCj4gPiA+ID4gQEAgLTg4LDYgKzg4LDE4IEBAIGJvb2wgc3Bk
bV9zb2NrZXRfc2VuZChjb25zdCBpbnQgc29ja2V0LA0KPiA+ID4gPiB1aW50MzJfdA0KPiA+ID4g
PiBzb2NrZXRfY21kLA0KPiA+ID4gPiDCoCAqLw0KPiA+ID4gPiDCoHZvaWQgc3BkbV9zb2NrZXRf
Y2xvc2UoY29uc3QgaW50IHNvY2tldCwgdWludDMyX3QNCj4gPiA+ID4gdHJhbnNwb3J0X3R5cGUp
Ow0KPiA+ID4gPiDCoA0KPiA+ID4gPiArLyoNCj4gPiA+ID4gKyAqIERlZmluZXMgdGhlIHRyYW5z
cG9ydCBlbmNvZGluZyBmb3IgU1BETSwgdGhpcyBpbmZvcm1hdGlvbg0KPiA+ID4gPiBzaGFsbA0K
PiA+ID4gPiBiZSBwYXNzZWQNCj4gPiA+ID4gKyAqIGRvd24gdG8gdGhlIFNQRE0gc2VydmVyLCB3
aGVuIGNvbmZvcm1pbmcgdG8gdGhlIFNQRE0gb3Zlcg0KPiA+ID4gPiBTdG9yYWdlIHN0YW5kYXJk
DQo+ID4gPiA+ICsgKiBhcyBkZWZpbmVkIGJ5IERTUDAyODYuDQo+ID4gPiA+ICsgKi8NCj4gPiA+
ID4gK3R5cGVkZWYgc3RydWN0IFFFTVVfUEFDS0VEIHsNCj4gPiA+ID4gK8KgwqDCoCB1aW50OF90
IHNlY3VyaXR5X3Byb3RvY29sOw0KPiA+ID4gPiArwqDCoMKgIHVpbnQxNl90IHNlY3VyaXR5X3By
b3RvY29sX3NwZWNpZmljOw0KPiA+ID4gPiArwqDCoMKgIGJvb2wgaW5jXzUxMjsNCj4gPiA+ID4g
K8KgwqDCoCB1aW50MzJfdCBsZW5ndGg7DQo+ID4gPiA+ICt9IFN0b3JhZ2VTcGRtVHJhbnNwb3J0
SGVhZGVyOw0KPiA+ID4gDQo+ID4gPiBEb2VzIGl0IG1ha2Ugc2Vuc2UgdG8gcGFjayBhIGJvb2w/
IElzIHRoaXMgZGVmaW5lZCBieSB0aGUgU1BETQ0KPiA+ID4gc2VydmVyDQo+ID4gPiBpbg0KPiA+
ID4gdXNlPyBJIGNhbid0IGZpbmQgdGhlIGRlZmluaXRpb24gb2YgdGhpcyBoZWFkZXIgYW55d2hl
cmUuDQo+ID4gPiANCj4gPiBUaGlzIGlzIGVzc2VudGlhbGx5IGEgdmlydHVhbCBoZWFkZXIgY29u
dGFpbmluZyBlc3NlbnRpYWwgc3RvcmFnZQ0KPiA+IHRyYW5zcG9ydCBkYXRhIGFzIHBlciBEU1Aw
Mjg2LiBGb3IgZXhhbXBsZSwgdGhpcyBpcyBkZWZpbmVkIGluIHRoZQ0KPiA+IHVwc3RyZWFtIGVm
Zm9ydCBmb3IgDQo+ID4gYGxpYnNwbWRgIHRvIGFkZCBzdG9yYWdlIGJpbmRpbmcgc3VwcG9ydCBb
MV0gYW5kIGluIERTUDAyODYgWzJdLA0KPiA+IHRoaXMNCj4gPiBpcyBkZWZpbmVkIGluIHNlY3Rp
b24gNS4xLjEuDQo+ID4gDQo+ID4gQ3VycmVudCBpbXBsZW1lbnRhdGlvbiBvZiB0aGUgU1BETSBz
ZXJ2ZXIgKGkuZSBpbiBgc3BkbS11dGlsc2Agb25seQ0KPiA+IG9uZQ0KPiA+IHRvIGhhdmUgc3Vw
cG9ydCBmb3Igc3RvcmFnZSksIHdpbGwganVzdCBwYXNzIHRoaXMgaGVhZGVyIHRvDQo+ID4gYGxp
YnNwZG1gDQo+ID4gdG8gYmUgZGVjb2RlZC4gT25jZSBkZWNvZGVkIGJ5IGBsaWJzcGRtYCwgYHNw
ZG0tdXRpbHNgL3NlcnZlciB3aWxsDQo+ID4gY29udGV4dHVhbGx5IGNoZWNrIGZvciB2YWxpZGl0
eSBvZiB0aGUgbWVzc2FnZS4NCj4gPiANCj4gDQo+IE9LLCB1bmRlcnN0b29kLg0KPiANCj4gPiBB
cyBmb3IgaW5jXzUxMiwgaXQganVzdCBuZWVkIHRvIGJlIHllcyBvciBubywgaXMgdGhlcmUgYSBi
ZXR0ZXIgd2F5DQo+ID4gdG8NCj4gPiByZXByZXNlbnQgdGhhdCBoZXJlPw0KPiANCj4gSXQncyBh
IGJ5dGUsIHJpZ2h0PyBUaGVuIEkgdGhpbmsgdXNpbmcgdWludDhfdCBpcyBtb3JlIGNsZWFyIGhl
cmUuDQpBcyBwZXIsICBTQ1NJIFByaW1hcnkgQ29tbWFuZHMgLSA2IChTUEMtNikgaXQncyBhIHNp
bmdsZSBiaXQgdG8NCmluZGljYXRlIHdlYXRoZXIgaXQncyBzZXQgb3Igbm90LCBoZW5jZSB3aHkg
SSB0aG91Z2h0IGEgYm9vbGVhbiBtaWdodA0KbWFrZSBtb3JlIHNlbnNlIGhlcmUuDQo=

