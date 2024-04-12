Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4D8AC4345F
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2024 06:49:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rvAj4-000896-53; Fri, 12 Apr 2024 02:49:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Jiqian.Chen@amd.com>)
 id 1rvAj0-00088n-44
 for qemu-devel@nongnu.org; Fri, 12 Apr 2024 02:49:26 -0400
Received: from mail-bn8nam12on20600.outbound.protection.outlook.com
 ([2a01:111:f403:2418::600]
 helo=NAM12-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Jiqian.Chen@amd.com>)
 id 1rvAix-0008Mq-CJ
 for qemu-devel@nongnu.org; Fri, 12 Apr 2024 02:49:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ckfQgF6vcGzp01b+9Lq73AkSJxYCqELM1/ABJl4mabVovrGC7jQyAjws8VUBg8RCUbH22z+Mj3aPutJOJTAOFgSCetKJFf/GGskiYwWOQgT/YBx11NsbBVaLBQc5+sQhJF7IG6twBRHurtVYyuBxjlM12Bf6L6IYPrwm+HHcO/l20sZGoYRly3WwK2MVECUEebsJpnKcTPtaVq7HdOriYCCKvdvNjjV4WakZeDPr2f2cPw54SrKdu0ET7nAVOR02tNZgBhe7n5/EEyXzs73VZ/mbOgpdloG0t2iYgsv6X5j9vD2gJ4HSqYeto+hV3HokwL0/5ww4L2QYri1ZdRE2EA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LtPJwfqZqbn3Tzn7RbNoVWifHMcyUmS/L3Kt8RdRMag=;
 b=FbQXItW/HqE9QxFdq6ZFRYw7QJ9i+Y6m6npqXcBGjvYmxhr37sYV1ZUtPtpvzD3/GI+/aueKY1N+hhezxW2+NImep1dPRtWH5IwA0/Q7msEpxgKUp8GhLhIUa29dGP0sjYhVj9heiadfMeJxPeZYjgk+4B0uhOz9G1aNyi2E3RdjLDnJsOu/5Ju12B9oD4CzrxKtJu3YnkmdCikRutOMIhtsf4kCDiruEXcq3YlAYZgFJc/ngGCTBlTsbi03/qxVDvkUadvB407rvdoHAnRU+A4VF10VU2wD00/VunhgwBu5gJVpW9PF4QUFMP/CzlzUGaxJzzdnB50g6oeBpcaJ6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LtPJwfqZqbn3Tzn7RbNoVWifHMcyUmS/L3Kt8RdRMag=;
 b=ATFbxwgECzw8fVo4Iq1GCrTNKSZv8s8W3SI2C2go52JYG+i1kQj2h34DFkzVDuUs4ogmy455QVwW+eju75QXYa4EGd8VsW3AQG0qQWm2Q7rg9WjP/tBfJzwg5ROjOkiHBvmgUHdkmSAhBorh0mNkiwhfN0QtPC/sgc/Gqrhnxm8=
Received: from BL1PR12MB5849.namprd12.prod.outlook.com (2603:10b6:208:384::18)
 by PH8PR12MB7277.namprd12.prod.outlook.com (2603:10b6:510:223::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.54; Fri, 12 Apr
 2024 06:49:10 +0000
Received: from BL1PR12MB5849.namprd12.prod.outlook.com
 ([fe80::b77f:9333:3a5a:d285]) by BL1PR12MB5849.namprd12.prod.outlook.com
 ([fe80::b77f:9333:3a5a:d285%6]) with mapi id 15.20.7409.053; Fri, 12 Apr 2024
 06:49:10 +0000
From: "Chen, Jiqian" <Jiqian.Chen@amd.com>
To: Jason Wang <jasowang@redhat.com>
CC: "Michael S. Tsirkin" <mst@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "Huang, Ray" <Ray.Huang@amd.com>, "Chen, Jiqian"
 <Jiqian.Chen@amd.com>
Subject: Re: [RFC QEMU PATCH v8 2/2] virtio-pci: implement No_Soft_Reset bit
Thread-Topic: [RFC QEMU PATCH v8 2/2] virtio-pci: implement No_Soft_Reset bit
Thread-Index: AQHagPw4nwt3E6Dxr0GcatBwmH6cBbFM+5kAgACHiID//5QEAIABse2A//+IQICAADj0gIAGTJQAgAdcY4CAAI4zAIAH/+mA//+FtAAAEOzcgA==
Date: Fri, 12 Apr 2024 06:49:10 +0000
Message-ID: <BL1PR12MB58493B9D251ABC6331B4F4EAE7042@BL1PR12MB5849.namprd12.prod.outlook.com>
References: <20240328103903.408290-1-Jiqian.Chen@amd.com>
 <20240328103903.408290-3-Jiqian.Chen@amd.com>
 <20240328065606-mutt-send-email-mst@kernel.org>
 <BL1PR12MB5849ACCD6602EAB88BE2FED9E73B2@BL1PR12MB5849.namprd12.prod.outlook.com>
 <20240328083503-mutt-send-email-mst@kernel.org>
 <BL1PR12MB5849C37A0B0E1AF02644C203E73A2@BL1PR12MB5849.namprd12.prod.outlook.com>
 <CACGkMEt=V4V4JgT08o5_f7tj-eNZDi2GB4=H_Qp7xALrRxBWhQ@mail.gmail.com>
 <20240329064431-mutt-send-email-mst@kernel.org>
 <BL1PR12MB5849AA89DC28465714590B56E73E2@BL1PR12MB5849.namprd12.prod.outlook.com>
 <CACGkMEu6uEF+4P3_3Q5tw4TNZ9dj3GwJh+h_BtWDfq3WeUhKJQ@mail.gmail.com>
 <20240407074848-mutt-send-email-mst@kernel.org>
 <BL1PR12MB5849D4F87AEA6059CE71AE34E7042@BL1PR12MB5849.namprd12.prod.outlook.com>
 <CACGkMEvqZYrXiWmwOLvna_JjxqNCVzKc3tmYF6LLniQAmL0NrQ@mail.gmail.com>
In-Reply-To: <CACGkMEvqZYrXiWmwOLvna_JjxqNCVzKc3tmYF6LLniQAmL0NrQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-imapappendstamp: IA1PR12MB6435.namprd12.prod.outlook.com
 (15.20.7472.008)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5849:EE_|PH8PR12MB7277:EE_
x-ms-office365-filtering-correlation-id: 3a9a3434-8a1f-4438-e8d3-08dc5abca847
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +2BbdnWdyuO8KJQmSBuIOjWFpcMkPjehG6RLzbxC6cWEysZLGCMqUzg39m0OzBB99qPH44njf3wKccU1/nCTWY0IOloeZiV9+9jUX1sS3XRI4pYUTOe9NoIsDiGWH5WS2WUDvr1K2PdPBwRHVxes3Bsq0MlEs+5mHS0IzSKYQtulEZpUKje/EeK5ba0Hwq/yW/Pl6Ir7mzC7GZ6goqa7mdDRApCRl0BSRaK+EA47LqGzal81+SOovolW+CSRVdoXH0LGayafVNPFj7NotBRUowZh/qrMHo6Z4b/6GmpF0YIfOHPzVKrl3xWGk7Fj5xKac/bpRz8wjg0SLmIzUSYVYY9pocwnT6J6EyzfOFok2POvqjk5reRSlJmJNF2kicdgHH7iHRdbAfaxVXrs42djWonB6gl1YLix5PidLlqZm02c2yL7vxnU/ayLu8puC4xOGc+DsASYqRg5ujdFSeUFQ0lhkoeDO3okYRDzBhdet9IAmqcPeQpdAvNuS9ud/KqRzJ7Z1bLJdX/6TAzx1VEHshjlTXzMArhB+qGe4ZcPXhE/7uHEQ802TyutzhIlGVmE0uXrZt6YbMGKxD0ZeCsCUaEwRHqK/hJjXLueQTrDUAgPx5esnxiGjOkNAurZ3K5R8VKE6HRJRta8ztnp96MPKOIu4TSiixoF6ElQudhT2P9Y329XLApxKmpCjznQWadGPAl6bB+yJKGXp7nUHIMFP1QOQW85rvlsjd2cYl4+JV4=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5849.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(376005)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?S2ZjeGltOHU4bGRvVDdnblpYY0dQWSt6b1N3WVAxVmZiNk43K1J3QTU2b0R4?=
 =?utf-8?B?NmpJRGk0dW53QUtETW93aGc5TjRtUHBSS3ZqM3E5WFdEQ1YraVJwRjRlbzZG?=
 =?utf-8?B?YVVKWElFK3R2ZUdCSzBnRTdFODZleTN3MWNHRERGYmdlOUllTU56SzFjbTI4?=
 =?utf-8?B?OHpGSzVOMDBhcXllRGpyR1NGeVRKOE5qaysweWlXTU9MbmVUc2oyVWxZQ2tl?=
 =?utf-8?B?VE5rcjBsVkNDQThYVkluQzVWTlhvdVBOTVN3T1liS1pVVWc1Z3NaRjNpQnFa?=
 =?utf-8?B?YitDOUwyR0Uva3RsZ2NSLzNMT0hnRlB5NWNXcWxEZ2twVEZkM3piWjZrNnlq?=
 =?utf-8?B?NVQ1d1A2UmQvNy80ZTl0TEFyVi9hSmE5NzBqRnYxdWUyVXRqQ2VwSnRtcHY1?=
 =?utf-8?B?cmlFelk4TW40Q2h4bkRiN0U5cVpUbnRiVHBkcW5aaUYrQkFNOXhjVS9HSy9G?=
 =?utf-8?B?WHB5Ri9RazExOEdWRUw0KzVmRVdwRlJvOEpNc1VieEszSEc0bWp5c3Y2VDV5?=
 =?utf-8?B?YUZ4SDErU0Q4VFNWZWhBVXhkSG1rNW9hbCtmYlREOE80TXlFa1M5NnBUU2Jx?=
 =?utf-8?B?c0hJV1plbDdZWlZUbFFXZzZhUWhMcXV2QTR2cmJrVzNHQ1I1Ymh0Ti9YamxT?=
 =?utf-8?B?NDVORnAxZVZkTE9MVEVNQ3RmS3krV1hxYUdHMTFXeFpKMTl5UXNaMlNuU0la?=
 =?utf-8?B?OVlHeDlxQysyZXl1NldVWFl1OThFbXZ1TXNYaU8vUUp3dks4WFM3aDJ1Z3pW?=
 =?utf-8?B?Q0xVMnRNSXA4QXphVXM2Wk9uTG9WWnFndHdzQjBEbUZ1QlRuaHNBNXB1emdv?=
 =?utf-8?B?MCs5ZjRuQk9ISjlIT2dSR3crR3kyeG5HYURFeG1seGxLK0xnRE0vTld2dlJB?=
 =?utf-8?B?bGY3QUs0OTFqN3lwSkVCU0JZMk5nTEFEMnlQbG9RRytZY25RT3ZPOGpUcXYw?=
 =?utf-8?B?UTgwWndTN1ZST2xsM25YcHRlQThPWlV2ZkF0RGRqYjJhUXBBUjFPRW9oeWRV?=
 =?utf-8?B?RzE5dC9XM2JTbTFrVnlHeDAzZzdDdUY0UkVnSjJsR0Z1TXk1V2ZLNmpaS29V?=
 =?utf-8?B?MFFEK2RWaFBBc3pQREZsNDZkNnl1ZktTYTFITEphczNtb3lmSGlMcUd1WTFB?=
 =?utf-8?B?Zk5pZ0x6bkN3MzMxNGN2NzN2ZG9uS1o4QlFYYXBTcHY4bmtqRXZDNkR5RWkv?=
 =?utf-8?B?czA0MkFObENYcjZxdXAzMjA4cDl0dmlBdmZFbms3Smptb2hEVkJkcEJCdkFF?=
 =?utf-8?B?ZEpRWVlVd1FZNklCNXA5czR2WUNmejJ4ZlhNdElyRVBIT3p5djFITTArVGIy?=
 =?utf-8?B?Skt4OWZBOTkvVGVWTzJReGp0dXRjTTNuVjZVTi9Cb0JhQzZHLzRvNWJJQjJj?=
 =?utf-8?B?MElOcVdBdEExNVJ0QWdTcUVzTy95RG5jWlVTeGprd0N5c1doN0RMbmEvMUJV?=
 =?utf-8?B?a2N1WVVTKzJESjMxMUFVMEpXazFaL3BhZFpnOW83bEM5aDdKOStKZHMyTitG?=
 =?utf-8?B?bndDQjhJWlhEa1VaTXdObnZSNW84YXY3eXZjaGNKb3ppVnl0NERudUFVeTZv?=
 =?utf-8?B?OGFzaTBJR2hwdm0rbmRLZnpBQnRydEJMa2RiajVFbk10dHNGc1lhZnBwWElH?=
 =?utf-8?B?Sm1iYnJoTXFNeTFVdnFUQnR0VUlOSXF2djdkUEwwaVdsYWZKTno4SUxCVnBl?=
 =?utf-8?B?Y0VFSmZGT01iY0hYV2RRYmdkOWY2cDZqdzdQc1NrZU4zSW1wTFlLQ2FjbXRw?=
 =?utf-8?B?VEQvcDlJdlZHekVjd3ZHb1VpSkcrbEZMMDJ2SWdkdlIySmRQNmREcnYybWJh?=
 =?utf-8?B?Ym9DRjZBaDFQMmJ4TFEycGY3ZjhSbllMd3pCUDR2QnFCMHhHSkFZNjVPWFlX?=
 =?utf-8?B?ZnRFVDRIY1FYbUE4MkpleGZOaTlwamJiUERzNUpTdmRtNG51VGJibmFhVlA0?=
 =?utf-8?B?RkpreWZnbzlBVWlja1hFbURwaUZWS3NtK0pXSm16ajVqYlh3ZjZpRGVqcHBq?=
 =?utf-8?B?dHNodkZ2L25XUEl4a3d4RGZmVFBCUWRKU2xjeDAyM2IvM3NoRHlzUW9tdSth?=
 =?utf-8?B?TzFRSFVFeUVwVS9tUHVOV3E2ZTRYM09qeHZZNlpVMGlzeG03azh3SFJxRS9w?=
 =?utf-8?Q?jjdQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D6F402B21745194DA95E5C2013395B72@amdcloud.onmicrosoft.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a9a3434-8a1f-4438-e8d3-08dc5abca847
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Apr 2024 06:49:10.3217 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uNWEJHMU7khUWdIiRQbUL94CFEJ+F9NuOVbLaiLrhNQsHzHHGiI534gZBoeCmYhNJuc9Ux179yda3Ov0lRVhzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7277
Received-SPF: permerror client-ip=2a01:111:f403:2418::600;
 envelope-from=Jiqian.Chen@amd.com;
 helo=NAM12-BN8-obe.outbound.protection.outlook.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.49,
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

T24gMjAyNC80LzEyIDE0OjQxLCBKYXNvbiBXYW5nIHdyb3RlOg0KPiBPbiBGcmksIEFwciAxMiwg
MjAyNCBhdCAyOjA14oCvUE0gQ2hlbiwgSmlxaWFuIDxKaXFpYW4uQ2hlbkBhbWQuY29tPiB3cm90
ZToNCj4+DQo+PiBPbiAyMDI0LzQvNyAxOTo0OSwgTWljaGFlbCBTLiBUc2lya2luIHdyb3RlOg0K
Pj4+Pj4gSSB3aWxsIHNldCB0aGUgZGVmYXVsdCB2YWx1ZSBvZiBOb19Tb2Z0X1Jlc2V0IGJpdCB0
byB0cnVlIGluIG5leHQgdmVyc2lvbiBhY2NvcmRpbmcgdG8geW91ciBvcGluaW9uLg0KPj4+Pj4g
QWJvdXQgdGhlIGNvbXBhdGliaWxpdHkgb2Ygb2xkIG1hY2hpbmUgdHlwZXMsIHdoaWNoIHR5cGVz
IHNob3VsZCBJIGNvbnNpZGVyPyBEb2VzIHRoZSBzYW1lIGFzIHgtcGNpZS1wbS1pbml0KGh3X2Nv
bXBhdF8yXzgpPw0KPj4+Pj4gRm9yZ2l2ZSBtZSBmb3Igbm90IGtub3dpbmcgbXVjaCBhYm91dCBj
b21wYXRpYmlsaXR5Lg0KPj4+Pg0KPj4+PiAieCIgbWVhbnMgbm8gY29tcGF0aWJpbGl0eSBhdCBh
bGwsIHBsZWFzZSBkcm9wIHRoZSAieCIgcHJlZml4LiBBbmQgaXQNCj4+Pj4gbG9va3MgbW9yZSBz
YWZlIHRvIHN0YXJ0IGFzICJmYWxzZSIgYnkgZGVmYXVsdC4NCj4+Pj4NCj4+Pj4gVGhhbmtzDQo+
Pj4NCj4+Pg0KPj4+IE5vdCBzdXJlIEkgYWdyZWUuIEV4dGVybmFsIGZsYWdzIGFyZSBmb3Igd2hl
biB1c2VycyB3YW50IHRvIHR3ZWFrIHRoZW0uDQo+Pj4gV2hlbiB3b3VsZCB1c2VycyB3YW50IGl0
IHRvIGJlIG9mZj8NCj4+PiBXaGF0IGlzIGRvbmUgaGVyZSBpcyBJIGZlZWwgc2FuZSwganVzdCBh
ZGQgbWFjaGluZSBjb21wYXQgbWFjaGluZXJ5DQo+Pj4gdG8gY2hhbmdlIHRvIG9mZiBmb3Igb2xk
IG1hY2hpbmUgdHlwZXMuDQo+PiBEbyB5b3Uga25vdyB3aGljaCBvbGQgbWFjaGluZXMgc2hvdWxk
IEkgY29uc2lkZXIgdG8gY29tcGF0aWJsZSB3aXRoPw0KPj4gT3Igd2hpY2ggZ3V5cyBzaG91bGQg
SSBhZGQgdG8gIkNDIiBhbmQgY2FuIGdldCBhbnN3ZXIgZnJvbSB0aGVtPw0KPj4gSSBoYXZlIGxl
c3Mga25vd2xlZGdlIGFib3V0IGNvbXBhdGliaWxpdHkuDQo+IA0KPiBJZiB5b3UgbWFrZSBpdCBv
ZmYgYnkgZGVmYXVsdCwgeW91IGRvbid0IG5lZWQgb3RoZXJ3aXNlLCBpdCdzIG9uZQ0KPiByZWxl
YXNlIGJlZm9yZS4NCk9rLCB0aGFua3MuIEluIG5leHQgdmVyc2lvbiwgSSB3aWxsIGZvbGxvdyB0
aGUgcmVzdWx0IG9mIGRpc2N1c3Npb24gYW5kIHJlbW92ZSAieCIsIHdoaWxlIGFkZGluZyBzb21l
IGNvbW1lbnRzIGluIGNvZGVzLg0KDQo+IA0KPiBUaGFua3MNCj4gDQo+Pg0KPj4+DQo+Pg0KPj4g
LS0NCj4+IEJlc3QgcmVnYXJkcywNCj4+IEppcWlhbiBDaGVuLg0KPiANCg0KLS0gDQpCZXN0IHJl
Z2FyZHMsDQpKaXFpYW4gQ2hlbi4NCg==

