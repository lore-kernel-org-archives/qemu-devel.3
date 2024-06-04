Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52F82C27C52
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 08:48:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEPqP-0005en-LV; Tue, 04 Jun 2024 04:48:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sEPqN-0005ed-Ns
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 04:48:35 -0400
Received: from mgamail.intel.com ([192.198.163.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sEPqI-0001gI-V0
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 04:48:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1717490911; x=1749026911;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=X+dA9PvNonH///zoSLDg9viOspXgD/rOCVZjZsTCj3o=;
 b=JWJ7wtVa538Mh49dE1llopYzl6EyVP2KZsBtvKPAG/NGGr1hhS7Vb+s6
 tMD76ZtA6x2xI8a5+FSlKY8mcIKB+tQAsLzY2fW90jgOXcMEEA1S6NkZB
 4v8bv7uGCtxTwK4nHL7r9NBEoPktIN/Ktq2L16HzqW6GoeT8upy4iMgNB
 AihmglLEZgE1Qwn/bR+x/PedWq4b82xV+PgQXty66hSybLzDRb0CJui2s
 UaAne1YLqQtZUJrdXoz6jDRwpIKf4j9gqgEPGty6dGQ4IoW9c9y+9S3rx
 HWrmbv3Y69UEo0C7j3zox6h8bNPTFfNMIpmhvefydC3T0fbQWXPSZ77Gk g==;
X-CSE-ConnectionGUID: NuJtwe4LTH6uQyBhyNoxDg==
X-CSE-MsgGUID: u8mQ9MxaTueCwqhVvhaSSg==
X-IronPort-AV: E=McAfee;i="6600,9927,11092"; a="14247692"
X-IronPort-AV: E=Sophos;i="6.08,213,1712646000"; d="scan'208";a="14247692"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Jun 2024 01:48:29 -0700
X-CSE-ConnectionGUID: EqLLNc1LQHK9KBBABCUpng==
X-CSE-MsgGUID: lHEwUWNCTHmjlSDday2HQA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,213,1712646000"; d="scan'208";a="37754916"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
 by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 04 Jun 2024 01:48:28 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 4 Jun 2024 01:48:27 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 4 Jun 2024 01:48:27 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 4 Jun 2024 01:48:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EU9ek5+sfmdI7QBIN33or71VfAaNZ75bZk5yUZlgoXGcAqmCTpAnq3RCSNx0mDvGambYXgZbzKWG6QBIfLqPd5/YlexpjTuLHSvtvE2/wYv+3YRBVcjcYMz5gRqz1iY7fy5/48E2Xs5D7/UFcp+48siaLMamx2+qKMgjFNgMJ192HGpcVaIKCxQ2o5rTx4ARXrmXU70vGfoJwPNob8LrmzHdbJDX5rR9uqu/gNKAIMaWc/v/ph9Il1SHu3iBHnAdLw9ui3ctJGFH3krthxp3BkBas3Zeq8RD9dKKPQjguLh4WM6qSGqPauXfej1z5bfYxvXjYMaHa2frKbOXJw/cUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X+dA9PvNonH///zoSLDg9viOspXgD/rOCVZjZsTCj3o=;
 b=Jl6pXdL3HvAA168T0EmIWyyj4+b18jKcMqJgKOXHCBcenXveyKqGrzS7vdNwjBzKNwLW+JKVw+AjTzDLD4OwqA5JCXomgv7TLdEzL6QnHmQZD/OoDVEAWX15/H9XdsNcdz274pdZdcb5FYxyR1cgwW/onyamYo0ntHwp7JYFoQ8jZdjblKzvqOdhjVvDK9efYEZOt5vmI77EdsKj5J05n+hXguXh2GIEioTcoc6rJ3IdvAuIoxqH0HfIIoQFFdMqyblBOuHTv98Zug7hRIoGl2dYgEFFSslm7scEP8D76E/l+XXXdrq+BYlpNxwUeYe4A8RHDDEHcQyoHRPHIQijXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by BL3PR11MB6483.namprd11.prod.outlook.com (2603:10b6:208:3be::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.27; Tue, 4 Jun
 2024 08:48:25 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091%7]) with mapi id 15.20.7633.021; Tue, 4 Jun 2024
 08:48:25 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: "eric.auger@redhat.com" <eric.auger@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>, "mst@redhat.com" <mst@redhat.com>,
 "peterx@redhat.com" <peterx@redhat.com>, "jasowang@redhat.com"
 <jasowang@redhat.com>, "jgg@nvidia.com" <jgg@nvidia.com>,
 "nicolinc@nvidia.com" <nicolinc@nvidia.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "clement.mathieu--drif@eviden.com"
 <clement.mathieu--drif@eviden.com>, "Tian, Kevin" <kevin.tian@intel.com>,
 "Liu, Yi L" <yi.l.liu@intel.com>, "Peng, Chao P" <chao.p.peng@intel.com>, "Yi
 Sun" <yi.y.sun@linux.intel.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard
 Henderson <richard.henderson@linaro.org>, Eduardo Habkost
 <eduardo@habkost.net>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: RE: [PATCH v6 18/19] intel_iommu: Implement
 [set|unset]_iommu_device() callbacks
Thread-Topic: [PATCH v6 18/19] intel_iommu: Implement
 [set|unset]_iommu_device() callbacks
Thread-Index: AQHatX1NjS0WvnbGzEqvnm/9l/Wze7G2FVCAgADkm+CAAEmPAIAACUJw
Date: Tue, 4 Jun 2024 08:48:25 +0000
Message-ID: <SJ0PR11MB67442ADA8C8CC17F14012A0092F82@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20240603061023.269738-1-zhenzhong.duan@intel.com>
 <20240603061023.269738-19-zhenzhong.duan@intel.com>
 <7d5fb5db-8505-469a-a41f-6e18ef8bc77c@redhat.com>
 <SJ0PR11MB67442CF9C141B5C1120CA59092F82@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <d089e681-5fa3-4f97-8637-76376fd4b4fc@redhat.com>
In-Reply-To: <d089e681-5fa3-4f97-8637-76376fd4b4fc@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|BL3PR11MB6483:EE_
x-ms-office365-filtering-correlation-id: 75ed6a7b-593c-4ab0-cc09-08dc847318eb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230031|376005|366007|1800799015|7416005|38070700009; 
x-microsoft-antispam-message-info: =?utf-8?B?Z2VjcFRnMkFWcUx5V1N6SnN3cklYTk0zcHJveGk5V1lUU2NueTNxMnRWZzJ6?=
 =?utf-8?B?bkNWYjhjS0VIY1d6RlBHbEt1TVMrZUlnWU9xZFhUTThtZWJ3QUJSYXhnSDR6?=
 =?utf-8?B?UzVlSEVzVDVKbWNHQW9TWGtGR3ppYzJMeFpEVG1JbmtiOGlZcUZZMjA4YXZv?=
 =?utf-8?B?TWt0UXJTd1ZHTCtpYUN5SERkemNlL2NQYXlxV1FpZkY1UkpOcllRZFRPWmtG?=
 =?utf-8?B?amxBZkR2dmp3Qi82ajV6YXZwcUZYYWJMdmtuUVVxVGdHNEx0M1BpT1V1ajlz?=
 =?utf-8?B?R25JSWlXWkt6VTNVZEoyWGl6TTZ3cHR5ZTZ1ZUJLVlpEVUJISjB5YmdzZE5N?=
 =?utf-8?B?a2Z0VTJOaXdGNC9jNFhxVTdBemUxNkJsNG1OMWpPTWFMeU5qa3p4c1lwWmZN?=
 =?utf-8?B?NFg0VVZzWHR0VEpBcXlZODJEUzhmTUJpRFZheEg5dXcyZFc1cnVnT2p6Qldz?=
 =?utf-8?B?QjhGK2ZrMTFXL1FjTndrMFZ5MklqUDRzdlI0RWd4a3NoUmVQVVNxTkZZTEp4?=
 =?utf-8?B?dmdIRGFVaHA3MDQ2aGRLWTVYN05DYlpabS9jOVJFT04yNVhENi9xVE1LcVI0?=
 =?utf-8?B?K1p5cGM5dFNPc00wWjZTUk1XN3pCUlFGaTBCWnFqMzJ2bmhGQXRRZGhDSkw4?=
 =?utf-8?B?T01palVyMC9XWXZhK2Z3MTRhdzM4QW5WZ0JKb3dzOFN2bGpIQTQrY2pyTnN0?=
 =?utf-8?B?WDNhYkFVNjBHR3dDcUxjM2lTZ3ZiVFJSallPYjVQZ0RLOVBhOE5rS3NHQkFI?=
 =?utf-8?B?ZDlaVGc0TXpQSlQ2OUlRSHJSMEt4WW9vSUFpNHhaQ3psOEJ6SGczdG5LQkps?=
 =?utf-8?B?OEF5VUJ0ck5Kc2xETGdVZTVFblZEYmVkZlJJY0xHbWNud2syckpsV3czbG9i?=
 =?utf-8?B?cGJET3R0bmtqN0ZrdHdPWjdMWFREUlk5MzJZYjN2OU1mZzl3cDNKMWtLSk1x?=
 =?utf-8?B?UU9rMldXaGxXWWFzSnZ5UEFLUUhRWGhrZzJ1VmxYL2ZvMG5uc0wyZVZOdXI4?=
 =?utf-8?B?bW9TYXhjSGttY1R6bHl4dkloT0xxSnN0KzNEdmsxWVRhc2ZFZm1ldnNhNFdr?=
 =?utf-8?B?WU11R2phWlZrbmlkRm5HNTc5QzZxMzJjR2p2aDl2ZmhjeUhQQjlYZ1pDd08z?=
 =?utf-8?B?NHV6ZElrUTBtbC9EUUJaVGJaZldnakdUakRBL3hkclhDZEtQSlJwb3h2dWdM?=
 =?utf-8?B?R2JEck91R1ZoOURoMUpTRDhyTDBXaTZlQzljV2FGMHk0WkhQaWFqTWJuQVRB?=
 =?utf-8?B?ZDByOGVKNUE0YUM4WVpnMHgxbjM5VW4zM1VwVUxDVVVWVTl5TS9PaXUzOEZn?=
 =?utf-8?B?YjkwVFUvaVpGbHJyZ2hWdWJyRzFxd1hwME00dGdtRjBpNUdQbjNCUS9PZ0hx?=
 =?utf-8?B?VWlBM1EwWkw3L2Njc2Y1a2RuNG1ncDhIU1B4TDhKSC91QitZVjdIV0pmcytn?=
 =?utf-8?B?OTNWUHIrL2dOK3lHTlpHUU1UekZqUWFrWHc4Y0VTb09vZi80QWZQMTBlRkF6?=
 =?utf-8?B?K1h4aGFWbjJEM0FXWDM3bTA4VWJ0V3BsYVBVM1FoSE1hTlkyY3pVMUZWUW1Y?=
 =?utf-8?B?aFRzUFRmcEU5eDUrZ2VpeUhmeUVaZkZyY1Back16aUQwdEc3ZXFwbm1iUUM1?=
 =?utf-8?B?cjlrRjNadWd5azNQaE5xMXN0bVhnN2VaSzUveTBOQ0F3S3JSTHRjb0o4S3ho?=
 =?utf-8?B?Z0pIWDVXVHQrRCtML1hONmVsNDBrVmpVaGVWRmlCc0ljOWVzMEVXVVk5Sk9x?=
 =?utf-8?B?aXd0QzVJaGtSRFBSZm9QelRBQ1NpMk9SS3JYcldIRDQza1VVTVFFMnJ3QzNy?=
 =?utf-8?Q?4a3LU0zHYnx6BzCNKpqwpsm2JTydvq3Q7WG7E=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(366007)(1800799015)(7416005)(38070700009); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MU1SdHhYcVUzTE5MSGQyVGpMY0tPODNWNGRJY2N3TXFXTXJSNEdab0h6OGV1?=
 =?utf-8?B?UmRYOTg0M25wNGtqbjNmajhDUS9UM29sRzh2YVQxNCtRQ1lvdWNaZnhsV3N5?=
 =?utf-8?B?Mm9IS25yejdrOTlKbE1ISEpHL3Z6c2hCYnZBYk4wRmVEU1RHYkowZnM0cEFG?=
 =?utf-8?B?NEdMcWE2ak0xdVEzdEpIbVVZNllkQmZYQUtmSW1JQU80Rml5M3AvekJjdVh6?=
 =?utf-8?B?RXNIdjNqQThPZXdhOWZkVW9OcG1YTjJST0xTQUtmMEt1M1ErRkdnNVYrb2NY?=
 =?utf-8?B?cDNNeXZPdHhEdXpBdHdBTUkvZ2pXdWtwMDN5S3FoL2pnTDM2WC8xeS8rV1lL?=
 =?utf-8?B?Z2loZUh1VmtFVDNzejJiTXloc3YrTXQwMXZnc0hOZFRRY0dVVUVpNVlBNlpK?=
 =?utf-8?B?T1IrVjJHQk9xZ08vUzMxQXFJMWVYL21ubjRDdlBBOTlWcGlsV3J5TFRrSzh1?=
 =?utf-8?B?c1BXdEFsY3NYOVJTaGRBejZMWVJiMUFTeTd5WThMYWMxYzQweHBCYmJOSGg0?=
 =?utf-8?B?ZjRaYXpnd29NV2ZsQW56RHJsMzhTR3lzbk0xZHRPamtYeldYUFN4NHF4TFVj?=
 =?utf-8?B?a1RPRjJkR2UySUU5L0ZGYmVacXdEMmJCd3NHRXZ2dnpnNVdvUkphNG5HSFBG?=
 =?utf-8?B?eTFnN0t6aGF4TUJ1VXhNZ1NPb0tnZFMvK2pVRDk3eE1McFZYMUU4WElUWTJ1?=
 =?utf-8?B?RVovZzVVaUlndHIvZzhpYWozUmJRcDNocElwSEFsL3dGZXgyR21uQXZIR3Fq?=
 =?utf-8?B?U3IzT1BENVFxTW0zUUxHZlVTQkZjc1NqK2FOcVlRUk14S2RLOHNBbGVsczdi?=
 =?utf-8?B?ZFJiTWVoVHVQeU1tK2hHeDZKaDFEMGNEMWlSRVE1UndnTytmOXRmUVV3eEtj?=
 =?utf-8?B?UUxWa1U5RVZlYy8rdlFoMGVOY1I2amdoQVNqYkFPWkVmNXQwNzdrODJTUysr?=
 =?utf-8?B?R3RjTkhqRFMvYTZmcU1WUS8ybDlOai9WcWZkS1lkUWtNdnprYVhQQVpoQS8x?=
 =?utf-8?B?dDdaMDZUTnRPcVI4Ui9OcTBCWWR2T1dYeEk3NkFPY0tPdm1BNVc3Ri9EY1Jm?=
 =?utf-8?B?UTZOb1hDTFR6QUtLdldlb0MxRXNQbW9SYUN2b08rTkZXK2NHczZSRGozSzBh?=
 =?utf-8?B?TE5TOHFIMTBJa1VkSWlmUWRnR0hsVGJwRitTdCtRWHp6STI1YzFsdEF4T3NO?=
 =?utf-8?B?VWRhQ2dwVzNNZk5TUk1rN013akFSNEYrOFpYYTR3ajEvVXptRjFyMXMvUFhN?=
 =?utf-8?B?dnU1cEFDNTFVZ2hsbEZDUUdjRXlJTXNVTy81SlFlMkc1TTh4VHRpaCtrU255?=
 =?utf-8?B?VnprSU05bzJHM2h6UVNnZEViOHlValBNd2hQWjFoc3hQYXo3VWFrZ0JrK0hX?=
 =?utf-8?B?dEhwc1Y5Z1NXSUdjYjNQTGRyNFBtczFTenJjc3VDazJBYys5Q0VaQUM3QWNz?=
 =?utf-8?B?dkJ0U0FrVkhJQ2RyWFRDamNSRUJyanoyVUpaQ1RsTGdZSkoyUjB6SmJMSitv?=
 =?utf-8?B?REZRR1NYRG5NM2JIRWsvZ3F1U0creko0Q2NUNkwxMFNpZlVRMXo2MTJwditv?=
 =?utf-8?B?THE4cEk4T25ORDBUZEIwOHVaWDdRNXhjOXNZeFRCdmFnRjNWb2ZNNWQ1UXdN?=
 =?utf-8?B?eCtvKzNCL2NpblowdnZhZEdYcDZHWm9neUNqWHN5bUF0bkoyVkN6QUF1VXFO?=
 =?utf-8?B?c3l1S3BLeEhqVWxLc3pXR2dUNDE5eHAwc29TcWE1OHE1bUpOSXZjVGwwWG5I?=
 =?utf-8?B?V3pNaCtucmtYay8zWTNjelIxMVg2TWFXS2tueUpjem5nRlVMMVh3cEw1RzFV?=
 =?utf-8?B?KzNTdUo1TkQwb3d4Q3Y3VDVIc3NrTmRzUmtMaFRETG04NUJDV2h0S0FhTmJS?=
 =?utf-8?B?MVZuMGFuQ0lCTjJ3bFhMVHZsTVlFa3l2Y1R3cCtCN3lTN1VyWG5Yb0dxWmRR?=
 =?utf-8?B?bnMzTEdMREVReEd3REJPMmZTcFBaa3hIYVAvYXR2M1JGS2RBU09XRmEwcXpn?=
 =?utf-8?B?SFNjeS9xKzhqdDltUU5MNkZqRmRNWWttYk12SENicVJFaE9QK2ZjNzlmN1Rp?=
 =?utf-8?B?OFFUTk91d0R3VCttejVqSTVtS0ZqTWFqcU9lbjRIUjBhVjRSaC9OcXpVa1Vs?=
 =?utf-8?Q?EjUPdnQKgDguTiNThhXI/eiF4?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75ed6a7b-593c-4ab0-cc09-08dc847318eb
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jun 2024 08:48:25.3860 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ejd+6s3V+y/ibGpfZY5o/bOxAVTqoS7Q8O/nLncgQqAltCTZtiYpyjiQ6UfkA3qyOgsSpqCO4DHXAHt/rlyz7wYQ2+wS5uLzg45sINj3W/Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6483
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.14;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
YXVnZXJAcmVkaGF0LmNvbT4NCj5TdWJqZWN0OiBSZTogW1BBVENIIHY2IDE4LzE5XSBpbnRlbF9p
b21tdTogSW1wbGVtZW50DQo+W3NldHx1bnNldF1faW9tbXVfZGV2aWNlKCkgY2FsbGJhY2tzDQo+
DQo+DQo+DQo+T24gNi80LzI0IDA3OjQwLCBEdWFuLCBaaGVuemhvbmcgd3JvdGU6DQo+Pg0KPj4+
IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+Pj4gRnJvbTogRXJpYyBBdWdlciA8ZXJpYy5h
dWdlckByZWRoYXQuY29tPg0KPj4+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjYgMTgvMTldIGludGVs
X2lvbW11OiBJbXBsZW1lbnQNCj4+PiBbc2V0fHVuc2V0XV9pb21tdV9kZXZpY2UoKSBjYWxsYmFj
a3MNCj4+Pg0KPj4+IEhpIFpoZW56aG9uZywNCj4+Pg0KPj4+IE9uIDYvMy8yNCAwODoxMCwgWmhl
bnpob25nIER1YW4gd3JvdGU6DQo+Pj4+IEZyb206IFlpIExpdSA8eWkubC5saXVAaW50ZWwuY29t
Pg0KPj4+Pg0KPj4+PiBJbXBsZW1lbnQgW3NldHx1bnNldF1faW9tbXVfZGV2aWNlKCkgY2FsbGJh
Y2tzIGluIEludGVsIHZJT01NVS4NCj4+Pj4gSW4gc2V0IGNhbGwsIGEgbmV3IHN0cnVjdHVyZSBW
VERIb3N0SU9NTVVEZXZpY2Ugd2hpY2ggaG9sZHMNCj4+Pj4gYSByZWZlcmVuY2UgdG8gSG9zdElP
TU1VRGV2aWNlIGlzIHN0b3JlZCBpbiBoYXNoIHRhYmxlDQo+Pj4+IGluZGV4ZWQgYnkgUENJIEJE
Ri4NCj4+PiBtYXliZSBwcmVjaXNlIHRoYXQgdGhpcyBpcyBub3QgdGhlIGFsaWFzZWQgb25lPw0K
Pj4gU3VyZS4NCj4+DQo+Pj4+IFNpZ25lZC1vZmYtYnk6IFlpIExpdSA8eWkubC5saXVAaW50ZWwu
Y29tPg0KPj4+PiBTaWduZWQtb2ZmLWJ5OiBZaSBTdW4gPHlpLnkuc3VuQGxpbnV4LmludGVsLmNv
bT4NCj4+Pj4gU2lnbmVkLW9mZi1ieTogWmhlbnpob25nIER1YW4gPHpoZW56aG9uZy5kdWFuQGlu
dGVsLmNvbT4NCj4+Pj4gLS0tDQo+Pj4+ICBody9pMzg2L2ludGVsX2lvbW11X2ludGVybmFsLmgg
fCAgOSArKysrDQo+Pj4+ICBpbmNsdWRlL2h3L2kzODYvaW50ZWxfaW9tbXUuaCAgfCAgMiArDQo+
Pj4+ICBody9pMzg2L2ludGVsX2lvbW11LmMgICAgICAgICAgfCA3Ng0KPj4+ICsrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysNCj4+Pj4gIDMgZmlsZXMgY2hhbmdlZCwgODcgaW5zZXJ0
aW9ucygrKQ0KPj4+Pg0KPj4+PiBkaWZmIC0tZ2l0IGEvaHcvaTM4Ni9pbnRlbF9pb21tdV9pbnRl
cm5hbC5oDQo+Pj4gYi9ody9pMzg2L2ludGVsX2lvbW11X2ludGVybmFsLmgNCj4+Pj4gaW5kZXgg
ZjhjZjk5YmRkZi4uYjgwMGQ2MmNhMCAxMDA2NDQNCj4+Pj4gLS0tIGEvaHcvaTM4Ni9pbnRlbF9p
b21tdV9pbnRlcm5hbC5oDQo+Pj4+ICsrKyBiL2h3L2kzODYvaW50ZWxfaW9tbXVfaW50ZXJuYWwu
aA0KPj4+PiBAQCAtMjgsNiArMjgsNyBAQA0KPj4+PiAgI2lmbmRlZiBIV19JMzg2X0lOVEVMX0lP
TU1VX0lOVEVSTkFMX0gNCj4+Pj4gICNkZWZpbmUgSFdfSTM4Nl9JTlRFTF9JT01NVV9JTlRFUk5B
TF9IDQo+Pj4+ICAjaW5jbHVkZSAiaHcvaTM4Ni9pbnRlbF9pb21tdS5oIg0KPj4+PiArI2luY2x1
ZGUgInN5c2VtdS9ob3N0X2lvbW11X2RldmljZS5oIg0KPj4+Pg0KPj4+PiAgLyoNCj4+Pj4gICAq
IEludGVsIElPTU1VIHJlZ2lzdGVyIHNwZWNpZmljYXRpb24NCj4+Pj4gQEAgLTUzNyw0ICs1Mzgs
MTIgQEAgdHlwZWRlZiBzdHJ1Y3QgVlREUm9vdEVudHJ5IFZURFJvb3RFbnRyeTsNCj4+Pj4gICNk
ZWZpbmUgVlREX1NMX0lHTl9DT00gICAgICAgICAgICAgIDB4YmZmMDAwMDAwMDAwMDAwMFVMTA0K
Pj4+PiAgI2RlZmluZSBWVERfU0xfVE0gICAgICAgICAgICAgICAgICAgKDFVTEwgPDwgNjIpDQo+
Pj4+DQo+Pj4+ICsNCj4+Pj4gK3R5cGVkZWYgc3RydWN0IFZUREhvc3RJT01NVURldmljZSB7DQo+
Pj4+ICsgICAgSW50ZWxJT01NVVN0YXRlICppb21tdV9zdGF0ZTsNCj4+PiBXaHkgZG8geW91IG5l
ZWQgdGhlIGlvbW11X3N0YXRlPw0KPj4gSXQgaXMgdXNlZCBpbiBuZXN0aW5nIHNlcmllcy4NCj4+
DQo+Pj4+ICsgICAgUENJQnVzICpidXM7DQo+Pj4+ICsgICAgdWludDhfdCBkZXZmbjsNCj4+Pj4g
KyAgICBIb3N0SU9NTVVEZXZpY2UgKmRldjsNCj4+Pj4gKyAgICBRTElTVF9FTlRSWShWVERIb3N0
SU9NTVVEZXZpY2UpIG5leHQ7DQo+Pj4+ICt9IFZUREhvc3RJT01NVURldmljZTsNCj4+PiBIb3cg
VlREIHNwZWNpZmljIGlzIGl0Pw0KPj4gSW4gbmVzdGluZyBzZXJpZXMsIGl0IGhhcyBlbGVtZW50
IGlvbW11X3N0YXRlIGFuZCBlcnJhdGENCj4+IHdoaWNoIGFyZSBWVEQgc3BlY2lmaWMuDQo+DQo+
c28gYXQgbGVhc3QgSSB3b3VsZCBhZGQgYSBjb21tZW50IGluIHRoZSBjb21taXQgbWVzc2FnZSBl
eHBsYWluaW5nIHRoaXMuDQoNCkknZCBsaWtlIHRvIGRyb3AgaXQgYW5kIHJlaW50cm9kdWNlIGl0
IGluIG5lc3Rpbmcgc2VyaWVzLg0KDQpUaGFua3MNClpoZW56aG9uZw0KDQo=

