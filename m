Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26DA8C3ABD8
	for <qemu-devel@archiver.kernel.org>; Fri, 16 May 2025 10:24:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFsDu-0007f9-Gd; Fri, 16 May 2025 06:23:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uFsDk-0007eC-6W
 for qemu-devel@nongnu.org; Fri, 16 May 2025 06:23:17 -0400
Received: from mgamail.intel.com ([198.175.65.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uFsDh-00009P-RJ
 for qemu-devel@nongnu.org; Fri, 16 May 2025 06:23:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1747390994; x=1778926994;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=uoOR/CzPM2h+A2S6mwj3/2vhzIzaDgjf/eYv7/oeSaQ=;
 b=ZJqwbTKzioin+GJyIoaAX9j8thTT5eQM7LnZS6maG8lgonKk4NiYdYRy
 zo5AydpHOzsYclWxJ5KmztAgxy49XO6UWThSjNGte6ROv2raFN8FCWiS4
 MS7HvLlPSykTkhMKCefzmrwU8b0t24ElWPbLVr+SHu6Vy3pAVyKWVWwgh
 Bz0tmaSHb117aWJsSFm7tAyny0lcxmz5Vg/sAVLV5J6lEmWXtqh9zNdob
 VRbJHRUsetnrxkWEMH8gRgT0S061zQ5AeYvKZSMDIq8Jnu4fXnpDlnBHK
 D7Y/CdU9Pn/HiHdFiOPi8r59DaOT4xqDtuCIqrrdawd3FHwms1W4bOzcx g==;
X-CSE-ConnectionGUID: JGtZgR08QX6x8aoRXi6vvA==
X-CSE-MsgGUID: z5VvytmLRCuK/O4AORMIMw==
X-IronPort-AV: E=McAfee;i="6700,10204,11434"; a="53173403"
X-IronPort-AV: E=Sophos;i="6.15,293,1739865600"; d="scan'208";a="53173403"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 May 2025 03:23:13 -0700
X-CSE-ConnectionGUID: SYln9fDITJqhj61lHrnd4w==
X-CSE-MsgGUID: RjY853adRve8j21bVG/+7g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,293,1739865600"; d="scan'208";a="138569221"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 May 2025 03:23:13 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Fri, 16 May 2025 03:23:12 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Fri, 16 May 2025 03:23:12 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 16 May 2025 03:23:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vGH60cTWj7a+5Y+LtDcUw91K5PTZLc5K9mA9JsmS/Aoc6XUglxhdoMrHQtA6j63wWtxU75wk0R96/KZ/MtK9vwbYcclFLcorSmlFsy6JrAKVdPvTlGkKBQeIULrQNk31ZYXjM2rMKKkfnEtY9rj+0e4RO96QjbRyXGRJgBwYSmMCe8uzI9F/xa1nbVujzOxa/ov8Sp8GrYRVnZIWgzcqreuezBFor9DYdReBqBAfLSKHjs4A0aRB2wK4BmIAimKOlGbDoYGdBO3jJpmtFBCNi5EMiawkwe/FfFPg1HPaxiWuwcO+7FFQ807po/ykE01K/TeMYimDFYNmCueQKg6Opw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EFU6EIrxMuSbvORrYs+mt8guBpvYHzp5S27rMT0Q5E0=;
 b=HwENP7RbzMNvx1FQshGcD8mxu+fnYb1vgE/pebKN8HaDqYroz4MVS1hP1YvSvpqD8tInTARk6rkcL/cbjBqqgjgcJckEXmtUjTxklujNOiZXa5TUtPGjdmpaBd9QuA9a6gtLRppHKtX9KKFwb4pquTwPQACNq2Uz3ujdNIaDEK39HFqAn6RCwkGVfqbDPVyjbYp+gEZUyjpnxwyRtJXOySqEFtu35YvJ9HIvAJH5u3OFbTRqMwwAmXmisEqN+mI5NsUVbluSdvMmG0Ft07W59zFTOIo6/95IlYsewPfzDiLoBg1DGNBCurLo2IamkT0BXnU+aJly11k07c6O5MA8PQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by SN7PR11MB6876.namprd11.prod.outlook.com (2603:10b6:806:2a7::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.28; Fri, 16 May
 2025 10:23:08 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091%4]) with mapi id 15.20.8722.027; Fri, 16 May 2025
 10:23:08 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: Steve Sistare <steven.sistare@oracle.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: Alex Williamson <alex.williamson@redhat.com>, Cedric Le Goater
 <clg@redhat.com>, "Liu, Yi L" <yi.l.liu@intel.com>, Eric Auger
 <eric.auger@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, "Marcel
 Apfelbaum" <marcel.apfelbaum@gmail.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
Subject: RE: [PATCH V3 35/42] vfio/iommufd: register container for cpr
Thread-Topic: [PATCH V3 35/42] vfio/iommufd: register container for cpr
Thread-Index: AQHbw1NftTLTd9+0YkenCkjnYmxai7PVBn2A
Date: Fri, 16 May 2025 10:23:08 +0000
Message-ID: <SJ0PR11MB674407DD9FFDF027C9F820BB9293A@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <1747063973-124548-1-git-send-email-steven.sistare@oracle.com>
 <1747063973-124548-36-git-send-email-steven.sistare@oracle.com>
In-Reply-To: <1747063973-124548-36-git-send-email-steven.sistare@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|SN7PR11MB6876:EE_
x-ms-office365-filtering-correlation-id: d06d2617-56de-4a66-4f92-08dd9463a757
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?FrvdwPrGtT//1wJ+Vlp+aLYTAVVtup//oL2UPEYwxpuZy5kCNBkPqVzJO5SK?=
 =?us-ascii?Q?ePvTXmFhITWOppcMdD9cIG1eGPb+btO7zTKm3Fm51KVSSrgnCncG0hLe3abd?=
 =?us-ascii?Q?BdYyautxXhC/9b3EgDQJ86xHraSj4UHze4rngrQwsF+zGJzvN43mz7JnRmil?=
 =?us-ascii?Q?6zG81u28Y9oXp5xJx1BeBPv351p4dMTfFMTveyergADK3Wfmwk/0YrOOZhAX?=
 =?us-ascii?Q?tU2kNkSJOQ4x8/fmjYCfQ7ROgwQh3gGuND+Ey3mUrgh10efj30CVbbpf2YUt?=
 =?us-ascii?Q?JXbss29zWt4aK9F8O/9guu7AFRRdBgk95nCEgw+VsOarsY4A3/5Od8LceS2L?=
 =?us-ascii?Q?zKax2RfDNSTC9XE8vEi3ct0jEkw0dbwAnxv9WXs0PWVkbtnV1K5YR92dtQxO?=
 =?us-ascii?Q?6UHDRSDbojUJTI7dAYY0YiZa4YwdczobNgXMBLG1j+tovzlQvO47LE68zZwH?=
 =?us-ascii?Q?VZawZ6lOJfgPHeBmgPpCsg/ipzr420mOAHSCyGHOoyVLRwmsv/QRBtDLWxJ8?=
 =?us-ascii?Q?iBg/20ugi561Mye0lw/CRZixivvh5VrC4gUzHh3F4dKhd3SpssgQj3bsO+LR?=
 =?us-ascii?Q?zDlqTQHEVXz8Fh0ke6lH27r9VvUsIDZ+9vMdNAEpRjwoqtIfEfDcKW7iWOeu?=
 =?us-ascii?Q?LaL1ZDCHMpPzZKQAxHSGq5Hr9yNJk/b6nuVqTVAb9DD29tnGl7Ff2NfyVsv8?=
 =?us-ascii?Q?uDXUkG4RNfluaNivx8WMnra2JxujeFM+V6T5Nl9s0b/6oYQ6aI/fmuvEDEvE?=
 =?us-ascii?Q?85NbyIA6RxGSfYtoVw1fvchhA9gUMSSl9yGuLdcigMIyYmXGVKE6hP0ZYJts?=
 =?us-ascii?Q?2UKC2Z3H8NYlmP0/tcKNfuzYhzKlt2FvKEbtVZdop0w+HzXDESEj57Mfl9dx?=
 =?us-ascii?Q?in6pM1ypRdxVuHqgjZLtjI1uuKpWJVyuo/IzSMNGaBPFgN6Q427Z8EZt3Sgd?=
 =?us-ascii?Q?eZeQaqB3kRUhMmJYlnUhtBjJnsOErfANBQiiVqyymUo7QRSYVnJ8X+G4jvOu?=
 =?us-ascii?Q?qUrYj2FBFsHRogp7NUbWX0AivhSlt8vc0kSgnh0HBMRu6u4iKuImDuvlQ/Pa?=
 =?us-ascii?Q?CiszLcb2Nn0K5mCKndJR2rRgpCnJkoxJyiDD2mKtpVkUINhhFngwlx6bdzBx?=
 =?us-ascii?Q?e53QwtVr4uIflV8GQu5AiVkONXuP22OCwnqlr79i4qSMHAh6BhHzbpG88UiY?=
 =?us-ascii?Q?5H88yUoDjHp+vPcsoLlkZutvIEEnCeE7u2q2BceJF6uIUJcgoJQ6XSJVZpit?=
 =?us-ascii?Q?ig8uyjnygery9cZjMIeJLsw/HPZFxONpclXxg7LhTNB2l4swEsOfdkV0UK9o?=
 =?us-ascii?Q?8YrYJag3Eqc0L7/FKP0G2HhfjiFqhIB/xk8M7zKu3kgOWE5p3PAK9W0Dtui1?=
 =?us-ascii?Q?BqTHNDrcCyp34x91oqKVgjmdFK1qi6jlwlS//gnQciM6GdPXCvecPsu9s49B?=
 =?us-ascii?Q?HjlA0ldOGyZU5V34bLY1SrzkZuUZpxDYByr2PDDJFkdWIq/q4YgexA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?EBzxg8Mix+p1cJHv/vTko9V/QnB9ijMGkh0v/HlZHkUMDRvtEKeLSJtVkgj8?=
 =?us-ascii?Q?AZG+kjnjFEmPYaMLzvu07+ltSS/Bmkjzd3HK5FKEhm6hECiufnrgYNOsVRfO?=
 =?us-ascii?Q?57GX4pQzn6vpo+87k8Y9ywk8HS55epCiX4irvZ91p2kLcU/vt6Hky/iCY762?=
 =?us-ascii?Q?qWBzL+HoVlDdeHD//J3Ayl5kG8oSTzyGh8uAPWGdPA8B9Wl9wFp3zbhKHLDp?=
 =?us-ascii?Q?dg1JB/fdKvIkx6AFTOBzNNYt+69NjcqTktEBsTXgugDuA3dgbM/Jc3GZ8Klm?=
 =?us-ascii?Q?8aLGJL4saxC9Gj0n45JE9cX+3rtND7Wy56NAXZ9zuMb3Sqi2ukyyyseh4/tk?=
 =?us-ascii?Q?Ps5FCUNC39g23bTYurm1O2Z6Fk4n21tS0Adx0azt4xV7aX7cAMKtxv1Vtr7M?=
 =?us-ascii?Q?hfGvxjuaIqVcHyaqHWLfEjgp7HxncL6Q11sRXXb3d+wIE+93rUbgNU298KhQ?=
 =?us-ascii?Q?G5jIl8o2w8Y9K54jJx08v9H3EkeiKjz9mEJGpSUJ3Jmwf9WYh9TfS9gjfkAV?=
 =?us-ascii?Q?tZigwxbLst0F0WvbRA9wq3m2L1+oMqKRbn5aTVb+qOWQHOUqqzTEVaRssM52?=
 =?us-ascii?Q?hZ13OFtgtXMy5Ge+85YpjDXFhl5FS8kXXQD3Vfr0pLp2kgnZshM1MsRz9OsA?=
 =?us-ascii?Q?bIrV1Sr3y/JY2GyohXEi3kDqnU5UcwF9GDE3Y0Z2aRlR4YZ0R4NJi8g8s4Q5?=
 =?us-ascii?Q?qjcxTkKL/fD60GhFCelZj2XD0Kyag4IwHp4kSeeFkgqTbSBZKxAB3L13AZiY?=
 =?us-ascii?Q?clMnMYkDT9IGNAyCWRGSDKvsI0i4hNeSeNb7bxNOUj2aZCieQOVH9lWpH3Q3?=
 =?us-ascii?Q?pby+8suMvmHb9oa7+oole59geJbEErvTVm7hoPRuCy4o5fqI9/39+50ae/IE?=
 =?us-ascii?Q?D7LwnI9P/m6Jpb1o+NDXa/+OfDEVKB6u4Qbc/ecvx3IF/PWHzG5SiODFO+15?=
 =?us-ascii?Q?QtfhqaUUQXS2kAO9cM0NkOeP3bKfBYj3oUjExia0UfMax9eagqSNKwFJNGQP?=
 =?us-ascii?Q?/XTaoJX9GMH5SS0E1ogQUD8p9/K2/MEld5c22dwhDHNjZPU2HQzC76XA7wJL?=
 =?us-ascii?Q?JKypzYOnznuv4f1jPTAP+ZH2FJj1Um6zZ1aTbEIuMrwqxFLRvBtSAhp3pICA?=
 =?us-ascii?Q?rEiE2b8HWgq6tL6LD/3SkTxXWBhfRsKt9ts1+XLsX2SzFzCc/2y1ZC9sj7kb?=
 =?us-ascii?Q?5ctevnm12WCQf2R5vDQy+frNqQgFqOgpb2oL9rlN+0CalBKEHMQXgt3IW8j4?=
 =?us-ascii?Q?Cgx/2rMht9ecRaP3pXlysIsQ3t3DGcQRGR5RdGZRZd4T97yg4+UR3MzPmUJi?=
 =?us-ascii?Q?/REG8Q9Phd2IrKTmuR4ppB5IZ+/m6JpPfGkImzrkJWwUCyQ4dvlQOAW9zMT5?=
 =?us-ascii?Q?gib0mtCwNY8lWb9UfhR5dNwBtIWYKq70szOTYkc7Q3rfeB3kx4mxLxetqxvS?=
 =?us-ascii?Q?SP+OfMOmnbkjhrIKodv6Ae/2FXLSgPRtsJWBLfU7LA3GvyTfW1Oj0UuEJ2va?=
 =?us-ascii?Q?OGfrHJeyStz3tndG0LbEEMWJyq/ojlM4/LXvldQvLkjRZeM0klTgva6AJN2/?=
 =?us-ascii?Q?q+Vth61SPPdZ6TEjgxYnXH2MtjPVLj7VYVw62a5s?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d06d2617-56de-4a66-4f92-08dd9463a757
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 May 2025 10:23:08.6608 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lMlGUq9v4a9frK7SQCx8LaXgHVPL8v6lfqm+qPMHDoc43lw8eGZ6wSMZn911UGOa1x0LUR0Tab/9mSWbGGiQ06Bz9sbu/Cm/J9COtFTP86Y=
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
>Subject: [PATCH V3 35/42] vfio/iommufd: register container for cpr
>
>Register a vfio iommufd container and device for CPR, replacing the generi=
c
>CPR register call with a more specific iommufd register call.  Add a
>blocker if the kernel does not support IOMMU_IOAS_CHANGE_PROCESS.
>
>This is mostly boiler plate.  The fields to to saved and restored are adde=
d
>in subsequent patches.
>
>Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>---
> hw/vfio/cpr-iommufd.c      | 97
>++++++++++++++++++++++++++++++++++++++++++++++
> hw/vfio/iommufd.c          |  6 ++-
> hw/vfio/meson.build        |  1 +
> hw/vfio/vfio-iommufd.h     |  1 +
> include/hw/vfio/vfio-cpr.h |  8 ++++
> 5 files changed, 111 insertions(+), 2 deletions(-)
> create mode 100644 hw/vfio/cpr-iommufd.c
>
>diff --git a/hw/vfio/cpr-iommufd.c b/hw/vfio/cpr-iommufd.c
>new file mode 100644
>index 0000000..46f2006
>--- /dev/null
>+++ b/hw/vfio/cpr-iommufd.c
>@@ -0,0 +1,97 @@
>+/*
>+ * Copyright (c) 2024-2025 Oracle and/or its affiliates.
>+ *
>+ * This work is licensed under the terms of the GNU GPL, version 2 or lat=
er.
>+ * See the COPYING file in the top-level directory.
>+ */
>+
>+#include "qemu/osdep.h"
>+#include "qapi/error.h"
>+#include "hw/vfio/vfio-cpr.h"
>+#include "migration/blocker.h"
>+#include "migration/cpr.h"
>+#include "migration/migration.h"
>+#include "migration/vmstate.h"
>+#include "system/iommufd.h"
>+#include "vfio-iommufd.h"
>+
>+static bool vfio_cpr_supported(VFIOIOMMUFDContainer *container, Error
>**errp)
>+{
>+    if (!iommufd_change_process_capable(container->be)) {
>+        error_setg(errp,
>+                   "VFIO container does not support IOMMU_IOAS_CHANGE_PRO=
CESS");
>+        return false;
>+    }
>+    return true;
>+}
>+
>+static const VMStateDescription vfio_container_vmstate =3D {
>+    .name =3D "vfio-iommufd-container",
>+    .version_id =3D 0,
>+    .minimum_version_id =3D 0,
>+    .needed =3D cpr_needed_for_reuse,
>+    .fields =3D (VMStateField[]) {
>+        VMSTATE_END_OF_LIST()
>+    }
>+};
>+
>+static const VMStateDescription iommufd_cpr_vmstate =3D {
>+    .name =3D "iommufd",
>+    .version_id =3D 0,
>+    .minimum_version_id =3D 0,
>+    .needed =3D cpr_needed_for_reuse,
>+    .fields =3D (VMStateField[]) {
>+        VMSTATE_END_OF_LIST()
>+    }
>+};
>+
>+bool vfio_iommufd_cpr_register_container(VFIOIOMMUFDContainer
>*container,
>+                                         Error **errp)
>+{
>+    VFIOContainerBase *bcontainer =3D &container->bcontainer;
>+    Error **cpr_blocker =3D &container->cpr_blocker;
>+
>+    migration_add_notifier_mode(&bcontainer->cpr_reboot_notifier,
>+                                vfio_cpr_reboot_notifier,
>+                                MIG_MODE_CPR_REBOOT);
>+
>+    if (!vfio_cpr_supported(container, cpr_blocker)) {
>+        return migrate_add_blocker_modes(cpr_blocker, errp,
>+                                         MIG_MODE_CPR_TRANSFER, -1) =3D=
=3D 0;
>+    }
>+
>+    vmstate_register(NULL, -1, &vfio_container_vmstate, container);
>+    vmstate_register(NULL, -1, &iommufd_cpr_vmstate, container->be);

Will this register iommufd be multiple times if multiple containers under o=
ne iommufd?
Maybe introduce a cpr_register_iommufd()?

>+
>+    return true;
>+}
>+
>+void vfio_iommufd_cpr_unregister_container(VFIOIOMMUFDContainer
>*container)
>+{
>+    VFIOContainerBase *bcontainer =3D &container->bcontainer;
>+
>+    vmstate_unregister(NULL, &iommufd_cpr_vmstate, container->be);
>+    vmstate_unregister(NULL, &vfio_container_vmstate, container);
>+    migrate_del_blocker(&container->cpr_blocker);
>+    migration_remove_notifier(&bcontainer->cpr_reboot_notifier);
>+}
>+
>+static const VMStateDescription vfio_device_vmstate =3D {
>+    .name =3D "vfio-iommufd-device",
>+    .version_id =3D 0,
>+    .minimum_version_id =3D 0,
>+    .needed =3D cpr_needed_for_reuse,
>+    .fields =3D (VMStateField[]) {
>+        VMSTATE_END_OF_LIST()
>+    }
>+};
>+
>+void vfio_iommufd_cpr_register_device(VFIODevice *vbasedev)
>+{
>+    vmstate_register(NULL, -1, &vfio_device_vmstate, vbasedev);
>+}
>+
>+void vfio_iommufd_cpr_unregister_device(VFIODevice *vbasedev)
>+{
>+    vmstate_unregister(NULL, &vfio_device_vmstate, vbasedev);
>+}
>diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
>index ea99b8d..dabb948 100644
>--- a/hw/vfio/iommufd.c
>+++ b/hw/vfio/iommufd.c
>@@ -460,7 +460,7 @@ static void
>iommufd_cdev_container_destroy(VFIOIOMMUFDContainer *container)
>     if (!QLIST_EMPTY(&bcontainer->device_list)) {
>         return;
>     }
>-    vfio_cpr_unregister_container(bcontainer);
>+    vfio_iommufd_cpr_unregister_container(container);
>     vfio_listener_unregister(bcontainer);
>     iommufd_backend_free_id(container->be, container->ioas_id);
>     object_unref(container);
>@@ -611,7 +611,7 @@ static bool iommufd_cdev_attach(const char *name,
>VFIODevice *vbasedev,
>         goto err_listener_register;
>     }
>
>-    if (!vfio_cpr_register_container(bcontainer, errp)) {
>+    if (!vfio_iommufd_cpr_register_container(container, errp)) {
>         goto err_listener_register;
>     }
>
>@@ -633,6 +633,7 @@ found_container:
>     }
>
>     vfio_device_prepare(vbasedev, bcontainer, &dev_info);
>+    vfio_iommufd_cpr_register_device(vbasedev);
>
>     trace_iommufd_cdev_device_info(vbasedev->name, devfd, vbasedev-
>>num_irqs,
>                                    vbasedev->num_regions, vbasedev->flags=
);
>@@ -671,6 +672,7 @@ static void iommufd_cdev_detach(VFIODevice *vbasedev)
>     vfio_address_space_put(space);
>
>     migrate_del_blocker(&vbasedev->cpr.id_blocker);
>+    vfio_iommufd_cpr_unregister_device(vbasedev);
>     iommufd_cdev_unbind_and_disconnect(vbasedev);
>     close(vbasedev->fd);
> }
>diff --git a/hw/vfio/meson.build b/hw/vfio/meson.build
>index 73d29f9..a158fd8 100644
>--- a/hw/vfio/meson.build
>+++ b/hw/vfio/meson.build
>@@ -21,6 +21,7 @@ system_ss.add(when: 'CONFIG_VFIO_XGMAC', if_true:
>files('calxeda-xgmac.c'))
> system_ss.add(when: 'CONFIG_VFIO_AMD_XGBE', if_true: files('amd-xgbe.c'))
> system_ss.add(when: 'CONFIG_VFIO', if_true: files(
>   'cpr.c',
>+  'cpr-iommufd.c',
>   'cpr-legacy.c',
>   'device.c',
>   'migration.c',
>diff --git a/hw/vfio/vfio-iommufd.h b/hw/vfio/vfio-iommufd.h
>index 5615dcd..cc57a05 100644
>--- a/hw/vfio/vfio-iommufd.h
>+++ b/hw/vfio/vfio-iommufd.h
>@@ -25,6 +25,7 @@ typedef struct IOMMUFDBackend IOMMUFDBackend;
> typedef struct VFIOIOMMUFDContainer {
>     VFIOContainerBase bcontainer;
>     IOMMUFDBackend *be;
>+    Error *cpr_blocker;
>     uint32_t ioas_id;
>     QLIST_HEAD(, VFIOIOASHwpt) hwpt_list;
> } VFIOIOMMUFDContainer;
>diff --git a/include/hw/vfio/vfio-cpr.h b/include/hw/vfio/vfio-cpr.h
>index d06d117..1379b20 100644
>--- a/include/hw/vfio/vfio-cpr.h
>+++ b/include/hw/vfio/vfio-cpr.h
>@@ -31,6 +31,7 @@ struct VFIOContainerBase;
> struct VFIOGroup;
> struct VFIOPCIDevice;
> struct VFIODevice;
>+struct VFIOIOMMUFDContainer;
>
> bool vfio_legacy_cpr_register_container(struct VFIOContainer *container,
>                                         Error **errp);
>@@ -43,6 +44,13 @@ bool vfio_cpr_register_container(struct
>VFIOContainerBase *bcontainer,
>                                  Error **errp);
> void vfio_cpr_unregister_container(struct VFIOContainerBase *bcontainer);
>
>+bool vfio_iommufd_cpr_register_container(struct VFIOIOMMUFDContainer
>*container,
>+                                         Error **errp);
>+void vfio_iommufd_cpr_unregister_container(
>+    struct VFIOIOMMUFDContainer *container);
>+void vfio_iommufd_cpr_register_device(struct VFIODevice *vbasedev);
>+void vfio_iommufd_cpr_unregister_device(struct VFIODevice *vbasedev);
>+
> bool vfio_cpr_container_match(struct VFIOContainer *container,
>                               struct VFIOGroup *group, int *fd);
>
>--
>1.8.3.1


