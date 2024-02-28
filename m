Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0E37C5478C
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Feb 2024 02:15:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rf9TG-0002WJ-0s; Tue, 27 Feb 2024 21:14:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1rf9TC-0002Vp-AR
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 21:14:54 -0500
Received: from mgamail.intel.com ([192.198.163.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1rf9Sw-0001n5-Mk
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 21:14:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1709086479; x=1740622479;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=HSC7Va9AKVxiQD2MCnwvy1ZnqRQEbw6t1BXRs5M4ki8=;
 b=CqWxqvwuVgtEwCQm88HlyCMNFQ/Ily7BylgG9G5ddSpjac9BLnOOCXnZ
 4M7DooxcvNsF8U5DL54MDctacrgObsB2heyUw/oSIHWg3olrEbbXSYMLK
 C8LXxBCk5f49NcOgABrgHlbS3QrxlK3cNwS3gL3bYRYENd4ZwRN2yQ9GY
 nk7F/xd91fMcHsITw6i8bBftmB8+cdP1vgw0IbK5/g00J5MBbMxoM4rnZ
 KtDOLXAlB7p/sYywrPjMoxYuerP9oweiiG4QG6YcZjx86tL3e7kgg960t
 akUmD4RvlTPhSwjK8y4j54OxDSy37irEZh0uKmk3CHdI3pDco/v8Q77D+ w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10996"; a="3330677"
X-IronPort-AV: E=Sophos;i="6.06,189,1705392000"; 
   d="scan'208";a="3330677"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Feb 2024 18:14:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,189,1705392000"; d="scan'208";a="30445411"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
 by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 27 Feb 2024 18:14:34 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 27 Feb 2024 18:14:33 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 27 Feb 2024 18:14:33 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 27 Feb 2024 18:14:33 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nNaZvaQGHVEcegMzBtvKEjjTIQx+dLrui6sNJgSPIR4Ww5oMTfiZDHWMjs2D/UZian6LiZL46oc9G7OwGoQQRYbbu+P4Dl/mxyGzSoChLtx0t78Ep1I2Nk4Byxro0I2aOGRhjdS8lm9Z1Peq4zd8WxKeHRpEMr0dmFXl01dezpf0y1MXva/IC+kR0eABWF7rLs3E+njM/bcecAzd45tDZV7QAMM12M4snkjPLbgVK56eBUaKjKobFeT/8Bs+//J/4+2IYDA5pmje8amqJTQMk0AE8hlQchGdiJl49Gxcj9yFIWBIvbZL/JpsV4CLJBVejO2CiJUsfKJ0biEz7BxcHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HSC7Va9AKVxiQD2MCnwvy1ZnqRQEbw6t1BXRs5M4ki8=;
 b=lcrUJ90AtsGXiL+NvK5hhr3iKCpaZROM9sijHwrEuZwMBS5DU0OwrBLiBrjKCdyRinS2R33iRGQaePFIl+zt5nZ+3cS7b2lTZG+luxnumlugnJt5SHuiZDCJphQrOqv3thf+MM+e+7VN4RgkGpZq0aFMuHmkI+ie6mKZ8rRlSkXEosNGIgew2tbQxgOB7oi0z3K31hraltDOQPEw0+pMibkT2CKpv94mKmnj7p+1oGoSH9//OGO2IGTWUjb/q+dwMOEcmMnpRnXFurEtXQ6c1f42fcYGsrSlXfcHqjUsy5ZHlkvhRP1RUzKVKUhX92IFKGPWsaQ5DKi+3jKtzSZdoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by SJ0PR11MB5939.namprd11.prod.outlook.com (2603:10b6:a03:42e::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.23; Wed, 28 Feb
 2024 02:14:31 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::c0f3:15d4:d7f6:a72a]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::c0f3:15d4:d7f6:a72a%4]) with mapi id 15.20.7339.009; Wed, 28 Feb 2024
 02:14:31 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: Joao Martins <joao.m.martins@oracle.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>, "eric.auger@redhat.com"
 <eric.auger@redhat.com>, "peterx@redhat.com" <peterx@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>, "mst@redhat.com"
 <mst@redhat.com>, "jgg@nvidia.com" <jgg@nvidia.com>, "nicolinc@nvidia.com"
 <nicolinc@nvidia.com>, "Tian, Kevin" <kevin.tian@intel.com>, "Liu, Yi L"
 <yi.l.liu@intel.com>, "Sun, Yi Y" <yi.y.sun@intel.com>, "Peng, Chao P"
 <chao.p.peng@intel.com>, Paolo Bonzini <pbonzini@redhat.com>, "Richard
 Henderson" <richard.henderson@linaro.org>, Eduardo Habkost
 <eduardo@habkost.net>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: RE: [PATCH rfcv2 18/18] intel_iommu: Block migration if cap is updated
Thread-Topic: [PATCH rfcv2 18/18] intel_iommu: Block migration if cap is
 updated
Thread-Index: AQHaVOC9sC8O2ye14U6f5euIaQuiIrEILJaAgBV15iCAAI5RgIAA+swg
Date: Wed, 28 Feb 2024 02:14:31 +0000
Message-ID: <SJ0PR11MB6744EFB8DA0649DA6DA3271892582@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20240201072818.327930-1-zhenzhong.duan@intel.com>
 <20240201072818.327930-19-zhenzhong.duan@intel.com>
 <72642921-98d4-4c4f-8117-868d2ae29eb0@oracle.com>
 <SJ0PR11MB6744BF58C9C21D5778A2D15792592@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <2446ce38-29c4-4593-afa1-014299bdc740@oracle.com>
In-Reply-To: <2446ce38-29c4-4593-afa1-014299bdc740@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|SJ0PR11MB5939:EE_
x-ms-office365-filtering-correlation-id: 3401f561-fb24-432e-a056-08dc38030003
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eyNtRui+Rz4+AY+LVbNUlLeYg3FiYsO4Ex2X/3MUDwAplfTqsMtibveR7AK+/ar0MTChOBVRK72MlZU0M5BUrEZMAjYYfkEreswtDJtEkD6piP6duWaHSWflf/jtH5t5n3Nlij+stP7pIB78vq1COPPf3X9GgUFosTAy2fzeH2jDbuhFlh40ezHfjw3gJYBZ+0gjJD0Bih4vIwDa3mr4CvjTqAAKdrwGlSWOCIDVWTOd6WFMbtnvhB+nenSHT8lUwMKq1MHdA0IPj9ZME1ND9FCtiE2R2gdDiBANtvDkSWcutQqRAYQB25a8DhbqZi9mH8nXVuzFS+JT83MwwzDreE3wW4/I6evwsQVyuUsGdNqdtqr3Y+WA0yu0acGi/gfFtPlKeIqUND99D5LbWXFKSXYrOP1AdyOZfTc3ZlQ5Z8jw8p7MHpEco3KVdO6GDMQJ2IYpkoYPwZ5r6iuxeRacJOGfuDhRhISEgHRR/1owaHZ6wI/95dsW8v5y1L73aMsIWP5v7i/0ejhlKi4qfZ4SkyGjUqhrWVM9r7O40M9AVXCO+1hVNbUrJLRlTosN2mQWcrU2hM90DPkWFPFfYDY+Ltr/z+qTtdCQExSzOcqxic8tzLnWBHhZP2NTg+Qak2gagtjY6TUtbjJxNWfrsVtT3MRG1gPgqk91rXqTpuyALWU4aJ4TJqDNTsh+uvhH8SAHj+0vYz2IBVQelf+CTOeghONbrHYlCK+ryAzQueyXyHQ=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TURXUEJFQTJoUFF4cnVUVmplSzg4NEpROHBrZ0p4ekJUNlJ1Q0dqbjJaZjBL?=
 =?utf-8?B?QVY2cjRNSjdmcHk3YjBjbE5VL09nb3BYclpQTGtDcFZYUkZ0Z2xEc3FhTFhZ?=
 =?utf-8?B?MFN0Z0daaE0wWVR6WlBmMU9uUmFtZWMyNk9rNG5CQjJRdGVjYXhicjJUd0NM?=
 =?utf-8?B?aXpsY3ZlMS9ET1loc21FKzdmVEVvVGROQnIxd1dNVHNMQlFjb3ZWNXlIQ3Vo?=
 =?utf-8?B?L01CeWxQQklpVm1mcVAyY0U0Y2VWT0s0RkFNV3h0NmVYSDFWb3R6ZjluVEF2?=
 =?utf-8?B?bFI2V1BHVjZNNTBNSHZMbFVuVllRMy9XNE5Pd0lLMVdFT3pHb3MyYjUxdmJh?=
 =?utf-8?B?b0taZVdleHVHQ2puTnhrVzdBTlFmVmF1VzI1TkFZZXpURUVRVnh5VUxLRXhG?=
 =?utf-8?B?R3h3OWpybjkxS01yRWZCQ1VoWVB5b08wZGpJWU10L1p5MFhHb1BkU1J5T2Nn?=
 =?utf-8?B?aTEreVVRN1Y0cisyZ3dibXhLb1ozNHJjWHQzekZvT3k5V3g3cmQ5T21xZklD?=
 =?utf-8?B?ZEUzbzJpTnBjczNEVCtLRXlXU2h5aTVBWmF0empjcklUbTZYMDBCMDRSNWgv?=
 =?utf-8?B?YmYvVG1NKzFOdjI1eHVpMVVpVDJiRGo5d05HdVVOVFhYZWRIVWxYMEV6OHln?=
 =?utf-8?B?TlhjYlcyelEya0dleUVkdEpuWVdGdGRaSmh5TTc2K1l1dGdvOUlIUkF5WW5F?=
 =?utf-8?B?ZnBsMDRpQmkzVVhaVGRlcEpneHRTalBxNjJzQm5iQnRnWCtnajB2WWNjdzk0?=
 =?utf-8?B?a1k4L1g2NXFhQWtVQVE3UklFbXJiR2JhWTZTSkFsR0srWExrczBLMytwTUVk?=
 =?utf-8?B?WlN5QkpSUG1xZFc3MG9rbCtGK01peklEelNLazNIUXNLUHREK2M1aWxPaVpl?=
 =?utf-8?B?eDZvZlg4QUVKQlI4dnE2NnJVcWxEVjNyOUhyeWZYM2tpUk8rbXhSM0o0cnVj?=
 =?utf-8?B?bTJtQ29pUnJjd0pSWUpGSEFaNis4cHFkb0VaV2wyeGsyN2l0S3RuT3dYaUZT?=
 =?utf-8?B?Y0lpRW9VRFNmcEk1bitLbE5hQkVrT2RnUHJONUNaeWs4dVRlVXFoeTFXSk5h?=
 =?utf-8?B?NHhud0lQOFE3eUpseUhxZFhXTlVFR0U0R0JxMjh4SzJIa0ZvZ2VoK05PUUdI?=
 =?utf-8?B?ZndjUEQzNVpGY2RyOTF0aXpMeW80eHdPdXJFdVVPNlZCeVBmUnBuM0pKVkQ5?=
 =?utf-8?B?cDhvbWtNWi95NEZJRzRNR3djQzR2TGkrb2tqMWRGd3RONW9lREZBSkR0UGZI?=
 =?utf-8?B?Q0ZuaVc5RkJCY3lBU01DRWFjTnFpMytLUlNRMFJYZGtPM3pPdWR6aGVFdUV6?=
 =?utf-8?B?dU8zdDJMTEFaR1JqTGVCYWN3RWRPTThGZjAxdjh0NWlZWHZFZXVFemlhMTRx?=
 =?utf-8?B?Z1J5SjlGUHM5TXN2K3B1aHNSY0ZGUG5NOGNuTkxXM0NXL2V4UTk5YVMvTW5h?=
 =?utf-8?B?Q2NSUVdpVW5FWU5zaWNQN2FLQXBxWm9NbG5PZklLeWRpN3pNNlBWWnJ1ZEph?=
 =?utf-8?B?ZDRXaGNtOUd2RHI5c1dZUWxhZml0M3BINWw2ekMvUWlJNVVvdjczSGo4RzFT?=
 =?utf-8?B?c1lLM29WZGExRzl3VVVuT0xCSzhMd3BIZGhNUFBLNU9xNUI1cUNjQytWYmlE?=
 =?utf-8?B?OTJaSXZpK3NxTUNNMmtOYkFSdjZ6cGhvdnUyM0FZT2F2NjAwUEl1OE43TVZo?=
 =?utf-8?B?UGh4cFdzSS9lUVlEd0FLZFMwRE5vOFl4Z1FxalNXL01wRnJZaVJjcTRjdDla?=
 =?utf-8?B?ZU41Z3A4cTBjRlh6UGZyK0tTdno4SHgzR2tWam5EekFYMFdMSThmcTlod2Fr?=
 =?utf-8?B?K0ovVENYdVBQbUNqQ1ZvWHZEeVcvaFYvREViQ2J6Zk1GVldXN3JWaDFoem9x?=
 =?utf-8?B?N29MQlZWc2RJNlZiYjB6VDJiSnpacWFjRW1pcXFVY0RRaDZRY3QyMmdGUGpK?=
 =?utf-8?B?YTA4WFhXdFlsRW12ZzNPWENZZXFDblQ1bU9ucmZCb0s2Z1pkYUE3OVgrOHVQ?=
 =?utf-8?B?cGhaZE9udTlUZ08rV3oxcHJiTG0weWxkR3hDMlN0bnl4Vno5eTJlRVVhbDFO?=
 =?utf-8?B?NGo4Y1FVSVFwTE1TeFBvUXVucjJIYWZSY3hUMHUwQ3hXKzhzSnU3VWhlSkxF?=
 =?utf-8?Q?No0ec46iZ1xeh0v8GWEIR+Gox?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3401f561-fb24-432e-a056-08dc38030003
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Feb 2024 02:14:31.5638 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KrqPuUJpeEeaDtbumLNtNVTwNXae3lQF/mvE/opBA5ztqKmbHUutjXSnqKuG0MhXUMTbetHo4vUpvWWAZTfQpOqs0tNyxRvYL8SnafGcKR0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5939
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.19;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.088,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IEpvYW8gTWFydGlucyA8am9h
by5tLm1hcnRpbnNAb3JhY2xlLmNvbT4NCj5TdWJqZWN0OiBSZTogW1BBVENIIHJmY3YyIDE4LzE4
XSBpbnRlbF9pb21tdTogQmxvY2sgbWlncmF0aW9uIGlmIGNhcCBpcw0KPnVwZGF0ZWQNCj4NCj5P
biAyNy8wMi8yMDI0IDAyOjQxLCBEdWFuLCBaaGVuemhvbmcgd3JvdGU6DQo+Pg0KPj4NCj4+PiAt
LS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPj4+IEZyb206IEpvYW8gTWFydGlucyA8am9hby5t
Lm1hcnRpbnNAb3JhY2xlLmNvbT4NCj4+PiBTdWJqZWN0OiBSZTogW1BBVENIIHJmY3YyIDE4LzE4
XSBpbnRlbF9pb21tdTogQmxvY2sgbWlncmF0aW9uIGlmIGNhcCBpcw0KPj4+IHVwZGF0ZWQNCj4+
Pg0KPj4+IE9uIDAxLzAyLzIwMjQgMDc6MjgsIFpoZW56aG9uZyBEdWFuIHdyb3RlOg0KPj4+PiBX
aGVuIHRoZXJlIGlzIFZGSU8gZGV2aWNlIGFuZCB2SU9NTVUgY2FwL2VjYXAgaXMgdXBkYXRlZCBi
YXNlZCBvbg0KPj4+IGhvc3QNCj4+Pj4gSU9NTVUgY2FwL2VjYXAsIG1pZ3JhdGlvbiBzaG91bGQg
YmUgYmxvY2tlZC4NCj4+Pj4NCj4+Pj4gU2lnbmVkLW9mZi1ieTogWmhlbnpob25nIER1YW4gPHpo
ZW56aG9uZy5kdWFuQGludGVsLmNvbT4NCj4+Pg0KPj4+IElzIHRoaXMgcmVhbGx5IG5lZWRlZCBj
b25zaWRlcmluZyBtaWdyYXRpb24gd2l0aCB2SU9NTVUgaXMgYWxyZWFkeQ0KPmJsb2NrZWQNCj4+
PiBhbnl3YXlzPw0KPj4NCj4+IFZGSU8gZGV2aWNlIGNhbiBiZSBob3QgdW5wbHVnZ2VkLCB0aGVu
IGJsb2NrZXIgZHVlIHRvIHZJT01NVSBpcw0KPnJlbW92ZWQsDQo+PiBidXQgd2Ugc3RpbGwgbmVl
ZCBhIGJsb2NrZXIgZm9yIGNhcC9lY2FwIHVwZGF0ZS4NCj4+DQo+DQo+UmlnaHQgd2hpY2ggdGhl
biB0aGUgYmxvY2tlciBnZXRzIHJlLWFkZGVkIGFmdGVyIHlvdSBhZGQgb25lIFZGSU8gZGV2aWNl
Lg0KPlRoZQ0KPmNvbW1pdCBtZXNzYWdlIHJlZmVycyB4cGxpY2l0bHkgVkZJTyBkZXZpY2UsIHdo
eSB3b3VsZCB5b3UgY2FyZSBhYm91dA0KPmJsb2NraW5nDQo+bWlncmF0aW9uIG9uIHZJT01NVSB3
aXRob3V0IHZmaW8gZGV2aWNlcyBwcmVzZW50PyBNYXliZSB0aGVyZSdzIGFub3RoZXINCj5yZWFz
b24NCj5idXQgdGhhdCB0aGUgY29tbWl0IG1lc3NhZ2VzIGRvZXNuJ3QgY292ZXI/IGxpa2UgZ3Vl
c3QgTUdBVyBiZWluZyBiaWdnZXINCj50aGFuDQo+aG9zdCBNR0FXIG9yIHNvbWV0aGluZyBsaWtl
IHRoYXQ/DQoNCklmIHFlbXUgc3RhcnRzIHdpdGggY29sZCBwbHVnZ2VkIHZmaW8gZGV2aWNlLCB0
aGF0IHZmaW8gZGV2aWNlIG1heSB1cGRhdGUgY2FwL2VjYXAuDQpFdmVuIGlmIHRoYXQgdmZpbyBk
ZXZpY2UgaXMgdW5wbHVnZ2VkIGF0IHJ1bnRpbWUsIHRoZSBjaGFuZ2VkIGNhcC9lY2FwIGlzIGtl
cHQuDQpJbiB0aGlzIGNhc2Ugc291cmNlIGFuZCBkZXN0IHdpbGwgaGF2ZSBpbmNvbXBhdGlibGUg
Y2FwL2VjYXAgY29uZmlnLg0KU28gSSBibG9jayBtaWdyYXRpb24gaWYgdGhlcmUgaXMgY2FwL2Vj
YXAgdXBkYXRlIG9uIHNvdXJjZSBzaWRlLg0KDQpUaGlzIHBhdGNoIGlzIHRvIGRlYWwgd2l0aCB0
aGUgY2FzZSB0aGF0IHRoZXJlIGlzIGNvbGQgcGx1Z2dlZCB2ZmlvIGRldmljZSB3aGljaCBpcw0K
dW5wbHVnZ2VkIGF0IHJ1bnRpbWUgYW5kIHRoZW4gbWlncmF0aW9uIGhhcHBlbi4NCg0KVGhhbmtz
DQpaaGVuemhvbmcNCg==

