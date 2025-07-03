Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EA6BC8303C
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Jul 2025 02:44:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uX9uf-0008W8-VP; Wed, 02 Jul 2025 22:43:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uX9ud-0008VY-05
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 22:42:59 -0400
Received: from mgamail.intel.com ([198.175.65.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uX9ua-0005wK-Jx
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 22:42:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1751510577; x=1783046577;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=m703LDRoUw1YJyz8pIrQPZdkp7hHRdF7+VNARz8Y8Z4=;
 b=GqtaWlc3/WrfK9O5yVkx5aYj7Yb3w+iAe6Uy//iOf0jTyYY3leqq49gv
 UvrKz4RsoUhJ6Ukflv2OdNMuujyaKLdkjd5LKfmaULbRoL4Q5AL4o/zlv
 kdHFLj3O797fHT7if0m1DCHkLA5FizVgcQnaPyT9S0poowCD3fKIjiAL3
 B7C5jwvl6MG5yDjLP+0uSBzs+EKepa7mQTPH0zjwV4IfXAslCuv6taRUb
 7dlU9zqb76P4D5AFSqBwWhw/vptHGDkgzBw27x3pSXrqY6Puev10Y6058
 jTOMHLwuLGJLZnR+nx5Zs709waGMCre7+rcLl7ZsLJSN+WWOJvchrX3A8 Q==;
X-CSE-ConnectionGUID: kwf5mMZuRrOk9N01OopE4Q==
X-CSE-MsgGUID: MWQpnbS6QU6YdEzn9d5GdQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11482"; a="71258268"
X-IronPort-AV: E=Sophos;i="6.16,283,1744095600"; d="scan'208";a="71258268"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Jul 2025 19:42:52 -0700
X-CSE-ConnectionGUID: XlKFi7UmSeC2lMR0M8d01A==
X-CSE-MsgGUID: KonGhQYORwKKySq8MsKLwA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,283,1744095600"; d="scan'208";a="158805579"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Jul 2025 19:42:51 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 2 Jul 2025 19:42:50 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Wed, 2 Jul 2025 19:42:50 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (40.107.92.76) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 2 Jul 2025 19:42:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jG/Ec9tWTqqCy7ybnL+sIRw1K1UVEZJCRdekz0lV2zRbcBtawBY4RV3gju/wL82J56/evv40w0388dBFH+qmq67mXMBrxfEQjnucai1TOqtNIbtCrlRtr5G+sJS6Y/aHX+cQyksThCXsOHl/oZWNJFZZZ7mQNRqjp6PWVfW/yqs2mXZeX8RelC1nvezZPF3ZsCSEZ9yvmm+1Gmyv8YnxEiyfqCuWtaypXi3Eiazp5YZj6x/6LsR/FOcba8c1ZvZSa+7oNPJNSx+i06ffiU4dDI/CQrXKJR5GY3cGJA1JneaLNFHoaMjuLKFz7vtJk56O+kxpEXSnL5FmITT/XgNVWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rKAbG+FzzK25Cg/aCyU1q3of0ell9lJhe6BoXUdq3M0=;
 b=ScCgYesZrYtMni3nCPmCR4Mp157SsfzOLAnjQLS7w0zmLTDgExvTF2xGnjqJpb812+EqE848j5MhcQPsQWNGgINRDWSLsUM7LQfaA4G/0NuCXngg9RaP7CDwcIKj/O6gXGfBLgFOBFZpcsSeCLIAz7fxGgTSQJbQhVZ5+GWiq3RGvM6zXGwnLodquPizuNpOek9L9mGAgIwosGeTHU5QmtzuIuY4rwgvxN2Wtogwqj06SoDtGllyJFD01XKHwxCX7i2R3VOg9tJcvpr0dgaKH27Oo18mlgBhxvitrnVV1IDK+0zysqTgbAQKTl9IFub/s6L6V6yVz85dKZbCPIde5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12)
 by PH0PR11MB5061.namprd11.prod.outlook.com (2603:10b6:510:3c::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.38; Thu, 3 Jul
 2025 02:42:04 +0000
Received: from IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13]) by IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13%4]) with mapi id 15.20.8835.023; Thu, 3 Jul 2025
 02:42:04 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: Steve Sistare <steven.sistare@oracle.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: Alex Williamson <alex.williamson@redhat.com>, Cedric Le Goater
 <clg@redhat.com>, "Liu, Yi L" <yi.l.liu@intel.com>, Eric Auger
 <eric.auger@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, "Marcel
 Apfelbaum" <marcel.apfelbaum@gmail.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
Subject: RE: [PATCH V6 12/21] vfio/iommufd: register container for cpr
Thread-Topic: [PATCH V6 12/21] vfio/iommufd: register container for cpr
Thread-Index: AQHb65yQqGVofVEyX0Wg2D2EtYt9UbQfsJqw
Date: Thu, 3 Jul 2025 02:42:04 +0000
Message-ID: <IA3PR11MB9136179B9376D4D1A5872A0C9243A@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <1751493538-202042-1-git-send-email-steven.sistare@oracle.com>
 <1751493538-202042-13-git-send-email-steven.sistare@oracle.com>
In-Reply-To: <1751493538-202042-13-git-send-email-steven.sistare@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9136:EE_|PH0PR11MB5061:EE_
x-ms-office365-filtering-correlation-id: 2663b9da-feec-4530-56eb-08ddb9db31ce
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?h44qvH9fvUv/kMCZHeTR0AzgM8eR84sKRX8XtFjOARWN+wmaWbTDup6OulGh?=
 =?us-ascii?Q?68HIk1cR/Y1faDVYGynHhN2YXZwCBP2oXfUi4K8wkIZ0F/jmFLxdTNrzaBEo?=
 =?us-ascii?Q?xqUFuN68P6MAxBix837PkJAAT1V7rTCDOm8GHR7nd5evEsHetwZWtcNiLTNG?=
 =?us-ascii?Q?7hKIKT9oEB+r2P7woxd2aAv6IeewsQdNB/6sYTEFrhRuC3MD5J+yreLZc/fe?=
 =?us-ascii?Q?8P9bfDPzsonVng2JmqKu6+OVFm7q2Ze5dYxhQRNu0HAxh6ntQn98UyG8aJdu?=
 =?us-ascii?Q?Wb8dGDwwsYCWtwCdSBDUeUTzGWuurcrQ6iCfMwDMUM5d0YaC/CVI5oSzSyY9?=
 =?us-ascii?Q?+hwZaP/QchYvhzNvka4PeBOLLI/J8gfjkIUaJTdx+dBVryxBBNHhd4ANsjon?=
 =?us-ascii?Q?ZQOITRkpB8z6xHmLEd2M2jX37CvAJoLM9JBbo0nJUlfSAmiqaT9Z/TRKNg5P?=
 =?us-ascii?Q?zISTAaIBomBoDIRQsKw0Z37yocWnhyCpdUVPbfhYkiOh0uXam1Yu2lKafGbp?=
 =?us-ascii?Q?CE+2GpuVmrwgUN4B7EakGcXi+fu162vTeggGpxRBlp4oo/Jx1N0+noJgUUcK?=
 =?us-ascii?Q?UxS2bDL5VujwUySxvnf443uNkhK7UwjlmMJbRpGRcePbmEUJ6ITiDsCIkgC2?=
 =?us-ascii?Q?3GeFweKAQMdamCd41oIr0P0hh+V/fQxgMyvNkntzamCWit4lrWMeHHRcIyHN?=
 =?us-ascii?Q?4n6iAnbOikAs8wrvSv381a/h0uLVpBiH0rnraq1xx2RVCfMz3swKrwQTtRai?=
 =?us-ascii?Q?1da/r8+b/zJUPGO0P56yiPxu+ZZu+2GANopAJ/Q99jJyOIe/IYsJ4rjtF1pz?=
 =?us-ascii?Q?3pZ7OjzXsrZ9aHVpMKTF2vlj1VaNjvyorRI7P31tVGJglf1bJ1mMQlpEHM7i?=
 =?us-ascii?Q?DkYcIeJpwAjog44ZbsUAfRrwP5yKciJ4q7fMK3ALPKLVu7BuznaifyiTQKfj?=
 =?us-ascii?Q?azJDdTFnwrsPzl109jB32noPuSdMRxqCJ2JJWvmRuRZ0Ft3/AEiehomCF+3b?=
 =?us-ascii?Q?d4/1OkbyoVWy6YowEQJrcIr0IMsbNu6ZhdV/67hgb4vkLYev4v0tb1sVRC5h?=
 =?us-ascii?Q?tKVkrv3Og5DmGTpPHClwybPCdC/x6l+n9yrZeg3Z7Z3OnSsusrOvzHOhU+I1?=
 =?us-ascii?Q?uc04dh4Ifag11mwjvAhtOmbqrGKAahBnT69IMGmSZXgq+vy03IIDe47vSu1t?=
 =?us-ascii?Q?ZSYPbY3IzcN5fX+qHg9J5+fK1jg7YSTivd1glWZDP6tNCHGHx+bt4aBiQbGU?=
 =?us-ascii?Q?EvUJsCKZyk9UwEZspNGd2ktGwULrBVLaPi8mK0VyishwNhiaVCsXTRUhMogO?=
 =?us-ascii?Q?jgsZGs34lfINkMjQnT2QxdKZiHQShnPcbghyWLcb4JTLvOMLBBGsH6WZ/i/H?=
 =?us-ascii?Q?xoSXZ1sJW/NT+ileEH9TUkQjYXZl9LS+1xgjLqdHxmZG+LeAo27S4B/63jD+?=
 =?us-ascii?Q?OZprsr0gImSgqo1jGc/AYA+Z7jm8PkYA/Apexf6rXnYvoygw/lWzWdTgTinl?=
 =?us-ascii?Q?8ydkkLubOAhfAsA=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9136.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?iiEg0Llz7s/RzlR0OXOcBH4ZoX9fDzhZ6LoTkyDZy1GvsZD11KIdzRUL6v5N?=
 =?us-ascii?Q?RlVd/7IoKpKYsvuYUp592A7hfiwSJhJVR4eTGVJMO8vfqkegqqEFGO/pjijx?=
 =?us-ascii?Q?ove8/jabahftNrLfVNCg2FYAO58erY8u/F/92gS6/R+rtQpMBAdw0ov/Uw2/?=
 =?us-ascii?Q?BpA2SjsIHXklo4sFAq5aO5EkBCgdxM/ErLEmAXAnpkQ1qVD5EL07gwA0uCAz?=
 =?us-ascii?Q?ZTwBuG8dmFzlwJ3tkuDKAb36M0c0YhRe1GZmztezkfSnSzO5IL+CP/pTNqsy?=
 =?us-ascii?Q?JEEuwfwmZMRkhkH68hmPvO5OGSAtBmwp9HRBz+gm2FaAkNr8hiJkoSD3FXSG?=
 =?us-ascii?Q?ur//Qg/Yw3KT1DKRUsSSuM861gxC5DcIrTaUPTTC71OqKFeMtaPf+xz10VyF?=
 =?us-ascii?Q?vYGXjvUSxFG5RkYLmjMx7jpXSND+L47/fDMsMWvoKIbTec3djTNqrDlVC+SM?=
 =?us-ascii?Q?wsUxYYqyaZJTVxPtTx/Qz/mfekJ2m4ecSnRYFWOR91FRWlDr9eqidTyJqzK8?=
 =?us-ascii?Q?xpX7KaXv2UmG/+kyuugzbWik6M3EWGBgwi5b5/qHKj+K1jrV8ercZjsUato5?=
 =?us-ascii?Q?N0Wtecqdpk0LXM15mF2n1gRJ0q35+VKFlj0O5F7Pv5KVebaUJDOOvVc3dfro?=
 =?us-ascii?Q?ycTxE/7dcLO0/odt72TlFCggDfU+xzhVveTdQBCZfD1hkHp9oOFmfQIJ1wjL?=
 =?us-ascii?Q?8IEKMS2vEOqbYB3UBnh9d8K34RNKxLRy9EnhR5Qw0ijXelaLNk8hwSI6xTr7?=
 =?us-ascii?Q?vs0Y335qQhZrHsxSVoonMUtCCxj40EQ+I9HFT8JbzhazplC3JIUWUhxel3ss?=
 =?us-ascii?Q?O7+q8yjpiqOdHNmmtLpbHCOs2dh5S/HM3q7ujjlqcQqRewEXqUFJDdOFG2NI?=
 =?us-ascii?Q?44qgN/o3xJyNR7KzrIo2NDzp5runoeC1BnYCZ3M2SvERlUjOzcQv6TEHRrD7?=
 =?us-ascii?Q?LJWVogAXxSt0vkj+gIOVEvhbDqssvLpPBkVXXCET1jshPCzwRODVM2sJ63SV?=
 =?us-ascii?Q?LUnPIaSTc8wiQF/QWqBKzVxRlagQUJjH2H4GGLffJx1/+ye03RVLZXUYKnex?=
 =?us-ascii?Q?T2lmRnfp7Gt5LTJswO5MtA83c8hC9OAWl+/6L1yoyYWVOCcQt0fMYPijBd+P?=
 =?us-ascii?Q?Kt923BsaUDITekBG3V1IOm1HxSMhIqrLC6cR2pLb0r8e8s7P5U2b8BfkKPd9?=
 =?us-ascii?Q?tEKex7TdrWXFzHxv5yU4O2vxzBviICEzscu9Z+kyjeFnWO/wrSWkYsX2W3h8?=
 =?us-ascii?Q?XCu4wOr0cuU822Z42aC4AKXXDYTFtJ0U6XkMzlBh3f+Et1OAW3cSC2/OMQXk?=
 =?us-ascii?Q?oswHRkEIKTSRmFGZtw/qpf4r7+9J55HtEiTHOBgQBxsRi0hHx9VoR6b1PPxx?=
 =?us-ascii?Q?MDfvCNxhYNWw73hQcIN8MvX40lUSyJ6cPHWCxPK1WVnoNlvWhyuu8FSq+dJ0?=
 =?us-ascii?Q?yyf7fCIyj7koWCVmqi+t0HkYBUAKqgYfTeZBiOtFeHaHztsntKbPj9vbXMT0?=
 =?us-ascii?Q?w6DPzqHMs4JOXyGR7n6GeDQUMfxvDfhcSpiA5qf6W76UU18w7WHjVA2P6/S7?=
 =?us-ascii?Q?waWV6qhdtWdgByO39oBq+Px4GHEivWR/rMkf8GuX?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9136.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2663b9da-feec-4530-56eb-08ddb9db31ce
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jul 2025 02:42:04.0965 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wI/+ZAUKWqk9peoQfPBaC98flSwm2nCNkAx9OnOoWQV54LNuu0A+9jMAxDinGmMIfp6Vb78HWO7BJ04pJUwmUIbpIV75VtwVrDViRTDjZX4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5061
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.10;
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
>From: Steve Sistare <steven.sistare@oracle.com>
>Subject: [PATCH V6 12/21] vfio/iommufd: register container for cpr
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

Reviewed-by: Zhenzhong Duan <zhenzhong.duan@intel.com>

Thanks
Zhenzhong


