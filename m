Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C936CCD187
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Oct 2025 12:45:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v7vRI-0007NS-Vu; Sun, 12 Oct 2025 08:44:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1v7vRG-0007NI-Vi
 for qemu-devel@nongnu.org; Sun, 12 Oct 2025 08:44:39 -0400
Received: from mgamail.intel.com ([198.175.65.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1v7vRC-0004R6-Ou
 for qemu-devel@nongnu.org; Sun, 12 Oct 2025 08:44:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1760273074; x=1791809074;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=lVGwrPSLyRckbpUnljtd083xDwmzKayIIIpZdD7G35Q=;
 b=T61Ew4gopQ5nH5YGnBlv/BYKfQXhprzCEF1sI09hQzbDfHJjoLuRx2CN
 J2uTPv+TJMhlEAmK+w4iLjdbPPmrzB2bh4o/hd7kHoaV2LrBvNuQLwyV5
 +5uQhGNcoWAzYkYkfz6byF9RHdWQ6EPLlQKp3NSppTLVIYzJMGWbLTb2w
 8cbbX3y05Qw1hhV45qSSPAExK2dP/r7uz1lVKr0EE33mHtaZRuTvjgtwj
 acV6HByOE+hXRlgtBr7wr6TFOtvfvjPxZMfuf3T+Us8cFEVK7CiM0fStZ
 LaKhxAfGLc7Ffy2HOEB/yTsn1wVEbxrMXyIWu/g4MdJOv01bN0aoClwmD g==;
X-CSE-ConnectionGUID: 6EZriovWQy2JL4LPv4gqUg==
X-CSE-MsgGUID: 3g2ZL7cPQlKe5sWiP+0k8g==
X-IronPort-AV: E=McAfee;i="6800,10657,11580"; a="73870378"
X-IronPort-AV: E=Sophos;i="6.19,223,1754982000"; d="scan'208";a="73870378"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Oct 2025 05:44:29 -0700
X-CSE-ConnectionGUID: GK2QWeicQtmJI6aUsrYM4A==
X-CSE-MsgGUID: 9zEUP1HOSrawSOx1s55tdA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,223,1754982000"; d="scan'208";a="180614964"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Oct 2025 05:44:29 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Sun, 12 Oct 2025 05:44:28 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Sun, 12 Oct 2025 05:44:28 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.52) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Sun, 12 Oct 2025 05:44:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aImdeS8jgRU1DFgdGDk+vmEV+qHPgu+gVFjkYQX1nh9mDlHvXzT4LrlWJYeVZ9iGvRDHHehslW3cm2hOUhIv/Kg0NChnwrKbhN9WAupINwoxqYIxRtlgVYZJgyfvQkpjTpL3zG+P72qVOXhwzbHSZZlkYQbRPXNWnE3WHJ8g9c16oOUKLcA63obdsE9Tg7MjvqOgzsUFaxosS83RxR1/O9PNJtFT1wJjeX1c/4TUahq/vspFU+rg1BWnFmoLl2WLYa6gVa1n+tD8lkyUggd14r5N7J6opIE04CCllYLLBSCpXeczd2d+n4lrggLsrfTPh7yXtZjMZIppFGfzjqZ7pA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F81NOy+EZMGRUNYxZv2Kgm/rrkzpPxHg5lcOIn4Ysps=;
 b=AXjY05qDx48Z/nzgZe1rE7RpUdxT+MZ39myZcoUIhIg7SYf0/nMdgxifdgu4h2i3UAOtgSIDiqzxIrgXXJ3j9wZCTGdfo88aY5ixZpn/6L9p+hkWDOBo0W+K708XNdnUgqCEhi7Ac+n1GoTByaHN+NuE/86X1E4K0MeLFINUAq+/EcJLPdEnQrs62y2JnwU3FYz011Lo+GPVtbeKSdYc8Zrhf6TDT66DHzpsL0L96ztZ91pI92PTctKbuSUlBS6CHtC5RJmjrEVMdm4wHCLb2U/NBI8ZRN45jJZ3VwPOGpm6eoIEVOdrmaUGUGvW+YvoqRqsfYHbE+bEbqrko5FKbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ0PR11MB4798.namprd11.prod.outlook.com (2603:10b6:a03:2d5::12)
 by SA1PR11MB8839.namprd11.prod.outlook.com (2603:10b6:806:467::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.11; Sun, 12 Oct
 2025 12:44:26 +0000
Received: from SJ0PR11MB4798.namprd11.prod.outlook.com
 ([fe80::d946:6abf:6e7e:fd1e]) by SJ0PR11MB4798.namprd11.prod.outlook.com
 ([fe80::d946:6abf:6e7e:fd1e%7]) with mapi id 15.20.9203.009; Sun, 12 Oct 2025
 12:44:24 +0000
Message-ID: <b533eaf9-bbee-4bec-91ff-23482151a983@intel.com>
Date: Sun, 12 Oct 2025 20:51:10 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 09/22] intel_iommu: Stick to system MR for IOMMUFD
 backed host device when x-fls=on
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, <qemu-devel@nongnu.org>
CC: <alex.williamson@redhat.com>, <clg@redhat.com>, <eric.auger@redhat.com>,
 <mst@redhat.com>, <jasowang@redhat.com>, <peterx@redhat.com>,
 <ddutile@redhat.com>, <jgg@nvidia.com>, <nicolinc@nvidia.com>,
 <skolothumtho@nvidia.com>, <joao.m.martins@oracle.com>,
 <clement.mathieu--drif@eviden.com>, <kevin.tian@intel.com>,
 <chao.p.peng@intel.com>
References: <20250918085803.796942-1-zhenzhong.duan@intel.com>
 <20250918085803.796942-10-zhenzhong.duan@intel.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <20250918085803.796942-10-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: KL1PR02CA0017.apcprd02.prod.outlook.com
 (2603:1096:820:c::22) To SJ0PR11MB4798.namprd11.prod.outlook.com
 (2603:10b6:a03:2d5::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR11MB4798:EE_|SA1PR11MB8839:EE_
X-MS-Office365-Filtering-Correlation-Id: f51f7827-8899-4f94-7a8f-08de098d12e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7416014|42112799006; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?S0VTVG45VXJ5R3J2ZStGUm9DQmo2OU0wN1VDV1RZUkFmTnM3MWdkV3Nwd0tp?=
 =?utf-8?B?ZUtCMm9HcW9PMTdsbGpXVGcwNkFWaUF4ODNIOFdCU3Z2YU9qK1JQQVN6TTNE?=
 =?utf-8?B?MGIyd0NsTHlnVVk1dTQ0NTR6alByZjIxNmdlbTRUUVZ1Y1owbW1maVRNRm01?=
 =?utf-8?B?dDNqRmkvWjR2Ykd2eURpSENLdDlZM2lXSnlDb1lOQStveGNkNzR3NHJuejJF?=
 =?utf-8?B?NDdyb3YweDR0YXNlZFFVdGpUUTZXY2ZYZjFvQmFiZ0VWVkFtM1VZMFVGOWVS?=
 =?utf-8?B?TVVrN0xJMEU4ZVR5OVFQNzhWK1BMLzlTNlB2NGVxTSthU0MrcWRldXZvYVhN?=
 =?utf-8?B?OUZwRHFaL2xEaktSdjRwc1dOUUVRRlFTcEZWbTNMeWJxOHJndUJ5WlBCSmFu?=
 =?utf-8?B?M1I2UC9ETGtncmFROFArMzVlVTNEVnVFT2VlOFJWWUQzMExxMG53UHdnN24y?=
 =?utf-8?B?eVlVeTdPbDZDSmpaUDlCZFIrNjdXQlJ4M1UxUjdFS3hUeDN4L3hFVUxlUEVQ?=
 =?utf-8?B?REl1eUdJdG9nR0ZOQjMvVXk0bWQyMnUzUVZTeWdjQUJLSDhpN3dyUG04Zk1H?=
 =?utf-8?B?L2VCdkNxOWRMbjRtemgycmRkNDQwY2NWZGlyaGphbGVyM1lCWUZSTEVLRml6?=
 =?utf-8?B?WEtoQ2FvVDRXeHlYMTJYbmRHdTdUMGZMWWdSOHBzN04ycXYxL3ZDR25nbVZM?=
 =?utf-8?B?bmlxMUppR3grQjFWK2gxNVdCL3d0dmcrai94TTJlOStCSS80N3NzeVQ2NGhk?=
 =?utf-8?B?UXNKb1BMbFZUTVFKNkNXNThRUGRGcWxkaUt3MUl3Q3pKdzRYdFhoMHcyUG1r?=
 =?utf-8?B?aURqcUpOSEp5Ri9JZFdEMGhyQ1l3UkdTbWN4UmtHZWV5QU0vZmVVZ2kwWnV3?=
 =?utf-8?B?Rk1SUEJRaGV6cHIyOWw1SXJCd0F5NjZzSjBwTmdiRFlrankwSzd5ME5WanBU?=
 =?utf-8?B?K3FvYzduNFFkRk1qdEdVTjQvME9MQ003VnVyRWxIYXVEMmxYSGlsUEZRY0t2?=
 =?utf-8?B?NmNXY1BmaXJLYnRpQ2E4dWszUXo5YjhuVzkxUkU5Zjh0UkV6NFdPOGRDZlh5?=
 =?utf-8?B?ZHJSVlNKUkxxU3ZGWW44UkJsUVFRVWlrZmVhemR1ZmV0U2FrclFDenIrenpk?=
 =?utf-8?B?RkdUd1FNT0dxdHdqNzc0N2FuY0pPdVR1OFN3NVg1NHl5alRGN09HeEc4dnJL?=
 =?utf-8?B?ODNBbi8vMitGYmRQazlYWnYwbnJqNE5qcVRRSlFic2xSSGJzS2Rna2lLYWVM?=
 =?utf-8?B?eHM2KzFBZkxOanlrNUFaUE5LYzNmeTF4enpPcDBpWFRzZGFlY3BNcm1Ralpn?=
 =?utf-8?B?VmN1dkNRRG5GSUVYejgzRFRDSTVKRG93U2UwaDlCeUs1WlcyZi91VG9ScVUr?=
 =?utf-8?B?Z3VCWDFENytnYlRRN0d1SFdOVjF6RU83R1NkYWprVERVL1p3WDRVMmRhQWho?=
 =?utf-8?B?cnZXb210RFF2NU85L3BhN2RObEdUVmRzU1RpVzQ2OGlSUVhXK1NKZDhVbnJU?=
 =?utf-8?B?bHhUUVFQS0NUWmRIUk82NFg5MjhLRURZY1BCcGxSRDBNSTY0UkFIZ1VxeThj?=
 =?utf-8?B?TSt5YzJuOExVYUREZGxrZ05UcEI0NVpFT1gzMTNRaXFjVmFzTmVEcG42c2lj?=
 =?utf-8?B?enM0K2M5dlBYMkl5SUY5WGVNcXFPTXdGWXZCZlRKbjcwRmxoUTIxVEVhTWhy?=
 =?utf-8?B?aEw2MXVwYmtzVWcvcmNKa1lsRzFWNkNpRTBxU3M2NXNUSHVUeElZcjcrK09V?=
 =?utf-8?B?SUcrT2tLTmJmUXBEKzVodXhNU2FSQ20vVFVLb3FuNmZFV05sVURJYjh6NGpL?=
 =?utf-8?B?eWxhb1AvL2E5NGg0clhtZk15S2pGOHN4UDFNUjBEUjQ2K1lQaXorRXF6RnBy?=
 =?utf-8?B?RzNMMlRzbFhpZC9JT2tpQUtRRXdIcHlFQWYvTWM3RHZKaVkxNlhoYTdGc0gw?=
 =?utf-8?Q?qAUbMq+UbkPLqEIpWMCF5FH9OKujjh2x?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB4798.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014)(42112799006); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cnVtd3AveDlUTjZUQVVJNWNNSnZPMVlXK1lrQ0FtT0JxOWw0ODBCUWd0VUhz?=
 =?utf-8?B?Y21va0JIMit5cnlFQStFYzlwcVd1U3hZNDAwWEpwNlpEaWIzZ29OSGpVQnF1?=
 =?utf-8?B?aEJuenRoYitYcitqczgzWmhJM2hwUVgxbURZZ0hrSy9ZNnNSTG5nMW9VdVht?=
 =?utf-8?B?NWpJbjBPa2tUcDZFK1NRM29mWXcvbXM3Zi96WndHaEZQZDVKNXdXRzZXU2hP?=
 =?utf-8?B?Ulc1V3hpWU9MUU5kbGJSeExrZ0NTbktKSlVIUzUveHBWN2tCeDBmMDNaTXh4?=
 =?utf-8?B?b3lzTS8vMW4vVFFYTHUrV3JSMlVTallsUnhnZDV6UklkOTNqeWQ2U1NTeDZB?=
 =?utf-8?B?Rmh6ZUQvU0RwRFNuenA1bnQzY2xwN0l4UVhrYVFFOW81Sy9lekkwbTVMdG9h?=
 =?utf-8?B?NXNzd01sRkNYMzBpVFNOYnJvcW9vc2tXRUhqTEk1aC9RYVRQZ2ZSUVNDRDRl?=
 =?utf-8?B?YitueUtHVHJYNGozMysySjdCWTZwZUhGVWI3eHkyd0JwblIrRVE4YUxWS00w?=
 =?utf-8?B?SGRnbUxOQmtPeURpZEJPNERZeWNpTFhOZllFOUR0WVpLNmdaTUw4MURBYlg5?=
 =?utf-8?B?em1YZVZIVTFCTGthNkZZQ0V1MkpoaG55QkdicS92d1R5dSs0TVY3eVZWRGNQ?=
 =?utf-8?B?a1FLb2ZyZDNDMjJXRVdaZ1EwWTdLQVM5VWh4cW92S29wVGhQallsdEFscnNv?=
 =?utf-8?B?bUxSZkZOY2M1Z2dBM2YvTzIrNlBXYm5IRHQzQXlKV1lTaGk1STZnNml6S0FW?=
 =?utf-8?B?c3FLRFFMQXUwRTRBU3pSY2RhaE9JOTJveEZyVysvUS9xd3VWSFdITVloQkNL?=
 =?utf-8?B?SEhuUFZPQWV5dmIzRXBnUTB5YVkzOVh5MEV6WXp2VVBycUx6UWppVVFNU1pH?=
 =?utf-8?B?azV0d1d5MkVER3oyZUVyVnpXc3FTMllXczdEOE5yL1JJUCtFNS94OXZhTC84?=
 =?utf-8?B?MTI3Sm9YWGk3TUFUSFQvVG9rQWpSWnNrNTAwRFByNmFLYWdrWDR1ZWlXb1pB?=
 =?utf-8?B?aWlUbDlIT3hHV3F4aG5jVmhsYVBVL2tiU0FiL1dvcUZ6R1BaTFowTXJkR3RW?=
 =?utf-8?B?enRMODEzVmRPQkQ4anpDNGdpTWVDd1kweVUrTUtyWnpXdyszUXlESHpib1Z3?=
 =?utf-8?B?N1hLSVhmd211eXdPRm01V2xRTHVVZURUK203dW45VGFWdXZQUm1Uak11dWQ1?=
 =?utf-8?B?alNJalFpZUEweE5wLzFScUZvOXl6YkxSVzU2dlVkdXpuS0hJcFViOGNjc0VD?=
 =?utf-8?B?R0RNa2lWNzBkRG9xWDZib2xpb210dmVORUs4UE01RU1qUEtycnV4WlpDVHRV?=
 =?utf-8?B?Rm9mcDlBQnEydnFFNlBTK21rMUtZUkFyNlhXWVZjU1hxOXFUTVI3VXlBRVFZ?=
 =?utf-8?B?OFRwVzlPdFEvc09XQVE0QlFOSFhqQnJ5VTBoZGRpV0JRR1p6RmRYRk90TGla?=
 =?utf-8?B?bkt2RUVKMVhpS094VjczM2pqSTl6cU1oT2ZZTHYxM3BxTTB6NGJsUSs0OHFU?=
 =?utf-8?B?aWVwRXorOC9hOEhaeGNuK1JjaHdqZWd2KzdGMmxMNjBoQXEzSHhrQ3pucDFw?=
 =?utf-8?B?TnN3K1RmWnEwU2s4aGF2VGlDUkVGR1E4d0ROUEZTcG5nb0JnMElRL3hlYzlH?=
 =?utf-8?B?NFFQNWtUZnVxcUl5d01XSmhTQnppOHNzNThtOHVya01YMFRQMXMrQU5JNUpN?=
 =?utf-8?B?Q096Tmp5RUkybzdWMC94YWFjY3J2WDBSN1dHdlpmQ0RpaWJ2YTd5dkhscGg5?=
 =?utf-8?B?TlFvSSsvK1d0d25helZ5ajJHOHRqMjVtcXlGT09weDBzU2QzTFQrOGQ5MkZm?=
 =?utf-8?B?MHJYNU14WkNZckJmMGFpWG5UdVlCb3lSM09iNjhkeklFWVlwL2U1aFRiVkdY?=
 =?utf-8?B?cFN6Y3hocWFnaFFuaGh5UjE0eWtOS2ovT3R5TEpiUytlOGgzbHJhcWRQbkFo?=
 =?utf-8?B?cGhaN2E2TFlLSlZ6M0dpY0U0YlhJcExJN3QxOWdoendYa1RyMitkZVlVN1Uy?=
 =?utf-8?B?eWNXMXd1cUNVWG5Ic3RsSXN5eGovT0F6dG1lM2o0TWo4b3lZSFp5UytvK1E1?=
 =?utf-8?B?UVR0VTNDQVQxVitDa3pGTjBZOHd5Z08rNFdtZDhlYk5nejZSNjdvdnlRMDVr?=
 =?utf-8?Q?akI3fDVJM4+9KYnm1Tj+pWFVx?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f51f7827-8899-4f94-7a8f-08de098d12e9
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB4798.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2025 12:44:24.8733 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jje2FT9/GixCoa8Ul0eQ6MiJqn3Nj/sNIfq26rETrpaWJCMeS5PrgIuWov/BYFyRk/He4YoGTouUq4oxepvuVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8839
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
> When guest enables scalable mode and setup first stage page table, we don't
> want to use IOMMU MR but rather continue using the system MR for IOMMUFD
> backed host device.
> 
> Then default HWPT in VFIO contains GPA->HPA mappings which could be reused
> as nesting parent HWPT to construct nested HWPT in vIOMMU.
> 
> Suggested-by: Yi Liu <yi.l.liu@intel.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> ---
>   hw/i386/intel_iommu.c | 37 +++++++++++++++++++++++++++++++++++--
>   1 file changed, 35 insertions(+), 2 deletions(-)

Reviewed-by: Yi Liu <yi.l.liu@intel.com>

> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> index ba40649c85..bd80de1670 100644
> --- a/hw/i386/intel_iommu.c
> +++ b/hw/i386/intel_iommu.c
> @@ -40,6 +40,7 @@
>   #include "kvm/kvm_i386.h"
>   #include "migration/vmstate.h"
>   #include "trace.h"
> +#include "system/iommufd.h"
>   
>   /* context entry operations */
>   #define RID_PASID    0
> @@ -1702,6 +1703,24 @@ static bool vtd_dev_pt_enabled(IntelIOMMUState *s, VTDContextEntry *ce,
>   
>   }
>   
> +static VTDHostIOMMUDevice *vtd_find_hiod_iommufd(VTDAddressSpace *as)
> +{
> +    IntelIOMMUState *s = as->iommu_state;
> +    struct vtd_as_key key = {
> +        .bus = as->bus,
> +        .devfn = as->devfn,
> +    };
> +    VTDHostIOMMUDevice *vtd_hiod = g_hash_table_lookup(s->vtd_host_iommu_dev,
> +                                                       &key);
> +
> +    if (vtd_hiod && vtd_hiod->hiod &&
> +        object_dynamic_cast(OBJECT(vtd_hiod->hiod),
> +                            TYPE_HOST_IOMMU_DEVICE_IOMMUFD)) {
> +        return vtd_hiod;
> +    }
> +    return NULL;
> +}
> +
>   static bool vtd_as_pt_enabled(VTDAddressSpace *as)
>   {
>       IntelIOMMUState *s;
> @@ -1710,6 +1729,7 @@ static bool vtd_as_pt_enabled(VTDAddressSpace *as)
>       assert(as);
>   
>       s = as->iommu_state;
> +
>       if (vtd_dev_to_context_entry(s, pci_bus_num(as->bus), as->devfn,
>                                    &ce)) {
>           /*
> @@ -1727,12 +1747,25 @@ static bool vtd_as_pt_enabled(VTDAddressSpace *as)
>   /* Return whether the device is using IOMMU translation. */
>   static bool vtd_switch_address_space(VTDAddressSpace *as)
>   {
> +    IntelIOMMUState *s;
>       bool use_iommu, pt;
>   
>       assert(as);
>   
> -    use_iommu = as->iommu_state->dmar_enabled && !vtd_as_pt_enabled(as);
> -    pt = as->iommu_state->dmar_enabled && vtd_as_pt_enabled(as);
> +    s = as->iommu_state;
> +    use_iommu = s->dmar_enabled && !vtd_as_pt_enabled(as);
> +    pt = s->dmar_enabled && vtd_as_pt_enabled(as);
> +
> +    /*
> +     * When guest enables scalable mode and setup first stage page table,
> +     * we stick to system MR for IOMMUFD backed host device. Then its
> +     * default hwpt contains GPA->HPA mappings which is used directly
> +     * if PGTT=PT and used as nesting parent if PGTT=FST. Otherwise
> +     * fallback to original processing.
> +     */
> +    if (s->root_scalable && s->fsts && vtd_find_hiod_iommufd(as)) {
> +        use_iommu = false;
> +    }
>   
>       trace_vtd_switch_address_space(pci_bus_num(as->bus),
>                                      VTD_PCI_SLOT(as->devfn),

