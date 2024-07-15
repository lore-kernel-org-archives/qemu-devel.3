Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DA21C3DA4B
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2024 15:24:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTNY0-0008Co-VS; Mon, 15 Jul 2024 11:23:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yuan1.liu@intel.com>)
 id 1sTNXz-0008CA-6F
 for qemu-devel@nongnu.org; Mon, 15 Jul 2024 11:23:27 -0400
Received: from mgamail.intel.com ([198.175.65.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yuan1.liu@intel.com>)
 id 1sTNXw-0001nm-6Q
 for qemu-devel@nongnu.org; Mon, 15 Jul 2024 11:23:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1721057004; x=1752593004;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=uzAa8yDV+tXGM8oIQdZ+zupQRBfU9hEA0CB0dICaXYA=;
 b=eBSNjo+4fRRV96/WjRfWhAtBbVP1G6iyeEwSoqwwL82wNQRblx5ubEUf
 t526db6T8FxNbOIRmNWviYhAHCuuwTHVNSyb/5xXTOdW0icTkaeUyKjIW
 UDhgy3CftxISvPL4biYGry1yoSrLUg3TPwjMewysyWFcNA77NsviX5O/c
 Kacl+cF0ZRQMIRJXAGYQILxCbmMVQ7BDsHQLGiioseH+3VBnIQN9Qm1oz
 RxAZ56B3Jb5omwrUoZzfChdq2zySBNpo9uUZwCwvBTR3Nie/iomVvvAE0
 5flGIKpnkG1U/9eEHlE+8Hqr65FnSS019eC95iygqWspqyXRRy+Q3KDzt w==;
X-CSE-ConnectionGUID: zGvdz6cuSyqWILlveY2CSw==
X-CSE-MsgGUID: OCFtKeZWQYqvpzrQ6zXDuA==
X-IronPort-AV: E=McAfee;i="6700,10204,11134"; a="18399499"
X-IronPort-AV: E=Sophos;i="6.09,210,1716274800"; d="scan'208";a="18399499"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Jul 2024 08:23:19 -0700
X-CSE-ConnectionGUID: y9akMOkGSAqvTs9/Q4z4TA==
X-CSE-MsgGUID: NFpboQ10Qoa6htIIYIHUjQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,210,1716274800"; d="scan'208";a="72884706"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
 by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 15 Jul 2024 08:23:17 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 15 Jul 2024 08:23:17 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 15 Jul 2024 08:23:17 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 15 Jul 2024 08:23:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jNjc70MrWGrtqHFPWACOOyu22QIiHMQ3HZsGmlR4JFWD44gjoxm/8vdEoyQNZH6sxeBlBW06V/F2JGC24kRUZN3uGOIc+6IRtZnlXypuZIwMJi9bliQVwxK/8IXGf6/Yw/YB6xj6owDVRRYWRp98CBN2W8SkP/Kr9UTLQctQxSH5VFkEo+ponlaXn98YjX4t2+jUlBZI0sSjXqzgId8ws6kyaq9x/bT3UyP/vMFE7nxXDNZ/22ywUT1GezqrUX5Znk2VKj4xb76zUfikTgEPEfjdSS+IYHVLqsw1+kIeUDtvY4WvMyOnSkolF3Gl+XI85JKF2/Z5zmJ846xHSLJ+LA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xaW9E4MywwqQiQpmjIlrT8RHLIDDdrX9CTq7E3k3mUQ=;
 b=BpijSWXkXdM8LIaScrt/rPTQrs1vpsyze0TzLgC3b3PRLaKXF6mJLvhqJW5ygLpIZKVvRhUHgCMJEBxfni6sbWNR1htQgmfkkbxAzr+132fWcQw1arn+RW/3E6Mfz7apBCWm78OYRsztnp/M9k82kGpk2v3rBYPEulp7lUU6nKRtPdHKHkI1zML3jcAHEqUuiNi8CmFsWX0PwKDcBm6lAR5hio5pFD6WAd8/cQ7mmTio2Q400SGnU+L/lCf+79dQ6dxanhWWLRk883bH9ceAjV2eNpMrASKKCV8oqfI+p8VLSz8+TBEysDcw4dp8obPaNfcHlHGn5XAuFhzw81j0Hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB5941.namprd11.prod.outlook.com (2603:10b6:510:13d::20)
 by SA1PR11MB6991.namprd11.prod.outlook.com (2603:10b6:806:2b8::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.28; Mon, 15 Jul
 2024 15:23:13 +0000
Received: from PH7PR11MB5941.namprd11.prod.outlook.com
 ([fe80::2750:7e63:952:7f1d]) by PH7PR11MB5941.namprd11.prod.outlook.com
 ([fe80::2750:7e63:952:7f1d%6]) with mapi id 15.20.7762.025; Mon, 15 Jul 2024
 15:23:13 +0000
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
Thread-Index: AQHa09y4Qu9AOd5eTECcwvlNYUC9ULHyIXCAgAVUt7CAAEXVgIAAAUtwgAAldYCAAAW84A==
Date: Mon, 15 Jul 2024 15:23:13 +0000
Message-ID: <PH7PR11MB59410B8B35F932AF55C8A243A3A12@PH7PR11MB5941.namprd11.prod.outlook.com>
References: <20240711215244.19237-1-yichen.wang@bytedance.com>
 <20240711184131-mutt-send-email-mst@kernel.org>
 <PH7PR11MB594105D464F3A4C2C25F94FEA3A12@PH7PR11MB5941.namprd11.prod.outlook.com>
 <20240715081857-mutt-send-email-mst@kernel.org>
 <PH7PR11MB5941A453AC1A4B3A387475A7A3A12@PH7PR11MB5941.namprd11.prod.outlook.com>
 <20240715104015-mutt-send-email-mst@kernel.org>
In-Reply-To: <20240715104015-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB5941:EE_|SA1PR11MB6991:EE_
x-ms-office365-filtering-correlation-id: 4bce5528-e849-4eed-2df9-08dca4e20af9
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7416014|38070700018; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?veaZGXbb09aM0xO23FO64Xmg1bBv9dPf7NcKv+4eHthtnvr8pIkspi7E1x?=
 =?iso-8859-1?Q?373TJ1gg78Cf2ZFR+HLCoSJMAXuK75+TfVesk0yduItNcyoXNa2b8VEy56?=
 =?iso-8859-1?Q?gf5qUEASH8jSQR1j5t8/YJmo+fYA47/p3vxwJEbETimcVsxca/twEZakct?=
 =?iso-8859-1?Q?lpFZ/ibeC2yw1gcKUBTh8V5cPWLQCBxMYSwoUN+LB8fFAJHbTcHPnwoAmo?=
 =?iso-8859-1?Q?oA5r6Oh7PzZKlrWYLF+A1BzKR0JEGHEW8P13V6DrgyUYerdK7g095lDK1v?=
 =?iso-8859-1?Q?hQMWnT6xJsHskCJsVJA5B2vW1Qu6GHybxZ0k5vPIC5/uH3IYzwksC6HeBM?=
 =?iso-8859-1?Q?3yY4NALmYdwFLZxpT3ClaaOTfYJtw7NDCzogqtqEFRwFh/aZrBnWt66mBB?=
 =?iso-8859-1?Q?Nlox9dfie73i08pBP1UFIUdcurPdCHGfCTubux+l2sspWkLOHsq7vhhuQq?=
 =?iso-8859-1?Q?Mpz0lbuLN2eR0kQ3kkSKtxaDpTw3fU7g/NBKmDOOjy0g7Q/K53zs5G1k8r?=
 =?iso-8859-1?Q?dE748Awmi2e5sl4lhvMmJcTnV7CDR6lCEJedBeCkqLIFlk+afpyxImMsiI?=
 =?iso-8859-1?Q?ZjwvpzRdcJW1lUNKZuW+4vM2pWdOsi3ZJjtpnSmHsyJ8DXq48a+5IE8FG/?=
 =?iso-8859-1?Q?GBtob8XaCU6pYZYLQwg9VjQ/AT/dzilSBMiptkeUTyk/pGhjFy0h+q6Go0?=
 =?iso-8859-1?Q?S3GGSk6Gg5q5mex352XM9i62qbK0OSEHhGut6OqDoxn+mHKyj5OSsdPlWA?=
 =?iso-8859-1?Q?E0mGWPgjT3Xoxp+1TWafr6UfihTzlhxE1rObAnNcWtKQUp1GhQQ0IfNLX9?=
 =?iso-8859-1?Q?/36Y4+ldDps23wy2ZdBlJMGcuu3hUR1qYs9dUkv6PNMZakWShrCTqy1zx4?=
 =?iso-8859-1?Q?esK2ilsHlVJBdVxRkGjGe3rRgBirEBfTqOokQ6zbyV8E5hMQcX//8hQSWP?=
 =?iso-8859-1?Q?GV1FoEc7bs+6S6icDHCm99I/tYdJy4VAFehoV9P2WtY4ZX98fEjnt10Rg6?=
 =?iso-8859-1?Q?PINhFMgcEaz94+GwYSh5sCLa6EuNQo4vg+NgqXF/auXke89NfWaorwC7ow?=
 =?iso-8859-1?Q?pVqsDipAgw9tuzi+eX3dFb4Jzhjg5s+o4nUi1RcOq7249VajKu/KJnJuJQ?=
 =?iso-8859-1?Q?rMb5Qgi/z2b/TUkRbL2l3ltrTxoAHyXGmIT53qY2AT5QMVp121hpVcS/l/?=
 =?iso-8859-1?Q?YEhDB2Epm0p0ZV8vImvU9YDeetP6/BF6fFU1jW8lRsUTr1cDgj5nHZBVVQ?=
 =?iso-8859-1?Q?nCOYMBfmK0OQ8lYtybtZ/PevsZ1NMPFhWT2ffIwR5a8qH4BM3NxfUwvYvP?=
 =?iso-8859-1?Q?czMG+S7TJd7aLHMSjoE8r0V7BU8V5nHie2PM5tupoVU7Dzy3fQnncgrjLF?=
 =?iso-8859-1?Q?BibUMjlsdeyny8Vhkuk2zcUEGV37+1MPtus3wmjipoU2xmk4UsQzU=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR11MB5941.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?0szjWwzNxrLxu7tfe0Npu+nvLSHfqyBCfgZB6DfOdZVJhp8fF+JFLdA8pR?=
 =?iso-8859-1?Q?0KXa6R5mC62qXuaMVw2nMv+oFMisKzQreApmkzHEEtGgv70LvabBB4UxzJ?=
 =?iso-8859-1?Q?Cr+FTdzL1XRc+LqKZAk61odXVpMiAWelpuWJACypdiXk9A8tPRsoSYhy0Z?=
 =?iso-8859-1?Q?ewacgJCyCPDN2Ef6Wi25EIQh6nlcMEEzRTpxmgQyMbsxlNMKtVyhwjJatU?=
 =?iso-8859-1?Q?AtUWedNXAhsy2LDitcEp8VJwe+0s8WgIX0kZy/BH1tWYvzkqVUQEBiKEKl?=
 =?iso-8859-1?Q?X1LAjJPlFfqwTtWtdPtNKBUwztoH6Yvzs/wfIQGRJcyIvcYFN7NcmTWKbe?=
 =?iso-8859-1?Q?pzJ7FWSYWfAjNuy8GQ2suh4gXsJLVtfpUrKfbvviHauUttmlBIEtzTW8P0?=
 =?iso-8859-1?Q?SGCItm8EsYbLyAcsHsqLkpYeruAvYI4pS91fmwz56b9UJS6GBWetFLR3Og?=
 =?iso-8859-1?Q?3uUT5PBsxKtvgiTHAhZTh7rOsMZExPcIC9SIqq3ByKx8zrhtUmtfmVMViH?=
 =?iso-8859-1?Q?lhWQowjR1tYL+8/nYvhKFKb9sLPW53eHXzi0SduqBdYovSMdSWMiT4Ae4P?=
 =?iso-8859-1?Q?S02tlchJ7xhKPWImeExda4HlQ3cBJKzNEjQxfsXzN+s9sdhQUnX+RkaLnV?=
 =?iso-8859-1?Q?pCZN7l8K+XXu8yUSb/JfVex0TTAz9CknkPvls0k2V3SXy514yVtGhwdYca?=
 =?iso-8859-1?Q?S/3kNrrKtbXJrnJznMKSni0b4e+Ew8OhfTbYNsurlEL45J95FMxyjtmQ50?=
 =?iso-8859-1?Q?/Fd9+GiE1qj1dveg6tQUOHGYZrl94ei3ZInXTsNbakRPpyKICkUS3F7LJV?=
 =?iso-8859-1?Q?8HyqfWKrRhdht57Sf/xG+36EUF1NZnGggj5oVbZlMn/dmjBhEyObaLUi9z?=
 =?iso-8859-1?Q?0yTKNiV/ASPnSILjK2RW6sycvHoAWj+knFq4f2FmapBDHF/nt3AfmfP9cf?=
 =?iso-8859-1?Q?YEXiat2ogyfvs7IEuOvmA/aeSvE+1zomeHjY/UYCIQSEB3PHHGpIl6Ho9m?=
 =?iso-8859-1?Q?xVhBxA2VHkt1b/kZ9DZCnYg4fzYqmIHxuiUTrARifJIhi7b5hT0i88ivyX?=
 =?iso-8859-1?Q?yeBYBET/efOB9h5eQdLZBgO2PzPoP3JOjcF1KnU8Af8ahYy09SwjzUI8LW?=
 =?iso-8859-1?Q?If6zWQZbkPjdT8+4OfNSkWHAn+CUcfkU67LeE4SmMRHprjXxa8ZqBMxLs6?=
 =?iso-8859-1?Q?UdDktXE0OKRuTwLLf4nAJIgBWhWegNpLRpnxxiooOCsKMVZgt3drfy6mn3?=
 =?iso-8859-1?Q?9567+TcglL7dEGTt6PNG8l4mcUx6G4q7Uh2mY+6PvY4zQm2rMNRqtpyBTs?=
 =?iso-8859-1?Q?KpENzFXQxOX1h+j6EGkDoFrMI+by1qvWHvDCuCqLExRlB+ERnGlSPHwTLH?=
 =?iso-8859-1?Q?sYGctaUlSexaWm703hec2R+6rv8q9iexHnBid5AdcgB64R4ZCSvkPJbJny?=
 =?iso-8859-1?Q?Ao0B4hJSFh5UZePeMoYfmoPR/D/P0GA2buvc0xco5l45icXgaPeytYRAqM?=
 =?iso-8859-1?Q?VN5o8cbOWNfDg1xWaZJJJzB26xSC+3F/NqxoFTpCK49awE3QGjSxyUqS8f?=
 =?iso-8859-1?Q?PIVkRABZViRIR/GQvSOb1AuN+Zr5k6pDWMyYhXjGjvCbHdPzITEuyurk14?=
 =?iso-8859-1?Q?du/Khvi9zK3cD9C/2mLWwZIz/nOwQQCL1F?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5941.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bce5528-e849-4eed-2df9-08dca4e20af9
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jul 2024 15:23:13.2614 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cPuhCNNon95zhxgGtW6mMLohm035CtWNgV2Gvt31QIvsvpuPbiypgiM+9QgkxvhfbQ65KejuF5uHIX2Cu/Ui5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6991
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.21; envelope-from=yuan1.liu@intel.com;
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
> Sent: Monday, July 15, 2024 10:43 PM
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
> On Mon, Jul 15, 2024 at 01:09:59PM +0000, Liu, Yuan1 wrote:
> > > -----Original Message-----
> > > From: Michael S. Tsirkin <mst@redhat.com>
> > > Sent: Monday, July 15, 2024 8:24 PM
> > > To: Liu, Yuan1 <yuan1.liu@intel.com>
> > > Cc: Wang, Yichen <yichen.wang@bytedance.com>; Paolo Bonzini
> > > <pbonzini@redhat.com>; Marc-Andr=E9 Lureau
> <marcandre.lureau@redhat.com>;
> > > Daniel P. Berrang=E9 <berrange@redhat.com>; Thomas Huth
> <thuth@redhat.com>;
> > > Philippe Mathieu-Daud=E9 <philmd@linaro.org>; Peter Xu
> <peterx@redhat.com>;
> > > Fabiano Rosas <farosas@suse.de>; Eric Blake <eblake@redhat.com>;
> Markus
> > > Armbruster <armbru@redhat.com>; Cornelia Huck <cohuck@redhat.com>;
> qemu-
> > > devel@nongnu.org; Hao Xiang <hao.xiang@linux.dev>; Kumar, Shivam
> > > <shivam.kumar1@nutanix.com>; Ho-Ren (Jack) Chuang
> > > <horenchuang@bytedance.com>
> > > Subject: Re: [PATCH v5 00/13] WIP: Use Intel DSA accelerator to
> offload
> > > zero page checking in multifd live migration.
> > >
> > > On Mon, Jul 15, 2024 at 08:29:03AM +0000, Liu, Yuan1 wrote:
> > > > > -----Original Message-----
> > > > > From: Michael S. Tsirkin <mst@redhat.com>
> > > > > Sent: Friday, July 12, 2024 6:49 AM
> > > > > To: Wang, Yichen <yichen.wang@bytedance.com>
> > > > > Cc: Paolo Bonzini <pbonzini@redhat.com>; Marc-Andr=E9 Lureau
> > > > > <marcandre.lureau@redhat.com>; Daniel P. Berrang=E9
> > > <berrange@redhat.com>;
> > > > > Thomas Huth <thuth@redhat.com>; Philippe Mathieu-Daud=E9
> > > > > <philmd@linaro.org>; Peter Xu <peterx@redhat.com>; Fabiano Rosas
> > > > > <farosas@suse.de>; Eric Blake <eblake@redhat.com>; Markus
> Armbruster
> > > > > <armbru@redhat.com>; Cornelia Huck <cohuck@redhat.com>; qemu-
> > > > > devel@nongnu.org; Hao Xiang <hao.xiang@linux.dev>; Liu, Yuan1
> > > > > <yuan1.liu@intel.com>; Kumar, Shivam <shivam.kumar1@nutanix.com>;
> Ho-
> > > Ren
> > > > > (Jack) Chuang <horenchuang@bytedance.com>
> > > > > Subject: Re: [PATCH v5 00/13] WIP: Use Intel DSA accelerator to
> > > offload
> > > > > zero page checking in multifd live migration.
> > > > >
> > > > > On Thu, Jul 11, 2024 at 02:52:35PM -0700, Yichen Wang wrote:
> > > > > > * Performance:
> > > > > >
> > > > > > We use two Intel 4th generation Xeon servers for testing.
> > > > > >
> > > > > > Architecture:        x86_64
> > > > > > CPU(s):              192
> > > > > > Thread(s) per core:  2
> > > > > > Core(s) per socket:  48
> > > > > > Socket(s):           2
> > > > > > NUMA node(s):        2
> > > > > > Vendor ID:           GenuineIntel
> > > > > > CPU family:          6
> > > > > > Model:               143
> > > > > > Model name:          Intel(R) Xeon(R) Platinum 8457C
> > > > > > Stepping:            8
> > > > > > CPU MHz:             2538.624
> > > > > > CPU max MHz:         3800.0000
> > > > > > CPU min MHz:         800.0000
> > > > > >
> > > > > > We perform multifd live migration with below setup:
> > > > > > 1. VM has 100GB memory.
> > > > > > 2. Use the new migration option multifd-set-normal-page-ratio t=
o
> > > control
> > > > > the total
> > > > > > size of the payload sent over the network.
> > > > > > 3. Use 8 multifd channels.
> > > > > > 4. Use tcp for live migration.
> > > > > > 4. Use CPU to perform zero page checking as the baseline.
> > > > > > 5. Use one DSA device to offload zero page checking to compare
> with
> > > the
> > > > > baseline.
> > > > > > 6. Use "perf sched record" and "perf sched timehist" to analyze
> CPU
> > > > > usage.
> > > > > >
> > > > > > A) Scenario 1: 50% (50GB) normal pages on an 100GB vm.
> > > > > >
> > > > > > 	CPU usage
> > > > > >
> > > > > > 	|---------------|---------------|---------------|-------------
> > > --|
> > > > > > 	|		|comm		|runtime(msec)	|totaltime(msec)|
> > > > > > 	|---------------|---------------|---------------|-------------
> > > --|
> > > > > > 	|Baseline	|live_migration	|5657.58	|		|
> > > > > > 	|		|multifdsend_0	|3931.563	|		|
> > > > > > 	|		|multifdsend_1	|4405.273	|		|
> > > > > > 	|		|multifdsend_2	|3941.968	|		|
> > > > > > 	|		|multifdsend_3	|5032.975	|		|
> > > > > > 	|		|multifdsend_4	|4533.865	|		|
> > > > > > 	|		|multifdsend_5	|4530.461	|		|
> > > > > > 	|		|multifdsend_6	|5171.916	|		|
> > > > > > 	|		|multifdsend_7	|4722.769	|41922		|
> > > > > > 	|---------------|---------------|---------------|-------------
> > > --|
> > > > > > 	|DSA		|live_migration	|6129.168	|		|
> > > > > > 	|		|multifdsend_0	|2954.717	|		|
> > > > > > 	|		|multifdsend_1	|2766.359	|		|
> > > > > > 	|		|multifdsend_2	|2853.519	|		|
> > > > > > 	|		|multifdsend_3	|2740.717	|		|
> > > > > > 	|		|multifdsend_4	|2824.169	|		|
> > > > > > 	|		|multifdsend_5	|2966.908	|		|
> > > > > > 	|		|multifdsend_6	|2611.137	|		|
> > > > > > 	|		|multifdsend_7	|3114.732	|		|
> > > > > > 	|		|dsa_completion	|3612.564	|32568		|
> > > > > > 	|---------------|---------------|---------------|-------------
> > > --|
> > > > > >
> > > > > > Baseline total runtime is calculated by adding up all
> multifdsend_X
> > > > > > and live_migration threads runtime. DSA offloading total runtim=
e
> is
> > > > > > calculated by adding up all multifdsend_X, live_migration and
> > > > > > dsa_completion threads runtime. 41922 msec VS 32568 msec runtim=
e
> and
> > > > > > that is 23% total CPU usage savings.
> > > > >
> > > > >
> > > > > Here the DSA was mostly idle.
> > > > >
> > > > > Sounds good but a question: what if several qemu instances are
> > > > > migrated in parallel?
> > > > >
> > > > > Some accelerators tend to basically stall if several tasks
> > > > > are trying to use them at the same time.
> > > > >
> > > > > Where is the boundary here?
> > > >
> > > > A DSA device can be assigned to multiple Qemu instances.
> > > > The DSA resource used by each process is called a work queue, each
> DSA
> > > > device can support up to 8 work queues and work queues are
> classified
> > > into
> > > > dedicated queues and shared queues.
> > > >
> > > > A dedicated queue can only serve one process. Theoretically, there
> is no
> > > limit
> > > > on the number of processes in a shared queue, it is based on enqcmd
> +
> > > SVM technology.
> > > >
> > > > https://www.kernel.org/doc/html/v5.17/x86/sva.html
> > >
> > > This server has 200 CPUs which can thinkably migrate around 100 singl=
e
> > > cpu qemu instances with no issue. What happens if you do this with
> DSA?
> >
> > First, the DSA work queue needs to be configured in shared mode, and on=
e
> > queue is enough.
> >
> > The maximum depth of the work queue of the DSA hardware is 128, which
> means
> > that the number of zero-page detection tasks submitted cannot exceed
> 128,
> > otherwise, enqcmd will return an error until the work queue is availabl=
e
> again
> >
> > 100 Qemu instances need to be migrated concurrently, I don't have any
> data on
> > this yet, I think the 100 zero-page detection tasks can be successfully
> submitted
> > to the DSA hardware work queue, but the throughput of DSA's zero-page
> detection also
> > needs to be considered. Once the DSA maximum throughput is reached, the
> work queue
> > may be filled up quickly, this will cause some Qemu instances to be
> temporarily unable
> > to submit new tasks to DSA.
>=20
> The unfortunate reality here would be that there's likely no QoS, this
> is purely fifo, right?

Yes, this scenario may be fifo, assuming that the number of pages each task
is the same, because DSA hardware consists of multiple work engines, they c=
an
process tasks concurrently, usually in a round-robin way to get tasks from =
the
work queue.=09

DSA supports priority and flow control based on work queue granularity.
https://github.com/intel/idxd-config/blob/stable/Documentation/accfg/accel-=
config-config-wq.txt

> > This is likely to happen in the first round of migration
> > memory iteration.
>=20
> Try testing this and see then?

Yes, I can test based on this patch set. Please review the test scenario
My server has 192 CPUs, and 8 DSA devices, 100Gbps NIC.
All 8 DSA devices serve 100 Qemu instances for simultaneous live migration.
Each VM has 1 vCPU, and 1G memory, with no workload in the VM.

You want to know if some Qemu instances are stalled because of DSA, right?

> --
> MST


