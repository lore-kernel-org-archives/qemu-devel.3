Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C01EC4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2024 10:16:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1kXU-0007Dw-Kw; Tue, 30 Apr 2024 06:16:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1s1kXN-00077d-O3
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 06:16:38 -0400
Received: from mgamail.intel.com ([198.175.65.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1s1kXG-0003Gr-Rq
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 06:16:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1714472191; x=1746008191;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=dYw1eDgMVGQ9XOWpK1egoyVRsiB5wbOfW0IbIIYBNTE=;
 b=NxQ/hY3EmE1KVzaIAC65PZsH1ZQzhQ5GA/+jpFXWSHkwWLWRwUmh+Igk
 S/cQ5yPh+oh1GexSewWwDJiouUe9IurasQr/tfGVujZzB94HFOH4kP1J6
 DRW9a8i+mUAgpeKkLfDyXAIiwG/9eFBuAmUruIJ/bdEVzNED5ftMCWLzC
 ykkcFAwkNn8n9Dm/1yG4cbTEv8DhrBgyhA7cnEt2gjDKOQJjYzPoMQRYI
 6jHMEMwT83pVPzLOV5b9niyu9uZcldRyzMNS4Pt9+K1XNLwsQk9OVLVY8
 GhlG49EVlDeVVH4LAyiviV5reb5aXfMJN+5crb/cPpKyV3PSXPC5gb8Tl A==;
X-CSE-ConnectionGUID: IP3LMfezQdG65c1hgN2j5Q==
X-CSE-MsgGUID: A61ydRYoQzyHSEPpMhEz3w==
X-IronPort-AV: E=McAfee;i="6600,9927,11059"; a="21320376"
X-IronPort-AV: E=Sophos;i="6.07,241,1708416000"; d="scan'208";a="21320376"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Apr 2024 03:16:25 -0700
X-CSE-ConnectionGUID: CAUzzW8PRQCDEiKmmE0AsQ==
X-CSE-MsgGUID: MrL3u6V4RXuXCeVD8RgNYA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,241,1708416000"; d="scan'208";a="31133174"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
 by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 30 Apr 2024 03:16:25 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 30 Apr 2024 03:16:24 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 30 Apr 2024 03:16:24 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 30 Apr 2024 03:16:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fwM5Qp9mmLaqEX5vlxKjDST88GWWZP964wGy4uDwKqT0S7Vbu/fjaNcGqyumfn/ER+ppdW8yhSHm0nF54zNf8629dg2IzpefE+mN5MBhijoYlOFPplIc8wvzXypii0P6YzP/dFp2jBPzRQ0hXHYpCyWL0CbE578Bbp7Er7JzmyBp+GtEeQAMHjjM6YIJV+sYvNquwfRjeQNKN5FpAK6RpmpgkhAss9OkCldc3STEf7qaHjWCquXknKUvoQI78HYwXLeujb4NYix4wx9QldHCuyYCSGZMnf0D9UwoDAbhRrcw0R/U+RzNaC4QZ7pvWOCkWuCNj1uhMJGGk3ll0k8bfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dYw1eDgMVGQ9XOWpK1egoyVRsiB5wbOfW0IbIIYBNTE=;
 b=Vfs11FyzY044f6nzF0IQXTsdsezx8vT0kAk9lKTRxaEefgE5iwhJCGQ5A+7u4unPWdYdtDxKn/DEq4FUMsMIc/anwBVP9N0+7SWTKLy/p9IvgQZqqMHcLgqw+gGQSFqDmnS/8dSQDhBGAtddgsyHmeoN7CS7ugmKRb0Q2e4HoPVVvWpx6FGUHCYMSvoDp0hB52SnO5kBLFRBVTIxGcL5iEVYgMTas/FPwStNmO7nuEypHywOPprUsyHnlRihl4p9Igwbt/2nelkT+xq02n7CqQyhXauWpBB7GqF8eT0dCFU4y26JoiDnlUKYFi8asI22tJ+QuV+o5Cy6p62cMqSq6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by DS0PR11MB8206.namprd11.prod.outlook.com (2603:10b6:8:166::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.36; Tue, 30 Apr
 2024 10:16:22 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::e4a3:76ce:879:9129]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::e4a3:76ce:879:9129%7]) with mapi id 15.20.7519.031; Tue, 30 Apr 2024
 10:16:22 +0000
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
Subject: RE: [PATCH v3 13/19] vfio: Create host IOMMU device instance
Thread-Topic: [PATCH v3 13/19] vfio: Create host IOMMU device instance
Thread-Index: AQHamgIUMuNdgn3Xz0GeMylLjIRarLGAkT4AgAACgcA=
Date: Tue, 30 Apr 2024 10:16:22 +0000
Message-ID: <SJ0PR11MB6744AA5CBB630EB00AFCC04A921A2@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20240429065046.3688701-1-zhenzhong.duan@intel.com>
 <20240429065046.3688701-14-zhenzhong.duan@intel.com>
 <0ca17106-a529-4d54-989f-9b9b47c6b8a7@redhat.com>
In-Reply-To: <0ca17106-a529-4d54-989f-9b9b47c6b8a7@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|DS0PR11MB8206:EE_
x-ms-office365-filtering-correlation-id: 3c0a1d17-d870-40cd-4727-08dc68fe95e9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230031|366007|7416005|376005|1800799015|38070700009; 
x-microsoft-antispam-message-info: =?utf-8?B?UjdHSDM0UnFwNHh2Vmw3ZUljVC9kOWV2Yy9vSUFSUDNYMk1JdGNiMjh2MlRE?=
 =?utf-8?B?RUFTaldVZkJYNHkwYnkrTzY2amJ4WnlXM295dzdLeWZ6azJjOUJrbnJCRlVK?=
 =?utf-8?B?aUNEOG9GRmNGN3B3RW5HdndWbnVFODY0QTBvRDB0a0UyamVwbG5SbjY4TGtD?=
 =?utf-8?B?NFV3b0k5SFlWanY0bjdMa1ErL1MzZ053NE5PSnViSHBucExyb082WWllUUpm?=
 =?utf-8?B?cmh3NFg1SGxmbndPMG8yMnBSbENVUmlYWmp4R1I2a2V5a2FXN0dDNEhQRUlJ?=
 =?utf-8?B?UEw4MklFS3k5M21KU3hPaXlSRmNsMmROMXhXdzdGcDhwcVcxOEt3dGdxZXZV?=
 =?utf-8?B?ZFlYOHJkSVpXWXBiNTllN2toR1pEd0Uxd29sMnUya2EzbUc5cXhQbXBkMFl1?=
 =?utf-8?B?QkF2d0dXcDZtQ1ltSVQ4QVNadE9QOFJjMVFmUmRRTEhTU1FZYmxNT0QzZkpG?=
 =?utf-8?B?T1FLcjBudmk2YURJd3BEZDlxWFdoUisyREFmMXN4MW00SUFTTkI3V1g3VHNm?=
 =?utf-8?B?QXd5WnY3VldPQ29xRjFjbmhQOEIzTU5FTHNMK2VTRU5tREJpMW5UOTkwUkQy?=
 =?utf-8?B?UHFHbFpDdXZ4cEppdmpMRjc2YVBjbzJ6UEg0bXZuaGsyWXR2d3ZrdWdJamFk?=
 =?utf-8?B?KytERGNKb1VYbWRSQzdhV1RGSlZKU1pCbTE2NlBGZnJRR2RUb3lKaUx1OWpT?=
 =?utf-8?B?ZEpBTW1yWHZHLzhYLzZHQTNhK09wZDZVbUJ6WlBUSWhmUGw4NWlzN29YRDJ3?=
 =?utf-8?B?TENyNFNYaC8vZGhWcDl4cW4rRmNhREVveHMwcXBrM0E3K292dUVHendJNW9z?=
 =?utf-8?B?MVd6KzVFNjJOU0ozWTluL1VIUkpScTFHcVlBMWxmK1lZc2xpQlhaV1owcTRo?=
 =?utf-8?B?TkplRW9qN1Fnbm1Yb2REMGxiOEpuTGZMM09VSXV4cEk2Q3lrODB5RXZuaFR1?=
 =?utf-8?B?cXUxUFVQNEtCbkt2WEFDdmd1VVQwZnZ4cFM4aVp5U0RFS0dvWGNFRzQzZmQr?=
 =?utf-8?B?TFBudVV6Ymp3S1hlZ0oxUkxPYXpxYzBzenVSeFFrcFl3d1dJZEg3ZVgzWUJQ?=
 =?utf-8?B?SEl3YkdhczF5TUJGci9IOFU3VE95dEhNckRKVWZxbUZTYjYzQVQ3RzVZUVdK?=
 =?utf-8?B?MEdKajJQRzlvMjA3Mkp0TEFlaGNvYzhYbDNVa3NNTGJVR0FIaHFzZFlzNytZ?=
 =?utf-8?B?MUVvN1BWdkp1R1VUOGM0VXhUUDVoZmpMbGs3Y3llUUZYUWhSbUNGcmNKM0VO?=
 =?utf-8?B?NHRjYWxiMFVRSHFPc28xbkptaEkyTk8xQXVlUU5STGZDNlQvR2lpQzlNK20w?=
 =?utf-8?B?bFdyV2diNk1VVFMzanRacktyV1dUUmxBaHkwL203ZHQ2MmluejlHakNzSHdL?=
 =?utf-8?B?aFJVUVVKaEtUVDlvQ3dHdFpCdFg0aVRydEtyZ1BXOHVGS3NFWGl1WDJEMHZn?=
 =?utf-8?B?REVJbFo0YmkrdmVGV0g0dFdCY3RCSHJRRVc4MGlJWWtiRTRGemVPQjUxYzY2?=
 =?utf-8?B?WERMSzJZMTJpYllVdUVZQlRiTnpqcXk1SEJhNm5zc0pPYzJ1bmx4TThvUDhD?=
 =?utf-8?B?cWNTTVZ3OHZDNWxlVlZEcWU4RTJGTlhIaEdCSzZhaWlqakpQUzl3Z3Z5NWZK?=
 =?utf-8?B?cE8yZXJRaFZ0M01mYUhFZXllR3FhNER2R1JOKzN1QXNZSjZYejJPMzBiWTRn?=
 =?utf-8?B?Y0FtbDlKdDBqODkrdEZtaTlNS1FIaEdDM2U1M1FaRmFiZEdPNnA4R3d0eTB1?=
 =?utf-8?B?S3FZVzJqNWlhMkNZelNvblpuanpNRzRwNjVsRkV4aTVrSExwSWVKdHFJMVJs?=
 =?utf-8?B?RzZPUXNjZWZGVm5UQWJ5UT09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(7416005)(376005)(1800799015)(38070700009); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZGI1MEx4VDd4WHJERzJsc2dMMVFydHlUcjhEK0VQRHp4V0FCTHpkSEd0OHpR?=
 =?utf-8?B?VTVqZGUxL1g3Zko0TDZ3aUlJbEJJc1ZEU0tuMzRFU1ZhM3NCMGlCSFdkTy8z?=
 =?utf-8?B?M256VE5tSCtNT2xhNVo0RTFiem5BWlNYN3RTRmFPTXoxaDFJZWhseUtXcndI?=
 =?utf-8?B?Z0tEZUZtR0NKNVExTDM0cldlZFl0S1hBTy8rTlR4NUd6cXNaQUFaMWJhdTE5?=
 =?utf-8?B?V05jRnhWclVFNmFNRjNrWmdibmxxZ2EzRGcrQUl5cGVvR0hENjhZU0x5bytz?=
 =?utf-8?B?K2pCaFl6K1JiUnd4Wlg4UFJOSmR0TmFEb2RHOFlrbmh0N3JMRVAvanNBNkhy?=
 =?utf-8?B?N24vRmh3TEtzWjErTTFSYnNBQ0lrVkdvUVc4RHA0YmIzS0RqN3JtbmRjVzNi?=
 =?utf-8?B?b1hrRUEzN3VYUlR5Y3EybzgyZ0sreFFaUzl5UVRsOUgyMlpmZHFMakRkWUFa?=
 =?utf-8?B?WkJpZG15YnRnWTVtRG5pSjdEKzNrT0R3NWcydVBrOWE3VnpmTGtiSEpWcEpj?=
 =?utf-8?B?dVpXTnRxQ2J1RFZCeVNVWDgvazRJQXNVQXMzMWlubmVub1ZyQVZOTHlFQkN2?=
 =?utf-8?B?ODNKWVdaQ2RVdmU4Nlp4YnBrVDFpRXRHS3J5ekFIY2taQkxJemRoVkJzUjgr?=
 =?utf-8?B?ZEFBa1c2YXY5c05LSFNNenVRL1VvNy8vVVoxNktTQ0lrYnhyVTNlay9NSVkz?=
 =?utf-8?B?aFVEYkRpcDRkNjNTYTEyZkh4RTBPZFY2UFVCS3QzelMybzVSYlpXUC9rMjZw?=
 =?utf-8?B?WDhqbWU5a21OVUlIREF4TmZLVFczdlM3UFpyL0trbVR2UUIyMDBIVTJkSW50?=
 =?utf-8?B?dXlsdzd6WE43alg0Y3hQSWtSTDM3OGoxR2YyT1RsRHlQUjNKd1ZkVEUreU9U?=
 =?utf-8?B?NUhTb0l3cTU5bG1mSUpDdlc2SXhEeXc4bHh6K0Uwa3YzYUFWcnNzd05kSnNm?=
 =?utf-8?B?c2o1WmU4RnJNNjRRdWpUWjZNMVdYMUpkSDNuaTQvUEFhYy92N3YwNFFTeFVJ?=
 =?utf-8?B?aTd4NEthSmI5UFl5ejF5V1kwcWJIUFNFNzJBUFlXdWJ5Y3hheXUxVFV0cUJ6?=
 =?utf-8?B?a01pb3lUTzdIQksxYzZDNU1MVmNhYmc4Ti85Y3IwWVY0NC82OEgvSXBIVUdJ?=
 =?utf-8?B?SThQbWZMNHoxY1Y1eitodmY0a1krMlYxaW9CRkllOG1GbGVSVzNNSTBvSTZG?=
 =?utf-8?B?ZVEya0FJVC9OOVJSaHNiaThMTmJtaFVjNmZCejZyaHNKYURiTGhBNnJHMysx?=
 =?utf-8?B?ZlcrTlZYbjcxZDNYUFFsTkdiNUszOHFZaStqVGNYd0M5YTkxSnFjMVhlbU5u?=
 =?utf-8?B?TjVENFZqVGJCSkRUV3pjbFU1YVNad2VValdqbkNyWHFvTm05cDFBQ1RGNXVi?=
 =?utf-8?B?QXZYTTdmSEpxc1ZhMVI3UkV1aytJeXA2VFo4MjBFM2F6VEVVQndibXBuQ051?=
 =?utf-8?B?SmV2Sk9HazVYUnBoOXZOOHFWTWlGczZHNHlWeDloTFZZUUVPSWVBK0JFZW8v?=
 =?utf-8?B?dzBucTBpZDhNL25kM3h2SWJmU2ZxNEI5RHJoOE9QZnNHNGRUdUJ4TDVISm56?=
 =?utf-8?B?Vit3MFRJY212SVNsV1dsZWNGc1IyT1dhZ0hWZ2NtckJEVUxGR3VrVm51bEw4?=
 =?utf-8?B?dXh5N3VFVHdCa0FLRmd1Y2wvZ1Z0dnhTVmp0eHY2c2xSTitFSC84R1ROY3J4?=
 =?utf-8?B?eEFiQVIzNzR4bXA5azZNeW8xbmNUK1BubjJWMDB4MmVXeWFobDJUeTRlU0hU?=
 =?utf-8?B?cTJ2QzZyeDlJQ2ZyWVFPQUp1Z2V4b0dXQTRMOVpHa0xiVlV6K3RNcnU1L0Zy?=
 =?utf-8?B?MFBOYktyWGZKWmtNdTFtbUtKQXZLWGN6WCs2VUR5NmNRWFNCV2Nud09RQTV4?=
 =?utf-8?B?aFRKcnlTeVhMRTVmVVVEWDg3alFpMjZScDZLOEFIRndoaXJHRmhFL3U1ZEwx?=
 =?utf-8?B?Nmc3bk9kUVdWZno0R1RyL29TajVZWkxiUEErS1FCTXgvWi8zZ1k5QnhnUzBn?=
 =?utf-8?B?blZJV0N0ZEdXT0VoNFVtRnc0Q1phSHNOSUFaekdzZ2Q0aC96K3pCNmd2OCtm?=
 =?utf-8?B?THNOZ0JTOVRHVWFKbm90cGI2NTd5YmI0d0NZN0h1YlRJZmZUc3BVSGprQVZS?=
 =?utf-8?Q?WpIuFWLDEKEIclq6tLgnEclDD?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c0a1d17-d870-40cd-4727-08dc68fe95e9
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Apr 2024 10:16:22.5806 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LucCBv7dCTLABBCfwhFtUu18QN8yVqPotXZ7kxHIrJzjtV028CmEl9SQMzB6kOyu1ZEAxMmGVw6ThX9CLaR0+QXPsZoHR5MPnXSNMXJgnkg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8206
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.13;
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
IDxjbGdAcmVkaGF0LmNvbT4NCj5TdWJqZWN0OiBSZTogW1BBVENIIHYzIDEzLzE5XSB2ZmlvOiBD
cmVhdGUgaG9zdCBJT01NVSBkZXZpY2UgaW5zdGFuY2UNCj4NCj5PbiA0LzI5LzI0IDA4OjUwLCBa
aGVuemhvbmcgRHVhbiB3cm90ZToNCj4+IENyZWF0ZSBob3N0IElPTU1VIGRldmljZSBpbnN0YW5j
ZSBpbiB2ZmlvX2F0dGFjaF9kZXZpY2UoKSBhbmQgY2FsbA0KPj4gLnJlYWxpemUoKSB0byBpbml0
aWFsaXplIGl0IGZ1cnRoZXIuDQo+Pg0KPj4gU3VnZ2VzdGVkLWJ5OiBDw6lkcmljIExlIEdvYXRl
ciA8Y2xnQHJlZGhhdC5jb20+DQo+PiBTaWduZWQtb2ZmLWJ5OiBaaGVuemhvbmcgRHVhbiA8emhl
bnpob25nLmR1YW5AaW50ZWwuY29tPg0KPj4gLS0tDQo+PiAgIGluY2x1ZGUvaHcvdmZpby92Zmlv
LWNvbW1vbi5oIHwgIDEgKw0KPj4gICBody92ZmlvL2NvbW1vbi5jICAgICAgICAgICAgICB8IDE4
ICsrKysrKysrKysrKysrKysrLQ0KPj4gICAyIGZpbGVzIGNoYW5nZWQsIDE4IGluc2VydGlvbnMo
KyksIDEgZGVsZXRpb24oLSkNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9ody92ZmlvL3Zm
aW8tY29tbW9uLmggYi9pbmNsdWRlL2h3L3ZmaW8vdmZpby0NCj5jb21tb24uaA0KPj4gaW5kZXgg
MDk0M2FkZDNiYy4uYjIwNGI5M2E1NSAxMDA2NDQNCj4+IC0tLSBhL2luY2x1ZGUvaHcvdmZpby92
ZmlvLWNvbW1vbi5oDQo+PiArKysgYi9pbmNsdWRlL2h3L3ZmaW8vdmZpby1jb21tb24uaA0KPj4g
QEAgLTEyNiw2ICsxMjYsNyBAQCB0eXBlZGVmIHN0cnVjdCBWRklPRGV2aWNlIHsNCj4+ICAgICAg
IE9uT2ZmQXV0byBwcmVfY29weV9kaXJ0eV9wYWdlX3RyYWNraW5nOw0KPj4gICAgICAgYm9vbCBk
aXJ0eV9wYWdlc19zdXBwb3J0ZWQ7DQo+PiAgICAgICBib29sIGRpcnR5X3RyYWNraW5nOw0KPj4g
KyAgICBIb3N0SU9NTVVEZXZpY2UgKmhpb2Q7DQo+PiAgICAgICBpbnQgZGV2aWQ7DQo+PiAgICAg
ICBJT01NVUZEQmFja2VuZCAqaW9tbXVmZDsNCj4+ICAgfSBWRklPRGV2aWNlOw0KPj4gZGlmZiAt
LWdpdCBhL2h3L3ZmaW8vY29tbW9uLmMgYi9ody92ZmlvL2NvbW1vbi5jDQo+PiBpbmRleCA4Zjlj
YmRjMDI2Li4wYmU4YjcwZWJkIDEwMDY0NA0KPj4gLS0tIGEvaHcvdmZpby9jb21tb24uYw0KPj4g
KysrIGIvaHcvdmZpby9jb21tb24uYw0KPj4gQEAgLTE0OTcsNiArMTQ5Nyw4IEBAIGludCB2Zmlv
X2F0dGFjaF9kZXZpY2UoY2hhciAqbmFtZSwgVkZJT0RldmljZQ0KPip2YmFzZWRldiwNCj4+ICAg
ew0KPj4gICAgICAgY29uc3QgVkZJT0lPTU1VQ2xhc3MgKm9wcyA9DQo+Pg0KPlZGSU9fSU9NTVVf
Q0xBU1Mob2JqZWN0X2NsYXNzX2J5X25hbWUoVFlQRV9WRklPX0lPTU1VX0xFR0FDWSkpOw0KPj4g
KyAgICBIb3N0SU9NTVVEZXZpY2UgKmhpb2Q7DQo+PiArICAgIGludCByZXQ7DQo+Pg0KPj4gICAg
ICAgaWYgKHZiYXNlZGV2LT5pb21tdWZkKSB7DQo+PiAgICAgICAgICAgb3BzID0NCj5WRklPX0lP
TU1VX0NMQVNTKG9iamVjdF9jbGFzc19ieV9uYW1lKFRZUEVfVkZJT19JT01NVV9JT01NVUYNCj5E
KSk7DQo+PiBAQCAtMTUwNCw3ICsxNTA2LDIwIEBAIGludCB2ZmlvX2F0dGFjaF9kZXZpY2UoY2hh
ciAqbmFtZSwNCj5WRklPRGV2aWNlICp2YmFzZWRldiwNCj4+DQo+PiAgICAgICBhc3NlcnQob3Bz
KTsNCj4+DQo+PiAtICAgIHJldHVybiBvcHMtPmF0dGFjaF9kZXZpY2UobmFtZSwgdmJhc2VkZXYs
IGFzLCBlcnJwKTsNCj4+ICsgICAgcmV0ID0gb3BzLT5hdHRhY2hfZGV2aWNlKG5hbWUsIHZiYXNl
ZGV2LCBhcywgZXJycCk7DQo+PiArICAgIGlmIChyZXQgPCAwKSB7DQo+PiArICAgICAgICByZXR1
cm4gcmV0Ow0KPg0KPg0KPmhtbSwgSSB3b25kZXIgaWYgd2Ugc2hvdWxkIGNoYW5nZSB0aGUgcmV0
dXJuIHZhbHVlIG9mIHZmaW9fYXR0YWNoX2RldmljZSgpDQo+dG8gYmUgYSBib29sLg0KDQpJIHNl
ZSwgYWxzbyBWRklPSU9NTVVDbGFzczo6IHNldHVwIGFuZCBWRklPSU9NTVVDbGFzczo6YWRkX3dp
bmRvdy4NCkkgY2FuIGFkZCBjbGVhbnVwIHBhdGNoZXMgdG8gZml4IHRoZW0gaWYgeW91IGhhdmUg
bm8gb3RoZXIgcGxhbi4NCg0KVGhhbmtzDQpaaGVuemhvbmcNCg0KPg0KPg0KPlRoYW5rcywNCj4N
Cj5DLg0KPg0KPg0KPg0KPj4gKyAgICB9DQo+PiArDQo+PiArICAgIGhpb2QgPSBIT1NUX0lPTU1V
X0RFVklDRShvYmplY3RfbmV3KG9wcy0+aGlvZF90eXBlbmFtZSkpOw0KPj4gKyAgICBpZiAoIUhP
U1RfSU9NTVVfREVWSUNFX0dFVF9DTEFTUyhoaW9kKS0+cmVhbGl6ZShoaW9kLCB2YmFzZWRldiwN
Cj5lcnJwKSkgew0KPj4gKyAgICAgICAgb2JqZWN0X3VucmVmKGhpb2QpOw0KPj4gKyAgICAgICAg
b3BzLT5kZXRhY2hfZGV2aWNlKHZiYXNlZGV2KTsNCj4+ICsgICAgICAgIHJldHVybiAtRUlOVkFM
Ow0KPj4gKyAgICB9DQo+PiArICAgIHZiYXNlZGV2LT5oaW9kID0gaGlvZDsNCj4+ICsNCj4+ICsg
ICAgcmV0dXJuIDA7DQo+PiAgIH0NCj4+DQo+PiAgIHZvaWQgdmZpb19kZXRhY2hfZGV2aWNlKFZG
SU9EZXZpY2UgKnZiYXNlZGV2KQ0KPj4gQEAgLTE1MTIsNSArMTUyNyw2IEBAIHZvaWQgdmZpb19k
ZXRhY2hfZGV2aWNlKFZGSU9EZXZpY2UgKnZiYXNlZGV2KQ0KPj4gICAgICAgaWYgKCF2YmFzZWRl
di0+YmNvbnRhaW5lcikgew0KPj4gICAgICAgICAgIHJldHVybjsNCj4+ICAgICAgIH0NCj4+ICsg
ICAgb2JqZWN0X3VucmVmKHZiYXNlZGV2LT5oaW9kKTsNCj4+ICAgICAgIHZiYXNlZGV2LT5iY29u
dGFpbmVyLT5vcHMtPmRldGFjaF9kZXZpY2UodmJhc2VkZXYpOw0KPj4gICB9DQoNCg==

