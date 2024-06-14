Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F396C27C6E
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2024 03:07:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHxGg-0006Fh-2u; Thu, 13 Jun 2024 23:06:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sHxGd-0006Bt-TM; Thu, 13 Jun 2024 23:06:19 -0400
Received: from mgamail.intel.com ([192.198.163.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sHxGa-0004TH-LG; Thu, 13 Jun 2024 23:06:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1718334376; x=1749870376;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=xd2LqewqHVeEW8iYmW2EpFND7aRCMNo5yla0OeyrOck=;
 b=Fw4vST3DDExHUN+r/nkJ5dc5vk9c5OEfzvXLV4HLK9kQaJdFVgfIRYQW
 lR90BZx/+uGf5wYnXZgsh+fgT0NFCUG814oD2jPTuc7jz/lIuVz0vOTr7
 qW7Gwl6SRltfb3TiFuEzF2Kkzwk987MOAvIRRcC+BBgKOAwqL7GbjoDwv
 PiAQFNiuS0XeTAlsXahsYwQl+mKFPblY3dOtAOL6yp34ihGi3iIi6BK3Z
 4S7V4Bmu2iJRKPYDrI8WamtOW+/DNsoVNMlGvdwJbrExmiF5QT0U4r3dr
 AKVtjL67mb6KCeWiJ9vEFLn93+fughoxPe9q1QbasYIaW+2K0mVf58GuS g==;
X-CSE-ConnectionGUID: 9VTBylErTPOHak8mTgKDXw==
X-CSE-MsgGUID: atbngEagSz+8H7xOenJEeg==
X-IronPort-AV: E=McAfee;i="6700,10204,11102"; a="25879265"
X-IronPort-AV: E=Sophos;i="6.08,236,1712646000"; d="scan'208";a="25879265"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Jun 2024 20:06:01 -0700
X-CSE-ConnectionGUID: DlHt/i1pSySiiPLhzgwlJw==
X-CSE-MsgGUID: b2mmpXqqSD2nw1zJyeb+dw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,236,1712646000"; d="scan'208";a="41032603"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
 by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 13 Jun 2024 20:06:02 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 13 Jun 2024 20:06:00 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 13 Jun 2024 20:06:00 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.174)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 13 Jun 2024 20:06:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MDBTXR5nMqcsYIA4YByHTYq9yVt7jYaU5VRF1GZ3UXGh6LHrKrAP2QUb4jY1dKISvTWw/ZxLlau4gDRN9NlB+YIFAXijb4jdp2owPt/lDdXAIrc7gCw97zG5Rdsg7YEwG+HUHJn0jNc5bd5XKc4rOKfW8aMGoYdSe5Hxh4FGyQ/aEngbGSYeiF/Io+ZeSIGDO7eB8XRfut9L9+RL1D3dLLe7kOlcyPfvMV3SnMJtKOsYC6oYd+o7RO9nTNb3qjl0aYZjfLKeF19uVpCEzDie44cqTCH/sFXIfyq5L8WY6bgFNcAwwvb9IyBQOH2n6+PrJK0a75Ivvag/teCpK7gXtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xd2LqewqHVeEW8iYmW2EpFND7aRCMNo5yla0OeyrOck=;
 b=E3t3GsH/qgd4eiaU8t7U5iwH2M3u1AcsIXmUp7l1sC46HvwtucCuf0TEZXUtJlgm67ax8KrM8fZDA7yOkIGignMlA/gGC6Lgpn4fU29lAZwk/dVPg8KI2aY6T8apAHDctoSu7xO6lgguGjTx7vRFZj6rwd3pzv3cdDuJTXU7FD1FkJj7Fu0UaN+yIpwWNc0Uxt5/wmql98P6oT2g/js9WQCkbnh8PEWKl2Vw789tJUgvs54y9bG6Ym9TX78Wk1ycmDi87/XG/ALnP1/b2BYUxS/af0esu4wjBEg/Aw2O7+h5aBvWY1DNAbeXpf2mxw1qILjesnVWLDvh04uLEd4duw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by DS7PR11MB6078.namprd11.prod.outlook.com (2603:10b6:8:86::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7633.37; Fri, 14 Jun 2024 03:05:57 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091%7]) with mapi id 15.20.7677.019; Fri, 14 Jun 2024
 03:05:57 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "eric.auger.pro@gmail.com" <eric.auger.pro@gmail.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>, "mst@redhat.com" <mst@redhat.com>,
 "jean-philippe@linaro.org" <jean-philippe@linaro.org>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>, "clg@redhat.com"
 <clg@redhat.com>, "yanghliu@redhat.com" <yanghliu@redhat.com>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>, "pbonzini@redhat.com"
 <pbonzini@redhat.com>, "berrange@redhat.com" <berrange@redhat.com>
Subject: RE: [PATCH v3 4/7] virtio-iommu: Compute host reserved regions
Thread-Topic: [PATCH v3 4/7] virtio-iommu: Compute host reserved regions
Thread-Index: AQHavXOLATA8uQqTv0Ke/++V4XR9aLHFdWQwgAAkdICAAPef0A==
Date: Fri, 14 Jun 2024 03:05:57 +0000
Message-ID: <SJ0PR11MB67442EC0B322352072F228B392C22@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20240613092359.847145-1-eric.auger@redhat.com>
 <20240613092359.847145-5-eric.auger@redhat.com>
 <SJ0PR11MB6744A08077F63B0E4535D97292C12@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <107a70a8-b75f-48bb-8df2-7d779b7e889a@redhat.com>
In-Reply-To: <107a70a8-b75f-48bb-8df2-7d779b7e889a@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|DS7PR11MB6078:EE_
x-ms-office365-filtering-correlation-id: b871ce0a-5cb0-43be-647e-08dc8c1ee9b8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230035|366011|376009|7416009|1800799019|38070700013; 
x-microsoft-antispam-message-info: =?utf-8?B?emgzdWdaZ2dyZ2t2SHpLTmFiTy9oUjk3dk9MUDZFODRRUlBObzdtVWZka3Rp?=
 =?utf-8?B?WUcyZEtyRTdDRnJYVWV4S1F6blMxZkF5MXp6L1hEcklybDl2MkJBNElDQWFT?=
 =?utf-8?B?SzRjK2UvbUljTjNybjBBREhuakVRMEc0cUM5cWluWmR0NUpoVEdXb1lIL2ZB?=
 =?utf-8?B?cWdlK05ubXBDelFBbXRyQVdKajlJMFpLL3REUHRIelZYSGJOaTNOV3BmZzVr?=
 =?utf-8?B?VnY1Wnl1V2hYWkdwVVU1VUJQV2tUNmxGeDNUeGFhYXYvRmRIVy9jc1FudDdm?=
 =?utf-8?B?ZUJSZmd3MHJmNFpENDVIZGR0SDNmSkpUK0t1QUlHKzMvQVlHcVIxU25pUWJB?=
 =?utf-8?B?TlRreldJT0haVk5UZE9nWjBZcE4zMWRlTWFCWkM3SkhYSTdBR09nYzE2Qk9p?=
 =?utf-8?B?UXF6WmFnUUJjdzRSTy9lbTNNZ0xJdDdVT3AvTDJqZ2ZldllWZCtoaFpLSXdF?=
 =?utf-8?B?RzVUdjZqa0pLOCszTENkaU8xQ0NTM05PNnVyOHZsQjlOaFppTjluUHRHdDZW?=
 =?utf-8?B?T0p5Wk5KbCszbXFES01DdTFKQWlqUEhEbXE4TStzN1FQSCsrZ01PaHh0Z2Rp?=
 =?utf-8?B?dGJOUEpXbTllZ2ZnWnhtWkdiUjQwbjhyMmtPc0pRbXNlU1J2alZ0VTNVYWUr?=
 =?utf-8?B?aTVDWHo0dGoxWU8xdE9yU05HUTNKNEdOQ0E0eVAzUjRUOU85SHFjNnlpR2NF?=
 =?utf-8?B?LzFURk1idi9vbjVWUjltWEx4dWhaUVFLbmNMZVdMZW5hR0gySVROVi8zZ3NS?=
 =?utf-8?B?cE50ZkxHUktUeU1ZRGR6clFGSXRoWGZ1NzBFOHR2bUxHY3ExcGt4bWZreTZt?=
 =?utf-8?B?ZWh6SnQ0em4zT1AvZnBRc1FwQzFodVZXTTM3ZmV0Y1VNQU82RUdWeEN4VVZY?=
 =?utf-8?B?bThmV2ZPcVZoaUlYWVAvZWJ3d3NaY3ZnQmZXekthbU1nNDNlWFl0ZE0zZDNS?=
 =?utf-8?B?SjBsQldUMkpTWDFmazRrMTdHb1cwNm41RmRPeko1TDk4S3JEdXgyQmVROHQy?=
 =?utf-8?B?UXVVZXVLZDlaVzZjVER2Y3oxaVEvZjdtcDAxZkdDVGJLbVNsSW4yU3psNFdG?=
 =?utf-8?B?cmphWm4rb3UvTGduTG9XMWJmZDQ3cnhVam1IQURDTENETjB3cENJRWJ6M1dw?=
 =?utf-8?B?d0FaMmRlNktYbXZ3YUxOTFVYQmlkdzdZSW9ycmMxbU9Tck1VbExOMmdKa0VI?=
 =?utf-8?B?amxqcGtNMGpGejd1TnlFakVKMzBPOWFGYVpLVHFaWFZCTS93aDBmT3h5eEV0?=
 =?utf-8?B?eVJJTWQzZFR0VzNucVZSVHlXQTdUWkVMdzBkTlRvd1RmM3JFS1p3cmVhZ3ZB?=
 =?utf-8?B?NHNPT3BVRXQvdW4veThOUXZLVndSRiswelNnTVV6QzZ0Y0JZaFpOaXRDV2x1?=
 =?utf-8?B?ZkFyZWhQWHRWUGVMZFQrRldPRTAvSkQ0MStMZ245U2JVZUwrbncvTzJ5TW5I?=
 =?utf-8?B?S0ViNldxOEFKV1RCcDRDbytuNmFHcnBFQmtxN080U3RpRlpoRzViNWZia001?=
 =?utf-8?B?Z3dNZm9mMTNySzduU0RVNjlMVTUxRU4yMmovNHl2UVUvSXAxNzRWWVZRTXN5?=
 =?utf-8?B?WmpnTWdqbWN1MC91cm5vL3R2alhDeFg0NnR6ZFhpQU1aNDZuSllBWWg3TVk5?=
 =?utf-8?B?RkZ3ZFRxNWtJU1BHNExubE9ZUXB5UE9Ta2tvazB4RmRWUWhtNXIwMWE1SGYx?=
 =?utf-8?B?bXpqUjByMU45anhaM3RqWDBzTmZrUzlTYW9FWUlqTjJuVzVxS2VQZlFLRGtk?=
 =?utf-8?B?bFdsYjRXVmJuNThQQXU3eS90QmxITVpXSjJId3BwSXNycW9vVUhNakRBYmpm?=
 =?utf-8?Q?+GxBQlDbjqnxuCX8d1a9aRqthL4oUSf5+fTEc=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230035)(366011)(376009)(7416009)(1800799019)(38070700013); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UllDZ0dmaWlETHlkaXpvQ1NzUytnR2lFbUVVSFBlS0FvOUdZeGVQOWR6MDJk?=
 =?utf-8?B?YWFtMjg1UUtSQStBcWlhZU9PRTlRdkV6Zk45OUJjWGhNWG4yWFQvZk9OUzE5?=
 =?utf-8?B?VDBzcW9lU2ZLL1pLNW9PeTNsOGh3YkpRd2RkaEZ1YzcvTG5pM0lNNWlNNlRS?=
 =?utf-8?B?OFFIYVdBMEEraThlSUpkVW85TmZqUjRyam9lakY4ejBuUU5UQzVnQ1lvQ3M5?=
 =?utf-8?B?c2dXSCs4dmxmNUZVcm5iNmZqNDJJSUN2a3QxWk14bXlQTjJrUjUyTml1Q2Zo?=
 =?utf-8?B?KzdOaVlLUFFQeUZITExSenE3bzVwVWFxbGdxSkQ5TkNZTnIzNU1GTW11OG15?=
 =?utf-8?B?c2FPZFZJb3pQcU05QlhsenRlK1hWVDBCR25taUpUVTBra2NwQ0lPWHBpT3gz?=
 =?utf-8?B?bjlMK2NpM3dWV2V2U042L3ZKanFoamFGZ2h4OWo4QUpVcGpzdU5GalMxM3Zx?=
 =?utf-8?B?dUZVQk5OOFpPdXFjaGd6MHh3amZVdW1aNXBITzB2TWFidWxTTWRTSFZqc09n?=
 =?utf-8?B?eVp5ZTlTdGhJeDc2L2hoRWFXZVh1Y3FueUxpcFhXVEJBNllNRTZ2ZUhQeCtx?=
 =?utf-8?B?Wk5RazJsaXVsSENaVC9GVFBwTDFMc2ttcUwybnFSQStXTEtSTEdnNEZXZDZO?=
 =?utf-8?B?eWdtZ25GdzVzejZFbXlwc1E3Mk5DMUErR1NWQm50aEVqR0w3Qkgzb2NUTUFK?=
 =?utf-8?B?OUVHV2MvUFVPNjZjL0xISS9BcHowNW1GT2haei9MNStEY0VaTDdneEVJV3ZK?=
 =?utf-8?B?cDQxYnNOV2NZYUlFQ1Zvay9lV2V4ZldvQkRESFNEN1dMSEpSVGdJMXp3Mzh3?=
 =?utf-8?B?YkRHR0pDdjZzRVpQeDQxT2ltakdzeE0wSkg1OXpKdWFwSkZVc3NiTUI5bE5F?=
 =?utf-8?B?czNxTktSUGI2YjhGcGx1d0R1R3crQSs5b2ZWbXJ4aGdNZXdIdWNNNU5aMndU?=
 =?utf-8?B?Nlpoa0dUblBYS3hnRTlkMERMOFpLU0RWWmlmZFZZVGQyRVBuT0lQaC9nWWRK?=
 =?utf-8?B?VDRiODFCTTdqcmR3RlpvU0JSMnY0dEpVbVJGT0Y0dXlRc1hvSUVHaVRVMUly?=
 =?utf-8?B?S25xaXNONWMyTzlJcnIzb2NNTGpsR2ZqWGNYSFNDZ1RwVVJTY3FlQzhTQWtT?=
 =?utf-8?B?cmFFVjFWb0lRelhjWnFSYUtoWVByZXE3MytXYTV4czFLRzh1cGx1Qzg0V0dV?=
 =?utf-8?B?SmhJbk94VXJiMlNQUEI4QVJuZDNTZEtBVTFMSExtTXlnY0hYU2ZIRmhadyth?=
 =?utf-8?B?VWcvbnRoQlFLOXBWVk9LZlNlcm14dHNic3JROUsrWTV6eUkycm9mT3pRTGJs?=
 =?utf-8?B?NXZIK2lKTVU4bmNRcnhYVy84c2F6UlVKU3JmV1hJR2cvUEVkVWNlcEs1alk3?=
 =?utf-8?B?N1JtVTZEdE1jRklvaytHajdSQ0UzUmR3UVYzWUVST1VMQXIzcFJxNXYvdDA0?=
 =?utf-8?B?S3RnVy8rOURKbHZNKzhSR2pmNkVHM0ErMytpZU5vQlpCR05KMzBxQkJNN3ls?=
 =?utf-8?B?aFgvRkJiWXlOcGlTME93a1NxZjlqNTQ5RDZnbzdENCt0SnFveFMrMEdYZm9B?=
 =?utf-8?B?R2IrMm1iV2ZJWnhBQld5VzVVTHBLTmg1cTIrZDRHZGtrTmFzVENKNytuRWZB?=
 =?utf-8?B?aVVBSm1WdVM3MTk5d3Z6cWhhaWExVVA3ZEpNRXFpR2toN3JsbndLUHNsZ2ND?=
 =?utf-8?B?eUxlbzVaV0c4S3h6SzBrYUpUTUdxUktsSXlvRmQreUNPRkRCODBZYXd2Zlcw?=
 =?utf-8?B?Rkx1b0xOaFQ5c1A5clFZQ1ZBZkJpYkZkd2Q2bFZRM2dVRUNnK1gxaUhlWDNZ?=
 =?utf-8?B?ZUxiVUYvTzFhbUpZY0tQamJKSGZOcThXYXY5SmcxU0dyOXBCN1VRZ2laUCsy?=
 =?utf-8?B?ZWJXTmVVc3IrK2FPb0w2M2pjNkdkMWNFVUhMTmFCSFZHLzJWemhaeHY4UWo5?=
 =?utf-8?B?QVFGUzNuMkk5ckR1eFhranJsbzJRb00yQTRGZUlNNHlEdm1HYmZpVnV3bmJF?=
 =?utf-8?B?ZHp1Z0d6WEM0Z2IrOHplOFNwcVJiUlZRam8zeVN1OFJnajVFZzlwdXdCSlRG?=
 =?utf-8?B?YWRtY0ROSFc1Z1p2WE1yUlVoRGkyckVGZ3FBQjBjdlBtWGc3dE9Cc1QwUFFE?=
 =?utf-8?Q?JNbY33i1wO05tJhLNQ0kTkveN?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b871ce0a-5cb0-43be-647e-08dc8c1ee9b8
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jun 2024 03:05:57.7599 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WZ8m2n9skVKJQ+8ctByaI5NtIBQN7PBWLXbGU8PDgnphMW7a62A2xIzbnaWu4zlaP0U6IYNraWxcFn3WCKYoVf0hrU7AwIElZjzAbXi6epU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6078
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.9;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.145,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IEVyaWMgQXVnZXIgPGVyaWMu
YXVnZXJAcmVkaGF0LmNvbT4NCj5TdWJqZWN0OiBSZTogW1BBVENIIHYzIDQvN10gdmlydGlvLWlv
bW11OiBDb21wdXRlIGhvc3QgcmVzZXJ2ZWQgcmVnaW9ucw0KPg0KPg0KPg0KPk9uIDYvMTMvMjQg
MTI6MDAsIER1YW4sIFpoZW56aG9uZyB3cm90ZToNCj4+IEhpIEVyaWMsDQo+Pg0KPj4+IC0tLS0t
T3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+Pj4gRnJvbTogRXJpYyBBdWdlciA8ZXJpYy5hdWdlckBy
ZWRoYXQuY29tPg0KPj4+IFN1YmplY3Q6IFtQQVRDSCB2MyA0LzddIHZpcnRpby1pb21tdTogQ29t
cHV0ZSBob3N0IHJlc2VydmVkIHJlZ2lvbnMNCj4+Pg0KPj4+IENvbXB1dGUgdGhlIGhvc3QgcmVz
ZXJ2ZWQgcmVnaW9ucyBpbiB2aXJ0aW9faW9tbXVfc2V0X2lvbW11X2RldmljZSgpLg0KPj4+IFRo
ZSB1c2FibGUgSU9WQSByZWdpb25zIGFyZSByZXRyaWV2ZWQgZnJvbSB0aGUgSE9TVElPTU1VRGV2
aWNlLg0KPj4+IFRoZSB2aXJ0aW9faW9tbXVfc2V0X2hvc3RfaW92YV9yYW5nZXMoKSBoZWxwZXIg
dHVybnMgdXNhYmxlIHJlZ2lvbnMNCj4+PiBpbnRvIGNvbXBsZW1lbnRhcnkgcmVzZXJ2ZWQgcmVn
aW9ucyB3aGlsZSB0ZXN0aW5nIHRoZSBpbmNsdXNpb24NCj4+PiBpbnRvIGV4aXN0aW5nIG9uZXMu
IHZpcnRpb19pb21tdV9zZXRfaG9zdF9pb3ZhX3JhbmdlcygpIHJldXNlIHRoZQ0KPj4+IGltcGxl
bWVudGF0aW9uIG9mIHZpcnRpb19pb21tdV9zZXRfaW92YV9yYW5nZXMoKSB3aGljaCB3aWxsIGJl
DQo+Pj4gcmVtb3ZlZCBpbiBzdWJzZXF1ZW50IHBhdGNoZXMuIHJlYnVpbGRfcmVzdl9yZWdpb25z
KCkgaXMganVzdCBtb3ZlZC4NCj4+Pg0KPj4+IFNpZ25lZC1vZmYtYnk6IEVyaWMgQXVnZXIgPGVy
aWMuYXVnZXJAcmVkaGF0LmNvbT4NCj4+Pg0KPj4+IC0tLQ0KPj4+DQo+Pj4gLSBhZGRlZCBnX2Fz
c2VydCghc2Rldi0+cHJvYmVfZG9uZSkNCj4+PiAtLS0NCj4+PiBody92aXJ0aW8vdmlydGlvLWlv
bW11LmMgfCAxNDYgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrLS0tLQ0KPi0tLS0NCj4+
PiAtDQo+Pj4gMSBmaWxlIGNoYW5nZWQsIDExMiBpbnNlcnRpb25zKCspLCAzNCBkZWxldGlvbnMo
LSkNCj4+Pg0KPj4+IGRpZmYgLS1naXQgYS9ody92aXJ0aW8vdmlydGlvLWlvbW11LmMgYi9ody92
aXJ0aW8vdmlydGlvLWlvbW11LmMNCj4+PiBpbmRleCBkYjg0MjU1NWM4Li4wNDQ3NGViZDc0IDEw
MDY0NA0KPj4+IC0tLSBhL2h3L3ZpcnRpby92aXJ0aW8taW9tbXUuYw0KPj4+ICsrKyBiL2h3L3Zp
cnRpby92aXJ0aW8taW9tbXUuYw0KPj4+IEBAIC00OTgsMTIgKzQ5OCwxMDkgQEAgZ2V0X2hvc3Rf
aW9tbXVfZGV2aWNlKFZpcnRJT0lPTU1VDQo+Pj4gKnZpb21tdSwgUENJQnVzICpidXMsIGludCBk
ZXZmbikgew0KPj4+ICAgICByZXR1cm4gZ19oYXNoX3RhYmxlX2xvb2t1cCh2aW9tbXUtPmhvc3Rf
aW9tbXVfZGV2aWNlcywgJmtleSk7DQo+Pj4gfQ0KPj4+DQo+Pj4gKy8qKg0KPj4+ICsgKiByZWJ1
aWxkX3Jlc3ZfcmVnaW9uczogcmVidWlsZCByZXN2IHJlZ2lvbnMgd2l0aCBib3RoIHRoZQ0KPj4+
ICsgKiBpbmZvIG9mIGhvc3QgcmVzdiByYW5nZXMgYW5kIHByb3BlcnR5IHNldCByZXN2IHJhbmdl
cw0KPj4+ICsgKi8NCj4+PiArc3RhdGljIGludCByZWJ1aWxkX3Jlc3ZfcmVnaW9ucyhJT01NVURl
dmljZSAqc2RldikNCj4+PiArew0KPj4+ICsgICAgR0xpc3QgKmw7DQo+Pj4gKyAgICBpbnQgaSA9
IDA7DQo+Pj4gKw0KPj4+ICsgICAgLyogZnJlZSB0aGUgZXhpc3RpbmcgbGlzdCBhbmQgcmVidWls
ZCBpdCBmcm9tIHNjcmF0Y2ggKi8NCj4+PiArICAgIGdfbGlzdF9mcmVlX2Z1bGwoc2Rldi0+cmVz
dl9yZWdpb25zLCBnX2ZyZWUpOw0KPj4+ICsgICAgc2Rldi0+cmVzdl9yZWdpb25zID0gTlVMTDsN
Cj4+PiArDQo+Pj4gKyAgICAvKiBGaXJzdCBhZGQgaG9zdCByZXNlcnZlZCByZWdpb25zIGlmIGFu
eSwgYWxsIHRhZ2dlZCBhcyBSRVNFUlZFRCAqLw0KPj4+ICsgICAgZm9yIChsID0gc2Rldi0+aG9z
dF9yZXN2X3JhbmdlczsgbDsgbCA9IGwtPm5leHQpIHsNCj4+PiArICAgICAgICBSZXNlcnZlZFJl
Z2lvbiAqcmVnID0gZ19uZXcwKFJlc2VydmVkUmVnaW9uLCAxKTsNCj4+PiArICAgICAgICBSYW5n
ZSAqciA9IChSYW5nZSAqKWwtPmRhdGE7DQo+Pj4gKw0KPj4+ICsgICAgICAgIHJlZy0+dHlwZSA9
IFZJUlRJT19JT01NVV9SRVNWX01FTV9UX1JFU0VSVkVEOw0KPj4+ICsgICAgICAgIHJhbmdlX3Nl
dF9ib3VuZHMoJnJlZy0+cmFuZ2UsIHJhbmdlX2xvYihyKSwgcmFuZ2VfdXBiKHIpKTsNCj4+PiAr
ICAgICAgICBzZGV2LT5yZXN2X3JlZ2lvbnMgPSByZXN2X3JlZ2lvbl9saXN0X2luc2VydChzZGV2
LT5yZXN2X3JlZ2lvbnMsDQo+cmVnKTsNCj4+PiArICAgICAgICB0cmFjZV92aXJ0aW9faW9tbXVf
aG9zdF9yZXN2X3JlZ2lvbnMoc2Rldi0NCj4+Pj4gaW9tbXVfbXIucGFyZW50X29iai5uYW1lLCBp
LA0KPj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICByYW5n
ZV9sb2IoJnJlZy0+cmFuZ2UpLA0KPj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICByYW5nZV91cGIoJnJlZy0+cmFuZ2UpKTsNCj4+PiArICAgICAgICBpKys7
DQo+Pj4gKyAgICB9DQo+Pj4gKyAgICAvKg0KPj4+ICsgICAgICogdGhlbiBhZGQgaGlnaGVyIHBy
aW9yaXR5IHJlc2VydmVkIHJlZ2lvbnMgc2V0IGJ5IHRoZSBtYWNoaW5lDQo+Pj4gKyAgICAgKiB0
aHJvdWdoIHByb3BlcnRpZXMNCj4+PiArICAgICAqLw0KPj4+ICsgICAgYWRkX3Byb3BfcmVzdl9y
ZWdpb25zKHNkZXYpOw0KPj4+ICsgICAgcmV0dXJuIDA7DQo+Pj4gK30NCj4+PiArDQo+Pj4gK3N0
YXRpYyBpbnQgdmlydGlvX2lvbW11X3NldF9ob3N0X2lvdmFfcmFuZ2VzKFZpcnRJT0lPTU1VICpz
LCBQQ0lCdXMNCj4+PiAqYnVzLA0KPj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICBpbnQgZGV2Zm4sIEdMaXN0ICppb3ZhX3JhbmdlcywNCj4+PiArICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgRXJyb3IgKiplcnJwKQ0KPj4+
ICt7DQo+Pj4gKyAgICBJT01NVVBjaUJ1cyAqc2J1cyA9IGdfaGFzaF90YWJsZV9sb29rdXAocy0+
YXNfYnlfYnVzcHRyLCBidXMpOw0KPj4gSGVyZSB0aGUgYnVzL2RldmZuIHBhcmFtZXRlcnMgYXJl
IHJlYWwgZGV2aWNlIEJERiBub3QgYWxpYXNlZCBvbmUsDQo+PiBCdXQgdXNlZCB0byBpbmRleCBz
LT5hc19ieV9idXNwdHIgd2hpY2ggZXhwZWN0IGFsaWFzZWQgYnVzL2RldmZuLg0KPj4NCj4+IERv
IHdlIG5lZWQgYSB0cmFuc2xhdGlvbiBvZiBidXMvZGV2Zm4/DQo+DQo+SHVtIHRoYXQncyBhIGdv
b2QgcG9pbnQgYWN0dWFsbHkuIEkgbmVlZCB0byBmdXJ0aGVyIHN0dWR5IHRoYXQuIHRoYXQncw0K
Pm5vdCBlYXN5IHRvIHRyYW5zbGF0ZSwgaXMgaXQ/DQoNClllcywgbWF5IG5lZWQgYSBwYXRoIHRv
IGNhbGwgaW50byBwY2lfZGV2aWNlX2dldF9pb21tdV9idXNfZGV2Zm4oKS4NCk1heWJlIGEgbmV3
IEhvc3RJT01NVURldmljZSBjYWxsYmFjay4NCg0KPg0KPk5vdyBJIGFtIG5vdCB0b3RhbGx5IHN1
cmUgd2h5IHdlIGRvbid0IHVzZSB0aGUgYWxpYXMgYXMgd2VsbCBmb3INCj5Ib3N0SU9NTVVEZXZp
Y2VzIG9yIGF0IGxlYXN0IHN0b3JlIHRoZSBhbGlhc2VkIGJkZi4NCg0KQmVjYXVzZSB3ZSBuZWVk
IHRvIHN0b3JlIEhvc3RJT01NVURldmljZSBpbiB2SU9NTVUgaW4gcmVhbCBiZGYgZ3JhbnVsYXJp
dHksDQpOb3QgYWxpYXNlZCBiZGYgZ3JhbnVsYXJpdHkuIFZpcnR1YWwgdnRkIGNhbGxzIFZGSU8g
ZGV2aWNlIHVBUEkgb24gcmVhbCBkZXZpY2Ugbm90DQp0aGUgYWxpYXNlZCBkZXZpY2UsIGkuZS4s
IFZGSU9fREVWSUNFX1tBVFRBQ0h8REVUQUNIXV9JT01NVUZEX1BULg0KDQpJIGFsc28gaGF2ZSBh
IHF1ZXN0aW9uLCBjb3VsZCB3ZSBkZWZpbmUgaG9zdF9yZXN2X3JhbmdlcyBpbiBWaXJ0aW9Ib3N0
SU9NTVVEZXZpY2UNCnRvIGF2b2lkIHRyYW5zbGF0aW9uPw0KDQpUaGFua3MNClpoZW56aG9uZw0K
DQo+DQo+VGhhbmtzDQo+DQo+RXJpYw0KPj4NCj4+IFRoYW5rcw0KPj4gWmhlbnpob25nDQo+Pg0K
Pj4+ICsgICAgSU9NTVVEZXZpY2UgKnNkZXY7DQo+Pj4gKyAgICBHTGlzdCAqY3VycmVudF9yYW5n
ZXM7DQo+Pj4gKyAgICBHTGlzdCAqbCwgKnRtcCwgKm5ld19yYW5nZXMgPSBOVUxMOw0KPj4+ICsg
ICAgaW50IHJldCA9IC1FSU5WQUw7DQo+Pj4gKw0KPj4+ICsgICAgaWYgKCFzYnVzKSB7DQo+Pj4g
KyAgICAgICAgZXJyb3JfcmVwb3J0KCIlcyBubyBzYnVzIiwgX19mdW5jX18pOw0KPj4+ICsgICAg
fQ0KPj4+ICsNCj4+PiArICAgIHNkZXYgPSBzYnVzLT5wYmRldltkZXZmbl07DQo+Pj4gKw0KPj4+
ICsgICAgY3VycmVudF9yYW5nZXMgPSBzZGV2LT5ob3N0X3Jlc3ZfcmFuZ2VzOw0KPj4+ICsNCj4+
PiArICAgIGdfYXNzZXJ0KCFzZGV2LT5wcm9iZV9kb25lKTsNCj4+PiArDQo+Pj4gKyAgICAvKiBj
aGVjayB0aGF0IGVhY2ggbmV3IHJlc3YgcmVnaW9uIGlzIGluY2x1ZGVkIGluIGFuIGV4aXN0aW5n
IG9uZSAqLw0KPj4+ICsgICAgaWYgKHNkZXYtPmhvc3RfcmVzdl9yYW5nZXMpIHsNCj4+PiArICAg
ICAgICByYW5nZV9pbnZlcnNlX2FycmF5KGlvdmFfcmFuZ2VzLA0KPj4+ICsgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgJm5ld19yYW5nZXMsDQo+Pj4gKyAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAwLCBVSU5UNjRfTUFYKTsNCj4+PiArDQo+Pj4gKyAgICAgICAgZm9yICh0bXAgPSBuZXdf
cmFuZ2VzOyB0bXA7IHRtcCA9IHRtcC0+bmV4dCkgew0KPj4+ICsgICAgICAgICAgICBSYW5nZSAq
bmV3ciA9IChSYW5nZSAqKXRtcC0+ZGF0YTsNCj4+PiArICAgICAgICAgICAgYm9vbCBpbmNsdWRl
ZCA9IGZhbHNlOw0KPj4+ICsNCj4+PiArICAgICAgICAgICAgZm9yIChsID0gY3VycmVudF9yYW5n
ZXM7IGw7IGwgPSBsLT5uZXh0KSB7DQo+Pj4gKyAgICAgICAgICAgICAgICBSYW5nZSAqIHIgPSAo
UmFuZ2UgKilsLT5kYXRhOw0KPj4+ICsNCj4+PiArICAgICAgICAgICAgICAgIGlmIChyYW5nZV9j
b250YWluc19yYW5nZShyLCBuZXdyKSkgew0KPj4+ICsgICAgICAgICAgICAgICAgICAgIGluY2x1
ZGVkID0gdHJ1ZTsNCj4+PiArICAgICAgICAgICAgICAgICAgICBicmVhazsNCj4+PiArICAgICAg
ICAgICAgICAgIH0NCj4+PiArICAgICAgICAgICAgfQ0KPj4+ICsgICAgICAgICAgICBpZiAoIWlu
Y2x1ZGVkKSB7DQo+Pj4gKyAgICAgICAgICAgICAgICBnb3RvIGVycm9yOw0KPj4+ICsgICAgICAg
ICAgICB9DQo+Pj4gKyAgICAgICAgfQ0KPj4+ICsgICAgICAgIC8qIGFsbCBuZXcgcmVzZXJ2ZWQg
cmFuZ2VzIGFyZSBpbmNsdWRlZCBpbiBleGlzdGluZyBvbmVzICovDQo+Pj4gKyAgICAgICAgcmV0
ID0gMDsNCj4+PiArICAgICAgICBnb3RvIG91dDsNCj4+PiArICAgIH0NCj4+PiArDQo+Pj4gKyAg
ICByYW5nZV9pbnZlcnNlX2FycmF5KGlvdmFfcmFuZ2VzLA0KPj4+ICsgICAgICAgICAgICAgICAg
ICAgICAgICAmc2Rldi0+aG9zdF9yZXN2X3JhbmdlcywNCj4+PiArICAgICAgICAgICAgICAgICAg
ICAgICAgMCwgVUlOVDY0X01BWCk7DQo+Pj4gKyAgICByZWJ1aWxkX3Jlc3ZfcmVnaW9ucyhzZGV2
KTsNCj4+PiArDQo+Pj4gKyAgICByZXR1cm4gMDsNCj4+PiArZXJyb3I6DQo+Pj4gKyAgICBlcnJv
cl9zZXRnKGVycnAsICIlcyBDb25mbGljdGluZyBob3N0IHJlc2VydmVkIHJhbmdlcyBzZXQhIiwN
Cj4+PiArICAgICAgICAgICAgICAgX19mdW5jX18pOw0KPj4+ICtvdXQ6DQo+Pj4gKyAgICBnX2xp
c3RfZnJlZV9mdWxsKG5ld19yYW5nZXMsIGdfZnJlZSk7DQo+Pj4gKyAgICByZXR1cm4gcmV0Ow0K
Pj4+ICt9DQo+Pj4gKw0KPj4+IHN0YXRpYyBib29sIHZpcnRpb19pb21tdV9zZXRfaW9tbXVfZGV2
aWNlKFBDSUJ1cyAqYnVzLCB2b2lkICpvcGFxdWUsDQo+Pj4gaW50IGRldmZuLA0KPj4+ICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIEhvc3RJT01NVURldmljZSAqaGlv
ZCwgRXJyb3IgKiplcnJwKQ0KPj4+IHsNCj4+PiAgICAgVmlydElPSU9NTVUgKnZpb21tdSA9IG9w
YXF1ZTsNCj4+PiAgICAgVmlydGlvSG9zdElPTU1VRGV2aWNlICp2aGlvZDsNCj4+PiArICAgIEhv
c3RJT01NVURldmljZUNsYXNzICpoaW9kYyA9DQo+Pj4gSE9TVF9JT01NVV9ERVZJQ0VfR0VUX0NM
QVNTKGhpb2QpOw0KPj4+ICAgICBzdHJ1Y3QgaGlvZF9rZXkgKm5ld19rZXk7DQo+Pj4gKyAgICBH
TGlzdCAqaG9zdF9pb3ZhX3JhbmdlcyA9IE5VTEw7DQo+Pj4NCj4+PiAgICAgYXNzZXJ0KGhpb2Qp
Ow0KPj4+DQo+Pj4gQEAgLTUxMyw2ICs2MTAsMjAgQEAgc3RhdGljIGJvb2wNCj4+PiB2aXJ0aW9f
aW9tbXVfc2V0X2lvbW11X2RldmljZShQQ0lCdXMgKmJ1cywgdm9pZCAqb3BhcXVlLCBpbnQgZGV2
Zm4sDQo+Pj4gICAgICAgICByZXR1cm4gZmFsc2U7DQo+Pj4gICAgIH0NCj4+Pg0KPj4+ICsgICAg
aWYgKGhpb2RjLT5nZXRfaW92YV9yYW5nZXMpIHsNCj4+PiArICAgICAgICBpbnQgcmV0Ow0KPj4+
ICsgICAgICAgIGhvc3RfaW92YV9yYW5nZXMgPSBoaW9kYy0+Z2V0X2lvdmFfcmFuZ2VzKGhpb2Qs
IGVycnApOw0KPj4+ICsgICAgICAgIGlmICghaG9zdF9pb3ZhX3Jhbmdlcykgew0KPj4+ICsgICAg
ICAgICAgICByZXR1cm4gdHJ1ZTsgLyogc29tZSBvbGQga2VybmVscyBtYXkgbm90IHN1cHBvcnQg
dGhhdCBjYXBhYmlsaXR5DQo+Ki8NCj4+PiArICAgICAgICB9DQo+Pj4gKyAgICAgICAgcmV0ID0g
dmlydGlvX2lvbW11X3NldF9ob3N0X2lvdmFfcmFuZ2VzKHZpb21tdSwgYnVzLCBkZXZmbiwNCj4+
PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgaG9zdF9p
b3ZhX3JhbmdlcywgZXJycCk7DQo+Pj4gKyAgICAgICAgaWYgKHJldCkgew0KPj4+ICsgICAgICAg
ICAgICBnX2xpc3RfZnJlZV9mdWxsKGhvc3RfaW92YV9yYW5nZXMsIGdfZnJlZSk7DQo+Pj4gKyAg
ICAgICAgICAgIHJldHVybiBmYWxzZTsNCj4+PiArICAgICAgICB9DQo+Pj4gKyAgICB9DQo+Pj4g
Kw0KPj4+ICAgICB2aGlvZCA9IGdfbWFsbG9jMChzaXplb2YoVmlydGlvSG9zdElPTU1VRGV2aWNl
KSk7DQo+Pj4gICAgIHZoaW9kLT5idXMgPSBidXM7DQo+Pj4gICAgIHZoaW9kLT5kZXZmbiA9ICh1
aW50OF90KWRldmZuOw0KPj4+IEBAIC01MjUsNiArNjM2LDcgQEAgc3RhdGljIGJvb2wNCj4+PiB2
aXJ0aW9faW9tbXVfc2V0X2lvbW11X2RldmljZShQQ0lCdXMgKmJ1cywgdm9pZCAqb3BhcXVlLCBp
bnQgZGV2Zm4sDQo+Pj4NCj4+PiAgICAgb2JqZWN0X3JlZihoaW9kKTsNCj4+PiAgICAgZ19oYXNo
X3RhYmxlX2luc2VydCh2aW9tbXUtPmhvc3RfaW9tbXVfZGV2aWNlcywgbmV3X2tleSwgdmhpb2Qp
Ow0KPj4+ICsgICAgZ19saXN0X2ZyZWVfZnVsbChob3N0X2lvdmFfcmFuZ2VzLCBnX2ZyZWUpOw0K
Pj4+DQo+Pj4gICAgIHJldHVybiB0cnVlOw0KPj4+IH0NCj4+PiBAQCAtMTI0Niw0MCArMTM1OCw2
IEBAIHN0YXRpYyBpbnQNCj4+PiB2aXJ0aW9faW9tbXVfc2V0X3BhZ2Vfc2l6ZV9tYXNrKElPTU1V
TWVtb3J5UmVnaW9uICptciwNCj4+PiAgICAgcmV0dXJuIDA7DQo+Pj4gfQ0KPj4+DQo+Pj4gLS8q
Kg0KPj4+IC0gKiByZWJ1aWxkX3Jlc3ZfcmVnaW9uczogcmVidWlsZCByZXN2IHJlZ2lvbnMgd2l0
aCBib3RoIHRoZQ0KPj4+IC0gKiBpbmZvIG9mIGhvc3QgcmVzdiByYW5nZXMgYW5kIHByb3BlcnR5
IHNldCByZXN2IHJhbmdlcw0KPj4+IC0gKi8NCj4+PiAtc3RhdGljIGludCByZWJ1aWxkX3Jlc3Zf
cmVnaW9ucyhJT01NVURldmljZSAqc2RldikNCj4+PiAtew0KPj4+IC0gICAgR0xpc3QgKmw7DQo+
Pj4gLSAgICBpbnQgaSA9IDA7DQo+Pj4gLQ0KPj4+IC0gICAgLyogZnJlZSB0aGUgZXhpc3Rpbmcg
bGlzdCBhbmQgcmVidWlsZCBpdCBmcm9tIHNjcmF0Y2ggKi8NCj4+PiAtICAgIGdfbGlzdF9mcmVl
X2Z1bGwoc2Rldi0+cmVzdl9yZWdpb25zLCBnX2ZyZWUpOw0KPj4+IC0gICAgc2Rldi0+cmVzdl9y
ZWdpb25zID0gTlVMTDsNCj4+PiAtDQo+Pj4gLSAgICAvKiBGaXJzdCBhZGQgaG9zdCByZXNlcnZl
ZCByZWdpb25zIGlmIGFueSwgYWxsIHRhZ2dlZCBhcyBSRVNFUlZFRCAqLw0KPj4+IC0gICAgZm9y
IChsID0gc2Rldi0+aG9zdF9yZXN2X3JhbmdlczsgbDsgbCA9IGwtPm5leHQpIHsNCj4+PiAtICAg
ICAgICBSZXNlcnZlZFJlZ2lvbiAqcmVnID0gZ19uZXcwKFJlc2VydmVkUmVnaW9uLCAxKTsNCj4+
PiAtICAgICAgICBSYW5nZSAqciA9IChSYW5nZSAqKWwtPmRhdGE7DQo+Pj4gLQ0KPj4+IC0gICAg
ICAgIHJlZy0+dHlwZSA9IFZJUlRJT19JT01NVV9SRVNWX01FTV9UX1JFU0VSVkVEOw0KPj4+IC0g
ICAgICAgIHJhbmdlX3NldF9ib3VuZHMoJnJlZy0+cmFuZ2UsIHJhbmdlX2xvYihyKSwgcmFuZ2Vf
dXBiKHIpKTsNCj4+PiAtICAgICAgICBzZGV2LT5yZXN2X3JlZ2lvbnMgPSByZXN2X3JlZ2lvbl9s
aXN0X2luc2VydChzZGV2LT5yZXN2X3JlZ2lvbnMsDQo+cmVnKTsNCj4+PiAtICAgICAgICB0cmFj
ZV92aXJ0aW9faW9tbXVfaG9zdF9yZXN2X3JlZ2lvbnMoc2Rldi0NCj4+Pj4gaW9tbXVfbXIucGFy
ZW50X29iai5uYW1lLCBpLA0KPj4+IC0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICByYW5nZV9sb2IoJnJlZy0+cmFuZ2UpLA0KPj4+IC0gICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICByYW5nZV91cGIoJnJlZy0+cmFuZ2UpKTsNCj4+
PiAtICAgICAgICBpKys7DQo+Pj4gLSAgICB9DQo+Pj4gLSAgICAvKg0KPj4+IC0gICAgICogdGhl
biBhZGQgaGlnaGVyIHByaW9yaXR5IHJlc2VydmVkIHJlZ2lvbnMgc2V0IGJ5IHRoZSBtYWNoaW5l
DQo+Pj4gLSAgICAgKiB0aHJvdWdoIHByb3BlcnRpZXMNCj4+PiAtICAgICAqLw0KPj4+IC0gICAg
YWRkX3Byb3BfcmVzdl9yZWdpb25zKHNkZXYpOw0KPj4+IC0gICAgcmV0dXJuIDA7DQo+Pj4gLX0N
Cj4+PiAtDQo+Pj4gLyoqDQo+Pj4gICogdmlydGlvX2lvbW11X3NldF9pb3ZhX3JhbmdlczogQ29u
dmV5cyB0aGUgdXNhYmxlIElPVkEgcmFuZ2VzDQo+Pj4gICoNCj4+PiAtLQ0KPj4+IDIuNDEuMA0K
DQo=

