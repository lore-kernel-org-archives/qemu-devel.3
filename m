Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B0BDCCD1A5
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Oct 2025 08:25:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vB7gN-0000mS-5A; Tue, 21 Oct 2025 04:25:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1vB7gJ-0000mD-JJ
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 04:25:23 -0400
Received: from mgamail.intel.com ([192.198.163.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1vB7gH-00071W-BE
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 04:25:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1761035121; x=1792571121;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=2VA2i3asK4SlYHegUzTULt9Xj6oMNTR7XX1hw/OBYO8=;
 b=a62eDg0lr2353IRHWxvUvSwlxtrMWGu5NqAch5Vm0AfizQnJcf/LWsdE
 /rLPq4kfmNX8VlIT8aS+AaJM1TOiMSbwG08cP0gKodUzSAPv0m5OxEC8c
 qMKawZt+7ZoHytz1z+TUumX56j0Oc71Xc/uXEMtD0MrNGfUaFVzn3x+qL
 q4BKX97QnBCnpomeJZTsZfdogCsogsPDlj95BrTDkbTzyus+rrtF/wM+W
 P/H6S/5mz8G9tjW/ILv+DxAMI/ALA9jD2FwMEAn0AHe1/CRsVJYkPXrOK
 JiraG2cLoFjR9TCGtm+JS5PvjW7p1/lKbcbLMijSn86L623y4H7vZ0HdQ A==;
X-CSE-ConnectionGUID: XmkQhCsvQUOvGo0kmJqHYQ==
X-CSE-MsgGUID: fhPV0ntcRCC+DVHgOq07cQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="50730578"
X-IronPort-AV: E=Sophos;i="6.19,244,1754982000"; d="scan'208";a="50730578"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Oct 2025 01:25:15 -0700
X-CSE-ConnectionGUID: GlzMsR4ZT2uHWvFLrRkujQ==
X-CSE-MsgGUID: u8fzSwDvQ4WzhMo4KROquA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,244,1754982000"; d="scan'208";a="183391087"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Oct 2025 01:25:15 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 21 Oct 2025 01:25:14 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Tue, 21 Oct 2025 01:25:14 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.50) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 21 Oct 2025 01:25:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PdWvsMPSBqziPlhEOkWbwUagD9kOiG0FZPoJ6teNuG04nyijsH0SsxbAWT8ZUHv7/Eat6tmzNIcJvDKjGkJc6VsLXQRo+LKZfs6wM7TfJO0P2DAa8hUPtwaW/drqfD8sR9UHhCTa2puvLyWp1QUqwIsv+DrC4m4ShjeONmZebwq2Hv/mjjr9mevvZZrD1ixeva1T4a22jDUVjhnYDbXxrfeaYGX84M2UJKdkKdLGwOLITKFiNEZixPp5O/9BEMdCR8fT8NDaTzn/HG2GPKVMTs7ZoZYP/bdwRjiIDC4pO/YiN40sTi3KBEtsItYjgZpKysLYEahdewS+Y82pYNRqig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2VA2i3asK4SlYHegUzTULt9Xj6oMNTR7XX1hw/OBYO8=;
 b=AfMGGV4BZvD41myxlpG6YxNyPD28tN2rO6V+SFPnt47qhAJM3wR/TMIXZsxb9uO3+4cIqkau8TJewYne1BlOOpCBL9aPIH50BduCoe4JuLOIEkVXrFUWwI62Gw3TktOIHz5N9wBjUzvm4OS0yuQh2H+rHH2La6fHYJFAUdr2aPRDkBFCLger3V++g/IMRYHOWJAWCDMVJ25qeRz2CVkna8I00iPm6YNwSf0QuUKfliFMOk2rSkMpeJyKZdO1m9IprkiizMHFpBbfJZs9bHqetYgV2ovgHMwOxiuY94TRrwNPmqxF0/xWzrz2Hr9STWUCzttGpGmYfD2R6lo+Tq9bMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12)
 by DS4PPF2F49754B6.namprd11.prod.outlook.com (2603:10b6:f:fc02::1a)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.16; Tue, 21 Oct
 2025 08:25:11 +0000
Received: from IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13]) by IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13%7]) with mapi id 15.20.9228.015; Tue, 21 Oct 2025
 08:25:11 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: "Liu, Yi L" <yi.l.liu@intel.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>, "mst@redhat.com" <mst@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>,
 "clement.mathieu--drif@eviden.com" <clement.mathieu--drif@eviden.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "avihaih@nvidia.com" <avihaih@nvidia.com>, "Hao, 
 Xudong" <xudong.hao@intel.com>, "Cabiddu, Giovanni"
 <giovanni.cabiddu@intel.com>, "Gross, Mark" <mark.gross@intel.com>, "Van De
 Ven, Arjan" <arjan.van.de.ven@intel.com>
Subject: RE: [PATCH v2 7/8] vfio/migration: Add migration blocker if VM memory
 is too large to cause unmap_bitmap failure
Thread-Topic: [PATCH v2 7/8] vfio/migration: Add migration blocker if VM
 memory is too large to cause unmap_bitmap failure
Thread-Index: AQHcPz9SC8XcAJsaGECSqxaSSWzx7bTLABYAgAEnpAA=
Date: Tue, 21 Oct 2025 08:25:11 +0000
Message-ID: <IA3PR11MB9136B8DEF2A5D413E121F13D92F2A@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <20251017082234.517827-1-zhenzhong.duan@intel.com>
 <20251017082234.517827-8-zhenzhong.duan@intel.com>
 <49ac485e-4704-40a9-a574-9bcfdc1f33fd@intel.com>
In-Reply-To: <49ac485e-4704-40a9-a574-9bcfdc1f33fd@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9136:EE_|DS4PPF2F49754B6:EE_
x-ms-office365-filtering-correlation-id: d466a23f-2f4c-4678-334b-08de107b5a5f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?ZjBINGMvRG1HNU55dzZYczRzdlROMGVmUmNUR0RMVEU4SXJ0N1lmaStzbkFM?=
 =?utf-8?B?QkJJaEloMlJteHl5QUkvd3dFSi90QnU3THYrc1g2YmowMkNjTDB6b3g1RFZs?=
 =?utf-8?B?NWZrQWhueStlcVdIS1ZwMHE1aHkwTVhjNEN0K3FpSnArNGZzNHNEY2NtOEFR?=
 =?utf-8?B?UXl2S3BLN213Y0U5YnBJYXVVckJZZWtwcjJUT1A1ci85bWIyNEFrR00yWGtv?=
 =?utf-8?B?RmFqSUYzRko3UmZ3S1lCbVh5QUhuQkNPRTVvNVJDeXB2MHlJWEpmR3dhTGpT?=
 =?utf-8?B?dTR2dERpSFkyM2dkWnlaY05XWUhvb1lvdlFxVkRQZ1R1NHdTQkFoV3pxOTVa?=
 =?utf-8?B?Y092bktNM3VyT0tqSnFOOVJicVEwU3VXNFRtVGVHTXQ2ZEhNSVFBWlZiZXg1?=
 =?utf-8?B?SXJWbGtJbmxYNWczU1hqUXBEUEdQK1Q0MU9iQmFIUkdnRUp4dGdDYklyWjVS?=
 =?utf-8?B?TFpWMm1BUXBOaEZ0YWl0TlBiUHBiMjBWRFFqVGVZd0FsQlR4ejY2SGhTdEpH?=
 =?utf-8?B?OXNLOThTQWNmUFJJU003d2FnOEd1dFptUHpIYVRVL1RYUXpmQWtxOGwwaVZt?=
 =?utf-8?B?dFlKaU5GWXBCT01IclFianBYSzRneG1zSnpETHJkajJXSURoUVgwcGMydUwx?=
 =?utf-8?B?VTNJcTVBU2dSWTNIT0s3MWhMUWVrdGdXK3VHaXlVL3MwMVR6NUZtWE5WWTRh?=
 =?utf-8?B?SGRWNUZrQmp6RzJhcXkvNHZOalFjQWF5WS9xbTdrd2swQm4xOWErN0V4dks3?=
 =?utf-8?B?TVdPSGRxYmxMOTJJZS9uYXlDR3ZweE0xbGhZdFJ0ZmtMNStHeDdCd093QlZ5?=
 =?utf-8?B?Q2VMZUNOSCtMZFhoYmNNSGJwbVFldEdRR3d1dnU4dlZBc3JqQmowMThLelVC?=
 =?utf-8?B?eUtpeTg2V01ZWmZGYnFsbUUwS25sNnJtOWpMcFNYdXNselQyanVaYVhlbit4?=
 =?utf-8?B?Tk5pYnRyZUx3ZVFyYVlLbnBCWGF0djBBMWdkVUJRd2djYlN3Y2x5T2VvWjk0?=
 =?utf-8?B?NW10RGZWY0tmTDVQUGZwYmJvVE9WajFmZ3dKTnBNeVpyT251ZHp3RTlOMDZn?=
 =?utf-8?B?NXhJZmRWcGczY1hWRmJmaE82WFRWKzl3WE8zNkt2T3FydkwwZ0IwS1d6RzdD?=
 =?utf-8?B?MFpsWlh0WEY5aFFFRkU0bzJPMEVUK2Y5bmpKL0kwU25Td3RlRnlqNitVZHBw?=
 =?utf-8?B?U1JudVBrQURtbG1uR016dWUrR3ltNzU5VE4vamdhYnptTi9tRnk5em9nUzlM?=
 =?utf-8?B?TjlOSGoyMjZJbUpiRFBob1hvT3hKQlZ0N00zS3R0VWxaS1h4ZlFMVzQyZ01X?=
 =?utf-8?B?dGt0SnFRUHdXNnZlTjczc3lURTU5V0pMOStpMzh0WVpybXlsUWxiT0d0THZ6?=
 =?utf-8?B?R2RLRnVPSTBqYlRlRytjTGFJYnZyNnBOTGFia3daeG4wckRHRWFHdWQxT1Yz?=
 =?utf-8?B?RFNjQWRZaVlCVVJFUHpuUFZKRlA2cHYvbVBBRjJpZ2VZcFlvS2pGKzlpeVo5?=
 =?utf-8?B?cmdjUEs1YzR4b0gzd29DMnViT0JMdVpkMnNXLzM0NnQvWFZ3bDd6NDdxZUZo?=
 =?utf-8?B?TFh6VlRCZzFlQldjTEVNZGZLYXo3aSs1V2F0QllSendodzRVVGgxRHJ4Uzd5?=
 =?utf-8?B?UGFZYmNZUHRlSlNGK2gwOFNrWmdnd2dYUUF3RjhLYnRub3hxekJCT0tobk1z?=
 =?utf-8?B?NHoyOVZBczQyMGdmOGpHS29ja2JUcEpWK1NPRzlDTHNESE9ORTN2b2ZzVFNv?=
 =?utf-8?B?cTNsNXVIdnZSQnJ3d0I3bUh3RVUxSEY3QmhIdHloZTY2Y1NlazB4SmFQd3E3?=
 =?utf-8?B?OVREdWR1T1RzQUdvb3E0Uk1Xc2lVSFp6blFwMlM5bUxaaThNWjhndWZwa04v?=
 =?utf-8?B?UU4zK0VCZ1l3MjZ1dU1XQW5jMjRmMzRVdlZzd1NQVlJLaGZHYWhLZkwwRm94?=
 =?utf-8?B?YjF3Qk52eUswYlpmbnNmaUVzNGJWdXhQc04yYW5XQXlFQlRnOTZ3WjVKSm1k?=
 =?utf-8?B?VHp5cW9XYjJ4d2pLa05sVHNMMGhLNm1vUHozMUtLZjdDSitoSWRBZEtpNVli?=
 =?utf-8?Q?x4AFXW?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9136.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RStmVWhpUFpMK1lJczFib1FNNkw2TXdRUHlLTnVjT0RERUhGSExmdElYVndk?=
 =?utf-8?B?Y2pISWl5Ui92TXROaFJSbzY4NEdQTzQyRmZFUTUrRUtxY3Nuci9xRWNYVUJJ?=
 =?utf-8?B?b3pGWVlVSFVibGZrVVBYcmg5Ti9uZjBxWHhCbGwwcUR3MUF2S1NKeHVXNDJY?=
 =?utf-8?B?MllhMXNJRnhBVWQ4M2NKTTZjYm9kbTh1aE9sWlE3ZXN1eCsrQTh6dUI2bjZD?=
 =?utf-8?B?MXNmZ3ZZZDR6bEx4Yk5jQWlCWHZwNFZDdmZDVi9GbHl5NnVXZ1RkQmZScTZt?=
 =?utf-8?B?ek11THBFc2F2ZTZwbHJTMEpZWE15aklGemhlaXNERmxKWEU4T1FzYjNaK2F2?=
 =?utf-8?B?YUp3d09XTnJOcUQ2ak9FbzZZUnVrRnU4dUtwMTBoWEVXYzJqb1R4Mk1abG1J?=
 =?utf-8?B?RXVaTTNaaWVqRFk3VTNDUVFpcEZwSmZGanFKSTFTRW82TGJZbGMvNU5CNTlS?=
 =?utf-8?B?NlZDYjRqbjUrVmE4eUJMY241VGF3eFNiNVBoUDkrRGxnM1VseFlsWFIyd2hm?=
 =?utf-8?B?aTNnT0VFQkRHQUtVV2dmOGR1aDUxVnFPYXFuSWR3VkVhNTJaVjJ0K1hlLzRl?=
 =?utf-8?B?eGhNNjNOaVVFSHJOYkpFa2VXbWlSb3BwL2pLMjRsUk9aWGt0ZFl1MUE4MWxW?=
 =?utf-8?B?WmNmYVhjSC91NjNvdzRQZy9jUlFBMVVTKzQ5VGJnT0o4RzZ0Q3BnOCtkOWg0?=
 =?utf-8?B?cUVQN21FeVZCdWlHa1hpMmRPNEdJRTlsSHlKdzJkVjVSQzVHSUR5cmVHMVFm?=
 =?utf-8?B?WStQaWNmQXdkL1g4bGZpWG55Y2JtTjMwSE9iMHpkVTJVUCthdmJ3Y3k2ck5a?=
 =?utf-8?B?S2NSam9nQlhIdVFUSjRKcFhrbVI5M1lyVGpXRzg2ckovQlRsZ1FHZkFRWks0?=
 =?utf-8?B?YURjVHBpUnVrdllKTFZDTThFc21GbHFNUXpnREFmcUJxMHhrakx1TzNEelE2?=
 =?utf-8?B?ZjNWVmJEUDJ5dDkrdmJQcHJ3ZjExRm5iNlNDWENGMFUrYUd2Z1ozMGJlN1hJ?=
 =?utf-8?B?aHVWOElvVXB4N01VM0pscTdvQkNJUjlBOWpCemNiSW5KRXoyTlBuWnFsWTBj?=
 =?utf-8?B?OUxoN1p5aEZla1NWREJUNmJCZGo2WEkyZC9OT004M2IzZzN2Q0xGSXo4QkUw?=
 =?utf-8?B?ZFdXMEhHQ24rWDNzWUV1a3NHMnZkVW1tUWg1dU5TZHByeVk4TUtJMHFGTG5P?=
 =?utf-8?B?MlY2d2EvV0ppQkJVY0l0MVFjcVpHTmREMDE1cURTMTNKR3dTZkVzWmx5ZzM4?=
 =?utf-8?B?UWEvTnFIMzJ0aDIxZjEvcXpZRVlHMVMzdXFYK1UzdmsyNjZmd2tyME5DODlH?=
 =?utf-8?B?Mmx0V3dJRHJFRzFsNnJvZGhNL3g2MFJZSDBoYVRHbVhMbTVBS0h1VWwvQ3Uw?=
 =?utf-8?B?VTlwVXA4dFBCeTV0Nkw0OEJHYXMyQkI3YUUyb1JlUWc5YitsYTZCbmM4dURY?=
 =?utf-8?B?enZyQVp5eUsxME5GR3J1elNiZUFIVllVNUlQS2lwdXVCbXh6dnZtamJZblNj?=
 =?utf-8?B?L2NwcnV3N0Z6Q2lmeXVLRzBHZWNLTCtxUTBvQkwwZDNTWTFJNS82emtObkNP?=
 =?utf-8?B?VDFKK3ZTc3Zwd2NCaWFPQ3BHYUlQRjFVdXo4MVhrMlFtOXI4a21ZbkhiRkQ2?=
 =?utf-8?B?cVlEZDlrcjNucUlWMmpaMzdFUGVTQkUrT3NQM1NNa2FDbXNGSkFuU2xuaWM5?=
 =?utf-8?B?bEhWcXlTbUlid0lJalNBd25XK2RNU0dGR1ZYK0xnVUc2blIyNS9saW1BbUZG?=
 =?utf-8?B?RVpycGNRZXNpRjYvWktzSXBQa0dxRW9oeGhVNHJQK3ZUa0V0REg2Q2Y1dGRk?=
 =?utf-8?B?UzI1alc1ZnVDdW5qQUxuTy83VmZtN2xzaW5kdmpEMTVoYWNlRThBWElHRG1j?=
 =?utf-8?B?ZjZLWmVsZjNKb1NuL2RaWHViTjFKbDJwUmVTbGVWWUd0UmJIUTdLQ1FHWCtB?=
 =?utf-8?B?bWhkeGt4U0JEM3BQVUdZeDcxdVVwNCsrUER3LzFwWUVYWFZPT3NPWlpYQ2da?=
 =?utf-8?B?Q0g0N0hIV2RhcVM5TmFFdWVpZzVoMnNiZTB4bnFMQkliU015TWxWUGF6Mm12?=
 =?utf-8?B?U1d3SkpTc2dSd3UyRUJ1WnR6aEJSSDhYTEd2U0VkOGRuOFZUaWdLakNrcGd2?=
 =?utf-8?Q?Hg//z4QQJhlkWEi4zFtB3jKJP?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9136.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d466a23f-2f4c-4678-334b-08de107b5a5f
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Oct 2025 08:25:11.6032 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Us/aufwcq6R8SctemANO6m8WgPUrA2vnDUUHtr/A+KH5KPdHnYqZ7UnR3qwBAFgkBR/O897WEM9mKwAOC/ycdSOEBJJevyF7uMGf0RdiZKc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPF2F49754B6
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.16;
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IExpdSwgWWkgTCA8eWkubC5s
aXVAaW50ZWwuY29tPg0KPlN1YmplY3Q6IFJlOiBbUEFUQ0ggdjIgNy84XSB2ZmlvL21pZ3JhdGlv
bjogQWRkIG1pZ3JhdGlvbiBibG9ja2VyIGlmIFZNDQo+bWVtb3J5IGlzIHRvbyBsYXJnZSB0byBj
YXVzZSB1bm1hcF9iaXRtYXAgZmFpbHVyZQ0KPg0KPk9uIDIwMjUvMTAvMTcgMTY6MjIsIFpoZW56
aG9uZyBEdWFuIHdyb3RlOg0KPj4gV2l0aCBkZWZhdWx0IGNvbmZpZywga2VybmVsIFZGSU8gdHlw
ZTEgZHJpdmVyIGxpbWl0cyBkaXJ0eSBiaXRtYXAgdG8gMjU2TUINCj4+IGZvciB1bm1hcF9iaXRt
YXAgaW9jdGwgc28gdGhlIG1heGltdW0gZ3Vlc3QgbWVtb3J5IHJlZ2lvbiBpcyBubyBtb3JlDQo+
dGhhbg0KPj4gOFRCIHNpemUgZm9yIHRoZSBpb2N0bCB0byBzdWNjZWVkLg0KPj4NCj4+IEJlIGNv
bnNlcnZhdGl2ZSBoZXJlIHRvIGxpbWl0IHRvdGFsIGd1ZXN0IG1lbW9yeSB0byA4VEIgb3IgZWxz
ZSBhZGQgYQ0KPj4gbWlncmF0aW9uIGJsb2NrZXIuIElPTU1VRkQgYmFja2VuZCBkb2Vzbid0IGhh
dmUgc3VjaCBsaW1pdCwgb25lIGNhbiB1c2UNCj4+IElPTU1VRkQgYmFja2VkIGRldmljZSBpZiB0
aGVyZSBpcyBhIG5lZWQgdG8gbWlncmF0aW9uIHN1Y2ggbGFyZ2UgVk0uDQo+Pg0KPj4gU3VnZ2Vz
dGVkLWJ5OiBZaSBMaXUgPHlpLmwubGl1QGludGVsLmNvbT4NCj4+IFNpZ25lZC1vZmYtYnk6IFpo
ZW56aG9uZyBEdWFuIDx6aGVuemhvbmcuZHVhbkBpbnRlbC5jb20+DQo+PiAtLS0NCj4+ICAgaHcv
dmZpby9taWdyYXRpb24uYyB8IDM3ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysNCj4+ICAgMSBmaWxlIGNoYW5nZWQsIDM3IGluc2VydGlvbnMoKykNCj4+DQo+PiBkaWZmIC0t
Z2l0IGEvaHcvdmZpby9taWdyYXRpb24uYyBiL2h3L3ZmaW8vbWlncmF0aW9uLmMNCj4+IGluZGV4
IDRjMDZlM2RiOTMuLjExMDZjYTc4NTcgMTAwNjQ0DQo+PiAtLS0gYS9ody92ZmlvL21pZ3JhdGlv
bi5jDQo+PiArKysgYi9ody92ZmlvL21pZ3JhdGlvbi5jDQo+PiBAQCAtMTYsNiArMTYsNyBAQA0K
Pj4gICAjaW5jbHVkZSA8c3lzL2lvY3RsLmg+DQo+Pg0KPj4gICAjaW5jbHVkZSAic3lzdGVtL3J1
bnN0YXRlLmgiDQo+PiArI2luY2x1ZGUgImh3L2JvYXJkcy5oIg0KPj4gICAjaW5jbHVkZSAiaHcv
dmZpby92ZmlvLWRldmljZS5oIg0KPj4gICAjaW5jbHVkZSAiaHcvdmZpby92ZmlvLW1pZ3JhdGlv
bi5oIg0KPj4gICAjaW5jbHVkZSAibWlncmF0aW9uL21pc2MuaCINCj4+IEBAIC0xMTUyLDYgKzEx
NTMsMzUgQEAgc3RhdGljIGJvb2wgdmZpb192aW9tbXVfcHJlc2V0KFZGSU9EZXZpY2UNCj4qdmJh
c2VkZXYpDQo+PiAgICAgICByZXR1cm4gdmJhc2VkZXYtPmJjb250YWluZXItPnNwYWNlLT5hcyAh
PQ0KPiZhZGRyZXNzX3NwYWNlX21lbW9yeTsNCj4+ICAgfQ0KPj4NCj4+ICtzdGF0aWMgYm9vbCB2
ZmlvX2RpcnR5X3RyYWNraW5nX2V4Y2VlZF9saW1pdChWRklPRGV2aWNlICp2YmFzZWRldikNCj4+
ICt7DQo+PiArICAgIFZGSU9Db250YWluZXIgKmJjb250YWluZXIgPSB2YmFzZWRldi0+YmNvbnRh
aW5lcjsNCj4+ICsgICAgdWludDY0X3QgbWF4X3NpemUsIHBhZ2Vfc2l6ZTsNCj4+ICsNCj4+ICsg
ICAgaWYgKCFvYmplY3RfZHluYW1pY19jYXN0KE9CSkVDVChiY29udGFpbmVyKSwNCj5UWVBFX1ZG
SU9fSU9NTVVfTEVHQUNZKSkgew0KPj4gKyAgICAgICAgcmV0dXJuIGZhbHNlOw0KPj4gKyAgICB9
DQo+PiArDQo+PiArICAgIGlmICghYmNvbnRhaW5lci0+ZGlydHlfcGFnZXNfc3VwcG9ydGVkKSB7
DQo+PiArICAgICAgICByZXR1cm4gdHJ1ZTsNCj4+ICsgICAgfQ0KPj4gKyAgICAvKg0KPj4gKyAg
ICAgKiBWRklPIHR5cGUxIGRyaXZlciBoYXMgYSBsaW1pdGF0aW9uIG9mIGJpdG1hcCBzaXplIG9u
IHVubWFwX2JpdG1hcA0KPj4gKyAgICAgKiBpb2N0bCgpLCBjYWxjdWxhdGUgdGhlIGxpbWl0IGFu
ZCBjb21wYXJlIHdpdGggZ3Vlc3QgbWVtb3J5IHNpemUgdG8NCj4+ICsgICAgICogY2F0Y2ggZGly
dHkgdHJhY2tpbmcgZmFpbHVyZSBlYXJseS4NCj4+ICsgICAgICoNCj4+ICsgICAgICogVGhpcyBs
aW1pdCBpcyA4VEIgd2l0aCBkZWZhdWx0IGtlcm5lbCBhbmQgUUVNVSBjb25maWcsIHdlIGFyZSBh
IGJpdA0KPj4gKyAgICAgKiBjb25zZXJ2YXRpdmUgaGVyZSBhcyBWTSBtZW1vcnkgbGF5b3V0IG1h
eSBiZSBub25jb25zZWN1dGl2ZQ0KPm9yIFZNDQo+PiArICAgICAqIGNhbiBydW4gd2l0aCB2SU9N
TVUgZW5hYmxlZCBzbyB0aGUgbGltaXRhdGlvbiBjb3VsZCBiZSByZWxheGVkLg0KPk9uZQ0KPj4g
KyAgICAgKiBjYW4gYWxzbyBzd2l0Y2ggdG8gdXNlIElPTU1VRkQgYmFja2VuZCBpZiB0aGVyZSBp
cyBhIG5lZWQgdG8NCj5taWdyYXRlDQo+PiArICAgICAqIGxhcmdlIFZNLg0KPj4gKyAgICAgKi8N
Cj4+ICsgICAgcGFnZV9zaXplID0gMSA8PCBjdHo2NChiY29udGFpbmVyLT5kaXJ0eV9wZ3NpemVz
KTsNCj4NCj5TaG91bGQgdXNlIHFlbXVfcmVhbF9ob3N0X3BhZ2Vfc2l6ZSgpIGhlcmU/DQoNCmht
bSwgSSB0aGluayBpdCdzIGhvc3QgbW11IHBhZ2Ugc2l6ZSB3aGljaCBpcyBub3QgYXMgYWNjdXJh
dGUgYXMgdGhlIGlvbW11IHBhZ2Ugc2l6ZXM/IGhlcmUgd2Ugd2FudCB0aGUgaW9tbXUgb25lcy4N
Cg0KVGhhbmtzDQpaaGVuemhvbmcNCg0K

