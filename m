Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6003EC3DA63
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jul 2024 06:15:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWVGx-0003ib-7D; Wed, 24 Jul 2024 02:14:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sWVGr-0003gX-JL
 for qemu-devel@nongnu.org; Wed, 24 Jul 2024 02:14:42 -0400
Received: from mgamail.intel.com ([192.198.163.7])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sWVGp-0006av-I9
 for qemu-devel@nongnu.org; Wed, 24 Jul 2024 02:14:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1721801679; x=1753337679;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=5QTPVShtx22nwzSmMGqHjk5f3I2kqBotb7ry9HeApvY=;
 b=gX/r4XKR/7jl58N2Xhf+StsLe4X0ptq54fP6L+I4THlPthf9ShWiUbzL
 BrST2V7mIwodXl3Y41g6mRUvpFglxDjQEL/F+JsJXR4BLyc0x5awL4gXB
 Fc8W6b13OKoMYYywjfHN9Grt2rDUiAFNi6CHdoRZiv/+18sH6D5/bxvEs
 VYC4zgqJZx17de/sDNE/Vt91IGeauPdXCgi4jIW3TdWPM0S0bMGbRhefv
 Em0T/2ZHMFaAG+ScnRq+oyUU+GsHzSMWEUROfSSs0j6blDRiVeuHBCEqm
 hL7Qj6E4ZZ1I9k0EoySUxd9H+omAe6Shiqtj2UKrMVmBy+Qquz5580U79 A==;
X-CSE-ConnectionGUID: d4F6vgm/TviIbWCD6hBKkg==
X-CSE-MsgGUID: LoTHA/ziTwCdAqkNVJkfdw==
X-IronPort-AV: E=McAfee;i="6700,10204,11142"; a="44883788"
X-IronPort-AV: E=Sophos;i="6.09,232,1716274800"; d="scan'208";a="44883788"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jul 2024 23:14:37 -0700
X-CSE-ConnectionGUID: KPUlFV8yTUGKuAOz94XoRg==
X-CSE-MsgGUID: 5YlPy91CTMW3+yaAjsvZEg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,232,1716274800"; d="scan'208";a="75695892"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
 by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 23 Jul 2024 23:14:36 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 23 Jul 2024 23:14:36 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 23 Jul 2024 23:14:36 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 23 Jul 2024 23:14:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IKs+MTBjPTxerq7Uooz6pHLhe8sM2kuzzujHLn2X1cGe1Fp72e4u7y01u2sFYj987a1u74xdL8ZqaVB/da3OO9v29teaTLLrgqXAIul9FDvFtllNjvKR6G+dzv9mTfdznAWb452b5OOeHciqnILR2afGNqV5pvMNvMTmt1HYZ7S73HzwfNOW6H8Hv7tNl6QsKZlHzppP12Mp/1uVUl4HUtXaC1tB1aS3mBlbjk6/pDD/LsnzVLc61emq8ZxqX7gjK77bGOSJM/7Vlep1ZqRQp5rKXA7Nktkqf+kf4jsJojVm4oeZ3xASp88ua+GVhBinpaSmugM8TO59i81+ZXY2Ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5QTPVShtx22nwzSmMGqHjk5f3I2kqBotb7ry9HeApvY=;
 b=Ie1HSdihvFHslrxs1qH8FAkOhjs5DQKhAp4OD1xxaZ+lVy0/qnMc7DyDoAFiGBNEmeoko+/WlikoKae9O/C435vsoyqBYtnned3XlttLpwTTlDS2KdLhBanBQHelA5OvOQEXZ/xY9QqKMef4lsxdhNjBgCH90F8OV6YPhIhjH3JvkW5LTE8DfXdwcVkPQO32w+1XI3Zf50IocaOUyvsmukF5CplDNfjgtU+WYsimaJgue7D4mpfTnoRLQmFFybnIcC9VXMC8NRYfpXeSYxHWVyZ5Hs+hgA3xPuImq5GMmPCFyvJkSc0ncglovdQTadgm286EET6zXK+6tTz+wEYvIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by SJ0PR11MB4847.namprd11.prod.outlook.com (2603:10b6:a03:2d9::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.20; Wed, 24 Jul
 2024 06:14:33 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091%7]) with mapi id 15.20.7784.016; Wed, 24 Jul 2024
 06:14:33 +0000
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
 L" <yi.l.liu@intel.com>, "Peng, Chao P" <chao.p.peng@intel.com>, "Marcel
 Apfelbaum" <marcel.apfelbaum@gmail.com>, Thomas Huth <thuth@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: RE: [PATCH v1 17/17] tests/qtest: Add intel-iommu test
Thread-Topic: [PATCH v1 17/17] tests/qtest: Add intel-iommu test
Thread-Index: AQHa2Otqr8F2tCxDOkGpok89/0kF67IFaygAgAAEUCA=
Date: Wed, 24 Jul 2024 06:14:33 +0000
Message-ID: <SJ0PR11MB6744E57B670F196E6328C1E392AA2@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20240718081636.879544-1-zhenzhong.duan@intel.com>
 <20240718081636.879544-18-zhenzhong.duan@intel.com>
 <6635ba0b-9e58-4dd2-be0a-3b749eb9e9cf@eviden.com>
In-Reply-To: <6635ba0b-9e58-4dd2-be0a-3b749eb9e9cf@eviden.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|SJ0PR11MB4847:EE_
x-ms-office365-filtering-correlation-id: 9fafdde0-31fa-47d6-6af3-08dcaba7e325
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|366016|1800799024|376014|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?VlBHaGl0V3FkQmFFYVhCTTZ2SXNqZCtMVlVJelUyV2ZvdUFpNW1YUHNTS01M?=
 =?utf-8?B?bUJ4clU2bWRuYVdMK0Q1cnRkWVZKaExnanpMYXU5eWZiQUFzWEVIRCtEODFB?=
 =?utf-8?B?OERhTWtWN1Vydi9UeVhiYlF3UVU4MDFRRnhqQzlaRk5jVm1OMnpwQmx3Uk5N?=
 =?utf-8?B?YVpjOHJQdUFkWUZEdDJFcE80OW5yRVN3L3RTQlRXeFlRM2psUkd6ZWNXZjNl?=
 =?utf-8?B?WDJ5c0V0elcwdVhUOVJRUFZ4U0taSzhmdVBJQkNHb2hOZDF1c3Q5eWVPelAy?=
 =?utf-8?B?MjcyWlMzNiticVdhMnVJQ2NkSk5xRWpTdjFjR2Y1TkRSUjcvUXFWSnFiOHVj?=
 =?utf-8?B?Vm5QOGViZm5xRFJOc05ab3FmN05ua3lQanUvOUdES2dVZGhiY3ZjZ2lZNlgw?=
 =?utf-8?B?RUR2b21ndkJPRVBQUzhoV0l5RWFpNE96MEJrWkhCalZTbEZyT0gzSStOSDZ6?=
 =?utf-8?B?dVJzaVhCdVJ1VTNnakVubEYwdTJuUWkyLzFKZmVwbVZzM3JnVHNUWnJMVlZ2?=
 =?utf-8?B?Ny85OHdpZm05L2pZSmdvTUhKdFJ1YmVBT3E2enR3a3hvMGtGVUZ0RzJoZ2Ex?=
 =?utf-8?B?am1xbmFUQ3Z0R0o2ejhZVUY0QUw5UmZjaWlWMVVwTHRiaHQ5Z3dOQ3N4MWlU?=
 =?utf-8?B?U0NwRGdrRUVVQ1VOMGNsa1cyVXZMOXRHSmMrTlZVUDd4MVpVNlZibEZ2SG01?=
 =?utf-8?B?dVl3NFlLVGpNTHlmMFdoR1Z3MzFPaGFuRkRqL0JVU2VHbzByRjhqQVZFZ2NU?=
 =?utf-8?B?ZVlFRXJHa0RIZ0JsZEd3NDgwaytaejFGbFFKK0RiWUh2V2tyeEhGMlBYMUwx?=
 =?utf-8?B?aDFzYUdmcjVocEJxNDh6U1VFdTR2Uk9qQnVqVGZ2Qjh6SUhxTjJwblVJdXdj?=
 =?utf-8?B?NDNJTXMvTHRqS0IxMHg0TWM4clAram0wWEp1WkkvNFduNjVEejVoNnN0TjJT?=
 =?utf-8?B?YWxNditEVW9XUDhQak1PMGllZW4vWG1NbVFla3lXQmt1bjN3ZGNKVDFVSjBW?=
 =?utf-8?B?Z2tsczBuWk5VaUY4aVNQRnYrQmdvaVJDbVc0YkQ2ZEpUNnJ5cVRhSzlFUW1r?=
 =?utf-8?B?SUpaVnR1aUFvUG5tTTNCcjNzSDM5dkp4QnlsdVE1b1ltWk80R1hETGxYWkFy?=
 =?utf-8?B?YzdOTUxoL3hXcG9qdzlUSDVKOTJPTTc3TXViR3RrdkM0T0w0M3ZMMHB4WFNv?=
 =?utf-8?B?eTZGa2xoZjlNbjRleUd0TTBIMTVRcEc1Ukc2QlBCQVE4RGhYVUNXZWZoazQv?=
 =?utf-8?B?WUN3UzJ6TDF5VXpha2pTR2VhY0ErMnd5MjNwVWQwNjFxWFF3UWczQnRxaDZY?=
 =?utf-8?B?L2t1TGkreXZuV1c1YjZrTnZmN2dRNEZOWi9MOGUrL0U0NElTR3h2bzF5Mjg5?=
 =?utf-8?B?WGtwaThkQ054NHBuU0VvSFBrcjdocEZZOEJhNnlmL2dwb2hZOGtTdjZkeCs2?=
 =?utf-8?B?RkdXOU9FRm9BRkNuMFFLdzVIenFrVGx1dXpMSDExbVF5QURmbDFxem9OZXRK?=
 =?utf-8?B?eXR1YUFuaXoxbGlVSVIzdDU4TXd1amRTbExSTUxjSlUyeG5TQ3Y0NFNOaUtP?=
 =?utf-8?B?VFhta09XRWhoSDdZVlVEa29BOXZSR24rcDZwM05yODhpS0IrVXhsemtpRzVa?=
 =?utf-8?B?R01yWm1OWkF2UEJpd0ZlQlVsZ3N0UkdyK21nb0Y4ZW1DQW1aZW1TTjQ2bFBx?=
 =?utf-8?B?TXpVa016M2c2WlBxZlNQOW5Hd3ZMV0lEVThEdUNFODdObWtGb21DdWZaQVAw?=
 =?utf-8?B?MitmdHpJSEZFTis5MldlUkhqc1NuQklCY0cvQlorS1VGWTZCQnZOT3h5TzBx?=
 =?utf-8?B?MzhNVEp6anJOWXkvM0lYcWJ3UFNzUjJzMXdNcmkxdjM4dHhBSzgxaTBwSjQ1?=
 =?utf-8?B?NHhzRWtsRXl0MGFabkpIS05VSXlJeFpxajBNU0dZaHhCN2c9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(366016)(1800799024)(376014)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MEorSHYxeTZiRW5NaSszMEtWSXdXZVNHSnFwZ3BZOGxKRHE5T1VveloyOHZO?=
 =?utf-8?B?Q0V0MHhwVjR6NXFDY0xQWFo0YjVuZ1dGUktJdkI3dDM0cWxHT29jVlpWcTZp?=
 =?utf-8?B?TFVYbkNjNWlrZzV0d0NqekpFUU4waXRkRXNkRHJ6d0VSUG9DZHpJUkRyNVRy?=
 =?utf-8?B?dXBhY1h5R3VsOE9pUWJIMkpoYU9tdlhxOFc4K3BXb0ZHQXpESFk0YlJYWEUr?=
 =?utf-8?B?WXpVcXdMNTc4UElEZnp3T05lK3lnRjhGODNwZjMrakUxNmxjNkVFcXVJSWhp?=
 =?utf-8?B?QkZRbGVYcWNudVlVVktHQ29yMitJRGxJZnN3REtvcktlV3V1Qy9DUnoyNUpv?=
 =?utf-8?B?OFJScGxsOVdrL3dhY09lNDlRdXhrVmszUUp2MFpyVU8vQVFkSFg1anZDS2Nj?=
 =?utf-8?B?cHZDSWwybUFKdStqbEZVTCtuNm9uK1d3YmtaRWZONzVsd0xEMXpKVUNYQ09v?=
 =?utf-8?B?NkdWYVdXRHY3RVMwSkd6Uk55YlM3TnhvRWlqZExsbk1BNW16cm15S29zVmxO?=
 =?utf-8?B?QWw0OHc0WTVIZlQ2OVVBaHZYVHZVNnc3SkF2ekEwMGNEUG5JZkZSLzR3QnJM?=
 =?utf-8?B?RklYZHlsZXJSdFI3SDJFY0ZsN1RrcDUwNzRneHFLeDBXYlhtVGM2bWtKUU5Q?=
 =?utf-8?B?MThJcElMb0ZTL1VBTHAxSUhqeUc1enJrNVoxazdHZllvbmdKUHF1Sk4wYzJs?=
 =?utf-8?B?R2NPOGxENStMaFFLcVhNQTJyWXJTTG9QNjdoU1dvWE5DQmtnTkU4NkZJRXcv?=
 =?utf-8?B?TUNxbjVGK3lRd05rMjFnQ3lPWiswUlhPTmVYTWVyR2hKek1nQzZyRnFjelZO?=
 =?utf-8?B?bGRZWXVZS3ZIRUlqWDNDNmZjUi9FSnlwL0JTY2ltVlFXMHdGcHBzcDh6OUpt?=
 =?utf-8?B?YjI1QS9FMkdCVUNCcXZEeWg5UERzU0VobVdUV2RvNmtyNGdvdm9xRVVTYWly?=
 =?utf-8?B?WjhncVlUY0x1NUxZY0lucmJuVjlQTXZZUFgzR1pQZmE1U1JtZ1FST1krRmZk?=
 =?utf-8?B?U3dJR0Urb3R0dVVqN0ZQakgxT0NYUHRPOUF5K1A0RFR0Q2Uzbk1yVjQ2am85?=
 =?utf-8?B?c1pRZ1ZBZXY5Z3lqYVNvNGdVQzJUUGdJYVdkQ2VCRTBMODdPVXJ4cm1MQ1c4?=
 =?utf-8?B?bWVacFZNc0UwWVN2WTRmL0dFV2tJeW9SZXZJNE52anBYTXQ2ODF5OGcvblo1?=
 =?utf-8?B?ZitDQ2c0eEkzQXo0WmpnTVhINGZYTW1GcHk5NXdkdkF6MXhVNFpJUStJdnF5?=
 =?utf-8?B?MkgyZDZBa3lGZk5adURnazZ0UGtWbGJJakRhN1p4cVdBK1VXY0N0OFV3SW9Y?=
 =?utf-8?B?R3gxODF1eEdib3FjMWlQK0t4UEs0K2N1SFNiZlA5SEhRWnk2WEVMNHdJQzU1?=
 =?utf-8?B?SHI1ZUdCZDFZRk5uVGFTVys0QUQ4TlNpdVUwZ2IvejlsaEtzeDFLclE1RVIw?=
 =?utf-8?B?d0FGVEpFWUdPVEp5OTA5dUE5OGRTbGIxZkUvek1UdmRHeU1WM2RuRHZvM0tK?=
 =?utf-8?B?bnp1dVF2NFpyc0ZETDN6OWxKQTN3eDcyTDBUM0pUWmNnUHFlc2ZHdk1YZ0RH?=
 =?utf-8?B?cUpyTlVEbnN3RG1xRjhtNWMwYTNOaGJXSnJQQ1l4MjEva0JRL1BuVlJtdE4r?=
 =?utf-8?B?cXp3U21wZDNZeVM4NVZ5MEw2V0IwS2tzdGsyZ2lTZ3hmS2xmRnZUL0hnVnBl?=
 =?utf-8?B?ZTI1eFlvem1QNzl5dVhib1lrMjMrNzlaUjNxdW8yV1N3K2ZMYUxBdENzaEt1?=
 =?utf-8?B?SDV6VFNVZkRNd0RUU3JpZXVtSjdrWVFkb1pBaUtYTG1qenh2VWN5bDZhbTNl?=
 =?utf-8?B?Mm02ZVkxRTBrVnJiSzVBVjFQbFV3d1Jkd1B6bGJvbEhibkxHM1FDVlA0K0tu?=
 =?utf-8?B?Sm1XczUwazd2KzJuYWxXR0pWc0xiM2hSb0VnT1gwU1gzZ05mTlBPemdjNVhL?=
 =?utf-8?B?VmhLdjk4cjdkSUNMVlY4K3oxdUpPbnpzMlZSMjdJdlhPWjkwWVJkaCtnK1Z3?=
 =?utf-8?B?bjJPZWo1eTAwVXRrWU5pTG1idjRkSlJsYUZweG5iVjZlZUErc25RR1p6bzdS?=
 =?utf-8?B?U05aajBXL2UxVGRrS1JTZGRRWGEwVTBoWWlONlQrTzRvNjB4cUF0ZnpKUnhY?=
 =?utf-8?Q?CkRgKI+tgh6JajpoNJxBJn+mX?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fafdde0-31fa-47d6-6af3-08dcaba7e325
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jul 2024 06:14:33.8408 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RbbXHa8z+N3jsHmJumfFHkD1bplF9+2vaXNMDPa2tJqUGtx8fxPLea9ueb9kzQtGr5yVzzdMEle4p+e41QQZcdwGzoM8AIYxCbzvWo+teMY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4847
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.7;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.133,
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
QVRDSCB2MSAxNy8xN10gdGVzdHMvcXRlc3Q6IEFkZCBpbnRlbC1pb21tdSB0ZXN0DQo+DQo+DQo+
DQo+T24gMTgvMDcvMjAyNCAxMDoxNiwgWmhlbnpob25nIER1YW4gd3JvdGU6DQo+PiBDYXV0aW9u
OiBFeHRlcm5hbCBlbWFpbC4gRG8gbm90IG9wZW4gYXR0YWNobWVudHMgb3IgY2xpY2sgbGlua3Ms
IHVubGVzcyB0aGlzDQo+ZW1haWwgY29tZXMgZnJvbSBhIGtub3duIHNlbmRlciBhbmQgeW91IGtu
b3cgdGhlIGNvbnRlbnQgaXMgc2FmZS4NCj4+DQo+Pg0KPj4gQWRkIHRoZSBmcmFtZXdvcmsgdG8g
dGVzdCB0aGUgaW50ZWwtaW9tbXUgZGV2aWNlLg0KPj4NCj4+IEN1cnJlbnRseSBvbmx5IHRlc3Rl
ZCBjYXAvZWNhcCBiaXRzIGNvcnJlY3RuZXNzIGluIHNjYWxhYmxlDQo+PiBtb2Rlcm4gbW9kZS4g
QWxzbyB0ZXN0ZWQgY2FwL2VjYXAgYml0cyBjb25zaXN0ZW5jeSBiZWZvcmUNCj4+IGFuZCBhZnRl
ciBzeXN0ZW0gcmVzZXQuDQo+Pg0KPj4gU2lnbmVkLW9mZi1ieTogWmhlbnpob25nIER1YW4gPHpo
ZW56aG9uZy5kdWFuQGludGVsLmNvbT4NCj4+IC0tLQ0KPj4gICBNQUlOVEFJTkVSUyAgICAgICAg
ICAgICAgICAgICAgfCAgMSArDQo+PiAgIGluY2x1ZGUvaHcvaTM4Ni9pbnRlbF9pb21tdS5oICB8
ICAxICsNCj4+ICAgdGVzdHMvcXRlc3QvaW50ZWwtaW9tbXUtdGVzdC5jIHwgNzENCj4rKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrDQo+PiAgIHRlc3RzL3F0ZXN0L21lc29uLmJ1aWxk
ICAgICAgICB8ICAxICsNCj4+ICAgNCBmaWxlcyBjaGFuZ2VkLCA3NCBpbnNlcnRpb25zKCspDQo+
PiAgIGNyZWF0ZSBtb2RlIDEwMDY0NCB0ZXN0cy9xdGVzdC9pbnRlbC1pb21tdS10ZXN0LmMNCj4+
DQo+PiBkaWZmIC0tZ2l0IGEvTUFJTlRBSU5FUlMgYi9NQUlOVEFJTkVSUw0KPj4gaW5kZXggN2Q5
ODExNDU4Yy4uZWM3NjViZjNkMyAxMDA2NDQNCj4+IC0tLSBhL01BSU5UQUlORVJTDQo+PiArKysg
Yi9NQUlOVEFJTkVSUw0KPj4gQEAgLTM2NjIsNiArMzY2Miw3IEBAIFM6IFN1cHBvcnRlZA0KPj4g
ICBGOiBody9pMzg2L2ludGVsX2lvbW11LmMNCj4+ICAgRjogaHcvaTM4Ni9pbnRlbF9pb21tdV9p
bnRlcm5hbC5oDQo+PiAgIEY6IGluY2x1ZGUvaHcvaTM4Ni9pbnRlbF9pb21tdS5oDQo+PiArRjog
dGVzdHMvcXRlc3QvaW50ZWwtaW9tbXUtdGVzdC5jDQo+Pg0KPj4gICBBTUQtVmkgRW11bGF0aW9u
DQo+PiAgIFM6IE9ycGhhbg0KPj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvaHcvaTM4Ni9pbnRlbF9p
b21tdS5oDQo+Yi9pbmNsdWRlL2h3L2kzODYvaW50ZWxfaW9tbXUuaA0KPj4gaW5kZXggNjUwNjQx
NTQ0Yy4uYjE4NDhkYmVjNiAxMDA2NDQNCj4+IC0tLSBhL2luY2x1ZGUvaHcvaTM4Ni9pbnRlbF9p
b21tdS5oDQo+PiArKysgYi9pbmNsdWRlL2h3L2kzODYvaW50ZWxfaW9tbXUuaA0KPj4gQEAgLTQ3
LDYgKzQ3LDcgQEAgT0JKRUNUX0RFQ0xBUkVfU0lNUExFX1RZUEUoSW50ZWxJT01NVVN0YXRlLA0K
PklOVEVMX0lPTU1VX0RFVklDRSkNCj4+ICAgI2RlZmluZSBWVERfSE9TVF9BV180OEJJVCAgICAg
ICAgICAgNDgNCj4+ICAgI2RlZmluZSBWVERfSE9TVF9BV19BVVRPICAgICAgICAgICAgMHhmZg0K
Pj4gICAjZGVmaW5lIFZURF9IQVdfTUFTSyhhdykgICAgICAgICAgICAoKDFVTEwgPDwgKGF3KSkg
LSAxKQ0KPj4gKyNkZWZpbmUgVlREX01HQVdfRlJPTV9DQVAoY2FwKSAgICAgICgoY2FwID4+IDE2
KSAmIDB4M2ZVTEwpDQo+Pg0KPj4gICAjZGVmaW5lIERNQVJfUkVQT1JUX0ZfSU5UUiAgICAgICAg
ICAoMSkNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvdGVzdHMvcXRlc3QvaW50ZWwtaW9tbXUtdGVzdC5j
IGIvdGVzdHMvcXRlc3QvaW50ZWwtaW9tbXUtdGVzdC5jDQo+PiBuZXcgZmlsZSBtb2RlIDEwMDY0
NA0KPj4gaW5kZXggMDAwMDAwMDAwMC4uOGUwNzAzNGY2Zg0KPj4gLS0tIC9kZXYvbnVsbA0KPj4g
KysrIGIvdGVzdHMvcXRlc3QvaW50ZWwtaW9tbXUtdGVzdC5jDQo+PiBAQCAtMCwwICsxLDcxIEBA
DQo+PiArLyoNCj4+ICsgKiBRVGVzdCB0ZXN0Y2FzZSBmb3IgaW50ZWwtaW9tbXUNCj4+ICsgKg0K
Pj4gKyAqIENvcHlyaWdodCAoYykgMjAyNCBJbnRlbCwgSW5jLg0KPj4gKyAqDQo+PiArICogQXV0
aG9yOiBaaGVuemhvbmcgRHVhbiA8emhlbnpob25nLmR1YW5AaW50ZWwuY29tPg0KPj4gKyAqDQo+
PiArICogVGhpcyB3b3JrIGlzIGxpY2Vuc2VkIHVuZGVyIHRoZSB0ZXJtcyBvZiB0aGUgR05VIEdQ
TCwgdmVyc2lvbiAyIG9yDQo+bGF0ZXIuDQo+PiArICogU2VlIHRoZSBDT1BZSU5HIGZpbGUgaW4g
dGhlIHRvcC1sZXZlbCBkaXJlY3RvcnkuDQo+PiArICovDQo+PiArDQo+PiArI2luY2x1ZGUgInFl
bXUvb3NkZXAuaCINCj4+ICsjaW5jbHVkZSAibGlicXRlc3QuaCINCj4+ICsjaW5jbHVkZSAiaHcv
aTM4Ni9pbnRlbF9pb21tdV9pbnRlcm5hbC5oIg0KPj4gKw0KPj4gKyNkZWZpbmUgQ0FQX01PREVS
Tl9GSVhFRDEgICAgKFZURF9DQVBfRlJPIHwgVlREX0NBUF9ORlIgfA0KPlZURF9DQVBfTkQgfCBc
DQo+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgVlREX0NBUF9NQU1WIHwgVlREX0NB
UF9QU0kgfCBWVERfQ0FQX1NMTFBTKQ0KPj4gKyNkZWZpbmUgRUNBUF9NT0RFUk5fRklYRUQxICAg
KFZURF9FQ0FQX1FJIHwgIFZURF9FQ0FQX0lSTyB8DQo+VlREX0VDQVBfTUhNViB8IFwNCj4+ICsg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICBWVERfRUNBUF9TTVRTIHwgVlREX0VDQVBfRkxU
UykNCj4+ICsNCj4+ICtzdGF0aWMgaW5saW5lIHVpbnQzMl90IHZ0ZF9yZWdfcmVhZGwoUVRlc3RT
dGF0ZSAqcywgdWludDY0X3Qgb2Zmc2V0KQ0KPj4gK3sNCj4+ICsgICAgcmV0dXJuIHF0ZXN0X3Jl
YWRsKHMsIFEzNV9IT1NUX0JSSURHRV9JT01NVV9BRERSICsgb2Zmc2V0KTsNCj4+ICt9DQo+PiAr
DQo+PiArc3RhdGljIGlubGluZSB1aW50NjRfdCB2dGRfcmVnX3JlYWRxKFFUZXN0U3RhdGUgKnMs
IHVpbnQ2NF90IG9mZnNldCkNCj4+ICt7DQo+PiArICAgIHJldHVybiBxdGVzdF9yZWFkcShzLCBR
MzVfSE9TVF9CUklER0VfSU9NTVVfQUREUiArIG9mZnNldCk7DQo+PiArfQ0KPj4gKw0KPj4gK3N0
YXRpYyB2b2lkIHRlc3RfaW50ZWxfaW9tbXVfbW9kZXJuKHZvaWQpDQo+PiArew0KPj4gKyAgICB1
aW50OF90IGluaXRfY3NyW0RNQVJfUkVHX1NJWkVdOyAgICAgLyogcmVnaXN0ZXIgdmFsdWVzICov
DQo+PiArICAgIHVpbnQ4X3QgcG9zdF9yZXNldF9jc3JbRE1BUl9SRUdfU0laRV07ICAgICAvKiBy
ZWdpc3RlciB2YWx1ZXMgKi8NCj4+ICsgICAgdWludDY0X3QgY2FwLCBlY2FwLCB0bXA7DQo+PiAr
ICAgIFFUZXN0U3RhdGUgKnM7DQo+PiArDQo+PiArICAgIHMgPSBxdGVzdF9pbml0KCItTSBxMzUg
LWRldmljZSBpbnRlbC1pb21tdSx4LXNjYWxhYmxlLW1vZGU9bW9kZXJuIik7DQo+PiArDQo+PiAr
ICAgIGNhcCA9IHZ0ZF9yZWdfcmVhZHEocywgRE1BUl9DQVBfUkVHKTsNCj4+ICsgICAgZ19hc3Nl
cnQoKGNhcCAmIENBUF9NT0RFUk5fRklYRUQxKSA9PSBDQVBfTU9ERVJOX0ZJWEVEMSk7DQo+PiAr
DQo+PiArICAgIHRtcCA9IGNhcCAmIFZURF9DQVBfU0FHQVdfTUFTSzsNCj4+ICsgICAgZ19hc3Nl
cnQodG1wID09IChWVERfQ0FQX1NBR0FXXzM5Yml0IHwgVlREX0NBUF9TQUdBV180OGJpdCkpOw0K
Pj4gKw0KPj4gKyAgICB0bXAgPSBWVERfTUdBV19GUk9NX0NBUChjYXApOw0KPj4gKyAgICBnX2Fz
c2VydCh0bXAgPT0gVlREX0hPU1RfQVdfNDhCSVQgLSAxKTsNCj4+ICsNCj4+ICsgICAgZWNhcCA9
IHZ0ZF9yZWdfcmVhZHEocywgRE1BUl9FQ0FQX1JFRyk7DQo+PiArICAgIGdfYXNzZXJ0KChlY2Fw
ICYgRUNBUF9NT0RFUk5fRklYRUQxKSA9PSBFQ0FQX01PREVSTl9GSVhFRDEpOw0KPj4gKyAgICBn
X2Fzc2VydChlY2FwICYgVlREX0VDQVBfSVIpOw0KPkNhbiB3ZSBhZGQgVlREX0VDQVBfSVIgdG8g
RUNBUF9NT0RFUk5fRklYRUQxPw0KDQpXaWxsIGRvLg0KDQpUaGFua3MNClpoZW56aG9uZw0KDQo+
PiArDQo+PiArICAgIHF0ZXN0X21lbXJlYWQocywgUTM1X0hPU1RfQlJJREdFX0lPTU1VX0FERFIs
IGluaXRfY3NyLA0KPkRNQVJfUkVHX1NJWkUpOw0KPj4gKw0KPj4gKyAgICBxb2JqZWN0X3VucmVm
KHF0ZXN0X3FtcChzLCAieyAnZXhlY3V0ZSc6ICdzeXN0ZW1fcmVzZXQnIH0iKSk7DQo+PiArICAg
IHF0ZXN0X3FtcF9ldmVudHdhaXQocywgIlJFU0VUIik7DQo+PiArDQo+PiArICAgIHF0ZXN0X21l
bXJlYWQocywgUTM1X0hPU1RfQlJJREdFX0lPTU1VX0FERFIsIHBvc3RfcmVzZXRfY3NyLA0KPkRN
QVJfUkVHX1NJWkUpOw0KPj4gKyAgICAvKiBFbnN1cmUgcmVnaXN0ZXJzIGFyZSBjb25zaXN0ZW50
IGFmdGVyIGhhcmQgcmVzZXQgKi8NCj4+ICsgICAgZ19hc3NlcnQoIW1lbWNtcChpbml0X2Nzciwg
cG9zdF9yZXNldF9jc3IsIERNQVJfUkVHX1NJWkUpKTsNCj4+ICsNCj4+ICsgICAgcXRlc3RfcXVp
dChzKTsNCj4+ICt9DQo+PiArDQo+PiAraW50IG1haW4oaW50IGFyZ2MsIGNoYXIgKiphcmd2KQ0K
Pj4gK3sNCj4+ICsgICAgZ190ZXN0X2luaXQoJmFyZ2MsICZhcmd2LCBOVUxMKTsNCj4+ICsgICAg
cXRlc3RfYWRkX2Z1bmMoIi9xMzUvaW50ZWwtaW9tbXUvbW9kZXJuIiwNCj50ZXN0X2ludGVsX2lv
bW11X21vZGVybik7DQo+PiArDQo+PiArICAgIHJldHVybiBnX3Rlc3RfcnVuKCk7DQo+PiArfQ0K
Pj4gZGlmZiAtLWdpdCBhL3Rlc3RzL3F0ZXN0L21lc29uLmJ1aWxkIGIvdGVzdHMvcXRlc3QvbWVz
b24uYnVpbGQNCj4+IGluZGV4IDY1MDhiZmIxYTIuLjIwZDA1ZDQ3MWIgMTAwNjQ0DQo+PiAtLS0g
YS90ZXN0cy9xdGVzdC9tZXNvbi5idWlsZA0KPj4gKysrIGIvdGVzdHMvcXRlc3QvbWVzb24uYnVp
bGQNCj4+IEBAIC03OSw2ICs3OSw3IEBAIHF0ZXN0c19pMzg2ID0gXA0KPj4gICAgIChjb25maWdf
YWxsX2RldmljZXMuaGFzX2tleSgnQ09ORklHX1NCMTYnKSA/IFsnZnV6ei1zYjE2LXRlc3QnXSA6
IFtdKSArDQo+XA0KPj4gICAgIChjb25maWdfYWxsX2RldmljZXMuaGFzX2tleSgnQ09ORklHX1NE
SENJX1BDSScpID8gWydmdXp6LXNkY2FyZC10ZXN0J10gOg0KPltdKSArICAgICAgICAgICAgXA0K
Pj4gICAgIChjb25maWdfYWxsX2RldmljZXMuaGFzX2tleSgnQ09ORklHX0VTUF9QQ0knKSA/IFsn
YW01M2M5NzQtdGVzdCddIDogW10pDQo+KyAgICAgICAgICAgICAgICAgXA0KPj4gKyAgKGNvbmZp
Z19hbGxfZGV2aWNlcy5oYXNfa2V5KCdDT05GSUdfVlREJykgPyBbJ2ludGVsLWlvbW11LXRlc3Qn
XSA6IFtdKSArDQo+XA0KPj4gICAgIChob3N0X29zICE9ICd3aW5kb3dzJyBhbmQgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXA0K
Pj4gICAgICBjb25maWdfYWxsX2RldmljZXMuaGFzX2tleSgnQ09ORklHX0FDUElfRVJTVCcpID8g
WydlcnN0LXRlc3QnXSA6IFtdKSArDQo+XA0KPj4gICAgIChjb25maWdfYWxsX2RldmljZXMuaGFz
X2tleSgnQ09ORklHX1BDSUVfUE9SVCcpIGFuZA0KPlwNCj4+IC0tDQo+PiAyLjM0LjENCj4+DQo+
DQo+UmV2aWV3ZWQtYnk6IENsw6ltZW50IE1hdGhpZXUtLURyaWY8Y2xlbWVudC5tYXRoaWV1LS1k
cmlmQGV2aWRlbi5jb20+DQo=

