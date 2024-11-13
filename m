Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10CBFD41C17
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2024 08:51:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tB95e-0003Mk-Ki; Wed, 13 Nov 2024 03:51:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1tB95b-0003M2-Fb
 for qemu-devel@nongnu.org; Wed, 13 Nov 2024 03:51:03 -0500
Received: from mgamail.intel.com ([198.175.65.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1tB95Z-0007jd-Fk
 for qemu-devel@nongnu.org; Wed, 13 Nov 2024 03:51:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1731487862; x=1763023862;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=YoC3zLcjVFAEQ9ESiBDOXlTZ4sAVsaHw7E8jSJoov2I=;
 b=Bvqo67w9HSiHTxphudKG7Px/BF0EdeNerRSFfD5g2kldEe7sq5Ij92rl
 HYRffBSO/kLZNjwDveoj/BwZlezGubrAHSC6Ij9K4Pnh8WmmtZrq66rm6
 d62G6KIy7yGseWZ+rFZYhNLpujLEhkUWjMJT64T8Tevxa3UAxA62OwQ65
 rLJz6FsyXg0EV0YcRqbWd0q30IyO2fV0oM5aDqNKgEWYqX4bOtE0o/Lpq
 9YCoI3BXrGdVqAg3vFCzAmPBZdHMSCLutUB0A3mYP7aWjuE8QsldL2zFt
 QoJI7qEPg4QRo9txjoZJ4xkywwISZ0zVfBrJM7a2618sQi8nt3kiAXOaD Q==;
X-CSE-ConnectionGUID: eBmhxlRmRFOPszBDbLPG2Q==
X-CSE-MsgGUID: eKuKZlmwQ8WnS80gi3M7GQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="31223488"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; d="scan'208";a="31223488"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Nov 2024 00:50:58 -0800
X-CSE-ConnectionGUID: MNsZS9TgS/qTdn65UQikVQ==
X-CSE-MsgGUID: XKl8nPiDQVeBJx+/M9fFCQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,150,1728975600"; d="scan'208";a="125326960"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
 by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 13 Nov 2024 00:50:58 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 13 Nov 2024 00:50:57 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 13 Nov 2024 00:50:57 -0800
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.47) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 13 Nov 2024 00:50:57 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VM3i8p5/N/5o4uunTLU/LnbrynUAwpJ4BmBIikZomuGuxU63WR6OXDyM6eECJhSiAqEi4SwYGcqm4UAhI3O1dpl8KpPEL28U6xR0jul/AMrl19c8rj91BxRpdX3v9PfGqiI4SwADZ5y0earEW4iNWk2TDMhVYJRbNLy+Xp7aRGyRoxOkF28NvuSlHyXDHwspARgcZkYphZ5NmIeZtVcMjzn/y18wos+5u8vaHFLpy7NEfg/bgirwPPmwkrvNinpoximOipu6oVrgBvJP+rzQxJK/nPjKqdZeJcRVjDD+/ZlLmC0EP3XmMoCZ6PfhrJjiNbGDyWC+9Jj0ai50IZQAgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YoC3zLcjVFAEQ9ESiBDOXlTZ4sAVsaHw7E8jSJoov2I=;
 b=haEQ8yfUl/LOnVg/ZjQTzG2AyT0zt11QClExWpZxQifyt9Q6hJipzQPgfvzbwrRPeNOyGqavuJEdpAy4DVBEFXgc5st9UhbKUuAiJGIu4H+nO5HbzRvMbcCHhzEGZgOrGBQwL33x0kOAjZOmoLB755lf01Os5ZpXIk6fFn5kNc8eXrbA3k5R1bbunzhnUZe+qcVRXWh38rX5UbjfOS93CZoPuelwOT9l9GS27EYBoXG5B4azxwfA2+RzvYnofanO+1K37euoIf5MzfnGyKigH/rMVsOUF9rqOwII+1QtVGACWNeXOhvNCmFeAYZoF8o9UgPjEdDO0PHYqNjlMk0Q9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by CY8PR11MB7193.namprd11.prod.outlook.com (2603:10b6:930:91::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.28; Wed, 13 Nov
 2024 08:50:55 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091%5]) with mapi id 15.20.8137.027; Wed, 13 Nov 2024
 08:50:55 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>, "eric.auger@redhat.com"
 <eric.auger@redhat.com>, "mst@redhat.com" <mst@redhat.com>,
 "peterx@redhat.com" <peterx@redhat.com>, "jasowang@redhat.com"
 <jasowang@redhat.com>, "jgg@nvidia.com" <jgg@nvidia.com>,
 "nicolinc@nvidia.com" <nicolinc@nvidia.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "Tian, Kevin" <kevin.tian@intel.com>, "Liu, Yi
 L" <yi.l.liu@intel.com>, "Peng, Chao P" <chao.p.peng@intel.com>, "Igor
 Mammedov" <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>
Subject: RE: [PATCH v5 17/20] tests/acpi: q35: Update host address width in
 DMAR
Thread-Topic: [PATCH v5 17/20] tests/acpi: q35: Update host address width in
 DMAR
Thread-Index: AQHbNBU8PM1O9QT8N0mXky2Jz89bE7K0z9+AgAAZ8+A=
Date: Wed, 13 Nov 2024 08:50:55 +0000
Message-ID: <SJ0PR11MB6744FA6A68F59165C04A8953925A2@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20241111083457.2090664-1-zhenzhong.duan@intel.com>
 <20241111083457.2090664-18-zhenzhong.duan@intel.com>
 <5a65512a-ec4e-4de3-84c9-253a9b7dcba0@eviden.com>
In-Reply-To: <5a65512a-ec4e-4de3-84c9-253a9b7dcba0@eviden.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|CY8PR11MB7193:EE_
x-ms-office365-filtering-correlation-id: b0e1a2e2-d7c9-4c3a-30ea-08dd03c04918
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|7416014|1800799024|366016|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?MHIzekJnN2FQY3dCTFVpRllGbkY0b0t6SGdwZGV2Tk5BT3dhZGxYL2NuNGtD?=
 =?utf-8?B?TFhVN05KeXlZWlRRckpUTi9xNzMvbkkvM2tzdzNTTGd5OGZ5Q2xTMFJvYUt3?=
 =?utf-8?B?UHJLOE55azBuWE9yTVNkWDE4QmxDWWloK092eUhaQ2ZhQlBoTkZMY3Q0UGQw?=
 =?utf-8?B?Q09CVzlVZ0tyZm1leHhsZUVaSDczWFh0UUx4QlBjK1U1MWhVRGp3Y3hKZUNz?=
 =?utf-8?B?cy9pdXJ6MWJydmowQjZ0OUxQaStLSWhnYWx5VmJvSlVFcCtZNWFtVTBYeWJz?=
 =?utf-8?B?SExlazVycVpTOUhqSkdaSGRwa1dDMWVmVWFrMTF6dTJvSXVZaU9RRkZZUWdv?=
 =?utf-8?B?dGZUcnoyZm1MRWpQam9qb0lINVgweS9SZDhOU09nV1Jna3phQm9JQzN0cDkv?=
 =?utf-8?B?Z28xZGJLdG5yQW9yVzVoZTV3Ym12dnlZQi8zVEU1aVNYYmluaGVDSCtYckFX?=
 =?utf-8?B?bFIxcFlOVXVaaXVrNVFhS2ZnL0JVWFpFWmZpWUMwU3dFMjBBWVBtUm9TSVpP?=
 =?utf-8?B?V3diZWlVTDB6aGRadzBjb25zVzRJYTd4R1RDTW81enpzNEpUZGF2MkFobXJt?=
 =?utf-8?B?MGRva1hOQURHUlB3bTJGNCtoeWpTWXRPbWFSQ0xaMlpocVFhN2lWUGxTZUJs?=
 =?utf-8?B?elJvOVdNQUN1SGlLYjdtSXhuYlpmclJPUndHcS9nczErVlhIOHZBR0dFckZ6?=
 =?utf-8?B?K25EZTBseCtJWjVMdHBkK2JaSVV2dk1DaGhXd0NCUFVKeGE1S0x1NXJtSjE3?=
 =?utf-8?B?NEJwUks2RW8yNFJVbnhSZFlKUjhQYjhFQVMxazRLVG9Wck9Zd2FMdXVlazFo?=
 =?utf-8?B?VTJaL29KYWQ2T2djc2g4RXBvcGFvRFJScGl5cmQxSUJ2dEVNTHFwV0hyRm50?=
 =?utf-8?B?cSsxQjd6TU9pTmdOMkI5cDZzRXY0eHR4bWo5Q3ljTUtxVWNkODNqUjlsM1hk?=
 =?utf-8?B?ekFnazE2R1JMKzR5MDlvTDNXQUk2c1RaeEluVE8yZkNmSzdxQlhjSThkK3FI?=
 =?utf-8?B?YThrUjJ5MnpVaUsvQ3ozQnFhVnIvaWdVUEUrUDVUYjhobXZRbFhCT0xyMEgx?=
 =?utf-8?B?SXVTWmZ4K1NHNGdwOEkvTHdWYXpla05EUkhURjRTaGMzRmUxclMxb1h3Uzdk?=
 =?utf-8?B?V0h6b1hJeGY4WG9QLzBWSnE5V09uNTR0THJkRXhuRUttbGVvMm02L1JBZ1J2?=
 =?utf-8?B?R1dEdlhZV3U3K1kzWUJKbkZtU0pmdGpKU3BxSHhVdlZ2S1FoS2V2VGcyLzhL?=
 =?utf-8?B?cVY2RHRaMkNaQ2o1Mk9McjRiRXNnZ1UvTVJiTkxXcEZFNWo1S3ZrNDFxdGlY?=
 =?utf-8?B?NmswbEkyYnBEUkJ6cFhIUmJsU2RBb2lCZS95T21VaVpEbndTYkZEU2ZaYjFl?=
 =?utf-8?B?eWNqbGR0Nk9LaTY4WDY3UXdnSVdvZ2hhTXJtL3J6dE0xdUNYWU00NE9lRG1z?=
 =?utf-8?B?eEY4UVRnTlIyL0ZvSXdlUEZ0V1lnN052bGN1amszNE9OSlZCRnRJemtLbU1k?=
 =?utf-8?B?TElicWxrRHRPOFFWK2c1aTVMVnkzRmZ1TjdYeDNVM1czL2N4eFR5UWt3UFFE?=
 =?utf-8?B?eFBCZU44MmxITzU0R2VPUDFiUWhMaFUvWVdNUmcvNmRIS0thSkVZSXRVNmRn?=
 =?utf-8?B?bklzZkpra292NEFCYW5la3N6L3UrTHp1RExodGxmbHhqaTZZY1ZlamV5RFNJ?=
 =?utf-8?B?Q3g2cXppTWxVMGZKWkdraWNaZXdyd1l3SG54WnhPT3lycGphVUNUa0hIMmNa?=
 =?utf-8?B?K1BpbVdvRWxaUTlKMEpCVTJZZDJYdTlmdFFFVHRBT0FNT3FlNGVPa1c3eC8v?=
 =?utf-8?Q?Y3FpT/z+WtAXY6tFFB6epBfRID0QdD6JT0X4Y=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WTlGWWZaOWtKV214NWVKbCtrSHNDRjIvNDBHY0RTY0gxQ1hGR29yVHBLdDUz?=
 =?utf-8?B?Si8zTldGdG9YTmN0aXV2aTJPOXlMd3BvQW5CaVh2UTRteTJUWi9IM2NiV0NT?=
 =?utf-8?B?TUJWcVZsNzdGaG9CVXROU1VkWHRqUUVSREVaWEtGcGlkYjJVOERFaXBMaXhF?=
 =?utf-8?B?UEM1ZU9vZ2x6VTR4Z2Fkby9vbWkyT1B2NURNV2dWRUdWc0FVeUdFamRSaEU0?=
 =?utf-8?B?RVBKS1BhVXprMnYrRzdFcFBvc01jcXpSZUpITUQwUDdWYnF2dGphWGlwWkZt?=
 =?utf-8?B?Ulo1ejBhd1BrT1d2Mm01V1FKVDlQNjRUbVBobks0SVpzckU5TkhvRmpnOVoy?=
 =?utf-8?B?WkdnUndYK3o0QkJEdUhPQXRsMTY0N1U5NXd3NG0xVW9GdmFlNU1ia2U1YlZZ?=
 =?utf-8?B?LzZRMkcwTmdyWi9PYVhuWjR0RTFiYjREQXlEazA2cXhuT3VJeGtOQWlEL1Rx?=
 =?utf-8?B?eS9FdXBwSzdKRndTM0ZXOFJUaUZtdjJxZUxheDUxWnJzL2hzWVpiRDhxTlhj?=
 =?utf-8?B?SnNJVGd2N2liMnI0Q0thendnTU5DSWNEbm0wSkQ2TnVOUlpiSGVwV05hbGI5?=
 =?utf-8?B?U2NWbFJzbFVxeVh5VjAxK1J2Y2JPMHp2WDQvYmgzUDBiSjJseWYzV2dic2pQ?=
 =?utf-8?B?RXA0WFVvQkZNOXJIaTdFR2YxeTF2UkgzVU91NEtJTXcwMFBFSDhSbGhYZDdU?=
 =?utf-8?B?dkowcGlHc1FaazA3SGtoWWZBREQ2aXpDWXFQWlBhYTlGZnNibUJMc1NoR2NU?=
 =?utf-8?B?SHNLamdZbWFtdkY1eGFoWFFkMGZLZ2E3N2hSWDRrOFM0cHhDZ0lhSDdPcnZT?=
 =?utf-8?B?c2ZLeE00TUN1L1l6dHhvOFpJZ1FYMi9Ta2MrVHdobHA0SmNxYUZBWThGK0Iz?=
 =?utf-8?B?Znc5dG9iMGRUa21EYUU4aFdQMjdHcGppaFcwTUpjNTZYTDhzdVZ4K3ZFWTB6?=
 =?utf-8?B?ZWdZUXYycmJpWVIxTmJKRWJzTTlXTWFYRXlsS2JITUUwU0FGb25PUVlSa0Z1?=
 =?utf-8?B?UzVoaEJGU1dNUzBGUm0xb3hGdDRjc29kVk1qbkpuaFRqNUU3dVYvZEthRkhz?=
 =?utf-8?B?N3l2TG01ZFJ3Z3dDRmpOZHUrbjk1T1NheEtUTFJmUXVua25FZ2hyNkh4d1dp?=
 =?utf-8?B?QW14c0JTVXJYM1JGRmVjMkhMR2EwZ2tyOXlvc3RwUklZK0RsZ1Z0RkdFUHNu?=
 =?utf-8?B?RnBQSXcwck9zOHNYSFNvRTQ0aEs3K3I0ZllvZ1Y1WXNwNlJGcXhTdGw4bllm?=
 =?utf-8?B?QngrVk5uODM1YUJ1TW8wKzlGVkdqMmZLTm9jMndZa2drWHlic1gwR09mclN3?=
 =?utf-8?B?RkkwZS82TWJvU1F4ZXdLUHRDc1FPa2xUMmhaVDdSQ1FJYytGeUJselZEUktm?=
 =?utf-8?B?Uld1SGhPc3dZd0NsUXhXRGNhbWVWdlF0a1dqRUVOZlpNMDVkVVI0NEgzNnpv?=
 =?utf-8?B?OUVTT1p2K1dxenpXSlM2QjhkcWtmb2w3V0MrS1dwY2x3WDJlcHBJUytRRDRB?=
 =?utf-8?B?ZlBleW90MjlpclNUL1g4enhKMW9kMEtsc2ZxMHdPQ1VYN2dYV2FKRWRYdlZZ?=
 =?utf-8?B?YWtNWmNIempOdkJMVEVkVENkRXhUZWFyVnhmMG9zWS9pRTVobDBVdld5djc0?=
 =?utf-8?B?U1lvRG55Q0FzWVVvRFNQRllFSitxZmF4aDRqSzRuWTdrN09RNFI1bGpqdE0z?=
 =?utf-8?B?dXVzVW54c2tOOCtIUlJMeWdhcHVRcmV0MUFZUG5Sa2NmZFdMN1h6eE5xaFA1?=
 =?utf-8?B?eWtKMVJnZm5CMkdPdXBSUkRKbElBY29HZVU5a3BtcnJXdEl2MjRqbzRFUE5z?=
 =?utf-8?B?NjFWU3FYQWM4NTlsOEJ5eXh2OUdJV2ljOWMzenhCTXBvTUY3dVF2RkVpdVE5?=
 =?utf-8?B?S2FtdXA0VGl4WTRaanlqU3M5MnZpOTJyVmZXYjQvR2ZJWm1JUW95YXd0M3FS?=
 =?utf-8?B?L0ozWjljTWZNWllKSS9aUUhFT1V5T3pvc08xMmJJdTVObEs1OWR4Z1Y4YVR4?=
 =?utf-8?B?eHUxT2RxMmJHck1KT1drNDdKaWN2L1g5NDk3Qll4Vjhnd3ZBOHR2R3pwQks2?=
 =?utf-8?B?c3I1UUlYYWYrZlBDMTdpRUxYbEFoRkRTZ21DbWthaDBXanpocEVGU01nMGtq?=
 =?utf-8?Q?H2EfjFvTfmdHjDMXOxoLSb9jA?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0e1a2e2-d7c9-4c3a-30ea-08dd03c04918
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2024 08:50:55.1332 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9PwdXGhraKsvwWEmBcQkUuqGP6q2y6oEY5AqLVss+yMN1TKqZj6xtUvDRxT/hdcViWUnkpKcG4B7WlUqhkEk0jD1Eseyr1vo7pCn3ShQYVc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7193
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.19;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.122,
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

SGkgQ2xlbWVudCwNCg0KPi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+RnJvbTogQ0xFTUVO
VCBNQVRISUVVLS1EUklGIDxjbGVtZW50Lm1hdGhpZXUtLWRyaWZAZXZpZGVuLmNvbT4NCj5TZW50
OiBXZWRuZXNkYXksIE5vdmVtYmVyIDEzLCAyMDI0IDM6MTcgUE0NCj5TdWJqZWN0OiBSZTogW1BB
VENIIHY1IDE3LzIwXSB0ZXN0cy9hY3BpOiBxMzU6IFVwZGF0ZSBob3N0IGFkZHJlc3Mgd2lkdGgg
aW4NCj5ETUFSDQo+DQo+SGkgWmhlbnpob25nLA0KPg0KPkFjaw0KDQpJIHByZXN1bWUgeW91IG1l
YW46DQpBY2tlZC1ieTogQ2zDqW1lbnQgTWF0aGlldS0tRHJpZjxjbGVtZW50Lm1hdGhpZXUtLWRy
aWZAZXZpZGVuLmNvbT4NCg0KVGhhbmtzDQpaaGVuemhvbmcNCg0KPg0KPiA+Y21kDQo+DQo+DQo+
T24gMTEvMTEvMjAyNCAwOTozNCwgWmhlbnpob25nIER1YW4gd3JvdGU6DQo+PiBDYXV0aW9uOiBF
eHRlcm5hbCBlbWFpbC4gRG8gbm90IG9wZW4gYXR0YWNobWVudHMgb3IgY2xpY2sgbGlua3MsIHVu
bGVzcyB0aGlzDQo+ZW1haWwgY29tZXMgZnJvbSBhIGtub3duIHNlbmRlciBhbmQgeW91IGtub3cg
dGhlIGNvbnRlbnQgaXMgc2FmZS4NCj4+DQo+Pg0KPj4gRGlmZmVyZW5jZXM6DQo+Pg0KPj4gQEAg
LTEsMzkgKzEsMzkgQEANCj4+ICAgLyoNCj4+ICAgICogSW50ZWwgQUNQSSBDb21wb25lbnQgQXJj
aGl0ZWN0dXJlDQo+PiAgICAqIEFNTC9BU0wrIERpc2Fzc2VtYmxlciB2ZXJzaW9uIDIwMjAwOTI1
ICg2NC1iaXQgdmVyc2lvbikNCj4+ICAgICogQ29weXJpZ2h0IChjKSAyMDAwIC0gMjAyMCBJbnRl
bCBDb3Jwb3JhdGlvbg0KPj4gICAgKg0KPj4gLSAqIERpc2Fzc2VtYmx5IG9mIHRlc3RzL2RhdGEv
YWNwaS94ODYvcTM1L0RNQVIuZG1hciwgTW9uIE5vdiAxMSAxNTozMToxOA0KPjIwMjQNCj4+ICsg
KiBEaXNhc3NlbWJseSBvZiAvdG1wL2FtbC1TUEo0VzIsIE1vbiBOb3YgMTEgMTU6MzE6MTggMjAy
NA0KPj4gICAgKg0KPj4gICAgKiBBQ1BJIERhdGEgVGFibGUgW0RNQVJdDQo+PiAgICAqDQo+PiAg
ICAqIEZvcm1hdDogW0hleE9mZnNldCBEZWNpbWFsT2Zmc2V0IEJ5dGVMZW5ndGhdICBGaWVsZE5h
bWUgOiBGaWVsZFZhbHVlDQo+PiAgICAqLw0KPj4NCj4+ICAgWzAwMGggMDAwMCAgIDRdICAgICAg
ICAgICAgICAgICAgICBTaWduYXR1cmUgOiAiRE1BUiIgICAgW0RNQSBSZW1hcHBpbmcgdGFibGVd
DQo+PiAgIFswMDRoIDAwMDQgICA0XSAgICAgICAgICAgICAgICAgVGFibGUgTGVuZ3RoIDogMDAw
MDAwNzgNCj4+ICAgWzAwOGggMDAwOCAgIDFdICAgICAgICAgICAgICAgICAgICAgUmV2aXNpb24g
OiAwMQ0KPj4gLVswMDloIDAwMDkgICAxXSAgICAgICAgICAgICAgICAgICAgIENoZWNrc3VtIDog
MTUNCj4+ICtbMDA5aCAwMDA5ICAgMV0gICAgICAgICAgICAgICAgICAgICBDaGVja3N1bSA6IDBD
DQo+PiAgIFswMEFoIDAwMTAgICA2XSAgICAgICAgICAgICAgICAgICAgICAgT2VtIElEIDogIkJP
Q0hTICINCj4+ICAgWzAxMGggMDAxNiAgIDhdICAgICAgICAgICAgICAgICBPZW0gVGFibGUgSUQg
OiAiQlhQQyAgICAiDQo+PiAgIFswMThoIDAwMjQgICA0XSAgICAgICAgICAgICAgICAgT2VtIFJl
dmlzaW9uIDogMDAwMDAwMDENCj4+ICAgWzAxQ2ggMDAyOCAgIDRdICAgICAgICAgICAgICBBc2wg
Q29tcGlsZXIgSUQgOiAiQlhQQyINCj4+ICAgWzAyMGggMDAzMiAgIDRdICAgICAgICBBc2wgQ29t
cGlsZXIgUmV2aXNpb24gOiAwMDAwMDAwMQ0KPj4NCj4+IC1bMDI0aCAwMDM2ICAgMV0gICAgICAg
ICAgIEhvc3QgQWRkcmVzcyBXaWR0aCA6IDI2DQo+PiArWzAyNGggMDAzNiAgIDFdICAgICAgICAg
ICBIb3N0IEFkZHJlc3MgV2lkdGggOiAyRg0KPj4gICBbMDI1aCAwMDM3ICAgMV0gICAgICAgICAg
ICAgICAgICAgICAgICBGbGFncyA6IDAxDQo+PiAgIFswMjZoIDAwMzggIDEwXSAgICAgICAgICAg
ICAgICAgICAgIFJlc2VydmVkIDogMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDANCj4+DQo+
PiAgIFswMzBoIDAwNDggICAyXSAgICAgICAgICAgICAgICBTdWJ0YWJsZSBUeXBlIDogMDAwMCBb
SGFyZHdhcmUgVW5pdCBEZWZpbml0aW9uXQ0KPj4gICBbMDMyaCAwMDUwICAgMl0gICAgICAgICAg
ICAgICAgICAgICAgIExlbmd0aCA6IDAwNDANCj4+DQo+PiAgIFswMzRoIDAwNTIgICAxXSAgICAg
ICAgICAgICAgICAgICAgICAgIEZsYWdzIDogMDANCj4+ICAgWzAzNWggMDA1MyAgIDFdICAgICAg
ICAgICAgICAgICAgICAgUmVzZXJ2ZWQgOiAwMA0KPj4gICBbMDM2aCAwMDU0ICAgMl0gICAgICAg
ICAgIFBDSSBTZWdtZW50IE51bWJlciA6IDAwMDANCj4+ICAgWzAzOGggMDA1NiAgIDhdICAgICAg
ICBSZWdpc3RlciBCYXNlIEFkZHJlc3MgOiAwMDAwMDAwMEZFRDkwMDAwDQo+Pg0KPj4gICBbMDQw
aCAwMDY0ICAgMV0gICAgICAgICAgICBEZXZpY2UgU2NvcGUgVHlwZSA6IDAzIFtJT0FQSUMgRGV2
aWNlXQ0KPj4gICBbMDQxaCAwMDY1ICAgMV0gICAgICAgICAgICAgICAgIEVudHJ5IExlbmd0aCA6
IDA4DQo+PiAgIFswNDJoIDAwNjYgICAyXSAgICAgICAgICAgICAgICAgICAgIFJlc2VydmVkIDog
MDAwMA0KPj4gICBbMDQ0aCAwMDY4ICAgMV0gICAgICAgICAgICAgICBFbnVtZXJhdGlvbiBJRCA6
IDAwDQo+PiAgIFswNDVoIDAwNjkgICAxXSAgICAgICAgICAgICAgIFBDSSBCdXMgTnVtYmVyIDog
RkYNCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBaaGVuemhvbmcgRHVhbiA8emhlbnpob25nLmR1YW5A
aW50ZWwuY29tPg0KPj4gLS0tDQo+PiAgIHRlc3RzL3F0ZXN0L2Jpb3MtdGFibGVzLXRlc3QtYWxs
b3dlZC1kaWZmLmggfCAgIDEgLQ0KPj4gICB0ZXN0cy9kYXRhL2FjcGkveDg2L3EzNS9ETUFSLmRt
YXIgICAgICAgICAgIHwgQmluIDEyMCAtPiAxMjAgYnl0ZXMNCj4+ICAgMiBmaWxlcyBjaGFuZ2Vk
LCAxIGRlbGV0aW9uKC0pDQo+Pg0KPj4gZGlmZiAtLWdpdCBhL3Rlc3RzL3F0ZXN0L2Jpb3MtdGFi
bGVzLXRlc3QtYWxsb3dlZC1kaWZmLmggYi90ZXN0cy9xdGVzdC9iaW9zLXRhYmxlcy0NCj50ZXN0
LWFsbG93ZWQtZGlmZi5oDQo+PiBpbmRleCA0NmY4MGJlOWNhLi5kZmI4NTIzYzhiIDEwMDY0NA0K
Pj4gLS0tIGEvdGVzdHMvcXRlc3QvYmlvcy10YWJsZXMtdGVzdC1hbGxvd2VkLWRpZmYuaA0KPj4g
KysrIGIvdGVzdHMvcXRlc3QvYmlvcy10YWJsZXMtdGVzdC1hbGxvd2VkLWRpZmYuaA0KPj4gQEAg
LTEsMiArMSBAQA0KPj4gICAvKiBMaXN0IG9mIGNvbW1hLXNlcGFyYXRlZCBjaGFuZ2VkIEFNTCBm
aWxlcyB0byBpZ25vcmUgKi8NCj4+IC0idGVzdHMvZGF0YS9hY3BpL3g4Ni9xMzUvRE1BUi5kbWFy
IiwNCj4+IGRpZmYgLS1naXQgYS90ZXN0cy9kYXRhL2FjcGkveDg2L3EzNS9ETUFSLmRtYXINCj5i
L3Rlc3RzL2RhdGEvYWNwaS94ODYvcTM1L0RNQVIuZG1hcg0KPj4gaW5kZXgNCj4wZGNhNmU2OGFk
OGE4Y2E1Yjk4MWJjZmJjNzQ1Mzg1YTYzZTlmMjE2Li4wYzA1OTc2NzE1YzZmMmY2ZWM0NmVmNmQz
NzcNCj45MGY4NmEzOTJiNWVhIDEwMDY0NA0KPj4gR0lUIGJpbmFyeSBwYXRjaA0KPj4gZGVsdGEg
MjENCj4+IGNjbWI9WjtCeFZHNDYweVlVfHs1IyRSKSs3S1QkT3AwNShxcWtebGV6DQo+Pg0KPj4g
ZGVsdGEgMjENCj4+IGNjbWI9WjtCeFZHNDYweVlVfDx4VCRSKSs3SGM+U2cwNSpJQ2tebGV6DQo+
Pg0KPj4gLS0NCj4+IDIuMzQuMQ0KPj4NCg==

