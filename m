Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9C0AC48286
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Feb 2024 07:35:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rWX1G-00089z-Db; Sun, 04 Feb 2024 02:34:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1rWX1A-00089g-76; Sun, 04 Feb 2024 02:34:20 -0500
Received: from mgamail.intel.com ([198.175.65.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1rWX17-0001cl-JE; Sun, 04 Feb 2024 02:34:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1707032058; x=1738568058;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=p2B/hQwxdpTYho/y5U7KRxCrN84E5mI4AGUTrdJYMOg=;
 b=CKVsfcz6/QC+J6/QUFzCk7UulPcBbHx9rgbj8/NpPVx8lCiyYVzpfhwN
 asAFillDz96g/PQcEY6Kdyd41n4+RK0asAWSbitoLgUgqC9ZmGMACMA6O
 jLHhpBPAQrF8iUonpmjph20HYPIJM+gc80DdQKRvdGh8LWrd/tj3YJq33
 9TMSi29wHyQMIRcMrJx17E5otdOsm4fKknM3yJKpfLSzVa+INcoojePaI
 TOQetzQvTpRN9Cb3mPD0UyfHs1m7Wz+nLaNByr4N7xOeGUiAPBwLasW4/
 Afym3tu1hVex9nS054UC3SGUSoNjlZzGCshtF92a25KVLVrGsjrZ3VRdE w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10973"; a="278773"
X-IronPort-AV: E=Sophos;i="6.05,242,1701158400"; 
   d="scan'208";a="278773"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Feb 2024 23:34:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,242,1701158400"; 
   d="scan'208";a="5066516"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
 by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 03 Feb 2024 23:34:11 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sat, 3 Feb 2024 23:34:10 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Sat, 3 Feb 2024 23:34:10 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Sat, 3 Feb 2024 23:34:10 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fCfEAa+JQfMCaOFXQ2myJiur20fzsgKgSeKxqc9VxEhE68E5QBUInuLRJLJDirGeykurWXqL4SQz8pAU93M5w0B9XNQHmv8rPpM0OcrdDm457S1tNfaBRCzqkm+OBGAdRGvHxvTOXyv59ISohjzr/4B9gwMFfCiUSUFpNIm3Yw+bSvmH4umkIfOGZYFYdbjyadZgLpsLUJkivlTjZUDS7KEIiDJ10iPQ4rrgfJ+4DTyM2LbN5LtBoiPA4pt7p5C3ZoIMqk3KlmmwRLWMc8RBRhs+UCfRB75VKYqeWVx/hpgp4ftZTunSQlCCrae/qbhYfhHhYSYES2mvGBRgrS1v3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p2B/hQwxdpTYho/y5U7KRxCrN84E5mI4AGUTrdJYMOg=;
 b=e0LeeJABGTRyY6RlfGO1dy4o2wBRgFBCQFn+KGGO1NgEHalnihIWL2PVx0CAbcA2xpeJlWGsogU1FqNcYNirU4TLzl4I7ZMur/IGuprdKnsliBz30R3YW8hwtHl1L13E4ATvIekE07Qpl1E0CCUELbxyh59LRmZTwlIt1z56o70CuKSgDnQ0RVlf1qzaCjjWLfGtCSzs/OMjnG8L8RYmiGbWucVEBSI76hz93IY4AV+8Hp4VTQAM6trk4mSx71hFF8ASjc/kfQoMK3ZBzeEkxfUXbiTtbonr7brs9bBcdVhYc3suLRjTMGeJzOwZ9bkmtGqJnf4tk2z490xQxndG1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by CH3PR11MB8341.namprd11.prod.outlook.com (2603:10b6:610:178::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.32; Sun, 4 Feb
 2024 07:34:07 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::d7ca:7979:6536:7ac3]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::d7ca:7979:6536:7ac3%5]) with mapi id 15.20.7228.029; Sun, 4 Feb 2024
 07:34:07 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "eric.auger.pro@gmail.com" <eric.auger.pro@gmail.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>, "jean-philippe@linaro.org" <jean-philippe@linaro.org>, 
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>, "yanghliu@redhat.com"
 <yanghliu@redhat.com>
CC: "mst@redhat.com" <mst@redhat.com>, "clg@redhat.com" <clg@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>
Subject: RE: [PATCH v2 3/3] hw: Set virtio-iommu aw-bits default value on
 pc_q35_9.0 and arm virt
Thread-Topic: [PATCH v2 3/3] hw: Set virtio-iommu aw-bits default value on
 pc_q35_9.0 and arm virt
Thread-Index: AQHaVSx0/jaTLU9t70OK/XVUd/iC9bD2nIQggAAik4CAAw4C8A==
Date: Sun, 4 Feb 2024 07:34:07 +0000
Message-ID: <SJ0PR11MB67446B94B65ABABA3F13983792402@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20240201163324.564525-1-eric.auger@redhat.com>
 <20240201163324.564525-4-eric.auger@redhat.com>
 <SJ0PR11MB67443F341958AD061E9A144D92422@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <7ecef9bc-e263-447a-9883-49e17a7f3115@redhat.com>
In-Reply-To: <7ecef9bc-e263-447a-9883-49e17a7f3115@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|CH3PR11MB8341:EE_
x-ms-office365-filtering-correlation-id: e0b5e2da-734a-4d36-80d3-08dc2553abe4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ksLIjlv6u4lW5036miGpizylsoTR/wjEkYmpxgcdYePghCndI/INdBZdNNAwX3iBpr+UXKRDJvC6vr0eX4tGZcB1HqDGyk8apjXq1FaEY2lzvNtdmWhQVlwTvKb8/zRnd1/7N5rm31TjdQYEAr7oNefZZjyAIE0/Uy2B1fiM4P7q66A2pT8kSylT3s+9yWSz0B8+vULh6OPnmJzVXZav5IGEXlSjrrw+KwCGxZgsaj4nEY1lU2+W6XBVKDkmI733O+pcgejvHkqwZLxR/j11UfntCwLPNrZylaTE2M2J6fN/2leGeRt8jrgrMPiNXAgwpRVqGUm0oBvVup2uV7lA9iS6wqwztfLP5UZzGeIFIdQhntMaAspvz10XnilzknxYDYe+ZM0geu4weI2zCUukA5xQSmPW77hzRyqX8r9JpNtXUz5ecLnIuA9M0EQS483ahg+mKrrkM6J27tJETHHiwHsDh1WgufxLOG+FjRc5HBtBYBW6RLdeFr0JqWouDtgRwtBLfLT+osYHxo9lhz4CkHQa4kbrO9MdZrI/7s1lkO790sWlWTahmPqSo8QGTGZqQmtJaelOBsb4comMFlzwacqBxKMJ+mtRuomxMYN7nI+Rkhgf6OK8EfjhdxJKp1ze
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(346002)(136003)(396003)(39860400002)(366004)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(26005)(83380400001)(41300700001)(71200400001)(82960400001)(38100700002)(122000001)(86362001)(76116006)(6506007)(7696005)(8676002)(8936002)(110136005)(66476007)(66946007)(4326008)(316002)(54906003)(7416002)(64756008)(66446008)(66556008)(5660300002)(2906002)(52536014)(9686003)(478600001)(38070700009)(33656002)(55016003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MXdLcjNxekdqTlJkdlBVb29SOG5OWitUQkFyUWJqMVZnRlFKdWYweTZWZi9w?=
 =?utf-8?B?YlJaRS9UQmhrWXNrSHFsVVhDY1I2azBCYSt3NFZFRFkyU0ZvZEdpZ0JRUldE?=
 =?utf-8?B?RmloQlh5TDNLZWtueURPN3NTKzZqR0JHOGRtRlVyM09HZUxWSE9LSU9pdUVY?=
 =?utf-8?B?eXZrakM1RUM2RmVlTFQ3UlFjc1Fud3VUNDg2KzF5bGo0RUl0QVQ5OWdEa2c1?=
 =?utf-8?B?eEhJcGkxWHViZmFNR3dmTS9nazM3SzFlY2NtY1RtMlovUHFjNFVUTWVicVZK?=
 =?utf-8?B?UWQ1UnRuSnNCMFlVcW92TG5XZFk1TURHOVhjb0xmeUtvRXdDZnlVNjAvbVh6?=
 =?utf-8?B?TStnbDExUEp2VEJSTlFQNjhaSW90RlF5ZmlrRmQ0QTY3K2FwMW50NW0yT080?=
 =?utf-8?B?K1RIemFoKy8xK2VRQ1cvallGa3M1cmRXNVJLdkVUeElMa2RVRk9hK25SRFps?=
 =?utf-8?B?MVE1RGhjNmFlMHB3cFJpcDludlBNVXFhRDQxY042NDlqY1RJaTRtaE5kOEJ2?=
 =?utf-8?B?WmlXQzE0MnlsT29abEdKTXhJOFJNNW5wTXY2RXgvQ3pvbXpiTFMwNVgvdmJV?=
 =?utf-8?B?RHVnRDR6TllaRDNtbGpLaU96QkMxZUJpTUpOclJxT0d0SldvNllSZzhSeGh4?=
 =?utf-8?B?cm5Jc0o3VGM1d1gzOWpzRVNQK0NlL1RTTzZpTFJnQ25adURMY21RSnc1cVMw?=
 =?utf-8?B?cW5XQ2J0Q0ZPbWtpcGlJcVhEUjUrY0g5c3l6WWpQNjQxWWliVVJnbGx5VXpv?=
 =?utf-8?B?cmJyL2JwRVZvZ2JFSlpHRVd1Wm5tVmdlRTRuZDRTazYzc0JidWNVNHRJZmE0?=
 =?utf-8?B?OGV4alpmbEtOaHFFcE5sKzl5ekZjNlg2YzBQVG1LSDdqZTFYOGNMTXZ5aE9k?=
 =?utf-8?B?akcvK2p0WUgzYXljdWJqb1pHMjRnbFltcWxBK1ZRU2RYVks4eEMyakdEVW8w?=
 =?utf-8?B?VUtVclMxQnkva1FtaEdha2FEY2RiVjF0bE9MREM5enhvYWI1cTk4VlA2cWpn?=
 =?utf-8?B?WnVacGZRNnBDc0hVbEk4QTIwajgvdmRQRkF0cnVCUXZNckhmRksrV0N2dVVx?=
 =?utf-8?B?by93UlZwRkxjZTdNODdhbDFsQnlzbWZEYkppaFFVd0x3T1pmTWNyWGsrbW1y?=
 =?utf-8?B?aVNKM3JoMEc3VUlRYWpGTWJIRmRWM2Y0aDJ6K1JkeWpGUUNiQ2dxYnBOUUNj?=
 =?utf-8?B?M1BISXFBT2E4ZmhteDBtZUJ0dk5BZ1VsQms0ODNEcVlwSldMQlVoMHJDL2FL?=
 =?utf-8?B?VVUxamxoZ20zZ0E1clE5L3hHVU96QVVBTUZqYU1UMC95QlRvVGsyV3Bia1dt?=
 =?utf-8?B?V1NzVXFxeTJRTS9wQzkya1NOamVWUW5yT2FMY1FVMGk2ZDlmUE1rcmo1anpw?=
 =?utf-8?B?MEhOdlFSNWZaa2M5QmYrcTlzcklDVm9kdG0vdjVHaFVGNERIMnlSaE1SOEw4?=
 =?utf-8?B?ZHh0RWhYbFZaUVFaeDRPRm9CdVpXaUhoS2Z1Ni84U3ZaSW93SWl6SmpJalJq?=
 =?utf-8?B?QVFpZGYvdXVFVUNOVUtSem5md3FLc05Pak92R1hRRFFwdFZ0VVA0MWtCSXVl?=
 =?utf-8?B?M2RKT1FBNThodU9OSW81eFN4ejYwRFMzZkFXWUpMcDNuVVhUcDRlRjNuMG5Q?=
 =?utf-8?B?SjV0Y3N5TVdkTGFMZ2kvL1FzQ2RTeDk1MVFHa3lickZ5Q0hlWnR2RnZ1VFg4?=
 =?utf-8?B?NUFwZFRScnowS2ZkK3gyOVhPV3RlTnVtbWZZZG1kRWZkckl2c1oxb2owNlg1?=
 =?utf-8?B?QkoyQWVZZHN1TWRyWEVxVHdNcjlNSHR5OW1qMXZEbkQ0bFpocFc2TGJVZUgw?=
 =?utf-8?B?SXRnRCthZklUaXZvRHh5UHk3MzROS3E2NTdwclAzdXVBbEh5SitiM3BPVUpQ?=
 =?utf-8?B?cVRLV202dWlzSUN6UGRVRnBCakxPVUZjZTVDRGRzNTJrZ01TV1JLZEYxMmlr?=
 =?utf-8?B?b1Y4SzZ2cEl3bDh5ZzZhdjBTREt1YkRxdWE5V1VyR0hmY3RLWUlmc05qV3or?=
 =?utf-8?B?ZFBBM2lXNXFEMGFhUlpvSG4wY3E4aXBiMUEzZ1dZWXZvUnRuSGtqY2pDWDlZ?=
 =?utf-8?B?UWphUURHMVpjdkhROWFESkJteUk5MGtpZTJyY2hlZzZYRjFtWmNsODMxTFI1?=
 =?utf-8?Q?lBemDCS/hFn/iC8U0h54QNOQF?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0b5e2da-734a-4d36-80d3-08dc2553abe4
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Feb 2024 07:34:07.6131 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MsAoWjEZ24lVUvxXQvRimdf0FrF6FpqdxoFod0/YUDVqBghHUULzBH5cgAM+WK5kZcgq0vpdvzlZW7QWWGB5q9DV++sTA+RYSfzakqxZmIU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8341
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.20;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.137,
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IEVyaWMgQXVnZXIgPGVyaWMu
YXVnZXJAcmVkaGF0LmNvbT4NCj5TdWJqZWN0OiBSZTogW1BBVENIIHYyIDMvM10gaHc6IFNldCB2
aXJ0aW8taW9tbXUgYXctYml0cyBkZWZhdWx0IHZhbHVlIG9uDQo+cGNfcTM1XzkuMCBhbmQgYXJt
IHZpcnQNCj4NCj5IaSBaaGVuemhvbmcsDQo+DQo+T24gMi8yLzI0IDA3OjUxLCBEdWFuLCBaaGVu
emhvbmcgd3JvdGU6DQo+PiBIaSBFcmljLA0KPj4NCj4+PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2Ut
LS0tLQ0KPj4+IEZyb206IEVyaWMgQXVnZXIgPGVyaWMuYXVnZXJAcmVkaGF0LmNvbT4NCj4+PiBw
Y19xMzVfOS4wIGFuZCBhcm0gdmlydA0KPj4+DQo+Pj4gQ3VycmVudGx5IHRoZSBkZWZhdWx0IGlu
cHV0IHJhbmdlIGNhbiBleHRlbmQgdG8gNjQgYml0cy4gT24geDg2LA0KPj4+IHdoZW4gdGhlIHZp
cnRpby1pb21tdSBwcm90ZWN0cyB2ZmlvIGRldmljZXMsIHRoZSBwaHlzaWNhbCBpb21tdQ0KPj4+
IG1heSBzdXBwb3J0IG9ubHkgMzkgYml0cy4gTGV0J3Mgc2V0IHRoZSBkZWZhdWx0IHRvIDM5LCBh
cyBkb25lDQo+Pj4gZm9yIHRoZSBpbnRlbC1pb21tdS4gT24gQVJNIHdlIHNldCA0OGIgYXMgYSBk
ZWZhdWx0IChtYXRjaGluZw0KPj4+IFNNTVV2MyBTTU1VX0lEUjUuVkFYID09IDApLg0KPj4+DQo+
Pj4gV2UgdXNlIGh3X2NvbXBhdF84XzIgdG8gaGFuZGxlIHRoZSBjb21wYXRpYmlsaXR5IGZvciBt
YWNoaW5lcw0KPj4+IGJlZm9yZSA5LjAgd2hpY2ggdXNlZCB0byBoYXZlIGEgdmlydGlvLWlvbW11
IGRlZmF1bHQgaW5wdXQgcmFuZ2UNCj4+PiBvZiA2NCBiaXRzLg0KPj4+DQo+Pj4gT2YgY291cnNl
IGlmIGF3LWJpdHMgaXMgc2V0IGZyb20gdGhlIGNvbW1hbmQgbGluZSwgdGhlIGRlZmF1bHQNCj4+
PiBpcyBvdmVycmlkZW4uDQo+Pj4NCj4+PiBTaWduZWQtb2ZmLWJ5OiBFcmljIEF1Z2VyIDxlcmlj
LmF1Z2VyQHJlZGhhdC5jb20+DQo+Pj4NCj4+PiAtLS0NCj4+Pg0KPj4+IHYxIC0+IHYyOg0KPj4+
IC0gc2V0IGF3LWJpdHMgdG8gNDhiIG9uIEFSTQ0KPj4+IC0gdXNlIGh3X2NvbXBhdF84XzIgdG8g
aGFuZGxlIHRoZSBjb21wYXQgZm9yIG9sZGVyIG1hY2hpbmVzDQo+Pj4gIHdoaWNoIHVzZWQgNjRi
IGFzIGEgZGVmYXVsdA0KPj4+IC0tLQ0KPj4+IGh3L2FybS92aXJ0LmMgICAgICAgICAgICB8IDYg
KysrKysrDQo+Pj4gaHcvY29yZS9tYWNoaW5lLmMgICAgICAgIHwgNSArKysrLQ0KPj4+IGh3L2kz
ODYvcGMuYyAgICAgICAgICAgICB8IDYgKysrKysrDQo+Pj4gaHcvdmlydGlvL3ZpcnRpby1pb21t
dS5jIHwgMiArLQ0KPj4+IDQgZmlsZXMgY2hhbmdlZCwgMTcgaW5zZXJ0aW9ucygrKSwgMiBkZWxl
dGlvbnMoLSkNCj4+Pg0KPj4+IGRpZmYgLS1naXQgYS9ody9hcm0vdmlydC5jIGIvaHcvYXJtL3Zp
cnQuYw0KPj4+IGluZGV4IGU2ZWFkMmM1YzguLjU2NTM5ZjJmYzUgMTAwNjQ0DQo+Pj4gLS0tIGEv
aHcvYXJtL3ZpcnQuYw0KPj4+ICsrKyBiL2h3L2FybS92aXJ0LmMNCj4+PiBAQCAtMjcxOCwxMCAr
MjcxOCwxNiBAQCBzdGF0aWMgdm9pZA0KPj4+IHZpcnRfbWFjaGluZV9kZXZpY2VfcHJlX3BsdWdf
Y2IoSG90cGx1Z0hhbmRsZXIgKmhvdHBsdWdfZGV2LA0KPj4+ICAgICB9IGVsc2UgaWYgKG9iamVj
dF9keW5hbWljX2Nhc3QoT0JKRUNUKGRldiksIFRZUEVfVklSVElPX01EX1BDSSkpIHsNCj4+PiAg
ICAgICAgIHZpcnRpb19tZF9wY2lfcHJlX3BsdWcoVklSVElPX01EX1BDSShkZXYpLA0KPk1BQ0hJ
TkUoaG90cGx1Z19kZXYpLA0KPj4+IGVycnApOw0KPj4+ICAgICB9IGVsc2UgaWYgKG9iamVjdF9k
eW5hbWljX2Nhc3QoT0JKRUNUKGRldiksIFRZUEVfVklSVElPX0lPTU1VX1BDSSkpDQo+ew0KPj4+
ICsgICAgICAgIHVpbnQ4X3QgYXdfYml0cyA9IG9iamVjdF9wcm9wZXJ0eV9nZXRfdWludChPQkpF
Q1QoZGV2KSwNCj4+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgImF3LWJpdHMiLCBOVUxMKTsNCj4+PiAgICAgICAgIGh3YWRkciBkYl9zdGFydCA9
IDAsIGRiX2VuZCA9IDA7DQo+Pj4gICAgICAgICBRTGlzdCAqcmVzZXJ2ZWRfcmVnaW9uczsNCj4+
PiAgICAgICAgIGNoYXIgKnJlc3ZfcHJvcF9zdHI7DQo+Pj4NCj4+PiArICAgICAgICBpZiAoIWF3
X2JpdHMpIHsNCj4+PiArICAgICAgICAgICAgcWRldl9wcm9wX3NldF91aW50OChkZXYsICJhdy1i
aXRzIiwgNDgpOw0KPj4+ICsgICAgICAgIH0NCj4+PiArDQo+Pj4gICAgICAgICBpZiAodm1zLT5p
b21tdSAhPSBWSVJUX0lPTU1VX05PTkUpIHsNCj4+PiAgICAgICAgICAgICBlcnJvcl9zZXRnKGVy
cnAsICJ2aXJ0IG1hY2hpbmUgZG9lcyBub3Qgc3VwcG9ydCBtdWx0aXBsZQ0KPklPTU1VcyIpOw0K
Pj4+ICAgICAgICAgICAgIHJldHVybjsNCj4+PiBkaWZmIC0tZ2l0IGEvaHcvY29yZS9tYWNoaW5l
LmMgYi9ody9jb3JlL21hY2hpbmUuYw0KPj4+IGluZGV4IGZiNWFmZGNhZTQuLjcwYWM5Njk1NGMg
MTAwNjQ0DQo+Pj4gLS0tIGEvaHcvY29yZS9tYWNoaW5lLmMNCj4+PiArKysgYi9ody9jb3JlL21h
Y2hpbmUuYw0KPj4+IEBAIC0zMCw5ICszMCwxMiBAQA0KPj4+ICNpbmNsdWRlICJleGVjL2NvbmZp
ZGVudGlhbC1ndWVzdC1zdXBwb3J0LmgiDQo+Pj4gI2luY2x1ZGUgImh3L3ZpcnRpby92aXJ0aW8t
cGNpLmgiDQo+Pj4gI2luY2x1ZGUgImh3L3ZpcnRpby92aXJ0aW8tbmV0LmgiDQo+Pj4gKyNpbmNs
dWRlICJody92aXJ0aW8vdmlydGlvLWlvbW11LmgiDQo+Pj4gI2luY2x1ZGUgImF1ZGlvL2F1ZGlv
LmgiDQo+Pj4NCj4+PiAtR2xvYmFsUHJvcGVydHkgaHdfY29tcGF0XzhfMltdID0ge307DQo+Pj4g
K0dsb2JhbFByb3BlcnR5IGh3X2NvbXBhdF84XzJbXSA9IHsNCj4+PiArICAgIHsgVFlQRV9WSVJU
SU9fSU9NTVVfUENJLCAiYXctYml0cyIsICI2NCIgfSwNCj4+PiArfTsNCj4+PiBjb25zdCBzaXpl
X3QgaHdfY29tcGF0XzhfMl9sZW4gPSBHX05fRUxFTUVOVFMoaHdfY29tcGF0XzhfMik7DQo+Pj4N
Cj4+PiBHbG9iYWxQcm9wZXJ0eSBod19jb21wYXRfOF8xW10gPSB7DQo+Pj4gZGlmZiAtLWdpdCBh
L2h3L2kzODYvcGMuYyBiL2h3L2kzODYvcGMuYw0KPj4+IGluZGV4IDgwMzI0NGU1Y2MuLjBlMmJj
YjQ4NDAgMTAwNjQ0DQo+Pj4gLS0tIGEvaHcvaTM4Ni9wYy5jDQo+Pj4gKysrIGIvaHcvaTM4Ni9w
Yy5jDQo+Pj4gQEAgLTE0NTgsNiArMTQ1OCw4IEBAIHN0YXRpYyB2b2lkDQo+Pj4gcGNfbWFjaGlu
ZV9kZXZpY2VfcHJlX3BsdWdfY2IoSG90cGx1Z0hhbmRsZXIgKmhvdHBsdWdfZGV2LA0KPj4+ICAg
ICB9IGVsc2UgaWYgKG9iamVjdF9keW5hbWljX2Nhc3QoT0JKRUNUKGRldiksIFRZUEVfVklSVElP
X01EX1BDSSkpIHsNCj4+PiAgICAgICAgIHZpcnRpb19tZF9wY2lfcHJlX3BsdWcoVklSVElPX01E
X1BDSShkZXYpLA0KPk1BQ0hJTkUoaG90cGx1Z19kZXYpLA0KPj4+IGVycnApOw0KPj4+ICAgICB9
IGVsc2UgaWYgKG9iamVjdF9keW5hbWljX2Nhc3QoT0JKRUNUKGRldiksIFRZUEVfVklSVElPX0lP
TU1VX1BDSSkpDQo+ew0KPj4+ICsgICAgICAgIHVpbnQ4X3QgYXdfYml0cyA9IG9iamVjdF9wcm9w
ZXJ0eV9nZXRfdWludChPQkpFQ1QoZGV2KSwNCj4+PiArICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgImF3LWJpdHMiLCBOVUxMKTsNCj4+PiAgICAgICAg
IC8qIERlY2xhcmUgdGhlIEFQSUMgcmFuZ2UgYXMgdGhlIHJlc2VydmVkIE1TSSByZWdpb24gKi8N
Cj4+PiAgICAgICAgIGNoYXIgKnJlc3ZfcHJvcF9zdHIgPSBnX3N0cmR1cF9wcmludGYoIjB4ZmVl
MDAwMDA6MHhmZWVmZmZmZjolZCIsDQo+Pj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIFZJUlRJT19JT01NVV9SRVNWX01FTV9UX01TSSk7DQo+Pj4gQEAgLTE0
NjYsNiArMTQ2OCwxMCBAQCBzdGF0aWMgdm9pZA0KPj4+IHBjX21hY2hpbmVfZGV2aWNlX3ByZV9w
bHVnX2NiKEhvdHBsdWdIYW5kbGVyICpob3RwbHVnX2RldiwNCj4+PiAgICAgICAgIHFsaXN0X2Fw
cGVuZF9zdHIocmVzZXJ2ZWRfcmVnaW9ucywgcmVzdl9wcm9wX3N0cik7DQo+Pj4gICAgICAgICBx
ZGV2X3Byb3Bfc2V0X2FycmF5KGRldiwgInJlc2VydmVkLXJlZ2lvbnMiLCByZXNlcnZlZF9yZWdp
b25zKTsNCj4+Pg0KPj4+ICsgICAgICAgIGlmICghYXdfYml0cykgew0KPj4+ICsgICAgICAgICAg
ICBxZGV2X3Byb3Bfc2V0X3VpbnQ4KGRldiwgImF3LWJpdHMiLCAzOSk7DQo+Pj4gKyAgICAgICAg
fQ0KPj4+ICsNCj4+PiAgICAgICAgIGdfZnJlZShyZXN2X3Byb3Bfc3RyKTsNCj4+PiAgICAgfQ0K
Pj4+DQo+Pj4gZGlmZiAtLWdpdCBhL2h3L3ZpcnRpby92aXJ0aW8taW9tbXUuYyBiL2h3L3ZpcnRp
by92aXJ0aW8taW9tbXUuYw0KPj4+IGluZGV4IDc4NzBiZGJlZWUuLmM0NjhlOWIxM2IgMTAwNjQ0
DQo+Pj4gLS0tIGEvaHcvdmlydGlvL3ZpcnRpby1pb21tdS5jDQo+Pj4gKysrIGIvaHcvdmlydGlv
L3ZpcnRpby1pb21tdS5jDQo+Pj4gQEAgLTE1MjksNyArMTUyOSw3IEBAIHN0YXRpYyBQcm9wZXJ0
eSB2aXJ0aW9faW9tbXVfcHJvcGVydGllc1tdID0gew0KPj4+ICAgICBERUZJTkVfUFJPUF9MSU5L
KCJwcmltYXJ5LWJ1cyIsIFZpcnRJT0lPTU1VLCBwcmltYXJ5X2J1cywNCj4+PiAgICAgICAgICAg
ICAgICAgICAgICBUWVBFX1BDSV9CVVMsIFBDSUJ1cyAqKSwNCj4+PiAgICAgREVGSU5FX1BST1Bf
Qk9PTCgiYm9vdC1ieXBhc3MiLCBWaXJ0SU9JT01NVSwgYm9vdF9ieXBhc3MsIHRydWUpLA0KPj4+
IC0gICAgREVGSU5FX1BST1BfVUlOVDgoImF3LWJpdHMiLCBWaXJ0SU9JT01NVSwgYXdfYml0cywg
NjQpLA0KPj4+ICsgICAgREVGSU5FX1BST1BfVUlOVDgoImF3LWJpdHMiLCBWaXJ0SU9JT01NVSwg
YXdfYml0cywgMCksDQo+PiBOb3QgY2xlYXIgaWYgdmlydGlvLWlvbW11IHN1cHBvcnQgb3RoZXIg
YXJjaHMgYmVzaWRlcyB4ODYgYW5kIGFybS4NCj4+IEl0IGxvb2tzIG9uIHRob3NlIGFyY2hzLCBh
d19iaXRzIGlzIGRlZmF1bHQgMCBvbiBtYWNoaW5lIDkuMCBhYm92ZQ0KPj4gYW5kIHdpbGwgZmFp
bHMgdGhlIGNoZWNrIGluIHJlYWxpemU/DQo+DQo+QXQgdGhlIG1vbWVudCB0aGUgdmlydGlvLWlv
bW11IG9ubHkgaXMgc3VwcG9ydGVkIGFsb25nIHdpdGggcTM1IGFuZA0KPmFybS12aXJ0Lg0KPk9u
bHkgdGhvc2UgbWFjaGluZXMgc2V0IHRoZSByZXNlcnZlZC1yZWdpb25zIHByb3AgYW5kIHRoZSBh
dy1iaXRzLCB3aGljaA0KPmFyZSBib3RoIHJlcXVlc3RlZCBmb3IgYSBjb3JyZWN0IGJlaGF2aW9y
Lg0KDQpDbGVhciwgdGhhbmtzIEVyaWMuDQoNClJldmlld2VkLWJ5OiBaaGVuemhvbmcgRHVhbiA8
emhlbnpob25nLmR1YW5AaW50ZWwuY29tPg0KDQpCUnMuDQpaaGVuemhvbmcNCg0KPg0KPlRoYW5r
IHlvdSBmb3IgdGhlIHJldmlldyENCj4NCj5FcmljDQo+DQo+Pg0KPj4gVGhhbmtzDQo+PiBaaGVu
emhvbmcNCj4+DQo+Pj4gICAgIERFRklORV9QUk9QX0VORF9PRl9MSVNUKCksDQo+Pj4gfTsNCj4+
Pg0KPj4+IC0tDQo+Pj4gMi40MS4wDQoNCg==

