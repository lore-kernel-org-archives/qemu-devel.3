Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60466C25B74
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2024 06:42:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7UoM-0000rp-Kp; Thu, 16 May 2024 02:41:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1s7UoK-0000rh-Nu
 for qemu-devel@nongnu.org; Thu, 16 May 2024 02:41:53 -0400
Received: from mgamail.intel.com ([192.198.163.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1s7UoI-0001Zc-Be
 for qemu-devel@nongnu.org; Thu, 16 May 2024 02:41:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1715841710; x=1747377710;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=bHQss4CC8jB4qDJqeECvnPc7oc24FXnfA71bCZJv2kA=;
 b=cjXaDYOF/QWysMQkWTWb+v7uZk7KIEiic0X07hfaLwcg+qa1t82ar5FW
 ODZSBIBPijyj/M4Q+5WJnF3txzL9VTHr64wYNwTWduRNapZynEexg86M9
 ieLynLSZEX1EgUZJFPtzF4QR2hsDsetlexvZGxWTrC/fQIYYM1fljDytn
 R9fiO+VQSlC3eQtVic4zI3aUZFApzzgyJkgw4Upp39W1eg3sNaqMdCSPF
 VVhdw7JQUaY8JXdhF10VVckmOVgFHbcXkL5dPAdjfqM/pWNrqCc1goxZn
 DdJUv10GlS9FinuwRKL06oxGSRGU+3NuNrcCsIpCA+miuPuGaFrXESvt6 Q==;
X-CSE-ConnectionGUID: w79YjUmlTMqYUDKdlTac2w==
X-CSE-MsgGUID: 8rmhTRRvQP2ekr3G8J+3hg==
X-IronPort-AV: E=McAfee;i="6600,9927,11074"; a="22603383"
X-IronPort-AV: E=Sophos;i="6.08,163,1712646000"; d="scan'208";a="22603383"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 May 2024 23:41:47 -0700
X-CSE-ConnectionGUID: CcNy4c9AT+uzVhcNHIZy2w==
X-CSE-MsgGUID: 9bfaOhCvSUqSDu2O7itDTQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,163,1712646000"; d="scan'208";a="31246753"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
 by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 15 May 2024 23:41:47 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 15 May 2024 23:41:47 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 15 May 2024 23:41:46 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 15 May 2024 23:41:46 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 15 May 2024 23:41:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kWWXAxuQ48Y3Wlh6zdT5GAZCA2BHqxehwQ1215XLkrKW1poAYq5T1TXju9Xq4wFJ/x4uroWmWl22Si/LRA7U1g6Ycftxe043ilcK0csdA6jBXwT5C2zBS61Jhj4dZx7DzR+Dtmy7oChbphdaq+apuj4eV2sfmlw1wFcuA8uz3JK+bEcIk2v2EOvtu0FnHZhSCF0s+UZYKXEat5bokJ2r2+tFQy0eYYV+EyemIC0xlschHpoU/ueSS/KpXIzhc4aQCUIe5fUP1eR4dN2vdjB117hMJZkmJs4njO4J57AwR7Sfu07yBPQhCcUn93NZmGiAVGPCetosK1JvfFeu3Jendw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bHQss4CC8jB4qDJqeECvnPc7oc24FXnfA71bCZJv2kA=;
 b=D9fVvTeLngMLyv6D6qKkEJtpFH6qqicGq3m51m3F1NfL4KrkBz9ZFir0/HGFD9HuIlCFNXpi42cNwnCxu3uKBAaQMvBzZioyAec9n8+y3r4UoCIbW7UILLH66BiPJj1dJONWSrvd5wWgMW/pZQ8O7xHz31Nphx7YtbDtEYCkHpaWDSGkHYNb7k06vJ1GkZmKgbJ4xG5rPQHZaJAH4ThFd5vtS5viu/jR/CV/EI75tq8hkaPeIp1KDmMXtRyzV8Nr0Dl1Vh8GcVW7uD3nuiD/wKOLYLIWpGBZ3wj5siGqyXmHJpO7KI0rZvv5uuJ5fb7aFIqC5jpMnPMSEzQ13OWEqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by SJ1PR11MB6202.namprd11.prod.outlook.com (2603:10b6:a03:45b::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.27; Thu, 16 May
 2024 06:41:44 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::21df:af3:be1d:722e]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::21df:af3:be1d:722e%4]) with mapi id 15.20.7587.026; Thu, 16 May 2024
 06:41:44 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "jasowang@redhat.com" <jasowang@redhat.com>, "Tian, Kevin"
 <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>, "peterx@redhat.com"
 <peterx@redhat.com>
Subject: RE: [PATCH ats_vtd v1 03/24] intel_iommu: check if the input address
 is canonical
Thread-Topic: [PATCH ats_vtd v1 03/24] intel_iommu: check if the input address
 is canonical
Thread-Index: AQHanKWOQU2WFAm+Q0y7GUlKu/g4H7GWZVqQgAGMUACAAYx0wA==
Date: Thu, 16 May 2024 06:41:44 +0000
Message-ID: <SJ0PR11MB674436B8BD9BB87C0BCC0CC692ED2@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20240502152810.187492-1-clement.mathieu--drif@eviden.com>
 <20240502152810.187492-4-clement.mathieu--drif@eviden.com>
 <SJ0PR11MB67440FA8BFCC383E6606866B92E32@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <7418b16d-c380-4006-b3d5-26c70e2db515@eviden.com>
In-Reply-To: <7418b16d-c380-4006-b3d5-26c70e2db515@eviden.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|SJ1PR11MB6202:EE_
x-ms-office365-filtering-correlation-id: 2af0dfe6-76ff-4f9e-537c-08dc757340d3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|366007|376005|1800799015|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?bGhNYXlJei9KNlpqemFaQW9TVEZtRTNHY2RWYUltSTRlZld1dW45WXJSc044?=
 =?utf-8?B?b1IrMkNqM1UwekxOUzM4dnAvSnpOWHplVG44TWprTllRdFNYclRIWEI1N2Mr?=
 =?utf-8?B?a2dMRXdGQjZiNEpQTXVzMGVROWJpMzN3amJrMVp2R00vZ01jRXZsZFdva0xC?=
 =?utf-8?B?UG5vM1ZZYnVZWmRGTGtiS1JybUU3UG12VHJYcDFqd3RRSzUvL05yWnloRTlw?=
 =?utf-8?B?OEE5c0wwZEVidXJwRXRWSExUREJLbEMyOGRkWWMreG9xOEZHK2NiNzNLOGRv?=
 =?utf-8?B?dnUzOWVDeHZoaVo4S25DVHZUZjZlbVo5TzhpNjZIRVIwc1Rld0FtMzNqSEFw?=
 =?utf-8?B?ekxMaEFEMWkrUzc5U3E2QXdoZ2QyZjBNQWFydk95dm14Q1hETHl4WmRXQVN3?=
 =?utf-8?B?RWtmM3BCZUFVcSt1RER0dzFqd05wb1ZDcjJRa0Z0Q1RJaGRjTVhwS29sRWU0?=
 =?utf-8?B?VThmYjVQaytxVDMrL3c1SlM1ejNwejZXVG1mK2k2L01mOHhDZW5mZEtjNW1C?=
 =?utf-8?B?OC8reWl4Wkt3Z29xclRPVi83KzVWOTd6YU5XOVpWSFJVeTN1TjVhMGJ1Yysr?=
 =?utf-8?B?L1pyU3hWTk9Ja1EzUGhPTTFUTFBxNUVRakJLV2FEODdxTXhRdWRGbU1zdmt5?=
 =?utf-8?B?SU92RVlRS2V3YjloU1YwV0VlV3NVWVZ0bjRTNm9GZjBjUzNpTmRJcFh4a1lC?=
 =?utf-8?B?bzJuZGFUZTQ4VkVxenRpTmJEd0R0WHRHNmk2dWx3eUlvVi9LRjExS2dUTUNL?=
 =?utf-8?B?QTJNSUkxQU5qZURJaWR2R0JQNFJxNWVDV2pJenQ2bWRjSHpiL0pIb1p0RWNF?=
 =?utf-8?B?Y0VOdC9RRHYrU1E0UE1UOUh1VTdJUG56VVdjRy9NbnhzRmI5Vng2SVdydWNF?=
 =?utf-8?B?M1pELzNhN05EQlRESlY3dnMyK3RoRWM5WkU2eEIxWEw5WDdBRjdrR3hMK1Ev?=
 =?utf-8?B?eEV2bDdTTlp0MFpJQUhJUVZUYWpGM3FVZTVrcjhaK3gwMVB6enZmdHVxRWdW?=
 =?utf-8?B?WU1JeGpCY2R2aHU0Y0QyZE1pRi9Xd3dLckpJeDVsVVBoY3AyTEhSMUNjRlNp?=
 =?utf-8?B?SVNERnhaRmlJQjB4TWVrVDFCY0dIdGxlS1Z6QUtkQmJ3N1IyV3JKZ1dmcThW?=
 =?utf-8?B?ZDZZOTRVYWQwODZpMXMyZldmVnVUZXFJQmNWY081dXVvVHFnOGFzSndlc09V?=
 =?utf-8?B?N3JlRnY0SU1LQ2tSUFFiblhkQ1A3Y3c1UFJXb1JxYUhKZDdEYW0rakY3NFJP?=
 =?utf-8?B?R3pmY2JCRnZlM3QyclN1VlVHaUNQT0gxSGdSYnoxckt1bGlrUzRjYkE4VGpO?=
 =?utf-8?B?NzdXeE5QOVZqaE5FSUhPZVBEK21idnk5bThPaldCS3RlSUJXektSK2E4TEU2?=
 =?utf-8?B?MW9QdzgrSm0xSjdLdUo4QXNPN1hMbGxrTVBINGsyTndTY09vLzRRSXVJeDI3?=
 =?utf-8?B?YytieExiQytuZ28vaDU0Qm9XRGo0Ti9VSWhZd05MNmRXZjRDRXVqdUFOYk5M?=
 =?utf-8?B?YzBYRGhUMFg3QTF1NThtek9TQmJIb2ovSVptazgzWjh2WkVSSUdTV2t6bjh2?=
 =?utf-8?B?dTk3TVJ1cWFHTTRiNHZHQXdncUpSaHRSVDlBcnFXT3U1U05vZURsUmNtVVpS?=
 =?utf-8?B?bVFpYmJQcDkyRFNjb0hQYm53dDhqU1FIVy9SOGk4QUVoQWlxLytBNFdGa0Zp?=
 =?utf-8?B?Q1FkNEMvZmRIMW5CRkxCV3NLdlRMNC9mRzNVUlFJNFptOU4xM3pOV0huc01L?=
 =?utf-8?B?YXRTb3dYMldxcEJPMjRxYUJiVEZDSXY3NDY3dVRUZ1AvaUl0TUdUNUVRSnlT?=
 =?utf-8?B?Y2d0NW5xNWQrNUUwK0tQdz09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(1800799015)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OUlYM3F4dmZoM2dQTTdzalFQZkptZ0VWUjVyRGdzNFlJaTR2ODBRdHF3cnda?=
 =?utf-8?B?WFhZRzlWdFhiSFY3REd3UTN6U3dPelBKOUw0SERaMEhoZEZNaGdsZTB1QUw1?=
 =?utf-8?B?a0RPUGw0aEFQc2Y4VkQydFlJbkJkZm8xS0Y3dlBma21QMGIwZVgweGpsdGxS?=
 =?utf-8?B?eG5NSFNQb2xNSDB3LzJ1a0dXNXlST2pxRjBtS2Nod1JtSXhPWDRYRGt5U1Bp?=
 =?utf-8?B?aXlHNzRnYVFRNmpEVzlGME5hVXYwZnlJR096SGRQeENJci80Q1ZVSjNIQkhY?=
 =?utf-8?B?R05WcmQwdjZsWEo1WkN6N3ZLMDU5MEJZS0pScEVRUFZlT3o3cUtrQzRrYTlI?=
 =?utf-8?B?WlI0cktPOVY0S3JYaVlFaWFlQnNuWmpmRFJOazljTlh4bjZTTnZCMDBiRU5X?=
 =?utf-8?B?WGFCejdIeUd5MW1TNmVtenB5Mjg3aU0xRGxUVmZ2bVo1L3lqdTNIK1hRaE1k?=
 =?utf-8?B?b0d0OEpPOVNaZDVOQjJMYUxORVdnUFR3eTVZZ2wvOXZQWE9kK0RDQXFXSnVH?=
 =?utf-8?B?a2pQc2l1MkpmRWsrS00wUi9Qb1c5eVBoMWt4dVNCTU9oVzd0cXV0QndQKzQ3?=
 =?utf-8?B?VExrVFJadmRYcXlrV21uOGNWU1RZb3FDdFoxSXZHSnJxeHBmQ3JqU3UyUFhT?=
 =?utf-8?B?VExXZCtSeTZIOGxmQ0pMVmUwWGF3NHdnTHpsbzQ0a2NoUEsxN3hDYjVWT3hJ?=
 =?utf-8?B?TGtTL3ErNDBIOEJaNWJRQ0lDYmVXaFpNdktLN3daSHl0MDd3dFBTdUNJQm9S?=
 =?utf-8?B?YjhMMUYwSjdBdTlyaDVYOGtlazFqYlJtZkZrb3lxc1dSZDZucE1ieFQ1Wk5Z?=
 =?utf-8?B?VG5BcXRPRUU0bS9TVFhOdEc0Z1ZYdG5zWDNlQWZyRDU1OHF2QmsyY3BNNUFk?=
 =?utf-8?B?TklLbjNZamhFTjFhRU4zbU5aeFl1ZDRKSEptRFB0eWRqM1U2d2IvVWRyTStD?=
 =?utf-8?B?eXEwSEsxQ21NNU95dzB3a2UyUVJGVkVHNWFTNFZESmtQMzRZbXUvQ1QrQUY4?=
 =?utf-8?B?bXBQTm8yYzQzYTVnZVY5cXVJdXhLNTFSQWxMcXNTQmxKR1FuaURDOVBpVFZ2?=
 =?utf-8?B?YlJFclJ4VUM0VmNaKy85d2w1QmxOaU1ENThVc1FYeDNtZTNVT05kSzJRMjhm?=
 =?utf-8?B?dDlSTHVILzd1RytOTDZvUmdHSGJmYUQ1OGhoaWlJVDBWYWZpOUkxRVhicUxM?=
 =?utf-8?B?OGJQcU1HcjdEbUxYOTRkc0FNK0l5cHlHZzBQVzViTmhCWS9TQUxiN1BjUVE0?=
 =?utf-8?B?Vy9wb0ExNVlycm1yV0lmN1BFa3hCR3ZFYWtYdVdHNFpRRTlVQzdJbVd0YVBS?=
 =?utf-8?B?THArK3dNcFlBVHp1TklrTXZyVTcxTUNXd1BhU1U0T1o4Q2Y5a0tnNUNiOW1O?=
 =?utf-8?B?cjBhZXVHZTVRVXZHaElJWE5PaHFqclZKVEM2aFpqbTlTMmZueGpmdTA3M3Z1?=
 =?utf-8?B?NHF6RmR1NkhUSE1iaUlOaDVSOEpDVXNTT09EZThWSUhQZzlMRWhkcURHd0JJ?=
 =?utf-8?B?MVJuOTJBQVlCc2RsM09xQ1lkM2RPQW5EMnJWbi9tSzhZNFZWblU1N0ZtSEtL?=
 =?utf-8?B?ak1sR0NjUkxldTZQNVE1TGY5SU90K2FNWkZxZlE1aHRDZWZwK3I3ejNkZ2w2?=
 =?utf-8?B?VmNuR0dJbnJ0VzJ4allSMkxYVlFNeVFYeGVNdSs3TE9Cb3ZKMldycFgwQS9y?=
 =?utf-8?B?YTVyL2ZiSXJLT25ZK0JmYVlzRFB0SnFQRWxHckhoeGs2VWYvSFZLclhZZ0NY?=
 =?utf-8?B?TnVYd0lZRXZWVXdhMHVDWi9JYTI2NkY3L0VUUURtM2x5MDNMZzBJR3hYcklS?=
 =?utf-8?B?U1FTWkVEbmJXN2NzdExPdWc1S3dCVzMrRmZDYzZEcHFqWGpObCtYeHFGT3dh?=
 =?utf-8?B?M3NpSHg5NHFQeDhtdFpYNE81dURNeUpRN0tOeWdNV1BMUUg5eGVxeGRSLzBh?=
 =?utf-8?B?LzNUVHlwaTFZdmhXc2NPaisyMFdCUmh5RUQ2S1Z5ajRkck9ubHZPYndCM0dQ?=
 =?utf-8?B?QlNQOFpoTml3b1grb3A1TGZJVjROZmRNNnQ1SzdxZVRvZmxiZzgrS2RscFFz?=
 =?utf-8?B?eXhNbUJ4RUlHQWxOUDg1MEdFTjNpUlc2UTRoNEJHOUNJSUwrOHRsYzdPVlhK?=
 =?utf-8?Q?JwshntCtlj5oV/k7Rj33ewXp0?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2af0dfe6-76ff-4f9e-537c-08dc757340d3
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 May 2024 06:41:44.8700 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sHAJqlbEKbM1pxPfTIBV/303kgRDGvX7ehm0LuKJf6TUou873ZBQiABP7Cl1TRo1G4wbp8Af3RmdgVabFuW8rL49MayFqWktx/sdITbCRCA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR11MB6202
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.9;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -52
X-Spam_score: -5.3
X-Spam_bar: -----
X-Spam_report: (-5.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.935,
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IENMRU1FTlQgTUFUSElFVS0t
RFJJRiA8Y2xlbWVudC5tYXRoaWV1LS1kcmlmQGV2aWRlbi5jb20+DQo+U3ViamVjdDogUmU6IFtQ
QVRDSCBhdHNfdnRkIHYxIDAzLzI0XSBpbnRlbF9pb21tdTogY2hlY2sgaWYgdGhlIGlucHV0DQo+
YWRkcmVzcyBpcyBjYW5vbmljYWwNCj4NCj5IaSB6aGVuemhvbmcsDQo+DQo+T24gMTQvMDUvMjAy
NCAwOTozNCwgRHVhbiwgWmhlbnpob25nIHdyb3RlOg0KPj4gQ2F1dGlvbjogRXh0ZXJuYWwgZW1h
aWwuIERvIG5vdCBvcGVuIGF0dGFjaG1lbnRzIG9yIGNsaWNrIGxpbmtzLCB1bmxlc3MgdGhpcw0K
PmVtYWlsIGNvbWVzIGZyb20gYSBrbm93biBzZW5kZXIgYW5kIHlvdSBrbm93IHRoZSBjb250ZW50
IGlzIHNhZmUuDQo+Pg0KPj4NCj4+IEhpIENsZW1lbnQsDQo+Pg0KPj4+IC0tLS0tT3JpZ2luYWwg
TWVzc2FnZS0tLS0tDQo+Pj4gRnJvbTogQ0xFTUVOVCBNQVRISUVVLS1EUklGIDxjbGVtZW50Lm1h
dGhpZXUtLWRyaWZAZXZpZGVuLmNvbT4NCj4+PiBTdWJqZWN0OiBbUEFUQ0ggYXRzX3Z0ZCB2MSAw
My8yNF0gaW50ZWxfaW9tbXU6IGNoZWNrIGlmIHRoZSBpbnB1dA0KPmFkZHJlc3MNCj4+PiBpcyBj
YW5vbmljYWwNCj4+Pg0KPj4+IEZpcnN0IHN0YWdlIHRyYW5zbGF0aW9uIG11c3QgZmFpbCBpZiB0
aGUgYWRkcmVzcyB0byB0cmFuc2xhdGUgaXMNCj4+PiBub3QgY2Fub25pY2FsLg0KPj4+DQo+Pj4g
U2lnbmVkLW9mZi1ieTogQ2zDqW1lbnQgTWF0aGlldS0tRHJpZiA8Y2xlbWVudC5tYXRoaWV1LS0N
Cj5kcmlmQGV2aWRlbi5jb20+DQo+Pj4gLS0tDQo+Pj4gaHcvaTM4Ni9pbnRlbF9pb21tdS5jICAg
ICAgICAgIHwgMjIgKysrKysrKysrKysrKysrKysrKysrKw0KPj4+IGh3L2kzODYvaW50ZWxfaW9t
bXVfaW50ZXJuYWwuaCB8ICAyICsrDQo+Pj4gMiBmaWxlcyBjaGFuZ2VkLCAyNCBpbnNlcnRpb25z
KCspDQo+Pj4NCj4+PiBkaWZmIC0tZ2l0IGEvaHcvaTM4Ni9pbnRlbF9pb21tdS5jIGIvaHcvaTM4
Ni9pbnRlbF9pb21tdS5jDQo+Pj4gaW5kZXggODBjZGYzNzg3MC4uMjQwZWNiOGY3MiAxMDA2NDQN
Cj4+PiAtLS0gYS9ody9pMzg2L2ludGVsX2lvbW11LmMNCj4+PiArKysgYi9ody9pMzg2L2ludGVs
X2lvbW11LmMNCj4+PiBAQCAtMTkxMiw2ICsxOTEyLDcgQEAgc3RhdGljIGNvbnN0IGJvb2wgdnRk
X3F1YWxpZmllZF9mYXVsdHNbXSA9IHsNCj4+PiAgICAgIFtWVERfRlJfUEFTSURfRU5UUllfUF0g
PSB0cnVlLA0KPj4+ICAgICAgW1ZURF9GUl9QQVNJRF9UQUJMRV9FTlRSWV9JTlZdID0gdHJ1ZSwN
Cj4+PiAgICAgIFtWVERfRlJfU01fSU5URVJSVVBUX0FERFJdID0gdHJ1ZSwNCj4+PiArICAgIFtW
VERfRlJfRlNfTk9OX0NBTk9OSUNBTF0gPSB0cnVlLA0KPj4+ICAgICAgW1ZURF9GUl9NQVhdID0g
ZmFsc2UsDQo+Pj4gfTsNCj4+Pg0KPj4+IEBAIC0yMDIzLDYgKzIwMjQsMjEgQEAgc3RhdGljIGlu
bGluZSB1aW50NjRfdA0KPj4+IHZ0ZF9nZXRfZmxwdGVfYWRkcih1aW50NjRfdCBmbHB0ZSwgdWlu
dDhfdCBhdykNCj4+PiAgICAgIHJldHVybiBmbHB0ZSAmIFZURF9GTF9QVF9CQVNFX0FERFJfTUFT
Syhhdyk7DQo+Pj4gfQ0KPj4+DQo+Pj4gKy8qIFJldHVybiB0cnVlIGlmIElPVkEgaXMgY2Fub25p
Y2FsLCBvdGhlcndpc2UgZmFsc2UuICovDQo+Pj4gK3N0YXRpYyBib29sIHZ0ZF9pb3ZhX2ZsX2No
ZWNrX2Nhbm9uaWNhbChJbnRlbElPTU1VU3RhdGUgKnMsDQo+Pj4gKyAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICB1aW50NjRfdCBpb3ZhLCBWVERDb250ZXh0RW50cnkgKmNl
LA0KPj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdWludDhfdCBh
dywgdWludDMyX3QgcGFzaWQpDQo+Pj4gK3sNCj4+PiArICAgIHVpbnQ2NF90IGlvdmFfbGltaXQg
PSB2dGRfaW92YV9saW1pdChzLCBjZSwgYXcsIHBhc2lkKTsNCj4+IEFjY29yZGluZyB0byBzcGVj
Og0KPj4NCj4+ICJJbnB1dC1hZGRyZXNzIGluIHRoZSByZXF1ZXN0IHN1YmplY3RlZCB0byBmaXJz
dC1zdGFnZSB0cmFuc2xhdGlvbiBpcyBub3QNCj4+IGNhbm9uaWNhbCAoaS5lLiwgYWRkcmVzcyBi
aXRzIDYzOk4gYXJlIG5vdCBzYW1lIHZhbHVlIGFzIGFkZHJlc3MgYml0cyBbTi0NCj4+IDFdLCB3
aGVyZSBOIGlzIDQ4IGJpdHMgd2l0aCA0LWxldmVsIHBhZ2luZyBhbmQgNTcgYml0cyB3aXRoIDUt
bGV2ZWwgcGFnaW5nKS4iDQo+Pg0KPj4gU28gaXQgbG9va3Mgbm90IGNvcnJlY3QgdG8gdXNlIGF3
IGZpbGVkIGluIHBhc2lkIGVudHJ5IHRvIGNhbGN1bGF0ZSBpb3ZhX2xpbWl0Lg0KPj4gQXcgY2Fu
IGJlIGEgdmFsdWUgY29uZmlndXJlZCBieSBndWVzdCBhbmQgaXQncyB1c2VkIGZvciBzdGFnZS0y
IHRhYmxlLiBTZWUNCj5zcGVjOg0KPj4NCj4+ICIgVGhpcyBmaWVsZCBpcyB0cmVhdGVkIGFzIFJl
c2VydmVkKDApIGZvciBpbXBsZW1lbnRhdGlvbnMgbm90IHN1cHBvcnRpbmcNCj5TZWNvbmQtc3Rh
Z2UNCj4+IFRyYW5zbGF0aW9uIChTU1RTPTAgaW4gdGhlIEV4dGVuZGVkIENhcGFiaWxpdHkgUmVn
aXN0ZXIpLg0KPj4gVGhpcyBmaWVsZCBpbmRpY2F0ZXMgdGhlIGFkanVzdGVkIGd1ZXN0LWFkZHJl
c3Mtd2lkdGggKEFHQVcpIHRvIGJlIHVzZWQgYnkNCj5oYXJkd2FyZQ0KPj4gZm9yIHNlY29uZC1z
dGFnZSB0cmFuc2xhdGlvbiB0aHJvdWdoIHBhZ2luZyBzdHJ1Y3R1cmVzIHJlZmVyZW5jZWQgdGhy
b3VnaA0KPnRoZQ0KPj4gU1NQVFBUUiBmaWVsZC4NCj4+IOKAoiBUaGUgZm9sbG93aW5nIGVuY29k
aW5ncyBhcmUgZGVmaW5lZCBmb3IgdGhpcyBmaWVsZDoNCj4+IOKAoiAwMDFiOiAzOS1iaXQgQUdB
VyAoMy1sZXZlbCBwYWdlIHRhYmxlKQ0KPj4g4oCiIDAxMGI6IDQ4LWJpdCBBR0FXICg0LWxldmVs
IHBhZ2UgdGFibGUpDQo+PiDigKIgMDExYjogNTctYml0IEFHQVcgKDUtbGV2ZWwgcGFnZSB0YWJs
ZSkNCj4+IOKAoiAwMDBiLDEwMGItMTExYjogUmVzZXJ2ZWQNCj4+IFdoZW4gbm90IHRyZWF0ZWQg
YXMgUmVzZXJ2ZWQoMCksIGhhcmR3YXJlIGlnbm9yZXMgdGhpcyBmaWVsZCBmb3IgZmlyc3QtDQo+
c3RhZ2Utb25seQ0KPj4gKFBHVFQ9MDAxYikgYW5kIHBhc3MtdGhyb3VnaCAoUEdUVD0xMDBiKSB0
cmFuc2xhdGlvbnMuIg0KPj4NCj4+IFRoYW5rcw0KPj4gWmhlbnpob25nDQo+Pg0KPk5vdCBzdXJl
IHRvIHVuZGVyc3RhbmQuDQo+QXJlIHlvdSB0YWxraW5nIGFib3V0IHRoZSBhdyBmaWVsZCBvZiBT
Y2FsYWJsZS1Nb2RlIFBBU0lEIFRhYmxlIEVudHJ5Pw0KWWVzLg0KDQo+VGhlIGF3IHBhcmFtZXRl
ciBpcyBzZXQgdG8gcy0+YXdfYml0cyBpbiB2dGRfZG9faW9tbXVfdHJhbnNsYXRlIHNvIEkNCj50
aGluayBpdCdzIHNhZmUgdG8gdXNlIGl0IGZvciBjYW5vbmljYWwgYWRkcmVzcyBjaGVjay4NCj5N
YXliZSB3ZSBjYW4ganVzdCB1c2Ugcy0+YXdfYml0cyBkaXJlY3RseSBmcm9tDQo+dnRkX2lvdmFf
ZmxfY2hlY2tfY2Fub25pY2FsIHRvIGF2b2lkIGFueSBtaXN0YWtlPw0KQWdhdyBjYW4gYmUgZGlm
ZmVyZW50IGZyb20gcy0+YXdfYml0cy4NClllcywgSSB0aGluayB1c2luZyBzLT5hd19iaXRzIGlz
IHNhZmUuDQoNClRoYW5rcw0KWmhlbnpob25nDQoNCj4+PiArICAgIHVpbnQ2NF90IHVwcGVyX2Jp
dHNfbWFzayA9IH4oaW92YV9saW1pdCAtIDEpOw0KPj4+ICsgICAgdWludDY0X3QgdXBwZXJfYml0
cyA9IGlvdmEgJiB1cHBlcl9iaXRzX21hc2s7DQo+Pj4gKyAgICBib29sIG1zYiA9ICgoaW92YSAm
IChpb3ZhX2xpbWl0ID4+IDEpKSAhPSAwKTsNCj4+PiArICAgIHJldHVybiAhKA0KPj4+ICsgICAg
ICAgICAgICAgKCFtc2IgJiYgKHVwcGVyX2JpdHMgIT0gMCkpIHx8DQo+Pj4gKyAgICAgICAgICAg
ICAobXNiICYmICh1cHBlcl9iaXRzICE9IHVwcGVyX2JpdHNfbWFzaykpDQo+Pj4gKyAgICAgICAg
ICAgICk7DQo+Pj4gK30NCj4+PiArDQo+Pj4gLyoNCj4+PiAgICogR2l2ZW4gdGhlIEBpb3ZhLCBn
ZXQgcmVsZXZhbnQgQGZscHRlcC4gQGZscHRlX2xldmVsIHdpbGwgYmUgdGhlIGxhc3QNCj5sZXZl
bA0KPj4+ICAgKiBvZiB0aGUgdHJhbnNsYXRpb24sIGNhbiBiZSB1c2VkIGZvciBkZWNpZGluZyB0
aGUgc2l6ZSBvZiBsYXJnZSBwYWdlLg0KPj4+IEBAIC0yMDM4LDYgKzIwNTQsMTIgQEAgc3RhdGlj
IGludA0KPnZ0ZF9pb3ZhX3RvX2ZscHRlKEludGVsSU9NTVVTdGF0ZSAqcywNCj4+PiBWVERDb250
ZXh0RW50cnkgKmNlLA0KPj4+ICAgICAgdWludDMyX3Qgb2Zmc2V0Ow0KPj4+ICAgICAgdWludDY0
X3QgZmxwdGU7DQo+Pj4NCj4+PiArICAgIGlmICghdnRkX2lvdmFfZmxfY2hlY2tfY2Fub25pY2Fs
KHMsIGlvdmEsIGNlLCBhd19iaXRzLCBwYXNpZCkpIHsNCj4+PiArICAgICAgICBlcnJvcl9yZXBv
cnRfb25jZSgiJXM6IGRldGVjdGVkIG5vbiBjYW5vbmljYWwgSU9WQSAoaW92YT0weCUiDQo+Pj4g
UFJJeDY0ICIsIg0KPj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICJwYXNpZD0weCUiIFBS
SXgzMiAiKSIsIF9fZnVuY19fLCBpb3ZhLCBwYXNpZCk7DQo+Pj4gKyAgICAgICAgcmV0dXJuIC1W
VERfRlJfRlNfTk9OX0NBTk9OSUNBTDsNCj4+PiArICAgIH0NCj4+PiArDQo+Pj4gICAgICB3aGls
ZSAodHJ1ZSkgew0KPj4+ICAgICAgICAgIG9mZnNldCA9IHZ0ZF9pb3ZhX2ZsX2xldmVsX29mZnNl
dChpb3ZhLCBsZXZlbCk7DQo+Pj4gICAgICAgICAgZmxwdGUgPSB2dGRfZ2V0X2ZscHRlKGFkZHIs
IG9mZnNldCk7DQo+Pj4gZGlmZiAtLWdpdCBhL2h3L2kzODYvaW50ZWxfaW9tbXVfaW50ZXJuYWwu
aA0KPj4+IGIvaHcvaTM4Ni9pbnRlbF9pb21tdV9pbnRlcm5hbC5oDQo+Pj4gaW5kZXggOTAxNjkx
YWZiOS4uZTk0NDgyOTFhNCAxMDA2NDQNCj4+PiAtLS0gYS9ody9pMzg2L2ludGVsX2lvbW11X2lu
dGVybmFsLmgNCj4+PiArKysgYi9ody9pMzg2L2ludGVsX2lvbW11X2ludGVybmFsLmgNCj4+PiBA
QCAtMzI0LDYgKzMyNCw4IEBAIHR5cGVkZWYgZW51bSBWVERGYXVsdFJlYXNvbiB7DQo+Pj4gICAg
ICBWVERfRlJfUEFTSURfRU5UUllfUCA9IDB4NTksIC8qIFRoZSBQcmVzZW50KFApIGZpZWxkIG9m
IHBhc2lkdC0NCj5lbnRyeSBpcw0KPj4+IDAgKi8NCj4+PiAgICAgIFZURF9GUl9QQVNJRF9UQUJM
RV9FTlRSWV9JTlYgPSAweDViLCAgLypJbnZhbGlkIFBBU0lEIHRhYmxlIGVudHJ5DQo+Ki8NCj4+
Pg0KPj4+ICsgICAgVlREX0ZSX0ZTX05PTl9DQU5PTklDQUwgPSAweDgwLCAvKiBTTkcuMSA6IEFk
ZHJlc3MgZm9yIEZTIG5vdA0KPj4+IGNhbm9uaWNhbC4qLw0KPj4+ICsNCj4+PiAgICAgIC8qIE91
dHB1dCBhZGRyZXNzIGluIHRoZSBpbnRlcnJ1cHQgYWRkcmVzcyByYW5nZSBmb3Igc2NhbGFibGUg
bW9kZSAqLw0KPj4+ICAgICAgVlREX0ZSX1NNX0lOVEVSUlVQVF9BRERSID0gMHg4NywNCj4+PiAg
ICAgIFZURF9GUl9NQVgsICAgICAgICAgICAgICAgICAvKiBHdWFyZCAqLw0KPj4+IC0tDQo+Pj4g
Mi40NC4wDQo=

