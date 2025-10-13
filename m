Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15D3ECCD185
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Oct 2025 06:21:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8Bv2-0000P1-PW; Mon, 13 Oct 2025 02:20:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1v8Bv1-0000Oj-4W
 for qemu-devel@nongnu.org; Mon, 13 Oct 2025 02:20:27 -0400
Received: from mgamail.intel.com ([198.175.65.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1v8Bux-0006Gg-FS
 for qemu-devel@nongnu.org; Mon, 13 Oct 2025 02:20:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1760336424; x=1791872424;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=WA3HiI48zdhUiuv7Bnn+RufSM2huaQefwJ2DL2KTYpk=;
 b=VAnhvGe8cuTNZAkH/mE3aWMSKhQyQjMQsPoz4b9kCekzfu1YA4D3tIKd
 7phlMPZdkL2o9UxLPdl1U7tnthjLYKgjK7psulgN06JPkJsGG0RyJP4Rw
 eMxOdA3A7kPPQs9xg492cDSsgKrLlezIWcNloQHtfsXrr70cO3bjc3G7x
 ltch7xrVaM3uHzDZZB/iBvj40/aaflemQbRFBlQoiZMfpAgPCrZYk1HsO
 XSjrc+aS4P/e+st1iuS3TahbkLFnKiTn3+4vcBlFUAVTnpegpYJYB7ZVY
 /o3bcOq0tog6WEQUsCS+GKMUColtqXUWxcviHPoaLi9IXLqSNnfCKuC7e A==;
X-CSE-ConnectionGUID: 4G5qqQwfQjG7do3oztucZQ==
X-CSE-MsgGUID: Hjije5MxRwyHIXqHHKsdNQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11580"; a="62170830"
X-IronPort-AV: E=Sophos;i="6.19,224,1754982000"; d="scan'208";a="62170830"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Oct 2025 23:20:21 -0700
X-CSE-ConnectionGUID: /iWSpL9MTs6a3Ks2WYVDxw==
X-CSE-MsgGUID: TrywqkZQTOyPFzB/x2OSbA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,224,1754982000"; d="scan'208";a="181084629"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Oct 2025 23:20:20 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Sun, 12 Oct 2025 23:20:19 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Sun, 12 Oct 2025 23:20:19 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.30)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Sun, 12 Oct 2025 23:20:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b/jwNfvKexaBcPkH4a7EaxyaZvil46sLUAo4LFDCkXKonV5lo8pPsBUf9FTp9siwTbVOgG3huQ1fQYzvSPidIcdeopXjwhUsWWuzo/BtO2EoeFNYZDDwVXlgMevr+C1+NoGYvhwzt6QDodhHLlLrAI0L1eeZHVHE0q9t7VE/JiyuV2ECwWHvy1vZPreuF16L+HutUkIv6XWSLFYRVs0LMF/HN6IANV7xgQIaGo8oHpm04Abe8/XTONUG7KZW3+F4pB4ecViy7j82BUFsAqI3iU84Sgzscswp7VqMedcgic/vPFF8lBCbGaPdJl0GYrJFijX+/7dwpLZbb5qbjs+s2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gBtuiRhZbY3DoNX73W3Gs2CjrwWPXEX+/9dkcRm2Jik=;
 b=P80lIRZLSuqO563CpdZJc7+qDquyMpwONyzeCMpO8rPrXF3qMENh+sZtyjxLnAdxRI89hE4NS97qGArQfe1O8tvMSigJboeFS6SYVSNqFBr4iY5pbHv9jKgmWlt221WN22Xcy/wNUJHDrGF5ZD8CsU29DYZfbApS29Bh7wQeGv5S38PcfriM2yEvV061Ziegn9j8IxfUUMLINInvD+PPcexboY27RzkUNKPoQxKV0Y6SOBvknQ60MthuYksosdgC7Qn2GxwvpLWubTR2HdmOP908nEcQ9Rk6II8lFEVCSEkNrto0zD/quHV/oRKcfRhZ7BeQfdVifBCtPPOwlGs/WQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12)
 by SJ2PR11MB7455.namprd11.prod.outlook.com (2603:10b6:a03:4cd::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.12; Mon, 13 Oct
 2025 06:20:16 +0000
Received: from IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13]) by IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13%7]) with mapi id 15.20.9203.009; Mon, 13 Oct 2025
 06:20:15 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: "Liu, Yi L" <yi.l.liu@intel.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>, "eric.auger@redhat.com"
 <eric.auger@redhat.com>, "mst@redhat.com" <mst@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>, "peterx@redhat.com"
 <peterx@redhat.com>, "ddutile@redhat.com" <ddutile@redhat.com>,
 "jgg@nvidia.com" <jgg@nvidia.com>, "nicolinc@nvidia.com"
 <nicolinc@nvidia.com>, "skolothumtho@nvidia.com" <skolothumtho@nvidia.com>,
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>,
 "clement.mathieu--drif@eviden.com" <clement.mathieu--drif@eviden.com>, "Tian, 
 Kevin" <kevin.tian@intel.com>, "Peng, Chao P" <chao.p.peng@intel.com>, "Paolo
 Bonzini" <pbonzini@redhat.com>
Subject: RE: [PATCH v6 03/22] intel_iommu: Update terminology to match VTD spec
Thread-Topic: [PATCH v6 03/22] intel_iommu: Update terminology to match VTD
 spec
Thread-Index: AQHcKHp2kZ7m/8T12UWUF3Bny3dQYrS+lyMAgAEoT5A=
Date: Mon, 13 Oct 2025 06:20:15 +0000
Message-ID: <IA3PR11MB9136162A228328140696B49392EAA@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <20250918085803.796942-1-zhenzhong.duan@intel.com>
 <20250918085803.796942-4-zhenzhong.duan@intel.com>
 <9b21869e-1163-44a3-9bcb-ef372ae4f02f@intel.com>
In-Reply-To: <9b21869e-1163-44a3-9bcb-ef372ae4f02f@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9136:EE_|SJ2PR11MB7455:EE_
x-ms-office365-filtering-correlation-id: 21c1e78e-f4ea-4acf-4838-08de0a209342
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|7416014|1800799024|366016|38070700021; 
x-microsoft-antispam-message-info: =?us-ascii?Q?h54yGu4P2vMb3sKWIfkpiMQcdcyOBNjOUUfdjfGYhPaDuDeDZWmcIBiLA7Op?=
 =?us-ascii?Q?hW+7jmvq2pGHhKO850OPiqD3E9IYd4px2pPnymb6kKSXs/YDoneEEqS/3+9N?=
 =?us-ascii?Q?0iyJMTo+7VC6EQ5eCbRVkzD0UkAvQDtOeTOKaTsBP/C9kiyvPQMfokkOJLFP?=
 =?us-ascii?Q?naH9aho0c79rZirZj+JfcMZ+ULVXaGgGhqaQHnhclfT1FZqmbjEC6YDwIluS?=
 =?us-ascii?Q?8e0GzSEUgmUMyf+PlngBhOcanu0wLLq/8YaFrfiy7jySGz+oDjhWmXZEwPUC?=
 =?us-ascii?Q?27ixbOhZDQvRdHALaxjmuSaz3pEuc0kqRk1gM3tNLlvdHfeQWJyWzjEZjH4c?=
 =?us-ascii?Q?bBBP3M2g23TfNPy0mVjiGrnuAPIg4YLR+VNRHLxAncNxC+SjjH94JMoGzbiY?=
 =?us-ascii?Q?E2vRwlkaO54cA01xdQgnXlvRZvq9QNBb4v6lj9M3Vv7s01nVLjd3IYf6p+L5?=
 =?us-ascii?Q?vnLvmxeLcDb4TnqFKteCcBgUusE70EHeYqTsXZ75FqxXCpVGxJC/cpgApdeJ?=
 =?us-ascii?Q?ZM8iM5pPeVMBwYCy19atDSegd7fGsePDQ3r6Gt/ZRB5lfWU8kybfBiQo9URL?=
 =?us-ascii?Q?HXfwHH6gF2MekEILUYZHehucXaGcXjLE1ALOf8xS6gbdXxhGIQUziSBPWZ66?=
 =?us-ascii?Q?k9NLvwE086ANILiIkRz20EvJu+3ZcEzoWCLKFaZgrcFRU2QoAWzv/0SzD3VN?=
 =?us-ascii?Q?KfasooaHChTg4ANWncdNvlnnhzqjaii1TcS8XdOwCfcSIgDPZ90QA8RiXrHP?=
 =?us-ascii?Q?y9Bv3GO788LfyCH/YtXMQbnigbxRbIsNGJ4TX2tMJkuAByEDykto/MR+0OWU?=
 =?us-ascii?Q?ty4AQOa2MmkvnLuq4tTukSIb+gck3RI8LCs2z/SvmO8HsVd/W62hgHgawC8O?=
 =?us-ascii?Q?+csNFOnNbqkpCDA7YW1ggxmZHj+5Cl0zYev0TzHBaEGSGxl9mLID9P8cfCqj?=
 =?us-ascii?Q?7OOn3dGtN0wqbGKNlNsANybOC2LUN60u89qlKXcx20HevXoaS9S62/p4l604?=
 =?us-ascii?Q?VddpC/OHs4gudbSs1hqidJDuHIfXB7XnbEVATDv2HDS9xEl6k4wgFw1/mCkN?=
 =?us-ascii?Q?ncxylnCvOayzmwAPtofeRTlE3mA7tgqX9dBG4JSdGEJFTm+nEkbAsTaFna8O?=
 =?us-ascii?Q?9T6nYOlnR5R8zNRBf44UY69sJEJjc0PwUTULBaVmBUdkKQPOAPFmp36WzhyR?=
 =?us-ascii?Q?RocOxaL7lNr48m0sB5dslfKPWLaZKoIRxW02oAH2wdBm3w73pJC/yJjhtiIm?=
 =?us-ascii?Q?W/gKTjD9IvvePcryLyrtgn/YkFS7kfUMLD8SNn1RAqHPuPymD4/uaOvxcVym?=
 =?us-ascii?Q?ADaplLH2R2WygUE+fhjkNUlWr+ZRE4PNz7lwxfos9f9eGYGWqFEB51ta1lUa?=
 =?us-ascii?Q?VaOitazSPmOAQ35kAIn6QcekcpAPfAfclEXfDA2KZHoQOOYQIbcsAtSSFOgT?=
 =?us-ascii?Q?b36jafryaByezE3+IcP/5fxmualiWwGgh71587okEmBja5LqchHFcP9Jmimh?=
 =?us-ascii?Q?a+4FLSDXNclUGyJIM5uDA+OLrd4mBffpJMD8?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9136.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?BqSTcJb4oB+A4MeSSC5UNSinmZG82WyILKzDnI5WQ6Q7gyuhntJb02rQYcz2?=
 =?us-ascii?Q?rJxEe1hL0nfYiYoT3OeP2vmD8uHpOQCsRmrGdDZLXANyTYMtOrU8QPxNdf6F?=
 =?us-ascii?Q?Hj7fyuGuAmrTASsjdkBh8gR4HaKgIuhdNn+sK14Nw6a5/UxiiEUZFs/Rmvxg?=
 =?us-ascii?Q?TcRAy1RaQIJgW3VezwV1J45PoVHWcqmnafZ5GXvccaNHP1l75NINW5IcmtOK?=
 =?us-ascii?Q?LnMfR7LZdwItzv5twkzONpjtEqtwnojOu/kbfVI0Rv0TRDNIDDNLIgvw75z5?=
 =?us-ascii?Q?FKJijfEr3dOQVpNcJwIo5uv6mTOh93emWwCty2jMn5Xby1SjjEw/m0jTSrlv?=
 =?us-ascii?Q?d5OX3uOQipcZcQZU+LRZDnpg4doE6zVjVKCF1iMHdIKyQjEoxgxTHy+xpRHq?=
 =?us-ascii?Q?nd/t9n55ttSxH4DNfMd7iu/EoqUvvX/7sEHwkIp17T86MqoyK3LU/qUhHEii?=
 =?us-ascii?Q?ZtS7dEp603zV0twHwRJ7l213dPpkNLXor4Q5fu3yJ8z9VU6rQg+UAdEh/kNx?=
 =?us-ascii?Q?vTpp+JLorq9j75q9FhQvz7gvduBGXvOVwbWL0Xi9EnW/2YkQ/CTOakDQ+KUL?=
 =?us-ascii?Q?87LnmWg+ZJoTgP3KSihaHlI5uN8pjO9Icg1VwxJin4CsEjye8nKad+yqaG9G?=
 =?us-ascii?Q?PdIMyW1vxCVXV3wW7iNYMQ6clf5mTGZuGG27b3WAB1dnIHL3b8P7MQLX/tOv?=
 =?us-ascii?Q?MQ5oOUBd5iuLd+W39cg+WlUVaWTzzD8pfeX7XGMKZU9wWTZim3RCh6al8jBC?=
 =?us-ascii?Q?oO30nOVkD4OLSvsHaguBkQX/w4/44WVVFkTFUqGSbtd0N1U/vxMDPWmicTJk?=
 =?us-ascii?Q?oDoC4M1omLs629MHg5NYeq07Ws3H24GPNp2I20ihXeqp+8zy9Q9m6MwTkbBC?=
 =?us-ascii?Q?c24KLrg0vNBXdgdz1AWk/X8Zpt0Ivpp/oR4Yr7tczcgp3Pwh7rbPmVQPAx4l?=
 =?us-ascii?Q?b1vnWOLQLQCU3weVKs0OjCUKI1OCzOBukF/BLPJ3aOekMZttMHuni/t805yW?=
 =?us-ascii?Q?TwrT94wH5G5TQxqIrQh1BQKabMUiW1FnRTKYm+p8GuBGCxO9vSP6CzS5VRNY?=
 =?us-ascii?Q?IRbFsCxLhXucdenkAmjoSWJM7XnLmlqVz9FLqfhN22zKyDLMwiEP0ZSwCN9X?=
 =?us-ascii?Q?94tgM10PK9OuM7ngGiYasNYVoOsAVhM2kGk7b+GE32aHQWfYhfJBe5Ogv4aK?=
 =?us-ascii?Q?ggCVF5lf+A/Rs2qp+ROfeTp2biI3mflslp6DkWVbdwUZwGet2/bQWbPyQl94?=
 =?us-ascii?Q?CIP4snokOg4GWk0NCO2pCh1uRxDcx1oJab6P1UeWmet1/6kLSy/amvRfbqS2?=
 =?us-ascii?Q?xqIECmGcB6g8IZzE4eSsrJl3KfneQJRLCpxS6YKiaapjOQsD/I8pfyCnbOfV?=
 =?us-ascii?Q?9pxglbk21NFYQuyGs3m9N/9FFK1aw1RoeHY9qwBaogLO70tEFtrbqCM1xXYS?=
 =?us-ascii?Q?FgIX4akE6W7nIwxnf1XMDMSU+fW2FeaSfPXVb2mdxK+IahnIwZgqWDOFu9D+?=
 =?us-ascii?Q?Ia6aFkKYT+IxrPWSXFgR5KZkQah617JqSsFO7GVg+JBs7IsiAcWPN+kLbyRa?=
 =?us-ascii?Q?xxHRFepry/DJZ7/VFozsybu+7EicPQ6UIu0VFUzI?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9136.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21c1e78e-f4ea-4acf-4838-08de0a209342
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Oct 2025 06:20:15.8408 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TASv53c0s1qE+uyPDlYLOLP1n6Fnug7AyfqQcVkMMJYHj65b/exA/lDoIBL19CibiVh40ydN4QqT2tlLmcnnAne2AlGQw4PW9FASlzg1gh8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7455
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.20;
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
>From: Liu, Yi L <yi.l.liu@intel.com>
>Subject: Re: [PATCH v6 03/22] intel_iommu: Update terminology to match
>VTD spec
>
>On 2025/9/18 16:57, Zhenzhong Duan wrote:
>> VTD spec revision 3.4 released in December 2021 renamed "First-level" to
>> "First-stage" and "Second-level" to "Second-stage".
>>
>> Do the same in intel_iommu code to match spec, change all existing
>> "fl/sl/FL/SL/first level/second level/stage-1/stage-2" terminology to
>> "fs/ss/FS/SS/first stage/second stage".
>>
>> No functional changes intended.
>
>LGTM.
>
>Reviewed-by: Yi Liu <yi.l.liu@intel.com>
>
>[...]
>
>>
>> -    if (!s->scalable_mode && s->flts) {
>> +    if (!s->scalable_mode && s->fsts) {
>>           error_setg(errp, "x-flts is only available in scalable mode");
>
>just realized we don't have chance to rename x-flts..

Ah, yes.

>
>>           return false;
>>       }
>>
>> -    if (!s->flts && s->aw_bits !=3D VTD_HOST_AW_39BIT &&
>> +    if (!s->fsts && s->aw_bits !=3D VTD_HOST_AW_39BIT &&
>>           s->aw_bits !=3D VTD_HOST_AW_48BIT) {
>>           error_setg(errp, "%s: supported values for aw-bits
>are: %d, %d",
>>                      s->scalable_mode ? "Scalable mode(flts=3Doff)" :
>"Legacy mode",
>> @@ -4877,7 +4879,7 @@ static bool vtd_decide_config(IntelIOMMUState
>*s, Error **errp)
>>           return false;
>>       }
>>
>> -    if (s->flts && s->aw_bits !=3D VTD_HOST_AW_48BIT) {
>> +    if (s->fsts && s->aw_bits !=3D VTD_HOST_AW_48BIT) {
>>           error_setg(errp,
>>                      "Scalable mode(flts=3Don): supported value for
>aw-bits is: %d",
>
>this should be x-flts=3Don. right? not a fault of this patch.

Yes, let me fix it in this patch opportunistically.

Thanks
Zhenzhong

