Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E2C5E6F09E
	for <qemu-devel@archiver.kernel.org>; Sun,  3 Nov 2024 14:18:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t7bQK-0005bO-7N; Sun, 03 Nov 2024 09:17:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1t7bQI-0005ar-Sx
 for qemu-devel@nongnu.org; Sun, 03 Nov 2024 09:17:46 -0500
Received: from mgamail.intel.com ([198.175.65.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1t7bQG-0008Lj-IB
 for qemu-devel@nongnu.org; Sun, 03 Nov 2024 09:17:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1730643464; x=1762179464;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=QGie1lMcUoxcM1WboPq84NHzQS0J7JTQvRMfnWFmRmU=;
 b=h97HaKmF58ejOuAAJgv5Z4J1u98QsLWIBH08pT/popLtTEaLPP9h6acd
 PJCrM1CDyVOXRAg3IQOcpCgK34KB5Tz7tZ0vqXFI/WtcOCrXulNiN8uM8
 kVvs6Zk7yeB9qihfvs/vuQ0VYt+BVV6Z7pfzq4DFv10yfGZUzyuOnDKyt
 psB5uLzjB18WJNtMgiKR0dFK+2iULdf4116rkJXQByfNOQ1UuaB+piVLM
 huISKiUOb/n9DmWY13lHnLjIBL4HngGrisomfMbBjsLLeo07nxwBSzYsH
 +KrcEOdJvUsjI/qFKa0fn2KQSmT6yCvDV7QuF+K7VXrrtmHoUejgtPsWD A==;
X-CSE-ConnectionGUID: 041xJd3tTiWP1DOJhPO7Sw==
X-CSE-MsgGUID: 28cqo7NATT+iKU8c2PIYDA==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="30506894"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; d="scan'208";a="30506894"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Nov 2024 06:17:42 -0800
X-CSE-ConnectionGUID: 32/lFyvBQQ+VORNZLcB6gg==
X-CSE-MsgGUID: ptgCZP21Tx2nlOXGaUr4pA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,255,1725346800"; d="scan'208";a="87345622"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
 by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 03 Nov 2024 06:17:42 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 3 Nov 2024 06:17:42 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Sun, 3 Nov 2024 06:17:42 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sun, 3 Nov 2024 06:17:20 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Tdg3XUhNoSgCM4Mvx1ngs94EMfSessvqlxUpbCT0WYaRkn6WQgDfSxoCesKvoaV5toJrEfxrnsroLomTsjEG7/H3F8FGp25sLU2Rou2CGmEHAH9w6h9NH3QwVsfwT13lDmByRXJsIjBO/EOJNaOMuT2c3pQqyfGJsDj6ovUJPwB8DER6pCxW2KCFH98vshSUs90h6fMFlfxiRWAS9apf6GLanCHn/Xeio+AxcZdqZ29l5rqlGW0xSg6cNb+LVD6MsxWbfTFXK99dG/MAIkImEWvm+hIMGQ7WroEbYu39VPjwPoLs96LIxKQSute6f4UQeO47yoY8iilDxxDlsRmjpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F9KoaS/irAg0wExl4PtBCYY1Trnzj23fj9b10uMnxFE=;
 b=CjbNRNM5mFM42/Xe5gDMtgpsbaAHCv9qSkEUGwlz/9qKjdQ5p5WB19nt2hQmthIf4GhSJDduyNkTAJneHF84AH6KaXN0mkuemThUhBoQrlVZrIQPkL++FYp+Rho4CMkqlYM0cn4pLbWrDIHoZisztznTdqwiGme83jvYNoR8nJlQCNXNi+wBycO+slvZK4aMCoC7l+Qos2U2DmC9pKYWJkjQf/4y6KOQUoPl8AvAjMSHa+fful4kRNROarlLMUkyhDCJQHcPq98VCJmMs+ZxTOhCbpEC0DXjz5hgI6UTQWlnjjTokJLvb7iTWtjX/4C8eJgDZZIQvYp7CopODxfWhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by DM4PR11MB5247.namprd11.prod.outlook.com (2603:10b6:5:38a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.29; Sun, 3 Nov
 2024 14:17:17 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a%6]) with mapi id 15.20.8114.028; Sun, 3 Nov 2024
 14:17:17 +0000
Message-ID: <750c9440-b787-4500-b039-a4827e5d7d20@intel.com>
Date: Sun, 3 Nov 2024 22:21:50 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 06/17] intel_iommu: Implement stage-1 translation
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, <qemu-devel@nongnu.org>
CC: <alex.williamson@redhat.com>, <clg@redhat.com>, <eric.auger@redhat.com>,
 <mst@redhat.com>, <peterx@redhat.com>, <jasowang@redhat.com>,
 <jgg@nvidia.com>, <nicolinc@nvidia.com>, <joao.m.martins@oracle.com>,
 <clement.mathieu--drif@eviden.com>, <kevin.tian@intel.com>,
 <chao.p.peng@intel.com>, Yi Sun <yi.y.sun@linux.intel.com>, Marcel Apfelbaum
 <marcel.apfelbaum@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, "Richard
 Henderson" <richard.henderson@linaro.org>, Eduardo Habkost
 <eduardo@habkost.net>
References: <20240930092631.2997543-1-zhenzhong.duan@intel.com>
 <20240930092631.2997543-7-zhenzhong.duan@intel.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <20240930092631.2997543-7-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI1PR02CA0001.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::15) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|DM4PR11MB5247:EE_
X-MS-Office365-Filtering-Correlation-Id: 461feb58-7760-47a2-8df6-08dcfc1238a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?b205bGJmeUJOeDVpaU96U09QM2ZmcFBkYWRNcFA5L3dlVi9WVUFsV3gvbEFG?=
 =?utf-8?B?OTdLTzZKRXpVaXM3bU5WUGZ3cEtYMWlCOUlCeDVoR2t1dHJXcXM2d3FldWRl?=
 =?utf-8?B?YTNOZUdDbDRmNUw1cnBuTXFhcklQaUpiVFB5aGZON2VFMG5jTnZsa01OQ0or?=
 =?utf-8?B?L0l0SDdoanlHaHh6RVMyTUtTRzdiV1locmpCWGNOZFVNOHl2bGpoMVZGTXUy?=
 =?utf-8?B?WTNCYWJ2M2Zka21VZEcxYzJkT2pHMU8vZkxNOTJaZEowSjlCOEVDWFBuWE45?=
 =?utf-8?B?cUp0KzcrK3FSTDhmSzArT3FZVkk1UUJ4bWtyeGlmUDFmeFVWTVJHQ3F2MUZS?=
 =?utf-8?B?a1pSaWppbUJ2SGVlQ0ROZFFJSFNiT0FIYXVoRDJxVXR2dU1Fc2tTc0dtZXIw?=
 =?utf-8?B?dTY3Q3FSc2NZS25hZWliTnlvYVllcXlqcTdIMGJFaTl1em5XMEN6a3ZOVVRt?=
 =?utf-8?B?VUoyemNqUVM4RVJsNkp2UExJU2RCci9ZYXB1cDdLRmNSRlVHOTRGeWp2dGV1?=
 =?utf-8?B?bkx0RVlidTlnMndmY3NQVjZkOGJBT1hNTGx6SytYamZyTktxV0FXN0JLN3FE?=
 =?utf-8?B?QVdjcktYYTBaeExoaE1QazBSTFl2ODJMWkp4MkpyelBxb2JEb2dyOXFINzFY?=
 =?utf-8?B?Mmh4a1RzcTVqTzFHVDQwa2g0Y0RvMEVxU1lzUVprQ1ZoNFpFcGVlenpFcU9J?=
 =?utf-8?B?M0FTYVZSZFBob2xGUEswNW9pdm5vR0N6YmFFVFUzZXUzRDg1R1ZLTHFIdlRk?=
 =?utf-8?B?SEVjdnpINXNkVHM3eCtCUFc3V3hucU9pK0xDVm5wVkl5bXliVk1vMHhvd21i?=
 =?utf-8?B?ZFovV2xNU1Z0c3hMOXl0UjhHbHJxZnBCa3o5Y1UwOUtxbjJ0ZDhiUzFOemI0?=
 =?utf-8?B?b3pobGRZdTBKQTR6SnQ4Zml2Y1ZnMjJoUkppM1loc282Z3UvSDBNZ0FIQlBL?=
 =?utf-8?B?NG1FK0VFYmYwWTlaUFM3QWRFN0dzRHFsemVWbXZEbUdBMDF3NlNPN0ZCeGxl?=
 =?utf-8?B?dFBVdk83QWdhRklKYm5XOSszRGFLV0RGSEgxcmlLU0NwV0xJRDZIdVNONmN6?=
 =?utf-8?B?VEZyMy9MNEdrZk5veEcrVjV6TU9WbXlHWWRvYWRIMnVaSlBDZkFnYzhRMGg3?=
 =?utf-8?B?a2lYa00yekRTVFBuVmg0OURZUVNBZUZXeEZHY3FwZHpOZUQzZ2tLWXpjWWVr?=
 =?utf-8?B?NEtlNXppQitpUjRpY1djRFp2WW93eFNrSFBwaVNDbGt1WkwxVWw2NVppS1o3?=
 =?utf-8?B?c0N1RHY4K2FCbnlLVHhCQUo3L0dSaFpXWHZKUmVZVGdvNmFKaFc1OTZOS2cr?=
 =?utf-8?B?Q28wZ25wcUlRc1IrbzdxWE1UODB6YmpReS96STVETTZPU3pZK2pvT29GTnkw?=
 =?utf-8?B?OGJBSWxUOU04K0tnUkNDalJsdDVqcmdyaXV1b05oVnJXUU1kbklnUXIxVXJh?=
 =?utf-8?B?M2x6MDlOZCtjZGFWY0FSTEVnMFhVc05TSUdOOUkzTU1QVmlyN2VlQ1VBbFR3?=
 =?utf-8?B?cXhKekVWRVJJb1N0ZTBmVm05MitPWDB5OGlncEVhdlVDeXFnc1dmOFFxSHpE?=
 =?utf-8?B?amdwVkNGMG5wWTdlUS92eE01WHlmWW9XMXZxTm83R1lIenFJcDJ4TnB3VGRy?=
 =?utf-8?B?Zkd0OEJNdXVEU0FhODQ0QmpJeVdMd1N4VXEybHJJc3JHUGV3N3RMQkxvMDV4?=
 =?utf-8?B?eC93bWVnTUhCaTVCTnJzRW9MVGQxRFJDZlRESHdmL0I0ek50c04yR0pwOVJv?=
 =?utf-8?Q?k8brgqL2DYtai1Hqy4FLLvPj6EVtxeLyExBWAZR?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7529.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eU1tYmNJSE0vdjR4NXNPcjR6cmVYZDhuSGlMbTg3UDg0VzJGa3QxU2FYaUhC?=
 =?utf-8?B?K0NUaHpaTU41OE8wcWUvQTVkWlNsWEtxSCtBRnNwM0Z4ajMyNnpPNi8zZld2?=
 =?utf-8?B?ZzBUcmpqT0ZmN2psWW9NV3BFSng4eVNaUDd3Syt0SWlid2srR3p6VzhrYlpL?=
 =?utf-8?B?ZE9jN3pxSjdEZ1BDWnZpbC8zOU9qcTRSa0tuMGlIbG1zcmo4T2JpUkNkWDN2?=
 =?utf-8?B?YmRMcFE2VGZGZk12N2FRVzF4OTA1WFdJZ05GWitmNlcxYnNra251QlY4ZWpB?=
 =?utf-8?B?YWhXSnFpc3BlZUZTdnhIZURrVE95a28vZ0ZEbEtNYUJOejFCZExIVUR5dVhp?=
 =?utf-8?B?TkFnQWdNMURPTncrREliTWtLbXdxcEZ5TWNSZlBnQXVoQ25SY29FUXBZSHBT?=
 =?utf-8?B?bG9OOW1FS3VLMGVWV21ZejlVTDR2YmRJVVBENnJwQXBBb09OOWVIMzBhWjNj?=
 =?utf-8?B?OFN3Qm5Ld2RpbDJ6WmIxSTdGNXQ0SjV1RlIxNGFXZnBUK1VsQUJ2MnllZUlp?=
 =?utf-8?B?YXNPRGF2cGUzTWVua05wUnhTbGE0bi9vd2dVY2ZwWjZacjNWa0NxVnNISzkw?=
 =?utf-8?B?Qm53SWgzellmcWdnY3pnSWVnc3dvY0psQ0RLa1VSUFJZVUQ0aEwrTm1pQld0?=
 =?utf-8?B?NVN4VFBNQm9RcE1STnZzY3BMb1JJTFYvRU1Rei9FZ2FPdmxObWdVY3dQdG92?=
 =?utf-8?B?bmEzK0hWR3plbGZ5NHcwMVpvVktKeXNLUC9zQkdrUVhoL3Byd1YyY01oaTdG?=
 =?utf-8?B?d0Roajg3amYvWTNZbm5EekZvNU5QeE5WdEY0Y2pWQVhCQkxUd3NJS1dCOTRK?=
 =?utf-8?B?QnM1ZjJ0TnpEbjU1QkRLTHYwUDFzSkwyMlhja00vNlpoUEZuKzJNQmhsUTgy?=
 =?utf-8?B?UEQwQ1gxTHE0UUhUMUdhT3lRTVNmeWFFUUx5MFQweTkyTkRwVjcrK2ZIekYz?=
 =?utf-8?B?K2p2Z1hCK0RrVDV4OUR3UldvQU5qNDdoSkhtWE9YSEJONUE3dTNibzlra0U3?=
 =?utf-8?B?dEQyRTVuSDdoYk5uL014c3ZUZEVoamxJb0l2cGxLeUhaYmhFNUd0R09halB5?=
 =?utf-8?B?SFJXUHQya2lESHR0S00wTjhOY01Oc08zN0ppdGl3dUpnMWVjNkdaeEJPWFIx?=
 =?utf-8?B?WXh1NjhnNlJyS0VyQUQ3aS9rd3pqbmdJZjVHeGd2aHgyVEg5ZzMxWmt4UlVw?=
 =?utf-8?B?ZG1kWE9DSTBZZVF5ZWowblNIcVhmMmJaRDBwS29obU5Vakp2SFlOQUpJWGFs?=
 =?utf-8?B?ZFZDbG5ETzQ5cFQwekNsQllpUml6RlBtNnM1SEFWcXFIdzlaajJINnE5U0R0?=
 =?utf-8?B?dEpvSVBueStVbzkrejBSR21ucExOTjlNeTFnN0Qwdk9rK21SOHV5bnBRMTNL?=
 =?utf-8?B?SUdkODNnNWdhYlU3VTl0SSs5VjRtVktSM2VmMzVLbEo4TFBnYzl3Sm9weEc3?=
 =?utf-8?B?ajg1OExkRThWcjVlTVFFdkc2ZGFBa2o0ajNPSG1HMVR5UkloVFBRajl5eGU3?=
 =?utf-8?B?c3llL2o1TE8wb1k2dVpLTVl2dVk2THR0bTNjZVdkbzBsRHhCWFNsbTIzd0sz?=
 =?utf-8?B?dFlTU0YrS29LZ3doTE5aR1NhRVdSSitzNGl3TGh4bW8yN3MzVm9CdGg0VS8r?=
 =?utf-8?B?RTZzbTUwU1RpODB3UnhrWDl5YzlleXpBbVYvUTU0Q3ZvL2MyL2V6RDVNWWpj?=
 =?utf-8?B?b0wyZitlVkNnclRTa2RRcVBib2d4NlhiUDJ5bjlqaFBjaENxUzZQOUlLOU5h?=
 =?utf-8?B?UDVOWE9GY0ZodWpwYjdSZWtlbnZ2d01ZSEMzYXdPcmdCaEo3ZGMxa0Y1Tkkz?=
 =?utf-8?B?Kzk3YVNHT29WRjNLNFNSbExIUTdFQ1IwMjFHSFB2SFIyUFBiU0ZKZmNRSFk3?=
 =?utf-8?B?VGMxOVg0eUU0eWszNjdvaGZrQWlRbXVMbFdiRkE4dHhWckV2U05vMlJ5Yys4?=
 =?utf-8?B?QkZhRkVOZm5KN3oxLzhSdUhNOU53b3pBT0h2ZjBRRGh2ZTBadTVoTmVJODNn?=
 =?utf-8?B?MzNUZHMwR3RybmsrVDBmdlhUQzBsSG95enhleHVscExtdTJ1TldMMktOZ2ZV?=
 =?utf-8?B?L3krVUFraEJBVnYyM2xrL25vN3owUXBFRisyNGsrZEtvT0tGUGRnVEtoUFIv?=
 =?utf-8?Q?tNrM6ey8OfXDbgV5Fi83fBoXE?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 461feb58-7760-47a2-8df6-08dcfc1238a6
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2024 14:17:17.0992 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c3h5Du3zIQYF+egwSWZWmuOqDU5Q3/K0TV6+WeEN8mV+s6j7ZsdrlJh0UkakHhAfa/Qmxsh7W2EqVc2AlF1qWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5247
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.16; envelope-from=yi.l.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
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

On 2024/9/30 17:26, Zhenzhong Duan wrote:
> From: Yi Liu <yi.l.liu@intel.com>
> 
> This adds stage-1 page table walking to support stage-1 only
> translation in scalable modern mode.
> 
> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
> Co-developed-by: Clément Mathieu--Drif <clement.mathieu--drif@eviden.com>
> Signed-off-by: Clément Mathieu--Drif <clement.mathieu--drif@eviden.com>
> Signed-off-by: Yi Sun <yi.y.sun@linux.intel.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> Acked-by: Jason Wang <jasowang@redhat.com>
> ---
>   hw/i386/intel_iommu_internal.h |  24 ++++++
>   hw/i386/intel_iommu.c          | 143 ++++++++++++++++++++++++++++++++-
>   2 files changed, 163 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_internal.h
> index 20fcc73938..38bf0c7a06 100644
> --- a/hw/i386/intel_iommu_internal.h
> +++ b/hw/i386/intel_iommu_internal.h
> @@ -428,6 +428,22 @@ typedef union VTDInvDesc VTDInvDesc;
>   #define VTD_SPTE_LPAGE_L3_RSVD_MASK(aw) \
>           (0x3ffff800ULL | ~(VTD_HAW_MASK(aw) | VTD_SL_IGN_COM))
>   
> +/* Rsvd field masks for fpte */
> +#define VTD_FS_UPPER_IGNORED 0xfff0000000000000ULL
> +#define VTD_FPTE_PAGE_L1_RSVD_MASK(aw) \
> +        (~(VTD_HAW_MASK(aw) | VTD_FS_UPPER_IGNORED))
> +#define VTD_FPTE_PAGE_L2_RSVD_MASK(aw) \
> +        (~(VTD_HAW_MASK(aw) | VTD_FS_UPPER_IGNORED))
> +#define VTD_FPTE_PAGE_L3_RSVD_MASK(aw) \
> +        (~(VTD_HAW_MASK(aw) | VTD_FS_UPPER_IGNORED))
> +#define VTD_FPTE_PAGE_L4_RSVD_MASK(aw) \
> +        (0x80ULL | ~(VTD_HAW_MASK(aw) | VTD_FS_UPPER_IGNORED))
> +
> +#define VTD_FPTE_LPAGE_L2_RSVD_MASK(aw) \
> +        (0x1fe000ULL | ~(VTD_HAW_MASK(aw) | VTD_FS_UPPER_IGNORED))
> +#define VTD_FPTE_LPAGE_L3_RSVD_MASK(aw) \
> +        (0x3fffe000ULL | ~(VTD_HAW_MASK(aw) | VTD_FS_UPPER_IGNORED))
> +
>   /* Masks for PIOTLB Invalidate Descriptor */
>   #define VTD_INV_DESC_PIOTLB_G             (3ULL << 4)
>   #define VTD_INV_DESC_PIOTLB_ALL_IN_PASID  (2ULL << 4)
> @@ -520,6 +536,14 @@ typedef struct VTDRootEntry VTDRootEntry;
>   #define VTD_SM_PASID_ENTRY_AW          7ULL /* Adjusted guest-address-width */
>   #define VTD_SM_PASID_ENTRY_DID(val)    ((val) & VTD_DOMAIN_ID_MASK)
>   
> +#define VTD_SM_PASID_ENTRY_FLPM          3ULL
> +#define VTD_SM_PASID_ENTRY_FLPTPTR       (~0xfffULL)
> +
> +/* First Level Paging Structure */
> +/* Masks for First Level Paging Entry */
> +#define VTD_FL_P                    1ULL
> +#define VTD_FL_RW                   (1ULL << 1)
> +
>   /* Second Level Page Translation Pointer*/
>   #define VTD_SM_PASID_ENTRY_SLPTPTR     (~0xfffULL)
>   
> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> index 6f2414898c..56d5933e93 100644
> --- a/hw/i386/intel_iommu.c
> +++ b/hw/i386/intel_iommu.c
> @@ -48,6 +48,8 @@
>   
>   /* pe operations */
>   #define VTD_PE_GET_TYPE(pe) ((pe)->val[0] & VTD_SM_PASID_ENTRY_PGTT)
> +#define VTD_PE_GET_FL_LEVEL(pe) \
> +    (4 + (((pe)->val[2] >> 2) & VTD_SM_PASID_ENTRY_FLPM))
>   #define VTD_PE_GET_SL_LEVEL(pe) \
>       (2 + (((pe)->val[0] >> 2) & VTD_SM_PASID_ENTRY_AW))
>   
> @@ -755,6 +757,11 @@ static inline bool vtd_is_sl_level_supported(IntelIOMMUState *s, uint32_t level)
>              (1ULL << (level - 2 + VTD_CAP_SAGAW_SHIFT));
>   }
>   
> +static inline bool vtd_is_fl_level_supported(IntelIOMMUState *s, uint32_t level)
> +{
> +    return level == VTD_PML4_LEVEL;
> +}
> +
>   /* Return true if check passed, otherwise false */
>   static inline bool vtd_pe_type_check(X86IOMMUState *x86_iommu,
>                                        VTDPASIDEntry *pe)
> @@ -838,6 +845,11 @@ static int vtd_get_pe_in_pasid_leaf_table(IntelIOMMUState *s,
>               return -VTD_FR_PASID_TABLE_ENTRY_INV;
>       }
>   
> +    if (pgtt == VTD_SM_PASID_ENTRY_FLT &&
> +        !vtd_is_fl_level_supported(s, VTD_PE_GET_FL_LEVEL(pe))) {
> +            return -VTD_FR_PASID_TABLE_ENTRY_INV;
> +    }
> +
>       return 0;
>   }
>   
> @@ -973,7 +985,11 @@ static uint32_t vtd_get_iova_level(IntelIOMMUState *s,
>   
>       if (s->root_scalable) {
>           vtd_ce_get_rid2pasid_entry(s, ce, &pe, pasid);
> -        return VTD_PE_GET_SL_LEVEL(&pe);
> +        if (s->scalable_modern) {
> +            return VTD_PE_GET_FL_LEVEL(&pe);
> +        } else {
> +            return VTD_PE_GET_SL_LEVEL(&pe);
> +        }
>       }
>   
>       return vtd_ce_get_level(ce);
> @@ -1060,7 +1076,11 @@ static dma_addr_t vtd_get_iova_pgtbl_base(IntelIOMMUState *s,
>   
>       if (s->root_scalable) {
>           vtd_ce_get_rid2pasid_entry(s, ce, &pe, pasid);
> -        return pe.val[0] & VTD_SM_PASID_ENTRY_SLPTPTR;
> +        if (s->scalable_modern) {
> +            return pe.val[2] & VTD_SM_PASID_ENTRY_FLPTPTR;
> +        } else {
> +            return pe.val[0] & VTD_SM_PASID_ENTRY_SLPTPTR;
> +        }
>       }
>   
>       return vtd_ce_get_slpt_base(ce);
> @@ -1862,6 +1882,104 @@ out:
>       trace_vtd_pt_enable_fast_path(source_id, success);
>   }
>   
> +/*
> + * Rsvd field masks for fpte:
> + *     vtd_fpte_rsvd 4k pages
> + *     vtd_fpte_rsvd_large large pages
> + *
> + * We support only 4-level page tables.
> + */
> +#define VTD_FPTE_RSVD_LEN 5
> +static uint64_t vtd_fpte_rsvd[VTD_FPTE_RSVD_LEN];
> +static uint64_t vtd_fpte_rsvd_large[VTD_FPTE_RSVD_LEN];
> +
> +static bool vtd_flpte_nonzero_rsvd(uint64_t flpte, uint32_t level)
> +{
> +    uint64_t rsvd_mask;
> +
> +    /*
> +     * We should have caught a guest-mis-programmed level earlier,
> +     * via vtd_is_fl_level_supported.
> +     */
> +    assert(level < VTD_FPTE_RSVD_LEN);
> +    /*
> +     * Zero level doesn't exist. The smallest level is VTD_PT_LEVEL=1 and
> +     * checked by vtd_is_last_pte().
> +     */
> +    assert(level);
> +
> +    if ((level == VTD_PD_LEVEL || level == VTD_PDP_LEVEL) &&
> +        (flpte & VTD_PT_PAGE_SIZE_MASK)) {
> +        /* large page */
> +        rsvd_mask = vtd_fpte_rsvd_large[level];
> +    } else {
> +        rsvd_mask = vtd_fpte_rsvd[level];
> +    }
> +
> +    return flpte & rsvd_mask;
> +}
> +
> +static inline bool vtd_flpte_present(uint64_t flpte)
> +{
> +    return !!(flpte & VTD_FL_P);
> +}
> +
> +/*
> + * Given the @iova, get relevant @flptep. @flpte_level will be the last level
> + * of the translation, can be used for deciding the size of large page.
> + */
> +static int vtd_iova_to_flpte(IntelIOMMUState *s, VTDContextEntry *ce,
> +                             uint64_t iova, bool is_write,
> +                             uint64_t *flptep, uint32_t *flpte_level,
> +                             bool *reads, bool *writes, uint8_t aw_bits,
> +                             uint32_t pasid)
> +{
> +    dma_addr_t addr = vtd_get_iova_pgtbl_base(s, ce, pasid);
> +    uint32_t level = vtd_get_iova_level(s, ce, pasid);
> +    uint32_t offset;
> +    uint64_t flpte;
> +
> +    while (true) {
> +        offset = vtd_iova_level_offset(iova, level);
> +        flpte = vtd_get_pte(addr, offset);
> +
> +        if (flpte == (uint64_t)-1) {
> +            if (level == vtd_get_iova_level(s, ce, pasid)) {
> +                /* Invalid programming of context-entry */
> +                return -VTD_FR_CONTEXT_ENTRY_INV;
> +            } else {
> +                return -VTD_FR_PAGING_ENTRY_INV;
> +            }
> +        }
> +        if (!vtd_flpte_present(flpte)) {
> +            *reads = false;
> +            *writes = false;
> +            return -VTD_FR_PAGING_ENTRY_INV;
> +        }
> +        *reads = true;
> +        *writes = (*writes) && (flpte & VTD_FL_RW);
> +        if (is_write && !(flpte & VTD_FL_RW)) {
> +            return -VTD_FR_WRITE;
> +        }
> +        if (vtd_flpte_nonzero_rsvd(flpte, level)) {
> +            error_report_once("%s: detected flpte reserved non-zero "
> +                              "iova=0x%" PRIx64 ", level=0x%" PRIx32
> +                              "flpte=0x%" PRIx64 ", pasid=0x%" PRIX32 ")",
> +                              __func__, iova, level, flpte, pasid);
> +            return -VTD_FR_PAGING_ENTRY_RSVD;
> +        }
> +
> +        if (vtd_is_last_pte(flpte, level)) {
> +            *flptep = flpte;
> +            *flpte_level = level;
> +            return 0;
> +        }
> +
> +        addr = vtd_get_pte_addr(flpte, aw_bits);
> +        level--;
> +    }

As I replied in last version, it should check the ir range for the
translation result. I saw your reply, but that only covers the input
address, my comment is about the output addr.

[1] 
https://lore.kernel.org/qemu-devel/SJ0PR11MB6744D2B572D278DAF8BF267692762@SJ0PR11MB6744.namprd11.prod.outlook.com/

> +}
> +
>   static void vtd_report_fault(IntelIOMMUState *s,
>                                int err, bool is_fpd_set,
>                                uint16_t source_id,
> @@ -2010,8 +2128,13 @@ static bool vtd_do_iommu_translate(VTDAddressSpace *vtd_as, PCIBus *bus,
>           }
>       }
>   
> -    ret_fr = vtd_iova_to_slpte(s, &ce, addr, is_write, &pte, &level,
> -                               &reads, &writes, s->aw_bits, pasid);
> +    if (s->scalable_modern && s->root_scalable) {
> +        ret_fr = vtd_iova_to_flpte(s, &ce, addr, is_write, &pte, &level,
> +                                   &reads, &writes, s->aw_bits, pasid);
> +    } else {
> +        ret_fr = vtd_iova_to_slpte(s, &ce, addr, is_write, &pte, &level,
> +                                   &reads, &writes, s->aw_bits, pasid);
> +    }
>       if (ret_fr) {
>           vtd_report_fault(s, -ret_fr, is_fpd_set, source_id,
>                            addr, is_write, pasid != PCI_NO_PASID, pasid);
> @@ -4239,6 +4362,18 @@ static void vtd_init(IntelIOMMUState *s)
>       vtd_spte_rsvd_large[2] = VTD_SPTE_LPAGE_L2_RSVD_MASK(s->aw_bits);
>       vtd_spte_rsvd_large[3] = VTD_SPTE_LPAGE_L3_RSVD_MASK(s->aw_bits);
>   
> +    /*
> +     * Rsvd field masks for fpte
> +     */
> +    vtd_fpte_rsvd[0] = ~0ULL;
> +    vtd_fpte_rsvd[1] = VTD_FPTE_PAGE_L1_RSVD_MASK(s->aw_bits);
> +    vtd_fpte_rsvd[2] = VTD_FPTE_PAGE_L2_RSVD_MASK(s->aw_bits);
> +    vtd_fpte_rsvd[3] = VTD_FPTE_PAGE_L3_RSVD_MASK(s->aw_bits);
> +    vtd_fpte_rsvd[4] = VTD_FPTE_PAGE_L4_RSVD_MASK(s->aw_bits);
> +
> +    vtd_fpte_rsvd_large[2] = VTD_FPTE_LPAGE_L2_RSVD_MASK(s->aw_bits);
> +    vtd_fpte_rsvd_large[3] = VTD_FPTE_LPAGE_L3_RSVD_MASK(s->aw_bits);
> +
>       if (s->scalable_mode || s->snoop_control) {
>           vtd_spte_rsvd[1] &= ~VTD_SPTE_SNP;
>           vtd_spte_rsvd_large[2] &= ~VTD_SPTE_SNP;

-- 
Regards,
Yi Liu

