Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE2E5C25B75
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2024 08:45:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sA44p-00012O-Ge; Thu, 23 May 2024 04:45:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sA44e-0000xt-Cn; Thu, 23 May 2024 04:45:22 -0400
Received: from mgamail.intel.com ([198.175.65.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sA44c-0006P4-6Z; Thu, 23 May 2024 04:45:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1716453919; x=1747989919;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=Obu6wYNkzytqJGYt78GqKWEd/TsY5aIHtoNJGtW/OCc=;
 b=gCPhSY0fwA63Thg9L+hOndiS0FQN+a7qrxLYA6VE3a3SS8dDmGTrB1ab
 E0ihBwdiNiH6bbmQ9cLrXdq7fpHq5xhAJu62no9sFWkZNSemo/Q0lT1b/
 5sL8PdU0sVFp3W2gXLQ9eT2dhwnNjDGAUWbLbTSfx2OvWiFEMfDgq8ARe
 CkR1v9g+Q7GrWiwABngtWmxGZU5eKvFK7yigZm5DWs1tqslXPm+2uz5w6
 4h2/R/phts+MsW+J5f0H2XB1KvTgHiJeJNMWXou+78zggZIW1x3ZFYrvO
 t+gIOYP0zCGsG1ctqQ3V8drMFt7HmcEDwCttySL9tcrIrXGX5ddDTPtIK Q==;
X-CSE-ConnectionGUID: XGUdT0ZkRrWgDb10uKvSaw==
X-CSE-MsgGUID: vntTvlnMQqS9hMN6PKGO8g==
X-IronPort-AV: E=McAfee;i="6600,9927,11080"; a="23889670"
X-IronPort-AV: E=Sophos;i="6.08,182,1712646000"; d="scan'208";a="23889670"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 May 2024 01:45:15 -0700
X-CSE-ConnectionGUID: PYU1D9OLRbK6Xgs9iNvNxw==
X-CSE-MsgGUID: aFJJ6jq9QRquVZwOw69UYA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,182,1712646000"; d="scan'208";a="33698572"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
 by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 23 May 2024 01:45:11 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 23 May 2024 01:45:11 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 23 May 2024 01:45:11 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 23 May 2024 01:45:11 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 23 May 2024 01:45:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SSVC0STwynUIe4T6/8a9ZuCjb041VAUT6bZls1XJn78wvMDd4SXUZt3OfXXh688V30M1ZSWIwxXUlBEF0M85QDPUYzGa6p9buVivdEYfkMw2l2NRWVWWq2nmTIonv68fCGudK4egdyQ7l8X8UsgmepVukrobjf1IS9+h4l4xiagZUKfjXLkZvVRdXUcc/00O3udqe55GSWGAU73eJ00JBL3leBy/kJJbKSHbOuNwlHDJcvKG+YkSKW7A8wslxavEYCGHE/AMaA0gOIQ5E90MdC4SnwjJRrYAmj6oS5b9IKbQ1oCvS7DwUm2MjzZwE2n+aQEvn1yAhvberL102A4PYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Obu6wYNkzytqJGYt78GqKWEd/TsY5aIHtoNJGtW/OCc=;
 b=ACcug8dhVj8BfNkChk1Dg1YsXp/VUjRJZDwFOZmi0ZtA0u3VNmspM4Ym6V8BpyhNlJd9CiaLy2AqfNtBlEBlT4VjXv9SE9MqJee/4lpTuzRcJUmSJ6r1u6RRNVUtw0eUr4DWbrIz6Q+dCk6NZCy9SpqO32MAr7x1ndclh34Aa7jCv9OMQJlBLtPAEKXjbXIzeY0vrOhfmbTvcVNAvnL9o1SY2njFb28qBdwg0n4JS3G92A982d0o/xAViXR+me+w9QYx4cRXNrJoD8ajtaJWUQB5SFkbm83XgG7nKwnZWyWXM6Hq+aAK+3gWtck6VgaySW1ULv2S9Blyea7W0Kk93g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by CO1PR11MB4849.namprd11.prod.outlook.com (2603:10b6:303:90::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.19; Thu, 23 May
 2024 08:45:04 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091%7]) with mapi id 15.20.7611.016; Thu, 23 May 2024
 08:45:04 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-s390x@nongnu.org" <qemu-s390x@nongnu.org>, Thomas Huth
 <thuth@redhat.com>, Matthew Rosato <mjrosato@linux.ibm.com>, Eric Farman
 <farman@linux.ibm.com>, Tony Krowiak <akrowiak@linux.ibm.com>
Subject: RE: [PATCH 4/7] s390x/css: Make S390CCWDeviceClass::realize return
 bool
Thread-Topic: [PATCH 4/7] s390x/css: Make S390CCWDeviceClass::realize return
 bool
Thread-Index: AQHarGnRi7R+VX/EhEql5v+QcABCUbGkghyA
Date: Thu, 23 May 2024 08:45:03 +0000
Message-ID: <SJ0PR11MB67445BDFBAC766FB2A41B25B92F42@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20240522170107.289532-1-clg@redhat.com>
 <20240522170107.289532-5-clg@redhat.com>
In-Reply-To: <20240522170107.289532-5-clg@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|CO1PR11MB4849:EE_
x-ms-office365-filtering-correlation-id: 9075b595-d3ae-45a6-3133-08dc7b04a3eb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|1800799015|366007|376005|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?ZnhRYXFaeW5nQ1lEdTVwWUdLRXlDOHlldS9WTXU0SmFDMzF6VUJYZzUxejVM?=
 =?utf-8?B?WkNIendtNFhkeHN2SmJKV1VQWVhrRkRnbGpzSnlrRy9FYmdvMEoza3V0RlpC?=
 =?utf-8?B?eUEvUjRRajZrcFN6R2xmUW4waDM3eTB0a1llNlJISGtJak1iMG1UZ1lUZE1a?=
 =?utf-8?B?TElpRXN5VEJOcmJMUlVBMzZGREhHQnpVY0xCVUo1VW15Y2drU2ROVkE2eEF3?=
 =?utf-8?B?N3dKaVBQT1pMeWM4T2Y1V0J0d2FmOGFkUnE4dDU5R1dYSVFVTERpVXJlc09X?=
 =?utf-8?B?YnFpRHczUC8vTjZpN0tON1FoZEFZbk1SbjhGNE9qTWx6amM0NlF0d1RmdEZp?=
 =?utf-8?B?Z2VXYWJMUFc2aU1pUC9RUWxNUzJTZkdaWGt6ZTNhc3lEYXVVTFRLSUhobmVy?=
 =?utf-8?B?ZHIyandJaGhMeGgxbFBBRU8rbDZVOWFDMlFOb3RCN1FjRWhUNUJIM3hXeWhM?=
 =?utf-8?B?dFY0RkdvM2lSdVZmWGhXU0tPKzF3R2NJcEliUWZRKzR4WDM4YVhOQkl6aXYw?=
 =?utf-8?B?SlpPYitWSDBVVUNDNlN1c0Y2MjRYbjVvdlhvSUtQUjhoRGdJWWovTUwxQk9E?=
 =?utf-8?B?RzBGRlV6QkxGZldQWFFqYThzVWxheFllRmJSNkNsVGtxUFJVUUZHWXlLY3Y1?=
 =?utf-8?B?WWNyUnFRV295bHR0bUJCcFRNTSt3dW1MZFA5eUpyRlpnZUhSU0pySW1pelBD?=
 =?utf-8?B?V01VVDk4cGplL0NCRUJuV3B5WmExRElKYjZ5ZVV2bUFyUHRJL2JRWkZvRC84?=
 =?utf-8?B?aGhLQTIyUC9WNWs0MFVxSVk3dTFjRmNVTlBIOThmVXpiMGt5eG50OEFtOHZN?=
 =?utf-8?B?VVR0VEt3TUdhSE0zL3N6YmlUVGRqelZGZTZraENYZWtSdG5HN2taNFY2amZ4?=
 =?utf-8?B?VTd6OCtkanJnUDlNNHNuUXVSR3ZuQ2JjV1RPZkVNSE4yYXh2UDYrVndCYnN6?=
 =?utf-8?B?dXVqSFcrUjBBa0VPY0tUZ3UyWnZOb3l3eUo4ZjgraUxLb0xiM2xWYVRoRGRT?=
 =?utf-8?B?NUJIaTNwV3JtYjJIdTVjdkVVYzhOUGdYUUlIcjIvYndZdUEyWllsOTM3S2Iv?=
 =?utf-8?B?Tk9pWHhDMWp2Vlc3Nlc1Q3FlRVV5MnhNWXNZVStnVzVPRVpJMFcwUXh4TDVp?=
 =?utf-8?B?ZjJqMjJXS1RmQ2pJSko2OFMwQ1RxTGFjZUY4dHVocVVFNWdEUzlOL1Q0cWc3?=
 =?utf-8?B?bGVPamMyRGtqdnNaYXZPVWpEYmk1dldFem95WXJOeTNYNHY2dFNWdGpwMmRL?=
 =?utf-8?B?bnlDT25mdVlyeFdxY2NrOTZnbDJPOGZhanlRb25ZVWx1d1VpcHVWTWpBYkp5?=
 =?utf-8?B?eGVGMkkvWDRvckREWTdYaG8rL0IxMnBjaEFMNUMvNXhnUXBtQ3NLL2dObDh0?=
 =?utf-8?B?akJYanVTWWNHSVR4VklESzVwSXYwOGFESVZ3TFViV1lqTGFnSnRzRWNUL2FR?=
 =?utf-8?B?b3JQNk1DUk05TlpzVERFNUZ0QzdqTm11SUpZUXFGM0Z4cW1MdmpDZGlzRUdv?=
 =?utf-8?B?TFY0NUtPVWVSZm9YWk9JMGVFQXdwMVo5MDZEd044ZUEvYzh1ekphNGQ5OUlU?=
 =?utf-8?B?eHpsWDhETER4WkZobldiT041R01vMGx1cFhJak1QRm1tL281eXpvTDhYUytv?=
 =?utf-8?B?K284a3BRU0R6Rnh4TjNydEs0SStDUmZ6dytWUStyVm5CWDdPS3orQlp3bjJa?=
 =?utf-8?B?QzAydHM3MllRdnI2YkRNdEJGZU9Vb3NiRWIyZXc0SEZZNXdOQ1MyeWJyMlFZ?=
 =?utf-8?B?WXAvNFh3M2dXM0dyVS9vb1RzS0F0NDQyWG1DOUNaYlB2Q1oydWthOVdNNzdP?=
 =?utf-8?B?L2hCcVI4ek1GZGROcWxLQT09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(366007)(376005)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bkJ3SFZwaXh0QVMvdWdVR3g2Um5CeVNRbkJOL0xGbjVRUlA4eU5HblZpL3Qr?=
 =?utf-8?B?UXNPay82NVhRQW9OU2VXOCthalQ0Ym5BZDRaMEJRUjFZODJaVkZJTWhxWkFz?=
 =?utf-8?B?YlZnNFovcHlMQ3N5aEU1TzY1SnArTUdHendFVElBang2cGxaR3ZiL1lsYWVD?=
 =?utf-8?B?bVpTdjQxVFJDSGRMRVBzVFVMZ3lOM2hTSjRnNHEvck9jN3U2ZXdBZ0JrWm9V?=
 =?utf-8?B?cWUzdEhRUzdiT2NlTW9naVh3aEN1USs0bkEyL0NqQ1RXbHQ1bVZpdlBNcGRJ?=
 =?utf-8?B?TE83aVBBcW5yb3hJOVh2TjJEMEFES2F3Mzg0K3N2aEpaMEU4aVV3cjYxSExu?=
 =?utf-8?B?V2N5RWVtZzRCWEVoNS96MThhVXJYMGsrVUt0K2RxWFlDN2N1MjlDWU5MS2ls?=
 =?utf-8?B?YXMyeU00MTE4SHJETmZXaStNc243dUhtNVFQY0NDaDdya0luOXpwT2YzUjVa?=
 =?utf-8?B?aGxJVnp6MlVTenNzSFVCQ0s3QWRCZTYyL0kvQmJteWtRekhvVXl4OGszN25s?=
 =?utf-8?B?YmNUcytyWkdwaG9sUExFRUswamtJZHhpdi8yY1JpM1pIK1hDanJldDZYRE5m?=
 =?utf-8?B?YytVQVcwT2tORkpTRC9SSmFJZDRwSENPMkxZazhHUldRalEzWFFRM3VnVGli?=
 =?utf-8?B?Y2QvMWdzalBvZ2xpUEdhOTZxdFpTdzhnKy9Rby8zd2lpT0VzUUx3Q2JVRUlF?=
 =?utf-8?B?WlMvOUM3aDNZUFpuTUJjTWdRRW4wMU1LRHJpR1hrRmxwSWVqVFlDc1pmYXZV?=
 =?utf-8?B?SEtZUzlzYlRUN1VRTjJSTEdIUkVqVm8vRGR0V0p4aW84bWlEamQweitZS0xE?=
 =?utf-8?B?YkMxeUZkVmlPczhlN1JTa2JjQ01yNkRsVkppK2tYSEVGcE5pZWRacWxJMmF3?=
 =?utf-8?B?SVZkekFOcWEwU0lTbzg3S25DTmU3U2h1V3g2YVI1dCtxVDNDOG01dEdkN1Q4?=
 =?utf-8?B?WEdVYjFyRDF4TDh5YjZIdE80RVZVNitISDVuaW10eU9uUytiOVdOc0ZzNytI?=
 =?utf-8?B?OXNDNTQ2QjgrVExVWXFIZmlBNllDRE5Gbmh3V3FIRjk0OVFUNkxGd1NiKy9h?=
 =?utf-8?B?UXB4elJpNjBFZFNhUlBkTVVsUlFjb2xCcy8zaDJ6am5VdEtrQ05xZlBlK0Ni?=
 =?utf-8?B?NlhVL3ZzOW5MYkp4MUFKQUNRQTRPL29Ja0tYSERBVkplZENnTk90Rmh0VjZi?=
 =?utf-8?B?VEJUdzZyWlBoZjVzK2JMazV5MmdSRndVNFNreDdkbFRCalRsaDBzRStiWUpM?=
 =?utf-8?B?K1BNVHRQQ2Nad2lkZldhQ2o5QVZqdTZPeTRDTE4zRll4enpHS3ViOUVxaVBM?=
 =?utf-8?B?R3hnblhYYWR0c3Izdm5MZVRLRUpUVmdHZm5QQ2d1N2oyWmRUMktOY0kvWVh1?=
 =?utf-8?B?N3Zpd0VhdTVFUXZtSkRaWXV4U3FsTzFEZ0c5Y00wZ0gzTFdXYWpaYm1rN2w0?=
 =?utf-8?B?RGZMRmdSdXFLanVQbjIzbXpRaG1iMS9jTTVRaVk1WHVTMDUzSTUvakJ1c3o0?=
 =?utf-8?B?czRTM2JTMU9OUHdnZURlZXNRY2Z2VjU5SzdiWnJaU0x3WkIrYkEvZEtHdnB1?=
 =?utf-8?B?cHNxOFFwRml2VlEwS0ZsL3h5S1hqMnpmSG5zWG82Vi9tMFpHMWc5ZU40MFpX?=
 =?utf-8?B?ZVNzb2pEL3pkRFE3UTk3K0ZKRks5NmJjKytrMkNzSFZMNmlhdmh5dzFRMnhs?=
 =?utf-8?B?cGQrVm9vSUtidHpTRVNEQkF3UzhMK3hFMzNtRkkxVXpIVWl5a2FOYW5WVW9F?=
 =?utf-8?B?NElUQlRiN25QVmhsMTgvQVRiVWlJYTd5bXFXK01kd1hxbUY2Wk1PaEtZWTRC?=
 =?utf-8?B?TXJscGk2RGc5SjJzZFYxTFZETE5Bbm9yOERGOGQwNUVzOVhTT0E5dy9zWnRa?=
 =?utf-8?B?d0VGMHZPdmdxR2wyKzFxWGlydDlLWUgrVkxmUlVTTDlQOXVGYW5naHhNdjdG?=
 =?utf-8?B?a3ZlRHlnWEJ4V3doN2NjemliVDc3RzhaSWcxNVgwR0ozU3psRkxkcEhmTnN1?=
 =?utf-8?B?S2tBUXNiSGhkUnZWOE5FdnVpYXlKeXQ2Y2F0RGd4L1hxbjBGK05ZZG5CbmFx?=
 =?utf-8?B?RU1pNFF2WW9NbHRPeDNiWC8zemEzRGxlM1pTWFliUjVMWUdLY2ZhV2o3NUdV?=
 =?utf-8?Q?K5H6eszrBvx5MXIQ5VmlJv3uy?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9075b595-d3ae-45a6-3133-08dc7b04a3eb
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 May 2024 08:45:03.9476 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SBa7h23QHnaMTrsVBM2sIp9GZqm64kNoHbFNKZ6mPo5TfJPx/V1m98xot2rLnnn2SCPK6raSRbuNud28h549sG2yZsIquL1TRXhsANuApn4=
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
IDxjbGdAcmVkaGF0LmNvbT4NCj5TdWJqZWN0OiBbUEFUQ0ggNC83XSBzMzkweC9jc3M6IE1ha2Ug
UzM5MENDV0RldmljZUNsYXNzOjpyZWFsaXplIHJldHVybg0KPmJvb2wNCj4NCj5TaW5jZSB0aGUg
cmVhbGl6ZSgpIGhhbmRsZXIgb2YgUzM5MENDV0RldmljZUNsYXNzIHRha2VzIGFuICdFcnJvciAq
KicNCj5hcmd1bWVudCwgYmVzdCBwcmFjdGljZXMgc3VnZ2VzdCB0byByZXR1cm4gYSBib29sLiBT
ZWUgdGhlIGFwaS9lcnJvci5oDQo+UnVsZXMgc2VjdGlvbi4gV2hpbGUgYXQgaXQsIG1vZGlmeSB0
aGUgY2FsbCBpbiB2ZmlvX2Njd19yZWFsaXplKCkuDQo+DQo+U2lnbmVkLW9mZi1ieTogQ8OpZHJp
YyBMZSBHb2F0ZXIgPGNsZ0ByZWRoYXQuY29tPg0KDQpSZXZpZXdlZC1ieTogWmhlbnpob25nIER1
YW4gPHpoZW56aG9uZy5kdWFuQGludGVsLmNvbT4NCg0KVGhhbmtzDQpaaGVuemhvbmcNCg0KPi0t
LQ0KPiBpbmNsdWRlL2h3L3MzOTB4L3MzOTAtY2N3LmggfCAyICstDQo+IGh3L3MzOTB4L3MzOTAt
Y2N3LmMgICAgICAgICB8IDcgKysrKy0tLQ0KPiBody92ZmlvL2Njdy5jICAgICAgICAgICAgICAg
fCAzICstLQ0KPiAzIGZpbGVzIGNoYW5nZWQsIDYgaW5zZXJ0aW9ucygrKSwgNiBkZWxldGlvbnMo
LSkNCj4NCj5kaWZmIC0tZ2l0IGEvaW5jbHVkZS9ody9zMzkweC9zMzkwLWNjdy5oIGIvaW5jbHVk
ZS9ody9zMzkweC9zMzkwLWNjdy5oDQo+aW5kZXgNCj4yYzgwN2VlM2ExYWU4ZDg1NDYwZmU2NWJl
OGE2MmM2NGYyMTJmZTRiLi4yZTBhNzA5OTgxMzIwNzA5OTZkNmINCj4wZDA4M2I4ZGRiYTViOWI4
N2RjIDEwMDY0NA0KPi0tLSBhL2luY2x1ZGUvaHcvczM5MHgvczM5MC1jY3cuaA0KPisrKyBiL2lu
Y2x1ZGUvaHcvczM5MHgvczM5MC1jY3cuaA0KPkBAIC0zMSw3ICszMSw3IEBAIHN0cnVjdCBTMzkw
Q0NXRGV2aWNlIHsNCj4NCj4gc3RydWN0IFMzOTBDQ1dEZXZpY2VDbGFzcyB7DQo+ICAgICBDQ1dE
ZXZpY2VDbGFzcyBwYXJlbnRfY2xhc3M7DQo+LSAgICB2b2lkICgqcmVhbGl6ZSkoUzM5MENDV0Rl
dmljZSAqZGV2LCBjaGFyICpzeXNmc2RldiwgRXJyb3IgKiplcnJwKTsNCj4rICAgIGJvb2wgKCpy
ZWFsaXplKShTMzkwQ0NXRGV2aWNlICpkZXYsIGNoYXIgKnN5c2ZzZGV2LCBFcnJvciAqKmVycnAp
Ow0KPiAgICAgdm9pZCAoKnVucmVhbGl6ZSkoUzM5MENDV0RldmljZSAqZGV2KTsNCj4gICAgIElP
SW5zdEVuZGluZyAoKmhhbmRsZV9yZXF1ZXN0KSAoU3ViY2hEZXYgKnNjaCk7DQo+ICAgICBpbnQg
KCpoYW5kbGVfaGFsdCkgKFN1YmNoRGV2ICpzY2gpOw0KPmRpZmYgLS1naXQgYS9ody9zMzkweC9z
MzkwLWNjdy5jIGIvaHcvczM5MHgvczM5MC1jY3cuYw0KPmluZGV4DQo+YjNkMTRjNjFkNzMyODgw
YTY1MWVkY2YyOGEwNDBjYTcyM2NiOWY1Yi4uM2MwOTc1MDU1MDg5YzM2MjlkZDc2DQo+Y2UyZTE0
ODRhNGVmNjZkOGQ0MSAxMDA2NDQNCj4tLS0gYS9ody9zMzkweC9zMzkwLWNjdy5jDQo+KysrIGIv
aHcvczM5MHgvczM5MC1jY3cuYw0KPkBAIC0xMDgsNyArMTA4LDcgQEAgc3RhdGljIGJvb2wgczM5
MF9jY3dfZ2V0X2Rldl9pbmZvKFMzOTBDQ1dEZXZpY2UNCj4qY2RldiwNCj4gICAgIHJldHVybiB0
cnVlOw0KPiB9DQo+DQo+LXN0YXRpYyB2b2lkIHMzOTBfY2N3X3JlYWxpemUoUzM5MENDV0Rldmlj
ZSAqY2RldiwgY2hhciAqc3lzZnNkZXYsIEVycm9yDQo+KiplcnJwKQ0KPitzdGF0aWMgYm9vbCBz
MzkwX2Njd19yZWFsaXplKFMzOTBDQ1dEZXZpY2UgKmNkZXYsIGNoYXIgKnN5c2ZzZGV2LCBFcnJv
cg0KPioqZXJycCkNCj4gew0KPiAgICAgQ2N3RGV2aWNlICpjY3dfZGV2ID0gQ0NXX0RFVklDRShj
ZGV2KTsNCj4gICAgIENDV0RldmljZUNsYXNzICpjayA9IENDV19ERVZJQ0VfR0VUX0NMQVNTKGNj
d19kZXYpOw0KPkBAIC0xMTcsNyArMTE3LDcgQEAgc3RhdGljIHZvaWQgczM5MF9jY3dfcmVhbGl6
ZShTMzkwQ0NXRGV2aWNlICpjZGV2LA0KPmNoYXIgKnN5c2ZzZGV2LCBFcnJvciAqKmVycnApDQo+
ICAgICBpbnQgcmV0Ow0KPg0KPiAgICAgaWYgKCFzMzkwX2Njd19nZXRfZGV2X2luZm8oY2Rldiwg
c3lzZnNkZXYsIGVycnApKSB7DQo+LSAgICAgICAgcmV0dXJuOw0KPisgICAgICAgIHJldHVybiBm
YWxzZTsNCj4gICAgIH0NCj4NCj4gICAgIHNjaCA9IGNzc19jcmVhdGVfc2NoKGNjd19kZXYtPmRl
dm5vLCBlcnJwKTsNCj5AQCAtMTQyLDcgKzE0Miw3IEBAIHN0YXRpYyB2b2lkIHMzOTBfY2N3X3Jl
YWxpemUoUzM5MENDV0RldmljZSAqY2RldiwNCj5jaGFyICpzeXNmc2RldiwgRXJyb3IgKiplcnJw
KQ0KPg0KPiAgICAgY3NzX2dlbmVyYXRlX3NjaF9jcndzKHNjaC0+Y3NzaWQsIHNjaC0+c3NpZCwg
c2NoLT5zY2hpZCwNCj4gICAgICAgICAgICAgICAgICAgICAgICAgICBwYXJlbnQtPmhvdHBsdWdn
ZWQsIDEpOw0KPi0gICAgcmV0dXJuOw0KPisgICAgcmV0dXJuIHRydWU7DQo+DQo+IG91dF9lcnI6
DQo+ICAgICBjc3Nfc3ViY2hfYXNzaWduKHNjaC0+Y3NzaWQsIHNjaC0+c3NpZCwgc2NoLT5zY2hp
ZCwgc2NoLT5kZXZubywgTlVMTCk7DQo+QEAgLTE1MCw2ICsxNTAsNyBAQCBvdXRfZXJyOg0KPiAg
ICAgZ19mcmVlKHNjaCk7DQo+IG91dF9tZGV2aWRfZnJlZToNCj4gICAgIGdfZnJlZShjZGV2LT5t
ZGV2aWQpOw0KPisgICAgcmV0dXJuIGZhbHNlOw0KPiB9DQo+DQo+IHN0YXRpYyB2b2lkIHMzOTBf
Y2N3X3VucmVhbGl6ZShTMzkwQ0NXRGV2aWNlICpjZGV2KQ0KPmRpZmYgLS1naXQgYS9ody92Zmlv
L2Njdy5jIGIvaHcvdmZpby9jY3cuYw0KPmluZGV4DQo+MjYwMGU2MmUzNzIzODc3OTgwMGRjMmIz
YTBiZDMxNWQ3NjMzMDE3Yi4uOWE4ZTA1MjcxMWZlMmY3YzA2N2MNCj41MjgwOGIyYWYzMGQwZWJm
ZWUwYyAxMDA2NDQNCj4tLS0gYS9ody92ZmlvL2Njdy5jDQo+KysrIGIvaHcvdmZpby9jY3cuYw0K
PkBAIC01ODIsOCArNTgyLDcgQEAgc3RhdGljIHZvaWQgdmZpb19jY3dfcmVhbGl6ZShEZXZpY2VT
dGF0ZSAqZGV2LCBFcnJvcg0KPioqZXJycCkNCj4NCj4gICAgIC8qIENhbGwgdGhlIGNsYXNzIGlu
aXQgZnVuY3Rpb24gZm9yIHN1YmNoYW5uZWwuICovDQo+ICAgICBpZiAoY2RjLT5yZWFsaXplKSB7
DQo+LSAgICAgICAgY2RjLT5yZWFsaXplKGNkZXYsIHZjZGV2LT52ZGV2LnN5c2ZzZGV2LCAmZXJy
KTsNCj4tICAgICAgICBpZiAoZXJyKSB7DQo+KyAgICAgICAgaWYgKCFjZGMtPnJlYWxpemUoY2Rl
diwgdmNkZXYtPnZkZXYuc3lzZnNkZXYsICZlcnIpKSB7DQo+ICAgICAgICAgICAgIGdvdG8gb3V0
X2Vycl9wcm9wYWdhdGU7DQo+ICAgICAgICAgfQ0KPiAgICAgfQ0KPi0tDQo+Mi40NS4xDQoNCg==

