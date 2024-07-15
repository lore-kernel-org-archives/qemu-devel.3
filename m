Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B76D2C3DA4A
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2024 15:58:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTO5S-0004fW-MV; Mon, 15 Jul 2024 11:58:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yuan1.liu@intel.com>)
 id 1sTO5P-0004cx-Nl
 for qemu-devel@nongnu.org; Mon, 15 Jul 2024 11:58:00 -0400
Received: from mgamail.intel.com ([192.198.163.8])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yuan1.liu@intel.com>)
 id 1sTO5M-0008Pc-OA
 for qemu-devel@nongnu.org; Mon, 15 Jul 2024 11:57:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1721059077; x=1752595077;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=zoVz0ZpR3ngi5DGWoKEB3DYnqzgyMDzCVPFTYLSgVjY=;
 b=anpCi4DbTafriwqNKISZBKHUv52BB6I6/GRWr04rbac16IcaTFUaqaKP
 jf3uKhgEfvLK0LofNN1CKpIWHSnT9knH37bRy/hDtF+X7V73FNeWu1jUt
 IjiuH9A9T8YoWC84/x7z1Clt5s8hkrEWZA9/SuEQFHA3MUyH6eDvi6nTR
 fusWkXVjl/RCF/XDA6t8lR7mPhrgCNrQ5ipvH0OW4qidmiZubwHeOqvBN
 olgfPhRDcs2IlPUfmTefXS0lKAXAePQjmdfI0g64nnBMzW/R0MrZzSnbg
 +ekZr0vu0Eom+GJuty33Q5C3Ci5la0nsOSj09OCfTnb5XOPA7KQYF+BjQ Q==;
X-CSE-ConnectionGUID: vwMIqeqJS6Cc7NmADiOgXA==
X-CSE-MsgGUID: i1y+ykroSfy/1GdcE6wqiQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11134"; a="35989808"
X-IronPort-AV: E=Sophos;i="6.09,210,1716274800"; d="scan'208";a="35989808"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Jul 2024 08:57:51 -0700
X-CSE-ConnectionGUID: hT1O3Q92Q7yNidK3vA6qhA==
X-CSE-MsgGUID: alvsuFeTQHKWnJoZ55gCDQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,210,1716274800"; d="scan'208";a="49555959"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
 by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 15 Jul 2024 08:57:51 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 15 Jul 2024 08:57:50 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 15 Jul 2024 08:57:50 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.40) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 15 Jul 2024 08:57:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZV6VcorGa6QluQROGIzNhuXIHeaAdb+Q6Uy2ituiAVWlEC2umAsrWtFxJxL1bQUiHqU9XWj+BuYDQUEEAy49qE9NjnK1NRc+1LPL9uRvsP+Sbx73B71yCGUWXXKwG2spkFGLUJnxYGfpTDIK/SM+5qZputMvnaKzGCiiCxNwruBbAwQbQOqAy4gkj9oHUKev3bCYRZq/yG06pPAbh4PiOnoEKzdnpkxhEGsl7fAhOuhYumSTnbterazCQMoNH4sgXOTtY/Z7mn8qPjtNWauhFDPdciMnS4WuqPp3u7I/dmqBFu1etbbWp6kX3MXPNy0Lzv4GzblXgPRnyOcm/ubBpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DDAjTlSUEyXsk727SstqeicLDbDT0LJADdMPjxudMes=;
 b=HS1B/FMN1Pb+DWviIB1N3AiNGnalidIhTeH/lVFTQH1Cx1FtC8T4qtZGjwjWZfYgL340ubYmoxsbx/Zj839+HmOh/uTNIsAeEUk02r7Wlblb6QTB2542yI8iXoKMaoRM5P57qCO1R16kixkPSHNs0Ajcl/AhCsWTTaiNqm1bpyrNf7pH31nUsUIDtAxH5XbV8L+5SS3uFnkEHOrWTbneajrESa80CBdNd6kCyhcJaaq/S2b1hAOcEVlXi6zG4QwLoC5Daldoi8PeeGQtDOudthfbj6tiE4uECOeL7o6oUoiemqhXljZ+/9p8ktLXQApIih64s2/Bh8MyRKe/Pd1Ylg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB5941.namprd11.prod.outlook.com (2603:10b6:510:13d::20)
 by IA0PR11MB8398.namprd11.prod.outlook.com (2603:10b6:208:487::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.28; Mon, 15 Jul
 2024 15:57:43 +0000
Received: from PH7PR11MB5941.namprd11.prod.outlook.com
 ([fe80::2750:7e63:952:7f1d]) by PH7PR11MB5941.namprd11.prod.outlook.com
 ([fe80::2750:7e63:952:7f1d%6]) with mapi id 15.20.7762.025; Mon, 15 Jul 2024
 15:57:42 +0000
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
Thread-Index: AQHa09y4Qu9AOd5eTECcwvlNYUC9ULHyIXCAgAVUt7CAAEXVgIAAAUtwgAAldYCAAAW84IAADNgQ
Date: Mon, 15 Jul 2024 15:57:42 +0000
Message-ID: <PH7PR11MB5941FD211A0357828F1DA20CA3A12@PH7PR11MB5941.namprd11.prod.outlook.com>
References: <20240711215244.19237-1-yichen.wang@bytedance.com>
 <20240711184131-mutt-send-email-mst@kernel.org>
 <PH7PR11MB594105D464F3A4C2C25F94FEA3A12@PH7PR11MB5941.namprd11.prod.outlook.com>
 <20240715081857-mutt-send-email-mst@kernel.org>
 <PH7PR11MB5941A453AC1A4B3A387475A7A3A12@PH7PR11MB5941.namprd11.prod.outlook.com>
 <20240715104015-mutt-send-email-mst@kernel.org>
 <PH7PR11MB59410B8B35F932AF55C8A243A3A12@PH7PR11MB5941.namprd11.prod.outlook.com>
In-Reply-To: <PH7PR11MB59410B8B35F932AF55C8A243A3A12@PH7PR11MB5941.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB5941:EE_|IA0PR11MB8398:EE_
x-ms-office365-filtering-correlation-id: c306c773-238d-4f1e-f1b0-08dca4e6dc2b
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7416014|38070700018; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?vn8XzzFYwy1qLtlfNHngK6wSPJKOSLxu4YW1AuIe8ZsjoD+dJYsXHDQeGG?=
 =?iso-8859-1?Q?LmbcdtMJAPtrwS7+oNLx8VsCQSmrtoNzYqPJh/Yv7wE/cLUiV5pkz5gs9x?=
 =?iso-8859-1?Q?8N9Eud8y4PgBQWUIZou/IKEUD4Wg5g3LZZcXpOGU6HFoz3t3hFG5lGNR83?=
 =?iso-8859-1?Q?qQYMXxIS4eG5eNOOnvDg8WjsxR9mKMyyP8bc3c+naNTBcjd+PBlVMGM2/S?=
 =?iso-8859-1?Q?WPhIJMlFFPiRgNs/K1LPhWnKwANcHPZrbfJvHwda+BMvOe30w3QrZfLc9h?=
 =?iso-8859-1?Q?/qTdqV7jmlH/VfKEqmAG0jTyvm2rhRlAw9MDckjwUfP3q0fcE5MgcY7Gqp?=
 =?iso-8859-1?Q?e3Z9L5zoybB3hg1Mv/2aVJfFfTH+moxuBwvua4OIt71SzdCEQI4JRR0zFL?=
 =?iso-8859-1?Q?XPZWeEMcMrfNB55dSz5MBNfTIs8HCsjeobEsign3QVeXPqdLfeBdWJCZj4?=
 =?iso-8859-1?Q?CI+Xdxg0GHqy/lT3iaooxj4uC2QFfZjxwBnFlGRHKfC3eqD1jxg6CJaBns?=
 =?iso-8859-1?Q?bqRTLUN0QkESpn1UgR2ePoDTz5+16dl33wowuJPanGUPQiHvkkW0ZUgnUv?=
 =?iso-8859-1?Q?VLDjqadMYrMv2agAhjOnGoUjXzgyfM/iPVI0LYBiEcEhBLk7GZOLQX/Emt?=
 =?iso-8859-1?Q?YyDRvWauu/vkf6Hn1hKsIU0BoY5GgJCLF0xqoIsBWSwb7Ty/jYjHyhbRha?=
 =?iso-8859-1?Q?xR/F8Q/JNreaD6TbFnNjfJR1qcYmswFlxeFzgza0h37X/H0qhdF0+C/cQx?=
 =?iso-8859-1?Q?Z5O3CLjL/AvFMdUZp6zAjQKPPEEYWRebPTetmhuVstSLu/5ZUaqaj3DaC1?=
 =?iso-8859-1?Q?le5M5ScT+2sD4NYCV/3+BGyNII59W5fWNLdaKEodj9Zff2zBAcVB77uUHp?=
 =?iso-8859-1?Q?LYfhWwA67dix4xo+Ndtub51jdLmdJGDmcEDTTiGd0Yb3pyCtL/z1wwQL+q?=
 =?iso-8859-1?Q?rcOUz8Q+jdXvGOZCdKWuouf/+5PaDNyQU0Y7bKEOeSYUHk9J/Sdkd8kjqq?=
 =?iso-8859-1?Q?z4TNN+y+NBCa/XUdgsq0oTJH3XXWhHWnoVNkttXSIoiyYwk+l0hW9DbXvs?=
 =?iso-8859-1?Q?d8PwDBxgOeuFIybWpOtRcLoIQOQUr6OXHRXr/czm63se23JIvw3gKuKsNd?=
 =?iso-8859-1?Q?+jE7R7arV1yBIsu3xgSp/Y7d4Ol390rq/SZP/nT0chXeDJ8dg9yIQWUxP5?=
 =?iso-8859-1?Q?B6y95aFkDdO1pSNqa16EnJolBDbzjdRS+tKKvz9Xg6kIu6w7omjJfePzUS?=
 =?iso-8859-1?Q?01hKuupPIWnoK8ClJYXZifLpQFEE0dgu2ZGdw87eGsBDAPxL7qhFX4CKoH?=
 =?iso-8859-1?Q?DRDdarSNgnpiv+u3q1LkDVbVTkpYc7WcitTQg1LCOjLBrJCV7DIT3dQiG3?=
 =?iso-8859-1?Q?dJIaldqITmwIm1dtIm8dQzWmkq8JXS553k9iCYhZdTcVHcwLhwVBc=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR11MB5941.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?83FDKU8uePONkW5Qn+ElmtANgt47FI8Je7iat0/kPpGvxsZgxmezOF4FKq?=
 =?iso-8859-1?Q?RWMr4JiJgcas6ahNatM87aKRiTGwaIkSbWwHFbgEUtuPA+5flNhah95YKS?=
 =?iso-8859-1?Q?8UXyIfrp3fdwrd/qeiaLiYElQVbi2B5swHvoxrBJUi9aYtwKFbIJ1kN+pR?=
 =?iso-8859-1?Q?PlKL2srXP+EjZrUDgH5Lc2L5cIbAz8jvLx5Kxd5EsM52LBATvUMZk0lTNP?=
 =?iso-8859-1?Q?H/lWkZU3JEUEgTGmfLZaMTIJUATJUbYZgm7NS+0shyUpzyZ/EsY9ao1f9v?=
 =?iso-8859-1?Q?vdlYOe6P3pHhjx8UTVQTZbXvOjPtpJReQwBP1ypqaBkth68shdDcwGiWoE?=
 =?iso-8859-1?Q?g+ljtvAmttdu5Y5jWL17UyEOqGx7EfC5giWBPmuvKJ1Obrk0ZSWOpuA40I?=
 =?iso-8859-1?Q?6G8G03QKsRGAcbPiOdSuIxl7I6rOrlBs0FZUyXCjRfm9Tz1TwM832wPIJi?=
 =?iso-8859-1?Q?nbRgBCmHFjmJW7UFUmC8t2+7Xo6j/l2M3R+GAqf+1A4PvsRElYLZNluD8W?=
 =?iso-8859-1?Q?7Ku5mOWoPh3Y/iYpZ1eGBha9mBp1u8RU7airwnNELOUPycPOJ570AxVqsL?=
 =?iso-8859-1?Q?QuGFr1xl2TniTZJ2PK8+52hq/4WMealIYaaBoqtQEyvujQO8rGcxNtvfsL?=
 =?iso-8859-1?Q?S/0twIBKUjMZFZZ0bALkvH5/IRCwwwK+1rOVjmng+7yJZnfn/c1r8sucn+?=
 =?iso-8859-1?Q?/fGhF09O4bHRFBwuaY8ozQcBoKwJYBdKUEFRqbb43JK7vE7fZF+9INoC2f?=
 =?iso-8859-1?Q?AxwhNK/Re4yAnPWt/Ljbbdrvterq22HRHfPVB4jPEys/x3pdHYKdR3PIFs?=
 =?iso-8859-1?Q?fBlknQzP7aL3gWVkpezpR9LyPNi6CRMJL1L++Sdz2iWpDkqKP0GomErHLe?=
 =?iso-8859-1?Q?UlucuzIB6lckvezsCMZKfV3hqaMOEQlKO5Bipe4J6DRvsB8hit8yrz89iM?=
 =?iso-8859-1?Q?qeyHxsdN8jnfnznaWwnrhUJj/t7B1YeS76b1RC5yYwBlnt4Y4Wzf8/9Lrk?=
 =?iso-8859-1?Q?fPghRusmpDMmFzBNMGzvLhB8hPLQ3QeH+sOmUEgmjDF44NolPa+gBk6fcF?=
 =?iso-8859-1?Q?YilJsy9NlGsf6MLCJ8ffto0AzMJ94Vmd1obRVmTJ8KEBuRhqx+eBKEL5p9?=
 =?iso-8859-1?Q?F5x0TL7pv77njy1+vLAkj7c7IFGBxLx9OFLgPf4CcNZYv+eV2mdoYD4H5a?=
 =?iso-8859-1?Q?RS4KdkD3mbiE00XtG8tdrWlXdkt4oZ23eHz9xK+h5d7JdNxmlCik1F8D/o?=
 =?iso-8859-1?Q?dtM/Di5MrSFmNHcSCsJ5XdZ5sEdHjVgP5TkooUlw7bm5fAsV2VOUCrHMNm?=
 =?iso-8859-1?Q?2Vak9aWisn0CR3JmTFsDQj59FIdpeiMkX6ldOIfMKuUbzw6wKlyoLJADVA?=
 =?iso-8859-1?Q?egyUeBFSAyEB2SYR5t+30m9LQONHkuwdXIjaWgv6P26HKUYOqtHB/fEdqU?=
 =?iso-8859-1?Q?HxTqzR08VIt/o7IasodnSolgfuVLYuoQpS1VWEsOHiAFpcU9mNVLxuwmbn?=
 =?iso-8859-1?Q?z2fNy5MKFXiwWibSE3uNEPARQuMQqMHaAxeFVdKq/jChX2FhRoKqwBmNYA?=
 =?iso-8859-1?Q?g8tz4f4jSHNVV7Q2ZjijxkIVjLFE+OuDjDw++Zbagb5JxbK7BMgXXAR2wh?=
 =?iso-8859-1?Q?TLyRE1eLgcn8GlHJxml8Bfq2bslo11hUhp?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5941.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c306c773-238d-4f1e-f1b0-08dca4e6dc2b
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jul 2024 15:57:42.2589 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0t9B4mzEKHkmLNYymsR0urPmbUqyKzRQl4/PpQw6fmaweSgFK+Y+2qv4OnntORR7u5mcYWBR4GR4esUOfBMT/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB8398
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.8; envelope-from=yuan1.liu@intel.com;
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
> From: Liu, Yuan1
> Sent: Monday, July 15, 2024 11:23 PM
> To: Michael S. Tsirkin <mst@redhat.com>
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
> Subject: RE: [PATCH v5 00/13] WIP: Use Intel DSA accelerator to offload
> zero page checking in multifd live migration.
>=20
> > -----Original Message-----
> > From: Michael S. Tsirkin <mst@redhat.com>
> > Sent: Monday, July 15, 2024 10:43 PM
> > To: Liu, Yuan1 <yuan1.liu@intel.com>
> > Cc: Wang, Yichen <yichen.wang@bytedance.com>; Paolo Bonzini
> > <pbonzini@redhat.com>; Marc-Andr=E9 Lureau <marcandre.lureau@redhat.com=
>;
> > Daniel P. Berrang=E9 <berrange@redhat.com>; Thomas Huth
> <thuth@redhat.com>;
> > Philippe Mathieu-Daud=E9 <philmd@linaro.org>; Peter Xu
> <peterx@redhat.com>;
> > Fabiano Rosas <farosas@suse.de>; Eric Blake <eblake@redhat.com>; Markus
> > Armbruster <armbru@redhat.com>; Cornelia Huck <cohuck@redhat.com>; qemu=
-
> > devel@nongnu.org; Hao Xiang <hao.xiang@linux.dev>; Kumar, Shivam
> > <shivam.kumar1@nutanix.com>; Ho-Ren (Jack) Chuang
> > <horenchuang@bytedance.com>
> > Subject: Re: [PATCH v5 00/13] WIP: Use Intel DSA accelerator to offload
> > zero page checking in multifd live migration.
> >
> > On Mon, Jul 15, 2024 at 01:09:59PM +0000, Liu, Yuan1 wrote:
> > > > -----Original Message-----
> > > > From: Michael S. Tsirkin <mst@redhat.com>
> > > > Sent: Monday, July 15, 2024 8:24 PM
> > > > To: Liu, Yuan1 <yuan1.liu@intel.com>
> > > > Cc: Wang, Yichen <yichen.wang@bytedance.com>; Paolo Bonzini
> > > > <pbonzini@redhat.com>; Marc-Andr=E9 Lureau
> > <marcandre.lureau@redhat.com>;
> > > > Daniel P. Berrang=E9 <berrange@redhat.com>; Thomas Huth
> > <thuth@redhat.com>;
> > > > Philippe Mathieu-Daud=E9 <philmd@linaro.org>; Peter Xu
> > <peterx@redhat.com>;
> > > > Fabiano Rosas <farosas@suse.de>; Eric Blake <eblake@redhat.com>;
> > Markus
> > > > Armbruster <armbru@redhat.com>; Cornelia Huck <cohuck@redhat.com>;
> > qemu-
> > > > devel@nongnu.org; Hao Xiang <hao.xiang@linux.dev>; Kumar, Shivam
> > > > <shivam.kumar1@nutanix.com>; Ho-Ren (Jack) Chuang
> > > > <horenchuang@bytedance.com>
> > > > Subject: Re: [PATCH v5 00/13] WIP: Use Intel DSA accelerator to
> > offload
> > > > zero page checking in multifd live migration.
> > > >
> > > > On Mon, Jul 15, 2024 at 08:29:03AM +0000, Liu, Yuan1 wrote:
> > > > > > -----Original Message-----
> > > > > > From: Michael S. Tsirkin <mst@redhat.com>
> > > > > > Sent: Friday, July 12, 2024 6:49 AM
> > > > > > To: Wang, Yichen <yichen.wang@bytedance.com>
> > > > > > Cc: Paolo Bonzini <pbonzini@redhat.com>; Marc-Andr=E9 Lureau
> > > > > > <marcandre.lureau@redhat.com>; Daniel P. Berrang=E9
> > > > <berrange@redhat.com>;
> > > > > > Thomas Huth <thuth@redhat.com>; Philippe Mathieu-Daud=E9
> > > > > > <philmd@linaro.org>; Peter Xu <peterx@redhat.com>; Fabiano Rosa=
s
> > > > > > <farosas@suse.de>; Eric Blake <eblake@redhat.com>; Markus
> > Armbruster
> > > > > > <armbru@redhat.com>; Cornelia Huck <cohuck@redhat.com>; qemu-
> > > > > > devel@nongnu.org; Hao Xiang <hao.xiang@linux.dev>; Liu, Yuan1
> > > > > > <yuan1.liu@intel.com>; Kumar, Shivam
> <shivam.kumar1@nutanix.com>;
> > Ho-
> > > > Ren
> > > > > > (Jack) Chuang <horenchuang@bytedance.com>
> > > > > > Subject: Re: [PATCH v5 00/13] WIP: Use Intel DSA accelerator to
> > > > offload
> > > > > > zero page checking in multifd live migration.
> > > > > >
> > > > > > On Thu, Jul 11, 2024 at 02:52:35PM -0700, Yichen Wang wrote:
> > > > > > > * Performance:
> > > > > > >
> > > > > > > We use two Intel 4th generation Xeon servers for testing.
> > > > > > >
> > > > > > > Architecture:        x86_64
> > > > > > > CPU(s):              192
> > > > > > > Thread(s) per core:  2
> > > > > > > Core(s) per socket:  48
> > > > > > > Socket(s):           2
> > > > > > > NUMA node(s):        2
> > > > > > > Vendor ID:           GenuineIntel
> > > > > > > CPU family:          6
> > > > > > > Model:               143
> > > > > > > Model name:          Intel(R) Xeon(R) Platinum 8457C
> > > > > > > Stepping:            8
> > > > > > > CPU MHz:             2538.624
> > > > > > > CPU max MHz:         3800.0000
> > > > > > > CPU min MHz:         800.0000
> > > > > > >
> > > > > > > We perform multifd live migration with below setup:
> > > > > > > 1. VM has 100GB memory.
> > > > > > > 2. Use the new migration option multifd-set-normal-page-ratio
> to
> > > > control
> > > > > > the total
> > > > > > > size of the payload sent over the network.
> > > > > > > 3. Use 8 multifd channels.
> > > > > > > 4. Use tcp for live migration.
> > > > > > > 4. Use CPU to perform zero page checking as the baseline.
> > > > > > > 5. Use one DSA device to offload zero page checking to compar=
e
> > with
> > > > the
> > > > > > baseline.
> > > > > > > 6. Use "perf sched record" and "perf sched timehist" to
> analyze
> > CPU
> > > > > > usage.
> > > > > > >
> > > > > > > A) Scenario 1: 50% (50GB) normal pages on an 100GB vm.
> > > > > > >
> > > > > > > 	CPU usage
> > > > > > >
> > > > > > > 	|---------------|---------------|---------------|-------
> ------
> > > > --|
> > > > > > > 	|		|comm		|runtime(msec)
> 	|totaltime(msec)|
> > > > > > > 	|---------------|---------------|---------------|-------
> ------
> > > > --|
> > > > > > > 	|Baseline	|live_migration	|5657.58	|		|
> > > > > > > 	|		|multifdsend_0	|3931.563	|		|
> > > > > > > 	|		|multifdsend_1	|4405.273	|		|
> > > > > > > 	|		|multifdsend_2	|3941.968	|		|
> > > > > > > 	|		|multifdsend_3	|5032.975	|		|
> > > > > > > 	|		|multifdsend_4	|4533.865	|		|
> > > > > > > 	|		|multifdsend_5	|4530.461	|		|
> > > > > > > 	|		|multifdsend_6	|5171.916	|		|
> > > > > > > 	|		|multifdsend_7	|4722.769	|41922
> 	|
> > > > > > > 	|---------------|---------------|---------------|-------
> ------
> > > > --|
> > > > > > > 	|DSA		|live_migration	|6129.168	|		|
> > > > > > > 	|		|multifdsend_0	|2954.717	|		|
> > > > > > > 	|		|multifdsend_1	|2766.359	|		|
> > > > > > > 	|		|multifdsend_2	|2853.519	|		|
> > > > > > > 	|		|multifdsend_3	|2740.717	|		|
> > > > > > > 	|		|multifdsend_4	|2824.169	|		|
> > > > > > > 	|		|multifdsend_5	|2966.908	|		|
> > > > > > > 	|		|multifdsend_6	|2611.137	|		|
> > > > > > > 	|		|multifdsend_7	|3114.732	|		|
> > > > > > > 	|		|dsa_completion	|3612.564	|32568
> 	|
> > > > > > > 	|---------------|---------------|---------------|-------
> ------
> > > > --|
> > > > > > >
> > > > > > > Baseline total runtime is calculated by adding up all
> > multifdsend_X
> > > > > > > and live_migration threads runtime. DSA offloading total
> runtime
> > is
> > > > > > > calculated by adding up all multifdsend_X, live_migration and
> > > > > > > dsa_completion threads runtime. 41922 msec VS 32568 msec
> runtime
> > and
> > > > > > > that is 23% total CPU usage savings.
> > > > > >
> > > > > >
> > > > > > Here the DSA was mostly idle.
> > > > > >
> > > > > > Sounds good but a question: what if several qemu instances are
> > > > > > migrated in parallel?
> > > > > >
> > > > > > Some accelerators tend to basically stall if several tasks
> > > > > > are trying to use them at the same time.
> > > > > >
> > > > > > Where is the boundary here?

If I understand correctly, you are concerned that in some scenarios the
accelerator itself is the migration bottleneck, causing the migration perfo=
rmance
to be degraded.

My understanding is to make full use of the accelerator bandwidth, and once
the accelerator is the bottleneck, it will fall back to zero-page detection
by the CPU.

For example, when the enqcmd command returns an error which means the work =
queue
is full, then we can add some retry mechanisms or directly use CPU detectio=
n.

> > > > > A DSA device can be assigned to multiple Qemu instances.
> > > > > The DSA resource used by each process is called a work queue, eac=
h
> > DSA
> > > > > device can support up to 8 work queues and work queues are
> > classified
> > > > into
> > > > > dedicated queues and shared queues.
> > > > >
> > > > > A dedicated queue can only serve one process. Theoretically, ther=
e
> > is no
> > > > limit
> > > > > on the number of processes in a shared queue, it is based on
> enqcmd
> > +
> > > > SVM technology.
> > > > >
> > > > > https://www.kernel.org/doc/html/v5.17/x86/sva.html
> > > >
> > > > This server has 200 CPUs which can thinkably migrate around 100
> single
> > > > cpu qemu instances with no issue. What happens if you do this with
> > DSA?
> > >
> > > First, the DSA work queue needs to be configured in shared mode, and
> one
> > > queue is enough.
> > >
> > > The maximum depth of the work queue of the DSA hardware is 128, which
> > means
> > > that the number of zero-page detection tasks submitted cannot exceed
> > 128,
> > > otherwise, enqcmd will return an error until the work queue is
> available
> > again
> > >
> > > 100 Qemu instances need to be migrated concurrently, I don't have any
> > data on
> > > this yet, I think the 100 zero-page detection tasks can be
> successfully
> > submitted
> > > to the DSA hardware work queue, but the throughput of DSA's zero-page
> > detection also
> > > needs to be considered. Once the DSA maximum throughput is reached,
> the
> > work queue
> > > may be filled up quickly, this will cause some Qemu instances to be
> > temporarily unable
> > > to submit new tasks to DSA.
> >
> > The unfortunate reality here would be that there's likely no QoS, this
> > is purely fifo, right?
>=20
> Yes, this scenario may be fifo, assuming that the number of pages each
> task
> is the same, because DSA hardware consists of multiple work engines, they
> can
> process tasks concurrently, usually in a round-robin way to get tasks fro=
m
> the
> work queue.
>=20
> DSA supports priority and flow control based on work queue granularity.
> https://github.com/intel/idxd-
> config/blob/stable/Documentation/accfg/accel-config-config-wq.txt
>=20
> > > This is likely to happen in the first round of migration
> > > memory iteration.
> >
> > Try testing this and see then?
>=20
> Yes, I can test based on this patch set. Please review the test scenario
> My server has 192 CPUs, and 8 DSA devices, 100Gbps NIC.
> All 8 DSA devices serve 100 Qemu instances for simultaneous live
> migration.
> Each VM has 1 vCPU, and 1G memory, with no workload in the VM.
>=20
> You want to know if some Qemu instances are stalled because of DSA, right=
?
>=20
> > --
> > MST


