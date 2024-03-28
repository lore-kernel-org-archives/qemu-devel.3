Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F896C54E64
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Mar 2024 11:10:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rpndE-0007ni-ON; Thu, 28 Mar 2024 07:09:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Jiqian.Chen@amd.com>)
 id 1rpndB-0007nV-M3
 for qemu-devel@nongnu.org; Thu, 28 Mar 2024 07:09:13 -0400
Received: from mail-mw2nam04on20600.outbound.protection.outlook.com
 ([2a01:111:f403:240a::600]
 helo=NAM04-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Jiqian.Chen@amd.com>)
 id 1rpnd6-00031W-Sc
 for qemu-devel@nongnu.org; Thu, 28 Mar 2024 07:09:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fhlgzf2CXqdg6GAqqWXwo4FS6fU7jFPhbkoMjiG31kfuGnZjDElHqA7+p8442UnrJqELdYlw8dJ5qgNZhpCFKYeD7PuZp9j3pk1UhxG1+8FGhf3YRHRC1UJBE0KBaSDPQ37ICH1cIHBmi43nZBheKF8Pz46Y6XXwrN9P9ofnSx4HlslZt5+AB3BGo+Ggf4yPW4jukzQsPIWfsGfa6vLO6uRoFKNWO6deu0QE9UXejrGWGrcFGVc3fZ1ohevQW8dshpgeY+y2R6mB9S9nmetUrjTsmPE1TYkUZ3qjs9VjvWlOUUQ3OxpgkA3azirlkIQhdWC0QH4fgxOVMLdv0VG+SQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jecTKEiXcZ+pYFS7hZgqahiaVMLl5VBFk9ih72xrSYg=;
 b=eyNeGGkLz0MGmk6cBXjLtBVqv8OX2gv0atmO5TLIe20xIwA4Z+lR924T6ia9wIgR6oh6It8aZnIO1IUhPiffo+10kZf4bsLuhrCZrRYOdzOrU4AjE+3QmZwerBDN1tR4EqCkT9mNGv+7SPfawlRNeZELfhuEAo7MWctatp7N1SmRQbSWZlbTgHy9MRU/2Hg/C6NQme2PzEXDVfVTKM6UhKYtXw6n2wPLnPlMwFuHPlk43VTsblskANjIEoGgaYsMEjG0By6v5iSVczfv8L3aqIk7oddWuyfYBX9P5uQ6mPr9AIPgYMl86QZX1Xbb0dHQc9ED6GHPIr1E6DVoKTBjCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jecTKEiXcZ+pYFS7hZgqahiaVMLl5VBFk9ih72xrSYg=;
 b=j97Dw1z57ASglo8PgRAsiJUcBSTamub1WGXtFQjXK+pw3maCjhLFJ9XMhcSFp68hQrcDizuCrFVW4Po8pmjW4rn9/ApYu/Dcmg1OEslUvrbwZy2mzrfRIdI3geozrfmQ8QFNgUG9XBe3fdnDgHB9WyQb5pX4GLf0z0dwN4Jk9ZQ=
Received: from BL1PR12MB5849.namprd12.prod.outlook.com (2603:10b6:208:384::18)
 by SA1PR12MB6917.namprd12.prod.outlook.com (2603:10b6:806:24c::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.32; Thu, 28 Mar
 2024 11:08:59 +0000
Received: from BL1PR12MB5849.namprd12.prod.outlook.com
 ([fe80::debf:178c:f5df:5efa]) by BL1PR12MB5849.namprd12.prod.outlook.com
 ([fe80::debf:178c:f5df:5efa%6]) with mapi id 15.20.7409.031; Thu, 28 Mar 2024
 11:08:58 +0000
From: "Chen, Jiqian" <Jiqian.Chen@amd.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "Huang, Ray"
 <Ray.Huang@amd.com>, "Chen, Jiqian" <Jiqian.Chen@amd.com>
Subject: Re: [RFC QEMU PATCH v8 2/2] virtio-pci: implement No_Soft_Reset bit
Thread-Topic: [RFC QEMU PATCH v8 2/2] virtio-pci: implement No_Soft_Reset bit
Thread-Index: AQHagPw4nwt3E6Dxr0GcatBwmH6cBbFM+5kAgACHiIA=
Date: Thu, 28 Mar 2024 11:08:58 +0000
Message-ID: <BL1PR12MB5849ACCD6602EAB88BE2FED9E73B2@BL1PR12MB5849.namprd12.prod.outlook.com>
References: <20240328103903.408290-1-Jiqian.Chen@amd.com>
 <20240328103903.408290-3-Jiqian.Chen@amd.com>
 <20240328065606-mutt-send-email-mst@kernel.org>
In-Reply-To: <20240328065606-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-imapappendstamp: IA1PR12MB6330.namprd12.prod.outlook.com
 (15.20.7292.000)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5849:EE_|SA1PR12MB6917:EE_
x-ms-office365-filtering-correlation-id: 82c0bce9-d7c1-4cd8-2a72-08dc4f177779
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zF4AbaCnOAc8bLr3/xcjOfbIj8JR15b3inC+K4RAOgy94cqgpysF60AYbZKoZprwIiHsexxGUScq2735WO6Yvqj6Zqfxr3be9q/X2EOQFVrz3fMIWFqnhQIG0emgNTW8Ngei09UK86J0CvNDI9zSHZcntMAHkTl609YYhQM5FhVxj+GbUQKZIksKrv+mj1vknRA31TnroVAqVoH8RPqtiyvbyftMC8H1vLs2gGjWKSFxRBxJEaUwBhxGpm/1bnlgV7NLXqJRdQb1oXYiQ9xGk2gZ5urfkyHHNyRoTG54iPeyugYw5z3bIcYeGP6f1wVGh+vMOIsyql185ADIfEK+bUJ7RsF9xxmfyqeNSaNfO3o7IJkDl2aacixc4yRj5KJ0ioy/puh/qynE/Afq5HW2FSG+KAtTiP0fP5v4AkLtJNA53dkVI3fg09HAuBWxVY5/k4Cx9fLHA53uE/uQ1yEX264sH6Y4zrLKD8jPi+hIpsgmy+l2pYtPf/2okH61r6DsTau8rUV1kBk9mwpNd2OA0jgYfS7LsEoNFdVPX4Sz8laWBXRwlTSqKLwtxtV42ieq6kO15o0NrmpikvwNc35hGPgevGR+fzrNGMgVXM1SzxTAntV8IDnAuJQucDfvqiskWuNymfaiw716QgM9K5RVZ8+YprF49SP3mH70V2//MNFw6Aqg9MpFMCB/8hPXGZcVORbLJBhkl6WTMxgrEx5taX6fB/vGGyJfg1jRfYbDp98=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5849.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(366007)(1800799015)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NWF3ZExzSnpaT3F5MU4wR1A0RjJTWkNaUGpJSTh0cWx0MHVRQ3lRaGZRRmJI?=
 =?utf-8?B?alIyaURXSk9WdkNFenJSSnFjalJ5ZUlOWUx3M0hOdXQ0aVV6N09NOUEyZ2tx?=
 =?utf-8?B?TWhRZTJ5dnc0NURnK3ZRSnVXUWNyOS82LzRQU2VkUExGSzNNSXd0dS9JOWVW?=
 =?utf-8?B?cXV6b05Zb0kxZW4xRFo0bUp5emVwZkpGbGlCTGxCd1AzNjVLMkRrT3hsazBp?=
 =?utf-8?B?VUkwSHFjWUhQdk1QYUFVN0hjd0ZJRWdYdVd0NnlscU40eEttMkZrdHYyaklq?=
 =?utf-8?B?Mng2aThFY2hQQTZ0cVhib0gwc0ZGdGJxa3hYWVQySTJ1WWFoUWcra0IwUTlT?=
 =?utf-8?B?R2lwTHFkL3V3OFBtYnYrSzJWZEtSL3NlRzFnUTlEakhSTFVJdi9qc09kVEI0?=
 =?utf-8?B?R2NZckNFeU83Z1F2SERyYjNXakRaRS9yeFBjUHJFYi9jRGlnUXN4ZUt3QlRW?=
 =?utf-8?B?cG1FS0Rlb0c4aW1ZTDJoRzFYNUIyY0NKQVVmU2FkcDBnZUluN0hxSWN3MjEx?=
 =?utf-8?B?cUhNcXV3NjQ2akxhMXhvYlpDdUc5Vk5LeVY2cXFrcDlyUlFxVUttUjJJeXVh?=
 =?utf-8?B?dzltaG9YeFZGMmZXRW1qQ2tLTEZFYzV4T1N5dzcrMm9qUmt1NE5LT1dURXJB?=
 =?utf-8?B?dmRoQnBkUngrdVUvcG5JS3FYQThNUExQWjlQWDdvY3FxU2tNVituNkJWL09O?=
 =?utf-8?B?OHp0aXhTZXdONDJidVBOamFuQlhTVE1SL2pQQnI1d2dObjhkT2xwdVhqZHFO?=
 =?utf-8?B?L2JXYjQwY1l2TnNPb041SjhMSmxwcDFxcEJPTlFnTTJud2N4M1l2emE4YzBU?=
 =?utf-8?B?eW8xZDBrY29uaEt6M0RPY05TRUdhMEcxM2dORkhDMkdYWXRYZEhCUHdld0FZ?=
 =?utf-8?B?cnJlZG5rRU0wY0NuQlc5ZXAzcHRrYjhXVFkxWFBVUEovTzRKSnpQS1U5RWNZ?=
 =?utf-8?B?bldPQzMreWN3cnBsMW9scTZ5bGE0b1I5OFVodkptSVdYZW5iOW1JUTVzdjha?=
 =?utf-8?B?WTF6dlBJSU5oMjJTUWs4WVJlUWVvNkF6OG1hQnZWTmlVSjE1UmZaRE1yazNj?=
 =?utf-8?B?K3I3SFlUTDZNKzgweWVySVFsUnVXcWpxVnpVU0xGYnZRYWFHZWR2QkFuMnVI?=
 =?utf-8?B?cEJaTjVHTXk4LzJVR0FDNFpLTFB3bURHS2xWVXVoNjRmYnpvdzRiTVRFZlkx?=
 =?utf-8?B?QVZHeVFvMnBIVndMR1Bud0I4a1RjQ3dNdXlheTQ5N2FhQmRsSlJnSzIzRDlz?=
 =?utf-8?B?VW0yZ1VFeUFkcEZRdXlzdkFvUUtsYnlEQUpQRVlLbUptNU9uYmo5dmtKaTZv?=
 =?utf-8?B?NVIza2xwYU9iYXZ6NDQydXZqaUpGWHNRa1crNm1MY1hzaTVNalhGMzVRQng3?=
 =?utf-8?B?VTN5clRQSWI1cWtYaVFMWHVQVGhwZ2NTNVFpYlJRWW45NUlpR1p0QVY5WWJY?=
 =?utf-8?B?RzhFNkNQUHI4MzJVdVdySEdvRkVQc2M1SzdjRWd2ZG5mWUpVamVtTEd2Y0Vz?=
 =?utf-8?B?WGZvUDMrd3JGZ2hBK0NiUGNtWUgxYmcyMkE3R09qZ3JoTW03QVBndDAySi9Z?=
 =?utf-8?B?OW54dTlDVmloU0FOdFkzSnNId1pRSmtsUWRxYVJNazNzNHVVb1ZwRkhLQitX?=
 =?utf-8?B?NVQyaUVxcjlEM2NEaTNzR001cDlMVFZUZmptM2RlK3lPZ21ldUY4bWpEKzBU?=
 =?utf-8?B?MXU1L2N5VERsQnE5cE9RZ09xaVRCSERnR3NVcFI1b2ZvOGlKaExGb2E4bHo5?=
 =?utf-8?B?ckU5S0NCRi9SZVNJNUxYa3lNdndQaWhmQS81YVBwMW5Vdis0VWJpeFF6MENa?=
 =?utf-8?B?SlpobHhxUWk4RHlTT3NNSGRVZVU2b2RUOUV0MGt0OUdQRU1xUGZ5MjVaZ1lV?=
 =?utf-8?B?QXBCOWlMZlRORTdZR1hkbmtraGNGQmFpRVV1ZkxVLzhZejVPMmxSQlVjeXF4?=
 =?utf-8?B?Z3RUU1NaTXBqbnJFbWo5RFpra0xZQVB1R2lZZ3NWeGVvWWF1ZFpRYjdBM1FP?=
 =?utf-8?B?T0ZpOSt4b0pYMHF3dVo5SitpUzFiWERRQkFLZ3ZhaFVtMmxRMmswbFdkU3NG?=
 =?utf-8?B?WEN6OHE0SzdySFE0MVY5dVhQME9vOWZKcHNqMkt6d3QxdGkvMElOMzh0ZVJ6?=
 =?utf-8?Q?+zQ4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <640E38B0465DDF47B4BAC477E3DA65EF@amdcloud.onmicrosoft.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82c0bce9-d7c1-4cd8-2a72-08dc4f177779
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Mar 2024 11:08:58.6427 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: P6RPBvBafNuM/e8JzIm4C3KXgk213MTzeOe2MQtu0uslhqoUrD5Ssvjz2DrSafw+5gIJLynTfJsslvwYtauiNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6917
Received-SPF: permerror client-ip=2a01:111:f403:240a::600;
 envelope-from=Jiqian.Chen@amd.com;
 helo=NAM04-MW2-obe.outbound.protection.outlook.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.08,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

T24gMjAyNC8zLzI4IDE4OjU3LCBNaWNoYWVsIFMuIFRzaXJraW4gd3JvdGU6DQo+IE9uIFRodSwg
TWFyIDI4LCAyMDI0IGF0IDA2OjM5OjAzUE0gKzA4MDAsIEppcWlhbiBDaGVuIHdyb3RlOg0KPj4g
SW4gY3VycmVudCBjb2RlLCB3aGVuIGd1ZXN0IGRvZXMgUzMsIHZpcnRpbyBkZXZpY2VzIGFyZSBy
ZXNldCBkdWUgdG8NCj4+IHRoZSBiaXQgTm9fU29mdF9SZXNldCBpcyBub3Qgc2V0LiBBZnRlciBy
ZXNldHRpbmcsIHRoZSBkaXNwbGF5IHJlc291cmNlcw0KPj4gb2YgdmlydGlvLWdwdSBhcmUgZGVz
dHJveWVkLCB0aGVuIHRoZSBkaXNwbGF5IGNhbid0IGNvbWUgYmFjayBhbmQgb25seQ0KPj4gc2hv
dyBibGFuayBhZnRlciByZXN1bWluZy4NCj4+DQo+PiBJbXBsZW1lbnQgTm9fU29mdF9SZXNldCBi
aXQgb2YgUENJX1BNX0NUUkwgcmVnaXN0ZXIsIHRoZW4gZ3Vlc3QgY2FuIGNoZWNrDQo+PiB0aGlz
IGJpdCwgaWYgdGhpcyBiaXQgaXMgc2V0LCB0aGUgZGV2aWNlcyByZXNldHRpbmcgd2lsbCBub3Qg
YmUgZG9uZSwgYW5kDQo+PiB0aGVuIHRoZSBkaXNwbGF5IGNhbiB3b3JrIGFmdGVyIHJlc3VtaW5n
Lg0KPj4NCj4+IFNpZ25lZC1vZmYtYnk6IEppcWlhbiBDaGVuIDxKaXFpYW4uQ2hlbkBhbWQuY29t
Pg0KPj4gLS0tDQo+PiAgaHcvdmlydGlvL3ZpcnRpby1wY2kuYyAgICAgICAgIHwgMjkgKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysNCj4+ICBpbmNsdWRlL2h3L3ZpcnRpby92aXJ0aW8tcGNp
LmggfCAgNSArKysrKw0KPj4gIDIgZmlsZXMgY2hhbmdlZCwgMzQgaW5zZXJ0aW9ucygrKQ0KPj4N
Cj4+IGRpZmYgLS1naXQgYS9ody92aXJ0aW8vdmlydGlvLXBjaS5jIGIvaHcvdmlydGlvL3ZpcnRp
by1wY2kuYw0KPj4gaW5kZXggMDVkZDAzNzU4ZDlmLi44ZDlmYWI4NTVjN2QgMTAwNjQ0DQo+PiAt
LS0gYS9ody92aXJ0aW8vdmlydGlvLXBjaS5jDQo+PiArKysgYi9ody92aXJ0aW8vdmlydGlvLXBj
aS5jDQo+PiBAQCAtMjM3OCw2ICsyMzc4LDExIEBAIHN0YXRpYyB2b2lkIHZpcnRpb19wY2lfcmVh
bGl6ZShQQ0lEZXZpY2UgKnBjaV9kZXYsIEVycm9yICoqZXJycCkNCj4+ICAgICAgICAgICAgICBw
Y2llX2NhcF9sbmtjdGxfaW5pdChwY2lfZGV2KTsNCj4+ICAgICAgICAgIH0NCj4+ICANCj4+ICsg
ICAgICAgIGlmIChwcm94eS0+ZmxhZ3MgJiBWSVJUSU9fUENJX0ZMQUdfUE1fTk9fU09GVF9SRVNF
VCkgew0KPj4gKyAgICAgICAgICAgIHBjaV9zZXRfd29yZChwY2lfZGV2LT5jb25maWcgKyBwb3Mg
KyBQQ0lfUE1fQ1RSTCwNCj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgUENJX1BNX0NUUkxf
Tk9fU09GVF9SRVNFVCk7DQo+PiArICAgICAgICB9DQo+PiArDQo+PiAgICAgICAgICBpZiAocHJv
eHktPmZsYWdzICYgVklSVElPX1BDSV9GTEFHX0lOSVRfUE0pIHsNCj4+ICAgICAgICAgICAgICAv
KiBJbml0IFBvd2VyIE1hbmFnZW1lbnQgQ29udHJvbCBSZWdpc3RlciAqLw0KPj4gICAgICAgICAg
ICAgIHBjaV9zZXRfd29yZChwY2lfZGV2LT53bWFzayArIHBvcyArIFBDSV9QTV9DVFJMLA0KPj4g
QEAgLTI0NDAsMTEgKzI0NDUsMzMgQEAgc3RhdGljIHZvaWQgdmlydGlvX3BjaV9yZXNldChEZXZp
Y2VTdGF0ZSAqcWRldikNCj4+ICAgICAgfQ0KPj4gIH0NCj4+ICANCj4+ICtzdGF0aWMgYm9vbCB2
aXJ0aW9fcGNpX25vX3NvZnRfcmVzZXQoUENJRGV2aWNlICpkZXYpDQo+PiArew0KPj4gKyAgICB1
aW50MTZfdCBwbWNzcjsNCj4+ICsNCj4+ICsgICAgaWYgKCFwY2lfaXNfZXhwcmVzcyhkZXYpIHx8
ICFkZXYtPmV4cC5wbV9jYXApIHsNCj4+ICsgICAgICAgIHJldHVybiBmYWxzZTsNCj4+ICsgICAg
fQ0KPj4gKw0KPj4gKyAgICBwbWNzciA9IHBjaV9nZXRfd29yZChkZXYtPmNvbmZpZyArIGRldi0+
ZXhwLnBtX2NhcCArIFBDSV9QTV9DVFJMKTsNCj4+ICsNCj4+ICsgICAgLyoNCj4+ICsgICAgICog
V2hlbiBOb19Tb2Z0X1Jlc2V0IGJpdCBpcyBzZXQgYW5kIHRoZSBkZXZpY2UNCj4+ICsgICAgICog
aXMgaW4gRDNob3Qgc3RhdGUsIGRvbid0IHJlc2V0IGRldmljZQ0KPj4gKyAgICAgKi8NCj4+ICsg
ICAgcmV0dXJuICgocG1jc3IgJiBQQ0lfUE1fQ1RSTF9OT19TT0ZUX1JFU0VUKSAmJg0KPj4gKyAg
ICAgICAgICAgIChwbWNzciAmIFBDSV9QTV9DVFJMX1NUQVRFX01BU0spID09IDMpOw0KPiANCj4g
DQo+IE5vIG5lZWQgZm9yICgpIGFyb3VuZCByZXR1cm4gdmFsdWUuDQpPaywgd2lsbCBkZWxldGUg
aW4gbmV4dCB2ZXJzaW9uLg0KDQo+IA0KPj4gK30NCj4+ICsNCj4+ICBzdGF0aWMgdm9pZCB2aXJ0
aW9fcGNpX2J1c19yZXNldF9ob2xkKE9iamVjdCAqb2JqKQ0KPj4gIHsNCj4+ICAgICAgUENJRGV2
aWNlICpkZXYgPSBQQ0lfREVWSUNFKG9iaik7DQo+PiAgICAgIERldmljZVN0YXRlICpxZGV2ID0g
REVWSUNFKG9iaik7DQo+PiAgDQo+PiArICAgIGlmICh2aXJ0aW9fcGNpX25vX3NvZnRfcmVzZXQo
ZGV2KSkgew0KPj4gKyAgICAgICAgcmV0dXJuOw0KPj4gKyAgICB9DQo+PiArDQo+PiAgICAgIHZp
cnRpb19wY2lfcmVzZXQocWRldik7DQo+PiAgDQo+PiAgICAgIGlmIChwY2lfaXNfZXhwcmVzcyhk
ZXYpKSB7DQo+PiBAQCAtMjQ4NCw2ICsyNTExLDggQEAgc3RhdGljIFByb3BlcnR5IHZpcnRpb19w
Y2lfcHJvcGVydGllc1tdID0gew0KPj4gICAgICAgICAgICAgICAgICAgICAgVklSVElPX1BDSV9G
TEFHX0lOSVRfTE5LQ1RMX0JJVCwgdHJ1ZSksDQo+PiAgICAgIERFRklORV9QUk9QX0JJVCgieC1w
Y2llLXBtLWluaXQiLCBWaXJ0SU9QQ0lQcm94eSwgZmxhZ3MsDQo+PiAgICAgICAgICAgICAgICAg
ICAgICBWSVJUSU9fUENJX0ZMQUdfSU5JVF9QTV9CSVQsIHRydWUpLA0KPj4gKyAgICBERUZJTkVf
UFJPUF9CSVQoIngtcGNpZS1wbS1uby1zb2Z0LXJlc2V0IiwgVmlydElPUENJUHJveHksIGZsYWdz
LA0KPj4gKyAgICAgICAgICAgICAgICAgICAgVklSVElPX1BDSV9GTEFHX1BNX05PX1NPRlRfUkVT
RVRfQklULCBmYWxzZSksDQo+PiAgICAgIERFRklORV9QUk9QX0JJVCgieC1wY2llLWZsci1pbml0
IiwgVmlydElPUENJUHJveHksIGZsYWdzLA0KPj4gICAgICAgICAgICAgICAgICAgICAgVklSVElP
X1BDSV9GTEFHX0lOSVRfRkxSX0JJVCwgdHJ1ZSksDQo+PiAgICAgIERFRklORV9QUk9QX0JJVCgi
YWVyIiwgVmlydElPUENJUHJveHksIGZsYWdzLA0KPiANCj4gSSBhbSBhIGJpdCBjb25mdXNlZCBh
Ym91dCB0aGlzIHBhcnQuDQo+IERvIHlvdSB3YW50IHRvIG1ha2UgdGhpcyBzb2Z0d2FyZSBjb250
cm9sbGFibGU/DQpZZXMsIGJlY2F1c2UgZXZlbiB0aGUgcmVhbCBoYXJkd2FyZSwgdGhpcyBiaXQg
aXMgbm90IGFsd2F5cyBzZXQuDQoNCj4gT3Igc2hvdWxkIHRoaXMgYmUgc2V0IHRvIHRydWUgYnkg
ZGVmYXVsdCBhbmQgdGhlbg0KPiBjaGFuZ2VkIHRvIGZhbHNlIGZvciBvbGQgbWFjaGluZSB0eXBl
cz8NCkhvdyBjYW4gSSBkbyBzbz8NCkRvIHlvdSBtZWFuIHNldCB0aGlzIHRvIHRydWUgYnkgZGVm
YXVsdCwgYW5kIGlmIG9sZCBtYWNoaW5lIHR5cGVzIGRvbid0IG5lZWQgdGhpcyBiaXQsIHRoZXkg
Y2FuIHBhc3MgZmFsc2UgY29uZmlnIHRvIHFlbXUgd2hlbiBydW5uaW5nIHFlbXU/DQoNCj4gDQo+
IA0KPj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvaHcvdmlydGlvL3ZpcnRpby1wY2kuaCBiL2luY2x1
ZGUvaHcvdmlydGlvL3ZpcnRpby1wY2kuaA0KPj4gaW5kZXggNGQ1N2E5Yzc1MTMwLi5jNzU4ZWI3
MzgyMzQgMTAwNjQ0DQo+PiAtLS0gYS9pbmNsdWRlL2h3L3ZpcnRpby92aXJ0aW8tcGNpLmgNCj4+
ICsrKyBiL2luY2x1ZGUvaHcvdmlydGlvL3ZpcnRpby1wY2kuaA0KPj4gQEAgLTQ0LDYgKzQ0LDcg
QEAgZW51bSB7DQo+PiAgICAgIFZJUlRJT19QQ0lfRkxBR19BRVJfQklULA0KPj4gICAgICBWSVJU
SU9fUENJX0ZMQUdfQVRTX1BBR0VfQUxJR05FRF9CSVQsDQo+PiAgICAgIFZJUlRJT19QQ0lfRkxB
R19WRFBBX0JJVCwNCj4+ICsgICAgVklSVElPX1BDSV9GTEFHX1BNX05PX1NPRlRfUkVTRVRfQklU
LA0KPj4gIH07DQo+PiAgDQo+PiAgLyogTmVlZCB0byBhY3RpdmF0ZSB3b3JrLWFyb3VuZHMgZm9y
IGJ1Z2d5IGd1ZXN0cyBhdCB2bXN0YXRlIGxvYWQuICovDQo+PiBAQCAtODAsNiArODEsMTAgQEAg
ZW51bSB7DQo+PiAgLyogSW5pdCBQb3dlciBNYW5hZ2VtZW50ICovDQo+PiAgI2RlZmluZSBWSVJU
SU9fUENJX0ZMQUdfSU5JVF9QTSAoMSA8PCBWSVJUSU9fUENJX0ZMQUdfSU5JVF9QTV9CSVQpDQo+
PiAgDQo+PiArLyogSW5pdCBUaGUgTm9fU29mdF9SZXNldCBiaXQgb2YgUG93ZXIgTWFuYWdlbWVu
dCAqLw0KPj4gKyNkZWZpbmUgVklSVElPX1BDSV9GTEFHX1BNX05PX1NPRlRfUkVTRVQgXA0KPj4g
KyAgKDEgPDwgVklSVElPX1BDSV9GTEFHX1BNX05PX1NPRlRfUkVTRVRfQklUKQ0KPj4gKw0KPj4g
IC8qIEluaXQgRnVuY3Rpb24gTGV2ZWwgUmVzZXQgY2FwYWJpbGl0eSAqLw0KPj4gICNkZWZpbmUg
VklSVElPX1BDSV9GTEFHX0lOSVRfRkxSICgxIDw8IFZJUlRJT19QQ0lfRkxBR19JTklUX0ZMUl9C
SVQpDQo+PiAgDQo+PiAtLSANCj4+IDIuMzQuMQ0KPiANCg0KLS0gDQpCZXN0IHJlZ2FyZHMsDQpK
aXFpYW4gQ2hlbi4NCg==

