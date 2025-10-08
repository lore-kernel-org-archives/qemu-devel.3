Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3AA4CCD185
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Oct 2025 10:20:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6RHU-0003l0-Ql; Wed, 08 Oct 2025 06:20:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1v6RHT-0003kc-FL
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 06:20:23 -0400
Received: from mgamail.intel.com ([192.198.163.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1v6RHR-0004XG-G7
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 06:20:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1759918821; x=1791454821;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=SazTzBgZ5wY5Kei0f8XwRzlYWiuLpuBUOUKsInd6TLY=;
 b=cMQ8JbHJa544NPBe6X9pj60nLKV+/lfbzqloaDTcUOpUOnBIYATMCtyu
 DJ+RK1uXhu3guthToso6chiyhNECuzldPugR7rarWYRGn8j4OeAf6Ofum
 Qkpoj9My/27aNMC+XSdHQor+m8lw1AdiTcNWxqaFevfbcrkV9WIXwZvDK
 dYA/JIFiDHVz+ejx7UnQwrGA3nzr8+NvqaIaDHiNq7txQN868XTbkFU0p
 Nu86+ZojprJUfppvQilnBjvh22GmpIGL2/FQbtc4WC+0PhbCSgwKGfqb9
 2bG3mfXT6bL5D7V2KIhqiJ2O7E+K0xSIy49lU7udaYjrqSp9IOGO2SUuw g==;
X-CSE-ConnectionGUID: oSR6LX8+SUGUdqOIHhKMZQ==
X-CSE-MsgGUID: VGihUdrMTk6vGRa/QeX+ww==
X-IronPort-AV: E=McAfee;i="6800,10657,11575"; a="61142339"
X-IronPort-AV: E=Sophos;i="6.18,323,1751266800"; d="scan'208";a="61142339"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Oct 2025 03:20:17 -0700
X-CSE-ConnectionGUID: WGEztov+RxmFZPvUbVgw0w==
X-CSE-MsgGUID: E5qMDWE8Q4uhYUZOM1ixFA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,323,1751266800"; d="scan'208";a="217501056"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Oct 2025 03:20:17 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 8 Oct 2025 03:20:15 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Wed, 8 Oct 2025 03:20:15 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.71) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 8 Oct 2025 03:20:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gIlV9keRtJJ6Kk13E/Cw377/eUkO8bXcS+4o15+PWmCwWZ0wldanSFfm9jry1azxsZILCfeCJhjeGKSPLn/HLS0peD8QalT7Gg6whpdxd49hKAh+mVnhclm9R3k/iBHhLwSUB0q/aqigTYkGvDq1esdtNUrGJ1s1jig6fIg3XXCNPuEG4UkQs8MbSle3oWyNLxYKhSZ1DtA2PyC99XIAqAhGp5FyfDGwgjKuECZH3LsFzGHnwu8pvazaIBODwF2U6VENKfakLp6/f2mhRimhq2KKJqOOI95PF+49KgsTARJEg0+CND7NCFR8picQEwerOAhR55O98JX+8zgzwrgclA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SazTzBgZ5wY5Kei0f8XwRzlYWiuLpuBUOUKsInd6TLY=;
 b=MKo/icCoeMd7mhBeqGhsWuOyRRc6VXuZHrG1JZgjgzmTjVJq7OOPfh+2kSxwuDiXNOMzOQ4QAZJFA52CBK2/pGLEy8tAMjcFsYw1QNPddNVObo1iBqN7GN1FsKzViOVBEFGDYHUXEADfxB8fy4kdfBKuUoFvN00C3IeTJvrZIiU95hi/x0gtY5yarOWZpOwtqorHeHOZKjEVxKSGrxhf6gjq6mvDBzdO9MIvXnaMZesB+AkPlPV6pnpNb+y1aeWci33d0E7fsM5Fbw7F/8GWmd2lTV9lJeOuJdjQBhVt+Nn0r0VuRbrgW4ZRct9VVWabJwgF7qvTtSl04cqk5VwZpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12)
 by SA1PR11MB6662.namprd11.prod.outlook.com (2603:10b6:806:256::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Wed, 8 Oct
 2025 10:20:13 +0000
Received: from IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13]) by IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13%4]) with mapi id 15.20.9115.020; Wed, 8 Oct 2025
 10:20:12 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>, "eric.auger@redhat.com"
 <eric.auger@redhat.com>, "mst@redhat.com" <mst@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>, "Liu, Yi L" <yi.l.liu@intel.com>
Subject: RE: [PATCH v2 2/3] intel_iommu: Simplify caching mode check with VFIO
 device
Thread-Topic: [PATCH v2 2/3] intel_iommu: Simplify caching mode check with
 VFIO device
Thread-Index: AQHcMPMonZO/GMhx70+PQqtgl/KB4bSs2+SAgAF2J7A=
Date: Wed, 8 Oct 2025 10:20:12 +0000
Message-ID: <IA3PR11MB91369D52B705DB7E35576C2F92E1A@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <20250929034206.439266-1-zhenzhong.duan@intel.com>
 <20250929034206.439266-3-zhenzhong.duan@intel.com>
 <a9a033d5a5422da97e808277b0400bd65466dbcf.camel@eviden.com>
In-Reply-To: <a9a033d5a5422da97e808277b0400bd65466dbcf.camel@eviden.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9136:EE_|SA1PR11MB6662:EE_
x-ms-office365-filtering-correlation-id: f58af3a1-a31c-4090-c58a-08de0654446c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700021;
x-microsoft-antispam-message-info: =?us-ascii?Q?1coXK/gbH5bTyjOjyrx7Pu9tCrgIgkB+higyVpduMo7tsvzXmbBRaTn4R7zq?=
 =?us-ascii?Q?NDitzuJ6O0vol60RHK2nBvU2h6P6Ke6gAHLqqztVB8vuCk1J5R8WuPk9zozM?=
 =?us-ascii?Q?gcmREGACN6QkrZGgK2ZF6S57o/tD5C91fRmgb9prUe9QxVX0Pyhn5xfDeGFO?=
 =?us-ascii?Q?B2NBnYGpRhyrKQmVKkM3bc/9GP2EO/yWPbX6bHGYkNucDircD+GaXKW2EAiq?=
 =?us-ascii?Q?BeDMZT+Rqo/S4gFVIawFZ+6ieLyrSF/O3xwpVSuQ8d2TCwkrC2QF3aqSIIpz?=
 =?us-ascii?Q?f/raoxjUWvkYY8dYv57LEK+lRdwHSARW8FGZf+TBR2JkzoHS66cvojBaPsza?=
 =?us-ascii?Q?g18fSTb5dOZrpuYR8OYxD4Jwz4p9yz4Yy288Ja0brVvSBm7n888207l+dS56?=
 =?us-ascii?Q?QFzPXSlFDM/4HPhI0oORC6Wwpp+CdFNdAzCcmdg7LnXbDy5SF4QAK9bmWCVt?=
 =?us-ascii?Q?X814B31S4mWooy/aLu5NCvV4Uwck7XRB7bH5rKa/zbnfk2pS8qtROkz+RiuL?=
 =?us-ascii?Q?FR6VKiczJLFaui6/yWMV7OqnRrCsV9iPIIhNjBnEsKIeFD8w/owxp8HDYOYA?=
 =?us-ascii?Q?MUbNe6zHL5b/oL/ex1wbUf9gUMMiHHhbzzkZMXHGvzRFDeahwzfJt7Krvygu?=
 =?us-ascii?Q?O8mcJFDlMukNcOpD/XB3O6JQcEKfK9YmTMwklZOQLlVMKfQUeH8mihC15yDW?=
 =?us-ascii?Q?MPWaT5kE8cnEQkXxaNaHppN9idWneuIKV2nud7HOXJySbXzHX8mu6v+aDTXG?=
 =?us-ascii?Q?tvFZFzWuR1yI7rmX0YEbTbtnxfkFSj9xA+D7KeeRMY+SD9ZeoNZOFYH4AM2d?=
 =?us-ascii?Q?4t9bKOSCbyD0WAp3h39Vggfw+Rm/JcGR4uotQpulpTmlgImepJ60PvrxeJ79?=
 =?us-ascii?Q?ErLG8xeWJTVZJ1S1eM+Dl9YRzErIn0ZkMnCnz+bHbqpmvKbVD1RiggBdJyvX?=
 =?us-ascii?Q?6d9Nl98wM0Q5FP65rW77qfin/wjyyB6G3xFo1EeSwf8v0p20YtiVszYA6xn/?=
 =?us-ascii?Q?pB8o7skrwkeRHVCS+/NgVwFPP7hKSTHS//hmGyVQmUW0oWrTbGzcZTaR1YU8?=
 =?us-ascii?Q?muDXFpyRNIZUMRe3GTNVxZl8NhlQSeHktkfnC9ll1ph4Bezth4OdhrzAXjSs?=
 =?us-ascii?Q?rPs9qR1ACqYmY3ob2MntMiXdaLUyZ+x+jfMwEqtT7BAWN05iSRoE0yuAGSve?=
 =?us-ascii?Q?hZIxV3XCojKi6XG/YHxWsSiK5EMZAZCfVlDUtrtE/NEKDv1lDWa/UdrpiZtH?=
 =?us-ascii?Q?eIkWLlPdN3BJC5U2LthAb/ElK4w8ijnAnUVZZrumpN9rEAqOGbdRjjXM1OFW?=
 =?us-ascii?Q?5dhlcqc9FODfuFk+gf3K1hkyocxaNrYDO+Te1DhWw6Wb597ZxxcPibUr7bXQ?=
 =?us-ascii?Q?S4LS6WsPwORfr6rN0DVWwhKopHmhS9lLDFEzrFLohs42c7AfFMmdbnbiNKL7?=
 =?us-ascii?Q?GJoPfOQuXf3H81U9me5vRQXap5k7Hpd+/KahH0S+6Fkjiirelvw13cnzGNQ0?=
 =?us-ascii?Q?F7RsfJ1CU3plzsLDD1evmoNUdECbSrdBGhBq?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9136.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Wn7sWKAByd+0A1HKJ6+0Ovbkwrv84Frb5/s6rfH9qyMUK3h/crkmXXF7irt3?=
 =?us-ascii?Q?HUEjsdBVg4BtcKG2Lhf6oAiJpPXqEGbj5UUkODyc/KweOVJbuFVA4TIJIfO7?=
 =?us-ascii?Q?w7qI0Fn4lVoYieiqeL9837/ri/DC0ApDe66kXwFnZRyPM8JT1ZPPGOj3om0W?=
 =?us-ascii?Q?wHbfGLW2TzBEWs6sbCi7R5XQIYEfJAIuCxXgmybPxDWLAcfggwrYycgmmO2d?=
 =?us-ascii?Q?KKpo1QE3ag6GtgTkwb4K6i7E9+jUf1ia5r4jgtNVE6SMeYqFa1QOFlGaPJQW?=
 =?us-ascii?Q?3po98mYO1nHClWeIvMbGfHrUjjrHIk0PWmWxlVD1Ft8dez2zrkqSColUqVIE?=
 =?us-ascii?Q?dg0etqADMys/jhpOWA8Py2AjsoJ+jTN7n/a33+Hj5dhYGwgydGOkEiqGU32a?=
 =?us-ascii?Q?HJIVW3X2oW/3++NkALZJgcVBWb55HheT9YYSjM2ODua+5q0h6BF+BeD4S6Hq?=
 =?us-ascii?Q?PVNJjtBYf8sWuImu5AG5G6q5rOfe8IOOgoJMzHFyD+WbtC0KcJS+kSt6BQkO?=
 =?us-ascii?Q?rdv7+7GLMhqDdU2MU6fgHs6fhS8TF7AjKInfY7N5fpS1hxX7clHfhD8lBYSm?=
 =?us-ascii?Q?to/ELnBl/tRsizDwoqC+7+zFQD/TBK4R4pHOgobDl6dYZ34s5PsdCnKhBLbi?=
 =?us-ascii?Q?kZE5vkRJYoa5PYA3x5Jb8+prgZkk542tPRRofHh720m+oqYrG14Ik9JKE2D+?=
 =?us-ascii?Q?pJ1B7UqfFPy4UPxHdKoUpHGp4ifLgzDE9RhPLt54R793iHTGEMh85m1MF9CB?=
 =?us-ascii?Q?l9KLdrzPhcJ8x/DpvpBJesfJVHR7WPN1EcHOlrzh+b43+fiImZnAv57Kkirm?=
 =?us-ascii?Q?7Qy5As5bN3PcOv3EthQjIVU2oFmL/69gYN3X6Hir6vTigNOBJqTpBCvavJzP?=
 =?us-ascii?Q?3NNo2bUtA/cHQgA4bwV+9NaphY+L2iO6Jblaygt0GY/o3EbXz3A74cz7FJV2?=
 =?us-ascii?Q?Ud2EYzVARFsWhfzgqb2u4O4u0mye9udzL73qyaGONmET18hqNfijQwQO0UxU?=
 =?us-ascii?Q?OWMT8awamKCUIiFAAQkWfeifI5KHoFGLWl8RG3DwTX56zU78SBMZGdLrCr/j?=
 =?us-ascii?Q?SfSnFsKGQbPPgj4DvE74Yxna4YXqb6MkHHfvM1Xvlsxh7tXxWudn3EAmt4Yo?=
 =?us-ascii?Q?5ij+CIoMp9g8gskTAYaVB4DfDOv5XzT7/aCw8YIFD+FqIdUA5SYct0Ug5j6O?=
 =?us-ascii?Q?qY1nBqfgQXCe/KgXQMxlEeIasxc2n59PHpZLfiQDytpGw5yD8xBoc2qlDwV8?=
 =?us-ascii?Q?i9kFqnfiopG+QTRWaQSicJufH8/DMmOnAXhEiu1qNqOhJ5vvWqcJSeDCq8GZ?=
 =?us-ascii?Q?ycI5BiSJCESUVB+KEZON6vNIUbn8XDplgNUr4Jk5dEmfoJjHaFw354IbFPw7?=
 =?us-ascii?Q?rebgNHiEWykTQM9KrRdV2Lr1qtOzL3pm1G82Bvh3MfYJ4+0VyZFFhdjJMCCL?=
 =?us-ascii?Q?y5hHCypObvXX3YYACdT+wxr782uPslKV1oMWJztPLG7mtrqeyJwombDKHGVZ?=
 =?us-ascii?Q?YZNupbwCIt5z0NcyNxN6BYc/S8c3Vcn/ZsPlNVifLwQ/mQSDlN2M7KbPE5KB?=
 =?us-ascii?Q?OPPN9IDxjURTDxv3ieHzwunpo93hg0wrxYqg2B+N?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9136.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f58af3a1-a31c-4090-c58a-08de0654446c
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Oct 2025 10:20:12.7999 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: s3N3BKkVY/N2lOR1we7Z3GwHR4+xur8C3wH3BUwkpVQv2HMZwo0EPW7VmSfFY+kSCyEBq1cS52jvhQePVGCtP4xwJMzApy4JlOxmcFoLWXc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6662
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.19;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.422,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
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
>From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
>Subject: Re: [PATCH v2 2/3] intel_iommu: Simplify caching mode check with
>VFIO device
>
>Hi zhenzhong,
>
>Thanks for the respin.
>Just a few comments in the commit message.

Hi Clement,

I see Michael has helped on the suggested changes, thanks Michael.

BRs,
Zhenzhong


