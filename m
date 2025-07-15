Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 076E3C83F17
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Jul 2025 06:36:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubZGZ-0004c0-Ls; Tue, 15 Jul 2025 02:35:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1ubZEI-0002hH-3s
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 02:33:30 -0400
Received: from mgamail.intel.com ([192.198.163.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1ubZEC-0003cm-T6
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 02:33:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1752561205; x=1784097205;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=CyVHcoorNc59ZAvd0YQAnYtbMTBqtUwvH0NSsmVSQvo=;
 b=PlNz+9tvci5jEDB8sNU7yeq3/6ZAb19nFpxwiG6M6cWguqbYuaM8b5CE
 32OTdD8gycZ3/a8FO6Pk2XcrdCCh7T8efdQr2Y9yac2gPeaQQ4dUfPm9w
 g9/egPi2FjbnpxbDIZlHuGgZvZTkYSysOPupnHuAJgosfcWaiSfglmwUJ
 /tVpr/Jp+G9fh4uZTX/ZGEr2LHU4bfIwEx/u1Kr5yqWNicmpkYj+UwbEL
 jLbFuSM0uUs7Mlw/b/MrCH9JBqknG5yrMTf21vvS55Cw/9nqc9qyxNjyV
 kd2fnC7Zi9fzLzATrDDkIY9ARMTxiMEeBkLkqiFkAk6cRsbZvW/q2oh1g Q==;
X-CSE-ConnectionGUID: 8o/vuiQHQcyWIny4ELfEDg==
X-CSE-MsgGUID: YxSUdjhrQd+XYnFH4AXb1g==
X-IronPort-AV: E=McAfee;i="6800,10657,11491"; a="57379425"
X-IronPort-AV: E=Sophos;i="6.16,313,1744095600"; d="scan'208";a="57379425"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Jul 2025 23:33:19 -0700
X-CSE-ConnectionGUID: ip2GnB+jTWqzDIbUvhJLTw==
X-CSE-MsgGUID: TS8oEKCfRVuNMMJdKdSgQA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,313,1744095600"; d="scan'208";a="188126560"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Jul 2025 23:33:20 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Mon, 14 Jul 2025 23:33:18 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Mon, 14 Jul 2025 23:33:18 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (40.107.220.42)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 14 Jul 2025 23:33:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bZlM7mSEQI5Si3e0RMF4a6BkQA+1OZGXvVMSYArL8u34Xz4JNU/fx/IB5LA+ajqjY3U47R+08RDKPbuEYJyMWBnYWrTklS+fngNyWGjZgnZ87veGuQ/ELUd/eyllmyvbtfN9O+ug5AQ1uLXWbHkU+ow+dh8ioOcZYZvN1mNQLpbUT8FUZZ3aOqhxNks0Keww+LQ1QOiIXTX3bWgvNiri/hoR9283gb1ubqIo0uoGehhjfbjNf4bzhFpINz61PokfzLESoqZID7tlPeaDXQ0DNwgPywopCaGtGRCUDGISmNkgr8TCrLWpmFpUZTp/7iY1yXVUpizIrlOjMqVimnidJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2CqHQCj1WArh71/75rJ9LEEAfuRvTzUjho8DZJdxAA0=;
 b=QfYTZZ2GcCbIZYlBYKvb+5YiA+Erp3DEeYpk2gv6HCP4b3v2BFW9Ex9eDcibf3MY41IbENJAxjvGeAbNQ3aC2h9v+iN0Ta2VvSG43lzN3PGMEbcxR7a4jdi2u6ubCzXTnkD+Yl/DPxNa5va2hB0PHvEyrddM5xXAB8KdYVBevwZFd9XscRawLg+1U8g3igPWgyVMC1CR/O0l1SM6Edqca2A15DpStBN476oAS892g6avSIs5qEh8zOhcpev+IwzQAG9VLYtC3FPyPPbArMxRZid7iZb2ftW97mOC0kQG+6dg2d+KFYvBfJiHc5tsnf5c0RGQnK9GzGvAjvszxI4Rjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12)
 by SN7PR11MB6601.namprd11.prod.outlook.com (2603:10b6:806:273::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.27; Tue, 15 Jul
 2025 06:32:56 +0000
Received: from IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13]) by IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13%4]) with mapi id 15.20.8835.023; Tue, 15 Jul 2025
 06:32:55 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: Steve Sistare <steven.sistare@oracle.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: Alex Williamson <alex.williamson@redhat.com>, Cedric Le Goater
 <clg@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Subject: RE: [PATCH V1] vfio: fix sub-page bar after cpr
Thread-Topic: [PATCH V1] vfio: fix sub-page bar after cpr
Thread-Index: AQHb9PSTG8RfmzuO/06MPH6Qxoq0xbQyuZlA
Date: Tue, 15 Jul 2025 06:32:55 +0000
Message-ID: <IA3PR11MB9136193226034BACC418E50D9257A@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <1752520890-223356-1-git-send-email-steven.sistare@oracle.com>
In-Reply-To: <1752520890-223356-1-git-send-email-steven.sistare@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9136:EE_|SN7PR11MB6601:EE_
x-ms-office365-filtering-correlation-id: 5e4c56af-f4a6-4f81-8209-08ddc3696ee9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?i2c7aA/SLSHNNARD8ttGwsIp+/c+WQ1i0zNzJjCdNUVKw/6EdVJF4ueM5J4+?=
 =?us-ascii?Q?cyx1v67T8u9YkZ9clW0hNTBhVOVs/CJU8aLbAZ+j8G2wqxrVHrD3MKTBRl1W?=
 =?us-ascii?Q?2HP0mQ1MYs33SnISE7ZSWBgsw9yEPS4avsbRroBEUZ8UDGZta+P38udTkjKb?=
 =?us-ascii?Q?59j+sBb0e3e/tnscbxPHVL3Mr9Oi2v7euc1RLUSb3v18z4ln+S3pPsH3Ds17?=
 =?us-ascii?Q?Y2wWpVWvE0aUqg2iIqbT0VH3022SOq0u3tbCsqstbLttdXMLh6YcApIELyzR?=
 =?us-ascii?Q?xwav3bA86/tWHVY9uvIVZJg1yYZ0EC5uk8F7e+y4wazrWXSh8JSd6DRwIBE7?=
 =?us-ascii?Q?Eecku0BXCCt0FeRXutvLvurtB8fOhWKO/t+ZptPkiJXdJqQqWO54+92UXrnb?=
 =?us-ascii?Q?jxU1dUe6f6ZDii1y4u5rNjfRe+VSZMoGXPgich9WvglnQOWUV2a4nf1nMV6q?=
 =?us-ascii?Q?cFJ7NEyUuDGVGeUpPpcNvQf4D7RMAbMf581lMIPLq1jPkcVfXVka9gkJHOa9?=
 =?us-ascii?Q?9uv74RQxakog/H6I6/rvKXEwLGulLZ4KCPdw6dElF4x9gCfsLMaBSnkXl8Nm?=
 =?us-ascii?Q?2rJe5+fgT0KkbgN9ow1axcJ5X6MCPIBEpU/phfC/GoKAFmlp31+1XBha94Vu?=
 =?us-ascii?Q?9apVZGnKpN1EaXZJS2+DONs0V81UgZuvdByYzIR8m790/Ep1awlZCwlJjUc1?=
 =?us-ascii?Q?uqQ5cxAVOHIH0nsBwixJR7GuL0nSH1/eqmHDgIoBIQtKAdcDD30tG7MSuyBT?=
 =?us-ascii?Q?WRymx+4vpGNFGWcPKY782G0FzLFQucLV7ymHsQb03zHarebK30L2gtgEGY1C?=
 =?us-ascii?Q?vlSRZAHgoh/+0B6n7qkHtFkb6x1xocek7ipCh/LdwoYpvTFNa3hWIK61dgMJ?=
 =?us-ascii?Q?ZIpTnFeQYiXbUKSr5aDYeozVneqauzlfWFojrdnD3/rSqr1TincsMBysVLUD?=
 =?us-ascii?Q?mh3enQ/qDZiEfRAugdh1Uy279NBONIJbk8V75S+HQWzVAkY4UlKa/FV5s6Jj?=
 =?us-ascii?Q?Vaervuwu8OijqeRVk/iYuQDwWX5yvMuERGOqrn3sFb2ivI9K49l2r62Hpkro?=
 =?us-ascii?Q?kjQl27j1KZnZ0Lck5pNPFCqN0ooz5v8E+/AYk1q01VQ/IxmKJ24NMNaq3zt1?=
 =?us-ascii?Q?8d5ufIqy7pqSv9Wo25pfQT6czivqvyDlHfaqBPGQjv40Vi70O8enuEHROqcZ?=
 =?us-ascii?Q?FHyCivkhtsDRHtLWVv5/76CyThmOvKUHNpE3jXlJ0FOwRKx6eoYASniU6HL8?=
 =?us-ascii?Q?VfsQ+i1VYazkqMMPUdcZaeIxWeOFM13faMVIlMVtDORaeO8zTtqyNp7YtvHK?=
 =?us-ascii?Q?1FxXkb2oBm589wt60oP4QZMpfF/4SyXLIcqFsD6cDvYKlO30sppXSgOFnzn6?=
 =?us-ascii?Q?jove5oj6XB4OWjz0TaG4G7jHT6GM0AON+AE8RnQJC3ByDrDIo8gwzacbisbF?=
 =?us-ascii?Q?H1W1QYWGPcZ6dOMtwGlo3wliEqYYTqylVTgg0DdWjdVJ97RFeCAucw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9136.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?D0VZpLzfGwc7oQWa0U6YpxzPwHM2K+L5KbVHc5tEyc63LzEXV/zFFoG4n0Sg?=
 =?us-ascii?Q?vtE3XaW+uWEN/HoCpg77JvMERspfx5wTXABmsqxUef7pmPZSR4XnB6O5Ij/M?=
 =?us-ascii?Q?biPbAVvPG5R5UHw9BglryVh8g4URppm9yada3qM71bhoUF7gnCw0OF7n0xJB?=
 =?us-ascii?Q?8eeLmVfuKtaLON1rCxObgH1zJrz1EPaB4bYS6UmaipbyYEwdSe9+A7MJowhh?=
 =?us-ascii?Q?qsh8usiK2ujWOWOFAwRKmBrhYtt/IAU1YcsYY7HNXhR+qZ9xHb63p2XE7Xvg?=
 =?us-ascii?Q?i4GA0YnnIj9t5w/zVJawWl55WbigJMRgsPM0UpZDxCGd9UVndpjBncSycgmv?=
 =?us-ascii?Q?4brIZV5bubPLrTDoCsLf5W6xU/ErMGknQs2Qi8UJZkiQKgedlJu4uiyyNXcA?=
 =?us-ascii?Q?0ZBaMLaCxrWRlGfeT/NS5imFIYuqdloi0Xtl8IfMgXcKLOoT2WYT6lTe/277?=
 =?us-ascii?Q?mlt/eqByqI6qyGv/35IW6yh/+YPEpckgxoNlokYl24XcxZFBEdGMqil1V41a?=
 =?us-ascii?Q?ZmWjpYFCx8Ka+ErU3ciQFruaH9MvvVO3Obv8gXLYcWUd5y+4BVlKsqLaMBly?=
 =?us-ascii?Q?oM39S/xBdc8Uo+MC2QXxthgGiJvAvn1BINjFzBdJve2UifuoXany8wkEpTZi?=
 =?us-ascii?Q?jMg5DVOBzFvAxs5OKDFA/iC89I4GKEND1J7b8uhRVzZyhhpgTI3u//CZldLY?=
 =?us-ascii?Q?2RISRyyqsPHi5YwUG8q6QZITilwd/UR1/HGmNbehuA4CieZys2HiGJh9Qvs7?=
 =?us-ascii?Q?SGckdwDCsoiYCmknwF3JGUYSbqUsFKudodRCQoYFgPRmD6TiERpqjoYQI1lF?=
 =?us-ascii?Q?FiTDRr2mch4AJ6De4BueKm2wcYBy13mFTeSatFpRTZOobgBrpHV11nxlcQ76?=
 =?us-ascii?Q?AcflL7YVmTklnyO6f0ELD6nQf5yzPqBShJpMdM2zDiS4ueq4ETFu5b+QjaTc?=
 =?us-ascii?Q?BWziTiy6m1VCWHN62QV7nRdALYb2GQgwPRwxDZLKpZdl4npfT6F+3DpDGYfs?=
 =?us-ascii?Q?CD56FvWrMIjEDEWcR1rsY2IVcp4Kn18ppXPGxHWhvp3slGAXikG7gtCXkAaL?=
 =?us-ascii?Q?cbIN0ZsC2gessZAdBdva2ZYZKa2D1KNqDbTmiStG6lDnZ0w4pPvo9WnbVbCO?=
 =?us-ascii?Q?IyoxwJ9fDiXYQBTuDNlZIHABvTXKQcow+NLzjU7Y/gR0fiomZLGOsZgymqJ5?=
 =?us-ascii?Q?f4BeGlq0hiyPzuGGPVP9OlAvJSkP94hWX5nhSBDK2rRarvv9+8hrO0eBWttF?=
 =?us-ascii?Q?ew262lJpltBhScAnY9e4sMFaEFpsKwT7GRsnZQgMF3sWiuAxNjyeWmgG7F41?=
 =?us-ascii?Q?G3VPS63DEHbLyiUn8JYDXEgZfhT383T21yqKCF2G2AUzGhTsX+gsd3SL8YcF?=
 =?us-ascii?Q?CqN1509HLZ6zbei9i9uFR1Ygcj3bE4Neay7LmfEHNVaHrCcTHySQ6PVbATC4?=
 =?us-ascii?Q?LKw8iwlZ9Kn4OGySf1lyzA3+jZkHp4e+feczVag7IlRbYfket4NKg7sSVMTO?=
 =?us-ascii?Q?+Vy2SnmLuEDKP+AXqsEQUjnFfyMj3SKqh1nvOQjNws6xti3HUvM8h07m4YY+?=
 =?us-ascii?Q?6s04ldVSsyAJEEzRcb8XPQvnNve3EeEM7zbcOk4l?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9136.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e4c56af-f4a6-4f81-8209-08ddc3696ee9
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jul 2025 06:32:55.6179 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NnNGych/wrdKzO6oX+e8HInnntB0tyxV7dBpFAXiU+/qGVeNETYlRtpDQlPUJd535z47CYaxfJhWGKlEHieQw72irKN9mK8PzRRzuajwYMg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6601
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.13;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
>Subject: [PATCH V1] vfio: fix sub-page bar after cpr
>
>Regions for sub-page BARs are normally mapped here, in response to the
>guest writing to PCI config space:
>
>  vfio_pci_write_config()
>    pci_default_write_config()
>      pci_update_mappings()
>        memory_region_add_subregion()
>    vfio_sub_page_bar_update_mapping()
>      ... vfio_dma_map()
>
>However, after CPR, the guest does not reconfigure the device and the
>code path above is not taken.  To fix, in vfio_cpr_pci_post_load, call
>vfio_sub_page_bar_update_mapping for each sub-page BAR with a valid
>address.
>
>Fixes: 7e9f21411302 ("vfio/container: restore DMA vaddr")
>
>Signed-off-by: Steve Sistare <steven.sistare@oracle.com>

Reviewed-by: Zhenzhong Duan <zhenzhong.duan@intel.com>

Just curious what kind of device have sub-page BARs and what's the size of =
subpage BAR.
Could you share the output of lspci -s $BDF -v?

Thanks
Zhenzhong

>---
> hw/vfio/pci.h |  1 +
> hw/vfio/cpr.c |  2 ++
> hw/vfio/pci.c | 14 ++++++++++++++
> 3 files changed, 17 insertions(+)
>
>diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
>index 495fae7..cb1310d 100644
>--- a/hw/vfio/pci.h
>+++ b/hw/vfio/pci.h
>@@ -228,6 +228,7 @@ void vfio_pci_write_config(PCIDevice *pdev,
> uint64_t vfio_vga_read(void *opaque, hwaddr addr, unsigned size);
> void vfio_vga_write(void *opaque, hwaddr addr, uint64_t data, unsigned
>size);
>
>+void vfio_sub_page_bar_update_mappings(VFIOPCIDevice *vdev);
> bool vfio_opt_rom_in_denylist(VFIOPCIDevice *vdev);
> bool vfio_config_quirk_setup(VFIOPCIDevice *vdev, Error **errp);
> void vfio_vga_quirk_setup(VFIOPCIDevice *vdev);
>diff --git a/hw/vfio/cpr.c b/hw/vfio/cpr.c
>index af0f12a..384b56c 100644
>--- a/hw/vfio/cpr.c
>+++ b/hw/vfio/cpr.c
>@@ -116,6 +116,8 @@ static int vfio_cpr_pci_post_load(void *opaque, int
>version_id)
>     PCIDevice *pdev =3D &vdev->pdev;
>     int nr_vectors;
>
>+    vfio_sub_page_bar_update_mappings(vdev);
>+
>     if (msix_enabled(pdev)) {
>         vfio_pci_msix_set_notifiers(vdev);
>         nr_vectors =3D vdev->msix->entries;
>diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
>index 1093b28..9c616bd 100644
>--- a/hw/vfio/pci.c
>+++ b/hw/vfio/pci.c
>@@ -2826,6 +2826,20 @@ static int vfio_pci_load_config(VFIODevice
>*vbasedev, QEMUFile *f)
>     return ret;
> }
>
>+void vfio_sub_page_bar_update_mappings(VFIOPCIDevice *vdev)
>+{
>+    PCIDevice *pdev =3D &vdev->pdev;
>+    int page_size =3D qemu_real_host_page_size();
>+    int bar;
>+
>+    for (bar =3D 0; bar < PCI_ROM_SLOT; bar++) {
>+        PCIIORegion *r =3D &pdev->io_regions[bar];
>+        if (r->addr !=3D PCI_BAR_UNMAPPED && r->size > 0 && r->size <
>page_size) {
>+            vfio_sub_page_bar_update_mapping(pdev, bar);
>+        }
>+    }
>+}
>+
> static VFIODeviceOps vfio_pci_ops =3D {
>     .vfio_compute_needs_reset =3D vfio_pci_compute_needs_reset,
>     .vfio_hot_reset_multi =3D vfio_pci_hot_reset_multi,
>--
>1.8.3.1


