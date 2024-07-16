Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20204C3DA4B
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2024 01:26:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTWwy-0000YL-KX; Mon, 15 Jul 2024 21:25:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yuan1.liu@intel.com>)
 id 1sTWwt-0000VW-08
 for qemu-devel@nongnu.org; Mon, 15 Jul 2024 21:25:47 -0400
Received: from mgamail.intel.com ([192.198.163.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yuan1.liu@intel.com>)
 id 1sTWwr-0007J0-0B
 for qemu-devel@nongnu.org; Mon, 15 Jul 2024 21:25:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1721093145; x=1752629145;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=eJ9OHWvxJRySBV+tUXp+HBZwzHe0f9Q8SCFsYASMQ5g=;
 b=LgzAMO91TGLr4NOjjEuZLcRcC3MLjmUe1hBfxLF0P1Bh9m1VuH18Fjhx
 NyNVgTEIJemVHfipI5/ttGzq6xaMo33PavEJxKdrcxHSs2eyHQyyB5qlu
 7CmXdjnAnSqDXqXaMLM0j1icziyCN0qPAJQDtdciPzixl759B0hfqB++E
 UFmg3UFa37ar5cbfDumUDqTK7FzTCT6+8a1shL4hAk5fJYfmsT8TVN/KR
 F61TfFt9k2YPdvJlMvoTZ+tDuWzNbJk9f0MvtSERdLA7EAJa91w/0imys
 6reaTlPruVh9eY1X1d5MHEiT/UWEBs/hqjwxtSVG4FNDkZul30L/jEWT1 A==;
X-CSE-ConnectionGUID: nr6omtkPQ/O0I9W7ACtHtQ==
X-CSE-MsgGUID: fcQVmthzQguLldb2IVBb/w==
X-IronPort-AV: E=McAfee;i="6700,10204,11134"; a="18699865"
X-IronPort-AV: E=Sophos;i="6.09,211,1716274800"; d="scan'208";a="18699865"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Jul 2024 18:25:43 -0700
X-CSE-ConnectionGUID: OveXm0O5TQubxJNRQi34yQ==
X-CSE-MsgGUID: QpBRIuwhS260DJ0akMYS1g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,211,1716274800"; d="scan'208";a="73064092"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
 by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 15 Jul 2024 18:25:42 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 15 Jul 2024 18:25:42 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 15 Jul 2024 18:25:42 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.48) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 15 Jul 2024 18:25:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PPAfNaKDkgG86TJ9hDCUwoUZDIl8eeR9pEb7zbYd7ch6c9G3+R/64+woT9M0GfREtGXWOK1HIMCsXiqFAZ7hUYTaXuKpfOkSVn5wrzFGgVfet4z8lqT6VXMXdaTB4devRBwSDsbOFLy3MTxxm+iZ9iSYG7voHN+gktMEWzPtbes9tuWXA/zaIhIm1XXdTbo8SP/Tbc0pwWnQ0aa5Oz8QG6jwL+RfXD64abgA3OOIbEVwAVsSvUxJeW8Hh7W5W7w00x49aRFmRxMvdWrJRYlj1PAVeCsaY4AeFvNfGf1jmaApz45cEqlo39BtasUEdvioeZ3gv1pdazdZemrNP9Vk1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eJ9OHWvxJRySBV+tUXp+HBZwzHe0f9Q8SCFsYASMQ5g=;
 b=EmXjqQTs8I9jW3hOKrR1Vo9RztImmFcyFJkTWtq4DGPjXxrZ1JZpMTJFl17s2x5jozqKd1sqIGRlOWjJbGioh2p4e46H1T3Z+NEGpTOh6mOB4zP0ug4rPpvYnQUcgtzDdlWO0nyB5GSseempyqgFzZXclNMSuevwN3WP2ZjlTPHg0blPy7blKUDkuc5pi3QThvN1RjsoXyNj7zpYtCVS3/p/qPyU0OAOHppQzvBpJn0fdRF1DxL8weQkJKtnUaiDzYTc0sYmseIWLp/xcxS5pVltWTStVS0RJZQCLcd/rIwaBLx41T0JBTwltY02fx5p77nrsMsQ71DZwiXs1NevhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB5941.namprd11.prod.outlook.com (2603:10b6:510:13d::20)
 by CY8PR11MB7688.namprd11.prod.outlook.com (2603:10b6:930:75::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.22; Tue, 16 Jul
 2024 01:25:38 +0000
Received: from PH7PR11MB5941.namprd11.prod.outlook.com
 ([fe80::2750:7e63:952:7f1d]) by PH7PR11MB5941.namprd11.prod.outlook.com
 ([fe80::2750:7e63:952:7f1d%6]) with mapi id 15.20.7762.025; Tue, 16 Jul 2024
 01:25:38 +0000
From: "Liu, Yuan1" <yuan1.liu@intel.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: "Wang, Yichen" <yichen.wang@bytedance.com>, Paolo Bonzini
 <pbonzini@redhat.com>, =?iso-8859-1?Q?Marc-Andr=E9_Lureau?=
 <marcandre.lureau@redhat.com>, =?iso-8859-1?Q?Daniel_P=2E_Berrang=E9?=
 <berrange@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>, Peter Xu
 <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>, Eric Blake
 <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Cornelia Huck
 <cohuck@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "Hao
 Xiang" <hao.xiang@linux.dev>, "Kumar, Shivam" <shivam.kumar1@nutanix.com>,
 "Ho-Ren (Jack) Chuang" <horenchuang@bytedance.com>
Subject: RE: [PATCH v5 00/13] WIP: Use Intel DSA accelerator to offload zero
 page checking in multifd live migration.
Thread-Topic: [PATCH v5 00/13] WIP: Use Intel DSA accelerator to offload zero
 page checking in multifd live migration.
Thread-Index: AQHa09y4Qu9AOd5eTECcwvlNYUC9ULHyIXCAgAVUt7CAAEXVgIAAAUtwgAAldYCAAAW84IAADNgQgAAJ3oCAAJYlsA==
Date: Tue, 16 Jul 2024 01:25:38 +0000
Message-ID: <PH7PR11MB5941ABAC845844680F69D428A3A22@PH7PR11MB5941.namprd11.prod.outlook.com>
References: <20240711215244.19237-1-yichen.wang@bytedance.com>
 <20240711184131-mutt-send-email-mst@kernel.org>
 <PH7PR11MB594105D464F3A4C2C25F94FEA3A12@PH7PR11MB5941.namprd11.prod.outlook.com>
 <20240715081857-mutt-send-email-mst@kernel.org>
 <PH7PR11MB5941A453AC1A4B3A387475A7A3A12@PH7PR11MB5941.namprd11.prod.outlook.com>
 <20240715104015-mutt-send-email-mst@kernel.org>
 <PH7PR11MB59410B8B35F932AF55C8A243A3A12@PH7PR11MB5941.namprd11.prod.outlook.com>
 <PH7PR11MB5941FD211A0357828F1DA20CA3A12@PH7PR11MB5941.namprd11.prod.outlook.com>
 <20240715122009-mutt-send-email-mst@kernel.org>
In-Reply-To: <20240715122009-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB5941:EE_|CY8PR11MB7688:EE_
x-ms-office365-filtering-correlation-id: 276a951b-18d1-43fb-9531-08dca536335d
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|1800799024|366016|376014|38070700018; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?sYMET6vEIG+Jh2jglu+R3vU0bDEri3icASw+TEixprIMJiCUDnYQzX6fQo?=
 =?iso-8859-1?Q?rlKejy1+R3SI0+QSBQZ4oA33enB/In3vxNJkLHPgAqk9qlBqD5+Z84+mR/?=
 =?iso-8859-1?Q?3vu+aRpWclxJNwooPkMbjAr2I5Ap9nhk+XS62BPq1ONJiV0SInVQDctOLB?=
 =?iso-8859-1?Q?q1+isETVH1b6gBfEGvvV7/dqqcGULd3eaghRFP0dZ5KE9Hrh9GiuM1C3tH?=
 =?iso-8859-1?Q?0Jp5z6aX2dEaDBZ9X1UVJdOQZ0cidlfQrUSZVKr7tJlc1x873X+I2hVyOs?=
 =?iso-8859-1?Q?PZMUV4GtPy/cjaVHRCXvNKUVeuDW85Yk/UgyVh51uiuy7fhZTs1tDr9VSV?=
 =?iso-8859-1?Q?324FYnQE9ggEE5cm3nVjVcPkrCP6rqlnJzuLQlajaGSt5v/C/uiracCVGu?=
 =?iso-8859-1?Q?UqBuYzTsvfDbSRvZg5YP5bfaTVVasOBTjdMig03ZHVeIueqXlR/XDdZct2?=
 =?iso-8859-1?Q?NfCfwiVx7O+W1mAM19lTRLCRmNXvG+6qnssU7Vx+vIxrlmCqh8vw7I1GDJ?=
 =?iso-8859-1?Q?1wN8aC8xjRshn0NAZzEe7IY1uSkRyk8wbJd/14OuchEorq5fd6OBGma8Hf?=
 =?iso-8859-1?Q?sT8qLvuwA70aQ1g15JE7jIxqmKM9ypfzJ5Plu6xFRI0DkcmIVoa9S6vPiL?=
 =?iso-8859-1?Q?MlsSMJFMx17x3Ur9sE60OTdD/BREexh2mw3ualAcOEU5jte3f9XRAq2qFR?=
 =?iso-8859-1?Q?Qb/fItxhVFethDg3gSDXU8aHyvz6n96aEt2mdyQSiy/1nM3jp57P3HMPHJ?=
 =?iso-8859-1?Q?fmiZvTn/lsxc+CeHlz7DA8A69LBWYZGjREWq0AHVZmVf0kgDwq/p/vn0HV?=
 =?iso-8859-1?Q?9bmiNgVDW0NcrGcoaZdHbJ0wYuQCDU2FalhVT3HAQ+SAh9zA9kwFGX89Qv?=
 =?iso-8859-1?Q?e0dV/N/AM/e3zQPTJmKsbweCSUzEZ+DOxw78+zzn/UpLE1PZD/+611WLQ5?=
 =?iso-8859-1?Q?gupIQ0Mcp8d13e1y5a9fNosKVhTY+7yQvyFN3Lo1pDq5faJbSpBf4BGkF8?=
 =?iso-8859-1?Q?Q35fqbB8k6i7ll8eyA4v9hGST9pLPdNM6Vz/qhlFSrunJZCXdCOj9Aq20D?=
 =?iso-8859-1?Q?soVvZ3560U3A5JZZjQ0gu2vnpEzbHta5Z3bv4KjrPgWuT11cVj+tRmWEiq?=
 =?iso-8859-1?Q?nTxFKkosDMsGyJXIfKi8AMM+q8yL7n884hJpnJAEC6W0gAzovAjtT8yFmu?=
 =?iso-8859-1?Q?b6uLN+fN0h7fosvhek8+q7qXVpsTU/62//CWcnsWhZEL31WlqUhxGhPd+f?=
 =?iso-8859-1?Q?dTnZAn/56QBIEb/xTnmdZE0beur687SiDWvpiOZ9+e4xhNWx7cBQrYRpsk?=
 =?iso-8859-1?Q?0SR8eFEiGQ9SAES1jA/EUoYVUwVgwKyp3KOxV7H7C8tA1tEhM4BCdhNx/j?=
 =?iso-8859-1?Q?Og9PxUXX5R+WLK0uuLHNsLD8nkpn6KqRDsxphpOHCKmOiHV+jbh8W6FKOS?=
 =?iso-8859-1?Q?CTfQCXGvkXZv3l4SH+i8oEJ4hJvOKdqXB86k3A=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR11MB5941.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(1800799024)(366016)(376014)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?lliKc+dmKjZFT2ChSvImBAMuYMKiFlgDRGgQdUwBweOU/r6NT5wq2GzXxt?=
 =?iso-8859-1?Q?oPbArZ9kUYHtPe35iCX3Zy9Ke3dvEuOhDWGLvvDVlDChN86mfJq769uBsx?=
 =?iso-8859-1?Q?bN7Uc0PWycZ49Nv4wtlmhkqKVdJjqWh1EmabLdmos/i80jP3pbde+8lreY?=
 =?iso-8859-1?Q?4gwqAfevSZ3r1O/SJrdFyrneH4A1kNpahmQPbWgzhglvhGEKIaXLIkb4T+?=
 =?iso-8859-1?Q?M3odSk5/5SPjlgODPLr1FvzdMARJUVdtm+8KnF45gvPOnt56N7rBTGqirP?=
 =?iso-8859-1?Q?bEk9sxfQaKmPSpGKL2JG2MTSPZccheS5XBaGO3S1/6lllY/FZgM4DCudCM?=
 =?iso-8859-1?Q?qzJmKbRi6GQJvb7V/EbNySKjV0ApLfeLjo+RLeOWjm4HgP6frkqv/1Ycxf?=
 =?iso-8859-1?Q?MxIfWiSk3Eh1gl1O/0H2fMs75u43o7xFegqRq3NY6OuQ6Qjk7BXKKg6xVi?=
 =?iso-8859-1?Q?fwt8U4ajo8YtchdAnLR1BKGBBihbJVlph70NHVNAvRYdGaW7ECn1tz4WFP?=
 =?iso-8859-1?Q?dhvBL0W4zylPx4CSuRqou6TKHpTwxCYZbG4m9pAzNg5osP25L13mtBTzhe?=
 =?iso-8859-1?Q?3f3gjxIuJwGTRqGQM45beFLofKPJvkG2C+qGM59eKU10Vv+HgPJdph7hlv?=
 =?iso-8859-1?Q?o1V37rcowFdQcUyP+ItbOmG4xFohLYKcHQFX8CnJLFu9Vx/yvsfzYbzbaR?=
 =?iso-8859-1?Q?9JtTybPioKHfwm0ccbFjwBH0s0pTHIRyzew0LDrF7iUuDp7c75/xWzpVKt?=
 =?iso-8859-1?Q?k4WjuSwlzEdVZuD2ahNbEgwQVXWW8+SUI+k/6cknMlYMeU6sGaX/OAl+5f?=
 =?iso-8859-1?Q?bYHIM4hIs6DZGPKfjDq2vnrvgMd9TaQ2bpE+hS3oAU74tM9s3Wujlf1oC7?=
 =?iso-8859-1?Q?93q2uXjaKESvF9w0ceBdjxRhEH6Ualk6dvaUFLQPZs6XBDwGTabS49CzA2?=
 =?iso-8859-1?Q?7jLeGdrADk54isTm9/5DlNB9JtrSXxnKTXmOs5JXFBMmJ739xsqYYA3PMQ?=
 =?iso-8859-1?Q?kZOMXPo5p+/vt5J1/xTtnhy5tluvI/eIRfXTaYzALG8kJvxs+QRrecjqcQ?=
 =?iso-8859-1?Q?pF6Tt6ZbFVxvGlFO7N8whWUbWAa6MHUPTWdE8mYpssaOXoIpdXioFbNmrQ?=
 =?iso-8859-1?Q?ZrMe91XSQhMo3ZFq+Usv3tsuBxAvKI5pl6RcOLT9zeNvWVbc7bIlVqrTY6?=
 =?iso-8859-1?Q?2yF9+78w4MbjfaqVawcFgsX4xLWmbteeHHoRDeXlQ+2J80BckklaEaI2pg?=
 =?iso-8859-1?Q?2FcLI2SF7A6gkLCXcSOQvGAR9BBkFpomMzXpqpQK2IAJM++AivPhqD+mU0?=
 =?iso-8859-1?Q?Cy/a39YLznrDNoZ48tgHXKCuI41nj320qeyC12htC6bID7Dhy9eLTq94hf?=
 =?iso-8859-1?Q?5lQv60da0MvGy0/11/7GfpbLyTUIuikdjJZ07aaPBnU0tPGH3FzRBoq5b8?=
 =?iso-8859-1?Q?6BrWiNtnZCMSIIAPshYE8FTqw2JNQvU/5i/wXkSpYC2h3d63RuksWwjc3a?=
 =?iso-8859-1?Q?vASiL31RhOi2OL08/QZHOSEKfTTmnfoSzKA6TMngAduYBhofG6TjKW3hAB?=
 =?iso-8859-1?Q?wdRBGtsKQJ2o/AJPlgbhj3KR60lRzSz0YXMVLR5H+82SJoSDT68kCvcgGs?=
 =?iso-8859-1?Q?3UQCH2KqCVeBBOw+t9yCMcfTMy8o2qBcNA?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5941.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 276a951b-18d1-43fb-9531-08dca536335d
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jul 2024 01:25:38.7746 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vbHBVObJrDv8J62GNy86t6sn4sLVk65NckTH1DPemoJ75D2kaLjbyf4W4I9ZuGq2FzXlXabeserjBKrpNAuPVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7688
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.14; envelope-from=yuan1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

> -----Original Message-----
> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Tuesday, July 16, 2024 12:24 AM
> To: Liu, Yuan1 <yuan1.liu@intel.com>
> Cc: Wang, Yichen <yichen.wang@bytedance.com>; Paolo Bonzini
> <pbonzini@redhat.com>; Marc-Andr=E9 Lureau <marcandre.lureau@redhat.com>;
> Daniel P. Berrang=E9 <berrange@redhat.com>; Thomas Huth <thuth@redhat.com=
>;
> Philippe Mathieu-Daud=E9 <philmd@linaro.org>; Peter Xu <peterx@redhat.com=
>;
> Fabiano Rosas <farosas@suse.de>; Eric Blake <eblake@redhat.com>; Markus
> Armbruster <armbru@redhat.com>; Cornelia Huck <cohuck@redhat.com>; qemu-
> devel@nongnu.org; Hao Xiang <hao.xiang@linux.dev>; Kumar, Shivam
> <shivam.kumar1@nutanix.com>; Ho-Ren (Jack) Chuang
> <horenchuang@bytedance.com>
> Subject: Re: [PATCH v5 00/13] WIP: Use Intel DSA accelerator to offload
> zero page checking in multifd live migration.
>=20
> On Mon, Jul 15, 2024 at 03:57:42PM +0000, Liu, Yuan1 wrote:
> > > > > > > > > that is 23% total CPU usage savings.
> > > > > > > >
> > > > > > > >
> > > > > > > > Here the DSA was mostly idle.
> > > > > > > >
> > > > > > > > Sounds good but a question: what if several qemu instances
> are
> > > > > > > > migrated in parallel?
> > > > > > > >
> > > > > > > > Some accelerators tend to basically stall if several tasks
> > > > > > > > are trying to use them at the same time.
> > > > > > > >
> > > > > > > > Where is the boundary here?
> >
> > If I understand correctly, you are concerned that in some scenarios the
> > accelerator itself is the migration bottleneck, causing the migration
> performance
> > to be degraded.
> >
> > My understanding is to make full use of the accelerator bandwidth, and
> once
> > the accelerator is the bottleneck, it will fall back to zero-page
> detection
> > by the CPU.
> >
> > For example, when the enqcmd command returns an error which means the
> work queue
> > is full, then we can add some retry mechanisms or directly use CPU
> detection.
>=20
>=20
> How is it handled in your patch? If you just abort migration unless
> enqcmd succeeds then would that not be a bug, where loading the system
> leads to migraton failures?

Sorry for this, I have just started reviewing this patch. The content we
discussed before is only related to the DSA device itself and may not be
related to this patch's implementation. I will review the issue you mention=
ed
carefully. Thank you for your reminder.

> --
> MST


