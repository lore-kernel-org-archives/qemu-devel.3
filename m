Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EC03CA9EC5
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2026 06:15:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xG9JJ-0000ul-3d; Mon, 12 Oct 2026 02:14:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1xG9JI-0000uB-1U
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 02:14:56 -0400
Received: from mgamail.intel.com ([198.175.65.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1xG9JF-00040q-UA
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 02:14:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791785694; x=1823321694;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=GGNyGHJ6cUoqNhkr4xBKqB+qFZ4rGSRI3xpFdSxj5Go=;
 b=GkxlBtPSx53iXzjrX6Q5JjcT3NIXqy5V/syBRXQAvDcd1jyx+fuqwyUk
 qncZvuTVfK1ZiXWEvdC0Cx29CaU5ZeIPCh95qrndDfx5yxfYz5SzKGBwJ
 vT9Gnful+8++/Gsc/CK0ZbEeLOmj+rRgd+a4VDKfs0Y/T/j4iH6qlhUFL
 8aXeEkvFgxXdGnMQdMEkWEhDCNL7qBaBZ0Mg53LnDWG61Mik0k7bxFfZv
 ypZIa9avnbBCak4SKw5a8mwxBkOFK61Chf6kO7rhl7NNE1qEeKNDUEX7+
 7TZNQjXCGwY+RP6D1D8zMTTgGITzfK+V3d9KJDtHdf2KvwEfBsWZRG1eI Q==;
X-CSE-ConnectionGUID: fTsgHr3sTQuLan8D+JvsNA==
X-CSE-MsgGUID: IVaGp4EjRaOBDTHkObzVBg==
X-IronPort-AV: E=McAfee;i="6800,10657,11932"; a="488745"
X-IronPort-AV: E=Sophos;i="6.27,153,1787036400"; 
   d="scan'208";a="488745"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Oct 2026 23:14:50 -0700
X-CSE-ConnectionGUID: KbXhafqnTaya4/LchCtcWQ==
X-CSE-MsgGUID: jOOoHnwERqWlThNKwxz0wA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,153,1787036400"; 
   d="scan'208";a="2619573"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa012.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Oct 2026 23:14:49 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Sun, 11 Oct 2026 23:14:49 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Sun, 11 Oct 2026 23:14:49 -0700
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.22) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Sun, 11 Oct 2026 23:14:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=shrEFi9X0EkLVvs4dehbitu18vIPYZeXbTltOmo1IGOmSwDQ7UHnjEw4R47lDqx59EaLryCjVd2ZWKEgvfqyWDSZHTdJWBWpeKIWCw8I/BidVPZrurEIbeSNeCKVnpACZd3WLVcD2qZ2U8EhqTOFG4TBUc2x4d1PSTAqhcMvoKaViiqg7KS5UwGgqebIitXYMbZQ/zO3gqrbXIm9pPDjGkFHhJwfSlc00iUmlJuxX9VWl4dAtMuslW9QSaJs+WgGPBOhFt3GsIMJOl58d1Ua3OmebATY6Pqk0LIi859FiZnySiLSohSeCNTTAczpjezA95Q+EvPb2W4gugWsPg6XUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KdyjMjwsJvOADN2P97Hb/SPOMBvOj7dutzI27Tr0qvc=;
 b=ivTDljvqEqNLoRs9DNQhEWXONwLh+HqYoSboR9Sl6k4Hnq8APmDEgj9jHJCX6YszxsSnfjDwPqF4SDOwCrByN0whmCa/4SMiJMLanD50XVwc/sBwo4lU8dru0v4dKUJj+ebAubBJYVufGZOUuXVsO9+h/4kO3tFx1BxqjWUJtnYVFySmD9nNs8gOVJwPIY5jHh0WybO3snPEQ8kLT6QcpXMTjlkFKHcIHS1kAsTfa1rJN5LSuhiDqg4/AaLTDSCTPJHXBWuqSn3DNgHNbS2EQU0ckgilgk73Vv/ReJd4nFEhnS1W5rVQ6DLlevjujgXrqP+htUTvuJf9pY8Kmokxkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA0PR11MB7185.namprd11.prod.outlook.com (2603:10b6:208:432::20)
 by IA1PR11MB6076.namprd11.prod.outlook.com (2603:10b6:208:3d4::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.20; Mon, 12 Oct
 2026 06:14:45 +0000
Received: from IA0PR11MB7185.namprd11.prod.outlook.com
 ([fe80::9f37:cb81:5463:300e]) by IA0PR11MB7185.namprd11.prod.outlook.com
 ([fe80::9f37:cb81:5463:300e%4]) with mapi id 15.21.0496.010; Mon, 12 Oct 2026
 06:14:45 +0000
From: "Kasireddy, Vivek" <vivek.kasireddy@intel.com>
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: =?iso-8859-1?Q?Marc-Andr=E9_Lureau?= <marcandre.lureau@redhat.com>,
 =?iso-8859-1?Q?Alex_Benn=E9e?= <alex.bennee@linaro.org>, Dmitry Osipenko
 <dmitry.osipenko@collabora.com>, Alex Williamson <alex@shazbot.org>,
 =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@redhat.com>
Subject: RE: [PATCH v13 9/9] virtio-gpu-dmabuf: Create dmabuf for blobs
 associated with VFIO devices
Thread-Topic: [PATCH v13 9/9] virtio-gpu-dmabuf: Create dmabuf for blobs
 associated with VFIO devices
Thread-Index: AQHdVphjmjD/24Tm10GKCqp8WfcGzLbzXLIAgACjmZCAAPn1AIAD/qBA
Date: Mon, 12 Oct 2026 06:14:45 +0000
Message-ID: <IA0PR11MB7185E449EA1B948028DCD31EF89F2@IA0PR11MB7185.namprd11.prod.outlook.com>
References: <20261007201222.648687-1-vivek.kasireddy@intel.com>
 <20261007201222.648687-10-vivek.kasireddy@intel.com>
 <b87b6288-4226-442e-8802-d9bf31f5a7dd@rsg.ci.i.u-tokyo.ac.jp>
 <IA0PR11MB71857E6DC18C3B4B74CE235EF8922@IA0PR11MB7185.namprd11.prod.outlook.com>
 <7bd99ac0-b126-43b4-870a-9211914a9701@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <7bd99ac0-b126-43b4-870a-9211914a9701@rsg.ci.i.u-tokyo.ac.jp>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PR11MB7185:EE_|IA1PR11MB6076:EE_
x-ms-office365-filtering-correlation-id: 3e45a8b8-5c78-411e-cccc-08df28281cc4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|23010399003|38070700021|56012099006|5023799004|11063799006|4143699003|261009223027099003|10067099003|18002099003|22082099003|6133799003;
x-microsoft-antispam-message-info: n5xHpESBcdOkNl3XyvWdDansTXB/BqOHkpMlLKkCVbe2ylnsCW3Q85/ocX2zd8d6VHLGX0nOBzjHlVKq+6gBgPNBHsgKnTGr3+sIC5zYHn/lWpm6qYRtI0zcMIKKnScvIAmqpBH4EUf/KNSZMFZRJrYl8b+Yxc5DeEUCkQlV6YegFRgZIoDfMm+CsqbxLUJXJgM3PywyhL4S9UyTSiDyuOYqcSeaaphndkowvSb230gFr3tvgqELiVdPrWi2ejbhnuQSTUES/qPqXQODDyzSkW3tquafzaVZNk8VyOr9JiUt63o44oW0LZ49g2Ye/Zwrz+W0wwZMpPwBrf3AWnKY/qhdzjk03ERki+rPOzyl+6TbIn6oqZS6hwQfQlaTAJ13fZuuFgHB7PMvD7Nt4SB/5sBcec48r9B82NYOlq1p/GVKEmq/2yn24eS3KXOBsaMyuWfrWkxWzBV8EspluzDLz5ihwskSM473BRCp9Ujm5ZODoqqw58haFOjcoTmmWb2nHK1Vflv0h4LHe1tf5DlHzexQAyXQ36TyEj+iD9GcZGfCk3uZIdsvA3KcKTBrwgLOGOluR/dgmgyO/yEPXMqivR/RLrLbruHBXLhJ0YrJnyboCYOeg7UCcPVIIdIqZbQm8wXqSwzi0xLJNDyeCpAdJCkZ6doNEu/Ld4FZhds4YRG64MGvXsZlSUGTK+nUWcztrm+USOnySB8f40XpGpELz0YT47PW5rqGuGnGT6PKrrU=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR11MB7185.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(38070700021)(56012099006)(5023799004)(11063799006)(4143699003)(261009223027099003)(10067099003)(18002099003)(22082099003)(6133799003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?LVOF4xzbagsnmMxGry5WeBtBFMa4i7KLR0Q8VxvaOwSw6eTUpK+CRPHZnQ?=
 =?iso-8859-1?Q?sprU9zJq3oVbBkRKfHBt3l2GViO7DwPjDyJ7yhaIFObMlhKzJ90f0jTg+V?=
 =?iso-8859-1?Q?MPNCeWlyxHjZa1HauQCHwlr8PEvIy411pXMNAfwXWY6fFgeLCl7wW4B2lm?=
 =?iso-8859-1?Q?9FQhBx6tUWDnJfwUA4jDjE6vUh13TtX74S+czSQHn+T88rRa/LegJk+hLb?=
 =?iso-8859-1?Q?cJvfIAeQhH/IVmeUFzJgcQZtuzGImdqkVlPnhwTyPcas0Hd3xM5SW7eF/8?=
 =?iso-8859-1?Q?coLm78VuQuvi//HCxmPoVPJ1edKTuMakhg1C18NL+XZvGs+L/X0EYTkh1L?=
 =?iso-8859-1?Q?Z1Fr5WLdDBwbYZTx2Gq36DUzgYOMod0IfaCvaFFHngthqBG2pomLBkzCZv?=
 =?iso-8859-1?Q?ua+f7gEUBdrwYNb0vN7eklFCiUE/rdceWv+DUXyBAAt7Y53O6nyGwlil7l?=
 =?iso-8859-1?Q?AAgNf3imbS7Yg05+Iq+FA2unmEbCEEOH9YKbNkQkuY29+jFdEEbillhcew?=
 =?iso-8859-1?Q?SuJLJEzgudtEsqVB4Zb/W8xnv8awosdFsrBzZbDvBmnf0rYUB213iTc39u?=
 =?iso-8859-1?Q?eyPl+Jj0lr6FamGP5OSS/ekfXMU5d4INdfpppxqKpaN319JPsiy+61vrqj?=
 =?iso-8859-1?Q?jnIBmCohD230j/LFJSj3HfHFIOk+FaKg2YhZbyagL8SOux41P3eqlRtm+d?=
 =?iso-8859-1?Q?WD17GhK22xKMxRHJV3suHyeedS6glcY6VgNe3D3sux8OGnditQzdxk4g4j?=
 =?iso-8859-1?Q?ia3DcmRbK/bUnFrf/BMU5aYbmMrVatDzwIftNLPWn/O7jwX1E7gS9gfqCk?=
 =?iso-8859-1?Q?CqyQRz1L351T6+OL+ZJHgkTTLcRomwM8hZMP8DpjlT+a2SdCiANJ/71jyc?=
 =?iso-8859-1?Q?fOZlakuZOJDLGVY9P/JX2h1+swHnUybo/7NOm2yhad/GaMdtKHmlZNHQK0?=
 =?iso-8859-1?Q?NxJt5kNVE8298j1+rZrEE0UZ9BCmj4nH459inLNDIVeemFbUMen+pStt5g?=
 =?iso-8859-1?Q?/wVVvXAPA3S3RYB/H+K7kJBc5RKoki1m4rv/lNOM7yh7cq/RG8okIPPENX?=
 =?iso-8859-1?Q?xrEbbt0DQZRQwWPFAf4ly/CdrYgyTQyuLMMuWmaxI0Y8GDU6ZkyWubZP+E?=
 =?iso-8859-1?Q?ozM7GZD5Zi0l+B/LNdfJt+SyANHVJ7GEpYRHRUswUaMNNl1TA333P32x2c?=
 =?iso-8859-1?Q?r4MD3cWnjG/taQ2UlcqjnfhXLf8kxpbG1vF6kGPBi/4ZEG8RM7SLBIXMZI?=
 =?iso-8859-1?Q?tfmK1Uzpl7z6Ft63pewNBcw69Lo/Ha4x7LoETGeWNDkPWHhUMpAzdaNLtT?=
 =?iso-8859-1?Q?aHrZSJByvWgjOULPgV8C78ue9yb19hmHfrwQO1YExZ6pFJvYXi8z5qTFgS?=
 =?iso-8859-1?Q?lpn69os6AkZoRRzkPSj7WdxGZkg0V+MViGOtf6hV7goHhc2yhXmoEIpojV?=
 =?iso-8859-1?Q?nr6tWS+SAIlevcqg2t2HqrtSa65sJSSAtirMOuCkBWjQ9Tp3DCn6gkn+3c?=
 =?iso-8859-1?Q?5DP+/ZCX7fGgzS38YTjMOTD8IZemv/xmMGyisG1jR6xrgBL7cQOg3Yu/pB?=
 =?iso-8859-1?Q?f58itOS2veHqtHzzRXgpYeihamuRA+aYt+KrCFfnhyo7r+1A5orr6gm4Th?=
 =?iso-8859-1?Q?v7Awl7LrC7kw4IXOEKj9lPKczM4xDpF/H9KR9lzGBr71QibjCqfRQZ3Dg/?=
 =?iso-8859-1?Q?QPHKaVpH2FKE6qwr89gNb6htcqA6gtYvQI6b2ZFDk7xxND33qNQE8iJvSy?=
 =?iso-8859-1?Q?m4R2BAEq1X60Dv+dggxcM7wxg88R9Wa2WLTaZ1P0NsguKdfBGtCJFcXHJH?=
 =?iso-8859-1?Q?CV0EAAVKDw=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: yFtGi4Azej1d9fcU3HyxUT32/2n2EVMVi2EnKVFFdylfpJ6Y3C3SyGzTGZBMy2S+wHpP+N+4TLigyDN0bh7LPqzJ2VxgIorj2/JL0YmgIuvYbjxLegkpSg+m0ISmXx2/J4n7Eh2ya9qTfTJsZ0Z77RTVO9DkB0Pcmp4YuvtDyuSdKoG+xZd90/Qslbj17W+bEmOTLPtjQPkaHD7h9B4Xhifo/TC1cTfNnEe4u3Cc/FXIUtcUK+Eeuhegm7XNYRInDyB0qWY3BeYQql2Z+f5nA+3hxDGt/MSCEz4vKztH09U4AwMIQI4LyoPJl3dWS/g8LdqzqY47Fy7cYk+J2k0lMQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA0PR11MB7185.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e45a8b8-5c78-411e-cccc-08df28281cc4
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Oct 2026 06:14:45.5937 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: z32+EsHY6/kdFTbgfDlbXEaNIBUXMNnYjS4yAGe9q9B43V32Y0e6vJMnO4l0CgMrZcqkm1367OaLggD7IJhWZWddkpCCVOf4jkA7SsGGHPU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6076
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.18;
 envelope-from=vivek.kasireddy@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

Hi Akihiko,

> Subject: Re: [PATCH v13 9/9] virtio-gpu-dmabuf: Create dmabuf for blobs
> associated with VFIO devices
> >
> >>> In addition to memfd, a blob resource can also have its backing
> >>> storage in a VFIO device region. Since, there is no effective way
> >>> to determine where the backing storage is located, we first try to
> >>> create a dmabuf assuming it is in memfd. If that fails, we try to
> >>> create a dmabuf assuming it is in VFIO device region.
> >>>
> >>> So, we first call virtio_gpu_create_udmabuf() to check if the blob's
> >>> backing storage is located in a memfd or not. If it is not, we invoke
> >>> the vfio_device_create_dmabuf_fd() API which identifies the right
> >>> VFIO device and eventually creates a dmabuf fd.
> >>>
> >>> Note that, for mmapping the dmabuf, we directly call mmap() if the
> >>> dmabuf fd was created via virtio_gpu_create_udmabuf() since we
> >> know
> >>> that the udmabuf driver supports mmap(). However, if the dmabuf
> >> was
> >>> created via vfio_device_create_dmabuf_fd(), we use the
> >>> vfio_device_mmap_dmabuf() API to get a mapping for the dmabuf.
> >>>
> >>> Cc: Marc-Andr=E9 Lureau <marcandre.lureau@redhat.com>
> >>> Cc: Alex Benn=E9e <alex.bennee@linaro.org>
> >>> Cc: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
> >>> Cc: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> >>> Cc: Alex Williamson <alex@shazbot.org>
> >>> Cc: C=E9dric Le Goater <clg@redhat.com>
> >>> Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
> >>> Signed-off-by: Vivek Kasireddy <vivek.kasireddy@intel.com>
> >>> ---
> >>>    hw/display/virtio-gpu-dmabuf.c | 22 +++++++++++++++++++---
> >>>    1 file changed, 19 insertions(+), 3 deletions(-)
> >>>
> >>> diff --git a/hw/display/virtio-gpu-dmabuf.c b/hw/display/virtio-gpu-
> >> dmabuf.c
> >>> index c9de8e9ba3..f59a5e76ff 100644
> >>> --- a/hw/display/virtio-gpu-dmabuf.c
> >>> +++ b/hw/display/virtio-gpu-dmabuf.c
> >>> @@ -153,9 +153,25 @@ bool virtio_gpu_init_dmabuf(struct
> >> virtio_gpu_simple_resource *res)
> >>>            if (res->dmabuf_fd =3D=3D
> >> VFIO_DMABUF_CREATE_ERR_INVALID_IOV) {
> >>>                error_free_or_abort(&local_err);
> >>>
> >>> -            qemu_log_mask(LOG_GUEST_ERROR,
> >>> -                          "Cannot create dmabuf: incompatible memory=
\n");
> >>> -            return false;
> >>> +            res->dmabuf_fd =3D vfio_device_create_dmabuf_fd(res->iov=
,
> >>> +                                                          res->iov_c=
nt,
> >>> +                                                          &local_err=
);
> >>> +            if (res->dmabuf_fd =3D=3D
> >> VFIO_DMABUF_CREATE_ERR_INVALID_IOV) {
> >>> +                error_free_or_abort(&local_err);
> >>> +                qemu_log_mask(LOG_GUEST_ERROR,
> >>> +                              "Cannot create dmabuf: incompatible me=
mory\n");
> >>> +                return false;
> >>> +            }
> >>> +
> >>> +            if (res->dmabuf_fd >=3D 0) {
> >>> +                pdata =3D vfio_device_mmap_dmabuf(res->iov, res->iov=
_cnt,
> >>> +                                                &local_err);
> >>
> >> This maps the complete IOV size, while virtio_gpu_fini_dmabuf()
> >> unmaps
> >> only blob_size. Create and attach accept backing larger than the blob,
> >> so excess pages remain mapped after detach, unref or reset.
> > Good catch. I'll add a check in virtio_gpu_fini_dmabuf() to determine i=
f
> > IOV size > blob_size, then do munmap(res->remapped, IOV size);
> > I think this should be safe even if the mapping (created with mmap)
> > size is blob_size. Or, is there a better solution you can think of such=
 as
> > tracking the exact mapping size in res object?
>=20
> Unmapping the IOV size is not safe if only blob_size was mapped:
> munmap() can also remove unrelated mappings in the excess range.
Ok, got it.

>=20
> A cleaner fix is to update vfio_device_mmap_dmabuf() to take the size to
> map (or cap it to blob_size).
Currently, vfio_device_mmap_dmabuf() creates an IOV sized mapping, so it
is going to need extra logic to cap it to blob_size, which needs to be expl=
icitly
passed in. So, are you ok with this given that you previously did not like =
the
idea of passing in blob_size as a parameter?

Thanks,
Vivek

> This keeps it symmetric with the udmabuf
> path and allows virtio_gpu_fini_dmabuf() to continue unmapping
> blob_size
> without needing extra tracking variables.
>=20
> Regards,
> Akihiko Odaki
>=20
> >
> > Thanks,
> > Vivek
> >>
> >> Regards,
> >> Akihiko Odaki
> >>
> >>> +                if (!pdata) {
> >>> +                    virtio_gpu_fini_dmabuf(res);
> >>> +                }
> >>> +            } else {
> >>> +                res->dmabuf_fd =3D -1;
> >>> +            }
> >>>            } else if (res->dmabuf_fd >=3D 0) {
> >>>                pdata =3D virtio_gpu_remap_dmabuf(res, &local_err);
> >>>                if (!pdata) {
> >


