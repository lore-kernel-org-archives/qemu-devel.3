Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BE3FCA1015
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Sep 2025 06:43:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uu3fs-0000Ff-UY; Thu, 04 Sep 2025 02:42:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uu3fp-0000Ei-VS
 for qemu-devel@nongnu.org; Thu, 04 Sep 2025 02:42:21 -0400
Received: from mgamail.intel.com ([198.175.65.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uu3fm-00050D-PF
 for qemu-devel@nongnu.org; Thu, 04 Sep 2025 02:42:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1756968139; x=1788504139;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=hf/6xoahof14e11u1dyoa9GKWpOR8H7R206PunMYtrU=;
 b=ZvuziXtjvJfehqulwdosHOKETngKBNgVTVKF/ihhHXUCbZ37vWf5roXD
 42yPN6utYn5n4E7FgEODbAClvVtR0u9/eQSq69IdnUErkuKu75g04BPKG
 bjFhhJvplWSJXeb7Okv6smG3Ud0vvpvVH5CaWFZF4xJQLKcyn2/2876Ze
 7piNoGyS+pZcJ0zQedNte4hdq711C5l0xE5Jv4IdXDsT6sdtyrTxDlbvB
 iplmTu+XH1K6PlGxYa9jSno+dC+9J1tN+5Ukhxm2fdNY9WEjsmXZbhnKM
 mDgOQD+qrW8kc7vqdqZG3mToSSnndtv4eh1wAxJl+1oHO+0VIGb+11FZS g==;
X-CSE-ConnectionGUID: bEshXwcERlCCwSl7fRyg9Q==
X-CSE-MsgGUID: LNNExRilSzG+fBQ9NkmlEQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="59211806"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; d="scan'208";a="59211806"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Sep 2025 23:42:13 -0700
X-CSE-ConnectionGUID: 8QqzFW/pQeau0wYeHYiq5A==
X-CSE-MsgGUID: ojRdtbieRiWUE6Whe/jxoA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,237,1751266800"; d="scan'208";a="195462600"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Sep 2025 23:42:13 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 3 Sep 2025 23:42:12 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Wed, 3 Sep 2025 23:42:12 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (40.107.237.82)
 by edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 3 Sep 2025 23:42:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u9wLOEssG0zYhT5FffsRXmkTCIKgXcZcNRSLZyyglOkiO9Gf1CaZcTTRjOKbkHMQzpZfLN/0pNRwrQUjAOsZxlqERZjQWBl0FPykKrMpjoDJYhxuNQ+W6I3YgZpK+tq3vvzATOmv6sTa0B6wT25B7zWigT7zbRpUQAadXkUUa8wS0cpxNGlXCDZdvPVDdyrJfk5EDp+wwGzLXNNJhIrSr8b9iHCi5C+lCTXfVkeylFweVfqJcUBqmBUW+wFXy8k6LoodwWm2XytT2xkXxOkiBNkwQ3adt3lYRdh7SnqDVxEFMoo9C/sQbd2RqNxhHJ+8bhJrK7bQS/NBBqzQP+bjCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hf/6xoahof14e11u1dyoa9GKWpOR8H7R206PunMYtrU=;
 b=hdgnibIBDPm5qWss2HdNDrA0BtgQQK71T3Ei1xjkQhHcpCJ41EBVH7S01+AWP/vqt9Ct0GgKAHZUmVL8IlKBaZ/RvsNJxen9hpxeDGb99B1Fcuumd8uKrEWDzTAxGQ1NiSjzJc0KJcRCwOoBsKytfZPcU1ggYOGC8vX9ukk8d5TrYnHlzQPy4rabAKkvy7xNcYUSFCgC1Vfk5JDMvZ7uqn4Sfq03jG9+lOWLKcV5oFt6+hSDTZYoR9DejFjUUx9E9YDirgihu6LgsQpXcbQJrbarSa/4HSGoh+iecqJE38Jwr6V9aEWY0Du9R0vhHCkadhZ4f7095vUG22hQklV0kA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12)
 by SJ0PR11MB4959.namprd11.prod.outlook.com (2603:10b6:a03:2de::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.17; Thu, 4 Sep
 2025 06:42:09 +0000
Received: from IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13]) by IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13%4]) with mapi id 15.20.9073.026; Thu, 4 Sep 2025
 06:42:09 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: "Liu, Yi L" <yi.l.liu@intel.com>, "eric.auger@redhat.com"
 <eric.auger@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>, "mst@redhat.com" <mst@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>, "peterx@redhat.com"
 <peterx@redhat.com>, "ddutile@redhat.com" <ddutile@redhat.com>,
 "jgg@nvidia.com" <jgg@nvidia.com>, "nicolinc@nvidia.com"
 <nicolinc@nvidia.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "clement.mathieu--drif@eviden.com"
 <clement.mathieu--drif@eviden.com>, "Tian, Kevin" <kevin.tian@intel.com>,
 "Peng, Chao P" <chao.p.peng@intel.com>, Yi Sun <yi.y.sun@linux.intel.com>
Subject: RE: [PATCH v5 16/21] intel_iommu: Replay pasid bindings after context
 cache invalidation
Thread-Topic: [PATCH v5 16/21] intel_iommu: Replay pasid bindings after
 context cache invalidation
Thread-Index: AQHcEy/zmhvzV/GWN0uWVf68C3lMb7R32giAgAFuqwCABL9tgIADSaYAgAFQrpA=
Date: Thu, 4 Sep 2025 06:42:09 +0000
Message-ID: <IA3PR11MB91367C3398002532F94165239200A@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <20250822064101.123526-1-zhenzhong.duan@intel.com>
 <20250822064101.123526-17-zhenzhong.duan@intel.com>
 <ed8f5d83-0bcf-4685-a362-cbb948b01baa@redhat.com>
 <eede18d2-e8fb-4bbd-b718-3f11544716ba@intel.com>
 <IA3PR11MB9136319CC57353A1E2F0F26A9207A@IA3PR11MB9136.namprd11.prod.outlook.com>
 <4d2f4c70-ed7c-4c2c-8140-04e2203d30f1@intel.com>
In-Reply-To: <4d2f4c70-ed7c-4c2c-8140-04e2203d30f1@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9136:EE_|SJ0PR11MB4959:EE_
x-ms-office365-filtering-correlation-id: d68fbdf5-35fa-4abb-1b90-08ddeb7e2c02
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|376014|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?d0c0NFpZcHZVSEgrblVVK080V0d0U0xSbVF1TlBOc1ZQWG1Fc2NSU3ZTbkd5?=
 =?utf-8?B?WWtOQzhTbmF6dDJqSTREbEFjZXZSNXY4NFpLZG1MbEN3Y3J4TmMrUlBpTk1u?=
 =?utf-8?B?MWtlN1pyQUprbnN5dTVlT1FmcXRsSUJxdnVLaVpGVlVCZmoxQUlWQ1gvaXRo?=
 =?utf-8?B?elJHTHRHdFlTVDhQZHJreTR6bkpDT3RrYVBJWG54ZlhRTTltMWZ0UnpycVhx?=
 =?utf-8?B?Ui9oOHdUbGtUU1VpZ0FjVmpWL0Vpa1ZjSE5oQ2VlZmVLd21HTE5pVW9iMVlu?=
 =?utf-8?B?NnZRNnVQTXBkM1pPRFpyaHE5b0xpaWxUOGxzdXFTQ3JDOHJGWmN3eXVmZU5L?=
 =?utf-8?B?a0RqcFAyYkg4bVo4blpidnN4eUpXN0tXblA1VnhENDZwYURLZ3YrUHJqY0Rs?=
 =?utf-8?B?RktOZlFTSkZRUG1SVUFJaDdNZGJGSFgycmRBbG8rOU1vTWVsRnJkb2MwOVhv?=
 =?utf-8?B?UTRtLzZoNFVPcmFCditXdzVoS1ZidUNpZEdRN2hNbUtwN3RkYmk0VGcrKzBn?=
 =?utf-8?B?SUt4WkpqTWwxRi90RVVMQUVaSG5HU215SzZDZFQxSzU0WEtVZTRjb0pyOFdk?=
 =?utf-8?B?VG10SDI3Wi9xcDBia3hnaDd2bENrbnZRSUs2OVpvcVppQXlvOUR0UnBFbjZ2?=
 =?utf-8?B?YXJVU3doNUp4NFoyUUNqTlVRcGR4YUxNc2RHdnhSUWIyeU90S1dibEcwcjFZ?=
 =?utf-8?B?M2YyblpBb1lYdFA2SWRjTnBNMkVJbXBZU2VLd1hubzJvMmZnQkUyNDRPOTJu?=
 =?utf-8?B?eGkwY2pReXByY0U0UXJ5Sm8xdG10TDdlZHJWdG9JNDUzZEY4dklzOWRMOW5Q?=
 =?utf-8?B?R2pkVnlZeDJtbVNOSUoyNWZWakRtaUpsMWJRdElSZitPR3l3Vmd0MWVScSs1?=
 =?utf-8?B?MTdXMDdCSnAyR3Zod015M29zWTNscXhtdUloVU1zNWtwanRRZmFNVk9DQ1M4?=
 =?utf-8?B?RG9SaWVGME53TGM2dnV6b241RVhsR2xSQUFWYkcxWVlvTTUvaDhlTUNIM1ZZ?=
 =?utf-8?B?d1pseWw5OHBJT24wZmhpZnB4L0c4WXB5cTRDUHhMNjl6YnJHNkR2STdqZmZM?=
 =?utf-8?B?Qi9hV3VVTGczUFV0bmlyVGRMUGtWMkJZQzZ6ZzdBMm9ISFBWQW15ejMxcEZl?=
 =?utf-8?B?cWZYOEUrNzNDcTJBVEYwa2hNakhsbmVrbjgwWkNrcHp3a2Z3RUNZNUlZbEhC?=
 =?utf-8?B?RFhMQklqbEdSZlA0anpWYkFpZUZRM2h0VnZzYS8zS04zS3BKbEtlVkM4Yllv?=
 =?utf-8?B?Sm02c0k5OWlZODA2Z05XaEVMT0JkRGM0YXBEUDNqRStHc09qWllPVnlkcE1W?=
 =?utf-8?B?NjY0L0s2VDVQcDNXdU5aMDhXMEZYdVRMWmRwM01mYVkzaXFkNFlSbDRjcFU4?=
 =?utf-8?B?alptdHpVeVBKNWFtTEVSWCtTRVc3cldqemgvRG1aZUhDUXVJV3IxaTZsSVpZ?=
 =?utf-8?B?UlBYU2dwVEpiYkRkQ0R1cGtON0lra3NIdU83QTQ2cXg2bTg2V2p2NVFOUDRL?=
 =?utf-8?B?Q2NCMFNCR0habzhDUW82aEFMa0NrQy93aW5kQUJaZmI2M0hKQ1liWkN1VHgy?=
 =?utf-8?B?YlUyTTdKZmp4Rjh4bytZUFJXd2hVdFlWbW93eW5YSlZvSGJwUTg0S1FaY1U5?=
 =?utf-8?B?Wnd4NEh2Y3YxNnVvTjFtcW9vbjBxOTg1bUt0SEc1ckhkaTBsZndRRkREMnJz?=
 =?utf-8?B?b2twMG9kQ0pTZmlSVDVMNkVLWmxaWVZ1TGFGRVlXR1hFOHVJTWZ3M1l1ZFhQ?=
 =?utf-8?B?YU5UK2xGUnJocU9FbUlmR2JHMFJvWjFmWGpRZnUzaTNQQk1pZTdDMEpoeGQz?=
 =?utf-8?B?c1JEaWVRVFdwMFloOXB6MjF2eDNJOXFtenJzeEErQ2h2WWNJM29DR3Z1OEpE?=
 =?utf-8?B?NXFFakJYa0F6VVY3SWFYVEFVdnB2RnRtZkVSSUlLTkVHTXk4MjZWMVh2cEZs?=
 =?utf-8?Q?pddvd9+ai5Y=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9136.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SUkzZE9rbzFlbnZpbmJEN25QMUsvWWNyWWNKWGpiVUlURjhUNTBQc3hrZGhO?=
 =?utf-8?B?K2JTd0E3VEUzcUR1K3NSWHlUSHpGbVE2MThjV01Kb1NMLzdaUmlwTUhOZGRP?=
 =?utf-8?B?SXF4VWRMYjBIT2RnWWJRRDd4Slp5QmNFWUs4WXB1ekVDcWt0a2w0NkR0UklM?=
 =?utf-8?B?MWNQMnVmWWthNXcvRDZzSzBaaGdNd3NpaHFBMWozd2JZNlpWQXhOZFp2UmNQ?=
 =?utf-8?B?UG1xSzNkd0VwcXE5cGNwWlkxbGEzQmJ6aUh6cDlZR2wzRVpTNVR1cmk1T2kr?=
 =?utf-8?B?c0FHLzI5dDk0dkNCNWJ6dS96M0ZBMUxkRUNrL29uUnd3RndLN1ovVTErdDhQ?=
 =?utf-8?B?N01QUjUxUDdqNkpMUGZlblVrY3BGd2FtTW1FWEpVSDVWNlFMSElCcTkxb1Vz?=
 =?utf-8?B?SENNTXZoZTlTM1kxeCtlK21ORGlwT0RzK2RwaG9IWEFxY0JuZ0IyQWJ3M2RE?=
 =?utf-8?B?WUNkWHdHYjgveXlKOEwvWEVYZFNCbjVqa21Xdks4ZkpJQ2s3WGdMc1Irekps?=
 =?utf-8?B?OW9Id1RDYVhFRmRQTXZxS1ZwZlJCZ0RTUFZTaTRnZnZNQ3VRWFpwUjZheHI1?=
 =?utf-8?B?b0pCR3IyUUg0N3NSWmxQZkpYbzZQM3NTeHF4ck9wQXRBYUUxd3Z5YnJHZnpR?=
 =?utf-8?B?Q0FROXFKTERSSmVDSDhId1VPWFVHQjN3Y2R1T0NKR0tBaUdKTklHRGdTMGxx?=
 =?utf-8?B?bkszbUxTdzlIYTVOb3YvaFJMZ21rb2lqQkJuelpxNHAzcmlaUFJ5UmU3b3pY?=
 =?utf-8?B?RVJiS0FSRjZUMlNYdTByNGl3MGFCYjhHL3hhREVhYitqanFGaHZhTGZKUEs0?=
 =?utf-8?B?cEF1UTNvcU85MjV1UktYZmZUc1VScGw3cjlPbEp2bjJRMERkUkRWeUhmN210?=
 =?utf-8?B?N04xQ1RtUjZmTVFXdjliTmhCTlhqYmF4Tmg1dy9kcjNaaFZzeFdZczExSlR4?=
 =?utf-8?B?ckhWNy9wM1NlQTlOb3d4azVLTlFsV2xTREJCTXRwdFdLbE5ZdE4wa01jVWlD?=
 =?utf-8?B?R1VMUDdQZzRKdDZVa2V1cnc1Y2xlR3BpazgzckhXaHRDdlQ4OWNDZ0ZjRzh3?=
 =?utf-8?B?YUREc2RLRFdjTncyclg5czQrNmdRMitQR3k0NHZjenMzODZnUzVMbGNwTGRj?=
 =?utf-8?B?Mm1jV01mOHdrMmtUWnhRWC9ndktKT0RkcjlzOGFCSzg4NTg0UFZjWUVOOXg4?=
 =?utf-8?B?MmxUOW1Ld01sRUVRS1dOZUdkdGNoRmIvSVNVV0ExN1JYczQyamQwNEI5OWJm?=
 =?utf-8?B?eUhldGtWaHZ0ZHB5cTF0bUlkWS9JQ0cySTJ3RFZxdVB2Q0JORkxURVVyWFN1?=
 =?utf-8?B?NUhRc3phVVRFRWJqb2drTkFZMmdnRzR0cFhoanpyVExXeEtoYm5wOEVISVVp?=
 =?utf-8?B?SXNKYkhFQndIeTYzK1RxVStYZGpLQVQ0bHo4K01PZGNEbTFvRzNjcm1zNGR3?=
 =?utf-8?B?OGRBVmFTRWZ5anE5WGhLUUxadWoxOFFqR0lNU05uSnd5VXR3OHFFaU5VQ0Mv?=
 =?utf-8?B?MTh2bEJza3Z0V09rbTdiRDNOWXZnOC9GNDZsTlpOa0d4REtJS2xuYnB5QzhW?=
 =?utf-8?B?OUxXU25lYzZoTjVHSWoxWXFVMndIUTdQYUVEeWFIT0tMNUFMMFRPN1dSL3Ni?=
 =?utf-8?B?UXpVTElkN0NZNkFad3ZQeE83TnJQWUVNczY3clA5UGRRbnljdWo0UjdVSnJJ?=
 =?utf-8?B?SHNqTlVQTEFLeTVEN3QxWEFLcUd2bnphOG83VWxQcXRoS2ZwczhvRDMzS1Ew?=
 =?utf-8?B?OGNzK251MWRYbmxQWTlPUnB2d2FaaEMrUEdVdEhWZ05RVWJVeHp2N1hlN0s1?=
 =?utf-8?B?bGRSMUZPbDNjTytBODBkdzJKMWxwdW4rcGF0T2hWU2J4Mm41UldUZ1BIbHAw?=
 =?utf-8?B?b0gzTllLTmJRZXp3ZHQwOC8xWW5uN1l2N3ZRSDBpajFEcFl6R1V5YTBVeG11?=
 =?utf-8?B?NW5pT0dwSmtHN2lUb2hFcWR2S3ZTV3MvM012M1J2aEpHUWVIQjg3RjNrS1pm?=
 =?utf-8?B?MU9KQkNmazl0N3JNQUVHSlEya2ZYU21QQ2l2OU5xVTc5V0tpb1p2eXhjSkVa?=
 =?utf-8?B?bnMzTmVEUDVDVlVTOFp4RVI4OEV0UHJOdTFzTW53Q2xweGFNZzRia0YySDg3?=
 =?utf-8?Q?c1qicdbJ7mxqP8/qiPNebk3Eo?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9136.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d68fbdf5-35fa-4abb-1b90-08ddeb7e2c02
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Sep 2025 06:42:09.2983 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vX0V9snyq3vz5J879XqEhF8Gh0IurWiY68WV5thkCN1PcRnPNeIXDay2bc/SJbcCrtZ/CY+rjYct7uiRk4ZzLAvrWXMVK4/V14rOTw0QruE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4959
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.21;
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IExpdSwgWWkgTCA8eWkubC5s
aXVAaW50ZWwuY29tPg0KPlN1YmplY3Q6IFJlOiBbUEFUQ0ggdjUgMTYvMjFdIGludGVsX2lvbW11
OiBSZXBsYXkgcGFzaWQgYmluZGluZ3MgYWZ0ZXINCj5jb250ZXh0IGNhY2hlIGludmFsaWRhdGlv
bg0KPg0KPk9uIDIwMjUvOS8xIDE2OjExLCBEdWFuLCBaaGVuemhvbmcgd3JvdGU6DQo+Pg0KPj4N
Cj4+PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPj4+IEZyb206IExpdSwgWWkgTCA8eWku
bC5saXVAaW50ZWwuY29tPg0KPj4+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjUgMTYvMjFdIGludGVs
X2lvbW11OiBSZXBsYXkgcGFzaWQgYmluZGluZ3MgYWZ0ZXINCj4+PiBjb250ZXh0IGNhY2hlIGlu
dmFsaWRhdGlvbg0KPj4+DQo+Pj4gT24gMjAyNS84LzI4IDE3OjQzLCBFcmljIEF1Z2VyIHdyb3Rl
Og0KPj4+Pg0KPj4+Pg0KPj4+PiBPbiA4LzIyLzI1IDg6NDAgQU0sIFpoZW56aG9uZyBEdWFuIHdy
b3RlOg0KPj4+Pj4gRnJvbTogWWkgTGl1IDx5aS5sLmxpdUBpbnRlbC5jb20+DQo+Pj4+Pg0KPj4+
Pj4gVGhpcyByZXBsYXlzIGd1ZXN0IHBhc2lkIGJpbmRpbmdzIGFmdGVyIGNvbnRleHQgY2FjaGUg
aW52YWxpZGF0aW9uLg0KPj4+Pj4gVGhpcyBpcyBhIGJlaGF2aW9yIHRvIGVuc3VyZSBzYWZldHku
IEFjdHVhbGx5LCBwcm9ncmFtbWVyIHNob3VsZCBpc3N1ZQ0KPj4+Pj4gcGFzaWQgY2FjaGUgaW52
YWxpZGF0aW9uIHdpdGggcHJvcGVyIGdyYW51bGFyaXR5IGFmdGVyIGlzc3VpbmcgYSBjb250ZXh0
DQo+Pj4+PiBjYWNoZSBpbnZhbGlkYXRpb24uDQo+Pj4+IFNvIGlzIHRoaXMgbWFuZGF0ZWQ/IElm
IHRoZSBzcGVjIG1hbmRhdGVzIHNwZWNpZmljIGludmFsaWRhdGlvbnMgYW5kIHRoZQ0KPj4+PiBn
dWVzdCBkb2VzIG5vdCBjb21wbHkgd2l0aCB0aGUgZXhwZWN0ZWQgaW52YWxpZGF0aW9uIHNlcXVl
bmNlIHNoYWxsIHdlDQo+Pj4+IGRvIHRoYXQgYmVoaW5kIHRoZSBjdXJ0YWluPw0KPj4+DQo+Pj4g
SSB0aGluayB0aGlzIGlzIGZvbGxvd2luZyB0aGUgYmVsb3cgZGVjaXNpb24uIFdlIGNhbiBkaXNj
dXNzIGlmIGl0J3MNCj4+PiByZWFsbHkgbmVlZGVkIHRvIHJlcGxheSB0aGUgcGFzaWQgYmluZC4N
Cj4+Pg0KPj4+IGQ0ZDYwN2U0MGQgKFBldGVyIFh1ICAgICAgICAgICAgICAgICAgICAgMjAxNy0w
NC0wNyAxODo1OToxNQ0KPiswODAwDQo+Pj4gMjMyMSkNCj4+PiAgICAgIC8qDQo+Pj4gZGQ0ZDYw
N2U0MGQgKFBldGVyIFh1ICAgICAgICAgICAgICAgICAgICAgMjAxNy0wNC0wNyAxODo1OToxNQ0K
PiswODAwDQo+Pj4gMjMyMikgICAgICAqIEZyb20gVlQtZCBzcGVjIDYuNS4yLjEsIGEgZ2xvYmFs
IGNvbnRleHQgZW50cnkgaW52YWxpZGF0aW9uDQo+Pj4gZGQ0ZDYwN2U0MGQgKFBldGVyIFh1ICAg
ICAgICAgICAgICAgICAgICAgMjAxNy0wNC0wNyAxODo1OToxNQ0KPiswODAwDQo+Pj4gMjMyMykg
ICAgICAqIHNob3VsZCBiZSBmb2xsb3dlZCBieSBhIElPVExCIGdsb2JhbCBpbnZhbGlkYXRpb24s
IHNvIHdlDQo+Pj4gc2hvdWxkDQo+Pj4gZGQ0ZDYwN2U0MGQgKFBldGVyIFh1ICAgICAgICAgICAg
ICAgICAgICAgMjAxNy0wNC0wNyAxODo1OToxNQ0KPiswODAwDQo+Pj4gMjMyNCkgICAgICAqIGJl
IHNhZmUgZXZlbiB3aXRob3V0IHRoaXMuIEhvZXdldmVyLCBsZXQncyByZXBsYXkgdGhlIHJlZ2lv
bg0KPmFzDQo+Pj4gZGQ0ZDYwN2U0MGQgKFBldGVyIFh1ICAgICAgICAgICAgICAgICAgICAgMjAx
Ny0wNC0wNyAxODo1OToxNQ0KPiswODAwDQo+Pj4gMjMyNSkgICAgICAqIHdlbGwgdG8gYmUgc2Fm
ZXIsIGFuZCBnbyBiYWNrIGhlcmUgd2hlbiB3ZSBuZWVkIGZpbmVyIHR1bmVzDQo+Pj4gZm9yDQo+
Pj4gZGQ0ZDYwN2U0MGQgKFBldGVyIFh1ICAgICAgICAgICAgICAgICAgICAgMjAxNy0wNC0wNyAx
ODo1OToxNQ0KPiswODAwDQo+Pj4gMjMyNikgICAgICAqIFZULWQgZW11bGF0aW9uIGNvZGVzLg0K
Pj4+IGRkNGQ2MDdlNDBkIChQZXRlciBYdSAgICAgICAgICAgICAgICAgICAgIDIwMTctMDQtMDcg
MTg6NTk6MTUNCj4rMDgwMA0KPj4+IDIzMjcpICAgICAgKi8NCj4+PiBkZDRkNjA3ZTQwZCAoUGV0
ZXIgWHUgICAgICAgICAgICAgICAgICAgICAyMDE3LTA0LTA3IDE4OjU5OjE1DQo+KzA4MDANCj4+
PiAyMzI4KSAgICAgdnRkX2lvbW11X3JlcGxheV9hbGwocyk7DQo+Pg0KPj4gSSBoYXZlIHRlc3Rl
ZCB0aGlzIHNlcmllcyB3aXRoIHRoaXMgcGF0Y2ggcmV2ZXJ0ZWQsIGl0IHdvcmtzIHdpdGggZ3Vl
c3QgbGludXgNCj5rZXJuZWwuDQo+Pg0KPj4gUGVyc29uYWxseSwgSSBhbSBpbmNsaW5lZCB0byBz
dG9wIGFkZGluZyB3b3JrYXJvdW5kIGZvciBndWVzdCBrZW5yZWwgYnVnLA0KPnRoZXJlIHdpbGwg
YmUgbW9yZSBhbmQgbW9yZSBvdmVyIHRpbWUgYW5kIGl0IG1ha2VzIGN1cnJlbnQgY29kZSBjb21w
bGV4DQo+dW5uZWNlc3NhcmlseS4gQEVyaWMsIEBMaXUsIFlpIEwgeW91ciB0aG91Z2h0Pw0KPg0K
PkxldCdzIGdvIGJhY2sgdG8gdGhlIG9yaWdpbmFsIHB1cnBvc2Ugb2YgdGhpcy4gUGV0ZXIgaGFz
IGlkZW50aWZpZWQgYQ0KPmNhc2UgaW4gd2hpY2ggYSBjb250ZXh0IG1vZGlmaWNhdGlvbiBpcyBu
b3QgZm9sbG93ZWQgYnkgSU9UTEINCj5pbnZhbGlkYXRpb24uIFsxXSBUaGlzIGlzIGEgdmFsaWQg
YmVoYXZpb3Igc2luY2UgdGhlIG9sZCBkb21haW4gaXMgc3RpbGwNCj5pbiB1c2UsIG5vIG5lZWQg
dG8gaW52YWxpZGF0ZSBJT1RMQi4gSGVuY2UgdGhlIHNoYWRvdyBwYWdlIG9mIHRoZQ0KPmNoYW5n
ZWQgZGV2aWNlIGhhcyBub3QgYmVlbiB1cGRhdGVkLiBTbyB0aGUgdklPTU1VIGNob3NlIHRvIGVu
Zm9yY2UgYQ0KPnN5bmNocm9uaXphdGlvbiBvbiB0aGUgc2hhZG93IHBhZ2UgcGVyIGNvbnRleHQg
ZW50cnkgbW9kaWZpY2F0aW9uLiBMZXQncw0KPnNlZSBpZiBzaW1pbGFyIHJlcXVpcmVtZW50IG9u
IFBBU0lEIHRhYmxlLg0KDQpEaWZmZXJlbnQgZGV2aWNlcyBjYW4gc2hhcmUgb25lIGRvbWFpbiwg
YnV0IEl0J3MgYSByYXJlIGNhc2UgdG8gc2VlIGRpZmZlcmVudCBkZXZpY2VzIHNoYXJpbmcgc2Ft
ZSBQQVNJRCB0YWJsZSBleGNlcHQgdGhleSBhcmUgaW4gc2FtZSBpb21tdSBncm91cCwgYnV0IGlm
IHRoZXkgYXJlIGluIHNhbWUgaW9tbXUgZ3JvdXAsIHRoZXkgc2hvdWxkIGFsd2F5cyB1c2UgYSBj
b21tb24gUEFTSUQgdGFibGUuIEkgdGhpbmsgbm8gbmVlZCB0byBzdXBwb3J0IHN1Y2ggcmFyZSBj
YXNlPyBBdCBsZWFzdCBsaW51eCBkb2VzIG5vdCB3b3JrIHRoaXMgd2F5Lg0KDQo+DQo+TGV0IG1l
IGFzayBvbmUgcXVlc3Rpb246IHNpbmNlIFBBU0lEIGNhY2hlIGlzIGFsc28gdGFnZ2VkIHdpdGgg
ZG9tYWluDQo+SUQsIGlmIHRoZSBESUQgaGFzIG5vdCBjaGFuZ2VkLCBtYXliZSBpb21tdSBkcml2
ZXIgd2lsbCBza2lwIHRoZSBQQVNJRA0KPmNhY2hlIGZsdXNoPw0KDQpNeSB1bmRlcnN0YW5kaW5n
IGlzIG5vIG1hdHRlciB3aGF0J3MgY2hhbmdlZCBpbiBQQVNJRCBlbnRyeSwgdGhlcmUgc2hvdWxk
IGJlIFBBU0lEIGNhY2hlIGludmFsaWRhdGlvbiwgZWl0aGVyIGRvbWFpbiBzY29wZSwgcGFzaWQg
c2NvcGUgb3IgZ2xvYmFsIGludmFsaWRhdGlvbi4NCg0KVGhhbmtzDQpaaGVuemhvbmcNCg0KPg0K
PlsxXQ0KPmh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3FlbXUtZGV2ZWwvMjAxNzAxMTcwODQ2MDQu
MmIxZjVlNTBAdDQ1MHMuaG9tZQ0KPi8NCj4NCj5SZWdhcmRzLA0KPllpIExpdQ0K

