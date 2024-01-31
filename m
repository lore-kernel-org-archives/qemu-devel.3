Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6F3BC47258
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jan 2024 15:22:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVCP6-0006rn-UX; Wed, 31 Jan 2024 10:21:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1rVCP3-0006rU-5L
 for qemu-devel@nongnu.org; Wed, 31 Jan 2024 10:21:31 -0500
Received: from mgamail.intel.com ([198.175.65.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1rVCOz-0006x9-7g
 for qemu-devel@nongnu.org; Wed, 31 Jan 2024 10:21:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1706714485; x=1738250485;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=Qowa2W4Iqou8fcmosIdddhUCyzosY1dluzmcFdYnIFc=;
 b=Q4a5ZkpBC6bidbTFdLHycarvvQ8xjF1vCFFmj/I7NMYIhTsRPafj6LAj
 nTw6qaALSKY86d4YUWuzUWlrwYixscRW2ZkYsQf6TuAcUmtf8zlKfhmVO
 stBfGCnAQf4G4nVq1dk7whFvQjDBTre55vwj9l29z+M0RO6ARLQTjWooC
 0eWySND+tiKjjp9siLHeQpUo0os1UvQcypV3x+ciPzefE+C9W0E3sPixx
 nEFsWGbOAlqPyodfDSSd2Jzs68m4h/4uvu40P3Vx618JdW8K45EVcyewy
 mMkDRzz4FLVJAYIj/cITnYDvZqh4oTZPi2FaJSnLrRoBEVDWSS5+r0f9a A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="22133781"
X-IronPort-AV: E=Sophos;i="6.05,231,1701158400"; d="scan'208";a="22133781"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Jan 2024 07:21:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="961627623"
X-IronPort-AV: E=Sophos;i="6.05,231,1701158400"; d="scan'208";a="961627623"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
 by orsmga005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 31 Jan 2024 07:21:18 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 31 Jan 2024 07:21:18 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 31 Jan 2024 07:21:18 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 31 Jan 2024 07:21:18 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NRpJOwg873s3ZEdxo96FywfVPaZVmgexLqVM2pwGU87jpOkSDqCWTQPLf5+I2tZDm/CTkXXUPlzoN66yD1fCmkyBaCa7wWp0hlUPFx4GqDvwwbVQGgojVDGUGpqdjix7eNrh20mECLFDi94YeKg9wmtWmLnFywcWdKsqTJCdVWdQczfFZywZSeHHlOqH5Q7s6a4MdLGHnhoE8QcuRvB8VaDch2Wgij+H45brX2m2B70H1qO81dSTqLomg4lhx1AG3nIXIJmyitx043WOZBEl1t4KwSLaeFxi6mOuJ0OfqQi31rO4muQvPmxbTZ/NeBmZ0IaE2exx5xJ08y0EwoP6Xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cmxJVUWXRcwBaaGx/o9qORjsjz1fknjJ7rue6qzTG3k=;
 b=ABefISc12faJx7S5IvtoTsQAqPRnO+wo67Bd1jqRjhxoFYINmxbpIVDZn5CS4VNTzjD4yPu2YPjLbVN6C2xYQYk+OpVrh2ixjCId/gcwsyxVgG/QB8cgu8wDE8tFW8OxBh0dFD7Xvmbp6xjXJcmR4lLPzIDPZUa7M/7Smq8VnA+FBA0e7e3L5ExJMlfNckMSkFGmsEy/7q/n7TNyogR1cZe0GkpuFdNl6Ks9BtsnzxGYrjwejV58P7Grdp4D6HfApn0h+8JEFUTAfzPoi80QyBZOubypLmZNnFvGLJ0o5WEDvMMXHDmA2D+HWL7QGn5++5W4iboYOw3X6UujXhT7nQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by SA2PR11MB5036.namprd11.prod.outlook.com (2603:10b6:806:114::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.22; Wed, 31 Jan
 2024 15:21:16 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::b877:93ff:2217:eb13]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::b877:93ff:2217:eb13%7]) with mapi id 15.20.7249.024; Wed, 31 Jan 2024
 15:21:16 +0000
Message-ID: <4b92ba16-5839-4c93-bd07-46e177de7d18@intel.com>
Date: Wed, 31 Jan 2024 23:24:18 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH rfcv1 23/23] intel_iommu: modify x-scalable-mode to be
 string option
Content-Language: en-US
To: Joel Granados <j.granados@samsung.com>, Zhenzhong Duan
 <zhenzhong.duan@intel.com>
CC: <qemu-devel@nongnu.org>, <alex.williamson@redhat.com>, <clg@redhat.com>,
 <eric.auger@redhat.com>, <peterx@redhat.com>, <jasowang@redhat.com>,
 <mst@redhat.com>, <jgg@nvidia.com>, <nicolinc@nvidia.com>,
 <joao.m.martins@oracle.com>, <kevin.tian@intel.com>, <yi.y.sun@intel.com>,
 <chao.p.peng@intel.com>, Yi Sun <yi.y.sun@linux.intel.com>, Marcel Apfelbaum
 <marcel.apfelbaum@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, "Richard
 Henderson" <richard.henderson@linaro.org>, Eduardo Habkost
 <eduardo@habkost.net>
References: <20240115103735.132209-1-zhenzhong.duan@intel.com>
 <20240115103735.132209-24-zhenzhong.duan@intel.com>
 <CGME20240131144013eucas1p22d46339ae42f54dd59c23e8b95502dda@eucas1p2.samsung.com>
 <20240131144011.onhavz2bl2ch7vkv@localhost>
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <20240131144011.onhavz2bl2ch7vkv@localhost>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0028.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::6) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|SA2PR11MB5036:EE_
X-MS-Office365-Filtering-Correlation-Id: d9105dc3-37ca-4d45-272a-08dc227043e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: heY1UlgfHg50aUgAXpafqIrP2S4XjVZZ/y6CL9+/Yt3KGpvcXggaZhJhXbu6UkM6gNroNIQyXy294vL7HYue+fEPzrXBdHEvzzCGr6bgL3dQQnIIT/wcVAw9dsBmljzoQnKst2zaD5kaG6XXSdaCE0LFxKtE6/7UnXD5eP2YLs70bNRBktwtXywO2mnn500ab+WKM8ktinSIC4KWNmPhntuEXAhoxMLkwU4QToE6HBS+NymjT/08ByIDpLBjwJ8TWdMa5wXw/He9pcRmmOAK0+FAH5Iux5jqEXjoWv3/2RrxNO8b7D09uzcvW0Ecyb06voM7CqIvBHZ8q2WBUDd3vhCI3WfwA6KLTsWSi6KcRl3n7rVWyqt00qW4sJImGKgIW5f3Ba1SIokhlosYHy76LQAik8kfGhMY4bWegAyCYDmXNiF+uxtg8w6mEcj2QCOr3BUoABSXWVQw5XQlV059NWCL+Q8hbmivzMCKigDfOXEh+vfK+2QNWnC3QdEZGToBsLjl+vg9Z053zRCL43tIa3DFHY0tlWU+rAlfyadqcB2znAtTy3TSE6fCX+u128AmquDaoAtQzijxhkviY4c7BhPMZxRjHmWPbPBZA1HLzKRzVAmCaVkFbxYFLBcivdP6mXtDflDpoD9DTt9DW8DUVQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7529.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(366004)(346002)(136003)(376002)(396003)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(41300700001)(26005)(2616005)(31686004)(36756003)(53546011)(478600001)(6512007)(83380400001)(6486002)(6506007)(38100700002)(82960400001)(316002)(86362001)(31696002)(5660300002)(7416002)(2906002)(66946007)(6636002)(54906003)(66476007)(66556008)(8936002)(110136005)(4326008)(8676002)(45980500001)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OXlPVGx1eFRiaUt1NlZtL2lLelFqaVpZSUNPS1RBaWlJSkdIZHA0eDN4MWdR?=
 =?utf-8?B?c2JvSHNISitNNGlKenp5bkx2U3NDVUJRRllDdnJCRDhLM25qaTE1cEF0bktM?=
 =?utf-8?B?RDY3RUNBSXRiOG4rNkZjZXVSNmZTbmVUYVZsWFB3SVZ1TDJSeVFRWHF4bnVZ?=
 =?utf-8?B?MUhjM2RiZEJoVitTNG1HZDk3TzAva2YyWktUTitUcTltWkNEOFZRcVhUSEtD?=
 =?utf-8?B?ckovQTY3NTEwbzNWUzh5Y2dVSUIwTERpUDIvU0JFVCtZOXJ0SUxXckx2Mm9U?=
 =?utf-8?B?TnB2ODl6SmkwcVRQNEQ2NDJrcm1lYkY4bmxrNmFqRk5pU014SGMyWWFmenJW?=
 =?utf-8?B?WG90UG5kdE4xYTFabGVDeVcvTTJEMytteVhIUGd3K3NvZThUUnh2MU0vaFd5?=
 =?utf-8?B?cVV2Y29weS9YSWhEdkFhTFZLb04vOXZVeWc3bFBtSjVvVkJZVWw5RE9WMElJ?=
 =?utf-8?B?N1NIN1hNTmxQYTc1dGFXV2hRa01pRFpaeVMwRVZ3OGVobEVKeHQ0d0MweDRN?=
 =?utf-8?B?c1Urb0VkK2N6SlFmYS9wRjZHTmRZV3h2S3JKNzNlL05lUXE0Q1NTamNINytC?=
 =?utf-8?B?Sk1SdVVaQUE2UTR2V0JDY3E0V2pwNG1reUZmdUxLT1haUDd5VTA5RVlCMExX?=
 =?utf-8?B?V3RkOEdQM1J0TUd1a1ZBYXVEY2tQU3R3ZmxHakNGMDFZNS9CNDRwYmtudkNJ?=
 =?utf-8?B?bXZpQjloL0x4WVhQS0dwZmkrWnJvVUV2U3ZLdlpJOVRpQ1A0U0FvaHp3UXg5?=
 =?utf-8?B?bjN3UXlicmlTRVJxUVR2N2taNHA5U2RrVTJQOS9WTUt6YnF5TUNwN0tHYlBJ?=
 =?utf-8?B?NkgxM1RtTjk0eVNWQmRUbi9JMkREUU9XOUxYaGx0UVdydFkrUmN0Zy9Fcjdv?=
 =?utf-8?B?NS9EYUhsTGRlVmpBM0JGdW5RdmdGYVVCRXdMM1ZMNGMwalEzVENIQ201VlMw?=
 =?utf-8?B?Vzl3UzYybFdzazExQWtsYURwWDh3TzE2UDMrQlNZemsySXR1Wk91dURwN29w?=
 =?utf-8?B?dHFhS3MzcnJqUi9wNUpsbkJMeDNPYXE1TXB6VThCNm1zcklFbVNKcURadDY5?=
 =?utf-8?B?aklsVFVzdGVEeHYxTXhiQUlIVVE4Y0ZkSktpUmFDY1dHOTJhNjJrQkY2ZTVo?=
 =?utf-8?B?UEJuVTgxWm5FOWNWcEliL3Jqa25QN0NCU01pdlBsamlRMDFsbzEza3FHRlpm?=
 =?utf-8?B?R0gwZVZhUmYvRW9TWDdMOWxLcVZyc0pvYWNYMEJkWWpKTWhWVHVYNFBoTFR0?=
 =?utf-8?B?MXU4bHZQVlFhcjRQQlJwaGpsMmZMUTg4OXlwMXBnejBzS0VWMlo3SDNnUUhJ?=
 =?utf-8?B?YXBrU1dockhaNjduWUxLdGszdm1wbUFjTFZ0WnlWQW9oT1BNVVFFV0pnQytE?=
 =?utf-8?B?V0w4SmRxaGRzZU84NkhkM0d6SDRyTnp0ei82OHdBMXZYRVJOTVhOS1hPV0Ja?=
 =?utf-8?B?ZWhkN0pMYkdESUI5L0c2VFhGTVRsenJlcURSVHByTCszWCtjL0lsclRsTVlO?=
 =?utf-8?B?V05BTmNiWER0TjNLK3JTOFJRN01IMHF6dVE3ZmtHSEFOSnN4SDl5ZndvdDFz?=
 =?utf-8?B?OVg3SXkzSUJRNlROMVplNStSQ3NlaXZyTmNVUk1VKzZLaUxKTTI0ay9CQW1O?=
 =?utf-8?B?QkFSVHZhNVdscE1jVFZiTi9idEh0T0hSTTFzYzJ3RmNCUFFDU3UyWEhDazh2?=
 =?utf-8?B?VCt0T2JCcVQreUFDQ3puTS9ieWl4c1FxN3pQeWlpMHE4c3BuZStoNzJvSHU2?=
 =?utf-8?B?UG5LY05mbGNQckV0cW5rUmJ2Ujk3Ukp3amFxdUhaRklPNGNJTFQrcDY5TXZj?=
 =?utf-8?B?OWRBOTdUNTljV291T0NsWldGZW9HcUVRaEtKS200alllQ281MmZsSFFUZkZF?=
 =?utf-8?B?UHF2L01odVBIS3A0S0VNRVdVa0I4SGQ5WndheGNxSVpuVUFTcEdza2NLaEcw?=
 =?utf-8?B?ZkI0QlB3bGk5THdZeUUvc0NZcEcyeUJlMURKQVk3SWI2RndQTy9nMElZVDdT?=
 =?utf-8?B?RG96UUhucWlJY2lRdnEvSVQ5clBzMzhLdW4xMjVSdnovdkp5Zmt2R3FYYWJB?=
 =?utf-8?B?RDVyTFVhN21jbkpKMXVvTzVrenh1dVpJNXJtZTRkV2JhTzQ2NjVVMTYrVVp0?=
 =?utf-8?Q?koLGYxHs2vOqfpR11HXg16vIs?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d9105dc3-37ca-4d45-272a-08dc227043e3
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2024 15:21:15.4171 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QDCQetTKyTgP/wpvPUyS6vvUQkGG4olF5N/gJ+jeBNWEykCiv1GsV8pYOrFqXO2L1vH648n6UoTeqwITx16b2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5036
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.9; envelope-from=yi.l.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.292,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 2024/1/31 22:40, Joel Granados wrote:
> On Mon, Jan 15, 2024 at 06:37:35PM +0800, Zhenzhong Duan wrote:
>> From: Yi Liu <yi.l.liu@intel.com>
>>
>> Intel VT-d 3.0 introduces scalable mode, and it has a bunch of capabilities
>> related to scalable mode translation, thus there are multiple combinations.
>> While this vIOMMU implementation wants to simplify it for user by providing
>> typical combinations. User could config it by "x-scalable-mode" option. The
>> usage is as below:
>>
>> "-device intel-iommu,x-scalable-mode=["legacy"|"modern"|"off"]"
>>
>>   - "legacy": gives support for stage-2 page table
>>   - "modern": gives support for stage-1 page table
>>   - "off": no scalable mode support
>>   -  if not configured, means no scalable mode support, if not proper
>>      configured, will throw error
>>
>> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
>> Signed-off-by: Yi Sun <yi.y.sun@linux.intel.com>
>> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
>> ---
>>   include/hw/i386/intel_iommu.h |  1 +
>>   hw/i386/intel_iommu.c         | 25 +++++++++++++++++++++++--
>>   2 files changed, 24 insertions(+), 2 deletions(-)
>>
>> diff --git a/include/hw/i386/intel_iommu.h b/include/hw/i386/intel_iommu.h
>> index f3e75263b7..9cbd568171 100644
>> --- a/include/hw/i386/intel_iommu.h
>> +++ b/include/hw/i386/intel_iommu.h
>> @@ -320,6 +320,7 @@ struct IntelIOMMUState {
>>   
>>       bool caching_mode;              /* RO - is cap CM enabled? */
>>       bool scalable_mode;             /* RO - is Scalable Mode supported? */
>> +    char *scalable_mode_str;        /* RO - admin's Scalable Mode config */
>>       bool scalable_modern;           /* RO - is modern SM supported? */
>>       bool snoop_control;             /* RO - is SNP filed supported? */
>>   
>> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
>> index e418305f6e..b507112069 100644
>> --- a/hw/i386/intel_iommu.c
>> +++ b/hw/i386/intel_iommu.c
>> @@ -5111,7 +5111,7 @@ static Property vtd_properties[] = {
>>       DEFINE_PROP_UINT8("aw-bits", IntelIOMMUState, aw_bits,
>>                         VTD_HOST_ADDRESS_WIDTH),
>>       DEFINE_PROP_BOOL("caching-mode", IntelIOMMUState, caching_mode, FALSE),
>> -    DEFINE_PROP_BOOL("x-scalable-mode", IntelIOMMUState, scalable_mode, FALSE),
>> +    DEFINE_PROP_STRING("x-scalable-mode", IntelIOMMUState, scalable_mode_str),
>>       DEFINE_PROP_BOOL("snoop-control", IntelIOMMUState, snoop_control, false),
>>       DEFINE_PROP_BOOL("x-pasid-mode", IntelIOMMUState, pasid, false),
>>       DEFINE_PROP_BOOL("dma-drain", IntelIOMMUState, dma_drain, true),
>> @@ -6122,7 +6122,28 @@ static bool vtd_decide_config(IntelIOMMUState *s, Error **errp)
>>           }
>>       }
>>   
>> -    /* Currently only address widths supported are 39 and 48 bits */
>> +    if (s->scalable_mode_str &&
>> +        (strcmp(s->scalable_mode_str, "off") &&
>> +         strcmp(s->scalable_mode_str, "modern") &&
>> +         strcmp(s->scalable_mode_str, "legacy"))) {
>> +        error_setg(errp, "Invalid x-scalable-mode config,"
>> +                         "Please use \"modern\", \"legacy\" or \"off\"");
>> +        return false;
>> +    }
>> +
>> +    if (s->scalable_mode_str &&
>> +        !strcmp(s->scalable_mode_str, "legacy")) {
>> +        s->scalable_mode = true;
>> +        s->scalable_modern = false;
>> +    } else if (s->scalable_mode_str &&
>> +        !strcmp(s->scalable_mode_str, "modern")) {
>> +        s->scalable_mode = true;
>> +        s->scalable_modern = true;
>> +    } else {
>> +        s->scalable_mode = false;
>> +        s->scalable_modern = false;
>> +    }
>> +
>>       if ((s->aw_bits != VTD_HOST_AW_39BIT) &&
>>           (s->aw_bits != VTD_HOST_AW_48BIT) &&
>>           !s->scalable_modern) {
>> -- 
>> 2.34.1
>>
>>
> 
> I noticed that this patch changes quite a bit from the previous version
> that you had. I Specifically noticed that you dropped VTD_ECAP_PRS from
> intel_iommu_internal.h. I was under the impression that this set the
> Page Request Servicves capability in the IOMMU effectively enabling PRI
> in the iommu.
> 
> Why did you remove it from your original patch?

It is because this series does not cover the PRS support. It should come
in a future series.

Regards,
Yi Liu

