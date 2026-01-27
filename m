Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05151D25920
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Jan 2026 02:57:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkZFo-0000bg-Gd; Mon, 26 Jan 2026 21:56:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1vkZFl-0000b5-1n; Mon, 26 Jan 2026 21:56:29 -0500
Received: from mgamail.intel.com ([198.175.65.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1vkZFi-0005wG-8O; Mon, 26 Jan 2026 21:56:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1769482586; x=1801018586;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=5L+LAdV/ijZJFzSY3U12px7y5Gw/gmlmwBXWttOTen4=;
 b=E46Ik19LVtVusnLqgS+63qs11M9ADAF9o8IenT5+OJiHLFFlpNFh1kWv
 a6vWCS6q+ymR1GtYfF6+p4bvnHfQs9xQAAQb/MW4nKNUVcr0WdwEP5bS8
 QXJlB3L+G+52LJMuSYCPdXQfe+DUe7dN4wcXViRYgFHQY5nfEm0BU2sCz
 6zaUCfp7gy1rZMGMrUsXna5Ut7Wv2iDivpDQE4qN9b3312BYoAxBCMGUW
 lYtMyIAIKyOLQvj7wclQRalhmWi7a5NhaBH/MDRXEAg4x4wEQUDl+bTvl
 OUZ3If0Rp9aWPfPo7O4MslfJSu+my+S6bh097wm4e8KVEiKOHbh+VAiUf A==;
X-CSE-ConnectionGUID: aOio+gUhSoOLTPz6LA68Rw==
X-CSE-MsgGUID: fiUfJCPCTw+u+pWcwYgOOw==
X-IronPort-AV: E=McAfee;i="6800,10657,11683"; a="88082152"
X-IronPort-AV: E=Sophos;i="6.21,256,1763452800"; d="scan'208";a="88082152"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Jan 2026 18:56:22 -0800
X-CSE-ConnectionGUID: 5iTIXCfyQjiRhQvkr+o1lw==
X-CSE-MsgGUID: CBH33pxeQg2d/H2GwgKoUA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,256,1763452800"; d="scan'208";a="211957177"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Jan 2026 18:56:22 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Mon, 26 Jan 2026 18:56:21 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Mon, 26 Jan 2026 18:56:21 -0800
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.21) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Mon, 26 Jan 2026 18:56:21 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Mbj0qfwISWaGt8efwymCDpwqBKQ/zisTFFVPZrD6bt8unvxmfX7WCrRlDYAaX3tjBLHXqrDOQ00KIkxlohuI/20ILELBSQ228pRogVN5/RMzpFshAzi39ymDW+BovRpF3OcQJwK1bjweHjjKp7qTkADByGQNQRR7idBsPUaj+lKz1dhTMW+dkhtUlHl34ehmP+ugvDHY9NLEw6sHDrqWNaQmhcOAjEsMElSIy6O+8BNihIA7JzS1tJwUYY7Yn1tFehN9I7qJzskqOKvtDnZLzDItKa2sck+3Iun7e4XerGujl5JvUdE0GulYaAZ1hzxX+hs9aeQISF/skbzN4JLtqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IzRHYYI4Vj/Nl/iy5IKB9kCfwZrgIu+ePrQqTVb7diw=;
 b=wIOmTqR8Bam4aaRrveN+Mjpvj5Njc8742BFOAjgV89jRZj8PqwcUpmplLrPn7BiUBbanPCadsYNAb6bAaDteZtZSdS90/n48Rrn+FE54+h7oEaVroPlK69yxyadfWlgymipWnsOEjX6kjQdmsOgKxPCGqPE54uwzuYALsn3ZX7tq6c337gC8p2eKMQXjqJvD8f427VuPu++OduFIcJz8lEPGLs5R/4XV9vc6jENyOSdV4Pe72KoKj6LY52/cazlbGViWk+h+ANhY8acZ78jVHJBTtkuwgfSFTxmslMlAk9ektlYrhYELXQ5clqoMa2Kb20MyT9Zx/NzFjjSwBlqFhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV8PR11MB8509.namprd11.prod.outlook.com (2603:10b6:408:1e6::15)
 by SJ1PR11MB6155.namprd11.prod.outlook.com (2603:10b6:a03:45e::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.16; Tue, 27 Jan
 2026 02:56:19 +0000
Received: from LV8PR11MB8509.namprd11.prod.outlook.com
 ([fe80::2e98:2a3a:ea82:c1bb]) by LV8PR11MB8509.namprd11.prod.outlook.com
 ([fe80::2e98:2a3a:ea82:c1bb%2]) with mapi id 15.20.9542.015; Tue, 27 Jan 2026
 02:56:18 +0000
Message-ID: <b520ea7e-3a41-4193-ba8c-4df73a67dce8@intel.com>
Date: Tue, 27 Jan 2026 11:03:03 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 34/37] hw/pci: Add helper to insert PCIe extended
 capability at a fixed offset
Content-Language: en-US
To: Shameer Kolothum <skolothumtho@nvidia.com>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>, Jason Gunthorpe
 <jgg@nvidia.com>, Nicolin Chen <nicolinc@nvidia.com>, "ddutile@redhat.com"
 <ddutile@redhat.com>, "berrange@redhat.com" <berrange@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>, "alex@shazbot.org" <alex@shazbot.org>,
 Nathan Chen <nathanc@nvidia.com>, Matt Ochs <mochs@nvidia.com>,
 "smostafa@google.com" <smostafa@google.com>, "wangzhou1@hisilicon.com"
 <wangzhou1@hisilicon.com>, "jiangkunkun@huawei.com" <jiangkunkun@huawei.com>, 
 "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>,
 "zhenzhong.duan@intel.com" <zhenzhong.duan@intel.com>, Krishnakant Jaju
 <kjaju@nvidia.com>, "Michael S . Tsirkin" <mst@redhat.com>
References: <20260126104342.253965-1-skolothumtho@nvidia.com>
 <20260126104342.253965-35-skolothumtho@nvidia.com>
 <a66aef84-ce92-4193-89bf-33651875452a@intel.com>
 <CH3PR12MB75481EF03A19B7DAFD9EA25FAB93A@CH3PR12MB7548.namprd12.prod.outlook.com>
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <CH3PR12MB75481EF03A19B7DAFD9EA25FAB93A@CH3PR12MB7548.namprd12.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR06CA0220.apcprd06.prod.outlook.com
 (2603:1096:4:68::28) To LV8PR11MB8509.namprd11.prod.outlook.com
 (2603:10b6:408:1e6::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR11MB8509:EE_|SJ1PR11MB6155:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d7dd702-a81c-4adc-8416-08de5d4fa515
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|42112799006|376014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Z1hIaDZSTTlvbis2SFl5VmhuUjQ5RE45K09ET1B1NFJLWUpvdTM4endQSjZP?=
 =?utf-8?B?aExNUDF4MDUrSkxPNWhkdDByOGc4RGFYQml1eTQvMDhVTzBCbDByV2VsOGxm?=
 =?utf-8?B?dUhic0x1OEU4S0pXNDVaOElMYmpQYTFENnhqVDl4MVo0dzF5aTJaMmE2NFBX?=
 =?utf-8?B?KzdxT0tCbTVsZXYxUlhUQWtSN1owOWVwZERhcnE0RkNVZG5jL280RmNpZFFx?=
 =?utf-8?B?Qk53N1BTbnZMSnRYSFBUWE9mNXB2eS8wNjJPRGxNZE5sYjhEWWpvREVhOC9a?=
 =?utf-8?B?cDNPWFNqKzBUVXM1ZTZvVllSb3RaZTZHbUxFdHhVeGd3RVRicTFOS0QrVU8r?=
 =?utf-8?B?KzZEQ3hpTTdvRHJXb3VNaGFPTEtzZk90T3preEZJaTRZV1dDaDNJMko0SU1s?=
 =?utf-8?B?SjJXZmltNlhPRHJTSUE0S2Q4MkR4K1pMZHlNMnF3MkJDWHc1dUhwUk9TRFZJ?=
 =?utf-8?B?TkxmR3Z0ZE1DS2k1SFR1WTN5Um83MkUrazdUUGUyMVF5ZGlqZm1EZXRDY0wz?=
 =?utf-8?B?V2pGNEpKcWtkaFJ2MUFNL3pFWnFwN0NnMS9lQzRBVzJ4aEJ4bmtLL0JmRUhH?=
 =?utf-8?B?SzRjVytXRHJKTzErYmtJNHBMRzBHNGxxKzA0UFVoKzZ5TkRzekJ3Sm4zb3hn?=
 =?utf-8?B?VlVORkV1cDRZRlpZV0R3YVZ2VE81TndqNVNoaWRGZ2NLMzhiOWFEYVg2QzEz?=
 =?utf-8?B?bmlnYkl6UVUzWnY5Mk0zQnNFenI0SHJZWTArL3ExNHEwNHFVTzFUSzBmNkM2?=
 =?utf-8?B?NGpyMkZTU3hibUMwV1VoT2s2YVJFSU5VSVFhTWdabzNteDk0SldHQy9VL3ZC?=
 =?utf-8?B?VDFncVd2dndNSHo5azdQVGY5cjA5S3dlSmlKNklza05NNHo4M0FwdUc4TzRy?=
 =?utf-8?B?THRoS24vSmFKMkJiTEF0V0lianlobk0wY05wL0QzQmV1cW8xSmI2RWVUMERi?=
 =?utf-8?B?ZTJjamQ4bXZtUlpibVVpSWEyZXZTSDlNMWJLVnVYd0dHUGwvTSszWE5KcGdV?=
 =?utf-8?B?Y0JFb2t6WjBHekVGMDkrZjRYYTBJa045Tkx4cGpOMTMva0JkajhmM09iVVBI?=
 =?utf-8?B?NTl0Zm1lMk9hdDY2a2V6VDRRUmROL1IreUpXaEhwRUtQV0dtM2c0ajV5dTFH?=
 =?utf-8?B?OWJsOXRSd1psZi92c24vZWkwSEdMdk9qM2xYbW1mSThRZmJuTGZMcHdMQ2w3?=
 =?utf-8?B?YkN2SkM2YmVzYUxrcUJPRVdCaUZxK1Vub2V3ZUI4YjlySUxLZHRhTitpcnhm?=
 =?utf-8?B?cDNPdzU5Y2Q0WlM0UnhwMVFISGxiR1BEeENjNHBneXZyYnBPUE9QMUlpMC80?=
 =?utf-8?B?Ykc2d3pSRUFPVHVBQ296OTErV3h0UU9nYWZjTFBWL25iNkpLWnhHODgyUjRW?=
 =?utf-8?B?YnR1UWE3eHdseTFFN1Z6eEprZm15WFJIcWJnTWJaNytNYW9FbExIVjJPbUla?=
 =?utf-8?B?aVpKbUpYZkJkRXkwbjRuUjNPaEdqRXpTUTByOVkzWFdKSGh1Q3hkMlJDRkZy?=
 =?utf-8?B?MUpLSU1iZlBQdElHb2xUUkp4eE9kTnVHTU1SaHR6dnd4K20vbXN3RXRMNUlX?=
 =?utf-8?B?NERobUNRTi9lQzlLL3NQVUU5Tnh1b255bTUrdUV5a3lwcFpRWUxRTzNJVkt6?=
 =?utf-8?B?cXN4OUxsUDR4ald5NHkrMjVjaklWQVgvL2FhRlR6NFJhZ1hnRHFnQ0IrQ3E2?=
 =?utf-8?B?K3NPS003dXhuZ3dwYlJCVFlIMjREKzA5YzhTM3FhMmhVRGdEbkRFaWlKZW5v?=
 =?utf-8?B?TkVNc3BKUzRyWTNtaUVITmFFaVM0NGRJOWxablZvWVVKUzUyeHgwV1pPZTh6?=
 =?utf-8?B?MU4wampCT3dkV3Y5bXV5TytZNy9xUDkvdk1lcW9xTDNWWEZHR0x3OTczRmZh?=
 =?utf-8?B?ZkxIMGFlZUI0WDk0cWl3YXArWWVaekdDZkZUT2lsNUQyM2J1emJFWU9EcmF4?=
 =?utf-8?B?aVFLTk1yVWxzQ0d0ODJ4VXpWNVBIZGZIU0RndDcyckplc082Z0RRTVl6V1Ja?=
 =?utf-8?B?YWY0WVBUdlNob1c0Y2EwV2hQaytFb0c0aUZuYVM3eUY0WDNKUXl6S0NUSkQ5?=
 =?utf-8?B?Sml4QkJ0cE81aWhQb1dwd2k1OUVYUEtzSjdjUDBaQTM0SDVmZDNvbUVtSGh6?=
 =?utf-8?Q?RZZo=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV8PR11MB8509.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(42112799006)(376014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TFR6ckVNNnJ6MkpkL0JFKzFTb0VKd0VxZkdaYWNHZ1NIT0NpNzJSMkc1U0xz?=
 =?utf-8?B?Ymt3eXo4WVVqcTZXc1V0Mmc1Q2RrUUgvWXJDVHJibVFXMy9kTkYwaUpCdk1E?=
 =?utf-8?B?eUFBeEs4ZWtiZ0JjNzI4VnlGV2Z0djN2ZG5ZTWVSNXNFa0x0aUZhdzlyOXZa?=
 =?utf-8?B?VUdxM0g3SnRLU1NTVHBqV3hmSnE5VW9SQUxELzlEbXRCQUVWS0w1VkRLVjFY?=
 =?utf-8?B?TDV0d0tsRjRXZGlPMThmT1BTQmJndXJIQ3pUT2VJa3Z2dkFTOVJWWnBnSUpP?=
 =?utf-8?B?Z0pvU3dVNUlORzNvTVo0eUVSdElEWi9WSXlvSzFmbDFxeWpTUEVkZjFNMWlK?=
 =?utf-8?B?NVZRbXJ3dEdqK04yVyt4M0RkQzNPVi9vdU5EVkpRRVRIZnZibU1DU1JSSEhj?=
 =?utf-8?B?R2JkeDArcjFZWHNselNSeGNLeTVNbldkOUVCQWZpYjFHblptUkUzeXRQTysr?=
 =?utf-8?B?aC9SUm0yLzVobVQzMW9nZEMyQ1YySnlkQVMrVUltbUxuUTZZeENveHFkQ3pt?=
 =?utf-8?B?U2oyaVFYT0FYV0J0ZDJJNGs4WDlCTFpuZVEremxjR1hWMkY5Q1d4K2FIT1JF?=
 =?utf-8?B?VUw3WkJWc2hMRDlpNmNNMm50T0pZemFCUnJVeUdGQUVkNjVYZXZraU5xd2w5?=
 =?utf-8?B?ZTJoS0VQSElmNTNVaUswNGZLa0ltS1l3VTNkbVl0N0p3YWFVVHVkY0t4V0dM?=
 =?utf-8?B?bUZwUjYvNkZnMVlHa2JJeW83a1hrdGg3NVVvTkYzeGMvdERWdFBaRmtOTUdo?=
 =?utf-8?B?NGJqU0t3MEQ3eUUxMVBiQ1E4MHBVYm9OMnVxbG5Wb3RVVVd2dEJvZlYwcDYw?=
 =?utf-8?B?OU0wd2dXR2xYQW44VGJ2VjdCUXVMbGtQelozZitWSmZ5T2Q0RWVEK0xmcm9O?=
 =?utf-8?B?Q2FBTytTWVpmNWgwNVFaeEM2dTZoVHFFTHBqV2xHcS95L2RwZTNpUXNWVkFZ?=
 =?utf-8?B?SStZU29BMnlET2YxSURkektFbkNlc2htY25tM2VtaWlsc2hjdko5UitkUlpG?=
 =?utf-8?B?MU5QQmJQaVgzbVg4MFdCMi80eXpsR1M1K0NMZi9SRHEwWlZvMHNjWkEzb1pk?=
 =?utf-8?B?UWNZeXhueElnSmU1ZzdleDFLVXlKUGIzM1J6UjByQ2xsQUVLb3ExL3k0V3B1?=
 =?utf-8?B?SXlldmlIZHE5MkQrT3ROTkhCNklNY2Q1Tmp3MTlJdytKZC9aUVU0ZThBb1lu?=
 =?utf-8?B?ZG5Eek9ZNmdRaVJpQ0x6WWdMS2Q5R21YanFxUTIwbzIrWnNQNlB0ejBtOEd6?=
 =?utf-8?B?QjVudVZJYTFjN1ZzNFhPZUhQcUJDZGhXQ1ZZVHpxZXdPRkdxV0lmSWhueXF2?=
 =?utf-8?B?YlpGeEpNYW9QNERuMnB2WFVwNXFQcnhFMVBnbmthL0ZSR3Z0bjhIOUtWZzgy?=
 =?utf-8?B?akJKRzBZVVY5RUVIS0FHZTNxenRTdmlsSHJmVWU4QXdpYjlURDNYM1BXOXVt?=
 =?utf-8?B?L3ZaR1BSTUx0UjVqTUxhckc3QUdQdzhZdU93cEJDQzhqN05zYVo0dFRZYlNQ?=
 =?utf-8?B?NGtBcDFQNnI2bDh0Qkk1VGhtc3dWUmtiOTdUMzBGcVU5bFBPaVNxVU94Qll2?=
 =?utf-8?B?MlJDWXhGSysrZWlVc1lORjRLd25kVDFxNjBuQWFaRy9LMkFFbHF6cGc2akMx?=
 =?utf-8?B?eEtXUW9VK2tuRWVMeWdZWHprZS9HK1lZTEhKSWo0OVVXK1ZyOHI0bk00elZY?=
 =?utf-8?B?Sm1uMUxoMFZ6OHZmYmcvcVByRFNFdyttenhpajlBQ1JFZkhwR28xK3cxblV5?=
 =?utf-8?B?Q0JFOGRweUJQbHE3MmhQOHpEdEFRcmRRd3VBb2x1bWs4UkY2K245b3dLb0Zk?=
 =?utf-8?B?c1JFRkRxaDM4S2VjRm1zaFFMYnNpdVB4a2JMbXBWR0QxaEtqbmtUdFRjaXJH?=
 =?utf-8?B?Zlg0N1FWNEtFOVpXaTVHbHAxbnJlTmRiaFl2b2s4VVBJYm9OcjNGZjdueG0v?=
 =?utf-8?B?NUFIOS80bkF4YkFXRlBjanFTTHIvajBWc1NrTzQ0bm5tK2h3OXlZVlNkendF?=
 =?utf-8?B?UTAvWGpRRmhQRWpBbTlLMG05bEtHUCtJeTRpbmhNVzRKalptL1ZoK1l3VjZY?=
 =?utf-8?B?YjBjcTlhbXRXUnVWYkpFVVowWDVtTU1nWHVjWDZsN05DU3k3dERRRzVhdzRE?=
 =?utf-8?B?MTJ3c3lETytwRFk2SWtjSndpZXI5U3RzcG56eGhzZU9SSUYyNjFaaGFFZVZ5?=
 =?utf-8?B?OWxlK1QzdFlyditjdmNic3NtUjN4bUtscWJuUlRZc2NaeUFUSzBmQzVMSlhU?=
 =?utf-8?B?ZmJCSXgwU3ZRTzh2cFJVaUxHYnV5MFZYNWFrN2JROUdGaG9lZnFSZXB5aExF?=
 =?utf-8?B?VTM0TU42Zng2cmcrSXFWNExIcFRBVjBaYU9nQ3RqWHZlaHRPNys5QT09?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d7dd702-a81c-4adc-8416-08de5d4fa515
X-MS-Exchange-CrossTenant-AuthSource: LV8PR11MB8509.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2026 02:56:18.8450 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SWnDQh+85KHN3g3wakSiOyM4HueN+EDb+F41eAx8IVNsSCtY01ncYKNmlwhCum0t2TyeIR0/mwe5pCgxtbZC8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR11MB6155
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.10; envelope-from=yi.l.liu@intel.com;
 helo=mgamail.intel.com
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

On 2026/1/26 22:17, Shameer Kolothum wrote:
> Hi Yi,
> 

>>> +/*
>>> + * Insert a PCIe extended capability at a given offset.
>>> + *
>>> + * This helper only validates that the insertion does not overwrite an
>>> + * existing PCIe extended capability header, as corrupting a header would
>>> + * break the extended capability linked list.
>>> + *
>>> + * The caller must ensure that (offset, size) does not overlap with other
>>> + * registers or capability-specific register blocks. Overlaps with
>>> + * capability-specific registers are not checked and are considered a
>>> + * user-controlled override.
>>> + *
>>> + * Note: Best effort helper. The PCIe spec does not require extended
>>> + * capabilities to be ordered, but most devices use a forward-linked list.
>>> + * Devices that do not consistently use a forward-linked list may cause
>>> + * insertion to fail.
>>> + */
>>> +bool pcie_insert_capability(PCIDevice *dev, uint16_t cap_id, uint8_t
>> cap_ver,
>>> +                            uint16_t offset, uint16_t size)
>>> +{
>>> +    uint16_t pos = PCI_CONFIG_SPACE_SIZE, prev = 0;
>>> +    uint32_t header;
>>> +
>>> +    assert(pci_is_express(dev));
>>> +
>>> +    if (!QEMU_IS_ALIGNED(offset, PCI_EXT_CAP_ALIGN) ||
>>> +        size < 8 ||
>>> +        offset < PCI_CONFIG_SPACE_SIZE ||
>>> +        offset >= PCIE_CONFIG_SPACE_SIZE ||
>>> +        offset + size > PCIE_CONFIG_SPACE_SIZE) {
>>> +        return false;
>>> +    }
>>> +
>>> +    header = pci_get_long(dev->config + pos);
>>> +    if (!header) {
>>> +        /* No extended capability present, insertion must be at the ECAP head
>> */
>>> +        if (offset != pos) {
>>> +            return false;
>>> +        }
>>> +        pci_set_long(dev->config + pos, PCI_EXT_CAP(cap_id, cap_ver, 0));
>>> +        goto out;
>>> +    }
>>> +
>>> +    while (header && pos && offset >= pos) {
>>> +        uint16_t next = PCI_EXT_CAP_NEXT(header);
>>> +
>>> +        /* Reject insertion inside an existing ECAP header (4 bytes) */
>>> +        if (offset < pos + PCI_EXT_CAP_ALIGN) {
>>> +            return false;
>>> +        }
>>
>> TBH. I was expecting to see a table that is similar with
>> pci_ext_cap_length[][1], and a helper to walk the ext cap list
>> to figure out the spared pos. But it might be over-enginering as
>> we rely more on user to give an offset that is for sure no conflict
>> with existing ecaps nor hidden registers. Could you also add a comment
>> in the code to note it?
>>
>> [1]
>> https://github.com/torvalds/linux/blob/63804fed149a6750ffd28610c5c1c9
>> 8cce6bd377/drivers/vfio/pci/vfio_pci_config.c#L71
>>
>> With the above nit, LGTM.
>>
>> Reviewed-by: Yi Liu <yi.l.liu@intel.com>
> 
> Thanks.
> 
> Yes, the helper depends on the caller to provide a suitable offset, since
> it's not generally possible to validate this due to hidden registers and
> device specific capability layouts, and this is already noted in the commit
> log and function comment.
> 
> If you had a specific wording in mind that would make this clearer, please
> let me know and I can incorporate it if this requires a respin.

no respin needed. Just noticed the comment in the function header is
enough. :)

