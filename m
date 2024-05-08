Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57C26C25B4F
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2024 06:25:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4ajo-0001LL-MC; Wed, 08 May 2024 02:25:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1s4ajj-0001Ks-2w
 for qemu-devel@nongnu.org; Wed, 08 May 2024 02:25:08 -0400
Received: from mgamail.intel.com ([198.175.65.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1s4ajg-0005Xq-A3
 for qemu-devel@nongnu.org; Wed, 08 May 2024 02:25:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1715149504; x=1746685504;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=QOo0/4X8hO5rVlGi+27Mw9wpyz9ZeoDxZepqHr56ZTg=;
 b=SUphPvZEU+kgnebuZKcWwVc2QLYxZ6gAW2+kgXHFVqbqyC4jZ8Uby66r
 9kaKSF3zBcClfhbqdYERR3V9eB4JXxNZNsS6c7+OpC/+HWzUvDAIz31yn
 xJACtNdlCh7YMjsMTMboQ2GntMZ41mv8dU/DhYcuFp9aDZYxFKxPprFm0
 73HkpiuQEHdj11CrmVoE5r+D9AaY5blOe/6KkBaSNlcK7KVH+qb3aUNIP
 GCOCHUxFZlBVgP0RY1aMMrogXP3comYCJvyoIe0pR3Ph/ahWDiaU6jsAV
 D0miBufNfjm8tNRDVlmfc3lvsiDXWNsqcnTPphDiydQMAbniF65xX/aMI A==;
X-CSE-ConnectionGUID: mgP0KFhlSAWw2fyQUIIZzQ==
X-CSE-MsgGUID: eRqGGXLrTT+X6wegHj+3uA==
X-IronPort-AV: E=McAfee;i="6600,9927,11066"; a="22141278"
X-IronPort-AV: E=Sophos;i="6.08,144,1712646000"; d="scan'208";a="22141278"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 May 2024 23:25:02 -0700
X-CSE-ConnectionGUID: 7St6/ogvQlOYmlurwVXkYw==
X-CSE-MsgGUID: MvLs059BQtO/CiRLitq8ig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,144,1712646000"; d="scan'208";a="33582252"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
 by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 07 May 2024 23:25:02 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 7 May 2024 23:25:01 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 7 May 2024 23:25:01 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 7 May 2024 23:25:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LU8aUVFTfS9lNpM7V0mVfzip7wERjE8uhLAXTf7R7Kx2XuTzYtnAhFSHvkU7EpbEK/WNXRUS5xSJJzHu2QK/4UUefgAhn+oOLqe46HRwlzbfmzS5mCU4picSWvK9xmMeyuTMYIt7HDIvFwjlFXegHhBtxt6q3vv/D4LNRjak2lo4yBi4U+L6JlgeRDhDaNoAUkMwcWvw/glsVb/U4RSgzFRj+uRSHLiR870NF5HU7mnTdjJOVHmFOcGQERtTnvyzXK9vmNyOK3Ne5Dr3g4aLISIorR208E5HljZH3KNgBo6od41x4VEhfAF31tUHOW4qaXmOPswTfhAd5u4idVqFmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QOo0/4X8hO5rVlGi+27Mw9wpyz9ZeoDxZepqHr56ZTg=;
 b=CzPmN6bXe4HOEmbDKvpXvGM1REk3qNDanJCvhZ5HgmLo7IcEIQqrXqp+4PM504rVapOmWTYORsUw4scJa7LBbPUGXtAZUwDsd3hR44apCdT3Fz6CRGY9laNz4KXj75S9aJkPDzThEV7lnZbrL+Jxr7kJEpugUXnqE9SJqLeSeiPlUAe8zBYTx4f4N2D1aOC/CPlsJsQrfc7H1xgTdr/aCpDGscskXdDBKfaYNHot11e2GZBynee3bxuTj7g7DdPoWQj1XVXat3TcXmJySY0EgAk9VNrvqUiqCJHbnZptDf8UBa1iOOHS973+O9DgzZCIvzWZT/BCdVXD2El/d70ksA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by CY8PR11MB7036.namprd11.prod.outlook.com (2603:10b6:930:50::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.43; Wed, 8 May
 2024 06:24:59 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::e4a3:76ce:879:9129]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::e4a3:76ce:879:9129%7]) with mapi id 15.20.7544.041; Wed, 8 May 2024
 06:24:59 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "mst@redhat.com"
 <mst@redhat.com>, "peterx@redhat.com" <peterx@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>, "jgg@nvidia.com"
 <jgg@nvidia.com>, "nicolinc@nvidia.com" <nicolinc@nvidia.com>,
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>, "Tian, Kevin"
 <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>, "Peng, Chao P"
 <chao.p.peng@intel.com>, Yi Sun <yi.y.sun@linux.intel.com>, Marcel Apfelbaum
 <marcel.apfelbaum@gmail.com>
Subject: RE: [PATCH v3 15/19] hw/pci: Introduce
 pci_device_[set|unset]_iommu_device()
Thread-Topic: [PATCH v3 15/19] hw/pci: Introduce
 pci_device_[set|unset]_iommu_device()
Thread-Index: AQHamgIc3p7zOkUbKEGY+9IBw5Ark7GLZbOAgAALF4CAAE6tAIABLIFQ
Date: Wed, 8 May 2024 06:24:59 +0000
Message-ID: <SJ0PR11MB6744ED41DE548C1B503E70A492E52@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20240429065046.3688701-1-zhenzhong.duan@intel.com>
 <20240429065046.3688701-16-zhenzhong.duan@intel.com>
 <adb10cf9-faff-41f1-a6e4-e7c169f16c72@redhat.com>
 <SJ0PR11MB6744EEA78AD1ADA4CC71DD8092E42@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <f90dff15-bc08-46bb-a583-48622062249f@redhat.com>
In-Reply-To: <f90dff15-bc08-46bb-a583-48622062249f@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|CY8PR11MB7036:EE_
x-ms-office365-filtering-correlation-id: 1061915d-69a4-450c-fa26-08dc6f279622
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230031|376005|7416005|1800799015|366007|38070700009; 
x-microsoft-antispam-message-info: =?utf-8?B?Z0ZGdnFCRDJUT3lFUzQzT09yVmg5SmtYWGlLaXFxTnhTUHdmZDJPcGZnVGJG?=
 =?utf-8?B?OWN1TVlWdUpnVWFkdEFTd2Rscnk5ZmQ0T0tUeE5vV0NMUnU3dVdRY3lJa1Jq?=
 =?utf-8?B?dHFCbmIrMTQ0cDNIQlk5RThFbnhqbHJkY0xmL2NQNWFUTjZ6c0FNMzZTUE4w?=
 =?utf-8?B?Q2ltRmpWaXZKeVQ2bEN5SDJ4aGowbkFidHpJVVcwMitJUzFlZkFiVEFFUjFn?=
 =?utf-8?B?bUZ0enMrSmx6NmFMcWF6NnU1SG0wYkl2VzdMNGJ0S2RoeVY5NGFwQ3V6a1lI?=
 =?utf-8?B?WGRPaHFJVHlXMXBidCtCdi9kZ0JCZHcxMkRPckpiSUdKakt0TFZyeWlvRy9P?=
 =?utf-8?B?cGdmd0FURFdYS0x5YW5GWGhzZ2xHNzN5ZFNseTk5SDZLWmZEa1dsdThIRTd6?=
 =?utf-8?B?K1pCUUFXaG5OSEd5WUZXbXR5cGp5VU9iRThuNDBhWkZQY1NhZXFCNDVMaWFl?=
 =?utf-8?B?ck8vUUQ4ejdOMkNUV0plY2dYdkt4azQ1U25vSzE4Ly9KNUpocFQ4VFJCcldu?=
 =?utf-8?B?SVY2NW5yQm8xV1JaQlVzTERVL2F4aUdwWk92L2c0WGhjekRXTDZhSWNkQWty?=
 =?utf-8?B?T0tmMExWbVVtamZ5dDY1YzkwTlRQYnA1NDc3cmxyb1ZwQ3BBV0k0VWJHTkxE?=
 =?utf-8?B?Kzc4dGxEbHV2SXUyTHJvMTFnUVE2a1NMKzBGcStLMDg1K2w4R1JtZndRQWhz?=
 =?utf-8?B?SDhwRmNqaCtmTkdMUnJNaHhkbHBkZ0ZaMUpjZ2cxMnpZYnVGMHo2YkFtbW82?=
 =?utf-8?B?UXNEZU5NWUhnN3Jqc3dPWnNBSnJERzNkVWpHL2VBenJ2cmJpMnY2SzJCYk5P?=
 =?utf-8?B?UWFNSlNWZnlPMklRM2s5QkMzTjRzRDZyZ3M3QWZCWlVzdThXQ0l3S0NQUGs4?=
 =?utf-8?B?a01abUlaK05JRmh3MW4wY243L0w2cjVDNlhaSlAyVlBpZ1dJZWhJZ0hnZXVX?=
 =?utf-8?B?N2UycFRSZis1M3pVTi9qQ0swcit0MlZodHNNL21ycGVuOEZwQVZ3STJHNGUx?=
 =?utf-8?B?L2tPcjNFRjFsd2k0NzNQZjUzVStadkJYQVcrK0RzVk5IWFJDK2RSbzdFaE1X?=
 =?utf-8?B?N3NDQkdkZ0hoczhIWU4xSzBCdTk5Mk1BU0RBRlJoenpHbncxZVZBWUhyNGwx?=
 =?utf-8?B?ekdYWEJBTHV1b3FTaVg4NTVPbWpDaml6UW82bFRRd3loeGYxVUw4Nk4wVXVT?=
 =?utf-8?B?TkdzOVNtOUtGL2c1ZW4zS3lFRzZvaUg1eUVtQnRLZXQySWxMcU5Eczg5emlj?=
 =?utf-8?B?TmpnUXNZS3k3M2UwUzNaY2g2b0pBSHNSN2xDRklIeU9mTlAxWHBKWEsyTW9n?=
 =?utf-8?B?RXlxR0hBNThlNDVpV0IyZE1nMkNXQXlqbWF4Tm5tYUhzZlBpVXh0Qi8zQWJ6?=
 =?utf-8?B?UXhnb1dVTzJCMXVjdlc1RnVHdVhyS0pPWTlWK21FTlIrRjByYlh5VkNxYkxa?=
 =?utf-8?B?SVcvOHRPQ01LYkU0UUh1MEZXK2dITDRrRlV1YVRRMWhVaXdvL1Q2SzhzRHZh?=
 =?utf-8?B?Ky9CR2R3c0JKRU13WVR6NE9kODFreFk5MGpqWkdWVXVPUzUzMlcrMVV3T08x?=
 =?utf-8?B?eGV2eEJyL1ZKb1R6UFVkRytJQi9rWEdwWjFvYjJoaENFY2xJUzlkSitzd2FF?=
 =?utf-8?B?YXliSkNTankyV3dZUGcybzRuN1dsNEJlVEtwbFBhWlhjZ0xjR0RQQ2h6eFdm?=
 =?utf-8?B?WUtRZ3RGclkzNmZpRHZVTHF0cEJKdTNyZXRRY3VobzdOMGsxcU1ocTNRNXBY?=
 =?utf-8?B?SXFpbDB4SExteDJaVkx5ejNMWE96aEtNb1JNN2NyMUpQNVk1TmVuYWpUb09y?=
 =?utf-8?B?QjQ3MG1YV2dJVlludjNZdz09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(7416005)(1800799015)(366007)(38070700009); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZmtWaWhlam5idTcvcWFKU0ltK0hCSWpESnpnczdQK09UMjFNOUZaenBBRU5U?=
 =?utf-8?B?Rm9xTGlZTmU3S1paVW9QS2RiUWlHTGhURHVLMXlHQTJUbmNkV0ovZ3ZmL3lQ?=
 =?utf-8?B?Y2lmbDVKWDVRWTdtM3RFMnBsTG5xQ3Z5ajIyK0ZVV0QxVHdlRDFHSnZxNE1k?=
 =?utf-8?B?UTloWHpYZFZrcGVITXNTcVUzc0Y0dWtIbmVicnNFRFJyNTFUYlFoZjIzMWp0?=
 =?utf-8?B?M2djb3VDNEgzOTJGbkJwTThzZWk3YlRuOXNKNXg3UmUvaTJqSXJmSGlmdzl1?=
 =?utf-8?B?ZnVUbE5KUXY4aG9EbmVsdmx1MkU5V3lvRjYzbEl1ak9rMWN5N1pTeHY0N2FK?=
 =?utf-8?B?bzBLeFE3N2IxRlNNT1I5M3ljdGxvcVY3YWRsZU9JQjlyNkpOekdRYStHOFU1?=
 =?utf-8?B?ajR5Z2FjeXV5cXZJQ3ZoK0R4UlB6alVWM3hKZlpyNFYyWldaU0drMkJxWDc3?=
 =?utf-8?B?WVJ4OTlKTytqVXFDRUZ0ZGVYNklObVZJeVIvTXBIRWt3TWtxLzNvYlU1cWhv?=
 =?utf-8?B?cmxrR0dBRU0xZ1d1Tzk0VUpaalpXNGcwTWpiN0ZuS3cycTgrbVBITUJEWnZP?=
 =?utf-8?B?Qi9CcjVqVWxoMUJZNmZkcjRNR1FvM2ZTRVIvUkVmdml1OG9YNTg0dEtuaVNo?=
 =?utf-8?B?ZmlhOTh0TndFeFJuNjRlZzJsWWdtbERvMDl6cHQ4Y1k0ZFFPRVRBbkpkU2to?=
 =?utf-8?B?cVpPZEswUE9weXpnR2hOcmJIcWtNRVA5OUtuVk9JQzhnU0JDUnlHS1NzN1d1?=
 =?utf-8?B?RjlOUnZJZ1JmY1VPSk5zU2JzVDBMTmVUaXR3eHo5c2EyZEdWbXVqOWhmbGZu?=
 =?utf-8?B?VVU3OTY5TGR6T29JZ3hZQXFkYWNEdnBKSW0xS2hLcmp0aUQ3dlB2bEY0OGk4?=
 =?utf-8?B?Uy9NZGxYb0hPT1EzSnBpR2VDeE1pLy9uOWRObi9QVHdaZVBtSkd5R3NWbVdC?=
 =?utf-8?B?Z0NUcWkvWE1Xb1BJTE1jT3JwVUxtdmxYclpiSVp0N2F2bEJOTERBWFpJTzNP?=
 =?utf-8?B?dGNTdDE2SkM3VFRTK3VzVVc3S2Z0dWFyaGsyRXJNekYxM0VPZGJJU0dFY2Va?=
 =?utf-8?B?V2ppOURhZnAwdElNVEFDdEFtTGFYWHI5VEpvMER6Q3JFVFdHNjlsSTJxQmlW?=
 =?utf-8?B?aG9VcXBhT09KTFhteHpJUE9HVWFlTFg5elp3cHYxZXkxc3hhYU1TaVhUSDVX?=
 =?utf-8?B?Q0QrQVk3TnFheUVZVTVaTVlHSXpXeHVueTl0aXpOcWd4Q1JWUzN6ck03R0lk?=
 =?utf-8?B?NDJwNDdGZFljSlM2VVVwNEYzQ3k2NVlLS0k4NkoxZVZRVFAvQS9kbXZwY1VB?=
 =?utf-8?B?NGMwUXVuZnJUSmtsendqZWc3MWozdGhTTm9DK2hRYk85UklpQ3QwRkM2aDVq?=
 =?utf-8?B?bjFnUXZPUklwL2tITWhmUmZLVjA1d21JQkRaMHhJSzBDbFI4R3lhMFNBVjVI?=
 =?utf-8?B?UmtIcG5JSXd0Z3g3c1dwYmEyb2Nabm96dWlvRWxrVXR4VnZ4MGI4RkJCS0F4?=
 =?utf-8?B?WDBhM0UxeXJjSFVzTmRobzEzdXprK0tlV1duM2MxZnpUWDRGanlhcDAxNkZ1?=
 =?utf-8?B?dXVVdkozNXBweVpwRXZjTGdYUzR5dmQvSHpnSmh3aGtJSFZhcVlJaWR0d3BJ?=
 =?utf-8?B?NThZK0lUSWliSlQzdGFsSXhjNlpGV3hSZFpPQW9lNEdQaS9ReHdXeFZjOVc3?=
 =?utf-8?B?RVRQZzQ2cTA2RFRaeEF4YlQ5cDNJbkUrd1dxRHM0NGxlOWpuWDBKQlNHa3dY?=
 =?utf-8?B?MkRnelA0S3FUQm8rMUo1UDdiRTlvbFNRcHlqeU1TNG16MkswbE1RNldwRzdD?=
 =?utf-8?B?TEpwL2o2cldXQ1lEcXVGWUVQRVV3eW9xZ0hnWWgyMEZQOXF6ejJqWmFqcFBD?=
 =?utf-8?B?YUMxQSsxZ1FTRHJaVDZTODRtdlFCQ1Y5WjNSZWZzS0p5akl0TlNkZ2pLZmtU?=
 =?utf-8?B?VjgrbU5QbFNpU05IM0ovZ2VDd211SnZFNkhLYzJvUkhrVzVVei9oUElwd2xQ?=
 =?utf-8?B?WHpyOExyaVpycmlOY05FYjJBREhRZWJCTVUvTitnQjBSOGpjRkpvMEU3aFFv?=
 =?utf-8?B?dzFPb0w2VkJvMGVhMzFrODZPK0o4cW5QbHBheHYzUGROdjhrcDlVRXRNM1pt?=
 =?utf-8?Q?pwx7Q6+bOqkNNoCwiJIgYOlGU?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1061915d-69a4-450c-fa26-08dc6f279622
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 May 2024 06:24:59.2905 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JnKGbS9ryk3j02OnvZNyMF45I5dERoWctXf0c29P2iMBUfJrqS8kiQrKGqTy1Gmfwb9b9g4+q/WYQmdUCK0aB/RYRRziF0mc04BuDlSWbGw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7036
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.13;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.581,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
IDxjbGdAcmVkaGF0LmNvbT4NCj5TdWJqZWN0OiBSZTogW1BBVENIIHYzIDE1LzE5XSBody9wY2k6
IEludHJvZHVjZQ0KPnBjaV9kZXZpY2VfW3NldHx1bnNldF1faW9tbXVfZGV2aWNlKCkNCj4NCj5P
biA1LzcvMjQgMDk6NDgsIER1YW4sIFpoZW56aG9uZyB3cm90ZToNCj4+IEhpIEPDqWRyaWMsDQo+
Pg0KPj4+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+Pj4gRnJvbTogQ8OpZHJpYyBMZSBH
b2F0ZXIgPGNsZ0ByZWRoYXQuY29tPg0KPj4+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjMgMTUvMTld
IGh3L3BjaTogSW50cm9kdWNlDQo+Pj4gcGNpX2RldmljZV9bc2V0fHVuc2V0XV9pb21tdV9kZXZp
Y2UoKQ0KPj4+DQo+Pj4gSGVsbG8gWmhlbnpob25nLA0KPj4+DQo+Pj4gT24gNC8yOS8yNCAwODo1
MCwgWmhlbnpob25nIER1YW4gd3JvdGU6DQo+Pj4+IEZyb206IFlpIExpdSA8eWkubC5saXVAaW50
ZWwuY29tPg0KPj4+Pg0KPj4+PiBwY2lfZGV2aWNlX1tzZXR8dW5zZXRdX2lvbW11X2RldmljZSgp
IGNhbGwNCj4+PiBwY2lfZGV2aWNlX2dldF9pb21tdV9idXNfZGV2Zm4oKQ0KPj4+PiB0byBnZXQg
aW9tbXVfYnVzLT5pb21tdV9vcHMgYW5kIGNhbGwgW3NldHx1bnNldF1faW9tbXVfZGV2aWNlDQo+
Pj4gY2FsbGJhY2sgdG8NCj4+Pj4gc2V0L3Vuc2V0IEhvc3RJT01NVURldmljZSBmb3IgYSBnaXZl
biBQQ0kgZGV2aWNlLg0KPj4+Pg0KPj4+PiBTaWduZWQtb2ZmLWJ5OiBZaSBMaXUgPHlpLmwubGl1
QGludGVsLmNvbT4NCj4+Pj4gU2lnbmVkLW9mZi1ieTogWWkgU3VuIDx5aS55LnN1bkBsaW51eC5p
bnRlbC5jb20+DQo+Pj4+IFNpZ25lZC1vZmYtYnk6IE5pY29saW4gQ2hlbiA8bmljb2xpbmNAbnZp
ZGlhLmNvbT4NCj4+Pj4gU2lnbmVkLW9mZi1ieTogWmhlbnpob25nIER1YW4gPHpoZW56aG9uZy5k
dWFuQGludGVsLmNvbT4NCj4+Pj4gLS0tDQo+Pj4+ICAgIGluY2x1ZGUvaHcvcGNpL3BjaS5oIHwg
MzgNCj4+PiArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrLQ0KPj4+PiAgICBo
dy9wY2kvcGNpLmMgICAgICAgICB8IDI3ICsrKysrKysrKysrKysrKysrKysrKysrKysrKw0KPj4+
PiAgICAyIGZpbGVzIGNoYW5nZWQsIDY0IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4+
Pj4NCj4+Pj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvaHcvcGNpL3BjaS5oIGIvaW5jbHVkZS9ody9w
Y2kvcGNpLmgNCj4+Pj4gaW5kZXggZWFhM2ZjOTlkOC4uODQ5ZTM5MTgxMyAxMDA2NDQNCj4+Pj4g
LS0tIGEvaW5jbHVkZS9ody9wY2kvcGNpLmgNCj4+Pj4gKysrIGIvaW5jbHVkZS9ody9wY2kvcGNp
LmgNCj4+Pj4gQEAgLTMsNiArMyw3IEBADQo+Pj4+DQo+Pj4+ICAgICNpbmNsdWRlICJleGVjL21l
bW9yeS5oIg0KPj4+PiAgICAjaW5jbHVkZSAic3lzZW11L2RtYS5oIg0KPj4+PiArI2luY2x1ZGUg
InN5c2VtdS9ob3N0X2lvbW11X2RldmljZS5oIg0KPj4+DQo+Pj4gVGhpcyBpbmNsdWRlIGRpcmVj
dGl2ZSBwdWxscyBhIExpbnV4IGhlYWRlciBmaWxlIDxsaW51eC9pb21tdWZkLmg+DQo+Pj4gd2hp
Y2ggZG9lc24ndCBleGlzdCBvbiBhbGwgcGxhdGZvcm1zLCBzdWNoIGFzIHdpbmRvd3MgYW5kIGl0
IGJyZWFrcw0KPj4+IGNvbXBpbGUuIFNvLA0KPj4+DQo+Pj4+DQo+Pj4+ICAgIC8qIFBDSSBpbmNs
dWRlcyBsZWdhY3kgSVNBIGFjY2Vzcy4gICovDQo+Pj4+ICAgICNpbmNsdWRlICJody9pc2EvaXNh
LmgiDQo+Pj4+IEBAIC0zODMsMTAgKzM4NCw0NSBAQCB0eXBlZGVmIHN0cnVjdCBQQ0lJT01NVU9w
cyB7DQo+Pj4+ICAgICAgICAgKg0KPj4+PiAgICAgICAgICogQGRldmZuOiBkZXZpY2UgYW5kIGZ1
bmN0aW9uIG51bWJlcg0KPj4+PiAgICAgICAgICovDQo+Pj4+IC0gICBBZGRyZXNzU3BhY2UgKiAo
KmdldF9hZGRyZXNzX3NwYWNlKShQQ0lCdXMgKmJ1cywgdm9pZCAqb3BhcXVlLCBpbnQNCj4+PiBk
ZXZmbik7DQo+Pj4+ICsgICAgQWRkcmVzc1NwYWNlICogKCpnZXRfYWRkcmVzc19zcGFjZSkoUENJ
QnVzICpidXMsIHZvaWQgKm9wYXF1ZSwNCj5pbnQNCj4+PiBkZXZmbik7DQo+Pj4+ICsgICAgLyoq
DQo+Pj4+ICsgICAgICogQHNldF9pb21tdV9kZXZpY2U6IGF0dGFjaCBhIEhvc3RJT01NVURldmlj
ZSB0byBhIHZJT01NVQ0KPj4+PiArICAgICAqDQo+Pj4+ICsgICAgICogT3B0aW9uYWwgY2FsbGJh
Y2ssIGlmIG5vdCBpbXBsZW1lbnRlZCBpbiB2SU9NTVUsIHRoZW4gdklPTU1VDQo+Pj4gY2FuJ3QN
Cj4+Pj4gKyAgICAgKiByZXRyaWV2ZSBob3N0IGluZm9ybWF0aW9uIGZyb20gdGhlIGFzc29jaWF0
ZWQgSG9zdElPTU1VRGV2aWNlLg0KPj4+PiArICAgICAqDQo+Pj4+ICsgICAgICogQGJ1czogdGhl
ICNQQ0lCdXMgb2YgdGhlIFBDSSBkZXZpY2UuDQo+Pj4+ICsgICAgICoNCj4+Pj4gKyAgICAgKiBA
b3BhcXVlOiB0aGUgZGF0YSBwYXNzZWQgdG8gcGNpX3NldHVwX2lvbW11KCkuDQo+Pj4+ICsgICAg
ICoNCj4+Pj4gKyAgICAgKiBAZGV2Zm46IGRldmljZSBhbmQgZnVuY3Rpb24gbnVtYmVyIG9mIHRo
ZSBQQ0kgZGV2aWNlLg0KPj4+PiArICAgICAqDQo+Pj4+ICsgICAgICogQGRldjogdGhlIGRhdGEg
c3RydWN0dXJlIHJlcHJlc2VudGluZyBob3N0IElPTU1VIGRldmljZS4NCj4+Pj4gKyAgICAgKg0K
Pj4+PiArICAgICAqIEBlcnJwOiBwYXNzIGFuIEVycm9yIG91dCBvbmx5IHdoZW4gcmV0dXJuIGZh
bHNlDQo+Pj4+ICsgICAgICoNCj4+Pj4gKyAgICAgKiBSZXR1cm5zOiAwIGlmIEhvc3RJT01NVURl
dmljZSBpcyBhdHRhY2hlZCwgb3IgZWxzZSA8MCB3aXRoIGVycnANCj5zZXQuDQo+Pj4+ICsgICAg
ICovDQo+Pj4+ICsgICAgaW50ICgqc2V0X2lvbW11X2RldmljZSkoUENJQnVzICpidXMsIHZvaWQg
Km9wYXF1ZSwgaW50IGRldmZuLA0KPj4+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgIEhv
c3RJT01NVURldmljZSAqZGV2LCBFcnJvciAqKmVycnApOw0KPj4+PiArICAgIC8qKg0KPj4+PiAr
ICAgICAqIEB1bnNldF9pb21tdV9kZXZpY2U6IGRldGFjaCBhIEhvc3RJT01NVURldmljZSBmcm9t
IGENCj4+PiB2SU9NTVUNCj4+Pj4gKyAgICAgKg0KPj4+PiArICAgICAqIE9wdGlvbmFsIGNhbGxi
YWNrLg0KPj4+PiArICAgICAqDQo+Pj4+ICsgICAgICogQGJ1czogdGhlICNQQ0lCdXMgb2YgdGhl
IFBDSSBkZXZpY2UuDQo+Pj4+ICsgICAgICoNCj4+Pj4gKyAgICAgKiBAb3BhcXVlOiB0aGUgZGF0
YSBwYXNzZWQgdG8gcGNpX3NldHVwX2lvbW11KCkuDQo+Pj4+ICsgICAgICoNCj4+Pj4gKyAgICAg
KiBAZGV2Zm46IGRldmljZSBhbmQgZnVuY3Rpb24gbnVtYmVyIG9mIHRoZSBQQ0kgZGV2aWNlLg0K
Pj4+PiArICAgICAqLw0KPj4+PiArICAgIHZvaWQgKCp1bnNldF9pb21tdV9kZXZpY2UpKFBDSUJ1
cyAqYnVzLCB2b2lkICpvcGFxdWUsIGludCBkZXZmbik7DQo+Pj4+ICAgIH0gUENJSU9NTVVPcHM7
DQo+Pj4+DQo+Pj4+ICAgIEFkZHJlc3NTcGFjZSAqcGNpX2RldmljZV9pb21tdV9hZGRyZXNzX3Nw
YWNlKFBDSURldmljZSAqZGV2KTsNCj4+Pj4gK2ludCBwY2lfZGV2aWNlX3NldF9pb21tdV9kZXZp
Y2UoUENJRGV2aWNlICpkZXYsIEhvc3RJT01NVURldmljZQ0KPj4+ICpoaW9kLA0KPj4+PiArICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICBFcnJvciAqKmVycnApOw0KPj4+DQo+Pj4gcGxl
YXNlIGluY2x1ZGUgYSBmb3J3YXJkIGRlY2xhcmF0aW9uIGZvciBIb3N0SU9NTVVEZXZpY2UgaW5z
dGVhZC4NCj4+DQo+PiBHb3QgaXQsIHdpbGwgZG8uDQo+PiBNYXliZSB1c2luZyBpb21tdV9od19p
bmZvX3R5cGUgaW4NCj5pbmNsdWRlL3N5c2VtdS9ob3N0X2lvbW11X2RldmljZS5oDQo+PiBpc24n
dCBhIGdvb2QgaWRlYSBmcm9tIHN0YXJ0Lg0KPg0KPkl0IGlzIG5vdCBpbmRlZWQgc2luY2Ugc29t
ZSBpbmNsdWRlZCBmaWxlcyBhcmUgdXNlZCBvbiB0aGUgV2luZG93cyBidWlsZC4NCg0KV2luZG93
cyBidWlsZCBwYXNzIGFmdGVyIGJlbG93IGNoYW5nZSB0byBkcm9wIGlvbW11X2h3X2luZm8uDQpJ
J2xsIGRvIG1vcmUgYnVpbGQgdGVzdCwgdGhlbiBzZW5kIHY1LCBzb3JyeSBmb3IgdGhlIHRyb3Vi
bGUuDQoNCmRpZmYgLS1naXQgYS9iYWNrZW5kcy9pb21tdWZkLmMgYi9iYWNrZW5kcy9pb21tdWZk
LmMNCmluZGV4IDdjMzMyYmQxNjcuLmZjM2U0OThiYzYgMTAwNjQ0DQotLS0gYS9iYWNrZW5kcy9p
b21tdWZkLmMNCisrKyBiL2JhY2tlbmRzL2lvbW11ZmQuYw0KQEAgLTIwOCw3ICsyMDgsNyBAQCBp
bnQgaW9tbXVmZF9iYWNrZW5kX3VubWFwX2RtYShJT01NVUZEQmFja2VuZCAqYmUsIHVpbnQzMl90
IGlvYXNfaWQsDQogfQ0KDQogYm9vbCBpb21tdWZkX2JhY2tlbmRfZ2V0X2RldmljZV9pbmZvKElP
TU1VRkRCYWNrZW5kICpiZSwgdWludDMyX3QgZGV2aWQsDQotICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIGVudW0gaW9tbXVfaHdfaW5mb190eXBlICp0eXBlLA0KKyAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICB1bml0MzJfdCAqdHlwZSwNCiAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgdm9pZCAqZGF0YSwgdWludDMyX3QgbGVuLCBFcnJv
ciAqKmVycnApDQogew0KICAgICBzdHJ1Y3QgaW9tbXVfaHdfaW5mbyBpbmZvID0gew0KZGlmZiAt
LWdpdCBhL2h3L2kzODYvaW50ZWxfaW9tbXUuYyBiL2h3L2kzODYvaW50ZWxfaW9tbXUuYw0KaW5k
ZXggMjlmYmU2MTQ1NC4uZGRlZjY2N2MwZCAxMDA2NDQNCi0tLSBhL2h3L2kzODYvaW50ZWxfaW9t
bXUuYw0KKysrIGIvaHcvaTM4Ni9pbnRlbF9pb21tdS5jDQpAQCAtMjAsNiArMjAsNyBAQA0KICAq
Lw0KDQogI2luY2x1ZGUgInFlbXUvb3NkZXAuaCINCisjaW5jbHVkZSBDT05GSUdfREVWSUNFUyAv
KiBDT05GSUdfSE9TVF9JT01NVV9ERVZJQ0UgKi8NCiAjaW5jbHVkZSAicWVtdS9lcnJvci1yZXBv
cnQuaCINCiAjaW5jbHVkZSAicWVtdS9tYWluLWxvb3AuaCINCiAjaW5jbHVkZSAicWFwaS9lcnJv
ci5oIg0KQEAgLTQyMDMsNiArNDIwNCw4IEBAIFZUREFkZHJlc3NTcGFjZSAqdnRkX2ZpbmRfYWRk
X2FzKEludGVsSU9NTVVTdGF0ZSAqcywgUENJQnVzICpidXMsDQogc3RhdGljIGJvb2wgdnRkX2No
ZWNrX2hkZXYoSW50ZWxJT01NVVN0YXRlICpzLCBWVERIb3N0SU9NTVVEZXZpY2UgKnZ0ZF9oZGV2
LA0KICAgICAgICAgICAgICAgICAgICAgICAgICAgIEVycm9yICoqZXJycCkNCiB7DQorI2lmZGVm
IENPTkZJR19IT1NUX0lPTU1VX0RFVklDRQ0KKw0KICAgICBIb3N0SU9NTVVEZXZpY2UgKmhpb2Qg
PSB2dGRfaGRldi0+ZGV2Ow0KICAgICBpbnQgcmV0Ow0KDQpAQCAtNDIyMyw2ICs0MjI2LDkgQEAg
c3RhdGljIGJvb2wgdnRkX2NoZWNrX2hkZXYoSW50ZWxJT01NVVN0YXRlICpzLCBWVERIb3N0SU9N
TVVEZXZpY2UgKnZ0ZF9oZGV2LA0KDQogICAgIGVycm9yX3NldGcoZXJycCwgImhvc3QgZGV2aWNl
IGlzIHVuc3VwcG9ydGVkIGluIHNjYWxhYmxlIG1vZGVybiBtb2RlIHlldCIpOw0KICAgICByZXR1
cm4gZmFsc2U7DQorI2Vsc2UNCisgICAgcmV0dXJuIHRydWU7DQorI2VuZGlmDQogfQ0KDQogc3Rh
dGljIGJvb2wgdnRkX2Rldl9zZXRfaW9tbXVfZGV2aWNlKFBDSUJ1cyAqYnVzLCB2b2lkICpvcGFx
dWUsIGludCBkZXZmbiwNCmRpZmYgLS1naXQgYS9pbmNsdWRlL3N5c2VtdS9ob3N0X2lvbW11X2Rl
dmljZS5oIGIvaW5jbHVkZS9zeXNlbXUvaG9zdF9pb21tdV9kZXZpY2UuaA0KaW5kZXggNjgwYzJh
MzExYS4uZWQ0Y2JjOTY3YSAxMDA2NDQNCi0tLSBhL2luY2x1ZGUvc3lzZW11L2hvc3RfaW9tbXVf
ZGV2aWNlLmgNCisrKyBiL2luY2x1ZGUvc3lzZW11L2hvc3RfaW9tbXVfZGV2aWNlLmgNCkBAIC0x
NCw3ICsxNCw2IEBADQoNCiAjaW5jbHVkZSAicW9tL29iamVjdC5oIg0KICNpbmNsdWRlICJxYXBp
L2Vycm9yLmgiDQotI2luY2x1ZGUgPGxpbnV4L2lvbW11ZmQuaD4NCg0KIC8qKg0KICAqIHN0cnVj
dCBIb3N0SU9NTVVEZXZpY2VDYXBzIC0gRGVmaW5lIGhvc3QgSU9NTVUgZGV2aWNlIGNhcGFiaWxp
dGllcy4NCkBAIC0yNCw3ICsyMyw3IEBADQogICogQGF3X2JpdHM6IGhvc3QgSU9NTVUgYWRkcmVz
cyB3aWR0aC4gMHhmZiBpZiBubyBsaW1pdGF0aW9uLg0KICAqLw0KIHR5cGVkZWYgc3RydWN0IEhv
c3RJT01NVURldmljZUNhcHMgew0KLSAgICBlbnVtIGlvbW11X2h3X2luZm9fdHlwZSB0eXBlOw0K
KyAgICB1aW50MzJfdCB0eXBlOw0KICAgICB1aW50OF90IGF3X2JpdHM7DQogfSBIb3N0SU9NTVVE
ZXZpY2VDYXBzOw0KDQpkaWZmIC0tZ2l0IGEvaW5jbHVkZS9zeXNlbXUvaW9tbXVmZC5oIGIvaW5j
bHVkZS9zeXNlbXUvaW9tbXVmZC5oDQppbmRleCBlZTE5MDdjMjNhLi42NTAzYTUxZDc5IDEwMDY0
NA0KLS0tIGEvaW5jbHVkZS9zeXNlbXUvaW9tbXVmZC5oDQorKysgYi9pbmNsdWRlL3N5c2VtdS9p
b21tdWZkLmgNCkBAIC0xNyw3ICsxNyw2IEBADQogI2luY2x1ZGUgInFvbS9vYmplY3QuaCINCiAj
aW5jbHVkZSAiZXhlYy9od2FkZHIuaCINCiAjaW5jbHVkZSAiZXhlYy9jcHUtY29tbW9uLmgiDQot
I2luY2x1ZGUgPGxpbnV4L2lvbW11ZmQuaD4NCiAjaW5jbHVkZSAic3lzZW11L2hvc3RfaW9tbXVf
ZGV2aWNlLmgiDQoNCiAjZGVmaW5lIFRZUEVfSU9NTVVGRF9CQUNLRU5EICJpb21tdWZkIg0KQEAg
LTQ5LDcgKzQ4LDcgQEAgaW50IGlvbW11ZmRfYmFja2VuZF9tYXBfZG1hKElPTU1VRkRCYWNrZW5k
ICpiZSwgdWludDMyX3QgaW9hc19pZCwgaHdhZGRyIGlvdmEsDQogaW50IGlvbW11ZmRfYmFja2Vu
ZF91bm1hcF9kbWEoSU9NTVVGREJhY2tlbmQgKmJlLCB1aW50MzJfdCBpb2FzX2lkLA0KICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIGh3YWRkciBpb3ZhLCByYW1fYWRkcl90IHNpemUpOw0K
IGJvb2wgaW9tbXVmZF9iYWNrZW5kX2dldF9kZXZpY2VfaW5mbyhJT01NVUZEQmFja2VuZCAqYmUs
IHVpbnQzMl90IGRldmlkLA0KLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBl
bnVtIGlvbW11X2h3X2luZm9fdHlwZSAqdHlwZSwNCisgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgdWludDMyX3QgKnR5cGUsDQogICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIHZvaWQgKmRhdGEsIHVpbnQzMl90IGxlbiwgRXJyb3IgKiplcnJwKTsNCg0KICNk
ZWZpbmUgVFlQRV9IT1NUX0lPTU1VX0RFVklDRV9JT01NVUZEIFRZUEVfSE9TVF9JT01NVV9ERVZJ
Q0UgIi1pb21tdWZkIg0KDQpUaGFua3MNClpoZW56aG9uZw0K

