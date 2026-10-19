Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4195DCCA490
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2026 02:28:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xId6f-00085r-Jm; Sun, 18 Oct 2026 22:28:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=7454c2a62=Alistair.Francis@wdc.com>)
 id 1xId6Z-00081C-F9
 for qemu-devel@nongnu.org; Sun, 18 Oct 2026 22:28:04 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=7454c2a62=Alistair.Francis@wdc.com>)
 id 1xId6X-0001pL-U5
 for qemu-devel@nongnu.org; Sun, 18 Oct 2026 22:28:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1792376882; x=1823912882;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=BHoWb/NXQ3lOkSfpcyYHOcI7R/4WY/GrPPoHDwkpXMI=;
 b=KtlFO2dTt+nY1I7Sp4t3jj0BLaxbYL86pGXiGKr3ZMy7SFvPjg3skYnk
 8j1PDSrS/+1enVWM5moPYE9SfdTTAwiz2I3oVXjiHwq1Uu5oU6whHbX2c
 otu8cRw+8W7Q7+3eBE8OR2ECdQgDM+G4/nt2WtuL2gq9/FrkvwKvFNI8y
 mqcSaO0OODHpYAg+rWaAcdGWhikOpkcNlZI5DmB3E2RUnhKoqq/XjBI9T
 tE8ue3hvAJMy240EMme3cv/bbiaEAW1mXDt4dNLl9B5jEWhD2GmnaayL5
 xpUftgW/1/IlKzbND756dkeTIPJgVqjve9k1U+d9IzLbBWvhdZ+Lx//V5 Q==;
X-CSE-ConnectionGUID: fziWEmIDSpO+tSyeN0kH7A==
X-CSE-MsgGUID: yx1y664hR06nNjtpBspn2A==
X-IronPort-AV: E=Sophos;i="6.27,166,1786982400"; d="scan'208";a="158416916"
Received: from mail-eastusazon11011000.outbound.protection.outlook.com (HELO
 BL2PR02CU003.outbound.protection.outlook.com) ([52.101.52.0])
 by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 19 Oct 2026 10:28:00 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oqlqMDP8jW6g+WE/o0ZWAk+08+ZdwtXyTorT7gcDjTChJsYc42NaxSwxLFVooJR2rGydxpFG2YXgi9fORImLBQBfGa84EbH8/LsUrZoWzfzTGsLI6TCL35Nr3A0m4OqQc/q6en04n3egZcoJcj0AfH33ZVBXqcFFILFt7nLOZVDlSVtndH2x2LFPywEogwZgrs3Law2mZDeSlCLswz1VeJIxKBdV2d03G0COeScw1U///18eNr/WpzYetPSlzYwKTZKUPp+SPfSMiWYFWAqDaaVQylMshzApMrcqoESf9gEXvtwrcKUzGqWNPVutSkKFoG9TCJd/eImqp3/xkcUm3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BHoWb/NXQ3lOkSfpcyYHOcI7R/4WY/GrPPoHDwkpXMI=;
 b=cmAdP14yPuD2XVnt3d/9kfE884r3EaeMnHqdKVTPdrlL4V6gQ648i9LrP9Bvtkz7sEkm544cv+KHymAewovS6QPaCg18PPX3Q4vq4HvC0sBa1SU0EEbfCF2rY447azwpITBF7F/EEbF//SA/wquwOg2BjfRyKpcjVNNldgOTtR5rQUG0vhovJptwC92Pq5kQAKfIJcuB4fe2fF6q2V8pnKwvJJm5FKaPZpyoig6Z21Cw2U4ukerN89/WEfUuoM44YsWIMmYmHXzSA8Ir522KaY5YOMfMxE0GRSoWFNhxpjX3pphjcmaSdmT8/vKMFSU9hC308Skh+jEffV9rEBlxRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BHoWb/NXQ3lOkSfpcyYHOcI7R/4WY/GrPPoHDwkpXMI=;
 b=QUFc0qLf5CCWdn5UHB97MJAFGkXjlpfQVBKZRwNE+msaJRB6tkocwwYd73Xy4CEsLMSMRksjWMV9YH48cqrLEQD+3yUt3uNU30HoIB8Na/1BR5i8D2V1h2GFxV6UOh1tDohVJvWniXtJ7yQfVvEfTPZQ6vhJbF2+Xh+XsES0hic=
Received: from MN6PR04MB9359.namprd04.prod.outlook.com (2603:10b6:208:4f2::13)
 by MN6PR04MB9336.namprd04.prod.outlook.com (2603:10b6:208:4f1::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Mon, 19 Oct
 2026 02:27:59 +0000
Received: from MN6PR04MB9359.namprd04.prod.outlook.com
 ([fe80::e729:bbef:5a37:2e77]) by MN6PR04MB9359.namprd04.prod.outlook.com
 ([fe80::e729:bbef:5a37:2e77%4]) with mapi id 15.21.0522.017; Mon, 19 Oct 2026
 02:27:59 +0000
From: Alistair Francis <Alistair.Francis@wdc.com>
To: "pierrick.bouvier@oss.qualcomm.com" <pierrick.bouvier@oss.qualcomm.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "philmd@oss.qualcomm.com" <philmd@oss.qualcomm.com>,
 "daniel.barboza@oss.qualcomm.com" <daniel.barboza@oss.qualcomm.com>,
 "anjo@rev.ng" <anjo@rev.ng>
Subject: Re: [PATCH v2 9/9] meson.build: list all remaining softmmu targets as
 comments
Thread-Topic: [PATCH v2 9/9] meson.build: list all remaining softmmu targets
 as comments
Thread-Index: AQHdXcVXSbB9teiHwkyEINOuf7S/rLcEJ14A
Date: Mon, 19 Oct 2026 02:27:58 +0000
Message-ID: <f7eb0ec665411343e5628e3c3337ea7e63131744.camel@wdc.com>
References: <20261016232304.1215119-1-pierrick.bouvier@oss.qualcomm.com>
 <20261016232304.1215119-10-pierrick.bouvier@oss.qualcomm.com>
In-Reply-To: <20261016232304.1215119-10-pierrick.bouvier@oss.qualcomm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.62.0 (by Flathub.org) 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN6PR04MB9359:EE_|MN6PR04MB9336:EE_
x-ms-office365-filtering-correlation-id: af8cbe8d-3a56-41d3-5c20-08df2d889776
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|19092799006|366016|10070799003|23010399003|1800799024|261009223027099003|10067099003|56012099006|22082099003|18002099003|11063799006|4143699003|38070700021;
x-microsoft-antispam-message-info: kwwfKgLNfQsLAul0dCBaye0KaSFwO7leMFOhBIxPOC5bxMWFyxXHvu5XOaXcjhkC2xKrrV2KO2pam7FWw31hQgDNwGOxh7Zksm3l0L/WSYIE6wzlktkwLHCQXqAefIWCo5x6WE5JpGf865nlQ+9W5z4q53GRTrV1umrQ6+Cs84q8+5t4G/bAR/63CbWQnv0YCzH/tEt2GlCUa8jAqmmGJTxm1s+W0y6KgrkcHXytpuASKUmC/s31Q7jFqOY6cO/nzUmP7cd4NFTzMRyMm4BfLQGrStCiK+lE6E0yDcOaCVmFbZexRzq8Nicbi0+hsBtMWQ4AGGdekSHzVflVNjFKe94C/xH00EUGRStxjVhk81lENu0VYtJtbHd6NP/0gixsejUAQzGb7p9+l7s7+yeQlRlr6YhakEoVPki1BuiHHnpCmSHrzjse6Q10eUtHkZ+yi5k5AgxNKBq0jnv4saqAEI8/Sd7C72U0YlCwLdJQm6N/m7oZ51hS/gdN0/zEPa7tlgl2Am0QZIGXq2h3GfulQEBo7Gvcp9hZmXYGLQsXkslxkTLpNNHu54NQtjQ+TkRkokyyXegTwurOjhu/jxaorlWslsDFbYZje1lypVeBFCGmgHDoU0JFi4SbGBA9XcvhX74f5WAJDQkIOCsMzoQWuLQmV5W6eh8ZU3Icju5XHgxIv1oQ2xIuUa87C5JXcsZQb3YxTEPf5TkR8M+JIH3kLond+ZPEhW2wzfP4fBzG1Ag=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN6PR04MB9359.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(19092799006)(366016)(10070799003)(23010399003)(1800799024)(261009223027099003)(10067099003)(56012099006)(22082099003)(18002099003)(11063799006)(4143699003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OVIzQ2NjaTQ4NGxGVk5FSzQyVWwxeGg5cm5nSlJmMnYwK1VHYWM5Q28wTW5W?=
 =?utf-8?B?ZG9MYUhyOEFEcjlJQ2VjUlFvK3p0L1ZTaEU3ck5veGd0bXdXbmdCc2J4VnMz?=
 =?utf-8?B?U000d0xyNXZZMEtibnF2SHFLczdZZUhGQVRVeVJFWnBWa25scTg0T2N2dWZi?=
 =?utf-8?B?aHJtb1hkVUhsNGY0c2hEdzRSWEs5M1JidGpMZTlqY3Aza256b1gxZnkwakQw?=
 =?utf-8?B?ZWhLTVg5NmdSNXVJWGsxYXlnZjNhNTVFNzluZ1gweUthRWZ6Y210TjVyekNJ?=
 =?utf-8?B?MFVwVTF0a2hWK0gxdHlCcHhyUWZqcVZranRBeHdIdXR3UFViSUl2QWFsYWUy?=
 =?utf-8?B?T09BU2t5WDlRNGlHWGNxUXZ3aGtqalBGdlcvSFFNUUZBVmZHZHNhZG9LM0l3?=
 =?utf-8?B?dUFMdlYxYlR2ZUo4ZHhOZ1JOTXRzcTZNU3FLTXVpWkszalBSNXBBQ01iS3lH?=
 =?utf-8?B?RVNwQ1k0ZFkycm03TjRzZC9lNGNuRGdDMGExWEJMMCtMOUFvSW94bG1NOHFS?=
 =?utf-8?B?TzYrdlovMDNwdjNGWmwwNnkzVXFTZmwxOVVET0dWK1ZMYmx0clBuR05aVmtL?=
 =?utf-8?B?YzR6b2JVV29pSkFvdHYwT3JmRFJqaFd2NDY3OUphek9FYWtNcVFGVFdkRGhN?=
 =?utf-8?B?VzJaZ3BSWXZtZFhETkJYckJZMC8zMmh0Z1cxSlpWMDgvSFlJL0xLak0xZUFm?=
 =?utf-8?B?MFlBc1ZuNkxYZWorSnNZSWR6VVQ0Z3BhTmxsQ2F4dFhBcjBheEFNV0ZLOXAz?=
 =?utf-8?B?YXlFcHluVTJmS0hwTVhJdFRCQS91a0IrQjMyLzh4YWlJOG1ZRkd3UkhRQzZz?=
 =?utf-8?B?MjJONUxIeFhuOUNqcGJGRWFXYWZSMCtNTEtpWVQ3YnRJbWRBMUsxaFlCV21n?=
 =?utf-8?B?QlpnWng2VTRKVjRRNzVFRkV2b21YNnRvaW8zcEFzeDhkNm1rQzhqOUxzTTFv?=
 =?utf-8?B?aURoR2l6ckpPYjg2Y1ZWT1FvdjRZU3ZNUFY4MlFyOEtpcjBRZDY3MEcrTmhD?=
 =?utf-8?B?OTRka204bUpvRXpMTlR4YnpkRTltSnMxeVpUSm5hQXI5bzR6UitRTGQ1RmRq?=
 =?utf-8?B?am02bWtyMU5NQW1HQ3hwR0p1MFNNWVpBMEZIUnVxYytqTzJYTllmanFVSHcz?=
 =?utf-8?B?b3VPcmRwWDBYTURlano0cXpMUUxvZHpvVzdlSmx0bSttbnlnMXBGdml2SGFK?=
 =?utf-8?B?TnZQYW1waGRaMU5pOUV0SEpDRUxjaFloZThwWlNhRzlqdU5iSmNIOUFZR2JM?=
 =?utf-8?B?YXFaNDJUSGVkQ1BpREtubnJaVXNMOXVPUmN6bzE2RlMxT1NNcmJHdkZmN1VW?=
 =?utf-8?B?SEM4bUtJZVk4alJlQnQySElMWVVMZ0Jacm5EalRRZkw0TUdCTUVoTHVGNWZM?=
 =?utf-8?B?R3NVMWQwb3dSYUZEVGxDdzN4d2lOUHFGa3V6TFRlYTdOOTJRV1JmRllkSTNT?=
 =?utf-8?B?eVI4Rkp0b2tMQ25tenFKeE9FYWR2cjM1RmVvZXBDQkt3a3BVVHd0Vng0bFVN?=
 =?utf-8?B?VmFyaEdHNlNObldzOWc4NDlzRU1yeFFyc2M4dGcrNjRvVExrZ2pNRlBBOXNp?=
 =?utf-8?B?aERmQVlaclVBTGs1T05MYkkvL3JTYy9iTzEzaU1YQkhjbW10ODlPOVFLV2V2?=
 =?utf-8?B?Wkp5R00xQTFwdWZ0MEdnNUs5bnhqemxRNldSVUZSZzhvdFJzL0xkRTlPNUFi?=
 =?utf-8?B?eE96YjNiVmE2WGZtNzMrd3liL3NrZ0FpbDdkeE5YMU9tNEhxSG5OTHNPK0w4?=
 =?utf-8?B?UVlaQkRuRGxEci9ZbEt6b1FIQ093Y2ZrWDUvTnNweHVyYUdsYSt2N0E3WlFl?=
 =?utf-8?B?c2RNT3g1QXFKQzF3aklud0lRV3lPSFh1V091YWVWS01KVysvckNPQXllTzQ0?=
 =?utf-8?B?c25hc0FONVhFLy9XV0JFMzMzVW5VVnJRRnlzazdvYi9TVUY3dnQyM2x2dVYx?=
 =?utf-8?B?TWUrY3VOQUg1Wk12SWdINWNralUwNVR0VFRQRkNRUTJFUUNDZGFacUQ2QUVq?=
 =?utf-8?B?MVJCUldaK3UxcXo2T3lhYlNHWEJXUi9IVkdEQVlpVVZwWkkyOFhjaU9oSjNo?=
 =?utf-8?B?Z3FGVDJQa2w5VkhqWkJjYldEOGVneEhVU0NOd1ZMN05jdEVxMmlhL2FOdENK?=
 =?utf-8?B?Nk5MYm8yOE9JQlhIOS9KajJ4MnJmN1FqZTR0aTVNVnAwaUVCTnAxclhwWC8y?=
 =?utf-8?B?QTQ5bE5oVWIrWGxEU09xbms0TkhpckY5Y0J3LzdsRWE1bi9lM3VIaC9xT1pU?=
 =?utf-8?B?Y2tWRHRiUnR1K2RycFl0SVd1YzQ5WGlkbnQrRmZXS1crL2VoOGlzNi9jWkNF?=
 =?utf-8?B?UFIvYVEyRHE0b1NSQkg2UFpnZVJBR2Y1bDZyV2RRdzcxRExMVHNydUwvRWlz?=
 =?utf-8?Q?F8uoSbqnyMfqb5UYmLSFdGa5/mUl9j51pbeqTkQtqoMcZ?=
x-ms-exchange-antispam-messagedata-1: jyYLDE7VNGuJl3EOc+pa2b7IuAVDUFaRhNw=
Content-Type: text/plain; charset="utf-8"
Content-ID: <88E0832D424CFB438CC098CA1D408313@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: PP+lwwPZ+tDh8zeRofBqNsmA9rItpaLyRXJEghPryG1F6WzvER8i4S6vDjySTapsqcyIj18IyVHfwSoj1cJanBa6dzahO5PNWaA+IQlhRq/m8diy2+PQshvXPAbiOHVK6ZHSml/5kxlavZaElsOw8czg2wNQULylvQbiJu3w+VIh9RWvcE/uTjMhb3m0kndiKC6jyTVUOP6e36BPQKUikZH3+BzFvmqA+qVLaIl8A/gqwLHYI7f2x4gEW77/X1wlvfCxCcxPt8o84O3mM9abSIMU8RAoBuQGacBsGl0fcqM1NaZXqThYeT1FPZfhVSU8OSjiWDJXg+BwfxCXMv6Njg==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: BA/XW4rirlfDGFgx9kf2AeGTD7S2SSaCw/o2rfEiZVtFogWXweidkoXLVk59hvfqaSTfEP4ngODSG6wf+cIq8ISfQY5MYEYLVY3vaLFNwlePV0tmpMQ5vNtOwoFjXJZhPdMlMlBPG06NChJWRXAhWcyYuK4OZYlZL8xGoEkuW2yCF/pwuiQPAmnjJYg3zH9oICEKXI23WenI7iPIOv3Tw1+zRfabi2+C7UEj7OSsZgreY/AuRHMeXMaf/4LrI8Ur+NO3gDPUMgH4i4BO0O0JHzhH3z5k2g7lWz6KyYIih8HQs+SzAPv0QHsi3LkomlSqR7mYWvkTZGCl+nlwQC3IPHi7gCBuxhLGhgxi6XpDXHSEq9Vo26J2E19uIgkLUHETEN5A3oJX1AVxPWnCFcCiZzFM1LR1dhQ/21r7XD/MvA1F0/KUCVqEVwCpdNIhXN2EISv3B+8+BFynr1pziJtwGjWWY9J4XNSwHWl/iwm2a8jrPu0OaoMayoB8RaGiNh2nzpw4I1G18D+4/KrxIp9A/9FB0GdqrJMIkJ6cGqI16ZruGN/CByPIrCvoYiBnu43L87LtKDQy3oukYfBGSYmE12vrztJ8AQ8oUDxDQp5BlP4uSKxTJHeyaAN5xdg5XWjg
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN6PR04MB9359.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af8cbe8d-3a56-41d3-5c20-08df2d889776
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Oct 2026 02:27:58.9633 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /aRkHa8ORZ6KXJK6DANjpjTwYkRu58kdNcEclhJwgjomP+NNqC9V2P7lUzZOIIGtSaqe/Ljdjwwm0RocKz/Ye/5YdcbS1hMJ/+pvNxqWiuQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR04MB9336
Received-SPF: pass client-ip=216.71.153.141;
 envelope-from=prvs=7454c2a62=Alistair.Francis@wdc.com;
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

T24gRnJpLCAyMDI2LTEwLTE2IGF0IDE2OjIzIC0wNzAwLCBQaWVycmljayBCb3V2aWVyIHdyb3Rl
Og0KPiBTaWduZWQtb2ZmLWJ5OiBQaWVycmljayBCb3V2aWVyIDxwaWVycmljay5ib3V2aWVyQG9z
cy5xdWFsY29tbS5jb20+DQoNCkFja2VkLWJ5OiBBbGlzdGFpciBGcmFuY2lzIDxhbGlzdGFpci5m
cmFuY2lzQHdkYy5jb20+DQoNCkFsaXN0YWlyDQoNCj4gLS0tDQo+IMKgbWVzb24uYnVpbGQgfCAx
NyArKysrKysrKysrKysrKysrKw0KPiDCoDEgZmlsZSBjaGFuZ2VkLCAxNyBpbnNlcnRpb25zKCsp
DQo+IA0KPiBkaWZmIC0tZ2l0IGEvbWVzb24uYnVpbGQgYi9tZXNvbi5idWlsZA0KPiBpbmRleCBj
ZTNlYjAwZjJkYS4uYTAyNWNlYmM2ZDUgMTAwNjQ0DQo+IC0tLSBhL21lc29uLmJ1aWxkDQo+ICsr
KyBiL21lc29uLmJ1aWxkDQo+IEBAIC00Mjc2LDEyICs0Mjc2LDI5IEBAIG11bHRpX3RhcmdldF9z
dXBwb3J0ZWRfdGFyZ2V0cyA9IFsNCj4gwqDCoCAnYXZyLXNvZnRtbXUnLA0KPiDCoMKgICdoZXhh
Z29uLXNvZnRtbXUnLA0KPiDCoMKgICdocHBhLXNvZnRtbXUnLA0KPiArwqAgIyAnaTM4Ni1zb2Z0
bW11JywNCj4gK8KgICMgJ2xvb25nYXJjaDY0LXNvZnRtbXUnLA0KPiDCoMKgICdtNjhrLXNvZnRt
bXUnLA0KPiDCoMKgICdtaWNyb2JsYXplLXNvZnRtbXUnLA0KPiArwqAgIyAnbWlwcy1zb2Z0bW11
JywNCj4gK8KgICMgJ21pcHM2NC1zb2Z0bW11JywNCj4gK8KgICMgJ21pcHM2NGVsLXNvZnRtbXUn
LA0KPiArwqAgIyAnbWlwc2VsLXNvZnRtbXUnLA0KPiDCoMKgICdvcjFrLXNvZnRtbXUnLA0KPiAr
wqAgIyAncHBjLXNvZnRtbXUnLA0KPiArwqAgIyAncHBjNjQtc29mdG1tdScsDQo+ICvCoCAjICdy
aXNjdjMyLXNvZnRtbXUnLA0KPiDCoMKgICdyaXNjdjY0LXNvZnRtbXUnLA0KPiDCoMKgICdyeC1z
b2Z0bW11JywNCj4gK8KgICMgJ3MzOTB4LXNvZnRtbXUnLA0KPiArwqAgIyAnc2g0LXNvZnRtbXUn
LA0KPiArwqAgIyAnc2g0ZWItc29mdG1tdScsDQo+ICvCoCAjICdzcGFyYy1zb2Z0bW11JywNCj4g
K8KgICMgJ3NwYXJjNjQtc29mdG1tdScsDQo+IMKgwqAgJ3RyaWNvcmUtc29mdG1tdScsDQo+ICvC
oCAjICd4ODZfNjQtc29mdG1tdScsDQo+ICvCoCAjICd4dGVuc2Etc29mdG1tdScsDQo+ICvCoCAj
ICd4dGVuc2FlYi1zb2Z0bW11JywNCj4gwqBdDQo+IMKgDQo+IMKgZW11bGF0b3JzID0ge30NCg==

