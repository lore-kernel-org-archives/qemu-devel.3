Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9249CC25B74
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2024 06:05:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBTUS-0007qj-0S; Mon, 27 May 2024 02:05:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sBTU2-0007dT-VD
 for qemu-devel@nongnu.org; Mon, 27 May 2024 02:05:23 -0400
Received: from mgamail.intel.com ([198.175.65.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sBTTb-0000SJ-BD
 for qemu-devel@nongnu.org; Mon, 27 May 2024 02:05:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1716789895; x=1748325895;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=/baCkLY0F+agWpzWmTYXfhGZr0qd0IP7Z45MJU15S0E=;
 b=f6+R+4F3huUiLO1C8eEZ1jrgd6SzY9lWSYlsAHhAcbCMAaddQHvKoVB9
 EgL3bX7u+ItodRwt2VW9nzFtHK3cPs9kP4z0psbm5dJwNOXhP3vovICwc
 fB2gz3gxbbvRjlOKo6H8z60hI4q9Axb/bDcwaUntgOMLgBkFCYQUu1U1E
 zEBD6DSYA/4UkcrzBUQRZFwK0GPhaCGA9uc5hJld1dtczfIswhYcIQp8p
 l896lchQ41tizB2JPy1umE2teB7QShVMU52JKCSOv3+IJu2VMPKJPsKkT
 tMVRySTgDI93ckuzKDT/xXQUcBkbr7Y2pePIsXniAKUBc++5COID1GMpw Q==;
X-CSE-ConnectionGUID: LpLsXJrVRP+dVGlkzOnKfA==
X-CSE-MsgGUID: 2FNQ9YXBTvm6xQIn/+Tolw==
X-IronPort-AV: E=McAfee;i="6600,9927,11084"; a="23657484"
X-IronPort-AV: E=Sophos;i="6.08,191,1712646000"; d="scan'208";a="23657484"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 May 2024 23:04:51 -0700
X-CSE-ConnectionGUID: iIsGtnNSRd6In07w7uNIgQ==
X-CSE-MsgGUID: 9cRYW5NJTKy2CnZ58tg7Tg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,191,1712646000"; d="scan'208";a="65870973"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
 by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 26 May 2024 23:04:50 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 26 May 2024 23:04:50 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 26 May 2024 23:04:49 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Sun, 26 May 2024 23:04:49 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.40) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sun, 26 May 2024 23:04:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kq8IZ7PBqIqnZB1ukAVECCE3VS+I3qYw9eAN7z6gUmfiaXfgyoNDEof4wzpPEIV4ykewtzXvGaYptYWQVxJt7nmJB7pSOC0UhHIVOtETyloxWm9DzI+V27VfGL5ZlsOUAe4rxFgSHVGzqmmfVrQ1TvjkyehVECzaa0vm/jWbnu/SLyA2D5R8nuRywZ/zMZdarzwu+Fo9OGnTX+zIB1eqb9ZBWWYEnTrs0whkdqBou6XSi9U/5QYjrQWhFQ+ipFNSARkkDYcoJx/iOC2CGqScISceQW7MFpRmZRCVm6q2BEwy7fj9wb3sL/d+TFVBOt4rXF4rEflPNzn+awZW8HHV4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/baCkLY0F+agWpzWmTYXfhGZr0qd0IP7Z45MJU15S0E=;
 b=nqtq2nyAy+adVtRSW+vNz1HCjjnFqxwzBgWl5/T97aBtpEbICxYPbBNZ6NScK5rT49Okpv2LrfWpsEUlLcBv2U9vDKZzA1qXml9ICv2Fv5APKwGqd/pBCoHBGtGlg5ostT/zyR+p3nqVZRKGoAc+NOTwAA0LZ0xeXQpbRWbiaiXd80S/NPLUAsb9/zeOBXjIPJcR07IlugUU9y1uvquIXRPPgYw4ueTrtFIqXv0dvtaHMhJ728Pye461SP4Pnj68ZTSM/9AWyhzSPTKqGAqdquxQBAE8gs+tdLB4OGdvQSTxh3SoBqZBBc3iY5GponF5/U+mzgNhmt6SYHij1vUnHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by DM4PR11MB7303.namprd11.prod.outlook.com (2603:10b6:8:108::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.29; Mon, 27 May
 2024 06:04:42 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091%7]) with mapi id 15.20.7611.025; Mon, 27 May 2024
 06:04:42 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: Jason Wang <jasowang@redhat.com>
CC: "Liu, Yi L" <yi.l.liu@intel.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "Peng, Chao P" <chao.p.peng@intel.com>, Yu Zhang
 <yu.c.zhang@linux.intel.com>, "Michael S. Tsirkin" <mst@redhat.com>, "Paolo
 Bonzini" <pbonzini@redhat.com>, Richard Henderson
 <richard.henderson@linaro.org>, Eduardo Habkost <eduardo@habkost.net>,
 "Marcel Apfelbaum" <marcel.apfelbaum@gmail.com>
Subject: RE: [PATCH] intel_iommu: Use the latest fault reasons defined by spec
Thread-Topic: [PATCH] intel_iommu: Use the latest fault reasons defined by spec
Thread-Index: AQHaqESnRiGl1jiq20uiRV0AFydhKrGfTQkAgAAs2mCAAA5PgIABefcAgAB9i4CAAW9wgIADKlPwgARf+4CAAAObwA==
Date: Mon, 27 May 2024 06:04:42 +0000
Message-ID: <SJ0PR11MB6744135D8C08CEE42460CAF792F02@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20240517102334.81943-1-zhenzhong.duan@intel.com>
 <CACGkMEvTomFeC1bM3SfY1zGhQ_5i15r6CY6M3jVzau6niNUf_w@mail.gmail.com>
 <SJ0PR11MB6744AECEAA6F9319259B0DF192E92@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <DS0PR11MB752917B52B66A6EF10C10678C3E92@DS0PR11MB7529.namprd11.prod.outlook.com>
 <CACGkMEt5ofYt12A6uKUj=QLcLbOnrGT=UkMpee=MUxO6Xy3sxg@mail.gmail.com>
 <SJ0PR11MB6744C340AAB1B786D3913F5D92EA2@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <CACGkMEsV05ujKNEL9JSAsfikWGW582yvfSOdHJgRxZC_1cxgEg@mail.gmail.com>
 <SJ0PR11MB67445F7F8B79D2C2B982C1F692F52@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <CACGkMEuO6T-LqcZ=5oRR83LyhZ7oOtZvb70CUksZDAmC1KnsOA@mail.gmail.com>
In-Reply-To: <CACGkMEuO6T-LqcZ=5oRR83LyhZ7oOtZvb70CUksZDAmC1KnsOA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|DM4PR11MB7303:EE_
x-ms-office365-filtering-correlation-id: 81c7163f-bdeb-4d28-eeca-08dc7e12e6ba
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|366007|376005|1800799015|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?THFBMlo5RjhablVqUk1lakx2TzlDUkVuQ25jSWQ4R0l3aTRaRDJ1VnFQTnVt?=
 =?utf-8?B?QzVyMWR3MlZhdGtjUlA2b0lOaWtzOS9sZ21GdThUK3ZFYkcvTzZMcFlDeENE?=
 =?utf-8?B?Rkh1RmFNbEZJZTdXWnd6b3JRWWJ2dG1YYkpyd09acUdYVjkzMnFPZDZNLzNm?=
 =?utf-8?B?eUpPOUcyL3Z6NUhTUDlsQ05lNXJoS2ZLMU8rWnNqUlRQTjZYcy9yYnBJUmJO?=
 =?utf-8?B?M1NaOEVCdFMvem5DbWFNNm1uNnJQcHA5M0cwZUNHMzZwNTVYYnBmVDBRS0NY?=
 =?utf-8?B?aElESHAyS01uMEhXWER3Syt4THhsN0NVVmp4TU5JbXZnR0ZRYmlRRjZQNjhp?=
 =?utf-8?B?c3FnbkFHTE9yZVlSVW9VOUg4M2NFYm8xNExqdTRaTjJlN013d05LSUlzQnRh?=
 =?utf-8?B?TGh0d05rT05lcW1wbGRXQXk5STJSMU1rbENIMjhoQk53WjdLZWdDRE16UTRh?=
 =?utf-8?B?dHJWdFN2RTdUV1BEd0tFaHhsK29wVzBwd0EvdU04bjlZRnhEdUgvUWNwTmMz?=
 =?utf-8?B?REZaRGVtTkhkaEhuUzRNWXFJT3RFMGh5dDAzVXdvRzJ2czVLQlE5QlZHVDg4?=
 =?utf-8?B?bVpXek5WUXo4Z3I3ZXJLS01xN2diMnF2YTVYL2NUL0k5c2J0ZWR2dUNIeUtJ?=
 =?utf-8?B?SUlnSzZ2SWV4dXA0d1JUYUZSa1VubkQxYXcrQVM0bnkwTWtWZ0p5MERwR2Fv?=
 =?utf-8?B?elpreU9IY2dUeUY0cUVPcEs4cE1NWXhMWFNFdXFGa2MwN0Fyb1JiVkdFUEQz?=
 =?utf-8?B?V3pVYzk4NUp5K0lqdFNsM3dxOHpZcGMvSy9qN2pwN2hMK080QzMzZFgwRmF0?=
 =?utf-8?B?UU1iUlpzRlQxUlFFWWVtWkdaUFJqYjdEM1ArSTYvbG1qMEhxL0hxL2JJNVRD?=
 =?utf-8?B?VVhHd3p4d2ZJRkQxK1pXbXloQVB5QnZOb05mVzQ0NlBqZkN4ZWM1OUpCRkhE?=
 =?utf-8?B?a3N3ZTBibW1Eams1WTFac05BSk5sQVpnVzVNL1pTVDJlRGt1VjV4Y281alo4?=
 =?utf-8?B?Q2JSalFQbjhiYjdxdUt2amZKRnhoQk5RcGJhR2M5QytjK2FuQzJEZTl6TktZ?=
 =?utf-8?B?TVRiZEJEQ0JPc1RYK0ptOTVQM0VWdElLRGg3aC9FSVRpQUdQY0EwQWhYdUpx?=
 =?utf-8?B?UVp4WDRQbFpOTnhQc0xhVDhEQ1R6U280dVRWb29lckFYY0FJaHV0NUpmNUhk?=
 =?utf-8?B?clZQeC9jMCttNXZaSTBpT3RlcFJLNW1CWlU0S1NnL1FlL2FQTFFlbUhZYmlm?=
 =?utf-8?B?SzhsbFZPQjJXOERkKzRjS0hVWHZmNzQ5bysxTnV0R1RJZTlqQ2pxclI4d1ha?=
 =?utf-8?B?WVZxQ0t2TVJ1MWUrRGJYdHQ2eUpoYUxsZHNOSTk2bExEOFNEcXB2VjZseW4r?=
 =?utf-8?B?a1FiaUhsRFVzV3QzWGxpUkZnUEFUYlNUZzdaUEhXajhvaDljVEVUcWt5OUo4?=
 =?utf-8?B?TkJaYytHQmFnVERWYWdpRzk4WERMOHhmMElkVzh6aHRFUTdsSm9USW9zM09E?=
 =?utf-8?B?bjZpc1hQQlh2enYzT2d3Q2VpYVIwQ0x6UlhxS0ZsOExDUGNlTER6VDhMM2ND?=
 =?utf-8?B?a3NpUmlFTXFqcWFieUQrSDN5WEpnRk9ZanJkaTVYVEtyNTY3akJ4VlJQam5o?=
 =?utf-8?B?TVNHcDJROW5penQxbHZIWmlzVkhPSlkrMGExU1NKVVVVU2FpMkhic3IyM3Mr?=
 =?utf-8?B?bVZLQURGY3FTeWtqYlVsaHhTRzV6cWsrTGlWd0tnNElBQm10L2tiamxjV0k0?=
 =?utf-8?B?SjhuMDI5QmlzK3VLR3hvTFY2MzlkUkRSNEkxWnMwckptWTJidGlhT2l6WTZD?=
 =?utf-8?B?NW82cXIvbVdyYU5ZMi9aUT09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(1800799015)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dXJnTXNSR0VtNS9QZHZjREk1TjFCRVpTTWJrTzB4ZWxhZUdDbk14R0hQdmdU?=
 =?utf-8?B?eHRMQ3pVcGxIQXJGVlZ3UkJQVDRIZHRqODhBbzk0Slg1UjQxREtnQmt0ZU1L?=
 =?utf-8?B?eGdpRitFRmJuK2p4VWdCUkxjamtVZUg2c1k1SXNkd3dlbWZDSUJ3bDF6ZFpi?=
 =?utf-8?B?dVV1WTVFREVkckFWRnY3cXRURDNBOXFRWjZUQ0hKeXdjdXhCRTRVZ1NEYTRF?=
 =?utf-8?B?UE4yaExMYXVwRGk5QTdUVklSR0MxY09oRXVFV0pvNGd4dmc3OXZKWlVRVFBk?=
 =?utf-8?B?dHJKY0Vqc3dETjJsWWJIMHJZMGZBZFM3UUJXK0NYa1JUYkFYaFN3SW95RXJH?=
 =?utf-8?B?bFcwcmFzaDBMRno1TEpSYWg3N2hpSDZSakdIUHFmczRVS3ZlZGZzbk1MV1c1?=
 =?utf-8?B?LzhsVjZoalcrSHM5STMvcWN6R3dhcW5Zd1BNcW96Um14ejBwSDBkdDFIRWpS?=
 =?utf-8?B?Qi9GdXBJUUUybWp1aFArU2hsYjFZaGg0MjQ2TkxsWkVJUDFPQnY1eTVlUXF6?=
 =?utf-8?B?aVM1ek1vM3pKdTFpbDAvaDVYZDBEVlNyR1NZTlNTK1lZVXNUOXpxUnVLR0xP?=
 =?utf-8?B?RWpvS3d1MGs0UHo2bmVXNWxLT0RpencxemNzYnUvRHQvWWpOcXBpOWFVSEF4?=
 =?utf-8?B?ZCt4U0ZMdkxOaVBybGF1RWo4YU1SS3IzUzZRcmlVeFVPME04Rkw4S3lqS3l1?=
 =?utf-8?B?SGxldlZzbDEvTlBhNXJhNlB1RFB6N2l6WW9PMW12ZElsd2RMMGFhYWt2Z1Zp?=
 =?utf-8?B?dDIyZUVueHlOM1BpYjdKUzJ2VzdTL2pLd3RvZGYydTZ6bTBKSmFKek8rTVR2?=
 =?utf-8?B?MEYrcGxjeDI3Z291ME4rTU11blhUYVBoUkpmTzVvNHUvVms0SHdmOFpDV0VS?=
 =?utf-8?B?OFRrUGpvaWFuMHBtL1prcVBWSlNZMEZZajNlZSt2alRSdlRFeGV3Y1hPNGtm?=
 =?utf-8?B?VzZPMklzY2ZLV2tPME5Odzd4aTlROERPcnBSNXRDa3dSdkZXeFpITnYyZXpx?=
 =?utf-8?B?akcya216cVo0Qi9rN2pSYW9FWHZjZzhzUXlGM1FEcjBxQjh5QU1rWVVJVFJH?=
 =?utf-8?B?a1AxcXdnVUhxYXZQSWp6cytxejJLRWRwMVhDV3lsb0JXdjU4S0RHQlNmcEN1?=
 =?utf-8?B?ZEY2eGJwZTNwZFQ4R1AyZUt6dkFMaWVMaWtqSVdDY1pqKzVZTHV0VzNlSjFw?=
 =?utf-8?B?OTZsenNWZ1J1RU45Sjc5VTFmRURrWEZabFdtQXB2NldaZlV6RzV0NngrdmtH?=
 =?utf-8?B?ZUtrV2huYmNpN3V4akF2M05qcGpvM2dWTXJiS0FVMW8zTExZTVRLdVpKWXhT?=
 =?utf-8?B?YVNOTGw4dmpHSmhjZjlzS2pzSm5oQVNlRHhraDZsNE52eVI3VHBQdjd2Y1Nx?=
 =?utf-8?B?MDV3RFpBdCtBTnE0M2tsa0UxTzhNc2tkWnRNK2haSXpCbnRZbGdBZjAvYURj?=
 =?utf-8?B?WmR3MnRscmIya1VMeklZaDJ2L0k5cUxuSklXYldoZ1AxN2lrejltVGlXVmZq?=
 =?utf-8?B?b1UybjFuUzBVczhQRndTKzZFWFJGUmw5L2EzQlY3VHlhZ3RPbElLWGVNbEEy?=
 =?utf-8?B?b3plenpKNEtiSUh1UWIwS3JSOWhJU0VNaXQ4Q01SUFhEWEdUVzJCN2pkUHRi?=
 =?utf-8?B?Y3V2SGxTUHdwdjJvMjZsSUJSa3RRRkJjcmxCWGszV0orMzRiZlpnL1crR2do?=
 =?utf-8?B?elBKbXhBTVVoMDBsOFVtRkRNMkJXUmFTZTl2L0tSMUFvdThJb2JPamIzU004?=
 =?utf-8?B?Q0FXZ2I2VmRWYjJCQTZJTFdiWU8vbmYwZDQySEJRcHFEditPMllOaU05YTMw?=
 =?utf-8?B?cWp1TnJBZ29SR0I5WXVycWFUWkNrN1Y2Q3ZNamQ5ODhTNXkzUlBZNmxGcmg1?=
 =?utf-8?B?NDF3R3lXb2dYT2NsbXNPUS9WTkFrSDFBbVlhSVFWMUF5b0M3OHFROFRjYTJv?=
 =?utf-8?B?UEZRWS9lbUYwQmVVR09uRWhseXlkZEVzd2loMlFQL1dsZkRrOWNiQjJRRU5w?=
 =?utf-8?B?cFRyNW55MzBOU2MrZEtTK21sWnMxdHE5eHh3WDg4WHBkSWpLbm50dTd0VnNw?=
 =?utf-8?B?WjViWmJqTzVmZE1LVmp5VjF6aDlBK1NwVVZHL2ZQamdWbkVUYlloY1NvUDFh?=
 =?utf-8?Q?Xbpa3uHJbRNJaMMIMcN+jjrwH?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81c7163f-bdeb-4d28-eeca-08dc7e12e6ba
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 May 2024 06:04:42.4668 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Qv+q+guajm0/hkYgRT2BP88Vv4jCztSLDZe8mViRRqr10gebXAf4dYQp88g5vD9TOJAGOOuW2XeJiZ5tYamPdGVrVA/UDNZb4tYpkjiRoGI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB7303
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.11;
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IEphc29uIFdhbmcgPGphc293
YW5nQHJlZGhhdC5jb20+DQo+U3ViamVjdDogUmU6IFtQQVRDSF0gaW50ZWxfaW9tbXU6IFVzZSB0
aGUgbGF0ZXN0IGZhdWx0IHJlYXNvbnMgZGVmaW5lZCBieQ0KPnNwZWMNCj4NCj5PbiBGcmksIE1h
eSAyNCwgMjAyNCBhdCA0OjQx4oCvUE0gRHVhbiwgWmhlbnpob25nDQo+PHpoZW56aG9uZy5kdWFu
QGludGVsLmNvbT4gd3JvdGU6DQo+Pg0KPj4NCj4+DQo+PiA+LS0tLS1PcmlnaW5hbCBNZXNzYWdl
LS0tLS0NCj4+ID5Gcm9tOiBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPg0KPj4gPlN1
YmplY3Q6IFJlOiBbUEFUQ0hdIGludGVsX2lvbW11OiBVc2UgdGhlIGxhdGVzdCBmYXVsdCByZWFz
b25zIGRlZmluZWQgYnkNCj4+ID5zcGVjDQo+PiA+DQo+PiA+T24gVHVlLCBNYXkgMjEsIDIwMjQg
YXQgNjoyNeKAr1BNIER1YW4sIFpoZW56aG9uZw0KPj4gPjx6aGVuemhvbmcuZHVhbkBpbnRlbC5j
b20+IHdyb3RlOg0KPj4gPj4NCj4+ID4+DQo+PiA+Pg0KPj4gPj4gPi0tLS0tT3JpZ2luYWwgTWVz
c2FnZS0tLS0tDQo+PiA+PiA+RnJvbTogSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4N
Cj4+ID4+ID5TdWJqZWN0OiBSZTogW1BBVENIXSBpbnRlbF9pb21tdTogVXNlIHRoZSBsYXRlc3Qg
ZmF1bHQgcmVhc29ucyBkZWZpbmVkDQo+YnkNCj4+ID4+ID5zcGVjDQo+PiA+PiA+DQo+PiA+PiA+
T24gTW9uLCBNYXkgMjAsIDIwMjQgYXQgMTI6MTXigK9QTSBMaXUsIFlpIEwgPHlpLmwubGl1QGlu
dGVsLmNvbT4NCj53cm90ZToNCj4+ID4+ID4+DQo+PiA+PiA+PiA+IEZyb206IER1YW4sIFpoZW56
aG9uZyA8emhlbnpob25nLmR1YW5AaW50ZWwuY29tPg0KPj4gPj4gPj4gPiBTZW50OiBNb25kYXks
IE1heSAyMCwgMjAyNCAxMTo0MSBBTQ0KPj4gPj4gPj4gPg0KPj4gPj4gPj4gPg0KPj4gPj4gPj4g
Pg0KPj4gPj4gPj4gPiA+LS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4+ID4+ID4+ID4gPkZy
b206IEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+DQo+PiA+PiA+PiA+ID5TZW50OiBN
b25kYXksIE1heSAyMCwgMjAyNCA4OjQ0IEFNDQo+PiA+PiA+PiA+ID5UbzogRHVhbiwgWmhlbnpo
b25nIDx6aGVuemhvbmcuZHVhbkBpbnRlbC5jb20+DQo+PiA+PiA+PiA+ID5DYzogcWVtdS1kZXZl
bEBub25nbnUub3JnOyBMaXUsIFlpIEwgPHlpLmwubGl1QGludGVsLmNvbT47IFBlbmcsDQo+PiA+
Q2hhbw0KPj4gPj4gPlANCj4+ID4+ID4+ID4gPjxjaGFvLnAucGVuZ0BpbnRlbC5jb20+OyBZdSBa
aGFuZw0KPjx5dS5jLnpoYW5nQGxpbnV4LmludGVsLmNvbT47DQo+PiA+PiA+TWljaGFlbA0KPj4g
Pj4gPj4gPiA+Uy4gVHNpcmtpbiA8bXN0QHJlZGhhdC5jb20+OyBQYW9sbyBCb256aW5pDQo+PiA+
PHBib256aW5pQHJlZGhhdC5jb20+Ow0KPj4gPj4gPj4gPiA+UmljaGFyZCBIZW5kZXJzb24gPHJp
Y2hhcmQuaGVuZGVyc29uQGxpbmFyby5vcmc+OyBFZHVhcmRvDQo+PiA+SGFia29zdA0KPj4gPj4g
Pj4gPiA+PGVkdWFyZG9AaGFia29zdC5uZXQ+OyBNYXJjZWwgQXBmZWxiYXVtDQo+PiA+PiA+PG1h
cmNlbC5hcGZlbGJhdW1AZ21haWwuY29tPg0KPj4gPj4gPj4gPiA+U3ViamVjdDogUmU6IFtQQVRD
SF0gaW50ZWxfaW9tbXU6IFVzZSB0aGUgbGF0ZXN0IGZhdWx0IHJlYXNvbnMNCj4+ID5kZWZpbmVk
DQo+PiA+PiA+YnkNCj4+ID4+ID4+ID4gPnNwZWMNCj4+ID4+ID4+ID4gPg0KPj4gPj4gPj4gPiA+
T24gRnJpLCBNYXkgMTcsIDIwMjQgYXQgNjoyNuKAr1BNIFpoZW56aG9uZyBEdWFuDQo+PiA+PiA+
PiA+ID48emhlbnpob25nLmR1YW5AaW50ZWwuY29tPiB3cm90ZToNCj4+ID4+ID4+ID4gPj4NCj4+
ID4+ID4+ID4gPj4gRnJvbTogWXUgWmhhbmcgPHl1LmMuemhhbmdAbGludXguaW50ZWwuY29tPg0K
Pj4gPj4gPj4gPiA+Pg0KPj4gPj4gPj4gPiA+PiBDdXJyZW50bHkgd2UgdXNlIG9ubHkgVlREX0ZS
X1BBU0lEX1RBQkxFX0lOViBhcyBmYXVsdA0KPnJlYXNvbi4NCj4+ID4+ID4+ID4gPj4gVXBkYXRl
IHdpdGggbW9yZSBkZXRhaWxlZCBmYXVsdCByZWFzb25zIGxpc3RlZCBpbiBWVC1kIHNwZWMNCj43
LjIuMy4NCj4+ID4+ID4+ID4gPj4NCj4+ID4+ID4+ID4gPj4gU2lnbmVkLW9mZi1ieTogWXUgWmhh
bmcgPHl1LmMuemhhbmdAbGludXguaW50ZWwuY29tPg0KPj4gPj4gPj4gPiA+PiBTaWduZWQtb2Zm
LWJ5OiBaaGVuemhvbmcgRHVhbiA8emhlbnpob25nLmR1YW5AaW50ZWwuY29tPg0KPj4gPj4gPj4g
PiA+PiAtLS0NCj4+ID4+ID4+ID4gPg0KPj4gPj4gPj4gPiA+SSB3b25kZXIgaWYgdGhpcyBjb3Vs
ZCBiZSBub3RpY2VkIGJ5IHRoZSBndWVzdCBvciBub3QuIElmIHllcyBzaG91bGQNCj4+ID4+ID4+
ID4gPndlIGNvbnNpZGVyIHN0YXJ0aW5nIHRvIGFkZCB0aGluZyBsaWtlIHZlcnNpb24gdG8gdnRk
IGVtdWxhdGlvbg0KPmNvZGU/DQo+PiA+PiA+PiA+DQo+PiA+PiA+PiA+IEtlcm5lbCBvbmx5IGR1
bXBzIHRoZSByZWFzb24gbGlrZSBiZWxvdzoNCj4+ID4+ID4+ID4NCj4+ID4+ID4+ID4gRE1BUjog
W0RNQSBXcml0ZSBOT19QQVNJRF0gUmVxdWVzdCBkZXZpY2UgWzIwOjAwLjBdIGZhdWx0IGFkZHIN
Cj4+ID4+ID4weDEyMzQ2MDAwMDANCj4+ID4+ID4+ID4gW2ZhdWx0IHJlYXNvbiAweDcxXSBTTTog
UHJlc2VudCBiaXQgaW4gZmlyc3QtbGV2ZWwgcGFnaW5nIGVudHJ5IGlzDQo+Y2xlYXINCj4+ID4+
ID4+DQo+PiA+PiA+PiBZZXMsIGd1ZXN0IGtlcm5lbCB3b3VsZCBub3RpY2UgaXQgYXMgdGhlIGZh
dWx0IHdvdWxkIGJlIGluamVjdGVkIHRvIHZtLg0KPj4gPj4gPj4NCj4+ID4+ID4+ID4gTWF5YmUg
YnVtcCAxLjAgLT4gMS4xPw0KPj4gPj4gPj4gPiBNeSB1bmRlcnN0YW5kaW5nIHZlcnNpb24gbnVt
YmVyIGlzIG9ubHkgaW5mb3JtYXRpb25hbCBhbmQgaXMgZmFyDQo+PiA+ZnJvbQ0KPj4gPj4gPj4g
PiBhY2N1cmF0ZSB0byBtYXJrIGlmIGEgZmVhdHVyZSBzdXBwb3J0ZWQuIERyaXZlciBzaG91bGQg
Y2hlY2sNCj5jYXAvZWNhcA0KPj4gPj4gPj4gPiBiaXRzIGluc3RlYWQuDQo+PiA+PiA+Pg0KPj4g
Pj4gPj4gU2hvdWxkIHRoZSB2ZXJzaW9uIElEIGhlcmUgYmUgYWxpZ25lZCB3aXRoIFZULWQgc3Bl
Yz8NCj4+ID4+ID4NCj4+ID4+ID5Qcm9iYWJseSwgdGhpcyBtaWdodCBiZSBzb21ldGhpbmcgdGhh
dCBjb3VsZCBiZSBub3RpY2VkIGJ5IHRoZQ0KPj4gPj4gPm1hbmFnZW1lbnQgdG8gbWlncmF0aW9u
IGNvbXBhdGliaWxpdHkuDQo+PiA+Pg0KPj4gPj4gQ291bGQgeW91IGVsYWJvcmF0ZSB3aGF0IHdl
IG5lZWQgdG8gZG8gZm9yIG1pZ3JhdGlvbiBjb21wYXRpYmlsaXR5Pw0KPj4gPj4gSSBzZWUgdmVy
c2lvbiBpcyBhbHJlYWR5IGV4cG9ydGVkIHNvIGxpYnZpcnQgY2FuIHF1ZXJ5IGl0LCBzZWU6DQo+
PiA+Pg0KPj4gPj4gICAgIERFRklORV9QUk9QX1VJTlQzMigidmVyc2lvbiIsIEludGVsSU9NTVVT
dGF0ZSwgdmVyc2lvbiwgMCksDQo+PiA+DQo+PiA+SXQgaXMgdGhlIFFlbXUgY29tbWFuZCBsaW5l
IHBhcmFtZXRlcnMgbm90IHRoZSB2ZXJzaW9uIG9mIHRoZSB2bXN0YXRlLg0KPj4gPg0KPj4gPkZv
ciBleGFtcGxlIC1kZXZpY2UgaW50ZWwtaW9tbXUsdmVyc2lvbj0zLjANCj4+ID4NCj4+ID5RZW11
IHRoZW4ga25vd3MgaXQgc2hvdWxkIGJlaGF2ZSBhcyAzLjAuDQo+Pg0KPj4gU28geW91IHdhbnQg
dG8gYnVtcCB2dGRfdm1zdGF0ZS52ZXJzaW9uPw0KPg0KPldlbGwsIGFzIEkgc2FpZCwgaXQncyBu
b3QgYSBkaXJlY3QgYnVtcGluZy4NCj4NCj4+DQo+PiBJbiBmYWN0LCB0aGlzIHNlcmllcyBjaGFu
Z2UgaW50ZWxfaW9tbXUgcHJvcGVydHkgZnJvbSB4LXNjYWxhYmxlLQ0KPm1vZGU9WyJvbiJ8Im9m
ZiJdIg0KPj4gdG8geC1zY2FsYWJsZS1tb2RlPVsibGVnYWN5InwibW9kZXJuInwib2ZmIl0iLg0K
Pj4NCj4+IE15IHVuZGVyc3RhbmRpbmcgbWFuYWdlbWVudCBhcHAgc2hvdWxkIHVzZSBzYW1lIHFl
bXUgY21kbGluZQ0KPj4gaW4gc291cmNlIGFuZCBkZXN0aW5hdGlvbiwgc28gY29tcGF0aWJpbGl0
eSBpcyBhbHJlYWR5IGd1YXJhbnRlZWQgZXZlbiBpZg0KPj4gd2UgZG9uJ3QgYnVtcCB2dGRfdm1z
dGF0ZS52ZXJzaW9uLg0KPg0KPkV4YWN0bHksIHNvIHRoZSBwb2ludCBpcyB0bw0KPg0KPnZ0ZD0z
LjAsIHRoZSBkZXZpY2Ugd29ya3MgZXhhY3RseSBhcyB2dGQgc3BlYyAzLjAuDQo+dnRkPTMuMywg
dGhlIGRldmljZSB3b3JrcyBleGFjdGx5IGFzIHZ0ZCBzcGVjIDMuMy4NCg0KR2V0IHlvdXIgcG9p
bnQuIEJ1dCBJIGhhdmUgc29tZSBjb25jZXJucyBhYm91dCB0aGlzOg0KMS5FeGFjdCB2ZXJzaW9u
IG1hdGNoaW5nIHdpbGwgYnJpbmcgdmFzdCBvZiB2ZXJzaW9uIGNoZWNrIGluIHRoZSBjb2RlLA0K
ICAgZXNwZWNpYWxseSB3aGVuIHdlIHN1cHBvcnQgbW9yZSB2ZXJzaW9ucy4NCjIuIFRoZXJlIGFy
ZSBzb21lIG1pc3NlZCBmZWF0dXJlcyBiZWZvcmUgd2UgY2FuIHVwZGF0ZSB2ZXJzaW9uIG51bWJl
ciB0byAzLjAsDQogICAgaS5lLiwgbmVzdGVkIHRyYW5zbGF0aW9uLCBBY2Nlc3NlZC9EaXJ0eSAo
QS9EKSBiaXRzLCA1IGxldmVsIHBhZ2UgdGFibGUsIGV0Yy4NCjMuIFNvbWUgZmVhdHVyZXMgYXJl
IHJlbW92ZWQgaW4gZnV0dXJlIHZlcnNpb25zLCBidXQgd2Ugc3RpbGwgbmVlZCB0bw0KICAgaW1w
bGVtZW50IHRoZW0gZm9yIGludGVybWVkaWF0ZSB2ZXJzaW9uLA0KICAgaS5lLiwgRXhlY3V0ZVJl
cXVlc3RlZCAoRVIpLCBBZHZhbmNlZCBGYXVsdCBMb2dnaW5nLCBldGMuDQoNCj4NCj5XaGVuIG1p
Z3JhdGlvbiB0byB0aGUgb2xkIHFlbXUsIG1nbXQgY2FuIHNwZWNpZnkgZS5nIHZ0ZD0zLjAgZm9y
DQo+YmFja3dhcmQgbWlncmF0aW9uIGNvbXBhdGliaWxpdHkuDQoNClllcywgdGhhdCBtYWtlcyBz
ZW5zZSBmb3Igc3VjaCBtaWdyYXRpb24uDQpCdXQgSSdtIG5vdCBzdXJlIGlmIHRoZXJlIGlzIGEg
cmVhbCBzY2VuYXJpbyBtaWdyYXRpbmcgdG8gb2xkIHFlbXUsDQp3aHkgbm90IGp1c3QgdXBkYXRl
IHFlbXUgb24gZGVzdGluYXRpb24/DQoNClRoYW5rcw0KWmhlbnpob25nDQoNCg==

