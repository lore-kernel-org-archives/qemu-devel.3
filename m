Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA45BCD5BAF
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2026 03:08:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQGEo-0002my-Vp; Thu, 21 May 2026 23:07:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1wQGEi-0002mc-Rk
 for qemu-devel@nongnu.org; Thu, 21 May 2026 23:07:47 -0400
Received: from mgamail.intel.com ([198.175.65.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1wQGEe-0000QB-Er
 for qemu-devel@nongnu.org; Thu, 21 May 2026 23:07:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1779419261; x=1810955261;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=7NYPWJ7WwY20OTV2I/2vxnz19XpaRJlRnr12u9qH658=;
 b=fYmgkNS4BOSR+CC9c/xNMxTp+dUKag5PCLSoD4clMGjh4crAJAK7il6E
 cnSK3VYNXwQM5LbKVip0ocwxEop8lZvDXWs0o/jnau/My58RKy8AXzAFl
 6nzrjtjrh+qw8kVLuGUCeEYoZoHyET/EiO51Vif91mrWhqGBA6LcHxvVx
 K772gM6+rwPjzPA4jZ9mP+G05aKC0zc8q52lCwPDO0Yfj+F48RgvCaK95
 OZufsd/VFtJXP3MGXKN8fj6XL5lDS/Ksg+OyRXU2/W3yEUUE85CKO41DV
 u6rk76+ny8MjicaGvhiYZYgHyEQ/CC92P/qTvPA5f1iOkqOLNQLNePYZk A==;
X-CSE-ConnectionGUID: vGPd7vKdSiCeobJJ0Yhg8w==
X-CSE-MsgGUID: L2Q2UGLtTr2GYtUK1IS6Hg==
X-IronPort-AV: E=McAfee;i="6800,10657,11793"; a="80402704"
X-IronPort-AV: E=Sophos;i="6.24,161,1774335600"; d="scan'208";a="80402704"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 May 2026 20:07:30 -0700
X-CSE-ConnectionGUID: SYaDd6n2QKisSmBiqW5PiA==
X-CSE-MsgGUID: nNxF5thgTVG4ekUD8igNrQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,161,1774335600"; d="scan'208";a="239907208"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 May 2026 20:07:30 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 21 May 2026 20:07:29 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 21 May 2026 20:07:29 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.4) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 21 May 2026 20:07:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a7smU9OUHKtpcidtyFylmrSv6gnQy348CrCDqYhAQ4mabJyUoZzTG++0M3ieUKsnoujfEDPKicFLXNGGNeuACWTu+kpQSL+yFSPxgKQ6vyYoed8e/NrfAz32rmN8IX34kJh462Lo7hogMFgsZBxnJK1hst1In87zS5tpFmpKZN27V4mk8Zi1xo5ghVVGpCuxAGUW9CqnwvJrXf8hZaaFiVEGY5c8QPp8K/3UXW7CRCT5vcyIy7zI4FcE5kYsTl0DheDn5gI8dJw+uxdBGzBpDxGOL+nAKeZNIGGwym75Ry8WlBdTXnUnNB/fVdvRfgyL/6/YthmXnnOuPe4YNAHkDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7NYPWJ7WwY20OTV2I/2vxnz19XpaRJlRnr12u9qH658=;
 b=becr21dqHm/kmb8RGMlOrecYcgWIn2AiA1ZadbWlZo79h5auMB5Kqso3Yl0znaDOhWxifKW5FuaKRRzEYxJSryYfqiCvgQElSlUe7CwaKkjqBm3EC4h9Dr9qjuvj8TQVVykl3BS9DbfBKA8SnnPtT73X2NXA1S6a9Rw4wXCNh3dIvHChRes4N8Iy5F7P9GMy3N8rY8fh2P2FhUnAvaAsGTw6IF/PaIzO7Hj4RWUwtK5mLyRHG3Neyrb8GZk/APASqf3itFlYXQhgPkOhFBZzZn5EZJsXDj3JcotTfSu5fYK+/J8w+yFflMTbcr7Pdve+VG7fMBe2weV+5As0C5YUvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12)
 by CY5PR11MB6464.namprd11.prod.outlook.com (2603:10b6:930:30::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.17; Fri, 22 May
 2026 03:07:18 +0000
Received: from IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::37b4:37a9:4f3:518b]) by IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::37b4:37a9:4f3:518b%5]) with mapi id 15.20.9913.009; Fri, 22 May 2026
 03:07:18 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: "Liu, Yi L" <yi.l.liu@intel.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "alex@shazbot.org" <alex@shazbot.org>, "clg@redhat.com" <clg@redhat.com>, 
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "mst@redhat.com"
 <mst@redhat.com>, "jasowang@redhat.com" <jasowang@redhat.com>,
 "jgg@nvidia.com" <jgg@nvidia.com>, "nicolinc@nvidia.com"
 <nicolinc@nvidia.com>, "skolothumtho@nvidia.com" <skolothumtho@nvidia.com>,
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>,
 "clement.mathieu--drif@bull.com" <clement.mathieu--drif@bull.com>, "Tian,
 Kevin" <kevin.tian@intel.com>, "Hao, Xudong" <xudong.hao@intel.com>
Subject: RE: [PATCH v5 10/15] intel_iommu_accel: Handle PASID entry removal
 for pc_inv_dsc request
Thread-Topic: [PATCH v5 10/15] intel_iommu_accel: Handle PASID entry removal
 for pc_inv_dsc request
Thread-Index: AQHc32mg4oXI8zixW0uZHfCp60fO67YNafCAgAwEaZA=
Date: Fri, 22 May 2026 03:07:18 +0000
Message-ID: <IA3PR11MB91369A610C7F2DDEC9F2D5BD920F2@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <20260509040819.1044702-1-zhenzhong.duan@intel.com>
 <20260509040819.1044702-11-zhenzhong.duan@intel.com>
 <829fcf6f-39e4-4d21-9f08-2772c0813c32@intel.com>
In-Reply-To: <829fcf6f-39e4-4d21-9f08-2772c0813c32@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9136:EE_|CY5PR11MB6464:EE_
x-ms-office365-filtering-correlation-id: dd3eebe8-8091-47b1-3050-08deb7af3bfa
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|7416014|376014|22082099003|56012099003|18002099003|3613699012|38070700021|4143699003|11063799006;
x-microsoft-antispam-message-info: djv2/FR1aEt0otHctL/hNnqaa/ivJ0za2egxkj7FYniYYLFNKZW3p3Dacvaidk7fsm/XAMIcYadPnB6xXqxF7VARd3Y6V/h8lguM68rexsVbItdmGrF65KYFwkfrvBqDx/kCELC5TTT1seXTVyuJm9F/v61iAvn5EvMEiNuOK7/GzeaB8yJH144TwjxDW4NSY5QHG7D9p1c6j+VbhgPAtQKaI2rpXxR3S3MvmVebH/u58yzHyqAj1wm4lif8vCHFOairqqP+olEvZlAdEW/Y5NznpEcgE9ax9dIfxly+9MWZqkEbaTuLLuJnAEDCrAq+Wyw1a60NBKzerVegt2dSNjgy6uWA6UMd4dL6LadAS5KTOvnT2sHTsrIQVFCRyaUCAsbiXGsO0Kb4qEYVIVicLlzxLhyScmnU9ecmLNH+cAM1t+gvEjeFA5xLQBQMT0QK32o6kWo1G5+Jtn2ihm6A1Ghjhn2TE0snuoC9uaZBaxHAEtyZ6xcoUSyNabqxyOVV9fF2e12WfC2MSFZTZL5AiuCTAessnGWUMAqbwcd7/RniFsxhOcDOge68yh1cNi/83E7iJgOlqKSdAmcs6Vb2vU0c8YZ8bre8MCuI8CDc608q7RuoEh8d+bl4qF+33xD6q+2xMw67Mmt007t0piRqR+8QL10HzDe+/tDsboPmmGYyhmGZST8zjfiHzzJdvw00W/9VvFUell2rwuhtJYXiotfGfH09zzNw5wXsAajtRako9ADFCLaJr8ldVWLi6GGarxiKVI1AjK1+pO1tkc5QWw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9136.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(376014)(22082099003)(56012099003)(18002099003)(3613699012)(38070700021)(4143699003)(11063799006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?L0d1VGMxMW42cXEwbU5xT25za0ZwL0JSalhwUEhnZ2xwQVQ1SnNrZWFUK2lJ?=
 =?utf-8?B?VVJCR085LzNXSUhhYVJ5ZkEvU001QThxMnNlbTdkZ2RBcjhxYTV6allJT25t?=
 =?utf-8?B?UWcwdC9QcFB4UldXWnlqVlgvQzFqaTl3MVkxc3JWVWtBZjdzeVQ4THNNL3hD?=
 =?utf-8?B?WU41cWg4YXZyVEsyQnI3d3dxWFhqQkJaVWQzODFLeTkrUGZrMkY5cXl5a09i?=
 =?utf-8?B?amFMZTFkYjd0QU1ra0EvY25RSkNDUkhacGN0Wk9RNS9ZMFREQUlyYXZjQUg5?=
 =?utf-8?B?eGptQ1JmSXFjU3E1MVpLbnZzeGd0UXhnSzFCeUs2NGRzd09zd3VXSmsrenQ1?=
 =?utf-8?B?Q1lZS1hZY29DRFpFSWZSV1krQ2JhdjhLaCtjUGRNR3lxQmdzakcyTEIxQ0dE?=
 =?utf-8?B?QjBwLzc5aVRnS1BWOGlndlZUclMyd0h3MTZoZm1nbnl5dGRGYm5DL0hheUUr?=
 =?utf-8?B?aHUxd2tSM2RRQWVsc2FKc2FhRHo5NVdka3QxTUJqLy84YkQzWU1jRkRlWlNF?=
 =?utf-8?B?VEdrOWxBMWtUcFEwZS8zZmtRNWZDVll2Rjc5RkZ4bXlJdzRIMXFtaENHY3c1?=
 =?utf-8?B?bklmL0FraFdpT1JLT1ZZQkhJY1I5SDNmYWFvdkxHekVsQStWNDNncVcrczUx?=
 =?utf-8?B?YnE2dVhFaHIwTkNWNDBxT0xqNWQ0a0NvS3d0QTFrM1JuRDh6MC9pSENOd0R0?=
 =?utf-8?B?WVNIaGVMUjBjamRCSzZWdVBpbk1CTHM1dDVscG5iZ3RhNWw4Q214UW5RNmd3?=
 =?utf-8?B?a0RZN3ROVzI2RDdtd05Db0Q5aHlmNThuc1o3dmJxc2QzczFCbDZxNEtYeGcw?=
 =?utf-8?B?K0V0ZVFHTzVwNzJ5QWxpb2dCUUlJWXJrQlFESVZhbDFHa1hadW0rS28rSEtv?=
 =?utf-8?B?ai9qT3B6VEZ3WGd5TFFveWMveU9EMzQydkpYOXNUcVJ0Mjl6ZStybXdnNzUx?=
 =?utf-8?B?RFpwbXJxUlhEeFZPRVJXSHYzelpRL0tHd2NDVmpxMWVqV0wxc3MxMnJELzha?=
 =?utf-8?B?d2dpWU5OaXgzSmI1QUFpY1IwVDllRCtsVFNka3ZBa2xYOEU3Y3NQeVVVaXlu?=
 =?utf-8?B?Z3dvaE92S0dhK1hDT1RkWnlJNXNadldHMW5DckRCWjllckRrVS9OYWRCUm8x?=
 =?utf-8?B?NmNXU2ZIUlAwMGNqbk5NLzlVcFBKOEtWMmdydHlvR0VoUTdKeC9PLzU1WE9Y?=
 =?utf-8?B?Tm5reWo5KzBSWGtUZ3Fwb2ZTL1FhbXMxYTBZNm1kR1JiVTY4MHp1eEZYb0pY?=
 =?utf-8?B?NjRpaDlsNUowZEFhR3pxZHVwVituU0dYQWN0U01wWXZsZVVRSFhwQ1BWdkM0?=
 =?utf-8?B?bDJSankxYXMrV0pqckNQZzIycWVjWlIyR2dDbzZKUENDbkZVV0ZrdGczVWFG?=
 =?utf-8?B?TlpYaEd6WXUzbVUzSW80MXViRG9mbjN1SzhWSjlQcDROb3lJUUx4Y1RZQXBC?=
 =?utf-8?B?elY1OTBlaFNpVFEwOEMrbzVTZTZPckRhRytpUHBmY28rc0VtUEFTeEVtZkRs?=
 =?utf-8?B?V1NrMXJHV1ZKNGdMVFdRY2RHQzFLMDU5cHp4OE5ZY3YzVkI0ck1SWmRDRTI0?=
 =?utf-8?B?SzJxeUE3NGNnMTZ4UmI4eUwvTnlub051UzhHbU83RVJlZVlONFA1UndFRDM4?=
 =?utf-8?B?OFBwbG5hYzR4QTBpNkIyMG9GdXJYUkt6Nm1rZFBGUmZKMGpOZEZPakZmeHJE?=
 =?utf-8?B?ZEdZdDNMTThNcnFtaEtzUUhlaGtlcWw5bVNDMFZaWDJqZGxEb1RXK2dCMmZV?=
 =?utf-8?B?ZisrWWhxRmJtSVNra3ZqdTZKTThJRHBIUHRHNTd6blFTNFUzL09rajFENmE3?=
 =?utf-8?B?M2tnZDlCY3JiQk9IczJiRlYrTDYvRzRiOExHNEI0bE9QSEs2RUdOUW0wRWpM?=
 =?utf-8?B?L3NIYmVGQXIzVC83TEg1TWJ6dmdHK3Q3Tnl0djAzd0lvRmROdER4TGJEWExo?=
 =?utf-8?B?Y0VTZS91R1Y4RzFhY0d5OHB0b0Q2TTdqb2pYMHNJR1Eya1hhbHlKZkdtOThh?=
 =?utf-8?B?RzBvU1NyRm1adEYyS3I1dDBvY3hvckdJTlBLcHpRVDFXbGR5MFZoU3VMekVH?=
 =?utf-8?B?ajFOQzNGYXEwQ3RVTEdpTkwrc3BTSlpPS2xiUllDYXFUekhCNGJ5OE5HVW5l?=
 =?utf-8?B?M2p5UWxvaUw4TXd3aGVQY0EyOE9xandWdDc1THkyZW5IU1o0cyt1MTRLcExu?=
 =?utf-8?B?aVh6UCt5bFE5bm12ZFpVbEJyOTJxNU1ObW9qcHZROVB5MUxYblNPa3NYbE8y?=
 =?utf-8?B?SGR6YURjR3FRbjUyeDk4M2FJb2NhWUZHN3NBWUVKLzRFSWdwd3NJZmJhb3BW?=
 =?utf-8?B?R0o1eHZlcUtiNXJ2WFR1aHd0c3hUWUJPb0Y4ekpqK1IvdW92b1Z1Zz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: B2vvpxvecU3AlWG7k5uEoOv8XTqx9q+NTamcRqSNFugOJgkC2tkT1x5iO0lRRNOZfpg2/NrsjvoqoZdqaOP83rPvQ+DtMKuNRJE4RZfP9tIWyuchm9e2v54EK0veBi8U+1HZ06MDSXogGk19f8XVFli8orLXHR+GZwcTsFRqz8bFZf3VFdoaIbZFkSX8y9ib07hBEYGH80LjzesgaB7vtigf8uuDUwUK5KOJqA8SQrwdTwyxUFfS3Df7EiiluYPqk3XvdT+kmpIcg/Ue7etuhrGgMtLXeO/u2/SovRI5rkwpWWHkbHKgdDbu/22PPSIx9tUmNc1Q6UpYmD/UoZaOJA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9136.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd3eebe8-8091-47b1-3050-08deb7af3bfa
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 May 2026 03:07:18.6366 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MkdqmuYuAiepw8a7mlSZDyToOcmFZE7O/8CW4QXENUqlXy41sFV4YaSry1TViFLByGKf5UUAJ7dM9Akrxopx3dBJlXCU/U07jFUismkZagg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6464
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.18;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IExpdSwgWWkgTCA8eWkubC5s
aXVAaW50ZWwuY29tPg0KPlN1YmplY3Q6IFJlOiBbUEFUQ0ggdjUgMTAvMTVdIGludGVsX2lvbW11
X2FjY2VsOiBIYW5kbGUgUEFTSUQgZW50cnkgcmVtb3ZhbCBmb3INCj5wY19pbnZfZHNjIHJlcXVl
c3QNCj4NCj5PbiA1LzkvMjYgMTI6MDgsIFpoZW56aG9uZyBEdWFuIHdyb3RlOg0KPj4gV2hlbiBn
dWVzdCBkZWxldGVzIFBBU0lEIGVudHJpZXMsIFFFTVUgd2lsbCBjYXB0dXJlIHRoZSBwYXNpZCBj
YWNoZQ0KPj4gaW52YWxpZGF0aW9uIHJlcXVlc3QsIHdhbGsgdGhyb3VnaCBwYXNpZF9jYWNoZV9s
aXN0IGluIGVhY2ggcGFzc3Rocm91Z2gNCj4+IGRldmljZSB0byBmaW5kIHN0YWxlIFZUREFjY2Vs
UEFTSURDYWNoZUVudHJ5IGFuZCBkZWxldGUgdGhlbS4NCj4+DQo+PiBDby1kZXZlbG9wZWQtYnk6
IFlpIExpdSA8eWkubC5saXVAaW50ZWwuY29tPg0KPj4gU2lnbmVkLW9mZi1ieTogWWkgTGl1IDx5
aS5sLmxpdUBpbnRlbC5jb20+DQo+PiBTaWduZWQtb2ZmLWJ5OiBaaGVuemhvbmcgRHVhbiA8emhl
bnpob25nLmR1YW5AaW50ZWwuY29tPg0KPj4gVGVzdGVkLWJ5OiBYdWRvbmcgSGFvIDx4dWRvbmcu
aGFvQGludGVsLmNvbT4NCj4+IC0tLQ0KPj4gICBody9pMzg2L2ludGVsX2lvbW11X2FjY2VsLmMg
fCA4MA0KPisrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysNCj4+ICAgMSBmaWxl
IGNoYW5nZWQsIDgwIGluc2VydGlvbnMoKykNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvaHcvaTM4Ni9p
bnRlbF9pb21tdV9hY2NlbC5jIGIvaHcvaTM4Ni9pbnRlbF9pb21tdV9hY2NlbC5jDQo+PiBpbmRl
eCBhNjZkNjNiNGM4Li44MmJmYmRmNDg0IDEwMDY0NA0KPj4gLS0tIGEvaHcvaTM4Ni9pbnRlbF9p
b21tdV9hY2NlbC5jDQo+PiArKysgYi9ody9pMzg2L2ludGVsX2lvbW11X2FjY2VsLmMNCj4+IEBA
IC0xNiw2ICsxNiwyOCBAQA0KPj4gICAjaW5jbHVkZSAiaHcvcGNpL3BjaV9idXMuaCINCj4+ICAg
I2luY2x1ZGUgInRyYWNlLmgiDQo+Pg0KPj4gK3N0YXRpYyBpbnQgdnRkX2hpb2RfZ2V0X3BlX2Zy
b21fcGFzaWQoVlREQWNjZWxQQVNJRENhY2hlRW50cnkgKnZ0ZF9wY2UsDQo+DQo+dGhpcyBoZWxw
ZXIgaXMgdHJpY2t5LiB2dGRfcGNlIGFscmVhZHkgaGFzIGEgcGUgY2FjaGVkLCB0aGVuIHdoeSBu
ZWVkDQo+dG8gZG8gdGhpcz8NCg0KSXQncyB1c2VkIG9uIHBjX2ludl9kc2MgaGFuZGxlciBwYXRo
LCB2dGRfcGNlIGNhY2hlcyBvbGQgcGUsIHdlIG5lZWQgdG8gZ2V0IHJlZnJlc2hlZCBvbmUgaW4g
bWVtb3J5Lg0KDQo+IEkgdGhpbmsgaXQncyBiZXR0ZXIgdG8gaGF2ZSBhIGhlbHBlciByZWNlaXZl
cyBzLCBkZXZmbiwgYW5kDQo+cGFzaWQgaW5zdGVhZCBvZiBhY2NlcHRpbmcgdnRkX3BjZS4gYnR3
LiBJIHRoaW5rIHRoZSBpbnRlbF9pb21tdS5jDQo+c2hvdWxkIGhhdmUgc3VjaCBhIGhlbHBlci4g
aXMgaXQ/DQoNCkluIGludGVsX2lvbW11LmMsIHRoZXJlIGlzIGEgaGVscGVyIGZvciB2dGRfYXM6
DQoNCnN0YXRpYyBpbmxpbmUgaW50IHZ0ZF9kZXZfZ2V0X3BlX2Zyb21fcGFzaWQoVlREQWRkcmVz
c1NwYWNlICp2dGRfYXMsDQogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIFZURFBBU0lERW50cnkgKnBlKQ0KDQpzbyBpbiBpbnRlbF9pb21tdV9hY2NlbC5jLCB2dGRf
aGlvZF9nZXRfcGVfZnJvbV9wYXNpZCgpIGlzIGFkZGVkIGZvciB2dGRfcGNlLg0KDQpUaGFua3MN
ClpoZW56aG9uZw0KDQo+DQo+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICBWVERQQVNJREVudHJ5ICpwZSkNCj4+ICt7DQo+PiArICAgIFZUREhvc3RJT01NVURldmljZSAq
dnRkX2hpb2QgPSB2dGRfcGNlLT52dGRfaGlvZDsNCj4+ICsgICAgSW50ZWxJT01NVVN0YXRlICpz
ID0gdnRkX2hpb2QtPmlvbW11X3N0YXRlOw0KPj4gKyAgICB1aW50MzJfdCBwYXNpZCA9IHZ0ZF9w
Y2UtPnBhc2lkOw0KPj4gKyAgICBWVERDb250ZXh0RW50cnkgY2U7DQo+PiArICAgIGludCByZXQ7
DQo+PiArDQo+PiArICAgIGlmICghcy0+ZG1hcl9lbmFibGVkIHx8ICFzLT5yb290X3NjYWxhYmxl
KSB7DQo+PiArICAgICAgICByZXR1cm4gLVZURF9GUl9SVEFERFJfSU5WX1RUTTsNCj4+ICsgICAg
fQ0KPj4gKw0KPj4gKyAgICByZXQgPSB2dGRfZGV2X3RvX2NvbnRleHRfZW50cnkocywgcGNpX2J1
c19udW0odnRkX2hpb2QtPmJ1cyksDQo+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICB2dGRfaGlvZC0+ZGV2Zm4sICZjZSk7DQo+PiArICAgIGlmIChyZXQpIHsNCj4+ICsgICAg
ICAgIHJldHVybiByZXQ7DQo+PiArICAgIH0NCj4+ICsNCj4+ICsgICAgcmV0dXJuIHZ0ZF9jZV9n
ZXRfcGFzaWRfZW50cnkocywgJmNlLCBwZSwgcGFzaWQpOw0KPj4gK30NCj4+ICsNCj4+ICAgYm9v
bCB2dGRfY2hlY2tfaGlvZF9hY2NlbChJbnRlbElPTU1VU3RhdGUgKnMsIFZUREhvc3RJT01NVURl
dmljZQ0KPip2dGRfaGlvZCwNCj4+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICBFcnJvciAq
KmVycnApDQo+PiAgIHsNCj4+IEBAIC0yODAsNiArMzAyLDU3IEBAIHN0YXRpYyB2b2lkIHZ0ZF9h
Y2NlbF9maWxsX3BjKFZUREhvc3RJT01NVURldmljZQ0KPip2dGRfaGlvZCwgdWludDMyX3QgcGFz
aWQsDQo+PiAgICAgICBRTElTVF9JTlNFUlRfSEVBRCgmdnRkX2hpb2QtPnBhc2lkX2NhY2hlX2xp
c3QsIHZ0ZF9wY2UsIG5leHQpOw0KPj4gICB9DQo+Pg0KPj4gK3N0YXRpYyB2b2lkIHZ0ZF9hY2Nl
bF9kZWxldGVfcGMoVlREQWNjZWxQQVNJRENhY2hlRW50cnkgKnZ0ZF9wY2UpDQo+PiArew0KPj4g
KyAgICBRTElTVF9SRU1PVkUodnRkX3BjZSwgbmV4dCk7DQo+PiArICAgIGdfZnJlZSh2dGRfcGNl
KTsNCj4+ICt9DQo+PiArDQo+PiArc3RhdGljIHZvaWQNCj4+ICt2dGRfYWNjZWxfcGFzaWRfY2Fj
aGVfaW52YWxpZGF0ZV9vbmUoVlREQWNjZWxQQVNJRENhY2hlRW50cnkgKnZ0ZF9wY2UsDQo+PiAr
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFZURFBBU0lEQ2FjaGVJbmZvICpw
Y19pbmZvKQ0KPj4gK3sNCj4+ICsgICAgVlREUEFTSURFbnRyeSBwZTsNCj4+ICsgICAgdWludDE2
X3QgZGlkOw0KPj4gKw0KPj4gKyAgICAvKg0KPj4gKyAgICAgKiBWVERfSU5WX0RFU0NfUEFTSURD
X0dfRFNJIGFuZCBWVERfSU5WX0RFU0NfUEFTSURDX0dfUEFTSURfU0kNCj5yZXF1aXJlDQo+PiAr
ICAgICAqIERJRCBjaGVjay4gSWYgRElEIGRvZXNuJ3QgbWF0Y2ggdGhlIHZhbHVlIGluIGNhY2hl
IG9yIG1lbW9yeSwgdGhlbg0KPj4gKyAgICAgKiBpdCdzIG5vdCBhIHBhc2lkIGVudHJ5IHdlIHdh
bnQgdG8gaW52YWxpZGF0ZS4NCj4+ICsgICAgICovDQo+PiArICAgIHN3aXRjaCAocGNfaW5mby0+
dHlwZSkgew0KPj4gKyAgICBjYXNlIFZURF9JTlZfREVTQ19QQVNJRENfR19QQVNJRF9TSToNCj4+
ICsgICAgICAgIGlmIChwY19pbmZvLT5wYXNpZCAhPSB2dGRfcGNlLT5wYXNpZCkgew0KPj4gKyAg
ICAgICAgICAgIHJldHVybjsNCj4+ICsgICAgICAgIH0NCj4+ICsgICAgICAgIC8qIEZhbGwgdGhy
b3VnaCAqLw0KPj4gKyAgICBjYXNlIFZURF9JTlZfREVTQ19QQVNJRENfR19EU0k6DQo+PiArICAg
ICAgICBkaWQgPSBWVERfU01fUEFTSURfRU5UUllfRElEKCZ2dGRfcGNlLT5wYXNpZF9lbnRyeSk7
DQo+PiArICAgICAgICBpZiAocGNfaW5mby0+ZGlkICE9IGRpZCkgew0KPj4gKyAgICAgICAgICAg
IHJldHVybjsNCj4+ICsgICAgICAgIH0NCj4+ICsgICAgfQ0KPj4gKw0KPj4gKyAgICBpZiAodnRk
X2hpb2RfZ2V0X3BlX2Zyb21fcGFzaWQodnRkX3BjZSwgJnBlKSkgew0KPj4gKyAgICAgICAgLyoN
Cj4+ICsgICAgICAgICAqIE5vIHZhbGlkIHBhc2lkIGVudHJ5IGluIGd1ZXN0IG1lbW9yeS4gZS5n
LiBwYXNpZCBlbnRyeSB3YXMgbW9kaWZpZWQNCj4+ICsgICAgICAgICAqIHRvIGJlIGVpdGhlciBh
bGwtemVybyBvciBub24tcHJlc2VudC4gRWl0aGVyIGNhc2UgbWVhbnMgZXhpc3RpbmcNCj4+ICsg
ICAgICAgICAqIHBhc2lkIGNhY2hlIHNob3VsZCBiZSBpbnZhbGlkYXRlZC4NCj4+ICsgICAgICAg
ICAqLw0KPj4gKyAgICAgICAgdnRkX2FjY2VsX2RlbGV0ZV9wYyh2dGRfcGNlKTsNCj4+ICsgICAg
fQ0KPj4gK30NCj4+ICsNCj4+ICtzdGF0aWMgdm9pZCB2dGRfYWNjZWxfcGFzaWRfY2FjaGVfaW52
YWxpZGF0ZShWVERIb3N0SU9NTVVEZXZpY2UNCj4qdnRkX2hpb2QsDQo+PiArICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgVlREUEFTSURDYWNoZUluZm8gKnBjX2lu
Zm8pDQo+PiArew0KPj4gKyAgICBWVERBY2NlbFBBU0lEQ2FjaGVFbnRyeSAqdnRkX3BjZSwgKm5l
eHQ7DQo+PiArDQo+PiArICAgIFFMSVNUX0ZPUkVBQ0hfU0FGRSh2dGRfcGNlLCAmdnRkX2hpb2Qt
PnBhc2lkX2NhY2hlX2xpc3QsIG5leHQsIG5leHQpIHsNCj4+ICsgICAgICAgIHZ0ZF9hY2NlbF9w
YXNpZF9jYWNoZV9pbnZhbGlkYXRlX29uZSh2dGRfcGNlLCBwY19pbmZvKTsNCj4+ICsgICAgfQ0K
Pj4gK30NCj4+ICsNCj4+ICAgLyoNCj4+ICAgICogVGhpcyBmdW5jdGlvbiB3YWxrcyBvdmVyIFBB
U0lEIHJhbmdlIHdpdGhpbiBbc3RhcnQsIGVuZCkgaW4gYSBzaW5nbGUNCj4+ICAgICogUEFTSUQg
dGFibGUgZm9yIGVudHJpZXMgbWF0Y2hpbmcgQGluZm8gdHlwZS9kaWQsIHRoZW4gY3JlYXRlDQo+
PiBAQCAtNDExLDYgKzQ4NCwxMyBAQCB2b2lkIHZ0ZF9hY2NlbF9wYXNpZF9jYWNoZV9zeW5jKElu
dGVsSU9NTVVTdGF0ZQ0KPipzLCBWVERQQVNJRENhY2hlSW5mbyAqcGNfaW5mbykNCj4+ICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgVFlQRV9IT1NUX0lPTU1VX0RFVklDRV9JT01N
VUZEKSkgew0KPj4gICAgICAgICAgICAgICBjb250aW51ZTsNCj4+ICAgICAgICAgICB9DQo+PiAr
DQo+PiArICAgICAgICAvKg0KPj4gKyAgICAgICAgICogUEFTSUQgZW50cnkgcmVtb3ZhbCBpcyBo
YW5kbGVkIGJlZm9yZSBhZGRpdGlvbiBpbnRlbnRpb25hbGx5LA0KPj4gKyAgICAgICAgICogYmVj
YXVzZSBpdCdzIHVubmVjZXNzYXJ5IHRvIGl0ZXJhdGUgb24gYW4gZW50cnkgdGhhdCB3aWxsIGJl
DQo+PiArICAgICAgICAgKiByZW1vdmVkLg0KPg0KPmhvdyBhYm91dCBiZWxvdz8gOikNCj4NCj4v
Kg0KPiAgKiBUaGUgcmVwbGF5IHBhdGggaW5ldml0YWJseSBuZWVkcyB0byBpdGVyYXRlIHRocm91
Z2ggZXhpc3RpbmcNCj4gICogUEFTSUQgY2FjaGUgZW50cmllcy4gU2luY2UgY2FjaGVkIFBBU0lE
IGVudHJpZXMgdGhhdCBhcmUgbWFya2VkDQo+ICAqIGZvciByZW1vdmFsIGRvbid0IG5lZWQgdG8g
YmUgaXRlcmF0ZWQsIHdlIGludGVudGlvbmFsbHkgaGFuZGxlDQo+ICAqIHJlbW92YWxzIGJlZm9y
ZSBhZGRpdGlvbnMgdG8gb3B0aW1pemUgdGhlIHJlcGxheSBwcm9jZXNzLg0KPiAgKi8NCj4NCj4N
Cj4+ICsgICAgICAgICAqLw0KPj4gKyAgICAgICAgdnRkX2FjY2VsX3Bhc2lkX2NhY2hlX2ludmFs
aWRhdGUodnRkX2hpb2QsIHBjX2luZm8pOw0KPj4gICAgICAgICAgIHZ0ZF9hY2NlbF9yZXBsYXlf
cGFzaWRfYmluZF9mb3JfZGV2KHZ0ZF9oaW9kLCBzdGFydCwgZW5kLCBwY19pbmZvKTsNCj4+ICAg
ICAgIH0NCj4+ICAgfQ0KDQo=

