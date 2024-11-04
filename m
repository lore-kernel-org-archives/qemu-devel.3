Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0F34D111A0
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 03:20:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t7ncX-0003u3-A6; Sun, 03 Nov 2024 22:19:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1t7ncU-0003rq-JB
 for qemu-devel@nongnu.org; Sun, 03 Nov 2024 22:19:11 -0500
Received: from mgamail.intel.com ([198.175.65.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1t7ncR-000405-BV
 for qemu-devel@nongnu.org; Sun, 03 Nov 2024 22:19:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1730690348; x=1762226348;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=OQ2udnH65jV85PBRfoOpgUnlj6tgqg9o3O0Gp8f3Dq0=;
 b=SY7IG0Zhdu4k9fBz2sFCP5EYf/uBB1OBXFzLk1WpeZ7vISPserZBcVTp
 B39pl9ghM1nPAN1udM0pzBtT/hCOkozRJDBiZgQVrD0DWKNtUxH/BhCs8
 KU8wzHbqcSA+IFPuYgmQO9ruR/21iNi6I0udal2RW4hu3tkLnjWkW6K47
 FKFkes5Yfgzlc5/5hLa3L3yW6LnCz4YPwcJ6intOS8HSc9P79ewlHncbJ
 /D7L32qtAEBOEXIHx3/btiuDl/2edDX6glyW62IRMY3Z6ZTnlCVsuGQP9
 +94Bv7Mew0A/JwUDvBOfg+POoPMqeLAbG7R5yyW3uMNEltPQ/jahWM8vO g==;
X-CSE-ConnectionGUID: xu9l1cXITHeh59lghTsftg==
X-CSE-MsgGUID: RrN8uPKLQk2+6ipfFzsZOA==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="40921843"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; d="scan'208";a="40921843"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Nov 2024 19:19:05 -0800
X-CSE-ConnectionGUID: Mh3YBNJRRjOyN20PeWKeqQ==
X-CSE-MsgGUID: PCoTVT1kTGmQk10kF+h2Pg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,256,1725346800"; d="scan'208";a="83451549"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
 by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 03 Nov 2024 19:19:05 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 3 Nov 2024 19:19:04 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Sun, 3 Nov 2024 19:19:04 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.49) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sun, 3 Nov 2024 19:19:03 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AGWe0JRdGk3e0aKmAldI3DaVYGpt2E4kpO7DCekt7+KbTAO446gvs8QKRuH820dX89aT95bO/BBLcucZY8X0uNMtjoto1tZrHxLC+bZ6ekoQyXEONLgKdhdNATCIeACSFWiaALbn2egGqVt88iNz/Zmnvwr4Ywq/Y5gtyEatjUdObK387dETBMjc/P4Y0DgCtvLqK/qAk6a4pM1JOKlwvv6jBH7sWWAPbIcxSzRoS7mgVUmRzYLioQAjcserqbANwhgm0hYG9p//TCwbd6nOe+M7pRcS4kbzmL9SotpR2LcEedukDQgqKxoKGgpAHO+6OSaikaXIk0FcQzcMH3hAJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OQ2udnH65jV85PBRfoOpgUnlj6tgqg9o3O0Gp8f3Dq0=;
 b=q5YXtBCOLqHMiID6VPsNngL7gRc1f3/+IhkWv7P/3SKUo0ZURpnRXuYmqZ5YxViYkc4LkEGmFr7YJGlNF/uXMyxC9kYXVkIqpmBSYtprcC6O0MGDABX6ms4kx6MFR2Qu9QZkbuW6hLy3snVYj9+P3qDSh9d4PUFdZGkOW+D1LWn1maHyysVTUcy3ao3/RLRwmeX5QBf0nqw+TCBIE7mcsbExO+x6GFdVLi0+l+scKNF70d+y9v9cWV57E0eSFY4duEE5GpPjauU0suUO2k7q9G+0c/zRvV3qQn++mdUVZEYq1Paap8gQEObGyDRXZ34Q0yhZZRpnqwAbtc4cJ4AgNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by SJ2PR11MB7456.namprd11.prod.outlook.com (2603:10b6:a03:4cd::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.29; Mon, 4 Nov
 2024 03:19:01 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091%5]) with mapi id 15.20.8114.028; Mon, 4 Nov 2024
 03:19:01 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: "Liu, Yi L" <yi.l.liu@intel.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>, "eric.auger@redhat.com"
 <eric.auger@redhat.com>, "mst@redhat.com" <mst@redhat.com>,
 "peterx@redhat.com" <peterx@redhat.com>, "jasowang@redhat.com"
 <jasowang@redhat.com>, "jgg@nvidia.com" <jgg@nvidia.com>,
 "nicolinc@nvidia.com" <nicolinc@nvidia.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "clement.mathieu--drif@eviden.com"
 <clement.mathieu--drif@eviden.com>, "Tian, Kevin" <kevin.tian@intel.com>,
 "Peng, Chao P" <chao.p.peng@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, Eduardo Habkost
 <eduardo@habkost.net>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: RE: [PATCH v4 14/17] intel_iommu: Set default aw_bits to 48 in
 scalable modern mode
Thread-Topic: [PATCH v4 14/17] intel_iommu: Set default aw_bits to 48 in
 scalable modern mode
Thread-Index: AQHbExt6qksyA+pIAUiDQKSj47oTJbKmqZ8AgAAAGOA=
Date: Mon, 4 Nov 2024 03:19:01 +0000
Message-ID: <SJ0PR11MB6744C11A435CBED0849A733992512@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20240930092631.2997543-1-zhenzhong.duan@intel.com>
 <20240930092631.2997543-15-zhenzhong.duan@intel.com>
 <74b6f85d-f5b5-48da-8bc5-bfe721250687@intel.com>
In-Reply-To: <74b6f85d-f5b5-48da-8bc5-bfe721250687@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|SJ2PR11MB7456:EE_
x-ms-office365-filtering-correlation-id: 4fee5269-4907-4ca7-398e-08dcfc7f6dc9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|376014|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?SjVOR2UwZDdoeEQyaFZKSG1kazZGeWgxdXBXRDAwMVYwdldKeFVPUFpJR24r?=
 =?utf-8?B?a1FUYlFOVzY2cGpML3Evb1JERU9DUWZuOEd4RU1kbnlWTThqelh3UnpxQWFr?=
 =?utf-8?B?ZmZjZDVWUCsvRWovZ0toZkZ6eXVGWU1HZDMrN3orZzM4Q2xadlRmSnlrdndw?=
 =?utf-8?B?TklRS3VyUFpIM3RxdURhdUZwNTQ2OVo3NlRSMHJtaUNrOWxIdkhxSHovK2Mx?=
 =?utf-8?B?Z1B4WGJUWXUzUHJXYzRMNTJ6NzhQangzRklEUng2T3BEWUF5eFBEQS9SNGth?=
 =?utf-8?B?NDIzMUdzcGE0QmhyOWk1U2ZBRHJ6SmlXcUx4ckc4RTZBcWhMa2g3VU9XbDVM?=
 =?utf-8?B?ZGNkb0ZvRFhqOHFrQ1hkeXIwKzJQZVZXL0NWSTNkR0ZWdWIyN09ja0lSbUlu?=
 =?utf-8?B?cWRCK0hLZCt1NlJweXdFOXNiYkVoV3pXMkNKcW9GK0F6V2FyS21lbmRjeWgv?=
 =?utf-8?B?K3Nta0dacWY2MkJ5M3FxUkcvRXhhT1owSXloSU1pMjVrelRYU2FLNmZUZlpt?=
 =?utf-8?B?RnIzVUZ3SStvLy9NUkloR1NheHUvR2trd0tJVXJ4cDNzb2ljME8zTUExV2xo?=
 =?utf-8?B?S3RDYkRaNkE3TTZPZzB2Nmg2ejdlQktZclNyaG9sMmxhcnpkbHphajhLSWov?=
 =?utf-8?B?RDVqK1M4U2J5YkMvMDRIM1M5ZFNRRUdNSTVTeld4cjFxYmFMYTVJN2RqTVky?=
 =?utf-8?B?bXEwNk1wZkVMcktHUzNoWktYbDhwWFZqU2NBZHp4WXFZR2x5cnFRVEJFK3dO?=
 =?utf-8?B?YzZmek9VQXhGLzB5RVZUcFIrc01nU0lNak1wTFN4TktSRFcvQ0xVR3dadmhw?=
 =?utf-8?B?RmpWMFkvaWN3STV3WlV2T1JUdEVHWEl5VStzaDJTOERaQ3dqZ2hiTGs2OWMv?=
 =?utf-8?B?TkZNVWhwVURXLzhQc2JOMUZ0VEFjaFNydXcyL2FWMWhZYmhtUFJHTTBtTVox?=
 =?utf-8?B?VFJQMkdsV1ZEMzdieW9JbjAwNUs1RGVQRDM3M1k2YkJBSTlDK1cvUlcvWFJs?=
 =?utf-8?B?UFVlMklTQmlDbWVOZVNxYjZwdmZTaEtxc1NWQVJrQXpwUnUrNG9IMzZIeXBD?=
 =?utf-8?B?V3FadGx0TDJLaGlmTHFua1BKOWI5QzlJeUw0cXlOdUJWb1VXVDJmRlRYcjdk?=
 =?utf-8?B?aXg2TXBTdTNHTlJxTzVXYStXbzBNWHlRQjdtL0VBR083Um1XWWVNUU5qQ0lT?=
 =?utf-8?B?TUwxaWFIdlRzV25TZERFUFd5L1BwNjEwRGV0ZGdzREprWENYNDZiWHFGdk9V?=
 =?utf-8?B?STNHSDJRRW9HQUJIcnI0dEdxMGIwb0M4SDJzT2t1ejRwOUxVaVNaVjFLQnJW?=
 =?utf-8?B?VCsyUkVaVmtOZHRDMDNVeW0vRGsrNElJcWUvVFp6UG15ZTNwRkVmMGZFQy9j?=
 =?utf-8?B?dk0xclVQZEdJRWh2N3JmTkRVVmJEYVR5bXJjcnFQQTcybVdFcTk5WmFrUlFp?=
 =?utf-8?B?bStQL1N5TldpMjRCbytXU3VXYTZhczdUaU1pWCtOZEFlSjgxTjFxbjZnNjJZ?=
 =?utf-8?B?OUNOUE44cWtVNVpSSFdYUjl5emd4MlNBUWJQcXJYVFNPMlhTZHltL0syUktl?=
 =?utf-8?B?Wm5yL1FOeGZmZTlZajJ0ZUQ3dFZaOG5rUklpSzdlT1JlOHZHV2ZFZG56c29Q?=
 =?utf-8?B?WXVZL0hmb1oxeENxZE5OaUhQMmF2MmNMRXpwRUFLMWIrai9kT1loaGx2d3ZC?=
 =?utf-8?B?TWc1elZwWkc1dGhIZWhEcGZaZ2ttd3U4WVVmaVRUMGNJRTFmdTB5dFJZNTEy?=
 =?utf-8?B?S1NvbnZYZEVZOERUT2lXRHVCZFpuZDJnbXU0eFAzR2hReXFKZ0xpWStPdlZn?=
 =?utf-8?Q?BWI0hjH/kWRLVdiMAE4wTzcVVIzit+UPNOgUk=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QWQzTjIrM0FtRW1HZno1MmpVdlFNeDdoNWFxN3VOcnlzbDBCaXZKTE5VVkpl?=
 =?utf-8?B?R1U2RXY2SnpvbEhjd0Foekc5RGY4clRZWGhrcG5OSElxRjRNLzlib3lTa2Iv?=
 =?utf-8?B?enRWMVRNMDB1ckpzSmgrN0tic2E0MStvR09FQjBqOE0rOXZRbkxYUUhuOUkw?=
 =?utf-8?B?dXppZmZxcWR2UHAzTDR6K3VLRUlmcEFvUFpsSlh2R2lnTXVxZzVvQy81Yjgv?=
 =?utf-8?B?VmswWGxCbldKaGp3cU1hTWNqbkFSeWQrSWRjdVptYUlnVEh3dC9GZkRHdVMz?=
 =?utf-8?B?VlJpMU53MU9MSSsrVHZ5ekFSdVRCTGNKZ2V4elNCeWQ4NGJ6QTdTQlVxcVlJ?=
 =?utf-8?B?M21tdVMzVzBwZFBjdCs2cVNUZ1gvRG10WFQrVGg3MTRqMXZOT1RGYkhJWG1p?=
 =?utf-8?B?L3Yxa215Y0wrU2FUaG1CYWhpQWZDbEFJczZQN1ZlZktEb0VWaGE3bE9MbDRs?=
 =?utf-8?B?VytqVTVOWlZsRENpZ0o1czJya3phK2ducDlvUTNmSGRxaHhnME9vcGhtU3px?=
 =?utf-8?B?c1hJRlRNK3pocnNsdkNmZkg4MzdjekJlNWNhaFBkMEl5Um1lQzZvdGZaZE1F?=
 =?utf-8?B?S0U5SFlsdzhJUU5UaGp4VVBGdWRITmFzdHIrWmdkcUF6TDd2R09JMklzd3hp?=
 =?utf-8?B?MGovQURYZ1ZyT0VNbGk0c0ZzaittRUdRckdDRUVreEhhZTlzRWNSTzdCaGpD?=
 =?utf-8?B?Wk9pMUJsMU11YWR6aTdBNkVyRi9meXJrVTF0cnhWRFNha3lkNVh0eFl6VW5n?=
 =?utf-8?B?MVdsYmRFTkpsd3c1NUZMczF3WWxFNllzZUluQlUwRTNsMytPb0l4cXROUU5u?=
 =?utf-8?B?aUlXY1dZSTMzUCs1QnRZYzdoak4wYmJkVkFVdWlsOGV6NVJWSERtdm1pN0tL?=
 =?utf-8?B?dmRkL0xlNThxVTB4U3JxYVlBajJGcnJtWmJNRWdENXNmWTEvd1psTDRjT05T?=
 =?utf-8?B?VHlwazdzb1Y2RWVJL3BxdU5YREdsaENUZG85YS9oMFV5MnJyMDZORDJIRzhW?=
 =?utf-8?B?c05TazVMY0ZtSndJWHZ0d0Z2QlpxYzl6MUhzUzhiTjFxQ2dlTWJmMEV1WEJh?=
 =?utf-8?B?Y2FlSTFZQmY1UGR3S3g0VE0vZVdoSVVWWXBMV0FLaCtJUU1EU2h3NkxTek1D?=
 =?utf-8?B?Kzg1QzlUNGxaZXBlcnZUeHVKVnVFaEpIYk45dU5zUmhRZ1hpV1pxcUNGelhm?=
 =?utf-8?B?L3Blb3hnZXp0eW5oc3ZEZmQrd3VacEsrVWhiMU1JeXNXMXJRNWFxcnVNZXlj?=
 =?utf-8?B?TWF4MFZ0Ui80NlpjcHYwaUtQVUVyQjN4eitkSk1kL0xVdHl6Vk00SDhmc3Jy?=
 =?utf-8?B?U2wzdkZHeVJxend5MVV4RFVpYzdSQ296THNxSm5HK1FqZXlIbXhabDIxNGxQ?=
 =?utf-8?B?WmlVS0JidGQzajFpbWcvM0ozci9td3dSbGJOVDlaa0RxaVlvZWNtMUh0cmFI?=
 =?utf-8?B?M21ieWI0QnRkM1dpL3UzWUhTOXZkQmM5T2VMN3FtMHprOS9ZMkMrb0cwUlk5?=
 =?utf-8?B?SHUwUXUxRXczc25QejZiZGF5OG5DNVVKd2hRV1BBMXlmNVE3UGJZQUpob3BJ?=
 =?utf-8?B?aWNraCsvY0FMZktJazFmMkIvMGR0ak9PaWVWd1c4dVdtQ0dveFB6YnB0alR5?=
 =?utf-8?B?M0ZKL0taeDIrdTg4Z29qeUlGQ09ETXlpQjZhZ2RGZTlkR2lrZGgwaUcwS0RI?=
 =?utf-8?B?RFVKQU5sRkZxTFliWkVJZkxiamR5Y01XZ3lsMmZPcDJ3MjFvUEpHSk9aek40?=
 =?utf-8?B?Sit6cWdMMHZkeXBwblczL3pmTGZwRXFyQWwxbXQrWnViSUdPVk9OdFFSYlpu?=
 =?utf-8?B?cU1FYXNHbFppenNOYVhiZ3lFM1puV21NNUo5M25TTmI3K2xLdE9IRFZ0Tk80?=
 =?utf-8?B?SkN4U3pwN21uaE5ySUt1WG9LeVFCaEg1dE8rcG0zUGtlVmJFQm8xQXdXVnV3?=
 =?utf-8?B?QjI3R2NsNGJQMENTeHpFRnhkQ25Mc2dvNnJBYjVpdVU3SDJROVdzclBrbE1p?=
 =?utf-8?B?ZzNZanB2TmZiMm9WR1BaVGo5VEQ3UWhZRlBFWTl5dmRCNzZNU3dheDJsN3lF?=
 =?utf-8?B?TndGOXZobzdBU0hoeG9ucFpNNFMxb3AzbXRyRXpzcHJYOWhaaEdpS0REcnZy?=
 =?utf-8?Q?XTRR9L/ER1GjADEWnoEeiPSlG?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fee5269-4907-4ca7-398e-08dcfc7f6dc9
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Nov 2024 03:19:01.2585 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Vz5uclWBJYNSUZbU6ivrVfjh1ykfyqDMrJ0eAMCHa9nSBZ31WCaFxqlLp1cO4aAIabLUAYEJW1lg1IJcn4DAMBC3g8wc9NsDBZXhN1HY5BE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7456
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.11;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IExpdSwgWWkgTCA8eWkubC5s
aXVAaW50ZWwuY29tPg0KPlNlbnQ6IE1vbmRheSwgTm92ZW1iZXIgNCwgMjAyNCAxMToxNiBBTQ0K
PlN1YmplY3Q6IFJlOiBbUEFUQ0ggdjQgMTQvMTddIGludGVsX2lvbW11OiBTZXQgZGVmYXVsdCBh
d19iaXRzIHRvIDQ4IGluIHNjYWxhYmxlDQo+bW9kZXJuIG1vZGUNCj4NCj5PbiAyMDI0LzkvMzAg
MTc6MjYsIFpoZW56aG9uZyBEdWFuIHdyb3RlOg0KPj4gQWNjb3JkaW5nIHRvIFZURCBzcGVjLCBz
dGFnZS0xIHBhZ2UgdGFibGUgY291bGQgc3VwcG9ydCA0LWxldmVsIGFuZA0KPj4gNS1sZXZlbCBw
YWdpbmcuDQo+Pg0KPj4gSG93ZXZlciwgNS1sZXZlbCBwYWdpbmcgdHJhbnNsYXRpb24gZW11bGF0
aW9uIGlzIHVuc3VwcG9ydGVkIHlldC4NCj4+IFRoYXQgbWVhbnMgdGhlIG9ubHkgc3VwcG9ydGVk
IHZhbHVlIGZvciBhd19iaXRzIGlzIDQ4Lg0KPj4NCj4+IFNvIGRlZmF1bHQgYXdfYml0cyB0byA0
OCBpbiBzY2FsYWJsZSBtb2Rlcm4gbW9kZS4gSW4gb3RoZXIgY2FzZXMsDQo+PiBpdCBpcyBzdGls
bCBkZWZhdWx0IHRvIDM5IGZvciBiYWNrd2FyZCBjb21wYXRpYmlsaXR5Lg0KPj4NCj4+IEFkZCBh
IGNoZWNrIHRvIGVuc3VyZSB1c2VyIHNwZWNpZmllZCB2YWx1ZSBpcyA0OCBpbiBtb2Rlcm4gbW9k
ZQ0KPj4gZm9yIG5vdy4NCj4NCj50aGlzIGlzIG5vdCBhIHNpbXBsZSBjaGVjay4gSSB0aGluayB5
b3VyIHBhdGNoIG1ha2VzIGFuIGF1dG8gc2VsZWN0aW9uDQo+b2YgYXdfYml0cy4NCg0KWWVzLCBp
ZiB1c2VyIGRvZXNuJ3Qgc3BlY2lmeSBpdCwgd2lsbCBhdXRvIHNlbGVjdCBhIGRlZmF1bHQuDQoN
Cj4NCj4+IFNpZ25lZC1vZmYtYnk6IFpoZW56aG9uZyBEdWFuIDx6aGVuemhvbmcuZHVhbkBpbnRl
bC5jb20+DQo+PiBSZXZpZXdlZC1ieTogQ2zDqW1lbnQgTWF0aGlldS0tRHJpZjxjbGVtZW50Lm1h
dGhpZXUtLWRyaWZAZXZpZGVuLmNvbT4NCj4+IC0tLQ0KPj4gICBpbmNsdWRlL2h3L2kzODYvaW50
ZWxfaW9tbXUuaCB8ICAyICstDQo+PiAgIGh3L2kzODYvaW50ZWxfaW9tbXUuYyAgICAgICAgIHwg
MTAgKysrKysrKysrLQ0KPj4gICAyIGZpbGVzIGNoYW5nZWQsIDEwIGluc2VydGlvbnMoKyksIDIg
ZGVsZXRpb25zKC0pDQo+Pg0KPj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvaHcvaTM4Ni9pbnRlbF9p
b21tdS5oIGIvaW5jbHVkZS9ody9pMzg2L2ludGVsX2lvbW11LmgNCj4+IGluZGV4IGI4NDNkMDY5
Y2MuLjQ4MTM0YmRhMTEgMTAwNjQ0DQo+PiAtLS0gYS9pbmNsdWRlL2h3L2kzODYvaW50ZWxfaW9t
bXUuaA0KPj4gKysrIGIvaW5jbHVkZS9ody9pMzg2L2ludGVsX2lvbW11LmgNCj4+IEBAIC00NSw3
ICs0NSw3IEBAIE9CSkVDVF9ERUNMQVJFX1NJTVBMRV9UWVBFKEludGVsSU9NTVVTdGF0ZSwNCj5J
TlRFTF9JT01NVV9ERVZJQ0UpDQo+PiAgICNkZWZpbmUgRE1BUl9SRUdfU0laRSAgICAgICAgICAg
ICAgIDB4MjMwDQo+PiAgICNkZWZpbmUgVlREX0hPU1RfQVdfMzlCSVQgICAgICAgICAgIDM5DQo+
PiAgICNkZWZpbmUgVlREX0hPU1RfQVdfNDhCSVQgICAgICAgICAgIDQ4DQo+PiAtI2RlZmluZSBW
VERfSE9TVF9BRERSRVNTX1dJRFRIICAgICAgVlREX0hPU1RfQVdfMzlCSVQNCj4+ICsjZGVmaW5l
IFZURF9IT1NUX0FXX0FVVE8gICAgICAgICAgICAweGZmDQo+PiAgICNkZWZpbmUgVlREX0hBV19N
QVNLKGF3KSAgICAgICAgICAgICgoMVVMTCA8PCAoYXcpKSAtIDEpDQo+Pg0KPj4gICAjZGVmaW5l
IERNQVJfUkVQT1JUX0ZfSU5UUiAgICAgICAgICAoMSkNCj4+IGRpZmYgLS1naXQgYS9ody9pMzg2
L2ludGVsX2lvbW11LmMgYi9ody9pMzg2L2ludGVsX2lvbW11LmMNCj4+IGluZGV4IDkxZDdiMWFi
ZmEuLjA2OGEwOGY1MjIgMTAwNjQ0DQo+PiAtLS0gYS9ody9pMzg2L2ludGVsX2lvbW11LmMNCj4+
ICsrKyBiL2h3L2kzODYvaW50ZWxfaW9tbXUuYw0KPj4gQEAgLTM3NzYsNyArMzc3Niw3IEBAIHN0
YXRpYyBQcm9wZXJ0eSB2dGRfcHJvcGVydGllc1tdID0gew0KPj4gICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgT05fT0ZGX0FVVE9fQVVUTyksDQo+PiAgICAgICBERUZJTkVfUFJPUF9CT09M
KCJ4LWJ1Z2d5LWVpbSIsIEludGVsSU9NTVVTdGF0ZSwgYnVnZ3lfZWltLCBmYWxzZSksDQo+PiAg
ICAgICBERUZJTkVfUFJPUF9VSU5UOCgiYXctYml0cyIsIEludGVsSU9NTVVTdGF0ZSwgYXdfYml0
cywNCj4+IC0gICAgICAgICAgICAgICAgICAgICAgVlREX0hPU1RfQUREUkVTU19XSURUSCksDQo+
PiArICAgICAgICAgICAgICAgICAgICAgIFZURF9IT1NUX0FXX0FVVE8pLA0KPj4gICAgICAgREVG
SU5FX1BST1BfQk9PTCgiY2FjaGluZy1tb2RlIiwgSW50ZWxJT01NVVN0YXRlLCBjYWNoaW5nX21v
ZGUsDQo+RkFMU0UpLA0KPj4gICAgICAgREVGSU5FX1BST1BfQk9PTCgieC1zY2FsYWJsZS1tb2Rl
IiwgSW50ZWxJT01NVVN0YXRlLCBzY2FsYWJsZV9tb2RlLA0KPkZBTFNFKSwNCj4+ICAgICAgIERF
RklORV9QUk9QX0JPT0woInNub29wLWNvbnRyb2wiLCBJbnRlbElPTU1VU3RhdGUsIHNub29wX2Nv
bnRyb2wsDQo+ZmFsc2UpLA0KPj4gQEAgLTQ2ODMsNiArNDY4MywxNCBAQCBzdGF0aWMgYm9vbCB2
dGRfZGVjaWRlX2NvbmZpZyhJbnRlbElPTU1VU3RhdGUgKnMsDQo+RXJyb3IgKiplcnJwKQ0KPj4g
ICAgICAgICAgIH0NCj4+ICAgICAgIH0NCj4+DQo+PiArICAgIGlmIChzLT5hd19iaXRzID09IFZU
RF9IT1NUX0FXX0FVVE8pIHsNCj4+ICsgICAgICAgIGlmIChzLT5zY2FsYWJsZV9tb2Rlcm4pIHsN
Cj4+ICsgICAgICAgICAgICBzLT5hd19iaXRzID0gVlREX0hPU1RfQVdfNDhCSVQ7DQo+PiArICAg
ICAgICB9IGVsc2Ugew0KPj4gKyAgICAgICAgICAgIHMtPmF3X2JpdHMgPSBWVERfSE9TVF9BV18z
OUJJVDsNCj4+ICsgICAgICAgIH0NCj4+ICsgICAgfQ0KPg0KPklmIHRoZSBkZWZhdWx0IHZhbHVl
IG9mIHMtPmF3X2JpdHMgaXMgc3RpbGwgMzksIHlvdSBkb24ndCBrbm93IGlmIGl0J3MNCj5zZXQg
YnkgdGhlIGFkbWluIG9yIHRoZSBvcmNoZXN0cmF0aW9uIHN0YWNrLiBUaGlzIGlzIHdoeSB5b3Ug
bmVlZA0KPnRvIGNoYW5nZSBpdC4gcmlnaHQ/DQoNCkV4YWN0bHksIHRoYXQncyByZWFzb24gb2Yg
aW50cm9kdWNpbmcgVlREX0hPU1RfQVdfQVVUTygweGZmKS4NCg0KVGhhbmtzDQpaaGVuemhvbmcN
Cg0K

