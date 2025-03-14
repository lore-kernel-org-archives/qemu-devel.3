Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0C1CC282EC
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Mar 2025 09:32:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tt1Np-00050d-0z; Fri, 14 Mar 2025 05:31:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chenyi.qiang@intel.com>)
 id 1tt1Nj-0004zD-O3
 for qemu-devel@nongnu.org; Fri, 14 Mar 2025 05:31:07 -0400
Received: from mgamail.intel.com ([198.175.65.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chenyi.qiang@intel.com>)
 id 1tt1Nd-0005SP-F5
 for qemu-devel@nongnu.org; Fri, 14 Mar 2025 05:31:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1741944662; x=1773480662;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=Ib0p/sP3G/Q1Iarqfirq62D/AmQq7W3XFTv+ZIVfOM0=;
 b=k/NhjUdTqTvBE5jKrnTm8pd9AGrbuMJ/C+pLoxxhEfp18NVSCcKM/C4a
 1oLgyfB1K1mh20QzaSQyEvDXyHDk0vrD7/wwD7jXL5UkS7EM0AVT0KQ96
 79B5o6WkOvqVgxKYzGOXZCxVC5L3yebDxhuEKnzx10ScfoFfgcCdDBaMJ
 7TQKSnQSJml205DQ82cJdznUreQMmFpuvJcpFpAP61Vb4DNYqiMqHQNFm
 DA1LNZgqFnUMcj/7oiq10yXECFlhziKbhgoqV/aD1QCkW/AKbOqb0v4PV
 rZaAh3SjjtsBm8zNRt9e1dKONk2p4Df7sv+ij5lDoEsIK90kHiJcMvQmt A==;
X-CSE-ConnectionGUID: iIspnAKLQzmcuCm7WTbgbw==
X-CSE-MsgGUID: eERo/PNfTbKDpeD/slTo7Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11372"; a="53297245"
X-IronPort-AV: E=Sophos;i="6.14,246,1736841600"; d="scan'208";a="53297245"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Mar 2025 02:30:58 -0700
X-CSE-ConnectionGUID: hQ8tUvaeTn+06No8CJSoXA==
X-CSE-MsgGUID: U8KcczcVQiuIz5ttzh6WHg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,246,1736841600"; d="scan'208";a="121712140"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Mar 2025 02:30:58 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Fri, 14 Mar 2025 02:30:57 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Fri, 14 Mar 2025 02:30:57 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.47) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 14 Mar 2025 02:30:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ip86a6zka1n3J4RA92bMslRlF6fDr5Iy5w6zwKwZSl5GSoxXEI3v1zDPPAq3YHe3djBx9gRUOB/gv/Oc6ew5O1tlNUxi0cCufJasdH/luH128+jhW0AZzuWdZB2VBkTr0fMUprp4sMGvqVAHRw7gk0Cn0sAyUtVHnJvgITXGC42FuNqahe4iQwir81eh11sJbiiYCL4rVQ+QESZntNP8HjKoR3mVea746laHzpcQrSMZ+1BriVu5dZ/MEZ5LHx8+EFb50k/H0cPHIFlTVNaFqsWTESMy5whylVpO5z4S1DvYIMFhiTTPD2JHBphvVzQfuO9WYLXePFSe0BGUYx4u7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NdPZ3jAOoAR7Xul5UNMeT8yK/dY47edxw7xKIpUBu+o=;
 b=h7eyj4LgPXBUhgN6240jWARQCCM886OX03w5GB753iCsMoM+1KMKs1msiB/m3Dx71ABQlvOvXktJvrpxzkj6LuoUombNn+WnM9Jf3Q/BT9XDRXHVEtaqmGv48+MMfXFFbjR/611he2LfqxgwOCg/DZvtP7UjUhx8ia0AG5RywKmKM/tbcoqpHjyPHCiYNUTQixdxFnOCTEMLvF2Bp1Q4r1KJc4hcZpHrdGHeB5Xtpuja0kCTd92Kdgk+IqOF9d5Y73umeJMknX2bcYKLXByDQrDQdNV7AzHHCgYUHqg3D3uQrwXYFi+ZYLRuh3Njrgx9SR3pPryZd9ZKl5bJOd0TGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM3PR11MB8735.namprd11.prod.outlook.com (2603:10b6:0:4b::20) by
 PH0PR11MB4998.namprd11.prod.outlook.com (2603:10b6:510:32::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8511.28; Fri, 14 Mar 2025 09:30:12 +0000
Received: from DM3PR11MB8735.namprd11.prod.outlook.com
 ([fe80::3225:d39b:ca64:ab95]) by DM3PR11MB8735.namprd11.prod.outlook.com
 ([fe80::3225:d39b:ca64:ab95%7]) with mapi id 15.20.8534.027; Fri, 14 Mar 2025
 09:30:12 +0000
Message-ID: <192a8ed9-fecb-4faa-b179-ed6f9ef18ac8@intel.com>
Date: Fri, 14 Mar 2025 17:30:03 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 6/7] memory: Attach MemoryAttributeManager to
 guest_memfd-backed RAMBlocks
To: David Hildenbrand <david@redhat.com>, Alexey Kardashevskiy <aik@amd.com>, 
 Peter Xu <peterx@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, Michael Roth
 <michael.roth@amd.com>
CC: <qemu-devel@nongnu.org>, <kvm@vger.kernel.org>, Williams Dan J
 <dan.j.williams@intel.com>, Peng Chao P <chao.p.peng@intel.com>, Gao Chao
 <chao.gao@intel.com>, Xu Yilun <yilun.xu@intel.com>, Li Xiaoyao
 <xiaoyao.li@intel.com>
References: <20250310081837.13123-1-chenyi.qiang@intel.com>
 <20250310081837.13123-7-chenyi.qiang@intel.com>
 <8d9ff645-cfc2-4789-9c13-9275103fbd8c@intel.com>
 <11d40705-60d8-4ad6-8134-86b393bfae8f@redhat.com>
From: Chenyi Qiang <chenyi.qiang@intel.com>
Content-Language: en-US
In-Reply-To: <11d40705-60d8-4ad6-8134-86b393bfae8f@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR02CA0027.apcprd02.prod.outlook.com
 (2603:1096:4:195::14) To DM3PR11MB8735.namprd11.prod.outlook.com
 (2603:10b6:0:4b::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM3PR11MB8735:EE_|PH0PR11MB4998:EE_
X-MS-Office365-Filtering-Correlation-Id: 507004b9-848c-48c1-578f-08dd62dad200
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MTIxODVaa1ZocWVjVWM2aTloS1ByVXpRd0RteUthZVpFNjdkQlQvODNwSXhK?=
 =?utf-8?B?QnFlYnhNWHhFWDBaejZNVjVLWnJYM2hZNFg1M0RoMFJGbUZTa25OQWp4Mzcy?=
 =?utf-8?B?SFlqRkJVdUhqT1QzeGFrRWFheWFUQlRYeHRmUVBoeGFrczhLbDVoUGFsQVNR?=
 =?utf-8?B?SlIrZUxhL2t0SXc1anYwMW5NSUlYSkxZbDFoV1JwZ3IxeUNxYTZRYlI4SUFW?=
 =?utf-8?B?RGt3eG1MMkJYY0xSdUJzRUVPUUNoT051M2Y2UEh6QkwrRVZUUnFJSUljdkd1?=
 =?utf-8?B?L3Y3MnpOOHcyZVhqQ0RXUXVwU2xJZWczK2dEOHA3dUhBU1lVdi81aXZhblhD?=
 =?utf-8?B?cE5VWnowazBmUUYrRkx4anIyMWRtQjdsWFJNa2hnYWFrUmxjdmFOMEFDZXRw?=
 =?utf-8?B?TVQ3RjViRndnRnZHUEtabHNKQmhEZlhOZHBJWkhlYzZEbVV2UUt5MWVTUHVm?=
 =?utf-8?B?My9sdjNJUjJWaW1xay9zMWIreXdJbHFIY1ByRHIvdFhYMWk4NDV0VUR0dFdM?=
 =?utf-8?B?UkRSaTYxL0ZUWXZwa1J0ak0xaktBWGQyT0Y2NWVqV0pkRk9FSTFYU0YxSlBZ?=
 =?utf-8?B?T3duVDdwbW5TMG5jalZ2aVlGVFZhamtyYnI0WGpqMzNFaWZNWGZlR0ozcCtV?=
 =?utf-8?B?QnZPOUxTRjdUTFo2WXc3S05odzl6dUlEb3VDRUxQSEs1MDQyV0tZTEIxaUZ0?=
 =?utf-8?B?NTh4aWtzcXNMNldGMXBDRXgxbG1nV3ZXN1F6S2xpOHNYNnhDMlpGeU1lanZY?=
 =?utf-8?B?dXYydldGSjF2TEtvWkF0R2owSTJqb2xEZXp1NWtTUGlaODhLdUt3N0JLMVFV?=
 =?utf-8?B?RGdBVmcwQnJTejRNNmJJRnUwZnJ4NFpuUWFBZHM3cGg2d1o2cEZ5d0JsUWww?=
 =?utf-8?B?Y084Z1VkT0taUVlzaEdRcTVtVzROQjEzZDI0MjJLU3ZEV0dhd1c2dDhyRFBZ?=
 =?utf-8?B?NEVFb0RFMWR1Ry9vOXZjTjZrY3dLZUR2NTJqRUtIbENxT1JUK1p1TWV0eHh3?=
 =?utf-8?B?MFhGcFhlMkxzcUlBN1VGVXNkUDQ2aXVCWWJjanZrMllnMmM1Y0xUZkdkaHdL?=
 =?utf-8?B?YXYycGhtYWt0cUVLNmZGUHplVXJENXQ3NHFxc1E0VllYancySnljS01WelVO?=
 =?utf-8?B?bXh1RFFtMzRETHBpcXNVYnFqejZDM3FVYUpUSVNlcitZVFVRYldZd29CQ1RN?=
 =?utf-8?B?bk82V2d6NjJKVElEQ0ZuS2Y3SGpNaVE0TnljL2pGdnp2Uy9ySzlRSmV6ZnRo?=
 =?utf-8?B?bjZtTUx1M0djLzdHRFB4QlVadlR5aWpLYW1KcGtPRjRhdkx4a0dya2RZb1NM?=
 =?utf-8?B?aXY1SCtvcm80Vm91SHdPVlVyYm5aS0pqc0hNVmI0NWFaQVN5MU1vVndQR1cy?=
 =?utf-8?B?N3FOUDJOWEJVaW1ic20rWUNXVEsyQU5Wa1FnTlZMWWZEQjNTeDJYMXBWM1A4?=
 =?utf-8?B?bS9aY1IyNzlNZEV1NlpCN3RuczA2bGdLWUhEV3pQYU5HNnQwQ3prNkNqc0E2?=
 =?utf-8?B?ZjFFV04rbXhVemFQOWZWL3hLK2QzZzNhWWFDWG5jNmZHYnlwd0pCbVc0NmJ4?=
 =?utf-8?B?SFdjRUlKZjllUFpYTnkyOTVNTzhRN2JiaEd1a3JzcnM1eWcrTk9CZjUxdE1h?=
 =?utf-8?B?aHo3a05IcnJsYnF0NGc3ZjZmYm9vaVUzWjQxYndsdFFYVTJFSXN6WVBjY2NM?=
 =?utf-8?B?MkN2ajJjRkpJSU5CazNFSnI0UmZib2twdVNseHBCaGpySVJJL3VvSGVnN1NJ?=
 =?utf-8?B?VmlRc2ZYQ1JCNmg0S1RvSUQvSXJDczNndFMwU0Z3dFhJZElRZVN2aXJZM2w4?=
 =?utf-8?B?N3p6LzJKVGZ1ZU9ZeTNiZkxBR3NHSGdHelo0cXNLOVBZaHdNdHVKNXBGZkR2?=
 =?utf-8?Q?zkyd05oTOZzTJ?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM3PR11MB8735.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SnI2SzJzSTBxRm9VVkZnVmZoeWVjRWtyWUFKajlpMEpTakI0YUtydEswMktp?=
 =?utf-8?B?WjVIbDhweUo3dW4ranViU2lkWFViZ2pVSXFKTkYveWNFRW9RZGJUblprWFll?=
 =?utf-8?B?YkNEQWZzOU92OGtXQkRiT2dyM0NydTlKcVRpTWFWdEFGUG1nM2VtYmI3c01D?=
 =?utf-8?B?ZEFsWkw5aEYvaXoxRWxzTXdXN3BJaE5JUkN0WkhaK0VvSnpjMXJFdk5vcmVn?=
 =?utf-8?B?K1E2UitZekpXMHRwR0ZGaDh1WkNaa29jOFN3ZVQ1TVVhZXh3UTMwc3JGVWsv?=
 =?utf-8?B?bzlPeE05S0RzcklBSnl1VndhdW5FL2tuNmx4VGdyVk5XTjVGQXN6eXRuTWFw?=
 =?utf-8?B?R21Hbi95SW83bUIxOGlncERvamFnUno0T0lCQnJBT0E5V2s4ekJXaythMGxI?=
 =?utf-8?B?Mkh3R01QU0MxUkdnV1BPbmtYOUV2WUczNkplTGlVd2REbWRFVHB1Rm5zVDZl?=
 =?utf-8?B?MzIxTS9aQVd4TGdrV2k1Y1hhdXVqajBUMmFNU2JXM25pM21FOENBZkJOcEJp?=
 =?utf-8?B?TVhtdit3dmJRTmlCODZRZDlyLzIxUk4xRjloZG1pYm1ySVRiblFqT1Y0bHJT?=
 =?utf-8?B?V09BeFRjdXRpeEtjSVpSVW93Y0h2NjVDek1xS1czTTNFWU42Z3pxZkxFU2ZP?=
 =?utf-8?B?UU91UjZWZmxFc25DVlA0T0dJTHNHS25JcVZNOUhHaWlMOS85T2ltN0czcVg4?=
 =?utf-8?B?V2ZQMDF5YkEvS1lSWXhIMGZyRTlGZ3FuenVsS3FYYTdPL29IVFk2N05VeEpW?=
 =?utf-8?B?bHNHSHlRdThlTUpvaHhWZldXbE51SXIxUlFZVWkxczdnM2h0a2pyalltSld1?=
 =?utf-8?B?dUNkY2R4Mll4RVJOYjNPbkt0QU1jdjRMcEVvdlUwTkN1eUVhVkxVSlhPaWEv?=
 =?utf-8?B?OUY0WnZ4ZW44ZCtrMy94ZDRwSGpUTnY2UG1CWFFSMzdmcU13K0tUMC9ITWdY?=
 =?utf-8?B?RXdBT0thbWFZL1N0eDhudlhtNFlQSjVjbWdTVC9rZTMzN2F2ZENoUDdLQkJX?=
 =?utf-8?B?NEJjNmgxdGw2RUlHRDdKdlg4eC9GQVRFMHN4YmRsUUkzbVZuWHpiUVJFLzVo?=
 =?utf-8?B?aC9kbE4vZGNXUkZlY0tRNFVIblBRLzJKN0pxM1pYZTZVY1JRQVNOSE11NXow?=
 =?utf-8?B?bnlUMkVNNWs1eTY2ZHVVbm5XVndkanhFVnNhNVd2OFovREh0dGJ1VDUvdnFr?=
 =?utf-8?B?TXdtYnlEUzlQRkxZZ2l1TjBDdTZmcWgxVDhSSnpnbFpHMmZKMENmUFFxQmhn?=
 =?utf-8?B?WHQ0U2tXenBsLzNOOXN0K3pQVHM5bTF6ZmE0OEFuYzQycHlXWDFaUlRVQ1l5?=
 =?utf-8?B?N0YvUE5LMktXT2tiQ0hMMTZTM2hnYVFuVWg3VHN1SjZkTWhrZkZ0TlU4dXV1?=
 =?utf-8?B?eHBjR2w1VW9zZ3N1RFVRTGdmMHgvZzViMU1lWjlNczVCWElQQXdJR2dnc0du?=
 =?utf-8?B?WHNseDBlbjlKU0oxeldhbVgvOFYybUlpTmhZVitjTktjWFJtd2dLSGVIemFk?=
 =?utf-8?B?V0syS3NyamZ3dWNXS2JLQ0Y2YjRCM2pIR3BhQnJUM2l5RjRrK3pNZ2VSOGRz?=
 =?utf-8?B?bEJMMmcrVGRYbWJ4TnlPNnJjOTVIcUN3ZmhEZXdkSFVRZ0tJc3YxQUc5WjhM?=
 =?utf-8?B?Z0o3YWdCTllhNkM2S2dnSW9lYzlkZGlqM0w5OHdJUjF4UGVMTnEyY29iUWpo?=
 =?utf-8?B?Z05RdW1pR05oQWhzOHR4VFdYOFhqSmxubVlSYnNncjFVaGUzQkp4aXEwMzRI?=
 =?utf-8?B?SUVMNkU2bEFDNEJ4OEJTYUZaZWphSFpCZXppZUhockFlWExzVnRuelZtVDZO?=
 =?utf-8?B?Z0NFb3BtWVhnRGM5d2NmUjdBSi9RVWZublc4MG81Z3FwUWZjMnpwaEE4cXNO?=
 =?utf-8?B?bmxzU05XMzgxRnZzcjVFZDh3emVkdC9nMHRVVGxDbnp2YXFmT2IweUtLU3I1?=
 =?utf-8?B?cmhRTkNVQWVNUDYza0hlSW9seklaQnREMW80L2Q1aHhrU2FzY2JlZEtLY1JD?=
 =?utf-8?B?blpkL1kraGxBNFo3bmJiMU9iVjMxc2x1ZjJhS2JvM1R2Mm9TYU9FNVI1YmRT?=
 =?utf-8?B?N3J4VjRSNTYwSDAxbXNPdXhQQ0wrT1A2UEVtVFV4TWQrdWt4WktJOHhzTFpS?=
 =?utf-8?B?dm4rNmVjamZZWGdObzh0NmJ2MVpLUittZkthZy9MVGNpQ092S2R6REMybzdM?=
 =?utf-8?B?UWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 507004b9-848c-48c1-578f-08dd62dad200
X-MS-Exchange-CrossTenant-AuthSource: DM3PR11MB8735.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2025 09:30:12.5258 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0MP0vgZ6BpWf2qHWP2b11qcFwjGcVnT5I186vybQgE0X0po3zqOUuccP4cX998T+adskmftYsTiVlVI0pESqeg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4998
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.11;
 envelope-from=chenyi.qiang@intel.com; helo=mgamail.intel.com
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



On 3/14/2025 5:00 PM, David Hildenbrand wrote:
> On 14.03.25 09:21, Chenyi Qiang wrote:
>> Hi David & Alexey,
> 
> Hi,
> 
>>
>> To keep the bitmap aligned, I add the undo operation for
>> set_memory_attributes() and use the bitmap + replay callback to do
>> set_memory_attributes(). Does this change make sense?
> 
> I assume you mean this hunk:
> 
> +    ret =
> memory_attribute_manager_state_change(MEMORY_ATTRIBUTE_MANAGER(mr->rdm),
> +                                                offset, size, to_private);
> +    if (ret) {
> +        warn_report("Failed to notify the listener the state change of "
> +                    "(0x%"HWADDR_PRIx" + 0x%"HWADDR_PRIx") to %s",
> +                    start, size, to_private ? "private" : "shared");
> +        args.to_private = !to_private;
> +        if (to_private) {
> +            ret = ram_discard_manager_replay_populated(mr->rdm, &section,
> +                                                      
> kvm_set_memory_attributes_cb,
> +                                                       &args);
> +        } else {
> +            ret = ram_discard_manager_replay_discarded(mr->rdm, &section,
> +                                                      
> kvm_set_memory_attributes_cb,
> +                                                       &args);
> +        }
> +        if (ret) {
> +            goto out_unref;
> +        }
> 
> 
> Why is that undo necessary? The bitmap + listeners should be held in
> sync inside of
> memory_attribute_manager_state_change(). Handling this in the caller
> looks wrong.

state_change() handles the listener, i.e. VFIO/IOMMU. And the caller
handles the core mm side (guest_memfd set_attribute()) undo if
state_change() failed. Just want to keep the attribute consistent with
the bitmap on both side. Do we need this? If not, the bitmap can only
represent the status of listeners.

> 
> I thought the current implementation properly handles that internally?
> In which scenario is that not the case?

As mentioned above, e.g. if private_to_shared:
1. set_attribute_shared() convert to shared, but bitmap doesn't change
at that stage and is still private.
2. state_change() failed, it undo the operation and bitmap status to
keep unchanged.
3. core mm side status is inconsistent with bitmap.

> 


