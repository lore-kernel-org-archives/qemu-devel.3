Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0BA3CCD19F
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Oct 2025 03:24:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vB2yU-0001VO-O4; Mon, 20 Oct 2025 23:23:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1vB2yS-0001VF-Pr
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 23:23:48 -0400
Received: from mgamail.intel.com ([192.198.163.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1vB2yP-0006ej-SU
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 23:23:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1761017026; x=1792553026;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=xRofuwB26pTqTa6OxfCbbFJhjcwvluadgxT2+hJ74KA=;
 b=UO4qfQRFELQy3+Hya1963n+RBWjxduGBkoNEytbWTUkM5MTQhpTPfLFf
 zk1MsU32T9QXs/NH7vAboMXW9uOcETvhi4bmql8SAB2AMY5G4sbXD8IvZ
 bjjsQIbRtY3DoE7j290+/cDuhwZuTmH7NNaYk/e2bzodI6Y93owUq/b3R
 VH8Ps2i7eET5Jn7pc0w6kOXbyYziAHlf3I9GeXNygjUvF59RudQcKbnn+
 02YhnJL4VzFxv1rJRoVTz54HzmX9gz9ZG+NShvCoqMjlK0Nk3wp5lBls5
 ZsOwkjCzasElSHhl988p2O+i3oI7EJJDzzSODk2k6BW3u/BsRbvQ1cwcG Q==;
X-CSE-ConnectionGUID: T89IX7z1Rla8gpTpHYLgfA==
X-CSE-MsgGUID: /pD6aZYaQwySexJH4Qm4nw==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="67002665"
X-IronPort-AV: E=Sophos;i="6.19,243,1754982000"; d="scan'208";a="67002665"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Oct 2025 20:23:40 -0700
X-CSE-ConnectionGUID: hMbVEv90RKee+E/YDJVkzw==
X-CSE-MsgGUID: Zzmab1BKQk+kqs7UiA/Ctg==
X-ExtLoop1: 1
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Oct 2025 20:23:40 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 20 Oct 2025 20:23:39 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Mon, 20 Oct 2025 20:23:39 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.47) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 20 Oct 2025 20:23:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i9Q9cxlQe10O3hPuohq6nPkRuVmIjdaVFjG4JRkdev3Q8K7O7AA61OWTg9OxeEu3JRyvd5lHMplQ7cyJP3Yy0Mq8QQvBArzugmp8Cl0YGPD5BoxBxuKBx5rPovFjFcmXDYbPDBO4r25S7FgG65q7n6TK+xr/UdiW3aZ17xCmN971UbJe1PXpe26qYOFj9fgfbY9VscrHc8fkeYepy1BSJiOAYn4K3InEOoxOk7PQG8QG6PtRsfTOzw6j3eyaUu8usfv7CGHhmSTlpMvktjsr737M8YKd6YxJKPQjsXMK+ws5oFGC+ac3J7r0JLUxgpvIzL0LBpLZ+ffkinsddVAH2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PpNhnoaIFyHC3T65NI5XnUs9ioMe7DHvqVfAeNCg9Eo=;
 b=BTtDxhXXlpV7Zw+oXRaBZirkZijrIol82w4/oAvxw9+Ap2QEgnX5PGPje0/TM0r4jqA9tGUJHNUeF6jBbb4rb2mhqQ0sxkh2fTPjgIJENb0yuHyIHNZe9pAK0800NtDXkqRb84JEof1/9eodPsCOdDoB0ymjBSwbbNYpYcgAIRr86DgQt1/SkS35wRxsxGqT0USLjR3Beeky0YXHA/2PwTdRVS5JMXKoDnKjTQkm4nyeYolNi3T/XXQuPPx3wMz0bF4K7+3pq73xEJ2cH81bZ9X/VdLpeRcQRkzAdl+p3OHVxq3t0DTCc2fdh5TAQEH8JXK3zid4LV7m1CJ/7ohzkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ0PR11MB4798.namprd11.prod.outlook.com (2603:10b6:a03:2d5::12)
 by PH7PR11MB6652.namprd11.prod.outlook.com (2603:10b6:510:1aa::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.16; Tue, 21 Oct
 2025 03:23:32 +0000
Received: from SJ0PR11MB4798.namprd11.prod.outlook.com
 ([fe80::d946:6abf:6e7e:fd1e]) by SJ0PR11MB4798.namprd11.prod.outlook.com
 ([fe80::d946:6abf:6e7e:fd1e%7]) with mapi id 15.20.9228.016; Tue, 21 Oct 2025
 03:23:32 +0000
Message-ID: <162b2660-6303-4abf-87bf-1dc9d75b6242@intel.com>
Date: Tue, 21 Oct 2025 11:30:17 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/8] vfio/iommufd: Query dirty bitmap before DMA unmap
To: Avihai Horon <avihaih@nvidia.com>, "Duan, Zhenzhong"
 <zhenzhong.duan@intel.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>, "mst@redhat.com" <mst@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>,
 "clement.mathieu--drif@eviden.com" <clement.mathieu--drif@eviden.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "Hao, Xudong" <xudong.hao@intel.com>, "Cabiddu,
 Giovanni" <giovanni.cabiddu@intel.com>, "Gross, Mark" <mark.gross@intel.com>, 
 "Van De Ven, Arjan" <arjan.van.de.ven@intel.com>
References: <20251017082234.517827-1-zhenzhong.duan@intel.com>
 <20251017082234.517827-3-zhenzhong.duan@intel.com>
 <e620aadd-c70b-43d3-9832-0cc1fc9d7c3c@nvidia.com>
 <IA3PR11MB9136BCC9994E40C674FE495792F5A@IA3PR11MB9136.namprd11.prod.outlook.com>
 <e7cdcee2-1df1-40fd-8f46-42e8c75185d1@intel.com>
 <ca586528-1798-4d67-9d93-781f5bec533e@nvidia.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <ca586528-1798-4d67-9d93-781f5bec533e@nvidia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: KUZPR06CA0007.apcprd06.prod.outlook.com
 (2603:1096:d10:30::11) To SJ0PR11MB4798.namprd11.prod.outlook.com
 (2603:10b6:a03:2d5::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR11MB4798:EE_|PH7PR11MB6652:EE_
X-MS-Office365-Filtering-Correlation-Id: 5034d075-adaa-46ed-c9e2-08de1051363f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|42112799006|366016|376014|1800799024|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RzZtZ0tNTnVWeDBjT1lXekFBYUk2NmRqR3FhOU9zeTNneng1U2ZOY1lRZFVn?=
 =?utf-8?B?dnRKN1hDQUJza0RocWVGU09GU3loYjZzbDVFS1pzRTdMb3hwY1g5QzBCT21K?=
 =?utf-8?B?b29IbXFzckNtdHpERlZ4Qk1Ub3gvbnY3Z0hiWExTbUdtQ1NyOFZxMDV3RGps?=
 =?utf-8?B?VlVYNENyS1RNbnYwQi80TXZJUzdqZ3VhUXdveTJ4blljOEZXTExLU3RXOU0v?=
 =?utf-8?B?WE1KS0ZHZkpHOVhoNHZhWVpnUnBDa2VVdWd6clJ6ckNWd0VYQ3RQRENDRG5i?=
 =?utf-8?B?VVZXRU94NFdncWVCQU8xVFBDRmdXWWU2Tm9iSWplTndRTWJ4ZGx6UjN1SE02?=
 =?utf-8?B?N0Q0eUdaVm5hVEt1Nkpvc1VneGZJK3VJMnJ0aFBFUWZSY2ZKTFZJKzBkMjJk?=
 =?utf-8?B?RnZ0UGhMOThRLzlMa21JMnZrR2c3V2VWbksrVFNMV2dUZVJRWmJ4OFRzR2Ix?=
 =?utf-8?B?ck84clMya2dvSW1kMTJ1RU9oYjE2TzFvMlhDUXozOVBMbW9vRkRmaEFxczUz?=
 =?utf-8?B?OXU5eDZQOXZpYVdBUFY1bzZpZlJJbWJRanhRSXc3bzJOTytaVmhJQStydXR0?=
 =?utf-8?B?cDdRd2NMQXgxeHZMbUppeHNqdEJNR2xSQmtydWJIc1JoczgxTytvaEdyMTRu?=
 =?utf-8?B?YWkzS2VFTFk4L0Q0UEk5MGVuZzhEUGpROFpEcG5ac0VDaHR3eVFidVZsMlJ0?=
 =?utf-8?B?bGZtbEtUS29ZY3h1YTRzUXROZytrak5ndFhYWlFydjhNRG1kdWpRRVI1WTdr?=
 =?utf-8?B?WnU4R1Y1TW9oeE5tdW9iNVZXa0lobnNTNVZrcFdIZmcwQXl1Q3R0clNEQ3pq?=
 =?utf-8?B?Ukxla1dxZ1U0cEVJMlRudjJwdnJkcmFMdGRISExIZEs1TDFLN2VaWEtBb1hx?=
 =?utf-8?B?cFZZV2QyQ0xqUFJrcTZkM0NrZjZOWHlzRjZSRjU2SkdQMUtoLzVkWFpabGpp?=
 =?utf-8?B?L1V0c0RHMllINEVwdmFOdFd1bnBJSEhEcFo2bUFWMFF1Y09ObGVVeXpFSjhp?=
 =?utf-8?B?bzlJSnp0WTRGemlBWU9vYW9QSUtFZGo5UjB6QWlHU1lFZDhuSmxSb2h4RWMy?=
 =?utf-8?B?aWc4OXBJcnVLNTB2ZzNBTE5qNUVPOVNSUFdNU3hVc3ZjckwwdklBNmZjbzR3?=
 =?utf-8?B?SjZDWGFvdjBCUmlEM1k3U29wSVpPZ05ZUWhqSTZZbzU0N2VGOUlTUVhkT3JV?=
 =?utf-8?B?TjcrZnNtaUZLWmp4TDdjV09OYnIyeDdhYXpoV1EyWUtKOENSMzcrak5RbUho?=
 =?utf-8?B?VmVNQUpJd3I5amZlSjgzcmFsbzEwODJKdE8vMGkvQ0M2TzFRd3N6QUs4aWl6?=
 =?utf-8?B?N2FWQ0dLdU5HVGdybVBwbUViaEduVEljY09iK0trMjFsbmxlSklUaXBhUjhp?=
 =?utf-8?B?N1hnRU9tNE9LOWVmOGhPWGdKUGUxTlNzS1QvTnNkRlN0THVlMEN4N0RySXJ6?=
 =?utf-8?B?aDRCQnplOVRzMU1OSVJkaEtKU0Fqb3Q2eDRXQVRDdW5mSTVtVVAyQURUcXgv?=
 =?utf-8?B?T3dJbVhpdHplRzU5TXhaUVJBYW1aTWlXVUhUZDZYQUdDdGY2M2dZMEJtNENS?=
 =?utf-8?B?OE9SY1ByM0RjZjRwZ2oyQ2d5WElZcGozUFNnYTZNUWUzYTVpUDhTZXRXNDU2?=
 =?utf-8?B?b2tqdkIwM0FNeng0UDVRV0I1QjJ6a3djUlA1aWo2S0FjbnlIWWtHeEd2emYr?=
 =?utf-8?B?UFFVekNETDVXcjI1UFZCTTVlRXJ5YkxkallYbG9IT2NEbzJtN3lZNjVJdXNu?=
 =?utf-8?B?WFVWNElKTnhwNk9QMU5kSmJlb3hMaksvMDZjSUo2MHVXbWNiOWc2MUJsM081?=
 =?utf-8?B?WjRkQTFjOE1uWHo0TitNbm5pZkU3VW9Oa0tqVHdkeVdVN0JTNWpoYWp2RjQv?=
 =?utf-8?B?VlQwY1lGNlE5eHRHdXJHUDdwVXlyMTJZcmNZMnhYVWEyWjhwdHZMUjJEMkdP?=
 =?utf-8?Q?d2a7oP/vY96YS8pOMmXzFvdDGTtX09YE?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB4798.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(42112799006)(366016)(376014)(1800799024)(7053199007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eGdZR283L0JOOHJiOFhETnJJVkVvdm5YTlJSRXZnemoydytBbkxURExqNEhC?=
 =?utf-8?B?R2t6Qi9WQXFVbjI3eEQ0eU9Rbk5EWWVvQW45eXlvQjNxZzhZK2RjSGpRWXlF?=
 =?utf-8?B?MTFZV0xHNUphOURyZkt5eUtrM3V5V1lCVldaTGJyc21URlhYTHBQdWZEblZ4?=
 =?utf-8?B?SzRER0Q4cEphQzhOZUtiZFV3dmdkSlcrakZKYWJYZVVoWGlXZ0hwQ3Q4d0Ez?=
 =?utf-8?B?WmdGNk1SaC8zRXorcmlpTGJkRUcvTUpzNnFwMTloUkxmNmxualhoVngyZWZK?=
 =?utf-8?B?T2MzQTJzSnpHbTFQbHZObXZwSytlNnFaQmpsYmg1OFRFaGJ4VEVWbjRDakFN?=
 =?utf-8?B?N0Rid1NpMDRWZHJxMkRybC91MmtLMUxKblVDNTlXRDJxRmQ4RFc2TFRManJV?=
 =?utf-8?B?d2g2RjNSSnNIWU9wbFUrV2dENmtkbml6aEtyWVo1ZTFucSszVXNlWEh3VTRX?=
 =?utf-8?B?NGNxTXIxL1k4OFFnNVo0TStmaUwva1ZwOVNCRDJnbzZnUDVGN3l0dVRjc1lt?=
 =?utf-8?B?KzQzb2pHZkEwZ0hZcmhOdE5lZmtTRjBJaEREcG1qdTA2dnBvTHFxNGpVZ3NL?=
 =?utf-8?B?dVh3SlVmNEVYQTB2bWVHeDdZQjBsbE9sR05oQW04akZFNFdTV2JZNkVub2Js?=
 =?utf-8?B?aFcyQWw2QkpTTUF0SDY4SE8xYU55ODhMQ045UEtnYzlQVVIzeXBCUzdsSU5k?=
 =?utf-8?B?aVhlQXNsaW52Snk0M3JBaVovQkVIalpDWURQKzNjQVZtWnZSdWtYSTdzd3do?=
 =?utf-8?B?clJtL2EwUXVZRWttVjhwckVLQ2g4S09SbHByNTJieGdBNkhHUUIwcjdva0RB?=
 =?utf-8?B?RUlBWFNtT0NiMEh3MG9RU2MvNU1UUUJOd2p5M3M3dE1yZGJpWURISjduR0VF?=
 =?utf-8?B?ek9OQ20yK29HbCtIOFZSbHBkWFEvaW1tUW5nRGtNU2xHUTlIWTg3WWg4Y2ln?=
 =?utf-8?B?V1NOcWZYYlVmWllhajFYRFRRTXRQQ2RSRWNQTE5peUk1ZmtnZDhQT1g5TWds?=
 =?utf-8?B?MDdXb2NHZjJWYXRZc3lMT2g0TzVWaEg2aVBzV3h6d21YODNaa2lWSXhVSlNS?=
 =?utf-8?B?NlFpUVEvSHRRSDV5R28wN3RrQng5TFBySnd3SVVmOEFoVGQwaDJTMXN3WXFE?=
 =?utf-8?B?Y2N4ZHQrYm9Lcnh6KzAvRE5sbmhsd3EvM0tDbEwveGxsU21LWTdPMmxTTmpl?=
 =?utf-8?B?TFpwd1BRSHM5SjkzS3luMDZDNWlXNjI0UVVYTUJKVVp3eVQveUVsMlhlREVY?=
 =?utf-8?B?c3NTQWMyMkc5YzNVYzVDanNuSk45M0F0aVQ2bzNkeXFWTEo4K3h1QXE0Sy96?=
 =?utf-8?B?MW41UTF4cVlFUDN3allyWUFrUkc4UEl0R1pCR2lPWVNkYkZ1MUdJQTVicXIy?=
 =?utf-8?B?T0RZczFiSGQvcElWQzRrazluRk5UaTY3Skp0Y1BaKzJZdVM3M3ozV2FRU2pB?=
 =?utf-8?B?MmNiTUc2aHRsVjhYNTlnRTlJcnVOSmZ3SFJtNnZEcTRUZHJON3ZrRUNHdTh5?=
 =?utf-8?B?U0JOMVpQMjA4L3psd3FuTnFCaTdqR01wVjRtUnE3NWppMlNLUGtrWS8vUWN6?=
 =?utf-8?B?cGhiRjFrc0FiSTg2bFR4UnR1K1dCa0Ureng5L0RIZU8xdU5BVEFUTmk1cWY4?=
 =?utf-8?B?Wk5HSjM0enIzcjZvbXRmL2RjQ05jV1dnamJYM1pFdXdoL0pJWW13UWtZY1hZ?=
 =?utf-8?B?ZS9vdjdkTElhMzVveWVGT1lrc0NGUmNaYW1PbHJGSytVM2oyRWhGVHRnYXNB?=
 =?utf-8?B?TGZJZDNtdGdOb251RGVFTFBCeXVBc0ZuQmZYZDJHcnlUZSs4SGNFc0xXSXdX?=
 =?utf-8?B?UmZhSU1jbUVLeHVoODdWNjgvb1kxSVMxN2pXZ2tCZ09WYXV4UlR1a0ZOUzFO?=
 =?utf-8?B?RFhZREtRV3hOa21PUndUNnV6cmRQOVBYSENHbWh4aXdiNlNsd1RTbWM0TUhN?=
 =?utf-8?B?WmpDQUpKdnZDUUJSYzF3bnpXUVFyK3NoZzEzd0cwU1RvUWJGMVJhUHVrR0Rv?=
 =?utf-8?B?cE54c2g3di9Ka2RBdTFqOWFEY2FaRk9PT1VvNFpLK0xnQWd0dVlIYUttajJr?=
 =?utf-8?B?OFBZUnEzaTlvZzQyV2lnZzY2TUZzQm10SUVNT0RLcDQ0RVgwYXNOSE1aeEFD?=
 =?utf-8?Q?8ZtiH2dKus6crKhRKBeyr/NT6?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5034d075-adaa-46ed-c9e2-08de1051363f
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB4798.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2025 03:23:32.3168 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eGjYBsL1BJIYC1295bZR5E2jX+ViHycmGT7L+1fCLkh+1aC/UgHPyTet7PkUbBlCgIYBT6HucKOSxOwwIPA9NA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6652
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.12; envelope-from=yi.l.liu@intel.com;
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

On 2025/10/20 21:04, Avihai Horon wrote:
> 
> On 20/10/2025 15:45, Yi Liu wrote:
>> External email: Use caution opening links or attachments
>>
>>
>> On 2025/10/20 18:00, Duan, Zhenzhong wrote:
>>> Hi
>>>
>>>> -----Original Message-----
>>>> From: Avihai Horon <avihaih@nvidia.com>
>>>> Subject: Re: [PATCH v2 2/8] vfio/iommufd: Query dirty bitmap before DMA
>>>> unmap
>>>>
>>>> Hi,
>>>>
>>>> On 17/10/2025 11:22, Zhenzhong Duan wrote:
>>>>> External email: Use caution opening links or attachments
>>>>>
>>>>>
>>>>> When a existing mapping is unmapped, there could already be dirty bits
>>>>> which need to be recorded before unmap.
>>>>>
>>>>> If query dirty bitmap fails, we still need to do unmapping or else 
>>>>> there
>>>>> is stale mapping and it's risky to guest.
>>>>>
>>>>> Co-developed-by: Joao Martins <joao.m.martins@oracle.com>
>>>>> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
>>>>> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
>>>>> Tested-by: Xudong Hao <xudong.hao@intel.com>
>>>>> Tested-by: Giovannio Cabiddu <giovanni.cabiddu@intel.com>
>>>>> ---
>>>>>    hw/vfio/iommufd.c | 8 +++++++-
>>>>>    1 file changed, 7 insertions(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
>>>>> index 976c0a8814..404e6249ca 100644
>>>>> --- a/hw/vfio/iommufd.c
>>>>> +++ b/hw/vfio/iommufd.c
>>>>> @@ -74,7 +74,13 @@ static int iommufd_cdev_unmap(const
>>>> VFIOContainer *bcontainer,
>>>>>        if (iotlb && 
>>>>> vfio_container_dirty_tracking_is_started(bcontainer)) {
>>>>>            if
>>>> (!vfio_container_devices_dirty_tracking_is_supported(bcontainer) &&
>>>>> bcontainer->dirty_pages_supported) {
>>>>> -            /* TODO: query dirty bitmap before DMA unmap */
>>>>> +            ret = vfio_container_query_dirty_bitmap(bcontainer, iova,
>>>> size,
>>>>> +
>>>> iotlb->translated_addr,
>>>>> +
>>>> &local_err);
>>>>> +            if (ret) {
>>>>> +                error_report_err(local_err);
>>>>> +            }
>>>>> +            /* Unmap stale mapping even if query dirty bitmap 
>>>>> fails */
>>>>>                return iommufd_backend_unmap_dma(be, ioas_id, iova,
>>>> size);
>>>>
>>>> If query dirty bitmap fails, shouldn't we unmap and return the query
>>>> bitmap error to fail migration? Otherwise, migration may succeed with
>>>> some dirtied pages not being migrated.
>>>
>>> Oh, good catch. Will make below change:
>>>
>>> --- a/hw/vfio/iommufd.c
>>> +++ b/hw/vfio/iommufd.c
>>> @@ -65,7 +65,7 @@ static int iommufd_cdev_unmap(const VFIOContainer 
>>> *bcontainer,
>>>       uint32_t ioas_id = container->ioas_id;
>>>       bool need_dirty_sync = false;
>>>       Error *local_err = NULL;
>>> -    int ret;
>>> +    int ret, unmap_ret;
>>>
>>>       if (unmap_all) {
>>>           size = UINT64_MAX;
>>> @@ -82,7 +82,14 @@ static int iommufd_cdev_unmap(const VFIOContainer 
>>> *bcontainer,
>>>                   error_report_err(local_err);
>>>               }
>>>               /* Unmap stale mapping even if query dirty bitmap fails */
>>> -            return iommufd_backend_unmap_dma(be, ioas_id, iova, size);
>>> +            unmap_ret = iommufd_backend_unmap_dma(be, ioas_id, iova, 
>>> size);
>>> +
>>> +            /*
>>> +             * If dirty tracking fails, return the failure to VFIO 
>>> core to
>>> +             * fail the migration, or else there will be dirty pages 
>>> missed
>>> +             * to be migrated.
>>> +             */
>>> +            return unmap_ret ? : ret;
>>>           }
>>
>> do we need a async way to fail migration? This unmap path is not
>> necessarily in the migration path.
> 
> I think in upper layers there is a check, if migration is active then 
> migration error is set to fail it.
> 
> vfio_iommu_map_notify():
> 
>          ...
>          ret = vfio_container_dma_unmap(bcontainer, iova,
>                                         iotlb->addr_mask + 1, iotlb, 
> false);
>          if (ret) {
>              error_setg(&local_err,
>                         "vfio_container_dma_unmap(%p, 0x%"HWADDR_PRIx", "
>                         "0x%"HWADDR_PRIx") = %d (%s)",
>                         bcontainer, iova,
>                         iotlb->addr_mask + 1, ret, strerror(-ret));
>              if (migration_is_running()) {
>                  migration_file_set_error(ret, local_err);
>              } else {
>                  error_report_err(local_err);
>              }
>          }
> 

got it. thanks. :)

