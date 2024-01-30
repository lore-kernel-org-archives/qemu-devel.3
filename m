Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6939AC46CD2
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jan 2024 06:22:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUhVC-00085E-Na; Tue, 30 Jan 2024 01:21:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1rUhVA-000851-6s
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 01:21:44 -0500
Received: from mgamail.intel.com ([134.134.136.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1rUhV7-0003HU-SF
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 01:21:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1706595701; x=1738131701;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=SooxS/o4qcImf2jHNeKXGqvMC2ZjsPZBQopNmFCw7Po=;
 b=YC87z7rxZrK5Vxp2JExcwZxpHEYv7j3XNIPvzPO9EHw951/I2Jd9Aq9K
 hJkr1P5J2iGlrfvl1vSsoFi/Ck6Ve78q0hvTikk1qLns9031LdoHOBzFf
 APkt5WsQcWYbaIEudWGbQvapIc4RY80Q2nHgX2CXjtrxT2NH2dhDeIJTG
 EbsMU92MDN8SF3A9m2okWTDFF6TvDeTsqrtyTXPIObnry7XJZcIlbTI3W
 7SZfq8GQMXTb+yTqqOhT1GEwiTC1kctA3wWML0s7UykO5GxzBcpts+JbX
 bAyLqgfsQ31HMTtaL0JBeep8IRbCgAAQOULWAvGUYe+MwtDJQ7W+cDTXL A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10968"; a="393614253"
X-IronPort-AV: E=Sophos;i="6.05,707,1701158400"; d="scan'208";a="393614253"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Jan 2024 22:21:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,707,1701158400"; 
   d="scan'208";a="3566828"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
 by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 29 Jan 2024 22:21:37 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 29 Jan 2024 22:21:36 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 29 Jan 2024 22:21:36 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 29 Jan 2024 22:21:35 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LkIbaVM/uBKKBLD1ZZH1lGrt8FKKUs4+9H5HFrgWKe85WYbQ0X+qK5N8aJhAfDl0De2YVfCck49O5LO6zCO3QsVXfIkMSnSHZr575xv9zhf3xXAhbUqy+lYzc0+7jhQitez56nu075lrqOMrU4dkhJYBS+YxaFcs4okHsQhc2Zt4rqbS6GTi6H35YMs73l0pKUeDAW9/hO4T51cZqfbSbH8UxlfWannNMad81QTHagHElNDoy3Hf+HJiBhnHPkb8hws+xliQuvJAXakyXWd2ophmhl+sXZSZu6INRRJctlyvCIavLi4bfVGuJk03JthM4NfCDJvvSnYgUo7HDpd40A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SooxS/o4qcImf2jHNeKXGqvMC2ZjsPZBQopNmFCw7Po=;
 b=eOXbDTKKWT7h04fpvPyl9typFTj6OPugLNoC8JPDuO3YfGebpTN9eR1gfsWJrcp05Gp3alAAdbT6ZeKzy58EbzVSvUDCJQQIi0Av5uWpvUE2Lq1Bh3MQdG4672a8p7qh/4y0ug5/07om5bEyaBETve3PtdxXwZedbpq4FKBqiBunKn3E7q3rSgd13gy5hQDLT3/oT916zA++WzbertEmexSYLASERp5P2aHpvkjNWCeQHSVQWAB1s+T4YZu3AxdHuiKfdSWZU1wRgHnUhz0Fgz8bTPIKWmO+blsg6PqbV39egGiUnBqDfHKlnapa6Gnb+V/8ldt+gRHbzEZ3HyuMhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA0PR11MB7185.namprd11.prod.outlook.com (2603:10b6:208:432::20)
 by DS7PR11MB5990.namprd11.prod.outlook.com (2603:10b6:8:71::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7228.34; Tue, 30 Jan 2024 06:21:33 +0000
Received: from IA0PR11MB7185.namprd11.prod.outlook.com
 ([fe80::cbc8:6370:5df2:b2df]) by IA0PR11MB7185.namprd11.prod.outlook.com
 ([fe80::cbc8:6370:5df2:b2df%4]) with mapi id 15.20.7228.029; Tue, 30 Jan 2024
 06:21:33 +0000
From: "Kasireddy, Vivek" <vivek.kasireddy@intel.com>
To: Alex Williamson <alex.williamson@redhat.com>, Eric Auger
 <eauger@redhat.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Gerd Hoffmann
 <kraxel@redhat.com>, =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?=
 <philmd@linaro.org>, =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@redhat.com>,
 Laszlo Ersek <lersek@redhat.com>, "Kim, Dongwon" <dongwon.kim@intel.com>,
 Yanghang Liu <yanghliu@redhat.com>
Subject: RE: [PATCH v2] target/i386/host-cpu: Use iommu phys_bits with VFIO
 assigned devices on Intel h/w
Thread-Topic: [PATCH v2] target/i386/host-cpu: Use iommu phys_bits with VFIO
 assigned devices on Intel h/w
Thread-Index: AQHaSkbBDztVirKMwka2xf9Igcj/FbDqOXkAgADaiwCABtW5YA==
Date: Tue, 30 Jan 2024 06:21:33 +0000
Message-ID: <IA0PR11MB7185F5E59A8E86748DE85D79F87D2@IA0PR11MB7185.namprd11.prod.outlook.com>
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
x-ms-traffictypediagnostic: IA0PR11MB7185:EE_|DS7PR11MB5990:EE_
x-ms-office365-filtering-correlation-id: d1874739-9115-4114-e614-08dc215bb461
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yLguZJ3Y0oXHS1yCPZ2vdMJ/HFq4/liAxSWzNMu/Tuq2YM/aGsuOt9fJI+Gu9P2PslPNASz3sSqCvTexxPOsHkaPIJ6oSSPzsy7q+3MhZXkU1IkuRbJSq9NUleGLWPG7DtzElPZtzBOabaCN3ALeCT6j7AjVg9jIJiXL6G5x9Gz9Gf+HwNgL6o3xdegHtNf6BQYOtgan5j/dI+4B0n6iSKMLZlOgLr+bDD3oisRDxLSlDR0B/3bxkQKOXoMn4yYLXE0dyao19qcVEcVatTrEgoc7Pg3nSnXWzPZA3fwk9fCElXuoizqfCDpLPU3mlGGP7ahUeyP/FrITgVbbaltIPCtAMbj9j3hqoioGpe5uqr7DuVKcn9asHsmqwPvo2muNF1A7AQLuOHK68EhhCrzIrN7mx9WpFOxWpIXhg2+8uomme6DuZqhjpC97wSTbVkJrNM9u/MfTymVDmcLNjMEE6LLKWiUkxgdz22GznuFBBe3uBh002vIs89WQ2fwK+Yz3DHIkTUcCLyB415ENzQw6merFlni8yS4BuoqRiA22BKXatB8J2jL032sw7AGF/nmOUCxBiq/e+lO1CZkkjTxf0HpMBhs465Z2sP0HNBIHnC6CAxUSFZYB78FjqVQGgJgLWw1mzr/STgs89K0dF4WyrQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR11MB7185.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(396003)(366004)(39860400002)(376002)(136003)(230273577357003)(230173577357003)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(55016003)(66574015)(26005)(83380400001)(7696005)(6506007)(33656002)(86362001)(82960400001)(38070700009)(8676002)(41300700001)(8936002)(5660300002)(4326008)(52536014)(122000001)(38100700002)(9686003)(76116006)(66946007)(66476007)(64756008)(110136005)(54906003)(66446008)(966005)(71200400001)(478600001)(2906002)(316002)(66556008);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ckZabll4bFQvNEQxemtPRjdGMHBNZHFJdWcxKytEMDdNaWU5N1hYcEZMTmJo?=
 =?utf-8?B?Nmc2Y2twUDZZVXVtZUZXSGJXNVIrNHIvaVVxZ0JNc3hmck5aUUhsWVlNK2VO?=
 =?utf-8?B?NWlXMXZiaHZReW1xL3M2VzEyYUNubTYxMVVxenhZQkROTy8zK2pTK1U0cThS?=
 =?utf-8?B?a0JHeHVmcFhMU3R2V3RRc2RMdzBabTZtVklibDcydlBJeWFSYnE2cDk5cWZE?=
 =?utf-8?B?VkgxOXRXU2VOTTNOc2tsOStuWVVDWVQxeTl6b0JSaFozN3BRYkJkSXQ3YmNU?=
 =?utf-8?B?WjRTTm50MnVRVEFZZGxtQWhNVmhCQW9VR1pObFUzZk1Od0d0amJQNmE5U1RB?=
 =?utf-8?B?SktISnNZR3c2Zmg5d0VmNVJGZU96dE8va0Q0OERYbFZCc2xRbGdKeEV0SjY3?=
 =?utf-8?B?L1FkOFlqajVLTzU1aVJxMmFpYUNRc0ZjRk9lUXpFVjNmNlJoWnJmbjhDV3Ew?=
 =?utf-8?B?d1lTNit6SWJpNmN1S2M0WENkcHdGd0hDdjkwK2pvZGY2VlFGazBWRDRuNXRn?=
 =?utf-8?B?ekxtM0dPUC9aTzdXMmJXYjZhbnhidndzOEl2bHhZbXVyQ081SHhzak5NK29r?=
 =?utf-8?B?MStmV2VIbTVncHM1cmNkdUF1b1hIVnViME1YeXJQdGh4VVlhdFRyRzgrS1dS?=
 =?utf-8?B?NStzRTNYbjZreWMvQW8vY0RqTGh5VzNEejR5NEY4cFNSMTNqdEF1TmtlMWVT?=
 =?utf-8?B?ZXcxZHM4SEh4M2RQVkoyalAyb0tnSExqMllORGkwNUdBS1VBZ1BEWmNGZzlX?=
 =?utf-8?B?VUREbFhVRUxPUWdRSStESUp3RHVjazJYYUpmWDBpUjlETlo1MWRSdFFHeWVQ?=
 =?utf-8?B?R25uODV0UjZsWjhxSSsvYU4rWVlkNHdQNlRCRjdlNTNWMFIyUzRyZDJoYUE1?=
 =?utf-8?B?Znl2VmgxcUtsMGNNZGJBd1lSbzE1dnlnTlBFOW5BTUpCVUxidjV5dTdXclBU?=
 =?utf-8?B?NEtRQ0NRaFBRdkZBaVV4djQydTBiMUtVeXpDNnZUL1d3S3RhUjdSclJiQkZs?=
 =?utf-8?B?TVFVV1pGY2FybmlWSFhLTXE0bHNRNy90Q2NYanpVSkF6UCtSKzhySlo2ZWRK?=
 =?utf-8?B?eStxT3dtaWtjUEJmaGhiVHhOOERUL0JlZGFKYUc2eE9nZzFHYXhyd3lFQXdX?=
 =?utf-8?B?cmI3blNKbTc1OHZDWW9KUmhQY0RoTHduVEsrU0RRU1YyNGp4b3dVRnBuMTVp?=
 =?utf-8?B?YStDYnBWOEt4QjN2cjlQc3J1K2hkRkNwZU5XcXpmZVNXS2kzNlJxMzlLZlNH?=
 =?utf-8?B?S1dVbEVoYlBOa3k2dk9FNUxhUkdrWnJ3VnZ5bm15c0xRWFFyS2RLT1EwUDZx?=
 =?utf-8?B?SzRxbS9JTVlGdW54c3ZlbWs3OWJSbitpNXpuSndPMmJLRDlkbWpaUUxsejJ3?=
 =?utf-8?B?MXpOSk5QRS9xdklFRE5zRmZydXdmelBQMWN2Vjl0NE9EOTJyVWVtcndjeW84?=
 =?utf-8?B?U1dVcTZreFJibFhwU1lWUmFhVlluZW1jU1hkeld6UWRsNVR2OW5rT1E2a1VD?=
 =?utf-8?B?aEIyWk1NYm5RU1o5Zld5SHFVV2YvYVh0MGhYSmpCQVBJaVg4MWJXTkJPZkl5?=
 =?utf-8?B?OExSZ0RwVFExTnZWQ1RnZDhYVnhSR1hTSUM3akg0ZWpGT09PbXNLRlBVNW9j?=
 =?utf-8?B?QUVjNjAxM2RzN0o1aXJhQ3JjL3ltRXg2VjJ1SDFVQ2dtVHk3TXhFbW5SV0Zn?=
 =?utf-8?B?Q3dXRVNDVk1abUtNQU9hQmRkTTNtQVRtZlpwMWN3TG5Ra1cyMWI1MThKeWl4?=
 =?utf-8?B?RExxK3gyWmJ5cnlTTHF6SzY1bVRjUG8vUkpNZ3RTdldFZVkvUW91VkF6OFBN?=
 =?utf-8?B?WE5iNDlkQnpSMDA1NzRBbW9PdjNRdWlGcVNTbHdPTmJMdXJqMjlZWHhSWTBB?=
 =?utf-8?B?NVZhN2V6Nkpna0xVSkJiVWVZU1VYZzh6VU5IL2tITlNoMlVjbTB2bUFPS3Zx?=
 =?utf-8?B?Z3d6M25lTitRZDRyNWJHY2hqOVpSdk95R3F3M0U3cW45MDYvL1I0Y3JHVU1o?=
 =?utf-8?B?WGVROW5qdGFXTVBvMzYvM3FibUN0Q0lJeHN4aUhFTWVEcnJDbys3bUNzYjBm?=
 =?utf-8?B?a3NrL0xiVGs5V0szUTNkcTJSR1VKYm9UWmJaMERHUGNURFdINFU3R2ZnYWY5?=
 =?utf-8?Q?UYC1p7N/gil5QOgxJTMZBmKC4?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA0PR11MB7185.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1874739-9115-4114-e614-08dc215bb461
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jan 2024 06:21:33.1247 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: v43xhmnyw9F5METdvmzbwLT2P+RIOxUdpRJJkOMKT+JQCcZVk4Em+TNsEUn5HrZZArdyEGCW4ExDPlQOvk4P3/ud29QqzgvGhQuouCZp48w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB5990
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=134.134.136.20;
 envelope-from=vivek.kasireddy@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -56
X-Spam_score: -5.7
X-Spam_bar: -----
X-Spam_report: (-5.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.29,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

SGkgQWxleCwgRXJpYywgDQoNCj4gPiA+IFJlY2VudCB1cGRhdGVzIGluIE9WTUYgYW5kIFNlYWJp
b3MgaGF2ZSByZXN1bHRlZCBpbiBNTUlPIHJlZ2lvbnMNCj4gPiA+IGJlaW5nIHBsYWNlZCBhdCB0
aGUgdXBwZXIgZW5kIG9mIHRoZSBwaHlzaWNhbCBhZGRyZXNzIHNwYWNlLiBBcyBhDQo+ID4gPiBy
ZXN1bHQsIHdoZW4gYSBIb3N0IGRldmljZSBpcyBhc3NpZ25lZCB0byB0aGUgR3Vlc3QgdmlhIFZG
SU8sIHRoZQ0KPiA+ID4gZm9sbG93aW5nIG1hcHBpbmcgZmFpbHVyZXMgb2NjdXIgd2hlbiBWRklP
IHRyaWVzIHRvIG1hcCB0aGUgTU1JTw0KPiA+ID4gcmVnaW9ucyBvZiB0aGUgZGV2aWNlOg0KPiA+
ID4gVkZJT19NQVBfRE1BIGZhaWxlZDogSW52YWxpZCBhcmd1bWVudA0KPiA+ID4gdmZpb19kbWFf
bWFwKDB4NTU3YjJmMjczNmQwLCAweDM4MDAwMDAwMDAwMCwgMHgxMDAwMDAwLA0KPiAweDdmOThh
YzQwMDAwMCkgPSAtMjIgKEludmFsaWQgYXJndW1lbnQpDQo+ID4gPg0KPiA+ID4gVGhlIGFib3Zl
IGZhaWx1cmVzIGFyZSBtYWlubHkgc2VlbiBvbiBzb21lIEludGVsIHBsYXRmb3JtcyB3aGVyZQ0K
PiA+ID4gdGhlIHBoeXNpY2FsIGFkZHJlc3Mgd2lkdGggaXMgbGFyZ2VyIHRoYW4gdGhlIEhvc3Qn
cyBJT01NVQ0KPiA+ID4gYWRkcmVzcyB3aWR0aC4gSW4gdGhlc2UgY2FzZXMsIFZGSU8gZmFpbHMg
dG8gbWFwIHRoZSBNTUlPIHJlZ2lvbnMNCj4gPiA+IGJlY2F1c2UgdGhlIElPVkFzIHdvdWxkIGJl
IGxhcmdlciB0aGFuIHRoZSBJT01NVSBhcGVydHVyZSByZWdpb25zLg0KPiA+ID4NCj4gPiA+IFRo
ZXJlZm9yZSwgb25lIHdheSB0byBzb2x2ZSB0aGlzIHByb2JsZW0gd291bGQgYmUgdG8gZW5zdXJl
IHRoYXQNCj4gPiA+IGNwdS0+cGh5c19iaXRzID0gPElPTU1VIHBoeXNfYml0cz4NCj4gPiA+IFRo
aXMgY2FuIGJlIGRvbmUgYnkgcGFyc2luZyB0aGUgSU9NTVUgY2FwcyB2YWx1ZSBmcm9tIHN5c2Zz
IGFuZA0KPiA+ID4gZXh0cmFjdGluZyB0aGUgYWRkcmVzcyB3aWR0aCBhbmQgdXNpbmcgaXQgdG8g
b3ZlcnJpZGUgdGhlDQo+ID4gPiBwaHlzX2JpdHMgdmFsdWUgYXMgc2hvd24gaW4gdGhpcyBwYXRj
aC4NCj4gPiA+DQo+ID4gPiBQcmV2aW91cyBhdHRlbXB0IGF0IHNvbHZpbmcgdGhpcyBpc3N1ZSBp
biBPVk1GOg0KPiA+ID4gaHR0cHM6Ly9lZGsyLmdyb3Vwcy5pby9nL2RldmVsL3RvcGljLzEwMjM1
OTEyNA0KPiA+ID4NCj4gPiA+IENjOiBHZXJkIEhvZmZtYW5uIDxrcmF4ZWxAcmVkaGF0LmNvbT4N
Cj4gPiA+IENjOiBQaGlsaXBwZSBNYXRoaWV1LURhdWTDqSA8cGhpbG1kQGxpbmFyby5vcmc+DQo+
ID4gPiBDYzogQWxleCBXaWxsaWFtc29uIDxhbGV4LndpbGxpYW1zb25AcmVkaGF0LmNvbT4NCj4g
PiA+IENjOiBDw6lkcmljIExlIEdvYXRlciA8Y2xnQHJlZGhhdC5jb20+DQo+ID4gPiBDYzogTGFz
emxvIEVyc2VrIDxsZXJzZWtAcmVkaGF0LmNvbT4NCj4gPiA+IENjOiBEb25nd29uIEtpbSA8ZG9u
Z3dvbi5raW1AaW50ZWwuY29tPg0KPiA+ID4gQWNrZWQtYnk6IEdlcmQgSG9mZm1hbm4gPGtyYXhl
bEByZWRoYXQuY29tPg0KPiA+ID4gVGVzdGVkLWJ5OiBZYW5naGFuZyBMaXUgPHlhbmdobGl1QHJl
ZGhhdC5jb20+DQo+ID4gPiBTaWduZWQtb2ZmLWJ5OiBWaXZlayBLYXNpcmVkZHkgPHZpdmVrLmth
c2lyZWRkeUBpbnRlbC5jb20+DQo+ID4gPg0KPiA+ID4gLS0tDQo+ID4gPiB2MjoNCj4gPiA+IC0g
UmVwbGFjZSB0aGUgdGVybSBwYXNzdGhyb3VnaCB3aXRoIGFzc2lnbmVkIChMYXN6bG8pDQo+ID4g
PiAtIFVwZGF0ZSB0aGUgY29tbWl0IG1lc3NhZ2UgdG8gbm90ZSB0aGF0IGJvdGggT1ZNRiBhbmQg
U2VhYmlvcw0KPiA+ID4gICBndWVzdHMgYXJlIGFmZmVjdGVkIChDw6lkcmljKQ0KPiA+ID4gLSBV
cGRhdGUgdGhlIHN1YmplY3QgdG8gaW5kaWNhdGUgd2hhdCBpcyBkb25lIGluIHRoZSBwYXRjaA0K
PiA+ID4gLS0tDQo+ID4gPiAgdGFyZ2V0L2kzODYvaG9zdC1jcHUuYyB8IDYxDQo+ICsrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrLQ0KPiA+ID4gIDEgZmlsZSBjaGFuZ2Vk
LCA2MCBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+ID4gPg0KPiA+ID4gZGlmZiAtLWdp
dCBhL3RhcmdldC9pMzg2L2hvc3QtY3B1LmMgYi90YXJnZXQvaTM4Ni9ob3N0LWNwdS5jDQo+ID4g
PiBpbmRleCA5MmVjYjcyNTRiLi41YzlmY2Q3ZGMyIDEwMDY0NA0KPiA+ID4gLS0tIGEvdGFyZ2V0
L2kzODYvaG9zdC1jcHUuYw0KPiA+ID4gKysrIGIvdGFyZ2V0L2kzODYvaG9zdC1jcHUuYw0KPiA+
ID4gQEAgLTEyLDYgKzEyLDggQEANCj4gPiA+ICAjaW5jbHVkZSAiaG9zdC1jcHUuaCINCj4gPiA+
ICAjaW5jbHVkZSAicWFwaS9lcnJvci5oIg0KPiA+ID4gICNpbmNsdWRlICJxZW11L2Vycm9yLXJl
cG9ydC5oIg0KPiA+ID4gKyNpbmNsdWRlICJxZW11L2NvbmZpZy1maWxlLmgiDQo+ID4gPiArI2lu
Y2x1ZGUgInFlbXUvb3B0aW9uLmgiDQo+ID4gPiAgI2luY2x1ZGUgInN5c2VtdS9zeXNlbXUuaCIN
Cj4gPiA+DQo+ID4gPiAgLyogTm90ZTogT25seSBzYWZlIGZvciB1c2Ugb24geDg2KC02NCkgaG9z
dHMgKi8NCj4gPiA+IEBAIC01MSwxMSArNTMsNTggQEAgc3RhdGljIHZvaWQgaG9zdF9jcHVfZW5h
YmxlX2NwdV9wbShYODZDUFUNCj4gKmNwdSkNCj4gPiA+ICAgICAgZW52LT5mZWF0dXJlc1tGRUFU
XzFfRUNYXSB8PSBDUFVJRF9FWFRfTU9OSVRPUjsNCj4gPiA+ICB9DQo+ID4gPg0KPiA+ID4gK3N0
YXRpYyBpbnQgaW50ZWxfaW9tbXVfY2hlY2sodm9pZCAqb3BhcXVlLCBRZW11T3B0cyAqb3B0cywg
RXJyb3INCj4gKiplcnJwKQ0KPiA+ID4gK3sNCj4gPiA+ICsgICAgZ19hdXRvZnJlZSBjaGFyICpk
ZXZfcGF0aCA9IE5VTEwsICppb21tdV9wYXRoID0gTlVMTCwgKmNhcHMgPQ0KPiBOVUxMOw0KPiA+
ID4gKyAgICBjb25zdCBjaGFyICpkcml2ZXIgPSBxZW11X29wdF9nZXQob3B0cywgImRyaXZlciIp
Ow0KPiA+ID4gKyAgICBjb25zdCBjaGFyICpkZXZpY2UgPSBxZW11X29wdF9nZXQob3B0cywgImhv
c3QiKTsNCj4gPiA+ICsgICAgdWludDMyX3QgKmlvbW11X3BoeXNfYml0cyA9IG9wYXF1ZTsNCj4g
PiA+ICsgICAgc3RydWN0IHN0YXQgc3Q7DQo+ID4gPiArICAgIHVpbnQ2NF90IGlvbW11X2NhcHM7
DQo+ID4gPiArDQo+ID4gPiArICAgIC8qDQo+ID4gPiArICAgICAqIENoZWNrIGlmIHRoZSB1c2Vy
IHJlcXVlc3RlZCBWRklPIGRldmljZSBhc3NpZ25tZW50LiBXZSBkb24ndCBoYXZlDQo+ID4gPiAr
ICAgICAqIHRvIGxpbWl0IHBoeXNfYml0cyBpZiB0aGVyZSBhcmUgbm8gdmFsaWQgYXNzaWduZWQg
ZGV2aWNlcy4NCj4gPiA+ICsgICAgICovDQo+ID4gPiArICAgIGlmIChnX3N0cmNtcDAoZHJpdmVy
LCAidmZpby1wY2kiKSB8fCAhZGV2aWNlKSB7DQo+ID4gPiArICAgICAgICByZXR1cm4gMDsNCj4g
PiA+ICsgICAgfQ0KPiA+ID4gKw0KPiA+ID4gKyAgICBkZXZfcGF0aCA9IGdfc3RyZHVwX3ByaW50
ZigiL3N5cy9idXMvcGNpL2RldmljZXMvJXMiLCBkZXZpY2UpOw0KPiA+ID4gKyAgICBpZiAoc3Rh
dChkZXZfcGF0aCwgJnN0KSA8IDApIHsNCj4gPiA+ICsgICAgICAgIHJldHVybiAwOw0KPiA+ID4g
KyAgICB9DQo+ID4gPiArDQo+ID4gPiArICAgIGlvbW11X3BhdGggPSBnX3N0cmR1cF9wcmludGYo
IiVzL2lvbW11L2ludGVsLWlvbW11L2NhcCIsDQo+IGRldl9wYXRoKTsNCj4gPiA+ICsgICAgaWYg
KHN0YXQoaW9tbXVfcGF0aCwgJnN0KSA8IDApIHsNCj4gPiA+ICsgICAgICAgIHJldHVybiAwOw0K
PiA+ID4gKyAgICB9DQo+ID4gPiArDQo+ID4gPiArICAgIGlmIChnX2ZpbGVfZ2V0X2NvbnRlbnRz
KGlvbW11X3BhdGgsICZjYXBzLCBOVUxMLCBOVUxMKSkgew0KPiA+ID4gKyAgICAgICAgaWYgKHNz
Y2FuZihjYXBzLCAiJWx4IiwgJmlvbW11X2NhcHMpICE9IDEpIHsNCj4gPiA+ICsgICAgICAgICAg
ICByZXR1cm4gMDsNCj4gPiA+ICsgICAgICAgIH0NCj4gPiA+ICsgICAgICAgICppb21tdV9waHlz
X2JpdHMgPSAoKGlvbW11X2NhcHMgPj4gMTYpICYgMHgzZikgKyAxOw0KPiA+ID4gKyAgICB9DQo+
ID4gPiArDQo+ID4gPiArICAgIHJldHVybiAwOw0KPiA+ID4gK30NCj4gPiA+ICsNCj4gPiA+ICtz
dGF0aWMgdWludDMyX3QgaG9zdF9pb21tdV9waHlzX2JpdHModm9pZCkNCj4gPiA+ICt7DQo+ID4g
PiArICAgIHVpbnQzMl90IGlvbW11X3BoeXNfYml0cyA9IDA7DQo+ID4gPiArDQo+ID4gPiArICAg
IHFlbXVfb3B0c19mb3JlYWNoKHFlbXVfZmluZF9vcHRzKCJkZXZpY2UiKSwNCj4gPiA+ICsgICAg
ICAgICAgICAgICAgICAgICAgaW50ZWxfaW9tbXVfY2hlY2ssICZpb21tdV9waHlzX2JpdHMsIE5V
TEwpOw0KPiA+ID4gKyAgICByZXR1cm4gaW9tbXVfcGh5c19iaXRzOw0KPiA+ID4gK30NCj4gPiA+
ICsNCj4gPiA+ICBzdGF0aWMgdWludDMyX3QgaG9zdF9jcHVfYWRqdXN0X3BoeXNfYml0cyhYODZD
UFUgKmNwdSkNCj4gPiA+ICB7DQo+ID4gPiAgICAgIHVpbnQzMl90IGhvc3RfcGh5c19iaXRzID0g
aG9zdF9jcHVfcGh5c19iaXRzKCk7DQo+ID4gPiArICAgIHVpbnQzMl90IGlvbW11X3BoeXNfYml0
cyA9IGhvc3RfaW9tbXVfcGh5c19iaXRzKCk7DQo+ID4gPiAgICAgIHVpbnQzMl90IHBoeXNfYml0
cyA9IGNwdS0+cGh5c19iaXRzOw0KPiA+ID4gLSAgICBzdGF0aWMgYm9vbCB3YXJuZWQ7DQo+ID4g
PiArICAgIHN0YXRpYyBib29sIHdhcm5lZCwgd2FybmVkMjsNCj4gPiA+DQo+ID4gPiAgICAgIC8q
DQo+ID4gPiAgICAgICAqIFByaW50IGEgd2FybmluZyBpZiB0aGUgdXNlciBzZXQgaXQgdG8gYSB2
YWx1ZSB0aGF0J3Mgbm90IHRoZQ0KPiA+ID4gQEAgLTc4LDYgKzEyNywxNiBAQCBzdGF0aWMgdWlu
dDMyX3QNCj4gaG9zdF9jcHVfYWRqdXN0X3BoeXNfYml0cyhYODZDUFUgKmNwdSkNCj4gPiA+ICAg
ICAgICAgIH0NCj4gPiA+ICAgICAgfQ0KPiA+ID4NCj4gPiA+ICsgICAgaWYgKGlvbW11X3BoeXNf
Yml0cyAmJiBwaHlzX2JpdHMgPiBpb21tdV9waHlzX2JpdHMpIHsNCj4gPiA+ICsgICAgICAgIHBo
eXNfYml0cyA9IGlvbW11X3BoeXNfYml0czsNCj4gPiBhcmUgeW91IGFsbG93ZWQgdG8gY2hhbmdl
IHRoZSBob3N0IGNwdSBjaGFyYWN0ZXJpc3RpY3Mgd2l0aG91dCB0YWtpbmcNCj4gPiBjYXJlIG9m
IGNvbXBhdHMgZm9yIG1pZ3JhdGlvbj8NCj4gDQo+IE5vdCBvbmx5IGlzIG1pZ3JhdGlvbiBhbiBp
c3N1ZSwgYnV0IHNvIGlzIGhvdHBsdWcuICBBbnl0aGluZyB0aGF0DQo+IGFsaWducyB0aGUgVk0g
Y29uZmlndXJhdGlvbiB0byB0aGUgaG9zdCBpcyBnb2luZyB0byBoYXZlIG1pZ3JhdGlvbg0KPiBp
c3N1ZXMgYW5kIGFueXRoaW5nIHRoYXQgZG9lcyBzbyBjb25kaXRpb25hbGx5IGJhc2VkIG9uIHRo
ZSBjdXJyZW50IHNldA0KPiBvZiBhdHRhY2hlZCBkZXZpY2VzIHdpbGwgaGF2ZSBob3RwbHVnIGlz
c3Vlcy4NCj4gDQo+IEl0J2QgYmUgbW9yZSBwcnVkZW50IHRvIGZpbmQgdGhlIGxlYXN0IGNvbW1v
biBkZW5vbWluYXRvciB1bmRlcg0KPiAvc3lzL2NsYXNzL2lvbW11L2RtYXIqL2ludGVsLWlvbW11
L2NhcCByZWdhcmRsZXNzIG9mIGF0dGFjaGVkIGRldmljZXMsDQo+IGJ1dCBpdCBzdGlsbCBhZmZl
Y3RzIG1pZ3JhdGlvbiBjb21wYXRpYmlsaXR5IGJldHdlZW4gaG9zdHMuDQo+IA0KPiBBbHNvIG5v
dGUgdGhhdCB2ZmlvLXBjaSBjYW4gc3BlY2lmeSB0aGUgZGV2aWNlIHdpdGggZWl0aGVyIGhvc3Q9
IG9yDQo+IHN5c2ZzZGV2PSBhbmQgd2l0aCB2ZmlvIGNkZXYgc3VwcG9ydCBhbmQgaW9tbXVmZCB0
aGUgZmlsZSBkZXNjcmlwdG9yDQo+IGZvciB0aGUgdmZpbyBkZXZpY2UgbWlnaHQgYmUgcGFzc2Vk
IHZpYSBTQ00gcmlnaHRzLCBzbyB3ZSBtYXkgbm90IGhhdmUNCj4gYSByZWZlcmVuY2UgdG8gaXQg
aW4gc3lzZnMuICBUaGUgYWJvdmUgYXBwZWFycyB0byBvbmx5IHdvcmsgd2l0aCB0aGUNCj4gaG9z
dD0gZGV2aWNlIHNwZWNpZmljYXRpb24uICBUaGFua3MsDQpUbyBhZGRyZXNzIGJvdGggbWlncmF0
aW9uIGFuZCBob3RwbHVnIHVzZS1jYXNlcywgdGhlIG9ubHkgb3B0aW9uIEkgY2FuDQpzZWUgaXMg
dG8ganVzdCBoYXJkY29kZSBwaHlzX2JpdHMgdG8gMzkgKHNtYWxsZXN0IGlvbW11IGF3IHNlZW4g
b24gcmVjZW50DQpJbnRlbCBoL3cpIGlmIGFuIEludGVsIGlvbW11IGlzIGRldGVjdGVkLg0KT3Is
IGluc3RlYWQgb2YgZG9pbmcgdGhpcyBhdXRvbWF0aWNhbGx5IHdpdGggdGhpcyBwYXRjaCwgSSBh
bSB0aGlua2luZyBvZiBqdXN0DQpwcmludGluZyBhIHdhcm5pbmcgdGhhdCwgaW4gb3JkZXIgdG8g
cHJldmVudCBWRklPIG1hcHBpbmcgZmFpbHVyZXMsIHRoZSB1c2VyDQpuZWVkcyB0byBhZGQgdGhl
IGZvbGxvd2luZyB3aGVuIGFuIEludGVsIGlvbW11IGlzIGRldGVjdGVkIHdoaWxlIGxhdW5jaGlu
Zw0KUWVtdToNCi1jcHUgaG9zdCxob3N0LXBoeXMtYml0cz1vbixob3N0LXBoeXMtYml0cy1saW1p
dD0zOSANCg0KU2luY2UgbmVpdGhlciBvZiB0aGVzZSBvcHRpb25zIGFyZSBncmVhdCwgSSBhbSB3
b25kZXJpbmcgaWYgdGhlcmUgaXMgYSBtb3JlDQplbGVnYW50IHdheSB0byBzb2x2ZSB0aGlzIHBy
b2JsZW0gdGhhdCB5b3UgY2FuIHJlY29tbWVuZC4NCg0KVGhhbmtzLA0KVml2ZWsNCg0KPiANCj4g
QWxleA0KDQo=

