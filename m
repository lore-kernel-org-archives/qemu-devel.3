Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33434CAC5B8
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Sep 2025 06:01:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3TQB-0003C9-U0; Tue, 30 Sep 2025 02:01:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1v3TQ7-0003Bl-NA
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 02:01:04 -0400
Received: from mgamail.intel.com ([192.198.163.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1v3TQ3-0005E3-KM
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 02:01:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1759212060; x=1790748060;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=ubdXcknVB1rsE4JzrFZUL4HXDrfi08pDLhWXtbLek84=;
 b=W/0SfisECWYGqh+bdIbyDmylOjorOmzy37xDko2px15akW5KjOVxbMph
 MFiOqSh+Ap9YFwqNU3LFEgQ19AqDS5bHAwz8EBdl8ft8nGyJQ+BDpALfp
 G648TmMJ3ME/5tU1YqQ18LOkl4oJ+B4SbYsSd17aWJ5n3eWsPIbdaD8nn
 zePrEr9ietpcNa6St+n2iSG1o9Y2Ofvd0C3nb9B+SPo0hMTZ+DC563O3k
 UA11rpZ3RsL5k/pc8SYR6LQcQrrLZExkhlLkRfhiYSkxoDQf0dE4Uvi9u
 JzGrMDSfGaDsGGadGUWnyMXRk5qyk13ZfbW9i+UK7jOKWX0pUGaLWGtcY w==;
X-CSE-ConnectionGUID: fjwUQJ0ESyyN6aKYYkCp3Q==
X-CSE-MsgGUID: kH3Vl9XkQjqiuealFf/UYQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11568"; a="65316653"
X-IronPort-AV: E=Sophos;i="6.18,303,1751266800"; d="scan'208";a="65316653"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Sep 2025 23:00:49 -0700
X-CSE-ConnectionGUID: TFre7zRFQlSKgeChNzwH4Q==
X-CSE-MsgGUID: IWzJYQnNRV+9m2pKkyqjgA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,303,1751266800"; d="scan'208";a="178816604"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Sep 2025 23:00:48 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 29 Sep 2025 23:00:48 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Mon, 29 Sep 2025 23:00:48 -0700
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.55) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 29 Sep 2025 23:00:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bTThY4jSx2RtRWSyhbNQR6mOIrK4ATAxtxVFZmqrwOzGOA7+LDiynjcRg222FaOII8RDJhaAbmrEOiPW93n21Rqrn6c0fEzdAWgodzjJE2BioaTpwk/wGMygktelo10hZhMzoJncP10/ndXWoBPO4kpb0HkcMS8XeW4HF+/yGEYYZw+RRC7hCaQ//QscLHg+VN7mpgKzkRizyP6kT/tYJ52nOTWoHjOQKLECYBjdBjB+VwX/NPJf56mb8HNec9ATH5OgFYX7ldkbpjVUq5RBU3a4FkXQbn2CNqmtcBzHGcqbTERaPKzai15rRld9A5QgwiOCNvZvXOOi45VQl7H3yA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sQMjWDHK6f4uTH00rVFlj6UUVpcHSrqCSPTX0KrxRH0=;
 b=ItQfptWXvQFH+5RvhrTWdhTgzv2s9sIDioiGTXFhyJniy8jsnKKBOaBWdJTTqvLXgpL8y0PjFtYp2kn9h6HvloR5qwjyElLMJHdsO4ZuGG1lAgi9/X2i2LJShMDUaK1WOU2n+6JhZY5/Ek2dTNTK/DH6Bz9SwQdjVwACDyl68FHjfWn+yL4K8r8G6xmZQT/cTHlUdpbo+YzCSVQzhlqOQEdxlZib51X6dsJ/45wPRdY46H8YmY4QvrhbQLtHuLS8/EL7a+LJ227IOArRgynNgf5q7avVKycI86x0SFzrFDIq8Gc5nKBdFcB4LlsqAu0ypDxMWS1hM2mB5UyFAt4Tmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12)
 by SJ0PR11MB6766.namprd11.prod.outlook.com (2603:10b6:a03:47c::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.17; Tue, 30 Sep
 2025 06:00:45 +0000
Received: from IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13]) by IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13%4]) with mapi id 15.20.9115.020; Tue, 30 Sep 2025
 06:00:45 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: Steven Sistare <steven.sistare@oracle.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>, "eric.auger@redhat.com"
 <eric.auger@redhat.com>, Markus Armbruster <armbru@redhat.com>
Subject: RE: [PATCH v2 6/6] accel/kvm: Fix SIGSEGV when execute
 "query-balloon" after CPR transfer
Thread-Topic: [PATCH v2 6/6] accel/kvm: Fix SIGSEGV when execute
 "query-balloon" after CPR transfer
Thread-Index: AQHcMFWngtFRdKHVOkWcXMje/gJxi7SqMJYAgADkn4A=
Date: Tue, 30 Sep 2025 06:00:45 +0000
Message-ID: <IA3PR11MB913635F06F6522102D8FC15D921AA@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <20250928085432.40107-1-zhenzhong.duan@intel.com>
 <20250928085432.40107-7-zhenzhong.duan@intel.com>
 <1ba0dbca-08b2-4f80-ba12-01884a25ef0d@oracle.com>
In-Reply-To: <1ba0dbca-08b2-4f80-ba12-01884a25ef0d@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9136:EE_|SJ0PR11MB6766:EE_
x-ms-office365-filtering-correlation-id: 5c979082-dc97-4ef9-8206-08ddffe6b266
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info: =?us-ascii?Q?RzuuenFYbVysV0AXrYuF/nWoZuH8Y2ZsLAUIQuIjP6fAwLCduPZ5h7G2Y+hb?=
 =?us-ascii?Q?FrqdFh3t/NRh0kUfMfEBRv9ji730qfwcol1z3rqLckq99zF6mdnH8Aa+BvyK?=
 =?us-ascii?Q?RxdEsKF0gRnSg0mncIQUTRVZhEBmtjU28C4yGsx7CwDUNsDgqjh4GNpjUDLv?=
 =?us-ascii?Q?VBhU7+uw+FqKbPaVqz8DHWWJb/0QpbpZ9B+hmlnp9EABf2HNA5M04OAbtb5P?=
 =?us-ascii?Q?GPg24n/3mNF+oL9J8JQChujPziiRUmxE+IQIIRr1B95f64VO29WLV1ph9uSf?=
 =?us-ascii?Q?ifWL48h+lRj3ZfRG/tMdwUpU3sWkmW+Axk7RTVRETYzCc4oumeUB+t/3wXl4?=
 =?us-ascii?Q?jf0XXRTshlqmGxR2xDkgPmgBOIHFZwcF9fCpwZlI64I/nUDaJU2Z2ovpKjgB?=
 =?us-ascii?Q?B0lUb43mn8MGy9SY2++qKM2mpg+mxb3R+61doewzWM5YJ3BnmSw6n9p8Bhyj?=
 =?us-ascii?Q?UGosZ8+64yJ47mBrLb3fkD0Gdi8gMgGnxqkFC5PRZWpWq3q11baWox4hxILS?=
 =?us-ascii?Q?aRtR019CoxEAeIlTTdiQCXZOla6awd4RRpe2f93ysGP+8Gk/UxJU01SJTOOT?=
 =?us-ascii?Q?V5bzhvDBsZF/cJaptqNURQmg/LC1Bq8i94JXH4Oeb5kywNhYhr99p0vBioJV?=
 =?us-ascii?Q?MfzkggO7bJ+rE+3P5bF3xrFUWZ84MZ6kSvyx15UVefLjWsEd0jCWro6liGiB?=
 =?us-ascii?Q?qtCzk+8zqI9jQOHqn4p8isDZknzcGPFxeCzAkCZyHtHSiallN49z7Q7VMiUN?=
 =?us-ascii?Q?AAEjLEeNyxEBFD6PqUDWaURsSPfR73Fy2mgZTdaGaaNjMDPG11AixvDQDzO5?=
 =?us-ascii?Q?STR6hxFypSaXk8RnrG8unnWzPRlCA5fhvLbWPk+ljjv82PNA+jbD3ULejd8K?=
 =?us-ascii?Q?CS4Hcb4tmyyshVWdN7H79FRpXYHgKyEDYmxpAcwskTu8mq684xC9rAbAgp66?=
 =?us-ascii?Q?Cn0Dti9OLM6HzBqGnbZ0igchKxn42+Tnz2ch/EY097Ljg7UmdyWlqbQiNmof?=
 =?us-ascii?Q?15cH4PfW21BhrScCqNgnbi33umaly+SwI/cb5z36sUMCC7/SVfJHT7JWJV5D?=
 =?us-ascii?Q?AtMkJvhFF4nGKS1++kf2xQ/W3kAsglUbSbWFMmpDYH7FW0sqdoOUgCLQZ82U?=
 =?us-ascii?Q?+H4+VyG8HLUL3GK6+MQKjdPJ8kwztgafQ792ctoQgQrFSXbl2k9AfLUMYgxt?=
 =?us-ascii?Q?9Al731n4G8MWW1GV+41nrGp/osxtlH/HDhBgFRKJKYi9shcjFbWG1UWTT3cH?=
 =?us-ascii?Q?L7TIHVHA6tXL2Iy93YVdZ9WEtzbn+K5+HREWrcDEdHYSO9kx+D0rJH8gJZa4?=
 =?us-ascii?Q?sCRNCTDVVszf/31cY9O44iOTJiepJecC6C8TyTVAbkcFziICO0IYyYdSPmBJ?=
 =?us-ascii?Q?y1bZT6FR5W1w6Pol1N/LM6byi877EDeQcKLn8M3dyg/MjVbf11CqnuHxA8hL?=
 =?us-ascii?Q?9erW8hWnbCtU9NHEvS8Jn3ieZrapDLCY1vcYjDeum5I3KskSjUbpsaaMGLuZ?=
 =?us-ascii?Q?+644qm449McJxh3wETPB0sMSUSfQtRuqTdaJ?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9136.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?OGEVte9LCDYthPZAQ1OCPybEV7r7DwLSrJCmPKlidTuieXKqXfAfRvarUwvx?=
 =?us-ascii?Q?lqHu+/lw6l6/7qjZpTasi/6Dgq8T5EIIU9pC+ZzHgew6MsodF156Ca0MTQ02?=
 =?us-ascii?Q?eyBoybMZla4uaTZufuZy+f5lmILMi49Z1xdg26ei6TQj0RU3eAYb4IqSFGXL?=
 =?us-ascii?Q?NTP0SJI9JCsDIag1d049ejznt3jp49C2El9NXXTpbXdlo5iSKexQkt1ETEwX?=
 =?us-ascii?Q?2HNYQkVVtdDj2qGaHbb3hrYE2HS0+863I13OgrI/8Rhg9CC1nltWDyBLDmPO?=
 =?us-ascii?Q?DPVB+9eFCcZGK5haQjZewXkkoWqIzz582OSWOvNT05+VBoR4TmoZD3rvqZ/5?=
 =?us-ascii?Q?dayPVtvVfgPGhsizMw5YsdCn52fJdv/l3C6LuLrXR79tCYeU/bYX2T5+ubv8?=
 =?us-ascii?Q?sNYWozqc6i/e+dS/kYDkv4Klhpzeg8gOELqqAj2u9yjZegzt8Vcp/bGU66cL?=
 =?us-ascii?Q?Pyi/rHYSQQGa+ieVyjRkFX8y5pnvp4ZL2hFmFFBaUcnsCINERfj8AHLNR1N8?=
 =?us-ascii?Q?AWQqxvKllxVdpoNfq/k9ClcDqMlphjFfnPf9bl03o6KryQqX4PA5XppVUYxv?=
 =?us-ascii?Q?BaZdY3Gelvhq0CFxSWBRVK8ay++cTGozSP3DquH9DXJSoV2DNADIxhSO/ck2?=
 =?us-ascii?Q?sQ/sT0Q+YZkiNPL9x8gxnVnxyp1qxdXIESiKA7MoQKvxrSRqJpSPX5wFzqZp?=
 =?us-ascii?Q?jH+Sm045WFkkNgWsXOA7ZODhMGySpQNacKiHBe/ywZuAOlBKHUqm2Y+Q/3JW?=
 =?us-ascii?Q?0oWbIqUKCvljF5S8O20tY4yKN1afJaA4YJGyrumjYiUYdi/0waV2ERkBESXw?=
 =?us-ascii?Q?apzVQj+bDj5V3J6qiPtbQDbA6HTGIUoELb8PxzXrmqXOAfRoCPDDIHaFYSg3?=
 =?us-ascii?Q?dzB4kpKuHUpzWdeJ1CJx5MTiGjhqqLZ6MMd4HI6opRdLChaVjVAfH+him6PB?=
 =?us-ascii?Q?ArYCR5JsDsRfmBeAXP2mtUM7KsiOJSTilFDuYwoA31jV0hBhtznjy1E6UDvT?=
 =?us-ascii?Q?0Aphaj5J9lPpi6l9ZgbP2Zr0YIUoYILlcZrIVfsBUKdGuO+XPSeGfblXU4IJ?=
 =?us-ascii?Q?Cz+Lr5EaSeLExCMjpkcRXFa7/73i9+aQZBY/18eJ0UJkGX18JKqNuZH1NgmQ?=
 =?us-ascii?Q?g1vmkKbDg4BOXNZYI359ZeaOW0wyDqFuDT2VqYzwc7H1SYGxBbgLRSqCkAjv?=
 =?us-ascii?Q?hjTKDanKzxgUPCMARCa6HeIMmOcvQM3iBuJ/yuEitPkoP2GVIUz6LOqxSES6?=
 =?us-ascii?Q?vfq83IK/CQs7/DC48e6Ho7vCrWUfCl/KlIR4MHTkMlxE2ieMlyW1U6kh8o1t?=
 =?us-ascii?Q?JRuHBD2dPjx8ewDvIGsAtNx+YTSAzGDK2442auoTsgp/7aBU8meUo2QnsPBS?=
 =?us-ascii?Q?7Dhu/vn+lmSZ2qipaJPQ3CGYWmdUtYuWgIho/Yv6irUywgxxK8D9aLdRDWvz?=
 =?us-ascii?Q?ugrTLdumTg14d1Ck2XWZEwq6ThMyu//eYJJVHpizT0rid/+R0+DJJRRFq7gc?=
 =?us-ascii?Q?FBwt240dxdavmeBdkaoDTn3luDqteqa7qBalXxndrJwckZOouPcc7WGfPGOj?=
 =?us-ascii?Q?055lErT0fyILuyphgfbCIhLogN/zfQGR52rGwo8X?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9136.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c979082-dc97-4ef9-8206-08ddffe6b266
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Sep 2025 06:00:45.6629 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qlh456uuVjRCdB5BxM5Rif1QxYBUUw6x5tfzRJsZhe9qb0mjhBkh4PF0tGYw/q04zhpMD4JphZf4OZMqy7TJfcEqtfAOgD08Q4uhLoOCN/Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB6766
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.12;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -48
X-Spam_score: -4.9
X-Spam_bar: ----
X-Spam_report: (-4.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.513,
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
>From: Steven Sistare <steven.sistare@oracle.com>
>Subject: Re: [PATCH v2 6/6] accel/kvm: Fix SIGSEGV when execute
>"query-balloon" after CPR transfer
>
>On 9/28/2025 4:54 AM, Zhenzhong Duan wrote:
>> After CPR transfer, source QEMU closes kvm fd and sets kvm_state to
>NULL,
>> "query-balloon" will check kvm_state->sync_mmu and trigger NULL pointer
>> reference.
>>
>> We don't need to NULL kvm_state as all states in kvm_state aren't releas=
ed
>> actually. Just closing kvm fd is enough so we could still query states
>> through "query_*" qmp command.
>
>IMO this does not make sense.  Much of the state in kvm_state was derived
>from ioctl's on the descriptors, and closing them invalidates it.  Asking
>historical questions about what used to be makes no sense.

You also have your valid point.

>
>Clearing kvm_state and setting kvm_allowed=3Dfalse would be a safer fix.

But clearing kvm_state will make some qmp commands which dereferencing
kvm_state trigger SIGSEGV. We can expect failure on those qmp, but SIGSEGV
is worse.

E.g., {"execute": "query-cpu-definitions"}, below error print with v2 but S=
IGSEGV with v1:

KVM get MSR (index=3D0x10a) feature failed, Bad file descriptor


I also see inconsistence on "query-balloon" result with v1 patch, before cp=
r-transfer:

{"error": {"class": "DeviceNotActive", "desc": "No balloon device has been =
activated"}}

after transfer:

{"error": {"class": "KVMMissingCap", "desc": "Using KVM without synchronous=
 MMU, balloon unavailable"}}

It's confusing there is no synchronous MMU support but we do have it.

Thanks
Zhenzhong

