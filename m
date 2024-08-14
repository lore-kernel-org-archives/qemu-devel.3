Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E63EC52D7C
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Aug 2024 03:04:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1se4J2-0004Tp-Kn; Tue, 13 Aug 2024 23:04:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1se4J0-0004T0-PE
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 23:04:10 -0400
Received: from mgamail.intel.com ([198.175.65.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1se4Iy-0005uF-29
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 23:04:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1723604648; x=1755140648;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=0EdEyHMbftKDmWdJ1cZbBHgaqnz9IPpHaa9V8Y1ALL8=;
 b=N/EAyoYKEjvVDGQtr/b27veRFVRwGV1mD/UgB7ABgToClqQFKKSQZ7gQ
 tHf2Wi7gtG7Y3E0KAHX5+3brv/2emxmFt/3X7+klVBKpQxNvc/neUHgQ+
 ZI6H0qcZXmQ5yt1aJ6KU87jFlqKp7XTD+hP2UNTsKkgbr6547KhG2Mkp/
 ukr2PNvRD9otj49HXPClS7YCfTgp5mR1HAbdEeoeFzRKyGeSjEs8yGSZm
 NuHNMdq5ltefCyAacMM4SJvGUhQMg0FHlMyDYztfUtZXjb6C8taBz3lZB
 ipaRm2tGNEjby/FoOBRUKIaA0LO/vatAdFsc0szH75FMsOdsA/V3vkp4c w==;
X-CSE-ConnectionGUID: 0QYfXwWGTQChKOJsMfvFqA==
X-CSE-MsgGUID: 5e+jd6TnRouEJSSLMZfeVg==
X-IronPort-AV: E=McAfee;i="6700,10204,11163"; a="44317981"
X-IronPort-AV: E=Sophos;i="6.09,287,1716274800"; d="scan'208";a="44317981"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Aug 2024 20:04:03 -0700
X-CSE-ConnectionGUID: sVncwlCJSKGKOyuvaRK7LQ==
X-CSE-MsgGUID: mTmER1y5TwGtEBziVDEE7g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,287,1716274800"; d="scan'208";a="58864914"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
 by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 13 Aug 2024 20:04:03 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 13 Aug 2024 20:03:55 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 13 Aug 2024 20:03:54 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 13 Aug 2024 20:03:54 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.41) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 13 Aug 2024 20:03:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nfzaTglSWBpm69zvtF57dhy7VjJx92vayqquP5sCtpCQ0DSJQFlDWo+s3Ef6Ek74C/LEQjeLBSCc1PUEp4y+BxiCpw7Ycdt6YzhN/EXTY32xV0SMv4vPVNms70/XIYqptJsBKm87+Ped1H5l0zM9Nw1RCk55nGOfGoTTb95Y4qPH4x2lZdkpJg4FsmG/KjmsK6AyztL+Hogc5UIvqv2+NgmjunzrOO0iopqWde+io8Cj2239spPaexhI2+jr9rav/cgzsHyMaxT5rczqn5l0PY7k+ac6WVn/iNMb5mapgequZQKR/D6ZNl2HhpUc+suU8uQ7yWUlLq352o9DsmStiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gRPwzTWQT1UDXMlNbi+BdDj/evLatABl7KtNeO5HVic=;
 b=OIz6WJWq2gt2yd86j/rxIMY8dZHoSRoS71uIDL3jqSJ9osYVbegAYrutPuXN0OdYTLAIdBOQNdU5gslw5pwJacyQ7wcLqCD+I3B3hm9GPI8XvOiZZKj/ZbJ3VnCg0Ht2wEB9f0I+TM1Ny4L+4dmzyC/q4QGH3xsiuWiAFHdXoMeVoYqkLaOfwfbM//p/VnX4b+icvBaSDeczYs9noG0T5EVbjcDktkszR/pjJ3rZBSsUCPWMzD3G4xJfaLhGKc4+tcE81i/CeM2Paw7kJL92IQGAe+SnnVUeJKOTtHQoCAcD28sEsKNHldToOEhYpHx4881NEz9iYz1xc1MzFwxt+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by CH3PR11MB8703.namprd11.prod.outlook.com (2603:10b6:610:1cd::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.32; Wed, 14 Aug
 2024 03:03:51 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a%3]) with mapi id 15.20.7828.030; Wed, 14 Aug 2024
 03:03:50 +0000
Message-ID: <a08417ee-8315-45a4-b065-c6787db92f4a@intel.com>
Date: Wed, 14 Aug 2024 11:08:05 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] intel_iommu: Make PASID-cache and PIOTLB type
 invalid in legacy mode
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, <qemu-devel@nongnu.org>
CC: <chao.p.peng@intel.com>, =?UTF-8?Q?Cl=C3=A9ment_Mathieu--Drif?=
 <clement.mathieu--drif@eviden.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Marcel Apfelbaum
 <marcel.apfelbaum@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, "Richard
 Henderson" <richard.henderson@linaro.org>, Eduardo Habkost
 <eduardo@habkost.net>
References: <20240814022654.2612780-1-zhenzhong.duan@intel.com>
 <20240814022654.2612780-3-zhenzhong.duan@intel.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <20240814022654.2612780-3-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR02CA0127.apcprd02.prod.outlook.com
 (2603:1096:4:188::7) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|CH3PR11MB8703:EE_
X-MS-Office365-Filtering-Correlation-Id: 38ca1e09-064a-480d-9b4a-08dcbc0db90e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bGJrREozYU9Vc3VhMDlvb083SDlNQkFpWlpBZGFSS0c5bitEY1lhVnp1WEJu?=
 =?utf-8?B?eUNLZndJQkRjMHJoRE8xTTFLYzB4ZWhCRFdkKzY0YWFhRzU5SmEveisyU01K?=
 =?utf-8?B?TlBRcTl3RWtPT0lhWnhIWXNxMmpyMmVsSlBTaXV2N0pmckkxRTdINXBUSXJj?=
 =?utf-8?B?V0I0bThsc3FoczNnRzViL2lJMGhMY21ET1h3U0VIZ0dJbEd6dTNjMzR2dEM5?=
 =?utf-8?B?QnZFaHYrWUhDR3NsdS9SOHIzVnVpWVE1VTMyaFZqU2ZlOEg5VVVmbnBsVkxa?=
 =?utf-8?B?Z3hDdUVrQTROLzlDYkVZU1RXWmFFYnVCRVZLYUQvMFQrK1hPaWpTL0tyMm5t?=
 =?utf-8?B?SmdSOVduS2VnOHV6dVErblBNY3RRdmxuY1NPenJGdkNDVlNkK2ZSbzM0bFl0?=
 =?utf-8?B?WWhzL1UyTGpwZE1iVVFtelRDK1JXcXhRNExTRWlMcGtaSTZHc29zQlFuZDho?=
 =?utf-8?B?a3I5ZWNPT1h0c21GcmoxNXBoK2dPNnJkczFyU3luTEQ1Vks3S2FLVnpMWXQ3?=
 =?utf-8?B?RWVkRTlQOXd0aFJ6UnNPTUJUb1kzSFpvekhaZTNFSHMyZVZLZVFrSEtFYVZB?=
 =?utf-8?B?ZW1uVXZpSVlrdklpRkxNV0hocENxQkJkbHNMcFFYYjFwWGtRT0VKWHdjOG13?=
 =?utf-8?B?OEFSWEpSMWhMWUcybnJWR3l4Wk9KZjFlaUlBaHpBeTQzU0ZkdHpkWEFUNS96?=
 =?utf-8?B?dTF1MGkxWFNBYU01NWpPVXdtREJpYng3bEh4blBpZUtPRk40dGNlZkxQakNx?=
 =?utf-8?B?L0trWHBlR1lSWWk4SDk0RVM5L3BEVVo5ZTJlMHNuUjk3aG53QVhwQ21hdm8w?=
 =?utf-8?B?S041S21nZHBtR2pKZnFhV09OWnU0RTNmaXpqczFOS3M2Q1AwY3lGNE9zazh0?=
 =?utf-8?B?dms0bXhOM0VPL1hFUlI5bTE4OElzK0FxN0lKMkUwQWU5bkhET1IyMVBXRWZO?=
 =?utf-8?B?d0hIcWdCeDIwUFNVVS81TTJRMUduOVp4YkFEaWI3aEN5NTZtZzF0aWcrVGwv?=
 =?utf-8?B?UnNkVWVTUkdJbnpSYlN0dGdDa1FFNThIY3R5MlIwdWpZVVMrRnBCMk5GYWhL?=
 =?utf-8?B?VDBJRVpOdDY1MXJuOFJpRnpoTTdDeEo5YXBGazNHdForM0g4dDRoa0pDcnU3?=
 =?utf-8?B?aGhZdEFRTTJvRUQ3NnNSM1hKWXlqV1Q0R2hMNWE0SzlSNTJTVHBtRSt2QnlS?=
 =?utf-8?B?cXFwTTZQMlhJT3lsajU0dnh6MXEvUFh3YWdFSWtKamlUQTZBWkcwUUFQcWhr?=
 =?utf-8?B?ZEgzazZLdHhrSkx4MVUvK2J3U29paGpvVnhpZWVqb3UxRHB6UzY4cWo1bnBP?=
 =?utf-8?B?N1d6bCtJd2hyRUFObTluT2d5ME50cGZQaWdIOG9ZOTJmMFA4Sm45YmlCTk1w?=
 =?utf-8?B?NWVuYXJZcWttSmNLMGV1SWgxRUU0N2JxMFZoRlcxL01tYTlJeUJ6aElOUjJ2?=
 =?utf-8?B?SndqT1hQdktwb2JiMVh3N3g5UlgxU0xvVmg3ZmpsR24vb0NuZG9nMzJFT3Av?=
 =?utf-8?B?TVpBdDFrdmpIdlcrUzRvMzB1ZzZRVk9ocVBIWUlBaU5EZzdwbzBEQVVDMzha?=
 =?utf-8?B?UzFkV0Y0Sy90aVluUlQ3U3JWSUNhMXFXZUpHZm54NHNkdXVGN0R2NDNEQ2ln?=
 =?utf-8?B?SUswd0V0KytpMjg4Z0wvUCtKZTN6Y2piVHh6Y1ZQbkMrNTdhSXNseEdZU2ho?=
 =?utf-8?B?S2plZ2UxMFFYTUdGUFhMUitoZWY1d2J4SjVxamVzK29pbE8xZ3hBaGtYYXRP?=
 =?utf-8?B?VUtRMWloY1lRS3FyYTdLNU16ZjdCR3MwejcxL1F6Um1HSzNaY1lwWmNvY2Uv?=
 =?utf-8?B?NVIzZGZpV3g0MnBEN2J2Zz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7529.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dlYreWY0VVZpSHhQMFF6VGVCc3F6Y29CS3JiRlp0YThURFdNMFpwY0dzMDF3?=
 =?utf-8?B?NHgxUE55cENFQ1RIV0JMSFR3SmtyNndXUUljTnNMdVozTnlEK3JzaUFzQTJH?=
 =?utf-8?B?UEJ5UWxJaUpCRHNDNXB6RFpEYzhWWDd0Z2NTZXFOOTltd2dNZy8zZ1BjSmlN?=
 =?utf-8?B?WmlGNlpORzZTYVU0WGZ6Vi90VXhncENjMXNwYkM1cHFXY1YwSExzSzVpSzdQ?=
 =?utf-8?B?TkhwNnJJSElvVXlCLzl4WXJQSXdFeXlLZGUvWm1mZCt6eUJ3WVhZQndEdTFX?=
 =?utf-8?B?cTFMU1dJSzVjSTJJdi85V2tVelR5TzU5dUVwREFPTzFGUUF3eW9qZitrMlVq?=
 =?utf-8?B?UjRRNitBOXAxYThWRTV4akwvQVhDNUhCTjIvUU4vWEJudGNtWlN2SURJNkpX?=
 =?utf-8?B?dUJQcUdxODBBS0o2dnFqWUlTY0lkTEpyUjJQQ0tjUHFKYU03R1cxbUJGTDNS?=
 =?utf-8?B?R2xzSGdvYm5BTlBTMENUQUZFSXp6OWVSc1RXMW1BTDNrZzBaejFFOUhCdGZr?=
 =?utf-8?B?VHlpbDhSaFFJcGlJUHRZZWZNNk0vYVVJZHUvaElySUtnSVZ3N01FazZpeWZo?=
 =?utf-8?B?WWtVVDlRL1RxS3BwVTFlVUpxVkFJUWYvVXpsaEg0emEvQlhycml4YlhmdlUr?=
 =?utf-8?B?MEtUM0tDb0hwWDJWU2FLcHBwNHlKNXpiZnVVNUt2TFdCMUk0TWJ5bk40MHdF?=
 =?utf-8?B?RG05b1p5VzdweGV6QmxmNndCV3FhdXRIc0FDa3VmQWtQVWE3VEYvbnB1eklu?=
 =?utf-8?B?d1cwZVVQVXVXUHJEaCtTUDFXelpEdnZlM3ZQc0lUb3dwYzdCQlhqTTRQM040?=
 =?utf-8?B?c1FVeGI5akowRmRISW5FanNhSWlydzJyclNvVXlUYmtKVFMyYlhlMkJJK3JS?=
 =?utf-8?B?clRiSExSSTEwQWJHeTFkQWpXcVdkckhVb3grSkI5d2pTSmZIUVo2Y0ptWHRK?=
 =?utf-8?B?S2g5eFh3THVtYWVWZzQxcWMxUlJEY2Nya0U4MmZSN21nR2JWNGlyaE56V1NY?=
 =?utf-8?B?U2tkNy9xMDNWYVk5TFBmSENhbG9HOVIxYmVQdXBOY1J5STRkTWZVVHJmdEs5?=
 =?utf-8?B?dzRTc29yMkJnNUxVN2tTK1J1Zy9BWitSdG5JYktkRkovbndHUnlQVVhjYjMz?=
 =?utf-8?B?ODdEZEZKYVVNNXFIdnJIeFIxU3pGeXZ6OXBGbEdGL1lvWFJZZU9OU1poOHNX?=
 =?utf-8?B?anRtUmlBQnJtbExNbEFOckc1Mjh3WEdyUSt5bjA0bm1yYUFEQUpGRlhJZzd4?=
 =?utf-8?B?RkcyRWpJYW1BT3hLUjUxbGhyOFVKT2t6VjExMEkycEhydU4vV213TXBlazNP?=
 =?utf-8?B?c29hZ2NDb3JwUkN4dzdTOHRXaEE0QXlIZGRwYncyekdsSUF6WTBUOWxqSHBR?=
 =?utf-8?B?cE4vWlV5WmNvMXhxT2p4dndlSWNyTXBVc2w5SDZtV0hRay9yNFJRWFNjZHh6?=
 =?utf-8?B?REN5YVN1RVdjK3l2bDR6VVNZekpsNE5rTVRWVGhtU2d3Y2tuZ2dZZXg5MXRm?=
 =?utf-8?B?NkFpWVlkUExVVTFpa1pBRmhGdkJMMGZBZTF3enNWWUNOMkpxODVnRFN1UkI4?=
 =?utf-8?B?NHBRc1Vta2NMUkhHazZjYVRRYW1PU00xVFBHWG1wbFRKUWN3WUtWbWNFN2Nx?=
 =?utf-8?B?d2ZvRWg1M0RlZTJKZXhaaEtqY1IrekR0bHlSUUZjVEdPdnJCajFSKzRIRG5M?=
 =?utf-8?B?akNZVEJxMENPVno2MTJFSWJWRFhFMk50MEM0Qk0wREZ2TmovcXZoUXI3TjVB?=
 =?utf-8?B?QWYwRDlCYXVUWHBoVW0vckp3NFE5TWxZUXRNS0taNWxMQWR3QlBUc2doOFd0?=
 =?utf-8?B?RHlSd3oyWmZZYzRxaU9LcU9JQVNyTStkemljNk8rM2lUWXJzaTJTamlZOExl?=
 =?utf-8?B?d0V6RThPb3A0clpOK1NmRGxoQVpOQlhzVzNGMnBKekdpeFVjbmV6ZjJIWkpz?=
 =?utf-8?B?NC9xTThOOEpSNTR0c0RHRytZR3R2SWF2WmUzbWtZMVZzOTlwZ1NwVk50ZWV0?=
 =?utf-8?B?b3Q4RncyWEJRZGlMZVV5M0VLVTRxYkFsdTh0TVRTeHFjMW94VzFndmE4endQ?=
 =?utf-8?B?MU9Kck5waU1lQlpBYlBDeEZRemY4a2EvRGgxbXFRVFdqc3RHNXhlUmhsb01i?=
 =?utf-8?Q?fnfDqwWiVuToLXB9WCaLVJlxh?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 38ca1e09-064a-480d-9b4a-08dcbc0db90e
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2024 03:03:50.8164 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oMNSPbe8F7RjfSWKsd07toQAoY98ILIAaB13sWgMoltPNdBPXT6huEldzgsins2yLVUkx2AVlXktludDoHMr8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8703
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.9; envelope-from=yi.l.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.125,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 2024/8/14 10:26, Zhenzhong Duan wrote:
> In vtd_process_inv_desc(), VTD_INV_DESC_PC and VTD_INV_DESC_PIOTLB are
> bypassed without scalable mode check. These two types are not valid
> in legacy mode and we should report error.
> 
> Fixes: 4a4f219e8a1 ("intel_iommu: add scalable-mode option to make scalable mode work")

4a4f219e8a10 would be better. :)

> Suggested-by: Yi Liu <yi.l.liu@intel.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> Reviewed-by: Clément Mathieu--Drif<clement.mathieu--drif@eviden.com>
> Reviewed-by: Yi Liu <yi.l.liu@intel.com>
> ---
>   hw/i386/intel_iommu.c | 22 +++++++++++-----------
>   1 file changed, 11 insertions(+), 11 deletions(-)
> 
> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> index 68cb72a481..90cd4e5044 100644
> --- a/hw/i386/intel_iommu.c
> +++ b/hw/i386/intel_iommu.c
> @@ -2763,17 +2763,6 @@ static bool vtd_process_inv_desc(IntelIOMMUState *s)
>           }
>           break;
>   
> -    /*
> -     * TODO: the entity of below two cases will be implemented in future series.
> -     * To make guest (which integrates scalable mode support patch set in
> -     * iommu driver) work, just return true is enough so far.
> -     */
> -    case VTD_INV_DESC_PC:
> -        break;
> -
> -    case VTD_INV_DESC_PIOTLB:
> -        break;
> -
>       case VTD_INV_DESC_WAIT:
>           trace_vtd_inv_desc("wait", inv_desc.hi, inv_desc.lo);
>           if (!vtd_process_wait_desc(s, &inv_desc)) {
> @@ -2795,6 +2784,17 @@ static bool vtd_process_inv_desc(IntelIOMMUState *s)
>           }
>           break;
>   
> +    /*
> +     * TODO: the entity of below two cases will be implemented in future series.
> +     * To make guest (which integrates scalable mode support patch set in
> +     * iommu driver) work, just return true is enough so far.
> +     */
> +    case VTD_INV_DESC_PC:
> +    case VTD_INV_DESC_PIOTLB:
> +        if (s->scalable_mode) {
> +            break;
> +        }
> +    /* fallthrough */
>       default:
>           error_report_once("%s: invalid inv desc: hi=%"PRIx64", lo=%"PRIx64
>                             " (unknown type)", __func__, inv_desc.hi,

-- 
Regards,
Yi Liu

