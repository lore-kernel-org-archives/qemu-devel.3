Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61797C3DA59
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2024 04:27:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUfD0-0006vJ-EO; Fri, 19 Jul 2024 00:27:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1sUfCz-0006ud-5q
 for qemu-devel@nongnu.org; Fri, 19 Jul 2024 00:27:05 -0400
Received: from smarthost3.eviden.com ([80.78.11.84])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1sUfCw-0006jr-SI
 for qemu-devel@nongnu.org; Fri, 19 Jul 2024 00:27:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1721363223; x=1752899223;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=tUt01f6/CueE5JnmLsMnAO/k+jJLJGdZMapxV9PGPIk=;
 b=EDmOYIOuS7p6xNKdKcJz3jSWFHc5zT1Sk0yIQF6sMoyF+pZ4fWcWAS2v
 P5WbbbK0HEyPCvzQMTJ9wx5uwExrpnzGe9btY3iV1gpPTM+YXrGFvHMJT
 CKP8x+7mS31Uj3x+NHLeKmi30YVi6OK86tdhRehFg2OdzByDoqkhZS7zy
 ZcrdV/I9CnKMiRaC1FKNJ2EHdt4saZXW9zuN9mGfzGCEWuQhSxCumQlpw
 TghyQRiuLGeFzE5UR2j9xHKRLsnxM+pxmshTblcBHtrqv1HZ4TTtLV/RH
 YToppF7xYqwOhxir0/DsGArHwQGhZqUxQREP9ahCQBkb+gqCYBMT6Yot+ Q==;
X-IronPort-AV: E=Sophos;i="6.09,219,1716242400"; d="scan'208";a="16788023"
X-MGA-submission: =?us-ascii?q?MDGiJAtt2CeLUgp4+0Cg+p0cF0Nh1l00WY6RZ8?=
 =?us-ascii?q?1/8fobF/uzOdYv6samuozQOo5Ssk2Og8/TDOCzVeK4bLb3fieKbTSSel?=
 =?us-ascii?q?Ko9B0f9z3v8o1A6tmdR2SjhuWjnzFqitTJ1ZUz8gjEhaOWLNVw7qRL5z?=
 =?us-ascii?q?Kna2RstbnrlOukQ0rpTlqj/Q=3D=3D?=
Received: from mail-dbaeur03lp2169.outbound.protection.outlook.com (HELO
 EUR03-DBA-obe.outbound.protection.outlook.com) ([104.47.51.169])
 by smarthost3.eviden.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Jul 2024 06:27:00 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gJ6rOtTh3seD1IQXvpTqsUT8a3DxD6UJlNVyCzdboezrzcHgUsAmlX8Gk6wXtycMmCcS5ol26BzEFvTSwDpcM8aq3ri8m0cpg8Xze45Y0yHzrn6k5RKNd/Fj81PLc/JsxjQCki0FV78akVKzUDaEGXq70c58D+7mwVDbsDk70ved4pGIFA1Ufo+sOcCw4km5zg0iy1L2XHn6G+Z8SQyJH2EDoLycxUfhGJkTSOkWlIRmz7Ze7njl/i76JvVavcRTYvRhifesBu0p7hteBbR2haV24xwTVnq89sdhnnlw4cSHe5fpUFAzZOnG/0WbBoPAbQRz+GO7LcrR2Lpv0pDpIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tUt01f6/CueE5JnmLsMnAO/k+jJLJGdZMapxV9PGPIk=;
 b=ruDqhxI2PXSYSm84CBX7sGfXYs1m+g5tgOaI87XtRiKVQ9/z/9P8pLUkSdUspsOpH0wRm/gabkrNu/CSbLJ5FrJlgNGv7eD0XTfFiqU/n+Y0Fl9VHlXdxTfWUf0jB4jGlJGP5iqZNn4OU9M1p8Tslls+I1bCVXIwGWQYFKJge+w9lXmQdkzz+dJX4Z8g4sAyHV8mGKTOuqF2Ytg4HSPYtmx7DcWpwhpC4lkw4L6tAufaJ4xAZpaijhWVp7uldHbllYik8Y4x5yXKFrt9UQmYZdl9zVo/Ft94MNcDf/nSr1XjcFp7DeZI2VDlPwPAOBsPRl1VUXFONnP3xy++grOsBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Eviden.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tUt01f6/CueE5JnmLsMnAO/k+jJLJGdZMapxV9PGPIk=;
 b=ix+nmVNnC5qDXrbtBASGdaHfMuB6NhkdReWp73iyYSpsU7GaoXhzZedmSjCgaPtvx1QEwA+bDG5B1uewGi5Ulhe80o/+ycAN90JCtE+HKVqnXl8I8/eHDT0c7hkz7IQIGst+yXKjfJF6iVPtNKG67DiJJySuBbSyoybh5ik5++R4/GHuoANR5/KS1wcxgRHLZ5r1emWqNgWcy4Trv42XEkuKKZXT7vu624B6oRE9vjVaRl30EPIYP0ZILmJSNgV/lKiz5ZlKlFshk5xTa4/gQ/g72t0EqQXHg3RnbsveECzBjgsgoTI2ZAqKsSaoIJsS59Y+CMi/YRZ3T/OhxVG+pA==
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by PA1PR07MB10161.eurprd07.prod.outlook.com (2603:10a6:102:480::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.16; Fri, 19 Jul
 2024 04:26:59 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%6]) with mapi id 15.20.7784.016; Fri, 19 Jul 2024
 04:26:59 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>, "Liu, Yi L"
 <yi.l.liu@intel.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>, "eric.auger@redhat.com"
 <eric.auger@redhat.com>, "mst@redhat.com" <mst@redhat.com>,
 "peterx@redhat.com" <peterx@redhat.com>, "jasowang@redhat.com"
 <jasowang@redhat.com>, "jgg@nvidia.com" <jgg@nvidia.com>,
 "nicolinc@nvidia.com" <nicolinc@nvidia.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "Tian, Kevin" <kevin.tian@intel.com>, "Peng,
 Chao P" <chao.p.peng@intel.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard
 Henderson <richard.henderson@linaro.org>, Eduardo Habkost
 <eduardo@habkost.net>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: Re: [PATCH v1 03/17] intel_iommu: Add a placeholder variable for
 scalable modern mode
Thread-Topic: [PATCH v1 03/17] intel_iommu: Add a placeholder variable for
 scalable modern mode
Thread-Index: AQHa2Os6jI53vxLunUO9e0sZTiatjrH8MI6AgAEpkACAAAnkAIAABAIAgAAAzoCAAA0gAA==
Date: Fri, 19 Jul 2024 04:26:59 +0000
Message-ID: <13d27262-d495-453e-ba8f-347a1a72be30@eviden.com>
References: <20240718081636.879544-1-zhenzhong.duan@intel.com>
 <20240718081636.879544-4-zhenzhong.duan@intel.com>
 <e41c8b79-1b86-42de-b1d5-dce7ed29d422@eviden.com>
 <SJ0PR11MB6744F86F44C2C32C4B79C80A92AD2@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <9c9dba22-df29-4121-8126-4707084b891b@intel.com>
 <SJ0PR11MB6744F4CAEA5A9627D79AFE2092AD2@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <SJ0PR11MB67448D180C7D00AD8F38EA4492AD2@SJ0PR11MB6744.namprd11.prod.outlook.com>
In-Reply-To: <SJ0PR11MB67448D180C7D00AD8F38EA4492AD2@SJ0PR11MB6744.namprd11.prod.outlook.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|PA1PR07MB10161:EE_
x-ms-office365-filtering-correlation-id: 15c27e06-b92a-4e37-8c6d-08dca7ab07da
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|1800799024|376014|366016|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?NTVSSGZ3b1ZZQnMyR2g1VTdjUXVNamN3V1hxUktBQlNRWjIwS0NxOGpISXV3?=
 =?utf-8?B?TEFCanl4cUlkcXF6RkRNdnJJZCtOcjR3TzlJVU5hcGhGUmgxQ1kxKzJhTndo?=
 =?utf-8?B?a2d2RGxwWkk1c2RVbDIrT1pxOFVYVDhPV3NSYVdXc1lwV0ZQUzJoUVpaSDE1?=
 =?utf-8?B?M2VrL05xczBDaEpxZ29jVGFZTEU2a0NJWUFIcTUrVll2SzYxYzFrY2hwcS9z?=
 =?utf-8?B?L3J0UkpmL2FzdURtVUl2bVlUaUtpaVVjYWJvSnBrREZOdUlPVGozUlU3Y3NC?=
 =?utf-8?B?TlBjWnFHWUJ3NWxTYUNscFRhYml5blNlbS9VTGMvWlpMNUl0aW1RY0EvK2ox?=
 =?utf-8?B?b3NYd2czYXYvVGRnVlEyODFlcFRVZWNPYTlQZ2QvNmN3dDBuR1hDZEZqcGpx?=
 =?utf-8?B?bFFOWFhRZ0IrNUp2aFdtSDRxUE56Y3gvU2U1MmFGQi9kTEhyczR3VXhpZjFF?=
 =?utf-8?B?SDA1YmQzTGg3OE5UOUpWWWZscVhnVDdjK2o1ZGhwb24zOG1ZUkkxY0JSTlNX?=
 =?utf-8?B?SXE2S0VZa2g5bUR3TmVRdWNXeTdPc1Q0Nzg3OEJWOFIwWkJXVjVsQkltcmdH?=
 =?utf-8?B?MUd5VldzNmlCMzh4c25kV1NHWXlSa2g3Rmd1Uk5IZzBVQU9oVGl5aEt5VnlH?=
 =?utf-8?B?bTJ2U1JmZ08xbEQwMGFKM1VFdVlkZ1N0VzRnNktIV0k0dW1LWi9QVUFSazgz?=
 =?utf-8?B?RmhFS2swQXV5dUh3eEdZSjdtZDVRY3ozVmxzZzlVbzU2dXU2a3pBbVVRTjBo?=
 =?utf-8?B?blJWT0Q5a3Z6ci9WTmhNc1dheFJpMHR4UUY3SjF2QjQ3TUxWSEpzbFVpVkx0?=
 =?utf-8?B?OGVUMzM3dG1lM1k0RG5rR1M1aU9nNDM4S2FCUm55M2FtR2VhV3JtaDNFdnEv?=
 =?utf-8?B?WWhqdWdrNXh4dTB6MTlUWXhObFVxMExqRWozZGJnbkpWM0IwVEdkVStQblVX?=
 =?utf-8?B?V0dpNGdDbGI2WVZHTXdCZW5RM0tNeG0xK1Vaa1Njb2FUd3owQStuYmkyRDZU?=
 =?utf-8?B?UjMyL1FjM1NNaHRscVJNaEJBZklyQUtPM3lIak8vZFVLbnozOCtPNUhLTU8x?=
 =?utf-8?B?djhkeDVrTmhjWEFHcWxzNnpKa1JXZUl2V0I5anFHWlk0WjhYQ2hJamlJdXhI?=
 =?utf-8?B?b3ExTFQzT1VmS1FweUxmVlNVVFR6aGNXS043WEgrQm9xWTNJV2lBa0xPZTZC?=
 =?utf-8?B?d2p5VXdKMFRKQzZKbTRscG1BTGZMY3dDMmxXZ3ZxWFVoTXBiWXN1MlJKWEli?=
 =?utf-8?B?Wmhxa2hqa1NsRXdqaXpBWWJCZkdrRTNuYlpTZlpnRytwNE9tWnJrYnZ1ZWhy?=
 =?utf-8?B?dWlWZ0J0ZFg4RjFRYU8wMHJWbUlxNmQ0QzgySHRjdVRxOUFjNmFYRklnb2t4?=
 =?utf-8?B?U1l5ZjI4U1Rhek8rYWRaak1KTmxHVDFuTGc1UTFVZnRVdS9lQlhBUFJWMCtr?=
 =?utf-8?B?d29IOUpOQlhDSVQrZ05aMThUR2cvQk1vejJIYXBBSnI1eGEvZ1hXcy9Dd0pL?=
 =?utf-8?B?bmRTbUpLbFF6OXZRTE9tSFRCL1EvRkgyWEw3ei8rRHRINjB1bzg5U1RMc1dn?=
 =?utf-8?B?UWplZzZxTDR2SkxNVy83VjB1d2l0Wkt6M0pGbUQ4RGdjblNpV0lFS1BkbXZo?=
 =?utf-8?B?SzFtV3VzRU1ua1Bka3Jxa2o1aEVuY2dNNU0xamFUdzd5a0xZbTMwaFIwN1hu?=
 =?utf-8?B?cGJjUGhyTnJkaVNRQXgvQ3pWUVpmcW1SdEpmNE92alVObWhqVGdNUTFoQ3dZ?=
 =?utf-8?B?OHlhNEdGVnpVMTMwVE1xWTl1OG5wNVBycjVqL2NyRjBpVGpCQi9PRitOK09h?=
 =?utf-8?B?RFNBM0pvNnAwTEFsdEVaYmVxOTBoaURVNlZlYmVQZWVpZWRMNm0wb29CVVho?=
 =?utf-8?B?aEFXN0FiRG16R2ZTR3FoQWFIbUdsaHd1eUNZblRLeGExMXc9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(1800799024)(376014)(366016)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?S1A2RUFuQmxGWHFoNGRNOGpwQXZaY21EQmpBOEk2b3lWUm9UVS9rYUc2SWFL?=
 =?utf-8?B?KzZVOTMvKy9BQnYzWXgrOHAvcVVtQUVOOUV4ZTFNZnh1eWI2dS9TdlBTSWlU?=
 =?utf-8?B?Q3pTNm5CN3FBWjFmdmlVcUpyN0JvWTJrMEM0Wkc1NDlCZDN1VFpyN1hHdko2?=
 =?utf-8?B?UmszOHFTYnQyaGFVWWFjRE5ZTWpOSEw1bjZXQlVMYzJKWEhVZkFJT2V6TUlq?=
 =?utf-8?B?RmFJdkNoVVhWU04rQ3J6c0h6ZEMzMmVpeWJ3b0p2VWorcGpDUnU3Z3FVVHpz?=
 =?utf-8?B?MDhZak8vZ0VOK240RDY0NU9SVHY3ZnZJdVJrWjFHTTg3Y0oxckxQUUUxNkdV?=
 =?utf-8?B?QVdSK0pqdVdTZ3JNOXRWQVY0YWhxcnBLUDVGLy9hV3h4NHdabVM1blVIRk1j?=
 =?utf-8?B?YlZiaVJnL0ROSnJFTEhGTld5WEthL3ExQk5jSldScEVvSlJkRTdlMmhNTjhW?=
 =?utf-8?B?SktZZ1E5OTI1WGZHcDhsTFpRVXdJekJWbFZhYW5Zajc0c0dJZElqRGpJL1BF?=
 =?utf-8?B?Zys4ZVZlTC9XRjNmT29rZGZtNm5Dc2tRc0U3ejdXdVBTaHZxWUFpZCtDSENE?=
 =?utf-8?B?ODBIQmRFNW1LNFoxckp3c2ZBN0JLMEx4dkg3ZHlleEV4UG9pTEhibkhrVjNT?=
 =?utf-8?B?eGRnQWRTL3JJK1Npd2thMlhiaXV0UzhHcHArd0p3YkxaWTlzb05rTW1PTVNP?=
 =?utf-8?B?MEJwdkFpbS83SVVrVXMvc2c0dWtFTkQ1RnpwTGxQTnozMEhSQzVRUFVCYS9K?=
 =?utf-8?B?RmN1TXVwbnV4alhocVV6UXhUOTdzMHBxMW15eDJZSGlpS1IxMWQyYktydDY5?=
 =?utf-8?B?WmpKQ1NzTm1IYndoMXVIc1lrenF1eHByZlQ0VkR3RlI3a1BpQVptcjVtY0Nn?=
 =?utf-8?B?TDRDSnRTNGZDRWZoNHdVOWl4azlBMUYrWExJTk45a1E1N2lpalA3cEM4VzhI?=
 =?utf-8?B?eENUSXR2Tzh2K2Exb3Q5THZuTTUwTEl6SU1wSmNnWTNDOS9SZVFiMFJTTTVD?=
 =?utf-8?B?Y2V0bU1ROFoxa1JsOXNYUTRJdWpJR0lOOGVaTkc1Ly84OTYyNkw0NDNTZzQ1?=
 =?utf-8?B?aFduSkJocDB6MmREK1ZKSHJmTVd6QzRWcXdEeGlZcUQxZDdtUVRxYjM0L0xT?=
 =?utf-8?B?MFdEdkc2bStVNGIzakFlWkpnSUVrckVxQlJQY0JSUGJRbTd5dmI2Q0RWaU1m?=
 =?utf-8?B?MURmZ08yOTNCS0JlNERhZ1V0UTVMTjdRV0Zyd3NkeVZaa2xVU2FLeFpKMDdE?=
 =?utf-8?B?eGFYdWUvdldYbytTVEdrU0xCMHI3YTNLOFlpbjdienBxckcvUEpoVlJON2I1?=
 =?utf-8?B?K1dKanFJQjFya2VLTEplSGYyKy9rNXlJb2NzRnI4LzlaQ2VIRHNZdmM3MHo1?=
 =?utf-8?B?SnkyOE5TQlEwbGsvL2NxQStUSjE0YTE2SWJkQ2xJSDFwVUhZSElEbTlFZHpN?=
 =?utf-8?B?NFJRZ1ZEMnBJdG9NRTRjMTZqanJPbnNUM3djTDhKUTFDZlZTM2ZKV1liajVv?=
 =?utf-8?B?dUU0bnljYUFiOElpSjU1cnl5Um9RVzhpKzFKbzgyb01LZkliOWxQc1NnbjBL?=
 =?utf-8?B?M3YzTjlzMFV5dkpINFVFQzd0TlI1aGc5SVZhWXlCTHFWbjJja3B6dGl4NGEw?=
 =?utf-8?B?MVc0dUtENk50dFRLdFI1NHRpakQ1R3pQUFBXdFMvTXc0dk1uRzQ3dCtOVnF2?=
 =?utf-8?B?VzBVQzdmTDByZHBVRnUxY2phOFBWQldLN3V1Z25aWUdIWFo3SGVZeUZ5SGd1?=
 =?utf-8?B?dlkzRndaVUVXTHBlQktjWGg3WkcwMXVMTFpaTU9ORjRGS1N6c1p0MHBQcVlw?=
 =?utf-8?B?bklqanNmWkVPdFdrV0tlbGM5VFZ0Nlo2QUpnQis4SEwwM0tNQldqM3lpbi9i?=
 =?utf-8?B?SWlxSTd2Ullwa2U4MmUyTWM0Vm9hSmxzT29NWjNGQ1RMdGErQ1gyTU14QjZO?=
 =?utf-8?B?T09pRWw0VzdLVmRaSEJyd1NDTFpOY205K2tuc1djYjRFcWxxN2lmd2JvSUli?=
 =?utf-8?B?Z3R1S0o3VjZzeVFYemxjOHRabHpkRnB4NTNEcDRpS0t5ZG9rV3MzNlQyanJE?=
 =?utf-8?B?VXhWWEZzTnpVZU9vcTFvQkwvRW1mOXo2SHEwT01tTXZKUUUraHMxTHF3NG1X?=
 =?utf-8?B?QlFGTnVGUktSUW9sTTNYUmV6ejhFbW9pN1dMRTF4Ylo5QjNQbDhPWFQ2SW81?=
 =?utf-8?Q?KyOXH+Lcr+y7n+ZTCh896nU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6F83CB79C9F03C459A72A6E75FE82288@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15c27e06-b92a-4e37-8c6d-08dca7ab07da
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jul 2024 04:26:59.2240 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: w8vJa1Es0P9BcIS8wNKtDdSB9VLVX+nQwToNIr1OzkPq0U1VfHVoee8XC3glHnF7bWy4Xlx9xHebt5lBwNSFKYKPHeGvbs6wk+dwW6mZnclcoyxF3jx8hqz2XOgFpvbW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR07MB10161
Received-SPF: pass client-ip=80.78.11.84;
 envelope-from=clement.mathieu--drif@eviden.com; helo=smarthost3.eviden.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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

DQoNCk9uIDE5LzA3LzIwMjQgMDU6MzksIER1YW4sIFpoZW56aG9uZyB3cm90ZToNCj4gQ2F1dGlv
bjogRXh0ZXJuYWwgZW1haWwuIERvIG5vdCBvcGVuIGF0dGFjaG1lbnRzIG9yIGNsaWNrIGxpbmtz
LCB1bmxlc3MgdGhpcyBlbWFpbCBjb21lcyBmcm9tIGEga25vd24gc2VuZGVyIGFuZCB5b3Uga25v
dyB0aGUgY29udGVudCBpcyBzYWZlLg0KPg0KPg0KPj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0t
LS0NCj4+IEZyb206IER1YW4sIFpoZW56aG9uZ10NCj4+IFN1YmplY3Q6IFJFOiBbUEFUQ0ggdjEg
MDMvMTddIGludGVsX2lvbW11OiBBZGQgYSBwbGFjZWhvbGRlciB2YXJpYWJsZSBmb3INCj4+IHNj
YWxhYmxlIG1vZGVybiBtb2RlDQo+Pg0KPj4NCj4+DQo+Pj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdl
LS0tLS0NCj4+PiBGcm9tOiBMaXUsIFlpIEwgPHlpLmwubGl1QGludGVsLmNvbT4NCj4+PiBTdWJq
ZWN0OiBSZTogW1BBVENIIHYxIDAzLzE3XSBpbnRlbF9pb21tdTogQWRkIGEgcGxhY2Vob2xkZXIg
dmFyaWFibGUgZm9yDQo+Pj4gc2NhbGFibGUgbW9kZXJuIG1vZGUNCj4+Pg0KPj4+IE9uIDIwMjQv
Ny8xOSAxMDo0NywgRHVhbiwgWmhlbnpob25nIHdyb3RlOg0KPj4+Pg0KPj4+Pj4gLS0tLS1Pcmln
aW5hbCBNZXNzYWdlLS0tLS0NCj4+Pj4+IEZyb206IENMRU1FTlQgTUFUSElFVS0tRFJJRiA8Y2xl
bWVudC5tYXRoaWV1LS1kcmlmQGV2aWRlbi5jb20+DQo+Pj4+PiBTdWJqZWN0OiBSZTogW1BBVENI
IHYxIDAzLzE3XSBpbnRlbF9pb21tdTogQWRkIGEgcGxhY2Vob2xkZXIgdmFyaWFibGUNCj4+PiBm
b3INCj4+Pj4+IHNjYWxhYmxlIG1vZGVybiBtb2RlDQo+Pj4+Pg0KPj4+Pj4NCj4+Pj4+DQo+Pj4+
PiBPbiAxOC8wNy8yMDI0IDEwOjE2LCBaaGVuemhvbmcgRHVhbiB3cm90ZToNCj4+Pj4+PiBDYXV0
aW9uOiBFeHRlcm5hbCBlbWFpbC4gRG8gbm90IG9wZW4gYXR0YWNobWVudHMgb3IgY2xpY2sgbGlu
a3MsIHVubGVzcw0KPj4+IHRoaXMNCj4+Pj4+IGVtYWlsIGNvbWVzIGZyb20gYSBrbm93biBzZW5k
ZXIgYW5kIHlvdSBrbm93IHRoZSBjb250ZW50IGlzIHNhZmUuDQo+Pj4+Pj4NCj4+Pj4+PiBBZGQg
YW4gbmV3IGVsZW1lbnQgc2NhbGFibGVfbW9kZSBpbiBJbnRlbElPTU1VU3RhdGUgdG8gbWFyaw0K
Pj4+IHNjYWxhYmxlDQo+Pj4+Pj4gbW9kZXJuIG1vZGUsIHRoaXMgZWxlbWVudCB3aWxsIGJlIGV4
cG9zZWQgYXMgYW4gaW50ZWxfaW9tbXUNCj4+IHByb3BlcnR5DQo+Pj4+Pj4gZmluYWxseS4NCj4+
Pj4+Pg0KPj4+Pj4+IEZvciBub3csIGl0J3Mgb25seSBhIHBsYWNlaGhvbGRlciBhbmQgdXNlZCBm
b3IgY2FwL2VjYXAgaW5pdGlhbGl6YXRpb24sDQo+Pj4+Pj4gY29tcGF0aWJpbGl0eSBjaGVjayBh
bmQgYmxvY2sgaG9zdCBkZXZpY2UgcGFzc3Rocm91Z2ggdW50aWwgbmVzdGluZw0KPj4+Pj4+IGlz
IHN1cHBvcnRlZC4NCj4+Pj4+Pg0KPj4+Pj4+IFNpZ25lZC1vZmYtYnk6IFlpIExpdSA8eWkubC5s
aXVAaW50ZWwuY29tPg0KPj4+Pj4+IFNpZ25lZC1vZmYtYnk6IFpoZW56aG9uZyBEdWFuIDx6aGVu
emhvbmcuZHVhbkBpbnRlbC5jb20+DQo+Pj4+Pj4gLS0tDQo+Pj4+Pj4gICAgIGh3L2kzODYvaW50
ZWxfaW9tbXVfaW50ZXJuYWwuaCB8ICAyICsrDQo+Pj4+Pj4gICAgIGluY2x1ZGUvaHcvaTM4Ni9p
bnRlbF9pb21tdS5oICB8ICAxICsNCj4+Pj4+PiAgICAgaHcvaTM4Ni9pbnRlbF9pb21tdS5jICAg
ICAgICAgIHwgMzQgKysrKysrKysrKysrKysrKysrKysrKystLS0tLS0tDQo+PiAtLQ0KPj4+IC0t
DQo+Pj4+Pj4gICAgIDMgZmlsZXMgY2hhbmdlZCwgMjYgaW5zZXJ0aW9ucygrKSwgMTEgZGVsZXRp
b25zKC0pDQo+Pj4+Pj4NCj4+Pj4+PiBkaWZmIC0tZ2l0IGEvaHcvaTM4Ni9pbnRlbF9pb21tdV9p
bnRlcm5hbC5oDQo+Pj4+PiBiL2h3L2kzODYvaW50ZWxfaW9tbXVfaW50ZXJuYWwuaA0KPj4+Pj4+
IGluZGV4IGMwY2E3YjM3MmYuLjRlMDMzMWNhYmEgMTAwNjQ0DQo+Pj4+Pj4gLS0tIGEvaHcvaTM4
Ni9pbnRlbF9pb21tdV9pbnRlcm5hbC5oDQo+Pj4+Pj4gKysrIGIvaHcvaTM4Ni9pbnRlbF9pb21t
dV9pbnRlcm5hbC5oDQo+Pj4+Pj4gQEAgLTE5NSw2ICsxOTUsNyBAQA0KPj4+Pj4+ICAgICAjZGVm
aW5lIFZURF9FQ0FQX1BBU0lEICAgICAgICAgICAgICAoMVVMTCA8PCA0MCkNCj4+Pj4+PiAgICAg
I2RlZmluZSBWVERfRUNBUF9TTVRTICAgICAgICAgICAgICAgKDFVTEwgPDwgNDMpDQo+Pj4+Pj4g
ICAgICNkZWZpbmUgVlREX0VDQVBfU0xUUyAgICAgICAgICAgICAgICgxVUxMIDw8IDQ2KQ0KPj4+
Pj4+ICsjZGVmaW5lIFZURF9FQ0FQX0ZMVFMgICAgICAgICAgICAgICAoMVVMTCA8PCA0NykNCj4+
Pj4+Pg0KPj4+Pj4+ICAgICAvKiBDQVBfUkVHICovDQo+Pj4+Pj4gICAgIC8qIChvZmZzZXQgPj4g
NCkgPDwgMjQgKi8NCj4+Pj4+PiBAQCAtMjExLDYgKzIxMiw3IEBADQo+Pj4+Pj4gICAgICNkZWZp
bmUgVlREX0NBUF9TTExQUyAgICAgICAgICAgICAgICgoMVVMTCA8PCAzNCkgfCAoMVVMTCA8PCAz
NSkpDQo+Pj4+Pj4gICAgICNkZWZpbmUgVlREX0NBUF9EUkFJTl9XUklURSAgICAgICAgICgxVUxM
IDw8IDU0KQ0KPj4+Pj4+ICAgICAjZGVmaW5lIFZURF9DQVBfRFJBSU5fUkVBRCAgICAgICAgICAo
MVVMTCA8PCA1NSkNCj4+Pj4+PiArI2RlZmluZSBWVERfQ0FQX0ZTMUdQICAgICAgICAgICAgICAg
KDFVTEwgPDwgNTYpDQo+Pj4+Pj4gICAgICNkZWZpbmUgVlREX0NBUF9EUkFJTiAgICAgICAgICAg
ICAgIChWVERfQ0FQX0RSQUlOX1JFQUQgfA0KPj4+Pj4gVlREX0NBUF9EUkFJTl9XUklURSkNCj4+
Pj4+PiAgICAgI2RlZmluZSBWVERfQ0FQX0NNICAgICAgICAgICAgICAgICAgKDFVTEwgPDwgNykN
Cj4+Pj4+PiAgICAgI2RlZmluZSBWVERfUEFTSURfSURfU0hJRlQgICAgICAgICAgMjANCj4+Pj4+
PiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9ody9pMzg2L2ludGVsX2lvbW11LmgNCj4+Pj4+IGIvaW5j
bHVkZS9ody9pMzg2L2ludGVsX2lvbW11LmgNCj4+Pj4+PiBpbmRleCAxZWIwNWMyOWZjLi43ODhl
ZDQyNDc3IDEwMDY0NA0KPj4+Pj4+IC0tLSBhL2luY2x1ZGUvaHcvaTM4Ni9pbnRlbF9pb21tdS5o
DQo+Pj4+Pj4gKysrIGIvaW5jbHVkZS9ody9pMzg2L2ludGVsX2lvbW11LmgNCj4+Pj4+PiBAQCAt
MjYyLDYgKzI2Miw3IEBAIHN0cnVjdCBJbnRlbElPTU1VU3RhdGUgew0KPj4+Pj4+DQo+Pj4+Pj4g
ICAgICAgICBib29sIGNhY2hpbmdfbW9kZTsgICAgICAgICAgICAgIC8qIFJPIC0gaXMgY2FwIENN
IGVuYWJsZWQ/ICovDQo+Pj4+Pj4gICAgICAgICBib29sIHNjYWxhYmxlX21vZGU7ICAgICAgICAg
ICAgIC8qIFJPIC0gaXMgU2NhbGFibGUgTW9kZSBzdXBwb3J0ZWQ/DQo+PiAqLw0KPj4+Pj4+ICsg
ICAgYm9vbCBzY2FsYWJsZV9tb2Rlcm47ICAgICAgICAgICAvKiBSTyAtIGlzIG1vZGVybiBTTSBz
dXBwb3J0ZWQ/ICovDQo+Pj4+Pj4gICAgICAgICBib29sIHNub29wX2NvbnRyb2w7ICAgICAgICAg
ICAgIC8qIFJPIC0gaXMgU05QIGZpbGVkIHN1cHBvcnRlZD8gKi8NCj4+Pj4+Pg0KPj4+Pj4+ICAg
ICAgICAgZG1hX2FkZHJfdCByb290OyAgICAgICAgICAgICAgICAvKiBDdXJyZW50IHJvb3QgdGFi
bGUgcG9pbnRlciAqLw0KPj4+Pj4+IGRpZmYgLS1naXQgYS9ody9pMzg2L2ludGVsX2lvbW11LmMg
Yi9ody9pMzg2L2ludGVsX2lvbW11LmMNCj4+Pj4+PiBpbmRleCAxY2ZmOGIwMGFlLi40MGNiZDRh
MGY0IDEwMDY0NA0KPj4+Pj4+IC0tLSBhL2h3L2kzODYvaW50ZWxfaW9tbXUuYw0KPj4+Pj4+ICsr
KyBiL2h3L2kzODYvaW50ZWxfaW9tbXUuYw0KPj4+Pj4+IEBAIC03NTUsMTYgKzc1NSwyMCBAQCBz
dGF0aWMgaW5saW5lIGJvb2wNCj4+Pj4+IHZ0ZF9pc19sZXZlbF9zdXBwb3J0ZWQoSW50ZWxJT01N
VVN0YXRlICpzLCB1aW50MzJfdCBsZXZlbCkNCj4+Pj4+PiAgICAgfQ0KPj4+Pj4+DQo+Pj4+Pj4g
ICAgIC8qIFJldHVybiB0cnVlIGlmIGNoZWNrIHBhc3NlZCwgb3RoZXJ3aXNlIGZhbHNlICovDQo+
Pj4+Pj4gLXN0YXRpYyBpbmxpbmUgYm9vbCB2dGRfcGVfdHlwZV9jaGVjayhYODZJT01NVVN0YXRl
ICp4ODZfaW9tbXUsDQo+Pj4+Pj4gLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICBWVERQQVNJREVudHJ5ICpwZSkNCj4+Pj4+PiArc3RhdGljIGlubGluZSBib29sIHZ0ZF9wZV90
eXBlX2NoZWNrKEludGVsSU9NTVVTdGF0ZSAqcywNCj4+Pj4+IFZURFBBU0lERW50cnkgKnBlKQ0K
Pj4+Pj4+ICAgICB7DQo+Pj4+PiBXaGF0IGFib3V0IHVzaW5nIHRoZSBjYXAvZWNhcCByZWdpc3Rl
cnMgdG8ga25vdyBpZiB0aGUgdHJhbnNsYXRpb24gdHlwZXMNCj4+Pj4+IGFyZSBzdXBwb3J0ZWQg
b3Igbm90Lg0KPj4+Pj4gT3RoZXJ3aXNlLCB3ZSBjb3VsZCBhZGQgYSBjb21tZW50IHRvIGV4cGxh
aW4gd2h5IHdlIGV4cGVjdA0KPj4+Pj4gcy0+c2NhbGFibGVfbW9kZXJuIHRvIGdpdmUgdXMgZW5v
dWdoIGluZm9ybWF0aW9uLg0KPj4+PiBXaGF0IGFib3V0IGJlbG93Og0KPj4+Pg0KPj4+PiAvKg0K
Pj4+PiAgICAqVlREX0VDQVBfRkxUUyBpbiBlY2FwIGlzIHNldCBpZiBzLT5zY2FsYWJsZV9tb2Rl
cm4gaXMgdHJ1ZSwgb3IgZWxzZQ0KPj4+IFZURF9FQ0FQX1NMVFMgY2FuIGJlIHNldCBvciBub3Qg
ZGVwZW5kaW5nIG9uIHMtPnNjYWxhYmxlX21vZGUuDQo+Pj4+ICAgICpTbyBpdCdzIHNpbXBsZXIg
dG8gY2hlY2sgcy0+c2NhbGFibGVfbW9kZXJuIGRpcmVjdGx5IGZvciBhIFBBU0lEIGVudHJ5DQo+
Pj4gdHlwZSBpbnN0ZWFkIGVjYXAgYml0cy4NCj4+Pj4gICAgKi8NCj4+PiBTaW5jZSB0aGlzIGhl
bHBlciBpcyBmb3IgcGFzaWQgZW50cnkgY2hlY2ssIHNvIHlvdSBjYW4ganVzdCByZXR1cm4gZmFs
c2UNCj4+PiBpZiB0aGUgcGUncyBQR1RUIGlzIFNTLW9ubHkuDQo+PiBJdCBkZXBlbmRzIG9uIHdo
aWNoIHNjYWxhYmxlIG1vZGUgaXMgY2hvc2VkLg0KPj4gSW4gc2NhbGFibGUgbGVnYWN5IG1vZGUs
IFBHVFQgaXMgU1Mtb25seSBhbmQgd2Ugc2hvdWxkIHJldHVybiB0cnVlLg0KPj4NCj4+PiBJdCBt
aWdodCBtYWtlIG1vcmUgc2Vuc2UgdG8gY2hlY2sgdGhlIGVjYXAvY2FwIGhlcmUgYXMgYW55aG93
IHRoZQ0KPj4+IGNhcGFiaWxpdHkgaXMgbGlzdGVkIGluIGVjYXAvY2FwLiBUaGlzIG1heSBhbHNv
IGJyaW5nIHVzIHNvbWUgY29udmVuaWVuY2UuDQo+Pj4NCj4+PiBTYXkgaW4gdGhlIGZ1dHVyZSwg
aWYgd2Ugd2FudCB0byBhZGQgYSBuZXcgbW9kZSAoZS5nLiBzY2FsYWJsZSBtb2RlIDIuMCkNCj4+
PiB0aGF0IHN1cHBvcnRzIGJvdGggRlMgYW5kIFNTIGZvciBndWVzdCwgd2UgbWF5IG5lZWQgdG8g
dXBkYXRlIHRoaXMgaGVscGVyDQo+Pj4gYXMgd2VsbCBpZiB3ZSBjaGVjayB0aGUgc2NhbGFibGVf
bW9kZXJuLiBCdXQgaWYgd2UgY2hlY2sgdGhlIGVjYXAvY2FwLCB0aGVuDQo+Pj4gdGhlIGZ1dHVy
ZSBjaGFuZ2UganVzdCBuZWVkcyB0byBjb250cm9sIHRoZSBlY2FwL2NhcCBzZXR0aW5nIGF0IHRo
ZQ0KPj4+IGJlZ2lubmluZyBvZiB0aGUgdklPTU1VIGluaXQuIFRvIGtlZXAgdGhlIGNvZGUgYWxp
Z25lZCwgeW91IG1heSBuZWVkIHRvDQo+Pj4gY2hlY2sgZWNhcC5QVCBiaXQgZm9yIFZURF9TTV9Q
QVNJRF9FTlRSWV9QVC4gOikNCj4+IE9LLCB3aWxsIGJlIGxpa2UgYmVsb3c6DQo+Pg0KPj4gLS0t
IGEvaHcvaTM4Ni9pbnRlbF9pb21tdS5jDQo+PiArKysgYi9ody9pMzg2L2ludGVsX2lvbW11LmMN
Cj4+IEBAIC04MjYsMTQgKzgyNiwxNCBAQCBzdGF0aWMgaW5saW5lIGJvb2wNCj4+IHZ0ZF9wZV90
eXBlX2NoZWNrKEludGVsSU9NTVVTdGF0ZSAqcywgVlREUEFTSURFbnRyeSAqcGUpDQo+Pg0KPj4g
ICAgICBzd2l0Y2ggKFZURF9QRV9HRVRfVFlQRShwZSkpIHsNCj4+ICAgICAgY2FzZSBWVERfU01f
UEFTSURfRU5UUllfRkxUOg0KPj4gLSAgICAgICAgcmV0dXJuIHMtPnNjYWxhYmxlX21vZGVybjsN
Cj4+ICsgICAgICAgIHJldHVybiAhIShzLT5lY2FwICYgVlREX0VDQVBfRkxUUyk7DQo+PiAgICAg
IGNhc2UgVlREX1NNX1BBU0lEX0VOVFJZX1NMVDoNCj4+IC0gICAgICAgIHJldHVybiAhcy0+c2Nh
bGFibGVfbW9kZXJuOw0KPj4gKyAgICAgICAgcmV0dXJuICEhKHMtPmVjYXAgJiBWVERfRUNBUF9G
TFRTKSB8fCAhKHMtPmVjYXAgJiBWVERfRUNBUF9TTVRTKTsNCj4gU29ycnkgdHlwbyBlcnIsIHNo
b3VsZCBiZToNCj4NCj4gKyAgICAgICAgcmV0dXJuICEhKHMtPmVjYXAgJiBWVERfRUNBUF9TTFRT
KSB8fCAhKHMtPmVjYXAgJiBWVERfRUNBUF9TTVRTKTsNCj4NCkkgYWdyZWUgd2l0aCBZaSdzIHBv
aW50IG9mIHZpZXcsIHRoaXMgdmVyc2lvbiBsb29rcyBnb29kDQo+PiAgICAgIGNhc2UgVlREX1NN
X1BBU0lEX0VOVFJZX05FU1RFRDoNCj4+ICAgICAgICAgIC8qIE5vdCBzdXBwb3J0IE5FU1RFRCBw
YWdlIHRhYmxlIHR5cGUgeWV0ICovDQo+PiAgICAgICAgICByZXR1cm4gZmFsc2U7DQo+PiAgICAg
IGNhc2UgVlREX1NNX1BBU0lEX0VOVFJZX1BUOg0KPj4gLSAgICAgICAgcmV0dXJuIHg4Nl9pb21t
dS0+cHRfc3VwcG9ydGVkOw0KPj4gKyAgICAgICAgcmV0dXJuICEhKHMtPmVjYXAgJiBWVERfRUNB
UF9QVCk7DQo+PiAgICAgIGRlZmF1bHQ6DQo+PiAgICAgICAgICAvKiBVbmtub3duIHR5cGUgKi8N
Cj4+ICAgICAgICAgIHJldHVybiBmYWxzZTsNCj4+DQo+PiBUaGFua3MNCj4+IFpoZW56aG9uZw0K

