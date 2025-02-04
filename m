Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49ECCC02192
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2025 01:52:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tf86R-0001Ef-BT; Mon, 03 Feb 2025 20:51:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1tf86O-0001EN-3K
 for qemu-devel@nongnu.org; Mon, 03 Feb 2025 20:51:48 -0500
Received: from mgamail.intel.com ([192.198.163.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1tf86H-0000on-QQ
 for qemu-devel@nongnu.org; Mon, 03 Feb 2025 20:51:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1738633901; x=1770169901;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=9upSmDfJQtnAGgWld4H8BD3wR1l+hvWmAMozUfsNuZs=;
 b=BNbb/gQiKiw54iCwjaUuNllz67vOYic0pZzk53KkyHPk5XsgitqkVE6n
 93qj/5C9n6PNq3M6sYiEzq+5s5LyxcKovcVCmatkHQN+puzabU1QJXGnP
 CFwEZjikrTgNtzPuhAdcs08907Or1X2B59g8RKnObJJ+6J267mXmAtvBa
 2Cz8G3ChmSd5OfXunKe7y6IX/mAkkdRcvN2Hg+nzPKComuw2dj+pTFPxi
 qdQ1ZPKqvR6mvnNEE72T4LKvMvCdshQmlKdYbaI3GscxWmw/OFkvR8EP/
 EPK+ocJXdD7HumgR5ZzS8aeT/NdEEtYsmt7Ulf38nCTduVB0zkdUO7n/c Q==;
X-CSE-ConnectionGUID: oo6QquZlTt2vq2UcVy+ZCw==
X-CSE-MsgGUID: 1Hl0kom2SfemOn3Ol8ipgw==
X-IronPort-AV: E=McAfee;i="6700,10204,11335"; a="49796836"
X-IronPort-AV: E=Sophos;i="6.13,257,1732608000"; d="scan'208";a="49796836"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Feb 2025 17:51:38 -0800
X-CSE-ConnectionGUID: WQROQfrMTTm4R0C+9M3Ssw==
X-CSE-MsgGUID: gP5jVNTXRROIKnSa/f45sg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; d="scan'208";a="115444961"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
 by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 03 Feb 2025 17:51:39 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 3 Feb 2025 17:51:37 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Mon, 3 Feb 2025 17:51:37 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.47) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 3 Feb 2025 17:51:36 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jxxhrbzMvAnLqNj3vXiMDtoe+SwlFiB+bS73SCkPzK4u7ipoVQem4ufa7u4TqGsWn0c94y5LfeqcZ12YwHZFG+mRlmPqxN7lzfu+9PAh7acu8bn6dkXxwPkvPbBDXlcPjS1SHPR+DlNnb99dq6+zkQ8poiGhMl+7/vrNwoHiubuENjf8nJPCmay4bNNU83PqU3JkdbjBhoZHjMbceJ4E4uuxHrNPRmEbGWGuWZ5SRXL0TvqzR+ZscQk5ut6o9imoBSTEEC33Lul3myNACBljIFhpY3e6MApaUmwKqXZOOT9cMRbJm+kjC396AvpEuSHHyOvXINcvYjgJP7LntfEzAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9upSmDfJQtnAGgWld4H8BD3wR1l+hvWmAMozUfsNuZs=;
 b=da6mBZZNSszlGI2yPZ6ImRygKUbgqaK+Yggp9Asu8BVyXrlgL/KkQzFUWc3rlfv5jLg/pu5Ugj1OLCBmCkA1FHqcURUd0vNbnLwj7giFBIX74nVMOvPfj4wjqig6on/zWC9UImlUsah+s4Sm4n/JpTV+Y2YvSI5ZR+2PEj50LE8YqJvrvLb+nNZsQV7qqjbsggaCJlaoU+iKBtSlyfsegad+/rGmVYnK3WjBO6YM37ecUZZNMSKqWdGDQ0IudY2bFiKWdyXDtA+Sb8ADjsD8CNDdPeyGiPGcVvx80LrhDLlx5APMSEaqin205ZjJmDzNKE0eynagPaBj5G/2sJoi4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SA1PR11MB6870.namprd11.prod.outlook.com (2603:10b6:806:2b4::16)
 by SJ2PR11MB7716.namprd11.prod.outlook.com (2603:10b6:a03:4f2::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.25; Tue, 4 Feb
 2025 01:51:32 +0000
Received: from SA1PR11MB6870.namprd11.prod.outlook.com
 ([fe80::1b76:3435:dbd0:4864]) by SA1PR11MB6870.namprd11.prod.outlook.com
 ([fe80::1b76:3435:dbd0:4864%4]) with mapi id 15.20.8398.020; Tue, 4 Feb 2025
 01:51:32 +0000
From: "Kim, Dongwon" <dongwon.kim@intel.com>
To: =?utf-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
CC: Dmitry Osipenko <dmitry.osipenko@collabora.com>, "Kasireddy, Vivek"
 <vivek.kasireddy@intel.com>, Akihiko Odaki <akihiko.odaki@daynix.com>, "Huang
 Rui" <ray.huang@amd.com>, =?utf-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?=
 <marcandre.lureau@redhat.com>, =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?=
 <philmd@linaro.org>, Gerd Hoffmann <kraxel@redhat.com>, "Michael S . Tsirkin"
 <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Gert Wollny
 <gert.wollny@collabora.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, 
 Gurchetan Singh <gurchetansingh@chromium.org>, Alyssa Ross <hi@alyssa.is>,
 =?utf-8?B?UGF1IE1vbm7DqSwgUm9nZXI=?= <roger.pau@citrix.com>, Alex Deucher
 <alexander.deucher@amd.com>, Stefano Stabellini <stefano.stabellini@amd.com>, 
 =?utf-8?B?Q2hyaXN0aWFuIEvDtm5pZw==?= <christian.koenig@amd.com>, "Xenia
 Ragiadakou" <xenia.ragiadakou@amd.com>, Pierre-Eric Pelloux-Prayer
 <pierre-eric.pelloux-prayer@amd.com>, Honglei Huang <honglei1.huang@amd.com>, 
 Julia Zhang <julia.zhang@amd.com>, Chen Jiqian <Jiqian.Chen@amd.com>, "Rob
 Clark" <robdclark@gmail.com>, Yiwei Zhang <zzyiwei@chromium.org>, "Sergio
 Lopez Pascual" <slp@redhat.com>
Subject: RE: [PATCH v6 00/10] Support virtio-gpu DRM native context
Thread-Topic: [PATCH v6 00/10] Support virtio-gpu DRM native context
Thread-Index: AQHbcDXbhlx9arVsgEanRzZCBe4QsbMqzcWCgAldBYCAASsJ5IAAl1hggAAW3B6AAGluIA==
Date: Tue, 4 Feb 2025 01:51:32 +0000
Message-ID: <SA1PR11MB6870F6C4479128EA3CBF9543FAF42@SA1PR11MB6870.namprd11.prod.outlook.com>
References: <20250126201121.470990-1-dmitry.osipenko@collabora.com>
 <87cyg844fr.fsf@draig.linaro.org>
 <5aedf1ad-d9b0-4edb-a050-f3d9bee9bccb@collabora.com>
 <87ikprflbb.fsf@draig.linaro.org>
 <PH8PR11MB6879D81CAA931B0718DF3B1EFAF52@PH8PR11MB6879.namprd11.prod.outlook.com>
 <878qqmbzb9.fsf@draig.linaro.org>
In-Reply-To: <878qqmbzb9.fsf@draig.linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR11MB6870:EE_|SJ2PR11MB7716:EE_
x-ms-office365-filtering-correlation-id: 7b5503d7-0bae-4b47-7367-08dd44be735f
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|7416014|366016|1800799024|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?MFJ6d2N6d1l5eTl6VFZjNGtCMnNpUERzU3hOanV4MnZUSWlzOHlsOE9BU2F1?=
 =?utf-8?B?eUZpRVpkVU5tcVBhVVlKT3lMVHJzR1dQU3c5UGpTU0RjUjJMNTBaSFZrZEc0?=
 =?utf-8?B?N2tabWltZmxqQkVmR1NSRTJnb3A4a04zTTM4UlZvYlFpNzEwY2FtTHIyR2Uw?=
 =?utf-8?B?QjdRWVorYUViMVB0cmVLcU5BdTNIV2N1T3ZmbzhQdzdybVRyNnlIbFhzTEFk?=
 =?utf-8?B?a0FGSzFjVUNzek1ITXBNNWhnK1dPYTVTdmQ1RFdES21WTHBEMWNTVVJxS05p?=
 =?utf-8?B?eDkvZXNZaGF2WkpqWG9rTWQ2OUQ4OTY0MWFRZFpKNEh2M3RZMHl5T1B6NUdG?=
 =?utf-8?B?NzZKVzUrZDJCckJPVU5NNEdwM1VvN042ZEZ6b1NYU3JBbnUyRkdrZk9BOVBE?=
 =?utf-8?B?WmtZbzhiODJ6QmFRVndQRUpkQ2VCdzR2dVdXOG85d0ZPaFVOdW9tcFNNWmFI?=
 =?utf-8?B?aXpSSEU0OHM2REZWeUxJakFhbk55cnRzSmFXMW14SUlNRUhKV2lEVzJWcU90?=
 =?utf-8?B?WEJmZUNOQXNrcFpLZy93R0k4VjN2ZEtUbWR1SFltaXprL3l0TDlQb25Ba1N2?=
 =?utf-8?B?TUpWNjNhMHNtOG93N05WeUxpVjNxSkVGVDFqSG5wSm9OQ0VZd3R2aEx4L3lJ?=
 =?utf-8?B?Rjg4Mmdnd1c3OTZ1WWNsUCtpWXhvKzlvR2hEaDk3czFJN1MrTU02aHY4bFVz?=
 =?utf-8?B?YStJVmZFZkhxTTdrdkdYTzdoWEc1cnZrSWRkdTQ0SkhmQlNEUEo0TjFYckk5?=
 =?utf-8?B?ZWtDQW9TeThsMm11dS9UWHl6T0pLWlRxQkQrQWJIblJlZWRUamE4ckZYOVo2?=
 =?utf-8?B?bjhOeGdFdkoxVE1pYWVlRnVLSmxiVXhnK1RwMjMwdWhIT1hpeGhCMm1nNGVh?=
 =?utf-8?B?UEZ1S1pyRG0wR2h2ZXVCVlo4bkVNRUw5Y1doR25aeTJmZC9acDRqZFVPQWFJ?=
 =?utf-8?B?ckNLZTlkUEdrZ0lTU2hUdW8zVUs2cTVzUGJ1TnQwb0ZOak9xaHMwZ1ViZGRH?=
 =?utf-8?B?VkN3NEpNTm83MGlrUitCN21mQ1NndU5Cb3J5L2MvckZqSTdpaHpibFFuNDNE?=
 =?utf-8?B?S0lTbzkzdWpHWUtjRkpncWVyOCtYVmg0UU9GWmFHUGtNdzVOWEZrOXUzVHZZ?=
 =?utf-8?B?QUR4elo3dkkzTm9vNytVTGlZZWdpQmFPeHF4UFdMcUhyTkJKUENGa1RDT0hS?=
 =?utf-8?B?ZVBEeUFhaDFsZlh6UHBjR2dEUWR3LzQxd3A3Zk8vU1pBbEZxS0pPNzhQVVhw?=
 =?utf-8?B?Tm91aHBZcmtqWUMxWHVxZ0dxZVcyMGlnSHY4ZGpRL2tjL2RTbFV0NVc0bmRh?=
 =?utf-8?B?OVpzUUNXZnZMa1hyZFQwdy9OdklNcGVZNnovbXJkbkZGUHV6L0tVV1BUaXFC?=
 =?utf-8?B?OGVCZGh4OUM0Y3NHdDFzWWxvM1VWYWJmWG4wdEVLM0FXWjk3WEptSG1hWHQ3?=
 =?utf-8?B?aFlOMjc2dUcxNGczRjMzcHhjeWMxSDRHL1pCK1hBdmhEQTZxSmUzQ1MzVHpY?=
 =?utf-8?B?SFEwRmd1aENLMGRocTJvbVJkYkVicmxZS1UyNWlvZFRZRUFsd0hBQlRUTmtN?=
 =?utf-8?B?a3JseWZ0bUJmcVFnU2JqNG1IRERWTWFsOVdlUkc2M3VDcEZNNFoxTjBmRi9O?=
 =?utf-8?B?RS91NDJuSWcyMjNQZ1dnTGNQQ2E2dXdvR0xwQndtWGZSWFBCL3JnZ2pvclUr?=
 =?utf-8?B?VHpsTzlpTm8yMFIzTDR6YzhVaEtKL2NPdWsrZUNaWXAvWFJ0ZUNIVFBFVS9S?=
 =?utf-8?B?QkMyOGhyZEZKY2FGek0zaWdTRDRJZU1yanJ5SC8xTXdkeURNOURKeEl0TWNt?=
 =?utf-8?B?QWxESnJtYzRTZlB3Q0NsdzlYWm0rcFN6am5Iclk5VEFVbEpyOStHaWdQOVZu?=
 =?utf-8?B?OTY4SUpZU25FUlJHVUExeU1iR2Q1cWZoZ1czNnBqVzNnWDZNUGIvcERTbWNG?=
 =?utf-8?Q?CMMcr9tHXuPKAY7VUtiKGAmNnFDcVASe?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR11MB6870.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?a01UazJGMVUyUmlVM2w4Y1V5VEFBZUdBV3JNZDhvaGdPU1o0VUFzNHpSckZo?=
 =?utf-8?B?UUpGMElicXBlQWV1MGdRSHpaVFdKZGZGN21QN2xmZVRVNWFJNnJENW9XOEg1?=
 =?utf-8?B?c1BQSG1pQ0Viek1ERHdPZjQ1dDFsbEY0TmtUdDlWUmVrcFBNM2NBUFkwMzJo?=
 =?utf-8?B?bWdPNENaUTJNbDhVRktjM0o3TXlCc0RaS3JkMzFLNXk4dVkwcytxbWd1ZVpC?=
 =?utf-8?B?MHhlUCswNFh4RWlvM0w4YklOdi82ZlVMblRSd21EWXNZUzZXaDhocDI3SS9j?=
 =?utf-8?B?WElhT2t2TzJZMnpUbjE1a1JPbHJjY0FFOWthZE9MSFhmL09yYmxRV1lseXF2?=
 =?utf-8?B?d1RnUUliZk0yeXY4T2xWdlVTcURJS2VsSGV1YUM3Tm9oNStqUGYrRitpMXJ1?=
 =?utf-8?B?U01NMnY1N250WG5YRUUzOGMvV3pCTjY5cmExeUtWbFp2VUUwOUJtbURCMHJr?=
 =?utf-8?B?cHRPeTE2UGluQzFjbVpvUk1jWjNSMi9Ta3VUTVVoWTd0REU4eDZNMmhmZGxQ?=
 =?utf-8?B?TUs3QytES0pMYXlEbGtHSFgzNmpzRCtTanB0R0R5Y2RzWFFFcitPYWVJYms5?=
 =?utf-8?B?TW9yUWppYWo1elhVWkhtWEVqNmdKeVltSnNFRWRmUk8zWDFscDhEb1Vka2pS?=
 =?utf-8?B?ek8raUlsbk1hd1NlZE5wbU4ydGZzVlE5c1c2OFk2dUZXQVpmMnd3VU16RGh6?=
 =?utf-8?B?RVl1S3dqaG95aCtKaXNnOXpadllJTnVZdm95MEpYcHdKZ3dGYXlpWUNSaXpN?=
 =?utf-8?B?dy9WVTAvUnY5ZFVueE5sd1Fjam5HZVhJak43clN6SjhYQmt4Y2dLdENqN2R6?=
 =?utf-8?B?YVhBbXpabHZzRXVFbW1Gb3ZSSTgxd092aVNZemtRYmhkT0xHYTZQTHRRdFkv?=
 =?utf-8?B?UE9PeFIxZXhSZXY1RlhOOWM0ZkZTc25MN05YcmF3U2pDMFY4RVRCVkRnMm5I?=
 =?utf-8?B?RFN6S0NBdkZLWTRuM1Q2VEJEc0JMOWlaaExPSTFjbVdFNDJEUFVJSEJvY1pB?=
 =?utf-8?B?dEdtbmRTQUdUVXRTVU8xejltV0JTTlFWZkNKSkFYYjhDaEpvODVOYXhDbmZP?=
 =?utf-8?B?TnB0cnVpNklIcFBUbzIzTDBBVHllSlhJc05rdm9ONVBBeEZmRWtGZWJXQk8r?=
 =?utf-8?B?Z1orVUpKOHhtV1FnMlM1eWdQQkdZUWVnNDB2RjhMZlU1VG1HYjQxWjR3aENq?=
 =?utf-8?B?UURVempBcUVNZ3lzd3VteHBQL3BJS0FNUnNiNmM0L2FGankrb3FnUEhOc0tt?=
 =?utf-8?B?YlluZXFkeXVDaEhmOURDQ2pFUjBQYWhhRDhUazZ6bUg4Z2lkQzFoS3cyMDRq?=
 =?utf-8?B?VDNScjZPWGowbERWa0ZWNmFBaGZFOWJRSXdseW1TYkFCdUtRSlQ1Q2hvekVB?=
 =?utf-8?B?WkJWRlp3UkFPS05pVHp0T01tZWJmYmh0dERJWHI0VXBwbzNndURvWUt6SHdI?=
 =?utf-8?B?UWtFMkduWFB2RTJRUVZwOS9oQ0lJRmdJMEZHUkQ1VkNOcEJFdXpXTXJIWWp0?=
 =?utf-8?B?S3ZYaW1vZVdhUDlsNWNkWUtMdTJSMnQxL2dYZTMrdDdEUGZuNFAvRTdLNG0w?=
 =?utf-8?B?RTdTazhONkJUZlIydGZJVEFWcktTbVBhOGtKbEtMMm1qeEluc004UkIrb3Q2?=
 =?utf-8?B?OXFvVHl0YVpUOU1EbUJNNm1HZ1VHd0RIK1g2Rm1WazEyalJuK3dqaFQweThh?=
 =?utf-8?B?QmNtZFRRUUJlODZJUEduWE5xM2RaYWMvMzdYd2g4WmxOUG5TUjg2U1BvZ1BR?=
 =?utf-8?B?Y1F4VlRhejFHMGszK1VkcDFmaHN5ZVdicjBEd3hGdVdzeGJ5NEtWemEzKzBG?=
 =?utf-8?B?ZUh5V1lQb0VJY211SDlaWnVzUW9sTG5rem5XS1ZxbXdCL05FVzJodEs3OGY1?=
 =?utf-8?B?cUdUYWM0MEVNOXNMNmpUUUhyUGtIQVZuOUpDNWRSVW9wTkFrM3NEK0tIZ1VD?=
 =?utf-8?B?K2luZ2Q2aWlTMUdmd2pYdDhQZ1hPMlY1Q2JEZmJObUhaREhmNmRZdlFuOVpS?=
 =?utf-8?B?c3dMeVBvVWJiU2ZTampQOXovR0pZK3NkZWc3OXpxbWZBZ2hZRTNENDlRMjVt?=
 =?utf-8?B?QldIRUtZbjFnMmE2ZWVGdGtMNklLWlBDeDdUTkt5V0hJZnFQOHpiVVFCci9C?=
 =?utf-8?Q?4RVDtqvcm6LxI+nZ3rTanCksN?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6870.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b5503d7-0bae-4b47-7367-08dd44be735f
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Feb 2025 01:51:32.6488 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eHyh08u1rdRASQfIfADZ6CW63/zfbGAjOwoCqse2KDz4Dzm57ilnfvVi10j6Uiw2Kuk+yA5EzfEzhQogJzp73A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7716
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.9; envelope-from=dongwon.kim@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -11
X-Spam_score: -1.2
X-Spam_bar: -
X-Spam_report: (-1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 THREAD_INDEX_BAD=3.196 autolearn=no autolearn_force=no
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

PiBTdWJqZWN0OiBSZTogW1BBVENIIHY2IDAwLzEwXSBTdXBwb3J0IHZpcnRpby1ncHUgRFJNIG5h
dGl2ZSBjb250ZXh0DQo+IA0KPiAiS2ltLCBEb25nd29uIiA8ZG9uZ3dvbi5raW1AaW50ZWwuY29t
PiB3cml0ZXM6DQo+IA0KPiA+IEhpLA0KPiA+DQo+ID4gVGhlIGNvbW1pdCBiZWxvdyBjb3VsZCBj
aGFuZ2UgdGhlIHRpbWluZyBvZiBkcmF3aW5nIGJ5IG1ha2luZyB0aGUNCj4gPiBkcmF3aW5nIGRv
bmUgYXQgcmVmcmVzaCBjeWNsZSBpbnN0ZWFkIG9mIHZpYSBkcmF3aW5nIGV2ZW50LiBTbyBpdA0K
PiA+IGxvb2tzIGxpa2UgZWl0aGVyIGRtYWJ1ZiBvciBjbGllbnQncyBmcmFtZWJ1ZmZlciBpcyBi
ZWluZyB3cml0dGVuIGFuZA0KPiA+IHJlYWQgYXQgdGhlIHNhbWUgdGltZS4gSGV5LCBjYW4geW91
IGRlc2NyaWJlIGhvdyB0aGUgY29ycnVwdGlvbiBsb29rcw0KPiA+IGxpa2U/IElzIGl0IGp1c3Qg
Z2FyYmFnZSBpbWFnZSB3aXRoIHJhbmRvbSBub2lzZSBvciB0aGUgYWN0dWFsIGZyYW1lIHdpdGgg
c29tZQ0KPiBkZWZlY3RzIGxpa2UgdGVhcmluZy4uLj8NCj4gDQo+IFRoZSB0ZXJtaW5hbCBnZXRz
IG1pcnJvcmVkIHVwc2lkZSBkb3duIGFuZCB0aGUgbW91c2UgY3JlYXRlcyBkYW1hZ2UgYXMgaXQN
Cj4gbW92ZXMgYWJvdXQuDQoNCkkgYW0gd29uZGVyaW5nIGlmIHRoaXMgaXMgcmVwcm9kdWNpYmxl
IHdpdGhvdXQgdmlyZ2wgYW5kIGRybSBuYXRpdmUgY29udGV4dCAobGlrZSB3Lw0Kc3cgcmFzdGVy
aXplciBvbiB0aGUgZ3Vlc3QpIGFzIHdlbGwuIA0KDQo+IA0KPiA+DQo+ID4+IFN1YmplY3Q6IFJl
OiBbUEFUQ0ggdjYgMDAvMTBdIFN1cHBvcnQgdmlydGlvLWdwdSBEUk0gbmF0aXZlIGNvbnRleHQN
Cj4gPj4NCj4gPj4gRG1pdHJ5IE9zaXBlbmtvIDxkbWl0cnkub3NpcGVua29AY29sbGFib3JhLmNv
bT4gd3JpdGVzOg0KPiA+Pg0KPiA+PiA+IE9uIDEvMjcvMjUgMTk6MTcsIEFsZXggQmVubsOpZSB3
cm90ZToNCj4gPj4gPiAuLi4NCj4gPj4gPj4gSSdtIHN0aWxsIHNlZWluZyBjb3JydXB0aW9uIHdp
dGggLWRpc3BsYXkgZ3RrLGdsPW9uIG9uIG15IHg4Ng0KPiA+PiA+PiBzeXN0ZW0gQlRXLiBJIHdv
dWxkIGxpa2UgdG8gdW5kZXJzdGFuZCBpZiB0aGF0IGlzIGEgcHJvYmxlbSB3aXRoDQo+ID4+ID4+
IFFFTVUsIEdUSyBvciBzb21ldGhpbmcgZWxzZSBpbiB0aGUgc3RhY2sgYmVmb3JlIHdlIG1lcmdl
Lg0KPiA+PiA+DQo+ID4+ID4gSSByZXByb2R1Y2VkIHRoZSBkaXNwbGF5IG1pcnJvcmluZy9jb3Jy
dXB0aW9uIGlzc3VlIGFuZCBiaXNlY3RlZCBpdA0KPiA+PiA+IHRvIHRoZSBmb2xsb3dpbmcgY29t
bWl0LiBUaGUgcHJvYmxlbSBvbmx5IGhhcHBlbnMgd2hlbiBRRU1VL0dUSw0KPiA+PiA+IHVzZXMg
V2F5bGFuZCBkaXNwbGF5IGRpcmVjdGx5LCB3aGlsZSBwcmV2aW91c2x5IEkgd2FzIHJ1bm5pbmcg
UUVNVQ0KPiA+PiA+IHdpdGggWFdheWxhbmQgdGhhdCBkb2Vzbid0IGhhdmUgdGhlIHByb2JsZW0u
IFdoeSB0aGlzIGNoYW5nZSBicmVha3MNCj4gPj4gPiBkbWFidWYgZGlzcGxheWluZyB3aXRoIFdh
eWxhbmQvR1RLIGlzIHVuY2xlYXIuDQo+ID4+DQo+ID4+IEFoaCB0aGF0IG1ha2VzIHNlbnNlIC0g
SSBvYnZpb3VzbHkgZm9yZ290IHRvIG1lbnRpb24gSSdtIHJ1bm5pbmcNCj4gPj4gc3dheS93YXls
YW5kIGFjcm9zcyBib3RoIG1hY2hpbmVzLg0KPiA+Pg0KPiA+PiA+IFJldmVydGluZyBjb21taXQg
Zml4ZXMgdGhlIGJ1Zy4NCj4gPj4gPg0KPiA+PiA+ICtEb25nd29uIEtpbSArVml2ZWsgS2FzaXJl
ZGR5DQo+ID4+ID4NCj4gPj4gPiBjb21taXQgNzdiZjMxMDA4NGRhZDM4YjNhMmJhZGYwMTc2NmM2
NTkwNTZmMWNmMg0KPiA+PiA+IEF1dGhvcjogRG9uZ3dvbiBLaW0gPGRvbmd3b24ua2ltQGludGVs
LmNvbT4NCj4gPj4gPiBEYXRlOiAgIEZyaSBBcHIgMjYgMTU6NTA6NTkgMjAyNCAtMDcwMA0KPiA+
PiA+DQo+ID4+ID4gICAgIHVpL2d0azogRHJhdyBndWVzdCBmcmFtZSBhdCByZWZyZXNoIGN5Y2xl
DQo+ID4+ID4NCj4gPj4gPiAgICAgRHJhdyByb3V0aW5lIG5lZWRzIHRvIGJlIG1hbnVhbGx5IGlu
dm9rZWQgaW4gdGhlIG5leHQgcmVmcmVzaA0KPiA+PiA+ICAgICBpZiB0aGVyZSBpcyBhIHNjYW5v
dXQgYmxvYiBmcm9tIHRoZSBndWVzdC4gVGhpcyBpcyB0byBwcmV2ZW50DQo+ID4+ID4gICAgIGEg
c2l0dWF0aW9uIHdoZXJlIHRoZXJlIGlzIGEgc2NoZWR1bGVkIGRyYXcgZXZlbnQgYnV0IGl0IHdv
bid0DQo+ID4+ID4gICAgIGhhcHBlbiBiYWNhdXNlIHRoZSB3aW5kb3cgaXMgY3VycmVudGx5IGlu
IGluYWN0aXZlIHN0YXRlDQo+ID4+ID4gICAgIChtaW5pbWl6ZWQgb3IgdGFiaWZpZWQpLiBJZiBk
cmF3IGlzIG5vdCBkb25lIGZvciBhIGxvbmcgdGltZSwNCj4gPj4gPiAgICAgZ2xfYmxvY2sgdGlt
ZW91dCBhbmQvb3IgZmVuY2UgdGltZW91dCAob24gdGhlIGd1ZXN0KSB3aWxsIGhhcHBlbg0KPiA+
PiA+ICAgICBldmVudHVhbGx5Lg0KPiA+PiA+DQo+ID4+ID4gICAgIHYyOiBVc2UgZ2RfZ2xfYXJl
YV9kcmF3KHZjKSBpbiBndGstZ2wtYXJlYS5jDQo+ID4+ID4NCj4gPj4gPiAgICAgU3VnZ2VzdGVk
LWJ5OiBWaXZlayBLYXNpcmVkZHkgPHZpdmVrLmthc2lyZWRkeUBpbnRlbC5jb20+DQo+ID4+ID4g
ICAgIENjOiBHZXJkIEhvZmZtYW5uIDxrcmF4ZWxAcmVkaGF0LmNvbT4NCj4gPj4gPiAgICAgQ2M6
IE1hcmMtQW5kcsOpIEx1cmVhdSA8bWFyY2FuZHJlLmx1cmVhdUByZWRoYXQuY29tPg0KPiA+PiA+
ICAgICBDYzogRGFuaWVsIFAuIEJlcnJhbmfDqSA8YmVycmFuZ2VAcmVkaGF0LmNvbT4NCj4gPj4g
PiAgICAgU2lnbmVkLW9mZi1ieTogRG9uZ3dvbiBLaW0gPGRvbmd3b24ua2ltQGludGVsLmNvbT4N
Cj4gPj4gPiAgICAgQWNrZWQtYnk6IE1hcmMtQW5kcsOpIEx1cmVhdSA8bWFyY2FuZHJlLmx1cmVh
dUByZWRoYXQuY29tPg0KPiA+PiA+ICAgICBNZXNzYWdlLUlkOiA8MjAyNDA0MjYyMjUwNTkuMzg3
MTI4My0xLWRvbmd3b24ua2ltQGludGVsLmNvbT4NCj4gPj4NCj4gPj4NCj4gPj4gTWF5YmUgYSBy
YWNlIG9uOg0KPiA+Pg0KPiA+PiAgICAgUWVtdURtYUJ1ZiAqZG1hYnVmID0gdmMtPmdmeC5ndWVz
dF9mYi5kbWFidWY7ID8NCj4gPj4NCj4gPj4gLS0NCj4gPj4gQWxleCBCZW5uw6llDQo+ID4+IFZp
cnR1YWxpc2F0aW9uIFRlY2ggTGVhZCBAIExpbmFybw0KPiANCj4gLS0NCj4gQWxleCBCZW5uw6ll
DQo+IFZpcnR1YWxpc2F0aW9uIFRlY2ggTGVhZCBAIExpbmFybw0K

