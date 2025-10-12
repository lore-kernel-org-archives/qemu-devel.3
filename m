Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5880BCCD184
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Oct 2025 14:52:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v7xQG-0007mA-W6; Sun, 12 Oct 2025 10:51:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1v7xQE-0007ld-Ma
 for qemu-devel@nongnu.org; Sun, 12 Oct 2025 10:51:42 -0400
Received: from mgamail.intel.com ([192.198.163.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1v7xQB-00009p-GA
 for qemu-devel@nongnu.org; Sun, 12 Oct 2025 10:51:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1760280700; x=1791816700;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=FcPC/m5JKGeOyTkEbq/eXzhFhqTr+zpj1gLGoO/mAgo=;
 b=kr6sJ6/mBWuQ3ycZY6ACxFfjlEgP1OO+pd5PyZ0au24LJYRw43s70NE+
 U/PkvPkHEfTDREjDp/n/V3/3axl/4l3miBX2qJiVRIQ9/2MGHpvlRAOek
 dNi3sbqfvDjH8G8KyUuP/igM2Emod35FtXChE66ZdnfnPg3MijS1DtP+x
 8Afkeo4Xywbus1jnEtENpxmmmRWg775MZ9kla+03MbOuPbNKf/eFpjWiy
 FR+JLLNDfg9Dtv3Qk+kuOOh2jmQYRN63vlJb+kfGd6rvaUdQGmIJV18DK
 VSCvNHuoxBreRpJzVeAqJc+os2EZqDpMji0YP4ALUnOYPZqpRgOecTkpw g==;
X-CSE-ConnectionGUID: gtI451wGRCmgy4HVRRWgCA==
X-CSE-MsgGUID: ZWEZ31wSSLOA5vx6OBlIEQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11580"; a="62468866"
X-IronPort-AV: E=Sophos;i="6.19,223,1754982000"; d="scan'208";a="62468866"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Oct 2025 07:51:36 -0700
X-CSE-ConnectionGUID: 5PpcO0LKSx+xQRumvF6gPA==
X-CSE-MsgGUID: kOQyEoJuQsmZz9MlTQdH1g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,223,1754982000"; d="scan'208";a="181069202"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Oct 2025 07:51:36 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Sun, 12 Oct 2025 07:51:35 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Sun, 12 Oct 2025 07:51:35 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.4) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Sun, 12 Oct 2025 07:51:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LfDlJPxO5Ze4ItNQutCee9KB4GTrOaSEa+F5WeEQLp5VQ0v8iT6iBz2c5dMXFimxzOE7Be7W5IUZgchvhK9uESDGx2sPtIlKJZCdq27kQYfwdsHYGFb8pAIp/puvVJzhlEe3VvOjMxLJN30QucIV2GyyQPQ3ZVoPh75/DX21Kif7PxziciBs/dW/BBfes8XH7YUXGOu15k51r+b4frPVxnqiybLNskdkcaR6H8uyqNfOplrKDqf6SO408ZfRwNl+bQKb7+NXaEBk6JJOK6oQ56XHOp5B/U1oxeZXomJ57FVBiUz81a/B6MkSomXBTE4TTYVVLnxB+soxrzI9vhsZIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7PQKtnZWUnubkxFkJYGpKEnuVB2K39j88OKeTgpQttE=;
 b=KaF2JoDlMrcLtZzkblBUEINgj6jGnOZ8LZNvPLmqQ1QKeDccbVaHAvEXvm1+UH3xiHmsOqEvdpn36dsGHUn9KllQXdefcDDs3HNr9moKF+0z6Ii7FBQ9K86EpVtRJu9YH+OagmuA25+Qfm5panL1hss1Xfxu392/Tvz+Dx+9Stevqlg1KnhW8yMD16Wx/5iLhyN3V9+XhDPYlXxu3PiVKAWXDdlFDfgbwMTpsMQzIu7U4U/HXL75n6L3r4TrtOjRZga1qKd8/3UhhdC+SKeGQaiLlXKuUdBrx0h88YBPZxUeq7WPeFhzDRTVs65Y7R3pq6eA75Ajx8QDKr/mMqFpfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ0PR11MB4798.namprd11.prod.outlook.com (2603:10b6:a03:2d5::12)
 by SJ0PR11MB5133.namprd11.prod.outlook.com (2603:10b6:a03:2ac::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.12; Sun, 12 Oct
 2025 14:51:33 +0000
Received: from SJ0PR11MB4798.namprd11.prod.outlook.com
 ([fe80::d946:6abf:6e7e:fd1e]) by SJ0PR11MB4798.namprd11.prod.outlook.com
 ([fe80::d946:6abf:6e7e:fd1e%7]) with mapi id 15.20.9203.009; Sun, 12 Oct 2025
 14:51:33 +0000
Message-ID: <42881757-3e8d-437e-80e6-aa2d409523f6@intel.com>
Date: Sun, 12 Oct 2025 22:58:18 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 12/22] intel_iommu: Handle PASID cache invalidation
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, <qemu-devel@nongnu.org>
CC: <alex.williamson@redhat.com>, <clg@redhat.com>, <eric.auger@redhat.com>,
 <mst@redhat.com>, <jasowang@redhat.com>, <peterx@redhat.com>,
 <ddutile@redhat.com>, <jgg@nvidia.com>, <nicolinc@nvidia.com>,
 <skolothumtho@nvidia.com>, <joao.m.martins@oracle.com>,
 <clement.mathieu--drif@eviden.com>, <kevin.tian@intel.com>,
 <chao.p.peng@intel.com>
References: <20250918085803.796942-1-zhenzhong.duan@intel.com>
 <20250918085803.796942-13-zhenzhong.duan@intel.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <20250918085803.796942-13-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG3P274CA0016.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::28)
 To SJ0PR11MB4798.namprd11.prod.outlook.com
 (2603:10b6:a03:2d5::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR11MB4798:EE_|SJ0PR11MB5133:EE_
X-MS-Office365-Filtering-Correlation-Id: 650c4c37-6186-4255-fccc-08de099ed5c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|42112799006|376014|7416014|366016|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dEtsWCttYWR1TS9WeHFCVkQ5bHNDcmt4ZWtESGVTQUtJaCttd2RLbUE4cTc3?=
 =?utf-8?B?NmdPZVRvT2dkbDFLTER3T3dRanF1L3cxbHczUy90VUJLaXR2NkwyOE5IbTV1?=
 =?utf-8?B?VXZxcmlkc2Z2UzJ4M3dhV2dMTGI3VGpBTDRvNzNGMHJFVUVoelFoZTI0Q3N1?=
 =?utf-8?B?OFhzUUNrcnBNdFA1TldCTVc1RWVzczdjaHZOY1ZPbFZNK1czL2QvUDFlQmhS?=
 =?utf-8?B?R2JFckxVOFBYNkM4UHNUeWFoVjgwZ2NYeU9lZFJxOFROOUVraW5xMEZ3Yjdp?=
 =?utf-8?B?UGNTSGxtelJHMDl2Rko5WWdQcExXNGVsb0ltV1h2UXc1ZTlqaFdpWnpQWDM4?=
 =?utf-8?B?UUJoUUgzeHlSOU1FRGh6VytvaTBCaEZnc3RlS25aYU5yUlpoWU1lRnZpcWhn?=
 =?utf-8?B?SDMzd2E5b3lnL1FpOCtyVk00MUY0dkJTMkFHVEFwOFVsMmovcjBkQS90ZVQw?=
 =?utf-8?B?TzFlZTVtYjF0bjA0dVdMQWJ1QXA5MTJFSUNuTVZuRFU3Sjg5V1lrS0oyVVY5?=
 =?utf-8?B?UUNsTTVJdHUzLzYxYXhrL3pJWFdmVVp2TVcwQ3ExNDVIRlNiMUpZSHFUUGhI?=
 =?utf-8?B?azMxWUZGcXhOK01aeGczQ1FBQkpyVHI3dzc5QVNFcnV5ZG9yeWpEUXYxVnAx?=
 =?utf-8?B?d0wzcVNlY29DWnhab2tKS2tDM3MvazFaYlJIdUwyQklndlNCS09CaEdVZUpG?=
 =?utf-8?B?NzVYaGU5aytBcmF4ZTd4ZDhOUzFNL2JxZmhPL1MrM3VIZWh5b1ZLeHB4ak9u?=
 =?utf-8?B?dmNTcmIyVDJHODFQQ2VuN3lsMDZ6cDd3RlJyVkhjOGxaQkROQkNXNW1QcEMw?=
 =?utf-8?B?TkFJRzJPbkdnczVPSjRUWnBFOFhhb0hpZWNLUU82d1grQmM1RXZMbjFNamFa?=
 =?utf-8?B?ZHN0NjVhUVl0UEZ3OFlSZVVDMmpZNDBDTG9JWmlQUnByR2NFWDBFRStWVUo2?=
 =?utf-8?B?dXJFN3FHdjZkWmtBU1g1QVRlTm5vNk9hWnVWU3FaQVlncXBmdDRPNG5TYXJL?=
 =?utf-8?B?bXBXVGxwY3F5OUlmTXIwbVRWai9ySnA5L2N6WDJScUkrTnhFb2U3MHZ6S2k2?=
 =?utf-8?B?VkRuV0NvVnpvbEtBUll5TWxSWExKZC9OcmJUV3RDUEhBeEo4bFM4SnJZNWc5?=
 =?utf-8?B?WnV0WkxTeS8xOFY0ZWRBaGtrUGhpcXl0dDNVdnk5blBCVXFvbnJKZlliMWtD?=
 =?utf-8?B?VHJldWkrai9pVlBnNi9Zb2t6Rm94ekFPamFrdDdTaXNuL3lhamNTc2ZOVXlr?=
 =?utf-8?B?eHc0aHZTN0QzRVhWUWdiTlJpTHEwb2xGNUpnUlk5b2JsdXhjQ2QrcVdQK2Zm?=
 =?utf-8?B?UVl4cGJvKzdLWm1TLzMzUXZiZ1BtUjJZdXMybGhjUkJ0QjQxbTl1ZlNBYk5x?=
 =?utf-8?B?eVpGVEc0Tng1cEt5R0YxVUdoUUtCbG5VUk9rREhBbm83QklGOFlIZVB0cHZz?=
 =?utf-8?B?cmNNaE9za21EQmRrdUVRN3BtaG45SGhZOCtoN24yYzA4NU1vaWE2U0tTamh1?=
 =?utf-8?B?SGk1bHNsS2RyRTRHV3NWcmpFMmZjSGdqSktTaUhjT0NMSVU2N0YvMjN4VGJr?=
 =?utf-8?B?cWlYcjhNT0lrbmszNm8zWEhmdVNuS1dIZmFBNEZ1akY0UGFtNG9RRnVNRWRJ?=
 =?utf-8?B?RTlSS1kvSDZtdDZIVUlkRkUySC9MakM2aTNkbmFBZmZ6OVYxbU5EZzJzdE5a?=
 =?utf-8?B?ZWhFbW1iVG8yZExhL2tPWjlWZ2wzVTJlMXFYYlhsdDJvWlpjZmlUWHRWTWZT?=
 =?utf-8?B?eVpnQ2dCK3RZWkpnSzdKa0NWanl6Smt2MklNWnFIdFlJN0tpd1lSR2RyOGQw?=
 =?utf-8?B?c2NHd1FyWThIb2gwWHdidHR1OXZ3bVpqbEM5dFNjQjFLNWgwYWI1ZldrY1ZJ?=
 =?utf-8?B?bGNwdXd5SHlwbER6MHJmZkFreHU5MElQRGxXdkZ0cE55dmJCUjczTnVZQWpv?=
 =?utf-8?Q?1GRiIl6oe/G+LodLkZOGlGomNdrUnnCG?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB4798.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(42112799006)(376014)(7416014)(366016)(1800799024); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WlBDdFEzTU9mRll1ZDJwakQvTnhNd0dQamJDa1puQjU0SjFvdVlIVHdwdXVj?=
 =?utf-8?B?Q0drUWFUdFZkR0tFa0g3TzkvMVR6VmlKdUhnbVdhVytEQTI2eE9YNXBsakkv?=
 =?utf-8?B?MHBDQ204cm9DLzNvNGRHa0JqdkhYTzc3Rm9IZHpacGdzbjVHSG50ZGZ5UGUz?=
 =?utf-8?B?TWpLcTh4bGZFQjBRa28rMkppOVVFaFhGRFdWMVdrNUozRHN4SHVHQmR3L00x?=
 =?utf-8?B?czBzbUZacmFTekFRSGYzZzdWRlhyL0lpNkE2bm13bkYvWk90OEhwUjU1Y0M3?=
 =?utf-8?B?eGNHRTRqaEYzZTBnS1pHbHphZUZGek1FaXM4Y2xUSmhVMEtrT2l4NERQK3VF?=
 =?utf-8?B?dWR0aFJraXN5KzE0RlRsdStmaERETlZETGlaZTVrdWdpOFF0T0ZWMGRRbE1H?=
 =?utf-8?B?WTBRbk5pZjJVL0NEenpqNCtyNlhQRXRvejNoSitzY3FXclZraTVIOGF1Y0pa?=
 =?utf-8?B?OTZYOERNTW9lR1M5aldXckIzUnlDOHNnWWRNTXpEMUxRRTBMdUNGQ2F1TUkr?=
 =?utf-8?B?QzI2aHIxekdEYkpBK3JTK2J5YjcyVFhPaHFCSkplTHZNRUZrWDU5dFBqSWtj?=
 =?utf-8?B?UWQ3M2QxS1YwaGxwb1lnWW9IL0RSRnZGeFRRZENVdjFZOStaNVIyRkZITUZT?=
 =?utf-8?B?aG9LSXdaK0YrQlZSSmpSNFJIcXhzQ0tVQ0EyYkxNYzNKY1Y0S25WQWJkRkp1?=
 =?utf-8?B?WnE2b1pwMEtxRUh0OFpDV3hWdlQzN0VaaFo3UjNoR0ZJNHhZUFFQcWZGbjVk?=
 =?utf-8?B?OVAvN2xBVmJ5blRWRDQ3WCtSd1phSHcxekYxeHFzMldpQWpzRE0vcy9HK3VF?=
 =?utf-8?B?QjAvOS9pdFY4TTRGc01nVzVzajRQU2FjcmRWZTAwUUhZcHNUMkUzWlJiU0Rp?=
 =?utf-8?B?aFpLYTVYWVJRVXZJdUdmem5USDUySTVTS2JYSS9tcFhJbjdmc2pDeVF1WWgv?=
 =?utf-8?B?OXcyUVJGOWdkTmJZSnVPZEV2Z1NmMGF5bEN4VFluRlNQQ2swaUZvd2ordnUv?=
 =?utf-8?B?dHFpc0lvTis3MDJVUDZJMnJETmtTVkVObHlLekQyRjBBcitqZ0U2bmQ4VXUx?=
 =?utf-8?B?U0tXTHRWa2VVQVdueTBDSHlNbEVzSWtXVDdOWWJYVHhkR2p2TkVkVFEySmxY?=
 =?utf-8?B?REVPMXo2Zk5pbVp2VkZsRUNGWitWSHd3V29yTHkzNGFTc1VPZ0piZ3JVd0E2?=
 =?utf-8?B?Q1VTVzYvcVFvZndLWlU1aGNhK1pQckdGaDQyeGN2V2pKa1VjbDNZT2RCMnZE?=
 =?utf-8?B?R0dJekNEbHUyR2xKR216ZXp3UHZtcVNrWWhwejBRYmlkSkFyM3NLbkZCOG5h?=
 =?utf-8?B?Mm90WlZudmtuRVVxTTkvUlQ5a3pBVXF0NkVzVEJUbjBOVHZ5eU1OUlAwcm1D?=
 =?utf-8?B?QTNxOXVraXlSN3YrK2dHRzI2YmFxRk9aUmJUNlBZMTVSYjZ3NGpJVnBhN0Qv?=
 =?utf-8?B?TVpJQzhmQUU2ZTZES3h2cy8vL2JKZjlIYy9RRnhTR1pYc2lCbDZZNGxQMjhj?=
 =?utf-8?B?L251UUJZbWFna1JIeUtWMElJSWY4eHRSa1Q5dDhsZGY2bmdCTjd1QTRVYmU5?=
 =?utf-8?B?WVczdmpjNUNJRzJHK1FwdnM0RkFVVGMrQWdlQTU4dXNpRzE2ek5mZ2o2enBj?=
 =?utf-8?B?Y043MGJmVVdCSjZXRjhiYTYyWWZ6L2tkQmoyZFBsS0N3blFLV20rYVFJRkhT?=
 =?utf-8?B?ZGZsYkJDS3N5WU1PRFpDY3hsVzg3OEtwMm5nLzR2WUIwemdNWnk1L0UvTWdl?=
 =?utf-8?B?a3ZlWmF4UGZqWm12RTVIdFdiMTdYMUg2eHhCcUw1MFp2UVlsYUNaUWswOVJM?=
 =?utf-8?B?TnJHN2lkd3NETTFvY0RrQmM5R3k3YUNoY2JiWnJpRlRZcURBejhhWEpYZGxY?=
 =?utf-8?B?UHpENGY0UmxaV0I0OTYzc2tiU0xoYXhKTHpjQUgraTU0US9tMEV6UTRMVDFz?=
 =?utf-8?B?eGNIN0x6ZHJRUTZ0bHpUVzZ1MkRUMGNXby9LeGtUWFdrYTcrWDEvWnZLU3RO?=
 =?utf-8?B?OWxYTU92bHV0emlWZlQzK3dSZ3FEMkVwcnZZTUtwbU5hL0ZFS0NKYnBZbEJr?=
 =?utf-8?B?WGZVME0xNDc3RnUvM0NJcTVDcjJXeGJ1enFKT25qdkx4dnl4ek1pWUlFV3Ru?=
 =?utf-8?Q?+Wf4OdO7gMQVY3l2ZeGVyVa28?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 650c4c37-6186-4255-fccc-08de099ed5c8
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB4798.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2025 14:51:33.2089 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ocCuByeugks0YCuydLyvrW3HGljtKEaP+aiBIkKMdHXkW4S0sKnRE1ZFtH7NS84MdBd/hvwRJPxiEgeRF95HVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5133
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.14; envelope-from=yi.l.liu@intel.com;
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
> This adds PASID cache sync for RID_PASID, non-RID_PASID isn't supported.
> 
> Adds an new entry VTDPASIDCacheEntry in VTDAddressSpace to cache the pasid
> entry and track PASID usage and future PASID tagged DMA address translation
> support in vIOMMU.
> 
> When guest triggers pasid cache invalidation, QEMU will capture it and
> update or invalidate pasid cache.
> 
> vIOMMU emulator could figure out the reason by fetching latest guest pasid
> entry in memory and compare it with cached PASID entry if it's valid.
> 
> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> ---
>   hw/i386/intel_iommu_internal.h |  19 +++-
>   include/hw/i386/intel_iommu.h  |   6 ++
>   hw/i386/intel_iommu.c          | 157 ++++++++++++++++++++++++++++++---
>   hw/i386/trace-events           |   3 +
>   4 files changed, 173 insertions(+), 12 deletions(-)
> 
> diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_internal.h
> index 9cdc8d5dbb..d400bcee21 100644
> --- a/hw/i386/intel_iommu_internal.h
> +++ b/hw/i386/intel_iommu_internal.h
> @@ -316,6 +316,7 @@ typedef enum VTDFaultReason {
>                                     * request while disabled */
>       VTD_FR_IR_SID_ERR = 0x26,   /* Invalid Source-ID */
>   
> +    VTD_FR_RTADDR_INV_TTM = 0x31,  /* Invalid TTM in RTADDR */
>       /* PASID directory entry access failure */
>       VTD_FR_PASID_DIR_ACCESS_ERR = 0x50,
>       /* The Present(P) field of pasid directory entry is 0 */
> @@ -493,6 +494,15 @@ typedef union VTDInvDesc VTDInvDesc;
>   #define VTD_INV_DESC_PIOTLB_RSVD_VAL0     0xfff000000000f1c0ULL
>   #define VTD_INV_DESC_PIOTLB_RSVD_VAL1     0xf80ULL
>   
> +/* PASID-cache Invalidate Descriptor (pc_inv_dsc) fields */
> +#define VTD_INV_DESC_PASIDC_G(x)        extract64((x)->val[0], 4, 2)
> +#define VTD_INV_DESC_PASIDC_G_DSI       0
> +#define VTD_INV_DESC_PASIDC_G_PASID_SI  1
> +#define VTD_INV_DESC_PASIDC_G_GLOBAL    3
> +#define VTD_INV_DESC_PASIDC_DID(x)      extract64((x)->val[0], 16, 16)
> +#define VTD_INV_DESC_PASIDC_PASID(x)    extract64((x)->val[0], 32, 20)
> +#define VTD_INV_DESC_PASIDC_RSVD_VAL0   0xfff000000000f1c0ULL
> +
>   /* Information about page-selective IOTLB invalidate */
>   struct VTDIOTLBPageInvInfo {
>       uint16_t domain_id;
> @@ -552,6 +562,13 @@ typedef struct VTDRootEntry VTDRootEntry;
>   #define VTD_SM_CONTEXT_ENTRY_RSVD_VAL0(aw)  (0x1e0ULL | ~VTD_HAW_MASK(aw))
>   #define VTD_SM_CONTEXT_ENTRY_RSVD_VAL1      0xffffffffffe00000ULL
>   
> +typedef struct VTDPASIDCacheInfo {
> +    uint8_t type;
> +    uint16_t did;
> +    uint32_t pasid;
> +    bool reset;
> +} VTDPASIDCacheInfo;
> +
>   /* PASID Table Related Definitions */
>   #define VTD_PASID_DIR_BASE_ADDR_MASK  (~0xfffULL)
>   #define VTD_PASID_TABLE_BASE_ADDR_MASK (~0xfffULL)
> @@ -573,7 +590,7 @@ typedef struct VTDRootEntry VTDRootEntry;
>   #define VTD_SM_PASID_ENTRY_PT          (4ULL << 6)
>   
>   #define VTD_SM_PASID_ENTRY_AW          7ULL /* Adjusted guest-address-width */
> -#define VTD_SM_PASID_ENTRY_DID(val)    ((val) & VTD_DOMAIN_ID_MASK)
> +#define VTD_SM_PASID_ENTRY_DID(x)      extract64((x)->val[1], 0, 16)
>   
>   #define VTD_SM_PASID_ENTRY_FSPM          3ULL
>   #define VTD_SM_PASID_ENTRY_FSPTPTR       (~0xfffULL)
> diff --git a/include/hw/i386/intel_iommu.h b/include/hw/i386/intel_iommu.h
> index 3351892da0..ff01e5c82d 100644
> --- a/include/hw/i386/intel_iommu.h
> +++ b/include/hw/i386/intel_iommu.h
> @@ -95,6 +95,11 @@ struct VTDPASIDEntry {
>       uint64_t val[8];
>   };
>   
> +typedef struct VTDPASIDCacheEntry {
> +    struct VTDPASIDEntry pasid_entry;
> +    bool valid;
> +} VTDPASIDCacheEntry;
> +
>   struct VTDAddressSpace {
>       PCIBus *bus;
>       uint8_t devfn;
> @@ -107,6 +112,7 @@ struct VTDAddressSpace {
>       MemoryRegion iommu_ir_fault; /* Interrupt region for catching fault */
>       IntelIOMMUState *iommu_state;
>       VTDContextCacheEntry context_cache_entry;
> +    VTDPASIDCacheEntry pasid_cache_entry;
>       QLIST_ENTRY(VTDAddressSpace) next;
>       /* Superset of notifier flags that this address space has */
>       IOMMUNotifierFlag notifier_flags;
> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> index d37d47115a..24061f6dc6 100644
> --- a/hw/i386/intel_iommu.c
> +++ b/hw/i386/intel_iommu.c
> @@ -1614,7 +1614,7 @@ static uint16_t vtd_get_domain_id(IntelIOMMUState *s,
>   
>       if (s->root_scalable) {
>           vtd_ce_get_pasid_entry(s, ce, &pe, pasid);
> -        return VTD_SM_PASID_ENTRY_DID(pe.val[1]);
> +        return VTD_SM_PASID_ENTRY_DID(&pe);
>       }
>   
>       return VTD_CONTEXT_ENTRY_DID(ce->hi);
> @@ -3074,6 +3074,144 @@ static bool vtd_process_piotlb_desc(IntelIOMMUState *s,
>       return true;
>   }
>   
> +static inline int vtd_dev_get_pe_from_pasid(VTDAddressSpace *vtd_as,
> +                                            VTDPASIDEntry *pe)
> +{
> +    IntelIOMMUState *s = vtd_as->iommu_state;
> +    VTDContextEntry ce;
> +    int ret;
> +
> +    if (!s->root_scalable) {
> +        return -VTD_FR_RTADDR_INV_TTM;
> +    }
> +
> +    ret = vtd_dev_to_context_entry(s, pci_bus_num(vtd_as->bus), vtd_as->devfn,
> +                                   &ce);
> +    if (ret) {
> +        return ret;
> +    }
> +
> +    return vtd_ce_get_pasid_entry(s, &ce, pe, vtd_as->pasid);
> +}
> +
> +/*
> + * For each IOMMUFD backed device, update or invalidate pasid cache based on
> + * the value in memory.
> + */
> +static void vtd_pasid_cache_sync_locked(gpointer key, gpointer value,
> +                                        gpointer user_data)
> +{
> +    VTDPASIDCacheInfo *pc_info = user_data;
> +    VTDAddressSpace *vtd_as = value;
> +    VTDPASIDCacheEntry *pc_entry = &vtd_as->pasid_cache_entry;
> +    VTDPASIDEntry pe;
> +    uint16_t did;
> +
> +    /* Ignore emulated device or legacy VFIO backed device */
> +    if (!vtd_find_hiod_iommufd(vtd_as)) {
> +        return;
> +    }
> +
> +    /* non-RID_PASID isn't supported yet */
> +    assert(vtd_as->pasid == PCI_NO_PASID);
> +
> +    if (vtd_dev_get_pe_from_pasid(vtd_as, &pe)) {
> +        /*
> +         * No valid pasid entry in guest memory. e.g. pasid entry was modified
> +         * to be either all-zero or non-present. Either case means existing
> +         * pasid cache should be invalidated.
> +         */
> +        pc_entry->valid = false;
> +        return;
> +    }
> +
> +    /*
> +     * VTD_INV_DESC_PASIDC_G_DSI and VTD_INV_DESC_PASIDC_G_PASID_SI require
> +     * DID check. If DID doesn't match the value in cache or memory, then
> +     * it's not a pasid entry we want to invalidate.

I think comparing DID applies to the case in which pc_entry->valid is
true. If pc_entry->valid is false, this means no cached pc_entry yet. If
pe in guest memory is valid, the pc_entry should be updated/set hence
the bind_pasid operation (added in later patch) would be conducted.

> +     */
> +    switch (pc_info->type) {
> +    case VTD_INV_DESC_PASIDC_G_PASID_SI:
> +    case VTD_INV_DESC_PASIDC_G_DSI:
> +        if (pc_entry->valid) {
> +            did = VTD_SM_PASID_ENTRY_DID(&pc_entry->pasid_entry);
> +            if (pc_info->did == did) {
> +                break;
> +            }
> +        }
> +        did = VTD_SM_PASID_ENTRY_DID(&pe);
> +        if (pc_info->did == did) {
> +            break;
> +        }
> +        return;
> +    }
> +
> +    pc_entry->pasid_entry = pe;
> +    pc_entry->valid = true;
> +}
> +
> +static void vtd_pasid_cache_sync(IntelIOMMUState *s, VTDPASIDCacheInfo *pc_info)
> +{
> +    if (!s->fsts || !s->root_scalable || !s->dmar_enabled) {
> +        return;
> +    }
> +
> +    vtd_iommu_lock(s);
> +    g_hash_table_foreach(s->vtd_address_spaces, vtd_pasid_cache_sync_locked,
> +                         pc_info);
> +    vtd_iommu_unlock(s);
> +}
> +
> +static bool vtd_process_pasid_desc(IntelIOMMUState *s,
> +                                   VTDInvDesc *inv_desc)
> +{
> +    uint16_t did;
> +    uint32_t pasid;
> +    VTDPASIDCacheInfo pc_info = {};
> +    uint64_t mask[4] = {VTD_INV_DESC_PASIDC_RSVD_VAL0, VTD_INV_DESC_ALL_ONE,
> +                        VTD_INV_DESC_ALL_ONE, VTD_INV_DESC_ALL_ONE};
> +
> +    if (!vtd_inv_desc_reserved_check(s, inv_desc, mask, true,
> +                                     __func__, "pasid cache inv")) {
> +        return false;
> +    }
> +
> +    did = VTD_INV_DESC_PASIDC_DID(inv_desc);
> +    pasid = VTD_INV_DESC_PASIDC_PASID(inv_desc);
> +    pc_info.type = VTD_INV_DESC_PASIDC_G(inv_desc);
> +
> +    switch (pc_info.type) {
> +    case VTD_INV_DESC_PASIDC_G_DSI:
> +        trace_vtd_inv_desc_pasid_cache_dsi(did);
> +        pc_info.did = did;
> +        break;
> +
> +    case VTD_INV_DESC_PASIDC_G_PASID_SI:
> +        /* PASID selective implies a DID selective */
> +        trace_vtd_inv_desc_pasid_cache_psi(did, pasid);
> +        /* Currently non-RID_PASID invalidation requests are ignored */

I'm a bit doubting if this is safe given the ATS path (for emulated
device) is merged. ATS path supports non-RID_PASID if emulated device
has PASID cap. The lucky thing is that the ATS path does not have
pasid level cache. So skipping invalidation for non-RID_PASID is not
harmful so far. Just a note to other reviewers although I didn't see a
problem here.

> +        if (pasid != RID_PASID) {
> +            return true;
> +        }
> +        pc_info.did = did;
> +        pc_info.pasid = pasid;
> +        break;
> +

Regards,
Yi Liu

