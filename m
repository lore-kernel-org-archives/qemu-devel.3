Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AA5CC25B74
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2024 13:26:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCfmi-0002xx-5d; Thu, 30 May 2024 09:25:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yuan1.liu@intel.com>)
 id 1sCfmX-0002eC-91
 for qemu-devel@nongnu.org; Thu, 30 May 2024 09:25:27 -0400
Received: from mgamail.intel.com ([198.175.65.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yuan1.liu@intel.com>)
 id 1sCfmT-0000fw-J7
 for qemu-devel@nongnu.org; Thu, 30 May 2024 09:25:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1717075522; x=1748611522;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=geBcsWiOS6o1D4KkUZulTzb1vGlT7K16ivZ5STAnyQo=;
 b=DjXIYgN1z19OWXnbamMffaIDC7rus+SOHCkyc5koR3EFQHH/iRFJfC/g
 ucs5/y8y9ZbAZk2N/OI2v/e4CSVr+NOnHMmz4qHS8cZsvp93Zi7oFqwk5
 h+LMXVA4dhqdbkk+ruvVgjfJXJOe8xqQHux/Z0x4qx/MGlTHOyem5DBpn
 3DGcrzZF63Pu3KcSvH3lUhbi9/Hc2RNRBZ994hCfRMRbBFLkCb5m/QMp7
 LFTEN4vOPvScZ7zATjdEyyFdK4EFQ55UOLKrJrnfG+uvWZyCixGpHwVpS
 LADSFLOBHe3un0xhrKuh32De1wb80hwhMLyX1Mtl+L0lQdtL12IXfJclL g==;
X-CSE-ConnectionGUID: 6EYcl/9XSJmXsFHKtZ84tw==
X-CSE-MsgGUID: x7anfC83SjmjnCjNTeGpRw==
X-IronPort-AV: E=McAfee;i="6600,9927,11088"; a="24112760"
X-IronPort-AV: E=Sophos;i="6.08,201,1712646000"; d="scan'208";a="24112760"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 May 2024 06:25:17 -0700
X-CSE-ConnectionGUID: BySK0fRDQmqynATnsr9PrQ==
X-CSE-MsgGUID: V4AMr+8lQNqAXfmg7F5jKw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,201,1712646000"; d="scan'208";a="36293490"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
 by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 30 May 2024 06:25:17 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 30 May 2024 06:25:16 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 30 May 2024 06:25:16 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 30 May 2024 06:25:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=itBjcQ/yeAUfhRRuuHDlfp4WnkpEzc/L0/lvUxWantYYStAgG3NdXIrXh39uGY9ruiFdx8b/1VSOHiW+x8weM4GjFDH53NZM0uMU97iKs7KMUxDiMjj+bTHfndFnzg1b/ftu4mBBcv34MthSFjHO8/P2fSGBiKpldwHdPWQchkOVzrPR8lndzPwivKojBdqkTHdPUD9iXx6WrNyDfJzcUi492weqy0NNLPvO61QBo7JkHeZhKclB45ta2ANppckUe4UQFR7+GIa0gjkfpAdoszneU6j/uKvUB9yi/IB3cX2+glszTrxA2MHzOSp3jdPCMqSPmY5xZkLVgAulu7ulFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=geBcsWiOS6o1D4KkUZulTzb1vGlT7K16ivZ5STAnyQo=;
 b=Z/0kwB20qPgxOAqwrXBMZ7QC7h4/LGiYF1adMVM/YOZEpSrnwpgBhE+3Tr+l0I9Ix93VXj1vWgYV4W69j7k91IOrTz4qlbWlmWU6autTYPMt4QycKk+uHpBoN2XIU/uUfFR1JCjkJOTTny9TNuJBF/doZITrxBWvvDEt0D3UrShlt0aPXepqIeOJP4JKOFuOUcJRzbDnT4ESq6gKPVU/XMZ0+GDDsEa63fNp3wII/wHr0oqQOO+W24dWX2E4Y99BX1ikR++EmSoA0N/hagZoumkKIiJBB4+GDnpLn9EoBOYqbE7mneyEu/09grPoim7Li0msJqlMyIKY8QDv5eZ4qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB5941.namprd11.prod.outlook.com (2603:10b6:510:13d::20)
 by SA2PR11MB5082.namprd11.prod.outlook.com (2603:10b6:806:115::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.22; Thu, 30 May
 2024 13:25:14 +0000
Received: from PH7PR11MB5941.namprd11.prod.outlook.com
 ([fe80::2750:7e63:952:7f1d]) by PH7PR11MB5941.namprd11.prod.outlook.com
 ([fe80::2750:7e63:952:7f1d%6]) with mapi id 15.20.7633.018; Thu, 30 May 2024
 13:25:13 +0000
From: "Liu, Yuan1" <yuan1.liu@intel.com>
To: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
 "peterx@redhat.com" <peterx@redhat.com>, "farosas@suse.de" <farosas@suse.de>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "linuxarm@huawei.com"
 <linuxarm@huawei.com>, "linwenkai6@hisilicon.com" <linwenkai6@hisilicon.com>, 
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>,
 "huangchenghai2@huawei.com" <huangchenghai2@huawei.com>
Subject: RE: [PATCH 1/7] docs/migration: add uadk compression feature
Thread-Topic: [PATCH 1/7] docs/migration: add uadk compression feature
Thread-Index: AQHasaz8E0yBf65W/0WETt9KQ8yyZLGvvhFA
Date: Thu, 30 May 2024 13:25:13 +0000
Message-ID: <PH7PR11MB59417BE6DD3AE194C24E8367A3F32@PH7PR11MB5941.namprd11.prod.outlook.com>
References: <20240529094435.11140-1-shameerali.kolothum.thodi@huawei.com>
 <20240529094435.11140-2-shameerali.kolothum.thodi@huawei.com>
In-Reply-To: <20240529094435.11140-2-shameerali.kolothum.thodi@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB5941:EE_|SA2PR11MB5082:EE_
x-ms-office365-filtering-correlation-id: 9b77891f-c23b-4e00-d716-08dc80abf000
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|366007|1800799015|376005|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?TGZIeDNIMThrU3ZObElwL0xlQmFvdk9kQ3J3UDA5ZEwzb0tBQTFlbzM3dTJv?=
 =?utf-8?B?ZzRleEl6SkQyY1dNSUhiRWY3emtmVTNRZDZtbHFCVjZSOVdRU2pDcFQvSjlT?=
 =?utf-8?B?SEF3ZlpwY2hvQkliaUZKalJJNEZPRDZxZEJJU2tOT0NMS3JrVFNrK3J1RmhF?=
 =?utf-8?B?Y1BsUXVnT091YzludDdXNWM2WVFaUmQvYnFJVFNxbjZQWXRLTFpkZGRocU5I?=
 =?utf-8?B?c0ZkN09wWFRRK2RsMGdiY002NzVzMDJWTkJkeDR0SncyTVVhd2xGb2RZZ0ZG?=
 =?utf-8?B?ZWprSkZqWUY5MHp4Vm5qZDRYekZhaStPOEdnYUU3dnhiVUFkbGI4ZS9PL0F1?=
 =?utf-8?B?M3AxRFdycHlSN2M5Q1AwTkpOZnZ1L3BPMHRoOGZXQWlPTUVWL3dTZ0dVU0VC?=
 =?utf-8?B?TnhQRzgxNi9YTTBBYXFpMVZZKzZuamoxS05yQ0FuU1NsNjVRNzN6NFdESXEx?=
 =?utf-8?B?QlBQTEtSZWhyaFlFVTNtRUpocjdFclIrVjJvMjMycktVNnhVUHFranMyYzl4?=
 =?utf-8?B?djQ2Tm5EYlNBdm96NjdURHdTeXQ3MlM3enhGQTNhWGhGNTZCTUpYTzByMGE2?=
 =?utf-8?B?cEltR21zL3lDSUNSd2xSUm96YXp5QTRBR2tISytvUHRKNTJreFBoNU51cEU3?=
 =?utf-8?B?cmNJTDVUSTNHN1luRXMxR3dleUZkdWI4eTBRYXNlRHRTNDBDeGF5bmlrK1lU?=
 =?utf-8?B?cDcwRS9QQXBwaTRmS0FoUG53RCt3LzBzTkFXZlMwR052RnlTc2d1K25GRDVx?=
 =?utf-8?B?enpiTUpsdHpTeEJSNmRaSlU1cndvYjBOQWw5cVZjQm1NMms3UHBsRklBQUVl?=
 =?utf-8?B?OUxzSmx5QXJseU10bzBlcnB3eGNzcWtkSmJMdmQyNjhyQ0dMZDc3SC9kQzJM?=
 =?utf-8?B?bVlabTdScHhKTDM2d1Z5QjcrZ0c4MlNNaEUyaEIra1JRZG5DVjBGY3pUVDh1?=
 =?utf-8?B?c3ViV0V3TTlVOEpxYVdKMk04ZDIvZ0h4YlQvL3lhMXFBZXlQT2lBS2hGVUxU?=
 =?utf-8?B?L1BGaFVMSHNOK3ZpOFJVR3J1Yk5IVU44ZUM3UHRlV2trQmQ5VUZsNC92TDZL?=
 =?utf-8?B?OFkrVHlOaFcrZWV3YnF1TGhjZW01WTBtRzdjR3FmY2NUMkVwYXk3WFYxV3lt?=
 =?utf-8?B?NEtMNVBNMmZvbEM4ZWtmbDMxa1VWQWZwN3BkVVJ3RW1OWUJYLzN3ZjNWaHhO?=
 =?utf-8?B?WUswb0VhSWhSY05udXgvaUU4UmFsWmVsWnpOS0YvbHEvMW9reVdDa25SeGZs?=
 =?utf-8?B?TGtYYk16a0tidnIrNWtucWZHNS8zWUN6UVZLdDdTYkZ1UVhjNytjQVBhaXVh?=
 =?utf-8?B?dGlXL0tKZFE4bHdRcUs2bTA2cG5FcUdsTU9EeitDVUw1QmhWTjdZYnRobjV6?=
 =?utf-8?B?NzVHNTlHY05ZZllld2ZFUW54OXVSWm54bmRYWEs4TXdDalUyMjN2NSs5bnNj?=
 =?utf-8?B?UW1DS2xPWUZyYjdrYytLVGQzK1BqYjgvU0FuZVV1dlFUN09xeitwclFQK3JB?=
 =?utf-8?B?NWZoSkNCQStCSE9DdVlPMlZxUmtCcVoydGNoblQweVFCcmVEU09BZlBBRFFv?=
 =?utf-8?B?dzM5eUpjc0tvUDhxNDd5dnMxMWROOVpYd2t4RG5JZnI0d0x1UWd4ZVovWU9p?=
 =?utf-8?B?dTZuQ01XcFJFZExjbk5ydHNLdnJDUjMwd1pRN0pFb1ZFVEpGb1lEOGZVNHNY?=
 =?utf-8?B?cW5CbTlHaVlTSmd3dGdHblVTc2lyUlNCWURZRmxVWkd4WlVwVXJMcEplTWdJ?=
 =?utf-8?Q?iRynhZUxLRqqqTJy+Y=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR11MB5941.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(376005)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NHl1TXRTWWNpTnpaTjNpYlFybmM2VHc4S1BnOTdMQjl4ZDlSMDg5Kzd5OVc2?=
 =?utf-8?B?LzVPd1U2ZnZqcXlBS2JtRG1WS3VuNmZLd2E5ZkRmOXlpS1FybkFMODE5N2tj?=
 =?utf-8?B?YVRqRU14UTRZcW1yUWJNc3crTHZPKzNuY241clVaZFJ0SVl3L3ZxQjZ0NjNw?=
 =?utf-8?B?WlVObHEvV1g4NVg3NmVkWHg5cVR0bmhFTTM2aXBWdHdxcE05MVBVdit6aEky?=
 =?utf-8?B?Q1hnUWZMdXNiNmJlMUJ6TUVhM2NHY256V2FUK0ZiMHpYNWFHaHRJbG45WmhO?=
 =?utf-8?B?SXhxUFc5dTd0V2RwYmNqRTd0aXpqS1JPSWI5bWkzY0wxZnlZTEdmcWp5TFha?=
 =?utf-8?B?ZThSWnNET2U2T1EyNEI4MzRuWUx2MnJmb2c1bi9LM2p6K1NBMFFqeWM5UkFy?=
 =?utf-8?B?YVpoTmFVNEpnTng5cFQ4SVZRa2dmRmlaclBkTHIwMW5zN0Ewa3pyLzBpR1d5?=
 =?utf-8?B?Y2Z6c0tONGhCcTc4d0ZSMzk4WVpRK00zbTJoZ3cySmRaZXdtYmNBTlBCMFRK?=
 =?utf-8?B?UVRGMlRtZnFzdXZUMTd1MTFRT1IxTWhiWHRjQ3BUNE1kbUhOREhJMGROU2VX?=
 =?utf-8?B?dWd3S0xWM3I3R09JNkwyRU1LR1FDYlczbXY3U0hTaFljT3BkeDhLUnVGRUQ1?=
 =?utf-8?B?STJTRkhNSnc3TE51cldlVkgvRitJRmdLMlg1ZmtocUlOYjZwQ2ViMStEREJx?=
 =?utf-8?B?akFVbHEvZUl3eVNtaUlOaFFZaEFWYXlsSjhRZlVtSmZ6ejhLWmdOSkFWaFFB?=
 =?utf-8?B?L1VWTWU5ZUtaQWVTdDVDOWZ3OTQ2REMrMzAyU0llSnRZc1pVMXZ4M09QbUJv?=
 =?utf-8?B?WWtqRHgweXgxY0REMXliUlFiNU1nZE9MUFlXUnkzZHIvZ3VnVGFGQm56ZnJy?=
 =?utf-8?B?TkFUMXN6czl0R21qQzBJajhCYnFpd2s5ZW9ZZE81WmhBTUR6SGZ5VTU0THA3?=
 =?utf-8?B?R3NSa3ZjKzZxU1VVZ096aFV1WVJXUCtMZVJ6dXFSMWkxVHYrQi9TeUdXejF6?=
 =?utf-8?B?SWlKSnZ6V0l2c0FFQVZGUStWSjVlUnpHTXR4RTBJUXhMa1BQSjZvdjNZelp5?=
 =?utf-8?B?WXJGK1dJdTF6emxzSzFEdU9RQmFmQkUvWjRVTkVobklKYmQrUWFxVjYvMEpE?=
 =?utf-8?B?UmR4aGZ1MGo3ak5DTXdURUgyNEdkdW8zOFp1WitPajdPZWswNTBZVWM4Q2VW?=
 =?utf-8?B?aU9MS2NiRUFEZGxMSWtONTE5VVFMenVFdWFtT2hHdGYrWjlOdUZqaGlob0VX?=
 =?utf-8?B?REVYdkRTMVZUa0w0SzQvWVZPMVVqd2RjS1R6aStUQWswOHZpTHJWYWdqSFR0?=
 =?utf-8?B?VU8xb2pTS0RXZ2Q5UGhiVFJuT3A1b0dVWENYZEZhdU83MzZkb0N2VXZZTnZF?=
 =?utf-8?B?djM1Nm5KZ3hxaUM0VVBOclE2VXdBYmpsNjlJcmgxSUJ6cWppdVEybVFBSExo?=
 =?utf-8?B?UlF5UHNCWXMwWExLaWVhVExEYnpOYmpOWCsrOGwzSmtuWHRWaTVzM2h2KzQ0?=
 =?utf-8?B?bWZsa1FvK2krcU9LSW9acmxwOHlBQTd5dk1nSlplUDllU3V2YTdOa2lNT080?=
 =?utf-8?B?Z1d6V20zZi9EYWdRVVo4R0JNU2hpMmhsYVNoWFhNZDVaK1FVdmVLbkNkTWt3?=
 =?utf-8?B?NXpzL0NLVjdNcEpzQThiZFRiT1I2MmVTRWdZS3ozcURReVFlcklpeEQ1bnBG?=
 =?utf-8?B?RmlMc3p6a2srUUU3N2VRVld0cEoyNzV4Y3BkeUg5VXN1MW5ZeGF6SVd0d1Ju?=
 =?utf-8?B?ZzFpTDZQN0JRQWJpL2Y2YVNlcDRibXphMGFrUEdRcm5PT2NIT1g0K093ZlVO?=
 =?utf-8?B?WlN5d20wdVIxNjB1NkQzYTdud2NrekNDeFZJRm9FVEtNRXB3QVlpR3AvVTB3?=
 =?utf-8?B?YlVUYjBYcUN5aW96Z1c4RGlOYWp6ZTFteHBmWEw1N2ZRRnIzZUxTcTNIbUdV?=
 =?utf-8?B?NFZYTzdjQnVBakZ0NmR2KzdWbWVVc3o2Y29NdE9CYzFiVGJlRXlhVlVzeW5l?=
 =?utf-8?B?cllUSEdVQkI4T0RGK0ZVTDJ5V21BRnZpTThYMUc5ZlFRYnJOOTM4amV0Mkls?=
 =?utf-8?B?bDJCenVLVTU2Qi8vaEtzTkdrTGhtUW5hZlZXOElnV3RiaDVGK2tJY25JNVhm?=
 =?utf-8?Q?M+wSUanliTKlW6mxS3/5eNpDo?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5941.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b77891f-c23b-4e00-d716-08dc80abf000
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 May 2024 13:25:13.3653 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pwNupPScHSGY00PVYNQRMZTHnM1hj5G7siKq9KJK7n+0b+2DHi8JzaZYrj+KFfjq8ZvJY2r+LxzsmdpabX4ZFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5082
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.11; envelope-from=yuan1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.085,
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

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBTaGFtZWVyIEtvbG90aHVtIDxz
aGFtZWVyYWxpLmtvbG90aHVtLnRob2RpQGh1YXdlaS5jb20+DQo+IFNlbnQ6IFdlZG5lc2RheSwg
TWF5IDI5LCAyMDI0IDU6NDQgUE0NCj4gVG86IHBldGVyeEByZWRoYXQuY29tOyBmYXJvc2FzQHN1
c2UuZGU7IExpdSwgWXVhbjEgPHl1YW4xLmxpdUBpbnRlbC5jb20+DQo+IENjOiBxZW11LWRldmVs
QG5vbmdudS5vcmc7IGxpbnV4YXJtQGh1YXdlaS5jb207IGxpbndlbmthaTZAaGlzaWxpY29uLmNv
bTsNCj4gemhhbmdmZWkuZ2FvQGxpbmFyby5vcmc7IGh1YW5nY2hlbmdoYWkyQGh1YXdlaS5jb20N
Cj4gU3ViamVjdDogW1BBVENIIDEvN10gZG9jcy9taWdyYXRpb246IGFkZCB1YWRrIGNvbXByZXNz
aW9uIGZlYXR1cmUNCj4gDQo+IERvY3VtZW50IFVBREsoVXNlciBTcGFjZSBBY2NlbGVyYXRvciBE
ZXZlbG9wbWVudCBLaXQpIGxpYnJhcnkgZGV0YWlscw0KPiBhbmQgaG93IHRvIHVzZSB0aGF0IGZv
ciBtaWdyYXRpb24uDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBTaGFtZWVyIEtvbG90aHVtIDxzaGFt
ZWVyYWxpLmtvbG90aHVtLnRob2RpQGh1YXdlaS5jb20+DQo+IC0tLQ0KPiAgZG9jcy9kZXZlbC9t
aWdyYXRpb24vdWFkay1jb21wcmVzc2lvbi5yc3QgfCAxNDQgKysrKysrKysrKysrKysrKysrKysr
Kw0KPiAgMSBmaWxlIGNoYW5nZWQsIDE0NCBpbnNlcnRpb25zKCspDQo+ICBjcmVhdGUgbW9kZSAx
MDA2NDQgZG9jcy9kZXZlbC9taWdyYXRpb24vdWFkay1jb21wcmVzc2lvbi5yc3QNCj4gDQo+IGRp
ZmYgLS1naXQgYS9kb2NzL2RldmVsL21pZ3JhdGlvbi91YWRrLWNvbXByZXNzaW9uLnJzdA0KPiBi
L2RvY3MvZGV2ZWwvbWlncmF0aW9uL3VhZGstY29tcHJlc3Npb24ucnN0DQo+IG5ldyBmaWxlIG1v
ZGUgMTAwNjQ0DQo+IGluZGV4IDAwMDAwMDAwMDAuLjk4OGI5MjYzMWUNCj4gLS0tIC9kZXYvbnVs
bA0KPiArKysgYi9kb2NzL2RldmVsL21pZ3JhdGlvbi91YWRrLWNvbXByZXNzaW9uLnJzdA0KPiBA
QCAtMCwwICsxLDE0NCBAQA0KPiArPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09DQo+ICtVc2VyIFNwYWNlIEFjY2VsZXJhdG9yIERldmVsb3Bt
ZW50IEtpdCAoVUFESykgQ29tcHJlc3Npb24NCj4gKz09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQ0KPiArVUFESyBpcyBhIGdlbmVyYWwtcHVy
cG9zZSB1c2VyIHNwYWNlIGFjY2VsZXJhdG9yIGZyYW1ld29yayB0aGF0IHVzZXMNCj4gc2hhcmVk
DQo+ICt2aXJ0dWFsIGFkZHJlc3NpbmcgKFNWQSkgdG8gcHJvdmlkZSBhIHVuaWZpZWQgcHJvZ3Jh
bW1pbmcgaW50ZXJmYWNlIGZvcg0KPiAraGFyZHdhcmUgYWNjZWxlcmF0aW9uIG9mIGNyeXB0b2dy
YXBoaWMgYW5kIGNvbXByZXNzaW9uIGFsZ29yaXRobXMuDQo+ICsNCj4gK1VBREsgaW5jbHVkZXMg
VW5pZmllZC9Vc2VyLXNwYWNlLWFjY2Vzcy1pbnRlbmRlZCBBY2NlbGVyYXRvciBGcmFtZXdvcmsN
Cj4gKFVBQ0NFKSwNCj4gK3doaWNoIGVuYWJsZXMgaGFyZHdhcmUgYWNjZWxlcmF0b3JzIGZyb20g
ZGlmZmVyZW50IHZlbmRvcnMgdGhhdCBzdXBwb3J0DQo+IFNWQSB0bw0KPiArYWRhcHQgdG8gVUFE
Sy4NCj4gKw0KPiArQ3VycmVudGx5LCBIaVNpbGljb24gS3VucGVuZyBoYXJkd2FyZSBhY2NlbGVy
YXRvcnMgaGF2ZSBiZWVuIHJlZ2lzdGVyZWQNCj4gd2l0aA0KPiArVUFDQ0UuIFRocm91Z2ggdGhl
IFVBREsgZnJhbWV3b3JrLCB1c2VycyBjYW4gcnVuIGNyeXB0b2dyYXBoaWMgYW5kDQo+IGNvbXBy
ZXNzaW9uDQo+ICthbGdvcml0aG1zIHVzaW5nIGhhcmR3YXJlIGFjY2VsZXJhdG9ycyBpbnN0ZWFk
IG9mIENQVXMsIGZyZWVpbmcgdXAgQ1BVDQo+ICtjb21wdXRpbmcgcG93ZXIgYW5kIGltcHJvdmlu
ZyBjb21wdXRpbmcgcGVyZm9ybWFuY2UuDQo+ICsNCj4gK2h0dHBzOi8vZ2l0aHViLmNvbS9MaW5h
cm8vdWFkay90cmVlL21hc3Rlci9kb2NzDQo+ICsNCj4gK1VBREsgRnJhbWV3b3JrDQo+ICs9PT09
PT09PT09PT09PQ0KPiArVUFESyBjb25zaXN0cyBvZiBVQUNDRSwgdmVuZG9ycycgZHJpdmVycywg
YW5kIGFuIGFsZ29yaXRobSBsYXllci4gVUFESw0KPiByZXF1aXJlcw0KPiArdGhlIGhhcmR3YXJl
IGFjY2VsZXJhdG9yIHRvIHN1cHBvcnQgU1ZBLCBhbmQgdGhlIG9wZXJhdGluZyBzeXN0ZW0gdG8N
Cj4gc3VwcG9ydA0KPiArSU9NTVUgYW5kIFNWQS4gSGFyZHdhcmUgYWNjZWxlcmF0b3JzIGZyb20g
ZGlmZmVyZW50IHZlbmRvcnMgYXJlDQo+IHJlZ2lzdGVyZWQgYXMNCj4gK2RpZmZlcmVudCBjaGFy
YWN0ZXIgZGV2aWNlcyB3aXRoIFVBQ0NFIGJ5IHVzaW5nIGtlcm5lbC1tb2RlIGRyaXZlcnMgb2YN
Cj4gdGhlDQo+ICt2ZW5kb3JzLiBBIHVzZXIgY2FuIGFjY2VzcyB0aGUgaGFyZHdhcmUgYWNjZWxl
cmF0b3JzIGJ5IHBlcmZvcm1pbmcgdXNlci0NCj4gbW9kZQ0KPiArb3BlcmF0aW9ucyBvbiB0aGUg
Y2hhcmFjdGVyIGRldmljZXMuDQo+ICsNCj4gKzo6DQo+ICsNCj4gKyAgICAgICAgICArLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLSsNCj4gKyAgICAgICAgICB8ICAgICAgICAgICAg
ICAgIGFwcHMgICAgICAgICAgICAgIHwNCj4gKyAgICAgICAgICArLS0tLSstLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0rLS0tLSsNCj4gKyAgICAgICAgICAgICAgIHwgICAgICAgICAgICAgICAgICAg
ICAgICB8DQo+ICsgICAgICAgICAgICAgICB8ICAgICAgICAgICAgICAgICAgICAgICAgfA0KPiAr
ICAgICAgICstLS0tLS0tKy0tLS0tLS0tKyAgICAgICArLS0tLS0tLSstLS0tLS0tKw0KPiArICAg
ICAgIHwgICBzY2hlZHVsZXIgICAgfCAgICAgICB8IGFsZyBsaWJyYXJpZXMgfA0KPiArICAgICAg
ICstLS0tLS0tKy0tLS0tLS0tKyAgICAgICArLS0tLS0tLSstLS0tLS0tKw0KPiArICAgICAgICAg
ICAgICAgfCAgICAgICAgICAgICAgICAgICAgICAgICB8DQo+ICsgICAgICAgICAgICAgICB8ICAg
ICAgICAgICAgICAgICAgICAgICAgIHwNCj4gKyAgICAgICAgICAgICAgIHwgICAgICAgICAgICAg
ICAgICAgICAgICAgfA0KPiArICAgICAgICAgICAgICAgfCAgICAgICAgICAgICAgICArLS0tLS0t
LS0rLS0tLS0tKw0KPiArICAgICAgICAgICAgICAgfCAgICAgICAgICAgICAgICB8IHZlbmRvciBk
cml2ZXJzfA0KPiArICAgICAgICAgICAgICAgfCAgICAgICAgICAgICAgICArLSstLS0tLS0tLS0t
LS0tKw0KPiArICAgICAgICAgICAgICAgfCAgICAgICAgICAgICAgICAgIHwNCj4gKyAgICAgICAg
ICAgICAgIHwgICAgICAgICAgICAgICAgICB8DQo+ICsgICAgICAgICAgICArLS0rLS0tLS0tLS0t
LS0tLS0tLS0tKy0tKw0KPiArICAgICAgICAgICAgfCAgICAgICAgIGxpYndkICAgICAgICAgIHwN
Cj4gKyAgICBVc2VyICAgICstLS0tKy0tLS0tLS0tLS0tLS0rLS0tLS0rDQo+ICsgICAgLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4gKyAgICBLZXJu
ZWwgICAgKy0tKy0tLS0tKyAgICstLS0tLS0rDQo+ICsgICAgICAgICAgICAgIHwgdWFjY2UgIHwg
ICB8IHNtbXUgfA0KPiArICAgICAgICAgICAgICArLS0tKy0tLS0rICAgKy0tLS0tLSsNCj4gKyAg
ICAgICAgICAgICAgICAgIHwNCj4gKyAgICAgICAgICAgICAgKy0tLSstLS0tLS0tLS0tLS0tLS0t
LS0rDQo+ICsgICAgICAgICAgICAgIHwgdmVuZG9yIGtlcm5lbCBkcml2ZXIgfA0KPiArICAgICAg
ICAgICAgICArLS0tLS0tLS0tLS0tLS0tLS0tLS0tLSsNCj4gKyAgICAtLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPiArICAgICAgICAgICAgICstLS0t
LS0tLS0tLS0tLS0tLS0tLS0tKw0KPiArICAgICAgICAgICAgIHwgICBIVyBBY2NlbGVyYXRvcnMg
ICAgfA0KPiArICAgICAgICAgICAgICstLS0tLS0tLS0tLS0tLS0tLS0tLS0tKw0KPiArDQo+ICtV
QURLIEluc3RhbGxhdGlvbg0KPiArLS0tLS0tLS0tLS0tLS0tLS0NCj4gK0J1aWxkIFVBREsNCj4g
K15eXl5eXl5eXl4NCj4gKw0KPiArLi4gY29kZS1ibG9jazo6IHNoZWxsDQo+ICsNCj4gKyAgICBn
aXQgY2xvbmUgaHR0cHM6Ly9naXRodWIuY29tL0xpbmFyby91YWRrLmdpdA0KPiArICAgIGNkIHVh
ZGsNCj4gKyAgICBta2RpciBidWlsZA0KPiArICAgIC4vYXV0b2dlbi5zaA0KPiArICAgIC4vY29u
ZmlndXJlIC0tcHJlZml4PSRQV0QvYnVpbGQNCj4gKyAgICBtYWtlDQo+ICsgICAgbWFrZSBpbnN0
YWxsDQo+ICsNCj4gK1dpdGhvdXQgLS1wcmVmaXgsIFVBREsgd2lsbCBiZSBpbnN0YWxsZWQgdG8g
L3Vzci9sb2NhbC9saWIgYnkgZGVmYXVsdC4NCj4gK0lmIGdldCBlcnJvcjoiY2Fubm90IGZpbmQg
LWxudW1hIiwgcGxlYXNlIGluc3RhbGwgdGhlIGxpYm51bWEtZGV2DQo+ICsNCj4gK1J1biBwa2ct
Y29uZmlnIGxpYndkIHRvIGVuc3VyZSBlbnYgaXMgc2V0dXAgY29ycmVjdGx5DQo+ICteXl5eXl5e
Xl5eXl5eXl5eXl5eXl5eXl5eXl5eXl5eXl5eXl5eXl5eXl5eXl5eXl5eXl5eXl4NCj4gKw0KPiAr
KiBleHBvcnQgUEtHX0NPTkZJR19QQVRIPSRQV0QvYnVpbGQvbGliL3BrZ2NvbmZpZw0KPiArKiBw
a2ctY29uZmlnIGxpYndkIC0tY2ZsYWdzIC0tbGlicw0KPiArICAtSS91c3IvbG9jYWwvaW5jbHVk
ZSAtTC91c3IvbG9jYWwvbGliIC1sd2QNCj4gKw0KPiArKiBleHBvcnQgUEtHX0NPTkZJR19QQVRI
IGlzIHJlcXVpcmVkIG9uIGRlbWFuZC4NCj4gKyAgTm90IHJlcXVpcmVkIGlmIFVBREsgaXMgaW5z
dGFsbGVkIHRvIC91c3IvbG9jYWwvbGliDQo+ICsNCj4gK1VBREsgSG9zdCBLZXJuZWwgUmVxdWly
ZW1lbnRzDQo+ICstLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPiArVXNlciBuZWVkcyB0
byBtYWtlIHN1cmUgdGhhdCBgYFVBQ0NFYGAgaXMgYWxyZWFkeSBzdXBwb3J0ZWQgaW4gTGludXgN
Cj4ga2VybmVsLg0KPiArVGhlIGtlcm5lbCB2ZXJzaW9uIHNob3VsZCBiZSBhdCBsZWFzdCB2NS45
IHdpdGggU1ZBIChTaGFyZWQgVmlydHVhbA0KPiArQWRkcmVzc2luZykgZW5hYmxlZC4NCj4gKw0K
PiArS2VybmVsIENvbmZpZ3VyYXRpb24NCj4gK15eXl5eXl5eXl5eXl5eXl5eXl5eDQo+ICsNCj4g
K2BgVUFDQ0VgYCBjb3VsZCBiZSBidWlsdCBhcyBtb2R1bGUgb3IgYnVpbHQtaW4uDQo+ICsNCj4g
K0hlcmUncyBhbiBleGFtcGxlIHRvIGVuYWJsZSBVQUNDRSB3aXRoIGhhcmR3YXJlIGFjY2VsZXJh
dG9yIGluIEhpU2lsaWNvbg0KPiArS3VucGVuZyBwbGF0Zm9ybS4NCj4gKw0KPiArKiAgICBDT05G
SUdfSU9NTVVfU1ZBX0xJQj15DQo+ICsqICAgIENPTkZJR19BUk1fU01NVT15DQo+ICsqICAgIENP
TkZJR19BUk1fU01NVV9WMz15DQo+ICsqICAgIENPTkZJR19BUk1fU01NVV9WM19TVkE9eQ0KPiAr
KiAgICBDT05GSUdfUENJX1BBU0lEPXkNCj4gKyogICAgQ09ORklHX1VBQ0NFPXkNCj4gKyogICAg
Q09ORklHX0NSWVBUT19ERVZfSElTSV9RTT15DQo+ICsqICAgIENPTkZJR19DUllQVE9fREVWX0hJ
U0lfWklQPXkNCj4gKw0KPiArTWFrZSBzdXJlIGFsbCB0aGVzZSBhYm92ZSBrZXJuZWwgY29uZmln
dXJhdGlvbnMgYXJlIHNlbGVjdGVkLg0KPiArDQo+ICtBY2NlbGVyYXRvciBkZXYgbm9kZSBwZXJt
aXNzaW9ucw0KPiArLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4gK0hhcndhcmUg
YWNjZWxlcmF0b3JzKGVnOiBIaVNpbGljb24gS3VucGVuZyBaaXAgYWNjZWxlcmF0b3IpIGdldHMN
Cj4gcmVnaXN0ZXJlZCB0bw0KPiArVUFESyBhbmQgY2hhciBkZXZpY2VzIGFyZSBjcmVhdGVkIGlu
IGRldiBkaXJlY3RvcnkuIEluIG9yZGVyIHRvIGFjY2Vzcw0KPiByZXNvdXJjZXMNCj4gK29uIGhh
cmR3YXJlIGFjY2VsZXJhdG9yIGRldmljZXMsIHdyaXRlIHBlcm1pc3Npb24gc2hvdWxkIGJlIHBy
b3ZpZGVkIHRvDQo+IHVzZXIuDQo+ICsNCj4gKy4uIGNvZGUtYmxvY2s6OiBzaGVsbA0KPiArDQo+
ICsgICAgJCBzdWRvIGNobW9kIDc3NyAvZGV2L2hpc2lfemlwLSoNCj4gKw0KPiArSG93IFRvIFVz
ZSBVQURLIENvbXByZXNzaW9uIEluIFFlbXUgTWlncmF0aW9uDQo+ICstLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4gKyogTWFrZSBzdXJlIFVBREsgaXMgaW5z
dGFsbGVkIGFzIGFib3ZlDQo+ICsqIEJ1aWxkIGBgUWVtdWBgIHdpdGggYGAtLWVuYWJsZS11YWRr
YGAgcGFyYW1ldGVyDQo+ICsNCj4gKyAgRS5nLiBjb25maWd1cmUgLS10YXJnZXQtbGlzdD1hYXJj
aDY0LXNvZnRtbXUgLS1lbmFibGUta3ZtIGBgLS1lbmFibGUtDQo+IHVhZGtgYA0KPiArDQo+ICsq
IEVuYWJsZSBgYFVBREtgYCBjb21wcmVzc2lvbiBkdXJpbmcgbWlncmF0aW9uDQo+ICsNCj4gKyAg
U2V0IGBgbWlncmF0ZV9zZXRfcGFyYW1ldGVyIG11bHRpZmQtY29tcHJlc3Npb24gdWFka2BgDQo+
ICsNCj4gK1NpbmNlIFVBREsgdXNlcyBTaGFyZWQgVmlydHVhbCBBZGRyZXNzaW5nKFNWQSkgYW5k
IGRldmljZSBhY2Nlc3MgdmlydHVhbA0KPiBtZW1vcnkNCj4gK2RpcmVjdGx5IGl0IGlzIHBvc3Np
YmxlIHRoYXQgU01NVXYzIG1heSBlbm91bnRlciBwYWdlIGZhdWx0cyB3aGlsZQ0KPiB3YWxraW5n
IHRoZQ0KPiArSU8gcGFnZSB0YWJsZXMuIFRoaXMgbWF5IGltcGFjdCB0aGUgcGVyZm9ybWFuY2Uu
IEluIG9yZGVyIHRvIG1pdGlnYXRlDQo+IHRoaXMsDQo+ICtwbGVhc2UgbWFrZSBzdXJlIHRvIHNw
ZWNpZnkgYGAtbWVtLXByZWFsbG9jYGAgcGFyYW1ldGVyIHRvIHRoZQ0KPiBkZXN0aW5hdGlvbiBW
TQ0KPiArYm9vdCBwYXJhbWV0ZXJzLg0KDQpUaGFuayB5b3Ugc28gbXVjaCBmb3IgcHV0dGluZyB0
aGUgSUFBIHNvbHV0aW9uIGF0IHRoZSB0b3AgYW5kIGNjIG1lLg0KDQpJIHRoaW5rIG1pZ3JhdGlv
biBwZXJmb3JtYW5jZSB3aWxsIGJlIGJldHRlciB3aXRoICctbWVtLXByZWFsbG9jJyBvcHRpb24s
DQpidXQgSSBhbSBjb25zaWRlcmluZyB3aGV0aGVyICctbWVtLXByZWFsbG9jJyBpcyBhIG1hbmRh
dG9yeSBvcHRpb24sIGZyb20gbXkgDQpleHBlcmllbmNlLCBTVkEgcGVyZm9ybWFuY2UgZHJvcHMg
bWFpbmx5IGNhdXNlZCBieSBJT1RMQiBmbHVzaCBhbmQgSU8gcGFnZSBmYXVsdCwNCkkgaGFkIHNv
bWUgZGlzY3Vzc2lvbnMgd2l0aCBQZXRlciBYdSBhYm91dCB0aGUgSU9UTEIgZmx1c2ggaXNzdWUs
IGFuZCBpdCBoYXMgDQpiZWVuIGltcHJvdmVkLg0KaHR0cHM6Ly9wYXRjaGV3Lm9yZy9RRU1VL1BI
N1BSMTFNQjU5NDFGMDRGQkZCOTY0Q0IyQzk2ODg2NkEzM0UyQFBIN1BSMTFNQjU5NDEubmFtcHJk
MTEucHJvZC5vdXRsb29rLmNvbS8NCg0KRm9yIElPIHBhZ2UgZmF1bHQsIHRoZSBRUEwoSUFBIHVz
ZXJzcGFjZSBsaWJyYXJ5KSBjYW4gcHJvY2VzcyBwYWdlIGZhdWx0DQpyZXF1ZXN0IGluc3RlYWQg
b2YgSU9NTVUsIGl0IG1lYW5zIHdlIGNhbiBkaXNhYmxlIHRoZSBJL08gcGFnZSBmYXVsdCBmZWF0
dXJlDQpvbiB0aGUgSUFBIGRldmljZSwgYW5kIGxldCB0aGUgZGV2aWNlIHN0aWxsIHVzZSBTVkEg
dGVjaG5vbG9neSB0byBhdm9pZCBtZW1vcnkNCmNvcHkuDQoNCkkgd2lsbCBwcm92aWRlIHRoZSB0
ZXN0IHJlc3VsdHMgaW4gbXkgbmV4dCB2ZXJzaW9uLCBkbyB5b3UgaGF2ZSBhbnkgaWRlYXMgb3Ig
DQpzdWdnZXN0aW9ucyBhYm91dCB0aGlzLCB0aGFua3MuDQoNCj4gK1Rob3VnaCBib3RoIFVBREsg
YW5kIFpMSUIgYXJlIGJhc2VkIG9uIHRoZSBkZWZsYXRlIGNvbXByZXNzaW9uwqBhbGdvcml0aG0s
DQo+IFVBREsNCj4gK2lzIG5vdCBmdWxseSBjb21wYXRpYmxlIHdpdGggWkxJQi4gSGVuY2UsIHBs
ZWFzZSBtYWtlIHN1cmUgdG8gdXNlDQo+IGBgdWFka2BgIG9uDQo+ICtib3RoIHNvdXJjZSBhbmQg
ZGVzdGluYXRpb24gZHVyaW5nIG1pZ3JhdGlvbi4NCj4gLS0NCj4gMi4xNy4xDQoNCg==

