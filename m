Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93557CD4F39
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2026 05:16:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNOQ1-0007LL-L6; Thu, 14 May 2026 01:15:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chenyi.qiang@intel.com>)
 id 1wNOPz-0007Kx-Qq
 for qemu-devel@nongnu.org; Thu, 14 May 2026 01:15:31 -0400
Received: from mgamail.intel.com ([198.175.65.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chenyi.qiang@intel.com>)
 id 1wNOPx-0005vO-HZ
 for qemu-devel@nongnu.org; Thu, 14 May 2026 01:15:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1778735730; x=1810271730;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=yAY6xozKNf7RGcgnK3lWLBwE6Lqi0uxViPCQo/fOens=;
 b=FV0ICcUhPneZgP07aj2Lem67W7pg2CiKNInRa0y5AzfVTTTBXsCKJ5Zd
 TtuiHCHJ24ZFq89KM86k2SJfSwrMZJaJ7X9uQYi60gLCxGB73Bht6huGO
 FuKlemfUkc37r3ZXneCuApwKBMVu47pvGmPeL680IAvTEdbkCdQQ5Gt81
 KC9fN7Nhj9E1i97Qq1iyUe+gqB+3lEw9oBOqjZBVCMkXXX4IQn8Hbvei1
 vpHtAkDpJeYUJ273pH2iiCPh9V1g7n2/VMCCWcHMYQWOL9P8d6a6cBeYl
 Qk07fKLlP3PWteqGeqyc9/pag8OGKUUF/ZQvQCd8GivGWoR/XKFJggjvn g==;
X-CSE-ConnectionGUID: m73cv3QNTreqPdg97dW1hQ==
X-CSE-MsgGUID: WCcCeiIKSsyGVzOwujogOQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11785"; a="79626091"
X-IronPort-AV: E=Sophos;i="6.23,234,1770624000"; d="scan'208";a="79626091"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 May 2026 22:15:21 -0700
X-CSE-ConnectionGUID: zpPcxO6RT1Gnvrl6GfcwEg==
X-CSE-MsgGUID: dAbdEFJxQOKSyaNxzDoaMA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,234,1770624000"; d="scan'208";a="233853268"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 May 2026 22:15:21 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 13 May 2026 22:15:20 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 13 May 2026 22:15:20 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.17) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 13 May 2026 22:15:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fe4LboqIqfK1RHwhon9NZ2Ol+95R0NVL7+7l9xWaa94O0ImunIVAL56rHnes6JqehFTCVDaL9qmHA0OxVHgzaU0mKnPpk+pMOFSbfApoo/UEIw5MGp5xdUX0Vtv/DvSz0kEhzmXPnN/L3Pe0BATnJmmQG4xy9Ofwb+l4+w0GL2B4j/EsUxGyJrgmuZUlSSXj+DL4A8s6v/9bgmPWTMTJaLC9psm0Gn6xA1pVvB2K3fkNn9l87laRJ0bBe2CHU7BzwiFaqThRfk80Ploi4z9OYaqjZ0VAHL7xSGqir2vl+vCz52EptD51u9FZIrHpQwnDxgZq2pPy/v/W+pSSok6GbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=quf94dR+f/E5uc/wpLm5BtY92245bKO4XAVoNZyI7HI=;
 b=Scb+x+1lPgd2c5lJgPxBmzBkHFrzJeUfU/+H73qN8RF8xxLKxikkRscbfdnasBowo0c4k0GjEuI+A2tsl4NX89/2Gw594Pq4RXvV6KwxUG8Ng+8JpAzFY3Ox+si3uEQ1FyGNYmngpabolmse2x5eVEJgle+5hNbfcGRQHXCCHk1lSe2mNs9F/QTsod2Zy5h9WXQHWMmv3ulhcCXDNzfZEaZNOEzV+sxyEnryzyG9dZxV6AgPu5xc/Ldz/7eSaYz/91Wwplp/tg+G23QHTcAi5AX28XDTsL9c+DyTWOVUbcEyS0Oh2drXDmNQ5StbbULjQQ43/5RLs1HCk0YBi5NhWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM3PR11MB8735.namprd11.prod.outlook.com (2603:10b6:0:4b::20) by
 PH7PR11MB6771.namprd11.prod.outlook.com (2603:10b6:510:1b5::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Thu, 14 May
 2026 05:15:12 +0000
Received: from DM3PR11MB8735.namprd11.prod.outlook.com
 ([fe80::8f1e:49f4:122c:c675]) by DM3PR11MB8735.namprd11.prod.outlook.com
 ([fe80::8f1e:49f4:122c:c675%7]) with mapi id 15.20.9913.009; Thu, 14 May 2026
 05:15:12 +0000
Message-ID: <ad3e5cca-9cb9-457e-8d11-b751727b58a9@intel.com>
Date: Thu, 14 May 2026 13:15:05 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 00/13] Make RamDiscardManager work with multiple
 sources & virtio-mem
To: Peter Xu <peterx@redhat.com>, =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?=
 <marcandre.lureau@redhat.com>
CC: <qemu-devel@nongnu.org>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@redhat.com>, David Hildenbrand <david@kernel.org>, Paolo Bonzini
 <pbonzini@redhat.com>
References: <20260504-rdm5-v4-0-bdf61e57c1e1@redhat.com>
 <agTk3NSZaI9IwlUs@x1.local>
Content-Language: en-US
From: Chenyi Qiang <chenyi.qiang@intel.com>
In-Reply-To: <agTk3NSZaI9IwlUs@x1.local>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR02CA0015.apcprd02.prod.outlook.com
 (2603:1096:4:194::16) To DM3PR11MB8735.namprd11.prod.outlook.com
 (2603:10b6:0:4b::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM3PR11MB8735:EE_|PH7PR11MB6771:EE_
X-MS-Office365-Filtering-Correlation-Id: 437ab0a9-68a3-417c-e95a-08deb177c65c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|22082099003|11063799003|4143699003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: 6H5Bkk7yAoCECI7S9jjaoQD03y3yqI6SP4dL/AJi/VaQFuBRSLcgSTmcUcvQjoASDlka1Sr8iCsPcbT+dXuHBbS987nOQzODThqSSgegj2k51bErrJ/4D1xyfbcEMh6GLFN56zva5fk8Z5GUYTa+0Lq8BVR21N9X0oU7fonHFzChmVrzdzsensWmyAeV1JXPHP2K2w0r+Ml+1zGGHuOleicdIPSEMXwWkW+aPiA7ctvsl4RUVstKU8/jZR3b2vlxPeUZE6Wsq8PxyqCPt2/VBwWVmG9gqwwRC2/HpeoXvQ6weCwIc/ixFcDTW7b+pgHrjCjj5CtgQyAAfz/lys5oyUD4Tvq9+BDkeaFh4tEsKrNGnynA5jrvapy2K3ST6/TqyfbQ66Ip+ImDv8qk6tamLC7CaVT/tuwEOXCm6/lVSdnmUzfN+wjsFufJydBrrRdQKIUQuf45nD6flDdOb4aRltCz23kudgmCaSJQ7NnH6CnJ4xWD+jOeqD+46kChjlK6C4V0RIek6zSR+DWikP9bfMw7UcuWpPChal1djG+dUifmCSx/pjaqIh0/cSaJriwMYG2su2yrXKckNe/7NcqLaVMH1lSrowvbr6Mf1gjKe0UCBp37vVDkOoGR5JaXNwWY6tJr24aDIGDF7mp09LdNBQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM3PR11MB8735.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(22082099003)(11063799003)(4143699003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QmcvYzFaeEVycWFOWUZRM2xUWFdVYkp4VElHd3owUDNJVXFpWTNSc1N4d1ZD?=
 =?utf-8?B?OXByM3ViZkxtN0NvRHlVVmpPN0MvSS83bXk5emdBdWlLbW9rWFNrZDQ2YWJH?=
 =?utf-8?B?R1h4L3lqY1JQNHNubURwbFpWclFJaGVJdVQvaDhXSUxmSGZZK3B3UjM2SGQw?=
 =?utf-8?B?dzlMSUk4UFBQUDhPdUgxbktNcno5UW05RTF4YVhrcE1raXE2dGVVN09NWHdQ?=
 =?utf-8?B?S1JwS3h5bmtTTWNFZFlFRCtmUEVrMjJiMU9Ja0duNVVXN1lJbnhXbkJ6QThV?=
 =?utf-8?B?Nk1XS2xkMXhQV3h4NGJzZkx2V1dsOU4yMnRlWDdMOENVTUM1dTBrTElqTHhq?=
 =?utf-8?B?TklWZ2ZET3JLTjhpeklPbTF6Z1ZwOHowSE51eUpCclIwMmNld0ZlRmcxUlJC?=
 =?utf-8?B?ME1rL2dUVEc5SFdqY2JMYzZ1MXlCOTZINm02WEFFQStMVkVXS3JraDNISzN5?=
 =?utf-8?B?K2kvejBUN0J3ZlVsQ3VNeEpSc1dqaTM5N1piMU0vbmJUQ1I3bm9mQnFkVmZJ?=
 =?utf-8?B?UlpPVXRVbDVRajBXWjNBVk43YzhMWEtiWHM1SHUyMWZ4ZWk2cmxjYUV4YStr?=
 =?utf-8?B?NXJJQVdBejZZSWxvME14MFhYZnRVdVV5M0tOZlQ5ck8vNTRrRE50MTNGR3Bj?=
 =?utf-8?B?dVRCaGdoTTNFeGlkdTdnT1N0L2dpWm5RaGZnbHdpUDdDZ0Q3ekEyZGpWbnFO?=
 =?utf-8?B?QURJLyt3OUx1bExPS3RpMVJtTW5KV04vNnBOTWNMVnNVOExsVGVOQ2x2OE15?=
 =?utf-8?B?OW10RWtyaUNWMHRDZkVkWWFRQUJ1clVyYlMvaEswQU9TMVU3K0VObG1tWDB2?=
 =?utf-8?B?MHFOVTFyNUJNQU4rQUt4RG5QblI0TVVVWXdQK2lHdi9wYWVUUzlFWkdwNlJq?=
 =?utf-8?B?NlU3d3FKdmF3eUxaQ3lZQzR4dEM1TEJWNkd2ZEZnT1pHL3pST25OZ3RlU0pz?=
 =?utf-8?B?b2k4VUptVmNXa0wxYnpjWlZyWVpMYmJReVUrZnNVWGcrSGZOYm5UU3ZPL1Vq?=
 =?utf-8?B?MU4vN3AwV0VkcmplSWJheUdjL1BVZklxUGxsSUdiLy84bGhieWdPRmNhRHZm?=
 =?utf-8?B?eEJxeGZPRGZ6MlRlcGVSeTJoZzF6Y2xkcDJ5b1NPVkpqS0Z0REZmK09ybVo3?=
 =?utf-8?B?bHBzYkE3ZTAxRDVCOFl0V2dHcnVyTXBEQmFtOUkzVVQvZUlEMEphNndialhp?=
 =?utf-8?B?WGg3b2RTRzVYRnppa29uR1dVRmh2MVRXRnNiYUR6d0tZNEtpQjN2U0dqZVY4?=
 =?utf-8?B?eVpPa2FUUFNqWEd3ZXZHRlV1VG1iNi9ialp0WjRqZi8yekwrMzJxQjNocmJI?=
 =?utf-8?B?THlMOG9CbXRTNXVFWEVKekRnUUV0R0hndUZoUkZLcFpuODFleHUyQUVid0RK?=
 =?utf-8?B?ZThQcWhXM1Zyb3ZKbHFscGZ2aEI3Z3grNnNVUVlTQ3F4UTFLSHVaV1FKY01o?=
 =?utf-8?B?RkowdVp4N21jdkpxcFV5YkgvNzQ4T3NHQkdaNjBmZXVQVVNDSnoyMWF0aUsy?=
 =?utf-8?B?S0RWOEVtT0N5ek5SWXMzcmJOTjJueldlRWlybkZYaHZudmhpMVZrRVRRa0Uw?=
 =?utf-8?B?dUdLUGM4bWp0Z1RlN0YxN3hqdWtjTzNsallmSkl1WkpobmxUekJIZXZZdE5Z?=
 =?utf-8?B?STg3MzBZYm1XdEhPam1zSTY4L2pFZFpGaDEveWNjcTdTT290SkJxUWhXYW9j?=
 =?utf-8?B?OEg1bmNGaGluaVZtaFJpUG4xZGUxTnlLV1ZtcTRFMjN3VGNqK1VRejJGQSs3?=
 =?utf-8?B?NnJsaVZMUTRwRDViYW9scW5jMlJTRVNmbWdUTTZNQ2FPQ2o0UGQwUjNQK2p2?=
 =?utf-8?B?WFM2S3NHSlR1bkZBSS8vMkl3bzlJREkrUWxEbVl5eVp0bmZtaXhWRmE5M3Y3?=
 =?utf-8?B?MWV1aFVFSzVDbGd2cWtIT1BKKzdzYWcxeVFUamxkZENIWk50Y2VKOUQwdUhx?=
 =?utf-8?B?Z3VsR1huWi9CV0VDVFMxSGpUeUZzR2VqcjQvN3VBcm8yQlgwWUFpYktkVUcr?=
 =?utf-8?B?cUNUVDNMekZkazAxRXJnNUpvUXR5V1hheXc5NlkwTWJxZGFLWlhWeU55Qy9D?=
 =?utf-8?B?TUJLWmtaNmV3K3RlT0NnMEpMd0pUb0kzRUp2RW9OTXpGOUFWVkl0c08rQ3Za?=
 =?utf-8?B?OE5wZ01uQUFDUUpaQk5MOEEvbGNMQkFDTXpqZHZUdEJQZnA1alhZeVVtNlZV?=
 =?utf-8?B?VHJsYmREd243dHUyc2gxdUo2aGgyeFh2eXBEZDQyT24zeWljdUhZYUJaSisx?=
 =?utf-8?B?TXhSdHk5Z21sZGdjanp2bytLQVhLcVZTZ204K3hVc3BxT1NlM3VDM3lHY1ZY?=
 =?utf-8?B?Q1dkMHVJVy9ZT25qZzlFRVNJTGo0SXBEdjV4WmxWWjNtaEtjN3V4dz09?=
X-Exchange-RoutingPolicyChecked: giwXO36L42RyAH/a8K570lVVHp7lAUa2OojOq8UU2F0tCy7kjpkCuloHoinMmSjecZt4CdjFQb6GavU9sowe5FOgq4OQXzy1q4fZ7oTc6REFbNqmfb5YweujRN8Xn2POuMc6A13X4TkA4CKnNoYP11J+/GtTcjllMiN0T/za1ItHYAK1uFHwv2Bt4qf6w4LTmHNljxLbQ4vokuYOhLuZqQ2EWcAurPjIBMiSD4m47tayesjE9Ohf4TTihtyLZ1wq1c/4XAkj7kTV9HimkjIjbUJLq38I/KU22Thsby+4r0P1A/qS4VgoQwjcQANI5GXJTjMMq4GVSIaqG1puZ6VbxQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 437ab0a9-68a3-417c-e95a-08deb177c65c
X-MS-Exchange-CrossTenant-AuthSource: DM3PR11MB8735.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2026 05:15:12.5286 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iBfFiPb+JavwLBX7nUaFzbMOdFQj0icVtdLcaLdS8veMRM+TIGiHDf5EnRFp1ghk8dO2n8PGgk38OUHve/sqNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6771
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.19;
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



On 5/14/2026 4:53 AM, Peter Xu wrote:
> On Mon, May 04, 2026 at 04:30:06PM +0400, Marc-André Lureau wrote:
>> Hi,
>>
>> This is an attempt to fix the incompatibility of virtio-mem with confidential
>> VMs. The solution implements what was discussed earlier with D. Hildenbrand:
>> https://patchwork.ozlabs.org/project/qemu-devel/patch/20250407074939.18657-5-chenyi.qiang@intel.com/#3502238
>>
>> The first patches are misc cleanups. Then some code refactoring to have split a
>> manager/source. And finally, the manager learns to deal with multiple sources.
>>
>> I haven't done thorough testing. I only launched a SEV guest with a virtio-mem
>> device. It would be nice to have more tests for those scenarios with
>> VFIO/virtio-mem/confvm.. In any case, review & testing needed!
>>
>> (help fix https://issues.redhat.com/browse/RHEL-131968)
> 
> Copy David for virtio-mem: David, please see if you're OK with virtio-mem
> side of things; if you have time look at everything it'll be even better.
> 
> Copy Chenyi: would you please check with your environment on whether you
> still hit issue with this series?

With this series along with the ongoing virtio-mem guest change[1], I can
launch the TD guest with a virtio-mem device and do the plug/unplug/replug operations
successfully.

[1] https://lore.kernel.org/lkml/20260401-coco-v1-1-b9c3072e2d9c@redhat.com/


