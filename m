Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA333C25B77
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2024 08:06:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s9gz1-0001ml-AS; Wed, 22 May 2024 04:05:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1s9gyz-0001mL-E2; Wed, 22 May 2024 04:05:58 -0400
Received: from mgamail.intel.com ([192.198.163.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1s9gyu-00080E-1Y; Wed, 22 May 2024 04:05:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1716365152; x=1747901152;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=MC6092zuaDbyDfNl3FGP20PZdQ+wrhozu556J4Pdgnc=;
 b=N1NuPS3tLIL0SmBC2zbkKlW4TVXcRPNOwoz3UpVrjD+0F3ILzYmKuJ7t
 RWSeAYm106uQS5b9bkb68FFSOoRvBC3/qX0Pu/b2/XWUIjhylMQhUJSWK
 nhEXyKJwYZMrAdhAGc3ck4RqT2V9GCjUYT1D6zJ6Yq82+k4MemS8XebhI
 wt3WmKQnPbS1hxxsAtPACukAtzdfMhG5pOwAY2Mw4BlvoA+ZGL7u3MLNM
 SJcAcYEGh5495hcF7NYB9UBkNzuhOSS927AfjF4+uCJWwMVoAN06Fw5tr
 HBp65lyM3xaMGtTafEUbA2IFKctNSytDs12ghwtR8y9Ckc18D70T98Yol Q==;
X-CSE-ConnectionGUID: K63iGkLhSdW1cByH6vfOXQ==
X-CSE-MsgGUID: V7sVpjgAS6CJcChaEt54IQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11079"; a="12384097"
X-IronPort-AV: E=Sophos;i="6.08,179,1712646000"; d="scan'208";a="12384097"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 May 2024 01:05:50 -0700
X-CSE-ConnectionGUID: xc22ocT5T5usEW00siJ2yQ==
X-CSE-MsgGUID: kxLWPK5sR+eZwTmu/5YTJQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,179,1712646000"; d="scan'208";a="33114509"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
 by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 22 May 2024 01:05:49 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 22 May 2024 01:05:49 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 22 May 2024 01:05:49 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 22 May 2024 01:05:49 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 22 May 2024 01:05:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TUSweOo5VJQYz6+b3q1UMYsnw7hso18iSFLjv1Eq+CUIWSYioMrIS4rueJbPEa1sPZ4Xis9J1kfG718Vt5K38HWdZX32XrrPSEcXEuHkkdj9yc6uGIM3FKfDhbzjleZQ3go/o1tm2jx3RLbMc0nl1GWRZi3jFtLE9jKFXjqyqVFETv3CtQWVOaGUpvQNrdgbUOJOuqpnGUz/nUm9HqNakQlrhEvAi1zefX1Rt2livrh8wCdEUZal4sUX40PZTWm1i7tARtVWWPwXz0R3erOeiRL9qBi84+IMbMy9l/joCgFsPDB9MA/9L1IZJEUzGUsVXvSAzmUbOiHrA+2hB6i3UQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MC6092zuaDbyDfNl3FGP20PZdQ+wrhozu556J4Pdgnc=;
 b=g5aAspgsj43DBtxrg754/OkjRAq+YWQBLURVP0+BMv7HoiY1A51WNAdG5AZWkj9wjBWOjVvzApdIYpGrGUIlJAwYnE0DtOX9DTwuRJHkCzN9J3Fo056bzBpuFwloBqmGNQUZGOqw9SX/E4CyE0vAcpyZJ+s5cNhcK7UkDas4PTVOjoecYKHkoCyEM+AzaAP/+f39yhj7Fq/uSJbCIfwcvAtJItSZ2T/GzW566wGbEzDI3wVM+at+1epRdfgm2DdO+ZsfTZknopxKy1XYtAw4FnmPoI5YvTtFCGhvQyVyjT2WXjus7b1zx/Eg1YgxZ7Dt1o9rljQXGbjsKsbXYoMR6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6722.namprd11.prod.outlook.com (2603:10b6:510:1ae::15)
 by CY8PR11MB6962.namprd11.prod.outlook.com (2603:10b6:930:59::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.19; Wed, 22 May
 2024 08:05:46 +0000
Received: from PH7PR11MB6722.namprd11.prod.outlook.com
 ([fe80::9136:e302:ad5f:b522]) by PH7PR11MB6722.namprd11.prod.outlook.com
 ([fe80::9136:e302:ad5f:b522%4]) with mapi id 15.20.7587.035; Wed, 22 May 2024
 08:05:46 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "Peng, Chao P"
 <chao.p.peng@intel.com>, Eric Farman <farman@linux.ibm.com>, Matthew Rosato
 <mjrosato@linux.ibm.com>, Thomas Huth <thuth@redhat.com>, "open
 list:vfio-ccw" <qemu-s390x@nongnu.org>
Subject: RE: [PATCH v2 20/20] vfio/ccw: Fix the missed unrealize() call in
 error path
Thread-Topic: [PATCH v2 20/20] vfio/ccw: Fix the missed unrealize() call in
 error path
Thread-Index: AQHarAKaeJBb6tYqCEy6ytin8rnJz7Gi4b8AgAAC6uA=
Date: Wed, 22 May 2024 08:05:46 +0000
Message-ID: <PH7PR11MB6722B0B1F6A3D0004BD77F7492EB2@PH7PR11MB6722.namprd11.prod.outlook.com>
References: <20240522044015.412951-1-zhenzhong.duan@intel.com>
 <20240522044015.412951-21-zhenzhong.duan@intel.com>
 <8e3efc39-b8a1-4750-86d3-1d2451ad2b65@redhat.com>
In-Reply-To: <8e3efc39-b8a1-4750-86d3-1d2451ad2b65@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6722:EE_|CY8PR11MB6962:EE_
x-ms-office365-filtering-correlation-id: df385ff9-cc3e-468c-b7e7-08dc7a35fc69
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|376005|1800799015|366007|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?VGZTM0xiUXJHUjdwSk1iaDFXNXJBaWhHbEJDa0UwUEVOSEpjanRuV0wrR1Mr?=
 =?utf-8?B?RnRXOFFCYk1XYmQrTkQ0WWpaTFFNNkdNclUxaW8xRWpUQWRUamZqNk9oOUVo?=
 =?utf-8?B?M2t6WDAvRTlyZWZ0cUJlaDVXN3BnRmxoS2p3YUN4K3I1eWNaMGEzcWJkR0Iw?=
 =?utf-8?B?MkpYc0dRNkl4R3BjVXpScURVc3BpaElYSHI2cFFEVGY4NGhIekR1SXI1VGgr?=
 =?utf-8?B?OUFtOEtZeUVEU3NxNzQzNnhnN3VtT3RYb2JUVkN4WjlqZ2IxWXYrdG14dk4v?=
 =?utf-8?B?SHZMZ2dwRVpmTmxFM3p5OTNoZE5JTWhtZDRGTTQ5eW5GYzEvSUlHbmNDT092?=
 =?utf-8?B?citlMWxXR05wNkF3TmJLM1BiT0VPa2hlRUplVllxdGlMTUxlVHl6L2ZJRWdI?=
 =?utf-8?B?Y2V1aWRpTDg2T1RyVGVzRDArRDNoUVlmSmVqWmpid2wxaXRpZVEzWnl2OVNl?=
 =?utf-8?B?V1FQQUJoeG9jbGoreHNkdVR5ZU5hRzdsVTBuUm5BZ3dIT2szaUpuRHUvNjBV?=
 =?utf-8?B?aURGK0I1RGtNOG1hM0dlUjc4aklOTmJNT0I0dkR3RkN2L05Bd3NSemRUZEFS?=
 =?utf-8?B?d2tLS3NvN3F6aTM0K3B4NkpXcHM5ZHNLSG81L0hCa0tUY2E5S1p1eWswVzFi?=
 =?utf-8?B?SFRYL1F1QVk5SStIeHBlWmEyK0NvVnRDM2RCM1NTNGxBNHV4Y1VZdDVVWFhF?=
 =?utf-8?B?SE91UFhjam5MMEtvaTZNNU9uZkwvdlFpNG5uSUhFakFyQktnZ0hsNjcyVkVj?=
 =?utf-8?B?Qm9hSXVSL0VTVFNNR05PTWlFODh1NVNlZmlZNTJTMEVtdno1Z1lUWEJsWGhL?=
 =?utf-8?B?MWUwa3lVOWFVQ1p0eWpSY00xb2dDZ2pSTUNhRlRHNjdqU0pHUHR0ZCtZZnF0?=
 =?utf-8?B?anNveERRcmZCald6YlkwOG96OFJtNUFXRHAwTzhUVE9ZTEZpcS9NRmFvWGdu?=
 =?utf-8?B?N09mWjJnd2JMdm5PZm9abFRma3Arcnl4QXdkUjYzUW9DQ1ZaZ05nQUdvV1hX?=
 =?utf-8?B?RnJhU1QyM1FZUXA3MkJHYldnNk8vckhoVHBHc0QxZlNPdzJQWm9XZnVaSHBF?=
 =?utf-8?B?MzkvckFNQ2JjZnRiNi9yMEJ6Tk1uL1VCR0ZUeklLZTBLMWRpbmdRaStyTmZB?=
 =?utf-8?B?N2xmV1FsSFErTU1ycFArVlA0QkExZUdqWTdBTmo1eEtnZk1BRnF3ZXd5S1Bm?=
 =?utf-8?B?eHN5NUVRY0tDZ2JlYUJHaVh3SDQ0UzQydXZQNW9EVFZpcVRrVHZMTHE3TXNi?=
 =?utf-8?B?Z3FKRFVkakxqNDVlWk0vdnRoTHVKWVNEVFpqM2RyN1p5UUFmRkxqUmY2dnA3?=
 =?utf-8?B?aFVZMFVVL24wNHpWRVNSMGhQZWFhVi9DaitKbTEwdTRVb3pCTzRETWxtendI?=
 =?utf-8?B?V0kzejhOc3Rncm8xcGF0ZXpyTUc5NFg0WDBOQmZFUm1kQlQ4S3dER1Z3NWNa?=
 =?utf-8?B?N1RLVE02QnVGSFN5M2diUTk4czdQWGhYdldtVFpuOC8xNi9vbk96eVluV29V?=
 =?utf-8?B?UFp3cWF5KzVmVFRDZjNTTFkvVGxQSkNzbUd1SmlLM3N4MWJFQmNieFBLWUY3?=
 =?utf-8?B?dDRYaDBMWWkwOGRGR0dISVo4eTE2b0ZzVzltclF1M1VNN0h1aXFsYUFweFlG?=
 =?utf-8?B?N0JXdXJMd0J0VjFpVkdrVUtvbHBQYWVhZ1Avekh0aDlCTEMva3FPamd3d2x0?=
 =?utf-8?B?cW1DUDIrb2lEM2pzOVZuVmlNVUdFa0hXRnB3N2VvWVVhY2x6VTFPTEtHSG82?=
 =?utf-8?B?K3RURmxoMnh5R0lKOGRsWFBhZ3U0blZBTVluODhrY3lvMURGK21JVUlBeUx2?=
 =?utf-8?B?NEI4cEVrWXlnV255T1pUQT09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR11MB6722.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(366007)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MXhpTlBaUTYxNkhYWUZibmhMc0t2d1JGK2ZJWnYwV1ZQVEVYWUduQkt3b3Y2?=
 =?utf-8?B?eTc0R09CRmx3RmFQT2RTZmU3Q052TGRjcWVQS2VUSEVoRnZpR3JNbmhyOGpO?=
 =?utf-8?B?ZlNYRjNGN0xNbWZRbzBZNjhtTmRJM1daMTcxdXZWWmpheWNOR1BMQVdGSmpY?=
 =?utf-8?B?elJmWFVER2hhQVpOalBxdm5zaG5talVaSDdqTTJ0RlUrYmx4ZlNJdDd3cG1l?=
 =?utf-8?B?UXRWZFdYdjhQOG5IU2NKWGFMMml1WmsyYVFUbDhnTHZGT0lMaUpveDZJdkJV?=
 =?utf-8?B?Skg5dlZMWWpIaFM3ZEEvZytrbmN4SDFXRkFCbEZwUXBRcFl4Ti9XTWdxdU5C?=
 =?utf-8?B?L0cwRDN0dEtVdkxRaFlTbGhBaGdGQVNuWFlubHFjcXdLeWh6LzErL0lKWnFt?=
 =?utf-8?B?b3FsVVNBT3A4akVZRno2NXpiR0dRZHVHeXhxMDBtUXVYaUVRYVJyRjBkL3Ni?=
 =?utf-8?B?cWZGVmNWUmVGcmZjb2ZNcGxKRHdtdFR1a283V2xQWEdnOGpoWWwxeUtVVjBQ?=
 =?utf-8?B?TjhCc1Zidkdkc1hsRmlQVXRNMlVzQjFWT2t6SUZjaHlqMy85OXRINnE2RDVL?=
 =?utf-8?B?aDFiZE16cnMycXp3MHd3STkySXVqTlhIQ0RzdWhHUWovZFRTM3NVOXhPZTlS?=
 =?utf-8?B?VVgvVHpuZEFqOWRkZnE1QmE5ZzhTWGU5WXJaOGwraGM0eEs3dUprVC9PS0Yx?=
 =?utf-8?B?Sk9aUlBIOVlxeThtMUNlL2hBajE1aFc1bFFETzBsQ2kvcUlKV1NaVVh6MkRZ?=
 =?utf-8?B?eE9DZzdPNXZ4OTh6dnZ4ZEJhcURhUzVxVTJkbjFmV2dXNVgyeHlTRWxiS0t6?=
 =?utf-8?B?cWltREE5N080KzdMNkxsbmZyK0tObnBQdUZRMkM5c21sbnpNRVBDUzJVMUlz?=
 =?utf-8?B?aHZnYzBXZkR3endydHUxaHo0bldrNnJWSUFKTG5JQTVOYW5nSExsWGd5a29l?=
 =?utf-8?B?bWdwQ0R4Q1BWemsvNUgxbmpnRzIzbUptVmRuWlptVlp2TTBqT2RZb2VjR1Nv?=
 =?utf-8?B?SitCZHE0OVhISEhneDk4OTVIUTI2MkMxNVpyQlcxMUR0MUNaU0ovRkI0dUtl?=
 =?utf-8?B?elhod0RmTFpiTDRMc1Yxd0xhcGZBdEFZRDM1WWRRZjJPU2xHenJ1cGpod1M2?=
 =?utf-8?B?QkMyaElxNkN2OG92cXFENVp5b3RSWVMzdlBhWFMvemlYaHlyZnJ1ZVpBVk92?=
 =?utf-8?B?Y2poa2s1M0hDbzBoM2NSamhuS0V1NVBJWWErTTZWZEpGS1FpUG1oVE5SUXJr?=
 =?utf-8?B?VmFFeUpVTGVTUHJwaDVxcmx0TExnSHY3cWVRNkJpSHFRVEhnMGVHam94cVAy?=
 =?utf-8?B?cDBuL3R4VGREdTFuSGhraUxYcjFYY2lpQjlSWUg2Wk5qVE54eThqb214bWVh?=
 =?utf-8?B?aitmS2VCRkNuWU9pTDQwK3hpSFNRK2VsLzhkaTJqbzRiN0xxcVpiMzgzRDRF?=
 =?utf-8?B?R0dkK2hGallOeW9xdzFGTSsvMUZTbkJ6OHAvbDVUNUNKRW5KcjFXOUZveGdi?=
 =?utf-8?B?aFNKSzhHKzl3MDF1a0kxd2lvVlF0RDFJMmRLN3RVNUpNdHViM3hseFlhTTNz?=
 =?utf-8?B?NHFJQTVPOG1NLzJKeTZqQmZZV3EwUFphaENaaEg4dzM2ZHZHdlhrM0N1WkRV?=
 =?utf-8?B?MEN3cUZPcklibjdHMGZnR0pMNUFJMUFTemxGZEh1d3ZMVk5RUUEwdk1QTHRl?=
 =?utf-8?B?TXUwaDZNajRBVmJMMll2RGV1WnlWUXZhWW50TTA2cnF2dHJxZ2dqa0RZSHNw?=
 =?utf-8?B?QXdJd1dYd1VuNUsxdHpjb21HNzM3MndGUnp2ZEY5aWl6OHFkVThjaGdGU1Nu?=
 =?utf-8?B?ZXVXWFN1VlRQa2NtT2MwdTl2MGdkRzBsaGJpSm8rVDBaNDdKVFB6cit6SUFy?=
 =?utf-8?B?L0ZpaDBqd0JhVCtBbUV6RXB1Sjg5cUJIUzVIWjQyMXZWLytqWEp3OVlXczBD?=
 =?utf-8?B?VDhucEZCMmc3U1lCZk1zY0cwNUlCMXpTK2hIZXZiL2xDQTY0TGpiWTU4aXBq?=
 =?utf-8?B?cXAzWVJIUXhXc2M4dEFpd1R4djdjNEQrZDlrZFVjekI2bGdRQTE4ZDhjU0tj?=
 =?utf-8?B?QlJMa2FJcGE5dzY0dk9OT041bkJzQ0VwVlhkQ2pnSnRsaHhXS21OdUZlNSsr?=
 =?utf-8?Q?1VFnQfA8pycWETDMhaC4sezSf?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6722.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df385ff9-cc3e-468c-b7e7-08dc7a35fc69
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 May 2024 08:05:46.6153 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sZMxm1sZw8vsQ0MXADcr5DbnmKUGhcRrQAmZROfnqAfglGYNO7AHKIDJjL2M7dn/rZs3B9INbn8rFnaUqZfRrXLedya68SOvki+5ngzRazI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB6962
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.18;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

SGkgQ8OpZHJpYywNCg0KPi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+RnJvbTogQ8OpZHJp
YyBMZSBHb2F0ZXIgPGNsZ0ByZWRoYXQuY29tPg0KPlNlbnQ6IFdlZG5lc2RheSwgTWF5IDIyLCAy
MDI0IDM6NTIgUE0NCj5UbzogRHVhbiwgWmhlbnpob25nIDx6aGVuemhvbmcuZHVhbkBpbnRlbC5j
b20+OyBxZW11LQ0KPmRldmVsQG5vbmdudS5vcmcNCj5DYzogYWxleC53aWxsaWFtc29uQHJlZGhh
dC5jb207IGVyaWMuYXVnZXJAcmVkaGF0LmNvbTsgUGVuZywgQ2hhbyBQDQo+PGNoYW8ucC5wZW5n
QGludGVsLmNvbT47IEVyaWMgRmFybWFuIDxmYXJtYW5AbGludXguaWJtLmNvbT47IE1hdHRoZXcN
Cj5Sb3NhdG8gPG1qcm9zYXRvQGxpbnV4LmlibS5jb20+OyBUaG9tYXMgSHV0aCA8dGh1dGhAcmVk
aGF0LmNvbT47DQo+b3BlbiBsaXN0OnZmaW8tY2N3IDxxZW11LXMzOTB4QG5vbmdudS5vcmc+DQo+
U3ViamVjdDogUmU6IFtQQVRDSCB2MiAyMC8yMF0gdmZpby9jY3c6IEZpeCB0aGUgbWlzc2VkIHVu
cmVhbGl6ZSgpIGNhbGwgaW4NCj5lcnJvciBwYXRoDQo+DQo+T24gNS8yMi8yNCAwNjo0MCwgWmhl
bnpob25nIER1YW4gd3JvdGU6DQo+PiBXaGVuIGdldCBuYW1lIGZhaWxlZCwgd2Ugc2hvdWxkIGNh
bGwgdW5yZWFsaXplKCkgc28gdGhhdA0KPj4gdmZpb19jY3dfcmVhbGl6ZSgpIGlzIHNlbGYgY29u
dGFpbmVkLg0KPj4NCj4+IEZpeGVzOiA5MDlhNjI1NGVkYSAoInZmaW8vY2N3OiBNYWtlIHZmaW8g
Y2RldiBwcmUtb3BlbmFibGUgYnkgcGFzc2luZyBhDQo+ZmlsZSBoYW5kbGUiKQ0KPj4gU2lnbmVk
LW9mZi1ieTogWmhlbnpob25nIER1YW4gPHpoZW56aG9uZy5kdWFuQGludGVsLmNvbT4NCj4NCj5J
ZiB0aGUgcmVhbGl6ZSBoYW5kbGVyIGZhaWxzLCB0aGUgdW5yZWFsaXplIGhhbmRsZXIgc2hvdWxk
IGJlIGNhbGxlZC4NCj5TZWUgZGV2aWNlX3NldF9yZWFsaXplZCgpLiBXZSBzaG91bGQgYmUgZmlu
ZSB3aXRob3V0IElNTy4NCg0KRG8geW91IG1lYW4gd2hlbiB2ZmlvX2Njd19yZWFsaXplKCkgZmFp
bHMsIHZmaW9fY2N3X3VucmVhbGl6ZSgpIHdpbGwgYmUgY2FsbGVkPw0KTG9va2VkIGludG8gZGV2
aWNlX3NldF9yZWFsaXplZCgpLCBJIGRpZG4ndCBzZWUgd2hlcmUgdmZpb19jY3dfdW5yZWFsaXpl
KCkgd2FzIGNhbGxlZC4NCkRvIEkgbWlzdW5kZXJzdGFuZD8NCg0KVGhhbmtzDQpaaGVuemhvbmcN
Cg0KPg0KPg0KPlRoYW5rcywNCj4NCj5DLg0KPg0KPg0KPg0KPj4gLS0tDQo+PiAgIGh3L3ZmaW8v
Y2N3LmMgfCAzICsrLQ0KPj4gICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAxIGRl
bGV0aW9uKC0pDQo+Pg0KPj4gZGlmZiAtLWdpdCBhL2h3L3ZmaW8vY2N3LmMgYi9ody92ZmlvL2Nj
dy5jDQo+PiBpbmRleCAxNjhjOWU1OTczLi4xNjE3MDRjZDdiIDEwMDY0NA0KPj4gLS0tIGEvaHcv
dmZpby9jY3cuYw0KPj4gKysrIGIvaHcvdmZpby9jY3cuYw0KPj4gQEAgLTU4OSw3ICs1ODksNyBA
QCBzdGF0aWMgdm9pZCB2ZmlvX2Njd19yZWFsaXplKERldmljZVN0YXRlICpkZXYsDQo+RXJyb3Ig
KiplcnJwKQ0KPj4gICAgICAgfQ0KPj4NCj4+ICAgICAgIGlmICghdmZpb19kZXZpY2VfZ2V0X25h
bWUodmJhc2VkZXYsIGVycnApKSB7DQo+PiAtICAgICAgICByZXR1cm47DQo+PiArICAgICAgICBn
b3RvIG91dF91bnJlYWxpemU7DQo+PiAgICAgICB9DQo+Pg0KPj4gICAgICAgaWYgKCF2ZmlvX2F0
dGFjaF9kZXZpY2UoY2Rldi0+bWRldmlkLCB2YmFzZWRldiwNCj4+IEBAIC02MzMsNiArNjMzLDcg
QEAgb3V0X3JlZ2lvbl9lcnI6DQo+PiAgICAgICB2ZmlvX2RldGFjaF9kZXZpY2UodmJhc2VkZXYp
Ow0KPj4gICBvdXRfYXR0YWNoX2Rldl9lcnI6DQo+PiAgICAgICBnX2ZyZWUodmJhc2VkZXYtPm5h
bWUpOw0KPj4gK291dF91bnJlYWxpemU6DQo+PiAgICAgICBpZiAoY2RjLT51bnJlYWxpemUpIHsN
Cj4+ICAgICAgICAgICBjZGMtPnVucmVhbGl6ZShjZGV2KTsNCj4+ICAgICAgIH0NCg0K

