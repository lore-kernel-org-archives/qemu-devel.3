Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B32C6CD4851
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2026 07:33:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNQYm-0006VI-PN; Thu, 14 May 2026 03:32:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chenyi.qiang@intel.com>)
 id 1wNQYc-0006UY-SW
 for qemu-devel@nongnu.org; Thu, 14 May 2026 03:32:36 -0400
Received: from mgamail.intel.com ([192.198.163.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chenyi.qiang@intel.com>)
 id 1wNQYa-00036H-SF
 for qemu-devel@nongnu.org; Thu, 14 May 2026 03:32:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1778743953; x=1810279953;
 h=message-id:date:subject:to:references:from:cc:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=ntmT/JSnhHUhURgIORcnyqCOnncyygGf0lOu0QAQEVQ=;
 b=L90Cujba74s7OLAaY+McPIm+GF5q02xvJ5PTYDoUtyr9tX9edHkoeRUA
 D9po1Y5bhTmrcAueq8C1k3jJ1QeX+h+vpTmKNvtLHVsS3DHimkg5l75/a
 fyUP/mvJ6r5/1m3HtsHo/WG679i5IpNAWQl1DJIKNRKJb8G0KrNJZAN+f
 odbdtKxy+8zZvKglCAXiJoDitcQFapP8N611/NriLkmGbykLXGrNUP1jD
 YIAm7DRkOu+D1Y5zTmBopEl79KYncafahFaq0c+RCbYL+oPYKQtW99uto
 /xivAP3Nk6sjxAq+0YhDpmgk8WSXdlbc+ktgqBUBbDcSFYW3xZkeha2wg A==;
X-CSE-ConnectionGUID: qREFoC1dQQefpmZDy5WIYA==
X-CSE-MsgGUID: UsNW8u62S8W5bNv44twj3A==
X-IronPort-AV: E=McAfee;i="6800,10657,11785"; a="83531174"
X-IronPort-AV: E=Sophos;i="6.23,234,1770624000"; d="scan'208";a="83531174"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 May 2026 00:32:29 -0700
X-CSE-ConnectionGUID: LmVXX4ITQtOdsuJYootzLw==
X-CSE-MsgGUID: GIbCXWRTSf2uV2QXtpTCZA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,234,1770624000"; d="scan'208";a="242646299"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 May 2026 00:32:29 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 14 May 2026 00:32:28 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 14 May 2026 00:32:28 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.50) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 14 May 2026 00:32:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S2/mM7hDq98AXMXakDNZjjHZ55jvyIEF327/qmvtJypjywnUKNm98TNm9TSdUS/OXYFFOd4C4OoYy/X+mMZ02RHVPfTN3PwBwMSRtoniiK6DB0ScinyWbTou00paobTcLgJG+tXgSgEeW+iY/zQPNR7r2nJocspUxLDVOUDTYWntdqdsHt/wyNr4QUKhXkXMgosUtKV0j1jgqKSDHRhi/zcMbuj8oRMDrwlwJGLKMi/WwNbITXBpf/lPBzbYYHndvlIgEpkqi6g+HBfQJgQg9c1Hs2c4jvQReoU3YbJpMdWUUKG95+0N5ERDbvATvMVvE9tej8DrTqBu51Feq1S7FA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=92a9Qn+Zp/SpdAMvCZcEvl2IG2B/MigIWiPefNWqoDg=;
 b=iu5ZMLuP9jEv1a6DRK2CqQRb+lIhHX6dvJ4I85qHvdes2mg+cxPGi2IdUut8O4kGVOZK0SR1uIfOEcDH8lzWvF8SjBteXYUuL2vi7ftY+vzfl/AcT7nCxGsS+JBaauBejb1zjDrxp2ucQxVNZhlWDVBJ5+Fe2kcBZh3403/xsDJPSoRfG5ItPqWhYaDjV1g3mWKVfO5nT/VNXk9da7WEBGY7A1bs0lqc1HRZq7Jf4UG9ZkrgpYxamuc8CH/AgnfTLvLyeA7Ab2tDCQrJ3dK8Eu63QefiH1ISEYzE8HysXZeLtBz9+OJGCWELabutFrTDHOq2f90Fe1p/n0aUhDyRFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM3PR11MB8735.namprd11.prod.outlook.com (2603:10b6:0:4b::20) by
 IA1PR11MB6291.namprd11.prod.outlook.com (2603:10b6:208:3e5::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Thu, 14 May
 2026 07:32:17 +0000
Received: from DM3PR11MB8735.namprd11.prod.outlook.com
 ([fe80::8f1e:49f4:122c:c675]) by DM3PR11MB8735.namprd11.prod.outlook.com
 ([fe80::8f1e:49f4:122c:c675%7]) with mapi id 15.20.9913.009; Thu, 14 May 2026
 07:32:17 +0000
Message-ID: <bc976b85-1335-4f37-a704-129216625b30@intel.com>
Date: Thu, 14 May 2026 15:32:11 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 13/13] RFC: hw/virtio: start virtio-mem guest_memfd
 regions as shared
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 <qemu-devel@nongnu.org>
References: <20260504-rdm5-v4-0-bdf61e57c1e1@redhat.com>
 <20260504-rdm5-v4-13-bdf61e57c1e1@redhat.com>
Content-Language: en-US
From: Chenyi Qiang <chenyi.qiang@intel.com>
CC: Peter Xu <peterx@redhat.com>
In-Reply-To: <20260504-rdm5-v4-13-bdf61e57c1e1@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TP0P295CA0006.TWNP295.PROD.OUTLOOK.COM (2603:1096:910:2::6)
 To DM3PR11MB8735.namprd11.prod.outlook.com
 (2603:10b6:0:4b::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM3PR11MB8735:EE_|IA1PR11MB6291:EE_
X-MS-Office365-Filtering-Correlation-Id: 47cbbe30-efaf-481f-c9f7-08deb18aecfb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|4143699003|22082099003|18002099003|56012099003|11063799003;
X-Microsoft-Antispam-Message-Info: i57H5aUSMNhOgrC5uEuVeiR576CR4pz6QvvrUHEIxbaG9tQBwnBAytrW3LfAJmYDeXB8Xrxq7PIrSaTdhJxBO3d5vJZ2QBlJde335Q8+Qfnz3GVLVmb/27YxDPYsN7olQYXhAduhWevuWHYWpYGHRe0MkqlLLMYTlDd6/bU0RC9nWQOJd/ztgikTZ1QN2o1RN2xZHCSUHnq6xyxZ6qI69137Q8anwlXhicn2pbfQK2OVdUCjJNiBmvpY48e5i3nl7ueYNUWmA0eF79rJiGlIIzJrKIDHOkYlHXnkgBQSKBEH369RTgdGbcyvef/pp2WoLn4ZLUe8QVKWJleAU88tLY4IbVQU4roU0a5TgicJg2sjw8OOovDtgOqqMosBE93aPXfUw9A1y87v0qWDwwHSwzP/4QXqSXGvbaUWaaOmOUehlOu2Wxg16W/xmNdKVGrmS1p87BR515nNv5NR3fRWND9ugVKDFaY92vf17oEMhRYTUpT9lBMMNQ+ygSZFeN38Yl6Y8T0+POku2wzeS+M9k8dzD15PczMW8fbyHHUUBmjfj8UU8sTp0zvwFisdzJQoa2RUzHW4yq1JeuD9dHVocPph8Vz2EZVcKua03u+mKXc3hTLu+7LEhsk8rxrVdAylxwhqLaAjIiBzZRvfZHWYr2Z+AYppOG9C8dpUiUHBDn7CUzYCj1toRBsoneNCjhzH
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM3PR11MB8735.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(4143699003)(22082099003)(18002099003)(56012099003)(11063799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YTNvc3hCVDh1RVArUE00ek04ZmgyM2VYRXhhSWNSVGVNRXgyL01zc1RITGlG?=
 =?utf-8?B?NG9oN1g5R2QvNmxZT3MwUFVRWVJ0OTVWaEtwbzhNcDQxNFhKTWcyMzFqZjVW?=
 =?utf-8?B?RjdvYnVoRDlpdHhib1FPL1ZMcU9lQTJHZ29BYVZuMkFiS21FZTJGcU9jMWRD?=
 =?utf-8?B?ZnZreUpqRDlKc0VZa3hObjVzMEx2TktIUVI1d1U3akR2NUtUM1BMbkRxRmVs?=
 =?utf-8?B?dmg2VHE2ZkVDVk12SStxOE91d1BPQ2hnQmRXbVFkajZBZkcxNWQ0WjhMem4z?=
 =?utf-8?B?L2dIOVk3ZnZyT1JVbEhNemEwUDJPVjhSSGdyVGlTRnp6Z3J0NlBPT1E5b2lt?=
 =?utf-8?B?NXR1SGExMHcrcXNiN2NSdEEzQkNzV0JPemJTUXh6NXF6bkcyNWpOTHhaOTFQ?=
 =?utf-8?B?YnVvemxYQThmT2FGS3NNZnp0RmNFdGwwTXVvK285WkNWdmZxL1Z5ei9jODFa?=
 =?utf-8?B?dXd3OW9mM3hFbmw0WjFjZ2Y3SFFvMGhlOCtTQ0x2WHZMaVFPYnpTZDZpNkc0?=
 =?utf-8?B?MEMwQThUWk4wQVFJMktmaHZDTGdyTnl2d2VKODk4emUyMERFYVBqeitqR25G?=
 =?utf-8?B?bkdRb0N6VHZBdFNmNnFrWWtVQWRZVmcvT0FPRlA4OE10WDNIa1ZnOGYxWjJS?=
 =?utf-8?B?bnJ4b1RrTUtKZFNXYlNWMnpHTzFpeGRWWFVHNU5XK3ptd1BGZ3JCcE1iV3RI?=
 =?utf-8?B?S0krRzQ4K1B3NmE1Qkt6Y1dRVmZENFBFTXh5eHlTaFpsSzdyTnA3RWxjcHFF?=
 =?utf-8?B?V3llOUNLeUtDc2E5djJPREJWMldlZ2FEQ29tRkVuU2p6YzArcVdVVXNlTlVq?=
 =?utf-8?B?bkpNOVM0aEJZUnNGTjZ1UGhOVzZMcW1FbSsrM0d0Vm1McmJGUkhRTCtqWWFl?=
 =?utf-8?B?TFVJRHJ4eXJrMGNDQkNKWUFMdHM5bHRqcGN6U1RpNGtBU2JEOVRFTkV6K1NJ?=
 =?utf-8?B?T0FVcTRwMWxSZ0lxMnFXaFhEdTFHZTNuZW9SZGFxeWdDY2RqYUlIN050UTBE?=
 =?utf-8?B?TDhsUTN1Z2RGM213QTBjWDZqSUhpdnBsTXhBYkw2L2VXeVI4UnJzVE5vakZ2?=
 =?utf-8?B?SHNIRHRWUmlIYWxwNFgxaW1ueVg0VWtmbFJJVUJMRjk3N1Aydy9Nd3JnOVhI?=
 =?utf-8?B?NFRYbXgyOVdwNTVpZWR0aVZFcWh4VjcrQnBxdzhEZndqWWVZdUFvUllaSkdn?=
 =?utf-8?B?aStTTkorclRDeFFnNVZzR2FLcjQwcVRVdkdGQXA5MTF6M2dLSGhVcU40Qlg4?=
 =?utf-8?B?czhmOVpBSWhmNXI3MCtoZ0Y4dDdEeXlMSUNPNHJKaG1VNnpOUHdoVHVtOWtQ?=
 =?utf-8?B?RTdZNnpWTXBETHlRWkdzcHBZYjJGZWp5c0xmZmhTMDFWQ2F4OUVyNDAzeXhC?=
 =?utf-8?B?bCs1azJhOHkySlRrWGdCanA1bnQwTjU3S0xMaVI0eUg2UURUa3JyR2JrVnRP?=
 =?utf-8?B?ZEFJU0NJemFJVW1FUGNnOE5yK2hNc3ptcE5HazRiOU50TEdhdkZHbWM2ejQr?=
 =?utf-8?B?b3B3SjljcTRUUVN3TjJvc2l0S3I5ZlNVL1lXdjFJWWI4V24vakRMZGwzUlVu?=
 =?utf-8?B?aS9KVXVLbGdTV3hlMTRsQTRkVXhCWG9TU2luWnpCN0h3UUhRay80cWpRaXp1?=
 =?utf-8?B?OFQ1V3QwWU1BbCtnVWN0TEdXazN1V0w2eDNMbktBZDJtWEsySFZKT2hXQVF0?=
 =?utf-8?B?empvL3oxR205Q0RDUGF0eW9mRk9taVdLUTBFcW5lNlh5c2tJSWRhYklVMjI4?=
 =?utf-8?B?elNSK1JtZGhWQjhIWVdPaFYvczd2Tkp1M2padFF4L0pDbG5HanpDNjN1ejZG?=
 =?utf-8?B?Yjdxc2ZEdlNBaWFxU0ZRSlZMMElzQ1RGWnRHYU56aVNSUUMrbTZyV0dkV1lJ?=
 =?utf-8?B?ckVTcFRBMDRYcUsrMS9Pc0xJV2NMWC9QeG9HTXRtM3ptNTZHY2VmeXkxZXc5?=
 =?utf-8?B?NnV3U1hZNENJK05RK3BYZnlOMmdjSkcxajRkWGhPZHFOZ3FKTmxXaUVkZWhY?=
 =?utf-8?B?UEJNbE5HaW4zS0lDOTczMHd2QVpORFF2b2UwS3g3Z2xVMGFwNVhLQzc0QmFG?=
 =?utf-8?B?WmtFb2VxdEVuYStJSkNKcGx5MTFnaXpMNmNKR0NVZ0VJSWZ3ZFFJaHhSdEM3?=
 =?utf-8?B?TzQrS1JmZGtNOUQ0ZGNIa0pqL1J2dG9MaWdzREthNjFGMVdaRjFVQ3k4MFcw?=
 =?utf-8?B?MWNLdDNsRU13R2phb05OeWozNHgra0xYZHBiWkNlcXZJQXBMM1NLQlhuNXhB?=
 =?utf-8?B?SzJZYW55azA4Vytkajl4bnZ3Z2xFam5QaFlGZS9BRTdWb1V1Z3hTeHpoYW9J?=
 =?utf-8?B?KzJOaExSOUlMWnhUQ1B5UXRIUUF5YmVDNnlMT2xXUUdQcjBwc1VMdz09?=
X-Exchange-RoutingPolicyChecked: Q15EjX7ZxU8+//DQqGYE6ImmqjmZkZMlM5Iivny5zd2egGmmyPWHsUEkKNBanWSfN0nJM1GGWuZ6QNe8yTMLV+z9vVIYNHFw6M8Kug+QqgDKGRA1VAMrXZQAnZqz8sbpaodM7eQBkHbYh4OJwlzUDGBXJYggsKXbgmhRIVXYGPhHhJ+tMIVqSSTvXF3DhWbLj6HkvlC+DoN5VCZ6FSNCCW+CrFTAl/ekN5maAZQJv3dauyUpCUlDpilV+Xbff7fpZCxrUv0bg/+7y0xF/GgYHZmJm6esx/fFYoSyDJj+Rmte3x5XRW4lOF86X+l23llgzC7uNexU1lbTCY7DLrPtIw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 47cbbe30-efaf-481f-c9f7-08deb18aecfb
X-MS-Exchange-CrossTenant-AuthSource: DM3PR11MB8735.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2026 07:32:17.5575 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jsL9WYBuAcCQ1etCbwN3Xn/+PE4lCPZlQzt+Mb0cIQmQd0eFtsA+0NBhrRox1aPArOSZbtp7GEFzxDzm5u1Naw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6291
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.12;
 envelope-from=chenyi.qiang@intel.com; helo=mgamail.intel.com
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



On 5/4/2026 8:30 PM, Marc-André Lureau wrote:
> In TDX guests, virtio-mem plug/unplug/re-plug fails because
> kvm_set_phys_mem() unconditionally sets KVM memory attributes to
> PRIVATE for all guest_memfd regions. On re-plug, the PRIVATE->PRIVATE
> transition is a no-op, so KVM doesn't re-AUG pages and the guest's
> TDG.MEM.PAGE.ACCEPT fails.

I think private->private conversion is a no-op success, it will continue
to do KVM_PRE_FAULT_MEMORY in kvm_handle_hc_map_gpa_range() and KVM will AUG pages.

> 
> Implement the "start-shared" approach: virtio-mem memory starts with
> shared KVM attributes. The guest converts shared->private on plug (via
> set_memory_encrypted -> MapGPA + ACCEPT), and back to shared on unplug
> (via set_memory_decrypted). This ensures every plug triggers a real
> SHARED->PRIVATE transition, causing KVM to AUG fresh pages.
> 
> Add RAM_GUEST_MEMFD_START_SHARED flag and set it during virtio-mem
> realize for guest_memfd-backed regions. Use
> ram_block_attributes_state_change() to properly update the attributes
> bitmap through the API. Skip setting PRIVATE in kvm_set_phys_mem()
> when the flag is set. On unplug, explicitly reset KVM attributes to
> shared on the host side to handle the case where the guest skips
> set_memory_decrypted().

If we only want to support unplug the shared memory, should we restrict it to check the attribute
instead of resetting to shared unconditionally?

> 
> See also virtio-comment "[PATCH RFC] virtio-mem: add shared/private memory property details".

Maybe I missed some context, can you provide the link to this RFC patch?


