Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D8CDC3DA49
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2024 03:31:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTvNF-0000Bu-09; Tue, 16 Jul 2024 23:30:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sTvMv-000091-41
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 23:30:20 -0400
Received: from mgamail.intel.com ([198.175.65.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sTvMo-000793-KN
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 23:30:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1721187010; x=1752723010;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=glrH3k9Ogd+OgAtQ7g1LH0mhbk8c/oo4yk2kAOuU6YA=;
 b=HCvRvKdcqOCl4VxrzbPvsmpzecy5a6KASRLdUKpesvZV595OtrTwZmpG
 ovF4APKUZkiKvDFmo0y1nLal8bPXyLqajJ4BEbBJTmnH9HIA0bJjZo6xS
 RVA69fFlpA7ekGiN04YNs8HyQ/dzsY4sp02FZYvCdSpjGpExFRcv1iy56
 rkTDqRcYbMqkRfMmHl4Rt56u8ues4Lz8gC6YYfahx0ldCbLkuVLhTfAVD
 fxYAMBy3ge0r91AUW828TXWAJ1O9VVYak7+Y5bm7r21Jt7QHLrE3HS36D
 t004gOOsLqSW2Ijz5jb2RZ0jVMNEtrancA6OT4eJ3azk4TRrbet6ERZDC w==;
X-CSE-ConnectionGUID: bv+1oKUxRyCCBThshZvPZw==
X-CSE-MsgGUID: grl9/ZtuQ+qXuiENdCRNJw==
X-IronPort-AV: E=McAfee;i="6700,10204,11135"; a="18620722"
X-IronPort-AV: E=Sophos;i="6.09,213,1716274800"; d="scan'208";a="18620722"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Jul 2024 20:30:07 -0700
X-CSE-ConnectionGUID: jojSGoKEQIG0mcZ7p5JOAg==
X-CSE-MsgGUID: 6lK2xKf2TZq7bvaNfOXTUw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,213,1716274800"; d="scan'208";a="50173717"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
 by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 16 Jul 2024 20:30:07 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 16 Jul 2024 20:30:06 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 16 Jul 2024 20:30:06 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.47) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 16 Jul 2024 20:30:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rWtCAEqlTIm2UcUJVejnTSRK0iZKGomQ1wb+q0bpyCSe7HChvSFmXcdjEcIjGUXm+wnLG+5/E03l27r/3Pj2aL+7Z9FgfliXC4Wtvt/ZsOIVWghrq3iykTsM4u/i2Hq5lvqNRWtrY643pE2s04mBiBqHkOxo/nqizB90kAGo099Mn5M9fJBfPrXRKIxo3SJtC+205w4GbpQ2/3o5/JeOP6/kxitVRERfdxrQlTjGJCBmZlrxMl4/VNJNJ4fyyNFtTzMT7Zugd14alaEVvDNM0fnV5Ed50EEjmOeKx6Uj0QvPPlhtVzHOls/gMSkb3+JHiqjGUExGbkO/jUFJ77k6rA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=glrH3k9Ogd+OgAtQ7g1LH0mhbk8c/oo4yk2kAOuU6YA=;
 b=GxncXY8h12xEAtOTyxyEng8WwvbEr7WvNxHquKuF4drkMBLQbHeCCZ/zzg/2jgLihqQIhTwW7CcW6FaGAfZZ+6DEyGh25IG+5tPJHJ6Gbp0W2FeBmfOLnBg/Vr9lz/WUhBhvx6cVFV0hVC0+gKXRQhKWB5kj8h4fhLwP11/pXLDyxcFq8l0TFlPOTqn8TfwCdfAbENRTx+O2eYSHLI/aAKl3rnXUct2Pn3Fsge2HLuCySs9jxdQjRvJK9ImzYUCY2Ug85czsw7U55Lz3lTB1vuOp0kkmW18mHGQYIL9hRiwZd18/etXcA9mlRTbmyVK/y5dAA2S3hl/9+2cmRw6pLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by DS0PR11MB8764.namprd11.prod.outlook.com (2603:10b6:8:192::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.28; Wed, 17 Jul
 2024 03:30:03 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091%7]) with mapi id 15.20.7784.016; Wed, 17 Jul 2024
 03:30:03 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: "Liu, Yi L" <yi.l.liu@intel.com>, Jason Wang <jasowang@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "Peng, Chao P"
 <chao.p.peng@intel.com>, Yu Zhang <yu.c.zhang@linux.intel.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Marcel Apfelbaum
 <marcel.apfelbaum@gmail.com>
Subject: RE: [PATCH] intel_iommu: Use the latest fault reasons defined by spec
Thread-Topic: [PATCH] intel_iommu: Use the latest fault reasons defined by spec
Thread-Index: AQHaqESnRiGl1jiq20uiRV0AFydhKrGfTQkAgAAs2mCAAA5PgIABefcAgAB9i4CAAW9wgIADKlPwgARf+4CAAAObwIAAMu3QgAAD1oCAAVLkgIA3YEcAgBc6kRA=
Date: Wed, 17 Jul 2024 03:30:03 +0000
Message-ID: <SJ0PR11MB6744F95EB6B6182D90DE8D8392A32@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <CACGkMEvTomFeC1bM3SfY1zGhQ_5i15r6CY6M3jVzau6niNUf_w@mail.gmail.com>
 <SJ0PR11MB6744AECEAA6F9319259B0DF192E92@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <DS0PR11MB752917B52B66A6EF10C10678C3E92@DS0PR11MB7529.namprd11.prod.outlook.com>
 <CACGkMEt5ofYt12A6uKUj=QLcLbOnrGT=UkMpee=MUxO6Xy3sxg@mail.gmail.com>
 <SJ0PR11MB6744C340AAB1B786D3913F5D92EA2@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <CACGkMEsV05ujKNEL9JSAsfikWGW582yvfSOdHJgRxZC_1cxgEg@mail.gmail.com>
 <SJ0PR11MB67445F7F8B79D2C2B982C1F692F52@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <CACGkMEuO6T-LqcZ=5oRR83LyhZ7oOtZvb70CUksZDAmC1KnsOA@mail.gmail.com>
 <SJ0PR11MB6744135D8C08CEE42460CAF792F02@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <SJ0PR11MB67448F0D3CE487F125D274AF92F02@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <20240527025023-mutt-send-email-mst@kernel.org>
 <CACGkMEuCqCNhVvXYN6jT5CDHbnt8sEHUk2UfwVaaOVLXfSfv3w@mail.gmail.com>
 <a791e442-f5b5-4670-9394-876b041cfd62@intel.com>
In-Reply-To: <a791e442-f5b5-4670-9394-876b041cfd62@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|DS0PR11MB8764:EE_
x-ms-office365-filtering-correlation-id: a75bd018-409d-4d66-7343-08dca610bf3e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?SWUrS3ozV3g3NTF6dThpM1poYklkU1gyRGpiNkZxNDNRWkNIQkhwVCtZVk83?=
 =?utf-8?B?YVcraUt6YloyK3B1WVA0YXJBemNaS09GSVl2b3IwdFdjTWsrZXRjNEF5RE9w?=
 =?utf-8?B?ZHZzWWJTMFNLcnJnVEJBTDM0SWJOVll0MjRTMkgyeWVDTTIwV2dtYkhRVHBI?=
 =?utf-8?B?QVVpNmtpV3JScGNvanFHWDZrQithUjBOaTBLVzN5WGE1bTNBcDlWOWpTSG5o?=
 =?utf-8?B?bngwWW1EajZTLzJoblFMMFR2RGNTNnlLY2dLbVM0RXVmSTRQejRCMlZsWHdN?=
 =?utf-8?B?Yitic3E4T1NINHJHNGxBRUlKcm0zcjB3cjVBZ0dUcjhpcHlQRHdCTWRjRWVy?=
 =?utf-8?B?OGVBNy93cTMzRlkvMXRkK3locmhHdnU1M1RjckpaOHVzUHNtTzhFSlB0ci9z?=
 =?utf-8?B?Qm5EWnM3ZWJWcEs1WVc4TTRpMFpQa3JWSkc2NGVwTzBjcUlzV09OazA5Qmt2?=
 =?utf-8?B?YzAvWENmVDZmemErM2cxNlRnS2laU2F1RnVGZm8yZU1rd0V3aE1wSFRLS3ZS?=
 =?utf-8?B?QnQ0N1VuOTFVbjgzWGw3TG1YSDZVNlk1alRMeThDYTJoNmtaUnJzVnpsK3ZT?=
 =?utf-8?B?WkE2My9nQ3UyK2J4c2RkNFB1VXg2YnRmSUlwMnlqOGNNdHVFeEN6TEEzaEto?=
 =?utf-8?B?SG83QVFpdzFnZFdva2FmTXRWc28xYm9XM1hkMUxSTXdMWkV5QnA0bVkyUXNk?=
 =?utf-8?B?U3BCYTFxZHR1MG5tc202WmtST0c1ZEJleGJXdE9RUEVqUWVISDR1a3lDeXk4?=
 =?utf-8?B?RG8wYXBXWEwxV0c0QTVHZGRYQjhBWllIVlNDZ0pqYkxWdG10N3R4YW9lNk9O?=
 =?utf-8?B?QTBHcHNnYXdpSGxKdTNCcGE3Yjluam9qSTJtMVcxZm9vaGNESFVmTzJhZjdi?=
 =?utf-8?B?N2kvN0RqSkxiU1EzNEh6QVdxU2FCMHlNL21XTzVSV2dtL3Z3SDRHYTFNWGts?=
 =?utf-8?B?WWF0TWkwVWFtb3BKbncyREhGbVp5RkhQYmZqV2JWeXB1UW9DRUtDT2NVdUVB?=
 =?utf-8?B?akl6U0NybkVlZTBxcFFHbElZL2lNc2ZacDVQb3Z0VHBaY2tOcWliUGljVDAv?=
 =?utf-8?B?MzlpbUs4QXBnaHdoRVVHY2tyL0s2eUkvT1hZNHdTUzJxMDhyYU82MjVqVlYz?=
 =?utf-8?B?bTJTSVdWeStrSHFjWC9MQndsZ0Q5amNrcG0vME9wM3d0bHBVaGpjZnBITmEv?=
 =?utf-8?B?UWUrR3NDdDJxZFIrd3EvQVMvcFlWWVFvMGZlLytGcTVESk1HZEcwSGZqcmpm?=
 =?utf-8?B?Q1ZTYlFhbEd1SFQ0NnJIUWkzdHhOd0lVNmpaQVY5ZjdPaW5UeUg0eG1qRUxT?=
 =?utf-8?B?TkMrdm5tdWZzMllURldOYnZjM2lPT1VNeVY2K3VlZnN6ZDdkT1BvVUVWSThr?=
 =?utf-8?B?dndxWUdMWk9UK2RLaXlsVHIyMjNMdHNuZEswQzJOd3VuMGRHTkJPVlFMYWNV?=
 =?utf-8?B?Yis1d1htQ0tkWkdXQ0E4c2lBcE1SdnRXdTZ2cS9BWU1BUVBrK2VjaHVoQmlp?=
 =?utf-8?B?Q0wzWkVUQXFFYXUrUXZkNi94aWpleUJ6VGIyak1mblg4eFJIbFcwWHVrM2ZJ?=
 =?utf-8?B?NFBheU9tRnNyTnFtR3RzZFY1Y1l3d0hxaXo1bmVhTmRXZmM4dkZYbFNYdGJn?=
 =?utf-8?B?UmJIdUMwZXUzVzVMYmhFcy9ZNmVOZ2ZBK2M0akdDMzVvNjFURGRxWmRmWHlE?=
 =?utf-8?B?NXYrQTdPNFhjMVBpT09NTUg2TVVYNE5nRU5IOTlUcmI4bmZ0cWZNcjBtSkdn?=
 =?utf-8?B?K3hLcXVRaC9GYVFnMDBZWFpoV2pWa0kwNVBZZC9GdHl3bHZJTGJDY2pBTlJN?=
 =?utf-8?B?bStSMVJmcFJRZ2s5Y3FHZ2JBaVFMM044OUczQVVnc1AzMzhyWUppU1N4c1lV?=
 =?utf-8?B?bk9HeWtKdjF0K0VuU29McUVWcUZKZTdFNnZIODlVQ3VacUE9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZS9Ncy9Tb1JBdEZLZVlmZU5IOUlBV0VXcGIyLzFWaW9QUmtBUElRYVRLSVE1?=
 =?utf-8?B?RTlqYzQ0eTRyUHFBa3RGMFp2VUw4ZTJoZjZhdWU3VlRxS0srU2NyZ1RUQWpx?=
 =?utf-8?B?Yk9qMXBvdXBIc1NUMExPTTdrOWNIVHVFVmNadXhNb1lXSnVLV3d3RVFUMFlq?=
 =?utf-8?B?eStvYmZMQ0dVSFFlYU91R084YlROeXdVcGFjZFcrejF3YjhBZ0JEVnNmSVkw?=
 =?utf-8?B?NCt3M3ZHaEEvekhQOTNsTUNBaFJya3JnSmdHL3JQUWhGY2ZaSlVZWTFYaHpq?=
 =?utf-8?B?bmxKam5uVXhlZ2xoV2tkc2ZkUDBDYllHRmo3TFBOYlBNSXI1M3VpVXljdkg4?=
 =?utf-8?B?OS9YR3ZFQys2WVhzOC9lckpPOTdrOXZGZTVZVENRdVRpMUQ1MXZlUTduMFpl?=
 =?utf-8?B?UGNPVnN2UDFzMzRqTDYxY2p1VVI5Q1lDaGlGell5ZEsyWndqcjZhVEphbUpL?=
 =?utf-8?B?RkZHVTU4NXBaRHNwWThibG1DRkhTcDVhZDFsYTRtV2lGTGFHUGZraVlaU3Mw?=
 =?utf-8?B?WGs4YnQvOVQyT3pwdlgwN1hCdmRZV1Ftdkg2TUVzRW44RVRxZnovZkJnWktr?=
 =?utf-8?B?bWhGV1cyVTZ6UzdzVlpKY0w5QTkvL1k0ZUhNLzFKenNLUXpTQUZ3aElVb2sy?=
 =?utf-8?B?ek9oVUNNMGIxejlkNmJMd0l1Vmk2RGxuUkRSdEkwQXRwa09nTlhtbVkxUjNX?=
 =?utf-8?B?UE9sV3BXS2Z0ODFzWVE0Zm0yS2J5ZFVleGhSRzd2bEd3anJBLzNJNFU5bGFm?=
 =?utf-8?B?RXhCc0hTSlVDWSsxc3JIRUNRZ0cwQTl6QTZNVTd0dXRZancrOXkrcFA2U1hI?=
 =?utf-8?B?OU9EbklCVTdhbVNONUE3ckNmN0ZPZG94clVEY2MxNU85bDF6MXRvYXpXMlNp?=
 =?utf-8?B?MzdlN1lIMVZKQUJoSldYTnBpcEp6UU11L3BlOGI2ejl6WHk3V2hEb0VXM3N3?=
 =?utf-8?B?R3ZjZDhzanBNYkJ0dk1TcjBkbTFZT1RXTWsyaXZJMjF0VVJhV1ptdUVSakNC?=
 =?utf-8?B?NWwycldWNUdOWkRKbG9Zd1Q1VnpOck1qNHFUTUtyYlJBZHZUZ0RndkNoL0Vz?=
 =?utf-8?B?RGtrYzZnL0pKa2Z0b0tST3QzWlh3VW8zRzdDSFBBWUE4UjVzV1RZeVFYSGYw?=
 =?utf-8?B?dU9YQ3lwZkp2bE1FbDA5ZVhyZUlVa3ltL1Vma0NsWitjN3QzeDFUTU95aXIy?=
 =?utf-8?B?YkdaMklPSnhITTROYmJ6TFQwRk9DaU5jYTBlam8zM2FtTThWNG1sY0JIVWxR?=
 =?utf-8?B?WjVOMnNJMzFHSFFpNExUQ3B4d2VZSUlEbkY4eVdoL3FwakV3Y0NQYU55d0N3?=
 =?utf-8?B?V2NuZTFCaHRVcnovUVZWK2x3U3NiZEMycTM4eFVRSUlMNFphK25YQnR0Unha?=
 =?utf-8?B?anZJc3BFUkw1a0RKYTFxM0x4alFDUVdIUUR3Y214NDlrQU1JaWxGenBkVkxr?=
 =?utf-8?B?SitWK3krT3J2M2NtQnRFam1zeUNQTVZGVkNTcTF3UHZkRkVTRTM4YTZZYVlk?=
 =?utf-8?B?eSsvblVLaEx4K1d4Qmdvd0FtVFpSTURUUndFM1VUQ2NiQ3lZb091ZVRWdFR0?=
 =?utf-8?B?dEJYU0VoOTg3aWc3Q1Yrb1BGYWI0NjZqSCtHVlpwRnJ0emU3ZTIrbUxpMU80?=
 =?utf-8?B?N2JNYkN2bEQ2Y0F4aytpd1EwMUpQWnQrRGVsdGY0eDVIT0tUeXk5SHJQN2xS?=
 =?utf-8?B?cVgybE1lbTF3YnBJRlBneEd6WEV3TTJycEZIc1NNREhuaWtnaTdtQXIweGtW?=
 =?utf-8?B?SUdZSHNJdWNUZXRMN3lPMi8yNzVEc0ttZklseVB6UFgwMVFYZEc3UDVrNkN0?=
 =?utf-8?B?ZE9LbWJtK2tscExtL2ZNNXBCRE52M0hTYUJ1MloweVYwVFprcVhNVXVkbGlB?=
 =?utf-8?B?WHUzQW9wS0wxZmlVQjZNbUlpU01BeTNoeDB5aFRoSmtEbTZySWV5TXBGOFJ3?=
 =?utf-8?B?dkZMSE9TblZObEkvYW1lZFdydXZiUnZPNmQ5QnNWejN6OTJFMk8wZldpNHJh?=
 =?utf-8?B?OFk0cWphUGdCR2JZUkRjYU5qYlpOZFhzY2xURmpPZWdiMklSWXNZcTArK1BL?=
 =?utf-8?B?TUlvaHNPNUs1T1NZN1UwZkdicTJCY0d0ZHVLakJhMVFXZHhBaHFwNEhQTitr?=
 =?utf-8?Q?y21JlxQmnFzWWDMaJhUQ0rpkf?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a75bd018-409d-4d66-7343-08dca610bf3e
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2024 03:30:03.7765 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: k77Xkrr7ahpWr/19HmYy/82aml89LdLrlok4SwD+o80sdMCjGI7n3oHYAr6UpvLSxjWS9kcqIcIINRInag3IiZFWVSEJTllgSyyKGtZG4SQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8764
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.21;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

SGkgTWljaGFlbCwgSmFzb24sDQoNCkJhc2VkIG9uIFlpJ3MgYW5hbHlzaXMsIGlzIGtlZXBpbmcg
Y3VycmVudCBWRVJTSU9OIHZhbHVlIGFjY2VwdGFibGUgZm9yIHlvdT8NCkxvb2sgZm9yd2FyZCB0
byB5b3VyIGNvbW1lbnRzLCBjdXJyZW50bHkgdGhpcyBvcGVuIGJsb2NrcyB1cyBmcm9tIHNlbmRp
bmcgdGhlIG5leHQgdmVyc2lvbi4NCg0KVGhhbmtzDQpaaGVuemhvbmcNCg0KPi0tLS0tT3JpZ2lu
YWwgTWVzc2FnZS0tLS0tDQo+RnJvbTogTGl1LCBZaSBMIDx5aS5sLmxpdUBpbnRlbC5jb20+DQo+
U3ViamVjdDogUmU6IFtQQVRDSF0gaW50ZWxfaW9tbXU6IFVzZSB0aGUgbGF0ZXN0IGZhdWx0IHJl
YXNvbnMgZGVmaW5lZCBieQ0KPnNwZWMNCj4NCj5IaSBNaWNoYWVsLCBKYXNvbiwNCj4NCj5PbiAy
MDI0LzUvMjggMTE6MDMsIEphc29uIFdhbmcgd3JvdGU6DQo+PiBPbiBNb24sIE1heSAyNywgMjAy
NCBhdCAyOjUw4oCvUE0gTWljaGFlbCBTLiBUc2lya2luIDxtc3RAcmVkaGF0LmNvbT4NCj53cm90
ZToNCj4+Pg0KPj4+IE9uIE1vbiwgTWF5IDI3LCAyMDI0IGF0IDA2OjQ0OjU4QU0gKzAwMDAsIER1
YW4sIFpoZW56aG9uZyB3cm90ZToNCj4+Pj4gSGkgSmFzb24sDQo+Pj4+DQo+Pj4+PiAtLS0tLU9y
aWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPj4+Pj4gRnJvbTogRHVhbiwgWmhlbnpob25nDQo+Pj4+PiBT
dWJqZWN0OiBSRTogW1BBVENIXSBpbnRlbF9pb21tdTogVXNlIHRoZSBsYXRlc3QgZmF1bHQgcmVh
c29ucyBkZWZpbmVkDQo+YnkNCj4+Pj4+IHNwZWMNCj4+Pj4+DQo+Pj4+Pg0KPj4+Pj4NCj4+Pj4+
PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPj4+Pj4+IEZyb206IEphc29uIFdhbmcgPGph
c293YW5nQHJlZGhhdC5jb20+DQo+Pj4+Pj4gU3ViamVjdDogUmU6IFtQQVRDSF0gaW50ZWxfaW9t
bXU6IFVzZSB0aGUgbGF0ZXN0IGZhdWx0IHJlYXNvbnMNCj5kZWZpbmVkIGJ5DQo+Pj4+Pj4gc3Bl
Yw0KPj4+Pj4+DQo+Pj4+Pj4gT24gRnJpLCBNYXkgMjQsIDIwMjQgYXQgNDo0MeKAr1BNIER1YW4s
IFpoZW56aG9uZw0KPj4+Pj4+IDx6aGVuemhvbmcuZHVhbkBpbnRlbC5jb20+IHdyb3RlOg0KPj4+
Pj4+Pg0KPj4+Pj4+Pg0KPj4+Pj4+Pg0KPj4+Pj4+Pj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0t
LS0NCj4+Pj4+Pj4+IEZyb206IEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+DQo+Pj4+
Pj4+PiBTdWJqZWN0OiBSZTogW1BBVENIXSBpbnRlbF9pb21tdTogVXNlIHRoZSBsYXRlc3QgZmF1
bHQgcmVhc29ucw0KPmRlZmluZWQNCj4+Pj4+IGJ5DQo+Pj4+Pj4+PiBzcGVjDQo+Pj4+Pj4+Pg0K
Pj4+Pj4+Pj4gT24gVHVlLCBNYXkgMjEsIDIwMjQgYXQgNjoyNeKAr1BNIER1YW4sIFpoZW56aG9u
Zw0KPj4+Pj4+Pj4gPHpoZW56aG9uZy5kdWFuQGludGVsLmNvbT4gd3JvdGU6DQo+Pj4+Pj4+Pj4N
Cj4+Pj4+Pj4+Pg0KPj4+Pj4+Pj4+DQo+Pj4+Pj4+Pj4+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0t
LS0tDQo+Pj4+Pj4+Pj4+IEZyb206IEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+DQo+
Pj4+Pj4+Pj4+IFN1YmplY3Q6IFJlOiBbUEFUQ0hdIGludGVsX2lvbW11OiBVc2UgdGhlIGxhdGVz
dCBmYXVsdCByZWFzb25zDQo+Pj4+PiBkZWZpbmVkDQo+Pj4+Pj4gYnkNCj4+Pj4+Pj4+Pj4gc3Bl
Yw0KPj4+Pj4+Pj4+Pg0KPj4+Pj4+Pj4+PiBPbiBNb24sIE1heSAyMCwgMjAyNCBhdCAxMjoxNeKA
r1BNIExpdSwgWWkgTCA8eWkubC5saXVAaW50ZWwuY29tPg0KPj4+Pj4+IHdyb3RlOg0KPj4+Pj4+
Pj4+Pj4NCj4+Pj4+Pj4+Pj4+PiBGcm9tOiBEdWFuLCBaaGVuemhvbmcgPHpoZW56aG9uZy5kdWFu
QGludGVsLmNvbT4NCj4+Pj4+Pj4+Pj4+PiBTZW50OiBNb25kYXksIE1heSAyMCwgMjAyNCAxMTo0
MSBBTQ0KPj4+Pj4+Pj4+Pj4+DQo+Pj4+Pj4+Pj4+Pj4NCj4+Pj4+Pj4+Pj4+Pg0KPj4+Pj4+Pj4+
Pj4+PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPj4+Pj4+Pj4+Pj4+PiBGcm9tOiBKYXNv
biBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPg0KPj4+Pj4+Pj4+Pj4+PiBTZW50OiBNb25kYXks
IE1heSAyMCwgMjAyNCA4OjQ0IEFNDQo+Pj4+Pj4+Pj4+Pj4+IFRvOiBEdWFuLCBaaGVuemhvbmcg
PHpoZW56aG9uZy5kdWFuQGludGVsLmNvbT4NCj4+Pj4+Pj4+Pj4+Pj4gQ2M6IHFlbXUtZGV2ZWxA
bm9uZ251Lm9yZzsgTGl1LCBZaSBMIDx5aS5sLmxpdUBpbnRlbC5jb20+Ow0KPlBlbmcsDQo+Pj4+
Pj4+PiBDaGFvDQo+Pj4+Pj4+Pj4+IFANCj4+Pj4+Pj4+Pj4+Pj4gPGNoYW8ucC5wZW5nQGludGVs
LmNvbT47IFl1IFpoYW5nDQo+Pj4+Pj4gPHl1LmMuemhhbmdAbGludXguaW50ZWwuY29tPjsNCj4+
Pj4+Pj4+Pj4gTWljaGFlbA0KPj4+Pj4+Pj4+Pj4+PiBTLiBUc2lya2luIDxtc3RAcmVkaGF0LmNv
bT47IFBhb2xvIEJvbnppbmkNCj4+Pj4+Pj4+IDxwYm9uemluaUByZWRoYXQuY29tPjsNCj4+Pj4+
Pj4+Pj4+Pj4gUmljaGFyZCBIZW5kZXJzb24gPHJpY2hhcmQuaGVuZGVyc29uQGxpbmFyby5vcmc+
Ow0KPkVkdWFyZG8NCj4+Pj4+Pj4+IEhhYmtvc3QNCj4+Pj4+Pj4+Pj4+Pj4gPGVkdWFyZG9AaGFi
a29zdC5uZXQ+OyBNYXJjZWwgQXBmZWxiYXVtDQo+Pj4+Pj4+Pj4+IDxtYXJjZWwuYXBmZWxiYXVt
QGdtYWlsLmNvbT4NCj4+Pj4+Pj4+Pj4+Pj4gU3ViamVjdDogUmU6IFtQQVRDSF0gaW50ZWxfaW9t
bXU6IFVzZSB0aGUgbGF0ZXN0IGZhdWx0DQo+cmVhc29ucw0KPj4+Pj4+Pj4gZGVmaW5lZA0KPj4+
Pj4+Pj4+PiBieQ0KPj4+Pj4+Pj4+Pj4+PiBzcGVjDQo+Pj4+Pj4+Pj4+Pj4+DQo+Pj4+Pj4+Pj4+
Pj4+IE9uIEZyaSwgTWF5IDE3LCAyMDI0IGF0IDY6MjbigK9QTSBaaGVuemhvbmcgRHVhbg0KPj4+
Pj4+Pj4+Pj4+PiA8emhlbnpob25nLmR1YW5AaW50ZWwuY29tPiB3cm90ZToNCj4+Pj4+Pj4+Pj4+
Pj4+DQo+Pj4+Pj4+Pj4+Pj4+PiBGcm9tOiBZdSBaaGFuZyA8eXUuYy56aGFuZ0BsaW51eC5pbnRl
bC5jb20+DQo+Pj4+Pj4+Pj4+Pj4+Pg0KPj4+Pj4+Pj4+Pj4+Pj4gQ3VycmVudGx5IHdlIHVzZSBv
bmx5IFZURF9GUl9QQVNJRF9UQUJMRV9JTlYgYXMgZmF1bHQNCj4+Pj4+PiByZWFzb24uDQo+Pj4+
Pj4+Pj4+Pj4+PiBVcGRhdGUgd2l0aCBtb3JlIGRldGFpbGVkIGZhdWx0IHJlYXNvbnMgbGlzdGVk
IGluIFZULWQgc3BlYw0KPj4+Pj4+IDcuMi4zLg0KPj4+Pj4+Pj4+Pj4+Pj4NCj4+Pj4+Pj4+Pj4+
Pj4+IFNpZ25lZC1vZmYtYnk6IFl1IFpoYW5nIDx5dS5jLnpoYW5nQGxpbnV4LmludGVsLmNvbT4N
Cj4+Pj4+Pj4+Pj4+Pj4+IFNpZ25lZC1vZmYtYnk6IFpoZW56aG9uZyBEdWFuDQo+PHpoZW56aG9u
Zy5kdWFuQGludGVsLmNvbT4NCj4+Pj4+Pj4+Pj4+Pj4+IC0tLQ0KPj4+Pj4+Pj4+Pj4+Pg0KPj4+
Pj4+Pj4+Pj4+PiBJIHdvbmRlciBpZiB0aGlzIGNvdWxkIGJlIG5vdGljZWQgYnkgdGhlIGd1ZXN0
IG9yIG5vdC4gSWYgeWVzDQo+Pj4+PiBzaG91bGQNCj4+Pj4+Pj4+Pj4+Pj4gd2UgY29uc2lkZXIg
c3RhcnRpbmcgdG8gYWRkIHRoaW5nIGxpa2UgdmVyc2lvbiB0byB2dGQNCj5lbXVsYXRpb24NCj4+
Pj4+PiBjb2RlPw0KPj4+Pj4+Pj4+Pj4+DQo+Pj4+Pj4+Pj4+Pj4gS2VybmVsIG9ubHkgZHVtcHMg
dGhlIHJlYXNvbiBsaWtlIGJlbG93Og0KPj4+Pj4+Pj4+Pj4+DQo+Pj4+Pj4+Pj4+Pj4gRE1BUjog
W0RNQSBXcml0ZSBOT19QQVNJRF0gUmVxdWVzdCBkZXZpY2UgWzIwOjAwLjBdIGZhdWx0DQo+Pj4+
PiBhZGRyDQo+Pj4+Pj4+Pj4+IDB4MTIzNDYwMDAwMA0KPj4+Pj4+Pj4+Pj4+IFtmYXVsdCByZWFz
b24gMHg3MV0gU006IFByZXNlbnQgYml0IGluIGZpcnN0LWxldmVsIHBhZ2luZyBlbnRyeQ0KPmlz
DQo+Pj4+Pj4gY2xlYXINCj4+Pj4+Pj4+Pj4+DQo+Pj4+Pj4+Pj4+PiBZZXMsIGd1ZXN0IGtlcm5l
bCB3b3VsZCBub3RpY2UgaXQgYXMgdGhlIGZhdWx0IHdvdWxkIGJlIGluamVjdGVkDQo+dG8NCj4+
Pj4+IHZtLg0KPj4+Pj4+Pj4+Pj4NCj4+Pj4+Pj4+Pj4+PiBNYXliZSBidW1wIDEuMCAtPiAxLjE/
DQo+Pj4+Pj4+Pj4+Pj4gTXkgdW5kZXJzdGFuZGluZyB2ZXJzaW9uIG51bWJlciBpcyBvbmx5IGlu
Zm9ybWF0aW9uYWwgYW5kDQo+aXMNCj4+Pj4+IGZhcg0KPj4+Pj4+Pj4gZnJvbQ0KPj4+Pj4+Pj4+
Pj4+IGFjY3VyYXRlIHRvIG1hcmsgaWYgYSBmZWF0dXJlIHN1cHBvcnRlZC4gRHJpdmVyIHNob3Vs
ZCBjaGVjaw0KPj4+Pj4+IGNhcC9lY2FwDQo+Pj4+Pj4+Pj4+Pj4gYml0cyBpbnN0ZWFkLg0KPj4+
Pj4+Pj4+Pj4NCj4+Pj4+Pj4+Pj4+IFNob3VsZCB0aGUgdmVyc2lvbiBJRCBoZXJlIGJlIGFsaWdu
ZWQgd2l0aCBWVC1kIHNwZWM/DQo+Pj4+Pj4+Pj4+DQo+Pj4+Pj4+Pj4+IFByb2JhYmx5LCB0aGlz
IG1pZ2h0IGJlIHNvbWV0aGluZyB0aGF0IGNvdWxkIGJlIG5vdGljZWQgYnkgdGhlDQo+Pj4+Pj4+
Pj4+IG1hbmFnZW1lbnQgdG8gbWlncmF0aW9uIGNvbXBhdGliaWxpdHkuDQo+Pj4+Pj4+Pj4NCj4+
Pj4+Pj4+PiBDb3VsZCB5b3UgZWxhYm9yYXRlIHdoYXQgd2UgbmVlZCB0byBkbyBmb3IgbWlncmF0
aW9uDQo+Y29tcGF0aWJpbGl0eT8NCj4+Pj4+Pj4+PiBJIHNlZSB2ZXJzaW9uIGlzIGFscmVhZHkg
ZXhwb3J0ZWQgc28gbGlidmlydCBjYW4gcXVlcnkgaXQsIHNlZToNCj4+Pj4+Pj4+Pg0KPj4+Pj4+
Pj4+ICAgICAgREVGSU5FX1BST1BfVUlOVDMyKCJ2ZXJzaW9uIiwgSW50ZWxJT01NVVN0YXRlLCB2
ZXJzaW9uLCAwKSwNCj4+Pj4+Pj4+DQo+Pj4+Pj4+PiBJdCBpcyB0aGUgUWVtdSBjb21tYW5kIGxp
bmUgcGFyYW1ldGVycyBub3QgdGhlIHZlcnNpb24gb2YgdGhlDQo+dm1zdGF0ZS4NCj4+Pj4+Pj4+
DQo+Pj4+Pj4+PiBGb3IgZXhhbXBsZSAtZGV2aWNlIGludGVsLWlvbW11LHZlcnNpb249My4wDQo+
Pj4+Pj4+Pg0KPj4+Pj4+Pj4gUWVtdSB0aGVuIGtub3dzIGl0IHNob3VsZCBiZWhhdmUgYXMgMy4w
Lg0KPj4+Pj4+Pg0KPj4+Pj4+PiBTbyB5b3Ugd2FudCB0byBidW1wIHZ0ZF92bXN0YXRlLnZlcnNp
b24/DQo+Pj4+Pj4NCj4+Pj4+PiBXZWxsLCBhcyBJIHNhaWQsIGl0J3Mgbm90IGEgZGlyZWN0IGJ1
bXBpbmcuDQo+Pj4+Pj4NCj4+Pj4+Pj4NCj4+Pj4+Pj4gSW4gZmFjdCwgdGhpcyBzZXJpZXMgY2hh
bmdlIGludGVsX2lvbW11IHByb3BlcnR5IGZyb20geC1zY2FsYWJsZS0NCj4+Pj4+PiBtb2RlPVsi
b24ifCJvZmYiXSINCj4+Pj4+Pj4gdG8geC1zY2FsYWJsZS1tb2RlPVsibGVnYWN5InwibW9kZXJu
Inwib2ZmIl0iLg0KPj4+Pj4+Pg0KPj4+Pj4+PiBNeSB1bmRlcnN0YW5kaW5nIG1hbmFnZW1lbnQg
YXBwIHNob3VsZCB1c2Ugc2FtZSBxZW11IGNtZGxpbmUNCj4+Pj4+Pj4gaW4gc291cmNlIGFuZCBk
ZXN0aW5hdGlvbiwgc28gY29tcGF0aWJpbGl0eSBpcyBhbHJlYWR5IGd1YXJhbnRlZWQNCj5ldmVu
IGlmDQo+Pj4+Pj4+IHdlIGRvbid0IGJ1bXAgdnRkX3Ztc3RhdGUudmVyc2lvbi4NCj4+Pj4+Pg0K
Pj4+Pj4+IEV4YWN0bHksIHNvIHRoZSBwb2ludCBpcyB0bw0KPj4+Pj4+DQo+Pj4+Pj4gdnRkPTMu
MCwgdGhlIGRldmljZSB3b3JrcyBleGFjdGx5IGFzIHZ0ZCBzcGVjIDMuMC4NCj4+Pj4+PiB2dGQ9
My4zLCB0aGUgZGV2aWNlIHdvcmtzIGV4YWN0bHkgYXMgdnRkIHNwZWMgMy4zLg0KPj4+Pg0KPj4+
PiBZaSBqdXN0IGZvdW5kIHZlcnNpb24gSUQgc3RvcmVkIGluIFZULWQgVkVSX1JFRyBpcyBub3Qg
YWxpZ25lZCB3aXRoIHRoZQ0KPlZULWQgc3BlYyB2ZXJzaW9uLg0KPj4+PiBGb3IgZXhhbXBsZSwg
d2Ugc2VlIGEgbG9jYWwgaHcgd2l0aCB2dGQgdmVyc2lvbiA2LjAgd2hpY2ggaXMgYmV5b25kIFZU
LQ0KPmQgc3BlYyB2ZXJzaW9uLg0KPj4+PiBXZSBhcmUgYXNraW5nIFZURCBhcmNoLCB3aWxsIGdl
dCBiYWNrIHNvb24uDQo+Pj4+DQo+Pj4+IE9yIHdpbGwgeW91IHBsYW4gcWVtdSB2VlQtZCBoYXZp
bmcgaXRzIG93biB2ZXJzaW9uIHBvbGljeT8NCj4+Pj4NCj4+Pj4gVGhhbmtzDQo+Pj4+IFpoZW56
aG9uZw0KPj4+DQo+Pj4gTm90IHVubGVzcyB0aGVyZSdzIGEgZ29vZCByZWFzb24gdG8gZG8gdGhp
cy4NCj4+DQo+PiArMQ0KPg0KPkhhZCBtb3JlIHN0dWR5aW5nIGluIHRoZSBzcGVjLiBCdW1waW5n
IHVwIHRvIDMuMCBtaWdodCBub3QgYmUgdHJpdmlhbC4gOigNCj4NCj5UaGUgVlQtZCBzcGVjIGhh
cyBzb21lIHJlcXVpcmVtZW50cyBiYXNlZCBvbiB0aGUgdmVyc2lvbiBudW1iZXIuIEJlbG93DQo+
aXMgYQ0KPmxpc3Qgb2YgaXQuIEFsdGhvdWdoIHRoZXkgYXJlIGRlZmluZWQgZm9yIGhhcmR3YXJl
LCBidXQgdlZULWQgbWF5IG5lZWQgdG8NCj5yZXNwZWN0IGl0IGFzIHRoZSBzYW1lIGlvbW11IGRy
aXZlciBydW5zIGZvciBib3RoIHRoZSB2VlQtZCBhbmQgdGhlIGh3DQo+VlQtZC4gUGVyIDEpLCBp
ZiBidW1waW5nIHVwIHRoZSBtYWpvciB2YWx1ZSB0byBiZSA2IG9yIGhpZ2hlciwgdGhlIHZWVC1k
DQo+bmVlZHMgdG8gZW5zdXJlIHRoZSByZWdpc3Rlci1iYXNlZCBpbnZhbGlkYXRpb24gaW50ZXJm
YWNlIGlzIG5vdCBhdmFpbGFibGUuDQo+UGVyIDIpLCBpZiBidW1wIHVwIHRoZSBtYWpvciB2ZXJz
aW9uIHRvIGJlIDIgb3IgaGlnaGVyLCB0aGUgdlZULWQgbmVlZHMgdG8NCj5ieSBkZWZhdWx0IGRy
YWluIHdyaXRlIGFuZCByZWFkIHJlcXVlc3RzIG5vIG1hdHRlciB0aGUgc29mdHdhcmUgcmVxdWVz
dHMgaXQNCj5vciBub3QuDQo+DQo+MSkgQ2hhcHRlciA2LjUgSW52YWxpZGF0aW9uIG9mIFRyYW5z
bGF0aW9uIENhY2hlcw0KPg0KPkZvciBzb2Z0d2FyZSB0byBpbnZhbGlkYXRlIHRoZSB2YXJpb3Vz
IGNhY2hpbmcgc3RydWN0dXJlcywgdGhlIGFyY2hpdGVjdHVyZQ0KPnN1cHBvcnRzIHRoZSBmb2xs
b3dpbmcgdHdvDQo+dHlwZXMgb2YgaW52YWxpZGF0aW9uIGludGVyZmFjZXM6DQo+4oCiIFJlZ2lz
dGVyLWJhc2VkIGludmFsaWRhdGlvbiBpbnRlcmZhY2U6IEEgbGVnYWN5IGludmFsaWRhdGlvbiBp
bnRlcmZhY2UNCj53aXRoIGxpbWl0ZWQgY2FwYWJpbGl0aWVzLg0KPlRoaXMgaW50ZXJmYWNlIGlz
IHN1cHBvcnRlZCBieSBoYXJkd2FyZSBpbXBsZW1lbnRhdGlvbnMgb2YgdGhpcw0KPmFyY2hpdGVj
dHVyZSB3aXRoIE1ham9yIFZlcnNpb24gNQ0KPm9yIGxvd2VyIChWRVJfUkVHKS4gSW4gYWxsIG90
aGVyIGhhcmR3YXJlIGltcGxlbWVudGF0aW9ucywgYWxsIHJlcXVlc3RzIGFyZQ0KPnRyZWF0ZWQg
YXMgaW52YWxpZA0KPnJlcXVlc3RzIGFuZCB3aWxsIGJlIGlnbm9yZWQgKGZvciBkZXRhaWxzIHNl
ZSB0aGUgQ0FJRyBmaWVsZCBpbiB0aGUgQ29udGV4dA0KPkNvbW1hbmQgUmVnaXN0ZXIgYW5kDQo+
dGhlIElBSUcgZmllbGQgaW4gdGhlIElPVExCIEludmFsaWRhdGUgUmVnaXN0ZXIpLg0KPg0KPjIp
IENoYXB0ZXIgNi41LjIuMyBJT1RMQiBJbnZhbGlkYXRlDQo+4oCiIERyYWluIFJlYWRzIChEUik6
IFNvZnR3YXJlIHNldHMgdGhpcyBmbGFnIHRvIGluZGljYXRlIGhhcmR3YXJlIG11c3QgZHJhaW4N
Cj5yZWFkIHJlcXVlc3RzIHRoYXQgYXJlDQo+YWxyZWFkeSBwcm9jZXNzZWQgYnkgdGhlIHJlbWFw
cGluZyBoYXJkd2FyZSwgYnV0IHF1ZXVlZCB3aXRoaW4gdGhlDQo+Um9vdC1Db21wbGV4IHRvIGJl
DQo+Y29tcGxldGVkLiBXaGVuIHRoZSB2YWx1ZSBvZiB0aGlzIGZsYWcgaXMgMSwgaGFyZHdhcmUg
bXVzdCBkcmFpbiB0aGUNCj5yZWxldmFudCByZWFkcyBiZWZvcmUgdGhlDQo+bmV4dCBJbnZhbGlk
YXRpb24gV2FpdCBEZXNjcmlwdG9yIChzZWUgU2VjdGlvbiA2LjUuMi44KSBpcyBjb21wbGV0ZWQu
DQo+U2VjdGlvbiA2LjUuNCBkZXNjcmliZXMNCj5oYXJkd2FyZSBzdXBwb3J0IGZvciBkcmFpbmlu
Zy4gSGFyZHdhcmUgaW1wbGVtZW50YXRpb25zIHdpdGggTWFqb3INCj5WZXJzaW9uDQo+MiBvciBo
aWdoZXINCj4oVkVSX1JFRykgd2lsbCBpZ25vcmUgdGhpcyBmbGFnIGFuZCBhbHdheXMgZHJhaW4g
cmVsZXZhbnQgcmVhZHMgYmVmb3JlIHRoZQ0KPm5leHQgSW52YWxpZGF0aW9uIFdhaXQNCj5EZXNj
cmlwdG9yIGlzIGNvbXBsZXRlZC4NCj7igKIgRHJhaW4gV3JpdGVzIChEVyk6IFNvZnR3YXJlIHNl
dHMgdGhpcyBmbGFnIHRvIGluZGljYXRlIGhhcmR3YXJlIG11c3QNCj5kcmFpbiByZWxldmFudCB3
cml0ZQ0KPnJlcXVlc3RzIHRoYXQgYXJlIGFscmVhZHkgcHJvY2Vzc2VkIGJ5IHRoZSByZW1hcHBp
bmcgaGFyZHdhcmUsIGJ1dCBxdWV1ZWQNCj53aXRoaW4gdGhlIFJvb3RDb21wbGV4IHRvIGJlIGNv
bXBsZXRlZC4gV2hlbiB0aGUgdmFsdWUgb2YgdGhpcyBmbGFnIGlzIDEsDQo+aGFyZHdhcmUgbXVz
dCBkcmFpbiB0aGUgcmVsZXZhbnQNCj53cml0ZXMgYmVmb3JlIHRoZSBuZXh0IEludmFsaWRhdGlv
biBXYWl0IERlc2NyaXB0b3IgaXMgY29tcGxldGVkLiBTZWN0aW9uDQo+Ni41LjQgZGVzY3JpYmVz
DQo+aGFyZHdhcmUgc3VwcG9ydCBmb3IgZHJhaW5pbmcuIEhhcmR3YXJlIGltcGxlbWVudGF0aW9u
cyB3aXRoIE1ham9yDQo+VmVyc2lvbg0KPjIgb3IgaGlnaGVyDQo+KFZFUl9SRUcpIHdpbGwgaWdu
b3JlIHRoaXMgZmxhZyBhbmQgYWx3YXlzIGRyYWluIHJlbGV2YW50IHdyaXRlcyBiZWZvcmUgdGhl
DQo+bmV4dCBJbnZhbGlkYXRpb24gV2FpdA0KPkRlc2NyaXB0b3IgaXMgY29tcGxldGVkLg0KPg0K
PjMpIENoYXB0ZXIgMTEuNC4yIENhcGFiaWxpdHkgUmVnaXN0ZXINCj5IYXJkd2FyZSBpbXBsZW1l
bnRhdGlvbnMgd2l0aCBNYWpvciBWZXJzaW9uIDYgb3IgaGlnaGVyDQo+KFZFUl9SRUcpIHJlcG9y
dGluZyB0aGUgc2Vjb25kLXN0YWdlIHRyYW5zbGF0aW9uIHN1cHBvcnQgKFNTVFMpDQo+ZmllbGQg
YXMgQ2xlYXIgYWxzbyByZXBvcnQgdGhpcyBmaWVsZCBhcyAwLg0KPg0KPjQpIENoYXB0ZXIgMTEu
NC44LjEgUHJvdGVjdGVkIE1lbW9yeSBFbmFibGUgUmVnaXN0ZXINCj7igKIgSGFyZHdhcmUgaW1w
bGVtZW50YXRpb25zIHdpdGggTWFqb3IgVmVyc2lvbiAyIG9yIGhpZ2hlcg0KPihWRVJfUkVHKSBi
bG9jayBhbGwgRE1BIHJlcXVlc3RzIGFjY2Vzc2luZyBwcm90ZWN0ZWQNCj5tZW1vcnkgcmVnaW9u
cyB3aGV0aGVyIG9yIG5vdCBETUEgcmVtYXBwaW5nIGlzDQo+ZW5hYmxlZC4NCj4NCj5BbHNvLCBh
cyByZXBsaWVkIGluIHRoZSBwcmlvciBlbWFpbCwgdGhlIFZULWQgYXJjaGl0ZWN0dXJlIHJlcG9y
dHMNCj5jYXBhYmlsaXR5IHZpYSB0aGUgY2FwL2VjYXAgcmVnaXN0ZXJzLiBUaGUgbmV3IGZhdWx0
IHJlYXNvbnMgaW4gdGhpcw0KPnBhdGNoIGlzIG1lYW5pbmdmdWwgb25seSB3aGVuIHRoZSBlY2Fw
LlNNVFMgYml0IGlzIHNldC4gU28gYnVtcGluZyB2ZXJzaW9uDQo+ZG9lcyBub3QgbWVhbiB0b28g
bXVjaCBhYm91dCB0aGUgaW50cm9kdWN0aW9uIG9mIG5ldyBjYXBhYmlsaXRpZXMuIEBKYXNvbiwN
Cj5naXZlbiB0aGUgYWJvdmUgc3RhdGVtZW50cywgY2FuIHdlIHJlY29uc2lkZXIgaWYgaXQgaXMg
bmVjZXNzYXJ5IHRvIGJ1bXANCj51cCB0aGUgdmVyc2lvbiBudW1iZXI/DQo+DQo+LS0NCj5SZWdh
cmRzLA0KPllpIExpdQ0K

