Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFD60C4345F
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2024 01:39:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s3nJB-000517-ET; Sun, 05 May 2024 21:38:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1s3nJA-00050P-09
 for qemu-devel@nongnu.org; Sun, 05 May 2024 21:38:24 -0400
Received: from mgamail.intel.com ([198.175.65.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1s3nJ6-0008B2-Sm
 for qemu-devel@nongnu.org; Sun, 05 May 2024 21:38:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1714959501; x=1746495501;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=TyshVee78gG/YKXbB0SjH8IYAn/y6OzTaFc1RSpRksI=;
 b=VCXv+ki7HOVy4kTroKHrhqMfEmcSrjJGOLBxT31C4dCC84bKjGqIShSL
 wJXjgORRvTORj/RuGZscpHKAGO/8HGscDasxkAU2qAQptGRGRerRgChp9
 +bdqMmuCwHm6c+wtTQNoNP4pbR1vPenF81f5/vdQ/HAXkwQe4neAJSdOj
 SD1K+cVokZARiJtIba/m5LOd3LGdmZeUD/Z4J2IF8oVPQ2d+t0EmBRfVj
 XKGNKg8X2bNbjDZXtRUALyDM7DXIzl8IUW6ri/V0QNoHPpl+XDc9xg70G
 iMFI4o1DGZZBPHtBUA3cLwXvNYE712JMTUSR3FIMFxpiUVYL35RtSBx+c g==;
X-CSE-ConnectionGUID: 3buysbO+Sfuf8XVOBe/zMg==
X-CSE-MsgGUID: AWqSFKTrTFe0JMpEpNSYBw==
X-IronPort-AV: E=McAfee;i="6600,9927,11064"; a="10811264"
X-IronPort-AV: E=Sophos;i="6.07,257,1708416000"; d="scan'208";a="10811264"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 May 2024 18:38:17 -0700
X-CSE-ConnectionGUID: SgAIFS3eTLeZHJJBXmsPxw==
X-CSE-MsgGUID: T4FYJ/MTQ8a4S5ZCGFk5hA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,257,1708416000"; d="scan'208";a="32617540"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
 by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 05 May 2024 18:38:16 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 5 May 2024 18:38:16 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Sun, 5 May 2024 18:38:16 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Sun, 5 May 2024 18:38:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XKlNYn4o5eUQcm5tMTQn0hPNUZNuC1jkaHRcbpldBCcfaXurNZZWzImkcSJ7Ww/bozDJSDFS3tfS/aw9L80Jv09nvzXJ+npf//cCYcII8rEFbItmWVIUYQYh4Velqf69D0524lvzbvliudzGssAx7C3blCMFCiqO6FmiD0GkMUTsnOb4Pl+O7Y9NH3OEbHRvg91QzZRPTIj1fG4EXJ5oFjQjXu6sxTHpLPgtA8J8Re8swI5E5IttBMXaGhirHItSyNOxv+DPf3nJFKqOyheEkmuecq/C4KaNWRmYwBYLrEY7H8TqKY5oflmxB++AFM/h1BUF9of50B3FAJW8EfQx/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TyshVee78gG/YKXbB0SjH8IYAn/y6OzTaFc1RSpRksI=;
 b=NX4HvdzFoRBh5m4LED23D1jzS5vR0CKCsgpsa5gTDUjNYHvPfnimqqjGvpvFZlg8ohUvyxnFTPDjB0r02eFLNeviI/5kkQ2qroRg9uwqICyXjXPTgm48OK8LBcUfWq6OseIdwLW7mFu3L76KbANzijwuIGZqKY2uCZMrspSFEKge/NwzSNxLVBN5gCQa/G929g4Mf99t69hZFEnYOKJxiVB4lXnTnhBtkBm/E4IMv4LjcY4RNZ39m52W7x3dFMquaukW0QEIbdoRMjaAlAQA4Ybs/ZMWQlcDKbsxLCA/M3UhSjSMzjDEAW1PaYBF4ncKtt+df03Ood1u43/ne78FFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by CO1PR11MB5026.namprd11.prod.outlook.com (2603:10b6:303:9c::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.41; Mon, 6 May
 2024 01:38:14 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::e4a3:76ce:879:9129]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::e4a3:76ce:879:9129%7]) with mapi id 15.20.7544.041; Mon, 6 May 2024
 01:38:14 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>,
 =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "jasowang@redhat.com" <jasowang@redhat.com>, "Tian, Kevin"
 <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>, Joao Martins
 <joao.m.martins@oracle.com>, Peter Xu <peterx@redhat.com>, Eric Auger
 <eric.auger@redhat.com>, "eperezma@redhat.com" <eperezma@redhat.com>, "Peng,
 Chao P" <chao.p.peng@intel.com>
Subject: RE: [PATCH intel_iommu 0/7] FLTS for VT-d
Thread-Topic: [PATCH intel_iommu 0/7] FLTS for VT-d
Thread-Index: AQHamwiDe5j67ytP7Eizl35edXhELbGBjs6QgAHXVwCABg6X4A==
Date: Mon, 6 May 2024 01:38:13 +0000
Message-ID: <SJ0PR11MB67443F458DB55397FA4BF58C921C2@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20240422155236.129179-1-clement.mathieu--drif@eviden.com>
 <9e15abd9-f824-4f11-9532-b0dcb7b521dd@redhat.com>
 <SJ0PR11MB6744D9C5BCFBA146FE09270492192@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <f00d7bfa-91d0-4c58-8b7e-bd3dad477e9f@eviden.com>
In-Reply-To: <f00d7bfa-91d0-4c58-8b7e-bd3dad477e9f@eviden.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|CO1PR11MB5026:EE_
x-ms-office365-filtering-correlation-id: 9aac876f-d0d0-40fb-5496-08dc6d6d3229
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|1800799015|366007|376005|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?ZGd3QnVPVk9xaTgrbm5NU1RGV2NycUVFQlRjMFlKVGQwRzRWTllnTTJ6ZnRK?=
 =?utf-8?B?MWNyanFzNDRwNDN3M0hEbTRiclNONkswUUpyQzBXUHFYVmI3eWczUEZVV0pM?=
 =?utf-8?B?RTBpRGZxb1JDOUpNYVNhTlJCdk1vemJORXVGUGU2ZG5qNjd6YzFnbTlvdkxU?=
 =?utf-8?B?SExpeVAzajMwRkRxSStRSWtJV1BXZzdUNkp4OEwzVGpGUUNaZ1h2R0x2WkhO?=
 =?utf-8?B?SFZ6MXFWZmpqZXllSENyMVRoemFndkg3RkRrclF2V1E2c25tQlBWL3RvQTBm?=
 =?utf-8?B?Y3RjTmU5cnlTeHBVdWhUc2h6KzZRUHBaZ3djS3BRaEtlcWQyQTE2ZlEzNFd4?=
 =?utf-8?B?UzBhL2lHaUlQbmRPYUVUOURrTkVtbzVDZTVEbjZPdkZPbEVBVklZZHhhTU14?=
 =?utf-8?B?c1VENVBtUlNYRGI2eEptbTgwNkRyRXlIZ25jOTI5YlhNcHZxRXFVbk5MRkc5?=
 =?utf-8?B?TDB4WEQxRjJ5UXJ3TzFjdmhyUHFBMW96bHBGRU1DTytoTjdTaktJUmlPTVhB?=
 =?utf-8?B?a2hPVDA3RVVqUWdzVzV5b1QvWmJySm9vR3A5UHJ0a0M5TVRZVFZCQ2s5YnRO?=
 =?utf-8?B?YVVXMTBUelZMeTdLMHZvZGx6TVFCWmFucng2RnVqSmYrRlFUQ1VMOHAveVlL?=
 =?utf-8?B?M0tkQ2RGYnllRngxRFJmcjNlMkxmOWJhV1VManJuN0JCTVYwaVRiSG53Tm5k?=
 =?utf-8?B?WW1aN3ZFM2h2RXNLS3hteC93c0ltOSt4bFJtU2MrTkhyZWdPQ3hKcFQ4b043?=
 =?utf-8?B?d2llOFc0NjlpVS9GZWFtV1Y4K21WRk5nVTdMMkQzbFNaczk4M3hMRmtlbkJq?=
 =?utf-8?B?cTRqdUFKWmJ0K2l1Y1hta21NWVZaVTcxNUhoQnFwS2pVRG9BOWdlOXZlSi9v?=
 =?utf-8?B?WFkvOFl5cjc5MnFZc1N3cHZlSGdJQzZSZDd4VWgrQ2MvdU5hOEc0QXIvRE5I?=
 =?utf-8?B?M1hpR3kxZy93NGNGeFo5WHYwb1hkY1U5eFBvSmxaTFFreG1BaFVCY0tMenlY?=
 =?utf-8?B?ZVE2U0hGK0x0K3pITDZpdEVqRUV5Zkx0c2lhSGU1QUR3aUJOVDBPY1JvT09F?=
 =?utf-8?B?dWozK3hmRXNNMTRBaWlBTHFTMWtIUTBZNllNSE94endjQzJ1akdmOVlhdUxq?=
 =?utf-8?B?SXVsNXdVSGFwazNZdU9xZTd6VEF4Mm1pbkhQR1J5NVZ0Z0JFMkovdk5lWXJj?=
 =?utf-8?B?NisvZEtzM3I3Y1hTaXdSaStkTnNLb25QMFk3MlRrd29heWlySHZsS1lHMzFO?=
 =?utf-8?B?Unp5Vmg2L2twU1VxYjdiSjk4b0gxUHg4dU5LdlQ5VmhGUUZ1bEI5azU1WFFX?=
 =?utf-8?B?Tytsdk1JdUV2d2dTci8zbVhoZHpQSllIc3luNDRPelJiREZINHJCZCtHbGQr?=
 =?utf-8?B?RFhwMmFXUHMyRm5JTVJtdmlNdXJMbFBGMkxTWnFodTUvNHlXb1QxMUp4L0kw?=
 =?utf-8?B?V1BrdFJVUmY3Z1F0SGIzam92di9zd2xCSzYzTlZSWEdxY3JldHNSTXhHeWpO?=
 =?utf-8?B?cnNoWERTTjZLampLbEZ2VTVvUXUrb25FRHN0NjNNWTFzZWhnazdDNVNDTDJ1?=
 =?utf-8?B?eHZ5Q0F4cGRGcXdqc25rT2RudnRiSTluTHVPNUZnbjBVSjgvRzdCNGpaaUU1?=
 =?utf-8?B?SWgxa2k0dC9tb2VGS1o5UVNtQ0tyOS9xWkQyc3hiOXJpTnFraURQWWo2bXJa?=
 =?utf-8?B?akNQSVZOSSs0MXVUUzgwUXUxWlRWSDFnZlpWd1cvY1ZXc056bkpWeE0xS2Uv?=
 =?utf-8?Q?OOh2gzV1fxr+pVlZDU=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(366007)(376005)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?elh1QW53aUI3UFN6TXJnVEZRNFRtV202cEdhUk1vRkxkS0RRQU95Njhzazl0?=
 =?utf-8?B?VXpKMXNsZDVyRmcwWDlscWUxNHlRWVVNVzJieDdCR0xMSTRSbjRjN2d6L2N5?=
 =?utf-8?B?RjhxWS93UFVrNXk0bzMwdzl3bCtaci91Qi9CQThzdVZMMGt5OXhrNktzNXNK?=
 =?utf-8?B?SFpaK2NNZ1hkbXBaMDhYYUpncDVJZmpNNXViWVB3Sm54TUVHa05rV2xXcFBN?=
 =?utf-8?B?TkJYalBSMTgvSHRpUkN3TExFVGR6c2VNeVlGNXFJZHY5QVhEb053b01qNlhZ?=
 =?utf-8?B?RTUzMDh1NS9sRitybkhYenRqMkJTWGdCVTdKalhvd0N5N05XV1Y3emhwRURh?=
 =?utf-8?B?RkFYOEs1NUhDdGs1N2dqSWhDUTBtbjZVRmZES1Vsa0dYNytCTUdGSFpOQ05x?=
 =?utf-8?B?a3FFM0RJdVRyTU9CYndrbmhaWHBBanJLM09yNzB5YmxqQ3ExY3o2ZkZSNS95?=
 =?utf-8?B?MzBUVHB1dTdBaDZodmkzbDlRczJzN3d6QmRsMStRTXBJSVpULzhSM3pTVHBh?=
 =?utf-8?B?Q2hsZ3IwOXBOU0VWZnB0N1BUOTZnZlRjV3VucnZjajd5TVVVN2JQcnFtT0My?=
 =?utf-8?B?UWdiVi9WSzA0U1NjcHhwYVl2UzYrT2xmMlN6ZklQVEh1dS9EKzlDMG9uaTVw?=
 =?utf-8?B?VndqMUlqd09SOS9rd29wUmlXUFBPYncrenV6OFpldEtsdU5VSWRjZldQUVFE?=
 =?utf-8?B?ZzhWTjVFZXlEUkxiTmk0YnE1VUdVdUZheTAxa3pPOTIxazl4ejhPeHlzTGRS?=
 =?utf-8?B?ZzNxd0dYSHBBbmdzT014b2ROcEhYY21FZXJvYjY4RUVWNitYaUNCcXVTa1lv?=
 =?utf-8?B?QmpjQVlnVFZ5bDRvV1MzMC80M2tVcVpqQlhXeXBnelRwa0xJRHZPZTVLalpX?=
 =?utf-8?B?M2VObkNoM1pXc2ZUMUNHUVF1MTc1YlJBT2R6b2dWR29DbnBRSldMZVEyUnJE?=
 =?utf-8?B?R2hlODJKbTZnajQvbDBGUndMR0FhcmhWdmVpME9MbXQ0c09OZDlMVG1vZ0FR?=
 =?utf-8?B?d204aDI2emx0U3JNWjg3ZHY3aG1JVlZFbjRuZUluK0QraFF2M21yZ1QvTnI2?=
 =?utf-8?B?OWdUTWp3YkpmdTdhOVRqaHJWRDhBUEh4cGN0Z2MrRUE2aWVVTjd6OWVUcTAx?=
 =?utf-8?B?VXRmU2V0Nm9wSlRnc0VuT1Nha0xBeVBTSWxlZlhLekcwbDRqbmd3TWUrMzlx?=
 =?utf-8?B?SnJMR3A3Vmo3VmY4b3JXU0d4dkFtTGptVGMzRVEvTGdJUEUxSkFmSk9aN201?=
 =?utf-8?B?UGQ5RXovM1AvdlVSVlpPYmk3RlZxZEZ6L1lhS2dJYVZ6L2hKcTE1cGJJWG1S?=
 =?utf-8?B?eWY4U0lwWUxQaUtmb2xMQXBPYjZ2RFZGQXE2N0tERnJrbWtJRWxQT0tMWVBO?=
 =?utf-8?B?ZHpSaXpQdXZKZmFFOFJGYkVZVWpZbHJSREs3ODI3WHZ2OSs3d0JrQ1dYRWlp?=
 =?utf-8?B?OWNhYjhBMGpnMVAvd1FOQ2syakE1RUdOMmhHNDV4WWluYy93dVA2N0dDMFU0?=
 =?utf-8?B?UW40ZS93MlphZUE3ZzY5WWxEM3c0TEw5RUtmbS85VHRXWWVqRDJhNVFPam5X?=
 =?utf-8?B?OVMrajlFWnlPRnIxd2hDdTlzbTlheFp5WXYvdEtud3ptQUFYaDh1QWJqaG00?=
 =?utf-8?B?QlBDUmdJNjFHMjRVdHI2L0czdXJCeFZrT1ZEL2ZNMUVQSVNSVExkVUpKRkNS?=
 =?utf-8?B?bStDcG1JcGNtSHRqYzZFUzExVng3dnVFcmpSN1lyRXM1SFdVenYyR1lWM3Az?=
 =?utf-8?B?c2FCendxNzNKYjhIWlhGTkdFUE9Mb2tDYnFmTzZFdkVoRjhIWjBDYTVOM0hO?=
 =?utf-8?B?VDJYWkxyUWNqdmx5cFpFY3pyN3B1MGJCZmVkaU5vUzJOS2s2Y0QxdDFyUlcw?=
 =?utf-8?B?L29jcWtBL25pMzBnODRmSzQwVmxuWmJSV3FvVjdkSDRoK0xLSS9JdzhlemxP?=
 =?utf-8?B?dEhoQzRTQjQxdlAvbVlWbXM5RVlXQzVDTnN1QjRxczg0eWpoQnJjNmxraDBH?=
 =?utf-8?B?QTdMbThDMnUxaitMRXRYMlVRTWZxYVNFUzJxTDB2TEpWUUFxdW12NmlkcG04?=
 =?utf-8?B?UnFuVlgyTzBSU0xYUW1zNEhaVVJyd1hGTjFHRnVzZ3lsb3FHc3ZpcktsMjN1?=
 =?utf-8?Q?rqr0FeX1jcev0G9pLMCQfZGpH?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9aac876f-d0d0-40fb-5496-08dc6d6d3229
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 May 2024 01:38:13.9925 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: u10xcySRg2mNm5XQQyK/8zRCe+6Nu3OaqNns1ZdPgAjF8waW0waWBatYCde4sVIBzij7T/5CY10wgjW9VMOE7elW43EDyapMdjOqHzOPR/Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5026
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.16;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.431,
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

SGkgQ2xlbWVudCwNCg0KU29ycnkgZm9yIGxhdGUgcmVzcG9uc2UsIGp1c3QgYmFjayBmcm9tIHZh
Y2F0aW9uLg0KSSBzYXcgeW91ciByZWJhc2VkIHZlcnNpb24gYW5kIHRoYW5rcyBmb3IgeW91ciB3
b3JrLg0KSSdsbCBzY2hlZHVsZSBhIHRpbWVzbG90IHRvIHJldmlldyB0aGVtLg0KDQpUaGFua3MN
ClpoZW56aG9uZw0KDQo+LS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj5Gcm9tOiBDTEVNRU5U
IE1BVEhJRVUtLURSSUYgPGNsZW1lbnQubWF0aGlldS0tZHJpZkBldmlkZW4uY29tPg0KPlN1Ympl
Y3Q6IFJlOiBbUEFUQ0ggaW50ZWxfaW9tbXUgMC83XSBGTFRTIGZvciBWVC1kDQo+DQo+SGkgWmhl
bnpob25nLA0KPg0KPkkgd2lsbCByZWJhc2UsDQo+DQo+dGhhbmtzDQo+DQo+T24gMDEvMDUvMjAy
NCAxNDo0MCwgRHVhbiwgWmhlbnpob25nIHdyb3RlOg0KPj4gQ2F1dGlvbjogRXh0ZXJuYWwgZW1h
aWwuIERvIG5vdCBvcGVuIGF0dGFjaG1lbnRzIG9yIGNsaWNrIGxpbmtzLCB1bmxlc3MgdGhpcw0K
PmVtYWlsIGNvbWVzIGZyb20gYSBrbm93biBzZW5kZXIgYW5kIHlvdSBrbm93IHRoZSBjb250ZW50
IGlzIHNhZmUuDQo+Pg0KPj4NCj4+IEFoLCB0aGlzIGlzIGEgZHVwbGljYXRlIGVmZm9ydCBvbiBz
dGFnZS0xIHRyYW5zbGF0aW9uLg0KPj4NCj4+IEhpIENsZW1lbnQsDQo+Pg0KPj4gV2UgaGFkIGV2
ZXIgc2VudCBhIHJmY3YxIHNlcmllcyAiaW50ZWxfaW9tbXU6IEVuYWJsZSBzdGFnZS0xIHRyYW5z
bGF0aW9uIg0KPj4gZm9yIGJvdGggZW11bGF0ZWQgYW5kIHBhc3N0aHJvdWdoIGRldmljZSwgbGlu
azoNCj4+IGh0dHBzOi8vbGlzdHMuZ251Lm9yZy9hcmNoaXZlL2h0bWwvcWVtdS1kZXZlbC8yMDI0
LTAxL21zZzAyNzQwLmh0bWwNCj4+IHdoaWNoIG5vdyBldm9sdmVzIHRvIHJmY3YyLCBsaW5rOg0K
Pj4NCj5odHRwczovL2dpdGh1Yi5jb20veWlsaXUxNzY1L3FlbXUvY29tbWl0cy96aGVuemhvbmcv
aW9tbXVmZF9uZXN0aW5nDQo+X3JmY3YyLw0KPj4NCj4+IEl0IGhhZCBhZGRyZXNzZWQgcmVjZW50
IGNvbW11bml0eSBjb21tZW50cywgYWxzbyB0aGUgY29tbWVudHMgaW4gb2xkDQo+aGlzdG9yeSBz
ZXJpZXM6DQo+Pg0KPmh0dHBzOi8vcGF0Y2h3b3JrLmtlcm5lbC5vcmcvcHJvamVjdC9rdm0vY292
ZXIvMjAyMTAzMDIyMDM4MjcuNDM3NjQ1DQo+LTEteWkubC5saXVAaW50ZWwuY29tLw0KPj4NCj4+
IFdvdWxkIHlvdSBtaW5kIHJlYmFzaW5nIHlvdXIgcmVtYWluaW5nIHBhcnQsIGkuZS4sIEFUUywg
UFJJIGVtdWxhdGlvbiwgZXRjDQo+b24gdG8gb3VyIHJmY3YyPw0KPj4NCj4+IFRoYW5rcw0KPj4g
Wmhlbnpob25nDQo+Pg0KPj4+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+Pj4gRnJvbTog
Q8OpZHJpYyBMZSBHb2F0ZXIgPGNsZ0ByZWRoYXQuY29tPg0KPj4+IFN1YmplY3Q6IFJlOiBbUEFU
Q0ggaW50ZWxfaW9tbXUgMC83XSBGTFRTIGZvciBWVC1kDQo+Pj4NCj4+PiBIZWxsbywNCj4+Pg0K
Pj4+IEFkZGluZyBhIGZldyBwZW9wbGUgaW4gQ2M6IHdobyBhcmUgZmFtaWxpYXIgd2l0aCB0aGUg
SW50ZWwgSU9NTVUuDQo+Pj4NCj4+PiBUaGFua3MsDQo+Pj4NCj4+PiBDLg0KPj4+DQo+Pj4NCj4+
Pg0KPj4+DQo+Pj4gT24gNC8yMi8yNCAxNzo1MiwgQ0xFTUVOVCBNQVRISUVVLS1EUklGIHdyb3Rl
Og0KPj4+PiBUaGlzIHNlcmllcyBpcyB0aGUgZmlyc3Qgb2YgYSBsaXN0IHRoYXQgYWRkIHN1cHBv
cnQgZm9yIFNWTSBpbiB0aGUgSW50ZWwNCj5JT01NVS4NCj4+Pj4NCj4+Pj4gSGVyZSwgd2UgaW1w
bGVtZW50IHN1cHBvcnQgZm9yIGZpcnN0LXN0YWdlIHRyYW5zbGF0aW9uIGluIFZULWQuDQo+Pj4+
IFRoZSBQQVNJRC1iYXNlZCBJT1RMQiBpbnZhbGlkYXRpb24gaXMgYWxzbyBhZGRlZCBpbiB0aGlz
IHNlcmllcyBhcyBpdCBpcyBhDQo+Pj4+IHJlcXVpcmVtZW50IG9mIEZMVFMuDQo+Pj4+DQo+Pj4+
IFRoZSBsYXN0IHBhdGNoIGludHJvZHVjZXMgdGhlICdmbHRzJyBvcHRpb24gdG8gZW5hYmxlIHRo
ZSBmZWF0dXJlIGZyb20NCj4+Pj4gdGhlIGNvbW1hbmQgbGluZS4NCj4+Pj4gT25jZSBlbmFibGVk
LCBzZXZlcmFsIGRyaXZlcnMgb2YgdGhlIExpbnV4IGtlcm5lbCB1c2UgdGhpcyBmZWF0dXJlLg0K
Pj4+Pg0KPj4+PiBUaGlzIHdvcmsgaXMgYmFzZWQgb24gdGhlIFZULWQgc3BlY2lmaWNhdGlvbiB2
ZXJzaW9uIDQuMSAoTWFyY2ggMjAyMykNCj4+Pj4NCj4+Pj4gSGVyZSBpcyBhIGxpbmsgdG8gYSBH
aXRIdWIgcmVwb3NpdG9yeSB3aGVyZSB5b3UgY2FuIGZpbmQgdGhlIGZvbGxvd2luZw0KPj4+IGVs
ZW1lbnRzIDoNCj4+Pj4gICAgICAgLSBRZW11IHdpdGggYWxsIHRoZSBwYXRjaGVzIGZvciBTVk0N
Cj4+Pj4gICAgICAgICAgIC0gQVRTDQo+Pj4+ICAgICAgICAgICAtIFBSSQ0KPj4+PiAgICAgICAg
ICAgLSBQQVNJRCBiYXNlZCBJT1RMQiBpbnZhbGlkYXRpb24NCj4+Pj4gICAgICAgICAgIC0gRGV2
aWNlIElPVExCIGludmFsaWRhdGlvbnMNCj4+Pj4gICAgICAgICAgIC0gRmlyc3Qtc3RhZ2UgdHJh
bnNsYXRpb25zDQo+Pj4+ICAgICAgICAgICAtIFJlcXVlc3RzIHdpdGggYWxyZWFkeSB0cmFuc2xh
dGVkIGFkZHJlc3Nlcw0KPj4+PiAgICAgICAtIEEgZGVtbyBkZXZpY2UNCj4+Pj4gICAgICAgLSBB
IHNpbXBsZSBkcml2ZXIgZm9yIHRoZSBkZW1vIGRldmljZQ0KPj4+PiAgICAgICAtIEEgdXNlcnNw
YWNlIHByb2dyYW0gKGZvciB0ZXN0aW5nIGFuZCBkZW1vbnN0cmF0aW9uIHB1cnBvc2VzKQ0KPj4+
Pg0KPj4+PiBodHRwczovL2dpdGh1Yi5jb20vQnVsbFNlcXVhbmEvUWVtdS1pbi1ndWVzdC1TVk0t
ZGVtbw0KPj4+Pg0KPj4+PiBDbMOpbWVudCBNYXRoaWV1LS1EcmlmICg3KToNCj4+Pj4gICAgIGlu
dGVsX2lvbW11OiBmaXggRlJDRCBjb25zdHJ1Y3Rpb24gbWFjcm8uDQo+Pj4+ICAgICBpbnRlbF9p
b21tdTogcmVuYW1lIHNscHRlIHRvIHB0ZSBiZWZvcmUgYWRkaW5nIEZMVFMNCj4+Pj4gICAgIGlu
dGVsX2lvbW11OiBtYWtlIHR5cGVzIG1hdGNoDQo+Pj4+ICAgICBpbnRlbF9pb21tdTogYWRkIHN1
cHBvcnQgZm9yIGZpcnN0LXN0YWdlIHRyYW5zbGF0aW9uDQo+Pj4+ICAgICBpbnRlbF9pb21tdTog
ZXh0cmFjdCBkZXZpY2UgSU9UTEIgaW52YWxpZGF0aW9uIGxvZ2ljDQo+Pj4+ICAgICBpbnRlbF9p
b21tdTogYWRkIFBBU0lELWJhc2VkIElPVExCIGludmFsaWRhdGlvbg0KPj4+PiAgICAgaW50ZWxf
aW9tbXU6IGFkZCBhIENMSSBvcHRpb24gdG8gZW5hYmxlIEZMVFMNCj4+Pj4NCj4+Pj4gICAgaHcv
aTM4Ni9pbnRlbF9pb21tdS5jICAgICAgICAgIHwgNjU1ICsrKysrKysrKysrKysrKysrKysrKysr
KysrLQ0KPi0tLS0tDQo+Pj4gLQ0KPj4+PiAgICBody9pMzg2L2ludGVsX2lvbW11X2ludGVybmFs
LmggfCAxMTQgKysrKy0tDQo+Pj4+ICAgIGluY2x1ZGUvaHcvaTM4Ni9pbnRlbF9pb21tdS5oICB8
ICAgMyArLQ0KPj4+PiAgICAzIGZpbGVzIGNoYW5nZWQsIDYwOSBpbnNlcnRpb25zKCspLCAxNjMg
ZGVsZXRpb25zKC0pDQo+Pj4+DQo=

