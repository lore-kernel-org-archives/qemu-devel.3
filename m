Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8340FC3DA59
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2024 06:16:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sVmKd-0007I6-QP; Mon, 22 Jul 2024 02:15:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sVmKb-0007GW-Tz
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 02:15:33 -0400
Received: from mgamail.intel.com ([198.175.65.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sVmKZ-0006C6-F0
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 02:15:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1721628932; x=1753164932;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=qT0K1+qC98548L+mgB+oQauMKrsW0qChhDiqK6kD0gg=;
 b=dUeLt5KWM2fJngWKMM4uJYCuyY7en+wJoTcsQ7eF26tu9DHHP0yMRFS5
 FikB0WazHwiYPMpv+n7PxbZdujuhLPsDC3RUccbQvQy3Uj2so9b45H7i0
 SBSW5jJpLf8ofXbslAPHNpeaZagH4yhcJBYrOBW9HhoXivfZ+fzoTPytR
 7m4BkTdKbD1Tu8UZZbTmEvLqfDj9O6jNWpy7WQ5ycnmt5ISFP04DDDI/3
 WuYXXNJkNwnvWFKvz+Noct1cFnl/LTH5JoK6S+9Twg6PoesXk3JWuZZdF
 q5NSc91La1iFurcCCtGdkc4a28oUeF3m6usGQ6Nyqx4cX8+gScLQXV/p6 A==;
X-CSE-ConnectionGUID: THt6soDISCekXcxKgfzxZg==
X-CSE-MsgGUID: EMOi/2CjRCGK74fTgUaZ/g==
X-IronPort-AV: E=McAfee;i="6700,10204,11140"; a="30564989"
X-IronPort-AV: E=Sophos;i="6.09,227,1716274800"; d="scan'208";a="30564989"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Jul 2024 23:15:29 -0700
X-CSE-ConnectionGUID: 7t5//QHLQ2emAZYqDvmVxQ==
X-CSE-MsgGUID: gAqV/UDcTGOQ12QAEnWzlw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,227,1716274800"; d="scan'208";a="82408037"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
 by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 21 Jul 2024 23:15:28 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 21 Jul 2024 23:15:27 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 21 Jul 2024 23:15:27 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Sun, 21 Jul 2024 23:15:27 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sun, 21 Jul 2024 23:15:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=si6KDQaX8ACE595hl8A9Ci54AQYGJbUMl1d07rx4mmcbpsum0bwlkw7DnR6WvMnbZmobD0bQY63fquS1pRZcMmfSoJyQmu44GS722jQrRrfQcCK/vJ9UHxPwl8rTGUI4RawllutPh93f+6B4xWfvF3lqxM8OyAtppSOgEu7sj2Nn+wop4dvwaIBH8BUKzPmpfWBDMvQRkVn8E7e3iHb2fzC1LdM3ZAMaPIk1fAPDO8NkvUqx1BFmqFcvFm3miF8mScGr1HWD7Rnp+1FZpYubamFgb7YQzqF6FpG2wR92uoFzs3S1FH6Gt2xBW6wWnLXoXWGQnh6OsZ9bDm3lbIy6Uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z4dkVMcxRMm7B9Pv6XIsLBgW7XjHoa0tFryCBg3cMJM=;
 b=a+7S0J1f1bCof0uxBQ2P0wa7D7oW/aPIh2MYm7ol6tKZQz45u7hXExVatCtiPii5N52zUMH5hKuM7mq8//9dVPPkVW4Et1BO4Hy+3sKNXkA3gfRMN4slciaV8rHGhMmxBK7tmlFMfQAFO+kEQy/029MLegEVZ3nQC4ILxOqfjC3AaCuHUPCvV0UPVey0fOWXhsZON3b2+KWqlg9QhkA49ekVB+EZU5lv/dv8GvF548eVCtZjRZJjrklwBX3/iIibcsPO7qBXfpmUVqMoaORQkh4iAlbNf1zVeYVzJsR60HQdacoH3828rOpGySw2hl7It1A/amtQkpTqcbxTCkc6Pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by PH7PR11MB6796.namprd11.prod.outlook.com (2603:10b6:510:1ba::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.14; Mon, 22 Jul
 2024 06:15:25 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091%7]) with mapi id 15.20.7784.016; Mon, 22 Jul 2024
 06:15:25 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: Joao Martins <joao.m.martins@oracle.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "Liu, Yi L" <yi.l.liu@intel.com>, Eric Auger <eric.auger@redhat.com>,
 "Alex Williamson" <alex.williamson@redhat.com>, Cedric Le Goater
 <clg@redhat.com>, Jason Gunthorpe <jgg@nvidia.com>, Avihai Horon
 <avihaih@nvidia.com>
Subject: RE: [PATCH v5 10/13] vfio/iommufd: Implement
 VFIOIOMMUClass::set_dirty_tracking support
Thread-Topic: [PATCH v5 10/13] vfio/iommufd: Implement
 VFIOIOMMUClass::set_dirty_tracking support
Thread-Index: AQHa2dQCrgwyq1cTTEmOmn20R8IS8LICSSdw
Date: Mon, 22 Jul 2024 06:15:25 +0000
Message-ID: <SJ0PR11MB6744FF7C32EC72E6E07C885492A82@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20240719120501.81279-1-joao.m.martins@oracle.com>
 <20240719120501.81279-11-joao.m.martins@oracle.com>
In-Reply-To: <20240719120501.81279-11-joao.m.martins@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|PH7PR11MB6796:EE_
x-ms-office365-filtering-correlation-id: 020f680a-2171-48c7-ab62-08dcaa15acec
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?lic8n5BQSTGAyVG1Mm8mE4zifUYkcc0x/y8rvZzRbFyZqXcGeSBEPct8ejqs?=
 =?us-ascii?Q?mBzf0rDbS3FDKRnJhtezQH4nfWfmGlWj6dkScqWB59TKnZC9ArWwcWVyMEgZ?=
 =?us-ascii?Q?oVDQfgLrAKwvcDLOZCTkdX+gpvJIrKJoz+C2FLrrBK3d0rShhq6NS4gzAkCf?=
 =?us-ascii?Q?W5N6mSZNASppC2zTsn4yPb28dWOQDYGx1A2eOkb0f12MxfbRCANdn1WnpFHK?=
 =?us-ascii?Q?DxJ4dqxQZyWndQhbtLOELz1buIrPy5DdB6UpA1r3rAYg+qHIesuDJk4lOGFY?=
 =?us-ascii?Q?2utLm2lU57faYssWiSXbWkrtPCRmgV6ESSnwqe1dfYIsqXJurH+27ksGpeLV?=
 =?us-ascii?Q?RIzNxEF/jT0Q7iGpMbqk9UzoG3nrfWdZbUoQVh67RZuqX7UFhPlIDiI5b91f?=
 =?us-ascii?Q?cun13PM4l+b2FATcminMjrcLr5NQhwELe/XftaoBZP5zN/Mf92O0n/gVHP0A?=
 =?us-ascii?Q?M02NlwoSYsqK5Ra+vwR1pmKXH7b0B+6eE3KprG8QxoRVpQcIW1DkIBkrqggu?=
 =?us-ascii?Q?3eDB81o6UsqizcYQLyOQT4+ySggBAoSN4RspWv/tNwMQryHPWjZxrPgerdsk?=
 =?us-ascii?Q?FRmkWOUr7XbxIHY2CYEjuK1OSo2+zkFaNMk4XF5nh5x407ne3TgrtPhXGTtB?=
 =?us-ascii?Q?PWBIGUov75Z3GSQkancCFtD6HluyX7w4KwLXB8ukJTGqFJl6xYxTFjJ70zE2?=
 =?us-ascii?Q?Xbr+iLmdPAt8KaBoGuq799FEs8YD027mNPaYpvh5uYjJZjfwFS3tk28buQ5G?=
 =?us-ascii?Q?Oj2UfCHeDdPRF1TnLQyIh2e9Tuh92u/TN1UkJepKFLhHqC769CMbKcNSVD8v?=
 =?us-ascii?Q?X7N8//B8OH7bLiZqMu4QI8NO4IlxxD/Us8o5s++pSRmIC05GDHGI48Uh7tea?=
 =?us-ascii?Q?Fuu6EN9/JlKdo5sltDfuyzIBToyGl1/TNMRn/VJ7FWunA8IwMScH+M9OwSvY?=
 =?us-ascii?Q?AGcqSxMtMATlDRVWLWgWpNBN4PYn7tvRu1jV092CenjkfT7+0pBmsNecGg5c?=
 =?us-ascii?Q?SB7B+2Av1nAOytIAPh+Gu4PT+8gzxczCG2XHdqyV6QIDvYgNXLCA7F+zHFOe?=
 =?us-ascii?Q?LFrSeCuzSdSlDDTC8V1ko5b/DrO/BwzTfLfTBv0wKO1XZPSN9b7s8n+R8+43?=
 =?us-ascii?Q?vswnLK+CFdqFVqFAzP0yWC+MeF3JsMXYJQnulIP3Ry8bJmIYUGQQ2DepCgnG?=
 =?us-ascii?Q?QTE7meF9riqyHeFEbqeOOANN1/jRDX5JwLIn5cqCUAIZD4l91YrGMzPiUgW/?=
 =?us-ascii?Q?eq9T/2oDmyebL5UHhH5PdLCQQ4Ag8UJOz4e5FDPEe4yO/CAUvZOV2hD+OV/M?=
 =?us-ascii?Q?6QIy3DsLxz1JGlKmhH8CQDO6OfSCYZPJyLcW4NHhRqbD0MUoZolGGGeHZGaw?=
 =?us-ascii?Q?ShCXFo1ZbhLyLiA3QxGfWCxqEVNdG1tD3vKPuzdB9PgTN3uzmg=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?6cBSxrk5kDEVX5vcqFpE7pPe8+cqETHFpH+kfYoz9AtrtuAEkeYFaGF9zdXD?=
 =?us-ascii?Q?fek0N9NW+PweuUpR2tluevVJbjIxsj+N5umE/+sx/WbM4uaKxm+Qz+R4Gbb5?=
 =?us-ascii?Q?wEVBqVo0o5yR+Q0+0U282TNuj4PxTHdzxb3uOkIHg4YWtxCEjrL6rnz9Rs6U?=
 =?us-ascii?Q?Vi3aeRcOTSpGJ6AqK2aGEw7MbbZYdBAjAim1FcweD46BaaWsSVda6DS+RVXX?=
 =?us-ascii?Q?Ris/RaoUpYn9KxllYHcBevsPo6mDcVfGH8Z3hPBYrSNTV3Q6DGJ7z4B/LOhp?=
 =?us-ascii?Q?CuRcWBm5PJJ7rxk7dNbr8pZ4I4PnY4KsuP3m/rrN3Y/gVe7cQ8J7MGRS50i2?=
 =?us-ascii?Q?7MmMX1dL4nXcnsM09JJlar0LAd/6N14VyQpF2saUaMalQz5xVSkh6z9jhV0s?=
 =?us-ascii?Q?qe+2p2qfKU0PwkPjJi6P5Td0JRoXPFKFkRUPBEMO6pX5frUCpkhXfUL7ljfz?=
 =?us-ascii?Q?fP/aNslEKpXkoeJJ3tKa5CK1KAz7sSdTwvqYsoIxB7gleHnDEXkIh9DAauyn?=
 =?us-ascii?Q?Km97/Mls8vpzqfzlh84hUoHw7l5alrtk69EOKLFm1CFOSDuO3hnqaH6e2CED?=
 =?us-ascii?Q?7yJ0csSOjRrai+ZgnwwXRB9kuFzmwXvArYeW/5JQlRsJqig8Yi2WeRdywPHT?=
 =?us-ascii?Q?tyIuT4VwewM8CjrvYZ9YLRL5yjtXTY7rNDRYILAqsg39B+CJHEVG4PGmHmUn?=
 =?us-ascii?Q?1FKaBWoUt0Gylhnp0O9rDDm85jUFZftSL0t/tvf1EcjcqsMN31PLBfgxj+ZM?=
 =?us-ascii?Q?7bUWwBd1HCD2wOPOOvzVYoPJ4Ti6PLK3uw4lWqnwVFIbYbZ1ANP3N7p40cE3?=
 =?us-ascii?Q?joUtflbFmj8RQ+uG8Lau3quxFzGHxM3ecWNdTeTa3YFBNkg2Q4dqNHzDjMhe?=
 =?us-ascii?Q?gXuWSmZ0E0aGbxHTqejYQ1hPcbZ+24lT2qi+cim/uob/5ulVDbXE26YP82cs?=
 =?us-ascii?Q?LSvpqT+zT+pNZ7/zcVrTGgRC7OK95jVlT0XDMtCH6RQITL4L7z0kWzXhNq9f?=
 =?us-ascii?Q?yzZc2Y2ISaMZdyMTO5ocIpYsaue+gKDtntxHtQffyeSpGEWDf+CapRRjMjMN?=
 =?us-ascii?Q?8ZXDamdpn0c6XX+WUcfqO9D/+Z7eaoj0UkJe+ACAyo5YNlaNWSjtiz6Zyy0b?=
 =?us-ascii?Q?761qJWIGtGmjSYSq7UZ/ZeeRUn9VZFZqVxrPfKiwVTK3pxBEQdNKzeqzMznL?=
 =?us-ascii?Q?Dhly12atiCigqo9PRQf0dRgApiWAf4NFY+yBGjht/EI/wXD1GD1M1liopIne?=
 =?us-ascii?Q?z7KS1RAgEYG3cX+spH28yBw3KNCZLIMWA9BOAvLStxYOR0kG+ws15hvWM4jN?=
 =?us-ascii?Q?OfZvEvN22GQqi1Zgjx00Dp1CirXOwWysZlkATd6M0IIw3nrOZMiPn1dTJVpr?=
 =?us-ascii?Q?mQruN20uUr2VxR7HE5a24ZSVxEscNSgnkT1sc/hy9HepgAZkBugXMqCTO1XW?=
 =?us-ascii?Q?L+OHlc90jrZzsWPfl//uZJVu2uUs23TRdgCYQvppeMD6MpFw4+iCIA/LDs8d?=
 =?us-ascii?Q?aKTECGXKInm3p1xhYYEbOSDcqhKb3Ya9hVhvYEXqCSO/7f/KxoSVna9yZqys?=
 =?us-ascii?Q?ZI6kgKD8goQxU0z+wIp/upRW2w27t2qP3zE1aVoc?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 020f680a-2171-48c7-ab62-08dcaa15acec
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jul 2024 06:15:25.1929 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NqK49pdqE+VXVQJsBLvVXuTPWIkyu/iwbvFThgdVukw8IoSiOGYwvBJhuMJk0yLaxfeXdybaXk7wrjNKCR8komCckg8AOCUw00iQjmHzKg0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6796
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.12;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
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



>-----Original Message-----
>From: Joao Martins <joao.m.martins@oracle.com>
>Subject: [PATCH v5 10/13] vfio/iommufd: Implement
>VFIOIOMMUClass::set_dirty_tracking support
>
>ioctl(iommufd, IOMMU_HWPT_SET_DIRTY_TRACKING, arg) is the UAPI that
>enables or disables dirty page tracking. The ioctl is used if the hwpt
>has been created with dirty tracking supported domain (stored in
>hwpt::flags) and it is called on the whole list of iommu domains.
>
>Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
>---
> include/sysemu/iommufd.h |  2 ++
> backends/iommufd.c       | 23 +++++++++++++++++++++++
> hw/vfio/iommufd.c        | 32 ++++++++++++++++++++++++++++++++
> backends/trace-events    |  1 +
> 4 files changed, 58 insertions(+)
>
>diff --git a/include/sysemu/iommufd.h b/include/sysemu/iommufd.h
>index e917e7591d05..6fb412f61144 100644
>--- a/include/sysemu/iommufd.h
>+++ b/include/sysemu/iommufd.h
>@@ -55,6 +55,8 @@ bool
>iommufd_backend_alloc_hwpt(IOMMUFDBackend *be, uint32_t dev_id,
>                                 uint32_t data_type, uint32_t data_len,
>                                 void *data_ptr, uint32_t *out_hwpt,
>                                 Error **errp);
>+bool iommufd_backend_set_dirty_tracking(IOMMUFDBackend *be,
>uint32_t hwpt_id,
>+                                        bool start, Error **errp);
>
> #define TYPE_HOST_IOMMU_DEVICE_IOMMUFD
>TYPE_HOST_IOMMU_DEVICE "-iommufd"
> #endif
>diff --git a/backends/iommufd.c b/backends/iommufd.c
>index 58032e588f49..1ae4751a1b2c 100644
>--- a/backends/iommufd.c
>+++ b/backends/iommufd.c
>@@ -239,6 +239,29 @@ bool
>iommufd_backend_alloc_hwpt(IOMMUFDBackend *be, uint32_t dev_id,
>     return true;
> }
>
>+bool iommufd_backend_set_dirty_tracking(IOMMUFDBackend *be,
>+                                        uint32_t hwpt_id, bool start,
>+                                        Error **errp)
>+{
>+    int ret;
>+    struct iommu_hwpt_set_dirty_tracking set_dirty =3D {
>+            .size =3D sizeof(set_dirty),
>+            .hwpt_id =3D hwpt_id,
>+            .flags =3D start ? IOMMU_HWPT_DIRTY_TRACKING_ENABLE : 0,
>+    };
>+
>+    ret =3D ioctl(be->fd, IOMMU_HWPT_SET_DIRTY_TRACKING, &set_dirty);
>+    trace_iommufd_backend_set_dirty(be->fd, hwpt_id, start, ret ? errno :
>0);
>+    if (ret) {
>+        error_setg_errno(errp, errno,
>+                         "IOMMU_HWPT_SET_DIRTY_TRACKING(hwpt_id %u) faile=
d",
>+                         hwpt_id);
>+        return false;
>+    }
>+
>+    return true;
>+}
>+
> bool iommufd_backend_get_device_info(IOMMUFDBackend *be, uint32_t
>devid,
>                                      uint32_t *type, void *data, uint32_t=
 len,
>                                      uint64_t *caps, Error **errp)
>diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
>index 2e5c207bbca0..7137faaf4540 100644
>--- a/hw/vfio/iommufd.c
>+++ b/hw/vfio/iommufd.c
>@@ -115,6 +115,37 @@ static bool
>iommufd_hwpt_dirty_tracking(VFIOIOASHwpt *hwpt)
>     return hwpt && hwpt->hwpt_flags &
>IOMMU_HWPT_ALLOC_DIRTY_TRACKING;
> }
>
>+static int iommufd_set_dirty_page_tracking(const VFIOContainerBase
>*bcontainer,
>+                                           bool start, Error **errp)
>+{
>+    const VFIOIOMMUFDContainer *container =3D
>+        container_of(bcontainer, VFIOIOMMUFDContainer, bcontainer);
>+    VFIOIOASHwpt *hwpt;
>+
>+    QLIST_FOREACH(hwpt, &container->hwpt_list, next) {
>+        if (!iommufd_hwpt_dirty_tracking(hwpt)) {
>+            continue;
>+        }
>+
>+        if (!iommufd_backend_set_dirty_tracking(container->be,
>+                                                hwpt->hwpt_id, start, err=
p)) {
>+            goto err;
>+        }
>+    }
>+
>+    return 0;
>+
>+err:
>+    QLIST_FOREACH(hwpt, &container->hwpt_list, next) {
>+        if (!iommufd_hwpt_dirty_tracking(hwpt)) {
>+            continue;
>+        }
>+        iommufd_backend_set_dirty_tracking(container->be,
>+                                           hwpt->hwpt_id, !start, NULL);
>+    }

Not sure if deserved to optimize a bit with breaking out from the failing h=
wpt.

With or without that,

Reviewed-by: Zhenzhong Duan <zhenzhong.duan@intel.com>

Thanks
Zhenzhong

>+    return -EINVAL;
>+}
>+
> static int iommufd_cdev_getfd(const char *sysfs_path, Error **errp)
> {
>     ERRP_GUARD();
>@@ -724,6 +755,7 @@ static void
>vfio_iommu_iommufd_class_init(ObjectClass *klass, void *data)
>     vioc->attach_device =3D iommufd_cdev_attach;
>     vioc->detach_device =3D iommufd_cdev_detach;
>     vioc->pci_hot_reset =3D iommufd_cdev_pci_hot_reset;
>+    vioc->set_dirty_page_tracking =3D iommufd_set_dirty_page_tracking;
> };
>
> static bool hiod_iommufd_vfio_realize(HostIOMMUDevice *hiod, void
>*opaque,
>diff --git a/backends/trace-events b/backends/trace-events
>index 4d8ac02fe7d6..28aca3b859d4 100644
>--- a/backends/trace-events
>+++ b/backends/trace-events
>@@ -16,3 +16,4 @@ iommufd_backend_unmap_dma(int iommufd,
>uint32_t ioas, uint64_t iova, uint64_t si
> iommufd_backend_alloc_ioas(int iommufd, uint32_t ioas) " iommufd=3D%d
>ioas=3D%d"
> iommufd_backend_alloc_hwpt(int iommufd, uint32_t dev_id, uint32_t
>pt_id, uint32_t flags, uint32_t hwpt_type, uint32_t len, uint64_t data_ptr=
,
>uint32_t out_hwpt_id, int ret) " iommufd=3D%d dev_id=3D%u pt_id=3D%u
>flags=3D0x%x hwpt_type=3D%u len=3D%u data_ptr=3D0x%"PRIx64" out_hwpt=3D%u
>(%d)"
> iommufd_backend_free_id(int iommufd, uint32_t id, int ret) " iommufd=3D%d
>id=3D%d (%d)"
>+iommufd_backend_set_dirty(int iommufd, uint32_t hwpt_id, bool start,
>int ret) " iommufd=3D%d hwpt=3D%u enable=3D%d (%d)"
>--
>2.17.2


