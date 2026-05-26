Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE8AFCD6E40
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 23:21:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wS154-0003Uk-2H; Tue, 26 May 2026 19:21:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=599a94ef2=Alistair.Francis@wdc.com>)
 id 1wS152-0003Sr-AW; Tue, 26 May 2026 19:21:00 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=599a94ef2=Alistair.Francis@wdc.com>)
 id 1wS150-0000G0-BI; Tue, 26 May 2026 19:20:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1779837658; x=1811373658;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=Cj1MZiRxG7r3oaVvOt7yoO5fbU7e2/t82sZAcDck+sw=;
 b=MIALSaISxgr85emBCcN6t6Hh+56TvvpXSqciYtpLCTDgtj1O/0hxdXhe
 liGBjeLbvbWJskbsMDEC2rUtpMNOUJlwgvDf6jcSxB8nhEZFPmUd1uRvd
 8b+zPXBCslhDMToWiDCzYvTNOLyu4AYZrzGIKTiMxfWvVNhHvnBWvcbZv
 HXBUqWHjSgYDBvIz3bcY03Gt6J/5F0Yza0qpiDh0kNq3dVyoAZdUfa+vv
 377XQk37e7J0wWzXKHEyuM/4NQrStO9qq93NdIBS5xzg4OSJwgnrMBdcY
 wndDvIO53YzyBwUa0N4lLF7BMOsfZHGtjD7ovt1dXyPS+q2EWrtOrcp6t g==;
X-CSE-ConnectionGUID: jgWOL3e9Rlug6PE4VlAPDQ==
X-CSE-MsgGUID: bGqJZAwCRkOMgkBfW3bONQ==
X-IronPort-AV: E=Sophos;i="6.24,170,1774281600"; d="scan'208";a="147839690"
Received: from mail-eastus2azon11011070.outbound.protection.outlook.com (HELO
 BN8PR05CU002.outbound.protection.outlook.com) ([52.101.57.70])
 by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 27 May 2026 07:20:55 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WJDmX5KwBN5yu9YEEDaAieT6DQXEvEAFwAGVp/hRvE7z9pBjlcGpu9VnldWfjXpoXdOdVlduhQRoK7W18+XWJydLQTC5O7ytsGtMWordzhxPvaVO7mQZlYxp9UVzurNWXd4Tt0MUnvQUFYGXYj+w5d+xVDezgH9RqYDRm+6kKW3C9okYg/ssIVTLkY8u1pejPnIS9OUcjGVa0R3TM7hms+NcnDwq7XdAkiuQNFL/XtbgRmcTXUDlmfkoWEwDpI8cguUmXfMWdPRdlNyRrb+VwmqlGjmnIsUo1XmcGCe0X+63lkYIZc5cMthOLjPNpHqg4F6PcoMR12xoaXLhWYD1vA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cj1MZiRxG7r3oaVvOt7yoO5fbU7e2/t82sZAcDck+sw=;
 b=VvyBeMv+OwN1ibVe1+7dw+GjpppcQwenUBsQ6359guFdSf9o4jQo+BMttqmtpYp8ixitzBr7+mD8ugBifaIrYwJJUiW93oliKOG2WJBSTCxiv9ddebpPRuEjcD4KPkaEbyy6HUOlaGhWxo+IJevS3AVOAL2p4mtqtS5OASGik03U+dUcUkLHI7ksikJudSwZPTCJTDuVNTeE0yWUm8JuhgMbu5nSm3m/vV8j+ijEcE5l+hSZArswsAojzBfmXgmhNkOXB2ZsNcI+BpMnsvIdYKRTSaC+htNS2QCVzfyaDnqdwzqk+DMXK1couQTkZtDKQa45U5gbSZ6kbqXM/WEkug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cj1MZiRxG7r3oaVvOt7yoO5fbU7e2/t82sZAcDck+sw=;
 b=T7QZHdt6TRPQmwEE4g3RmwIcungcuc/B52AN7ztrGaj0Fhc+dXm1/76rB0RWuImpHoFU9V7+fFB9MXHA9SFFyo5L8U8Pl43y0dhQLwJI/XHrhfdypTivIqJ+ZQRF5flBLvXot3C85AG+lCm5N6Z7sPPzaUvfMBpbx843Atk+u1M=
Received: from CH5PR04MB9550.namprd04.prod.outlook.com (2603:10b6:610:20e::17)
 by LV0PR04MB9814.namprd04.prod.outlook.com (2603:10b6:408:331::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.17; Tue, 26 May
 2026 23:20:53 +0000
Received: from CH5PR04MB9550.namprd04.prod.outlook.com
 ([fe80::2dd5:1dc8:e3e7:5d31]) by CH5PR04MB9550.namprd04.prod.outlook.com
 ([fe80::2dd5:1dc8:e3e7:5d31%4]) with mapi id 15.21.0071.011; Tue, 26 May 2026
 23:20:53 +0000
From: Alistair Francis <Alistair.Francis@wdc.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "philmd@linaro.org"
 <philmd@linaro.org>
CC: "daniel.barboza@oss.qualcomm.com" <daniel.barboza@oss.qualcomm.com>,
 "chao.liu.zevorn@gmail.com" <chao.liu.zevorn@gmail.com>,
 "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>,
 "zhiwei_liu@linux.alibaba.com" <zhiwei_liu@linux.alibaba.com>,
 "palmer@dabbelt.com" <palmer@dabbelt.com>, "pierrick.bouvier@linaro.org"
 <pierrick.bouvier@linaro.org>, "anjo@rev.ng" <anjo@rev.ng>,
 "sai.pavan.boddu@amd.com" <sai.pavan.boddu@amd.com>, "liwei1518@gmail.com"
 <liwei1518@gmail.com>, "pierrick.bouvier@oss.qualcomm.com"
 <pierrick.bouvier@oss.qualcomm.com>
Subject: Re: [PATCH 2/4] target-info: Add target_riscv64()
Thread-Topic: [PATCH 2/4] target-info: Add target_riscv64()
Thread-Index: AQHc7PYfHaHK9iCps0upJToQodaSqrYg8qoA
Date: Tue, 26 May 2026 23:20:53 +0000
Message-ID: <b832d2bad55eba383bc003dc17b00bf029c6dbaa.camel@wdc.com>
References: <20260526095731.63525-1-philmd@linaro.org>
 <20260526095731.63525-3-philmd@linaro.org>
In-Reply-To: <20260526095731.63525-3-philmd@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.60.1 (by Flathub.org) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH5PR04MB9550:EE_|LV0PR04MB9814:EE_
x-ms-office365-filtering-correlation-id: 41c017f1-5100-4029-e354-08debb7d6e9e
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|10070799003|366016|19092799006|1800799024|7416014|18002099003|22082099003|38070700021|56012099006|4143699003|11063799006;
x-microsoft-antispam-message-info: AmWLC/cmcWpW5Cd4iphYo1k3PrmHzycNfl3kFjL66a6uNGEpCR14jX/ZHYhjSmqVGlcANn4WiUe8FgyNruq7oZBQTFhR6yxmKJnamrz83JkG0SA0PjgPr8LqWQTSbMohsZlRVX5eLJaVCem+VJEtriLl1ezmV/g4yfkwYd9bfXVSHSQqAiuZtF6AM4da+Lo/40OzzW7Dsdx/h/rblwMwSNbMpWVaSdxD//ic5dEPDhPss9JQ3ADODmcUsMcVZIPLst6xTx6MCJLinZCgebj9jsq9ubGNSHhINneoqjdr8ccYqeNo0qW+3VT0EjhcRqXpVCkHWsMRta7gyHtvRkjL5zw8ZCFqx6HvlUCxdrUD63saG7VkOvjMHOsdQn8cbtSL6naIOnfh7wDa3akOG41W2heV3kkIGxAgVtrgboNORSlTPvEq5FjsrBxjlY+n7bUfJWq9JFe8wdgUMDEBiIslLBEZpbJRkgEfh+dH5tTW19Cs1gXE1yj6Qj8pa90oppQx9dJVql/NAPrD1EOqgoYfr4i73L2cQZkUVeqjZeRUgTViEFUvjRPJ8Gi8zEJO1PmuhIcEiyaN+pJCzlRfPEI+fKRIVoJpfa7vMmhh9jMHQ68+a2+iKzf4nkoEEpmxXa7bEhsHV0cxitGwSwHnn41z6UwjhYdXqsbIsjynyFzz4KeYUA70Y6Iir5Qla661L4uLm6V1blhRTWQFpD1QEtIGmskgMCoN1gm7HVAF84J/i1NU7AR9pNoJu5nsePaPAwVV
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH5PR04MB9550.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(10070799003)(366016)(19092799006)(1800799024)(7416014)(18002099003)(22082099003)(38070700021)(56012099006)(4143699003)(11063799006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?U1ZTVCsyYm0wRkd6emp2dnN1TDRyYVlZZ2gxWVRhcUhyV1p0ckVRL2QvTUlS?=
 =?utf-8?B?K2MwUjJ5OWhqVkJWVmRWbmQ3cUI4cHBpbEhtWkZsQk9xU1ZVQzJQeVN0YmMy?=
 =?utf-8?B?cW1TbzdjTHNYd0RwYXFkTzRJdHBqUG9vNTdWMUNDMHRxdVkwbTgyQjBiWGtL?=
 =?utf-8?B?MW1OcDQzSnJGVGFBUkU1N0JVcXNyR0VnZkR5cU94blRiOHlTTVhhdUQ5bmdv?=
 =?utf-8?B?VFUrbjlyWUg0MGp2ejdRMXhRdU1xRkpzcXo2dnVVSkdkUlN4M0ZsWEg0aWtr?=
 =?utf-8?B?b0FvcDFGcm5ISmJzM052b1M1K2RNb2g5TkFTUDJpRzRLSXFxZ29weVc4T1ZB?=
 =?utf-8?B?RVhoaWt5SDhFemtwTlNBcVJJSFc3Nlk5elE3Sm1BbnRtVTQ4VzZSV0lCZ1Zu?=
 =?utf-8?B?bThrUFJjRXp0NlZUb00vaG1SeFVQaWpJU3NMZXlsbkxKakhTdlI3SUVJOUls?=
 =?utf-8?B?TVdrbmJyTGl2Y0IrVVZoNEJORy80bUgrUDlvbGRYNTVKNERLeldaQXBUcHdq?=
 =?utf-8?B?MExnWVI3cjh6VkJ2eTJKZjZNcFg3cFRody9xMlVNZ2FHRGM0dzFndzB4WnJM?=
 =?utf-8?B?QzV5bFNEc0FKZnQxL1Z5K25rVTI1aXF1ZjZwT2NLR044aXB4UFZwSnNuUG9t?=
 =?utf-8?B?OEtaS0tZT0NHcFYxN0RxbnV1bTgvbExFdE1TUjBkMjlLVjl0ZkV4czRPVTBC?=
 =?utf-8?B?cjFVNXcrK2ZxRG54V2RGYXliZEFvOS9OMGJEVmFPZE5NNDZhQkZLY0QrRkNz?=
 =?utf-8?B?bjZTQUpzOTFCZnJmVGRMWDNOaHduV3NUQzY4Z3Jmc0RqeFVHYzFLYzQzOXQv?=
 =?utf-8?B?a2Z5R0QySVJTQks0RmdxY0VkMWE1NGNGeU9iYTRtS0svMXIxUGJyalhKLzQ2?=
 =?utf-8?B?NElKaUhLQXZ6bXMrazBPSkx2SWNOK3BmNVR2eW42dXhCTjBnTWw0OTRQSkZ2?=
 =?utf-8?B?L0ZDMkp1Mk9aZVdoeERDNDZZUGFsM2JvL1hDa0tRZXRpMGdaYkRJYlM0OGFU?=
 =?utf-8?B?NCtQbW9sNjRNRmtNbG90WmRzSGRPUDB1OGhpVGg1VDJBZ1pQWkczS3I3ZVg3?=
 =?utf-8?B?MFY1RWRSaHVOWnlqQkFDSVhBRzVjOGxOK1dHWmpNZ1FnUG5NUXQraWVIQTR1?=
 =?utf-8?B?TExtL3FSMisrQkNaVlRHMUM3akFtQUFOZi9idHB3NWZ2UjZSdnBHQlpsMld0?=
 =?utf-8?B?M0JDUmwvZ2txa0VHTVJUcTlGdFJKWlNiOEt1MUduSTN0TGYxeXozbStzcTEz?=
 =?utf-8?B?bTZ3TGY4bFBaYytLcmlYb3puV0k2STBXL0FhY0xsblNkZTNPNmc2U1BXd0JJ?=
 =?utf-8?B?aXM2amE4c3NjSkFIMjNLc25nZnNXRG5VbE4yeTZNUW1nRWNxT2prR2ZQQWZY?=
 =?utf-8?B?KzIrMkFMQWdLbnhjejg3SnBaZ2RNaUw3cmtCM1VFZkVRdGFENVZTK1RGR0V4?=
 =?utf-8?B?TWljc3hJanNUZ0RRWkwwZHdOUkdPb0xWelRJUm5nUkZEMFVDbHZlWjBUblFp?=
 =?utf-8?B?cENYejB2MFhzVEI5eUcrYUh1MTFidE1PWDlCc3dmUC9wUjlkQUg5Ykp2ZUM3?=
 =?utf-8?B?Nmw2c2JXNFhzdlZzaituSTRJSEtJWTBQcjY1VUxqd3V6UWUrdjZlazNMb3h5?=
 =?utf-8?B?SEhQc3hHWDBZWlVaM0l6Y2tSbUQrUjdQM2E4bHNOekxiWTFweWNPaEJnZUVC?=
 =?utf-8?B?cEkxTGhWeDd1Sy85U3dvajJTRDFYUGlpQXdORzd4M2tZdDJ0dDh1ZjBXdXpu?=
 =?utf-8?B?cWlJT1J0dksxYmxtUDNCcU9GYnNVUlNxd3VhM0o3ZUoydjFJWVA2WW5ZQUJK?=
 =?utf-8?B?TUtMTFJWeWRSWk1jS1MySHhoWjRNRDVNUG5YRk8xRk5WdUlWYXF6S2lHN1Zq?=
 =?utf-8?B?dEpEcTYwWVZRaWdjcDk3RktwWlAzVDBIY3VOZjk2NjFmbG5ReFlzQVBHdEd1?=
 =?utf-8?B?Z215ZExWYkovcGJuZUxiZDd2dXlkTUJjaWZvcVArQjRibVBMb3huZVo1ZkFz?=
 =?utf-8?B?K3dtYzlSd1NnSEduZlJYTk0wQXV5NkN1R0YwNGhJN1NTa3lsN09ZQVh5ZC8z?=
 =?utf-8?B?TUEzNnV2cjhVQ0pkeUdnR2tFK3k3aHVxTnFvakRhb3pxUDBzdkZJVitnTFRN?=
 =?utf-8?B?Mk90TXhFalRqVlBHTXhTTWdIYkRuMlpTTHNZZlR0eEFpZm1icEY0QmoxdDEv?=
 =?utf-8?B?K0I5WFhnaGN0WEhFYUplRTgxUitURGpPUTB0RmJsZjdmckhLck5sWWZtQXRh?=
 =?utf-8?B?dER6MmhIVUtrQ083OU9Vc09aVTRuaHQwSG1tUmtmajJnQmhoQytwcjc5Z0pN?=
 =?utf-8?B?SlNoS08rWGM2WjlnMHZ2eDVyb29zS0Fla3RIRUVLeWlpZ1JkUjZGY3VUWDc5?=
 =?utf-8?Q?wzgWF2ISk2o0C4ZCo4zMLa1wwtKG1GVT2Pk5aBvPu9Bfi?=
x-ms-exchange-antispam-messagedata-1: wfikNOd+nTtKsprXx0O1rAk4RHSYmH8DeN0=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7E448B4F8A5D6C4AB7412BACE3FA0AFD@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: GUD/Uj/4njkEtlfQPMElpkj7H2tZgc3/p0JyAVwzxbXE2VphpitSZJ1E0JvIeIGTLt66/BDHjCItUlvnJZ/PZ3S9cdVYZQ5rchVOr9hZUqrBN4Lp5k3RIL4htOZhPpZkjcLMuRBhEfVmdPbgJIvDbnvMPYnXO6xBe1TLm2KIUgrVrcf3PmbMKSUabXZ0Qpz6vILqPdxjxQE0PR8K/kPFCXi4yCaJCuGNh3qsbfspGrMJ+g6QXoZ6Ij8NVt5lwIw/PnTedrkYXRH7mF81rR3L1302BvuZtj1p1+193Bege28YnB3yR5Weem7NbSa/KqsbcBqX4Wo9rsVN5sLkwzCuCg==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Nkm2f/2ebpnj0IiQSYXiAqY7ZdsBR9uMWyYN/UuxBm4PxS2WmfK5+2w6AHSE5A9iVPJTmtLbblZR8pewsV3ztqO0rRXvbtrlivG8kbYffpfA7DP7JEo8own3xikFbXLJ7HbMqJbtvhIRPissmW4vthFPADe5qZLTsUSEyZSbxv+IEecwrKFA4W47woWxUYxiCQBZMdRP0zg8sV/ht3pkNEKaNR9n/BMDQ2pbaGYbWWLwdXbpUcWPPWO5rj90gDvvn3u3DK2UyN6iqXbjkGxdj7PazlIvxqlrD9LJnjO7DYUio9Ts7JrVpjf0MjK+HbQ6RtcRzuoLjLkXOQWr2iXtkOpRZTxdD1oE8LHcvzpoJV2KYlOsormEUmtoHwUu+Y6OZHTja3b+aq7HFHzoYbIAULaaICpYIkyzt88wgubRuuTdYtLFtB6iQDySlgNz3Z+hF4PdxLA4A7AoWhzU8LbgF3MbvbqIYNvXkah3CW254CEZ8mRYFR6j/o+HSY9IobEe94uh+oJVubF519v0fQ/dEKW4Ic/dM2MhjQPz+K40Vol0pE0a/zCc+w/x1GkWqa3zsl6pdM9PuR6MinkK2IyG7vJgMoQQjHYTqiRNpoTIyt1f7zK5KW9Th2JHkohZh+wK
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH5PR04MB9550.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41c017f1-5100-4029-e354-08debb7d6e9e
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 May 2026 23:20:53.4089 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wTPOaitAfA0a3Lk2/s4zQpv4TgaDGbL0z4RB4yPK4ZFOtsEx+WY/5ZaD4Shn3sqkJ0xuvAYqcsAtZyYxmd+RkqAqg7kYxUJQYC2+tpTk2Pw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV0PR04MB9814
Received-SPF: pass client-ip=216.71.153.141;
 envelope-from=prvs=599a94ef2=Alistair.Francis@wdc.com;
 helo=esa3.hgst.iphmx.com
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

T24gVHVlLCAyMDI2LTA1LTI2IGF0IDExOjU3ICswMjAwLCBQaGlsaXBwZSBNYXRoaWV1LURhdWTD
qSB3cm90ZToNCj4gRnJvbTogQW50b24gSm9oYW5zc29uIDxhbmpvQHJldi5uZz4NCj4gDQo+IEFk
ZHMgYSBoZWxwZXIgZnVuY3Rpb24gdG8gdGVsbCBpZiB0aGUgYmluYXJ5IGlzIHRhcmdldGluZyBy
aXNjdjY0IG9yDQo+IG5vdC4NCj4gDQo+IFJldmlld2VkLWJ5OiBQaWVycmljayBCb3V2aWVyIDxw
aWVycmljay5ib3V2aWVyQGxpbmFyby5vcmc+DQo+IFNpZ25lZC1vZmYtYnk6IEFudG9uIEpvaGFu
c3NvbiA8YW5qb0ByZXYubmc+DQo+IFJldmlld2VkLWJ5OiBDaGFvIExpdSA8Y2hhby5saXUuemV2
b3JuQGdtYWlsLmNvbT4NCj4gUmV2aWV3ZWQtYnk6IFBoaWxpcHBlIE1hdGhpZXUtRGF1ZMOpIDxw
aGlsbWRAbGluYXJvLm9yZz4NCj4gTWVzc2FnZS1JRDogPDIwMjYwNTIwLWh3LXJpc2N2LWNwdS1p
bnQtdjMtNi1kMTEyM2VhNjNkOWNAcmV2Lm5nPg0KPiBTaWduZWQtb2ZmLWJ5OiBQaGlsaXBwZSBN
YXRoaWV1LURhdWTDqSA8cGhpbG1kQGxpbmFyby5vcmc+DQoNClJldmlld2VkLWJ5OiBBbGlzdGFp
ciBGcmFuY2lzIDxhbGlzdGFpci5mcmFuY2lzQHdkYy5jb20+DQoNCkFsaXN0YWlyDQoNCj4gLS0t
DQo+IMKgaW5jbHVkZS9xZW11L3RhcmdldC1pbmZvLmggfCA3ICsrKysrKysNCj4gwqB0YXJnZXQt
aW5mby5jwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfCA1ICsrKysrDQo+IMKgMiBmaWxlcyBj
aGFuZ2VkLCAxMiBpbnNlcnRpb25zKCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9xZW11
L3RhcmdldC1pbmZvLmggYi9pbmNsdWRlL3FlbXUvdGFyZ2V0LWluZm8uaA0KPiBpbmRleCAyM2M5
OTdkZTU0MS4uNmM1YjcxNDI4OGUgMTAwNjQ0DQo+IC0tLSBhL2luY2x1ZGUvcWVtdS90YXJnZXQt
aW5mby5oDQo+ICsrKyBiL2luY2x1ZGUvcWVtdS90YXJnZXQtaW5mby5oDQo+IEBAIC05OSw0ICs5
OSwxMSBAQCBib29sIHRhcmdldF9wcGM2NCh2b2lkKTsNCj4gwqAgKi8NCj4gwqBib29sIHRhcmdl
dF9zMzkweCh2b2lkKTsNCj4gwqANCj4gKy8qKg0KPiArICogdGFyZ2V0X3Jpc2N2NjQ6DQo+ICsg
Kg0KPiArICogUmV0dXJucyB3aGV0aGVyIHRoZSB0YXJnZXQgYXJjaGl0ZWN0dXJlIGlzIHJpc2N2
NjQNCj4gKyAqLw0KPiArYm9vbCB0YXJnZXRfcmlzY3Y2NCh2b2lkKTsNCj4gKw0KPiDCoCNlbmRp
Zg0KPiBkaWZmIC0tZ2l0IGEvdGFyZ2V0LWluZm8uYyBiL3RhcmdldC1pbmZvLmMNCj4gaW5kZXgg
MjhjNDU4ZmM3YTcuLjA0YzY5YzQxZjhhIDEwMDY0NA0KPiAtLS0gYS90YXJnZXQtaW5mby5jDQo+
ICsrKyBiL3RhcmdldC1pbmZvLmMNCj4gQEAgLTkzLDMgKzkzLDggQEAgYm9vbCB0YXJnZXRfczM5
MHgodm9pZCkNCj4gwqB7DQo+IMKgwqDCoMKgIHJldHVybiB0YXJnZXRfYXJjaCgpID09IFNZU19F
TVVfVEFSR0VUX1MzOTBYOw0KPiDCoH0NCj4gKw0KPiArYm9vbCB0YXJnZXRfcmlzY3Y2NCh2b2lk
KQ0KPiArew0KPiArwqDCoMKgIHJldHVybiB0YXJnZXRfYXJjaCgpID09IFNZU19FTVVfVEFSR0VU
X1JJU0NWNjQ7DQo+ICt9DQo=

