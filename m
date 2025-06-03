Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AD2BC5AE59
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Jun 2025 10:40:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMP4F-0001zT-Lq; Tue, 03 Jun 2025 06:40:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uMP48-0001tG-L6
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 06:40:20 -0400
Received: from mgamail.intel.com ([192.198.163.8])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uMP46-0008Lh-NJ
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 06:40:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1748947219; x=1780483219;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=h8Ng1WLV0pEZHZHlyBJwpP1OE5MTXNMX63qDcQSbXxE=;
 b=NAbm3PpIKLFLS7/KPOHFvlu9kPov5sZyqrwtyptSRfYznUmB67aLCIti
 KPa80dVzfPoE9uxIBNtKW26pnfElzJ/HAFauOnJ9Wbl5dwa3GMLMGPB3Z
 eIgEMohBEmGnGUi63MPJEiBqr9gU5QmFnUk6lzY1SSFuNNwd7TZg/T/Tk
 vq9ZEJZYzpaTWBrCrMoTX5qLWdlCRnVFv65gDdo8TMi0J4MPK8XzCnDnA
 MWMGCbYz8lmBeb4orz2WC47B9l/EeoqShizwWd8XcwmYWaFt9l2VDaD5e
 brkhmZPlan9cdszbLYy/BC/XnILh//xY/D729BNGrr0DFq3D/Z8vD6V9Q w==;
X-CSE-ConnectionGUID: ejHuWIMmQq6V6dH3THvL7Q==
X-CSE-MsgGUID: lmuxSVLcS1a7VrSq5fWG0A==
X-IronPort-AV: E=McAfee;i="6700,10204,11451"; a="68533961"
X-IronPort-AV: E=Sophos;i="6.16,205,1744095600"; d="scan'208";a="68533961"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jun 2025 03:40:16 -0700
X-CSE-ConnectionGUID: K5wqswR6QXWy2mPcEcL84g==
X-CSE-MsgGUID: 2E0yOVXsTtinTncB+qJkPA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,205,1744095600"; d="scan'208";a="149978921"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jun 2025 03:40:16 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 3 Jun 2025 03:40:15 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Tue, 3 Jun 2025 03:40:15 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (40.107.243.44)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Tue, 3 Jun 2025 03:40:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zAmkg8HYH4Co01xHtotypzZaoET1mn6RLlg0PoSiZdlL2tUIsCQYit8GPoNOkk6nseJFf0BtX9U/Zd/p3JA0706n6yJFvPKAHLs+nS47JJwSCPR1ZDFohU8fZ9zMA7syTCdxtSiSbr3ZZCFpIJnr7cmdsS256GUhKXVVYtKJsmAOzXNSj2Hq4s1Kvrj65rBlgG9lCjc3CgMPOpCgDNiVk9ytvFpT08FAkHxjTyqSZRDQEKjpyQrN+nez5eV1x2JdGFOkhqt2NIZZ+V6XwqXJUT1HMcp+yc2mui9XRojhLq3NYZPYlFonE6MR0r7/dAzT1a0DKYe9CtQeCgB0qsH4xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pOtiTu/Jpnzfab+TnfcZ97o4tsJtmUIgwh9g64FLcE0=;
 b=jLLLxl1wqIiKBUg72hpHYxQK3k4JSjgxNc3J/v+dsaFnJScU6Lk20I8Jr3KKFqBbQlqh2PEnqM3VKuZh39ijH7t9GSFh9ov7PLpZ3/g/ssefce2Te3wihupZignxTGep8xMH1B9NzqzKkzF8IFV2eplw9tZz4zfI6J77y4foEWkJLI+s5kWlCg+En5f3NyXDElcy4Nta4HveyrXrN75AnTzhv6kExyMG1yKUW/Vp/irAvntXHUt7kIKpo/cTQuNwoMu4I1MypH2/FY3LKQ19NtftJWjNVyrzJdEW9weazE1NpYuT1bSBg4esxSlg41RVuT+rJ8Lxkg6mZN5/0xaVSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12)
 by CY8PR11MB7316.namprd11.prod.outlook.com (2603:10b6:930:9f::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.30; Tue, 3 Jun
 2025 10:40:13 +0000
Received: from IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13]) by IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13%4]) with mapi id 15.20.8769.037; Tue, 3 Jun 2025
 10:40:13 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: Steve Sistare <steven.sistare@oracle.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: Alex Williamson <alex.williamson@redhat.com>, Cedric Le Goater
 <clg@redhat.com>, "Liu, Yi L" <yi.l.liu@intel.com>, Eric Auger
 <eric.auger@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, "Marcel
 Apfelbaum" <marcel.apfelbaum@gmail.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
Subject: RE: [PATCH V4 04/43] vfio/pci: vfio_pci_put_device on failure
Thread-Topic: [PATCH V4 04/43] vfio/pci: vfio_pci_put_device on failure
Thread-Index: AQHb0M9ffeBve8sbTkmcsVPSqsxgBbPxRJcg
Date: Tue, 3 Jun 2025 10:40:13 +0000
Message-ID: <IA3PR11MB913626075C1F4FA64AED3B63926DA@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <1748546679-154091-1-git-send-email-steven.sistare@oracle.com>
 <1748546679-154091-5-git-send-email-steven.sistare@oracle.com>
In-Reply-To: <1748546679-154091-5-git-send-email-steven.sistare@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9136:EE_|CY8PR11MB7316:EE_
x-ms-office365-filtering-correlation-id: c1d2ce91-7ae8-4cf9-ddf4-08dda28b0588
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?hiode/DgDvu53kVJ1aS+pRSVAfYFweHX0nU7cOxp2gtd2GqhSY0pPWWV8YQX?=
 =?us-ascii?Q?E1eEkOQXUbT89VMSER9/Qf0pePh0tStdLpJjIYTQIj79setfEhCRqJO08E8X?=
 =?us-ascii?Q?Y7lj2+Vl1F26/qezYHy5oI0uiZdp8WeB9WKLLz3LTqKdIBnDMKBZnZ9OpfZG?=
 =?us-ascii?Q?YFQ7fVPUBtNxq1RM3Jfc9dACGZRNN9nZMa7NIG4T1f2j48ngMJMDDrvDEeDQ?=
 =?us-ascii?Q?wG9o+AE5WTSkxIj2a0gVNgY/sC5EchieYmriCZ34onZkyTqXX4LH72xwfY1V?=
 =?us-ascii?Q?Axpac5yNsn8B9AS1A3qay9MN5aBrXlYmPSaUrd/teZGAjtEYns+PjkOsyJ6E?=
 =?us-ascii?Q?hPZm9zeZGINgixoDORodWX8TfFt29GAGTR+YgzVeuF8ETLHcC7w91PJO9PnK?=
 =?us-ascii?Q?wLpU6qIaD9GFnlBNydzqI2y7pw/rdBEUds9HSKpURjjVv3kJ6kow3oDXpGIr?=
 =?us-ascii?Q?0c5Foq0hnwjTUKYyCcr7zYWmp5BhF7bhRwCJdwjf4TSFpTCSZvOyTeiqCINM?=
 =?us-ascii?Q?fPbQXE7FiK8Fi+NmZi1t+8Qt18hX9lZ5SLirstoD+gpR9FNFvBpFUuEVI4d0?=
 =?us-ascii?Q?FuHnGy4wauw4MHcqbtUyR4FLY8O2DnNDLIDBjo/EchFKRggWc1q92r0R3uby?=
 =?us-ascii?Q?5wy77tanbpxvS7seQTWyzaz7xTS8jU/fcFQvhvcdUrnjLzV9cCky+zEdvPWG?=
 =?us-ascii?Q?b+154t0bgYRsd9U1N0be8MzptllzOLgJQWzYve/SUqmyA/8/vFQL9TzanK9D?=
 =?us-ascii?Q?KWyPcpEFyQ5Umf03wjLbgnzfMVz+X4agiClPjrbEQta3VfFkRd46cgBxhzQq?=
 =?us-ascii?Q?Z37dH690fpd/vVCr5h1gXBa8kdpkQTI63d+n4s097H1q96+zILgdpIJUkrJL?=
 =?us-ascii?Q?i0N2Eo0w7S8dFCnW0PsmlE5XE7DRhe3cQ9qmJd2+3BzzTPus3r5KPeZNhHlT?=
 =?us-ascii?Q?Q8dBuXcxuxL3sK5H0rZ8JAKT/0Mm8ikRapuJLhzUMqRkI5QUt0FCA0q5kb10?=
 =?us-ascii?Q?FZ8Y84n46yfjI5l/jitBJEUbB2wQexsfx9AWV6O2MrG49l/2mE/jTR5PTY2s?=
 =?us-ascii?Q?6a3N0J6WUSc5wxny9hN/KaFSYvtwP1ncyujZGNObl6nIsNMDiU7UrE3acTrV?=
 =?us-ascii?Q?jSiXPIzgGyn+ik/HiRQE3AJlYq6qnX1wc67WWe0f4asyq0SmP2bYwSYh0Q2l?=
 =?us-ascii?Q?+VM8UG8NHaEYxsI+EDEEJKwbZI8zX9aF8/pJLdtoFYFLjjhtSWBC3ZBoLRgd?=
 =?us-ascii?Q?jb0Xf/2d0Xpwzk03/malaxTJFCJ8r+8jZegtMBHP3QdYvzlT/f9n3p+IIx/4?=
 =?us-ascii?Q?rbpbHWyuXVmlWnDHwiCFlKsHNP2TiU3i0tHnNyHpZYp9zVSxfXDweXKycPus?=
 =?us-ascii?Q?k4TFocutj+4pBcnhVp8pCmYAwCLNxMXl0md311ty8zaBCBegLkWU1TCibFNP?=
 =?us-ascii?Q?NuA49CQyoFTXGspyMuQ/z6GgeV/3Bk4H3YjdOc3KN7qWeyX6EYcgJ+N443Ru?=
 =?us-ascii?Q?7MEe8IZMPGAXYGs=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9136.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?AO/oNITvAeVO2pClA+cPdbQcJ39yH8uurIWxmn8lzIINiK+9qOnOWR5qGAYA?=
 =?us-ascii?Q?V9NsDLrLUxhFnaNTYmjPA9AUxomA640Cz9XGiFzfmj8KLAp0t/m3sC/gJ7C8?=
 =?us-ascii?Q?XJtcGhP3u8wppjKKzQnTRL4Cgxu3bIE3zZI9R74eU671H26oz1SGIyFVNnP0?=
 =?us-ascii?Q?xDiTX7fPEWK1Oo3Yy+G2iLouTz/v8c/bI2iIG6kAWZFYCQacPiZBG8Q8lwIC?=
 =?us-ascii?Q?5UZPmk4ZyQW6mKYMaDXKBwjXlzVPUmHeCfAYKbJ7Ln+SCsilmhcz+eXz/X7E?=
 =?us-ascii?Q?zogwRYHbghYsao/02ci59Lqfd4C4TSoSOF6HwTBWOSpniNbqyby92d/i1mi1?=
 =?us-ascii?Q?btQ02yjBUW58z2AUnLuK4Rh1TvhdM/Eq6f4G5lfPqkKdD7j55VY2XQbhpk+J?=
 =?us-ascii?Q?KeAhgzdWUfCBG+IzPtkwYY0l7zZ6JIOPhDGSqRtqIHHYSlT10n+E+jquAyms?=
 =?us-ascii?Q?/dgjCPessyrmsnUI7fhQQVHatZIoo7+SoOomwks/aGFzPGN3YJv1pw3TbVM3?=
 =?us-ascii?Q?G8CbklzX7d5e/p+uBuR05pGPQkfk9X73I9DJ2cjzFE7KDs9H8Z+48MW972HF?=
 =?us-ascii?Q?a82Y7LK1VSpa5yrbBKT2RwfednfHnGr3t428GfrLj4LNkvhhstsmDd5pp2Vu?=
 =?us-ascii?Q?v5VmpyJk2s655IVk0v/9i/RF6GEj7/mXmUsnlERuIU02w26KpMLxl04k0oK8?=
 =?us-ascii?Q?AbaYrtFwsy6nGdX7WOSVi7CpidTFL8459OVig6blRP2hhYLMzZkX48uN/v9b?=
 =?us-ascii?Q?VbmJsxOKXAkvlmgvARUnUOXcyC73Gq62ijxTaI7prZNAW++GUScUzZnoZr9i?=
 =?us-ascii?Q?Ohw0j6zpjthPwWxVyDQ4SQqf/lF86YlKWWrlBsp7uEI+RZf0mfDF4djFGgxm?=
 =?us-ascii?Q?BWIgKHOIrm8wfl/qrgJ0IB4rx7wQLeBUzIUNOa1oID81RQ0LM2EDDQH2d1TW?=
 =?us-ascii?Q?d41DcJjwYZ08nHfJOLGArjtY4m5NdW1BGJbe/ddi/yn0mHGAwxGE0xX9bhR2?=
 =?us-ascii?Q?Sg558BJdTfeoc0D9NsFWHsg2AMRm8EoEJ9avLKKvJQCJzhbieSfpLrVM/ASQ?=
 =?us-ascii?Q?pc3g3SCVXj2uP8t4Zic3iuljefJGEo+j53E3txNHUARi/xvX6b4laR4iO4vW?=
 =?us-ascii?Q?KA8WICxPOB1hoLzeDURZ+F0A34S8NeAWOJw2HpRHCDGsTl2TUvsLjMhNMF4I?=
 =?us-ascii?Q?UHJqh58ZwsuwBppi8sDlvKHYdY5JNYlbPHNkuXGVvCvbBU6xlpWx0aJAGjVA?=
 =?us-ascii?Q?7stnjQN5td6ODi9HjLR/Vc+s1LeBybKesVhCqh6ECtnvicoxcMULZzOL95og?=
 =?us-ascii?Q?d7PpIYLaAHUrh5z3e9QbtCa1AjxNGiJLzJcZzS928KWYzWCFV//0+9gIGmvs?=
 =?us-ascii?Q?hYaI7RJLBK3uo5qSddejiFTJ7mwEPR/GV3GD6iwDaQJbkkHbHWWadl+b7Tgh?=
 =?us-ascii?Q?YBzlIt+pJDCbsuwLIcv/OVMyt15hjuGnjLY1BYSwCelwsAobJyhiqHv+iHdT?=
 =?us-ascii?Q?rmxcOQonlqsJ2ZZVNJtILSqLviP3vvD/K+oHfp5X/htYPIcW7ZMQsBOOxBT3?=
 =?us-ascii?Q?YFzx2ypqNGmc+MdGx7BT+OyBeBr/vGks+dh+VXES?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9136.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1d2ce91-7ae8-4cf9-ddf4-08dda28b0588
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2025 10:40:13.3147 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IWoKP792dyl+ZZr6yD99HA0bDZXtnkEtoJyYwUwGncj7jCWsfNdOGYKcbZwQGpy0sI7NockGbyok2SCU/qEK29B16X8xtNzI+cLz9wmY/qI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7316
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.8;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.128,
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
>Subject: [PATCH V4 04/43] vfio/pci: vfio_pci_put_device on failure
>
>If vfio_realize fails after vfio_device_attach, it should call
>vfio_device_detach during error recovery.  If it fails after
>vfio_device_get_name, it should free vbasedev->name.  If it fails
>after vfio_pci_config_setup, it should free vdev->msix.
>
>To fix all, call vfio_pci_put_device().
>
>Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>---
> hw/vfio/pci.c | 1 +
> 1 file changed, 1 insertion(+)
>
>diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
>index a1bfdfe..7d3b9ff 100644
>--- a/hw/vfio/pci.c
>+++ b/hw/vfio/pci.c
>@@ -3296,6 +3296,7 @@ out_teardown:
>     vfio_bars_exit(vdev);
> error:
>     error_prepend(errp, VFIO_MSG_PREFIX, vbasedev->name);
>+    vfio_pci_put_device(vdev);

Double free, vfio_pci_put_device() is also called in vfio_instance_finalize=
().
Early free of vdev->vbasedev.name will also break something, e.g., trace_vf=
io_region_finalize(region->vbasedev->name, region->nr);

> }
>
> static void vfio_instance_finalize(Object *obj)
>--
>1.8.3.1


