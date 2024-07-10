Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00632C3DA42
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2024 15:20:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRZ7S-0005Dl-Ic; Wed, 10 Jul 2024 11:20:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yuan1.liu@intel.com>)
 id 1sRZ7R-00059m-Di
 for qemu-devel@nongnu.org; Wed, 10 Jul 2024 11:20:33 -0400
Received: from mgamail.intel.com ([192.198.163.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yuan1.liu@intel.com>)
 id 1sRZ7D-00081Y-Af
 for qemu-devel@nongnu.org; Wed, 10 Jul 2024 11:20:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1720624819; x=1752160819;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=/CIwqVL1kugVrcM0ukFH9qDIUPQVNhPRjL2cKuUb0JA=;
 b=gP3GZNLw1KtOS0h5Qkg+SmD3fdlbf6S/UjapU2QrwS6ohShSD6mAxqym
 ztBhAik0g9mkx/XosdaZdioi+FmU3B4DNjUkDqaIA5GyoOx9Bc0WMBjE3
 TDUxf3yTqqjXzrz3LwlKyXrylHroj+54GFd8Y3xLitMSVIXPO9UgUf+2f
 wt/5AfDdYh6ZV7RGt6qcQyV4xvxkI7VvvBFEVI2akH6eJaFoXN05OxO2v
 wlApDW2ixIUpczStToTS3dWeOUqxGRxsNT8RplKMTmJXpEPcWeVkZxd+S
 DoReJFgxcdqBCeWobO5mRO/PWYVwqTB206PuoUqKKFYr9rKHyjWx5NOHl Q==;
X-CSE-ConnectionGUID: DRVqMoC1RFyE5zHb7NEU4A==
X-CSE-MsgGUID: 19LyBkG7R8+iwRgOijpXKg==
X-IronPort-AV: E=McAfee;i="6700,10204,11129"; a="17650826"
X-IronPort-AV: E=Sophos;i="6.09,198,1716274800"; d="scan'208";a="17650826"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Jul 2024 08:20:16 -0700
X-CSE-ConnectionGUID: 4fpIJxQWSpywFbj6B82pHA==
X-CSE-MsgGUID: trFwOjbpTfOf3cbAwYSNQA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,198,1716274800"; d="scan'208";a="53427530"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
 by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 10 Jul 2024 08:20:16 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 10 Jul 2024 08:20:15 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 10 Jul 2024 08:20:15 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 10 Jul 2024 08:20:15 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.43) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 10 Jul 2024 08:20:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dhz4veQ8E2MAHg5nAVakmUACHKNrv1K06903ds5y4/ULz3rM1ZUk2hhdwY3TwFuabYGRr8/uIHk7Z4E9o5Y4bEl+FpIP16VaSi1JSxI/7Z6HxRXZm4qeuIiWoCy/g8SD+hJrDJKdggfevT7t9fXfTQdD60ytjgE7gyhMc+diAxZFWqfLRfplnlhPqBQWHZ4HwQkF0Vhd43r1hwvraACbOKuMh0jug0yPgGTBUDLglhaREFIPk1tun0/hb0jxoQn1ttt/cJDjKRR9qMOYMG0V24NTOiC7RILxa3o+9EF4IYH3lTw6yBK6yfEnwDLknftiRqA1x2Y6Te2Ju69wvNh74A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JK2fbDic6e6YDSblbH4aeclqH4+7isV5sIyfUj04BxY=;
 b=WZxwPykLK1bwrSS8/FLmbiTI40zcvXcr58gIpwsokjhDbLGi1H/D7kNGdfJRZMWzEdu1X/f721CryWOt29EIu0TRpC1fNi4qcYXbsME6iEmqxyDEdHUVv+8ogJ/6K5Z7iDMJA3vswutmxoj0krsPMJzNU1WicVCf0SNcutsXpBc3t4OlIpmFcXQMjlUGfVaamghQQvuxrvquEcdZ1tMtrr33HPE3UNj01S/Dw1qA2wvnPaweCo1MlAWgcKsyabDDlaPGJFAwHcEoTQhW3nYdgfX9+Q/u81HYod4amCIGKIK0gpi3J9ID8OondsjzVX8EHA7q/BMYTRZ3Ig7KkbfZ2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB5941.namprd11.prod.outlook.com (2603:10b6:510:13d::20)
 by SJ0PR11MB4974.namprd11.prod.outlook.com (2603:10b6:a03:2d6::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.20; Wed, 10 Jul
 2024 15:20:03 +0000
Received: from PH7PR11MB5941.namprd11.prod.outlook.com
 ([fe80::2750:7e63:952:7f1d]) by PH7PR11MB5941.namprd11.prod.outlook.com
 ([fe80::2750:7e63:952:7f1d%7]) with mapi id 15.20.7741.033; Wed, 10 Jul 2024
 15:20:03 +0000
From: "Liu, Yuan1" <yuan1.liu@intel.com>
To: "Wang, Yichen" <yichen.wang@bytedance.com>, Paolo Bonzini
 <pbonzini@redhat.com>, =?iso-8859-1?Q?Daniel_P=2E_Berrang=E9?=
 <berrange@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 =?iso-8859-1?Q?Marc-Andr=E9_Lureau?= <marcandre.lureau@redhat.com>, "Thomas
 Huth" <thuth@redhat.com>, =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?=
 <philmd@linaro.org>, Peter Xu <peterx@redhat.com>, Fabiano Rosas
 <farosas@suse.de>, Eric Blake <eblake@redhat.com>, Markus Armbruster
 <armbru@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: Hao Xiang <hao.xiang@linux.dev>, "Zou, Nanhai" <nanhai.zou@intel.com>,
 "Ho-Ren (Jack) Chuang" <horenchuang@bytedance.com>, "Wang, Yichen"
 <yichen.wang@bytedance.com>, Bryan Zhang <bryan.zhang@bytedance.com>
Subject: RE: [PATCH v4 3/4] migration: Introduce 'qatzip' compression method
Thread-Topic: [PATCH v4 3/4] migration: Introduce 'qatzip' compression method
Thread-Index: AQHazwlNjY04RVg/xkaI4wxytkTamLHwBhng
Date: Wed, 10 Jul 2024 15:20:02 +0000
Message-ID: <PH7PR11MB5941B336F783BE9971EDDD6CA3A42@PH7PR11MB5941.namprd11.prod.outlook.com>
References: <20240705182901.48948-1-yichen.wang@bytedance.com>
 <20240705182901.48948-4-yichen.wang@bytedance.com>
In-Reply-To: <20240705182901.48948-4-yichen.wang@bytedance.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB5941:EE_|SJ0PR11MB4974:EE_
x-ms-office365-filtering-correlation-id: e7cd293d-7648-4b4b-c840-08dca0f3c559
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|7416014|376014|366016|38070700018|921020; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?p2UxcSMmFCThKkDBjOe5BNgeY6zSm8f1oMhZOZMNExIrasumjdP1/eOyD3?=
 =?iso-8859-1?Q?kqLPmjgbIz4hh0WREaGclh/buss6DWQafKwHcWjSg4zVT44Gr8Kj24VL8l?=
 =?iso-8859-1?Q?gIIjz2Njipc+Kq408C1W3zuSXQLjIwYypfzD7esbAfcf0S7jL5y6AuQon7?=
 =?iso-8859-1?Q?86WlXWNrEkzrNaGTCdPrdCVIUqs3lw35bQ460V8tEa79hguHgSV2xjI0MF?=
 =?iso-8859-1?Q?DJazE10liOuLyGQSNJKYFu32IL9xIUpDH4CkpnD0/wzEbgmKyKQiG12oYO?=
 =?iso-8859-1?Q?akiHsByeX4pTwp0R4t4mFpMYQAhNCJFixmuB4zs4SyLnF00BdumHbwqoRv?=
 =?iso-8859-1?Q?CFJVXvi9nVAp/MY5UYDV+xxN934MlyS/oVwH75R5YZyG5mfd4S3CBhFi2D?=
 =?iso-8859-1?Q?lZV3MsrACqBpdSCFAuZT6EaO5Eu1Hvc1d/YUqHY7B4Lf2Vy45JfDv9oHPx?=
 =?iso-8859-1?Q?ltnFVVZ3EqkARAXsyvzm4Ix2UfV0tMXm0lA59eOqLs+mTKrIdWCMP6fknb?=
 =?iso-8859-1?Q?Zabdu1dOZxJEJpZZdz3pb4aRsTSXOKqa13BnIpe33SCqDaeKjQucXd59We?=
 =?iso-8859-1?Q?qqT/6S/zPEqCRgkypJ61GEoRa/qa7leEAjrXvOn2WJdBwwoXAPkDbufa11?=
 =?iso-8859-1?Q?xeCL9jvoDBCgLLhkmOUzddTn5pyA4YGhVcV6ONoWOSHb9np7OS/51dM9NX?=
 =?iso-8859-1?Q?NcriHBOYY2Gf7OG4frT79SCVSmQ8Ptp75zdH0mqFTb9zQ7WTPLrVFXUhbW?=
 =?iso-8859-1?Q?f0fXHC1vrLmVi/y/L5okLBlWScfp7qveZfsuQQ40DHV1U9Df52vJDkt+QJ?=
 =?iso-8859-1?Q?X8xgDvlo+/GtHqKlOI+q+wnwQ9DoNUK1GdUqlE7M0HWPU0MhVilg08IVDK?=
 =?iso-8859-1?Q?Vi3PmARSUBydROxPtavvyhq3CzQmpYgWjhKLWU/LzCtV6ly2ucJ/jOk0cy?=
 =?iso-8859-1?Q?IXeV+Y81x4kAdOp801kd6n5g739ABzS7pN5xwBPBNbHwVhOakdxVI040sN?=
 =?iso-8859-1?Q?tBZXV8NyQxX05OJRcOtV/dLuyp3n9kKjW3L+ydQZwhmUrBd+3Qx1sMHhBN?=
 =?iso-8859-1?Q?RwSSFov6LIH2Kwr5AjJUeFbJB+X5KCcXodcyW5/ixZkMfQnZI8Uc3bjYXi?=
 =?iso-8859-1?Q?UufpLDBcn49beBTWKpH2YG/Frah98qTwbN8BMRkcNwB/TxF0maYxNkXcPE?=
 =?iso-8859-1?Q?HqNGNj+JZxRxpAB7dd6M1E6nW4Fya/ahUqW3GtalVSAD9QweiY5zr3Wb37?=
 =?iso-8859-1?Q?MfZV+bWM86VpdosQKpfFtY3JsSSMLZx+C0OGlY1UticRKzLSLT/jsM3NWL?=
 =?iso-8859-1?Q?AH2k2VPsiU8ZwSDKRvcyDX7DEb5os0UmezG3MqljoShH/l3kw5XqwwgCtK?=
 =?iso-8859-1?Q?5bDZdzUbM6v2dD1VZ+GptxFfFC7iEXXEmcvHeNRO6g1CBs/x1M7eG+J0bY?=
 =?iso-8859-1?Q?XzaB8FhnayPOWqxq?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR11MB5941.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700018)(921020);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?Q8J3mIXXwY32t0ZaV7Jy2Wqsn6JnBlYA5f623niQ5XkKAPX8PdpgAYx0e5?=
 =?iso-8859-1?Q?jZLyOcIQqASS4tl/KovpgbKFA9mc1z0d5xk0u0AN7QxMu9pgumKHO0VTHA?=
 =?iso-8859-1?Q?yioncDNE0a2NRHJZly/55K3CBBKXNckfO+QfueAfCjH7SCEG05aEpZ/4Ra?=
 =?iso-8859-1?Q?bwMQV0v0e/jUob33CLv63KemOycW2D37+lg1/8bHCyjM6ZPrJFZTI1/3CR?=
 =?iso-8859-1?Q?5NHjnCTkRy8VFCXKBEnLsH7O88/yobU9UENa6FwsmHkAAeRhC7Pn1NADY0?=
 =?iso-8859-1?Q?Ubws4pGc07LAlSsSmAcbi2vTKhs2PDeQx18wFayBQlyeX0z1cWp7+4rG16?=
 =?iso-8859-1?Q?z4tjckg63KNf+zIWiLAgYCpVEuLz0IXEt7cei4o6MExyU01N4g0g8CY7in?=
 =?iso-8859-1?Q?HI9yCYohARUTpJyckN6cLQf6f0LakTnpa3j36OXOW2H9Q2X0pQnE8LP3z6?=
 =?iso-8859-1?Q?jRiMzEFS3qgzp6EWpjmGFB63pe35a4bDK60soI7LszCEAsyXDD+/6aG7qE?=
 =?iso-8859-1?Q?SbOV7VYofiw24rA424gzIBWILn+Iv4goKF0y0PkWSgMjKkmGxtvLPpKBPj?=
 =?iso-8859-1?Q?OlCxVpd1HymWQ/IQnpvGyezlwhA4hVxoSjbY8bIjEKJAqQFxseLohZwF/Z?=
 =?iso-8859-1?Q?nOS6hy1GY4Q8WBmgxg3fbDDHs+k5FrKUBhL6CsqAiXGsSuirBlccnZfiz0?=
 =?iso-8859-1?Q?OaxZ67BcgRlvTSQNBqxI75l7IB/ewBn30QPiDW8e2AeOLI/Qr8DPGIhH1W?=
 =?iso-8859-1?Q?K9bYYT54tYgZ36IfRslMhg5O++GzbMXOzmuEFaAGRnxxNqAx1av3idF7Oc?=
 =?iso-8859-1?Q?rhSK9YYj7m5vol/jMlFED4SIemajs+XXCUcwIVMjN0POd+mQILHXyYYK9u?=
 =?iso-8859-1?Q?YA0o2F7R+eDCTaMtv89yZre/6y4smv87BjRJ1EVwqTIqAVryiJOvx8lwNR?=
 =?iso-8859-1?Q?2qp4w4kso+SEpKrCFryAyXBjpwwwkcq6h/rlhPoGFH0gsjLbDZjvNa0xeT?=
 =?iso-8859-1?Q?ybOM1OU9RRJUnBx2ZG75R6fsbQ2yV92ivW3ZtBBRV3sn6zzP38BRUKf2da?=
 =?iso-8859-1?Q?K3XJSYuJ/m2cOZYJ8WfK3bQxrX+kWDvjvSqHdFSW8a9aUf7o4eDOq4oZc1?=
 =?iso-8859-1?Q?NKDmSFbAlzgfa/EvLbO/X4p4HUUm8EL+6P9Y0dtURQyZujH6o50CsZ9yXO?=
 =?iso-8859-1?Q?4oHPAzW9WDz5EgCoSsTN2WSK6z5ohVO5vO61W/T+z6tVa8odyr2AfuOY+9?=
 =?iso-8859-1?Q?3tJRJ+HPe82BDCP9wnLh6duHydgXbNBw1zeNZgWKYyCGjelX1anXnPseD6?=
 =?iso-8859-1?Q?9rLGag1clzKscO5BzBOrAkona5ecs/U/WK5jE+d8xS5JgqtbSgZYxQW8va?=
 =?iso-8859-1?Q?9ZWQhMZx+KBNIGCuDS4RxOeAiBtdSqIrBvo6BUseHboKADlPJdo6Iyss0o?=
 =?iso-8859-1?Q?L0mZMMNVzuH21KeSKsag4s83hXPVS11nEplOsxt6+weoIBj0Lvih7PrtXV?=
 =?iso-8859-1?Q?X2G+LihbaHB3HuKD6I8yZo+5gFk/ppSbDxF4bW99LSbXm6QFSAf2XkhC7Y?=
 =?iso-8859-1?Q?ddt1GwmvAurqL0eE73ah2knhvhRBPMn46UUKaAUEfxTkfw00bKw5eGNekQ?=
 =?iso-8859-1?Q?NMudofnR4XT/jbxxMHZkI/BLkxGOidspgn?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5941.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7cd293d-7648-4b4b-c840-08dca0f3c559
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jul 2024 15:20:02.7723 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: txkpLV0Vno0pePz/GfSmUMxFpq/d/wnBi2OvKFsb655GR5MvX3kwFUY+wumFp7EPXXZ613rN984IzG/YVSvX9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4974
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.19; envelope-from=yuan1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

> -----Original Message-----
> From: Yichen Wang <yichen.wang@bytedance.com>
> Sent: Saturday, July 6, 2024 2:29 AM
> To: Paolo Bonzini <pbonzini@redhat.com>; Daniel P. Berrang=E9
> <berrange@redhat.com>; Eduardo Habkost <eduardo@habkost.net>; Marc-Andr=
=E9
> Lureau <marcandre.lureau@redhat.com>; Thomas Huth <thuth@redhat.com>;
> Philippe Mathieu-Daud=E9 <philmd@linaro.org>; Peter Xu <peterx@redhat.com=
>;
> Fabiano Rosas <farosas@suse.de>; Eric Blake <eblake@redhat.com>; Markus
> Armbruster <armbru@redhat.com>; Laurent Vivier <lvivier@redhat.com>; qemu=
-
> devel@nongnu.org
> Cc: Hao Xiang <hao.xiang@linux.dev>; Liu, Yuan1 <yuan1.liu@intel.com>;
> Zou, Nanhai <nanhai.zou@intel.com>; Ho-Ren (Jack) Chuang
> <horenchuang@bytedance.com>; Wang, Yichen <yichen.wang@bytedance.com>;
> Bryan Zhang <bryan.zhang@bytedance.com>
> Subject: [PATCH v4 3/4] migration: Introduce 'qatzip' compression method
>=20
> From: Bryan Zhang <bryan.zhang@bytedance.com>
>=20
> Adds support for 'qatzip' as an option for the multifd compression
> method parameter, and implements using QAT for 'qatzip' compression and
> decompression.
>=20
> Signed-off-by: Bryan Zhang <bryan.zhang@bytedance.com>
> Signed-off-by: Hao Xiang <hao.xiang@linux.dev>
> Signed-off-by: Yichen Wang <yichen.wang@bytedance.com>
> ---
>  hw/core/qdev-properties-system.c |   6 +-
>  migration/meson.build            |   1 +
>  migration/multifd-qatzip.c       | 391 +++++++++++++++++++++++++++++++
>  migration/multifd.h              |   5 +-
>  qapi/migration.json              |   3 +
>  tests/qtest/meson.build          |   4 +
>  6 files changed, 407 insertions(+), 3 deletions(-)
>  create mode 100644 migration/multifd-qatzip.c
>=20
> diff --git a/hw/core/qdev-properties-system.c b/hw/core/qdev-properties-
> system.c
> index f13350b4fb..eb50d6ec5b 100644
> --- a/hw/core/qdev-properties-system.c
> +++ b/hw/core/qdev-properties-system.c
> @@ -659,7 +659,11 @@ const PropertyInfo qdev_prop_fdc_drive_type =3D {
>  const PropertyInfo qdev_prop_multifd_compression =3D {
>      .name =3D "MultiFDCompression",
>      .description =3D "multifd_compression values, "
> -                   "none/zlib/zstd/qpl/uadk",
> +                   "none/zlib/zstd/qpl/uadk"
> +#ifdef CONFIG_QATZIP
> +                   "/qatzip"
> +#endif
> +                   ,
>      .enum_table =3D &MultiFDCompression_lookup,
>      .get =3D qdev_propinfo_get_enum,
>      .set =3D qdev_propinfo_set_enum,
> diff --git a/migration/meson.build b/migration/meson.build
> index 5ce2acb41e..c9454c26ae 100644
> --- a/migration/meson.build
> +++ b/migration/meson.build
> @@ -41,6 +41,7 @@ system_ss.add(when: rdma, if_true: files('rdma.c'))
>  system_ss.add(when: zstd, if_true: files('multifd-zstd.c'))
>  system_ss.add(when: qpl, if_true: files('multifd-qpl.c'))
>  system_ss.add(when: uadk, if_true: files('multifd-uadk.c'))
> +system_ss.add(when: qatzip, if_true: files('multifd-qatzip.c'))
>=20
>  specific_ss.add(when: 'CONFIG_SYSTEM_ONLY',
>                  if_true: files('ram.c',
> diff --git a/migration/multifd-qatzip.c b/migration/multifd-qatzip.c
> new file mode 100644
> index 0000000000..a1502a5589
> --- /dev/null
> +++ b/migration/multifd-qatzip.c
> @@ -0,0 +1,391 @@
> +/*
> + * Multifd QATzip compression implementation
> + *
> + * Copyright (c) Bytedance
> + *
> + * Authors:
> + *  Bryan Zhang <bryan.zhang@bytedance.com>
> + *  Hao Xiang <hao.xiang@bytedance.com>
> + *  Yichen Wang <yichen.wang@bytedance.com>
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or
> later.
> + * See the COPYING file in the top-level directory.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "exec/ramblock.h"
> +#include "exec/target_page.h"
> +#include "qapi/error.h"
> +#include "migration.h"
> +#include "options.h"
> +#include "multifd.h"
> +#include <qatzip.h>

"exec/target_page.h" may not required

use "qapi/qapi-types-migration.h" to instead "migration.h"

> +struct qatzip_data {
> +    /*
> +     * Unique session for use with QATzip API
> +     */
> +    QzSession_T sess;
> +
> +    /*
> +     * For compression: Buffer for pages to compress
> +     * For decompression: Buffer for data to decompress
> +     */
> +    uint8_t *in_buf;
> +    uint32_t in_len;
> +
> +    /*
> +     * For compression: Output buffer of compressed data
> +     * For decompression: Output buffer of decompressed data
> +     */
> +    uint8_t *out_buf;
> +    uint32_t out_len;
> +};

Add typedef and CamelCase name.
typedef struct QatzipData
https://www.qemu.org/docs/master/devel/style.html#comment-style

Typedefs are used to eliminate the redundant 'struct' keyword, since
type names have a different style than other identifiers=20
("CamelCase" versus "snake_case"). Each named struct type should have=20
a CamelCase name and a corresponding typedef.

> +/**
> + * qatzip_send_setup: Set up QATzip session and private buffers.
> + *
> + * @param p    Multifd channel params
> + * @param errp Pointer to error, which will be set in case of error
> + * @return     0 on success, -1 on error (and *errp will be set)
> + */
> +static int qatzip_send_setup(MultiFDSendParams *p, Error **errp)
> +{
> +    struct qatzip_data *q;
> +    QzSessionParamsDeflate_T params;
> +    const char *err_msg;
> +    int ret;
> +    int sw_fallback;
> +
> +    q =3D g_new0(struct qatzip_data, 1);
> +    p->compress_data =3D q;
> +    /* We need one extra place for the packet header */
> +    p->iov =3D g_new0(struct iovec, 2);
> +
> +    sw_fallback =3D 0;
> +    if (migrate_multifd_qatzip_sw_fallback()) {
> +        sw_fallback =3D 1;
> +    }
> +
> +    ret =3D qzInit(&q->sess, sw_fallback);
> +    if (ret !=3D QZ_OK && ret !=3D QZ_DUPLICATE) {
> +        err_msg =3D "qzInit failed";
> +        goto err_free_q;
> +    }
> +
> +    ret =3D qzGetDefaultsDeflate(&params);
> +    if (ret !=3D QZ_OK) {
> +        err_msg =3D "qzGetDefaultsDeflate failed";
> +        goto err_close;
> +    }
> +
> +    /* Make sure to use configured QATzip compression level. */
> +    params.common_params.comp_lvl =3D migrate_multifd_qatzip_level();
> +
> +    ret =3D qzSetupSessionDeflate(&q->sess, &params);
> +    if (ret !=3D QZ_OK && ret !=3D QZ_DUPLICATE) {
> +        err_msg =3D "qzSetupSessionDeflate failed";
> +        goto err_close;
> +    }
> +
> +    /* TODO Add support for larger packets. */
> +    if (MULTIFD_PACKET_SIZE > UINT32_MAX) {
> +        err_msg =3D "packet size too large for QAT";
> +        goto err_close;
> +    }
> +
> +    q->in_len =3D MULTIFD_PACKET_SIZE;
> +    q->in_buf =3D qzMalloc(q->in_len, 0, PINNED_MEM);
> +    if (!q->in_buf) {
> +        err_msg =3D "qzMalloc failed";
> +        goto err_close;
> +    }
> +
> +    q->out_len =3D qzMaxCompressedLength(MULTIFD_PACKET_SIZE, &q->sess);
> +    q->out_buf =3D qzMalloc(q->out_len, 0, PINNED_MEM);
> +    if (!q->out_buf) {
> +        err_msg =3D "qzMalloc failed";
> +        goto err_free_inbuf;
> +    }
> +
> +    return 0;
> +
> +err_free_inbuf:
> +    qzFree(q->in_buf);
> +err_close:
> +    qzClose(&q->sess);
> +err_free_q:
> +    g_free(q);

There might be risks here.

The p->compress_data may have a wild pointer, need to add=20
p->compress_data =3D NULL Or move p->compress_data =3D q before
the return 0.

> +    g_free(p->iov);
> +    p->iov =3D NULL;
> +    error_setg(errp, "multifd %u: %s", p->id, err_msg);
> +    return -1;
> +}
> +
> +/**
> + * qatzip_send_cleanup: Tear down QATzip session and release private
> buffers.
> + *
> + * @param p    Multifd channel params
> + * @param errp Pointer to error, which will be set in case of error
> + * @return     None
> + */
> +static void qatzip_send_cleanup(MultiFDSendParams *p, Error **errp)
> +{
> +    struct qatzip_data *q =3D p->compress_data;
> +    const char *err_msg;
> +    int ret;
> +
> +    ret =3D qzTeardownSession(&q->sess);
> +    if (ret !=3D QZ_OK) {
> +        err_msg =3D "qzTeardownSession failed";
> +        goto err;
> +    }
> +
> +    ret =3D qzClose(&q->sess);
> +    if (ret !=3D QZ_OK) {
> +        err_msg =3D "qzClose failed";
> +        goto err;
> +    }
> +
> +    qzFree(q->in_buf);
> +    q->in_buf =3D NULL;
> +    qzFree(q->out_buf);
> +    q->out_buf =3D NULL;
> +    g_free(p->iov);
> +    p->iov =3D NULL;
> +    g_free(p->compress_data);
> +    p->compress_data =3D NULL;
> +    return;
> +
> +err:
> +    error_setg(errp, "multifd %u: %s", p->id, err_msg);
> +}
> +
> +/**
> + * qatzip_send_prepare: Compress pages and update IO channel info.
> + *
> + * @param p    Multifd channel params
> + * @param errp Pointer to error, which will be set in case of error
> + * @return     0 on success, -1 on error (and *errp will be set)
> + */
> +static int qatzip_send_prepare(MultiFDSendParams *p, Error **errp)
> +{
> +    MultiFDPages_t *pages =3D p->pages;
> +    struct qatzip_data *q =3D p->compress_data;
> +    int ret;
> +    unsigned int in_len, out_len;
> +
> +    if (!multifd_send_prepare_common(p)) {
> +        goto out;
> +    }
> +
> +    /* memcpy all the pages into one buffer. */
> +    for (int i =3D 0; i < pages->normal_num; i++) {
> +        memcpy(q->in_buf + (i * p->page_size),
> +               p->pages->block->host + pages->offset[i],
> +               p->page_size);
> +    }
> +
> +    in_len =3D pages->normal_num * p->page_size;
> +    if (in_len > q->in_len) {
> +        error_setg(errp, "multifd %u: unexpectedly large input", p->id);
> +        return -1;
> +    }
> +    out_len =3D q->out_len;
> +
> +    /*
> +     * Unlike other multifd compression implementations, we use a non-
> streaming
> +     * API and place all the data into one buffer, rather than sending
> each page
> +     * to the compression API at a time. Based on initial benchmarks, th=
e
> +     * non-streaming API outperforms the streaming API. Plus, the logic
> in QEMU
> +     * is friendly to using the non-streaming API anyway. If either of
> these
> +     * statements becomes no longer true, we can revisit adding a
> streaming
> +     * implementation.
> +     */
> +    ret =3D qzCompress(&q->sess, q->in_buf, &in_len, q->out_buf, &out_le=
n,
> 1);
> +    if (ret !=3D QZ_OK) {
> +        error_setg(errp, "multifd %u: QATzip returned %d instead of
> QZ_OK",
> +                   p->id, ret);
> +        return -1;
> +    }
> +    if (in_len !=3D pages->normal_num * p->page_size) {
> +        error_setg(errp, "multifd %u: QATzip failed to compress all
> input",
> +                   p->id);
> +        return -1;
> +    }
> +
> +    p->iov[p->iovs_num].iov_base =3D q->out_buf;
> +    p->iov[p->iovs_num].iov_len =3D out_len;
> +    p->iovs_num++;
> +    p->next_packet_size =3D out_len;
> +
> +out:
> +    p->flags |=3D MULTIFD_FLAG_QATZIP;
> +    multifd_send_fill_packet(p);
> +    return 0;
> +}
> +
> +/**
> + * qatzip_recv_setup: Set up QATzip session and allocate private buffers=
.
> + *
> + * @param p    Multifd channel params
> + * @param errp Pointer to error, which will be set in case of error
> + * @return     0 on success, -1 on error (and *errp will be set)
> + */
> +static int qatzip_recv_setup(MultiFDRecvParams *p, Error **errp)
> +{
> +    struct qatzip_data *q;
> +    QzSessionParamsDeflate_T params;
> +    const char *err_msg;
> +    int ret;
> +    int sw_fallback;
> +
> +    q =3D g_new0(struct qatzip_data, 1);
> +    p->compress_data =3D q;
> +
> +    sw_fallback =3D 0;
> +    if (migrate_multifd_qatzip_sw_fallback()) {
> +        sw_fallback =3D 1;
> +    }
> +
> +    ret =3D qzInit(&q->sess, sw_fallback);
> +    if (ret !=3D QZ_OK && ret !=3D QZ_DUPLICATE) {
> +        err_msg =3D "qzInit failed";
> +        goto err_free_q;
> +    }
> +
> +    ret =3D qzGetDefaultsDeflate(&params);
> +    if (ret !=3D QZ_OK) {
> +        err_msg =3D "qzGetDefaultsDeflate failed";
> +        goto err_close;
> +    }
> +
> +    /* Make sure to use configured QATzip compression level. */
> +    params.common_params.comp_lvl =3D migrate_multifd_qatzip_level();

There is no need to set the compression level for decompression.

> +    ret =3D qzSetupSessionDeflate(&q->sess, &params);
> +    if (ret !=3D QZ_OK && ret !=3D QZ_DUPLICATE) {
> +        err_msg =3D "qzSetupSessionDeflate failed";
> +        goto err_close;
> +    }
> +
> +    /*
> +     * Mimic multifd-zlib, which reserves extra space for the
> +     * incoming packet.
> +     */
> +    q->in_len =3D MULTIFD_PACKET_SIZE * 2;

I don't quite understand why MULTIFD_PACKET_SIZE * 2 lengths are needed her=
e.

> +    q->in_buf =3D qzMalloc(q->in_len, 0, PINNED_MEM);
> +    if (!q->in_buf) {
> +        err_msg =3D "qzMalloc failed";
> +        goto err_close;
> +    }
> +
> +    q->out_len =3D MULTIFD_PACKET_SIZE;
> +    q->out_buf =3D qzMalloc(q->out_len, 0, PINNED_MEM);
> +    if (!q->out_buf) {
> +        err_msg =3D "qzMalloc failed";
> +        goto err_free_inbuf;
> +    }
> +
> +    return 0;
> +
> +err_free_inbuf:
> +    qzFree(q->in_buf);
> +err_close:
> +    qzClose(&q->sess);
> +err_free_q:
> +    g_free(q);

Ditto

> +    error_setg(errp, "multifd %u: %s", p->id, err_msg);
> +    return -1;
> +}
> +
> +/**
> + * qatzip_recv_cleanup: Tear down QATzip session and release private
> buffers.
> + *
> + * @param p    Multifd channel params
> + * @return     None
> + */
> +static void qatzip_recv_cleanup(MultiFDRecvParams *p)
> +{
> +    struct qatzip_data *q =3D p->compress_data;
> +
> +    /* Ignoring return values here due to function signature. */
> +    qzTeardownSession(&q->sess);
> +    qzClose(&q->sess);
> +    qzFree(q->in_buf);
> +    qzFree(q->out_buf);
> +    g_free(p->compress_data);
> +}
> +
> +
> +/**
> + * qatzip_recv: Decompress pages and copy them to the appropriate
> + * locations.
> + *
> + * @param p    Multifd channel params
> + * @param errp Pointer to error, which will be set in case of error
> + * @return     0 on success, -1 on error (and *errp will be set)
> + */
> +static int qatzip_recv(MultiFDRecvParams *p, Error **errp)
> +{
> +    struct qatzip_data *q =3D p->compress_data;
> +    int ret;
> +    unsigned int in_len, out_len;
> +    uint32_t in_size =3D p->next_packet_size;
> +    uint32_t expected_size =3D p->normal_num * p->page_size;
> +    uint32_t flags =3D p->flags & MULTIFD_FLAG_COMPRESSION_MASK;
> +
> +    if (in_size > q->in_len) {
> +        error_setg(errp, "multifd %u: received unexpectedly large
> packet",
> +                   p->id);
> +        return -1;
> +    }
> +
> +    if (flags !=3D MULTIFD_FLAG_QATZIP) {
> +        error_setg(errp, "multifd %u: flags received %x flags
> expected %x",
> +                   p->id, flags, MULTIFD_FLAG_QATZIP);
> +        return -1;
> +    }

The zero-page processing missing here
    multifd_recv_zero_page_process(p);

    if (!p->normal_num) {
        assert(in_size =3D=3D 0);
        return 0;
    }

> +    ret =3D qio_channel_read_all(p->c, (void *)q->in_buf, in_size, errp)=
;
> +    if (ret !=3D 0) {
> +        return ret;
> +    }
> +
> +    in_len =3D in_size;
> +    out_len =3D q->out_len;
> +    ret =3D qzDecompress(&q->sess, q->in_buf, &in_len, q->out_buf,
> &out_len);
> +    if (ret !=3D QZ_OK) {
> +        error_setg(errp, "multifd %u: qzDecompress failed", p->id);
> +        return -1;
> +    }
> +    if (out_len !=3D expected_size) {
> +        error_setg(errp, "multifd %u: packet size received %u size
> expected %u",
> +                   p->id, out_len, expected_size);
> +        return -1;
> +    }
> +
> +    /* Copy each page to its appropriate location. */
> +    for (int i =3D 0; i < p->normal_num; i++) {
> +        memcpy(p->host + p->normal[i],
> +               q->out_buf + p->page_size * i,
> +               p->page_size);
> +    }
> +    return 0;
> +}
> +
> +static MultiFDMethods multifd_qatzip_ops =3D {
> +    .send_setup =3D qatzip_send_setup,
> +    .send_cleanup =3D qatzip_send_cleanup,
> +    .send_prepare =3D qatzip_send_prepare,
> +    .recv_setup =3D qatzip_recv_setup,
> +    .recv_cleanup =3D qatzip_recv_cleanup,
> +    .recv =3D qatzip_recv
> +};
> +
> +static void multifd_qatzip_register(void)
> +{
> +    multifd_register_ops(MULTIFD_COMPRESSION_QATZIP,
> &multifd_qatzip_ops);
> +}
> +
> +migration_init(multifd_qatzip_register);
> diff --git a/migration/multifd.h b/migration/multifd.h
> index 0ecd6f47d7..adceb65050 100644
> --- a/migration/multifd.h
> +++ b/migration/multifd.h
> @@ -34,14 +34,15 @@ MultiFDRecvData *multifd_get_recv_data(void);
>  /* Multifd Compression flags */
>  #define MULTIFD_FLAG_SYNC (1 << 0)
>=20
> -/* We reserve 4 bits for compression methods */
> -#define MULTIFD_FLAG_COMPRESSION_MASK (0xf << 1)
> +/* We reserve 5 bits for compression methods */
> +#define MULTIFD_FLAG_COMPRESSION_MASK (0x1f << 1)
>  /* we need to be compatible. Before compression value was 0 */
>  #define MULTIFD_FLAG_NOCOMP (0 << 1)
>  #define MULTIFD_FLAG_ZLIB (1 << 1)
>  #define MULTIFD_FLAG_ZSTD (2 << 1)
>  #define MULTIFD_FLAG_QPL (4 << 1)
>  #define MULTIFD_FLAG_UADK (8 << 1)
> +#define MULTIFD_FLAG_QATZIP (16 << 1)
>=20
>  /* This value needs to be a multiple of qemu_target_page_size() */
>  #define MULTIFD_PACKET_SIZE (512 * 1024)
> diff --git a/qapi/migration.json b/qapi/migration.json
> index 8c9f2a8aa7..ea62f983b1 100644
> --- a/qapi/migration.json
> +++ b/qapi/migration.json
> @@ -558,6 +558,8 @@
>  #
>  # @zstd: use zstd compression method.
>  #
> +# @qatzip: use qatzip compression method. (Since 9.1)
> +#
>  # @qpl: use qpl compression method.  Query Processing Library(qpl) is
>  #       based on the deflate compression algorithm and use the Intel
>  #       In-Memory Analytics Accelerator(IAA) accelerated compression
> @@ -570,6 +572,7 @@
>  { 'enum': 'MultiFDCompression',
>    'data': [ 'none', 'zlib',
>              { 'name': 'zstd', 'if': 'CONFIG_ZSTD' },
> +            { 'name': 'qatzip', 'if': 'CONFIG_QATZIP'},
>              { 'name': 'qpl', 'if': 'CONFIG_QPL' },
>              { 'name': 'uadk', 'if': 'CONFIG_UADK' } ] }
>=20
> diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
> index 12792948ff..23e46144d7 100644
> --- a/tests/qtest/meson.build
> +++ b/tests/qtest/meson.build
> @@ -324,6 +324,10 @@ if gnutls.found()
>    endif
>  endif
>=20
> +if qatzip.found()
> +  migration_files +=3D [qatzip]
> +endif
> +
>  qtests =3D {
>    'bios-tables-test': [io, 'boot-sector.c', 'acpi-utils.c', 'tpm-emu.c']=
,
>    'cdrom-test': files('boot-sector.c'),
> --
> Yichen Wang


