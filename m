Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4620AC3DA49
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2024 02:37:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUdUL-0006PI-SC; Thu, 18 Jul 2024 22:36:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sUdUJ-0006Oj-VI
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 22:36:52 -0400
Received: from mgamail.intel.com ([198.175.65.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sUdUH-0004Fh-1U
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 22:36:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1721356609; x=1752892609;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=1/5Zlz4BGywdX3RDPazFPn/Y75vw6VZZu83wvbie5HA=;
 b=NFI/264EYjthwlo2mtxRMBHqCYbcHKjxtIMFhhGrNgOvSaSG1r/hjZ4q
 3l1aZATrJaeZ2Ccnleuf12DLoQ8xGauhwZbzR+UMURA8wm+hNjKQdIttB
 aXJOwsHdzcxQp4iYRvr8d/gcLeH8FcwvtYLeAQvXc6pxhQhd0ztQxpfDG
 R84w2QnACj5Wkfg5o+7mG6otVz+7bwq31CEY7NQcxppD4eToaoJ5Mizsk
 OOWnU7YuDVtlFiFOhRIhAr/lcMvYpfNWxKWrvmQVtOaSD3HauNPoCM47a
 fUNWTik/A46/CxMMYaP5jiGRXJGuAoNmfaAMzjijYt6kUrHQpVAvalyFn w==;
X-CSE-ConnectionGUID: vH1rHzWWS26kyUXbxgVzjA==
X-CSE-MsgGUID: EOsxZn9jRmy5/w7znTYRbA==
X-IronPort-AV: E=McAfee;i="6700,10204,11137"; a="18805519"
X-IronPort-AV: E=Sophos;i="6.09,219,1716274800"; d="scan'208";a="18805519"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Jul 2024 19:36:45 -0700
X-CSE-ConnectionGUID: 1r8BhShhTWe/ek5Ok00Prw==
X-CSE-MsgGUID: VdrUOgm0QISRnIKGojJ6Eg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,219,1716274800"; d="scan'208";a="50841750"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
 by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 18 Jul 2024 19:36:45 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 18 Jul 2024 19:36:44 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 18 Jul 2024 19:36:44 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 18 Jul 2024 19:36:44 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.176)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 18 Jul 2024 19:36:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jji7JR810HJbVKwDZrPAs5amjYzFTBeEUguaaJM/AFhxS/oLyYKJK9eQ9mVFK9rrkID/NgUciGPhsuTDz3iJHaRkePvW0Jwxyx0FQTxBH/9gkxm4BjEBaFliY2Z9vwJjX0vTsmSYd1YbyI2w3R9u/EJfEHugTv/8+B2kd30V/M2c0lJucyuTnevb1ws596AeYpm79BNN22wrPWJcf1/fTFAEeCG+rRjPh8r/N0NdLFC/ytZcHHVJ/zJtBSMb0r8VoTE9gzV9tiai4upBpMiC42vmE8nz3teEWfcEDKmXXYwbd6iODMj8tDqyzpBqIJCqS5QUNGvuz8ElQTFq1gHOsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1/5Zlz4BGywdX3RDPazFPn/Y75vw6VZZu83wvbie5HA=;
 b=BXlR9Kt5udN3fksnD9MAT3ZsyZLgmtr13nIllYJh5GiXHXigLwydHh35bfoUzB1IY4Z/oNH/eqes8BjcIYMR5e+rY57KeqvX76NxUX2X4FFXsUHlb2BsHdc09BCyQViU1YF1/qjAzkH1d30V2kTQVH1vZCGSdYLEDFUEU57UCQRgyJQaOkABfxPtrmbHdZpDGYKOTlA/s930RgIZIzchFfB6PaQpXioK/vZEsaz7xchANZ8i8h0W5qgFZBg81u9QR5XEHKRQTETu7yAZc4TAXOjpR0imD3LCgIeQED0usg4Se6Qc2u6NzpO52g4JCzYnDrJbXqZ9jVJYUreqelGLMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by SJ1PR11MB6130.namprd11.prod.outlook.com (2603:10b6:a03:45f::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.32; Fri, 19 Jul
 2024 02:36:41 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091%7]) with mapi id 15.20.7784.016; Fri, 19 Jul 2024
 02:36:41 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: Joao Martins <joao.m.martins@oracle.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "Liu, Yi L" <yi.l.liu@intel.com>, Eric Auger <eric.auger@redhat.com>,
 "Alex Williamson" <alex.williamson@redhat.com>, Cedric Le Goater
 <clg@redhat.com>, Jason Gunthorpe <jgg@nvidia.com>, Avihai Horon
 <avihaih@nvidia.com>
Subject: RE: [PATCH v4 05/12] vfio/iommufd: Introduce auto domain creation
Thread-Topic: [PATCH v4 05/12] vfio/iommufd: Introduce auto domain creation
Thread-Index: AQHa1FFShwF3jB8O50qStFQJTkISYLH6NXowgAByoYCAAAxgYIAAFPIAgAFW16CAAB1iAIABHwPw
Date: Fri, 19 Jul 2024 02:36:41 +0000
Message-ID: <SJ0PR11MB674470AE0C7E1C6A6FBCA91F92AD2@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20240712114704.8708-1-joao.m.martins@oracle.com>
 <20240712114704.8708-6-joao.m.martins@oracle.com>
 <SJ0PR11MB67443AD929EFB426B4E4FBBF92A32@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <91d16e89-4733-437b-9674-b5a96f4398ec@oracle.com>
 <SJ0PR11MB674420D8D4742A704036C9F892A32@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <50bf8b57-ca18-4898-9e94-fa4420c58acb@oracle.com>
 <SJ0PR11MB67445783F2A2C2EFCBD65A7492AC2@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <25730f05-7652-423e-9d8f-35079a083345@oracle.com>
In-Reply-To: <25730f05-7652-423e-9d8f-35079a083345@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|SJ1PR11MB6130:EE_
x-ms-office365-filtering-correlation-id: 655bc8c4-41f9-4814-1eeb-08dca79b9f80
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?LzFPMlpKUzd6ajJuTS9HV3UzUU00REdTYXIyUnNmaU5MYlVYUlRtMWNhYUgr?=
 =?utf-8?B?d3l1b2pBU0ZWYXErWmVaUmxmYXZ4RFpnVFhNeWNJbzFYaDRydHJhWjhJb0U2?=
 =?utf-8?B?TzVlV01NVGNTelhhMTJ4NU9zbFFOcDJ4YkJCY0xYcllVdU0xWnk2NVJBTWJv?=
 =?utf-8?B?TzY5YThqdWw1dFlLOFJnZjZUdEVxbXBFR3diVmlwdUNmRW9rMFJNeW5tNjdh?=
 =?utf-8?B?OUNKekZ5b3V5R3JMQzRaanlBRTEyWnhiNG5RQ2R0UUhTL0ZNNU1mMFQrYzJY?=
 =?utf-8?B?ZGI4dXM1akpTZVBFV1I0cjdTbFNsM0NVYm1JZ09wcmdWSWhFcXE2a2dUenJG?=
 =?utf-8?B?cU1yU0pWQWhtZ3dBQWFpdHZScWs5dU1XUG1VR0s2TnVHc1RJay9IWkQ4WVNy?=
 =?utf-8?B?QXZvUkJSRDE4Rk05a1RTOThhMlhsQkFzTUF5a2NUWnBSMXBMcGpwVWtLWTZ2?=
 =?utf-8?B?THRPTzlUT29hYnRMcFM1dis4UGRHYmVDcExiSVVzN2o5VVh5ck9RVHZpdVgv?=
 =?utf-8?B?eXBaVUhEUzFCQ1lOdUZtdm1sbVdsaVdZdmtzY3RvdGhuZzByMkpTalRxVUpm?=
 =?utf-8?B?ZW5kb2U4bG1lY1laUkJTWXVqanBVbVprWCs4ZjVCTWMrMVB2NEI1MVI4eVdO?=
 =?utf-8?B?LzNQWWRzRWJsb082Njl4dFVOMlhScGo3dVcxdU9wbkx0Tzl0TGZsaW8ySXBm?=
 =?utf-8?B?TFdHQ3o0a0xZdXpSSWQ5dEttQjdCSnowRUlFZmo5dGlOSWRzQTFqZ3o4ZVds?=
 =?utf-8?B?SW9uQXJjNjdBc0xVaGRLWml3c2NubGNGdzMxdmNZTEh6Y3lzK0k4VGsvU3d2?=
 =?utf-8?B?SmpRenh6ODlPcEJFUmNxaVpCNElSZTdaQjdFSmFldXFtQUcvNHE4MDMzZzY0?=
 =?utf-8?B?NFovWEgwaytIeTNEa0ozbllzYWhtMm4vcEJJd1cwcUEzZVozSXIwWXpwWlhB?=
 =?utf-8?B?Sm1lUER5RG5NUVphbzV6WXA0QUJ1cjZ4ZERFTndwVlhCeXQzSjRHZmszOGFV?=
 =?utf-8?B?dnpXQW8yYXdhejcyZkZxekNkaWpZajl5d1lKSVVtSWNDeGZrelMzMjdKNW9o?=
 =?utf-8?B?Y2dWcVhJU2FsM3ZIbHJHRkRRemdTOWpSUUlsSlhGaEhTdGVIOE5uYkRadHdE?=
 =?utf-8?B?R2tXVVVaZWw3WENlU2FiT3dYekQ4a3FLM1JyTG44VkZpSzczZUhsa0owU0tD?=
 =?utf-8?B?NUpRcUYxSnNkWVJXLys3dVRUY1dUVm94OFQxWEpwUGhMaC8rSXI2ejdLcWdH?=
 =?utf-8?B?Y29sbUxpaG9JVm01YXExYnlyQ3Avc3V4VlcrN1ZBMDlMUlc1YkdWSHI0Z3Zw?=
 =?utf-8?B?MjJqbmZseVhLZ0hyWDFMNmxIOXRGRnhZOHgyR2ZMN2tGQ0E0azNhQnp2emRV?=
 =?utf-8?B?SVduRHBWd3ZJRCt2bnVDVlpZbDBsNi9Wa2FhSU5PSjV6SXFGc1RXOVBkbTVE?=
 =?utf-8?B?SzlPM0dtbnpURGJTZFRRWDZDcUxHM0FpemdLeXRhRzhzNVhZaHF5UkZCQU0r?=
 =?utf-8?B?V2RTaFRNNnVGZ01hcm1odkxicUI4WWRpdXdIT0h6djYwRVpZcHM1WHI0NUZZ?=
 =?utf-8?B?K053Z1pkbWdMTzVQaVdDcWF0Mk11Slh0UlVYdkw1UXFoVzIyLzlEcXJzdUtX?=
 =?utf-8?B?MGc3UXdma1BCdm9iY2FxNWQvOXlSbm12WVpYZ2ZNV2pQNkltdGxQYmE0MUFn?=
 =?utf-8?B?MTVwL1ZGdEdvT0xMYUZVY0MzS3V5cUYzeFVWeU1zc0k1UlA0YzJXV2lSY3du?=
 =?utf-8?B?OGFHenJxVGFzeDQwZUx6d2hWbjZ2TnhnQ3RVM2UxOHRXeFM4akdYTkh2L1Rp?=
 =?utf-8?B?NWxvYVkxOURBbi8xbW5xUVg4dFRnQ0tQRzNEOFllWEM2QlJCYjZzdVg5d1Ay?=
 =?utf-8?B?R0xhdTNSU1hSMWgzcExoWklDOFhBNVA0YUpMTFVwbCtyOXc9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eVZWeG9BVTc3dUloSnNmaXhPZlRnemZJbjVGU0tnb3pGYjVmREViTGRScDJ2?=
 =?utf-8?B?NkxEL1RlbTZpazMrZW13bWZYOW1YWTBvUHNWdms0aWNRL2RGbXpkTWRJbHA1?=
 =?utf-8?B?T0M5SFhtalkreHlzNzJLekVmWHQzeU92Sk9HK0V6d2xrV2FLVGJJUDlTd29X?=
 =?utf-8?B?S3BuMjU5RG43NWRZVDVJalJHK3dyZ3RtTytzaXlBSFhQdEh3TTB3MlVvT1hQ?=
 =?utf-8?B?V2NWeHRoTWttbE1nUEF3K2hIU3ZNWWNaaW4rYm9FL0xIcDkxcmJWZFBZL2Z4?=
 =?utf-8?B?R1dhcVFOK0xlSUx5WVgrdjB6L0NGZk5Vb2JmUVFqcEtpQU5KYi8rRGp3OGxS?=
 =?utf-8?B?cEhkUkFlRTFZZTdiQVZUNmsvSERPUExnUEhBVEJQcjRPR0ZiOU9KV3hRZ3Fx?=
 =?utf-8?B?bExPQ2dHQlVZdVBkZ2hodVV5Vm12Q21OS0ZKYW12cUJESjdtZ0FESFFhcTh2?=
 =?utf-8?B?N2J3NWZLVlRPTks1QkUyeTdHdUxrc2prL1J4NTczZk14bkV4YkNBaGZHU3Ba?=
 =?utf-8?B?Nis2ejRzd2YrQWxIWEFWYkNENHpQZHRFUXZmREV3V2U4b0dVeVlaeWlyRUZ1?=
 =?utf-8?B?bEVEUmUyb0gwNjJaSFhGL2hzRXM5bGxNbWhXNUtPV1R1SThmZkNUN05XQXVn?=
 =?utf-8?B?OUxmcitsejMrZUpiN3V2ZFloWGZFK1VFTjJLbnNrZW56dG45NEFVMlp4VWpJ?=
 =?utf-8?B?bmxtZU5mYXdFMkVsekkxakl2MnQ1WlFKeU9tYWx3MDFSVVpIdWtXQ0I3VFll?=
 =?utf-8?B?eFBwVzRmcEk1QkZOaHBqQ0V4QUpSVzdtaXR6eEExMkgrem4zV3ZTaDV3a3VE?=
 =?utf-8?B?T0FQcy9vbEF3RVlTK09CMnZFUHEralVKMGdoYkZYNXA2MjJKbXNRY25yc3d5?=
 =?utf-8?B?amFQWjFxSUlhMHFuclJULzdjTjdYQzdkSVFrNUdYUGZkR0VyUERKb0dpVmJX?=
 =?utf-8?B?Z2dtRVlnL25OYTZ0YUVORTV2ejJKbkhvVCswL2hyS3E5UkF5V3VvOFExNWRB?=
 =?utf-8?B?VWY5NFhsWWpURFNmdTNQRTc5T1grelM2WkFjQkdCb0FaMHVzUDlUcXBMS1Zz?=
 =?utf-8?B?UHN5WjdSNEJFODBmRDhLbmdNMmNYRlR5VHU5aUxlaHFuZHVRNjFwNWFGeDRj?=
 =?utf-8?B?MVZzeTNRaEQzNnhwR2FlM2pSajhWWWIrenJIc2ZhWjJyU2Z1ekIzZGZxWk9U?=
 =?utf-8?B?ZmwzVnlnRXRjbnl2cG8zdHFtbVFIZWM1blZXdmZlMTJHWGhvWEpJU3R1b1kz?=
 =?utf-8?B?R0VpWTlWUlV0RExEeHl3VkJab1hUOWFuLzJXbkw0cFZqc0hQQVBPYU5XQU9i?=
 =?utf-8?B?dGpLZ244NTlBYU5TdlNNL1ZwYVFaY0dVUW5MQmo4ckRVK3BLUGRoVnNUa2Vw?=
 =?utf-8?B?TGFkUEVqM3BLdnRGdzlCRENmVDhJa2gyTmlvaVlZTndQZlBoQzRETVVXN2tL?=
 =?utf-8?B?eHVFNDRYNnNhTFBuMndqbTZvSjA5M1hVeHpSNkwyT0FxZFZiQjJqdllvbnE5?=
 =?utf-8?B?U1BuTDkvZTJzb0oxWGFFMW5jU3haYWxrYUVyaFFPTW1yVWlmbW93cnFteFlW?=
 =?utf-8?B?VVhDUHgwMW5FZ1IyNXF3ZEhaalhJU2JxNTgwdHp5WlBLYmtNWVBqS3ZKZWd5?=
 =?utf-8?B?THBFeTl3Mk1kNklGSlRHL3Z2eU1qNmxqUFFvb1dpUEtCM04yQ1A4SFNGb1Vy?=
 =?utf-8?B?R2dMeFd1cWgvRVJRWVJ2Q1dDa2dsak8zdUVvTmtoZHdYRFFQbStmNmZpVGcz?=
 =?utf-8?B?T2hHNTg4QXJrNFRVY2tpTkEyOFdrVWs2TXFqM3lYUzRTdUo2K1VQakViaHVh?=
 =?utf-8?B?VFUrR1FMdi9lbFRQUTVqd1ZWckU2cEc2L05Obk1TVUdTQXRONHNFb1B1ZGJH?=
 =?utf-8?B?L3lBejJJYmNtYzVMQUFOZUF2Y1JuTjZTdjlnS0pKNVU0NjZhQTFHVWpOQVRR?=
 =?utf-8?B?NVl3b29iTVEvbGtEaU5CN3FQa0d0WStXSUdKYTJrc0dZclRucjJBSlp0MW0z?=
 =?utf-8?B?eG1ENnpLeVpTemF3R3dnMzZXek02NklFMWQ3ZElick9ITXJYenc4RGZnUDNa?=
 =?utf-8?B?ekF6NTR6M1lsTmRDMXJiaTl3cE5LZGtNV1NyYXhRS1U4UDlEcFN1ektYcUZq?=
 =?utf-8?Q?ECf2+1amESeztfBng9to6/tg+?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 655bc8c4-41f9-4814-1eeb-08dca79b9f80
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jul 2024 02:36:41.6967 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Xs7bHED7lyOnNRR+O4cS7mx1Hpqolp7z0Fo/NvzyxXpX7/AgNH17RcU+eLZBg+SANSlOyv7QGy5+/9tdu9Uo1OY4/VJLMQXBBXalptw/MoE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR11MB6130
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.19;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IEpvYW8gTWFydGlucyA8am9h
by5tLm1hcnRpbnNAb3JhY2xlLmNvbT4NCj5TdWJqZWN0OiBSZTogW1BBVENIIHY0IDA1LzEyXSB2
ZmlvL2lvbW11ZmQ6IEludHJvZHVjZSBhdXRvIGRvbWFpbg0KPmNyZWF0aW9uDQo+DQo+T24gMTgv
MDcvMjAyNCAwODo0NCwgRHVhbiwgWmhlbnpob25nIHdyb3RlOg0KPj4+Pj4+IElmIGV4aXN0aW5n
IGh3cHQgZG9lc24ndCBzdXBwb3J0IGRpcnR5IHRyYWNraW5nLg0KPj4+Pj4+IEFub3RoZXIgZGV2
aWNlIHN1cHBvcnRpbmcgZGlydHkgdHJhY2tpbmcgYXR0YWNoZXMgdG8gdGhhdCBod3B0LCB3aGF0
DQo+Pj4gd2lsbA0KPj4+Pj4gaGFwcGVuPw0KPj4+Pj4+DQo+Pj4+Pg0KPj4+Pj4gSG1tLCBJdCBz
dWNjZWVkcyBhcyB0aGVyZSdzIG5vIGluY29tcGF0YmlsaXR5LiBBdCB0aGUgdmVyeSBsZWFzdCBJ
IHBsYW4NCj5vbg0KPj4+Pj4gYmxvY2tpbmcgbWlncmF0aW9uIGlmIHRoZSBkZXZpY2UgbmVpdGhl
ciBoYXMgVkYgZGlydHkgdHJhY2tpbmcsIG5vcg0KPklPTU1VDQo+Pj4+PiBkaXJ0eQ0KPj4+Pj4g
dHJhY2tpbmcgKGFuZCBwYXRjaCAxMSBuZWVkcyB0byBiZSBhZGp1c3RlZCB0byBjaGVjayBod3B0
X2ZsYWdzDQo+aW5zdGVhZA0KPj4+IG9mDQo+Pj4+PiBjb250YWluZXIpLg0KPj4+Pg0KPj4+PiBX
aGVuIGJjb250YWluZXItPmRpcnR5X3BhZ2VzX3N1cHBvcnRlZCBpcyB0cnVlLCBJIHRoaW5rIHRo
YXQgY29udGFpbmVyDQo+Pj4gc2hvdWxkIG9ubHkgY29udGFpbnMgaHdwdCBsaXN0IHRoYXQgc3Vw
cG9ydCBkaXJ0eSB0cmFja2luZy4gQWxsIGh3cHQgbm90DQo+Pj4gc3VwcG9ydGluZyBkaXJ0eSB0
cmFja2luZyBzaG91bGQgYmUgaW4gb3RoZXIgY29udGFpbmVyLg0KPj4+Pg0KPj4+IFdlbGwgYnV0
IHdlIGFyZSBhZG9wdGluZyB0aGlzIGF1dG8gZG9tYWlucyBzY2hlbWUgYW5kIHdvcmtzIGZvciBh
bnkNCj4+PiBkZXZpY2UsDQo+Pj4gZGlydHkgdHJhY2tpbmcgb3Igbm90LiBXZSBhbHJlYWR5IHRy
YWNrIGh3cHQgZmxhZ3Mgc28gd2Uga25vdyB3aGljaCBvbmVzDQo+Pj4gc3VwcG9ydA0KPj4+IGRp
cnR5IHRyYWNraW5nLiBUaGlzIGRpZmZlcmVudGlhdGlvbiB3b3VsZCAoSU1ITykgY29tcGxpY2F0
ZSBtb3JlIGFuZCBJDQo+YW0NCj4+PiBub3QNCj4+PiBzdXJlIHRoZSBnYWluDQo+Pg0KPj4gT0ss
IEkgd2FzIHRyeWluZyB0byBtYWtlIGJjb250YWluZXItPmRpcnR5X3BhZ2VzX3N1cHBvcnRlZCAg
YWNjdXJhdGUNCj5iZWNhdXNlIGl0IGlzIHVzZWQgaW4gbWFueSBmdW5jdGlvbnMgc3VjaCBhcyB2
ZmlvX2dldF9kaXJ0eV9iaXRtYXAoKSB3aGljaA0KPnJlcXVpcmUgYW4gYWNjdXJhdGUgdmFsdWUu
IElmIHRoZXJlIGlzIG1peCBvZiBod3B0IGluIHRoYXQgY29udGFpbmVyLCB0aGF0J3MNCj5pbXBv
c3NpYmxlLg0KPj4NCj4+IEJ1dCBhcyB5b3Ugc2F5IHlvdSB3YW50IHRvIGFkZHJlc3MgdGhlIG1p
eCBpc3N1ZSBpbiBhIGZvbGxvdy11cCBhbmQNCj5wcmVzdW1lIGFsbCBhcmUgaG9tb2dlbmVvdXMg
aHcgZm9yIG5vdywgdGhlbiBPSywgdGhlcmUgaXMgbm8gY29uZmxpY3QuDQo+Pg0KPg0KPlJpZ2h0
DQo+DQo+Pj4NCj4+Pj4gSWYgZGV2aWNlIHN1cHBvcnRzIGRpcnR5IHRyYWNraW5nLCBpdCBzaG91
bGQgYnlwYXNzIGF0dGFjaGluZyBjb250YWluZXINCj50aGF0DQo+Pj4gZG9lc24ndCBzdXBwb3J0
IGRpcnR5IHRyYWNraW5nLiBWaXNlIHZlcnNhLg0KPj4+PiBUaGlzIHdheSB3ZSBjYW4gc3VwcG9y
dCB0aGUgbWl4aW5nIGVudmlyb25tZW50Lg0KPj4+Pg0KPj4+DQo+Pj4gSXQncyBub3QgdGhhdCBl
YXN5IGFzIHRoZSB3aG9sZSBmbG93IGRvZXNuJ3QgaGFuZGxlIHRoaXMgbWl4ZWQgbW9kZSAoZXZl
bg0KPj4+IGV4Y2x1ZGluZyB0aGlzIHNlcmllcykuIFdlIHdvdWxkIHRvIGhhdmUgZGV2aWNlLWRp
cnR5LXRyYWNraW5nIHN0YXJ0IGFsbA0KPj4+IG5vbi1kaXNhYmxlZCBkZXZpY2UgdHJhY2tlcnMg
Zmlyc3QgW2FuZCBzdG9wIHRoZW0gYXMgd2VsbF0sIGFuZCB0aGVuIHdlDQo+Pj4gd291bGQNCj4+
PiBhbHdheXMgaXRlcmF0ZSB0aG9zZSBmaXJzdCAoaWYgZGV2aWNlIGRpcnR5IHRyYWNrZXJzIGFy
ZSBhY3RpdmUpLCBhbmQgdGhlbg0KPmRlZmVyDQo+Pj4gdG8gSU9NTVUgdHJhY2tlciBmb3IgdGhv
c2Ugd2hvIGRvbid0Lg0KPj4NCj4+IFdoeSBpcyBkZXZpY2UtZGlydHktdHJhY2tpbmcgcHJlZmVy
cmVkIG92ZXIgSU9NTVUgZGlydHkgdHJhY2tpbmc/DQo+PiBJbWFnaW5lIGlmIG1hbnkgZGV2aWNl
cyBhdHRhY2hlZCB0byBzYW1lIGRvbWFpbi4NCj4+DQo+DQo+VGhlIGhldXJpc3RpYyBvciBleHBl
Y3RhdGlvbiBpcyB0aGF0IGRldmljZSBkaXJ0eSB0cmFja2luZyBkb2Vzbid0IGludm9sdmUgYQ0K
PmNvbXByb21pc2UgZm9yIFNXIGJlY2F1c2UgaXQgY2FuIGEpIHBlcmZvcm0gbG93ZXN0IGdyYW51
bGFyaXR5IG9mIElPVkENCj5yYW5nZQ0KPmJlaW5nIGRpcnR5IHdpdGggYikgbm8gRE1BIHBlbmFs
dHkuIFdpdGggSU9NTVUgdGhvdWdoLCBTVyBuZWVkcyB0bw0KPndvcnJ5IGFib3V0DQo+bWFuYWdp
bmcgcGFnZSB0YWJsZXMgdG8gZGljdGF0ZSB0aGUgZ3JhbnVsYXJpdHkgYW5kIHRob3NlIHRha2Ug
dGltZSB0byB3YWxrDQo+dGhlDQo+ZGVlcGVyIHRoZSBsZXZlbCB3ZSBkZXNjZW5kIGludG8uIEkg
dXNlZCB0byB0aGluayB0aGF0IElPTU1VIHdlIGhhdmUgRE1BDQo+cGVuYWx0eQ0KPihiZWNhdXNl
IG9mIHRoZSBJT1RMQiBmbHVzaGVzIHRvIGNsZWFyIGRpcnR5IGJpdCwgYW5kIElPVExCIGNhY2hl
IG1pc3NlcykgYnV0IEkNCj5oYXZlbid0IHlldCB0aGF0IG1hdGVyaWFsaXplZCBpbiB0aGUgZmll
bGQgeWV0IChhdCBsZWFzdCBmb3IgMTAwR2JpdC9zIHJhdGVzKS4NCj4NCj5UTDtEUiBBdCB0aGUg
ZW5kIG9mIHRoZSBkYXkgd2l0aCBkZXZpY2UgZGlydHkgdHJhY2tpbmcgeW91IGhhdmUgbGVzcyB0
byB3b3JyeQ0KPmFib3V0LCBhbmQgaXQncyB0aGUgVkYgZG9pbmcgbW9zdCBvZiB0aGUgaGVhdnkg
bGlmdGluZy4gSW4gdGhlb3J5IHdpdGggZGV2aWNlDQo+ZGlydHkgdHJhY2tpbmcgeW91IGNvdWxk
IGV2ZW4gcGVyZm9ybSBzdWIgYmFzZXBhZ2UgdHJhY2tpbmcgaWYgdGhlIGRldmljZQ0KPmFsbG93
cw0KPml0IHRvIGRvIHNvLg0KDQpDbGVhciwgdGhhbmtzIEpvYW8uDQoNCkJScy4NClpoZW56aG9u
Zw0K

