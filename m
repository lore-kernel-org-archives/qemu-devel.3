Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FD86C4345F
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Apr 2024 04:23:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rwwpC-0003Ik-Lu; Wed, 17 Apr 2024 00:23:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1rwwpA-0003Hy-WC
 for qemu-devel@nongnu.org; Wed, 17 Apr 2024 00:23:09 -0400
Received: from mgamail.intel.com ([192.198.163.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1rwwp8-00081o-8Y
 for qemu-devel@nongnu.org; Wed, 17 Apr 2024 00:23:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1713327786; x=1744863786;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=WZQVQkft517AgyMIHl0sq0On4C+1pYvUbK+xdLu3L8o=;
 b=iBMwy2phGlf+zaNNTor9mR6FpxXe9e+EbGrAnXo+ydOshGq+U/ha8FDU
 JeoYAJUgASJgY9dNAEoBC0ac10gepdG8MuOVxUJq/NwFmqcABShgm6I1s
 BFyHf8ERjYL+mVRhBpMfN6JDMz90YGbwMF6Y37TaG+Rlt/w0LHWNs31W3
 83hw2D8Tn5NeHCjK8+Hoj5IgVwQBZKGIF+9oa/K8Wb84cVH0E4kK+8fhT
 AoDb9bNbNton3FdMlYxhJ2/bNmBuOC/CvXvkhdGcJxrJXo5t7He0qYP11
 fS6jFWYWwszPXmkD8XSEIEj5EGe22KA+PDO3KWSal3WKUBR6C31+JaQv5 Q==;
X-CSE-ConnectionGUID: taUb45k2SzW7R+DS4TOzlQ==
X-CSE-MsgGUID: jOYkFb/7RoSQcMtX3dG8JA==
X-IronPort-AV: E=McAfee;i="6600,9927,11046"; a="9020626"
X-IronPort-AV: E=Sophos;i="6.07,208,1708416000"; 
   d="scan'208";a="9020626"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Apr 2024 21:23:04 -0700
X-CSE-ConnectionGUID: 4Aq0x/kJQvKZ3bs0VD0Spg==
X-CSE-MsgGUID: fPaUd5EQQ6OWm0XRU05MRw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,208,1708416000"; d="scan'208";a="26930305"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
 by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 16 Apr 2024 21:23:04 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 16 Apr 2024 21:23:02 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 16 Apr 2024 21:23:02 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 16 Apr 2024 21:23:02 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 16 Apr 2024 21:23:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OHCeRCaexOrb/wfZcYWs9Dn9uVu3wdpdw56KuZrnUp0EMZ34XJKMBw4Fp0bVHfaRk3GOqF8c9pd1W2d1ajadORtiuP2blqbC4rD9ysth1xapr7R3XUsAQxmK2NshE/UYr/FUyhsBinWniS2J3fu4w1HCAEN1p53eklfObXW0BatJlPIu3Kseo7ASdMVTVsg5NhdI6OeowQaZQBj26Tb9Od2Fan3ScN1Wv42uBeNFjSlRrp3N5N0u2A9cXvln6gbQVwoTzwIL/ltRAnV6SOdoX7PUT+jXuuvXV+SUHIcB08CKITto5Lek4MOhe/TsBI50n9oQLRmfEgW1LhFhyz9FkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WZQVQkft517AgyMIHl0sq0On4C+1pYvUbK+xdLu3L8o=;
 b=OlancX69V6OhphJhetuswXD8Jc1DCbaNlQxEokJaIelNYfUY/cNZYRxiaECH7BViDtMUo5oPA2MnIx3BNFzaBuJW0h2d97vyCI4k2/gad/6m4n6TBUkDNIRSahAbAzlMUGwrw6W/mmu7uNVLf+IUT4NL7Iq6uALoOBQQmXSiV2kcNOcE+ZepG6CvVYmUkMFubyXJALDZU/z0j1XzT+ecaXq17oZ1D0P+kPevX8e0KjjWKfht3lBzHqrWu1bpnLUcCDSYJyXrUbgG3s4W9Tg37AGaSSkUycBoVeKSv7MzY/s2nv+3t5Ht3kud8Q642sFg4D9UBFaYNLUFDSVyKjz8mA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by SA1PR11MB8541.namprd11.prod.outlook.com (2603:10b6:806:3a9::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.37; Wed, 17 Apr
 2024 04:23:00 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::e4a3:76ce:879:9129]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::e4a3:76ce:879:9129%7]) with mapi id 15.20.7472.025; Wed, 17 Apr 2024
 04:23:00 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "peterx@redhat.com"
 <peterx@redhat.com>, "jasowang@redhat.com" <jasowang@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>, "jgg@nvidia.com" <jgg@nvidia.com>,
 "nicolinc@nvidia.com" <nicolinc@nvidia.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "Tian, Kevin" <kevin.tian@intel.com>, "Liu, Yi
 L" <yi.l.liu@intel.com>, "Peng, Chao P" <chao.p.peng@intel.com>
Subject: RE: [PATCH v2 02/10] vfio: Introduce HIODLegacyVFIO device
Thread-Topic: [PATCH v2 02/10] vfio: Introduce HIODLegacyVFIO device
Thread-Index: AQHaiYzptKOfpLfFEUmXEx9ocl3VJrFpUwqAgADyPPCAALKTgIAA8qXA
Date: Wed, 17 Apr 2024 04:22:59 +0000
Message-ID: <SJ0PR11MB6744DF9B5542A7D1780F5A41920F2@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20240408081230.1030078-1-zhenzhong.duan@intel.com>
 <20240408081230.1030078-3-zhenzhong.duan@intel.com>
 <9869ac57-56c6-41b7-a2c6-d42a5ba475ee@redhat.com>
 <SJ0PR11MB67448DE106AEE894D080D3F492082@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <a46d4d57-0d6c-4ba3-887b-bc167a25434a@redhat.com>
In-Reply-To: <a46d4d57-0d6c-4ba3-887b-bc167a25434a@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|SA1PR11MB8541:EE_
x-ms-office365-filtering-correlation-id: b91abd7c-c62e-49a6-3027-08dc5e9610d8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XUXAgb/rbQhBmVZXTKytq9KCVa4WO4qXyYRql2+0fOkyqLiKdsTSw0mgQm5Iy4p0hSEK83c7lQmgJ/UNA5aFo0kYhpKNoyUgOdvVfS2ZRxMitz2mfx7WYHb1mUVG7zlfGbSPgAnYinpn9QhYnhV9J6fnyKJ9dGeEP4KE+t0oJ+mQefyKiQHPtT4Q9pmJP4NgjdnpUXILuK83QCCks3CweiB54nOn9mFyEWY+HZ9ckEURj9+fzDyuMp7Xy3umsdMbtjKHbeLzxcdnsaJZ9V2vGgFk9JEi5t7A1joDg45jiczcTgFVR4FqHFASrFxymPr1DaiVBFER/JkZIcwtYw9Zm9QqWSKRWB1OAMver2x+u6oazx2zN1Ff6OlKcfv3UMddntSVUQm2iKbTSTvTskFUTB+onYe5Ao0mwwFpTXhERMYsQp7Q80g42XHyPWBK8lYLGizTYjMKg1CJaBTx+1+qUEWUBPNv5+2CmrrPBBgzNR6zV77yql+mL4BArd0nMfwNPqT1dORAeo2zP0L8n2mXE4DxaK+vD7jdzsKuCyv/j1ahrOl905YPu7yECCGdSt6KRvhOcGC9Xix62lh/0D7gonrx8I9Sa+ylmHfsccLDTpXT8M3pMw3PyBneDUjrKlZEBDHm2f5VBfsRFh4MqnsfJfYNqh1k5/TrgYp7sHTg7dqgX16XFoRiMw0A8zBs2mcNL/DATAis5D+8D5+qkIiSr84jeJTx+m5if6IGypmvUVk=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(1800799015)(7416005)(38070700009); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dVFEcmhZVzN2UmlPRlJaeHF6dklkWnBtTjUyc0pFMExRTzBSTzR1VFNNVXJt?=
 =?utf-8?B?ZEMyQ09VYkVDSnF1ZzZ6V3MyU0pZWEFXOCtYb0daU21rVzR0MHRNdTk0UUpo?=
 =?utf-8?B?eE9udVorR1U0VHBNOVh2VjNrMDFHWEtUTkFuTVRwN0pqMEdwN3FIUEVweTlJ?=
 =?utf-8?B?UlpuSTNUOXg1MFhYQXFTYmcwbDNGZG1SWnR5QXZYVEVFbHpneWQwSllqaEFt?=
 =?utf-8?B?cHpYYWxsamxmbUVwMVVKc1VzdklUall0RkhQUHE1Y01maGw1OU5nTEV3bG9x?=
 =?utf-8?B?V0Zzalo3VitSN21zWGEvaFhlQUZKMEc0ZXFuT2EwZTF2SnYxdE5RSFFBY0RB?=
 =?utf-8?B?a3lNRDBDODcyQ3hUY3pmZUFRY3ZHNkZvTnJVOUtwUDVNYXVOQzBmUmFnUldN?=
 =?utf-8?B?SEg4cXlaeGtyMDg4bWlZazRPUnNGcU5MWkxtTWZ5Z1pRY3dyVmNFL3JoaE0r?=
 =?utf-8?B?ZUR5T3k5RHh6OFdrM3NiVDMvd1BTZzg0R242eHhFREV0NTQ4ekt6TFFZSmJ3?=
 =?utf-8?B?WXhaRFdoblZmWlB2cVBPMy9vYmRWQVRaV0lPb2w1TzdUU3NKRnZydG4zMG1F?=
 =?utf-8?B?OWd6VnB0dmltNEFLTCtrN2U0QUhUakdpQWdzTkdXYzgrdldrWVIxbWppTlZo?=
 =?utf-8?B?VExLdUdYM3E2dTZsanE1MU96TVRYQlk1dUowNUZNREVCMnh0RVhuM3A0LzZO?=
 =?utf-8?B?N0ZBaUJLWHovWGhpeVBPYjJsOEFCVTBZY3NQZm5idE0zNmNManlreWtsbHBx?=
 =?utf-8?B?OTlKdUE2ODdXYVpwdEVoMFNwcUtJYVVOek0xNHhPbHBiS0N5MmR1dUlMZ0Fs?=
 =?utf-8?B?eGY2dm5JdVlSZXIvdVI1Um42cWdGTmVWZDlHVjluOElJNkpaQWdyM2YxVXBi?=
 =?utf-8?B?ckszamhVTTY2R2VDZUlCdzlRY3JpNVNINWhiTW5DeUJ3ZkxmZThLVzhoNFJ3?=
 =?utf-8?B?YXhwWGtBdmJzUDI3VUJlSC92U0tFYXFOYjIwdGQwWUN4MzBkSVNSb1BRMXRP?=
 =?utf-8?B?UDBGT1pZZjkvQ3lRYTVKOXdzRkZrdTVyekdSUE5mRHlWRkc4YnRlSkNISFJs?=
 =?utf-8?B?a3lMU1J3MGRZSHl3K2MzWUdZN2VPSzRJanFyeTk3bmJQL0VpemZjUHFBZGZU?=
 =?utf-8?B?aUVKb3hNNWhEeWZyS3pWRGppVXhjOEt5eDg3K1VUemxzYVBDM0NNTFYvemVt?=
 =?utf-8?B?THB6eGpDVzVaSGR5TjZieTRJazFNU0grUW95OU1OZ1NtMEUvSlowYVlqRXgz?=
 =?utf-8?B?cDZ4by96ZkppNjlwSjV1LzhtYkRLVlJKUTZOWm0rakxEbC9uQ3IyWXMrMzVt?=
 =?utf-8?B?RGF3MzhiV0lEOURDcmRjY0JZT3hydi9pZnkrb3k0SlBxSmJaTEloTWRoaTI0?=
 =?utf-8?B?WjhZcytlaUpWQXZ5N0ZFQ1hRSmdhMFFuSEh6cmtBaWFxQmtUUUtzL1NWRE95?=
 =?utf-8?B?b0ZsMTZTdnNXVmJCZEMvRVNHL0R6UmpTQ09tZmtYbWQwRXBrMEZsKytndzZj?=
 =?utf-8?B?YjlQaW00RCtEMmlQNDhjOXZtUWJaR084aE9uMjJvRlg4enpFY04vdXVxaFRP?=
 =?utf-8?B?VWpjcUtDb2dwYjlqYTBwTVBsV1FzRzNvd3pjbGp2dEh0eCt4eXQxSkg0cnJ5?=
 =?utf-8?B?dEtvdDU3SWp0M1p5eHhqdEREVTlvOTdJOGRIVkx3VWJKLzZ3VVdXZDRUNXpq?=
 =?utf-8?B?OThNVE8vdkNFQ1FHQ1I0MkxoTFRCMlNqbWkyUlRtSktSMThzaGI2SVNSak5U?=
 =?utf-8?B?MHNEcHp1Z0diMW5SSmllRnovbExlUUlOSEhqZTh4b0xhTC9RZ1pvSjN1QWYy?=
 =?utf-8?B?MTNjRmdudlhvTFAvaHBBZWM3NFZDdGEwRXVrWWVRNnQ4eDlBQTVZcmd3VnFw?=
 =?utf-8?B?UTg0VDA3ZW05NzRzbC9OTm1CQWFYMUp0Vkw2SS9hdklEcmZHbk1yYWgzRGEr?=
 =?utf-8?B?TGpPL3ZHSnI4R3JXU0tzbkdNRnJmbFowcjBEdHY0SmVSWHozczVuQlVjUVR0?=
 =?utf-8?B?MWFKbFM5cGNrYUNIWVk5THFIVDhzUG1ib1hBNlVSMWVZcGh3OU9nY3R6Ukts?=
 =?utf-8?B?WWlBUWJYSW12bUlyMHhTYTNkbWN4WUdWcG5DbVh0VG9RZ0RlRkh4eDJZcW1u?=
 =?utf-8?Q?jCdWT3iwEBFC3xK9RzfdfEcYg?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b91abd7c-c62e-49a6-3027-08dc5e9610d8
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2024 04:23:00.0060 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GAQI73QNbn2ajq84eYKDwam0wI8UQ3SeyP6C7hNS5g8Zro7o+lDgrYkupJp+CFWEHCq+214EV7A1LrBAKGUvElFilzwKPZMPVY4/y8XaeW4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8541
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.14;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.844,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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
IDxjbGdAcmVkaGF0LmNvbT4NCj5TdWJqZWN0OiBSZTogW1BBVENIIHYyIDAyLzEwXSB2ZmlvOiBJ
bnRyb2R1Y2UgSElPRExlZ2FjeVZGSU8gZGV2aWNlDQo+DQo+SGVsbG8sDQo+DQo+T24gNC8xNi8y
NCAwNTo0MSwgRHVhbiwgWmhlbnpob25nIHdyb3RlOg0KPj4gSGkgQ8OpZHJpYywNCj4+DQo+Pj4g
LS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4+PiBGcm9tOiBDw6lkcmljIExlIEdvYXRlciA8
Y2xnQHJlZGhhdC5jb20+DQo+Pj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MiAwMi8xMF0gdmZpbzog
SW50cm9kdWNlIEhJT0RMZWdhY3lWRklPIGRldmljZQ0KPj4+DQo+Pj4gT24gNC84LzI0IDEwOjEy
LCBaaGVuemhvbmcgRHVhbiB3cm90ZToNCj4+Pj4gSElPRExlZ2FjeVZGSU8gcmVwcmVzZW50cyBh
IGhvc3QgSU9NTVUgZGV2aWNlIHVuZGVyIFZGSU8gbGVnYWN5DQo+Pj4+IGNvbnRhaW5lciBiYWNr
ZW5kLg0KPj4+Pg0KPj4+PiBJdCBpbmNsdWRlcyBhIGxpbmsgdG8gVkZJT0RldmljZS4NCj4+Pj4N
Cj4+Pj4gU3VnZ2VzdGVkLWJ5OiBFcmljIEF1Z2VyIDxlcmljLmF1Z2VyQHJlZGhhdC5jb20+DQo+
Pj4+IFN1Z2dlc3RlZC1ieTogQ8OpZHJpYyBMZSBHb2F0ZXIgPGNsZ0ByZWRoYXQuY29tPg0KPj4+
PiBTaWduZWQtb2ZmLWJ5OiBaaGVuemhvbmcgRHVhbiA8emhlbnpob25nLmR1YW5AaW50ZWwuY29t
Pg0KPj4+PiAtLS0NCj4+Pj4gICAgaW5jbHVkZS9ody92ZmlvL3ZmaW8tY29tbW9uLmggfCAxMSAr
KysrKysrKysrKw0KPj4+PiAgICBody92ZmlvL2NvbnRhaW5lci5jICAgICAgICAgICB8IDExICsr
KysrKysrKystDQo+Pj4+ICAgIDIgZmlsZXMgY2hhbmdlZCwgMjEgaW5zZXJ0aW9ucygrKSwgMSBk
ZWxldGlvbigtKQ0KPj4+Pg0KPj4+PiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9ody92ZmlvL3ZmaW8t
Y29tbW9uLmggYi9pbmNsdWRlL2h3L3ZmaW8vdmZpby0NCj4+PiBjb21tb24uaA0KPj4+PiBpbmRl
eCBiOWRhNmMwOGVmLi5mMzA3NzJmNTM0IDEwMDY0NA0KPj4+PiAtLS0gYS9pbmNsdWRlL2h3L3Zm
aW8vdmZpby1jb21tb24uaA0KPj4+PiArKysgYi9pbmNsdWRlL2h3L3ZmaW8vdmZpby1jb21tb24u
aA0KPj4+PiBAQCAtMzEsNiArMzEsNyBAQA0KPj4+PiAgICAjZW5kaWYNCj4+Pj4gICAgI2luY2x1
ZGUgInN5c2VtdS9zeXNlbXUuaCINCj4+Pj4gICAgI2luY2x1ZGUgImh3L3ZmaW8vdmZpby1jb250
YWluZXItYmFzZS5oIg0KPj4+PiArI2luY2x1ZGUgInN5c2VtdS9ob3N0X2lvbW11X2RldmljZS5o
Ig0KPj4+Pg0KPj4+PiAgICAjZGVmaW5lIFZGSU9fTVNHX1BSRUZJWCAidmZpbyAlczogIg0KPj4+
Pg0KPj4+PiBAQCAtMTQ3LDYgKzE0OCwxNiBAQCB0eXBlZGVmIHN0cnVjdCBWRklPR3JvdXAgew0K
Pj4+PiAgICAgICAgYm9vbCByYW1fYmxvY2tfZGlzY2FyZF9hbGxvd2VkOw0KPj4+PiAgICB9IFZG
SU9Hcm91cDsNCj4+Pj4NCj4+Pj4gKyNkZWZpbmUgVFlQRV9ISU9EX0xFR0FDWV9WRklPIFRZUEVf
SE9TVF9JT01NVV9ERVZJQ0UgIi0NCj5sZWdhY3ktDQo+Pj4gdmZpbyINCj4+Pg0KPj4+IEkgd291
bGQgcHJlZmVyIHRvIGtlZXAgdGhlIHByZWZpeCBUWVBFX0hPU1RfSU9NTVVfREVWSUNFLg0KPj4N
Cj4+IFdpbGwgZG8uDQo+Pg0KPj4+DQo+Pj4+ICtPQkpFQ1RfREVDTEFSRV9TSU1QTEVfVFlQRShI
SU9ETGVnYWN5VkZJTywgSElPRF9MRUdBQ1lfVkZJTykNCj4+Pj4gKw0KPj4+PiArLyogQWJzdHJh
Y3Rpb24gb2YgVkZJTyBsZWdhY3kgaG9zdCBJT01NVSBkZXZpY2UgKi8NCj4+Pj4gK3N0cnVjdCBI
SU9ETGVnYWN5VkZJTyB7DQo+Pj4NCj4+PiBzYW1lIGhlcmUNCj4+DQo+PiBTaG91bGQgSSBkbyB0
aGUgc2FtZSBmb3IgYWxsIHRoZSBIb3N0SU9NTVVEZXZpY2UgYW5kDQo+SG9zdElPTU1VRGV2aWNl
Q2xhc3Mgc3ViLXN0cnVjdHVyZXM/DQo+DQo+SSB3b3VsZCBmb3IgdHlwZSBuYW1lcy4gVGhlIG1h
aW4gcmVhc29uIGlzIGZvciBuYW1pbmcgY29uc2lzdGVuY3ksIHdoaWNoIGlzDQo+dXNlZnVsIGZv
ciBncmVwIGFuZCBjb2RlIGFuYWx5c2lzLg0KDQpHb3QgaXQuDQoNCj4NCj4+DQo+PiBUaGUgcmVh
c29uIEkgdXNlZCAnSElPRCcgYWJicmV2aWF0aW9uIGlzIHNvbWUgZnVuY3Rpb24gbmFtZXMgYmVj
b21lDQo+ZXh0cmVtZWx5IGxvbmcNCj4+IGFuZCBleGNlZWQgODAgY2hhcmFjdGVycy4gRS5nLjoN
Cj4+DQo+PiBAQCAtMTE0OCw5ICsxMTQ4LDkgQEAgc3RhdGljIHZvaWQNCj52ZmlvX2lvbW11X2xl
Z2FjeV9jbGFzc19pbml0KE9iamVjdENsYXNzICprbGFzcywgdm9pZCAqZGF0YSkNCj4+ICAgICAg
IHZpb2MtPnBjaV9ob3RfcmVzZXQgPSB2ZmlvX2xlZ2FjeV9wY2lfaG90X3Jlc2V0Ow0KPj4gICB9
Ow0KPj4NCj4+IC1zdGF0aWMgaW50IGhpb2RfbGVnYWN5X3ZmaW9fZ2V0X2hvc3RfaW9tbXVfaW5m
byhIb3N0SU9NTVVEZXZpY2UNCj4qaGlvZCwNCj4+IC0gICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICB2b2lkICpkYXRhLCB1aW50MzJfdCBsZW4sDQo+PiAtICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgRXJyb3IgKiplcnJw
KQ0KPj4gK3N0YXRpYyBpbnQNCj5ob3N0X2lvbW11X2RldmljZV9sZWdhY3lfdmZpb19nZXRfaG9z
dF9pb21tdV9pbmZvKEhvc3RJT01NVURldmljZQ0KPipoaW9kLA0KPj4gKyAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB2b2lkICpkYXRh
LCB1aW50MzJfdCBsZW4sDQo+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIEVycm9yICoqZXJycCkNCj4+ICAgew0KPj4gICAgICAg
VkZJT0RldmljZSAqdmJhc2VkZXYgPSBISU9EX0xFR0FDWV9WRklPKGhpb2QpLT52ZGV2Ow0KPj4g
ICAgICAgLyogaW92YV9yYW5nZXMgaXMgYSBzb3J0ZWQgbGlzdCAqLw0KPj4gQEAgLTExNzMsNyAr
MTE3Myw3IEBAIHN0YXRpYyB2b2lkDQo+aGlvZF9sZWdhY3lfdmZpb19jbGFzc19pbml0KE9iamVj
dENsYXNzICpvYywgdm9pZCAqZGF0YSkNCj4+ICAgew0KPj4gICAgICAgSG9zdElPTU1VRGV2aWNl
Q2xhc3MgKmhpb2MgPSBIT1NUX0lPTU1VX0RFVklDRV9DTEFTUyhvYyk7DQo+Pg0KPj4gLSAgICBo
aW9jLT5nZXRfaG9zdF9pb21tdV9pbmZvID0gaGlvZF9sZWdhY3lfdmZpb19nZXRfaG9zdF9pb21t
dV9pbmZvOw0KPj4gKyAgICBoaW9jLT5nZXRfaG9zdF9pb21tdV9pbmZvID0NCj5ob3N0X2lvbW11
X2RldmljZV9sZWdhY3lfdmZpb19nZXRfaG9zdF9pb21tdV9pbmZvOw0KPj4gICB9Ow0KPj4NCj4+
IEkgZGlkbid0IGZpbmQgb3RoZXIgd2F5IHRvIG1ha2UgaXQgbWVldCB0aGUgODAgY2hhcnMgbGlt
aXRhdGlvbi4gQW55DQo+c3VnZ2VzdGlvbnMgb24gdGhpcz8NCj4NCj5UcnkgOg0KPg0KPkBAIC0x
MTc3LDcgKzExNzcsOCBAQCBzdGF0aWMgdm9pZCBoaW9kX2xlZ2FjeV92ZmlvX2NsYXNzX2luaXQo
DQo+ICB7DQo+ICAgICAgSG9zdElPTU1VRGV2aWNlQ2xhc3MgKmhpb2MgPSBIT1NUX0lPTU1VX0RF
VklDRV9DTEFTUyhvYyk7DQo+DQo+LSAgICBoaW9jLT5nZXRfaG9zdF9pb21tdV9pbmZvID0gaGlv
ZF9sZWdhY3lfdmZpb19nZXRfaG9zdF9pb21tdV9pbmZvOw0KPisgICAgaGlvYy0+Z2V0X2hvc3Rf
aW9tbXVfaW5mbyA9DQo+KyAgICAgICAgaG9zdF9pb21tdV9kZXZpY2VfbGVnYWN5X3ZmaW9fZ2V0
X2hvc3RfaW9tbXVfaW5mbzsNCj4gIH07DQo+DQo+ICBzdGF0aWMgY29uc3QgVHlwZUluZm8gdHlw
ZXNbXSA9IHsNCj4NCj5UaGF0IHNhaWQsIEkgYWdyZWUgdGhhdCAnaG9zdF9pb21tdV9kZXZpY2Vf
bGVnYWN5X3ZmaW8nIHJvdXRpbmUgcHJlZml4DQo+Y291bGQgYmUgc2hvcnRlbmVkIHRvICdoaW9k
X2xlZ2FjeV92ZmlvJy4NCg0KR290IGl0Lg0KDQpUaGFua3MNClpoZW56aG9uZw0KDQo=

