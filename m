Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB85CC4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2024 09:14:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1jYK-00025O-Cc; Tue, 30 Apr 2024 05:13:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1s1jYE-00023u-Mp
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 05:13:26 -0400
Received: from mgamail.intel.com ([192.198.163.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1s1jYC-0007jx-0O
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 05:13:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1714468404; x=1746004404;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=HVvoNHDPUc3MBT1ts7f9eI3YCusvtbEJJ3BxXXh7eBo=;
 b=i5RGy9KZS+D7mbLP7RLGF90eMoD6EePox/G2As5nLNT+416ZOcvUc7A1
 muDUErnr5thvPS+m39s9jpp6o8NnLhbpx6roqGdpUrgDXBatCHBCTw8xd
 vA2F/g6YhFJ+X/Ca1uoyMFccP7xf3bYi5ie4FdTik5R+NB6yzH5hAmAhm
 Rdz/ESkAA0jYxbdsynxZLzPWw3gzj7K/U4hgTPZf98801T+PPSbDbrnMr
 xAF4eYeVdY3s1jz5qvrlAsnl7mDHln1Zgs5qVON/M+4zpT/UqGG6JQAZu
 PzrBKkX3sLE5ZtUqIIn07ktuQJf+oIcZFnI9Sz2ARlE9phy/QfucZqXOu Q==;
X-CSE-ConnectionGUID: QThQEA13QauPLGsoWFDTJA==
X-CSE-MsgGUID: cmN665S5SzeQUFxyz3xoJQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11059"; a="20848707"
X-IronPort-AV: E=Sophos;i="6.07,241,1708416000"; d="scan'208";a="20848707"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Apr 2024 02:13:18 -0700
X-CSE-ConnectionGUID: zIR6AnUnTZm/vzxiF0/fIw==
X-CSE-MsgGUID: 5eOzSNkjQaqFNb5LmJD3Eg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,241,1708416000"; d="scan'208";a="26901591"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
 by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 30 Apr 2024 02:13:17 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 30 Apr 2024 02:13:16 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 30 Apr 2024 02:13:16 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 30 Apr 2024 02:13:16 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 30 Apr 2024 02:13:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CzlKkYjdwk1uW7eKPjG4FXgH9BkQm0a+BQGIk3t0b3K+NtCRpDoFW0Bxwx9u4m2/RM/meKxXSeeeOtZXL44sANmiYNFw58rfW++0FprAh3xIGutslvPXwgcWRB30eDTZdMdWtjMbXvTg6wnE8RZ5mYIP2lyno4W5NYXtTNzVGQ7QPtwFW9kzqIixSCLEoKcTja/amec4HNDSxiXn812DeXqNrpsy1lZTyzq6b+YjZsTAAJQ/y/2U78q6udfEXNjUCE38KrFLoGl1QwBoJ4pZL1II+NHRKt8EDysu6tL/w4frQqsWgS/I6OmD2wRAyDyJU7bg0uFOxNUV+Ki0c3XqVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HVvoNHDPUc3MBT1ts7f9eI3YCusvtbEJJ3BxXXh7eBo=;
 b=cPcgrBKTUvneINn1lVpF5VjuPCoKBNd7gxWXDqFoMQ6pkvMX0RImbzBleta1on6QhaRwPwZy5EgVwCu+gBu4h/DlqEnjHTYiVNmwRaxq8+YIVTFICEu83HLg+XhclxIeH6Ty0b/LEjxweceWBCkhlqMLTdz1a5dPgDFHaPbfY6bDRvFmEj6ihnOpNseDr8eJf80MWZ2doMdllTByvqg9a64L7hEjqyD7En1AFL5yoY0/3pHVOLfbw/+uRY97kmjUUe6R6T3ZrP9fbEUvm9HFHOY3XkT+AXprU5inreMipZ4rdtM6JBqmXZ6MOLO43fpPMEdTVqSy7KK5aYIFUsSh1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by PH0PR11MB7614.namprd11.prod.outlook.com (2603:10b6:510:28f::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.36; Tue, 30 Apr
 2024 09:13:14 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::e4a3:76ce:879:9129]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::e4a3:76ce:879:9129%7]) with mapi id 15.20.7519.031; Tue, 30 Apr 2024
 09:13:14 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "mst@redhat.com"
 <mst@redhat.com>, "peterx@redhat.com" <peterx@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>, "jgg@nvidia.com"
 <jgg@nvidia.com>, "nicolinc@nvidia.com" <nicolinc@nvidia.com>,
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>, "Tian, Kevin"
 <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>, "Peng, Chao P"
 <chao.p.peng@intel.com>
Subject: RE: [PATCH v3 02/19] vfio/container: Introduce
 HostIOMMUDeviceLegacyVFIO device
Thread-Topic: [PATCH v3 02/19] vfio/container: Introduce
 HostIOMMUDeviceLegacyVFIO device
Thread-Index: AQHamgH9z0N3F43eA02TiqIADP11SLGAck2AgAAVDDA=
Date: Tue, 30 Apr 2024 09:13:13 +0000
Message-ID: <SJ0PR11MB6744D20165F8D9F8383CA115921A2@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20240429065046.3688701-1-zhenzhong.duan@intel.com>
 <20240429065046.3688701-3-zhenzhong.duan@intel.com>
 <5160adfc-9630-49f0-a2a4-f6987c819bc5@redhat.com>
In-Reply-To: <5160adfc-9630-49f0-a2a4-f6987c819bc5@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|PH0PR11MB7614:EE_
x-ms-office365-filtering-correlation-id: 438b4d11-d561-4a2a-8b68-08dc68f5c3be
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230031|376005|1800799015|7416005|366007|38070700009; 
x-microsoft-antispam-message-info: =?utf-8?B?dnJzcy9oVDRkRERpNktaMTBVRjY2OVR4MVAvVlFVMFA5Qjh2Rk9LTCtCclVv?=
 =?utf-8?B?RDFkTW15TEVWempqeEVua2cvTzFXWEhvdGp2VHBmelh4UWJoZjlQdHVDTlk0?=
 =?utf-8?B?MWEzbFg1RFkwWGRKTE9UR2pyc055cHd5SnVlT2NzMHdpSHUzZFZrT0FFQktE?=
 =?utf-8?B?a0RlRjEwTm1CY3U1cnBmRjZuNjlybzVOdVBubzZMRE82eGdVc0dJTUJGeGdK?=
 =?utf-8?B?Wk9VclFlQTJQUWhFTjVpa0hSM2lkN05hSEJLUUpwaDV0bkRPSnVzUVJjbnJp?=
 =?utf-8?B?RnQveU1UQ3Zjc3lGdmowb0xyZTJleFNSNU9qVVRtTGZpZ1JEaGUwTEkyb3V1?=
 =?utf-8?B?NlVkRzZObUptdWJlM25QSkxaQWk5cVJzZVZjQklUenZneVBOaDFGNlRuWEVG?=
 =?utf-8?B?QkRhU2Z3ZjEvY2FFRWxHUWtCcm9Db2FvZUxFMThqalBTSmlSUTVtdSswK1Nl?=
 =?utf-8?B?bSsyVGdzazNObGRKVC9BR3MwL0swMC9EQWtzNitBZENlSncvM1p2SnQ1N1F0?=
 =?utf-8?B?YUpXT0ZCTGh0M2VnWnVIakhyQ2pRc2xQTDlpdTlHTDVnT1pTZG1JNXZvNE1Z?=
 =?utf-8?B?cytIYXhQMnlOZTQ4YUs2eDRVVmlHSlBMd2doQkdXNUc3eFplUmR3eDJCN1BH?=
 =?utf-8?B?OWovY2hkQ2oyREwrUVNtdzcxRW5NTEF6YnNhU1llRytvdDBLak9uUTBxR0tV?=
 =?utf-8?B?SmZjNjJsYlpvSWZhNjRoZXdyQ3VCYWRlYzhFb2RCZ1JyMEEwNy80K0lPOUJt?=
 =?utf-8?B?UWE1OG1qNjNLUUYyQVFvbGhoaEFveDRJeXZoMWlnRHNROTRaZFJLUXdyWEZS?=
 =?utf-8?B?WXRKcGdEOUdsblM3RCt3NERTQ2x2MzZBZWlWTzRaUnR2RmxmQ05iSTBaalYw?=
 =?utf-8?B?c0tpeVU0YkVXRmpZM0hkWnJIVjFzUUl5dHN6ZVJzUElrY1ZmeS9tUUJRQVEr?=
 =?utf-8?B?QjdTZGZMNy9XU0JKcUU4SmZRdnF1dkVtcVQ0R3o1aFpUTlgvR3IyL3NYdzg4?=
 =?utf-8?B?V0hNT0JTM3k4TkZhbTMxQXJaMmpaNm1ENjhKKzF0Mzk0ZkZLMEhqWXZWZElp?=
 =?utf-8?B?WkxxNnNYelZyTnNjczZZZXlqUnREN1pKT1JOUEpEZmtVeTlZN2JsUmFTUm5Z?=
 =?utf-8?B?b1VFcUZZRVllS3BuenpJRk81VDBhVnJwdWwzc2JKeG0zaWRtaE5ZWXplTndv?=
 =?utf-8?B?bDRXZU9yRXRMUGZsWGdPTUd5c0w2WWpjTTRWUkhiUm5SZ1lEOUV3elp3S0Qy?=
 =?utf-8?B?aVR4Z002TFJNbGJzekh5WWJITFFSQUhTSDIvdGs4OFFIWnBYYmJCclZydlM3?=
 =?utf-8?B?VFk4c0VxWFRPQWd0b21FN2l0WVlpNkhOUnJpU1FnR3NucGNiMnJsTEZRUW1r?=
 =?utf-8?B?Q3BpSE9BMVZIVHJIN0RZbzd2TUdIaGxRNlYzTlh2S2NoSzJNall2R0Z5OTlX?=
 =?utf-8?B?b29HN3lpSmM2aXFtb2N3UkdUSDNlVHdENDNDTnM5WGplNFVRY3UrbHJoNEVo?=
 =?utf-8?B?ZFVIZnQ1K1BFUUZOM21pR0Q0QXg5U3JaeEU1NzVrbk9XQmoxWmlyMmZXNGtB?=
 =?utf-8?B?T2pmMnRKYkFjcFlON0RRQUlwa3d5RVRpRE0rcnFhS3ZFVHgvR05ZUUZsaURo?=
 =?utf-8?B?bDZCWFFyZlYvWEd5cXMvVmdKSXhYR0x2UEFmRXdub2NtYW02SnhpbmwvQWxO?=
 =?utf-8?B?dktDalUvVmVZWWxpVmJmbjNvc3Y2aHp1eVphaXg1QTB1c0t6ZUdydks1cGU5?=
 =?utf-8?B?YlFoYWpJOUtxc3VoakdkWlBoWm13dk1kL0M4bncyd2pXQ3FZekViWjZBc2xY?=
 =?utf-8?B?THhBSkJVUFV1VFpBODBsdz09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(7416005)(366007)(38070700009); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bnR1cWpmdmcwc2F4eW9tZkV4V3JsUU1WdjRlYjFJUXpEWko0Ny9zRVR0N1Zi?=
 =?utf-8?B?RnN2UjlqR0NzMU0zQTZkUndXUEhBVzZnUDZsK2IwTHRzL3RaUEljRnFWOUFT?=
 =?utf-8?B?WEJMWHpUS3YrbmlHWGNTUVhUcmFJKzN5dXlVRnZBWDdGb3Y0Mld0RThseThR?=
 =?utf-8?B?d1NiYVQwL3V2Rm5hcytpWFBnMUpRam12YUZKVTBJZHhZUWNTS29zdEpEY1ZE?=
 =?utf-8?B?OXk3aEUwSFZWRVhjMmRuOGliK2NUa1Z6bkNXdlUwd0plUmpzRCtIY1lTR2VH?=
 =?utf-8?B?THNsS29SZGdNTmFCL0U3bmwwWU5ITEtUZkhrZCtGeEI5Y0tOWWNpa2x3WUdG?=
 =?utf-8?B?QWJNbHdsVjNYVjVDbVJOMUkxWC9vWTJDVTFabnVHMHlwWTJSVFB6K3JGai9H?=
 =?utf-8?B?cXVHVTd1SjEvZlJMODlDMmt2aEpKaVVZNjBiaFNUR2xFRGpqbWJKcDA0RFJx?=
 =?utf-8?B?Nm9IT2FFNy9HNUE3dlNxQUVnclZ2T09zc0lMbVBLOHZoc2Z2UnBwVEtRWjIy?=
 =?utf-8?B?cldoNDhPcFp3VzVHdDFFelNqVEoyMzBQa3VhejIvSHdGR0ZnU3hSeHFCSUR5?=
 =?utf-8?B?SDcyVlJWMW9WVGpYbkZ4MmlFeHBXSGZlbTA1UGhla1hWTEI1VDd6Wlk0RDlq?=
 =?utf-8?B?aDdZRDNVNlNuT1BzNUtFR1o3QW9ublFRdTFnTGdQV0JaL3o2SVkzdEx4RU40?=
 =?utf-8?B?RXQ0enBOUFAyQk9BTGc5V0JGSzYvVUZ2Q09ZNWlReGJOY200YlRQTWIvNFlq?=
 =?utf-8?B?K3NJRkh5YTJ1SFEwYmJaTllyVjl0YnRSTEk2dUVXdGxoNitiTGo4R0ovTmx6?=
 =?utf-8?B?cEJBYXp3MW1NM3IwTml2VHdqKzRIa1NVbllUeitzNUVMSlR2dVMvU3l3bzlM?=
 =?utf-8?B?dEk0SDNRbWV0SDVaTXJ3OXZVc25peVhiby9SS1J3eHNsZWVuWk1Hc1B3M1hp?=
 =?utf-8?B?Wm5IMGQ2RXdldGJPc1BKS2JBaUJNMUlPeXhPbnlXME1XQmx2YWpSVkhLUEVX?=
 =?utf-8?B?bWt4djB1d0Vrb2U4SW9jc2JZc052OURsb1FraVI3YkdTVVNlVnRka2g3NFZL?=
 =?utf-8?B?RmNmZDcyM25ZZnNxdVkwdTRkTVM5QnRYNFh4LzhJeFpQaFFDWklyQytqdGNM?=
 =?utf-8?B?M1ZaNEN5T1NxWU0rbXVBbEs5VXFRblh4RmJjcFF2bndsbloxT1U3WVRBUC9x?=
 =?utf-8?B?Q08vVHFaUWVEKzQ1M1BBVVZ1b2ZTZDNlY0xOUjVBUWlBVVNJSVdiOVZwT0hM?=
 =?utf-8?B?K09NLzR1OFR6dVRFbUxZRmtDOW8wMWpKa3JYUjhFT1JzSUlIeWVrRWJDUFJQ?=
 =?utf-8?B?YmpyTlJVcGtuenNTcXJid29PeXd5YzBhYXJDNFhVeE5yaCt3akRPd3hvMjBD?=
 =?utf-8?B?OFh0citNaEl6MGNFZ2IzKzNzblVYWEZ3a1V1dEdoSjU3L05LQTZpcXVsOFUr?=
 =?utf-8?B?UEVYMVJ4YkZoYnUwNFNuUmNQczNKcXpMa0R3aytMMmJyNUR0THh0cHd2R2dP?=
 =?utf-8?B?eWhrTDR1QnJLcDBzMHF3aWYrLytDT2NTRXFIUzk4amVmM1VPeDhnOWdicE55?=
 =?utf-8?B?SGhuVzIxWnhyVldydE9JYWxMSnYxZ1J6enF1M1k1NThCZFozSUJUWHhkN2g1?=
 =?utf-8?B?MnB1SDhxc2RVVXZOOWpKWkE2Y3RpelpCUTNuUGVBQWxvZnVoNFIweUZFVmRH?=
 =?utf-8?B?MFExaVBiSk9HaG5US2dNT0xVV1NxdHV6WDlDSHFKdlNvaVBXSlArWFFJWWMz?=
 =?utf-8?B?QjNaSEtwMThLaTN3aGpoSE85cGVUQkxUV2l0bjlRUVh4dFREanNsMjFvMkxs?=
 =?utf-8?B?NUJ6WEw4V2dSZEJmK25wM3FKdkJCa3UxeXEveGVsRmNzTGcwajBHZGNLamRh?=
 =?utf-8?B?Yi9qYXJ1aFNTT0QwR0tCWmg0eE9qSmtQeHBLb0lrcmYzRmJ0eCtnR2ZvUTNJ?=
 =?utf-8?B?TU1pZHd4cmdtcFpvVnlnK2h4SkF6bmRWRk4ySnFBb3BMeEZEdHNBbE9DeWFZ?=
 =?utf-8?B?dElaL1E1NjFTNGd5QWY1Mm55NWxBTUZtTkpkUUt5bjhQMVJvUDZhMk1jQzVV?=
 =?utf-8?B?SlozWHhieHlHVEV3YmIreXQ5cnBJemRKdGpTWXhXRE0yRnA4bzBZcVJIR1Jn?=
 =?utf-8?Q?85z5lVXExPUz/2J415HT9WC/X?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 438b4d11-d561-4a2a-8b68-08dc68f5c3be
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Apr 2024 09:13:13.9473 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mUqA5FyU0HXXZ1aL+N7zT1ZSf7YY9H+tA3qDafnFmekFOBSJ3hiUeN+n20eRtZuoswvGl2yn0aSu0DUkLr+TtDPQAAQjYxeDPR33W3snsjg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7614
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.9;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.987,
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IEPDqWRyaWMgTGUgR29hdGVy
IDxjbGdAcmVkaGF0LmNvbT4NCj5TdWJqZWN0OiBSZTogW1BBVENIIHYzIDAyLzE5XSB2ZmlvL2Nv
bnRhaW5lcjogSW50cm9kdWNlDQo+SG9zdElPTU1VRGV2aWNlTGVnYWN5VkZJTyBkZXZpY2UNCj4N
Cj5PbiA0LzI5LzI0IDA4OjUwLCBaaGVuemhvbmcgRHVhbiB3cm90ZToNCj4+IEhvc3RJT01NVURl
dmljZUxlZ2FjeVZGSU8gcmVwcmVzZW50cyBhIGhvc3QgSU9NTVUgZGV2aWNlIHVuZGVyDQo+VkZJ
Tw0KPj4gbGVnYWN5IGNvbnRhaW5lciBiYWNrZW5kLg0KPj4NCj4+IEl0IGluY2x1ZGVzIGEgbGlu
ayB0byBWRklPRGV2aWNlLg0KPg0KPkkgZG9uJ3Qgc2VlIGFueSB1c2Ugb2YgdGhpcyBhdHRyaWJ1
dGUuIE1heSBiZSBpbnRyb2R1Y2UgbGF0ZXIgd2hlbiBuZWVkZWQuDQoNCkluZGVlZCwgd2lsbCBy
ZW1vdmUuDQoNClRoZW4gJ3N0cnVjdCBIb3N0SU9NTVVEZXZpY2VMZWdhY3lWRklPJyBpcyBzYW1l
IGFzDQpzdHJ1Y3QgSG9zdElPTU1VRGV2aWNlLg0KDQpOb3QgY2xlYXIgaWYgaXQncyBwcmVmZXJy
ZWQgdG8gcmVtb3ZlICdzdHJ1Y3QgSG9zdElPTU1VRGV2aWNlTGVnYWN5VkZJTycNCmFuZCB1c2Ug
SG9zdElPTU1VRGV2aWNlIGluc3RlYWQuIFNvbWV0aGluZyBsaWtlOg0KDQpPQkpFQ1RfREVDTEFS
RV9TSU1QTEVfVFlQRShIb3N0SU9NTVVEZXZpY2UsDQogICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIEhPU1RfSU9NTVVfREVWSUNFX0xFR0FDWV9WRklPKQ0KDQpUaGFu
a3MNClpoZW56aG9uZw0KDQo+DQo+VGhhbmtzLA0KPg0KPkMuDQo+DQo+Pg0KPj4gU3VnZ2VzdGVk
LWJ5OiBFcmljIEF1Z2VyIDxlcmljLmF1Z2VyQHJlZGhhdC5jb20+DQo+PiBTdWdnZXN0ZWQtYnk6
IEPDqWRyaWMgTGUgR29hdGVyIDxjbGdAcmVkaGF0LmNvbT4NCj4+IFNpZ25lZC1vZmYtYnk6IFpo
ZW56aG9uZyBEdWFuIDx6aGVuemhvbmcuZHVhbkBpbnRlbC5jb20+DQo+PiAtLS0NCj4+ICAgaW5j
bHVkZS9ody92ZmlvL3ZmaW8tY29tbW9uLmggfCAxMiArKysrKysrKysrKysNCj4+ICAgaHcvdmZp
by9jb250YWluZXIuYyAgICAgICAgICAgfCAgNiArKysrKy0NCj4+ICAgMiBmaWxlcyBjaGFuZ2Vk
LCAxNyBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+Pg0KPj4gZGlmZiAtLWdpdCBhL2lu
Y2x1ZGUvaHcvdmZpby92ZmlvLWNvbW1vbi5oIGIvaW5jbHVkZS9ody92ZmlvL3ZmaW8tDQo+Y29t
bW9uLmgNCj4+IGluZGV4IGI5ZGE2YzA4ZWYuLmFhM2FiZTBhMTggMTAwNjQ0DQo+PiAtLS0gYS9p
bmNsdWRlL2h3L3ZmaW8vdmZpby1jb21tb24uaA0KPj4gKysrIGIvaW5jbHVkZS9ody92ZmlvL3Zm
aW8tY29tbW9uLmgNCj4+IEBAIC0zMSw2ICszMSw3IEBADQo+PiAgICNlbmRpZg0KPj4gICAjaW5j
bHVkZSAic3lzZW11L3N5c2VtdS5oIg0KPj4gICAjaW5jbHVkZSAiaHcvdmZpby92ZmlvLWNvbnRh
aW5lci1iYXNlLmgiDQo+PiArI2luY2x1ZGUgInN5c2VtdS9ob3N0X2lvbW11X2RldmljZS5oIg0K
Pj4NCj4+ICAgI2RlZmluZSBWRklPX01TR19QUkVGSVggInZmaW8gJXM6ICINCj4+DQo+PiBAQCAt
MTQ3LDYgKzE0OCwxNyBAQCB0eXBlZGVmIHN0cnVjdCBWRklPR3JvdXAgew0KPj4gICAgICAgYm9v
bCByYW1fYmxvY2tfZGlzY2FyZF9hbGxvd2VkOw0KPj4gICB9IFZGSU9Hcm91cDsNCj4+DQo+PiAr
I2RlZmluZSBUWVBFX0hPU1RfSU9NTVVfREVWSUNFX0xFR0FDWV9WRklPDQo+VFlQRV9IT1NUX0lP
TU1VX0RFVklDRSAiLWxlZ2FjeS12ZmlvIg0KPj4gK09CSkVDVF9ERUNMQVJFX1NJTVBMRV9UWVBF
KEhvc3RJT01NVURldmljZUxlZ2FjeVZGSU8sDQo+PiArICAgICAgICAgICAgICAgICAgICAgICAg
ICAgSE9TVF9JT01NVV9ERVZJQ0VfTEVHQUNZX1ZGSU8pDQo+PiArDQo+PiArLyogQWJzdHJhY3Qg
b2YgaG9zdCBJT01NVSBkZXZpY2Ugd2l0aCBWRklPIGxlZ2FjeSBjb250YWluZXIgYmFja2VuZCAq
Lw0KPj4gK3N0cnVjdCBIb3N0SU9NTVVEZXZpY2VMZWdhY3lWRklPIHsNCj4+ICsgICAgSG9zdElP
TU1VRGV2aWNlIHBhcmVudF9vYmo7DQo+PiArDQo+PiArICAgIFZGSU9EZXZpY2UgKnZkZXY7DQo+
PiArfTsNCj4+ICsNCj4+ICAgdHlwZWRlZiBzdHJ1Y3QgVkZJT0RNQUJ1ZiB7DQo+PiAgICAgICBR
ZW11RG1hQnVmIGJ1ZjsNCj4+ICAgICAgIHVpbnQzMl90IHBvc194LCBwb3NfeSwgcG9zX3VwZGF0
ZXM7DQo+PiBkaWZmIC0tZ2l0IGEvaHcvdmZpby9jb250YWluZXIuYyBiL2h3L3ZmaW8vY29udGFp
bmVyLmMNCj4+IGluZGV4IDc3YmRlYzI3NmUuLjNiNjgyNjk5NmEgMTAwNjQ0DQo+PiAtLS0gYS9o
dy92ZmlvL2NvbnRhaW5lci5jDQo+PiArKysgYi9ody92ZmlvL2NvbnRhaW5lci5jDQo+PiBAQCAt
MTE0OCw3ICsxMTQ4LDExIEBAIHN0YXRpYyBjb25zdCBUeXBlSW5mbyB0eXBlc1tdID0gew0KPj4g
ICAgICAgICAgIC5uYW1lID0gVFlQRV9WRklPX0lPTU1VX0xFR0FDWSwNCj4+ICAgICAgICAgICAu
cGFyZW50ID0gVFlQRV9WRklPX0lPTU1VLA0KPj4gICAgICAgICAgIC5jbGFzc19pbml0ID0gdmZp
b19pb21tdV9sZWdhY3lfY2xhc3NfaW5pdCwNCj4+IC0gICAgfSwNCj4+ICsgICAgfSwgew0KPj4g
KyAgICAgICAgLm5hbWUgPSBUWVBFX0hPU1RfSU9NTVVfREVWSUNFX0xFR0FDWV9WRklPLA0KPj4g
KyAgICAgICAgLnBhcmVudCA9IFRZUEVfSE9TVF9JT01NVV9ERVZJQ0UsDQo+PiArICAgICAgICAu
aW5zdGFuY2Vfc2l6ZSA9IHNpemVvZihIb3N0SU9NTVVEZXZpY2VMZWdhY3lWRklPKSwNCj4+ICsg
ICAgfQ0KPj4gICB9Ow0KPj4NCj4+ICAgREVGSU5FX1RZUEVTKHR5cGVzKQ0KDQo=

