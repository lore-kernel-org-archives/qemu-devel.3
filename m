Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95870C25B75
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2024 08:45:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sA44J-0000VA-3m; Thu, 23 May 2024 04:45:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sA44H-0000UW-P0; Thu, 23 May 2024 04:44:57 -0400
Received: from mgamail.intel.com ([198.175.65.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sA44F-0006M0-7U; Thu, 23 May 2024 04:44:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1716453896; x=1747989896;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=WtUh277q00n+gLbZTe50cRYhBzn+ebIu7yOqw2c6a8o=;
 b=Itv/H0IWpl7uXJRL0ojUqY5XGNaTAncTw0IFRaWX2Knt8FtQrPvX58ad
 PRZsJAvOW7F42zqGaGkqLNg24DmeJN9hC5TXCDwfIn5ODs6Ho+ubKeTMV
 HCVVg4QTIZBcnnfV2kWUt8GhzgJYngyMHqBnAtb+Ghy9i5sLSfr8mrOYw
 razJ5vnMqi+AcissvhEaEgm0zb50EvEPlgIA70fCKcC50o+0uCbK5sRKm
 6VgjCpplAR3U/JxUl5qk2GdKmICdbGyUrWQcXWmPTYU1kTLxTOkpJf5SL
 rroy5wG9NH/NEMjy/kxZi+JiC/S1GRADmJaS8YapIPeXPI7m78suN9Fhk A==;
X-CSE-ConnectionGUID: 8+BNrIj4TSW4LmHxyM0/aQ==
X-CSE-MsgGUID: Pbffj2L8TFm9w2fYLq3tkQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11080"; a="23889612"
X-IronPort-AV: E=Sophos;i="6.08,182,1712646000"; d="scan'208";a="23889612"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 May 2024 01:44:51 -0700
X-CSE-ConnectionGUID: kmzJl1nnQ2usWY/z4JL8eQ==
X-CSE-MsgGUID: YVEHWd09R2yZf7jgRPAMUw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,182,1712646000"; d="scan'208";a="33698426"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
 by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 23 May 2024 01:44:50 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 23 May 2024 01:44:49 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 23 May 2024 01:44:49 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 23 May 2024 01:44:49 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 23 May 2024 01:44:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WC2JPfCTv/MREqVDTX19fGbGFqKodq+KYQEKjeBxJSmWvHbY5PJc0xGx+fKKIKqMMWT6uWHFF/ZyLEp/4HpvcAejODj1tQiyl1XvoVtkjQXOPqS6KZZKthf1ayQiEtYvPwsPL7EMUCkFWPmBzL9ztrw6s8jVHIEpo2Pmk3eLbB9qNqvFhLWeW2FSP1ouAOS/ywi4b+Rqon0meSeyJeHd3hKcx8RYqE4fLoMW60BHM8+3R6Dvw1Fni+j6vLmF1aEA9rEF8xx0jKOdYB5d5SuCNJATAXXEwQChUSL5Z7CM+ZErFBRtoZcl7yedj/vzlILmlIMQI/uTUct6IWo3VNlLmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WtUh277q00n+gLbZTe50cRYhBzn+ebIu7yOqw2c6a8o=;
 b=KZX+jsaNTnrvPOEjALkeziVXuNolw2QgnTbPkYFGtyOd7XqKykgQRs9IJWdrbFfSU7A94F5ytdLabTCdmjbCIQUotB4yELYt/YY3Nx00U+fZpvQ4HgumN2T0j2lLvIiBGF6bdh8YPV+uy80bm+70If/gExnkxChBveLsRTxipq91voM4ZXKmoA7Z2JU/9kjzndpD7csLQSfss9RqZpQ0F1ZdDIcFGYbiozHpzoRbDHUtyRMAB4NESJxfCRmHo+FRWLSfiZandQB9vmo/nEoVSoMP8Hq5C3WWsOQCkMbEk5GnnZPUiP35gXtQGHq7Wg0fjxE2qa0LUm+0v0ActvANIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by CO1PR11MB4849.namprd11.prod.outlook.com (2603:10b6:303:90::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.19; Thu, 23 May
 2024 08:44:46 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091%7]) with mapi id 15.20.7611.016; Thu, 23 May 2024
 08:44:46 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-s390x@nongnu.org" <qemu-s390x@nongnu.org>, Thomas Huth
 <thuth@redhat.com>, Matthew Rosato <mjrosato@linux.ibm.com>, Eric Farman
 <farman@linux.ibm.com>, Tony Krowiak <akrowiak@linux.ibm.com>
Subject: RE: [PATCH 3/7] hw/s390x/ccw: Remove local Error variable from
 s390_ccw_realize()
Thread-Topic: [PATCH 3/7] hw/s390x/ccw: Remove local Error variable from
 s390_ccw_realize()
Thread-Index: AQHarGnPFPaQwSu9j02SNIpmc3sbxbGkgc8g
Date: Thu, 23 May 2024 08:44:46 +0000
Message-ID: <SJ0PR11MB674477976C64BBC80440901F92F42@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20240522170107.289532-1-clg@redhat.com>
 <20240522170107.289532-4-clg@redhat.com>
In-Reply-To: <20240522170107.289532-4-clg@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|CO1PR11MB4849:EE_
x-ms-office365-filtering-correlation-id: a298e2ae-9ece-4d8e-bca8-08dc7b049956
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|1800799015|366007|376005|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?dXdxN0ppQkZUUS80M0dSYzhXQmxyTjZSYTBzTGhmYTZrMlpyT0tjSzJya0dw?=
 =?utf-8?B?TFNnN3UxSE0wd3JVMU1tS0xaSGNydEkxNm5Vd0VuY1hEK0IzMFFHQTdrS1Rk?=
 =?utf-8?B?WDFpMEZxR3dGWHNaZVIza3lmTWtRZngzQWVoMHo1M1psSjQvR0JtSEdNM1Vt?=
 =?utf-8?B?TXhjVDcyMXVCaVRiTEZrSzNydDM0VlprSmEyeG1oang4dEFSc0NWYTNORHo2?=
 =?utf-8?B?S0xTNk9QWW52b1ZTTEJMdlNId2NuYmFTMjZnbkFacFU4cXBnVUNOa2FyR0U0?=
 =?utf-8?B?SjZhNEg4a3F5SVUrT3pqZFBKRzhZalJFbEFJQWpaSi9UVjEvbk92bTd3Z21m?=
 =?utf-8?B?VFRXREtqdjdTZnhuaHpZMkZ6QlRWbi9NRVpqZDJnaVZNTk1tSEI0MWFtclZx?=
 =?utf-8?B?VG1rYklaUUc1Rk50VzltZnBBZVpGNUNZY0dtZGc2VUxzRUt0dVprL2l1dzVq?=
 =?utf-8?B?MzVIT0lPQm9hYXBJaWtSWjFCSDlHQzFVZ2lxdVAvRFkwMk8rK2c5RkFwTXlh?=
 =?utf-8?B?cFhYM3Vnb1Z2R1dBZXhjTXRlWXl5VGVoZHhIWUxrdjR0U3hMeE1FcEtTL0VT?=
 =?utf-8?B?MllEV2tWdDdSS2l0MFNjV1VBbTM4QlJ1UFRQZzFwRTFKOG5zYWVRV1RrY3hH?=
 =?utf-8?B?VFIvNGJIWWpYdEhEaDVocFVNdmF0T0xPMVBXRWIxVmdlQXRSbnFOYXg5V3o2?=
 =?utf-8?B?VUVnZTc2aWpGcVpyR2RwTmVwcmUrWG5laW1hZ2lLdGFLVGx0dFdRcHNjNWlJ?=
 =?utf-8?B?RGxDdHZ5S1gya25ycnZQZW9ReXhZUW51RjNNdTFCSVZFRmpvWHBJRjNDRG1u?=
 =?utf-8?B?cEJiZ21BYUpUeGFJdU4rS0s0SlZvRmZwV3BhVzd5NWl1M3ptOFNRYWtLUzlH?=
 =?utf-8?B?ckJicktiVWFNdDdubkNoMk5BSmpsT0hESXN1cDBxSDhlMlUyV2ZCZzBnbGVV?=
 =?utf-8?B?NEttcTRXaDhHMG1IamtlTXpRb2RPWHpvSE5rYitvRFdYWFdleE1qbSs3N0Rn?=
 =?utf-8?B?TjJCQVZHU25yUnNVMDRxSjRuTUhEM3ZKMnV6RFdPdFNRQjZyZE1RMlBZMWo4?=
 =?utf-8?B?SnJrTmxvdS8xb1p5OXZQV0dNdkxUZk9CWW8xbkxGcDJCNVFIUmVOMmhLaTR1?=
 =?utf-8?B?dFViYkxIQzh2VVdkSmRNYS8wTHZXMWdTaUdXZmdESVNsWmFUZnZRVnAyTkZk?=
 =?utf-8?B?aFR1LzM3WHAzeERwK2g1cFhiSE96ajV3WG0rckZ1WmNXK3JOeVphdE1SZFpB?=
 =?utf-8?B?V2lPRE5DTk13TWlJMFRqQjlMU1VYbFhSZDN2NUNuUGdKZGFKZWk4d09MMTFt?=
 =?utf-8?B?WUZrOXN1YytISmcrU0UyNmhHcXpXdUtlcXFRR3pNMjJqYktXaERNL1BxUjZF?=
 =?utf-8?B?S2RlU0VpV2FDUDV3eSt2R1NWWDI5R0lsa0FRQnFhWWdwNFMzUUpPUzVnT21H?=
 =?utf-8?B?ajRwc3IxVVowOXh3SUxoZ0RTL0RCOFFqVGFLb3lSVTBHQWdEQlVNdnQ1QUZK?=
 =?utf-8?B?NzlVdDRVSU0rQ1lRZmM1dEd6d2ZHb2N5eDhoa3R1MEwveEFzQkk5cGlYWmpQ?=
 =?utf-8?B?WDBjSkhZWEdGWFJmWGY5eHhNWlRPMFg5a2RRd0lERVNGREY1c1ZxeTdvS1Uw?=
 =?utf-8?B?aTlkZE50QlBIYUFYK2YraE11Y2V3TDJjU0pFL0pyci9PUytUaFcyQ1liTFZ1?=
 =?utf-8?B?eUxvQ09hSG9NdmxIOGdkVU03VVRJQU5HcC9VZW9DdzFILytNcHNaVUxHbzI2?=
 =?utf-8?B?YUJKVVVNVndDeElPZVZObmEyQ2FCOUg4T0hKWkFQaVpVMW5rbyt3SVR4NlpY?=
 =?utf-8?B?Z1hwSkVqTG5TcVkwdHZRQT09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(366007)(376005)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZVZYNkhjQlNRdDlPYW5jczF3T0g0TGJ1UVJsNmkyWi9KbExIYzhvWURjd005?=
 =?utf-8?B?QmFKWnYyaDFFSXVaQWh1aWlZUHEwUXVyakhSbkNFbTlIQU9ZSXd6ZmtuNlhS?=
 =?utf-8?B?amZRWmMzVHE3SUloZzc5cC92RmEzZzRRRTlGdDFTM2FmN3k4Tk94Vmk4ZURl?=
 =?utf-8?B?SU5tc1Izc2szRGptcGxud0J0L0ZjdEkraHhQMUxPR2x5MHZ5amU1WnJKLzJ2?=
 =?utf-8?B?NW9yTit0Sm81Y3lYdFJHK0FCQVNCNGl5bTJQdTdqSy9JaHlpemEyRitTWUl5?=
 =?utf-8?B?ZVozZ21iV05rSm05aksxckZRTVplVkxCK0RmYnVMVlNMSFVKZW41NG43dUd5?=
 =?utf-8?B?bWl0WTRYOTd0NkFSY3pZbkNnM1hIMXY1am9jVnBFSWdWV0RQV0tUMm5PT0Mx?=
 =?utf-8?B?UGJYYjgwSUhJWU1ma2I1b3FjUXJlcFZFQ0pPaFErSVF1Q25pa0lBZkVrWVpz?=
 =?utf-8?B?aEdGamlCUmZGSTN4elo3Qm10U3cyUlIxV0haR3h3bE94OXBZaXRkYW5PWE5P?=
 =?utf-8?B?TjkvRTlaODREeVpHckNDMEd0YTZ6RXQwbk5PNi9BMUV2d1VTNFFQYmtPQkJs?=
 =?utf-8?B?SmhmMWE5NC9FSURqK2hlOUVkd0ovZEI3clZ1cm5YbGJLL0F3NmFTVy9kRXFC?=
 =?utf-8?B?UU5YM2krNmpsNzEvaTAwL3lETjIvb29SL3B2UTRrYlpMUklxSFN4aXFCYTJM?=
 =?utf-8?B?b1FZRW44NXF1NmVDeUU1K05qaDdHeG1xdmNoQUo3Y3ZpT00rSVRzWjNJYVpp?=
 =?utf-8?B?QjRRNEt6N3hJakhkWnZFaUtYKzBlSmlLeXNQZkk5T3laWGhnVEs5Mmk4V3Ry?=
 =?utf-8?B?N2tMYUZlUVNnVGltRHpkbjA2YkpGU1hnbzE0UjJUYXJYN3V3ZmM2TG9nWVhL?=
 =?utf-8?B?RUlBVWhkNE9MRmIxKy9NbmFkNmkwektIWjN1MnlzdTBVcXhRNXZGbHBBRGNU?=
 =?utf-8?B?YWlmTXd6bzFHSXlDUVhybk1mSnZLdW91QXRsalJzbjRsYkw0S1B6VlhKb3cv?=
 =?utf-8?B?WmVmUWNBVXd6bW1NUVpHMXVmNjEwQTB2aW9jRHY0RlhiYXZQUnN2Z092cXU3?=
 =?utf-8?B?UGk5a2o1cU1DWldHblNGYjY5dTMzbm55K1pHY1lsaDhHczgxQ2FPUUFhTXp5?=
 =?utf-8?B?VkVxakFiQ3N6TnR2ZTBiWGpCUEhhTGdHQy9ySVREbjlMT3FkZGhGZnRUSmhz?=
 =?utf-8?B?emRleXFJNTNHUlZRWE4vOFYwNjV1aXFlK2ZKa0ZBa0NxTTQySFg3eXdwV0VF?=
 =?utf-8?B?Tmk1djcwRmEwT0xkbzhQRWYzZHE0MWwyKzc5Wk94SktBMW80d0hsSERVQkdH?=
 =?utf-8?B?b0VBK09LMTBmYzZ2S1d5SlRXQWVwdkJjcmwzOFVtazFSMC9WY1ZEU3JvdEhP?=
 =?utf-8?B?NzI1UWhrZkMzYUZJc2FmaEZBSGJMTTBmaEhNRks1djlNNjZHVnlRZlhaUHd1?=
 =?utf-8?B?Ry9SK0pmaWlKeURSTkVyMDhBSUpEaDBROG8yTnJKbEZMTk9PWk9iU2x1RXhn?=
 =?utf-8?B?Y1lsVjdiK011aEFZaUUvRzFRdzIvZnp1QklpRTRwWm5tdUFnbGcxaStSWHl4?=
 =?utf-8?B?cElsVzRtd3NxemVidDJ4ZjBZRTFwK3FrTDQ3Q1lNUXlQMUt4R3k1b3orQzZa?=
 =?utf-8?B?bGczOTdYZnpreURXb3daRHkvemkzOXREb2dJc09PSzIreXp1aVV4M213MlBR?=
 =?utf-8?B?K1dpZFBUcFV5K0J3VkJRTDVCLyt2dStEQ1hpWHhsN3BLRHMvblVuQU1OOU5a?=
 =?utf-8?B?WHlVcGtYNkpYNUJubmFacVBHZWMrNDhucm1DNjl0T0dCNVB1RU10UjFYT3N6?=
 =?utf-8?B?Q096SHJaZy9WNVE1b3JvRUpadmtaOVRCZ1dRci9aMXpSZzhPMnBOSUY3SHJt?=
 =?utf-8?B?WHNXWXNiTFQ2SCtNTnZPOTdLU0VUWnRSQWVWQnZKRk1PdmRibGZhcGpudXk4?=
 =?utf-8?B?WDM4TzJYdjdOcm1vUUhSNHhIdEZtSFYwb2pBSm9JKzJoYVdDbmR6czBLV3pJ?=
 =?utf-8?B?QnN3SkFRMnVZNmpESWN1TS9yZEZVd1NBclg2STltaTFLRmNoYlNWUk9SRkdB?=
 =?utf-8?B?amVhbmkvMEFrcGdmUzV4NTVaZmFSZXhPRWFnZ29iaHZ2V2dzSHZyL1lJdFJv?=
 =?utf-8?Q?g5UImKMPr0jJzf3Tqo5UWddDK?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a298e2ae-9ece-4d8e-bca8-08dc7b049956
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 May 2024 08:44:46.1945 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PlLx74ghFuZtZglmAIrurNe2nYZEal0fhJozs1P9ng2DEE3z3lt4lX13clXPcURX/1pB+0k1445uZW2Z6fxATTaz/ZmzHonTF+YyLtzk8uk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4849
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.13;
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IEPDqWRyaWMgTGUgR29hdGVy
IDxjbGdAcmVkaGF0LmNvbT4NCj5TdWJqZWN0OiBbUEFUQ0ggMy83XSBody9zMzkweC9jY3c6IFJl
bW92ZSBsb2NhbCBFcnJvciB2YXJpYWJsZSBmcm9tDQo+czM5MF9jY3dfcmVhbGl6ZSgpDQo+DQo+
VXNlIHRoZSAnRXJyb3IgKiplcnJwJyBhcmd1bWVudCBvZiBzMzkwX2Njd19yZWFsaXplKCkgaW5z
dGVhZCBhbmQNCj5yZW1vdmUgdGhlIGVycm9yX3Byb3BhZ2F0ZSgpIGNhbGwuDQo+DQo+U2lnbmVk
LW9mZi1ieTogQ8OpZHJpYyBMZSBHb2F0ZXIgPGNsZ0ByZWRoYXQuY29tPg0KDQpSZXZpZXdlZC1i
eTogWmhlbnpob25nIER1YW4gPHpoZW56aG9uZy5kdWFuQGludGVsLmNvbT4NCg0KVGhhbmtzDQpa
aGVuemhvbmcNCg0KPi0tLQ0KPiBody9zMzkweC9zMzkwLWNjdy5jIHwgMTMgKysrKystLS0tLS0t
LQ0KPiAxIGZpbGUgY2hhbmdlZCwgNSBpbnNlcnRpb25zKCspLCA4IGRlbGV0aW9ucygtKQ0KPg0K
PmRpZmYgLS1naXQgYS9ody9zMzkweC9zMzkwLWNjdy5jIGIvaHcvczM5MHgvczM5MC1jY3cuYw0K
PmluZGV4DQo+NGI4ZWRlNzAxZGY5MDk0OTcyMDI2MmI2ZmMxYjY1ZjRlNTA1ZTM0ZC4uYjNkMTRj
NjFkNzMyODgwYTY1MWVkDQo+Y2YyOGEwNDBjYTcyM2NiOWY1YiAxMDA2NDQNCj4tLS0gYS9ody9z
MzkweC9zMzkwLWNjdy5jDQo+KysrIGIvaHcvczM5MHgvczM5MC1jY3cuYw0KPkBAIC0xMTUsMTMg
KzExNSwxMiBAQCBzdGF0aWMgdm9pZCBzMzkwX2Njd19yZWFsaXplKFMzOTBDQ1dEZXZpY2UNCj4q
Y2RldiwgY2hhciAqc3lzZnNkZXYsIEVycm9yICoqZXJycCkNCj4gICAgIERldmljZVN0YXRlICpw
YXJlbnQgPSBERVZJQ0UoY2N3X2Rldik7DQo+ICAgICBTdWJjaERldiAqc2NoOw0KPiAgICAgaW50
IHJldDsNCj4tICAgIEVycm9yICplcnIgPSBOVUxMOw0KPg0KPi0gICAgaWYgKCFzMzkwX2Njd19n
ZXRfZGV2X2luZm8oY2Rldiwgc3lzZnNkZXYsICZlcnIpKSB7DQo+LSAgICAgICAgZ290byBvdXRf
ZXJyX3Byb3BhZ2F0ZTsNCj4rICAgIGlmICghczM5MF9jY3dfZ2V0X2Rldl9pbmZvKGNkZXYsIHN5
c2ZzZGV2LCBlcnJwKSkgew0KPisgICAgICAgIHJldHVybjsNCj4gICAgIH0NCj4NCj4tICAgIHNj
aCA9IGNzc19jcmVhdGVfc2NoKGNjd19kZXYtPmRldm5vLCAmZXJyKTsNCj4rICAgIHNjaCA9IGNz
c19jcmVhdGVfc2NoKGNjd19kZXYtPmRldm5vLCBlcnJwKTsNCj4gICAgIGlmICghc2NoKSB7DQo+
ICAgICAgICAgZ290byBvdXRfbWRldmlkX2ZyZWU7DQo+ICAgICB9DQo+QEAgLTEzMiwxMiArMTMx
LDEyIEBAIHN0YXRpYyB2b2lkIHMzOTBfY2N3X3JlYWxpemUoUzM5MENDV0RldmljZQ0KPipjZGV2
LCBjaGFyICpzeXNmc2RldiwgRXJyb3IgKiplcnJwKQ0KPiAgICAgY2N3X2Rldi0+c2NoID0gc2No
Ow0KPiAgICAgcmV0ID0gY3NzX3NjaF9idWlsZF9zY2hpYihzY2gsICZjZGV2LT5ob3N0aWQpOw0K
PiAgICAgaWYgKHJldCkgew0KPi0gICAgICAgIGVycm9yX3NldGdfZXJybm8oJmVyciwgLXJldCwg
IiVzOiBGYWlsZWQgdG8gYnVpbGQgaW5pdGlhbCBzY2hpYiIsDQo+KyAgICAgICAgZXJyb3Jfc2V0
Z19lcnJubyhlcnJwLCAtcmV0LCAiJXM6IEZhaWxlZCB0byBidWlsZCBpbml0aWFsIHNjaGliIiwN
Cj4gICAgICAgICAgICAgICAgICAgICAgICAgIF9fZnVuY19fKTsNCj4gICAgICAgICBnb3RvIG91
dF9lcnI7DQo+ICAgICB9DQo+DQo+LSAgICBpZiAoIWNrLT5yZWFsaXplKGNjd19kZXYsICZlcnIp
KSB7DQo+KyAgICBpZiAoIWNrLT5yZWFsaXplKGNjd19kZXYsIGVycnApKSB7DQo+ICAgICAgICAg
Z290byBvdXRfZXJyOw0KPiAgICAgfQ0KPg0KPkBAIC0xNTEsOCArMTUwLDYgQEAgb3V0X2VycjoN
Cj4gICAgIGdfZnJlZShzY2gpOw0KPiBvdXRfbWRldmlkX2ZyZWU6DQo+ICAgICBnX2ZyZWUoY2Rl
di0+bWRldmlkKTsNCj4tb3V0X2Vycl9wcm9wYWdhdGU6DQo+LSAgICBlcnJvcl9wcm9wYWdhdGUo
ZXJycCwgZXJyKTsNCj4gfQ0KPg0KPiBzdGF0aWMgdm9pZCBzMzkwX2Njd191bnJlYWxpemUoUzM5
MENDV0RldmljZSAqY2RldikNCj4tLQ0KPjIuNDUuMQ0KDQo=

