Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D875C47DA9
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jan 2024 08:09:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUjBO-0004sA-M2; Tue, 30 Jan 2024 03:09:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kevin.tian@intel.com>)
 id 1rUjBM-0004ro-Hw
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 03:09:24 -0500
Received: from mgamail.intel.com ([198.175.65.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kevin.tian@intel.com>)
 id 1rUjBK-0000Tr-O9
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 03:09:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1706602163; x=1738138163;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=+6K95RTfWh+qc4AEzEADSGClo2NXafuk3Odi/T3ZaZo=;
 b=aU+lqGpYVvF5fsckH9dpp1joHl9wLeXjZxcFkddm3B/wYQqz0ZMfX8Sg
 zXCOyD9/4SrmpNGIP/BFF9NFRKQ8NwUb9lhp1StlT1Uz8xfFeOz1mBf8f
 HF7xZttk2FrCwKHNnMSGsfeWs0/k40IARovHptplNf6Iclq2F8dMZOhLZ
 6Jc9Kvsf/9azHY7ShUK2CH/PFyYbY5Gde0aemXeMKBdgXZQ4kZXm6/KmE
 nV1FJuUIX1jWV7IZMJJkATCCswDECdgg0MaJrljhNnXfFGPlvyf5Df2Qq
 iZOiLiOiMh02QblDQu2dCuBRYeH27FeGXT45AM+c+Vqo1F/6Ec0iEn7qy g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10968"; a="3077717"
X-IronPort-AV: E=Sophos;i="6.05,707,1701158400"; 
   d="scan'208";a="3077717"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Jan 2024 00:09:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10968"; a="858397539"
X-IronPort-AV: E=Sophos;i="6.05,707,1701158400"; d="scan'208";a="858397539"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
 by fmsmga004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 30 Jan 2024 00:09:15 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 30 Jan 2024 00:09:15 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 30 Jan 2024 00:09:15 -0800
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.40) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 30 Jan 2024 00:09:14 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S+82twWtbI65P9bISHTzOjJjlIIXwnCK/KSBIsMrfOffTl38EuYA+doVA12QMdojFvNn2UN7+49Sk1X8PdpmqGqQ4K2aCPYS3qOAyiSMWdiN3ktnuLbKXMPl7nEwi0oKO295Ved5fqf7HUjLpcQGQ8GskEwLZWQKpfwESs/GNOTsl9aUKHywikTZWBx7YhTHPTZuJJP4ne4Nyt4C/loOVDYSySMMLd379wdJb1ZxAA3clz8jBQ8gru49mcQ/VjKE4khj8qEV9FMo2tafvX5ClzOoheTDVMAeNWNTjFEllXDOD/7c9l0+z5YG1cranGJjkHBs+dZLJsMZ+hePN62mrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+6K95RTfWh+qc4AEzEADSGClo2NXafuk3Odi/T3ZaZo=;
 b=d/GWybjVLO8bPxODGCkdAP9mfayMSyB77jdUvkkLaH4WGhNGZyl/0+aE9R4GOyu8GUaXLFFzRqwhLhZkQ+ZYn/tNcYZ/SkyqvCITAUUHKfd1pL8o9pVn+N36xOtjbK6+NyLyFlf4YU7wOXOMmNbPlAKMv52fXSJXTdWiho6ydUOhQmCWSIfJGEXzP7Bba4wttH+/t+r/cUIAw0eKQlnDCRlTBS3d2kyI60+zAPrsz34xoyVfxxDtGDSYftqrvhL/XHAxLqKKhse89v7CKpiWV4lSeno/Rw3cXOYrzGQVeRmWns00543gDdlvwoTSO7rNQuHyly7pCS3Toe7qnOQPJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SN7PR11MB6923.namprd11.prod.outlook.com (2603:10b6:806:2aa::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.32; Tue, 30 Jan
 2024 08:09:11 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::a8e9:c80f:9484:f7cb]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::a8e9:c80f:9484:f7cb%3]) with mapi id 15.20.7228.029; Tue, 30 Jan 2024
 08:09:11 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Alex Williamson <alex.williamson@redhat.com>, "Kasireddy, Vivek"
 <vivek.kasireddy@intel.com>
CC: Eric Auger <eauger@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>,
 =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>,
 =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@redhat.com>, Laszlo Ersek
 <lersek@redhat.com>, "Kim, Dongwon" <dongwon.kim@intel.com>, Yanghang Liu
 <yanghliu@redhat.com>
Subject: RE: [PATCH v2] target/i386/host-cpu: Use iommu phys_bits with VFIO
 assigned devices on Intel h/w
Thread-Topic: [PATCH v2] target/i386/host-cpu: Use iommu phys_bits with VFIO
 assigned devices on Intel h/w
Thread-Index: AQHaTCUY+bWRHVT20E64Z21L6I1jorDqNbwAgADajACABv0usA==
Date: Tue, 30 Jan 2024 08:09:11 +0000
Message-ID: <BN9PR11MB5276A27C3D786EF00F37449A8C7D2@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20240118192049.1796763-1-vivek.kasireddy@intel.com>
 <8d85ff1d-fed9-49c9-9fe3-b401e0921533@redhat.com>
 <20240125142014.6c62126a.alex.williamson@redhat.com>
In-Reply-To: <20240125142014.6c62126a.alex.williamson@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|SN7PR11MB6923:EE_
x-ms-office365-filtering-correlation-id: 2f4c9e82-fb47-4516-7e48-08dc216abde8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 21HgjaE2WmEtSzTJBqSMooIr1h+O1wagizwHTyGVd1+vduZISdb0iWU7FiCNw1k4Syh9K4/9tkfi9taHVyNUk1J2mv8tqYMld0dM5DliJFwC/Rf8n+Xlz2TQj3h+53TBoEjuSB3d87QtrI/d4EAzo1JWASiI6nsMcbOP/uzWPZjBUYynYff9Lwo0rNEArBuW83AGnrMBaOOho5Q84mEo4jQoDv4QdyT3yDrtVUXsAsh85/KjTG+yPLhuGXSktokxOrXqJ51o7pbE2/qpRTilwvRJZDHGxJUNa/aggQNLXiUNQUu6f7gLMIJsBqP8o6kBA6wSpHJOSP/nP01BGDOLfnsMn5APn0U7m/RAEwgz2ulu4TVXvLYl2GK7jUXAmSej1EYbQMF6pYIi/MkQTSzoUpuSW3dAcds56Id04lRqmK8PD1YoJT59oaacq6nyEnJg+XjxoDPOY9yuxqJWNfFIYvmLu3z00QEpM1qYM8xZ7Qmc1NFLOlfanQZfgxM5FzdOei6HVVltlQD9K7SSX+FODwk2JB6fwzCJAjMlRG+JIsz+ciAvp5aK4qcObcNc0zkURFbr7io1jh8mmGzEKw7nYEpKNovvYbmaKeRUCbAo4ckGAIzKC0zLrbblWHe1j2Cq2zNeMYmsZ6hunCna3kdAA3BX2Dbpy69OLIIh7wcSLmI=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR11MB5276.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(39860400002)(346002)(136003)(376002)(396003)(230922051799003)(230273577357003)(230173577357003)(186009)(64100799003)(451199024)(1800799012)(26005)(55016003)(7696005)(6506007)(53546011)(83380400001)(33656002)(86362001)(38070700009)(82960400001)(8936002)(41300700001)(52536014)(4326008)(5660300002)(66946007)(38100700002)(9686003)(122000001)(478600001)(316002)(71200400001)(110136005)(66476007)(54906003)(76116006)(66446008)(64756008)(66556008)(2906002)(6636002)(8676002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eDVNOFJGT0N4UjBudWtTTXp0K2R0MmpEN3dmaGt4M2VEclhReXZyOHhRb1RW?=
 =?utf-8?B?OXZTbTh6VHdnZUd2N2l6OGdKaXd5L2w0NkxTRVZoVEJoQXZENGYyUXlEaFNW?=
 =?utf-8?B?d3MwaTdmK3pqNi81N2JHREljS0MvcVo3K1RHUW9VSGhqRVRGK2ZsWTlNRWhk?=
 =?utf-8?B?akRJaVRvQU9LbHZHc2V1bUFwbkNXRUNqTjZGRUNqS3dVc2Z3UVhMWTBPSW0y?=
 =?utf-8?B?aWkrc0JwY240cE5YTjBjZWZlemhtRW93T0hWWTBNd1NwM0Jmd3JRUWlnbFZt?=
 =?utf-8?B?UTdXaDc2ZTdWcmEzbE9CRkswQlYwTXJjcWlYVVhzU1JnNUNsQlE4dnd2UFd1?=
 =?utf-8?B?V3BKQWkxalhOajhRMERqVTdJOTNObk5pNjJvL3hlMW4rUk9mcDZ5cjlyM043?=
 =?utf-8?B?bFVRQnNXaTZaVnJiRFg2VjBwMEpVV2tPc0g3M1FQV09XbmUwOW9WOXR6U1dC?=
 =?utf-8?B?RzRmS3pTSTJaR0ZMdzRwYWpLUm1rVnJHL1ZvMzNVUzVQVUQydW41a1ZXUmVB?=
 =?utf-8?B?Z01kUjJkcnpmdkFya09nWkM3b1JkS1pzakRxR05Bd0hrYjVVMzVUOExmbThF?=
 =?utf-8?B?elN1bmFhVE4xdExuQmJidHdidHc0SW5wUGxORlo5cVF0ZjY3Q1lwRyt3cGl0?=
 =?utf-8?B?VVFEWXpBK1RpcG9ic0pibXE4VkhLS2VKOExGUjJxeEttQmFMTEQ1SC9sUjli?=
 =?utf-8?B?b1o0U1h2bGxGY3BpM1l4VC9HRUp5cVA4T1RFQVdPU2FJVXJOSHJYQU9EOWd1?=
 =?utf-8?B?UnlJb1dWdWU5UzYzZWZ1TVJvaUFJU0Q3VTVpRVJCU3ZobFZ2bHlwZk9WTmxk?=
 =?utf-8?B?TUJoejNla0N4akZza1J6Zzk0SWczUkMxYlVKZFdpTXp1ZFp0bHpMY0VxNmE3?=
 =?utf-8?B?Ky9MTXVKOVp4Z3VxajhHRUNhb0hHNUtHbXR6ak10aXlNN242M1IwazIvSURx?=
 =?utf-8?B?SXk4SlViOUZlWitMcW15b0h3RGxaRVB3SWIxL0lqRzFMWjV4RCtzTkhqOGds?=
 =?utf-8?B?a25UTFJhcTM0TTVxQmViMkt3UUJxQVhNNER1YUZ3WkNBZEtZdjJHbUJaU3A4?=
 =?utf-8?B?bUFlZEc2VUJzZm9SNG5IOWZuNHdSQWwxWTQ5ekxGdEhhYVhyTS9DbU02bjV5?=
 =?utf-8?B?aUFaNHRkenpwM0FMWlBOaWNvT05sSm85YlBDb3ZXMmMzc0FuSzBXYWhFUzNT?=
 =?utf-8?B?em0rSFZJc3VYaTBXcExab0FvZmhUT0pEdDd1K0prVFo4OUs3b1JqQ0lWMFRE?=
 =?utf-8?B?U2tCeDRwTG52TGFyTTI0MzhDd0ZBR0FBS0pielNIb3VhS0tpc0lqZ0pxeS9a?=
 =?utf-8?B?OEZrUENaR09FUUlGK1p5Z25Dc1Z0bkltbUNDblVFV0VaVmZBTWRBS3NPbVMv?=
 =?utf-8?B?VndqamR2N1h0d2ExQmtyQUJJZXkrU3ByYmlFdnMxU2J6ZFRwUGd3V2JqVFhY?=
 =?utf-8?B?RTJiTFdtbkpOUnlwUGlkV0wrT20wN0VlZkNVazgzZFNvZVArRTQvRGlENWR0?=
 =?utf-8?B?VUhBZDRhQ2xxVzNuaDdEU0NoaW5LcGJWUVRlNnpOUUVwMGs2RVRjSUp2VWNh?=
 =?utf-8?B?YWtUUDF1THNibURzWUxpOWF4aGpudUlENm9PaU5STUppMTZnR2locUJ0QmFO?=
 =?utf-8?B?Wkx6bTcyWXgzUnpjNWhYcFNIV1J0WmhBKzRKTGVyS0lkTkdHREovOEZuMDVC?=
 =?utf-8?B?cjhpRk1tWFRjczk1LzUraDQ5dXV4Y3BMaG1CSzRsZDdXd1IwcFVQcVgwRGFu?=
 =?utf-8?B?M005QWwwSE41RW8vR1hwWWcyVC9ia2M1bUdqeGhESFJhR1FkMVRBSzlEYmVs?=
 =?utf-8?B?S0JRVVBiWE1ibW9PbU5FZnZkK01xaVRBNmJ5S3VwM2dMR2J4OFFSV0NBNDBr?=
 =?utf-8?B?YWxVaEUyWTZNT2RHeE5vZW1pMjBNQllxMlIweHB2S3lxQ3ZEd2VFckU0OWgy?=
 =?utf-8?B?WTBSazB5UlRFdkxDTlFzQ21JQmdjYkRLK0hmbHNjYUlXdzIzcVFybmhMNExy?=
 =?utf-8?B?TWcyT3ZmU1Y4L3YzaEQ2ZGViRHgvWjg2Ym1oSkUvMGU1SGt4c2FpWHZQNVBz?=
 =?utf-8?B?emozT2dMdGlJUVVtQjFXNVdIYTVLemJpdWlHYTFQWk53c1lXMTFoTmRDamhr?=
 =?utf-8?Q?E1H1qimiMjT+KN4udL+HoZax/?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f4c9e82-fb47-4516-7e48-08dc216abde8
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jan 2024 08:09:11.5813 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: P1RzUb7DR1tlxFegwQdOqwCDFvKt3rAjIkvpryQeH26id8MfknBxQsorVVbtBXaj/o65NkNCAUe1im16tEEylg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6923
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.14; envelope-from=kevin.tian@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.29,
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

PiBGcm9tOiBBbGV4IFdpbGxpYW1zb24NCj4gU2VudDogRnJpZGF5LCBKYW51YXJ5IDI2LCAyMDI0
IDU6MjAgQU0NCj4gDQo+IE9uIFRodSwgMjUgSmFuIDIwMjQgMDk6MTg6MDIgKzAxMDANCj4gRXJp
YyBBdWdlciA8ZWF1Z2VyQHJlZGhhdC5jb20+IHdyb3RlOg0KPiANCj4gPiBIaSBWaXZlaywNCj4g
Pg0KPiA+IE9uIDEvMTgvMjQgMjA6MjAsIFZpdmVrIEthc2lyZWRkeSB3cm90ZToNCj4gPiA+DQo+
ID4gPiArICAgIGlmIChpb21tdV9waHlzX2JpdHMgJiYgcGh5c19iaXRzID4gaW9tbXVfcGh5c19i
aXRzKSB7DQo+ID4gPiArICAgICAgICBwaHlzX2JpdHMgPSBpb21tdV9waHlzX2JpdHM7DQo+ID4g
YXJlIHlvdSBhbGxvd2VkIHRvIGNoYW5nZSB0aGUgaG9zdCBjcHUgY2hhcmFjdGVyaXN0aWNzIHdp
dGhvdXQgdGFraW5nDQo+ID4gY2FyZSBvZiBjb21wYXRzIGZvciBtaWdyYXRpb24/DQo+IA0KPiBO
b3Qgb25seSBpcyBtaWdyYXRpb24gYW4gaXNzdWUsIGJ1dCBzbyBpcyBob3RwbHVnLiAgQW55dGhp
bmcgdGhhdA0KPiBhbGlnbnMgdGhlIFZNIGNvbmZpZ3VyYXRpb24gdG8gdGhlIGhvc3QgaXMgZ29p
bmcgdG8gaGF2ZSBtaWdyYXRpb24NCj4gaXNzdWVzIGFuZCBhbnl0aGluZyB0aGF0IGRvZXMgc28g
Y29uZGl0aW9uYWxseSBiYXNlZCBvbiB0aGUgY3VycmVudCBzZXQNCj4gb2YgYXR0YWNoZWQgZGV2
aWNlcyB3aWxsIGhhdmUgaG90cGx1ZyBpc3N1ZXMuDQoNCkRvZXMgaXQgbWFrZSBtb3JlIHNlbnNl
IHRvIHByaW50IG91dCBhIHdhcm5pbmcgc28gaXQncyBhZG1pbiB0byBmaWd1cmUNCm91dCB0aGUg
cHJvcGVyIHBoeXNfYml0cyB3b3JrYWJsZSB3aXRoIHRoZSBpb21tdSByZXN0cmljdGlvbiwgaW5z
dGVhZCBvZg0KZm9yY2luZy9oYXJkLWNvZGluZyBhbnkgdmFsdWUgaW1wbGljaXRseT8NCg0KPiAN
Cj4gSXQnZCBiZSBtb3JlIHBydWRlbnQgdG8gZmluZCB0aGUgbGVhc3QgY29tbW9uIGRlbm9taW5h
dG9yIHVuZGVyDQo+IC9zeXMvY2xhc3MvaW9tbXUvZG1hciovaW50ZWwtaW9tbXUvY2FwIHJlZ2Fy
ZGxlc3Mgb2YgYXR0YWNoZWQgZGV2aWNlcywNCj4gYnV0IGl0IHN0aWxsIGFmZmVjdHMgbWlncmF0
aW9uIGNvbXBhdGliaWxpdHkgYmV0d2VlbiBob3N0cy4NCj4gDQo+IEFsc28gbm90ZSB0aGF0IHZm
aW8tcGNpIGNhbiBzcGVjaWZ5IHRoZSBkZXZpY2Ugd2l0aCBlaXRoZXIgaG9zdD0gb3INCj4gc3lz
ZnNkZXY9IGFuZCB3aXRoIHZmaW8gY2RldiBzdXBwb3J0IGFuZCBpb21tdWZkIHRoZSBmaWxlIGRl
c2NyaXB0b3INCj4gZm9yIHRoZSB2ZmlvIGRldmljZSBtaWdodCBiZSBwYXNzZWQgdmlhIFNDTSBy
aWdodHMsIHNvIHdlIG1heSBub3QgaGF2ZQ0KPiBhIHJlZmVyZW5jZSB0byBpdCBpbiBzeXNmcy4g
IFRoZSBhYm92ZSBhcHBlYXJzIHRvIG9ubHkgd29yayB3aXRoIHRoZQ0KPiBob3N0PSBkZXZpY2Ug
c3BlY2lmaWNhdGlvbi4gIFRoYW5rcywNCj4gDQoNCmlvbW11ZmQgc3VwcG9ydHMgYSBJT01NVUZE
X0NNRF9HRVRfSFdfSU5GTyBjbWQgd2hpY2ggY2FuDQphbHNvIHJlcG9ydCBjYXAvZWNhcCBvbiBp
bnRlbCBpb21tdS4NCg==

