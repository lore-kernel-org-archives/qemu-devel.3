Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 625D7C25B75
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2024 10:26:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s9Mh2-0000Rt-Uh; Tue, 21 May 2024 06:26:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1s9Mgv-0000Ql-TT
 for qemu-devel@nongnu.org; Tue, 21 May 2024 06:26:00 -0400
Received: from mgamail.intel.com ([198.175.65.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1s9Mgo-0002Jz-2Q
 for qemu-devel@nongnu.org; Tue, 21 May 2024 06:25:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1716287150; x=1747823150;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=fc4qBvrzjkRMOfjsAB+cohTeeSsRVPIG11PdhD1Vluk=;
 b=Et+zCtdrFCRfAJhV4Mfo+8wQlNotT/RSpeVzquwfb9JEb9sCVas3Y/AZ
 4emXYsmDhX6ijxxk41LwrYrdb6phCJ24K5uIY7HGCpMxZg6HGPs6lgRM1
 lZKquOlO9gTrjXL406R/Ri4THAxQead/ctb/MXPAQz9nC4qoBBiSV71Wm
 5QNA8vDhXlAyhiest9NiKplQ8dcG8Y/2t4+0D1mjlrrMQLOaMdFGruycc
 HT4T6D64GdJhjiwM7ELsBed5JDQvQo6d0bQhetGqhuQAnsfo3B+NMA4+I
 Epfr0MDLNsCO/p1eIAVX30Y6XGyty0WkOiGFtLpLfkKpN1SO7GruBuHe7 Q==;
X-CSE-ConnectionGUID: 1YR8Wi+NQUCDe0k1KhUtHw==
X-CSE-MsgGUID: 1cc3VeaLS6CWY8aCZ4eN1w==
X-IronPort-AV: E=McAfee;i="6600,9927,11078"; a="12581405"
X-IronPort-AV: E=Sophos;i="6.08,177,1712646000"; d="scan'208";a="12581405"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 May 2024 03:25:45 -0700
X-CSE-ConnectionGUID: wZ3ukau3QkCx9JYKdcL09A==
X-CSE-MsgGUID: EnBUmVCORzKmUQJHkniNhA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,177,1712646000"; d="scan'208";a="33424108"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
 by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 21 May 2024 03:25:45 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 21 May 2024 03:25:44 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 21 May 2024 03:25:44 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 21 May 2024 03:25:44 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 21 May 2024 03:25:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bxfPwfFIrRNJuG07N/NUByiF5GzmuWfUS+IhYLn6hW8tTGotpqNtJiQOQBwYaskqDYxCwCzfxEBXVbHgcb8Hj4K/CuzWDM25VIKdSwmxlXxD6nVPScH06qrkzY9V/BVkyN9r1ofHA3fxKtRtZF9soGoWlYvwFNhTbjuViRiLSvvJBukzmMBGBhcbChziLUmyI+w+EVwHSSfD4KS08cjZ+qVMUKD9ER1+wodbzY2YPRoOJxurp3jD53qy5Plm9NdV4A+x6Z2xZZt8ozxCcKRTPK+9vp/PCjs4yDc8DJip0ClZ5s9/hi9h3LE18Qv2wlTzw/z1kWBcD/Q5h9DvdeELqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fc4qBvrzjkRMOfjsAB+cohTeeSsRVPIG11PdhD1Vluk=;
 b=latZAkeE3XIlpNb8BWa784SThpxkreD9cWhgSkUozMyGgjllmTmhsgAT0c9SVrlwK5sIbvk8+b5Guut77uVDjulix4LqkUp5LB6599BeMMsD6inq7EOtnz/Yx+IamSGKNTb/cynVfC4TrhAyjWL+iO0ZolfPs52IYWqmtniUnzHJ2ABs8PBM5PLg1DXlqQa6xOwOPRmq6i2yZZ+Obt5AW1W6sMRDP3z4fOQiZpVQpxg1GayXkylu+7CJOPsTXlwx/k8p3lzDiEMUMw50JdlvJT+wjszBs9JVr7yRyqqrobOcJfvqjE6Y9Y9PtagaC3FmlAYuugrsoRmPwliB/2eaXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by MW4PR11MB7032.namprd11.prod.outlook.com (2603:10b6:303:227::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.36; Tue, 21 May
 2024 10:25:39 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::21df:af3:be1d:722e]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::21df:af3:be1d:722e%4]) with mapi id 15.20.7587.030; Tue, 21 May 2024
 10:25:39 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: Jason Wang <jasowang@redhat.com>, "Liu, Yi L" <yi.l.liu@intel.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "Peng, Chao P"
 <chao.p.peng@intel.com>, Yu Zhang <yu.c.zhang@linux.intel.com>, "Michael S.
 Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "Richard
 Henderson" <richard.henderson@linaro.org>, Eduardo Habkost
 <eduardo@habkost.net>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: RE: [PATCH] intel_iommu: Use the latest fault reasons defined by spec
Thread-Topic: [PATCH] intel_iommu: Use the latest fault reasons defined by spec
Thread-Index: AQHaqESnRiGl1jiq20uiRV0AFydhKrGfTQkAgAAs2mCAAA5PgIABefcAgAB9i4A=
Date: Tue, 21 May 2024 10:25:39 +0000
Message-ID: <SJ0PR11MB6744C340AAB1B786D3913F5D92EA2@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20240517102334.81943-1-zhenzhong.duan@intel.com>
 <CACGkMEvTomFeC1bM3SfY1zGhQ_5i15r6CY6M3jVzau6niNUf_w@mail.gmail.com>
 <SJ0PR11MB6744AECEAA6F9319259B0DF192E92@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <DS0PR11MB752917B52B66A6EF10C10678C3E92@DS0PR11MB7529.namprd11.prod.outlook.com>
 <CACGkMEt5ofYt12A6uKUj=QLcLbOnrGT=UkMpee=MUxO6Xy3sxg@mail.gmail.com>
In-Reply-To: <CACGkMEt5ofYt12A6uKUj=QLcLbOnrGT=UkMpee=MUxO6Xy3sxg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|MW4PR11MB7032:EE_
x-ms-office365-filtering-correlation-id: 655a4a41-688d-40e4-5b79-08dc79805cb9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|376005|366007|1800799015|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?bnd3K2RrOWhydkVSeDkwTzI3N0t5cEhtZm1HWXFRcjBUZmErbWlPYXNab0VI?=
 =?utf-8?B?a21tclFsZWtkbnV1QkthVlJqRC83RVZZTmZmMDFibmVOdGg2T0oybHp3V0pj?=
 =?utf-8?B?NG00UjkzNWpja1dNRk5hN0tQVU1FYmp0L0NtZGxtamRVZmZZaTVuclJUYlBG?=
 =?utf-8?B?UDhiekwrQk1zbVVCbU5Cc2hJUVZHUGZLZVV1bDhBYWI3Q0RMOTNHUUhZbGxC?=
 =?utf-8?B?L2c4WXFWZkIrYjFLVDMwaXNKNUpZRkVLVVQyVWpLSVdiYlZ2OGo4ZmFFQlVx?=
 =?utf-8?B?WXhIZ1puMTZpWitFbmFIbVpHQUQwWnJVNGd5dzdhTkNobE1Xb1dSUEJlNUdy?=
 =?utf-8?B?T0Z4ME92VHI3R1l4aFBqZDRySjNCbFJKdldWQVRUUktSSnVqT01uSnRyNnho?=
 =?utf-8?B?dzFObDliU1Rzd052TXY3Y2FqWWRHazhhYTIzams2V2ZjNHpJaDVFc25vZzVy?=
 =?utf-8?B?b2V1bTNPL1dnVXdaSkdCNXpWSkFNSTA3TXg5T3QrNHpJQVhWMjl1U1JEQklv?=
 =?utf-8?B?WUFhQ0ZvSnA4RlV6R24rWU5qcHFCQkhOdE1vMGVjam93dW5GRUZPMXk1YTdE?=
 =?utf-8?B?YkhsenNXTXJSeGFvdGNoMkJpOFRDODZkbGgwQ2grdFNxc2xuZTR5bVBVallE?=
 =?utf-8?B?SDhJWkpkSlpjbWQ4ZkhncVFaWWt3a1FjRFRPZSsyYWtmSUtZVHM3NmhXblRE?=
 =?utf-8?B?ekR6dUtmZzJlSUlzcUsyRXA3VDdXQ2M5QVNHQURVazBhY0t5Tml1eWQ1M0lO?=
 =?utf-8?B?VDdINnNpVzROWk5FcEpudFFCbDhYTU1FVW9LMy9OWEJ6WjJLR0tYbFljUGNq?=
 =?utf-8?B?VlhwTXZldmFnZUNTckJGT0l0RXc0ZEk5TmhadzdBbm1peFU1MjB4YVJpR29L?=
 =?utf-8?B?U1E5Lzk0Q3I3NGxId0hFRmdmdFlzUnZWUHJyYmd3aSticnVlMzRGdFhnNnEr?=
 =?utf-8?B?bFB3N1dUaVlxTDB3NjdRVmdGMTVtdW9Hcld0SGJ1eUpUNE5hM3NzaXhnRUJO?=
 =?utf-8?B?MEFVYm1BbmNVZWtqdnB1WjRldTNGQVhMa2E2MDlhNXlxVUxSQWlVdFFLZW05?=
 =?utf-8?B?ekpUQkpqOElkUTBNUmlnQzFXdnFIczZRdTB5MTd3K0xiUlFaQ2djMG5QZFlH?=
 =?utf-8?B?czArUEk5WVVpTG1hbFRiVFhkb1NTNkpQbjJLU0NFenVnQVpGYW1nNVJYdG5Q?=
 =?utf-8?B?R3ZaM2VsQnVoaE1HWm4yMllIMGJnL0c5SnBHZXZQRmV2cWdPU1lGamphMFpF?=
 =?utf-8?B?VkhuMDFYZitkRzdpSzdYSlNoYndLRnByUjl2dW1XeC9IK2NEN3Rub3BvTUJ5?=
 =?utf-8?B?ZnY2MlJXNnFmUjkzMkhrckY3TUJQS3k5SUJEVHlIU3dMVGEzNU45Zk1qN1Bl?=
 =?utf-8?B?ZXc3SUVpOThuMlJuK0FaeStnTmxJUnoyRWNNcUNFYWJDTmRGQzk1UjlqVjVO?=
 =?utf-8?B?ckU2WDBvZXZNVmR5c2JuRVdHZHlINjIyM0JFMS9VKzJVQTFtOUIwTEJTMk5M?=
 =?utf-8?B?TTNRemdqNlNkc1RaelpvN3YzM3ExSnJ3L0psM3BFaThiT2FEMEpLRVU5bDlp?=
 =?utf-8?B?RnUxWVVlRjZXSDUvSzBLcVI5TmRXL1prNk4zcVZGU050dVA3RW9TdUVUanln?=
 =?utf-8?B?ZXVYakt1cjcxVG8xbWZwWnY2TzdGaTU0L3VnVUVIVkw3MER5VG9rdzNJR2h6?=
 =?utf-8?B?Qmx2QWRsdEtueHV4SWtrOWJqYzF0RXQ1VHJwemVyVEFNTzdPR0lIY20rdysy?=
 =?utf-8?B?K1ppUHB2TFRUSnZKZWtjS0Z2dDB3Slp0WDN3ME4ra0VRQ0FoWEhxQVdFU3E5?=
 =?utf-8?B?VVI5RTZ0YU5ZaE43eURSdz09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(366007)(1800799015)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?am54T05pYU42TVY4QVZmWVp3REMvUmU3TDRhOExQeTJEU3E3d3R6bkdiRTE2?=
 =?utf-8?B?bkJjUHY0QlJlQU1Vd3lJVjE5SmZMeWphbjkyYnhpaUtybmJTMjNBOVRTZjYw?=
 =?utf-8?B?RURqcDlhYnRjbTFUWDNyc2puSGc4WjlQdjFQZHRXWHRDNjgyLzIwWTVteExw?=
 =?utf-8?B?QlU0eWlGWjlYSDgxQVNPRlk5VHhHNm5XZTQvMk5ITkJOK3JnMXhYYitnVWpk?=
 =?utf-8?B?dm1lb1BLaGkyVEF2RHRYVFUzQTdUV3hhWkFjT0NuNWozL2ZkV2toVDZETHZa?=
 =?utf-8?B?NXduY3JSR1NhV2IxbUdZdG8xV1krTExXR3crMzZpdHJmTG1mSjhaV2VlSzVj?=
 =?utf-8?B?VGhGK0tQM1E3TytzY2xUWWVKTm41S2sxKzZ1SEROekdYay96MTU0NndIcUZ3?=
 =?utf-8?B?S3YzbVUxS1FwaFNtQUxyVTVrU3BYMXQ2aG52SlQ1eHRnYjMxUTArOExBeVB1?=
 =?utf-8?B?U0tmd0R3RU16aWJ6emhmWjNPWHlLYWdHOEVmVSszMmRZalpUaE5Jbmt3SXA1?=
 =?utf-8?B?WUFJcWJMSmFnTXBBQlJUTnpTRzlidENmTW96U1BYT0txb3BKNWgxMi9majZa?=
 =?utf-8?B?UWJaOGh2cWNYdkhXMnJQYi9STUlVVmFlZVdPaGhtWVQ4MVZTM2svcFFPV2tt?=
 =?utf-8?B?cCs4OHFoeEl4M2VBcU02VEhpRmkwUnFPdE9HbFIzU0lpSkQreER1NTJrY1ox?=
 =?utf-8?B?ZlZzTnhHeEVsODNuSEZTNnl4cXJTQ1h1RDN4WGpaeGdaVy9pSitFdkdKbE1E?=
 =?utf-8?B?S3UvUUJ6eVd0d214T0p3ZXhjUXlVWXVQT0xPL0tqS0lMb0lRQjNGQlBZSTdS?=
 =?utf-8?B?S1RvRDI5bWNEdVJmOXpQK2RXaVB3NUtRRGx4d1hsMUtaZnBwWHljVmRYd1ZL?=
 =?utf-8?B?c2VDVG1GTnNkZkNlYkl1VGFpTEdVOVZNV1lZejJGZFQzK2RYeHFBaUUwREdX?=
 =?utf-8?B?RHVpb05wZWkybHZ1KzcwWmo5TS85a2tHSXZlTVNVTmZZa3MwZDV0NHBoVlBF?=
 =?utf-8?B?ak1sM3ZpdUxqMTdSL2xvNGhOOXNXU0h4c3VvL3dsYUFzZ01JeUNHZzl1Zjlp?=
 =?utf-8?B?VHNHZTgvazdHTUVlL3NuZUs4ZVdLaWhxWUlwUXdSWUpydGtUNHVXMkE2Z01P?=
 =?utf-8?B?Nzd6LzFnenlKSVVRaUxsVEhGcCs3SGNGT1B0MTJjc2NXOGNSK0svcE9pNDlV?=
 =?utf-8?B?NFY4Rml6YlgyaG1RWXFKSG5ZT3YweFU3b1RMaEpkK0Uva0tiRkttbWpnZlI0?=
 =?utf-8?B?NVBQWXJBL1gzZS90T3g5Mnhnd3UyRytESzFjRFg2R0NVR2gwSzhnMkxidkdK?=
 =?utf-8?B?d0NINFVVckxlcHVYaGlaRDQybDNOWmdPZzhUTTREZjhMQXNFaUhZcHJJNHNF?=
 =?utf-8?B?U2thVzNJY2NMK2sydlJnWW1MdkdnUGtBTjJXaGk2Wm40TFAvU0NRNzNVNGxr?=
 =?utf-8?B?bDkwU21GNjlRSWhnTy9FcXFnOVVrTWU5VkIzMzB6TDZiL25PT1ZKbkVBb0dX?=
 =?utf-8?B?Q2RnVTFObmZ4K1RhOXF1UTJnaktDSXJiQ2VvTzNFTERXT2tVOGdTWUQweHRU?=
 =?utf-8?B?YUE4TTU3eTRTVFBWcmJsT05iWmlFaVZvT3dJL1ZvenlJOWhwbW5iZUZnNnJ2?=
 =?utf-8?B?bDNCY3dLTTdtQUFRdWlsSkIyczhYdmI3U2VlSnhNTFpwam1peS9BQzFjWFN1?=
 =?utf-8?B?c2RVYzRoMytVT3MzUENKZStBTjZMRkh3aEoydHlDUzdrNkxRM0RtdnU3Ynd2?=
 =?utf-8?B?NGQ3OEVqYmJ2bHY0eW1qUWJIWjNsZkJ6dUF5SmFGOWdmclpBL2RVRFp0VjQ1?=
 =?utf-8?B?V2htdmsra1BuaFdtVjVuNzZVdW9SMXFueVZ2WVBxZUdFOXhxY1RjM1dST3k5?=
 =?utf-8?B?YmNpZm9qOXpkZGJseE13eGJSL29ud01HekFNWE91VjkyejhlSW9jdzNlMlJC?=
 =?utf-8?B?RWV6aGRpQ0poN0JrQ2svem1pK2dNZk5PMXNqVDhxVWY3VjNNcmNsbHhnQTFy?=
 =?utf-8?B?TUo1YUhTOWN0ZVQveWk2blFwOWFNRTJDZXBLL2N5NEpXVFFXSVo2OEsrWXRn?=
 =?utf-8?B?TENERFBZOWVXYjQraFBPMnZBa3R6TW5oVmd2ck80VXpVSDNsTE5RM1ByczlI?=
 =?utf-8?Q?yL+Pn6FXFoLA8plbNXk/+Oog5?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 655a4a41-688d-40e4-5b79-08dc79805cb9
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2024 10:25:39.8139 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mFyvJ5278u0Me/4PODqzGMGcbUNkAO1zV/iY/UcrgCdSGmbznaV9w8pK2zLklbcKRisp8MWCC9fnKCNx/9mPk/lsXNG5Dr+Hi+WELsw+blk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB7032
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.16;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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
aGUgbGF0ZXN0IGZhdWx0IHJlYXNvbnMgZGVmaW5lZCBieQ0KPnNwZWMNCj4NCj5PbiBNb24sIE1h
eSAyMCwgMjAyNCBhdCAxMjoxNeKAr1BNIExpdSwgWWkgTCA8eWkubC5saXVAaW50ZWwuY29tPiB3
cm90ZToNCj4+DQo+PiA+IEZyb206IER1YW4sIFpoZW56aG9uZyA8emhlbnpob25nLmR1YW5AaW50
ZWwuY29tPg0KPj4gPiBTZW50OiBNb25kYXksIE1heSAyMCwgMjAyNCAxMTo0MSBBTQ0KPj4gPg0K
Pj4gPg0KPj4gPg0KPj4gPiA+LS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4+ID4gPkZyb206
IEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+DQo+PiA+ID5TZW50OiBNb25kYXksIE1h
eSAyMCwgMjAyNCA4OjQ0IEFNDQo+PiA+ID5UbzogRHVhbiwgWmhlbnpob25nIDx6aGVuemhvbmcu
ZHVhbkBpbnRlbC5jb20+DQo+PiA+ID5DYzogcWVtdS1kZXZlbEBub25nbnUub3JnOyBMaXUsIFlp
IEwgPHlpLmwubGl1QGludGVsLmNvbT47IFBlbmcsIENoYW8NCj5QDQo+PiA+ID48Y2hhby5wLnBl
bmdAaW50ZWwuY29tPjsgWXUgWmhhbmcgPHl1LmMuemhhbmdAbGludXguaW50ZWwuY29tPjsNCj5N
aWNoYWVsDQo+PiA+ID5TLiBUc2lya2luIDxtc3RAcmVkaGF0LmNvbT47IFBhb2xvIEJvbnppbmkg
PHBib256aW5pQHJlZGhhdC5jb20+Ow0KPj4gPiA+UmljaGFyZCBIZW5kZXJzb24gPHJpY2hhcmQu
aGVuZGVyc29uQGxpbmFyby5vcmc+OyBFZHVhcmRvIEhhYmtvc3QNCj4+ID4gPjxlZHVhcmRvQGhh
Ymtvc3QubmV0PjsgTWFyY2VsIEFwZmVsYmF1bQ0KPjxtYXJjZWwuYXBmZWxiYXVtQGdtYWlsLmNv
bT4NCj4+ID4gPlN1YmplY3Q6IFJlOiBbUEFUQ0hdIGludGVsX2lvbW11OiBVc2UgdGhlIGxhdGVz
dCBmYXVsdCByZWFzb25zIGRlZmluZWQNCj5ieQ0KPj4gPiA+c3BlYw0KPj4gPiA+DQo+PiA+ID5P
biBGcmksIE1heSAxNywgMjAyNCBhdCA2OjI24oCvUE0gWmhlbnpob25nIER1YW4NCj4+ID4gPjx6
aGVuemhvbmcuZHVhbkBpbnRlbC5jb20+IHdyb3RlOg0KPj4gPiA+Pg0KPj4gPiA+PiBGcm9tOiBZ
dSBaaGFuZyA8eXUuYy56aGFuZ0BsaW51eC5pbnRlbC5jb20+DQo+PiA+ID4+DQo+PiA+ID4+IEN1
cnJlbnRseSB3ZSB1c2Ugb25seSBWVERfRlJfUEFTSURfVEFCTEVfSU5WIGFzIGZhdWx0IHJlYXNv
bi4NCj4+ID4gPj4gVXBkYXRlIHdpdGggbW9yZSBkZXRhaWxlZCBmYXVsdCByZWFzb25zIGxpc3Rl
ZCBpbiBWVC1kIHNwZWMgNy4yLjMuDQo+PiA+ID4+DQo+PiA+ID4+IFNpZ25lZC1vZmYtYnk6IFl1
IFpoYW5nIDx5dS5jLnpoYW5nQGxpbnV4LmludGVsLmNvbT4NCj4+ID4gPj4gU2lnbmVkLW9mZi1i
eTogWmhlbnpob25nIER1YW4gPHpoZW56aG9uZy5kdWFuQGludGVsLmNvbT4NCj4+ID4gPj4gLS0t
DQo+PiA+ID4NCj4+ID4gPkkgd29uZGVyIGlmIHRoaXMgY291bGQgYmUgbm90aWNlZCBieSB0aGUg
Z3Vlc3Qgb3Igbm90LiBJZiB5ZXMgc2hvdWxkDQo+PiA+ID53ZSBjb25zaWRlciBzdGFydGluZyB0
byBhZGQgdGhpbmcgbGlrZSB2ZXJzaW9uIHRvIHZ0ZCBlbXVsYXRpb24gY29kZT8NCj4+ID4NCj4+
ID4gS2VybmVsIG9ubHkgZHVtcHMgdGhlIHJlYXNvbiBsaWtlIGJlbG93Og0KPj4gPg0KPj4gPiBE
TUFSOiBbRE1BIFdyaXRlIE5PX1BBU0lEXSBSZXF1ZXN0IGRldmljZSBbMjA6MDAuMF0gZmF1bHQg
YWRkcg0KPjB4MTIzNDYwMDAwMA0KPj4gPiBbZmF1bHQgcmVhc29uIDB4NzFdIFNNOiBQcmVzZW50
IGJpdCBpbiBmaXJzdC1sZXZlbCBwYWdpbmcgZW50cnkgaXMgY2xlYXINCj4+DQo+PiBZZXMsIGd1
ZXN0IGtlcm5lbCB3b3VsZCBub3RpY2UgaXQgYXMgdGhlIGZhdWx0IHdvdWxkIGJlIGluamVjdGVk
IHRvIHZtLg0KPj4NCj4+ID4gTWF5YmUgYnVtcCAxLjAgLT4gMS4xPw0KPj4gPiBNeSB1bmRlcnN0
YW5kaW5nIHZlcnNpb24gbnVtYmVyIGlzIG9ubHkgaW5mb3JtYXRpb25hbCBhbmQgaXMgZmFyIGZy
b20NCj4+ID4gYWNjdXJhdGUgdG8gbWFyayBpZiBhIGZlYXR1cmUgc3VwcG9ydGVkLiBEcml2ZXIg
c2hvdWxkIGNoZWNrIGNhcC9lY2FwDQo+PiA+IGJpdHMgaW5zdGVhZC4NCj4+DQo+PiBTaG91bGQg
dGhlIHZlcnNpb24gSUQgaGVyZSBiZSBhbGlnbmVkIHdpdGggVlQtZCBzcGVjPw0KPg0KPlByb2Jh
Ymx5LCB0aGlzIG1pZ2h0IGJlIHNvbWV0aGluZyB0aGF0IGNvdWxkIGJlIG5vdGljZWQgYnkgdGhl
DQo+bWFuYWdlbWVudCB0byBtaWdyYXRpb24gY29tcGF0aWJpbGl0eS4NCg0KQ291bGQgeW91IGVs
YWJvcmF0ZSB3aGF0IHdlIG5lZWQgdG8gZG8gZm9yIG1pZ3JhdGlvbiBjb21wYXRpYmlsaXR5Pw0K
SSBzZWUgdmVyc2lvbiBpcyBhbHJlYWR5IGV4cG9ydGVkIHNvIGxpYnZpcnQgY2FuIHF1ZXJ5IGl0
LCBzZWU6DQoNCiAgICBERUZJTkVfUFJPUF9VSU5UMzIoInZlcnNpb24iLCBJbnRlbElPTU1VU3Rh
dGUsIHZlcnNpb24sIDApLA0KDQpUaGFua3MNClpoZW56aG9uZw0KDQo+DQo+PiBJZiB5ZXMsIGl0
IHNob3VsZA0KPj4gYmUgMy4wIGFzIHRoZSBzY2FsYWJsZSBtb2RlIHdhcyBpbnRyb2R1Y2VkIGlu
IHNwZWMgMy4wLiBBbmQgdGhlIGZhdWx0DQo+PiBjb2RlIHdhcyByZWRlZmluZWQgdG9nZXRoZXIg
d2l0aCB0aGUgaW50cm9kdWN0aW9uIG9mIHRoaXMgdHJhbnNsYXRpb24NCj4+IG1vZGUuIEJlbG93
IGlzIHRoZSBhIHNuaXBwZXQgZnJvbSB0aGUgY2hhbmdlIGxvZyBvZiBWVC1kIHNwZWMuDQo+Pg0K
Pj4gSnVuZSAyMDE4IDMuMA0KPj4g4oCiIFJlbW92ZWQgYWxsIHRleHQgcmVsYXRlZCB0byBFeHRl
bmRlZC1Nb2RlLg0KPj4g4oCiIEFkZGVkIHN1cHBvcnQgZm9yIHNjYWxhYmxlLW1vZGUgdHJhbnNs
YXRpb24gZm9yIERNQSBSZW1hcHBpbmcsIHRoYXQNCj5lbmFibGVzIFBBU0lEZ3JhbnVsYXIgZmly
c3QtbGV2ZWwsIHNlY29uZC1sZXZlbCwgbmVzdGVkIGFuZCBwYXNzLXRocm91Z2gNCj50cmFuc2xh
dGlvbiBmdW5jdGlvbnMuDQo+PiDigKIgV2lkZW4gaW52YWxpZGF0aW9uIHF1ZXVlIGRlc2NyaXB0
b3JzIGFuZCBwYWdlIHJlcXVlc3QgcXVldWUNCj5kZXNjcmlwdG9ycyBmcm9tIDEyOCBiaXRzDQo+
PiB0byAyNTYgYml0cyBhbmQgcmVkZWZpbmVkIHBhZ2UtcmVxdWVzdCBhbmQgcGFnZS1yZXNwb25z
ZSBkZXNjcmlwdG9ycy4NCj4+IOKAoiBMaXN0ZWQgYWxsIGZhdWx0IGNvbmRpdGlvbnMgaW4gYSB1
bmlmaWVkIHRhYmxlIGFuZCBkZXNjcmliZWQgRE1BDQo+UmVtYXBwaW5nIGhhcmR3YXJlDQo+PiBi
ZWhhdmlvciB1bmRlciBlYWNoIGNvbmRpdGlvbi4gQXNzaWduZWQgbmV3IGNvZGUgZm9yIGVhY2gg
ZmF1bHQgY29uZGl0aW9uDQo+aW4gc2NhbGFibGVtb2RlIG9wZXJhdGlvbi4NCj4+IOKAoiBBZGRl
ZCBzdXBwb3J0IGZvciBBY2Nlc3NlZC9EaXJ0eSAoQS9EKSBiaXRzIGluIHNlY29uZC1sZXZlbCB0
cmFuc2xhdGlvbi4NCj4+IOKAoiBBZGRlZCBzdXBwb3J0IGZvciBzdWJtaXR0aW5nIGNvbW1hbmRz
IGFuZCByZWNlaXZpbmcgcmVzcG9uc2UgZnJvbQ0KPnZpcnR1YWwgRE1BDQo+PiBSZW1hcHBpbmcg
aGFyZHdhcmUuDQo+PiDigKIgQWRkZWQgYSB0YWJsZSBvbiBzbm9vcGluZyBiZWhhdmlvciBhbmQg
bWVtb3J5IHR5cGUgb2YgaGFyZHdhcmUNCj5hY2Nlc3MgdG8gdmFyaW91cw0KPj4gcmVtYXBwaW5n
IHN0cnVjdHVyZXMgYXMgYXBwZW5kaXguDQo+PiDigKIgTW92ZSBQYWdlIFJlcXVlc3QgT3ZlcmZs
b3cgKFBSTykgZmF1bHQgcmVwb3J0aW5nIGZyb20gRmF1bHQgU3RhdHVzDQo+cmVnaXN0ZXINCj4+
IChGU1RTX1JFRykgdG8gUGFnZSBSZXF1ZXN0IFN0YXR1cyByZWdpc3RlciAoUFJTX1JFRykuDQo+
Pg0KPj4gUmVnYXJkcy4NCj4+IFlpIExpdQ0KPg0KPlRoYW5rcw0KDQo=

