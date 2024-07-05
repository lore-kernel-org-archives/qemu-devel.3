Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23448C30658
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2024 08:50:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPed1-0005Y2-Eq; Fri, 05 Jul 2024 04:49:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sPecz-0005PD-Ho
 for qemu-devel@nongnu.org; Fri, 05 Jul 2024 04:49:13 -0400
Received: from mgamail.intel.com ([192.198.163.8])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sPecx-0006aj-KD
 for qemu-devel@nongnu.org; Fri, 05 Jul 2024 04:49:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1720169351; x=1751705351;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=pQxDBk83/YxUVuu7NNU0F5Mfl16I6frKd81BIQUWrU0=;
 b=ev/B0OZmvetYQ6yuK8kB8TKKd6Zne/4t9viNBSmaSea2KTPJnVdZm07C
 YNZHjr5DH7E1gxai4QV/UcKt++9kePIsKDOY8LTvkvLX4FD9jrbmDEmH0
 755+pPEMIcdY/+qd3KQOhhflQzPqsgaSF64NLcSeZhxsfYMYMGM5TQ++2
 ROmN3Kr7PKU2vyCD3Ry3cZHANwIvJ0zb8mAURjvZMd9+Lmj86WI+xD3Y2
 Me3FGMeGxJyeGpN6s3qjTKTOxjDlM0szQw1HeUQ2ckP/tedzy7ybJvi4I
 884WPANZTbz53uO8jJu6RI/n3kQmf1KEfKg3pMYoClx1ZrfrXVYCuw/Mb w==;
X-CSE-ConnectionGUID: EeSw4QYMRTOsaj9lioB6xA==
X-CSE-MsgGUID: m16SZsRsQ++IkdtkC+NKtA==
X-IronPort-AV: E=McAfee;i="6700,10204,11123"; a="34995569"
X-IronPort-AV: E=Sophos;i="6.09,184,1716274800"; d="scan'208";a="34995569"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Jul 2024 01:49:08 -0700
X-CSE-ConnectionGUID: UqcBHPIaS0iJG5xNYxShaA==
X-CSE-MsgGUID: g5JAsiLeSWyqqIj80SsQWA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,184,1716274800"; d="scan'208";a="51673117"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
 by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 05 Jul 2024 01:49:07 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 5 Jul 2024 01:49:07 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 5 Jul 2024 01:49:06 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 5 Jul 2024 01:49:06 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 5 Jul 2024 01:49:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TFLUn0hgr8OhxcirHijNE4tD1k9Dn+wES5WJXpUAc2qdFs2YtkIAGnIznIzWqJZFh69mTswWmbXnPlk0E9eYj3s2gjKxLHw7/ZxvBn0VMa/hFEc+UKv2TNavHk7X3r1reyEAxPZgeACNNRtXIdaQRJKjgY2roVSERkk7GmzAQ/4RofoJPb8h7fR64HUCgDlw9u/0UHj6e+guou+DWmGJRnoVWvgeCz2eUyzrHBhqbX9pNkIeTRWvOZ14xXca5P9fJMz++N33NCdVHW2TW/uZ3B1bjcX4tY2MIvzrWYY4BBN4B+7++DwQQzFqwP+Mi+d/4lfNtHFfXb7Ovg0rlIs8ZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pQxDBk83/YxUVuu7NNU0F5Mfl16I6frKd81BIQUWrU0=;
 b=nQS3VXtApVQ12ERSE3UsLRRmBCZzkTWBANNBbhNppTkFphDA65/MwYDHx4E9oowVj/vGr4+PHOhkJI7sTO/M1qCjhK4LRnsF2Rn8EC/vCzoOFr5WisVBSXzy21LoGedxk1v8ftNvY/i/9eVS9wiEaQuwgFV7rDnBsG4v9wkZIkoqCfim8+UabNXyr6LMyJygUjXC6AzXqlGvNFndWdlFHDi30N4EOgOEEZaEDmCC+7dKfdc1rB/VGcU4UwXE8+ZQ6E5PyVlZFC/eWbnBEXXQxfmNhRZ56gvBE0DBKAsWIgA2w21dvOiPN1/VPfeoR6eZyScJDicxTSOqBlnlkynqcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by SJ0PR11MB4848.namprd11.prod.outlook.com (2603:10b6:a03:2af::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.26; Fri, 5 Jul
 2024 08:49:04 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091%7]) with mapi id 15.20.7741.027; Fri, 5 Jul 2024
 08:49:04 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "jasowang@redhat.com" <jasowang@redhat.com>, "Tian, Kevin"
 <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>, "peterx@redhat.com"
 <peterx@redhat.com>, "mst@redhat.com" <mst@redhat.com>
Subject: RE: [PATCH  v3 2/3] intel_iommu: fix type of the mask field in
 VTDIOTLBPageInvInfo
Thread-Topic: [PATCH  v3 2/3] intel_iommu: fix type of the mask field in
 VTDIOTLBPageInvInfo
Thread-Index: AQHazpi2lPssDbL9Hku4cJcjbRw2n7Hn0tmg
Date: Fri, 5 Jul 2024 08:49:04 +0000
Message-ID: <SJ0PR11MB6744371E32FC95BAFF62821B92DF2@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20240705050213.1492515-1-clement.mathieu--drif@eviden.com>
 <20240705050213.1492515-3-clement.mathieu--drif@eviden.com>
In-Reply-To: <20240705050213.1492515-3-clement.mathieu--drif@eviden.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|SJ0PR11MB4848:EE_
x-ms-office365-filtering-correlation-id: 66101afd-d1e7-4bd5-4485-08dc9ccf52ec
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?T1lSMlJwY0lxRXQ2ZnVyQ2RSYnAxQi9GZG5CYXdDN29mLzJrWC9VYmhkQ3JT?=
 =?utf-8?B?S1REQ25NR0Q3OHBvaXkwWFgvbnJGQmVwQlFFQkxsU3ltNFpxSlg0SVJZNWg3?=
 =?utf-8?B?MUJYNHFOd0wrNlpVSUtXWGdpOGVRQksyU3FLUmo2eEdkb0J0MThEUnA0ZUw4?=
 =?utf-8?B?ME8yNThaWFY5ZllMM0F1ODBjbmhXeUJLdUVPUFM0aVc0RytTYjZLY1l3N3V4?=
 =?utf-8?B?dnBDeG14TDl3WjlpQ1ZodUplK1JuVUIrUEV6bHRpbnIydHZGSmxFZ1BraWtj?=
 =?utf-8?B?d3hQUnJlbTF5WDZ5OWtzaGdQZEVadklMaWEyK0J4NDcvMHZtTEpOZWZyL3NS?=
 =?utf-8?B?dkxWa0h1UGYrZjhGNFhZWnZJZDk4bklibnNGeUszakRMZG1hVXZ5VkFIQXFy?=
 =?utf-8?B?OGVPSGRTMHJscHVwZjE2MysrN0FNY05icjg4aFBmRUlRK0QzbHIrMy9GaXF3?=
 =?utf-8?B?T3lnZ0tzZWJET3hvL1IxWnJYRnhubVcxWm5DcFVSRW5jbDV2MEJzYS9QSitm?=
 =?utf-8?B?MjAwV0tUbllpRW1qRE9kNGovRXRTUXMwRXFNQ3I1Y2s2UGJjay95MHRQN0xC?=
 =?utf-8?B?WTNVWThmY1lWRi9DcjUrK20vT1hnTUN5QWJDNXU1OXI1OTE3ZWxYMHg2cWVs?=
 =?utf-8?B?M0pHSGZpeE5MejFmajk0dHFPMWFGRUs4VHJ1cUxpVnZlQ1BpVlZMTS9nTkZD?=
 =?utf-8?B?MGc1SkFDV2QwQVoyTXhYTUg1dmxqRHh6aTBFaHNFdWxKTlRueFlBS2ViRmhS?=
 =?utf-8?B?RUUxeGtvVkZId1ZhajVwMzVXVUJtcy9JajB4Q1c3MDc2NVhObmdpb0tUWlhm?=
 =?utf-8?B?cS83a0VHWHovNjZoTEZYNXlybzBtTzBxVEVqTGFYU3QyS3JIdWx6NmhPVkkx?=
 =?utf-8?B?OUpKb2tqdXQ3dHc4anN3RUZlclZNREpsOGhQRURaaFFIMkpxbVRiZHVyTFRB?=
 =?utf-8?B?NERQZWQ2MzEyeFIyYWd0WkR0TnVJK2ZhYzdiVmh6ejdHTThYb0ppaTUvUFIy?=
 =?utf-8?B?Vkh0aTh3WkRtU01jU0dJdWJJS3JjVTR6KzlxVFQxMmJnZi9RLzEydFJmN0JU?=
 =?utf-8?B?QUZXdkZMcmhwamtKSVFoQmU5VmJKSnJ1YlJ3OXZUME1EVWVKdURRS2I5THhS?=
 =?utf-8?B?UmxxRndZRHc1MHJtbnFYL3o2MStUUXVhdkVrU1dWZ0h3RDhCUGl6c2pQNDdy?=
 =?utf-8?B?ZVc0a25SZmZoSFhHR2RYd0pINXhzeHVqWDNiZ1NMVVZMOTU4WkJVQ3JlMUp2?=
 =?utf-8?B?UktmR0FUSHFadldMYmFHL1hQUVpmSGNhcklvOXBZbUQ1bk5hMmVLS01VOEt0?=
 =?utf-8?B?dmkvRk8yTElheUY1N3dzVXBsUkN1UWloVnNsWHA1czE4QTZ5M0Z0V01kY1JM?=
 =?utf-8?B?SDFXNkREcENUY1BodDlXK1U4ZzdUazE2dFNVY05NbWhrS0pLVGQ0MVJIbWRL?=
 =?utf-8?B?RGtqOWN1eWczTjlURm1TTUc3TXo5aDRzU0NNUnUzOUNreW9DUDRVdHJUVE1D?=
 =?utf-8?B?K0hGdFhzRXVPK1o0QXI3Y1FSTmxib3ArdVBuS0puNVhvSWVMbDhpc1cvVzdW?=
 =?utf-8?B?ckJGQ25WSithRUpqSktzQmFoRnhZS2EwWVhxOHVXeUZVRTVJWTRha1cvZ1Z4?=
 =?utf-8?B?bWdkQXdocUJncTNoZGRaN1dRWUZONTg4MzlvL0pJQkJncXZObURkTmI5alhR?=
 =?utf-8?B?RERTTi9WeGZ4aGtJcWhlcmlFN3JjTElsTGgxNU42dys1eGQrNWxWRVJUVmJC?=
 =?utf-8?B?dXBibVRUSnBTcU1Wby9BcE9lVVVrRkQrRXh1N2NxWVNQbEpOZmJOSHRkL1Q5?=
 =?utf-8?B?T05ZR0VpTjBCbWh5TTFCQncvMFdOd3duTkE5L25aYkp1ZHRDMEFDWCs3RXN6?=
 =?utf-8?B?ZWIxNnBpMU1VVVR6b1d4WHdFQTVpMzJuaUpXTktGbmxvb3c9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WFpTYjdDUHRwNnBtQXpuVFdSSjFBWXh2UFRIMVFVYkE3V0hSTVEyVjg3cWVr?=
 =?utf-8?B?WG9hRC9mQ0E0blYzZVdXQzhJam4wQ3NoalBhc1dPSVNRUG1JOGRKWjYxcGhE?=
 =?utf-8?B?NVpGSXFjN3MxdmdHZVVLOEEvTHJ0VWt4RTQ1VmhXMWIzci9HMHg2TjZLbmZP?=
 =?utf-8?B?NE1iMWl5WjgxUnV6Znh2ei9UU2I2KzY0YzEzbmQyQWo2Z3IyUFhlVnhITkZU?=
 =?utf-8?B?Ni9DUWFMZTh3N1FlUG85cjBqUnlrcVVqL1NLZWp2UWlicFV2SmJTZnQ2UmlP?=
 =?utf-8?B?UkxiUXF0NzJnbFJCRmhEZks3UHJwOW50S016T3JmRVptSmpmaytNTm9XK1dC?=
 =?utf-8?B?ZERJRURKMitITm9SUFJ5L25JVDlVREJUcDUva3dENVlVWTdzbCtSeWVFR095?=
 =?utf-8?B?SU1lZE9nTFN6U2R3VmJZTTVnV2pSbFVyRzhnMFV4RThvOHAzQ0FXSk1XQjJL?=
 =?utf-8?B?TUZxeU1ta2dGWFY1QTlEZ2wxeVBKdFBXNDQrMjlPRkIvVUUybTFja0J1cWps?=
 =?utf-8?B?enlqcTJMSVRDMXlaVkJ0aXBPVHNmWXBIaFVvQ2syOHJpOXNnT013SjBmdUxu?=
 =?utf-8?B?RWFRSllXckkwdVI0MXhBbTBqRmZMb2pLdnVTQ0FnczhRZXpVTmU1Y0UyMmZL?=
 =?utf-8?B?enlJRXRTeUJtUENhQkIzN01jRTJqR3Vwak1ORHQ2MTZQWGxHd2wzOW92T2pj?=
 =?utf-8?B?L2NycTUzUU5PN2lNWWUrYWhVMXJyOWhNY1pXbVh5bk1ZWnZ6Qmthd2g3bmVX?=
 =?utf-8?B?U3BHTnNIQ2drOVVZL2hUQlVRY0E3OURUN29uOEU4cmxtUzF3NzJUUlpucVhS?=
 =?utf-8?B?NkZESFk0MnBuQ3hrRDF6TjlBbmxLekM3VUw5N3lWMW0reVZnMlpRdm5qelpF?=
 =?utf-8?B?V3ZCL1ZpbGtIWFRoSk1uSCtCNHh2OUNPZVBaaDVCdGhWU3RlU1dDcW5ndnR0?=
 =?utf-8?B?ZkNZdnVBZ1NVNzJpaVlHazJ1QklkV0QxeERlSUhFN2FrdnZXaTRnVlpNdGZq?=
 =?utf-8?B?dVBnUEFxQkNEWkRaVHA1aFd1SWp0c3pFRGZKbFgrbGlwQW1xVEh0Nml2bEVi?=
 =?utf-8?B?OXR6RWlocFZoKy9ObXVIQU1YQkRrNGFYeCtnMzhFVkFMQlZUZjJObm5weEwx?=
 =?utf-8?B?NmIxeENFRUl0N2o0QVhZUm5YalBrNmZjY3c3Y0VvWlVHSGhhbHNaRHppQTcy?=
 =?utf-8?B?YWZwNmR4VmNkY3FtVXZZc3h3WmdvcDBHK3krdGJYZi9XWlAwYXFIY0lqR0U3?=
 =?utf-8?B?VlA1NG1sT01FYjdBK2t6QXBFV0lCUXZNc2FoZEdsYzJoeHdnZFR5QkhqNEhP?=
 =?utf-8?B?R21PcWpReGpLRFE1TmpZVzlDU3FIS09UTEFodzBZbm9hZURMNHNreHNqcWZa?=
 =?utf-8?B?RlhNUmhOdHdmN2RzZEcxY1RQMjV0cDVtRklJNGs1RzV6TUtLZXlUZXB6L3Fu?=
 =?utf-8?B?Z0kwd0ZXM0VTaXdmOCtzVzJWMEpMcnd2WUE1cXhFQ0ZoRnpwV1B4UlpwaWpq?=
 =?utf-8?B?MTk3Q2ZFK0dZUDh0ODhzTXhqZEV3dXdqV21aazhEL1d5WGVUcVVPRTZBY0du?=
 =?utf-8?B?ekx2cndpSGxIamRocllhRXprZW9TZG0vM1BmMzZ4S25UMmJXY2RONE84S0k4?=
 =?utf-8?B?M1Fia21NTkZvTlNLV1V4U2RndEFzWEZrbGR3L1g5OVhvSW9xT000UER4WlRT?=
 =?utf-8?B?MFhrOUwydHhhSGZxbFdLaFdqa05nUEo2ZEM4cUJpYldVK2x0OUxjcjRCS1Rk?=
 =?utf-8?B?VGxDZXkzM3cwWXhGRjNMVHZVRkdRY2ZJTFdMN2VoRXhlM0NFUUlhdWtPcXhO?=
 =?utf-8?B?UHFUelVlU3BSc2d2cHExOGMwUEJPOWxtdWcwdjBFVVllUDduclVGVG5FYU9U?=
 =?utf-8?B?Y1VZT0xMN3d1K0pDdWllaC9aM0pRK3g5bzFyWFRtYTBvamQzRzFoWVRzTnJF?=
 =?utf-8?B?cGFaQVA0MmY3bHRJVzVidmhtZlBLdGVFMWk3QU5yV1NmalFpaUxBemp1MUZq?=
 =?utf-8?B?Tzdlb0pkRU16TC9ndDlVby9TYkFDbVNFcDdPbENOZzk5VjdFdDFrQWt6dVdi?=
 =?utf-8?B?WWxnSzVMcmdBTlJhOUp0dkYvaGFpeE16L3dCbVRnN1ZRMWFqK3B3bDhENXNE?=
 =?utf-8?Q?3fwhwexW8FT6srxvL/9HjIX+J?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66101afd-d1e7-4bd5-4485-08dc9ccf52ec
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jul 2024 08:49:04.3123 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ONHQMovzGKvVdIGEtZsCdf0B6ZR2/PfRbHRPcLHOuT71bBZmIz/6DbH7x+toNIEhmaiCzRD0pRRU72jhppHvP/FQJXB4utuaHLABbaOo49c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4848
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.8;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IENMRU1FTlQgTUFUSElFVS0t
RFJJRiA8Y2xlbWVudC5tYXRoaWV1LS1kcmlmQGV2aWRlbi5jb20+DQo+U3ViamVjdDogW1BBVENI
IHYzIDIvM10gaW50ZWxfaW9tbXU6IGZpeCB0eXBlIG9mIHRoZSBtYXNrIGZpZWxkIGluDQo+VlRE
SU9UTEJQYWdlSW52SW5mbw0KPg0KPkZyb206IENsw6ltZW50IE1hdGhpZXUtLURyaWYgPGNsZW1l
bnQubWF0aGlldS0tZHJpZkBldmlkZW4uY29tPg0KPg0KPlZURElPVExCUGFnZUludkluZm8ubWFz
ayBtaWdodCBub3QgZml0IGluIGFuIHVpbnQ4X3QuDQo+TW9yZW92ZXIsIHRoaXMgZmllbGQgaXMg
dXNlZCBpbiBiaW5hcnkgb3BlcmF0aW9ucyB3aXRoIDY0LWJpdCBhZGRyZXNzZXMuDQo+DQo+U2ln
bmVkLW9mZi1ieTogQ2zDqW1lbnQgTWF0aGlldS0tRHJpZiA8Y2xlbWVudC5tYXRoaWV1LS1kcmlm
QGV2aWRlbi5jb20+DQoNClJldmlld2VkLWJ5OiBaaGVuemhvbmcgRHVhbiA8emhlbnpob25nLmR1
YW5AaW50ZWwuY29tPg0KDQpUaGFua3MNClpoZW56aG9uZw0KDQo+LS0tDQo+IGh3L2kzODYvaW50
ZWxfaW9tbXVfaW50ZXJuYWwuaCB8IDIgKy0NCj4gMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9u
KCspLCAxIGRlbGV0aW9uKC0pDQo+DQo+ZGlmZiAtLWdpdCBhL2h3L2kzODYvaW50ZWxfaW9tbXVf
aW50ZXJuYWwuaA0KPmIvaHcvaTM4Ni9pbnRlbF9pb21tdV9pbnRlcm5hbC5oDQo+aW5kZXggY2Jj
NDAzMDAzMS4uNWZjYmUyNzQ0ZiAxMDA2NDQNCj4tLS0gYS9ody9pMzg2L2ludGVsX2lvbW11X2lu
dGVybmFsLmgNCj4rKysgYi9ody9pMzg2L2ludGVsX2lvbW11X2ludGVybmFsLmgNCj5AQCAtNDM2
LDcgKzQzNiw3IEBAIHN0cnVjdCBWVERJT1RMQlBhZ2VJbnZJbmZvIHsNCj4gICAgIHVpbnQxNl90
IGRvbWFpbl9pZDsNCj4gICAgIHVpbnQzMl90IHBhc2lkOw0KPiAgICAgdWludDY0X3QgYWRkcjsN
Cj4tICAgIHVpbnQ4X3QgbWFzazsNCj4rICAgIHVpbnQ2NF90IG1hc2s7DQo+IH07DQo+IHR5cGVk
ZWYgc3RydWN0IFZURElPVExCUGFnZUludkluZm8gVlRESU9UTEJQYWdlSW52SW5mbzsNCj4NCj4t
LQ0KPjIuNDUuMg0K

