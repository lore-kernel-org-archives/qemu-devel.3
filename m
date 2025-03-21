Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E03F2C35FF3
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Mar 2025 06:26:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tvVpd-0000Kc-5h; Fri, 21 Mar 2025 02:26:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1tvVoN-00082I-La
 for qemu-devel@nongnu.org; Fri, 21 Mar 2025 02:25:04 -0400
Received: from mgamail.intel.com ([192.198.163.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1tvVoK-00031W-Ed
 for qemu-devel@nongnu.org; Fri, 21 Mar 2025 02:24:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1742538292; x=1774074292;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=zrV+J2g3BdkwEVv7JpCnn9Ib1p0eCUm3STW1ILcJAVg=;
 b=laNJwPQN0F/JdIQKXURbDz1Fg+oUttyorcKa9lAjn2a2GkoeAR0+qGFG
 lGU4OE/MCTY7cIzbdL9ADIhvmIp52OuFhqdxu0Hl9DoItwnH7H7OnmEdo
 RDhqIOJkt3LUJNrxcnNacp0H30IM5KDp4h59RXmMlX3RWm+lTl52BHYrn
 Lc8vZxwEv5CGHDiJUYr4kmv9g3PqjfbP4BIomAOskEyNe3TTsSy3rQ2xM
 W86Ua0PxZYINmeoi6hqbui2xjUIt+ROPuFTQR1ln4SgbuIxWrlj6v1N3l
 g68wAnAMuKN97X8IX+b8l1Edm7DTDYgPNvAB7J2V7umSI2a/aKHXnztw2 g==;
X-CSE-ConnectionGUID: NHW/kPloSoajYmSWc8NK+Q==
X-CSE-MsgGUID: 9WWkgXOwS+Wpyxb0ToJ4og==
X-IronPort-AV: E=McAfee;i="6700,10204,11379"; a="46548543"
X-IronPort-AV: E=Sophos;i="6.14,263,1736841600"; d="scan'208";a="46548543"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Mar 2025 23:24:49 -0700
X-CSE-ConnectionGUID: Tr5XEYNoTZ6yN8TzvcdUSw==
X-CSE-MsgGUID: 4bRNMTzzQaaUZUeuUUD4Bg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,263,1736841600"; d="scan'208";a="127997460"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Mar 2025 23:24:48 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 20 Mar 2025 23:24:47 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 20 Mar 2025 23:24:47 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.44) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 20 Mar 2025 23:24:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fm0r7N/zMSJpvb+XOPak3N3/8+R8+K3evHqgxZHitIo+j8SuntS9OqHYfUGNKpeFsF0xQL3cWCEqn6clPjTuTwPM3pHZ2MJtavoIXBCsT4TmhKI04P4hOLUvaj4T8dRTgqBRhxxyQcT75UzeMgWxK/RpjgkqSfzf/8hXUNDX88UPEZjNKYwAmNX4+NpnLwrJYlXZmttQXupb7imzNlqiOhQMynbXW5ihAbijUBabDBEFPSMN6KSsSgMZBcQ0t87rT1KP8bux6/KhHLgfJS2e4+togMW1ltOfveZ1IZ0vyKRnjsWksvdwAvtIqu4C96vl3GQs/YiUws9Jgq1QtE5ELQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zoiqkTyfZSNsG2Fpfuf8bsXzykcGUtfGQxgzGR+VX3c=;
 b=Xl8A9W/1f6Cq/+k5XtIi7/rY2gXebpyb2z3HRUQuRapf8G90py+LVE8rgIkIbVkl7PlLGaOLBRtehiNh5IdUO3GpAj0/beipJxMbuInI6FvNKxHz+K7mwWPIFpA9AkC8CckdxrnkNmD/MdonD5J4UXj47MEKCkQT4YlnD1lXnFUG7F+c4vVtWQfRo2NBdaEbsVtvYPhTu5vHEefZcabne9quyKJ3e7MrhnGMJ8HVWAmB8lJtN/YvjAoL4w8mdjh9+Y3CrtG9ekPCGW2z1yTx/84ixS3EPhAhXmMOA+a0GSV3sJDP7frof07kLwaNBGddc/d4Dv7TiBxO8qKwnC4biQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by PH8PR11MB6952.namprd11.prod.outlook.com (2603:10b6:510:224::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Fri, 21 Mar
 2025 06:24:42 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091%6]) with mapi id 15.20.8534.034; Fri, 21 Mar 2025
 06:24:41 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: Joao Martins <joao.m.martins@oracle.com>
CC: Avihai Horon <avihaih@nvidia.com>, Eric Auger <eric.auger@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@redhat.com>, Alex Williamson
 <alex.williamson@redhat.com>
Subject: RE: [PATCH for-10.1 24/32] vfio: Introduce new files for dirty
 tracking definitions and declarations
Thread-Topic: [PATCH for-10.1 24/32] vfio: Introduce new files for dirty
 tracking definitions and declarations
Thread-Index: AQHbl+v5GdaKalDSUk6u3PTGyZcGg7N7y3bwgAATaICAAQUpwA==
Date: Fri, 21 Mar 2025 06:24:41 +0000
Message-ID: <SJ0PR11MB6744DB06536F5A319946748792DB2@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20250318095415.670319-1-clg@redhat.com>
 <20250318095415.670319-25-clg@redhat.com>
 <SJ0PR11MB6744B94364FA17801C4C451592D82@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <fbc6f226-b4be-4f99-aea3-8a8342f6ee4a@oracle.com>
In-Reply-To: <fbc6f226-b4be-4f99-aea3-8a8342f6ee4a@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|PH8PR11MB6952:EE_
x-ms-office365-filtering-correlation-id: a5192588-47d8-4b9f-6691-08dd684110a1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?fTaXBvzplDlKFxc62qx5HPw/1afWRQfcEO1fJoX3EDn2OVNQk0Lt/D1txO?=
 =?iso-8859-1?Q?mUjPDy4GC1IjZ3qjrfqpcsvr/5x4SROHkLmFH5h4ESP2py9dARDYO3wUxX?=
 =?iso-8859-1?Q?xV7YOsTTtoc2XNw5PLgAlngO8elK+iigv8yaQtfxaoqt+YxUNq3KbNAAZZ?=
 =?iso-8859-1?Q?HhWS1yJ6RN3AK5PmF8rWXxPM8usBjHmIcsbLI0pTbg0b+P/pvgMph+afSY?=
 =?iso-8859-1?Q?7fJtwEH1gH7pVEgQLFwV7gplQRhXoNfl3Py1Fl5jCQfbDEOrYOLz/hsCQD?=
 =?iso-8859-1?Q?9GEZu1wkEuRo75a4jPygHiI62bQUWxA3dh1TQ4gQIT99Au4gpwX9hdB8VW?=
 =?iso-8859-1?Q?oYZh6WtlexiRnHFG2TOJQuaHmBcaRL3Cy14WINmLl0YZracE6iBWla2buY?=
 =?iso-8859-1?Q?n0PbOXuUAdzvW4gpnR94LDs7uak/5XaI3mlenBiQmzIN9V4PINwWH22w9x?=
 =?iso-8859-1?Q?QGh4J5/muPwiV4a/DqoVao1DjXAb1mqSyayPEseQCAIgUHqqifX/94Efke?=
 =?iso-8859-1?Q?sqDf4umRgA0bjQS90liI+1/pe0gbGVIhk4T07ru7xCmctCnO2tarTURMmP?=
 =?iso-8859-1?Q?rzn9t7/EA71+TfD2r+fVoqn5R9WvAScvj36lpi62LVRJ7+FPTmGksnxJax?=
 =?iso-8859-1?Q?RAFzLLnx2HIy9OGyUwu0VS0XJn8ewQENkTMq3cGJONgTHVztOTrlZ0/Suk?=
 =?iso-8859-1?Q?Ky1asF5NKhKY8jbWu76sdmbcDdUpcHb7LXthEvsvaFgo4sI+55ezrFj3DZ?=
 =?iso-8859-1?Q?Y46tYDYynX8tWxOF1GajRU9nJo/toXw8d+cmM39KlHTVTNmr9B/tXgkN3k?=
 =?iso-8859-1?Q?r0iL1KnnyE+HO2djdnSR/2nVgzO93NtEdp1Z5NWaIsVHp5wyLYbQNtMO9n?=
 =?iso-8859-1?Q?WST9PkrkZEpuK80NxqWc57vjvX/P5RRaoMA77x3rvqzuY6V98364ddcrO2?=
 =?iso-8859-1?Q?3qilcmgQPSRJA5U2ayNTbW9jyWHUp2jG7a3FnAXN8i7Zvs3BXbKoEsduKR?=
 =?iso-8859-1?Q?iAtcAz2DE4XEz+ZuETMOgjQ6PJpAwM0TSIk2g0GXfZ7/+oK3hmSpb6ueCK?=
 =?iso-8859-1?Q?cG33tJ3LaV1gB/Bsk0U/gUs7CpNBxHDp7sXKSjS9iooDFn8qmcimQqBqpT?=
 =?iso-8859-1?Q?UDeizur6lwUEeV+xOOH0FZlzr4wUcAramxincr2tiqToYxy1h0OuFZd49g?=
 =?iso-8859-1?Q?xwl6UvxPEkTlhrKcYLd/ATbzU07QioRwiKS+UeELynqWE2iQ5GejQZtCOx?=
 =?iso-8859-1?Q?rCoIZNYU1uBo+YFgnHccYGFgkJYN8CHYNaqpAknDZ9bLwyRAH57ZH+buhI?=
 =?iso-8859-1?Q?88cw36Jnop1DScO6z8FKXuYqhHJNwUdfavPHmDiDBuJc9EPK9bQI/vdtO2?=
 =?iso-8859-1?Q?J7H421XLK+mHagsPbieWFYFN7xAyoChonUq+UxZMG5NhUufmTaNgERORIW?=
 =?iso-8859-1?Q?AW2q5gMtNUIcXm1r26QNde3tB5jOwCCYscQ3RkZxnEqN3ZOJdg3FNYM6R3?=
 =?iso-8859-1?Q?5oOt7wvGEQ1dUJ2Offr+q0?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?Z7Bga12EpO719N/wsnA1Ps1+AhiYr8pteR/twzKPGlFAE8dKw45vz2yWPx?=
 =?iso-8859-1?Q?758qfVfyoYI3myLCHUYsOVAHpITF/bbonftEeGUgpmvIrX9YdV+sHVLhSC?=
 =?iso-8859-1?Q?IkpjFXXQDykU6J4J7RgVfmwhVcFlPlrUxferz+bdnxOvE2X0WeAuEOIfy8?=
 =?iso-8859-1?Q?rOIVHwdH5rMCAktaGJ4cuDvol2CV/pJS1CvJW9uT5IfsCtGMV1KxPQbZg2?=
 =?iso-8859-1?Q?hmJyOGkzHq71YSG9O/tR9xCq5RDH12DC4+/xOekQO7T2b0UdWhWe2oal96?=
 =?iso-8859-1?Q?mJ5J92MxDBwua/6tn8ksNgsoGxllknbwNRjiB6pxUB1Z/qe3aaOPhBELwY?=
 =?iso-8859-1?Q?Sc6fnwZk4u4GfIrqa4bYgsafqPZE9OvDzfwp/PD5kjR+HnAuuh+1Sh88c9?=
 =?iso-8859-1?Q?aj5jyTgGB7HTCfADdZrO8AIOgcCOKoEbum86MiDlth8PtQX2jjWKtyL5Pk?=
 =?iso-8859-1?Q?hidEInHzbZRyDJoAkLfGCGvMa700Y4zPVa9woWKIymC56E3/uu756ITR19?=
 =?iso-8859-1?Q?mAarlRUzBRBnp8xJM/bqvvGP1JQ4kUz57JfD5zCcA4tkmhnA4cfIQzQlM/?=
 =?iso-8859-1?Q?dOJQmCwvrLvv4D17Jj8d864XEU3cOeblk2dYsv1/dQS8yXlg28o9Uv4Anb?=
 =?iso-8859-1?Q?1E6stWTCthYmGbbqRjE+czfkt7vdHgp/SccDRfpcuiAGqS1coB+BKcmVkC?=
 =?iso-8859-1?Q?mPubxnquCB8zZURxtqryuTSpWx5rLWg+vD9T9p2dzkqpLA+QLbpDZHxoST?=
 =?iso-8859-1?Q?/ats2KyAmptlzy5t4n4N7kRt2QCOQ3fPb/RQ6G+qfIPbMjRWTvawR1tMSM?=
 =?iso-8859-1?Q?h1v/u0aYaYlMl9cJMgRUEFpOTWDYDIWXlZsE28afaMSFgmoB8m9Nu/pucu?=
 =?iso-8859-1?Q?zQLN40bVctVTeJqNUK6qt+/2bQvI266/jYt0gvd+xnsHLAY38hBr8/bjua?=
 =?iso-8859-1?Q?J4CPmHiiJrZYWVytfV+c7n69/A8o6hgAVHYDTlwBw97uFwT3Vn/ZpHLVkJ?=
 =?iso-8859-1?Q?k58YCBmF5JHsmzwo9mc+0skxL+tAwflvbHtjYKLa4W+5hJt5/dIH3MQc/z?=
 =?iso-8859-1?Q?R/gjZ8EE3TdaP+ZrNKphgK0NIjefRhZc3krmFqE0Koo+1xlS/GyQQ04MTc?=
 =?iso-8859-1?Q?HD+U4B0bc4N2K+SJ630MKp3A9bjIQGhAHxwSsh/Ra2Sc0eyMz7ZGT20OYP?=
 =?iso-8859-1?Q?nByr99LIu7+uQshyzjoXPNLP5oo3GSlUgoeskBkKT0/tffJsG/9BPU4IQQ?=
 =?iso-8859-1?Q?7SUCwJcersgs2WcPj3iLENHilDRhblrjf5Pqve/8wgNqUj2lV8On+ynGOS?=
 =?iso-8859-1?Q?//0AeITxgsourovy0qGof+wyBrPOtTxTIfWmDiIFnt5D97r0nEORspWin2?=
 =?iso-8859-1?Q?sC76eppkTaqCp9LVGKmHRNNe629r70nTAIjxbV1i1qTe9RtAzInNcyAasn?=
 =?iso-8859-1?Q?DdObrXMbahWmmQOCss1R8Wk/mzOkZbEvaw7qShfy7OGZRHOjljE7uhleat?=
 =?iso-8859-1?Q?W0F8GJrnGJ9qLxLFj1/5Y6alV72+Un+9qz7BO1JwI1f8SVpoQ5lLcLg/hu?=
 =?iso-8859-1?Q?PsgCGvrvnFE4AAuXt+KkcWuWLiTMCEHqz1BMfltUANXfoPGNioTOihVSX4?=
 =?iso-8859-1?Q?uTOpYg9AI7TngWmJGDCXiOmGyNybCBiqtb?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5192588-47d8-4b9f-6691-08dd684110a1
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Mar 2025 06:24:41.7359 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZA4MSapm1xaFMhK6k8GEnJqWM7xtvTS96lvgWssqyTSU+5kBmQmK9/fwgWoQ16X1LyDgwiddU06YoS5scO9hI0ZPDbWqkuSNsWd7gZpAw4M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6952
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.13;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.332,
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
>From: Joao Martins <joao.m.martins@oracle.com>
>Subject: Re: [PATCH for-10.1 24/32] vfio: Introduce new files for dirty tr=
acking
>definitions and declarations
>
>On 20/03/2025 09:52, Duan, Zhenzhong wrote:
>>> -----Original Message-----
>>> From: C=E9dric Le Goater <clg@redhat.com>
>>> Subject: [PATCH for-10.1 24/32] vfio: Introduce new files for dirty tra=
cking
>>> definitions and declarations
>>>
>>> File "common.c" has been emptied of most of its definitions by the
>>> previous changes and the only definitions left are related to dirty
>>> tracking. Rename it to "dirty-tracking.c" and introduce its associated
>>> "dirty-tracking.h" header file for the declarations.
>>>
>>> Cleanup a little the includes while at it.
>>>
>>> Signed-off-by: C=E9dric Le Goater <clg@redhat.com>
>>> --- a/hw/vfio/common.c
>>> +++ b/hw/vfio/dirty-tracking.c
>>> @@ -20,14 +20,10 @@
>>>
>>> #include "qemu/osdep.h"
>>> #include <sys/ioctl.h>
>>> -#ifdef CONFIG_KVM
>>> -#include <linux/kvm.h>
>>> -#endif
>>
>> It looks this change unrelated to this patch?
>>
>>> #include <linux/vfio.h>
>>>
>>> #include "hw/vfio/vfio-common.h"
>>> #include "hw/vfio/pci.h"
>>> -#include "exec/address-spaces.h"
>>
>> Same here.
>>
>
>It's written in the commit message:
>
>	"Cleanup a little the includes while at it."

Oh yes, I missed it, no problem here.

Thanks
Zhenzhong=20

