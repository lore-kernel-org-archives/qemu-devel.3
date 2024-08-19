Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99A5EC5320E
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2024 09:58:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sfz8k-00061p-IJ; Mon, 19 Aug 2024 05:57:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sfz8h-00061K-6a
 for qemu-devel@nongnu.org; Mon, 19 Aug 2024 05:57:27 -0400
Received: from mgamail.intel.com ([192.198.163.7])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sfz8e-0000zA-KL
 for qemu-devel@nongnu.org; Mon, 19 Aug 2024 05:57:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1724061444; x=1755597444;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=1jopiBW8Q/68EOdzbst7agGPROlYwmWrs82AlM7kL94=;
 b=e50A0O08izG/R8u4qYDJcxfoCRWKpGAKxBOXcabCRaEY+71XNqSCIrtw
 MSTWKwiUlM4oz4YkJGhmUSXbACSxZMZtdpJk4aR1ntgoGGudJMS8BVVcs
 q+qwE/ES7arsAjKJSEaJS5yq4DRQ99OPGIdZahE9dj44NA8nT/Bg8oNGl
 mLJELxpYZImRFn/9VZT5mK4Y3wYEAozw30gP5Xkdg0LkwCPakCWuSWeDe
 fURGM0xiDCoN3MzJCdx7UkUgz4LlmclEpxG6xJSlYK/VetimccEpWkqip
 mZv2KIpK/JVyWF1G6tZOo2jnQTu1QuHJxHDLtvczXqlrh8ZsKsXzTs5BN A==;
X-CSE-ConnectionGUID: /1se9+N6ShCLhMTJ4jTHKw==
X-CSE-MsgGUID: WwCtBgCTTtar8YxFG55Aig==
X-IronPort-AV: E=McAfee;i="6700,10204,11168"; a="47698780"
X-IronPort-AV: E=Sophos;i="6.10,158,1719903600"; d="scan'208";a="47698780"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Aug 2024 02:57:21 -0700
X-CSE-ConnectionGUID: dQwTwj/ySwmgM7ZVWAjvmQ==
X-CSE-MsgGUID: zDR9Wve5RPOmhmFJldy8yA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,158,1719903600"; d="scan'208";a="64994977"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
 by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 19 Aug 2024 02:57:21 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 19 Aug 2024 02:57:20 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 19 Aug 2024 02:57:20 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 19 Aug 2024 02:57:20 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.43) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 19 Aug 2024 02:57:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z8MTkbO6yK+CJONPJZWbbwWrb+L2Ad1XVe2lLCJdXMDCsVHdGR+ehi0cl29K7xaakypIS1X5aheXLA0j84kvmAJ7u1dZ8l08TXjQK6RTGFIkCwcrSRJlw7JkSYaJv6fidSa9G4pdVYBXMh1W+tfdcjUs2NU7/8DzQ49I5PXtmDbNjozr8CU+rvWZBQ4TW7ngldjR9WHVJQrkkO5VcvkFrnU7i2+wpzeOHu4GzdGi7JExFXzMjt6vSp9oy1l5qX6JhRkkhLJAdf/U5ePZ6SQ3weHzum8hSMf8UpN2SznifM+ncCMMukt4ociC1JHIRFDzaiN7uptTljXEffF2HiPoFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1jopiBW8Q/68EOdzbst7agGPROlYwmWrs82AlM7kL94=;
 b=mlvRgTJnKohNAXZxYOg6euEOQ/joCORfR1KlWu63i4RXv0KV5MhpWAQipm9yqMVd+D/9Cb6gpQaeMehi+O9mS5I4RIxugOyBi3wSkMRJdXd6bTymkQ6BQeOMR7WvMrE6iyxpTECk5If3Hdf02sIzVw9s33Mk5sN74s//YUhlg573bmDrfs4JYCk1QtLZ6+nbxjeEMYgNk1ioxKohq3WHaBsjsDNQXWBKAmH1Lk+dyyLjRemxl0xye6h/JvnMdCBImOckU9xCL9Hj+5ZvnsYaRyJNlBwQVn8m66G+oohmt3kLVnFZjnQd05fgtz9Fc/xTcrRgD1PZT6fZ0r17/xvFCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by CH3PR11MB7819.namprd11.prod.outlook.com (2603:10b6:610:125::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Mon, 19 Aug
 2024 09:57:18 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091%6]) with mapi id 15.20.7875.019; Mon, 19 Aug 2024
 09:57:18 +0000
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
Subject: RE: [PATCH v2 13/17] intel_iommu: piotlb invalidation should notify
 unmap
Thread-Topic: [PATCH v2 13/17] intel_iommu: piotlb invalidation should notify
 unmap
Thread-Index: AQHa5wEaw2m2jAjze0GI1QuvEcklKLIuaD+AgAAFMzA=
Date: Mon, 19 Aug 2024 09:57:18 +0000
Message-ID: <SJ0PR11MB6744CCAD824F111844C5A087928C2@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20240805062727.2307552-1-zhenzhong.duan@intel.com>
 <20240805062727.2307552-14-zhenzhong.duan@intel.com>
 <1a3d2c06-1c73-4b4d-a531-bd39007088d9@intel.com>
In-Reply-To: <1a3d2c06-1c73-4b4d-a531-bd39007088d9@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|CH3PR11MB7819:EE_
x-ms-office365-filtering-correlation-id: ff2a2cec-db64-4e76-83f9-08dcc0354faa
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|7416014|376014|366016|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?cWZjdytFcDlOekFpdU50cUpGT25vdEpPSGtmOENybjd5QzczcGZQRUowWUFt?=
 =?utf-8?B?aVZVdWZmUDJUWTFuTjhLekF3a2ZNcjdsaHJkcUJoMTZab1pvQlVwV1JGd2RZ?=
 =?utf-8?B?RnBWSTlmTU8yQXRXWXM4MzJyZGQ1MHRCU1oyTHd5czluM3dNZTdPVlpnUnly?=
 =?utf-8?B?MERia1JMSllDaVpDV0JqZnJJZktISk14TlBqUGVOVHVyd2hITi9BY29XbW1U?=
 =?utf-8?B?MVpGdVlFOHFNdmV0RS9GZVZ4QmlvaHJkV2I0TnE0MUwweW1sTzhwMHVNS3BR?=
 =?utf-8?B?a0JZQm9CeTh4SWhmR0pUNnUrdmVpOWhycVptVmVkNndaQ0hOcDM4ZEJqemhK?=
 =?utf-8?B?V3ZKMDN5aUROa3JhbEhTNEdQRjU2cVVsTUdTVExHdXVBQTJGWUxEZkpKMHdo?=
 =?utf-8?B?L3gweWpHb2J5UEZ4dEhKZXdFa29zMEVFRjFsRTRGTUc2dXpya0d0SUNqTXh4?=
 =?utf-8?B?VHBpN2RQaC9YMUU4YUZCYjZQdkpVdGJOalRTL21yOWY1c3hEMXkwYVJLSGhN?=
 =?utf-8?B?UW5CL21iTTF5SlJzdSt1Ly9WSlZPSzlLOG50YjJCZi8rdElPUmhobWwzcUFV?=
 =?utf-8?B?RXllYUczc1RJSWlpaFE0U1ZPNnNxQk03VDNqSGxjTEV5UDdHRTk0ODBjY21o?=
 =?utf-8?B?QTFvWGRNRTZKeStwb05Ick90dU5QNEZ3aDVoeTM4V2FPcGFRNHliYzAzYWpM?=
 =?utf-8?B?dnBwOFMwZ0VZMXFWZ3MwdThwQlozREIwcnlWeWZwbTJjMC9VLzladVk1N2cr?=
 =?utf-8?B?Q1g0NnM2NHJEbEtyQkxGcU9POHlrQnFSem5kVTREWWgzai9ZTTJ2VWNxRVlt?=
 =?utf-8?B?SUpRbWVCbXluZk9KdkFuVVlmaTJFK1hDYjU0UnU1aU1lR1dnSnVidFBmZzE4?=
 =?utf-8?B?djdicWxMOWxTNXdBMlFsQ3hjcm42bmplL0JFVEp1a2NNQmRuVkZzbjkrOWVz?=
 =?utf-8?B?U2VBRGJ4SVQ2QWF0bGJ1RTU2QSttUzR0TW9hdFMwbWhqY0tlMW1UM1lmak4y?=
 =?utf-8?B?dXQrZWFUZVpEZXVrT3Q4eGxmbWtlNWdHYWhxYzczeWo5YWVRQ05MekZxQlYz?=
 =?utf-8?B?VmdhRkRzb3padkxTanYzcVR5TjRCaXp0aVUzb3JHMHVVd0docm5IZkJkeFcw?=
 =?utf-8?B?dkdDRzhLUmx2N0FGL015OVRCZFpLa1hNWmR1ditmcUt2RlNCT1dPM29VMjhS?=
 =?utf-8?B?Zm53K3FjWWsrbHY4YmxZb3puT3ZVSFBLRVhkK1RRdnM2UktrV0RxOG51MHdY?=
 =?utf-8?B?dWhqcTZLekszZHNOYnVVcXY1UmdiSXdwZUQ1M3dxZU5sZDROSlZyS1QyWENO?=
 =?utf-8?B?eVBMVjJxY1dOU0hLL000TTdKWWt5ZzBvbHFXOThzcGxoV1hCMTBqd1VHZ2Nx?=
 =?utf-8?B?RHdZNHJvV0FZQi81VFdBcWp2UzFHMjFVQ1RZdnR4VVp3NnZWbjZRRFA0Z3Z1?=
 =?utf-8?B?NmpaUEN4NHR6QTlkY0tyTWhsbDVDM2ZMR2UxYU9QMlBoSzlDRW5VZWNzQXA4?=
 =?utf-8?B?N1B1R3JvRUY0Q1NSYnNEWmd5cG5pUFhnQzlaL3o0aU1qb29OU2NLNHBCRExP?=
 =?utf-8?B?cUJ5aWp2UllFMnVqWVRzVWdaUEs0bVd1OW9jVXVyWmpNeWcyV1RrQ1ZEUktt?=
 =?utf-8?B?YUJKeDFVekZKRDhtUVNxekQ5a1RaMkVPRmhaS09LN3hTRk5xUXFRNDY2ckRz?=
 =?utf-8?B?aTE2UUhwSEJuUnpNZnNITTVlb2NRRzdrYUpwYjlENHNLK3lFd0RLZUtxbG8r?=
 =?utf-8?B?cDBMaDBYb1YrZXFRQXdHam41TUtxS2hxSUw4Yjg0Ung2RzFZT3NqVUhvWHFS?=
 =?utf-8?B?ZTZSQWNkSVJQRXRVbWx5R05CaDIwUXpQQitWU2tmWXpnaGowQzFCWXpIYjA0?=
 =?utf-8?B?ZUMxbzE4RGI1NVdQNmFuQmJWSDhzbXhUOTJoSFc4ZURzZWc9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?d3QrTFJEUENoSTRlejdXdnlRaEFWQWt6QmpyTEVZSFZHKzllZjlKWEtlRGtr?=
 =?utf-8?B?Ti9KWjdUTW1UbmhxNWxCVFdvbW5HRzJkWlQ4alV2Nm5reEJqdmhGVTUwYk9s?=
 =?utf-8?B?QTRpbmhERTNCQjBTNVAvNmJ3UE41d0dISGRraHZXMHRHSmFxOURBV1VaVUpu?=
 =?utf-8?B?bEZNOVZQRjQyNlhZS0EzR2s3eVVmMlV5Z1p2M1pwd1B6ZUpzelZ3Z3FGZnZ6?=
 =?utf-8?B?OVo5VUV5ZHRybWFCKzcxTHhCclhyRDMyZVRuSnN1cXZWNGZ3Unl4c3FiZDVL?=
 =?utf-8?B?bkgyaTFBVmh5WHFTcDMvMzZ3VFpxcnV0SWd1WVVaVFlOVmJjUTZGRFpiK1BD?=
 =?utf-8?B?VWVzcHVxVFZWOWFEOUlWSElzL3c1a2tGUVNRMHZtVHg3S2JJYitPaWtSYUhO?=
 =?utf-8?B?Y0hDZW83dzJ2USt5NlFROXV3emRDZTJhY1UyejM4aXBteThKNmcxSGlRcTlq?=
 =?utf-8?B?ck43STA3MlNNeWpaVFNoVmtoV0FKSHpEU3ROSVU3Wm9iWUk2RjZUOFcwL1dq?=
 =?utf-8?B?dU96c3ZDeC9qdlY2Ynk1QytWTFVrVDgwb05xMzBmVXVLa2QvSGV6QXRzaTdE?=
 =?utf-8?B?ak4xTURrdnFSNUtIR2t1c3U3aDRYVkF6S3FscXROUTdSRUs2NjljWldURjdl?=
 =?utf-8?B?dlhUbkI5QkxMMzNRb3ZEOHlLd3NXTTFmMitwVEZjNFNzS0xCa2ptNEcwblkx?=
 =?utf-8?B?RlF6YWR3a2t2c25JZzBuN3dMczl4dzhaR3dqd1NCd3pQdnpzaWpGci9PdDh5?=
 =?utf-8?B?NWg0TzdYL2VtM0crYjJRbTc5eGh6SnhEekE1ZG5idEFPdmxYUld2MTBUdytj?=
 =?utf-8?B?V1pmV0tSV29yK1dkZGdGVXgyQmw0VjJxUHpIZU01L2VENGVUTDQ5RzJCK3pI?=
 =?utf-8?B?YUZLTXNCMEpwbXBXMktxRllXaitYOXJQdGJHTzcyWGVMazI3N3NsUjI3TmFU?=
 =?utf-8?B?OFpoSTVWcmxrWjZpck4zVE1Odkh0cThYdVZEZ3FLSjJtZWJ5T09vNjlIUXpK?=
 =?utf-8?B?RFJBYWN6ZlFnRXErVTlWZlhkRmJzTFE2eUo0OEs4K25pR0dsUEFXbENTaURG?=
 =?utf-8?B?NXZuVnN5VFM2aXB0RWJ1MXozNi9jUGZSN3g2V2N1K3VmMk02MW5tUWlzTjMr?=
 =?utf-8?B?Vm94Wndjb3NtcjR5VWQ2Sm5iRFZRSCtKd0tqWVNjdWxKWjZRUzRldDBETUlo?=
 =?utf-8?B?TEgyU2JvZ3V4SEE4OEdTNmdpazRNUkVXZzNGU3U0amlhZXRmOXR5NFprNzdN?=
 =?utf-8?B?YVVmS3JCQ3FzNTB3ekNaOTlXN0dNdWEvVHVCbDlhTWF0emxhRFVqZFZmcnRp?=
 =?utf-8?B?bHFacUtTaS9LMXRicUYrNkprYm52cnZPSU5vbWZHbWgzeTQ2ajJrbGlRZXhL?=
 =?utf-8?B?WURwL1BwSGVnUnJPcnpGazdXc2NTTTNXSndZUlZLMWl2Z2c2Wk83OU9TUWxo?=
 =?utf-8?B?aHVsNE4wQnNOTGVPWFo2K0RXcUdOWXFVblRsMjl1R1RMVXdmUmJ0cFcwUnpy?=
 =?utf-8?B?cGtCUGg2WGI1WmV1S1JvMCtSSnplUGJaNDhiSFZOMElBMjlEamxFTHpRL2NJ?=
 =?utf-8?B?MjMxTnRBakhLMm1SSzQ0M1dEVjVmeUdNWDMrY3J1UmZ2WmtMaW9mc1VzT0U4?=
 =?utf-8?B?ZkFIREVlSCs4QlBOTzZDYWpNVFlJZHlYaVZmbExTai9HMUxJbFhVbVlmQkpE?=
 =?utf-8?B?QVcrakxDd2hEbURHK2dsb0pIbDBnT0ZFN3VwdktrS0txaitCVlVCTnJFZXkr?=
 =?utf-8?B?amFtOG5HTDdHVHBrck1ZY0hGbVFZVFB3QlR6b2xqbVQrM2lIQVVRRG5NWm9Z?=
 =?utf-8?B?Y1MyMHcrek94Q2x2WDNtTDJHZkdIUjFmSko3UXVURDVvYzNhMlE3TFEweG5p?=
 =?utf-8?B?RkdvUXdoTW0xNFNHaTY4bWtvY1JEb3Z4bVRPcnNUZ2N1U2JaaDRCeUNtTDR3?=
 =?utf-8?B?bHA4MFlJRTNuT21ibGFMeWtHYWk3T29SSmJBTHExYWVUUnVVZ3R6N1FxSk1F?=
 =?utf-8?B?bG5aSytZSlRoMmFPdVVMbGFybk0yalNsR3FpUENsdmxqOTY3MTlXRDlVdzNM?=
 =?utf-8?B?clMwWmsyYWQzU0laVEtFWXZJV25CUjRkd2pVd3daUTRFOG1uYWhzckpsSURU?=
 =?utf-8?Q?EIxr4kggrhrXY1OwYwYVqCgT3?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff2a2cec-db64-4e76-83f9-08dcc0354faa
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Aug 2024 09:57:18.1959 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9lSGbaFeesqxnglNWx8XKZ3yRwNJvBD0e3exPFRRmVM48sRhngMNxpwe9MdjMhc3jhpsESJIG8kx9gy3Y0nv6JbNBLq6iI1tFz0fsBAg2ss=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7819
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.7;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
aXVAaW50ZWwuY29tPg0KPlN1YmplY3Q6IFJlOiBbUEFUQ0ggdjIgMTMvMTddIGludGVsX2lvbW11
OiBwaW90bGIgaW52YWxpZGF0aW9uIHNob3VsZA0KPm5vdGlmeSB1bm1hcA0KPg0KPk9uIDIwMjQv
OC81IDE0OjI3LCBaaGVuemhvbmcgRHVhbiB3cm90ZToNCj4+IFRoaXMgaXMgdXNlZCBieSBzb21l
IGVtdWxhdGVkIGRldmljZXMgd2hpY2ggY2FjaGVzIGFkZHJlc3MNCj4+IHRyYW5zbGF0aW9uIHJl
c3VsdC4gV2hlbiBwaW90bGIgaW52YWxpZGF0aW9uIGlzc3VlZCBpbiBndWVzdCwNCj4+IHRob3Nl
IGNhY2hlcyBzaG91bGQgYmUgcmVmcmVzaGVkLg0KPg0KPlBlcmhhcHMgSSBoYXZlIGFza2VkIGl0
IGluIHRoZSBiZWZvcmUuIDopIFRvIG1lLCBzdWNoIGVtdWxhdGVkIGRldmljZXMNCj5zaG91bGQg
aW1wbGVtZW50IGFuIEFUUy1jYXBhYmlsaXR5LiBZb3UgbWF5IG1lbnRpb24gdGhlIGRldmljZXMg
dGhhdA0KPmRvZXMgbm90IGltcGxlbWVudCBBVFMtY2FwYWJpbGl0eSwgYnV0IGNhY2hlcyB0aGUg
dHJhbnNsYXRpb24gcmVzdWx0LA0KPmFuZCBub3RlIHRoYXQgaXQgaXMgYmV0dGVyIHRvIGltcGxl
bWVudCBBVFMgY2FwIGlmIHRoZXJlIGlzIG5lZWQgdG8NCj5jYWNoZSB0aGUgdHJhbnNsYXRpb24g
cmVxdWVzdC4NCg0KT0ssIHdpbGwgZG8uIFdpbGwgYmUgbGlrZToNCg0KIkZvciBkZXZpY2UgdGhh
dCBkb2VzIG5vdCBpbXBsZW1lbnQgQVRTLWNhcGFiaWxpdHkgb3IgZGlzYWJsZSBpdA0KYnV0IHN0
aWxsIGNhY2hlcyB0aGUgdHJhbnNsYXRpb24gcmVzdWx0LCBpdCBpcyBiZXR0ZXIgdG8gaW1wbGVt
ZW50IEFUUyBjYXANCm9yIGVuYWJsZSBpdCBpZiB0aGVyZSBpcyBuZWVkIHRvIGNhY2hlIHRoZSB0
cmFuc2xhdGlvbiByZXF1ZXN0LiINCg0KVGhhbmtzDQpaaGVuemhvbmcNCg0KPg0KPj4NCj4+IFNp
Z25lZC1vZmYtYnk6IFlpIFN1biA8eWkueS5zdW5AbGludXguaW50ZWwuY29tPg0KPj4gU2lnbmVk
LW9mZi1ieTogWmhlbnpob25nIER1YW4gPHpoZW56aG9uZy5kdWFuQGludGVsLmNvbT4NCj4+IFJl
dmlld2VkLWJ5OiBDbMOpbWVudCBNYXRoaWV1LS1EcmlmPGNsZW1lbnQubWF0aGlldS0tZHJpZkBl
dmlkZW4uY29tPg0KPj4gLS0tDQo+PiAgIGh3L2kzODYvaW50ZWxfaW9tbXUuYyB8IDM1DQo+Kysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKy0NCj4+ICAgMSBmaWxlIGNoYW5nZWQsIDM0
IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvaHcvaTM4
Ni9pbnRlbF9pb21tdS5jIGIvaHcvaTM4Ni9pbnRlbF9pb21tdS5jDQo+PiBpbmRleCBmYTAwZjg1
ZmQ3Li4zMTdlNjMwZTA4IDEwMDY0NA0KPj4gLS0tIGEvaHcvaTM4Ni9pbnRlbF9pb21tdS5jDQo+
PiArKysgYi9ody9pMzg2L2ludGVsX2lvbW11LmMNCj4+IEBAIC0yOTA3LDcgKzI5MDcsNyBAQCBz
dGF0aWMgdm9pZA0KPnZ0ZF9waW90bGJfcGFzaWRfaW52YWxpZGF0ZShJbnRlbElPTU1VU3RhdGUg
KnMsDQo+PiAgICAgICAgICAgICAgICAgICBjb250aW51ZTsNCj4+ICAgICAgICAgICAgICAgfQ0K
Pj4NCj4+IC0gICAgICAgICAgICBpZiAoIXMtPnNjYWxhYmxlX21vZGVybikgew0KPj4gKyAgICAg
ICAgICAgIGlmICghcy0+c2NhbGFibGVfbW9kZXJuIHx8ICF2dGRfYXNfaGFzX21hcF9ub3RpZmll
cih2dGRfYXMpKSB7DQo+PiAgICAgICAgICAgICAgICAgICB2dGRfYWRkcmVzc19zcGFjZV9zeW5j
KHZ0ZF9hcyk7DQo+PiAgICAgICAgICAgICAgIH0NCj4+ICAgICAgICAgICB9DQo+PiBAQCAtMjkx
OSw2ICsyOTE5LDkgQEAgc3RhdGljIHZvaWQNCj52dGRfcGlvdGxiX3BhZ2VfaW52YWxpZGF0ZShJ
bnRlbElPTU1VU3RhdGUgKnMsIHVpbnQxNl90IGRvbWFpbl9pZCwNCj4+ICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgYm9vbCBpaCkNCj4+ICAgew0KPj4gICAgICAgVlRE
SU9UTEJQYWdlSW52SW5mbyBpbmZvOw0KPj4gKyAgICBWVERBZGRyZXNzU3BhY2UgKnZ0ZF9hczsN
Cj4+ICsgICAgVlREQ29udGV4dEVudHJ5IGNlOw0KPj4gKyAgICBod2FkZHIgc2l6ZSA9ICgxIDw8
IGFtKSAqIFZURF9QQUdFX1NJWkU7DQo+Pg0KPj4gICAgICAgaW5mby5kb21haW5faWQgPSBkb21h
aW5faWQ7DQo+PiAgICAgICBpbmZvLnBhc2lkID0gcGFzaWQ7DQo+PiBAQCAtMjkyOSw2ICsyOTMy
LDM2IEBAIHN0YXRpYyB2b2lkDQo+dnRkX3Bpb3RsYl9wYWdlX2ludmFsaWRhdGUoSW50ZWxJT01N
VVN0YXRlICpzLCB1aW50MTZfdCBkb21haW5faWQsDQo+PiAgICAgICBnX2hhc2hfdGFibGVfZm9y
ZWFjaF9yZW1vdmUocy0+aW90bGIsDQo+PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgdnRkX2hhc2hfcmVtb3ZlX2J5X3BhZ2VfcGlvdGxiLCAmaW5mbyk7DQo+PiAgICAgICB2dGRf
aW9tbXVfdW5sb2NrKHMpOw0KPj4gKw0KPj4gKyAgICBRTElTVF9GT1JFQUNIKHZ0ZF9hcywgJnMt
PnZ0ZF9hc193aXRoX25vdGlmaWVycywgbmV4dCkgew0KPj4gKyAgICAgICAgaWYgKCF2dGRfZGV2
X3RvX2NvbnRleHRfZW50cnkocywgcGNpX2J1c19udW0odnRkX2FzLT5idXMpLA0KPj4gKyAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdnRkX2FzLT5kZXZmbiwgJmNlKSAmJg0K
Pj4gKyAgICAgICAgICAgIGRvbWFpbl9pZCA9PSB2dGRfZ2V0X2RvbWFpbl9pZChzLCAmY2UsIHZ0
ZF9hcy0+cGFzaWQpKSB7DQo+PiArICAgICAgICAgICAgdWludDMyX3QgcmlkMnBhc2lkID0gVlRE
X0NFX0dFVF9SSUQyUEFTSUQoJmNlKTsNCj4+ICsgICAgICAgICAgICBJT01NVVRMQkV2ZW50IGV2
ZW50Ow0KPj4gKw0KPj4gKyAgICAgICAgICAgIGlmICgodnRkX2FzLT5wYXNpZCAhPSBQQ0lfTk9f
UEFTSUQgfHwgcGFzaWQgIT0gcmlkMnBhc2lkKSAmJg0KPj4gKyAgICAgICAgICAgICAgICB2dGRf
YXMtPnBhc2lkICE9IHBhc2lkKSB7DQo+PiArICAgICAgICAgICAgICAgIGNvbnRpbnVlOw0KPj4g
KyAgICAgICAgICAgIH0NCj4+ICsNCj4+ICsgICAgICAgICAgICAvKg0KPj4gKyAgICAgICAgICAg
ICAqIFBhZ2UtU2VsZWN0aXZlLXdpdGhpbi1QQVNJRCBQQVNJRC1iYXNlZC1JT1RMQiBJbnZhbGlk
YXRpb24NCj4+ICsgICAgICAgICAgICAgKiBkb2VzIG5vdCBmbHVzaCBzdGFnZS0yIGVudHJpZXMu
IFNlZSBzcGVjIHNlY3Rpb24gNi41LjIuNA0KPj4gKyAgICAgICAgICAgICAqLw0KPj4gKyAgICAg
ICAgICAgIGlmICghcy0+c2NhbGFibGVfbW9kZXJuKSB7DQo+PiArICAgICAgICAgICAgICAgIGNv
bnRpbnVlOw0KPj4gKyAgICAgICAgICAgIH0NCj4+ICsNCj4+ICsgICAgICAgICAgICBldmVudC50
eXBlID0gSU9NTVVfTk9USUZJRVJfVU5NQVA7DQo+PiArICAgICAgICAgICAgZXZlbnQuZW50cnku
dGFyZ2V0X2FzID0gJmFkZHJlc3Nfc3BhY2VfbWVtb3J5Ow0KPj4gKyAgICAgICAgICAgIGV2ZW50
LmVudHJ5LmlvdmEgPSBhZGRyOw0KPj4gKyAgICAgICAgICAgIGV2ZW50LmVudHJ5LnBlcm0gPSBJ
T01NVV9OT05FOw0KPj4gKyAgICAgICAgICAgIGV2ZW50LmVudHJ5LmFkZHJfbWFzayA9IHNpemUg
LSAxOw0KPj4gKyAgICAgICAgICAgIGV2ZW50LmVudHJ5LnRyYW5zbGF0ZWRfYWRkciA9IDA7DQo+
PiArICAgICAgICAgICAgbWVtb3J5X3JlZ2lvbl9ub3RpZnlfaW9tbXUoJnZ0ZF9hcy0+aW9tbXUs
IDAsIGV2ZW50KTsNCj4+ICsgICAgICAgIH0NCj4+ICsgICAgfQ0KPj4gICB9DQo+Pg0KPj4gICBz
dGF0aWMgYm9vbCB2dGRfcHJvY2Vzc19waW90bGJfZGVzYyhJbnRlbElPTU1VU3RhdGUgKnMsDQo+
DQo+LS0NCj5SZWdhcmRzLA0KPllpIExpdQ0K

