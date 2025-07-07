Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70360C83F0D
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Jul 2025 03:13:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uYcHV-0006Y6-JR; Sun, 06 Jul 2025 23:12:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uYcHS-0006Wg-EJ
 for qemu-devel@nongnu.org; Sun, 06 Jul 2025 23:12:35 -0400
Received: from mgamail.intel.com ([198.175.65.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uYcHQ-0006L3-2G
 for qemu-devel@nongnu.org; Sun, 06 Jul 2025 23:12:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1751857952; x=1783393952;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=3v04slb4r0Zq8a2K0n1rA/Q6iY3wUGUkMYcOHLldj4A=;
 b=RSt2JE/68v9sLGtDwjYCt/uS+tEl9XRF/oZMrVKSDWAtjdpk2+UzSSrO
 6ouSgoPUNXyYQ06qTuPpJZd8dqQ78IDs7ZBGkq33aTrxEvGIcTIclDknt
 WiV+bdlgi9aosFGmhzBWrvssHcw2VybnETopfhTYo2rFzdATE/KEtXbGS
 K0wsNnCUVP+IMTbJ3dOGCt2r+QmoR6jKtq1qHz4RVwsyFciKREFGus3bB
 oWVioCsSP1UgaacxGNycXrk9Rb7a8vUOLk3x9iq3JU2R1u7ChAYku3/+2
 6U+E1hr5Zn2RaZjO826Y3b3j3zCXZAjS2ysPvpKK0FtWn+tGi81v5RcBQ w==;
X-CSE-ConnectionGUID: rMI7oKTDRj+TI5Q9dMgtCQ==
X-CSE-MsgGUID: IdyGEqTWR2OHfGKl0rIN8g==
X-IronPort-AV: E=McAfee;i="6800,10657,11486"; a="76620250"
X-IronPort-AV: E=Sophos;i="6.16,293,1744095600"; d="scan'208";a="76620250"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Jul 2025 20:12:28 -0700
X-CSE-ConnectionGUID: gX4Ui5vFQtyJernWomjBVQ==
X-CSE-MsgGUID: yGIxVU1RSNmOzxb/CeWxzA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,293,1744095600"; d="scan'208";a="192287040"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Jul 2025 20:12:28 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Sun, 6 Jul 2025 20:12:27 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Sun, 6 Jul 2025 20:12:27 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (40.107.244.50)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Sun, 6 Jul 2025 20:12:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vLHrYacH4CoNDDc+BRZQf1w76cU9Z9nZl2z/jGIz1ISI3QM/f7kRKha+A29r11wJ/1bWxgkvVQsWuUhaZ2Iy5f9Zc0pnXimy9ToVeuKdxWJ7YzEi0jBpnuU62hNE72YX8IoP4WkdQ9orJhJ8PXcnnuZICSmNHLDBZXX/mAFIjNifFOF+Fi+87C4LBhrBnccoeRG8EPYmxnnCb8MOQkF6BzxT3cNcRi8e9DXwKmsQKQt6NagstYLAurBItq2GbiTh61IZzxkaEt0oeza1HXUkdbm9Kad7CRtnrR3uaPrxzpKLMfBblLLkEWkqzZnWl79aTqkR4mEnEjQ5IYjJzjH9NQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3v04slb4r0Zq8a2K0n1rA/Q6iY3wUGUkMYcOHLldj4A=;
 b=uE4WWcIoKef1iEYKZRly82PVlhjY3jaoZhnvyOEJ2B8WPYOVN98PBrE+DeaRVSg7VLGIZGUKFRAKan4GDpaURp7ckaYT5qtPlaA9/jA+VxcWrVPqNeG6/Z4+5x+DTWaJ/ZGySun8OgB0CD764HQhiEftnCwSVquiaVIgsm6gCjIhd2hYzfv+R11HkrVKMn+uEtMH/IoOt+jwVvCB7ELHB+rQqwbHUY13QQ7/TFNWUikX+Sekn3O1wj+GWuNeSxKy6U04MWYXT0Vyg52gmY4635tMfLh7bPIl7iUeclzT6PcUZNPvpxOmXDPeeCmNnrnbix3gYWhr4nhEbgORcpJ+jA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12)
 by CYXPR11MB8663.namprd11.prod.outlook.com (2603:10b6:930:da::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.23; Mon, 7 Jul
 2025 03:12:24 +0000
Received: from IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13]) by IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13%4]) with mapi id 15.20.8835.023; Mon, 7 Jul 2025
 03:12:24 +0000
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
Thread-Index: AQHb4bQosuj8+0B4mECFK/DRFdJ0t7QL/2WAgAWe78CAFHHRkA==
Date: Mon, 7 Jul 2025 03:12:24 +0000
Message-ID: <IA3PR11MB9136005A33841A077E546E9E924FA@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <20250620071813.55571-1-zhenzhong.duan@intel.com>
 <20250620071813.55571-10-zhenzhong.duan@intel.com>
 <3babbbd5-23e3-4b6b-9f9c-e879d4ddb125@redhat.com>
 <IA3PR11MB9136359F208103BA9F3DB8F79278A@IA3PR11MB9136.namprd11.prod.outlook.com>
In-Reply-To: <IA3PR11MB9136359F208103BA9F3DB8F79278A@IA3PR11MB9136.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9136:EE_|CYXPR11MB8663:EE_
x-ms-office365-filtering-correlation-id: 7649d865-becb-4578-a4dc-08ddbd04183b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|7416014|1800799024|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?QUdCUGtuQis2cG1uaHZ1Y0NjYWc0ekFPNlM2d1Rqb1V5Yzc2bTY0S2tKWTdm?=
 =?utf-8?B?YkhBTFlrTWkzQ0ZFNVJnQ2ZUUjB3SGVzTmtucWpabm40MC9CLzIySTZVZmhM?=
 =?utf-8?B?R1pKTytSRU5LWVRjUitZRnJSNjRLMktpUFV2Njhxc3F3K0NiNUFaQm5hL2hz?=
 =?utf-8?B?WXlqYzJZcFJUL3haYTVYOUg0SWRhU3FGaTlRbzFjQnpaeVFlSWczdVJZWEZU?=
 =?utf-8?B?d0V0ZlN5Z3laQ0lNZnZrNzhzZzJzalBxMzd6b1lCYzd2U3Q3UzZuZWxraFRu?=
 =?utf-8?B?TVpVbEtBMjlSclpxRUZSMnd3bXpWUWpscE9ockpwaWhidVZidEQ1NlFIMTRk?=
 =?utf-8?B?V2ZrWk0rUTFQaXZ3bFFMckRsRHA1T3EwS0t4K1dhNzJkV1JsUEJWYm45czFl?=
 =?utf-8?B?Znh1MTZ0WW5Fa1dKazg2U0IvdXBQaWI1Q29KaDJROVNPTVhOQ2FuOERObDdJ?=
 =?utf-8?B?bWNOWHRNbFBKTHN5ZXJLWDd1QnFLTEdTU0RxZ3NqME9ER2Y4SjJBTUt5Vlhl?=
 =?utf-8?B?dHNpN2htUUJ3S0ZWNXdJWGJ2dVBoVFJZZ3JuWk5maDdDMlg3WmE2V0U1eFNX?=
 =?utf-8?B?c2hURGJhNDAvU0FaZFNGWjZVaXJBMURWaUE3REdqYXYzelFDRHB3THYrQW5M?=
 =?utf-8?B?aWk4T3B2aEtoQWFzNW1QT3NzTFJ6M1FxWVYrMVZRMHZDTGlrR1hJK2taQnpy?=
 =?utf-8?B?MEVRa3pNZFlSY3pYVlgyRHh0RzZ2VkpZL2Nud3psZ1dwaU1GY2xEUG5iaXAv?=
 =?utf-8?B?akswNnByZEhxcnpSb0NtWTZBSmNGcUxOZmNRRk9velRnZ2tKK1U1VlVjTGlu?=
 =?utf-8?B?RlNxb1d1RFlsbThwZmRGa1J0a1BKVVRqNW0waHFGQVUwcnRNd21Kb1dleDlp?=
 =?utf-8?B?YlQxZzVSVGlGUFROdFlucXdZUmRQQkcrVEsyY3BCTThiQ1ZSQWJDWGJYWDg3?=
 =?utf-8?B?VE5GMjJjdTBRTkpkMGY4YXErYzZUV3B2Uy9WKzBKdUpXQytNMlFhbWNVZExl?=
 =?utf-8?B?dFNXdXZsWko0Q0Nxb0hsb1l0SGV0Qi9PZkxJc2FiWjh4bWNHVDU4b291SWhk?=
 =?utf-8?B?VDZJdmxwa3pGek1HN0pMbnh5QVNnbzk0NTU5UkdWd2hvSG1ueU1tditXK2FV?=
 =?utf-8?B?S3Y2ZDcxZnRCcEZOSmJxakV1NEsyYTd0N1ZEK1F3dzNDNEVQMzlleDJqTXZo?=
 =?utf-8?B?YjNwdzBKUGpVWDVvN2lUaWd1ZG9UbGF2Z0VwTmU1Q0RLZmhYVFlzNDJrVnFI?=
 =?utf-8?B?QVF3K1NDV0NjT1NCNWdZTTFzN3o1VlEyZmM0MEVob3kyMG5JUDZraTEyYjlE?=
 =?utf-8?B?Y1grdjFtL3VTQVo1T01FcHc0UmgwSjI1b2xFMTBCK2w4aHduWHgza2Zwa2Ju?=
 =?utf-8?B?NTJabnpXMUNTT0F1YkkzbE1Va1V6V0RHbW1DT0Q5MmczYWw0YU5rVGljR296?=
 =?utf-8?B?M3NxaFFuZ2VSVFY1MzhZY3RRc0V6R0hvNis0Y3VGYlhsWXovNUFvVnNzVGZQ?=
 =?utf-8?B?VWVyUWNTZFplemx2bnhSbklDTnBKcEYxRnZCcjhWckl0bitRbzRORFNqZjVJ?=
 =?utf-8?B?K2YwRmUvQVgvL2hqcWpveTNlMjJJeGpBTUZwek1xRkIzNnovbm9YOXNrVEpi?=
 =?utf-8?B?dGQreWNJaFlsakJhUUV0amZNNDNGRWNsQVY0aDVidlJaK2RwWVp5SXphVE9R?=
 =?utf-8?B?MUlOSkZsZHFFczdYYU95TS9oY05LSHlDZ2xhTU1xWUttSXFQMlNTbzJraUxz?=
 =?utf-8?B?TzBaN2NLSjNPWU1VNkxsYnFCTnAvSkpNZnJRQVVxclRkZWkwcFVlRTZ6UXJn?=
 =?utf-8?B?eHJ3L1N4ZVJjdzVQYUh0WC9HditGOVBkM0t3dGhVWUQzYW1heVc2RnEvWk5x?=
 =?utf-8?B?WTRQM01QbU9WS3hudjFxOGxHV3NEd1Z3M0QxeFJkUCtza1pzWUVpckdwR0xH?=
 =?utf-8?B?bjc4dndaSFhDUTgrZjRwZkpnak5kdHgreHFXU1lEaHdVeERBRGNReHZaN2dn?=
 =?utf-8?B?cDRVNzZpTThnPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9136.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(1800799024)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZGh5U0NsekVXUlBSbjFZMmlQRDlnZkl0VnErMStlY3dIRk1vVXYveDdNRENp?=
 =?utf-8?B?NmpMRkJiV20vQ3ZWSjR2UW1GV0RRaERGUHhTY2lubnFRWkFOK1ludytKeHRB?=
 =?utf-8?B?OVFXS0JyaXp3SitFTE9jbFVYQXJMdGtjSHpWaXpFam8xTEpTNDNRLzNhbUxx?=
 =?utf-8?B?Z0pLNjhDM241Tjd3c0VGeldvRzlsRlBzdEhMK1U4YWN5TFprbklnNzM2YU0z?=
 =?utf-8?B?QkZyZWhmK2N2bHRGNjBkOXBSaHMxNlJKZVg2OFdrTnc1bEVwTmxBblRrNEpu?=
 =?utf-8?B?VUJWaitaSjR5Yk5QUG5xU21INWcrcjk4TE1BcXpBVnhOYlVFc0dBS2phN0Ri?=
 =?utf-8?B?SFQzaFN6ajQ5VkFNUWRYMHdiTmJmdFQyekF2U3ZhT3FsUHRJQ0xoc053czdM?=
 =?utf-8?B?MlNNdVQraWp1dHhuNVB4U3hJTkw2ZEtrOUxHTDdPdjd6QitsMTVlRG1DaFpJ?=
 =?utf-8?B?c05HK3dnYWRzb1dPUVRteDZNaCtTeEJWdDRSUEo3ZW9wQm1zTXJkR21leUZt?=
 =?utf-8?B?R2pwK2huRXdtVDNNZllhNGZ5T1BDelVGQytIWUgvVGU2YnpUZWpZSkhsTFQ2?=
 =?utf-8?B?NCttVGZQOTZKdm9sM3B6Y2o3SG9KWFBzMEdNWEE5dXJkWFZQZlNUdXgwRG1i?=
 =?utf-8?B?Tzl5OUhvZXBGcUoySm5jaTVpWmNSOEJFemZKU29sbkZ3b2F6dUpnRE9kb2k3?=
 =?utf-8?B?QVdRaVhYTDBpaHVnRXVISk9Ga2FGUzdpVG1VVVNSR3A0VlRZdk1vb3VqY1o5?=
 =?utf-8?B?VmFWRG9aYUptU0xRWDByK1kyQWFZTHZTbGhVTjlTRExCN3NRVkVLemlSbUlT?=
 =?utf-8?B?VFd0TWNTTE1BUFE2TE9laEZsVGQxWHIrM2NFWmJ6OTR4SmxiU1JISm1selZh?=
 =?utf-8?B?aUFtTG9rcjlmZURFQU42bkJUWWR1NWVUYlE0cllOVkVhbXZKUjZLb0lZeUx1?=
 =?utf-8?B?MmF5QjVnejJvcU1mQkd0NzI3N0Q5UXBrNUg4cmxXZXl0UDBVL29aenZBb243?=
 =?utf-8?B?KzVHTDBWcGhGSy9HUERwUi8xMWMyR3FtSU1HRmtjTWYxTytJOVNXMUNDbmgy?=
 =?utf-8?B?OE5EWitVT3Y0WU9Meks5UC8vSFBUMndUNmQrQnhtZlJNKy9SSFVpZUlsTXBt?=
 =?utf-8?B?NmdHcGlRSGkraGg2M2hZeVpraFlBL1FHZWZRMXMxK2JwR0N4UzdlWGtKdlpF?=
 =?utf-8?B?b3JLaXJJMkdValFkS2NJOUVEWU5vQng2YWYxallRNEViQ3JZTXRWSnlZODVn?=
 =?utf-8?B?d0lXeGQ0NzlLTE80UkFNaU5iWTV3Z0svTlVYYUJScE9yYmpnelBua2V6amZq?=
 =?utf-8?B?YVdGbHJaZHR2T1owYXdrVjQ0cDhicUl4THd5Vk1qSjhqamZldFRWZUlvVVFn?=
 =?utf-8?B?L3NXMXA5enRsdGRGZDM0UXY4TGltdG50NlJiV05ScnhucVVNWEVxL0lLUDQw?=
 =?utf-8?B?RlNTYnBObFY3czl6WGNaL0lEVWtHRXVvWmRTRmd1RWhxMlBGc0tObHJtVmdw?=
 =?utf-8?B?UEdiSEYxNHZic0ljVTg0dEVuVUlROUNvSHVEdGtSVmd6ck5JZlp5RjEyL3I4?=
 =?utf-8?B?d3dVSndOZTlhYm5DK25kT09OakV6WFpoZVJyV2ltTk5yVmM0c0x6ekxVVXpC?=
 =?utf-8?B?a0N4eUR5V2RINGdqa3FwZmlSREFIVG9tZDl5N0RmVEwwbjYvNzZCY2FyTmNt?=
 =?utf-8?B?MTFIOEVQVzlyT2tiVzFPRC9RU0gxc2pFc0Q1TmNySFgrS3BEMStoWDdSN0xY?=
 =?utf-8?B?ekgvV2JPQWJaZFF6THZuUjN6UGtoeVJsQlk4Z2FvYTlCNWpvM0ZtbFdkWG9z?=
 =?utf-8?B?UTJqRTJBNDBNMHMvRFhETXYxTS9jUjh6MzAzckswSHZnWXpPUXZlbjRublJQ?=
 =?utf-8?B?dWI1U1ZqOFRhT1Y0SXZQR20zRWFzdkxySUp1RFZGL2YzWS91eE1wNmlRZVVX?=
 =?utf-8?B?NnBIRStXNFozZFdZU2JGMUF4bVE2end5WDdsTmtPaFBnb2FubkY5c08vMTZ5?=
 =?utf-8?B?UVEyZVVQTGtvQXZLSms2MEpINVpFVkJQVUZTbVJhS1VhUittYzQrN2VMem1N?=
 =?utf-8?B?U1MwMENubzNVb1lJM3ZYM1JXMWQ2WXN0SW9UdHJBR2pmbGJraDlLRmtSaWJl?=
 =?utf-8?Q?C2eFYbxZLqBXX7mBgjkDazBJL?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9136.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7649d865-becb-4578-a4dc-08ddbd04183b
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jul 2025 03:12:24.0214 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kbOotS946raUBN1otZVKmpTSw3VHddGSz9gy/2kCm/rh093sBnOGl0PklMvqTPnlhQlQbu4uaMsJk5p5j1GMz10rXA2QIJI3gZJNIL8MwxM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR11MB8663
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.9;
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

SGkgRXJpYywNCg0KPi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+RnJvbTogRHVhbiwgWmhl
bnpob25nDQo+U3ViamVjdDogUkU6IFtQQVRDSCB2MiAwOS8xOV0gaW50ZWxfaW9tbXU6IEludHJv
ZHVjZSB0d28gaGVscGVycw0KPnZ0ZF9hc19mcm9tL3RvX2lvbW11X3Bhc2lkX2xvY2tlZA0KPg0K
Pg0KPg0KPj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPj5Gcm9tOiBFcmljIEF1Z2VyIDxl
cmljLmF1Z2VyQHJlZGhhdC5jb20+DQo+PlN1YmplY3Q6IFJlOiBbUEFUQ0ggdjIgMDkvMTldIGlu
dGVsX2lvbW11OiBJbnRyb2R1Y2UgdHdvIGhlbHBlcnMNCj4+dnRkX2FzX2Zyb20vdG9faW9tbXVf
cGFzaWRfbG9ja2VkDQo+Pg0KPj5IaSBaaGVuemhvbmcsDQo+Pg0KPj5PbiA2LzIwLzI1IDk6MTgg
QU0sIFpoZW56aG9uZyBEdWFuIHdyb3RlOg0KPj4+IFBDSSBkZXZpY2Ugc3VwcG9ydHMgdHdvIHJl
cXVlc3QgdHlwZXMsIFJlcXVlc3RzLXdpdGhvdXQtUEFTSUQgYW5kDQo+Pj4gUmVxdWVzdHMtd2l0
aC1QQVNJRC4gUmVxdWVzdHMtd2l0aG91dC1QQVNJRCBkb2Vzbid0IGluY2x1ZGUgYSBQQVNJRCBU
TFANCj4+PiBwcmVmaXgsIElPTU1VIGZldGNoZXMgcmlkX3Bhc2lkIGZyb20gY29udGV4dCBlbnRy
eSBhbmQgdXNlIGl0IGFzDQo+SU9NTVUncw0KPj4+IHBhc2lkIHRvIGluZGV4IHBhc2lkIHRhYmxl
Lg0KPj4+DQo+Pj4gU28gd2UgbmVlZCB0byB0cmFuc2xhdGUgYmV0d2VlbiBQQ0kncyBwYXNpZCBh
bmQgSU9NTVUncyBwYXNpZCBzcGVjaWFsbHkNCj4+PiBmb3IgUmVxdWVzdHMtd2l0aG91dC1QQVNJ
RCwgZS5nLiwgUENJX05PX1BBU0lEKC0xKSA8LT4gcmlkX3Bhc2lkLg0KPj4+IEZvciBSZXF1ZXN0
cy13aXRoLVBBU0lELCBQQ0kncyBwYXNpZCBhbmQgSU9NTVUncyBwYXNpZCBhcmUgc2FtZSB2YWx1
ZS4NCj4+Pg0KPj4+IHZ0ZF9hc19mcm9tX2lvbW11X3Bhc2lkX2xvY2tlZCgpIHRyYW5zbGF0ZXMg
ZnJvbSBCREYraW9tbXVfcGFzaWQgdG8NCj4+dnRkX2FzDQo+Pj4gd2hpY2ggY29udGFpbnMgUENJ
J3MgcGFzaWQgdnRkX2FzLT5wYXNpZC4NCj4+Pg0KPj4+IHZ0ZF9hc190b19pb21tdV9wYXNpZF9s
b2NrZWQoKSB0cmFuc2xhdGVzIGZyb20gQkRGK3Z0ZF9hcy0+cGFzaWQgdG8NCj4+aW9tbXVfcGFz
aWQuDQo+Pj4NCj4+PiBTaWduZWQtb2ZmLWJ5OiBaaGVuemhvbmcgRHVhbiA8emhlbnpob25nLmR1
YW5AaW50ZWwuY29tPg0KPj4+IC0tLQ0KPj4+ICBody9pMzg2L2ludGVsX2lvbW11LmMgfCA1OA0K
Pj4rKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrDQo+Pj4gIDEgZmls
ZSBjaGFuZ2VkLCA1OCBpbnNlcnRpb25zKCspDQo+Pj4NCj4+PiBkaWZmIC0tZ2l0IGEvaHcvaTM4
Ni9pbnRlbF9pb21tdS5jIGIvaHcvaTM4Ni9pbnRlbF9pb21tdS5jDQo+Pj4gaW5kZXggOWQ0YWRj
OTQ1OC4uODk0OGI4MzcwZiAxMDA2NDQNCj4+PiAtLS0gYS9ody9pMzg2L2ludGVsX2lvbW11LmMN
Cj4+PiArKysgYi9ody9pMzg2L2ludGVsX2lvbW11LmMNCj4+PiBAQCAtMTYwMiw2ICsxNjAyLDY0
IEBAIHN0YXRpYyBpbnQNCj4+dnRkX2Rldl90b19jb250ZXh0X2VudHJ5KEludGVsSU9NTVVTdGF0
ZSAqcywgdWludDhfdCBidXNfbnVtLA0KPj4+ICAgICAgcmV0dXJuIDA7DQo+Pj4gIH0NCj4+Pg0K
Pj4+ICtzdGF0aWMgaW5saW5lIGludCB2dGRfYXNfdG9faW9tbXVfcGFzaWRfbG9ja2VkKFZUREFk
ZHJlc3NTcGFjZQ0KPip2dGRfYXMsDQo+Pj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgdWludDMyX3QNCj4qcGFzaWQpDQo+PklzIGl0IG1lYW5pbmdmdWwg
dG8gdXNlIGlubGluZSBoZXJlIGFuZCBiZWxvdz8gQmVsb3cgSSBndWVzcyB5b3UgZG8gc28NCj4+
dG8gYXZvaWQgImRlZmluZWQgYnV0IG5vdCB1c2VkIiBjb21waWxhdGlvbiBlcnJvciBidXQgSSBk
b24ndCB0aGluayBpdA0KPj5zaG91bGQgc3RheSBhcyBpcy4NCj4NCj5ZZXMsIHRoYXQncyB0aGUg
b25seSByZWFzb24gSSBkZWZpbmUgdGhlIGJvdGggaW5saW5lLg0KPkRvIHlvdSBoYXZlIG90aGVy
IHN1Z2dlc3Rpb25zIHRvIGF2b2lkIGNvbXBpbGF0aW9uIGVycm9yIGlmIG5vdCB1c2UgaW5saW5l
Pw0KDQpJIGZpbmQgSSBhbSBub3QgY2xlYXIgb24gYWJvdmUgY29tbWVudHMgeWV0LCBkbyB5b3Ug
anVzdCB3YW50IHRvIHJlbW92ZSBpbmxpbmUgZmxhZz8NCk1heWJlIG1lcmdpbmcgdGhlIHR3byBo
ZWxwZXJzIHRvIG90aGVyIHBhdGNoZXMgdXNpbmcgdGhlbSB0byBhdm9pZCBpbmxpbmU/DQoNCklm
IEkgbWlzdW5kZXJzdG9vZCwgY291bGQgeW91IHNoYXJlIG1vcmUgbGlnaHQgb24gd2hhdCBjaGFu
Z2VzIHlvdSB3YW50IHRoaXMgcGllY2Ugb2YgY29kZSB0byBoYXZlPw0KDQpUaGFua3MNClpoZW56
aG9uZw0KDQo+DQo+Pg0KPj5JIGRvbid0IHJlYWxseSB1bmRlcnN0YW5kIHRoZSBpb21tdV9wYXNp
ZCB0ZXJtaW5vbG9neS4gRWl0aGVyIGl0IGlzIGENCj4+cGFzaWQgcGFzc2VkIHRocm91Z2ggdGhl
IFBDSSB0cmFuc2FjdGlvbiBvciBpdCBpcyB0aGUgZGVmYXVsdCBwYXNpZA0KPj5mb3VuZCBpbiBy
aWQycGFzc2lkIGNlIGZpZWxkLiBTbyB0aGF0J3MgYSBwYXNpZCBib3RoIHdheXMgOy0pIGNhbid0
IHlvdQ0KPj5zaW1wbHkgY2FsbCBpdCBwYXNpZC4NCj4NCj5ZZXMsIFBDSSBzaWRlIHdlIGNhbGwg
aXQganVzdCBwYXNpZCwgdGhlIG90aGVyIHNpZGUgSSBuYW1lIGl0IGlvbW11IHBhc2lkIHRvDQo+
ZGlzdGluZ3Vpc2guDQo+RG9lcyB0aGF0IHdvcmsgZm9yIHlvdT8NCj4NCj4+PiArew0KPj4+ICsg
ICAgVlREQ29udGV4dENhY2hlRW50cnkgKmNjX2VudHJ5ID0gJnZ0ZF9hcy0+Y29udGV4dF9jYWNo
ZV9lbnRyeTsNCj4+PiArICAgIEludGVsSU9NTVVTdGF0ZSAqcyA9IHZ0ZF9hcy0+aW9tbXVfc3Rh
dGU7DQo+Pj4gKyAgICB1aW50OF90IGJ1c19udW0gPSBwY2lfYnVzX251bSh2dGRfYXMtPmJ1cyk7
DQo+Pj4gKyAgICB1aW50OF90IGRldmZuID0gdnRkX2FzLT5kZXZmbjsNCj4+PiArICAgIFZURENv
bnRleHRFbnRyeSBjZTsNCj4+PiArICAgIGludCByZXQ7DQo+Pj4gKw0KPj4+ICsgICAgaWYgKGNj
X2VudHJ5LT5jb250ZXh0X2NhY2hlX2dlbiA9PSBzLT5jb250ZXh0X2NhY2hlX2dlbikgew0KPj4+
ICsgICAgICAgIGNlID0gY2NfZW50cnktPmNvbnRleHRfZW50cnk7DQo+Pj4gKyAgICB9IGVsc2Ug
ew0KPj4+ICsgICAgICAgIHJldCA9IHZ0ZF9kZXZfdG9fY29udGV4dF9lbnRyeShzLCBidXNfbnVt
LCBkZXZmbiwgJmNlKTsNCj4+PiArICAgICAgICBpZiAocmV0KSB7DQo+Pj4gKyAgICAgICAgICAg
IHJldHVybiByZXQ7DQo+Pj4gKyAgICAgICAgfQ0KPj4+ICsgICAgfQ0KPj5pZiB0aGUgYWJvdmUg
cGF0dGVybiBpcyB1c2VkIGF0IG1hbnkgbG9jYXRpb25zIEkgc3RpbGwgdGhpbmsgaXQgbWF5IGJl
DQo+PnZhbHVhYmxlIHRvIGhhdmUgYSBfbG9ja2VkIGhlbHBlci4NCj4NCj5Ob3QgZ2V0LCBib3Ro
IHZ0ZF9hc190b19pb21tdV9wYXNpZF9sb2NrZWQoKSBhbmQNCj52dGRfYXNfZnJvbV9pb21tdV9w
YXNpZF9sb2NrZWQoKQ0KPmFyZSBhbHJlYWR5IF9sb2NrZWQgaGVscGVyLCBpc24ndCBpdD8NCj4N
Cj5EbyB5b3UgbWVhbiBhZGRpbmcgYSBjb21tZW50IHNheWluZyAiQ2FsbGVyIG9mIHRoaXMgZnVu
Y3Rpb24gc2hvdWxkIGhvbGQNCj5pb21tdV9sb2NrLiINCj4NCj4+PiArDQo+Pj4gKyAgICAvKiBU
cmFuc2xhdGUgdG8gaW9tbXUgcGFzaWQgaWYgUENJX05PX1BBU0lEICovDQo+Pj4gKyAgICBpZiAo
dnRkX2FzLT5wYXNpZCA9PSBQQ0lfTk9fUEFTSUQpIHsNCj4+PiArICAgICAgICAqcGFzaWQgPSBW
VERfQ0VfR0VUX1JJRDJQQVNJRCgmY2UpOw0KPj4+ICsgICAgfSBlbHNlIHsNCj4+PiArICAgICAg
ICAqcGFzaWQgPSB2dGRfYXMtPnBhc2lkOw0KPj4+ICsgICAgfQ0KPj4+ICsNCj4+PiArICAgIHJl
dHVybiAwOw0KPj4+ICt9DQo+Pj4gKw0KPj4+ICtzdGF0aWMgZ2Jvb2xlYW4gdnRkX2ZpbmRfYXNf
Ynlfc2lkX2FuZF9pb21tdV9wYXNpZChncG9pbnRlciBrZXksDQo+Z3BvaW50ZXINCj4+dmFsdWUs
DQo+Pj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IGdwb2ludGVyDQo+dXNlcl9kYXRhKQ0KPj4+ICt7DQo+Pj4gKyAgICBWVERBZGRyZXNzU3BhY2Ug
KnZ0ZF9hcyA9IChWVERBZGRyZXNzU3BhY2UgKil2YWx1ZTsNCj4+PiArICAgIHN0cnVjdCB2dGRf
YXNfcmF3X2tleSAqdGFyZ2V0ID0gKHN0cnVjdCB2dGRfYXNfcmF3X2tleQ0KPiopdXNlcl9kYXRh
Ow0KPj53aHkgdGFyZ2V0PyBjYW4ndCB5b3UgbmFtZSBpdCBrZXkgaW5zdGVhZD8NCj4NCj5UaGVy
ZSBpcyBhbHJlYWR5IGEgcGFyYW1ldGVyIG5hbWVkIGtleSwgbWF5YmUgdGFyZ2V0X2tleT8NCj4N
Cj5UaGFua3MNCj5aaGVuemhvbmcNCj4NCj4+PiArICAgIHVpbnQxNl90IHNpZCA9IFBDSV9CVUlM
RF9CREYocGNpX2J1c19udW0odnRkX2FzLT5idXMpLA0KPnZ0ZF9hcy0+ZGV2Zm4pOw0KPj4+ICsg
ICAgdWludDMyX3QgcGFzaWQ7DQo+Pj4gKw0KPj4+ICsgICAgaWYgKHZ0ZF9hc190b19pb21tdV9w
YXNpZF9sb2NrZWQodnRkX2FzLCAmcGFzaWQpKSB7DQo+Pj4gKyAgICAgICAgcmV0dXJuIGZhbHNl
Ow0KPj4+ICsgICAgfQ0KPj4+ICsNCj4+PiArICAgIHJldHVybiAocGFzaWQgPT0gdGFyZ2V0LT5w
YXNpZCkgJiYgKHNpZCA9PSB0YXJnZXQtPnNpZCk7DQo+Pj4gK30NCj4+PiArDQo+Pj4gKy8qIFRy
YW5zbGF0ZSBpb21tdSBwYXNpZCB0byB2dGRfYXMgKi8NCj4+c2FtZSBoZXJlDQo+Pj4gK3N0YXRp
YyBpbmxpbmUNCj4+PiArVlREQWRkcmVzc1NwYWNlICp2dGRfYXNfZnJvbV9pb21tdV9wYXNpZF9s
b2NrZWQoSW50ZWxJT01NVVN0YXRlDQo+KnMsDQo+Pj4gKyAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIHVpbnQxNl90IHNpZCwNCj51aW50MzJfdCBwYXNpZCkN
Cj4+PiArew0KPj4+ICsgICAgc3RydWN0IHZ0ZF9hc19yYXdfa2V5IGtleSA9IHsNCj4+PiArICAg
ICAgICAuc2lkID0gc2lkLA0KPj4+ICsgICAgICAgIC5wYXNpZCA9IHBhc2lkDQo+Pj4gKyAgICB9
Ow0KPj4+ICsNCj4+PiArICAgIHJldHVybiBnX2hhc2hfdGFibGVfZmluZChzLT52dGRfYWRkcmVz
c19zcGFjZXMsDQo+Pj4gKw0KPnZ0ZF9maW5kX2FzX2J5X3NpZF9hbmRfaW9tbXVfcGFzaWQsICZr
ZXkpOw0KPj4+ICt9DQo+Pj4gKw0KPj4+ICBzdGF0aWMgaW50IHZ0ZF9zeW5jX3NoYWRvd19wYWdl
X2hvb2soY29uc3QgSU9NTVVUTEJFdmVudCAqZXZlbnQsDQo+Pj4gICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICB2b2lkICpwcml2YXRlKQ0KPj4+ICB7DQo+PlRoYW5rcw0KPj4N
Cj4+RXJpYw0KDQo=

