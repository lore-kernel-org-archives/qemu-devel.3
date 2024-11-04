Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11C2BD11183
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 06:27:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t7qXc-0002Sl-LU; Mon, 04 Nov 2024 01:26:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1t7qXU-0002ST-RK
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 01:26:13 -0500
Received: from mgamail.intel.com ([198.175.65.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1t7qXR-00075p-9y
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 01:26:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1730701569; x=1762237569;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=NC75o+v8kTyUlPdRuk5Zau3biBOpwgn2TmV9wfMnVYs=;
 b=VkLls6rST/QshQ80KDc8v66R9TqZeqJWJy3eK5ioWcmOhL/DZNr94m+Q
 YwcjvBH8ki0cdI8OIUhK5SahrdUVUNkpXStYdncyRv4fnYB/LcOFEuUWk
 rjrFG5SmTFbrNy0ssn1b8TCEQwzRBz23UvagQyZd0zLdOtwXf3m7lJtUd
 r3WQMiEzlaDtv7zvRaOdC0wlyPyCvHYH9aFFglT/r8WZA4lNJ5aN7wpUJ
 efp3NGHccbRCQb74c4nShdoO8A6EMOZH4CsF1KH/mrxy9oRacbAS96sS0
 GZPJe74Epqfgf/1FmbPgolBt694lfWTj2l9x5P9NSXWB5YNyUZw8bO/bL A==;
X-CSE-ConnectionGUID: 1DkGhDr0TkOK9ZGfUQfVyw==
X-CSE-MsgGUID: w+h7K5uZTYKZ8zExtNdcDg==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="30561420"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; d="scan'208";a="30561420"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Nov 2024 22:26:03 -0800
X-CSE-ConnectionGUID: GubSJrOHSlGLcAJx5pD5qQ==
X-CSE-MsgGUID: OQNQ32qLTjGeu89iJ1AxfA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,256,1725346800"; d="scan'208";a="83654535"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
 by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 03 Nov 2024 22:26:03 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 3 Nov 2024 22:26:02 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Sun, 3 Nov 2024 22:26:02 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.177)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sun, 3 Nov 2024 22:26:02 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vXHD9N1aF0ELEbfIM0I1RhIq/SaBfUTSioaiuK9OjUxqdVHwhXlmHUMazzQEHC9VRMJWHi3eIUbPEUOOfOLI9E9NVKtPyyl4P1vQQ3+WnnbzwQ54B8vsWP1YiJedjWf25s6KXi9NB3u2MbnvhWW9L1tJN+jDQ23rNDD3Z7L6sNRpwOABWNHu4HgnKsDi0XT/e1CKQO89g+EoKAY3eHwZtMnoog1mgS5NlCrCbN/HGLjZMFn/JfHmt6gFlSozIKABEIwL3xXlEnl1gvod1TW81ytw0ulK02X4aUY5bvIBCK0U6vqcUC4zzq2iyF7SijiCsh1tWp+GTPV+wL0yNE/8cA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NC75o+v8kTyUlPdRuk5Zau3biBOpwgn2TmV9wfMnVYs=;
 b=KhhCqFKnf6sAm5cisNidEoRbsB4oCJ0g+6tekmoI8RienoUcEV8nWF6UA08A962F1u9DnJVlAIEWP6p6DJsCAm3mXUu1YuNhXPPmQG2+ZY+hXA9Or/FxDB9f/9SiQxJxsWSxuUdZ0edqC/EyMrOqnV5LZqXM2ujSGHpo9kZs5YkWFbyyMjPeFQK4+ZcH78a8V+gqDjxZamsaizEZLUb19A4YZiDaqleFZJUg2VB1VjjPzFGh8ckEgKcLFgYXNlOza9kgoQLZcVUSe7948/fTi80jbMTLmYnfDVSqfRWtA3GhODRxjW+BCR3ZrDnVYtv2jBvh2c0ePtOEC90cd6DgNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by CY8PR11MB7798.namprd11.prod.outlook.com (2603:10b6:930:77::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.29; Mon, 4 Nov
 2024 06:25:58 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091%5]) with mapi id 15.20.8114.028; Mon, 4 Nov 2024
 06:25:57 +0000
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
 "Peng, Chao P" <chao.p.peng@intel.com>, Yi Sun <yi.y.sun@linux.intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson
 <richard.henderson@linaro.org>, Eduardo Habkost <eduardo@habkost.net>, Marcel
 Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: RE: [PATCH v4 15/17] intel_iommu: Introduce a property x-fls for
 scalable modern mode
Thread-Topic: [PATCH v4 15/17] intel_iommu: Introduce a property x-fls for
 scalable modern mode
Thread-Index: AQHbExuAfv1IrXwu+EKkvlrbZNnFPLKmvOsAgAAeNBA=
Date: Mon, 4 Nov 2024 06:25:57 +0000
Message-ID: <SJ0PR11MB6744F2BFCE29E91D6180609292512@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20240930092631.2997543-1-zhenzhong.duan@intel.com>
 <20240930092631.2997543-16-zhenzhong.duan@intel.com>
 <5cbe6426-e64c-45f1-b276-c7dbb70ff3ed@intel.com>
In-Reply-To: <5cbe6426-e64c-45f1-b276-c7dbb70ff3ed@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|CY8PR11MB7798:EE_
x-ms-office365-filtering-correlation-id: 2fb8a793-6727-49fe-070a-08dcfc998b51
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|7416014|376014|366016|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?WjBHRm41blgzcUVOZUg1aGxQcU9pMWV1anJjbjJ4YVNJeXBCM0dYQkVvYTJt?=
 =?utf-8?B?ejBmSGpBZ0kvbUZWOU95R2U2dk9iWW5ob3BuSmRhVzdIRk9qT25acWJCUmZ2?=
 =?utf-8?B?ekJ0WHJDYUJyKzhLZ01mUXpzVzRJd0V5cXZSOGdMcEJLb3lCUXBvekFmVzFu?=
 =?utf-8?B?Q2d4YklKTURuMkE1S0UvbGdVR2RZdTJtdGZYejhmNk96VUJ5ZU1yY0MrTkRn?=
 =?utf-8?B?bnordWR1aFQzSEFwSkFlWnVDNDc1R0pNUlJlcG5HZUd3TGVoNC9uZ1k3eGJr?=
 =?utf-8?B?MFNCTDVQL2hZNEd0L2VhSGNTeCtRejBQdTN1UzU1ZitvVnhRa0s4VXdUVlJi?=
 =?utf-8?B?OXVkdmYwUVQvYkdmanMxUGdoNmhqeFBDSDlGaFpaVVVFTVZySy82Z20wWmI3?=
 =?utf-8?B?Wlo1NlNYNXVKc3V2eGpJaUZsRjdjOWpPTlBCTldLRHNTUTg5NjFyOTZoa0NT?=
 =?utf-8?B?Tjl5SVBjQmpZK2VjMWVvSy85QWxWbGpyZ0FJb1NNbGNrQkNkcEI0R0FoUEpz?=
 =?utf-8?B?a3JQMkIwN3AybjdReGlYd2xhMHE5T2JDcEVWcytHSHhCZzQxWkNWeCtsbS81?=
 =?utf-8?B?TDVHZGQwYUlvdVBScnVQZFFvNzY2Z1ZUQ0V5OXpKWUFacGhDRjZMT2grN08y?=
 =?utf-8?B?djhrb0huc29ZQXgyRXovSThkUzZ2MllkSFo4K2orNXdBUGpuUklGYnVYRHFT?=
 =?utf-8?B?MFJ1V1UzUFJQZDhoN2hRKzU0SW03dHVkNURKbEpTckQrV1FlY3EvTVJaM2U4?=
 =?utf-8?B?cHQzZDUrYTNWZUpTL3FqYWlIajRINGxuWjJ4WWtmZ2RVY0hkdVVlN1loUGln?=
 =?utf-8?B?YUdhc1N6bjk4cjZIL1YxaVJZT1JUcklmbE90c05GMjRBR3h3Y0FuSk5Ccm13?=
 =?utf-8?B?d0thNUd5QzVYaEg4MytUWmhQRHVHV0E4TFJDekVTcXBBS2cxS3gwekVqSHFQ?=
 =?utf-8?B?aS9sOC9ReTBFOGJXTjl4dzZzMllHVjA5bWsrM0pranh2cGIwdnNNUk1QLzlO?=
 =?utf-8?B?a3VuYkxrUWFxdFZuUlZzU1M1NjUxUlVROEdrSFB4cThBUmJScjQvTEVIaTZU?=
 =?utf-8?B?bUdybU9tV3N3WkNSRHdDeEs1NVRZUUQyN2RFUnh4T21WZHFWRHpiRDVTT3Yy?=
 =?utf-8?B?U3ZXWUJNejJnWTNtSVJ5NnA5QXFEdU9RRVdBajF6d0VzMS81MzJBdHNWUjQ1?=
 =?utf-8?B?L3RqbUxvWFdZcmhFYzVIazg3T0lFNEUvY0VkOVgyRnpmZ1MrVHltc09SQ2F1?=
 =?utf-8?B?OHN4dURqeElwam5Ha2ZYT2lkQW8yQUYwUXJ0WU82MVZVRjhmOGZjaVZYSUpW?=
 =?utf-8?B?Y2x1Wmd5VkJwSkFtWmE0UU1zTUhjdGVtMElYREgzSmpta0ZrMnZXcG9id2J5?=
 =?utf-8?B?bXI2N1RvZmZsdk1EdGZrTHFKVm41YStvUDVQK1FPUllLL01QK2VlalRiNDZJ?=
 =?utf-8?B?TjM1UG91bzdNbTIrREZKYk9kQnFJV1krUS9wSmJTZUtsWUhqby9pYlVyMFhI?=
 =?utf-8?B?T1FMRUhGWUlMTEd2dGdvakhNL1lEcEFaSTN2b3BQaXM4VFd5MGdrZDVrazZi?=
 =?utf-8?B?MVIrYUZRVUcvUElpaGRtbTZ3TnViSU1XcWFzUmg4SDVZZHpQbHg4QStxMWR5?=
 =?utf-8?B?SUlSN2Y5djBMQ1dLKytBeC9hSm8yZllSa0FiR2lza0dCWlRxYkRzWGJkWWZJ?=
 =?utf-8?B?VFdYNXFhWEJ3RDdxYUQ3THB5NDlNQk1OTUthTGFJK3puaWxCLzBETG9BOTN6?=
 =?utf-8?B?d0NsNjFzMFMxZGFIdVR1REZpVGRINUNyNVd4cmQ3NnFsNmhBTHFCbi9uODMr?=
 =?utf-8?Q?r6mq+acoqvhzwiDBawozwhfJdsu/mUJGoTHa8=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SXBXMFdER24vR1lvUkltVXRJU3Z5M0xONk9keHM3RzdFS2EvM1daQ3VwZFNS?=
 =?utf-8?B?dkJobk5wTHhyeUpmQ3E4V3JldExsZG9UTTlDQ1lmUmFhRGgwQnE2OGFLbWlN?=
 =?utf-8?B?MjN5OXB4d2o1cWplMkxVbXRhVG9HN0xrTC9EMkdVRDI5Ni9oWEZXaGVSdDBS?=
 =?utf-8?B?MFdKUkEwdWJQL0l0dnpET1llMVc1dFF0U2h4Njh4RmtEODJPVStnTFZRc0t4?=
 =?utf-8?B?djBIdEdKNEFIVHNwSU1WVW5rUzFnQyttcGF2OGxOcUo5eHRIZjRmVDZ5RHNr?=
 =?utf-8?B?eXFiNFg1YVhrdjR5UGtGT1FhajZJQko4SGtNQjd5aVFJT2lidCtjT2xMaFIv?=
 =?utf-8?B?THFyUnVQdERFd0VLZUNvS3F4YmhPQlVNT3VnaGcwREcwT2szREtXdkRQK3B6?=
 =?utf-8?B?MTV2WWI3Q0JkanBxMGRmOFJrMS9aWDkvWkc0blNvWTZubHdPVWdEejZtMGty?=
 =?utf-8?B?SGFsSGZST0FuRm1ackZDWDNGUHFFTXlyakNUVUk0a1RxRE5tR3NnVlFZakdR?=
 =?utf-8?B?OEowUmxIVC9ycUwxa0x5bUlXVnd3dlBBK1dxYU9TZnJKbHBNTVBVNVpockVV?=
 =?utf-8?B?TDhsQ09LeTYzK3ZaSkp5RjZ5YVpvZVRJT1AwKzY4MENaclB3MEhOVXVsdkwv?=
 =?utf-8?B?bGlkSFlGOE1kMkZxdUdka0FhMDh0QUZjay9MRDEzUm1WR0FPN1FmcTRCdS9n?=
 =?utf-8?B?T2wwL0NlLzl1OEFhdUhEVWpBZnA5OEJTSnpzVG5VTnUxc3ZPdGswd3V1ZWtt?=
 =?utf-8?B?aVRGZHpXQ0o1eUhEWC9hNzR2WmErNm16M0N4bHdvMUFNTk5UUXplVkxvVnl1?=
 =?utf-8?B?YnlERThnMUNHVWNqZllXeEJFTUR1Z1lxdlhoRmZSWXk2dHVCRW9jWVRqL2VF?=
 =?utf-8?B?c0lPMEJNM21NbEhtL1V5bU9sYU9XNngxTk1HQ3pFbnNybmRiczNMcEtIeFAy?=
 =?utf-8?B?WnkxUGo2VE83L05UMEJQRFVaY3hnTTJxdUFKS24wQWhRTVNoUkFoTXJUODhL?=
 =?utf-8?B?QzJnTnNDV2M5ZFRlSWVqdW1uaUJMWG9GdGhQTzRhd3JDOWxINEp5TmZBZlNx?=
 =?utf-8?B?OXgvZ3pLSUwzR3d6ZjlsczZzays0NEYvUU8xV2wzRklMdkh5YmxPY2xBMGJy?=
 =?utf-8?B?U3hyWjMvTG9ZSXpxWUVlVVNFZ09sd3REcEFmNVZRUU9VRGhGSFRUN0ZvWHhU?=
 =?utf-8?B?SnBFK3dBckRiMGtPOHBFcjBYdys1dTZzMXV5ZXlDY1Jsd2xmZTFxSURpUnd5?=
 =?utf-8?B?Zk54Q2xFUFcvczFobEllMU5Ub2pRMmZldnZIYnlydDJVcUlaK2V1MjFLMEJk?=
 =?utf-8?B?MDZDUDl3aGJSRnlzVm8xOU1SdWg1TzdKdzY5RDh4VmtkeDZQd3JMa21YVkdK?=
 =?utf-8?B?bWpmcGdjVktDNXhCUlV0OVVZYjZoa2k5czhvcTFyUFYyRXVkZVdGeDJRRkgz?=
 =?utf-8?B?WUQrRjZyZmt0VVJHdUd2MktyWElSMEV1cHovUlhjMkNCYXRHejlEeXFIQ2Y0?=
 =?utf-8?B?d3EzTE5HOER1MG9JSkhkVSsvOVVGYjl0VUFlSk5SaTF2OGh3M2I1eUZERnpF?=
 =?utf-8?B?Y2ExZmVmNEZCRHhKNit2Nkd4djFwYlRiMFhJN3RsSjI2OFRuVkx2dXJTWldR?=
 =?utf-8?B?eHpFV09LOWRIS1lVcSsvVjFLS3p6N2lUZ2V5M3lqcE1tTVRJQnk0ek5hbE1E?=
 =?utf-8?B?amRTa1Y0Vnd3RllSVWdGV0l2eWJaa0IrMlZncGZHK3RDOUNUQUxkbUl5cjRU?=
 =?utf-8?B?c0xFemRjdTdVdkZZUTNTNUUrZmd1UGNlMGpyRlZSeHpENWdrOFBhUnJEUjR2?=
 =?utf-8?B?OEExZ3R3TGM5YVF5aU1jT094MUhJZkpGMGhibXBLQzhrME1lVEJzYjFzbEJI?=
 =?utf-8?B?ZnpnNmJpM1YwV2FYOTZlVU10eC9ickpRTUZqTHV0Um16UndBV3UvU2o5a2g1?=
 =?utf-8?B?V0xXV3MwQVcveC91b2QramZkYTR1bGVSdUZaQWZOL1Nma2xBd05JVVZQUmRs?=
 =?utf-8?B?c2ZLbFFUREVkNUJYeEJ0ZmVtZHNEMkdNek1yTGwzRUhsQVludnA2Q1Q4MFdt?=
 =?utf-8?B?cHdGOEdtVjlsUHNBVVhFSE1uMWZySktRaVB6N0FMUmlRcUp3YlVncG9pNUdX?=
 =?utf-8?Q?G0Oy3NdfxbYkPkqy+RKEdvO5N?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fb8a793-6727-49fe-070a-08dcfc998b51
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Nov 2024 06:25:57.7115 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FwMI4NZM4vH0yHz3MwXSqtsjTY5HbaP087030EKY1Md0uZl2n0WPsyFJVcxVo74ERKtEdjpYYxLOQxx3CBxucu7EMEJfuLbDBcskZJcYaVY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7798
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.18;
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
aXVAaW50ZWwuY29tPg0KPlNlbnQ6IE1vbmRheSwgTm92ZW1iZXIgNCwgMjAyNCAxMjoyNSBQTQ0K
PlN1YmplY3Q6IFJlOiBbUEFUQ0ggdjQgMTUvMTddIGludGVsX2lvbW11OiBJbnRyb2R1Y2UgYSBw
cm9wZXJ0eSB4LWZscyBmb3INCj5zY2FsYWJsZSBtb2Rlcm4gbW9kZQ0KPg0KPk9uIDIwMjQvOS8z
MCAxNzoyNiwgWmhlbnpob25nIER1YW4gd3JvdGU6DQo+PiBJbnRlbCBWVC1kIDMuMCBpbnRyb2R1
Y2VzIHNjYWxhYmxlIG1vZGUsIGFuZCBpdCBoYXMgYSBidW5jaCBvZiBjYXBhYmlsaXRpZXMNCj4+
IHJlbGF0ZWQgdG8gc2NhbGFibGUgbW9kZSB0cmFuc2xhdGlvbiwgdGh1cyB0aGVyZSBhcmUgbXVs
dGlwbGUgY29tYmluYXRpb25zLg0KPj4NCj4+IFRoaXMgdklPTU1VIGltcGxlbWVudGF0aW9uIHdh
bnRzIHRvIHNpbXBsaWZ5IGl0IHdpdGggYSBuZXcgcHJvcGVydHkgIngtZmxzIi4NCj4+IFdoZW4g
ZW5hYmxlZCBpbiBzY2FsYWJsZSBtb2RlLCBmaXJzdCBzdGFnZSB0cmFuc2xhdGlvbiBhbHNvIGtu
b3duIGFzIHNjYWxhYmxlDQo+PiBtb2Rlcm4gbW9kZSBpcyBzdXBwb3J0ZWQuIFdoZW4gZW5hYmxl
ZCBpbiBsZWdhY3kgbW9kZSwgdGhyb3cgb3V0IGVycm9yLg0KPj4NCj4+IFdpdGggc2NhbGFibGUg
bW9kZXJuIG1vZGUgZXhwb3NlZCB0byB1c2VyLCBhbHNvIGFjY3VyYXRlIHRoZSBwYXNpZCBlbnRy
eQ0KPj4gY2hlY2sgaW4gdnRkX3BlX3R5cGVfY2hlY2soKS4NCj4+DQo+PiBTaWduZWQtb2ZmLWJ5
OiBZaSBMaXUgPHlpLmwubGl1QGludGVsLmNvbT4NCj4+IFNpZ25lZC1vZmYtYnk6IFlpIFN1biA8
eWkueS5zdW5AbGludXguaW50ZWwuY29tPg0KPj4gU2lnbmVkLW9mZi1ieTogWmhlbnpob25nIER1
YW4gPHpoZW56aG9uZy5kdWFuQGludGVsLmNvbT4NCj4NCj5NYXliZSBhIFN1Z2dlc3RlZC1ieSB0
YWcgY2FuIGhlbHAgdG8gdW5kZXJzdGFuZCB3aGVyZSB0aGlzIGlkZWEgY29tZXMuIDopDQoNCldp
bGwgYWRkOg0KU3VnZ2VzdGVkLWJ5OiBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPg0K
DQo+DQo+PiAtLS0NCj4+ICAgaHcvaTM4Ni9pbnRlbF9pb21tdV9pbnRlcm5hbC5oIHwgIDIgKysN
Cj4+ICAgaHcvaTM4Ni9pbnRlbF9pb21tdS5jICAgICAgICAgIHwgMjggKysrKysrKysrKysrKysr
KysrKy0tLS0tLS0tLQ0KPj4gICAyIGZpbGVzIGNoYW5nZWQsIDIxIGluc2VydGlvbnMoKyksIDkg
ZGVsZXRpb25zKC0pDQo+Pg0KPj4gZGlmZiAtLWdpdCBhL2h3L2kzODYvaW50ZWxfaW9tbXVfaW50
ZXJuYWwuaCBiL2h3L2kzODYvaW50ZWxfaW9tbXVfaW50ZXJuYWwuaA0KPj4gaW5kZXggMjcwMmVk
ZDI3Zi4uZjEzNTc2ZDMzNCAxMDA2NDQNCj4+IC0tLSBhL2h3L2kzODYvaW50ZWxfaW9tbXVfaW50
ZXJuYWwuaA0KPj4gKysrIGIvaHcvaTM4Ni9pbnRlbF9pb21tdV9pbnRlcm5hbC5oDQo+PiBAQCAt
MTk1LDYgKzE5NSw3IEBADQo+PiAgICNkZWZpbmUgVlREX0VDQVBfUEFTSUQgICAgICAgICAgICAg
ICgxVUxMIDw8IDQwKQ0KPj4gICAjZGVmaW5lIFZURF9FQ0FQX1NNVFMgICAgICAgICAgICAgICAo
MVVMTCA8PCA0MykNCj4+ICAgI2RlZmluZSBWVERfRUNBUF9TTFRTICAgICAgICAgICAgICAgKDFV
TEwgPDwgNDYpDQo+PiArI2RlZmluZSBWVERfRUNBUF9GTFRTICAgICAgICAgICAgICAgKDFVTEwg
PDwgNDcpDQo+Pg0KPj4gICAvKiBDQVBfUkVHICovDQo+PiAgIC8qIChvZmZzZXQgPj4gNCkgPDwg
MjQgKi8NCj4+IEBAIC0yMTEsNiArMjEyLDcgQEANCj4+ICAgI2RlZmluZSBWVERfQ0FQX1NMTFBT
ICAgICAgICAgICAgICAgKCgxVUxMIDw8IDM0KSB8ICgxVUxMIDw8IDM1KSkNCj4+ICAgI2RlZmlu
ZSBWVERfQ0FQX0RSQUlOX1dSSVRFICAgICAgICAgKDFVTEwgPDwgNTQpDQo+PiAgICNkZWZpbmUg
VlREX0NBUF9EUkFJTl9SRUFEICAgICAgICAgICgxVUxMIDw8IDU1KQ0KPj4gKyNkZWZpbmUgVlRE
X0NBUF9GUzFHUCAgICAgICAgICAgICAgICgxVUxMIDw8IDU2KQ0KPj4gICAjZGVmaW5lIFZURF9D
QVBfRFJBSU4gICAgICAgICAgICAgICAoVlREX0NBUF9EUkFJTl9SRUFEIHwNCj5WVERfQ0FQX0RS
QUlOX1dSSVRFKQ0KPj4gICAjZGVmaW5lIFZURF9DQVBfQ00gICAgICAgICAgICAgICAgICAoMVVM
TCA8PCA3KQ0KPj4gICAjZGVmaW5lIFZURF9QQVNJRF9JRF9TSElGVCAgICAgICAgICAyMA0KPj4g
ZGlmZiAtLWdpdCBhL2h3L2kzODYvaW50ZWxfaW9tbXUuYyBiL2h3L2kzODYvaW50ZWxfaW9tbXUu
Yw0KPj4gaW5kZXggMDY4YTA4ZjUyMi4uMTQ1Nzg2NTVlMSAxMDA2NDQNCj4+IC0tLSBhL2h3L2kz
ODYvaW50ZWxfaW9tbXUuYw0KPj4gKysrIGIvaHcvaTM4Ni9pbnRlbF9pb21tdS5jDQo+PiBAQCAt
ODAzLDE2ICs4MDMsMTggQEAgc3RhdGljIGlubGluZSBib29sDQo+dnRkX2lzX2ZsX2xldmVsX3N1
cHBvcnRlZChJbnRlbElPTU1VU3RhdGUgKnMsIHVpbnQzMl90IGxldmVsKQ0KPj4gICB9DQo+Pg0K
Pj4gICAvKiBSZXR1cm4gdHJ1ZSBpZiBjaGVjayBwYXNzZWQsIG90aGVyd2lzZSBmYWxzZSAqLw0K
Pj4gLXN0YXRpYyBpbmxpbmUgYm9vbCB2dGRfcGVfdHlwZV9jaGVjayhYODZJT01NVVN0YXRlICp4
ODZfaW9tbXUsDQo+PiAtICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFZURFBB
U0lERW50cnkgKnBlKQ0KPj4gK3N0YXRpYyBpbmxpbmUgYm9vbCB2dGRfcGVfdHlwZV9jaGVjayhJ
bnRlbElPTU1VU3RhdGUgKnMsIFZURFBBU0lERW50cnkgKnBlKQ0KPj4gICB7DQo+PiAgICAgICBz
d2l0Y2ggKFZURF9QRV9HRVRfVFlQRShwZSkpIHsNCj4+IC0gICAgY2FzZSBWVERfU01fUEFTSURf
RU5UUllfU0xUOg0KPj4gLSAgICAgICAgcmV0dXJuIHRydWU7DQo+PiAtICAgIGNhc2UgVlREX1NN
X1BBU0lEX0VOVFJZX1BUOg0KPj4gLSAgICAgICAgcmV0dXJuIHg4Nl9pb21tdS0+cHRfc3VwcG9y
dGVkOw0KPj4gICAgICAgY2FzZSBWVERfU01fUEFTSURfRU5UUllfRkxUOg0KPj4gKyAgICAgICAg
cmV0dXJuICEhKHMtPmVjYXAgJiBWVERfRUNBUF9GTFRTKTsNCj4+ICsgICAgY2FzZSBWVERfU01f
UEFTSURfRU5UUllfU0xUOg0KPj4gKyAgICAgICAgcmV0dXJuICEhKHMtPmVjYXAgJiBWVERfRUNB
UF9TTFRTKTsNCj4+ICAgICAgIGNhc2UgVlREX1NNX1BBU0lEX0VOVFJZX05FU1RFRDoNCj4+ICsg
ICAgICAgIC8qIE5vdCBzdXBwb3J0IE5FU1RFRCBwYWdlIHRhYmxlIHR5cGUgeWV0ICovDQo+PiAr
ICAgICAgICByZXR1cm4gZmFsc2U7DQo+PiArICAgIGNhc2UgVlREX1NNX1BBU0lEX0VOVFJZX1BU
Og0KPj4gKyAgICAgICAgcmV0dXJuICEhKHMtPmVjYXAgJiBWVERfRUNBUF9QVCk7DQo+PiAgICAg
ICBkZWZhdWx0Og0KPj4gICAgICAgICAgIC8qIFVua25vd24gdHlwZSAqLw0KPj4gICAgICAgICAg
IHJldHVybiBmYWxzZTsNCj4+IEBAIC04NjEsNyArODYzLDYgQEAgc3RhdGljIGludA0KPnZ0ZF9n
ZXRfcGVfaW5fcGFzaWRfbGVhZl90YWJsZShJbnRlbElPTU1VU3RhdGUgKnMsDQo+PiAgICAgICB1
aW50OF90IHBndHQ7DQo+PiAgICAgICB1aW50MzJfdCBpbmRleDsNCj4+ICAgICAgIGRtYV9hZGRy
X3QgZW50cnlfc2l6ZTsNCj4+IC0gICAgWDg2SU9NTVVTdGF0ZSAqeDg2X2lvbW11ID0gWDg2X0lP
TU1VX0RFVklDRShzKTsNCj4+DQo+PiAgICAgICBpbmRleCA9IFZURF9QQVNJRF9UQUJMRV9JTkRF
WChwYXNpZCk7DQo+PiAgICAgICBlbnRyeV9zaXplID0gVlREX1BBU0lEX0VOVFJZX1NJWkU7DQo+
PiBAQCAtODc1LDcgKzg3Niw3IEBAIHN0YXRpYyBpbnQNCj52dGRfZ2V0X3BlX2luX3Bhc2lkX2xl
YWZfdGFibGUoSW50ZWxJT01NVVN0YXRlICpzLA0KPj4gICAgICAgfQ0KPj4NCj4+ICAgICAgIC8q
IERvIHRyYW5zbGF0aW9uIHR5cGUgY2hlY2sgKi8NCj4+IC0gICAgaWYgKCF2dGRfcGVfdHlwZV9j
aGVjayh4ODZfaW9tbXUsIHBlKSkgew0KPj4gKyAgICBpZiAoIXZ0ZF9wZV90eXBlX2NoZWNrKHMs
IHBlKSkgew0KPj4gICAgICAgICAgIHJldHVybiAtVlREX0ZSX1BBU0lEX1RBQkxFX0VOVFJZX0lO
VjsNCj4+ICAgICAgIH0NCj4+DQo+PiBAQCAtMzc3OSw2ICszNzgwLDcgQEAgc3RhdGljIFByb3Bl
cnR5IHZ0ZF9wcm9wZXJ0aWVzW10gPSB7DQo+PiAgICAgICAgICAgICAgICAgICAgICAgICBWVERf
SE9TVF9BV19BVVRPKSwNCj4+ICAgICAgIERFRklORV9QUk9QX0JPT0woImNhY2hpbmctbW9kZSIs
IEludGVsSU9NTVVTdGF0ZSwgY2FjaGluZ19tb2RlLA0KPkZBTFNFKSwNCj4+ICAgICAgIERFRklO
RV9QUk9QX0JPT0woIngtc2NhbGFibGUtbW9kZSIsIEludGVsSU9NTVVTdGF0ZSwgc2NhbGFibGVf
bW9kZSwNCj5GQUxTRSksDQo+PiArICAgIERFRklORV9QUk9QX0JPT0woIngtZmxzIiwgSW50ZWxJ
T01NVVN0YXRlLCBzY2FsYWJsZV9tb2Rlcm4sIEZBTFNFKSwNCj4+ICAgICAgIERFRklORV9QUk9Q
X0JPT0woInNub29wLWNvbnRyb2wiLCBJbnRlbElPTU1VU3RhdGUsIHNub29wX2NvbnRyb2wsDQo+
ZmFsc2UpLA0KPg0KPmEgcXVlc3Rpb246IGlzIHRoZXJlIGFueSByZXF1aXJlbWVudCBvbiB0aGUg
bGF5b3V0IG9mIHRoaXMgYXJyYXk/IFNob3VsZA0KPm5ldyBmaWVsZHMgYWRkZWQgaW4gdGhlIGVu
ZD8NCg0KTG9va2VkIG92ZXIgdGhlIGhpc3RvcnksIHNlZW1zIHdlIGRpZG4ndCBoYXZlIGFuIGV4
cGxpY2l0IHJ1bGUgaW4gdnRkX3Byb3BlcnRpZXMuDQpJIHB1dCAieC1mbHMiIGp1c3QgdW5kZXIg
Ingtc2NhbGFibGUtbW9kZSIgYXMgc3RhZ2UtMSBpcyBhIHN1Yi1mZWF0dXJlIG9mIHNjYWxhYmxl
IG1vZGUuDQpMZXQgbWUga25vdyBpZiB5b3UgaGF2ZSBwcmVmZXJlbmNlIHRvIGFkZCBpbiB0aGUg
ZW5kLg0KDQpUaGFua3MNClpoZW56aG9uZw0KDQo+DQo+PiAgICAgICBERUZJTkVfUFJPUF9CT09M
KCJ4LXBhc2lkLW1vZGUiLCBJbnRlbElPTU1VU3RhdGUsIHBhc2lkLCBmYWxzZSksDQo+PiAgICAg
ICBERUZJTkVfUFJPUF9CT09MKCJkbWEtZHJhaW4iLCBJbnRlbElPTU1VU3RhdGUsIGRtYV9kcmFp
biwgdHJ1ZSksDQo+PiBAQCAtNDUwOSw3ICs0NTExLDEwIEBAIHN0YXRpYyB2b2lkIHZ0ZF9jYXBf
aW5pdChJbnRlbElPTU1VU3RhdGUgKnMpDQo+PiAgICAgICB9DQo+Pg0KPj4gICAgICAgLyogVE9E
TzogcmVhZCBjYXAvZWNhcCBmcm9tIGhvc3QgdG8gZGVjaWRlIHdoaWNoIGNhcCB0byBiZSBleHBv
c2VkLiAqLw0KPj4gLSAgICBpZiAocy0+c2NhbGFibGVfbW9kZSkgew0KPj4gKyAgICBpZiAocy0+
c2NhbGFibGVfbW9kZXJuKSB7DQo+PiArICAgICAgICBzLT5lY2FwIHw9IFZURF9FQ0FQX1NNVFMg
fCBWVERfRUNBUF9GTFRTOw0KPj4gKyAgICAgICAgcy0+Y2FwIHw9IFZURF9DQVBfRlMxR1A7DQo+
PiArICAgIH0gZWxzZSBpZiAocy0+c2NhbGFibGVfbW9kZSkgew0KPj4gICAgICAgICAgIHMtPmVj
YXAgfD0gVlREX0VDQVBfU01UUyB8IFZURF9FQ0FQX1NSUyB8IFZURF9FQ0FQX1NMVFM7DQo+PiAg
ICAgICB9DQo+Pg0KPj4gQEAgLTQ2ODMsNiArNDY4OCwxMSBAQCBzdGF0aWMgYm9vbCB2dGRfZGVj
aWRlX2NvbmZpZyhJbnRlbElPTU1VU3RhdGUgKnMsDQo+RXJyb3IgKiplcnJwKQ0KPj4gICAgICAg
ICAgIH0NCj4+ICAgICAgIH0NCj4+DQo+PiArICAgIGlmICghcy0+c2NhbGFibGVfbW9kZSAmJiBz
LT5zY2FsYWJsZV9tb2Rlcm4pIHsNCj4+ICsgICAgICAgIGVycm9yX3NldGcoZXJycCwgIkxlZ2Fj
eSBtb2RlOiBub3Qgc3VwcG9ydCB4LWZscz1vbiIpOw0KPj4gKyAgICAgICAgcmV0dXJuIGZhbHNl
Ow0KPj4gKyAgICB9DQo+PiArDQo+PiAgICAgICBpZiAocy0+YXdfYml0cyA9PSBWVERfSE9TVF9B
V19BVVRPKSB7DQo+PiAgICAgICAgICAgaWYgKHMtPnNjYWxhYmxlX21vZGVybikgew0KPj4gICAg
ICAgICAgICAgICBzLT5hd19iaXRzID0gVlREX0hPU1RfQVdfNDhCSVQ7DQo+DQo+LS0NCj5SZWdh
cmRzLA0KPllpIExpdQ0K

