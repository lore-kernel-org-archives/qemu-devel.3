Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E0C2C83F1B
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Jul 2025 10:43:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubzbW-0005Eb-O7; Wed, 16 Jul 2025 06:43:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1ubzQ4-000162-Eb
 for qemu-devel@nongnu.org; Wed, 16 Jul 2025 06:31:38 -0400
Received: from mgamail.intel.com ([192.198.163.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1ubzQ0-0005yE-TX
 for qemu-devel@nongnu.org; Wed, 16 Jul 2025 06:31:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1752661881; x=1784197881;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=wsXhhlFYpO4O8Chwz5jFjSefQXXVDO8v/NcS3eqF3Zk=;
 b=YQo5OZgReoOUjm3OoElP2z+uDzYgjpQZh1LonTd9BLZrT6viil+oTrgd
 3iYW8d6N3pXuTHu7LgpuyMhArau8YOfrduaGmkV2u/ASb+zpPX/BL3FgW
 dPg+Uvh6cID1tBfIR2weDBDoV2o1BUX+38+q9a/D1NtBiH+2o1y2vK6FF
 SWTOREJLVwSeKy5/SksqeFlaly9IsvQhA0N1xHFeb6eg6hZMLZEQxnWyg
 y64K1qsVyWLOY75CAcOmzcok/+5U4hxK9maChAL/wkBEtiQNT5UHgUUnl
 wlSIPQ9gK/YtdfLQs4wkecUZi+HRcvHkiG01J4ARJavNHPdM/vWg9C2N+ w==;
X-CSE-ConnectionGUID: IT1uq/0FRNqPk52NvLe50g==
X-CSE-MsgGUID: YAV4Rcl/TK6qcSwh+Y3z6w==
X-IronPort-AV: E=McAfee;i="6800,10657,11493"; a="55049146"
X-IronPort-AV: E=Sophos;i="6.16,315,1744095600"; d="scan'208";a="55049146"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Jul 2025 03:31:16 -0700
X-CSE-ConnectionGUID: WHMXf3oUSNGO65/QsWywEg==
X-CSE-MsgGUID: Z7a56Nm7SPi26DI+C6Ybfg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,315,1744095600"; d="scan'208";a="156863031"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Jul 2025 03:31:16 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Wed, 16 Jul 2025 03:31:15 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Wed, 16 Jul 2025 03:31:15 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (40.107.212.80)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Wed, 16 Jul 2025 03:31:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rKQUOdq6sNgrO4Y/D3hynWk4fGIC5bfAjUfVhh74jvG6ZYPRaLx/XLqUQsQ+zyHXDpPTurI5B/l7n/U3NWrHY4gSfsE8/BU1QJYcb+akAQfbA3aPciyd4rbqNI0oTcIVIiZKqgamabwp6+noM7kbR0yj9ARzsdKgjr9PtUW3DjWy15SbC9nzy5utUnh0T1umRXB668dAhienpG9GnkZor1p6Q4qW3Vmi3J75rLtBFYYDkYdMwNMnquG4T3v8S42nernLP/KmJyttELFwt9EzQ3YemipuYvl7fyRugzrJpPr0gszHEmf0GB6e7BYx2+3VYpgnws5DlEZLkV6ccCKCcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wsXhhlFYpO4O8Chwz5jFjSefQXXVDO8v/NcS3eqF3Zk=;
 b=tFBIRI3dkq6F5c7UKHvq58Ovn0407crMMnIUAsP0yMIw6hlD7NSP2D2QKBXus2SDRF1HwkB32MVW5C2StwNGLuOH93wv45JrWRQXSGq5GjVUH76Sok0/Vszp5dOjB6w17ssQ+IlYpHu2G7jNl3bi3As3k2vpn4j8Ekok2icaac1VAocLY8JjV6pHTayjgND9zTyuVbXyIE6o/adSHrae9UFkzA4D3hB1VZgDAeBbMNIczXfR/LqIQNSxoJdUG9haQjZf8VBkRmPY1BNlB3BRYnZklJ9jvY8TxjTxEPdD6AW75QEwYrz3zDZEhnu4f6lfvlRqUYRNywxTZ4e7+Sgsag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12)
 by PH0PR11MB4966.namprd11.prod.outlook.com (2603:10b6:510:42::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.32; Wed, 16 Jul
 2025 10:31:06 +0000
Received: from IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13]) by IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13%4]) with mapi id 15.20.8835.023; Wed, 16 Jul 2025
 10:31:05 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: "eric.auger@redhat.com" <eric.auger@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>, "mst@redhat.com" <mst@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>, "peterx@redhat.com"
 <peterx@redhat.com>, "ddutile@redhat.com" <ddutile@redhat.com>,
 "jgg@nvidia.com" <jgg@nvidia.com>, "nicolinc@nvidia.com"
 <nicolinc@nvidia.com>, "shameerali.kolothum.thodi@huawei.com"
 <shameerali.kolothum.thodi@huawei.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "clement.mathieu--drif@eviden.com"
 <clement.mathieu--drif@eviden.com>, "Tian, Kevin" <kevin.tian@intel.com>,
 "Liu, Yi L" <yi.l.liu@intel.com>, "Peng, Chao P" <chao.p.peng@intel.com>
Subject: RE: [PATCH v3 07/20] intel_iommu: Check for compatibility with
 IOMMUFD backed device when x-flts=on
Thread-Topic: [PATCH v3 07/20] intel_iommu: Check for compatibility with
 IOMMUFD backed device when x-flts=on
Thread-Index: AQHb7/hoBQVqCDKijEq37aEKMjw/RLQ0hlWAgAAOMLA=
Date: Wed, 16 Jul 2025 10:31:05 +0000
Message-ID: <IA3PR11MB9136C85F0799CB91572121FB9256A@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <20250708110601.633308-1-zhenzhong.duan@intel.com>
 <20250708110601.633308-8-zhenzhong.duan@intel.com>
 <342129d6-0b96-440c-83ac-e9b8bc5b18a0@redhat.com>
In-Reply-To: <342129d6-0b96-440c-83ac-e9b8bc5b18a0@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9136:EE_|PH0PR11MB4966:EE_
x-ms-office365-filtering-correlation-id: 00372090-b331-44f0-6a7b-08ddc453dedb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7416014|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?c1FaSDR1SVZTNGVBaGpQZFVNNUJub0FwZGhsQWJzQnVESzAvcGgwMytKalRK?=
 =?utf-8?B?Wmc4dmxVc3NnM2E3ZmdaR0lQeTFwM1BjcFpteXFrNWh2S0Vkcy8vdStQaXpV?=
 =?utf-8?B?b25WdjEwZXh1ZlJTZUMrMmsyTmlYcFM0a1Fabm5hVERvR1I2YjNpY0RFZUsy?=
 =?utf-8?B?ZjlrYWZDeDNmWkxpb0xPYWtpY0NBL2dOZ2hpUTFOckFVN1h3SGJ3NEt3dWhY?=
 =?utf-8?B?L0N1N3Z5cVNITitYdkZyUHpIeUR1U1N5RjMzK2VWdGhFb2E1QlJORkwzU1lY?=
 =?utf-8?B?aVlXSjBHVloxYlVXSTNPN3NUdHlsTFA1QjNueVlQU0Q3TEZNa1UvR2pNSHNs?=
 =?utf-8?B?NmRIWjdSczhCdFIrckp5Z291Skw0Unk4cDZSNWN4WkNMOEZoeFZXUld3RnRy?=
 =?utf-8?B?VWVOd1RXdktCakt6ZWlPWjkxQ1RxSXdQa1dCUmF3S0hsa01GZWtZTmVEMnZF?=
 =?utf-8?B?TWxrbzAzTXVkb1RSd25EMlBWQjhoNTlSZHJzVjZ4V3hnZUladFNwWDg5Wkdq?=
 =?utf-8?B?eWtrQVJTSUZveFZObVVFL2paSmF5emNUbnJKVHlZc3NQOFY5NUFsVkI1U3lR?=
 =?utf-8?B?VzIwTXMyNlE3OWZEcVAwWnZFYWFpK0FzZkdpWU9WT2R6QTlZS2FUSUt6Vys3?=
 =?utf-8?B?UGtqM1BvTmdTYzYvWlg3TFlPZWVPZzkyQ2pTZXFUeExjR1ZUdzZBOXZONlNR?=
 =?utf-8?B?cEc2UWRQVnB6cVBLMVpRRjRPVVY1ZTFXdWd6TWJ2YXdSb2szSmxKcWd6ZmtC?=
 =?utf-8?B?bVh5akFieStQK20xQTloMDZWKyttZERwVFJCUHkvN2dNSDM4L2dqZVZHT2ZR?=
 =?utf-8?B?ODdsaHQ5cWY5RGlzN0Yzd1cySG1jMlo1SEJsdmw1ZGQ2eGpYWEQ3RnZHS1pW?=
 =?utf-8?B?bFVPZ2xHTlovVXNKRmhnMW92dm5BSjRGekc1Wmp3aUs0dTRNSC91NHFTczRj?=
 =?utf-8?B?NXpRamhaSjZFNXVMNVc4ZDlYOFUvNmVLT0hSSmoveHpwWEZ6ZStMMlFVZUZC?=
 =?utf-8?B?TisyQmZyQnIzVVpRSklRMWNUcDlmYjRjUUl2ZGZzQmVDQlJCcEtpV29ieEpC?=
 =?utf-8?B?c2NubXRqT01uRlBxeTJKWUlYaG9MR3daZE10dW9xQzdzL2IzYm51VnpmeXRz?=
 =?utf-8?B?Mkh6czBvTkJhSlNHc1h5b0dVd1lRdXJMV0Z5QTF4UUpjNFNZZUxOOG1RbnBr?=
 =?utf-8?B?d1FMSWo5bEEreXRnaFdlNVJ3K0hEVlplTFRTU3lrSVFra0s4WUQ1VUNscm90?=
 =?utf-8?B?RXJ3M21paEcvU2loN3JOT0l0Sno1NXhGVUxwbHEzZVcrWExvczlCZkVZOXRj?=
 =?utf-8?B?SkYycXFWS1N3MVQ2eDRpdXFhUURlOS9RL0NjT0RTUDA3bnFLekJEZzhFRGFu?=
 =?utf-8?B?enVteC9PN2RQZng3Tlc3RU1YY2EzK3oyRWFrdUlKNGhLWWVianppV1hTMlFy?=
 =?utf-8?B?L2xWWURMamFLVkttbkJVa0Mrb004b1FCbHpmc1MvTEdqV2FQaFlQMjJ6d1lz?=
 =?utf-8?B?MklPOE1CclZJbU4yUGkyUzYwanRxd1NJRWhLUDBnZ3BEbzhsbnNUTnZYUWYw?=
 =?utf-8?B?Vk42TnBUeThvbHZENzNWeENiaWFLeldlWTREdmQ1Q2tsVU9TQmhXTXpaZ0h3?=
 =?utf-8?B?czF2M0JNWVJDQVZWMVB2YWxIZzk2OFZ3Wi9KQndsOXB3aVB5WUlsdS92blpW?=
 =?utf-8?B?WEpjcjVXU2FCSDI2aHJzdE9HNE00cVhSZXFsb203VDVoSDdTckV5aEkrRDV0?=
 =?utf-8?B?NHJ6Rm9sTng1WmZIb1JoK09JRHBjbzIycm02S05BUzhQc0xKUWg2Z0Qzei92?=
 =?utf-8?B?ZnoxVE5YU3hHaGNOK1p3N1RINkVPcDRSRXJWVFErb0MvRjNYL2lSRm12TTR5?=
 =?utf-8?B?dGNwTHM4OTNiTmhVL1Q3UllLcFJBMEZMczNGMFI0bzRESjZObDNBVUpnQ0du?=
 =?utf-8?B?SUdyTTFpQTltYlFtTTRwMi9KQ2FQaXdVamFKZU5tMVZFSEJCclhlQUsxSnlD?=
 =?utf-8?B?YUtNdGVhNHJBPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9136.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cGlkaThQZGdPbytjaUg0b0Y2b1ZVTEFtbDF5NU5xeGdUVHZjVFFZSG0zRnpF?=
 =?utf-8?B?RFRQTzFvTWE3d0NyaFRNdFYwNEc0K2tERHhENVZWS0ZBZzZQckc3Um5yaHRt?=
 =?utf-8?B?WHhTNkQrSFczNnZnQjQ3anNMdGp6SitvVm5JdjZkcmphaGoxa3JoY3RDMGhT?=
 =?utf-8?B?ajhXdWMyVGI2QjRsT2k3RTNDWmxyS1JNNURCTGoweHZSUnUwODNXUTNLM0Zk?=
 =?utf-8?B?RzhkMmFuRnNmbXhRUVFCVFgzMWhrckVjTFBvaWdUMWh3L1RaVEM1NjlUTXhX?=
 =?utf-8?B?d040TXNmZHZmTW10YWFnaHlWRzh5N3FKalo5VE4yQTRiZmJWNEoxS1U4SnVt?=
 =?utf-8?B?VVJxdFNTcjByYjdJZW8zeW9pMFFxVWJIc1YxWHhVdjl3K2ZLSWR0bnpuWFBI?=
 =?utf-8?B?MzJ0bVU4cVQyek14RysxRWFaM1RCSHVmYVJzb09HaDE5N05vTlNtVEozajEw?=
 =?utf-8?B?R2Z2UE1xL1J5TFZ6blYyYTM5RDBjaVRwbk1SYXBlWk8wdC9oazROZnloKzUz?=
 =?utf-8?B?d3ZndnhtdlZNNTgwMUFPMmFObDNpalVNUWVHQkN3SnJOcXhpWFVTL2dFWHoy?=
 =?utf-8?B?UnF1aEtSTmdPOHRKTzRKSGlSYVBISWNSSHJlTmY3dVAxb0dRYm41NXJENklG?=
 =?utf-8?B?Q3FvUGtubTZocEVEZi9QQkh2ZUJLcGxOcEt5UGxSMUNNd0pLRnJVMEJlZkhD?=
 =?utf-8?B?dDlvZDdBTm9XNmJhWEg0NHk0Q3VYS05GcWNrQ29mZXB3T0ZBUDRsOG9DMDdz?=
 =?utf-8?B?cTBZK3RaaHJZYUczTEc1YitZeldaS2ZxbXVDVyt6SkcvOFZ3alpESnlUMklQ?=
 =?utf-8?B?elVJWkJWSTduR2p0ZHl4STJVT2tqS0E2LzN2RFZmUHYxaGFpSmliVWd3RjFI?=
 =?utf-8?B?V2czMUQ1QWZRSnlFR2JkekE5TWJoZjY5Qnl2SlR3UTNPSlFBWGRNMUZRUXlR?=
 =?utf-8?B?M29mOEpZMGxtVzJFZ2UvOWFiNTdjemRhcllETk14S0RFK05rdmhwRG9GZjZ0?=
 =?utf-8?B?VUN4K2cwdmk3ZWVXSmFIcytBSmtGT1FDU3BQRkUvamU3QnlNUHV4U1o0aVFu?=
 =?utf-8?B?eXg5TFhwajF2QkNoUHpvUFdLblBuVk9QcS96RnBoaHJqS1FLWG1KSG13Uk5w?=
 =?utf-8?B?Z1k0RTBGeno1b3JjSytXUVR6NVNxNUIzc2F3Z2RaQjFTRWVQc0dKZWxhUXNI?=
 =?utf-8?B?bXF2MkNvNzk1QnhoSlhoSm12N1p2RjBSV09sVm5ndUhVMFFoZjl3MndOc1pj?=
 =?utf-8?B?dExtWjcwOXBxZEdYL01iVXNzOUlzcElYWnE0a3V2eVlCcXlLTHVMZHlyQkhF?=
 =?utf-8?B?M3p3U2FTTFFMbTRDbnhES3poZzV5YllFbmt0UElzWENhTkhrczlRNWtxdk9n?=
 =?utf-8?B?cGt6TC9lNkdFMmlRTEJCcWZtdFVLZm5EMlp5MzJLVE91K01mVGFITzg4TWF2?=
 =?utf-8?B?VURYTzhmMGVFZnZsb2RGbnJ4SUpnZXdrWDlic1lGd2tVbHVHMkg5RkZqbUwy?=
 =?utf-8?B?WlNDS1E1Q0p0bmdtVUhzZW1QYkI3NDJRWGlVZ0hGVTR0S3NXQ0FQRjdsbEtK?=
 =?utf-8?B?Qk93WXlWL2FlV05lTEFWcTVROTl2Szh6M29yaG9ja2s5SUNtNjNEUXcxU2JQ?=
 =?utf-8?B?OWNUUEVscEQrajVhZmpXYTRSRllQS1ZkeW03QnNwcW8xS1J4cy9URXNzS3l2?=
 =?utf-8?B?NXNpWTV3M3pJMDZKT244QVYxWEJnVTVXSXpGSjdJdWh2U2xVaEZJcFVncmhW?=
 =?utf-8?B?SEpmeEhIOFh0WEp2UzlYRnp5QzBLMzNJbVJQZ1oyZlh2TDVpR3E5VUhUb1Fh?=
 =?utf-8?B?clRyUmNrY0xZRnIwNFVHeVhuZVZHNmN2cGhmNE8rQ0hveTlMenpNa0JsSysz?=
 =?utf-8?B?WElTN1Z6T3JMTzdlTVdBMGZPcEVkeWh5MkRFdXptQ0VFOG9wZVpXd0l1Mkx2?=
 =?utf-8?B?QTdFWWJYa2JXL2hVRXF2SG0zR3RaQmZ6UnJ0c1JodHNLR1luWlVRVlRHZzlo?=
 =?utf-8?B?WHNjbmtIU3NZandUaHJoM0RxOGpTVGNwVEF4UUFuRUF6Skx6UTgrdSswVXg0?=
 =?utf-8?B?cnJoRi9mNUlNaXE3blhwKys0VnFNRzVJaUtiejRLblZOb3dlZnJsR3I1aHpZ?=
 =?utf-8?Q?GyswFuaYuD0FuDW7AObbdVQv8?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9136.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00372090-b331-44f0-6a7b-08ddc453dedb
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jul 2025 10:31:05.6452 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nuPRq1+cpwatTGk1keHx/TVeT13uejF8tE3EL9bU8+69DCSuwMmrD3xyfLGo9ZVKFVIP0n54rfMI/tq68IzglQoo/mc7hRoNcqxJx/mqYtw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4966
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.15;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

SGkgRXJpYywNCg0KPi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+RnJvbTogRXJpYyBBdWdl
ciA8ZXJpYy5hdWdlckByZWRoYXQuY29tPg0KPlN1YmplY3Q6IFJlOiBbUEFUQ0ggdjMgMDcvMjBd
IGludGVsX2lvbW11OiBDaGVjayBmb3IgY29tcGF0aWJpbGl0eSB3aXRoDQo+SU9NTVVGRCBiYWNr
ZWQgZGV2aWNlIHdoZW4geC1mbHRzPW9uDQo+DQo+SGkgWmhlbnpob25nLA0KPg0KPk9uIDcvOC8y
NSAxOjA1IFBNLCBaaGVuemhvbmcgRHVhbiB3cm90ZToNCj4+IFdoZW4gdklPTU1VIGlzIGNvbmZp
Z3VyZWQgeC1mbHRzPW9uIGluIHNjYWxhYmxlIG1vZGUsIHN0YWdlLTEgcGFnZSB0YWJsZQ0KPj4g
aXMgcGFzc2VkIHRvIGhvc3QgdG8gY29uc3RydWN0IG5lc3RlZCBwYWdlIHRhYmxlLiBXZSBuZWVk
IHRvIGNoZWNrDQo+PiBjb21wYXRpYmlsaXR5IG9mIHNvbWUgY3JpdGljYWwgSU9NTVUgY2FwYWJp
bGl0aWVzIGJldHdlZW4gdklPTU1VIGFuZA0KPj4gaG9zdCBJT01NVSB0byBlbnN1cmUgZ3Vlc3Qg
c3RhZ2UtMSBwYWdlIHRhYmxlIGNvdWxkIGJlIHVzZWQgYnkgaG9zdC4NCj4+DQo+PiBGb3IgaW5z
dGFuY2UsIHZJT01NVSBzdXBwb3J0cyBzdGFnZS0xIDFHQiBodWdlIHBhZ2UgbWFwcGluZywgYnV0
IGhvc3QNCj4+IGRvZXMgbm90LCB0aGVuIHRoaXMgSU9NTVVGRCBiYWNrZWQgZGV2aWNlIHNob3Vs
ZCBmYWlsLg0KPj4NCj4+IEV2ZW4gb2YgdGhlIGNoZWNrcyBwYXNzLCBmb3Igbm93IHdlIHdpbGxp
bmdseSByZWplY3QgdGhlIGFzc29jaWF0aW9uDQo+PiBiZWNhdXNlIGFsbCB0aGUgYml0cyBhcmUg
bm90IHRoZXJlIHlldC4NCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBZaSBMaXUgPHlpLmwubGl1QGlu
dGVsLmNvbT4NCj4+IFNpZ25lZC1vZmYtYnk6IFpoZW56aG9uZyBEdWFuIDx6aGVuemhvbmcuZHVh
bkBpbnRlbC5jb20+DQo+PiAtLS0NCj4+ICBody9pMzg2L2ludGVsX2lvbW11LmMgICAgICAgICAg
fCAzMA0KPisrKysrKysrKysrKysrKysrKysrKysrKysrKysrLQ0KPj4gIGh3L2kzODYvaW50ZWxf
aW9tbXVfaW50ZXJuYWwuaCB8ICAxICsNCj4+ICAyIGZpbGVzIGNoYW5nZWQsIDMwIGluc2VydGlv
bnMoKyksIDEgZGVsZXRpb24oLSkNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvaHcvaTM4Ni9pbnRlbF9p
b21tdS5jIGIvaHcvaTM4Ni9pbnRlbF9pb21tdS5jDQo+PiBpbmRleCBlOTBmZDJmMjhmLi5jNTdj
YTAyY2RkIDEwMDY0NA0KPj4gLS0tIGEvaHcvaTM4Ni9pbnRlbF9pb21tdS5jDQo+PiArKysgYi9o
dy9pMzg2L2ludGVsX2lvbW11LmMNCj4+IEBAIC00MCw2ICs0MCw3IEBADQo+PiAgI2luY2x1ZGUg
Imt2bS9rdm1faTM4Ni5oIg0KPj4gICNpbmNsdWRlICJtaWdyYXRpb24vdm1zdGF0ZS5oIg0KPj4g
ICNpbmNsdWRlICJ0cmFjZS5oIg0KPj4gKyNpbmNsdWRlICJzeXN0ZW0vaW9tbXVmZC5oIg0KPj4N
Cj4+ICAvKiBjb250ZXh0IGVudHJ5IG9wZXJhdGlvbnMgKi8NCj4+ICAjZGVmaW5lIFZURF9DRV9H
RVRfUklEMlBBU0lEKGNlKSBcDQo+PiBAQCAtNDM1NSw3ICs0MzU2LDM0IEBAIHN0YXRpYyBib29s
IHZ0ZF9jaGVja19oaW9kKEludGVsSU9NTVVTdGF0ZSAqcywNCj5Ib3N0SU9NTVVEZXZpY2UgKmhp
b2QsDQo+PiAgICAgICAgICByZXR1cm4gdHJ1ZTsNCj4+ICAgICAgfQ0KPj4NCj4+IC0gICAgZXJy
b3Jfc2V0ZyhlcnJwLCAiaG9zdCBkZXZpY2UgaXMgdW5jb21wYXRpYmxlIHdpdGggc3RhZ2UtMQ0K
PnRyYW5zbGF0aW9uIik7DQo+PiArI2lmZGVmIENPTkZJR19JT01NVUZEDQo+PiArICAgIHN0cnVj
dCBIb3N0SU9NTVVEZXZpY2VDYXBzICpjYXBzID0gJmhpb2QtPmNhcHM7DQo+PiArICAgIHN0cnVj
dCBpb21tdV9od19pbmZvX3Z0ZCAqdnRkID0gJmNhcHMtPnZlbmRvcl9jYXBzLnZ0ZDsNCj4NCj5J
IGFtIG5vdyBjb25mdXNlZCBhYm91dCBob3cgdGhpcyByZWxhdGVzIHRvIHZ0ZF9nZXRfdmlvbW11
X2NhcCgpLg0KPlBDSUlPTU1VT3BzLnNldF9pb21tdV9kZXZpY2UgPSB2dGRfZGV2X3NldF9pb21t
dV9kZXZpY2UgY2FsbHMNCj52dGRfY2hlY2tfaGlvZCgpDQo+dmlvbW11IG1pZ2h0IHJldHVybiBI
V19ORVNURURfQ0FQIHRocm91Z2gNCj5QQ0lJT01NVU9wcy5nZXRfdmlvbW11X2NhcA0KPndpdGhv
dXQgbWFraW5nIHN1cmUgdGhlIHVuZGVybHlpbmcgSFcgSU9NTVUgZG9lcyBzdXBwb3J0IGl0LiBJ
cyB0aGF0IGENCj5jb3JyZWN0IHVuZGVyc3RhbmRpbmc/IE1heWJlIHdlIHNob3VsZCBjbGFyaWZ5
IHRoZSBjYWxsaW5nIG9yZGVyIGJldHdlZW4NCj5zZXRfaW9tbXVfZGV2aWNlIHZzIGdldF92aW9t
bXVfY2FwPyBDb3VsZCB3ZSBjaGVjayBIVyBJT01NVQ0KPnByZXJlcXVpc2l0ZXMgaW4gdnRkX2dl
dF92aW9tbXVfY2FwKCkgYnkgZW5mb3JjaW5nIHRoaXMgaXMgY2FsbGVkIGFmdGVyDQo+c2V0X2lv
bW11X2RldmljZS4gSSB0aGluayB3ZSBzaG91bGQgY2xhcmlmeSB0aGUgZXhhY3Qgc2VtYW50aWMg
b2YNCj5nZXRfdmlvbW11X2NhcCgpLlRoYW5rcyBFcmljDQoNCk15IHVuZGVyc3RhbmRpbmcgZ2V0
X3Zpb21tdV9jYXAoKSByZXR1cm5zIHB1cmUgdklPTU1VJ3MgY2FwYWJpbGl0aWVzDQp3aXRoIG5v
IGhvc3QgSU9NTVUncyBjYXBhYmlsaXRpZXMgaW52b2x2ZWQuDQoNCkZvciBleGFtcGxlLCByZXR1
cm5lZCBIV19ORVNURURfQ0FQIG1lYW5zIHRoaXMgdklPTU1VIGhhcyBjb2RlDQp0byBzdXBwb3J0
IGNyZWF0aW5nIG5lc3RlZCBod3B0IGFuZCBhdHRhY2hpbmcsIG5vIG1hdHRlciBpZiBob3N0IElP
TU1VDQpzdXBwb3J0cyBuZXN0aW5nIG9yIG5vdC4NCg0KVGhlIGNvbXBhdGliaWxpdHkgY2hlY2sg
YmV0d2VlbiBob3N0IElPTU1VIHZzIHZJT01NVSBpcyBkb25lIGluDQpzZXRfaW9tbXVfZGV2aWNl
KCksIHNlZSB2dGRfY2hlY2tfaGlvZCgpLg0KDQpJdCdzIHRvbyBsYXRlIGZvciBWRklPIHRvIGNh
bGwgZ2V0X3Zpb21tdV9jYXAoKSBhZnRlciBzZXRfaW9tbXVfZGV2aWNlKCkNCmJlY2F1c2Ugd2Ug
bmVlZCBnZXRfdmlvbW11X2NhcCgpIHRvIGRldGVybWluZSBpZiBjcmVhdGluZyBuZXN0ZWQgcGFy
ZW50DQpod3B0IG9yIG5vdCBhdCBhdHRhY2hpbmcgc3RhZ2UuDQoNCklmIGhvc3QgZG9lc24ndCBz
dXBwb3J0IG5lc3RpbmcsIHRoZW4gY3JlYXRpbmcgbmVzdGVkIHBhcmVudCBod3B0IHdpbGwgZmFp
bA0KZWFybHkgaW4gdmZpbyByZWFsaXplIGJlZm9yZSB2dGRfY2hlY2tfaGlvZCgpIGlzIGNhbGxl
ZCBhbmQgd2UgZmFpbCB0aGUgaG90cGx1Zy4NCg0KVGhhbmtzDQpaaGVuemhvbmcNCg==

