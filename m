Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0AD5C25B75
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2024 04:04:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sF4Mu-00039w-Uz; Thu, 06 Jun 2024 00:04:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sF4Mr-00039b-VI
 for qemu-devel@nongnu.org; Thu, 06 Jun 2024 00:04:50 -0400
Received: from mgamail.intel.com ([198.175.65.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sF4Mp-0001OG-Mt
 for qemu-devel@nongnu.org; Thu, 06 Jun 2024 00:04:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1717646687; x=1749182687;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=UEyN+b60W7be/sJ/2TVLEgTQfV+jXBkwKU7Yd/b8rZ8=;
 b=O2QfUCFfXPfqTFk8xXoE0nPGxUP8xvyQx/QiFcuYgmqtQLKyZSXUvTww
 4G4DW/UHXsV41QOEuNryqbbMAHeUhkECH4tlNAO/B5+RtyrFc/cHL6DF1
 rQTsNnlvp5XHpdknNSUmo62Fum2GMQ75ZefLOBpNJRexJe/r1pxGJbipg
 KtW6WR/fdY2NTnhFrhLoR4n2Fq01+D12bcbRXgcNg6KKipVuQTQUKpDLO
 if4hB0bbwD+8I+L9kcc0WJavFUBwxKJ0smRaPx8/4/3xM9GpnpLQ6a/0e
 co8tUszpi6pOu4s7bTd7ub0cHbQ89UMDbjhxIDOPcRJWkMzfvVUYiJ4p/ w==;
X-CSE-ConnectionGUID: HLc+uMEuQ7+NgahVhDhozw==
X-CSE-MsgGUID: m7iSSYqHTImgUR5XuKSbpA==
X-IronPort-AV: E=McAfee;i="6600,9927,11094"; a="14425782"
X-IronPort-AV: E=Sophos;i="6.08,218,1712646000"; d="scan'208";a="14425782"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Jun 2024 21:04:45 -0700
X-CSE-ConnectionGUID: 2ZCTXgo2RYCryxlDrmUJYg==
X-CSE-MsgGUID: S1hAXGO0TE6OmgMt7NryYw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,218,1712646000"; d="scan'208";a="42924943"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
 by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 05 Jun 2024 21:04:45 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 5 Jun 2024 21:04:44 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 5 Jun 2024 21:04:44 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.44) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 5 Jun 2024 21:04:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kaij7zbTQ856JtFGtLELt4wImO7a8qX0wahM/rVU0XiNC6KDWel2soNBYY6Qt7JE8V1Q3M+ULOn1B1qvtuQ152/bWfCUaskyXpKHWUaWMw98SKTgrcy9F+pGRSmH2JqpwXsb1h3XiH9zyNLYB6Ajd5A4w4XRo0zBGCKKS+rGm+6Or0vWGIqYppY3PMSuXI1bOZKONFEuOXuzaPb1oq6P83BIooYx8uGN7HhBvv/F80k0Aqb0o7MfKe427EXi17J7sivrF5DJSBaiCueCRddZ+R1vqOypFEL616yWivGEngj0w6Ambjqj2/RcTvg9+A0LlgldPJCFqRtJqRmikbdYWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UEyN+b60W7be/sJ/2TVLEgTQfV+jXBkwKU7Yd/b8rZ8=;
 b=dna6zDObCFNv4fnwkUstf6H9bSgDmzVcy8RPaZ/Ja/MDKy4oMmFUwBSqdfN8Whg8j4OgeVaRkr740rtwic6wrfc/m2wHG6HqadEOmJkmnGQB2w1RyxYmUv7FO+YDQp9/EwaA7w3TFhHEitsAmOgsKNlkNahCQHYZdGObgsNYe+ndaK6xUqetnsUinD2xTwIY3iBQ2S0CALgc/vcfloI50lOxNBCI+KbvGCGQ9kMCI/uIvfuMeKriy23WQBfLvP7ZbN9nQ7fnNQrLV86XA2fYPn4jWTCf9MI8b49gD3uYGtFvXBLNyTfZDp2a1H7Qp8+nvtuzQd6z4KMYW45Qe1j9Vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by CY5PR11MB6306.namprd11.prod.outlook.com (2603:10b6:930:22::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.31; Thu, 6 Jun
 2024 04:04:41 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091%7]) with mapi id 15.20.7633.021; Thu, 6 Jun 2024
 04:04:41 +0000
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
 "Liu, Yi L" <yi.l.liu@intel.com>, "Peng, Chao P" <chao.p.peng@intel.com>, "Yi
 Sun" <yi.y.sun@linux.intel.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard
 Henderson <richard.henderson@linaro.org>, Eduardo Habkost
 <eduardo@habkost.net>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: RE: [PATCH v6 18/19] intel_iommu: Implement
 [set|unset]_iommu_device() callbacks
Thread-Topic: [PATCH v6 18/19] intel_iommu: Implement
 [set|unset]_iommu_device() callbacks
Thread-Index: AQHatX1NjS0WvnbGzEqvnm/9l/Wze7G2HucAgAD5pQCAACu2AIAC2nNg
Date: Thu, 6 Jun 2024 04:04:41 +0000
Message-ID: <SJ0PR11MB6744F40EA245CEA8DE55D65492FA2@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20240603061023.269738-1-zhenzhong.duan@intel.com>
 <20240603061023.269738-19-zhenzhong.duan@intel.com>
 <fcec6a43-3ac1-46fd-aca2-96097b85175a@redhat.com>
 <SJ0PR11MB67441662E0FD34AE114217AF92F82@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <b2995975-5589-406f-bd07-817291ed4404@redhat.com>
In-Reply-To: <b2995975-5589-406f-bd07-817291ed4404@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|CY5PR11MB6306:EE_
x-ms-office365-filtering-correlation-id: 2fe223ec-8265-4505-a687-08dc85ddcade
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230031|376005|1800799015|7416005|366007|38070700009; 
x-microsoft-antispam-message-info: =?utf-8?B?ek5oanpHZk14bnNRZHpHMEg3WXBYSDFIV3oveTFYMWpQSFowcWlFcGVZbDkr?=
 =?utf-8?B?Y2p3OWdRcWJybkxZMEp6M2RhV0F0N3FiVjB6UlVZOUNPT1JnUFBzT0R5Y1p5?=
 =?utf-8?B?OXVkUW80TmhGNkxxeG1lRGZiZEY5WXRiVi90UlJtVEk4NVFrdUtoMTVpbkNo?=
 =?utf-8?B?VGZRaE1KR3ZpQVYvNHBQOGx3dmhnWlBWWXZsRkF1a2NvdUNsaUs2TU5ReG1o?=
 =?utf-8?B?d3NuZjhnbXo0K1ZNclVZVzZtTzM3WEl0aDU1YkJqZGIwYktkYmEvY3V3NDJM?=
 =?utf-8?B?bFpLczVoOTJTakVkWG92QlhvMElub1BQS2Nhbm1TV0I3dVo1aTZYNDFPTDla?=
 =?utf-8?B?T3U2VXo4STVxMUZyT25KNXF0eUsyR0RDMExYZk5rclNXOEhKclB3ZDMxbWEw?=
 =?utf-8?B?c3pxaDJib0FWQTNpeVBvYS9Xb2srcTNLMjdoUEgyaDlHaGVQMkZNL2QwTlBD?=
 =?utf-8?B?VGJTbmJPNmdtY2lqKzkybzExQnRsR0hhclR0Qi9oS3NGQmduZENoVlhCbUxt?=
 =?utf-8?B?K1QzT21nQXY5N2FkWGZmaTRLQ3BhZFNQR2d2cVlrVENoYUkzWDJsWi81MExN?=
 =?utf-8?B?aytDc3Q4d2svZ2tWWnR0ek9QOWF1cENIZk1OYkE2dmpvMHJIRDlyL2dZbC9l?=
 =?utf-8?B?S1lIMngxaTFkQ2IybGZuYVFlZVJFNDNJR3Bocm9CcExJRk41VDlIMmt4Zm1O?=
 =?utf-8?B?VG5hcjBKbjVJbXNxOXlJU3hiNDViTHYvRXNrYnFnU1NZWjZlcW11UmVpbXFW?=
 =?utf-8?B?UEdGTXUvSTJXbzUrbDBNUnRoS2xqU2dteXAzMXVDMkVmUGYxNm9rS0ZQeVdX?=
 =?utf-8?B?aEpwNEM0NUtXTUFvUm9ZN2EzRFlKVTlpM2xOSUQva21sWEZTWXRYYTlreDZ2?=
 =?utf-8?B?eENUK0ttR1pZRzZ2NTVXMFZNVEs0NEphaUFuanFicnB6aXlzNDZsMmdNeXRj?=
 =?utf-8?B?QkgzeVdOWVdnRitlMHo0OHl2QWNNa0dVb3Q1WFpkUDU4ZDF5bmNwTXE2R0NE?=
 =?utf-8?B?eENoSnI2THQ1WkJSM29yS3JrV2ZrV3AyVzZtazBnK0dLQmRjV0RHR1puS1Zz?=
 =?utf-8?B?RUJ6REVRK00xVWJDcFU3S1kvU2hDYVVOMDludlhsUkJRWmd5RHoyOHJhVWI3?=
 =?utf-8?B?T0t3TmJmMXE0T2JhSHJNSlIwNHp3dTZiTHl6a1kzQTJaenBmeGh2UmUzVlJP?=
 =?utf-8?B?TURUVFB1SlFNd0xUbXA0dlBBYjZtc1cveWIyU2k5NGFWbEdpa3ZKYTgyVUNX?=
 =?utf-8?B?d3llSUp4RFZWNU9COCtPcmRaVW5qMTJOQnJJY2JEWit3bUhUZjBSV1hrMUN5?=
 =?utf-8?B?TExNYmtIODFVWHZ1OGpjcTRTTkY5NEVuQ1R4bmpqTlNKRHdLT2plNGYvaTJ5?=
 =?utf-8?B?YUFMSHZ0bDhxQzF2aUdPWHp4UUVuTGdOb0FTR2dueUNBS1BlRGJIQ1pLbE02?=
 =?utf-8?B?M3JaeElmbE1ockFsREo3b0haUGxhaStlWmFvaUhsVEtOV0RPbDNXdlJEdDZH?=
 =?utf-8?B?SS9tQmhlV0RpVEVrbXZpUFRuTE9JZUZVL29kV1FqZk5TZE1zL3Rhb093NU9y?=
 =?utf-8?B?bm5OZUlTTHU1em4zYTJZUXZlT20yV3ZVSzBEVFNCeEFsbXBqbUEyZ2NPb2xY?=
 =?utf-8?B?MHR0Vk1WUkpvU0liRWpON1hHTko5UldnaDRMN3FZMGN4bVFXOEZNdFBnaExv?=
 =?utf-8?B?UklDVWovV1lEQld6eHNOMnhSUk53MjZaY1hiTldGa3VVVEQ0c1RLb0Q0K1Jj?=
 =?utf-8?B?VEFNczhhamZhVHJIVW5NR3A2ZlE2RnRDSmJaWlJtK0tMZHhRSFBzSlEyc2FW?=
 =?utf-8?B?TnhlWEJVdWhuRFBKMmhadz09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(7416005)(366007)(38070700009); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VlBOZDVOZFc4MmJrRzNFSUdRUFBURmpuekkwRnJDaWE5UEZMUjBWZXJBRjUz?=
 =?utf-8?B?Y3hrUWk4QjAvbXViUDcvL0dFUW00WGRleFdQbUtOVml2VDNDdC9jbWJ2eTY3?=
 =?utf-8?B?OUg2Qk1OcERyZjdwWW5wekpXaE4rWmJIM0kyZzc4WlJOSVJLR0dSQkErZFVw?=
 =?utf-8?B?aUg3aG5UMlhTb0cxeE4wazYwVEhSVElnVWtDaHZZaHNiVFlWdnVjVVNlS0do?=
 =?utf-8?B?SXdWOUZrMVFSendTcUJYOFhXMXFuQkJIRXd1MlRFaEtjVG05TlVEeVBESHNU?=
 =?utf-8?B?a0F4eVJHOGlhWUVSSGV1eTNwZkRvaHM0RGVXNmY0YzU5OXVZK2dDcFl6a3V4?=
 =?utf-8?B?eVp6NEkrQmduTUJCQ3JRc1BWY3huTStsTk4xRk1PSDk3N0hZK3N2VjB1Q0pT?=
 =?utf-8?B?bWRxVlFTWFlDZk1qMkpZQzdaNXBuREdYSEJsTVUxUTFlSmZHQnJmcTVUYWp6?=
 =?utf-8?B?aTkwOUpGMmFnR3NvVHdjTlkyZS8rOVUyN3dpQWtJbDY1Vjh1SGJzbU9tekk5?=
 =?utf-8?B?UzUxcjVkRWV6YWtTSEYvbkhGcmF4ZGc4aTUySlUzOGtrQi8xbXYrSWtPcjlZ?=
 =?utf-8?B?eUg0TlRLS2tPaFNLYWlsQUxCNzJOS3l2aWY0Y2NWSGY1TkFsVmtEQWpqUHJs?=
 =?utf-8?B?UUhBaDUrWk9wQUd3ci9BTlJOTTV5RC9pc3VkblM1N0Excnd1WGpmLzhPVldC?=
 =?utf-8?B?cXZ4SlIxRlZqV3F4L0VsUHQ4Ykp4Y1VBbkE1L1NuRG5ySUhzOUo4YlYveWtS?=
 =?utf-8?B?ZWtWeVF0cHY2bklwRTRLN3N3dTFIcEI0RERGV2RReGNoL0tIWW13UDMwTTBM?=
 =?utf-8?B?dFEvTDVLSWp2UktuMThuV2c5eUJXazlEM3BBdUZGMGRMTW9BblBPdUhmTzdL?=
 =?utf-8?B?RmxTWGJwcFEwQjVBY1Y3THQrUnFYamdiTGxqUnJONjRvZk56RmgycHZwQnlx?=
 =?utf-8?B?bm5McGU0SGdHT2FBbStKT2RIUG9BOXJVZlcxQ1d5aFlHMVNWMGt6Z2FpekRi?=
 =?utf-8?B?QTJ5QjFuUWRFSzlCWnplSDV0VmIvY3NmRzRud2UzRkFhdnN6alpDTTVQVXU1?=
 =?utf-8?B?SVhBY0dDUmtrMUQwTTlHa1BPKzZuTk5WU0IybDdadHRtdkxWc2N3M2FsTElZ?=
 =?utf-8?B?UFcram5OVzdJTWlhOGRGcWpTaXZ0ejZCMVhMeDBEL2NsMFhacUd2Qm14dHRI?=
 =?utf-8?B?bDg3SG93WmtzOFZ6K1liZHdxaEo1WDNCV2E2c1JzWDU2RUdCTkZDek00dUlN?=
 =?utf-8?B?UkZTN0VYK1puUWZ6MUkwMVJvSXRtbVh2M0NiU0YyNFNuUTF0SDdaZEdUTkds?=
 =?utf-8?B?YUVDWFJYalNUeWVTNTUrUWNzcml0cFdWdk9oMllrMVJjeHlhcGVEU1o0Mmsz?=
 =?utf-8?B?UkFFL0VpanExYnJjVVcvbmxValJMNlJ0ay9Cd0FKTnNRcHRqalo2K3Jxd25j?=
 =?utf-8?B?L0VkV0FrWlE3ZXB1UWdZWDlJQ1BzQnNWV21zbHovTGhMRC9yZzRqZzgySG85?=
 =?utf-8?B?YkxSemZJT0gvREpVVWVYUWFIdm1IbUlYeE16SEl2QmRPYW9WQmRJTEJGZjE5?=
 =?utf-8?B?WEhRWERJNHc3SUpESk40RGJaelA3TnRpNTRwL0lhU3VUeXIybnNDYzI4ZVZ5?=
 =?utf-8?B?WFdJVVVxdGxIQlBENm8yaWhBVkQ5T2gwZ01maG1FZ3VHU3g5bVdMaXRoSHE5?=
 =?utf-8?B?cDRzVEc4Wks4dzV2aFllSEpveVIrQm9jaUIvaGpyelErenZ0Zlp3aWV1UzVY?=
 =?utf-8?B?aXd2R1FpSEJjKzN4ZU5YZGUxZEhIc1VSNEtraXlpalNnY3FRZHVlS3BtZEpN?=
 =?utf-8?B?SzYyMXlBN1JKMUN0TTlNNFNDeFJVaXQ5dlVHS2pPdXBIYW9zNGVIZWNvWERk?=
 =?utf-8?B?MWVQTTVheThqRG10KzA0ZG1GT0tOSm9VWUlObS8vZU9mNVM3UG1RclM3TnI1?=
 =?utf-8?B?NUdXbnVoQm8vNWt4OUpISlAybmp3K202Y1R0SUNlTkkwTENWekhSMStlTjhZ?=
 =?utf-8?B?K2c0eS96UnMzaFAyUFFJKzVrTHBPa1FKc0ExM3o5dW56cWtQa041dWtaK2Rs?=
 =?utf-8?B?ckthWUNleXRCbWs1Njg0TTlBZGE1ZloyUHFJdVBLeHdWMzEvelZWRzRKenB2?=
 =?utf-8?Q?lb9FP1wcevUkbogTwbXhZ16F3?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fe223ec-8265-4505-a687-08dc85ddcade
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jun 2024 04:04:41.7287 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TflXhpDgX6LmH6FnHJitvn94asfvzwJc2QujKBbnnBVgrSsSCk+U9iluiWWOUMXa3LiVVW2Hq1L+QAMqxQDfe6i7Hm2TtJ3wwmLc1cHQ57I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6306
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.16;
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
YXVnZXJAcmVkaGF0LmNvbT4NCj5TdWJqZWN0OiBSZTogW1BBVENIIHY2IDE4LzE5XSBpbnRlbF9p
b21tdTogSW1wbGVtZW50DQo+W3NldHx1bnNldF1faW9tbXVfZGV2aWNlKCkgY2FsbGJhY2tzDQo+
DQo+DQo+DQo+T24gNi80LzI0IDA3OjQ2LCBEdWFuLCBaaGVuemhvbmcgd3JvdGU6DQo+Pg0KPj4+
IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+Pj4gRnJvbTogRXJpYyBBdWdlciA8ZXJpYy5h
dWdlckByZWRoYXQuY29tPg0KPj4+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjYgMTgvMTldIGludGVs
X2lvbW11OiBJbXBsZW1lbnQNCj4+PiBbc2V0fHVuc2V0XV9pb21tdV9kZXZpY2UoKSBjYWxsYmFj
a3MNCj4+Pg0KPj4+DQo+Pj4NCj4+PiBPbiA2LzMvMjQgMDg6MTAsIFpoZW56aG9uZyBEdWFuIHdy
b3RlOg0KPj4+PiBGcm9tOiBZaSBMaXUgPHlpLmwubGl1QGludGVsLmNvbT4NCj4+Pj4NCj4+Pj4g
SW1wbGVtZW50IFtzZXR8dW5zZXRdX2lvbW11X2RldmljZSgpIGNhbGxiYWNrcyBpbiBJbnRlbCB2
SU9NTVUuDQo+Pj4+IEluIHNldCBjYWxsLCBhIG5ldyBzdHJ1Y3R1cmUgVlRESG9zdElPTU1VRGV2
aWNlIHdoaWNoIGhvbGRzDQo+Pj4+IGEgcmVmZXJlbmNlIHRvIEhvc3RJT01NVURldmljZSBpcyBz
dG9yZWQgaW4gaGFzaCB0YWJsZQ0KPj4+PiBpbmRleGVkIGJ5IFBDSSBCREYuDQo+Pj4+DQo+Pj4+
IFNpZ25lZC1vZmYtYnk6IFlpIExpdSA8eWkubC5saXVAaW50ZWwuY29tPg0KPj4+PiBTaWduZWQt
b2ZmLWJ5OiBZaSBTdW4gPHlpLnkuc3VuQGxpbnV4LmludGVsLmNvbT4NCj4+Pj4gU2lnbmVkLW9m
Zi1ieTogWmhlbnpob25nIER1YW4gPHpoZW56aG9uZy5kdWFuQGludGVsLmNvbT4NCj4+Pj4gLS0t
DQo+Pj4+ICBody9pMzg2L2ludGVsX2lvbW11X2ludGVybmFsLmggfCAgOSArKysrDQo+Pj4+ICBp
bmNsdWRlL2h3L2kzODYvaW50ZWxfaW9tbXUuaCAgfCAgMiArDQo+Pj4+ICBody9pMzg2L2ludGVs
X2lvbW11LmMgICAgICAgICAgfCA3Ng0KPj4+ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysNCj4+Pj4gIDMgZmlsZXMgY2hhbmdlZCwgODcgaW5zZXJ0aW9ucygrKQ0KPj4+Pg0KPj4+
PiBkaWZmIC0tZ2l0IGEvaHcvaTM4Ni9pbnRlbF9pb21tdV9pbnRlcm5hbC5oDQo+Pj4gYi9ody9p
Mzg2L2ludGVsX2lvbW11X2ludGVybmFsLmgNCj4+Pj4gaW5kZXggZjhjZjk5YmRkZi4uYjgwMGQ2
MmNhMCAxMDA2NDQNCj4+Pj4gLS0tIGEvaHcvaTM4Ni9pbnRlbF9pb21tdV9pbnRlcm5hbC5oDQo+
Pj4+ICsrKyBiL2h3L2kzODYvaW50ZWxfaW9tbXVfaW50ZXJuYWwuaA0KPj4+PiBAQCAtMjgsNiAr
MjgsNyBAQA0KPj4+PiAgI2lmbmRlZiBIV19JMzg2X0lOVEVMX0lPTU1VX0lOVEVSTkFMX0gNCj4+
Pj4gICNkZWZpbmUgSFdfSTM4Nl9JTlRFTF9JT01NVV9JTlRFUk5BTF9IDQo+Pj4+ICAjaW5jbHVk
ZSAiaHcvaTM4Ni9pbnRlbF9pb21tdS5oIg0KPj4+PiArI2luY2x1ZGUgInN5c2VtdS9ob3N0X2lv
bW11X2RldmljZS5oIg0KPj4+Pg0KPj4+PiAgLyoNCj4+Pj4gICAqIEludGVsIElPTU1VIHJlZ2lz
dGVyIHNwZWNpZmljYXRpb24NCj4+Pj4gQEAgLTUzNyw0ICs1MzgsMTIgQEAgdHlwZWRlZiBzdHJ1
Y3QgVlREUm9vdEVudHJ5IFZURFJvb3RFbnRyeTsNCj4+Pj4gICNkZWZpbmUgVlREX1NMX0lHTl9D
T00gICAgICAgICAgICAgIDB4YmZmMDAwMDAwMDAwMDAwMFVMTA0KPj4+PiAgI2RlZmluZSBWVERf
U0xfVE0gICAgICAgICAgICAgICAgICAgKDFVTEwgPDwgNjIpDQo+Pj4+DQo+Pj4+ICsNCj4+Pj4g
K3R5cGVkZWYgc3RydWN0IFZUREhvc3RJT01NVURldmljZSB7DQo+Pj4+ICsgICAgSW50ZWxJT01N
VVN0YXRlICppb21tdV9zdGF0ZTsNCj4+Pj4gKyAgICBQQ0lCdXMgKmJ1czsNCj4+Pj4gKyAgICB1
aW50OF90IGRldmZuOw0KPj4+PiArICAgIEhvc3RJT01NVURldmljZSAqZGV2Ow0KPj4+PiArICAg
IFFMSVNUX0VOVFJZKFZUREhvc3RJT01NVURldmljZSkgbmV4dDsNCj4+Pj4gK30gVlRESG9zdElP
TU1VRGV2aWNlOw0KPj4+PiAgI2VuZGlmDQo+Pj4+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2h3L2kz
ODYvaW50ZWxfaW9tbXUuaA0KPj4+IGIvaW5jbHVkZS9ody9pMzg2L2ludGVsX2lvbW11LmgNCj4+
Pj4gaW5kZXggN2Q2OTRiMDgxMy4uMmJiZGU0MWU0NSAxMDA2NDQNCj4+Pj4gLS0tIGEvaW5jbHVk
ZS9ody9pMzg2L2ludGVsX2lvbW11LmgNCj4+Pj4gKysrIGIvaW5jbHVkZS9ody9pMzg2L2ludGVs
X2lvbW11LmgNCj4+Pj4gQEAgLTI5Myw2ICsyOTMsOCBAQCBzdHJ1Y3QgSW50ZWxJT01NVVN0YXRl
IHsNCj4+Pj4gICAgICAvKiBsaXN0IG9mIHJlZ2lzdGVyZWQgbm90aWZpZXJzICovDQo+Pj4+ICAg
ICAgUUxJU1RfSEVBRCgsIFZUREFkZHJlc3NTcGFjZSkgdnRkX2FzX3dpdGhfbm90aWZpZXJzOw0K
Pj4+Pg0KPj4+PiArICAgIEdIYXNoVGFibGUgKnZ0ZF9ob3N0X2lvbW11X2RldjsgICAgICAgICAg
ICAgLyoNCj5WVERIb3N0SU9NTVVEZXZpY2UNCj4+PiAqLw0KPj4+PiArDQo+Pj4+ICAgICAgLyog
aW50ZXJydXB0IHJlbWFwcGluZyAqLw0KPj4+PiAgICAgIGJvb2wgaW50cl9lbmFibGVkOyAgICAg
ICAgICAgICAgLyogV2hldGhlciBndWVzdCBlbmFibGVkIElSICovDQo+Pj4+ICAgICAgZG1hX2Fk
ZHJfdCBpbnRyX3Jvb3Q7ICAgICAgICAgICAvKiBJbnRlcnJ1cHQgcmVtYXBwaW5nIHRhYmxlIHBv
aW50ZXIgKi8NCj4+Pj4gZGlmZiAtLWdpdCBhL2h3L2kzODYvaW50ZWxfaW9tbXUuYyBiL2h3L2kz
ODYvaW50ZWxfaW9tbXUuYw0KPj4+PiBpbmRleCA1MTkwNjNjOGY4Li43NDdjOTg4YmM0IDEwMDY0
NA0KPj4+PiAtLS0gYS9ody9pMzg2L2ludGVsX2lvbW11LmMNCj4+Pj4gKysrIGIvaHcvaTM4Ni9p
bnRlbF9pb21tdS5jDQo+Pj4+IEBAIC0yMzcsNiArMjM3LDEzIEBAIHN0YXRpYyBnYm9vbGVhbiB2
dGRfYXNfZXF1YWwoZ2NvbnN0cG9pbnRlcg0KPnYxLA0KPj4+IGdjb25zdHBvaW50ZXIgdjIpDQo+
Pj4+ICAgICAgICAgICAgIChrZXkxLT5wYXNpZCA9PSBrZXkyLT5wYXNpZCk7DQo+Pj4+ICB9DQo+
Pj4+DQo+Pj4+ICtzdGF0aWMgZ2Jvb2xlYW4gdnRkX2FzX2lkZXZfZXF1YWwoZ2NvbnN0cG9pbnRl
ciB2MSwgZ2NvbnN0cG9pbnRlciB2MikNCj4+Pj4gK3sNCj4+Pj4gKyAgICBjb25zdCBzdHJ1Y3Qg
dnRkX2FzX2tleSAqa2V5MSA9IHYxOw0KPj4+PiArICAgIGNvbnN0IHN0cnVjdCB2dGRfYXNfa2V5
ICprZXkyID0gdjI7DQo+Pj4+ICsNCj4+Pj4gKyAgICByZXR1cm4gKGtleTEtPmJ1cyA9PSBrZXky
LT5idXMpICYmIChrZXkxLT5kZXZmbiA9PSBrZXkyLT5kZXZmbik7DQo+Pj4+ICt9DQo+Pj4+ICAv
Kg0KPj4+PiAgICogTm90ZSB0aGF0IHdlIHVzZSBwb2ludGVyIHRvIFBDSUJ1cyBhcyB0aGUga2V5
LCBzbyBoYXNoaW5nL3NoaWZ0aW5nDQo+Pj4+ICAgKiBiYXNlZCBvbiB0aGUgcG9pbnRlciB2YWx1
ZSBpcyBpbnRlbmRlZC4gTm90ZSB0aGF0IHdlIGRlYWwgd2l0aA0KPj4+PiBAQCAtMzgxMiw2ICsz
ODE5LDcwIEBAIFZUREFkZHJlc3NTcGFjZQ0KPj4+ICp2dGRfZmluZF9hZGRfYXMoSW50ZWxJT01N
VVN0YXRlICpzLCBQQ0lCdXMgKmJ1cywNCj4+Pj4gICAgICByZXR1cm4gdnRkX2Rldl9hczsNCj4+
Pj4gIH0NCj4+Pj4NCj4+Pj4gK3N0YXRpYyBib29sIHZ0ZF9kZXZfc2V0X2lvbW11X2RldmljZShQ
Q0lCdXMgKmJ1cywgdm9pZCAqb3BhcXVlLCBpbnQNCj4+PiBkZXZmbiwNCj4+Pj4gKyAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICBIb3N0SU9NTVVEZXZpY2UgKmhpb2QsIEVycm9y
ICoqZXJycCkNCj4+Pj4gK3sNCj4+Pj4gKyAgICBJbnRlbElPTU1VU3RhdGUgKnMgPSBvcGFxdWU7
DQo+Pj4+ICsgICAgVlRESG9zdElPTU1VRGV2aWNlICp2dGRfaGRldjsNCj4+Pj4gKyAgICBzdHJ1
Y3QgdnRkX2FzX2tleSBrZXkgPSB7DQo+Pj4+ICsgICAgICAgIC5idXMgPSBidXMsDQo+Pj4+ICsg
ICAgICAgIC5kZXZmbiA9IGRldmZuLA0KPj4+PiArICAgIH07DQo+Pj4+ICsgICAgc3RydWN0IHZ0
ZF9hc19rZXkgKm5ld19rZXk7DQo+Pj4+ICsNCj4+Pj4gKyAgICBhc3NlcnQoaGlvZCk7DQo+Pj4+
ICsNCj4+Pj4gKyAgICB2dGRfaW9tbXVfbG9jayhzKTsNCj4+Pj4gKw0KPj4+PiArICAgIHZ0ZF9o
ZGV2ID0gZ19oYXNoX3RhYmxlX2xvb2t1cChzLT52dGRfaG9zdF9pb21tdV9kZXYsICZrZXkpOw0K
Pj4+PiArDQo+Pj4+ICsgICAgaWYgKHZ0ZF9oZGV2KSB7DQo+Pj4+ICsgICAgICAgIGVycm9yX3Nl
dGcoZXJycCwgIklPTU1VRkQgZGV2aWNlIGFscmVhZHkgZXhpc3QiKTsNCj4+Pj4gKyAgICAgICAg
dnRkX2lvbW11X3VubG9jayhzKTsNCj4+Pj4gKyAgICAgICAgcmV0dXJuIGZhbHNlOw0KPj4+PiAr
ICAgIH0NCj4+Pj4gKw0KPj4+PiArICAgIHZ0ZF9oZGV2ID0gZ19tYWxsb2MwKHNpemVvZihWVERI
b3N0SU9NTVVEZXZpY2UpKTsNCj4+Pj4gKyAgICB2dGRfaGRldi0+YnVzID0gYnVzOw0KPj4+PiAr
ICAgIHZ0ZF9oZGV2LT5kZXZmbiA9ICh1aW50OF90KWRldmZuOw0KPj4+PiArICAgIHZ0ZF9oZGV2
LT5pb21tdV9zdGF0ZSA9IHM7DQo+Pj4+ICsgICAgdnRkX2hkZXYtPmRldiA9IGhpb2Q7DQo+Pj4g
SSBhbSBzdGlsbCBub3QgdG90YWxseSBjbGVhciBhYm91dCB3aHkgd2UgY291bGRuJ3QgcmV1c2Ug
VlREQWRkcmVzc1NwYWNlDQo+Pj4gaW5zdGFuY2UgZm9yIHRoaXMgYnVzL2RldmlkLiBJcyBpdCBh
IG1hdHRlciBvZiBhbGlhc2VkIHZlcnN1cyBub24NCj4+PiBhbGlhc2VkIGJ1cy9kZXZmbiwgb3Ig
YSBtYXR0ZXIgb2YgcGFzaWQgZGlmZi4gQW4gQWRkcmVzc1NwYWNlIGNvdWxkIGJhY2sNCj4+PiBh
biBhc3NpZ25lZCBkZXZpY2UgaW4gd2hpY2ggY2FzZSBhIEhvc3RJT01NVURldmljZSBjb3VsZCBi
ZSBhZGRlZCB0bw0KPj4+IHRoaXMgbGF0dGVyLiBJIHRoaW5rIHRoaXMgc2hvdWxkIGJlIGV4cGxh
aW5lZCBpbiB0aGUgY29tbWl0IG1zZw0KPj4gWWVzLCBhcyB5b3Ugc2FpZCwgaXQncyBhIG1hdHRl
ciBvZiBhbGlhc2VkIHZzIG5vbiBhbGlhc2VkIEJERi4NCj4+DQo+PiBWVERBZGRyZXNzU3BhY2Ug
aXMgcGVyIGFsaWFzZWQgQkRGIHdoaWxlIFZUREhvc3RJT01NVURldmljZSBpcyBwZXINCj5ub24g
YWxpYXNlZCBCREYuDQo+PiBUaGVyZSBjYW4gYmUgbXVsdGlwbGUgYXNzaWduZWQgZGV2aWNlcyB1
bmRlciBzYW1lIHZpcnR1YWwgaW9tbXUgZ3JvdXANCj5hbmQgc2hhcmUgc2FtZQ0KPj4gVlREQWRk
cmVzc1NwYWNlLCBidXQgdGhleSBoYXZlIHRoZWlyIG93biBWVERIb3N0SU9NTVVEZXZpY2UuDQo+
Pg0KPj4gV2lsbCByZWZpbmUgY29tbWl0IG1zZy4NCj4NCj5PSyB0aGFuayB5b3UgZm9yIHRoZSBj
b25maXJtYXRpb24uIEEgZ2VuZXJhbCBjb25jZXJuIGlzIHRoaXMgaXMgdGhlIGtpbmQNCj5vZiBj
b2RlIHdlIGFyZSBnb2luZyB0byBkdXBsaWNhdGUgaW4gZWFjaCB2SU9NTVUuDQoNClRoZSBoYXNo
IHRhYmxlIGNvZGUgY2FuIGJlIGNvbW1vbiwgYnV0IHdpbGwgd2UgaGF2ZSBvdGhlciBkdXBsaWNh
dGUgY29kZT8NCkkgZmVlbCBtb3N0IG9mIHRoZSBjb2RlcyBhcmUgVlREIHNwZWNpZmljLg0KDQo+
IFRoaXMgaXMgYmV5b25kIHRoZQ0KPnNjb3BlIG9mIHRoaXMgc2VyaWVzIGJ1dCB3ZSBzaGFsbCBy
ZWFsbHkgdGhpbmsgYWJvdXQgaW50cm9kdWNpbmcgYQ0KPmNvbW1vbiBiYXNlIG9iamVjdCBmb3Ig
dklPTU1VLiBVbmZvcnR1bmF0ZWx5IHRoZXJlIGFyZSBpc3N1ZXMgcmVsYXRlZCB0bw0KPm11bHRp
cGxlIGluaGVyaXRlbmNlIHRoYXQgbWF5IHByZXZlbnQgdXMgZnJvbSB1c2luZyB1c3VhbCBRT00N
Cj5pbmhlcml0ZW5jZSBidXQganVzdCBhcyB3ZSBoYXZlIGRvbmUgZm9yIGJhY2tlbmRzIGFuZCBI
b3N0SU9NTVVEZXZpY2UNCj53ZSBtYXkgaW1wbGVtZW50IGluaGVyaXRlbmNlIGFub3RoZXIgd2F5
Lg0KDQpZZXMsIHZpcnRpby1pb21tdSBpcyBkaWZmZXJlbnQgZnJvbSBvdGhlcnMsIGl0IGluaGVy
aXRzIGZyb20gVFlQRV9WSVJUSU9fREVWSUNFLg0KTm90IGdldCBhYm91dCB0aGUgYW5vdGhlciB3
YXksIGNvdWxkIHlvdSBleHBsYWluIGEgYml0Pw0KDQpUaGFua3MNClpoZW56aG9uZw0K

