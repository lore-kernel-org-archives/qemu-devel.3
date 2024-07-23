Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAE53C3DA49
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2024 08:21:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWAlt-0002F4-BL; Tue, 23 Jul 2024 04:21:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sWAlm-0002ED-Bx
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 04:21:15 -0400
Received: from mgamail.intel.com ([198.175.65.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sWAlf-0000R4-Ro
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 04:21:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1721722868; x=1753258868;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=7+zn80Bm2N4he1gWgiUahfVhUE3F05wmL5pssZ8oPPI=;
 b=hxWlQKW/WUWXDCQF/Hn5R4n6bkHRxcB0Ntjl0Sb0lMjBm3BSkiXK+b0l
 SoNXBbbocNFJZP8NHqir3iTw+6o9J1LdwBymcRvbj/Gzq2lk00mCk+dNN
 6s7FsQtW3tXtC3jnMRZhpo2s6lSLtLbKOR5UyHKglqBr9EKu2SgC2Avkl
 AOnYikhAQYaF7yMHhk4/GhtRn57YVvN86DaevH2M4vBJfZw853LVX1iPh
 geb6S/PnJk8z9VtrK1tT5o2pj6HRpv6sY0MSwCs+CZ0fs3GQGe+dWKEEt
 K98wDnMkkDXbRQFN+JBRcwPSR5V3ogKVM6WJ2HJevkxSAOnmQ5hcIW2lM w==;
X-CSE-ConnectionGUID: JASlc3/7RBeL2u6p83Ozeg==
X-CSE-MsgGUID: Fc0KLGIUQJCozH1RYsQmrA==
X-IronPort-AV: E=McAfee;i="6700,10204,11141"; a="23134138"
X-IronPort-AV: E=Sophos;i="6.09,230,1716274800"; d="scan'208";a="23134138"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jul 2024 01:21:02 -0700
X-CSE-ConnectionGUID: TTIoQfiDSAOmiCGtd3XhbA==
X-CSE-MsgGUID: SkopOidpSVysPhmqt9qYtw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,230,1716274800"; d="scan'208";a="57009535"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
 by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 23 Jul 2024 01:21:01 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 23 Jul 2024 01:21:00 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 23 Jul 2024 01:21:00 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.172)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 23 Jul 2024 01:21:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IFpp7RwV/+xT2IiHBa19WDbU+jXowP4pCPvBApKrcblbXjLoKUxBOGusSrEcRnnqp5F/hb3xpsN1aK/9gIVNfd4+Uo9sEVXDFUsLmLtljzbEWgaYCTJlRrjjkNX1BB1THR1U8m3s6Pr1fEExthNeEiPY3GKeoyQ1eM6wjBxGXnlzDvmUXXzvt6voWisUvJDzEbTFRpsLS9pWRLofrqwLorMNNLIWIBCZxSoIc3M5NkdejAAE8eOT+jz91LiXNXVRY8/PCTxjX1Ygh/wc9fPGEDgOIPqkbZEZ4BfCCcxy9Qt62wCT4pApVxJzmWE0Ime5jwDzxWdkRAzJ8tcOSM0HZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7+zn80Bm2N4he1gWgiUahfVhUE3F05wmL5pssZ8oPPI=;
 b=YmNBnZgVPt+C/riNQGJdMaaozuFp3WZAVV+D9YPz/+/pjl+oi0w4ZPxk4Dzahb7VMg64nmug2CLAn3Bo8MfsPcWsJ+zwUIr9GqzEQyo5ddJCUpHZpK6VqAo2K80PJN8WRn19Tx/Ucdxw6XBNu5KkU1zG8xA1RqwSDDHh67tiIrL7RjsAARqOKjdmb5R1iw6A8nGfp12tkDwgj9o8HO7e2I7C6R+zmd9KMxUjNdvwlzUOMiF8S2hG2wIwlI2BwGgtiLNS+EA1qggM7cjdLslU5ghRH1/0+RAXYIGR68t5K27Q6Rkvv5q82zrGxWAum/1GZKkJKNhseswtlLuQkRz+TA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by CH3PR11MB7939.namprd11.prod.outlook.com (2603:10b6:610:131::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.17; Tue, 23 Jul
 2024 08:20:58 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091%7]) with mapi id 15.20.7784.016; Tue, 23 Jul 2024
 08:20:58 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: Joao Martins <joao.m.martins@oracle.com>, "eric.auger@redhat.com"
 <eric.auger@redhat.com>, =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?=
 <clg@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "Liu, Yi L" <yi.l.liu@intel.com>, Alex Williamson
 <alex.williamson@redhat.com>, Jason Gunthorpe <jgg@nvidia.com>, Avihai Horon
 <avihaih@nvidia.com>
Subject: RE: [PATCH v6 4/9] vfio/{iommufd,container}: Invoke
 HostIOMMUDevice::realize() during attach_device()
Thread-Topic: [PATCH v6 4/9] vfio/{iommufd,container}: Invoke
 HostIOMMUDevice::realize() during attach_device()
Thread-Index: AQHa3Hwb3oIU1aKXKkuZrieKAn9u7bID7awAgAABy4CAAAMDAIAAAtmAgAAD58A=
Date: Tue, 23 Jul 2024 08:20:57 +0000
Message-ID: <SJ0PR11MB674475ED43B94625DC359AA992A92@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20240722211326.70162-1-joao.m.martins@oracle.com>
 <20240722211326.70162-5-joao.m.martins@oracle.com>
 <a1cc917a-7fa7-43da-b7b7-1b69308400b0@redhat.com>
 <eae669f6-f24f-4573-9934-2c6fb5b364ad@redhat.com>
 <8405600f-ffa2-43c2-8e51-7b6674de11ae@redhat.com>
 <e0ad88d2-c78d-4d28-9655-08fd5a92fe2b@oracle.com>
In-Reply-To: <e0ad88d2-c78d-4d28-9655-08fd5a92fe2b@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|CH3PR11MB7939:EE_
x-ms-office365-filtering-correlation-id: 9eb0e8f6-d02c-4bbb-a6aa-08dcaaf0613e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?RWVwVFAzK2xWMmZzUVZwNmZaL00rcm43bEszYjFxcjFwUTBsMlpQNm4zSy8x?=
 =?utf-8?B?Tmcrc2tvNVdoQ01jZldZNXE0WStLa04wTUtyT05xcEIzTHg3UDNpNVFHSGVC?=
 =?utf-8?B?YVpVQUErR2NGSHl4VEhOMnhJa0hzOVpCWkVjU3FhSDlTUDczOGR4MkFCVXdt?=
 =?utf-8?B?OTRoT1c1eUZGOEhETEVWRUtFRWxlMTVnVzJGNHpLS2RpbEFud0xaQVdXaU12?=
 =?utf-8?B?RXB5WEVDWUpKd2l2YjZiUE5NeWpQbzFNWFBkZXFDNWZTVGdUaWw3TllkMGQ0?=
 =?utf-8?B?ajNmOEQwTkJvMWpXblFRbmE3ZnNoZ2h5Uy9NelcyRHJHbXh5YkJDMGpUSzh0?=
 =?utf-8?B?VU4rRzdvZGZEZXd4cHplL1RGLytPYkFZU1hCVGpneWgxaFFMTmlDSld1dERT?=
 =?utf-8?B?aUltZE9RNU9nSXhqaDR4SmYwRVhjdWdIZFM1aCttQjlWcHlnODBqcHVOZExF?=
 =?utf-8?B?QWcxSFVxSXoyNkg0UjZ0d0EwTGhTTUtHQTl4b0Y0eGFnU2U3NjNJdi9HTlNh?=
 =?utf-8?B?L2ZIK3RCZERMRmMzYVd1bExOVzMzck5Sd2MzT3BybXR6L2FjUFZ5YUhqYmNS?=
 =?utf-8?B?MkIxOVlwRFQ5NjhLeVdlWXdXSTdWMHo2cUFOMmJtQ3p6Mkh0ckM5RHEwN25H?=
 =?utf-8?B?WVl3VHAzaUs4MllqQkE4azZIbXJCQ2ZqYUV1a2pQTUNIMzF2Y0hVcVMxSkQw?=
 =?utf-8?B?aFlmb1k4NXhRMEpOazFUNjd6ZUsvZklvcmV0Z1ZKTUcvbU95VVQ2S1ZNTW1M?=
 =?utf-8?B?czNSNWNCY0kvclpTbW9IMUZaYTZDR1pQR0UzVU03OVB2WTNzMnJ6WCsxV0Zs?=
 =?utf-8?B?dHVzak5mNTJLVnhyMy9vK2xWbTZxTnZsd1YzZHkzOEVtU0RrbHVoL1k3MzJs?=
 =?utf-8?B?MUh5T3RHelU3MWdXYTR4Q0I0UTI4cllSM2k4aXNRMkFGZEI3SkRZWDE2aloz?=
 =?utf-8?B?cmQwTGxLd2JITkUrcDdUZDhYdHJZUTFVZzNaVXA5Nzg1SVh1L29kQ2I5R1hU?=
 =?utf-8?B?bWFjckVUbjFEQlJVK29rU0lVTTJJYm9zUXdDanpFSzBXaVVjVG5zTzBIWGVB?=
 =?utf-8?B?K2Q5WjBpejBqUnkreHZqdzdiSU5xeHpNVTBDcFliUkJGWXhxYXgydFFBYVdT?=
 =?utf-8?B?ZDhERlBkRXE2K0V5VGdGNzNIbXYrbHdzUlQrckJweGRUVmJnV1oySUtaU0ZS?=
 =?utf-8?B?QmgxUlgvWGh3SkovS3R5OUw0VDRnYm5PUHExT0RCRThjRFdtV0traXVmVTU0?=
 =?utf-8?B?NFRBeEtCQ2krSFJ2aGJPT1ZsMVNyZStQaU9leEhmY3luRWtsT1ZZL09nYWda?=
 =?utf-8?B?NEl0SlpmS1ltemY0UUh3YStVMG9YTFVmelpucEEyeWVSdXlkbzFGMGpwdWNl?=
 =?utf-8?B?Ny9QM2REdWZVeFQyWGtOQ20rT2N0aXpmRzdqRUtaQnowQzZZamN1Vm1tc2V4?=
 =?utf-8?B?Tlh1YmpRWFA0VGxTSVN3R09hb3I0aGErTkVoazVCN2JEWnZ6d3NOTWFNb29N?=
 =?utf-8?B?ckVnK25JMmhCb0thSHBVUDZpMW9wc0VwMHZvcXB1MjRjUHJmV29TSXNrNzBn?=
 =?utf-8?B?YXVOMDRvZ1Jjc0dXb3lSdlRlK3VFR1lKaFNRQk84amVRS0hHU1pCWnJ6K2ps?=
 =?utf-8?B?d21ua25yeStsZGQvazVVVUVpOTcyOXUzNGM4SXk1SmhPWmFQN055NUMrd2lP?=
 =?utf-8?B?UnIvb3RHdFdLMkNCcmpMNUpmWFlVb3hOK0FNTWVtK3hwVVZvd1VXODlxZUtR?=
 =?utf-8?B?dm1Gd3JKeDZpbm1sS0pjSE9WNGZYSWtiQ24xaDZGZDJHaHh2N1Rpek5jcFVs?=
 =?utf-8?B?RUZndlJOU040RlRXTnROL2dvL1lWVDNqa3Z6ei9Lc2ZNQ2pOY3dHMmpoZzRP?=
 =?utf-8?B?MEVIL08wUFUrenpVZlJXNUlYaU9jdTBuZ0p0SkQyeW5aTlE9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?K1d3TDE2VmN4OVl1eWxSKzIxalgxRFJkSlNYOHpzM09WdXdneXZ6aDg5QS9C?=
 =?utf-8?B?M0xKaytvMGt0aUdhZHQ0dE8wMlNLL1lsVFE5d2t1V1dlVG5sSTlwdmdmVGh6?=
 =?utf-8?B?WU8xbzdOWXBsaHR1M013U1czTGJWem5zUzIvYWM4NC9sZFZpZkZFYUEyN0Js?=
 =?utf-8?B?eG5rMGFZQlZkcDVXZStaeWQ5amN5blBMRmIzblR2Y3NSa1hFRDB3QVBucFZO?=
 =?utf-8?B?bFNYOUd0OTF4T3hPNGRqWUIxNVBrZU02ZGRIMzE5VkdYQUwrekhEcHBqamNx?=
 =?utf-8?B?MDdoL3VWdmJETWNvMm44d0YwYXcrc3NMZWloVnBTWkkvVnNpL3ZxblZKSkVY?=
 =?utf-8?B?dWtvaE04YnpuSGJ5Mjg4K3VlZGtpcXBqYmVPNUdJUXFaeXNtZWE1RWhpZzlC?=
 =?utf-8?B?M2dRVW9BZTJtY0pac0VrWG9iekgzQmdaOXp6NWw4bGtjc21HZmxRN0hxQ2lI?=
 =?utf-8?B?V1N0dDNqNHFyVERQVFNMYTJCMUN4MWRhbW1oVXZITTlKeHdKZ1pFb2RDR08w?=
 =?utf-8?B?STdhQ3hzZUNUNEd4WnNkcGJZbm9LMlAveU13d1FBUHFGbFpWcWY1U2VLU3RI?=
 =?utf-8?B?Ulg5NVBna2Z3QndPQ1hPV0ZUTFErTnRHcHZEWGxSMDFlRFhWMjdUSjZuQmh4?=
 =?utf-8?B?V0RWRVRhL1ZaSmJEL1VHdXNOd25sQ3VwNlFQLzliZmdKRGIyL3RsaTJranFC?=
 =?utf-8?B?NlV6N2Z0bTJwU3FpcmE3cHNJRDU5cG5sUWkxYmMwSGhoa09aaHptY210SzU5?=
 =?utf-8?B?L0VSVUVkYWdUa3Y4QndVQUtKY200ZjRxQzJsTS9KOG9QdzcvUWNyWXZmbzhk?=
 =?utf-8?B?NnU2NlZoWm16WWVXNTA3SXFhODlGY3hJNmNXemxHSmJNMU9JYTI4bTVWMDZH?=
 =?utf-8?B?dFJEcnQ2cm9rZE40cm56ZlJJZ2h5MnV5c2ZVb0hIclRmOUxXOEVwUWdDOVRK?=
 =?utf-8?B?Qm93SnRqYjMyT1RUYU85U2FTWU5XdlhaV3JuT2toSWx4SEpKTW5GcGl0bDll?=
 =?utf-8?B?YndQTWNvL3J3TVJpdWNxU3JBZnBYY3JTakZSRHlsUkVQcnM3UC9jd2pwTUJ4?=
 =?utf-8?B?TW5haUFOdjJCRzh2aEtvd3JvT3ZSVEVSWGZ6aUhCeDNPcXNMZXR1UFVmKzNF?=
 =?utf-8?B?QjNRUFZ3alAvNFJXU1A1aXpINXZKM3ZKS2pucDRER0pCaGJMWFBBVTk5dzVT?=
 =?utf-8?B?YnY4NFU1SDVKMjVzM2lQUTBLM0NVNzRoL1dFeHdJd0x1clBQR3pxbkRoNDRI?=
 =?utf-8?B?WlV3NFFLWFE1ZlRDclFyMDVONkR6QXpEajdLUHdHUGNvL2lWNVlUNGxMRmph?=
 =?utf-8?B?TUxScEkydVJjcEFJNnBVUHNlUUdNZnUrbHpxRUdTTk1XZE9kdjBXQmdldTFy?=
 =?utf-8?B?cW9KVnZOdVpHSVlrZHpDcDZxdTI3TC96MW1yTG5rUzZ6SUhVOFp3M2h6T0pT?=
 =?utf-8?B?K0NiLzd0TU0zMXQvQTB2V3VEb1JRZTZWaDBWenczSWpHK3ZQV25qazhIS0I2?=
 =?utf-8?B?bHVHcllkVit3Y2ZsZnBQYXlCRXc3ckVVZEVMam5kOXVoT000TzQ0d2ZubnFO?=
 =?utf-8?B?bHBGeXoxNWhSWDB0MitYNU10MTc2Z1g1MkdUZ3h5cVNKU2JHazhSeGNJbTJz?=
 =?utf-8?B?a000UkJjd1c0a1N3MFJaeWN4VmxUN3BaOVFyWXMydFdkTER1WkRTZEUzQllq?=
 =?utf-8?B?UkRCMTEyai83d1ZQSUg5ZHM2SVN6R2JSelRmd2dxdFpZc2ZXK1YvUDR0THVq?=
 =?utf-8?B?QmwrdUFvMUhyb0pSM1YyQ0dqUkY0K0pyS09NeUlJTkNDR0NaUmNMY004NEc2?=
 =?utf-8?B?WnZXY0xvcHB2ZE8xNzhrZnlxNmgrVzRFNGJXeVQyaFBOYks1L2p5MndmNHZj?=
 =?utf-8?B?WWNFS21TMXlyZkxSL1Q1bExqQURxQVA1ek1ZNmd6SUhGU1hqdkwrYVFGakJ2?=
 =?utf-8?B?RmV6OHVhK0lIL0M1TEU2L3pzMXZneXBrUzE4Y3l2QmJWMVpnSE83aEw1OHFS?=
 =?utf-8?B?MUpTZ3JvVkIrdE9vNjVpN3JGeWxaa2s2bHpCTVJlV2NYelMzWGJ3Ky9qNW4w?=
 =?utf-8?B?RHgxNzN3eHFQYW41alpiQzVrZ2Rlc0luQmJheTc2dC9CS24wK1dvT3ZoVzdI?=
 =?utf-8?Q?4d/IC9oK6fdx6xCtTP8/yB3rt?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9eb0e8f6-d02c-4bbb-a6aa-08dcaaf0613e
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jul 2024 08:20:57.9514 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: n0mxdEFNdXJIjbz7NsWyyKsPdzyRDAjUX2KMOQLefRmn3TXfCbNaz22RgTkIjgWtaclFiYFT/g3PTHOZ1J0Al+XcuuPVzZF7ePQQf2/LVmw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7939
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.14;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.133,
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
by5tLm1hcnRpbnNAb3JhY2xlLmNvbT4NCj5TdWJqZWN0OiBSZTogW1BBVENIIHY2IDQvOV0gdmZp
by97aW9tbXVmZCxjb250YWluZXJ9OiBJbnZva2UNCj5Ib3N0SU9NTVVEZXZpY2U6OnJlYWxpemUo
KSBkdXJpbmcgYXR0YWNoX2RldmljZSgpDQo+DQo+T24gMjMvMDcvMjAyNCAwODo1NSwgRXJpYyBB
dWdlciB3cm90ZToNCj4+DQo+Pg0KPj4gT24gNy8yMy8yNCAwOTo0NCwgQ8OpZHJpYyBMZSBHb2F0
ZXIgd3JvdGU6DQo+Pj4gT24gNy8yMy8yNCAwOTozOCwgRXJpYyBBdWdlciB3cm90ZToNCj4+Pj4g
SGkgSm9hbywNCj4+Pj4NCj4+Pj4gT24gNy8yMi8yNCAyMzoxMywgSm9hbyBNYXJ0aW5zIHdyb3Rl
Og0KPj4+Pj4gTW92ZSB0aGUgSG9zdElPTU1VRGV2aWNlOjpyZWFsaXplKCkgdG8gYmUgaW52b2tl
ZCBkdXJpbmcgdGhlIGF0dGFjaA0KPj4+Pj4gb2YgdGhlIGRldmljZQ0KPj4+Pj4gYmVmb3JlIHdl
IGFsbG9jYXRlIElPTU1VRkQgaGFyZHdhcmUgcGFnZXRhYmxlIG9iamVjdHMgKEhXUFQpLiBUaGlz
DQo+Pj4+PiBhbGxvd3MgdGhlIHVzZQ0KPj4+Pj4gb2YgdGhlIGh3X2NhcHMgb2J0YWluZWQgYnkg
SU9NTVVfR0VUX0hXX0lORk8gdGhhdCBlc3NlbnRpYWxseQ0KPnRlbGwNCj4+Pj4+IGlmIHRoZSBJ
T01NVQ0KPj4+Pj4gYmVoaW5kIHRoZSBkZXZpY2Ugc3VwcG9ydHMgZGlydHkgdHJhY2tpbmcuDQo+
Pj4+Pg0KPj4+Pj4gTm90ZTogVGhlIEhvc3RJT01NVURldmljZSBkYXRhIGZyb20gbGVnYWN5IGJh
Y2tlbmQgaXMgc3RhdGljIGFuZA0KPj4+Pj4gZG9lc24ndA0KPj4+Pj4gbmVlZCBhbnkgaW5mb3Jt
YXRpb24gZnJvbSB0aGUgKHR5cGUxLWlvbW11KSBiYWNrZW5kIHRvIGJlDQo+aW5pdGlhbGl6ZWQu
DQo+Pj4+PiBJbiBjb250cmFzdCBob3dldmVyLCB0aGUgSU9NTVVGRCBIb3N0SU9NTVVEZXZpY2Ug
ZGF0YSByZXF1aXJlcw0KPnRoZQ0KPj4+Pj4gaW9tbXVmZCBGRCB0byBiZSBjb25uZWN0ZWQgYW5k
IGhhdmluZyBhIGRldmlkIHRvIGJlIGFibGUgdG8NCj4+Pj4+IHN1Y2Nlc3NmdWxseQ0KPj4+PiBO
aXQ6IG1heWJlIHRoaXMgY29tbWVudCBzaGFsbCBiZSBhbHNvIGFkZGVkIGluIGlvbW11ZmQuYyBi
ZWZvcmUgdGhlDQo+Y2FsbA0KPj4+PiB0byB2ZmlvX2RldmljZV9oaW9kX3JlYWxpemUoKSB0byBh
dm9pZCBzb21lb25lIGVsc2UgdG8gbW92ZSB0aGF0IGNhbGwNCj4+Pj4gZWFybGllciBhdCBzb21l
IHBvaW50DQo+Pj4+PiBHRVRfSFdfSU5GTy4gVGhpcyBtZWFucyB2ZmlvX2RldmljZV9oaW9kX3Jl
YWxpemUoKSBpcyBjYWxsZWQgaW4NCj4+Pj4+IGRpZmZlcmVudCBwbGFjZXMgd2l0aGluIHRoZSBi
YWNrZW5kIC5hdHRhY2hfZGV2aWNlKCkgaW1wbGVtZW50YXRpb24uDQo+Pj4+Pg0KPj4+Pj4gU3Vn
Z2VzdGVkLWJ5OiBDw6lkcmljIExlIEdvYXRlciA8Y2xnQHJlZGhhdC5jbT4NCj4+Pj4+IFNpZ25l
ZC1vZmYtYnk6IEpvYW8gTWFydGlucyA8am9hby5tLm1hcnRpbnNAb3JhY2xlLmNvbT4NCj4+Pj4+
IFJldmlld2VkLWJ5OiBaaGVuemhvbmcgRHVhbiA8emhlbnpob25nLmR1YW5AaW50ZWwuY29tPg0K
Pj4+Pj4gLS0tDQo+Pj4+PiDCoCBpbmNsdWRlL2h3L3ZmaW8vdmZpby1jb21tb24uaCB8wqAgMSAr
DQo+Pj4+PiDCoCBody92ZmlvL2NvbW1vbi5jwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfCAx
NiArKysrKystLS0tLS0tLS0tDQo+Pj4+PiDCoCBody92ZmlvL2NvbnRhaW5lci5jwqDCoMKgwqDC
oMKgwqDCoMKgwqAgfMKgIDQgKysrKw0KPj4+Pj4gwqAgaHcvdmZpby9oZWxwZXJzLmPCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgfCAxMSArKysrKysrKysrKw0KPj4+Pj4gwqAgaHcvdmZpby9pb21t
dWZkLmPCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKgIDQgKysrKw0KPj4+Pj4gwqAgNSBmaWxl
cyBjaGFuZ2VkLCAyNiBpbnNlcnRpb25zKCspLCAxMCBkZWxldGlvbnMoLSkNCj4+Pj4+DQo+Pj4+
PiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9ody92ZmlvL3ZmaW8tY29tbW9uLmgNCj4+Pj4+IGIvaW5j
bHVkZS9ody92ZmlvL3ZmaW8tY29tbW9uLmgNCj4+Pj4+IGluZGV4IDFhOTY2NzhmOGMzOC4uNGU0
NGIyNmQzYzQ1IDEwMDY0NA0KPj4+Pj4gLS0tIGEvaW5jbHVkZS9ody92ZmlvL3ZmaW8tY29tbW9u
LmgNCj4+Pj4+ICsrKyBiL2luY2x1ZGUvaHcvdmZpby92ZmlvLWNvbW1vbi5oDQo+Pj4+PiBAQCAt
MjQyLDYgKzI0Miw3IEBAIHZvaWQgdmZpb19yZWdpb25fZmluYWxpemUoVkZJT1JlZ2lvbiAqcmVn
aW9uKTsNCj4+Pj4+IMKgIHZvaWQgdmZpb19yZXNldF9oYW5kbGVyKHZvaWQgKm9wYXF1ZSk7DQo+
Pj4+PiDCoCBzdHJ1Y3QgdmZpb19kZXZpY2VfaW5mbyAqdmZpb19nZXRfZGV2aWNlX2luZm8oaW50
IGZkKTsNCj4+Pj4+IMKgIGJvb2wgdmZpb19kZXZpY2VfaXNfbWRldihWRklPRGV2aWNlICp2YmFz
ZWRldik7DQo+Pj4+PiArYm9vbCB2ZmlvX2RldmljZV9oaW9kX3JlYWxpemUoVkZJT0RldmljZSAq
dmJhc2VkZXYsIEVycm9yICoqZXJycCk7DQo+Pj4+PiDCoCBib29sIHZmaW9fYXR0YWNoX2Rldmlj
ZShjaGFyICpuYW1lLCBWRklPRGV2aWNlICp2YmFzZWRldiwNCj4+Pj4+IMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIEFkZHJlc3NTcGFjZSAqYXMsIEVy
cm9yICoqZXJycCk7DQo+Pj4+PiDCoCB2b2lkIHZmaW9fZGV0YWNoX2RldmljZShWRklPRGV2aWNl
ICp2YmFzZWRldik7DQo+Pj4+PiBkaWZmIC0tZ2l0IGEvaHcvdmZpby9jb21tb24uYyBiL2h3L3Zm
aW8vY29tbW9uLmMNCj4+Pj4+IGluZGV4IDc4NGUyNjZlNmFhYi4uZGExMmNiZDU2NDA4IDEwMDY0
NA0KPj4+Pj4gLS0tIGEvaHcvdmZpby9jb21tb24uYw0KPj4+Pj4gKysrIGIvaHcvdmZpby9jb21t
b24uYw0KPj4+Pj4gQEAgLTE1MzcsNyArMTUzNyw3IEBAIGJvb2wgdmZpb19hdHRhY2hfZGV2aWNl
KGNoYXIgKm5hbWUsDQo+VkZJT0RldmljZQ0KPj4+Pj4gKnZiYXNlZGV2LA0KPj4+Pj4gwqAgew0K
Pj4+Pj4gwqDCoMKgwqDCoCBjb25zdCBWRklPSU9NTVVDbGFzcyAqb3BzID0NCj4+Pj4+DQo+Pj4+
Pg0KPlZGSU9fSU9NTVVfQ0xBU1Mob2JqZWN0X2NsYXNzX2J5X25hbWUoVFlQRV9WRklPX0lPTU1V
X0xFR0FDWSkpOw0KPj4+Pj4gLcKgwqDCoCBIb3N0SU9NTVVEZXZpY2UgKmhpb2Q7DQo+Pj4+PiAr
wqDCoMKgIEhvc3RJT01NVURldmljZSAqaGlvZCA9IE5VTEw7DQo+Pj4+PiDCoCDCoMKgwqDCoMKg
IGlmICh2YmFzZWRldi0+aW9tbXVmZCkgew0KPj4+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgIG9wcyA9
DQo+Pj4+Pg0KPlZGSU9fSU9NTVVfQ0xBU1Mob2JqZWN0X2NsYXNzX2J5X25hbWUoVFlQRV9WRklP
X0lPTU1VX0lPTU1VRg0KPkQpKTsNCj4+Pj4+IEBAIC0xNTQ1LDIxICsxNTQ1LDE3IEBAIGJvb2wg
dmZpb19hdHRhY2hfZGV2aWNlKGNoYXIgKm5hbWUsDQo+Pj4+PiBWRklPRGV2aWNlICp2YmFzZWRl
diwNCj4+Pj4+IMKgIMKgwqDCoMKgwqAgYXNzZXJ0KG9wcyk7DQo+Pj4+PiDCoCAtwqDCoMKgIGlm
ICghb3BzLT5hdHRhY2hfZGV2aWNlKG5hbWUsIHZiYXNlZGV2LCBhcywgZXJycCkpIHsNCj4+Pj4+
IC3CoMKgwqDCoMKgwqDCoCByZXR1cm4gZmFsc2U7DQo+Pj4+PiAtwqDCoMKgIH0NCj4+Pj4+IMKg
IC3CoMKgwqAgaWYgKHZiYXNlZGV2LT5tZGV2KSB7DQo+Pj4+PiAtwqDCoMKgwqDCoMKgwqAgcmV0
dXJuIHRydWU7DQo+Pj4+PiArwqDCoMKgIGlmICghdmJhc2VkZXYtPm1kZXYpIHsNCj4+Pj4+ICvC
oMKgwqDCoMKgwqDCoCBoaW9kID0gSE9TVF9JT01NVV9ERVZJQ0Uob2JqZWN0X25ldyhvcHMtDQo+
Pmhpb2RfdHlwZW5hbWUpKTsNCj4+Pj4+ICvCoMKgwqDCoMKgwqDCoCB2YmFzZWRldi0+aGlvZCA9
IGhpb2Q7DQo+Pj4+PiDCoMKgwqDCoMKgIH0NCj4+Pj4+IMKgIC3CoMKgwqAgaGlvZCA9IEhPU1Rf
SU9NTVVfREVWSUNFKG9iamVjdF9uZXcob3BzLT5oaW9kX3R5cGVuYW1lKSk7DQo+Pj4+PiAtwqDC
oMKgIGlmICghSE9TVF9JT01NVV9ERVZJQ0VfR0VUX0NMQVNTKGhpb2QpLT5yZWFsaXplKGhpb2Qs
DQo+dmJhc2VkZXYsDQo+Pj4+PiBlcnJwKSkgew0KPj4+Pj4gK8KgwqDCoCBpZiAoIW9wcy0+YXR0
YWNoX2RldmljZShuYW1lLCB2YmFzZWRldiwgYXMsIGVycnApKSB7DQo+Pj4+PiDCoMKgwqDCoMKg
wqDCoMKgwqAgb2JqZWN0X3VucmVmKGhpb2QpOw0KPj4+Pj4gLcKgwqDCoMKgwqDCoMKgIG9wcy0+
ZGV0YWNoX2RldmljZSh2YmFzZWRldik7DQo+Pj4+PiArwqDCoMKgwqDCoMKgwqAgdmJhc2VkZXYt
Pmhpb2QgPSBOVUxMOw0KPj4+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgIHJldHVybiBmYWxzZTsNCj4+
Pj4+IMKgwqDCoMKgwqAgfQ0KPj4+Pj4gLcKgwqDCoCB2YmFzZWRldi0+aGlvZCA9IGhpb2Q7DQo+
Pj4+PiDCoCDCoMKgwqDCoMKgIHJldHVybiB0cnVlOw0KPj4+Pj4gwqAgfQ0KPj4+Pj4gZGlmZiAt
LWdpdCBhL2h3L3ZmaW8vY29udGFpbmVyLmMgYi9ody92ZmlvL2NvbnRhaW5lci5jDQo+Pj4+PiBp
bmRleCAxMGNiNGI0MzIwYWMuLjljY2RiNjM5YWM4NCAxMDA2NDQNCj4+Pj4+IC0tLSBhL2h3L3Zm
aW8vY29udGFpbmVyLmMNCj4+Pj4+ICsrKyBiL2h3L3ZmaW8vY29udGFpbmVyLmMNCj4+Pj4+IEBA
IC05MTQsNiArOTE0LDEwIEBAIHN0YXRpYyBib29sIHZmaW9fbGVnYWN5X2F0dGFjaF9kZXZpY2Uo
Y29uc3QNCj4+Pj4+IGNoYXIgKm5hbWUsIFZGSU9EZXZpY2UgKnZiYXNlZGV2LA0KPj4+Pj4gwqAg
wqDCoMKgwqDCoCB0cmFjZV92ZmlvX2F0dGFjaF9kZXZpY2UodmJhc2VkZXYtPm5hbWUsIGdyb3Vw
aWQpOw0KPj4+Pj4gwqAgK8KgwqDCoCBpZiAoIXZmaW9fZGV2aWNlX2hpb2RfcmVhbGl6ZSh2YmFz
ZWRldiwgZXJycCkpIHsNCj4+Pj4+ICvCoMKgwqDCoMKgwqDCoCByZXR1cm4gZmFsc2U7DQo+Pj4+
IGRvbid0IHlvdSB3YW50IHRvIGdvIHRvIGVycl9hbGxvY19pb2FzIGluc3RlYWQ/DQo+Pj4NCj4+
PiBobW0sIHRoZSBlcnJfYWxsb2NfaW9hcyBsYWJlbCBpcyBpbiBhIGRpZmZlcmVudCBmdW5jdGlv
bg0KPj4+IGlvbW11ZmRfY2Rldl9hdHRhY2goKS4NCj4+Pg0KPj4+IG1heSBiZSB5b3UgbWVhbnQg
dGhlIGNvbW1lbnQgZm9yIHJvdXRpbmUgaW9tbXVmZF9jZGV2X2F0dGFjaCgpIGFuZA0KPj4+IGxh
YmVsIGVycl9jb25uZWN0X2JpbmQgPw0KPj4+DQo+Pj4NCj4+PiBUaGFua3MsDQo+Pj4NCj4+PiBD
Lg0KPj4+DQo+Pj4NCj4+Pj4+ICvCoMKgwqAgfQ0KPj4+Pj4gKw0KPj4+Pj4gwqDCoMKgwqDCoCBn
cm91cCA9IHZmaW9fZ2V0X2dyb3VwKGdyb3VwaWQsIGFzLCBlcnJwKTsNCj4+Pj4+IMKgwqDCoMKg
wqAgaWYgKCFncm91cCkgew0KPj4+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgIHJldHVybiBmYWxzZTsN
Cj4+Pj4+IGRpZmYgLS1naXQgYS9ody92ZmlvL2hlbHBlcnMuYyBiL2h3L3ZmaW8vaGVscGVycy5j
DQo+Pj4+PiBpbmRleCA3ZTIzZTkwODBjOWQuLmVhMTVjNzlkYjBhMyAxMDA2NDQNCj4+Pj4+IC0t
LSBhL2h3L3ZmaW8vaGVscGVycy5jDQo+Pj4+PiArKysgYi9ody92ZmlvL2hlbHBlcnMuYw0KPj4+
Pj4gQEAgLTY4OSwzICs2ODksMTQgQEAgYm9vbCB2ZmlvX2RldmljZV9pc19tZGV2KFZGSU9EZXZp
Y2UNCj4qdmJhc2VkZXYpDQo+Pj4+PiDCoMKgwqDCoMKgIHN1YnN5cyA9IHJlYWxwYXRoKHRtcCwg
TlVMTCk7DQo+Pj4+PiDCoMKgwqDCoMKgIHJldHVybiBzdWJzeXMgJiYgKHN0cmNtcChzdWJzeXMs
ICIvc3lzL2J1cy9tZGV2IikgPT0gMCk7DQo+Pj4+PiDCoCB9DQo+Pj4+PiArDQo+Pj4+PiArYm9v
bCB2ZmlvX2RldmljZV9oaW9kX3JlYWxpemUoVkZJT0RldmljZSAqdmJhc2VkZXYsIEVycm9yICoq
ZXJycCkNCj4+Pj4+ICt7DQo+Pj4+PiArwqDCoMKgIEhvc3RJT01NVURldmljZSAqaGlvZCA9IHZi
YXNlZGV2LT5oaW9kOw0KPj4+Pj4gKw0KPj4+Pj4gK8KgwqDCoCBpZiAoIWhpb2QpIHsNCj4+Pj4+
ICvCoMKgwqDCoMKgwqDCoCByZXR1cm4gdHJ1ZTsNCj4+Pj4+ICvCoMKgwqAgfQ0KPj4+Pj4gKw0K
Pj4+Pj4gK8KgwqDCoCByZXR1cm4gSE9TVF9JT01NVV9ERVZJQ0VfR0VUX0NMQVNTKGhpb2QpLT5y
ZWFsaXplKGhpb2QsDQo+Pj4+PiB2YmFzZWRldiwgZXJycCk7DQo+Pj4+PiArfQ0KPj4+Pj4gZGlm
ZiAtLWdpdCBhL2h3L3ZmaW8vaW9tbXVmZC5jIGIvaHcvdmZpby9pb21tdWZkLmMNCj4+Pj4+IGlu
ZGV4IDVlMmZjMWNlMDg5ZC4uMjMyNGJmODkyYzU2IDEwMDY0NA0KPj4+Pj4gLS0tIGEvaHcvdmZp
by9pb21tdWZkLmMNCj4+Pj4+ICsrKyBiL2h3L3ZmaW8vaW9tbXVmZC5jDQo+Pj4+PiBAQCAtNDAz
LDYgKzQwMywxMCBAQCBzdGF0aWMgYm9vbCBpb21tdWZkX2NkZXZfYXR0YWNoKGNvbnN0IGNoYXIN
Cj4+Pj4+ICpuYW1lLCBWRklPRGV2aWNlICp2YmFzZWRldiwNCj4+Pj4+IMKgIMKgwqDCoMKgwqAg
c3BhY2UgPSB2ZmlvX2dldF9hZGRyZXNzX3NwYWNlKGFzKTsNCj4+Pj4+IMKgICvCoMKgwqAgaWYg
KCF2ZmlvX2RldmljZV9oaW9kX3JlYWxpemUodmJhc2VkZXYsIGVycnApKSB7DQo+Pj4+PiArwqDC
oMKgwqDCoMKgwqAgcmV0dXJuIGZhbHNlOw0KPj4gSHVtIHNvcnJ5IG15IHByZXZpb3VzIGNvbW1l
bnQgd2FzIHRhcmdldHRpbmcgdGhhdCBwbGFjZS4gSSB0aGluaw0KPj4gdW5yb2xsaW5nIGlzIG5l
ZWRlZCB1cCB0byBwdXRfYWRkcmVzc19zcGFjZQ0KPj4NCj4+IHNvIGVmZmVjdGl2ZWx5IHRoaXMg
ZG9lcyBub3QgbWF0Y2ggZXJyX2FsbG9jX2lvYXMgYnV0IEkgZ3Vlc3Mgd2Ugd291bGQNCj4+IG5l
ZWQgYW5vdGhlciBsYWJlbA0KPj4NCj4NCj5Zb3UncmUgcmlnaHQuIFdlIGhhdmVuJ3QgeWV0IGF0
dGFjaGVkIHJ0aGUgZGV2aWNlIGFuZCB0aGF0J3Mgd2hhdA0KPmVycl9hbGxvY19pb2FzDQo+d291
bGQgZG8uIEFkZGluZyBhbm90aGVyIGxhYmVsIG5vdCBzdXJlIHdvdWxkIG1ha2UgdGhpbmdzIGNs
ZWFuZXIgZ2l2ZW4NCj50aGUNCj5vcmRlcmluZyByZXF1aXJlbWVudC4gU28gbWF5YmUgdGhpcyBp
bnN0ZWFkPw0KPg0KPkBAIC00ODIsNyArNDgzLDggQEAgc3RhdGljIGJvb2wgaW9tbXVmZF9jZGV2
X2F0dGFjaChjb25zdCBjaGFyICpuYW1lLA0KPlZGSU9EZXZpY2UNCj4qdmJhc2VkZXYsDQo+ICAg
ICBzcGFjZSA9IHZmaW9fZ2V0X2FkZHJlc3Nfc3BhY2UoYXMpOw0KPg0KPiAgICAgaWYgKCF2Zmlv
X2RldmljZV9oaW9kX3JlYWxpemUodmJhc2VkZXYsIGVycnApKSB7DQo+LSAgICAgICAgcmV0dXJu
IGZhbHNlOw0KPisgICAgICAgIHZmaW9fcHV0X2FkZHJlc3Nfc3BhY2Uoc3BhY2UpOw0KPisgICAg
ICAgIGdvdG8gZXJyX2Nvbm5lY3RfYmluZDsNCj4gICAgIH0NCj4NCj4gICAgIC8qIHRyeSB0byBh
dHRhY2ggdG8gYW4gZXhpc3RpbmcgY29udGFpbmVyIGluIHRoaXMgc3BhY2UgKi8NCg0KSSB3YXMg
Y29uZnVzZWQgdGhvdWdoIENlZHJpYyBhbmQgRXJpYyBib3RoIEFDSyB0aGlzIGNoYW5nZS4gRG9u
J3Qgd2UgbWlzcyB0aGUgaW9tbXVmZF9jZGV2X3VuYmluZF9hbmRfZGlzY29ubmVjdCgpIGNhbGw/
DQoNCg==

