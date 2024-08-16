Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59F79C52D7D
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2024 02:38:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1semqc-0001x9-Gn; Thu, 15 Aug 2024 22:37:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1semqX-0001vJ-Kr
 for qemu-devel@nongnu.org; Thu, 15 Aug 2024 22:37:45 -0400
Received: from mgamail.intel.com ([192.198.163.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1semqV-0007F0-2y
 for qemu-devel@nongnu.org; Thu, 15 Aug 2024 22:37:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1723775863; x=1755311863;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=NBu9Kr6zX98Fb8aUxkw81IiOHSiidL1V1YWhmMRgPiM=;
 b=az8ABXdE4EF3yigjQXNv094hShrm7nKh456+LpbnTtPHCeUNHY8kAsKe
 Iz8OBmQp/CfywbApxRsYK7kCLjjFOZIItR3AjwdH1jljaCtOOS5mSYJVH
 QZaemAkHk8FmFjrBCnpwv+F55+bNlNpfue1Y+PWuV4Yr2tA7oP3C7x7/+
 21G4GFc0YD4QFGqhUBanc0olet17mRt5tTlsRkgfpYRExvvY+EcJGE8I7
 hLphUtffPauUVZNLoeQQ4bOMW83ZL/iy7d53BF7blWejxFQQaCq3w+JyJ
 +3u2+ORs8j60qbGhvkmgsuhwmnwLydl24Z3VBXtRVDTOYYClc7BWnCLXe A==;
X-CSE-ConnectionGUID: e2Ase2j3QxOZZxMr0K89Yg==
X-CSE-MsgGUID: 8SqMnCNWT9Ku6R7ebzTvVA==
X-IronPort-AV: E=McAfee;i="6700,10204,11165"; a="13047015"
X-IronPort-AV: E=Sophos;i="6.10,150,1719903600"; d="scan'208";a="13047015"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Aug 2024 19:37:40 -0700
X-CSE-ConnectionGUID: h3T0oCVvQDiH5GV8SoIf6A==
X-CSE-MsgGUID: i9MzO0xIQCC+X8h8T1Pv/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,150,1719903600"; d="scan'208";a="59495304"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
 by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 15 Aug 2024 19:37:39 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 15 Aug 2024 19:37:39 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 15 Aug 2024 19:37:39 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 15 Aug 2024 19:37:39 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.45) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 15 Aug 2024 19:37:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=riiGrDcNJc3zCAbwiha0tu786OKE61CWXZWRQGvMe4wG0nEk1QV3bFl6XYh98bbpRq5t0j13iABIKr+8bdVHzCt003s8pnbqC86e028YhGNFFY9I3wcJKWD911NjGLJh0vhthDLJSulgdSVcs+3zhowR7ofzSW67Q2iqyVLrTEKs/TY8f+SAHJzyuw3WT1RmAU2or3sn//nOPi8Cf2UOGwY+iaIBHwd60sv96OC1+rTrqiOHHkbwElUWzZj3awMVVSmYpZ83oe3EcqEykqJTV/PcA0KSnpJOTMUTBKYPWiLl7vCUcDhK1zvpXnlh0/eoA3AOQX4hcTWqvpu/g3rsyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NBu9Kr6zX98Fb8aUxkw81IiOHSiidL1V1YWhmMRgPiM=;
 b=bysvJSWG6jc7zyHTJyINEcmXanIxyb8dtEMuRqg6lsRrbq9Fp379A4u2TL6uKR5h6oNvos7zbq4p55NyGpSaU+ZGxhwhJUy4nGyGnnvZ+ifwhYD5zMBv2aN6oaJ4WEnt+mxoQADVyqplHhnt5oj+7M8TxgNg67OKjiERG2DaNfK3JIBFzt0/xICE13GY/1KCr6HHrXXKUNLUc4LkywLKYXtdHXMVHgIxRe5Sc9zEPInKIeRgbjC9d9unx3fq4mF4OnYLxeWeTjcOkWR51TeuNqb+OHgliLDFhHiDFqHBqlS4My5O6x1TNrU+PgwzyPfeXIt7RzcZio3UZWxcgVJiiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by PH7PR11MB6652.namprd11.prod.outlook.com (2603:10b6:510:1aa::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.17; Fri, 16 Aug
 2024 02:37:36 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091%6]) with mapi id 15.20.7828.031; Fri, 16 Aug 2024
 02:37:36 +0000
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
Subject: RE: [PATCH v2 08/17] intel_iommu: Set accessed and dirty bits during
 first stage translation
Thread-Topic: [PATCH v2 08/17] intel_iommu: Set accessed and dirty bits during
 first stage translation
Thread-Index: AQHa5wETNNMwdHApd0akLmwQibLhEbImsP4AgAKLG/A=
Date: Fri, 16 Aug 2024 02:37:36 +0000
Message-ID: <SJ0PR11MB6744BA14C86A1BEA1169FD1092812@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20240805062727.2307552-1-zhenzhong.duan@intel.com>
 <20240805062727.2307552-9-zhenzhong.duan@intel.com>
 <516fa8d2-ac16-4f2f-b7de-e5ac6b6d8663@intel.com>
In-Reply-To: <516fa8d2-ac16-4f2f-b7de-e5ac6b6d8663@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|PH7PR11MB6652:EE_
x-ms-office365-filtering-correlation-id: 31597ae3-f8df-4e7b-5030-08dcbd9c6386
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|7416014|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?ZFllL3YxZDNId0pGdm01QVJhSk56Y2RXRnViRjgwQWtYc0pWcEVHWnZGT3VI?=
 =?utf-8?B?TkNMa2NWeUlGY25DckhzMFNrTWUvSkZaVTdVc21YbHJIejhRcC9iWDZPRjhT?=
 =?utf-8?B?dmtpOEFGNGdsbWR3TGFuWTFhRlZpcG0rM21WUHhSN1lra0xWYjg5V2tYWnRV?=
 =?utf-8?B?WjFsM0s3eDU0K1M3bng3bTJCK01ua1dRWXNvMDB6Ymo5UU41Smx0KzRWS21z?=
 =?utf-8?B?T01YY1paS3JTS3RHanlJZjQ3ZG5hSjVaZWJBZmdJcFVncXhWUjAwNER6Skg4?=
 =?utf-8?B?dTFJOVNza3VtZW40bmRoK0lnYWVKRFVZaWh4N0t1akhQVkR0Z2x2dmhHWnpi?=
 =?utf-8?B?dWtESDAvcDBWOUN4eHdOcVJ6M0ZyNnFpK3JJY3ROU3RwZmI1b2xwZ0YxRUFZ?=
 =?utf-8?B?cmRsUDRzNjhaV0llMnZvUHplNG53SnIxQTN0S0pXR0tFbmRkTHpOVlY2S1RG?=
 =?utf-8?B?NDVzdGtLSTNzQUVFbzNMYjlBV1ltdVhGYUNTZWdUYURpNjFGOWZFM3Y3am5m?=
 =?utf-8?B?Y2RoaWdYclBpT0l2RWd3TGE2NGNsYjBXN2ZndU5GM3BXL2NpcnhwVno1djZP?=
 =?utf-8?B?QWNHaGNwRHdwNkVzckFQeTJnZ1BMbzdOVHZqRWxOQjNNTGpYbk5KWnJFMFM2?=
 =?utf-8?B?aWdhZ09NSXRqbjc4YjlXaXpoNVVUekdzNjMzNlk4dnUvT3YwUHdKTW9lN1Yr?=
 =?utf-8?B?VjhNR3BtdmlOQ1k0V09FcUNULzFSNEdsSzNqTHpaL3JhK2svbm45R2t6TWJi?=
 =?utf-8?B?Vk9tV2tLV0trSkVJcW40dVY0T2k0N0FERjZ1b2grdzJXdktwb2twTHFuMlVF?=
 =?utf-8?B?UnNzMlp6SVIvSFlINTBqY0JuOTRNdlhkVjlxQmZBVUdlL1ZRdHFsa1Q1VEhL?=
 =?utf-8?B?RVlFRmFweERVQjlnd1F2V0thRVNOUGdlWTVCMzBuN05MOThxYW1kZWQ3b0Z5?=
 =?utf-8?B?SEdtaGgvNXhrZXhqcW1MbTd2cU9DOE1yc21ORkJRNlFVM0ltM09lYnpIbTJr?=
 =?utf-8?B?SUJWdlVaMXFEOERJMTUxL2JqMk5JM2QxdDA2c1hFclpTNzZPUGthcnFTR1Jh?=
 =?utf-8?B?NEowUnpSUHZsRiswTWFIY05vSWx6bVhya05zaHFCUmxud2FidEFQRTY4OExt?=
 =?utf-8?B?NTRoY2VNd0ZzV3NPUGFlb0N6VWV1WnZaMVpCNmNZc0NyeDNaN2g1Q1NiUG9r?=
 =?utf-8?B?aUd3dFdqbWtjQTNvTU9iUDVuNWFNZjdzL2xBS1JuYityWlB6OENycWk4RkVo?=
 =?utf-8?B?VXNUallSZmRxU2dEMWlGUDJiTWdpSjBpMlZ5ZURnOWpISDFXMHlGNWlqSGhj?=
 =?utf-8?B?Z3JZMUZ3Q2NhckVPL3NrSGxuTWRaQ1RUWlZVS3pOQjdIQmRNQTRaZ290MDNO?=
 =?utf-8?B?ZmZzckYyWlAzb1FNQnE0QXJFQWxXNGNsZ1lDSkx3M0VWNUZ2ZjJ3K2dmK0Mv?=
 =?utf-8?B?Mk9VSlRJZHJlU29PRytYbmxDd3lWc1hYZXpKUmtRWEJRV2NRTXdxZmVOSllK?=
 =?utf-8?B?eUV4dXk1RXFEcXFFSFd4U0tJK0lqNHBJVExKN2VRb1hiVG5PbVJQakdtclVB?=
 =?utf-8?B?N1VGWUZFY3Z1aURGQjE4NUNldHhBV1UzWnh1RlBvYytNaEl1bHBOaGlQUmFy?=
 =?utf-8?B?bDVPd2swWXlKN1Z3dWRzS0ZwZ2lXVXFmVnIzK1B0WStsU1NLTXdUTW81M29M?=
 =?utf-8?B?QmZxUHlXSHdYUitFTTJ2aWdIalNIeWJybThsME0wNEZ2b0d2di91ZERmdldk?=
 =?utf-8?B?TVVUT1F1eVhyOUhsdDkvdjVjSUZqSXVoMEczd2xsbDE0WjlTNG9jTTFPaFV3?=
 =?utf-8?B?OVJ2ZUsvMGxnRGc1M3E0alV6VmFBSnpOeWcyQXQ1cHltbHRYakJqU2dpNXhK?=
 =?utf-8?B?T1YvcEdyNzA1bnIxVklrYVEyUXVmc3RoNnpXYnRaSE90OFE9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7416014)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bjFVbkI1MG9TTEYyVng4SkhYOXdIUzNDWld2TTMzaVBwSzAyVlVQUE1hSVRX?=
 =?utf-8?B?UjhKQytjTi9ra1ZaTzkwUXdtZEk3TVV6OXJybVFGZ3dCK2NrWnZ3QVlkeGly?=
 =?utf-8?B?RlVFOTNnZEFhZ1JVK2IzeGlNbENMbmpJczQ3VHBZUmYrUmsxQWovc0FtejNl?=
 =?utf-8?B?SWNyL2VVWGZNWHpmT0IzTVU0N2JqczFHZlA2eWdtL3ZkTWtwUzRHa09WbzIy?=
 =?utf-8?B?NDZENDMvclBsUWpESURCYWI3S2NGd3ord0VIamloRExERzlhK2FaeTcwek92?=
 =?utf-8?B?RU53dWQ0K2dqbFZTbG4vM0VpZWdrNm45NXV2bXZ5V0JabGluYXFkZFFhQWxQ?=
 =?utf-8?B?c2Z3SGdhMjR0TkxqSHQ0cFJSRzJjTU5XNzNXakp6VnRRbDdOWGlOeTBHcG0w?=
 =?utf-8?B?cEVkUW1JNm52M2hIbldQZzlWRFdTYWwrU3dsYTJFTEFCVUw3S0F1WnR3Z09T?=
 =?utf-8?B?MHhvSVlRMHVnQ0QydDdEQ1FJVEQ1SUk2bUtzTTluMXBKenovWjk3NFMrQ1pN?=
 =?utf-8?B?c1VSVDZRMDZjTWR3OWY5LzVDakM4OXRUMlFJV1BxcnRna2p5QUhWQVluRTFp?=
 =?utf-8?B?eTVXL3lEWU0xbW5XT0ZZaEFpQWFQZERUb2huZ2RiZUdzcTk5UFh6TkFwT2dw?=
 =?utf-8?B?eDRTZ2pNeFNDZHd0bklVL28rU2FVaGFNYzYxTkQ5Sm5FNTdIYmZxYldreVZN?=
 =?utf-8?B?VmtBdTRtY3hvQ0RleVhaTVl2TlNlOTRYUXlPalphYW1QOWxYV2srVzBPT0E4?=
 =?utf-8?B?RHVEYjdFTzJSSWNRNmlGYlY5ZWR1QTR6QXNReVJnTTBaRTFqU0V3ck5oZ1BG?=
 =?utf-8?B?Vm5acTcweTdPbXFXSkkxMnpvYjYzZ0JHSWJ0M1M1VW5BSC9XNitTOVdJYTlh?=
 =?utf-8?B?MnV5SWoyb29JZURneFlSVmtvVGl0MW82L3FEb05kbndvUjN4UGZsT1FQdExn?=
 =?utf-8?B?WjFCcmFjMW5rajBGZXpWT09LMUkxRGNCNThzSTlXRlU3NkNuaTUwSHVOSlEz?=
 =?utf-8?B?ZmdvS1JVRkNuUlcyQjZnY2p3WHVpaHZBbjZRcnhXV3VzbjhQRDNwOFp0QkJn?=
 =?utf-8?B?eEFOekhqQkkyblNVeG9OVnVjbnFQOTkwS0lvWmtmejZValN3d25rSENaSGxQ?=
 =?utf-8?B?YjhuMEdDcXA1b3Z4STlLTFVUTUNlUGRlMUNlZTh1cG9PeUtrYzV0OGZRanEr?=
 =?utf-8?B?UUJieWZJOVNzQzEzNFQ2QXB5c3NiTEZURFpYL1dIQmdES3Bkak9KUERsZmlC?=
 =?utf-8?B?alZpekYwei9GakVQeHptc0s5bTI4RWFsRFJFa1Jud1pDWFNWT29OYkd5ZitI?=
 =?utf-8?B?bGo0aXkwZVJEY2R1T2NYTzk1aDFNNkF5SmxzUmVLOGlRcGxsL3Z4a2ZuTGlq?=
 =?utf-8?B?NlNLUFY3YVBRMG0yeU55MVUvVGhyQldDdDY3cFM4b1RGekY5T2txMUhGNTgz?=
 =?utf-8?B?KzhCREtuck0vRTFOY1BnTS9WVFNuN0hkb0pSZjREalFpMWkzc3NTZkdQc2J0?=
 =?utf-8?B?Y1UrSzlwZWFMVWREeDM4ZERaSGMvMmNPZURtQ2hadTJlc0lHWjN2RnJWNjBm?=
 =?utf-8?B?VkE0OTZnU3c0NDFlaFdqd0VvSlpVbTJUbVYzT21iZTBUTmFIVWhYajgrSkJQ?=
 =?utf-8?B?ZjNERURzVk55QjYwRFBkK0dzendLc0NCN1R6L2wxdFl1VWQxcnpibnhoV2VQ?=
 =?utf-8?B?OUtzbjBLdnNWRnl2cTR5dHo1ZmZidUdKNVd6NHZIbDQ4VkFHQlR0RFVQanhN?=
 =?utf-8?B?TFg3MlM3TCtQenNGclBjWW91U0x6K0NyalRTYXdRdlY3b0M3bWZ0RWx3MUlt?=
 =?utf-8?B?TjlkQjREZ0xxZFFTK2VlRjFUOUgrT0daMk9vZkFLdEtqOE9LTTYyeE1hY1FN?=
 =?utf-8?B?UDBJWEFlb043ZjN0QzFYN1NPdDhmWlhNaW1zcitWUVZuUmlCTThPdGtwMUkx?=
 =?utf-8?B?bFE2bjBOLzNKSDVubmpyMzVGZzBBUXIwNEQzMXlDbnROdlRZSTdSMXRPSFFl?=
 =?utf-8?B?UVdyN01qNVhjS1JlYlRUZmVCc1BSVFF5Y2xzWVBwbkZydnJqbiswNk0veUVW?=
 =?utf-8?B?UlFBZWdFUnVBdlFnb1ZIQ2NjdE9BOUdlRjVMeHpTajd4R3VoekYrR1lMQUhL?=
 =?utf-8?Q?Kz4XC48n9LHWjfNJt2CPJJva0?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31597ae3-f8df-4e7b-5030-08dcbd9c6386
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Aug 2024 02:37:36.1646 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8xbsHdgRIyGyfs6xNXP1Q2Nn7GKLo7D+1tp+RKiK/J3yd0OV0xRSbZpDe2r4rava5o+6A8jt8BSyf9uiZkeTEtFv57OPGnts6auWzupJ6EQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6652
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.16;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.131,
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
aXVAaW50ZWwuY29tPg0KPlN1YmplY3Q6IFJlOiBbUEFUQ0ggdjIgMDgvMTddIGludGVsX2lvbW11
OiBTZXQgYWNjZXNzZWQgYW5kIGRpcnR5IGJpdHMNCj5kdXJpbmcgZmlyc3Qgc3RhZ2UgdHJhbnNs
YXRpb24NCj4NCj5PbiAyMDI0LzgvNSAxNDoyNywgWmhlbnpob25nIER1YW4gd3JvdGU6DQo+PiBG
cm9tOiBDbMOpbWVudCBNYXRoaWV1LS1EcmlmIDxjbGVtZW50Lm1hdGhpZXUtLWRyaWZAZXZpZGVu
LmNvbT4NCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBDbMOpbWVudCBNYXRoaWV1LS1EcmlmIDxjbGVt
ZW50Lm1hdGhpZXUtLWRyaWZAZXZpZGVuLmNvbT4NCj4+IFNpZ25lZC1vZmYtYnk6IFpoZW56aG9u
ZyBEdWFuIDx6aGVuemhvbmcuZHVhbkBpbnRlbC5jb20+DQo+PiAtLS0NCj4+ICAgaHcvaTM4Ni9p
bnRlbF9pb21tdV9pbnRlcm5hbC5oIHwgIDMgKysrDQo+PiAgIGh3L2kzODYvaW50ZWxfaW9tbXUu
YyAgICAgICAgICB8IDI0ICsrKysrKysrKysrKysrKysrKysrKysrKw0KPj4gICAyIGZpbGVzIGNo
YW5nZWQsIDI3IGluc2VydGlvbnMoKykNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvaHcvaTM4Ni9pbnRl
bF9pb21tdV9pbnRlcm5hbC5oDQo+Yi9ody9pMzg2L2ludGVsX2lvbW11X2ludGVybmFsLmgNCj4+
IGluZGV4IDY2ODU4M2FlY2EuLjc3ODZlZjc2MjQgMTAwNjQ0DQo+PiAtLS0gYS9ody9pMzg2L2lu
dGVsX2lvbW11X2ludGVybmFsLmgNCj4+ICsrKyBiL2h3L2kzODYvaW50ZWxfaW9tbXVfaW50ZXJu
YWwuaA0KPj4gQEAgLTMyNCw2ICszMjQsNyBAQCB0eXBlZGVmIGVudW0gVlRERmF1bHRSZWFzb24g
ew0KPj4NCj4+ICAgICAgIC8qIE91dHB1dCBhZGRyZXNzIGluIHRoZSBpbnRlcnJ1cHQgYWRkcmVz
cyByYW5nZSBmb3Igc2NhbGFibGUgbW9kZSAqLw0KPj4gICAgICAgVlREX0ZSX1NNX0lOVEVSUlVQ
VF9BRERSID0gMHg4NywNCj4+ICsgICAgVlREX0ZSX0ZTX0JJVF9VUERBVEVfRkFJTEVEID0gMHg5
MSwgLyogU0ZTLjEwICovDQo+PiAgICAgICBWVERfRlJfTUFYLCAgICAgICAgICAgICAgICAgLyog
R3VhcmQgKi8NCj4+ICAgfSBWVERGYXVsdFJlYXNvbjsNCj4+DQo+PiBAQCAtNTQ5LDYgKzU1MCw4
IEBAIHR5cGVkZWYgc3RydWN0IFZURFJvb3RFbnRyeSBWVERSb290RW50cnk7DQo+PiAgIC8qIE1h
c2tzIGZvciBGaXJzdCBMZXZlbCBQYWdpbmcgRW50cnkgKi8NCj4+ICAgI2RlZmluZSBWVERfRkxf
UCAgICAgICAgICAgICAgICAgICAgMVVMTA0KPj4gICAjZGVmaW5lIFZURF9GTF9SV19NQVNLICAg
ICAgICAgICAgICAoMVVMTCA8PCAxKQ0KPj4gKyNkZWZpbmUgVlREX0ZMX0EgICAgICAgICAgICAg
ICAgICAgIDB4MjANCj4+ICsjZGVmaW5lIFZURF9GTF9EICAgICAgICAgICAgICAgICAgICAweDQw
DQo+Pg0KPj4gICAvKiBTZWNvbmQgTGV2ZWwgUGFnZSBUcmFuc2xhdGlvbiBQb2ludGVyKi8NCj4+
ICAgI2RlZmluZSBWVERfU01fUEFTSURfRU5UUllfU0xQVFBUUiAgICAgKH4weGZmZlVMTCkNCj4+
IGRpZmYgLS1naXQgYS9ody9pMzg2L2ludGVsX2lvbW11LmMgYi9ody9pMzg2L2ludGVsX2lvbW11
LmMNCj4+IGluZGV4IDYxMjFjY2E0Y2QuLjNjMmNlZWQyODQgMTAwNjQ0DQo+PiAtLS0gYS9ody9p
Mzg2L2ludGVsX2lvbW11LmMNCj4+ICsrKyBiL2h3L2kzODYvaW50ZWxfaW9tbXUuYw0KPj4gQEAg
LTE4MjIsNiArMTgyMiw3IEBAIHN0YXRpYyBjb25zdCBib29sIHZ0ZF9xdWFsaWZpZWRfZmF1bHRz
W10gPSB7DQo+PiAgICAgICBbVlREX0ZSX1BBU0lEX1RBQkxFX0VOVFJZX0lOVl0gPSB0cnVlLA0K
Pj4gICAgICAgW1ZURF9GUl9TTV9JTlRFUlJVUFRfQUREUl0gPSB0cnVlLA0KPj4gICAgICAgW1ZU
RF9GUl9GU19OT05fQ0FOT05JQ0FMXSA9IHRydWUsDQo+PiArICAgIFtWVERfRlJfRlNfQklUX1VQ
REFURV9GQUlMRURdID0gdHJ1ZSwNCj4+ICAgICAgIFtWVERfRlJfTUFYXSA9IGZhbHNlLA0KPj4g
ICB9Ow0KPj4NCj4+IEBAIC0xOTM5LDYgKzE5NDAsMjAgQEAgc3RhdGljIGJvb2wNCj52dGRfaW92
YV9mbF9jaGVja19jYW5vbmljYWwoSW50ZWxJT01NVVN0YXRlICpzLCB1aW50NjRfdCBpb3ZhLA0K
Pj4gICAgICAgICAgICAgICApOw0KPj4gICB9DQo+Pg0KPj4gK3N0YXRpYyBNZW1UeFJlc3VsdCB2
dGRfc2V0X2ZsYWdfaW5fcHRlKGRtYV9hZGRyX3QgYmFzZV9hZGRyLA0KPnVpbnQzMl90IGluZGV4
LA0KPj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHVpbnQ2NF90IHB0
ZSwgdWludDY0X3QgZmxhZykNCj4+ICt7DQo+PiArICAgIGlmIChwdGUgJiBmbGFnKSB7DQo+PiAr
ICAgICAgICByZXR1cm4gTUVNVFhfT0s7DQo+PiArICAgIH0NCj4+ICsgICAgcHRlIHw9IGZsYWc7
DQo+PiArICAgIHB0ZSA9IGNwdV90b19sZTY0KHB0ZSk7DQo+PiArICAgIHJldHVybiBkbWFfbWVt
b3J5X3dyaXRlKCZhZGRyZXNzX3NwYWNlX21lbW9yeSwNCj4+ICsgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgYmFzZV9hZGRyICsgaW5kZXggKiBzaXplb2YocHRlKSwNCj4+ICsgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgJnB0ZSwgc2l6ZW9mKHB0ZSksDQo+PiArICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIE1FTVRYQVRUUlNfVU5TUEVDSUZJRUQpOw0KPg0KPkNhbiB3ZSBlbnN1cmUg
dGhpcyB3cml0ZSBpcyBhdG9taWM/IEEvRCBiaXQgc2V0dGluZyBzaG91bGQgYmUgYXRvbWljIGZy
b20NCj5ndWVzdCBwLm8udi4NCg0KWWVzLCB3aGF0IGFib3V0IGJlbG93Og0KDQpAQCAtMjA5Niw3
ICsyMDk2LDcgQEAgc3RhdGljIGludCB2dGRfaW92YV90b19mbHB0ZShJbnRlbElPTU1VU3RhdGUg
KnMsIFZURENvbnRleHRFbnRyeSAqY2UsDQogICAgIGRtYV9hZGRyX3QgYWRkciA9IHZ0ZF9nZXRf
aW92YV9wZ3RibF9iYXNlKHMsIGNlLCBwYXNpZCk7DQogICAgIHVpbnQzMl90IGxldmVsID0gdnRk
X2dldF9pb3ZhX2xldmVsKHMsIGNlLCBwYXNpZCk7DQogICAgIHVpbnQzMl90IG9mZnNldDsNCi0g
ICAgdWludDY0X3QgZmxwdGU7DQorICAgIHVpbnQ2NF90IGZscHRlLCBmbGFnX2FkID0gVlREX0ZM
X0E7DQoNCiAgICAgaWYgKCF2dGRfaW92YV9mbF9jaGVja19jYW5vbmljYWwocywgaW92YSwgY2Us
IHBhc2lkKSkgew0KICAgICAgICAgZXJyb3JfcmVwb3J0X29uY2UoIiVzOiBkZXRlY3RlZCBub24g
Y2Fub25pY2FsIElPVkEgKGlvdmE9MHglIiBQUkl4NjQgIiwiDQpAQCAtMjEzNCwxNiArMjEzNCwx
NSBAQCBzdGF0aWMgaW50IHZ0ZF9pb3ZhX3RvX2ZscHRlKEludGVsSU9NTVVTdGF0ZSAqcywgVlRE
Q29udGV4dEVudHJ5ICpjZSwNCiAgICAgICAgICAgICByZXR1cm4gLVZURF9GUl9QQUdJTkdfRU5U
UllfUlNWRDsNCiAgICAgICAgIH0NCg0KLSAgICAgICAgaWYgKHZ0ZF9zZXRfZmxhZ19pbl9wdGUo
YWRkciwgb2Zmc2V0LCBmbHB0ZSwgVlREX0ZMX0EpICE9IE1FTVRYX09LKSB7DQorICAgICAgICBp
ZiAodnRkX2lzX2xhc3RfcHRlKGZscHRlLCBsZXZlbCkgJiYgaXNfd3JpdGUpIHsNCisgICAgICAg
ICAgICBmbGFnX2FkIHw9IFZURF9GTF9EOw0KKyAgICAgICAgfQ0KKw0KKyAgICAgICAgaWYgKHZ0
ZF9zZXRfZmxhZ19pbl9wdGUoYWRkciwgb2Zmc2V0LCBmbHB0ZSwgZmxhZ19hZCkgIT0gTUVNVFhf
T0spIHsNCiAgICAgICAgICAgICByZXR1cm4gLVZURF9GUl9GU19CSVRfVVBEQVRFX0ZBSUxFRDsN
CiAgICAgICAgIH0NCg0KICAgICAgICAgaWYgKHZ0ZF9pc19sYXN0X3B0ZShmbHB0ZSwgbGV2ZWwp
KSB7DQotICAgICAgICAgICAgaWYgKGlzX3dyaXRlICYmDQotICAgICAgICAgICAgICAgICh2dGRf
c2V0X2ZsYWdfaW5fcHRlKGFkZHIsIG9mZnNldCwgZmxwdGUsIFZURF9GTF9EKSAhPQ0KLSAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgTUVNVFhfT0spKSB7DQotICAgICAgICAgICAgICAgICAgICByZXR1cm4gLVZURF9GUl9G
U19CSVRfVVBEQVRFX0ZBSUxFRDsNCi0gICAgICAgICAgICB9DQogICAgICAgICAgICAgKmZscHRl
cCA9IGZscHRlOw0KICAgICAgICAgICAgICpmbHB0ZV9sZXZlbCA9IGxldmVsOw0KICAgICAgICAg
ICAgIHJldHVybiAwOw0KDQpUaGFua3MNClpoZW56aG9uZw0KDQo=

