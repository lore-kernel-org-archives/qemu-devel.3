Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AECDC369AB
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 02:25:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u88kW-00065Q-6i; Thu, 24 Apr 2025 22:25:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1u88kR-000653-Sx
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 22:25:04 -0400
Received: from mgamail.intel.com ([192.198.163.8])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1u88kP-0001v6-5U
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 22:25:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1745547901; x=1777083901;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=1PWZAIJonFLkNI2xxb7qU4TTpoAHzFWbUm93GCyrfZ4=;
 b=Q/omFd2dViv/EEL2DasMpEHp8Jnum4bgrFnceJT0v8prPoGXdXgsaYar
 C/xiLuhYMZ1p0x1oAGC/B1/0k7U49NSfb7YaJs0ik5CXwZ5OOLoVj0K1P
 R1Iscpzf1K36UnX7sIlPGjAoL3oEjKGc8aDsa5lQQ+O7KcpAKnKjzv4N2
 4GcIXF6kYEwG9QXwJq+eLMQt+y07tTUI5r3FNYxWTLNloNxbQ0TELcK9o
 4yKQWj8SJRE4Mpexfxim81RelrlNqabduz3gR9wVdOn4kFTjhn2VvGiLX
 OuEF9rguFbIZn81O9G9mJlnU2NUjQpm7EQYAa4/1I8TnBsdBeP+kJKZ8V Q==;
X-CSE-ConnectionGUID: ueNq35WKTJqdhamZc7dHDw==
X-CSE-MsgGUID: KcZFukbiQJKHkUzprJfrLQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11413"; a="64731678"
X-IronPort-AV: E=Sophos;i="6.15,237,1739865600"; d="scan'208";a="64731678"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Apr 2025 19:24:54 -0700
X-CSE-ConnectionGUID: QxsTtoapQueoWV+QFEj0Ag==
X-CSE-MsgGUID: iEH2hVyATjKVXBMrQqTXLQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,237,1739865600"; d="scan'208";a="137942430"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Apr 2025 19:24:55 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 24 Apr 2025 19:24:53 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 24 Apr 2025 19:24:53 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.40) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 24 Apr 2025 19:24:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iuLrMHQeBCGvzrT2s7WFdt72tlK/wWJGFyk3bBIgF7GF0ZBZm2UunHSqnJpHgFj+OoXwfKelZBZpkTH1DE4ZixzcS6G6asTQcK8GK49Y2TJ6NiyhmQkMtHR0Q0mxomEXdvCSXwG99N8QHDXnI/ufBqjsB65Qzjlwi7tmUhJoYQB5OMH/ImgxA9RfQPTwoNuHNUHYN1x9qhpxd9sLZZOQYhFEFnlp3OqETde9FUBFYvSBdqQ+el295RsTXLnAGST49lpzNdJKoiepawhQ1PAX+eao/xWjLvclF/3gn9uSDxrOW+NUaotMxQdcqmEm/OXHvnH2nED8oMm9dMG4AZIUlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1PWZAIJonFLkNI2xxb7qU4TTpoAHzFWbUm93GCyrfZ4=;
 b=syN7ps0XPGo5CpAAROT479oB7w+5aB9lmi5a5wVNaSnMexQhcVVqnqVrdB3XMRAVQGb/L8jsfyM0UO0Rxi0jUQt3SK/R1qrNjRpf8PErrjFHlq+N2aR5lz9xMyyzSpylmjmGDru7Np4FhQcvbV7PRW5LcqFmBkJueVpn0iVNL2uIJ92Hqw3BAVWAElUhQTFBsRz2o8Njxtbx2qStV9KLTO9vKQD5mrgFsn8tINqSbMa/zOFTfZ/l40I7OBl4+vDRzb15nycX1ZK0lT0MgZsJfCfrArqHOK6JRbEnf/qciVWOx6HZzfpS3oXzChFtgi2nKEOQnWO7ZnUhYjv8U1Ylbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by PH3PPF10FBEE80C.namprd11.prod.outlook.com (2603:10b6:518:1::d09)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.27; Fri, 25 Apr
 2025 02:24:51 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091%4]) with mapi id 15.20.8678.025; Fri, 25 Apr 2025
 02:24:51 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "nicolinc@nvidia.com"
 <nicolinc@nvidia.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "steven.sistare@oracle.com"
 <steven.sistare@oracle.com>, "Liu, Yi L" <yi.l.liu@intel.com>, "Peng, Chao P"
 <chao.p.peng@intel.com>
Subject: RE: [PATCH] vfio: Register/unregister container for CPR only once for
 each container
Thread-Topic: [PATCH] vfio: Register/unregister container for CPR only once
 for each container
Thread-Index: AQHbtONrJn6oqHg2nkKKGCXpZineC7OyuwaAgADpKIA=
Date: Fri, 25 Apr 2025 02:24:51 +0000
Message-ID: <SJ0PR11MB67447DEF03605DBF7EED7DD792842@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20250424063355.3855174-1-zhenzhong.duan@intel.com>
 <81a55290-4c9f-4c3f-85b9-ddba53360aa8@redhat.com>
In-Reply-To: <81a55290-4c9f-4c3f-85b9-ddba53360aa8@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|PH3PPF10FBEE80C:EE_
x-ms-office365-filtering-correlation-id: d7f5ef5d-d356-4e69-43e8-08dd83a05b9e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?U2IxWlZpY0JRWXBkeTh6dXNZKy9uOFVVMm5jK2FTWm5JQ0lBUXR3MUdzVnpt?=
 =?utf-8?B?cHFxREQ3RGhhQi9WV2IvMndEMU1haGoxS0IwcGFjQXAySUZtSi9Vc2JtQWR0?=
 =?utf-8?B?WnhGNEZWcGhwcmg4RXQ4TlhTMzNkUVNXZ2NqaFIzUnFic2xMTWpBT1IrSVZG?=
 =?utf-8?B?dmhkKzFpV3VteVNLbGk1SGxweis3YW5ua3dGYkkxQ2VPUHJ6UWhQVkYrNnlo?=
 =?utf-8?B?QVRZNDFJY09XZ2tvWjEvKzBrUWV1Y0F2ZXJLOWUxdkNpNUtFYzVXT1dFbGs1?=
 =?utf-8?B?UkwwNEU3M2ovSFdocUZGRVZaMDNIMEprV081ejNnQU8ySWczb1B4V3VhV3VQ?=
 =?utf-8?B?ZVBnaU01MTcwTFlxaUl6ZlVPNmlaNkJtdk52ckw5K2tEb2Jsd3NRQTFPMzZH?=
 =?utf-8?B?bnlySk9PU3pxVXlFYzhBbHlnWGFLWW04TkRUL3lpcFFPT0RQSFdNcFNSUFQz?=
 =?utf-8?B?R1BGMEdlaEgrQVd5ZzdDa1BOV2JyVmZhTHNxaXE0K3NRSDViaTZoeWF2TlR0?=
 =?utf-8?B?UnIxMFlFRE8vQ3FDRFQ3amk1K2lUZUsrOUdzMzMxMVYzSkFvTi9DbTB6UDFC?=
 =?utf-8?B?UkFSYkppS3RQdXBMS0x3dGdqN243bExMS2IyaHZXaTd3Rm5hVG94SFNoTHZt?=
 =?utf-8?B?MmhZc2RqWERacVNmaWl2K0pBekdvTzNtUk9mWTVpNkJsT094Y1M2Z2haYVlN?=
 =?utf-8?B?cXd6VnYzV2RuaENKeXU1QUEzMDg3RVRWdEQ4d1FyOG5uWkR1UHJVUmxoZEVk?=
 =?utf-8?B?T0NBbkk0ZVJ5V283aUdVV2JIcFB3NVd1SFltbzlxRUhzdkNvOHlNeWdjTWZv?=
 =?utf-8?B?ejZHRDR6MjdBandvRXZMamJEc04wNzFQcGNRWGJiaDFiZ2E0UzVQRWU1Qkxk?=
 =?utf-8?B?WFRXM0plSkFDWUxoOXJ2WE5DM1RaYkxUNGNLY2RaV2d2SDNmbE9Gb0ExZytO?=
 =?utf-8?B?aFlEOFNYSVVVWC9nQnd3a3J3TnJlcFAwZVlEU2diUkNrai85azhtQVhUVzZT?=
 =?utf-8?B?VEw4aXgxT2N4a3VRNnFldXBYbllOdkdoVSt6Wm5oODZ0bytTOUpkV0pPMEJu?=
 =?utf-8?B?QjYrQ0x5TC9FNU5VUnRMODBOMkw4MUJMekZIY0wzRHVJSnhXcGNneTBpU1JU?=
 =?utf-8?B?WWNjSldxZnBhK0Y0RWlldXJKQVpnVGZad1NhQXNMRGFETS9GQWJwakI3a3R6?=
 =?utf-8?B?Wno0cURhYUNsZkVHVkFxTUZwbmFnVk5xQmxHMnBiTERHcnpkRllmdEc4bXM2?=
 =?utf-8?B?OEJ4dDUwejgxRU9TbE9MRUkwejlxcnJHYU9OY3pFMGpPWCtUTi9xdGF1a2hh?=
 =?utf-8?B?REVMWDhDNkk0U1dLNEg1UXBYU2RoaXZaSU9mZUF5enlYME52UEZadzlvNEdW?=
 =?utf-8?B?cWsyK2dyQW1mWExxVGo0YlplWXA5ZW1PUEtCMlZHRWtOWXU5SXJaSklzaTJ0?=
 =?utf-8?B?dVBmZlBBK0l2dU42eGVwcnZSYlYwTUErMm95QVpqZnEvNFJZRVd0Y3luVTlV?=
 =?utf-8?B?b1BuUndremVqUEN1N1BwOHNFUXZiM3cvalR1TjMvUmZraGVmNkZYMDhEZGJw?=
 =?utf-8?B?R2ZwWVBnZnpVSk9GOVBTRVVmVy80U2hObElCUEE4c3NnQWV5bDhtaXdETDl6?=
 =?utf-8?B?b1pKRzhBaGNIVy9zSmg1dTJDRGxZRzhiREEwVElLUmZwTXVPYmN6QW9KbklT?=
 =?utf-8?B?Q1p2dTF1NjFXMlFEQmxuRmpTRWNZOGJlbHE0b2cyNlp0MUVZTG5YbVA2ZW9S?=
 =?utf-8?B?TUQyVCtrK05yTjRudWpaN3pROFlOVEw3ZTJEbVJOQUZJbU9oODFTWVJER05W?=
 =?utf-8?B?NGZlaWtJZ2kwNDRVb2FOM2R4eXZFMUk5UFhxUGMzU0JtQXVhL0dIeFpJVUtJ?=
 =?utf-8?B?RXpiTXFQTjkzVUVLU3IzaCt2dmxKekgrTFRkYzNrcFlvbU9kUVJ6VFdWQ3dC?=
 =?utf-8?B?b1BwQVNuUG9SQ0N2cEM5UXdpZlJvU1dvMkI0NExTdXNBYmhZcDFZK2V2WG92?=
 =?utf-8?Q?6h28YKsJf9rsfwnU0YTt4ykgmq0ST4=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aVV5aWtqTXZ1VG9VRlc5SjFOeThzZFhuK0l0eHBCd0xnTmIzQnN0QXRIS0Z5?=
 =?utf-8?B?WTNUYXRsMmFzOGE0V0pJQWRyOVNqUTNtbDlkRUx2Z1hrWEE4d0QvbitEN2I0?=
 =?utf-8?B?T0Jmck81OXM0L0VjYTVsZjYwQ3l4MFhGSzZmaWFmNXIxRVRhTlZ4Y0cwamZW?=
 =?utf-8?B?YUpLa255d1NVTUdBdE50bWVoZUhzVjJmVXdTMlhRZEpsWWRvcVVJanpVbjkr?=
 =?utf-8?B?L0xpY2k2cndYSjJ4V29Sdk5hZEUzN0FraktUU1FqQzlmSlY2SURDVFkySXFD?=
 =?utf-8?B?NmFLUnl0T2UwUE1BelJMN0hRM0kvTGRQVGVReGNSZGlkV2pJRWxjcUptc0FB?=
 =?utf-8?B?SUlLaTJDU0hTMk9lTmpYVGNvaFhIRllTVGxaYU9pMEZ0MDB0UFAxK2RpMkFk?=
 =?utf-8?B?c1NZVzAzdktjU1ZramNlY3gwY0w4YkIyTkVtMUZJaURXL1YzY3kyUzlZYXVW?=
 =?utf-8?B?K0VvRlRFakY0S0VtMjdWVXlsVlFRaFNoVlh5SnpHdFFUMmVnOC9DOFRaTldl?=
 =?utf-8?B?Mk9tTXluWTZRL2hhd3kxSGwzZ0h2ZjdnUmM4ZVVOQlNuQVIxU1FWNm9rbDBn?=
 =?utf-8?B?VndOL1pXRUNDUUd2NDAzUkNMbnZCdjAyRmY2NzRodURSOU5ZQmhWL21ZakY3?=
 =?utf-8?B?L2ZXaXc4SnU2bWRnY3pkYW1Vd1BhVVZRd3Y3VWJ5eUZBWTdhekNFZmY3UFZj?=
 =?utf-8?B?b2w5Y3JYaktWQ1VlZkJVMXRKdjBEZlJDczlTc3FpaG1UcGxxOVFmOHJRTUhC?=
 =?utf-8?B?ajRjajZuVTZ1RnVvVkg3Mk8xNTVMRlM0aEsxZUNSLytidmo5VDlkbGMwcFRq?=
 =?utf-8?B?c3N2M0lRN3dIQVk4R2VmOUxTRGtWYzhCeVRMYTIxVnVXbjFHWGQvYzdOM1Zq?=
 =?utf-8?B?UFdSb1RvL3l5TFY4WnZGMDh4ZnJRZUNnZU1RMWt3dUlwNFhsWVpFZWJ6WHFu?=
 =?utf-8?B?ekZNbDVnZ0w2b1ppWFpJK2pXa0t6L25uR0VyMTY3UVM5cm1hV2J0MzI1OWhh?=
 =?utf-8?B?UmRMY2llRUNmSlF5S2d3ZGdDNlJ0Unh6WDJiMml5Z2E3L1JQZXRQWko3NHJ3?=
 =?utf-8?B?MWk5Y29xSitFRzBUM0JkRjdRVjQxMHR0K25MU2dWN1dCdGcwT1orQUNHV2pF?=
 =?utf-8?B?eEVCTTJacDhGZktTOVYvTGpsQnAwNk5DVWVkT2Y1Ni8xUWJsZ25jLzlVSDhp?=
 =?utf-8?B?M1RJTktoNGlDaUVmNWFJdHdmRFdxczcwbnhQRGJaczZZMStpN3FQQlowRCs5?=
 =?utf-8?B?Mm1yb3VBMDhWNm1XNVFhNnNVUEtyOVhvR2V2QjgxVEJ1TlRRVnczZXB2Unp4?=
 =?utf-8?B?blFqRmplWWk2ajFFa1ZGNkl2ZXRNOENDcnpTQXlVbUZmV0kwRTRabWg1QzRH?=
 =?utf-8?B?dmtWUkNZdmt4clJkVkcrVkJTOGdPWnM0V0dJNE9JS1F0eGRoR05wTG1HTTNo?=
 =?utf-8?B?dXZRUFg5SnFCMlFDZ2JuY29sY01zT1E5UHZES1RZQVF6M3Z6OEFvRW00bVVU?=
 =?utf-8?B?Qmx2SzM3Zm5FTW9YSG84MjNzQythWmlLRzNqdDh0MjNKZ2RRaDVYWDdiaFRK?=
 =?utf-8?B?d2JPeldaTUFWSmRpY1JUN0dKb0RlVWFaaUFsTmYvOHR6dmU3RTk5d2RmcmRz?=
 =?utf-8?B?NEVMSVZCSkZkUXh0Q1E3WEdmVnpXcUZXWGNpbWFXNGtEWmNGWnIwaW1XYStP?=
 =?utf-8?B?T2dDNUlYeVhzaDFCeC8rbTM4WGY0WkNMVGx3NVRBbTlvK0hycmRaZmtKOWFQ?=
 =?utf-8?B?aHo4UFMwVDhQQ0ppbVpBOUs1aUR5a3NvQnFwMzMxdlR2THJKVUFFZTcvbnBH?=
 =?utf-8?B?YnFsUERBK25YQlk1WXJHWUJPdjJiWGxrbFE2MHVCaUZWUzhIbU03RkxNMGoz?=
 =?utf-8?B?NXBYSnliK01mZWt5dWk1M3ZWOTJaNFdOaVRGSXcvTXgySjA2L1hJUkZsVFpI?=
 =?utf-8?B?UUl5bEk0anF5WGVXSVlqQzdaNDlwWnNERzhkRS9WZG9YZlE2SDZ0STNBN0pN?=
 =?utf-8?B?YUdPcVl6MWs5T01wR0lSREhSdDRoUjAxV3FHZThna0M5SFhzVEpTZUVTY2h4?=
 =?utf-8?B?bUI2bC8yZklVYWRLYTlMTStkWHd4dW1uYk1yV0UyUE9USnRLZVBGZ0tGSldo?=
 =?utf-8?Q?s+90mmy0iqyA7iKa1q6SftsA0?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7f5ef5d-d356-4e69-43e8-08dd83a05b9e
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Apr 2025 02:24:51.1195 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HaDxXWihBa+s8zhKrwOq8cq4a+boLzKNhDuzVbdF2fIxG/A/XglKIwvplYhqbgCFsR7EpYKuPKZCjuMDAkJlBrg2Irs3sT//DBJTUyjJHcM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPF10FBEE80C
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.8;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -51
X-Spam_score: -5.2
X-Spam_bar: -----
X-Spam_report: (-5.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.84,
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IEPDqWRyaWMgTGUgR29hdGVy
IDxjbGdAcmVkaGF0LmNvbT4NCj5TdWJqZWN0OiBSZTogW1BBVENIXSB2ZmlvOiBSZWdpc3Rlci91
bnJlZ2lzdGVyIGNvbnRhaW5lciBmb3IgQ1BSIG9ubHkgb25jZSBmb3INCj5lYWNoIGNvbnRhaW5l
cg0KPg0KPk9uIDQvMjQvMjUgMDg6MzMsIFpoZW56aG9uZyBEdWFuIHdyb3RlOg0KPj4gdmZpb19j
cHJfcmVnaXN0ZXJfY29udGFpbmVyIGFuZCB2ZmlvX2Nwcl91bnJlZ2lzdGVyX2NvbnRhaW5lciBh
cmUgY29udGFpbmVyDQo+PiBzY29wZWQgZnVuY3Rpb24uIENhbGxpbmcgdGhlbSBmb3IgZWFjaCBk
ZXZpY2UgYXR0YWNoaW5nL2RldGFjaGluZyB3b3VsZA0KPj4gY29ycnVwdCBDUFIgcmVib290IG5v
dGlmaWVyIGxpc3QsIGkuZS4sIHdoZW4gdHdvIFZGSU8gZGV2aWNlcyBhcmUgYXR0YWNoZWQNCj4+
IHRvIHNhbWUgY29udGFpbmVyIGFuZCBoYXZlIHNhbWUgbm90aWZpZXIgcmVnaXN0ZXJlZCB0d2lj
ZS4NCj4+DQo+PiBGaXhlczogZDlmYTQyMjNiMzBhICgidmZpbzogcmVnaXN0ZXIgY29udGFpbmVy
IGZvciBjcHIiKQ0KPj4gU2lnbmVkLW9mZi1ieTogWmhlbnpob25nIER1YW4gPHpoZW56aG9uZy5k
dWFuQGludGVsLmNvbT4NCj4NCj5Mb29rcyBPSyB0byBtZSwgc28NCj4NCj5SZXZpZXdlZC1ieTog
Q8OpZHJpYyBMZSBHb2F0ZXIgPGNsZ0ByZWRoYXQuY29tPg0KPg0KPlNvbWUgZmVlZGJhY2sgZnJv
bSBTdGV2ZSB3b3VsZCBiZSBnb29kIHRvIGhhdmUuDQo+DQo+PiAtLS0NCj4+IGJ0dzogdW50ZXN0
ZWQgYXMgSSBoYXZlIG5vIGVudiB3aXRoIHR3byBtaWdyYXRpb24gY2FwYWJsZSBkZXZpY2VzLA0K
Pj4gICAgICAgYXBwcmVjaWF0ZSBpZiBzb21lb25lIGhhdmUgZW52IHRvIGhlbHAgdGVzdCwgdGhh
bmtzDQo+DQo+SSBkaWQuDQoNClRoYW5rcyBDw6lkcmljIQ0KDQpCUnMsDQpaaGVuemhvbmcNCg==

