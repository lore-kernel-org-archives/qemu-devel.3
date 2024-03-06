Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8380EC54E49
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Mar 2024 02:30:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhh2z-0001wM-O0; Tue, 05 Mar 2024 21:30:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yuan1.liu@intel.com>)
 id 1rhh2t-0001vu-Sp
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 21:30:15 -0500
Received: from mgamail.intel.com ([198.175.65.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yuan1.liu@intel.com>)
 id 1rhh2n-00049k-Hs
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 21:30:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1709692209; x=1741228209;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=DXtEs7SR+1VaWSci6DrMn5054e2IrBkwur4+jP2UEaM=;
 b=ZmhDvGR7nDRLRukcx2/UrYfH0LUu7V4KhZJl3UwdyYxPD+dN8Fqxb2gD
 irtSAt33kpJRM6+E5jQzOa0SPHiamQKcPlM1Ks/NE4zssIJrkKiRJjwYL
 N7c+ilvvNPG8BnAXirPWAZAF/vNPgza7bKnC/ppAWuMyvTq5e20zYP7hP
 O00kWtMJII+IQN59+cg88jm0q4XWBpuFvrgw0vIo1yo0zuRIkl3QABnWb
 8/31RIMeFiTIVLTQyREhDz8LVEeDxOctrXKQutrWXcYPM6vrS0kh3BMBn
 HweUnWzl25YD+0McmO07YnoaBsiNt8QRnWzS0fTeGaRWNhJtA/qm25MLU Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11004"; a="15429935"
X-IronPort-AV: E=Sophos;i="6.06,207,1705392000"; d="scan'208";a="15429935"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Mar 2024 18:30:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,207,1705392000"; 
   d="scan'208";a="9669239"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
 by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 05 Mar 2024 18:30:07 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 5 Mar 2024 18:30:06 -0800
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 5 Mar 2024 18:30:05 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 5 Mar 2024 18:30:05 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 5 Mar 2024 18:30:05 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bM9VPPAIXqRBfGiTjjZGZUtuBPlMrrx32i6FDi7wE7yINdzEb5XTlKe8VvPYyOsta3wP0aKIeOC18jHdSDJqtSA+7tOFS53BljJYyy9Kx96ls/yAKNTiQQ7jcK5sRvDPdTaswuM9mpd1LHMAb306Qfr1vRU4wwWz09Bdec0LoFtrCvlvFvGoNFBg2fshKIMPLCW809O6Duefj4VPfXP185PvSIJI9rl2YIE3fuzkydy6QIKh4qogdWU0II/5c/RI65Rk/gj50MELFx/LduTlelOKzeAls+dqO29/hd6rd44S8aTA2gj+r46bX6e493SkKVCS0+f1zOVe/nJVY/ngaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hQscT9md+SK4B+LFJ2+ozsyDkUtcRHQ3AVRuErOdi38=;
 b=m5/l8ijJXbDrIEod+pWhUYdqdbqRSVlG9IaJJboRWbWl2JLgj2ncNZyknk7cuSHtR4yli5jyIjL4qaIjrHCQtGRukWtcFqRZhqZpBfF1sHI/+0AgPQNd1OFwQTK5rfkgjG9eJMq2TcPMmGjzp+dP+Pa7W1EafEO061jlifnvQsyOUvOVYhmQ/0XkqKKrKVzG+HjtpKIee2BepnQj9pbVkwuEcIBQeaswA0+bq4EzA4U8IW5PaiSkqrWtjqx0BhpP30EdKHKvk+A2y5eHaCn6IW7I+s+6R44wHDO4voCSJZ0RqdB4UZ0b4WlDqXP5HeLwtOfdsAD+fhTg1b4ncBGp3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB5941.namprd11.prod.outlook.com (2603:10b6:510:13d::20)
 by DM6PR11MB4641.namprd11.prod.outlook.com (2603:10b6:5:2a9::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.24; Wed, 6 Mar
 2024 02:29:58 +0000
Received: from PH7PR11MB5941.namprd11.prod.outlook.com
 ([fe80::f0ec:877c:fd93:a04c]) by PH7PR11MB5941.namprd11.prod.outlook.com
 ([fe80::f0ec:877c:fd93:a04c%3]) with mapi id 15.20.7362.019; Wed, 6 Mar 2024
 02:29:58 +0000
From: "Liu, Yuan1" <yuan1.liu@intel.com>
To: Fabiano Rosas <farosas@suse.de>, "peterx@redhat.com" <peterx@redhat.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "hao.xiang@bytedance.com"
 <hao.xiang@bytedance.com>, "bryan.zhang@bytedance.com"
 <bryan.zhang@bytedance.com>, "Zou, Nanhai" <nanhai.zou@intel.com>
Subject: RE: [PATCH v4 4/8] migration/multifd: add qpl compression method
Thread-Topic: [PATCH v4 4/8] migration/multifd: add qpl compression method
Thread-Index: AQHabsDAdjT45HdR/0u2+lGVPFPhfbEpojUAgABbZUA=
Date: Wed, 6 Mar 2024 02:29:57 +0000
Message-ID: <PH7PR11MB59410E606FFBD8DFC048BDC4A3212@PH7PR11MB5941.namprd11.prod.outlook.com>
References: <20240304140028.1590649-1-yuan1.liu@intel.com>
 <20240304140028.1590649-5-yuan1.liu@intel.com> <87wmqggzv5.fsf@suse.de>
In-Reply-To: <87wmqggzv5.fsf@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB5941:EE_|DM6PR11MB4641:EE_
x-ms-office365-filtering-correlation-id: 25c5b245-fcdb-44b8-8497-08dc3d855122
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: moCwkMZ9W1hMuCBKPKqAiKuy20cC0SRe2DUm6oeMk+Rc+Om7BDDJXuhW+hLAIU0H8cr2cqUNU6QSk5IjY8UhXiQWYpuA7CEDxfP5Ks+T8xpG3ynlt6EBvmojPuScoAcs8FBRZS5kDMzAiW6i2atvtAxC8/OnvL8Uu4kuNC+x5fQjAQm2lJtOZNOmAT6aBBipN8QRNIFw9jpaoGdA5VtJlJvO/D13Z5bHSdHtxjHvWYchXNFhphlUxBR8Z40QMoCmz7kTLjPBrIhBmqd2TmkmRd43DqhZHEkvIJuP6PLFST7qXYyq3rzn7St+W7haOMwYBqkXyyXRlRhyg9yoIiimLvOkZy0G5QKqSVq7zjQW8dIzBk+1sPIF0X7x/uAoYCO8Tn4TiO8qe9q9G3V1QF9NdztRYpR3EnHhs3Zm7sNK2d4yg9QJhDO84xpGdKulLc+jpWLMJRvv3eLwbfvB9HpqlI5BxT2Q6GGV251c9tRSVJofOWxZxvpt6nZsJvgyeuA6sGOSH5KcAQB0Sc5+PllSZGpO9+XovzgcVvRRcDcB2UJ7/1NBqNDBMTwTqTDaknugHgtL+Q1YyJmnQK3+Xi0pRQzgALNGwnR+s3dEACwIjyV191EgGPToLDagXpdkqq0JKLfNhows26HQS8P/vI729Kb3jL5OMRaX9jXDN13Mobk1zF5+FoyPjw8fJ5cTsyfibcAi8iYBxaqiU8m8NVfhE9G6wto/2ws/XjNlO7RDHCY=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR11MB5941.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?mF+agaMEYqDGjnSPNFs1HSDUCwMLVw6RB6gVd1z7ktHX3QUrUoBLE0+1wIwb?=
 =?us-ascii?Q?ibnx88nda/gltorwK7pAofPaS6HUN3cdLKRlgwalgL+8/8+nEi3GjDy+VqOQ?=
 =?us-ascii?Q?UK1pUKG4zkhvj5+5otkFYljkmTv2CAlxO0BEBU1/T9P03E2et1n9vQwqlK/z?=
 =?us-ascii?Q?sr+hKFkwxqeGbhmfI7rFd05+HpLu+nJ+68G8dzIfqwQ+JKmRsEhc1Qa7eD7g?=
 =?us-ascii?Q?on7UoS+F2pBztT5Jyq1VNfWxtAHXiHKZC2RAmWv2AIZtPAvV2kIMFCmb2/MD?=
 =?us-ascii?Q?CO/TnJFEuftgO8rBm11gVfgnrZvGa2dBrXI4BtqYL9+NMjnD8Xuwz3F7dFGn?=
 =?us-ascii?Q?5jUfAec6r3W2Ez6a8Yaogzt4SSp/l9K7FjixspDcNGVoDY/O5sFy8YQkdKTW?=
 =?us-ascii?Q?FCDDQT1/d5pn00W7t/gTstfrg2IsHatK36xrKRZgfnBcVaOzIqw5NVP+DT04?=
 =?us-ascii?Q?IpnYTNcCbJBkKByh7YVzS2JjpK7/lsjdz+BB1F4SA+hDnnOhTu93gRZzhG6Y?=
 =?us-ascii?Q?C4oZva4eZ3yMDuEm19JrwIFXRPKlKJnfXX4L4No+d0fk2a1RAXtp2CsRDOx3?=
 =?us-ascii?Q?9wT+oT99+9Y1AfDFcvtEoLD/sJG8SRS3YKmNJbjdPyHYBxMIAtQEUdxWL73C?=
 =?us-ascii?Q?EbEaWeaRkLxrYq6p/25SfIAKPTN4WZucVrGFIaSt6pdoMjjNREcLow3QdpP6?=
 =?us-ascii?Q?fCVRU4mMX+jIY6+/IJceABy/PUTfw/f6siNeyBb23FcRPXk1jmfz9UoxmT3Y?=
 =?us-ascii?Q?7w7Enuc2TtAoOYO7dnL4blAGICIPNmyO0u+BVqxmeaKs2pPW3UyILQP1qZsg?=
 =?us-ascii?Q?kAayrJAO05Z7Vsxv7Vs9dAQojWngiBbUxaCli8vbSf2EMpJ3gMkffhT3Q+gp?=
 =?us-ascii?Q?8D+vstCer0Bn/BJM/KVwaekZEHCEDTNO5XCQgfpcciQbB/58imkaRc755tr1?=
 =?us-ascii?Q?EalVUY+L8CMszn9FM3Q0i4mK5YKdWlATB+QrYizzpCmDzDS/aRdzGXdKYc/g?=
 =?us-ascii?Q?k8IMXLjP2k1nMyzQjyYzHoL6XSUiC3Fgp6XebP4H53nu0p4Qu8cTK4toltKv?=
 =?us-ascii?Q?DOOhqb7pTlgEDO/qEnbRwiyQXc/4u0kCjgu270llN3FJgPXC3btnB6cdKdkd?=
 =?us-ascii?Q?3Z+dAV09X3TeH76Ap8KTZ8lC7AiG+eJcEPa0pDAAYr6ZLlV9zMT6EInem+yW?=
 =?us-ascii?Q?b6ZhwbEpLx9pSjUTSXV6vht2OvBMAmjzU8hTMFVRCzjx2sPgDF+UTYyJ7TW5?=
 =?us-ascii?Q?5dJMSjJ7uzn0nPKCmHyQkhQIVA7Z/nx4y4pvU3yppfIu1HPdbbxLL8joM6hh?=
 =?us-ascii?Q?UVHdrBqkFU71b4CHsCKamRpCWL/HJv5dRmTYluCL/xQ+zIkpLxe6cloa+GE1?=
 =?us-ascii?Q?vOMmgVr0J2y/NOjp6pwK4PHifMnWRCyntVxoF3QHUU8CFg3X0m6IVu4iDSA8?=
 =?us-ascii?Q?wxHnEzfz+QMyUj5f2DeES4ztI2Mt4Fe9OcFnJBnJ1wR9cmvDWNtrlA9JrkoH?=
 =?us-ascii?Q?MyIpxQq8R8y+CkiIUfz2x9Y4bbzslhtE9zXuuVrZ1c6TM/wYky9ECO3+RJXx?=
 =?us-ascii?Q?PZYjS01jBA+oZmuLL2y0KzwU4cmExV3xIhTbYwyf?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5941.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25c5b245-fcdb-44b8-8497-08dc3d855122
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Mar 2024 02:29:57.9080 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aClFDmsy0dhyF+2TAyGeXezdgMiEpSgaF+xpHBovcSyO4JLlFEji9TS7ivquArT3O3gEwe2K1PrnCkplRiMI8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4641
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.13; envelope-from=yuan1.liu@intel.com;
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
> Sent: Wednesday, March 6, 2024 4:58 AM
> To: Liu, Yuan1 <yuan1.liu@intel.com>; peterx@redhat.com
> Cc: qemu-devel@nongnu.org; hao.xiang@bytedance.com;
> bryan.zhang@bytedance.com; Liu, Yuan1 <yuan1.liu@intel.com>; Zou, Nanhai
> <nanhai.zou@intel.com>
> Subject: Re: [PATCH v4 4/8] migration/multifd: add qpl compression method
>=20
> Yuan Liu <yuan1.liu@intel.com> writes:
>=20
> > add the Query Processing Library (QPL) compression method
> >
> > Although both qpl and zlib support deflate compression, qpl will
> > only use the In-Memory Analytics Accelerator(IAA) for compression
> > and decompression, and IAA is not compatible with the Zlib in
> > migration, so qpl is used as a new compression method for migration.
> >
> > How to enable qpl compression during migration:
> > migrate_set_parameter multifd-compression qpl
> >
> > The qpl only supports one compression level, there is no qpl
> > compression level parameter added, users do not need to specify
> > the qpl compression level.
> >
> > Signed-off-by: Yuan Liu <yuan1.liu@intel.com>
> > Reviewed-by: Nanhai Zou <nanhai.zou@intel.com>
> > ---
> >  hw/core/qdev-properties-system.c |   2 +-
> >  migration/meson.build            |   1 +
> >  migration/multifd-qpl.c          | 158 +++++++++++++++++++++++++++++++
> >  migration/multifd.h              |   1 +
> >  qapi/migration.json              |   7 +-
> >  5 files changed, 167 insertions(+), 2 deletions(-)
> >  create mode 100644 migration/multifd-qpl.c
> >
> > diff --git a/hw/core/qdev-properties-system.c b/hw/core/qdev-properties=
-
> system.c
> > index 1a396521d5..b4f0e5cbdb 100644
> > --- a/hw/core/qdev-properties-system.c
> > +++ b/hw/core/qdev-properties-system.c
> > @@ -658,7 +658,7 @@ const PropertyInfo qdev_prop_fdc_drive_type =3D {
> >  const PropertyInfo qdev_prop_multifd_compression =3D {
> >      .name =3D "MultiFDCompression",
> >      .description =3D "multifd_compression values, "
> > -                   "none/zlib/zstd",
> > +                   "none/zlib/zstd/qpl",
> >      .enum_table =3D &MultiFDCompression_lookup,
> >      .get =3D qdev_propinfo_get_enum,
> >      .set =3D qdev_propinfo_set_enum,
> > diff --git a/migration/meson.build b/migration/meson.build
> > index 92b1cc4297..c155c2d781 100644
> > --- a/migration/meson.build
> > +++ b/migration/meson.build
> > @@ -40,6 +40,7 @@ if get_option('live_block_migration').allowed()
> >    system_ss.add(files('block.c'))
> >  endif
> >  system_ss.add(when: zstd, if_true: files('multifd-zstd.c'))
> > +system_ss.add(when: qpl, if_true: files('multifd-qpl.c'))
> >
> >  specific_ss.add(when: 'CONFIG_SYSTEM_ONLY',
> >                  if_true: files('ram.c',
> > diff --git a/migration/multifd-qpl.c b/migration/multifd-qpl.c
> > new file mode 100644
> > index 0000000000..6b94e732ac
> > --- /dev/null
> > +++ b/migration/multifd-qpl.c
> > @@ -0,0 +1,158 @@
> > +/*
> > + * Multifd qpl compression accelerator implementation
> > + *
> > + * Copyright (c) 2023 Intel Corporation
> > + *
> > + * Authors:
> > + *  Yuan Liu<yuan1.liu@intel.com>
> > + *
> > + * This work is licensed under the terms of the GNU GPL, version 2 or
> later.
> > + * See the COPYING file in the top-level directory.
> > + */
> > +
> > +#include "qemu/osdep.h"
> > +#include "qemu/rcu.h"
> > +#include "exec/ramblock.h"
> > +#include "exec/target_page.h"
> > +#include "qapi/error.h"
> > +#include "migration.h"
> > +#include "trace.h"
> > +#include "options.h"
> > +#include "multifd.h"
> > +#include "qpl/qpl.h"
>=20
> I don't mind adding a skeleton upfront before adding the implementation,
> but adding the headers here hurts the review process. Reviewers will
> have to go digging through the next patches to be able to validate each
> of these. It's better to include them along with their usage.
>=20
> What I would do in this patch is maybe just add the new option, the
> .json and meson changes and this file with just:
>=20
> static void multifd_qpl_register(void)
> {
>     /* noop */
> }
>=20
> Then in the next commit you can implement all the methods in one
> go. That way, the docstrings come along with the implementation, which
> also facilitates review.

Thanks for the guidance, I will implement it in the next version.

> > +
> > +struct qpl_data {
>=20
> typedef struct {} QplData/QPLData, following QEMU's coding style.

I will fix it in next version

> > +    qpl_job **job_array;
> > +    /* the number of allocated jobs */
> > +    uint32_t job_num;
> > +    /* the size of data processed by a qpl job */
> > +    uint32_t data_size;
> > +    /* compressed data buffer */
> > +    uint8_t *zbuf;
> > +    /* the length of compressed data */
> > +    uint32_t *zbuf_hdr;
> > +};
> > +
> > +/**
> > + * qpl_send_setup: setup send side
> > + *
> > + * Setup each channel with QPL compression.
> > + *
> > + * Returns 0 for success or -1 for error
> > + *
> > + * @p: Params for the channel that we are using
> > + * @errp: pointer to an error
> > + */
> > +static int qpl_send_setup(MultiFDSendParams *p, Error **errp)
> > +{
> > +    /* Implement in next patch */
> > +    return -1;
> > +}
> > +
> > +/**
> > + * qpl_send_cleanup: cleanup send side
> > + *
> > + * Close the channel and return memory.
> > + *
> > + * @p: Params for the channel that we are using
> > + * @errp: pointer to an error
> > + */
> > +static void qpl_send_cleanup(MultiFDSendParams *p, Error **errp)
> > +{
> > +    /* Implement in next patch */
> > +}
> > +
> > +/**
> > + * qpl_send_prepare: prepare data to be able to send
> > + *
> > + * Create a compressed buffer with all the pages that we are going to
> > + * send.
> > + *
> > + * Returns 0 for success or -1 for error
> > + *
> > + * @p: Params for the channel that we are using
> > + * @errp: pointer to an error
> > + */
> > +static int qpl_send_prepare(MultiFDSendParams *p, Error **errp)
> > +{
> > +    /* Implement in next patch */
> > +    return -1;
> > +}
> > +
> > +/**
> > + * qpl_recv_setup: setup receive side
> > + *
> > + * Create the compressed channel and buffer.
> > + *
> > + * Returns 0 for success or -1 for error
> > + *
> > + * @p: Params for the channel that we are using
> > + * @errp: pointer to an error
> > + */
> > +static int qpl_recv_setup(MultiFDRecvParams *p, Error **errp)
> > +{
> > +    /* Implement in next patch */
> > +    return -1;
> > +}
> > +
> > +/**
> > + * qpl_recv_cleanup: setup receive side
> > + *
> > + * Close the channel and return memory.
> > + *
> > + * @p: Params for the channel that we are using
> > + */
> > +static void qpl_recv_cleanup(MultiFDRecvParams *p)
> > +{
> > +    /* Implement in next patch */
> > +}
> > +
> > +/**
> > + * qpl_recv_pages: read the data from the channel into actual pages
> > + *
> > + * Read the compressed buffer, and uncompress it into the actual
> > + * pages.
> > + *
> > + * Returns 0 for success or -1 for error
> > + *
> > + * @p: Params for the channel that we are using
> > + * @errp: pointer to an error
> > + */
> > +static int qpl_recv_pages(MultiFDRecvParams *p, Error **errp)
> > +{
> > +    /* Implement in next patch */
> > +    return -1;
> > +}
> > +
> > +/**
> > + * qpl_get_iov_count: get the count of IOVs
> > + *
> > + * For QPL compression, in addition to requesting the same number of
> IOVs
> > + * as the page, it also requires an additional IOV to store all
> compressed
> > + * data lengths.
> > + *
> > + * Returns the count of the IOVs
> > + *
> > + * @page_count: Indicate the maximum count of pages processed by
> multifd
> > + */
> > +static uint32_t qpl_get_iov_count(uint32_t page_count)
> > +{
> > +    return page_count + 1;
> > +}
> > +
> > +static MultiFDMethods multifd_qpl_ops =3D {
> > +    .send_setup =3D qpl_send_setup,
> > +    .send_cleanup =3D qpl_send_cleanup,
> > +    .send_prepare =3D qpl_send_prepare,
> > +    .recv_setup =3D qpl_recv_setup,
> > +    .recv_cleanup =3D qpl_recv_cleanup,
> > +    .recv_pages =3D qpl_recv_pages,
> > +    .get_iov_count =3D qpl_get_iov_count
> > +};
> > +
> > +static void multifd_qpl_register(void)
> > +{
> > +    multifd_register_ops(MULTIFD_COMPRESSION_QPL, &multifd_qpl_ops);
> > +}
> > +
> > +migration_init(multifd_qpl_register);
> > diff --git a/migration/multifd.h b/migration/multifd.h
> > index d82495c508..0e9361df2a 100644
> > --- a/migration/multifd.h
> > +++ b/migration/multifd.h
> > @@ -33,6 +33,7 @@ bool multifd_queue_page(RAMBlock *block, ram_addr_t
> offset);
> >  #define MULTIFD_FLAG_NOCOMP (0 << 1)
> >  #define MULTIFD_FLAG_ZLIB (1 << 1)
> >  #define MULTIFD_FLAG_ZSTD (2 << 1)
> > +#define MULTIFD_FLAG_QPL (4 << 1)
> >
> >  /* This value needs to be a multiple of qemu_target_page_size() */
> >  #define MULTIFD_PACKET_SIZE (512 * 1024)
> > diff --git a/qapi/migration.json b/qapi/migration.json
> > index 5a565d9b8d..e48e3d7065 100644
> > --- a/qapi/migration.json
> > +++ b/qapi/migration.json
> > @@ -625,11 +625,16 @@
> >  #
> >  # @zstd: use zstd compression method.
> >  #
> > +# @qpl: use qpl compression method. Query Processing Library(qpl) is
> based on
> > +#       the deflate compression algorithm and use the Intel In-Memory
> Analytics
> > +#       Accelerator(IAA) hardware accelerated compression and
> decompression.
>=20
> Missing: (since 9.0)

Sure, I will add it in next version

> > +#
> >  # Since: 5.0
> >  ##
> >  { 'enum': 'MultiFDCompression',
> >    'data': [ 'none', 'zlib',
> > -            { 'name': 'zstd', 'if': 'CONFIG_ZSTD' } ] }
> > +            { 'name': 'zstd', 'if': 'CONFIG_ZSTD' },
> > +            { 'name': 'qpl', 'if': 'CONFIG_QPL' } ] }
> >
> >  ##
> >  # @MigMode:

