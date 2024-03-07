Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6654EC48BF6
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Mar 2024 06:46:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ri7VZ-00020e-Ae; Thu, 07 Mar 2024 01:45:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yuan1.liu@intel.com>)
 id 1ri7VV-0001zM-LT
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 01:45:34 -0500
Received: from mgamail.intel.com ([198.175.65.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yuan1.liu@intel.com>)
 id 1ri7VI-0004fC-EP
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 01:45:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1709793920; x=1741329920;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=NtzR9qEmorDqLN1B/zpm+azDn2+eo8csby7+ocv06WE=;
 b=GDhXXsMBPmVQDDVSKNXoX9lnVQwt84qagGJ+oqz0dKMek80zWyFTup9Y
 p6ppVJKM0WVO0rUzkCe7uqLZKzIK6iHjS2gqcjV2fpO+SPH74PG4dkhmL
 EIwObU/NehCidThBH5VYD0epZEoSVp+3Bi6lJMQikCrDraFd58pGVoGix
 t6UoWoWvwHfOfJ0nj15FcoUrFr4c0+OPnjkWCUs6tGlxyo/9H6T843lUa
 DjYjkoqAT5rcRMT0oIc8sEozB5YurkpnzZEGDEjc5AeXiGqe052u5xbc/
 rz7O4Gq4pN6ZjvkcaflMMvUP7s/Z3McWtfZ/iSJNEtFkw7P7+eOylxlZq g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11005"; a="15883204"
X-IronPort-AV: E=Sophos;i="6.06,210,1705392000"; d="scan'208";a="15883204"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Mar 2024 22:45:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,210,1705392000"; d="scan'208";a="14669887"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
 by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 06 Mar 2024 22:45:18 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 6 Mar 2024 22:45:16 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 6 Mar 2024 22:45:16 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 6 Mar 2024 22:45:16 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 6 Mar 2024 22:45:15 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O/NCmWoK/rbCsah/zNjXWpJ8QVvFpGSRE/kpI9wR/RwG8XOQb+6jj1EzmJ4KmJScgSmxnVuWWKnfgpauv8UIimY9+OseJjYAuZ3qNpyigG4Vv1N0Gc4K9ElcjOny1BufskTMqk432SGQPYUu+Te2uyVaGqWqolmsaHzndCXOmucbjIWa88sPLUcCYbOTbsZON+u0HSz1DX2vsyyxigthzkmt0YnZc3O7tuu0KFS0r38F/bkdcFEPRjvpr8FpiiEXbcH+wQkDp4lAy273uVYXSY7ryHJAM9BL7iEGCJZo4slbghvHxoSgYJUItz0DP8zTv3ZKz09O/0LsyWa/9UqplQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qQAKyVbjC5eyxEHUYqvJhZtEMqH1iAb4MBuMn17tzpI=;
 b=W1zVftmXNq+vagtS3k+wQK94mSNPBYjYRma4/XPbfScdWCD+08zyZTjVBzNit8u6gloQy9T2ygCBMxaACDgQiWbQ5aYdVZLQNOrDGw1uTETce/xSHe6hi/NIZ/xEDxS4QmK4ke6oT9SHqggE+qefZeYdS3NBJx7UgNHsBPKQaIqMJeWKrGmSCykF4CfyHMiJgAIRAO4pJ/V1AubdQ4W891DUARqn+jxUlbAyOfPe+A+McyEJORt4MLQ8MtUpK5HTAzCdMvIO0vlhGS/PXpQ7+oJEus5zFaHxXWuutvMOt+0qxvC+bJI2GOWdxaeHJZ2KjO2o6g1DIXyIScnFRE6LAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB5941.namprd11.prod.outlook.com (2603:10b6:510:13d::20)
 by SA1PR11MB8595.namprd11.prod.outlook.com (2603:10b6:806:3a9::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.23; Thu, 7 Mar
 2024 06:45:13 +0000
Received: from PH7PR11MB5941.namprd11.prod.outlook.com
 ([fe80::f926:1804:73ce:ca52]) by PH7PR11MB5941.namprd11.prod.outlook.com
 ([fe80::f926:1804:73ce:ca52%4]) with mapi id 15.20.7386.005; Thu, 7 Mar 2024
 06:45:13 +0000
From: "Liu, Yuan1" <yuan1.liu@intel.com>
To: Fabiano Rosas <farosas@suse.de>, "peterx@redhat.com" <peterx@redhat.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "hao.xiang@bytedance.com"
 <hao.xiang@bytedance.com>, "bryan.zhang@bytedance.com"
 <bryan.zhang@bytedance.com>, "Zou, Nanhai" <nanhai.zou@intel.com>
Subject: RE: [PATCH v4 3/8] configure: add --enable-qpl build option
Thread-Topic: [PATCH v4 3/8] configure: add --enable-qpl build option
Thread-Index: AQHabsC3NX5eKOeUXku7+l0f1318PLEpmuKAgABSMnCAALABgIABOuTg
Date: Thu, 7 Mar 2024 06:45:13 +0000
Message-ID: <PH7PR11MB5941DF4F2B00AE1DFAC01AE7A3202@PH7PR11MB5941.namprd11.prod.outlook.com>
References: <20240304140028.1590649-1-yuan1.liu@intel.com>
 <20240304140028.1590649-4-yuan1.liu@intel.com> <874jdkifna.fsf@suse.de>
 <PH7PR11MB59415A25C34ABC6C373B3324A3212@PH7PR11MB5941.namprd11.prod.outlook.com>
 <87v85zshem.fsf@suse.de>
In-Reply-To: <87v85zshem.fsf@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB5941:EE_|SA1PR11MB8595:EE_
x-ms-office365-filtering-correlation-id: 3ec1f13f-e597-4edf-01f3-08dc3e722470
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lKr/ycP8llliFiixxNOxlVNDO7no04jBIdkLyOK6feip7+dygYw0Z5gGQEmNLqClvOQ6ZvYLSRdfTzeyHB7IKHWxmSLSu1JhDP4f6rkbLD3OIYeQn83iyylBYSkLD1+uKVzm6PiLS3VFC7BSMZizOTAyxKbXOvNdgOjXysC+WE+jPvyKjvYG24PblXOwSA7o2dolPaY5rwgrnHk7Y9ahl14DgHA83i697X30e02PL/ai/XjHFRd3N9wfbvQOM5Evt/osTeqlDH4vMiRScQocf8YjEhPlCDnARQRKz8ZxWvWcYRR2FTrzDSOumVdmZX0JomrY1ncm3kGfmBuJ3fNkMq1mbwih3s0rHxYuO/5/EADkllST9EhLKo2O8fas1b7REutCD9/5hm5W35SRs+sXfm+RdUmTN3u1HA/TwrsMOVfOrF/PFeq27dgQYY6j5iXGkDAW53iPmDEfPNkOrUppzzGBt4JAYOYKqScwCTMqWQCf5Uf1ySUcTSJ8zV76vX5ET7iBvHdNy2u1YSued26mVyJa87FhX/Anq9jQbX+iA0HQxEPvmzs1e9SOL3xt0pxWeBJuxSk7X3JdV6xwAZKe9virvV7aaoW6c6zKLVxrqqIWQcr9fGo8x64tiBDMSi5OGupXttTzFG4QEdpZFdrV7EUtuZAmtqh12s4iudQaNQg=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR11MB5941.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?NE9Dh+V3ErQI2shWIvzG4BCh3dKmwQVkgo1yAxXiDCDcLYNOKY5zdB0K9a3V?=
 =?us-ascii?Q?w55B0xByXcpJRh022qt8zrJt0SrHHNNksmjJK+lna/y12mdFeQEkFURfxfJg?=
 =?us-ascii?Q?Wc03sJb9tXPYWliS2OqirS9UMBsfKMTI2OTkHvnVQcI81RpxSaPrgIAZd8EL?=
 =?us-ascii?Q?LgcYgrN4+qkCzoHOGLEq4uU+yK7x3C0Oo9R1El1od1v78Wjof+R1NR5ZZdK4?=
 =?us-ascii?Q?FP35/h5WR4s0WeQ9khTbtULeV5jxM34ZxHfbijSV3axtZT5pPCIz/Azc8eqR?=
 =?us-ascii?Q?/zSILDV/3Ca6OdHJNjSJnSNrghMk/94lkPU603Ddyd1K0Wp+jbK/Hzu3qcEz?=
 =?us-ascii?Q?IHxchnvhUmIRUz43mtZRKn6pQWUdbJi9pcqGM0OucS9+o62VccnJImxoLd43?=
 =?us-ascii?Q?ztxJWBM5W7kTu5+BbG3mM4NRPNw0r51fsjNQiu0+z8rgsbEt6x1GtQdYaY/D?=
 =?us-ascii?Q?qY2pHY9cu7ZjwwTR0hRiD/e0d+vtEp6Ig2C2zlwDQpMhb2wrYaBE7NclaXt7?=
 =?us-ascii?Q?3Vu+WHjmbhZBC0eq3kXkJ4N+8gOtrq2qxADE5QiJvoVerZcJRokmW9OaoRa+?=
 =?us-ascii?Q?+G+g3qJxPF55w/twiS43fCHYRahqn8fYON+Hqxj8V8Dftp7DHrTn/blK7wlr?=
 =?us-ascii?Q?SccCQ22648UMp46VFN7X9zO9e0huCZpvDJNVRB0bMTyvfPcad62RgmegqgPh?=
 =?us-ascii?Q?D4ljz1Racsehwpb2HMe6FR5pbk9Ij2GPoL5lxiQS1L4TSpUvQvDu5+wB939t?=
 =?us-ascii?Q?FgVLV7t1kc+nklfWlWebM4I10oGrjyzx66qVEKp4CtjsAFmMeqxLYkPoQAgC?=
 =?us-ascii?Q?VpJxoBYJnOV/pRm7j4HljGEK14/wpbhwa24ezGgrnXWarlQZN1seIT7Q5/Uo?=
 =?us-ascii?Q?+dr8Io1X4abO+/B3sQYCJcml2tuE87dlZlVG4BkyYOpUabs+ekIMUghr8iRE?=
 =?us-ascii?Q?WPXGhICbAu1GOggWMPRQCX7wfB926Zb0MuR+ouFJLq4peVR7zSgyeLlI7Kyw?=
 =?us-ascii?Q?gzDIQTJkLTf9oGqF+610INrFwiIdK9gmsQwy8+/yzHtBNg1N47bOxc59I/Id?=
 =?us-ascii?Q?yUOMRzPdxQYgqcxGzMFwggwGKke3UCWmDj0SIMgleCyiXNfxbcWzddSpKFzG?=
 =?us-ascii?Q?pHaairOSsA4QBuzEb8zv3QWY001cN2MohxJO+XE+xuMaBU+SWJ98+nOISXba?=
 =?us-ascii?Q?84dlFVed0oXu2rFR5OWTHxSo4Ci+0/X4YkCHnDayvco4obZeQl9qBEn6KlIL?=
 =?us-ascii?Q?yCrovXe4QoSUf/A5guIZ1KmAKYaVKb169wYKksUTzWeLCDpt3Ct4+OuwMqjD?=
 =?us-ascii?Q?+yGiFQjLquiQxOtZU3i8inkytTdxQENLxPR2mGleusQQ62/HMErxFgZsoNhG?=
 =?us-ascii?Q?44/RS44EWGT25pCfNrOljKcbhv7FGKc4oxolXyAI9IEgLZOoV+8I/wW9Mo5U?=
 =?us-ascii?Q?KfWwPCQnkB3O6FFC/nNx8DW9grAmE8sJxKmTzrhuQWNfZtJgee1iCI65gba5?=
 =?us-ascii?Q?SS1vHS/T3k81QWN06r6Ur35hQzSt8CqHoxUYFEEV81Pd6Z7lj17s/srkV3Gb?=
 =?us-ascii?Q?Yv1fjhwYiaJX8rdORXrU2Xuqs/lvq6JX2BvSITqj?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5941.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ec1f13f-e597-4edf-01f3-08dc3e722470
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Mar 2024 06:45:13.8032 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3iPQ/OMhmNTMtdwNegzCiKvT6hzSUalXUoMZ7M343VaVMBEhJSJ2x4bx5MyPdTMKvyGPgsD+R+KX3DLP/y0VLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8595
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.12; envelope-from=yuan1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.365,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
> From: Fabiano Rosas <farosas@suse.de>
> Sent: Wednesday, March 6, 2024 7:56 PM
> To: Liu, Yuan1 <yuan1.liu@intel.com>; peterx@redhat.com
> Cc: qemu-devel@nongnu.org; hao.xiang@bytedance.com;
> bryan.zhang@bytedance.com; Zou, Nanhai <nanhai.zou@intel.com>
> Subject: RE: [PATCH v4 3/8] configure: add --enable-qpl build option
>=20
> "Liu, Yuan1" <yuan1.liu@intel.com> writes:
>=20
> >> -----Original Message-----
> >> From: Fabiano Rosas <farosas@suse.de>
> >> Sent: Wednesday, March 6, 2024 4:32 AM
> >> To: Liu, Yuan1 <yuan1.liu@intel.com>; peterx@redhat.com
> >> Cc: qemu-devel@nongnu.org; hao.xiang@bytedance.com;
> >> bryan.zhang@bytedance.com; Liu, Yuan1 <yuan1.liu@intel.com>; Zou,
> Nanhai
> >> <nanhai.zou@intel.com>
> >> Subject: Re: [PATCH v4 3/8] configure: add --enable-qpl build option
> >>
> >> Yuan Liu <yuan1.liu@intel.com> writes:
> >>
> >> > add --enable-qpl and --disable-qpl options to enable and disable
> >> > the QPL compression method for multifd migration.
> >> >
> >> > the Query Processing Library (QPL) is an open-source library
> >> > that supports data compression and decompression features.
> >> >
> >> > The QPL compression is based on the deflate compression algorithm
> >> > and use Intel In-Memory Analytics Accelerator(IAA) hardware for
> >> > compression and decompression acceleration.
> >> >
> >> > Please refer to the following for more information about QPL
> >> >
> >>
> https://intel.github.io/qpl/documentation/introduction_docs/introduction.=
h
> >> tml
> >> >
> >> > Signed-off-by: Yuan Liu <yuan1.liu@intel.com>
> >> > Reviewed-by: Nanhai Zou <nanhai.zou@intel.com>
> >> > ---
> >> >  meson.build                   | 18 ++++++++++++++++++
> >> >  meson_options.txt             |  2 ++
> >> >  scripts/meson-buildoptions.sh |  3 +++
> >> >  3 files changed, 23 insertions(+)
> >> >
> >> > diff --git a/meson.build b/meson.build
> >> > index c1dc83e4c0..2dea1e6834 100644
> >> > --- a/meson.build
> >> > +++ b/meson.build
> >> > @@ -1197,6 +1197,22 @@ if not get_option('zstd').auto() or have_bloc=
k
> >> >                      required: get_option('zstd'),
> >> >                      method: 'pkg-config')
> >> >  endif
> >> > +qpl =3D not_found
> >> > +if not get_option('qpl').auto()
> >> > +  libqpl =3D cc.find_library('qpl', required: false)
> >> > +  if not libqpl.found()
> >> > +    error('libqpl not found, please install it from ' +
> >> > +
> >>
> 'https://intel.github.io/qpl/documentation/get_started_docs/installation.=
h
> >> tml')
> >> > +  endif
> >> > +  libaccel =3D cc.find_library('accel-config', required: false)
> >> > +  if not libaccel.found()
> >> > +    error('libaccel-config not found, please install it from ' +
> >> > +    'https://github.com/intel/idxd-config')
> >>
> >> accel-config seems to be packaged by many distros, I'm not sure we nee=
d
> >> to reference the repository here.
> >>
> >> https://repology.org/project/accel-config/versions
> >
> > Yes, accel-config has been added to many distributions, I will use
> pkgconfig to
> > detect the libaccel and the version(at least v4.0).
> >
> > I have a question, I didn't find accel-config installation package from
> > https://repology.org/project/accel-config/versions. Does using this lin=
k
> also
> > require the user to build an accel-config package, and then install it?
>=20
> That is just an aggregated list of distros and the version of the
> package they provide in their repos. So I'm just pointing out to you
> that there seems to be a packaged accel-config for most distros
> already. Which means we just want to say "install accel-config" and
> users should be able to use their distro's package manager.
>=20
> >
> > It is easy to install accel-config using the installation package, but =
I
> didn't
> > find a repo that provides accel-config installation packages for most
> distributions.
> >
> > First check accel-config is available through pktconfig, and if it is
> not available,
> > prompts users to install it from https://github.com/intel/idxd-config,
> is it OK?
>=20
> There's no need, just check if its available and suggest the user to
> install it. We already have the link in the docs.

Get it, thanks~

> >
> >> > +  endif
> >> > +  qpl =3D declare_dependency(dependencies: [libqpl, libaccel,
> >> > +        cc.find_library('dl', required: get_option('qpl'))],
> >> > +        link_args: ['-lstdc++'])
> >> > +endif
> >> >  virgl =3D not_found
> >> >
> >> >  have_vhost_user_gpu =3D have_tools and host_os =3D=3D 'linux' and
> >> pixman.found()
> >> > @@ -2298,6 +2314,7 @@ config_host_data.set('CONFIG_MALLOC_TRIM',
> >> has_malloc_trim)
> >> >  config_host_data.set('CONFIG_STATX', has_statx)
> >> >  config_host_data.set('CONFIG_STATX_MNT_ID', has_statx_mnt_id)
> >> >  config_host_data.set('CONFIG_ZSTD', zstd.found())
> >> > +config_host_data.set('CONFIG_QPL', qpl.found())
> >> >  config_host_data.set('CONFIG_FUSE', fuse.found())
> >> >  config_host_data.set('CONFIG_FUSE_LSEEK', fuse_lseek.found())
> >> >  config_host_data.set('CONFIG_SPICE_PROTOCOL',
> spice_protocol.found())
> >> > @@ -4438,6 +4455,7 @@ summary_info +=3D {'snappy support':    snappy=
}
> >> >  summary_info +=3D {'bzip2 support':     libbzip2}
> >> >  summary_info +=3D {'lzfse support':     liblzfse}
> >> >  summary_info +=3D {'zstd support':      zstd}
> >> > +summary_info +=3D {'Query Processing Library support': qpl}
> >> >  summary_info +=3D {'NUMA host support': numa}
> >> >  summary_info +=3D {'capstone':          capstone}
> >> >  summary_info +=3D {'libpmem support':   libpmem}
> >> > diff --git a/meson_options.txt b/meson_options.txt
> >> > index 0a99a059ec..06cd675572 100644
> >> > --- a/meson_options.txt
> >> > +++ b/meson_options.txt
> >> > @@ -259,6 +259,8 @@ option('xkbcommon', type : 'feature', value :
> >> 'auto',
> >> >         description: 'xkbcommon support')
> >> >  option('zstd', type : 'feature', value : 'auto',
> >> >         description: 'zstd compression support')
> >> > +option('qpl', type : 'feature', value : 'auto',
> >> > +       description: 'Query Processing Library support')
> >> >  option('fuse', type: 'feature', value: 'auto',
> >> >         description: 'FUSE block device export')
> >> >  option('fuse_lseek', type : 'feature', value : 'auto',
> >> > diff --git a/scripts/meson-buildoptions.sh b/scripts/meson-
> >> buildoptions.sh
> >> > index 680fa3f581..784f74fde9 100644
> >> > --- a/scripts/meson-buildoptions.sh
> >> > +++ b/scripts/meson-buildoptions.sh
> >> > @@ -222,6 +222,7 @@ meson_options_help() {
> >> >    printf "%s\n" '                  Xen PCI passthrough support'
> >> >    printf "%s\n" '  xkbcommon       xkbcommon support'
> >> >    printf "%s\n" '  zstd            zstd compression support'
> >> > +  printf "%s\n" '  qpl             Query Processing Library support=
'
> >> >  }
> >> >  _meson_option_parse() {
> >> >    case $1 in
> >> > @@ -562,6 +563,8 @@ _meson_option_parse() {
> >> >      --disable-xkbcommon) printf "%s" -Dxkbcommon=3Ddisabled ;;
> >> >      --enable-zstd) printf "%s" -Dzstd=3Denabled ;;
> >> >      --disable-zstd) printf "%s" -Dzstd=3Ddisabled ;;
> >> > +    --enable-qpl) printf "%s" -Dqpl=3Denabled ;;
> >> > +    --disable-qpl) printf "%s" -Dqpl=3Ddisabled ;;
> >> >      *) return 1 ;;
> >> >    esac
> >> >  }

