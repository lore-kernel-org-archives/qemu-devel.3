Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C82A2C3DA5D
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2024 06:30:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sVmYH-0001xL-Kx; Mon, 22 Jul 2024 02:29:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sVmYG-0001wP-9r; Mon, 22 Jul 2024 02:29:40 -0400
Received: from mgamail.intel.com ([192.198.163.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sVmYE-0000nh-3I; Mon, 22 Jul 2024 02:29:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1721629778; x=1753165778;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=dsy/8DyiBMK6HXE+PG732ES8LkUP6TqegC6uV/w7N8o=;
 b=QvDmnk0HH3qSSZ0xO/B659TgjTzvPCYbSyZLwszbOl23/n7OF0BBt1Vn
 CA/TYZtiw6nn0Iwwde4XZXJT5jUvZACv6zIGHqUFjMBaQ0U0i1NiPSdT9
 SqAiNLXpmahOCJFZv4QqMEn2pRFoORjEMp2V3h8M2f9r6R8rcneNjg2mR
 uJXTC6QWSJSfiKv8ckc6et8OCeutHMED8Hc1ROJb78r7dG5s2hVf4pRkX
 s6ZAZU4gB5JmaAWFN4WPMpP4dsZz/UK2jk5tqlFlIE8wNMk1kpOMHh1g+
 FP2yPUkyMGnQSGfjtw/KMrCYAXdvmiYXKz3+PGfAj+FGTZic8o2DbBxGi w==;
X-CSE-ConnectionGUID: nBpkm4iRSACrHrgpYxkl9g==
X-CSE-MsgGUID: XZHBERVySd69sZ28nh5WCA==
X-IronPort-AV: E=McAfee;i="6700,10204,11140"; a="22081782"
X-IronPort-AV: E=Sophos;i="6.09,227,1716274800"; d="scan'208";a="22081782"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Jul 2024 23:29:34 -0700
X-CSE-ConnectionGUID: 7do6Qn2JTJeMIZ1I8WuhXA==
X-CSE-MsgGUID: yrz0CyclTdmJqjAlYqlPpA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,227,1716274800"; d="scan'208";a="82798799"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
 by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 21 Jul 2024 23:29:34 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 21 Jul 2024 23:29:34 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 21 Jul 2024 23:29:33 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Sun, 21 Jul 2024 23:29:33 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.41) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sun, 21 Jul 2024 23:29:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nHP9zrTZMFxH7mekkfGtwvjpdq/96Wybri8PjcTNsaB4g3qOY6XVOQ2InBhYVlHQ1WvsbNLUslP80nX7tOGccSnTtYuqqMprg/2q8nqlDL1cIkjCIuK7vhgHPXNX6Zo+ClCni+IhV5OxPAo3+TNlk82hC+hNkhMYj9dDbgdDqbNoRedRnasrwHzRHcnLrxSLeO8+nmSaFnt5RslPc8bLvln3byqtnBUI1c4BeR189WfhtDH0pbu05hyn4ApO/8AsNw+9pOOm2b5jhQBgvxrAShmbVXk6jVWdpXrZs0nSOT1DvnSZSyZZVQt8xLYf/Sm6f9L8jWQnWdzCmfPJhlyXvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K0Uy1odcRJCmcTJJ5E8tqMAGEQwyjqNOfROvImNdWvc=;
 b=gVG20mgZ558XImw1jQas4ujg7AUZuYXEMGtke0+YpWr2bGRtiglA26UswmmME5l7V67GKPXQTQISi9m3/4PgLRrUnlUxsOZSRr4exdWh5t3JBVEnDVuZzq26xJiKKRi6EMbOkuH6t2My+TTUNdUk8QklnKWDnrGqlRtjKSe3KRGUj6o56WOq9lJD5Q3Za+Q798kfbgMTlab7QVZnEyM1LP5vWHbNcMk0vod2IwBGSAj02VCNSgE1pZowTVapVU8nmBIVHdALOhEh0/8HGAM+zSz5DemWw+/hFUHKU5rseoRbJhuaLW52bsn+LLyMYB5/d2VLQZ/y068szQtd9x+8iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by PH7PR11MB6332.namprd11.prod.outlook.com (2603:10b6:510:1fc::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.35; Mon, 22 Jul
 2024 06:29:26 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091%7]) with mapi id 15.20.7784.016; Mon, 22 Jul 2024
 06:29:26 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: Eric Auger <eric.auger@redhat.com>, "eric.auger.pro@gmail.com"
 <eric.auger.pro@gmail.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "clg@redhat.com"
 <clg@redhat.com>, "alex.williamson@redhat.com" <alex.williamson@redhat.com>
CC: "yanghliu@redhat.com" <yanghliu@redhat.com>
Subject: RE: [PATCH] hw/vfio/container: Fix SIGSEV on
 vfio_container_instance_finalize()
Thread-Topic: [PATCH] hw/vfio/container: Fix SIGSEV on
 vfio_container_instance_finalize()
Thread-Index: AQHa2fvh05Ju3Vbn6EalaS//P5oJ8LICTPvw
Date: Mon, 22 Jul 2024 06:29:25 +0000
Message-ID: <SJ0PR11MB6744D7BCCE003ED0AA91841092A82@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20240719165011.1751831-1-eric.auger@redhat.com>
In-Reply-To: <20240719165011.1751831-1-eric.auger@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|PH7PR11MB6332:EE_
x-ms-office365-filtering-correlation-id: 0d5678d8-252a-449e-ae08-08dcaa17a216
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?rKBUQ1G0oTOFw1AAO3360DPjl1PAZb0QPsQiZjzYxauu9MOgLtNNPIAeIi43?=
 =?us-ascii?Q?0dyKgHCyBrpmlqvdNX1ZOmpTAUtI7dkA4ML2uqjJQxTovKiNNCrmAWVdwEN7?=
 =?us-ascii?Q?PzpzgK1f9+7N/bA9NdFlH2X5cVlSJh28/U+HhVW4bzuTLOT39S5zpFv6ubhX?=
 =?us-ascii?Q?SFNaiRRT6/2esRDp68wZEC1qys9dJG7ry5GQIAV1FLVdY6xL0/Imuo7EPJQv?=
 =?us-ascii?Q?Vt7De1f/JKKtJ2zJ+7maLBQmEzcqbDOtUKkHbnsrWwy/TAL5v/oT+PQj7yrK?=
 =?us-ascii?Q?u1t72IdH01i8yAuXp1VBYKl1bCmn5D8DHHJOlUPOPRdCce1+EPvnHoqDTacp?=
 =?us-ascii?Q?MH1vJjI5n+9Y7SZc9KCYP2UCqPHB4H3ODJaVdYovjN13E5w9OHXDMqD6HgJi?=
 =?us-ascii?Q?4gfHYk+zZeYBFx4QVi7kg1UIvhquym7JlmU/PGG8pFYyNfZzsz24SlcGJf4y?=
 =?us-ascii?Q?fZw2rUCjfAxtXcIERFM9i608fE2vYyieRcTZaUbwacZormwnCD7fmD/NQ0ro?=
 =?us-ascii?Q?0pNfnaOwOGAffNVX1MSrZRukfVJp4tDmCwBN1v8SIi1R0GyEUFCp9S0Ka1ZI?=
 =?us-ascii?Q?EsX/0zmOsFSk3XXUb7fdCWpK64hlOMVwb+q9msSewKjkYbKFET1D+3nxN3ap?=
 =?us-ascii?Q?PQ7MvBPnK51mtca4pMgNu+f/zd0n3TETeFD3ru6eMeyV6CELsh+N27KXWsvX?=
 =?us-ascii?Q?md4Z1VcQ46RFP7239FSR4fMYAHR48cK4UAj5IGDa+wrt/iiI9R5gktCyJnI+?=
 =?us-ascii?Q?FuUiOdsb1ccr999yIZ/XYlLIMmXvg1Axq+oMrNGq9upGNN6qF7PWqIshqr2l?=
 =?us-ascii?Q?SeFhUxVuIXQHyfAFj0mP5WDpVJQK6WLDrlshSeK4Qi7jq7rsMW3PvOrBW+QR?=
 =?us-ascii?Q?GSbpzTjjhD1bKvcZYi6hsRP/FEiPXBB/RTsLKSx0Xanoi9p+96H65q6+Bdds?=
 =?us-ascii?Q?YWUn/F4fOG2eWtZQUSgndeo+etAyp3Feesg3JHCK8JNjmjh0B7yu6QVowypi?=
 =?us-ascii?Q?kJ1sOoWRbvXskJ7+N47EqCrd1hT9edrNGywYvX2DZVCQuRdtke8Uql77DP9l?=
 =?us-ascii?Q?xK/fJCbTsy9uGmsMglE3e8V+EUV3rjaUuq8AJNltNPg3S7cbLczcNdn/3BpA?=
 =?us-ascii?Q?kbSeqgKFttq9A0acy55Hh0BCHagRpg88CVxst36gt4asaGDVPM/KPts3a9yD?=
 =?us-ascii?Q?V9uFCiUv4sRfM7tLPxQofWfHa5MwGA1skGJR2FFxOBH4M5wveyRwweD5ErSU?=
 =?us-ascii?Q?aW+4bAcjlrcCh5bMOZ3X3x4uInFF5c0XVhr6QkUe63rjnlcczH++Fms8R0cq?=
 =?us-ascii?Q?3EtzyjeeXnJGxsYOPXAto4HxOM7rcsxcvU+2qXFbIXFXEVfHGEQpqj1RdIwN?=
 =?us-ascii?Q?xDxWmOdgMOfJr1yuGP2p7g4OVODwhJ4fSjVXP2bmlNqW8muM7Q=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?BTgtjrx3uaj8vf7zFeBeM0mnuMtN3qH56D3udKVJXPDX5yce076GxN04jF5z?=
 =?us-ascii?Q?JtPWFH7B60P3c8irKs7dhuunO2UA0pt56QO3DTeBRL+0EWKFkqFKKj3PcITY?=
 =?us-ascii?Q?cE6B+Rvq2BYDDt4v9bDioBktyG56A7Yeh/1jWXeu2/jqvmoOHyDd96Mp/hdV?=
 =?us-ascii?Q?E0urwNMcjJejX+UA3Ya4GGyniFrLuQefe4y/rMzNHceXRTQ5XbcKBtj/Lnwe?=
 =?us-ascii?Q?RW84w9A2GzXz84kwJBE2XKtUfi/23HU8o+Sg3LF2ckFX6wFKalG9VSx4oWy/?=
 =?us-ascii?Q?8vkjL3Y0bVuzqvIowyNJikxVp+uLh8YP9+Yp0lgVaqB1Ai1nFVMI5XEp5CIz?=
 =?us-ascii?Q?rZq7/LcvBpIoqFtxgjs/THBO2FCjB71UcYYHff7xwb/XmYrdoG030NlmsS7y?=
 =?us-ascii?Q?jL102Dv4FE1TBlNZj1jw76P3DR+kvaekmp46fd5C3+RBu8/GA6mEMlHYaQdE?=
 =?us-ascii?Q?j8TtCp8m06FZM3vVg3etRp8I91xmrfYWBR7D4oiqFQ2h7zJsexkz2NQ3n0zi?=
 =?us-ascii?Q?JuC20BNeF4c023/5s1srp9uqDeCRE2koPATQ9qRkjp/FiGgPkaWZlATs6y5b?=
 =?us-ascii?Q?3n549F7rVvAWQRGyzoEdaMTcG4RhDh5bv97ZjAYh/0hPdkdAiuI/RPbJIaVM?=
 =?us-ascii?Q?HHnjwHr6Aw0ckpycFueWZhNBflXBzDAWdOXreRsFiAtcd4/3Lezy6rMShuVG?=
 =?us-ascii?Q?SFRhwzD4iTK52hG2PARW4CKo4LVMjrvgB+HTAP7TEVumk/epkm0grhR6FiIx?=
 =?us-ascii?Q?JLN8nxXwwx2wUtvM0D/fVCZOY0Y7YnU1Gl5Aiq5kyFzVOwHUbacMxdPiUB8T?=
 =?us-ascii?Q?mwqiNFmRzt4JnRl/TKpvvQZZ3KfVtbnmJfDfKwHX4j2CeOr4li8VOtTHljib?=
 =?us-ascii?Q?axT7O0RDdlsEYynqpW4h+ymUEu8RVOOpQHNBmqvdDtCjbdcvUmDmBJ5zvxg8?=
 =?us-ascii?Q?foxJqaMk+7LvkeQA2gxIthUjF7kD/EXWPyV6rgGOXI9ohaEzqMQPa+dfS1+6?=
 =?us-ascii?Q?++dpSTggiGvarxBfO9gYJRPuk1n/uzcdKhJF9yTxUL19B8jbu0N5C6xH7Zs5?=
 =?us-ascii?Q?lQ2qqu7+rarl2XLXGp7PNXobO953/nUz3p2Ga4QW7OwT49YE9oazlTWRQDK0?=
 =?us-ascii?Q?pFTTHFeA2OOIZxZOn/wr3Sb4F8JrGzxaTBZpe8vawQMD0nF65WpjbNnAmoqX?=
 =?us-ascii?Q?lUfoOYSXf6hAR9dyoU08/s73c2vpE7cl1K7Y+yUXJUHKuW1/s7DlL/QTHr3J?=
 =?us-ascii?Q?w9U5rnsYPvTY8SHLfmRGiNwnU/WeKzpzqRJ/xXQOcHNkzBVsfExGzsx7GFuP?=
 =?us-ascii?Q?zOlWMvGc0OuHW0ZPwtLypQjCVB9LJ9ZTMpW6kNVTl9qhr7TjGXdvntEuYrps?=
 =?us-ascii?Q?6qCarAmZl74TJCGqDS0dcbK6G67dmcC95PosMSyvs1aNEEDjqFDJz6/YmWSb?=
 =?us-ascii?Q?REeXpRfm56lj9W686pSaruWP27KU7mgRMQfdaygYMRqknxXtCpHMhbsS/Wj+?=
 =?us-ascii?Q?0XdSUTqSjkQcZiLHNw8gJeHZSlABeRF1O3eXr6KhKQn4kHMwQ3iZn5FcO/rc?=
 =?us-ascii?Q?Fn1T/3XKe+5QzPdOw7g8lD07+aj/MwxRKSC6dexR?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d5678d8-252a-449e-ae08-08dcaa17a216
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jul 2024 06:29:25.9974 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2y8d2ch597szgLlwoB18sp9GIEBs7+CvjXcpVDOaAB5n982+uzusYm2IAwZ3GebAWcaBw0Ig4yrDU00hN10OT+BKpVqRgChKR063eLgIy3U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6332
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.13;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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
>From: Eric Auger <eric.auger@redhat.com>
>Subject: [PATCH] hw/vfio/container: Fix SIGSEV on
>vfio_container_instance_finalize()
>
>In vfio_connect_container's error path, the base container is
>removed twice form the VFIOAddressSpace QLIST: first on the
>listener_release_exit label and second, on free_container_exit
>label, through object_unref(container), which calls
>vfio_container_instance_finalize().
>
>Let's remove the first instance.
>
>Fixes: 938026053f4 ("vfio/container: Switch to QOM")
>Signed-off-by: Eric Auger <eric.auger@redhat.com>

Reviewed-by: Zhenzhong Duan <zhenzhong.duan@intel.com>

Thanks
Zhenzhong

>---
> hw/vfio/container.c | 1 -
> 1 file changed, 1 deletion(-)
>
>diff --git a/hw/vfio/container.c b/hw/vfio/container.c
>index 425db1a14c..d8b7c533af 100644
>--- a/hw/vfio/container.c
>+++ b/hw/vfio/container.c
>@@ -657,7 +657,6 @@ static bool vfio_connect_container(VFIOGroup
>*group, AddressSpace *as,
>     return true;
> listener_release_exit:
>     QLIST_REMOVE(group, container_next);
>-    QLIST_REMOVE(bcontainer, next);
>     vfio_kvm_device_del_group(group);
>     memory_listener_unregister(&bcontainer->listener);
>     if (vioc->release) {
>--
>2.41.0


