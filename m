Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5169BC2BD09
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2024 08:29:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTH5A-0005VO-DR; Mon, 15 Jul 2024 04:29:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yuan1.liu@intel.com>)
 id 1sTH58-0005Un-99
 for qemu-devel@nongnu.org; Mon, 15 Jul 2024 04:29:14 -0400
Received: from mgamail.intel.com ([192.198.163.8])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yuan1.liu@intel.com>)
 id 1sTH54-0000vQ-US
 for qemu-devel@nongnu.org; Mon, 15 Jul 2024 04:29:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1721032151; x=1752568151;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=VfIa05IECuSJMp2+0Z+D/4c+ION61PcSdB7BKv4zH+o=;
 b=FsWCe3QCJYb/kQG7RjTFUk9or1O/wM7AqNc0r4EwxYfSN0I0jT+CxDfD
 X+6XQKgqqNR9SH5w6/Fg+9rOzRJV8dUymVQsA/+21WdSkihynooPMM+JZ
 yAkrhrW5K0bmzZmRzNDW0BnslbjeZUEwR2I301aJgai2uqn6uh0MavzOa
 HZAYLeKAHe1dnqSppFGLwOP5mE9kL8RcNuv8VYIBBxeu0xsUugDmperqw
 9kAxQwialASIzjeWsWbhbbyKDKikMuIpS2LpLlefCgUGEv8AI8qjiDkmu
 6Xqwf8E4HphQtdrIrxpa9sRENqsImj8lk2n7RbyhjFdqWNBPc+Eu3owZ9 A==;
X-CSE-ConnectionGUID: VE4dl3dzT+6EYdCK85y8tQ==
X-CSE-MsgGUID: Nd6XG0hER3S1fOWJBDlmvQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11133"; a="35938364"
X-IronPort-AV: E=Sophos;i="6.09,209,1716274800"; d="scan'208";a="35938364"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Jul 2024 01:29:08 -0700
X-CSE-ConnectionGUID: tYJPYO47SkyfUW6uwZ9CoA==
X-CSE-MsgGUID: 6KsIPt8ORZSdCxXaDloQrA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,209,1716274800"; d="scan'208";a="54372676"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
 by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 15 Jul 2024 01:29:08 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 15 Jul 2024 01:29:06 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 15 Jul 2024 01:29:06 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 15 Jul 2024 01:29:06 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.47) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 15 Jul 2024 01:29:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ezQm6ehcjb/p5MbEwDzAw51/wdzBamTR3FaoP1bf6f3bHIV4VFR9GhUX0PMKL5/FZgvRq/uYr8WxXl4HEMDW8TBCO61f+bwiRcZOujbgk8NNPaDYBE9wHiCfWmb/Sv/HRCV5vj6FCn/P88VVsk8dkNBge3GgZG1b4/NffMCM6txasOXL0DeEN8mPHToXPDOW8FnJUrkd1RKVdMoiopZ7bYt2ofYwmKY9Yi9QH8eYAbYF7jLkb7W/jPdzJ0z40k+IAEIZWb0rxTqw7KyYA4C1X4Dup3gchwc4WfoPpmhEund+DaXyaBtE55hqt4AZ68EBeHivzNgSuDJUAJ02Bwrzfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yQ0CjJ88Anoxvc/v3FV8+r0MP0AhuEwNGt2oI9/ElLc=;
 b=ioZhojY5kgWxVNCDdTO21Xx68j+cbJpeSZwjOAVrS8SngY+5u2YCwub4Y/9ZIsEeJ8sQexdQS6Wax77dkPnNzcV+TUrdObjvP+ARs5mEEBOPVfM0TTGMKKX3pQUByyBUzq6oWvsvpmTvsfJTeH+qlcaBOO+z2PTHWQT1lxssxBfO+NXtCN63KQ1JO7n6//L07NNIJHHtK2eGGmNA7UcAXSn1ceydCY722rKSyFuruM3K/YRopADI3fVHtGzF0an9Gn8QmuIQDZ8LPuXGVeR7NtfHCuYdi2gHcQpWajhmjnrZo8jAIC6/2eujVfCoIrQIXzevkBEImB7W4d8J6BFyiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB5941.namprd11.prod.outlook.com (2603:10b6:510:13d::20)
 by SA2PR11MB4892.namprd11.prod.outlook.com (2603:10b6:806:f9::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.27; Mon, 15 Jul
 2024 08:29:03 +0000
Received: from PH7PR11MB5941.namprd11.prod.outlook.com
 ([fe80::2750:7e63:952:7f1d]) by PH7PR11MB5941.namprd11.prod.outlook.com
 ([fe80::2750:7e63:952:7f1d%6]) with mapi id 15.20.7762.025; Mon, 15 Jul 2024
 08:29:03 +0000
From: "Liu, Yuan1" <yuan1.liu@intel.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, "Wang, Yichen"
 <yichen.wang@bytedance.com>
CC: Paolo Bonzini <pbonzini@redhat.com>, =?iso-8859-1?Q?Marc-Andr=E9_Lureau?=
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
Thread-Index: AQHa09y4Qu9AOd5eTECcwvlNYUC9ULHyIXCAgAVUt7A=
Date: Mon, 15 Jul 2024 08:29:03 +0000
Message-ID: <PH7PR11MB594105D464F3A4C2C25F94FEA3A12@PH7PR11MB5941.namprd11.prod.outlook.com>
References: <20240711215244.19237-1-yichen.wang@bytedance.com>
 <20240711184131-mutt-send-email-mst@kernel.org>
In-Reply-To: <20240711184131-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB5941:EE_|SA2PR11MB4892:EE_
x-ms-office365-filtering-correlation-id: bdd5ffc4-00c5-42a0-51e4-08dca4a82f10
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|7416014|38070700018; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?lGGub2tfgAvspfGbKSt+qDxvdl1ORx9m8DNoYxZ7cOsk689hc/7C6ne3Dl?=
 =?iso-8859-1?Q?qlhkdH20yI3z5Cu6jIyBBW3In/gbZgl5aPRJkpzvkCDvtgRY4CohShAUQN?=
 =?iso-8859-1?Q?RQE5XbMNgJrOpxSDl0fOk6VchG0/oTDFLqX2ikDwRKg1jeU9bDTnoxS09N?=
 =?iso-8859-1?Q?Csur8BUALzhQ1KD/Hz7uzn+ia+OGUswCqPvxNfBbOdDDI6PzEJtE94E8A+?=
 =?iso-8859-1?Q?pPDtYZ0B8+ME1lmTMd9XpecN5Wt5B4oCLy4gt3FMJ25ZBNKJc/rl6AAHyd?=
 =?iso-8859-1?Q?Es8r30A1Q2xEHvu8k+nzOVU4m0/H/ZwRjM3/9nGpgXXyA9mI+ZP7mziovU?=
 =?iso-8859-1?Q?NSccLyK24+3BxmrcPK0NVRxc3vYcmA119uyNTuIPMsYBI433nkod5NcUSY?=
 =?iso-8859-1?Q?tM+mAPVjW2Pm1iu8K5zjCmNwFUTH5KpvlhSRzXLa5CwieN7AU1uVapW/KP?=
 =?iso-8859-1?Q?1d1OpX4/AAk/cRUyUM3qD5G6omoeyq6UNgr7U8fvR1lG8llH2O16RqRlBh?=
 =?iso-8859-1?Q?f1jrvlOdXvM+3tM38g7rnGysiHxEc+UaOwlOwS+9fqEL+hTIfp7FzRqykK?=
 =?iso-8859-1?Q?pBftS8qJjy/phdXY8JgE26jU6P77WBihRzzEjr4AS+QdHqW5G1JYul7Oe9?=
 =?iso-8859-1?Q?AsdikHkZDbvT/XkpzMXADzCeApmWha+uqoL/eYE2pRbI9R6Leoq4OOO7u8?=
 =?iso-8859-1?Q?4o9aelA73CQYLaTEdZ7ynU/ec2VY+hKjG8f3S5LNoHwIoVmt8lHAN6H5Tf?=
 =?iso-8859-1?Q?pzXcnCDz50fb5A8j+SHhHnbf7zcoDEUWaC3e/OC34u8OQQKcsmKnYn4AYd?=
 =?iso-8859-1?Q?jwgGOZbu3zGl9fukb2yzBxk3F8l4ZSUVVJQNPF+TEbX+uLgtd7Ff+StmyR?=
 =?iso-8859-1?Q?B9TC8pLU3i2io2CblvUMicLqLYMz1Tg7cAi6yuc69d/BPsCiUA+qpwwRV6?=
 =?iso-8859-1?Q?EhHbrwLOaVDLCRZJqG8FhcCAcavGbpwRGYCrwJ4yLn4V0ntPCj/DadF9Yw?=
 =?iso-8859-1?Q?3lEiAfIcL4ktZtzItFdiRucMt2k0UqXrA9naLh92dki+RjNc10QEydbaB/?=
 =?iso-8859-1?Q?hnNUv7GBxj/pkRPQG8vpwAnJCxdVqbkKk9ZmuKtZdL8qs5wzOHXByiVR2+?=
 =?iso-8859-1?Q?YbWNcDEZfaV76YPtiML4wTRCDiKQYGORZbFTiDSIdpM/y6RMlae8MwUZew?=
 =?iso-8859-1?Q?dJCcHKUntdCYVnb8oYK+liScXeU7WKiiPRUrlKmxEDD3Rq2yDMRMOjqGmi?=
 =?iso-8859-1?Q?x2Qr5DRV0EQ0jBUkkhJxRRFy6TuQJMk/VtRA/MoOBZJKplSIueIyzcAFFP?=
 =?iso-8859-1?Q?HDNEQ2mFodU8JZ3n0jmfdKhUMQ+5uDfuQkn266Hlw7xjpYr56N2G7B+va5?=
 =?iso-8859-1?Q?1OG0vewvH9KywJVBeJD+4Fz/W7teHkBVMIjQcuJnUHVHSh6d9f4uU=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR11MB5941.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7416014)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?k04A/s2/x1LkxH9JU7C6LvYNM6CaWVLvr1OH+VfxwrFE5MaBWag2q22Myk?=
 =?iso-8859-1?Q?xkl7GUC3Qf77SzJ4Y8IqUgaf9LoxInHet2vh0FXnpK3Rf8nGOLF9R2Yvrz?=
 =?iso-8859-1?Q?mo4wdADuuWE3b1e/6aBqCcrJqY3FeCONBhdGYn0jg8zflMQopt18SsVLqn?=
 =?iso-8859-1?Q?6jKRswcx3AWyGMxVUuazFbJ7VfXYxE9a16jY6acaQOAbNbiqM+83sV+qLL?=
 =?iso-8859-1?Q?Q8enyYABZCkwjcK8a3Nw0Z0JLyhyMn3KKsjRr9h2MiUsIeXeBpazchBTYo?=
 =?iso-8859-1?Q?3Ge5TsjgPi5pyone16tSlkELykMh6fhGcD/rGIskroBixHBrEEB3zzOLGH?=
 =?iso-8859-1?Q?mepd93fAsK0N5wh+ZKEfEavpkuBHFVUnE7nQWaUJlbebCqDKg9aMyLFEZl?=
 =?iso-8859-1?Q?M3yKbkw0OJm/QAiCagETcCXbp3/Nk9iUB7GwusbjTJJEVrgl5rKtpZTzW+?=
 =?iso-8859-1?Q?IPC/SUqK1+huTIVCX2hww1yXTPX66QaGN3M0XtZHEk5Zyj+zkt6soiSgrL?=
 =?iso-8859-1?Q?YSeupckeGFNnRGhdVrLPCbGhCr1UrwK0awcJU7VwDTOwLJyX4wMJebYRiF?=
 =?iso-8859-1?Q?Jl9jC3nA8+17A2MA+L/EKitouqQ8/2fmTlVH5zYBFVx9VpTDzYBvQHhmzw?=
 =?iso-8859-1?Q?0Q2swngOEz6u4OGcvjQV+xn7rRIJ0N4GLfUYSA+7xhLpzO45XO0NJYCZhF?=
 =?iso-8859-1?Q?piIQAsgUy/s4oUn/0JP7B0P3MxAhTM9rV+dbg9m2EP3+9z2B5BPq8zc1Nh?=
 =?iso-8859-1?Q?ttsL77M0oaoSJ4yTTOax0YK7KsZOuR0Pz664xsHQ3wki8F/5MJPreywoOQ?=
 =?iso-8859-1?Q?z3vohKllinlwsgsHd7egw3Da8ZLqpC45GyQWtpStJ4d6sre1ZxMr12aUrd?=
 =?iso-8859-1?Q?sGZ9vbKW8SS6RyVX+JtQUZNVh0N5Kw3RVFlIb2F82NjoFi+Wxu1hFFNGEa?=
 =?iso-8859-1?Q?CImEI0nOy9MrXq9HTUGfvGbj6y+6TiGzVFsA1i0pQgxjPudk7HquVOQzqM?=
 =?iso-8859-1?Q?YpYAE90AqNaCNxL7wUiLE0bPviRu6giiEMarwmhkUGGc41Chb+0PVNhWfl?=
 =?iso-8859-1?Q?5VQDcnYLBBKjuHCcvtXWGWvoNjaIRaUsGS5U3D6jAKl705eoURCNLoyqKD?=
 =?iso-8859-1?Q?rdzgLV98NQ1PAH6RHkYsqbxfa/1lire+DiM4znmUgVPV7jmb+ulWGfOMQE?=
 =?iso-8859-1?Q?RbYdbdQ5L83TFn8jebBUIar/59G4L35N/pjfAoVu57QhhDoJIyoFZ7B9al?=
 =?iso-8859-1?Q?O7vy89gxr1Ai4Dk/0tSMhPt/Qn9qnXxJNGU/1J6lJS0Fuzk4yRP+ZGFQuZ?=
 =?iso-8859-1?Q?JfwHxFA0RLDTSVKfrLnLxuDtfx7a93jCd6IMkvS/EEfFqBhSgz3VthmPBu?=
 =?iso-8859-1?Q?NQC4c1W20/At9HEYuYQKPqbAPMpx345YTOFh/7cVomFh/3NUigX8VD3t7n?=
 =?iso-8859-1?Q?kW8BeNhSuLfPyE9pSiLPnWL1griUlplRI7PdMSsw3WcS+999BvmzSr4P85?=
 =?iso-8859-1?Q?5bl8mJxqSTBY/dbHzWCwPaGGHNBXizg9zLF6U69yacMlVjOFq8+kLRs05n?=
 =?iso-8859-1?Q?UmV9ebjdOtZlTljFwDaoFJRlnxLzO0bLXCGCE65tKXyXeohV+j8u1wlIvx?=
 =?iso-8859-1?Q?IqhkRUgRPN9mivmwK1Wkq/eP1nNqv4BaTs?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5941.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bdd5ffc4-00c5-42a0-51e4-08dca4a82f10
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jul 2024 08:29:03.0812 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cWDINSQA+83epGHkDHXWCnhh6/GjC0+AGh3r57oYiFtT0v5bktoWsMuADrWbrm+dXwBjjHn5Cf8PH4uM20jwJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4892
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
> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Friday, July 12, 2024 6:49 AM
> To: Wang, Yichen <yichen.wang@bytedance.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>; Marc-Andr=E9 Lureau
> <marcandre.lureau@redhat.com>; Daniel P. Berrang=E9 <berrange@redhat.com>=
;
> Thomas Huth <thuth@redhat.com>; Philippe Mathieu-Daud=E9
> <philmd@linaro.org>; Peter Xu <peterx@redhat.com>; Fabiano Rosas
> <farosas@suse.de>; Eric Blake <eblake@redhat.com>; Markus Armbruster
> <armbru@redhat.com>; Cornelia Huck <cohuck@redhat.com>; qemu-
> devel@nongnu.org; Hao Xiang <hao.xiang@linux.dev>; Liu, Yuan1
> <yuan1.liu@intel.com>; Kumar, Shivam <shivam.kumar1@nutanix.com>; Ho-Ren
> (Jack) Chuang <horenchuang@bytedance.com>
> Subject: Re: [PATCH v5 00/13] WIP: Use Intel DSA accelerator to offload
> zero page checking in multifd live migration.
>=20
> On Thu, Jul 11, 2024 at 02:52:35PM -0700, Yichen Wang wrote:
> > * Performance:
> >
> > We use two Intel 4th generation Xeon servers for testing.
> >
> > Architecture:        x86_64
> > CPU(s):              192
> > Thread(s) per core:  2
> > Core(s) per socket:  48
> > Socket(s):           2
> > NUMA node(s):        2
> > Vendor ID:           GenuineIntel
> > CPU family:          6
> > Model:               143
> > Model name:          Intel(R) Xeon(R) Platinum 8457C
> > Stepping:            8
> > CPU MHz:             2538.624
> > CPU max MHz:         3800.0000
> > CPU min MHz:         800.0000
> >
> > We perform multifd live migration with below setup:
> > 1. VM has 100GB memory.
> > 2. Use the new migration option multifd-set-normal-page-ratio to contro=
l
> the total
> > size of the payload sent over the network.
> > 3. Use 8 multifd channels.
> > 4. Use tcp for live migration.
> > 4. Use CPU to perform zero page checking as the baseline.
> > 5. Use one DSA device to offload zero page checking to compare with the
> baseline.
> > 6. Use "perf sched record" and "perf sched timehist" to analyze CPU
> usage.
> >
> > A) Scenario 1: 50% (50GB) normal pages on an 100GB vm.
> >
> > 	CPU usage
> >
> > 	|---------------|---------------|---------------|---------------|
> > 	|		|comm		|runtime(msec)	|totaltime(msec)|
> > 	|---------------|---------------|---------------|---------------|
> > 	|Baseline	|live_migration	|5657.58	|		|
> > 	|		|multifdsend_0	|3931.563	|		|
> > 	|		|multifdsend_1	|4405.273	|		|
> > 	|		|multifdsend_2	|3941.968	|		|
> > 	|		|multifdsend_3	|5032.975	|		|
> > 	|		|multifdsend_4	|4533.865	|		|
> > 	|		|multifdsend_5	|4530.461	|		|
> > 	|		|multifdsend_6	|5171.916	|		|
> > 	|		|multifdsend_7	|4722.769	|41922		|
> > 	|---------------|---------------|---------------|---------------|
> > 	|DSA		|live_migration	|6129.168	|		|
> > 	|		|multifdsend_0	|2954.717	|		|
> > 	|		|multifdsend_1	|2766.359	|		|
> > 	|		|multifdsend_2	|2853.519	|		|
> > 	|		|multifdsend_3	|2740.717	|		|
> > 	|		|multifdsend_4	|2824.169	|		|
> > 	|		|multifdsend_5	|2966.908	|		|
> > 	|		|multifdsend_6	|2611.137	|		|
> > 	|		|multifdsend_7	|3114.732	|		|
> > 	|		|dsa_completion	|3612.564	|32568		|
> > 	|---------------|---------------|---------------|---------------|
> >
> > Baseline total runtime is calculated by adding up all multifdsend_X
> > and live_migration threads runtime. DSA offloading total runtime is
> > calculated by adding up all multifdsend_X, live_migration and
> > dsa_completion threads runtime. 41922 msec VS 32568 msec runtime and
> > that is 23% total CPU usage savings.
>=20
>=20
> Here the DSA was mostly idle.
>=20
> Sounds good but a question: what if several qemu instances are
> migrated in parallel?
>=20
> Some accelerators tend to basically stall if several tasks
> are trying to use them at the same time.
>=20
> Where is the boundary here?

A DSA device can be assigned to multiple Qemu instances.=20
The DSA resource used by each process is called a work queue, each DSA
device can support up to 8 work queues and work queues are classified into=
=20
dedicated queues and shared queues.=20

A dedicated queue can only serve one process. Theoretically, there is no li=
mit=20
on the number of processes in a shared queue, it is based on enqcmd + SVM t=
echnology.

https://www.kernel.org/doc/html/v5.17/x86/sva.html

> --
> MST


