Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EDC3C4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2024 09:56:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1kDN-00042U-Qy; Tue, 30 Apr 2024 05:55:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1s1kDH-00040p-Pj
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 05:55:53 -0400
Received: from mgamail.intel.com ([192.198.163.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1s1kDE-0008CN-Ue
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 05:55:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1714470949; x=1746006949;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=FkH6PaM7sBPAQqpVTtyDAexIIde05x6hUNjFA5j3QUI=;
 b=d+O9GZYf4LOTRcsHStyOlV99UMPHmj1rBL4zLt7s3+yzjeNWcG8JpxVx
 JirVKhBpF2E9RPzw/gjMJXl/uPwBRSoX2O+BoW9Gfktr63rfgt/DCqtTl
 4C0W4+FUhaKFgqk/jYZXELJnf+zmMkH1n/b77h+n5c7EKeZ1pxUXnC/Ts
 OxrXOPiUWljw225x1V6Z5XrfVMl9RGpZV+ihUZ0rbKbNNh7L0Wo9uo+N6
 6mZ0g9erFSXN0+DClIpJl7qzdYlryzLICZfmoH4Q6PAqwpTppsUXABGZF
 qTxI/D+u+u/UPGU0AXFYWd+Yko/ey+YwrlcLa8deEVvGjNSNcpquWNgWH g==;
X-CSE-ConnectionGUID: 0fXYvOs/T6SvAoWIPOM4HA==
X-CSE-MsgGUID: SPVaYOvsRBy38xLHz/vEnQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11059"; a="13096332"
X-IronPort-AV: E=Sophos;i="6.07,241,1708416000"; d="scan'208";a="13096332"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Apr 2024 02:55:45 -0700
X-CSE-ConnectionGUID: EmWwYHXWQNKW3rNDWQVsuA==
X-CSE-MsgGUID: qR3Lnwd9S8GXv3CBnn3DPA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,241,1708416000"; d="scan'208";a="26814123"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
 by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 30 Apr 2024 02:55:44 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 30 Apr 2024 02:55:44 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 30 Apr 2024 02:55:44 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 30 Apr 2024 02:55:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=My0ald76qiK3zgOHzmv22PvnWA/azukqm/x34j58izsTNj/1Y2kdNEUvPzIbztsv1JEZWOdPzkeDQ3whDr6j4rDGQNmTd20ymHdN4d2gBb6uxO3Gdc9a4pAoxFAQAwm49mWv02anohR6GohOSM2vW6mrm4tH8bcrTa/v6NhvuagvL5BtsesGy6IBZMXdyyuRi/iBzt0CTYKhvhxdY96AV3KhoBj4MRpUiKvJovUUASvwaS5y1aLkEz86hRGU26ucq9xCsw7LPU344MFxaHxJ+f+KvgG23ME2DFLKkQiXYv+sKYv8pCveZWAXZ66L+j/XgIgwooovXFHfVaybYtuOSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FkH6PaM7sBPAQqpVTtyDAexIIde05x6hUNjFA5j3QUI=;
 b=O270kUmrmH86x5XJD7u2fAC8RUTeYMQ3xgAp8UuWywqzkrZViPOq0Mh8vC2xKpUM/hIvQCHd9bdgvm0ncm1qm7dez+NS8g+OwIuwDTPEbTRjFPvzKpOo3zZZjld98J0eQJgw24jJE++iA7yFDGVeYJA2wvS8DHQwd6vtyC90RDYRIqAhgYmS3A00mF2o+6A1cIikuqvw5oC1Nae2/kxY53Ce91LMHS2foHNEnhY3rwgdryeQywhDUOWF0XPMpjISY0aQmU4HQ+Wo6+ZhkGvivUg3lqCLf4zIE8a2HgFgZcBUwemnB1rqg/rjtxtctUGf5WkzjGLuHOYJk2N26GPo5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by PH8PR11MB6951.namprd11.prod.outlook.com (2603:10b6:510:225::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Tue, 30 Apr
 2024 09:55:34 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::e4a3:76ce:879:9129]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::e4a3:76ce:879:9129%7]) with mapi id 15.20.7519.031; Tue, 30 Apr 2024
 09:55:34 +0000
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
 <chao.p.peng@intel.com>
Subject: RE: [PATCH v3 05/19] backends/host_iommu_device: Introduce
 HostIOMMUDeviceCaps
Thread-Topic: [PATCH v3 05/19] backends/host_iommu_device: Introduce
 HostIOMMUDeviceCaps
Thread-Index: AQHamgIP5dlYY8RorUiCu4lRxYlSdLGAkQUAgAADFnA=
Date: Tue, 30 Apr 2024 09:55:34 +0000
Message-ID: <SJ0PR11MB6744A11C683EA4242EADB730921A2@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20240429065046.3688701-1-zhenzhong.duan@intel.com>
 <20240429065046.3688701-6-zhenzhong.duan@intel.com>
 <1495f7b1-d3f3-4bd9-93de-34767cfa5b26@redhat.com>
In-Reply-To: <1495f7b1-d3f3-4bd9-93de-34767cfa5b26@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|PH8PR11MB6951:EE_
x-ms-office365-filtering-correlation-id: daa1e5c2-283a-4e2b-0c1f-08dc68fbae22
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230031|1800799015|376005|7416005|366007|38070700009; 
x-microsoft-antispam-message-info: =?utf-8?B?OUtJRURqOHJqK0l2N0NadjVoNG5ZTEF4T09rUWtTcEFTRjV2S21URlhzRzVh?=
 =?utf-8?B?VGd2R3JVU3VGSjBCd0JaV1puRHZGNWN5SWtMOXFKcWVWZ1cvcW02OSt5a1pu?=
 =?utf-8?B?Wld5a1NGbTJHYjZSZDFjUUw1amFzenRHUDJRYy9SU0xQTlptYlA0QWVBM01l?=
 =?utf-8?B?NlE1YVg1VDFxTXpvd2R1ZVU5Q21HOXRCOVFaUkNRNEMvdWhGRUgyZzNPWktl?=
 =?utf-8?B?UTRqTXJnc09KaXg0WTNlRFhvd2JNT3JNUFJkNlgyRGNoYXFoVHJibGJrTEgr?=
 =?utf-8?B?ZGhmT1hUSkZrdTg3T2E1SEtZYzBNaUIxTXI5dEtlS1ZoampyWmdpZ2ZGL1Jr?=
 =?utf-8?B?RUhGVGpMbnZMMWYxbkdnZ3REOG85NHB4Y3BnbitacCszMFpLR3Q1MzVJQzZj?=
 =?utf-8?B?S0dVWGU0UXpCTWRzTlJxTkJiVkQxWGtNRnh5Wlh5eklhVkpDTVdzTklmYUdK?=
 =?utf-8?B?eFBOSGVzS2t5Mld5Yy9CL3MyL1BqNWkyVGJIQ0p2RjNiSWh5Y2tZbHRCNjQz?=
 =?utf-8?B?OW9SZEE3WWdIWTB5Nlp4NFRZWGZUSVNrT3ZQbGVZODhHSlRqb3QzMU9YRHEy?=
 =?utf-8?B?VWo0N0NQVy9zZU5sSG5BbHg5NjJwdkN2Y1hlL1ZReDRJbTV2Rmg2WmU5VzBt?=
 =?utf-8?B?Z0ZrbHNkLzVIQld2N1p4MEo5eXVSUFRpdkhTbkx4ajU3YWhKckNkWEtSVTJB?=
 =?utf-8?B?aUx1a3R0Y1V2NTNQLzBib0tYZzB5TldicTR3RGVJRjdqTGc0WXhJaWt1eVNY?=
 =?utf-8?B?Q3g4aTY1Sno2QTkzcXhUMlpDMk44eEM1NnNueW05bTk2Zkw5OG03Z0wrcVV1?=
 =?utf-8?B?eHJtTnQrNHJRNG9QZjVpdW9jWUNPSytxdXVwM08rU3NmVzF0Z3VBNWx6WitK?=
 =?utf-8?B?VXBwT09UN2RmZUMwSm1YcVNNU0FSQ2dRd2pLMmV2dUFFd0ZmalF4dGNWQStI?=
 =?utf-8?B?R1pHemNzdTRLamxIdmVUZEZyNGRTRVRPeTBvcUp5UzBrMUpKRmhpTHBkYWJP?=
 =?utf-8?B?ZjBCS00rWnBMK2FvMGhBS1dWaXJ3cy85MkRKV0RNYkZVenRVVVVqejVqWVp6?=
 =?utf-8?B?enI5NVZVb3dUWFo0TFVuMTYxQ1JKWC9EK2crVVdjSWFnMkdUVHBZWlVKb0hU?=
 =?utf-8?B?a1RUMG00TVBERGQyamU1TUVaamdDMHYwZmtzVEhMZDdNWUU0QmJyNXZleUw4?=
 =?utf-8?B?WnFBYWpHVFlMc2pqTUdOMHlZamxLR2dZUXVJT0syRXJRcWEvbjJhZmdLVWxk?=
 =?utf-8?B?elpsbFArTXRvWWplSCtrLzg4cS95RDNmRndQa0Z3c3IzQ3VFWElsT1R4REZz?=
 =?utf-8?B?a0g3WTJEWXVBR3RrWEhmK1BoT1pIZmExMmJDNyt0dTVVcE1aR1cwTGR5OEhC?=
 =?utf-8?B?aDArMWFEV0ZSV096ZmFyNEFTUVA3SGJxaklDS1JsbDh4RTFJdHdFTlpSQXcv?=
 =?utf-8?B?b2tRTHNwZnJqNEVtUEpYcTdXTVpmNUZRNG9ybk8xN2xaRTRyTXVxMVNpWnlj?=
 =?utf-8?B?dTN6N0hRQzByUWxRUW1PbzAyUkl2cU04ODdSdGpiaktOcFZFb0FNZ3NKR1Q5?=
 =?utf-8?B?c0kyL0wwMmFkalZuZjdPU3hqNWQwZFFBdEkxRXBkYUxDazRxSXRVeURRaEcr?=
 =?utf-8?B?dGFycGVLVVpidk1EUEE3K3hlZ1NtTlljajZtMXE5cmFKaFMvcEZDdUdqb0l2?=
 =?utf-8?B?SHN2VFZLNmQvcDFBc05QUmxhOWNENGtZZGxBRENQdzVtdlZncm5DNU1DYitj?=
 =?utf-8?B?cDN3dUx2RG5Jdmx5dDVrMlhlL1luTXFaaVNvRFVKTFFrUmxQcHBQakdveE4z?=
 =?utf-8?B?aUpoNFJ4bVdtNHBsdFMvZz09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(7416005)(366007)(38070700009); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?V29YZ2RUZFNqU0s4Y3IyZTFYUy9lUVFTR0NVWW5rNksvWnRHVXFrQWcrandZ?=
 =?utf-8?B?SENZc2ZjVDQ5cm1hUnNuc0h6d2hxRnhncHhSK0ZDZ1lPODVBYStQcVVUb0hZ?=
 =?utf-8?B?d2JXak1EV0RIUGhxZXNWUktha2RoTFQ3UFNIS3ZDOVVQYkN5UmFNWUFsMzZK?=
 =?utf-8?B?T0pLZXRFVVhrTXE0YW03cmh5am12QXlPbDBQeHRQcjhJR2xSRm5rV2JSbDc5?=
 =?utf-8?B?dk1FdlZySVdVYjR5eTZuRTc1SUZzSXVmQWI3NVFOZDFNdlFIUG1VQmZrcmRB?=
 =?utf-8?B?aXgxSlZmbDQ0SE44SFFIOG5CS2YzWkhXYmlYeXkrVDNESmZrcWpOTVpJeGVv?=
 =?utf-8?B?NW4vbGVkZk9oeFFjL2hkWWI0UEFqVjVTMVEyd2VNaExhd1JKN1ZMYWpSYzVz?=
 =?utf-8?B?TnFRUHNlL2NFQVdTa3FTYUJDWUVEU3piYm1DR3RpR3I0L3AwaktGNW9kQ0JY?=
 =?utf-8?B?R0pOY0hBQXA5Tld4blk5NU9RKzFEaWI5TTdTb1ZFUEpWUXhVMi9jbC94OXps?=
 =?utf-8?B?K0JLQms4MjgwenpGa20xRS9WcTJZOURTbWNKYm1OVXJlWVR0WlVnOHEwc2M3?=
 =?utf-8?B?bmw1NXVjelJvVFpKVHJyMVZBWkxaL1ZpaHh3eTVoTHBKaFhIaFA1ajlJVmFV?=
 =?utf-8?B?YTI3NDRWTDBORFVJbDRldCtjZG5EUy9SYy9Ob2tRK01qRCs5bUJySTl5bmhk?=
 =?utf-8?B?NnFlYWlYUXplamNqY3JydVRpdHdkdUQ4WThIMXowVDE3N3hmSlNLU2dGT3Ax?=
 =?utf-8?B?UGFNeWxiTlpWSHkxVVhwT0hyUW5hSVBTOHFFbU1CNHhUNmJmT1RoNW5SZ0NK?=
 =?utf-8?B?NVhPS0ROMnplYVhydDFWT1BOYjVaWUx5dUIzUG1hbjVlVE42NkcvaTVDeDJs?=
 =?utf-8?B?QkJEeFNtN1VnWE1wdEk2UkkzdmlTd2E0ZnBJVE1OUWtmMEJpaUFrWUxZaW1r?=
 =?utf-8?B?andxN3l1MVNGYWlwZHNVbndSRDBDSDAvUkZhdFo4Ykt6L0pwUXlWdHhCeFh3?=
 =?utf-8?B?MU1ObzVCQ055aURKcTBMNXh4ZDlGZXRncWlPRG5WcDdWRUt4NU1PWnI3b280?=
 =?utf-8?B?RkIwRHYwL2w3R2g0L2VPekVhbW5BaVppbDBpNDlucVI5YlRNM0Z3cVJYK2x2?=
 =?utf-8?B?MUxlcENLbmxTNzZic2hLNVdQOUZPd2tIUTlhTGttalJiUHdrQWt3M3BNbmlH?=
 =?utf-8?B?MVdkWjhjU3BzWkhBK3ZNeXEwelk4UllZT294WnQvaTJzVmZabXdxYTMySFBr?=
 =?utf-8?B?UGxnalZPVXNTbUU1K0NXMTZibFV4QUw1OTR1bUF2OHNpUTRmTlkwRytFWDdh?=
 =?utf-8?B?d1F2OEtzT3QrNmUybDVFME5MSDZnVWFVVk5menUxMWo3WXEycHNSNTQxLzlq?=
 =?utf-8?B?YVA3ZFdMYjFORXZNdzA3OW5sY29HK292UktmSTVXWVZLaGJpeHNzM0Z1Q2M0?=
 =?utf-8?B?b1o3NlN6SDRKbjNqYUM4R3lBL3M4M1NvRTJWa2tFelhITk53SDdqKzEzU0JQ?=
 =?utf-8?B?eG5QNXUwRzUvUnlHdFoxekNQN1hTSGJvdGZLcU9Fc0lVQnpKNk5Ba3p3cllr?=
 =?utf-8?B?MVdIOU9HTmNLRGN5RW1SSlFnRTVlMmwxblBZN2dmUmtueFVBOVdFekF1UlNC?=
 =?utf-8?B?ZjJtSHRRRWgzNUVsWER2aDY0clpFejVwOGNhMW1yenVBamUyZWxINGdQNWhE?=
 =?utf-8?B?VStUZC83dzdyY3N3OHY0R1VRY0JqZ2QrcVZlL0NJYUFrV0p4Q0F6K09mcVJC?=
 =?utf-8?B?QXcwZGlNbTF2bjVjQXV1TUFSVXJVdVJMVXNLaEZFVi9SSnhXM2xqcnNGSHBi?=
 =?utf-8?B?VkMvQkVIVHptQzV1YnQ3MTN6M2swTURBVFJJSnVaNHhDS2ZPdTl6NUw4MEJL?=
 =?utf-8?B?cjk2bXNrdzc2OGFJUEFnOTljT1JPNlNabElyMFg5LzhTZHRMOVQyZUVtR3J0?=
 =?utf-8?B?TjdkQml1bXRWbGVqNXlnc0NpZTBVQ1BHb2k5c01zQTNpVUtTK1dGVmFjRkgv?=
 =?utf-8?B?SjM5TkJONWY4Q2FlN0RPMS9Pa3BVeWtrZi92ZWRlT0VXVjJNZnRjUjFtaC85?=
 =?utf-8?B?SW01MnpqRDJLeWJmTUd0Yk1DM0ppRFhtYlZpVjY5S0ZWa3RSbEpxRUJ2SkNK?=
 =?utf-8?Q?GqPS1BUkH6mUDb9jr9UjEjUTw?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: daa1e5c2-283a-4e2b-0c1f-08dc68fbae22
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Apr 2024 09:55:34.6935 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dHBf/+Fqkld54RwRGziaSl/NG/Hzotl4FdClKyRAVD6Yy+gvZooeVSKJOyHTy5FVbzxfb4JXygNuhYYgsTOBGdDKN3KaF3XpjPA0jAhg3cc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6951
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.13;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.987,
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IEPDqWRyaWMgTGUgR29hdGVy
IDxjbGdAcmVkaGF0LmNvbT4NCj5TdWJqZWN0OiBSZTogW1BBVENIIHYzIDA1LzE5XSBiYWNrZW5k
cy9ob3N0X2lvbW11X2RldmljZTogSW50cm9kdWNlDQo+SG9zdElPTU1VRGV2aWNlQ2Fwcw0KPg0K
Pk9uIDQvMjkvMjQgMDg6NTAsIFpoZW56aG9uZyBEdWFuIHdyb3RlOg0KPj4gSG9zdElPTU1VRGV2
aWNlQ2FwcydzIGVsZW1lbnRzIG1hcCB0byB0aGUgaG9zdCBJT01NVSdzIGNhcGFiaWxpdGllcy4N
Cj4+IERpZmZlcmVudCBwbGF0Zm9ybSBJT01NVSBjYW4gc3VwcG9ydCBkaWZmZXJlbnQgZWxlbWVu
dHMuDQo+Pg0KPj4gQ3VycmVudGx5IG9ubHkgdHdvIGVsZW1lbnRzLCB0eXBlIGFuZCBhd19iaXRz
LCB0eXBlIGhpbnRzIHRoZSBob3N0DQo+PiBwbGF0Zm9ybSBJT01NVSB0eXBlLCBpLmUuLCBJTlRF
TCB2dGQsIEFSTSBzbW11LCBldGM7IGF3X2JpdHMgaGludHMNCj4+IGhvc3QgSU9NTVUgYWRkcmVz
cyB3aWR0aC4NCj4+DQo+PiBJbnRyb2R1Y2UgLmNoZWNrX2NhcCgpIGhhbmRsZXIgdG8gY2hlY2sg
aWYNCj5IT1NUX0lPTU1VX0RFVklDRV9DQVBfWFhYDQo+PiBpcyBzdXBwb3J0ZWQuDQo+Pg0KPj4g
SW50cm9kdWNlIGEgSG9zdElPTU1VRGV2aWNlIEFQSSBob3N0X2lvbW11X2RldmljZV9jaGVja19j
YXAoKQ0KPndoaWNoDQo+PiBpcyBhIHdyYXBwZXIgb2YgLmNoZWNrX2NhcCgpLg0KPj4NCj4+IElu
dHJvZHVjZSBhIEhvc3RJT01NVURldmljZSBBUEkNCj5ob3N0X2lvbW11X2RldmljZV9jaGVja19j
YXBfY29tbW9uKCkNCj4+IHRvIGNoZWNrIGNvbW1vbiBjYXBhYmFsaXRpZXMgb2YgZGlmZmVyZW50
IGhvc3QgcGxhdGZvcm0gSU9NTVVzLg0KPj4NCj4+IFN1Z2dlc3RlZC1ieTogQ8OpZHJpYyBMZSBH
b2F0ZXIgPGNsZ0ByZWRoYXQuY29tPg0KPj4gU2lnbmVkLW9mZi1ieTogWmhlbnpob25nIER1YW4g
PHpoZW56aG9uZy5kdWFuQGludGVsLmNvbT4NCj4+IC0tLQ0KPj4gICBpbmNsdWRlL3N5c2VtdS9o
b3N0X2lvbW11X2RldmljZS5oIHwgNDQNCj4rKysrKysrKysrKysrKysrKysrKysrKysrKysrKysN
Cj4+ICAgYmFja2VuZHMvaG9zdF9pb21tdV9kZXZpY2UuYyAgICAgICB8IDI5ICsrKysrKysrKysr
KysrKysrKysrDQo+PiAgIDIgZmlsZXMgY2hhbmdlZCwgNzMgaW5zZXJ0aW9ucygrKQ0KPj4NCj4+
IGRpZmYgLS1naXQgYS9pbmNsdWRlL3N5c2VtdS9ob3N0X2lvbW11X2RldmljZS5oDQo+Yi9pbmNs
dWRlL3N5c2VtdS9ob3N0X2lvbW11X2RldmljZS5oDQo+PiBpbmRleCAyYjU4YTk0ZDYyLi4xMmI2
YWZiNDYzIDEwMDY0NA0KPj4gLS0tIGEvaW5jbHVkZS9zeXNlbXUvaG9zdF9pb21tdV9kZXZpY2Uu
aA0KPj4gKysrIGIvaW5jbHVkZS9zeXNlbXUvaG9zdF9pb21tdV9kZXZpY2UuaA0KPj4gQEAgLTE0
LDEyICsxNCwyNyBAQA0KPj4NCj4+ICAgI2luY2x1ZGUgInFvbS9vYmplY3QuaCINCj4+ICAgI2lu
Y2x1ZGUgInFhcGkvZXJyb3IuaCINCj4+ICsjaW5jbHVkZSAibGludXgvaW9tbXVmZC5oIg0KPj4g
Kw0KPj4gKy8qKg0KPj4gKyAqIHN0cnVjdCBIb3N0SU9NTVVEZXZpY2VDYXBzIC0gRGVmaW5lIGhv
c3QgSU9NTVUgZGV2aWNlIGNhcGFiaWxpdGllcy4NCj4+ICsgKg0KPj4gKyAqIEB0eXBlOiBob3N0
IHBsYXRmb3JtIElPTU1VIHR5cGUuDQo+PiArICoNCj4+ICsgKiBAYXdfYml0czogaG9zdCBJT01N
VSBhZGRyZXNzIHdpZHRoLiAweGZmIGlmIG5vIGxpbWl0YXRpb24uDQo+PiArICovDQo+PiArdHlw
ZWRlZiBzdHJ1Y3QgSG9zdElPTU1VRGV2aWNlQ2FwcyB7DQo+PiArICAgIGVudW0gaW9tbXVfaHdf
aW5mb190eXBlIHR5cGU7DQo+PiArICAgIHVpbnQ4X3QgYXdfYml0czsNCj4+ICt9IEhvc3RJT01N
VURldmljZUNhcHM7DQo+Pg0KPj4gICAjZGVmaW5lIFRZUEVfSE9TVF9JT01NVV9ERVZJQ0UgImhv
c3QtaW9tbXUtZGV2aWNlIg0KPj4gICBPQkpFQ1RfREVDTEFSRV9UWVBFKEhvc3RJT01NVURldmlj
ZSwgSG9zdElPTU1VRGV2aWNlQ2xhc3MsDQo+SE9TVF9JT01NVV9ERVZJQ0UpDQo+Pg0KPj4gICBz
dHJ1Y3QgSG9zdElPTU1VRGV2aWNlIHsNCj4+ICAgICAgIE9iamVjdCBwYXJlbnRfb2JqOw0KPj4g
Kw0KPj4gKyAgICBIb3N0SU9NTVVEZXZpY2VDYXBzIGNhcHM7DQo+PiAgIH07DQo+Pg0KPj4gICAv
KioNCj4+IEBAIC00Nyw1ICs2MiwzNCBAQCBzdHJ1Y3QgSG9zdElPTU1VRGV2aWNlQ2xhc3Mgew0K
Pj4gICAgICAgICogUmV0dXJuczogdHJ1ZSBvbiBzdWNjZXNzLCBmYWxzZSBvbiBmYWlsdXJlLg0K
Pj4gICAgICAgICovDQo+PiAgICAgICBib29sICgqcmVhbGl6ZSkoSG9zdElPTU1VRGV2aWNlICpo
aW9kLCB2b2lkICpvcGFxdWUsIEVycm9yICoqZXJycCk7DQo+PiArICAgIC8qKg0KPj4gKyAgICAg
KiBAY2hlY2tfY2FwOiBjaGVjayBpZiBhIGhvc3QgSU9NTVUgZGV2aWNlIGNhcGFiaWxpdHkgaXMg
c3VwcG9ydGVkLg0KPj4gKyAgICAgKg0KPj4gKyAgICAgKiBPcHRpb25hbCBjYWxsYmFjaywgaWYg
bm90IGltcGxlbWVudGVkLCBoaW50IG5vdCBzdXBwb3J0aW5nIHF1ZXJ5DQo+PiArICAgICAqIG9m
IEBjYXAuDQo+PiArICAgICAqDQo+PiArICAgICAqIEBoaW9kOiBwb2ludGVyIHRvIGEgaG9zdCBJ
T01NVSBkZXZpY2UgaW5zdGFuY2UuDQo+PiArICAgICAqDQo+PiArICAgICAqIEBjYXA6IGNhcGFi
aWxpdHkgdG8gY2hlY2suDQo+PiArICAgICAqDQo+PiArICAgICAqIEBlcnJwOiBwYXNzIGFuIEVy
cm9yIG91dCB3aGVuIGZhaWxzIHRvIHF1ZXJ5IGNhcGFiaWxpdHkuDQo+PiArICAgICAqDQo+PiAr
ICAgICAqIFJldHVybnM6IDwwIG9uIGZhaWx1cmUsIDAgaWYgYSBAY2FwIGlzIHVuc3VwcG9ydGVk
LCBvciBlbHNlDQo+PiArICAgICAqIDEgb3Igc29tZSBwb3NpdGl2ZSB2YWx1ZSBmb3Igc29tZSBz
cGVjaWFsIEBjYXAsDQo+PiArICAgICAqIGkuZS4sIEhPU1RfSU9NTVVfREVWSUNFX0NBUF9BV19C
SVRTLg0KPj4gKyAgICAgKi8NCj4+ICsgICAgaW50ICgqY2hlY2tfY2FwKShIb3N0SU9NTVVEZXZp
Y2UgKmhpb2QsIGludCBjYXAsIEVycm9yICoqZXJycCk7DQo+PiAgIH07DQo+PiArDQo+PiArLyoN
Cj4+ICsgKiBIb3N0IElPTU1VIGRldmljZSBjYXBhYmlsaXR5IGxpc3QuDQo+PiArICovDQo+PiAr
I2RlZmluZSBIT1NUX0lPTU1VX0RFVklDRV9DQVBfSU9NTVVGRCAgICAgICAwDQo+PiArI2RlZmlu
ZSBIT1NUX0lPTU1VX0RFVklDRV9DQVBfSU9NTVVfVFlQRSAgICAxDQo+PiArI2RlZmluZSBIT1NU
X0lPTU1VX0RFVklDRV9DQVBfQVdfQklUUyAgICAgICAyDQo+PiArDQo+PiArDQo+PiAraW50IGhv
c3RfaW9tbXVfZGV2aWNlX2NoZWNrX2NhcChIb3N0SU9NTVVEZXZpY2UgKmhpb2QsIGludCBjYXAs
DQo+RXJyb3IgKiplcnJwKTsNCj4+ICtpbnQgaG9zdF9pb21tdV9kZXZpY2VfY2hlY2tfY2FwX2Nv
bW1vbihIb3N0SU9NTVVEZXZpY2UgKmhpb2QsDQo+aW50IGNhcCwNCj4+ICsgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICBFcnJvciAqKmVycnApOw0KPj4gICAjZW5kaWYNCj4+
IGRpZmYgLS1naXQgYS9iYWNrZW5kcy9ob3N0X2lvbW11X2RldmljZS5jDQo+Yi9iYWNrZW5kcy9o
b3N0X2lvbW11X2RldmljZS5jDQo+PiBpbmRleCA0MWYyZmRjZTIwLi5iOTdkMDA4Y2M3IDEwMDY0
NA0KPj4gLS0tIGEvYmFja2VuZHMvaG9zdF9pb21tdV9kZXZpY2UuYw0KPj4gKysrIGIvYmFja2Vu
ZHMvaG9zdF9pb21tdV9kZXZpY2UuYw0KPj4gQEAgLTI4LDMgKzI4LDMyIEBAIHN0YXRpYyB2b2lk
IGhvc3RfaW9tbXVfZGV2aWNlX2luaXQoT2JqZWN0ICpvYmopDQo+PiAgIHN0YXRpYyB2b2lkIGhv
c3RfaW9tbXVfZGV2aWNlX2ZpbmFsaXplKE9iamVjdCAqb2JqKQ0KPj4gICB7DQo+PiAgIH0NCj4+
ICsNCj4+ICsvKiBXcmFwcGVyIG9mIEhvc3RJT01NVURldmljZUNsYXNzOmNoZWNrX2NhcCAqLw0K
Pj4gK2ludCBob3N0X2lvbW11X2RldmljZV9jaGVja19jYXAoSG9zdElPTU1VRGV2aWNlICpoaW9k
LCBpbnQgY2FwLA0KPkVycm9yICoqZXJycCkNCj4NCj5TaW5jZSB3ZSBoYXZlIGFuICdFcnJvciAq
KmVycnAnLCB3ZSBjb3VsZCByZXR1cm4gYSBib29sIGluc3RlYWQsDQo+dW5sZXNzIHRoaXMgaXMg
YSAnZ2V0X2NhcCcgcm91dGluZSA/DQoNCk1heWJlIGJldHRlciB0byBuYW1lIGl0IGhvc3RfaW9t
bXVfZGV2aWNlX2dldF9jYXAoKT8NCkJlY2F1c2Ugbm90IGFsbCByZXN1bHRzIGFyZSBib29sLCBz
b21lIGFyZSBpbnRlZ2VyLCBpLmUuLCBhd19iaXRzLg0KDQpUaGFua3MNClpoZW56aG9uZw0KDQo+
DQo+VGhhbmtzLA0KPg0KPkMuDQo+DQo+DQo+PiArew0KPj4gKyAgICBIb3N0SU9NTVVEZXZpY2VD
bGFzcyAqaGlvZGMgPQ0KPkhPU1RfSU9NTVVfREVWSUNFX0dFVF9DTEFTUyhoaW9kKTsNCj4+ICsg
ICAgaWYgKCFoaW9kYy0+Y2hlY2tfY2FwKSB7DQo+PiArICAgICAgICBlcnJvcl9zZXRnKGVycnAs
ICIuY2hlY2tfY2FwKCkgbm90IGltcGxlbWVudGVkIik7DQo+PiArICAgICAgICByZXR1cm4gLUVJ
TlZBTDsNCj4+ICsgICAgfQ0KPj4gKw0KPj4gKyAgICByZXR1cm4gaGlvZGMtPmNoZWNrX2NhcCho
aW9kLCBjYXAsIGVycnApOw0KPj4gK30NCj4+ICsNCj4+ICsvKiBJbXBsZW1lbnQgY2hlY2sgb24g
Y29tbW9uIElPTU1VIGNhcGFiaWxpdGllcyAqLw0KPj4gK2ludCBob3N0X2lvbW11X2RldmljZV9j
aGVja19jYXBfY29tbW9uKEhvc3RJT01NVURldmljZSAqaGlvZCwNCj5pbnQgY2FwLA0KPj4gKyAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIEVycm9yICoqZXJycCkNCj4+ICt7
DQo+PiArICAgIEhvc3RJT01NVURldmljZUNhcHMgKmNhcHMgPSAmaGlvZC0+Y2FwczsNCj4+ICsN
Cj4+ICsgICAgc3dpdGNoIChjYXApIHsNCj4+ICsgICAgY2FzZSBIT1NUX0lPTU1VX0RFVklDRV9D
QVBfSU9NTVVfVFlQRToNCj4+ICsgICAgICAgIHJldHVybiBjYXBzLT50eXBlOw0KPj4gKyAgICBj
YXNlIEhPU1RfSU9NTVVfREVWSUNFX0NBUF9BV19CSVRTOg0KPj4gKyAgICAgICAgcmV0dXJuIGNh
cHMtPmF3X2JpdHM7DQo+PiArICAgIGRlZmF1bHQ6DQo+PiArICAgICAgICBlcnJvcl9zZXRnKGVy
cnAsICJOb3Qgc3VwcG9ydCBxdWVyeSBjYXAgJXgiLCBjYXApOw0KPj4gKyAgICAgICAgcmV0dXJu
IC1FSU5WQUw7DQo+PiArICAgIH0NCj4+ICt9DQoNCg==

