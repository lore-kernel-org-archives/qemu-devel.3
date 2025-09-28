Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBF49CAC5BB
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Sep 2025 08:15:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v2mXG-0006gx-VH; Sun, 28 Sep 2025 04:13:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1v2mXE-0006gb-MK
 for qemu-devel@nongnu.org; Sun, 28 Sep 2025 04:13:32 -0400
Received: from mgamail.intel.com ([192.198.163.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1v2mX4-0002AK-PP
 for qemu-devel@nongnu.org; Sun, 28 Sep 2025 04:13:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1759047203; x=1790583203;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=EMI1SkaA+nWGwQlqGVnSAIsLDppDrLAFQpA7DfATerA=;
 b=X8ejgtk6XD5nMwYjPxnKFsBRCh8LxiXx5m/LFc9PqNIS17/m9krgWjT1
 oaGFUa07hFTs5Y6ZkGNtrJ5JxIHzTBiYFowhmp1SE1DRHrxxCva7AqmCl
 //6cp3bvq58lwlwSDAyb89p7dL1xX+Dz/+hnUAY5XZYe5MSxpHuGilDZi
 ZNt1+nPS2TiNqn9laIAd2KJTHygRdCJIyLkY2JEMzc8tFRWzpd+Ckc4e2
 Xwlwcvxil9hOaoj7iA/SeQgp7wO18qHqj5b35b5P1vCJ+RVF226HE9Cy8
 m3HuTu+6yQTOOulopxiawVZlmzHbI+j1chDVYDPSVj4gQAIw8QpHkad+R w==;
X-CSE-ConnectionGUID: PhhyCzTFQr+Bp2PN198iNg==
X-CSE-MsgGUID: tGP7zm2hR6e0dbtH7do0Xg==
X-IronPort-AV: E=McAfee;i="6800,10657,11566"; a="71997484"
X-IronPort-AV: E=Sophos;i="6.18,299,1751266800"; d="scan'208";a="71997484"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Sep 2025 01:13:15 -0700
X-CSE-ConnectionGUID: cpevIwf9SPqwGkQYLnJnlw==
X-CSE-MsgGUID: DGsnjCnnSMmjUweMA1GG0A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,299,1751266800"; d="scan'208";a="201644520"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Sep 2025 01:13:15 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Sun, 28 Sep 2025 01:13:13 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Sun, 28 Sep 2025 01:13:13 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.66) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Sun, 28 Sep 2025 01:13:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mvWI4goaJidYTlosc08vzuAZnrHH+91nh0CakAgje5ZryPIpbLyrwQnwJmaZgSpyxJHHFlBoa/X7In49ayiorcO/yPIGFlz/rtBH9f+fK2vh8roMydFFZ9xuQoprg7YfAxKOXe+RmIz9hVDWCfCAVVwGGlU1ACt5Oe53MjiN/mEHrH5SLabVtTtv6LM6Dll0904lW5NC0ARMeVP8DmPt/S+UUnLfKOKCM96mwtkyKMXnP3zCC6SBIW+7tyGfhBMpPdTn6aJlFL7/8tsdHRop+vcn+D497vggTnFj3puPtcllCphOj0RNOyt+bH4bU6dWe6ZywkF9sc/D6faJD0NOZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T5tcYme4HsyCaGvChvXKZQl0wd1u5tCS+QdawXdEPGU=;
 b=qIr0LDHWk+SQvOwjiYTEgNOCWgCfpvNepiyI7uXFeTpWME3MdkEwAFZrsvt1IRcCplxivr8/8DbuV9sfWG7bmNYL3sPLGdk7a1pOuM4DF5sHMyP4fAd2UvpyW1rfV/Ag0CNShde1NOSCR53LB90rXe8G57JteL68ppcTN+jr1wgT+yPp2lPhKEoO6j8QOOOLdWYFU6LuFLLGbW5RWGUBxb5yZMHiQVqGxwDCabh0WNNQtPMqzuxbZreM5TuSADHtLJ3bgjaATRnkkXV3+WHHCldYrgBTX42JdYQrFlOSXwq8vEZeX2DGmLaCUdALoLf3oQYaYosXj3WKxUAjRzgvsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12)
 by DM4PR11MB7207.namprd11.prod.outlook.com (2603:10b6:8:111::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.15; Sun, 28 Sep
 2025 08:13:12 +0000
Received: from IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13]) by IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13%4]) with mapi id 15.20.9115.020; Sun, 28 Sep 2025
 08:13:11 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: Markus Armbruster <armbru@redhat.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>, "clg@redhat.com"
 <clg@redhat.com>, "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "steven.sistare@oracle.com" <steven.sistare@oracle.com>
Subject: RE: [PATCH 5/5] accel/kvm: Fix SIGSEGV when execute "query-balloon"
 after CPR transfer
Thread-Topic: [PATCH 5/5] accel/kvm: Fix SIGSEGV when execute "query-balloon"
 after CPR transfer
Thread-Index: AQHcLozlCnTmME1KJ0id+DD8li8BQrSk5LASgANb+cA=
Date: Sun, 28 Sep 2025 08:13:11 +0000
Message-ID: <IA3PR11MB91367C4C3B50CFCCDDB96C3A9218A@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <20250926022540.1884023-1-zhenzhong.duan@intel.com>
 <87v7l5stsj.fsf@pond.sub.org>
In-Reply-To: <87v7l5stsj.fsf@pond.sub.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9136:EE_|DM4PR11MB7207:EE_
x-ms-office365-filtering-correlation-id: 18713468-85e4-452d-e6b1-08ddfe66dde8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info: =?us-ascii?Q?7YvyeZ8hWyTuW+gIgA8Jfge+KNpzlXhTcBytP+R1jt6ydEWrb7dk09++NuFd?=
 =?us-ascii?Q?t2vHIcD184sh4cQt9Zup3zXfbvJ38hVvregwlFaO1//S6v4CnFZxNykSVj8S?=
 =?us-ascii?Q?905xnuX0CvbWCUi729J0aa3Jidpyyck+eDmrTjEg24pYTGGF+muf87/dsIzE?=
 =?us-ascii?Q?g/oB8dU5D7KaCedSdqrnwrdSQOkscZD1/QPw9ghuX/RuEkQ0dmVkF08rHtLT?=
 =?us-ascii?Q?NTpqxu6gwvVzHPHrzvqHh/oj0x4bxetgX14Au7DqSnO3ft9fwUl4omrQBMI0?=
 =?us-ascii?Q?pGoNh0dL9dYLtKXCM2IyGHu4Qzt068TMYGLEvX4F0faMSSHQ88VQ5g33toda?=
 =?us-ascii?Q?IeDnpO4MC23QidCS1S2k+mXgIhx8brMTMl2Pz8xYWyC1SpvWWAD7FXMJ5ZKh?=
 =?us-ascii?Q?rcTKEMI7oF6zduQ0ezRb9zKxOBM5CRKpb7Dca1CrAe6SQdpG6s4OrGTJD/sU?=
 =?us-ascii?Q?JmYiYprf3d8sAXxfghqP86pLbKd6hrJC1pV5yZbZvRZYukPIV7hcwPyb4HVa?=
 =?us-ascii?Q?EpMIWqKXnZ89VJOB5IfNzq3BYiMod/Hlc1MYWHKoyuIaMxgQGb/IPDaD1neP?=
 =?us-ascii?Q?42RptSIVWC9+m/8QlcnNcjBcaSueFh0ahyrKOSW8Y8rEz63qPEjLh7JggP6Z?=
 =?us-ascii?Q?2bXbrs+BGMBt8wypQfeK70YygChIJMotCvSTfFixYCuaGZgkV8ycs3+C6mY2?=
 =?us-ascii?Q?WX5C7ZI+ybiSDvRVfYFrYOcPMb/p3TtzkEl/kldePiKdgxdaloGC1jNqhgAu?=
 =?us-ascii?Q?SExhrzhqknRADN3GL7t62ZgGQ9sUwLEPWFXiRlzf5FRJUT9foYE6cw2XCJ+t?=
 =?us-ascii?Q?e9D+nudb9mevUzL1zVYOINHkqLbPc+Pwa8L9rU94xRYljwLEYe14e5Tr0QOG?=
 =?us-ascii?Q?HfRfamSqfr6Lz9P1/9pkLB/d/NsAKgXFyVG7BS5hDFpq6b4cYWqPqfAh/XO+?=
 =?us-ascii?Q?owBkI1KznlrJGLL5b/08UjiZGzY1/yCNKbfHx45z9BJxclHXdVkrYihjtJPu?=
 =?us-ascii?Q?z3c/CNePMZFe4k0dXZtVxFdh5ta8A7NPF5qm5f5SnkSZPEatXJ5SpSc68TCD?=
 =?us-ascii?Q?uWW8ViTUzo9zekdFSAPFQezwE8I6ssT99gTEZIzoPtHJn+Qkb3/rn/A7++0S?=
 =?us-ascii?Q?BHjpxXLgFq2SSfu1IDCZCJqofwU0vFK/77FGLx8prCgtQypJNfhPQG8dQfs6?=
 =?us-ascii?Q?ZMN8eKfQpvxJCe2QhH8tDSpiTo1bMfjsK824/kazPOzHXllNMuFiKSzIKSy9?=
 =?us-ascii?Q?09vMUQWNO3RQO8rtp/ykkKUGFj+6CK4dOxefvWEC+63Qu7IIhcUtTlVz+17A?=
 =?us-ascii?Q?KVQlrdLZfkZD83EEEZKT3jVsOr8g/5zP3o4NwZL08S+B1D0mKdU/oyu9CXGk?=
 =?us-ascii?Q?HK5zgd50F6ZQUOnqJ3HnBGYy3toqdHiP58xUCNQTiptNW6rG2Esa8h5INBRk?=
 =?us-ascii?Q?+i3j5QbTZQ46+GTHHNJiHXWK1itycgLxcpDTxhHgEMkBTjZhECneKpdAUD0z?=
 =?us-ascii?Q?jcCvHwxZ1LGw7Fgqc3QppkXN3pJT3Mo8RDA7?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9136.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?sjZBslctz36046L8p464uaDKYXJiSi1FEVTTBIOuexA56yTepDcz8Q7HwvTE?=
 =?us-ascii?Q?pPJ+2m6m9we3vaahGlz39mHBa5UOsGXiG5Kf8lR6E4Lu0orMX5F2CWW2u9w9?=
 =?us-ascii?Q?4O63j77Qny9BGS6oYEyZU0x9JDS04ge2merAs52ZSXIuTlJ55X/oqFfmakuG?=
 =?us-ascii?Q?znOrBigVlHSW9v7UGUzvzCTYx7jqKsD4NZH2Su3wuSlbcSaf6R1hctdSBba0?=
 =?us-ascii?Q?s13yz0m5rz6Jbjzc8+EmqnnSHexwcNbinDAvjOuIeyfwNAcqUKvgXx7Bre2g?=
 =?us-ascii?Q?7lzLHklx2uk6+P+KyC106lCyig81BxlE7o8PD26UMxAqseYpJbbX9NInk/aH?=
 =?us-ascii?Q?SCVh2Z6Mra4z+IJmohvxY1WSh2nKXtCVi+x2Kj6ETDvu78P1J+bSdA7NxyDc?=
 =?us-ascii?Q?bLMuq1a8FNfKSZRjZ/yWBmDlYl74OHtIgt5v2I8M5rRip+0QrUuNfU76PVix?=
 =?us-ascii?Q?Gu/6dztIjTrHvJOlyIs7xZLDJ8gnE2dDJNG13t417EjesIWjzrsrgVgoe8Bm?=
 =?us-ascii?Q?SOS2epGY0UfylZoTQ2/BCr0RMqz2febJu1MEOXWJOy5CnwoCjvgRDpu26agH?=
 =?us-ascii?Q?QfTiNSzEYBoxDeQ7ba9+TkwUvsBALvMnkXkZsfNVWicbo27oGYAfUpgRLdhv?=
 =?us-ascii?Q?1JJaE8/2p92vj85GTrXEUu+XxCkLVR3iDcFnVcYWXU9nKvjQ1pCIbtOylS5O?=
 =?us-ascii?Q?YpBj89zn9MYqVThx/KYt3TPOPN6J95z3D5arWm/e9b70qZ6fkujG4ISvSejm?=
 =?us-ascii?Q?W/akwAEnuwhYmsmZ7obi4ADhyC8BfbNuoGQaBRN3eziM5s9+oYiqY7de9Wl3?=
 =?us-ascii?Q?DH5RCV1EIm2b/1hUTaOTZFiGXks6v7NjwnFCLzibDTvCjOjYJnIyRcR9geF4?=
 =?us-ascii?Q?vWezJzq2Q2yBPr1BP9EYSxeqSXeQsXoUsAFASdVyZ21Ju4iaBD1mrKTvo1Ye?=
 =?us-ascii?Q?TVzlRf260A09TliKUC++YFdJ+fkT1YWvv8lsbxy226KhyctYqrRqbeLHMOKh?=
 =?us-ascii?Q?OJKTxvK7eGEz4XEyfXSGXRvjhOUd+oJCvyTJnTzJInWTORtBDRr/lJG9risQ?=
 =?us-ascii?Q?6Bvc6whe24JVfndmcJFJ+FwAmhGCAjgHaItXkmSefc/cQsvxMwtrhlRDCJrq?=
 =?us-ascii?Q?TVmK2tMDROc0GhyE70T+gDYAjM6ujoCv0Zg2cfbtWrpgMYhNOHWjx1cmdzXI?=
 =?us-ascii?Q?0UfBE6yAeNZRKfifYDrOh1zQarGg+2mHi0G4UUmiAmihGHoobuoIZgje9SrP?=
 =?us-ascii?Q?s0Pb+VRi/yAbfUrrHFLzZ9gYdBEP0MYQeouMhbbrBy2JxgqgYroQOTX+LFcU?=
 =?us-ascii?Q?ChiTgiW8Yi8Ubs8VnfxcmBb35PwfJY5yn7YLMSbhQUbyvTDtlV02g349gOKs?=
 =?us-ascii?Q?X48KW5ebZY7qi5/TeBLH4OBSzFezCSj5u8pzMBZpowySZkt0UYXwheFnglFu?=
 =?us-ascii?Q?g5pnlw+DTWYa/eizbE3S3D0g4dmC80LPQv2kON2oKs/SB7IKO1apTyi76zjD?=
 =?us-ascii?Q?f613TzWAWeLbqR7gFHarazCBfVX4Q3zQ6hD+s0S0JOTdRqZTeAPW8otX3Ywl?=
 =?us-ascii?Q?9ZigxhA7QTFd73VxFw5E6wXqmgMayeroqXRzuQK4?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9136.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18713468-85e4-452d-e6b1-08ddfe66dde8
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Sep 2025 08:13:11.9565 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LUYs88ID2R4b64eKILGXxw49H5qIvnQYshPETnriEESe/jEoxdzjfhURVIrcJQbKmDxFLM9oGyJeX52E47qdJTVfzehUMaPX9hnzxNfburk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB7207
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.9;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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
>From: Markus Armbruster <armbru@redhat.com>
>Subject: Re: [PATCH 5/5] accel/kvm: Fix SIGSEGV when execute
>"query-balloon" after CPR transfer
>
>Zhenzhong Duan <zhenzhong.duan@intel.com> writes:
>
>> After CPR transfer, source QEMU close kvm fd and free kvm_state,
>> "query-balloon" will check kvm_state->sync_mmu and trigger NULL
>> pointer reference.
>>
>> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
>> ---
>>  accel/kvm/kvm-all.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
>> index 9060599cd7..a3e2d11763 100644
>> --- a/accel/kvm/kvm-all.c
>> +++ b/accel/kvm/kvm-all.c
>> @@ -3479,7 +3479,7 @@ int kvm_device_access(int fd, int group, uint64_t
>attr,
>>
>>  bool kvm_has_sync_mmu(void)
>>  {
>> -    return kvm_state->sync_mmu;
>> +    return kvm_state && kvm_state->sync_mmu;
>>  }
>>
>>  int kvm_has_vcpu_events(void)
>
>This dereference could signify there's a general assumption *kvm_state
>is valid, i.e. there might be more dereferences hiding in the code.

Yes, agree with your concern, let me pursues other way.
>
>Have you checked?
>
>Is freeing @kvm_state after CPR transfer useful?

kvm_state was NULLed, let me try to keep it for query just like in kernel
task struct is retained when child process exit.

I'd like to add your Suggested-by on this if you don't object.

Thanks
Zhenzhong

