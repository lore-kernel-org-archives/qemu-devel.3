Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4025FC10F16
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2024 10:06:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1kNW-0003Ok-Tf; Tue, 30 Apr 2024 06:06:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1s1kNR-0003OQ-Hk
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 06:06:21 -0400
Received: from mgamail.intel.com ([192.198.163.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1s1kNM-0001de-MO
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 06:06:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1714471576; x=1746007576;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=Pr4fn6btaSms2LcN+4z9Gx13e3w/kZt1lD751Z5wMAA=;
 b=QnSkWhrhkBbn/JvGPijvdA/fZ8y2o06GRFMjvwupmfZwlsbxHSgLIBpE
 4xX5IucVWulzo/LHcc5YvekRCyjV/tccmW64NNYmCohHkjuvazZGsRdt1
 Nxq7FuJblgwiUK0ubtOM3SKgRhknGD/IJiPoOnNwoIhB3qjTBVFhi53M8
 I8gVEDoAzliZu/++SDqyVye0TuuQIXwouNSAaFET+j3dF6BFbzC6L8ZY3
 9kOSqj+89vpFWVBTWKxqbPFUMn4+XvoP1BljOQgJ6CJCDuyl51R83bAPr
 5tDXxhhZxUCYvHEpJ4Bp3ZOsg4QoC0Pl+Abw/yPfpdQ5nsZucO1XLz+0D Q==;
X-CSE-ConnectionGUID: bUp5U4epSAKHm5+20/P+Ww==
X-CSE-MsgGUID: obf/+yusSBa/7mF9gS+rGw==
X-IronPort-AV: E=McAfee;i="6600,9927,11059"; a="10018827"
X-IronPort-AV: E=Sophos;i="6.07,241,1708416000"; d="scan'208";a="10018827"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Apr 2024 03:06:14 -0700
X-CSE-ConnectionGUID: nWiRFQXNSeWTejPBR17enA==
X-CSE-MsgGUID: u5DQXG7CRIWaZs1SXdEzXA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,241,1708416000"; d="scan'208";a="26496785"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
 by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 30 Apr 2024 03:06:13 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 30 Apr 2024 03:06:13 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 30 Apr 2024 03:06:12 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 30 Apr 2024 03:06:12 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 30 Apr 2024 03:06:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FeGRkvhT6Ykl9BuWQ53QwFkhfAvVg0DWscLc//JD1rJ+Oi3ra7OpKumSWevIm6U0H+zzSIbm/pxvIp+3+qwu5lE7/wJEv6/4bnFQZU/yHzzxJZrs1fxptyy8JQ62hU5JABTdeuK0q1OPDkLv+4AqcBbCT6n9HAHKwu38QS/h1QbBsbVYwYmnIKiHamzeZ/WEQdqaqhr6uTcPZIwxf8QM7Sez3KENUsiVmtgyXUBhAVCI8T0iatq393zsWxIhJ0KkUac5adAMjwO6encYkVgUh8tqvdJ7OW7IjKOBvJMgPRojB5gCFEX/Vv8MIm5W0J9BuI9Jclx7TM5GzTqo80BfFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pr4fn6btaSms2LcN+4z9Gx13e3w/kZt1lD751Z5wMAA=;
 b=DmkkrSi5DjN9b2ETOcf2vGrxQ+MzP0cGLsk/qibqj90oYzooeB4z/8Bs9U772gz8Y81kMPb8f8uoviKW1MXOByBE+PG1u2HYJTAiYt0Aw5hUX59BHw0O8W81bTzz+w+vHg5giw5XMSuMysNFYvCq/9YM9eLMeP+MZyzgoLEA1DT7GAlm6bVt143K3UGRq/6fa9UZXazx+l0LKKY2Rabn0eGGIDU6FZlaj78hwSTcf7/i/H/LuEooqn197u0F6olnYiWYw6R9XIeIpT8zlFnyAHBy65jR4ZPXU9Ec5Kn7d9/QtjSeKxo6rlioE/+KmvGRbFWNrd+DMmWID/jtMNcCzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by CYYPR11MB8387.namprd11.prod.outlook.com (2603:10b6:930:c8::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.35; Tue, 30 Apr
 2024 10:06:10 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::e4a3:76ce:879:9129]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::e4a3:76ce:879:9129%7]) with mapi id 15.20.7519.031; Tue, 30 Apr 2024
 10:06:10 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "mst@redhat.com"
 <mst@redhat.com>, "peterx@redhat.com" <peterx@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>, "jgg@nvidia.com"
 <jgg@nvidia.com>, "nicolinc@nvidia.com" <nicolinc@nvidia.com>,
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>, "Tian, Kevin"
 <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>, "Peng, Chao P"
 <chao.p.peng@intel.com>
Subject: RE: [PATCH v3 11/19] backends/iommufd: Implement
 HostIOMMUDeviceClass::check_cap() handler
Thread-Topic: [PATCH v3 11/19] backends/iommufd: Implement
 HostIOMMUDeviceClass::check_cap() handler
Thread-Index: AQHamgISrtOEAFqTuEa3yBgglOPHg7GAkSsAgAAE4yA=
Date: Tue, 30 Apr 2024 10:06:10 +0000
Message-ID: <SJ0PR11MB6744DC907835CB7FEF992EA7921A2@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20240429065046.3688701-1-zhenzhong.duan@intel.com>
 <20240429065046.3688701-12-zhenzhong.duan@intel.com>
 <dccbba66-57c9-45de-9fa9-beb7b528e0b1@redhat.com>
In-Reply-To: <dccbba66-57c9-45de-9fa9-beb7b528e0b1@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|CYYPR11MB8387:EE_
x-ms-office365-filtering-correlation-id: 13423a16-d45e-4450-6e4d-08dc68fd2911
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230031|1800799015|7416005|376005|366007|38070700009; 
x-microsoft-antispam-message-info: =?utf-8?B?YVlRVVcvRnNoT1NXMjIvUHpxOEtDdWdkbHhmY09FbFIwZnI3eElvQ2dXanZ1?=
 =?utf-8?B?Uk5xUmRHWDNoRStmdm9yZnVEVEdjclVrblJCVEFQYlFuMzU2TGZOVktxOFoz?=
 =?utf-8?B?OWVTdmdEZUVEd0dqQTZzL3dhcUhwUUh3WU4wVjAvT210ZGxlRngvUFdFRldF?=
 =?utf-8?B?aENCK2YxUTRwc0hmZFMya2pYa0Q5Y1VFZ2ttVlk2M01xcXc3cWJoTXQrV2k0?=
 =?utf-8?B?eDZucGJ0Z1JKeXJEbEJuQjlzV1NBbm9sNXEzR0txM25uUDdpZWFoN1VmN3R5?=
 =?utf-8?B?MkRnVFNJRmZ3SlJvOEk2NXVkcE5zQkcvUzdOSHhpV2tzNzJvRzZLd0JtZzVI?=
 =?utf-8?B?dlJhUktWMERkT1JBbkY0LzN3RWRSVzVUQUkyaUtNUWJmNlljRXZVWjNCL1Zt?=
 =?utf-8?B?QjVJdjJiL2pwWGFhL1VTbVhuQjRhUmlCRUx0L25BUVdQcDh1QXpXVEVZZUl4?=
 =?utf-8?B?Z0dPOFpaWWxvTVlFcGx6cjFCQ3NkODY1TjNpNllWVUVxeGhWM2dORnhtcHJv?=
 =?utf-8?B?UHlHL0t6aXNLT3grd0hXYVJqVnBzUzdJOXRtTThUVFJIRHB6NTl3aGpEWFdi?=
 =?utf-8?B?RU5FL2pqbmRoZDNHYk1XWjJCYXo5cEpQTCtIai9YMWVUaVk5aUg3LzUxbFhR?=
 =?utf-8?B?QitsZzNQbWxrVVRMRUgvYXlBOWRHQWxnVXFmbk9FQVNpc3VWcTFMM1F6dDN1?=
 =?utf-8?B?bndoc1ZaaHVaREc1VzZsUnJCeWxLS0tURnNPNHBkQmVzYm94Yno5TVB6U2xL?=
 =?utf-8?B?a0VFLzFvVVZTTHdxQmxBckdWaHNMWUYrcFpDT0ROc09KemV4WHNGeWF0ajcw?=
 =?utf-8?B?S3ZWYjZBTTJSWFZCZzV5Y0M1VkphaDR4U1YydG5EblpDbmlBd3h6R1dzQXVl?=
 =?utf-8?B?cVhKNW9uSWxTWURXMU1VYWNRakEvUnI3WDF1UkdmRjBubVkybGhVdDJKWEN1?=
 =?utf-8?B?RU5rQ2FZR3BKYjVRL2NXVDdwNEhZWWYzZHpseC96N1g3RHBxU0t4RzAyZXVZ?=
 =?utf-8?B?MThGOVk0ZFo0MWd3L1cvdkxQN0pLTW03YXpJREFocEgvYkVjRnNQMTZPMVl1?=
 =?utf-8?B?b0R4V3VyTHNPVmxDL1BNNHhCYnlIc1JhdW52RDNRZU9ZYWM0RDE2ZjVKSkEx?=
 =?utf-8?B?NjVnU1phZERqRFVEMGhpMHFudi93eE8zaUQwdVlyeUU3eFM5SDQrd0YrRHBB?=
 =?utf-8?B?RitHVlA5blYrK013TUJSVDdDZE9zdlhHVkxxOFlaVGEyeTl4Q05KRUdyTnlV?=
 =?utf-8?B?M3NiOEI1aW5nOEgrTHhTNTBIemR4SnZjUFVySTluRWg3Z1JaRTNOQ1o2RXkr?=
 =?utf-8?B?ZTZpUUZOTDZ4ejM0dEtpdlNKa05XTVFzNXZlczFxMWl0RytiRlNJaDBBbXBr?=
 =?utf-8?B?cGMvRlNxWWNSNUlqSmp3aGFFQlRhRUpLZWJuaFB1WEtSNlVvS083L3ZVZWR4?=
 =?utf-8?B?K1hob1dYQnJYSzdwOHRzZFZzRE9GY2lCc0ZKSUIxS21lYW1rcXFEdWkyeWxx?=
 =?utf-8?B?RXhvdk5YYUU0Nlg1c00ydUdVUE4rMW9PeUdIaGpOc3lJUVlpNXNKTWpidjdu?=
 =?utf-8?B?aFkvaW1QUmJHY0xKV1J4dnRpWkhXODAxRklpZzVnSEFMZ0gzdTM4Wmo4dlZS?=
 =?utf-8?B?aUM5bUtOTkkySzFscE82UGg0QTVsY3RoVGJvVW91RGMvbEkyR3M4L3ZxQUM3?=
 =?utf-8?B?b0l4cFZzWE9hazk2MlRvdHJZcmlaYThVWThLZEoyMUxNZjlSVjJkdlBQaTh6?=
 =?utf-8?B?TjVKb1VmN2QwRjMrL21QSEJQVENrWXNObEc1enMyS1ZHUUs3RkNReEdpYmFw?=
 =?utf-8?B?bSs4L3JLbHJ3cFZnc2xjQT09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(7416005)(376005)(366007)(38070700009); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eE5iYUh1am9qOFZFWHBEMnhOMmxkZ2dxbmtaQ1AwaVB1OHZpSmF1emo0TnFo?=
 =?utf-8?B?bWFpK2N1Y1VMb0Y5a3JCM1RkOWVrdGtPKzVLSEgvRzhWR0wwVzVYcDR0d1V1?=
 =?utf-8?B?aENiVWFmRzd1QTJlQU9SL1hpOGNtZVYvZXpzZ0ZlRjcvNGdyTFZjM0JWYk5P?=
 =?utf-8?B?aGNaak81eFFOQWlMYmZqWkJMeUNZaUZlUjIyOFpnSjE2amxZOERXZEVjSFZp?=
 =?utf-8?B?TERLN1RWSTlGSTlSSVljbks3VGRnQjlLRSt4WGp1a1lyMnJCYldMZ2UxK25W?=
 =?utf-8?B?SElmdjRiVkxsbFUweW9oNjl4eXdpTS9ENUNOVHFWdWFlY0VQQ05aSkU5b2w4?=
 =?utf-8?B?dnlrTGVmQWFTNWhYYmlMbGwxOEMvSi9rUWFDd1J3RmpNZzZtWEhnenhHdFhC?=
 =?utf-8?B?Q1RxV0tnMy85a3B2MnlxNDZFbTRlUDZKSEJvcnBxVW1yV0tqMk51SzJtcmQy?=
 =?utf-8?B?Y3ZHOEs4M3Q5dHlLYy9xNzVDa3AyS3ZPVktvM1BwZ0RjYkpGMFUvQk1Oak1N?=
 =?utf-8?B?Q1NydnVXdDltMGFva28xeE9JYS81QXJXV3lSdnVRK3RSZTlBMnRCTCt2Z1Rr?=
 =?utf-8?B?OXNhWGIzZm1vSlJPc004dCtERHBnTlFOemsvQVpSSWo5ZzJoNUlDTHpmZk5F?=
 =?utf-8?B?ZXV4QzE3RFk0T3VTTzdKcmQvYVp1WitJTldOUkZHTExDSi84WmJvampiaEpQ?=
 =?utf-8?B?OVVQSG9qY2lKa2x6YTlUUGtWSm9rYVk1TXdpZm5WVUNBRzlyY0c1WHozeXVl?=
 =?utf-8?B?SnU5SlZieWdvY1BZbnlmL2FRU0d4dnlnMUFCRXhnMjN6ZkI2c29IeGVHU205?=
 =?utf-8?B?VDVSYnBzd3lMNVU4Mk9janRHeS82cXpyR3ZXYS9QU2tKVU4rNUhmREtFUmRN?=
 =?utf-8?B?Yk9oR1JqMDE1V3ZsZG9LZWZMZVhQaEhRYWRQTmVFeTJtMVZ3bUhUbUN0Z1NV?=
 =?utf-8?B?K05oeDIzbFZkNFhRSFhRRG92elBhSC9jMXNUTkhkV2NjZmRIb0MvcjdjWEJk?=
 =?utf-8?B?eU82N2ZlRUpTN2RBeit2bUZNcnM4MUk4RDBRR1NwcFhQUVBsTzBwcmc3Q29T?=
 =?utf-8?B?dlB1UmVwRFFkZWptVjJONHhQd1hjNnJHa21QNmoxbUJCWnZMdnlvMGxaZ1ls?=
 =?utf-8?B?cStZM1dGOFFUb1pUM2U0NStxL2xNcXlaelZ3MzNFWmh2ZWJQQ01YLzBjRUlQ?=
 =?utf-8?B?YklsYUIrSW8xYUlmeCsvbkFPUVc4eW9lUjVKZU1JSWcyUVdYZHltZUU2SnRI?=
 =?utf-8?B?M1BBOXZhU1pWaDJGREtoMzVpOHdPWXExZ1g4U04xeGQxU2V6NzJZS0REeXRI?=
 =?utf-8?B?YmN5RjEyZmNFVVUvdnUwbTZITGptMmx3NXNSZ0FJTEtuR01QQWFDTWVxVDNo?=
 =?utf-8?B?QW9EOXVXdWpFTEFQRTBxWmM1TGxqRjB0aEdueGlBRnE0dmVJcXFuRmJjeFBW?=
 =?utf-8?B?Nko3aHFTRHNDMExWNUdvZzlnTFIxWlF1SEtXWCtoQTdoeUtRdFI5NWFrMXEz?=
 =?utf-8?B?bmxmbDlWZ3EwK1NWemlYQVU3UVdGcDIyQTQxNlkrK3dlSE14V1VZa2FGUVpB?=
 =?utf-8?B?OHp0dGQ5TnFZWTVscytIS0FCOVhrOXR3YVNHUlQ2Nnk2SXA5eDEwMHh1TVU3?=
 =?utf-8?B?cDh1c2J1aFVmSlU4WXhVVzZNT09iTCtFZHUxYWZvOXlBdCtKMTBma3QyQ2ph?=
 =?utf-8?B?Tjdzb3oySW4yR242SHBoTXRMcGtZYnpYVlVMR2x1WGE3SURZMzc2TnZKSVN2?=
 =?utf-8?B?L2xxdVFwYUxFZ25MK1MzeGswQnl3c1J4NVI2d09yTHpkZ2NVamlWN2xydUtR?=
 =?utf-8?B?STVtZzU0WFlvMTZMTnN6Q1drWTBPRTBMaTB4cmV1SzhLLzU1TGYzZ2FuLzFh?=
 =?utf-8?B?MG9ZOXdLbzNHYk5uLy9MQVdaMVp2c21odWVJTHNTTURuREdqNEdIcTlVejR2?=
 =?utf-8?B?eXk4b3l0ZDF4UHRWdWxtV3l1Q2tIdG0xeHBqZkFBRzk0Q3Vwb2lBUmNOV2VR?=
 =?utf-8?B?QmMyS0pDV0xEM0JUTGRqVzF4amdWL2VqUlFSMXp5UG4wQWR3TmlMTHZjYUdD?=
 =?utf-8?B?ZlRwbWIwVVYvdVRwb0Uvc1Y5bktOWVJvZ3dDOTI2Ullmc3p2VVA3bkQ3YWE4?=
 =?utf-8?Q?DxHqcIp7UdfTmMhKxWXtHB5Ql?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13423a16-d45e-4450-6e4d-08dc68fd2911
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Apr 2024 10:06:10.4571 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GnxgF7Pgyfcl0aMtY3ByBAfcnP0woLXUd0J1v7VAnXWiOZE6C7MwDW6xHvPfIjUVbNOgMbOM6aHU2pnhjrvallWQvsuSHP9sPo6XgC7quCA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR11MB8387
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.18;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.987,
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
IDxjbGdAcmVkaGF0LmNvbT4NCj5TdWJqZWN0OiBSZTogW1BBVENIIHYzIDExLzE5XSBiYWNrZW5k
cy9pb21tdWZkOiBJbXBsZW1lbnQNCj5Ib3N0SU9NTVVEZXZpY2VDbGFzczo6Y2hlY2tfY2FwKCkg
aGFuZGxlcg0KPg0KPk9uIDQvMjkvMjQgMDg6NTAsIFpoZW56aG9uZyBEdWFuIHdyb3RlOg0KPj4g
U3VnZ2VzdGVkLWJ5OiBDw6lkcmljIExlIEdvYXRlciA8Y2xnQHJlZGhhdC5jb20+DQo+PiBTaWdu
ZWQtb2ZmLWJ5OiBaaGVuemhvbmcgRHVhbiA8emhlbnpob25nLmR1YW5AaW50ZWwuY29tPg0KPj4g
LS0tDQo+PiAgIGJhY2tlbmRzL2lvbW11ZmQuYyB8IDE4ICsrKysrKysrKysrKysrKysrKw0KPj4g
ICAxIGZpbGUgY2hhbmdlZCwgMTggaW5zZXJ0aW9ucygrKQ0KPj4NCj4+IGRpZmYgLS1naXQgYS9i
YWNrZW5kcy9pb21tdWZkLmMgYi9iYWNrZW5kcy9pb21tdWZkLmMNCj4+IGluZGV4IGQ2MTIwOTc4
OGEuLjI4ZmFlYzUyOGUgMTAwNjQ0DQo+PiAtLS0gYS9iYWNrZW5kcy9pb21tdWZkLmMNCj4+ICsr
KyBiL2JhY2tlbmRzL2lvbW11ZmQuYw0KPj4gQEAgLTIzMyw2ICsyMzMsMjMgQEAgaW50DQo+aW9t
bXVmZF9iYWNrZW5kX2dldF9kZXZpY2VfaW5mbyhJT01NVUZEQmFja2VuZCAqYmUsIHVpbnQzMl90
IGRldmlkLA0KPj4gICAgICAgcmV0dXJuIHJldDsNCj4+ICAgfQ0KPj4NCj4+ICtzdGF0aWMgaW50
IGhpb2RfaW9tbXVmZF9jaGVja19jYXAoSG9zdElPTU1VRGV2aWNlICpoaW9kLCBpbnQgY2FwLA0K
PkVycm9yICoqZXJycCkNCj4+ICt7DQo+PiArICAgIHN3aXRjaCAoY2FwKSB7DQo+PiArICAgIGNh
c2UgSE9TVF9JT01NVV9ERVZJQ0VfQ0FQX0lPTU1VRkQ6DQo+PiArICAgICAgICByZXR1cm4gMTsN
Cj4NCj5JIGRvbid0IHVuZGVyc3RhbmQgdGhpcyB2YWx1ZS4NCg0KMSBtZWFucyB0aGlzIGhvc3Qg
aW9tbXUgZGV2aWNlIGlzIGF0dGFjaGVkIHRvIElPTU1VRkQgYmFja2VuZCwNCm9yIGVsc2UgMCBp
ZiBhdHRhY2hlZCB0byBsZWdhY3kgYmFja2VuZC4NCg0KU3RyaWN0bHkgc3BlYWtpbmcsIEhPU1Rf
SU9NTVVfREVWSUNFX0NBUF9JT01NVUZEIGlzIG5vdCBhDQpoYXJkd2FyZSBjYXBhYmlsaXR5LCBJ
J20gdHJ5aW5nIHRvIHB1dCBhbGwoc3cvaHcpIGluIENBUHMgY2hlY2tpbmcNCmZyYW1ld29yayBq
dXN0IGxpa2UgS1ZNPC0+cWVtdSBDQVBzIGRvZXMuDQoNClRoYW5rcw0KWmhlbnpob25nDQoNCj4N
Cj4NCj5UaGFua3MsDQo+DQo+Qy4NCj4NCj4NCj4+ICsgICAgZGVmYXVsdDoNCj4+ICsgICAgICAg
IHJldHVybiBob3N0X2lvbW11X2RldmljZV9jaGVja19jYXBfY29tbW9uKGhpb2QsIGNhcCwgZXJy
cCk7DQo+PiArICAgIH0NCj4+ICt9DQo+PiArDQo+PiArc3RhdGljIHZvaWQgaGlvZF9pb21tdWZk
X2NsYXNzX2luaXQoT2JqZWN0Q2xhc3MgKm9jLCB2b2lkICpkYXRhKQ0KPj4gK3sNCj4+ICsgICAg
SG9zdElPTU1VRGV2aWNlQ2xhc3MgKmhpb2MgPSBIT1NUX0lPTU1VX0RFVklDRV9DTEFTUyhvYyk7
DQo+PiArDQo+PiArICAgIGhpb2MtPmNoZWNrX2NhcCA9IGhpb2RfaW9tbXVmZF9jaGVja19jYXA7
DQo+PiArfTsNCj4+ICsNCj4+ICAgc3RhdGljIGNvbnN0IFR5cGVJbmZvIHR5cGVzW10gPSB7DQo+
PiAgICAgICB7DQo+PiAgICAgICAgICAgLm5hbWUgPSBUWVBFX0lPTU1VRkRfQkFDS0VORCwNCj4+
IEBAIC0yNTEsNiArMjY4LDcgQEAgc3RhdGljIGNvbnN0IFR5cGVJbmZvIHR5cGVzW10gPSB7DQo+
PiAgICAgICAgICAgLnBhcmVudCA9IFRZUEVfSE9TVF9JT01NVV9ERVZJQ0UsDQo+PiAgICAgICAg
ICAgLmluc3RhbmNlX3NpemUgPSBzaXplb2YoSG9zdElPTU1VRGV2aWNlSU9NTVVGRCksDQo+PiAg
ICAgICAgICAgLmNsYXNzX3NpemUgPSBzaXplb2YoSG9zdElPTU1VRGV2aWNlSU9NTVVGRENsYXNz
KSwNCj4+ICsgICAgICAgIC5jbGFzc19pbml0ID0gaGlvZF9pb21tdWZkX2NsYXNzX2luaXQsDQo+
PiAgICAgICAgICAgLmFic3RyYWN0ID0gdHJ1ZSwNCj4+ICAgICAgIH0NCj4+ICAgfTsNCg0K

