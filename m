Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 449C0C25B74
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2024 08:42:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sAQU4-0003vb-Fr; Fri, 24 May 2024 04:41:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sAQU2-0003vH-Lh
 for qemu-devel@nongnu.org; Fri, 24 May 2024 04:41:02 -0400
Received: from mgamail.intel.com ([192.198.163.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sAQTz-0006YO-IZ
 for qemu-devel@nongnu.org; Fri, 24 May 2024 04:41:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1716540059; x=1748076059;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=20KcmIDDRVTqTdZrLYThIW2EdTJ46u91UjYEFTXuh4A=;
 b=bP0yeeZAip6qkyWnF2RHMuvmLZTZPlgXn6BoiA38r6nMyEduP/NvuYZb
 zv+DD+pg4nyt75S7VHCLN6Ylsaoa/IudhmbM+KziiydV+n/H8MN3pV7Bm
 57tPLfnSX2xfjjfjsnyvjiihf9CBU6t+SNDPg1zjp/CusrRUf1MriAGoZ
 GqfPTn7M6WTWgmPOsdA89s8OmkgZiANmUeeoP8iEf9tZjjBCcwxjn5CiI
 kU6gxDM4nHS7Dkn163PK0AY0IeKC4DNUEIgYegPYvLjiZ9lU1CLkquwB4
 FR8sczPsSgJwexglrhEONGHRQsOF01mE+tScXAyDqPx9lLs9j0syVe1LW A==;
X-CSE-ConnectionGUID: IxT2uF63QaiF8fm0C+mBfA==
X-CSE-MsgGUID: sKYQeBiyRkCUVVotP8HP2Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11081"; a="23516234"
X-IronPort-AV: E=Sophos;i="6.08,184,1712646000"; d="scan'208";a="23516234"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 May 2024 01:40:55 -0700
X-CSE-ConnectionGUID: 0HUAwxdMTC6v6TdrjZa/0w==
X-CSE-MsgGUID: a6FjIaFJRTGN/76nxNgy4w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,184,1712646000"; d="scan'208";a="34062681"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
 by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 24 May 2024 01:40:55 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 24 May 2024 01:40:54 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 24 May 2024 01:40:54 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 24 May 2024 01:40:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AxdAUaQ9Z/iMV8yjWD4VHdl3+7bwt9B3x1vdq8lmfJkZXH1NnZi0/OBVv2dQEq9iuk7xz/i6O/tJo7v6dFXQraDl69AzeMfLSu8yzCXF1IhyRsvZ1ZEsKwdd9HJL7nSIg8CKEO7JioxE4frrGP23UgAcHj9v/okFFPnfFSM78Pog+64oK26zwwN8KYcbOXl+OLDP4sBaIfaFh6+nZMc540A2zg33zHSfPAmQtA8HEYj5JP5by69fgUi9wgbkSKk4f7Dz9eFtc2lb/S7Y0eJB/K6yFypAtWOdwbr4PwhEiM0boZnclx2pWLhmFSuNW4HNS+Ru5Hx0GubyPMKl1VA8Xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=20KcmIDDRVTqTdZrLYThIW2EdTJ46u91UjYEFTXuh4A=;
 b=V5iMuF3n+gyVgrhPeGTXuNZX/NwXTXm/XglOvDeowPeYydF6BhrqR+2ZZKLl2jsqa9JECGCELGreSbyfwspBQKcQV+Js1MwWy++zQzF1/BBcq+Av5j/NBA2C5plpTmJ7vjKdwCUFJA37w4P7f7p+iHjXFNF1Rwq2LQAYgPp2sp88sjOtO0yxzD1bg78ms6+/01c+HRuociFEqk1mWLAyVIsChoPjZz81yQnls+X9ok/yEzjKjYajpxy/PtPQ/9k0jXdBFCVxvFGj6KZHDGaMylywsalQn33P2X58R665PjeyOoZ9ABsFHJGg2s3OrWNE+rXHVtRMHvNkDhGdSqUQcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by MN2PR11MB4631.namprd11.prod.outlook.com (2603:10b6:208:262::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.22; Fri, 24 May
 2024 08:40:53 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091%7]) with mapi id 15.20.7611.016; Fri, 24 May 2024
 08:40:52 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: Jason Wang <jasowang@redhat.com>
CC: "Liu, Yi L" <yi.l.liu@intel.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "Peng, Chao P" <chao.p.peng@intel.com>, Yu Zhang
 <yu.c.zhang@linux.intel.com>, "Michael S. Tsirkin" <mst@redhat.com>, "Paolo
 Bonzini" <pbonzini@redhat.com>, Richard Henderson
 <richard.henderson@linaro.org>, Eduardo Habkost <eduardo@habkost.net>, Marcel
 Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: RE: [PATCH] intel_iommu: Use the latest fault reasons defined by spec
Thread-Topic: [PATCH] intel_iommu: Use the latest fault reasons defined by spec
Thread-Index: AQHaqESnRiGl1jiq20uiRV0AFydhKrGfTQkAgAAs2mCAAA5PgIABefcAgAB9i4CAAW9wgIADKlPw
Date: Fri, 24 May 2024 08:40:52 +0000
Message-ID: <SJ0PR11MB67445F7F8B79D2C2B982C1F692F52@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20240517102334.81943-1-zhenzhong.duan@intel.com>
 <CACGkMEvTomFeC1bM3SfY1zGhQ_5i15r6CY6M3jVzau6niNUf_w@mail.gmail.com>
 <SJ0PR11MB6744AECEAA6F9319259B0DF192E92@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <DS0PR11MB752917B52B66A6EF10C10678C3E92@DS0PR11MB7529.namprd11.prod.outlook.com>
 <CACGkMEt5ofYt12A6uKUj=QLcLbOnrGT=UkMpee=MUxO6Xy3sxg@mail.gmail.com>
 <SJ0PR11MB6744C340AAB1B786D3913F5D92EA2@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <CACGkMEsV05ujKNEL9JSAsfikWGW582yvfSOdHJgRxZC_1cxgEg@mail.gmail.com>
In-Reply-To: <CACGkMEsV05ujKNEL9JSAsfikWGW582yvfSOdHJgRxZC_1cxgEg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|MN2PR11MB4631:EE_
x-ms-office365-filtering-correlation-id: 1410172b-5e69-4b91-7af8-08dc7bcd38b2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|1800799015|376005|366007|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?ME5qTUVJZzRWbmp3bmZuNllUcUVrcEtVRm5Va2duQkg4ejNndHo4L2NQYnBP?=
 =?utf-8?B?dGR3ZzFpNHFOYkEwcXBDcG5Rd3VWQmVHa3JNZURuR3Myd1Q1ZC9QZGprU2Rn?=
 =?utf-8?B?dTBTbzZjRUJzUFRRUXBralFvc29HbW1XcER5U09oY3hMRTJ6eWEzNkFEdzBl?=
 =?utf-8?B?MHZvNktqQlBBcWhhS3hXbFRTN0tXSVg0ajlFOC9Zd0xqNHhkZGpsSjVkU3dK?=
 =?utf-8?B?QWdOcjF5YUxDcGloL09HVkh1dis0dzhVRTlIaUNma05UcStMOG5ITHpxbG9Y?=
 =?utf-8?B?MWNzSnVBZlpuOUNlWVh6QzFya3h3bFY3OG1uaDFwZmxOS3ZWYVA4TlhRR0Fi?=
 =?utf-8?B?UHo2U0h0czZzMHJHangxTE01WHNJSVFBeGxyZk12eXJQdDY2RnUyY0Z1REZQ?=
 =?utf-8?B?T0djU2x3Q09PbSs4N3hCNy9KK21jaWphdlJhLzZJV2lHK3ZvWVlEMXVrYTR0?=
 =?utf-8?B?bElJbkozMXJCdWxXY0d1MUhwTUhYU2MrckE4Umw5cFNnZ1BGdXJROHF5aFdQ?=
 =?utf-8?B?V0s0YTM5VldxU3hPRjhweG9wbVlsYy9tTTlmZncrVGRpMFlia2ZxWEExYUxD?=
 =?utf-8?B?UXlJTUFSYkozT0FybFdjd1VxYkZyMnZQT055QjFLdEdaVGdScmhackZZNDJQ?=
 =?utf-8?B?cW1OQ0haM3ZvNlF0ZjdWUkxoMlBJWTUzbjNmME1CajBheE51dG5BbVozL0tB?=
 =?utf-8?B?aE05VFUzellLQnJSa0JPeXRMck1wUlpIK3RQL0E3dHUrVmFVVzdHWjlYQjgz?=
 =?utf-8?B?MDhmdXhLRDdENnpYOU5uZE5aT0kvL1dwVFdpMHRETE9aVENtVGEydFZubG9S?=
 =?utf-8?B?dzEwRG1DK0FrVGE4OXZXS2ZzaG9iYmhFdGxNcW5uTnVkNFB0V2VoSkhZcnpj?=
 =?utf-8?B?djgzSkJuSHV5Rno2dmlBcldIU0MwSWxVNU1jWkV6WjhXZ3FkZmdzc1kwQ3E2?=
 =?utf-8?B?Q09UZkkrNEs5NUlxVStYdUhJVmVsd1dDaHBNYXlDc1BWNEdsY001Nm9NSVE1?=
 =?utf-8?B?ZXlBTUV1ZXEzRzY5TXgxeTJYM0RHVWIyeG5YQXRUN3VROWwvYk52Yk1nQkN3?=
 =?utf-8?B?NGRoKzlWL3BIVGxldzhkQm1UZzRDR1hJalpYV2o1QzQyZ0RpcUFRTmlyR3la?=
 =?utf-8?B?QVEyLzhJNTA5U3oySFpkYXBVRlZ6OUsvTEhNcWhvOVRSZHhKcjdCUkxmY0NY?=
 =?utf-8?B?cFQxdkk1a3Z5eGwvMDdrQVBoV2hEOW9TSHcvWHZsSjFvYlN5UkczQUw0QmZS?=
 =?utf-8?B?UVk0b2ZjQ2ZwQnREQWlPWjB4RXVXdklTWm02Z1ZvV0ZoSzIxNzB1bDF5aExy?=
 =?utf-8?B?ZTVlUkNNclNxYzE0aHpzdmtZRW4ySGNTWHFmRHhzRVROcFVINmtxRVo0Rmxu?=
 =?utf-8?B?a1lwUXBNb0NwMFVRY3VVSm93TzI5UUZ5SGl5UzBiUTg4dC9BaUFvQWl5Skls?=
 =?utf-8?B?N2pkb0J0THY0bmVXOTZGUWh3dU1QYk5MdXgyYjlONWtTUjl6NlVMNitTVWtl?=
 =?utf-8?B?UkNCaEtqYVM5MHA5OWpkbms2RnhteU9VMkxDb090ZWM3U2k3VW1iNHVMVjVC?=
 =?utf-8?B?czdpb2hDbndSTkY5Z09QZm56ek1TeEgzL3NyYkdQRnZkRjhxZXA3UTY2c2ZT?=
 =?utf-8?B?Zm1uMWhVaUNqQkpBcUFlTGQzbWY3Vkt4Q01JV3RJQ2pZeXZDWXhCMkVXeFBC?=
 =?utf-8?B?OHIwU1pyTjc3cEtha2QwS0xnTWpXTjNIbGdCcFlhci9obkJ3eGtuTFZVbDE5?=
 =?utf-8?B?Z2FYKzU1WHRvZU4zRXkxRjJBNHFyRjBKMlltTmpIUWtnbjFpS2hEVW5hQnpl?=
 =?utf-8?B?aGpaZk9yYWFMdWhJVVRzZz09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(366007)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VjY2bnZQN0FscFFaMjVLYkVaNEhNUDN6QzFxVSswM01nVW9NWlRWWW8vb1lR?=
 =?utf-8?B?Y0t2REljUjhkMFFrNCsxbWIrTm5iRDVUdzBSZCtSSkQwK1dFSnVQSWh5bjM5?=
 =?utf-8?B?Yk81bWtMd1d0aDRxbUZKQmNoUE9PMUpzRFdYVlI4R0hxZ2xsd1oxbDR4Nm1j?=
 =?utf-8?B?VFlZZ0J0QlBORzRtY0J6a1pESnRnNzV6Y3BOdnlIbm10bEM4STFiS0h5VXAv?=
 =?utf-8?B?ZFBiTUNWQTIvS1pkY2RjWnRWTnJSZk9DclpiV3dSYzlGYkNsT0tBZllBaHo3?=
 =?utf-8?B?TFFJM3BneUVXcGVkazl5aHpRT2VZVS9UU3pMYVk3RTRvR1MwREZxaXJIajJX?=
 =?utf-8?B?L1E4b2xhK2FRV0hIUVZpZTNjUXZiY0grN3FoNkF4elgyYTRCVVlVSFVseG5z?=
 =?utf-8?B?ckw2VDFSeEtMWW92SW5GVkdZY0I0NXhlNFcyVEUwalNmTDF4UERxN1pqak4x?=
 =?utf-8?B?eFZYNXI3dENKRXJIRUg3RkNwS3FrTGx4YmF3M1lKUitQWkE2V1oyaFlBOUlj?=
 =?utf-8?B?eUtwZVQ3cFNFa1hZbmc0dmMzZDVrMXAzaUx3QUR6UHQ5YlU4ekJpa0x2M0lr?=
 =?utf-8?B?ZDJPOTl1L0k5Vnd1WWZ2eERLdWU4emp3Um85akNkWml2LytRK1hFOHdBL1RZ?=
 =?utf-8?B?YnhXNk9EYkhlSkFWU3V5cUFLUzVJVjQ4T1Vyd3BHRkFiZDlLdEgxV1JvQURa?=
 =?utf-8?B?QVBpMUI4TmpYeGdNcDNhM2ZvRS9PWHpKQ0JndWl5NGM3MEx2NzlFeTQ4amdM?=
 =?utf-8?B?STA0RjZDZkZiVS9Tc3hIaElFNU55L3hOYkw0NmdqU2FsNDhnUGdlK3lPRG1E?=
 =?utf-8?B?TTJOcjRxeGhmSU9tazhmOTJCRmw2ZDNRbVBSNDNMYXg2ckJVUFBrSXJQZ3l2?=
 =?utf-8?B?Y2FLajRGdkpqSmZuQ1ZXeE0wR093WFRGQ3NVMFFGaHZzVmRmRFpCbmdOWGJy?=
 =?utf-8?B?L1NpV0thc2lkc2RPUFRpK3dZUWpxd0hGRjhYejV5RVo3S214YlBpWU5tY1kw?=
 =?utf-8?B?M0VzakUzYUVFOVVvaUtGQVhxVVkySGE4WHcySVFicXVFOFdXejJOOWI3VGVX?=
 =?utf-8?B?U3crM1lYeFVjekhaYXlRZ2FHb0JXeVZxTzhnRi9rSnJKcWFlam5UYng3M2NS?=
 =?utf-8?B?cklwbmV6UzdVblhub1luTFhncVFOTm5JMFZCQzJVRGlkc1lmaHR5UnAzaDg4?=
 =?utf-8?B?ZnRDOThyUHAvMzc1MmkvSGEyalVheTU5VTJWdzJYNnRJRVVWNVBXWnJQckti?=
 =?utf-8?B?TkVJc2x0ck44M1VTNmFxclQ4L2d0REdhWmE5YmFxRlZUWnRsZzM3MDN3NkU1?=
 =?utf-8?B?STBoZVNjWWlSYm1DWjAzbU5vWmZhYlc4VGFsWEdiNlZKK0R0UmRDREE0cWFD?=
 =?utf-8?B?b2hpOEIxRXhkYStiOUtvRnlyQWNJSnRTaVZnN3N6OGx0ZEhXM2d3YzVwTld5?=
 =?utf-8?B?RFpWRnFjN3I3Wm43WTFUTU9TUEVTQUFzMTNLQVhyNWo1NVNuZTlPa09XVVdS?=
 =?utf-8?B?Tm1YK0lNQnFNNEZKTm8za2M0ZngxY1d2c2lLWlBXNEY5aVVERXdzeXMyUXBr?=
 =?utf-8?B?QjluU2hEMGwvaWZZOEZSSURqUy9zS0doNkUvekc4ZlJMTmlPSTVveUVLMzJW?=
 =?utf-8?B?YmlSelV3MXYzZy9NNVFSdkpoc21BMTZNQjloS1N6SGxkazJPWUFKdzVsdjNy?=
 =?utf-8?B?TWxLaWgyakxYNnFMMjMxY2h3Mm9sZXE2NytBeWFXZE1DSExkZlA3bHVUWkRX?=
 =?utf-8?B?T1hYWUZGTGNzS2gvd3FqaFlMUTBydzZqakozeEJ2MFRMZ3RXVk5hT3F5UU5x?=
 =?utf-8?B?VGYyMEZpSTVzTDAvb1pOWTFDQzcxKzdLeFh0TnlxK0g3UkRDckt2c3hvWWNv?=
 =?utf-8?B?R215Q1JwWGZLS0tFY3Fnb0U5RHpmUkQ4TVpROU5KWmdYb1lLOTBLNTRacklU?=
 =?utf-8?B?b25abGJ6eS8zUW1vUmU4ZXliVS9IbTVRaktBN2JvMzI3Z3lnUlpCcWUwVXly?=
 =?utf-8?B?c0Z3N29Ld2pWcXA2L05yV3ZtcXVLNU51NzFjc0w1UlRzcVEyYnFZZkRjUjUz?=
 =?utf-8?B?WkdJcUNmYjU3UnJjaFExbGVjN1k3eldsTVlSUW1OaEFWWXQ2bnhOMmM1TDBN?=
 =?utf-8?Q?DuK8bZbK+Tfyy457gk9XTbLzg?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1410172b-5e69-4b91-7af8-08dc7bcd38b2
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 May 2024 08:40:52.9319 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iQL/33dNvFRcmnbaWMe1fkZnWjk2NA4oIK2o3CvJqViF/W+UVQhMYBi65Ga1dQrYFENTXWt+OxbW/CeGLX95oJ1EAC1BoHiXv4W98jaC+V8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4631
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.11;
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IEphc29uIFdhbmcgPGphc293
YW5nQHJlZGhhdC5jb20+DQo+U3ViamVjdDogUmU6IFtQQVRDSF0gaW50ZWxfaW9tbXU6IFVzZSB0
aGUgbGF0ZXN0IGZhdWx0IHJlYXNvbnMgZGVmaW5lZCBieQ0KPnNwZWMNCj4NCj5PbiBUdWUsIE1h
eSAyMSwgMjAyNCBhdCA2OjI14oCvUE0gRHVhbiwgWmhlbnpob25nDQo+PHpoZW56aG9uZy5kdWFu
QGludGVsLmNvbT4gd3JvdGU6DQo+Pg0KPj4NCj4+DQo+PiA+LS0tLS1PcmlnaW5hbCBNZXNzYWdl
LS0tLS0NCj4+ID5Gcm9tOiBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPg0KPj4gPlN1
YmplY3Q6IFJlOiBbUEFUQ0hdIGludGVsX2lvbW11OiBVc2UgdGhlIGxhdGVzdCBmYXVsdCByZWFz
b25zIGRlZmluZWQgYnkNCj4+ID5zcGVjDQo+PiA+DQo+PiA+T24gTW9uLCBNYXkgMjAsIDIwMjQg
YXQgMTI6MTXigK9QTSBMaXUsIFlpIEwgPHlpLmwubGl1QGludGVsLmNvbT4gd3JvdGU6DQo+PiA+
Pg0KPj4gPj4gPiBGcm9tOiBEdWFuLCBaaGVuemhvbmcgPHpoZW56aG9uZy5kdWFuQGludGVsLmNv
bT4NCj4+ID4+ID4gU2VudDogTW9uZGF5LCBNYXkgMjAsIDIwMjQgMTE6NDEgQU0NCj4+ID4+ID4N
Cj4+ID4+ID4NCj4+ID4+ID4NCj4+ID4+ID4gPi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+
PiA+PiA+ID5Gcm9tOiBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPg0KPj4gPj4gPiA+
U2VudDogTW9uZGF5LCBNYXkgMjAsIDIwMjQgODo0NCBBTQ0KPj4gPj4gPiA+VG86IER1YW4sIFpo
ZW56aG9uZyA8emhlbnpob25nLmR1YW5AaW50ZWwuY29tPg0KPj4gPj4gPiA+Q2M6IHFlbXUtZGV2
ZWxAbm9uZ251Lm9yZzsgTGl1LCBZaSBMIDx5aS5sLmxpdUBpbnRlbC5jb20+OyBQZW5nLA0KPkNo
YW8NCj4+ID5QDQo+PiA+PiA+ID48Y2hhby5wLnBlbmdAaW50ZWwuY29tPjsgWXUgWmhhbmcgPHl1
LmMuemhhbmdAbGludXguaW50ZWwuY29tPjsNCj4+ID5NaWNoYWVsDQo+PiA+PiA+ID5TLiBUc2ly
a2luIDxtc3RAcmVkaGF0LmNvbT47IFBhb2xvIEJvbnppbmkNCj48cGJvbnppbmlAcmVkaGF0LmNv
bT47DQo+PiA+PiA+ID5SaWNoYXJkIEhlbmRlcnNvbiA8cmljaGFyZC5oZW5kZXJzb25AbGluYXJv
Lm9yZz47IEVkdWFyZG8NCj5IYWJrb3N0DQo+PiA+PiA+ID48ZWR1YXJkb0BoYWJrb3N0Lm5ldD47
IE1hcmNlbCBBcGZlbGJhdW0NCj4+ID48bWFyY2VsLmFwZmVsYmF1bUBnbWFpbC5jb20+DQo+PiA+
PiA+ID5TdWJqZWN0OiBSZTogW1BBVENIXSBpbnRlbF9pb21tdTogVXNlIHRoZSBsYXRlc3QgZmF1
bHQgcmVhc29ucw0KPmRlZmluZWQNCj4+ID5ieQ0KPj4gPj4gPiA+c3BlYw0KPj4gPj4gPiA+DQo+
PiA+PiA+ID5PbiBGcmksIE1heSAxNywgMjAyNCBhdCA2OjI24oCvUE0gWmhlbnpob25nIER1YW4N
Cj4+ID4+ID4gPjx6aGVuemhvbmcuZHVhbkBpbnRlbC5jb20+IHdyb3RlOg0KPj4gPj4gPiA+Pg0K
Pj4gPj4gPiA+PiBGcm9tOiBZdSBaaGFuZyA8eXUuYy56aGFuZ0BsaW51eC5pbnRlbC5jb20+DQo+
PiA+PiA+ID4+DQo+PiA+PiA+ID4+IEN1cnJlbnRseSB3ZSB1c2Ugb25seSBWVERfRlJfUEFTSURf
VEFCTEVfSU5WIGFzIGZhdWx0IHJlYXNvbi4NCj4+ID4+ID4gPj4gVXBkYXRlIHdpdGggbW9yZSBk
ZXRhaWxlZCBmYXVsdCByZWFzb25zIGxpc3RlZCBpbiBWVC1kIHNwZWMgNy4yLjMuDQo+PiA+PiA+
ID4+DQo+PiA+PiA+ID4+IFNpZ25lZC1vZmYtYnk6IFl1IFpoYW5nIDx5dS5jLnpoYW5nQGxpbnV4
LmludGVsLmNvbT4NCj4+ID4+ID4gPj4gU2lnbmVkLW9mZi1ieTogWmhlbnpob25nIER1YW4gPHpo
ZW56aG9uZy5kdWFuQGludGVsLmNvbT4NCj4+ID4+ID4gPj4gLS0tDQo+PiA+PiA+ID4NCj4+ID4+
ID4gPkkgd29uZGVyIGlmIHRoaXMgY291bGQgYmUgbm90aWNlZCBieSB0aGUgZ3Vlc3Qgb3Igbm90
LiBJZiB5ZXMgc2hvdWxkDQo+PiA+PiA+ID53ZSBjb25zaWRlciBzdGFydGluZyB0byBhZGQgdGhp
bmcgbGlrZSB2ZXJzaW9uIHRvIHZ0ZCBlbXVsYXRpb24gY29kZT8NCj4+ID4+ID4NCj4+ID4+ID4g
S2VybmVsIG9ubHkgZHVtcHMgdGhlIHJlYXNvbiBsaWtlIGJlbG93Og0KPj4gPj4gPg0KPj4gPj4g
PiBETUFSOiBbRE1BIFdyaXRlIE5PX1BBU0lEXSBSZXF1ZXN0IGRldmljZSBbMjA6MDAuMF0gZmF1
bHQgYWRkcg0KPj4gPjB4MTIzNDYwMDAwMA0KPj4gPj4gPiBbZmF1bHQgcmVhc29uIDB4NzFdIFNN
OiBQcmVzZW50IGJpdCBpbiBmaXJzdC1sZXZlbCBwYWdpbmcgZW50cnkgaXMgY2xlYXINCj4+ID4+
DQo+PiA+PiBZZXMsIGd1ZXN0IGtlcm5lbCB3b3VsZCBub3RpY2UgaXQgYXMgdGhlIGZhdWx0IHdv
dWxkIGJlIGluamVjdGVkIHRvIHZtLg0KPj4gPj4NCj4+ID4+ID4gTWF5YmUgYnVtcCAxLjAgLT4g
MS4xPw0KPj4gPj4gPiBNeSB1bmRlcnN0YW5kaW5nIHZlcnNpb24gbnVtYmVyIGlzIG9ubHkgaW5m
b3JtYXRpb25hbCBhbmQgaXMgZmFyDQo+ZnJvbQ0KPj4gPj4gPiBhY2N1cmF0ZSB0byBtYXJrIGlm
IGEgZmVhdHVyZSBzdXBwb3J0ZWQuIERyaXZlciBzaG91bGQgY2hlY2sgY2FwL2VjYXANCj4+ID4+
ID4gYml0cyBpbnN0ZWFkLg0KPj4gPj4NCj4+ID4+IFNob3VsZCB0aGUgdmVyc2lvbiBJRCBoZXJl
IGJlIGFsaWduZWQgd2l0aCBWVC1kIHNwZWM/DQo+PiA+DQo+PiA+UHJvYmFibHksIHRoaXMgbWln
aHQgYmUgc29tZXRoaW5nIHRoYXQgY291bGQgYmUgbm90aWNlZCBieSB0aGUNCj4+ID5tYW5hZ2Vt
ZW50IHRvIG1pZ3JhdGlvbiBjb21wYXRpYmlsaXR5Lg0KPj4NCj4+IENvdWxkIHlvdSBlbGFib3Jh
dGUgd2hhdCB3ZSBuZWVkIHRvIGRvIGZvciBtaWdyYXRpb24gY29tcGF0aWJpbGl0eT8NCj4+IEkg
c2VlIHZlcnNpb24gaXMgYWxyZWFkeSBleHBvcnRlZCBzbyBsaWJ2aXJ0IGNhbiBxdWVyeSBpdCwg
c2VlOg0KPj4NCj4+ICAgICBERUZJTkVfUFJPUF9VSU5UMzIoInZlcnNpb24iLCBJbnRlbElPTU1V
U3RhdGUsIHZlcnNpb24sIDApLA0KPg0KPkl0IGlzIHRoZSBRZW11IGNvbW1hbmQgbGluZSBwYXJh
bWV0ZXJzIG5vdCB0aGUgdmVyc2lvbiBvZiB0aGUgdm1zdGF0ZS4NCj4NCj5Gb3IgZXhhbXBsZSAt
ZGV2aWNlIGludGVsLWlvbW11LHZlcnNpb249My4wDQo+DQo+UWVtdSB0aGVuIGtub3dzIGl0IHNo
b3VsZCBiZWhhdmUgYXMgMy4wLg0KDQpTbyB5b3Ugd2FudCB0byBidW1wIHZ0ZF92bXN0YXRlLnZl
cnNpb24/DQoNCkluIGZhY3QsIHRoaXMgc2VyaWVzIGNoYW5nZSBpbnRlbF9pb21tdSBwcm9wZXJ0
eSBmcm9tIHgtc2NhbGFibGUtbW9kZT1bIm9uInwib2ZmIl0iDQp0byB4LXNjYWxhYmxlLW1vZGU9
WyJsZWdhY3kifCJtb2Rlcm4ifCJvZmYiXSIuDQoNCk15IHVuZGVyc3RhbmRpbmcgbWFuYWdlbWVu
dCBhcHAgc2hvdWxkIHVzZSBzYW1lIHFlbXUgY21kbGluZQ0KaW4gc291cmNlIGFuZCBkZXN0aW5h
dGlvbiwgc28gY29tcGF0aWJpbGl0eSBpcyBhbHJlYWR5IGd1YXJhbnRlZWQgZXZlbiBpZg0Kd2Ug
ZG9uJ3QgYnVtcCB2dGRfdm1zdGF0ZS52ZXJzaW9uLg0KDQpUaGFua3MNClpoZW56aG9uZw0K

