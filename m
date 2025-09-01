Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60F2BCA0FF0
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Sep 2025 05:34:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usxBK-0002NL-2m; Mon, 01 Sep 2025 01:34:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1usxBH-0002KI-Dc
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 01:34:15 -0400
Received: from mgamail.intel.com ([198.175.65.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1usxB9-0005hX-0w
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 01:34:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1756704847; x=1788240847;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=YmEFCmYRywuhdX3v6EvERuc5Q7nQU7TxMYgPBEU1WiI=;
 b=WWBqAqBttlpM3TVOLkA6/y8kjGXD40M0tkUppGjS26NcFi+z56H0IJBO
 la3zSjeV6H+FMTSWwgSSaCY9sEsHM/5FN8cSY0k8b4XeJnto4CDaLGxFr
 yr8BWbU5ToYppjKfZn9JlQce8zDwr8etmCEK1grm5S4CLkZgCIMtd+FVS
 7t/RYP5dgs1CnNIZIQ4Ida/NNR0Kq30/I1xHVRejCtf2d7Qb6Xa+FrSux
 JGFFCAR5F7rq/L++DGAehHAH0KQzWMStJiUwHkrUx6nvygBVpK5tEUMVX
 hJ+w2RQoQMRFc3hNV/Oe/AcIFiGey8j+5w9yWh1pNptYVsrMv1c1pczX3 w==;
X-CSE-ConnectionGUID: xybuyfVYTP+1QHoaXGCS6w==
X-CSE-MsgGUID: VqsQyQgKS/ahHyBgYPuWxQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="58820290"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; d="scan'208";a="58820290"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Aug 2025 22:34:02 -0700
X-CSE-ConnectionGUID: 7LUaKooYS+GA0FFtYjSkrA==
X-CSE-MsgGUID: 35lNBW+xQle9NhTgtJ+V/g==
X-ExtLoop1: 1
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Aug 2025 22:34:01 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Sun, 31 Aug 2025 22:33:59 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Sun, 31 Aug 2025 22:33:59 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (40.107.94.76) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Sun, 31 Aug 2025 22:33:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qZyK9C/oM0ZpWh2CTh8HNUs1HIf3oupnQWyiFJS4sJAisAyknnV8vyP9gLssKczB7rb9BwAxieeBAqqLLsC3yJAbgv8v0pyj1qPRlUoBrjAbIl3q0O4raZP+bafdtWbkeHza7cM2znbTv5w5Pw0oZqiTIfImQFtrPBsUiR4G81bi2l+8DNFaYogr+f4EVxAriiyfaRuTF0rIphnAlG8WpJ+sUWg6RzgALQ7Jce/oR4qRo9Q9uea6wSl1DLlz5fV1oU0wN83JuU23FtlW7N3Tjb9iaH9ANKN1vhX9uOPxZjnLM/If8tVoxQTGecwro215axuJCnyddVYEJJjHYUrkRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YmEFCmYRywuhdX3v6EvERuc5Q7nQU7TxMYgPBEU1WiI=;
 b=mOpTrKLgv+a3dUHaycaT3aXApzhlwZNAAgxE6JQOhovkzML4FhngqjnWFm49fCUJX4xXcfBBqXLH3riFSA/LYGHNVKH9IUboi9viB7gOe+AnkjWtQf2xAXYijU4AJO3ehy5dgVOkf8ywlITAYrmWbfGCmyM4d7kk4ECLX+i1WfnNh75DPxK984Aa4hruTsab1f3jqDN3spnPOmLwBYPfrl1R8KlN8wdECoF/WTpNvOcnl8NKLsKXzn8m4FLc6tO8cfgTM2pRkldGfKzgpXQfbC+YHLcXwt8m+EER59ve0UDOspp9CE/8zoX1BuousMh3tiVrOdYq+yD+mZAGaFQbXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12)
 by PH7PR11MB6772.namprd11.prod.outlook.com (2603:10b6:510:1b6::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.21; Mon, 1 Sep
 2025 05:33:58 +0000
Received: from IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13]) by IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13%4]) with mapi id 15.20.9052.019; Mon, 1 Sep 2025
 05:33:58 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: "Liu, Yi L" <yi.l.liu@intel.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>, "eric.auger@redhat.com"
 <eric.auger@redhat.com>, "mst@redhat.com" <mst@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>, "peterx@redhat.com"
 <peterx@redhat.com>, "ddutile@redhat.com" <ddutile@redhat.com>,
 "jgg@nvidia.com" <jgg@nvidia.com>, "nicolinc@nvidia.com"
 <nicolinc@nvidia.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "clement.mathieu--drif@eviden.com"
 <clement.mathieu--drif@eviden.com>, "Tian, Kevin" <kevin.tian@intel.com>,
 "Peng, Chao P" <chao.p.peng@intel.com>
Subject: RE: [PATCH v5 10/21] intel_iommu: Introduce two helpers
 vtd_as_from/to_iommu_pasid_locked
Thread-Topic: [PATCH v5 10/21] intel_iommu: Introduce two helpers
 vtd_as_from/to_iommu_pasid_locked
Thread-Index: AQHcEy/mQAz0RvAeWUKyLIetcP08vLR3+YCAgAXhv6A=
Date: Mon, 1 Sep 2025 05:33:57 +0000
Message-ID: <IA3PR11MB913629651A0A69304F18FD719207A@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <20250822064101.123526-1-zhenzhong.duan@intel.com>
 <20250822064101.123526-11-zhenzhong.duan@intel.com>
 <a8e8ed01-8e37-467a-8e95-8afc2f6a16e3@intel.com>
In-Reply-To: <a8e8ed01-8e37-467a-8e95-8afc2f6a16e3@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9136:EE_|PH7PR11MB6772:EE_
x-ms-office365-filtering-correlation-id: 81138e7f-511d-41ba-1b83-08dde919261c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7416014|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?cndsZmkyY0g5ZjI1TG1VeWl6eVVjR3hMY01NVStlejRzeFdaYlBQaGRGRThU?=
 =?utf-8?B?bUU5SWtBaE9nOU5ScVEvanBPdTFmalVaRFpwOGZ0T3ZnK2JRT01hUnQveXNK?=
 =?utf-8?B?WVlCMGtVWU8yYVVtOHA0QVdkdHZ5cEFRQ0k0c0NXdHRmK1I0UkRrQlhHMHlZ?=
 =?utf-8?B?UW9xZzJpWGx5MU90UmJiSWRMNHJhNHFiNU9Vc1Bqek02VGF1SUlRaVVRcDRG?=
 =?utf-8?B?RnpFTVFidWJZK3RQeXUxaVl1ZVNUTWM2ZWVMVno1K3JxS1VzeUUreXcxclRN?=
 =?utf-8?B?VzB3WFRhRW9mejk3S0R4VzByTnNxK205dEVOVlVUT09oalBoMlhIN3k5cmQv?=
 =?utf-8?B?RDcrQWluK0ZpVTdhWkdxZXNLdmE2Zkt4LytJVHZTSno3bk9XR3lBbVZKUml1?=
 =?utf-8?B?dTVubm5SVElKTkdsalFMYjNxcDVQWE1VZlZGeERYN3BmTHZBN1ByTXdOelhO?=
 =?utf-8?B?NURBWHVJM2dLektZUTVCTkhOK0U4OWs4eUF1T3BWS1ZRUTR2RzlkdGNEWjBB?=
 =?utf-8?B?SUdkQ2wvT0ZtaTRDNHJnSkpNdzRORkdxSk1ocGFmMTRLTms2cURqVDQ1VStB?=
 =?utf-8?B?QzFrYkJ2V1E3UW40MHF5VmhvdkpNcEdzWTBWeHZnSUpjT0w2RDZpSks4MUhD?=
 =?utf-8?B?ZTlEODBscGNuMUsyUG1UNjA0M0dZaUMrbkhadGlRVHlidDJBbURvNy9mUytF?=
 =?utf-8?B?MmNacVRQdExzSEYvSDh2Wi9RUldMTytqQjlSOEc2a2grYmJFUmxwQTNhMEtR?=
 =?utf-8?B?VXhNSGxWSHloN2ZINWsyY2IrUGFGb0I2RzgxcUNMVnlPNUlveHBTeXhqNGFG?=
 =?utf-8?B?N2Y5QTJ4aXFLVmZuU1N5c28zTytwSXJxbW1JeDR0Nnd0MzhxdS9pN0NsUWdJ?=
 =?utf-8?B?ZlJmbGZXSjdvUDd6SVQ0R3V2a1JiajFhYzFhczkxRnZuT05oTnA5TlUzNEJy?=
 =?utf-8?B?TVBmNmR0Q01qV1R5S1JZaHRxQzJFeTBSblRXcDdwNFc4VVZaWVN1czBJWFpk?=
 =?utf-8?B?VkxwZTA1SCtiMkhZQkF1Zm5Tei9tZElwcDlwYUZQZkwvSG5la2FzOHdZb1JE?=
 =?utf-8?B?V3ppc2FJMWtybG1XSVZmYVcyWExCdk05MGQxcXpsbE9OKzdPYnRnMENidTZQ?=
 =?utf-8?B?TXVNNm1sK2prdXFQdi9IbElEZE1MSUhDcTl2U3BlSk5ma2hDdkYzRm5wWDE1?=
 =?utf-8?B?cHo4YTZGbk5NOVl0d1ZET2dHMjVrYW5LSXEvWmVjSjM4Qk9YZjd4ZkRwcDJ4?=
 =?utf-8?B?d2EyYU4yNDBXSjNyT28rb1ZYclhkYkwvZ3dONGNJL2JzM1VvNkNtU3dUaUl1?=
 =?utf-8?B?U0dCM1NjeWdkalU0VUZjYkNicTU5SWg0VjZiVGZreklPMHJRSEdaSzRyNXlF?=
 =?utf-8?B?T0dUMVU3TGFvN3FHcy9CTHoxRnBRYXNBNDZwSGNwTTN0QXpXQ1NRYm16UmZY?=
 =?utf-8?B?a2pwS2ZCa2ZiU2ZHQmFtaEV2K0N1NWcxUm1JaFQrbFMxRHAzSkFCNjUvV1pH?=
 =?utf-8?B?aTZLNTY1RkpTOVVUVFJuejNFRnU2RytvMTQySUNscnFKazR0M1JmNE5SY0dr?=
 =?utf-8?B?Yy91aWdGeFIzZ0IrakRDQUhkNEhzaFFZVnR3bmhKMXlXc1hHR3BhRFMxbGlr?=
 =?utf-8?B?YkhhMy8wVERpdytyRi8zeE9YS1drcnEzNExZTjhkNEFaY3RqUDZ2OHQ2Ry9n?=
 =?utf-8?B?blVxMDRYZzBxRm1LS0lWZm5BUXJuOE9XSFBKdGt3c2pIK1I0YkFNQkdsZFBZ?=
 =?utf-8?B?eUZQTGM5bkwyKy9JN2Y3STFiVmg5aUxsL055QkZaUEtMVmJoajBmVmsrdGxa?=
 =?utf-8?B?bHJuSVFvWmlQT3RmL0lnYXlJUjdzVk84Mk9xWHM1WE5BVEVoNTBFNXFwWDRZ?=
 =?utf-8?B?ajB0SWRVNzJGdC9LZFN4bWRxMEJESk1TZnBnRDgxbVBiV1NNU1FTRTcwb1Jh?=
 =?utf-8?B?QkgxRVJJYjF4d1QvclZiNWlCbWptTmhxOVU1VnpxcGN2bncvVDByQlNtV0Qz?=
 =?utf-8?Q?kZHpu/yFPocVCcELuP83GInYtPbOXA=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9136.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZzRHd01IOExRS0ZLbE1iSjdCWVpwc2VZQWVlYlB1a0JON0ozcWYwbDdaanBm?=
 =?utf-8?B?cTN1MXFtckFycXhEMzIvKzVNSmRLMit1dm9tZ0hIN3d0a2MrUjBxYWZta3Nm?=
 =?utf-8?B?L2FKcExVSFV2OFdhYmV6VXpNcDBneFdtcklsYmQ0NGZFaENwM1grWnM2dm1V?=
 =?utf-8?B?WkZndkN5V2tQVC9yTmNHd3QvVUxvZ1hIRVAxWjNvMTY2dnhtRU9iNUcrVnBu?=
 =?utf-8?B?YkpVclhlL2tCSFBSbUdFZm9LckRaQlNFQ3l1WXcrb0tVQVQvMkw1MFU4QTZz?=
 =?utf-8?B?TG8xTExFcTVxYjU4SkNjcklkVjljaEFyWVkzamc2dmNtOHl3SmtRZXU2d1Nt?=
 =?utf-8?B?RytzeTlCN3hSelRoWFZIcEhFWlFPMlU0djYrZFNaMG9BbUJ4eFJGSXVwMmhT?=
 =?utf-8?B?ZHRMWHBCRHVlQ05FR3o4N0dHTjFEY3NrZWVlR25lTHNBaThOLzlMblRhaWth?=
 =?utf-8?B?YlNMaVBmeW80UVVSQ2VNdGVxT2NOSnlrVG82dHdYZ0RyR2IzcERIYnJDZlJJ?=
 =?utf-8?B?NVlhK0pQaWk2K0lFRXVQYTV3Qnk1NXRzRXlPMmVsQlVmek1SSHBJWk00R0pj?=
 =?utf-8?B?aXFDcVFlcS9Ob2VCeVVwQWwxY055VWxDZVVQaGJzUUM5empUWHIwM2RFUDRy?=
 =?utf-8?B?TnlINTJFaHpBTlJFVWlsRS9JMTJ6TVNvUWxqdUtab0ZzejUvWGFPUTVreWhr?=
 =?utf-8?B?UEdQUnBCUWFVMzU4WjcrODZVMmZWdWx3d2laZ1Y1ekFUVDdudVBVeS9kaUd4?=
 =?utf-8?B?YlF5WWFwbnBYZXJlRnhnMVdiKzhNUmhGQ01qUTllbUh0c0hrVjJOWEx4Rytx?=
 =?utf-8?B?aEo5U2ZWQVc0VjVLTlBzWUdHOFpJUlI2Z3pvM2ova1Ivb016c0NsWjVlOS9x?=
 =?utf-8?B?MTg5RE5DaW1QbzQvc3RHeE1TM054Mi9mczR3MXY5VGVKRklueXd4MWhHeFJm?=
 =?utf-8?B?YzUzejB4ODJhTGUxRDhscmF5bDQ5eHVNWTZKaEluYTVDR0F1bjYraWdIWWFv?=
 =?utf-8?B?RlRyd2tXdCtocDlwVll6OVJsbVRvZFpRREtoMGtUaUhWdGM2VEZ0YnNDVXZ0?=
 =?utf-8?B?N3N6bnRINEhHaFZOMGJuaHYrZjNCTUxNallNK214RUkzQlNGd0pQOFFQRFZN?=
 =?utf-8?B?NnpCK1JkbzNjL1NLWjhzVldvamgwVkd1eEprVjdvUWFQSlpqaG1UODIyVENz?=
 =?utf-8?B?dkNpRlVlOWgySjhzc004RFg0S1ZIdEJwUlI4bHJNZElCSkR5SzU3SndRTjFW?=
 =?utf-8?B?UFBqcXZ6SDJIKzBYcUJHanZJRVRVK05jSXdVK3lEcnJSWitNbjlqVzhEUE9m?=
 =?utf-8?B?NVhoOHFDamFMcHAxekRlcXBZUXJtc0Q3NG50S0pPODdzVU9DZXNpcWJ2b0p1?=
 =?utf-8?B?WHpoVDhuNlpiWkF3blVzaExtWUZYTmp4RURqVjRaRkxCR090d0NzVUZ3T3Vp?=
 =?utf-8?B?UjJoVFozbnhaYWZMUFdmQk5mK0NodlF5Q0xuMndlU1pnZzY2TFBBV2h3NFJo?=
 =?utf-8?B?em14Y3loOS9iUWlTdFZLQkx3ZVBmNStWamRLZktHd1VkeWtCN0Z2SzZ2cDRH?=
 =?utf-8?B?RTBYOCtVK2dja1RwUm5GTE5zNkt6SUpBZWY4eVpjM3h3Q1F0VEJFMHhyQ2xH?=
 =?utf-8?B?NzZJYmNBR1hpR0VqRUdWcjdjRDB3S2ZrVnhtcjdQb2xISWl1eFQ4cXM2c0tQ?=
 =?utf-8?B?bDhRRy8yd3hUV0xxSHl3ZUZ0Mk1vOURjelZ5V1M4NGFrNFZPeDQ1MU45Vk0v?=
 =?utf-8?B?bk14QVNBY3BqQTlRQmZOZUQxT0FmTDQ0U0d3bVJkV2x6bzVuUkRIN3JrVFho?=
 =?utf-8?B?aEVnWGJVUkpkQWk1aW1VbUl3dVBXSkh6ckg0TW1rUlRtRFdFWnovU2dIb0tZ?=
 =?utf-8?B?S3RGQkx4OHUrWFVwbldTYUowYmtpOWxwMVQ3VW5WU3E2ZEE1dEJ0NUUrampB?=
 =?utf-8?B?TWN0L2lLbkVTYlJLcFhTZ2FtTUxrRytLVlE2T3lxVVI3QXpON3dLeE90T205?=
 =?utf-8?B?R1JWZkNLeHVFSDc2MGdjWDJaVlgzL0VubWtDWFdmTTZjd3I3SjBwMXo0VVpV?=
 =?utf-8?B?V3E3RGlzRkFlYnhxZ0lBMk16SnUzZTMyQVg4dmhreExtcTVVYTJUMWNmZ2hl?=
 =?utf-8?Q?iNbQfPz0V0Kf+uc2ZsvxAk0Xz?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9136.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81138e7f-511d-41ba-1b83-08dde919261c
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Sep 2025 05:33:57.9111 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5vePBNRPCVEEhRVCM2JdCLHBP9/Dvjla9R7h5dNX62jlLmbt8XKWRC+0/KW1Lb/tFwQrnMwp1o6rzQPKebuomwsvR7WdAr1djKu/7Wfr7/4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6772
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.21;
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IExpdSwgWWkgTCA8eWkubC5s
aXVAaW50ZWwuY29tPg0KPlN1YmplY3Q6IFJlOiBbUEFUQ0ggdjUgMTAvMjFdIGludGVsX2lvbW11
OiBJbnRyb2R1Y2UgdHdvIGhlbHBlcnMNCj52dGRfYXNfZnJvbS90b19pb21tdV9wYXNpZF9sb2Nr
ZWQNCj4NCj5PbiAyMDI1LzgvMjIgMTQ6NDAsIFpoZW56aG9uZyBEdWFuIHdyb3RlOg0KPj4gUENJ
IGRldmljZSBzdXBwb3J0cyB0d28gcmVxdWVzdCB0eXBlcywgUmVxdWVzdHMtd2l0aG91dC1QQVNJ
RCBhbmQNCj4+IFJlcXVlc3RzLXdpdGgtUEFTSUQuIFJlcXVlc3RzLXdpdGhvdXQtUEFTSUQgZG9l
c24ndCBpbmNsdWRlIGEgUEFTSUQgVExQDQo+PiBwcmVmaXgsIElPTU1VIGZldGNoZXMgcmlkX3Bh
c2lkIGZyb20gY29udGV4dCBlbnRyeSBhbmQgdXNlIGl0IGFzIElPTU1VJ3MNCj4+IHBhc2lkIHRv
IGluZGV4IHBhc2lkIHRhYmxlLg0KPj4NCj4+IFNvIHdlIG5lZWQgdG8gdHJhbnNsYXRlIGJldHdl
ZW4gUENJJ3MgcGFzaWQgYW5kIElPTU1VJ3MgcGFzaWQgc3BlY2lhbGx5DQo+PiBmb3IgUmVxdWVz
dHMtd2l0aG91dC1QQVNJRCwgZS5nLiwgUENJX05PX1BBU0lEKC0xKSA8LT4gcmlkX3Bhc2lkLg0K
Pj4gRm9yIFJlcXVlc3RzLXdpdGgtUEFTSUQsIFBDSSdzIHBhc2lkIGFuZCBJT01NVSdzIHBhc2lk
IGFyZSBzYW1lIHZhbHVlLg0KPj4NCj4+IHZ0ZF9hc19mcm9tX2lvbW11X3Bhc2lkX2xvY2tlZCgp
IHRyYW5zbGF0ZXMgZnJvbSBCREYraW9tbXVfcGFzaWQgdG8NCj52dGRfYXMNCj4+IHdoaWNoIGNv
bnRhaW5zIFBDSSdzIHBhc2lkIHZ0ZF9hcy0+cGFzaWQuDQo+Pg0KPj4gdnRkX2FzX3RvX2lvbW11
X3Bhc2lkX2xvY2tlZCgpIHRyYW5zbGF0ZXMgZnJvbSBCREYrdnRkX2FzLT5wYXNpZCB0bw0KPmlv
bW11X3Bhc2lkLg0KPg0KPnRyYW5zbGF0ZSBpcyBzb21laG93IHN0cmFuZ2UuIGNvbnZlcnQgb3Ig
Z2V0IG1pZ2h0IGJlIGJldHRlcj8gU2FtZSB0bw0KPnRoZSB0cmFuc2xhdGUgdGVybXMgaW4gdGhl
IHBhdGNoLg0KDQpPSywgd2lsbCB1c2UgJ2NvbnZlcnQnIHRlcm1pbm9sb2d5Lg0KDQo+DQo+Pg0K
Pj4gU2lnbmVkLW9mZi1ieTogWmhlbnpob25nIER1YW4gPHpoZW56aG9uZy5kdWFuQGludGVsLmNv
bT4NCj4+IFJldmlld2VkLWJ5OiBFcmljIEF1Z2VyIDxlcmljLmF1Z2VyQHJlZGhhdC5jb20+DQo+
PiAtLS0NCj4+ICAgaHcvaTM4Ni9pbnRlbF9pb21tdS5jIHwgNTgNCj4rKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrDQo+PiAgIDEgZmlsZSBjaGFuZ2VkLCA1OCBpbnNl
cnRpb25zKCspDQo+Pg0KPj4gZGlmZiAtLWdpdCBhL2h3L2kzODYvaW50ZWxfaW9tbXUuYyBiL2h3
L2kzODYvaW50ZWxfaW9tbXUuYw0KPj4gaW5kZXggNmVkZDkxZDk0ZS4uMTgwMWYxY2RmNiAxMDA2
NDQNCj4+IC0tLSBhL2h3L2kzODYvaW50ZWxfaW9tbXUuYw0KPj4gKysrIGIvaHcvaTM4Ni9pbnRl
bF9pb21tdS5jDQo+PiBAQCAtMTYwMiw2ICsxNjAyLDY0IEBAIHN0YXRpYyBpbnQNCj52dGRfZGV2
X3RvX2NvbnRleHRfZW50cnkoSW50ZWxJT01NVVN0YXRlICpzLCB1aW50OF90IGJ1c19udW0sDQo+
PiAgICAgICByZXR1cm4gMDsNCj4+ICAgfQ0KPj4NCj4+ICtzdGF0aWMgaW50IHZ0ZF9hc190b19p
b21tdV9wYXNpZF9sb2NrZWQoVlREQWRkcmVzc1NwYWNlICp2dGRfYXMsDQo+PiArICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHVpbnQzMl90ICpwYXNpZCkNCj4+ICt7DQo+
PiArICAgIFZURENvbnRleHRDYWNoZUVudHJ5ICpjY19lbnRyeSA9ICZ2dGRfYXMtPmNvbnRleHRf
Y2FjaGVfZW50cnk7DQo+PiArICAgIEludGVsSU9NTVVTdGF0ZSAqcyA9IHZ0ZF9hcy0+aW9tbXVf
c3RhdGU7DQo+PiArICAgIHVpbnQ4X3QgYnVzX251bSA9IHBjaV9idXNfbnVtKHZ0ZF9hcy0+YnVz
KTsNCj4+ICsgICAgdWludDhfdCBkZXZmbiA9IHZ0ZF9hcy0+ZGV2Zm47DQo+PiArICAgIFZURENv
bnRleHRFbnRyeSBjZTsNCj4+ICsgICAgaW50IHJldDsNCj4+ICsNCj4+ICsgICAgLyogRm9yIFJl
cXVlc3RzLXdpdGgtUEFTSUQsIGl0cyBwYXNpZCB2YWx1ZSBpcyB1c2VkIGJ5IHZJT01NVQ0KPmRp
cmVjdGx5ICovDQo+PiArICAgIGlmICh2dGRfYXMtPnBhc2lkICE9IFBDSV9OT19QQVNJRCkgew0K
Pj4gKyAgICAgICAgKnBhc2lkID0gdnRkX2FzLT5wYXNpZDsNCj4+ICsgICAgICAgIHJldHVybiAw
Ow0KPj4gKyAgICB9DQo+PiArDQo+PiArICAgIGlmIChjY19lbnRyeS0+Y29udGV4dF9jYWNoZV9n
ZW4gPT0gcy0+Y29udGV4dF9jYWNoZV9nZW4pIHsNCj4+ICsgICAgICAgIGNlID0gY2NfZW50cnkt
PmNvbnRleHRfZW50cnk7DQo+PiArICAgIH0gZWxzZSB7DQo+PiArICAgICAgICByZXQgPSB2dGRf
ZGV2X3RvX2NvbnRleHRfZW50cnkocywgYnVzX251bSwgZGV2Zm4sICZjZSk7DQo+PiArICAgICAg
ICBpZiAocmV0KSB7DQo+PiArICAgICAgICAgICAgcmV0dXJuIHJldDsNCj4+ICsgICAgICAgIH0N
Cj4+ICsgICAgfQ0KPj4gKyAgICAqcGFzaWQgPSBWVERfQ0VfR0VUX1JJRDJQQVNJRCgmY2UpOw0K
Pg0KPmxvb2tzIGxpa2Ugd2UgaGF2ZSBxdWl0ZSBhIGZldyBjb2RlIGdldCByaWRfcGFzaWQgZnJv
bSB0aGUgY29udGV4dA0KPmVudHJ5LiBJIHRoaW5rIHdlIG1heSBzaW1wbGlmeSBpdCBieSB1c2lu
ZyBQQVNJRCAjMCBzaW5jZSB2SU9NTVUgZG9lcw0KPm5vdCByZXBvcnQgRUNBUC5SUFMgYml0IGF0
IGFsbC4gSXQgY291bGQgYmUgZG9uZSBhcyBhIHNlcGFyYXRlIGNsZWFudXAuDQoNClllcywgYnV0
IHdlIGFscmVhZHkgaGF2ZSBhbGwgY29kZSBzdXBwb3J0aW5nIFJQUyBjYXBhYmlsaXR5IHRob3Vn
aCBSUFMNCmlzbid0IGVuYWJsZWQgaW4gQ0FQIHJlZ2lzdGVyLiBJbiB0aGVvcnkgd2UgY2FuIGVu
YWJsZSBSUFMgZWFzaWx5IGJ5IHNldHRpbmcNCnRoZSBiaXQgaW4gQ0FQIHJlZ2lzdGVyLiBTbyBJ
IHdvdWxkIGxpa2UgdG8gYmUgY29uc2lzdGVudCB3aXRoIHRoaXMgaW5zdGVhZCBvZg0KZHJvcHBp
bmcgYWxsIHRoZSBleGlzdGluZyBjb2RlIGFib3V0IFJQUyBjYXAuDQoNClRoYW5rcw0KWmhlbnpo
b25nDQoNCj4NCj4+ICsgICAgcmV0dXJuIDA7DQo+PiArfQ0KPj4gKw0KPj4gK3N0YXRpYyBnYm9v
bGVhbiB2dGRfZmluZF9hc19ieV9zaWRfYW5kX2lvbW11X3Bhc2lkKGdwb2ludGVyIGtleSwNCj5n
cG9pbnRlciB2YWx1ZSwNCj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICBncG9pbnRlcg0KPnVzZXJfZGF0YSkNCj4+ICt7DQo+PiArICAgIFZUREFk
ZHJlc3NTcGFjZSAqdnRkX2FzID0gKFZUREFkZHJlc3NTcGFjZSAqKXZhbHVlOw0KPj4gKyAgICBz
dHJ1Y3QgdnRkX2FzX3Jhd19rZXkgKnRhcmdldCA9IChzdHJ1Y3QgdnRkX2FzX3Jhd19rZXkgKil1
c2VyX2RhdGE7DQo+PiArICAgIHVpbnQxNl90IHNpZCA9IFBDSV9CVUlMRF9CREYocGNpX2J1c19u
dW0odnRkX2FzLT5idXMpLA0KPnZ0ZF9hcy0+ZGV2Zm4pOw0KPj4gKyAgICB1aW50MzJfdCBwYXNp
ZDsNCj4+ICsNCj4+ICsgICAgaWYgKHZ0ZF9hc190b19pb21tdV9wYXNpZF9sb2NrZWQodnRkX2Fz
LCAmcGFzaWQpKSB7DQo+PiArICAgICAgICByZXR1cm4gZmFsc2U7DQo+PiArICAgIH0NCj4+ICsN
Cj4+ICsgICAgcmV0dXJuIChwYXNpZCA9PSB0YXJnZXQtPnBhc2lkKSAmJiAoc2lkID09IHRhcmdl
dC0+c2lkKTsNCj4+ICt9DQo+PiArDQo+PiArLyogVHJhbnNsYXRlIGlvbW11IHBhc2lkIHRvIHZ0
ZF9hcyAqLw0KPj4gK3N0YXRpYyBpbmxpbmUNCj4+ICtWVERBZGRyZXNzU3BhY2UgKnZ0ZF9hc19m
cm9tX2lvbW11X3Bhc2lkX2xvY2tlZChJbnRlbElPTU1VU3RhdGUNCj4qcywNCj4+ICsgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB1aW50MTZfdCBzaWQsDQo+
dWludDMyX3QgcGFzaWQpDQo+PiArew0KPj4gKyAgICBzdHJ1Y3QgdnRkX2FzX3Jhd19rZXkga2V5
ID0gew0KPj4gKyAgICAgICAgLnNpZCA9IHNpZCwNCj4+ICsgICAgICAgIC5wYXNpZCA9IHBhc2lk
DQo+PiArICAgIH07DQo+PiArDQo+PiArICAgIHJldHVybiBnX2hhc2hfdGFibGVfZmluZChzLT52
dGRfYWRkcmVzc19zcGFjZXMsDQo+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICB2dGRf
ZmluZF9hc19ieV9zaWRfYW5kX2lvbW11X3Bhc2lkLA0KPiZrZXkpOw0KPj4gK30NCj4+ICsNCj4+
ICAgc3RhdGljIGludCB2dGRfc3luY19zaGFkb3dfcGFnZV9ob29rKGNvbnN0IElPTU1VVExCRXZl
bnQgKmV2ZW50LA0KPj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdm9p
ZCAqcHJpdmF0ZSkNCj4+ICAgew0KPg0KPnRoZSBjb2RlIGxvb2tzIGdvb2QgdG8gbWUuDQo+DQo+
UmV2aWV3ZWQtYnk6IFlpIExpdSA8eWkubC5saXVAaW50ZWwuY29tPg0K

