Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38E78CCF9EC
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 09:44:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDgEh-0003OE-O1; Tue, 28 Oct 2025 05:43:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1vDgEW-0003IB-Hf
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 05:43:17 -0400
Received: from mgamail.intel.com ([198.175.65.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1vDgEP-00052f-VS
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 05:43:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1761644590; x=1793180590;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=3sgJWuFicOREeNOifxibDtVY/drV/xCtJ3kSCUuYsqo=;
 b=DzSw45a06UuQTnUGdpvgykPVhWKJ97Cr6ysHtxNC9iMTkZpydMRRBUnM
 WraGC0vHQMr0YEtP0v3lDsj4IQejnhnJ8br3JEmMegy/rgqpivUHyeqTa
 4EAKfodKdP9FTirbCrU55BpbHKmebdPnEP3/dCLa4RKjmtAmL7ZRAQ4WE
 bkuyEbzfznO4i+09G5z38YrhWTBbK90S3yLrQfkbMxLoG8V6cxp+2GzuZ
 ENqQhkfkaEVziA3Ww9tE0LW0Au8abI68Hx3ypIwp4AMGxW0WpKU/PZHK0
 zbxoG+yqECo6xaWNjox7oF2opQulNcqZaEgPH4Wb/5Gf8akUlVCU8hGYb Q==;
X-CSE-ConnectionGUID: d+UBqQxvTUSKkF3+/jegcQ==
X-CSE-MsgGUID: PTpKVXAhT0ex296SX64ZHA==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="74026253"
X-IronPort-AV: E=Sophos;i="6.19,261,1754982000"; d="scan'208";a="74026253"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Oct 2025 02:43:04 -0700
X-CSE-ConnectionGUID: SEvYjyPuRnGb1JvFABkLUQ==
X-CSE-MsgGUID: rTmcLPpyQsyNmGeM/XQ+0w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,261,1754982000"; d="scan'208";a="185387674"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Oct 2025 02:43:04 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 28 Oct 2025 02:43:03 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Tue, 28 Oct 2025 02:43:03 -0700
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.47) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 28 Oct 2025 02:43:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j+W7bSjrgqO69wAAGNt06k3/BGTf+UNChDFItgDNikq7C/BcYfCPZXvcMSv5LEMVxAYKmjeP70PY/p4qZlDY2fbG0j7oq5ThgnaYOewSWPnVmFtoIbVHi2yFDmd825JntLb/+2Nr59Mc4quRaw4JNNhcav+rUkTXXJQ8W1iRjXRo4aTEHyXDenV1x8kdq3GlAyLQ1Z8FpxjkNc6gYIAjZSvAbGseTjfQkU6p4k3Ui5qNHuqFPkGy/J8sRRk1ikz5l1ISz/ch+nSmWHjyGPJlwG70GMMXyDrcTvo/HxbYGgCQe/QHljae637prSmqHYeen8GYitiai62M7sdAEBYPOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3sgJWuFicOREeNOifxibDtVY/drV/xCtJ3kSCUuYsqo=;
 b=luK6ZkX919cL9mjGMwGXh12lvtwApVhArq/350BXQY6Oh+LC4jP/eOeQww58wKlbQ82CoT6Esp2aiZ0HnW8viTzMv8IOJeqjOQIJGEFBqDilXMPoYO2t/83EVBdGUdM3egtJHMrKJx3R8fkcdlQdyW0nBQ98KU5gm4Uab04kH2J2bencKcNnXbd26UhReD3dDqjTVtDTbNTDR6RUFs4TapnMp4R3LpqFLfMwOzxZKJ2PvOgR69fJO+DpWoVP5p3jx1F3ReljRuqLbN11Z2xXTJzoBsGV8gT+9ZGGlAWAOg3fgWfh5JMyoLfZ+dehW5vUgPxDdlCEu9vigWoNcsSzmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12)
 by IA1PR11MB8197.namprd11.prod.outlook.com (2603:10b6:208:446::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.12; Tue, 28 Oct
 2025 09:43:01 +0000
Received: from IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13]) by IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13%7]) with mapi id 15.20.9253.017; Tue, 28 Oct 2025
 09:43:01 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "mst@redhat.com"
 <mst@redhat.com>, "jasowang@redhat.com" <jasowang@redhat.com>,
 "peterx@redhat.com" <peterx@redhat.com>, "ddutile@redhat.com"
 <ddutile@redhat.com>, "jgg@nvidia.com" <jgg@nvidia.com>,
 "nicolinc@nvidia.com" <nicolinc@nvidia.com>, "skolothumtho@nvidia.com"
 <skolothumtho@nvidia.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "clement.mathieu--drif@eviden.com"
 <clement.mathieu--drif@eviden.com>, "Tian, Kevin" <kevin.tian@intel.com>,
 "Liu, Yi L" <yi.l.liu@intel.com>, "Peng, Chao P" <chao.p.peng@intel.com>
Subject: RE: [PATCH v7 17/23] iommufd: Introduce a helper function to extract
 vendor capabilities
Thread-Topic: [PATCH v7 17/23] iommufd: Introduce a helper function to extract
 vendor capabilities
Thread-Index: AQHcRMKaUSVhoEqzPU6ka5EncKvfDLTRgWMAgAXTd0A=
Date: Tue, 28 Oct 2025 09:43:01 +0000
Message-ID: <IA3PR11MB9136414F72F6CE4AD6448FF892FDA@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <20251024084349.102322-1-zhenzhong.duan@intel.com>
 <20251024084349.102322-18-zhenzhong.duan@intel.com>
 <647cfdb2-6dee-4831-920e-a6440829c201@redhat.com>
In-Reply-To: <647cfdb2-6dee-4831-920e-a6440829c201@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9136:EE_|IA1PR11MB8197:EE_
x-ms-office365-filtering-correlation-id: e633440b-636d-47a4-3f75-08de1606627e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|376014|366016|1800799024|38070700021; 
x-microsoft-antispam-message-info: =?utf-8?B?eDlsM2hBaWhSVEZHUjFGaXlVTU0reURzTHFhVm1wZlFpc3JUMmZ0akV1d0J4?=
 =?utf-8?B?U21Ud3dNU2x5OTN4ajh6MjF3VVNoZzI1Y1loVFhoWGN2UTM5Mmg2cEFzZDZD?=
 =?utf-8?B?N29JVjg1N0lQSTlSY2dvUGVZcXhSMWgvY0s5V0daVGpwVG9lQngvWTNlSnIx?=
 =?utf-8?B?YXdjV0J0VGZzZEdzVXdzUUxPaTlyaFpUd3pYTm1IMGhVZWZyN3hiaFVTbDFl?=
 =?utf-8?B?Ylp0R3g0ei9Ed05vSXJuaHRrdzVONTZLRlh1VkRQaUdQMjh2NHZvUHdOakRD?=
 =?utf-8?B?ZHM0TmNOYnpxNWhqSFB0NW9XbFlSRlBFcnpFWHhKVnNDQjdtMHNyeFFneVYw?=
 =?utf-8?B?NXBJMU83MVdVYXBkcy9ETkNQUmlhT003a2FjSVJNbG9rT3lLYWtsRkgrVUlr?=
 =?utf-8?B?d2ZNaWtUWE1DVUZmRTFPRGZsUk5HZ0xlaVMzc05veHhFVkdET2VPdUFzb1N2?=
 =?utf-8?B?MjU4V1hsZ0hsRDB4OEp0OGdBZ0lQbEZxRi9OdjlzWmVkaEZCWmpXSjFnaEF6?=
 =?utf-8?B?ZkNxNUFZWFZqV1h0cWx2bnlpYitmWDVLS3Q3SDdUQXJtemFlSWVTMmtOZTRV?=
 =?utf-8?B?R1NGNVJINHprOHg1V1RHUWNYNDFYaDEvTTgrNVB5YkcwWnlER3QwVWNXQzZP?=
 =?utf-8?B?eWpRWUFsaWcvbnI4ZXVWVXpEU1dhMHZNeGtiem1Ya1NhNkxCUlNWWjNkWnMy?=
 =?utf-8?B?MHFrSkViNlU2cERSU09leVk4SXlEUE9YWUNmVmwxK0g5WGRIdEZGS0lDYyto?=
 =?utf-8?B?QzhkbDdNbkVzSEtIeE1SUHN5OUp0ZWgzdUtkcktQdlZ2S1FRRUVMSm5BNkNO?=
 =?utf-8?B?dVNzd0F5eTlvL0k3Tm5LVks5SVVrSmR4TWNCUlpXTTQ1S05HaVRtZXFldjFm?=
 =?utf-8?B?WGJnb3NnSUt4bUVYZDluQnlhejRmMzEramFBTVM2Q1RYSGJrcVRSMG8xWS8v?=
 =?utf-8?B?SjJlR2UwQ2tyMUtuOXJpVWRPMXBRMDYvT0M2M05hbzAvblV0d0JvWTd6cnpi?=
 =?utf-8?B?VDRuK1duWXNuZVA2SWRsZ09WOXlXQXRYSjBiaVFtWE53emxDY1I2MS9tN1dN?=
 =?utf-8?B?bTFIV3F3QzM5NFVEU0JsMnlwQ3ZmVGlkSzJYWVhMNDFGWjhsVXV4MUkxdlho?=
 =?utf-8?B?dVhpd3g4NldPekZZUXBudmZ6UjhQZlB1RitwdFUrdDgxT1RkR2xqT01iUyt6?=
 =?utf-8?B?bVh4MkdSSGFiV1RJL0tTQXk5YXRmRFArbkllblArR0ZXSFJqWFkyVGRVaFA5?=
 =?utf-8?B?RXJzNkdzMWp5NWVhTExpZkdzWjcrdFBqS0Vtdk41d1owRGkyK0J1VDlaSUVx?=
 =?utf-8?B?VWppbm5RRG4wVU1TU2dtRkY4VW5yYytwTTBXT0xObG9DcTFtNkxZMEVmd1dG?=
 =?utf-8?B?dkc1NUZsTUNnNW0zU1pCeGpGSnF4Mit6N2hSL21iS01oRGpOM1Ayc2p3RnZG?=
 =?utf-8?B?d3VWL041NmIxZ0tmbkt4YXhBTmFoZDk3KzhxS0V4YlU0cUV3NFVmQk9Gbjl2?=
 =?utf-8?B?QUsySU5UNUE0L0RvdnVjVEZPRG5BdzdBQlNpT1lUb01RdWlVSWpoZmdxLzVm?=
 =?utf-8?B?eGVhZlg4OHhZYkpRZzNEb0xTRVhsVFpJbjBiT0Nuc0d3MU53aVN6eDQwZXpB?=
 =?utf-8?B?NWc1Z1ExNnlEbExTVTRKd0tHVDNQT0VXbmNqWWpaT21UUElJdlBLZGJsVElH?=
 =?utf-8?B?Zkl6bWhCYXNEVmxLWVFLY1p6MGc3SXVPN3JWZDVuLzd1MTBHeittdlhkc2Vo?=
 =?utf-8?B?Ujl0YllPNS9jajdjSE9La3NTeU9JdnFTMEMyenBvR2RHMDNaYk14eVZacFpt?=
 =?utf-8?B?cW5TKzNrRElzTmhKdTJXNWdqMmw0Y0pRTTVETUprTDhCSWVCT2ZLejBESkRz?=
 =?utf-8?B?eTg3MTMyV3dyenlNUm1oNnpENXJmZkxoQ2E4ejlXcElqNzlWc1laSUpQSjlz?=
 =?utf-8?B?TzJnVHJkUlllNnBIM1hvbXBZa0pUYklyQUNDZ1dMUThhNkxKdEtqTk5vYkhL?=
 =?utf-8?B?bWVKQ004a1BaQmtPUExiOEcrYVpTWStOc1gzNFllUkRGazUzRFZkc3gwcHpn?=
 =?utf-8?Q?EHKbY5?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9136.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(1800799024)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eDZ4Y3BkeGdhOWlldWxzbi9yUTgyR2RLRTdWd1FnQU1od29BdUIzQXVaMTNu?=
 =?utf-8?B?R3hxTk5yaVNrWDRWK2kxOTN2Q0VERjFSNjBTM2lMRzdOM292eTZ1ZjRoVGZ2?=
 =?utf-8?B?UGF0SmtGeWFNY09wcEpLTWw3c2pKb0xUbVJwWDNKSGd0L3RwemZxQnVVdk5P?=
 =?utf-8?B?MUdtSG5PSEZ4MjM5bGJoenBXTWNXRnlYOE1tcVZPbU1SOUtzMmJKQjdRaXJu?=
 =?utf-8?B?SzZQNW1YY2Y1NUZzdlBQNitzbG1qV2toTVY5R0xKNUt5SlcxQmtOVnUyNVRx?=
 =?utf-8?B?eWMwN3VJU2NYOTlrN3JMLytBVkJ2azhnTTA3aEc2dVBoMGR0Z0pDVzFxUnFL?=
 =?utf-8?B?bGpkTVQ1dWJUSGd4VzQvYUQ5SENSZGFzc0ErZTJubnU0dFRMb2ZieUdzSDcx?=
 =?utf-8?B?NC96L2cvWTBTWldEVWhGditwckFpRitKUDRZSlhqU1QxRGQ5RVkxOEl1RVdQ?=
 =?utf-8?B?MWpKdU8rdDFRN1AxRmNKaGsvQVlYeGpoVThUd3dkSkluOHVXbThpZHFiRkFO?=
 =?utf-8?B?amNPeW9wTnBBU0pqZkdxRDJXUVgvK3Y0dlQ0VEdGYjBKMHJ5cHB2K2ZCOVRl?=
 =?utf-8?B?UXNEd29yOEF6akRJYlpXbzZyVGZySXNPdmExYmNWMmFMMmZodXRuYkRmbkRE?=
 =?utf-8?B?VXZtc2Z0cksvV1JWUDVvLytBU20yUDhVYm1jWG5BaUMzbmZIczNRNXNHSnZW?=
 =?utf-8?B?b0VOMmRGK041WWYwWUZjUEdVWTV1L200eFdTL3F1REo5Q0N5Y3daUUt6R3hi?=
 =?utf-8?B?ZEE1OElZM05GelhwL1F3RkZSeXI3TUxpNzN4ZmloRThIaklvc1Z4REhzeFEr?=
 =?utf-8?B?NHQrV05Nam1MQUw3ZWMvdUZtNE12bUFkYlN6ZGZWbEJacmdHZ01NZHRxNkZw?=
 =?utf-8?B?Vzd4cVZxNjRhR1V0aTRhT2JrdVhpWlhDZnFEUXRPYUdNR05tdTRwZnM4Q1Zq?=
 =?utf-8?B?bW5XMlVUZG1qRlZxeXRVWXJqR25tTkoyWnZ4Nis5R2haaitoNUhFWms0MUM2?=
 =?utf-8?B?angyWUxLQmRLb2N4RVB2QkJzdHpNWjlEM01OemFJUGFGQVVtdTVmTitjWHgz?=
 =?utf-8?B?eUx1T3JMSUsyQk1aYWhqQjBUSlg2aUNXTmthZWNoOW1rekVlaWluNndsUXdL?=
 =?utf-8?B?VlpSWHJlbUZKMk9DcXNmb2JpN3RQRWorbUNKMFdidFUwUW0wbC9IZUVYcWRU?=
 =?utf-8?B?MHZZZGJDaXltOWlQWG9OL0VyOTRkNzZPSnp0bHcyZnF2WnJxenhVZDkxV1du?=
 =?utf-8?B?L2xYQ1NZSnc2cXpyRXBZWTREWHkzL3FjanVIbTNGaDU1ZEg1M1NPY0gvc3B0?=
 =?utf-8?B?TSt3SEhpdkI2bHFNV0sxdGhNTDEzTEVaWkZhWFBYODZnSGV1cGpGZTdJSHJT?=
 =?utf-8?B?eTMyYTZEL0dOZjk4TFNCZFczSC9DeW0wazh5YUNsbzZrbGRCV2sxSXFiUVhj?=
 =?utf-8?B?YlVYM3FFV2tHa3RsekVGZ3ErM25uaFNOMHR2T2pwV1ZCaHpQSDhRKzM3YjdT?=
 =?utf-8?B?R1YrRktqOHJNT2dRR1hSdm15Z2s2cFJJRVpQNFhSRFdyK3h0V09FZk15K3BP?=
 =?utf-8?B?dzdnN0E1TkxLdytCSVZudStON1VIK21PVmNYWnFDNFJKWkZqcEc4L2hNd0V0?=
 =?utf-8?B?Zml1NlJDaUFyT2F6OFVFUFlZWjJGM2cxcEYxMlZzei9hQjNsekRLeElHWngv?=
 =?utf-8?B?M2I4dkZkZ3ZqejJNa2h4U3RUVHFHanIzK0tJVGdycTE4WXllLzdOWlloOVdP?=
 =?utf-8?B?MGwwWWlISTRrVDRuR29ZWXE5WFJ1WS9Xd2RvSHk1OFVlTE02UWxMYmFVaGxo?=
 =?utf-8?B?Wmg5OUY3YzFHUENGeFdDR0VBTytVT3QyRlVjREdxQ0V1bnAvK1g3T0NmVi9C?=
 =?utf-8?B?VUdPNmY2MklWMDIvaElEQUFVcVZUTFVma0FEYWs0MzNLTjY1OGdlSVJiODZG?=
 =?utf-8?B?YkF4aXBCZFRzdzBQTm1zUlFScHV4ZDZvOXIrcGRXU0JwMUVOMjZtRGRyNW1x?=
 =?utf-8?B?T3dtZ1RmL1FtT2VpRVZLanNYK0tiMGVPNHdiay9oRUx0cXF1SzNxZU1veEZU?=
 =?utf-8?B?aHIxY1NEZnhmQUNpTFVBeW54TUpTNkt0Y2E5UDhXVlMzUHRwQksxSGZnaEwr?=
 =?utf-8?Q?GoA/Fm7AjqjcieV9PbRILCkzM?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9136.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e633440b-636d-47a4-3f75-08de1606627e
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2025 09:43:01.0699 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9SZVGRkgQ32mB4KymWVPqDcjuwu834zalX59atS8tjGmz7UesmaLIzYttSb76GQ/CHE9ZFkAD1/pJ3xlUQa4pHWx1I5OOyFz466UBEooEj8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB8197
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.11;
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IEPDqWRyaWMgTGUgR29hdGVy
IDxjbGdAcmVkaGF0LmNvbT4NCj5TdWJqZWN0OiBSZTogW1BBVENIIHY3IDE3LzIzXSBpb21tdWZk
OiBJbnRyb2R1Y2UgYSBoZWxwZXIgZnVuY3Rpb24gdG8NCj5leHRyYWN0IHZlbmRvciBjYXBhYmls
aXRpZXMNCj4NCj5PbiAxMC8yNC8yNSAxMDo0MywgWmhlbnpob25nIER1YW4gd3JvdGU6DQo+PiBJ
biBWRklPIGNvcmUsIHdlIGNhbGwgaW9tbXVmZF9iYWNrZW5kX2dldF9kZXZpY2VfaW5mbygpIHRv
IHJldHVybiB2ZW5kb3INCj4+IHNwZWNpZmljIGhhcmR3YXJlIGluZm9ybWF0aW9uIGRhdGEsIGJ1
dCBpdCdzIG5vdCBnb29kIHRvIGV4dHJhY3QgdGhpcyByYXcNCj4+IGRhdGEgaW4gVkZJTyBjb3Jl
Lg0KPj4NCj4+IEludHJvZHVjZSBob3N0X2lvbW11X2V4dHJhY3RfcXVpcmtzKCkgdG8gaGVscCBl
eHRyYWN0aW5nIHRoZSByYXcgZGF0YSBhbmQNCj4+IHJldHVybiBhIGJpdG1hcCBpbiBpb21tdWZk
LmMgYmVjYXVzZSBpdCdzIHRoZSBwbGFjZSBkZWZpbmluZw0KPj4gaW9tbXVmZF9iYWNrZW5kX2dl
dF9kZXZpY2VfaW5mbygpLg0KPj4NCj4+IFRoZSBvdGhlciBjaG9pY2UgaXMgdG8gcHV0IHZlbmRv
ciBkYXRhIGV4dHJhY3RpbmcgY29kZSBpbiB2ZW5kb3IgdklPTU1VDQo+PiBlbXVsYXRpb24gZmls
ZSwgYnV0IHRoYXQgd2lsbCBtYWtlIHRob3NlIGZpbGVzIG1peGVkIHdpdGggdklPTU1VDQo+PiBl
bXVsYXRpb24gYW5kIGhvc3QgSU9NTVUgZXh0cmFjdGluZyBjb2RlLCBhbHNvIG5lZWQgYSBuZXcg
Y2FsbGJhY2sgaW4NCj4+IFBDSUlPTU1VT3BzLiBTbyB3ZSBjaG9vc2UgYSBzaW1wbGVyIHdheSBh
cyBhYm92ZS4NCj4+DQo+PiBTdWdnZXN0ZWQtYnk6IE5pY29saW4gQ2hlbiA8bmljb2xpbmNAbnZp
ZGlhLmNvbT4NCj4+IFNpZ25lZC1vZmYtYnk6IFpoZW56aG9uZyBEdWFuIDx6aGVuemhvbmcuZHVh
bkBpbnRlbC5jb20+DQo+PiBSZXZpZXdlZC1ieTogTmljb2xpbiBDaGVuIDxuaWNvbGluY0Budmlk
aWEuY29tPg0KPj4gLS0tDQo+PiAgIGluY2x1ZGUvaHcvaW9tbXUuaCAgICAgICAgICAgICAgICAg
fCAgNSArKysrKw0KPj4gICBpbmNsdWRlL3N5c3RlbS9ob3N0X2lvbW11X2RldmljZS5oIHwgMTUg
KysrKysrKysrKysrKysrDQo+PiAgIGJhY2tlbmRzL2lvbW11ZmQuYyAgICAgICAgICAgICAgICAg
fCAxMyArKysrKysrKysrKysrDQo+PiAgIDMgZmlsZXMgY2hhbmdlZCwgMzMgaW5zZXJ0aW9ucygr
KQ0KPj4NCj4+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2h3L2lvbW11LmggYi9pbmNsdWRlL2h3L2lv
bW11LmgNCj4+IGluZGV4IDliOGJiOTRmYzIuLjZkNjE0MTA3MDMgMTAwNjQ0DQo+PiAtLS0gYS9p
bmNsdWRlL2h3L2lvbW11LmgNCj4+ICsrKyBiL2luY2x1ZGUvaHcvaW9tbXUuaA0KPj4gQEAgLTIy
LDQgKzIyLDkgQEAgZW51bSB2aW9tbXVfZmxhZ3Mgew0KPj4gICAgICAgVklPTU1VX0ZMQUdfV0FO
VF9ORVNUSU5HX1BBUkVOVCA9IEJJVF9VTEwoMCksDQo+PiAgIH07DQo+Pg0KPj4gKy8qIEhvc3Qg
SU9NTVUgcXVpcmtzLiBFeHRyYWN0ZWQgZnJvbSBob3N0IElPTU1VIGNhcGFiaWxpdGllcyAqLw0K
Pj4gK2VudW0gaG9zdF9pb21tdV9xdWlya3Mgew0KPj4gKyAgICBIT1NUX0lPTU1VX1FVSVJLX05F
U1RJTkdfUEFSRU5UX0JZUEFTU19STyA9IEJJVF9VTEwoMCksDQo+PiArfTsNCj4+ICsNCj4+ICAg
I2VuZGlmIC8qIEhXX0lPTU1VX0ggKi8NCj4+IGRpZmYgLS1naXQgYS9pbmNsdWRlL3N5c3RlbS9o
b3N0X2lvbW11X2RldmljZS5oDQo+Yi9pbmNsdWRlL3N5c3RlbS9ob3N0X2lvbW11X2RldmljZS5o
DQo+PiBpbmRleCBhYjg0OWE0YTgyLi45YWU3ZjRjYzZkIDEwMDY0NA0KPj4gLS0tIGEvaW5jbHVk
ZS9zeXN0ZW0vaG9zdF9pb21tdV9kZXZpY2UuaA0KPj4gKysrIGIvaW5jbHVkZS9zeXN0ZW0vaG9z
dF9pb21tdV9kZXZpY2UuaA0KPj4gQEAgLTM5LDYgKzM5LDIxIEBAIHR5cGVkZWYgc3RydWN0IEhv
c3RJT01NVURldmljZUNhcHMgew0KPj4gICAgICAgdWludDY0X3QgaHdfY2FwczsNCj4+ICAgICAg
IFZlbmRvckNhcHMgdmVuZG9yX2NhcHM7DQo+PiAgIH0gSG9zdElPTU1VRGV2aWNlQ2FwczsNCj4+
ICsNCj4+ICsvKioNCj4+ICsgKiBob3N0X2lvbW11X2V4dHJhY3RfcXVpcms6IEV4dHJhY3QgaG9z
dCBJT01NVSBxdWlya3MNCj4+ICsgKg0KPj4gKyAqIFRoaXMgZnVuY3Rpb24gY29udmVydHMgQHR5
cGUgc3BlY2lmaWMgaGFyZHdhcmUgaW5mb3JtYXRpb24gZGF0YQ0KPj4gKyAqIGludG8gYSBzdGFu
ZGFyZCBiaXRtYXAgZm9ybWF0Lg0KPj4gKyAqDQo+PiArICogQHR5cGU6IElPTU1VIEhhcmR3YXJl
IEluZm8gVHlwZXMNCj4+ICsgKg0KPj4gKyAqIEBWZW5kb3JDYXBzOiBJT01NVSBAdHlwZSBzcGVj
aWZpYyBoYXJkd2FyZSBpbmZvcm1hdGlvbiBkYXRhDQo+PiArICoNCj4+ICsgKiBSZXR1cm5zOiBi
aXRtYXAgd2l0aCBlYWNoIHJlcHJlc2VudGluZyBhIGhvc3QgSU9NTVUgcXVpcmsgZGVmaW5lZCBp
bg0KPj4gKyAqIGVudW0gaG9zdF9pb21tdV9xdWlya3MNCj4+ICsgKi8NCj4+ICt1aW50NjRfdCBo
b3N0X2lvbW11X2V4dHJhY3RfcXVpcmtzKHVpbnQzMl90IHR5cGUsIFZlbmRvckNhcHMgKmNhcHMp
Ow0KPg0KPi4uLl9nZXRfcXVpcmtzKCkgc291bmRzIG5pY2VyLiBUaGlzIGlzIG1pbm9yLg0KDQpP
Sywgd2lsbCBkby4NCg0KVGhhbmtzDQpaaGVuemhvbmcNCg==

