Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A591CD11702
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2024 06:33:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t4DsO-00006a-Bo; Fri, 25 Oct 2024 02:32:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1t4DsN-00006E-5r
 for qemu-devel@nongnu.org; Fri, 25 Oct 2024 02:32:47 -0400
Received: from mgamail.intel.com ([198.175.65.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1t4DsK-0007WQ-C9
 for qemu-devel@nongnu.org; Fri, 25 Oct 2024 02:32:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1729837964; x=1761373964;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=f9jbbmrPMJp9hm9C2dTqabQfjN7dXlsBuvqfwnO5aX0=;
 b=NN/b6S8dCNKba82PNex/s+dO/VhsvX/6bPkBX36Qr2bW0L1Dh4JFQ4Mj
 dgcOS7m3Sh5G8TdplT/NMT46CbpF2NjUZGRU7nVvFo9h1BUgh4fZS92e2
 TgF/vdAueCQqq9sTfafjRivWd+Khf6HyTxighWTZY15Q295ImlWLnz5qu
 ex99yLJy9FU1ktzxx5uidpKozp481Sm0IdkwTNpl3N8662O24df5nJo4D
 E6TmFkVg88JPo5JBeDlYZ1zKWPrVpgCJOgDeZS/5ROif2fzlV/bQdNuu5
 BclPiAFEu1LVYAWutd/Bwoca5sDjtS9ySk6xv1qsi89gA0OH0zdjMcFv+ Q==;
X-CSE-ConnectionGUID: UbLJRWHaRZi0ogt30TqXuA==
X-CSE-MsgGUID: f2twBFntQOuaC07rKoio6A==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="29276331"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; d="scan'208";a="29276331"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Oct 2024 23:32:35 -0700
X-CSE-ConnectionGUID: VZbCSwIvRL6LsQGfxqjPCA==
X-CSE-MsgGUID: b4s3YRbMTzSGvzzPw4vjAQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,231,1725346800"; d="scan'208";a="118290786"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
 by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 24 Oct 2024 23:32:35 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 24 Oct 2024 23:32:34 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 24 Oct 2024 23:32:34 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.172)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 24 Oct 2024 23:32:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fsL2+RxcnWnn+Fhph8j71aW5bbb3UorofEm/gVn/fCGj2UWeewbD1zpcYOeQ9jVuxnBP5TgHeeBLTbSk8twEWhwPGRtlJlWv697GglXy71pGTprh+26hg/IGs6Mne3o/v0UeWlBMKewNaq3b8jqJNgGSBlRwm6PvvIGlIV1fXt8IJsmB+ppc7HGR9o++UKzZSkaGV0Yni+ne0OBcYrfwmoEK3oP2Cfms7xY4Zc3L2ePnki6CoPN9Y8AHEByu3yQwnxYk4Ge2XrSFcS9MzP4Yf51Po922KmSRtiIYPOdyCzk67vyJjJ+NgjhtQyKEjDe0yY/zC99JTFn1RbWE5togBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f9jbbmrPMJp9hm9C2dTqabQfjN7dXlsBuvqfwnO5aX0=;
 b=j9cX72ScOnHqhFMp2ZX8mrGumB7TyUyb4y0u7UKeQPi6oH3m6h03u4Z3v93aNsH9dg56qLSaoygiWsfdM92DDoE5KYcULFf0YKXl4sGD/uTtAv6MHJAqyGM2tIyfggfHzKK0Q1EBTPSk7+UWpUMJVInRWdZHjnp/WY1SDeGhBpzQvuV9VmoyDexJixTSrZxodUj2EC73q6JECPsLB1EySgju5T0kYYiyKi3Pqr4VkuBvDex0cI8ocuRx3u0btM8JYrMXOlKQIn/1bu4RQgNNMoA4rkqNOvD/+BhMGEq9MsgFSODRlE3KPqSZnUNWHwfC4stao8APn7cHqnwdtGfZAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by DS0PR11MB8685.namprd11.prod.outlook.com (2603:10b6:8:193::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.16; Fri, 25 Oct
 2024 06:32:26 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091%5]) with mapi id 15.20.8093.018; Fri, 25 Oct 2024
 06:32:26 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>, "eric.auger@redhat.com"
 <eric.auger@redhat.com>, "mst@redhat.com" <mst@redhat.com>,
 "peterx@redhat.com" <peterx@redhat.com>, "jasowang@redhat.com"
 <jasowang@redhat.com>, "jgg@nvidia.com" <jgg@nvidia.com>,
 "nicolinc@nvidia.com" <nicolinc@nvidia.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "clement.mathieu--drif@eviden.com"
 <clement.mathieu--drif@eviden.com>, "Tian, Kevin" <kevin.tian@intel.com>,
 "Liu, Yi L" <yi.l.liu@intel.com>, "Peng, Chao P" <chao.p.peng@intel.com>
Subject: RE: [PATCH v4 00/17] intel_iommu: Enable stage-1 translation for
 emulated device
Thread-Topic: [PATCH v4 00/17] intel_iommu: Enable stage-1 translation for
 emulated device
Thread-Index: AQHbExtJRjAdhQwjVUioPsbGu7Wv97KXFvRA
Date: Fri, 25 Oct 2024 06:32:25 +0000
Message-ID: <SJ0PR11MB674400719ACF48567C1A18FB924F2@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20240930092631.2997543-1-zhenzhong.duan@intel.com>
In-Reply-To: <20240930092631.2997543-1-zhenzhong.duan@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|DS0PR11MB8685:EE_
x-ms-office365-filtering-correlation-id: 49ccdc19-bb56-4245-46c7-08dcf4beca91
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|7416014|366016|376014|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?YWdDc1NBVjNzaVhLUHduZ1NBeUNLRnFmMHROd09jcWtLamV1TDQvb2RhT3BB?=
 =?utf-8?B?VnFOcEhjdGVmWHRvQ1NJUVNRb3NSQThiTXBBNHpmQlFzcUUwWU1IRG1NWU14?=
 =?utf-8?B?T1ZHMlh2NXBDZGlnL3ROQ2hpN1RGZVp5UUV3RjNkTXhsT28zSXg3ejZtcXl5?=
 =?utf-8?B?SklUVDBuN0pPeXAwekRadFJ6a0RGcjRkd0F4cDZyalNEeExLM01aa1R5Lys5?=
 =?utf-8?B?cEF1WlgzeHdWNWNBN2t6ZDZOVlBhV3M0bFVibjdxNGVnWTliTDZYai9EQ0p3?=
 =?utf-8?B?VzVFd2svRW5CdXZxdzgwU0JzLzRJOGxuS3ErdmczUkVuMExNZGxRR3VvL2x3?=
 =?utf-8?B?dnh1OFNvVUVYN09haXRtcGZJRUxXbEpib0Nxc0N6ZUdNOFgzb2ZxTXRaY25j?=
 =?utf-8?B?ZFJQVDg3MnVoOE90c1FhUWJ5YjcyUjRGSGNrWEFnMGtJR0N4LzJuQklHRGJz?=
 =?utf-8?B?R1E5cTZZL2NnNXZLQmx1SmEzRGJpeWVBZGJJNmgzNG5FeVVZRzJNUHB2dGF1?=
 =?utf-8?B?TlNIeTBrWFBZcG12RHN1QTJaN1cvQlIyTllLRzFTRHYvWHZ3U3o3MG43NEJu?=
 =?utf-8?B?RExKR0xtWGtiamlsc2FNdHhaRFUwMnBRRE5FcGUySHhBdmN6dzV2YlBqZjhj?=
 =?utf-8?B?eExTQmlCRWJTSTY4SmlsTzRvTmZndW9ZU05kbXlpRVlWQytjd3VFZjhZYi9C?=
 =?utf-8?B?aVNuTCsvQVl2TGVKSG1rOG44MVlFdGxpaXd6TWVGQjllWGpZbTRHTk5VcmFs?=
 =?utf-8?B?bjhDOUVqVlFvWXM1SlNlVWUyNElpaFFsTDdDYnZZRU1tWWR3N09ubllBVWoy?=
 =?utf-8?B?TXJMMlFGWjc4ZkFLQmRhTzZQcG0rRTZ5OHRKMjQ1dVpiemZmK2NwZnUxMmRn?=
 =?utf-8?B?dnFuK0Y3MW5GMDVtazlvaFZVcWozU3Z0UzNRZXhOUEtyK3ZHSzZ6cTlDOTc4?=
 =?utf-8?B?U3JqalcvckdoNkQ0QUg2N1N0azJHb0lmcDQ3QTRPcWRRYm03MmRjUm4xdTl2?=
 =?utf-8?B?SkI4TmlFNjVnSWJqK2sxVGJXTE54dkMzeU1yRmhKdTFjWnhoMGsyTTdFN3F0?=
 =?utf-8?B?K09acE9VdmxmRDgyZkVNcEthNkpvdm5CQ2JJQVBFTHdXOTYxazNzV1ZlMHor?=
 =?utf-8?B?c3hUWHF4cThhbmtxMFpZaUFhbjNKaTZ2ck0zaGtvRlA4WWdtYkQ4cDQxVTFs?=
 =?utf-8?B?WFdWS2VpVnNWa3VhUWlDd2NLOGZwVTZNWEkyNlg4ZWhUUTM2Tmc2eThQc2pn?=
 =?utf-8?B?elBNU3NSbFI2OGdaWHY2LzYxNDRoTzhFaHdUcXBSczNlbnVKOGhEcHRPZVg0?=
 =?utf-8?B?cDZXeEdGTC9ybUEyWXRFVG9KNjUwQVcxc01RT3NaOXVtc3FnWlh5NFlBQml1?=
 =?utf-8?B?dzlTT0YzVENmRzFWQXhndUZlMGhnS3gyR3lsRWFOOHhhUll3Wkk2S2tlK2VL?=
 =?utf-8?B?L1h6UDJzZUxpNWZsUkdSMTBsb1FRK3dGcmxtd0ROQTFYbVRSUmplbEJINFJu?=
 =?utf-8?B?ZC80UkRsbU1wOVJtTDhsenlUcFJzbFZwOU5JQk9YOCs0RlQ5eDlHSm5zbFBx?=
 =?utf-8?B?bUNnOWgwN2lNakM4em04Y2p3V0VYWTBOVGhnL2x3QmcwQU5VSkt3SmI3L0t1?=
 =?utf-8?B?UExCZ1dEdnlNdFB0c0ZmUmZxZGVNMW5vc0pna1cxbEs3bFM0Ymo3YU5iV0FS?=
 =?utf-8?B?UWJLQ2ZaOUZZQnI4Mk1Qd01jOWRKNlJZVVhsQXRCTUxHUmNSYS9BZHNHcFZ6?=
 =?utf-8?B?d1c2ak5sb3JrcXZOSFRGaHhNTE1aZkRPcVljYmNmMStWb2p2QmRKTXRjb0pH?=
 =?utf-8?B?Z2tGbHloVGowaFZZRlBjdz09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(366016)(376014)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?emhGRk4zdEZqekc1OEwwK29YWklGTWxIckFQdHVKbjgrUkE5MEFoSHp3ak9I?=
 =?utf-8?B?Wml1MFJXNHZBWnozbmNhZlhIcHdMTWJIOGY3TWczT1VvNS9VaUhVUnBoVERO?=
 =?utf-8?B?UVBjS3AxN2F0NU9PQXlVakhBTk5uWi9KOTFOWVZOZm4yQTdnbGZwa1lwdGZu?=
 =?utf-8?B?LzhaUU0vdlZseERQclJZMHVtRGVjWDAxcUNQdmtNWXVjbzgvQ1ZzSGZDSEZZ?=
 =?utf-8?B?bkdhaENGZ3k5a3FEMTQyQlRkMks0UFgxNmttSVpzWDE0UlpDZzR1VGkwdnBW?=
 =?utf-8?B?QmdsT0R2OG1qYy9EOWtLWkJmdnFrMjYzUGZSeHloSWlHeGsrdnZVYURmSUlX?=
 =?utf-8?B?ZlVKazR0R2dSSytROHZaUFF1RGhTRVhDYzJYajNJb1o2YUcrOXFmcGtHelc4?=
 =?utf-8?B?V3RrV1BWR21kN2d1Tkg5T2wwNTdTTERWWTZmYkU3YnFZNHpDTURGcSsveUJ1?=
 =?utf-8?B?dFhXMk90RGJROE44V0FpanMvNS9CMU5FUTh1MGJKUzhDTEZrUkdJcS9VVTg0?=
 =?utf-8?B?Z1ZTWHpnWEt1ZCtkZ1Qvdno3aTZKK2JVYmxaVnZlUUlQUFhkRjM3UEdXS1pL?=
 =?utf-8?B?ZnZnNXZjMkgwTkpBNUpFUWZBL0hSeDZVSTNoNDR0TG45aGZibUJZTWVWVkdn?=
 =?utf-8?B?QjBHREtmOG04QUxwWVVReHNCQm1Pa21wYXZ2QWEvcnJQQmlpNGNzUGtyQnNP?=
 =?utf-8?B?WTlCWG56VlJRTEg4N25VNjVwZ3FZM0RLWTcxd0pPRHdEWWNEcEpEVkxCaklL?=
 =?utf-8?B?YlpKYW1oa2Q4bW95dlJ2UGY2Q0x2cWxkaStoQ3d0bjdKbVZPeXNqMWxneVhZ?=
 =?utf-8?B?SE1uV2ttQ0UzNVl2eC9aNCtRckdDYkh6ajZlT1BBVXREbFZxb3dSbGtGbk9s?=
 =?utf-8?B?L1UxYkc0QTJxREFqOUVPd2o3d2tJU2VpaXhWK0VDWC8zdVI0ZThtNHEybzZ0?=
 =?utf-8?B?eGNGK3M1dWJCTnhXNVhacGhNV28yYnZ4MFBvU1k4czNoa25vQTVCVVRLb1JV?=
 =?utf-8?B?NklmR0h6MGhaeVRucmV0U1U5Y1NMUk0zVnozVVRzRFREUzRpSXEyTmtjV0hN?=
 =?utf-8?B?TGxENG9XRFRvYjlEZG45WE9xVVRKb1laQ3NsSnQ0WWcwcGdwR0Z3QmJjUys5?=
 =?utf-8?B?cE1BQUd5ak53N1l3bHhPeVVLNVdQdzlCOEpFY3JudE1NOVF2OGJtQlpMMmd2?=
 =?utf-8?B?bWJWV2FBcTdDTlR0b1dGeFlSVjhqeGp1UnQrNHd0MmxRcDEvRFRaRjZLUXI3?=
 =?utf-8?B?YkZpYU9xWE4wZEJ2WlBTKy9iSnlsbXdGNkdHYy9JSXdvaFJkZ2pMMlFoZFdw?=
 =?utf-8?B?dm9rZjhyRER6ejBQVk94Y20xY2J4Tzlyb3I5RURmRTEvZ05tZWRNdlZJNVZN?=
 =?utf-8?B?U0FOZHcvYUx4YXd2YlhJMHVIU3dKQ1dtOGxNa0t6RUN5SjBiTlNWeTV3Vm1n?=
 =?utf-8?B?QmNRRFFLblVwK2t6MlpocThnUjhKNllWcTRXeEtLcWtGQUFDWWY3ZmdMSTdk?=
 =?utf-8?B?ZEJ0aEtSYjNNSEJxQmF1VGZLcnNja1QxK0c4TzljTHg2WEYzWm5CbVNtV2Jk?=
 =?utf-8?B?TytzZHY4RFVQZXBQeEhEd2xFaFo2Y3hOWngwZXo5OXM0RDRkaThtSmZjd29m?=
 =?utf-8?B?MHFTVkpxektDYm9XL3dLSXZpTzkxVlMzd21mTHhZdXE0T1dVc1lHL0pJeXNw?=
 =?utf-8?B?UW9wMjE2R0JGN0IyWSs0b0VRTmNSYU1xSVVrdUtnaktaZWtHKzVqbVJEaWdT?=
 =?utf-8?B?VVNYeHJmTm9oUlRPVy8wbGZWMFRHajhmUS92eVlCZHBTSTBYQXkwN1MzdVhN?=
 =?utf-8?B?bTVxZHptRmZqc1N3aTE1WDBJdjBkY2N4ejF1TE1TT3ZvSElSUmViOHgzZjB5?=
 =?utf-8?B?SEtnbElDZXUzUjhGbXA1Tko5SFErcUVpcC9KcnJ6UnAxVExRR2NtUU02SkVa?=
 =?utf-8?B?WERHTWFsdFZrUk5IRE02OXNzcWtraDZSaEswRXcxczlpbEszYzJ5cU5lcC84?=
 =?utf-8?B?U0dLM3JjWklqaE42ZW1FWjY5SWo4UWJpMmNOMVJkN3dKM1pZaDlacDNIMGhR?=
 =?utf-8?B?WWxYdVVIdlRXKzg0a3Frc2k5TkxQcGw3SXk3UzRTUjVWZ3NZbmNxK0QzQmNG?=
 =?utf-8?Q?Ajvs5rtla0+CenuRa8Zp/ZO9Z?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49ccdc19-bb56-4245-46c7-08dcf4beca91
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Oct 2024 06:32:25.9034 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: n3fhp6b4RgQTbT7zryL4Z2ke4vlVSCjJIgO9gswhRdLDxulZTE+An552ydR7PpbbW8aL11bov6nVszpiDo7qN4mtQ2tC80t25wVkmTwd8Fo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8685
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.20;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.263,
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

SGkgQWxsLA0KDQpLaW5kbHkgcGluZywgYW55IG1vcmUgY29tbWVudHM/DQoNClRoYW5rcw0KWmhl
bnpob25nDQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IER1YW4sIFpoZW56
aG9uZyA8emhlbnpob25nLmR1YW5AaW50ZWwuY29tPg0KPlNlbnQ6IE1vbmRheSwgU2VwdGVtYmVy
IDMwLCAyMDI0IDU6MjYgUE0NCj5TdWJqZWN0OiBbUEFUQ0ggdjQgMDAvMTddIGludGVsX2lvbW11
OiBFbmFibGUgc3RhZ2UtMSB0cmFuc2xhdGlvbiBmb3IgZW11bGF0ZWQNCj5kZXZpY2UNCj4NCj5I
aSwNCj4NCj5QZXIgSmFzb24gV2FuZydzIHN1Z2dlc3Rpb24sIGlvbW11ZmQgbmVzdGluZyBzZXJp
ZXNbMV0gaXMgc3BsaXQgaW50bw0KPiJFbmFibGUgc3RhZ2UtMSB0cmFuc2xhdGlvbiBmb3IgZW11
bGF0ZWQgZGV2aWNlIiBzZXJpZXMgYW5kDQo+IkVuYWJsZSBzdGFnZS0xIHRyYW5zbGF0aW9uIGZv
ciBwYXNzdGhyb3VnaCBkZXZpY2UiIHNlcmllcy4NCj4NCj5UaGlzIHNlcmllcyBlbmFibGVzIHN0
YWdlLTEgdHJhbnNsYXRpb24gc3VwcG9ydCBmb3IgZW11bGF0ZWQgZGV2aWNlDQo+aW4gaW50ZWwg
aW9tbXUgd2hpY2ggd2UgY2FsbGVkICJtb2Rlcm4iIG1vZGUuDQo+DQo+UEFUQ0gxLTU6ICBTb21l
IHByZXBhcmluZyB3b3JrIGJlZm9yZSBzdXBwb3J0IHN0YWdlLTEgdHJhbnNsYXRpb24NCj5QQVRD
SDYtODogIEltcGxlbWVudCBzdGFnZS0xIHRyYW5zbGF0aW9uIGZvciBlbXVsYXRlZCBkZXZpY2UN
Cj5QQVRDSDktMTM6IEVtdWxhdGUgaW90bGIgaW52YWxpZGF0aW9uIG9mIHN0YWdlLTEgbWFwcGlu
Zw0KPlBBVENIMTQ6ICAgU2V0IGRlZmF1bHQgYXdfYml0cyB0byA0OCBpbiBzY2FsYWJsZSBtb2Ry
ZW4gbW9kZQ0KPlBBVENIMTUtMTY6RXhwb3NlIHNjYWxhYmxlIG1vZGVybiBtb2RlICJ4LWZscyIg
YW5kICJmczFncCIgdG8gY21kbGluZQ0KPlBBVENIMTc6ICAgQWRkIHF0ZXN0DQo+DQo+Tm90ZSBp
biBzcGVjIHJldmlzaW9uIDMuNCwgaXQgcmVuYW1lcyAiRmlyc3QtbGV2ZWwiIHRvICJGaXJzdC1z
dGFnZSIsDQo+IlNlY29uZC1sZXZlbCIgdG8gIlNlY29uZC1zdGFnZSIuIEJ1dCB0aGUgc2NhbGFi
bGUgbW9kZSB3YXMgYWRkZWQNCj5iZWZvcmUgdGhhdCBjaGFuZ2UuIFNvIHdlIGtlZXAgb2xkIGZh
dm9yIHVzaW5nIEZpcnN0LWxldmVsL2ZsL1NlY29uZC1sZXZlbC9zbA0KPmluIGNvZGUgYnV0IGNo
YW5nZSB0byB1c2Ugc3RhZ2UtMS9zdGFnZS0yIGluIGNvbW1pdCBsb2cuDQo+QnV0IGtlZXAgaW4g
bWluZCBGaXJzdC1sZXZlbC9mbC9zdGFnZS0xIGFsbCBoYXZlIHNhbWUgbWVhbmluZywNCj5zYW1l
IGZvciBTZWNvbmQtbGV2ZWwvc2wvc3RhZ2UtMi4NCj4NCj5RZW11IGNvZGUgY2FuIGJlIGZvdW5k
IGF0IFsyXQ0KPlRoZSB3aG9sZSBuZXN0aW5nIHNlcmllcyBjYW4gYmUgZm91bmQgYXQgWzNdDQo+
DQo+WzFdIGh0dHBzOi8vbGlzdHMuZ251Lm9yZy9hcmNoaXZlL2h0bWwvcWVtdS1kZXZlbC8yMDI0
LTAxL21zZzAyNzQwLmh0bWwNCj5bMl0NCj5odHRwczovL2dpdGh1Yi5jb20veWlsaXUxNzY1L3Fl
bXUvdHJlZS96aGVuemhvbmcvaW9tbXVmZF9zdGFnZTFfZW11X3Y0DQo+WzNdIGh0dHBzOi8vZ2l0
aHViLmNvbS95aWxpdTE3NjUvcWVtdS90cmVlL3poZW56aG9uZy9pb21tdWZkX25lc3RpbmdfcmZj
djINCj4NCj5UaGFua3MNCj5aaGVuemhvbmcNCj4NCj5DaGFuZ2Vsb2c6DQo+djQ6DQo+LSBzL1Nj
YWxhYmxlIGxlZ2FjeS9TY2FsYWJsZSBpbiBsb2dnaW5nIChDbGVtZW50KQ0KPi0gdGVzdCB0aGUg
bW9kZSBmaXJzdCB0byBtYWtlIHRoZSBpbnRlbnRpb24gY2xlYXJlciAoQ2xlbWVudCkNCj4tIHMv
eC1jYXAtZnMxZ3AvZnMxZ3AgYW5kIHMvVlREX0ZMX1JXX01BU0svVlREX0ZMX1JXIChKYXNvbikN
Cj4tIGludHJvZHVjZSB4LWZscyBpbnN0ZWFkIG9mIHVwZGF0aW5nIHgtc2NhbGFibGUtbW9kZSAo
SmFzb24pDQo+LSBSZWZpbmUgY29tbWVudCBsb2cgaW4gcGF0Y2g0IChqYXNvbikNCj4tIHMvdGFu
c2x0aW9uL3RyYW5zbGF0aW9uLyBhbmQgcy9WVERfU1BURV9SU1ZEX0xFTi9WVERfRlBURV9SU1ZE
X0xFTi8NCj4oTGl1eWkpDQo+LSBVcGRhdGUgdGhlIG9yZGVyIGFuZCBuYW1pbmcgb2YgVlREX0ZQ
VEVfUEFHRV8qIChMaXV5aSkNCj4NCj52MzoNCj4tIGRyb3AgdW5uZWNlc3NhcnkgIShzLT5lY2Fw
ICYgVlREX0VDQVBfU01UUykgKENsZW1lbnQpDQo+LSBzaW1wbGlmeSBjYWxjdWxhdGlvbiBvZiBy
ZXR1cm4gdmFsdWUgZm9yIHZ0ZF9pb3ZhX2ZsX2NoZWNrX2Nhbm9uaWNhbCgpIChMaXV5aSkNCj4t
IG1ha2UgQS9EIGJpdCBzZXR0aW5nIGF0b21pYyAoTGl1eWkpDQo+LSByZWZpbmUgZXJyb3IgbXNn
IChDbGVtZW50LCBMaXV5aSkNCj4NCj52MjoNCj4tIGNoZWNrIGVjYXAvY2FwIGJpdHMgaW5zdGVh
ZCBvZiBzLT5zY2FsYWJsZV9tb2Rlcm4gaW4gdnRkX3BlX3R5cGVfY2hlY2soKQ0KPihDbGVtZW50
KQ0KPi0gZGVjbGFyZSBWVERfRUNBUF9GTFRTL0ZTMUdQIGFmdGVyIHRoZSBmZWF0dXJlIGlzIGlt
cGxlbWVudGVkIChDbGVtZW50KQ0KPi0gZGVmaW5lIFZURF9JTlZfREVTQ19QSU9UTEJfRyAoQ2xl
bWVudCkNCj4tIG1ha2UgZXJyb3IgbXNnIGNvbnNpc3RlbnQgaW4gdnRkX3Byb2Nlc3NfcGlvdGxi
X2Rlc2MoKSAoQ2xlbWVudCkNCj4tIHJlZmluZSBjb21taXQgbG9nIGluIHBhdGNoMTYgKENsZW1l
bnQpDQo+LSBhZGQgVlREX0VDQVBfSVIgdG8gRUNBUF9NT0RFUk5fRklYRUQxIChDbGVtZW50KQ0K
Pi0gYWRkIGEga25vYiB4LWNhcC1mczFncCB0byBjb250cm9sIHN0YWdlLTEgMUcgcGFnaW5nIGNh
cGFiaWxpdHkNCj4tIGNvbGxlY3QgQ2xlbWVudCdzIFItQg0KPg0KPnYxOg0KPi0gZGVmaW5lIFZU
RF9IT1NUX0FXX0FVVE8gKENsZW1lbnQpDQo+LSBwYXNzaW5nIHBndHQgYXMgYSBwYXJhbWV0ZXIg
dG8gdnRkX3VwZGF0ZV9pb3RsYiAoQ2xlbWVudCkNCj4tIHByZWZpeCBzbF8vZmxfIHRvIHNlY29u
ZC9maXJzdCBsZXZlbCBzcGVjaWZpYyBmdW5jdGlvbnMgKENsZW1lbnQpDQo+LSBwaWNrIHJlc2Vy
dmVkIGJpdCBjaGVjayBmcm9tIENsZW1lbnQsIGFkZCBoaXMgQ28tZGV2ZWxvcGVkLWJ5DQo+LSBV
cGRhdGUgdGVzdCB3aXRob3V0IHVzaW5nIGxpYnF0ZXN0LXNpbmdsZS5oIChUaG9tYXMpDQo+DQo+
cmZjdjI6DQo+LSBzcGxpdCBmcm9tIG5lc3Rpbmcgc2VyaWVzIChKYXNvbikNCj4tIG1lcmdlZCBz
b21lIGNvbW1pdHMgZnJvbSBDbGVtZW50DQo+LSBhZGQgcXRlc3QgKGphc29uKQ0KPg0KPg0KPkNs
w6ltZW50IE1hdGhpZXUtLURyaWYgKDQpOg0KPiAgaW50ZWxfaW9tbXU6IENoZWNrIGlmIHRoZSBp
bnB1dCBhZGRyZXNzIGlzIGNhbm9uaWNhbA0KPiAgaW50ZWxfaW9tbXU6IFNldCBhY2Nlc3NlZCBh
bmQgZGlydHkgYml0cyBkdXJpbmcgZmlyc3Qgc3RhZ2UNCj4gICAgdHJhbnNsYXRpb24NCj4gIGlu
dGVsX2lvbW11OiBBZGQgYW4gaW50ZXJuYWwgQVBJIHRvIGZpbmQgYW4gYWRkcmVzcyBzcGFjZSB3
aXRoIFBBU0lEDQo+ICBpbnRlbF9pb21tdTogQWRkIHN1cHBvcnQgZm9yIFBBU0lELWJhc2VkIGRl
dmljZSBJT1RMQiBpbnZhbGlkYXRpb24NCj4NCj5ZaSBMaXUgKDIpOg0KPiAgaW50ZWxfaW9tbXU6
IFJlbmFtZSBzbHB0ZSB0byBwdGUNCj4gIGludGVsX2lvbW11OiBJbXBsZW1lbnQgc3RhZ2UtMSB0
cmFuc2xhdGlvbg0KPg0KPll1IFpoYW5nICgxKToNCj4gIGludGVsX2lvbW11OiBVc2UgdGhlIGxh
dGVzdCBmYXVsdCByZWFzb25zIGRlZmluZWQgYnkgc3BlYw0KPg0KPlpoZW56aG9uZyBEdWFuICgx
MCk6DQo+ICBpbnRlbF9pb21tdTogTWFrZSBwYXNpZCBlbnRyeSB0eXBlIGNoZWNrIGFjY3VyYXRl
DQo+ICBpbnRlbF9pb21tdTogQWRkIGEgcGxhY2Vob2xkZXIgdmFyaWFibGUgZm9yIHNjYWxhYmxl
IG1vZGVybiBtb2RlDQo+ICBpbnRlbF9pb21tdTogRmx1c2ggc3RhZ2UtMiBjYWNoZSBpbiBQQVNJ
RC1zZWxlY3RpdmUgUEFTSUQtYmFzZWQgaW90bGINCj4gICAgaW52YWxpZGF0aW9uDQo+ICBpbnRl
bF9pb21tdTogRmx1c2ggc3RhZ2UtMSBjYWNoZSBpbiBpb3RsYiBpbnZhbGlkYXRpb24NCj4gIGlu
dGVsX2lvbW11OiBQcm9jZXNzIFBBU0lELWJhc2VkIGlvdGxiIGludmFsaWRhdGlvbg0KPiAgaW50
ZWxfaW9tbXU6IHBpb3RsYiBpbnZhbGlkYXRpb24gc2hvdWxkIG5vdGlmeSB1bm1hcA0KPiAgaW50
ZWxfaW9tbXU6IFNldCBkZWZhdWx0IGF3X2JpdHMgdG8gNDggaW4gc2NhbGFibGUgbW9kZXJuIG1v
ZGUNCj4gIGludGVsX2lvbW11OiBJbnRyb2R1Y2UgYSBwcm9wZXJ0eSB4LWZscyBmb3Igc2NhbGFi
bGUgbW9kZXJuIG1vZGUNCj4gIGludGVsX2lvbW11OiBJbnRyb2R1Y2UgYSBwcm9wZXJ0eSB0byBj
b250cm9sIEZTMUdQIGNhcCBiaXQgc2V0dGluZw0KPiAgdGVzdHMvcXRlc3Q6IEFkZCBpbnRlbC1p
b21tdSB0ZXN0DQo+DQo+IE1BSU5UQUlORVJTICAgICAgICAgICAgICAgICAgICB8ICAgMSArDQo+
IGh3L2kzODYvaW50ZWxfaW9tbXVfaW50ZXJuYWwuaCB8ICA5MiArKysrLQ0KPiBpbmNsdWRlL2h3
L2kzODYvaW50ZWxfaW9tbXUuaCAgfCAgIDggKy0NCj4gaHcvaTM4Ni9pbnRlbF9pb21tdS5jICAg
ICAgICAgIHwgNjgxICsrKysrKysrKysrKysrKysrKysrKysrKysrKy0tLS0tLQ0KPiB0ZXN0cy9x
dGVzdC9pbnRlbC1pb21tdS10ZXN0LmMgfCAgNjUgKysrKw0KPiB0ZXN0cy9xdGVzdC9tZXNvbi5i
dWlsZCAgICAgICAgfCAgIDEgKw0KPiA2IGZpbGVzIGNoYW5nZWQsIDcxNiBpbnNlcnRpb25zKCsp
LCAxMzIgZGVsZXRpb25zKC0pDQo+IGNyZWF0ZSBtb2RlIDEwMDY0NCB0ZXN0cy9xdGVzdC9pbnRl
bC1pb21tdS10ZXN0LmMNCj4NCj4tLQ0KPjIuMzQuMQ0KDQo=

