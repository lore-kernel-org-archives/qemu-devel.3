Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48EE3C3ABC9
	for <qemu-devel@archiver.kernel.org>; Fri, 16 May 2025 08:55:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFqqj-0001xY-17; Fri, 16 May 2025 04:55:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uFqqg-0001uU-Mm
 for qemu-devel@nongnu.org; Fri, 16 May 2025 04:55:22 -0400
Received: from mgamail.intel.com ([192.198.163.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uFqqe-0007h4-5B
 for qemu-devel@nongnu.org; Fri, 16 May 2025 04:55:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1747385720; x=1778921720;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=U+yBO41eKwLfdxfYlBiUrtkWlAXDpEnufSH84aZX8I0=;
 b=l1VvX7lZs4t/1nvi018X848LOxwM2lcmLz/t18dYvaxmbglaCXnkgNXj
 9dlzkSXPKYJmvLwz0QnuYC5ZpFAQUpX4zx2yRJ78tsYJzsOeHrRK9Xm4r
 Pq15hpGyIlrxG5dujxieSG581PO+YYtMfKXtqT9znaVnztu8XaberC9kh
 tDtsd5nJz7xq3GDVoQy0qlMMz8mlwqqix8h6BtTyhVnyzHTY6PaGIDfcr
 hZ5CTsD61te2c4vW26GoX/fcvqKVtMKcv4y1Lvq7tvf3ANkmZBInLkk+F
 1F1Hc9VA5xuanD3b6p3NbTHaCLVmX2eJKmbMxOyPmIB7HIdzXjgxgn7ZW g==;
X-CSE-ConnectionGUID: 6bVIVW8pS3i0Y6BTH5TDJQ==
X-CSE-MsgGUID: WhQfxsw7Rh6oqqUjE9seZw==
X-IronPort-AV: E=McAfee;i="6700,10204,11434"; a="48603506"
X-IronPort-AV: E=Sophos;i="6.15,293,1739865600"; d="scan'208";a="48603506"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 May 2025 01:55:16 -0700
X-CSE-ConnectionGUID: NRk4OrgHTlqCzsk3st/HBQ==
X-CSE-MsgGUID: r7BH5N/uSHKAMmr/dn9dlg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,293,1739865600"; d="scan'208";a="143586110"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 May 2025 01:55:16 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Fri, 16 May 2025 01:55:15 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Fri, 16 May 2025 01:55:15 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 16 May 2025 01:55:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BpJvtt+DtDd+sMvyxcdhFzCmrfWLv9CevA7y8Mz/89Wa1Nz52cAlz6ZiDBZRCBVFW++JglZQa3YcGhojwZi3YpOR7N3aGNNKubeAXX6+XODxgNpHjWly0uZtDiCFkt2XBmoEsuJ59j+sZZn82Kyk6t+pVfq/fxB+5P7AbPcJbhHHofvgS9VpTUpY0/Wt+3bg8PFdH8Gss9zJpduVTOwx4IibJbvukITNsdbyyMvMWoEZBuHEIufxJspa2VK78t6xhGovIVkPlZgjLV8ehpNIxFZdIFg+GPnx4ioxHIaHCC58DU6KaFv6NqH4X1ijGnHdirTeasZhaDAiFp6OBcKG/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c8ZlaSqnWz9JAyilDUdH4IoKdUBaQwHBLWYaX8iGu9s=;
 b=bjZVJjcX17PjrVUlOpunngNru0t13PhfHAaIZ0c3perRHyM1/raTea5oc1dPLEkBnANzXrvw1knxN/CTjnIHYooFbD4VzwN3iGzeRgy20mF514hLZeTMDv1TtJOcQRBco38VcuqSEQcWEmRmj6rFcfVgn4IjPKpjFvqR+icYvWg+SoH+NBuINu4SnxA1TwUbbGvxpEpnx/t4f7VuchpIF/4xfpKhyZrigAkCKFOXA9UICsZcJ+YwkbzoOrV2WjVyLTBJBsPxDehA2qzbIBP8UXYPTyOTAUryy0E/2HNbUxYrKVunJQYjgqNyoZy6gRGtLx1suipSB9BMvjFiycNISg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by SJ0PR11MB4959.namprd11.prod.outlook.com (2603:10b6:a03:2de::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.29; Fri, 16 May
 2025 08:55:13 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091%4]) with mapi id 15.20.8722.027; Fri, 16 May 2025
 08:55:13 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: Steve Sistare <steven.sistare@oracle.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: Alex Williamson <alex.williamson@redhat.com>, Cedric Le Goater
 <clg@redhat.com>, "Liu, Yi L" <yi.l.liu@intel.com>, Eric Auger
 <eric.auger@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, "Marcel
 Apfelbaum" <marcel.apfelbaum@gmail.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
Subject: RE: [PATCH V3 33/42] vfio/iommufd: define hwpt constructors
Thread-Topic: [PATCH V3 33/42] vfio/iommufd: define hwpt constructors
Thread-Index: AQHbw1NeyTj0Ugl2t06fgWEXsIff/bPU+E0Q
Date: Fri, 16 May 2025 08:55:12 +0000
Message-ID: <SJ0PR11MB6744C9ABCAFF7FB3204BA6549293A@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <1747063973-124548-1-git-send-email-steven.sistare@oracle.com>
 <1747063973-124548-34-git-send-email-steven.sistare@oracle.com>
In-Reply-To: <1747063973-124548-34-git-send-email-steven.sistare@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|SJ0PR11MB4959:EE_
x-ms-office365-filtering-correlation-id: 04dbfdbd-85e9-450b-5609-08dd94575ecd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?Osjv78xshMNN3ZuXRWxjvu0Xg6FzjIckh5aJ2dT3QYcp5el9GEPzHzEWiWZB?=
 =?us-ascii?Q?efub1PW5zlh+OaJrb0BXtU15fM3AN5HGd+72L9Fglvx93ZU1eQ9upjXcmM45?=
 =?us-ascii?Q?1aTbxtNnUXXkkPdJu5GsNKq8ijmE87DshKfz0QY58zYOWDL+c8tdf9Ba9IRC?=
 =?us-ascii?Q?cHV/Bt/vQao77IHKwMlrmI4hqIoAD+19ehPdxuDRwKPY3E8MCg/yx7vi+NnR?=
 =?us-ascii?Q?VIS7yYD3hphVW6KuazUUYFteG+BZQG7aTze4e21nlM1AM06CP1KeUJiHYiZH?=
 =?us-ascii?Q?KL2ME4qlfCUkKVhysbnAFo5hSj9SvIggslyLVBIqXB+ZQpX/B+SBGPGmdNra?=
 =?us-ascii?Q?nUpS0hl4Afc/ogEhyErcixlqmgI8GipOwqljMAHlESP2BchnQ38eSV3HW3N2?=
 =?us-ascii?Q?ECXqQSpgBGhnnVo5YAwyB4jmGMv+jpZaW64N0e7Ma5yYhOqCPYt2TLwzXWYq?=
 =?us-ascii?Q?XZNy2PAmGEwvQuPxSPX1aCjORjOIpZ06/fQiI1CEb5+a7rl6e6aN1UWv3HY3?=
 =?us-ascii?Q?AydA/M/sMMJ+xSbWnllWAiwMBXPFd2Wapyj3a9ubnuWLCTaJRd0v8XryhvjL?=
 =?us-ascii?Q?T0/pgCUJZE+WT5JRThnLxFBHOMSk+bxywbLpjrCFLNai7WNk4ZEwdatfy4cV?=
 =?us-ascii?Q?SPO8Z/ne0avLmrxsVhlF8ZOQWjZHOg7wVlrTTjwxXqYyRjkqzZufywMTG02k?=
 =?us-ascii?Q?icBNeCv6LUEtGdNjZW//EXY3/Iu+Cy6jcR/2BfUvIGw41wch2ciCKIMY10iO?=
 =?us-ascii?Q?66XwJDa77c8PmlYnhTbBmwRs8sNOjR922d14NPBhFoJnvHqMwzsTayxaRq2x?=
 =?us-ascii?Q?/WFOMIGR92J4FUIoySHpCGiSKG6txW1J4yqbv+Eh20VU2FOytQpuVOif1SEP?=
 =?us-ascii?Q?8rF9curHBMEc3mIXu2Zmafzm04iTlqq5wccLuh3SpN96B5iZecPYQ3CCyEWl?=
 =?us-ascii?Q?dLy+DGvQGMugz/81PbDCQ5pHx7Ng2eE6ywhS+qoiI4kE8yNyw8yyXRCgoiWq?=
 =?us-ascii?Q?iprdsmIjEwFjKX00oKczLbV3s6dwubZmVbFyVyN1UHPr/NsJeJ1u8Gl3A1cs?=
 =?us-ascii?Q?MMOE2cw1YRloDI1qAM6Pq5/hQvNNQNc7EsZ6rKl6uSqB9j6AFEAV1ABGfcmk?=
 =?us-ascii?Q?DQ6wTQP+C/EQi1l/YTc38ZqJfxddt1cje2npqvq2tvIUsguz65XMcMMJL5Pt?=
 =?us-ascii?Q?mv6OFc1j2iITlzJi2L/unveOURlAityce8FDINEun1zAxu5Ad/Pg3AE5CZ7X?=
 =?us-ascii?Q?LtrjZCJd+C+1DrNQO/pIeKW1qnsMk7EqUjjV7V2sxzBd/idiToTbehneOGJk?=
 =?us-ascii?Q?XYAhPP6jkT4Ubb7UmyMOq52Rgjc9o9RXt0WHJdAWQJCm6JMI1q2yVWYE/3p2?=
 =?us-ascii?Q?sueKHYj02iJHrKyJsLmpj6jmdxKlUNE9jeUid8/qNLMLxdjvcRw++glfeJ1D?=
 =?us-ascii?Q?kZFAx8GA+qanqW1ucJetyjM5UYQBblhmaME5RSDA+WcWZfAIPufdnlxN4v5C?=
 =?us-ascii?Q?LBvKquDd+fUpL8w=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Ueqc2okj8yDHzDNhpp5xKYapzXg+Zow5C2IlmQZlSks8KpD9BGseMA/Yhst2?=
 =?us-ascii?Q?8pmqImrfYCgQBY3Xml8EmGz48mNcqZvZas+6UQ6VbHJA9rYlkzUDxB7DM+ku?=
 =?us-ascii?Q?rtNkB3klplA8EXA+3FJS9F7f4R8DaXD/3weqO9GRJICAhkE8bbAI8l8iCXub?=
 =?us-ascii?Q?ZTv6ZiCRXA2QgafjDOfEdgrRbw6PjJ3zRwKWsZ6jdxLV9SLWfRRHXioUtKuB?=
 =?us-ascii?Q?ezisUpXG4BCb6KFJzGbQdiq07M//V9W8bqBAmWDxR+0TzNNK1M727JsJVZWd?=
 =?us-ascii?Q?nd1sFYFeb6q/OU4zgMMY4FHLkp6WHmceziLJcFF5uPUetnkypzBjSbYIy0Vx?=
 =?us-ascii?Q?X5W9pcBm0swu7q4pZZDj+U0qDQOM7O/6jKc4Gqgdx2AjbYfAV6pHFBmwL0Ww?=
 =?us-ascii?Q?IKDDf3BpkjZERA1tkthTdtOCszuLQsiVQDvNNBweJtRbvwdkHdRpPaT+TMBp?=
 =?us-ascii?Q?h4RRWxyXPJzBcKmJHu1W3J61hxVmb/TFpppkWgPqaMt4lQluG9g/C4SeEV8g?=
 =?us-ascii?Q?+0pVsg7YwsqHm6roakmpOHdzZnCMmysJ5P1KscUyEbFrWTDDSpFSGyX16bXj?=
 =?us-ascii?Q?ienFjqLUl9rFMAuebSvceREYc4EOPnLpVDvpUQ+NmdVb1GKEukYuJSFVXqqv?=
 =?us-ascii?Q?JCD20++B65lydjowKW6w5CN+aVzx7bJ1hP67Ux37esjO2avbSAYe5O03kbo8?=
 =?us-ascii?Q?CeJr2J635/SZEhe1TFfszIs9GoXZHds/odWoLAlyCigkqXNtnWogg8OMwIGU?=
 =?us-ascii?Q?ie+Qqw7koYLINiaCYA09TZPHpoD2jQ4pSutQ8N/MxijtKnY8TFz8t6pEiF1O?=
 =?us-ascii?Q?NMUDVpPGj0/QCaMw2F52ZeZFa9Yf5oSGEPFFRWBN3oVt1PSMqtQnmqFx0Xfb?=
 =?us-ascii?Q?Sw7ILLnOpUsTut5ZzzUDzoZ+f1ewlWaiefMBM7qT0PSVazsBu0hChgoYT4TF?=
 =?us-ascii?Q?Xz50oFWlVDGB2gznbFAVFH1h/8mSTaWZQbVyCxos8egoI7qoJzF9NdhP5c+e?=
 =?us-ascii?Q?a7K8ohMkfFS8klEdVrejwrzY4qzQtHq/QvqqvOunH6RH3IiVjJKMCSVXpgjV?=
 =?us-ascii?Q?qnY/HpFd377oT8KHVkgk3J41XhPwlw0epKo894I6r4KizwchzVnIF2V9dhqi?=
 =?us-ascii?Q?qnmHPIMWDqDyIUk0Q4yM3BUpmmCMK9iN8r4Pxyf8PGRBs0ggrbq5adWTpVBt?=
 =?us-ascii?Q?S2ElzI/F13/Ke7YOJUqq8S6BgW3fYDrJQGIfqubyYNgYVaOtYiAmzOT8iH4I?=
 =?us-ascii?Q?rtES5hdCOvpzIjkANAg3vbEefry3BiD5rbDLMAnyXnYCT0BW6EVq72z87iGw?=
 =?us-ascii?Q?ObyV7wBcbhy3XjtVNdXzVcKfnfceqP28Sybw+7gjzwntj2CXVj8HZQOkpHM3?=
 =?us-ascii?Q?2qXFBq5HGT5jaW1bTHoZnfDPeTbZQ5u0uoVSzqvqoLc+QYBb88rAZIJdKfwc?=
 =?us-ascii?Q?HFEjy1YqqOUaw4ChDtOH9HJ64RG431qc+8iFDOKSITAw/u8jWVzAngaavAF6?=
 =?us-ascii?Q?8yic1t6WlhdMEuXhKd1M5Ae9MWiU/GnWBfR0Ir0FXUUKvxeHIUla+VL4VsD2?=
 =?us-ascii?Q?WKs3Bkf6nCrPCixHKi7nphWIiU/ncQiSQhE8VRPC?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04dbfdbd-85e9-450b-5609-08dd94575ecd
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 May 2025 08:55:12.9414 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 18ml8jmFGAZHtK4iZ2NC3+kgbtyg3P9y7A/sg8XGwPexHN1Ue4CfNKTjneBtUJIq9kmo6gOKpMYRrMV5GrEh5ygXvFtSwqfoq8CGEtUiCoY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4959
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.18;
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
>Subject: [PATCH V3 33/42] vfio/iommufd: define hwpt constructors
>
>Extract hwpt creation code from iommufd_cdev_autodomains_get into the
>helpers iommufd_cdev_use_hwpt and iommufd_cdev_make_hwpt.  These will
>be used by CPR in a subsequent patch.
>
>Call vfio_device_hiod_create_and_realize earlier so iommufd_cdev_make_hwpt
>can use vbasedev->hiod hw_caps, avoiding an extra call to
>iommufd_backend_get_device_info

We had made consensus to realize hiod after attachment,
it's not a hot path so an extra call is acceptable per Cedric.

>
>No functional change.
>
>Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>---
> hw/vfio/iommufd.c | 116 ++++++++++++++++++++++++++++++-------------------=
---
>--
> 1 file changed, 65 insertions(+), 51 deletions(-)
>
>diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
>index f645a62..8661947 100644
>--- a/hw/vfio/iommufd.c
>+++ b/hw/vfio/iommufd.c
>@@ -310,16 +310,70 @@ static bool
>iommufd_cdev_detach_ioas_hwpt(VFIODevice *vbasedev, Error **errp)
>     return true;
> }
>
>+static void iommufd_cdev_use_hwpt(VFIODevice *vbasedev, VFIOIOASHwpt
>*hwpt)
>+{
>+    vbasedev->hwpt =3D hwpt;
>+    vbasedev->iommu_dirty_tracking =3D iommufd_hwpt_dirty_tracking(hwpt);
>+    QLIST_INSERT_HEAD(&hwpt->device_list, vbasedev, hwpt_next);
>+}
>+
>+/*
>+ * iommufd_cdev_make_hwpt: If @alloc_id, allocate a hwpt_id, else use
>@hwpt_id.
>+ * Create and add a hwpt struct to the container's list and to the device=
.
>+ * Always succeeds if !@alloc_id.
>+ */
>+static bool iommufd_cdev_make_hwpt(VFIODevice *vbasedev,
>+                                   VFIOIOMMUFDContainer *container,
>+                                   uint32_t hwpt_id, bool alloc_id,
>+                                   Error **errp)
>+{
>+    VFIOIOASHwpt *hwpt;
>+    uint32_t flags =3D 0;
>+
>+    /*
>+     * This is quite early and VFIO Migration state isn't yet fully
>+     * initialized, thus rely only on IOMMU hardware capabilities as to
>+     * whether IOMMU dirty tracking is going to be requested. Later
>+     * vfio_migration_realize() may decide to use VF dirty tracking
>+     * instead.
>+     */
>+    g_assert(vbasedev->hiod);
>+    if (vbasedev->hiod->caps.hw_caps & IOMMU_HW_CAP_DIRTY_TRACKING) {
>+        flags =3D IOMMU_HWPT_ALLOC_DIRTY_TRACKING;
>+    }
>+
>+    if (alloc_id) {
>+        if (!iommufd_backend_alloc_hwpt(vbasedev->iommufd, vbasedev->devi=
d,
>+                                        container->ioas_id, flags,
>+                                        IOMMU_HWPT_DATA_NONE, 0, NULL,
>+                                        &hwpt_id, errp)) {
>+            return false;
>+        }
>+
>+        if (iommufd_cdev_attach_ioas_hwpt(vbasedev, hwpt_id, errp)) {
>+            iommufd_backend_free_id(container->be, hwpt_id);
>+            return false;
>+        }
>+    }
>+
>+    hwpt =3D g_malloc0(sizeof(*hwpt));
>+    hwpt->hwpt_id =3D hwpt_id;
>+    hwpt->hwpt_flags =3D flags;
>+    QLIST_INIT(&hwpt->device_list);
>+
>+    QLIST_INSERT_HEAD(&container->hwpt_list, hwpt, next);
>+    container->bcontainer.dirty_pages_supported |=3D
>+                                vbasedev->iommu_dirty_tracking;
>+    iommufd_cdev_use_hwpt(vbasedev, hwpt);
>+    return true;
>+}
>+
> static bool iommufd_cdev_autodomains_get(VFIODevice *vbasedev,
>                                          VFIOIOMMUFDContainer *container,
>                                          Error **errp)
> {
>     ERRP_GUARD();
>-    IOMMUFDBackend *iommufd =3D vbasedev->iommufd;
>-    uint32_t type, flags =3D 0;
>-    uint64_t hw_caps;
>     VFIOIOASHwpt *hwpt;
>-    uint32_t hwpt_id;
>     int ret;
>
>     /* Try to find a domain */
>@@ -340,54 +394,14 @@ static bool
>iommufd_cdev_autodomains_get(VFIODevice *vbasedev,
>
>             return false;
>         } else {
>-            vbasedev->hwpt =3D hwpt;
>-            QLIST_INSERT_HEAD(&hwpt->device_list, vbasedev, hwpt_next);
>-            vbasedev->iommu_dirty_tracking =3D iommufd_hwpt_dirty_trackin=
g(hwpt);
>+            iommufd_cdev_use_hwpt(vbasedev, hwpt);
>             return true;
>         }
>     }
>-
>-    /*
>-     * This is quite early and VFIO Migration state isn't yet fully
>-     * initialized, thus rely only on IOMMU hardware capabilities as to
>-     * whether IOMMU dirty tracking is going to be requested. Later
>-     * vfio_migration_realize() may decide to use VF dirty tracking
>-     * instead.
>-     */
>-    if (!iommufd_backend_get_device_info(vbasedev->iommufd, vbasedev->dev=
id,
>-                                         &type, NULL, 0, &hw_caps, errp))=
 {
>-        return false;
>-    }
>-
>-    if (hw_caps & IOMMU_HW_CAP_DIRTY_TRACKING) {
>-        flags =3D IOMMU_HWPT_ALLOC_DIRTY_TRACKING;
>-    }
>-
>-    if (!iommufd_backend_alloc_hwpt(iommufd, vbasedev->devid,
>-                                    container->ioas_id, flags,
>-                                    IOMMU_HWPT_DATA_NONE, 0, NULL,
>-                                    &hwpt_id, errp)) {
>-        return false;
>-    }
>-
>-    hwpt =3D g_malloc0(sizeof(*hwpt));
>-    hwpt->hwpt_id =3D hwpt_id;
>-    hwpt->hwpt_flags =3D flags;
>-    QLIST_INIT(&hwpt->device_list);
>-
>-    ret =3D iommufd_cdev_attach_ioas_hwpt(vbasedev, hwpt->hwpt_id, errp);
>-    if (ret) {
>-        iommufd_backend_free_id(container->be, hwpt->hwpt_id);
>-        g_free(hwpt);
>+    if (!iommufd_cdev_make_hwpt(vbasedev, container, 0, true, errp)) {
>         return false;
>     }
>
>-    vbasedev->hwpt =3D hwpt;
>-    vbasedev->iommu_dirty_tracking =3D iommufd_hwpt_dirty_tracking(hwpt);
>-    QLIST_INSERT_HEAD(&hwpt->device_list, vbasedev, hwpt_next);
>-    QLIST_INSERT_HEAD(&container->hwpt_list, hwpt, next);
>-    container->bcontainer.dirty_pages_supported |=3D
>-                                vbasedev->iommu_dirty_tracking;
>     if (container->bcontainer.dirty_pages_supported &&
>         !vbasedev->iommu_dirty_tracking) {
>         warn_report("IOMMU instance for device %s doesn't support dirty t=
racking",
>@@ -530,6 +544,11 @@ static bool iommufd_cdev_attach(const char *name,
>VFIODevice *vbasedev,
>
>     space =3D vfio_address_space_get(as);
>
>+    if (!vfio_device_hiod_create_and_realize(vbasedev,
>+            TYPE_HOST_IOMMU_DEVICE_IOMMUFD_VFIO, errp)) {
>+        goto err_alloc_ioas;
>+    }
>+
>     /* try to attach to an existing container in this space */
>     QLIST_FOREACH(bcontainer, &space->containers, next) {
>         container =3D container_of(bcontainer, VFIOIOMMUFDContainer, bcon=
tainer);
>@@ -604,11 +623,6 @@ found_container:
>         goto err_listener_register;
>     }
>
>-    if (!vfio_device_hiod_create_and_realize(vbasedev,
>-                     TYPE_HOST_IOMMU_DEVICE_IOMMUFD_VFIO, errp)) {
>-        goto err_listener_register;
>-    }
>-
>     /*
>      * TODO: examine RAM_BLOCK_DISCARD stuff, should we do group level
>      * for discarding incompatibility check as well?
>--
>1.8.3.1


