Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2385C54E49
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Mar 2024 03:18:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhhn2-0001Yw-LD; Tue, 05 Mar 2024 22:17:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1rhhn1-0001Yl-CC; Tue, 05 Mar 2024 22:17:55 -0500
Received: from mgamail.intel.com ([198.175.65.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1rhhmy-00021i-6E; Tue, 05 Mar 2024 22:17:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1709695073; x=1741231073;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=tf1uxcQqV1GNe0Uks2Xe4+IBEQjs/PrkXU2dKR5lmUU=;
 b=ZgqK3V2E+rcwhIck4v7FhZqcV5NkeGoXjZxu1k603a63O8OQflZ0aqaP
 jFrOdkvZVHgfNhBbinnw0SethvmzVlCYrMBba1P5cyKej82OkOKvcXxrJ
 yWtvNSe0k/9+FxWn7RUlAQtgXPgdMWDLa+iM3xj5v29UgUKOQnhD9Vq4n
 YQAQuddNeyKkX2TR1bIlH/D6ZQFcJHFjAJawyJxaPFoGkuUaYQfG5TN4s
 oLbcJdlfy+zCFTuTKwzhchzWuJcD/6Ty+meTnp4QDptncD5Shz3L7siUp
 VvaiyDZHhaQoaFGf0tOiPgy1kPnlx6g6K7HciHyAS3bef5lkpraCgZmqp Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11004"; a="26754511"
X-IronPort-AV: E=Sophos;i="6.06,207,1705392000"; d="scan'208";a="26754511"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Mar 2024 19:15:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,207,1705392000"; 
   d="scan'208";a="9774459"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
 by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 05 Mar 2024 19:15:35 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 5 Mar 2024 19:15:34 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 5 Mar 2024 19:15:34 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 5 Mar 2024 19:15:31 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ft4WFsnelfzYeq1OWSC/Vw7fSPPlpa3WWXlKqGjSR+gGuKCgTXrnzkOgtozAQqSbmjoQ4b3zuDfWKw/b5b8IEeINc6LFaFXbWCxZjSUfJUn2nwW5hjweGamSBZv//BujkLY8ng7+q7UYIOSJHRziErq+qim+OsTAgiVFsexbbdbGVX8rrL21F0fhbN/wry5fOnl02KxdE+K3/MIJvBTzp0Wyeq5/q/mc7/F8+MRtGM0nSE4l+ThBJoDmDA705OgCYgDPIhfWAXP5KgZs0fsHseDGmZERnIOWsbS0xNYQ1LS6LRymYJN2xVCcYwGhVvEzJQVzFyEMkdc2IeHaBUO8JQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tf1uxcQqV1GNe0Uks2Xe4+IBEQjs/PrkXU2dKR5lmUU=;
 b=PEdt8GYEpS+tv64CsZ0J2w9ZhJ7eRcI2+3qe0wJ/UvUdg8Sw/DOnsCDkX7wnvvVvT3Sd5e+VDXTHC0EXRBemVyyxRft10EtbkOwp8MkL4SeNhAM7iBL7l0ie4UbB1Wj+uOuDxHxpLF9eMS4fIbFjMUdJbkoyIJoy835DdDJcl/GiB9EBoCv9o1XykBCwUcU4XDAZbqY0Y32d6+P7M9Gpd33QJqy9NdVe9RpXVitG1KPjdy16g0GDDArOYM+dH8EDQEHMm8a4T10H4BAp1tbxTMNOi6GlOS1+G/mnDnCH950LzUFk1FcHtKtolJ4cOB0RM4Ei4c9G1xhy++vEH/3HHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by DM6PR11MB4594.namprd11.prod.outlook.com (2603:10b6:5:2a0::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.23; Wed, 6 Mar
 2024 03:15:24 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::c0f3:15d4:d7f6:a72a]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::c0f3:15d4:d7f6:a72a%4]) with mapi id 15.20.7362.019; Wed, 6 Mar 2024
 03:15:24 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: Eric Auger <eric.auger@redhat.com>, "eric.auger.pro@gmail.com"
 <eric.auger.pro@gmail.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "mst@redhat.com"
 <mst@redhat.com>, "jean-philippe@linaro.org" <jean-philippe@linaro.org>,
 "imammedo@redhat.com" <imammedo@redhat.com>, "peter.maydell@linaro.org"
 <peter.maydell@linaro.org>, "clg@redhat.com" <clg@redhat.com>,
 "yanghliu@redhat.com" <yanghliu@redhat.com>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>, "pbonzini@redhat.com"
 <pbonzini@redhat.com>, "berrange@redhat.com" <berrange@redhat.com>
Subject: RE: [PATCH v6 7/9] hw/i386/q35: Set virtio-iommu aw-bits default
 value to 39
Thread-Topic: [PATCH v6 7/9] hw/i386/q35: Set virtio-iommu aw-bits default
 value to 39
Thread-Index: AQHabygiPjB7W52At0Gpg6uwXKk7/rEqCU1w
Date: Wed, 6 Mar 2024 03:15:24 +0000
Message-ID: <SJ0PR11MB67443EC0B600D02A773AD20792212@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20240305180734.48515-1-eric.auger@redhat.com>
 <20240305180734.48515-8-eric.auger@redhat.com>
In-Reply-To: <20240305180734.48515-8-eric.auger@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|DM6PR11MB4594:EE_
x-ms-office365-filtering-correlation-id: 29a00bc0-f1c6-4ea4-27db-08dc3d8baa33
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: afBKxBmBlOIQaI2AILDyVjKIzIjUNP6LkeqTFQXdGZyEaBoD/BIOTBs+RjycwyPvrLxCsPtg+dZQSsU21nit5LwVZxuv3ySIxnl3vK46vlwGDSg9Tk4yQGzEsTOLcOVhyn2R5qO6UeT+5Ft2ye9ZZo2edJOe/hpZcVzmGZAbRtUh2rkNZR5EvRCyziNnXcnzx9xqiFv5To1T7xyvOpeceuVzkLxIgyE5DHK6kw4ohOgGmDW23y+nE0MF88kcQARPaOzFvARwHt5vYL4u7pvQ7GaalIm6kLGr5JyJbKL5E6wqnY194AG+9VsQi+48jx+V1ylFpZxgf5B2NuYNLoyR01k1dsCX9kW1ZdG71dfnBzws1XBAfO7RWSIApLHGw6o9iiR8Pac7yNotbxgqjtEj9z1z0dKAOw/9wikopWpdjh20cBt4J9xgYXeS/Pb2OYoBCvwbMSLRxhNgHtgo4ODqC2gOppaHIhXJjcG2uxKTPYN+B66CkZaIIdlfMqwJK7ksRHTc2Ws3h4sSoQ1y17CXWO9VMQwamm61ZRfG30o1tgGOZJXANQcO9jdL+S147TrXYJP6InGzUFU2mKgSXGvJh6ShojSSaaNnno5T3YmdaroTW9UoQrAWtlHX0npBzT4rInTnFnqG8PXAj5ltDMggorevQBdpDlUDZDXehi/w4MBIQrKmcCoKfuI7MVW4D5UhTTN1ERhr1zE7ytd2cBgFgunYis06vaFJ7ErJJEgK8oQ=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(921011)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NmJPeUR5QTFWQ2d4TnVPOVFpMnM3azMwK0E1d0hORjV0cG1pWVFJVVRQMWVM?=
 =?utf-8?B?cGVkRXk4SFI4NTQxQXpOZE4zYU5kREwrclpJWVdITHNvZHltQk1Db0tGVmh4?=
 =?utf-8?B?ci9uNWQ1VVNSQlZJY2hVRks1M0hDRnZENGhodHdqZy84TUNjbmhyY2tIVW4x?=
 =?utf-8?B?bHRKQXJwYVNtQnJjSkhWMjExUHlyM2FYTzI0amFuRElGbVVTUlU0VEVUeWRO?=
 =?utf-8?B?UlRSS012TXI5djl1VVduSWdPU3JCajQrWnBNM2NsdUttaUZOMlBjNm1oTjdK?=
 =?utf-8?B?alBpbC9CZlpnSVI2MG9uNm5INW02ZENGUGpITTVOQWdNRGk3Rk1ySDhIdDlx?=
 =?utf-8?B?eitqT21OMm9XQm9hK0pDcnRieS8zRDdyeTdGWGkweVE3MUVMQTh6dkFCb0tT?=
 =?utf-8?B?dldKL1RvQ3pST3lPTjJqakZqRkZ1SWROdllheVpxZWhuYmdHQmh3aUZTTU5W?=
 =?utf-8?B?aHUxdUhZNWZlcUpkREFjeHU1ckExS3BtcEtVL3IrWFNLZ0trbG8yZmdtMzBH?=
 =?utf-8?B?dk5WSms0K2tQd2pzUU92MnFNeDUrejVhL0RGVWNSeVhNUFpjMHRzN0k1WEw3?=
 =?utf-8?B?WmtCREJjN0x3c0gwa0lQenlTZHpreVFHWlM3Q2FEYWpndVRNYUJ0Q2o3SFFF?=
 =?utf-8?B?bDQ5ejZ6NFVOZ3NETW8vOHo2eXhMTDN3dVBBaGRXeC9IeVhoaEx4OEVGdTIx?=
 =?utf-8?B?cWdkMTBMWUdXYU9qNFc2MnBMU2ZjQmVrZXN2dFdDRUVKdUdHQktvYXdlNWl3?=
 =?utf-8?B?ZWVQcGQ3Uy8rN0xRZk1PQ094UHdnN1ZJTjI5WlNZZkYveFdoMXhyZW8yTWMx?=
 =?utf-8?B?QjJpUGY1WHVyYVo1cnFvUnBSVUR1NHlrMmlBeUY5MXNKVVlyd1UwbXdyVUNi?=
 =?utf-8?B?SkZsb0l0MWp0Tnh6TWpGVUlvVjlpL3hIc001R0hwS2xaWEpzUCtra0xqZDlD?=
 =?utf-8?B?c3VGdS95OE5oK2szKzdaeDliQjRRaGxTL2tVRFcwYjFZUUpZRDlzZWhzRUll?=
 =?utf-8?B?TTlnWUdrVE5vZGpLSTJsc21xUkh5OG9xTW9Ia3p1MnlnQ2tsZzhvNFl6djB4?=
 =?utf-8?B?NEoxbWMzcnlYRS9nWHBzUzNpbmd4TjJvQzRWUm5UUnVYMU9kRXg3U21LMnRx?=
 =?utf-8?B?em00b2hENnE1N2szcGluekNqMkw2THN1bGd4ZjdVSDhrVys1RURubEZwaFF1?=
 =?utf-8?B?UnZuTWxKVVVGSEM5SC9IamtuT1YvdklseHhhekM1blVHdmZZbUQ1UHhITWRL?=
 =?utf-8?B?VFU2NDdxbTZSblpVSU5ONytzNHdsNUFaQkdrRWt2dFZHclZTMkNETkZBMDVJ?=
 =?utf-8?B?ZzVTV2xtR0FFOWJ4L0JHY3dsUFRLbG5vM1RZekdnU3RWWmVDSHoybllPdGxn?=
 =?utf-8?B?WWk5MzVCN08wT3JXd09yN252NnRRK1ByMFhZcU1xcDJXc3o1L0tmWjl0Vkky?=
 =?utf-8?B?SWNkV3VpUmw1cklNQ3A4LzJIa1c2MVpsa25ZYnYvQW9hOFg0WUtrVmtCRE15?=
 =?utf-8?B?NmZ5TTF2MElzb0RkT1pub2lGSlVJV0o2U2FzRmNQQ0M3Y0t3SW1seVIvQ1Jy?=
 =?utf-8?B?bjRRZlZBeTJEdTY3cWlsaGhCQ1ZIaDJxYTFzVHI0Z2E3c3FFY2p5Qnd1Qk5j?=
 =?utf-8?B?RmZpVG1lQTltZ2NjMlV5VWRzMkV2bTZWeTcvTExCbWp3Q29WeVlnbVZpcW15?=
 =?utf-8?B?dnNlRWJ0RUtaeG1KcDJ3MDErcVA1OWpxN1FOQzBhU0N5NFhMZlk3STVTTW92?=
 =?utf-8?B?MFp1TnhhSVZoSkw5d2g3NFgxTHhFR1BYV0VIeC9XYzJYV3dJdHNoV1Z0NXk3?=
 =?utf-8?B?YWIrY0J3NHVxWUxhQ1dTNWwxck9ac3ZnSDlyKzE4UVpLSTRJZWN1dEN1MEFK?=
 =?utf-8?B?MWJiZHdWUDhhYkZndlZHNkRiMVBST1FCUStnNkdibTNFUGxUSzlwSzBaUFJx?=
 =?utf-8?B?UFM0MkZpTFQra3VQZGNyYUdrNjZXdDFEYUtpSWxKbURvdDZzZFFHVzBXR0s0?=
 =?utf-8?B?RVhuV2hsVWJ1bTZkUFVFZjdka1FMc2I4QkMzZmt2Rk5lV1JiVS85akpwV0VQ?=
 =?utf-8?B?QTNWZzFqbWJSdm93N2FOTW1lL1QrZTc3SE5uMUdkNlJGQWxIbGpSc3lPZFo5?=
 =?utf-8?Q?ZMvarT1dKAKfWXA8ZJTYa+YGH?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29a00bc0-f1c6-4ea4-27db-08dc3d8baa33
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Mar 2024 03:15:24.4608 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OcVAYgTj6gWONEXLEFfgbzqQBKfsu2JMKJ4MrPJDKeMRZ5dhP8XgzXGv5/XUNXaWrCXIzK4b5qgRI45Nz9rnrBwyZHgMSFgwFskPoGEzHrs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4594
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.9;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.568,
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

SGkgRXJpYywNCg0KPi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+RnJvbTogRXJpYyBBdWdl
ciA8ZXJpYy5hdWdlckByZWRoYXQuY29tPg0KPlN1YmplY3Q6IFtQQVRDSCB2NiA3LzldIGh3L2kz
ODYvcTM1OiBTZXQgdmlydGlvLWlvbW11IGF3LWJpdHMgZGVmYXVsdA0KPnZhbHVlIHRvIDM5DQo+
DQo+Q3VycmVudGx5IHRoZSBkZWZhdWx0IGlucHV0IHJhbmdlIGNhbiBleHRlbmQgdG8gNjQgYml0
cy4gT24geDg2LA0KPndoZW4gdGhlIHZpcnRpby1pb21tdSBwcm90ZWN0cyB2ZmlvIGRldmljZXMs
IHRoZSBwaHlzaWNhbCBpb21tdQ0KPm1heSBzdXBwb3J0IG9ubHkgMzkgYml0cy4gTGV0J3Mgc2V0
IHRoZSBkZWZhdWx0IHRvIDM5LCBhcyBkb25lDQo+Zm9yIHRoZSBpbnRlbC1pb21tdS4NCj4NCj5X
ZSB1c2UgaHdfY29tcGF0XzhfMiB0byBoYW5kbGUgdGhlIGNvbXBhdGliaWxpdHkgZm9yIG1hY2hp
bmVzDQo+YmVmb3JlIDkuMCB3aGljaCB1c2VkIHRvIGhhdmUgYSB2aXJ0aW8taW9tbXUgZGVmYXVs
dCBpbnB1dCByYW5nZQ0KPm9mIDY0IGJpdHMuDQo+DQo+T2YgY291cnNlIGlmIGF3LWJpdHMgaXMg
c2V0IGZyb20gdGhlIGNvbW1hbmQgbGluZSwgdGhlIGRlZmF1bHQNCj5pcyBvdmVycmlkZW4uDQo+
DQo+U2lnbmVkLW9mZi1ieTogRXJpYyBBdWdlciA8ZXJpYy5hdWdlckByZWRoYXQuY29tPg0KPg0K
Pi0tLQ0KPg0KPnY1IC0+IHY2Og0KPi0gc3BsaXQgcGMvYXJtIHNldHRpbmdzDQo+DQo+djMgLT4g
djQ6DQo+LSB1cGRhdGUgdGhlIHFvcyB0ZXN0IHRvIHJlbGF4IHRoZSBjaGVjayBvbiB0aGUgbWF4
IGlucHV0IElPVkENCj4NCj52MiAtPiB2MzoNCj4tIGNvbGxlY3RlZCBaaGVuemhvbmcncyBSLWIN
Cj4tIHVzZSAmZXJyb3JfYWJvcnQgaW5zdGVhZCBvZiBOVUxMIGVycm9yIGhhbmRsZQ0KPiAgb24g
b2JqZWN0X3Byb3BlcnR5X2dldF91aW50KCkgY2FsbCAoQ8OpZHJpYykNCj4tIHVzZSBWVERfSE9T
VF9BV18zOUJJVCAoQ8OpZHJpYykNCj4NCj52MSAtPiB2MjoNCj4tIHNldCBhdy1iaXRzIHRvIDQ4
YiBvbiBBUk0NCj4tIHVzZSBod19jb21wYXRfOF8yIHRvIGhhbmRsZSB0aGUgY29tcGF0IGZvciBv
bGRlciBtYWNoaW5lcw0KPiAgd2hpY2ggdXNlZCA2NGIgYXMgYSBkZWZhdWx0DQo+LS0tDQo+IGlu
Y2x1ZGUvaHcvaTM4Ni9wYy5oICAgICAgICAgICAgfCAzICsrKw0KPiBody9jb3JlL21hY2hpbmUu
YyAgICAgICAgICAgICAgIHwgMSArDQo+IGh3L2kzODYvcGMuYyAgICAgICAgICAgICAgICAgICAg
fCA2ICsrKysrKw0KPiBody9pMzg2L3BjX3EzNS5jICAgICAgICAgICAgICAgIHwgMiArKw0KPiB0
ZXN0cy9xdGVzdC92aXJ0aW8taW9tbXUtdGVzdC5jIHwgMiArLQ0KPiA1IGZpbGVzIGNoYW5nZWQs
IDEzIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4NCj5kaWZmIC0tZ2l0IGEvaW5jbHVk
ZS9ody9pMzg2L3BjLmggYi9pbmNsdWRlL2h3L2kzODYvcGMuaA0KPmluZGV4IDUwNjU1OTAyODEu
LmIzMjI5Zjk4ZGUgMTAwNjQ0DQo+LS0tIGEvaW5jbHVkZS9ody9pMzg2L3BjLmgNCj4rKysgYi9p
bmNsdWRlL2h3L2kzODYvcGMuaA0KPkBAIC0xOTgsNiArMTk4LDkgQEAgdm9pZCBwY19zeXN0ZW1f
cGFyc2Vfb3ZtZl9mbGFzaCh1aW50OF90DQo+KmZsYXNoX3B0ciwgc2l6ZV90IGZsYXNoX3NpemUp
Ow0KPiAvKiBzZ3guYyAqLw0KPiB2b2lkIHBjX21hY2hpbmVfaW5pdF9zZ3hfZXBjKFBDTWFjaGlu
ZVN0YXRlICpwY21zKTsNCj4NCj4rZXh0ZXJuIEdsb2JhbFByb3BlcnR5IHBjX2NvbXBhdF9kZWZh
dWx0c1tdOw0KPitleHRlcm4gY29uc3Qgc2l6ZV90IHBjX2NvbXBhdF9kZWZhdWx0c19sZW47DQoN
CklmIHdlIG9ubHkgd2FudCB0byBzdXBwb3J0IHEzNSBhbmQgbm90IGk0NDBmeCwgYmV0dGVyIHRv
IGFkZCBfcTM1IHN1ZmZpeCBhbmQgbW92ZSBpbnRvIHBjX3EzNS5jIGFuZCBtYWRlIHN0YXRpYz8N
Cg0KPisNCj4gZXh0ZXJuIEdsb2JhbFByb3BlcnR5IHBjX2NvbXBhdF84XzJbXTsNCj4gZXh0ZXJu
IGNvbnN0IHNpemVfdCBwY19jb21wYXRfOF8yX2xlbjsNCj4NCj5kaWZmIC0tZ2l0IGEvaHcvY29y
ZS9tYWNoaW5lLmMgYi9ody9jb3JlL21hY2hpbmUuYw0KPmluZGV4IDZiZDA5ZDQ1OTIuLjRiODkx
NzJkMWMgMTAwNjQ0DQo+LS0tIGEvaHcvY29yZS9tYWNoaW5lLmMNCj4rKysgYi9ody9jb3JlL21h
Y2hpbmUuYw0KPkBAIC0zNSw2ICszNSw3IEBADQo+DQo+IEdsb2JhbFByb3BlcnR5IGh3X2NvbXBh
dF84XzJbXSA9IHsNCj4gICAgIHsgVFlQRV9WSVJUSU9fSU9NTVVfUENJLCAiZ3JhbnVsZSIsICI0
ayIgfSwNCj4rICAgIHsgVFlQRV9WSVJUSU9fSU9NTVVfUENJLCAiYXctYml0cyIsICI2NCIgfSwN
Cj4gfTsNCj4gY29uc3Qgc2l6ZV90IGh3X2NvbXBhdF84XzJfbGVuID0gR19OX0VMRU1FTlRTKGh3
X2NvbXBhdF84XzIpOw0KPg0KPmRpZmYgLS1naXQgYS9ody9pMzg2L3BjLmMgYi9ody9pMzg2L3Bj
LmMNCj5pbmRleCBmNWZmOTcwYWNmLi45MDI0NDgzMzU2IDEwMDY0NA0KPi0tLSBhL2h3L2kzODYv
cGMuYw0KPisrKyBiL2h3L2kzODYvcGMuYw0KPkBAIC01OSw2ICs1OSw3IEBADQo+ICNpbmNsdWRl
ICJody9pMzg2L2t2bS94ZW5fZXZ0Y2huLmgiDQo+ICNpbmNsdWRlICJody9pMzg2L2t2bS94ZW5f
Z250dGFiLmgiDQo+ICNpbmNsdWRlICJody9pMzg2L2t2bS94ZW5feGVuc3RvcmUuaCINCj4rI2lu
Y2x1ZGUgImh3L2kzODYvaW50ZWxfaW9tbXUuaCINCg0KVGhpcyBjYW4gYmUgcmVtb3ZlZD8NCg0K
PiAjaW5jbHVkZSAiaHcvbWVtL21lbW9yeS1kZXZpY2UuaCINCj4gI2luY2x1ZGUgImU4MjBfbWVt
b3J5X2xheW91dC5oIg0KPiAjaW5jbHVkZSAidHJhY2UuaCINCj5AQCAtNzgsNiArNzksMTEgQEAN
Cj4gICAgIHsgInFlbXU2NC0iIFRZUEVfWDg2X0NQVSwgIm1vZGVsLWlkIiwgIlFFTVUgVmlydHVh
bCBDUFUgdmVyc2lvbiAiDQo+diwgfSxcDQo+ICAgICB7ICJhdGhsb24tIiBUWVBFX1g4Nl9DUFUs
ICJtb2RlbC1pZCIsICJRRU1VIFZpcnR1YWwgQ1BVIHZlcnNpb24gIiB2LCB9LA0KPg0KPitHbG9i
YWxQcm9wZXJ0eSBwY19jb21wYXRfZGVmYXVsdHNbXSA9ICB7DQo+KyAgICB7IFRZUEVfVklSVElP
X0lPTU1VX1BDSSwgImF3LWJpdHMiLCAiMzkiIH0sDQo+K307DQo+K2NvbnN0IHNpemVfdCBwY19j
b21wYXRfZGVmYXVsdHNfbGVuID0NCj5HX05fRUxFTUVOVFMocGNfY29tcGF0X2RlZmF1bHRzKTsN
Cj4rDQo+IEdsb2JhbFByb3BlcnR5IHBjX2NvbXBhdF84XzJbXSA9IHt9Ow0KPiBjb25zdCBzaXpl
X3QgcGNfY29tcGF0XzhfMl9sZW4gPSBHX05fRUxFTUVOVFMocGNfY29tcGF0XzhfMik7DQo+DQo+
ZGlmZiAtLWdpdCBhL2h3L2kzODYvcGNfcTM1LmMgYi9ody9pMzg2L3BjX3EzNS5jDQo+aW5kZXgg
NDVhNDEwMmU3NS4uMzI0MjFhMGE1ZiAxMDA2NDQNCj4tLS0gYS9ody9pMzg2L3BjX3EzNS5jDQo+
KysrIGIvaHcvaTM4Ni9wY19xMzUuYw0KPkBAIC0zNTYsNiArMzU2LDggQEAgc3RhdGljIHZvaWQg
cGNfcTM1X21hY2hpbmVfb3B0aW9ucyhNYWNoaW5lQ2xhc3MNCj4qbSkNCj4gICAgIG1hY2hpbmVf
Y2xhc3NfYWxsb3dfZHluYW1pY19zeXNidXNfZGV2KG0sDQo+VFlQRV9JTlRFTF9JT01NVV9ERVZJ
Q0UpOw0KPiAgICAgbWFjaGluZV9jbGFzc19hbGxvd19keW5hbWljX3N5c2J1c19kZXYobSwgVFlQ
RV9SQU1GQl9ERVZJQ0UpOw0KPiAgICAgbWFjaGluZV9jbGFzc19hbGxvd19keW5hbWljX3N5c2J1
c19kZXYobSwgVFlQRV9WTUJVU19CUklER0UpOw0KPisgICAgY29tcGF0X3Byb3BzX2FkZChtLT5j
b21wYXRfcHJvcHMsDQo+KyAgICAgICAgICAgICAgICAgICAgIHBjX2NvbXBhdF9kZWZhdWx0cywg
cGNfY29tcGF0X2RlZmF1bHRzX2xlbik7DQo+IH0NCj4NCj4gc3RhdGljIHZvaWQgcGNfcTM1Xzlf
MF9tYWNoaW5lX29wdGlvbnMoTWFjaGluZUNsYXNzICptKQ0KPmRpZmYgLS1naXQgYS90ZXN0cy9x
dGVzdC92aXJ0aW8taW9tbXUtdGVzdC5jIGIvdGVzdHMvcXRlc3QvdmlydGlvLWlvbW11LXRlc3Qu
Yw0KPmluZGV4IDA2OGU3YTllNmMuLjBmMzYzODFhY2IgMTAwNjQ0DQo+LS0tIGEvdGVzdHMvcXRl
c3QvdmlydGlvLWlvbW11LXRlc3QuYw0KPisrKyBiL3Rlc3RzL3F0ZXN0L3ZpcnRpby1pb21tdS10
ZXN0LmMNCj5AQCAtMzQsNyArMzQsNyBAQCBzdGF0aWMgdm9pZCBwY2lfY29uZmlnKHZvaWQgKm9i
aiwgdm9pZCAqZGF0YSwNCj5RR3Vlc3RBbGxvY2F0b3IgKnRfYWxsb2MpDQo+ICAgICB1aW50OF90
IGJ5cGFzcyA9IHF2aXJ0aW9fY29uZmlnX3JlYWRiKGRldiwgMzYpOw0KPg0KPiAgICAgZ19hc3Nl
cnRfY21waW50KGlucHV0X3JhbmdlX3N0YXJ0LCA9PSwgMCk7DQo+LSAgICBnX2Fzc2VydF9jbXBo
ZXgoaW5wdXRfcmFuZ2VfZW5kLCA9PSwgVUlOVDY0X01BWCk7DQo+KyAgICBnX2Fzc2VydF9jbXBo
ZXgoaW5wdXRfcmFuZ2VfZW5kLCA+PSwgMzIpOw0KDQpVSU5UMzJfTUFYPw0KDQpUaGFua3MNClpo
ZW56aG9uZw0KDQo+ICAgICBnX2Fzc2VydF9jbXBpbnQoZG9tYWluX3JhbmdlX3N0YXJ0LCA9PSwg
MCk7DQo+ICAgICBnX2Fzc2VydF9jbXBpbnQoZG9tYWluX3JhbmdlX2VuZCwgPT0sIFVJTlQzMl9N
QVgpOw0KPiAgICAgZ19hc3NlcnRfY21waW50KGJ5cGFzcywgPT0sIDEpOw0KPi0tDQo+Mi40MS4w
DQoNCg==

