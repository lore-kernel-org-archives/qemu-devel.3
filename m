Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD24AC3DA4B
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2024 13:11:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTLT4-0002Ff-Tk; Mon, 15 Jul 2024 09:10:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yuan1.liu@intel.com>)
 id 1sTLT2-0002Dw-AO
 for qemu-devel@nongnu.org; Mon, 15 Jul 2024 09:10:12 -0400
Received: from mgamail.intel.com ([198.175.65.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yuan1.liu@intel.com>)
 id 1sTLSz-0001Zp-4y
 for qemu-devel@nongnu.org; Mon, 15 Jul 2024 09:10:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1721049009; x=1752585009;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=cJbbEnOq5YBKPHLyQK7bhma4d5ynPt85fC7btVXkQbo=;
 b=KMJAnK/rBnDlTGenEdkAoQGAhEAsEot8FC8Lk+1sKmHsUcs3M9LwCCBB
 0Ak2DeI+YAq6HRuW/e47zeoJO/kWpNw3VwKAcrAPH9FAHkSBwe0h0yd7q
 9a0WK5UjqzxP31xoCnQf6vim+MUdkcjcHCMoEWnbhcHXiLAdiNtkbFgDi
 wkDVY1gfnTMvkHHdJ4iebGSlvQqiirTYDofDJyJxfdbi52X+3EqzeFOaB
 fsMu48GXrdFyKc6bj+HCWEs/egRZZ9iGN/B1yrNNO1QVsQ3QL2sB+FAUJ
 6qy08xvMkyieF/4XJV+c1SXGJ2UbwF09uUeHL3rmoZ2IppCrp1EtKR9Ay Q==;
X-CSE-ConnectionGUID: JjTJyn5cRoydE3ZrWHSEwQ==
X-CSE-MsgGUID: Hh3tpCfyT1+ZxRmQQfVkdA==
X-IronPort-AV: E=McAfee;i="6700,10204,11134"; a="29817459"
X-IronPort-AV: E=Sophos;i="6.09,210,1716274800"; d="scan'208";a="29817459"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Jul 2024 06:10:05 -0700
X-CSE-ConnectionGUID: 8FaAyoqHTGO0P141cFdqJA==
X-CSE-MsgGUID: l8YkwScBQZe1Ak0M5qd/gA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,210,1716274800"; d="scan'208";a="54544025"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
 by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 15 Jul 2024 06:10:04 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 15 Jul 2024 06:10:03 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 15 Jul 2024 06:10:02 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 15 Jul 2024 06:10:02 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 15 Jul 2024 06:10:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F6v47op8jnUNm9tYojfoF3BYIhifrgkgtHcNR81vcV7+a9m6N6FJKdEZoez3IqXVv1V1/P9X4WH5ck9Qa91EDPQh+TtqkptBl1Is+YsC3d6uCL9RRdzYy3BgcT8fIiabNybXU3rCCpfNBwHmZ8O3WdFm6j6RMjP+pwr52TFIi4K9oykvzc3k0sK9/LO4zjblF6gGKCmGIMnd7kV5hjWJyfdn6XqTCq7xtksj0vskO1V6X8YMQUR04X7fWwRMy5vwNxz7EioPgvnHs3rWhvgp2UnColIFh8KoKiLfYYCaIBm7GhJOX1dRsOOzma1QWmznxPwKrZPJ4/oi0NYVly8MeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mvJPPfZp6xDm8zd3FzlsNkJXf6wc8tpsnviIiwQz0gw=;
 b=NvtvZC5eg/DjIj93lNcNi6C2sJ0M27afQyR/zIom5fRDspXbdC0ZFHL/irI8/FO2gXPLrxe4kvyiL/QjZFgJqm3wt0ceAczlFsEVjl/hxaKP/21bYZeCHOU+bOgGGQNcP9U96aE6PWce4rCvB5+KQlu4/t2PqOWb99+stn8fMpRidQrhSGrVXM7EHg4+tA1piVF6LYoXErLE+0vogJfqkHKHeRzV8oabudoskZvAEV5P+0b6xtrYLTlpeqOap8kKKSQnTzsAEY44Abp4OAzGjH2JSGY80nRmq11zY/MWmqQb8WKo15LboFKj9UpemEMvW9R+WYbCpyogbQJ54SEc+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB5941.namprd11.prod.outlook.com (2603:10b6:510:13d::20)
 by SJ1PR11MB6273.namprd11.prod.outlook.com (2603:10b6:a03:458::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29; Mon, 15 Jul
 2024 13:09:59 +0000
Received: from PH7PR11MB5941.namprd11.prod.outlook.com
 ([fe80::2750:7e63:952:7f1d]) by PH7PR11MB5941.namprd11.prod.outlook.com
 ([fe80::2750:7e63:952:7f1d%6]) with mapi id 15.20.7762.025; Mon, 15 Jul 2024
 13:09:59 +0000
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
Thread-Index: AQHa09y4Qu9AOd5eTECcwvlNYUC9ULHyIXCAgAVUt7CAAEXVgIAAAUtw
Date: Mon, 15 Jul 2024 13:09:59 +0000
Message-ID: <PH7PR11MB5941A453AC1A4B3A387475A7A3A12@PH7PR11MB5941.namprd11.prod.outlook.com>
References: <20240711215244.19237-1-yichen.wang@bytedance.com>
 <20240711184131-mutt-send-email-mst@kernel.org>
 <PH7PR11MB594105D464F3A4C2C25F94FEA3A12@PH7PR11MB5941.namprd11.prod.outlook.com>
 <20240715081857-mutt-send-email-mst@kernel.org>
In-Reply-To: <20240715081857-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB5941:EE_|SJ1PR11MB6273:EE_
x-ms-office365-filtering-correlation-id: 2efde29c-1114-4417-8374-08dca4cf6e65
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|7416014|38070700018; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?nUEezYV8AxNVrwmKFmnqxEAZ3pVbnYsi+csMUhrMDfGG8itq/ygNFpYsYP?=
 =?iso-8859-1?Q?hHntROLtNChUpGGGF5V3jefwINtXaNeOITpdEoVwmkknAfGek0RsyKzPq/?=
 =?iso-8859-1?Q?L7NaHH0QPsJK622NdA6xjdgJIEuhtwRUzkUt3olE6/HvE9S9tLycWIGqAM?=
 =?iso-8859-1?Q?VbDcwWVegA0cfa1Sx+dQpWsyu24QlKQ/h7TZvfy5iM2KRakSLJcRoHKTb0?=
 =?iso-8859-1?Q?ImND5G6tZS7m5zIazlkweY1cyx1v1nezEtDJG8FlxK6VQAjhzVB9/Zy3Ch?=
 =?iso-8859-1?Q?KL6+n6wQGJ/ZPwz+gEQIsQvPRs8aawfVjHwlCwyLYvYhanVRHr8g4wrRFZ?=
 =?iso-8859-1?Q?a1I7EMjgXggWgqBwnTBIYqJjieajZ4Lxa7xBDLaVxOfoogq6n1zevv1Iq0?=
 =?iso-8859-1?Q?HLejTku0vApLB5CkMA78fNLfNGadnQ5vyuESdG7OLJamTQz32Xvk/g7X3v?=
 =?iso-8859-1?Q?Z8aIe8tnkWQCwUSxdwUuZQazx2YrXmhjI/m5Op6m/+Datakjdo9+TZj8F8?=
 =?iso-8859-1?Q?qQKskEa7pGZQeJKu8LfSvzgK1XAstUuUnBFneI17S3EAVwP1KLRrl3rI7U?=
 =?iso-8859-1?Q?UN44Fk2k09+z25+jg6PQCBKOY8xIoeOM2b2qkP4xAyICaHp903sRhwjNXd?=
 =?iso-8859-1?Q?soVe1Z0g2yfUGo2XkpnqHGvm/2Pyy4OIMxJ+rRQlGivrcZa9k9VLBVp1y7?=
 =?iso-8859-1?Q?+izJRMaY+kmYdgB6fvmiFbEMJLqoA+CKpm1/5+2wAkel1cJ+K/JaVrX88I?=
 =?iso-8859-1?Q?4rGL/AqBdilX8BzYeM6oTz6oiiLPbYzK+En3oiDMB/sBtlFij9+ItYIsKS?=
 =?iso-8859-1?Q?pqJT4UU/9lX4Oy0c+tajHTfoJW5rxWGiQRyejJLrqBVbSpt8r92I8sYLPo?=
 =?iso-8859-1?Q?y+XEGkJrGbuqz6ZHfehnJ09R8t4NDahUbVIanch5He4ssqXuStI3OgY/Ur?=
 =?iso-8859-1?Q?Wq9Iig2KGEX795eqYQgkTLjhb6KGVs26sinoyCbhOgQ7u7grCAeGqoleAX?=
 =?iso-8859-1?Q?6tzwn0m3z5YYyMtZJGgphe0qfznmcf6vihxaB7vd/zIqtXOcAhEQjdjDie?=
 =?iso-8859-1?Q?7JAcD6m8tqPrZa8ltJcmrD8a3MhvHP+R3r8+TNDnuegh/rFBouFoXnFXpd?=
 =?iso-8859-1?Q?lkH04nDnWXlqbP45xmWn56+SY9Sh81aq+ZzXORxUBo9IkTcSx/26AU3NXl?=
 =?iso-8859-1?Q?HK750Qg6GI1rvq7XLmzDA418pU4X5+xN5b/A9b0TXZPDDm92VvUDquE1Gl?=
 =?iso-8859-1?Q?fH/QckWfLyFIszx3OhlHeLI+eOC7rowsYlwzoKeDjdUhE9YmNG2fhhyG/D?=
 =?iso-8859-1?Q?/DHPRNTUOx/2hBJq72fr8EPTWFbDUBLJNVNtUZMP8bWmgU+SSQhJb1aEDc?=
 =?iso-8859-1?Q?YqluwU61S0S8B5LW/1b6BUjCdIBqcs4x8CckIAz7TNS2MHgooK0eQ=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR11MB5941.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7416014)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?/Qf9Txvu6IuANjO0jAcj9gMdgVULaTEEqVNmZT+jrFJkQY1wE5l/MZWrR6?=
 =?iso-8859-1?Q?acTPNzK5RsDXFusSYvFB+em6+R1N7JN5RcMbNmq8wJ+4QkKVBEzu//lOAa?=
 =?iso-8859-1?Q?h1dsoonY8jMM8/H6uMBMjpWK69qvDRYWnJE+2+p0sPDPMERKdLquWL/cy9?=
 =?iso-8859-1?Q?uv6MNuZ6dcsJE4DJdlszZLT8ZgwVFH0ut501HDcGe2QEXTw3/JVMmsofP/?=
 =?iso-8859-1?Q?68H1rzIfCPjZzTVjugiBK7nVLd2XfUIWS/jq2moXu9q1YQ81TWJ7SfBLNL?=
 =?iso-8859-1?Q?1JrwYkiQ6tt1sUWXE/VGiFfXgI9bvNmj/LOSPj2lvI18MUpPwJ9/qkLZvL?=
 =?iso-8859-1?Q?AhNaZkMulmLmLC7NN5buFvuR49j7Df7fgiDcyXmyNNvdDEBvdkzVsdQYJe?=
 =?iso-8859-1?Q?CoNdhgUHEyct+PF1/psqHFdGVjLuDju5BOwXVJiesDdZdUn28jbF9D2Vxf?=
 =?iso-8859-1?Q?9hw2Oovdhtyf3OKWZB++pPoCszAoKwqhg4um8msJhHebYVfg0b24jkqJDT?=
 =?iso-8859-1?Q?0UYywo4WBLT1QPrgOyQCFalstndrbvPXvoFDoQt6nU6d4aUjVkXm/lJeu/?=
 =?iso-8859-1?Q?NyJqly8V/WqT8GY7GGRvbDj47LbPaKzNKANL37GBipLKaa9TZWUC9ROMjX?=
 =?iso-8859-1?Q?m/UKadH+eQOCmok5zYWLN0jxDVuq1tNaSWhxIqIXA8hGmdGxrEr/BSy3Fe?=
 =?iso-8859-1?Q?/cMCbikx7MC6UKc9GMK6LHueJEEDUocaUKdI22yu1Zjf2qI8v3WFdO6Kbg?=
 =?iso-8859-1?Q?711M+jIuF2DVfeAcVjEs3GjXoXOAdkNIzZKPuIYrfprm0QIIApmwV7/XPt?=
 =?iso-8859-1?Q?4CtVbpOiG7WQUewJcUVBODc6/rlWylnx/3qkEx2fq2rfGyzyzTU8lhqRU4?=
 =?iso-8859-1?Q?/OjQccOzq64dVpRi56alTMOGw8LqyDACh2kuQEsaoObXEii1aXe95941em?=
 =?iso-8859-1?Q?GzG9Ui57qT9y1ubnXzwgET3qQZ103l7jQgG1arYturLwsZKTr9zUNTz9Gd?=
 =?iso-8859-1?Q?O+/nmBb4/6F72sy9ZqmjsaMznQ9lts8KQ0zvL6ehj0PkJsZPSOoGTZdtYI?=
 =?iso-8859-1?Q?aHNwHelERZtLzKoqQDEiET5YoZ104QYenY5M77StH7egMe5X7o0fw6S8T1?=
 =?iso-8859-1?Q?XZ1p59+Ezc1vFFQh1ZGREICbLwWcZ6iIuBRCmH4/wp5EZpC/HsL521d+5z?=
 =?iso-8859-1?Q?T/Y1xi+er2dfaBvMVQvy3BvWAYyUmdShN6wmHkzcE6nNpxN0WJANFikdmN?=
 =?iso-8859-1?Q?VCXGJ6bJrNbxbPrKnGMYlZariNYl5Mh4wFdhHoeDJGwdRWq8D2zceg2DCU?=
 =?iso-8859-1?Q?ZqzfsTnJ/UrPb8VCCpNy98dcnofxTpP5FYG7TLe7HD/ipzWWqVg7PpIESn?=
 =?iso-8859-1?Q?jNHMrGtquEt1ODsoK4o4TOVl1JHU7Is2oDLUrnUzx9q8LAKSCRpWOL3gcd?=
 =?iso-8859-1?Q?Bzp4vhmz1V9WqIU1NHlQyyYWwwLDjYLwly+N7mK1bVsNFC4FeU3pcmzLmO?=
 =?iso-8859-1?Q?ts5Zrz+meMbGm61rpRZWX1Zld4SGaO1mctwS7JOj93vp3VjRKl7JhV5p43?=
 =?iso-8859-1?Q?RVOmE+lOy8Mo/I8DUE3Ti2c5HNfUHzJvHjoBTrRTI+uHkkMTUmZXH6OY1Y?=
 =?iso-8859-1?Q?gwPT9GYZ7xUUz9wSZRVTMkTjIeDuzUiPKZ?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5941.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2efde29c-1114-4417-8374-08dca4cf6e65
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jul 2024 13:09:59.6899 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fVInZIu36qwkw/0V6kcERRkzPXB7GcLswFF/8Cvi5FQXqzDhy+j8HMzmMaUMh8GyXT77VtLlX6slYXvM1LcKqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR11MB6273
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.12; envelope-from=yuan1.liu@intel.com;
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
> Sent: Monday, July 15, 2024 8:24 PM
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
> On Mon, Jul 15, 2024 at 08:29:03AM +0000, Liu, Yuan1 wrote:
> > > -----Original Message-----
> > > From: Michael S. Tsirkin <mst@redhat.com>
> > > Sent: Friday, July 12, 2024 6:49 AM
> > > To: Wang, Yichen <yichen.wang@bytedance.com>
> > > Cc: Paolo Bonzini <pbonzini@redhat.com>; Marc-Andr=E9 Lureau
> > > <marcandre.lureau@redhat.com>; Daniel P. Berrang=E9
> <berrange@redhat.com>;
> > > Thomas Huth <thuth@redhat.com>; Philippe Mathieu-Daud=E9
> > > <philmd@linaro.org>; Peter Xu <peterx@redhat.com>; Fabiano Rosas
> > > <farosas@suse.de>; Eric Blake <eblake@redhat.com>; Markus Armbruster
> > > <armbru@redhat.com>; Cornelia Huck <cohuck@redhat.com>; qemu-
> > > devel@nongnu.org; Hao Xiang <hao.xiang@linux.dev>; Liu, Yuan1
> > > <yuan1.liu@intel.com>; Kumar, Shivam <shivam.kumar1@nutanix.com>; Ho-
> Ren
> > > (Jack) Chuang <horenchuang@bytedance.com>
> > > Subject: Re: [PATCH v5 00/13] WIP: Use Intel DSA accelerator to
> offload
> > > zero page checking in multifd live migration.
> > >
> > > On Thu, Jul 11, 2024 at 02:52:35PM -0700, Yichen Wang wrote:
> > > > * Performance:
> > > >
> > > > We use two Intel 4th generation Xeon servers for testing.
> > > >
> > > > Architecture:        x86_64
> > > > CPU(s):              192
> > > > Thread(s) per core:  2
> > > > Core(s) per socket:  48
> > > > Socket(s):           2
> > > > NUMA node(s):        2
> > > > Vendor ID:           GenuineIntel
> > > > CPU family:          6
> > > > Model:               143
> > > > Model name:          Intel(R) Xeon(R) Platinum 8457C
> > > > Stepping:            8
> > > > CPU MHz:             2538.624
> > > > CPU max MHz:         3800.0000
> > > > CPU min MHz:         800.0000
> > > >
> > > > We perform multifd live migration with below setup:
> > > > 1. VM has 100GB memory.
> > > > 2. Use the new migration option multifd-set-normal-page-ratio to
> control
> > > the total
> > > > size of the payload sent over the network.
> > > > 3. Use 8 multifd channels.
> > > > 4. Use tcp for live migration.
> > > > 4. Use CPU to perform zero page checking as the baseline.
> > > > 5. Use one DSA device to offload zero page checking to compare with
> the
> > > baseline.
> > > > 6. Use "perf sched record" and "perf sched timehist" to analyze CPU
> > > usage.
> > > >
> > > > A) Scenario 1: 50% (50GB) normal pages on an 100GB vm.
> > > >
> > > > 	CPU usage
> > > >
> > > > 	|---------------|---------------|---------------|-------------
> --|
> > > > 	|		|comm		|runtime(msec)	|totaltime(msec)|
> > > > 	|---------------|---------------|---------------|-------------
> --|
> > > > 	|Baseline	|live_migration	|5657.58	|		|
> > > > 	|		|multifdsend_0	|3931.563	|		|
> > > > 	|		|multifdsend_1	|4405.273	|		|
> > > > 	|		|multifdsend_2	|3941.968	|		|
> > > > 	|		|multifdsend_3	|5032.975	|		|
> > > > 	|		|multifdsend_4	|4533.865	|		|
> > > > 	|		|multifdsend_5	|4530.461	|		|
> > > > 	|		|multifdsend_6	|5171.916	|		|
> > > > 	|		|multifdsend_7	|4722.769	|41922		|
> > > > 	|---------------|---------------|---------------|-------------
> --|
> > > > 	|DSA		|live_migration	|6129.168	|		|
> > > > 	|		|multifdsend_0	|2954.717	|		|
> > > > 	|		|multifdsend_1	|2766.359	|		|
> > > > 	|		|multifdsend_2	|2853.519	|		|
> > > > 	|		|multifdsend_3	|2740.717	|		|
> > > > 	|		|multifdsend_4	|2824.169	|		|
> > > > 	|		|multifdsend_5	|2966.908	|		|
> > > > 	|		|multifdsend_6	|2611.137	|		|
> > > > 	|		|multifdsend_7	|3114.732	|		|
> > > > 	|		|dsa_completion	|3612.564	|32568		|
> > > > 	|---------------|---------------|---------------|-------------
> --|
> > > >
> > > > Baseline total runtime is calculated by adding up all multifdsend_X
> > > > and live_migration threads runtime. DSA offloading total runtime is
> > > > calculated by adding up all multifdsend_X, live_migration and
> > > > dsa_completion threads runtime. 41922 msec VS 32568 msec runtime an=
d
> > > > that is 23% total CPU usage savings.
> > >
> > >
> > > Here the DSA was mostly idle.
> > >
> > > Sounds good but a question: what if several qemu instances are
> > > migrated in parallel?
> > >
> > > Some accelerators tend to basically stall if several tasks
> > > are trying to use them at the same time.
> > >
> > > Where is the boundary here?
> >
> > A DSA device can be assigned to multiple Qemu instances.
> > The DSA resource used by each process is called a work queue, each DSA
> > device can support up to 8 work queues and work queues are classified
> into
> > dedicated queues and shared queues.
> >
> > A dedicated queue can only serve one process. Theoretically, there is n=
o
> limit
> > on the number of processes in a shared queue, it is based on enqcmd +
> SVM technology.
> >
> > https://www.kernel.org/doc/html/v5.17/x86/sva.html
>=20
> This server has 200 CPUs which can thinkably migrate around 100 single
> cpu qemu instances with no issue. What happens if you do this with DSA?

First, the DSA work queue needs to be configured in shared mode, and one
queue is enough.=20

The maximum depth of the work queue of the DSA hardware is 128, which means
that the number of zero-page detection tasks submitted cannot exceed 128,
otherwise, enqcmd will return an error until the work queue is available ag=
ain

100 Qemu instances need to be migrated concurrently, I don't have any data =
on
this yet, I think the 100 zero-page detection tasks can be successfully sub=
mitted
to the DSA hardware work queue, but the throughput of DSA's zero-page detec=
tion also
needs to be considered. Once the DSA maximum throughput is reached, the wor=
k queue
may be filled up quickly, this will cause some Qemu instances to be tempora=
rily unable
to submit new tasks to DSA. This is likely to happen in the first round of =
migration
memory iteration.

> > > --
> > > MST


