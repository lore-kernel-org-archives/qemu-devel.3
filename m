Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A45EFC41513
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2024 13:58:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sAVPs-0007n9-To; Fri, 24 May 2024 09:57:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1sAVPr-0007lv-MV
 for qemu-devel@nongnu.org; Fri, 24 May 2024 09:57:03 -0400
Received: from smarthost1.eviden.com ([80.78.11.82])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1sAVPo-0004fk-U8
 for qemu-devel@nongnu.org; Fri, 24 May 2024 09:57:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1716559021; x=1748095021;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=DOsFMv9KvhZzLvkfrcjj+gyriMMeJtahUzLWlRv2KWA=;
 b=o0v5h1SfyMyd45HQtWLW9pqMN0H3gp+vGIja4RU72lbXDFhhAmcjmaYZ
 2ByedJKAN6y1wY0gjHrtnceT3ZaNu1Yst3dd9E6iGzU/eQxVzOnSL7Lyw
 eyGQYd8kKsebb2WKGZ65zO5kKeHnYO0PE38Ib/4M+NgtYfYOEbefVHyND
 2iAZanEhqAGbyZ7gg7t7IkQcnxq7eAJuIvI4Hf/SSc4sH75L5GrWQPecm
 G/rnzXHZPzADTQsbGojsAXBnXEwt0uKSecT8LyLEDAbs8osatCXwQGGo3
 6pqERgrWVtC4Aqg4TQp3JyjSJzA/8qQSIkri6djHiqDoeetEIWOB5ijn3 Q==;
X-IronPort-AV: E=Sophos;i="6.08,185,1712613600"; d="scan'208";a="13225716"
X-MGA-submission: =?us-ascii?q?MDFX4NBVxJQPnOPIZjR42H3i1YbZ25FDwb8E6h?=
 =?us-ascii?q?ouZ2+Ghk8EjjQ9Wv5AbgByvtOGyDOtvVjRaI3LS8B7eCwf6bnrlGhVp7?=
 =?us-ascii?q?Gc2vSQGzCLynGgycnBBNF+aMPuyNScz7AvnkJ3JK1Z7Ot42R2D4uk+R7?=
 =?us-ascii?q?9UMVm1f/7dzxwVjnqWSUjsTg=3D=3D?=
Received: from mail-he1eur04lp2051.outbound.protection.outlook.com (HELO
 EUR04-HE1-obe.outbound.protection.outlook.com) ([104.47.13.51])
 by smarthost1.eviden.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 May 2024 15:56:54 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a5zEAcBigN1G+100VA7L1uwQqwx9cs4gHc3Y0NtzPuHTFqbUXHYJPmkVddazo0tRtAkBIiAtMkXSD2YaTLQJsgRIFEnifCdig7futq1L/S2PJyA7eW2eYY+qWdDVpnhgurA/z6RELz0y5s4jmFw9NhvFhVpu6h5JB+SSWrciLPRTpvQQ43fGA43NNa/kK4b5OVtfSKtf6feo9526xZFl9sdZ01YK6T4soESVLGCpJjXnC7zKIvNEqt12HjtUc1ooari53O4UyU4p1pSOXnGDGqL0i7aWzA81IDo5zT2//rtE6IWVD1FL+0gLrCL9GndQHeoBzJKxxZBfut6nqEZ8bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DOsFMv9KvhZzLvkfrcjj+gyriMMeJtahUzLWlRv2KWA=;
 b=XxFFmURc39NQv+lFM25oMbk6Fs0THqqVOPM1LWrTUk97ocmOzj5aVy5migXR5n41dj+nZoeV0c6WaxHY25Vxy3by1foW2dxdOIgTwrqvdsRjnLEemMr9Hw8wvReS63TZzwh6pg5J2M/SNpiGDWe5Pzl7K/+BY9Fh/G8Tb1O28XA3nSExVGtnUxX4XTJjkFR4iA3ruH6+kMr/njegum15uTeJnXuqn5+9z9FmiABVrEMsgWB7wqpbwYHYaFfVofqcifHzFEYPoLCYH73pOfxCRxXYa2U87x5WHPPj2mDSR4DTf+LwL+ShXQC/wTxPpUF79ceMBr08LfahjtIas5D+xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by GVXPR07MB9680.eurprd07.prod.outlook.com (2603:10a6:150:110::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.22; Fri, 24 May
 2024 13:56:52 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%5]) with mapi id 15.20.7611.016; Fri, 24 May 2024
 13:56:52 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>, "eric.auger@redhat.com"
 <eric.auger@redhat.com>, "mst@redhat.com" <mst@redhat.com>,
 "peterx@redhat.com" <peterx@redhat.com>, "jasowang@redhat.com"
 <jasowang@redhat.com>, "jgg@nvidia.com" <jgg@nvidia.com>,
 "nicolinc@nvidia.com" <nicolinc@nvidia.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>, "chao.p.peng@intel.com"
 <chao.p.peng@intel.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard
 Henderson <richard.henderson@linaro.org>, Eduardo Habkost
 <eduardo@habkost.net>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: Re: [PATCH rfcv2 15/17] intel_iommu: Set default aw_bits to 48 in
 scalable modren mode
Thread-Topic: [PATCH rfcv2 15/17] intel_iommu: Set default aw_bits to 48 in
 scalable modren mode
Thread-Index: AQHarBETrJJqvHUXHEOluDilF7EbI7GmbEIA
Date: Fri, 24 May 2024 13:56:52 +0000
Message-ID: <f80e5a23-5006-4fd6-8bd4-60a114c316e8@eviden.com>
References: <20240522062313.453317-1-zhenzhong.duan@intel.com>
 <20240522062313.453317-16-zhenzhong.duan@intel.com>
In-Reply-To: <20240522062313.453317-16-zhenzhong.duan@intel.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|GVXPR07MB9680:EE_
x-ms-office365-filtering-correlation-id: 8fa77d3f-22e8-4200-ceda-08dc7bf95d9a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230031|7416005|1800799015|376005|366007|38070700009; 
x-microsoft-antispam-message-info: =?utf-8?B?YkdTRFhtVFJUczZ5NlJ2U1FCTldNTit3Zm5rRFk4OEt4VytFVlN2OGRTdGdz?=
 =?utf-8?B?aThwMjNvQ0c1RVM4SHlXZmd3ZCtlV0c2clVJcWsrdU8zbHVxT0JGbEtweEUv?=
 =?utf-8?B?Skd0dlNrQ2NVLzR2NFZNOFptUFY0OW9BWWt2aU5Ia2FoR2lwMjZkQllxMHN6?=
 =?utf-8?B?NEFYWEdTeVVQQ1lOUHlKUDA5bmRDdEZTU3dnTFYwaVJxcnl2T2MxVzA0bjNO?=
 =?utf-8?B?Yk85cjZmWHdGOGxDYy8yTzE5ZkpYZmJpTG9LQTA0VmhXZnFraXRpK000anA0?=
 =?utf-8?B?SDdjelNFNjVlMXdjQUVNUXphakpHZG5tRGEraFRnMFJSVlVVTnFGajlrNUsz?=
 =?utf-8?B?Z0QraE9qQVFQVDl5YTFZYitRVU9XL28vRUZ0M3VKUU81MGtIOE1raGtZWHNu?=
 =?utf-8?B?SWtRSFVYeFpRTElDZTJRcWx4cFJGRWpGN1RIREVpTFNGZWNSVm91U2dtZTlr?=
 =?utf-8?B?YURUVmY5VzdkNWN3WmhPUlAzaWo5Ry9iS09kTWJ0WEtGdU5YUW9NamUzbDBS?=
 =?utf-8?B?blRsVXVyb3Q1aUo2STNWWTZET20rMDNSdUl2NWVyUm1jekQ5empPSUdHbU45?=
 =?utf-8?B?eXAraWlDZDlzTjJ4SUVzeGp3Rk1iU3Q2RjUwVXFuNGp1M2RjcGdSM3FlUHM1?=
 =?utf-8?B?VEpBVlR3V2daNElrNXloZnhmeWZCZ2xQU2VQNXlTQWNQNnczdkN5NmpOZXZs?=
 =?utf-8?B?SWtMWlgrNEYzc3RZUnVvMXI2TkxuVUFpWUE4aGdZbDQ1anFwalQ4ZEp2ekpw?=
 =?utf-8?B?MDVCRGVETy9SUHBzTG9ncythREQvVHpESDNnQnhLNG84OXBlanpVZHg3dHpH?=
 =?utf-8?B?WnlZZHNwNGw5Z0pyQWdiazliamdZaHZBMHdhaWRueHVrb0RndFJWcTRvdVJV?=
 =?utf-8?B?Z3RuNXFGOXRYREx5eUpPWlVLOW1tbUF4WUtXZ2E1cFMvTVRHbXFrTml6T0tM?=
 =?utf-8?B?VUhvOGJNTUJIWGo1QTZMOTUyZDNTOWI0WFg1SnpsSGhyMVE0elZwWEYxT2RN?=
 =?utf-8?B?bUt0TEJKbnNIblpBYmtyc1kyTUg1NFR2eTJZZS9KVEV4NmRVSWdQdngzMy81?=
 =?utf-8?B?bmlyYmkxRjdRSlNFSXFOL1BOUU9yakQ1cXl6cU9hS1hCTm9xdjFqYy9yUTBq?=
 =?utf-8?B?WnozRkg1SDN4UzRTR2pTSk9tdEhrdHhsZno5RFdMYm5EdG1VS1ZabXNvbnJz?=
 =?utf-8?B?RXpkbk9BVUdNdjJPZHBnVEFDMzBxbHh4TVo4SVdpU1hiOWk5V2V2cmo3bStP?=
 =?utf-8?B?L2tqUFNzRUMyVWs3SFdnQ3dqaTRLTWV5ekVTVjI0OGRPS2x5YW1Ta0UwNGVQ?=
 =?utf-8?B?WjAxWlhFcWNIOThrWUhyWU1Rb1VIOEpNOFMrdFo2N0sxQ1hFNFBsbFBmcjFz?=
 =?utf-8?B?SzhFbkJ6bHMxMm1HSUF0eGRCcG9NcGs2OTFnUmViYzhFZGl2aW5IVElwdjBP?=
 =?utf-8?B?UzdtS00vbnZBOTJHZDRUVFJnUmxvTEdneDExSHB1T2ozbGppKzVweE1sRFAz?=
 =?utf-8?B?YWtWeGZ4YlY2YW1Tc1JBUHV1a2t5cUN1ZGtpTi9aNDVsMVVhaWo4RWdyT1Rp?=
 =?utf-8?B?THloUWNUQzhIQ25JZ3JiMWNtc2svUjlIRlR0UVlreGpsUEd0dVVPWlhReW1x?=
 =?utf-8?B?WVVyUHMzSVp1NGJOU2NZRCtFU2U3aGxnMzlYYUdHWEFCQ0FUZmpVSWd2N2kv?=
 =?utf-8?B?RDdqamRwcGtvU2FnV080SFphL1BndDRqeTR0R3JYRmZJRmlSYzFYM242N2RH?=
 =?utf-8?B?YTRGWWV5cWs3NGlSbnB5a1JNbEd3c2FqMzF0WGFCZFBTME56Y2Yva0dESUhY?=
 =?utf-8?B?TGRZZzFvcWM0QnhPODl4dz09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(7416005)(1800799015)(376005)(366007)(38070700009); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?N1NWL2dSVnM3Q2RsclEwZk1HN3pDZGlBV2ZOeDZtS3QzTTFXR3NwSm41S1F3?=
 =?utf-8?B?TUVlMjdVZGFadzF3eFNTUGc1U3MyYUlwOUtjbHQ5Ny9UZVlBanprZWppKy9a?=
 =?utf-8?B?dEFxU2M2ZnBGeUhPRlhVcGxtRUdCWUFyQ2EyK2hvZkswYXI2b0UwdGpuNGdw?=
 =?utf-8?B?WGdYR1htcTE2L003eVdnQ01YSVVCNnE5N21tS3hLZVJtZnZNTU8vcHJmMGlz?=
 =?utf-8?B?VHZvRngzVFhTRGE1ay9tYk0rM3V3b0xaWk05YUtLWC9OcTZpbFNmSCtJa3gz?=
 =?utf-8?B?bmFad1l0UzFDQ1ZDV25SNndrY3RoZEIzSjBoTlVZd2dkdml3cGtlR2ZBdS9w?=
 =?utf-8?B?MENjUFNJejlBNGsyM1ZIclBSQ0xCQkxCVjBSSFFzWk5zdlBmTml4MDdjZmNa?=
 =?utf-8?B?NDBvbUdkMzRLU3pGTnI3Qk94RWRGN1JJSEtGejkyYndJV1RWZkhJaUY2WlB2?=
 =?utf-8?B?NnBpdmpycmY5dVZVU0d6MzNMQXdmQlc1bnFYdTVqcnMzTHA4eUlhMkRMOUEv?=
 =?utf-8?B?bmFVeFZ1TUdGZ29pU2dFSU5kZGRwNGxYWisrRTF1Q29ScHgvbDZpdk9hcGo3?=
 =?utf-8?B?bk55Y1lrNElVakJDOXhTeklOU0VZeVA0MWNVc3ljSXdWM2IrMldFQUdKb2U5?=
 =?utf-8?B?WTN3REdsdzNzSllFOGhGOUZ0NDUrS0crQ0syU0x1NHRmMUl5b2NoQ3BzZk83?=
 =?utf-8?B?YWlvbFdtUGtPdDdScXNycCtUQjNBQ0VOMC8wRkU2bll6OWgrWEJab052Ymp3?=
 =?utf-8?B?RGI4NmdxWmhZOGRSeHRUc1ZrL1VvQk96MVN5VXN3cDh3eTBiQXMrc0xWeVds?=
 =?utf-8?B?NS9GamNPbUdQS1JmSGZOdXRHZE52NUlXZUd2b2RNNnJ3elB5eHhkMnZyVEdB?=
 =?utf-8?B?bHFNL2plUzlQOGhQSEt5ZUNsZmNtTFVwTy9RWGtPalNsanZUZHVaVzZZR28z?=
 =?utf-8?B?NWtieGltMDRDSFd6TjVPOVd1OHptOGxUYTN6MGRZMXI5Slk0L3dKVUszWXh6?=
 =?utf-8?B?d21NZFk2eUN5dTJ4TFhTekM3Nk52cytFdTI4dFpFTFJ6ay9ZbDJXMGR2YnZF?=
 =?utf-8?B?RVlaT3pLb01mTm9JTU5PVEVpOFViWlFrQ1lyMUo0L2oxN3JPMW5iOTFPOHJh?=
 =?utf-8?B?OWlrMVhjdDgrb2ZKYkZUUHJ3bnV4UnJhVGJOZTg3NXNVUmJIRlVpUi8wak80?=
 =?utf-8?B?Sk1yYmo1SkNiTEFJTUkyYk9RdU9xSzhtVm9NS2VNcEFZd2lFUzlBdHRIRXN3?=
 =?utf-8?B?UGlJcCszbjJ6U203cXRUbGRQWGxtRHpwSmhReS95aXh1TkIrM0plS2F4UjdX?=
 =?utf-8?B?TU0rWkt4NTR2UXUzcVV0NW5JOXhESWxVVmNWUy9wTjk4NUJpSUxNNjJoWWlH?=
 =?utf-8?B?UFBrcUJoMG9XTmNlMExnMTBmUC9Sc2pVTGxSNldFTWlCRWp2bHNrdyt4RG5S?=
 =?utf-8?B?UUtuYkNvcU9oRjVtWFljUEhmekt0THVjZnNycEU2NUpod2pKeVozN09HNFJ5?=
 =?utf-8?B?b1BhNU1mWU9vK3dDWTU0WnpEblRiVkFVNC9EZ0lHZnRJL2NCYTcvL0U2K2Zp?=
 =?utf-8?B?QVY4QkZGVU1RUGVVRE9qVHhQOGhTL0NoUkxLekVpRzNOM24xM05ZanlmOEdN?=
 =?utf-8?B?ZXdvQ0lpZTFCZysxUGVLWnhJSDJ5WDVGaWVhWDZFMEx6NWFjU0ROc053SHVk?=
 =?utf-8?B?dHFheHZBelJ6MXgzMHVCcEY4TDRJdmFac3dtaEJ0YTdJZlEyZ3d2SWVnUzYx?=
 =?utf-8?B?QVlIWnpVNnFreWJsUUw3OXBnYWVvOGR5TXgxbHN0STdIYkhhSDZDWE0wNm13?=
 =?utf-8?B?R1NvdERid2hmQ3VZd1k1WTc0eWtGakpFcW1UV1pmQ002SVZlWFRoZHFVTmhV?=
 =?utf-8?B?OFRObHo2bzA2U0xoZVM0QS80MThJN0lPektWVFd3ekM3ZjluTnpnZ1V4SHJi?=
 =?utf-8?B?d3lWQlA0WU1UV1Zta2xtOHk0dDJEZTN0Rk8rc1Q3U2ZHOUFEcDFKK3crVGE4?=
 =?utf-8?B?Nmg1ZE1ZQnZUMXpaRXpjUzBLQ2JpdXV2NCtoN3pRNDZyU281WUYzL3BIcHZZ?=
 =?utf-8?B?cVhKWXE3dUx5YkJBL3QwbzdwdW1ETFNlbVN3YzRrd0RkNFNuSWNLQXkvSTJF?=
 =?utf-8?B?R1pjcVNucitLdXoyTWFhWHFqcXBERU1PSXdMUXgyR1NBK1JFdkdDV1c3aXJ3?=
 =?utf-8?Q?fm8tJBOGw0X2BxFRFoycDQA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D229BF1A6C60EE43A5627EDF332D0578@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fa77d3f-22e8-4200-ceda-08dc7bf95d9a
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 May 2024 13:56:52.6823 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /pOkzZ3L3jjJQ/uWwO7y1bsLgEhiIATpPnyUKM8Mowatlwr0Fn007BWcup7+AUDn/uvw7fcmfby5cu7+lgz/uKMf14eKGZOauDlQe9uUseH2IXrsrGSAkMs8p3RaYyI/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR07MB9680
Received-SPF: pass client-ip=80.78.11.82;
 envelope-from=clement.mathieu--drif@eviden.com; helo=smarthost1.eviden.com
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

SGkgWmhlbnpob25nDQoNCk9uIDIyLzA1LzIwMjQgMDg6MjMsIFpoZW56aG9uZyBEdWFuIHdyb3Rl
Og0KPiBDYXV0aW9uOiBFeHRlcm5hbCBlbWFpbC4gRG8gbm90IG9wZW4gYXR0YWNobWVudHMgb3Ig
Y2xpY2sgbGlua3MsIHVubGVzcyB0aGlzIGVtYWlsIGNvbWVzIGZyb20gYSBrbm93biBzZW5kZXIg
YW5kIHlvdSBrbm93IHRoZSBjb250ZW50IGlzIHNhZmUuDQo+DQo+DQo+IEFjY29yZGluZyB0byBW
VEQgc3BlYywgc3RhZ2UtMSBwYWdlIHRhYmxlIGNvdWxkIHN1cHBvcnQgNC1sZXZlbCBhbmQNCj4g
NS1sZXZlbCBwYWdpbmcuDQo+DQo+IEhvd2V2ZXIsIDUtbGV2ZWwgcGFnaW5nIHRyYW5zbGF0aW9u
IGVtdWxhdGlvbiBpcyB1bnN1cHBvcnRlZCB5ZXQuDQo+IFRoYXQgbWVhbnMgdGhlIG9ubHkgc3Vw
cG9ydGVkIHZhbHVlIGZvciBhd19iaXRzIGlzIDQ4Lg0KPg0KPiBTbyBkZWZhdWx0IGF3X2JpdHMg
dG8gNDggaW4gc2NhbGFibGUgbW9kZXJuIG1vZGUuIEluIG90aGVyIGNhc2VzLA0KPiBpdCBpcyBz
dGlsbCBkZWZhdWx0IHRvIDM5IGZvciBjb21wYXRpYmlsaXR5Lg0KPg0KPiBBZGQgYSBjaGVjayB0
byBlbnN1cmUgdXNlciBzcGVjaWZpZWQgdmFsdWUgaXMgNDggaW4gbW9kZXJuIG1vZGUNCj4gZm9y
IG5vdy4NCj4NCj4gU2lnbmVkLW9mZi1ieTogWmhlbnpob25nIER1YW4gPHpoZW56aG9uZy5kdWFu
QGludGVsLmNvbT4NCj4gLS0tDQo+ICAgaHcvaTM4Ni9pbnRlbF9pb21tdS5jIHwgMTYgKysrKysr
KysrKysrKysrLQ0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAxNSBpbnNlcnRpb25zKCspLCAxIGRlbGV0
aW9uKC0pDQo+DQo+IGRpZmYgLS1naXQgYS9ody9pMzg2L2ludGVsX2lvbW11LmMgYi9ody9pMzg2
L2ludGVsX2lvbW11LmMNCj4gaW5kZXggZTA3ZGFhYmE5OS4uYTRjMjQxZWE5NiAxMDA2NDQNCj4g
LS0tIGEvaHcvaTM4Ni9pbnRlbF9pb21tdS5jDQo+ICsrKyBiL2h3L2kzODYvaW50ZWxfaW9tbXUu
Yw0KPiBAQCAtMzc0OCw3ICszNzQ4LDcgQEAgc3RhdGljIFByb3BlcnR5IHZ0ZF9wcm9wZXJ0aWVz
W10gPSB7DQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIE9OX09GRl9BVVRPX0FVVE8p
LA0KPiAgICAgICBERUZJTkVfUFJPUF9CT09MKCJ4LWJ1Z2d5LWVpbSIsIEludGVsSU9NTVVTdGF0
ZSwgYnVnZ3lfZWltLCBmYWxzZSksDQo+ICAgICAgIERFRklORV9QUk9QX1VJTlQ4KCJhdy1iaXRz
IiwgSW50ZWxJT01NVVN0YXRlLCBhd19iaXRzLA0KPiAtICAgICAgICAgICAgICAgICAgICAgIFZU
RF9IT1NUX0FERFJFU1NfV0lEVEgpLA0KPiArICAgICAgICAgICAgICAgICAgICAgIDB4ZmYpLA0K
eW91IGNvdWxkIGRlZmluZSBhIGNvbnN0YW50IGZvciB0aGlzIGludmFsaWQgdmFsdWUNCj4gICAg
ICAgREVGSU5FX1BST1BfQk9PTCgiY2FjaGluZy1tb2RlIiwgSW50ZWxJT01NVVN0YXRlLCBjYWNo
aW5nX21vZGUsIEZBTFNFKSwNCj4gICAgICAgREVGSU5FX1BST1BfQk9PTCgieC1zY2FsYWJsZS1t
b2RlIiwgSW50ZWxJT01NVVN0YXRlLCBzY2FsYWJsZV9tb2RlLCBGQUxTRSksDQo+ICAgICAgIERF
RklORV9QUk9QX0JPT0woInNub29wLWNvbnRyb2wiLCBJbnRlbElPTU1VU3RhdGUsIHNub29wX2Nv
bnRyb2wsIGZhbHNlKSwNCj4gQEAgLTQ2NjMsNiArNDY2MywxNCBAQCBzdGF0aWMgYm9vbCB2dGRf
ZGVjaWRlX2NvbmZpZyhJbnRlbElPTU1VU3RhdGUgKnMsIEVycm9yICoqZXJycCkNCj4gICAgICAg
ICAgIH0NCj4gICAgICAgfQ0KPg0KPiArICAgIGlmIChzLT5hd19iaXRzID09IDB4ZmYpIHsNCj4g
KyAgICAgICAgaWYgKHMtPnNjYWxhYmxlX21vZGVybikgew0KPiArICAgICAgICAgICAgcy0+YXdf
Yml0cyA9IFZURF9IT1NUX0FXXzQ4QklUOw0KPiArICAgICAgICB9IGVsc2Ugew0KPiArICAgICAg
ICAgICAgcy0+YXdfYml0cyA9IFZURF9IT1NUX0FXXzM5QklUOw0KPiArICAgICAgICB9DQo+ICsg
ICAgfQ0KPiArDQo+ICAgICAgIGlmICgocy0+YXdfYml0cyAhPSBWVERfSE9TVF9BV18zOUJJVCkg
JiYNCj4gICAgICAgICAgIChzLT5hd19iaXRzICE9IFZURF9IT1NUX0FXXzQ4QklUKSAmJg0KPiAg
ICAgICAgICAgIXMtPnNjYWxhYmxlX21vZGVybikgew0KPiBAQCAtNDY3MSw2ICs0Njc5LDEyIEBA
IHN0YXRpYyBib29sIHZ0ZF9kZWNpZGVfY29uZmlnKEludGVsSU9NTVVTdGF0ZSAqcywgRXJyb3Ig
KiplcnJwKQ0KPiAgICAgICAgICAgcmV0dXJuIGZhbHNlOw0KPiAgICAgICB9DQo+DQo+ICsgICAg
aWYgKChzLT5hd19iaXRzICE9IFZURF9IT1NUX0FXXzQ4QklUKSAmJiBzLT5zY2FsYWJsZV9tb2Rl
cm4pIHsNCj4gKyAgICAgICAgZXJyb3Jfc2V0ZyhlcnJwLCAiU3VwcG9ydGVkIHZhbHVlcyBmb3Ig
YXctYml0cyBhcmU6ICVkIiwNCnNwZWNpZnkgJ2luIG1vZGVybiBtb2RlJyBpbiB0aGUgbWVzc2Fn
ZT8NCj4gKyAgICAgICAgICAgICAgICAgICBWVERfSE9TVF9BV180OEJJVCk7DQo+ICsgICAgICAg
IHJldHVybiBmYWxzZTsNCj4gKyAgICB9DQo+ICsNCj4gICAgICAgaWYgKHMtPnNjYWxhYmxlX21v
ZGUgJiYgIXMtPmRtYV9kcmFpbikgew0KPiAgICAgICAgICAgZXJyb3Jfc2V0ZyhlcnJwLCAiTmVl
ZCB0byBzZXQgZG1hX2RyYWluIGZvciBzY2FsYWJsZSBtb2RlIik7DQo+ICAgICAgICAgICByZXR1
cm4gZmFsc2U7DQo+IC0tDQo+IDIuMzQuMQ0KPg0KI2NtZA==

