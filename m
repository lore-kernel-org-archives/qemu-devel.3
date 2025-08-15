Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1891ACA0EE6
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Aug 2025 10:43:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1umrtm-0003WQ-HJ; Fri, 15 Aug 2025 06:43:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1umrtj-0003Vo-4N
 for qemu-devel@nongnu.org; Fri, 15 Aug 2025 06:42:59 -0400
Received: from mgamail.intel.com ([198.175.65.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1umrtg-0007Z0-5A
 for qemu-devel@nongnu.org; Fri, 15 Aug 2025 06:42:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1755254576; x=1786790576;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=LYLFB3lif2lJqnCQ22bnH0oecHVNcQybMjgYRApZHYc=;
 b=LEaGLjdG8LNb1KLP9UkCiH1MrlPGW9Q+fvc5KtTbyg+D1hZp8YpVjymh
 7Zs3K4xvVz46RkvvdeKbv9bXBZiFQWwRk5NU1izZtgrSzS/h6gKSfKtEo
 +fa99G2CODsWQtV66qU5uxnplU1YNq8PJStNTIDtKCRyC8ZOXJnH/3bmq
 7oJzYzQPBGTyoWN8prKhJxO2R+/IcSoj9ZavSMFzSi+TNmcI7LLCnrW+e
 lHfUj9LHwRqi9wjZg6prygU013UabFb1wJAnHO/lkM5haQy7EJX9Ptoyi
 STVnX+Woifwn9CRyVZN1c8UApU34bGgq9woufM1glgYhXgnJix0e+AMO+ w==;
X-CSE-ConnectionGUID: 3rf6CQ0VQGaE5X0QcbTjlg==
X-CSE-MsgGUID: m1LqO+0GRRa5A+PyGyq2yg==
X-IronPort-AV: E=McAfee;i="6800,10657,11522"; a="61415642"
X-IronPort-AV: E=Sophos;i="6.17,290,1747724400"; d="scan'208";a="61415642"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Aug 2025 03:42:53 -0700
X-CSE-ConnectionGUID: 6PqcYY37QUa0qZSlvSDrEg==
X-CSE-MsgGUID: 7c2Za3w9Q4GYOZDGOrOC6A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,290,1747724400"; d="scan'208";a="197981753"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Aug 2025 03:42:53 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 15 Aug 2025 03:42:52 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Fri, 15 Aug 2025 03:42:52 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (40.107.236.70)
 by edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 15 Aug 2025 03:42:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mJ6cdbLa4bF0bIotAUNd2y/qA8EYLVS0uc0Sx6IoN9QR5AKqRK/lcz4QraV4VeUe0wFm0J6jf5zRfZCwgo5Ytm0jgHlUmsXoLqo3Wv5FCYYPgGEDlL6qSOrTlGvKusWB3F5I+crsWVSDk2eyHUMSqxXZdXCLtVDwQ99V5iPiJn72v2tpoUZGWn6hTyf/kN2RPfSA7/6pzcdgLUYHh9X2Y51tBAnHRWzYD316X/UiVDaCBl3TXKczkrnZY6aLp7std8AhXCYrumr2lM+HgYouY29hNzJiZMbF1R1OZj2QmRA8BihJa2SagGLZfsLuSTtm28Zqu/aME8xXxHo1uy/ZUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HKCH7/HKRGMNRWH1+zCdHCBuu1x3zcKpQHGta9ejqm0=;
 b=JCtpWLJDxPE6P4ed1r+OekozgiQn3OrzUhvjVJWcd41bSscWwVpxf8UVF0OAIu/68AnCuz20u9QHIjK8fXj8u8XkJTbutYuCUjUK4Z1R//e4yQlp9HTGmZiMLfVvz0Lobq2JNy6WzaVJ0KjmpmQehxLZ5MEGZGv1K9f8AsgD6EC9EAi2Df4Kd2L+kOagfVXqbUy+Qq5lJ/4OP7YrkKRyHHSbMjo9NuJ6Yhgz0/rFb4Owozenhzuxk/Yq2akt09hC/shk/G4EJ0qzc3hBNzDY9DZM02nhoEtzlIa5gOt3VozuzikQP9f6Af9Rb6v54JT7F8oCBX1TY2LCNdG0WrVj2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BY5PR11MB3974.namprd11.prod.outlook.com (2603:10b6:a03:183::29)
 by SJ5PPF7371775FE.namprd11.prod.outlook.com
 (2603:10b6:a0f:fc02::834) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.11; Fri, 15 Aug
 2025 10:42:50 +0000
Received: from BY5PR11MB3974.namprd11.prod.outlook.com
 ([fe80::fe0b:26f7:75b4:396]) by BY5PR11MB3974.namprd11.prod.outlook.com
 ([fe80::fe0b:26f7:75b4:396%5]) with mapi id 15.20.9031.014; Fri, 15 Aug 2025
 10:42:50 +0000
Message-ID: <70d6d913-239d-42a4-8a88-a492bf5e569f@intel.com>
Date: Fri, 15 Aug 2025 18:49:22 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] vfio: Report an error when the 'dma_max_mappings' limit
 is reached
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, <qemu-devel@nongnu.org>
CC: Alex Williamson <alex.williamson@redhat.com>
References: <20250814153419.1643897-1-clg@redhat.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <20250814153419.1643897-1-clg@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR02CA0018.apcprd02.prod.outlook.com
 (2603:1096:4:194::18) To BY5PR11MB3974.namprd11.prod.outlook.com
 (2603:10b6:a03:183::29)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR11MB3974:EE_|SJ5PPF7371775FE:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ff1b44c-6b9d-4bb6-c244-08dddbe87a69
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|42112799006|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SkNSRHBIdWtTQS92cnYzWE1YQkJZaEhPRlczdHExNTVId2JEQVpHYXpGTXBt?=
 =?utf-8?B?dWFLVWQySUtWOVRlQ3Q1d0E4RTB6bjYzWTJULzZZNmFqWUJoOUhyaFZZVGE2?=
 =?utf-8?B?NVBhWmtYdGl0T2dkSDd4aWF1dlpZY0FvZDRjT0NqVUE3WG40Z292UDl1Z2ZB?=
 =?utf-8?B?N2FHMHhsY1J1ZUJIemN6a0wzbU5uamxFV0wySVlhRE15MFVJZkVQNVlyRkUw?=
 =?utf-8?B?V0YzbXJScHQ4RUNCTGRQOFNhTEJHS1A1YWt1aENDakRVczh4bkhYSVZtRElx?=
 =?utf-8?B?YURDL25oZWp1M2Nqem8zQndkVFA0dUZGUnBiR05XaEw3Zkk1WkFuOFcrdllJ?=
 =?utf-8?B?OE1sMk11VmhWY2FyTVQrenpDbGhCU1Mrcy81M3ZMZ0JLZkdubFFLNFJ4d2k0?=
 =?utf-8?B?djdPU3N1NlZ5R0pvdTBEOHJqMmtpdlNvT2EzWE80RUxHdWdsbG93eTh2aXNM?=
 =?utf-8?B?QkdCZmxQY05aRjY3eUJ0OFU5L3RHaEpsdkNDbG5wcTdFQlJjZzNWUk45cVc4?=
 =?utf-8?B?aitiUGF5SzduOHVCeFFvTGsybERaYXQxcWcxUk94QW1oOE52T09PdlVWalNj?=
 =?utf-8?B?ODNiMFdrNXlJYU52UGVLVlhPWTV0MndsZllLT2NkT1YzdVpoUzVsbHlhWmVJ?=
 =?utf-8?B?REN6L2VnWjJVUTdKMElENFBQQmFQckUyNmRSWVNiSG5sdlpsL3VHWjdNdDFH?=
 =?utf-8?B?SEhwVStMd0JlSitQdTliYlM0YUtvZisrYUlXYVl6MjZtOWdDcVVTYjdYSTBP?=
 =?utf-8?B?NVRyR0tmazVsUGZXMUFvZGRPa3phWnl0bzFTcHl6REZLZjdnWlhobEU2T3My?=
 =?utf-8?B?c2ZMVWVxdXNNUko2ODIvOWt3Y3VJVW1iRXhHM0FzN200eUNKczdEQ0hxTnpC?=
 =?utf-8?B?VVBqcWgyZU5tNk5nNmpORlY5ZlYwWk1MZ1dvODZxVGpSa3MrWmJMQmJaYkVN?=
 =?utf-8?B?MjRZSFZ3cGhhR1BhY0wxWHFxbVlpM09aY3A0cldBV0lJM3FXeSsvT1pVVExH?=
 =?utf-8?B?b25qRG9VZlJjTHUzYjRaUWMxTUYvRGRSMmM4eWRZMFl5eVFzWWRZelVTdVI1?=
 =?utf-8?B?YnNvdnFJMjhSS1c2NlpzUGN5aVpmWmdUUGhVbkxwNEdvTndZbjFxdGV2VUxr?=
 =?utf-8?B?eTdhZUo3T0RUcW5ieFp4ZmZlR1N2Sm5ab2ZGT05tRGdlTFV0K1BYbFJBWFEz?=
 =?utf-8?B?aDFQMXdsZ1NLbzhlQ1hGQzZNckgrZkN6TlllTklPeG56bnpQZFpsdloxb1J3?=
 =?utf-8?B?VkgvOTZKM3Rhd29wQUVLaTNlbFBtQlpjM2JCQXZOYzF1MEYvdnV5dWlhck95?=
 =?utf-8?B?VDNueXlSdjdnRTFxWVBOR1JlTzRqK1B6eTJyRWFhWHh1ZWhvRmI5Z1czTXVz?=
 =?utf-8?B?K1Jwbzh2K2RSR3Yrd1RDRGw0TzZRNW91S2ZleEFhUUhBWjNlckVvczViYnNm?=
 =?utf-8?B?NnljN2xRSEV5dHdWNndOdlVEN1Z3MCtYd2NidGI1RG1NZExGdFpQVXdUcEhW?=
 =?utf-8?B?V0FWMjhNWHpqMmpuTGZxOGFVcHBva2xBUjJBYlpSMUorcWlLSVM3ckgycFJD?=
 =?utf-8?B?T3F1bllXaEhhY3pGZWthMVNTZGRUWVR3eC9UVThMR3VrdENMVC95bkt1YnF4?=
 =?utf-8?B?aVdQR2NpeXRsYUliTTFZZ3NzdTJnb1JBZlB4MGdoMFgzQ00wbVc4MzlOTXpm?=
 =?utf-8?B?YXN1emFaR1RYVkFmNlBaSld5SENDQTdmdGY0eDlBRUROa3JaSWwvQU1iUUNZ?=
 =?utf-8?B?U0kyZlAxOUFrSHgzZDBkRTlRRU01NGRrSU1ZTFRyOUVYN1ZDNHpJcllVVjFn?=
 =?utf-8?B?MnFZdXk3eWZVWkg4QWRWK2lrM0s0S1YvR0R0bXNmZ0tjdW9FdE9QWnI2U3Jr?=
 =?utf-8?B?MG9FZ2I4WHRHWEFCcktyOHJVbDdzMnBQYUZNM29VQ1Z0USs3eklrU3FuOUw4?=
 =?utf-8?Q?iBERp/4w6RU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR11MB3974.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(42112799006)(7053199007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZnIvRXpmY2hXTXl2T1YvbzZMdGw3dkV5bVpZRXJkV1EyV000Rjh1VGtuN1hp?=
 =?utf-8?B?Y3QxUDg4WGQySSt4cnBzTHp3ZjVMbnlTcExxaWRTQi9WaDRuY3piOXZhRDM3?=
 =?utf-8?B?SStyNkJLVmczSnlVR3ZVb3AzT1VkQ3dlVG90Mm1hZllrb2NTMXdTcU9TNTc3?=
 =?utf-8?B?MjVRVCtWZ0E0SksyM21QUHJVMUh4NEhrRDQxamhKaytHRjVRTmExZDg4VlEw?=
 =?utf-8?B?MnRNOTI0djh0a1VYWmhndTQ4L2JsYk1sdjhYSXFKaW52Vy85a0w2SzZWU2g3?=
 =?utf-8?B?SWdlQTBLUUNJdkJzWDNHMEpXaEhmWVJFcFlxN3NtQnBuc3VRRnVPOE1Nbm56?=
 =?utf-8?B?Tm80Yy9qYnJmWjNPdmVwbU1SdkZSMkJBNHBnVThvOWE2TjM3QXNmTDdTbXBV?=
 =?utf-8?B?MmJHb2NYbmw4UlJjc0M0YmJWSlRmaE0zaFBDSjNSQjBjUjVlWXhBZXpLK2dr?=
 =?utf-8?B?MFpDdDN6TDhwMFc5MjNQd2tPejRJYStTaFZKWGh6ZGVpN1dXNklzVVF3eElz?=
 =?utf-8?B?bXlhTFZwQ2c3b2ZkdTNWWGdBSVlUa2syNTBod1BzQTNCTVhiTHJTV29uaWlu?=
 =?utf-8?B?RlJvZXhoWkFCUFJ4VDNVVEJFSndudnUwQ0MrRVNzSzFXbHVHQVRubXBqdFN6?=
 =?utf-8?B?NGVuRVJGKzhpUE81Z0ordmtxTVZMZ2ZIWTBJWnlXZzMvNWsydzZJOGRqZUNz?=
 =?utf-8?B?MEkvcmxQUkRkdXQwMzFPRHBQOGwrc0Zzd29tYmNTb0E5bEZWTU5JKzRQZlFJ?=
 =?utf-8?B?UlVrWEYyZ3VleHQ3NVZZL2Jkem5VdDU1KzR0SUI2NGtqMkR5cnVHSXlTRVZG?=
 =?utf-8?B?YW5SVjdNV0NPQ2hDdDFBRHlsOWdsV2xhK0ZkWjA2R1dCVTNIaDNQcFFRTFox?=
 =?utf-8?B?NFcxK0NTQWpYZUdGVlJpbHV6dmY5NE1WZDFkaUZ0bDdHejllOTVWMW43MFZl?=
 =?utf-8?B?OW9GUXo2ZFFFS0J0bFZFRk91OStSa1k1NEZDTU5CYXVQYXZIUllOcTRGa1NB?=
 =?utf-8?B?K0ZWeTUwRWlDc0UzMk1OSitUMzFlY3RMdVl6elhSQXRpei8yQWVrRFVhdFZY?=
 =?utf-8?B?ekJjOTZISktmckZNTEpLcXRGT3lUcjRYamluRC9OOC9xTnhBOHZBbTNnc1Yw?=
 =?utf-8?B?aEhCK2YzSENuSGwvdWFxNWVwMDhwdU9xM3ZYOStUcnEzcC8wMmk5UVRjb2xK?=
 =?utf-8?B?YVZtTTYwQnZSZVVJT2VGaVZMSFI1Mi9KN3RDRkxxbkQ3OHQ0djFVV0ZrWVVm?=
 =?utf-8?B?NzAyeUVCWFhwdGNCdUp2UjIwWkFSZTFkeGlaTmxKYkoyRUY3ZU42UDRGRFZC?=
 =?utf-8?B?Ym1CQ1gydlIyL2d3TzZXNTdIWEZKc0F5eFhVU004eHI0NklnL1RtZ3hEcEdS?=
 =?utf-8?B?SWtTZjBOZjhpU3NNNkZrcHFyK0lyVXNNWWdDRS9ZQjZVLy9SSmFuK0hzVUUv?=
 =?utf-8?B?K2lDVjlPVi9peEFTdWtNb1VsRHIwb2dLbmJaSFVqb2VhTFRDQ2Nnb2NsM09r?=
 =?utf-8?B?OXBJcDREZFp4WGlJZnlUbFFpblBlNi9sRDk4TTVuUDZjYlhrUVcrbkRGQlk3?=
 =?utf-8?B?NUNoN1FNYUxROTZCNXZ3elZ4dDMyZVRTWE9VZTJxVktkejIwQmZYNGZTRlR5?=
 =?utf-8?B?OHkrQndlOWZyUHpLRXJTOVhiZnFoTVVxYVRMUWZsWmExaE9ER0VKYVZQQzVH?=
 =?utf-8?B?R0VaaUlJZit4SFJON2UrNFJnZEpkMHZ1Qmhxd0RqZ2NVYWw4bWpMMkZiTUdp?=
 =?utf-8?B?SCt6eDNCSkhJR2NlK2ZNektnL2cyRlZUOWJsbC9VWFhYZjZmYXdlM294byt3?=
 =?utf-8?B?NGRwNFNxSjVYeGw1M2RpZFJqNjdPWXM0cW9wUERsaGZYTkxYSm9JR1d1NnFm?=
 =?utf-8?B?OXZSenNvSXowTFNsTmwwVXVieGZqZDBTK0VFM1BSbU9XM2xqV3VDRGFTMXhZ?=
 =?utf-8?B?c1Y1R001eDU3NE4rZHQrV3lXNytsVVJpQjhkcXlkTzVEbVAwckgzOWl3b1p5?=
 =?utf-8?B?eUZlMTF1akNaamNuOWJmS3ZGa2xxSkE3ajd3MFQ0OCtoVkdnZUFMQ21rRms5?=
 =?utf-8?B?dUl0RmRMQXZpaFNrWnFKdUZ1WDBJSXdCbWhDN2dxU3dUVXk1Nml0RzNYNktQ?=
 =?utf-8?Q?VBUDaMeRYsbEjBQvFeWEMhKDB?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ff1b44c-6b9d-4bb6-c244-08dddbe87a69
X-MS-Exchange-CrossTenant-AuthSource: BY5PR11MB3974.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2025 10:42:50.0923 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +MAepXDBLISgb8+6eCNUWgc1mPUFRdgylnVamtgH0Vvj24Da/0E1heYOo5OTohvPdbeDY7kFaTwJ5wsEkQ3VOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF7371775FE
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.14; envelope-from=yi.l.liu@intel.com;
 helo=mgamail.intel.com
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

On 2025/8/14 23:34, Cédric Le Goater wrote:
> The VFIO IOMMU Type1 kernel driver enforces a default IOMMU mapping
> limit of 65535, which is configurable via the 'dma_max_mappings'

@Alex, I've a long standing question, could you share why 65535 is the
magic number? :)

> module parameter. When this limit is reached, QEMU issues a warning
> and fails the mapping operation, but allows the VM to continue
> running, potentially causing issues later. This scenario occurs with
> SEV-SNP guests, which must update all IOMMU mappings during
> initialization.
> 
> To address this, update vfio_ram_discard_register_listener() to accept
> an 'Error **' parameter and propagate the error to the caller. This
> change will halt the VM immediately, at init time, with the same error
> message.
> 
> Additionally, the same behavior will be enforced at runtime. While
> this might be considered too brutal, the rarity of this case and the
> planned removal of the dma_max_mappings module parameter make it a
> reasonable approach.
> 
> Cc: Alex Williamson <alex.williamson@redhat.com>
> Signed-off-by: Cédric Le Goater <clg@redhat.com>
> ---
>   hw/vfio/listener.c | 13 +++++++++----
>   1 file changed, 9 insertions(+), 4 deletions(-)

Reviewed-by: Yi Liu <yi.l.liu@intel.com>

> diff --git a/hw/vfio/listener.c b/hw/vfio/listener.c
> index 184c15e05fcb388cf0848e97e1eb283f17a50ad4..bc40ec8613c71a12b8c0dfdea497a14a446ac1fd 100644
> --- a/hw/vfio/listener.c
> +++ b/hw/vfio/listener.c
> @@ -250,8 +250,9 @@ int vfio_ram_discard_notify_populate(RamDiscardListener *rdl,
>       return 0;
>   }
>   
> -static void vfio_ram_discard_register_listener(VFIOContainerBase *bcontainer,
> -                                               MemoryRegionSection *section)
> +static bool vfio_ram_discard_register_listener(VFIOContainerBase *bcontainer,
> +                                               MemoryRegionSection *section,
> +                                               Error **errp)
>   {
>       RamDiscardManager *rdm = memory_region_get_ram_discard_manager(section->mr);
>       int target_page_size = qemu_target_page_size();
> @@ -316,13 +317,15 @@ static void vfio_ram_discard_register_listener(VFIOContainerBase *bcontainer,
>   
>           if (vrdl_mappings + max_memslots - vrdl_count >
>               bcontainer->dma_max_mappings) {
> -            warn_report("%s: possibly running out of DMA mappings. E.g., try"
> +            error_setg(errp, "%s: possibly running out of DMA mappings. E.g., try"
>                           " increasing the 'block-size' of virtio-mem devies."
>                           " Maximum possible DMA mappings: %d, Maximum possible"
>                           " memslots: %d", __func__, bcontainer->dma_max_mappings,
>                           max_memslots);
> +            return false;
>           }
>       }
> +    return true;
>   }
>   
>   static void vfio_ram_discard_unregister_listener(VFIOContainerBase *bcontainer,
> @@ -576,7 +579,9 @@ void vfio_container_region_add(VFIOContainerBase *bcontainer,
>        */
>       if (memory_region_has_ram_discard_manager(section->mr)) {
>           if (!cpr_remap) {
> -            vfio_ram_discard_register_listener(bcontainer, section);
> +            if (!vfio_ram_discard_register_listener(bcontainer, section, &err)) {
> +                goto fail;
> +            }
>           } else if (!vfio_cpr_ram_discard_replay_populated(bcontainer,
>                                                              section)) {
>               error_setg(&err,

