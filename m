Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69569C54E49
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Mar 2024 02:21:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhgtO-0007ne-A4; Tue, 05 Mar 2024 21:20:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yuan1.liu@intel.com>)
 id 1rhgtK-0007nT-J0
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 21:20:24 -0500
Received: from mgamail.intel.com ([192.198.163.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yuan1.liu@intel.com>)
 id 1rhgtG-000118-0o
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 21:20:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1709691618; x=1741227618;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=ix2c9Sc8sf1ONt/ma29ve5LftvzkLuPyPW14jZY4RO8=;
 b=Pp5g863oaWo+1NNS11qXrWaVFaz4iEq4HNusQSuM+A3J8Lrm/v55Zk8i
 E31lxpRJdkfG8yK97yYc5Ob3Fnnle4bHOTR7kKqulOUhSlFu2K7YLOpYz
 mejXh/BormqrBJ0wQ/8FjVfC1sui6Nkg5e81TGjsQgajk6oZVUqtTT+lb
 RNUp12bhLRZqZNQiJ6h3kdbS5HCpau0k3udfFAyIxp4c2blIoozDikQky
 iOGgbnaCaXLpMMM8pDtGK1FK98lF+OMw0Rxzd3ivcFFaqLEMueB67VK5c
 xTP3CHq9xUs0xO4jU5mcF8bPyxyepAmj/z38Bgn+uud+WR/cX+Zb2FAGd w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11004"; a="4862561"
X-IronPort-AV: E=Sophos;i="6.06,207,1705392000"; 
   d="scan'208";a="4862561"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Mar 2024 18:20:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,207,1705392000"; d="scan'208";a="14155740"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
 by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 05 Mar 2024 18:20:15 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 5 Mar 2024 18:20:14 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 5 Mar 2024 18:20:14 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 5 Mar 2024 18:20:14 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PO2HEvyosp3IJydCFbua9wNmvp2GrRENqAS+6wIZR3p5SxUgVTNyl8dLExErgxtcz5BakKiYxPvzmGkaXZ2PjPhyINpH6h11t6QN4vtB+By0RQ3ayCgMLd0lkwk12Hq5h/ckjl9OuJAyfaXfZ4iiqU4z47vB3lyW6rcm8qG5xTg4hj+ZuAxVlxfaNHsXVBB1JPy2a/TneBZQaCCXxLgcprFDFYOwN9zrA7xhrADnKJWaC/4+2N0On+K9dgVt3rKIeVr2D+MoDMRWdGn4STSBOuglhVixYgDCZ8RloJXDJioyluuLMgN6K7+LIoFqvRj0AGgeuIPc9VcLjcE9mhL9/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=poPRy2P9IH1ijxkiDH+wBRZE2VceWcdwx7V9Vc+FHmE=;
 b=eEczNWeClH3mMsJC5zSA4z+ybmQSrG67OEzr9fruX+D+uQnY2jJFRAon08ScdWuDSjsxEERBi9SQtzcb2tCBSEjUqQhH7NDXscOPxwAmmw0MTurz/Huut2+F0cN7YQXcBXUJbGa+r36q9Rn0ZCCALnim6YFHcf1tnuYC7LJffxsFpMjKNZD4FNqvjVBc6T5GfFUramaLPHXuaOSyk4UYM0Y+sK8x6BIO9l7y2PRUOawQCnGhrFc9FplVcckuEtw4gStZJy1kTvzfu39RbyJV4IWXu59fCnubjqsOcK3vcH+76bKPdGpSAfVjgg3K3VLn6n5cfQzbhUVXtBGJQTR94Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB5941.namprd11.prod.outlook.com (2603:10b6:510:13d::20)
 by MN2PR11MB4662.namprd11.prod.outlook.com (2603:10b6:208:263::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.24; Wed, 6 Mar
 2024 02:20:12 +0000
Received: from PH7PR11MB5941.namprd11.prod.outlook.com
 ([fe80::f0ec:877c:fd93:a04c]) by PH7PR11MB5941.namprd11.prod.outlook.com
 ([fe80::f0ec:877c:fd93:a04c%3]) with mapi id 15.20.7362.019; Wed, 6 Mar 2024
 02:20:12 +0000
From: "Liu, Yuan1" <yuan1.liu@intel.com>
To: Fabiano Rosas <farosas@suse.de>, "peterx@redhat.com" <peterx@redhat.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "hao.xiang@bytedance.com"
 <hao.xiang@bytedance.com>, "bryan.zhang@bytedance.com"
 <bryan.zhang@bytedance.com>, "Zou, Nanhai" <nanhai.zou@intel.com>
Subject: RE: [PATCH v4 3/8] configure: add --enable-qpl build option
Thread-Topic: [PATCH v4 3/8] configure: add --enable-qpl build option
Thread-Index: AQHabsC3NX5eKOeUXku7+l0f1318PLEpmuKAgABSMnA=
Date: Wed, 6 Mar 2024 02:20:11 +0000
Message-ID: <PH7PR11MB59415A25C34ABC6C373B3324A3212@PH7PR11MB5941.namprd11.prod.outlook.com>
References: <20240304140028.1590649-1-yuan1.liu@intel.com>
 <20240304140028.1590649-4-yuan1.liu@intel.com> <874jdkifna.fsf@suse.de>
In-Reply-To: <874jdkifna.fsf@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB5941:EE_|MN2PR11MB4662:EE_
x-ms-office365-filtering-correlation-id: b81826f2-6a0c-4ce5-458c-08dc3d83f3cf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qfcmQqfcfh6YFj06vfMo4nYf6UkCeumiE9MRTRaMNDbmsQEMRNScCnQM5UDuYHEfsv8DY6nCRmT2DRknKjMsjNaaA7o7DbH0WTtVKHMyi1tMBF3guuXIHwqIVWeuCo4gezJyHIP95gdXneDpeYOtWae4WB9rfMJBg+nTGog/PFKh91YJfzQdu+Q/tdKuEmTjp7G7r5/14VvvAWokfkpe83HJZ+LdJMZ3vadDXK90EOaPlP6sScJdOKOjyp821xHeJlue+gb2fmyOQ1CYOKtsF9xEc5kRJqOJNDiNqb1ysktNrqRgO2OP1eO/vHcWfx0Lx5eQnqvupk8ER3MKC8uiYeVy0iuvKumIix6GCaB9xE1cUKpSbv1EHTNTA6w003N8FOLlg7kFrVg9JtbrA9LZdtcx1vnXgWbCHKw33pifYNQjncLgZ9hS+xmEhdJlmiDDfim/hnFRI4q37hB38t/zggjEaxCrmNwU9cAJgPL0GUZCkgqWK80QVlORtxoN8n+Z/6PDDLiAxWAoSRI2eqNob7RmvdBzuAtD56TZ5leYchOvgJcjz+xHP01bjM4n7mrYTizSt0uZJkVpnkw7Cy0pJBHUruI2rOgOACJ8sqp+lxj+x3eJcn+6mkm4p++p3099knkXU6LJ2BX1f+UNbg+xvWuqKN4hJm8A/qSCno8CzPN4L8b6w2zwunQx0B72cPwW
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR11MB5941.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?xs69Iv+++cSbFGuUNeEoublqXP8wORJaDhksR8tiniVbSa6KJqBEZMCSjn11?=
 =?us-ascii?Q?qu/NaYKSxgcoZwD5GvjiuFyP9eNpaU7lnJ1hLeQpMDhMCWH9mObiimC6M86x?=
 =?us-ascii?Q?AA1A228xzcjIYDs+9ehcYBjPSnjrdmAyN8MJSu7yDBimggH92OrVFW8G5I2f?=
 =?us-ascii?Q?aWK10x5/4jabvYIjQYeliwIelolRRDI3cn/ePz5ZYRksXcMmL+IaocT9FFQn?=
 =?us-ascii?Q?4xGNkhOHyRgq/u49iP6yI8iBkeDqqtRoPf8DUPPY3LPqn2d8MhJvQcMJwyvb?=
 =?us-ascii?Q?VwDjxZhMZHEKrpPxCrSW6gwDoAGKk6LymXPRyiM6xtjiGmmPbla/Xdk+RB13?=
 =?us-ascii?Q?INnTCPn9FrdLiLtkZYcW6Owym25BRgBBmSKlf0cqtyq/QwBGs0cPj6ZpXJUN?=
 =?us-ascii?Q?Wf7kwpWJxhV/cTBUKG53OXqYj4IkudpZeCv+gOj9NB1CAIprV7+gyQSOMJSz?=
 =?us-ascii?Q?7dS85rcoGRLi4BkKEQ4I1SJoYK5RuPVCb6PR6uvC8NEATAqL0NlO/JbHWAeQ?=
 =?us-ascii?Q?9zKIKvN293g1XnW01pP54L8PFAIG8mtQIktXxEPVE1NqCZo9M2ZM2Ttb/rQM?=
 =?us-ascii?Q?UF7LlnLEOUMk/KPqCdhmrDu//z+54LrbM2dk3oKXC8W0vTSCgblEqdRgk4ZH?=
 =?us-ascii?Q?jSV/ls5iAbQCc0TSe8pJxS9j0KT3hUqQwdwDkUEpZKsxRq+VnBYCBsCkfRHt?=
 =?us-ascii?Q?xXbS05ltakt0YfAoyv8wV9LGPx4u/f7YZVH4mDKBiMQOCrx828tLvqPPicqM?=
 =?us-ascii?Q?TmpcgDjXQJOfNzRIGWCDDhpPtXuvqMmfT6ZOkWZ748Vi94S6C+HmNFdTirEn?=
 =?us-ascii?Q?GG/wgL0m55m6oOSXDAnA8qVTp6wcNelDRjgymYj0s4OFJytVduORnVZEGeHT?=
 =?us-ascii?Q?eHuPcHcwzCJ7guGhGOAZuHDmVV0lDhG0XbwCMGlkzJivtX2Z5osZ/f6yQZRy?=
 =?us-ascii?Q?fXKvwkZoX90vurrITRkzB0hFgjuH2JPEVDUK7SSTTpk59GmT6JNaHjn+aQZ6?=
 =?us-ascii?Q?bmgo66YQGxeR2izrBaLB4okScNipj71AtAWN2QhxR8pN7ThY7L/79kblYPtx?=
 =?us-ascii?Q?Ej7252e8enGUKUr8rzcNrOaYfKKZekpPFFneKCMCQvHGbxZYG35+g4f9lUuF?=
 =?us-ascii?Q?9ByiVjHsMmDMRyyupw7lhHCUMkNIkiSyM8/sk3hWLpuCH7ATxRHo/hWa8rS1?=
 =?us-ascii?Q?rUng672qdrh0f5GovlrCrUix2aljaE7d5NRwU/mh+pqQc6Cc8B159xiSfgUY?=
 =?us-ascii?Q?ZEgUhUzM9qcbkNI0KVvVPVfJHIqPOdlAEvDrfqEIAo0twA2JoG52t0U0aU4R?=
 =?us-ascii?Q?yqsnMqETt3aSGgbH3bE/h3ai4azdVQPViVPl4RUA9NZLPaIqWEr25vd7oT2J?=
 =?us-ascii?Q?gb2u6Z8JNS6X6Js//jL9U8cUVYu3E/b6UytbJGH9f3jaB69bHYHaCADfL9F1?=
 =?us-ascii?Q?DK5qBBzcFo4FLy1CRuvw22tz8ViOHG64Sw4yOlX+e5p8pWnPWR9RKNOKBVkQ?=
 =?us-ascii?Q?SPV682wGO+jgmWWt9UFbV4o1u4HKy38gg9tTRY0JttRswb2E2bQQTzTuwutC?=
 =?us-ascii?Q?UziY9aC2jIgqkVULINsXkzduls1eXhZ9JTVP7lE/?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5941.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b81826f2-6a0c-4ce5-458c-08dc3d83f3cf
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Mar 2024 02:20:12.0026 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: j1VqN0K+I0gaaeoEX0ewko+Khfqn+fcVW/5Wkqg0Y1st3hqOmge0qzL8gOp7Lmkcxj2eyThMjpYqr3lRY/vOrw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4662
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.16; envelope-from=yuan1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.568,
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
> Sent: Wednesday, March 6, 2024 4:32 AM
> To: Liu, Yuan1 <yuan1.liu@intel.com>; peterx@redhat.com
> Cc: qemu-devel@nongnu.org; hao.xiang@bytedance.com;
> bryan.zhang@bytedance.com; Liu, Yuan1 <yuan1.liu@intel.com>; Zou, Nanhai
> <nanhai.zou@intel.com>
> Subject: Re: [PATCH v4 3/8] configure: add --enable-qpl build option
>=20
> Yuan Liu <yuan1.liu@intel.com> writes:
>=20
> > add --enable-qpl and --disable-qpl options to enable and disable
> > the QPL compression method for multifd migration.
> >
> > the Query Processing Library (QPL) is an open-source library
> > that supports data compression and decompression features.
> >
> > The QPL compression is based on the deflate compression algorithm
> > and use Intel In-Memory Analytics Accelerator(IAA) hardware for
> > compression and decompression acceleration.
> >
> > Please refer to the following for more information about QPL
> >
> https://intel.github.io/qpl/documentation/introduction_docs/introduction.=
h
> tml
> >
> > Signed-off-by: Yuan Liu <yuan1.liu@intel.com>
> > Reviewed-by: Nanhai Zou <nanhai.zou@intel.com>
> > ---
> >  meson.build                   | 18 ++++++++++++++++++
> >  meson_options.txt             |  2 ++
> >  scripts/meson-buildoptions.sh |  3 +++
> >  3 files changed, 23 insertions(+)
> >
> > diff --git a/meson.build b/meson.build
> > index c1dc83e4c0..2dea1e6834 100644
> > --- a/meson.build
> > +++ b/meson.build
> > @@ -1197,6 +1197,22 @@ if not get_option('zstd').auto() or have_block
> >                      required: get_option('zstd'),
> >                      method: 'pkg-config')
> >  endif
> > +qpl =3D not_found
> > +if not get_option('qpl').auto()
> > +  libqpl =3D cc.find_library('qpl', required: false)
> > +  if not libqpl.found()
> > +    error('libqpl not found, please install it from ' +
> > +
> 'https://intel.github.io/qpl/documentation/get_started_docs/installation.=
h
> tml')
> > +  endif
> > +  libaccel =3D cc.find_library('accel-config', required: false)
> > +  if not libaccel.found()
> > +    error('libaccel-config not found, please install it from ' +
> > +    'https://github.com/intel/idxd-config')
>=20
> accel-config seems to be packaged by many distros, I'm not sure we need
> to reference the repository here.
>=20
> https://repology.org/project/accel-config/versions

Yes, accel-config has been added to many distributions, I will use pkgconfi=
g to=20
detect the libaccel and the version(at least v4.0).=20

I have a question, I didn't find accel-config installation package from=20
https://repology.org/project/accel-config/versions. Does using this link al=
so=20
require the user to build an accel-config package, and then install it?

It is easy to install accel-config using the installation package, but I di=
dn't=20
find a repo that provides accel-config installation packages for most distr=
ibutions.

First check accel-config is available through pktconfig, and if it is not a=
vailable,
prompts users to install it from https://github.com/intel/idxd-config, is i=
t OK?

> > +  endif
> > +  qpl =3D declare_dependency(dependencies: [libqpl, libaccel,
> > +        cc.find_library('dl', required: get_option('qpl'))],
> > +        link_args: ['-lstdc++'])
> > +endif
> >  virgl =3D not_found
> >
> >  have_vhost_user_gpu =3D have_tools and host_os =3D=3D 'linux' and
> pixman.found()
> > @@ -2298,6 +2314,7 @@ config_host_data.set('CONFIG_MALLOC_TRIM',
> has_malloc_trim)
> >  config_host_data.set('CONFIG_STATX', has_statx)
> >  config_host_data.set('CONFIG_STATX_MNT_ID', has_statx_mnt_id)
> >  config_host_data.set('CONFIG_ZSTD', zstd.found())
> > +config_host_data.set('CONFIG_QPL', qpl.found())
> >  config_host_data.set('CONFIG_FUSE', fuse.found())
> >  config_host_data.set('CONFIG_FUSE_LSEEK', fuse_lseek.found())
> >  config_host_data.set('CONFIG_SPICE_PROTOCOL', spice_protocol.found())
> > @@ -4438,6 +4455,7 @@ summary_info +=3D {'snappy support':    snappy}
> >  summary_info +=3D {'bzip2 support':     libbzip2}
> >  summary_info +=3D {'lzfse support':     liblzfse}
> >  summary_info +=3D {'zstd support':      zstd}
> > +summary_info +=3D {'Query Processing Library support': qpl}
> >  summary_info +=3D {'NUMA host support': numa}
> >  summary_info +=3D {'capstone':          capstone}
> >  summary_info +=3D {'libpmem support':   libpmem}
> > diff --git a/meson_options.txt b/meson_options.txt
> > index 0a99a059ec..06cd675572 100644
> > --- a/meson_options.txt
> > +++ b/meson_options.txt
> > @@ -259,6 +259,8 @@ option('xkbcommon', type : 'feature', value :
> 'auto',
> >         description: 'xkbcommon support')
> >  option('zstd', type : 'feature', value : 'auto',
> >         description: 'zstd compression support')
> > +option('qpl', type : 'feature', value : 'auto',
> > +       description: 'Query Processing Library support')
> >  option('fuse', type: 'feature', value: 'auto',
> >         description: 'FUSE block device export')
> >  option('fuse_lseek', type : 'feature', value : 'auto',
> > diff --git a/scripts/meson-buildoptions.sh b/scripts/meson-
> buildoptions.sh
> > index 680fa3f581..784f74fde9 100644
> > --- a/scripts/meson-buildoptions.sh
> > +++ b/scripts/meson-buildoptions.sh
> > @@ -222,6 +222,7 @@ meson_options_help() {
> >    printf "%s\n" '                  Xen PCI passthrough support'
> >    printf "%s\n" '  xkbcommon       xkbcommon support'
> >    printf "%s\n" '  zstd            zstd compression support'
> > +  printf "%s\n" '  qpl             Query Processing Library support'
> >  }
> >  _meson_option_parse() {
> >    case $1 in
> > @@ -562,6 +563,8 @@ _meson_option_parse() {
> >      --disable-xkbcommon) printf "%s" -Dxkbcommon=3Ddisabled ;;
> >      --enable-zstd) printf "%s" -Dzstd=3Denabled ;;
> >      --disable-zstd) printf "%s" -Dzstd=3Ddisabled ;;
> > +    --enable-qpl) printf "%s" -Dqpl=3Denabled ;;
> > +    --disable-qpl) printf "%s" -Dqpl=3Ddisabled ;;
> >      *) return 1 ;;
> >    esac
> >  }

