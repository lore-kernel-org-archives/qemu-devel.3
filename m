Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3B74C3271E
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jul 2024 07:04:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sQiPx-0001X1-SB; Mon, 08 Jul 2024 03:04:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1sQiPw-0001RN-4w
 for qemu-devel@nongnu.org; Mon, 08 Jul 2024 03:04:08 -0400
Received: from mgamail.intel.com ([198.175.65.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1sQiPu-0003dM-8z
 for qemu-devel@nongnu.org; Mon, 08 Jul 2024 03:04:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1720422247; x=1751958247;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=UBht7lciKv5LC+62/rgN3LG89Di8h8jc2p1zeVri/8U=;
 b=SndtBgG79SkWFKWx1GtrZ/FJMxwxelWP/3Y958pCg+6raQUIl1oR/gS/
 /IOG1oKi6OIb0EZG1jbzW+xKCv9bp1+On06XOmvbav+XUvWmdsvYv1bez
 oRWXyeGI8kSRy8Rc2gsZAbOQuFc6MaQCK5sDtWT5Z5DCgEIwh3xGHVw3m
 P9ny4/Mk61W0De7GYlamEp8aLoiiJUcZvk5VmzsPMfJ/T2S/6bJA+jj2G
 /IndfjNzG1DLFUT90n74jjV9vjtRO9fuk0ZuOVASU+CUpQ6504QWLN3aZ
 j1Q4xEktM93X66GdvnTrWVsb42OqR593GLF6VY21TAuT+OBDOoVrtdrqn Q==;
X-CSE-ConnectionGUID: UEVlXK00S9K1fIucJFfcPA==
X-CSE-MsgGUID: HweiNZlsQcO6vkJHDPNXfA==
X-IronPort-AV: E=McAfee;i="6700,10204,11126"; a="17563710"
X-IronPort-AV: E=Sophos;i="6.09,191,1716274800"; d="scan'208";a="17563710"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Jul 2024 00:03:55 -0700
X-CSE-ConnectionGUID: Sna5P3VlQ2Wtto9YjNoP3g==
X-CSE-MsgGUID: QWGc4/tzStGMKMuz4x7Kng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,191,1716274800"; d="scan'208";a="47343731"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
 by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 08 Jul 2024 00:03:55 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 8 Jul 2024 00:03:53 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 8 Jul 2024 00:03:53 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.173)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 8 Jul 2024 00:03:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CcbdM/l2T3sXGPRdAznSIaB4bwfEQN0bgQQwPM8rZkD5wsDb3AXosnhBBBqrEfEqgrnu7YavW+Q3dXFYZfZGy3gwRcHoDknUhfO5kRLd5nYRRscDbnIVGJFR51Msk5zjmhAS/G5nG1Tq+vaHG2sBGCWQW3CAEs8hLWzXt+VM+HiIe7a+eSUXVJ7xHkuzMWY0LQOFbSffjZyn6icEwCVw88KlVNxY+DXCnhq3PhpLImt7MPacRQD85XRhioPTNj7IzR4M1kbysbtqj06WrP+4SsjxobTWCEgf9ir/pw/b49poK88+lF3frznK2MCAFcVsn3G36YagBhs7qep8en3IBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FDm1Gv2Ts3Ge6g03ub0XkwSjDj9p38z263BjSMJlJeg=;
 b=GK3+xoqtrHZnr8s7+jUw4ysy6ufII6qyt9M5XVktQ7jhHPIy8KoPVIX/0Z9LSkQ2CpYbT7Un822BlBAukU6UyL8TFXiEG5JIwZ/2EqjDatdMJ+jfAUnBBfj/dtRk0AOlUNhIHRFAcO1wNKev6DWeW4DLNGJToK6VqmjT6g/6/qP1eVezQsJGh2dWV34a24RnUoOyPV/A31xwlBPznkNWbTvwXCHsT2PK6yZTFRWSJknDmRqT2Ps8y3bFgOh4Z9Y1ZLwNgR+kNtLAayJf0+a3252sYJJZQC8Pdg/RD09mCKCNYmI6g1McivvkFKkxhHdEQDrHvoIEzVMno0mTG6IFvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by SJ1PR11MB6180.namprd11.prod.outlook.com (2603:10b6:a03:459::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Mon, 8 Jul
 2024 07:03:50 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a%3]) with mapi id 15.20.7741.033; Mon, 8 Jul 2024
 07:03:49 +0000
Message-ID: <c8bd5b18-9e49-44f1-a1d3-05bd02a91bc5@intel.com>
Date: Mon, 8 Jul 2024 15:07:44 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/4] intel_iommu: fix FRCD construction macro
To: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "jasowang@redhat.com" <jasowang@redhat.com>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>, "peterx@redhat.com"
 <peterx@redhat.com>, "mst@redhat.com" <mst@redhat.com>
References: <20240705105937.1630829-1-clement.mathieu--drif@eviden.com>
 <20240705105937.1630829-2-clement.mathieu--drif@eviden.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <20240705105937.1630829-2-clement.mathieu--drif@eviden.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR06CA0238.apcprd06.prod.outlook.com
 (2603:1096:4:ac::22) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|SJ1PR11MB6180:EE_
X-MS-Office365-Filtering-Correlation-Id: 4860f35f-7e8a-4acb-374c-08dc9f1c1dd9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aEdqcEdQRkdpVWlPYzF5VXhjeDVuOGF6MXI3MXJCRWRQRmp1WWdyNFczK0hh?=
 =?utf-8?B?d3h3QWpZL3pxcUhSVEIyR0ZqL09TeTRNQkJsUGgvU1NRYmxPVjFSNnROQzBO?=
 =?utf-8?B?WkdKbGxvNlFWT0RJaU9ieVRJY28wd2hyMUQ0SSt1RVZlbllzb3B2NDg5d01Q?=
 =?utf-8?B?OE0xcWFTNTVwNnZ6SklFeW40eDBNM2x6ZXdFaEdqSGl2M3FTbTZKR3VoNTVQ?=
 =?utf-8?B?UkRoRkdmY013dWNGVUx3Z0Z2d2lMRDhzdWc4Z2lnaHJwbGdNN3NlMlZWbGI4?=
 =?utf-8?B?TnF4YVNscVJ2OTFWMDF6MHZkZ05uS2pPcldFa2x5VDdPL2R5cWpJdmVZVzRU?=
 =?utf-8?B?ZlBMalFFaWt3dExsKzNuTnBXK1g4cUxwWFhaRmJ3aEg5c3A0ZVA3V2VlKzBE?=
 =?utf-8?B?OWtWNE0vdDIzMGQwOWQvQXkrelFOVnNSRXNXWGxyTnlBQWluN0dBU1ZPNVAw?=
 =?utf-8?B?OEh2a1JISUVYdVpmcnQrcEVEY2xsSzNSb04rT1Y1Ui82YWcrdEtRZzQ5c2Ez?=
 =?utf-8?B?ZTF5WWVRV3VSWVFMY2tkbEN1MEh3Ky9vMWY4RXc3NWYvaWlLbk1DWlZLQlg4?=
 =?utf-8?B?K0ZjMnQzOWZRcWZMWU9uQTZIcnJtV1krRFB0Nm1yMkJWaXlkMlAxZWJnUW9M?=
 =?utf-8?B?NjkxVSt4alAvZ2prK2RLSmd1eGEvUnBQTUJHSTYzRXF2cnpQYmRkZzRpRTlN?=
 =?utf-8?B?VDJYdm5CQWxIRGJ4U0VDVHVGSEpCTnpoQ1F1TC81alBOQ2dHdy9tWUNuUUl0?=
 =?utf-8?B?bng1VzBBYWE1b1lSV2JvUlYxUXBiWkRvOTNDMDV5YTJlbWFpanJCQnM4NUVq?=
 =?utf-8?B?Y29Gclhsc3ZRYU9uY0k1MWlZS1h5UnBvcjhzZWpnRm51YU5USmdaUzlTQWJh?=
 =?utf-8?B?MFRGdmIyWGdBcEFyUlMySmwzdGlkVys3ejhhaStaUXZiUEt1WWRUWWpQMXU2?=
 =?utf-8?B?TVErRktjcEd2bmNqZy9QVkNyazJLbjBMOXBId2xObWd3WkxZUzNkT01OZmxq?=
 =?utf-8?B?V0lXbVp5NkNYcStZRnB5THNMUkw1bU51SlltazBEc3VZK2oyZ0VrS0lPNWJl?=
 =?utf-8?B?NHMwUE4xTUE0T29DSTg5N0ZjbE1WakRyS09jT0h2T0cxVnkrbnpQemE2SFhU?=
 =?utf-8?B?ekNhL21QMlgrcHVhcFgxNGZTWkpaQzlENFJXbkVwOHNYVTRpVk5raTluV25X?=
 =?utf-8?B?Nnc5TWU0RUZ1MEMwcVJhQWt3Qzgwd3piSzJ6NU5vRmZyelRhbGZqd1NwZExw?=
 =?utf-8?B?M0poUGo2YytlVDRHUzIvREZVRnRvQ0tOZXZSY01kWDloOFNLNmhzanplbXVB?=
 =?utf-8?B?ZkpIcWNaNFY1eHRSQ1kvdi9KODN1T3ZLSFBnVk5WVWtvZFhMT20rQS9laUox?=
 =?utf-8?B?cjNrQzRHdi9PRnR3SmVZWjBlRlZYQTJPTVB6TkdlUkdSMzF4YVAzWXpBejB1?=
 =?utf-8?B?dFFITTlqc0xHY2FRMWlWYkpIM0x3TWVteWhxRTFwaHJDcUNXYWh5M0tadWQ5?=
 =?utf-8?B?YVhFOG1zNWRNZEZkbGpQcGd2U1AvU012aEFQd2hxUHlkb2ZaOXh2enBKS3lz?=
 =?utf-8?B?ZWtjL2tZR09KU3E5ZlhsUk5xR3h6cW0vWk1lZ3F1Sk9HRnQvQnU2UEJlcElq?=
 =?utf-8?B?RHREL1NOcFRWVmsyVzR1WkV1NDkvR0VzMFZKVWhSMWRWVVlvbm1ZL3JDZnVW?=
 =?utf-8?B?bXQzckZwQzREZC9FbWM5bFRISU92RTdKUDhsWFovTG11K0Y4Q1R4VXh1bTJT?=
 =?utf-8?B?dDFYMUY2Wk1ZRmVxOHJjOUxJT0t6RzNDN1dKMWRwWEd1WlZJbVdBeEd6QjNZ?=
 =?utf-8?B?SENWcVVNTktydk5DL3hiUT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7529.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UzFxWXB2TUxGTEhwbm9zMHpiMzYyejloWGhqUXJ2eForU1JmZ20yTkYrZHhq?=
 =?utf-8?B?eGh5N1p0RXNkTzhpek5pRm95VmhwbHdudjFYQjk0QnVVVkdsczErY0tlU2J4?=
 =?utf-8?B?dlBJVVZTMTIxMVpocGZKa3VFZkdKQUNPbmUyaURLbVZkTEhzS3JGeGV3ZXJw?=
 =?utf-8?B?eHlkY3FqK1JUZnpqdkIrU1F4d1ZtWDB5QlRwYmV4OFl1UWIrQTh6ZFg3VzVo?=
 =?utf-8?B?TzBGVGY1QmRST2FqazVLQlNvVW90MG9ySmRiOGoyQ1YxdWNtRDZSejIxUXhm?=
 =?utf-8?B?RTMyRHFMMjhMREMxTzF5N0hWN2FDMGRsNllTS0Uza2lKd3BESjVUR0kzVUFU?=
 =?utf-8?B?SGpKSzcyaExDd1U0R080TC9BMktvUEtjTVc1V3R6MW0xUDVFN01qdGYxVXE5?=
 =?utf-8?B?MjcxMmZZdEE5TVRsUjl1TlUyZHhTaWxsR0RReWg3ek94ZGR1M3JNWFJnZm1B?=
 =?utf-8?B?MDdnZW14QS9hN3FsOVdFanlDSmx2ZnRoNmFPVlZyQkZYR0tHMjdENlBaQkxy?=
 =?utf-8?B?VDdBQjZQQUIxTjFyZm5YR3paWTA0UkdJdkpoaTA5QTZrUUs5UU8xL2luNkJ3?=
 =?utf-8?B?dFlob2YrN0ZrT28rZXdmRGY5UG1iQ3kydUQxR2FQRFNiZjI3cjBtMWZ2dXFV?=
 =?utf-8?B?VWgzWFRIdVdIaGdSVXZHZ25ZQ21MZFVqcks4em9uWUV1OEYvYzFsdTZ2dHpF?=
 =?utf-8?B?eFB0NFpkV29NVW9xWUdWemI2VlN6VzJXeUVXQXlWM1YvUDIzUWptRlVSeHJY?=
 =?utf-8?B?M0pGZ1ZJSG5yeFdrU0tob0FUN0dHaWEvUXFKdXhHZmNaNCtZY3VFeERuZ2Jj?=
 =?utf-8?B?Y0pxUnZURGJHQnFVM21pUHpkZHZIaDl6cHoyNWl0enZRY0xtWHdtSVBESlFn?=
 =?utf-8?B?MWk3UXRLR2ZxTkNUVkFPN1V6UWRUUmNJK1FkSTJqTS9vWGhJTnVvVDcvOWw3?=
 =?utf-8?B?M0xaaXlLOE5pMkVPTVpOdlVBTDlFMXV3TTJtUm83Tlp2TVZBQTRwZVdVbXk1?=
 =?utf-8?B?U3FMalpuNGVRUHF4YzRqUiswZ0YwZ0xDSk5UVzlVMmNyK25ZbUZieW12T0o4?=
 =?utf-8?B?OWE2QUN2alROYUx6TzNXNk1BUlZVa01VbEpiVWRNTU5vazFzNlpHMStFYVdz?=
 =?utf-8?B?M0J3WG5LWWNidHh1c2NjOU95Qk9pbm5UN1NKcHBsa3dybDJLSUpWbmVFRUN2?=
 =?utf-8?B?V3JIcDdtcyt4QTYzODhmOTlFRUViWUs5Y1RCTzN6WEJ0YUNwYkxiRFRzSVp5?=
 =?utf-8?B?MmgwZEl0MzJvMlJaMGVPblBJMVptSXd5VldlS3pyd3dLUmQ4dEw0ZVZaUTZS?=
 =?utf-8?B?cFlJb0QzN1JSZGh5S2d2c0x5YjZORUZZdGd0RlVwQWRHMTJIdWFZaWtaejRD?=
 =?utf-8?B?T3lHMFRFdzZuYjdLUWVPVXlrNW4wbC81dE44VHlnd0lhbG9wYVB2NHd6QlNP?=
 =?utf-8?B?TG42NERHZzlqQXFabFlHQWszZHQ4S0RkbW5EM3ZoR1kwZEdwUUZVbSsvZWRj?=
 =?utf-8?B?QitsRm82UVREa21LYnRhVVBEbGsyam1MQmRsaGk4UHVFai9IQUFSdWhTUlNq?=
 =?utf-8?B?VmhvRHM5OEVVVjdoOGM1VXFMaXh6YUxBUC91NnV1TUE4MjNVM3ZJT0Z1Z2Q4?=
 =?utf-8?B?SDF5UFYxMWdUZmFGYmFKYUJtMGRSUWxCdTAzcG5SaVZrNnQxT3VyRjlKVVkw?=
 =?utf-8?B?cmZJMXRrQ1doNzVhNXQxdGx0N200aTNKU0NWOFFVQ3Q5S1BJU09lMWVFNDMv?=
 =?utf-8?B?M3JSb3dCVGhsNFFHa2JmS0dybnl0SHF5OFZnb2hXUVZQQ3FpMG15c2VtZkxR?=
 =?utf-8?B?Uyt3NkprclJPSE8yVGRwWGpZampuMUFHV09qZ0hwTytMUzJpcUV1VEFEcFNM?=
 =?utf-8?B?OWtFQ25Yb3p6RkowL1d6VEFjVXdoQ0t6aWxPbHV3Z1ordjBtZHNtcVMwRjJn?=
 =?utf-8?B?K0xvd2pNS284MzJ5VUhOVVhvVDJqOFFleVo3M3dQbXp0Q0xPc25wdkFWK0Vt?=
 =?utf-8?B?MTkyWUN2NDN2L09JWDJadCsxRk56QXFOc1daek5mczdiL1FVS3BBbkdLU0U1?=
 =?utf-8?B?TEhTa0hSY0ZYcXdLa1N2TWR6QlVDL3FRdFltVE9yTVJvVDJrSXlkZzAwMmxr?=
 =?utf-8?Q?l3ErhrM4Nc98GfP2927mp1WAo?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4860f35f-7e8a-4acb-374c-08dc9f1c1dd9
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2024 07:03:49.1233 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2Rd+of+nRBRt7pGvc5s6NNZ9nkUdauTnj1Ll/jItw5zGqRVmPMUQcnWsUOaE5WI4s6D2ZANgPhj7JfCZB8ZwfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR11MB6180
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.21; envelope-from=yi.l.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

On 2024/7/5 19:01, CLEMENT MATHIEU--DRIF wrote:
> From: Clément Mathieu--Drif <clement.mathieu--drif@eviden.com>
> 
> The constant must be unsigned, otherwise the two's complement
> overrides the other fields when a PASID is present.
> 
> Fixes: 1b2b12376c8a ("intel-iommu: PASID support")
> 

The extra line behind the "Fixes tag" is not needed.

> Signed-off-by: Clément Mathieu--Drif <clement.mathieu--drif@eviden.com>
> Reviewed-by: Yi Liu <yi.l.liu@intel.com>
> Reviewed-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> ---
>   hw/i386/intel_iommu_internal.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_internal.h
> index f8cf99bddf..cbc4030031 100644
> --- a/hw/i386/intel_iommu_internal.h
> +++ b/hw/i386/intel_iommu_internal.h
> @@ -267,7 +267,7 @@
>   /* For the low 64-bit of 128-bit */
>   #define VTD_FRCD_FI(val)        ((val) & ~0xfffULL)
>   #define VTD_FRCD_PV(val)        (((val) & 0xffffULL) << 40)
> -#define VTD_FRCD_PP(val)        (((val) & 0x1) << 31)
> +#define VTD_FRCD_PP(val)        (((val) & 0x1ULL) << 31)
>   #define VTD_FRCD_IR_IDX(val)    (((val) & 0xffffULL) << 48)
>   
>   /* DMA Remapping Fault Conditions */

It might be fine to squash patch 02 of this series into this one. @Jason?

-- 
Regards,
Yi Liu

