Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1956EC83F09
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Jul 2025 21:12:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZFGg-0000ha-EP; Tue, 08 Jul 2025 16:50:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uZDxo-0005yu-8o
 for qemu-devel@nongnu.org; Tue, 08 Jul 2025 15:26:50 -0400
Received: from mgamail.intel.com ([198.175.65.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uZDxd-0002IU-DE
 for qemu-devel@nongnu.org; Tue, 08 Jul 2025 15:26:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1752002798; x=1783538798;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=Uthz/KpD6EhpJLNpg9/6etF6oKzPPWVF+CjwGOA4cI4=;
 b=hUaHZLMUbDqK4QopaEhzBuvAnGgFjYDth3QrVmt2wOn+dEcMd2pN/lMZ
 b2RwO6JZkYR69TLYWzlsC068sOyb4EjJSD7YR8TvLNL+FMbnZhM9zjAfX
 asMJ2yFragFPhOZVkSWJgdG/gX58unJ004cHZzQtBaexAzYpu6biQAU1A
 Ho5VGfRV9OvqaHwyTISkVeKshQ9b/AJbeDg71vSK4whIe2yDWabsZFbJG
 ZLNWHDU+VG8s1wDOv018i3d6oFYnt9ed0Ub8JnyOam+AlPNXVngVSz33y
 Gg+P5O8Jll3KlrFxgsoEofZSUqUmKggs97uRmYeqx9fi1g7/3xdSfwCC7 w==;
X-CSE-ConnectionGUID: ZZHQBkl2R3CHyX1e1rrYGw==
X-CSE-MsgGUID: ieUlHPjJR2GK4rxLPufX2Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11487"; a="54297344"
X-IronPort-AV: E=Sophos;i="6.16,296,1744095600"; d="scan'208";a="54297344"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Jul 2025 19:35:21 -0700
X-CSE-ConnectionGUID: RPPqtiDFQY+n5VZVlLaD8g==
X-CSE-MsgGUID: Ja5Cf+qaSIORhwfgJBGA9w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,296,1744095600"; d="scan'208";a="186399465"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Jul 2025 19:35:21 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 7 Jul 2025 19:35:21 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Mon, 7 Jul 2025 19:35:21 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (40.107.237.81)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 7 Jul 2025 19:35:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cpoZXB67fS+WUHY8DDwdKkosx69k5Si6x1GsReJuo4Wa4Sawdt0YYw9nFwQFFnnVEdDZ8kNTk66D8zK1yrFytUPAbLMGSd9SHxS27ObxCA8tY/ZkgECFeoMiFVjI6IWvFvPKx6cRzmCbjYmtW7tgGCq3qg7rvia2APsvi0EwU4GXRCyX6vdsVpvbe1dhVY7o9WMpSQJ3HxZqYv8p0rg6mTSsCn2lHbJrPlxtMiKzqI6EdfHjTLKpYr8yzXlh35SewHt7Pxsn9XQdBXQZUzQ90p1lUi1OomjfksvxRFZPQKYU0XxWH7nlnUxt0XJeAgqY5XzzdqrOl56GfXp5HLrTew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Uthz/KpD6EhpJLNpg9/6etF6oKzPPWVF+CjwGOA4cI4=;
 b=h/Qw6HX3phXqtCqXfLe53/qS0VbZKaNvzxCIdyPCmjDfSz4QD1ihBcPQ44osqyROkR4CN9eptPgFvo/MNYfftxpwET8qvV3gVrYuiHWtUACG8RkV9hdJM5v8kcw3DNXsyuYZRuRpcSSO/H3210zPaK52x9xIAXanGqJCoHL8nqqAjXAijhfxhi6D/GKuty8V6u/ESkZnDv+X2zynUmfyedJXPvcxSnLCRPSgv+AoM/yB8yyM5fMFkeNH4p8/O5O8h59QZUEzL5e+JzhNPn5TH9k1NrWdMBEvt2pfz4elAacacy2lvZPrfiyncpCIf6cwH5Ibc+MzFGIS1Cgaq9CYog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12)
 by PH8PR11MB6854.namprd11.prod.outlook.com (2603:10b6:510:22d::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.25; Tue, 8 Jul
 2025 02:35:18 +0000
Received: from IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13]) by IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13%4]) with mapi id 15.20.8835.023; Tue, 8 Jul 2025
 02:35:18 +0000
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
Subject: RE: [PATCH v2 09/19] intel_iommu: Introduce two helpers
 vtd_as_from/to_iommu_pasid_locked
Thread-Topic: [PATCH v2 09/19] intel_iommu: Introduce two helpers
 vtd_as_from/to_iommu_pasid_locked
Thread-Index: AQHb4bQosuj8+0B4mECFK/DRFdJ0t7QL/2WAgAWe78CAFHHRkIAA7AKAgAChH/A=
Date: Tue, 8 Jul 2025 02:35:18 +0000
Message-ID: <IA3PR11MB9136FDB6C8E9CFA0116A11E7924EA@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <20250620071813.55571-1-zhenzhong.duan@intel.com>
 <20250620071813.55571-10-zhenzhong.duan@intel.com>
 <3babbbd5-23e3-4b6b-9f9c-e879d4ddb125@redhat.com>
 <IA3PR11MB9136359F208103BA9F3DB8F79278A@IA3PR11MB9136.namprd11.prod.outlook.com>
 <IA3PR11MB9136005A33841A077E546E9E924FA@IA3PR11MB9136.namprd11.prod.outlook.com>
 <77e9dcb3-1704-4418-8d6c-b349c02ff2e7@redhat.com>
In-Reply-To: <77e9dcb3-1704-4418-8d6c-b349c02ff2e7@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9136:EE_|PH8PR11MB6854:EE_
x-ms-office365-filtering-correlation-id: 811841e6-357f-4087-92cb-08ddbdc813ff
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|7416014|376014|1800799024|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?SkljamRjNlhSK016NkM3dElvcjJjSUVUcUltZjg3QTRyWWxDd0MrTWtZdmFO?=
 =?utf-8?B?L3JPWTJnU0VIVWRtTHV5RW5xVkxub2NwejZVZ0s1NmtXb2ZyRmpZOGFqKytY?=
 =?utf-8?B?VWJEeDBqSlBNL1B6ZSt3bmFLbWlvOHNsdFh2VmJVWC9qMm5BWnh4VmVHRzZE?=
 =?utf-8?B?L1VRNjY5VUsrWnoweDlueHNVdkNlUDlLRDliVFZTQllUd1BHcVZRV29ueWV1?=
 =?utf-8?B?N0JxQm5BcUtDY245K2lHYlhWMWZlSE9zZFlVYVUrT1N3Z2JCSmlRMnpqb0Nv?=
 =?utf-8?B?ZHFhWTlaZ3pFbVZpS0ZMYlZzeUlpOGh5TG1xckd2Mk5CWXQ0MVlaSCt3MFpl?=
 =?utf-8?B?aVZlT0dTaEF2UDlZR3Uvb1R2TTg4SDJHZFRiNE5XekZyTERpbEJIRGJhWjQy?=
 =?utf-8?B?ZEQ2bWlYZE9HUXN1dkV1dHVPV3h6RHAyTUwyYWpPMXQwV0YwY01uTkozcXhx?=
 =?utf-8?B?T0JWTmFEMndvUzJiV3NXeFNCM3NUajN3TUJaalczclptdC95K3J0dUd0b2Mv?=
 =?utf-8?B?T0J2Y0xENk9mY2p0dThjZm5VWmluci9DWm15RTNVQzhMZWJOR0hkV3dUMVBk?=
 =?utf-8?B?K1oxK2pVb0lxMUxSODhoRWhJWFhjZ1pJMUVVUjlYbGtrelJXbGFienE1eEFq?=
 =?utf-8?B?RzVyNlNXc05lUkFqb1dpT1Ztb3JkOXRCTFFQc0lDU2xsZWYyUUR2dy9mQWRV?=
 =?utf-8?B?VXF0MnJuNjIvN3cvTk5PQXloWFdQNWw4bUovcEtFTXV6ejR3QU12TlZhSWJH?=
 =?utf-8?B?ZlZZS2RQU1c4MjZvZFQwRTVsQ2VuWndmQVRCWTBEblQxTFBwWjQ3UXVoRkhs?=
 =?utf-8?B?bU5Bb015T2VaR2xmQlNMNGRrSnlWbWNTRXdBN0psUlkycHAyclZBN29kSUJv?=
 =?utf-8?B?QmVKdDQzZ0lhS2hGMmFXUlVVSEJGcVFWUmJjdDRsL2lWZzExcGZRS2ttTXMw?=
 =?utf-8?B?NVpkd0E5WVpIc1M2L0FVYmF5Z0FCWTZVd21nTjdJVU9tYTkrS3l2SDJCSzZP?=
 =?utf-8?B?QjhIMUNVN2ZxcTQrbFNmeHM1Zk16T013WkZFcktSRGsxMGlURGRYak52VndU?=
 =?utf-8?B?aldLWE4yR29UclVzZ2JvZ29BOVhsNU5FVWtxZldHaEw1N1hMa041K0ROZXdj?=
 =?utf-8?B?OEI3WFFnSHNYU2pFVE11V09NV0VTMGQ3cVEvN09JaFo4UW0rWWtLb05OcWlV?=
 =?utf-8?B?bHpRd1NRbm1zOFFXR0lkMWRORmFZTWh1bVIvUTNuR1NkYlYvUVJRUzhtRWs4?=
 =?utf-8?B?Q2lqQ0ZySTZsZE9MMkdWcDNvTTdXcEJBVFA1MHpjdU0vOXNab2JOWEwrOEpt?=
 =?utf-8?B?RG5SVC84Y1RZdThwbE5USHNwdTByVDRneUN5YVRTbU12dmhZSHpyZXJoY0sv?=
 =?utf-8?B?NDlJalR3Qy9iNDNDU3l6azUrYk9Ta1hMbmNtQWNNdzVOM3BhWjdFbithbVdK?=
 =?utf-8?B?UTlPZGZRZ2FIelpRUGdFMUVrVUlCTzJ6Qi9hNGd5VGFwL0Q2NHkvOXB6a1ZD?=
 =?utf-8?B?c0xjcVg4MXI3ZTZzR0tmVEhKTFNTVHl3cmQ4clppbTVuaUZ5aWtleWgvR0xT?=
 =?utf-8?B?ZGZwQU9OTzFNeEU4MTlCZWlZeHJIeEFIKy9NVlRvVmUwWnNHanl4ZlJKT05P?=
 =?utf-8?B?Q2pTTllzRUdVVU5YMXlNM3NCWUtmSXRFOFFPUHc0NUxjS0U5dFZkdHpZNWdH?=
 =?utf-8?B?WjlORVV0ZjJsTnhWZGs2MDl4N3FaTUNjakovdUlSNkdPcXRaMTROV3V0OGJm?=
 =?utf-8?B?aEdTelQ4akt3UUN6aXBScElIdGJOdEpWUURsTGwrbFN6WERhNDUwMWxsOVlK?=
 =?utf-8?B?WVplaXJhbVFzSmVJaC9ieWVoOXQzd1djUElrYlBMd2N1QkxEU2h4ZE1JL09a?=
 =?utf-8?B?L3o4VEN2dUZweUx4L1NsQm9IK2Q1YVliNmhYaVNSblIyUkVNSHBZS3p2bXFX?=
 =?utf-8?B?MjdhbXN6R0F5WElMWXpzUXFiUm8xY1RDb1hveUpTeTNnZ1FwMlp1RURpeE9Q?=
 =?utf-8?Q?4Sok0MMTZQEhnBseLPIc+7a7yRRmGQ=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9136.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(376014)(1800799024)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MjcvYkR5N3JaZTJ4UFFadWNXOFRDOXZRVzNWNmZYWVNnVTQ2YWVKR3V2NGZO?=
 =?utf-8?B?YWJPdkIvTzJpMnNtRDk3TWVuMVNrS0ZsemlKUVJvUlR6dTg0Ulk2WXZtajk4?=
 =?utf-8?B?eTAxVVYvVGdmSVdLTzF6MENtcmZ0NG5VYkJ1QVdacnlIVzFwc1RYVDNsc1Uv?=
 =?utf-8?B?cEtTaElQSk5iUGd5anZQeWdtbHFqaW1TYUlzZHJOWjNVQlptNlFMU0RVS2g2?=
 =?utf-8?B?N3czRitjN3FBQWdja3RwZ1ByUDBESWd0S2JBNG5aaW1uU3pEek04RGFoZFNT?=
 =?utf-8?B?ZkJlM2pDbTltampYRzRPdFVGZTlkUzVKY1BmM0dOZzBhaW4yNmZIWnZnR0py?=
 =?utf-8?B?TkFRZ1gvVWpJbGJhRFU3NXE4ckdQWHF3NEczQ0hpRzEvbHI2dnJmY1p4cENn?=
 =?utf-8?B?UVBTdnVnNldSeXQ5SzVtREZnYmNCU3hjK1BUZXBNVVR0Uzg4YlZ1RnR1T1JU?=
 =?utf-8?B?Z2xwaytsWVRsT2hoN1RKRlF3WVFBVkxZNm41TEtYOWJqSzFscGptcXZQZXFF?=
 =?utf-8?B?T1k1UHJKM0ZNRmxuQ0ZPTkxwaGQ5Nkc0cTlNWEZsOGpUU0gveHRkZjVSWWVS?=
 =?utf-8?B?Qmp3TTVlSWtKWEY1Zi9JUjlHV0tiS0VFSjJNVjE0SDRwV05mZnY3aWxBTUph?=
 =?utf-8?B?YVd5RnpGS2RuRmFVTXZZK092aW8vUTM0Y2VjTm5xT01LSG80MCtpSW9PTzdH?=
 =?utf-8?B?TlFYYnZoL3pkRmV2dlBna2FQcUVPVU43OU9iREw5aGN0eWhaRC95YTN5WWxl?=
 =?utf-8?B?VVYrdEFnM1NqSkRYQnhmeXdGbVNLVkM5Y3JzS2QyaDY0aWJHT21ud3dDQ0tW?=
 =?utf-8?B?UWNLc0NnYjhvbXNKenNPeEcwUThxMVNsdCtCYllhc2d3bEU4NUJrNE9nc3V2?=
 =?utf-8?B?VGR1OEY3dXhuZitUWkcvL2FhbU0wYWI1QXRmVTgxTlVXNUpSdU12NkFoQXlK?=
 =?utf-8?B?di9lTi84b1B6aEpBamRDa25kZlZRY3krNk1zM3ZwUTl1bTRPSVdHNkc0a29r?=
 =?utf-8?B?MlR1alYxN0wrZWcrV2Y3N1hvS3YzZFhrRVFlR3hrcUtjT093QkZWNnRjYWZQ?=
 =?utf-8?B?R1o5RDBWWEtuVzBCYi9SOXJqR1U3NDhNQU9COXV6NWN2WVdFL1lETGpwajkx?=
 =?utf-8?B?WTYyejhzcVJoMnFYQU5YS3pxcUl1bHRLdXNGNnlFbjNTQmpQY3poTmRwNW8w?=
 =?utf-8?B?OE5mOEY4SENjY0ROaTgrTUkyYUNqa2dOak1MNVZWeWppZXlzbERZV1lZLzFt?=
 =?utf-8?B?Rko1OVVFdi91dzlta1Y5c0pyU2p5clNVUk0rWTZaQ3hTSDhNNldoTExoeTBQ?=
 =?utf-8?B?ZGc1ZmE2OUVyTTdiVlhDRWxFajNxV1NDTnNLWEFvUzVxbzNlbGxKRHIvVVdL?=
 =?utf-8?B?UnRYaEFTb2hpZ1NKbzQrck5aODVSdjV5T0EwS0RtQkVzaWxYNlllYS9PWWpX?=
 =?utf-8?B?U2VXMVlUMGp3K204REdNRUxoZlVJK0lNRU53TmNJVlU1Q1dYb28zWTJwTmJV?=
 =?utf-8?B?dDFPbmo4SjlCZ1ZpdHB2NU1qM2wrWGY5N2hoZ3RYTnViR2FrUE1waWFsRU9F?=
 =?utf-8?B?OTVMSlNwY3pZTlhvQjVXdUNlaEFWNVRFblA4VkpBUUlWcmtCVDJ1MjJoMzE0?=
 =?utf-8?B?dlIvN0tYaGl1Z0Rrd0pkcHlhR3cyTzNlNmdLSjF4Wkg2RWcydUNVYW1nVjFu?=
 =?utf-8?B?bTRkcnkxVEQ2WEJiYVVpdnB1Y2hpQW82QW1KVzNRSmhESmdrL3kwYW9lc0U5?=
 =?utf-8?B?dWpuTFVXdnhhQzRYK1lxcHo5MGNaRnZucFpUVmF3SWplemVHTVRiY1Z0aE5O?=
 =?utf-8?B?WG5iNTlKTDJyeDdJY0labHQ1bFdGc0RITklNZlJiQ09UakVjc2tha1l4MTFn?=
 =?utf-8?B?QTBOY2dwNHBzelZhK0RhMzV6YVp6SFNyeGV2eEVrWmhWZlFyZTA4NXYrN2xI?=
 =?utf-8?B?MWtEZHROVWNPbHVraVNCeW5QcjJZYmFEZmlyYi82RDhuQThmTFVWbEwvSVhv?=
 =?utf-8?B?ZUpEczBiTUZRWlJqeWpDSCtteWNVK205U202OWtrUjUrT0VkQ1p0Q2RiZ084?=
 =?utf-8?B?MWVmWkdKMTBYMmY4YjNtODI3ZC9DeVA0ZUJTaG9CUExOZHJOWGRhR0JkWVVT?=
 =?utf-8?Q?y56u+o/nmdk08rbKg/D4A+u84?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9136.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 811841e6-357f-4087-92cb-08ddbdc813ff
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2025 02:35:18.2488 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: S7o2jCpxCs4yXREysGNqxZLjQKyTFzXUwO1/G9W6Em4DGV6Dw6/qdh6837XcmeE3iD1y2qjt33m2KAfS5ic/Fzb+kM+C7r+JvNvbPWjcOi8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6854
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.16;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

SGkgRXJpYywNCg0KPi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+RnJvbTogRXJpYyBBdWdl
ciA8ZXJpYy5hdWdlckByZWRoYXQuY29tPg0KPlN1YmplY3Q6IFJlOiBbUEFUQ0ggdjIgMDkvMTld
IGludGVsX2lvbW11OiBJbnRyb2R1Y2UgdHdvIGhlbHBlcnMNCj52dGRfYXNfZnJvbS90b19pb21t
dV9wYXNpZF9sb2NrZWQNCj4NCj5IaSBaaGVuemhvbmcsDQo+DQo+T24gNy83LzI1IDU6MTIgQU0s
IER1YW4sIFpoZW56aG9uZyB3cm90ZToNCj4+IEhpIEVyaWMsDQo+Pg0KPj4+IC0tLS0tT3JpZ2lu
YWwgTWVzc2FnZS0tLS0tDQo+Pj4gRnJvbTogRHVhbiwgWmhlbnpob25nDQo+Pj4gU3ViamVjdDog
UkU6IFtQQVRDSCB2MiAwOS8xOV0gaW50ZWxfaW9tbXU6IEludHJvZHVjZSB0d28gaGVscGVycw0K
Pj4+IHZ0ZF9hc19mcm9tL3RvX2lvbW11X3Bhc2lkX2xvY2tlZA0KPj4+DQo+Pj4NCj4+Pg0KPj4+
PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPj4+PiBGcm9tOiBFcmljIEF1Z2VyIDxlcmlj
LmF1Z2VyQHJlZGhhdC5jb20+DQo+Pj4+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjIgMDkvMTldIGlu
dGVsX2lvbW11OiBJbnRyb2R1Y2UgdHdvIGhlbHBlcnMNCj4+Pj4gdnRkX2FzX2Zyb20vdG9faW9t
bXVfcGFzaWRfbG9ja2VkDQo+Pj4+DQo+Pj4+IEhpIFpoZW56aG9uZywNCj4+Pj4NCj4+Pj4gT24g
Ni8yMC8yNSA5OjE4IEFNLCBaaGVuemhvbmcgRHVhbiB3cm90ZToNCj4+Pj4+IFBDSSBkZXZpY2Ug
c3VwcG9ydHMgdHdvIHJlcXVlc3QgdHlwZXMsIFJlcXVlc3RzLXdpdGhvdXQtUEFTSUQgYW5kDQo+
Pj4+PiBSZXF1ZXN0cy13aXRoLVBBU0lELiBSZXF1ZXN0cy13aXRob3V0LVBBU0lEIGRvZXNuJ3Qg
aW5jbHVkZSBhIFBBU0lEDQo+VExQDQo+Pj4+PiBwcmVmaXgsIElPTU1VIGZldGNoZXMgcmlkX3Bh
c2lkIGZyb20gY29udGV4dCBlbnRyeSBhbmQgdXNlIGl0IGFzDQo+Pj4gSU9NTVUncw0KPj4+Pj4g
cGFzaWQgdG8gaW5kZXggcGFzaWQgdGFibGUuDQo+Pj4+Pg0KPj4+Pj4gU28gd2UgbmVlZCB0byB0
cmFuc2xhdGUgYmV0d2VlbiBQQ0kncyBwYXNpZCBhbmQgSU9NTVUncyBwYXNpZA0KPnNwZWNpYWxs
eQ0KPj4+Pj4gZm9yIFJlcXVlc3RzLXdpdGhvdXQtUEFTSUQsIGUuZy4sIFBDSV9OT19QQVNJRCgt
MSkgPC0+IHJpZF9wYXNpZC4NCj4+Pj4+IEZvciBSZXF1ZXN0cy13aXRoLVBBU0lELCBQQ0kncyBw
YXNpZCBhbmQgSU9NTVUncyBwYXNpZCBhcmUgc2FtZQ0KPnZhbHVlLg0KPj4+Pj4NCj4+Pj4+IHZ0
ZF9hc19mcm9tX2lvbW11X3Bhc2lkX2xvY2tlZCgpIHRyYW5zbGF0ZXMgZnJvbSBCREYraW9tbXVf
cGFzaWQNCj50bw0KPj4+PiB2dGRfYXMNCj4+Pj4+IHdoaWNoIGNvbnRhaW5zIFBDSSdzIHBhc2lk
IHZ0ZF9hcy0+cGFzaWQuDQo+Pj4+Pg0KPj4+Pj4gdnRkX2FzX3RvX2lvbW11X3Bhc2lkX2xvY2tl
ZCgpIHRyYW5zbGF0ZXMgZnJvbSBCREYrdnRkX2FzLT5wYXNpZCB0bw0KPj4+PiBpb21tdV9wYXNp
ZC4NCj4+Pj4+IFNpZ25lZC1vZmYtYnk6IFpoZW56aG9uZyBEdWFuIDx6aGVuemhvbmcuZHVhbkBp
bnRlbC5jb20+DQo+Pj4+PiAtLS0NCj4+Pj4+ICBody9pMzg2L2ludGVsX2lvbW11LmMgfCA1OA0K
Pj4+PiArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrDQo+Pj4+PiAg
MSBmaWxlIGNoYW5nZWQsIDU4IGluc2VydGlvbnMoKykNCj4+Pj4+DQo+Pj4+PiBkaWZmIC0tZ2l0
IGEvaHcvaTM4Ni9pbnRlbF9pb21tdS5jIGIvaHcvaTM4Ni9pbnRlbF9pb21tdS5jDQo+Pj4+PiBp
bmRleCA5ZDRhZGM5NDU4Li44OTQ4YjgzNzBmIDEwMDY0NA0KPj4+Pj4gLS0tIGEvaHcvaTM4Ni9p
bnRlbF9pb21tdS5jDQo+Pj4+PiArKysgYi9ody9pMzg2L2ludGVsX2lvbW11LmMNCj4+Pj4+IEBA
IC0xNjAyLDYgKzE2MDIsNjQgQEAgc3RhdGljIGludA0KPj4+PiB2dGRfZGV2X3RvX2NvbnRleHRf
ZW50cnkoSW50ZWxJT01NVVN0YXRlICpzLCB1aW50OF90IGJ1c19udW0sDQo+Pj4+PiAgICAgIHJl
dHVybiAwOw0KPj4+Pj4gIH0NCj4+Pj4+DQo+Pj4+PiArc3RhdGljIGlubGluZSBpbnQgdnRkX2Fz
X3RvX2lvbW11X3Bhc2lkX2xvY2tlZChWVERBZGRyZXNzU3BhY2UNCj4+PiAqdnRkX2FzLA0KPj4+
Pj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdWludDMy
X3QNCj4+PiAqcGFzaWQpDQo+Pj4+IElzIGl0IG1lYW5pbmdmdWwgdG8gdXNlIGlubGluZSBoZXJl
IGFuZCBiZWxvdz8gQmVsb3cgSSBndWVzcyB5b3UgZG8gc28NCj4+Pj4gdG8gYXZvaWQgImRlZmlu
ZWQgYnV0IG5vdCB1c2VkIiBjb21waWxhdGlvbiBlcnJvciBidXQgSSBkb24ndCB0aGluayBpdA0K
Pj4+PiBzaG91bGQgc3RheSBhcyBpcy4NCj4+PiBZZXMsIHRoYXQncyB0aGUgb25seSByZWFzb24g
SSBkZWZpbmUgdGhlIGJvdGggaW5saW5lLg0KPj4+IERvIHlvdSBoYXZlIG90aGVyIHN1Z2dlc3Rp
b25zIHRvIGF2b2lkIGNvbXBpbGF0aW9uIGVycm9yIGlmIG5vdCB1c2UgaW5saW5lPw0KPj4gSSBm
aW5kIEkgYW0gbm90IGNsZWFyIG9uIGFib3ZlIGNvbW1lbnRzIHlldCwgZG8geW91IGp1c3Qgd2Fu
dCB0byByZW1vdmUNCj5pbmxpbmUgZmxhZz8NCj4+IE1heWJlIG1lcmdpbmcgdGhlIHR3byBoZWxw
ZXJzIHRvIG90aGVyIHBhdGNoZXMgdXNpbmcgdGhlbSB0byBhdm9pZCBpbmxpbmU/DQo+SW4gdGhl
IHBhc3Qgd2hhdCBJIGRpZCBpbiBzdWNoIHNpdHVhdGlvbiBjb25zaXN0ZWQgaW4gaW50cm9kdWNp
bmcgYQ0KPmRlY2xhcmF0aW9uIG9mIHRoZSBzdGF0aWMgZnVuY3Rpb24gYmVmb3JlIGl0cyBkZWZp
bml0aW9uIGFuZCB3aGVuIHRoZQ0KPmFjdHVhbCB1c2VyIGlzIGludHJvZHVjZWQsIGluIGEgc3Vi
c2VxdWVudCBwYXRjaCwgcmVtb3ZlIHRoZSBzcHVyaW91cw0KPmRlY2xhcmF0aW9uLg0KPk5vdywg
cmVhZGluZw0KPmh0dHBzOi8vd3d3LnJlZGRpdC5jb20vci9jcHBfcXVlc3Rpb25zL2NvbW1lbnRz
LzE1a2ZpamUvaG93X3RvX2RlY2lkZQ0KPl9pZl9hX2Z1bmN0aW9uX3Nob3VsZF9iZV9pbmxpbmVf
b3IvLA0KPm1heWJlIGFkZGluZyB0aGUgaW5saW5lIGhlcmUgaXMgbm90IGEgcHJvYmxlbSBnaXZl
biB0aGUgY29tcGlsZXIgbWF5IG9yDQo+bWF5IG5vdCBpbmxpbmUgdGhlIGZ1bmN0aW9uLg0KDQpU
aGFua3MgZm9yIHRoZSBsaW5rLCB0aGlzIHJlZnJlc2hlcyBteSB1bmRlcnN0YW5kaW5nIHRvIGlu
bGluZS4NCg0KQlJzLA0KWmhlbnpob25nDQo=

