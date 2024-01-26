Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7862C47422
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jan 2024 07:39:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rTGnV-0006FQ-II; Fri, 26 Jan 2024 02:38:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1rTGnS-0006E7-W3
 for qemu-devel@nongnu.org; Fri, 26 Jan 2024 02:38:43 -0500
Received: from mgamail.intel.com ([134.134.136.31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1rTGnQ-0004KU-RJ
 for qemu-devel@nongnu.org; Fri, 26 Jan 2024 02:38:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1706254720; x=1737790720;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=78/6tjLylEsrUT+T6Gqoy5/ctw7sbPtFedPCzceIXeE=;
 b=UzJIYrg824MqqFQRLp6Z80jtHQk1X6kvblu0g/Z03wCS2tfWohCVZh80
 sx56g02P70nm6+EilGfjGltcr5F8JCASkA53BGKv8jnIVXcHuBYBv8OG0
 w+RqDRrZIoV73Z4RoIlJWJq6FgxuDv3SL+PpvqqXtkLEV+oQit8p16P/Z
 sPK/5KEQsMI8SI5GpfK+v78203hmbgdwDDHtlmRoR7DtKw1/qgx5568V9
 f9Y4ukLrWqEPxeVpaFnYwDYCLdnjY8v2wehoR/hCsR/VBIJnyusU6/Uip
 9uOCK710QKoDP8zEchBS0B/NpDMzxNn0ADWtc1Piglli4TZ/BTA/NvTIm g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10964"; a="466686580"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; d="scan'208";a="466686580"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Jan 2024 23:38:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10964"; a="906236243"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; d="scan'208";a="906236243"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
 by fmsmga002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 25 Jan 2024 23:38:37 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 25 Jan 2024 23:38:36 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 25 Jan 2024 23:38:36 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 25 Jan 2024 23:38:36 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A+GXJ1GHLbqcAnxshCBCOCwOk2NOy5yqxcViqJS21jibuBpWCQiP6Il+7GUYyBWoOWV4aoszGQml1i1RUy0OAxURvkV/vATUN2SKFJEqoAOhqFovjXBMF36nPCbtFqAjEnwRMZ1DB4OlJw57Om8KaotxbQKcYo1eDTtcvHo9tq6QV9EPdVfw6uGcraIHW+gJHvVrJPVH3QNqvTOtzjlvumuMqt2bFswaOlspnKR7a15oHGqPTw8ISaSZjaHUiIJ3HUn+h28rsI2F7kZ9U/aq/1sV5kaCSj2RqffdJJO+enhFzOW4getIKEYahYVicQGv39nG34rqFQBcxafWfFH0gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=78/6tjLylEsrUT+T6Gqoy5/ctw7sbPtFedPCzceIXeE=;
 b=JpRdfEe1Hd/if1PIrMMSuJdO950xMp8PH3GDsvsyOV/T8i+iTQlzEjzHcfjWaaMW8BwAnKNrC1ho2sDOYyrf4FJoF9N97IcELe5LSwJkovpomUeectrI815dyF4y5XdGt86ICSPuyAAFBd48gGT4YYyiAIpK60MYMt0vi5XJlChRayKaDZ4SqtzbuTrPM94bojhvXIxdN59bcW9sVrvto23i0Vq6i/5sBpcvJRutKXsbDM9GDcQqUUSYewy84HDesg5q5AnYzo+06G2sSmnLWwvMyOrOHp74rRPcI3NOMTbaL6+OJbLZKnc11jcUq+IDat0/vszi6bve9YhthydS1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA0PR11MB7185.namprd11.prod.outlook.com (2603:10b6:208:432::20)
 by CY5PR11MB6368.namprd11.prod.outlook.com (2603:10b6:930:38::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.27; Fri, 26 Jan
 2024 07:38:34 +0000
Received: from IA0PR11MB7185.namprd11.prod.outlook.com
 ([fe80::cbc8:6370:5df2:b2df]) by IA0PR11MB7185.namprd11.prod.outlook.com
 ([fe80::cbc8:6370:5df2:b2df%4]) with mapi id 15.20.7228.022; Fri, 26 Jan 2024
 07:38:33 +0000
From: "Kasireddy, Vivek" <vivek.kasireddy@intel.com>
To: =?utf-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Gerd Hoffmann
 <kraxel@redhat.com>, Frediano Ziglio <freddy77@gmail.com>, "Kim, Dongwon"
 <dongwon.kim@intel.com>
Subject: RE: [PATCH v1 3/7] ui/spice: Submit the gl_draw requests at 60 FPS
 for remote clients
Thread-Topic: [PATCH v1 3/7] ui/spice: Submit the gl_draw requests at 60 FPS
 for remote clients
Thread-Index: AQHaSzsD2qAmDxo9dUy3eP8OlBq64bDlhvKAgAFp8GA=
Date: Fri, 26 Jan 2024 07:38:33 +0000
Message-ID: <IA0PR11MB718558F4CE44998CD408224AF8792@IA0PR11MB7185.namprd11.prod.outlook.com>
References: <20240120003013.1829757-1-vivek.kasireddy@intel.com>
 <20240120003013.1829757-4-vivek.kasireddy@intel.com>
 <CAJ+F1CKUr7dGjVG+Fcvc4sBRFAncBRTTQ76uZs9SkNCsQgBZUg@mail.gmail.com>
In-Reply-To: <CAJ+F1CKUr7dGjVG+Fcvc4sBRFAncBRTTQ76uZs9SkNCsQgBZUg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PR11MB7185:EE_|CY5PR11MB6368:EE_
x-ms-office365-filtering-correlation-id: e57bd322-9ecc-4c19-06d4-08dc1e41cce1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wSAFd5rIfWUlaVfUb8vec0prS1i+lkvxCzsKkkmlsKQfOmqFQuWQx6OhgobJZoT+RUzg6TOvwZD7Atv6T4Zj11UcoiwbanWEhLbia8/ff85G3oQ8ZGeXTNaD9xCB6trzXa+UMF3HFNgnefcMBdPZgRKLJYHOvOOe/JkLEfmdSi+R3MJIh5gg6zTd+9lWe03cH7yFm+plkVnrDyWKtsBqQzZLcsG54B+YFFpN7kaRkUl32xktkeEkYBpX1ouihrV3PC4PtNvPLPeLourRp6HoTMw17rQbikIc8RYgw1RTHDvs/FByZQxoBXxbPMcSIRQcW8eYhKh9rK49mfeB6t5Hjw5S+A9tfgPFeBJiRfei12BNpJRCoOQNCDLOc9rNoOu4fI7UjjNg89vczBN/HlffjoGwNBw73AWBPPORruExpLSKZcSJ69KbOjZbHVHtic8GZg6vzUnkkPyIEj+Ecn70i4AjIoihuQzLIUrUgFtPbo+303on76+bGoNqTvUNJZnH/+rtBpL5QDuf8zKb8iJdeiMncNObfKyArW67P2kUahRpkDqEEsdSSI90HkokEQz6hO8z7rYZiLEon6kSF2NT3bXuXwbifDW7Q6vMpcd7puI=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR11MB7185.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(376002)(136003)(396003)(366004)(39860400002)(230922051799003)(186009)(1800799012)(451199024)(64100799003)(107886003)(83380400001)(26005)(478600001)(71200400001)(9686003)(66899024)(6506007)(7696005)(53546011)(966005)(41300700001)(6916009)(33656002)(86362001)(316002)(76116006)(54906003)(64756008)(66476007)(66946007)(66446008)(66556008)(4326008)(8936002)(8676002)(55016003)(52536014)(82960400001)(122000001)(5660300002)(38100700002)(38070700009)(2906002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bUtFSm8vdjJmeXhZNnZsdFRxdkI4cTVlOTZiSXpKb2c1WVB1VzlxRzNVcm9O?=
 =?utf-8?B?REJCWHhLcnVhZ2pLYnFZS20xUGpGTTN4ZTZ0Wk5BbG83OGxMTm9ydGlBeVZC?=
 =?utf-8?B?Q3lMZm5LU0FFbEpESEVJbXp5cGZiWDNXNHBoOU1VZlpsaHY2U3hGa2p5OUZZ?=
 =?utf-8?B?ZDdtMmxCc1FMN0dFQjhBcUJwOHNpMTZNcHgzWWpselQvbW1Wc1lYNkdDRm5L?=
 =?utf-8?B?dHJyMmQzVVVUWGhSZ09mSGsrcit2YWxSRi9wTTdzSDg2RjNaelUwL0hCZCs5?=
 =?utf-8?B?Zkhpb1lhcVBlLzRadkE2MFdpdnVEYXM4R1lWcUZHZGlrZzJNc21PancvS25E?=
 =?utf-8?B?R2FPZi9RTElVMy9taUwySmJ0ZFNmayt4Yk5ENTlmVmJCVmkzeG5aams1VFVZ?=
 =?utf-8?B?NkFPZzdQamVqTG1yU1BFU1pJdkUzSjI1alBKcVNkMTdOTUdzdm9wTEpQcnZz?=
 =?utf-8?B?bEtxa2NtOGZiQkNCNHRYdGNxcklPNmw1SHRrZGg2emdOYlVkNWhyWVVIQjJK?=
 =?utf-8?B?akZ4Q2pOMWhrYXE1VDQ5Y3NhcHlUNGh5WFlRb0hyK1B1UHhURU16dkFEeXRz?=
 =?utf-8?B?SXBhYWd2M0o0M2hoTGZyeTJOYXdNWVA5Q0hYQk1rcStBMmlMaUl4SytoQUQx?=
 =?utf-8?B?MlhOUXE2RjdmVGg2VG9sTm1CT2o1eFhUWjNGMjdyT29lb042NW8vNzMwM0R6?=
 =?utf-8?B?bFpqTjJ3ZDFsVllGSTd5WnZQTzJIWDR6Rkpqam4wcnVKeS9YUUdkVU1FWXFP?=
 =?utf-8?B?RjR4a1lLYVBtYmNKaTJxS2tWSUdRTHU4MVloR1NXazE4UmFYUWFRYlZmNWhW?=
 =?utf-8?B?cGJHQVRhWnFqRlY0Um80RFlNTnNhNXd1Rld6MkROUnAxcjdvUXkxczdXWFBk?=
 =?utf-8?B?R1FIbmswcXBGb0pCbTRVTlJNeHUxT003dmxxeGM2dVNTa0JKTlY0bTI3WWdQ?=
 =?utf-8?B?TzA1QUR0M1ljaWdqblEzQ3BBTS8vTHo0R3p6MFR5R1dGTjNjY3VYWGhzQnRZ?=
 =?utf-8?B?MzlMb01PVTVJdmFHQ1BwaWJjSXdWQWJZTEU5NXdLNTlDSFlYZFdsVkpHQXBl?=
 =?utf-8?B?YjE0NFczNWg2ejUzL0xxbGYvUE9LT1RJY3VDN0llRUN3Z0FVNGpkU2poVnZz?=
 =?utf-8?B?SytKZTh4TENMR0p6M0JIY1VQTGlsMXkveFUvOTNDY21vMlEvRmlNQ1FvNk5k?=
 =?utf-8?B?Zk00YVVsREpFVmNScG5BcW1CeGRoWE5jMHBmRk0rdlhUTlNhYVBLa0N3Smgv?=
 =?utf-8?B?L3BKK2tBRE5nSlZGWHRUN3RDZFRTMDI0eGtiYXF1akNXN2p1bHJmV2t0bldH?=
 =?utf-8?B?RlY4U0xhUVNSSmhSeHh5RnlFUFhiYmdIWkx6T2I0R0dtdGc1UHJZVnpPVUZm?=
 =?utf-8?B?cmlKaHNKRUxOdEhsd0daNkxYZEZkb0pjSnZBdWZ6QjU5T0RBak1CV01qdUY2?=
 =?utf-8?B?Z3NRSzhha3VBUlpwZVp5RjBFdzZEZzQ3VXZHQ3MxTS9acHFsck9ZQzcveHVl?=
 =?utf-8?B?bDNySmxxbXhJVnFESWF2UGZxelgrSElxQW1QaUloVzJnV1JFdzFjVW9Hd2Yz?=
 =?utf-8?B?WGtxMERHK1hLM2VoaXNEa29TNGlSR1VpYUtiS2k3RTducEo0YXg2Tk96clVG?=
 =?utf-8?B?eWZ4TUxidFBRRHNRV2p6T0QzWTlmVWJDZmsyMVpObSsxS2Z6M25wMGVmU2px?=
 =?utf-8?B?d2V4cU0zZEhCT3lUWWFLckNpK0xKZ2RKSEpFYzg2NTFBZEtPNGdzSituWnYw?=
 =?utf-8?B?c3ZUTTNRdzBvZHh2Nk9MMDh1UGdrR2kvekhselBobzlrL2NMci9yY2drL0VV?=
 =?utf-8?B?cm5lOTRtS2dCRDBRZ0lOUmlWVE96M0R6bk4xSkV5a2E4ZjZjYURCM0NmZXIr?=
 =?utf-8?B?LzJqTXFzT0hhVGZLNUcwWVkwL2VSY3lHQlBjQk5TYUc4MlJ4MVAvbkVPclVy?=
 =?utf-8?B?QlZEWHBTUDRWR2ZFNmxkelI2SXp3OUVXOCsyMTY1VkRlQytoMmwyZzNrVG91?=
 =?utf-8?B?R2tVNnpsYkdEVlRabFEwVXFLdmQyNW80am5JeFFLSW5ST0FmQUduZUZ1d1Vh?=
 =?utf-8?B?WWFHa0U1eEtWUkpienVFNTBjK1gySi9VbFlWTXlYNENkNGU1aldSbTVrK0dS?=
 =?utf-8?Q?JBoZe43Iogaxs4YjEsJ4lETkR?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA0PR11MB7185.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e57bd322-9ecc-4c19-06d4-08dc1e41cce1
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jan 2024 07:38:33.8307 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: emt6biv3os7IbziUY+wUmZ8Wv1/so4OVR759/fcAQRo28FhHUtVy+gA2THUih0EQG6XhbBqg46qMdZ2rhpNwpcavQZPqtHoUnBN3UOEdHF4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6368
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
IHdyb3RlOg0KPiA+DQo+ID4gSW4gdGhlIHNwZWNpZmljIGNhc2Ugd2hlcmUgdGhlIGRpc3BsYXkg
bGF5ZXIgKHZpcnRpby1ncHUpIGlzIHVzaW5nDQo+ID4gZG1hYnVmLCBhbmQgaWYgcmVtb3RlIGNs
aWVudHMgYXJlIGVuYWJsZWQgKC1zcGljZSBnbD1vbixwb3J0PXh4eHgpLA0KPiA+IGl0IG1ha2Vz
IHNlbnNlIHRvIGxpbWl0IHRoZSBtYXhpbXVtIChzdHJlYW1pbmcpIHJhdGUgdG8gNjAgRlBTDQo+
ID4gdXNpbmcgdGhlIEdVSSB0aW1lci4gVGhpcyBtYXRjaGVzIHRoZSBiZWhhdmlvciBvZiBHVEsg
VUkgd2hlcmUgdGhlDQo+ID4gZGlzcGxheSB1cGRhdGVzIGFyZSBzdWJtaXR0ZWQgYXQgNjAgRlBT
IChhc3N1bWluZyB0aGUgdW5kZXJseWluZw0KPiA+IG1vZGUgaXMgV3hZQDYwKS4NCj4gDQo+IE9u
ZSBvZiB0aGUgaXNzdWVzIHdpdGggdGhpcyBhcHByb2FjaCBpcyB0aGF0IHRoZSBETUFCVUYgaXNu
J3Qgb3duZWQgYnkNCj4gdGhlIGNvbnN1bWVyLiBCeSBkZWxheWluZyB0aGUgdXNhZ2Ugb2YgaXQs
IHdlIHJpc2sgaGF2aW5nDQo+IGRhbWFnZWQvaW52YWxpZCB1cGRhdGVzLg0KVGhpcyBwYXRjaCBp
cyBvbmx5IHJlbGV2YW50IHdpdGggYmxvYj10cnVlIG9wdGlvbi4gQW5kLCBpbiB0aGlzIGNhc2Us
IHRoZQ0KR3Vlc3QgKHZpcnRpby1ncHUga2VybmVsIGRyaXZlcikgaXMgYmxvY2tlZCAob24gYSBm
ZW5jZSkgdW50aWwgdGhlIEhvc3QNCmhhcyBjb25zdW1lZCB0aGUgYnVmZmVyLCB3aGljaCBpbiB0
aGlzIGNhc2UgaGFwcGVucyBhZnRlciB0aGUgZW5jb2Rlcg0Kc2lnbmFscyB0aGUgYXN5bmMgdG8g
aW5kaWNhdGUgdGhhdCBlbmNvZGluZyBpcyBjb21wbGV0ZWQuIFRoZXJlZm9yZSwNCkFGQUlVLCB0
aGVyZSBpcyBubyByaXNrIG9mIG1pc3Npbmcgb3IgaW52YWxpZCB1cGRhdGVzLiBJZGVhbGx5LCB0
aGUgcmF0ZQ0Kc2hvdWxkIGJlIGRyaXZlbiBieSB0aGUgY29uc3VtZXIgd2hpY2ggaW4gdGhpcyBj
YXNlIGlzIHRoZSBTcGljZSBjbGllbnQsDQphbmQgZ2l2ZW4gdGhhdCBpdCBkb2Vzbid0IG1ha2Ug
c2Vuc2UgdG8gc3VibWl0IG5ldyBmcmFtZXMgZmFzdGVyIHRoYW4NCnRoZSByZWZyZXNoIHJhdGUs
IEkgZmlndXJlZCBpdCBpcyBvayB0byBsaW1pdCB0aGUgcHJvZHVjZXIgdG8gNjAgRlBTIGFzIHdl
bGwuDQpOb3RlIHRoYXQgU3BpY2UgYWxzbyBkb2VzIHJhdGUgbGltaXRpbmcgYmFzZWQgb24gbmV0
d29yayBsYXRlbmNpZXMgYW5kDQpkcm9wcGVkIGZyYW1lcy4NCg0KDQo+IA0KPiBJdCB3b3VsZCBi
ZSBncmVhdCBpZiB3ZSBjb3VsZCBoYXZlIGEgbWVjaGFuaXNtIGZvciBkb3VibGUvdHJpcGxlDQo+
IGJ1ZmZlcmluZyB3aXRoIHZpcnRpby1ncHUsIGFzIGZhciBhcyBJIGtub3cgdGhpcyBpcyBub3Qg
cG9zc2libGUgeWV0Lg0KR2l2ZW4gdGhhdCB2aXJ0aW8tZ3B1IGlzIGEgZHJtL2ttcyBkcml2ZXIs
IHRoZXJlIGNhbiBvbmx5IGJlIG9uZSBidWZmZXINCmluIGZsaWdodCBhdCBhbnkgZ2l2ZW4gdGlt
ZS4gQW5kLCBpdCBkb2Vzbid0IG1ha2Ugc2Vuc2UgdG8gc3VibWl0IGZyYW1lcw0KZmFzdGVyIHRo
YW4gdGhlIHJlZnJlc2ggcmF0ZSBhcyB0aGV5IHdvdWxkIHNpbXBseSBnZXQgZHJvcHBlZC4gSG93
ZXZlciwNCkkgdHJpZWQgdG8gYWRkcmVzcyB0aGlzIGlzc3VlIGZldyB5ZWFycyBhZ28gYnV0IGl0
IGRpZCBub3QgZ28gYW55d2hlcmU6DQpodHRwczovL2xvcmUua2VybmVsLm9yZy9hbGwvMjAyMTEw
MTQxMjQ0MDIuNDZmOTVlYmNAZWxkZmVsbC9ULw0KDQo+IA0KPiBJIHdvbmRlciBpZiBzZXR0aW5n
IGRweV9zZXRfdWlfaW5mbygpIHdpdGggdGhlIGZpeGVkIHJlZnJlc2hfcmF0ZSBpcw0KPiBlbm91
Z2ggZm9yIHRoZSBndWVzdCB0byBoYXZlIGEgZml4ZWQgRlBTLg0KSSBhbSBub3Qgc3VyZS4gTGV0
IG1lIHRyeSB0byBleHBlcmltZW50IHdpdGggaXQgYW5kIHNlZSBob3cgdGhpbmdzIHdvcmsuDQoN
ClRoYW5rcywNClZpdmVrDQo+IEl0IHdpbGwgb25seSB3b3JrIHdpdGggZ2Z4IGh3IHRoYXQgc3Vw
cG9ydCB1aV9pbmZvKCkgdGhvdWdoLg0KPiANCj4gDQo+IA0KPiA+DQo+ID4gQ2M6IEdlcmQgSG9m
Zm1hbm4gPGtyYXhlbEByZWRoYXQuY29tPg0KPiA+IENjOiBNYXJjLUFuZHLDqSBMdXJlYXUgPG1h
cmNhbmRyZS5sdXJlYXVAcmVkaGF0LmNvbT4NCj4gPiBDYzogRnJlZGlhbm8gWmlnbGlvIDxmcmVk
ZHk3N0BnbWFpbC5jb20+DQo+ID4gQ2M6IERvbmd3b24gS2ltIDxkb25nd29uLmtpbUBpbnRlbC5j
b20+DQo+ID4gU2lnbmVkLW9mZi1ieTogVml2ZWsgS2FzaXJlZGR5IDx2aXZlay5rYXNpcmVkZHlA
aW50ZWwuY29tPg0KPiA+IC0tLQ0KPiA+ICB1aS9zcGljZS1kaXNwbGF5LmMgfCAzOCArKysrKysr
KysrKysrKysrKysrKysrKysrKysrLS0tLS0tLS0tLQ0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgMjgg
aW5zZXJ0aW9ucygrKSwgMTAgZGVsZXRpb25zKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvdWkv
c3BpY2UtZGlzcGxheS5jIGIvdWkvc3BpY2UtZGlzcGxheS5jDQo+ID4gaW5kZXggMzg0Yjg1MDhk
NC4uOTBjMDQ2MjNlYyAxMDA2NDQNCj4gPiAtLS0gYS91aS9zcGljZS1kaXNwbGF5LmMNCj4gPiAr
KysgYi91aS9zcGljZS1kaXNwbGF5LmMNCj4gPiBAQCAtODQxLDEyICs4NDEsMzEgQEAgc3RhdGlj
IHZvaWQgcWVtdV9zcGljZV9nbF9ibG9ja190aW1lcih2b2lkDQo+ICpvcGFxdWUpDQo+ID4gICAg
ICB3YXJuX3JlcG9ydCgic3BpY2U6IG5vIGdsLWRyYXctZG9uZSB3aXRoaW4gb25lIHNlY29uZCIp
Ow0KPiA+ICB9DQo+ID4NCj4gPiArc3RhdGljIHZvaWQgc3BpY2VfZ2xfZHJhdyhTaW1wbGVTcGlj
ZURpc3BsYXkgKnNzZCwNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgdWludDMyX3Qg
eCwgdWludDMyX3QgeSwgdWludDMyX3QgdywgdWludDMyX3QgaCkNCj4gPiArew0KPiA+ICsgICAg
dWludDY0X3QgY29va2llOw0KPiA+ICsNCj4gPiArICAgIGNvb2tpZSA9DQo+ICh1aW50cHRyX3Qp
cXhsX2Nvb2tpZV9uZXcoUVhMX0NPT0tJRV9UWVBFX0dMX0RSQVdfRE9ORSwgMCk7DQo+ID4gKyAg
ICBzcGljZV9xeGxfZ2xfZHJhd19hc3luYygmc3NkLT5xeGwsIHgsIHksIHcsIGgsIGNvb2tpZSk7
DQo+ID4gK30NCj4gPiArDQo+ID4gIHN0YXRpYyB2b2lkIHNwaWNlX2dsX3JlZnJlc2goRGlzcGxh
eUNoYW5nZUxpc3RlbmVyICpkY2wpDQo+ID4gIHsNCj4gPiAgICAgIFNpbXBsZVNwaWNlRGlzcGxh
eSAqc3NkID0gY29udGFpbmVyX29mKGRjbCwgU2ltcGxlU3BpY2VEaXNwbGF5LCBkY2wpOw0KPiA+
IC0gICAgdWludDY0X3QgY29va2llOw0KPiA+ICsgICAgUWVtdURtYUJ1ZiAqZG1hYnVmID0gc3Nk
LT5ndWVzdF9kbWFidWY7DQo+ID4NCj4gPiAtICAgIGlmICghc3NkLT5kcyB8fCBxZW11X2NvbnNv
bGVfaXNfZ2xfYmxvY2tlZChzc2QtPmRjbC5jb24pKSB7DQo+ID4gKyAgICBpZiAoIXNzZC0+ZHMp
IHsNCj4gPiArICAgICAgICByZXR1cm47DQo+ID4gKyAgICB9DQo+ID4gKw0KPiA+ICsgICAgaWYg
KHFlbXVfY29uc29sZV9pc19nbF9ibG9ja2VkKHNzZC0+ZGNsLmNvbikpIHsNCj4gPiArICAgICAg
ICBpZiAocmVtb3RlX2NsaWVudCAmJiBzc2QtPmdsX3VwZGF0ZXMgJiYgZG1hYnVmKSB7DQo+ID4g
KyAgICAgICAgICAgIHNwaWNlX2dsX2RyYXcoc3NkLCAwLCAwLCBkbWFidWYtPndpZHRoLCBkbWFi
dWYtPmhlaWdodCk7DQo+ID4gKyAgICAgICAgICAgIHNzZC0+Z2xfdXBkYXRlcyA9IDA7DQo+ID4g
KyAgICAgICAgICAgIC8qIFRvIHN0cmVhbSBhdCA2MCBGUFMsIHRoZSAoR1VJKSB0aW1lciBkZWxh
eSBuZWVkcyB0byBiZSB+MTcgbXMgKi8NCj4gPiArICAgICAgICAgICAgZGNsLT51cGRhdGVfaW50
ZXJ2YWwgPSAxMDAwIC8gKDIgKg0KPiBHVUlfUkVGUkVTSF9JTlRFUlZBTF9ERUZBVUxUKSArIDE7
DQo+ID4gKyAgICAgICAgfQ0KPiA+ICAgICAgICAgIHJldHVybjsNCj4gPiAgICAgIH0NCj4gPg0K
PiA+IEBAIC04NTQsMTEgKzg3Myw4IEBAIHN0YXRpYyB2b2lkIHNwaWNlX2dsX3JlZnJlc2goRGlz
cGxheUNoYW5nZUxpc3RlbmVyDQo+ICpkY2wpDQo+ID4gICAgICBpZiAoc3NkLT5nbF91cGRhdGVz
ICYmIHNzZC0+aGF2ZV9zdXJmYWNlKSB7DQo+ID4gICAgICAgICAgcWVtdV9zcGljZV9nbF9ibG9j
ayhzc2QsIHRydWUpOw0KPiA+ICAgICAgICAgIGdsRmx1c2goKTsNCj4gPiAtICAgICAgICBjb29r
aWUgPQ0KPiAodWludHB0cl90KXF4bF9jb29raWVfbmV3KFFYTF9DT09LSUVfVFlQRV9HTF9EUkFX
X0RPTkUsIDApOw0KPiA+IC0gICAgICAgIHNwaWNlX3F4bF9nbF9kcmF3X2FzeW5jKCZzc2QtPnF4
bCwgMCwgMCwNCj4gPiAtICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBzdXJmYWNlX3dp
ZHRoKHNzZC0+ZHMpLA0KPiA+IC0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHN1cmZh
Y2VfaGVpZ2h0KHNzZC0+ZHMpLA0KPiA+IC0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IGNvb2tpZSk7DQo+ID4gKyAgICAgICAgc3BpY2VfZ2xfZHJhdyhzc2QsIDAsIDAsDQo+ID4gKyAg
ICAgICAgICAgICAgICAgICAgICBzdXJmYWNlX3dpZHRoKHNzZC0+ZHMpLCBzdXJmYWNlX2hlaWdo
dChzc2QtPmRzKSk7DQo+ID4gICAgICAgICAgc3NkLT5nbF91cGRhdGVzID0gMDsNCj4gPiAgICAg
IH0NCj4gPiAgfQ0KPiA+IEBAIC0xMDI1LDcgKzEwNDEsNiBAQCBzdGF0aWMgdm9pZA0KPiBxZW11
X3NwaWNlX2dsX3VwZGF0ZShEaXNwbGF5Q2hhbmdlTGlzdGVuZXIgKmRjbCwNCj4gPiAgICAgIEVH
TGludCBzdHJpZGUgPSAwLCBmb3VyY2MgPSAwOw0KPiA+ICAgICAgYm9vbCByZW5kZXJfY3Vyc29y
ID0gZmFsc2U7DQo+ID4gICAgICBib29sIHlfMF90b3AgPSBmYWxzZTsgLyogRklYTUUgKi8NCj4g
PiAtICAgIHVpbnQ2NF90IGNvb2tpZTsNCj4gPiAgICAgIGludCBmZDsNCj4gPg0KPiA+ICAgICAg
aWYgKCFzc2QtPmhhdmVfc2Nhbm91dCkgew0KPiA+IEBAIC0xMDk4LDggKzExMTMsMTEgQEAgc3Rh
dGljIHZvaWQNCj4gcWVtdV9zcGljZV9nbF91cGRhdGUoRGlzcGxheUNoYW5nZUxpc3RlbmVyICpk
Y2wsDQo+ID4gICAgICB0cmFjZV9xZW11X3NwaWNlX2dsX3VwZGF0ZShzc2QtPnF4bC5pZCwgdywg
aCwgeCwgeSk7DQo+ID4gICAgICBxZW11X3NwaWNlX2dsX2Jsb2NrKHNzZCwgdHJ1ZSk7DQo+ID4g
ICAgICBnbEZsdXNoKCk7DQo+ID4gLSAgICBjb29raWUgPQ0KPiAodWludHB0cl90KXF4bF9jb29r
aWVfbmV3KFFYTF9DT09LSUVfVFlQRV9HTF9EUkFXX0RPTkUsIDApOw0KPiA+IC0gICAgc3BpY2Vf
cXhsX2dsX2RyYXdfYXN5bmMoJnNzZC0+cXhsLCB4LCB5LCB3LCBoLCBjb29raWUpOw0KPiA+ICsg
ICAgaWYgKHJlbW90ZV9jbGllbnQpIHsNCj4gPiArICAgICAgICBzc2QtPmdsX3VwZGF0ZXMrKzsN
Cj4gPiArICAgIH0gZWxzZSB7DQo+ID4gKyAgICAgICAgc3BpY2VfZ2xfZHJhdyhzc2QsIHgsIHks
IHcsIGgpOw0KPiA+ICsgICAgfQ0KPiA+ICB9DQo+ID4NCj4gPiAgc3RhdGljIGNvbnN0IERpc3Bs
YXlDaGFuZ2VMaXN0ZW5lck9wcyBkaXNwbGF5X2xpc3RlbmVyX2dsX29wcyA9IHsNCj4gPiAtLQ0K
PiA+IDIuMzkuMg0KPiA+DQo+ID4NCj4gDQo+IA0KPiAtLQ0KPiBNYXJjLUFuZHLDqSBMdXJlYXUN
Cg==

