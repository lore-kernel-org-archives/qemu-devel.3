Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0A97C77B7C
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Jun 2025 02:20:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uTWnd-0003zK-Ji; Sun, 22 Jun 2025 22:20:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uTWnc-0003w8-6j
 for qemu-devel@nongnu.org; Sun, 22 Jun 2025 22:20:44 -0400
Received: from mgamail.intel.com ([192.198.163.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uTWna-0000Gk-7y
 for qemu-devel@nongnu.org; Sun, 22 Jun 2025 22:20:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1750645242; x=1782181242;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=QYnNjf0xfmEpCPVItujYyGGLqCdbAQSQxI7OMhXhJq4=;
 b=WNMIcYRZn1h3rGEnTc7j0PpJgSZjVJuxttp5ONn6cEsVtyBPuRUuorb9
 PERcmZDGPZZOMjsNs9zpw7qZ90v/NHhFqugnzQck47ju81lTDe2ZiwMim
 MaTtUm/IfXMQbO1ICuFyhYV6XsV3Yn6VufzG6OxZ9/CGepPQUgJgixJ13
 jeSNW4F93G9fYGea1QAyxzJ9WnZB856P+e8sjWk0j5YUhS1O/a3DP348A
 mchjcX+K9ZO4yFtfxUGiJQvJEpB4ZhrE1heYHzThDrWtAHsDv1dkqOcGC
 MOykVSAabJXuUbxluypkmJbpNBLyJmqOISjQCh1sSb38QqzybPl6WbyAy g==;
X-CSE-ConnectionGUID: X3ii1MmzQdqH0bJNvu/1rQ==
X-CSE-MsgGUID: KZkosXmiQdOiIllBhr9tDw==
X-IronPort-AV: E=McAfee;i="6800,10657,11472"; a="52768244"
X-IronPort-AV: E=Sophos;i="6.16,257,1744095600"; d="scan'208";a="52768244"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Jun 2025 19:20:40 -0700
X-CSE-ConnectionGUID: OracyibiQKG8CYuFlpNlCA==
X-CSE-MsgGUID: zVrKH5ewSHGARzk0z8R/2w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,257,1744095600"; d="scan'208";a="152137716"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Jun 2025 19:20:39 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Sun, 22 Jun 2025 19:20:39 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Sun, 22 Jun 2025 19:20:39 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (40.107.93.54) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Sun, 22 Jun 2025 19:20:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HKxHLec1Qg55ORzJUnGpve35BBHPbyPRqJ2fhppyYL+cs64hFYq7ZdY2jh+/2FfAyres6chBBTgEp/ClrWWMvrTJDDHDI1uGFKn/96mkz27jULnoEfSn7C0pZI3ZQDUshRpIF42Mj4f/wPSQzOODyWZy8p50hFDG5QDA4P2IO5Btki2nBN+ZwQxrRmlDKj2XOFrAgIFcmTrP1TJXuTyNAwifBJ02xbENmE2heKIm5Mrj0TpwSqcWlzku5l8/1bTHt4Uxz2izxwKvccZIVtM/A0K2G2iAPAyihxoFEU5ByrTTp3pziu5SRPTS0e3PAz2Fa1BW5TrGRQ3Ju/uHXWDboQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QYnNjf0xfmEpCPVItujYyGGLqCdbAQSQxI7OMhXhJq4=;
 b=LqlrS1u03Hb9RnXFunEsSOKyxRe4SqhpPMefJcEcrYtyTgQY7yuMmc9SE1je0ZlVrc9HYmPKWShcJ9IrcUQv2e/u9F90XEoyHeXkjR/zHcNfZKJtsbTOlUg/SIv6zRD1pIgZ7rGCD3zH/GFDAd8OwQtCPe08xqGvd5+0Haec4nuK5JxnnDDkVPZlPo8TnteGmey1+TCoBQQXsfmnywT3Gl/YOGb/Fk0Dodikk8jYRiZe5LxnkbR5gTdQYzobzwUhVp427FV0RGD5s1iIfmgaKDkvovmS4fPDX4w6HlRSrDVkn/ftQqzMT4Hj95KgGPhXPIke31mU7jhIRrl6TjglvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12)
 by PH7PR11MB6956.namprd11.prod.outlook.com (2603:10b6:510:207::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.30; Mon, 23 Jun
 2025 02:20:34 +0000
Received: from IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13]) by IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13%4]) with mapi id 15.20.8835.023; Mon, 23 Jun 2025
 02:20:34 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: "eric.auger@redhat.com" <eric.auger@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>, "mst@redhat.com" <mst@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>, "peterx@redhat.com"
 <peterx@redhat.com>, "ddutile@redhat.com" <ddutile@redhat.com>,
 "jgg@nvidia.com" <jgg@nvidia.com>, "nicolinc@nvidia.com"
 <nicolinc@nvidia.com>, "shameerali.kolothum.thodi@huawei.com"
 <shameerali.kolothum.thodi@huawei.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "clement.mathieu--drif@eviden.com"
 <clement.mathieu--drif@eviden.com>, "Tian, Kevin" <kevin.tian@intel.com>,
 "Liu, Yi L" <yi.l.liu@intel.com>, "Peng, Chao P" <chao.p.peng@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson
 <richard.henderson@linaro.org>, Eduardo Habkost <eduardo@habkost.net>, Marcel
 Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: RE: [PATCH v2 03/19] intel_iommu: Implement get_viommu_cap() callback
Thread-Topic: [PATCH v2 03/19] intel_iommu: Implement get_viommu_cap() callback
Thread-Index: AQHb4bQYLS7DJqsaDkyHKpm+xRh117QLsjqAgARVEoA=
Date: Mon, 23 Jun 2025 02:20:34 +0000
Message-ID: <IA3PR11MB913627BF2E40D74BE47B6F089279A@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <20250620071813.55571-1-zhenzhong.duan@intel.com>
 <20250620071813.55571-4-zhenzhong.duan@intel.com>
 <2478ff00-a09d-4904-89b3-bdcebbcb7fbe@redhat.com>
In-Reply-To: <2478ff00-a09d-4904-89b3-bdcebbcb7fbe@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9136:EE_|PH7PR11MB6956:EE_
x-ms-office365-filtering-correlation-id: 2a52285a-ec01-413d-505d-08ddb1fc8925
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|7416014|376014|366016|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?ZzgxQXlSSWdVUWdXVXhTZDhMTTd4L2NMUllMRHdpTjBhbHBoVks3dWlWOEV1?=
 =?utf-8?B?TEkvS2NKODA0N3ZyaXUycFRIRU1SRXlHaWtUeVlkL2N3Y3lJVzhydEtTdUR4?=
 =?utf-8?B?VlRoRzM1TGNBaWNBNjMwODdJOXErY3J6dlhCNFA5SHh6QVlmdW9Mb040Z2sy?=
 =?utf-8?B?S1h2WDVuaEpSNnJySS9tUm1lL1BaK3BTLzNxZzBkdS8xZXY2UDY4elZ4Z0hS?=
 =?utf-8?B?SWV6YlF3am4wRDRlcXFHaEsyYTFGc0lUMnNweWROVFZNRGhqZmRFTEV2bFlq?=
 =?utf-8?B?UUVMYjhteW9oYVUzWlc4SDlTMCs4ZDJxMjJqa2F1RDIwRWJFQTYrTGZPK2x3?=
 =?utf-8?B?MCtEOTBqUkJXR0ppaWNjSHB0Ky9PUFdJZXVYcHhjTmY2WUhSSU1abDFUZ3NR?=
 =?utf-8?B?d3dFOUhGVXpoMnZidmxxZU5MTmhBOGdhWVF2ZlhCSTVEUUVMbk5qNG9HRzgx?=
 =?utf-8?B?K2FnK1VydEo2dkVzSXpiQ3A4VzlRWGJDc2VvRHRBcDV1R3J0dnVSMzdsa1o3?=
 =?utf-8?B?bHR1R3BwRzZRMzRZbUJQTTh2WDNVUjhpb25yY0wvQUd3SC9ZVmhDRm1taVRM?=
 =?utf-8?B?cStZWFg0SHZZSHZFOHkwNUpBUVdJVXhad1c2amM2eGIvekdKZDcrcnNXVDRV?=
 =?utf-8?B?cTRlT2NiUmN2UXpreGRMdlRSYjVaQy96aTFDQ0NWSjR1ci9kb3JtUmFHTnlU?=
 =?utf-8?B?enJSeDBTaWs5UlowRnZXYXdWWjZwU3VWbnY1MW1YbjIrV2lITGh2VTFLQUI1?=
 =?utf-8?B?SmxyVlpESlI2WE92MTFSSXNXaG5UU0RRV3FnOFJZWkh6bzZmV0krTFBtRmRl?=
 =?utf-8?B?VlFhS3Z6bjllOENEaGZ4dWdNYytTMlorbGorcThxYzZzbTVWU2tGQVMvZGhi?=
 =?utf-8?B?Q1BJUTF6TFJKaUhkdWtMbnhCcHg5ZmpaOUJCRysxRVQ0Vk15c2s1TitGcHFY?=
 =?utf-8?B?VlVwcnk4ZUVxc2ZUb2M2endaenZLZmFCUnpSK2xHS1FPdlNLTVlZWEFrSk50?=
 =?utf-8?B?Q1psS2ZqNEd4RW9oZWUrWmlPNjA1dEhhcWpJM0NtVHA0NTZoZGZlUnNtcDN2?=
 =?utf-8?B?MkJiRFJteHF6anJ0aVdKTlI1NTk4RzRrdTU1ays5MWxqQWpLM0ZDNURVWjZJ?=
 =?utf-8?B?VWpsOHA1RlgrY2ZOMUszS2djeDk3Z3FCUzJ2bDdNWlNLMGxoUWF3WXdTZ3Fh?=
 =?utf-8?B?WnNzUlAwWEZsS0xvNWVoRDVOSnpoNG1reHhFU0NkM3FrZ2lPUWVmUG9LeVMv?=
 =?utf-8?B?eTlVdFk3RWFLeFVHZ0VWNExuUjdwZHZBNTRtUEdCSlBVRWozbkFnUW5ZZzJu?=
 =?utf-8?B?b1ljWFlRVDJ0Yy9UcDlLdnMwall2OHFRR0tkemRPSDYzQ2dHZktQMVo3TkMx?=
 =?utf-8?B?cndKMjY4VnluN0s3cGo5VDU0azB3bFlIdWUzeHRHWDJlenlRZXpoSE5tSEVP?=
 =?utf-8?B?YzY0Q1NLbk43VFJBQWNqOEt5Ky9wVUJiZ1U1U2V2Ukd2TytJaFJtY3ZDTXE1?=
 =?utf-8?B?ZlZobm5zbVk4T04yU3EwMFY0Vld2REZZZGZZNkJDditFMEJ2R1hlbExZSGxl?=
 =?utf-8?B?SFI0SldUekh4ZGN1WkQ0Tlk5MlprN1hFRkJBZHkzZTA5c3JobXZHL1l1K1ZP?=
 =?utf-8?B?dE5EWDZqTzRKTzJXWVRIcW1KV2lyMUl5RldlOVZyNXVvZmIwRUZZVjlQanpO?=
 =?utf-8?B?Z0NONEY3TkRYZDdQYjN1bkllaFVoSFI4Vk12RVgrdm5VekdRbnNiM3RzQmRN?=
 =?utf-8?B?b1RuanBEU21tbkhmUzVKeXFhODhBQXk0dU44YW5Qakl3VGdtZyt5Y2xyRnVG?=
 =?utf-8?B?d3MrME5jUG9nRmJUYW5LWTh2Uk9qQUQ2NTBYenRndThuVUpRd2xrdzZEU0k0?=
 =?utf-8?B?ZmUwcVBDNjZOYW1vN3NEMkxzSlRSNWI2aEQ2c1Vzcnpna3lmNU4rV3M3V3dG?=
 =?utf-8?B?cWF3cE5HRDYwZ3NZcXZRdjZveVhyanlQcXpPWitQS1BwbFJaMTRKR3NLWUFy?=
 =?utf-8?B?NVdvaHVWYVVnPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9136.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cnoxRmYvUUQyeGg2YjJ1YklabDdUTkd3ZzhLT1M1bTJGRFdWM1VsMlExeW1x?=
 =?utf-8?B?SXNDRWJTWTQ2dGY1K3pZRnd5UTAxVVZlT0R2aFVRQnFCc3dRTWdFMWZrVHlC?=
 =?utf-8?B?amFidGs3WU9qUXFPSUIxaUtXc3I0N2tsbURaU011V0JkTWNVOTQzSHdid1dT?=
 =?utf-8?B?QndQWFQvdTZVeG1Gb2NDK01CSGpvdjRzRTlSbVRrQkRPKzAvSmpoQ1VHa3F3?=
 =?utf-8?B?SDhGYXd3MGszVXRRdjZpTnFCYTFjQUdKV200dEZiVVAxYXRBN3JSalNVK0pP?=
 =?utf-8?B?cHhlRVJPSFVkNUgzc0R4ZnI1Q09EYVo0LytlMkZERlQ4VG9qZWRvSVI1dlk4?=
 =?utf-8?B?TElYWnowaG4yWU1QZVZZbWRyRkd5aHZyN0Rkdmh4VmhCSmswaGJUUkF0bVBK?=
 =?utf-8?B?cEF4bmNMcEM3TE5GVmgrVy9TbG5NM0kwYXRjR2U1RUNjOHdhYlJ2U3MvdFh1?=
 =?utf-8?B?NUdZckMzOVZzL2VxSExwRnlyYXVZWnk2Q1lQQ1RuWVBQUk5GNmpoUzhzWTBD?=
 =?utf-8?B?UFNOdmp5WW9KRzFvWXpidXFlRzEyNElmSXRJVE5Bd1pZdGM2Yys3bTZLVVN6?=
 =?utf-8?B?SW9JejBmQkhCVFVvTERzeGs3OVpmV2JLRlBqcEFIcWxJZWJaQ3ZqUG9ReWxP?=
 =?utf-8?B?dEI5UU1iZjNFbXpPaEZEZHR6YjBndXVkYVk5SEsydzlnWCtMWldaenRha1Jw?=
 =?utf-8?B?Nlp3QTlZUUZRL1NjMXNBMmRFMjRoTGtsb1VESHZiTWcrRXRXaWNIbndia29X?=
 =?utf-8?B?U1NKaW5VbUZSY2p6NURrcjlWQWRFS1dKaFE4Y2NYaWUvSG4wMmFzbTJMdGQ5?=
 =?utf-8?B?R3NSV3NyREhYVlFpRXFybWY3OWdtSHdiRElVZGRCVjc3eGVQUlF1SERhdWdM?=
 =?utf-8?B?dmdOZzY4YXN1cGg1OG96WmM2djhCMWtzbUZUdkROY0VzMkRPS01uS0FPbGZq?=
 =?utf-8?B?aThGeVA0WTlwVkp2TTlYTkJJQmUra2pKWW9JVUFmenpvejBjb2VwOHZKZGhX?=
 =?utf-8?B?VWtsUFJaV1oxVS9wdlk4dW9GMXh6NFNWSFRIeDhid1Z3Vzh6U2hwYmUvSUZQ?=
 =?utf-8?B?ZFkraGFPUU14VG40bSt4emltc3FxYUlqa00rQ2YxdnRveDdLRmVmWGIzeFZG?=
 =?utf-8?B?cWlDa0V5Tm1veWFhUUxKazc0V3JGZHp3RWk2NWFydXVSdWpwYlZwY3F6d3VU?=
 =?utf-8?B?WmphVVpkYjB6VzZBV1lGck1YSmhlZGh6cnFmaFVMN1FjWWJEWUhaUm9Id1lX?=
 =?utf-8?B?eFVyaU05K0pkQzUzSEdJV0tTZ2o5Q1pvcnk2YkFNcDljZXdKRWJaT3ZYMnNv?=
 =?utf-8?B?bHloOXJOcENaSTRReklzTTVnb1dNc1BUUk9BSHhaRUZObGdTSk1VdDh6aUlU?=
 =?utf-8?B?Q1NFTmdqOGJhamozN3l6QVQ3S1ZSZmxyUWZLcDZLZlhJSjgxL2dYMzdjbkdw?=
 =?utf-8?B?UENKWHlhU3dKNWtmcFJ0NUZQV0NNUHNHeU9xeiswVkM3cnhzTWdUUU9jblFT?=
 =?utf-8?B?Q1I1M2c0WWZWeGhKWDhZQ0p4TTVqR3hSTmp3TWFZVW50OVpKZmxEbTlKY1V3?=
 =?utf-8?B?QTdSWFdPeC9lNnhVMG9qR09OSFVQUEs4cERBek5WQ3VMZGo0cUdVdEZrb0c1?=
 =?utf-8?B?SW1JdU1HY2wvb2hMZVMwaHJDd3FpODMxbElmaHVWNGhnSzRwZzBVc2Uzd3gr?=
 =?utf-8?B?MnMwS3RLb3M2WTJFSktVZFFjbk5uQTF2OXFhS3hXcDc0UTExbHlBVVFyNVZn?=
 =?utf-8?B?MUJ5NGgrU3F3aHBMYTBBTURWeGduTTdPZTNuL2gwTVZaR3NxRFJVaS9ibWIy?=
 =?utf-8?B?UlF1cmZGUlVCeVZWeG5YTnp4UVdYRmpNMXlINVFzR0UzSnBRR2VlMUIyR093?=
 =?utf-8?B?dG9xR1psbjhyMGVuSVpuSGhELzQrYzFaVVdWV1pxdmN0Z1ZSb3ZRbnRPLzFU?=
 =?utf-8?B?L1VkVnhTVnBlSGtoalJVRU41UnlvVFVLNkFCMlRjSzJwTzBoYmVhWTVPOW5t?=
 =?utf-8?B?YVBmTGhUQVYyakF4cExqVXljcmhGc0xMeGZSamtHTU9BL3lMZlk0dVZFbWNm?=
 =?utf-8?B?RW82cVhUbkJvVDBJemtqamYvcGdzdjUyQkN2YUVKaTUwMnhGdjN5K0Z5QTc5?=
 =?utf-8?Q?gDbTFnu+0NtXEGjUZqYFdv5HG?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9136.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a52285a-ec01-413d-505d-08ddb1fc8925
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jun 2025 02:20:34.7142 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yTGubBYCMh1Rs5rnEaU8Mi9a9tjtNAo0ALfEqfUydoWx+YmS6O16BeLGgJdl3TtJq6JckhwQNrUT3aRIG0imVuY1WIpDJtzD95+GqNYIPJQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6956
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.17;
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IEVyaWMgQXVnZXIgPGVyaWMu
YXVnZXJAcmVkaGF0LmNvbT4NCj5TdWJqZWN0OiBSZTogW1BBVENIIHYyIDAzLzE5XSBpbnRlbF9p
b21tdTogSW1wbGVtZW50IGdldF92aW9tbXVfY2FwKCkNCj5jYWxsYmFjaw0KPg0KPkhpIFpoZW56
aG9uZywNCj4NCj5PbiA2LzIwLzI1IDk6MTcgQU0sIFpoZW56aG9uZyBEdWFuIHdyb3RlOg0KPj4g
SW1wbGVtZW50IGdldF92aW9tbXVfY2FwKCkgY2FsbGJhY2sgYW5kIGV4cG9zZSBzdGFnZS0xIGNh
cGFiaWxpdHkgZm9yIG5vdy4NCj4+DQo+PiBWRklPIHVzZXMgaXQgdG8gY3JlYXRlIG5lc3RlZCBw
YXJlbnQgZG9tYWluIHdoaWNoIGlzIGZ1cnRoZXIgdXNlZCB0byBjcmVhdGUNCj4+IG5lc3RlZCBk
b21haW4gaW4gdklPTU1VLiBBbGwgdGhlc2Ugd2lsbCBiZSBpbXBsZW1lbnRlZCBpbiBmb2xsb3dp
bmcgcGF0Y2hlcy4NCj4+DQo+PiBTdWdnZXN0ZWQtYnk6IFlpIExpdSA8eWkubC5saXVAaW50ZWwu
Y29tPg0KPj4gU2lnbmVkLW9mZi1ieTogWmhlbnpob25nIER1YW4gPHpoZW56aG9uZy5kdWFuQGlu
dGVsLmNvbT4NCj4+IC0tLQ0KPj4gIE1BSU5UQUlORVJTICAgICAgICAgICB8ICAxICsNCj4+ICBp
bmNsdWRlL2h3L2lvbW11LmggICAgfCAxNCArKysrKysrKysrKysrKw0KPj4gIGh3L2kzODYvaW50
ZWxfaW9tbXUuYyB8IDEyICsrKysrKysrKysrKw0KPj4gIDMgZmlsZXMgY2hhbmdlZCwgMjcgaW5z
ZXJ0aW9ucygrKQ0KPj4gIGNyZWF0ZSBtb2RlIDEwMDY0NCBpbmNsdWRlL2h3L2lvbW11LmgNCj4+
DQo+PiBkaWZmIC0tZ2l0IGEvTUFJTlRBSU5FUlMgYi9NQUlOVEFJTkVSUw0KPj4gaW5kZXggOTRj
NDA3NjEyNy4uMjc4MTc5NzRhNiAxMDA2NDQNCj4+IC0tLSBhL01BSU5UQUlORVJTDQo+PiArKysg
Yi9NQUlOVEFJTkVSUw0KPj4gQEAgLTIyNzcsNiArMjI3Nyw3IEBAIEY6IGluY2x1ZGUvc3lzdGVt
L2lvbW11ZmQuaA0KPj4gIEY6IGJhY2tlbmRzL2hvc3RfaW9tbXVfZGV2aWNlLmMNCj4+ICBGOiBp
bmNsdWRlL3N5c3RlbS9ob3N0X2lvbW11X2RldmljZS5oDQo+PiAgRjogaW5jbHVkZS9xZW11L2No
YXJkZXZfb3Blbi5oDQo+PiArRjogaW5jbHVkZS9ody9pb21tdS5oDQo+PiAgRjogdXRpbC9jaGFy
ZGV2X29wZW4uYw0KPj4gIEY6IGRvY3MvZGV2ZWwvdmZpby1pb21tdWZkLnJzdA0KPj4NCj4+IGRp
ZmYgLS1naXQgYS9pbmNsdWRlL2h3L2lvbW11LmggYi9pbmNsdWRlL2h3L2lvbW11LmgNCj4+IG5l
dyBmaWxlIG1vZGUgMTAwNjQ0DQo+PiBpbmRleCAwMDAwMDAwMDAwLi4zYzFjMDhmMDVkDQo+PiAt
LS0gL2Rldi9udWxsDQo+PiArKysgYi9pbmNsdWRlL2h3L2lvbW11LmgNCj4+IEBAIC0wLDAgKzEs
MTQgQEANCj4+ICsvKg0KPj4gKyAqIEdlbmVyYWwgdklPTU1VIGNhcGFiaWxpdGllcywgZmxhZ3Ms
IGV0Yw0KPj4gKyAqDQo+PiArICogQ29weXJpZ2h0IChDKSAyMDI1IEludGVsIENvcnBvcmF0aW9u
Lg0KPj4gKyAqDQo+PiArICogU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjAtb3ItbGF0
ZXINCj4+ICsgKi8NCj4+ICsNCj4+ICsjaWZuZGVmIEhXX0lPTU1VX0gNCj4+ICsjZGVmaW5lIEhX
X0lPTU1VX0gNCj4+ICsNCj4+ICsjZGVmaW5lIFZJT01NVV9DQVBfU1RBR0UxICAgIEJJVF9VTEwo
MCkNCj5JIHRoaW5rIHlvdSBzaGFsbCByYXRoZXIgaW50cm9kdWNlIHRoZSBoZWFkZXIgYW5kIHRo
ZSBmaXJzdCBlbnVtIHZhbHVlDQo+aW4gdGhlIHByZXZpb3VzIHBhdGNoLg0KDQpTdXJlLCB3aWxs
IGRvLg0KDQpUaGFua3MNClpoZW56aG9uZw0K

