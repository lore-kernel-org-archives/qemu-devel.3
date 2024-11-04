Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE5E5D111A3
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 03:39:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t7nvV-0003h7-2a; Sun, 03 Nov 2024 22:38:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1t7nvS-0003gs-M1
 for qemu-devel@nongnu.org; Sun, 03 Nov 2024 22:38:46 -0500
Received: from mgamail.intel.com ([198.175.65.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1t7nvP-0005ln-Be
 for qemu-devel@nongnu.org; Sun, 03 Nov 2024 22:38:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1730691523; x=1762227523;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=JGlYQqFlD8qFwVZxdR+yj9+ooQlGPgygpXzJl1/4+Ok=;
 b=iSzusRsCVE/ba3irp/hR6r16XpgfS80IHCFrRVC39ICZzbmdGCBcrfgD
 +fZJOhwmXL1LSNFgFI5EP/zODvstvFAp+HR9DNz9+a91Jc8Q9ku/ixI+Z
 b9ugLaiE7MmT2HZ1h/KUaMe64mDjN9CGI+JMaJFmE3f3FgPjDkY3wfOWf
 FG4ddZefnwba5K04U49hacD7rrLsi4UbvgzRPr+GGi7pQWWRoP9xIfDGE
 n4ZL513Ls8ZTGsdxA4db0sn/wf/RD+8weRmG9rV0Zb2s9tj7joGsW8SM8
 rFLvl0d26GcHeZh+9NKgF5Oh8bxkapefrZbj+UjoTrunQMyKuBLJPg2AK A==;
X-CSE-ConnectionGUID: aG+NBguURMegW0LOtUSjJw==
X-CSE-MsgGUID: eysYJI/xS8C8Sssysic4AQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="47838438"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; d="scan'208";a="47838438"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Nov 2024 19:38:39 -0800
X-CSE-ConnectionGUID: BtGI7K1pTyui9QZgM/Fu3w==
X-CSE-MsgGUID: 3AFzpkwLTnub8jZ9r2/fuQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,256,1725346800"; d="scan'208";a="88345811"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
 by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 03 Nov 2024 19:38:39 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 3 Nov 2024 19:38:39 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Sun, 3 Nov 2024 19:38:39 -0800
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.40) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sun, 3 Nov 2024 19:38:38 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z0ma/jbe3qJEylBlXjrbQ4AZ8hgVNbQHNVW7jw2b3Ka8k2/C35xdy1K4wN0rru6BzxwrgFpWBrzQST3ZrsZKoyx+HqZ1kV2lEO0PDY6hIlUHBQIj2dXEr9n3ixCxHFvlRjwXXLzUZ5JYeRlMcgqdGp8O8SjpX/ezJ+FHDgupOzykEjKw3W3snPnsyA7dyUV7EgyqxaSYWqv1vTR1z4C2bnb3Nvcb5TKikgQBQ2nGV+PxN9S/oHjl4qQHsU3WPg8vvNmCnovR2OYbdmR0g9mftksjs9GDsOxjwNVfurOpjpSw0XTNLj0EvUsrHtDgMu2MpUCaD7kDtIcO2zOlALR0yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JGlYQqFlD8qFwVZxdR+yj9+ooQlGPgygpXzJl1/4+Ok=;
 b=u/UFc3KkVDcI9zWDj95lwxmgzCdNuWiH7eyONpd6w0v7MF6yXmTGNE6QPJYXO7M20qV42uxZbuPuQ/RAkVcdKNKmzgHYqua36cXe13WHUdDXxxxryer+rnbCvciAk78Bm0PLceJjvOgKKhVPhmROCYT3+BKjIwpa8WzmTy0AFgxc80OdUP6GMx8fH3/2JOLxap+TshWHIV0YW/S7/wxgccdFLkIOQb2rsU7LN8d8ezvf+E29os/7ucso6ukvoPapfb79qWByeIkSauNXKj80TU4lso924bjKsqXhP5/nkP3f8e2TkGhb1uxzTemM8HgJpiGXeuPeEUzdCcFUv5duUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by IA1PR11MB6393.namprd11.prod.outlook.com (2603:10b6:208:3ae::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.29; Mon, 4 Nov
 2024 03:38:21 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091%5]) with mapi id 15.20.8114.028; Mon, 4 Nov 2024
 03:38:20 +0000
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
Subject: RE: [PATCH v4 09/17] intel_iommu: Flush stage-1 cache in iotlb
 invalidation
Thread-Topic: [PATCH v4 09/17] intel_iommu: Flush stage-1 cache in iotlb
 invalidation
Thread-Index: AQHbExtveXFI3ote3kSoqPMS4AF/QbKmomuAgAAKkgA=
Date: Mon, 4 Nov 2024 03:38:20 +0000
Message-ID: <SJ0PR11MB674468C8BF05B3571B893E9492512@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20240930092631.2997543-1-zhenzhong.duan@intel.com>
 <20240930092631.2997543-10-zhenzhong.duan@intel.com>
 <39a88bac-ce24-49d5-a6e8-9553a48983a8@intel.com>
In-Reply-To: <39a88bac-ce24-49d5-a6e8-9553a48983a8@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|IA1PR11MB6393:EE_
x-ms-office365-filtering-correlation-id: 1777a39c-5da6-46ef-2bdd-08dcfc8220ef
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|7416014|376014|1800799024|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?SU03NGF3R0xybFRIRkdURGxnL2dOd0hkRnJaRSs3TDUxSkFNcVNaVFZ2bHVS?=
 =?utf-8?B?NTNjQ0U1YktsUCswb0RKd3QvNlc1ZWZ1MThFOE5jam5DV09QWXIxeDJYQ0gy?=
 =?utf-8?B?QmlLVUVlaDRZVTUzWjh6STlTNm50QnJpVXpuQ0dVT0JVMUZUcHNNWWhaZEcw?=
 =?utf-8?B?MWx5MUg4aWhISXZ0VUZWc1pLLzBucTJWVnd0N1lzNXpvVEMzK2FCZXNlQlNB?=
 =?utf-8?B?Y05TdUN3dGs4NWZOVHloSHFNUzhJMXRaVU5IeDJpUGcwaEp2Ry9MOUY5a2Mx?=
 =?utf-8?B?aUxJRlI5SE9lQU9tYkk0SWU1NUFxN1N6U3JJbGNUUGlHQ056SmdGbTJhSkY3?=
 =?utf-8?B?cENzaVhlUTNwclRUZFRCb2hRQXZoMWdmS2xzSWpiSnJXejBFcjlldm9pb2R0?=
 =?utf-8?B?Vk5HOHV3dERDci9DL0MweW5rTEpFYURHNVAyWjAyR1g2dkVoTDNITVJzNC93?=
 =?utf-8?B?cHNzdS84bmR6K1BlNXBpNXFPaFpOY092ZkNrVjVaWVMyVk9aZDdDL0xibWZn?=
 =?utf-8?B?YzJkZEhFcUJoaUFRdkZUWkRibTBQRjJpQWpxYnZReGUvd3hzV2xaQm5XN3Ja?=
 =?utf-8?B?T3lPeFhQRHZxWk9TbCt2akdsaEVBQTFBeC9BNWFXN0ZUQmNoSHJ4b3diTCtS?=
 =?utf-8?B?U011UHB1ZkZJNkVTa3pTbUVkMTczaklnQXR1QnVtQnhLZXZHdEtIQXVoeUFN?=
 =?utf-8?B?YkRPVEY4S2JKYmpVcFB1WE05Q0pmSWxqbGFaSlJML0pZMVFlS1ZmQklkaEQ1?=
 =?utf-8?B?Q09EdFdPTi92L2hWUGZnN2doQWs0ZlNxcUEzMkdDZm14a1VNV2V3OThSS2hu?=
 =?utf-8?B?QldCMTRLL2dvdCt3cDFnS1l5eFJXTnQxRFBxeEhLL0RIYTJBeVdUMXlySnY5?=
 =?utf-8?B?T1JOTG8wZ2hvZndUeVpTTEpIOERtS1ZSV3BrckRmdmZyQTlvRmJlZTFjdlJn?=
 =?utf-8?B?VkxXdldpK2VQVUpCdzN0Z3BsZ2NHY1FicS9ZRXJ2cXNDMDFTczBKUzB1Uk4x?=
 =?utf-8?B?QlRwUzBBaFVQR016V1IvVzRmQU5VWm9kTEtNeldYZDY3RmlwMkR1WXhCdXFi?=
 =?utf-8?B?VGR3TlJKMTdaOTJrOVozUXNRZzV2cHFYYkVRSDB5dDJWdlE4Y3JuSjVYR0VZ?=
 =?utf-8?B?S2xUalVBVmxXS20wY1Npb1lEU3Z0SVhab1hua3ZHamJ4VUZraEs3Mko0MHhs?=
 =?utf-8?B?a1hXbXErZFIzVHdOZmg3SDhDcjNPdEl6b1NsVldNKzBnYjA2c1hqdDRKeVg3?=
 =?utf-8?B?OUdFWVB2ZWRhd0VONFlDMkVqTktsL21xTi9XcXlidzVrY25hRjBzVU93Z3FC?=
 =?utf-8?B?eHZ1M3BFZ04vRkNDaWk3MDVzNGpMUHlmRyt5M0xWeHR4Tjl1WGdiL3lXQkVz?=
 =?utf-8?B?WkVSZlJ5N3llUGVmTzhjK0tLdFgzYXpYeEl0NlpXL1NNT0NsVTFyVmVNVFFi?=
 =?utf-8?B?L0YwNnYramU2S2dXYWs1aGJyWXg4alp3Ymxwcm8zUCtaeE5YcTNCQ1Fra003?=
 =?utf-8?B?aGloUHBUSk5vcDkxa091WE1nc1IvNnVTVjY5ekVKeGx3QS8xMEl4amJmL0Y4?=
 =?utf-8?B?NklZeXNFMHQvY3Q5QmpGbmdJU3UyUHhUV3BMeXJQRUNVTlBFNXRzd1ZMa1Iz?=
 =?utf-8?B?SE12eFlrNzlRZlEzSTFjc0ZQSnVObjJpTEhvVytwWVpJelJDckZpRHFDY0xl?=
 =?utf-8?B?UXk5VFVRVjh2OW9VRlorL3dQNWQ3blJoQjdWc3lyWm15RkRvNTVnNnZWd2hZ?=
 =?utf-8?B?N2dIeFQrcEZ6NCtLRlR6U0sxUUJFdlVYK2Uycm1OalFGaWFvVlVHdmlKQ0Zv?=
 =?utf-8?Q?dlJPHJZsRLR0cZkarHloCH4pGxzOLbPgnnW4g=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(376014)(1800799024)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YTh3TmFYdGhTeWw0YjF6WTF3QjVYZjBlWTZyVWFvc1VQQS9pVzhJa2JCT3Vv?=
 =?utf-8?B?V1A1LytleHdwcmFuM1RXb1IvMEVncW1yVFdRc2I4N2o5RWxKS3lSZnRIVnNY?=
 =?utf-8?B?eEpHQVdhTzd3VWFaNTJBUDVmOVIyV3dPeTVyb1d0YVpQMEdEWkdhdWk1UmZP?=
 =?utf-8?B?MzFrRHBkRWV3c2N3cWVLczJMYllWS1VYbU8rYVQzUE5aZDVVSEN4eFNpRDRY?=
 =?utf-8?B?WHhYdkhmZGRVQ0gxN0Qzd3FkN0FCajh4SlMxcCtaZEpVV2tnME1JK3lSQ255?=
 =?utf-8?B?SWhabG95VFpsZ0NXTW5KaDFxRkpzVE5KQXVweFlZNkVIMXBjRHdhRkZUTjMv?=
 =?utf-8?B?ZmJsTDdyRUdzZXE5bEl1WmtkaXNMWnVwMFFva1VxLzEzU21CS3NtYkpyc2ls?=
 =?utf-8?B?MDJvNFBXT1lQdDZoZUMyd0R1Tlh6SHgva0RSR1hJeVN0c0huZDVTbmhSUE9o?=
 =?utf-8?B?YXFCRXBwdVUvNGoxbFBCYjQyUW5uNDEwcDZhbEJFMDQ0REQvRG1seklqZTR3?=
 =?utf-8?B?eEJLZVBHYklZZysyZmtMRjVWQkNtQlIxcmpycnhwalBjUnF6VGM4bFZsZ29R?=
 =?utf-8?B?ZHpDOHFraDhtaHh6SGd3aGc0Q1BYZzV6NVpWbmNBUkVpNGFaVFErR2V2Z0xu?=
 =?utf-8?B?aWFFZWNGTTFoTWRtWHllSldPQ3NQd25IcklWNUw2azBkcXN0N2J3dDlnRHda?=
 =?utf-8?B?UXBkQnpqanBuRVc5Tk02aEtvS3h1MjFLQzhjaGtEMkZ0TkxNTHhqazRkNG4y?=
 =?utf-8?B?V0U2enJWb1VzQUFTUUdhbEVRSDVMQkdzZUpUOWtYYjhrT1c1blRYUjVvbDRi?=
 =?utf-8?B?aHFHbEpPVjBIUkdteC9yUW9ubjZER1ZqaGZGU1A0TmQ5UHJZemNZRkJDNWp3?=
 =?utf-8?B?NzgrNHY4NThTTDhkQmVkZHl1c2lJSnJRS1pTNDJoNVRPNnFNaGVIQTlBQmxi?=
 =?utf-8?B?U2xSL25OV29mMkRndVpZWStCQUV4NWl4NkRTZVNzbnR6cDJZM0dzWWtsWWhY?=
 =?utf-8?B?amphNXdvSXBJZDYvbHhBYS80NVcrbWxjdmk0SFpqU3FLYjdiQzVpMFJITmlE?=
 =?utf-8?B?MzR5N3doV0FSd3NIOUMySDNPVHdmbGJLa2R0MmYzdS9jb04wN1VlQmtqN0I5?=
 =?utf-8?B?OTdGSzVUN3NHTW82SjB5ZmU0NXM2VkI4WDVJeGdJSE9ManVidGNNNjNUSXZm?=
 =?utf-8?B?OXJaU3ExeVU3cnN0ekE2aDV1cXJTTzdFKzBSWDhudFVVazVhK2VkalhKMEZX?=
 =?utf-8?B?cHR4Z2hEc1FFS2kxLzlTWTVmUC9MKzNibmZyZGdDdmtXaExnODlJMExyWUd6?=
 =?utf-8?B?dGhKUVdVVlBOYWg2ZmRJallJZE5vWk04QkVRbnBRMmpQbHVOcFBZQ2NHcUJl?=
 =?utf-8?B?Mmk5V0VFZXp4RTBBang4Ymo4UHFsOHZUSUhHblFvS2kzT1Fqd295VTByRmZh?=
 =?utf-8?B?andMNXczc1JQVS9vZ1lOMnp5emdjTXd4eEVPRU5BZFNqb0NBVi8xdElmVHpk?=
 =?utf-8?B?bjVRb0pFZXExakZ2dEgwSnZoNWtOSCs4ZnRVT3JnKzByQW9heVdxWUxqMWpD?=
 =?utf-8?B?TXNrTWp3UFBNazhPL3BNclFlZlpLOHNtTEIra0RTUldrM0krQWcySlRVUkJm?=
 =?utf-8?B?TFZjeCtBb3JLUlFZbk5sd203V1FRMTArRlNOV0hmVUtDcjFtU3UrSHJ4UUcv?=
 =?utf-8?B?YnA0a0laeGpJdEQzYkdoMlUxNEw3ZmsraTlkaURsc3JOM2hxSE0zeG80ZWtP?=
 =?utf-8?B?L09OVnFPL0doUEpONEliM2thOHRrNXRoQ3RvTTBPd2plSGJRWVZqQVJUbENH?=
 =?utf-8?B?NExuVC9wNDRWTEdLWEFoK2UzWkRXOXhKekJjd2UvQTJWVGpQcFVIUGR2a0pG?=
 =?utf-8?B?NStDeGlBVzVSbThMNEp1Q002SDJKcFlvVlJKU3RRRWdDM0F6a2U2dVZYNE9N?=
 =?utf-8?B?SElaSFJmTGdJN2RFRjdBTi84UGVYYU4zTXdWTjRJWUdKTnJySTZ4dnNNU1pa?=
 =?utf-8?B?YlNBL3VSSm5zdGZhZFhObGczSTI0c3ZsRkEvRExTL3BNQTN0V3lEYkVRNG4z?=
 =?utf-8?B?UHBzbExOeWhIMm45V2IzOTBReC9LZ2M5a3pUeks3My9iK1FFSFR0MTc3RWJK?=
 =?utf-8?Q?r5yKdnLEwUoeNFEyWCa9N6wlH?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1777a39c-5da6-46ef-2bdd-08dcfc8220ef
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Nov 2024 03:38:20.8241 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UrEddl8dgRZbxuouEIyVE+u4g3SZFN/FvSfM//zcEr9yBdPX/Rx6kxsXd3JvDXCiACBFJf7Pj4rBx8bn6C2qumUc3n1KI/3A+JjSYFLbGGA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6393
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.10;
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
aXVAaW50ZWwuY29tPg0KPlNlbnQ6IE1vbmRheSwgTm92ZW1iZXIgNCwgMjAyNCAxMDo1MSBBTQ0K
PlN1YmplY3Q6IFJlOiBbUEFUQ0ggdjQgMDkvMTddIGludGVsX2lvbW11OiBGbHVzaCBzdGFnZS0x
IGNhY2hlIGluIGlvdGxiDQo+aW52YWxpZGF0aW9uDQo+DQo+T24gMjAyNC85LzMwIDE3OjI2LCBa
aGVuemhvbmcgRHVhbiB3cm90ZToNCj4+IEFjY29yZGluZyB0byBzcGVjLCBQYWdlLVNlbGVjdGl2
ZS13aXRoaW4tRG9tYWluIEludmFsaWRhdGlvbiAoMTFiKToNCj4+DQo+PiAxLiBJT1RMQiBlbnRy
aWVzIGNhY2hpbmcgc2Vjb25kLXN0YWdlIG1hcHBpbmdzIChQR1RUPTAxMGIpIG9yIHBhc3MtdGhy
b3VnaA0KPj4gKFBHVFQ9MTAwYikgbWFwcGluZ3MgYXNzb2NpYXRlZCB3aXRoIHRoZSBzcGVjaWZp
ZWQgZG9tYWluLWlkIGFuZCB0aGUNCj4+IGlucHV0LWFkZHJlc3MgcmFuZ2UgYXJlIGludmFsaWRh
dGVkLg0KPj4gMi4gSU9UTEIgZW50cmllcyBjYWNoaW5nIGZpcnN0LXN0YWdlIChQR1RUPTAwMWIp
IG9yIG5lc3RlZCAoUEdUVD0wMTFiKQ0KPj4gbWFwcGluZyBhc3NvY2lhdGVkIHdpdGggc3BlY2lm
aWVkIGRvbWFpbi1pZCBhcmUgaW52YWxpZGF0ZWQuDQo+Pg0KPj4gU28gcGVyIHNwZWMgZGVmaW5p
dGlvbiB0aGUgUGFnZS1TZWxlY3RpdmUtd2l0aGluLURvbWFpbiBJbnZhbGlkYXRpb24NCj4+IG5l
ZWRzIHRvIGZsdXNoIGZpcnN0IHN0YWdlIGFuZCBuZXN0ZWQgY2FjaGVkIElPVExCIGVudGllcyBh
cyB3ZWxsLg0KPj4NCj4+IFdlIGRvbid0IHN1cHBvcnQgbmVzdGVkIHlldCBhbmQgcGFzcy10aHJv
dWdoIG1hcHBpbmcgaXMgbmV2ZXIgY2FjaGVkLA0KPj4gc28gd2hhdCBpbiBpb3RsYiBjYWNoZSBh
cmUgb25seSBmaXJzdC1zdGFnZSBhbmQgc2Vjb25kLXN0YWdlIG1hcHBpbmdzLg0KPg0KPmEgc2lk
ZSBxdWVzdGlvbiwgaG93IGFib3V0IGNhY2hlIHBhZ2luZyBzdHJ1Y3R1cmU/DQoNCldlIGRvbid0
IGNhY2hlIHBhZ2luZyBzdHJ1Y3R1cmVzIGluIGN1cnJlbnQgdklPTU1VIGVtdWxhdGlvbiBjb2Rl
LA0KSSB0aG91Z2h0IHRoZSByZWFzb24gaXMgaXQncyBjaGVhcCBmb3IgdklPTU1VIHRvIGdldCBw
YWdpbmcgc3RydWN0dXJlDQpjb21wYXJlZCB0byByZWFsIElPTU1VIGh3LiBFdmVuIGlmIHdlIGNh
Y2hlIHBhZ2luZyBzdHJ1Y3R1cmUsIHdlIG5lZWQNCnRvIGNvbXBhcmUgYWRkcmVzcyB0YWcgYW5k
IHJlYWQgbWVtb3J5IHRvIGdldCByZXN1bHQsIHNlZW1zIG5vdCBtdWNoIGJlbmVmaXQuDQoNClRo
YW5rcw0KWmhlbnpob25nDQoNCj4NCj4+IEFkZCBhIHRhZyBwZ3R0IGluIFZURElPVExCRW50cnkg
dG8gbWFyayBQR1RUIHR5cGUgb2YgdGhlIG1hcHBpbmcgYW5kDQo+PiBpbnZhbGlkYXRlIGVudHJp
ZXMgYmFzZWQgb24gUEdUVCB0eXBlLg0KPj4NCj4+IFNpZ25lZC1vZmYtYnk6IFpoZW56aG9uZyBE
dWFuIDx6aGVuemhvbmcuZHVhbkBpbnRlbC5jb20+DQo+PiBSZXZpZXdlZC1ieTogQ2zDqW1lbnQg
TWF0aGlldS0tRHJpZjxjbGVtZW50Lm1hdGhpZXUtLWRyaWZAZXZpZGVuLmNvbT4NCj4+IEFja2Vk
LWJ5OiBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPg0KPj4gLS0tDQo+PiAgIGluY2x1
ZGUvaHcvaTM4Ni9pbnRlbF9pb21tdS5oIHwgIDEgKw0KPj4gICBody9pMzg2L2ludGVsX2lvbW11
LmMgICAgICAgICB8IDI3ICsrKysrKysrKysrKysrKysrKysrKy0tLS0tLQ0KPj4gICAyIGZpbGVz
IGNoYW5nZWQsIDIyIGluc2VydGlvbnMoKyksIDYgZGVsZXRpb25zKC0pDQo+DQo+YW55aG93LCB0
aGlzIHBhdGNoIGxvb2tzIGdvb2QgdG8gbWUuDQo+DQo+UmV2aWV3ZWQtYnk6IFlpIExpdSA8eWku
bC5saXVAaW50ZWwuY29tPg0KPg0KPj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvaHcvaTM4Ni9pbnRl
bF9pb21tdS5oIGIvaW5jbHVkZS9ody9pMzg2L2ludGVsX2lvbW11LmgNCj4+IGluZGV4IGZlOTA1
N2M1MGQuLmI4NDNkMDY5Y2MgMTAwNjQ0DQo+PiAtLS0gYS9pbmNsdWRlL2h3L2kzODYvaW50ZWxf
aW9tbXUuaA0KPj4gKysrIGIvaW5jbHVkZS9ody9pMzg2L2ludGVsX2lvbW11LmgNCj4+IEBAIC0x
NTUsNiArMTU1LDcgQEAgc3RydWN0IFZURElPVExCRW50cnkgew0KPj4gICAgICAgdWludDY0X3Qg
cHRlOw0KPj4gICAgICAgdWludDY0X3QgbWFzazsNCj4+ICAgICAgIHVpbnQ4X3QgYWNjZXNzX2Zs
YWdzOw0KPj4gKyAgICB1aW50OF90IHBndHQ7DQo+PiAgIH07DQo+Pg0KPj4gICAvKiBWVC1kIFNv
dXJjZS1JRCBRdWFsaWZpZXIgdHlwZXMgKi8NCj4+IGRpZmYgLS1naXQgYS9ody9pMzg2L2ludGVs
X2lvbW11LmMgYi9ody9pMzg2L2ludGVsX2lvbW11LmMNCj4+IGluZGV4IDk5YmIzZjQyZWEuLjQ2
YmRlMWFkNDAgMTAwNjQ0DQo+PiAtLS0gYS9ody9pMzg2L2ludGVsX2lvbW11LmMNCj4+ICsrKyBi
L2h3L2kzODYvaW50ZWxfaW9tbXUuYw0KPj4gQEAgLTMwNSw5ICszMDUsMjEgQEAgc3RhdGljIGdi
b29sZWFuIHZ0ZF9oYXNoX3JlbW92ZV9ieV9wYWdlKGdwb2ludGVyDQo+a2V5LCBncG9pbnRlciB2
YWx1ZSwNCj4+ICAgICAgIFZURElPVExCUGFnZUludkluZm8gKmluZm8gPSAoVlRESU9UTEJQYWdl
SW52SW5mbyAqKXVzZXJfZGF0YTsNCj4+ICAgICAgIHVpbnQ2NF90IGdmbiA9IChpbmZvLT5hZGRy
ID4+IFZURF9QQUdFX1NISUZUXzRLKSAmIGluZm8tPm1hc2s7DQo+PiAgICAgICB1aW50NjRfdCBn
Zm5fdGxiID0gKGluZm8tPmFkZHIgJiBlbnRyeS0+bWFzaykgPj4gVlREX1BBR0VfU0hJRlRfNEs7
DQo+PiAtICAgIHJldHVybiAoZW50cnktPmRvbWFpbl9pZCA9PSBpbmZvLT5kb21haW5faWQpICYm
DQo+PiAtICAgICAgICAgICAgKCgoZW50cnktPmdmbiAmIGluZm8tPm1hc2spID09IGdmbikgfHwN
Cj4+IC0gICAgICAgICAgICAgKGVudHJ5LT5nZm4gPT0gZ2ZuX3RsYikpOw0KPj4gKw0KPj4gKyAg
ICBpZiAoZW50cnktPmRvbWFpbl9pZCAhPSBpbmZvLT5kb21haW5faWQpIHsNCj4+ICsgICAgICAg
IHJldHVybiBmYWxzZTsNCj4+ICsgICAgfQ0KPj4gKw0KPj4gKyAgICAvKg0KPj4gKyAgICAgKiBB
Y2NvcmRpbmcgdG8gc3BlYywgSU9UTEIgZW50cmllcyBjYWNoaW5nIGZpcnN0LXN0YWdlIChQR1RU
PTAwMWIpIG9yDQo+PiArICAgICAqIG5lc3RlZCAoUEdUVD0wMTFiKSBtYXBwaW5nIGFzc29jaWF0
ZWQgd2l0aCBzcGVjaWZpZWQgZG9tYWluLWlkIGFyZQ0KPj4gKyAgICAgKiBpbnZhbGlkYXRlZC4g
TmVzdGVkIGlzbid0IHN1cHBvcnRlZCB5ZXQsIHNvIG9ubHkgbmVlZCB0byBjaGVjayAwMDFiLg0K
Pj4gKyAgICAgKi8NCj4+ICsgICAgaWYgKGVudHJ5LT5wZ3R0ID09IFZURF9TTV9QQVNJRF9FTlRS
WV9GTFQpIHsNCj4+ICsgICAgICAgIHJldHVybiB0cnVlOw0KPj4gKyAgICB9DQo+PiArDQo+PiAr
ICAgIHJldHVybiAoZW50cnktPmdmbiAmIGluZm8tPm1hc2spID09IGdmbiB8fCBlbnRyeS0+Z2Zu
ID09IGdmbl90bGI7DQo+PiAgIH0NCj4+DQo+PiAgIC8qIFJlc2V0IGFsbCB0aGUgZ2VuIG9mIFZU
REFkZHJlc3NTcGFjZSB0byB6ZXJvIGFuZCBzZXQgdGhlIGdlbiBvZg0KPj4gQEAgLTM4Miw3ICsz
OTQsNyBAQCBvdXQ6DQo+PiAgIHN0YXRpYyB2b2lkIHZ0ZF91cGRhdGVfaW90bGIoSW50ZWxJT01N
VVN0YXRlICpzLCB1aW50MTZfdCBzb3VyY2VfaWQsDQo+PiAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgdWludDE2X3QgZG9tYWluX2lkLCBod2FkZHIgYWRkciwgdWludDY0X3QgcHRlLA0K
Pj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHVpbnQ4X3QgYWNjZXNzX2ZsYWdzLCB1
aW50MzJfdCBsZXZlbCwNCj4+IC0gICAgICAgICAgICAgICAgICAgICAgICAgICAgIHVpbnQzMl90
IHBhc2lkKQ0KPj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdWludDMyX3QgcGFzaWQs
IHVpbnQ4X3QgcGd0dCkNCj4+ICAgew0KPj4gICAgICAgVlRESU9UTEJFbnRyeSAqZW50cnkgPSBn
X21hbGxvYyhzaXplb2YoKmVudHJ5KSk7DQo+PiAgICAgICBzdHJ1Y3QgdnRkX2lvdGxiX2tleSAq
a2V5ID0gZ19tYWxsb2Moc2l6ZW9mKCprZXkpKTsNCj4+IEBAIC00MDAsNiArNDEyLDcgQEAgc3Rh
dGljIHZvaWQgdnRkX3VwZGF0ZV9pb3RsYihJbnRlbElPTU1VU3RhdGUgKnMsDQo+dWludDE2X3Qg
c291cmNlX2lkLA0KPj4gICAgICAgZW50cnktPmFjY2Vzc19mbGFncyA9IGFjY2Vzc19mbGFnczsN
Cj4+ICAgICAgIGVudHJ5LT5tYXNrID0gdnRkX3B0X2xldmVsX3BhZ2VfbWFzayhsZXZlbCk7DQo+
PiAgICAgICBlbnRyeS0+cGFzaWQgPSBwYXNpZDsNCj4+ICsgICAgZW50cnktPnBndHQgPSBwZ3R0
Ow0KPj4NCj4+ICAgICAgIGtleS0+Z2ZuID0gZ2ZuOw0KPj4gICAgICAga2V5LT5zaWQgPSBzb3Vy
Y2VfaWQ7DQo+PiBAQCAtMjA2OSw3ICsyMDgyLDcgQEAgc3RhdGljIGJvb2wNCj52dGRfZG9faW9t
bXVfdHJhbnNsYXRlKFZUREFkZHJlc3NTcGFjZSAqdnRkX2FzLCBQQ0lCdXMgKmJ1cywNCj4+ICAg
ICAgIGJvb2wgaXNfZnBkX3NldCA9IGZhbHNlOw0KPj4gICAgICAgYm9vbCByZWFkcyA9IHRydWU7
DQo+PiAgICAgICBib29sIHdyaXRlcyA9IHRydWU7DQo+PiAtICAgIHVpbnQ4X3QgYWNjZXNzX2Zs
YWdzOw0KPj4gKyAgICB1aW50OF90IGFjY2Vzc19mbGFncywgcGd0dDsNCj4+ICAgICAgIGJvb2wg
cmlkMnBhc2lkID0gKHBhc2lkID09IFBDSV9OT19QQVNJRCkgJiYgcy0+cm9vdF9zY2FsYWJsZTsN
Cj4+ICAgICAgIFZURElPVExCRW50cnkgKmlvdGxiX2VudHJ5Ow0KPj4NCj4+IEBAIC0yMTc3LDkg
KzIxOTAsMTEgQEAgc3RhdGljIGJvb2wNCj52dGRfZG9faW9tbXVfdHJhbnNsYXRlKFZUREFkZHJl
c3NTcGFjZSAqdnRkX2FzLCBQQ0lCdXMgKmJ1cywNCj4+ICAgICAgIGlmIChzLT5zY2FsYWJsZV9t
b2Rlcm4gJiYgcy0+cm9vdF9zY2FsYWJsZSkgew0KPj4gICAgICAgICAgIHJldF9mciA9IHZ0ZF9p
b3ZhX3RvX2ZscHRlKHMsICZjZSwgYWRkciwgaXNfd3JpdGUsICZwdGUsICZsZXZlbCwNCj4+ICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAmcmVhZHMsICZ3cml0ZXMsIHMtPmF3
X2JpdHMsIHBhc2lkKTsNCj4+ICsgICAgICAgIHBndHQgPSBWVERfU01fUEFTSURfRU5UUllfRkxU
Ow0KPj4gICAgICAgfSBlbHNlIHsNCj4+ICAgICAgICAgICByZXRfZnIgPSB2dGRfaW92YV90b19z
bHB0ZShzLCAmY2UsIGFkZHIsIGlzX3dyaXRlLCAmcHRlLCAmbGV2ZWwsDQo+PiAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgJnJlYWRzLCAmd3JpdGVzLCBzLT5hd19iaXRzLCBw
YXNpZCk7DQo+PiArICAgICAgICBwZ3R0ID0gVlREX1NNX1BBU0lEX0VOVFJZX1NMVDsNCj4+ICAg
ICAgIH0NCj4+ICAgICAgIGlmIChyZXRfZnIpIHsNCj4+ICAgICAgICAgICB2dGRfcmVwb3J0X2Zh
dWx0KHMsIC1yZXRfZnIsIGlzX2ZwZF9zZXQsIHNvdXJjZV9pZCwNCj4+IEBAIC0yMTkwLDcgKzIy
MDUsNyBAQCBzdGF0aWMgYm9vbA0KPnZ0ZF9kb19pb21tdV90cmFuc2xhdGUoVlREQWRkcmVzc1Nw
YWNlICp2dGRfYXMsIFBDSUJ1cyAqYnVzLA0KPj4gICAgICAgcGFnZV9tYXNrID0gdnRkX3B0X2xl
dmVsX3BhZ2VfbWFzayhsZXZlbCk7DQo+PiAgICAgICBhY2Nlc3NfZmxhZ3MgPSBJT01NVV9BQ0NF
U1NfRkxBRyhyZWFkcywgd3JpdGVzKTsNCj4+ICAgICAgIHZ0ZF91cGRhdGVfaW90bGIocywgc291
cmNlX2lkLCB2dGRfZ2V0X2RvbWFpbl9pZChzLCAmY2UsIHBhc2lkKSwNCj4+IC0gICAgICAgICAg
ICAgICAgICAgICBhZGRyLCBwdGUsIGFjY2Vzc19mbGFncywgbGV2ZWwsIHBhc2lkKTsNCj4+ICsg
ICAgICAgICAgICAgICAgICAgICBhZGRyLCBwdGUsIGFjY2Vzc19mbGFncywgbGV2ZWwsIHBhc2lk
LCBwZ3R0KTsNCj4+ICAgb3V0Og0KPj4gICAgICAgdnRkX2lvbW11X3VubG9jayhzKTsNCj4+ICAg
ICAgIGVudHJ5LT5pb3ZhID0gYWRkciAmIHBhZ2VfbWFzazsNCj4NCj4tLQ0KPlJlZ2FyZHMsDQo+
WWkgTGl1DQo=

