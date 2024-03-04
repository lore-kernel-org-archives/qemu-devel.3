Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36112C5478C
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Mar 2024 10:11:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rh5Hd-0003Ui-Qx; Mon, 04 Mar 2024 05:10:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1rh5Hb-0003UV-Uw
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 05:10:56 -0500
Received: from mgamail.intel.com ([192.198.163.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1rh5HZ-0007DU-PR
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 05:10:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1709547054; x=1741083054;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=gNnwoxjSHXLISsZ53Vu84i4fFATXmu5UAgp06+JqdNc=;
 b=Ureu0WIUrvt+PIrvkbpFXc7zALeAq9A668fCAaIsO0U6pTUuBfM7qLqJ
 p5cXSaeSaSYABCwkNV/zNVexK5BYtRocOj3Fc8bgd1JfS5nb8/EQtY3ER
 nHRh5GQDaS6c9k7Y+W5leHbSK/YAX4XV1nuVebYtU4E+b2HD2LQqAtFrg
 1/oBpmR4slvi4vL0sD8LbjNByXVP25UqKSuv8r9uczycl1gV+yQPi5S0B
 9GzO+RsAzMHDJfFesPdWH+3M70Ji8z8X8bObH9Hr/FBg7IwpHh99JzMUi
 IGQNE9jG7/NAbtgWbVBvTeF5kKZWcPtw733yxK9Lmn/GiN1oy7wRVb8Ec g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11002"; a="7801586"
X-IronPort-AV: E=Sophos;i="6.06,203,1705392000"; 
   d="scan'208";a="7801586"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Mar 2024 02:10:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,203,1705392000"; d="scan'208";a="39937586"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
 by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 04 Mar 2024 02:10:50 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 4 Mar 2024 02:10:50 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 4 Mar 2024 02:10:50 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 4 Mar 2024 02:10:50 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CoiAqs5Mr+Wt8OzdjlEjZdcgQmufHtZ1yiOKa80Fqs8EyXLCr3EYPRiYfF19M2Ij+9BBX3kCLvSFWUQrRwmXtmz6Favp1cDiWRaPzDx8Z7BH3/sUceafvMDzjUGO0GllTOHZ19bEskqYcNbm6ek1LfhICRFYTqtDx5p3vdnvu8f4jW58g0/YSHLyvqkCMiYgDbCPs4J+PXR8rYigsJRX+WERPbXQ0/c/AVaHabGgYs10DwH6qOI5Mh/kzWUbVHTDH9YlUgmp7suRDqwM46xOYDz+ygrhM9naS4K8QVd/KHUQ5DL5A3uyHfbavBIHeVWMzcH02o7o3kCxdWdMEtZzUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gNnwoxjSHXLISsZ53Vu84i4fFATXmu5UAgp06+JqdNc=;
 b=WEfuh9rbTCKYMI4CMBw7mAcp9z5d+Kyvd3C8+oZnrGyAZ+CSMCzMffphu+3pQuaTpXel6mTjBMu8zV+EYTvD3nIpbzaXhBAc/Gj70H4neC/DCc7ptY/IYF+BBYA1mx1Vg25bGqUBvAzyvjJemlK4/ZlHCIQdcusBarhSW0n5d5uEHiIWM0x4zrcWu1ZyTCi9Fl5D43FFtw82/VzcIAF21MsQpwim0IlfHG6FqR6iFv3NcKtu6ZlHLHPkS8jSrjULsgXMxNRhig4VMHf3BOOZMd7VIaLS7YEkv5U9aQzQvoLWjcgFns0Hw09ohJIEk/kTx6zB6mN/rMxWgr+LWlwMrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by SA3PR11MB8118.namprd11.prod.outlook.com (2603:10b6:806:2f1::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.23; Mon, 4 Mar
 2024 10:10:48 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::c0f3:15d4:d7f6:a72a]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::c0f3:15d4:d7f6:a72a%4]) with mapi id 15.20.7362.019; Mon, 4 Mar 2024
 10:10:47 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: Prasad Pandit <ppandit@redhat.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>, "clg@redhat.com"
 <clg@redhat.com>, "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "peterx@redhat.com" <peterx@redhat.com>, "jasowang@redhat.com"
 <jasowang@redhat.com>, "mst@redhat.com" <mst@redhat.com>, "jgg@nvidia.com"
 <jgg@nvidia.com>, "nicolinc@nvidia.com" <nicolinc@nvidia.com>,
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>, "Tian, Kevin"
 <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>, "Sun, Yi Y"
 <yi.y.sun@intel.com>, "Peng, Chao P" <chao.p.peng@intel.com>, "Marcel
 Apfelbaum" <marcel.apfelbaum@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>, Eduardo Habkost
 <eduardo@habkost.net>
Subject: RE: [PATCH v1 6/6] intel_iommu: Block migration if cap is updated
Thread-Topic: [PATCH v1 6/6] intel_iommu: Block migration if cap is updated
Thread-Index: AQHaaisjZfUYiE/VykmSeDX9O65MCbEnJ/iAgAAI1KCAACvPgIAAAsTA
Date: Mon, 4 Mar 2024 10:10:47 +0000
Message-ID: <SJ0PR11MB67445C9089A62476223F50D192232@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20240228094432.1092748-1-zhenzhong.duan@intel.com>
 <20240228094432.1092748-7-zhenzhong.duan@intel.com>
 <CAE8KmOxFnzsw2das+Go_EEyVUr517hWS8xvXfN1VoJq0RofR+w@mail.gmail.com>
 <SJ0PR11MB6744A22D240CB8A41569222392232@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <CAE8KmOwuTpFSr=ft2cdiWKJmiy2uZMunO+v1UWFa1MbGqCXH7g@mail.gmail.com>
In-Reply-To: <CAE8KmOwuTpFSr=ft2cdiWKJmiy2uZMunO+v1UWFa1MbGqCXH7g@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|SA3PR11MB8118:EE_
x-ms-office365-filtering-correlation-id: 68a2ca15-1735-4e41-de29-08dc3c335ca3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RpLpRIgZsdJy3ShwCyUbbQeN8NJ6SEmxkweBwc1gXKxn+YOEYt5PhvNRdvMdgbTsg6dXINmbZFSjgnO2pTfRH8kaLl+UkqpmPjUYsgkqxAoOYmb5AAu1DaWjnRySdFo73BWeuyMQFxfO9m87ydkCnNP7+/2FTbbVZdzGmslHob3fFiwj6rPR8kr5M3CDN4X0lLA8uOwex+UvSIzEwGRkig88G8wjyu6ILjqaZTeycsGq/B31XrGN7l0rtwJxopAuRGxj23chyoWz0/jbdygzpIVs+y1ZYJAq10PyUXsZ80G7wl2HHgePooaFRZLlx4sEXE+FMtv2Z+Lw9fr69Wd5R0KXYBl4p9R4p3U4TYZ9Mz/I/HO6I4AHQkDJTF6FW9G08dXeIqdWbbGXtZauNy83n611Xv4al7xfDiGHW0SMbTrWaTKMx1jbIa28UUMHJJc7+p5+Mq0GcZxaNnO3rVQznuSfHx5YAA4uOYqSt6dscoYvFz8F95WrErxIApXUj1Q6oa5Uaw3XhMqtHtNMdFaOA0ihaAst7H365S6dJT5FQ5LONmK4wozr3b0oKha/vArifQHsr55l/bTFLsLPWlESKeajjZp1i4c2imbh/J1nLolHkL9REEl+KDX/pgjsKdlcQxv/s4d8oQKYkCuhvKpY38Gm5KP8tO+ip1TwhhQo+RakA0bleffttDOV0S5ANippYnxndh/mC/GrpFVmzBfySWZrX1d3k4tm9VUSGYwfFV4=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dG1LVlBqZ1E3TjB2dU5nRjJvRDlUbm11SjVBNlNpeGUzMENKd25mUHVUMHZ3?=
 =?utf-8?B?alJOdEk5SFZZVjNYRE9FV1loazl5QUVJQWFpdmJjVEdZVEgwZ2VacGhpbHll?=
 =?utf-8?B?LzRlRmttYkoyVzNPQS9xWnIyZnEyeGE0Y3NnVUdkeGRyM1NiUUFMQ1VvT1Nj?=
 =?utf-8?B?cTVnbFFlOTNFZnBZank2QmxuN1hjSTdNa3dXbG8wQm9PbmZFTFlkL2NOTEJY?=
 =?utf-8?B?TW5RcU9EVlRiTHVhZTRrZ0ZTbWZzUnZwY1pIN1R3NDk3WjlDa3Q3VmZlczlh?=
 =?utf-8?B?Snlmd3lDVnRPQ1UycmlLYTh5cy9oQ1crTTBEMXVZU2lNQWlUcWRyZUNyVllR?=
 =?utf-8?B?WGQ0cDFhWU1RdERpdXpLY0ZhbWx3SUIxTVQyN3ZZSHhRcHRFRWdOelNJMldl?=
 =?utf-8?B?bGQ0L1FGYnBiQ3BadktYa1daNy94R3R5M3VNY3BIU0F5RzU4ZVh2MEFaSkNj?=
 =?utf-8?B?elRqMXdUUmZHdHlSN0FpSnYxSUdwYW9kdEVNS2tXK0NUZGRyQklmWE9sM3pB?=
 =?utf-8?B?RmVFMTZ0cFN4R2ovZWQ3UkhZamNxZ1hFdCtaSWd0eU9pRTVVM2VWbWU4dmc1?=
 =?utf-8?B?blFFdFpqMDAzOTN2KzFRc0V0NDkvRldHOWdrYStLRUtNNmMveDlMNG9CZjl4?=
 =?utf-8?B?Q3BScmc1UGhsVnltTTNyWWhmZ0VyYzJ1NUNmOGkrRzRUZXJrcXVOTFdUaCtj?=
 =?utf-8?B?UUlZeE9vdW0xSEhwMHBud0R6SXlETWxRVzZYc3VTbmJ0M3FabGZsUmdmUU9G?=
 =?utf-8?B?UVI4ek9Jc1NxSElJRHArMlNlWFN4Q21tOUppUTdwRjFxWmFuaGlqNHM3T0RJ?=
 =?utf-8?B?OE9BcmZLWW14NjFHR3htNUY4cjk0NXltQlFFVzg3Ny9sTUxYSHkrOXhybkdx?=
 =?utf-8?B?eDhDVkgzYm5YaWhpZ0piWkszUll2UktSUWZBamJmSmVIMlFVRXVtUmFEMEt3?=
 =?utf-8?B?cnRtbzhaS2QrR3lPZ1lhTWNrZ2dTRlA2MiswV241NmcvTjg0UFN0L0VhazJU?=
 =?utf-8?B?ZWltN1p5aFpoZlo1TGl4ajhnNE5QNUJRVEhESHpJNUdaUEJPU2s5bThsc3BP?=
 =?utf-8?B?cXRta2NXS3lrdG9tNFhLVEVQWmtoMFd6MzdoSFp4V05RZHpEelJGN3BjNjFN?=
 =?utf-8?B?YVptcG9vUGdBQlJadVBmY2hpN05sdWhpMzFUNW8xa3lNN2FQRnp5OFFJK1Bo?=
 =?utf-8?B?VzBrQ2tlbzZmczlkazlVbERFdmprcVB4NUVjZHEwVjNUZnZtelRLUktMZktS?=
 =?utf-8?B?a1d5YVcyekt5UTRpVFBScTZzVHBVUXdHZ21oVm9HWUpzVGFJVzNGeHJWd1pZ?=
 =?utf-8?B?dXN2aU5rSWUrbU5tcnVxUkF1eGsxcW5pa3JtMXFGVzhlOE1NWmZPZkgrYVFw?=
 =?utf-8?B?K2pUOHNFMXhqT2lBWDhvdUx3ZWJyT0dwNk9hMjNSOG1OWUJ4OGhJYTI0ajg2?=
 =?utf-8?B?SnhoMk04cUh4cHpnYzNNT00wdnJRNTA2dDdKZ3VkU0N1Qmg5eDJuVWVmT21p?=
 =?utf-8?B?QS82RVNlcGJYcVNCaFVObEo5SDVrZUtpb09vQnZzZUpqVGtETlhMWnRLLzg4?=
 =?utf-8?B?QlJicFhpRzIzUkY2MVoxTWthaDRtMXMvemJnYno2K2pXUlI2YTY2eEM5aGlp?=
 =?utf-8?B?OFFzaUVWZnJCN0JOR3B1emp5dnkvR2pXUnpWc2NSSGpndmdVY1hLN0puUWJP?=
 =?utf-8?B?T3lVdWV4UGlpRDVzRkpqdEprQjBPWlRkbDVMem9LUmVPT09mRDhhcytqZ2Ni?=
 =?utf-8?B?T3JSMEpHV0hmdXpFNG1HZUZSK1dlc3JYdmpORTh1ZzM1cnBnOVlHb2krSlRz?=
 =?utf-8?B?SGZzRk1sekN4MjNyMDF0TmpqUDhpOWtqbUNIbmkvWWNEV2dETCtsU2hjRkky?=
 =?utf-8?B?OHNNL3hDcVFIZjM5VHdaUmIrRFVBbnowWW9Pem1rMDdwMTg3cWtrdFlybCsz?=
 =?utf-8?B?QUxrRFVaZnY3T1R4YnVrWm9QU0tXb0RJWlJNMkt4K0lIUVYrSDYybmVlMWQ0?=
 =?utf-8?B?dXNZNG5iK3lvYzMxd2JsblI2L1J0ZVRSQXgvS1BER0s3Z1Ywd3NDcnpQd2Vv?=
 =?utf-8?B?SU1rZkVqS0tUcUVqRkEzZlRNNTdkM1FMRkp1a1Z6TVZmcHBaWkRyYXgxdDYv?=
 =?utf-8?Q?oaoCtOoBI5iMJCmOqdOoIlHbH?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68a2ca15-1735-4e41-de29-08dc3c335ca3
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Mar 2024 10:10:47.4883 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: e0UfOTg33+/wYdx0qC2K2bRc10zthsUZhuAQdfRvEYBC7fAYh96SDPhAMhethgTIUM9kQXxNWpzDR+b9LjbLBMeweHH2gokZfXBAl4bBJhA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB8118
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.12;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.589,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IFByYXNhZCBQYW5kaXQgPHBw
YW5kaXRAcmVkaGF0LmNvbT4NCj5TdWJqZWN0OiBSZTogW1BBVENIIHYxIDYvNl0gaW50ZWxfaW9t
bXU6IEJsb2NrIG1pZ3JhdGlvbiBpZiBjYXAgaXMgdXBkYXRlZA0KPg0KPk9uIE1vbiwgNCBNYXIg
MjAyNCBhdCAxMzo0MSwgRHVhbiwgWmhlbnpob25nDQo+PHpoZW56aG9uZy5kdWFuQGludGVsLmNv
bT4gd3JvdGU6DQo+PiBUaGlzIGlzIHRvIGRlYWwgd2l0aCBhIHNwZWNpYWwgY2FzZSB3aGVuIGNv
bGQgcGx1Z2dlZCB2ZmlvIGRldmljZSBpcw0KPnVucGx1Z2dlZA0KPj4gYXQgcnVudGltZSwgdGhl
biBtaWdyYXRpb24gdHJpZ2dlcnMuDQo+Pg0KPj4gV2hlbiBxZW11IG9uIHNvdXJjZSBzaWRlIHN0
YXJ0cyB3aXRoIGNvbGQgcGx1Z2dlZCB2ZmlvIGRldmljZSwgdklPTU1VDQo+DQo+cWVtdSAtPiBR
RU1VDQo+DQo+PiBjYXBhYmlsaXR5L2V4dGVuZGVkIGNhcGFiaWxpdHkgcmVnaXN0ZXJzKGNhcC9l
Y2FwKSBjYW4gYmUgdXBkYXRlZCBiYXNlZA0KPj4gb24gaG9zdCBjYXAvZWNhcCwgdGhlbiB2SU9N
TVUgY2FwL2VjYXAgaXMgZnJvemVuIGFmdGVyIG1hY2hpbmUgY3JlYXRpb24NCj4+IGRvbmUsIHZJ
T01NVSBjYXAvZWNhcCBpc27igJl0IHJlc3RvcmVkIHRvIGRlZmF1bHQgYWZ0ZXIgdmZpbyBkZXZp
Y2UgaXMNCj51bnBsdWdnZWQuDQo+PiBJbiB0aGlzIGNhc2Ugc291cmNlIGFuZCBkZXN0KGRlZmF1
bHQgY2FwL2VjYXApIHdpbGwgaGF2ZSBpbmNvbXBhdGlibGUNCj5jYXAvZWNhcA0KPj4gdmFsdWUu
IFNvIG1pZ3JhdGlvbiBpcyBibG9ja2VkIGlmIHRoZXJlIGlzIGNhcC9lY2FwIHVwZGF0ZSBvbiBz
b3VyY2Ugc2lkZS4NCj4+DQo+PiBJZiB2ZmlvIGRldmljZSBpc24ndCB1bnBsdWdnZWQgYXQgcnVu
dGltZSwgdmZpbyBkZXZpY2UncyBvd24gdklPTU1VDQo+bWlncmF0aW9uIGJsb2NrZXINCj4+IGlz
IHJlZHVuZGFudCB3aXRoIGJsb2NrZXIgaGVyZSwgYnV0IHRoYXQncyBoYXJtbGVzcy4NCj4+DQo+
PiBJZiB2ZmlvIGRldmljZXMgYXJlIGFsbCBob3QgcGx1Z2dlZCBhZnRlciBxZW11IG9uIHNvdXJj
ZSBzaWRlIHN0YXJ0cywgdGhlbg0KPnZJT01NVQ0KPj4gY2FwL2VjYXAgaXMgZnJvemVuIHdpdGgg
dGhlIGRlZmF1bHQgdmFsdWUsIHdlIGRvbid0IG1ha2UgYSBibG9ja2VyIGluIHRoaXMNCj5jYXNl
Lg0KPj4NCj4NCj5OaWNlICsxDQo+DQo+PiA+PiBAQCAtMzg2MSw4ICszODY0LDE3IEBAIHN0YXRp
YyBpbnQNCj4+ID52dGRfY2hlY2tfaW9tbXVmZF9oZGV2KEludGVsSU9NTVVTdGF0ZSAqcywNCj4+
ID4+ICAgICAgICAgIHRtcF9jYXAgfD0gVlREX0NBUF9NR0FXKGhvc3RfbWdhdyArIDEpOw0KPj4g
Pj4gICAgICB9DQo+PiA+Pg0KPj4gPj4gLSAgICBzLT5jYXAgPSB0bXBfY2FwOw0KPj4gPj4gLSAg
ICByZXR1cm4gMDsNCj4+ID4+ICsgICAgaWYgKHMtPmNhcCAhPSB0bXBfY2FwKSB7DQo+PiA+PiAr
ICAgICAgICBpZiAodnRkX21pZ19ibG9ja2VyID09IE5VTEwpIHsNCj4+ID4+ICsgICAgICAgICAg
ICBlcnJvcl9zZXRnKCZ2dGRfbWlnX2Jsb2NrZXIsDQo+PiA+PiArICAgICAgICAgICAgICAgICAg
ICAgICAiY2FwL2VjYXAgdXBkYXRlIGZyb20gaG9zdCBJT01NVSBibG9jayBtaWdyYXRpb24iKTsN
Cj4+ID4+ICsgICAgICAgICAgICByZXQgPSBtaWdyYXRlX2FkZF9ibG9ja2VyKCZ2dGRfbWlnX2Js
b2NrZXIsIGVycnApOw0KPj4gPj4gKyAgICAgICAgfQ0KPj4gPj4gKyAgICAgICAgaWYgKCFyZXQp
IHsNCj4+ID4+ICsgICAgICAgICAgICBzLT5jYXAgPSB0bXBfY2FwOw0KPj4gPj4gKyAgICAgICAg
fQ0KPj4gPj4gKyAgICB9DQo+PiA+PiArICAgIHJldHVybiByZXQ7DQo+Pg0KPj4gdnRkX21pZ19i
bG9ja2VyICE9IE5VTEwgbWVhbnMgY2FwIGlzIGFscmVhZHkgdXBkYXRlZCBvbmNlIGF0IGxlYXN0
Lg0KPj4gSW4gdGhpcyBjYXNlLCByZXQgaXMgcmV0dXJuIHZhbHVlIDAgZnJvbSBpb21tdWZkX2Rl
dmljZV9nZXRfaW5mbygpLg0KPj4NCj4+ICAgICByZXQgPSBpb21tdWZkX2RldmljZV9nZXRfaW5m
byhpZGV2LCAmdHlwZSwgc2l6ZW9mKHZ0ZCksICZ2dGQsIGVycnApOw0KPj4gICAgIGlmIChyZXQp
IHsNCj4+ICAgICAgICAgcmV0dXJuIHJldDsNCj4+ICAgICB9DQo+Pg0KPj4gVGhlbiBjYXAgaXMg
dXBkYXRlZCB3aXRoIGhvc3QgY2FwIHZhbHVlIHRtcF9jYXAuIFRoaXMgdXBkYXRlIG9ubHkgaGFw
cGVuDQo+PiBiZWZvcmUgbWFjaGluZSBjcmVhdGlvbiBkb25lLg0KPg0KPiogQWZ0ZXIgaW9tbXVm
ZF9kZXZpY2VfZ2V0X2luZm8oKSByZXQgaXMgIT0gMC4gU28gcy0+Y2FwIHdvbid0IGJlDQo+dXBk
YXRlZCB0aGVuLiBIb3BlIHRoYXQgaXMgaW50ZW5kZWQuDQoNClllcywgaW9tbXVmZF9kZXZpY2Vf
Z2V0X2luZm8oKSByZXR1cm4gcmV0ICE9MCBtZWFucyBlcnJvciBoYXBwZW4sDQp3ZSBzaG91bGQg
bm90IHVwZGF0ZSBzLT5jYXAgZGVmaW5pdGVseS4NCg0KTm9ybWFsbHkgaWYgdGhlcmUgYXJlIG11
bHRpcGxlIHZmaW8gZGV2aWNlcyBiYWNrZWQgYnkgZGlmZmVyZW50IGhvc3QgSU9NTVVzLA0KSXQn
cyBwb3NzaWJsZSBzLT5jYXAgdXBkYXRlZCBtb3JlIHRoYW4gb25jZSwgZS5nLiwgTUdBVyB1cGRh
dGU6IDU3LT41Mi0+NDguDQoNCj4NCj4qIFdpdGggdGhlIGFib3ZlIHR3ZWFrcyBpbmNsdWRlZDoN
Cj4gICAgUmV2aWV3ZWQtYnk6IFByYXNhZCBQYW5kaXQgPHBqcEBmZWRvcmFwcm9qZWN0Lm9yZz4N
Cg0KVGhhbmtzIGZvciB5b3VyIHJldmlldy4NCg0KQlJzLg0KWmhlbnpob25nDQo=

