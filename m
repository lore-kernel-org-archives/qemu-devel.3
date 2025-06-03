Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 717C4C5AD49
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Jun 2025 10:40:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMP3p-0001Sp-Bd; Tue, 03 Jun 2025 06:40:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uMP3n-0001SW-A5
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 06:39:59 -0400
Received: from mgamail.intel.com ([198.175.65.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uMP3l-00088D-3Z
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 06:39:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1748947197; x=1780483197;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=OpPqPWsGWLxpY9Pjn65oex8123epfsEScr6rmHNNMuU=;
 b=IZ+/LCiMQM2yTN73cQlRAmA5uX3y5SDJdefsdnuoRFJeSAQDsW+NjzLu
 uPUeSH72y3tYZn3wD6oVlw3yl/sm5CBI+KryWrxQAIxNXjJcK38zh3myc
 ILRu2lnxzOpDi3ukxbzaJhSMiaY+A2cxnV6xXpCxsrOseFe6fixpGR8li
 N8iIg1YGOUhhbWwAa0wOOMK2zDnGpPToct/k3Q95EJskqSmqMdRFkACAe
 ek6+UMDgymZRvUz/sL43MhySLe28MKN/sg/PAsuQX3FP1fndZGy6Daf3m
 /FYMvOiCMus1mhNBpUJvSDalOvc9MiNbqV9Ib17mEyxkfffxEYqjz0DtY A==;
X-CSE-ConnectionGUID: DljwndRlS6yAvlUWxGPe8g==
X-CSE-MsgGUID: +T5lun7QS9eS/h09Lu0dyw==
X-IronPort-AV: E=McAfee;i="6700,10204,11451"; a="62036028"
X-IronPort-AV: E=Sophos;i="6.16,205,1744095600"; d="scan'208";a="62036028"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jun 2025 03:39:55 -0700
X-CSE-ConnectionGUID: MJB4UBT1QM+CWvDXmLZWJQ==
X-CSE-MsgGUID: LxqCMOnWSzCrtxQxp79law==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,205,1744095600"; d="scan'208";a="148676045"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jun 2025 03:39:55 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 3 Jun 2025 03:39:54 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Tue, 3 Jun 2025 03:39:54 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (40.107.243.69)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Tue, 3 Jun 2025 03:39:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RNI6ZYaBel91n2CqMgqXV33HSFt2Hy/6zzpZfENl3ZDzG0fUeh5S8evmCNnwZfMC/umjFlN7fs4SErBjCNy4sT3F2hnRz7oT4FadyCCztKn1cKvEM/cQx5VgkEwAMv6kuvxCiORrhDUbPcGqfR3MYKMNMnapRcFy1uNiT6bAgutpdNXCGlNkvWNRg9cCFytKknmiYio98djyO5j37FgbX++yci03Cri+CwlpOZao5aQ986Btk/FHAeMrr2ABNGjGBtNyvYbUA4+sn68SQJrLmxoAqyoH+7CYQf8f8EKei+2GSb9NjdUcAu8vZj+fxdjNE8dqRunU8rR0rwCZ97CkYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OpPqPWsGWLxpY9Pjn65oex8123epfsEScr6rmHNNMuU=;
 b=teJwVKEINh24he3tY52OcHFlTSy2owPV3jgFtKcuHOqsmY9Snt1Q+6LRn//OWPLY7NXmeTuQ9tPTPm+1HRuXKNaUOwwuPClGquAdBUibnCNDNUto7eB7VJotH2AeknpMF3ZNwXOj3MgEytZA+kexVuqpFJDzpCxjdADKLB4auY8aqlyBCjK8S6mXwzBk1gdRt8Zj9HG824RUYa4wJ4KNMel8Ne3ftO1tFZZFISsORQljujuPY7kuOtIPeoImUG+2MLUzzyi+1AVRwWq0mrDjrjqTBKIKRseU6kMIe+DdJGe9iZPDNdBm+lwFgDmhlWaTGuZP1PfLwxjBn2LuOozdyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12)
 by CY8PR11MB7316.namprd11.prod.outlook.com (2603:10b6:930:9f::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.30; Tue, 3 Jun
 2025 10:39:52 +0000
Received: from IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13]) by IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13%4]) with mapi id 15.20.8769.037; Tue, 3 Jun 2025
 10:39:52 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: Steve Sistare <steven.sistare@oracle.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: Alex Williamson <alex.williamson@redhat.com>, Cedric Le Goater
 <clg@redhat.com>, "Liu, Yi L" <yi.l.liu@intel.com>, Eric Auger
 <eric.auger@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, "Marcel
 Apfelbaum" <marcel.apfelbaum@gmail.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
Subject: RE: [PATCH V4 03/43] vfio/container: pass MemoryRegion to DMA
 operations
Thread-Topic: [PATCH V4 03/43] vfio/container: pass MemoryRegion to DMA
 operations
Thread-Index: AQHb0M9c+6aq8GqBF02xwOsttgKqubPxRf1g
Date: Tue, 3 Jun 2025 10:39:51 +0000
Message-ID: <IA3PR11MB91369CC18C3B9402BCB255B5926DA@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <1748546679-154091-1-git-send-email-steven.sistare@oracle.com>
 <1748546679-154091-4-git-send-email-steven.sistare@oracle.com>
In-Reply-To: <1748546679-154091-4-git-send-email-steven.sistare@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9136:EE_|CY8PR11MB7316:EE_
x-ms-office365-filtering-correlation-id: 48e806e5-6c98-4334-7128-08dda28af8d9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?WllnVGdQOEVJMTNGeGI1Sm5zM1FRZTVMMm8vRDdNY1BmUDJneGsrcHBXaUNl?=
 =?utf-8?B?ZThvdmRGWFRjWkxvcHZDcXR0dEF1M25sK2hya0VSOHRvZ0huV3VEcWdYR0Js?=
 =?utf-8?B?bDVQaHcvSGd4T3Irb1lqYzlYdXdSL01BNHNOZDU4dlZ1TXZhaGUvR1hkcWdW?=
 =?utf-8?B?UytpY3FsZjZabTVaQ3l5MS9aZi9LdGZ6ZEpEWVJHVDlmSngyT3FJWVQvZjJY?=
 =?utf-8?B?TUZaRHdLamI4ZkRXVkN2Vnh4eXRmd1hkTGFPNDM1L0lkOXByUk80REphYjlV?=
 =?utf-8?B?MzFmUEQ3RGs5NFVNYnk4MStzNDFQcklLd0Q5NHhQRVAzM2ZtNW5HV3FNdnlY?=
 =?utf-8?B?ZWNvTEgwN2ZJU0lqbGFBTGhUK3N4cm5GNC9mbjc2c1ZSbUdNWll3NkdzMkY3?=
 =?utf-8?B?TzdFWkFnZkxONklsR1dXaXF2QVhSaS9iNmZmamJQL1B6L1BhNk5kdGx1YjR0?=
 =?utf-8?B?dzFJbEdqdDFjZTBmQUg1eXZiYitWcnpuVUtoQVo2eGJHYnYybTRwMzlzaURj?=
 =?utf-8?B?MGlZUElZa2QwdlJ6L3FBVEw1c0tjR2ZCSGJremVOMVR1T0N0WXZ3NzVSUHhW?=
 =?utf-8?B?b0pRekhuWmFIOFpkWXd4UWkzTVVTSXNyOU5JMU9LKzBaRk9aalQ1SjZTRDNa?=
 =?utf-8?B?blNzemdhdzB1WlpkVTJ5enZqSHlkYS9VaWJuZWNINXN3NC81VTZwTXV5blV1?=
 =?utf-8?B?bWYvaDBjM09KOVRaVk1tcWlrd3gyTjdaaWo1dnBYb2hLeUsySzRTdFNTUHor?=
 =?utf-8?B?RW9ZOC93MW1CMzUzSHNnTUhGYWEvM0FWWjRqQ0JDeWxScE1WOTdubXVrZDJo?=
 =?utf-8?B?Ry91NmZoMVdCQmJPUzhxeXc1YWN2ZTB0eWwwREQvdVhZU1pwT1pPY2RMeVI5?=
 =?utf-8?B?L3A5d0pjanhPeHkrZlB0UFg0L3ZJYUFzdW5GcmZtQjdpQXBYamZ3dWZiQWFt?=
 =?utf-8?B?OUJaQXNGQ1RYc1VWOU02dGovRzV6L2lYU2xwVGRFSjdzMjJQVFFDdVdUWkEx?=
 =?utf-8?B?Z1lIRmNZN0RGWlJGMHpkaHFxbXZ5bG0vZXh0eHNVKzE4dGRvckhyQTB6bW5H?=
 =?utf-8?B?b0xydnZGRFl0TjBrczJmaGs2aGFmNUFJOXdzM05qRDd3NFdBb3Q0ZDZxNFdX?=
 =?utf-8?B?SmZkdk5GMzhiQmgxMU9URUVZcHNGbitoa2JRSTdjcXRiN1BCVEJVaUxsQnlZ?=
 =?utf-8?B?dXJQNGtlSWh2RFg3S2hQN3Q5ZURGTUNBNHRiMEpWVngxU24xMnJKUEhteGFB?=
 =?utf-8?B?T0JvVGZZRWhiZC9FTDhuLzFEdDZIRlRYNFJzSk4vL0t5UXA2OUUwcGFob0xo?=
 =?utf-8?B?eWd2d0NHZzJQRTF3ZUdiK21NeGVwVngvdlpDYXhwemZPS1g1c1JGdHdQZzRh?=
 =?utf-8?B?MGFsM0E0Z1V1Q0Z4eU53aGYxaER6RGxDV2czbjJXRzhaQms5WGpiSWNtamx5?=
 =?utf-8?B?eS8zdnY0UFBOeU1od3JVQTU5QXZTU3FxaFZsTVJFM1dIc0E5S1pSVjhvNlZ2?=
 =?utf-8?B?eFpEQTRCQkJiYTE0YUxTTUFLYmtmcENGWElZVFdVekZ2OStIUExxaGZwemIy?=
 =?utf-8?B?Z0cyT085eG9tVHFvVkxvS0Vaam5GT1B0MW9KbXNCekpVSDJWS2RxSFBGZUpV?=
 =?utf-8?B?aTl5MmphS2FyMXY5c25XcmlkR0xKdHpxeTc2WlFVRlVoWkJyWHJwZ0VnM1lm?=
 =?utf-8?B?R1lvbFI4eERZRnNkWi9wMVpqeGt0VFZxZk5YTElxaHF0UDZGRlFYaXlDZ2gw?=
 =?utf-8?B?cHBPak9FV0RiUXAzbW90cmRoQnBRU25jN2pOK0Jqdys1UTRsS1VOUWxqZWVI?=
 =?utf-8?B?NU1EVGo3S1ZGRFMrUnRTSnFwWUFIK2pzQ3NWRXBISW5GQkRVMU4zeWc1N0hv?=
 =?utf-8?B?eDBjeDRETnVLNVVmRWpqVit2SWdYSHI4VHNVT01hcDRDNm1haWViNGhraURr?=
 =?utf-8?B?YzVQWWRjMFVVcDRidzVUSnpLNUR1VnY4OHlBWkttRUVQeGNwYkVKenp3elFS?=
 =?utf-8?Q?L8j48zkzjMJMSKSe0PQOlcp5JeWL4U=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9136.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TkRQSDFxa1pDK2RWYnlBanJLKzRvWlEveU9Rc3FJU0ViVVBzazljN2ZGRGZC?=
 =?utf-8?B?ZUp3clgxVU0yS3piY1B5TTFqQmFTOUNobHFGNWtSdEhqb0JQeWZrZ0h3VG9F?=
 =?utf-8?B?RUp2VTFseEx4ekUvY0pqcHhyMzFYMnEySzFEZWdIRWRzVmxMamZCTW1LaXFy?=
 =?utf-8?B?cWNxb2FLdzhEZk1xNUhhYVJGaHp0Z1ZzR2JvQUNqcHJPU3hBckZoeml6bnkr?=
 =?utf-8?B?RkJjdzU0TGJxUXB5RE9CTFBEZkVKOWZtN0tPeVMwaFZKMHpucDBVMTFyb0hT?=
 =?utf-8?B?SlBPNFhwdUxuQktDdDZNWG91NTV5MUdPcVpiR2dOVkduSm9HSDk0OU51NUla?=
 =?utf-8?B?dkcyUHBTVlZWbkYvQVRyYmloNWJUbHpWZG52TE00OWJya1IxdHdsMmNIYkhY?=
 =?utf-8?B?eXBjWTk4L3dBWEhOSjJzMnFQNi9RREVzbXc4aTFQcjgwREZBaVFnUEozVGtM?=
 =?utf-8?B?Yy9XcmZ3TUQyK0NLYmV3S0VOanNRTEpDVzVxc2NrMDBhRWxEYndoZm5rZXZC?=
 =?utf-8?B?RTUzS3BUZ2pwUmRsZnpqaXJMOHAxQWo3VTN5MmFhMzJFUjRGK1c5dGdwRDQ4?=
 =?utf-8?B?L1BwVmUyTU9Ma3NHNUk3Y3RaQzlKd2x5RUtSYjdMSkZUcmliYnRlbGhWd1A5?=
 =?utf-8?B?RDF3VExBQ1JQMCsrWFAwdGIvUkYwOHRKMTdRRUVoQzFBeFp3bGdva0NhcFls?=
 =?utf-8?B?UDQ5YkJTMXBOQ1BvMUxMMVRsTnNRWndPa1g4NmpPYVBKZ3R1L3pub3JnWTV4?=
 =?utf-8?B?MlQwVkRxd28vVGlaOERXY2lIUHFiVzhXU0xTbUc4bllFY3dJdE5pVFplRkVu?=
 =?utf-8?B?SFBrWU5Pd1VPMlk1SnE2ZDhOV0dLYnI2VlhwR1VVdlQ1TGlDOXBzYjZrbXhG?=
 =?utf-8?B?dVhFMExGU2NmaWcxTkYrenZ1bzIranorWlRYSzROZUlRcmtmY002TlhGUEha?=
 =?utf-8?B?Vi84cnlqcGJhVUNYbWJPMTJ5Qm92TXZpSktVdUlZV2RZb2ZzTUlCd1VjMXpt?=
 =?utf-8?B?b2N0ZnNkNVAyTStYRUorZU9wbkwxL1pLTXY1UEF5TjhsSWY5TGVyVm9VRERW?=
 =?utf-8?B?M0tKdGMxRmlHei9ybHU1LzFjVWNVOTJHa1cxd1NZYXNDcE9FMnpxTTljdENP?=
 =?utf-8?B?ZlNvSnVlNnFKemMzQ3R1K1l3RWlRUUFsalZsOVJvZ3R0NVpQRFhwdmlESytU?=
 =?utf-8?B?aDNXZ3NzSHJWU05yYi9CdG9EVlMwbnNDZVF6clBCR2EwTVJ5RXdielRNYVFl?=
 =?utf-8?B?TTRrRGNSVXlYYWdSZ1luM2ZQRVJiWXhWRjBnL2Y3UkRIc2Z0SFhZNThtWlMv?=
 =?utf-8?B?VUswK2Y5V2dIWEJXajVNMTVBZ2FhVWcrbGtRclcyWXVzVnM5TzB6R3FMcnQ1?=
 =?utf-8?B?MmZ5R1o2NlZvZzZWNXhSVENqdTlrSVRDTzZaRWo2N01kdWxHSmE1YmM2R1Zv?=
 =?utf-8?B?UU0yb0VGNWt2KzBUcGVjQkFFcTgxcXprZXR5dTZyU01VcnFRWkNNYlY1SjBz?=
 =?utf-8?B?T0E1ZUllbFRBekp4L2V0Qi9yNnFSMk1SQkcxVFBwdUxkaXBIYnE0K25YeHl4?=
 =?utf-8?B?OXF0QkJNSWV6bVUweU5kS3hBVHFENldhOFptSXhzOXRJUDNnZ0NDL1JRdy9L?=
 =?utf-8?B?WXBXakE3WW5YSWw5RTRmdHRFSXQ4R3FVTjFrSGl4UTJWdm15cVN6UmFCOXho?=
 =?utf-8?B?UkNMcmNSM2dqYkN3dVN5U00ya3dHNWszMUVxdDY4YlNnSExNamR4eEVwN2dU?=
 =?utf-8?B?RHB0OWZrSEcwS2VnL2ROcUcrd3dnMVBjZVY1VlAwcmN0bjNXUzBUZ2hSM1Ey?=
 =?utf-8?B?ZXFRSmovNitrcGxSRG5JUVI4a1NOaUZsQUdjcnozbTMyOEQ1VHpEMVRBV1dp?=
 =?utf-8?B?SkhoTXd6N0tJb1lMV0pLM3JuSVJSN21yTXBUOU9PM2VnaDdJajllb2F4NVZy?=
 =?utf-8?B?LzhWaXRPU2NlL3hwMkFVa3B6Mnk5djVUNUZKSTJjT1ZWRURudE44a0xNUnhu?=
 =?utf-8?B?ajByQmdzbGdCemd1SmthMWFTelJseVBUcHZHNEdFSjZNaWs1SnBJbzFscE9v?=
 =?utf-8?B?QlFTNzhjZmVOdnNmUlhjbTIxN2pmejVNbnF2Uk95Nmd1VmJzUVlFRWNxbFUv?=
 =?utf-8?Q?dmHqnWzu/BzSqecVvDYa1Brlk?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9136.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48e806e5-6c98-4334-7128-08dda28af8d9
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2025 10:39:52.0133 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7pnTQ15JThbdQwwk0VmO4IwEhUQzu/+Q3Yweot8QcsZN4pwAmymyctA2JQ9PXUq+Iz9aHBEs1h89OU68AZqmlwOWuMp8zRVcodh39MNznS8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7316
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.13;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.128,
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IFN0ZXZlIFNpc3RhcmUgPHN0
ZXZlbi5zaXN0YXJlQG9yYWNsZS5jb20+DQo+U3ViamVjdDogW1BBVENIIFY0IDAzLzQzXSB2Zmlv
L2NvbnRhaW5lcjogcGFzcyBNZW1vcnlSZWdpb24gdG8gRE1BDQo+b3BlcmF0aW9ucw0KPg0KPlBh
c3MgdGhyb3VnaCB0aGUgTWVtb3J5UmVnaW9uIHRvIERNQSBvcGVyYXRpb24gaGFuZGxlcnMgb2Yg
dmZpbw0KPmNvbnRhaW5lcnMuIFRoZSB2ZmlvLXVzZXIgY29udGFpbmVyIHdpbGwgbmVlZCB0aGlz
IGxhdGVyLCB0byB0cmFuc2xhdGUNCj50aGUgdmFkZHIgaW50byBhbiBvZmZzZXQgZm9yIHRoZSBk
bWEgbWFwIHZmaW8tdXNlciBtZXNzYWdlLg0KPg0KPk9yaWdpbmFsbHktYnk6IEpvaG4gSm9obnNv
biA8am9obi5nLmpvaG5zb25Ab3JhY2xlLmNvbT4NCj5TaWduZWQtb2ZmLWJ5OiBKYWdhbm5hdGhh
biBSYW1hbiA8amFnLnJhbWFuQG9yYWNsZS5jb20+DQo+U2lnbmVkLW9mZi1ieTogRWxlbmEgVWZp
bXRzZXZhIDxlbGVuYS51ZmltdHNldmFAb3JhY2xlLmNvbT4NCj5TaWduZWQtb2ZmLWJ5OiBKb2hu
IExldm9uIDxqb2huLmxldm9uQG51dGFuaXguY29tPg0KPlJldmlld2VkLWJ5OiBDw6lkcmljIExl
IEdvYXRlciA8Y2xnQHJlZGhhdC5jb20+DQo+UmV2aWV3ZWQtYnk6IFN0ZXZlIFNpc3RhcmUgPHN0
ZXZlbi5zaXN0YXJlQG9yYWNsZS5jb20+DQoNClJldmlld2VkLWJ5OiBaaGVuemhvbmcgRHVhbiA8
emhlbnpob25nLmR1YW5AaW50ZWwuY29tPg0KDQo+LS0tDQo+IGluY2x1ZGUvaHcvdmZpby92Zmlv
LWNvbnRhaW5lci1iYXNlLmggfCAxNyArKysrKysrKysrKysrKystLQ0KPiBody92ZmlvL2NvbnRh
aW5lci1iYXNlLmMgICAgICAgICAgICAgIHwgIDQgKystLQ0KPiBody92ZmlvL2NvbnRhaW5lci5j
ICAgICAgICAgICAgICAgICAgIHwgIDMgKystDQo+IGh3L3ZmaW8vaW9tbXVmZC5jICAgICAgICAg
ICAgICAgICAgICAgfCAgMyArKy0NCj4gaHcvdmZpby9saXN0ZW5lci5jICAgICAgICAgICAgICAg
ICAgICB8ICA2ICsrKy0tLQ0KPiA1IGZpbGVzIGNoYW5nZWQsIDI0IGluc2VydGlvbnMoKyksIDkg
ZGVsZXRpb25zKC0pDQo+DQo+ZGlmZiAtLWdpdCBhL2luY2x1ZGUvaHcvdmZpby92ZmlvLWNvbnRh
aW5lci1iYXNlLmggYi9pbmNsdWRlL2h3L3ZmaW8vdmZpby0NCj5jb250YWluZXItYmFzZS5oDQo+
aW5kZXggM2QzOTJiMC4uODNiYTdhNSAxMDA2NDQNCj4tLS0gYS9pbmNsdWRlL2h3L3ZmaW8vdmZp
by1jb250YWluZXItYmFzZS5oDQo+KysrIGIvaW5jbHVkZS9ody92ZmlvL3ZmaW8tY29udGFpbmVy
LWJhc2UuaA0KPkBAIC03OCw3ICs3OCw3IEBAIHZvaWQgdmZpb19hZGRyZXNzX3NwYWNlX2luc2Vy
dChWRklPQWRkcmVzc1NwYWNlICpzcGFjZSwNCj4NCj4gaW50IHZmaW9fY29udGFpbmVyX2RtYV9t
YXAoVkZJT0NvbnRhaW5lckJhc2UgKmJjb250YWluZXIsDQo+ICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIGh3YWRkciBpb3ZhLCByYW1fYWRkcl90IHNpemUsDQo+LSAgICAgICAgICAgICAgICAg
ICAgICAgICAgIHZvaWQgKnZhZGRyLCBib29sIHJlYWRvbmx5KTsNCj4rICAgICAgICAgICAgICAg
ICAgICAgICAgICAgdm9pZCAqdmFkZHIsIGJvb2wgcmVhZG9ubHksIE1lbW9yeVJlZ2lvbiAqbXIp
Ow0KPiBpbnQgdmZpb19jb250YWluZXJfZG1hX3VubWFwKFZGSU9Db250YWluZXJCYXNlICpiY29u
dGFpbmVyLA0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGh3YWRkciBpb3ZhLCByYW1f
YWRkcl90IHNpemUsDQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgSU9NTVVUTEJFbnRy
eSAqaW90bGIsIGJvb2wgdW5tYXBfYWxsKTsNCj5AQCAtMTE5LDkgKzExOSwyMiBAQCBzdHJ1Y3Qg
VkZJT0lPTU1VQ2xhc3Mgew0KPiAgICAgYm9vbCAoKnNldHVwKShWRklPQ29udGFpbmVyQmFzZSAq
YmNvbnRhaW5lciwgRXJyb3IgKiplcnJwKTsNCj4gICAgIHZvaWQgKCpsaXN0ZW5lcl9iZWdpbiko
VkZJT0NvbnRhaW5lckJhc2UgKmJjb250YWluZXIpOw0KPiAgICAgdm9pZCAoKmxpc3RlbmVyX2Nv
bW1pdCkoVkZJT0NvbnRhaW5lckJhc2UgKmJjb250YWluZXIpOw0KPisgICAgLyoqDQo+KyAgICAg
KiBAZG1hX21hcA0KPisgICAgICoNCj4rICAgICAqIE1hcCBhbiBhZGRyZXNzIHJhbmdlIGludG8g
dGhlIGNvbnRhaW5lci4gTm90ZSB0aGF0IEBtciB3aWxsIHdpdGhpbiBhbg0KPisgICAgICogUkNV
IHJlYWQgbG9jayByZWdpb24gYWNyb3NzIHRoaXMgY2FsbC4NCj4rICAgICAqDQo+KyAgICAgKiBA
YmNvbnRhaW5lcjogI1ZGSU9Db250YWluZXJCYXNlIHRvIHVzZQ0KPisgICAgICogQGlvdmE6IHN0
YXJ0IGFkZHJlc3MgdG8gbWFwDQo+KyAgICAgKiBAc2l6ZTogc2l6ZSBvZiB0aGUgcmFuZ2UgdG8g
bWFwDQo+KyAgICAgKiBAdmFkZHI6IHByb2Nlc3MgdmlydHVhbCBhZGRyZXNzIG9mIG1hcHBpbmcN
Cj4rICAgICAqIEByZWFkb25seTogdHJ1ZSBpZiBtYXBwaW5nIHNob3VsZCBiZSByZWFkb25seQ0K
PisgICAgICogQG1yOiB0aGUgbWVtb3J5IHJlZ2lvbiBmb3IgdGhpcyBtYXBwaW5nDQo+KyAgICAg
Ki8NCj4gICAgIGludCAoKmRtYV9tYXApKGNvbnN0IFZGSU9Db250YWluZXJCYXNlICpiY29udGFp
bmVyLA0KPiAgICAgICAgICAgICAgICAgICAgaHdhZGRyIGlvdmEsIHJhbV9hZGRyX3Qgc2l6ZSwN
Cj4tICAgICAgICAgICAgICAgICAgIHZvaWQgKnZhZGRyLCBib29sIHJlYWRvbmx5KTsNCj4rICAg
ICAgICAgICAgICAgICAgIHZvaWQgKnZhZGRyLCBib29sIHJlYWRvbmx5LCBNZW1vcnlSZWdpb24g
Km1yKTsNCj4gICAgIC8qKg0KPiAgICAgICogQGRtYV91bm1hcA0KPiAgICAgICoNCj5kaWZmIC0t
Z2l0IGEvaHcvdmZpby9jb250YWluZXItYmFzZS5jIGIvaHcvdmZpby9jb250YWluZXItYmFzZS5j
DQo+aW5kZXggMWM2Y2E5NC4uZDgzNGJkNCAxMDA2NDQNCj4tLS0gYS9ody92ZmlvL2NvbnRhaW5l
ci1iYXNlLmMNCj4rKysgYi9ody92ZmlvL2NvbnRhaW5lci1iYXNlLmMNCj5AQCAtNzUsMTIgKzc1
LDEyIEBAIHZvaWQgdmZpb19hZGRyZXNzX3NwYWNlX2luc2VydChWRklPQWRkcmVzc1NwYWNlDQo+
KnNwYWNlLA0KPg0KPiBpbnQgdmZpb19jb250YWluZXJfZG1hX21hcChWRklPQ29udGFpbmVyQmFz
ZSAqYmNvbnRhaW5lciwNCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgaHdhZGRyIGlvdmEs
IHJhbV9hZGRyX3Qgc2l6ZSwNCj4tICAgICAgICAgICAgICAgICAgICAgICAgICAgdm9pZCAqdmFk
ZHIsIGJvb2wgcmVhZG9ubHkpDQo+KyAgICAgICAgICAgICAgICAgICAgICAgICAgIHZvaWQgKnZh
ZGRyLCBib29sIHJlYWRvbmx5LCBNZW1vcnlSZWdpb24gKm1yKQ0KPiB7DQo+ICAgICBWRklPSU9N
TVVDbGFzcyAqdmlvYyA9IFZGSU9fSU9NTVVfR0VUX0NMQVNTKGJjb250YWluZXIpOw0KPg0KPiAg
ICAgZ19hc3NlcnQodmlvYy0+ZG1hX21hcCk7DQo+LSAgICByZXR1cm4gdmlvYy0+ZG1hX21hcChi
Y29udGFpbmVyLCBpb3ZhLCBzaXplLCB2YWRkciwgcmVhZG9ubHkpOw0KPisgICAgcmV0dXJuIHZp
b2MtPmRtYV9tYXAoYmNvbnRhaW5lciwgaW92YSwgc2l6ZSwgdmFkZHIsIHJlYWRvbmx5LCBtcik7
DQo+IH0NCj4NCj4gaW50IHZmaW9fY29udGFpbmVyX2RtYV91bm1hcChWRklPQ29udGFpbmVyQmFz
ZSAqYmNvbnRhaW5lciwNCj5kaWZmIC0tZ2l0IGEvaHcvdmZpby9jb250YWluZXIuYyBiL2h3L3Zm
aW8vY29udGFpbmVyLmMNCj5pbmRleCBhOWYwZGJhLi5hOGM3NmViIDEwMDY0NA0KPi0tLSBhL2h3
L3ZmaW8vY29udGFpbmVyLmMNCj4rKysgYi9ody92ZmlvL2NvbnRhaW5lci5jDQo+QEAgLTIwNyw3
ICsyMDcsOCBAQCBzdGF0aWMgaW50IHZmaW9fbGVnYWN5X2RtYV91bm1hcChjb25zdA0KPlZGSU9D
b250YWluZXJCYXNlICpiY29udGFpbmVyLA0KPiB9DQo+DQo+IHN0YXRpYyBpbnQgdmZpb19sZWdh
Y3lfZG1hX21hcChjb25zdCBWRklPQ29udGFpbmVyQmFzZSAqYmNvbnRhaW5lciwgaHdhZGRyDQo+
aW92YSwNCj4tICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHJhbV9hZGRyX3Qgc2l6ZSwg
dm9pZCAqdmFkZHIsIGJvb2wgcmVhZG9ubHkpDQo+KyAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICByYW1fYWRkcl90IHNpemUsIHZvaWQgKnZhZGRyLCBib29sIHJlYWRvbmx5LA0KPisgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgTWVtb3J5UmVnaW9uICptcikNCj4gew0KPiAgICAg
Y29uc3QgVkZJT0NvbnRhaW5lciAqY29udGFpbmVyID0gY29udGFpbmVyX29mKGJjb250YWluZXIs
IFZGSU9Db250YWluZXIsDQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgYmNvbnRhaW5lcik7DQo+ZGlmZiAtLWdpdCBhL2h3L3ZmaW8vaW9tbXVmZC5j
IGIvaHcvdmZpby9pb21tdWZkLmMNCj5pbmRleCBhZjFjN2FiLi5hOGNjNTQzIDEwMDY0NA0KPi0t
LSBhL2h3L3ZmaW8vaW9tbXVmZC5jDQo+KysrIGIvaHcvdmZpby9pb21tdWZkLmMNCj5AQCAtMzQs
NyArMzQsOCBAQA0KPiAgICAgICAgICAgICBUWVBFX0hPU1RfSU9NTVVfREVWSUNFX0lPTU1VRkQg
Ii12ZmlvIg0KPg0KPiBzdGF0aWMgaW50IGlvbW11ZmRfY2Rldl9tYXAoY29uc3QgVkZJT0NvbnRh
aW5lckJhc2UgKmJjb250YWluZXIsIGh3YWRkcg0KPmlvdmEsDQo+LSAgICAgICAgICAgICAgICAg
ICAgICAgICAgICByYW1fYWRkcl90IHNpemUsIHZvaWQgKnZhZGRyLCBib29sIHJlYWRvbmx5KQ0K
PisgICAgICAgICAgICAgICAgICAgICAgICAgICAgcmFtX2FkZHJfdCBzaXplLCB2b2lkICp2YWRk
ciwgYm9vbCByZWFkb25seSwNCj4rICAgICAgICAgICAgICAgICAgICAgICAgICAgIE1lbW9yeVJl
Z2lvbiAqbXIpDQo+IHsNCj4gICAgIGNvbnN0IFZGSU9JT01NVUZEQ29udGFpbmVyICpjb250YWlu
ZXIgPQ0KPiAgICAgICAgIGNvbnRhaW5lcl9vZihiY29udGFpbmVyLCBWRklPSU9NTVVGRENvbnRh
aW5lciwgYmNvbnRhaW5lcik7DQo+ZGlmZiAtLWdpdCBhL2h3L3ZmaW8vbGlzdGVuZXIuYyBiL2h3
L3ZmaW8vbGlzdGVuZXIuYw0KPmluZGV4IDBhZmFmZTMuLmExZDJkMjUgMTAwNjQ0DQo+LS0tIGEv
aHcvdmZpby9saXN0ZW5lci5jDQo+KysrIGIvaHcvdmZpby9saXN0ZW5lci5jDQo+QEAgLTE3MCw3
ICsxNzAsNyBAQCBzdGF0aWMgdm9pZCB2ZmlvX2lvbW11X21hcF9ub3RpZnkoSU9NTVVOb3RpZmll
ciAqbiwNCj5JT01NVVRMQkVudHJ5ICppb3RsYikNCj4gICAgICAgICAgKi8NCj4gICAgICAgICBy
ZXQgPSB2ZmlvX2NvbnRhaW5lcl9kbWFfbWFwKGJjb250YWluZXIsIGlvdmEsDQo+ICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICBpb3RsYi0+YWRkcl9tYXNrICsgMSwgdmFkZHIs
DQo+LSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICByZWFkX29ubHkpOw0KPisg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgcmVhZF9vbmx5LCBtcik7DQo+ICAg
ICAgICAgaWYgKHJldCkgew0KPiAgICAgICAgICAgICBlcnJvcl9yZXBvcnQoInZmaW9fY29udGFp
bmVyX2RtYV9tYXAoJXAsIDB4JSJIV0FERFJfUFJJeCIsICINCj4gICAgICAgICAgICAgICAgICAg
ICAgICAgICIweCUiSFdBRERSX1BSSXgiLCAlcCkgPSAlZCAoJXMpIiwNCj5AQCAtMjQwLDcgKzI0
MCw3IEBAIHN0YXRpYyBpbnQNCj52ZmlvX3JhbV9kaXNjYXJkX25vdGlmeV9wb3B1bGF0ZShSYW1E
aXNjYXJkTGlzdGVuZXIgKnJkbCwNCj4gICAgICAgICB2YWRkciA9IG1lbW9yeV9yZWdpb25fZ2V0
X3JhbV9wdHIoc2VjdGlvbi0+bXIpICsgc3RhcnQ7DQo+DQo+ICAgICAgICAgcmV0ID0gdmZpb19j
b250YWluZXJfZG1hX21hcChiY29udGFpbmVyLCBpb3ZhLCBuZXh0IC0gc3RhcnQsDQo+LSAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB2YWRkciwgc2VjdGlvbi0+cmVhZG9ubHkp
Ow0KPisgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdmFkZHIsIHNlY3Rpb24t
PnJlYWRvbmx5LCBzZWN0aW9uLT5tcik7DQo+ICAgICAgICAgaWYgKHJldCkgew0KPiAgICAgICAg
ICAgICAvKiBSb2xsYmFjayAqLw0KPiAgICAgICAgICAgICB2ZmlvX3JhbV9kaXNjYXJkX25vdGlm
eV9kaXNjYXJkKHJkbCwgc2VjdGlvbik7DQo+QEAgLTU2NCw3ICs1NjQsNyBAQCBzdGF0aWMgdm9p
ZCB2ZmlvX2xpc3RlbmVyX3JlZ2lvbl9hZGQoTWVtb3J5TGlzdGVuZXINCj4qbGlzdGVuZXIsDQo+
ICAgICB9DQo+DQo+ICAgICByZXQgPSB2ZmlvX2NvbnRhaW5lcl9kbWFfbWFwKGJjb250YWluZXIs
IGlvdmEsIGludDEyOF9nZXQ2NChsbHNpemUpLA0KPi0gICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICB2YWRkciwgc2VjdGlvbi0+cmVhZG9ubHkpOw0KPisgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICB2YWRkciwgc2VjdGlvbi0+cmVhZG9ubHksIHNlY3Rpb24tPm1yKTsNCj4g
ICAgIGlmIChyZXQpIHsNCj4gICAgICAgICBlcnJvcl9zZXRnKCZlcnIsICJ2ZmlvX2NvbnRhaW5l
cl9kbWFfbWFwKCVwLCAweCUiSFdBRERSX1BSSXgiLCAiDQo+ICAgICAgICAgICAgICAgICAgICAi
MHglIkhXQUREUl9QUkl4IiwgJXApID0gJWQgKCVzKSIsDQo+LS0NCj4xLjguMy4xDQoNCg==

