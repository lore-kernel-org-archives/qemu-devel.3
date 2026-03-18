Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CE59FCD0B5
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2026 05:50:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2jn6-0004mH-Vc; Wed, 18 Mar 2026 01:50:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1w2jn3-0004m0-VQ
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 01:49:58 -0400
Received: from mgamail.intel.com ([198.175.65.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1w2jn1-0002Et-94
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 01:49:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1773812995; x=1805348995;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=kytOjJu45vRGwSxzHFZjAGlfRH3oKk4kf3Iw+/G2Ung=;
 b=kxZMGvUWh9mEUee/JVP1Fz35IjnmGCAEVu9S+oS3vpWw+srxUtHGxuoL
 HvoIR6VYkzpnsnUoRVA61thZU798pK2HpcqMknLJ1vfXe99kmutgUKORX
 rMrdi5k6QqVc2JQG1lw02fXlJi3P4mX7T4tACOOhJTfQHGAsULefzl7km
 jsHUJk++6/aFBBucsY1XiA9iU+9rN1/3H+kiTPxdvU+jxHyldppSwXe+P
 0V4zr+UaCpQvfexKuuBOaDR9DkBQSGoGxP3yrOYnrcIMoR6dgAJYCHRUP
 U01+iX/PvO/Wk1duTjhNTQq18LhQBkIBvode2KXl/Yy2OWLVYAM3bE/W8 Q==;
X-CSE-ConnectionGUID: 9ovU/x0vSauevvduKe33Aw==
X-CSE-MsgGUID: 6DuD0ZJFQTO9AXWdEq6HQA==
X-IronPort-AV: E=McAfee;i="6800,10657,11732"; a="85175428"
X-IronPort-AV: E=Sophos;i="6.23,126,1770624000"; d="scan'208";a="85175428"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Mar 2026 22:49:53 -0700
X-CSE-ConnectionGUID: VxXvExoASuyO9pnE38SF+g==
X-CSE-MsgGUID: jmO8Bd6IRhC08CWOYYCk0Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,126,1770624000"; d="scan'208";a="227185085"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Mar 2026 22:49:53 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 17 Mar 2026 22:49:52 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 17 Mar 2026 22:49:52 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.54) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 17 Mar 2026 22:49:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=drM4rYQMaJbelw8v5QWEE5kI3OT8BlVZU+oRuTejd7jCWFF4/5vY+H/qxODHq7MziznhBJ+3WR07HbGE0oYJefWkrmAe0EuBLHTTZGNJz3q2tD0scO0fgn1iwjyOlQbjLU+gmsW6w2DdCB/MhG7lyqrSjSUYVGFTePMwVB5dFesAVQ53YE3Kc8Jl8CCjIHVpMbmUheJwbEJ4G4QqN+EsRX4FHGRVKPB1GDHlWrigC3GGYfMaQPXgyukDN+UWnCLQkp7CdaUDVL13fgDmPWiv+msExPdtri2VLeuVc/nF6glwVu5e+/5j1eFALi6uf1Lw88KjLGE4mRt/Lh64l/sPDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vrzIXLidvhIGdB0ZgimIFhGSkhJtNgk7Srsdz7Lygis=;
 b=WTJC6x7hf+VY22I2CdWrC1mv2k/Jf/wV9Amf0OidepQRXUOoV/KglW5yx6AoP7Pcamz3blmIiC96LdexQCarJ8gEWtOi1MdkEeNgQ2h8ACGZiQ1x0yadyy2mpwDRU5RvkUXSqk58mnzW7NN8KXqsng9nOYvtujWQ95l8b6NCVf1UD/86o11SkZzz3wZNQMkGQJex5/fyx6LPYOYg77TzEM0fVsDC+fa5IJOerG8un1AN5oWCC1mjaF8EzSa6oK8/bMLX7ZSDiG2MQkZtbrT8N5wVxrEUx7ICzdPBT7J8kHf/19pYimVDdc/YQySVU726kLQZqgSu/JjmYp+t2IXsNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CH3PR11MB7177.namprd11.prod.outlook.com (2603:10b6:610:153::8)
 by CO1PR11MB5012.namprd11.prod.outlook.com (2603:10b6:303:90::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Wed, 18 Mar
 2026 05:49:50 +0000
Received: from CH3PR11MB7177.namprd11.prod.outlook.com
 ([fe80::b997:e226:4979:c035]) by CH3PR11MB7177.namprd11.prod.outlook.com
 ([fe80::b997:e226:4979:c035%5]) with mapi id 15.20.9723.018; Wed, 18 Mar 2026
 05:49:50 +0000
From: "Kasireddy, Vivek" <vivek.kasireddy@intel.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Akihiko Odaki
 <odaki@rsg.ci.i.u-tokyo.ac.jp>
CC: Alex Williamson <alex@shazbot.org>
Subject: RE: [PATCH v11 07/10] vfio/device: Add support for creating dmabuf
 from multiple ranges
Thread-Topic: [PATCH v11 07/10] vfio/device: Add support for creating dmabuf
 from multiple ranges
Thread-Index: AQHcsQKuikOpoSIkLUmoXhv75zh8zLWy25OAgABSA5A=
Date: Wed, 18 Mar 2026 05:49:50 +0000
Message-ID: <CH3PR11MB7177C6A65EE7D28D84F4F826F84EA@CH3PR11MB7177.namprd11.prod.outlook.com>
References: <20260311025340.1335673-1-vivek.kasireddy@intel.com>
 <20260311025340.1335673-8-vivek.kasireddy@intel.com>
 <d313433e-e601-4ebc-baee-ae5baef45b29@redhat.com>
In-Reply-To: <d313433e-e601-4ebc-baee-ae5baef45b29@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR11MB7177:EE_|CO1PR11MB5012:EE_
x-ms-office365-filtering-correlation-id: b3a294d4-46e6-4ec9-510d-08de84b22ba4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|22082099003|18002099003|56012099003|38070700021;
x-microsoft-antispam-message-info: HzY7iu/hvxBy2auklSaGfsYsnipvvP7Nxw5+qyFLfB+Zsnckzzu8LumxDtAejYo0s6IRuGFxk8QGGADa5S2A+X9bW6gF5c00R3epNjO2hf9GN8RCRnFKs0nnn8zhlPLk6z7xDtvARuX7iEL+j3aUX1OoSKmoF568eoR0hr1q6/m+zfOOWGnbJwR5GYwXnSaJlpDKzqiu9d4HwSDhdd5iPHqCIK8V9SpZ3ozGnLN8fxgdCSsfyxxyY3sT7MipDxynIpE7PGKFjK9Xf32gD2CmCLAa4gx8FRvqhmdz1EcQY3DoUUmocwonwbJROal81kNom1yXEp/fKegmQDneohPvTvsFLN0yN7vU03YjqHqo+oE7WmtQxSV6StpWUNSR3GjHyZuca7W8zGa+RNW8MJvXKdJVKJSG3kSxKvb4f4vj4j+KZ14grtw8yuG/Sym5GYFKr+x5PwYR/G04Aw2Ezu3b6QjP05edZQR2so3v/zaiQXJuIo5lF+H49znlbn8pWdnwCN5pnc+5jme4TyyquBW0tGWVRNl/hsbL/ajNT6XNU2NvENcN12ygt20ixmaNiuSBCBxcZxYcp6CoSwguITsNBGelB/U5WqI+MrcZr9OnUFqfrSPFKArBywnNkQYEiOm7BdQWZXoUhSN8V1W8emAYZrnoX9EIorq32EzQSAQB0xqXlK50o96G3D8yOkhqE9LJBubKy7/joXwVteb5ot9XW9lXSA1drCet8EKWDL/v6GPS+CYaibw607us6ggCBwllOjoSRmddOuKfRRjP1ZLAIHznUBGMbHEU5mqf/9UUIg4=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR11MB7177.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(22082099003)(18002099003)(56012099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?fotfHt0vmgRL/74ay3r4j6EcqRS3+ERsvZz8h0kDiHfgzqO6GYjcNSMJDH?=
 =?iso-8859-1?Q?vtiroiilO5446GOas74EBADOwAOdVUDTiYEckRB4kB7fYmezn9MtP6bgBA?=
 =?iso-8859-1?Q?7fikF/o/MmNq/0/58Ivtn8VkEV4nj99AIWquYeXXf0T9m6HnDNFsQ7r4gW?=
 =?iso-8859-1?Q?UTbpDqnuEu7PW1w1J/w6F6xb27xCBhp1P7H1LXvXbM3CS6mp78r0jPcY+Q?=
 =?iso-8859-1?Q?BiHDdAoSlC5TWrALI2ImXDrivpYtXa1wEiOvvx4SwqsBlXldETXu+o8REG?=
 =?iso-8859-1?Q?Tic30A+WIeLiAX6GLMshHXs5RMTt7nFa1Jph3E1UTRCvfnJ0rCbvdejuIC?=
 =?iso-8859-1?Q?vHkA18R4kcnMgxE3XqRIoAEvvnpZFhXEQZ6YO5UcP6NXO/4/PkxmAQ/6Jc?=
 =?iso-8859-1?Q?/mXr9H/5YqWPO6H88gAPdcXbockLND+IP7yqnzE5VavmP3MvRjGtYsMAnN?=
 =?iso-8859-1?Q?f7zrTGyTrzTD8JuHG6xPhGW5O+kJ2d9xzVu5Nume+9cEM2QZai3x98C99s?=
 =?iso-8859-1?Q?Mr9VD7ZV3xsIzWi5YLa2Gqdi7O3kqLIWAJDQ2NTyRbX9Lh3Y7dTONODamR?=
 =?iso-8859-1?Q?X7gqcgavQT31HEQRrIX4HPrqgNdrVFUTt9Bh6/6y6L5H+H7dMEflaxJC+n?=
 =?iso-8859-1?Q?cwSSdVdlWfu2rXvD0JPMSMmqTLa+AlQHMolRCDJWs7NiGuIB7iFjOwGfuy?=
 =?iso-8859-1?Q?m1AdEp6zxrDUIraSgH50SAM2nCS2QOJEsJuX2FEsJYSpjiqOsMdZVeqwXc?=
 =?iso-8859-1?Q?fQTOOmKpQf8gVP37QR4eGSffY1FRCreZIpgLXSfYVZoWJNixsDAfvdvLDj?=
 =?iso-8859-1?Q?IMVUNu1HEMhFrsjYr5KN5mhXpSWsXw9HNLXxXxjfn1c12QgCrxeuUwQp1s?=
 =?iso-8859-1?Q?QIJJZN2j8g1VlCcuKdHGWj7lvoVmnkgQQaKWSO3yKqKAHdxHesC5NWHqdY?=
 =?iso-8859-1?Q?Nf648j4N2kwG/S0oMkDXyEwegY2ugTfDJWzl22Z+WiFPkFgUQ8OtTrA18m?=
 =?iso-8859-1?Q?ZUFGCqOmoVBpKzgOJg496hdwByKGyX+plnK8CLvn9FuB2hIl8/toImP+j/?=
 =?iso-8859-1?Q?It6AtNsWNnLyUhX9vLgn7xb3gcPJMiYtSOhMha6MMMcy5Q9Rc1JOo4eC0o?=
 =?iso-8859-1?Q?EvOF3/RFOSX5gQDw0IHYZZge0pp9NO/PAe2KyinFNvNr90rkGGCs0wJOAt?=
 =?iso-8859-1?Q?tO3wOqiY+rDbgCXWzRLUy1XCQbcz3WAcDv8IdgO8MvJ/0/Xfe2JriQA/tM?=
 =?iso-8859-1?Q?bDAut454d2Ynqtzr6DEKAPr6BYv1cXNOhY6fWJbFmipSWdau1eRsxzF928?=
 =?iso-8859-1?Q?TcfINoI8IXjEK/biOCb1DVy6mAV1njy6lthGEMIf1wFBL3gnwwTcV3OTnG?=
 =?iso-8859-1?Q?Wxz2OUy8tPaUATykp7JiqZyht9rGpOCSNqqCQUZFeuTnDrsI844K2Saxsx?=
 =?iso-8859-1?Q?AzY1WaC8Y3TiMZsB2a7p4sJ9XW3c8ThlWekmo/dWq4VzqVoTwR8QLPj7DC?=
 =?iso-8859-1?Q?yGvGt9xRo8d83Xg/8x0aP23jb4Qzh/hpP+oAuH3sWGwPKAcPbg3ADHwwK+?=
 =?iso-8859-1?Q?uUvGFCASPINSjS/jD84sqjmj+s8MXu1xZ8zj7l7kBp0cCuKzDzzvE1pJ9U?=
 =?iso-8859-1?Q?SR6nYxwQdpbuZp2HK0RHI7tkRc7cks/W7TZjzyUwdPlkTkU8rn1FQ184SG?=
 =?iso-8859-1?Q?hNpmfBiVv7mF1XunNOEBj93jqWy43QZdVsGP46kszyqFnUvwCwUb/SOSlR?=
 =?iso-8859-1?Q?xnr0y6rkT26kRq7h+SM2JtO6/fCQx0/PjBqQ4XdXhEbZuTY7Dq3qGeIA8j?=
 =?iso-8859-1?Q?C4Ww1qkDGQ=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: mLTn7TPnbmQwz+6mYuF2ahZKrDkMneuZlcFe6n7CCF2xs04zLQ3KP3Pack/whKswOi20rYAeeK86Ob51e6NbvV/Za5JtG+HeyJe5E+ZIorS7ldh/H+9E63L9QVWtDBksq4xZWxtJMjknfwrzuDauX2vT6wmDX40iXtwQ9OpilpZ2fV4E8QKuySnuNErAEUG7HNQQTpQiFQfFWauF7kOjJ6eV5nv+Wqz6JOXchKW9eYby5B718OLuabc2mVR5oBX8+SokCWw2jdBdWHxT2gKnuRNjWDwWXpzBMb0qukDUFO8M84LI7g1uWVjJqcwoyGlIsqpGUupHgUq4KC+0DAHlgg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB7177.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3a294d4-46e6-4ec9-510d-08de84b22ba4
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2026 05:49:50.3900 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xnN7kVsRdlDJXy0imGym4ERoIZCbqUOyOgS2RwtNGiDpFZaBXKn1aVD9K6JCFxXvorYN1NuYiJzun+1bwi5HF4UHwGnZC3eaXe1+FoVgsJI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5012
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.11;
 envelope-from=vivek.kasireddy@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903, SPF_HELO_NONE=0.001,
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

> Subject: Re: [PATCH v11 07/10] vfio/device: Add support for creating
> dmabuf from multiple ranges
>=20
> HEllo,
>=20
> On 3/11/26 03:50, Vivek Kasireddy wrote:
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
> > VFIODevice associated with a memory region, introduce a helper to
> > just use the vfio_device_list to lookup the VFIODevice.
> >
> > Lastly, introduce an enum to return the type of error encountered
> > while creating the dmabuf fd.
> >
> > Cc: Alex Williamson <alex@shazbot.org>
> > Cc: C=E9dric Le Goater <clg@redhat.com>
> > Signed-off-by: Vivek Kasireddy <vivek.kasireddy@intel.com>
> > ---
> >   hw/vfio/device.c              | 81
> +++++++++++++++++++++++++++++++++++
> >   hw/vfio/dmabuf-stubs.c        | 17 ++++++++
> >   hw/vfio/meson.build           |  1 +
> >   include/hw/vfio/vfio-device.h | 22 ++++++++++
>=20
> Please add to your .git/config
>=20
> [diff]
> 	orderFile =3D /path/to/qemu/scripts/git.orderfile
Done. Thank you for the tip.

>=20
>=20
>=20
> >   4 files changed, 121 insertions(+)
> >   create mode 100644 hw/vfio/dmabuf-stubs.c
> >
> > diff --git a/hw/vfio/device.c b/hw/vfio/device.c
> > index 973fc35b59..2d01059be0 100644
> > --- a/hw/vfio/device.c
> > +++ b/hw/vfio/device.c
> > @@ -21,6 +21,7 @@
> >   #include "qemu/osdep.h"
> >   #include <sys/ioctl.h>
> >
> > +#include "system/ramblock.h"
> >   #include "hw/vfio/vfio-device.h"
> >   #include "hw/vfio/pci.h"
> >   #include "hw/core/iommu.h"
> > @@ -644,3 +645,83 @@ static VFIODeviceIOOps
> vfio_device_io_ops_ioctl =3D {
> >       .region_read =3D vfio_device_io_region_read,
> >       .region_write =3D vfio_device_io_region_write,
> >   };
> > +
>=20
> Please add a comment
>=20
>    /*
>     * For virtio-gpu, < explain the context >
>     */
Ok, will do.

>=20
>=20
> > +static bool vfio_device_lookup(struct iovec *iov, VFIODevice
> **vbasedevp,
> > +                               Error **errp)
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
> > +int vfio_device_create_dmabuf_fd(struct iovec *iov, unsigned int
> iov_cnt,
> > +                                 Error **errp)
> > +{
> > +    g_autofree struct vfio_device_feature *feature =3D NULL;
> > +    struct vfio_device_feature_dma_buf *dma_buf;
> > +    RAMBlock *rb, *first_rb;
> > +    VFIODevice *vbasedev;
> > +    ram_addr_t offset;
> > +    int i, index, ret;
> > +    size_t argsz;
>=20
> Shouldn't we check iov and iov_cnt values ?
You mean something like this:
if (iov_size(iov, iov_cnt) !=3D dmabuf_size)
and also calling vfio_device_lookup() here instead of below?

>=20
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
> > +    if (!vfio_device_lookup(iov, &vbasedev, errp)) {
> > +        return VFIO_DMABUF_CREATE_ERR_INVALID_IOV;
> > +    }
> > +
> > +    for (i =3D 0; i < iov_cnt; i++) {
> > +        rb =3D qemu_ram_block_from_host(iov[i].iov_base, false, &offse=
t);
> > +        if (i =3D=3D 0) {
> > +            first_rb =3D rb;
> > +        }
> > +        if (!rb || rb !=3D first_rb) {
> > +            error_setg(errp, "Cannot create dmabuf with different
> regions\n");
> > +            return VFIO_DMABUF_CREATE_ERR_INVALID_IOV;
> > +        }
> > +
> > +        index =3D vfio_get_region_index_from_mr(rb->mr);
>=20
> returning a VFIORegion seems cleaner.
>=20
> > +        if (index < 0) {
> > +            error_setg(errp, "Cannot find region index for dmabuf
> segment\n");
> > +            return VFIO_DMABUF_CREATE_ERR_INVALID_IOV;
> > +        }
>=20
>=20
> Could you please introduce a common helper for the code above that
> could be shared with vfio_device_mmap_dmabuf() ? The same
> sequence
> is duplicated.
Ok, I'll try to add a common helper.

>=20
>=20
> > +        dma_buf->region_index =3D index;
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
>=20
> See vfio_region_create_dma_buf() for possible errors. You might want
> to introduce a helper.
IIUC, for this use-case, I think we want to treat any error here as a failu=
re
instead of treating ENOTTY as success like in the case of
vfio_region_create_dma_buf().

>=20
>=20
> > +    }
> > +    return ret;
> > +}
> > diff --git a/hw/vfio/dmabuf-stubs.c b/hw/vfio/dmabuf-stubs.c
> > new file mode 100644
> > index 0000000000..e71e2b68dd
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
> > +                                 Error **errp)
> > +{
> > +    error_setg(errp, "VFIO dmabuf support is not enabled");
> > +    return VFIO_DMABUF_CREATE_HOST_ERROR;
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
> > diff --git a/include/hw/vfio/vfio-device.h b/include/hw/vfio/vfio-
> device.h
> > index 596c7f5a10..566e5d8bc0 100644
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
> This is overkill. Please return a bool value and ensure the errp
> argument is correctly filled.
Having these specific errors is really useful as it makes the dmabuf
handling in virtio-gpu very intuitive and sensible. Akihiko (virtio-gpu
reviewer) suggested this mechanism and can add more comments
or explain the rationale for this.

Thanks,
Vivek

>=20
> > +
> >   typedef struct VFIODeviceOps VFIODeviceOps;
> >   typedef struct VFIODeviceIOOps VFIODeviceIOOps;
> >   typedef struct VFIOMigration VFIOMigration;
> > @@ -318,6 +325,21 @@ int vfio_device_get_irq_info(VFIODevice
> *vbasedev, int index,
> >    * Returns the region index or -1 on error.
> >    */
> >   int vfio_get_region_index_from_mr(MemoryRegion *mr);
> > +
> > +/**
> > + * Create a dmabuf fd by first translating the addresses in the
> > + * iovec array into VFIO region offsets and then invoking the
> > + * VFIO_DEVICE_FEATURE_DMA_BUF feature.
> > + *
> > + * @iov: array of iovec entries associated with a buffer
> > + * @iov_cnt: number of entries in the iovec array
> > + * @errp: pointer to Error*, to store an error if it happens.
> > + *
> > + * Returns the created dmabuf fd or either
> VFIO_DMABUF_CREATE_ERR_UNSPEC
> > + * or VFIO_DMABUF_CREATE_ERR_INVALID_IOV on error.
> > + */
> > +int vfio_device_create_dmabuf_fd(struct iovec *iov, unsigned int
> iov_cnt,
> > +                                 Error **errp);
> >   #endif
> >
> >   /* Returns 0 on success, or a negative errno. */


