Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 164AAC83F27
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Jul 2025 03:30:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubspz-0005Lg-3h; Tue, 15 Jul 2025 23:29:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1ubspw-0005Id-Sr
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 23:29:41 -0400
Received: from mgamail.intel.com ([198.175.65.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1ubspt-0004oG-Pd
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 23:29:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1752636578; x=1784172578;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=SWBFrpTBMd35ZWq/M8bx/M1jVD4k7GKyOSvrKHq3fDA=;
 b=kdOQJ6VdKPjKy0Q/pqiMVWzJMLPfJwfHGMZr9aw5bHujbuvPh2ENVrpY
 94TBNNY3YIa91DZfKbVFCAPx/jrHSLeJaAJbAS/GoqNQsCwHiE4oAyUHG
 o+i3n9IwO5UDPR//R+YN8aUxd3ic8ByXOo4xyZqjEp/u9o5MEYybdaNBg
 8YglClkkSs/LkMhSGmKz7h1bIBGtHzm9rXkz0wEgirW6b1VXmIOIV9j38
 zYaQFkT14zWu7UCu5A4iOvkVcQ2/YFi1WN7B09Y5a5CRXLNHDjbuiG8kw
 +xRpLcqyT3OHcgM/t4Uwf3bhXgFQoOu1J00/D9tZENNPbBMVp8nwdyssk g==;
X-CSE-ConnectionGUID: OfTFOXlFSPq3N53AUeJ40g==
X-CSE-MsgGUID: 3puiT4BLSZatvjNmkrZnmQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11493"; a="77404120"
X-IronPort-AV: E=Sophos;i="6.16,315,1744095600"; d="scan'208";a="77404120"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Jul 2025 20:29:34 -0700
X-CSE-ConnectionGUID: UUr9E5JxTeO1xOTSlNIrBg==
X-CSE-MsgGUID: jk6kodqRRnaSc3n20CReOw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,315,1744095600"; d="scan'208";a="188395372"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Jul 2025 20:29:33 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Tue, 15 Jul 2025 20:29:32 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Tue, 15 Jul 2025 20:29:32 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (40.107.92.77) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Tue, 15 Jul 2025 20:29:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IK079YaaZjD65Yds2VZEshduE3ayCNtGahTQJErFT+mYpix7d2hDVpEV7zMLEci68a5V1thhxFns0EjKt/U64bLMzrUIzqKG0W9NBvEaiiXPGzwJ3QegBgqmPDgyRrPmrYKKumz9CPBdTJ6DG+FZ+FotVUNhd7sXYJdRC+xdeIUako3+VOkvJOhXJvsUSwFyqMCCc9+uuGmZ4zS0DCpM8aF++IivJ794CKYinIkThiMCzXA3CzJJcd/tQO2wfea7egQ8yGJEmdKdtNJlicrEIgH7yLqat08RYF1YqO/8DEKrbzLcl5jSQUxJ8ttQETiQ4AhDCjRcBixxZX21NSejbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SWBFrpTBMd35ZWq/M8bx/M1jVD4k7GKyOSvrKHq3fDA=;
 b=TxDhbViqf83Wg/wdSoMfTvQqVbe2S8ppOEKXePzTRHBSCxilDkSJHQojwjaZ7oiJifovsAjUtvhQyQUCyoVb4Pq9cA/vT7qtYgzftW36CNfbgoThm423dOhIJgXDWWMBg3pRrG9YUgKvqBaiQdlxWAd08j/irr3ciuuCcVcHlnS2gHMU1a0Y2Q4k5lSXlBPFL5hIfkMVr56G+w3kpuczpci8nKf2nedkOrS3T0w1xgkxscit4oQ5DzNZ0fe8Lk6w1xKaLAKSIvml7E79NObs2psExpN7L8ybZexMlRUSenJnZHk4MLkd56lMuTl04h8C6EPc6bvb5Q1UMMTDWWDYXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12)
 by CO1PR11MB5188.namprd11.prod.outlook.com (2603:10b6:303:95::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.27; Wed, 16 Jul
 2025 03:29:02 +0000
Received: from IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13]) by IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13%4]) with mapi id 15.20.8835.023; Wed, 16 Jul 2025
 03:29:02 +0000
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
 "Liu, Yi L" <yi.l.liu@intel.com>, "Peng, Chao P" <chao.p.peng@intel.com>
Subject: RE: [PATCH v3 05/20] hw/pci: Export pci_device_get_iommu_bus_devfn()
 and return bool
Thread-Topic: [PATCH v3 05/20] hw/pci: Export pci_device_get_iommu_bus_devfn()
 and return bool
Thread-Index: AQHb7/hmm+JZF5vLQk28i2W36yJny7QzblKAgAC0cOA=
Date: Wed, 16 Jul 2025 03:29:02 +0000
Message-ID: <IA3PR11MB9136A8E8D37FCE8CC6ACD0AC9256A@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <20250708110601.633308-1-zhenzhong.duan@intel.com>
 <20250708110601.633308-6-zhenzhong.duan@intel.com>
 <cfa02f0f-d20e-4088-b377-3f233d3ec3f7@redhat.com>
In-Reply-To: <cfa02f0f-d20e-4088-b377-3f233d3ec3f7@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9136:EE_|CO1PR11MB5188:EE_
x-ms-office365-filtering-correlation-id: 8b37078d-eb72-488c-f6a6-08ddc418e90a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7416014|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?TTJaS2huandhcTZpZk13VU44VVYzZ1doSzRSMzBXVkpkN0JWYkg5Y3BmUjlH?=
 =?utf-8?B?Yy93L0hLdFZXT2sreGJxd29PazNmT2o0N2ZoSzV0RmlBZkhoWUhKK1JFQXh6?=
 =?utf-8?B?OUFnSUNJQUhHQ0pnbWRraUpFUjlLSUFhcGlITWUxTnR4V3R1V2RIeWRicmxv?=
 =?utf-8?B?Nkp0aWN3cUdlbGJmR01YZllIeU4rWXphODY4akFhL2RhbERqaVBPdmxpN2kv?=
 =?utf-8?B?d3hYV1VpUktNY1N6cmF0ZnV5MzE4V2xURHhEdHlwRUxSR0dSUmlxaHBMaEJp?=
 =?utf-8?B?cEsxL0t4Z0RCV3RkOVkvWHVZUzRuWnZVYWZ5dzhTRXdrVlVVeFdFREttTDE5?=
 =?utf-8?B?UTBqcG9IbTRKSzNYRjJpRTE3U0VFWkRFd2JUeWdEOVd0cHFUeG1EMGxHSlBP?=
 =?utf-8?B?eGRlMzF4SnNaTUp4Rm4zTUVXSWc0c2FJZGptUS9lRzl6elFhdnB5T0U4MWk2?=
 =?utf-8?B?WTZQTDF4aHRySDhjZEdYSGpmS3hUYS9DbWdkNmI0R1VuU3lCMTNsVm1OREd3?=
 =?utf-8?B?NVlpVWJFL3p3c1d5bzZhd09yRG9QL2dlVWpjSk55aG00UFNCYWNkR0VPaTlX?=
 =?utf-8?B?aFJlS2FNM3IzaEFEQmVlTm9SU09hNjEzK252NDYxT2tVRnluMWE5YmpVSU1v?=
 =?utf-8?B?QjA4SzUrbytSUS91WTFiU3lObXlKZ3NiVG54OG43ZG9tWEdTWmpBT2ZySGdT?=
 =?utf-8?B?ejdleGt1VklwSUJsMHJVWHQwS09wQVkweVg2Z1dVUHlLK3dwWjVxTUI0eHF6?=
 =?utf-8?B?aU1DUUNlMnBKQXJvYlVYT0xJVFJhbkgycGtUN1M2ZEpyRmV3WXpaZXgxYm03?=
 =?utf-8?B?eWdpUDZmaWJzTldQaTkxaEtwTUFwNFdKY2FCUXFDZ1g3b0VmVS9IZFhTcnl1?=
 =?utf-8?B?V05WaWpWK0tlRzZ2NXJpRlJMWnc2WnVkQjdrR1hLUlJaRExSZ0lPUGFmOEJE?=
 =?utf-8?B?QWxPd1NBWmVKS0xaSjBrL2lBQnhXZHVOUTRyTHVhZndiZVFWVk40MHhEVm84?=
 =?utf-8?B?akpnMmU3TU1ReWZaU3NsSEZyN0NkTDRzQmNxWjZxb28ySXJNQTlTMDhpTm1o?=
 =?utf-8?B?c214bXh0cUhwUllUSzBhSUl3Rlh6STVHVHROV3NZbjNoVVVWRTZkNVJlWjVZ?=
 =?utf-8?B?eGFsN3p3ajNrbWMzcXZBUldUOHhYa1dGK29wRkEwR0FKSWtDb210OCt3Mk1x?=
 =?utf-8?B?YTRpVGxxTXBvQ3NTNEhMYVN2aUQzWkdnbTB5bWFVcjloMEIrWjdjbG5jdUQv?=
 =?utf-8?B?bnFLc3RTRVVWcEcrTUdWUEZEVTFlaDRKdWxZR0VmSzcwV2hBM2ZvWGpKd0p2?=
 =?utf-8?B?cjZKdzFGdC96akNiSm5aWVJTQjNmNk9PRDgrSlF6Z3M1YUxBYTJlSFZpSUc4?=
 =?utf-8?B?YU9UMUp3QlJXL0xpZFllWEVDbXF4b1RUTkxBWW8wdGlOR093RFpoT051eWEw?=
 =?utf-8?B?bWlwSEFqK1gyb0RjbE1lYnlSb3pLSHlrSUFpc1lQOXUydG5nUGpGU1lSZXhD?=
 =?utf-8?B?QWc4QnV0S1ZmMGM1OHBWck9DZDhQNVAvVmZyc2MzT1RhRmdnOVJTajdrZmli?=
 =?utf-8?B?ZEQ3Z3JCQVgyMTcyeWgvalYvMi9zZDh2YitmM2U1czhKRzJpREJlUVJxc1ps?=
 =?utf-8?B?Yk9pMUJGZXRjK2hTSkovZS9sbWJ2TDM3em9TTGJKNFpyeUtLMGpwQitIOUtF?=
 =?utf-8?B?NFcxU3poVmY1Q0ZYTDVuampLbEMvOTVxcmNLdHFUOFFac3V3NFAzWnF1T3B2?=
 =?utf-8?B?YnJWdWgzdm5OWXU4MFh0Sy9YUVRJcCtGRUh4TmlQWlpTQUdRMUFtazJLYllJ?=
 =?utf-8?B?ZkpxRWIzRzNPTWJTNHFsQkFiV1ovOVQ0Qmx1QVp1Qk5vOU5XNk1RR2Q1K1c3?=
 =?utf-8?B?c3I2bHFOVWJwNHl1VUV3eWZUUmJURm9zT2tjOGhQcTVMOUNyTnBFakgxQkRv?=
 =?utf-8?B?cE0wZGtnYXVBSGhJNzljSUNkV0x4OXMrN0dGQzlTQk9NY2xMdGtxN2NYTDVO?=
 =?utf-8?Q?KxgcjIW2S0PLO8WUQJkoCt9rr81FWw=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9136.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cXliOEM1dWxzNUZiekVyRWhnNklydDhZMFFhcXdSQkJlQUFwZ05CbHlha0I2?=
 =?utf-8?B?SGZsSzRDclphcE0vQ1RGUDZnU0ZENkx1OWRIaXBTNmZoaFBNYVpLejZ1Tm1Z?=
 =?utf-8?B?R05RWHh1aEhqNjhJTGdNQmZUbE45cDQ5M09mZ2lINGtDVHF6VVBYaXRETm1P?=
 =?utf-8?B?V3VQMGtaQXJKaG1vODg1NURKSjdMMXZXeGNxc2huNDdwZWpwdUlPQkszb1dv?=
 =?utf-8?B?ekppYURyRXIxTmJDdTNENSttWmM3UlFRVWJsM25keUtNTnRrcUdSN2NwK2Vk?=
 =?utf-8?B?NWdYWVNYMVNrOUE1SVFRcEtZQXpxWTVWekRRenRHSmMxVm4zSktZWWdOL2RY?=
 =?utf-8?B?S2pBdWEzM2l1SjFmalBGNEhhZlJSZGl2NmhKODd5QVNQY2RZQzFaZ0VQKzNO?=
 =?utf-8?B?YjVyZSs3b3hrVDVOdW13VFhlanR5WE82K21SV29WcmQrd3NEYzNmNzI0WlYv?=
 =?utf-8?B?Sm8va2M2ZnhjUm56bEF1TFVGNjUxZFE2TXlvSlJrWER4ZUltVWxaWU4ycDhR?=
 =?utf-8?B?Y3hOaUN0U0czbWRmbWNYRTBlWVcweW5FNzlDeDU4WEw1Si9NaTRSbkJ4TWhN?=
 =?utf-8?B?bVJ2d1dzLzdKL0duWTdieFByZTg0d0hqWFBrRy8vWDEzMURjSnplZmdKWWUr?=
 =?utf-8?B?TVBQc1JESndWdm4vT0pjQXdTWWlEaHZyM3JDUzNKaXlGaHA5UnBHbWxiWlYr?=
 =?utf-8?B?REpTa29Sd2dYUHBELzM1a1QyWVI4QjQ1czgwVmYxQktDWmFUV1lFRnJ1Y0Fr?=
 =?utf-8?B?cWhXcWdjTklYK0VyZXpQRkE2SnM2dWlEcEdlNnVlZS9MTW85SzNSQmtHMUtm?=
 =?utf-8?B?eEp2NzRaOHdnY0xuWDVBUnBsUm00bCtXSlpHODluL1hBb2dwQmxVSjFIZEpS?=
 =?utf-8?B?RlNGc0xnK2I0S1Ixb2VGWXRyT3lFcGswbTNmS1ZUY0JBOVpyekZ5bmNRRUtO?=
 =?utf-8?B?dWgyNWFLdmJBWHBHR0Npa0VuN0kwVTBMMTlFNk5VeEU3aCtKV1l0YlQxanA3?=
 =?utf-8?B?NklabDNrTlkyRm9SWlhBUDhDczlVdC9ucEZYelk2U2RxMlVlUjRiZEVoYUJB?=
 =?utf-8?B?MlFiU3I2ZVpGMmpXYjM4c1NZS2VXT3RWYkJIWDJVc2F3TTFnbzdnYnlDRnVS?=
 =?utf-8?B?czlLRisyUjM3Um45Q0JKVkU2V1JCTEVUMitsV3BnNVNBREt6bFgrLzJqcFR5?=
 =?utf-8?B?NHdwdDhQS0Q1M0poUU9vdmZYVFgxRzZWVUJvYVE2dEJwY1FvM0dYRnBJd3dx?=
 =?utf-8?B?YUNMbW1qaTFDQVQyZTFQc25Db0VOVFV4azUxVzBDam0wa1ZYQ0FKTnhaa0ky?=
 =?utf-8?B?SGR6aGVxdm9pS09OUTFLOEhLdzhDeXRVVUovT1Z3TGcza0tMOXBJbFFsaGln?=
 =?utf-8?B?VlpCM2R5T0paVjNWamk1RDhIWTdoell2c21EaFN0MWRyOWxZYnNnd1I0WlZJ?=
 =?utf-8?B?SE1mdEU3T0VWUE4vNFlTSExVMVR4U0ZSVGtQVHBkU1FMa1VVelk5bHRvSklM?=
 =?utf-8?B?SVl2QzlmY1NqaWhubkhaMENsMnpRRnN6Y0dVek1xTmthRWVjc045NzhxWHU3?=
 =?utf-8?B?YitremdDTFBUWExZd21xdnFaZkhNdVZld1lya3pYTE0vemQwZ3pkb0hSeFRQ?=
 =?utf-8?B?ZCtyUmtvRUNzV0hQZ21FeFBMS3Y4Q1A0MWxZSE1oeEFkenRpOUhxdjc4d1Z5?=
 =?utf-8?B?a3hBcExrcXo2RWptQ1JsNldpWlN5MmhmNlIxMmViSmZnS3BVcEg2TVMrYUtG?=
 =?utf-8?B?RnZjUVZ0Qy91eEJja3plMmUzbnpKTnE0a3lvcklRanBEeTdrWVFxRGpud2hv?=
 =?utf-8?B?MXRyM3lOODVNZ1B6UVoxckhJdFE5SlZ5bWdIVTN6enZEcC90dnFWZFB3ZDFS?=
 =?utf-8?B?NVhXek84cUorc2Nod2dseUthU1JzQWxkMVFGZlY0NlY3WVdkeFQ5TWppYjk1?=
 =?utf-8?B?SE1NbXNwelhoVGtqUitvRmhjYm9meGN2NEV3OW91VUdhSHBjWEsrOUQ0QnJN?=
 =?utf-8?B?eGxNM0diMTY5MCszd3cvSC9KT1ZlS2VkY1c4OTVoN3V2Z2VlZzZ4TDFTK3Zs?=
 =?utf-8?B?U0VoUTc5TTBYaEV0TFlDYTZTODN0bCsxaHd3RTBXR0lWN2tnWEMrQlU1UCtP?=
 =?utf-8?Q?9J3Lbkc6MZ0VjWeBJ//p89lx/?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9136.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b37078d-eb72-488c-f6a6-08ddc418e90a
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jul 2025 03:29:02.4290 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Uvfzzl5rRIxUQgbqMR/v2dtRwQT6B3Le1BVbl1/bi4ks906XwPnytBhIZzUVXTFDDiEQKL2hE66E0+QBujirYwFsd0P5x3sAGkvQqFNAKAo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5188
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.9;
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

SGkgRXJpYywNCg0KPi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+RnJvbTogRXJpYyBBdWdl
ciA8ZXJpYy5hdWdlckByZWRoYXQuY29tPg0KPlN1YmplY3Q6IFJlOiBbUEFUQ0ggdjMgMDUvMjBd
IGh3L3BjaTogRXhwb3J0DQo+cGNpX2RldmljZV9nZXRfaW9tbXVfYnVzX2RldmZuKCkgYW5kIHJl
dHVybiBib29sDQo+DQo+DQo+DQo+T24gNy84LzI1IDE6MDUgUE0sIFpoZW56aG9uZyBEdWFuIHdy
b3RlOg0KPj4gUmV0dXJucyB0cnVlIGlmIFBDSSBkZXZpY2UgaXMgYWxpYXNlZCBvciBmYWxzZSBv
dGhlcndpc2UuIFRoaXMgd2lsbCBiZQ0KPj4gdXNlZCBpbiBmb2xsb3dpbmcgcGF0Y2ggdG8gZGV0
ZXJtaW5lIGlmIGEgUENJIGRldmljZSBpcyB1bmRlciBhIFBDSQ0KPj4gYnJpZGdlLg0KPj4NCj4+
IFNpZ25lZC1vZmYtYnk6IFpoZW56aG9uZyBEdWFuIDx6aGVuemhvbmcuZHVhbkBpbnRlbC5jb20+
DQo+PiAtLS0NCj4+ICBody9wY2kvcGNpLmMgICAgICAgICB8IDEyICsrKysrKysrLS0tLQ0KPj4g
IGluY2x1ZGUvaHcvcGNpL3BjaS5oIHwgIDIgKysNCj4+ICAyIGZpbGVzIGNoYW5nZWQsIDEwIGlu
c2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0pDQo+Pg0KPj4gZGlmZiAtLWdpdCBhL2h3L3BjaS9w
Y2kuYyBiL2h3L3BjaS9wY2kuYw0KPj4gaW5kZXggZGYxZmI2MTVhOC4uODdmN2M5NDJiMyAxMDA2
NDQNCj4+IC0tLSBhL2h3L3BjaS9wY2kuYw0KPj4gKysrIGIvaHcvcGNpL3BjaS5jDQo+PiBAQCAt
Mjg1NywyMCArMjg1NywyMSBAQCBzdGF0aWMgdm9pZA0KPnBjaV9kZXZpY2VfY2xhc3NfYmFzZV9p
bml0KE9iamVjdENsYXNzICprbGFzcywgY29uc3Qgdm9pZCAqZGF0YSkNCj4+ICAgKiBGb3IgY2Fs
bCBzaXRlcyB3aGljaCBkb24ndCBuZWVkIGFsaWFzZWQgQkRGLCBwYXNzaW5nIE5VTEwgdG8NCj4+
ICAgKiBhbGlhc2VkX1tidXN8ZGV2Zm5dIGlzIGFsbG93ZWQuDQo+PiAgICoNCj4+ICsgKiBSZXR1
cm5zIHRydWUgaWYgUENJIGRldmljZSBpcyBhbGlhc2VkIG9yIGZhbHNlIG90aGVyd2lzZS4NCj5z
L1BDSSBkZXZpY2UvUENJIGRldmljZSBSSUQNCj4NCj5CZXNpZGVzDQo+UmV2aWV3ZWQtYnk6IEVy
aWMgQXVnZXIgPGVyaWMuYXVnZXJAcmVkaGF0LmNvbT4NCg0KQXBwbGllZCB5b3VyIHN1Z2dlc3Rp
b25zIGZvciBQQVRDSDItNSwgc2VlIGh0dHBzOi8vZ2l0aHViLmNvbS95aWxpdTE3NjUvcWVtdS9j
b21taXRzL3poZW56aG9uZy9pb21tdWZkX25lc3RpbmcudjQud2lwLw0KDQpUaGFua3MNClpoZW56
aG9uZw0K

