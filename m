Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E8F0C79F99
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2026 02:11:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3lIF-0006Kv-Jj; Mon, 07 Sep 2026 22:10:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chang.seok.bae@intel.com>)
 id 1x3lID-0006Kn-Kj
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 22:10:37 -0400
Received: from mgamail.intel.com ([192.198.163.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chang.seok.bae@intel.com>)
 id 1x3lIC-0002e9-0A
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 22:10:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788833436; x=1820369436;
 h=message-id:date:subject:to:references:from:in-reply-to:
 content-transfer-encoding:mime-version;
 bh=NEq2PCP4evMaMpm2iu0xOsIrv69E8OAKyoIeKWCKjDM=;
 b=RS1XNn/iW3pH0zwtoDF5c9ALnqhCk95fujrZ7lPTxGsJLM9rleLVUqjQ
 WwQNP7OyICpu53pQ8Q2zCfuLBZmn4VB5BcnoQFNqWGW19KqCVEvMTEdm1
 PpsS+VNp/ANnAb/JNmqYVxkhlFBZrG2DB+X5WRTzmWNPxDfxkE5mH9xmC
 obwQhENBJF0PpNELIBkqMwzxhNB0gR4LSBBopesjus4SJEDeQdR9nZovq
 KsBMxRRqXTt4y2UMbYk68uIyoGfX6Xxsmtq/BTH8+OQgSRIA+ChN56/Ue
 fvxcSjFiasA1hkuInaxVEIMUgoz0GR21zVp8S8UHu+9gjR9I8OhQzNCCn Q==;
X-CSE-ConnectionGUID: WW63STbXSC6l/RCgz7WQ7Q==
X-CSE-MsgGUID: 0kPYuBC2RnuYNsExrElNsw==
X-IronPort-AV: E=McAfee;i="6800,10657,11899"; a="88377496"
X-IronPort-AV: E=Sophos;i="6.25,268,1779174000"; d="scan'208";a="88377496"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Sep 2026 19:10:34 -0700
X-CSE-ConnectionGUID: wWOKot1oQs2pjoWcrfLjQA==
X-CSE-MsgGUID: guhJNKiZQ9ibJ16KOJwbWg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,268,1779174000"; d="scan'208";a="269531444"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Sep 2026 19:10:34 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 7 Sep 2026 19:10:33 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Mon, 7 Sep 2026 19:10:33 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.7) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 7 Sep 2026 19:10:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xyfLeiinVQWtjHoe3ywrEcDu2YV0vAJ9aLh43uPDmRv/igF8hte7UmJzQeeppARfB1tiATqQBK9Xh4YIP+yKgbj1UVyOKqKAmqfV+nG2L/Cn7PD+2pW+fNo7eeNEhy3zwa+0Kt7NsI5/9vdSYQz8Hy4TT2kkEq97f3IUyjGsYJ0EIH1+3SY88Px4eQGUDaqXL+4yjo0kZp4Nck+miwCmKORz/Ovt4zxjmkSvBM7t8cDN+DcNrxPnXe6qvxIwW1rzr3HXwsCUxbVTgBPrvbKA2NQb8C+gNG4fUzXhDnDrA80tVc5qztleVPPVbpoz7Pku5GIOnToW73oFU/f9X0AqQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8Ugt8dCaD+gmR/c+pwUqawjeXcdv5pZEw9CoLiP7tQs=;
 b=vqP+euYcsbDUtngQ+Ifgp7OM1A8EaFSocuR2PtrrOM1N79DheRjjGj+77Z0zaDVhIdxihpzd1PRQ5X8XqN0qocx88V81b1PhH9HEjIrNgin1Pl/vJuN1V15LPgiET4fEXCqmwZP/W+hmN/OUgTYGh+x+VTi6upKVUVXUAzTlnb27+RT6mwlmoGmz+/0tPdJ7yjkR9sXQdGXUZQMknlXg6gGnQOgwhPc5h+DJXo1T0pJzCGwWj/RbkLHxy+hEqS5WAUW3lSxcIitm4SUkG4S9YHd/59m3eWxbvGa9ujx00pX/3ZTfRWwUxlDIoxQTAsgYJTE07LOd5+pVMMwCuxe9Nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7925.namprd11.prod.outlook.com (2603:10b6:8:f8::18) by
 SN7PR11MB6678.namprd11.prod.outlook.com (2603:10b6:806:26a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Tue, 8 Sep
 2026 02:10:24 +0000
Received: from DS0PR11MB7925.namprd11.prod.outlook.com
 ([fe80::60af:89a0:65dc:9c84]) by DS0PR11MB7925.namprd11.prod.outlook.com
 ([fe80::60af:89a0:65dc:9c84%7]) with mapi id 15.21.0382.014; Tue, 8 Sep 2026
 02:10:23 +0000
Message-ID: <cd30077e-4e89-49c5-840c-61d52823de83@intel.com>
Date: Mon, 7 Sep 2026 19:10:22 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/20] target/i386/tcg: add definition for REX2 prefix
To: Paolo Bonzini <pbonzini@redhat.com>, <qemu-devel@nongnu.org>
References: <20260825122921.431739-1-pbonzini@redhat.com>
 <20260825122921.431739-8-pbonzini@redhat.com>
Content-Language: en-US
From: "Chang S. Bae" <chang.seok.bae@intel.com>
In-Reply-To: <20260825122921.431739-8-pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0193.namprd13.prod.outlook.com
 (2603:10b6:a03:2c3::18) To DS0PR11MB7925.namprd11.prod.outlook.com
 (2603:10b6:8:f8::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7925:EE_|SN7PR11MB6678:EE_
X-MS-Office365-Filtering-Correlation-Id: efcc78a5-c115-4458-6fc4-08df0d4e5776
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|1800799024|376014|10067099003|22082099003|18002099003|4143699003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: au5Uuh6MvFmeyMsvdrjMsaI7D2wl7tp2XzAGu9ITJ3p0zTKUDPUmZks62/HLlmIgfb9MDxDT2nbt9ikBzBpu6MLiw129M2eYqzSp6hV8tsO5n7FOOwLjkUGoLGfjhKEpVXz4sMboHQjeIZ8/myJW/0H0Rl7IDkyblA9oJFVQF9nB4Wyr3uYz2BirdgsThKeJVq7RLbo+RNFku6UOGqH2JrQI5fPZ2DHc1OEZwNwyMLmUjw3/xwPYvAaEWnhxylw/aGc0NXbmLaqHz64ClpqDjHoct2B0U6H7PiTwNFADr1CK9iK1G3IotSMjRlfH0aIhAqvieM6kS+9edz+HmzFgtO6R9IvfGO7kHPyDHES9G2rTo7b71xa5WYkuvvA9k+RO1rirkuamI0O9LA/SHgpySXFpbneVmFiLo69CFYcr+wv59W80GVLWjDpaxgaZNOmyybLlnjKOgKl0f/4kHfILN0xT7oj1SbGAXOI2Z52Rz7EjTdj0A3cAfERJYZQV8r30ZBaD4tNCpvwPqEBZcKOCQUiiFzzHWgb6dLB+5F61AckNpWI2q9rn90+I7kKiCXsSBTuQdLzAtnZxMY9iksUlSwyPAVsC7w0h4/En0PtGhhr0y6t2ydfMDskauJiTTUMvv05+CduLE5aj5w6GLcnrcNW6VWlYlsAQF0m089RlHiA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7925.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(10067099003)(22082099003)(18002099003)(4143699003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SzNyaUtleEdyRFdQNzFTbDc1VnpLbVdZRHBpdUEzT1AxMlhUVHJLQVAvSE5U?=
 =?utf-8?B?eUtOa0g1ZDhka1YxRWdjUnBrbFJyZjZqdVh6SG1wQnVCUmdQQ0pldmVxaHZ2?=
 =?utf-8?B?T0J6QVZvbm1rbVZTaUZpUERYcTFWTTVsU1hyT3ZWRldLeENiWWY4bFZPUlFr?=
 =?utf-8?B?VTlLaEQ5L0YwTEM4OEU1b1dKVENON25tVjQ2WmFDOGFqQXFMNFQwbW8rUUMw?=
 =?utf-8?B?b0lTeExLVTdnZThkYlRlajB5dU5XbUhPazJnR1piU2QvMEJYQ3BsZkJBVUpL?=
 =?utf-8?B?S3NKOUZINWJUUFJMcVdIK3hMR002UXFSSEJCcCtSbElXczZWQ2xSYklzSFpH?=
 =?utf-8?B?NE9lOEJKUEtHbWllaXRGSUN3TndxNjliVGtaT0tpN3RjalRPbHg2SU0zQkth?=
 =?utf-8?B?REE1SzFBaFg3MXJyZzdJSnVxemRqcjByWm1xZ2pTaTM5b1lrN1A2RGMrWTB1?=
 =?utf-8?B?eVNuMkVJelBPWit5Ky9ONHR4bjFaVmw5K28wZ2NzRnI5QkVTOVRWTTdwaEp5?=
 =?utf-8?B?U0pIZWZzRXM1WHdMQnlQM3NTTEpvK1Y5SHhzRDFLeHR1bHBFUEVWRE1icXg3?=
 =?utf-8?B?eXFzODl2OFVyOE1GSWlSOGdtQUxwUGFyQXN0aW1xWHNMTUdtWHE4bzVIRm5s?=
 =?utf-8?B?QnJ3eDFIVk1aNTNhUWVPNmExTnZhTVFlWkptaS9mOGJQT1k0SS9DWm9zaXlJ?=
 =?utf-8?B?dDUyNGRSZ2JIS3F6ZzJZdGt3UmgwcXFxUUtmeXk1QVM1RnhRWi9hSXFjTng0?=
 =?utf-8?B?TE9xdEJWanFEdTFNK1krK0J1NFdCZElFY0JpQlhoYzFzRC9XWUEvRG1FYmpM?=
 =?utf-8?B?Wk5DaTJUeUFMbVo5eHE5REVlNGh1V1M0RU1Oc0w4VmxXU1pwcEd1L3B5NEtZ?=
 =?utf-8?B?VGlyTy9JVzBpRjlBV0xqNDd6MlB1NWVnRXZFRW5FOEZxVjdlL0dmVW1pZk9r?=
 =?utf-8?B?UlJBb1Z1ZjRZV3F2djN5U0p4YWNUVFVpMkN4aDRzd0QwS2Zvb3MvRTJEQVNM?=
 =?utf-8?B?bGdUTmhqNzJkQW1ZOFh1dzh6MzlVNXRlb0puUS93cC8xaGJpRW13bmtLREJY?=
 =?utf-8?B?eTBYQ0FqaWpNenBNVU13RUp1T3VYZ3NUUWtDVFRCaHAyVGtDaG10QUxsWTNG?=
 =?utf-8?B?S2h6dTVzb0syZnZpWFNhc0NCcmgvQ2xiS3BHVVlqalRrZWVZUUxBSU9lalBB?=
 =?utf-8?B?L1NGakxZN2xBUTBVT29aRjNEOEdYSDBQUDJqQXgyWk15K0hBb2FLL0tSN29a?=
 =?utf-8?B?dnA5QXpjTUJYYTQ2ZHNiazhWK1dXMDlVanRKQUZ3Q0Q5K3dRSkI1cm5Dc1pV?=
 =?utf-8?B?TytCMmU5eG0wT1BKLytidlJmM2hzdFJFK0h5bEEybllSZEtXbU9xWVJlRE5t?=
 =?utf-8?B?bHpQWGc3dFZ5ZEsvMzR3eC9SNVpwdVBDVjJUdGsyVkJIcEFudFRlandzaDFV?=
 =?utf-8?B?bUVTV09SVytBL0lWb3FzaGREVlV3S09wMTNOS1B0ZDlmQUdlazJwYXR5TGM0?=
 =?utf-8?B?TzR0UzVBQVhSbFUwMXkwcW90aHFDc3k5TTIyV01BUXdnNTNydy82RUF6dm9C?=
 =?utf-8?B?MWVyUktsZU9hTENXWFNGUm9JY0k2Nzh1c1ZkVGMzMURoa01QVWFJTllwSnM2?=
 =?utf-8?B?YStES0diTjhWeE5BNzFnQldWd1JuVW9BZUFGVHZCQ1F0dXdDLzdEcEduZXBx?=
 =?utf-8?B?MzBHRnVEUi9LSmI4dHNWdnQ4SFdQNjR3SEJRVWN0VVVRSStwTXFqWnN1VHNz?=
 =?utf-8?B?bmdRdTBWS2Y1YlYvM1loM3V4aVp2MWdjdHM0cjFCUVljRnptdnlpT3puMlFl?=
 =?utf-8?B?WmhjUTRwRTBWRW5uYmdqdkMwemMzRnlOcms4Rys2eC9ReGMxRUhsdmpzM2l3?=
 =?utf-8?B?MjhGakx6eGREalhlQlVFRTZYL3NBYm14cW5VMi9HWDJwVk9FaDRNbHYwUzJz?=
 =?utf-8?B?TmNLNHRXMUhycnlCVnFkVTlWZVZyUkQ0ODhqRnVYRXZEelh5T05JK05YOGtM?=
 =?utf-8?B?MHYyY3ZDSCs4aVIrTHVsUVUzc3B6UEV1SjFmR25jOHZROE93d2ZZZGluYnJH?=
 =?utf-8?B?N0QvOXJsSEFQVTQzUVZhUy92VFVUdDJtWjE1YThvTUJsY1NWV2NBdklGVDA5?=
 =?utf-8?B?dm9XZmpZRWtwTnBKUmhaVDVkVTJsSitWSS9YRzY3WjFseVhHUGR3amEvdEdw?=
 =?utf-8?B?bUNFdVhsbGFMTWR3QkxXSEpGOGtiS3F2T1lwTnVjbzByTERPSWdENlRRcmpS?=
 =?utf-8?B?blVmLzhuaDR6N2tnSUNZaEJ2K0ZEc3A4bkczZXNBUXFMdTRKck9kZFZLd1ps?=
 =?utf-8?B?aitUV2Iwb0Ird3lGUWJGZHBscGVnbW9GOS9DNVl0SGJxc0ZZTW5xQT09?=
X-Exchange-RoutingPolicyChecked: p4AY/783blpZQ8dKE+zLHA4xdUO/MmWZm3yz/f7kMSLQ60BT3DlEbrJmhX3SOPyp/lHLH8icNek0YlE4uE6G1sYVdd/brxsDsC1a7zSBPmpJTZeV/DibdhMbEM9c+RqpwoNrN9PbDDWCFcoXrKG8KNV6BhsGW2rMQKD4JVB8cZfTZLnzm35OeCAR/2zUpqVnThBhRCzDYNdksp4zRV1CQ/TJbEGVkNQAJ/W7cQoG+jVWLC92QFmB4ORJILH9XVuINaES89vTSpxBGKeJGiGrT3vhFIhUG0imtU8xWwiRwzalMWEzCjjv560r36wK666qO3J3sGjFI75MVRIxLSkINw==
X-MS-Exchange-CrossTenant-Network-Message-Id: efcc78a5-c115-4458-6fc4-08df0d4e5776
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7925.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2026 02:10:23.9114 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +dyJRk21mHao6XzD1QVQNKzd5OScDRUC3tWnYmUOnqoqUag7Jrc0ejUyhFHBOE7RQz/XzlasH5lTtVb8MowhS+w/im+PFlGub4XqErCefgQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6678
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.18;
 envelope-from=chang.seok.bae@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On 8/25/2026 5:29 AM, Paolo Bonzini wrote:
>   
>   #ifdef TARGET_X86_64
> -#define REX_PREFIX(S)  (((S)->prefix & (PREFIX_REX | PREFIX_VEX)) != 0)
> +#define REX_PREFIX(S)  (((S)->prefix & (PREFIX_REX | PREFIX_REX2 | PREFIX_VEX)) != 0)
>   #define REX_W(S)       ((S)->vex_w)
>   #define REX_R(S)       ((S)->rex_r + 0)
>   #define REX_X(S)       ((S)->rex_x + 0)

Nit:
REX_PREFIX() being true looks to matter for bye_reg_is_xH(). Just 
wondered this macro naming. Perhaps, could be REX_FAMILY_PREFIX() or 
something due to the addition of other prefix kinds.

