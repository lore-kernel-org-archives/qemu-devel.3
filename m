Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E57BD1CDA1
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2024 07:14:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t395A-0004Rg-Cx; Tue, 22 Oct 2024 03:13:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1t3958-0004RP-9T
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 03:13:30 -0400
Received: from mgamail.intel.com ([198.175.65.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1t3955-0000WX-4u
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 03:13:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1729581208; x=1761117208;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=QFNSxu+u0arwutM0vERNc3BPvQZY7ai0Ry/fQIiJEC4=;
 b=nVwkfmlHsBEO6Z4EpQCsQoOz1WrpPkX/NDH/n3IUyae2+dTNbPdMwOoO
 BlaiRgLuXaNHs8qp8BeLNXgWU+yR2/xxa/Pn5pxrsJ8V4/na1NODqHVWA
 uf8N/UZDPz95K6nag9x6HJB0yb7HWhJToVhrc05zxk3Dnf/88GYNt4j1T
 No3WgZy7AZ2HwYeiOElQuebdbAUTBhmmeT2jYuUdd+usjamol3faYb/hc
 4Ht5zSf+JqrvXWIbGU4A/gABRS/RMu/elkF94ArwXDDmKb0Mogw5VqZnG
 ylJQfoIWtJlNUJPmNKZMbc5ULPxpsjElHAJ+oVaelPYJJ0tUItrpgxcaZ w==;
X-CSE-ConnectionGUID: pT9bLry8SLqk0oUyTc4cbg==
X-CSE-MsgGUID: Bh4RSdHoQX2xE2eOBmhdwQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="28974578"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; d="scan'208";a="28974578"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Oct 2024 00:13:23 -0700
X-CSE-ConnectionGUID: g8Xu24DhS6GM1LxnDY6pZw==
X-CSE-MsgGUID: mg9vnyPGR8SMTzykwVCFJg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,222,1725346800"; d="scan'208";a="80131520"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
 by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 22 Oct 2024 00:13:22 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 22 Oct 2024 00:13:21 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 22 Oct 2024 00:13:21 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.48) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 22 Oct 2024 00:13:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ghZxrWJJ0DgXHBKbdsX0w1OLVmOCA+1iTCtSq/WyCODxNcm6xu1FH4kEacsx770AraRu4H7TiuXnzHrxpETfPBTHc+GPux1NpNaSsIa8w+y9iUQIKsrUN7Ir50dUtUQjxQbWgyHFUtqKn2zcr16NYgRHvx+vcbxezpED4t4H71fuIktUlJBIACuounTLTqQyNfpc4LXZKAv4n0repx6KaO9s8AAQ//YR0Ymf5SXk1NirCo5V9GmAFsyBsWg7/m/8srPAzJAjlumKstzsdWib355FwNElovSR2qMoG3Zxj9qvJnbfazQabC70vy+AMh7KITE0zEkUSBd82sl/MGS9jQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QFNSxu+u0arwutM0vERNc3BPvQZY7ai0Ry/fQIiJEC4=;
 b=WHlXM/RRj3w0lLlt/XrAyHejtYo8yiWba2MF1HFzHgR7qB6xXAW4uctFyY5rW1LGbNkR3hHE2SbXw/3rD8op3t5m4UaXZKffoYJKNvRLHEW6X7Uywd/aAp3ahF2eB9oDM0um7gvtAEcFhxueNT7rZuPqPtbav8JajpafgWIK9seuV3P5WsgQAHq5g+e1RHP+fNHz63ffmIZu9m9XnHmJjh9t8dWOnsiFGhdstoNaoT6i0bVzBljOeELKscVdxIGcrCMVtgLCT34Nu3qZGyjo/W8qcepzpB4Fel2ZbvifJjWVFlu4fos8g+d2onVaE1oi5csV4/zEgpiKTxA6PmKVtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by SJ0PR11MB4813.namprd11.prod.outlook.com (2603:10b6:a03:2df::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.16; Tue, 22 Oct
 2024 07:13:19 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091%5]) with mapi id 15.20.8069.027; Tue, 22 Oct 2024
 07:13:19 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: Jason Wang <jasowang@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "Peng, Chao P" <chao.p.peng@intel.com>, "Liu, Yi L"
 <yi.l.liu@intel.com>, =?utf-8?B?Q2zDqW1lbnQgTWF0aGlldS0tRHJpZg==?=
 <clement.mathieu--drif@eviden.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, Eduardo Habkost
 <eduardo@habkost.net>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: RE: [PATCH v2] intel_iommu: Introduce property "x-stale-tm" to
 control Transient Mapping (TM) field
Thread-Topic: [PATCH v2] intel_iommu: Introduce property "x-stale-tm" to
 control Transient Mapping (TM) field
Thread-Index: AQHbGuoFLuS8TSFiM0mt8z0EXrA2XrKKj32AgAAK/ZCABDyygIADkkKg
Date: Tue, 22 Oct 2024 07:13:19 +0000
Message-ID: <SJ0PR11MB674479C27E0C19F64699F7DA924C2@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20241010075354.3582221-1-zhenzhong.duan@intel.com>
 <CACGkMEt+M=nEiivOM4OPm6jxe9ygDm-41nDxQUCBMskETFAO8Q@mail.gmail.com>
 <SJ0PR11MB6744C0B9DE8D32354242099992472@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <20241019202416-mutt-send-email-mst@kernel.org>
In-Reply-To: <20241019202416-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|SJ0PR11MB4813:EE_
x-ms-office365-filtering-correlation-id: d443aa5d-f0bb-4438-104f-08dcf26901c4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?QUR3VEljMytDeUFibkN5SFZVUnp0cWI5eHhaVnBOZTBGTTZZR3pWNVR5N1Jy?=
 =?utf-8?B?MFpNZ0psenFTb2ttd2lrVklZdXZQQzFaUVdYWmNmMUFBSlI0bDhuSWo4V0pn?=
 =?utf-8?B?a2ZEYjlhV0pReFdJbnNuQWRJUEg3bDJnaTJqcWxmZWpkSkM3QU9SRzR2cElE?=
 =?utf-8?B?VWFMNi9zK0xaQVlaOTZXenhycFBYaklSbG0vbmxOREFHcXdRN0I2MGxkS1Q5?=
 =?utf-8?B?c0pKRmd4aUpsc3llQVVMeHl3L1lpa2Q2VnZ2MDZyNFZnNElCcy8zNUt4eDBC?=
 =?utf-8?B?b1o4WC9MRlpXMml2TzZ6Sm9mZkNlTkp4QjhQUk14MVB2M1E0dDJxV2R0MXJp?=
 =?utf-8?B?eVc2YTM0eEFWd3A2QVl5cDgyWURPS3lOeWZXR0JpYUE4cWpmZ29aaURVeXp6?=
 =?utf-8?B?WnY0Ym5mV2h3dkNkbE4xK1UrODBPeDQrUzFJRS9qWHRnSEh1Nm9vdG5Zb0w2?=
 =?utf-8?B?MG0xNGlUSURrempaYTZTL2NaNkVTQUxwZmkrU2pQbSs4YmhZRW5aTGhQeFhW?=
 =?utf-8?B?VjcwNHhCWlFxcDJCODVsQXNvZFNqbmltc2s2TThTZ0pSWmorMThoS0MzaVBr?=
 =?utf-8?B?aDRDUmV2RkM4UkVhK2FNOURNN09wc1kxdE5Kd2thMWo4U05NN3c1VE00NU42?=
 =?utf-8?B?YkdFcnFGWVpkd1FxNlFodWlQNDRFMzh5ZFRDUkh1VDlGdEoxMnZEZElNTTN5?=
 =?utf-8?B?aThsUXlmNDNSamUxQmE4NHdlWW9LUVpiWHI5NWNBcE5Ba3MrS1U0cjlCTjJX?=
 =?utf-8?B?QUhqUEZXMXRqdUhKYkpuWGwxcDZocExPU2dnV1VHaGZvZUFXMjFmOFFzUGNO?=
 =?utf-8?B?TnpkTGxxQU45TVFCK3RkTFJkelRLSmo5NHA4Rm9FSzhlYVVMc01FaDdKUWdw?=
 =?utf-8?B?WVJSWDJzQjZmZ05rVk5WTmxkRUVsalR6MWNodHg1SEVBVjY5aERNZ2JoRjdM?=
 =?utf-8?B?c2pSSWx6TnB1NDd5bmI1RFZHcVNNRDR3SEFXbSszV0NBU0taWDR5ZVVKVDB5?=
 =?utf-8?B?R2cxM3A5OFhjWkl0bUI5eFZIdHNiZDVWQTJ6SzcvQXVKYytBcmZZVFV4Z25O?=
 =?utf-8?B?UksxeUd2RCtjeStDTEczc2NtZTZTZHk5QmIwNXRyenBPeEpGcWJiYmRhc3hn?=
 =?utf-8?B?RlkyNnJ0RVZnYkVYdS81Nk5lU1RIeDh1RzNZUklYaWJpdUd2UzM2Rm42Mmtu?=
 =?utf-8?B?UXV2bnZ2UGxVd0pLcDYvRFBEamRJZllocjh4MytzRWtaelpJRHJPTWVvK2pM?=
 =?utf-8?B?SlJhWStxa2NsUDdxVDg5M0ovQUdIbWRGTHUxV1lpMXUzMVRqQmVDUHlmalRD?=
 =?utf-8?B?RlhhQnAvRnBxeTJHUWVlVWlYMnVpK0hjYVpDQmZYdDNaazdFYTljVWxJaXJY?=
 =?utf-8?B?czNFd3R1bjlFdk9sZzdzQVJVMW9HRmRXTTMwNldva3d0amVyRFBBTDdlQnVp?=
 =?utf-8?B?bnZRREJvbGpGbENBVnh1cnE4ME16MjdvcUdjVXRxdXIvdzVPV3l3Yi9JSnRa?=
 =?utf-8?B?RFpmd0tMMXBNT2d4b3ZzRGxzQmdrTVg2cUl0cmx1aW5FNXRWdnlwZmpvb1Az?=
 =?utf-8?B?ai9JaGpNSzVrWFk4LzB0RTVldkRDUWNXd0F1ZnUycVR5ZElLUHVwYTZQOHhX?=
 =?utf-8?B?c3VEdWkwY2l3RXB4R0I2U0ZsRXc0bTJPYUZGcWc2SndZbHV0Mm9uZnBqUEE2?=
 =?utf-8?B?T21seTc0THFTeDdrZml1aktYWm5INEtsQnFnay9FQ240dVdQaUZZa0wxL1E4?=
 =?utf-8?B?Q0w5WlNuOS9mZ3NBcHBHM3lNOE96M1JEZzE3WFhHNk11YzNGcmFCc3ZFQXds?=
 =?utf-8?Q?G7LRJBgLGD5r1ckfkuRBqv2hhU4WPhEqdyFjE=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UXJQUndyQWI2ajNqaFI1M0hPQ3BYZWxMUlJUL2tRQ0R6UjJ1M3g1N01xMnpE?=
 =?utf-8?B?ZWx6Y3JVazJ3NGVzY3ZwUFFSU0ZMeWlCc1VJdExrMStFTGVFa2d2d0VjWUlh?=
 =?utf-8?B?SVZLaExBTmQyejQ3M2RhL0pYdHFwcUdoeStkd2w2WVBKaWhDSU1RREpnTEpQ?=
 =?utf-8?B?c2R0YWZTZFRDMTlZcFNobzdBaHhmS29UcDduMTdlYU1pQkhzN3AwdzU5TUhD?=
 =?utf-8?B?N1B4Rm45cThzcWg3ekU5Wm16dHlRQU0rLzJRWTErNlZqWHFuaFA0NzZMTXZR?=
 =?utf-8?B?T3pNaXpiaVc3bTFkZFFzNG1OSndBMExrMGM5WjVRTEZ0NzlyZnBZQUp1RFRD?=
 =?utf-8?B?WTFOdFBCVEc2RTB4N1NMUTNZNlhYd0pyK1pHVEMwZm5hMWtZY3pHT1pmTkRs?=
 =?utf-8?B?aVlvS2ZPSlNQWkh1b2lUdDZJZUJyUjJWYzRIUWgyZVVyTEN5SXR3M0NkbmJF?=
 =?utf-8?B?NWwzTWNib09pcUM3R1dpaC9aWVZNeUZPUUg4SWh5SVlXWGt6UUdoaW8yQkYr?=
 =?utf-8?B?aTNqWlNKUEQ3TDQvSGRZV1VzQlZCMkF0RldwVmI3NkZZdnJuQjdGN0JqcXpP?=
 =?utf-8?B?RVlOUmQxVlFlL3pxUXFSU01MV0RNQXlnZHJlc2J1Z2hvTCthSCs4V2t0eUJR?=
 =?utf-8?B?STVSWUgwNDdnNms2YmY5c1BlSjFZREZqc3pyWGhOUUtmbDZ2WlRyaHNtNWFN?=
 =?utf-8?B?VVlwK05IWkplZ3ZSbWZqOCsrMllzUzZraXZ6S0lwNTNxbkJJMXIrRE1UYURJ?=
 =?utf-8?B?S0xwLy8wWjFJa0o2RWx3L3orTi9iRWRCaWtPNmdOWFQ1SmVDd1F4QTUwVXA1?=
 =?utf-8?B?LzlPczhVQUhTZnd5bC91VnRkeXQ3bkw0QWd0RkZaNUFYa3paNE9jREp5WUFW?=
 =?utf-8?B?aFZYNmxubS9Ocm1EZlIxYzhXWll5QWw0STJCT1V6eis1WkFCZVA0TnU0dkti?=
 =?utf-8?B?aU5KMXp4bGRrell3NTl5SytnSzVDcGlqRDJXeklZcUE5SnpHTlo4WURUQVRQ?=
 =?utf-8?B?V0VVaFBqT0VrRVhOdFRXQnBucU04MmFJQWM1ZUQzSzdveVRUTHQzVTRLb0pw?=
 =?utf-8?B?dVNUMkwzVXZvbXBJZEFxTEJjWDBXekc4UDdRWkt3R0R0YXMvNGJYODFqRnM1?=
 =?utf-8?B?R3l4WDUyU2owM3duclhEaWJGWmFUMmUyamlaQlBMeXI4QTNTb1lZMEdCU3hK?=
 =?utf-8?B?MFZaTXpFOW5lanpZdnZUNEtxdkdlbkx6WXdSUXNlZG5OZkROcWpDSGp3QTNt?=
 =?utf-8?B?a0NwK1oxNEl4bVc4bkwrb3dzcWZvRmJ6UVpZSnhDQkwxWG90M1NUcW1NV2Z1?=
 =?utf-8?B?ZVVqTHNpYm1KcGEwR2Y5Tk1UbDBaOXFNSEhCVnFleHc5N2d3NE1kdnVJeFlP?=
 =?utf-8?B?OVNFaXdONVZOOGFWSlA5WnhtRkVnVjdwRm9UenNNZXIrWDJWSEdydzA5aTdP?=
 =?utf-8?B?NGROelMxRGc4RVJpK1Jkc3hJSFV2aXFYMzdZZ1JjY2R3di9ZYmFmU3FBY1Ev?=
 =?utf-8?B?U3VaWVVjSGRKVktBaTVYbSs2MUIxSitXUHNOalg3SWw2T2IzNG5hWnhzeVBy?=
 =?utf-8?B?cUM5bjlNWnBrKzJXM2U4M0VBQjd4K2NTUEtXMFBXcjB0bjk1UFFvUjRnVisv?=
 =?utf-8?B?eU44QkhWVVY1c1p2K1M3dzJtNWxZaXF4Vjd6RFU5SEtpZTV2Q0hjVmJGMUlD?=
 =?utf-8?B?Y2NqaVN1YVF0eWVVM1dxb2FvQ3dRNEVPNXNNbUhXempuZ01DSVowb1pMUi9F?=
 =?utf-8?B?cEl4Z2dZK3ZxcTZNZWQyczF3em9QM2pqaTkvUHh1Q24rUkNkV1dXUW5UNWlr?=
 =?utf-8?B?b2dnSEpkREhDbVRmYTlkQWxjOXE5Y2hqeHBHOHM2dWZ2QXU0TW5CZkhsUXpY?=
 =?utf-8?B?ckY5RkJIT1FyZGNjeGtVVW5MUzNzNnA2dFl0ZlVLam8zRGprRHJuR1U0alVi?=
 =?utf-8?B?VUJjRC91UEFsMVBvbFZ3ZllWMStCNDIyZGwwWUt6QmdPaXRLOHRob05GalN1?=
 =?utf-8?B?ZVVhZkowamU1Q1RBRllSVlRzNmNwbVFBWHNZRzIyMDdYeEUvME5ZWmZ6amVx?=
 =?utf-8?B?eE5hNmVxN2ZhNFZMUExHVGx4aFBPZFg5RE93SVFhSFlUMklMZjZnOXk2ZGxs?=
 =?utf-8?Q?Nu5pY245ls20FQLnOU6jckekV?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d443aa5d-f0bb-4438-104f-08dcf26901c4
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Oct 2024 07:13:19.4386 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1UelWFMu+EowR8Myv556De8edbaGmXKVBvHIYuL2s/DK7JMclYnKTV9Q4otFecM7EqbgQzH1RYxig8QqgMbfgUwAPGmSA1WkKOO+PMC+OkA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4813
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.19;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -64
X-Spam_score: -6.5
X-Spam_bar: ------
X-Spam_report: (-6.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.421,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H2=-1.699,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IE1pY2hhZWwgUy4gVHNpcmtp
biA8bXN0QHJlZGhhdC5jb20+DQo+U3ViamVjdDogUmU6IFtQQVRDSCB2Ml0gaW50ZWxfaW9tbXU6
IEludHJvZHVjZSBwcm9wZXJ0eSAieC1zdGFsZS10bSIgdG8gY29udHJvbA0KPlRyYW5zaWVudCBN
YXBwaW5nIChUTSkgZmllbGQNCj4NCj5PbiBUaHUsIE9jdCAxNywgMjAyNCBhdCAwNzo1Nzo1M0FN
ICswMDAwLCBEdWFuLCBaaGVuemhvbmcgd3JvdGU6DQo+Pg0KPj4NCj4+ID4tLS0tLU9yaWdpbmFs
IE1lc3NhZ2UtLS0tLQ0KPj4gPkZyb206IEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+
DQo+PiA+U3ViamVjdDogUmU6IFtQQVRDSCB2Ml0gaW50ZWxfaW9tbXU6IEludHJvZHVjZSBwcm9w
ZXJ0eSAieC1zdGFsZS10bSIgdG8NCj5jb250cm9sDQo+PiA+VHJhbnNpZW50IE1hcHBpbmcgKFRN
KSBmaWVsZA0KPj4gPg0KPj4gPk9uIFRodSwgT2N0IDEwLCAyMDI0IGF0IDM6NTfigK9QTSBaaGVu
emhvbmcgRHVhbg0KPjx6aGVuemhvbmcuZHVhbkBpbnRlbC5jb20+DQo+PiA+d3JvdGU6DQo+PiA+
Pg0KPj4gPj4gVlQtZCBzcGVjIHJlbW92ZWQgVHJhbnNpZW50IE1hcHBpbmcgKFRNKSBmaWVsZCBm
cm9tIHNlY29uZC1sZXZlbCBwYWdlLQ0KPnRhYmxlcw0KPj4gPj4gYW5kIHRyZWF0IHRoZSBmaWVs
ZCBhcyBSZXNlcnZlZCgwKSBzaW5jZSByZXZpc2lvbiAzLjIuDQo+PiA+Pg0KPj4gPj4gQ2hhbmdp
bmcgdGhlIGZpZWxkIGFzIHJlc2VydmVkKDApIHdpbGwgYnJlYWsgYmFja3dhcmQgY29tcGF0aWJp
bGl0eSwgc28NCj4+ID4+IGludHJvZHVjZSBhIHByb3BlcnR5ICJ4LXN0YWxlLXRtIiB0byBhbGxv
dyB1c2VyIHRvIGNvbnRyb2wgdGhlIHNldHRpbmcuDQo+PiA+DQo+PiA+Tml0OiBJIHRoaW5rIHdl
IHByb2JhYmx5IGRvbid0IG5lZWQgdGhlIHggcHJlZml4PyBBcyB3ZSB0cnkgdG8NCj4+ID5tYWlu
dGFpbiB0aGUgY29tcGF0aWJpbGl0eSB2aWE6DQo+PiA+DQo+PiA+PiArICAgIHsgVFlQRV9JTlRF
TF9JT01NVV9ERVZJQ0UsICJ4LXN0YWxlLXRtIiwgIm9uIiB9LA0KPj4gPg0KPj4gPj8NCj4+DQo+
PiBJJ20gZmluZSB0byByZW1vdmUgaXQuIEJ1dCwNCj4+IFRoZSBwcmVmaXggIngtIiBpcyB1c2Vk
IHRvIGluZGljYXRlIHRoYXQgYSBmZWF0dXJlIGlzIGV4cGVyaW1lbnRhbC4NCj4NCj5ObywgaXQg
aXMgdXNlZCB0byBpbmRpY2F0ZSB0aGF0IHRoZSBmZWF0dXJlIGlzIG5vdCBwYXJ0IG9mDQo+YSBz
dGFibGUgQVBJLg0KDQpPSywgVHJhbnNpZW50IE1hcHBpbmcgKFRNKSB3YXMgcmVtb3ZlZCBpbiBz
cGVjIHNpbmNlIDIwMjAsDQpzbyBJIHdpbGwgcmVtb3ZlICJ4LSIgdGhlbi4gVGhhbmtzIGZvciBj
b25maXJtaW5nLg0KDQpCUnMuDQpaaGVuemhvbmcNCg0KPg0KPj4gQ291bGRuJ3Qgd2UgaGF2ZSBh
IHByb3BlcnR5IGJvdGggZXhwZXJpbWVudGFsIGFuZCBjb21wYXRpYmxlPw0KPj4gSSBzZWUgYSBs
b3Qgb2Ygc3VjaCBwcm9wZXJ0aWVzOg0KPj4NCj4+ICMgZ3JlcCAieC0iIC9zZGIvcWVtdS9ody9p
Mzg2L3BjLmMNCj4+ICAgICB7ICJJQ0g5LUxQQyIsICJ4LXNtaS1zd3NtaS10aW1lciIsICJvZmYi
IH0sDQo+PiAgICAgeyAiSUNIOS1MUEMiLCAieC1zbWktcGVyaW9kaWMtdGltZXIiLCAib2ZmIiB9
LA0KPj4gICAgIHsgVFlQRV9JTlRFTF9JT01NVV9ERVZJQ0UsICJ4LXN0YWxlLXRtIiwgIm9uIiB9
LA0KPj4gICAgIHsgVFlQRV9YODZfQ1BVLCAieC1hbWQtdG9wb2V4dC1mZWF0dXJlcy1vbmx5Iiwg
ImZhbHNlIiB9LA0KPj4gICAgIHsgVFlQRV9YODZfQ1BVLCAieC1sMS1jYWNoZS1wZXItdGhyZWFk
IiwgImZhbHNlIiB9LA0KPj4gICAgIHsgIklDSDktTFBDIiwgIngta2VlcC1wY2ktc2xvdC1ocGMi
LCAiZmFsc2UiIH0sDQo+PiAgICAgeyBUWVBFX1g4Nl9DUFUsICJ4LXZlbmRvci1jcHVpZC1vbmx5
IiwgIm9mZiIgfSwNCj4+ICAgICB7ICJJQ0g5LUxQQyIsICJ4LWtlZXAtcGNpLXNsb3QtaHBjIiwg
InRydWUiIH0sDQo+PiAgICAgeyAiSUNIOS1MUEMiLCAieC1zbWktY3B1LWhvdHVucGx1ZyIsICJv
ZmYiIH0sDQo+PiAgICAgeyAiSUNIOS1MUEMiLCAieC1zbWktY3B1LWhvdHBsdWciLCAib2ZmIiB9
LA0KPj4gICAgIHsgVFlQRV9YODZfQ1BVLCAieC1pbnRlbC1wdC1hdXRvLWxldmVsIiwgIm9mZiIg
fSwNCj4+ICAgICB7IFRZUEVfWDg2X0NQVSwgIngtaHYtc3luaWMta3ZtLW9ubHkiLCAib24iIH0s
DQo+PiAgICAgeyBUWVBFX1g4Nl9DUFUsICJ4LW1pZ3JhdGUtc21pLWNvdW50IiwgIm9mZiIgfSwN
Cj4+ICAgICB7IFRZUEVfWDg2X0NQVSwgIngtaHYtbWF4LXZwcyIsICIweDQwIiB9LA0KPj4gICAg
IHsgImk0NDBGWC1wY2lob3N0IiwgIngtcGNpLWhvbGU2NC1maXgiLCAib2ZmIiB9LA0KPj4gICAg
IHsgInEzNS1wY2lob3N0IiwgIngtcGNpLWhvbGU2NC1maXgiLCAib2ZmIiB9LA0KPj4gICAgIHsg
Imt2bWNsb2NrIiwgIngtbWFjaC11c2UtcmVsaWFibGUtZ2V0LWNsb2NrIiwgIm9mZiIgfSwNCj4+
ICAgICB7ICJJQ0g5LUxQQyIsICJ4LXNtaS1icm9hZGNhc3QiLCAib2ZmIiB9LA0KPj4NCj4+IFRo
YW5rcw0KPj4gWmhlbnpob25nDQoNCg==

