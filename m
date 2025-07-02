Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9119C83F04
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 13:47:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWxnt-0007JK-EW; Wed, 02 Jul 2025 09:47:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uWxnd-0007Au-1C
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 09:46:58 -0400
Received: from mgamail.intel.com ([192.198.163.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uWxnY-0005RP-RS
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 09:46:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1751464013; x=1783000013;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=bxQeaMW6QGf5QVNnT3RxGI/0v4ys4jtrnLV+IwvK6hI=;
 b=eBL1w4LiqFKobY7tSjka6ivdnRbINCmSPsBqMWCnUkgiGpkFuUCG7b/6
 jvxP/95s2YDHwmbYjkuYxv0x1BZh5jf68RQb7Qid7yauHj7Ooa04f0ArP
 EQgDS4XcdpSVCnmsi9YZXoFcrneJWlAailjM+9qvgFra+oPhuAge8n3/J
 al5N0kWcrB40Lpm8nGA76j+Yf+zenwFjJSg2ZcjzGPB47gU1I//f0yEvO
 3IuWlprRxAEuST+84QQgxOZxqx0bIobKfqLR7vHSrUHzlSIt2Tn0F1bDh
 AqsNsppBuuUBLvJUOunAOxH/zFD3J3jsAsLXXoOzgfNoOpswXDVe8Zmr7 A==;
X-CSE-ConnectionGUID: YsNdk4NxS1GQ8I63MVxujQ==
X-CSE-MsgGUID: Dh93G4/KSpCnACu/BK4Qgw==
X-IronPort-AV: E=McAfee;i="6800,10657,11482"; a="53854016"
X-IronPort-AV: E=Sophos;i="6.16,281,1744095600"; d="scan'208";a="53854016"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Jul 2025 06:46:49 -0700
X-CSE-ConnectionGUID: e8GxPQxiT0iZfCAl2ugFGA==
X-CSE-MsgGUID: eK8P61wfRr6VSAZT5Fn8CA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,281,1744095600"; d="scan'208";a="153854444"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Jul 2025 06:46:49 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 2 Jul 2025 06:46:48 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Wed, 2 Jul 2025 06:46:48 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (40.107.244.41)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 2 Jul 2025 06:46:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sX9eedW8/hKHFxEv0KVv87zXJzEcrd8+L0JxPGxJ/mtVzISrZgoNvssYGaxr1eI9JxDbIaheXrthjDGIZlA8UNl4TxqqA6ELXbPrPjGyqxYMj0HabB5BT1Y3zAPdy9dQ7JYAEJvQxJTuw5YKGmPGRuCtKAne7bP4n0sbFmiBBOWabnUqyl6JDC5atksnYhnxxqvfyUwbL0WnuuXUMKGmyPy3UxsgfhTvvtL/Nr6fmUbFnWPGSNffCeKc4rnFYp/NM9lgm1GCVTly+OVxSj6lqDWw2W7RjJL409Qnpp4LkJ4LIJTEtz3NaHHq/0wnfIMifM+uX2kcmPJqYkPFXROWuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RtUoY7QNhtJt+DOFiBiR+erGcCqZ8uhlPjmZWTCsnG4=;
 b=hUDaxF2wWRnOmfii14EzLDgA7Zez0+sFYdXCiOwpqli1R8VUI5LTdSubyZM8jGOZYKTsbuYEN2v45yJb+AdiLZxEj0vD/bU58Zr/Yus/VxLPGvPZ+lZwfkXdGN8LOOHX0XfYoArda00SQaWPEesD90rCmDUEViiT0GKyELqgPZ6vVSAzLWaT/RhCBxrjQtDq6CMJ3wx6VKRJqaixPlgOTTaYg6e96uMyP3AcPGTovGKpH1KrhH/3N96sOe+LY0GQeMIbS2HoarTRBI7P0k069y1Bh4uvakXv9XB6G1lycRW7ygPa3Fflbu7lXZn2RqVbI9BHbzDk05eDd19Iwgs9Lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12)
 by DS7PR11MB6198.namprd11.prod.outlook.com (2603:10b6:8:9a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.34; Wed, 2 Jul
 2025 13:46:46 +0000
Received: from IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13]) by IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13%4]) with mapi id 15.20.8835.023; Wed, 2 Jul 2025
 13:46:46 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: Steven Sistare <steven.sistare@oracle.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: Alex Williamson <alex.williamson@redhat.com>, Cedric Le Goater
 <clg@redhat.com>, "Liu, Yi L" <yi.l.liu@intel.com>, Eric Auger
 <eric.auger@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, "Marcel
 Apfelbaum" <marcel.apfelbaum@gmail.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
Subject: RE: [PATCH V5 35/38] vfio/iommufd: change process
Thread-Topic: [PATCH V5 35/38] vfio/iommufd: change process
Thread-Index: AQHb2h4QhD64q5KK2EqqYvjZk7axZLQT1chQgAmeH4CAANPiwA==
Date: Wed, 2 Jul 2025 13:46:46 +0000
Message-ID: <IA3PR11MB913633D7D68CDB8BC68A98CA9240A@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <1749569991-25171-1-git-send-email-steven.sistare@oracle.com>
 <1749569991-25171-36-git-send-email-steven.sistare@oracle.com>
 <IA3PR11MB91368C5C5D98CD165A9F53DE927BA@IA3PR11MB9136.namprd11.prod.outlook.com>
 <9035951e-65af-472b-9120-9e7dee85eeed@oracle.com>
In-Reply-To: <9035951e-65af-472b-9120-9e7dee85eeed@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9136:EE_|DS7PR11MB6198:EE_
x-ms-office365-filtering-correlation-id: 57826405-5d9e-485c-7069-08ddb96ee31f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?eoRND+nypoY0jnUixVhZpoWtvwdJKRU5t+B5roEiUv4PojExn+NsXMmeFLME?=
 =?us-ascii?Q?LPNcXWFUsc2WOfHfzLUdQS20rmmjFOKDKIYzdSrbU3qK9AGQn/0kXpeBVA0f?=
 =?us-ascii?Q?zpf21lHTS2lDKBjdoOK4Vqs9DsK8xBuYN3YcUzI6f9TASFge1UUvsFdq2DIZ?=
 =?us-ascii?Q?ncHaMC57alAM5ZsJX9xQeySXLxHn0lE7qXpWxjXV4kCItkH9ssviJZpOCE6S?=
 =?us-ascii?Q?ItE9IJEuWIhfI3D32AgSRuPMLXP4v/24Ixv7V8BgohuisKIIrM63h1PfIRvA?=
 =?us-ascii?Q?BUOFEDUMVpESSu2a+O32gGJ/LnUZyKwcDchu4N4LTz/sv1MU4zfwkD1UVwQG?=
 =?us-ascii?Q?HSo/RldHdwN6/YnXHkCHS0a3aQWng+eCbb1k/cwpTjxhaIXiySD1auQXF9nY?=
 =?us-ascii?Q?uKeP4waaJuKv+6i5DX6GBi6cLZ44aJSph8MOFuWuGvVzJ5DqPIziYnsEi3an?=
 =?us-ascii?Q?eauuoipL9aZ/tzGUQFUsB6w0VXznKJITbdd3Ac1RHODBTB04Iym6M+h6e3BE?=
 =?us-ascii?Q?dNFHDvAQQJeTRtvrZKANv45zayMt6RxpjNo5ehi4FSRMSuwsrNI5Hdnw3lfK?=
 =?us-ascii?Q?ioShS/sgam4VpTmquNxbQ1+N5uQvzALSBGOY4mQd4c1Otuo0kKvgvsR3p1uB?=
 =?us-ascii?Q?Dus+UpgPybLT1loB2v8XLs3924xBYJK8TdOTerw2M3Av5mV9HDiW7qlgod4q?=
 =?us-ascii?Q?XAf8x17v2rJkByBWZhdLvTZKpoUNkI3tpUqr5ubNcjjxs+8OqXA4Bv0RFBce?=
 =?us-ascii?Q?JMth75bfteC5z2aWbojEgpuXczOd3wqmUh70+F7k4Z9vNzeZP+2wjNEFFFzw?=
 =?us-ascii?Q?oPTqUQ8zz17BF37zK+A1YHCeF580Wctb7UYC4lCoTrZhwrfAAsr02BNBweWb?=
 =?us-ascii?Q?BXOyJ4xRj2YjCKefTt77bUVY9is56mD3tv4P56QhHXY6yF4Jwjg7SnK/bg84?=
 =?us-ascii?Q?5I2mkc1JHUXyc4VVbyb9rbbeD8DQSEopm6hu8Hs1wU9aMvFu7LHvOQBx+EJ/?=
 =?us-ascii?Q?/dy39bYxGdzi5SKrZPZyQ1xmSHLoHwKn2bqh3Wlpp4y7jXvaGqKLemNcZcGo?=
 =?us-ascii?Q?VSMDF/zngJBPrbbc/nk3iJuG1FI8LL1o860ddq+VZmow7Ydt67R7lJeAMVsy?=
 =?us-ascii?Q?7UO2Hyi/rG7KXiievlAw0UpDZtizl6ahEKjwl64E7YYW9u/dRkINXV2jFrfw?=
 =?us-ascii?Q?UjrtJ2WWE+3mgAgQQVkOquC12NrKLMkT9wkRL8J1v6ISJCle/ExLCV166qWR?=
 =?us-ascii?Q?cxy4FxKAWBtNDwjF80phTk09dr7yM6t3DbPtGSYd3RVfHSP0eA6LUsrugxnv?=
 =?us-ascii?Q?lm10qeWWHanzydstrhJWk/c9A4BxUe20vQz310zCKl8AqlkL4G3NeNUT930x?=
 =?us-ascii?Q?sG04+FMCV11App7GD3JDPylzdXvY6YbnRV+DZqRjC3t6FTbK07WK1xJjbpsb?=
 =?us-ascii?Q?BlecsRd7+f5w8JzReKOJsVP4Gou0UrfOQK6mU5KgYk76L7uYx0gDw88AiN5c?=
 =?us-ascii?Q?Zpgon9OCWtGulmg=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9136.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Fw3EKaHbRrcF3gMx6eJqYLv0iuycXXE5Bp2g+0NZKv2gSJTR6U69czG2XUSs?=
 =?us-ascii?Q?hbU/zmzRhmk8aXez71LmIIiN71BqPfZbNSazXjPGaTx5GJQhyfbQnzZS233a?=
 =?us-ascii?Q?dR9QwUtMoXMI/WQ9lKje7WwBktAzkjuYmjVpk1hNvl1mUdIKP/uHpWlRHALF?=
 =?us-ascii?Q?SPfpw/zsrJvr0S7vemuuyQVfK+yWB/lxdVJsnQw4vlOUoxnypr5jMXBnRitf?=
 =?us-ascii?Q?C6Tq9n9osbVvcTEyY6rTFyzVnbmQxT0CIjQtGV1oimxEP5DVMkR5uKpQi3iD?=
 =?us-ascii?Q?gJzhdXXC6hepTQPbeCwbx05PFo0FgQSiSqNtk11W7TI1c3N8Z37tVtKEt3od?=
 =?us-ascii?Q?/+6g55koA/VeoaI6gAySQ2s0nvfu442UldQb44HhsYvmx3Y/Mbfa3Yahn8+6?=
 =?us-ascii?Q?cLjgnO5wspdFLjpii5HrzkE43GOLtYHn0D2aUuEbZX9/khsfghHWHUSwykqt?=
 =?us-ascii?Q?mfT7g3XLRhXTLl5k1QLxVAKO/Ey1DFmX8rFUBAKsWLVtW7HmXTgQnFJIaxjg?=
 =?us-ascii?Q?qNyTTBWrZoG0LrcggjQ3bcI/ZGXi0Nseewsl7Y+l2c3lT5Kuk+HEZ4FpEvzm?=
 =?us-ascii?Q?rEW1A5+8QXeXJdszrTtCZ755+WDOoRfX4uqQlst95zT7n6nq6BSWthdr2LDT?=
 =?us-ascii?Q?FgnvbFffjxlrg0OtJ7IOagQ7uVaAgWn+wFQmgNwtoQFIdJXzR0CFINaLb21O?=
 =?us-ascii?Q?4lyPiYK+eWThjHypd91EhzCNfHjXQXbTPypszv2LVhBVY+OxqnXA61JsCZdv?=
 =?us-ascii?Q?IlrcoqE7WpUgXM/We03bG0s7j7sCdCYQIFjZfdQcF/6d1xqTdA/1MYGWktPJ?=
 =?us-ascii?Q?FAMbdavqap7extlHFRynz6ClbO/nz82RXW0m9khm2fQ0nuX7PHEF12e85Nhe?=
 =?us-ascii?Q?LfPQv/o83qxFlmIi+h46V1+mUOobBDaRotjkBydzQABUlz2+Yl/nUfm7tzRS?=
 =?us-ascii?Q?m5uGKX42AKMdNfUPMzJgQllYBXR5BdiUXLY/fmjm4dLdKV7cGsYgS2g2uGA7?=
 =?us-ascii?Q?DfsC1xFkhNNxKm/BZUckax+6gb2wv4Rt//kJHP+DO+OjR3+EM1397bJhJ1FI?=
 =?us-ascii?Q?71I8cjZ215bGST9NB3NmOlXZt9bhuXFbuFd5frtl11IsxlKazyxRqh+g5c2p?=
 =?us-ascii?Q?tJoQAh1Bz45OEYrn/pW/fCEtwSL8pqNb/U00C9gVyX3STAGPf+j1wmOYWWwd?=
 =?us-ascii?Q?0FamjVRWwB8wjLafqjDQuBYNllL4PSaNc46mmq/5tsjx0Y4JEUDaC9VpWXw+?=
 =?us-ascii?Q?ss+n8m9jova5+zkbdNvyUVnc/gFD0zU6d3FbdsUl0ElxdESCGKC+B99B3UK7?=
 =?us-ascii?Q?4PYvAHh5DKnfoGf2J4X/l07dYQNqQqMOJGTS5pmweFAnWR4VlCXLMrYEzSTp?=
 =?us-ascii?Q?a/tpicoqBYExP/3jPxOwd8AwvaH+OPU7jpQDNwUERXHDWJUp0OZcQzyk2oP0?=
 =?us-ascii?Q?2vIwnhu5vJL+giCeF0hYamJwLF00mWoCMGvTbTkceI646qrM0jT6SnNj0Bob?=
 =?us-ascii?Q?gubS1PwXhVch1Llsb7UVCHV8JXjYrqR/cvpqgzlOgVEWOfIhyyhOzqrToEa3?=
 =?us-ascii?Q?eabYNMv/L6ReVDrJE1aGLdNeEMpvpPx34Yz1ooNQ?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9136.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57826405-5d9e-485c-7069-08ddb96ee31f
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jul 2025 13:46:46.4197 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OnWc6cVHKVesI3HEgp8r7dAjkBLJE8ZXBS0wmP+0v+YPDaAgqvCYpeEHYZgBX4MhkM2nx1ExaQK3sybINlJ/NmKx/XByiy54saysACnoz6k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6198
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.14;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.237,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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
>Subject: Re: [PATCH V5 35/38] vfio/iommufd: change process
>
>On 6/25/2025 7:40 AM, Duan, Zhenzhong wrote:
>>> -----Original Message-----
>>> From: Steve Sistare <steven.sistare@oracle.com>
>>> Subject: [PATCH V5 35/38] vfio/iommufd: change process
>>>
>>> Finish CPR by change the owning process of the iommufd device in
>>> post load.
>>>
>>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>>> ---
>>> hw/vfio/cpr-iommufd.c | 30 ++++++++++++++++++++++++++++++
>>> 1 file changed, 30 insertions(+)
>>>
>>> diff --git a/hw/vfio/cpr-iommufd.c b/hw/vfio/cpr-iommufd.c
>>> index 152a661..a9e3f68 100644
>>> --- a/hw/vfio/cpr-iommufd.c
>>> +++ b/hw/vfio/cpr-iommufd.c
>>> @@ -110,10 +110,40 @@ static bool
>vfio_cpr_supported(IOMMUFDBackend *be,
>>> Error **errp)
>>>      return true;
>>> }
>>>
>>> +static int iommufd_cpr_pre_save(void *opaque)
>>> +{
>>> +    IOMMUFDBackend *be =3D opaque;
>>> +    Error *local_err =3D NULL;
>>> +
>>> +    /*
>>> +     * The process has not changed yet, but proactively call the ioctl=
,
>>> +     * and it will fail if any DMA mappings are not supported.
>>> +     */
>>> +    if (!iommufd_change_process(be, &local_err)) {
>>
>> I'm confused when to call iommufd_change_process_capable and when to
>call iommufd_change_process, could you clarify?
>
>Strictly speaking, we do not need iommufd_change_process_capable,
>because we always
>try iommufd_change_process and recover on failure.  But,
>iommufd_change_process_capable
>allows us to install a migration blocker, and fail with a blocker error, w=
hich is
>considered
>more user friendly for migration.

Though they are same effect, iommufd_change_process_capable still looks bet=
ter than iommufd_change_process in pre_save(), because we want to check ins=
tead of really changing anything here. Other than that, this patch looks go=
od to me.

Reviewed-by: Zhenzhong Duan <zhenzhong.duan@intel.com>

Unrelated to this patch, after further thinking, I suspect that blocker is =
never installed. Because vfio_iommufd_cpr_register_iommufd() is called for =
first VFIO device and before memory listener is installed. iommufd_change_p=
rocess_capable() will always return true.

>
>>> +        error_report_err(local_err);
>>> +        return -1;
>>> +    }
>>> +    return 0;
>>> +}
>>> +
>>> +static int iommufd_cpr_post_load(void *opaque, int version_id)
>>> +{
>>> +     IOMMUFDBackend *be =3D opaque;
>>> +     Error *local_err =3D NULL;
>>> +
>>> +     if (!iommufd_change_process(be, &local_err)) {
>>> +        error_report_err(local_err);
>>> +        return -1;
>>> +     }
>>> +     return 0;
>>> +}
>>> +
>>> static const VMStateDescription iommufd_cpr_vmstate =3D {
>>>      .name =3D "iommufd",
>>>      .version_id =3D 0,
>>>      .minimum_version_id =3D 0,
>>> +    .pre_save =3D iommufd_cpr_pre_save,
>>> +    .post_load =3D iommufd_cpr_post_load,
>>
>> Do we need LOW priority?
>
>No.  iommufd_cpr_post_load only calls iommufd_change_process, which
>acts upon
>mappings that are already known to the kernel, independently of vmstate.

OK.


