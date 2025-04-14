Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBC91C369B2
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Apr 2025 09:38:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4GGD-0003oX-9f; Mon, 14 Apr 2025 05:37:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1u4GG5-0003nj-DP
 for qemu-devel@nongnu.org; Mon, 14 Apr 2025 05:37:41 -0400
Received: from mgamail.intel.com ([198.175.65.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1u4GG1-00064n-HM
 for qemu-devel@nongnu.org; Mon, 14 Apr 2025 05:37:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1744623457; x=1776159457;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=z8NK+lerhYsvaMhlw4PIIR0QDHnaIKQA4fZS6fHDgD4=;
 b=exsMT51HQYc2EqOSWZKlog8DSwoU7jk834gT4ZkCLX5fLVy7hj3lHzTZ
 CTSTmUhAyL1UgCQiEnDeYlYl/60OxgyDPi2bRxNVbjkIIGgI+urhT3lCV
 V0HsNK/CIDQLf6vigd50Td6KS7Lms/1UXgCe1RMBAS2DLu+7my+8AxcR3
 sZactHKTp7PW3IJPgKBuFFf1YfipmhjE49X+Bkee1RO7olYMGbRM5ijrf
 VWgVKkDiKPX//JQ7dxpro1mkXNuBOnsTON01JkxgOO4yEcAOyK/BqbB39
 2bXWHl0SY6detIrK2Ev7VIEN/Sodo5QsOWJiGr66R9MUSitbPRkVDQiCP g==;
X-CSE-ConnectionGUID: 3wuLepHXQmWU9CMkM30srg==
X-CSE-MsgGUID: jQrP2SEyTESOxN1+HrK/gA==
X-IronPort-AV: E=McAfee;i="6700,10204,11402"; a="46174151"
X-IronPort-AV: E=Sophos;i="6.15,211,1739865600"; d="scan'208";a="46174151"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Apr 2025 02:37:35 -0700
X-CSE-ConnectionGUID: hPIUwU1jQq24Dcs9fO8Mtw==
X-CSE-MsgGUID: C99cR1FwSpOfBQSmsOC5Dg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,211,1739865600"; d="scan'208";a="134742492"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Apr 2025 02:37:35 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 14 Apr 2025 02:37:34 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Mon, 14 Apr 2025 02:37:34 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.177)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 14 Apr 2025 02:37:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xGqIz7+0eCJEQkk3cNXOgiq3NQCb2gszSpCnB8zGeFjrcaJKDtcz7AmeQtbIqFIJ31VNLDg1KKT4Z4vNzVUEX/2B104HjiBSgRRxxY3NpfzoSvw6JeY/RsGjRUTutg84Tp6xAwGFC6343uIpzMcvaWGgQ+HmHrHMv3M/bhvbzwrgLleK5bOYvLhv+bNw/iyRvvlW2zBwiVxbV+/R0R9PRS4zT8xJvUaUmJj5BCmbLVvi1sEqeUEh4VcGmHi6X3s1VLNATK8Iygk61Kob9ODJiIoj647I3ezqGb73nF1iGXP2PI/zLNoz7zZMtMXh6Z5ZBoriXPwe4AXRwsh4jbYZ3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v17DskxitYY7/rYkQKaDEXfzNTqVEHQslFpb9Nxloho=;
 b=wKn+vJin1XYGh7uQTvez6eXtkyDiX9r4M7A8mYXqLGR5Fxu13WnpLoohLmjyJYBSlYqi6clMNTgYcUjWZxBnAvDJZr9l8t7TGFNCybqLXiiRc3jxq6OdEv3JshkZvO8FZbUgeznVOhErBX+R1w652wcjp6cfNimZpMBjBRpCoYyYfmo4sZvTvIbzVtk/6jL62bCCUA9GmnVoqujolRjRhdk514iYYX4kWbVDPmErHp3ixQKWUGY1wx+ngWexE7P7P704k4JIo0l1qoruQhly6HKNrqu/Q+NXoPqFbpFvmSFTWZ6K51tYG4Urj/pxoYFkpLUW+x7aVlBIOH8E0LJ4VQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by SJ1PR11MB6298.namprd11.prod.outlook.com (2603:10b6:a03:457::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.32; Mon, 14 Apr
 2025 09:37:03 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091%3]) with mapi id 15.20.8632.030; Mon, 14 Apr 2025
 09:37:03 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "nicolinc@nvidia.com"
 <nicolinc@nvidia.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "Peng, Chao P" <chao.p.peng@intel.com>, "Donald
 Dutile" <ddutile@redhat.com>
Subject: RE: [PATCH 2/5] vfio: Move realize() after attach_device()
Thread-Topic: [PATCH 2/5] vfio: Move realize() after attach_device()
Thread-Index: AQHbqstqg8dGaGNdUEq2y5NCdeSeyLOeVYiAgASSiWA=
Date: Mon, 14 Apr 2025 09:37:03 +0000
Message-ID: <SJ0PR11MB6744F23DDF12D06F6106565E92B32@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20250411101707.3460429-1-zhenzhong.duan@intel.com>
 <20250411101707.3460429-3-zhenzhong.duan@intel.com>
 <53bd9468-aa91-48b7-b186-9909d65973b3@redhat.com>
In-Reply-To: <53bd9468-aa91-48b7-b186-9909d65973b3@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|SJ1PR11MB6298:EE_
x-ms-office365-filtering-correlation-id: d7505799-c148-4002-0581-08dd7b37ea25
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?VygURpH54jl2XvoqP/57ga3iDxoeBixPnJ6Tq08jPUA+KvGGhU741W6R7F?=
 =?iso-8859-1?Q?oGNe8bX9EO4Jl3krHxGzooJA6c6w2GFl7TghFe4zXEQR1dAsaobUnMscCJ?=
 =?iso-8859-1?Q?a2JU0wRyZyMJvVxJdFstiSnBa3Akq+BhGPnhrpnWAyeqWasdAA0H/UeJA9?=
 =?iso-8859-1?Q?LgJdGeOMQl2ipS2aG15IahwnuQW/cbwwA9CfAjRdcuYvqOisCL4iOO2ixo?=
 =?iso-8859-1?Q?6sFL2ciI2cm7WF8SbF0Im85SefQDrwLheGrOxUwA/7ylMcGZUW6F9RXz5P?=
 =?iso-8859-1?Q?c8mwMD5o3uYUoW4nIlyQAjjPVYfBkGNp52H+BPgdJLNoSwtXquda5H2olM?=
 =?iso-8859-1?Q?eRy83N0ylfphBtFdLuYreDnUw4PEZvVQmfPQ4+cZp4ae21ygKDDw+rzx6I?=
 =?iso-8859-1?Q?Muaoa8QtMgoJ0PHpTkqa/O4Eaqiq1xRpfv5KHbtUBTDImE7d3NwsbClLk5?=
 =?iso-8859-1?Q?Vl8QpowKH+6YRtO2ptxA1rC0RKsxiGec1X+fdreiv4+6eEZsFocuc2vbTn?=
 =?iso-8859-1?Q?b0b0xRO8wccRX5VL+CFjCy65kjNTnTnjdsdH6/46U4PJ3X9ZAXM6KIFjFQ?=
 =?iso-8859-1?Q?ALMG662ude4Ie6r0Ecdc2lscfVdOAa3L5/KiuR80+czEiiWbnf9MVAn0AS?=
 =?iso-8859-1?Q?jPvvjIuKroeVXyBsgs6Nde6/m6sve6nIAIsFlZNpE4+j3ThtCd2LlPrDVn?=
 =?iso-8859-1?Q?HXW5/LOeCKKKaVjwYhryONg/6iTYG/oV2oEzScEJAYjpazgDCP/OPZTKC2?=
 =?iso-8859-1?Q?RMskUweh3ha/WBRt+Ujzl5i8+corXNOpPRHJA9BxfKVH6kgV6o4FSPYkSD?=
 =?iso-8859-1?Q?eUCZGuKsMhkemRA0hUB7n4G0MncYU/OgdXkrJYc77HNHFsVKzr00eDvhVQ?=
 =?iso-8859-1?Q?rCvGiJwFe7CKyO7X0i/9GNYJVEFT0b3BItCcuoeSRqVoUBYG17IjBxdiFw?=
 =?iso-8859-1?Q?cRM8yi9SiuLAUCQ+Xwml3Z5IDswH9SgV03EtPvZRowRWvXBv4Mo5x8C9I7?=
 =?iso-8859-1?Q?HoGqMIQ/kMBC4coHv6AieKF8ipRLVozTAsUzJq5wDlAndgsONvQiT6GV3Q?=
 =?iso-8859-1?Q?1EBVgSzsbrmCWNjD3WRs2bks++R+ZtWUwoeFiFu9meQNnhhe4qBaFJdBAO?=
 =?iso-8859-1?Q?74fjUwwU+8MNClG7qlkks0C3UjtxIpI0GbnNNgZn6nizJSm2QhO1tXd/M8?=
 =?iso-8859-1?Q?FWuMPlfrTirbLP3ZFrP+BA+K1N6GuFr9Lq7Sh/4isN2ps7jwL2Vs4olwhk?=
 =?iso-8859-1?Q?eBMfrYLYh+GePe1mXaaZDjtnuX8TFXFU2NQUfNrhwT87cBzO4htl+r/g0C?=
 =?iso-8859-1?Q?UbgcdhqvcOy+CTMQm7LbXrbaWWe4ieYszmyF9+V3TTyYGZmbUj99CRsKfl?=
 =?iso-8859-1?Q?Oj9jsn6gqAWmBF5Rh8C5wy7SojK/dNu3ZWtF2zRMP6rafhVaw4/7yf6/xO?=
 =?iso-8859-1?Q?8C/Z3TEddG8ods1HQWY3yUT6osxhxdnJqvb9Qzchq1wrWMg9w9gYnOwHrL?=
 =?iso-8859-1?Q?U3q1Zu6fF/W1RwSSnrEGxpZPZ99tZX8Ddnv6SkbdSqOg=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?ekjjwrke1Q6PfoA4dPaGcz4K+Ov1a2Juf4iE5VVA3JJkKSFm8Ck/Tupwif?=
 =?iso-8859-1?Q?vcrHQtYjGCzlM3VsHZ0pa0bJfm3nLJLzEkmyFggS1ugnhINy6ze/LHyFi6?=
 =?iso-8859-1?Q?u0eHRgwWby1SRzGcrfA3FaBfYui1lY9+iqN+H4JRWvWaqZr9rl3vEhgjq6?=
 =?iso-8859-1?Q?jfxLfb+twIES/3WiyUWvo6z5tduoWVzW4dnu/Rq6bC0QDPNgg0m3GZa4Ka?=
 =?iso-8859-1?Q?yTPp0cRwibW6Z4Si7xKZttlhP5fQ1bJp2tc9f+7JSPkuf+xwOHTNr29Gfl?=
 =?iso-8859-1?Q?YS+u7rjYrizaVREV2JR3bPt34XeETiL++tUpGeAMIA2v/5fRgGbYkGALJr?=
 =?iso-8859-1?Q?FkDdNkWUVpqj0TpuTo6xcKMwMoL+4yYLkYYfaG7DI8OXJPDiklywv+aa3P?=
 =?iso-8859-1?Q?9DxoX4HAvpmIsD017YM/BsAT+Knt0hqMHdFq6vHF4wIxk1jr4EG19GW1wc?=
 =?iso-8859-1?Q?AGsO3lZdfhPfDopA4uoEGXMGCvQl8fXLBmfaXzjeSpq/o+xy5cEHJMDRww?=
 =?iso-8859-1?Q?HmCE1bNx5mGYvjJw2nQcBL97oFxJ9ipW9RWSLjoEdebsFPqQLK/8H/dK/7?=
 =?iso-8859-1?Q?quNZOoq9+pCayE7B+0QRAUF3Nm5+G1aWYV8Qdhiqjt7MNyaLSe6/Cfh0Pv?=
 =?iso-8859-1?Q?sYnvc0U6xKoucffCJ01rR/tjrngrOvROilUXYmzA5EdS1ieMeuWh3dfIgm?=
 =?iso-8859-1?Q?negzttxjV80PtTYVrKXWsUT3yr6yGPavkOGfKbQRCgzj3aPnw35b/VZRWj?=
 =?iso-8859-1?Q?S9eNii3zKie2Xj6lQp3x45HksEKtn41iZRimqUr3RulGYtyZlxpeNn8ffR?=
 =?iso-8859-1?Q?xkinoE6vx2USq6oO4OkCstd/ECPkLZWt9kWOJvCiOULDpIJ0rbqzzCdN3r?=
 =?iso-8859-1?Q?FoTBYCcaiVg3i8TNOK1Btvn89Y0FYaqp8PVfpHY7efFvS6tRUdDlfvqA5O?=
 =?iso-8859-1?Q?F8eMSBSYn7Be7AmLgAyMt+aYU6AZjlTBBTQ7OFdU8u9UG7Sa/RFC8nYRx3?=
 =?iso-8859-1?Q?m9MFQbB78a/HCWtRoDZnp082NJZTQErSt3aPaOdlpLBBsZ1FojPLMZlmvB?=
 =?iso-8859-1?Q?HW3vULSlgopVwNKgRkbGjmHLu95EMKmT5+cXqQW5pheEvKtIPCNdjKQQaK?=
 =?iso-8859-1?Q?iS96njlUUIf9UkyfSYpMzcXg7h71HaYUqkpwor7npartZULbse+bjCb5pK?=
 =?iso-8859-1?Q?jIJcJncUEfXE0ZxODwCxpsb+iVgc9juTeYGhs7LRBBRdZPY9x0RVtf/rNG?=
 =?iso-8859-1?Q?q5DbFJbbglJDrjfM1ASkS/yoPGKRvCd7es9QPnXENYYhIU1knVs7Y24n3S?=
 =?iso-8859-1?Q?swFcc3rgo6OnAwA17IzQ7LpWcK9thKt2BVsOWXuhyB5Z3kx1/KzTyR3XYD?=
 =?iso-8859-1?Q?IPyO0DDiD2AGAnVwGWoGFmVu28G0E2vC9WHuDO+wKdTERSEao2AH9ED8LH?=
 =?iso-8859-1?Q?gMjD0PeH12DQ+B2ZUYosWfpoAg3ac9Gdn+/GhPmnI9FKdL1XD5YXU63Nov?=
 =?iso-8859-1?Q?dVYSgjollnjeJg0wk1oik3xmrB9JIct0iqiMwSHSPdkx3qaViVgQuuQQTJ?=
 =?iso-8859-1?Q?8MYFmnZjmkJCG7HNZ3A40CMhSx3yUWcD+w7Tq/WWGK3SPtFT6vejT2pArh?=
 =?iso-8859-1?Q?ryx3+PV0Stm72Tb4UEDrbognRv69Ahr7J0?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7505799-c148-4002-0581-08dd7b37ea25
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Apr 2025 09:37:03.7863 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: quyJIAqC3KJnb1K9eU7RL5ECbYTvJjac3azWHn3TQeCbpz+LargYRVEKEF9MHmo/+oqfUonKkk3OzvtEs2g1FuW4rF2mnloKSmVMZvrx6O8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR11MB6298
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.16;
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
>From: C=E9dric Le Goater <clg@redhat.com>
>Subject: Re: [PATCH 2/5] vfio: Move realize() after attach_device()
>
>On 4/11/25 12:17, Zhenzhong Duan wrote:
>> Previously device attaching depends on realize() getting host iommu
>> capabilities to check dirty tracking support.
>>
>> Now we save a caps copy in VFIODevice and check that copy for dirty
>> tracking support, there is no dependency any more, move realize()
>> call after attach_device() call in vfio_device_attach().
>>
>> Drop vfio_device_hiod_realize() which looks redundant now.
>>
>> Suggested-by: C=E9dric Le Goater <clg@redhat.com>
>> Suggested-by: Donald Dutile <ddutile@redhat.com>
>> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
>> ---
>>   include/hw/vfio/vfio-device.h |  1 -
>>   hw/vfio/container.c           |  4 ----
>>   hw/vfio/device.c              | 28 +++++++++++-----------------
>>   hw/vfio/iommufd.c             |  4 ----
>>   4 files changed, 11 insertions(+), 26 deletions(-)
>>
>> diff --git a/include/hw/vfio/vfio-device.h b/include/hw/vfio/vfio-device=
.h
>> index 09a7af891a..14559733c6 100644
>> --- a/include/hw/vfio/vfio-device.h
>> +++ b/include/hw/vfio/vfio-device.h
>> @@ -124,7 +124,6 @@ bool vfio_device_irq_set_signaling(VFIODevice
>*vbasedev, int index, int subindex
>>
>>   void vfio_device_reset_handler(void *opaque);
>>   bool vfio_device_is_mdev(VFIODevice *vbasedev);
>> -bool vfio_device_hiod_realize(VFIODevice *vbasedev, Error **errp);
>>   bool vfio_device_attach(char *name, VFIODevice *vbasedev,
>>                           AddressSpace *as, Error **errp);
>>   void vfio_device_detach(VFIODevice *vbasedev);
>> diff --git a/hw/vfio/container.c b/hw/vfio/container.c
>> index 23a3373470..676e88cef4 100644
>> --- a/hw/vfio/container.c
>> +++ b/hw/vfio/container.c
>> @@ -883,10 +883,6 @@ static bool vfio_legacy_attach_device(const char
>*name, VFIODevice *vbasedev,
>>
>>       trace_vfio_device_attach(vbasedev->name, groupid);
>>
>> -    if (!vfio_device_hiod_realize(vbasedev, errp)) {
>> -        return false;
>> -    }
>> -
>>       group =3D vfio_group_get(groupid, as, errp);
>>       if (!group) {
>>           return false;
>> diff --git a/hw/vfio/device.c b/hw/vfio/device.c
>> index 4de6948cf4..6154d3f443 100644
>> --- a/hw/vfio/device.c
>> +++ b/hw/vfio/device.c
>> @@ -347,17 +347,6 @@ bool vfio_device_is_mdev(VFIODevice *vbasedev)
>>       return subsys && (strcmp(subsys, "/sys/bus/mdev") =3D=3D 0);
>>   }
>>
>> -bool vfio_device_hiod_realize(VFIODevice *vbasedev, Error **errp)
>> -{
>> -    HostIOMMUDevice *hiod =3D vbasedev->hiod;
>> -
>> -    if (!hiod) {
>> -        return true;
>> -    }
>> -
>> -    return HOST_IOMMU_DEVICE_GET_CLASS(hiod)->realize(hiod, vbasedev,
>errp);
>> -}
>> -
>>   VFIODevice *vfio_get_vfio_device(Object *obj)
>>   {
>>       if (object_dynamic_cast(obj, TYPE_VFIO_PCI)) {
>> @@ -372,6 +361,7 @@ bool vfio_device_attach(char *name, VFIODevice
>*vbasedev,
>>   {
>>       const VFIOIOMMUClass *ops =3D
>>
>VFIO_IOMMU_CLASS(object_class_by_name(TYPE_VFIO_IOMMU_LEGACY));
>> +    HostIOMMUDeviceClass *hiodc;
>>       HostIOMMUDevice *hiod =3D NULL;
>>
>>       if (vbasedev->iommufd) {
>> @@ -380,16 +370,20 @@ bool vfio_device_attach(char *name, VFIODevice
>*vbasedev,
>>
>>       assert(ops);
>>
>> +    if (!ops->attach_device(name, vbasedev, as, errp)) {
>> +        return false;
>> +    }
>>
>>       if (!vbasedev->mdev) {
>>           hiod =3D HOST_IOMMU_DEVICE(object_new(ops->hiod_typename));
>> -        vbasedev->hiod =3D hiod;
>> -    }
>> +        hiodc =3D HOST_IOMMU_DEVICE_GET_CLASS(hiod);
>>
>> -    if (!ops->attach_device(name, vbasedev, as, errp)) {
>> -        object_unref(hiod);
>> -        vbasedev->hiod =3D NULL;
>> -        return false;
>> +        if (!hiodc->realize(hiod, vbasedev, errp)) {
>> +            object_unref(hiod);
>> +            ops->detach_device(vbasedev);
>> +            return false;
>> +        }
>> +        vbasedev->hiod =3D hiod;
>
>This is not what I meant. I was not clear enough. Sorry about that.
>
>hiodc->realize can be called under each container backend: legacy
>and iommufd. I don't see much much value to make it common and
>it would remove the unref/detach sequence to handle errors.

OK, I'll switch to per backend change.
I was trying to avoid duplicate change for both backend, also realize() wil=
l not fail normally and unref/detach sequence is untouched.

Thanks
Zhenzhong

