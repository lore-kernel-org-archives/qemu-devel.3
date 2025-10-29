Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9B1DCCF9EB
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Oct 2025 09:57:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vE2vh-0000pD-Kq; Wed, 29 Oct 2025 05:57:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1vE2vf-0000kL-OX
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 05:57:19 -0400
Received: from mgamail.intel.com ([198.175.65.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1vE2vT-00038a-F8
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 05:57:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1761731828; x=1793267828;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=GdMUpgqph+8PkrZzCxvY1sJWRt/gR6EER/3UfYyt1Qo=;
 b=Qg7uma9oCj+HoxO8bfDSnKma4g8N8C8/GUNtXVJoNHB28FIAvHzF6q+a
 d6Ha6PT6fynJTwmkzh8kUH1KgkeRFioTf8iha91GjkOAcQtCFjcbV5KSu
 87CgbZdeJCnNI4NtqsrcURZZGE5sAig4jqKR3Xhvd1uN4EHlwYiWZWMK2
 YVjXrLH5o1L8vRY12l2uCGwXZ7970OMZTWSOB0twre3bR+auvXT9wGDmJ
 Y7xu+z5UxXO88V3AAxV9lvXBwvseg5FrJbjxeaU60lqU2VRMsFzV+z7Nn
 Wsos+ku6XEwEnqsh2bhK5lCRUIimwnPNJXjE+AqvAA7fkMnJNLl/n1I3Z g==;
X-CSE-ConnectionGUID: OhswkF5cR7ef+pNL1571Mg==
X-CSE-MsgGUID: HkaldjuzQduZKHAP7XMd9w==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="67490732"
X-IronPort-AV: E=Sophos;i="6.19,263,1754982000"; d="scan'208";a="67490732"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Oct 2025 02:56:58 -0700
X-CSE-ConnectionGUID: 9Wj4D1aJRmW5R+vYMk0y3A==
X-CSE-MsgGUID: Sfja1Is3QoCuKPIPel7zSQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,263,1754982000"; d="scan'208";a="184799476"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Oct 2025 02:56:58 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 29 Oct 2025 02:56:56 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Wed, 29 Oct 2025 02:56:56 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.26)
 by edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 29 Oct 2025 02:56:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iJM2TeWFpFzcxqnBB9irxsSou7ZSpuy91d3WjnaYlUJ5S3J8ODqCFdir+ml/gSHVKZAw888nkwlObDYv/Rg+lzxlEBXcD761HoixDgpr76ZouH552ROCmbHn99eWj/oJj8LkVOtFCsSd1cPHsVZYB45+9Gfl3dRBrLOU1gLhkJhtHv9LM5WwC21NfQq7Q04TI8NzFD2GWr5wjgTFC8jwqOWa8/6o3PtCFrt6zEZ3rN1q0wfpHDyLvF8YZ/Nv9avxMlQet9SpFrjV9coSvlI1g4GlzcOdynfaHxI3FM4eEFnzR+AZa/5Z9DjBeG6FJnse5nb1qVJ5caWYJbjCerO4WQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GdMUpgqph+8PkrZzCxvY1sJWRt/gR6EER/3UfYyt1Qo=;
 b=jqh6xy1rcMNpxPbNC1eLfMymapnFjqKst0n2iPtHGjwfffzol8L/zM+tl0fVRacG6M7OJN4H2JHjZB3O+zkJxMfjPjlotXoPOwOR6fiA1VCM9fR33OAAOemsUo1D3jtRuFMX55d3hPHP9NmNfllmdxRezt/CPUzjHb4kx5x02tyHzhLl3nnx0ciXXP2dWKpnK1jcDPalykmxwV1MGrMyuQT0xJ3TGWzMUogOHSqXE7njJpaIAFweLf76zN5QPHnGlfEU0/7UXRyUWBPA+OhzK3WuxczAnkY15yc55cfGd2ADnIanOo8BBrVur17jxqCDZiyXWz0Y548eeZVyQp6rUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12)
 by MN2PR11MB4533.namprd11.prod.outlook.com (2603:10b6:208:264::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.12; Wed, 29 Oct
 2025 09:56:54 +0000
Received: from IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13]) by IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13%7]) with mapi id 15.20.9275.013; Wed, 29 Oct 2025
 09:56:54 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "mst@redhat.com"
 <mst@redhat.com>, "jasowang@redhat.com" <jasowang@redhat.com>,
 "peterx@redhat.com" <peterx@redhat.com>, "ddutile@redhat.com"
 <ddutile@redhat.com>, "jgg@nvidia.com" <jgg@nvidia.com>,
 "nicolinc@nvidia.com" <nicolinc@nvidia.com>, "skolothumtho@nvidia.com"
 <skolothumtho@nvidia.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "clement.mathieu--drif@eviden.com"
 <clement.mathieu--drif@eviden.com>, "Tian, Kevin" <kevin.tian@intel.com>,
 "Liu, Yi L" <yi.l.liu@intel.com>, "Peng, Chao P" <chao.p.peng@intel.com>, "Yi
 Sun" <yi.y.sun@linux.intel.com>
Subject: RE: [PATCH v7 13/23] intel_iommu: Bind/unbind guest page table to host
Thread-Topic: [PATCH v7 13/23] intel_iommu: Bind/unbind guest page table to
 host
Thread-Index: AQHcRMKTKQaI2CESTUOSWRIItBDScLTRjxmAgAc+thA=
Date: Wed, 29 Oct 2025 09:56:54 +0000
Message-ID: <IA3PR11MB91368F782F60BA5240FB9E0D92FAA@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <20251024084349.102322-1-zhenzhong.duan@intel.com>
 <20251024084349.102322-14-zhenzhong.duan@intel.com>
 <0dd62d63-d847-49c5-a05a-2e58c6c6d538@redhat.com>
In-Reply-To: <0dd62d63-d847-49c5-a05a-2e58c6c6d538@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9136:EE_|MN2PR11MB4533:EE_
x-ms-office365-filtering-correlation-id: a456c622-445a-47a7-6355-08de16d17d6f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|376014|1800799024|366016|38070700021; 
x-microsoft-antispam-message-info: =?utf-8?B?NVdqTnBUZ0dvbEo2N00zVGJhLzQ3NmlCUFlJODlzL3ZWRjd6UHdCYjhNeUVN?=
 =?utf-8?B?WjlOWDk4VTNDY21GbERLQnUzOHMyZXI3LzRQVjlORlU4N1ZIZWVXakREK0Vo?=
 =?utf-8?B?U3FpVkkrZnp6SVRLNmVMbVRRUndlcEhtRElKUkQ4TTVDT0VVZXI4S3VJaEZZ?=
 =?utf-8?B?YzJQaHUzbzVWQnFXTlV5MllQT2RKSmVFbWYrOWJSRWhkQnpUYkZPcDdmTzY2?=
 =?utf-8?B?a2tzL0ZvY1JTQ3JITVpNU3k4Q0tOalVNYnFYaElpVGdGZXRsOEc3Q3BTT2dZ?=
 =?utf-8?B?ZlRkNGR0YzF5S1pVUjlnRE5TbDBnQUlFdXU2TDlLVG5neEoyazQxMTJ0K2Vt?=
 =?utf-8?B?M3gwUDEyQ3dvU01RYjdNSkpYUng3czhZeDNJczhpSGFPM2RpRldHMENRZld4?=
 =?utf-8?B?ZDkyWmJFK0VJYU8zZk5vekd5NVptWVFRQXV5ZVYvNWk1Vlp4TW4ybXU4amln?=
 =?utf-8?B?R2NCbFZCSTN5cUJoRFdpaE9pa0lGVnVvSGtkVGEwUjV0dzZ2MEtaNGJ2MXpT?=
 =?utf-8?B?L2hzSnh1bVhydE40YnpsbmxhOEY2aC9malJYeG04b3d3WW41ZTdKMGdDYy9T?=
 =?utf-8?B?cFF4YkZDa1J6MzB2NmpFUTM2bGVWUU40MEtobmpSNWlhM1phSXpGVmJzY3Vh?=
 =?utf-8?B?b1dueDhzSG1CeTNQYmladEhOV0dPQVZNRXViWERReEpneXV6VHZ4TWZ6UThC?=
 =?utf-8?B?cisrQzMxNkNBN2NMbUdvbE5JRjNpVWZsWWFsWkpJV2o4VnU2cHNYWWU5VTFL?=
 =?utf-8?B?MWlSMXJldTcrV3IvNWtWSC9qNjIyWm1Ga0NLUkFoRlE5V3h5MnZaOVAzc1NJ?=
 =?utf-8?B?WVBwZ1QrMkJ1SlZDMCswQUhLMFdKZnNGL3hlUmJ4cHJjQ2tJR09sN1hvajNw?=
 =?utf-8?B?aC9sczZER0xSTVF3dDJqNnFHRDBJQk9TTWdYcEhLT3R0NGJVZ1QrOVdWK3dw?=
 =?utf-8?B?MTI0UGtybjdYbmFraFQwdmQ2Zll0djdHb3VuWjVWVDBZTVUwWUhWenVlYm5I?=
 =?utf-8?B?UE5vWVdON2x4Q0t2R1pJNmZubHN4d0VCK2JreXEyWmFvNWc2TFdQT2MrajQy?=
 =?utf-8?B?TWpxZk91ek91WktFdlpQUm9OSm9OdVpOK3BrU3B1dWoxQndGSmVHbDlleUtQ?=
 =?utf-8?B?QUlJNEREcHBpbkNDckhleGtqZlNjdTV0aDVmakhFTHFqRU8wMlg4bVQyVlU4?=
 =?utf-8?B?TXhkZStpRTF0ekZNTFI3YXVHT3M3TFp1eE1QSUxqam51VCtYYm5RanZvMm15?=
 =?utf-8?B?VEF6OHo4U1Y5NnJaeXNNOU1XUFMrWjJhVjN0dllIem5sK1hvNEFRZWNmWUxK?=
 =?utf-8?B?VDYwakFmeC9kSnlvUjI0SnE3b05ONFRhd3pOc1U0czQ2V1Q1V1RPSDJONGpu?=
 =?utf-8?B?N2daNXNzWEFnd1d1MEJyZmVmN1puUHdqUVpBZ25DQTJwR3d4TGMyY3UvajBG?=
 =?utf-8?B?N21GanQrNURvU0JPZzFOMklqSU1Wb0RKLzhqNnVBaTdrcUlsZGNCb3pKaWtW?=
 =?utf-8?B?QUlkMUFxZWh3eVFlUGo4MnQ0bDRlUGIrbENDRktzMm1pQjhNcDVWOXArZUkv?=
 =?utf-8?B?R3RFOFZRYU1TUUVOOXZJOFlYUlpMTmJ6MmZXWVVET3hXQWZPdnpjaHdLU0xI?=
 =?utf-8?B?eXFGQVVSeTdzOS9FbmZXd2V1UVNJVFl1N0RjcXJpd3NuZGFzUDNwTGFnckpS?=
 =?utf-8?B?Q2FlMHE0VXM4TVlpb2dsSVc3YVBIRUFkQnRIN2lRQ2t1WmZ0THJiNWlkazUr?=
 =?utf-8?B?azFuU0VhSEFTc1FzTkNJZjlTWVJ4TE5rTXlOV3VUNHFLVjlFQTd0ZzhYZjlT?=
 =?utf-8?B?SnY0YlZNbFVCWU02V0c5dC9WVzRHVytGREp4MmVsQWMyQTlyY09ySWdjb2dE?=
 =?utf-8?B?ejFtSFEzZElxTGZieHFvblRLaWVJaXRZTjZCd2p5WEgwL24yMkJCWXcyUTdw?=
 =?utf-8?B?aUhVWStVRk8vdVFoYTJnQm5FTGYxdmwxM3ZkSkV6MTZ2L2JpN01pczVTRU5W?=
 =?utf-8?B?YWtwTlZYZUdxWTNzTjB4cnNiOE1ITDJ6NE9neG81ZnhKWDRiUDZhY3dmQjRT?=
 =?utf-8?Q?7I7JE1?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9136.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dEpMQU9aU09aOHdIRmtzbzJiVzVvRjZqUGt2ZFI0TkhaMFRLM1o1UHRDUHBD?=
 =?utf-8?B?MXplTHc0QktRaWZMSkdSaTh3Vm40cFdvOXVveS9BUWdWTkRYUjY1SFhwNHRl?=
 =?utf-8?B?QWZyK2VpNjdZRTRHdkpSTHhrMXp0Ny96dmx3aVV1ajFZVWRzb0pnY05CNHIv?=
 =?utf-8?B?eFpFVHFiT1czbHBqRys5L29VWEhXYmpSK0ZSaUZnbHNQUFlYZk14L0pFaW0x?=
 =?utf-8?B?YS83Ynl4Tzc4SndKdGl2Z2o3WWxNL0hKcDRDM3duc3ZtbEpjcVZKbmtNZTdC?=
 =?utf-8?B?YlZyaThSaUNUUFJiNko5YmNBKzdzWjh6K3dnOFFUZlh4SUJtMlNmaW8xQ0ZS?=
 =?utf-8?B?ZDdINnovVCt4dUxLVGNBNkM3RFZKKzRuR3dHSzlmZzhoTjhneHJmU0VPdHlw?=
 =?utf-8?B?R0Q0OWgrdU5sdzBSL0RaaHVvWFlJTUlFaHFLVVNja0VZTGhMMjR5ZHhHL1U4?=
 =?utf-8?B?WjNaTVNldlBRRzQ3Y1VqV0RWVzBWQWJzQWtFOUN6SzRQOER2TTJUZnpEdGQr?=
 =?utf-8?B?NU1BVHBka3o3U3RHRDJmNmZmRXM4ODZWTXAzVGRBODJnUHBOMUUzNHptRzRq?=
 =?utf-8?B?ajluem9OSDVac0EzY2o1dERQSHU5VGZsdEpwU3RrMXhSQ3ExaDh4YzNmalh2?=
 =?utf-8?B?MHVCckhLQm8wTG4yUVhPdFZ4UVdXeDZncy9XWjJWeGI2WUtSZkxKSXdObGNz?=
 =?utf-8?B?dkdHQTVTWk1sWEhnL1JaRzM5dVYzRFh5ckVYcmNUeVpNN1R5MzVncHcxUXp1?=
 =?utf-8?B?MGJGaTF1dDBJWnNoZHBKS0hUTTRCQmNWaXVoTU1ZTlF6Nmhlczg3MmVtNGlF?=
 =?utf-8?B?SnArTkxQbEl2c2lyYVhZMHFGMHJhdi9ZaGQ5YWY3Ky9zd2JXZ2VCWFNzRDFB?=
 =?utf-8?B?Z1NqdTMrV2h5NFQ3SGk3aGdKajhmZzcyZjFzTkV6SVk0MFNpd2RzRkZFdjhy?=
 =?utf-8?B?c1huNUVvUHQ0RjJZV3BMa3JUTjBUNHFIUWdPUThaWlZvVyttNjNuVVJEanlU?=
 =?utf-8?B?ZEpZeDAyajFhcUhHRmZmdW5NNDBpclpCVHZCeGM0YU0wVFJTMFl0ZXBVUEha?=
 =?utf-8?B?UEEycHVjbmlOMEdWTjJVb1QrYUhGT3BLbTBGMG84aWRNWU05TEduWnJqYUll?=
 =?utf-8?B?bm5EWmJJR2dUSUo4VUtIRXRWekZZcURzMjlXZHJoM1J1RXo5bDJnWEh0L1cx?=
 =?utf-8?B?WTEybFhpWnNHOTZXYm1mWUJiSndjeFRLUFFwNkwvQ2pqMkVQZjd2UWtSdzUr?=
 =?utf-8?B?MzdRVHVoQVQ4UTNJKzZoRjVqYjdLTndIbythRTl6WWVBTFlVeVYwU3Yvd0Vs?=
 =?utf-8?B?RTQ4QnNlaGlOVFkvbi9vdVpxQWxrVnlTSUh1cUVsZEhuc3lxN3kwWHhSY0Zl?=
 =?utf-8?B?WmFhUVhmTzJrb1FMOU9GaWdldEhPelVDcnpjTkFSdTl0Y2hnSDVRRkNwWXVJ?=
 =?utf-8?B?bFRmeVA4YTBKTkJRQ09BREJCRVEyNUVCWG8xMXVxZElEZWVzR1RON3Y0bG5X?=
 =?utf-8?B?cnkwazMzNjlJL2pnalNxRldudmNZU1BGbiswaWd5RWE0UUZCMU9iVHVMZXpa?=
 =?utf-8?B?Mm8xNjlmd2FnZnNuWmZXWHcyZGVUQm5FSnFFbXZjSWcrVjdrR1h6aitYaUpX?=
 =?utf-8?B?UXZ1VndkRFdScVlaSmdJY0dtTHFWa3RremVIQXJBb0Fram8rckVINnFYbWwz?=
 =?utf-8?B?b1duNUkvNnZEU1pEckVrWEtZQmVNMVVzQU1XYXJPQjU3WmN3RVoyWUNjTEpH?=
 =?utf-8?B?cnpOS2l1dFRoWXdpRDcwTGpwNUdjWm9UdEh2aSs0Nm9lSXlnbThaU0JlU3FK?=
 =?utf-8?B?NUQ0V1B6SjQzNnQ0V0VzTVlPVVFPTERsM1hXSUZlYm9QazRYQy8rUjhVZWk1?=
 =?utf-8?B?and1Rm9WTThkSnErNTg5dHZyRExhWm5vVTZlV1d0NzVJK1ExRUcwenEybktP?=
 =?utf-8?B?N2J6REIyeEl3YWhWSUxHeGhVVVZSa05MV0hVSmRXVFk3TGpuRW1BaGJxcm5x?=
 =?utf-8?B?VXEyNnEwbkQxNmV1ZGhDZUFUR05CZlduekc4WHUweVNHZDY4NThpY1RLSmFj?=
 =?utf-8?B?UElrdnIyWkh4VVlUY25ZN2cyMU9zNnZjOXRRTVFuSjJsZkRpVVZwQnRVeHEr?=
 =?utf-8?Q?YDZQNewDWMgui/J3/DwlP4ezK?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9136.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a456c622-445a-47a7-6355-08de16d17d6f
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Oct 2025 09:56:54.1303 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kLhHIVvdyXt6kQjPdv+o9XaOqE+BGp/iDUO6GcnPC6BB9odehHCdDXysRFqbpDWKZmiNFEwaS8XTLfEjRgpYPzLkv77V9OxLqEHltKKZsYI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4533
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.15;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IEPDqWRyaWMgTGUgR29hdGVy
IDxjbGdAcmVkaGF0LmNvbT4NCj5TdWJqZWN0OiBSZTogW1BBVENIIHY3IDEzLzIzXSBpbnRlbF9p
b21tdTogQmluZC91bmJpbmQgZ3Vlc3QgcGFnZSB0YWJsZSB0bw0KPmhvc3QNCj4NCj5PbiAxMC8y
NC8yNSAxMDo0MywgWmhlbnpob25nIER1YW4gd3JvdGU6DQo+PiBUaGlzIGNhcHR1cmVzIHRoZSBn
dWVzdCBQQVNJRCB0YWJsZSBlbnRyeSBtb2RpZmljYXRpb25zIGFuZCBwcm9wYWdhdGVzDQo+PiB0
aGUgY2hhbmdlcyB0byBob3N0IHRvIGF0dGFjaCBhIGh3cHQgd2l0aCB0eXBlIGRldGVybWluZWQg
cGVyIGd1ZXN0DQo+SU9NTVUNCj4+IFBHVFQgY29uZmlndXJhdGlvbi4NCj4+DQo+PiBXaGVuIFBH
VFQ9UFQsIGF0dGFjaCBQQVNJRF8wIHRvIGEgc2Vjb25kIHN0YWdlIEhXUFQoR1BBLT5IUEEpLg0K
Pj4gV2hlbiBQR1RUPUZTVCwgYXR0YWNoIFBBU0lEXzAgdG8gbmVzdGVkIEhXUFQgd2l0aCBuZXN0
aW5nIHBhcmVudCBIV1BUDQo+PiBjb21pbmcgZnJvbSBWRklPLg0KPj4NCj4+IENvLUF1dGhvcmVk
LWJ5OiBZaSBMaXUgPHlpLmwubGl1QGludGVsLmNvbT4NCj4+IFNpZ25lZC1vZmYtYnk6IFlpIExp
dSA8eWkubC5saXVAaW50ZWwuY29tPg0KPj4gU2lnbmVkLW9mZi1ieTogWWkgU3VuIDx5aS55LnN1
bkBsaW51eC5pbnRlbC5jb20+DQo+PiBTaWduZWQtb2ZmLWJ5OiBaaGVuemhvbmcgRHVhbiA8emhl
bnpob25nLmR1YW5AaW50ZWwuY29tPg0KPj4gLS0tDQo+PiAgIGluY2x1ZGUvaHcvaTM4Ni9pbnRl
bF9pb21tdS5oIHwgICAxICsNCj4+ICAgaHcvaTM4Ni9pbnRlbF9pb21tdS5jICAgICAgICAgfCAx
NTANCj4rKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKystDQo+PiAgIGh3L2kzODYvdHJh
Y2UtZXZlbnRzICAgICAgICAgIHwgICAzICsNCj4+ICAgMyBmaWxlcyBjaGFuZ2VkLCAxNTEgaW5z
ZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9o
dy9pMzg2L2ludGVsX2lvbW11LmgNCj5iL2luY2x1ZGUvaHcvaTM4Ni9pbnRlbF9pb21tdS5oDQo+
PiBpbmRleCAzNzU4YWMyMzljLi5iNWY4YTlmYzI5IDEwMDY0NA0KPj4gLS0tIGEvaW5jbHVkZS9o
dy9pMzg2L2ludGVsX2lvbW11LmgNCj4+ICsrKyBiL2luY2x1ZGUvaHcvaTM4Ni9pbnRlbF9pb21t
dS5oDQo+PiBAQCAtMTA0LDYgKzEwNCw3IEBAIHN0cnVjdCBWVERBZGRyZXNzU3BhY2Ugew0KPj4g
ICAgICAgUENJQnVzICpidXM7DQo+PiAgICAgICB1aW50OF90IGRldmZuOw0KPj4gICAgICAgdWlu
dDMyX3QgcGFzaWQ7DQo+PiArICAgIHVpbnQzMl90IGZzX2h3cHQ7DQo+PiAgICAgICBBZGRyZXNz
U3BhY2UgYXM7DQo+PiAgICAgICBJT01NVU1lbW9yeVJlZ2lvbiBpb21tdTsNCj4+ICAgICAgIE1l
bW9yeVJlZ2lvbiByb290OyAgICAgICAgICAvKiBUaGUgcm9vdCBjb250YWluZXIgb2YgdGhlDQo+
ZGV2aWNlICovDQo+PiBkaWZmIC0tZ2l0IGEvaHcvaTM4Ni9pbnRlbF9pb21tdS5jIGIvaHcvaTM4
Ni9pbnRlbF9pb21tdS5jDQo+PiBpbmRleCA4NzFlNmFhZDE5Li4zNzg5YTM2MTQ3IDEwMDY0NA0K
Pj4gLS0tIGEvaHcvaTM4Ni9pbnRlbF9pb21tdS5jDQo+PiArKysgYi9ody9pMzg2L2ludGVsX2lv
bW11LmMNCj4+IEBAIC0yMCw2ICsyMCw3IEBADQo+PiAgICAqLw0KPj4NCj4+ICAgI2luY2x1ZGUg
InFlbXUvb3NkZXAuaCINCj4+ICsjaW5jbHVkZSBDT05GSUdfREVWSUNFUyAvKiBDT05GSUdfSU9N
TVVGRCAqLw0KPj4gICAjaW5jbHVkZSAicWVtdS9lcnJvci1yZXBvcnQuaCINCj4+ICAgI2luY2x1
ZGUgInFlbXUvbWFpbi1sb29wLmgiDQo+PiAgICNpbmNsdWRlICJxYXBpL2Vycm9yLmgiDQo+PiBA
QCAtNDIsNiArNDMsOSBAQA0KPj4gICAjaW5jbHVkZSAibWlncmF0aW9uL3Ztc3RhdGUuaCINCj4+
ICAgI2luY2x1ZGUgInRyYWNlLmgiDQo+PiAgICNpbmNsdWRlICJzeXN0ZW0vaW9tbXVmZC5oIg0K
Pj4gKyNpZmRlZiBDT05GSUdfSU9NTVVGRA0KPj4gKyNpbmNsdWRlIDxsaW51eC9pb21tdWZkLmg+
DQo+PiArI2VuZGlmDQo+Pg0KPj4gICAvKiBjb250ZXh0IGVudHJ5IG9wZXJhdGlvbnMgKi8NCj4+
ICAgI2RlZmluZSBQQVNJRF8wICAgIDANCj4+IEBAIC04Nyw2ICs5MSw3IEBAIHN0cnVjdCB2dGRf
aW90bGJfa2V5IHsNCj4+DQo+PiAgIHN0YXRpYyB2b2lkIHZ0ZF9hZGRyZXNzX3NwYWNlX3JlZnJl
c2hfYWxsKEludGVsSU9NTVVTdGF0ZSAqcyk7DQo+PiAgIHN0YXRpYyB2b2lkIHZ0ZF9hZGRyZXNz
X3NwYWNlX3VubWFwKFZUREFkZHJlc3NTcGFjZSAqYXMsDQo+SU9NTVVOb3RpZmllciAqbik7DQo+
PiArc3RhdGljIGludCB2dGRfYmluZF9ndWVzdF9wYXNpZChWVERBZGRyZXNzU3BhY2UgKnZ0ZF9h
cywgRXJyb3IgKiplcnJwKTsNCj4+DQo+PiAgIHN0YXRpYyB2b2lkIHZ0ZF9wYXNpZF9jYWNoZV9y
ZXNldF9sb2NrZWQoSW50ZWxJT01NVVN0YXRlICpzKQ0KPj4gICB7DQo+PiBAQCAtOTgsNyArMTAz
LDExIEBAIHN0YXRpYyB2b2lkDQo+dnRkX3Bhc2lkX2NhY2hlX3Jlc2V0X2xvY2tlZChJbnRlbElP
TU1VU3RhdGUgKnMpDQo+PiAgICAgICBnX2hhc2hfdGFibGVfaXRlcl9pbml0KCZhc19pdCwgcy0+
dnRkX2FkZHJlc3Nfc3BhY2VzKTsNCj4+ICAgICAgIHdoaWxlIChnX2hhc2hfdGFibGVfaXRlcl9u
ZXh0KCZhc19pdCwgTlVMTCwgKHZvaWQgKiopJnZ0ZF9hcykpIHsNCj4+ICAgICAgICAgICBWVERQ
QVNJRENhY2hlRW50cnkgKnBjX2VudHJ5ID0NCj4mdnRkX2FzLT5wYXNpZF9jYWNoZV9lbnRyeTsN
Cj4+IC0gICAgICAgIHBjX2VudHJ5LT52YWxpZCA9IGZhbHNlOw0KPj4gKyAgICAgICAgaWYgKHBj
X2VudHJ5LT52YWxpZCkgew0KPj4gKyAgICAgICAgICAgIHBjX2VudHJ5LT52YWxpZCA9IGZhbHNl
Ow0KPj4gKyAgICAgICAgICAgIC8qIEl0J3MgZmF0YWwgdG8gZ2V0IGZhaWx1cmUgZHVyaW5nIHJl
c2V0ICovDQo+PiArICAgICAgICAgICAgdnRkX2JpbmRfZ3Vlc3RfcGFzaWQodnRkX2FzLCAmZXJy
b3JfZmF0YWwpOw0KPj4gKyAgICAgICAgfQ0KPj4gICAgICAgfQ0KPj4gICB9DQo+Pg0KPj4gQEAg
LTIzODAsNiArMjM4OSwxMjggQEAgc3RhdGljIHZvaWQNCj52dGRfY29udGV4dF9nbG9iYWxfaW52
YWxpZGF0ZShJbnRlbElPTU1VU3RhdGUgKnMpDQo+PiAgICAgICB2dGRfaW9tbXVfcmVwbGF5X2Fs
bChzKTsNCj4+ICAgfQ0KPj4NCj4+ICsjaWZkZWYgQ09ORklHX0lPTU1VRkQNCj4+ICtzdGF0aWMg
aW50IHZ0ZF9jcmVhdGVfZnNfaHdwdChIb3N0SU9NTVVEZXZpY2VJT01NVUZEICppZGV2LA0KPj4g
KyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFZURFBBU0lERW50cnkgKnBlLCB1aW50MzJf
dA0KPipmc19od3B0LA0KPj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIEVycm9yICoq
ZXJycCkNCj4NCj5SZXR1cm5pbmcgYSBib29sIGlzIGJldHRlci4gU2FtZSBmb3IgdGhlIHJvdXRp
bmVzIGJlbG93Lg0KDQpXZSB3aWxsIG5lZWQgdGhlIHJldHVybmVkIGVycm9yIGNvZGUgdG8gZGV0
ZXJtaW5lIHRoZSBmYXVsdCBldmVudCB0byBpbmplY3QgdG8gZ3Vlc3QNCmluIGZ1dHVyZSBmYXVs
dCBldmVudCBzZXJpZXMuDQoNCj4NCj4+ICt7DQo+PiArICAgIHN0cnVjdCBpb21tdV9od3B0X3Z0
ZF9zMSB2dGQgPSB7fTsNCj4+ICsNCj4+ICsgICAgdnRkLmZsYWdzID0gKFZURF9TTV9QQVNJRF9F
TlRSWV9TUkVfQklUKHBlKSA/DQo+SU9NTVVfVlREX1MxX1NSRSA6IDApIHwNCj4+ICsgICAgICAg
ICAgICAgICAgKFZURF9TTV9QQVNJRF9FTlRSWV9XUEVfQklUKHBlKSA/DQo+SU9NTVVfVlREX1Mx
X1dQRSA6IDApIHwNCj4+ICsgICAgICAgICAgICAgICAgKFZURF9TTV9QQVNJRF9FTlRSWV9FQUZF
X0JJVChwZSkgPw0KPklPTU1VX1ZURF9TMV9FQUZFIDogMCk7DQo+PiArICAgIHZ0ZC5hZGRyX3dp
ZHRoID0gdnRkX3BlX2dldF9mc19hdyhwZSk7DQo+PiArICAgIHZ0ZC5wZ3RibF9hZGRyID0gKHVp
bnQ2NF90KXZ0ZF9wZV9nZXRfZnNwdF9iYXNlKHBlKTsNCj4+ICsNCj4+ICsgICAgcmV0dXJuICFp
b21tdWZkX2JhY2tlbmRfYWxsb2NfaHdwdChpZGV2LT5pb21tdWZkLCBpZGV2LT5kZXZpZCwNCj4+
ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBpZGV2LT5od3B0X2lkLCAw
LA0KPklPTU1VX0hXUFRfREFUQV9WVERfUzEsDQo+PiArICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgc2l6ZW9mKHZ0ZCksICZ2dGQsIGZzX2h3cHQsDQo+ZXJycCk7DQo+PiAr
fQ0KPj4gKw0KPj4gK3N0YXRpYyB2b2lkIHZ0ZF9kZXN0cm95X29sZF9mc19od3B0KEhvc3RJT01N
VURldmljZUlPTU1VRkQgKmlkZXYsDQo+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgVlREQWRkcmVzc1NwYWNlICp2dGRfYXMpDQo+PiArew0KPj4gKyAgICBpZiAoIXZ0ZF9h
cy0+ZnNfaHdwdCkgew0KPj4gKyAgICAgICAgcmV0dXJuOw0KPj4gKyAgICB9DQo+PiArICAgIGlv
bW11ZmRfYmFja2VuZF9mcmVlX2lkKGlkZXYtPmlvbW11ZmQsIHZ0ZF9hcy0+ZnNfaHdwdCk7DQo+
PiArICAgIHZ0ZF9hcy0+ZnNfaHdwdCA9IDA7DQo+PiArfQ0KPj4gKw0KPj4gK3N0YXRpYyBpbnQg
dnRkX2RldmljZV9hdHRhY2hfaW9tbXVmZChWVERIb3N0SU9NTVVEZXZpY2UgKnZ0ZF9oaW9kLA0K
Pj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBWVERBZGRyZXNzU3BhY2Ug
KnZ0ZF9hcywNCj5FcnJvciAqKmVycnApDQo+PiArew0KPj4gKyAgICBIb3N0SU9NTVVEZXZpY2VJ
T01NVUZEICppZGV2ID0NCj5IT1NUX0lPTU1VX0RFVklDRV9JT01NVUZEKHZ0ZF9oaW9kLT5oaW9k
KTsNCj4+ICsgICAgVlREUEFTSURFbnRyeSAqcGUgPSAmdnRkX2FzLT5wYXNpZF9jYWNoZV9lbnRy
eS5wYXNpZF9lbnRyeTsNCj4+ICsgICAgdWludDMyX3QgaHdwdF9pZDsNCj4+ICsgICAgYm9vbCBy
ZXQ7DQo+PiArDQo+PiArICAgIC8qDQo+PiArICAgICAqIFdlIGNhbiBnZXQgaGVyZSBvbmx5IGlm
IGZsdHM9b24sIHRoZSBzdXBwb3J0ZWQgUEdUVCBpcyBGU1QgYW5kIFBULg0KPj4gKyAgICAgKiBD
YXRjaCBpbnZhbGlkIFBHVFQgd2hlbiBwcm9jZXNzaW5nIGludmFsaWRhdGlvbiByZXF1ZXN0IHRv
IGF2b2lkDQo+PiArICAgICAqIGF0dGFjaGluZyB0byB3cm9uZyBod3B0Lg0KPj4gKyAgICAgKi8N
Cj4+ICsgICAgaWYgKCF2dGRfcGVfcGd0dF9pc19mc3QocGUpICYmICF2dGRfcGVfcGd0dF9pc19w
dChwZSkpIHsNCj4+ICsgICAgICAgIGVycm9yX3NldGcoZXJycCwgIkludmFsaWQgUEdUVCB0eXBl
Iik7DQo+PiArICAgICAgICByZXR1cm4gLUVJTlZBTDsNCj4+ICsgICAgfQ0KPj4gKw0KPj4gKyAg
ICBpZiAodnRkX3BlX3BndHRfaXNfcHQocGUpKSB7DQo+PiArICAgICAgICBod3B0X2lkID0gaWRl
di0+aHdwdF9pZDsNCj4+ICsgICAgfSBlbHNlIGlmICh2dGRfY3JlYXRlX2ZzX2h3cHQoaWRldiwg
cGUsICZod3B0X2lkLCBlcnJwKSkgew0KPj4gKyAgICAgICAgcmV0dXJuIC1FSU5WQUw7DQo+PiAr
ICAgIH0NCj4+ICsNCj4+ICsgICAgcmV0ID0gaG9zdF9pb21tdV9kZXZpY2VfaW9tbXVmZF9hdHRh
Y2hfaHdwdChpZGV2LCBod3B0X2lkLA0KPmVycnApOw0KPj4gKyAgICB0cmFjZV92dGRfZGV2aWNl
X2F0dGFjaF9od3B0KGlkZXYtPmRldmlkLCB2dGRfYXMtPnBhc2lkLA0KPmh3cHRfaWQsICFyZXQp
Ow0KPj4gKyAgICBpZiAocmV0KSB7DQo+PiArICAgICAgICAvKiBEZXN0cm95IG9sZCBmc19od3B0
IGlmIGl0J3MgYSByZXBsYWNlbWVudCAqLw0KPj4gKyAgICAgICAgdnRkX2Rlc3Ryb3lfb2xkX2Zz
X2h3cHQoaWRldiwgdnRkX2FzKTsNCj4+ICsgICAgICAgIGlmICh2dGRfcGVfcGd0dF9pc19mc3Qo
cGUpKSB7DQo+PiArICAgICAgICAgICAgdnRkX2FzLT5mc19od3B0ID0gaHdwdF9pZDsNCj4+ICsg
ICAgICAgIH0NCj4+ICsgICAgfSBlbHNlIGlmICh2dGRfcGVfcGd0dF9pc19mc3QocGUpKSB7DQo+
PiArICAgICAgICBpb21tdWZkX2JhY2tlbmRfZnJlZV9pZChpZGV2LT5pb21tdWZkLCBod3B0X2lk
KTsNCj4+ICsgICAgfQ0KPj4gKw0KPj4gKyAgICByZXR1cm4gIXJldDsNCj4+ICt9DQo+PiArDQo+
PiArc3RhdGljIGludCB2dGRfZGV2aWNlX2RldGFjaF9pb21tdWZkKFZUREhvc3RJT01NVURldmlj
ZSAqdnRkX2hpb2QsDQo+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFZU
REFkZHJlc3NTcGFjZSAqdnRkX2FzLA0KPkVycm9yICoqZXJycCkNCj4+ICt7DQo+PiArICAgIEhv
c3RJT01NVURldmljZUlPTU1VRkQgKmlkZXYgPQ0KPkhPU1RfSU9NTVVfREVWSUNFX0lPTU1VRkQo
dnRkX2hpb2QtPmhpb2QpOw0KPj4gKyAgICBJbnRlbElPTU1VU3RhdGUgKnMgPSB2dGRfYXMtPmlv
bW11X3N0YXRlOw0KPj4gKyAgICB1aW50MzJfdCBwYXNpZCA9IHZ0ZF9hcy0+cGFzaWQ7DQo+PiAr
ICAgIGJvb2wgcmV0Ow0KPj4gKw0KPj4gKyAgICBpZiAocy0+ZG1hcl9lbmFibGVkICYmIHMtPnJv
b3Rfc2NhbGFibGUpIHsNCj4+ICsgICAgICAgIHJldCA9IGhvc3RfaW9tbXVfZGV2aWNlX2lvbW11
ZmRfZGV0YWNoX2h3cHQoaWRldiwgZXJycCk7DQo+PiArICAgICAgICB0cmFjZV92dGRfZGV2aWNl
X2RldGFjaF9od3B0KGlkZXYtPmRldmlkLCBwYXNpZCwgIXJldCk7DQo+PiArICAgIH0gZWxzZSB7
DQo+PiArICAgICAgICAvKg0KPj4gKyAgICAgICAgICogSWYgRE1BUiByZW1hcHBpbmcgaXMgZGlz
YWJsZWQgb3IgZ3Vlc3Qgc3dpdGNoZXMgdG8gbGVnYWN5DQo+bW9kZSwNCj4+ICsgICAgICAgICAq
IHdlIGZhbGxiYWNrIHRvIHRoZSBkZWZhdWx0IEhXUFQgd2hpY2ggY29udGFpbnMgc2hhZG93IHBh
Z2UNCj50YWJsZS4NCj4+ICsgICAgICAgICAqIFNvIGd1ZXN0IERNQSBjb3VsZCBzdGlsbCB3b3Jr
Lg0KPj4gKyAgICAgICAgICovDQo+PiArICAgICAgICByZXQgPSBob3N0X2lvbW11X2RldmljZV9p
b21tdWZkX2F0dGFjaF9od3B0KGlkZXYsDQo+aWRldi0+aHdwdF9pZCwgZXJycCk7DQo+PiArICAg
ICAgICB0cmFjZV92dGRfZGV2aWNlX3JlYXR0YWNoX2RlZl9od3B0KGlkZXYtPmRldmlkLCBwYXNp
ZCwNCj5pZGV2LT5od3B0X2lkLA0KPj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAhcmV0KTsNCj4+ICsgICAgfQ0KPj4gKw0KPj4gKyAgICBpZiAocmV0KSB7DQo+
PiArICAgICAgICB2dGRfZGVzdHJveV9vbGRfZnNfaHdwdChpZGV2LCB2dGRfYXMpOw0KPj4gKyAg
ICB9DQo+PiArDQo+PiArICAgIHJldHVybiAhcmV0Ow0KPj4gK30NCj4+ICsNCj4+ICtzdGF0aWMg
aW50IHZ0ZF9iaW5kX2d1ZXN0X3Bhc2lkKFZUREFkZHJlc3NTcGFjZSAqdnRkX2FzLCBFcnJvciAq
KmVycnApDQo+PiArew0KPj4gKyAgICBWVERQQVNJRENhY2hlRW50cnkgKnBjX2VudHJ5ID0gJnZ0
ZF9hcy0+cGFzaWRfY2FjaGVfZW50cnk7DQo+PiArICAgIFZUREhvc3RJT01NVURldmljZSAqdnRk
X2hpb2QgPSB2dGRfZmluZF9oaW9kX2lvbW11ZmQodnRkX2FzKTsNCj4+ICsgICAgaW50IHJldDsN
Cj4+ICsNCj4+ICsgICAgLyogSWdub3JlIGVtdWxhdGVkIGRldmljZSBvciBsZWdhY3kgVkZJTyBi
YWNrZWQgZGV2aWNlICovDQo+PiArICAgIGlmICghdnRkX2hpb2QpIHsNCj4+ICsgICAgICAgIHJl
dHVybiAwOw0KPj4gKyAgICB9DQo+PiArDQo+PiArICAgIGlmIChwY19lbnRyeS0+dmFsaWQpIHsN
Cj4+ICsgICAgICAgIHJldCA9IHZ0ZF9kZXZpY2VfYXR0YWNoX2lvbW11ZmQodnRkX2hpb2QsIHZ0
ZF9hcywgZXJycCk7DQo+PiArICAgIH0gZWxzZSB7DQo+PiArICAgICAgICByZXQgPSB2dGRfZGV2
aWNlX2RldGFjaF9pb21tdWZkKHZ0ZF9oaW9kLCB2dGRfYXMsIGVycnApOw0KPj4gKyAgICB9DQo+
PiArDQo+PiArICAgIHJldHVybiByZXQ7DQo+PiArfQ0KPj4gKyNlbHNlDQo+PiArc3RhdGljIGlu
dCB2dGRfYmluZF9ndWVzdF9wYXNpZChWVERBZGRyZXNzU3BhY2UgKnZ0ZF9hcywgRXJyb3IgKipl
cnJwKQ0KPj4gK3sNCj4+ICsgICAgcmV0dXJuIDA7DQo+PiArfQ0KPj4gKyNlbmRpZg0KPj4gKw0K
Pj4gICAvKiBEbyBhIGNvbnRleHQtY2FjaGUgZGV2aWNlLXNlbGVjdGl2ZSBpbnZhbGlkYXRpb24u
DQo+PiAgICAqIEBmdW5jX21hc2s6IEZNIGZpZWxkIGFmdGVyIHNoaWZ0aW5nDQo+PiAgICAqLw0K
Pj4gQEAgLTMxMzQsNiArMzI2NSw4IEBAIHN0YXRpYyB2b2lkDQo+dnRkX3Bhc2lkX2NhY2hlX3N5
bmNfbG9ja2VkKGdwb2ludGVyIGtleSwgZ3BvaW50ZXIgdmFsdWUsDQo+PiAgICAgICBWVERQQVNJ
REVudHJ5IHBlOw0KPj4gICAgICAgSU9NTVVOb3RpZmllciAqbjsNCj4+ICAgICAgIHVpbnQxNl90
IGRpZDsNCj4+ICsgICAgY29uc3QgY2hhciAqZXJyX3ByZWZpeDsNCj4NCj5TZXR0aW5nIHRoaXMg
cHJlZml4IGxvb2tzIGEgYml0IGZyYWdpbGUuIE1heSBiZSBhZGQgYSBkZWZhdWx0IHZhbHVlIGhl
cmUuDQoNCk9LLCBsaWtlOg0KDQogICAgY29uc3QgY2hhciAqZXJyX3ByZWZpeCA9ICJBdHRhY2hp
bmcgdG8gSFdQVCBmYWlsZWQ6ICI7DQoNClRoYW5rcw0KWmhlbnpob25nDQo=

