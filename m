Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CD07CCD184
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Oct 2025 12:27:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v7v9v-0004JE-AX; Sun, 12 Oct 2025 08:26:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1v7v9s-0004Ix-Er
 for qemu-devel@nongnu.org; Sun, 12 Oct 2025 08:26:41 -0400
Received: from mgamail.intel.com ([198.175.65.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1v7v9o-0002Je-JB
 for qemu-devel@nongnu.org; Sun, 12 Oct 2025 08:26:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1760271997; x=1791807997;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=TATFnkTl3tjO7gH26UH406gwV+htC6FzNkk617vtQgE=;
 b=K9Mep6ZhzXNNVg4K7PicndR03QhAGYCuu9e9d+GaVZSJNMiwFu3xkuZL
 g+0ob1FG5pjAbBxTUN4J994zXECmzMi5Q3JGRylZ3Mn6PpKCp0CZqWj+d
 IIfDkFHZ9ERNgnkX05CsBAxnltrVWMnCfqYr4e+QUp8g3zakvAawjIFfk
 21jNjvYaaXRDZlg6679hVvl5PBMw7qq269UQTco8Ve4DRqcZ/JJP+0M/G
 Qsm6JpJUrb8Zxf4sseTqsTLgXVh5dqg6/Hmm6DXyQUe1t4IR69PJEGjsy
 oWgwh4L/nez09+38V3TYadl6P1D6PpzB7kaTxLrJb5UCui/LQddNrV7b3 Q==;
X-CSE-ConnectionGUID: 52t8UCN/SVq0wHjcc2ol+Q==
X-CSE-MsgGUID: c56hCcTgTJ6CPhgn75+mlA==
X-IronPort-AV: E=McAfee;i="6800,10657,11580"; a="73869895"
X-IronPort-AV: E=Sophos;i="6.19,223,1754982000"; d="scan'208";a="73869895"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Oct 2025 05:26:33 -0700
X-CSE-ConnectionGUID: 5fXvm5RQSnqyYeQH4JUTaA==
X-CSE-MsgGUID: ojF5dIcKRrWsGg5eoiMiAA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,223,1754982000"; d="scan'208";a="185631661"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Oct 2025 05:26:31 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Sun, 12 Oct 2025 05:26:30 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Sun, 12 Oct 2025 05:26:30 -0700
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.59) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Sun, 12 Oct 2025 05:26:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MrvywMTQpkD/BwIoxabcJ5AwNDHsfMjwWN5GAWzA+ZuYdwC0SlOLrJZG6uyZ4Zm/ESMRE1Q9KVArNlGqo02n76kR6E6sWh6gYyAAoGLSZO9cmLXlz6Aey73P4h1isd49W0Q9whM68k+/oqo/gjG5ZKZprbaIKB0og6uC2Ny0Ibhi6LEUhrrmGu6c8Up8+zp2BaOVIXvlJokVMVXhGgVt8sOsUNWyxKAA8qGkoNgwYZBMOPud4WRmyvncacvuftAJoYn99RlhotHNtO5CnKxjdpdhSp9lPF+QIJazzpkhnHDb6AmC8dKCojMy+t8JcnIb5wfE6fUF54IKdBae6nORkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=URlCH0CZbyBCBnhmNWR4l4aIljasHlTzthM1SWX+rZA=;
 b=Q6hduk6F8ledmwXegC9R47eX4VYMOa93UMkfl/NvaJ7TEtRgAFRKqd2rIqOrOr9wQDEe42dh1GJgOlqoEwrfqO4kKrUI/jQGKmTaHHRx+ItybO4SbBYJh55Z2CGx6xsh3h7cjxX7+dR4kbreeb8oWNH61OyjExiMiK7KCoXRtGn/R9LWcV8U7qgRc/V3POsnjAeWaZC2TvjWYKbRfpH7imT98fAyDBx5k+bp7dN6RfHMdHhtYygmlDPHCRn/eiR36oq2m5W30Zv1L7avpjXwNw4D4c8fvq+kQbPNiqtTzLg9r6epILvaBUARXhLCIKDm83hho2HaOPjE/YIxTSauVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ0PR11MB4798.namprd11.prod.outlook.com (2603:10b6:a03:2d5::12)
 by CH3PR11MB8704.namprd11.prod.outlook.com (2603:10b6:610:1c7::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.12; Sun, 12 Oct
 2025 12:26:27 +0000
Received: from SJ0PR11MB4798.namprd11.prod.outlook.com
 ([fe80::d946:6abf:6e7e:fd1e]) by SJ0PR11MB4798.namprd11.prod.outlook.com
 ([fe80::d946:6abf:6e7e:fd1e%7]) with mapi id 15.20.9203.009; Sun, 12 Oct 2025
 12:26:27 +0000
Message-ID: <969be9c1-247c-461d-9fde-b583b6a9f3d5@intel.com>
Date: Sun, 12 Oct 2025 20:33:14 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 08/22] vfio/iommufd: Force creating nesting parent HWPT
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, <qemu-devel@nongnu.org>
CC: <alex.williamson@redhat.com>, <clg@redhat.com>, <eric.auger@redhat.com>,
 <mst@redhat.com>, <jasowang@redhat.com>, <peterx@redhat.com>,
 <ddutile@redhat.com>, <jgg@nvidia.com>, <nicolinc@nvidia.com>,
 <skolothumtho@nvidia.com>, <joao.m.martins@oracle.com>,
 <clement.mathieu--drif@eviden.com>, <kevin.tian@intel.com>,
 <chao.p.peng@intel.com>
References: <20250918085803.796942-1-zhenzhong.duan@intel.com>
 <20250918085803.796942-9-zhenzhong.duan@intel.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <20250918085803.796942-9-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PSBPR02CA0001.apcprd02.prod.outlook.com (2603:1096:301::11)
 To SJ0PR11MB4798.namprd11.prod.outlook.com
 (2603:10b6:a03:2d5::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR11MB4798:EE_|CH3PR11MB8704:EE_
X-MS-Office365-Filtering-Correlation-Id: 1cb4d8a5-c337-4bd2-81bb-08de098a90f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|42112799006|7416014|376014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?U04xRFA5N0FTdkZhTDM2MTRrQldCNDlkd1VReC9qcDFOOFRjaWJ3RTJVSDBz?=
 =?utf-8?B?bkdoalR2UnM5VCtYL3VpdTNIUnFLT3hkVmNRcjFrNys3QWlCQmdYd3p6dllI?=
 =?utf-8?B?d1FNNzBmM2RpLzNwYnkwUVdYeW1GcVp2amdrNjIvT0J2T1QyYTFuR0o4bDBq?=
 =?utf-8?B?MXIweno0aEZ1U2xxMVBZclZIcndoZmZoeGU1NVVaNFp0Zk55cjVRbzRDSFMv?=
 =?utf-8?B?YkJrWnpvbjkzejNUM1l5K3ZtNndyQ1ZWd2U2WWwrN0dGNVJheFlnTlRYZUtT?=
 =?utf-8?B?ZUVyblFvOW9XaW9acXlJVU5KUmVVbWZmV1BZWjhNaG9NOThINHltR0lzbWkz?=
 =?utf-8?B?cVZ6d1czVkhkOUhoMzlIZE5wWnpjcmtCRUR5QXdsc0xMdjZJVnJnN2haZ0JE?=
 =?utf-8?B?WGJ2c2JRSm8vQWF2YkQwby82clNlRTdQSmZzT1hndDlJcEc2R1FJMnF3RkNv?=
 =?utf-8?B?Q1czcTVuM3lhVWNScFhmSyszN1pvN3NPVWI2ZjJCNUNISktYdUtOdzVRc2NT?=
 =?utf-8?B?Wm5xcHorMjNSa2NwdUhGOTdWVGw2NGFZKzNIcGh5TUtjRGF1eGd1QUtqS1RC?=
 =?utf-8?B?SlpOVzJCbzhJeVVrMEhiYnBud1ZjSjZEQzBQb1lXamJPQ1dPcHA0bW5hcWdY?=
 =?utf-8?B?Z3FJd25VWjN4UFNtaUFHRzMrQzFiVEZsTHBPVmxuRHVEaUV4ajlwZVVFbEox?=
 =?utf-8?B?QkhzbzNKM1FEWjNVY1JmVUVjV2J2NzNtYnBJL0Y2US9Va29DQ2lNRDhBRmt3?=
 =?utf-8?B?U2YxVGhiTTg5ZVFZYUpmeTJ2dGFqSEhKWHRra0diS21IU0xBNlZRNjFYU29C?=
 =?utf-8?B?VEl5bGhGUDVnS0JHL1FCUUlZeE9sVnZjaHkvUjFCQnh0WWRXZ0Jxa0dJQWhM?=
 =?utf-8?B?UVQ3TStraXhlNWRyNHZXMW01VUFIZkEzY3hIbWVGNlJoc01COFQvYkZGMjZE?=
 =?utf-8?B?cjFIQXZXZlpJQ2VsamJGdHo5MDkxV2d0WkJZOHFDZm5OY0ROUS9lWDQrRDkr?=
 =?utf-8?B?NTlqS21sTHFzWlhZdnllMHZFZ1RGTnNmZkRlbGtkZWZ1Zkc4T3UwNUNIMVZq?=
 =?utf-8?B?cDMreERvRXBUT25Bd1JOdHNQdk1oeG1wR3gvakorcEZnQ0xxNnVEZmRlYTV1?=
 =?utf-8?B?cU51a1ZVK1kvTXVxL29FVHhIbnBleWtpYjRUUUdlVkVIN1diUCtwQWt3NmRB?=
 =?utf-8?B?Q1AwTWJ6TG00NmoxM0l3ZmxnbHJTV2REbEJMN0V0eFpoKzZCUWR1LzZCWXVq?=
 =?utf-8?B?Qk52Q2djdjNnWWVULzd6bWt2NWtOc0k1OVVHeVlRdVlOTjhtMnZwanlkdjdX?=
 =?utf-8?B?YytBYXozTnhWMTlXZ3BGaE43a2RZTVExUVNZblowZ2ZvdG04WDZkWGtHNkwr?=
 =?utf-8?B?Wm9DRUtlNjVZWmFiNUhwL0x4dy9DbGNSZnRWQUx0TFVkdU5hRGxKazVpVi9w?=
 =?utf-8?B?cWV2bzNCZGh2Slp0YUxrWDlQWTR5RzJFbjJTWU1EMjF0OEx1bm55c25mQTZS?=
 =?utf-8?B?TTBoQzhwTG1LZE4vaUVUMDdkOHRNRnJOOExobm1wMERJRlNqZXh5VmVSc3M1?=
 =?utf-8?B?QndyRjVuTkl0eVJzc3VVSExKSm9BdEhRRk5FMFRoYkNrLzM2a0RHM2dDVXNv?=
 =?utf-8?B?TFc4Q3R5SlgzOFFjUkl6YXZNTExqVWpVMEVSMkVsbHgyVHBJeEtoSnlJREJK?=
 =?utf-8?B?aXdnenVMc0g5WVVTMG9VM3JZMkNVSFdxZW9HZjlIQXArclJJWVlhRmNiZDdl?=
 =?utf-8?B?OFhoRGZjRllhTndxMGdFMDdWbTJkUnVWOFo2WG1mQ2hSYytVVDJRbnp3SzNS?=
 =?utf-8?B?cVIrbWN5WU5EVU5ORmI3ZTZ6OVZ4SXVaRFpQL0lieVdibDFkUTJaYVJYVk5X?=
 =?utf-8?B?TGZiYmwrSGVNS1R6czNMNWpFa04wZEZSOHJwL1k4N3FoVXp4L1dvUEIyMUMy?=
 =?utf-8?Q?Cw2okF69HwTuZ/V3WKkmeUgzIlDpEace?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB4798.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(42112799006)(7416014)(376014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VzF6ZnRpbndrZXRtc1RVS2ZtU0NQeHM4UHk2ZXpwYUpYYTQrd1o2WUNVZ2tW?=
 =?utf-8?B?eUFQK25pZFdzY01GR05ZWlVlWjZ4elViNU5Kb2F3Skp2UGpYQ2hmekxwWHVM?=
 =?utf-8?B?RGxRN0ZFTWFQT3VqZnVKcEltbmh4MTQ0TFRpWFpJaUMwTWMvb2hGSmo4R2Jt?=
 =?utf-8?B?c1QyQzJaT2RINkhrMXhKQnVjQ0kybHl1TVNGa2dRRTlPdkt1aWJGOHpBY3Rs?=
 =?utf-8?B?M3BhNkxNYTNaTmVqRk5Fb0xBUnlkVGd3L3kyL0dPcDRYWEpXSXZJK0Irb2xQ?=
 =?utf-8?B?Q3hzT1JDSWZuUVo4U2hRUVQya0RXVktsdkt2cWQwN1NzS3BwZzJZTTBjdUJt?=
 =?utf-8?B?TjYxd2wxaUowdHIza3BXZWwvSHFyczNCek4vZ3czZVVwV1llQkM2VDIwclR3?=
 =?utf-8?B?L0RFMHpYSHIyRUFNRWVsS1VhRGgxNmtLTm54blIxVG1Rai9DdGxpSzJwbElD?=
 =?utf-8?B?bW0rVUtZSzBENTl4cVdlbnFkVUhGSUMycHJ6UFNia1lXa0pGc09QamlVZjNZ?=
 =?utf-8?B?QTFKZ2xBNVBERGRIRk4zSC9BS1RPMmlaaXpQcVBjRDJoWC9OTUV1bDZJamNQ?=
 =?utf-8?B?NzN6MWZxbzFnN3FzaDNvbzNrTHFsMGZZV0trTDlFbytZZFY3dWt6SVRXbnlu?=
 =?utf-8?B?a2JUcDJnWEZ3VWFLbVNWZTg3eHIvN3orTjREMUtrbHVkbVN4SG5XVmlrQ1dy?=
 =?utf-8?B?b2V5ZjFvRWxycGFwN09xYUhUR28xQWlFT2J3eVovRzFIRmJ1TGx3bURRTTFE?=
 =?utf-8?B?Z01abDgrbGsweENFOE9Id2NGa0dZQjQ5c3dkMTdJSlZKZlA0enpIVWhodzdv?=
 =?utf-8?B?MG1nd2dQUGRyZG1JeE1YSmhnRDVKY1k3c2pveXIxeFdIL1VyNEJocytvVVJi?=
 =?utf-8?B?R2RBSDVHWXRpQ2g3S2NnNUJmR25BWVBBTXg0aEJOcVFkVnRML2dTeTFvWnNB?=
 =?utf-8?B?cHhqZ29VMmtRU2hOcEVuM1I1aGd6U1JIV0NXbDM3NTRobHdxRHloNjF6d1lv?=
 =?utf-8?B?VUswZjFIeXpXek5rcyt6SzNLOHdOTWNQZDhURkNiRUtOOXhYNGJmQUhqcjlm?=
 =?utf-8?B?eStpV21UcjZPaWd5bWd2Y2NTb2hObWtabS9pRGNzd2t5YmYzWWFZYUhjb1Fl?=
 =?utf-8?B?Wnc0ellaci9WaC9BdjA5bUx5cEhNc1Q2bStnU1pjRG40NHhBYjVBclAyOWEz?=
 =?utf-8?B?MzRUN1dwendpdUhsSmNMUUJRcU5KaXdaaktwU2ZFZk8xeWZoRzZiL05FUHcw?=
 =?utf-8?B?RDIyS0pSQzNOMy9OdEFrcmd5c0xoNTdlbko4V2F1OXAxQXgvay9nUWU5NHps?=
 =?utf-8?B?VW1tVTlsM1VLQThKdDIxL1RjcExjcXBETEtscFJjcnBPMTNyZC9QYWdwRVNl?=
 =?utf-8?B?OUFYd3J1blN3N2orSEJvYmlvY2ExaTloZWUzQkVuYzBraCtGakJNMDcxSGtj?=
 =?utf-8?B?VE5pblBWVHB3ZUxJNEY1eEV5SkFQYTRrMjJvVGp4OHBtQzh3SU9YK3djNk1u?=
 =?utf-8?B?YTZUNXBOeWJaWGdOZnYrUnlPV1lvTEJHQndBeVNob2RZbDMzU3NNYUMwRm5h?=
 =?utf-8?B?UGswWjNYbWJWU1N1KzZyMy96NVJtaEFST0JTcjVYRFp6QlNmQ2x0ajBWMzg0?=
 =?utf-8?B?U1hsemcyNW5BaDRiV1Y1SWpVeHVIdU9Wd2gvaTJDcUhHK1ZmRlhGSEYwRnpK?=
 =?utf-8?B?R1VFbXArZUcvcmRnTjdWY05paXNsZVZGN3V2TXl0d2JsNHJtNzFMc1hobjJu?=
 =?utf-8?B?YzhncUliMUNDU0dadjRQY2VEOElkUDM4dlVxcUFHcytrOE1qOFYyRTdYRFNu?=
 =?utf-8?B?RFN0UlRmejJqTTV5ZithRGJObkN4SmtXWU9PTHZsQTg5dGZXSDdWNEQyMk1l?=
 =?utf-8?B?STlLaTd5ZlpxZlg2VUNsNG11N1d5dVhGUUp6dlpOVjVuSmhVa3lnYysycXp5?=
 =?utf-8?B?ZlRxMU9OeWMrNDlNODdFVGNzMVdOVGEyTDNDc0cwQ1gzZmNET29uZUVwMzl1?=
 =?utf-8?B?MWhKVE1SMFFXaXAvUHlnaFVSdkRidnhYaFNOMmdjN0RHWGh1SllGZTJKVUc5?=
 =?utf-8?B?dlFuZ3RMUFo4NE56Y0JhQlJ0eUpPaXcrMWJTa0d6T2NCUGphQU1xTGVDSi9n?=
 =?utf-8?Q?rEnxAMFcWby/op/+bkF2CXjBJ?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cb4d8a5-c337-4bd2-81bb-08de098a90f0
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB4798.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2025 12:26:27.7194 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q/vOTJbQfB30flwFYUwWVgenL3k/kd0STOyY3M8UHZFcn0OvcGerE8v/mrn5TL+LvD3l8xQMQQvJUw9nNeffKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8704
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.12; envelope-from=yi.l.liu@intel.com;
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

On 2025/9/18 16:57, Zhenzhong Duan wrote:
> Call pci_device_get_viommu_flags() to get if vIOMMU supports
> VIOMMU_FLAG_WANT_NESTING_PARENT.
> 
> If yes, create a nesting parent HWPT and add it to the container's hwpt_list,
> letting this parent HWPT cover the entire second stage mappings (GPA=>HPA).
> 
> This allows a VFIO passthrough device to directly attach to this default HWPT
> and then to use the system address space and its listener.
> 
> Introduce a vfio_device_get_viommu_flags_want_nesting() helper to facilitate
> this implementation.
> 
> It is safe to do so because a vIOMMU will be able to fail in set_iommu_device()
> call, if something else related to the VFIO device or vIOMMU isn't compatible.
> 
> Suggested-by: Nicolin Chen <nicolinc@nvidia.com>
> Suggested-by: Yi Liu <yi.l.liu@intel.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
>   include/hw/vfio/vfio-device.h |  2 ++
>   hw/vfio/device.c              | 12 ++++++++++++
>   hw/vfio/iommufd.c             |  9 +++++++++
>   3 files changed, 23 insertions(+)
>

Reviewed-by: Yi Liu <yi.l.liu@intel.com>

> diff --git a/include/hw/vfio/vfio-device.h b/include/hw/vfio/vfio-device.h
> index e7e6243e2d..a964091135 100644
> --- a/include/hw/vfio/vfio-device.h
> +++ b/include/hw/vfio/vfio-device.h
> @@ -257,6 +257,8 @@ void vfio_device_prepare(VFIODevice *vbasedev, VFIOContainerBase *bcontainer,
>   
>   void vfio_device_unprepare(VFIODevice *vbasedev);
>   
> +bool vfio_device_get_viommu_flags_want_nesting(VFIODevice *vbasedev);
> +
>   int vfio_device_get_region_info(VFIODevice *vbasedev, int index,
>                                   struct vfio_region_info **info);
>   int vfio_device_get_region_info_type(VFIODevice *vbasedev, uint32_t type,
> diff --git a/hw/vfio/device.c b/hw/vfio/device.c
> index 08f12ac31f..620cc78b77 100644
> --- a/hw/vfio/device.c
> +++ b/hw/vfio/device.c
> @@ -23,6 +23,7 @@
>   
>   #include "hw/vfio/vfio-device.h"
>   #include "hw/vfio/pci.h"
> +#include "hw/iommu.h"
>   #include "hw/hw.h"
>   #include "trace.h"
>   #include "qapi/error.h"
> @@ -504,6 +505,17 @@ void vfio_device_unprepare(VFIODevice *vbasedev)
>       vbasedev->bcontainer = NULL;
>   }
>   
> +bool vfio_device_get_viommu_flags_want_nesting(VFIODevice *vbasedev)
> +{
> +    VFIOPCIDevice *vdev = vfio_pci_from_vfio_device(vbasedev);
> +
> +    if (vdev) {
> +        return !!(pci_device_get_viommu_flags(&vdev->parent_obj) &
> +                  VIOMMU_FLAG_WANT_NESTING_PARENT);
> +    }
> +    return false;
> +}
> +
>   /*
>    * Traditional ioctl() based io
>    */
> diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
> index 8c27222f75..f1684a39b7 100644
> --- a/hw/vfio/iommufd.c
> +++ b/hw/vfio/iommufd.c
> @@ -379,6 +379,15 @@ static bool iommufd_cdev_autodomains_get(VFIODevice *vbasedev,
>           flags = IOMMU_HWPT_ALLOC_DIRTY_TRACKING;
>       }
>   
> +    /*
> +     * If vIOMMU requests VFIO's cooperation to create nesting parent HWPT,
> +     * force to create it so that it could be reused by vIOMMU to create
> +     * nested HWPT.
> +     */
> +    if (vfio_device_get_viommu_flags_want_nesting(vbasedev)) {
> +        flags |= IOMMU_HWPT_ALLOC_NEST_PARENT;
> +    }
> +
>       if (cpr_is_incoming()) {
>           hwpt_id = vbasedev->cpr.hwpt_id;
>           goto skip_alloc;

