Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEFF9CAC5B0
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Oct 2025 04:49:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v5zcy-0005PO-TW; Tue, 07 Oct 2025 00:48:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1v5zcx-0005PG-My
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 00:48:43 -0400
Received: from mgamail.intel.com ([192.198.163.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1v5zcu-00060y-7n
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 00:48:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1759812520; x=1791348520;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=GbVT5pZim2Uoes6mcHSR2c+TqCjE17p9yyXI7Lrrez0=;
 b=jzq2otRZZk9H3Wd3gNSOs/1oQWp95Vh2Zloz50fgXwqbIXqwMWIkEU50
 ubFiQDmb8lx9SxV7frY1ERmbkKQ/ZI/tXrX/N4qE39hR0Lai46vjW3j7U
 e5hdgFoJVxpwncCYXGqJ5+pSr/TkQONVh0GiTymJFTGgb7yxK68CYaABQ
 5Zbld20sRV1VNYOXiqircVIHZOE/pEgbhadje2ovGuVKTsQkuHxYVpS4W
 F6DiLKcZ7DXGaZ/2CWiBkvrPutTOyfg3nU5TGz1AYYEbhz5hcK8oHLr77
 PvEqraRmfVr2tDQ7KXsToCcFq40tWRNYNQobrFKXLQAmw6GymxgYafN5z g==;
X-CSE-ConnectionGUID: CxqPPOpMSjmRciAi/abdyg==
X-CSE-MsgGUID: i2f/EMERRA2u4zWGdIZ5Mw==
X-IronPort-AV: E=McAfee;i="6800,10657,11574"; a="61199312"
X-IronPort-AV: E=Sophos;i="6.18,321,1751266800"; d="scan'208";a="61199312"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Oct 2025 21:48:36 -0700
X-CSE-ConnectionGUID: ChrIBh3gTS+4LFv5jikvmg==
X-CSE-MsgGUID: ah+gZsAyTFG7FCyCSswCOw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,321,1751266800"; d="scan'208";a="184091590"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Oct 2025 21:48:36 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 6 Oct 2025 21:48:35 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Mon, 6 Oct 2025 21:48:35 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.58) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 6 Oct 2025 21:48:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W4EtjvcVOOQGQ7F9kgfcnlR2JAHKj0totL6P8NqHXWYpVBJf1DVAwR0aEJjpQHJE5TOKQ7a8aHGAE5OZ0iMYEEL98+XVbazyXUBPPhmBq8FP5weSk9eecYpZ0t5NPSuRhMSvLyrpm9CChmM1j0twiA5riQ5ykWXdNHY3myTbCrYKVf7TwVllGQqSTUK/iJNzeH9W99+Tn/bgh0hV1SYn9tOq0Nx3hAW5s1doXvOrNZRPJhhDWBlnNAQr7l7RyHUeisIGl7fglia05isGy5p7j+p0JeaUsSB5lrOiUo0XtQPZC9Mn5CFeN3CrxdN518nR4O2NvvTK8M+uGSTiXLn7UQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JYNldRM7BP0AQv+0zzstuuALkWt27LL+Iua8f6iQrV4=;
 b=Jnzds1KPDk6QDC8dngAtU7buZIJpcTSAcP11B/vIVEY2UHDoW2yyfVrhw4uoQyoMiM9QlkVfOrWjuC2nS2DqevgaGsBAS57grfbXkv6ZGm9VaF4xtc2KZY4TN4U3E/HJUbWdciefiSKT9gXPpyvS3/3DkQ+UjXqS5CkFhlAtPBahhuEk6zIDD6AoM6Fpj0CcokJoZDprm/LHUSCWWIEkdchSiBO5cuya5SVw37dJnCQ2EoJu8yX1Kxz6H4lJPBsyVTELzYmL11jJKh228jEu56TaDaWE86+j1C3pzE7zsr8JicioceCJ8Kq3Gy7iJqz0qZGU4AIl9mVO7ywcWseQjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA0PR11MB7185.namprd11.prod.outlook.com (2603:10b6:208:432::20)
 by SA1PR11MB6566.namprd11.prod.outlook.com (2603:10b6:806:251::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Tue, 7 Oct
 2025 04:48:24 +0000
Received: from IA0PR11MB7185.namprd11.prod.outlook.com
 ([fe80::dd3b:ce77:841a:722b]) by IA0PR11MB7185.namprd11.prod.outlook.com
 ([fe80::dd3b:ce77:841a:722b%4]) with mapi id 15.20.9182.017; Tue, 7 Oct 2025
 04:48:23 +0000
From: "Kasireddy, Vivek" <vivek.kasireddy@intel.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: Alex Williamson <alex.williamson@redhat.com>
Subject: RE: [PATCH v1 6/7] vfio/device: Add support for
 VFIO_DEVICE_FEATURE_DMA_BUF
Thread-Topic: [PATCH v1 6/7] vfio/device: Add support for
 VFIO_DEVICE_FEATURE_DMA_BUF
Thread-Index: AQHcNL+QY02u9plHPEuWLz8n51LAdLS0y6iAgAEtbkA=
Date: Tue, 7 Oct 2025 04:48:23 +0000
Message-ID: <IA0PR11MB71850D4E82F91AC1CAE70231F8E0A@IA0PR11MB7185.namprd11.prod.outlook.com>
References: <20251003234138.85820-1-vivek.kasireddy@intel.com>
 <20251003234138.85820-7-vivek.kasireddy@intel.com>
 <9f3e4af2-aa60-434b-8269-706696431882@redhat.com>
In-Reply-To: <9f3e4af2-aa60-434b-8269-706696431882@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PR11MB7185:EE_|SA1PR11MB6566:EE_
x-ms-office365-filtering-correlation-id: da0b9f67-438c-4772-9390-08de055cbf50
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700021;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?Y9pL6xWdaS8r53/vkXAa2Gk2PDktAQN6V/iH1de/bsrF0fxeEiXHvCScXV?=
 =?iso-8859-1?Q?YzRkIV7dBLgtUzCVYdSkXY0NmJV6z2yZ3t4rz+HlX8WdCB76Hxe3YL4rn+?=
 =?iso-8859-1?Q?HfvwpIE/+cWR2kzaWLnttqXSmpoBAYx1bQDZ7CzgXr3dtSCSh7nH4af3EL?=
 =?iso-8859-1?Q?H1pgclNzaxvFD8gZp2t/xwFoRTdXKd3VhgXO4zNqCuE2RENfrdkWaWzl8M?=
 =?iso-8859-1?Q?sUmU4gAf1xKWIOma/g/BaUA2LzSWccCYirFqWFcffGFBx7PnwVMwK3p0mX?=
 =?iso-8859-1?Q?TPirko4B6g6VA09R4As+txgLlxIKcc1XTY0yCaZsf9pS6FwMe0PGPBD2Dp?=
 =?iso-8859-1?Q?R1X4EQw0Kt5v12FwgzJr5oOMEPjl5l6V7gYxyNDwiouN1vByocRAkE1aoZ?=
 =?iso-8859-1?Q?ejbuTYNK3HRZdrozWQWA3pnMjlY9YkRAkWBurohgXXOMrKn+hJ9g6LHKUH?=
 =?iso-8859-1?Q?2FzH+W4bfT5gb6yJb1bW/sin2qrwfZ3pNlMndtLejN5lt0Y8CaxrGCaofN?=
 =?iso-8859-1?Q?Ornp6HhYGdX+Sd30uPGCNW7igHNZzbkY4KBOqz5d67BFNBRQUap1+di4Xv?=
 =?iso-8859-1?Q?iNIUXAlAC5GGsC7GNw8PL7rHoQmBeuS47XcNhIgRGqA3NWMYXUTNlOsHpd?=
 =?iso-8859-1?Q?irBHA2+apVXsKp4ycbnM2x54a3J56O4z56rU3rdeqrNNKgCRqPTnxqsfZi?=
 =?iso-8859-1?Q?lsNYHX9+OLPIJaUwdfc5QhPFWmX6Rxbhs3ZSbRSi7kZtSj3GNQ+TIDUwaf?=
 =?iso-8859-1?Q?gcsOJNbQVfk9Eg0bP2Ghjdlkx/TAUcxmem4C9lhIx9bUGmlZ0mQqqfMJvW?=
 =?iso-8859-1?Q?CY/lfckzqeasT52drXciCqWZ/lXUfpx38hoI7dRrfDl2y9RpmI1Eut+57C?=
 =?iso-8859-1?Q?ov8cUQdJtzyJUlnK+tmCS77DiuwKxRsay1+oNAFNY3zbaOcRqByieHao8e?=
 =?iso-8859-1?Q?ww1687fWUOokKoBREjPxQ6D0q5WxFn2iWN9I+YIhvs+CGnEt2DcB4vGjwD?=
 =?iso-8859-1?Q?oHLY1hxUmZb2vH+jKoWCuBCFi3htIKJGO6deiagbs243SOC+qS9YPC0Tip?=
 =?iso-8859-1?Q?erL8dw0XXcLSTSSv/YvMvyjRnBIGf/qu6pnDZm+FjCfIKynYSCrru7bFe9?=
 =?iso-8859-1?Q?X6Om3C+qrpaYEI0Lio8TJMovGR1r4s9leHq6M5nkSLnLy/8WR03EQKO/ny?=
 =?iso-8859-1?Q?AHbVfWQ6w4yqRRi547cbor5nWAJpGe9PL71lrjz3pR7pK6PWFRqN+9l3nO?=
 =?iso-8859-1?Q?SIde/QjPRIF2r2uiyqWjmEb6bRpuuzJBa2cU9ULt/2qUhvwvAH/LYMVGsc?=
 =?iso-8859-1?Q?LxoBdBOK9IKLBh7esriI+5l/NrADs86oPlSYidwrmX2Iks71F+haYFpkyC?=
 =?iso-8859-1?Q?ZAYBHmAjoaOJKFSfVq3hfPhcCwvqvPD6Q1p04Zux0rgULkM8O7hIQDLFl3?=
 =?iso-8859-1?Q?CPNIkbC2sntpD+YOfXSZpd4kLgL8gHjGup1TmS2bBiDFLU0bNNclP65fWP?=
 =?iso-8859-1?Q?lJnhK4xeOHEAGDsrZz39e/6GoimLxfwlOBgrQC4MDvUDO+dQUErZfTGmzk?=
 =?iso-8859-1?Q?7vIpgnujuFAoBK8JH1IxN1qUKOuJ?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR11MB7185.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?3DXtLqVVNCUJIvqys84Syfb7lI4gm6l/0mkGenNeuMkFIntLYqbZ2lwryU?=
 =?iso-8859-1?Q?rmEggHqy9JIcvn+MW4xOXeleWM+K8UhH7kLw8K3gd6DnKmt2djJTlL0Qrw?=
 =?iso-8859-1?Q?v7ih3IM6t1WpnullvTNBPmxJ0qkaOMMOqhnCGh0fsh+YWURNS+DFweDGQr?=
 =?iso-8859-1?Q?ymnPJcNavSzh0YeUjdg+aHQwSSlYOeWv3TkltABzHYg4ntwXKdjTEZGp6q?=
 =?iso-8859-1?Q?Wmp4TWs3cM8CAI8ZNGi/39WJZVjTvxO2ONw9bMcUj2hv7dThZMgxBfVxJg?=
 =?iso-8859-1?Q?9LoJqoU2/ihbfKXheooJJ1vzwRQfanX7KQl+oueIuaUzvLbyCJD0KUxLqm?=
 =?iso-8859-1?Q?WfOypE/hTc2T+wHah8AZhXtw0utDEQ7gXOXwYUmqCJjswRYZ5DzknjmaX2?=
 =?iso-8859-1?Q?LeNjhXjmPmxWKwKHu7lZeAJxad+VveIHzcD5ZQLzDkPHUrdH8NImzFb2IP?=
 =?iso-8859-1?Q?A3hXZLJIN6cY6Ybr9sZxvO5PdEe+qJhHGhjfx1rM7DsIB2AIDz9B0N4ook?=
 =?iso-8859-1?Q?fcQbfHM4m5L26gnz2gCDNibPau+V/rxNZyvzA1VSKNb/NbGE5N5pnwrpet?=
 =?iso-8859-1?Q?RseHC3e+KV1CqL51U1TofRMMVUOFmzbAAIfw/mUXe2fSHTj6EOZ4g6VloA?=
 =?iso-8859-1?Q?Es1+Tam8Gcq/3rss/WwtzP0TpcG8koBHeYYWRlnplTvLzey8OXb9HeJpq6?=
 =?iso-8859-1?Q?hKJg0Plx28Z7z8IZKDGRWzXuaJUrHLh74uifnFe5w/S95YI1N/xCtLYY/G?=
 =?iso-8859-1?Q?QAn8NHplEURJsHorSQHXgwYdp0/KS3ymF36uaDh1Vt5Np6Tjf+XwMPCrd6?=
 =?iso-8859-1?Q?8sBXdLbI/WmNXIu4/RmjruEIi4QkHLmL0sFNXid6NCRcYjZ56LA9HhqgtO?=
 =?iso-8859-1?Q?FHfpYv8CFpAC+0MYGp24egALf3RAZZ9ZpSyT22xaNhFKQZyntKgrkUdiPL?=
 =?iso-8859-1?Q?a9Ap3EO/zmZGhDHYlRFW6QVLKgDrWr0p7+qSctXz12Fesm8sx45DssBlvc?=
 =?iso-8859-1?Q?Ii0NsEQfkp1JdPgoNDWRl3PLFh/3d9ytWuOdCE6XAKDGjUYxmnK3ugVtWk?=
 =?iso-8859-1?Q?K+yLI2IulKQVJcH+M3uP5kuQTEz/5NhScNmniWvaKts5AyZM5HuaGY/IvC?=
 =?iso-8859-1?Q?xEJYO/BmurQxPl0EwAm1vQTFQ0NRGuussSxUuR9uiiVMXLV/InFIqxL7Dj?=
 =?iso-8859-1?Q?ZZI+XL5y8Dsm/5COq27JHtC78I/Noyr1147liMI14GgXDaM2vYpZASUq3T?=
 =?iso-8859-1?Q?vi/5h6R3GQdWjQSuB3I1evwi+NdABw+4dV6W7hdCkLCQc1umEM8H5Caqur?=
 =?iso-8859-1?Q?f7WzgPikbbMuuQMMTpuIV1t15aVLc3GWSX66mbB9JJ7rxsCFvgt+cDAnUO?=
 =?iso-8859-1?Q?rtT3j4AJNyAct26+xS+YrXuDEPtN72V9hgfATj+lW9gGVvFRWwOzkYS+Vo?=
 =?iso-8859-1?Q?bs9iBaMyf/qJ02bDRplIuj/HXdjCN5p2JVR1pMCaYtRlOn3eJjH0fZRnfB?=
 =?iso-8859-1?Q?OTbULQ7sCPsKWS0VfJBl8ibfRloJY1rEjhm60wna6KftK7EL4sMwvJf3FD?=
 =?iso-8859-1?Q?8ekfpwv5iaK/v6D7cd5Wrjol9xqxdg26fLXQuC2fv2sxa1s8mmeCYxakI6?=
 =?iso-8859-1?Q?b/OiH5d/qRHARUd6cR4LstVPKaSeAe0zVw?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA0PR11MB7185.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da0b9f67-438c-4772-9390-08de055cbf50
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Oct 2025 04:48:23.8000 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hoS9T9gPu8KmpxUS8NGv2oGidvlWFO7bNQhkomvoyYD/qiSS6TOUxNTD1lRifUex98Z4zy0mAwtsSuI3escgJJfQfAJYLJT+uorhODieDzQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6566
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.18;
 envelope-from=vivek.kasireddy@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.441,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Hi Cedric,

> Subject: Re: [PATCH v1 6/7] vfio/device: Add support for
> VFIO_DEVICE_FEATURE_DMA_BUF
>=20
> Hello Vivek,
>=20
> On 10/4/25 01:35, Vivek Kasireddy wrote:
> > In order to implement VFIO_DEVICE_FEATURE_DMA_BUF, we first need
> > to identify the VFIO region and index the buffer (represented by
> > iovec) belongs to and then translate its addresses to offsets
> > within that region.
> >
> > The qemu_ram_block_from_host() API gives us both the region and the
> > offset info we need to populate the dma ranges in order to invoke
> > this feature.
> >
> > Cc: Alex Williamson <alex.williamson@redhat.com>
> > Cc: C=E9dric Le Goater <clg@redhat.com>
> > Signed-off-by: Vivek Kasireddy <vivek.kasireddy@intel.com>
> > ---
> >   hw/vfio/device.c              | 43 ++++++++++++++++++++++++++++++++++=
+
> >   include/hw/vfio/vfio-device.h |  3 +++
> >   2 files changed, 46 insertions(+)
> >
> > diff --git a/hw/vfio/device.c b/hw/vfio/device.c
> > index 64f8750389..49070929ac 100644
> > --- a/hw/vfio/device.c
> > +++ b/hw/vfio/device.c
> > @@ -21,6 +21,7 @@
> >   #include "qemu/osdep.h"
> >   #include <sys/ioctl.h>
> >
> > +#include "system/ramblock.h"
> >   #include "hw/vfio/vfio-device.h"
> >   #include "hw/vfio/pci.h"
> >   #include "hw/hw.h"
> > @@ -592,3 +593,45 @@ static VFIODeviceIOOps vfio_device_io_ops_ioctl =
=3D
> {
> >       .region_read =3D vfio_device_io_region_read,
> >       .region_write =3D vfio_device_io_region_write,
> >   };
> > +
> > +int vfio_device_create_dmabuf(VFIODevice *vdev,
>=20
> a 'vbasedev' name is preferred for VFIODevice variables/parameters.
Ok, will make the change.

>=20
> > +                              struct iovec *iov, unsigned int iov_cnt)
> > +{
> > +    g_autofree struct vfio_device_feature *feature;
>=20
> g_autofree variables should be set: 'feature =3D NULL'
Ok, got it.=20

>=20
> > +    struct vfio_device_feature_dma_buf *dma_buf;
> > +    ram_addr_t offset;
> > +    RAMBlock *rb;
> > +    size_t argsz;
> > +    int i, index;
> > +
> > +    argsz =3D sizeof(*feature) + sizeof (*dma_buf) +
> > +            sizeof(struct vfio_region_dma_range) * iov_cnt;
> > +    feature =3D g_malloc0(argsz);
> > +    dma_buf =3D (struct vfio_device_feature_dma_buf *)feature->data;
> > +
> > +    for (i =3D 0; i < iov_cnt; i++) {
> > +        rcu_read_lock();
>=20
> Is it needed ?
Looks like it is indeed not needed. I'll remove it in the next version.

>=20
> > +        rb =3D qemu_ram_block_from_host(iov[i].iov_base, false, &offse=
t);
> > +        rcu_read_unlock();
> > +
> > +        if (!rb) {
> > +            return -1;
>=20
> wouldn't an errno be more appropriate ?
It would. I'll add it.

>=20
> > +        }
> > +
> > +        index =3D vfio_get_region_index_from_mr(rb->mr);
> > +        if (index < 0) {
> > +            return -1;
> > +        }
> > +
> > +        dma_buf->region_index =3D index;
> > +        dma_buf->dma_ranges[i].offset =3D offset;
> > +        dma_buf->dma_ranges[i].length =3D iov[i].iov_len;
> > +    }
> > +
> > +    dma_buf->nr_ranges =3D iov_cnt;
> > +    dma_buf->open_flags =3D O_RDONLY | O_CLOEXEC;
> > +    feature->argsz =3D argsz;
> > +    feature->flags =3D VFIO_DEVICE_FEATURE_GET |
> VFIO_DEVICE_FEATURE_DMA_BUF;
> > +
> > +    return ioctl(vdev->fd, VFIO_DEVICE_FEATURE, feature);
> Please use :
>=20
>     return vbasedev->io_ops->device_feature(vbasedev, feature);
>=20
> This would be returning an errno. Callers should be aware.
Makes sense and it seems a bit cleaner.

>=20
> > +}
> > diff --git a/include/hw/vfio/vfio-device.h b/include/hw/vfio/vfio-devic=
e.h
> > index bdb106c937..74b3c4eef7 100644
> > --- a/include/hw/vfio/vfio-device.h
> > +++ b/include/hw/vfio/vfio-device.h
> > @@ -279,6 +279,9 @@ int vfio_device_get_irq_info(VFIODevice *vbasedev,
> int index,
> >                                   struct vfio_irq_info *info);
> >
> >   int vfio_get_region_index_from_mr(MemoryRegion *mr);
> > +
> > +int vfio_device_create_dmabuf(VFIODevice *vbasedev,
> > +                              struct iovec *iov, unsigned int iov_cnt)=
;
>=20
>=20
> Since this is an external routine, please add documentation.
Will do.

Thanks,
Vivek

>=20
>=20
> Thanks,
>=20
> C.
>=20
>=20
> >   #endif
> >
> >   /* Returns 0 on success, or a negative errno. */


