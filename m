Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F5EFC19776
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2025 08:17:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnvYa-0007op-Ot; Fri, 28 Feb 2025 03:17:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1tnvYY-0007oA-QV
 for qemu-devel@nongnu.org; Fri, 28 Feb 2025 03:17:15 -0500
Received: from mgamail.intel.com ([198.175.65.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1tnvYW-0000zi-Kt
 for qemu-devel@nongnu.org; Fri, 28 Feb 2025 03:17:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1740730632; x=1772266632;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=Dn8L53ewYiUEyqPXQ1K4juFNnJukK+pROIReILy7HjA=;
 b=IKfdqaUB7yKjpLYYJm6HqcwFdw/Mmqd4DoNY2JJg5ax9ezwCLq3c+CfQ
 cDW7nz70kfj08kwEFWu1oUY2tCOjD6Vn6ZN8ntqMSadk1ZQ4feW4D4j2Y
 +Co0syv4SBwlrBjn2KmNfw/XgCGL+bh3b4wbPMyfuSqiP/DXMHTGdaS5Z
 1LXbI2rClN7QAE0rUOC0KpNib+plqLQOO35S9ohBAgdXcqxibMoltxXy6
 oxiBmHLk2ftYeffEPRfCcMz6bUL4SuyNcHK13DLTQwXTpC54OzJNxMlw2
 EhJwk8DTA0E80X6z+h9SSMbOrQFwneT7gTzmHhB+7bKjRKTIfPCXtpc/S g==;
X-CSE-ConnectionGUID: mmFa1wYMQ/+pWG2Juf61kg==
X-CSE-MsgGUID: Z89zCZSESf2vA8i0NwjUSg==
X-IronPort-AV: E=McAfee;i="6700,10204,11358"; a="41569776"
X-IronPort-AV: E=Sophos;i="6.13,321,1732608000"; d="scan'208";a="41569776"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Feb 2025 00:17:07 -0800
X-CSE-ConnectionGUID: gJED52mZRqyrvHIh//yAOg==
X-CSE-MsgGUID: 0mMoxQ+PQFisRKoXyihyjQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,321,1732608000"; d="scan'208";a="148088111"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
 by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 28 Feb 2025 00:17:03 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Fri, 28 Feb 2025 00:17:02 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Fri, 28 Feb 2025 00:17:02 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.173)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 28 Feb 2025 00:17:01 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PBM41lQIVEHuIlTFX9qeJ04GWRDMQUtr2S2xARO1MVmku+nXLtaLxhg9ZLyckna+3eFm7go9EbDAYTDNkyZez3eiqeeclz57eVFNatw7zqjcmfwgQh/KWyr1O0SbWdBlQkWBoptFLIGNdbmU0GyjyJ4ahRnTHPelRJqfkBgTu/ZPKq5g4EnXS7bx36kJkWCsRFeOaIBkFF1VfFYpjiH3VnPI8w8nA7pU6BK8Rq87Wox4kjrLbsCTe+PoYTmQh5daPAn2ERvns3XM/s2bfW+RXol0chmNwD48tc09s08sGyZ1HKmXPl9vB4MnWRCzYbhnkJKzD6Z5K1tvxh+ZqqN5Pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dn8L53ewYiUEyqPXQ1K4juFNnJukK+pROIReILy7HjA=;
 b=jPzEFBK2iSPuHK+6qbrZkNwr59A/htqSjk90dgQXYoysfyLEx3DdRsgCJVWYyBUpNe/UQdnfk2ktvlp0htVYO4z6eYGRcR1CPJlcuLXvi9Z12UEbphEmx6FKw3ubPK3k7RiE9puXsvs6PDn69ULUoy0Xy4uyG2so37fZSaMRzIc5wGgC6ytCpvlj8cD7Lh7n6IAaSFZmIolpVS8V3KgEzFOw5riJA/93RLrR3hMAr+Hvarr98gUQd9dldT9O9ruVOHokLbXuEZnPLWnSxHtTETra39ihNbNM5sesjr3iHq9Xh1ugjGsvPbZA5zBt+vl74dcX6cy9awrCZC8UwCSykQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by MW4PR11MB7055.namprd11.prod.outlook.com (2603:10b6:303:22b::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.22; Fri, 28 Feb
 2025 08:16:17 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091%6]) with mapi id 15.20.8489.021; Fri, 28 Feb 2025
 08:16:17 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: "eric.auger@redhat.com" <eric.auger@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>, "mst@redhat.com" <mst@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>, "peterx@redhat.com"
 <peterx@redhat.com>, "jgg@nvidia.com" <jgg@nvidia.com>, "nicolinc@nvidia.com"
 <nicolinc@nvidia.com>, "shameerali.kolothum.thodi@huawei.com"
 <shameerali.kolothum.thodi@huawei.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "clement.mathieu--drif@eviden.com"
 <clement.mathieu--drif@eviden.com>, "Tian, Kevin" <kevin.tian@intel.com>,
 "Liu, Yi L" <yi.l.liu@intel.com>, "Peng, Chao P" <chao.p.peng@intel.com>
Subject: RE: [PATCH rfcv2 03/20] HostIOMMUDevice: Introduce realize_late
 callback
Thread-Topic: [PATCH rfcv2 03/20] HostIOMMUDevice: Introduce realize_late
 callback
Thread-Index: AQHbgqf4kW3myVfhUUy5lTRf0uUHeLNQeeoAgAp0YqA=
Date: Fri, 28 Feb 2025 08:16:17 +0000
Message-ID: <SJ0PR11MB6744096111D47692257CD1B392CC2@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20250219082228.3303163-1-zhenzhong.duan@intel.com>
 <20250219082228.3303163-4-zhenzhong.duan@intel.com>
 <5322a196-017e-46c1-98d9-bf2f30d148e9@redhat.com>
In-Reply-To: <5322a196-017e-46c1-98d9-bf2f30d148e9@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|MW4PR11MB7055:EE_
x-ms-office365-filtering-correlation-id: e4ab9524-857d-4acb-c1fe-08dd57d02d18
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|7416014|366016|1800799024|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?MWE3TTJzZFFQTW40N0NpeTlQamcveXFRVTA1OTJwcExxd0pTbzBLS3d3eVAx?=
 =?utf-8?B?MnoxRHFnMEF3Q1Q2OHlyWTc0ZWxyOVJMOG5NY3dOSU1wUTFHbzNjbEErQTIw?=
 =?utf-8?B?WjNDZjNBVHF6Q1d6c2tDNi9WT0x6L0N4d2lldWx0bzNvL0pIMEIzSjlDeEo4?=
 =?utf-8?B?UEp1d1VIY1p5ZHQrWlNlZnpIc0dBakJ0bXlmdURyd01DelRjZ24wdDd3ZDhO?=
 =?utf-8?B?b2tOU0IzK2tsMm9wM1dsbDJKK0NVZVE1YnZVNFNackt0TzdOc05PMHNLN2tI?=
 =?utf-8?B?UTQvbTVvKzdQQkVPL2hqUGg3U1R3Zm5hUERsT3hPUVBKdWVDUlJwNGJuWGVT?=
 =?utf-8?B?V3VvOUdZTy94bDdjS0pBTTd4bmVDOW12RysyeWl6d1NEdlBLR2V4Y2RITE55?=
 =?utf-8?B?aW1STlp3S1VYdlBPeXgrc29YUlZYcUNQTnBBSlhsWEFjaitWUXRSQWhVYzgw?=
 =?utf-8?B?VEZOeWZqQUFnamZXNFhBVHRydC90MFgzZDR2Tm5penZuc0ZFME9JWXpXci9H?=
 =?utf-8?B?b21XNjdzOGNrWVlxaHdYdFdrYml0aXVMaTJISUZEMW9KWkJFSi9MUDVZajJY?=
 =?utf-8?B?ZDhKSGxWeGZNKzhyYjc1b2c0cWk3VENGdHY0KzhETU4vMjVJaHZHU2lOZ3o1?=
 =?utf-8?B?K0tZUkY3Y0FCdlNGTG5XTXExbXJqNlBTZXNCdXhGdUtKbzlwNEZMbkQwMHBT?=
 =?utf-8?B?a3h6SjB3SGpmZXNBODArTi9CUmw3K005K1liUWltY2Ywd3ViMXJDS29TRDNT?=
 =?utf-8?B?K3YyUitRR3FDSlVLamJWWFJyTTBvbSs4TWRVVDl5WmtNcGRnSFg4NlI5Qlhz?=
 =?utf-8?B?K3JlbHA3eTYzTWpySEVCRzh2VU03S1NISlB0Q29oSTV6eHEyVXRFbXhqUWRr?=
 =?utf-8?B?OG1tWGVzV29ZMGNYcTdCTnJKQzF4OHpYYkMwZnZCMllrZ2tWelZWZEI5UE8w?=
 =?utf-8?B?aHh2c2RNZndQdC8wNGZDMFc1UU5BM1l2YzUyang0UkxqYWVjdkMxYmF2WmNX?=
 =?utf-8?B?RUl5Z2I2aFhpTkdSd0N6b0V3M1kzUEllZnRsMjgrOGZ5RXFCM1JNLzN6WEE5?=
 =?utf-8?B?cjJ2a3dmNEY4YmcwOUp6czZ4OUtUODRySlNLdWhLQnBXYk1OUFdKbTZXL242?=
 =?utf-8?B?ajJtejhDOFBJWnBUNldJbDA0YldpYWZTSENIR2lUaGJGRVFzbFNGSTNUYVpV?=
 =?utf-8?B?SURpbXpoa0xKam03c3NwNGxSNW8wZFBocnRNR3J0WHMva2N2UW9KUU41Q3J5?=
 =?utf-8?B?WlNHUVlGanJwQ1ZaVEh0eEI5NnpQelB2eWNmYklXUS9YZWp3U2tpeVhEdGU2?=
 =?utf-8?B?eXRtUWhxTThkR3ZwZnpCTFF5TDMwM2VQSEVmenVyZ3h1TmFYUmZ1cDF3bkVN?=
 =?utf-8?B?eTY5cVlUeVdpdWpIQStHTGgzNWI0ZlNhWG1rNHJKcmJhOTk4K2NFV2M5Wjhu?=
 =?utf-8?B?dWxjRkJ0azhLUEFWR1Y2T1BDbFB3Q0kxdzIzWEhBb1RnVy82UlJNRXBXMEMw?=
 =?utf-8?B?aWZQZVNvdndlSlhlcFNHOWY1eFZiUEMvUUFPaWFyR1JvWEVKYjJ2SzJXREdV?=
 =?utf-8?B?ZWx4RVdYN3k0ZStLQUp2enQ1aXd4WGZUMkw0b0pJQTdZM3FDWHVCTHpQQ09m?=
 =?utf-8?B?M2g4VnpIRERwZFhLa1JtdXgvWHJnNjA4STBBZDN0bWcxNzEvQUNtMXEyVVo5?=
 =?utf-8?B?ZHRxZmltdWxndXd0ZWF3THU5NHdZalp3eHVibjNEVk54S1Y3UU45SWpZNG5E?=
 =?utf-8?B?N3VZaFBZeGpPdm9jc2N6bGVZZ3RSczA1RzE1YnBSb0E1VGxVcFZ5aTVjM0Fw?=
 =?utf-8?B?NjlkL0ZldXI0N3U3WkUyTWpXaHRySlg1S0Q4RDUrekQ4Lzd2S2FSRVNoZ0pi?=
 =?utf-8?B?dGpqbjlValRlVVRINkIwbFBHbG1RTGVicjF1QU5tdXN5M1NSNDgyU1RvSlQy?=
 =?utf-8?Q?bxczPgvxkoB2ubUjr7RtfYC+wH+xypdW?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VTFkcG9OZCtZdUpwckkvNWR4TGNPVm5hbGVQNnNDd3RtUTZWRVcxQ3J5ZGZi?=
 =?utf-8?B?MVUxWFJaRHNjS0xJeWMwckJTVUdweEgyWmFOc0p2ODlmZWlhM0psR2JHR0l3?=
 =?utf-8?B?cDFzczlDSFBKUmtKcmkxM25wd2kzUms3S0lxUnhyNUNzYjlNbERQYlFrdFY3?=
 =?utf-8?B?d21hcGJRRUc4cFZVdDRYQitYODlXZXhpTzJxVHhOSTBGSzAwNDZrOVZoenZF?=
 =?utf-8?B?UzdiWVVRSk40MnNKSk9qSXcrY1VUZzU4Ri9oQjZ1a01YclpyZFpVY2dZZ3Zn?=
 =?utf-8?B?aVNtb0pKMW1NajRpM0xMYkVOcHNNR0hxVkN5SFV0U1NWejNTZnpsbVVzaVp6?=
 =?utf-8?B?TnBjQW9hRDA3ckdWR0svOXNxSGhXZHhhTE4rNEIvYWVNK2ZHWnB4dzJJQ1Ru?=
 =?utf-8?B?YzNhdkRJODlOV0xSTllYSFVnckp2UlBLamFtOWtKejlQQVhlQVhCakVqdUtX?=
 =?utf-8?B?Nk9PWUJVdWNyL2hhTkNzbUdQeG1TNmZxUXpwRnJVZ25LZWlQakxVbnJOWXRG?=
 =?utf-8?B?d29iUHZqWjNCZzZ4aEQ2eFBBbzgxQWNIM3M5RE1BLzBwS1YrOVF1bmZaZWtG?=
 =?utf-8?B?M0NvN0RNMGk5cGF0OEh6dnF1VHg5aGswa05YNVB6SHZ0c2xhMWpQRGE0K2lC?=
 =?utf-8?B?T0tXb1JRU25CUGZIdWNrbzA4Sy9oMHRwSktsS29TSEFHWEJEVEF1VzNYS0NY?=
 =?utf-8?B?NVhRYWhMOW1IV1UzSDBXN2cveG5NR3VsNGhZczFNclNRZStuc1VXUDE1Qm84?=
 =?utf-8?B?U2VSUGtZcTJFWlFqcU93QTgvRWpPa2JNTTJNc3o1TzdXUTVjdjBGSDloK2N3?=
 =?utf-8?B?WTd1L04xcUZCTFdzSGYwMS9TdHpQNHc3OTZzUVAydUlJSXNlN2NUZnlIVzk0?=
 =?utf-8?B?Vzc3eU90MVFCUThwdTJ0SDNaS2NrQTVtbXdZNEpQbHYxY3EzOEFXcG5Tam5k?=
 =?utf-8?B?RU1kTTc5UlBybjlvRE9hdEdTdSt4NDNwTytoaVhaZzNhZXh0U21sVlFPZGht?=
 =?utf-8?B?SWhuM3g0VU9JRG5FVlJKVXFDdi92Q1BvQWo2elQrUWFPUEtoSkVPM0RSRFhG?=
 =?utf-8?B?ajBXWkFPWWFadW44akJWMGwyUUdxWjlUTzlWTGZtKzl1YlprK2loZTIwdWtk?=
 =?utf-8?B?Skp6OXZUeUlVS3BsV2tWYkRkSjRZNVVmc2d5ZFREY3k5TDZMbUJ5cG1rWkZ3?=
 =?utf-8?B?aVF2eGN6S2RMaFBobjd3R2FDSCtnUDhhUFpFOG0va2J3OXJJZkdEdkJJRzVx?=
 =?utf-8?B?cENtV3VNWVFQcUdzcUxBRldBOUdFaDV6dkhGV2hmMTUram8yb0kwYmI2UzBr?=
 =?utf-8?B?U2w3K3ViWG5qL25oSDJSeG5NUmRnTzYyREd3WUFnTGZpenlzdHdiQWdNTCs5?=
 =?utf-8?B?OFExckdYRmh6eFlwNEE0bEFJUmVQS0V6cmc1S09QcGRoS1ZlRWRTSVhjQWZv?=
 =?utf-8?B?Z3NmK0JtditOckdWUFE5K2szUVh5dW5FY1hZQmdseGl3MVE3Q1FEbU14bDFI?=
 =?utf-8?B?TS9WdDlEUkNhZXFhUkZKNHB0bnFMVEc1dUc2dlFkMENnTXg2ZkU2VEptb0lE?=
 =?utf-8?B?YnY1VThUOGVQNUJQdVFqM1N2QUhDVk9MTnRHakE4cEZvSDZzcjNRbWplWE45?=
 =?utf-8?B?N29CR0dTS3pOclNBWjNGdi9lYlkrcjIwd2xEWkN3SDZRblVIT1pmaS9zdFcx?=
 =?utf-8?B?d3BDNTVrc3RkeElaUFMzeU1EKzFjZzFMK0NiOW9vdEQwV1FBMzhlalVKMUFo?=
 =?utf-8?B?cWIrU3VtcHQ1eFpPbFZuVlZQc1p2TS9vOURDT2JSL1VpMlRuWXJIT1gzTENJ?=
 =?utf-8?B?QzlJTi9PQitpSDJ4WHh0cURtMCtObEYrSStOY3BGTmJ3cHRRemZCbzZzS3RO?=
 =?utf-8?B?ZUZ5MjRIbFdQN0hneWtTY0IwR00rZEhBQXZRQlVHVm9sanFNaHI2eEx2MGsw?=
 =?utf-8?B?RCt1aGx2SG9uNEJzMUI2c2tRN0thNnE0UXkxRHlxWDVCdlN4RUlVamhQdE9U?=
 =?utf-8?B?QXFBL3E4bDRwNHUzaE14aXJKSGpQcUVSZGN3V2M2SmhEbGt2MFg3em5vWDZS?=
 =?utf-8?B?a0lMVGVkVUVpZmVNbmRlY0VNK3VaVVdQRGs2RVdocmRGQVp5VC9UZWZwOFVY?=
 =?utf-8?Q?OSruMfkgZYMVWGqhVIEC7retj?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4ab9524-857d-4acb-c1fe-08dd57d02d18
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Feb 2025 08:16:17.7576 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +QkJP/VGPHa5gXQ4B9qE5rUa1cjsuhT7uK7hu4DMmoO072jWF1AZGvhuisgpPUqMEP+NuAdv+62gqp552JgTDbnTYcgon0nSZljPSJYOaF8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB7055
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.21;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.438,
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IEVyaWMgQXVnZXIgPGVyaWMu
YXVnZXJAcmVkaGF0LmNvbT4NCj5TdWJqZWN0OiBSZTogW1BBVENIIHJmY3YyIDAzLzIwXSBIb3N0
SU9NTVVEZXZpY2U6IEludHJvZHVjZSByZWFsaXplX2xhdGUNCj5jYWxsYmFjaw0KPg0KPg0KPg0K
Pg0KPk9uIDIvMTkvMjUgOToyMiBBTSwgWmhlbnpob25nIER1YW4gd3JvdGU6DQo+PiBDdXJyZW50
bHkgd2UgaGF2ZSByZWFsaXplKCkgY2FsbGJhY2sgd2hpY2ggaXMgY2FsbGVkIGJlZm9yZSBhdHRh
Y2htZW50Lg0KPj4gQnV0IHRoZXJlIGFyZSBzdGlsbCBzb21lIGVsZW1lbnRzIGUuZy4sIGh3cHRf
aWQgaXMgbm90IHJlYWR5IGJlZm9yZQ0KPj4gYXR0YWNobWVudC4gU28gd2UgbmVlZCBhIHJlYWxp
emVfbGF0ZSgpIGNhbGxiYWNrIHRvIGZ1cnRoZXIgaW5pdGlhbGl6ZQ0KPj4gdGhlbS4NCj5mcm9t
IHRoZSBkZXNjcmlwdGlvbiBpdCBpcyBub3Qgb2J2aW91cyB3aHkgdGhlIHJlYWxpemUoKSBjb3Vs
ZCBub3QgaGF2ZQ0KPmJlZW4gY2FsbGVkIGFmdGVyIHRoZSBhdHRhY2guIENvdWxkIHlvdSByZW1p
bmQgdGhlIHJlYWRlciB3aGF0IGlzIHRoZQ0KPnJlYXNvbj8NCg0KU3VyZSwgd2lsbCByZXBocmFz
ZSBhcyBiZWxvdzoNCg0KIiBIb3N0SU9NTVVEZXZpY2UgcHJvdmlkZXMgc29tZSBlbGVtZW50cyB0
byB2SU9NTVUsIGJ1dCB0aGVyZSBhcmUgc29tZSB3aGljaA0KYXJlIHJlYWR5IGFmdGVyIGF0dGFj
aG1lbnQsIGUuZy4sIGh3cHRfaWQuDQoNCkJlZm9yZSBjcmVhdGUgYW5kIGF0dGFjaCB0byBhIG5l
dyBod3B0IHdpdGggSU9NTVUgZGlydHkgdHJhY2tpbmcgY2FwYWJpbGl0eSwNCndlIGhhdmUgdG8g
Y2FsbCByZWFsaXplKCkgdG8gZ2V0IGlmIGhhcmR3YXJlIElPTU1VIHN1cHBvcnRzIGRpcnR5IHRy
YWNraW5nDQpjYXBhYmlsaXR5Lg0KDQpTbyBtb3ZpbmcgcmVhbGl6ZSgpIGFmdGVyIGF0dGFjaCgp
IHdpbGwgbm90IHdvcmsgaGVyZSwgd2UgbmVlZCBhIG5ldyBjYWxsYmFjaw0KcmVhbGl6ZV9sYXRl
KCkgdG8gZnVydGhlciBpbml0aWFsaXplIHRob3NlIGVsZW1lbnRzLg0KDQpDdXJyZW50bHksIHRo
aXMgY2FsbGJhY2sgaXMgb25seSB1c2VmdWwgZm9yIGlvbW11ZmQgYmFja2VuZC4gRm9yIGxlZ2Fj
eQ0KYmFja2VuZCBub3RoaW5nIG5lZWRzIHRvIGJlIGluaXRpYWxpemVkIGFmdGVyIGF0dGFjaG1l
bnQuICINCg0KVGhhbmtzDQpaaGVuemhvbmcNCg0K

