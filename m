Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05DD6C83F1B
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Jul 2025 07:05:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ucIfg-00026D-9u; Thu, 17 Jul 2025 03:04:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1ucIfa-00022A-34
 for qemu-devel@nongnu.org; Thu, 17 Jul 2025 03:04:42 -0400
Received: from mgamail.intel.com ([192.198.163.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1ucIfX-0004dB-QA
 for qemu-devel@nongnu.org; Thu, 17 Jul 2025 03:04:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1752735879; x=1784271879;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=MBwMBeDPc5v9l1XrD3Brj6bTeeZWqR7b3xKKxazUoL0=;
 b=YAYFKpF7lV+QPpLA/quxI0GqXHdSQHmrwZtFmRu7KLl14CS+0UsE/XVT
 YTQSPFrQ+fQCagHDPFsCZwaGPQJK8bEHMXjSlZChlK87/GS/G4+LRn8DK
 XQptXlmJbuhKlbrgzNd5Ai8Zi9f7afReo/uWPxblJJIrz9mEFMveBC58e
 DPUx56F38J3fzuo++e57Vz5ma+pjuEZi/eZtfgewuf8IqimySIhRWU6jr
 ULHJz0vbW37n0/APgGW3hk8OpPaie9KJYo8VwhediaV0QKNITvDNW7Kjb
 QvMdTpL5iKm8OvuWgM0euNbt7ndO5lINMFMRx+l0f0+FEY/dedvuoqxvN w==;
X-CSE-ConnectionGUID: lDZ8fZXbRRKYWZWP974AVQ==
X-CSE-MsgGUID: sLidNLZXS4q2SAUy1xGQLg==
X-IronPort-AV: E=McAfee;i="6800,10657,11493"; a="55142473"
X-IronPort-AV: E=Sophos;i="6.16,318,1744095600"; d="scan'208";a="55142473"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Jul 2025 00:04:38 -0700
X-CSE-ConnectionGUID: rDYiuf3ZSluarjiFB7YGog==
X-CSE-MsgGUID: a5XvfcfiQzWbpRYOF219iA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,318,1744095600"; d="scan'208";a="157787301"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Jul 2025 00:04:38 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Thu, 17 Jul 2025 00:04:37 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Thu, 17 Jul 2025 00:04:37 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (40.107.236.70)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Thu, 17 Jul 2025 00:04:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d5Ydh/p/0DnNyx2qdxqnwTblsYCqWaeVs0JjFbGxQrXj15exTp1GCnZH9IjsmJr0Tm4X8LCaqYy1EvJCtT0M9si878Ff727+hgNgW+mDIBB3nyIS/BZ8HGZ34Luiz8Fdnea7zi+sWwIDIAMwBUGaj372IXVVjOLIHFTSQwxi57ex1FtjgpFezmG6Fjkbp8uxOjbmznh0qT1bx9WlLRu36wLKvD8IED8q/N15kTTif+wnw/mLVAACetuteyqhxdst1TVFjwO5lL5ZSxxv7UymIUyKhQtuollQojBk5qYAHCLrQG6g7r104JT1fC19EJeryMR21fWe/kfl8OGxI1HtFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MBwMBeDPc5v9l1XrD3Brj6bTeeZWqR7b3xKKxazUoL0=;
 b=uy01FkG3hJgxywu4kQDmNsCdiwXpCM/A3Olfj5a+1hX3N0p/GqahJIQK2TQZbtADPcI2N3Y20Cv0DM1Zu2epLoZIRYjhQl4UjBJbxRjdMiKQQPS+6vTSRuJ3aPP4itRGifCfwKH5qUFmbr25EPXPoWbq4BMrduJDiqftcUvTSZiXhy8lj7QnAp5p4Vt19udGBMvlrpJc6Qnq7tSYnBwF47dgO1rur69enarGB+OzD98QVLLsZwP8TUvxez9/HY3oXQJndsjzGLG47bVzs+Lm8XdkcW71z/ADvO2RX5GM38qtnjlKP+QpzQrJyahgy3RyNmHN+hpH5FIf/gtOcoD3Rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12)
 by BL1PR11MB5288.namprd11.prod.outlook.com (2603:10b6:208:316::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.39; Thu, 17 Jul
 2025 07:03:54 +0000
Received: from IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13]) by IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13%4]) with mapi id 15.20.8835.023; Thu, 17 Jul 2025
 07:03:53 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: "eric.auger@redhat.com" <eric.auger@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>, "mst@redhat.com" <mst@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>, "peterx@redhat.com"
 <peterx@redhat.com>, "ddutile@redhat.com" <ddutile@redhat.com>,
 "jgg@nvidia.com" <jgg@nvidia.com>, "nicolinc@nvidia.com"
 <nicolinc@nvidia.com>, "shameerali.kolothum.thodi@huawei.com"
 <shameerali.kolothum.thodi@huawei.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "clement.mathieu--drif@eviden.com"
 <clement.mathieu--drif@eviden.com>, "Tian, Kevin" <kevin.tian@intel.com>,
 "Liu, Yi L" <yi.l.liu@intel.com>, "Peng, Chao P" <chao.p.peng@intel.com>
Subject: RE: [PATCH v3 07/20] intel_iommu: Check for compatibility with
 IOMMUFD backed device when x-flts=on
Thread-Topic: [PATCH v3 07/20] intel_iommu: Check for compatibility with
 IOMMUFD backed device when x-flts=on
Thread-Index: AQHb7/hoBQVqCDKijEq37aEKMjw/RLQ0hlWAgAAOMLCAACBhgIABABUwgAA4r4CAAAQrAA==
Date: Thu, 17 Jul 2025 07:03:53 +0000
Message-ID: <IA3PR11MB913633CE891F18F36808E76D9251A@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <20250708110601.633308-1-zhenzhong.duan@intel.com>
 <20250708110601.633308-8-zhenzhong.duan@intel.com>
 <342129d6-0b96-440c-83ac-e9b8bc5b18a0@redhat.com>
 <IA3PR11MB9136C85F0799CB91572121FB9256A@IA3PR11MB9136.namprd11.prod.outlook.com>
 <081c3534-332f-454a-985b-4dc81a3dd2a7@redhat.com>
 <IA3PR11MB9136ABA0E88C04CB6E9E80BA9251A@IA3PR11MB9136.namprd11.prod.outlook.com>
 <ea639677-65e4-4eda-be7e-e65d13a22afc@redhat.com>
In-Reply-To: <ea639677-65e4-4eda-be7e-e65d13a22afc@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9136:EE_|BL1PR11MB5288:EE_
x-ms-office365-filtering-correlation-id: 440f924b-1d5f-469b-cba1-08ddc500175f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|7416014|1800799024|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?T3VYa1AyK2NyM3NWZUFrRFkvWUswZTFLSXVvZFBGbmxaK0RMMzdOakFOM3JB?=
 =?utf-8?B?OHpMSDUwV3N1c3ZOYkRhY0pWR3FOa28rN2FUcEszRFRpcTg1NktPN0pxamlw?=
 =?utf-8?B?TnJwU2VnZStqMk1nU1pnUjNFSkZOK3Jsc0d2WU1xdUR1Rmw4dmk2OERDTHlj?=
 =?utf-8?B?RXVtZkRRbmlsRHY1SytKd1hacHY3M0pFbXhMdXVQUVYvMU1uRWdVQzNVUlQr?=
 =?utf-8?B?U1hGQmpCcUtEckg2UnFsVGE1ZjNkNHlFNkpMc1NCeHh2OHJtWjgxNkdvQ09j?=
 =?utf-8?B?REZOWTZxZERscnR3S21Yd2VXM2t5bzk0Sm1nbHBUMG41L3gvcDl0QmJuRnEv?=
 =?utf-8?B?dVJ0d2xveGl0dEVWZnQ3a3gvSjh4NUtsQm1wY1h0cDRGQVJtcHZUY3BuallV?=
 =?utf-8?B?Y2ltV2JiTGp4ZFFDbzRtNzRUZHlLajNaVmRqbDU2b1dPWG5kSURZUUJiUno1?=
 =?utf-8?B?dC9jcmZubXFLbGlJajV1MlJBVitJOUlQaTZScHRsR0hsWjdiL0Y5NmxkQjA0?=
 =?utf-8?B?M3VQQWlkd0dRdzZRalBENUZ0ektNZjhCUTFHOEt5RVhvd0IyMG5JUGNoNFQ3?=
 =?utf-8?B?L2J6bHJvQ0w4QzVNSUd3NkJQOEZMNVpSNnQzWDNJOGNqZ0FkQUVmQklQZkEz?=
 =?utf-8?B?RWtHWkdIUnk0Y1FuRzJVNDhyZEQxaE04dDBWWVhLS012NFdzZU5GaFBvb2dV?=
 =?utf-8?B?NjUwaVBGU0J0eE5OMU1uZmhtYnB6dFV6VFpIbzJBTE41c1lPWHE1d1J5Nkc2?=
 =?utf-8?B?OXYwekMyTjgydTAzTHo2SHNFcldmU2pUbEhiUkNFRUpKSVpvS25Kd0FFb2dj?=
 =?utf-8?B?T1hjR1grN05RdHhMYklVU3VJWWE0aFMvSkZ1K2gwcjZWOCtSQmpldDhUOCsz?=
 =?utf-8?B?RWFZdGx1TldCc1g2cXZMWGtKMUk1R1lLQUlScC81bU9KMTR0bmhYajNwRW5v?=
 =?utf-8?B?L3hpQ00zalRyN1F5WThERktlSlFjTnpsVW1NOEV6SlNCTXMybktPcGxUckZZ?=
 =?utf-8?B?TlVaM29NYVFJb2JkR3ljT1VuM0lOd1hRbEFDZzduTlZHeHh0TWZIR1RYdzF2?=
 =?utf-8?B?WE9UWG84amFHSU02OXplZmpXbFdTcFRXY1lBSFRtNHpHRDVxU2N1QmRkaTJp?=
 =?utf-8?B?U29tZFRMS20zRy9LUjdLL1Bvc2t0cG1mR285VjNNblA3S3A0MGl3cUhZVEFt?=
 =?utf-8?B?RE53ai8za2NVTG9EZHBVcWRNY2RubXVqY2ZycnI3WVNqek1iMnlPODJQT2dH?=
 =?utf-8?B?YzZBNGlYQzJyeXUzWVg5SnJ1K3dmSWhPUUJXSTlCcmJFb1d5d084WGw0WUhQ?=
 =?utf-8?B?VVlLUUNLc2tNK2VHVnU1M2o0STRtUmEwLzM5b3pKYm9KMnNCZzh2VzcwUVJK?=
 =?utf-8?B?U3lPUmpseHJZbnUzWG5ZQWFoOVhQTG1kcVBUYVdkVUE2UkFmWDNPL2o5NlFz?=
 =?utf-8?B?OVRSNzVyYVNGZXd2c3Fsb1k1M0ZwZ0Q1UFBVeTFnMXNwZ0FkNlloOEY1enIr?=
 =?utf-8?B?aGxPUThsclEyNjlPM29EVmdVa3VMZCtRR3c3MnB4eHgyc2hxLytsMTZIcWN3?=
 =?utf-8?B?azU1WUh0OVgzN09IYWZad0tRa201emFMM0gxSWFvRWZYdHZyWVJrT1J6SG0v?=
 =?utf-8?B?RmRXbFVmZTJOWTZHVUZxN0wxZ2hNcGxwRVAzRDJjSnZETUtwV2lQTkYxZ3Ri?=
 =?utf-8?B?NWlEcWpHZVVoVk5EcjhJVXlWZ2xTWXIrU0Q2MTk2cnNkZHpXRUh4amVhaEFj?=
 =?utf-8?B?dVgvSVpVYURSdEtGdlVYME5pS2pEQTRuMTdNV0MxVlhrUjRqZFM1M1NWd1ZM?=
 =?utf-8?B?MlkvZkIybzFsMzBJeHFkNTNtOVJaeVZxQ3ZQUDljOXFrK2QxaDdmVkI4LzFJ?=
 =?utf-8?B?SlFrczJjb0FKRXJ3bHRrc2U3Y2ptTHlRQ2VXZzJBS3A4aW9SSGpKam4yWnNZ?=
 =?utf-8?B?UjQwZTgyWklxQmxMcFR3NzFXQW1GVURyOXpNRGhLY2ZrNlpQbkcybWtxYXZP?=
 =?utf-8?B?NW5aL2hTNWtnPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9136.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(1800799024)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Wk9BMEUvbmNYWXljLzRIN0MyTXVrdmgrOXZPS3Y5dTVzK0VBdmV3UEY4MVNI?=
 =?utf-8?B?MmFGbTNKZ1FZM3ZyUDkrQ2trcHlVaVhFV2dCd0xyT3N5dDc0b1o0RUhzKzlZ?=
 =?utf-8?B?YUNwa1g3dGJaY0c2VjJXTUtpSDJVMTVIQ1h4WDV0c1FacGphaGJ5bHRtSXFv?=
 =?utf-8?B?THZEQ09EL2o5UlNXcUE2T2N1YnVic054S215UDAyM2VDZDRCVlVHZVF1Sktx?=
 =?utf-8?B?d0xCOXM2Ti81dGVUZno2NXozc3VRMlN6NDEwTm9VNjc3R1BMUHl2WVVUbCtu?=
 =?utf-8?B?eXdkTFFyYmVSR0gzTzZZSDV6T0NMZHVUK09uN25MaWFoRXF5RmswWjRGb3VV?=
 =?utf-8?B?V1NwN1l4ZG1JNjJMRDZ0NFloWVlmRm1WdVd5RHhYUVo3eGdNeGpseXBPZzVU?=
 =?utf-8?B?My9TU3l0Z2U5NHlCUjk2d09scjVHd3RYL1gyQzcxd29IZWlNOXhHUjg1WDFZ?=
 =?utf-8?B?emhQeUc5UXl5MWVrK011b3RDQ2xvWlFrcVZ6TDJOVVpQb1BjcG5wbVBHTXZO?=
 =?utf-8?B?WmtKSlc1b1lDNysxN1JKaDZEV0lSS0cwQVNZRUNnc09XWWdpNnM3V1BVZ0Rw?=
 =?utf-8?B?dUNESkxtV3VVdnVFOG1SaXNHWTAxQ2g2Y2x4RHlPUjJyRHMreTAwOGl4TXpQ?=
 =?utf-8?B?VnNXajB6SDlmTHV2NmhjanB6QWtMdS8wZjJZODZPQ1lHWFU2MEtEekh5YnNi?=
 =?utf-8?B?ZWhpK0x1U1BYMXV1S0JiVVlwNHNoc2EzazRNUjNwTzdhdDJSQkppZElPbVBH?=
 =?utf-8?B?Tk53U0hQS3BjWnZibDlyTS90bk9yenlWRDkyVjV1M3E4eHEzYzYweEVRRmtk?=
 =?utf-8?B?ejh2SlBiOG5tVGt5U296aXViUXNpbDdPb2FERE9Qb21ackViRTRaRWVENXky?=
 =?utf-8?B?N2NObFc3MXVYb3dobWx1M1A1ZDZ3OE5yTGxSbHRZZkV0UnUwM2l5a3BES1g1?=
 =?utf-8?B?WkRhNDNzR2pRV2dQZVJNOExwYUJHZkxCM0VOYXVKa0g1LzVGQnE3WUpwTUk2?=
 =?utf-8?B?WkJuNFY1ZUV6cXN1TllidGR6VFAwSEFHSEovZEhPTnQ4QzAvRkdzbElmY3pq?=
 =?utf-8?B?M09uVGVNWlNrYkpEckkwaVprL0lLdnl5UXgrM2lFVFhka1NyUElvNURzNTVC?=
 =?utf-8?B?OEdWVzZnWGVURGU2RWFwbDFGOFhyWU91eXVKcGdhOS82bjNTMmJrNSt5V1cx?=
 =?utf-8?B?alI3anU1UmJHamx6elBhY0krb3k0K1Y1dGRvK25OdnVrRXZ0bGNlYmFoMDdB?=
 =?utf-8?B?TXZqWXQ5NGoyQU9TSHh4MWd3cEo4Rm5IQ2FXcHZlaW4rYk51U0lxUXNBdHlH?=
 =?utf-8?B?cmVOTjQyRFRpVlJuRlI2UnRKZVRzMTVLTVlMMjI0cDQwaGdxd3R1eXdvWEs0?=
 =?utf-8?B?Nktub3o1YVhkZytuTTI1Tk9zSnZ2UTgwTmp5dWVLTkJjVWsxaEF4dEs5cUZ1?=
 =?utf-8?B?QktuenprNDZwUXFJQVNNWCtGbm5PODg4bC9OYit3MXJzdTZEU2JPWC9mTXNu?=
 =?utf-8?B?YUtwWksyaHpOVmxTVHgyQVFzUm9ienl6SHVMNkNFSjV2NGNta0NrOHVDMUlE?=
 =?utf-8?B?ZmhJYnVyL3FVQXByeGdmS211NU82NWFhWDhpemZuMjRnVHJUaFhDQ3pDUUpZ?=
 =?utf-8?B?MFZ3dmd2ZTNLRG5nTEx2UEVQdThjay95MTd5VlFZQXE1d2o0TSsyRzlINUhV?=
 =?utf-8?B?ZDNwbHJoMHl0bko3ZmszaDYrVnBGSlJMbUgzdWtYQkFhTnc5WUFUNllYK2N1?=
 =?utf-8?B?d2l2MHlwQXNtUkkvUEk3aEFsM2tRZ1p4YldsRHdZaUpPZllXUllzajJkTWNK?=
 =?utf-8?B?SUVkRisyNGdRMmZXcURKK1k0eUZOT2trN0VjR1NzbjluNllvRElrTWdGUCtO?=
 =?utf-8?B?eXhEMWhUOE9qRjZZRXJYakRNUXVJUGJVVzBHbzVnNFVXMC9nRjNrUXJwa250?=
 =?utf-8?B?Q1FrNFN3SkhhM3N1Z2xkVEUzSlNlN0lTZzZ2STN3emhKcmpHSmRoVDk4c0VX?=
 =?utf-8?B?SFY5WFJXY3Z1OVM0cjVSTHgzVVY0dTRHRFUrWG1PMVdxSXV4UE9YcjhsYXZH?=
 =?utf-8?B?OGs4UFo0empRaTRBSXlxd0hNN1JtY3ZRazZxY2lQc2YxV2RQYW4vSEU5SnMv?=
 =?utf-8?Q?ytiyreqextSzOl2vqx90QKNZE?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9136.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 440f924b-1d5f-469b-cba1-08ddc500175f
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2025 07:03:53.9254 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XlSxpeY/HWIllKgV0ziC6s0COau8ZhFCwEmLhPZhurl3ZYLUSAMzxThMwWoMs5UgVynvYbk7fyImKuJQ5nxdpXMajkrqp/Ii3zI+aBdD6Qg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5288
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.15;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

SGkgRXJpYywNCg0KPi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+RnJvbTogRXJpYyBBdWdl
ciA8ZXJpYy5hdWdlckByZWRoYXQuY29tPg0KPlN1YmplY3Q6IFJlOiBbUEFUQ0ggdjMgMDcvMjBd
IGludGVsX2lvbW11OiBDaGVjayBmb3IgY29tcGF0aWJpbGl0eSB3aXRoDQo+SU9NTVVGRCBiYWNr
ZWQgZGV2aWNlIHdoZW4geC1mbHRzPW9uDQo+DQo+SGkgWmhlbnpob25nLA0KPg0KPk9uIDcvMTcv
MjUgNTo0NyBBTSwgRHVhbiwgWmhlbnpob25nIHdyb3RlOg0KPj4gSGkgRXJpYywNCj4+DQo+Pj4g
LS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4+PiBGcm9tOiBFcmljIEF1Z2VyIDxlcmljLmF1
Z2VyQHJlZGhhdC5jb20+DQo+Pj4gU2VudDogV2VkbmVzZGF5LCBKdWx5IDE2LCAyMDI1IDg6MDkg
UE0NCj4+PiBUbzogRHVhbiwgWmhlbnpob25nIDx6aGVuemhvbmcuZHVhbkBpbnRlbC5jb20+Ow0K
Pj4+IHFlbXUtZGV2ZWxAbm9uZ251Lm9yZw0KPj4+IENjOiBhbGV4LndpbGxpYW1zb25AcmVkaGF0
LmNvbTsgY2xnQHJlZGhhdC5jb207IG1zdEByZWRoYXQuY29tOw0KPj4+IGphc293YW5nQHJlZGhh
dC5jb207IHBldGVyeEByZWRoYXQuY29tOyBkZHV0aWxlQHJlZGhhdC5jb207DQo+Pj4gamdnQG52
aWRpYS5jb207IG5pY29saW5jQG52aWRpYS5jb207DQo+Pj4gc2hhbWVlcmFsaS5rb2xvdGh1bS50
aG9kaUBodWF3ZWkuY29tOyBqb2FvLm0ubWFydGluc0BvcmFjbGUuY29tOw0KPj4+IGNsZW1lbnQu
bWF0aGlldS0tZHJpZkBldmlkZW4uY29tOyBUaWFuLCBLZXZpbiA8a2V2aW4udGlhbkBpbnRlbC5j
b20+Ow0KPkxpdSwNCj4+PiBZaSBMIDx5aS5sLmxpdUBpbnRlbC5jb20+OyBQZW5nLCBDaGFvIFAg
PGNoYW8ucC5wZW5nQGludGVsLmNvbT4NCj4+PiBTdWJqZWN0OiBSZTogW1BBVENIIHYzIDA3LzIw
XSBpbnRlbF9pb21tdTogQ2hlY2sgZm9yIGNvbXBhdGliaWxpdHkgd2l0aA0KPj4+IElPTU1VRkQg
YmFja2VkIGRldmljZSB3aGVuIHgtZmx0cz1vbg0KPj4+DQo+Pj4gSGkgWmhlbnpob25nLA0KPj4+
DQo+Pj4gT24gNy8xNi8yNSAxMjozMSBQTSwgRHVhbiwgWmhlbnpob25nIHdyb3RlOg0KPj4+PiBI
aSBFcmljLA0KPj4+Pg0KPj4+Pj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4+Pj4+IEZy
b206IEVyaWMgQXVnZXIgPGVyaWMuYXVnZXJAcmVkaGF0LmNvbT4NCj4+Pj4+IFN1YmplY3Q6IFJl
OiBbUEFUQ0ggdjMgMDcvMjBdIGludGVsX2lvbW11OiBDaGVjayBmb3IgY29tcGF0aWJpbGl0eSB3
aXRoDQo+Pj4+PiBJT01NVUZEIGJhY2tlZCBkZXZpY2Ugd2hlbiB4LWZsdHM9b24NCj4+Pj4+DQo+
Pj4+PiBIaSBaaGVuemhvbmcsDQo+Pj4+Pg0KPj4+Pj4gT24gNy84LzI1IDE6MDUgUE0sIFpoZW56
aG9uZyBEdWFuIHdyb3RlOg0KPj4+Pj4+IFdoZW4gdklPTU1VIGlzIGNvbmZpZ3VyZWQgeC1mbHRz
PW9uIGluIHNjYWxhYmxlIG1vZGUsIHN0YWdlLTEgcGFnZQ0KPj4+IHRhYmxlDQo+Pj4+Pj4gaXMg
cGFzc2VkIHRvIGhvc3QgdG8gY29uc3RydWN0IG5lc3RlZCBwYWdlIHRhYmxlLiBXZSBuZWVkIHRv
IGNoZWNrDQo+Pj4+Pj4gY29tcGF0aWJpbGl0eSBvZiBzb21lIGNyaXRpY2FsIElPTU1VIGNhcGFi
aWxpdGllcyBiZXR3ZWVuIHZJT01NVQ0KPmFuZA0KPj4+Pj4+IGhvc3QgSU9NTVUgdG8gZW5zdXJl
IGd1ZXN0IHN0YWdlLTEgcGFnZSB0YWJsZSBjb3VsZCBiZSB1c2VkIGJ5IGhvc3QuDQo+Pj4+Pj4N
Cj4+Pj4+PiBGb3IgaW5zdGFuY2UsIHZJT01NVSBzdXBwb3J0cyBzdGFnZS0xIDFHQiBodWdlIHBh
Z2UgbWFwcGluZywgYnV0DQo+Pj4gaG9zdA0KPj4+Pj4+IGRvZXMgbm90LCB0aGVuIHRoaXMgSU9N
TVVGRCBiYWNrZWQgZGV2aWNlIHNob3VsZCBmYWlsLg0KPj4+Pj4+DQo+Pj4+Pj4gRXZlbiBvZiB0
aGUgY2hlY2tzIHBhc3MsIGZvciBub3cgd2Ugd2lsbGluZ2x5IHJlamVjdCB0aGUgYXNzb2NpYXRp
b24NCj4+Pj4+PiBiZWNhdXNlIGFsbCB0aGUgYml0cyBhcmUgbm90IHRoZXJlIHlldC4NCj4+Pj4+
Pg0KPj4+Pj4+IFNpZ25lZC1vZmYtYnk6IFlpIExpdSA8eWkubC5saXVAaW50ZWwuY29tPg0KPj4+
Pj4+IFNpZ25lZC1vZmYtYnk6IFpoZW56aG9uZyBEdWFuIDx6aGVuemhvbmcuZHVhbkBpbnRlbC5j
b20+DQo+Pj4+Pj4gLS0tDQo+Pj4+Pj4gIGh3L2kzODYvaW50ZWxfaW9tbXUuYyAgICAgICAgICB8
IDMwDQo+Pj4+PiArKysrKysrKysrKysrKysrKysrKysrKysrKysrKy0NCj4+Pj4+PiAgaHcvaTM4
Ni9pbnRlbF9pb21tdV9pbnRlcm5hbC5oIHwgIDEgKw0KPj4+Pj4+ICAyIGZpbGVzIGNoYW5nZWQs
IDMwIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4+Pj4+Pg0KPj4+Pj4+IGRpZmYgLS1n
aXQgYS9ody9pMzg2L2ludGVsX2lvbW11LmMgYi9ody9pMzg2L2ludGVsX2lvbW11LmMNCj4+Pj4+
PiBpbmRleCBlOTBmZDJmMjhmLi5jNTdjYTAyY2RkIDEwMDY0NA0KPj4+Pj4+IC0tLSBhL2h3L2kz
ODYvaW50ZWxfaW9tbXUuYw0KPj4+Pj4+ICsrKyBiL2h3L2kzODYvaW50ZWxfaW9tbXUuYw0KPj4+
Pj4+IEBAIC00MCw2ICs0MCw3IEBADQo+Pj4+Pj4gICNpbmNsdWRlICJrdm0va3ZtX2kzODYuaCIN
Cj4+Pj4+PiAgI2luY2x1ZGUgIm1pZ3JhdGlvbi92bXN0YXRlLmgiDQo+Pj4+Pj4gICNpbmNsdWRl
ICJ0cmFjZS5oIg0KPj4+Pj4+ICsjaW5jbHVkZSAic3lzdGVtL2lvbW11ZmQuaCINCj4+Pj4+Pg0K
Pj4+Pj4+ICAvKiBjb250ZXh0IGVudHJ5IG9wZXJhdGlvbnMgKi8NCj4+Pj4+PiAgI2RlZmluZSBW
VERfQ0VfR0VUX1JJRDJQQVNJRChjZSkgXA0KPj4+Pj4+IEBAIC00MzU1LDcgKzQzNTYsMzQgQEAg
c3RhdGljIGJvb2wNCj52dGRfY2hlY2tfaGlvZChJbnRlbElPTU1VU3RhdGUNCj4+PiAqcywNCj4+
Pj4+IEhvc3RJT01NVURldmljZSAqaGlvZCwNCj4+Pj4+PiAgICAgICAgICByZXR1cm4gdHJ1ZTsN
Cj4+Pj4+PiAgICAgIH0NCj4+Pj4+Pg0KPj4+Pj4+IC0gICAgZXJyb3Jfc2V0ZyhlcnJwLCAiaG9z
dCBkZXZpY2UgaXMgdW5jb21wYXRpYmxlIHdpdGggc3RhZ2UtMQ0KPj4+Pj4gdHJhbnNsYXRpb24i
KTsNCj4+Pj4+PiArI2lmZGVmIENPTkZJR19JT01NVUZEDQo+Pj4+Pj4gKyAgICBzdHJ1Y3QgSG9z
dElPTU1VRGV2aWNlQ2FwcyAqY2FwcyA9ICZoaW9kLT5jYXBzOw0KPj4+Pj4+ICsgICAgc3RydWN0
IGlvbW11X2h3X2luZm9fdnRkICp2dGQgPSAmY2Fwcy0+dmVuZG9yX2NhcHMudnRkOw0KPj4+Pj4g
SSBhbSBub3cgY29uZnVzZWQgYWJvdXQgaG93IHRoaXMgcmVsYXRlcyB0byB2dGRfZ2V0X3Zpb21t
dV9jYXAoKS4NCj4+Pj4+IFBDSUlPTU1VT3BzLnNldF9pb21tdV9kZXZpY2UgPSB2dGRfZGV2X3Nl
dF9pb21tdV9kZXZpY2UgY2FsbHMNCj4+Pj4+IHZ0ZF9jaGVja19oaW9kKCkNCj4+Pj4+IHZpb21t
dSBtaWdodCByZXR1cm4gSFdfTkVTVEVEX0NBUCB0aHJvdWdoDQo+Pj4+PiBQQ0lJT01NVU9wcy5n
ZXRfdmlvbW11X2NhcA0KPj4+Pj4gd2l0aG91dCBtYWtpbmcgc3VyZSB0aGUgdW5kZXJseWluZyBI
VyBJT01NVSBkb2VzIHN1cHBvcnQgaXQuIElzIHRoYXQNCj5hDQo+Pj4+PiBjb3JyZWN0IHVuZGVy
c3RhbmRpbmc/IE1heWJlIHdlIHNob3VsZCBjbGFyaWZ5IHRoZSBjYWxsaW5nIG9yZGVyDQo+YmV0
d2Vlbg0KPj4+Pj4gc2V0X2lvbW11X2RldmljZSB2cyBnZXRfdmlvbW11X2NhcD8gQ291bGQgd2Ug
Y2hlY2sgSFcgSU9NTVUNCj4+Pj4+IHByZXJlcXVpc2l0ZXMgaW4gdnRkX2dldF92aW9tbXVfY2Fw
KCkgYnkgZW5mb3JjaW5nIHRoaXMgaXMgY2FsbGVkIGFmdGVyDQo+Pj4+PiBzZXRfaW9tbXVfZGV2
aWNlLiBJIHRoaW5rIHdlIHNob3VsZCBjbGFyaWZ5IHRoZSBleGFjdCBzZW1hbnRpYyBvZg0KPj4+
Pj4gZ2V0X3Zpb21tdV9jYXAoKS5UaGFua3MgRXJpYw0KPj4+PiBNeSB1bmRlcnN0YW5kaW5nIGdl
dF92aW9tbXVfY2FwKCkgcmV0dXJucyBwdXJlIHZJT01NVSdzIGNhcGFiaWxpdGllcw0KPj4+PiB3
aXRoIG5vIGhvc3QgSU9NTVUncyBjYXBhYmlsaXRpZXMgaW52b2x2ZWQuDQo+Pj4+DQo+Pj4+IEZv
ciBleGFtcGxlLCByZXR1cm5lZCBIV19ORVNURURfQ0FQIG1lYW5zIHRoaXMgdklPTU1VIGhhcyBj
b2RlDQo+Pj4+IHRvIHN1cHBvcnQgY3JlYXRpbmcgbmVzdGVkIGh3cHQgYW5kIGF0dGFjaGluZywg
bm8gbWF0dGVyIGlmIGhvc3QgSU9NTVUNCj4+Pj4gc3VwcG9ydHMgbmVzdGluZyBvciBub3QuDQo+
Pj4gVGhlbiBJIHRoaW5rIHlvdSBuZWVkIHRvIHJlZmluZSB0aGUgZGVzY3JpcHRpb24gaW4gMi8y
MCB0byBtYWtlIHRoaXMgY2xlYXIuDQo+Pj4gc3RhdGluZyBleHBsaWNpdGx5IGdldF92aW9tbXVf
Y2FwIHJldHVybnMgdGhlb3JldGljYWwgY2FwYWJpbGl0aWVzIHdoaWNoDQo+Pj4gYXJlIGluZGVw
ZW5kZW50IG9uIHRoZSBhY3R1YWwgaG9zdCBjYXBhYmlsaXRpZXMgdGhleSBtYXkgZGVwZW5kIG9u
Lg0KPj4gV2lsbCBkby4NCj4+DQo+PiBGb3IgdmlydHVhbCB2dGQsIHdlIGFyZSB1bmFibGUgdG8g
cmV0dXJuIGNhcGFiaWxpdGllcyBkZXBlbmRpbmcgb24gaG9zdA0KPmNhcGFjaXRpZXMsDQo+PiBC
ZWNhdXNlIGRpZmZlcmVudCBob3N0IElPTU1VIG1heSBoYXZlIGRpZmZlcmVudCBjYXBhYmlsaXRp
ZXMsIHdlIHdhbnQgdG8NCj5yZXR1cm4NCj4+IGEgY29uc2lzdGVudCByZXN1bHQgb25seSBkZXBl
bmRpbmcgb24gdXNlcidzIGNtZGxpbmUgY29uZmlnLg0KPm9rDQo+Pg0KPj4+PiBUaGUgY29tcGF0
aWJpbGl0eSBjaGVjayBiZXR3ZWVuIGhvc3QgSU9NTVUgdnMgdklPTU1VIGlzIGRvbmUgaW4NCj4+
Pj4gc2V0X2lvbW11X2RldmljZSgpLCBzZWUgdnRkX2NoZWNrX2hpb2QoKS4NCj4+Pj4NCj4+Pj4g
SXQncyB0b28gbGF0ZSBmb3IgVkZJTyB0byBjYWxsIGdldF92aW9tbXVfY2FwKCkgYWZ0ZXIgc2V0
X2lvbW11X2RldmljZSgpDQo+Pj4+IGJlY2F1c2Ugd2UgbmVlZCBnZXRfdmlvbW11X2NhcCgpIHRv
IGRldGVybWluZSBpZiBjcmVhdGluZyBuZXN0ZWQNCj5wYXJlbnQNCj4+Pj4gaHdwdCBvciBub3Qg
YXQgYXR0YWNoaW5nIHN0YWdlLg0KPj4+IGlzbid0IGl0IHBvc3NpYmxlIHRvIHJld29yayB0aGUg
Y2FsbCBzZXF1ZW5jZT8NCj4+IEkgdGhpbmsgbm90LiBDdXJyZW50IHNlcXVlbmNlOg0KPj4NCj4+
IGF0dGFjaF9kZXZpY2UoKQ0KPj4gICAgIGdldF92aW9tbXVfY2FwKCkNCj4+ICAgICBjcmVhdGUg
aHdwdA0KPj4gLi4uDQo+PiBjcmVhdGUgaGlvZA0KPj4gc2V0X2lvbW11X2RldmljZShoaW9kKQ0K
Pj4NCj4+IEhpb2QgcmVhbGl6ZSBuZWVkcyBpb21tdWZkLGRldmlkIGFuZCBod3B0X2lkIHdoaWNo
IGFyZSByZWFkeSBhZnRlcg0KPmF0dGFjaF9kZXZpY2UoKS4NCj5PSy4gSSB3b3VsZCBhZGQgdGhp
cyBleHBsYW5hdGlvbiBpbiB0aGUgY29tbWl0IG1zZyB0b28uDQoNCkdvdCBpdCwgd2lsbCBkby4N
Cg0KVGhhbmtzDQpaaGVuemhvbmcNCg==

