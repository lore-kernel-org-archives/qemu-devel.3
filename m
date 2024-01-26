Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAAADC47422
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jan 2024 07:42:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rTGqf-0002a4-7M; Fri, 26 Jan 2024 02:42:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1rTGqc-0002ZZ-ME
 for qemu-devel@nongnu.org; Fri, 26 Jan 2024 02:41:58 -0500
Received: from mgamail.intel.com ([134.134.136.31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1rTGqa-0005Iv-GK
 for qemu-devel@nongnu.org; Fri, 26 Jan 2024 02:41:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1706254916; x=1737790916;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=h731M1ExJ4b4xUafp1nMQ+8JmumSMenRJ7uIl3HFf88=;
 b=Rr4btctJ0/zV4s9+6cgihY4lvENiEpmOBeYuk9THCZu38AKNXuwvNDqv
 fc9FW9f4yG/F0+DbNjJvL9j97wJmyQPiGL8KhWX9GG1YLlk19oRV3KIBL
 TJETfhRD6+c/DEGjQyb5wTAZB1JWcpbKCUdIhPDZMWI/GihYQ/DJ5veuN
 rkbPXgUs7Mj6fNqQ7YfrWk5+R22rZHBbVX6WfXlI8eczrv0jy4WSBqI5b
 nWZqZu2ISVFJLFoKn1F1P26VJOXsefwKGhIM2QqXlwZygJ4B7NQPaOCK0
 2F2V1ER9jKCEO0gw1AwI2egeErrOdg66IQd5RNuf7xeVBSu+V/CMYFTQ5 g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10964"; a="466687265"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; d="scan'208";a="466687265"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Jan 2024 23:41:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10964"; a="906237433"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; d="scan'208";a="906237433"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
 by fmsmga002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 25 Jan 2024 23:41:50 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 25 Jan 2024 23:41:49 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 25 Jan 2024 23:41:49 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 25 Jan 2024 23:41:49 -0800
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.41) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 25 Jan 2024 23:41:48 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZfPZocygzdIfjCNW8TJwk98HSXn0LebtVM45GROiiYw3vzftqkdtH2CcyjTqteINhmIefICIpbUO69bKgB7wUquEwqra5Gvo6oKAmoQ6OzScpWZ/5l9+fOKDeDcVU8WFWanv2x+L5BjFtn5QnR8IEVz0RcBPGBu/Q9CVg6MiwJhZIGGd6HcozKFpP79wxI5aVhCeupjtHqlwuXfxmLS0hkLrNm2Madqd4t+On8TogZ67Yas4dwL4oM8sOJpO4Udg/jPlwbh3/c3VdbXpOVskA+B5x16Y6vOUc3XINwU8gGMymAEPqaCUliSpOfhsk4cmFzt5xRwMXfYrV0f+PSmnWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h731M1ExJ4b4xUafp1nMQ+8JmumSMenRJ7uIl3HFf88=;
 b=GeGEVyfR1Y5r6xUAKkfjIlbBbw3eDg+5CyPRz6S+gISvRHYzbMKZ+0MCvydVhmuV3eiHbrLAZ23iECi5HXhKy0PPxxL2hE5zBnDIap040INIt0d4QFfMwliFQobsWEFHKrnnXCeqZKBFZJ13L7FsIH+LTwhCAY9daQjR1/ZHR9pN6DEQtjHTpqtFOUq6CGfsXFmd1f/ro+NiYkcJynzOs2VXFlCWmP7pNTUv8OEerTjANZ33D09xvkgbexY7MHx4b+my/laeSQQU18oF786wsftQFHOQx2N367Bcg3cNmhTl3X1GMUprMY8USbdaUGjoDcDC4vBZj9OLKKYTWy1IHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA0PR11MB7185.namprd11.prod.outlook.com (2603:10b6:208:432::20)
 by MN0PR11MB6057.namprd11.prod.outlook.com (2603:10b6:208:375::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.26; Fri, 26 Jan
 2024 07:41:46 +0000
Received: from IA0PR11MB7185.namprd11.prod.outlook.com
 ([fe80::cbc8:6370:5df2:b2df]) by IA0PR11MB7185.namprd11.prod.outlook.com
 ([fe80::cbc8:6370:5df2:b2df%4]) with mapi id 15.20.7228.022; Fri, 26 Jan 2024
 07:41:46 +0000
From: "Kasireddy, Vivek" <vivek.kasireddy@intel.com>
To: =?utf-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Gerd Hoffmann
 <kraxel@redhat.com>, Frediano Ziglio <freddy77@gmail.com>, "Kim, Dongwon"
 <dongwon.kim@intel.com>
Subject: RE: [PATCH v1 1/7] ui/spice: Add an option for users to provide a
 preferred codec
Thread-Topic: [PATCH v1 1/7] ui/spice: Add an option for users to provide a
 preferred codec
Thread-Index: AQHaSzsFdqBQGG37lku08yGaAdRdQbDlhv6AgAFvPFA=
Date: Fri, 26 Jan 2024 07:41:46 +0000
Message-ID: <IA0PR11MB71852CE27A15BEA00AD5D0B5F8792@IA0PR11MB7185.namprd11.prod.outlook.com>
References: <20240120003013.1829757-1-vivek.kasireddy@intel.com>
 <20240120003013.1829757-2-vivek.kasireddy@intel.com>
 <CAJ+F1CLL-BhebmHsBEGV+Lqm-gJ9uDktQkbYT0WGW41qL+ESdA@mail.gmail.com>
In-Reply-To: <CAJ+F1CLL-BhebmHsBEGV+Lqm-gJ9uDktQkbYT0WGW41qL+ESdA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PR11MB7185:EE_|MN0PR11MB6057:EE_
x-ms-office365-filtering-correlation-id: cb627bde-de47-4258-8d44-08dc1e423f85
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8qiM2PdCam123YnTZFmHQfGYa26Cr0OEfBjEVbTlsW2Gcywb/MzVDQXa33ytWzkASxE3C/S6KJD1kKxgxWmXsKQIQmrBk8/X4RUnj9V0qH9nbTwhtHKTl43k5ER/bkVAkXvlE8bO+B3BYLBvLV0+DGz5JeO/4B4bxU+cAl2slEwcbUPLEXYKVv/7cUifNbKpoXycA2riQEhRiOWQ0No4GnBrZ4qHChuBppaThuiKrEuapmTaNx2Ds0DEp2AHGwOdR53t0rnPrQbhvC/b1mLUQGye9QKsQfeKFzp9Of3oaDGPrAUhDu8MuTc64Aq109xAj5GGFGr+DMAV+3AP+c9Em29BTOmsaqDYM6E8M2pHp0ni7Mp94wqgPxjvxPugyZtZz94QniLABi1vMJXIX+DsOvQWZTtTlzS1c1KepYpemwyE3DIfdNZuaLaI0zOKCyn62mecGX0eqfACDm22vQWf5BZTQAGwUFJluq4xLIrLHhRNj+pWL3V3d9Vw27Ee3R4YZ27YNtlzPL/ddV1PvfMkdP9qxWenVvIgBwHoFP3vDtZUGBNYdyPQr2W91Txbt36WIn1q28jRcy6SjdxccZbaG95JlRumoTTp8k994qeZwTeL48CZVbSWl6k5pgi1RMlA
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR11MB7185.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(346002)(376002)(39860400002)(136003)(366004)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(26005)(83380400001)(82960400001)(122000001)(6506007)(7696005)(53546011)(38100700002)(71200400001)(55016003)(107886003)(38070700009)(9686003)(2906002)(478600001)(33656002)(41300700001)(86362001)(5660300002)(66556008)(54906003)(66946007)(66476007)(316002)(6916009)(66446008)(76116006)(64756008)(8676002)(8936002)(52536014)(4326008);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?N2NGdFhOU0lmWitaY1EvekhudlVJV3g3Mjk1SzhDcDk4Nml4WDV5NXNOa0RS?=
 =?utf-8?B?aDV5c2h1UGtkWW9NWllLUGc3UEhCMTdCc0JPcGovR2V1K1JmSWtTNWlSV1dq?=
 =?utf-8?B?YldTTk1yNlpoUkl3WmZMcGovZFIyTFFnNFAxVXIvVzQzK0hzLy9jbi94ZUpT?=
 =?utf-8?B?WW5pQzNzY0VWK3BVaWJPeDFPa2xIN3hjbzI3empLWkdtUjdjT3F0eHNlM3hu?=
 =?utf-8?B?ZWRtc3RKNFlyMVFwZVErcWxadkk0bFArS0pzazVDVTA4eHQ3MWYyR1RONE1U?=
 =?utf-8?B?MVRkanBIcjV3YUxUTW5MTklDUnlUc3dyVGUzRkxTYTBHdDVZbGswMnVyOEc3?=
 =?utf-8?B?K0ZBNEQzQzM4NFFPNldRVklZRi9XR0ZaaUszYnBzUGZjMnU5NnlDbFJFZmRB?=
 =?utf-8?B?dmNrRHlFbVNneGlZWmlKWXdiNjc1eUx1VWtvcGFwOUZEbi80d2pjcFdRQnAx?=
 =?utf-8?B?cTdwN044Z0J3Rm1lMGhkT0Jwbzgyc0w5WlFPeit5Q3hXUGJCWUNaOXRlSHpU?=
 =?utf-8?B?eXp4amdZbUFFZWJTa2pvb3Q0NkRxays0c01LVWxNQ1Zpa0pQa3ZpRWRaVmF4?=
 =?utf-8?B?LzFkZnZiV01tUFZGblFXSjRDd3V2Qy9kbHJOUHFpczJkTHNGWHJnS011MEpl?=
 =?utf-8?B?U0dLRmxqWFBGOFk5Mk5FdzY2cEdQaml4ZDFXQ0NQMUgvdzF0WlFhVGY5RWRl?=
 =?utf-8?B?STU3aE11Y3o2ZytDbnl5aW5mZlUvU2xzSEVPbGdFUjB6SzRBV3dyVFlrSWxH?=
 =?utf-8?B?OERlVUJDS0R1VXJxUEVGYXgwT2hvY2R4QkJsbWM3QTRCSytxN253YndiOE9D?=
 =?utf-8?B?SlRMSmpQbUdUVTFodHlOVEdIK2N6NzBINjhodEczeGFCT0dKb1VRZ1pBTm1u?=
 =?utf-8?B?MFlLMUxkSUxUU2s0SU8rL2pSa3YxdmlmQWwyclc3V0hLN2VEZE1QeENVNFhP?=
 =?utf-8?B?blQ3N3BuMlRWM3c4MlZ5eFVtZlpUZ3JHeXp5Mk4vcnRYclZDMWp0VnZUYU9u?=
 =?utf-8?B?RjEyRGk0MnRGeWs2azBrZkRxZmlKKzVxYUw3VW1ZR0IxZGY5OGNLZmMwazVh?=
 =?utf-8?B?SkJOUlpManp2QmZaMGs0dWtDZURibzRkcVNQdmtUR3hVNnRvUWhRcmFXcUVp?=
 =?utf-8?B?NmtpMll5QkV6dk1wc3A2SW9oMmZuMVFmT1M4WCsxdS9qUUZ3dkZjOCtiSGJP?=
 =?utf-8?B?N3Vxc0QyeVUvN2tnQ2dObjhScjR0UVpzbVJlRXAwc3gwbTd4WitpK0duMWJK?=
 =?utf-8?B?OG9yb2IyVTdvQm9oRkZRQmZQMXQ5ZFZvQzBSMkNXdkJPY2dPUmo0VXl0ZEJ3?=
 =?utf-8?B?RE1RcVVYeWNUNkdBSGdhTjVZSWRESitzaFBCV2lMRHhPYUR6STJoSDZqRytX?=
 =?utf-8?B?YUVNTFFGK1BlRGYxMEZpZjh6aWRRb01pUDZEczhINk0zNjRCc09jSUs0K1JE?=
 =?utf-8?B?UjA2MTJ1TWx6WnB0UHUrTDhscWdMdVRRaVprNWtBSis0N2tYRUwwZThMQjJD?=
 =?utf-8?B?bDRkZzJ1M3dXQnhwalBsYk0zdFB4bGl0b1lQNFAwTDV0WWpwMitMV2ZDbDlt?=
 =?utf-8?B?UEZkRjRrNXIwRGs3NE8vWFFIbW0wYVhSYk9FQlNJbWd0TTdGSkhQbXVMNjRi?=
 =?utf-8?B?NjZxQ1RiSDd1OW8yRnkyWWlqWG1BWGNzS1FFbnJQMFNIT0RVOHBTemZGMVU0?=
 =?utf-8?B?U2U3V2s3ckxlL2RWVTh0dTM0SzNFdVBHU1N0T3ZZVFBYMmExaGpNNGZndFox?=
 =?utf-8?B?NDN0UTdrclBpMmJueTJESDNpSTV1dGtkck5XSHJNZUhZbmxkK0FnVEJ0ZTlC?=
 =?utf-8?B?Tnc3dGRKM2wvYmpNcmFGcTVraWlLUjVHVmFaR0paZWtuQ0FYZ0NtQkJ0aDU5?=
 =?utf-8?B?SHZ2Mi9mZXY2N3BEaXNTQi8xR2NsUDV1UlQ1L3V5ZUpjNjVlWGsyVmpDOGtk?=
 =?utf-8?B?UGs0d0FoVjNmUUtuYjBFL01zZHJySXNCY3BKTmNzNFZpQWF2bU9ka0U2MHp6?=
 =?utf-8?B?SHhZeVlGTGJ6Uk12SU5XTTcyRmpOc1NteWppREt2cXVZSEd2K213YzFPOXNM?=
 =?utf-8?B?WjRiVGFCd1JLenlFdExMMitINk5IOGlSVE1ITVg3MDcrT05ZU1ZjQUVSWjk2?=
 =?utf-8?Q?0z8hYxHb6X3DiTByFALISKZ30?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA0PR11MB7185.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb627bde-de47-4258-8d44-08dc1e423f85
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jan 2024 07:41:46.1614 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7eKVNTidsyYzvnO1HJyiuvFycm5c/n3NpVnVOa43Fetdjq78MdiV4roFHIElojPAX9WT3MX5d+0tUbA5t65nja8+iQXTCUA6WdlVXSr5zBw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6057
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=134.134.136.31;
 envelope-from=vivek.kasireddy@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -58
X-Spam_score: -5.9
X-Spam_bar: -----
X-Spam_report: (-5.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.5,
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

SGkgTWFyYy1BbmRyZSwNCg0KPiANCj4gSGkNCj4gDQo+IE9uIFNhdCwgSmFuIDIwLCAyMDI0IGF0
IDQ6NTTigK9BTSBWaXZlayBLYXNpcmVkZHkNCj4gPHZpdmVrLmthc2lyZWRkeUBpbnRlbC5jb20+
IHdyb3RlOg0KPiA+DQo+ID4gR2l2aW5nIHVzZXJzIGFuIG9wdGlvbiB0byBjaG9vc2UgYSBwYXJ0
aWN1bGFyIGNvZGVjIHdpbGwgZW5hYmxlDQo+ID4gdGhlbSB0byBtYWtlIGFuIGFwcHJvcHJpYXRl
IGRlY2lzaW9uIGJhc2VkIG9uIHRoZWlyIGhhcmR3YXJlIGFuZA0KPiA+IHVzZS1jYXNlLg0KPiA+
DQo+ID4gQ2M6IEdlcmQgSG9mZm1hbm4gPGtyYXhlbEByZWRoYXQuY29tPg0KPiA+IENjOiBNYXJj
LUFuZHLDqSBMdXJlYXUgPG1hcmNhbmRyZS5sdXJlYXVAcmVkaGF0LmNvbT4NCj4gPiBDYzogRnJl
ZGlhbm8gWmlnbGlvIDxmcmVkZHk3N0BnbWFpbC5jb20+DQo+ID4gQ2M6IERvbmd3b24gS2ltIDxk
b25nd29uLmtpbUBpbnRlbC5jb20+DQo+ID4gU2lnbmVkLW9mZi1ieTogVml2ZWsgS2FzaXJlZGR5
IDx2aXZlay5rYXNpcmVkZHlAaW50ZWwuY29tPg0KPiA+DQo+ID4gLS0tDQo+ID4gdjI6DQo+ID4g
LSBEb24ndCBvdmVycmlkZSB0aGUgZGVmYXVsdCBTcGljZSBjb2RlYyBpZiBwcmVmZXJyZWQtY29k
ZWMgaXMgbm90DQo+ID4gICBwcm92aWRlZCAoRnJlZGlhbm8pDQo+ID4gLS0tDQo+ID4gIHFlbXUt
b3B0aW9ucy5oeCB8ICA1ICsrKysrDQo+ID4gIHVpL3NwaWNlLWNvcmUuYyB8IDEyICsrKysrKysr
KysrKw0KPiA+ICAyIGZpbGVzIGNoYW5nZWQsIDE3IGluc2VydGlvbnMoKykNCj4gPg0KPiA+IGRp
ZmYgLS1naXQgYS9xZW11LW9wdGlvbnMuaHggYi9xZW11LW9wdGlvbnMuaHgNCj4gPiBpbmRleCBi
NjY1NzBhZTAwLi5jYWFhZmUwMWQ1IDEwMDY0NA0KPiA+IC0tLSBhL3FlbXUtb3B0aW9ucy5oeA0K
PiA+ICsrKyBiL3FlbXUtb3B0aW9ucy5oeA0KPiA+IEBAIC0yMjYwLDYgKzIyNjAsNyBAQCBERUYo
InNwaWNlIiwgSEFTX0FSRywgUUVNVV9PUFRJT05fc3BpY2UsDQo+ID4gICAgICAiICAgICAgIFss
c3RyZWFtaW5nLXZpZGVvPVtvZmZ8YWxsfGZpbHRlcl1dWyxkaXNhYmxlLWNvcHktcGFzdGU9b258
b2ZmXVxuIg0KPiA+ICAgICAgIiAgICAgICBbLGRpc2FibGUtYWdlbnQtZmlsZS14ZmVyPW9ufG9m
Zl1bLGFnZW50LW1vdXNlPVtvbnxvZmZdXVxuIg0KPiA+ICAgICAgIiAgICAgICBbLHBsYXliYWNr
LWNvbXByZXNzaW9uPVtvbnxvZmZdXVssc2VhbWxlc3MtDQo+IG1pZ3JhdGlvbj1bb258b2ZmXV1c
biINCj4gPiArICAgICIgICAgICAgWyxwcmVmZXJyZWQtY29kZWM9PGVuY29kZXI+Ojxjb2RlYz5c
biINCj4gDQo+IFRoZSBTUElDRSBBUEkgaXMgInNwaWNlX3NlcnZlcl9zZXRfdmlkZW9fY29kZWNz
KCkiLCBsZXQncyBuYW1lIHRoZQ0KPiBvcHRpb246ICJ2aWRlby1jb2RlY3MiIHRvIGF2b2lkIGNv
bmZ1c2lvbnMuDQpJIGFtIG9rIHdpdGggInZpZGVvLWNvZGVzIiBpbnN0ZWFkIG9mICJwcmVmZXJy
ZWQtY29kZWMiLg0KDQo+IA0KPiA+ICAgICAgIiAgICAgICBbLGdsPVtvbnxvZmZdXVsscmVuZGVy
bm9kZT08ZmlsZT5dXG4iDQo+ID4gICAgICAiICAgICAgICAgICAgICAgIGVuYWJsZSBzcGljZVxu
Ig0KPiA+ICAgICAgIiAgICAgICAgICAgICAgICBhdCBsZWFzdCBvbmUgb2Yge3BvcnQsIHRscy1w
b3J0fSBpcyBtYW5kYXRvcnlcbiIsDQo+ID4gQEAgLTIzNDgsNiArMjM0OSwxMCBAQCBTUlNUDQo+
ID4gICAgICBgYHNlYW1sZXNzLW1pZ3JhdGlvbj1bb258b2ZmXWBgDQo+ID4gICAgICAgICAgRW5h
YmxlL2Rpc2FibGUgc3BpY2Ugc2VhbWxlc3MgbWlncmF0aW9uLiBEZWZhdWx0IGlzIG9mZi4NCj4g
Pg0KPiA+ICsgICAgYGBwcmVmZXJyZWQtY29kZWM9PGVuY29kZXI+Ojxjb2RlYz5gYA0KPiA+ICsg
ICAgICAgIFByb3ZpZGUgdGhlIHByZWZlcnJlZCBjb2RlYyB0aGUgU3BpY2Ugc2VydmVyIHNob3Vs
ZCB1c2UuDQo+ID4gKyAgICAgICAgRGVmYXVsdCB3b3VsZCBiZSBzcGljZTptanBlZy4NCj4gDQo+
IFRoZSBTUElDRSBBUEkgc2F5czoNCj4gICogQGNvZGVjczogYSBjb2RlYyBzdHJpbmcgaW4gdGhl
IGZvbGxvd2luZyBmb3JtYXQ6DQo+IGVuY29kZXI6Y29kZWM7ZW5jb2Rlcjpjb2RlYw0KPiANCj4g
QnV0IHRoZSBkb2MgZG9lc24ndCBzYXkgd2hldGhlciB0aGUgb3JkZXIgaXMgaW1wb3J0YW50LCBh
bmQgZG9lc24ndA0KPiBnaXZlIG1vcmUgZGV0YWlscyBvbiB0aGUgImVuY29kZXI6Y29kZWMiIGZv
cm1hdC4NCj4gDQo+IEFsc28gcmVhZGluZyB0aGUgY29kZSwgaXQgc2VlbXMgImF1dG8iIGhhcyBh
IHNwZWNpYWwgbWVhbmluZyBmb3INCj4gZGVmYXVsdCB2aWRlbyBjb2RlY3MuDQpBbHRob3VnaCwg
SSBhbSB1c2luZyBzcGljZV9zZXJ2ZXJfc2V0X3ZpZGVvX2NvZGVjcygpIEFQSSwgbXkgaW5pdGlh
bCBnb2FsDQp3aXRoIHRoaXMgb3B0aW9uIGlzIGZvciB0aGUgdXNlciB0byBzcGVjaWZ5IG9uZSA8
ZW5jb2Rlcj46PGNvZGVjPiBlbnRyeQ0Kb25seS4gSSBndWVzcyBpdCBtaWdodCBiZSBPSyB0byBo
YXZlIHRoZSB1c2VyIHNwZWNpZnkgYSBsaXN0IGFzIGxvbmcgYXMgU3BpY2UgcGlja3MNCnRoZSBm
aXJzdCBlbnRyeSAoYWthIHByZWZlcnJlZCkgYW5kIGZhbGxzIGJhY2sgdG8gdGhlIG5leHQgaWYg
aXQgY2Fubm90IGNyZWF0ZSBvcg0KdXNlIHRoZSBlbmNvZGVyIGFzc29jaWF0ZWQgd2l0aCB0aGUg
Zmlyc3QgZW50cnkuDQoNCj4gDQo+ID4gKw0KPiA+ICAgICAgYGBnbD1bb258b2ZmXWBgDQo+ID4g
ICAgICAgICAgRW5hYmxlL2Rpc2FibGUgT3BlbkdMIGNvbnRleHQuIERlZmF1bHQgaXMgb2ZmLg0K
PiA+DQo+ID4gZGlmZiAtLWdpdCBhL3VpL3NwaWNlLWNvcmUuYyBiL3VpL3NwaWNlLWNvcmUuYw0K
PiA+IGluZGV4IGRiMjFkYjJjOTQuLjEzYmZiZTRlODkgMTAwNjQ0DQo+ID4gLS0tIGEvdWkvc3Bp
Y2UtY29yZS5jDQo+ID4gKysrIGIvdWkvc3BpY2UtY29yZS5jDQo+ID4gQEAgLTQ4OCw2ICs0ODgs
OSBAQCBzdGF0aWMgUWVtdU9wdHNMaXN0IHFlbXVfc3BpY2Vfb3B0cyA9IHsNCj4gPiAgICAgICAg
ICB9LHsNCj4gPiAgICAgICAgICAgICAgLm5hbWUgPSAic3RyZWFtaW5nLXZpZGVvIiwNCj4gPiAg
ICAgICAgICAgICAgLnR5cGUgPSBRRU1VX09QVF9TVFJJTkcsDQo+ID4gKyAgICAgICAgfSx7DQo+
ID4gKyAgICAgICAgICAgIC5uYW1lID0gInByZWZlcnJlZC1jb2RlYyIsDQo+ID4gKyAgICAgICAg
ICAgIC50eXBlID0gUUVNVV9PUFRfU1RSSU5HLA0KPiA+ICAgICAgICAgIH0sew0KPiA+ICAgICAg
ICAgICAgICAubmFtZSA9ICJhZ2VudC1tb3VzZSIsDQo+ID4gICAgICAgICAgICAgIC50eXBlID0g
UUVNVV9PUFRfQk9PTCwNCj4gPiBAQCAtNjYzLDYgKzY2Niw3IEBAIHN0YXRpYyB2b2lkIHFlbXVf
c3BpY2VfaW5pdCh2b2lkKQ0KPiA+ICAgICAgY2hhciAqeDUwOV9rZXlfZmlsZSA9IE5VTEwsDQo+
ID4gICAgICAgICAgKng1MDlfY2VydF9maWxlID0gTlVMTCwNCj4gPiAgICAgICAgICAqeDUwOV9j
YWNlcnRfZmlsZSA9IE5VTEw7DQo+ID4gKyAgICBjb25zdCBjaGFyICpwcmVmZXJyZWRfY29kZWMg
PSBOVUxMOw0KPiA+ICAgICAgaW50IHBvcnQsIHRsc19wb3J0LCBhZGRyX2ZsYWdzOw0KPiA+ICAg
ICAgc3BpY2VfaW1hZ2VfY29tcHJlc3Npb25fdCBjb21wcmVzc2lvbjsNCj4gPiAgICAgIHNwaWNl
X3dhbl9jb21wcmVzc2lvbl90IHdhbl9jb21wcjsNCj4gPiBAQCAtODAyLDYgKzgwNiwxNCBAQCBz
dGF0aWMgdm9pZCBxZW11X3NwaWNlX2luaXQodm9pZCkNCj4gPiAgICAgICAgICBzcGljZV9zZXJ2
ZXJfc2V0X3N0cmVhbWluZ192aWRlbyhzcGljZV9zZXJ2ZXIsDQo+IFNQSUNFX1NUUkVBTV9WSURF
T19PRkYpOw0KPiA+ICAgICAgfQ0KPiA+DQo+ID4gKyAgICBwcmVmZXJyZWRfY29kZWMgPSBxZW11
X29wdF9nZXQob3B0cywgInByZWZlcnJlZC1jb2RlYyIpOw0KPiA+ICsgICAgaWYgKHByZWZlcnJl
ZF9jb2RlYykgew0KPiA+ICsgICAgICAgIGlmIChzcGljZV9zZXJ2ZXJfc2V0X3ZpZGVvX2NvZGVj
cyhzcGljZV9zZXJ2ZXIsIHByZWZlcnJlZF9jb2RlYykpIHsNCj4gDQo+IFNhZGx5LCB0aGUgQVBJ
IGp1c3QgcmV0dXJucyAwIGlmIG9uZSBvZiB0aGUgY29kZWMgd2FzIGFjY2VwdGVkLCBub3QNCj4g
Z3JlYXQgaWYgeW91IHdhbnQgYSBzcGVjaWZpYyBzZXQgb2YgY29kZWNzLg0KSUlVQywgYWx0aG91
Z2ggYSB1c2VyIGNhbiBzcGVjaWZ5IGEgc2V0IG9mIGNvZGVjcywgb25seSBvbmUgY2FuIGJ5IGFj
dGl2ZWx5IHVzZWQgYXQNCmFueSBnaXZlbiB0aW1lIChhdC1sZWFzdCB3aXRoIEdzdHJlYW1lciBv
bmVzLCBub3QgU3BpY2UgY29kZWNzKSB3aXRoIG15IHVzZS1jYXNlIChnbD1vbikuDQoNClRoYW5r
cywNClZpdmVrDQoNCj4gDQo+IG90aGVyd2lzZSwgbGd0bQ0KPiANCj4gDQo+ID4gKyAgICAgICAg
ICAgIGVycm9yX3JlcG9ydCgiUHJlZmVycmVkIGNvZGVjIG5hbWUgaXMgbm90IHZhbGlkIik7DQo+
ID4gKyAgICAgICAgICAgIGV4aXQoMSk7DQo+ID4gKyAgICAgICAgfQ0KPiA+ICsgICAgfQ0KPiA+
ICsNCj4gPiAgICAgIHNwaWNlX3NlcnZlcl9zZXRfYWdlbnRfbW91c2UNCj4gPiAgICAgICAgICAo
c3BpY2Vfc2VydmVyLCBxZW11X29wdF9nZXRfYm9vbChvcHRzLCAiYWdlbnQtbW91c2UiLCAxKSk7
DQo+ID4gICAgICBzcGljZV9zZXJ2ZXJfc2V0X3BsYXliYWNrX2NvbXByZXNzaW9uDQo+ID4gLS0N
Cj4gPiAyLjM5LjINCj4gPg0KPiA+DQo+IA0KPiANCj4gLS0NCj4gTWFyYy1BbmRyw6kgTHVyZWF1
DQo=

