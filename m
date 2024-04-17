Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C965C4345F
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Apr 2024 06:00:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rwyK2-0000Cm-Bp; Wed, 17 Apr 2024 01:59:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Jiqian.Chen@amd.com>)
 id 1rwyJx-0000CT-5y
 for qemu-devel@nongnu.org; Wed, 17 Apr 2024 01:59:03 -0400
Received: from mail-bn1nam02on20600.outbound.protection.outlook.com
 ([2a01:111:f403:2407::600]
 helo=NAM02-BN1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Jiqian.Chen@amd.com>)
 id 1rwyJt-0007cH-EF
 for qemu-devel@nongnu.org; Wed, 17 Apr 2024 01:59:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k//kpnM7abQ4SmMPMjJK/80t3djlMYQ7pwz+EfZ7eO5yaGtuka1HzbYga55d1Ygx6ox1XCO2trFPU2znzJDhP4D/0Mg174CwcsSODn/QNB85MXYOgVd+4/kK1T2SwLeoQvyIOECVIRWRTfevc8oJT/8DT1WSOhvt2wz7hVPgYti+wZo0PhQd14utOC/9fuP4mbmwLwrce/CRdMDE6nyYPX/mAXOnzTGNlTRTMrFQl+Dk9hg+ZBRaQsKLFQkNZKpJpvYhfmTsl5FarZZW29AQ201V1FuJzkJh/cA/eZ26klbB7bBaYmoYlwU862svREKq3TotVDJU7UEMmd/yF4qZbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XUsGjtu6kpSO12DfUXPJWh4rDtOiNJTiZ59vOtgm0oQ=;
 b=BLpPWoBmSlDbg3OfdxVdA3Kvdy3O+tYgsSHBiJpD1aTvkzWtUJyqaJ58pfpSGgIHiIpKdz2WySZ1Zu1ORxRKig2IEpo5USC83qN6SdnFuMiRcB2YwmSBrUif/pBNQlzeuxIM4M+6yg5FYlGixSl3F2LomS8Hct1tBTHHIlrvd9gRHCo9EVWNEHt6kVZMMwg+7Q0IwAIA69gVT8WuIdyRPoaiRzduxM5vGMmQfvjEqdMuw4oQpBOXRHVmdzOnmk0SqBG9y0YqTSXEZdeGXi8Jx/uFbzG54gxJ6Kkj/hEji82h9DJYtzyx6e5eUE6mLc3UJANtS3QFoCntPFeEdnFnDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XUsGjtu6kpSO12DfUXPJWh4rDtOiNJTiZ59vOtgm0oQ=;
 b=aIhL0HkFKmggQ+d3kUPAa6FNZyrWEioCCXK33yxnHkakI6McPSKOqbBGzVwtHleH4Em7iw/GEO6vj5BuLRNdmByFrvuUTzf13VGiow+n6JSIyL2qvWmr8TpFwN+sxqUEClwhFYj8dbKDKvjLD3VyX7OOoSlRPilhNqnvyjzPUz4=
Received: from BL1PR12MB5849.namprd12.prod.outlook.com (2603:10b6:208:384::18)
 by DS7PR12MB8370.namprd12.prod.outlook.com (2603:10b6:8:eb::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.37; Wed, 17 Apr
 2024 05:58:49 +0000
Received: from BL1PR12MB5849.namprd12.prod.outlook.com
 ([fe80::b77f:9333:3a5a:d285]) by BL1PR12MB5849.namprd12.prod.outlook.com
 ([fe80::b77f:9333:3a5a:d285%6]) with mapi id 15.20.7452.049; Wed, 17 Apr 2024
 05:58:49 +0000
From: "Chen, Jiqian" <Jiqian.Chen@amd.com>
To: Yan Vugenfirer <yvugenfi@redhat.com>
CC: Igor Mammedov <imammedo@redhat.com>, "Michael S . Tsirkin"
 <mst@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Jason Wang
 <jasowang@redhat.com>, "Huang, Ray" <Ray.Huang@amd.com>, "Chen, Jiqian"
 <Jiqian.Chen@amd.com>
Subject: Re: [RFC QEMU PATCH v9 2/2] virtio-pci: implement No_Soft_Reset bit
Thread-Topic: [RFC QEMU PATCH v9 2/2] virtio-pci: implement No_Soft_Reset bit
Thread-Index: AQHaj8v0vhbSJoQeWk+O1EoAWaQkZLFrCqGAgAE6pwD//6zNgIAAjDwA
Date: Wed, 17 Apr 2024 05:58:49 +0000
Message-ID: <BL1PR12MB5849D18C865821E85B5D7611E70F2@BL1PR12MB5849.namprd12.prod.outlook.com>
References: <20240416070127.116922-1-Jiqian.Chen@amd.com>
 <20240416070127.116922-3-Jiqian.Chen@amd.com>
 <20240416174531.6573af25@imammedo.users.ipa.redhat.com>
 <BL1PR12MB5849B0755AE7DFD07A9B253FE70F2@BL1PR12MB5849.namprd12.prod.outlook.com>
 <CAGoVJZyodBsX-FAxEjAGaXfu4ce8J1Qj4auWt-o9F+oRPVKBXg@mail.gmail.com>
In-Reply-To: <CAGoVJZyodBsX-FAxEjAGaXfu4ce8J1Qj4auWt-o9F+oRPVKBXg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-imapappendstamp: BL3PR12MB6644.namprd12.prod.outlook.com
 (15.20.7495.000)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5849:EE_|DS7PR12MB8370:EE_
x-ms-office365-filtering-correlation-id: 2f5f5454-4b1a-4a00-ce3e-08dc5ea37397
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mYeKqyv6ab3j4f8hiolWX2ik4pY5ypWZNWSVYKOUO8kt4hxB+rm1+kjQ6l/PgwZE5aBDVTnI+XBu6CUFqkaveMJAPiPLA0eNaUq7VchkG+jdXY8P1jvkDImrfU1p2Yp1fp3KT2tCH0jAWFUgnh3MZb2kiTQ4bIKS1py6Ffe4mdbFcfaA/K7iqucaJtYuulXI9ayeq/HeH1MKjxGQuuRScUTfnUb89Qd3yK258tgqaU4V2IpG6z1rS5R5fVOCurwM/oH9cQfNi9mMDffhyNpb0pWcFdUjKQFXgYrBFi7yW5JF+IOAqRGzHFUbtBCIcoZdAFLqmIMzml6TFmRBbmfN+7RD5PgTMUN9T6JlDcoQnINnZLXjOPO4wmsIoHcgIOMRmi7Em8TtJQvWpvdPn1PletenqPvbJCTCdmRZW/i8o6E6lhDLXvuxT8BBz5BHf635DhCqKh4FE8VSVBOwXVaV2t7THp6bXD4lvnVGmM+XfhLu+G1wrbGXzDeVM4GihyDBeuV9IEY+CursQV8Q4sXR4nwCed0sFSdEx7Db/wNXq743ItyxgKczARG+sE0HkYToutvAMDKO1aY63nqqruxJDShdGyUgxb2RYGsoVE1wgsNwyxAEh56OF7zf1WWFPub2XRe2wYeRP/Hy37BCib0lFsBZr7TNnVNWlar9gJeae4pw9U6t8mbDjWAW+/rXx/DBXVPFzMebKpi+MH/vPFJX0VMQS7Ocj4ulnPpmaJDP7+0=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5849.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(1800799015)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VC9GRkRrYVU3S2Vacmk2UHpoMzdWbVJMa0tMaXJaMGFLZi92YmdQdWtjakNx?=
 =?utf-8?B?MDkvdDl4cUxQVGYrbjdjekUwY3ArdnI5Z1NMWk5jbG1NYXljSmk1dHptWFhS?=
 =?utf-8?B?Ui9zWVhlZnkrNzhxc3M2ZmdqN243WTgyMzVkMTZoZmkyV0tTQzZhZ29HS2Vr?=
 =?utf-8?B?UUxYMWFFR2dDQklhRUZ6YkpxQWwzeUpTcjE2NEVpUmRNZzQ4NUswS1VHUmxh?=
 =?utf-8?B?V3ZXRktDRTFleVQwVEF1RVFGaTM3UVF4WTFBQlhtcTZOZDZ3cHpaRElkZVFI?=
 =?utf-8?B?ZndzT3dCc3RpR0NFc3BMbjdBTTZCY05vMnVLMkRiZGF0QTV4ZmE3S2JzQ2hH?=
 =?utf-8?B?QkVDK2pqZDF4d29aS3ViWDAyNzNRVHNLT0cwU0MzekJwb1p5cG4wQXRHYzZk?=
 =?utf-8?B?NmtyRC9yS3BVMjc3RXhlOThqK1l3a0JMUXRrcXY0R2M2NU9ZZmhRTS8xbVFR?=
 =?utf-8?B?d0IvRkdSMnF0NzFIbkdQUnpLU3gxaURtWGVvcG5ITW9ySTNLdWgvN2xDK21N?=
 =?utf-8?B?ZmlpR05uTFlCVXNJckd0MEl2Tkg1NGNOVitTcFVTdWdValpJSzlWdkRCUHMz?=
 =?utf-8?B?cU5uU1ExTjNNTHpacERaa3JNVVJrQW9oUTZSUEt6aVFub3pZOUdLcFBXaGt0?=
 =?utf-8?B?MkZwTy9QU1ZyWTJhYXIzWUQvekNjdXNqcnljQ3ByNGpwRnVjQllCV2lSNGQx?=
 =?utf-8?B?dlNMckxUR01qK2s5dTdjWXVpaWdqZUxPdDlkQmZEcTV0d28welkrcWlkZVlV?=
 =?utf-8?B?bnBMSll2NFZEN0VtN0xDdEx2WWJIZGlIREJpdy9HNnQ0SCtSbnhuZ0pISzZE?=
 =?utf-8?B?S1p2TVMzNmlxUC9FSU1GNWR6UmhYRUsvZFlSci80NjY0d3hYK21hMHl6eGxJ?=
 =?utf-8?B?VU9qdHpkaWZpSGlYd01VT1Q2S1p4MHcyL2d3N1pvU1ZKUlpLenc5bzdXNWg3?=
 =?utf-8?B?NnRFalFTWHhwQUVBdU9rL3oxV3pjTGpDWDAvY1I5b09SMnRub0RVVnRnWTUv?=
 =?utf-8?B?ZFc5SldlaU5xeDBhRzNERzZ3K1pMeVFtY1JxTzJEZ25Pb1pDZVlrM0pXOEY1?=
 =?utf-8?B?WGZZVldoU3dYSVpJUkFzWWF2aXNVS3liQzdaek5QL1J0WHU0cnRCSUYrL0Ix?=
 =?utf-8?B?dXg4d2Fad2doZDZSN083NzUrUVdraWhENEoxZ1pvclVXTkhyQStNN3V1N1oy?=
 =?utf-8?B?RThQVURhN0Z2aXVHTmZmL2V6YXNqcHQ2WWJHQWg2REZyZE1TMXBNQUtWLzJk?=
 =?utf-8?B?cjNsV3VXYUtCZ2FJWXVGYis5dVFOV1ZrMFFuZ2Vwamg3UkRnMlRpVXdYenJT?=
 =?utf-8?B?SjdJMC9WRG5VRGs3QTBhUTRvcjZGaHdUcGd0REhMc1l6SUh0N1hsNlBmeWNw?=
 =?utf-8?B?Z0VVVWFIblZ6bzJUU1F6WVdnbjRVbWE3VWZXdUl3dkovbFNrd0ZpVCt4M2M1?=
 =?utf-8?B?SjFvNTdMVHBIMUQ0L3dqTVYvdlVlR1NxSm9makxHaThLNmxNMzR1ekU0amxk?=
 =?utf-8?B?VzZ4SG5FTExReTZoY3A5UU1zeEljOFpNaW83UkhvM1RHU1pQa0ZCR3FpS1J6?=
 =?utf-8?B?blJlRXFQSXBBQ2NLc1JJMGxXVG5oQkNOV3FBd21rRGN5MEJxMHdjZk5SaExj?=
 =?utf-8?B?akFLeFhqN0NpVmNuWG5KTHhWemZNSFpCN0lWbEg3cmFEU3FDRjF3VlA4Yzdz?=
 =?utf-8?B?Yjl2VUFoVGJCTUhXRmVDR0pYOG93aVVRR3J6ZHBKT3BsTGs0VnluTGt1VWFr?=
 =?utf-8?B?Vm95enh4MjNoYndNazBtS1lzSWRpTXB2dnRjSXhaMUNmU202bkJtMTJ1N09Z?=
 =?utf-8?B?VExod25TTkY5WUFRaDhsMHhKMFBnQWpFZmFQQWdiVHFOTHlxRkZ1K3FONXFV?=
 =?utf-8?B?Y1IzM2s2cnJYV1RIdldidWlmZlRoSzJOVkJEbEFySHlXWmdtMk9FZXZMU3N3?=
 =?utf-8?B?Y1RvVzBoRno4K3FBcDlMYXY3TDJkUktCcG5TWmIvbWdUOGhIZVpoVHVMb1Fx?=
 =?utf-8?B?SHlRcytnT2RSSUcyWnVEOGYyNFh2dDk3MlpqNTdhNWJqZi81VEJWTmY4WUFo?=
 =?utf-8?B?L3FPRGtMRmpJNDduak90T21waVZndXE4NlpBdktHaWY3dTB5aHJJQ3FjMVNK?=
 =?utf-8?Q?r1XU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A375B2EB0173DD4DA2AE8676741F7310@amdcloud.onmicrosoft.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f5f5454-4b1a-4a00-ce3e-08dc5ea37397
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2024 05:58:49.1323 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7BXmSavFiVS7BQmM/81ZVltOOx4ytiupYpMt5X51rW8pxN2QOPqVRTpIMGXreE8nKpl8348Ql9cr5qTQ7m138Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8370
Received-SPF: permerror client-ip=2a01:111:f403:2407::600;
 envelope-from=Jiqian.Chen@amd.com;
 helo=NAM02-BN1-obe.outbound.protection.outlook.com
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.844,
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

T24gMjAyNC80LzE3IDEzOjMzLCBZYW4gVnVnZW5maXJlciB3cm90ZToNCj4gT24gV2VkLCBBcHIg
MTcsIDIwMjQgYXQgNjoxM+KAr0FNIENoZW4sIEppcWlhbiA8SmlxaWFuLkNoZW5AYW1kLmNvbT4g
d3JvdGU6DQo+Pg0KPj4gT24gMjAyNC80LzE2IDIzOjQ1LCBJZ29yIE1hbW1lZG92IHdyb3RlOg0K
Pj4+IE9uIFR1ZSwgMTYgQXByIDIwMjQgMTU6MDE6MjcgKzA4MDANCj4+PiBKaXFpYW4gQ2hlbiA8
SmlxaWFuLkNoZW5AYW1kLmNvbT4gd3JvdGU6DQo+Pj4NCj4+Pj4gSW4gY3VycmVudCBjb2RlLCB3
aGVuIGd1ZXN0IGRvZXMgUzMsIHZpcnRpby1ncHUgYXJlIHJlc2V0IGR1ZSB0byB0aGUNCj4+Pj4g
Yml0IE5vX1NvZnRfUmVzZXQgaXMgbm90IHNldC4gQWZ0ZXIgcmVzZXR0aW5nLCB0aGUgZGlzcGxh
eSByZXNvdXJjZXMNCj4+Pj4gb2YgdmlydGlvLWdwdSBhcmUgZGVzdHJveWVkLCB0aGVuIHRoZSBk
aXNwbGF5IGNhbid0IGNvbWUgYmFjayBhbmQgb25seQ0KPj4+PiBzaG93IGJsYW5rIGFmdGVyIHJl
c3VtaW5nLg0KPj4+DQo+Pj4gSnVzdCBhIGhpZ2ggbGV2ZWwgcXVlc3Rpb24uDQo+Pj4gVHlwaWNh
bGx5IHdoZW4gc3lzdGVtIGdvZXMgaW50byBTMyBhbGwgZGV2aWNlcyAobW9kdWxvIFJBTSkgbG9v
c2UgY29udGV4dA0KPj4+IChha2EgcG93ZXJlZCBvZmYpLCBhbmQgdGhlbiBpdCdzIHVwdG8gZGV2
aWNlIGRyaXZlciB0byByZWNvdmVyIHdoYXRldmVyDQo+Pj4gd2FzIGxvc3QuDQo+PiBObywgd2hh
dCB5b3Ugc2FpZCBpcyBqdXN0IG9uZSBzaXR1YXRpb24gdGhhdCB3aGVuIHN5c3RlbSBnb2VzIGlu
dG8gUzMgZGV2aWNlcyBsb29zZSBjb250ZXh0IGFuZCBmdWxseSByZWluaXRpYWxpemVkIGFuZCBi
ZSBEMC11bmluaXRpYWxpemVkIHN0YXRlLg0KPj4gVGhlIG90aGVyIHNpdHVhdGlvbiBpcyB0aGUg
Y29udGV4dCBtdXN0IGJlIG1haW50YWluZWQgc28gdGhhdCB0aGUgZGV2aWNlcyBjYW4gcXVpY2ts
eSBiZSBEMC1hY3RpdmUgc3RhdGUgYWZ0ZXIgcmVzdW1pbmcuDQo+PiBUaGVyZSBhcmUgc29tZSBk
ZXNjcmlwdGlvbnMgaW4gUENJZSBzcGVjaWZpY2F0aW9uIGluIENoYXB0ZXIgNS4zLjEuNCBEMyBz
dGF0ZToNCj4+ICIgRnVuY3Rpb25hbCBjb250ZXh0IGlzIHJlcXVpcmVkIHRvIGJlIG1haW50YWlu
ZWQgYnkgRnVuY3Rpb25zIGluIHRoZSBEM0hvdCBzdGF0ZSBpZiB0aGUgTm9fU29mdF9SZXNldCBm
aWVsZCBpbiB0aGUgUE1DU1IgaXMNCj4+IFNldC4gSW4gdGhpcyBjYXNlLCBTeXN0ZW0gU29mdHdh
cmUgaXMgbm90IHJlcXVpcmVkIHRvIHJlLWluaXRpYWxpemUgdGhlIEZ1bmN0aW9uIGFmdGVyIGEg
dHJhbnNpdGlvbiBmcm9tIEQzSG90IHRvIEQwICh0aGUNCj4+IEZ1bmN0aW9uIHdpbGwgYmUgaW4g
dGhlIEQwYWN0aXZlIHN0YXRlKS4gSWYgdGhlIE5vX1NvZnRfUmVzZXQgYml0IGlzIENsZWFyLCBm
dW5jdGlvbmFsIGNvbnRleHQgaXMgbm90IHJlcXVpcmVkIHRvIGJlDQo+PiBtYWludGFpbmVkIGJ5
IHRoZSBGdW5jdGlvbiBpbiB0aGUgRDNIb3Qgc3RhdGUsIGhvd2V2ZXIgaXQgaXMgbm90IGd1YXJh
bnRlZWQgdGhhdCBmdW5jdGlvbmFsIGNvbnRleHQgd2lsbCBiZSBjbGVhcmVkIGFuZA0KPj4gc29m
dHdhcmUgbXVzdCBub3QgZGVwZW5kIG9uIHN1Y2ggYmVoYXZpb3IuIEFzIGEgcmVzdWx0LCBpbiB0
aGlzIGNhc2UgU3lzdGVtIFNvZnR3YXJlIGlzIHJlcXVpcmVkIHRvIGZ1bGx5IHJlLWluaXRpYWxp
emUgdGhlDQo+PiBGdW5jdGlvbiBhZnRlciBhIHRyYW5zaXRpb24gdG8gRDAgYXMgdGhlIEZ1bmN0
aW9uIHdpbGwgYmUgaW4gdGhlIEQwdW5pbml0aWFsaXplZCBzdGF0ZS4iDQo+Pg0KPiBCVFc6IGFj
Y29yZGluZyB0byBXaW5kb3dzIGRvY3VtZW50YXRpb24gRDMgSG90IHN0YXRlIGltcGxlbWVudGF0
aW9uIGlzDQo+IGEgbXVzdCBmb3IgcmVhbCBIVyBkZXZpY2VzLg0KPiBodHRwczovL2xlYXJuLm1p
Y3Jvc29mdC5jb20vZW4tdXMvd2luZG93cy1oYXJkd2FyZS9kcml2ZXJzL2tlcm5lbC9kZXZpY2Ut
c2xlZXBpbmctc3RhdGVzDQo+ICJEZXZpY2UgcG93ZXIgc3RhdGVzIEQxLCBEMiwgYW5kIEQzIGFy
ZSB0aGUgZGV2aWNlIGxvdy1wb3dlciBzdGF0ZXMuDQo+IFN0YXJ0aW5nIHdpdGggV2luZG93cyA4
LCBEMyBpcyBkaXZpZGVkIGludG8gdHdvIHN1YnN0YXRlcywgRDNob3QgYW5kDQo+IEQzY29sZC4N
Cj4gDQo+IEQxIGFuZCBEMiBhcmUgaW50ZXJtZWRpYXRlIGxvdy1wb3dlciBzdGF0ZXMuIE1hbnkg
Y2xhc3NlcyBvZiBkZXZpY2VzDQo+IGRvIG5vdCBkZWZpbmUgdGhlc2Ugc3RhdGVzLiBBbGwgZGV2
aWNlcyBtdXN0IGRlZmluZSBEM2hvdC4iDQpZZXMsIEkga25vdywgaXQgaXMgYWxzbyBkZXNjcmli
ZWQgaW4gUENJZSBzcGVjaWZpY2F0aW9uLiBCdXQgdGhpcyBpcyBub3QgYSBjb25mbGljdC4NCldo
ZW4gc2V0IE5vX1NvZnRfUmVzZXQgZGlkbuKAmXQgbWVhbiB0aGUgZGV2aWNlIGNhbid0IGVudGVy
IEQzaG90IHN0YXRlLiBJdCBtZWFucyB3aGVuIGRldmljZSBlbnRlciBEM2hvdCwgdGhlIGNvbnRl
eHQgb2YgZGV2aWNlIG11c3QgYmUgbWFpbnRhaW5lZC4NCg0KPiANCj4gQmVzdCByZWdhcmRzLA0K
PiBZYW4uDQo+IA0KPiANCj4+IFdoYXQncyBtb3JlLCBub3QgYWxsIHZpcnRpbyBkZXZpY2VzJyBj
b250ZXh0IGNhbiBiZSByZWNvdmVyZWQgYnkgZHJpdmVyIGFmdGVyIHJlc3VtaW5nLCBsaWtlIHZp
cnRpby1ncHUsIHdlIGhhdmUgbm90IGVub3VnaCBpbmZvcm1hdGlvbiB0byByZS1jcmVhdGUgYWxs
DQo+PiBkaXNwbGF5IHJlc291cmNlcywgdGhhdCBpcyBkaXNjdXNzZWQgaW4gbXkgcHJldmlvdXMg
dmVyc2lvbiBlbWFpbCB0aHJlYWQuDQo+Pg0KPj4+IFNvIHdoeSBzaG91bGQgd2UgaW1wbGVtZW50
IGh3KHFlbXUpIHdvcmthcm91bmQgZm9yIGEgZHJpdmVyIHByb2JsZW0/DQo+PiBJIHRoaW5rIHRo
aXMgaXMgbm90IGEgd29ya2Fyb3VuZCwgTm9fU29mdF9SZXNldCBiaXQgaXMgYWxzbyBkZXNjcmli
ZWQgaW4gUENJZSBzcGVjaWZpY2F0aW9uLCBpdCBjYW4gYmUgc2V0IG9yIG5vdC4NCj4+IEFuZCB3
ZSBjYW4gc2V0IHRoaXMgYml0IGZvciB0aGUgc3BlY2lmaWMgZGV2aWNlIHdoaWNoIHdlIHdhbnQg
dG8gbWFpbnRhaW4gY29udGV4dCBkdXJpbmcgUzMuDQo+Pg0KPj4+DQo+Pj4+DQo+Pj4+IEltcGxl
bWVudCBOb19Tb2Z0X1Jlc2V0IGJpdCBvZiBQQ0lfUE1fQ1RSTCByZWdpc3RlciwgdGhlbiBndWVz
dCBjYW4gY2hlY2sNCj4+Pj4gdGhpcyBiaXQsIGlmIHRoaXMgYml0IGlzIHNldCwgdGhlIGRldmlj
ZXMgcmVzZXR0aW5nIHdpbGwgbm90IGJlIGRvbmUsIGFuZA0KPj4+PiB0aGVuIHRoZSBkaXNwbGF5
IGNhbiB3b3JrIGFmdGVyIHJlc3VtaW5nLg0KPj4+Pg0KPj4+PiBOb19Tb2Z0X1Jlc2V0IGJpdCBp
cyBpbXBsZW1lbnRlZCBmb3IgYWxsIHZpcnRpbyBkZXZpY2VzLCBhbmQgd2FzIHRlc3RlZA0KPj4+
PiBvbmx5IG9uIHZpcnRpby1ncHUgZGV2aWNlLiBTZXQgaXQgZmFsc2UgYnkgZGVmYXVsdCBmb3Ig
c2FmZXR5Lg0KPj4+Pg0KPj4+PiBTaWduZWQtb2ZmLWJ5OiBKaXFpYW4gQ2hlbiA8SmlxaWFuLkNo
ZW5AYW1kLmNvbT4NCj4+Pj4gLS0tDQo+Pj4+ICBody92aXJ0aW8vdmlydGlvLXBjaS5jICAgICAg
ICAgfCAzNyArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrDQo+Pj4+ICBpbmNsdWRl
L2h3L3ZpcnRpby92aXJ0aW8tcGNpLmggfCAgNSArKysrKw0KPj4+PiAgMiBmaWxlcyBjaGFuZ2Vk
LCA0MiBpbnNlcnRpb25zKCspDQo+Pj4+DQo+Pj4+IGRpZmYgLS1naXQgYS9ody92aXJ0aW8vdmly
dGlvLXBjaS5jIGIvaHcvdmlydGlvL3ZpcnRpby1wY2kuYw0KPj4+PiBpbmRleCBhMWI2MTMwOGU3
YTAuLjgyZmE0ZGVmZTVjZCAxMDA2NDQNCj4+Pj4gLS0tIGEvaHcvdmlydGlvL3ZpcnRpby1wY2ku
Yw0KPj4+PiArKysgYi9ody92aXJ0aW8vdmlydGlvLXBjaS5jDQo+Pj4+IEBAIC0yMjMwLDYgKzIy
MzAsMTEgQEAgc3RhdGljIHZvaWQgdmlydGlvX3BjaV9yZWFsaXplKFBDSURldmljZSAqcGNpX2Rl
diwgRXJyb3IgKiplcnJwKQ0KPj4+PiAgICAgICAgICAgICAgcGNpZV9jYXBfbG5rY3RsX2luaXQo
cGNpX2Rldik7DQo+Pj4+ICAgICAgICAgIH0NCj4+Pj4NCj4+Pj4gKyAgICAgICAgaWYgKHByb3h5
LT5mbGFncyAmIFZJUlRJT19QQ0lfRkxBR19QTV9OT19TT0ZUX1JFU0VUKSB7DQo+Pj4+ICsgICAg
ICAgICAgICBwY2lfc2V0X3dvcmQocGNpX2Rldi0+Y29uZmlnICsgcG9zICsgUENJX1BNX0NUUkws
DQo+Pj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgUENJX1BNX0NUUkxfTk9fU09GVF9SRVNF
VCk7DQo+Pj4+ICsgICAgICAgIH0NCj4+Pj4gKw0KPj4+PiAgICAgICAgICBpZiAocHJveHktPmZs
YWdzICYgVklSVElPX1BDSV9GTEFHX0lOSVRfUE0pIHsNCj4+Pj4gICAgICAgICAgICAgIC8qIElu
aXQgUG93ZXIgTWFuYWdlbWVudCBDb250cm9sIFJlZ2lzdGVyICovDQo+Pj4+ICAgICAgICAgICAg
ICBwY2lfc2V0X3dvcmQocGNpX2Rldi0+d21hc2sgKyBwb3MgKyBQQ0lfUE1fQ1RSTCwNCj4+Pj4g
QEAgLTIyOTIsMTEgKzIyOTcsMzcgQEAgc3RhdGljIHZvaWQgdmlydGlvX3BjaV9yZXNldChEZXZp
Y2VTdGF0ZSAqcWRldikNCj4+Pj4gICAgICB9DQo+Pj4+ICB9DQo+Pj4+DQo+Pj4+ICtzdGF0aWMg
Ym9vbCB2aXJ0aW9fcGNpX25vX3NvZnRfcmVzZXQoUENJRGV2aWNlICpkZXYpDQo+Pj4+ICt7DQo+
Pj4+ICsgICAgdWludDE2X3QgcG1jc3I7DQo+Pj4+ICsNCj4+Pj4gKyAgICBpZiAoIXBjaV9pc19l
eHByZXNzKGRldikgfHwgIWRldi0+ZXhwLnBtX2NhcCkgew0KPj4+PiArICAgICAgICByZXR1cm4g
ZmFsc2U7DQo+Pj4+ICsgICAgfQ0KPj4+PiArDQo+Pj4+ICsgICAgcG1jc3IgPSBwY2lfZ2V0X3dv
cmQoZGV2LT5jb25maWcgKyBkZXYtPmV4cC5wbV9jYXAgKyBQQ0lfUE1fQ1RSTCk7DQo+Pj4+ICsN
Cj4+Pj4gKyAgICAvKg0KPj4+PiArICAgICAqIFdoZW4gTm9fU29mdF9SZXNldCBiaXQgaXMgc2V0
IGFuZCB0aGUgZGV2aWNlDQo+Pj4+ICsgICAgICogaXMgaW4gRDNob3Qgc3RhdGUsIGRvbid0IHJl
c2V0IGRldmljZQ0KPj4+PiArICAgICAqLw0KPj4+PiArICAgIHJldHVybiAocG1jc3IgJiBQQ0lf
UE1fQ1RSTF9OT19TT0ZUX1JFU0VUKSAmJg0KPj4+PiArICAgICAgICAgICAocG1jc3IgJiBQQ0lf
UE1fQ1RSTF9TVEFURV9NQVNLKSA9PSAzOw0KPj4+PiArfQ0KPj4+PiArDQo+Pj4+ICBzdGF0aWMg
dm9pZCB2aXJ0aW9fcGNpX2J1c19yZXNldF9ob2xkKE9iamVjdCAqb2JqKQ0KPj4+PiAgew0KPj4+
PiAgICAgIFBDSURldmljZSAqZGV2ID0gUENJX0RFVklDRShvYmopOw0KPj4+PiAgICAgIERldmlj
ZVN0YXRlICpxZGV2ID0gREVWSUNFKG9iaik7DQo+Pj4+DQo+Pj4+ICsgICAgLyoNCj4+Pj4gKyAg
ICAgKiBOb3RlIHRoYXQ6IGEgcHJvcG9zYWwgdG8gYWRkIFNVU1BFTkQgYml0IGlzIGJlaW5nIGRp
c2N1c3NlZCwNCj4+Pj4gKyAgICAgKiBtYXkgbmVlZCB0byBjb25zaWRlciB0aGUgc3RhdGUgb2Yg
U1VTUEVORCBiaXQgaW4gZnV0dXJlDQo+Pj4+ICsgICAgICovDQo+Pj4+ICsgICAgaWYgKHZpcnRp
b19wY2lfbm9fc29mdF9yZXNldChkZXYpKSB7DQo+Pj4+ICsgICAgICAgIHJldHVybjsNCj4+Pj4g
KyAgICB9DQo+Pj4+ICsNCj4+Pj4gICAgICB2aXJ0aW9fcGNpX3Jlc2V0KHFkZXYpOw0KPj4+Pg0K
Pj4+PiAgICAgIGlmIChwY2lfaXNfZXhwcmVzcyhkZXYpKSB7DQo+Pj4+IEBAIC0yMzM2LDYgKzIz
NjcsMTIgQEAgc3RhdGljIFByb3BlcnR5IHZpcnRpb19wY2lfcHJvcGVydGllc1tdID0gew0KPj4+
PiAgICAgICAgICAgICAgICAgICAgICBWSVJUSU9fUENJX0ZMQUdfSU5JVF9MTktDVExfQklULCB0
cnVlKSwNCj4+Pj4gICAgICBERUZJTkVfUFJPUF9CSVQoIngtcGNpZS1wbS1pbml0IiwgVmlydElP
UENJUHJveHksIGZsYWdzLA0KPj4+PiAgICAgICAgICAgICAgICAgICAgICBWSVJUSU9fUENJX0ZM
QUdfSU5JVF9QTV9CSVQsIHRydWUpLA0KPj4+PiArICAgIC8qDQo+Pj4+ICsgICAgICogZm9yIHNh
ZmV0eSwgc2V0IHRoaXMgZmFsc2UgYnkgZGVmYXVsdCwgaWYgY2hhbmdlIGl0IHRvIHRydWUsDQo+
Pj4+ICsgICAgICogbmVlZCB0byBjb25zaWRlciBjb21wYXRpYmxlIGZvciBvbGQgbWFjaGluZQ0K
Pj4+PiArICAgICAqLw0KPj4+PiArICAgIERFRklORV9QUk9QX0JJVCgicGNpZS1wbS1uby1zb2Z0
LXJlc2V0IiwgVmlydElPUENJUHJveHksIGZsYWdzLA0KPj4+PiArICAgICAgICAgICAgICAgICAg
ICBWSVJUSU9fUENJX0ZMQUdfUE1fTk9fU09GVF9SRVNFVF9CSVQsIGZhbHNlKSwNCj4+Pj4gICAg
ICBERUZJTkVfUFJPUF9CSVQoIngtcGNpZS1mbHItaW5pdCIsIFZpcnRJT1BDSVByb3h5LCBmbGFn
cywNCj4+Pj4gICAgICAgICAgICAgICAgICAgICAgVklSVElPX1BDSV9GTEFHX0lOSVRfRkxSX0JJ
VCwgdHJ1ZSksDQo+Pj4+ICAgICAgREVGSU5FX1BST1BfQklUKCJhZXIiLCBWaXJ0SU9QQ0lQcm94
eSwgZmxhZ3MsDQo+Pj4+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2h3L3ZpcnRpby92aXJ0aW8tcGNp
LmggYi9pbmNsdWRlL2h3L3ZpcnRpby92aXJ0aW8tcGNpLmgNCj4+Pj4gaW5kZXggNTlkODgwMThj
MTZhLi45ZTY3YmEzOGM3NDggMTAwNjQ0DQo+Pj4+IC0tLSBhL2luY2x1ZGUvaHcvdmlydGlvL3Zp
cnRpby1wY2kuaA0KPj4+PiArKysgYi9pbmNsdWRlL2h3L3ZpcnRpby92aXJ0aW8tcGNpLmgNCj4+
Pj4gQEAgLTQzLDYgKzQzLDcgQEAgZW51bSB7DQo+Pj4+ICAgICAgVklSVElPX1BDSV9GTEFHX0lO
SVRfRkxSX0JJVCwNCj4+Pj4gICAgICBWSVJUSU9fUENJX0ZMQUdfQUVSX0JJVCwNCj4+Pj4gICAg
ICBWSVJUSU9fUENJX0ZMQUdfQVRTX1BBR0VfQUxJR05FRF9CSVQsDQo+Pj4+ICsgICAgVklSVElP
X1BDSV9GTEFHX1BNX05PX1NPRlRfUkVTRVRfQklULA0KPj4+PiAgfTsNCj4+Pj4NCj4+Pj4gIC8q
IE5lZWQgdG8gYWN0aXZhdGUgd29yay1hcm91bmRzIGZvciBidWdneSBndWVzdHMgYXQgdm1zdGF0
ZSBsb2FkLiAqLw0KPj4+PiBAQCAtNzksNiArODAsMTAgQEAgZW51bSB7DQo+Pj4+ICAvKiBJbml0
IFBvd2VyIE1hbmFnZW1lbnQgKi8NCj4+Pj4gICNkZWZpbmUgVklSVElPX1BDSV9GTEFHX0lOSVRf
UE0gKDEgPDwgVklSVElPX1BDSV9GTEFHX0lOSVRfUE1fQklUKQ0KPj4+Pg0KPj4+PiArLyogSW5p
dCBUaGUgTm9fU29mdF9SZXNldCBiaXQgb2YgUG93ZXIgTWFuYWdlbWVudCAqLw0KPj4+PiArI2Rl
ZmluZSBWSVJUSU9fUENJX0ZMQUdfUE1fTk9fU09GVF9SRVNFVCBcDQo+Pj4+ICsgICgxIDw8IFZJ
UlRJT19QQ0lfRkxBR19QTV9OT19TT0ZUX1JFU0VUX0JJVCkNCj4+Pj4gKw0KPj4+PiAgLyogSW5p
dCBGdW5jdGlvbiBMZXZlbCBSZXNldCBjYXBhYmlsaXR5ICovDQo+Pj4+ICAjZGVmaW5lIFZJUlRJ
T19QQ0lfRkxBR19JTklUX0ZMUiAoMSA8PCBWSVJUSU9fUENJX0ZMQUdfSU5JVF9GTFJfQklUKQ0K
Pj4+Pg0KPj4+DQo+Pg0KPj4gLS0NCj4+IEJlc3QgcmVnYXJkcywNCj4+IEppcWlhbiBDaGVuLg0K
PiANCg0KLS0gDQpCZXN0IHJlZ2FyZHMsDQpKaXFpYW4gQ2hlbi4NCg==

