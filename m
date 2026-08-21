Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3793C5DF87
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2026 07:16:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wxJU8-0004Dz-UN; Fri, 21 Aug 2026 03:16:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1wxJU6-0004Db-CO
 for qemu-devel@nongnu.org; Fri, 21 Aug 2026 03:16:14 -0400
Received: from mgamail.intel.com ([198.175.65.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1wxJU3-0004uU-B8
 for qemu-devel@nongnu.org; Fri, 21 Aug 2026 03:16:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787296571; x=1818832571;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=bA/jerg0ZtFR11fhhd2+gso7Pxmc9XO5RjXujL9GcD0=;
 b=iNi2lsjp0LkJN4/BYw7VA4sb78VlisUKv9Bo7XyJN66CTGjWZtVCP+o0
 s0+Hzuy2f9bifFgrjEmKdxTqo5nvhpbkhzzP2V8i9b8bMLDJqYNbrK1Kj
 0GJemBogVjG+9mrZyoFn0OL5/5sJvT3H+upPb6YAJiZQAM+2IvRLTAUL1
 rKI/G9meHrCjALxf+y0HiP8ez6LdD5HlybWbZqM3HmOD3IeM1RAJGyCxO
 w943dZhwWqk1ROGVKUPeSEyJIRjK8Oj2JsJqAl6+f1IQV3HZ7+mM/rnRn
 HxHh9GxN7oXm/IDvfdxVTG9jXQfpyh9u3RCl/Gv3GdaXh9fpouGk8YorV g==;
X-CSE-ConnectionGUID: +c3ZB95kTAKyAbLkzLLZRQ==
X-CSE-MsgGUID: ppTNeu8ISkeGNFudRQRS6w==
X-IronPort-AV: E=McAfee;i="6800,10657,11881"; a="87610736"
X-IronPort-AV: E=Sophos;i="6.25,234,1779174000"; d="scan'208";a="87610736"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Aug 2026 00:16:08 -0700
X-CSE-ConnectionGUID: Pz5Bt/sPQx6uYm7U8gxcww==
X-CSE-MsgGUID: VaUsl8CpQ4ClGSbR8gTkdQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,234,1779174000"; d="scan'208";a="269735995"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Aug 2026 00:16:08 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Fri, 21 Aug 2026 00:16:06 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Fri, 21 Aug 2026 00:16:06 -0700
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.32) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Fri, 21 Aug 2026 00:16:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RRgPg6hvvJOsLRQriJIsDkUuQ+pic2fLhBpqm/0MJoOVMKg9IeWUjlE5nRV/qGIISoEpMPjAK/GhJ1HJXOLN8arrSoq4SohpoOVsjNO3cMIb4QvRYkCPck0gtHWmTi1ofgYZhGclu4fZwOplAlNWy/bvGBzBrrc1HQXFGF1LfYEZGajaESaD4c8dThtAI/roPYqVfMV41YPgC8/xkV/cq3RZAeOErTzl3dxKqxxkhAYYnliNbLqR6FOH8q50lC4NwtdNXtKq67L9eWp7PaAJF9OVCWUDDWHwvqIFr9JuVwJb40YRVgqqwVqF0M44vxEkQVugMuts1I5Fc+KXWQD3Rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bA/jerg0ZtFR11fhhd2+gso7Pxmc9XO5RjXujL9GcD0=;
 b=SQoXMjW7rmiXrt4wUnfk/MA8fbMiWaZLRWIdsQrUV5GRbQzJwq7V3BKpEL5trDzesOvNDGpBv3NLoep/5HhQ4aLlvSYPKQEemTozRJ5KQP86Byq+qBSVQ1nUrSx4L0saotw5GfnHAtprW0LX1IyqnC9C+Ws5x2ebHj3gnraYgyNMw6wKKTAr6q/TY7AwQ1rDvS1rOoGLWxdmWzK6MLLryG30QzwoIQmFyD22lQ8bFQDCjonK9JuxqtisS5NejW6GEscX950LP3xnnKUqIOAw46V5dscrOZiGhBOH891ZbMK9jDWsOGfIzYzFP6/FO7z5EGfeuVlDB/g2iV0CBD0qQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12)
 by DM3PR11MB8716.namprd11.prod.outlook.com (2603:10b6:0:43::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.10; Fri, 21 Aug
 2026 07:15:57 +0000
Received: from IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::37b4:37a9:4f3:518b]) by IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::37b4:37a9:4f3:518b%3]) with mapi id 15.21.0339.007; Fri, 21 Aug 2026
 07:15:57 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: =?utf-8?B?Q2zDqW1lbnQgTUFUSElFVS0tRFJJRg==?=
 <clement.mathieu--drif@bull.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "alex@shazbot.org" <alex@shazbot.org>, "clg@redhat.com" <clg@redhat.com>, 
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "mst@redhat.com"
 <mst@redhat.com>, "jasowangio@gmail.com" <jasowangio@gmail.com>,
 "jgg@nvidia.com" <jgg@nvidia.com>, "nicolinc@nvidia.com"
 <nicolinc@nvidia.com>, "skolothumtho@nvidia.com" <skolothumtho@nvidia.com>,
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>, "Tian, Kevin"
 <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>, "Hao, Xudong"
 <xudong.hao@intel.com>
Subject: RE: [PATCH v3 0/6] intel_iommu: Enable PRQ support for passthrough
 device
Thread-Topic: [PATCH v3 0/6] intel_iommu: Enable PRQ support for passthrough
 device
Thread-Index: AQHdJXaoJ2foc7Rrs0CFGZilBc0gdraUUwKAgALNe6CAAAbZgIADRW4wgAAQPYCADWBJkIAAP/6AgAAFG0A=
Date: Fri, 21 Aug 2026 07:15:57 +0000
Message-ID: <IA3PR11MB9136C9DD34DD6DC631A2ECBE92A32@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <20260806073825.363468-1-zhenzhong.duan@intel.com>
 <45013c8a3fe7983ee31f52d9d9ba6c176ce98fdb.camel@bull.com>
 <IA3PR11MB9136D461AAF0FCC8D757B33C92DE2@IA3PR11MB9136.namprd11.prod.outlook.com>
 <97d42422c79aaa53a4a3faca5fc04ca75e22042c.camel@bull.com>
 <IA3PR11MB9136F6CEC9314AD408EFFE7992DC2@IA3PR11MB9136.namprd11.prod.outlook.com>
 <2d811cf876963acc75673078a869a63fdccdaf06.camel@bull.com>
 <IA3PR11MB9136C8AC130468162F9EE8A992A32@IA3PR11MB9136.namprd11.prod.outlook.com>
 <ecedc1b02ec279c36e84377f415730b44f879df8.camel@bull.com>
In-Reply-To: <ecedc1b02ec279c36e84377f415730b44f879df8.camel@bull.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9136:EE_|DM3PR11MB8716:EE_
x-ms-office365-filtering-correlation-id: 9dd0370d-61b7-46fd-8602-08deff540be8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|7416014|23010399003|22082099003|18002099003|56012099006|4143699003|38070700021|10067099003|11063799006;
x-microsoft-antispam-message-info: UbH0QJzCXOW1W433CUd0yfUTJpmCM5YFuxtHVX9BEuE24vbfVZY9QA9E2EeX3qGwACzwN9lFCKVpa8u+vO/SnBLnYlTqvgvGngyWG8lYYl5aVdL7OJFcfnt+6QEgSLR4junJ7HFJ2i9TC79rD1jNe8BgBWAlFfxuIAEkGnEXhOGXitbU9pB4CXfmLCjPlEcAA0eDfYrHraot3XRbYinILtu+GhCrXOHSiqLthECPklfdZKQ8dfcaZ2aO7La/SWHRN0F5WzHUAJ3lMwZGa4EdP+eb5n4JPpLNOY7dqEPX8oqE/jRX9e78UrPFKx9knrnChlRzYcfDKib3xKk7n0avSjxXA+wwMCFN5V7k8VX/OMpu3l9l5Zrq3GcuNHDs1dvD/FX5B/cdNG8EQXMrJiSsAETlZfqzFJatlVcmp4TrGvUk0MKjJleqHzDs4/RKPR757R+B6fHDti9FHZg0aEHjDKvNTmMJpLezMHI4DBOkg+VivoY9pv7tyV5M+9vrY2XxzbVOCRiQe8Q67+x1/VxzLiQNcQON1lZTUeUsN0Ye+KYSKHgz+B86Zvqge4TupshnTluD5Gqhxuo8PmnymZHvvow5CxOBiVm4AjJcN8midm7y69R7ervAcxiXcMZH7rlwzMUK7Ox0r5vG2tGxnmL96bnf3zoA3qlHR1jkD9NKaW3ZqOw2ImZR0LKGvKH9mb/4r5jXFKphVkIRwou4XCfts3RrN8tg0q16KOPibx6cjH8=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9136.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7416014)(23010399003)(22082099003)(18002099003)(56012099006)(4143699003)(38070700021)(10067099003)(11063799006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?alJ5cmY2UTNUN1Qyc0IrTHBFSkhNVDhJWGMrRDhWYUN6M09NSEdMakpDOVpM?=
 =?utf-8?B?ZE50Y1BoUElzRzVjYTYwS0ZnYXZlaEpWOFNPbC9BWUNaamc1SXpwT1EvbFd0?=
 =?utf-8?B?MFp3Wmc2b0ZXNDdnRVFHS3lBUnhKM1hGQWM1RUkwUkg1WEhUSmhIZ3Y3cEU0?=
 =?utf-8?B?MnZENDJ6ZU82SVpNZm5CSStkMTI2OHpFMVF2SzZ1TWJDVnlMU0k1ejVtQnFC?=
 =?utf-8?B?TXpaQW1UcVdwT013NE1iMkVVRk0rYUdxQ2VRT2lscmhDbVFzZ0hRMitUd3Vk?=
 =?utf-8?B?bnRGT2swWGxMYk9wWiszNjNxWk9rNmU3dHhPZDFPTlM0aUg0RUxjdmY0Vms3?=
 =?utf-8?B?c1dmTXhzVk9tTU9RbVhhWnlBZnkzWkpOcS82Mk44Znc0MWVrT3E4RzR6Wnlz?=
 =?utf-8?B?UWFabks5VEdoVnptaUd4RFBmbGNvZDR2ZEZieVBNbEVUMWwzbnB5ZHhoazlr?=
 =?utf-8?B?ZGJORTgwZ0FaK0xCYlMzSXZqYlVOZ1U1OWhJQjJIakQxbE43aFNRVENIUXNh?=
 =?utf-8?B?N1JQYmxITjFuOW1yK1hNa2VZNFp5MHBnM2Z1Ri9TcEVPM1NNVGlxb2JNMElm?=
 =?utf-8?B?WnMxeUxXSEVGSGwzcXk1RHlDT3ZNWE1neVVsRUs3T1pNYnRVeDNPclhPditZ?=
 =?utf-8?B?UXBuNXFXVFFUVzRiTWRrdml0OXl5bkhFZEVJQTNOTTJGYWU3YUJQZ1pyQmMr?=
 =?utf-8?B?OUcxaDBEaWFEYUs1Vmh3UG9SMkp1T1RINHhHRUVrMlNHWmNPQjRTOEQyV21a?=
 =?utf-8?B?WmxuN0VWRGdab0RzNFU5akZpelVFRHFvbSs1TGpPeXhIb0pHeVd6dFhNY2tj?=
 =?utf-8?B?c1VWcWd6YVBjUmR4eG1XaVYxRkVwM3dyMFBoY3AreVljR1IrUWNVaGE1SGti?=
 =?utf-8?B?dkpIOGNSa2c3V0pXcWQ2djVDTFlIdllvMHJtZS9IcmlHZDdxNS9qYmZaVHJ4?=
 =?utf-8?B?NDBKektzOU42WWo3S0Mza21QRk80QlZ2ZVo0NnRSV2VVdlhESFlsS0l4OXJ3?=
 =?utf-8?B?QTc1KzR5eVdEYi94WllBckJ0aEZybXV6K1MrTHRzMGw4WWg5d3d1Y05MQk9C?=
 =?utf-8?B?RGVuSWY3V3BMaDZnalc2aHpIUy9tM1orWFNubDJrSUVUMDdXZWV5WFdxOWNN?=
 =?utf-8?B?dVMyUXRiM3ZtT2JOcmk2d3ZYcTBkZmt6aDJiZzgzbXZjeFFJY3duK0JUSFVl?=
 =?utf-8?B?eHFtL2ZHM01XNlJDakhIdEc0YjZrVGZrWmExMFhOWHFQRUtaWEJJODZIcjBI?=
 =?utf-8?B?RlkyMzh2OUFvYVlOUWxqc1lWYk9KdjZPUVFyM3ZjeWpGcHBFZlRsOUpoVWJm?=
 =?utf-8?B?SWhxQjJneThabTArdzk0RUlEb1ZTYW9nM09zdkZIbmZaMDZQNWRYVHp4OTR0?=
 =?utf-8?B?d0FPdmdleUVKZk54Z2hzaWpVaHBKUURucWl1b3MxZzA1b0orSW5ra1d5bGFO?=
 =?utf-8?B?eTJnUDFqK3QrOENST2xNbko1ejl2ZGNCaUFJMzM4LzFzTXlkaWh6M0pxeWY2?=
 =?utf-8?B?SmQveGVXQU8zcHRueG10VTdraSs1eW5INFc5RmhqYVVaVlhuYWtkYUVHeHZ4?=
 =?utf-8?B?d1NiYXJ0KzJlcWxlVmU3RHBFMmowM0VGaFVLNnNqa2RoSnFkQzUxeEgzNEI5?=
 =?utf-8?B?U0VYZHlpQmRiSlFTVDl0Wm9WZFNhR3Z3UmdGY3R6L2NNSk5udzVQL3NVb01H?=
 =?utf-8?B?M0d1ZDFBMDM1M2tOMHpvYzBHUkFSOXhrbUxtSGxYZ08rRTZ4MTVKMHMza1Er?=
 =?utf-8?B?OElXaDVjaGk5blFxUEF3NkovcThDblFUaDBBTEs2cWZNZGtycmlDSUU4bFBF?=
 =?utf-8?B?MkphdG9DNWs1WFNpK2dOTzhMeUFEMjZtMVRnOHU1TVhVMlJZQkQ2MmtJUDFP?=
 =?utf-8?B?eVFjaHNXbHV3dzRzVDY2N1gwamE5enBJbnJiK1RNbFFwYWErYkpwTnl6a2hU?=
 =?utf-8?B?NGlNdVYxMmdxbTA3UmdmSEl0Vk96eHhDYjhXckdzMzdyVnZBWkZyNk5ISjRG?=
 =?utf-8?B?VmUxZzhnSmtjN3VpSTVqK0lwemRFUnB6a3V1eCtpU3Mxa0hveU1KNTJqMXFS?=
 =?utf-8?B?bFp3NTJIQ1Jla2w4dWFZUndUQ2FVck5FK3kxdFRDNk9WV1M5a0N2LzhHRWp5?=
 =?utf-8?B?bWppZkRxZUR6S3lUN1lNV3VoaW5wcTlEMHNENytKcHFFUnloWlVPV3lLNTAz?=
 =?utf-8?B?S3k3UnZrMm9Udlo2bFNCMmV5cjZtQk4rand2ZWc1a05jTGg5ckVvbXJVNWh1?=
 =?utf-8?B?ZXd6dFFJZThBa2ZhanJiVW9ZbXphY3lvSjBCbjhacVB4LysxVzVoZThGRnI1?=
 =?utf-8?B?dkVqUE1DT2YwdloxeWJUSDZlcFFNNjk5YWdmMnRGakNhM3NiS3NUQT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: pZfpqfdMeKsyD1EtPenCvskEoK21VHftxM6DvD9cRVkOenBkICV2RcosK6Onh9LFrjybmZlQtsdIAzU+TBXIC8rPPAEXKzB8YUxS/UnobjZ038IvqjlQGY2K0FyIxbes+jbRdOVBwjwoIqc9568o36i54ygXqRU7t9x0fpOcrwadRh3ZI2v65oksA5aQ+8OAAqKFo4H5oiI894VE4QzUgdpBHKW1I3cBVq6luCMFSYSTFWSnuricuwrOEDHyq2kj/EtbTEMJQlhPw+petYjIlZh/AmnRg1d7aIpFCvXx2cYw0m2TP5I7KEW0EAkPJSgRSoUIkOOP4DbEkyKH+hEurQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9136.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9dd0370d-61b7-46fd-8602-08deff540be8
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Aug 2026 07:15:57.4707 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KWzElyLIdvwKqxhb8/dNHG6Ss9+suRqMy0J5W7HJY/Htfvvnow98WjGUwdJFSIc3KiXy3tQ5qaY7ALsYerLZDEBHOzXkEglLfNxThYmW5t8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR11MB8716
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.20;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.346,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IENsw6ltZW50IE1BVEhJRVUt
LURSSUYgPGNsZW1lbnQubWF0aGlldS0tZHJpZkBidWxsLmNvbT4NCj5TdWJqZWN0OiBSZTogW1BB
VENIIHYzIDAvNl0gaW50ZWxfaW9tbXU6IEVuYWJsZSBQUlEgc3VwcG9ydCBmb3IgcGFzc3Rocm91
Z2gNCj5kZXZpY2UNCj4NCj4NCj5PbiBGcmksIDIwMjYtMDgtMjEgYXQgMDI6NDQgKzAwMDAsIER1
YW4sIFpoZW56aG9uZyB3cm90ZToNCj4+IENhdXRpb246IEV4dGVybmFsIGVtYWlsLiBEbyBub3Qg
b3BlbiBhdHRhY2htZW50cyBvciBjbGljayBsaW5rcywgdW5sZXNzIHRoaXMgZW1haWwNCj5jb21l
cyBmcm9tIGEga25vd24gc2VuZGVyIGFuZCB5b3Uga25vdyB0aGUgY29udGVudCBpcyBzYWZlLg0K
Pj4NCj4+DQo+PiBIaSBDbGVtZW50LA0KPj4NCj4+DQo+PiA+IC0tLS0tT3JpZ2luYWwgTWVzc2Fn
ZS0tLS0tDQo+PiA+IEZyb206IENsw6ltZW50IE1BVEhJRVUtLURSSUYgPFtjbGVtZW50Lm1hdGhp
ZXUtLQ0KPmRyaWZAYnVsbC5jb21dKG1haWx0bzpjbGVtZW50Lm1hdGhpZXUtLWRyaWZAYnVsbC5j
b20pPg0KPj4gPiBTdWJqZWN0OiBSZTogW1BBVENIIHYzIDAvNl0gaW50ZWxfaW9tbXU6IEVuYWJs
ZSBQUlEgc3VwcG9ydCBmb3IgcGFzc3Rocm91Z2gNCj4+ID4gZGV2aWNlDQo+PiA+DQo+PiA+DQo+
PiA+IE9uIFdlZCwgMjAyNi0wOC0xMiBhdCAxMzoyNiArMDAwMCwgRHVhbiwgWmhlbnpob25nIHdy
b3RlOg0KPj4gPg0KPj4gPiA+IENhdXRpb246IEV4dGVybmFsIGVtYWlsLiBEbyBub3Qgb3BlbiBh
dHRhY2htZW50cyBvciBjbGljayBsaW5rcywgdW5sZXNzIHRoaXMNCj5lbWFpbA0KPj4gPg0KPj4g
PiBjb21lcyBmcm9tIGEga25vd24gc2VuZGVyIGFuZCB5b3Uga25vdyB0aGUgY29udGVudCBpcyBz
YWZlLg0KPj4gPg0KPj4gPiA+DQo+PiA+ID4NCj4+ID4gPg0KPj4gPiA+DQo+PiA+ID4gPiAtLS0t
LU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPj4gPiA+ID4gRnJvbTogQ2zDqW1lbnQgTUFUSElFVS0t
RFJJRiA8W2NsZW1lbnQubWF0aGlldS0tDQo+PiA+ID4NCj4+ID4NCj4+ID4gW2RyaWZAYnVsbC5j
b21dKG1haWx0bzpkcmlmQGJ1bGwuY29tKV0obWFpbHRvOltjbGVtZW50Lm1hdGhpZXUtLQ0KPmRy
aWZAYnVsbC5jb21dKG1haWx0bzpjbGVtZW50Lm1hdGhpZXUtLWRyaWZAYnVsbC5jb20pKT4NCj4+
ID4NCj4+ID4gPg0KPj4gPiA+ID4gU3ViamVjdDogUmU6IFtQQVRDSCB2MyAwLzZdIGludGVsX2lv
bW11OiBFbmFibGUgUFJRIHN1cHBvcnQgZm9yDQo+cGFzc3Rocm91Z2gNCj4+ID4gPiA+IGRldmlj
ZQ0KPj4gPiA+ID4NCj4+ID4gPiA+DQo+PiA+ID4gPiBPbiBNb24sIDIwMjYtMDgtMTAgYXQgMTA6
NDkgKzAwMDAsIER1YW4sIFpoZW56aG9uZyB3cm90ZToNCj4+ID4gPiA+DQo+PiA+ID4gPg0KPj4g
PiA+ID4gPiBDYXV0aW9uOiBFeHRlcm5hbCBlbWFpbC4gRG8gbm90IG9wZW4gYXR0YWNobWVudHMg
b3IgY2xpY2sgbGlua3MsIHVubGVzcw0KPnRoaXMNCj4+ID4gPiA+DQo+PiA+ID4NCj4+ID4NCj4+
ID4gZW1haWwNCj4+ID4NCj4+ID4gPg0KPj4gPiA+ID4NCj4+ID4gPiA+IGNvbWVzIGZyb20gYSBr
bm93biBzZW5kZXIgYW5kIHlvdSBrbm93IHRoZSBjb250ZW50IGlzIHNhZmUuDQo+PiA+ID4gPg0K
Pj4gPiA+ID4NCj4+ID4gPiA+ID4NCj4+ID4gPiA+ID4NCj4+ID4gPiA+ID4gSGkgQ2xlbWVudCwN
Cj4+ID4gPiA+ID4NCj4+ID4gPiA+ID4NCj4+ID4gPiA+ID4NCj4+ID4gPiA+ID4NCj4+ID4gPiA+
ID4gPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPj4gPiA+ID4gPiA+IEZyb206IENsw6lt
ZW50IE1BVEhJRVUtLURSSUYgPFtjbGVtZW50Lm1hdGhpZXUtLQ0KPj4gPiA+ID4gPg0KPj4gPiA+
ID4gPg0KPj4gPiA+ID4NCj4+ID4gPiA+DQo+PiA+ID4gPg0KPltbZHJpZkBidWxsLmNvbV0obWFp
bHRvOmRyaWZAYnVsbC5jb20pXShtYWlsdG86W2RyaWZAYnVsbC5jb21dKG1haWx0bzpkcmlmQGJ1
bGwuYw0KPm9tKSldKG1haWx0bzpbY2xlbWVudC5tYXRoaWV1LS0NCj4+ID4gPg0KPj4gPg0KPj4g
PiBbZHJpZkBidWxsLmNvbV0obWFpbHRvOmRyaWZAYnVsbC5jb20pXShtYWlsdG86W2NsZW1lbnQu
bWF0aGlldS0tDQo+ZHJpZkBidWxsLmNvbV0obWFpbHRvOmNsZW1lbnQubWF0aGlldS0tZHJpZkBi
dWxsLmNvbSkpKT4NCj4+ID4NCj4+ID4gPg0KPj4gPiA+ID4NCj4+ID4gPiA+DQo+PiA+ID4gPiA+
DQo+PiA+ID4gPiA+DQo+PiA+ID4gPiA+ID4gU3ViamVjdDogUmU6IFtQQVRDSCB2MyAwLzZdIGlu
dGVsX2lvbW11OiBFbmFibGUgUFJRIHN1cHBvcnQgZm9yDQo+PiA+ID4gPiA+DQo+PiA+ID4gPg0K
Pj4gPiA+DQo+PiA+DQo+PiA+IHBhc3N0aHJvdWdoDQo+PiA+DQo+PiA+ID4NCj4+ID4gPiA+DQo+
PiA+ID4gPiA+DQo+PiA+ID4gPiA+ID4gZGV2aWNlDQo+PiA+ID4gPiA+ID4NCj4+ID4gPiA+ID4g
PiBIaSBaaGVuemhvbmcsDQo+PiA+ID4gPiA+ID4NCj4+ID4gPiA+ID4gPiBJIHdpbGwgcmVhZCB0
aGlzIHNlcmllcyBlYXJseSBuZXh0IHdlZWsuDQo+PiA+ID4gPiA+ID4gdGhhbmtzIGZvciB0aGUg
cmVzcGluIQ0KPj4gPiA+ID4gPiA+DQo+PiA+ID4gPiA+ID4gYnR3LCByZWxhdGVkIHRvIHRoaXMg
d29yazogaGF2ZSBldmVyIHNlZW4NCj4+ID4gPiA+ID4gPiB2ZmlvX2RldmljZV9nZXRfYXdfYml0
cyByZXR1cm5pbmcgNDcgd2hlcmVhcw0KPj4gPiA+ID4gPiA+IHRoZSBpb21tdSBzdXBwb3J0cyA0
OD8gVGhpcyBsZWFkcyB0aGUgZm9sbG93aW5nDQo+PiA+ID4gPiA+ID4gYXcgdGVzdCB0byBmYWls
Og0KPj4gPiA+ID4gPiA+DQo+PiA+ID4gPiA+ID4gYGBgDQo+PiA+ID4gPiA+ID4gcmV0ID0gaGlv
ZGMtPmdldF9jYXAoaGlvZCwgSE9TVF9JT01NVV9ERVZJQ0VfQ0FQX0FXX0JJVFMsDQo+ZXJycCk7
DQo+PiA+ID4gPiA+ID4gaWYgKHJldCA8IDApIHsNCj4+ID4gPiA+ID4gPiDCoMKgIHJldHVybiBm
YWxzZTsNCj4+ID4gPiA+ID4gPiB9DQo+PiA+ID4gPiA+ID4gaWYgKHMtPmF3X2JpdHMgPiByZXQp
IHsNCj4+ID4gPiA+ID4gPiDCoMKgIGVycm9yX3NldGcoZXJycCwgImF3LWJpdHMgJWQgPiBob3N0
IGF3LWJpdHMgJWQiLCBzLT5hd19iaXRzLCByZXQpOw0KPj4gPiA+ID4gPiA+IMKgwqAgcmV0dXJu
IGZhbHNlOw0KPj4gPiA+ID4gPiA+IH0NCj4+ID4gPiA+ID4gPiBgYGANCj4+ID4gPiA+ID4gPg0K
Pj4gPiA+ID4gPiA+IEkgZ290IHRoaXMgd2hlbiB0cnlpbmcgdG8gbmVzdCBWTXMuDQo+PiA+ID4g
PiA+DQo+PiA+ID4gPiA+DQo+PiA+ID4gPiA+DQo+PiA+ID4gPiA+DQo+PiA+ID4gPiA+IEkgYW0g
dHJ5aW5nIHRvIHJlcHJvZHVjZSwgd2hhdCBkZXZpY2UgZGlkIHlvdSBwYXNzdGhyb3VnaD8NCj4+
ID4gPiA+DQo+PiA+ID4gPg0KPj4gPiA+ID4NCj4+ID4gPiA+IEkgdXNlZCBlZHUgZm9yIHRlc3Rp
bmcuDQo+PiA+ID4gPiBBbiBJIGhhZCBhdy1iaXRzPTQ4IG9uIGJvdGggdm1zLg0KPj4gPiA+DQo+
PiA+ID4NCj4+ID4gPg0KPj4gPiA+IFJlcHJvZHVjZWQgdGhlIHNhbWUgd2l0aCBMMShmc3RzPW9u
KSBhbmQgTDIoZnN0cz1vZmYpLg0KPj4gPg0KPj4gPg0KPj4gPiBNeSBjb25maWcgaGFzIGZzdHM9
b24gb24gYm90aCBWTXMuDQo+PiA+IFdoaWNoIGtlcm5lbCBhcmUgeW91IHVzaW5nPw0KPj4gPiBN
aW5lIGlzIFJIRUwxMC4yICg2LjEyLjAtMjExLjcuMy5lbDEwXzIueDg2XzY0KQ0KPj4NCj4+DQo+
PiBJbiB0aGVvcnkgd2Ugd2lsbCBub3QgcnVuIGludG8gdGhhdCBjaGVjayBpZiBmc3RzPW9uIG9u
IGJvdGggVk1zLCBvbiBteSBlbnYgSSBzZWU6DQo+Pg0KPj4gInFlbXUtc3lzdGVtLXg4Nl82NDog
LWRldmljZSB2ZmlvLXBjaSxob3N0PTAwOjA0LjAsaW9tbXVmZD1pb21tdWZkMDogdmZpbw0KPjAw
MDA6MDA6MDQuMDogRmFpbGVkIHRvIGFsbG9jYXRlIGh3cHQ6IE9wZXJhdGlvbiBub3Qgc3VwcG9y
dGVkIg0KPj4NCj4+IHdoaWNoIGlzIGV4cGVjdGVkIGFzIHdlIHdhbnQgbmVzdGluZyBzdXBwb3J0
IGluIEwxIGJ1dCBpdCBvbmx5IHN1cHBvcnRzIGZzdHMuDQo+DQo+T2ggeWVwLCBJIGZvcmdvdCB0
byBtZW50aW9uIHRoYXQgSSdtIG5vdCBhdHRhY2hpbmcgaW9tbXVmZCBmb3IgdGhpcyB0ZXN0Lg0K
PkkgYWdyZWUgd2l0aCB3aGF0IHlvdSBzYXkgd2hlbiBpb21tdWZkIGlzIHByZXNlbnQsIGJ1dCB3
aXRob3V0IGl0ICh3ZWlyZCBjb25maWcsDQo+SSBhZG1pdCwgYnV0IGludGVyZXN0aW5nIGZvciB0
ZXN0aW5nKSwgSSBnZXQ6DQo+DQo+YGBgDQo+cWVtdS1zeXN0ZW0teDg2XzY0OiAtZGV2aWNlIHZm
aW8tcGNpLGhvc3Q9MDA6MDEuMDogdmZpbyAwMDAwOjAwOjAxLjA6IEZhaWxlZCB0bw0KPnNldCB2
SU9NTVU6IGF3LWJpdHMgNDggPiBob3N0IGF3LWJpdHMgNDcNCg0KT2gsIEkgc2VlLCBJIHJlcHJv
ZHVjZWQgdGhlIHNhbWUuDQoNCj5gYGANCj4NCj5KdXN0IHdvbmRlcmluZyB3aHkgc3VjaCBhIDFi
aXQgZGlmZmVyZW5jZS4NCg0KaG9zdCBhdy1iaXRzIDQ3IGlzIHdoYXQgaG9zdCBrZXJuZWwgc3Vw
cG9ydHMsIG5vdCB0aGUgcHVyZSBodyBsaW1pdC4NCkZvciBmaXJzdCBzdGFnZSBwYWdlIHRhYmxl
LCBQVF9GRUFUX1NJR05fRVhURU5EIGlzIHNldCwNCmtlcm5lbCBsaW1pdGVkIG1heCBpb3ZhIHJh
bmdlcyB0byA0N2JpdCBldmVuIHRob3VnaCBodyBzdXBwb3J0cyA0OCBiaXQsIHNlZSBiZWxvdzoN
Cg0Kc3RhdGljIF9fYWx3YXlzX2lubGluZSBzdHJ1Y3QgcHRfcmFuZ2UgX3B0X3RvcF9yYW5nZShz
dHJ1Y3QgcHRfY29tbW9uICpjb21tb24sDQogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIHVpbnRwdHJfdCB0b3Bfb2ZfdGFibGUpDQp7DQouLi4NCiAg
ICAgICAgLyoNCiAgICAgICAgICogVGhlIHRvcCByYW5nZSB3aWxsIGRlZmF1bHQgdG8gdGhlIGxv
d2VyIHJlZ2lvbiBvbmx5IHdpdGggc2lnbiBleHRlbmQuDQogICAgICAgICAqLw0KICAgICAgICBy
YW5nZS5tYXhfdmFzel9sZzIgPSBtYXhfdmFzel9sZzI7DQogICAgICAgIGlmIChwdF9mZWF0dXJl
KGNvbW1vbiwgUFRfRkVBVF9TSUdOX0VYVEVORCkpDQogICAgICAgICAgICAgICAgbWF4X3Zhc3pf
bGcyLS07DQouLi4NCn0NCg0KU28gcWVtdSBnZXRzIGhvc3QgYXctYml0cyA0Ny4gVGhpcyBpcyBz
dHJpY3RseSBmb2xsb3dpbmcgdnRkIHNwZWM6DQoNClNvZnR3YXJlIHVzaW5nIGZpcnN0LXN0YWdl
IHRyYW5zbGF0aW9uIHN0cnVjdHVyZXMgdG8gdHJhbnNsYXRlIGFuIElPIFZpcnR1YWwgQWRkcmVz
cyAoSU9WQSkgbXVzdCB1c2UgDQpjYW5vbmljYWwgYWRkcmVzc2VzLiBBZGRpdGlvbmFsbHksIHNv
ZnR3YXJlIG11c3QgbGltaXQgYWRkcmVzc2VzIHRvIGxlc3MgdGhhbiB0aGUgbWluaW11bSBvZiBN
R0FXIA0KYW5kIHRoZSBsb3dlciBjYW5vbmljYWwgYWRkcmVzcyB3aWR0aCBpbXBsaWVkIGJ5IEZT
UE0gKGkuZS4sIDQ3LWJpdCB3aGVuIEZTUE0gaXMgNC1sZXZlbCBhbmQgNTYtYml0IA0Kd2hlbiBG
U1BNIGlzIDUtbGV2ZWwpLg0KDQpCUnMsDQpaaGVuemhvbmcNCg==

