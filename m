Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 885E7C3DA49
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2024 02:48:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUdef-0001mU-JJ; Thu, 18 Jul 2024 22:47:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sUdee-0001h8-2h
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 22:47:32 -0400
Received: from mgamail.intel.com ([192.198.163.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sUdea-0000xf-Rq
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 22:47:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1721357249; x=1752893249;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=F1PELHzogLLY7hldtjySBXrnNv/6x5dQQ4pAsUQa068=;
 b=C0ZqZ15YPL7fGz1EMzk1R9P+2TL1rrvVl0q09FmCHcmnThxukieNdLUu
 22JBl9r4dvZzmP3xAvvEAa6ncgihsdvF1tFsgC7A8Wl1DvSa7M/ZVxsPe
 iWRBLr/saZryQRlyooykIVLfZ8aYU2EwPMWIY9nCk0YVqf6r6aPoExJ+D
 4YCJKSowDHR/FO+qgpCZH3SqdQY9G86C0siTYl4/Ljmd6EHO5dQn3vAnd
 y/8llgjxJmmvi84gze/eFoxPPEV2v2RLFPxXvbQoB7LRpEvPI5rdeEjfB
 /EtmJqHeUefVxPvKxfxKMQoQ+s5ZMOfzE2XNHVG+bB4SJi3xLN+dk9Zsx Q==;
X-CSE-ConnectionGUID: Wu5ir29LST+jXHo1jyp4jQ==
X-CSE-MsgGUID: 0UTFpdIiRxGCBjBaseCnzw==
X-IronPort-AV: E=McAfee;i="6700,10204,11137"; a="29570722"
X-IronPort-AV: E=Sophos;i="6.09,219,1716274800"; d="scan'208";a="29570722"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Jul 2024 19:47:26 -0700
X-CSE-ConnectionGUID: GzeUa16KQBqbNDvy9NR42g==
X-CSE-MsgGUID: jQGaMLanRXeJYeBTvXX5YQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,219,1716274800"; d="scan'208";a="55257587"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
 by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 18 Jul 2024 19:47:26 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 18 Jul 2024 19:47:25 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 18 Jul 2024 19:47:25 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.46) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 18 Jul 2024 19:47:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=paMWlLxFKzd/Twg/HBofLNPYF9BZvN1GvoNRIR3oAk3kykFTST9b9v3/FacxRU0/4tJYHjfUz9ifeO+T01PN7iuSjGl95Bdd4nPYlUwr02pWQaHqVRyFak3SYdQogXOkzdKvhPXqq6OM/JmeXqDmCL/IPFO4/qvGq8oiUY/m9RVG/2CSgcjlmShfDB0rxmGccb2TfOEovVy1kUI8RImsVoNgSF53Dke0zBGIi1+08c75sego2vAy/xg1jNkOXjgcJpmCBzT0IOE5YE8RQGmoQnHgn2XUJfr070zMHZHU46CLjOAL/8Ru5orjTQDdFMrD8Slc6e/8jtp0E3J1vYBc2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F1PELHzogLLY7hldtjySBXrnNv/6x5dQQ4pAsUQa068=;
 b=TsC+qZ308yB54CRa3PxImQfiS5q4KuhocODS2hErdW/MIR5mM9Omb0tShRb3/mhDrbnJZwrwhQ6PQeqYPKKcKto6Ul5FlN+6rSoLbGUvTmiUWPiivZFXnxxh4y7B5lhxL2Z7kjYzAKpT6d6PpFsXMK8QfFM2SUpVlJHjjX/mIWE1VRv1bko6fN8ozrMT53niELq6jz2kJdfQL9a0iSWJy8Y88fssalPyl/fo9IJSpaaH39LBi7/Sw6+kQ1QsNTWSlxls/EsRNGEAk6TMpfGwLWPekYFCz62FCz0MecPGCPw82maODHdpVaMbsjpQnuyJ/E+yqk75YY1tDCx27/JQiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by PH7PR11MB6056.namprd11.prod.outlook.com (2603:10b6:510:1d4::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.16; Fri, 19 Jul
 2024 02:47:22 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091%7]) with mapi id 15.20.7784.016; Fri, 19 Jul 2024
 02:47:22 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>, "eric.auger@redhat.com"
 <eric.auger@redhat.com>, "mst@redhat.com" <mst@redhat.com>,
 "peterx@redhat.com" <peterx@redhat.com>, "jasowang@redhat.com"
 <jasowang@redhat.com>, "jgg@nvidia.com" <jgg@nvidia.com>,
 "nicolinc@nvidia.com" <nicolinc@nvidia.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "Tian, Kevin" <kevin.tian@intel.com>, "Liu, Yi
 L" <yi.l.liu@intel.com>, "Peng, Chao P" <chao.p.peng@intel.com>, "Paolo
 Bonzini" <pbonzini@redhat.com>, Richard Henderson
 <richard.henderson@linaro.org>, Eduardo Habkost <eduardo@habkost.net>, Marcel
 Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: RE: [PATCH v1 03/17] intel_iommu: Add a placeholder variable for
 scalable modern mode
Thread-Topic: [PATCH v1 03/17] intel_iommu: Add a placeholder variable for
 scalable modern mode
Thread-Index: AQHa2OtCWmQl4pZpx0e1R3JC4utGS7H8MJAAgAEmyHA=
Date: Fri, 19 Jul 2024 02:47:22 +0000
Message-ID: <SJ0PR11MB6744F86F44C2C32C4B79C80A92AD2@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20240718081636.879544-1-zhenzhong.duan@intel.com>
 <20240718081636.879544-4-zhenzhong.duan@intel.com>
 <e41c8b79-1b86-42de-b1d5-dce7ed29d422@eviden.com>
In-Reply-To: <e41c8b79-1b86-42de-b1d5-dce7ed29d422@eviden.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|PH7PR11MB6056:EE_
x-ms-office365-filtering-correlation-id: 6a41308c-2fda-4e2e-e945-08dca79d1d73
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|7416014|366016|376014|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?elpHYkRPUUZ3RmRBOGMzVWZORWMzYjZaaHRsQ0lUcE1ybS9FRmM1RGFUVk8y?=
 =?utf-8?B?WTNSK25jUDBUSEtEWnpPVWE4c21hbFIvVXBaSGNvdGQ4UVl5Nm5zQ3R2N1c1?=
 =?utf-8?B?QldTc0FBWUo5U004OTZvcWtSWkpJaW84TGpTbTdINHpIWFpvbVlTV2NnR09X?=
 =?utf-8?B?ZW92TUROL0xwSHYwN3MxbXlod1hyaTJCSytaSVdHcS9zb1VBZm9uQkVoRzlw?=
 =?utf-8?B?Vkl1UHZqYnBzMjk3cEJMYmhNS0ExbFBJTXVSYkxFM3cvWmt6YU1LYmhYUTNY?=
 =?utf-8?B?dS9GV0lzWk5pdUloVjg1WUJQRWtCNFZKRTB2b3BLWUJONmFQbXlBN2RzWHRm?=
 =?utf-8?B?UEtkcXAzMGdIeDl6cWNDbnpIZTYxcFJTcm1sVHRrMXBwdGl0M3B4czBaRERB?=
 =?utf-8?B?QndGMWVnU1daeXBadmJpL1pCeU56MDE2bHkvdUk4WjFWM2lLT3ZKVVQwUzZF?=
 =?utf-8?B?MEN3cjc0UUZpSHdhNmdNWmszRzNCTS9QcndFeVlEeWVPWk9UK3lOelpBQ1RM?=
 =?utf-8?B?WGFwNEhBWHp5V25Zek5MRThLVitkU0FpbFV2QWhzeTJsTTFMcnBaNnlFMjB0?=
 =?utf-8?B?UllWWjBXYWJEdHQwcnhWNXd0YWFxVE9FTGtHQU42SVhtVWdVUnZrd3FrS1gx?=
 =?utf-8?B?ajZndE1uQUM2ZjVHMCtyTjZHQUhialNxMUErWGphcUc5c0IzZ3htdllUR09N?=
 =?utf-8?B?Q1cwLzh6ampvZnNBT1c3Q1N3KzZTS2FEOFNOdWFrZzBEV2QvVk02SDA3VFFS?=
 =?utf-8?B?emRoRkJJVFNidDBTNnJIbG0yOWFUWnI1cTNIYkdsNFZUdndWZVNFMjRrQmQ1?=
 =?utf-8?B?OWNnTWkwZUdxdDlGd0o0QzVNaHpHTkxyc1NsWm93RE12bTk1ZVF2UHFCMXZP?=
 =?utf-8?B?TlQ0Ym1mWW8zeHVWMjR5Qis0bUU3OXhkVEpIdUZxZFhiNFdrNDU3L29Nallz?=
 =?utf-8?B?YkRCYTd4YURzeTZLVGNKYmIwNmtlL2RLbkZXeU1zcGZqRFhwd3VmU3hZYnkw?=
 =?utf-8?B?eTl1WU5KK09tSERwVkIrQ0FUbUNqZWpWakYwOTFhM1VPeGNHUDRmR0JnL3pZ?=
 =?utf-8?B?V0pXWHB6N2dxVDVtUk85KzNwbEVSVDdwNzQ3ODM1d1EyMzFRRmY0TW03NU0w?=
 =?utf-8?B?b256Tnk2TUhDN1c1V3g3YXV6aGdaajlMVW9iaVQxMDAwTmZvMEh4TDhNUTFl?=
 =?utf-8?B?KzVqYmd5UXdXS20vaWxLMzEvaG5EczZWL1ByWUMzZ1NNTy9PQzhBMVBTYTh1?=
 =?utf-8?B?OWo0S3ZHS2d4VGQ2QmhySmIzbTRvbk5mQ3RMSFpQbmJHOTQycHpLQk5TNmRh?=
 =?utf-8?B?bnhrV0pNSmpWdmxTZ1VuNHdCRjZaMlAxKzJnakVtMkhOWGVpUmVNbUdWMDBW?=
 =?utf-8?B?RU81OFNhTDQxWllHakcwQzU5UVhkdEdRSCs2UXFhV3ExRHhiRnNjbnBWZE1Y?=
 =?utf-8?B?b3Q1bmVXVjlueU9mZytYb01GWTJZOGxzZmRKVXVPc3IxQUNxY3U1YlJ0Z0tV?=
 =?utf-8?B?Zm5NQndTNHFTTkRrOVNrdGNzWDdPaUpYU25acFZlNXRHVEtkOXZ6NkNOUVpj?=
 =?utf-8?B?WWhnZTlpQ3FjYjVWK2djRDl4VGNGbTFLTC9NRjdIVEJOYmVKUFY3ZVNtcG4z?=
 =?utf-8?B?U3NKZHFwa2daMUllWFhzczczcmlSSFFERnY0ZEhzMjl0bkVlaldyNG5xUmh1?=
 =?utf-8?B?RnZGeVZNMDlaaUUvRDhSSFVTVjVLZ3dzRUZpRDBWaTVwQ2I5MHNnQjczNm95?=
 =?utf-8?B?QTQyV0U4VXVjdTYrTEFrcS9ocGt0Zm5DTC9Ycjd4SFhhNlZCYmZqQjlBUXUw?=
 =?utf-8?B?dU82bVl1ajZHQm9Mcko3WGQ2emJMQ2xXdUd5VXQyVGJ5UmJremFISmJOT0p1?=
 =?utf-8?B?TkVpdmpSUFBzL25DRDhmbE9oUWVOOURkUkptRzR2RS9nMEE9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(366016)(376014)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RkhyMkp6WE5RRFE4TENiTURuZEN4MzMybnlzT2VUNlU3bW8wWTZVS1FTbUpO?=
 =?utf-8?B?WklrcUVSTkw5VlU1SDdOcFpuVEhUUkZnd2hMT1ZFbThQR2JTRXQvb1BiMHAw?=
 =?utf-8?B?ejUwZ0lzUUVsd1Y3Q1hsNWV2VE5IaWxNc0FCQXh6S3UrWjh4dHBXdjRZZUZR?=
 =?utf-8?B?TW1iQVU3ZmZLR2syUWdKcUEvSkdtM2RNWTRYT0pQUEo5cWJnbmRzeWhGa1I0?=
 =?utf-8?B?dHFhbWFWVFNBbDZhRWhxaXlzb3RaYWk0bmRpTDNENTBkdld1dVVWZnlmVHBN?=
 =?utf-8?B?N0w3QVFscjZWOElIWWMrQkxyMDdJQTVici9vT3ZGVkxCeGN4aEZSTHNRN0hs?=
 =?utf-8?B?QTh6ZUhzS05wdDNDRW5nd0tuV2R6N2c5cUNudzlCWnNIeG8yQU9Wd0ZaQXZt?=
 =?utf-8?B?eEZITEdXZTZqYTd1QTUyMlVEWVpzeU9mUEhBR3Vqb2o0YWpmZHduL0k2S0Y2?=
 =?utf-8?B?MXVxT0ZPZENpVmNyVWZmdFEwaWdjNkRjY0tXN285d2wrdFFzcFBBUjFlL1Zh?=
 =?utf-8?B?THlPOEEwZlNvcUR1eXVzcWgrZmNFUitRUDZBSGFVV1dvYTZrR0Y5RE5OdXll?=
 =?utf-8?B?bnpxQ0dRcXYrWUlRWTByak9yYXVBb0ZJRU5EVm9DZEFSUGk2dCt3Z1FHZ3hC?=
 =?utf-8?B?VDJJQWNubWwzSllrckdrbjRYRFFCaUEzdklhNElsM29xaC92TlU4KzZYR3Jz?=
 =?utf-8?B?T1RpRUpPU1FpcU9QckczQ0dEMzNxazFVQ0ttVm5SR0p0eUhMYlhXTEMxYStn?=
 =?utf-8?B?Y2wvRDFWRlMvS085UURXaXBaQis0ZE9uM2RjNGJQbWQwUkY4RlRBdmFkcmxV?=
 =?utf-8?B?dWNZYTFZK2NURmRlVnRDaHViMHNSRTNWampnTGhJTFNEZzk1MjAvNitRNTB1?=
 =?utf-8?B?VHlZOUV0bzd3TWhOYzVWY3pZa3lEUjVoRzR4UGtDU3ZCaTc0RDd0ZVdMQ1Ux?=
 =?utf-8?B?cmxDWkx0WDg3UkhCVi8wUVdpWDkwaUhUQUFHQmx4bVl0RHJvYVIwQUVIakZV?=
 =?utf-8?B?VU5ZeGIxbzYydGx4NmxYVFNrWVdoMUV0YXJ0YUlHeFAvejFEV3ZjL2ZxenBT?=
 =?utf-8?B?Uk1TMWtBdkhnY2tYaVBSR1VpR1g3UzI2NWhZM29mQTVRS3RYYzdFdDZiQlFY?=
 =?utf-8?B?V0hHamhMdUFMVnZlWUV3ZGpzMTgxMjdZUXJyVEI0ZW9abmxHWG43Z3EwdHNw?=
 =?utf-8?B?OFlHOWcyTzhtQzJHVkdCOUEzaDBkWHBNN08rWG9GUUxIR0NNaDRacnNRWUJI?=
 =?utf-8?B?UnJmS1hERktXNGR1WG9yZ20wRm1SbHIvS21kNUg4dXZmTjJrNlR5dCtsblc5?=
 =?utf-8?B?UDk3cE9DQmc2amx5NnliOWZkOWprenUwY2hMSGFUNmJkU1FzT2hUWFpwODIy?=
 =?utf-8?B?UkFaZVZ5YStxeDIrc1VvVGt5bldYdEpldzNnQUdZR3N0VHZDSmFJbU90R3Yx?=
 =?utf-8?B?ZFNtZ2hYcFNJNDlGaHJtTHgwY2RqeE5wK2NPN1diYm9WSlAxZWxhcnBPUlQw?=
 =?utf-8?B?aThESDgzUjNmTzMrOVhPUGJDVU5IR0NuM1BrWko3d2hEdnJoSDduWFpGRTRO?=
 =?utf-8?B?dXZCTGtGVCtuUElqdmhDSTR1RGtnS0p1c0lUNWJuQXBHc1ZUcG9uMUYxOFZo?=
 =?utf-8?B?ejVMYXp0d2ErSnVZRks3ajB2bzNPWHJlVGRueWZIbzI3aUhUK2RhS2dkSGZJ?=
 =?utf-8?B?QlJDdERMQzFsWW11eDQ4elczZjVpNU14Sk1tRWRVZVBiREpGZnVLYzJ1d1pn?=
 =?utf-8?B?UkNHakRZbSsveXE0UHVFQkQrM1FQdlhNNTJWY25XNk01SmxCWXYzR2FKS0hY?=
 =?utf-8?B?aDk5NWxhS01HZzR1bDlzZ1RoYnV1ak5NYlpKS2gyKzJzSW90Tk5EYnJ2VUo2?=
 =?utf-8?B?NW9ydW0xdUhPYjFWczFNZERIRnFtYkQ1cTJrSldqMkFhcm5EeHowd2U0OTd6?=
 =?utf-8?B?L2d1bHdFa0ppWHhBYmJzOTJNRzhEZWxMbGdqM0ZRZzV5ZUc5REptVjlieWpS?=
 =?utf-8?B?SllablNpd3pnUDFjL0lwS3JvWFc4UkN5ZExZUE5LdmRQbVp1NDJxeE1wNHhG?=
 =?utf-8?B?NlEzVVNWRDdRWC9OZlZxNzFmU25DM2Y2L0hWZkhtT1c1WVJpdWdTUEdSZ1B6?=
 =?utf-8?Q?8w1KSgvNJANWBbr7GnVzu096n?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a41308c-2fda-4e2e-e945-08dca79d1d73
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jul 2024 02:47:22.5502 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Vn5QJ2FgvmS5Pw5tRt0RkU1+Ifdcw2dokkPEtdfD5cmncG2LSSl2MgNoC1sO2u5CGhonNjxOT7/n4vmiNEWM7OA9EUur4Lx+dfbHBWrvFJM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6056
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.11;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IENMRU1FTlQgTUFUSElFVS0t
RFJJRiA8Y2xlbWVudC5tYXRoaWV1LS1kcmlmQGV2aWRlbi5jb20+DQo+U3ViamVjdDogUmU6IFtQ
QVRDSCB2MSAwMy8xN10gaW50ZWxfaW9tbXU6IEFkZCBhIHBsYWNlaG9sZGVyIHZhcmlhYmxlIGZv
cg0KPnNjYWxhYmxlIG1vZGVybiBtb2RlDQo+DQo+DQo+DQo+T24gMTgvMDcvMjAyNCAxMDoxNiwg
Wmhlbnpob25nIER1YW4gd3JvdGU6DQo+PiBDYXV0aW9uOiBFeHRlcm5hbCBlbWFpbC4gRG8gbm90
IG9wZW4gYXR0YWNobWVudHMgb3IgY2xpY2sgbGlua3MsIHVubGVzcyB0aGlzDQo+ZW1haWwgY29t
ZXMgZnJvbSBhIGtub3duIHNlbmRlciBhbmQgeW91IGtub3cgdGhlIGNvbnRlbnQgaXMgc2FmZS4N
Cj4+DQo+Pg0KPj4gQWRkIGFuIG5ldyBlbGVtZW50IHNjYWxhYmxlX21vZGUgaW4gSW50ZWxJT01N
VVN0YXRlIHRvIG1hcmsgc2NhbGFibGUNCj4+IG1vZGVybiBtb2RlLCB0aGlzIGVsZW1lbnQgd2ls
bCBiZSBleHBvc2VkIGFzIGFuIGludGVsX2lvbW11IHByb3BlcnR5DQo+PiBmaW5hbGx5Lg0KPj4N
Cj4+IEZvciBub3csIGl0J3Mgb25seSBhIHBsYWNlaGhvbGRlciBhbmQgdXNlZCBmb3IgY2FwL2Vj
YXAgaW5pdGlhbGl6YXRpb24sDQo+PiBjb21wYXRpYmlsaXR5IGNoZWNrIGFuZCBibG9jayBob3N0
IGRldmljZSBwYXNzdGhyb3VnaCB1bnRpbCBuZXN0aW5nDQo+PiBpcyBzdXBwb3J0ZWQuDQo+Pg0K
Pj4gU2lnbmVkLW9mZi1ieTogWWkgTGl1IDx5aS5sLmxpdUBpbnRlbC5jb20+DQo+PiBTaWduZWQt
b2ZmLWJ5OiBaaGVuemhvbmcgRHVhbiA8emhlbnpob25nLmR1YW5AaW50ZWwuY29tPg0KPj4gLS0t
DQo+PiAgIGh3L2kzODYvaW50ZWxfaW9tbXVfaW50ZXJuYWwuaCB8ICAyICsrDQo+PiAgIGluY2x1
ZGUvaHcvaTM4Ni9pbnRlbF9pb21tdS5oICB8ICAxICsNCj4+ICAgaHcvaTM4Ni9pbnRlbF9pb21t
dS5jICAgICAgICAgIHwgMzQgKysrKysrKysrKysrKysrKysrKysrKystLS0tLS0tLS0tLQ0KPj4g
ICAzIGZpbGVzIGNoYW5nZWQsIDI2IGluc2VydGlvbnMoKyksIDExIGRlbGV0aW9ucygtKQ0KPj4N
Cj4+IGRpZmYgLS1naXQgYS9ody9pMzg2L2ludGVsX2lvbW11X2ludGVybmFsLmgNCj5iL2h3L2kz
ODYvaW50ZWxfaW9tbXVfaW50ZXJuYWwuaA0KPj4gaW5kZXggYzBjYTdiMzcyZi4uNGUwMzMxY2Fi
YSAxMDA2NDQNCj4+IC0tLSBhL2h3L2kzODYvaW50ZWxfaW9tbXVfaW50ZXJuYWwuaA0KPj4gKysr
IGIvaHcvaTM4Ni9pbnRlbF9pb21tdV9pbnRlcm5hbC5oDQo+PiBAQCAtMTk1LDYgKzE5NSw3IEBA
DQo+PiAgICNkZWZpbmUgVlREX0VDQVBfUEFTSUQgICAgICAgICAgICAgICgxVUxMIDw8IDQwKQ0K
Pj4gICAjZGVmaW5lIFZURF9FQ0FQX1NNVFMgICAgICAgICAgICAgICAoMVVMTCA8PCA0MykNCj4+
ICAgI2RlZmluZSBWVERfRUNBUF9TTFRTICAgICAgICAgICAgICAgKDFVTEwgPDwgNDYpDQo+PiAr
I2RlZmluZSBWVERfRUNBUF9GTFRTICAgICAgICAgICAgICAgKDFVTEwgPDwgNDcpDQo+Pg0KPj4g
ICAvKiBDQVBfUkVHICovDQo+PiAgIC8qIChvZmZzZXQgPj4gNCkgPDwgMjQgKi8NCj4+IEBAIC0y
MTEsNiArMjEyLDcgQEANCj4+ICAgI2RlZmluZSBWVERfQ0FQX1NMTFBTICAgICAgICAgICAgICAg
KCgxVUxMIDw8IDM0KSB8ICgxVUxMIDw8IDM1KSkNCj4+ICAgI2RlZmluZSBWVERfQ0FQX0RSQUlO
X1dSSVRFICAgICAgICAgKDFVTEwgPDwgNTQpDQo+PiAgICNkZWZpbmUgVlREX0NBUF9EUkFJTl9S
RUFEICAgICAgICAgICgxVUxMIDw8IDU1KQ0KPj4gKyNkZWZpbmUgVlREX0NBUF9GUzFHUCAgICAg
ICAgICAgICAgICgxVUxMIDw8IDU2KQ0KPj4gICAjZGVmaW5lIFZURF9DQVBfRFJBSU4gICAgICAg
ICAgICAgICAoVlREX0NBUF9EUkFJTl9SRUFEIHwNCj5WVERfQ0FQX0RSQUlOX1dSSVRFKQ0KPj4g
ICAjZGVmaW5lIFZURF9DQVBfQ00gICAgICAgICAgICAgICAgICAoMVVMTCA8PCA3KQ0KPj4gICAj
ZGVmaW5lIFZURF9QQVNJRF9JRF9TSElGVCAgICAgICAgICAyMA0KPj4gZGlmZiAtLWdpdCBhL2lu
Y2x1ZGUvaHcvaTM4Ni9pbnRlbF9pb21tdS5oDQo+Yi9pbmNsdWRlL2h3L2kzODYvaW50ZWxfaW9t
bXUuaA0KPj4gaW5kZXggMWViMDVjMjlmYy4uNzg4ZWQ0MjQ3NyAxMDA2NDQNCj4+IC0tLSBhL2lu
Y2x1ZGUvaHcvaTM4Ni9pbnRlbF9pb21tdS5oDQo+PiArKysgYi9pbmNsdWRlL2h3L2kzODYvaW50
ZWxfaW9tbXUuaA0KPj4gQEAgLTI2Miw2ICsyNjIsNyBAQCBzdHJ1Y3QgSW50ZWxJT01NVVN0YXRl
IHsNCj4+DQo+PiAgICAgICBib29sIGNhY2hpbmdfbW9kZTsgICAgICAgICAgICAgIC8qIFJPIC0g
aXMgY2FwIENNIGVuYWJsZWQ/ICovDQo+PiAgICAgICBib29sIHNjYWxhYmxlX21vZGU7ICAgICAg
ICAgICAgIC8qIFJPIC0gaXMgU2NhbGFibGUgTW9kZSBzdXBwb3J0ZWQ/ICovDQo+PiArICAgIGJv
b2wgc2NhbGFibGVfbW9kZXJuOyAgICAgICAgICAgLyogUk8gLSBpcyBtb2Rlcm4gU00gc3VwcG9y
dGVkPyAqLw0KPj4gICAgICAgYm9vbCBzbm9vcF9jb250cm9sOyAgICAgICAgICAgICAvKiBSTyAt
IGlzIFNOUCBmaWxlZCBzdXBwb3J0ZWQ/ICovDQo+Pg0KPj4gICAgICAgZG1hX2FkZHJfdCByb290
OyAgICAgICAgICAgICAgICAvKiBDdXJyZW50IHJvb3QgdGFibGUgcG9pbnRlciAqLw0KPj4gZGlm
ZiAtLWdpdCBhL2h3L2kzODYvaW50ZWxfaW9tbXUuYyBiL2h3L2kzODYvaW50ZWxfaW9tbXUuYw0K
Pj4gaW5kZXggMWNmZjhiMDBhZS4uNDBjYmQ0YTBmNCAxMDA2NDQNCj4+IC0tLSBhL2h3L2kzODYv
aW50ZWxfaW9tbXUuYw0KPj4gKysrIGIvaHcvaTM4Ni9pbnRlbF9pb21tdS5jDQo+PiBAQCAtNzU1
LDE2ICs3NTUsMjAgQEAgc3RhdGljIGlubGluZSBib29sDQo+dnRkX2lzX2xldmVsX3N1cHBvcnRl
ZChJbnRlbElPTU1VU3RhdGUgKnMsIHVpbnQzMl90IGxldmVsKQ0KPj4gICB9DQo+Pg0KPj4gICAv
KiBSZXR1cm4gdHJ1ZSBpZiBjaGVjayBwYXNzZWQsIG90aGVyd2lzZSBmYWxzZSAqLw0KPj4gLXN0
YXRpYyBpbmxpbmUgYm9vbCB2dGRfcGVfdHlwZV9jaGVjayhYODZJT01NVVN0YXRlICp4ODZfaW9t
bXUsDQo+PiAtICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFZURFBBU0lERW50
cnkgKnBlKQ0KPj4gK3N0YXRpYyBpbmxpbmUgYm9vbCB2dGRfcGVfdHlwZV9jaGVjayhJbnRlbElP
TU1VU3RhdGUgKnMsDQo+VlREUEFTSURFbnRyeSAqcGUpDQo+PiAgIHsNCj5XaGF0IGFib3V0IHVz
aW5nIHRoZSBjYXAvZWNhcCByZWdpc3RlcnMgdG8ga25vdyBpZiB0aGUgdHJhbnNsYXRpb24gdHlw
ZXMNCj5hcmUgc3VwcG9ydGVkIG9yIG5vdC4NCj5PdGhlcndpc2UsIHdlIGNvdWxkIGFkZCBhIGNv
bW1lbnQgdG8gZXhwbGFpbiB3aHkgd2UgZXhwZWN0DQo+cy0+c2NhbGFibGVfbW9kZXJuIHRvIGdp
dmUgdXMgZW5vdWdoIGluZm9ybWF0aW9uLg0KDQpXaGF0IGFib3V0IGJlbG93Og0KDQovKg0KICpW
VERfRUNBUF9GTFRTIGluIGVjYXAgaXMgc2V0IGlmIHMtPnNjYWxhYmxlX21vZGVybiBpcyB0cnVl
LCBvciBlbHNlIFZURF9FQ0FQX1NMVFMgY2FuIGJlIHNldCBvciBub3QgZGVwZW5kaW5nIG9uIHMt
PnNjYWxhYmxlX21vZGUuDQogKlNvIGl0J3Mgc2ltcGxlciB0byBjaGVjayBzLT5zY2FsYWJsZV9t
b2Rlcm4gZGlyZWN0bHkgZm9yIGEgUEFTSUQgZW50cnkgdHlwZSBpbnN0ZWFkIGVjYXAgYml0cy4N
CiAqLw0KDQpUaGFua3MNClpoZW56aG9uZw0KDQo+PiArICAgIFg4NklPTU1VU3RhdGUgKng4Nl9p
b21tdSA9IFg4Nl9JT01NVV9ERVZJQ0Uocyk7DQo+PiArDQo+PiAgICAgICBzd2l0Y2ggKFZURF9Q
RV9HRVRfVFlQRShwZSkpIHsNCj4+ICsgICAgY2FzZSBWVERfU01fUEFTSURfRU5UUllfRkxUOg0K
Pj4gKyAgICAgICAgcmV0dXJuIHMtPnNjYWxhYmxlX21vZGVybjsNCj4+ICAgICAgIGNhc2UgVlRE
X1NNX1BBU0lEX0VOVFJZX1NMVDoNCj4+IC0gICAgICAgIHJldHVybiB0cnVlOw0KPj4gKyAgICAg
ICAgcmV0dXJuICFzLT5zY2FsYWJsZV9tb2Rlcm47DQo+PiArICAgIGNhc2UgVlREX1NNX1BBU0lE
X0VOVFJZX05FU1RFRDoNCj4+ICsgICAgICAgIC8qIE5vdCBzdXBwb3J0IE5FU1RFRCBwYWdlIHRh
YmxlIHR5cGUgeWV0ICovDQo+PiArICAgICAgICByZXR1cm4gZmFsc2U7DQo+PiAgICAgICBjYXNl
IFZURF9TTV9QQVNJRF9FTlRSWV9QVDoNCj4+ICAgICAgICAgICByZXR1cm4geDg2X2lvbW11LT5w
dF9zdXBwb3J0ZWQ7DQo+PiAtICAgIGNhc2UgVlREX1NNX1BBU0lEX0VOVFJZX0ZMVDoNCj4+IC0g
ICAgY2FzZSBWVERfU01fUEFTSURfRU5UUllfTkVTVEVEOg0KPj4gICAgICAgZGVmYXVsdDoNCj4+
ICAgICAgICAgICAvKiBVbmtub3duIHR5cGUgKi8NCj4+ICAgICAgICAgICByZXR1cm4gZmFsc2U7
DQo+PiBAQCAtODEzLDcgKzgxNyw2IEBAIHN0YXRpYyBpbnQNCj52dGRfZ2V0X3BlX2luX3Bhc2lk
X2xlYWZfdGFibGUoSW50ZWxJT01NVVN0YXRlICpzLA0KPj4gICAgICAgdWludDhfdCBwZ3R0Ow0K
Pj4gICAgICAgdWludDMyX3QgaW5kZXg7DQo+PiAgICAgICBkbWFfYWRkcl90IGVudHJ5X3NpemU7
DQo+PiAtICAgIFg4NklPTU1VU3RhdGUgKng4Nl9pb21tdSA9IFg4Nl9JT01NVV9ERVZJQ0Uocyk7
DQo+Pg0KPj4gICAgICAgaW5kZXggPSBWVERfUEFTSURfVEFCTEVfSU5ERVgocGFzaWQpOw0KPj4g
ICAgICAgZW50cnlfc2l6ZSA9IFZURF9QQVNJRF9FTlRSWV9TSVpFOw0KPj4gQEAgLTgyNyw3ICs4
MzAsNyBAQCBzdGF0aWMgaW50DQo+dnRkX2dldF9wZV9pbl9wYXNpZF9sZWFmX3RhYmxlKEludGVs
SU9NTVVTdGF0ZSAqcywNCj4+ICAgICAgIH0NCj4+DQo+PiAgICAgICAvKiBEbyB0cmFuc2xhdGlv
biB0eXBlIGNoZWNrICovDQo+PiAtICAgIGlmICghdnRkX3BlX3R5cGVfY2hlY2soeDg2X2lvbW11
LCBwZSkpIHsNCj4+ICsgICAgaWYgKCF2dGRfcGVfdHlwZV9jaGVjayhzLCBwZSkpIHsNCj4+ICAg
ICAgICAgICByZXR1cm4gLVZURF9GUl9QQVNJRF9UQUJMRV9FTlRSWV9JTlY7DQo+PiAgICAgICB9
DQo+Pg0KPj4gQEAgLTM4NjEsNyArMzg2NCwxMyBAQCBzdGF0aWMgYm9vbCB2dGRfY2hlY2tfaGlv
ZChJbnRlbElPTU1VU3RhdGUNCj4qcywgSG9zdElPTU1VRGV2aWNlICpoaW9kLA0KPj4gICAgICAg
ICAgIHJldHVybiBmYWxzZTsNCj4+ICAgICAgIH0NCj4+DQo+PiAtICAgIHJldHVybiB0cnVlOw0K
Pj4gKyAgICBpZiAoIXMtPnNjYWxhYmxlX21vZGVybikgew0KPj4gKyAgICAgICAgLyogQWxsIGNo
ZWNrcyByZXF1ZXN0ZWQgYnkgVlREIG5vbi1tb2Rlcm4gbW9kZSBwYXNzICovDQo+PiArICAgICAg
ICByZXR1cm4gdHJ1ZTsNCj4+ICsgICAgfQ0KPj4gKw0KPj4gKyAgICBlcnJvcl9zZXRnKGVycnAs
ICJob3N0IGRldmljZSBpcyB1bnN1cHBvcnRlZCBpbiBzY2FsYWJsZSBtb2Rlcm4gbW9kZQ0KPnll
dCIpOw0KPj4gKyAgICByZXR1cm4gZmFsc2U7DQo+PiAgIH0NCj4+DQo+PiAgIHN0YXRpYyBib29s
IHZ0ZF9kZXZfc2V0X2lvbW11X2RldmljZShQQ0lCdXMgKmJ1cywgdm9pZCAqb3BhcXVlLCBpbnQN
Cj5kZXZmbiwNCj4+IEBAIC00MDg0LDcgKzQwOTMsMTAgQEAgc3RhdGljIHZvaWQgdnRkX2NhcF9p
bml0KEludGVsSU9NTVVTdGF0ZSAqcykNCj4+ICAgICAgIH0NCj4+DQo+PiAgICAgICAvKiBUT0RP
OiByZWFkIGNhcC9lY2FwIGZyb20gaG9zdCB0byBkZWNpZGUgd2hpY2ggY2FwIHRvIGJlIGV4cG9z
ZWQuDQo+Ki8NCj4+IC0gICAgaWYgKHMtPnNjYWxhYmxlX21vZGUpIHsNCj4+ICsgICAgaWYgKHMt
PnNjYWxhYmxlX21vZGVybikgew0KPj4gKyAgICAgICAgcy0+ZWNhcCB8PSBWVERfRUNBUF9TTVRT
IHwgVlREX0VDQVBfRkxUUzsNCj4+ICsgICAgICAgIHMtPmNhcCB8PSBWVERfQ0FQX0ZTMUdQOw0K
Pj4gKyAgICB9IGVsc2UgaWYgKHMtPnNjYWxhYmxlX21vZGUpIHsNCj4+ICAgICAgICAgICBzLT5l
Y2FwIHw9IFZURF9FQ0FQX1NNVFMgfCBWVERfRUNBUF9TUlMgfCBWVERfRUNBUF9TTFRTOw0KPj4g
ICAgICAgfQ0KPj4NCj4+IEBAIC00MjUxLDkgKzQyNjMsOSBAQCBzdGF0aWMgYm9vbCB2dGRfZGVj
aWRlX2NvbmZpZyhJbnRlbElPTU1VU3RhdGUNCj4qcywgRXJyb3IgKiplcnJwKQ0KPj4gICAgICAg
ICAgIH0NCj4+ICAgICAgIH0NCj4+DQo+PiAtICAgIC8qIEN1cnJlbnRseSBvbmx5IGFkZHJlc3Mg
d2lkdGhzIHN1cHBvcnRlZCBhcmUgMzkgYW5kIDQ4IGJpdHMgKi8NCj4+ICAgICAgIGlmICgocy0+
YXdfYml0cyAhPSBWVERfSE9TVF9BV18zOUJJVCkgJiYNCj4+IC0gICAgICAgIChzLT5hd19iaXRz
ICE9IFZURF9IT1NUX0FXXzQ4QklUKSkgew0KPj4gKyAgICAgICAgKHMtPmF3X2JpdHMgIT0gVlRE
X0hPU1RfQVdfNDhCSVQpICYmDQo+PiArICAgICAgICAhcy0+c2NhbGFibGVfbW9kZXJuKSB7DQo+
PiAgICAgICAgICAgZXJyb3Jfc2V0ZyhlcnJwLCAiU3VwcG9ydGVkIHZhbHVlcyBmb3IgYXctYml0
cyBhcmU6ICVkLCAlZCIsDQo+PiAgICAgICAgICAgICAgICAgICAgICBWVERfSE9TVF9BV18zOUJJ
VCwgVlREX0hPU1RfQVdfNDhCSVQpOw0KPj4gICAgICAgICAgIHJldHVybiBmYWxzZTsNCj4+IC0t
DQo+PiAyLjM0LjENCj4+DQo=

