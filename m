Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B4B9C3ABDD
	for <qemu-devel@archiver.kernel.org>; Fri, 16 May 2025 10:24:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFsDn-0007eB-Sf; Fri, 16 May 2025 06:23:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uFsDf-0007dm-0m
 for qemu-devel@nongnu.org; Fri, 16 May 2025 06:23:12 -0400
Received: from mgamail.intel.com ([198.175.65.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uFsDc-00009P-7m
 for qemu-devel@nongnu.org; Fri, 16 May 2025 06:23:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1747390988; x=1778926988;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=qxdo4D+4dekASO+yd6puoZ11bTMEpVGf/f4NUI+HZug=;
 b=kazWgMuBAArKvVkoPvzgjO+0SithYPQg1XGpC5Qyj4uPA4BUNzwRHk1J
 whwfZwE+hhpiNxZvkqTKiSZANPI0eunG0ahATNYvhXo18XT3IWyvQs+Ou
 gvDbK0hBk6c72jthx+UxYwkZ4EGjW+k6VKoz6Hm1nY0UJUrl+S1/mryHH
 aSHImj41TIKPn6nF0yHnr2+4ZDig5PlW15ic8P4dwRtWq/kmyTaRXSPgq
 4CzWaY8ZZswvTg5kJoo93w9mMAtm3aVFlytIR46JXzoECow6R13XOaLT9
 reDi1YdtobsPaI+k/qmFNjOY1ghs2Dn5b2VpAce1JNeiZF1ed8TDHOc8f w==;
X-CSE-ConnectionGUID: 3EcApx93TqikioKNH5So6w==
X-CSE-MsgGUID: Mn6OuQjeSKW4+czx1ZfWLg==
X-IronPort-AV: E=McAfee;i="6700,10204,11434"; a="53173383"
X-IronPort-AV: E=Sophos;i="6.15,293,1739865600"; d="scan'208";a="53173383"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 May 2025 03:23:04 -0700
X-CSE-ConnectionGUID: /T8R5uRMQkWCnTk+KFpkeQ==
X-CSE-MsgGUID: eRBxi07CTVO0zkJIcPTDLw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,293,1739865600"; d="scan'208";a="138569183"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 May 2025 03:23:04 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Fri, 16 May 2025 03:23:03 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Fri, 16 May 2025 03:23:03 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.45) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 16 May 2025 03:23:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JxiOlCkZPQFfEFipgRlyGM4J7exThmvpmi5C9+l57ldD3pohkj2TbtrSbVmCWZfMvjdI7KhEihnnFeMosRs0iKUYmx0D3PrO5On0cqpCWPcqGG6ZeAUFCTlg1oBMj1mP4S3EB2InyMwndhHtQWATYXU7HZ0YEpHis+KHF+QQU7fnJD6F/jNfJGWA2nWG2YqwW2OHMB3uJwnjDrUu0LIq8BKBwr5V6QhEaTyg5jMoxLQcaaKtYw3gtL2oYOKdCc9nrJ7LNpabW39ahJzY3mo0PkYAeToz7fPmjNHroU0Djm7BPXpuud2nJXjSrBmYyqd94fu7hfwbgZ+Y0uTZUdDRvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3fsnKYKM0lh1zycnFv8NHHjMf4kyJ8l7TpqSE9H1SrI=;
 b=PlUV9TeUO+9ic54t4AUp0z3LNt4orwCLQPxHhPASOJ3D7AxlMkxwnAaGRrMEP4cfBDO15k2fDXJHz7EY58mA7dksAvjq4RKJ9pDIXNmnz3wMPfJyr/RFMjbbnSbqoewtY/bwkn+od5U2a9G50jLyzsHpD477dSkNRdvCN23fyNrxNibpqABp2cWAtodcKWEUTmwUoaeiD1KBNezjUWgEZxWdkOO27OOEyn43/rr86mebYFgTm2ChsYuMWLolOX27wq//WibPRKeF8Ez4z+cuHu9vsKZi44kGoNOT8UQQcsX7/6qg1zCaK+9bNQsBgyOo7kkpZy7D1FFdcM/8UmSjYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by SN7PR11MB6876.namprd11.prod.outlook.com (2603:10b6:806:2a7::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.28; Fri, 16 May
 2025 10:22:16 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091%4]) with mapi id 15.20.8722.027; Fri, 16 May 2025
 10:22:16 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: Steve Sistare <steven.sistare@oracle.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: Alex Williamson <alex.williamson@redhat.com>, Cedric Le Goater
 <clg@redhat.com>, "Liu, Yi L" <yi.l.liu@intel.com>, Eric Auger
 <eric.auger@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, "Marcel
 Apfelbaum" <marcel.apfelbaum@gmail.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
Subject: RE: [PATCH V3 37/42] vfio/iommufd: reconstruct device
Thread-Topic: [PATCH V3 37/42] vfio/iommufd: reconstruct device
Thread-Index: AQHbw1Nd6KUUjFss8EmA3FcR+/yVvbPVEYkg
Date: Fri, 16 May 2025 10:22:16 +0000
Message-ID: <SJ0PR11MB6744AF09E9C87B1D9C919E7E9293A@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <1747063973-124548-1-git-send-email-steven.sistare@oracle.com>
 <1747063973-124548-38-git-send-email-steven.sistare@oracle.com>
In-Reply-To: <1747063973-124548-38-git-send-email-steven.sistare@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|SN7PR11MB6876:EE_
x-ms-office365-filtering-correlation-id: 04b5c05e-1ca5-4668-e5fb-08dd946387fd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?RhlLwdP1Cg1b8G5LyxuOhwdDfSm0UjmFLPaVxmiIb404JlHvjCFTdoaHpttP?=
 =?us-ascii?Q?Jtre3Pah9YOrV3VPilk7IAO0xt10Vc2t+a3TcZrVUUko/Qg8wndr3nwEeRgT?=
 =?us-ascii?Q?CPRQVAFGLqnSOsQxj3mhEur5p8IIXA4wCyL5f3iFyq7QD/+jw4/hNqmipvT4?=
 =?us-ascii?Q?lVG/clLojEqHflZLrOux3ms5cXsQKRK+rDwFeVvJmP3GBol68JjNU2mO0kSn?=
 =?us-ascii?Q?aChCAp69GJTjKAjzTADsQ1/dUhNLdXzBDxTbtUChlUsl6rwXerQXJiSPCeeL?=
 =?us-ascii?Q?TxdalcClRSGFHW4jmz/bbbO2pt5BsYlHiReLl3GtXmOmVWjrGe6zSU30M40d?=
 =?us-ascii?Q?B4E7khZcQkqGmndnvjh/S2rv1aAPx8tzl7wbufipSVeyvwuPRK+gPgaFB/sR?=
 =?us-ascii?Q?fHHBhrOLWfOi1aG79rDm58jDL9w8ILZKcIYPhLFsHWoJgd5oHIs46ThFfsgl?=
 =?us-ascii?Q?oV7oKkm56CtP/oEla0nOmyLfKPfOV8gXjkR47IkK2bJYhzGB7LSGYRvBvZMJ?=
 =?us-ascii?Q?A8mVptFNQNneltIz33nhJ+oGGiCKuz9xdWN9gK4Y8mn4gc+dsdXvZ+t4QKvB?=
 =?us-ascii?Q?MkXd3DjVcM7JvN6In9a5iePeTl1kN7J44dUEhDI2grbac1hBI23hNGEgvd1V?=
 =?us-ascii?Q?W7qEjRThKNj7rYSsW+4pBk3qXJsNyDaAVdw2Z7bs3UUyMWU8aCiAjPM2DrAk?=
 =?us-ascii?Q?2pcXTbUZ3g8PDnhZxL8O8n9AiDjS9nvVYQ9nRi27QudVuT948BHlTaeNYEAX?=
 =?us-ascii?Q?LbyQ2YaDdaxMF8vr020Gqb4t+uQhVPz+wz9SapLELPcVPrWHGsswvUWJGTUF?=
 =?us-ascii?Q?4jGYOVhFoN4vQxqCs7dfNXpeOeOBfECKq7OXIU/Oz956jyg3GYXTy5Byys0v?=
 =?us-ascii?Q?oJ6TlX5s1QQPNa2RdwkF73C9kCSdNQCoX1ExwroFMBpdW6WosqSde1bol4oH?=
 =?us-ascii?Q?hROBEpPHdt7mKACUGQg6tod3oR4+UjUkeMmuCmuJEcpeEQtrGq0wg4ujY8EN?=
 =?us-ascii?Q?3In2gehczprSe2g5DEndYsZFfqnPrcegVKSbhfvNb9XaHQnx+uPQ8D43yERD?=
 =?us-ascii?Q?df0gL5ZR5xWA0p9V9cq8iKN2kIKcghGkCkUfAWuUDFgEOZJxHpzKzJH7rfd6?=
 =?us-ascii?Q?3565qPOZzwSn5I3A+tHYXI0pPsU3hfZ++RJ1qD6Ynmv8qJLDlAFADWX3QA82?=
 =?us-ascii?Q?YhunU4aeMS1K2Wt49ki3067WvJRu0XNCZjLTKeh8vRRRPZqH9I+i/eDx2DM0?=
 =?us-ascii?Q?LANLNqX6R8dFpKGr7MPo+0V6xYKEsUm0OiZ6DzQeQ0c396Vanw8MlK8c83ZB?=
 =?us-ascii?Q?kA/w7PzLkQXORpf6RQ7tOnZX28Xv+pfKyBZhngdEYbTut/RYI4cNKd3tWGtM?=
 =?us-ascii?Q?joVlrqy1HivPoO8nmjgXkFt5TURr6jEcS/r7j7IOrSsQRTRwG0hvZ7d/36j7?=
 =?us-ascii?Q?QrWfuad1+/pP/KJKZYdbCaZssnOadY7nepfXPwKuD9ZXnLWEemMV2w=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ckpwPcoWYeKpt/p14MdaRUuGE+2noM288uYa03gX+JSzU+TIcwh2n/JJvDC0?=
 =?us-ascii?Q?/ZQVOM/3wUlUlqur9IDd0n7DGQTZcFFP4KqF4Sl2/5P/6bobJ/nGXzXOdnD8?=
 =?us-ascii?Q?IDjdGaAfUlFqLfczd2ayHXPEr1U7n84JLghdB70g34b9coc8TWIjLiUZGCqL?=
 =?us-ascii?Q?Fm9Q/JbXhzYKvr8xSOeZyU+b26k2Bqshuuc/TBlD8v3AAJkLxKzWFY+Ee5J3?=
 =?us-ascii?Q?uuvL4he1Axs5BPA4nSnMv1RoHkLXam1q97nmu8iWDzlEUsd68lBO2aaX+cKm?=
 =?us-ascii?Q?em+dzV2E/woi8+CAfvY40LA7dOApyq/pjkOIMFcqPJ8xcQWtEo0PeK608W8I?=
 =?us-ascii?Q?/yNKGQIZ8yKjv16tFBvB9epET3hn3Jz7vB6CTVVN3CZ60uooOs/VQEz5ND2b?=
 =?us-ascii?Q?uaJ0HKbcw3zGYL3csVPvIFLSG4SV9C8IOd9BmbRgv6+lM4qT7RzdnXfvr4NM?=
 =?us-ascii?Q?pcKPVa7ZN0BjeKJC5p8/Mz1SUxa+MrTli4FrmQG0CkFxL3WOWZttL0Qa0g1V?=
 =?us-ascii?Q?1INOpTs2An9OiAoJQqWBFub9lGNRhCBHXHxuc9CN3rJL21zI7G00gk6GLBUc?=
 =?us-ascii?Q?4sB9T0ry3sGJvsU+N3pAftjap9mStYBl/wQls9vy9ANbXB3/nDCIm6DZU5z5?=
 =?us-ascii?Q?4cKZRUDpb3IZrJtFm/HFybehKi3uYQuR3VZepTc91l9MjQ7Due/HYRMaRSiL?=
 =?us-ascii?Q?mAfT/6SjGrWWTy125KZjrSo61lJ9SRJpHahN47iszprSGYdyQ/R+3HJQY3ya?=
 =?us-ascii?Q?BoeZ6U7lNROWRYm39ZcZnm2jVdj4wTyV9ySsWeyZ4viDrCrbosnq4v47IaO/?=
 =?us-ascii?Q?K23M6fmRP3HJdwG+cEwN7+h8lSpChYNkVfL8Ozhrz5Qb2b3O7xEYy7G932qV?=
 =?us-ascii?Q?G9kqOCC8VTVxNDHz9gBn4IKHTv4q7SwEC9mxwFlAXrJ4hQo/R9IxeVEbHomM?=
 =?us-ascii?Q?20K7GLr8fvfPPzasgCR/T39f5ymSPaXYxyfS+O8plNgYBEKnMECrb7FjsT0q?=
 =?us-ascii?Q?qKRhRQILUfqy6hOYtyL9nCw2iCFQt9eG4OlKwqYoMr/1gTuZWu+Lea/23KY9?=
 =?us-ascii?Q?pWThPxnujHHJth7idIVzQlXQR9DgWYKiobvjHlavCdA0/f0sG5S1EQYA0ytu?=
 =?us-ascii?Q?cSYO6Uf0t1Lzbu5JWYCQsO8sRostmtDIl/pnoag7hTMTld17stcQe1G2cLsQ?=
 =?us-ascii?Q?wUyezjswQONlJ1keMetEhjiu6emPUgh75h9BM9ZZ+t1zTK7+HxOAJV8fLLcY?=
 =?us-ascii?Q?w6l6G0/4OpxZmXck9d8GttNMNk1LpdIlmTTDKI867Y6lJ/wjgxxON5bufESX?=
 =?us-ascii?Q?P5YYpqRMpJjkAVEbfjx3642kFxCQj/+mGvC530bq++t2jQJk0OtIysqN9CJB?=
 =?us-ascii?Q?iXim1mostlrprObqxkyvkioPldNWCdvhLWpi78sq4dIbBMWgVZaI+HQrUild?=
 =?us-ascii?Q?iAG+pzFbapg2sDWyPg/88TbXGkIVHxS3U9MhYjxlPwv1UvZ4I6X15WEuP4Qh?=
 =?us-ascii?Q?HgDrxJya69sjUpCrK9+LH26axV+shZ/RPadEc2gy0Gdx771i+jzceMCO1huf?=
 =?us-ascii?Q?SsIfFbPlhpFKWmN3DPZqtBTgBCY58DohegoOp43g?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04b5c05e-1ca5-4668-e5fb-08dd946387fd
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 May 2025 10:22:16.0653 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pI1qPYEwrc5VHAKUxPNfO0YX04KBZXClXnWnOjDqjB/Fjihxu9TOYYI9xk6lJh4kcPXWLdodL4eNaZOuXgfFsx+w+Wg5zNCp0aAUhHgQ0vA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6876
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.14;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -60
X-Spam_score: -6.1
X-Spam_bar: ------
X-Spam_report: (-6.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.686,
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
>From: Steve Sistare <steven.sistare@oracle.com>
>Subject: [PATCH V3 37/42] vfio/iommufd: reconstruct device
>
>Reconstruct userland device state after CPR.  During vfio_realize, skip
>all ioctls that configure the device, as it was already configured in old
>QEMU.
>
>Save the ioas_id in vmstate, and skip its allocation in vfio_realize.
>Because we skip ioctl's, it is not needed at realize time.  However, we do
>need the range info, so defer the call to iommufd_cdev_get_info_iova_range
>to a post_load handler, at which time the ioas_id is known.
>
>This reconstruction is not complete.  hwpt_id and devid need special
>treatment, handled in subsequent patches.
>
>Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>---
> hw/vfio/cpr-iommufd.c |  8 ++++++++
> hw/vfio/iommufd.c     | 17 +++++++++++++++++
> 2 files changed, 25 insertions(+)
>
>diff --git a/hw/vfio/cpr-iommufd.c b/hw/vfio/cpr-iommufd.c
>index b760bd3..3d430f0 100644
>--- a/hw/vfio/cpr-iommufd.c
>+++ b/hw/vfio/cpr-iommufd.c
>@@ -31,6 +31,13 @@ static int vfio_container_post_load(void *opaque, int
>version_id)
>     VFIOIOMMUFDContainer *container =3D opaque;
>     VFIOContainerBase *bcontainer =3D &container->bcontainer;
>     VFIODevice *vbasedev;
>+    Error *err =3D NULL;
>+    uint32_t ioas_id =3D container->ioas_id;
>+
>+    if (!iommufd_cdev_get_info_iova_range(container, ioas_id, &err)) {
>+        error_report_err(err);
>+        return -1;
>+    }
>
>     QLIST_FOREACH(vbasedev, &bcontainer->device_list, container_next) {
>         vbasedev->cpr.reused =3D false;
>@@ -47,6 +54,7 @@ static const VMStateDescription vfio_container_vmstate =
=3D {
>     .post_load =3D vfio_container_post_load,
>     .needed =3D cpr_needed_for_reuse,
>     .fields =3D (VMStateField[]) {
>+        VMSTATE_UINT32(ioas_id, VFIOIOMMUFDContainer),
>         VMSTATE_END_OF_LIST()
>     }
> };
>diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
>index 046f601..c49a7e7 100644
>--- a/hw/vfio/iommufd.c
>+++ b/hw/vfio/iommufd.c
>@@ -122,6 +122,10 @@ static bool
>iommufd_cdev_connect_and_bind(VFIODevice *vbasedev, Error **errp)
>         goto err_kvm_device_add;
>     }
>
>+    if (vbasedev->cpr.reused) {
>+        goto skip_bind;
>+    }
>+
>     /* Bind device to iommufd */
>     bind.iommufd =3D iommufd->fd;
>     if (ioctl(vbasedev->fd, VFIO_DEVICE_BIND_IOMMUFD, &bind)) {
>@@ -133,6 +137,8 @@ static bool
>iommufd_cdev_connect_and_bind(VFIODevice *vbasedev, Error **errp)
>     vbasedev->devid =3D bind.out_devid;
>     trace_iommufd_cdev_connect_and_bind(bind.iommufd, vbasedev->name,
>                                         vbasedev->fd, vbasedev->devid);
>+
>+skip_bind:
>     return true;
> err_bind:
>     iommufd_cdev_kvm_device_del(vbasedev);
>@@ -580,6 +586,11 @@ static bool iommufd_cdev_attach(const char *name,
>VFIODevice *vbasedev,
>         }
>     }
>
>+    if (vbasedev->cpr.reused) {
>+        ioas_id =3D -1;           /* ioas_id will be received from vmstat=
e */
>+        goto skip_ioas_alloc;
>+    }
>+
>     /* Need to allocate a new dedicated container */
>     if (!iommufd_backend_alloc_ioas(vbasedev->iommufd, &ioas_id, errp)) {
>         goto err_alloc_ioas;
>@@ -587,6 +598,7 @@ static bool iommufd_cdev_attach(const char *name,
>VFIODevice *vbasedev,
>
>     trace_iommufd_cdev_alloc_ioas(vbasedev->iommufd->fd, ioas_id);
>
>+skip_ioas_alloc:
>     container =3D
>VFIO_IOMMU_IOMMUFD(object_new(TYPE_VFIO_IOMMU_IOMMUFD));
>     container->be =3D vbasedev->iommufd;
>     container->ioas_id =3D ioas_id;
>@@ -605,6 +617,10 @@ static bool iommufd_cdev_attach(const char *name,
>VFIODevice *vbasedev,
>         goto err_discard_disable;
>     }
>
>+    if (vbasedev->cpr.reused) {
>+        goto skip_info;

I suspect this will break virtio-iommu, see virtio_iommu_set_iommu_device()=
.
When virtio-iommu try to get host_iova_ranges, it's not ready until post lo=
ad.

>+    }
>+
>     if (!iommufd_cdev_get_info_iova_range(container, ioas_id, &err)) {
>         error_append_hint(&err,
>                    "Fallback to default 64bit IOVA range and 4K page size=
\n");
>@@ -613,6 +629,7 @@ static bool iommufd_cdev_attach(const char *name,
>VFIODevice *vbasedev,
>         bcontainer->pgsizes =3D qemu_real_host_page_size();
>     }
>
>+skip_info:
>     if (!vfio_listener_register(bcontainer, errp)) {
>         goto err_listener_register;
>     }
>--
>1.8.3.1


