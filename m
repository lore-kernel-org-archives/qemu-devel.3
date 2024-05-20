Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0B1BC25B75
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2024 03:12:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s8tRF-0002sA-Eu; Sun, 19 May 2024 23:11:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1s8tRD-0002rw-Jv
 for qemu-devel@nongnu.org; Sun, 19 May 2024 23:11:47 -0400
Received: from mgamail.intel.com ([192.198.163.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1s8tRA-0002y4-2l
 for qemu-devel@nongnu.org; Sun, 19 May 2024 23:11:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1716174704; x=1747710704;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=u/Hu4Sucu0tQ7G+yLOoEFIOLKqMsnETRmzNhdUGyAUk=;
 b=mX6/bwZK8m8H316mrDShTr8Ct4vKku7u674id5aHgnG6vf6nsOaTuLJ9
 eSnbQi5wTeFw9VC5bREctL/wNqaGmBMszS1B7zRPIpm+mRslr1mWxUlM0
 pbl9uJ+xAfc6UchpPX/Fz+qQEbF/OoPwIHiilG7CUuvJG6Ff+m4xvGHVR
 rBNwBdSBnhMBfOK0DTYieBF680DAIG61gxuzvPRJq3iQp2PcYYzH8MzOM
 GxFgZTH3V+FG8ztxqvf1Cs/52COxCQqnzaKayoalv4v5Zty56OSGK0a2z
 0AQwPkJ424X2JS6HSZnsMKX/iqoS+bW/R1qqJSiVgjPEBf2oDUZ+S17HD Q==;
X-CSE-ConnectionGUID: H1DDSWv9Q3utiWSg184fPA==
X-CSE-MsgGUID: QMEmTWAKT5CuczLNi1IJBw==
X-IronPort-AV: E=McAfee;i="6600,9927,11077"; a="22955547"
X-IronPort-AV: E=Sophos;i="6.08,174,1712646000"; d="scan'208";a="22955547"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 May 2024 20:11:37 -0700
X-CSE-ConnectionGUID: EuHMwhwnSKW26gOxhXeEiQ==
X-CSE-MsgGUID: z35jhOZ7ReWjXgqnL54+0A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,174,1712646000"; d="scan'208";a="32526562"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
 by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 19 May 2024 20:11:36 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 19 May 2024 20:11:35 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Sun, 19 May 2024 20:11:35 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.41) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Sun, 19 May 2024 20:11:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KKj8FjUVVOQtcFN2D7YbYuMcAlmuyjEkBDwtSCO5qiwUf2bm+NODVwH0feGokltCV6tefa6XpYQ+hrdyphjUaOjrMBsdL58nO/EQMliYRQ69l3yWeHyfGAZHA00pxeNoS0RRG2vHssgRslvBUz62/hO7tVihvMtAZ/qanSUeaD5gv+edsVeUYQzhqGXy7JbsvMC5t5b7OIvaInHFTXZtgcbekEmODwE/P5QZ1k/e5Iq+YH/U1zXqMPkf8WZHIEpoe2MexdwtvIyxjKNuj85EVh80qespxspIcT105ocRooyx2URSfEpfmUh6lBO7BwVv0i0N6Sk2ClfoyenkyjBk8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u/Hu4Sucu0tQ7G+yLOoEFIOLKqMsnETRmzNhdUGyAUk=;
 b=CsGZ2z1N01F/MrFzjcUw2Gr/JL3IsyzDqFbVQmrCiKD2K2Jsa6PBUYyTF+Wpw+NGwVYgThVhBJYEdNTH1OKXP6MOMvvu05eOPQ0PSSkTE+wuvGPo66Y0iQw33jEF8pK8E9MHo+anPKw7BLQSwwXTnPfVvH5NH0xsu//M0PaCbbuc7zZH/hUxKymafCRMixFVGc1QZ2NGAmtiIi1HjhObJuflgb4NG1sQo9TxxoIARKekFEwWb2NI5NKzlIdw1hVgvCP73+XcxtCN9pUURV+ey6kzZavjlVmsBq1tR1IwqWEmzul+UpRbq6aDYUumKzy5MNeqQvnkvFfPJ5b5Hg2PzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by SJ0PR11MB5087.namprd11.prod.outlook.com (2603:10b6:a03:2ad::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.36; Mon, 20 May
 2024 03:11:33 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::21df:af3:be1d:722e]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::21df:af3:be1d:722e%4]) with mapi id 15.20.7587.030; Mon, 20 May 2024
 03:11:33 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: "Liu, Yi L" <yi.l.liu@intel.com>, CLEMENT MATHIEU--DRIF
 <clement.mathieu--drif@eviden.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "Peng, Chao P" <chao.p.peng@intel.com>, Yu Zhang
 <yu.c.zhang@linux.intel.com>, "Michael S. Tsirkin" <mst@redhat.com>, "Jason
 Wang" <jasowang@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "Richard
 Henderson" <richard.henderson@linaro.org>, Eduardo Habkost
 <eduardo@habkost.net>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: RE: [PATCH] intel_iommu: Use the latest fault reasons defined by spec
Thread-Topic: [PATCH] intel_iommu: Use the latest fault reasons defined by spec
Thread-Index: AQHaqESnRiGl1jiq20uiRV0AFydhKrGbZ2+AgAKdFYCAAXEC4A==
Date: Mon, 20 May 2024 03:11:33 +0000
Message-ID: <SJ0PR11MB6744C35C1ACDA0DA9639E6C392E92@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20240517102334.81943-1-zhenzhong.duan@intel.com>
 <02ee8c65-54a8-4ce4-a4a0-351f29f3eea6@eviden.com>
 <DS0PR11MB75299A30E22AE7CC768CEB64C3E82@DS0PR11MB7529.namprd11.prod.outlook.com>
In-Reply-To: <DS0PR11MB75299A30E22AE7CC768CEB64C3E82@DS0PR11MB7529.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|SJ0PR11MB5087:EE_
x-ms-office365-filtering-correlation-id: 37c1c4ea-b4f9-4044-b58b-08dc787a8db7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|366007|1800799015|376005|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?RURsNG1FejBVUnJjWXEyU25iRWhWTFFkT2kyN1Y3b29XUWkzWWl6Nm1nKzBr?=
 =?utf-8?B?Ry91a2RsTm4vZktiOEJBb0lTQ2JNVDE0eXJab294RklnL243U0tsODl0WGdv?=
 =?utf-8?B?eXdJSVp2aTFXSUluaGZ0NFFYa3Bkc0dhQzl6SUkwaTlBVGJLWmhEeEpZckdk?=
 =?utf-8?B?QktmZ01lUjNSZ3MwMXlJYktpTVpyQ0FtZ1hrK1VLTEVXRktrR0g1Y2RHdk5h?=
 =?utf-8?B?dGNwUFNoNDNDYXFpdHE2UXVkOC96cXc1RE1zSDFZNXFteENpN0FXTkE5UEwv?=
 =?utf-8?B?RWlYYnRPczV4Y0NYOG85bWRZK2Z5V2JFREcrbzVWMHhNZ1RmbnI1WW1jTzM1?=
 =?utf-8?B?WHI5UlQxNFBXYy9SZ3ZRVkxMZmZBUkJRQ0pCMG1VU2ZyYi91T1FwMzNtS205?=
 =?utf-8?B?Q0pQa0k1WHB3RTBrM2lxZ3lFT2RER2xHUlV1cHhiVkFWZEdocnIwRXIyMWNq?=
 =?utf-8?B?bk9KWU9JTkNiMnN4QTVxNXVGWXBKTnRPbTNOdzhIbldWSTJaUzE5Rzh0NExJ?=
 =?utf-8?B?b1FtL09scWYvTkp3NDhpWDRWYlVuQlZEOHdMWlc3UHlHYURpOVZXTFMzOSs3?=
 =?utf-8?B?SUFSdVlUN2ZzMDF1dFNXWTBsU0JvblBZZUpDMHFjR0ltOTluNXVHTTJPRzRV?=
 =?utf-8?B?NjR4Q21tc0w5Q2kxTXJ6Znptay9ZNDZDWldHWnlURXFOSXcvTndtejJOeEtR?=
 =?utf-8?B?VFhiYXpTR3lmUG5YZmljS2VCTUZXVFdJa0JwQSt6Vm5OUTRlSlBybW1vQW1s?=
 =?utf-8?B?MG5JcnFxOUtSTUZ0ZXFCbFpNZE1xTDJTZVJVUkd4MWRLTmkvQ3h4R1dYclJG?=
 =?utf-8?B?YXN6VGFGcUhTdTZNRmF6MHlLZnlxSE1aZVNYWEJZZnFMbnVRdXBESmVidWZm?=
 =?utf-8?B?TEtPYnZMVGI3dFV2NlhOT1RzVFRweHVGaytabWNvcHMydDF5V1hOY1RjaVdt?=
 =?utf-8?B?bWw3eXJsTDAzYVBGN0w3SnNxaU85WXhxSm85ekdVY3Q3WHVTNlhtZlZZQ3kz?=
 =?utf-8?B?SzdxNFh5MWpHTFJlNUxBUEZOTG5majh2UWgybWI1QXJBTUZiekl4SitmTFY4?=
 =?utf-8?B?NDBiWkVnR1JDM2syaUg2bU4yOHVZRm1ieUZzclkrNGJIS1dCUk5YTWFJZmV5?=
 =?utf-8?B?YU53cWV4QUc3ekU2dmJXdjN3Mms5ek5aV2kxOE00SXVHamxoQ0dodHMvaHEx?=
 =?utf-8?B?R3IydGhET0c4YWp4S1Z1ZTdBRGVSVkIwQ0lUaFlPbnNPTkRpbVQ4L1pUZzdk?=
 =?utf-8?B?cW0vMHkrQVFOc3ZtS241Q3pSN0hobUcwbDlBNzlmelZObXdaSTZvR2wwTDJM?=
 =?utf-8?B?RHZkUkRlK0J4U1kyeWNmY3BHeDVJVlBvQm5wVWZWd0lWNHROUVpaUnBGZXht?=
 =?utf-8?B?MHQ2TERjdGpGU1U3OGc1TFJkbEE0TjBKTW9QZkNhbHJGZituOWZmRXZvaVhV?=
 =?utf-8?B?dUxHUVpKbkViTnZlSjY5ZXFnTmFTQU4zZXdibFNlN0hQRUNXajV3b0ZVZkhp?=
 =?utf-8?B?V0hzWSt2dmFGNkRTczlyK1N0U3JJdEFlaW1aNkp5ZkFwZlVKWm82eVZZaks4?=
 =?utf-8?B?aUc2cWZaN0hWV2lmeElqK2kwUGJ1WnkzRE1FMTZJV3R2RkRob2cvaDQxM1Nh?=
 =?utf-8?B?K0FFWi9CRjM3NkFOUUZWTm1Qa2s5YVhwb244UUhzcHBHQW1Jbi93V2Y2ajF1?=
 =?utf-8?B?aHpXeHUzc2dIRTE5ZnJsY0ZpNEtiYW9pRElvbW9mUmRLcGUraGFVWmo5b205?=
 =?utf-8?B?T1d6czUwY0JxQlhtR1FtZElVMi9lU295OU9QZzEzNTh5VkZva0VIcUtWV05x?=
 =?utf-8?B?ZE1YNWhKRnV6YjNvaXBkZz09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(376005)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WHNiSFZXUkl4TlE4K2xHTzB6QWlDbExBbGYvb0RIS0VnOGNSODkvckszVXhN?=
 =?utf-8?B?aVFjT1A1dnlCVDJlY2t6clpkbmpNTzM0bHBDdm1xcUtDRGVXTDNDUU9yNEJh?=
 =?utf-8?B?Z3pPZVByWHk0dG1mQllUNUUyajRETUIvZVdQOGlkZndHS0M2eVd4RXRlVmRj?=
 =?utf-8?B?K0dtbnVtRTJLeUV5ZU91MC9TakJGVjF4bmlQUk9uZzhncE55cTBWbEN2TGNs?=
 =?utf-8?B?bHpKNmRvaS90dGRVSDQ2NWIyTmI4d3k1NlhVYStuMjdqVTQ3TFJnSFIxTmVS?=
 =?utf-8?B?VFRlZUp4QXU5S1oyQjRXSWl5TVBTbERhVVVIOUVHakFSNnNXVzR0Q3RHZ3lY?=
 =?utf-8?B?SlBMZ0lsekxrSU1Tc2s4UDVUWXpCZGZOSkd6VUQrbUpjbDBzdFdsZWFtWjVK?=
 =?utf-8?B?SHpqWEVBSlVKWFdqVmFzRlJoZ3M4dEtEeHRVSG5qRWRHMmxYMll0Z2dkTlhI?=
 =?utf-8?B?VUN1YUlyRG5qZkFDYU9DYWNGaExBN2dXZ2J1bUZZUGlKNEdNMm9IMDRRWGpq?=
 =?utf-8?B?YWRhQXNIeVJ0TTBwT0dWRFFjNFkrOGp3UTZYTDBZUUFOdy8rZENYL29hNVB1?=
 =?utf-8?B?U3dsZkpFcDlCSDhUUjBBb0VpMEd1VlI2QVF1S2pXNzdlT3FsN1hkaFpkRnI5?=
 =?utf-8?B?VEE4VjBIM21NYkpNdjhnUVJ1R0JVQ2VEVU1raEVkTFdiV254cVI4UkNkMXJD?=
 =?utf-8?B?L1RmNFRhVVFMdng1dVNtZXBqQVBJMUZEU041NUdGUldXaUs4aThkV3Q5dVl6?=
 =?utf-8?B?TzI0VkZ4c2NrWGpEV3RqNlFOTWhxSFRiMXg2TE9NV29tTEQ1Q25ya1dWTDVC?=
 =?utf-8?B?bkg5L2x3RWQyTWFWUHJ2ZlV4eVBqS2hiWHhSMFVDQ1JPdEdOYTgyUU5HQ3U1?=
 =?utf-8?B?UFYwb05lV2UyaHhuV1llM1RzQktUYmYvRXpwK0trQkh0d3NRNmJaTjNOdXNH?=
 =?utf-8?B?b2p6Rk1nRVlQWm5TUFV3L0JMYTNXVzlsK3RwS2FzMUs1Z3kwQUx3NTR4b2NT?=
 =?utf-8?B?S0hndm1VTStkckpFbVJuOFIzSGxTZjRxWk9mU3p1WUUveWlHbE9YYSt6WXR6?=
 =?utf-8?B?S00zTmIzS2NCV251TktEaXpwM3BXNmVRekpTK054MTgrY3NqMWlDRzU4RDdt?=
 =?utf-8?B?eXRNdENPWGRrczBhQ3ZRSENyeGVaM3U0Q1hyajFMd2ZLdVpxSWhQV3FYVXRT?=
 =?utf-8?B?SW1UYk9Pd2pyc0ZIWTZ3Vkw5RitTRkV6NkN4b1EzZ0Iza0dvSExtSTcwOVh5?=
 =?utf-8?B?YjhwakV0eUkvUWxCVHhJNDdzSWhkYzY3OUk5djRTK2JNcC9iZ2NEMGN4YUxL?=
 =?utf-8?B?ZFU2NmVKZWdVWm1ON2pvRjZpTlRxTm15ZTBEa1djbGFYSEo4TE1LTm4reFI5?=
 =?utf-8?B?M1pXU1pBeDdPNExNWWdKN1d1cGVSb1dSMHBIbU45N0p0ZSsvVzI5MUsvTWZ0?=
 =?utf-8?B?cksvaHdudWtyVmtodk5GL3lDalRkeDFGd0hBb0pKbXVoSm5DQTVSSHFERWRX?=
 =?utf-8?B?L2MwaUFha3AxSlgwSlR6ZkZLL3B5UVByQkEvdWRtNkF4cVNKYnIvQXZQMXc1?=
 =?utf-8?B?ZEZUcFpkdFZyMFdNdUpKajQ0RUlxTjJRYzF4Z0ZTbVVkc2hSbjYxY3VpZWJJ?=
 =?utf-8?B?NXFpK3l3eGkxQXVMRTlzNk82bENESGR4ZG56dFJKT08xUVpBNjk3YzcxMENI?=
 =?utf-8?B?L1BtT0RuL1gybWpGSzdQdGZnamcwcTE1OG1TYitmUWZaMDNJbHQvek5WMFEr?=
 =?utf-8?B?TVY5UEVLWXdhMk5SRkNyTXJaMVl3aUVvRkRMTXVIdm1vam1YTFNQVTRjRlNE?=
 =?utf-8?B?aENQKzBLTHBnWmdJOUVJbllXVnByU29YUkF0WWphNnh3bjNrT0JZeDhIRG45?=
 =?utf-8?B?bjZQRWkyOGhOa3Y4SGdVbFRnOHplY2RCTVZ1ZTBPZ3JsQlZqOXMxRjRBQWxX?=
 =?utf-8?B?QWN5eU1BM1hNMG9hR3R4dkRTVUs1WlpXc3B3SElmY3NaUGNyRUNMQllmRVFu?=
 =?utf-8?B?cVJZeVhHTEZhcG51aERkSkZHM09ka2lEUkVINUVOTmJiVXZxa0dSS3N6YURy?=
 =?utf-8?B?QStYZGVybVBVMjFIVzUxMXJFMjhpZUZPY284d21ucCtzVVk2elloZkdwU1hR?=
 =?utf-8?Q?Hc9M7cY2xlV/4pvZiJeh0ddpR?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37c1c4ea-b4f9-4044-b58b-08dc787a8db7
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 May 2024 03:11:33.8230 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2LXVeRSgmSEIWJ4kcvFS1gTesLgFPSLxY0SlhpV10kEqepTgrwOYYRIGh3FI4Fxo42mkqtlGodyZ9za52fZ2w3CN2UKGrHsKBQpYxxxpmIA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5087
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.9;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.383,
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IExpdSwgWWkgTCA8eWkubC5s
aXVAaW50ZWwuY29tPg0KPlN1YmplY3Q6IFJFOiBbUEFUQ0hdIGludGVsX2lvbW11OiBVc2UgdGhl
IGxhdGVzdCBmYXVsdCByZWFzb25zIGRlZmluZWQgYnkNCj5zcGVjDQo+DQo+PiBGcm9tOiBDTEVN
RU5UIE1BVEhJRVUtLURSSUYgPGNsZW1lbnQubWF0aGlldS0tZHJpZkBldmlkZW4uY29tPg0KPj4g
U2VudDogRnJpZGF5LCBNYXkgMTcsIDIwMjQgOToxMyBQTQ0KPj4NCj4+IEhpIFpoZW56aG9uZw0K
Pj4NCj4+IE9uIDE3LzA1LzIwMjQgMTI6MjMsIFpoZW56aG9uZyBEdWFuIHdyb3RlOg0KPj4gPiBD
YXV0aW9uOiBFeHRlcm5hbCBlbWFpbC4gRG8gbm90IG9wZW4gYXR0YWNobWVudHMgb3IgY2xpY2sg
bGlua3MsIHVubGVzcw0KPnRoaXMgZW1haWwNCj4+IGNvbWVzIGZyb20gYSBrbm93biBzZW5kZXIg
YW5kIHlvdSBrbm93IHRoZSBjb250ZW50IGlzIHNhZmUuDQo+PiA+DQo+PiA+DQo+PiA+IEZyb206
IFl1IFpoYW5nIDx5dS5jLnpoYW5nQGxpbnV4LmludGVsLmNvbT4NCj4+ID4NCj4+ID4gQ3VycmVu
dGx5IHdlIHVzZSBvbmx5IFZURF9GUl9QQVNJRF9UQUJMRV9JTlYgYXMgZmF1bHQgcmVhc29uLg0K
Pj4gPiBVcGRhdGUgd2l0aCBtb3JlIGRldGFpbGVkIGZhdWx0IHJlYXNvbnMgbGlzdGVkIGluIFZU
LWQgc3BlYyA3LjIuMy4NCj4+ID4NCj4+ID4gU2lnbmVkLW9mZi1ieTogWXUgWmhhbmcgPHl1LmMu
emhhbmdAbGludXguaW50ZWwuY29tPg0KPj4gPiBTaWduZWQtb2ZmLWJ5OiBaaGVuemhvbmcgRHVh
biA8emhlbnpob25nLmR1YW5AaW50ZWwuY29tPg0KPj4gPiAtLS0NCj4+ID4gICBody9pMzg2L2lu
dGVsX2lvbW11X2ludGVybmFsLmggfCAgOCArKysrKysrLQ0KPj4gPiAgIGh3L2kzODYvaW50ZWxf
aW9tbXUuYyAgICAgICAgICB8IDI1ICsrKysrKysrKysrKysrKystLS0tLS0tLS0NCj4+ID4gICAy
IGZpbGVzIGNoYW5nZWQsIDIzIGluc2VydGlvbnMoKyksIDEwIGRlbGV0aW9ucygtKQ0KPj4gPg0K
Pj4gPiBkaWZmIC0tZ2l0IGEvaHcvaTM4Ni9pbnRlbF9pb21tdV9pbnRlcm5hbC5oDQo+Yi9ody9p
Mzg2L2ludGVsX2lvbW11X2ludGVybmFsLmgNCj4+ID4gaW5kZXggZjhjZjk5YmRkZi4uNjY2ZTJj
ZjJjZSAxMDA2NDQNCj4+ID4gLS0tIGEvaHcvaTM4Ni9pbnRlbF9pb21tdV9pbnRlcm5hbC5oDQo+
PiA+ICsrKyBiL2h3L2kzODYvaW50ZWxfaW9tbXVfaW50ZXJuYWwuaA0KPj4gPiBAQCAtMzExLDcg
KzMxMSwxMyBAQCB0eXBlZGVmIGVudW0gVlRERmF1bHRSZWFzb24gew0KPj4gPiAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAqIHJlcXVlc3Qgd2hpbGUgZGlzYWJsZWQgKi8NCj4+
ID4gICAgICAgVlREX0ZSX0lSX1NJRF9FUlIgPSAweDI2LCAgIC8qIEludmFsaWQgU291cmNlLUlE
ICovDQo+PiA+DQo+PiA+IC0gICAgVlREX0ZSX1BBU0lEX1RBQkxFX0lOViA9IDB4NTgsICAvKklu
dmFsaWQgUEFTSUQgdGFibGUgZW50cnkgKi8NCj4+ID4gKyAgICAvKiBQQVNJRCBkaXJlY3Rvcnkg
ZW50cnkgYWNjZXNzIGZhaWx1cmUgKi8NCj4+ID4gKyAgICBWVERfRlJfUEFTSURfRElSX0FDQ0VT
U19FUlIgPSAweDUwLA0KPj4gPiArICAgIC8qIFRoZSBQcmVzZW50KFApIGZpZWxkIG9mIHBhc2lk
IGRpcmVjdG9yeSBlbnRyeSBpcyAwICovDQo+PiA+ICsgICAgVlREX0ZSX1BBU0lEX0RJUl9FTlRS
WV9QID0gMHg1MSwNCj4+ID4gKyAgICBWVERfRlJfUEFTSURfVEFCTEVfQUNDRVNTX0VSUiA9IDB4
NTgsIC8qIFBBU0lEIHRhYmxlIGVudHJ5DQo+YWNjZXNzIGZhaWx1cmUgKi8NCj4+ID4gKyAgICBW
VERfRlJfUEFTSURfRU5UUllfUCA9IDB4NTksIC8qIFRoZSBQcmVzZW50KFApIGZpZWxkIG9mIHBh
c2lkdC0NCj5lbnRyeSBpcyAwICovDQo+PiBzL3Bhc2lkdC9wYXNpZA0KPg0KPlBlciBzcGVjLCBp
dCBpcyBwYXNpZCB0YWJsZSBlbnRyeS4gU28gWmhlbnpob25nIG1heSBuZWVkIHRvIHVzZSB0aGUg
c2FtZQ0KPndvcmQNCj5XaXRoIHRoZSBsaW5lIGJlbG93LiBFLmcuIFBBU0lEIFRhYmxlIGVudHJ5
Lg0KDQpZZXMsIHdpbGwgZml4Lg0KDQpUaGFua3MNClpoZW56aG9uZw0KDQo+DQo+UmVnYXJkcywN
Cj5ZaSBMaXUNCj4NCj4+ID4gKyAgICBWVERfRlJfUEFTSURfVEFCTEVfRU5UUllfSU5WID0gMHg1
YiwgIC8qSW52YWxpZCBQQVNJRCB0YWJsZQ0KPmVudHJ5ICovDQo+PiA+DQo+PiA+ICAgICAgIC8q
IE91dHB1dCBhZGRyZXNzIGluIHRoZSBpbnRlcnJ1cHQgYWRkcmVzcyByYW5nZSBmb3Igc2NhbGFi
bGUgbW9kZQ0KPiovDQo+PiA+ICAgICAgIFZURF9GUl9TTV9JTlRFUlJVUFRfQUREUiA9IDB4ODcs
DQo+PiA+IGRpZmYgLS1naXQgYS9ody9pMzg2L2ludGVsX2lvbW11LmMgYi9ody9pMzg2L2ludGVs
X2lvbW11LmMNCj4+ID4gaW5kZXggY2M4ZTU5Njc0ZS4uMDk1MWViYjcxZCAxMDA2NDQNCj4+ID4g
LS0tIGEvaHcvaTM4Ni9pbnRlbF9pb21tdS5jDQo+PiA+ICsrKyBiL2h3L2kzODYvaW50ZWxfaW9t
bXUuYw0KPj4gPiBAQCAtNzcxLDcgKzc3MSw3IEBAIHN0YXRpYyBpbnQNCj52dGRfZ2V0X3BkaXJl
X2Zyb21fcGRpcl90YWJsZShkbWFfYWRkcl90DQo+PiBwYXNpZF9kaXJfYmFzZSwNCj4+ID4gICAg
ICAgYWRkciA9IHBhc2lkX2Rpcl9iYXNlICsgaW5kZXggKiBlbnRyeV9zaXplOw0KPj4gPiAgICAg
ICBpZiAoZG1hX21lbW9yeV9yZWFkKCZhZGRyZXNzX3NwYWNlX21lbW9yeSwgYWRkciwNCj4+ID4g
ICAgICAgICAgICAgICAgICAgICAgICAgICBwZGlyZSwgZW50cnlfc2l6ZSwgTUVNVFhBVFRSU19V
TlNQRUNJRklFRCkpIHsNCj4+ID4gLSAgICAgICAgcmV0dXJuIC1WVERfRlJfUEFTSURfVEFCTEVf
SU5WOw0KPj4gPiArICAgICAgICByZXR1cm4gLVZURF9GUl9QQVNJRF9ESVJfQUNDRVNTX0VSUjsN
Cj4+ID4gICAgICAgfQ0KPj4gPg0KPj4gPiAgICAgICBwZGlyZS0+dmFsID0gbGU2NF90b19jcHUo
cGRpcmUtPnZhbCk7DQo+PiA+IEBAIC03ODksNiArNzg5LDcgQEAgc3RhdGljIGludA0KPnZ0ZF9n
ZXRfcGVfaW5fcGFzaWRfbGVhZl90YWJsZShJbnRlbElPTU1VU3RhdGUNCj4+ICpzLA0KPj4gPiAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGRtYV9hZGRyX3QgYWRk
ciwNCj4+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBWVERQ
QVNJREVudHJ5ICpwZSkNCj4+ID4gICB7DQo+PiA+ICsgICAgdWludDhfdCBwZ3R0Ow0KPj4gPiAg
ICAgICB1aW50MzJfdCBpbmRleDsNCj4+ID4gICAgICAgZG1hX2FkZHJfdCBlbnRyeV9zaXplOw0K
Pj4gPiAgICAgICBYODZJT01NVVN0YXRlICp4ODZfaW9tbXUgPSBYODZfSU9NTVVfREVWSUNFKHMp
Ow0KPj4gPiBAQCAtNzk4LDcgKzc5OSw3IEBAIHN0YXRpYyBpbnQNCj52dGRfZ2V0X3BlX2luX3Bh
c2lkX2xlYWZfdGFibGUoSW50ZWxJT01NVVN0YXRlDQo+PiAqcywNCj4+ID4gICAgICAgYWRkciA9
IGFkZHIgKyBpbmRleCAqIGVudHJ5X3NpemU7DQo+PiA+ICAgICAgIGlmIChkbWFfbWVtb3J5X3Jl
YWQoJmFkZHJlc3Nfc3BhY2VfbWVtb3J5LCBhZGRyLA0KPj4gPiAgICAgICAgICAgICAgICAgICAg
ICAgICAgIHBlLCBlbnRyeV9zaXplLCBNRU1UWEFUVFJTX1VOU1BFQ0lGSUVEKSkgew0KPj4gPiAt
ICAgICAgICByZXR1cm4gLVZURF9GUl9QQVNJRF9UQUJMRV9JTlY7DQo+PiA+ICsgICAgICAgIHJl
dHVybiAtVlREX0ZSX1BBU0lEX1RBQkxFX0FDQ0VTU19FUlI7DQo+PiA+ICAgICAgIH0NCj4+ID4g
ICAgICAgZm9yIChzaXplX3QgaSA9IDA7IGkgPCBBUlJBWV9TSVpFKHBlLT52YWwpOyBpKyspIHsN
Cj4+ID4gICAgICAgICAgIHBlLT52YWxbaV0gPSBsZTY0X3RvX2NwdShwZS0+dmFsW2ldKTsNCj4+
ID4gQEAgLTgwNiwxMSArODA3LDEzIEBAIHN0YXRpYyBpbnQNCj52dGRfZ2V0X3BlX2luX3Bhc2lk
X2xlYWZfdGFibGUoSW50ZWxJT01NVVN0YXRlDQo+PiAqcywNCj4+ID4NCj4+ID4gICAgICAgLyog
RG8gdHJhbnNsYXRpb24gdHlwZSBjaGVjayAqLw0KPj4gPiAgICAgICBpZiAoIXZ0ZF9wZV90eXBl
X2NoZWNrKHg4Nl9pb21tdSwgcGUpKSB7DQo+PiA+IC0gICAgICAgIHJldHVybiAtVlREX0ZSX1BB
U0lEX1RBQkxFX0lOVjsNCj4+ID4gKyAgICAgICAgcmV0dXJuIC1WVERfRlJfUEFTSURfVEFCTEVf
RU5UUllfSU5WOw0KPj4gPiAgICAgICB9DQo+PiA+DQo+PiA+IC0gICAgaWYgKCF2dGRfaXNfbGV2
ZWxfc3VwcG9ydGVkKHMsIFZURF9QRV9HRVRfTEVWRUwocGUpKSkgew0KPj4gPiAtICAgICAgICBy
ZXR1cm4gLVZURF9GUl9QQVNJRF9UQUJMRV9JTlY7DQo+PiA+ICsgICAgcGd0dCA9IFZURF9QRV9H
RVRfVFlQRShwZSk7DQo+PiA+ICsgICAgaWYgKHBndHQgPT0gVlREX1NNX1BBU0lEX0VOVFJZX1NM
VCAmJg0KPj4gPiArICAgICAgICAhdnRkX2lzX2xldmVsX3N1cHBvcnRlZChzLCBWVERfUEVfR0VU
X0xFVkVMKHBlKSkpIHsNCj4+ID4gKyAgICAgICAgICAgIHJldHVybiAtVlREX0ZSX1BBU0lEX1RB
QkxFX0VOVFJZX0lOVjsNCj4+ID4gICAgICAgfQ0KPj4gPg0KPj4gPiAgICAgICByZXR1cm4gMDsN
Cj4+ID4gQEAgLTg1MSw3ICs4NTQsNyBAQCBzdGF0aWMgaW50DQo+dnRkX2dldF9wZV9mcm9tX3Bh
c2lkX3RhYmxlKEludGVsSU9NTVVTdGF0ZSAqcywNCj4+ID4gICAgICAgfQ0KPj4gPg0KPj4gPiAg
ICAgICBpZiAoIXZ0ZF9wZGlyZV9wcmVzZW50KCZwZGlyZSkpIHsNCj4+ID4gLSAgICAgICAgcmV0
dXJuIC1WVERfRlJfUEFTSURfVEFCTEVfSU5WOw0KPj4gPiArICAgICAgICByZXR1cm4gLVZURF9G
Ul9QQVNJRF9ESVJfRU5UUllfUDsNCj4+ID4gICAgICAgfQ0KPj4gPg0KPj4gPiAgICAgICByZXQg
PSB2dGRfZ2V0X3BlX2Zyb21fcGRpcmUocywgcGFzaWQsICZwZGlyZSwgcGUpOw0KPj4gPiBAQCAt
ODYwLDcgKzg2Myw3IEBAIHN0YXRpYyBpbnQNCj52dGRfZ2V0X3BlX2Zyb21fcGFzaWRfdGFibGUo
SW50ZWxJT01NVVN0YXRlICpzLA0KPj4gPiAgICAgICB9DQo+PiA+DQo+PiA+ICAgICAgIGlmICgh
dnRkX3BlX3ByZXNlbnQocGUpKSB7DQo+PiA+IC0gICAgICAgIHJldHVybiAtVlREX0ZSX1BBU0lE
X1RBQkxFX0lOVjsNCj4+ID4gKyAgICAgICAgcmV0dXJuIC1WVERfRlJfUEFTSURfRU5UUllfUDsN
Cj4+ID4gICAgICAgfQ0KPj4gPg0KPj4gPiAgICAgICByZXR1cm4gMDsNCj4+ID4gQEAgLTkxMyw3
ICs5MTYsNyBAQCBzdGF0aWMgaW50DQo+dnRkX2NlX2dldF9wYXNpZF9mcGQoSW50ZWxJT01NVVN0
YXRlICpzLA0KPj4gPiAgICAgICB9DQo+PiA+DQo+PiA+ICAgICAgIGlmICghdnRkX3BkaXJlX3By
ZXNlbnQoJnBkaXJlKSkgew0KPj4gPiAtICAgICAgICByZXR1cm4gLVZURF9GUl9QQVNJRF9UQUJM
RV9JTlY7DQo+PiA+ICsgICAgICAgIHJldHVybiAtVlREX0ZSX1BBU0lEX0RJUl9FTlRSWV9QOw0K
Pj4gPiAgICAgICB9DQo+PiA+DQo+PiA+ICAgICAgIC8qDQo+PiA+IEBAIC0xNzcwLDcgKzE3NzMs
MTEgQEAgc3RhdGljIGNvbnN0IGJvb2wgdnRkX3F1YWxpZmllZF9mYXVsdHNbXSA9IHsNCj4+ID4g
ICAgICAgW1ZURF9GUl9ST09UX0VOVFJZX1JTVkRdID0gZmFsc2UsDQo+PiA+ICAgICAgIFtWVERf
RlJfUEFHSU5HX0VOVFJZX1JTVkRdID0gdHJ1ZSwNCj4+ID4gICAgICAgW1ZURF9GUl9DT05URVhU
X0VOVFJZX1RUXSA9IHRydWUsDQo+PiA+IC0gICAgW1ZURF9GUl9QQVNJRF9UQUJMRV9JTlZdID0g
ZmFsc2UsDQo+PiA+ICsgICAgW1ZURF9GUl9QQVNJRF9ESVJfQUNDRVNTX0VSUl0gPSBmYWxzZSwN
Cj4+ID4gKyAgICBbVlREX0ZSX1BBU0lEX0RJUl9FTlRSWV9QXSA9IHRydWUsDQo+PiA+ICsgICAg
W1ZURF9GUl9QQVNJRF9UQUJMRV9BQ0NFU1NfRVJSXSA9IGZhbHNlLA0KPj4gPiArICAgIFtWVERf
RlJfUEFTSURfRU5UUllfUF0gPSB0cnVlLA0KPj4gPiArICAgIFtWVERfRlJfUEFTSURfVEFCTEVf
RU5UUllfSU5WXSA9IHRydWUsDQo+PiA+ICAgICAgIFtWVERfRlJfU01fSU5URVJSVVBUX0FERFJd
ID0gdHJ1ZSwNCj4+ID4gICAgICAgW1ZURF9GUl9NQVhdID0gZmFsc2UsDQo+PiA+ICAgfTsNCj4+
ID4gLS0NCj4+ID4gMi4zNC4xDQo+PiA+DQo+PiA+DQo+PiBsZ3RtDQo=

