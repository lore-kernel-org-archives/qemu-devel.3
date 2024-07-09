Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14E0CC3DA45
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2024 03:45:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sR1m1-0003uM-JX; Mon, 08 Jul 2024 23:44:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sR1lz-0003tB-46
 for qemu-devel@nongnu.org; Mon, 08 Jul 2024 23:44:11 -0400
Received: from mgamail.intel.com ([192.198.163.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sR1lw-00059j-Ve
 for qemu-devel@nongnu.org; Mon, 08 Jul 2024 23:44:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1720496649; x=1752032649;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=zzuZ3nca8GaFsizvkWFmgBEyMFzvz5wFpIs7sUcr6c0=;
 b=U9UK3ywqNdNfGt0teTg159UzM3x7FA41j0H4yIU5aLFG/HupZAEmcfFY
 GNQMm5eRsZF0SYOHNqleLglouEU+pbqq5EBWpRHlm9K0j+dWntwSa1C0H
 YQ8um5kEO26kUAiymaO2HZ3m7PZtNkUTJN5z4O2O7TTXuWKYlG8Zej+At
 OQk5e1bt1BpWEqORVCbDqI1srQn1CsQ95a+E9eIXoLY3Ithu4usZQyl9n
 u8YF2I8/zi8yzBo6K5eDra3x2YnRh+ta3i/j/w4EAC7Ej4YwNli6LCT42
 c+KrRagzn4ilcB+3BJt6hW7Jg8XnbOurwDzfsxvkPhrchW254tdjuT5wi g==;
X-CSE-ConnectionGUID: QWrXdz6vSuGLelhNylIdTw==
X-CSE-MsgGUID: mXhBpztXSwyYXKWEh/usDg==
X-IronPort-AV: E=McAfee;i="6700,10204,11127"; a="12443314"
X-IronPort-AV: E=Sophos;i="6.09,193,1716274800"; d="scan'208";a="12443314"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Jul 2024 20:44:03 -0700
X-CSE-ConnectionGUID: zblT4ppdSJm32kn9aj2ZsA==
X-CSE-MsgGUID: 66Wd7Wg2QqScoR3fDqm8WA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,193,1716274800"; d="scan'208";a="47477805"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
 by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 08 Jul 2024 20:44:03 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 8 Jul 2024 20:44:02 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 8 Jul 2024 20:44:02 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 8 Jul 2024 20:44:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sq8mG6VlnnuZv9r9Fpi0273e1jFji9nqFPOJDEU9Ja+WWc0lky4uOg0arY6xlon/9yW8fxQpahye2t/8dfxQu+ewNbyxFTwzdwwlM+6i2JkTBiXT9nx02mT1Cc3ge7vN7XkbugIcLNtKwwlzPAceSPJgiWd1nr9iQ7d9w+ejMIzHICKHadgNaGEoRU7V+CLrd8N/iPmdjhK9WY96AasXRK1CB0HPp/kLvgT/uFFiv5EZPtCR49sq/TRmrQQe8EgENTWJZp0ukBQ6D/d6RunVm7gAYsKxNTJEqqjRc9FEclV4gbmUVRWmmVKKgNmI6xksOuotsKlsNduQPc7Mz64X5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ly4/vEpdLtCvCX60QWVjut98xUP7VPB/JMVE7M8Ew48=;
 b=nMP14ranRrFT55/L+5uDKRntr2hLzT2BHsd3SeGrg2XwS1LuOjDo3aQ439VwUb988dTc2TUNqtJ3CQMgZcYMZzm6GJep7IjaUxGyzXHaWV+Sl3BLPFzf8XOqM6wrQdz6aHi2hYIw+96K+K+cz1vTIMtZvNaRr//S4jsTdv/LzDrb5AxLvglWl9EZE2NgYIc4e71iIcZrk+ABeE2ZqrYudO1/c0FthSVwdOZCt32eFWxMFpctQa7vU7y5vuofWuBuWxb7T1wGKBy3cZH3lObImB+h7v+Ba24pSYAzmMSBxBSra2YNred/Xsw29HvH6AUeTNxsrWOYQt8SlNIJTY7LfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by MW6PR11MB8410.namprd11.prod.outlook.com (2603:10b6:303:249::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.36; Tue, 9 Jul
 2024 03:43:54 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091%7]) with mapi id 15.20.7741.033; Tue, 9 Jul 2024
 03:43:53 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: Joao Martins <joao.m.martins@oracle.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "Liu, Yi L" <yi.l.liu@intel.com>, Eric Auger <eric.auger@redhat.com>, Alex
 Williamson <alex.williamson@redhat.com>, Cedric Le Goater <clg@redhat.com>,
 Jason Gunthorpe <jgg@nvidia.com>, Avihai Horon <avihaih@nvidia.com>
Subject: RE: [PATCH v3 01/10] vfio/iommufd: Don't fail to realize on
 IOMMU_GET_HW_INFO failure
Thread-Topic: [PATCH v3 01/10] vfio/iommufd: Don't fail to realize on
 IOMMU_GET_HW_INFO failure
Thread-Index: AQHa0UP9XaJW+V7HF0q1KSPPC08ne7HtvVgw
Date: Tue, 9 Jul 2024 03:43:53 +0000
Message-ID: <SJ0PR11MB67440E96F272F5D349023AEB92DB2@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20240708143420.16953-1-joao.m.martins@oracle.com>
 <20240708143420.16953-2-joao.m.martins@oracle.com>
In-Reply-To: <20240708143420.16953-2-joao.m.martins@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|MW6PR11MB8410:EE_
x-ms-office365-filtering-correlation-id: 42f06bdc-739a-46ae-7027-08dc9fc95a4e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?qooYidAH6/msy0axUWBzwaqEVXun1dyTBLfPtJ07hmGVd4TczfgRS+4RPVQK?=
 =?us-ascii?Q?c41+jd5owNAA2XJey62CVMyrXJcaMFVgmvGAZHSVXOe4O1GzDoe6nwbyuxVY?=
 =?us-ascii?Q?8zRVjbjVXjSSwPEPZ8IvHBVfc2YlYVIhH7c+dlGv9PUBk1zAhYWL2q3bP9US?=
 =?us-ascii?Q?Lum/OsTh/U/Y9u7RRz2CIng3amyI2xy1bYXyeoHTxoZZ/CCQLJERQM+zzNZN?=
 =?us-ascii?Q?c88lYw9Gj1yoz0ynSIN7Tg4BS27GCiF1rw7PuiawHKcsj0oVdE3h0djr0N2G?=
 =?us-ascii?Q?EjATRftYMyej1HSD/m9wHCmw2ySDuRuiYsXHLMKjIZnkSnIsD25Zujzo13Ea?=
 =?us-ascii?Q?6JaNiml+8+viaC+K1PP+s5psvdFApLKxA1unUO0U3rTYGDv8lVk5GhG6dJEL?=
 =?us-ascii?Q?1eCTSVRumlJDt0LtDGm8JrSPRDSXvLpIXoOdGNK7GrYfA7Y1l+cFp7phGTNy?=
 =?us-ascii?Q?4U9YfHMtw+TmgHNpbwOv7aMkGwWQFCvAfH10mgH51BYrPX3xOtZUkFjYcFwF?=
 =?us-ascii?Q?hWaUrm0+eaMQqwNzX/jvYrttG+IFpu1dVvYqpdWROc72n25WFBQr4epnlam/?=
 =?us-ascii?Q?3RBMbdqZqAP8bESbog+0QkqMwcvLDHYRPyZjqpd21q6wDjooimu6x1Q/Itcx?=
 =?us-ascii?Q?yX13BA0Go6TTMlH0XP8Y9lX0AiBgwEtme2cOuzbmHR1ExYwj2AtomhC2bOGr?=
 =?us-ascii?Q?di1ure9pAODu6OxGmXRBLINX5AwGcf1bo9XHon+2X4F3Rg364SV1Ob6JKtoX?=
 =?us-ascii?Q?V/LIZdB9U02YzgL2NSR6mRVOvSG+/s7CC3K7vF07H3CMhWqKmz4+24nuN064?=
 =?us-ascii?Q?B7TH4IxuXOolrwKn7yBweXMnq3nBFN3g99Cy2h52D3oAYwnUYmoifZD2qGWj?=
 =?us-ascii?Q?9kkj+xVUtdiwyTEFCg2zSyEd71f12qGYFJz8KRGCHbpeIQYjLfX3dTG6Xde/?=
 =?us-ascii?Q?DER82LMqVRPPWgjfrOqN4YA7tmmA0B2wa79YhIgu7pJtjcYtTX6CnI46tyGo?=
 =?us-ascii?Q?fyqH1Us4BTBk0pe/BrwCL/4zYmvmvvqS2pYU3z16JgKEDMLPi87AqataxAlI?=
 =?us-ascii?Q?fAWFEfWPxfWTRGZPNI3VpvbpO0yQm9ZS4kod0U2cNz6Y4dRRn0iXRNplEueA?=
 =?us-ascii?Q?+09hRXHf4k+FXzrQNhCB8krdYLsut6Jz6WLKRM6Gp6fMBnnSgnMtvK/2Y+0N?=
 =?us-ascii?Q?4ni7AWAV56tCOHBOUs08yiaFm3vlCt22d4Q0OjjiOaNdly8G2ePUMgihWW1R?=
 =?us-ascii?Q?0KqytQeDvGs3tx4XeDkAS77H4qtzqnNPstYTh2KOXL9xMFB46flvqRqhNXPs?=
 =?us-ascii?Q?D3NcI2Mf2nn9lMG9uoWz07uEMSwdYJHIHxv2Dj/AAdP1lLk3paHBwvlBh6mZ?=
 =?us-ascii?Q?CsuSIQvpa1EBGKOAldnGwbr1w9HlWF9tgPKZpXeAcyaUCWaRQw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?TsUmNerQxYWrwVArDqzNGGMqZpmkEL8xfUrHICm0R7azQlNgzdfQh6Ql2v2L?=
 =?us-ascii?Q?PA2av+EoxpBOl2hXTs7ShVPTIvLVbdxBW12sIncZLNaYOdmg2ABmcLAc6UBf?=
 =?us-ascii?Q?a4H/90U0zLMmmo/g+paLJUvNn8vyrFUIt+ascyYde24qzkUHvOeOGttMeDyH?=
 =?us-ascii?Q?Nh3elgOF0/mkC8BMvMmm9IV2HfVzMMeaA16KorWVFoIm3biRYQjnpmGR7sn2?=
 =?us-ascii?Q?VtbyqyH+1AZfJq3zvyfbzcMXeoymN/mB+3tTH6nk2dodogUueW5kmdO8XMdt?=
 =?us-ascii?Q?A/CWjnAdCy5L+z7U8voQDNbLsRL6TdF9W8objjKN59TfUzzKGcFpUY15pKeB?=
 =?us-ascii?Q?Q/4Jj780tl13/8WmAoH22m+o1nV2CE9yubaxe+nrxFacZzyB28S3Mw+oo5pV?=
 =?us-ascii?Q?UUJULSs79W8hMQIPkOjkPfxPBnn78ynTqsATFXFgzx4JspvFXVDyR8VzXaK4?=
 =?us-ascii?Q?s74tcc8KHc61YScvrWO0DVZZfB1UYBFNEYbsKfjalzZg1mN+BTMPVM9SDAQC?=
 =?us-ascii?Q?sR6MXDWunYF9DcQqleCNmPeZPj7DU2jsx8wPFlWYSeB+L0pS8gINiIqZhriV?=
 =?us-ascii?Q?WEvlbbxn403JBtwgpK8ll6jibMtvBW7pxqvOON5h/wddHN/2yAk9xzCo/V3e?=
 =?us-ascii?Q?1dYfn2JVodzIUT4yLgLbT2dsyMxEF6FjgW04XdhkN7hNfGocJWqnPO6FVxjK?=
 =?us-ascii?Q?CysDl60Ty8Z3LqdyUxRPzQgO/jkyA9M65Rm+oQZKboStrmvZumJe3xsJp3EA?=
 =?us-ascii?Q?ab2ARGgPe4YGTlNPf/JzJaQc8Asoz9iv1NnwV8BakB6dNvzZTVZpm4Jw3iAb?=
 =?us-ascii?Q?/35jdW+ywSCNu1xyFEyYCB6moEV7rgkirATX/r9QHeONLyhYxcTNM8J+rhyE?=
 =?us-ascii?Q?dqw+gSEYgEWcdAkUSpj6/q3/nG6q5uW5VCrk7pRqJJo8bcSQcbciaO1bpOn7?=
 =?us-ascii?Q?ekfOjZFtDVLm0/bQ3+jVJeBKTMYVFLqVv+BVbm294PeaumNIyBg/GRwM72L8?=
 =?us-ascii?Q?g8CXMpkEHHn3UbbGvVKBwRn6YuM9+FIPtDDffPcAF1syBqV+UwJAlPo7dnBw?=
 =?us-ascii?Q?Q5dGmTTJ/vAEuT2PIWmwoAuqtB0uQ7oe7QKp88OTBZBNkMARehTfvgjWzYXH?=
 =?us-ascii?Q?PYD+AD1Yz5U9UpdYM6k6vJdhp0dFKS7Kr6UWm3Qdbe3tGaxOphb2s7mc5y16?=
 =?us-ascii?Q?uoFvKAugoCznb9s0USyCMNDS4CLuPNBqzu7WklOVh7qulsaKf189ZKp0oxFG?=
 =?us-ascii?Q?uywBVr0J9wFwzongAVfOTTZAfaYyEZGJh7p36cKcSEH5muG6aQQ+7Ww5nP1I?=
 =?us-ascii?Q?m6CVItNhZWroHVej4il1c0m8cTtqhCqEXgsEezPn+vgkH+sdBIFX9rxBoS1Z?=
 =?us-ascii?Q?3w4ZQwUhygnqsw+4vZUnt1aZBm2QSq63usDVoQ9fzXs/iZiHrrnxy3xU5w/V?=
 =?us-ascii?Q?drIOXYp+LovnOpIly9ZF1EconLGPpbvQ9CEdKnsboTmIbWJbpSkxUSr/X+oo?=
 =?us-ascii?Q?5Q8F8hx63x6qpBDGLMJMHLbO33jewdSR0hErmvJonfeE09u0ERjcOCmunDAN?=
 =?us-ascii?Q?XmtdKQt10R/soqzZZOskB7mVGBYkouETgF8QLHsv?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42f06bdc-739a-46ae-7027-08dc9fc95a4e
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jul 2024 03:43:53.2049 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jFrSm15CgEX9zu2lzGO0Ne6+xfHRv0YCO9nDn1K0NR22o0r7uTDRSH38cQ5oUj5V2FHfwULAE5u19Wkb4kwsv7+h5nEYdmx3R76FtQGPEt0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR11MB8410
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.16;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

Hi Joao,

>-----Original Message-----
>From: Joao Martins <joao.m.martins@oracle.com>
>Subject: [PATCH v3 01/10] vfio/iommufd: Don't fail to realize on
>IOMMU_GET_HW_INFO failure
>
>mdevs aren't "physical" devices and when asking for backing IOMMU info, it
>fails the entire provisioning of the guest. Fix that by filling caps info
>when IOMMU_GET_HW_INFO succeeds plus discarding the error we would
>get into
>iommufd_backend_get_device_info().
>
>Cc: Zhenzhong Duan <zhenzhong.duan@intel.com>
>Fixes: 930589520128 ("vfio/iommufd: Implement
>HostIOMMUDeviceClass::realize() handler")
>Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
>---
> hw/vfio/iommufd.c | 12 +++++-------
> 1 file changed, 5 insertions(+), 7 deletions(-)
>
>diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
>index c2f158e60386..a4d23f488b01 100644
>--- a/hw/vfio/iommufd.c
>+++ b/hw/vfio/iommufd.c
>@@ -631,15 +631,13 @@ static bool
>hiod_iommufd_vfio_realize(HostIOMMUDevice *hiod, void *opaque,
>
>     hiod->agent =3D opaque;
>
>-    if (!iommufd_backend_get_device_info(vdev->iommufd, vdev->devid,
>-                                         &type, &data, sizeof(data), errp=
)) {
>-        return false;
>+    if (iommufd_backend_get_device_info(vdev->iommufd, vdev->devid,
>+                                         &type, &data, sizeof(data), NULL=
)) {

This will make us miss the real error. What about bypassing host IOMMU devi=
ce
creation for mdev as it's not "physical device", passing corresponding host=
 IOMMU
device to vIOMMU make no sense.

Thanks
Zhenzhong

>+        hiod->name =3D g_strdup(vdev->name);
>+        caps->type =3D type;
>+        caps->aw_bits =3D vfio_device_get_aw_bits(vdev);
>     }
>
>-    hiod->name =3D g_strdup(vdev->name);
>-    caps->type =3D type;
>-    caps->aw_bits =3D vfio_device_get_aw_bits(vdev);
>-
>     return true;
> }
>
>--
>2.17.2


