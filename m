Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD902F532DF
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2026 05:48:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w4uc2-0002bv-Ur; Tue, 24 Mar 2026 01:47:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1w4uc0-0002ba-BH
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 01:47:32 -0400
Received: from mgamail.intel.com ([198.175.65.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1w4ubv-00039S-OV
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 01:47:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1774331248; x=1805867248;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=nzUvsdLl3r9L2yh7aaZ5WwIKR1Zuu0lccKlJKJC/GL4=;
 b=Sa3UY3yJmXB32C2TsP3sLlSXaiogUJBSqWAPdvO/RHCsJPKbTul1yUw7
 mebK2l5GJMeZGln+uxsTZxs1J5oqE/MJYOplpYPDZrDJofErGS+Bx1Iv3
 GFqO7mR5pd/imG5JDpDC+BLghUwu8/6/KVSpmo4WEhjo27aH6qDiOW60R
 DfHGYPgB/OjBYoQy4R0Tim1NPySfWTpkdr1D1sNikY7jhg5JaCAG9oR7X
 UetXQsQM2x8y2aUAt1bKaLeRarSKh2fC3C4QSwN9JRBliTLAYiJu+9cIg
 SpfFzXSMbz1kb5Ce81vAJU8INuR47nzSKHV6q3RdHfAT2QXPGGjE9xG09 g==;
X-CSE-ConnectionGUID: dgZEm2BERi2UpHwkVwFZpg==
X-CSE-MsgGUID: SymqBoThQc+dQ+t8cXXKxQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11738"; a="75364907"
X-IronPort-AV: E=Sophos;i="6.23,138,1770624000"; d="scan'208";a="75364907"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Mar 2026 22:47:23 -0700
X-CSE-ConnectionGUID: rP+L2xMrSHm7JuNRNPYd2A==
X-CSE-MsgGUID: T6VGonIfQTaM1I+g8Oe2aA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,138,1770624000"; d="scan'208";a="254738130"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Mar 2026 22:47:22 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 23 Mar 2026 22:47:22 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 23 Mar 2026 22:47:22 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.23) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 23 Mar 2026 22:47:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WJ9vCvDRF817MiZq97VnH31f2HzTMWOsCXNLi9NSQmcdEi1W75arD7mLo4cmAYAWm5NpuFz+6HYVCbBkx5zLg6EJQY/YxXY8zx3Shc/U+jLb/TiEfqxWkjFjU2tDxXhKbkCv/61ioSLg6thOY3UUgN45wuvQ9tAFNmLJllltKHkfgZ+MU6YGCmRgLEofoNU4hPpdqWhr09h31PnLtp54hR9YcaHI4x4fSJEucuEkvzu64ebv8POSoqal8twz2RWUE9EIHCoTx/mTXeJ8y5MVnmePLrNKyv0hYV0IvJ7UN79bsOT7u8SMMiEMs14/JNYWTQ8h6snskuY0jewA1BVksg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y184JV9Eu3RGyNzR0bqWcOw7N8Gk+TgGzbesDx4UXC8=;
 b=QhHqVPM9R6jpXJ+GXI9k5n531t04B0/dtpcfSJRCtYJRUEZBQFcHBBsdb94ZF1Bcssck+SuXggyeFVrLRNP8v6pc6dNqZBV19eHYm/pshYHNv7hzAdFRUEfulsvwTmWL9vpK5uTY6y1UJdAx4LvvrHKwSiN0FZ4OWnR0G5AXBvhnnKLB+a5G7dtFBGbsw2K0N+KVBniNqE7i6FP8LN15LY892+Jjd/zTm+lgS9u9Qe4QvRbmK1NOl//fdMsmqcOLYTecxXRm0oyHL0Q3BqddPH5btONjb93ES/6iOjpkxxwoPtfUgGH6C4z7Wi/bvImNgT6qEtrztAbR4XatelCNSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA0PR11MB7185.namprd11.prod.outlook.com (2603:10b6:208:432::20)
 by DS4PPF25B1C4D24.namprd11.prod.outlook.com (2603:10b6:f:fc02::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.19; Tue, 24 Mar
 2026 05:47:20 +0000
Received: from IA0PR11MB7185.namprd11.prod.outlook.com
 ([fe80::9f37:cb81:5463:300e]) by IA0PR11MB7185.namprd11.prod.outlook.com
 ([fe80::9f37:cb81:5463:300e%5]) with mapi id 15.20.9745.019; Tue, 24 Mar 2026
 05:47:20 +0000
From: "Kasireddy, Vivek" <vivek.kasireddy@intel.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Akihiko Odaki
 <odaki@rsg.ci.i.u-tokyo.ac.jp>
CC: Alex Williamson <alex@shazbot.org>
Subject: RE: [PATCH v12 07/10] vfio/device: Add support for creating dmabuf
 from multiple ranges
Thread-Topic: [PATCH v12 07/10] vfio/device: Add support for creating dmabuf
 from multiple ranges
Thread-Index: AQHct2B8XYwrKczqy0WrQxqhUeOkDrW8b7YAgAATDcA=
Date: Tue, 24 Mar 2026 05:47:19 +0000
Message-ID: <IA0PR11MB7185D4CE68C2FA1DA354D42DF848A@IA0PR11MB7185.namprd11.prod.outlook.com>
References: <20260319052023.2088685-1-vivek.kasireddy@intel.com>
 <20260319052023.2088685-8-vivek.kasireddy@intel.com>
 <98c1495e-e142-4e63-ada1-87e14b85342e@redhat.com>
In-Reply-To: <98c1495e-e142-4e63-ada1-87e14b85342e@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PR11MB7185:EE_|DS4PPF25B1C4D24:EE_
x-ms-office365-filtering-correlation-id: 7160116d-5b5e-44fe-eca9-08de8968d078
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|38070700021|22082099003|18002099003|56012099003;
x-microsoft-antispam-message-info: rNxqH50O5dbLYTuhST84ZZnObth1uabFodGhLQNQ+20U7lxahuUFWUbaMLXGKETGT4JGFGGA3mIQdxduzIpkyKGziSUO+WsgSeQDVztEjUw9la/iHD+IoC7CtptT9s9U2qGc1Yo21bcYHthmni+9oVGW8yuI6kEYO772ivT7IplO5doJRlUTtUupHSKm1l4mx3uwooj/dGgW7g4uYjmfk3/Vp0VsfXJ+lIEx4x7m835j3ZVXS9itCXbJzH0SRNpcWkfFSLe5wGNw010XpuSBe3T3AYeDY5r4Xph2h+tNLFjUZu4iKigmWhVWK3I+g7viSRBWr2WcZXlalQij161dATTDL7MT1/TADXUnfhsGIpSCOe8aNnm+dyo0FE7/Edalfu8ttlgoNz0BholQ8iJgfQ76+ixegLUQeX33ZqGbrmnKmJ2iaBA8fIynpZvlGx/f5anwlZgZljQeSzQjCIBFebT9xbqLpycdHooJ6GRUraaUZPZ8zL9R31UQnKhidzQ5+LFW22DYyxP1dn0tjGZGtdLN5aJVIOb+vPoEjyVhhOBazW1rf1d7ViVxiSWX1e7fF/DQ4IN+efsMdo7dI5Wg2o7PBxO5GAHQdA6d/f4zyv/2IN8VSPE3/ZCX7DnZ4KGMWQOMt+qoYUtnxiCVKBMl1Dcs3fLoKQ+NlnIbumyQslPew/Xpzyb3zlS2EJYLZ36fnT43TTYf7y5kH63LePaH8WXjYzrprTxgRB+3Wff7TQ3TNxLyEN70K7Rdg+Ti/G9EU4W711a81nDtctaNhjnbB9SvzxYk5DuzTc0fCG7ssFQ=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR11MB7185.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700021)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?VmvEZKcE0Be8T3cNlKPhQNrmdNh+qg8axM5mCK15mowPBcdUp5eIzbEPNa?=
 =?iso-8859-1?Q?U2xgL7lpeBvyMiZR5NNGjhbeb7k1GrehMbsETox3WmNo+lO7NGWT3tFplx?=
 =?iso-8859-1?Q?uC+z/UxR7ZaGoIrcQzx3cRI3nrVYgfniCTBgZsHJq4dR0tTuTi1rJTeZNi?=
 =?iso-8859-1?Q?WSzhL1OmT/DNhdNA3ZcjxzaTR5HQdSSkHY6fX8rid+VzI8XHk9IzoZJqf/?=
 =?iso-8859-1?Q?rBxD2xUg5KlTtXuE7KiTmRX5lAkz7pg+NUhH+rhKJrebDLUaDZ83xajND2?=
 =?iso-8859-1?Q?9LEXtQHGAXh19ezw/HzK5UBGTtYWV16qWSV2m+62h1FFZYz0K+fUk5cwsO?=
 =?iso-8859-1?Q?fg9kOIEOe1us7HA7kKHWcs39iEuh86EQyLWiuBIXHqUxgAc6OLAxam6fsS?=
 =?iso-8859-1?Q?Lu9fgrcMcLOMOEix5YdwpbBysWDKw3+hZPm0yBtcDQ0WfDTb6zMfutKZsi?=
 =?iso-8859-1?Q?0iY+ApVKShng155ZVn0RCyaGjsWhwcfwHuuHCnJ/6g+4n2sNEZgI/EqNeY?=
 =?iso-8859-1?Q?tzl6eHm62Ef2hHkfgX+exgdJHvagC+B71+pxcqlX44SPmW5ymFfJlSEnnD?=
 =?iso-8859-1?Q?hm17d86ip+T59B54m+jfe2TnF0M502klAMNvJa0X5YZ1ZBLSBQL9cAMH11?=
 =?iso-8859-1?Q?QxAGfJ8ml/QyiiF3UGU+pCzuECvQjt3x5YyQDs0GE6Q/ul+QicD8HwDMvO?=
 =?iso-8859-1?Q?++NvqFdmhJlz3rMi5Y2TgFNhtl8EvZay+ihlt6Ro+RxNYeQm4eRax7gKeO?=
 =?iso-8859-1?Q?mlGnC1S0cw4F2ze5mEIBEYIfRaVpIPOIkgdSwWWaA6IPJ88hno1dC37C1k?=
 =?iso-8859-1?Q?PcWEPrCbvAsFxVLkEE0X5TD++lU5mFnm+7T40XveRGgeKmYmDoCHaHwPC7?=
 =?iso-8859-1?Q?tBHIjkQwAk7J76lTPwxKJc4SOAHN0cX7VTFES6BXizCzh/qx3ygorAaeyC?=
 =?iso-8859-1?Q?OFP6tUtbkInFkQgi0L+smAYbvp3BdZ9OYMU+c2lcFIppi8la4BVu96RGGM?=
 =?iso-8859-1?Q?0HZavTZsOCb2SKyv3LnMAL6G685Ij2o7RHYuoOwyXxUvq8r5teI9WsvGmG?=
 =?iso-8859-1?Q?+/fUyWeBujhI4an7J9DbtKXEe+WeilqERuXholn6kGQ2NTnhgTX/Wf/z7q?=
 =?iso-8859-1?Q?Gs058eSQ1bzCCuXUaK1QsHdo+XBuMvKydYEZntOYp1SeIo4w4aCOTMKtTz?=
 =?iso-8859-1?Q?vw+0EErd/A3IlSnL7504k2kXGbpUhaZPMwqVUUoIbYUHdH88Js72EDcOLu?=
 =?iso-8859-1?Q?u9r5zhLrj9YQjoBq2dDvOBh7ODoSkfAWAZlnzFDiLLKzoUe8meKvhIOQSp?=
 =?iso-8859-1?Q?04BoLjCShZ7JPbRLAs4pkTBGiFYwXgcMRcjYhD2Jyt9tWXs3WfWdeJ7Qkg?=
 =?iso-8859-1?Q?Tm+SAntyU/p7POyEeNn2/WraM4WA1AUCx6jHt3RWEa5lt6+K9fNTvkOFcW?=
 =?iso-8859-1?Q?4Vd1cmnHw16PXONg01gVfPG+dDafeZzgZjOqMyEMf3vg4KbKNeLBonkYXn?=
 =?iso-8859-1?Q?QGYj89b/xLwzFLcCaPHWYwGGsWv3XFd+ePxEg8pZkIyRzaUn8JmY3hRp0Y?=
 =?iso-8859-1?Q?Pu6lsVE3WsQNIZqSc1WMizuRAr2HlSWuFugxxrojoP9DGOGi42bBFOa+3z?=
 =?iso-8859-1?Q?Flq0nfU6dK8Rma+VR3lv8R0iBkD3CecsjStUwJpf0LEQog2udz0HD/Z7ZH?=
 =?iso-8859-1?Q?Bfu1ek140gbBwfbEoVy+EIO39pFBJU4Md/35MjmpyoUrqvT8xYNDXwNIv+?=
 =?iso-8859-1?Q?rDJ8ncChW41vjvwMZh8xRSQQJryJsQ9qp9HHmKHPKiy34VgdWfAQh56DmQ?=
 =?iso-8859-1?Q?9cMSIfr5dw=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: txc9wLDtyDAwsKRJvUynAilLyqqbzVbaRhM3khPZ1Ymighkt/UBR5Z5Jy+ITAxdVV34i3WwIhDD7lvacJG2X4e1pySoN/w4ueia3fhCzwxVCp91RJ7oqDYhQvNBDT84tQ9zEQrruAlxVC2cb7bVVWu2zpOsYkdXo5job8gbGDuTtpBXAd4398Wd2ljzx1gPmaiPDQr7lXBgXY+Hz25AFz2KCQe5AUAL4279f3OcNWNnZdwjemT7jGhvbC508YThCStDEalDrFslT7fy4Zpl7NecQ7iFPZ9cORSrlBzFSJoW6bI/jFcMKJdlKfcjkznhXYixKa/WsvAt1+xiJGfXFXw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA0PR11MB7185.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7160116d-5b5e-44fe-eca9-08de8968d078
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Mar 2026 05:47:20.0251 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 40ZWlV6LsPClUQGGSGjlbY07iPT4oieEOPH67mpn/Vf3Yss8rLzTdd1FqWqF1neuPdbS9gSvRkd76Wzc2in342aO2Dvs8no2YyR+DjHp3j0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPF25B1C4D24
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.18;
 envelope-from=vivek.kasireddy@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Hi Cedric,

> Subject: Re: [PATCH v12 07/10] vfio/device: Add support for creating
> dmabuf from multiple ranges
>=20
> On 3/19/26 06:15, Vivek Kasireddy wrote:
> > In order to create a dmabuf associated with a buffer that spans
> > multiple ranges, we first need to identify the VFIO region and
> > index the buffer (represented by iovec) belongs to and then
> > translate its addresses to offsets within that region.
> >
> > The qemu_ram_block_from_host() API gives us both the region and
> > the offset info we need to populate the dma ranges so that we can
> > invoke the VFIO_DEVICE_FEATURE_DMA_BUF feature to create the
> dmabuf.
> >
> > Also, instead of iterating over all QOM devices to find the
> > VFIODevice associated with a memory region, introduce a helper
> > to just use the vfio_device_list to lookup the VFIODevice.
> > And, introduce another helper lookup the VFIO region given an
> > address.
> >
> > Lastly, introduce an enum to return the type of error encountered
> > while creating the dmabuf fd.
> >
> > Cc: Alex Williamson <alex@shazbot.org>
> > Cc: C=E9dric Le Goater <clg@redhat.com>
> > Signed-off-by: Vivek Kasireddy <vivek.kasireddy@intel.com>
> > ---
> >   include/hw/vfio/vfio-device.h |  23 +++++++
> >   hw/vfio/device.c              | 114
> ++++++++++++++++++++++++++++++++++
> >   hw/vfio/dmabuf-stubs.c        |  17 +++++
> >   hw/vfio/meson.build           |   1 +
> >   4 files changed, 155 insertions(+)
> >   create mode 100644 hw/vfio/dmabuf-stubs.c
> >
> > diff --git a/include/hw/vfio/vfio-device.h b/include/hw/vfio/vfio-
> device.h
> > index 828a31c006..d46640ff53 100644
> > --- a/include/hw/vfio/vfio-device.h
> > +++ b/include/hw/vfio/vfio-device.h
> > @@ -41,6 +41,13 @@ enum {
> >       VFIO_DEVICE_TYPE_AP =3D 3,
> >   };
> >
> > +enum {
> > +    /* The Guest passed addresses stored in IOV are invalid */
> > +    VFIO_DMABUF_CREATE_ERR_INVALID_IOV =3D -1,
> > +    /* Guest or Host may be at fault for this type of error */
> > +    VFIO_DMABUF_CREATE_ERR_UNSPEC =3D -2,
> > +};
>=20
> Sorry, I am not convinced this is useful.
Ok, I'll move these error enums elsewhere or not use them in VFIO.
The goal/idea here is to identify the error case where Guest passed
in invalid addresses that do not belong to VFIO or virtio-gpu and log
them with qemu_log_mask(). In all other cases (of errors), we want
to categorize the errors as Host related and report them using
error_report_err().

We have done it this way because there is no way to know (ahead of
time) if the Guest passed addresses belong to VFIO or virtio-gpu or
invalid. So, we always first try to create a dmabuf via udmabuf and if
that fails, try via VFIO and then bail out with a qemu_log_mask() if we
cannot create a dmabuf via VFIO as well.

>=20
> > +
> >   typedef struct VFIODeviceOps VFIODeviceOps;
> >   typedef struct VFIODeviceIOOps VFIODeviceIOOps;
> >   typedef struct VFIOMigration VFIOMigration;
> > @@ -308,6 +315,22 @@ bool vfio_device_has_region_cap(VFIODevice
> *vbasedev, int region, uint16_t cap_t
> >
> >   int vfio_device_get_irq_info(VFIODevice *vbasedev, int index,
> >                                   struct vfio_irq_info *info);
> > +
> > +/**
> > + * Create a dmabuf fd by first translating the addresses in the
> > + * iovec array into VFIO region offsets and then invoking the
> > + * VFIO_DEVICE_FEATURE_DMA_BUF feature.
> > + *
> > + * @iov: array of iovec entries associated with a buffer
> > + * @iov_cnt: number of entries in the iovec array
> > + * @total_size: total size of the dmabuf
> > + * @errp: pointer to Error*, to store an error if it happens.
> > + *
> > + * Returns the created dmabuf fd or either
> VFIO_DMABUF_CREATE_ERR_UNSPEC
> > + * or VFIO_DMABUF_CREATE_ERR_INVALID_IOV on error.
> > + */
> > +int vfio_device_create_dmabuf_fd(struct iovec *iov, unsigned int
> iov_cnt,
> > +                                 size_t total_size, Error **errp);
> >   #endif
> >
> >   /* Returns 0 on success, or a negative errno. */
> > diff --git a/hw/vfio/device.c b/hw/vfio/device.c
> > index 973fc35b59..542c378913 100644
> > --- a/hw/vfio/device.c
> > +++ b/hw/vfio/device.c
> > @@ -21,7 +21,9 @@
> >   #include "qemu/osdep.h"
> >   #include <sys/ioctl.h>
> >
> > +#include "system/ramblock.h"
> >   #include "hw/vfio/vfio-device.h"
> > +#include "hw/vfio/vfio-region.h"
> >   #include "hw/vfio/pci.h"
> >   #include "hw/core/iommu.h"
> >   #include "hw/core/hw-error.h"
> > @@ -644,3 +646,115 @@ static VFIODeviceIOOps
> vfio_device_io_ops_ioctl =3D {
> >       .region_read =3D vfio_device_io_region_read,
> >       .region_write =3D vfio_device_io_region_write,
> >   };
> > +
> > +/*
> > + * This helper looks up the VFIODevice corresponding to the given
> iov. It
> > + * can be useful to determinine if a buffer (represented by the iov)
> belongs
> > + * to a VFIO device or not. This is mainly invoked when external
> components
> > + * such as virtio-gpu request creation of dmabuf fds for buffers that
> may
> > + * belong to a VFIO device.
> > + */
> > +static bool vfio_device_lookup(struct iovec *iov, VFIODevice
> **vbasedevp,
> > +                               RAMBlock **first_rbp, Error **errp)
> > +{
> > +    VFIODevice *vbasedev;
> > +    RAMBlock *first_rb;
> > +    ram_addr_t offset;
> > +
> > +    first_rb =3D qemu_ram_block_from_host(iov[0].iov_base, false,
> &offset);
> > +    if (!first_rb) {
> > +        error_setg(errp, "Could not find first ramblock\n");
> > +        return false;
> > +    }
> > +
> > +    *first_rbp =3D first_rb;
> > +    QLIST_FOREACH(vbasedev, &vfio_device_list, next) {
> > +        if (vbasedev->dev =3D=3D first_rb->mr->dev) {
> > +            *vbasedevp =3D vbasedev;
> > +            return true;
> > +        }
> > +    }
> > +    error_setg(errp, "No VFIO device found to create dmabuf from\n");
> > +    return false;
> > +}
> > +
> > +/*
> > + * This helper looks up the VFIORegion corresponding to the given
> address.
> > + * It also verifies that the RAMBlock associated with the address is
> the
> > + * same as the first_rb passed in. This is to ensure that all addresse=
s
> > + * in the iov belong to the same region.
> > + */
> > +static bool vfio_region_lookup(void *addr, VFIORegion **regionp,
> > +                               RAMBlock *first_rb, ram_addr_t *offsetp=
,
> > +                               Error **errp)
> > +{
> > +    VFIORegion *region;
> > +    RAMBlock *rb;
> > +
> > +    rb =3D qemu_ram_block_from_host(addr, false, offsetp);
> > +    if (!rb || rb !=3D first_rb) {
> > +        error_setg(errp, "Dmabuf segments must belong to the same
> region\n");
> > +        return false;
> > +    }
> > +
> > +    region =3D vfio_get_region_from_mr(rb->mr);
> > +    if (region) {
> > +        *regionp =3D region;
> > +        return true;
> > +    }
> > +    error_setg(errp, "Could not find valid region for dmabuf
> segment\n");
> > +    return false;
> > +}
> > +
> > +int vfio_device_create_dmabuf_fd(struct iovec *iov, unsigned int
> iov_cnt,
> > +                                 size_t total_size, Error **errp)
> > +{
> > +    g_autofree struct vfio_device_feature *feature =3D NULL;
> > +    struct vfio_device_feature_dma_buf *dma_buf;
> > +    RAMBlock *first_rb =3D NULL;
> > +    VFIODevice *vbasedev;
> > +    VFIORegion *region;
> > +    ram_addr_t offset;
> > +    size_t argsz;
> > +    int i, ret;
> > +
> > +    if (iov_size(iov, iov_cnt) !=3D total_size) {
> > +        error_setg(errp, "Total size of iov does not match dmabuf
> size\n");
> > +        return VFIO_DMABUF_CREATE_ERR_INVALID_IOV;
>=20
> This returned value is redundant with errp and error-prone for an API.
> I think you should find an alternative implementation. May be these
> routines simply do not belong to VFIO.
Ok, we'll try to explore an alternative that would probably not have these
error enums in VFIO.

>=20
>=20
> > +    }
> > +
> > +    if (!vfio_device_lookup(iov, &vbasedev, &first_rb, errp)) {
> > +        return VFIO_DMABUF_CREATE_ERR_INVALID_IOV;
> > +    }
> > +
> > +    argsz =3D sizeof(*feature) + sizeof (*dma_buf) +
> > +            sizeof(struct vfio_region_dma_range) * iov_cnt;
> > +    feature =3D g_malloc0(argsz);
> > +    *feature =3D (struct vfio_device_feature) {
> > +        .argsz =3D argsz,
> > +        .flags =3D VFIO_DEVICE_FEATURE_GET |
> VFIO_DEVICE_FEATURE_DMA_BUF,
> > +    };
> > +    dma_buf =3D (struct vfio_device_feature_dma_buf *)feature->data;
> > +
> > +    for (i =3D 0; i < iov_cnt; i++) {
> > +        if (!vfio_region_lookup(iov[i].iov_base, &region,
> > +                                first_rb, &offset, errp)) {
> > +            return VFIO_DMABUF_CREATE_ERR_INVALID_IOV;
> > +        }
> > +
> > +        dma_buf->region_index =3D region->nr;
> > +        dma_buf->dma_ranges[i].offset =3D offset;
> > +        dma_buf->dma_ranges[i].length =3D iov[i].iov_len;
> > +    }
> > +
> > +    dma_buf->nr_ranges =3D iov_cnt;
> > +    dma_buf->open_flags =3D O_RDONLY | O_CLOEXEC;
> > +
> > +    ret =3D vfio_device_get_feature(vbasedev, feature);
> > +    if (ret < 0) {
> > +        error_setg_errno(errp, -ret,
> > +                         "Could not create dmabuf fd via VFIO device")=
;
> > +        return VFIO_DMABUF_CREATE_ERR_UNSPEC;
> > +    }
> > +    return ret;
> > +}
> > diff --git a/hw/vfio/dmabuf-stubs.c b/hw/vfio/dmabuf-stubs.c
> > new file mode 100644
> > index 0000000000..374bd2a188
> > --- /dev/null
> > +++ b/hw/vfio/dmabuf-stubs.c
> > @@ -0,0 +1,17 @@
> > +/*
> > + * Copyright (c) 2026 Intel and/or its affiliates.
> > + *
> > + * SPDX-License-Identifier: GPL-2.0-or-later
> > + */
> > +
> > +#include "qemu/osdep.h"
> > +#include "qemu/error-report.h"
> > +#include "qemu/iov.h"
> > +#include "hw/vfio/vfio-device.h"
> > +
> > +int vfio_device_create_dmabuf_fd(struct iovec *iov, unsigned int
> iov_cnt,
> > +                                 size_t total_size, Error **errp)
> > +{
> > +    error_setg(errp, "VFIO dmabuf support is not enabled");
> > +    return VFIO_DMABUF_CREATE_HOST_ERROR;
>=20
> ../hw/vfio/dmabuf-stubs.c:16:12: error:
> 'VFIO_DMABUF_CREATE_HOST_ERROR' undeclared (first use in this
> function)
>     16 |     return VFIO_DMABUF_CREATE_HOST_ERROR;
Will fix it in the next version.

Thanks,
Vivek

>=20
> Thanks,
>=20
> C.
>=20
>=20
>=20
> > +}
> > diff --git a/hw/vfio/meson.build b/hw/vfio/meson.build
> > index 82f68698fb..ac899d30a8 100644
> > --- a/hw/vfio/meson.build
> > +++ b/hw/vfio/meson.build
> > @@ -34,3 +34,4 @@ system_ss.add(when: 'CONFIG_IOMMUFD',
> if_false: files('iommufd-stubs.c'))
> >   system_ss.add(when: 'CONFIG_VFIO_PCI', if_true: files(
> >     'display.c',
> >   ))
> > +system_ss.add(when: 'CONFIG_VFIO', if_false: files('dmabuf-stubs.c'))


