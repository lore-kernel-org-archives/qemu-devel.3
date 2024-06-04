Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA3C4C25B74
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 05:49:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEN1A-0008MI-Iv; Tue, 04 Jun 2024 01:47:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sEN0S-0007Uj-V0
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 01:46:53 -0400
Received: from mgamail.intel.com ([192.198.163.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sEN0Q-0000ei-7D
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 01:46:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1717480006; x=1749016006;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=bR4/pt5ee7/fs2i0fT9etRIQaX82MHa2UPMclpdpcMc=;
 b=LeSTV8xNkdVQczYE9n+UNrGTdCl63WEZLdeA/2MF10R5mRA3zZSBR5nU
 B+dj4zZbFUJ9DvfyePRKrUmdcBaVkc4rHYZgfDbFO5kq15wEOgAPLcJvp
 lesTRr6Y2fbqMZH9ZUULN55K9tf1JC85u+7h7vOHAeRI2ebb4TSTUiJtw
 EEHhVKWINrHgsyTzRpvmS9OA5LOR0Yih07645zKrK+tKJaa4+PW2xWvJx
 QvF8RIFtNnFBHDFqt5Vp2OJN7Pd9i2drmJK96XbI14duHKHs57/7TcgBU
 tInfw7/FdXAWo7m8lhuIX/tFbaJYitzrCAr+9M497p8pETdHoOSd/IyhW Q==;
X-CSE-ConnectionGUID: 7a051CAwRw+xT64Mt2/1Fg==
X-CSE-MsgGUID: qSZrU/cEQeGx3JoWL1Ud1A==
X-IronPort-AV: E=McAfee;i="6600,9927,11092"; a="11886995"
X-IronPort-AV: E=Sophos;i="6.08,213,1712646000"; d="scan'208";a="11886995"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jun 2024 22:46:44 -0700
X-CSE-ConnectionGUID: d7QQRUn+RTCaCkjBtFkCPw==
X-CSE-MsgGUID: FASgsr6CQTWboZdf0GlQOw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,213,1712646000"; d="scan'208";a="67942931"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
 by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 03 Jun 2024 22:46:44 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 3 Jun 2024 22:46:43 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 3 Jun 2024 22:46:43 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 3 Jun 2024 22:46:43 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 3 Jun 2024 22:46:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HqmXrsoOZBcmx7oORZGJRrWohKM2ZW15XOkVn13AXA5K/v41ZcvekvFLuXWyYhDQ+ixb5o8iH4b3M6+8WeCrjpXYw+pqivU709ci1xtrM76HGltMaS9z4gF7Bg6+9UEBtFvl2dP3Cy5RSPKw4RhQDuuQBQo6eO5S+DYoX5Pzk6YvPED/bTDgU2/sUVxwNwNehftonlUTifE5JOwx7RziHP5t+WL7vfPT3FxpuDdWN2vyqjjSwUkTatr59Z3jtIwMTPTstdxAG6OqkTEMvpyDT19br/T3oqsBxDqGt77iHRgxgbT9DmHrBeYrY8vwxJL6QYdn8kihvLmRagygAEUlOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bR4/pt5ee7/fs2i0fT9etRIQaX82MHa2UPMclpdpcMc=;
 b=l9sYReaktEQY11XHepzmOfg9vdDzyFZ47y8Rl2iJrVkoaLILToDa4ZXQ86gxJym0rkcgL7Djb/TW9VWVOyjTJz995Ijt8EN57vgcI5QloHeNaUfOyjZmFswuhjwz4jJ555oagscZYBOCfBBQcWiXKnsXepY2aRcYqjeME5NLuq7S02hznA8e2OI/o6MD0xsYgWPzVLdxkkOHoyaNHNQwcNf0TGX4vYiGtDLWW9J5jJffSJK3IAeAbowZzShAP80XHIeM4a7izZ+jX5gi3gEStSgUmQhl34uBuW8e+A3+5wP394lJ+mG0b6mk2ZS5ckU0G1YS+J3F87jZNJbWELKWKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by BN9PR11MB5257.namprd11.prod.outlook.com (2603:10b6:408:132::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.25; Tue, 4 Jun
 2024 05:46:40 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091%7]) with mapi id 15.20.7633.021; Tue, 4 Jun 2024
 05:46:40 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: "eric.auger@redhat.com" <eric.auger@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>, "mst@redhat.com" <mst@redhat.com>,
 "peterx@redhat.com" <peterx@redhat.com>, "jasowang@redhat.com"
 <jasowang@redhat.com>, "jgg@nvidia.com" <jgg@nvidia.com>,
 "nicolinc@nvidia.com" <nicolinc@nvidia.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "clement.mathieu--drif@eviden.com"
 <clement.mathieu--drif@eviden.com>, "Tian, Kevin" <kevin.tian@intel.com>,
 "Liu, Yi L" <yi.l.liu@intel.com>, "Peng, Chao P" <chao.p.peng@intel.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: RE: [PATCH v6 19/19] intel_iommu: Check compatibility with host IOMMU
 capabilities
Thread-Topic: [PATCH v6 19/19] intel_iommu: Check compatibility with host
 IOMMU capabilities
Thread-Index: AQHatX1RkxOur4dgjU29eNgHXAlelrG2GEaAgADmOnA=
Date: Tue, 4 Jun 2024 05:46:40 +0000
Message-ID: <SJ0PR11MB67445D1A02E24D9AE8CE1C6992F82@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20240603061023.269738-1-zhenzhong.duan@intel.com>
 <20240603061023.269738-20-zhenzhong.duan@intel.com>
 <0d612695-09ed-4ef1-8994-4091803779fb@redhat.com>
In-Reply-To: <0d612695-09ed-4ef1-8994-4091803779fb@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|BN9PR11MB5257:EE_
x-ms-office365-filtering-correlation-id: 70993cea-6b07-49dd-a55e-08dc8459b4f7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230031|366007|376005|7416005|1800799015|38070700009; 
x-microsoft-antispam-message-info: =?utf-8?B?M2RYd0VsREs2ZkdlbUJHLzExVTNwOUVlajMxRGRiT2RzNHN3bWZzZG5xTnE1?=
 =?utf-8?B?M0xPaWlYVFhCU0ZDeUxpYlY2SnJ0NTJIbHhOOXNYdnFRQUVJM2lNSHJxUzJ6?=
 =?utf-8?B?SmNseHpHTXJTU3E1K0dMYnFmdXc0cElZL2FibGp1WkFZcXpaTmkzaXpTNFhB?=
 =?utf-8?B?empWMEZ6ZFZFZ1p4MTZXL01DTU9maHRDVGErMk1QajcyN21SMVE3RnhtRE1W?=
 =?utf-8?B?Mnp5SGM1WHJXVUxjK2NPYmc5cFBYaG5xUTFKSWpFY1owelJRbUtaQnJsWnhz?=
 =?utf-8?B?ZWl2dFE4R21YeVUzejZxeHJTTk04azNFVmNzdmo4QkxkQUgvSEpQUUlpT3g1?=
 =?utf-8?B?b0JBcnltZWM1OEhqTmRLd3ZVd1JCVlBnbmozRk1WT1JXczZHTS9KRDkxUkpP?=
 =?utf-8?B?SUNZc05xTXcydjVGSFBTeFJ2NnpQMmpmdDFkcVRpdHZ5T3JtanZMaHlYRDdi?=
 =?utf-8?B?ZzBDdXNBOSsyYlZsSGF1RWthNVBtZXlmdXQxL3dMM1hLUjdZcEhRNG9WUGdj?=
 =?utf-8?B?bDB2SzhIbnJBK1pWemdDajZOV21xclV0dGpiSHJibjZBOWtTWVRDNVZRRkZo?=
 =?utf-8?B?dUI1ditrL2Izc1dxOHVxZzhiN2hhNlI0Ri90VXRSeVZkQWMrNHMvOE9XT2o1?=
 =?utf-8?B?eDhoczR0Q1NNcE10SjdOS1cvQkRiM2M4OGJVUERqYWExUzFPSDdvSWtQR2JZ?=
 =?utf-8?B?ankvM2IrZGsvK3FrRFU3VENZdmZUcWFEOTV2NG9HcXJWdUZDT0Vob1ZWVm1j?=
 =?utf-8?B?UEZhVE90dmgyb2RXNUFBcU5KVlBEczhZSi9uUWhxOTNIZTl6d1lnN080aTVH?=
 =?utf-8?B?Y2F1by9Vb0dpOHRSL2tOMi90ZDc3NGdvaVQyaWovbzRTWVBEMU4wc0k2RFY3?=
 =?utf-8?B?SmEwVDYzblFNdnV5bGltZm9OR2MzL1lLTHppcDU2T3QxZzE0ZTR1RmhiT0NU?=
 =?utf-8?B?bVFISmorSVdpdmRoak9iWkdqeWcwVDEvWXNCaXR6SDVkOU00QWtlUlJJVlhr?=
 =?utf-8?B?T0RiNEs5QWg0bHl3NU5LZ2xXb2dMSHJQVGFRTTNHTk9yZGk0aTBQL054SUE1?=
 =?utf-8?B?SmtwbVNzbUdYYnFnRmJza3pkRXpwa05YcXBNQVFTRWNqRDlBVThJRGREM1dH?=
 =?utf-8?B?bXk4VG9hUzR1UHdKemM4NWt5ZTBzcXNNb2x4c000dFhtVzlQQXJiOHJzVjhx?=
 =?utf-8?B?aGtNcThna3QyZlZ4SG5XTDk1UElpUEtuWjUrTTJwdzNwNW9jek9pMENyck13?=
 =?utf-8?B?eHJueElXRDk2c3drMmRDbnpwdC9wNDlLU2YyS3FobGwrSzlLcFRpL05ETzQ0?=
 =?utf-8?B?NzBtWGRGbE14UUFwVlRMNWh6N09rYzBxb05QWGpHUDFoY3pHQUZNazV5aVhx?=
 =?utf-8?B?UTdmWWJiRitYY3NqR0JoY3l2MFJ4YlB2WmFnYnJkUXpiYzc2Q3hSMUVEUDJP?=
 =?utf-8?B?VDdpYlphVnZxTGUvTmVmcUxBWm56andIa0ZkbDc4RVI2VkJkU0tmMUxwTmZv?=
 =?utf-8?B?SVA5bDI5aXdUQlFPSXU5UEQyZU5uL21IWGtWUlJCNy9UUEJBYVBPb3NxY3RV?=
 =?utf-8?B?cUlrbTQ4aWZTcjhJK2MvWXNlcWtNMnRUcDhTbVpyNi80eUx1RElrK2hmeE9j?=
 =?utf-8?B?dFBpVkhkSittaVhKZThyYlFYQVZ4cXcxWTNkaW9ieWE2L0Y5QkxwMnBUL2Ur?=
 =?utf-8?B?elF4elJXMXYzN3NWazkxR3ZhUUEzdGYzY1pTN2o1OFVUMTcyNGpibzNUajhz?=
 =?utf-8?B?VzhUcUhLWlNFN1FBQjlzYUNLYSt1OGRnNTY4cFZlTy9vWmxIbXFPU0lFS3hT?=
 =?utf-8?B?eFVrZWNuRjZ1eVFySW5KQT09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(7416005)(1800799015)(38070700009); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?M0tlbHNlOXpDd1ZpZjFSdkFhUFBEZ0V4VDN0WGR3RUdPN084NUhPWUl1by8v?=
 =?utf-8?B?WlI3QmxQTTAxb3dMOG1IQlBXNW9IRXpMa1lhZWs0Y2lTS3RMbkdpZ0hNNCs2?=
 =?utf-8?B?bGc1bTY5d2RUdnlrNFkwSjRXQmY1Vzdxa0NDWjR6TGExWXVFM0pwbUVaRlUv?=
 =?utf-8?B?QW55NmlVOGQ0dEN4RWxseDdlNnh3L1BnZHhqVnJySTFUaWNLUkt2QVBveG12?=
 =?utf-8?B?Szd5aHVTaG1JSTYvZVRmM0laU011VEFsLyt1dFhmdjA3d1RvOU1jdGRlc2RE?=
 =?utf-8?B?Zm1WL2tIVE95K2xWZlNXaHJIV2tCa3lNN1hOMkJNTW9vWjF1NjhIN29RUk4z?=
 =?utf-8?B?ZGo2WHFrcFN2TGNIYytVVjNyRnp3V21ENGpFSlhNZE85ZCtrbi9ZMjZoTW0y?=
 =?utf-8?B?ZXExbElJK2YwNkVvK2U4Y3JkUVBaWDZyVUlldHJEQmZ1VEtWYnBuVjhFU2d1?=
 =?utf-8?B?VWRjQy84aVVpMmR1TTZuT3hUR2xzS2F5M1FDdktycmNjVURER3FnVnYvMDlm?=
 =?utf-8?B?VTN4RXBYRytlblNCV2VRSkFGcGIzSkdteHRDRmdDTkhLZGJFRTYwL28xZytq?=
 =?utf-8?B?Sm0yaVNUdlBackVVQU1LTDZVMTR1QjF0b0FCS1BBNWF0Wm9DelY1NDlsMmpt?=
 =?utf-8?B?ckVKSEJ6WlhvSHg3TFlkRkkycEVxZENVeUpzUldsSi8wTU5OVHJjVTlJOENx?=
 =?utf-8?B?UHk4YUFWeG1sSk9PMGZ4a0tNWmVMRmZzeDkxd0p3L2FGN1BNT3FXOUJzNXpt?=
 =?utf-8?B?Tnp0dytLUTBiamgrWm5PcDNpcHBCQUlFSllGY3FKWElOVEt1MGFPNzNGUDZm?=
 =?utf-8?B?WlNuMTYwamJPejExQlE4Mkl0YVA5UFNVUElvYWEwOWN0eGRHM2JBWjA0NUVF?=
 =?utf-8?B?TndWRHJCWXZEN3RVN2lnVkZteTM4b0owdVlTWHdtb3o2SGdML1JGSWxRc3dy?=
 =?utf-8?B?RXBDT2dTekFyUE1INjJqRHRNd0pDVEhMN2lxWGtpWXNXcHVndytuR1N3Vkc1?=
 =?utf-8?B?Q3lwaGFKWXBnZzBZeEZxdVNvNUpSYTMxTXlYMkYvZkhnRWFzcElDRURhYW9i?=
 =?utf-8?B?RkpHemcyYzJ1K05FZlovekZJd2YrdnV2Tm9yZWJ0SmpRdlNqbHROZTh6THN6?=
 =?utf-8?B?YWJIeHdwbVdVVTkraHBrWXhzWEwvNi9DeFg5Z290U3hmbkdNNU1UWW0wT2k5?=
 =?utf-8?B?bDRLNWdZR2FzK09ld09oejFjTmNmM3dUNkRVNUUyTmhpMGdFeExEZGNKRWlz?=
 =?utf-8?B?QjVQcW5Ocm1YaTRPSEwyOVJ1Tnlhb3NwUUJEYmllNzZIQm5KVnlUaldHV3Ex?=
 =?utf-8?B?dUtOYndwQUJRN21NSzNSekFwaTlaVUdqTm8rUktZUUN6YzJld0lTYmJsdTEz?=
 =?utf-8?B?YjJ2c2x2Y1MrOWswREpPOUlIM3RzTFRzNGVoaXJ4UkUvWWRCSzJVaVNFeWN5?=
 =?utf-8?B?TzFTVGMxOU8vZkdsNkJmN0x2TjVZc2J4KzhMd2NIMENnZ08weE5tUnQxRmZI?=
 =?utf-8?B?VUQvM3B0bmRZZ3FYVXRIdlNEQUJSUXlFQVdWUzVHaXpEdWU5b1EzNjc5ZDJV?=
 =?utf-8?B?NDA3b1RCcmNQZDVQeTdoTVJiSWtkNkRuaWVlWDZiODdmKzBsNXVCdCthYVA2?=
 =?utf-8?B?V05YYmY5NVRyZEs5RkxUSi9jS1pxbW02OXJIUUNEK2tUb1MvbmFvaGx5TDds?=
 =?utf-8?B?cGVPV2JYcUlVdUNXbFNia2xuSGxNTHhlQXBwRFRlZHU0YUl6VDREZ1ZOaVBt?=
 =?utf-8?B?M1hqWXk3LzFOdExNT3IxdW1pUWxaU3cxakYwcnd0ajhUYXI2VUQ5eGo5Tmpj?=
 =?utf-8?B?Q3RyUzQ2K3ZUaUZpYy9RT0RkZlQvS05ILzA3R1VTSmg5Y0xRRGkvQ01sTG0y?=
 =?utf-8?B?emFlREFRNEVoaXRYU2tyalpzbVpBYXlkVkVDQkpYR3JCQ0xMU0t5VTAwVTBU?=
 =?utf-8?B?VmVQRkFUVGdCNmN3YlJBbVFqazFJbENJYWlJTjZiTEY5RDk5dmFpZUZ3QWtX?=
 =?utf-8?B?WlZXcHpCMTM0UjhqbEZjMFB2V1RYMTdpMUNaRytTVGJkNXZzdTd5YW56Qk1N?=
 =?utf-8?B?YnVqVzU5QllrV1h6SFo3dkY2cjAxVmdhSi9aWnlKblc3d1NQYTZiYWFtNjdm?=
 =?utf-8?Q?8CnPrQKGTQHlQetFfextwY2TP?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70993cea-6b07-49dd-a55e-08dc8459b4f7
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jun 2024 05:46:40.2536 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 43Sa63P9yidcD1btw5s5+1SqBIHf2f7pUEDCchJI3vLzoBBJgvj6O36Kx8a/L61eDhT79NRilTmtD2+qqINTKqenVQTd+hvBVJ/UHT6Dbz8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5257
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.16;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IEVyaWMgQXVnZXIgPGVyaWMu
YXVnZXJAcmVkaGF0LmNvbT4NCj5TdWJqZWN0OiBSZTogW1BBVENIIHY2IDE5LzE5XSBpbnRlbF9p
b21tdTogQ2hlY2sgY29tcGF0aWJpbGl0eSB3aXRoIGhvc3QNCj5JT01NVSBjYXBhYmlsaXRpZXMN
Cj4NCj5IaSBaaGVuemhvbmcsDQo+DQo+T24gNi8zLzI0IDA4OjEwLCBaaGVuemhvbmcgRHVhbiB3
cm90ZToNCj4+IElmIGNoZWNrIGZhaWxzLCBob3N0IGRldmljZSAoZWl0aGVyIFZGSU8gb3IgVkRQ
QSBkZXZpY2UpIGlzIG5vdA0KPj4gY29tcGF0aWJsZSB3aXRoIGN1cnJlbnQgdklPTU1VIGNvbmZp
ZyBhbmQgc2hvdWxkIG5vdCBiZSBwYXNzZWQgdG8NCj4+IGd1ZXN0Lg0KPj4NCj4+IE9ubHkgYXdf
Yml0cyBpcyBjaGVja2VkIGZvciBub3csIHdlIGRvbid0IGNhcmUgb3RoZXIgY2FwYWJpbGl0aWVz
DQo+d2UgZG9uJ3QgY2FyZSBhYm91dCBvdGhlciBjYXBzDQoNCldpbGwgZG8uDQoNClRoYW5rcw0K
Wmhlbnpob25nDQoNCj4+IGJlZm9yZSBzY2FsYWJsZSBtb2Rlcm4gbW9kZSBpcyBpbnRyb2R1Y2Vk
Lg0KPj4NCj4+IFNpZ25lZC1vZmYtYnk6IFlpIExpdSA8eWkubC5saXVAaW50ZWwuY29tPg0KPj4g
U2lnbmVkLW9mZi1ieTogWmhlbnpob25nIER1YW4gPHpoZW56aG9uZy5kdWFuQGludGVsLmNvbT4N
Cj4+IC0tLQ0KPj4gIGh3L2kzODYvaW50ZWxfaW9tbXUuYyB8IDI5ICsrKysrKysrKysrKysrKysr
KysrKysrKysrKysrDQo+PiAgMSBmaWxlIGNoYW5nZWQsIDI5IGluc2VydGlvbnMoKykNCj4+DQo+
PiBkaWZmIC0tZ2l0IGEvaHcvaTM4Ni9pbnRlbF9pb21tdS5jIGIvaHcvaTM4Ni9pbnRlbF9pb21t
dS5jDQo+PiBpbmRleCA3NDdjOTg4YmM0Li5kODIwMmE3N2RkIDEwMDY0NA0KPj4gLS0tIGEvaHcv
aTM4Ni9pbnRlbF9pb21tdS5jDQo+PiArKysgYi9ody9pMzg2L2ludGVsX2lvbW11LmMNCj4+IEBA
IC0zODE5LDYgKzM4MTksMzAgQEAgVlREQWRkcmVzc1NwYWNlDQo+KnZ0ZF9maW5kX2FkZF9hcyhJ
bnRlbElPTU1VU3RhdGUgKnMsIFBDSUJ1cyAqYnVzLA0KPj4gICAgICByZXR1cm4gdnRkX2Rldl9h
czsNCj4+ICB9DQo+Pg0KPj4gK3N0YXRpYyBib29sIHZ0ZF9jaGVja19oZGV2KEludGVsSU9NTVVT
dGF0ZSAqcywgSG9zdElPTU1VRGV2aWNlDQo+Kmhpb2QsDQo+PiArICAgICAgICAgICAgICAgICAg
ICAgICAgICAgRXJyb3IgKiplcnJwKQ0KPj4gK3sNCj4+ICsgICAgSG9zdElPTU1VRGV2aWNlQ2xh
c3MgKmhpb2RjID0NCj5IT1NUX0lPTU1VX0RFVklDRV9HRVRfQ0xBU1MoaGlvZCk7DQo+PiArICAg
IGludCByZXQ7DQo+PiArDQo+PiArICAgIGlmICghaGlvZGMtPmdldF9jYXApIHsNCj4+ICsgICAg
ICAgIGVycm9yX3NldGcoZXJycCwgIi5nZXRfY2FwKCkgbm90IGltcGxlbWVudGVkIik7DQo+PiAr
ICAgICAgICByZXR1cm4gZmFsc2U7DQo+PiArICAgIH0NCj4+ICsNCj4+ICsgICAgLyogQ29tbW9u
IGNoZWNrcyAqLw0KPj4gKyAgICByZXQgPSBoaW9kYy0+Z2V0X2NhcChoaW9kLCBIT1NUX0lPTU1V
X0RFVklDRV9DQVBfQVdfQklUUywNCj5lcnJwKTsNCj4+ICsgICAgaWYgKHJldCA8IDApIHsNCj4+
ICsgICAgICAgIHJldHVybiBmYWxzZTsNCj4+ICsgICAgfQ0KPj4gKyAgICBpZiAocy0+YXdfYml0
cyA+IHJldCkgew0KPj4gKyAgICAgICAgZXJyb3Jfc2V0ZyhlcnJwLCAiYXctYml0cyAlZCA+IGhv
c3QgYXctYml0cyAlZCIsIHMtPmF3X2JpdHMsIHJldCk7DQo+PiArICAgICAgICByZXR1cm4gZmFs
c2U7DQo+PiArICAgIH0NCj4+ICsNCj4+ICsgICAgcmV0dXJuIHRydWU7DQo+PiArfQ0KPj4gKw0K
Pj4gIHN0YXRpYyBib29sIHZ0ZF9kZXZfc2V0X2lvbW11X2RldmljZShQQ0lCdXMgKmJ1cywgdm9p
ZCAqb3BhcXVlLCBpbnQNCj5kZXZmbiwNCj4+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgSG9zdElPTU1VRGV2aWNlICpoaW9kLCBFcnJvciAqKmVycnApDQo+PiAgew0KPj4g
QEAgLTM4NDIsNiArMzg2NiwxMSBAQCBzdGF0aWMgYm9vbA0KPnZ0ZF9kZXZfc2V0X2lvbW11X2Rl
dmljZShQQ0lCdXMgKmJ1cywgdm9pZCAqb3BhcXVlLCBpbnQgZGV2Zm4sDQo+PiAgICAgICAgICBy
ZXR1cm4gZmFsc2U7DQo+PiAgICAgIH0NCj4+DQo+PiArICAgIGlmICghdnRkX2NoZWNrX2hkZXYo
cywgaGlvZCwgZXJycCkpIHsNCj4+ICsgICAgICAgIHZ0ZF9pb21tdV91bmxvY2socyk7DQo+PiAr
ICAgICAgICByZXR1cm4gZmFsc2U7DQo+PiArICAgIH0NCj4+ICsNCj4+ICAgICAgdnRkX2hkZXYg
PSBnX21hbGxvYzAoc2l6ZW9mKFZUREhvc3RJT01NVURldmljZSkpOw0KPj4gICAgICB2dGRfaGRl
di0+YnVzID0gYnVzOw0KPj4gICAgICB2dGRfaGRldi0+ZGV2Zm4gPSAodWludDhfdClkZXZmbjsN
Cj5FcmljDQoNCg==

