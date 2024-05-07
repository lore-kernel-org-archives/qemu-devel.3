Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C65CCC41513
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2024 10:26:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4I1B-0005nV-1B; Tue, 07 May 2024 06:25:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1s4I0y-0005jJ-9c
 for qemu-devel@nongnu.org; Tue, 07 May 2024 06:25:40 -0400
Received: from mgamail.intel.com ([198.175.65.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1s4I0u-0005eS-OC
 for qemu-devel@nongnu.org; Tue, 07 May 2024 06:25:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1715077537; x=1746613537;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=MnHUjMD++QuAWUAx5Td8Nr7TZ7Z9pliMODdQkhymipM=;
 b=MkSeQcYqkJ6SIJtBPy6OYWUlLRHk/7nHIRTP1QV/ke92FyCox+WyR3fC
 P+IpY/xEZcD6GOY/R0WLZLhnbQeo+jCF6dIRVb8L5lw8Ejl/8HUleukdZ
 xAM2nTARwQv3Wci1TUh74Bi+cPmBH7f0PNa6iQ/+VaWE1DvdqEFvU9hqb
 /6N18O11BGBxaTQaWm35llt8XgFddan9sMq6SaO1y85z2PzNd9Fare1pz
 KwcP117kiSnI1L1n1a2rY0AoqGkokKWvWjHuJIJK3rSkVbOA5ktxkFy1m
 72pZTB70qmH6aJo8xYEtJdNKJOA0o0bVrOV8el2RRa4q4xCoaCIc+ubV0 w==;
X-CSE-ConnectionGUID: cholpbFVQP+dxcA8gMNC5Q==
X-CSE-MsgGUID: w6DAyDzgQuGIKpAn/sbgww==
X-IronPort-AV: E=McAfee;i="6600,9927,11065"; a="14647068"
X-IronPort-AV: E=Sophos;i="6.07,261,1708416000"; d="scan'208";a="14647068"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 May 2024 03:25:34 -0700
X-CSE-ConnectionGUID: F5ncCrynTuKdHu5Er9ILLw==
X-CSE-MsgGUID: CcD1VvcXQjeIYMLPABtIhA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,261,1708416000"; d="scan'208";a="29059812"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
 by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 07 May 2024 03:25:34 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 7 May 2024 03:25:33 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 7 May 2024 03:25:33 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 7 May 2024 03:25:33 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 7 May 2024 03:25:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XDRRKrLmYaYj6pQ3cHqrL3fSvYzoxWmfIrnRffnhu4wbfakHIAA+844jg0WElJnUCZRkVdkkKaaFaGOsM7ufFli3ItPEcXPIeNTz2o5QPfuJKs3d2zeBQOmNInQh5WHlh0ycw21KITmEMN5OM4Yv+rsjOC4AI7ibYpbmK1JRgng0JWFKsquKSYhk4FsCQm82ooEURHMMP+p4YmWzK/PwFG4RcfzesBXuXYSXAzNXCmf3lNWqSYkXxb9VtcL3TcCItc+0GueA7FBLq2DQSd/xuoBF+fIK90pKM0F3CxDa5F8k+sEbwLgc37YhMeMNp8wVCQYjBCcXTxaHisZrO0XArg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MnHUjMD++QuAWUAx5Td8Nr7TZ7Z9pliMODdQkhymipM=;
 b=cvqd9LHJxUH3RrXwazrL3KKWH/OAdOoYf00pS1lgyN0B9y6MZFvuK46XNKwplP6Rjel9C2MINR5io3x0gNbn8GCAFAZyUZxbnYo9SquD95VQkOkQeVvbKEWDJBYGOr+xui+5i1Aamf1MqkTn2WeLSQh9r5+mcx3COLRYbHKMncCBYeQgPFbb3kqtxlcbCmI913ElL6LxHjTcypiZUO1zLpD+fqi6uGlJeK3CV4kXComPZ367jW1GhEs73FSFZtpPD8RWZo69iKQYDeaY+LpIBu4ykUdgfvLvsYQUMnLiJridRDGRXv18QZHi+vpjj3WyjBravH7bil/Wd6otI9o/zA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by DS7PR11MB5990.namprd11.prod.outlook.com (2603:10b6:8:71::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7544.41; Tue, 7 May 2024 10:25:25 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::e4a3:76ce:879:9129]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::e4a3:76ce:879:9129%7]) with mapi id 15.20.7544.041; Tue, 7 May 2024
 10:25:25 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Markus Armbruster
 <armbru@redhat.com>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>, "eric.auger@redhat.com"
 <eric.auger@redhat.com>, "mst@redhat.com" <mst@redhat.com>,
 "peterx@redhat.com" <peterx@redhat.com>, "jasowang@redhat.com"
 <jasowang@redhat.com>, "jgg@nvidia.com" <jgg@nvidia.com>,
 "nicolinc@nvidia.com" <nicolinc@nvidia.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "clement.mathieu--drif@eviden.com"
 <clement.mathieu--drif@eviden.com>, "Tian, Kevin" <kevin.tian@intel.com>,
 "Liu, Yi L" <yi.l.liu@intel.com>, "Peng, Chao P" <chao.p.peng@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: RE: [PATCH v4 01/19] backends: Introduce HostIOMMUDevice abstract
Thread-Topic: [PATCH v4 01/19] backends: Introduce HostIOMMUDevice abstract
Thread-Index: AQHaoGA1qoaeYVjC1UGuuiJyxMs7+7GLhZuAgAAIlWA=
Date: Tue, 7 May 2024 10:25:25 +0000
Message-ID: <SJ0PR11MB6744657163BED6D98730056492E42@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20240507092043.1172717-1-zhenzhong.duan@intel.com>
 <20240507092043.1172717-2-zhenzhong.duan@intel.com>
 <264a1de0-1c1e-44bc-bf9b-f1082b9e0e9a@linaro.org>
In-Reply-To: <264a1de0-1c1e-44bc-bf9b-f1082b9e0e9a@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|DS7PR11MB5990:EE_
x-ms-office365-filtering-correlation-id: cd3e5db1-736d-476d-27e4-08dc6e800288
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230031|376005|366007|7416005|1800799015|38070700009; 
x-microsoft-antispam-message-info: =?utf-8?B?SW9VWWtYN0J1QjN0a0RwOGR4SWU4eE1DWmxtSVlObjlzYmJxMG81NkN3OVdW?=
 =?utf-8?B?MGl0cXhuV1lsVHkyUnNNSVcrdE9OTnJTVkZkSmQ4Vzk3bThENmtibzRueHpw?=
 =?utf-8?B?aXhOeWViRzV5c2puOEtFTGVXTHh0RnJKVjRGQU1BbU43ZCtmRkdmNTRVNnBB?=
 =?utf-8?B?dklJcG5WaU5ZQkpRTjA1MHlJVHR3RTZBNUozWlo2Uk5DeEs4R3JVN2tDT1hq?=
 =?utf-8?B?RC9xNTVHNEZzVnIvQ29YTXdtOExYa25vYkNkUndUeUdyOVQ0b3B5VXpJbCtn?=
 =?utf-8?B?b2dtTFB5UjMxd0ZHRDllTXpSZ2pRN0ZuRmZUVWxLU3Z3cnRhdnl6Q3pGK2Vi?=
 =?utf-8?B?azVxMWRsZFVDd0wrUnQ3emo2djZXcVNuMnVtWUMreTVFRVNaeXRmaG54dDJ0?=
 =?utf-8?B?NHhyTm5wYXhSd21kb3RGVUh2YklEQ0MxYXpHZE44OWlNVHhpYU5DeElaT0NL?=
 =?utf-8?B?dVR6a0VkeUdFM0MxalEwSy84TjZmZzhhMzYwT0lFN0lGVkZqaHZmM0x6Rzlo?=
 =?utf-8?B?OHlvQ2FGWUlNYnU1bEFSSXFDRjRiS09KUDdYSjJyS0NMQ1liVENnL1hzaXRQ?=
 =?utf-8?B?OXZ1YnczbXZVajZ5andkUTFkUGVXcktGbXUrOENwT0xHRjYwbDlKRlcwTkxC?=
 =?utf-8?B?OWNiT1MzT0lGd1EyVktSeE5DUFVLOE5FZXgwbEFMOXgyQStqTEx5Zk4xK3hR?=
 =?utf-8?B?aU1xMHRYeGsxK1Ywbk5PVWU0ZDcvY0xzMStLQzRtL2pxOFRjaDFTSGZyTGlI?=
 =?utf-8?B?QmxVQkFWYmhmVW1CbG81cVdKVDNmdDhuczIxM2dFWmw2aGpxTnBkeENQMDJ4?=
 =?utf-8?B?TXdWaGVLb0tyNFFvUnZESUZBS3ZqNjR1STF5azh6aGhZL2hwM05vajZrMHNU?=
 =?utf-8?B?OWhyeE9Tc2lyWHJzRmdmU29oZ3h1TUIxR0trUmdFRGUxRG13MGYvT3MzM3Br?=
 =?utf-8?B?M1RFTXRaRjJEeXZFQmNEWTcwcXFHM294YnJIY1FJQmdlRUtmSWEvRXBwWVNo?=
 =?utf-8?B?NnJxdVVVWUd0QWJLaUV4TTQ0RVlBYWhwWmlZZW15UWJUazZicTNiMnBPVFFv?=
 =?utf-8?B?cEdHMkRuU2diMy94bVdxU2FMcXZaRmsrN055dTVLajB3Ym04SEhUZjhzTkNx?=
 =?utf-8?B?T0IrU1pZeUVRc0psNmZSUm9OUUp4Wk1ZOVdFNkN6Zy8yYVI1OHJOQ205R2tU?=
 =?utf-8?B?SmdoeGpFT0lZbkMzQTgxSXlISjZEcWpmT01KY05lRHNQL2pxYk14Qjh3UVZz?=
 =?utf-8?B?SUswYVRlQVBDN1I1V0pwaEl6aTlhQzdVQnM5cG5sYndsZzFnMm5PTTJJRWpr?=
 =?utf-8?B?cHlESEx6OXBxNGNPaVE2enRYYVdkSXdPYnpyLzNCUE4rNkdTZVhka25pQ0Jv?=
 =?utf-8?B?d3BnWEZ2V0NDdGpUUld2TFlOL29JdGpsOHNVUE5FbDVJMG1CalRJUlFjcjRK?=
 =?utf-8?B?amQ2WDc0R3JrK2prYW9mUjlNR1RvNkg1blgrcCtXY1BTSVlsLzd2WEdOb29v?=
 =?utf-8?B?OW92MFJ5V3JCRk1xNUhlazdsd1laV2NFVWs3M1ZuNHVWQ3g5NnpabFNVZXdY?=
 =?utf-8?B?QzlmMi9XTEUvcS9vRUdDdUxDM25Oak5DZlc1SjgvdkhLUFpDTjQ1TkFCNjlk?=
 =?utf-8?B?YURqdkRGc1R0ajA5cmowa1JXcDZMRlBtZFZMaWJtbHNFZVNHM0tvVFFrRUI0?=
 =?utf-8?B?aiswdE5PZmhHRkR1bHRjNUY1SE5LaFU2OHltNkpyMVdna1ZOUk5VbHJ6TmRB?=
 =?utf-8?B?QXcwNmJuS3AyY2g4ejFsa0UxU2JGVy9aWUg2WE51OWx3NUEza3NqV1NtNW9s?=
 =?utf-8?B?aVNnWklZRFJOT1p4Q0Zydz09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(366007)(7416005)(1800799015)(38070700009); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?b2dlcDdXLzY1Nk10V1VlQjJuTVlBdzdsMkZzYXNvMGJYUVpEM0x2cVFONk1I?=
 =?utf-8?B?T2hhSFlpNzNRalU1Q0ltNmJIcEhqSTFLQldKYlhJYlc2Wi8vTzBVZUtkZkpW?=
 =?utf-8?B?YWRLTzVLYkxTamtvY3RhRXpxRU5OSUQzTy8vSy8zV0d4enpRQUdRdmRSZFJ3?=
 =?utf-8?B?QXVLbExDWDJtWnBXcHRYVmdXK0ZJcmpsMElwOHBncXJjTWJBYU5PMUZtUDdp?=
 =?utf-8?B?QnQya1RsN0V2OU1iWFVJMDE1OERGUFBTbTEzbndtR0VjRWQyNi9vOHNxZ21y?=
 =?utf-8?B?cjFMUVpIaVFkZmNOWkwrMVVTcURtUjFzNmp2WFZFS3lwODJXR1lHbUFJNG5N?=
 =?utf-8?B?V0pYcUdsRFNGU2FUUHFZTG1mYzdFcVJqV1I3VzdJL1dxRFkxM3pEeE5EbG9u?=
 =?utf-8?B?T0lVMXV4bG4vYUxBdW1zOVZ3VVF3aHQrSHpMb1FoSVNwb1ArMURiZVZsNXFF?=
 =?utf-8?B?Ry9yTGdyRlg3V3VURlBETTlMdExYdWZzQ2tITE51c0ZOZEpGcDg2WVFMTDM2?=
 =?utf-8?B?aDZuL2k3YVN3WnUxREQ2K0gxdXNKSUdVZzNsVXU0SGpwc3RDVkRQcFRhY0tP?=
 =?utf-8?B?YWs5K3l3TmkwWlExYXRMdmphMEVmK3Z4aGVwMzRoNFdEeEZMQ3BVSVkzejhN?=
 =?utf-8?B?QmdBb0JydDRjejlCT2tIRTNNYXE0UVFhR3pXM1JBZmxwOW43UXd5UnNrWFJQ?=
 =?utf-8?B?SEprd0hiYVRiUWJQeWpBYUFLeGJ2TlB4RU42RmsyNytCZngyUnVqZm5jUXVG?=
 =?utf-8?B?Wm5hZk94UUdoRkpPbHNuc3JoMVVKVmNjVjlIazdiRzlTb1ZGY2F2NnV3bFJX?=
 =?utf-8?B?RUxnZXBjalhqOUI5R1lDcmlHemJEcUdZT2RFODFheXMwSWhISWpjK29sRFlu?=
 =?utf-8?B?c3VrMmlMNWdlS01zWUs5ZS9EVmhFS2lDamZYeUFWaFA0L3NSUXFRYnh2QWVn?=
 =?utf-8?B?ZWtFZms4VnJ2SUpkT1lBT3NmUUNsWjJHSk5JcmYwa0l1SWV3LzcyRCs4Z3dW?=
 =?utf-8?B?RHloU1hKNmlraFl2aWEycllUMktMTTZVMjM1blN4c0VrZldnV0tDQkx4aVlJ?=
 =?utf-8?B?cGdreFI1Zy9XU2V1aEJ4SXJ3TStIZUdKOVhsZDFhdUdjY1pxMXhEQ1NIelNk?=
 =?utf-8?B?ZkRwdWJndENWWm55YXFGcmFodS9kUjBOaXdUQktQNWZ6aFlFVWRxZzJnUDA5?=
 =?utf-8?B?MUxZd1BkbE1rMUpzSlhEblFYeWx1RTVFaDhMTlJwb0hpTUhxNGtkQXRUV1la?=
 =?utf-8?B?Y1pFRFBsOHEwUjl2dzJkMEk2Q3RWM3E2TUs4RHJ0aDZwbFkyVG9uZXlqVnA2?=
 =?utf-8?B?THRLV0txZDBBd080RVZOZHNKaTAwU2dBWi9Xajdqd25UQmt4Zm1mVFhTWWVk?=
 =?utf-8?B?bDVOdXZnRFdRT2NsY1JieWR0L3NlSm96R2Vsd21XMitpbzBGcFQ2S3NrZTdm?=
 =?utf-8?B?aXd0UllUZ09za1VTWlJMREp5blBZdmJGTWNKWkY3K0N2aGVFTXFYY2g1anBp?=
 =?utf-8?B?UHRpdEFrK29BSVVIUjY1Wjh0RU9qcmhGcU5nZWgyandoZm1DdVdMQTJFUWM2?=
 =?utf-8?B?MTIvM1lVei95aGVFYVU4VE1RdmFwYjdLRFQzekdMdjVlNXFlOWtoTlhiV2hJ?=
 =?utf-8?B?bGkxNUtrQkJ0NnRsWVJzQThZNW1FK2FzVHc3ZFdEaUVkZWtMSGMwdUJ1MGJV?=
 =?utf-8?B?cHN5VDRkOWJCMDVLc1Y2NmtnaEdrbWNhT2NYTC8rMmY1aVVzRCt0RW5JVTZl?=
 =?utf-8?B?NHlEQnRzdE9keWl3SHBOU05FdW5HS0JEWVBQTStDTlBvYW9FSCtQdnJZQTJD?=
 =?utf-8?B?ckgzR0l1V2JMdlorQnFBaC9SNjR4NWowTVVYdU4rbmJWODMzTEhVTnAxMVdS?=
 =?utf-8?B?YTUxZkhPdlZPWEh6alZpTkNjcUI2b3huUnl0bENEaldsL0RrN1BXUDdubkYv?=
 =?utf-8?B?V3hsaVlZOEN6b0tweFNkaU1mZzZxT3dObEwzZnlyT2lJUS9jUGFmZ1NPdEUr?=
 =?utf-8?B?cEs1VlBEbUdOVjIwTFd1UUE1S3BrS0c2MWljazJ1OVpYN2dBcVJWczkyREdk?=
 =?utf-8?B?Ums1L1hTeVU0ZDBKTEdVUTNpSXVaR1RZRzh2YlNaeWNEMk82ZnNibXJDamZj?=
 =?utf-8?Q?qqNd7GZmggpOJv/kpo1RUICf4?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd3e5db1-736d-476d-27e4-08dc6e800288
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 May 2024 10:25:25.6677 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aWHob606XeqDFCRoNXMjFN98U3U2zE6dMV5PnC2dPiWb8C5tTGoknvo9ZzqJaNaqZMx/N5z9/2EMd0Ucuzxtw5MgUFdFXuHVSb7ulJEmADI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB5990
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.15;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.581,
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

SGkgUGhpbGlwcGUsDQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IFBoaWxp
cHBlIE1hdGhpZXUtRGF1ZMOpIDxwaGlsbWRAbGluYXJvLm9yZz4NCj5TdWJqZWN0OiBSZTogW1BB
VENIIHY0IDAxLzE5XSBiYWNrZW5kczogSW50cm9kdWNlIEhvc3RJT01NVURldmljZQ0KPmFic3Ry
YWN0DQo+DQo+SGkgWmhlbnpob25nLA0KPg0KPk9uIDcvNS8yNCAxMToyMCwgWmhlbnpob25nIER1
YW4gd3JvdGU6DQo+PiBJbnRyb2R1Y2UgSG9zdElPTU1VRGV2aWNlIGFzIGFuIGFic3RyYWN0aW9u
IG9mIGhvc3QgSU9NTVUgZGV2aWNlLg0KPj4NCj4+IEludHJvZHVjZSAucmVhbGl6ZSgpIHRvIGlu
aXRpYWxpemUgSG9zdElPTU1VRGV2aWNlIGZ1cnRoZXIgYWZ0ZXINCj4+IGluc3RhbmNlIGluaXQu
DQo+Pg0KPj4gSW50cm9kdWNlIGEgbWFjcm8gQ09ORklHX0hPU1RfSU9NTVVfREVWSUNFIHRvIGRl
ZmluZSB0aGUgdXNhZ2UNCj4+IGZvciBWRklPLCBhbmQgVkRQQSBpbiB0aGUgZnV0dXJlLg0KPj4N
Cj4+IFN1Z2dlc3RlZC1ieTogQ8OpZHJpYyBMZSBHb2F0ZXIgPGNsZ0ByZWRoYXQuY29tPg0KPj4g
U2lnbmVkLW9mZi1ieTogWmhlbnpob25nIER1YW4gPHpoZW56aG9uZy5kdWFuQGludGVsLmNvbT4N
Cj4+IC0tLQ0KPj4gICBNQUlOVEFJTkVSUyAgICAgICAgICAgICAgICAgICAgICAgIHwgIDIgKysN
Cj4+ICAgaW5jbHVkZS9zeXNlbXUvaG9zdF9pb21tdV9kZXZpY2UuaCB8IDUxDQo+KysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrDQo+PiAgIGJhY2tlbmRzL2hvc3RfaW9tbXVfZGV2aWNlLmMg
ICAgICAgfCAzMCArKysrKysrKysrKysrKysrKysNCj4+ICAgYmFja2VuZHMvS2NvbmZpZyAgICAg
ICAgICAgICAgICAgICB8ICA1ICsrKw0KPj4gICBiYWNrZW5kcy9tZXNvbi5idWlsZCAgICAgICAg
ICAgICAgIHwgIDEgKw0KPj4gICA1IGZpbGVzIGNoYW5nZWQsIDg5IGluc2VydGlvbnMoKykNCj4+
ICAgY3JlYXRlIG1vZGUgMTAwNjQ0IGluY2x1ZGUvc3lzZW11L2hvc3RfaW9tbXVfZGV2aWNlLmgN
Cj4+ICAgY3JlYXRlIG1vZGUgMTAwNjQ0IGJhY2tlbmRzL2hvc3RfaW9tbXVfZGV2aWNlLmMNCj4N
Cj4NCj4+IGRpZmYgLS1naXQgYS9pbmNsdWRlL3N5c2VtdS9ob3N0X2lvbW11X2RldmljZS5oDQo+
Yi9pbmNsdWRlL3N5c2VtdS9ob3N0X2lvbW11X2RldmljZS5oDQo+PiBuZXcgZmlsZSBtb2RlIDEw
MDY0NA0KPj4gaW5kZXggMDAwMDAwMDAwMC4uMmI1OGE5NGQ2Mg0KPj4gLS0tIC9kZXYvbnVsbA0K
Pj4gKysrIGIvaW5jbHVkZS9zeXNlbXUvaG9zdF9pb21tdV9kZXZpY2UuaA0KPj4gQEAgLTAsMCAr
MSw1MSBAQA0KPj4gKy8qDQo+PiArICogSG9zdCBJT01NVSBkZXZpY2UgYWJzdHJhY3QgZGVjbGFy
YXRpb24NCj4+ICsgKg0KPj4gKyAqIENvcHlyaWdodCAoQykgMjAyNCBJbnRlbCBDb3Jwb3JhdGlv
bi4NCj4+ICsgKg0KPj4gKyAqIEF1dGhvcnM6IFpoZW56aG9uZyBEdWFuIDx6aGVuemhvbmcuZHVh
bkBpbnRlbC5jb20+DQo+PiArICoNCj4+ICsgKiBUaGlzIHdvcmsgaXMgbGljZW5zZWQgdW5kZXIg
dGhlIHRlcm1zIG9mIHRoZSBHTlUgR1BMLCB2ZXJzaW9uIDIuICBTZWUNCj4+ICsgKiB0aGUgQ09Q
WUlORyBmaWxlIGluIHRoZSB0b3AtbGV2ZWwgZGlyZWN0b3J5Lg0KPj4gKyAqLw0KPj4gKw0KPj4g
KyNpZm5kZWYgSE9TVF9JT01NVV9ERVZJQ0VfSA0KPj4gKyNkZWZpbmUgSE9TVF9JT01NVV9ERVZJ
Q0VfSA0KPj4gKw0KPj4gKyNpbmNsdWRlICJxb20vb2JqZWN0LmgiDQo+PiArI2luY2x1ZGUgInFh
cGkvZXJyb3IuaCINCj4+ICsNCj4+ICsjZGVmaW5lIFRZUEVfSE9TVF9JT01NVV9ERVZJQ0UgImhv
c3QtaW9tbXUtZGV2aWNlIg0KPj4gK09CSkVDVF9ERUNMQVJFX1RZUEUoSG9zdElPTU1VRGV2aWNl
LCBIb3N0SU9NTVVEZXZpY2VDbGFzcywNCj5IT1NUX0lPTU1VX0RFVklDRSkNCj4+ICsNCj4+ICtz
dHJ1Y3QgSG9zdElPTU1VRGV2aWNlIHsNCj4+ICsgICAgT2JqZWN0IHBhcmVudF9vYmo7DQo+PiAr
fTsNCj4+ICsNCj4+ICsvKioNCj4+ICsgKiBzdHJ1Y3QgSG9zdElPTU1VRGV2aWNlQ2xhc3MgLSBU
aGUgYmFzZSBjbGFzcyBmb3IgYWxsIGhvc3QgSU9NTVUNCj5kZXZpY2VzLg0KPj4gKyAqDQo+PiAr
ICogRGlmZmVyZW50IHR5cGUgb2YgaG9zdCBkZXZpY2VzIChlLmcuLCBWRklPIG9yIFZEUEEgZGV2
aWNlKSBvciBkZXZpY2VzDQo+PiArICogd2l0aCBkaWZmZXJlbnQgYmFja2VuZCAoZS5nLiwgVkZJ
TyBsZWdhY3kgY29udGFpbmVyIG9yIElPTU1VRkQNCj5iYWNrZW5kKQ0KPj4gKyAqIGNhbiBoYXZl
IGRpZmZlcmVudCBzdWItY2xhc3Nlcy4NCj4+ICsgKi8NCj4+ICtzdHJ1Y3QgSG9zdElPTU1VRGV2
aWNlQ2xhc3Mgew0KPj4gKyAgICBPYmplY3RDbGFzcyBwYXJlbnRfY2xhc3M7DQo+PiArDQo+PiAr
ICAgIC8qKg0KPj4gKyAgICAgKiBAcmVhbGl6ZTogaW5pdGlhbGl6ZSBob3N0IElPTU1VIGRldmlj
ZSBpbnN0YW5jZSBmdXJ0aGVyLg0KPj4gKyAgICAgKg0KPj4gKyAgICAgKiBNYW5kYXRvcnkgY2Fs
bGJhY2suDQo+PiArICAgICAqDQo+PiArICAgICAqIEBoaW9kOiBwb2ludGVyIHRvIGEgaG9zdCBJ
T01NVSBkZXZpY2UgaW5zdGFuY2UuDQo+PiArICAgICAqDQo+PiArICAgICAqIEBvcGFxdWU6IHBv
aW50ZXIgdG8gYWdlbnQgZGV2aWNlIG9mIHRoaXMgaG9zdCBJT01NVSBkZXZpY2UsDQo+PiArICAg
ICAqICAgICAgICAgIGkuZS4sIGZvciBWRklPLCBwb2ludGVyIHRvIFZGSU9EZXZpY2UNCj4+ICsg
ICAgICoNCj4+ICsgICAgICogQGVycnA6IHBhc3MgYW4gRXJyb3Igb3V0IHdoZW4gcmVhbGl6ZSBm
YWlscy4NCj4+ICsgICAgICoNCj4+ICsgICAgICogUmV0dXJuczogdHJ1ZSBvbiBzdWNjZXNzLCBm
YWxzZSBvbiBmYWlsdXJlLg0KPj4gKyAgICAgKi8NCj4+ICsgICAgYm9vbCAoKnJlYWxpemUpKEhv
c3RJT01NVURldmljZSAqaGlvZCwgdm9pZCAqb3BhcXVlLCBFcnJvciAqKmVycnApOw0KPj4gK307
DQo+PiArI2VuZGlmDQo+PiBkaWZmIC0tZ2l0IGEvYmFja2VuZHMvaG9zdF9pb21tdV9kZXZpY2Uu
Yw0KPmIvYmFja2VuZHMvaG9zdF9pb21tdV9kZXZpY2UuYw0KPj4gbmV3IGZpbGUgbW9kZSAxMDA2
NDQNCj4+IGluZGV4IDAwMDAwMDAwMDAuLjQxZjJmZGNlMjANCj4+IC0tLSAvZGV2L251bGwNCj4+
ICsrKyBiL2JhY2tlbmRzL2hvc3RfaW9tbXVfZGV2aWNlLmMNCj4+IEBAIC0wLDAgKzEsMzAgQEAN
Cj4+ICsvKg0KPj4gKyAqIEhvc3QgSU9NTVUgZGV2aWNlIGFic3RyYWN0DQo+PiArICoNCj4+ICsg
KiBDb3B5cmlnaHQgKEMpIDIwMjQgSW50ZWwgQ29ycG9yYXRpb24uDQo+PiArICoNCj4+ICsgKiBB
dXRob3JzOiBaaGVuemhvbmcgRHVhbiA8emhlbnpob25nLmR1YW5AaW50ZWwuY29tPg0KPj4gKyAq
DQo+PiArICogVGhpcyB3b3JrIGlzIGxpY2Vuc2VkIHVuZGVyIHRoZSB0ZXJtcyBvZiB0aGUgR05V
IEdQTCwgdmVyc2lvbiAyLiAgU2VlDQo+PiArICogdGhlIENPUFlJTkcgZmlsZSBpbiB0aGUgdG9w
LWxldmVsIGRpcmVjdG9yeS4NCj4+ICsgKi8NCj4+ICsNCj4+ICsjaW5jbHVkZSAicWVtdS9vc2Rl
cC5oIg0KPj4gKyNpbmNsdWRlICJzeXNlbXUvaG9zdF9pb21tdV9kZXZpY2UuaCINCj4+ICsNCj4+
ICtPQkpFQ1RfREVGSU5FX0FCU1RSQUNUX1RZUEUoSG9zdElPTU1VRGV2aWNlLA0KPj4gKyAgICAg
ICAgICAgICAgICAgICAgICAgICAgICBob3N0X2lvbW11X2RldmljZSwNCj4+ICsgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgSE9TVF9JT01NVV9ERVZJQ0UsDQo+PiArICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIE9CSkVDVCkNCj4+ICsNCj4+ICtzdGF0aWMgdm9pZCBob3N0X2lvbW11X2Rl
dmljZV9jbGFzc19pbml0KE9iamVjdENsYXNzICpvYywgdm9pZCAqZGF0YSkNCj4+ICt7DQo+PiAr
fQ0KPj4gKw0KPj4gK3N0YXRpYyB2b2lkIGhvc3RfaW9tbXVfZGV2aWNlX2luaXQoT2JqZWN0ICpv
YmopDQo+PiArew0KPj4gK30NCj4+ICsNCj4+ICtzdGF0aWMgdm9pZCBob3N0X2lvbW11X2Rldmlj
ZV9maW5hbGl6ZShPYmplY3QgKm9iaikNCj4+ICt7DQo+PiArfQ0KPg0KPkFsbCB0aGVzZSBzdHVi
cyBjYWxsIGZvciBhIFFPTSBpbnRlcmZhY2UgZGVzaWduIGluc3RlYWQNCj5vZiBpbmhlcml0YW5j
ZSBJTUhPLiBTZWUgSU5URVJGQUNFX0NIRUNLIGluICJxb20vb2JqZWN0LmgiLg0KPkJ1dCBtYXli
ZSBJIG1pc3VuZGVyc3Rvb2QgdGhpcyBzZXJpZXMgOikNCg0KVGhhbmtzIGZvciB5b3VyIHN1Z2dl
c3Rpb24uIEd1ZXNzIHlvdSBtZWFuIGludHJvZHVjaW5nIGFuIGludGVyZmFjZQ0Kd2hpY2ggY29u
dGFpbnMgLnJlYWxpemUoKSBhbmQgLmdldF9jYXAoKSwgbGV0IEhvc3RJT01NVURldmljZSBvciBp
dHMNCnN1Yi1jbGFzc2VzIGltcGxlbWVudCB0aGlzIGludGVyZmFjZS4NCg0KLnJlYWxpemUoKSBh
bmQgLmdldF9jYXAoKSBhcmUgbm90IGNvbW1vbiBoYW5kbGVycyBhbmQgb25seSB1c2VkIGJ5IGhv
c3QgaW9tbXUNCmRldmljZSBRT00sIHNhbWUgZm9yIHN1Y2ggYW4gaW50ZXJmYWNlLiBTbyBpdCBs
b29rcyBhbiBvdmVyIGRlc2lnbi4gV2UgY2FuIGxldA0KSG9zdElPTU1VRGV2aWNlIG9yIGl0cyBz
dWItY2xhc3NlcyBkZWZpbmUgYW5kIGltcGxlbWVudCB0aG9zZSBoYW5kbGVycyBkaXJlY3RseS4N
Cg0KVGhhbmtzDQpaaGVuemhvbmcNCg==

