Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69F8FCD043F
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Jan 2026 06:30:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vd0aW-0002Vi-LN; Tue, 06 Jan 2026 01:30:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1vd0aU-0002QG-Fu
 for qemu-devel@nongnu.org; Tue, 06 Jan 2026 01:30:38 -0500
Received: from mgamail.intel.com ([198.175.65.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1vd0aS-0003j8-MV
 for qemu-devel@nongnu.org; Tue, 06 Jan 2026 01:30:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1767681037; x=1799217037;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=12zcVrigPXpbdlXPNZ7KJJiRRc1tP0oHZmIvNl5vlR4=;
 b=m8hF3W0VCxXIMuSzcWfvnie5RGEg4aBkS5fyuviOwtGniL0bs+/9OM7G
 zvIxP01+63jhb+DANl8kr+kNDNq/ssMXWlOxsdOmogfqTa+OVjeJIITrL
 R5eZhc9JGH9SuGpBVxnfdQh9MPcRSZzKjL9m2zqelTG1DRNtWGD6GXsVV
 LnRNIUheGH53aXToiFSUH3Dz/W7YlCaXABHwuI5ZUErSrxj3ZHwDwYtGs
 PVgO3PW0jmJvQEApBtdtEqmxC2UQDC3q7GYcWU4SX+ZKEXvGpsHWe73/4
 abbm52eu3tdG0fbV5ySHDay75w1qDpiPjKAW5MYjAp+04mB9LaYCnv4KH w==;
X-CSE-ConnectionGUID: vm8n6nh8SICb1mcuTS0K3A==
X-CSE-MsgGUID: R0mJm7+5TGWXy6WybCRuow==
X-IronPort-AV: E=McAfee;i="6800,10657,11662"; a="80161984"
X-IronPort-AV: E=Sophos;i="6.21,204,1763452800"; d="scan'208";a="80161984"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Jan 2026 22:30:35 -0800
X-CSE-ConnectionGUID: /wzw/s4PTYq340CW40Xd9A==
X-CSE-MsgGUID: aqRMg5mtTWyx34ekMVYzHw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,204,1763452800"; d="scan'208";a="233714951"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Jan 2026 22:30:35 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Mon, 5 Jan 2026 22:30:34 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Mon, 5 Jan 2026 22:30:34 -0800
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.44) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Mon, 5 Jan 2026 22:30:33 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fxcze6U+qfwLQbcMlEIWZuUQd+k8Kq+0VUIlGlmBy0I2+tB45ZTBhlLTC5clHq+KgdSWZQHmM/GWPwbLAfFxS86SKA/gx+yZODyUphBVfzh9GQWG2MDj5+TbUtT52ejKlNBYI+lwTMqtAsN+I6NaxooUg4aQtfk9CXfFDd9dR/iQdbVbM02fZqbw5AczT48CnorFlqOZfba3DU+nw+UQDUeVMp5OXthnyTT+tgizJ5K98rP+swP2t/eW64YkVfFM5gkBg/St5AiUAE/YGJ/vNpFlZATj8SLzrC/35SWzND0KkMPTkqfnmwl82mFIj2jsGjwPn9xVbiXSeERwkEuVxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=12zcVrigPXpbdlXPNZ7KJJiRRc1tP0oHZmIvNl5vlR4=;
 b=Nzhouq4ZYJPy/PRXIyymZ+nYVJAn9J1fh6x9TQWRoP5fEf/IjjGF0Keo3126MrQ+THKgM+Wku7RmpXokrOq1PFgrkmCMRNVH8f5spdcNLNrzLxy8NkPOHxXdeBd02U+Reh9oT/1ojVsXrrHGQyaBwdE18GlR+eioZX9VI7ysVQBr7UXUoIeNzgqKa+RCmz0nvqtJyMUv3AtIFmgvahBJ35ybhxCvRHB5oMYue++68mn3X3XVcv5wD0fzNKRJlI8oLGMzAeO5rqeB5dGbOQ2yHZ+L975/deQ6U4reKCMDmgrGCjNj/HlAGYXy/dO6JkUAyhZoOZM0rTY7AR9X7aUtzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12)
 by SA2PR11MB4811.namprd11.prod.outlook.com (2603:10b6:806:11d::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Tue, 6 Jan
 2026 06:30:30 +0000
Received: from IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13]) by IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13%7]) with mapi id 15.20.9456.013; Tue, 6 Jan 2026
 06:30:30 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "alex@shazbot.org" <alex@shazbot.org>, "eric.auger@redhat.com"
 <eric.auger@redhat.com>, "mst@redhat.com" <mst@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>, "peterx@redhat.com"
 <peterx@redhat.com>, "ddutile@redhat.com" <ddutile@redhat.com>,
 "jgg@nvidia.com" <jgg@nvidia.com>, "nicolinc@nvidia.com"
 <nicolinc@nvidia.com>, "skolothumtho@nvidia.com" <skolothumtho@nvidia.com>,
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>,
 "clement.mathieu--drif@eviden.com" <clement.mathieu--drif@eviden.com>, "Tian, 
 Kevin" <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>, "Peng, Chao
 P" <chao.p.peng@intel.com>
Subject: RE: [PATCH v9 05/19] hw/pci: Introduce pci_device_get_viommu_flags()
Thread-Topic: [PATCH v9 05/19] hw/pci: Introduce pci_device_get_viommu_flags()
Thread-Index: AQHcbY9GN966atXl5UeW4qy4WWgAe7VDs7iAgADh2VA=
Date: Tue, 6 Jan 2026 06:30:30 +0000
Message-ID: <IA3PR11MB91364B1ED1B0CDB76E174A8A9287A@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <20251215065046.86991-1-zhenzhong.duan@intel.com>
 <20251215065046.86991-6-zhenzhong.duan@intel.com>
 <3e471204-fe5a-41ce-9f09-dcc3c3e0dd18@redhat.com>
In-Reply-To: <3e471204-fe5a-41ce-9f09-dcc3c3e0dd18@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9136:EE_|SA2PR11MB4811:EE_
x-ms-office365-filtering-correlation-id: 462e2ad2-744a-472b-ef2b-08de4ced168e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|7416014|1800799024|366016|38070700021; 
x-microsoft-antispam-message-info: =?utf-8?B?NmxGb0dxMXg0a3B2dVNEeTFsTjhOSUQ2VUhoRVdKZUEyWkx0dFlpSFlVWkNz?=
 =?utf-8?B?aEJnYnppdDF4N08wdzZFK1RtVmNyNUgwZFpGMHhzanRVTGw0aHRwaWdFK01E?=
 =?utf-8?B?TTBrRVptRjQyUTgxVGFFVStQMTJYUDNWeGhOQllRWXVRVHZIWXF2RnpqQVVs?=
 =?utf-8?B?TzhVYmtYaU1YWUJVQTZyd3o3QkFqNk91azJGUkZGVkVqcEVCYjlDbzdpRXdB?=
 =?utf-8?B?WWlHRHd1aXVJdk9vTEh6WlJyZjdqVmxtNVh4Z3BxTnh1eXZrQ2t6M2pieUVv?=
 =?utf-8?B?d2tITVVUR2RLNXBEdXNHbVVGc3h0NEdhT2FVOUJwU3YrMmM1VTFJdUw0SEhh?=
 =?utf-8?B?WXdSOFlpUmJKZE1NOGJKRDJ5MVlscnlEL0w0dFFHa2hGMGlaV1VxZUphc3J1?=
 =?utf-8?B?NVY2ZGU0VVhqeXlqMDIxbGVtem5hY0R6Ykk3SDFVcFFYcUErRVplTVRDSC96?=
 =?utf-8?B?THBqR0FsVjVsQkl0NE9vcU1BQjc5YUJLeW5DOFBaRlQ3bzd5eXRNTFQ3MlVl?=
 =?utf-8?B?WTRDZmJPM3kvTlMvZitUcC9qME1Cd1VCaCtZbGQ5ZEU4V21wMDBRWFhnNnJ0?=
 =?utf-8?B?eXU2TGRpVW1yc0RYVXNpbUdhcTNpTEQrKzJQdi9CbmdORnptY0JKQ3VzV3Vl?=
 =?utf-8?B?VHBPUStEb1VYMG1sdTRLdG5JVzdkandBYk9NVlM2K09hdjhSRitQVEdqSk1M?=
 =?utf-8?B?cGw0NERXRVJkdHJnbUtmY1NxZ056eTMzTjFvako0SnhTYkZVMWV1MEhMZFRX?=
 =?utf-8?B?NVRoRkRyUWFmN2FnY0JwL1dLOVJaOVhvWjNUdFNQNkswL0tyOXJxeTg2YVF5?=
 =?utf-8?B?djBpVEJYdVVMck81cmVnMndTcmRuL0FhT1NnVDBoeG91VUFxRXRzdWpHeWlX?=
 =?utf-8?B?ZXZLc3JpdlpzNmMxdTNQZGF4TktNM3dvTnFrYmpEOVZzYzVibkEydkQ4Wkdn?=
 =?utf-8?B?WklaNHYvUEloeXpMbGJtbGpKRkl4VzM1R1NGQWRocFFBWlJQSVRKdGJaOUty?=
 =?utf-8?B?VXh6MlNnbWxQd1VuaWlheXNEdXlsRXk5aFVvWFpSNk1pdDBHVjV3N1BrVS9p?=
 =?utf-8?B?YjMzT2RCMndNSWZtWXQzZU8zM1pWcUtuc25xZm0yK0hiUHlQNzlWc2pnbVNs?=
 =?utf-8?B?aWNCYkdXZjk0UjgvUXlIb0ZwcHRRTDRHb3NhMGJBSFEwbHJOT0JaSXJCbGp3?=
 =?utf-8?B?ditYdk84R0tvQk94WDJCY2laeGQvdGtqb3JMem1zOWRwaWJCZU1Sd2VaYU5E?=
 =?utf-8?B?cSt0RFV1Z3BqMDBNR0hwU2doczlaKzBNYjNzR2U5NmNOanJRdHNOT241ZXIr?=
 =?utf-8?B?c3VlNmlXTk13NnpFdEFBTnRsRnJZU09NZkw2bXAwb29vNTNBUXc2eUN5OUZp?=
 =?utf-8?B?b29jNnQ4dUsvOE9IZVh4WThyNFhLSm9Uby8vdnFGWlplUjQvTWxDVjkvb1Bi?=
 =?utf-8?B?ZmRRTFc1am44QkF5TXdTdkhrbnZXMUdTOUN3enRLamFkU2RwSzdBNjBWVnNl?=
 =?utf-8?B?dXRHRTE3MWZMY2l0T3dSVTl5MnUwb0tnVnd4TUV6eURqV0lRYjJ1M3Y4YXRZ?=
 =?utf-8?B?Y1h2cFdpMG4rc0FId3M1NWZ0US84aEwrOE93NHZ5cDRmRzZGOGFVcTJQTDNC?=
 =?utf-8?B?ZE1CaEQ3OUViRUtPcXpQMGZBcXdYMTlidjc0SVBaS1FBaWxTMThudXp5Z3Mv?=
 =?utf-8?B?dW5IaU5qcm5nckk3bTFNS0FFcCtTY3dWUHBaUVJIbjh3R2hTODJnZzJOOXZY?=
 =?utf-8?B?UTFQczEveTI4a1B6VStSckJkNHFzOGRGZDM4VkNZZkFUc2wzTWZ6bHBheVlY?=
 =?utf-8?B?TklQS3VvU2tBdzljcXYwc0c1cENIa05zajBWUUlFeGIvWHFwSU9DMEptOFFP?=
 =?utf-8?B?Ty9FMXR2L1NwdGYxZ0x5WnpxL3BvUHhUOEZWcllsZXBxVTU4SHdneDZXSFJO?=
 =?utf-8?B?aTVjOUdORUVPeFU5MlI0VXVCbzBwODluMmVwZmVHQWRXMFJUR3hyMjBYNUpE?=
 =?utf-8?B?a2JLNnVFUUdGbWhhMlZrWEtpSVhNbXFlL3dGNHlsdVNieDBCVXNqTnVKZWht?=
 =?utf-8?Q?m5F0RI?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9136.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eVRvcUV1cjNHenVsSUE4Um0rbHEzQWowRXJKb0ZQc05XNVlUQTdzVGlXR3lz?=
 =?utf-8?B?WUFnaTd5TjZBVVgwZGxxS083eGZoQklvNGx1Qk13bDVIWlo2NmI0d0lWV2lw?=
 =?utf-8?B?bEYxWlZLd2ZLTzlHak5HOWVUZW5YeXR1WWtQN2dOL2x0MkZaRVJITDgyTHFU?=
 =?utf-8?B?UXNpQ3VKNXVIMTRoWGNzMWlCbVFzZVlTZ2xYVjhHdXhsSStVbkhHZWJ4NVVR?=
 =?utf-8?B?eXBDM0NmZTdWM0t1VDBsMUVkUkQrV2Y4S2pObHdadWtRU2UwTlJSOUQ3RnZV?=
 =?utf-8?B?N05ranM0MExrVEtCOU16bll0aU5RZlp6UlJqelJPaDF0ZDFvaVpzLzhTb1pY?=
 =?utf-8?B?STVWL1l6dnROQXFyWUpGbThpMXp4eDkyNDREV3A3Vm5zSFpmZS9yQVk3NXlC?=
 =?utf-8?B?dXRTbTFMd1JoMXJCWm9Ea3hVMnJJOE50bzdjVmVuMVkyQjNobTlSZmVnaEd5?=
 =?utf-8?B?bmZRelYzaUlPMy9rbmtxVkNJNFZyVkdiSG5CVWVxSzVLeWJ1dmVkdjhzVHNP?=
 =?utf-8?B?c01tVGJ3M240U3F3QW1YV2VvUHFLbVBkc2dkR2FPVjhZZlNHVDAvOG4vRm1C?=
 =?utf-8?B?MmNjQmx2TjJVdHEwM3NYR2N0VFBRcCtaaUhwNC9pclU5dk1BR2tlR3NLU2Ez?=
 =?utf-8?B?dVZ5RndzZWsxcVJsL3pvMnQ0aVNzaGM2WiswWWdWS3ZZZWlDZ3FZUUJjWE11?=
 =?utf-8?B?NGJnaWFNbWhFUTlPYkVsTEdtZ3YyZWdsRWdjVXppWFgwSEdVT29aZmpJSTdD?=
 =?utf-8?B?TDQrdW9wc1JFcWxXQWIrcGFISVVGTVZPZjlKQTA5RjY5YWRuMno1MnZROVk5?=
 =?utf-8?B?ZTR4UXJPMGpiOGRlbkpBc2ZKWVh5ZXIrZEVTUUROeE1MNlZ6cEtvSTJZUEMw?=
 =?utf-8?B?TStieWJyQUFIN0JJSEIzOWtSaXJUREhlT2JqOEM4RkMvQTBnbjFMdGh3R3RY?=
 =?utf-8?B?NFN5eGNyemhZbWVCVFhEWUxoaVRzbzF5NVRJUk9yN3daZkpmOUdqOW8zNFZF?=
 =?utf-8?B?MmtLaUZLMjVZRUU3SVFQL0ZuQlJBWklDMGV3UDBWZFIwWGV5enN1czB6Z0hE?=
 =?utf-8?B?SkIxQ0oxTVI4NTBXOERhV1V1SVh6MXpMeDVSaEE5akFMbmVyWFV2d0dHeXNs?=
 =?utf-8?B?WmFPeEVGb05YZTlEY0hqVWJNQno2UWRhREJ2ZjdnL0ZFSnhPcXc2ZEt6YjNW?=
 =?utf-8?B?Rndsb3p2dkU1WWlFZnhQVTQ4T1lUak9VTVZxcDdSRDNPR09nMkFlRUhuQXp3?=
 =?utf-8?B?ZVBmQzBtOWV3bW1lU0pnUVpVR0d2NDNmdzVnV0FCSUJrK3U4ei9hWHkrNWUy?=
 =?utf-8?B?ckV2V3dqQkRiQ3VMdHJjZ1hORER5L1ErdlZnbVZUY3pYUmVjTHIxSDZGaVNW?=
 =?utf-8?B?NUFMTjMyR3RaeHArMy96dzhSeURtQlZOMjVFL1FIT0FUOUhXWWM3Y2JPUjhy?=
 =?utf-8?B?NW9kZlFaWmhtUThlN1o4U1g3dWI4RXJSMGxzcS9kQzhRdTZUa0NFREw4V3NZ?=
 =?utf-8?B?V200TVhNdmduNTNEUFpCVUR2dk8zUDg0ZmZuUlEzenp0OGd1U0lQRWdlMFhW?=
 =?utf-8?B?Y0JCTVZGZ3JwcFNtUWxKRXNDMndLNmVpR0x2a0pHanAwWFltZllCRy9lOE9u?=
 =?utf-8?B?KzR2bmR4YlA1dEp5Ni83UFh3ZW9WbVd1VlBxR2RCN1p0ejhOcldOaU82MnhU?=
 =?utf-8?B?Z1dhQ2tpcVpRbjFBeVJvVEF1cy9QSDNvY2liNU5Ea2Z2T0V5K2FFbnRKNE9O?=
 =?utf-8?B?d0N5OXFJalJacjIxbDJySEpyRSsvYWhUK1VDVEdwWnVBZEdPMDBRUXc4MU92?=
 =?utf-8?B?RUN2L2ZyYWlOQmJhS0ZxTVdtalhiU3dSSHpWRUcwNnVRZm1mNlR0YUNnZFJW?=
 =?utf-8?B?Yy9acVF0QTkxWGJ5TGpZK244SVY3dnczenJvYVNaUUZKVGhrc1dyRzhPN0ls?=
 =?utf-8?B?bHN4ampNUVF5eDdSaFhrQ1RUUXFzUDNhaFEvMkNqTDNsZjh1MUkzb0oySnE5?=
 =?utf-8?B?cExjNCtBYWFNMi9mMFAxMEZ6QUE5TDJjdGRmbHlxYjM4aGx3Mzc4TWs3UTJP?=
 =?utf-8?B?SmUzVjRBVGNGVmFUUkVJWWpMck5rVGNJSXdjc2JtZ25xV2tyYW5HaTZ3SEZ2?=
 =?utf-8?B?VnR2ZDdFN0t3NHl3dVZlU2FRZ0M2OGV5RndDU0Z6d3A3R3htQitNUXdhR1hy?=
 =?utf-8?B?Q3pPaThtTUhmRHpvZWJFdU11SlptckNvUlRicUg4MTlkMHcxOXMvNnpOSjVJ?=
 =?utf-8?B?UHdvaDdSdXdvZjAyMGVQMFhJUENjMnBzbkhOQ0R5UDE1NERHd1AxaERrQXJM?=
 =?utf-8?B?d29MTFA3US95R3hQSkJmZWtkTFRBOEFXeVErS3I0SHRPRE9tZmxVZz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9136.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 462e2ad2-744a-472b-ef2b-08de4ced168e
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jan 2026 06:30:30.2507 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eie1j8W9QAbazP30Nx8rEqcdFGR3TxSJAWdSF9oODmKdq+zjMVDTjfDDq6vLbfT/84shjcfIS8J1exN0LrtYTqixcIyzxiSUc+/6XPymDrM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4811
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.13;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Pi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+RnJvbTogQ8OpZHJpYyBMZSBHb2F0ZXIgPGNs
Z0ByZWRoYXQuY29tPg0KPlN1YmplY3Q6IFJlOiBbUEFUQ0ggdjkgMDUvMTldIGh3L3BjaTogSW50
cm9kdWNlDQo+cGNpX2RldmljZV9nZXRfdmlvbW11X2ZsYWdzKCkNCj4NCj5IaSwNCj4NCj5PbiAx
Mi8xNS8yNSAwNzo1MCwgWmhlbnpob25nIER1YW4gd3JvdGU6DQo+PiBJbnRyb2R1Y2UgYSBuZXcg
UENJSU9NTVVPcHMgb3B0aW9uYWwgY2FsbGJhY2ssIGdldF92aW9tbXVfZmxhZ3MoKQ0KPndoaWNo
DQo+PiBhbGxvd3MgdG8gcmV0cmlldmUgZmxhZ3MgZXhwb3NlZCBieSBhIHZJT01NVS4gVGhlIGZp
cnN0IHBsYW5uZWQgdklPTU1VDQo+PiBkZXZpY2UgZmxhZyBpcyBWSU9NTVVfRkxBR19XQU5UX05F
U1RJTkdfUEFSRU5UIHRoYXQgYWR2ZXJ0aXNlcyB0aGUNCj4+IHN1cHBvcnQgb2YgSFcgbmVzdGVk
IHN0YWdlIHRyYW5zbGF0aW9uIHNjaGVtZSBhbmQgd2FudHMgb3RoZXIgc3ViLXN5c3RlbQ0KPj4g
bGlrZSBWRklPJ3MgY29vcGVyYXRpb24gdG8gY3JlYXRlIG5lc3RpbmcgcGFyZW50IEhXUFQuDQo+
Pg0KPj4gcGNpX2RldmljZV9nZXRfdmlvbW11X2ZsYWdzKCkgaXMgYSB3cmFwcGVyIHRoYXQgY2Fu
IGJlIGNhbGxlZCBvbiBhIFBDSQ0KPj4gZGV2aWNlIHBvdGVudGlhbGx5IHByb3RlY3RlZCBieSBh
IHZJT01NVS4NCj4+DQo+PiBnZXRfdmlvbW11X2ZsYWdzKCkgaXMgZGVzaWduZWQgdG8gcmV0dXJu
IDY0Yml0IGJpdG1hcCBvZiBwdXJlbHkgdklPTU1VDQo+PiBmbGFncyB3aGljaCBhcmUgb25seSBk
ZXRlcm1pbmVkIGJ5IHVzZXIncyBjb25maWd1cmF0aW9uLCBubyBob3N0DQo+PiBjYXBhYmlsaXRp
ZXMgaW52b2x2ZWQuIFJlYXNvbnMgYXJlOg0KPj4NCj4+IDEuIGhvc3QgbWF5IGhhcyBoZXRlcm9n
ZW5lb3VzIElPTU1VcywgZWFjaCB3aXRoIGRpZmZlcmVudCBjYXBhYmlsaXRpZXMNCj4+IDIuIHRo
aXMgaXMgbWlncmF0aW9uIGZyaWVuZGx5LCByZXR1cm4gdmFsdWUgaXMgY29uc2lzdGVudCBiZXR3
ZWVuIHNvdXJjZQ0KPj4gICAgIGFuZCB0YXJnZXQuDQo+Pg0KPj4gTm90ZSB0aGF0IHRoaXMgb3Ag
d2lsbCBiZSBpbnZva2VkIGF0IHRoZSBhdHRhY2hfZGV2aWNlKCkgc3RhZ2UsIGF0IHdoaWNoDQo+
PiBwb2ludCBob3N0IElPTU1VIGNhcGFiaWxpdGllcyBhcmUgbm90IHlldCBmb3J3YXJkZWQgdG8g
dGhlIHZJT01NVQ0KPnRocm91Z2gNCj4+IHRoZSBzZXRfaW9tbXVfZGV2aWNlKCkgY2FsbGJhY2sg
dGhhdCB3aWxsIGJlIGFmdGVyIHRoZSBhdHRhY2hfZGV2aWNlKCkuDQo+Pg0KPj4gU2VlIGJlbG93
IHNlcXVlbmNlOg0KPj4NCj4+ICAgIHZmaW9fZGV2aWNlX2F0dGFjaCgpOg0KPj4gICAgICAgIGlv
bW11ZmRfY2Rldl9hdHRhY2goKToNCj4+ICAgICAgICAgICAgcGNpX2RldmljZV9nZXRfdmlvbW11
X2ZsYWdzKCkgZm9yIEhXIG5lc3RpbmcgY2FwDQo+PiAgICAgICAgICAgIGNyZWF0ZSBhIG5lc3Rp
bmcgcGFyZW50IEhXUFQNCj4+ICAgICAgICAgICAgYXR0YWNoIGRldmljZSB0byB0aGUgSFdQVA0K
Pj4gICAgICAgICAgICB2ZmlvX2RldmljZV9oaW9kX2NyZWF0ZV9hbmRfcmVhbGl6ZSgpIGNyZWF0
aW5nIGhpb2QNCj4+ICAgIC4uLg0KPj4gICAgcGNpX2RldmljZV9zZXRfaW9tbXVfZGV2aWNlKGhp
b2QpDQo+Pg0KPj4gU3VnZ2VzdGVkLWJ5OiBZaSBMaXUgPHlpLmwubGl1QGludGVsLmNvbT4NCj4+
IFNpZ25lZC1vZmYtYnk6IFpoZW56aG9uZyBEdWFuIDx6aGVuemhvbmcuZHVhbkBpbnRlbC5jb20+
DQo+PiBSZXZpZXdlZC1ieTogTmljb2xpbiBDaGVuIDxuaWNvbGluY0BudmlkaWEuY29tPg0KPj4g
UmV2aWV3ZWQtYnk6IEVyaWMgQXVnZXIgPGVyaWMuYXVnZXJAcmVkaGF0LmNvbT4NCj4+IFJldmll
d2VkLWJ5OiBZaSBMaXUgPHlpLmwubGl1QGludGVsLmNvbT4NCj4+IFJldmlld2VkLWJ5OiBDw6lk
cmljIExlIEdvYXRlciA8Y2xnQHJlZGhhdC5jb20+DQo+PiAtLS0NCj4+ICAgTUFJTlRBSU5FUlMg
ICAgICAgICAgfCAgMSArDQo+PiAgIGluY2x1ZGUvaHcvaW9tbXUuaCAgIHwgMjUgKysrKysrKysr
KysrKysrKysrKysrKysrKw0KPg0KPkFsbCBoZWFkZXJzIHVuZGVyIGluY2x1ZGUvaHcvIGhhdmUg
YmVlbiBtb3ZlZCB0byBpbmNsdWRlL2h3L2NvcmUvLg0KPmlvbW11LmgNCj5zaG91bGQgYWxzbyBi
ZSBtb3ZlZCB1bmRlciB0aGUgc2FtZSBkaXJlY3RvcnkuDQo+DQo+VGhlIHNlcmllcyBuZWVkcyBh
IHJlc3BpbiBiZWNhdXNlIG9mIHRoZXNlIGNoYW5nZXMuDQoNClRoYW5rcyBmb3IgcmVtaW5kZXIs
IEkganVzdCBzZW50IHYxMCBvdXQgZm9yIGJlbG93IHR3byBzZXJpZXMuDQoNCltQQVRDSCB2OSAw
MC8xOV0gaW50ZWxfaW9tbXU6IEVuYWJsZSBmaXJzdCBzdGFnZSB0cmFuc2xhdGlvbiBmb3IgcGFz
c3Rocm91Z2ggZGV2aWNlDQpbUEFUQ0ggdjkgMC80XSBJbXBsZW1lbnQgRVJSQVRBXzc3MjQxNSBx
dWlyayBmb3IgVlREDQoNCkJScywNClpoZW56aG9uZw0K

