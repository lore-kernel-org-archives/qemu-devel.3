Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78993C7115B
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Jun 2025 08:21:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uTcQa-0000bb-O5; Mon, 23 Jun 2025 04:21:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uTcQS-0000Xu-Oc
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 04:21:16 -0400
Received: from mgamail.intel.com ([198.175.65.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uTcQN-00088C-9M
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 04:21:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1750666868; x=1782202868;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=iBsIttGL9Q4Wn2cMhcWqEUylSJ+w3INR/WY47imWXII=;
 b=BFhBJPZTAlNr+6jG+nHor+LdXFNNiiA1hI+arBYxIR3Jn+99beFLATNq
 cLbSg6ijI9MSNUA+pq0nC5XZ2QOG6DMy/UMNidA4Yazv/mt68ew1Za3ZC
 MpNP4tpJO7SKcy6+lGdPX4VNeAIB3f4e0O2HtRbJonKHf1jICxCq17FS5
 mHyglRm9FgXY3GGcbzIy2d8gZHQg2083Ok2TTM8qqlNoIw2WGVvelEJRd
 AxoApg15GIlkOppGkx2Kc5Ebt6TSi6I6DidI9c31MnS7wLT2YP8gAESDF
 wno2L7tgmnlHujikOC4IdeuAYVyIRdrmzM4DitwcNEzrbLJ6a2DdulV9k w==;
X-CSE-ConnectionGUID: 8ApFa236QUSIQ34Ti56tOg==
X-CSE-MsgGUID: ggiFMVaFQj+xip8BoSV49Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11472"; a="52831779"
X-IronPort-AV: E=Sophos;i="6.16,258,1744095600"; d="scan'208";a="52831779"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jun 2025 01:21:04 -0700
X-CSE-ConnectionGUID: S9CW9TQKSSeVK81823rt6Q==
X-CSE-MsgGUID: 3tMYE8zGS8215p3QCZpOYw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,258,1744095600"; d="scan'208";a="175136693"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jun 2025 01:21:03 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 23 Jun 2025 01:21:02 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Mon, 23 Jun 2025 01:21:02 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (40.107.101.41)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 23 Jun 2025 01:21:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I+BwWf82L2zpSuBZ6w9ejBqsUyovgck2TgZTxLqoHuT4WdktEV1sTlqIoHOr8EiGZOZkwzbhOpcG7PoXALoDlHsE23CZpjGjbbGFLax7ECUN9E+RsSJcT/TtobDnp3wY9qzaw6y8n4WAm1HzW+nuAJSVJRvuOuytdeEpJmZMdkzs35kpAWdBfwbger4b7iOenmdampCt9sGDTxqQ7Mt7L+3xY+LFmj/Oha4VylIIcDQOA5TS7bRyaZK+a1uOpRzwreXvNOYesqC+c92uS9PcyCivDbbQ3FXNgJrWJk97nEpKCCaQYpHHj/LxlRQfoFxkk5N017cAzmfjyfbg5YaekA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iBsIttGL9Q4Wn2cMhcWqEUylSJ+w3INR/WY47imWXII=;
 b=SBB5yl2JQ/5MFVOKvFuvtTffIlQwrP3cz3q4KcK7PktAm0SD5vUsXRKF4fDdUPSBqQX4QCW6xbTLTAMRxYzzH55lRrQbJ9xsZMW7JnwVmVcMynRU/77rHscNBEM/vTIgyXC9upUeSnX44J6zBv/+iVIC/NlndSl8HQKEqVyukhKczgY5O8gf+dscZwQv+0Lmq6tL7D7eVtm2jknEZ9sDCv3L7ufFmSVWX+0zJGPfYgLTz1HSX7erJCtrKVFekKnuijuGh66Xb18a11gO5/xAncSeixNaMzryr/GjIz9/M9qhJpi4tEY+YkdQKd07pTZUmUcT2qGGrpysmK9MQWFEDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12)
 by PH7PR11MB8036.namprd11.prod.outlook.com (2603:10b6:510:248::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.29; Mon, 23 Jun
 2025 08:20:33 +0000
Received: from IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13]) by IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13%4]) with mapi id 15.20.8835.023; Mon, 23 Jun 2025
 08:20:32 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: Steve Sistare <steven.sistare@oracle.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: Alex Williamson <alex.williamson@redhat.com>, Cedric Le Goater
 <clg@redhat.com>, "Liu, Yi L" <yi.l.liu@intel.com>, Eric Auger
 <eric.auger@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, "Marcel
 Apfelbaum" <marcel.apfelbaum@gmail.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
Subject: RE: [PATCH V5 23/38] backends/iommufd: change process ioctl
Thread-Topic: [PATCH V5 23/38] backends/iommufd: change process ioctl
Thread-Index: AQHb2h4GwGEN0QjYrkmW7ZC6473VZrQQes3g
Date: Mon, 23 Jun 2025 08:20:32 +0000
Message-ID: <IA3PR11MB91369747BA941A4AFFBC83EB9279A@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <1749569991-25171-1-git-send-email-steven.sistare@oracle.com>
 <1749569991-25171-24-git-send-email-steven.sistare@oracle.com>
In-Reply-To: <1749569991-25171-24-git-send-email-steven.sistare@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9136:EE_|PH7PR11MB8036:EE_
x-ms-office365-filtering-correlation-id: 92ac8d73-6144-456d-fc14-08ddb22ed294
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?SUu2tpG8lPvz+kXZPzjlBZt8De/kRE/Efx5kQgqKmGGRtwwP1a5Bnws0pGjI?=
 =?us-ascii?Q?SF5VkkkyDGR1ydlwm48ljaTAiEONnGxJd23hadQ0DHUwgnHJdE+/K6x1FbwO?=
 =?us-ascii?Q?kSdqeF5I3gsjTA9+/ZJ4kk7+YJjs1a0krvsMx80XyxqKNZsISREgE4vfoDyo?=
 =?us-ascii?Q?Pm0glPY0KdDzLiW2+UDzbOc8Fcl8F/rxrBr+f5TpT6XvwttO5L3XSylA6iu/?=
 =?us-ascii?Q?dyDXKl+zu6YEBTJyvvKJQH5DX46TophvX4f/tRQUSqmmdXjkqnoG2VDkDouX?=
 =?us-ascii?Q?a7tC75kgYYvb3czWcfVM/NSw0hbxr6YXg+9kARbNfRFnS6Ma3WSyTsO3bO4s?=
 =?us-ascii?Q?JoGYmu8FAFOZRm0LuDNHtA27K0PwsvY77SeBit4pqrDvNqWjG2SxE6496nwV?=
 =?us-ascii?Q?G6q+LLWNFkBAUH97Wd4E4enoM4+dZjKywKhDJ2t9oe0CQYs1P/LyJGRNuO40?=
 =?us-ascii?Q?R+vf6YEksmAtXgwdEh1Ih5l73PbMct4eeS08JqZ3mlV1iNuOri2Uq317UKnM?=
 =?us-ascii?Q?j2cjB/7U1yIDHzVggdUCij4H0N/+CKI1AanZQT1dJe/r5s1NEBZcEgvk33KT?=
 =?us-ascii?Q?PGgA+ecPlCkPIpL+8O55gYyQ1sGB5rDyr9E5DefwMMmi+p378zlFpnsBmnVj?=
 =?us-ascii?Q?MQSFkXz6+EmIrBUYC9HAkBVDpvphM0wiQPqTpZMhBGggALMmHfbP1LOYUWk4?=
 =?us-ascii?Q?g/eoHc0la6L35XwBn1WtWUU526rAdHPVopnn9WVVuvkH+H3xHGkOnyrVcBW6?=
 =?us-ascii?Q?U/czea9rYu+SRcqAZVWRMk0lrXFtY1n7e+fGKNn47ZiI9KdksIEQJ4QaS4Qb?=
 =?us-ascii?Q?HLRfGuGdHN2X7O4sIQPIkX2JgpgAPFR9Ndp4TR+gCOPgXqMhYKvu7pzSGf3O?=
 =?us-ascii?Q?aP5vZIAgbqRuZFx4klbCYauQglcGqz9+pKHOqzMmoHfwH41eJqOigb7rh0k9?=
 =?us-ascii?Q?GVumkqZ4CvAYgX4rNSEkaj5xYPEfnJG7ZJKzcASZhs12Q89NfD0T5mHClc9T?=
 =?us-ascii?Q?Z2FJmklGMsTmtP2mxPfDOtygYc3JMFXGlFvZOUo4w8XwijAGSW4qahuqlMKu?=
 =?us-ascii?Q?mg64D8iv21NQlyhcacPga+3sN032sdJgVsFE2xZc4nD5GMWQbmo4oCdYlxbu?=
 =?us-ascii?Q?HAYxr48WGB050SPb+51nCSL68VzxusvfMd9NzZGjckVKcheaP3bnZxHJIWln?=
 =?us-ascii?Q?jjN5vKmovDm07weixMDblQXTfe8Z1hXzS8evoDQ+1ak8MtmpEcg9IjclvIsK?=
 =?us-ascii?Q?5c3RZUi4kWmms2AAw2nGIYE5+xVirP90LCgS3U6gYBQx2bDDMvIg1NtRwMQ1?=
 =?us-ascii?Q?paVrlzazqzK1t9YkbnF7F/UwZRTabWEmevdFSCO//gVQ7kdwqrzDTUEuuZSe?=
 =?us-ascii?Q?ER7QvRNP7tuoxior+eQu4snJ/pX2MFbtg8eEnzcFl9TLz17ithMUG/DYK3w6?=
 =?us-ascii?Q?n2V6wHoqsD2djiOqbO/Wqkoq/y0q3Ii9bql3zlgAMcOz/uG+vN5v1A=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9136.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Ze9+OoNWJjVI6m4ooo2YQpYJ9yZ1xtB3DpwkAPRWqLF2QA4w+dGjb39xPOrS?=
 =?us-ascii?Q?4JA1YsdPj8ocrMFikA+3REumPYQvah72xs0Vd+hoMaxobGG8q/Uoe4Qz1j2/?=
 =?us-ascii?Q?lyV7rNcWfwWZY6DCmSOQi6CaVm1/f5K9dN+RGu3ozZHahIpo5afjtpcCCoV9?=
 =?us-ascii?Q?O0bEmElSlA92F+CtRGWQYIqTDiGzKGJaA6p8XzRCiLtCJwo0znJBcTpWoev1?=
 =?us-ascii?Q?5E7xEsUQ+f7X+O4529NXKWVVbz9u80UESsTtUORq5TRGqEKtIL3tjpyE7Vrz?=
 =?us-ascii?Q?+xfkg9CJmQkaGTALm0D0UPpqT1in7uP4RUYoVQjhcgVAsnXrAF9UG1ZXAd2u?=
 =?us-ascii?Q?YYR0aTHVkGUkR07Nd4x481PR8WizOVVpNyNF8KQ49N78YtbIFB+U1vUWXOeu?=
 =?us-ascii?Q?Cp3tswrXUMZzx4oiDoT1zWLls4dKFEluPljEpnaLRijAODxDL48L0ob9q8ZY?=
 =?us-ascii?Q?2w3/GDBcsD5v0R4CPIx3mcvQS4Z9pqbRbTtKNNrVB79brcni6o9dZ0CWN7Cx?=
 =?us-ascii?Q?w9TcXp/jJz3bU4V5RV0tLNlXb1Hvd70hKYfkKyqqaGQRv883eqk1O6Z+s/vT?=
 =?us-ascii?Q?aMoKL41ux+dmjNBhT69TP+X8F0XdI4WTCpecSm9nzH+suyvbrpfw5zvYAHhR?=
 =?us-ascii?Q?3TVnxfrLjFnWTPdszfChLysgoWlfxjxikIkEXSBe+H9WG9dXwUpUXgP0GV2R?=
 =?us-ascii?Q?YPhL4FBS4p3HswqJc9mvq5KbIuImSFeE9Nnvg1U7yjl8UcrHW0LBUKlptD5Z?=
 =?us-ascii?Q?IRVxXEHZRoSv6GWAlrSqxLzx6nh7XPkuRTA5WLJkVbjFaXzCIDUZQsQJ8dew?=
 =?us-ascii?Q?flxjJHHI6o2Q2Egw+aUnS7UvSBWbnR6ntC5LKYLS6/02sV3tnSdn9vGrLTgc?=
 =?us-ascii?Q?V00L9LDChICfXj/e5ZiQ0wjGe9OjEgeAawS/QltPfrk19ZG2D2gF2/7qVBo9?=
 =?us-ascii?Q?wBQQK6jenS21KSnj3LPZVA7VyA0HH5xdFhUiWjC40hdtCZIjGAdvGJMzUDZP?=
 =?us-ascii?Q?zpe4xswjw8kUe6lfBliuU1G8Ut0bt/JR10DqWnTbHyKuVWVIS92DCtDsXBPa?=
 =?us-ascii?Q?vPH/bQxKKO21ubVMZvS+TKn3UOQzz7cpRKcHsHdYJC0ZHXZSBAfQkE6WQ9c3?=
 =?us-ascii?Q?qpVV1VA9hw7WYnpd9ddRrH81oQLuTyOZCuA416BlN8euldKtP0x71n1fdd25?=
 =?us-ascii?Q?beWmo7Cu30yvAXM42i9ZPO/LRjGdM0tZixNDnb98ll5aJQ5/zziUigSw4oDo?=
 =?us-ascii?Q?ZFJj7nxEEz+uKVWkAiY5WuEuY9f9CnrVanM2i6/TSMqzKpa2BwgNAPKa+qlp?=
 =?us-ascii?Q?DSFcTXMmuMOhaSxNQV2Kp1vu3eBrdY9d08gge0pdI6SgLKG8UcV7cPN7mNbj?=
 =?us-ascii?Q?43g3msrSo+qiR/DGWVqY/VvRPBfVW0LrjaH5tH2PdQ3dFEiNT4oeXQZYQMwj?=
 =?us-ascii?Q?oMXcaP+Eo1y6rGsdQ1cdm7xWGf8bpcH+1M0Uofc828H16+1sHVIl0zE4Z+k8?=
 =?us-ascii?Q?4Y6JQnDGMPqYEbTDVUoTJiKHD5ULnDzVnv02QZ/OgRc1PPgk9PgHNgKp2Udo?=
 =?us-ascii?Q?z8zgnPhkzsCUna4VyfjPTDRAnIu6eQs64X7Ajdjt?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9136.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92ac8d73-6144-456d-fc14-08ddb22ed294
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jun 2025 08:20:32.7380 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3aUEWH8Ec7kzQMPEN7XBB1K56GX1EzLaTccKdSPda7HswkJ1KJkJWMCApE7GK2R9QBeuxhUP40M7oUjXkwDdizOlKHaxymgJ1HMtynuAbqg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8036
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.17;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
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



>-----Original Message-----
>From: Steve Sistare <steven.sistare@oracle.com>
>Subject: [PATCH V5 23/38] backends/iommufd: change process ioctl
>
>Define the change process ioctl
>
>Signed-off-by: Steve Sistare <steven.sistare@oracle.com>

Reviewed-by: Zhenzhong Duan <zhenzhong.duan@intel.com>

Thanks
Zhenzhong

