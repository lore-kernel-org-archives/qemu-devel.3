Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD2ABEC01A0
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2026 08:12:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w4aOY-0005Qo-5a; Mon, 23 Mar 2026 04:12:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1w4aOV-0005QI-HM
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 04:12:15 -0400
Received: from mgamail.intel.com ([192.198.163.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1w4aOT-0006Y1-Ng
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 04:12:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1774253533; x=1805789533;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=Y/dGXjHpldir3FxVfjPnfJoqKdb33o/Yg9dhXWtLcjk=;
 b=JOX8TcSYRjiZMCcAPTJGB5965JJm+NY8DkCFXjoJasZOD560mQwg+VCp
 NJwodJnLV1km4/aGgkz2rRJwdir49eCJI2pg9VaTER351Zz4MDKZfTorL
 /ORMVDpmJEMSfb1AF6HHYsk2ORLyY2Ov6B2s/qtkg8s9sYeaBEZmaBiaC
 ij6uEZDnpMUtaJaaL9xFbfMuuU+NNJIaJoAnK1jBei5RqTHa56tGQ7V0l
 lxa9UP6SsoHRdJmyh2FZcRHfqh/HATm4g4wxYkiy46ahk92Ef5dvoAXzT
 AvnRAZ1plgk3z1Gn1gLHCssYPHR7elXgeIfoenQdqzr/ayBYZr8lbV00z Q==;
X-CSE-ConnectionGUID: hBNCfzL+RL2ilzMQt5Szqw==
X-CSE-MsgGUID: 1uRfXT+RSqeO5zajGl1rkQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11737"; a="79151898"
X-IronPort-AV: E=Sophos;i="6.23,136,1770624000"; d="scan'208";a="79151898"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Mar 2026 01:12:04 -0700
X-CSE-ConnectionGUID: wpF5f+CvRySWEgGAf/rImw==
X-CSE-MsgGUID: ZBtJjjxgTo6OU9jzheDgIg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,136,1770624000"; d="scan'208";a="228031895"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Mar 2026 01:12:04 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 23 Mar 2026 01:12:03 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 23 Mar 2026 01:12:03 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.71) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 23 Mar 2026 01:12:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ebu5I6Mn4fd/qHg5A9y471HDiFYubhayy8upDGV/dylTwmKPihxmYbst/uQqT1qAXrJpPpzZsrRMV0kfmFL4wHRm3JjmLjQ3xNTZ1TgaN9cOk2BykPOeDE+2vpfwJQOsqPuD5QAtNvds3uPlPd2/J/JDWAQZ8n7Pyv3MnO5YWjh5teY/1dgVoGMwBynRn89IfMZC0uw5ll2M4V+FbBigLWNZOc2EgiLRjVvmKcNEm5OQj1ZcsKAZnszQrgR9kGJzjNX9J1d+DmMorpscqBN4UB9N73hVRZh/wNymIvGyyXrKYX80UwI5H28AhCiHJJ6QKFAtZJE/PA7Nk0N96nZIMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y/dGXjHpldir3FxVfjPnfJoqKdb33o/Yg9dhXWtLcjk=;
 b=hZ7Rkh9FCfRacomeOEsZrQ7re5cIaJpWOkVuXUPyJSS13sWLoLPRFMfEMUsKwQ+55lAszeCblMWIVLTo2qqra6Z5WhXUbYD4C+Rvstx/HTSgerbMUEfvDs2OzBEaXuwUYviInXScX0O0rQLizLZ1sAQ3oi5tcTbNDKvaAx/z6K73uAAxJxngvFLsGShq2KVJ3cSsUlr11/OnOldg7cfgQ6LMovjU2S6eSyFUiJBydDjSIMlOP2ivmemqD3qUJAaJ9BrKVpRItFY4CXVuXypyaCBlOgcjyNigxZQhNlWW7u0rFlDQhpeo1rHntDuC8FBT1rCxFVIfyJ9oKz8KcZ9TtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12)
 by IA1PR11MB6489.namprd11.prod.outlook.com (2603:10b6:208:3a7::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.17; Mon, 23 Mar
 2026 08:12:00 +0000
Received: from IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::37b4:37a9:4f3:518b]) by IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::37b4:37a9:4f3:518b%5]) with mapi id 15.20.9723.013; Mon, 23 Mar 2026
 08:12:00 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: "Liu, Yi L" <yi.l.liu@intel.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "alex@shazbot.org" <alex@shazbot.org>, "clg@redhat.com" <clg@redhat.com>, 
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "mst@redhat.com"
 <mst@redhat.com>, "jasowang@redhat.com" <jasowang@redhat.com>,
 "jgg@nvidia.com" <jgg@nvidia.com>, "nicolinc@nvidia.com"
 <nicolinc@nvidia.com>, "skolothumtho@nvidia.com" <skolothumtho@nvidia.com>,
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>,
 "clement.mathieu--drif@eviden.com" <clement.mathieu--drif@eviden.com>, "Tian, 
 Kevin" <kevin.tian@intel.com>, "Hao, Xudong" <xudong.hao@intel.com>
Subject: RE: [PATCH v1 08/13] intel_iommu: Handle PASID entry removal for
 pc_inv_dsc request
Thread-Topic: [PATCH v1 08/13] intel_iommu: Handle PASID entry removal for
 pc_inv_dsc request
Thread-Index: AQHcrRuagpYoYycHDkaeqayzx0ooOLW3SNUAgARywmCAABrkgIAACJSQ
Date: Mon, 23 Mar 2026 08:12:00 +0000
Message-ID: <IA3PR11MB9136906BAACB87A8A3A7BE24924BA@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <20260306034409.184873-1-zhenzhong.duan@intel.com>
 <20260306034409.184873-9-zhenzhong.duan@intel.com>
 <e642e31b-49d5-49c8-af7f-53cd5768e336@intel.com>
 <IA3PR11MB9136E8022237A46CE1413042924BA@IA3PR11MB9136.namprd11.prod.outlook.com>
 <f36cb217-4ebc-4d57-8e82-b6d24c36ee02@intel.com>
In-Reply-To: <f36cb217-4ebc-4d57-8e82-b6d24c36ee02@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9136:EE_|IA1PR11MB6489:EE_
x-ms-office365-filtering-correlation-id: b89128be-8c38-4bdb-e0e8-08de88b3dbd5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|366016|376014|1800799024|56012099003|22082099003|18002099003|3613699012|38070700021;
x-microsoft-antispam-message-info: ySv3ee4b7VYoHMJFjmhNMDYxWhvKlkczLI2/jq5s2/chr6EeNJNjg5RzCmrzR87zlRipXOBAuj2UOFxwD4TGAHgR0NpS/wHlHXcX+yx2qyo6JRfSuBnWOJeNAkfvkxtMBsz1pHkdMWRb8A4ZnuRtaZGopRie0JU4iulChAocPKbkMq+3g2oAgmAs1pkC9LnFxIHZQNhcOasl3cpjRtvi/HJMNcWvLg+7zXEGy/KpfF8OtK1ZRNHBuFtyo99fV3T9pRHsrZfHsSzikM89IEJQ83XM4y52aYEopaudy4kKWqGOvJ/qUZD6ESg6V02z0qCbV4pqFGiSmsMf8/45t7wRFv1UK3/mdb3hCPD985+vxCS13UXIqmRZp2c9JYfI6kUSpcenIvFSisXKLekURN/uIgVrCKddefMIpEtKUyS5wfu0KdOUpS1lVFtaWYXZGN0m8bST/Ufcu1GR+XPxD9j4TdSrkeT18am+3JZABKAhg6CPAg+qxlQ5A1OZZ+clw2il9fX9gxYJUJYiywQE0bWicK/SSfpuaqO9UOEx7WDTjA5rl7miOBpXZSWCn7ZsJNx8aEPNGAUSoyJnPbmbmUfm29qj5Gyj7Z27Q7E6umG9xUgjDheZeSshsid7Pi6snnbctDQ3l6bgX85ZLmeb3e9em8Cp5CgxlWavkIsuVt1gx/9BDobZfjbNOBvFajc6suSvqbG+o34HJ0IbBQBW4q8kC+cDXlfZZGcxqN2pREihYtYaeihL4PfRPWrPR1fZE/wLM7Ed/okJgk4PkMzrOlgJQXT355nrJIOUtH8owh1Ckbat1c4LKe5ZNfhHMQi4tGqt
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9136.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(366016)(376014)(1800799024)(56012099003)(22082099003)(18002099003)(3613699012)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eG9HNVlUd29BS21yVHNTYzV6bWNNL2E3NzJVTGUrdHZhdDhVNkZxVnNSS3lP?=
 =?utf-8?B?alZFVS9KRlFGZUtuNUF6bW9yVlMyaHZYYkF5YWVaYWVGYlZyNC9VM2x5SGpS?=
 =?utf-8?B?WTMvY3NyT3I2V2UxU2U3dmRrZGpiL2daajRCbTY0aS9JZHk3cW5yUkVJZFhv?=
 =?utf-8?B?VzUyVDhXZ0lqT2M5Vy95enFYSVZIc2VJWGQyNXg0VG5WNU1HVXA3UXdlam9E?=
 =?utf-8?B?NkpJbGYwcHp2MG0xa3p1eGxnVUJ0UEg1TUYwYnUxQStlR3pPc3VBam54eFly?=
 =?utf-8?B?Yi9RdllzbG1wcTZsZTNsVThmYWtMZExWWGxKRjRaaHUwejhPSjQ4V2dwYUNi?=
 =?utf-8?B?aHorVHdYenVNL0RuUTZmcjBMOTdyUGZqZTV5UjNnSTA0V3N1Q1gvMnlnaDR3?=
 =?utf-8?B?UXVwUkYzWC9MUE1qbG44TG5wRDlNMjRGZ1NRSDM5MDVkTGIwQUIxLzFLQTJO?=
 =?utf-8?B?QzY5enc0cDVpMitjRFh6eHBTMStGTlk1M2RVMWJueXB5aXRPVURLckFvclc0?=
 =?utf-8?B?Rm9UdTVHVExZZEZHY2txTTdTVEZmTkk2SjBQbTVySU02WEsxR0xONiswL3VV?=
 =?utf-8?B?ZEUxMHBWdURJcHNMeERIZ1padzZWdzdqWk96VEhXS2hoK3BMZkJTOWVicExx?=
 =?utf-8?B?TDdhSkgvSFJBWkhidUh1UEF0RE4yRzJrZy9oNnZta1puYUR1alduZC9zcVlB?=
 =?utf-8?B?V3NpWU5samxpNWRIZnJLRE01SnBHSy81ZVZrTFRWZG4ya2NzbDBOb3FhUVBp?=
 =?utf-8?B?Q1VLbHBDa0xoQjZYNWFod21KU2ViMVYwMnN1ei9USlplRWU1d0VwUTgydFJH?=
 =?utf-8?B?bDRxVHRjZlZGMVBtTEFjM0dLY3lvKzRndEdVb3g3WUgrM0ZVVUhla2JlSlR5?=
 =?utf-8?B?NUY2eGV3ZHhET1lZK2hscUNKV0RZYjVMN2ExdW1oR2JDZm9ER2QwdWxLRHZY?=
 =?utf-8?B?aUQ2R3U1U1RTbmw0NWUrTlNmdXRwK3BpRnVSbGcwMWxIV015ZU9wSHk3VnFy?=
 =?utf-8?B?Um5yTm5YU08vRld1Ymluc1FSU1JVRzBBQ0p6YmJrRmpPWVRlZVRnNHA4bFJp?=
 =?utf-8?B?SE9heHU3WHM2TlpYaHdmajc2VzNUQTFDdFhlb3ZQQTl1cjNNeUE2MUxiVDBy?=
 =?utf-8?B?THhIRlJwSmhaUHh5azRNMnVGc1RWSVhDK2pLUDIyMXRsRVpMbUJlTmxabUFj?=
 =?utf-8?B?S1lNY2hya1ZhVTJDWXVLZFdSVEJYTTE3dzZFa2I0a2hYR2RqQlhkTFpFRjhE?=
 =?utf-8?B?eUxkbHQ2OUttK1VwdVNta3BRMTBWbmxIT3U5YVhIOW1wMzNYSHlUaGtLNXc5?=
 =?utf-8?B?RHhxWGk4RU8rTmpLUnZvalQrSVRSWmJOZWlMQzNJTDBEdVY3cUNoY1dtRi9B?=
 =?utf-8?B?RGFYd2xMZFdPWWRSaUZTVTRnOWMxOUFRc0ErdFRweXgvVGh5bzUvYnlxUDAx?=
 =?utf-8?B?dDFEektYR3dhaVlmSEFHbkliZzFPMDFvY09sdkMvckdrTGZqV05JL05rOW5L?=
 =?utf-8?B?WmYvK3htMWdBeXF5U214ZStUSHE0RTBjVnZpZHJnazA2d0V4T2dvVFlocVZo?=
 =?utf-8?B?UnRJZlhhSGtRbldKSkhLQkwxU0xVVVppSVJtK2x5cHB6bysyLy9pV0ZGd0FN?=
 =?utf-8?B?WFNWcnZNTldUclZVRXdqb1UveEZwMHJQeHc2RGpoYkhBS1Y5MjkxVCtrRC9I?=
 =?utf-8?B?WTl2L2FoaUh4clhPMHpyQXRldFN4VVdtNHB3bTJjNCswbDhpRkVQUTJFNkFy?=
 =?utf-8?B?blljNkFmK3ZraUFVSDc5V0JDeFZFNnc0R2F6NGY4ZTJvenVQMjVnS25Sa3FX?=
 =?utf-8?B?akw0ajJuUXBHU1ZGNitISS84ZklWYlhXcVFBaDVyaDBxSU9vMU1lRFgyRGxX?=
 =?utf-8?B?NHpJSUNmR2pOZlVmU0NpV2tSekgydkIvQkJudXl3TlJia253ODZUV0UvdUsx?=
 =?utf-8?B?MXk0Tm1iRGQwQWMxVFduNDRqQ2JPYnlSVFMvejJFbjRVclZFZnlXL1R1VVg3?=
 =?utf-8?B?ODE5czU5dUlwM0NjQm1KbUhSTzU2enFWb1FqWjNKcnVjd0dyZkFvdHFJMVAx?=
 =?utf-8?B?NFNtY2ptMzBvblM5T2RSL202MEpGZFZDQ2VQMVdtMDZHZzZSU3E2dUJTNnJY?=
 =?utf-8?B?d0Naa2NkZms2ejlKYWxOWmhuVlJQN05rNDU1N1RWK01FMEhjZktlWGdyb0xt?=
 =?utf-8?B?ajFWSEhBTXRYWGtEWHhUUHRMSGtSM296YmR5anRMVjF4dWVGN2xGNTJYT1Zz?=
 =?utf-8?B?UStscVNlM0U3aWhVZGM1VWVvWXpxMmRkdy90Q2VLcmw1RndPZjg0OFNBZXNY?=
 =?utf-8?B?MjREdVU1UDM3K0xCdHZQSEo4Mm9aYjM0clJITHZEQXFwSE51d3p6dz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: hfwtP/KGiNeDrw25Zd0fQn0TSuKdSt8ZrmBAF3M8Qg2wVBuyp9mksfdNDdS6fjy70ckXEA36uW0l8K/I9dF8t03b0ofJfwZU2lm9ARxTnWeBJT7cgeOll3zRY1t3aLzVOhQ4SciX4AlvembqcnnhJh7IZvzZa34Ijdwcm5xw/c6jWr5Yt7B53TLmGrb8/fqg3AmY7HH0hiXPXpDF3/R1QzIIjM2ne73ue6bhT/NdrXABdEoA23g3fUS+qwp8giOMKWdz6xUEl1chChqWKWWVPPTPSJ82m7bgGqlhl87X2l6AqnR+nuDITDRysQ4FIr0ip12e/KOS70hRgNfwS46H3A==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9136.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b89128be-8c38-4bdb-e0e8-08de88b3dbd5
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Mar 2026 08:12:00.1877 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VgUXSUbbICSUUarraTTuJF1K5Ba4BfJhnUip80EFThmEWNJ+jnlz6nKFw76Iz7LShHhkZ/xnCXKtG0QPx8QB7STbvdExfl3E5HMsZex5MIA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6489
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.12;
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
List-Id: qemu development <qemu-devel.nongnu.org>
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
aXVAaW50ZWwuY29tPg0KPlN1YmplY3Q6IFJlOiBbUEFUQ0ggdjEgMDgvMTNdIGludGVsX2lvbW11
OiBIYW5kbGUgUEFTSUQgZW50cnkgcmVtb3ZhbCBmb3INCj5wY19pbnZfZHNjIHJlcXVlc3QNCj4N
Cj5PbiAzLzIzLzI2IDE0OjA4LCBEdWFuLCBaaGVuemhvbmcgd3JvdGU6DQo+Pg0KPj4NCj4+PiAt
LS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPj4+IEZyb206IExpdSwgWWkgTCA8eWkubC5saXVA
aW50ZWwuY29tPg0KPj4+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjEgMDgvMTNdIGludGVsX2lvbW11
OiBIYW5kbGUgUEFTSUQgZW50cnkgcmVtb3ZhbCBmb3INCj4+PiBwY19pbnZfZHNjIHJlcXVlc3QN
Cj4+Pg0KPj4+IE9uIDMvNi8yNiAxMTo0NCwgWmhlbnpob25nIER1YW4gd3JvdGU6DQo+Pj4+IFdo
ZW4gZ3Vlc3QgZGVsZXRlcyBQQVNJRCBlbnRyaWVzLCBRRU1VIHdpbGwgY2FwdHVyZSB0aGUgcGFz
aWQgY2FjaGUNCj4+Pj4gaW52YWxpZGF0aW9uIHJlcXVlc3QsIHdhbGsgdGhyb3VnaCBwYXNpZF9j
YWNoZV9saXN0IGluIGVhY2ggcGFzc3Rocm91Z2gNCj4+Pj4gZGV2aWNlIHRvIGZpbmQgc3RhbGUg
VlREQUNDRUxQQVNJRENhY2hlRW50cnkgYW5kIGRlbGV0ZSB0aGVtLg0KPj4+DQo+Pj4gQXMgdGhl
IGNvbW1lbnQgdG8gdGhlIGxhc3QgcGF0Y2gsIEkgdGhpbmsgdGhpcyBwYXRjaCBzaG91bGQgaGFu
ZGxlIGJvdGgNCj4+PiB1cGRhdGUgYW5kIHJlbW92YWwgb2YgUEFTSUQgZW50cnkuDQo+Pj4NCj4+
Pj4gVGhpcyBoYXBwZW4gYmVmb3JlIHRoZSBQQVNJRCBlbnRyeSBhZGRpdGlvbiwgYmVjYXVzZSBh
IG5ldyBhZGRlZCBlbnRyeQ0KPj4+PiBzaG91bGQgbmV2ZXIgYmUgcmVtb3ZlZC4NCj4+Pg0KPj4+
IFRoaXMgaXMgY29uZnVzaW5nLiBUQkguIHRoaXMgb3JkZXIgaXMgbm90IHF1aXRlIGltcG9ydGFu
dCBhcyB0aGUgY3VycmVudA0KPj4+IGltcGxlbWVudGF0aW9uLCB3ZSBkb24ndCBoYXZlIG11bHRp
cGxlIHBhc2lkIGVudGlyZXMgc2hhcmUgc2FtZSBjYWNoZQ0KPj4+IGVudHJ5LCBzbyBhIGdpdmVu
IHBhc2lkIGVudHJ5LCB3ZSBlaXRoZXIgYWRkIG5ldyBjYWNoZSBlbnRyeSBvcg0KPj4+IHVwZGF0
ZS9kZWxldGUgY2FjaGUgZW50cnkuIFNvIEkgd291bGQganVzdCBkcm9wIHRoaXMgbGluZS4NCj4+
DQo+PiBPSywgd2lsbCByZW1vdmUgaXQuDQo+Pg0KPj4gSW4gZmFjdCwgdGhlIG9yZGVyIGlzIGZv
ciBwZXJmb3JtYW5jZSByZWFzb24uIEltYWdpbmcgdGhlcmUgYXJlIGxvdHMgb2YgcGFzaWQNCj5l
bnRpcmVzDQo+PiBpbiBwYXNpZF9jYWNoZV9saXN0LCB3ZSByZW1vdmUgc3RhbGUgZW50cmllcyBm
aXJzdCwgdGhlbiBpbiBhZGRpdGlvbiBjb2RlIHdoZW4gd2UNCj4+IGxvb3Agb24gcGFzaWRfY2Fj
aGVfbGlzdCB0byBzZWUgaWYgYSBuZXcgcGFzaWQgZW50cnkgYWxyZWFkeSBleGlzdHMsIHdlIGNh
biBpdGVyYXRlDQo+PiBsZXNzIGVudHJpZXMuDQo+DQo+Z290IGl0LiB5b3UgY2FuIG1hcmsgaXQg
aW4gdGhlIGNvZGUuDQoNCldpbGwgZG8uDQoNClRoYW5rcw0KWmhlbnpob25nDQoNCg==

