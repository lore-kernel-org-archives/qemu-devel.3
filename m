Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E8CFC54F30
	for <qemu-devel@archiver.kernel.org>; Tue, 27 May 2025 04:23:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJlq7-0001iW-Hh; Tue, 27 May 2025 00:22:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1uJlq5-0001iN-Tu
 for qemu-devel@nongnu.org; Tue, 27 May 2025 00:22:57 -0400
Received: from mgamail.intel.com ([198.175.65.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1uJlq3-0006r9-Bs
 for qemu-devel@nongnu.org; Tue, 27 May 2025 00:22:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1748319776; x=1779855776;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=dSmoEQCZZWrC8kDP5GT1MMrzngTCXYW2PxSQANba01g=;
 b=ady6sYi7MTyZsPlReQG4HQ6Bc7pje2j/XO6NYT7wO8/ae36Hkx7nDOb1
 c0jXPcFC8uwXZgO9LzSlBWI3v7WaR5RhdxmFPBkmC+1T+gAG7X8Lz1Jj4
 VgDhF8GJ6GVL/aut9lIgkEBcaaAjks8h5xSo+LAKgt+EzGmVwU31ztr5a
 MID/uya/hzIuDY8C9sUiF37T/iBvpOwls8HbrXl13ctDkS518Phn79qqf
 i20mpdtbwCkM83+YAOdKi1UC4w0WLXIgr7/nQnNsOTswT8LH6t0W42Iq4
 1H7RkxZEwsDy2lZsnzOAcwbJZgFx/ZM1AmnWBFxOG9Vtzv9EcpOC+Xq5x A==;
X-CSE-ConnectionGUID: 1A/jR+grTD6qzsNqEWJcYg==
X-CSE-MsgGUID: Niy6u7r3RP+6V137wNdw9Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11445"; a="50291810"
X-IronPort-AV: E=Sophos;i="6.15,317,1739865600"; d="scan'208";a="50291810"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 May 2025 21:22:53 -0700
X-CSE-ConnectionGUID: SnwZW8FOTC+yMKl0eKCJhA==
X-CSE-MsgGUID: vBKBoPxdRUug2eN7oZP9rw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,317,1739865600"; d="scan'208";a="142585523"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 May 2025 21:22:51 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 26 May 2025 21:22:50 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Mon, 26 May 2025 21:22:50 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (40.107.220.49)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Mon, 26 May 2025 21:22:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BZWuMPSV/JcjBmTzjSDKR04uWs/d8rN+96i3gmWv3yO/fgyy7mQowkuo0q4tUXDN6fhyWZfOQI7Wz8ryrwiVE2csfUfn8POrVVBpiGYze5B5Z0AO6fitwbVwhZa1m3cRP9rVwZxuMgQqScu04Uj/IEP1xFEwmPtmNTJeNcftad+bGJryRkYJfvwKA8wEnuGUmYvDNbsjvid4rF70ac7QjeFp66OsG5sQCf/7HjXnu+/bp5dllRplYj5ZSU6KGo8/+ArPaaWLzaMWCFm3qhms1jwdH7NFwHzDU5J+liJ/barHHDwd2cT3NlLZcOwS0RE6J584513oms9CL89Yy4KvzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dSmoEQCZZWrC8kDP5GT1MMrzngTCXYW2PxSQANba01g=;
 b=RXYpWDtK3Nbhzat2zs96YNOl8uxog7wsRB+M7GYKxwDsL8fNeAFsqPZna89P9qbaDC1XiUi9bWbC2biXEJ2g90SAYP52hGV/ppiJZOfhBZLqz/4W4un6R+rE1aSp87Wvn1zanWjx56t8Dl9pd7AktZEgXAPOr/tA0guhtpT14Op4Tzjab5Lrb545xyQ8WQK58WaD6h5cahKJZ3GfhgV3lZstoYvX1XGQ8ybl12kA+h2mrZtfirCuw7CPTD6xQnDYcyfFKvkam9ZsYXwgiUveSV0Z1KavbR9uertUUOnS6NlCY44SHh6qySCiP9olo1980qpnUHGmaeEmTdBUEbFpYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA0PR11MB7185.namprd11.prod.outlook.com (2603:10b6:208:432::20)
 by SA3PR11MB8074.namprd11.prod.outlook.com (2603:10b6:806:302::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.26; Tue, 27 May
 2025 04:22:45 +0000
Received: from IA0PR11MB7185.namprd11.prod.outlook.com
 ([fe80::dd3b:ce77:841a:722b]) by IA0PR11MB7185.namprd11.prod.outlook.com
 ([fe80::dd3b:ce77:841a:722b%4]) with mapi id 15.20.8769.025; Tue, 27 May 2025
 04:22:45 +0000
From: "Kasireddy, Vivek" <vivek.kasireddy@intel.com>
To: =?utf-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Gerd Hoffmann
 <kraxel@redhat.com>, Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Frediano Ziglio <freddy77@gmail.com>, "Kim, Dongwon" <dongwon.kim@intel.com>
Subject: RE: [PATCH v4 4/7] ui/spice: Add an option to submit gl_draw requests
 at fixed rate
Thread-Topic: [PATCH v4 4/7] ui/spice: Add an option to submit gl_draw
 requests at fixed rate
Thread-Index: AQHbxUP6aaIiI/I0UkeNQY/JfMt5TLPh7eSAgAOZSiA=
Date: Tue, 27 May 2025 04:22:45 +0000
Message-ID: <IA0PR11MB71851EB2D94D13FBC3787AA5F864A@IA0PR11MB7185.namprd11.prod.outlook.com>
References: <20250515024734.758335-1-vivek.kasireddy@intel.com>
 <20250515024734.758335-5-vivek.kasireddy@intel.com>
 <CAMxuvazk2UMmneKa3=WSyXpqj+GOzFLzSFJ-stb8X4qN=0p3NQ@mail.gmail.com>
In-Reply-To: <CAMxuvazk2UMmneKa3=WSyXpqj+GOzFLzSFJ-stb8X4qN=0p3NQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PR11MB7185:EE_|SA3PR11MB8074:EE_
x-ms-office365-filtering-correlation-id: 74cfeb58-b98d-428f-af66-08dd9cd6216b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|38070700018|13003099007; 
x-microsoft-antispam-message-info: =?utf-8?B?NzUxNVY1QW9rWHNBUlRCUDVhcEJnbHd6eHdJT3ozNnRtV0IyQ1QrblZlZFFo?=
 =?utf-8?B?blM4NmhuWWNsSy96R3JiMjgrVDBKa2xJY1FaRXl6ZDdsb0RtQXdIU3pUZXp5?=
 =?utf-8?B?UWE0TVJFUFdnVm0wajBIclREQkxGVTJ1T3psMTdhMjZGOU45Z0RJWldFQksv?=
 =?utf-8?B?RklRMmVueXUrTUtuWFdEcTJnZUdNUjF6d2o2eU9XOU81dHhnOStpUEFudS9P?=
 =?utf-8?B?NE83UFFIbTBFUlcvaFFNZGtnTmdHRWFyTXFReTZsWXNiODdFUXRRc3BxekZv?=
 =?utf-8?B?RitXTDhzUzBXNXczOWptc2g0cVVwQ0FmNHVlS1FsbHJhZ0dVd1prVjlsV2hS?=
 =?utf-8?B?VURYUVV3a24yL1hROEFicFllbnFNK3ZaRkhJVEVFd3hsSlFPOGJyaGRGOVNO?=
 =?utf-8?B?OEZzWkpTUENTbjZpUmhkY20zWlQ1TUxKc0hFaEpFT3krNE81TDFHWVRFY0Fu?=
 =?utf-8?B?QTZHbFJlb0hsa3VHODlsU29LRHZDMzRRaDZ0S1dQdk1ub0RQU04zM0RTVTdo?=
 =?utf-8?B?QW9xSnpFSjRWVXh3dkZOOTR5aVFleXhtMGtMRUpXb0ZkaXh5dmpRREloT1Ew?=
 =?utf-8?B?YTF3Ri9lM2drN2JqTkYyeWJ0K2RhQUFHVm1kbzNqbkw5cmV2L1RhWVVoclBY?=
 =?utf-8?B?dDdjUnc5YVF1SFArcjVlWDIxZERXbDdsdTUxcXhkRUkzemRIOXdydy9UUVVP?=
 =?utf-8?B?cEZDdzIwNmZmZW1VZWw3eGl0cmV5ZTdVQnozZlpxWktXUUNVajNjMzZwNmhy?=
 =?utf-8?B?UTl5VFlqQmRsRHVYcTBqK2xLZDZ1UFByVEd6ZUtLdTY3alRlYkk0aGpIR1RY?=
 =?utf-8?B?ZEhtMXdXQ0tjczFmelBGNkVuRzRzdE9ZVG9TSjRjazNLUDFZMWcxUjdxK0xh?=
 =?utf-8?B?eUtWajQrb2huQWZPRURVNHo2aEpHNUhQdVpOZjQxalFsVGpYTTV3Z1I2dTBW?=
 =?utf-8?B?SmVUSlVUQ3RmS3F0WmV4TkJkMnMxRzFSMGFwMlFOaGpITGs5TGdPZ3FCRnVw?=
 =?utf-8?B?Rk5QWEpvUm50TjBrUERhbjNJTjhOcWdIVnQvNkpkazkxdWVZbG5jcjYwRENs?=
 =?utf-8?B?dmVQUnBDQWljbTVjS3BLQVRRRmRBbTRha0I4emo2eXYrOS93SDhBcUpzZmZN?=
 =?utf-8?B?QktwSDZyVDdZK1kvTlN0L0VWV0g5T1dqRFVNclNTa2dsdmlSK3EyODFMOXdY?=
 =?utf-8?B?NnFCOWM0Nmh1cWpNWnV4b3dmYnRxOG80K3hnenc4eFJhMUxmeWRjdzRucm5H?=
 =?utf-8?B?MFVtZHFhNjhGVkxYWjNmbWZhNHcxMDZudGpuemZSbjRTUGZIZi9hazgyQUlN?=
 =?utf-8?B?enNwOUU3Qmx3MG9ReU1VNHZHd3dVV0haMFdINEs5RVB2dCtqbTRrejFPNmFR?=
 =?utf-8?B?a1RhYW11WVl6eGF4WnhxRmF0djA5Smw1T1FOWHBJRlVZNmFTZjIyR1diRnBj?=
 =?utf-8?B?RUpXNDVmeTFwRWtWdG8wSWRwTmViYTEyUVVVTHNFY2VtOTlweVZTdVE2QjJF?=
 =?utf-8?B?OGRQYkdqU2lOV21DQXJBL1d1b0VUVGdBeTJVQWZpeXQzMWxzZUxCcHpXbXdG?=
 =?utf-8?B?MEtQcjcvVit6cDBQcGlHVW9URnd0cUVyR1lOTnVTcU11aDd4VWh4S3BQbnRr?=
 =?utf-8?B?T2ZVRldaNnZGeW51SkVJVTZJVWhtUVZwUEFrMkFqeFlnQUFBS2FNaTQ0YmZK?=
 =?utf-8?B?RnZrM3RlSW9BOEtMNVZJMUxhcmFaaW9FSDBhVGNpNEIrRTVOYzZES1RQS05t?=
 =?utf-8?B?SHNxcjJ6aTFqdW8zd0p0TWNoQUpoMm1lbVlia1BHWkt0OWoxNVlGTTFmUjlL?=
 =?utf-8?B?aWFjckhNVGVYOFExRlNYazcvNnFHWkF5ZzNzZ2pkb3UxdW5aT1g4REgwbkRm?=
 =?utf-8?B?U0NpR1VsbzBSbGhhSHh0eGlVbzhXdXovQVpaZEVRYm85cmpOcURBS1BIUUoz?=
 =?utf-8?Q?oB61Oq+2ur0=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR11MB7185.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018)(13003099007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SWhCZ2NxNGZoMk51Z3FrWFFucjEydWQ3WjU2U0pwOGc3Ky9JYzRzb0hLSEt1?=
 =?utf-8?B?NURhU0VxTmtHOTllUWxyWWV3eHE5M0FBQi8xZzBCSjc4bUp1bVRYdXJzNWJW?=
 =?utf-8?B?eEVwUThZSjhtT09YV1VUREtIWUlpYXozVGZyMWtYWjdwbTNabWUvRFUya3gz?=
 =?utf-8?B?VWttNmhQM2NjVHF3WG1Pa0NTbWRzUUprSWF5ZlRmSWdya2dHTFRqa0ZPdm0v?=
 =?utf-8?B?US80cnlXRlM4MWxYaU1mK0lXRnp0ZmFLWC9Oa0tKN1ArZXVXSG5YK1lXY3dn?=
 =?utf-8?B?c0w0NzM2RG10NWlYRk1nOGdIRWNqTGI1RE4wa01XMFh6cGVIWEx3eUdoQSta?=
 =?utf-8?B?alVjbWJMNUNWVjdjdjBwcFRYNDlseGJPdTZFeG5OSGc4cEZCK0dFcWJMNkgy?=
 =?utf-8?B?b2RnR1pydHZsUnRZOFN0ZTN3Uk8wNXc2K2w2YUF6U1dYZkZwd0F4cndJN1J0?=
 =?utf-8?B?aWR1YytyUU9sQ1pLMTVqUGtUKzB2d3E2U1hFVExKbk51Ty9yYnVyUERxMDUw?=
 =?utf-8?B?YlZMaW5KemRpc01aZUlKcXc4eVdidmxMTmpicXJXYTNCQndQUUM5YU0zN1o3?=
 =?utf-8?B?Sm4zcW95TWlPWkljOUYyTEd1SnV0VCtqMTFwQkR5c25oSFdVQnBCNldJTGtI?=
 =?utf-8?B?TnhibnIremNQNmZpdVo0Q1JKaTZLRDJuaFVQa3E5VUM1UnYxa1FEYXg4UmpQ?=
 =?utf-8?B?RTMzenhCOW1CNmFkL3hiNk1qQnRDM3ZoNld1NG5YOUtVeVdtbDFpblFFWmY4?=
 =?utf-8?B?Yk1aWlV4VjRadjdtSGxTTDRaY3loQmZ1M3k5NlpGS3hGQ2duMTg3aksveU45?=
 =?utf-8?B?UHRKbitiNlRYK0F0QkQ4UWVGY0FGWUVlSWllL29mYno3ZUg1cUhhOWQwZHZy?=
 =?utf-8?B?NEI0U1JhREYzOXMyemZjZ1k3ck5nT2NQYmZMeFMyWEcyb3NxZm8xQWtycGVu?=
 =?utf-8?B?M3FSOFZ4a25oeGlWU2c3VmRobWF2M0NsYzQwdlpBNk96OHVDbEhEKzRxQjcr?=
 =?utf-8?B?TUdIUGJiS0FpRUt3ZzVkQ011QklwUThFRFZqbjNUOWs2UHFRN3RpdHRzZ0xw?=
 =?utf-8?B?OC9kNVI2dmFVL1BjMzdSeUNrRHdtbmlVVjlXSFpTRnVzcEhqRlE0VHVzWDFy?=
 =?utf-8?B?a2NEa1RvemJDR083aDBZb3VTcC9PK3JpZEdCeDl5WWhxeWpyOTJKZVlzNnJU?=
 =?utf-8?B?dlpYVGxXWUJaTHdxNVlhWlBMUUM5WG5hK2paMmwxc0t6cGJMdEE2VzFBS0RK?=
 =?utf-8?B?SlFuQmlmUHBicUxRcVpLVEJBUmJkbVBjRitFT0lCMWx6dS84Qlc0N29SeGNI?=
 =?utf-8?B?bXNPMHc2cjVka1NSNEVPdHMrd2ZBQmlNRlBEZ2ZiY1dIZmNEQXJvNmd3djVt?=
 =?utf-8?B?K2VXcGVjM0MxVlZhaHNOTllKbkNSWFdDVFZLUVhOcE84QmpPdDhRNmt2cXB2?=
 =?utf-8?B?WWU1NDkzbjJiR3Roa0NPeXJDZUl2VjNFWjUxWk1OTkpPWEZ2UU1kNmRwV1da?=
 =?utf-8?B?a3Q4WlM5UUFUME9qWUVuQ1UrUG56RURqVkZYOUNUZFg0QmRQTVFsZlFrR2o2?=
 =?utf-8?B?aEN5SE5iZ1VtSFc3S29rTWxYaGdZejRFdkw1ZTVjVTMyQkpxMkZaSWd1KzVm?=
 =?utf-8?B?MWpxSXZwRm9PLzFndTFuNXl3dmsvaWhKanJzZGpIekJVMWJEaWo2alBjUG9P?=
 =?utf-8?B?UG8yWGN5V1p2UGdNaW9Jc1FTR1R1RVVoLy9JQUt2NXBDa0pTc1NkWk9XYW5N?=
 =?utf-8?B?aEJNNlZpUEZFRnRzWWhTK0hON0NDeGFwY0x6VHFXaGNpc0NXbWVqRk84bDdQ?=
 =?utf-8?B?UzA1VXdrdE5kREpQWFZNRHAzc1ZVL2p6MU5pdjh3WDd4akNhK0FnRFhqdFFp?=
 =?utf-8?B?YWJTNWhaNGQ1aTUyYlVLVHgxTTE2aDNEYTM2bnhuSmgyaFU2cVlVVXFZclNa?=
 =?utf-8?B?Y3RnTUxMVldHYW05QUtRTkxVZ1NKYXZDZlJtN245N0tMdHJtOWZMQ21ONm85?=
 =?utf-8?B?Z1JiOUkzd0JUMzYxQXVWTSsvZXZJZnJzeElVMDJnRUNySSt6WHBsZGorUkx2?=
 =?utf-8?B?R1o4RWNLdVN1M21jbkVaTlVXQmpob3d4UFM3Q0tneTVuMFIyN1pRYmpzb0Fq?=
 =?utf-8?Q?Ey+4bibzMWK5z+FqCVQ3atBHU?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA0PR11MB7185.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74cfeb58-b98d-428f-af66-08dd9cd6216b
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 May 2025 04:22:45.3503 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zaARjlosaG1Ve1MgAf1rRpgR/Lb1bcv1rpJGF+gDlzSaG++LXjXGiPkuV9lW1Mxh2ltc4nQOhgnO+dE4gMv4M9V0F2PMCRTPy0F3bvTBLDA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB8074
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.17;
 envelope-from=vivek.kasireddy@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -72
X-Spam_score: -7.3
X-Spam_bar: -------
X-Spam_report: (-7.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.903,
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

SGkgTWFyYy1BbmRyw6ksDQoNCj4gSGkNCj4gDQo+IE9uIFRodSwgTWF5IDE1LCAyMDI1IGF0IDQ6
NDnigK9BTSBWaXZlayBLYXNpcmVkZHkNCj4gPHZpdmVrLmthc2lyZWRkeUBpbnRlbC5jb20gPG1h
aWx0bzp2aXZlay5rYXNpcmVkZHlAaW50ZWwuY29tPiA+IHdyb3RlOg0KPiANCj4gDQo+IAlJbiB0
aGUgc3BlY2lmaWMgY2FzZSB3aGVyZSB0aGUgZGlzcGxheSBsYXllciAodmlydGlvLWdwdSkgaXMg
dXNpbmcNCj4gCWRtYWJ1ZiwgYW5kIGlmIHJlbW90ZSBjbGllbnRzIGFyZSBlbmFibGVkICgtc3Bp
Y2UgZ2w9b24scG9ydD14eHh4KSwNCj4gCWl0IG1ha2VzIHNlbnNlIHRvIGxpbWl0IHRoZSBtYXhp
bXVtIChzdHJlYW1pbmcpIHJhdGUgKHJlZnJlc2ggcmF0ZSkNCj4gCXRvIGEgZml4ZWQgdmFsdWUg
dXNpbmcgdGhlIEdVSSByZWZyZXNoIHRpbWVyLiBPdGhlcndpc2UsIHRoZSB1cGRhdGVzDQo+IAlv
ciBnbF9kcmF3IHJlcXVlc3RzIHdvdWxkIGJlIHNlbnQgYXMgc29vbiBhcyB0aGUgR3Vlc3Qgc3Vi
bWl0cyBhIG5ldw0KPiAJZnJhbWUgd2hpY2ggaXMgbm90IG9wdGltYWwgYXMgaXQgd291bGQgbGVh
ZCB0byBpbmNyZWFzZWQgbmV0d29yaw0KPiAJdHJhZmZpYyBhbmQgd2FzdGFnZSBvZiBHUFUgY3lj
bGVzIGlmIHRoZSBmcmFtZXMgZ2V0IGRyb3BwZWQuDQo+IA0KPiANCj4gDQo+IAlDYzogR2VyZCBI
b2ZmbWFubiA8a3JheGVsQHJlZGhhdC5jb20gPG1haWx0bzprcmF4ZWxAcmVkaGF0LmNvbT4NCj4g
Pg0KPiAJQ2M6IE1hcmMtQW5kcsOpIEx1cmVhdSA8bWFyY2FuZHJlLmx1cmVhdUByZWRoYXQuY29t
DQo+IDxtYWlsdG86bWFyY2FuZHJlLmx1cmVhdUByZWRoYXQuY29tPiA+DQo+IAlDYzogRG1pdHJ5
IE9zaXBlbmtvIDxkbWl0cnkub3NpcGVua29AY29sbGFib3JhLmNvbQ0KPiA8bWFpbHRvOmRtaXRy
eS5vc2lwZW5rb0Bjb2xsYWJvcmEuY29tPiA+DQo+IAlDYzogRnJlZGlhbm8gWmlnbGlvIDxmcmVk
ZHk3N0BnbWFpbC5jb20NCj4gPG1haWx0bzpmcmVkZHk3N0BnbWFpbC5jb20+ID4NCj4gCUNjOiBE
b25nd29uIEtpbSA8ZG9uZ3dvbi5raW1AaW50ZWwuY29tDQo+IDxtYWlsdG86ZG9uZ3dvbi5raW1A
aW50ZWwuY29tPiA+DQo+IAlTaWduZWQtb2ZmLWJ5OiBWaXZlayBLYXNpcmVkZHkgPHZpdmVrLmth
c2lyZWRkeUBpbnRlbC5jb20NCj4gPG1haWx0bzp2aXZlay5rYXNpcmVkZHlAaW50ZWwuY29tPiA+
DQo+IAktLS0NCj4gCSBpbmNsdWRlL3VpL3NwaWNlLWRpc3BsYXkuaCB8ICAxICsNCj4gCSBxZW11
LW9wdGlvbnMuaHggICAgICAgICAgICB8ICA1ICsrKysNCj4gCSB1aS9zcGljZS1jb3JlLmMgICAg
ICAgICAgICB8IDExICsrKysrKysrDQo+IAkgdWkvc3BpY2UtZGlzcGxheS5jICAgICAgICAgfCA1
NCArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrLS0tLS0tLQ0KPiAJIDQgZmlsZXMgY2hh
bmdlZCwgNjEgaW5zZXJ0aW9ucygrKSwgMTAgZGVsZXRpb25zKC0pDQo+IA0KPiAJZGlmZiAtLWdp
dCBhL2luY2x1ZGUvdWkvc3BpY2UtZGlzcGxheS5oIGIvaW5jbHVkZS91aS9zcGljZS1kaXNwbGF5
LmgNCj4gCWluZGV4IGY0OTIyZGQ3NGIuLjJmZTUyNGI1OWMgMTAwNjQ0DQo+IAktLS0gYS9pbmNs
dWRlL3VpL3NwaWNlLWRpc3BsYXkuaA0KPiAJKysrIGIvaW5jbHVkZS91aS9zcGljZS1kaXNwbGF5
LmgNCj4gCUBAIC0xNTIsNiArMTUyLDcgQEAgc3RydWN0IFNpbXBsZVNwaWNlQ3Vyc29yIHsNCj4g
DQo+IAkgZXh0ZXJuIGJvb2wgc3BpY2Vfb3BlbmdsOw0KPiAJIGV4dGVybiBib29sIHJlbW90ZV9j
bGllbnQ7DQo+IAkrZXh0ZXJuIGludCBtYXhfcmVmcmVzaF9yYXRlOw0KPiANCj4gCSBpbnQgcWVt
dV9zcGljZV9yZWN0X2lzX2VtcHR5KGNvbnN0IFFYTFJlY3QqIHIpOw0KPiAJIHZvaWQgcWVtdV9z
cGljZV9yZWN0X3VuaW9uKFFYTFJlY3QgKmRlc3QsIGNvbnN0IFFYTFJlY3QgKnIpOw0KPiAJZGlm
ZiAtLWdpdCBhL3FlbXUtb3B0aW9ucy5oeCBiL3FlbXUtb3B0aW9ucy5oeA0KPiAJaW5kZXggOTdj
NjNkOWIzMS4uNGU5ZjRlZGZkYyAxMDA2NDQNCj4gCS0tLSBhL3FlbXUtb3B0aW9ucy5oeA0KPiAJ
KysrIGIvcWVtdS1vcHRpb25zLmh4DQo+IAlAQCAtMjI4Miw2ICsyMjgyLDcgQEAgREVGKCJzcGlj
ZSIsIEhBU19BUkcsDQo+IFFFTVVfT1BUSU9OX3NwaWNlLA0KPiAJICAgICAiICAgICAgIFssZGlz
YWJsZS1hZ2VudC1maWxlLXhmZXI9b258b2ZmXVssYWdlbnQtbW91c2U9W29ufG9mZl1dXG4iDQo+
IAkgICAgICIgICAgICAgWyxwbGF5YmFjay1jb21wcmVzc2lvbj1bb258b2ZmXV1bLHNlYW1sZXNz
LQ0KPiBtaWdyYXRpb249W29ufG9mZl1dXG4iDQo+IAkgICAgICIgICAgICAgWyx2aWRlby1jb2Rl
Y3M9PGVuY29kZXI+Ojxjb2RlYz5cbiINCj4gCSsgICAgIiAgICAgICBbLG1heC1yZWZyZXNoLXJh
dGU9cmF0ZVxuIg0KPiAJICAgICAiICAgICAgIFssZ2w9W29ufG9mZl1dWyxyZW5kZXJub2RlPTxm
aWxlPl1cbiINCj4gCSAgICAgIiAgICAgICAgICAgICAgICBlbmFibGUgc3BpY2VcbiINCj4gCSAg
ICAgIiAgICAgICAgICAgICAgICBhdCBsZWFzdCBvbmUgb2Yge3BvcnQsIHRscy1wb3J0fSBpcyBt
YW5kYXRvcnlcbiIsDQo+IAlAQCAtMjM3NCw2ICsyMzc1LDEwIEBAIFNSU1QNCj4gCSAgICAgICAg
IFByb3ZpZGUgdGhlIHByZWZlcnJlZCBjb2RlYyB0aGUgU3BpY2Ugc2VydmVyIHNob3VsZCB1c2Uu
DQo+IAkgICAgICAgICBEZWZhdWx0IHdvdWxkIGJlIHNwaWNlOm1qcGVnLg0KPiANCj4gCSsgICAg
YGBtYXgtcmVmcmVzaC1yYXRlPXJhdGVgYA0KPiAJKyAgICAgICAgUHJvdmlkZSB0aGUgbWF4aW11
bSByZWZyZXNoIHJhdGUgKG9yIEZQUykgYXQgd2hpY2ggdGhlIGVuY29kaW5nDQo+IAkrICAgICAg
ICByZXF1ZXN0cyBzaG91bGQgYmUgc2VudCB0byB0aGUgU3BpY2Ugc2VydmVyLiBEZWZhdWx0IHdv
dWxkIGJlIDMwLg0KPiAJKw0KPiAJICAgICBgYGdsPVtvbnxvZmZdYGANCj4gCSAgICAgICAgIEVu
YWJsZS9kaXNhYmxlIE9wZW5HTCBjb250ZXh0LiBEZWZhdWx0IGlzIG9mZi4NCj4gDQo+IAlkaWZm
IC0tZ2l0IGEvdWkvc3BpY2UtY29yZS5jIGIvdWkvc3BpY2UtY29yZS5jDQo+IAlpbmRleCA2YzNi
ZmUxZDBmLi5kODkyNTIwN2IxIDEwMDY0NA0KPiAJLS0tIGEvdWkvc3BpY2UtY29yZS5jDQo+IAkr
KysgYi91aS9zcGljZS1jb3JlLmMNCj4gCUBAIC01Niw2ICs1Niw4IEBAIHN0cnVjdCBTcGljZVRp
bWVyIHsNCj4gCSAgICAgUUVNVVRpbWVyICp0aW1lcjsNCj4gCSB9Ow0KPiANCj4gCSsjZGVmaW5l
IE1BWF9SRUZSRVNIX1JBVEUgMzANCj4gCSsNCj4gCSBzdGF0aWMgU3BpY2VUaW1lciAqdGltZXJf
YWRkKFNwaWNlVGltZXJGdW5jIGZ1bmMsIHZvaWQgKm9wYXF1ZSkNCj4gCSB7DQo+IAkgICAgIFNw
aWNlVGltZXIgKnRpbWVyOw0KPiAJQEAgLTQ5MSw2ICs0OTMsOSBAQCBzdGF0aWMgUWVtdU9wdHNM
aXN0IHFlbXVfc3BpY2Vfb3B0cyA9IHsNCj4gCSAgICAgICAgIH0sew0KPiAJICAgICAgICAgICAg
IC5uYW1lID0gInZpZGVvLWNvZGVjcyIsDQo+IAkgICAgICAgICAgICAgLnR5cGUgPSBRRU1VX09Q
VF9TVFJJTkcsDQo+IAkrICAgICAgICB9LHsNCj4gCSsgICAgICAgICAgICAubmFtZSA9ICJtYXgt
cmVmcmVzaC1yYXRlIiwNCj4gCSsgICAgICAgICAgICAudHlwZSA9IFFFTVVfT1BUX05VTUJFUiwN
Cj4gCSAgICAgICAgIH0sew0KPiAJICAgICAgICAgICAgIC5uYW1lID0gImFnZW50LW1vdXNlIiwN
Cj4gCSAgICAgICAgICAgICAudHlwZSA9IFFFTVVfT1BUX0JPT0wsDQo+IAlAQCAtODEzLDYgKzgx
OCwxMiBAQCBzdGF0aWMgdm9pZCBxZW11X3NwaWNlX2luaXQodm9pZCkNCj4gCSAgICAgICAgIH0N
Cj4gCSAgICAgfQ0KPiANCj4gCSsgICAgbWF4X3JlZnJlc2hfcmF0ZSA9IHFlbXVfb3B0X2dldF9u
dW1iZXIob3B0cywgIm1heC1yZWZyZXNoLQ0KPiByYXRlIiwgTUFYX1JFRlJFU0hfUkFURSk7DQo+
IAkrICAgIGlmIChtYXhfcmVmcmVzaF9yYXRlIDwgMCkgew0KPiAJKyAgICAgICAgZXJyb3JfcmVw
b3J0KCJtYXggcmVmcmVzaCByYXRlL2ZwcyBpcyBpbnZhbGlkIik7DQo+IAkrICAgICAgICBleGl0
KDEpOw0KPiAJKyAgICB9DQo+IAkrDQo+IAkgICAgIHNwaWNlX3NlcnZlcl9zZXRfYWdlbnRfbW91
c2UNCj4gCSAgICAgICAgIChzcGljZV9zZXJ2ZXIsIHFlbXVfb3B0X2dldF9ib29sKG9wdHMsICJh
Z2VudC1tb3VzZSIsIDEpKTsNCj4gCSAgICAgc3BpY2Vfc2VydmVyX3NldF9wbGF5YmFja19jb21w
cmVzc2lvbg0KPiAJZGlmZiAtLWdpdCBhL3VpL3NwaWNlLWRpc3BsYXkuYyBiL3VpL3NwaWNlLWRp
c3BsYXkuYw0KPiAJaW5kZXggOTE0MDE2OTAxNS4uZWQ5MTUyMWFjMiAxMDA2NDQNCj4gCS0tLSBh
L3VpL3NwaWNlLWRpc3BsYXkuYw0KPiAJKysrIGIvdWkvc3BpY2UtZGlzcGxheS5jDQo+IAlAQCAt
MzIsNiArMzIsNyBAQA0KPiANCj4gCSBib29sIHNwaWNlX29wZW5nbDsNCj4gCSBib29sIHJlbW90
ZV9jbGllbnQ7DQo+IAkraW50IG1heF9yZWZyZXNoX3JhdGU7DQo+IA0KPiAJIGludCBxZW11X3Nw
aWNlX3JlY3RfaXNfZW1wdHkoY29uc3QgUVhMUmVjdCogcikNCj4gCSB7DQo+IAlAQCAtODQ0LDEy
ICs4NDUsMzIgQEAgc3RhdGljIHZvaWQgcWVtdV9zcGljZV9nbF9ibG9ja190aW1lcih2b2lkDQo+
ICpvcGFxdWUpDQo+IAkgICAgIHdhcm5fcmVwb3J0KCJzcGljZTogbm8gZ2wtZHJhdy1kb25lIHdp
dGhpbiBvbmUgc2Vjb25kIik7DQo+IAkgfQ0KPiANCj4gCStzdGF0aWMgdm9pZCBzcGljZV9nbF9k
cmF3KFNpbXBsZVNwaWNlRGlzcGxheSAqc3NkLA0KPiAJKyAgICAgICAgICAgICAgICAgICAgICAg
ICAgIHVpbnQzMl90IHgsIHVpbnQzMl90IHksIHVpbnQzMl90IHcsIHVpbnQzMl90IGgpDQo+IAkr
ew0KPiAJKyAgICB1aW50NjRfdCBjb29raWU7DQo+IAkrDQo+IAkrICAgIGNvb2tpZSA9DQo+ICh1
aW50cHRyX3QpcXhsX2Nvb2tpZV9uZXcoUVhMX0NPT0tJRV9UWVBFX0dMX0RSQVdfRE9ORSwgMCk7
DQo+IAkrICAgIHNwaWNlX3F4bF9nbF9kcmF3X2FzeW5jKCZzc2QtPnF4bCwgeCwgeSwgdywgaCwg
Y29va2llKTsNCj4gCSt9DQo+IAkrDQo+IAkgc3RhdGljIHZvaWQgc3BpY2VfZ2xfcmVmcmVzaChE
aXNwbGF5Q2hhbmdlTGlzdGVuZXIgKmRjbCkNCj4gCSB7DQo+IAkgICAgIFNpbXBsZVNwaWNlRGlz
cGxheSAqc3NkID0gY29udGFpbmVyX29mKGRjbCwgU2ltcGxlU3BpY2VEaXNwbGF5LA0KPiBkY2wp
Ow0KPiAJLSAgICB1aW50NjRfdCBjb29raWU7DQo+IA0KPiAJLSAgICBpZiAoIXNzZC0+ZHMgfHwg
cWVtdV9jb25zb2xlX2lzX2dsX2Jsb2NrZWQoc3NkLT5kY2wuY29uKSkgew0KPiAJKyAgICBpZiAo
IXNzZC0+ZHMpIHsNCj4gCSsgICAgICAgIHJldHVybjsNCj4gCSsgICAgfQ0KPiAJKw0KPiAJKyAg
ICBpZiAocWVtdV9jb25zb2xlX2lzX2dsX2Jsb2NrZWQoc3NkLT5kY2wuY29uKSkgew0KPiAJKyAg
ICAgICAgaWYgKHJlbW90ZV9jbGllbnQgJiYgc3NkLT5nbF91cGRhdGVzICYmIHNzZC0+aGF2ZV9z
Y2Fub3V0KSB7DQo+IAkrICAgICAgICAgICAgZ2xGbHVzaCgpOw0KPiAJKyAgICAgICAgICAgIHNw
aWNlX2dsX2RyYXcoc3NkLCAwLCAwLA0KPiAJKyAgICAgICAgICAgICAgICAgICAgICAgICAgc3Vy
ZmFjZV93aWR0aChzc2QtPmRzKSwgc3VyZmFjZV9oZWlnaHQoc3NkLT5kcykpOw0KPiAJKyAgICAg
ICAgICAgIHNzZC0+Z2xfdXBkYXRlcyA9IDA7DQo+IAkrICAgICAgICAgICAgLyogVG8gdXBkYXRl
IGF0IDYwIEZQUywgdXBkYXRlX2ludGVydmFsIG5lZWRzIHRvIGJlIH4xNi42NiBtcw0KPiAqLw0K
PiAJKyAgICAgICAgICAgIGRjbC0+dXBkYXRlX2ludGVydmFsID0gMTAwMCAvIG1heF9yZWZyZXNo
X3JhdGU7DQo+IAkrICAgICAgICB9DQo+IAkgICAgICAgICByZXR1cm47DQo+IAkgICAgIH0NCj4g
DQo+IAlAQCAtODU3LDExICs4NzgsOCBAQCBzdGF0aWMgdm9pZA0KPiBzcGljZV9nbF9yZWZyZXNo
KERpc3BsYXlDaGFuZ2VMaXN0ZW5lciAqZGNsKQ0KPiAJICAgICBpZiAoc3NkLT5nbF91cGRhdGVz
ICYmIHNzZC0+aGF2ZV9zdXJmYWNlKSB7DQo+IAkgICAgICAgICBxZW11X3NwaWNlX2dsX2Jsb2Nr
KHNzZCwgdHJ1ZSk7DQo+IAkgICAgICAgICBnbEZsdXNoKCk7DQo+IAktICAgICAgICBjb29raWUg
PQ0KPiAodWludHB0cl90KXF4bF9jb29raWVfbmV3KFFYTF9DT09LSUVfVFlQRV9HTF9EUkFXX0RP
TkUsIDApOw0KPiAJLSAgICAgICAgc3BpY2VfcXhsX2dsX2RyYXdfYXN5bmMoJnNzZC0+cXhsLCAw
LCAwLA0KPiAJLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgc3VyZmFjZV93aWR0aChz
c2QtPmRzKSwNCj4gCS0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHN1cmZhY2VfaGVp
Z2h0KHNzZC0+ZHMpLA0KPiAJLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgY29va2ll
KTsNCj4gCSsgICAgICAgIHNwaWNlX2dsX2RyYXcoc3NkLCAwLCAwLA0KPiAJKyAgICAgICAgICAg
ICAgICAgICAgICBzdXJmYWNlX3dpZHRoKHNzZC0+ZHMpLCBzdXJmYWNlX2hlaWdodChzc2QtPmRz
KSk7DQo+IAkgICAgICAgICBzc2QtPmdsX3VwZGF0ZXMgPSAwOw0KPiAJICAgICB9DQo+IAkgfQ0K
PiAJQEAgLTk1NCw2ICs5NzIsMjAgQEAgc3RhdGljIHZvaWQNCj4gcWVtdV9zcGljZV9nbF9zY2Fu
b3V0X2Rpc2FibGUoRGlzcGxheUNoYW5nZUxpc3RlbmVyICpkY2wpDQo+IAkgICAgIFNpbXBsZVNw
aWNlRGlzcGxheSAqc3NkID0gY29udGFpbmVyX29mKGRjbCwgU2ltcGxlU3BpY2VEaXNwbGF5LA0K
PiBkY2wpOw0KPiANCj4gCSAgICAgdHJhY2VfcWVtdV9zcGljZV9nbF9zY2Fub3V0X2Rpc2FibGUo
c3NkLT5xeGwuaWQgPGh0dHA6Ly9xeGwuaWQ+ICk7DQo+IAkrDQo+IAkrICAgIC8qDQo+IAkrICAg
ICAqIFdlIG5lZWQgdG8gY2hlY2sgZm9yIHRoZSBjYXNlIG9mICJsb3N0IiB1cGRhdGVzLCB3aGVy
ZSBhIGdsX2RyYXcNCj4gCSsgICAgICogd2FzIG5vdCBzdWJtaXR0ZWQgYmVjYXVzZSB0aGUgdGlt
ZXIgZGlkIG5vdCBnZXQgYSBjaGFuY2UgdG8gcnVuLg0KPiAJKyAgICAgKiBPbmUgY2FzZSB3aGVy
ZSB0aGlzIGhhcHBlbnMgaXMgd2hlbiB0aGUgR3Vlc3QgVk0gaXMgZ2V0dGluZw0KPiAJKyAgICAg
KiByZWJvb3RlZC4gSWYgdGhlIGNvbnNvbGUgaXMgYmxvY2tlZCBpbiB0aGlzIHNpdHVhdGlvbiwg
d2UgbmVlZA0KPiAJKyAgICAgKiB0byB1bmJsb2NrIGl0LiBPdGhlcndpc2UsIG5ld2VyIHVwZGF0
ZXMgd291bGQgbm90IHRha2UgZWZmZWN0Lg0KPiAJKyAgICAgKi8NCj4gCSsgICAgaWYgKHFlbXVf
Y29uc29sZV9pc19nbF9ibG9ja2VkKHNzZC0+ZGNsLmNvbikpIHsNCj4gCSsgICAgICAgIGlmIChy
ZW1vdGVfY2xpZW50ICYmIHNzZC0+Z2xfdXBkYXRlcyAmJiBzc2QtPmhhdmVfc2Nhbm91dCkgew0K
PiAJKyAgICAgICAgICAgIHNzZC0+Z2xfdXBkYXRlcyA9IDA7DQo+IAkrICAgICAgICAgICAgcWVt
dV9zcGljZV9nbF9ibG9jayhzc2QsIGZhbHNlKTsNCj4gCSsgICAgICAgIH0NCj4gCSsgICAgfQ0K
PiAJICAgICBzcGljZV9zZXJ2ZXJfZ2xfc2Nhbm91dCgmc3NkLT5xeGwsIE5VTEwsIDAsIDAsIE5V
TEwsIE5VTEwsIDAsDQo+IERSTV9GT1JNQVRfSU5WQUxJRCwNCj4gCSAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgRFJNX0ZPUk1BVF9NT0RfSU5WQUxJRCwgZmFsc2UpOw0KPiAJICAgICBxZW11
X3NwaWNlX2dsX21vbml0b3JfY29uZmlnKHNzZCwgMCwgMCwgMCwgMCk7DQo+IAlAQCAtMTA2MSw3
ICsxMDkzLDYgQEAgc3RhdGljIHZvaWQNCj4gcWVtdV9zcGljZV9nbF91cGRhdGUoRGlzcGxheUNo
YW5nZUxpc3RlbmVyICpkY2wsDQo+IAkgICAgIEVHTGludCBmb3VyY2MgPSAwOw0KPiAJICAgICBi
b29sIHJlbmRlcl9jdXJzb3IgPSBmYWxzZTsNCj4gCSAgICAgYm9vbCB5XzBfdG9wID0gZmFsc2U7
IC8qIEZJWE1FICovDQo+IAktICAgIHVpbnQ2NF90IGNvb2tpZTsNCj4gCSAgICAgdWludDMyX3Qg
d2lkdGgsIGhlaWdodCwgdGV4dHVyZTsNCj4gDQo+IAkgICAgIGlmICghc3NkLT5oYXZlX3NjYW5v
dXQpIHsNCj4gCUBAIC0xMTU5LDggKzExOTAsMTEgQEAgc3RhdGljIHZvaWQNCj4gcWVtdV9zcGlj
ZV9nbF91cGRhdGUoRGlzcGxheUNoYW5nZUxpc3RlbmVyICpkY2wsDQo+IAkgICAgIHRyYWNlX3Fl
bXVfc3BpY2VfZ2xfdXBkYXRlKHNzZC0+cXhsLmlkIDxodHRwOi8vcXhsLmlkPiAsIHcsIGgsIHgs
IHkpOw0KPiAJICAgICBxZW11X3NwaWNlX2dsX2Jsb2NrKHNzZCwgdHJ1ZSk7DQo+IAkgICAgIGds
Rmx1c2goKTsNCj4gCS0gICAgY29va2llID0NCj4gKHVpbnRwdHJfdClxeGxfY29va2llX25ldyhR
WExfQ09PS0lFX1RZUEVfR0xfRFJBV19ET05FLCAwKTsNCj4gCS0gICAgc3BpY2VfcXhsX2dsX2Ry
YXdfYXN5bmMoJnNzZC0+cXhsLCB4LCB5LCB3LCBoLCBjb29raWUpOw0KPiAJKyAgICBpZiAocmVt
b3RlX2NsaWVudCkgew0KPiAJKyAgICAgICAgc3NkLT5nbF91cGRhdGVzKys7DQo+IAkrICAgIH0g
ZWxzZSB7DQo+IAkrICAgICAgICBzcGljZV9nbF9kcmF3KHNzZCwgeCwgeSwgdywgaCk7DQo+IAkr
ICAgIH0NCj4gDQo+IA0KPiANCj4gSSB0aGluayB0aGlzIGlzIG5vdCB0aGUgcmlnaHQgcGxhY2Ug
dG8gaGFuZGxlIHRoZSByZW1vdGUgdnMgbG9jYWwgY2FzZS4gSXQgc2hvdWxkDQo+IGJlIGRvbmUg
YXQgdGhlIHNwaWNlIHNlcnZlciBsZXZlbCwgc2luY2UgdGhlIHNlcnZlciBjYW4gc2VydmUgdmFy
aW91cyBzb2NrZXRzIC8NCj4gY29ubmVjdGlvbnMgKG5vdCBqdXN0IHRoZSBvbmUgaXQgbGlzdGVu
cyB0bywgYnV0IHRoZSBvbmUgaXQgaGFzIGJlZW4gZ2l2ZW4pLg0KV2hhdCBJIGFtIGRvaW5nIGhl
cmUgaXMganVzdCBwb3N0cG9uaW5nIHRoZSBzdWJtaXNzaW9uIG9mIGdsX2RyYXcgcmVxdWVzdCAo
dG8NCnNwaWNlIHNlcnZlcikgZm9yIHRoZSByZW1vdGUgY2xpZW50IGNhc2UuIEluIG90aGVyIHdv
cmRzLCBpbnN0ZWFkIG9mIHN1Ym1pdHRpbmcNCnRoZSBnbF9kcmF3IHJlcXVlc3QgcmlnaHQgYXdh
eSBmcm9tIHFlbXVfc3BpY2VfZ2xfdXBkYXRlKCksIGl0IHdpbGwgbm93IGJlDQpzdWJtaXR0ZWQg
ZnJvbSB0aGUgc3BpY2VfZ2xfcmVmcmVzaCgpIHRpbWVyIGNhbGxiYWNrLiBUaGlzIGlzIHRvIGVu
c3VyZSB0aGF0DQp1cGRhdGVzIGZyb20gdGhlIEd1ZXN0IGFyZSBzdWJtaXR0ZWQgYXQgYSBmaXhl
ZCByYXRlIChhcyBpbmRpY2F0ZWQgYnkNCm1heC1yZWZyZXNoLXJhdGUpIGluc3RlYWQgb2YgYXJi
aXRyYXJpbHkgc3VibWl0dGluZyB0aGVtLiBJJ2xsIGFkZCBjb21tZW50cw0KZGVzY3JpYmluZyB0
aGlzIGJlaGF2aW9yIGluIHRoZSBuZXh0IHZlcnNpb24uDQoNClRoYW5rcywNClZpdmVrDQoNCj4g
DQo+IA0KPiAJIH0NCj4gDQo+IAkgc3RhdGljIGNvbnN0IERpc3BsYXlDaGFuZ2VMaXN0ZW5lck9w
cyBkaXNwbGF5X2xpc3RlbmVyX2dsX29wcyA9IHsNCj4gCS0tDQo+IAkyLjQ5LjANCj4gDQo+IA0K
DQo=

