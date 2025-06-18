Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12316C71157
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Jun 2025 02:11:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uRiG5-0002uE-04; Tue, 17 Jun 2025 22:10:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uRiG0-0002tY-FX
 for qemu-devel@nongnu.org; Tue, 17 Jun 2025 22:10:32 -0400
Received: from mgamail.intel.com ([198.175.65.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uRiFx-00011k-Sc
 for qemu-devel@nongnu.org; Tue, 17 Jun 2025 22:10:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1750212630; x=1781748630;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=Pw/R2sT1yZK1SXv21diwMkebceZ1iND9texVwjRUf0U=;
 b=GZ9wwnctDhAjShRXKqRbJrnpT+ln7DOGmhOc3OsiyJBnjtlQPRkx2DA8
 2/mdAsc+0aNgLyP85q0Ues1W5AWNaF0QgtT0f4KBw4qe18U7CT/Saj9QU
 e07+uzS8/MpegM/YBAjfLDwXqS+dtJS1DVLtxlJD/OGFCkUAkE0wesfla
 99IV1qdzAfa4jDCOLXoou1azqgzHuHElaRvpJjBvzOyI29FweCxp2hZV0
 THT0e9iU0Bm8d3Ste9u8XshydkQBaRFSCg78B4Ia3D8KGa0YATDxuk6du
 WS3Pstph4X6Vl+Aaj0f/oea6jYPjbQV1Qb5Tj6Ntmpeb3KPamC+LuaVh5 Q==;
X-CSE-ConnectionGUID: dW7okUT6TMCo0KmwEt2+4g==
X-CSE-MsgGUID: OHpwpPfTRFSjx3cFlLJveg==
X-IronPort-AV: E=McAfee;i="6800,10657,11467"; a="52116715"
X-IronPort-AV: E=Sophos;i="6.16,245,1744095600"; d="scan'208";a="52116715"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Jun 2025 19:10:25 -0700
X-CSE-ConnectionGUID: w56C9HzFSlmtfOMId+745Q==
X-CSE-MsgGUID: PsejSgbRToWDvWiZfitQiw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,245,1744095600"; d="scan'208";a="148944162"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Jun 2025 19:10:25 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 17 Jun 2025 19:10:24 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Tue, 17 Jun 2025 19:10:24 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (40.107.92.71) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 17 Jun 2025 19:10:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RIgOGY+kVTuantFIDD4mRWPW2cFKsjHp5bvCzqLHJQJUMeieWAP2sD8uQfdXH7UBftMIcCQKv/RbMDwEt6KsUDJ70sBAYbhrJyRMTFMet+rECwT83E54nF6NdMiGITHPDqSWHt1HjWN0s/QwR6MEMyJZIsSR8lv9bqzEQXiUB7O+NpxZzFAMqaC8SzHkSjlCw256sfXp9RfGEYceh/egb/Hy/mWjqBdUUuMEstc90zB0O/qGfquiRkp2tPscirjFwWPRSMYoexDIDsg/9fR2HSEdMQnGlZ17cBrHMm08AjajChzP5VFgndCbLntznxRH4X7o1WtiUQNx/pA6YzTZcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pw/R2sT1yZK1SXv21diwMkebceZ1iND9texVwjRUf0U=;
 b=UGB8fqGG9ncgiqLU/9OWY/vWa5W/d75TnipC90yTzKPKHPC3ItnCA6IuMiZZ4pRydgGYy2B0OHiGUT6KsyP5vN4KU0EIZCrWovwDhOj46PDYAt7TF8Q+e2QRRNrYTzBoNQZKHMWm23m8ZihzOs/h9JTQaZXWMf0mID+C/OlgRDNAWcKgBsGrErQ1Lc9ZdmCG3zf3Z+/xQiC+a8+FlelCaRQXgQukBgZxOI4+3lrQskqxW67CnQM3DH+J7r2ig+hEnVBTnUMVbJY3XTW8LWCAti76OCraIo+x3RlDvV59MRpEiMlT5p46jgGE9TrBLorgJtY3ByRC2cqodjH6GI8dBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12)
 by IA3PR11MB9448.namprd11.prod.outlook.com (2603:10b6:208:572::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.30; Wed, 18 Jun
 2025 02:10:22 +0000
Received: from IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13]) by IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13%4]) with mapi id 15.20.8835.023; Wed, 18 Jun 2025
 02:10:22 +0000
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
 "Liu, Yi L" <yi.l.liu@intel.com>, "Peng, Chao P" <chao.p.peng@intel.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: RE: [PATCH v1 02/15] intel_iommu: Optimize context entry cache
 utilization
Thread-Topic: [PATCH v1 02/15] intel_iommu: Optimize context entry cache
 utilization
Thread-Index: AQHb1srx8KBRZWY3jE+gRF83S3+bB7QHq66AgACRxOA=
Date: Wed, 18 Jun 2025 02:10:21 +0000
Message-ID: <IA3PR11MB91363AC7DBFB6988CA1FAD229272A@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <20250606100416.346132-1-zhenzhong.duan@intel.com>
 <20250606100416.346132-3-zhenzhong.duan@intel.com>
 <e75d6344-9858-400a-9c73-1359789e15a9@redhat.com>
In-Reply-To: <e75d6344-9858-400a-9c73-1359789e15a9@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9136:EE_|IA3PR11MB9448:EE_
x-ms-office365-filtering-correlation-id: d1d8914d-4f4c-4f81-286b-08ddae0d47e7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|7416014|1800799024|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?bGJpazhWbkxtMUNRY2VqVi8xckcwVm5wTU0zNVJWTFVpMXBLakRXVDRzRVZJ?=
 =?utf-8?B?ZHpIZXFGZ052Z2xJTmdTREhoR0t0dkxwS3dQeTFTK1cvbTIwY0l3YklVc0Ji?=
 =?utf-8?B?UXkva2hySnlIUHZzVXk0cjBzVWg2UkxRYXh1MzV6dDhSaEVjM2c0QnZiODcy?=
 =?utf-8?B?L0NmMHVNSDBUTHZoQk1TMkpQamMrZjBrTnp1NEtWRjMrYXBKNm5kTTdUdytr?=
 =?utf-8?B?QmF2Zjd4RVpacTAzWE5aOEhYSnA1ekVuTTNWUzFRZjVWQzdIQmxQcFlwTTdH?=
 =?utf-8?B?WmVwbG10Q2prSWNqdmxaSVJkSkU4QitRanY3Z0pzWThadlNsRFdTektKOGhj?=
 =?utf-8?B?ajhhQ3NpSlQrcm5lWE5JRnphMndrZGNzZ3hsSXU5NXUvbXlWZTZQOHFWcEcx?=
 =?utf-8?B?YXhJOE96QWpPbUhqMUY0UEd3UzlFaEZ0SHNOK3Rkc0p5VU1EUEtIQ3lKSFht?=
 =?utf-8?B?K2ppRFdoaE1nOWZDcXBVZ29uNHUzNVYvR05aZ3RwZjllYk5leXZDNFgvM3Jz?=
 =?utf-8?B?a2F4TDRkbFpxOTlVeGpCcVFsVURyVmxoTWhoK3FIRzc3WjdsRG41NkxWWWVX?=
 =?utf-8?B?ajBVNWY0Tzc1QkVNbTBlY2M5UFNZcXpVSjNkazNoaXY2TUtEd0ZtRjc4aUZj?=
 =?utf-8?B?b2lqM3dmTWJqOGIyRmpiUy9qZUZINndmeWVSMktXaFFJcGd2QmNDdG5xYUN4?=
 =?utf-8?B?YnM3WWd6SHh4TXBUSzlKdGoxbjJlYTRFSDRxTjQwM0xRbEVQVWFDN2lyUEhR?=
 =?utf-8?B?d2djbE9pY0Z3ejZvS3RQOUprQUVzdEhMMjFzdjVCVnZaWVltQmhyUVdPdkhq?=
 =?utf-8?B?OWwwOEE4TXZkekJlVEhJQ0NlQ1ptWmJqVXRnTjZxWUNzajZRRU4wMWdtV2FF?=
 =?utf-8?B?V3B5bzlEYXlRQ2RUb0FNdHc4ZE9FQTZKTiszZWxleFo3dUFIYUVKVDNSdG9u?=
 =?utf-8?B?NDlDQktteGlLN1VUbnRTRDY5aTJrWk93L1Z0S1dGUWk0V25QV0tXV2JrOTBo?=
 =?utf-8?B?REE5WE5yemRMQUZPOEp6NjRSYWR3ZzFtTTk4VEEwZmcrenBHcmdWdlJKR09z?=
 =?utf-8?B?QWYrVlVaSGc0KytVejRYUWhNWXN0dGtaMUlYbmF3WlJDQjlUenZrYlZMcHc2?=
 =?utf-8?B?S04vNUg1eTdXUXlUNlJXeFJnSmYzZStDVjhJeEZwQ3g4TXAyZ2x0RGs5OVpV?=
 =?utf-8?B?YVZteUVIcFpTdlpaR2QzbExQeVVyRFVqRVVqNEhtT2tpbUFBdmlUY2greU81?=
 =?utf-8?B?V1YySkhkajBVTm9ScFdWdmRmeFB0QUU3eWFscnZYN3B2TG1nYStKSk1xMDkz?=
 =?utf-8?B?VGtoK2dXbFVFYnRXWTBEK0IrQ1FNbk5vSjRmc3dNRWt1YWtjTGQ0R0VKOVNZ?=
 =?utf-8?B?TUNTQUQ2cERRN3BtSEt1Ymo4cHlYTFM3Y0xYenRyVTB5blQrVlFONkIzRnJC?=
 =?utf-8?B?ajZRRFFNczRuZnU3a3NObEh5ek9GU0tsRm9LZ0VETjh6NmZvQTVReTVacXJH?=
 =?utf-8?B?OGZLUXM4Zy8zbTdURjZ2UDV2UnoyV09Td3JsTjgydG55Y1RWNlBhN1B3aUJI?=
 =?utf-8?B?ZmZhVjlYN1MxN3hEa1FvL2crcDkxWW03akY4Z2xBcHdUalJKeVBBWVpZcTBl?=
 =?utf-8?B?RDVLS1RmVEswN1F4NzdENG1WVTFTOFkyQXh2SW1jQm9nRkFUSms5Mjk0ak9L?=
 =?utf-8?B?aHp3bmNxc25wVzdwdGQ0NVR3QnFFTURWanlqbmoxUWR0Z2sxYXlrZjdBRTJU?=
 =?utf-8?B?RHBNNDRMd2dqcVYzM3RMUXYwOXl4VXpWK3N2WXU0bVFzTG82cDBVSkRTUnZD?=
 =?utf-8?B?MXhlY1VrWGRqZGE1U2ZIWDRETkN3bGg2QkJ2QVBGQ25hZzcyY0puOE9iVFpw?=
 =?utf-8?B?azFveDc5UzVKcTJiVnFZc29QeHBvZTBzWmRGcFJqb1JlQmpzblhReUdIWjNT?=
 =?utf-8?B?RXhPR290TFN3dlZ6Q1JwdEVTMnIwcXpLenNlREprMG9IZG9QdFFSV0xwbTU5?=
 =?utf-8?B?WmFIelV2dEpnPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9136.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(1800799024)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WE1ELzJYbi9XSy9aaHRya2hoajd2RDZmcjZvTmxyNFllejNTRVV0cllhYk1m?=
 =?utf-8?B?YStET2JyZFpNdHExWW4wOTZqd2hjTkdzSm90d2RNYWhIRlhnYUw2Z1dteUY1?=
 =?utf-8?B?dHVKazBxYTRVRHZmYjRLT2Q3VmQ4L1dkR0ZLWjUvR3dhQXNBMC9rd0pieFoy?=
 =?utf-8?B?cnpzVndJYWJBMnllT2QvS090REZVOTNWMmhOd1dodU5aVE9VcC9DcjByNWh3?=
 =?utf-8?B?dlhVMzg2WXJMS1JhYUl5TjdnQk94eWFRaURvVGtqWnljbHZRWnpLSUhZakhz?=
 =?utf-8?B?NE5nU0JlVUI4RWhSY3hzZ3QwL0VCY2NIeWxpY0xnQnJ2MERPODJJbHlHOWxu?=
 =?utf-8?B?UHlUTmFhZU1UdnMwUG1FbmpHMDl5UGdSNFk4a09LR29ieXZRVFArN1lOTFVG?=
 =?utf-8?B?ZlZwaGNsV01aaG5peG0zUXRkZ1NEclNkNVk5TkppZGhxMWVZTGxMZXpqL3Qv?=
 =?utf-8?B?NzZEMXo5bXE3dUhFTzZFZ0hDdGRXb0YzRldDbWxNUFJSK05qR2RNeVQ4NFg2?=
 =?utf-8?B?bVVCMjc5a1F2YWp1RlBkODZ5bEhaVFVYWHUzSitpMmtIWnpUODFUNkI0WHJ3?=
 =?utf-8?B?VDJsMVhKeDY5NGgvSUdodTFLT2Zjc1NIVXJGS0F1RlJPZ3ZvWjZFZVBEZkh5?=
 =?utf-8?B?RCtvdnNYRnJDaHNrM3VZWGl5MGMzc3F5WWgyMysxeWxaK0ZadFVUNVZVYXYx?=
 =?utf-8?B?MXBIbTNuYlJpWWVHMXU3VlV5V1pYYTJoRS91ZnNMbTUwM0RyVXplL2F2ZXZt?=
 =?utf-8?B?dERYeW04TE9sb2loeTBJSHJPTXd3YmduaEQ4eEZqWkt3ZDdyUEkybjMrazFH?=
 =?utf-8?B?dkdCSUdpNm91QXpBTXpkRzNUbmJGdmJ5SG9QeDRoU3JnMlNyalZrZDhpU2Vu?=
 =?utf-8?B?Z1MrSlhtcnpvaCtTYnpGaE0yU3d6ZnhJaE5xWDY3cTRHV2d6NHlsaWZvVjRU?=
 =?utf-8?B?QmZIK0preHhjWkxKK1o5YncyYm5senZCKytCM1NwWDVPdjJ1VCtvWDZQbXhR?=
 =?utf-8?B?RTdkSFBhRHhOTUFQUUdFNlgxanNUaUQwK1JlVXo3cllQaE1RdnVMWVpQci9J?=
 =?utf-8?B?SXVvWkxPTVovcDBkSmU0ckR3b1QydVdHeXhRejVzeVRkQ0svZFZTenhWSjhz?=
 =?utf-8?B?MlpnYkRNZStncks4MmZXOVpPclhaaEQyVFN4bXdTeWh2ZEl1OWFFVXNIZlV0?=
 =?utf-8?B?djFwZFdESUhCMTcvQUhnNDBEQXEyWHVHM1JUYTBCbElNZ0xpSCt2aWZ3WjBD?=
 =?utf-8?B?NHFUQmxCdGlBTVVwMUM3d3hjT3NjM1o2YXQzbk1xMGtMYW00QmtGandhaVlF?=
 =?utf-8?B?YzV2OVNMeU11TEtVQ3JkVTRxZjUvWTlqWjFLZFJVMHg4cVMzRDBDWXJLVXRa?=
 =?utf-8?B?aFVoQUQveFk1NjBBTzc5OGQ3VC9aYTlXR2s4OFZnOURhbCt3Ujl0aW5xRGdI?=
 =?utf-8?B?WWFxUnVQS25nSkV2RGd3V3ByQkh5SjZjUzFGTEJ3VVowUE5SbEZLS09yeFhz?=
 =?utf-8?B?azZNaUd4ZHd5SWV2bUw2dXAyMno4T1cvZktCUndVSTE2VFdDSm0vc0hTVGdl?=
 =?utf-8?B?aCtzN3BRYjRESENyV2RsR1FTNG5BaHZyMmtkRHNLK1IxUHhlb3VCQ2libFN0?=
 =?utf-8?B?dElPREsyOXJJMnd2S0lkQUlpVTVuVUU0N0l0VmdTRDFXYVZZR1c0Q3dGRW9a?=
 =?utf-8?B?QU0rY2NLT1dPcG5mUXQzMFZjSFFyeFhQUFRkMWV0VzNyaVdMdE9qdncwdmhv?=
 =?utf-8?B?bmlJOWkrWkMyN3pLRUh0dGFkSFNmZ2FLMUM4WS9QaWZqOG1KbVNudjAzNXJa?=
 =?utf-8?B?UGtrbGNOM3ZDMEhnYXYwZ2JwbnMxRnE0RjgxR1NxRExDSGFqNVhOYnZXb1VI?=
 =?utf-8?B?MmMvSDVYUFVRR1BZc1F3Sm9PWWg4alMrY0JMaitLaXJvWWx6OEpvQ2dhRzJr?=
 =?utf-8?B?dzBVdkpiRGxvRWJ2UkR4WXBiaXROcGU5WDhWWmt3QUptOEpWRndzc0pGYklV?=
 =?utf-8?B?SXBRam5HV2xkNS9FWm5CbFU4Q2JQNE55Q1R4Y1JGNC91Wi8zMlpmVXRCclVR?=
 =?utf-8?B?Sjc2UGQyQS94SkhMOExNL3lIODljWTZiNWUwQkYwemlBV1JRTlRrTUFLai92?=
 =?utf-8?Q?sb3rBnrMn9nWxGBk/lIfJC+Qv?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9136.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1d8914d-4f4c-4f81-286b-08ddae0d47e7
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2025 02:10:22.0170 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0CLz4glrjJtuv9ARiNSFq9zzvIL7kgOvv02e5klgpqeewdhI2+sbt/ezVn7l8s0gZhL1sorCMH9MkeLQGn+53lwUe+EgXx/LitPdN09ofOQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR11MB9448
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.20;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -62
X-Spam_score: -6.3
X-Spam_bar: ------
X-Spam_report: (-6.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.89,
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

SGkgRXJpYywNCg0KPi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+RnJvbTogRXJpYyBBdWdl
ciA8ZXJpYy5hdWdlckByZWRoYXQuY29tPg0KPlN1YmplY3Q6IFJlOiBbUEFUQ0ggdjEgMDIvMTVd
IGludGVsX2lvbW11OiBPcHRpbWl6ZSBjb250ZXh0IGVudHJ5IGNhY2hlDQo+dXRpbGl6YXRpb24N
Cj4NCj5IaSBaaGVuemhvbmcsDQo+DQo+T24gNi82LzI1IDEyOjA0IFBNLCBaaGVuemhvbmcgRHVh
biB3cm90ZToNCj4+IFRoZXJlIGFyZSBtYW55IGNhbGwgc2l0ZXMgcmVmZXJlbmNpbmcgY29udGV4
dCBlbnRyeSBieSBjYWxsaW5nDQo+PiB2dGRfZGV2X3RvX2NvbnRleHRfZW50cnkoKSB3aGljaCB3
aWxsIHRyYXZlcnNlIHRoZSBETUFSIHRhYmxlLg0KPj4NCj4+IEluIG1vc3QgY2FzZXMgd2UgY2Fu
IHVzZSBjYWNoZWQgY29udGV4dCBlbnRyeSBpbiB2dGRfYXMtPmNvbnRleHRfY2FjaGVfZW50cnkN
Cj4+IGV4Y2VwdCB3aGVuIGl0cyBlbnRyeSBpcyBzdGFsZS4gQ3VycmVudGx5IG9ubHkgZ2xvYmFs
IGFuZCBkb21haW4gY29udGV4dA0KPj4gaW52YWxpZGF0aW9uIHN0YWxlIGl0Lg0KPj4NCj4+IFNv
IGludHJvZHVjZSBhIGhlbHBlciBmdW5jdGlvbiB2dGRfYXNfdG9fY29udGV4dF9lbnRyeSgpIHRv
IGZldGNoIGZyb20gY2FjaGUNCj4+IGJlZm9yZSB0cnlpbmcgd2l0aCB2dGRfZGV2X3RvX2NvbnRl
eHRfZW50cnkoKS4NCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBaaGVuemhvbmcgRHVhbiA8emhlbnpo
b25nLmR1YW5AaW50ZWwuY29tPg0KPj4gLS0tDQo+PiAgaHcvaTM4Ni9pbnRlbF9pb21tdS5jIHwg
MzYgKysrKysrKysrKysrKysrKysrKysrKystLS0tLS0tLS0tLS0tDQo+PiAgMSBmaWxlIGNoYW5n
ZWQsIDIzIGluc2VydGlvbnMoKyksIDEzIGRlbGV0aW9ucygtKQ0KPj4NCj4+IGRpZmYgLS1naXQg
YS9ody9pMzg2L2ludGVsX2lvbW11LmMgYi9ody9pMzg2L2ludGVsX2lvbW11LmMNCj4+IGluZGV4
IGYwYjFmOTBlZmYuLmEyZjMyNTA3MjQgMTAwNjQ0DQo+PiAtLS0gYS9ody9pMzg2L2ludGVsX2lv
bW11LmMNCj4+ICsrKyBiL2h3L2kzODYvaW50ZWxfaW9tbXUuYw0KPj4gQEAgLTE1OTcsNiArMTU5
NywyMiBAQCBzdGF0aWMgaW50DQo+dnRkX2Rldl90b19jb250ZXh0X2VudHJ5KEludGVsSU9NTVVT
dGF0ZSAqcywgdWludDhfdCBidXNfbnVtLA0KPj4gICAgICByZXR1cm4gMDsNCj4+ICB9DQo+Pg0K
Pj4gK3N0YXRpYyBpbnQgdnRkX2FzX3RvX2NvbnRleHRfZW50cnkoVlREQWRkcmVzc1NwYWNlICp2
dGRfYXMsDQo+VlREQ29udGV4dEVudHJ5ICpjZSkNCj4+ICt7DQo+PiArICAgIEludGVsSU9NTVVT
dGF0ZSAqcyA9IHZ0ZF9hcy0+aW9tbXVfc3RhdGU7DQo+PiArICAgIHVpbnQ4X3QgYnVzX251bSA9
IHBjaV9idXNfbnVtKHZ0ZF9hcy0+YnVzKTsNCj4+ICsgICAgdWludDhfdCBkZXZmbiA9IHZ0ZF9h
cy0+ZGV2Zm47DQo+PiArICAgIFZURENvbnRleHRDYWNoZUVudHJ5ICpjY19lbnRyeSA9ICZ2dGRf
YXMtPmNvbnRleHRfY2FjaGVfZW50cnk7DQo+PiArDQo+PiArICAgIC8qIFRyeSB0byBmZXRjaCBj
b250ZXh0LWVudHJ5IGZyb20gY2FjaGUgZmlyc3QgKi8NCj4+ICsgICAgaWYgKGNjX2VudHJ5LT5j
b250ZXh0X2NhY2hlX2dlbiA9PSBzLT5jb250ZXh0X2NhY2hlX2dlbikgew0KPj4gKyAgICAgICAg
KmNlID0gY2NfZW50cnktPmNvbnRleHRfZW50cnk7DQo+PiArICAgICAgICByZXR1cm4gMDsNCj4+
ICsgICAgfSBlbHNlIHsNCj4+ICsgICAgICAgIHJldHVybiB2dGRfZGV2X3RvX2NvbnRleHRfZW50
cnkocywgYnVzX251bSwgZGV2Zm4sIGNlKTsNCj4+ICsgICAgfQ0KPj4gK30NCj4+ICsNCj5XaGls
ZSB0aGUgcGF0Y2ggbG9va3MgZ29vZCB0byBtZSBjYW4ndCB5b3UgdXNlIHRoZSBoZWxwZXIgYWxz
byBpbg0KPnZ0ZF9kb19pb21tdV90cmFuc2xhdGUoKT8NCj5TZWUgIiAvKiBUcnkgdG8gZmV0Y2gg
Y29udGV4dC1lbnRyeSBmcm9tIGNhY2hlIGZpcnN0ICovIg0KDQpJdCBjYW4sIGJ1dCBpdCBmaW5h
bGx5IGNhbGxzIGludG8gdnRkX2Rldl90b19jb250ZXh0X2VudHJ5KCkgc28gd2UgY2FuIGNhbGwg
dnRkX2Rldl90b19jb250ZXh0X2VudHJ5KCkgZGlyZWN0bHkuDQpJIHdpbGwgZHJvcCB0aGlzIHBh
dGNoIGZvbGxvd2luZyBZaSdzIHN1Z2dlc3Rpb24uDQoNClRoYW5rcw0KWmhlbnpob25nDQo=

