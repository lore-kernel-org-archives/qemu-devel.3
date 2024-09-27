Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65B9ECEBF76
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2024 06:39:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1su4cg-000590-2r; Fri, 27 Sep 2024 02:38:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1su4cd-00052R-Vb
 for qemu-devel@nongnu.org; Fri, 27 Sep 2024 02:38:35 -0400
Received: from mgamail.intel.com ([192.198.163.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1su4ca-0006Ve-Ux
 for qemu-devel@nongnu.org; Fri, 27 Sep 2024 02:38:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1727419113; x=1758955113;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=IJPQm9d76/JamrbGOWN7G9GFLfaaiP0yTaifsNeFuyU=;
 b=aGVQxRkTzdJMIW3hx8NVVY+rjEgW2Fcqy5YICd39PtDr69meQ3iIuDjY
 lTlyCaM7xvM4JkO4wV/jec68VqHw9diaFwS7qJcSx+TKnPGAUmPki9z8n
 wHLjGeek2b7ODUYrrOgmoSiDbW1Km21OLSTjWsmN9yaqb+hiGVesAr3ZG
 jz1aA0ijUFPOtogqUldu0Ebg9S6R/75FcrDW/OjwUFyIy2mzmyF1YE80r
 GryTjWz8u01pPK9V5VI/hvjlgzDCnajZuENuGpC/v2+pY99B3JwtvThIT
 rQJYCECi9czkFu2Xu4tHOh9uKWMk50GYmFFo+8IY8LKuvEdaxqnN5tk35 w==;
X-CSE-ConnectionGUID: qrVwKQhCQw68kuiyTpsjnA==
X-CSE-MsgGUID: HcxXByqxRJyJ6wMRC6CEpg==
X-IronPort-AV: E=McAfee;i="6700,10204,11207"; a="26718620"
X-IronPort-AV: E=Sophos;i="6.11,157,1725346800"; d="scan'208";a="26718620"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Sep 2024 23:38:29 -0700
X-CSE-ConnectionGUID: kkrAsSwTRimbhFEvOnUxdA==
X-CSE-MsgGUID: 28jWpsWpTp+L1ak1AUFo/A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,157,1725346800"; d="scan'208";a="77379470"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
 by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 26 Sep 2024 23:38:29 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 26 Sep 2024 23:38:29 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 26 Sep 2024 23:38:29 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.171)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 26 Sep 2024 23:38:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x4mE5S3B3I+bF1N0w2xzAXikjo7pfamM5dOqEKD2afpi2E7SbmfafvOntt6KqkSoPtwkcNxmHBx8Kb2xMntRWzIhzOqZRswWZy5meAO6xGh94Bdd6MD9i6oLj9KkRdlgaLDfJwy5ZtGC0c+MVoRVwGZkaVgDh24XsRDJcL22rEMk4L9LFgaF937amtfsYYyQbEn2/3DrlMxtCunCvVPfwaTnKMneK79+9kGxnUHt3D9lRiTWrovrbu1UYh+Kjim02CSRnNdXM5/UmKDs69VRXiAmDuCVOf9Y22u8Uf+uLdFnzHYij7wjv21vz0UQUnXrdE0IjNyx87qFm/X4yzxeww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IJPQm9d76/JamrbGOWN7G9GFLfaaiP0yTaifsNeFuyU=;
 b=VKjmbV2GdnnxBT0KxpmQck0X82jsGQL6fohVah6V8j8NIy1tFF4M8vMtw6jVjC9D2nMxxPdqGU8zVJyg7XmfsrUaZ8NufO1QfBX8jb9+XrU1dwHjk4RTOs5Z4ymudjTxi4I3OsH9ByxBHRsRGBVPA819Y6TMnDw9KwcCwIlCd4mvozdZYAdmkf/LrZ50U+7TNeAmfDdG/z8VzY8lj0iT7+1Jvgz4YyJwhZ0b8LvKz+Xgb9fzFoLd3jEYY3DZQh6ECPDV1x4QMlKh6ZD7I2V2HNVQeyvBxYtE5r7z5nVtXRd1KYZ6OoSAhdSpydvDxiq4hKwmYr7UN+SZhvt9hPmCcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by LV8PR11MB8745.namprd11.prod.outlook.com (2603:10b6:408:204::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.21; Fri, 27 Sep
 2024 06:38:26 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091%6]) with mapi id 15.20.7982.022; Fri, 27 Sep 2024
 06:38:26 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: Jason Wang <jasowang@redhat.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>, "clg@redhat.com"
 <clg@redhat.com>, "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>, "peterx@redhat.com" <peterx@redhat.com>,
 "jgg@nvidia.com" <jgg@nvidia.com>, "nicolinc@nvidia.com"
 <nicolinc@nvidia.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "clement.mathieu--drif@eviden.com"
 <clement.mathieu--drif@eviden.com>, "Tian, Kevin" <kevin.tian@intel.com>,
 "Liu, Yi L" <yi.l.liu@intel.com>, "Peng, Chao P" <chao.p.peng@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson
 <richard.henderson@linaro.org>, Eduardo Habkost <eduardo@habkost.net>, Marcel
 Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: RE: [PATCH v3 04/17] intel_iommu: Flush stage-2 cache in
 PASID-selective PASID-based iotlb invalidation
Thread-Topic: [PATCH v3 04/17] intel_iommu: Flush stage-2 cache in
 PASID-selective PASID-based iotlb invalidation
Thread-Index: AQHbBAshkYI6tchrmkeNdE4jQwxi9rJrF7oAgAAfeBA=
Date: Fri, 27 Sep 2024 06:38:26 +0000
Message-ID: <SJ0PR11MB6744791E1C56E6D91A2CA3B3926B2@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20240911052255.1294071-1-zhenzhong.duan@intel.com>
 <20240911052255.1294071-5-zhenzhong.duan@intel.com>
 <CACGkMEvvmY=k=Op56A0RP4sm8u_8CmDckmiQX+QF_NtWEHtefw@mail.gmail.com>
In-Reply-To: <CACGkMEvvmY=k=Op56A0RP4sm8u_8CmDckmiQX+QF_NtWEHtefw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|LV8PR11MB8745:EE_
x-ms-office365-filtering-correlation-id: 947480dd-8881-4851-c41e-08dcdebefde7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|7416014|366016|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?NGVRTGpoTlp6YVYxRnIzb1k4OUgyZ2pydEFCWWo2QnZYOEMySEpSVWhNSVAy?=
 =?utf-8?B?RkRHbTFFaHdDRUkzSWhDMG9wYkh5NzJHWUsxRHhBM1ZwVmp4QWwyb0xnR0Vy?=
 =?utf-8?B?U1ZjNy9hQ2habFBLSEJtSjk1dE9DcTQ2WnBrVTFBQzFZTFFuY1Baa1h4cmph?=
 =?utf-8?B?aWhHVCt4RGdEZ3gveFFreTNoVUdvOTU0bkZ2UHFuRCtMNTVPSDJGV1MxbWkz?=
 =?utf-8?B?K1BTZG1aRWVXN0tHZHBkV3pha2JZK2tjQjQ5R2YvaDh2bjR2L3hNUFd0L2My?=
 =?utf-8?B?ZVMrb2pIck1pOFI4M1FlTmdzVXdWR0lHb1pKNTF0cjFORytDWWF4MUcvNFhF?=
 =?utf-8?B?VXVRUTVXQll3NnVlNzY1KzN6bThPYTRNb0pYeTRYVkpwY2tUcHpBSUR0UUFX?=
 =?utf-8?B?VGVlOUpZYTJacXlWTTJIYSszdTE4c3JHWVd2dnB1VmNSNS9kaEZPT21BU0Uv?=
 =?utf-8?B?bERFR29DVkVwejdkRmdvYmxzYnUwQjhsbWV5Q29VYnErODlEK1JXd0Q4VGZK?=
 =?utf-8?B?NExpMDZNeHhQeEsvUzVtZ0t4T2h6cjI5RkVTMTlzS3paZTcvR05EeWtmamQr?=
 =?utf-8?B?d0NVL1o1QzhaTUtXdHBNMXVVTUFNbCt3c053NFZ2Yy9hZUFwa3J5TFp4T2RY?=
 =?utf-8?B?dDJZSjM1VHZiQklBV3pLQ0VVZExnUFliY1ZlL3Z0dUdoMndRSGdoNnRpeUJS?=
 =?utf-8?B?WlNQMjdzMG5HVi9PQ0JGL2dzS2xPZjRVdzJreHp6TkhudFBXVVBkOHRMUlp0?=
 =?utf-8?B?d1JDVEU3elhZejMxNEVaWTJ6WEpIMlFjL3U4MUhEYUN1K21mR0lZNDJLWk9r?=
 =?utf-8?B?R3VqS0FUZVFWUzZYbTdGQjZKNWNjVnI1ekdtVStiOWpnWHQwUTArV05zKzhS?=
 =?utf-8?B?MDNDODE0emJqZ21Xd05JVm1neWd4OHd6bmROQmJXYUFueVkyeWRnMXByVU5q?=
 =?utf-8?B?R0JNMUd4a0hPUjlUUmpoT2JIbUg0R3VOS3ZTcXBnRDlaS1RwS0xCbjBkSUVX?=
 =?utf-8?B?ZnB3Qkk3S2IrSDRBZldrOUJ6NE9kNHZ6T1hiYU9aQnpXMWRtZjBYYnRCd2V2?=
 =?utf-8?B?d1NOY0s4dVNsUmYvUUNyVldBbnZERWdkaUlMOTBzSUN3dzZLTURRL3BIOTd2?=
 =?utf-8?B?ZmxnWGNVcHNOWHNEV05ta0hxSjB0ZGh1RVlLUVlXSVQxTG4yR3lBWjlybnho?=
 =?utf-8?B?OWhpL1FxSTNRcUxxb1UrMG85NzJqQUh2QkQ3M2hpbm03ZjZOaWJaRThQOEtB?=
 =?utf-8?B?eVBucHhOa2t5b3ViTTM2QmpNUmZnV0RHbXpnZENQNmI0RVQ4MmtWYmdicm40?=
 =?utf-8?B?ZEJEZFFvZ2JjZmkzdDNIRVNFbTcwanpuYU1GSlcyektWdmdueVFuQ2Z4YUpY?=
 =?utf-8?B?NmJ4MXQxQytFdzR3OEpKekZqeVFWTENwNmJhaXlINFdGZmZrOGtqOGh3dTF3?=
 =?utf-8?B?aE5lNG4xQzV3NlJ0eTVyWGd3ZU9uSFU1THFZaDhhdzYwNGdNdGM0SE1qaW5a?=
 =?utf-8?B?RjVqWlRLVFo2VFVGUzlhY29CdTY3TmVMNzN2dE1aNzRBYUkvNVhlVWFIbWor?=
 =?utf-8?B?d0tVL1d6NWFPcXVhRjdXaElDOGw2TTJzMWRZTTA4Yk5ueXlxVzVsRTVVOVpV?=
 =?utf-8?B?QS8vcm5pTHJNQ0RpYzZOa3hUaVh0WE1pcmhHVDBVTkh6WmZnNUlLKzJuK3Rp?=
 =?utf-8?B?ZXUrK1ZJU0NRcUdDSGkyMDM5amp3c3RMME8vc3Q5enZjbFpPVzNFcW9WMksw?=
 =?utf-8?B?RjZPV09ScDYwMDRZUnMvMFZ3MkJkbDk2Q0tDdXhNK1krZUlaMmI1K0lGUEEw?=
 =?utf-8?B?OVJJenFkU09KbStaZzY4Z3QySUgzYW5pYnA0T1ozZGxlNmowT0VEZmNieUUv?=
 =?utf-8?B?d0E5VE9FaWtoZkR1cm11dXJ2ZnFPbFF0YkxYQW9NZlRiNXc9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eWRSWktNUnNXUFd1L0hPYWNjaWRteHlEVDJFZ2hHWjk2alUreGtoc3FqenR0?=
 =?utf-8?B?TkpwM0lRTUxoOFZQZlhPa2JkQ0VGZFBOVHd2VFM4NjI0RTIvV3JNOUJ4VTdn?=
 =?utf-8?B?eS9MUUZjWFdGeG9sREczaDVid0gzNzUyeENDVkEveTBIRTdqTEdQOWJuR1JI?=
 =?utf-8?B?MjVlV0Zjbk83bHdBaWV6VjhZcno0SUVZOHFCSFA3ekZqeWxZaEFDZGM1aER4?=
 =?utf-8?B?REo1WkljZGZLNzV1bGV3R3FZekptSzd1OENpcHRETS83bW9QSzNOS1RMU1FK?=
 =?utf-8?B?K0UrRlpBNkt6amc5RXFxUytSUTc2SlF3MDhmQjJZcys2THFpWlJEc0FBWGxq?=
 =?utf-8?B?TzRnM3NobHM1NUE5Q1BiQmZCdHMxd0V5U3NjVXk0b1JWczc0ZDB2ZXB5dzAr?=
 =?utf-8?B?dHRHTWJTZ1BrcHhVb0FETXZaZ2VZbXphVTVpSUtLTlBNRjBzOWZmSDMyUFZG?=
 =?utf-8?B?V24zUEVDdFZ2TmQ1VTJNYmlNYUVpVXZLQVBQUDJVYXMwN0hNbkp1MXRnSGxN?=
 =?utf-8?B?NStRYWpJUFNOUGJiR05aOTg5RFBJa2JoQkY1L1pSZFo0cEZXcEtMbEJ4Sk5O?=
 =?utf-8?B?amQ4aGpDMStMYTVZbUUvNW56dFVLVlB0K3ZpV2JLYzdUcXYyTU1kd1JlNGVC?=
 =?utf-8?B?Z2xNU1FFcHd1R0ltc1dKd21YWkFzL0d2aDZ0WnFYZzdiRmxXY0RjM3pPMURE?=
 =?utf-8?B?bzd0a2NOQU9ZZHk5QWJDYVEvZlpLLzVaL0xPWEFvSElZLy80NU8ydlYvQVFm?=
 =?utf-8?B?M05SSHNVOXZrY2F6aE0wWGFDWDhNMm4yNkJRRE5LdzNQMkF2Z3doaEw0NWRa?=
 =?utf-8?B?K2xPTWZFQVQzZlBEVXRic01aMi9xL05rSlRXejlJSVYwOXdMcnhXcXFuWjYr?=
 =?utf-8?B?T0wwREptTE9FVjR1MFBqeEpYem9lZ241RXEyMmZ5dkpSMjVoRysveGJZbktz?=
 =?utf-8?B?YVMwNXB5UzhPUGpvUmVEMzY0UWtJSWVsLzB6eXVBRFFtSHgvRm13NjV0NHpH?=
 =?utf-8?B?c3RyYlJJZXRoV3VhbEk3UkRjWnd6MCtmSG5paFRMM0ZCTThTTzAvQ0NUVVNZ?=
 =?utf-8?B?cUNNaTdHL1JEV2tGdjNuV3dNU2JQaXFRQm8wUzRSTlZlcWJ2TFZRdXdvcHpo?=
 =?utf-8?B?cndlZUFTNWhYVlozYWF0QklISE9uVCtKcGxLVUpKL2s5Q0VBT0pzL0hSMDVS?=
 =?utf-8?B?WGFpWVFTR0x4SWhnbkd3TFNmWTJFMHorWXRKRmVMUWVpUVBORHdJcHVJNXpV?=
 =?utf-8?B?VXZ5SEVxUnZRT3VEY1FHaEpSSk1DNVBicGFyS2FZb3Q3N2xPSTdLVGtPTTNV?=
 =?utf-8?B?Y2M0YTdFcElwWTVieWZTWE4xUjBLRW1NcXJUWG11TFNmVmkwcHNoTWpSRzNj?=
 =?utf-8?B?NzRUaEhRUk1kOGFuZVhsbUgxM1BVRklwL1JmR094UStiY1pwTGNXNGw4Ulo5?=
 =?utf-8?B?OTRNWUVmbTBTcDFIWHNkcWJIVitFRUNwcEtvTG1XNjJncEN6Mnczd1pXVURL?=
 =?utf-8?B?T0tHa1JJbXp1NzdsS0dDMHhWSXAzdVk3OFUzM2pCcFJMWStYc0R5U0xMZTZt?=
 =?utf-8?B?THZnZllvS25jaHQyMEpJRm9lVFBBQ3NTU3pCUFJDQktuMUhiRjVNdFVRV2g4?=
 =?utf-8?B?UGlySTA4YzZvWFdnNFlrbE1raVFYdmI0YUdlaWwwRWNwM3NSc1g2UnF1RnRa?=
 =?utf-8?B?c3RMMmtxdzRkSzVDTy9oRDlWYzVWeU9WR0Z1T0YrclFJKzM0NGdBWHZWbkNs?=
 =?utf-8?B?NDVSQ0FHSURKbDFsQkVyOUxBZGcwOWM2NkxvbE1BNy91VkZQb3pWL01LWS9I?=
 =?utf-8?B?a2xvdlNtZUlIbXl1aGI3L3RmazRYVXlNYUZveWlJNGovVEZZOUwrVm9VNWUr?=
 =?utf-8?B?VGx6YkhRcDIwUTdWdnI1RDVKN0wxaHY0cVUydlhBUGp4WlliYjZQdEZZL2tT?=
 =?utf-8?B?WWM5RTRkakFvRlltM1BJakxqUWpZMHhWSzN2TGszWnZxbHdwWVhQL2txTlZX?=
 =?utf-8?B?VzRXaUNoVXdPbHlhcEN4amtDY0UwZ0FwbktpYzhCaUJMSWd3UFdmQkZnek5v?=
 =?utf-8?B?SWh3eUphTWJvRGh3My9oUDZHNEdoeVE3TXNoek9BUEl0ZlB0dlRGakdpK0Za?=
 =?utf-8?Q?BaYBLkvcLQIG8azciFt1/shJ0?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 947480dd-8881-4851-c41e-08dcdebefde7
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Sep 2024 06:38:26.4492 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: U4PiQFJWYw2JKEFgpW/xhE+874GgZYsdIk06OWjLdsIZf4nNSEnJEV5y3vCKX4SaD/ekVEFcox47wV4iSPohB6mb6MVCk9w7uuqLQK+4fs4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8745
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.15;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.131,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IEphc29uIFdhbmcgPGphc293
YW5nQHJlZGhhdC5jb20+DQo+U3ViamVjdDogUmU6IFtQQVRDSCB2MyAwNC8xN10gaW50ZWxfaW9t
bXU6IEZsdXNoIHN0YWdlLTIgY2FjaGUgaW4gUEFTSUQtDQo+c2VsZWN0aXZlIFBBU0lELWJhc2Vk
IGlvdGxiIGludmFsaWRhdGlvbg0KPg0KPk9uIFdlZCwgU2VwIDExLCAyMDI0IGF0IDE6MjbigK9Q
TSBaaGVuemhvbmcgRHVhbg0KPjx6aGVuemhvbmcuZHVhbkBpbnRlbC5jb20+IHdyb3RlOg0KPj4N
Cj4+IFBlciBzcGVjIDYuNS4yLjQsIFBBRElELXNlbGVjdGl2ZSBQQVNJRC1iYXNlZCBpb3RsYiBp
bnZhbGlkYXRpb24gd2lsbA0KPj4gZmx1c2ggc3RhZ2UtMiBpb3RsYiBlbnRyaWVzIHdpdGggbWF0
Y2hpbmcgZG9tYWluIGlkIGFuZCBwYXNpZC4NCj4+DQo+PiBXaXRoIHNjYWxhYmxlIG1vZGVybiBt
b2RlIGludHJvZHVjZWQsIGd1ZXN0IGNvdWxkIHNlbmQgUEFTSUQtc2VsZWN0aXZlDQo+PiBQQVNJ
RC1iYXNlZCBpb3RsYiBpbnZhbGlkYXRpb24gdG8gZmx1c2ggYm90aCBzdGFnZS0xIGFuZCBzdGFn
ZS0yIGVudHJpZXMuDQo+Pg0KPj4gQnkgdGhpcyBjaGFuY2UsIHJlbW92ZSBvbGQgSU9UTEIgcmVs
YXRlZCBkZWZpbml0aW9uLg0KPg0KPk5pdDogaWYgdGhlcmUncyBhIHJlc3BpbiB3ZSdkIGJldHRl
ciBzYXkgdGhvc2UgZGVmaW5pdGlvbnMgaXMgdW51c2VkLg0KDQpTdXJlLCB3aWxsIGJlOg0KDQoi
QnkgdGhpcyBjaGFuY2UsIHJlbW92ZSBvbGQgSU9UTEIgcmVsYXRlZCBkZWZpbml0aW9ucyB3aGlj
aCB3ZXJlIHVudXNlZC4iDQoNClRoYW5rcw0KWmhlbnpob25nDQoNCj4NCj5PdGhlciB0aGFuIHRo
aXMNCj4NCj5BY2tlZC1ieTogSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4NCj4NCj5U
aGFua3MNCj4NCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBaaGVuemhvbmcgRHVhbiA8emhlbnpob25n
LmR1YW5AaW50ZWwuY29tPg0KPj4gLS0tDQo+PiAgaHcvaTM4Ni9pbnRlbF9pb21tdV9pbnRlcm5h
bC5oIHwgMTQgKysrLS0tDQo+PiAgaHcvaTM4Ni9pbnRlbF9pb21tdS5jICAgICAgICAgIHwgODEN
Cj4rKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrDQo+PiAgMiBmaWxlcyBjaGFuZ2Vk
LCA5MCBpbnNlcnRpb25zKCspLCA1IGRlbGV0aW9ucygtKQ0KPj4NCj4+IGRpZmYgLS1naXQgYS9o
dy9pMzg2L2ludGVsX2lvbW11X2ludGVybmFsLmgNCj5iL2h3L2kzODYvaW50ZWxfaW9tbXVfaW50
ZXJuYWwuaA0KPj4gaW5kZXggOGZhMjdjN2YzYi4uMTllNGVkNTJjYSAxMDA2NDQNCj4+IC0tLSBh
L2h3L2kzODYvaW50ZWxfaW9tbXVfaW50ZXJuYWwuaA0KPj4gKysrIGIvaHcvaTM4Ni9pbnRlbF9p
b21tdV9pbnRlcm5hbC5oDQo+PiBAQCAtNDAyLDExICs0MDIsNiBAQCB0eXBlZGVmIHVuaW9uIFZU
REludkRlc2MgVlRESW52RGVzYzsNCj4+ICAjZGVmaW5lIFZURF9JTlZfREVTQ19JT1RMQl9BTSh2
YWwpICAgICAgKCh2YWwpICYgMHgzZlVMTCkNCj4+ICAjZGVmaW5lIFZURF9JTlZfREVTQ19JT1RM
Ql9SU1ZEX0xPICAgICAgMHhmZmZmZmZmZjAwMDBmZjAwVUxMDQo+PiAgI2RlZmluZSBWVERfSU5W
X0RFU0NfSU9UTEJfUlNWRF9ISSAgICAgIDB4ZjgwVUxMDQo+PiAtI2RlZmluZSBWVERfSU5WX0RF
U0NfSU9UTEJfUEFTSURfUEFTSUQgICgyVUxMIDw8IDQpDQo+PiAtI2RlZmluZSBWVERfSU5WX0RF
U0NfSU9UTEJfUEFTSURfUEFHRSAgICgzVUxMIDw8IDQpDQo+PiAtI2RlZmluZSBWVERfSU5WX0RF
U0NfSU9UTEJfUEFTSUQodmFsKSAgICgoKHZhbCkgPj4gMzIpICYNCj5WVERfUEFTSURfSURfTUFT
SykNCj4+IC0jZGVmaW5lIFZURF9JTlZfREVTQ19JT1RMQl9QQVNJRF9SU1ZEX0xPDQo+MHhmZmYw
MDAwMDAwMDAwMWMwVUxMDQo+PiAtI2RlZmluZSBWVERfSU5WX0RFU0NfSU9UTEJfUEFTSURfUlNW
RF9ISSAgICAgIDB4ZjgwVUxMDQo+Pg0KPj4gIC8qIE1hc2sgZm9yIERldmljZSBJT1RMQiBJbnZh
bGlkYXRlIERlc2NyaXB0b3IgKi8NCj4+ICAjZGVmaW5lIFZURF9JTlZfREVTQ19ERVZJQ0VfSU9U
TEJfQUREUih2YWwpICgodmFsKSAmDQo+MHhmZmZmZmZmZmZmZmZmMDAwVUxMKQ0KPj4gQEAgLTQz
OCw2ICs0MzMsMTUgQEAgdHlwZWRlZiB1bmlvbiBWVERJbnZEZXNjIFZUREludkRlc2M7DQo+PiAg
ICAgICAgICAoMHgzZmZmZjgwMFVMTCB8IH4oVlREX0hBV19NQVNLKGF3KSB8IFZURF9TTF9JR05f
Q09NIHwNCj5WVERfU0xfVE0pKSA6IFwNCj4+ICAgICAgICAgICgweDNmZmZmODAwVUxMIHwgfihW
VERfSEFXX01BU0soYXcpIHwgVlREX1NMX0lHTl9DT00pKQ0KPj4NCj4+ICsvKiBNYXNrcyBmb3Ig
UElPVExCIEludmFsaWRhdGUgRGVzY3JpcHRvciAqLw0KPj4gKyNkZWZpbmUgVlREX0lOVl9ERVND
X1BJT1RMQl9HICAgICAgICAgICAgICgzVUxMIDw8IDQpDQo+PiArI2RlZmluZSBWVERfSU5WX0RF
U0NfUElPVExCX0FMTF9JTl9QQVNJRCAgKDJVTEwgPDwgNCkNCj4+ICsjZGVmaW5lIFZURF9JTlZf
REVTQ19QSU9UTEJfUFNJX0lOX1BBU0lEICAoM1VMTCA8PCA0KQ0KPj4gKyNkZWZpbmUgVlREX0lO
Vl9ERVNDX1BJT1RMQl9ESUQodmFsKSAgICAgICgoKHZhbCkgPj4gMTYpICYNCj5WVERfRE9NQUlO
X0lEX01BU0spDQo+PiArI2RlZmluZSBWVERfSU5WX0RFU0NfUElPVExCX1BBU0lEKHZhbCkgICAg
KCgodmFsKSA+PiAzMikgJiAweGZmZmZmVUxMKQ0KPj4gKyNkZWZpbmUgVlREX0lOVl9ERVNDX1BJ
T1RMQl9SU1ZEX1ZBTDAgICAgIDB4ZmZmMDAwMDAwMDAwZjFjMFVMTA0KPj4gKyNkZWZpbmUgVlRE
X0lOVl9ERVNDX1BJT1RMQl9SU1ZEX1ZBTDEgICAgIDB4ZjgwVUxMDQo+PiArDQo+PiAgLyogSW5m
b3JtYXRpb24gYWJvdXQgcGFnZS1zZWxlY3RpdmUgSU9UTEIgaW52YWxpZGF0ZSAqLw0KPj4gIHN0
cnVjdCBWVERJT1RMQlBhZ2VJbnZJbmZvIHsNCj4+ICAgICAgdWludDE2X3QgZG9tYWluX2lkOw0K
Pj4gZGlmZiAtLWdpdCBhL2h3L2kzODYvaW50ZWxfaW9tbXUuYyBiL2h3L2kzODYvaW50ZWxfaW9t
bXUuYw0KPj4gaW5kZXggNTdjMjRmNjdiNC4uYmUzMGNhZWYzMSAxMDA2NDQNCj4+IC0tLSBhL2h3
L2kzODYvaW50ZWxfaW9tbXUuYw0KPj4gKysrIGIvaHcvaTM4Ni9pbnRlbF9pb21tdS5jDQo+PiBA
QCAtMjY1Niw2ICsyNjU2LDgzIEBAIHN0YXRpYyBib29sDQo+dnRkX3Byb2Nlc3NfaW90bGJfZGVz
YyhJbnRlbElPTU1VU3RhdGUgKnMsIFZUREludkRlc2MgKmludl9kZXNjKQ0KPj4gICAgICByZXR1
cm4gdHJ1ZTsNCj4+ICB9DQo+Pg0KPj4gK3N0YXRpYyBnYm9vbGVhbiB2dGRfaGFzaF9yZW1vdmVf
YnlfcGFzaWQoZ3BvaW50ZXIga2V5LCBncG9pbnRlciB2YWx1ZSwNCj4+ICsgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIGdwb2ludGVyIHVzZXJfZGF0YSkNCj4+ICt7DQo+
PiArICAgIFZURElPVExCRW50cnkgKmVudHJ5ID0gKFZURElPVExCRW50cnkgKil2YWx1ZTsNCj4+
ICsgICAgVlRESU9UTEJQYWdlSW52SW5mbyAqaW5mbyA9IChWVERJT1RMQlBhZ2VJbnZJbmZvICop
dXNlcl9kYXRhOw0KPj4gKw0KPj4gKyAgICByZXR1cm4gKChlbnRyeS0+ZG9tYWluX2lkID09IGlu
Zm8tPmRvbWFpbl9pZCkgJiYNCj4+ICsgICAgICAgICAgICAoZW50cnktPnBhc2lkID09IGluZm8t
PnBhc2lkKSk7DQo+PiArfQ0KPj4gKw0KPj4gK3N0YXRpYyB2b2lkIHZ0ZF9waW90bGJfcGFzaWRf
aW52YWxpZGF0ZShJbnRlbElPTU1VU3RhdGUgKnMsDQo+PiArICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIHVpbnQxNl90IGRvbWFpbl9pZCwgdWludDMyX3QgcGFzaWQpDQo+
PiArew0KPj4gKyAgICBWVERJT1RMQlBhZ2VJbnZJbmZvIGluZm87DQo+PiArICAgIFZUREFkZHJl
c3NTcGFjZSAqdnRkX2FzOw0KPj4gKyAgICBWVERDb250ZXh0RW50cnkgY2U7DQo+PiArDQo+PiAr
ICAgIGluZm8uZG9tYWluX2lkID0gZG9tYWluX2lkOw0KPj4gKyAgICBpbmZvLnBhc2lkID0gcGFz
aWQ7DQo+PiArDQo+PiArICAgIHZ0ZF9pb21tdV9sb2NrKHMpOw0KPj4gKyAgICBnX2hhc2hfdGFi
bGVfZm9yZWFjaF9yZW1vdmUocy0+aW90bGIsIHZ0ZF9oYXNoX3JlbW92ZV9ieV9wYXNpZCwNCj4+
ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICZpbmZvKTsNCj4+ICsgICAgdnRkX2lv
bW11X3VubG9jayhzKTsNCj4+ICsNCj4+ICsgICAgUUxJU1RfRk9SRUFDSCh2dGRfYXMsICZzLT52
dGRfYXNfd2l0aF9ub3RpZmllcnMsIG5leHQpIHsNCj4+ICsgICAgICAgIGlmICghdnRkX2Rldl90
b19jb250ZXh0X2VudHJ5KHMsIHBjaV9idXNfbnVtKHZ0ZF9hcy0+YnVzKSwNCj4+ICsgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHZ0ZF9hcy0+ZGV2Zm4sICZjZSkgJiYNCj4+
ICsgICAgICAgICAgICBkb21haW5faWQgPT0gdnRkX2dldF9kb21haW5faWQocywgJmNlLCB2dGRf
YXMtPnBhc2lkKSkgew0KPj4gKyAgICAgICAgICAgIHVpbnQzMl90IHJpZDJwYXNpZCA9IFZURF9D
RV9HRVRfUklEMlBBU0lEKCZjZSk7DQo+PiArDQo+PiArICAgICAgICAgICAgaWYgKCh2dGRfYXMt
PnBhc2lkICE9IFBDSV9OT19QQVNJRCB8fCBwYXNpZCAhPSByaWQycGFzaWQpICYmDQo+PiArICAg
ICAgICAgICAgICAgIHZ0ZF9hcy0+cGFzaWQgIT0gcGFzaWQpIHsNCj4+ICsgICAgICAgICAgICAg
ICAgY29udGludWU7DQo+PiArICAgICAgICAgICAgfQ0KPj4gKw0KPj4gKyAgICAgICAgICAgIGlm
ICghcy0+c2NhbGFibGVfbW9kZXJuKSB7DQo+PiArICAgICAgICAgICAgICAgIHZ0ZF9hZGRyZXNz
X3NwYWNlX3N5bmModnRkX2FzKTsNCj4+ICsgICAgICAgICAgICB9DQo+PiArICAgICAgICB9DQo+
PiArICAgIH0NCj4+ICt9DQo+PiArDQo+PiArc3RhdGljIGJvb2wgdnRkX3Byb2Nlc3NfcGlvdGxi
X2Rlc2MoSW50ZWxJT01NVVN0YXRlICpzLA0KPj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIFZUREludkRlc2MgKmludl9kZXNjKQ0KPj4gK3sNCj4+ICsgICAgdWludDE2X3Qg
ZG9tYWluX2lkOw0KPj4gKyAgICB1aW50MzJfdCBwYXNpZDsNCj4+ICsNCj4+ICsgICAgaWYgKChp
bnZfZGVzYy0+dmFsWzBdICYgVlREX0lOVl9ERVNDX1BJT1RMQl9SU1ZEX1ZBTDApIHx8DQo+PiAr
ICAgICAgICAoaW52X2Rlc2MtPnZhbFsxXSAmIFZURF9JTlZfREVTQ19QSU9UTEJfUlNWRF9WQUwx
KSkgew0KPj4gKyAgICAgICAgZXJyb3JfcmVwb3J0X29uY2UoIiVzOiBpbnZhbGlkIHBpb3RsYiBp
bnYgZGVzYyBoaT0weCUiUFJJeDY0DQo+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAiIGxv
PTB4JSJQUkl4NjQiIChyZXNlcnZlZCBiaXRzIHVuemVybykiLA0KPj4gKyAgICAgICAgICAgICAg
ICAgICAgICAgICAgX19mdW5jX18sIGludl9kZXNjLT52YWxbMV0sIGludl9kZXNjLT52YWxbMF0p
Ow0KPj4gKyAgICAgICAgcmV0dXJuIGZhbHNlOw0KPj4gKyAgICB9DQo+PiArDQo+PiArICAgIGRv
bWFpbl9pZCA9IFZURF9JTlZfREVTQ19QSU9UTEJfRElEKGludl9kZXNjLT52YWxbMF0pOw0KPj4g
KyAgICBwYXNpZCA9IFZURF9JTlZfREVTQ19QSU9UTEJfUEFTSUQoaW52X2Rlc2MtPnZhbFswXSk7
DQo+PiArICAgIHN3aXRjaCAoaW52X2Rlc2MtPnZhbFswXSAmIFZURF9JTlZfREVTQ19QSU9UTEJf
Rykgew0KPj4gKyAgICBjYXNlIFZURF9JTlZfREVTQ19QSU9UTEJfQUxMX0lOX1BBU0lEOg0KPj4g
KyAgICAgICAgdnRkX3Bpb3RsYl9wYXNpZF9pbnZhbGlkYXRlKHMsIGRvbWFpbl9pZCwgcGFzaWQp
Ow0KPj4gKyAgICAgICAgYnJlYWs7DQo+PiArDQo+PiArICAgIGNhc2UgVlREX0lOVl9ERVNDX1BJ
T1RMQl9QU0lfSU5fUEFTSUQ6DQo+PiArICAgICAgICBicmVhazsNCj4+ICsNCj4+ICsgICAgZGVm
YXVsdDoNCj4+ICsgICAgICAgIGVycm9yX3JlcG9ydF9vbmNlKCIlczogaW52YWxpZCBwaW90bGIg
aW52IGRlc2M6IGhpPTB4JSJQUkl4NjQNCj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICIs
IGxvPTB4JSJQUkl4NjQiICh0eXBlIG1pc21hdGNoOiAweCVsbHgpIiwNCj4+ICsgICAgICAgICAg
ICAgICAgICAgICAgICAgIF9fZnVuY19fLCBpbnZfZGVzYy0+dmFsWzFdLCBpbnZfZGVzYy0+dmFs
WzBdLA0KPj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgaW52X2Rlc2MtPnZhbFswXSAmIFZU
RF9JTlZfREVTQ19JT1RMQl9HKTsNCj4+ICsgICAgICAgIHJldHVybiBmYWxzZTsNCj4+ICsgICAg
fQ0KPj4gKyAgICByZXR1cm4gdHJ1ZTsNCj4+ICt9DQo+PiArDQo+PiAgc3RhdGljIGJvb2wgdnRk
X3Byb2Nlc3NfaW52X2llY19kZXNjKEludGVsSU9NTVVTdGF0ZSAqcywNCj4+ICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgVlRESW52RGVzYyAqaW52X2Rlc2MpDQo+PiAgew0K
Pj4gQEAgLTI3NzUsNiArMjg1MiwxMCBAQCBzdGF0aWMgYm9vbA0KPnZ0ZF9wcm9jZXNzX2ludl9k
ZXNjKEludGVsSU9NTVVTdGF0ZSAqcykNCj4+ICAgICAgICAgIGJyZWFrOw0KPj4NCj4+ICAgICAg
Y2FzZSBWVERfSU5WX0RFU0NfUElPVExCOg0KPj4gKyAgICAgICAgdHJhY2VfdnRkX2ludl9kZXNj
KCJwLWlvdGxiIiwgaW52X2Rlc2MudmFsWzFdLCBpbnZfZGVzYy52YWxbMF0pOw0KPj4gKyAgICAg
ICAgaWYgKCF2dGRfcHJvY2Vzc19waW90bGJfZGVzYyhzLCAmaW52X2Rlc2MpKSB7DQo+PiArICAg
ICAgICAgICAgcmV0dXJuIGZhbHNlOw0KPj4gKyAgICAgICAgfQ0KPj4gICAgICAgICAgYnJlYWs7
DQo+Pg0KPj4gICAgICBjYXNlIFZURF9JTlZfREVTQ19XQUlUOg0KPj4gLS0NCj4+IDIuMzQuMQ0K
Pj4NCg0K

