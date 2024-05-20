Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BE16C25B79
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2024 04:16:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s8uRM-0004Ha-1T; Mon, 20 May 2024 00:16:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1s8uRB-0004HG-SK
 for qemu-devel@nongnu.org; Mon, 20 May 2024 00:15:50 -0400
Received: from mgamail.intel.com ([192.198.163.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1s8uR6-0004rd-G7
 for qemu-devel@nongnu.org; Mon, 20 May 2024 00:15:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1716178544; x=1747714544;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=rW6+sOzoZBUpqGWhlmvg7YNeKwRsWYs3+Ga9kCCjAiQ=;
 b=bWuC7umNMrV4Jz/8+jOm9zPzg19PHSDiLfv1N2MljTz762VgmlB6lnJy
 rkWvka8tsLZfWkt4lzsGvwRjal70x0Hr9Z8kOJkiwEGkr9qGHDr2SIM3B
 V+iOAczP6jxc6MceQ+tCoYcvetgCzO2Z/oA7oD4ZyMT+eW5EtygKh4+rI
 TOoeE+K13a7LyFYGR8Trpd43OCIcjFCyJ5vZ/56Dr0vUFagJ7wgRkt52s
 i6FYVU1EFnpG1gHp1hshDCdT6rAzNmP4yH7jqrDPSLJ1QspXiEvDb6nyG
 T+Jxp4K12Wz+d90g7B6dNsnZh0ZwGoF+IWZGq5eYdjiagWYV7/jler3aN A==;
X-CSE-ConnectionGUID: Y3+h1tC1STWDG6LnprH4ww==
X-CSE-MsgGUID: f+pMfPvyTLCPajR3zrHQeg==
X-IronPort-AV: E=McAfee;i="6600,9927,11077"; a="22959225"
X-IronPort-AV: E=Sophos;i="6.08,174,1712646000"; d="scan'208";a="22959225"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 May 2024 21:15:41 -0700
X-CSE-ConnectionGUID: JvkK8NNjTNuvUwUa/0hsZg==
X-CSE-MsgGUID: bK5fYP5LQNaNsZISa8cp+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,174,1712646000"; d="scan'208";a="69835943"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
 by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 19 May 2024 21:15:40 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 19 May 2024 21:15:40 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Sun, 19 May 2024 21:15:40 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.100)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Sun, 19 May 2024 21:15:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dRhdtuJL1fPDp0RV9d6W6JBPRQPFqXFlt6he45eCorLeG6Qc7rMsIoxJZBW/YQnUlnE9u9OKQrAqUdR+5P+W8XnAsOFdibOqORgj3rTHuACT99MHgevJn33gHzsCD72xcfLRPvu7BxMygYHzvhORtRZq0E+nemBaSyFqU3pV17NaxdfT+Jb5Fa1iHkBF+SvKWwb5GPt/0m6UOK9r70rnKS1WVLLcPPsW42akKMipGIA+oGE0aGMSYivtPoEu91VMbSeMeP39yBq4KPP05Cu9aDOkdhCV58rCYXmdT9eNXQFyN8I0lY7Y7JZ+6Phmd8oMM+2jwbOCi2g8khBmsPNhyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rW6+sOzoZBUpqGWhlmvg7YNeKwRsWYs3+Ga9kCCjAiQ=;
 b=UfImIRrd19cJQjEqGpT7PM924ysn0nQV4H7b8MDuvWS7hmb0s2UunmLX/fLR3CKC23r02excU9vxEWMMmuVOrMAppLGKGw3e7QP7Kl0WcDFrX10OHu4MNKc5hC3MYq5sy/m+xFg1hQAFLDuTONePmQR7d2IYXIrOw1gGcBRKvLk3hM7Pgk9z5D+i9HcRlPFqHNBtJdJ4UZ8wSxilfUBLQ0WzewOxLzu1mObMN6CDE2j3Ek/7VSD2N9VTde5E7SDLjmqd9hLudViBtpF38nXfF3KThy+BmL53kYRFEhTduL4vJpcxEaNxBolgw3sEJFSQyz3Ik1f1CVSwxU7hColYjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by CYYPR11MB8386.namprd11.prod.outlook.com (2603:10b6:930:bf::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.28; Mon, 20 May
 2024 04:15:37 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a%7]) with mapi id 15.20.7587.030; Mon, 20 May 2024
 04:15:37 +0000
From: "Liu, Yi L" <yi.l.liu@intel.com>
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>, Jason Wang
 <jasowang@redhat.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "Peng, Chao P"
 <chao.p.peng@intel.com>, Yu Zhang <yu.c.zhang@linux.intel.com>, "Michael S.
 Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "Richard
 Henderson" <richard.henderson@linaro.org>, Eduardo Habkost
 <eduardo@habkost.net>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: RE: [PATCH] intel_iommu: Use the latest fault reasons defined by spec
Thread-Topic: [PATCH] intel_iommu: Use the latest fault reasons defined by spec
Thread-Index: AQHaqESnTCEgSFc1NkKmPwe8IhjJm7GfTQkAgAAxhACAAAfs4A==
Date: Mon, 20 May 2024 04:15:37 +0000
Message-ID: <DS0PR11MB752917B52B66A6EF10C10678C3E92@DS0PR11MB7529.namprd11.prod.outlook.com>
References: <20240517102334.81943-1-zhenzhong.duan@intel.com>
 <CACGkMEvTomFeC1bM3SfY1zGhQ_5i15r6CY6M3jVzau6niNUf_w@mail.gmail.com>
 <SJ0PR11MB6744AECEAA6F9319259B0DF192E92@SJ0PR11MB6744.namprd11.prod.outlook.com>
In-Reply-To: <SJ0PR11MB6744AECEAA6F9319259B0DF192E92@SJ0PR11MB6744.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR11MB7529:EE_|CYYPR11MB8386:EE_
x-ms-office365-filtering-correlation-id: 02cb6505-1796-4db1-c07c-08dc788380b5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|366007|376005|1800799015|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?cTd1ZUltdEZoYkUySFluN240MXl4bHBZdTIyeUFjelNXYXExejF3Y1hXcW1z?=
 =?utf-8?B?RVZ2bFpyb0RYcmV0bFQwdldLVDE1SVRtQVhlK0REamgrbTRCTE5XN2tQU2xW?=
 =?utf-8?B?aUtVZ29HTDZ3cU52VHlEY3RhWU1hc2t1dytXZlEwY2xwYldKbzNzWnc2emFG?=
 =?utf-8?B?VGZZTDNRMDM5SkdSMHN2OVIxMFhpWFJ6TUpWcmNCREhKTmpjdlMya3lLN3gw?=
 =?utf-8?B?cHZ6NDVoVHZVZ2pFYll3ZUJTYlVxVEFqNjU2eEZUSXNIUFQ4azJxZW5HRkVV?=
 =?utf-8?B?VU9VRHBTNi9hb1pGNnpMQ0NZMW5yTmE4QmU5eFErOW1EM3BSeEp6Z1A4a2tQ?=
 =?utf-8?B?KytSVjZmTEpPNlBiUm40RHAwVTkyOEZDcjZtNHFHN2lsZVlLNHFRQUlVUVhm?=
 =?utf-8?B?aXp4NG1xK1JUTTNwaTNWT3ZJMkNzczBKU0VzdktNV1JITXZCTVl3eTJ0U2tq?=
 =?utf-8?B?aVcwc2JMM0ptYXZ0cFFQeTJFNjhhY1pqVWY1Y3k2ZVpiOEN6M2U4Q29FRk0x?=
 =?utf-8?B?RDVhdlpXS21YNFdtak5OVnBkcnYzT2hDelk2TlBZMCt1dHRKOGtNOFQxSW5v?=
 =?utf-8?B?L2dVMUZtVGg1OWVwS2kwR2F6YmJta3A2VkZ3WXc3V3hhTm5Vb3RuQWxCa3or?=
 =?utf-8?B?My9EOHBtZGlsdUt5U0l1SGwrNXJMbmdxcXFlSXR6WGtBb0t4d0Myb2Z4WW04?=
 =?utf-8?B?eFZIUTErRVpXcnZxWHduM1o4OHIxZG9NRVBJYVRsb211bWRDaUFxQlVRdEx3?=
 =?utf-8?B?REx0QkVZNnl6UHMvcHBJcGRxSkRjZ3g4WUVybkdhdkVqOTBUek82TitINm1s?=
 =?utf-8?B?VTZzL0UyT2FIVTBBL2FGaHJhRFRjblhIMUdYYzRYTzdWM0dGZEVHYStuRUdj?=
 =?utf-8?B?TkszcEk2NVNCbEt4Z2x1a3FWczJSenRvdld1QnlUakx1VmQ2dFVmZXQ4TmFj?=
 =?utf-8?B?emR4YzVoWmlQYzVFRFJ6bDNHK2hISGM5Mkx6MUVzdE8vSFVVdTFVaXYyUnZV?=
 =?utf-8?B?MkhOSncwYS8rWVl0VDIzbXYyMGUvRjZJTjJGMEgveVQ3OE5YaDVrenFBT0Vm?=
 =?utf-8?B?S3EraGgzUGNBN2JpbTVvODI0QlI2R2Z3SEFFOWtoVW5ReENCeU9vTlZuaTlJ?=
 =?utf-8?B?RndxSXdmUVpZTjU4eWNVVGlCS3BkNzdTODZidDZLRXBQTnJYY1RFdUJnZi9p?=
 =?utf-8?B?OWtlZnZpdnJaWTcvTkRkbThnSHplQTF6d2tERjBDUlhqUlZoSUJWYWU3dmlQ?=
 =?utf-8?B?c0FWMUVyNW5DWDZDSXkveGxDcE9uL0syZnFyY1huL3Q5bWlFcnFiajl0TVlp?=
 =?utf-8?B?TGo0UnhqdlgxSGYrczRCV0EwK2pZamptd29IRUZDS3VnWTdVTjk2dVVqckJK?=
 =?utf-8?B?cUZYQzE1ZitGOXI3U3JSZmRGbG9NWmEwSys5ckxENVF3L1NjK2EyMVQ3RGR4?=
 =?utf-8?B?K01QSWlKQmt3dE52YmRxMERaVVNMU1dDclpXSmgwYU0zR3F2ekdLNE1IdXlz?=
 =?utf-8?B?S0xySHlBSTFpMlM0UzBUcncvTmFNaktvY2ZEeU9IRmVCSThtbkdENkZFQ3lu?=
 =?utf-8?B?RjVlRFR6UE8rN2szaE9uTkpCOGp2bUVEWEJnR1dFYkt0WGdQbzY3akh5WmVD?=
 =?utf-8?B?N3gya0k0Qjk2V2cyN1J2dEJZR0pDQjUrSVpoc1Z3TkFZd0xzVE0rRVhDRGFz?=
 =?utf-8?B?VTFYQW1vMUQ3anptbG9YWXhMREM4M05hYXgrbW0vZFNRSC9RMGluS0xyYTI4?=
 =?utf-8?B?NXFJMmJwYUVGNEFoTVYzZWxDSzFtbU1KUDhlbDVnVnN1QVBzOWRONEtrelhl?=
 =?utf-8?B?aXM2MnF3Z0NFRzRHdjFHUT09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7529.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(1800799015)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YmNUbjNZU1kySkdMaDhQTFU2MlN3NnlZWW13a2x0ZnVsSlJzcU9SSlVueVh4?=
 =?utf-8?B?OTBaellhUm9WcDdlVy82V05ySUQxOGpzTElIbzdOTkZVelJPY2FzdEZBOW13?=
 =?utf-8?B?YnVWS2o3RXhPd1ZjSDJEZDJ3aGR5SDU1bE5seVNEZm9lZTI1Rk82Z09HYTYv?=
 =?utf-8?B?cVNuSUZ3dm9NZURZS1RqTFM3NldsRzJUZWJDZGNtT0ZoM0NvUW10aVUwWUQ2?=
 =?utf-8?B?NERGS3pxZFdJR0ZLajAwU3g1UHUrQzBzTG1QOW9YUmMwdmhSODVUakc0U09B?=
 =?utf-8?B?RXNsYmN6b3lSYjBpMVF0dmh3bUtteVFhcXFLYUV2ZkpwZGh5Q2ZFenR6WGlR?=
 =?utf-8?B?M29qNlNVYklCbTl1SktmWXMrbWYxK1owQldwcmxsZU1UN0Q0OWNSQU5Temt2?=
 =?utf-8?B?WFF3Z2RiUlg1eitpMlZiTjJhMUZnd213bEMzM1ZtMUQwNnh4WVlyYzV2N2I0?=
 =?utf-8?B?ZUZwZ09JY0RycmRuSzV2TVU2RzBMQkV6N0tqSjN2RitvNEpWT29jdVhSZm5X?=
 =?utf-8?B?SXp0dEorSXNmaFRPNlZIU1VQeVY5NEZDWjgyVkY5ZDZaenBoZnQ2bTF0OEkv?=
 =?utf-8?B?bkFHSjZJc1ZybUhxSjdwaVkwQjJTSHhieGJHVU5PSE52RE5WVUU5M3FOTVEx?=
 =?utf-8?B?NEk4d0p4cWdUTmRBOFN2TWNXWWpUbHdiSTlVN0Z0RWhldGVOeXducEdJdlBq?=
 =?utf-8?B?SWhtWnlGQzlEaXdZUWUwZzlRWUJoNjFBNjE5bGFnZSs4dHhpaFY2dTlJaGZh?=
 =?utf-8?B?eUdSV2VvWm43RDZtSFV1cDIyRHVDa3krZy9VbFRWYlFzRnRLZzNhYnNmdUJr?=
 =?utf-8?B?bUt3b0t1bzA5SkFsTjMrUzRvSGwveGhwN3I5MFRqZXBBVTZwMVkra0kzTzRu?=
 =?utf-8?B?ZjVlc0FHRHVmdm1iNDg4S1RaWVlSY3pCV0paSDZYUWgzeFJrOExrMUtFRFdZ?=
 =?utf-8?B?emUvY0VrMW95OUtuQ29Hb2xhSTgySE1JdEJ3YkFuUjF4dWhPcmNKMGFxVjh1?=
 =?utf-8?B?N1JLajUvQnFRemx6M3BETkx6VVdVVXNlTzJRV3RTUUhHL252SnZSTWhJUSt0?=
 =?utf-8?B?bVJ0dkczZy81VW5JQ1dWdkVIRkg3YWVWczV1VXlUS0dwWlRuUWFBUWdGcEJS?=
 =?utf-8?B?VkQzWWVKZDcreFFmWDkxN3FhcER4VlloVUpGZ2dyOUZHbzRqTXFDd3JJNmVO?=
 =?utf-8?B?Zys3Vnc1R29NTGYySUkyL0NtNXhqaVBPZjhZMk45cTRGVmdPaTFIaXVNTFFU?=
 =?utf-8?B?d2Y2cjlaVHhMOHY4NEZ3Mk9OcjdpVm1xS09aUnNCOWd3ckQ3Ni9kakFkVklZ?=
 =?utf-8?B?aWo5YjMrYlVZcGRGcWFwamNsL0ZGL2xGN1kvajhyR2RqbHczL3Z1dDRlSUpU?=
 =?utf-8?B?d3pRNjRuRUVabW1jZXdFM2hxVk9OSmk1dFdocjlGNXFWV3JISTErZnJ4MDha?=
 =?utf-8?B?SnVBNzM2SkdDamd3bEx1YmFCcmlyeDhNNmtFTTcrb2I1eS9peW9SeDBmaWs2?=
 =?utf-8?B?Vk4rbFh3MFl6alU4OGw5czhUTzM1SXlWdFBWcnlZWE4xd2ZSZ2tuYnpoNmFH?=
 =?utf-8?B?L2JuUlYzUEtlV0NhRXEvRnJ5dXhSYTJEdWFDbW8vTWpuSWYvMXVsSHg0REdr?=
 =?utf-8?B?eFh0LzBvTnl3aUg1RVA5QWwyM25YM3hyQmlsOXFqbTRjYzNsUjRZMWJYSUdz?=
 =?utf-8?B?aGVFS3VjbEFNV1N5eUZqUWZyeTJJMlZDRHI2cmZ5YkVla2cyN0VmR2Q1bWxl?=
 =?utf-8?B?WFVtOFBITWxZYWJGak0vY2pKcm1VRlpBL1U1U09lRW5QWFQ4TExSTHBhNTRE?=
 =?utf-8?B?dG5YeHE3QUJva2JFekxBb2J6bzliKzJ3amNvSFlmYmR4YmR1WTE2UWNBUi8x?=
 =?utf-8?B?WTVuS3J3RVc5RHVnc2dUakFuMXdxTU56MzN0SUdHSVA3aUU1eUcrY01neksw?=
 =?utf-8?B?dGc2L1NCenhWVkV3aW8ydGdWOWVkVGxZUFR2QkFRTHk4Q0NJWnJXdzM4dS83?=
 =?utf-8?B?d3FxZmFzZjVLdFljc09CRnpoYlFxb0MvN2w0TUM4U2VRdUhuTlcwQmk0VCtR?=
 =?utf-8?B?bkZGeGhrd1RjMS9saHo5czZEQTJRS2x1eEpkM0E2cnFFUGZLOUFoc1Z6TGlw?=
 =?utf-8?Q?PsWpoBXQuS3KIqoMFMFFjwAi/?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02cb6505-1796-4db1-c07c-08dc788380b5
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 May 2024 04:15:37.4799 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ccA+wu/akg8JuLrddUYEG1qneEe2ekwtvrDA3f8fuS6dGFSOwZhgyp8Gx1fKd4ECzkwi8pGKmCnBa3kNx33tgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR11MB8386
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.9; envelope-from=yi.l.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

PiBGcm9tOiBEdWFuLCBaaGVuemhvbmcgPHpoZW56aG9uZy5kdWFuQGludGVsLmNvbT4NCj4gU2Vu
dDogTW9uZGF5LCBNYXkgMjAsIDIwMjQgMTE6NDEgQU0NCj4gDQo+IA0KPiANCj4gPi0tLS0tT3Jp
Z2luYWwgTWVzc2FnZS0tLS0tDQo+ID5Gcm9tOiBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQu
Y29tPg0KPiA+U2VudDogTW9uZGF5LCBNYXkgMjAsIDIwMjQgODo0NCBBTQ0KPiA+VG86IER1YW4s
IFpoZW56aG9uZyA8emhlbnpob25nLmR1YW5AaW50ZWwuY29tPg0KPiA+Q2M6IHFlbXUtZGV2ZWxA
bm9uZ251Lm9yZzsgTGl1LCBZaSBMIDx5aS5sLmxpdUBpbnRlbC5jb20+OyBQZW5nLCBDaGFvIFAN
Cj4gPjxjaGFvLnAucGVuZ0BpbnRlbC5jb20+OyBZdSBaaGFuZyA8eXUuYy56aGFuZ0BsaW51eC5p
bnRlbC5jb20+OyBNaWNoYWVsDQo+ID5TLiBUc2lya2luIDxtc3RAcmVkaGF0LmNvbT47IFBhb2xv
IEJvbnppbmkgPHBib256aW5pQHJlZGhhdC5jb20+Ow0KPiA+UmljaGFyZCBIZW5kZXJzb24gPHJp
Y2hhcmQuaGVuZGVyc29uQGxpbmFyby5vcmc+OyBFZHVhcmRvIEhhYmtvc3QNCj4gPjxlZHVhcmRv
QGhhYmtvc3QubmV0PjsgTWFyY2VsIEFwZmVsYmF1bSA8bWFyY2VsLmFwZmVsYmF1bUBnbWFpbC5j
b20+DQo+ID5TdWJqZWN0OiBSZTogW1BBVENIXSBpbnRlbF9pb21tdTogVXNlIHRoZSBsYXRlc3Qg
ZmF1bHQgcmVhc29ucyBkZWZpbmVkIGJ5DQo+ID5zcGVjDQo+ID4NCj4gPk9uIEZyaSwgTWF5IDE3
LCAyMDI0IGF0IDY6MjbigK9QTSBaaGVuemhvbmcgRHVhbg0KPiA+PHpoZW56aG9uZy5kdWFuQGlu
dGVsLmNvbT4gd3JvdGU6DQo+ID4+DQo+ID4+IEZyb206IFl1IFpoYW5nIDx5dS5jLnpoYW5nQGxp
bnV4LmludGVsLmNvbT4NCj4gPj4NCj4gPj4gQ3VycmVudGx5IHdlIHVzZSBvbmx5IFZURF9GUl9Q
QVNJRF9UQUJMRV9JTlYgYXMgZmF1bHQgcmVhc29uLg0KPiA+PiBVcGRhdGUgd2l0aCBtb3JlIGRl
dGFpbGVkIGZhdWx0IHJlYXNvbnMgbGlzdGVkIGluIFZULWQgc3BlYyA3LjIuMy4NCj4gPj4NCj4g
Pj4gU2lnbmVkLW9mZi1ieTogWXUgWmhhbmcgPHl1LmMuemhhbmdAbGludXguaW50ZWwuY29tPg0K
PiA+PiBTaWduZWQtb2ZmLWJ5OiBaaGVuemhvbmcgRHVhbiA8emhlbnpob25nLmR1YW5AaW50ZWwu
Y29tPg0KPiA+PiAtLS0NCj4gPg0KPiA+SSB3b25kZXIgaWYgdGhpcyBjb3VsZCBiZSBub3RpY2Vk
IGJ5IHRoZSBndWVzdCBvciBub3QuIElmIHllcyBzaG91bGQNCj4gPndlIGNvbnNpZGVyIHN0YXJ0
aW5nIHRvIGFkZCB0aGluZyBsaWtlIHZlcnNpb24gdG8gdnRkIGVtdWxhdGlvbiBjb2RlPw0KPg0K
PiBLZXJuZWwgb25seSBkdW1wcyB0aGUgcmVhc29uIGxpa2UgYmVsb3c6DQo+IA0KPiBETUFSOiBb
RE1BIFdyaXRlIE5PX1BBU0lEXSBSZXF1ZXN0IGRldmljZSBbMjA6MDAuMF0gZmF1bHQgYWRkciAw
eDEyMzQ2MDAwMDANCj4gW2ZhdWx0IHJlYXNvbiAweDcxXSBTTTogUHJlc2VudCBiaXQgaW4gZmly
c3QtbGV2ZWwgcGFnaW5nIGVudHJ5IGlzIGNsZWFyDQoNClllcywgZ3Vlc3Qga2VybmVsIHdvdWxk
IG5vdGljZSBpdCBhcyB0aGUgZmF1bHQgd291bGQgYmUgaW5qZWN0ZWQgdG8gdm0uIA0KDQo+IE1h
eWJlIGJ1bXAgMS4wIC0+IDEuMT8NCj4gTXkgdW5kZXJzdGFuZGluZyB2ZXJzaW9uIG51bWJlciBp
cyBvbmx5IGluZm9ybWF0aW9uYWwgYW5kIGlzIGZhciBmcm9tDQo+IGFjY3VyYXRlIHRvIG1hcmsg
aWYgYSBmZWF0dXJlIHN1cHBvcnRlZC4gRHJpdmVyIHNob3VsZCBjaGVjayBjYXAvZWNhcA0KPiBi
aXRzIGluc3RlYWQuDQoNClNob3VsZCB0aGUgdmVyc2lvbiBJRCBoZXJlIGJlIGFsaWduZWQgd2l0
aCBWVC1kIHNwZWM/IElmIHllcywgaXQgc2hvdWxkDQpiZSAzLjAgYXMgdGhlIHNjYWxhYmxlIG1v
ZGUgd2FzIGludHJvZHVjZWQgaW4gc3BlYyAzLjAuIEFuZCB0aGUgZmF1bHQNCmNvZGUgd2FzIHJl
ZGVmaW5lZCB0b2dldGhlciB3aXRoIHRoZSBpbnRyb2R1Y3Rpb24gb2YgdGhpcyB0cmFuc2xhdGlv
bg0KbW9kZS4gQmVsb3cgaXMgdGhlIGEgc25pcHBldCBmcm9tIHRoZSBjaGFuZ2UgbG9nIG9mIFZU
LWQgc3BlYy4NCg0KSnVuZSAyMDE4IDMuMA0K4oCiIFJlbW92ZWQgYWxsIHRleHQgcmVsYXRlZCB0
byBFeHRlbmRlZC1Nb2RlLg0K4oCiIEFkZGVkIHN1cHBvcnQgZm9yIHNjYWxhYmxlLW1vZGUgdHJh
bnNsYXRpb24gZm9yIERNQSBSZW1hcHBpbmcsIHRoYXQgZW5hYmxlcyBQQVNJRGdyYW51bGFyIGZp
cnN0LWxldmVsLCBzZWNvbmQtbGV2ZWwsIG5lc3RlZCBhbmQgcGFzcy10aHJvdWdoIHRyYW5zbGF0
aW9uIGZ1bmN0aW9ucy4NCuKAoiBXaWRlbiBpbnZhbGlkYXRpb24gcXVldWUgZGVzY3JpcHRvcnMg
YW5kIHBhZ2UgcmVxdWVzdCBxdWV1ZSBkZXNjcmlwdG9ycyBmcm9tIDEyOCBiaXRzDQp0byAyNTYg
Yml0cyBhbmQgcmVkZWZpbmVkIHBhZ2UtcmVxdWVzdCBhbmQgcGFnZS1yZXNwb25zZSBkZXNjcmlw
dG9ycy4NCuKAoiBMaXN0ZWQgYWxsIGZhdWx0IGNvbmRpdGlvbnMgaW4gYSB1bmlmaWVkIHRhYmxl
IGFuZCBkZXNjcmliZWQgRE1BIFJlbWFwcGluZyBoYXJkd2FyZQ0KYmVoYXZpb3IgdW5kZXIgZWFj
aCBjb25kaXRpb24uIEFzc2lnbmVkIG5ldyBjb2RlIGZvciBlYWNoIGZhdWx0IGNvbmRpdGlvbiBp
biBzY2FsYWJsZW1vZGUgb3BlcmF0aW9uLg0K4oCiIEFkZGVkIHN1cHBvcnQgZm9yIEFjY2Vzc2Vk
L0RpcnR5IChBL0QpIGJpdHMgaW4gc2Vjb25kLWxldmVsIHRyYW5zbGF0aW9uLg0K4oCiIEFkZGVk
IHN1cHBvcnQgZm9yIHN1Ym1pdHRpbmcgY29tbWFuZHMgYW5kIHJlY2VpdmluZyByZXNwb25zZSBm
cm9tIHZpcnR1YWwgRE1BDQpSZW1hcHBpbmcgaGFyZHdhcmUuDQrigKIgQWRkZWQgYSB0YWJsZSBv
biBzbm9vcGluZyBiZWhhdmlvciBhbmQgbWVtb3J5IHR5cGUgb2YgaGFyZHdhcmUgYWNjZXNzIHRv
IHZhcmlvdXMNCnJlbWFwcGluZyBzdHJ1Y3R1cmVzIGFzIGFwcGVuZGl4Lg0K4oCiIE1vdmUgUGFn
ZSBSZXF1ZXN0IE92ZXJmbG93IChQUk8pIGZhdWx0IHJlcG9ydGluZyBmcm9tIEZhdWx0IFN0YXR1
cyByZWdpc3Rlcg0KKEZTVFNfUkVHKSB0byBQYWdlIFJlcXVlc3QgU3RhdHVzIHJlZ2lzdGVyIChQ
UlNfUkVHKS4NCg0KUmVnYXJkcy4NCllpIExpdQ0K

