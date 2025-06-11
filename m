Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56DA6C61CE7
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Jun 2025 10:07:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uPIM5-0006qK-1E; Wed, 11 Jun 2025 06:06:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uPIM3-0006ps-1g
 for qemu-devel@nongnu.org; Wed, 11 Jun 2025 06:06:47 -0400
Received: from mgamail.intel.com ([192.198.163.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uPIM0-0005Qk-FT
 for qemu-devel@nongnu.org; Wed, 11 Jun 2025 06:06:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1749636404; x=1781172404;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=RY65XEidzY4DThkjm+yWPSrC3Ecl6tHzbyb0kva3Wp8=;
 b=hKWGNv/xgehr06m7cY4DcrYrkkh1K6YktGWF642Xma3PN7R3Eub96kDS
 6tnjcQWnx+w15cPByxZm/YI0hVcYAk8szvWZkH7yuBPW5DzADXcOEH1Gq
 H83KEinYDToTwX6AXMfskWu6rYg1oCkmQSwsTBeeWwbquGPo5oLS4WxAw
 gDhgLEVTq2r3iqPLEnFT1PE5YyfvY5VAB3qF3tgcyZabKaA49RBx6vLzg
 JMPnFmEV+aAyvV/jD5UqjmBqsO3+Uuwx5E6t5jXxVGhTQHtc2Oyu/eWc9
 ztEJnYgKLZwHJh0tq/KLjaNAqRZ74isBe3aPCh2uy0bj+avPWw+u+22wT A==;
X-CSE-ConnectionGUID: oTNJ+M6ORZibRQ5PTw7Aow==
X-CSE-MsgGUID: V7QywjPqR4WzQiJiS2tdww==
X-IronPort-AV: E=McAfee;i="6800,10657,11460"; a="63121092"
X-IronPort-AV: E=Sophos;i="6.16,227,1744095600"; d="scan'208";a="63121092"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Jun 2025 03:06:41 -0700
X-CSE-ConnectionGUID: Gx4Q5acBQaOyv+cdq2uoIA==
X-CSE-MsgGUID: etaVTB/aRtCNbd1GAkiaoA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,227,1744095600"; d="scan'208";a="148065204"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Jun 2025 03:06:41 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 11 Jun 2025 03:06:40 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Wed, 11 Jun 2025 03:06:40 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (40.107.244.79)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 11 Jun 2025 03:06:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tSj1YUbyzZgv1HN9WEMakULhvg6tJAzff4mo/ZDFOeUU+iQemTZXGzgpXTSCHBvF8Qhp+k8j5l+Bsjc0Yk9RnRaleG7bEGBV3W3rawUIRfzyFdsylDx8V8Ll0jzFoey3oMmwkVRPS8wqYJRG7YePoYj5xs4esmv9JYbfcF2U8XN2sMdtomxS4L94pF1UZqmnHB6fdnSVHa0Pzef4zAZrqlmDp54t9A8bN1TVnYhlHJTdBuvKUfWbdPhGw3mI1BiEmxa6VKFm8LqkgT/+5Eugsu5/k97cbBHwwcAsrl8oTMjAt4gwcQ7F+JSUdBJadLf/WfTGsCZ0YOhIIGas+NkY5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RY65XEidzY4DThkjm+yWPSrC3Ecl6tHzbyb0kva3Wp8=;
 b=NiK29B5n07W+eWE/1lCJfLJmnQjvJFT628MxSnTt7S5PSNBDgE6HEmgeMQ1PWE74OVZR6DXQLjL63a2fPmlMr+WxOtaWtOksjBFPoXUEyN/nFViX9Y9oROaF9COqAeymu2/L/+ZnXr2Y8eFIPwt+zP5FPxaAs8gDcuGGpfDc9LXNwcQPOKzPnrZIE4CnnzAEBIzdaz1ndmjEL5Dsb5gZqM0BRfa+doswkZ2DyoO+FeUcMzX24VGvG6iNTmsQQpDSzHiD0EV7ThRm+OhDAfl464uLl6DtYqzSV8kl9l6qzS0GoOtg/kH9ltPO69stKD0fTQSfRHjzu1FxEak7Guuu3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12)
 by DM4PR11MB7349.namprd11.prod.outlook.com (2603:10b6:8:106::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.29; Wed, 11 Jun
 2025 10:06:37 +0000
Received: from IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13]) by IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13%4]) with mapi id 15.20.8813.024; Wed, 11 Jun 2025
 10:06:36 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: "Liu, Yi L" <yi.l.liu@intel.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>, "eric.auger@redhat.com"
 <eric.auger@redhat.com>, "mst@redhat.com" <mst@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>, "peterx@redhat.com"
 <peterx@redhat.com>, "ddutile@redhat.com" <ddutile@redhat.com>,
 "jgg@nvidia.com" <jgg@nvidia.com>, "nicolinc@nvidia.com"
 <nicolinc@nvidia.com>, "shameerali.kolothum.thodi@huawei.com"
 <shameerali.kolothum.thodi@huawei.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "clement.mathieu--drif@eviden.com"
 <clement.mathieu--drif@eviden.com>, "Tian, Kevin" <kevin.tian@intel.com>,
 "Peng, Chao P" <chao.p.peng@intel.com>, Marcel Apfelbaum
 <marcel.apfelbaum@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, "Richard
 Henderson" <richard.henderson@linaro.org>, Eduardo Habkost
 <eduardo@habkost.net>
Subject: RE: [PATCH v1 02/15] intel_iommu: Optimize context entry cache
 utilization
Thread-Topic: [PATCH v1 02/15] intel_iommu: Optimize context entry cache
 utilization
Thread-Index: AQHb1srx8KBRZWY3jE+gRF83S3+bB7P9nMkAgAAl5iA=
Date: Wed, 11 Jun 2025 10:06:36 +0000
Message-ID: <IA3PR11MB913640374E35567AA052B6DD9275A@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <20250606100416.346132-1-zhenzhong.duan@intel.com>
 <20250606100416.346132-3-zhenzhong.duan@intel.com>
 <a36077a1-9eee-4c3b-9365-1b7a9dac3b41@intel.com>
In-Reply-To: <a36077a1-9eee-4c3b-9365-1b7a9dac3b41@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9136:EE_|DM4PR11MB7349:EE_
x-ms-office365-filtering-correlation-id: c8aec4e2-8e86-495c-9a5f-08dda8cfa6ec
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|7416014|366016|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?dWNMRGxSTjhoRnNMZnd4S1M1bURoblVTbXppUFlmanJJaVpzaUVlZm5TYjBU?=
 =?utf-8?B?OXR5UE11NlliRHNRYUNlU2h6U25kK0FuSGRoWUU4V1hEQXR0dlVYY1RLQkY0?=
 =?utf-8?B?cEdSN3l4RjYrSHRoSjhRTzBxNmFtV2lGYmM3SjlQZDB6d1RrdlNCYXlyZWNQ?=
 =?utf-8?B?QVYwOVcwbHhvUEU3aDQ4R2tKTUdOOU5QaHduaDVuZUhFMTNmMWpZTGR2c1l6?=
 =?utf-8?B?YkJtWlE2SW5wQm1LVDNHejlDYkVkNC82Z2d3MHlMWWlqWEhYRUk1RlRZTkQr?=
 =?utf-8?B?YVZZRVlMUi83VUlzQ09QdER0cVVOdEUxVURRY25QaGVXZnBmS1MydnVUZHda?=
 =?utf-8?B?bnpHZE1HeEdvMlU1RzZmbk5DeFVkSUNjWXVoSUprNTg5d2tnWEpOSFJ5TGdh?=
 =?utf-8?B?OHF3d2xRQlp5dDhKZHlOQ0Y0Y1dZQjZrODI3UllYOGFuTElzTnB4YVFLQjVG?=
 =?utf-8?B?T0lYMSsvUXdGMmhpc0hjUUMrbHVTbHF0ajE0MjN5cTI4N2FyUjdRdVJUeGZX?=
 =?utf-8?B?SEFOMTlnMFRZNGJLcktDdUtoN21vWVh0d1lDVFNOQ3BHbVFveUt2aE9vSm96?=
 =?utf-8?B?VjM1eVRmUVBoNjdDQytyOVpQb1JVLzA5WG9EOXRJZEduRWNWZ3FiSG9MaUx4?=
 =?utf-8?B?dUlLZkUyaDJaN1J0V0lyNEpJN3RmM2tqTFhUUjBGZkxwbzV2R2JYZTJoM2lY?=
 =?utf-8?B?ZnBBY1lraXBwV2U2M0ducWtRa1JUNFByN0hUOGVxZzRISm5zSFBJZnZaZ00z?=
 =?utf-8?B?S0lTNkJuUkpXTlRHMXNPRFFkN0JpcFg0VGlOeCs1aG9UVDRHQlpjdW5qSVNj?=
 =?utf-8?B?N1dJcTZTYjdEVzgzVFFIU2RjWVZOa20zRlZEMnhHbWt3RUFOTDdia2ZWWm1j?=
 =?utf-8?B?UzBscHJoU0h4d3B6SG9SeDJ1RDkrQ0IzS3plSXJOakJ2LzVUdEo4b0I3R3Ez?=
 =?utf-8?B?b284NytQYmx1akJLN0l1S0hZcUFrTjIwN0E0K2JpL29ZMXg4NjlTcUhtbWdh?=
 =?utf-8?B?TkdyMFQ1QU4vMFlEcHFKMnRoT3JtQW1uZ1dZZnFOamFFR29lYm1FY3JtRGxk?=
 =?utf-8?B?K1lZa0E5Y3ptdENXakVOT09jNlNLVHZxY1ljYnhzRWxrZ3RscTlIbGJBQi85?=
 =?utf-8?B?d0hXWHpzK2pOcjhFdzUyOHp6b2xZRm1aMXZlVlZLMjJpWlpVNithYXMrOXZ5?=
 =?utf-8?B?dytkNUkzUE8zRnJGbE9lSmYxd3U1WisrYm9qKzh0Y2R0K1JPYlNuSG50MGtE?=
 =?utf-8?B?TTFwd0Jtc2FucXlzdWJMWjZpbWdkNFJjUkFNNFlPSnNxNTRZZEJwU1MwekdK?=
 =?utf-8?B?dXcxT3owVGhJa0FvSlRIckVqQTlMRUd0NUdVWnNrK2prNHZncmxueER2Umo2?=
 =?utf-8?B?d2xYSU9mZHdEMmVMU0thRUhDcTIrMVRyV293N0Y1OUNqUm1LSFpqRmcrUDFW?=
 =?utf-8?B?bGEwbDhOSnJRanJRS2d6aGNHd2tsc09pTlQwaVFmZTlHRXV1VUFhWjN5RWV0?=
 =?utf-8?B?TTlNdE4wL2NhQjhRaEJjS3c0bTJMMk5SRC9WOGYwaEJDUm9LQlR3dWJYczdN?=
 =?utf-8?B?V1JXeGhxWkhYWmdybFlGclUvdEhaakJkdHFwNnNlT2ljSHdhUWdRRjZMYVZk?=
 =?utf-8?B?WFFvT09ldHJjaXBscWIvTk1qaWo5QzArYnBzWDdGcTZ2OEhWSW5NMWlKM2Rw?=
 =?utf-8?B?Z0dzVkhjY3FLcE05aFo4MXhhVlNxaC9HaWtUcCtTYjdIQmcrZmswOGJ0bEVU?=
 =?utf-8?B?VVBtRDRJQ1ovUkZoNW1aZ3NmUG5NcmR4RGxMcDNSNFkwTWcxUnMydE1QckdW?=
 =?utf-8?B?b3pHTCtxVFlDK0JSU0pBVTNVVUlYM3lVdzhQZGFnNTlrS3c5SXhGVmh4cnkx?=
 =?utf-8?B?OVZSU0dFQSt5WS81QlQzVVJ5dVoySFBGS3kxRTViTmxTcTRpVFA4UTZNZHVw?=
 =?utf-8?B?dFduelI2OXB2SzErOGlPY3NXVDJBek0vS3A5ZGdnVnhjTStkUzhGZmRIWjRv?=
 =?utf-8?B?T0dnRTJ6ZUNnPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9136.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bTQvbmg1MEp3MHlENlRSdncwMUsyRVZTVVBGYXlVSHd2U0ZvTWlHNFpra0ta?=
 =?utf-8?B?c081S21zS0huQTlKTG1CbFhLRUdEU2hWelNlWUhWVGpnYllIblM3UEQ0ZU9I?=
 =?utf-8?B?bXpIUGJseHNSd05UaXdFN25EYllDWkRSZ1ZIRzdheHk0cEpxSmtpT2gzMXBL?=
 =?utf-8?B?L1lvaEt5R1kzSENsMnVDWmRuNEJBL1BtZ0tKTnk4VExRdkFNOEQwUzR4WHZk?=
 =?utf-8?B?dS82MkxCNThVYTQ3czd4b2dvUWtjNHhNU21FeDl6eDhLbkdyV0ZXSWpvWWVz?=
 =?utf-8?B?eVlXYWVRTWlxTitQNDdyVEpDNUhPSnl2RXdCUFgyNHRGQUdyRFFvUVZyMVNF?=
 =?utf-8?B?eDE4VkE2UGFzZ2ZuL3dNbERHd092dGdYcmNNU3Vyc0FmU2Uxc3dzYkNzYXRi?=
 =?utf-8?B?a25wNTYwTnAraG92RjFRQm9OcEFwNHFhR2E4VFB3SkdBYkxidi8vNWhjRHlS?=
 =?utf-8?B?UzJ0SFVJaHdhenBZZXNMRytuN0pLRmttUXVvcnR6ZWJlRXYzbHBjK01IdVpH?=
 =?utf-8?B?Qm0yTUs5bGtMMXNNNFdwejdGQlFnZHhxejBodHJEVjFEVXJtMEl4Z3N6UkYw?=
 =?utf-8?B?Qm1MUzk4cVVwUWw0VG1idVdSMjhhWGZMbmVVazZYZ0gwTWZWemxpanJrN25N?=
 =?utf-8?B?Y2JkTXh1ZVV4V1VqZkRMU2wreUhCSnpDdEFMQTQ1c3hRRkoxZmt5NWFkQzI5?=
 =?utf-8?B?RHVIa3ZPUnI5Z0duZ294aDVrT3pNaE5oZ1VxemMzSDVYSXkwS2F4cGJzOXpY?=
 =?utf-8?B?Q2FSNVgwM1hMYzdOaUtlNk94VUlRVVRpS09qd2hEbVpiaVl0bmw5ZHJMSmRI?=
 =?utf-8?B?cUdQcE1xRkFKZmpqc3V0OXdLNGJSWGhjL0dEMG1qSmdCMEJLbkVmcGRWOVlz?=
 =?utf-8?B?dXlMaTR5MWpFVDU0QTVBWVFFcFhNam5JY2RmTW9zMVhERG1RdHJSTmh0Ukoz?=
 =?utf-8?B?M1lNek5GNlZETU1wNzJCN0ZPbU9oOXVGeUFJbCtjVVIzOFdjWlhGU3lGb3lo?=
 =?utf-8?B?UktzR2VmcTArV3pPckNiVlNpRjVLRzVEd25QWnBTOEthekNobndTUStqb1Js?=
 =?utf-8?B?dGNvQnJsR2ZtY0dDMi9mbGRXVEVlclIxc1pKUy9hL3gwd2FYREZUWnNPeVlN?=
 =?utf-8?B?YUtMVzJzbjFWcjg5TmRYK21naHJ0NFNTY1hhQk5ibDZ4L2Q1Wi9CL1ZBMHhV?=
 =?utf-8?B?bUhQQ3ArekJtNmgzQXVjVGRLWnZTL25JOE5lNG1YaTc3bzJsNzhBUkIzbjhv?=
 =?utf-8?B?cEY4RHRmK2VFWTZqSlhjWkxhYXhySGxiWHVxT0trOU8xeGNlZVVYb05XTXBY?=
 =?utf-8?B?QUdYMTV4Z0NUUThHUTE2bjFUcnliUFNSb24zcEc5UExocmFhVndtQWJpNHJt?=
 =?utf-8?B?aXVGcGVGaEhvekUxMzdxcVlSd0dEeTJYOXZKTUVqaHpSMitkRGpLYmJqaHZz?=
 =?utf-8?B?cjRQRWZLbUtWM1lYbGpqYWxkRmN0Qzc5aDcwSTEvVG9QYWZsYzE3OERZWmtX?=
 =?utf-8?B?NkV4aDhzREREQmtra3hiK3cvcEhheHJDaXlaZUdWSmluYitoaDlNcHR5Uyt3?=
 =?utf-8?B?ZGxWQWVhUStuZW1XOGNkeVBkOVB6Rkh4Z3VuU0RLRUNENk83VFhDQnNpUldH?=
 =?utf-8?B?ajBwNURLNndOWjY5UEgxREQvcVBZb1h5M3g3SE8zVEhZdCt2dzBKUTgvbzNv?=
 =?utf-8?B?WDRKdzI1S2kzWkNnZCttSW51aGI4SmtaN252R3p4NHQ5NmwySURKWHFsTlFm?=
 =?utf-8?B?ek90YVk5YjY5djk2UVlhaFRsT0hDa1NHRGFmR3k5czdTc1F5Q3c2czZRYU9n?=
 =?utf-8?B?QVFmZmZWVWlzMndGUFRRZE1obkhGdm42YjBvZVQwbk5sME5FWmFwa2ZpbEtr?=
 =?utf-8?B?MVVaMDVxTWRTaGo0bkJYK1hEcmhWVkpLa1paZFNvUEZ2YStqVmI5OXpSSEFD?=
 =?utf-8?B?OVdyWlo1UktUWmxEOHJQcVZNRmQ3WGFZUEJnaDdYN0U1UlNqUEVlbjhtcVI4?=
 =?utf-8?B?NmM0dmlIQkZwSm9laktVSUJSeWp3V1VwUStsV2RsbGM4OTYvTEdMNDdrbkNt?=
 =?utf-8?B?WlVJWlRPRWN4eU1mUk5UVyt0Zm5qbEhLQkxLbDl2dnhVdGZtVlpGQzd0aW8w?=
 =?utf-8?Q?8ru6zQFJIDUDQ3qIpWD5dLD89?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9136.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8aec4e2-8e86-495c-9a5f-08dda8cfa6ec
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jun 2025 10:06:36.8083 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: D/wcIUj0KnSbY3883JWFEeZ9hWAhLGdsh53+6Bm+3T2/wYM/tHFYCpOyC68B+f7mWu4CJ/rDKK8uAfWgbOhM+1JQORMDPCsQLsLSs4UeVtE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB7349
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.10;
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
aXVAaW50ZWwuY29tPg0KPlN1YmplY3Q6IFJlOiBbUEFUQ0ggdjEgMDIvMTVdIGludGVsX2lvbW11
OiBPcHRpbWl6ZSBjb250ZXh0IGVudHJ5IGNhY2hlDQo+dXRpbGl6YXRpb24NCj4NCj5PbiAyMDI1
LzYvNiAxODowNCwgWmhlbnpob25nIER1YW4gd3JvdGU6DQo+PiBUaGVyZSBhcmUgbWFueSBjYWxs
IHNpdGVzIHJlZmVyZW5jaW5nIGNvbnRleHQgZW50cnkgYnkgY2FsbGluZw0KPj4gdnRkX2Rldl90
b19jb250ZXh0X2VudHJ5KCkgd2hpY2ggd2lsbCB0cmF2ZXJzZSB0aGUgRE1BUiB0YWJsZS4NCj4+
DQo+PiBJbiBtb3N0IGNhc2VzIHdlIGNhbiB1c2UgY2FjaGVkIGNvbnRleHQgZW50cnkgaW4gdnRk
X2FzLT5jb250ZXh0X2NhY2hlX2VudHJ5DQo+PiBleGNlcHQgd2hlbiBpdHMgZW50cnkgaXMgc3Rh
bGUuIEN1cnJlbnRseSBvbmx5IGdsb2JhbCBhbmQgZG9tYWluIGNvbnRleHQNCj4+IGludmFsaWRh
dGlvbiBzdGFsZSBpdC4NCj4+DQo+PiBTbyBpbnRyb2R1Y2UgYSBoZWxwZXIgZnVuY3Rpb24gdnRk
X2FzX3RvX2NvbnRleHRfZW50cnkoKSB0byBmZXRjaCBmcm9tIGNhY2hlDQo+PiBiZWZvcmUgdHJ5
aW5nIHdpdGggdnRkX2Rldl90b19jb250ZXh0X2VudHJ5KCkuDQo+DQo+VGhlIGNhY2hlZCBjb250
ZXh0IGVudHJ5IGlzIG5vdyBwcm90ZWN0ZWQgYnkgdnRkX2lvbW11X2xvY2soKS4gV2hpbGUgbm90
DQo+YWxsIGNhbGxlciBvZiB2dGRfZGV2X3RvX2NvbnRleHRfZW50cnkoKSBhcmUgdW5kZXIgdGhp
cyBsb2NrLg0KPg0KPkFsc28sIHRoZSBjYWNoZWQgY29udGV4dCBlbnRyeSBpcyBjcmVhdGVkIGlu
IHRoZSB0cmFuc2xhdGUgcGF0aC4gSU1ITywNCj50aGlzIHBhdGggaXMgbm90IHN1cHBvc2VkIHRv
IGJlIHRyaWdnZXJlZCBmb3IgcGFzc3Rocm91Z2ggZGV2aWNlcy4NCj5XaGlsZSB0aGlzIG1heSBu
ZWVkIGRvdWJsZSBjaGVjayBhbmQgbWF5IGNoYW5nZSBpbiB0aGUgZnV0dXJlLiBCdXQgbGV0J3MN
Cj5zZWUgaWYgYW55IGxvY2tpbmcgaXNzdWUgd2l0aCB0aGUgY3VycmVudCBjb2RlLg0KDQpHb29k
IGZpbmRpbmcsIHllcy4NClByZXZpb3VzbHkgSSB0aG91Z2h0IHRyYW5zbGF0aW9uIHBhdGggdXBk
YXRlcyBjY19lbnRyeS0+Y29udGV4dF9lbnRyeSBhZnRlciBjY19lbnRyeS0+Y29udGV4dF9jYWNo
ZV9nZW4uDQpJbiB2dGRfYXNfdG9fY29udGV4dF9lbnRyeSgpIGNjX2VudHJ5LT5jb250ZXh0X2Nh
Y2hlX2dlbiBpcyBjaGVja2VkIGZpcnN0LCBzbyB0aGVyZSB3YXMgbm8gcmVhbCByYWNlLg0KQnV0
IEkgc3RpbGwgbWlzc2VkIGEgbWVtb3J5IGJhcnJpZXIgbGlrZSBiZWxvdzoNCg0KQEAgLTIyNzcs
NiArMjI4Niw3IEBAIHN0YXRpYyBib29sIHZ0ZF9kb19pb21tdV90cmFuc2xhdGUoVlREQWRkcmVz
c1NwYWNlICp2dGRfYXMsIFBDSUJ1cyAqYnVzLA0KICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICBjY19lbnRyeS0+Y29udGV4dF9jYWNoZV9nZW4sDQogICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIHMtPmNvbnRleHRfY2FjaGVfZ2VuKTsNCiAgICAgICAgIGNjX2VudHJ5
LT5jb250ZXh0X2VudHJ5ID0gY2U7DQorICAgICAgICBzbXBfd21iKCk7DQogICAgICAgICBjY19l
bnRyeS0+Y29udGV4dF9jYWNoZV9nZW4gPSBzLT5jb250ZXh0X2NhY2hlX2dlbjsNCiAgICAgfQ0K
IA0KQW5vdGhlciBvcHRpb24gSSBjYW4gdGhpbmsgb2YgaXMgYWRkaW5nIGxvY2sgdG8gY2FjaGUg
cmVhZGluZyBsaWtlIGJlbG93Og0KDQpAQCAtMTY1OSwxMSArMTY1OSwxNSBAQCBzdGF0aWMgaW50
IHZ0ZF9hc190b19jb250ZXh0X2VudHJ5KFZUREFkZHJlc3NTcGFjZSAqdnRkX2FzLCBWVERDb250
ZXh0RW50cnkgKmNlKQ0KICAgICB1aW50OF90IGRldmZuID0gdnRkX2FzLT5kZXZmbjsNCiAgICAg
VlREQ29udGV4dENhY2hlRW50cnkgKmNjX2VudHJ5ID0gJnZ0ZF9hcy0+Y29udGV4dF9jYWNoZV9l
bnRyeTsNCg0KKyAgICB2dGRfaW9tbXVfbG9jayhzKTsNCisNCiAgICAgLyogVHJ5IHRvIGZldGNo
IGNvbnRleHQtZW50cnkgZnJvbSBjYWNoZSBmaXJzdCAqLw0KICAgICBpZiAoY2NfZW50cnktPmNv
bnRleHRfY2FjaGVfZ2VuID09IHMtPmNvbnRleHRfY2FjaGVfZ2VuKSB7DQogICAgICAgICAqY2Ug
PSBjY19lbnRyeS0+Y29udGV4dF9lbnRyeTsNCisgICAgICAgIHZ0ZF9pb21tdV91bmxvY2socyk7
DQogICAgICAgICByZXR1cm4gMDsNCiAgICAgfSBlbHNlIHsNCisgICAgICAgIHZ0ZF9pb21tdV91
bmxvY2socyk7DQogICAgICAgICByZXR1cm4gdnRkX2Rldl90b19jb250ZXh0X2VudHJ5KHMsIGJ1
c19udW0sIGRldmZuLCBjZSk7DQogICAgIH0NCiB9DQoNCldoaWNoIG9uZSBkbyB5b3UgcHJlZmVy
Pw0KDQpUaGFua3MNClpoZW56aG9uZw0K

