Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FBF9C6FD1F
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Mar 2024 08:01:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rq7AH-000276-Hw; Fri, 29 Mar 2024 04:00:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Jiqian.Chen@amd.com>)
 id 1rq7AE-00022i-Sw
 for qemu-devel@nongnu.org; Fri, 29 Mar 2024 04:00:39 -0400
Received: from mail-dm6nam11on20700.outbound.protection.outlook.com
 ([2a01:111:f403:2415::700]
 helo=NAM11-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Jiqian.Chen@amd.com>)
 id 1rq7AA-0000oa-8S
 for qemu-devel@nongnu.org; Fri, 29 Mar 2024 04:00:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hjlauQ5kiSpW4yeGDpwINsd6iaRghOvnUJfIQIbxteVbTZ9ErEOrnXzzhZUwNBAOul9QEbhKp5S455LnVLQL3R8rMHMpDCWPNU7AfTbAZ+cnpK83mshOqu4cDQOcUwkMi2afeRwP/RMm3Xh9yT6KRnh+ptUv0QryghpilXHYXsGeXVA43VftSZb6n4nYzxOqvl3QxtlIRteL4g0ie3381eVtVWcZS1KPITQxGTvcER8uUrlr5r2DuCHwGx3HUqvJqFDic6NSoUZGda8CSSV+Hu++1L2skBoxDRQXOkggefjRA/eLRq29i0amtgsLih6O+POx8sPThHnYkr4TnxB9Kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f8Pt1sdCPxo3WuQJodhIPPsophEb3pxnyLsKH5xdxfo=;
 b=MUP+zcpAFkTgjuu3sEVrTxZojwjzcQSqjGBbbNsPF8Qg2Rkyqv37cxAYrM9QIC7ipzxh/vqINMNsaSMDvzV4L0O90CdbjcUnUqe1fYXMTMgEntfVeUo337cC+k1vdLlXjDmhywzU1W5gTR+eDr0/Dy9oICIf2qUUmgUXshaYeM+nHqqPAwZoPsQmCUoo4R/J/vDmpCkZA5g6tQ42Eld5/oucWqb2TBZM+wYElpbBJTxRpj5JxEVc2kI+EmN9/WF/g21Lx/ZxQp6bSBqElRtJW0s8EsQSR+oXTUKCY7i5dEJIYdvsr6RKjuMbn2azME+EZV1jv6jaY5Rr+ktrt2ldFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f8Pt1sdCPxo3WuQJodhIPPsophEb3pxnyLsKH5xdxfo=;
 b=ycXdv+yFYIqIQAO7V9fWy7mLNA396UEsmulLU5yjR09dExI6tWGac1pqLyo7dyURtYe5JybKT1rhtjYAiSC5VO7/Rd89Ob59WQiLiLt4ZubUS4UpEnn7GJrYtHInC+aKiaGb/cTBDM8hgaYSyO7Kxf8hkqWPeslpm5O80iFrwD4=
Received: from BL1PR12MB5849.namprd12.prod.outlook.com (2603:10b6:208:384::18)
 by SJ2PR12MB8831.namprd12.prod.outlook.com (2603:10b6:a03:4d0::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.32; Fri, 29 Mar
 2024 08:00:28 +0000
Received: from BL1PR12MB5849.namprd12.prod.outlook.com
 ([fe80::debf:178c:f5df:5efa]) by BL1PR12MB5849.namprd12.prod.outlook.com
 ([fe80::debf:178c:f5df:5efa%6]) with mapi id 15.20.7409.031; Fri, 29 Mar 2024
 08:00:27 +0000
From: "Chen, Jiqian" <Jiqian.Chen@amd.com>
To: Jason Wang <jasowang@redhat.com>
CC: "Michael S. Tsirkin" <mst@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "Huang, Ray" <Ray.Huang@amd.com>, "Chen, Jiqian"
 <Jiqian.Chen@amd.com>
Subject: Re: [RFC QEMU PATCH v8 2/2] virtio-pci: implement No_Soft_Reset bit
Thread-Topic: [RFC QEMU PATCH v8 2/2] virtio-pci: implement No_Soft_Reset bit
Thread-Index: AQHagPw4nwt3E6Dxr0GcatBwmH6cBbFM+5kAgACHiID//5QEAIABse2A//+IQICAAIqjgA==
Date: Fri, 29 Mar 2024 08:00:27 +0000
Message-ID: <BL1PR12MB5849A4AECE81D37684B88129E73A2@BL1PR12MB5849.namprd12.prod.outlook.com>
References: <20240328103903.408290-1-Jiqian.Chen@amd.com>
 <20240328103903.408290-3-Jiqian.Chen@amd.com>
 <20240328065606-mutt-send-email-mst@kernel.org>
 <BL1PR12MB5849ACCD6602EAB88BE2FED9E73B2@BL1PR12MB5849.namprd12.prod.outlook.com>
 <20240328083503-mutt-send-email-mst@kernel.org>
 <BL1PR12MB5849C37A0B0E1AF02644C203E73A2@BL1PR12MB5849.namprd12.prod.outlook.com>
 <CACGkMEt=V4V4JgT08o5_f7tj-eNZDi2GB4=H_Qp7xALrRxBWhQ@mail.gmail.com>
In-Reply-To: <CACGkMEt=V4V4JgT08o5_f7tj-eNZDi2GB4=H_Qp7xALrRxBWhQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-imapappendstamp: IA1PR12MB8333.namprd12.prod.outlook.com
 (15.20.7292.000)
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5849:EE_|SJ2PR12MB8831:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: A4IdqVmTF79/GjkjFqSO0u0e5HOGv3AAgfzd4LZIhGUR7yH8viRxRKnyFf7iGnnp/i9OAM17cdjbHe3U7htorrmUNco7iF4XKrPQB1ytnHjAGM/NiWAoRvwGCq9HYnQVdIRv9KRr2z00oWCVATj+PBj9kf2VAvcqahVOATXLHXlhEOU/Eunsbj1TlMYPKOvXjhkjzg4O0KlmaE2F76Lnog5pIsWjEPsK3d9RIAsUipYh08J6xlLTTwt9hMKGoqZtrj8gh9NYQbK2jiYUgQG096TVkjZOTpdNEG/OQA3WWgl0u8Ugrvm+d5Dp2lUOCCH31Gf182dvU+afv+0uT7mcqfeGGWlnYZunSPt/I8Ses8sQj1XIoWnwx3Vox9+Bkf36Mp5phZQ6zeLjF72hFR3JEIiYL87Z8FRm/R2BES8a3B5mN5L3zY9ilnlfQjlyq2jrKFvNd5ith6eonFX6hyJzKmKmTuDrFy/wQHwN9p/FowLshPoRlE1uPsEKMUckOMFULE+gxW1INt+P8MO3zHlOYNGixk/ghabQ1Me33qFBlS15AQdh5K56Osk3Mz8WkxkU9TRZ8dFXQckP81BTV6Sijq3MrxQp2rlwfvpaP8doCVGYT5KlQupbhtcMhv5v49WnLj6RV4nGSl8cTTVdY6WbB7TN8MQzguhzgpoylFkZfb4=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5849.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(366007); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MWswL20wOFVsVkZ3MTBUdHhmcFptRVNKejB4anFBQU05R2FYUWtMSGFSZXVn?=
 =?utf-8?B?SWgrc0lKdTZ2S1NZb2hpOCs4bXVTVFlKSlJoellueHlrRmxBRnZZYnpMc3c1?=
 =?utf-8?B?L3ZtVHJ4MG80blk4aWIraXhyVk95SVhIeTRBMFpZTWlmRzJQZDFJOEluZ1hS?=
 =?utf-8?B?eUpOWGlQbEE4bm93Ukk2UHdIS1ZKRytGUWJmbm5vZXYxU0l5MTlRZE1XbWhL?=
 =?utf-8?B?a2hUNTdnMWRndldoYkNYZ2FkVDVqaExTNjM3eXZzeVFBZ09FUXA2c1ZvdThF?=
 =?utf-8?B?bVIzYkpFaEUzdmFibzZsU2M1QzROVUVTUkxzdW1pdWVORXZUTjFJN3FoLzFJ?=
 =?utf-8?B?VklFNHJBOXFDS0xpWHpnVjNSTHRCQWlIbi83T25yQ3IxZDFTOHRBQWZkSVoy?=
 =?utf-8?B?bmFpeWZ1dVliMDV3OGt5QTZhWTRUN24vWnJXUG1DWTQ0R2o2K1N1T1FGUGly?=
 =?utf-8?B?eFhqdFlzbWVyaElPbXhHOEhrK0doOFFTNXV6RXFVQUNsZmZXY0kzZHhNS0sx?=
 =?utf-8?B?VE56QkM5UEcwQ055bEd3YzhJQ3RRUDhwa3NudEZ0ZXRsbnZqUDk5TWR2TVU1?=
 =?utf-8?B?dDduOWtySDQvcWZQQUZ6S0pTNzNubFhXQXRKRGY2TWtqazFGdVAwUUQrd2Iw?=
 =?utf-8?B?YUt0ejlZSmJXWmhiUjk5ZUh5QUV4bVV2U0xSOXdWZnl6QmtNcmJ3Qy83cnBl?=
 =?utf-8?B?NTlhOXZsR0hreDVmZjJMRWtBODEvcHQ4QnJLczVUTlp3UC9QSUR4WmVXYTlq?=
 =?utf-8?B?WERPczFQZFdDWWpkYkkyWjhTMXJ6eitTS1RGUTNQTUxadWpkKzJnc3BFWGR6?=
 =?utf-8?B?ZTNna1dodFZ5QUZHeDlEUWRZUHc0YkxNbDFGN3U1cHNZQ2pGbDJSRUxBRHlQ?=
 =?utf-8?B?QzcxRlA0aUdUNmJId1d1UUYrYUdJWkJ2cEhFTVRGbC9YblZYMHgrY1I4d2Q4?=
 =?utf-8?B?dHF0Q2lBV0VjZklydklFTnAxbTRRbkRSOWZFSWFxUGxTVlJtMmxuOWZqclpp?=
 =?utf-8?B?TWg4c3U5TjFjVE1CVHdmZTZ3M2tFbFdXbDZDTFlNN1pLczBXYkVVZmV2Sm0v?=
 =?utf-8?B?YzR1Q2Q2dCtmUEdxZXJ3QXBrVnhpUFZNT1JuM3E5UHQyalBYOVo0ZlUxdUU2?=
 =?utf-8?B?eW1UM0hHR1NMZzh4LzJtOVVNZWgwaEFLK1llSmYzNW5hbGpiSGtaWGpWTTd6?=
 =?utf-8?B?OE5lOXlUbUlYUCtmTmNRbDJmdkV5UUpEUWJKcVJmaHpDcldyTU02OGhZMlQ2?=
 =?utf-8?B?dTBybDRUbHppS2tzZnZ1STVNcVRMQWdpNmk2OUtOem1nOSs3MmdpWXZLS1R0?=
 =?utf-8?B?R0Z1QS9OQmhyK3dtelJvNDNMbXBJaUp3RDFoVkx2R1FNNUdmakR0emdHekRX?=
 =?utf-8?B?ajlwVDlBVkl5NCtsY2tkWTNJZXQ3MS8vNXdxZGVYWThaSWFuTHlQUk5PNWNz?=
 =?utf-8?B?cjhYcnhieThxVkE0YnVUMWFEWHdvNVdzLy9WNkJJdnNxSUpFNmxnQjZOU25w?=
 =?utf-8?B?ZkZNRFdTL1RsTXFIOFJOY2lSWDlBRkhWNkYxeWp0elhWOFJBNGdhNElBTEo3?=
 =?utf-8?B?dVE4bmxsSUFXT2xodmZoeXdUSEsrSEtXQ2w4SHZsb1l4aTlBNnd3dm5GMDhz?=
 =?utf-8?B?b3VPRDRTTlA0eGR4VGdpVWd6c211TmswRXd4MjBrN1BEeVNwT0djNXVKSEFh?=
 =?utf-8?B?WGNJR0tvQU5uV2tIUlVZN0w0dk5XTjdUb2N5UW1EWEtKOFNGOFJhSjIrOER5?=
 =?utf-8?B?YlZRSDFzSXlVZ0kyZHBVVzIzVTJOOFFLVnFWT1piZmRCTGtsSmZKSlZRNnlC?=
 =?utf-8?B?U3ZXd2x5aTJPcUZ0NmJBVE1GcVQvMkRLMURlZURrbWJGajVlOC9UNHp5TVEv?=
 =?utf-8?B?WDB0Q0ZBQVp1ZWgrQW14YXltSlpmLzVpM0pFME1sTjl1M21Ca3N2Rm9rWk1s?=
 =?utf-8?B?ZEE0TjlEMFRCWE83WU9MLzhIMW0vSHpDbUVMMnBBYXY5ck9ERjFJWjdEaWlj?=
 =?utf-8?B?OXorNEp4VWVqSDlUZ3ZlZjR2ZUNSQThHNGEzUi9tTXRrMGNzekdncE5XQSs5?=
 =?utf-8?B?RG9kZlpIcWt2QWRNNjRncEl2RVkvQW8wSk5NdGpFcXI0SFZMM3hUUFg3eEhi?=
 =?utf-8?Q?vu1s=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5B7E8C4EE67BB14F8DC1A71921E16B3D@amdcloud.onmicrosoft.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2751b20-2b25-4ac9-2c41-08dc4fc64bc4
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Mar 2024 08:00:27.2886 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LUgQXWtaWp+QckDXjRqnwfiKRaYm5ZYyWSrINK6Ib0gAzHc8IPrX3nK/iy16rwxyElNTA2W9AD8O9O0tE1PW0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8831
Received-SPF: permerror client-ip=2a01:111:f403:2415::700;
 envelope-from=Jiqian.Chen@amd.com;
 helo=NAM11-DM6-obe.outbound.protection.outlook.com
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

T24gMjAyNC8zLzI5IDE1OjIwLCBKYXNvbiBXYW5nIHdyb3RlOg0KPiBPbiBGcmksIE1hciAyOSwg
MjAyNCBhdCAzOjA34oCvUE0gQ2hlbiwgSmlxaWFuIDxKaXFpYW4uQ2hlbkBhbWQuY29tPiB3cm90
ZToNCj4+DQo+PiBPbiAyMDI0LzMvMjggMjA6MzYsIE1pY2hhZWwgUy4gVHNpcmtpbiB3cm90ZToN
Cj4+Pj4+PiArfQ0KPj4+Pj4+ICsNCj4+Pj4+PiAgc3RhdGljIHZvaWQgdmlydGlvX3BjaV9idXNf
cmVzZXRfaG9sZChPYmplY3QgKm9iaikNCj4+Pj4+PiAgew0KPj4+Pj4+ICAgICAgUENJRGV2aWNl
ICpkZXYgPSBQQ0lfREVWSUNFKG9iaik7DQo+Pj4+Pj4gICAgICBEZXZpY2VTdGF0ZSAqcWRldiA9
IERFVklDRShvYmopOw0KPj4+Pj4+DQo+Pj4+Pj4gKyAgICBpZiAodmlydGlvX3BjaV9ub19zb2Z0
X3Jlc2V0KGRldikpIHsNCj4+Pj4+PiArICAgICAgICByZXR1cm47DQo+Pj4+Pj4gKyAgICB9DQo+
Pj4+Pj4gKw0KPj4+Pj4+ICAgICAgdmlydGlvX3BjaV9yZXNldChxZGV2KTsNCj4+Pj4+Pg0KPj4+
Pj4+ICAgICAgaWYgKHBjaV9pc19leHByZXNzKGRldikpIHsNCj4+Pj4+PiBAQCAtMjQ4NCw2ICsy
NTExLDggQEAgc3RhdGljIFByb3BlcnR5IHZpcnRpb19wY2lfcHJvcGVydGllc1tdID0gew0KPj4+
Pj4+ICAgICAgICAgICAgICAgICAgICAgIFZJUlRJT19QQ0lfRkxBR19JTklUX0xOS0NUTF9CSVQs
IHRydWUpLA0KPj4+Pj4+ICAgICAgREVGSU5FX1BST1BfQklUKCJ4LXBjaWUtcG0taW5pdCIsIFZp
cnRJT1BDSVByb3h5LCBmbGFncywNCj4+Pj4+PiAgICAgICAgICAgICAgICAgICAgICBWSVJUSU9f
UENJX0ZMQUdfSU5JVF9QTV9CSVQsIHRydWUpLA0KPj4+Pj4+ICsgICAgREVGSU5FX1BST1BfQklU
KCJ4LXBjaWUtcG0tbm8tc29mdC1yZXNldCIsIFZpcnRJT1BDSVByb3h5LCBmbGFncywNCj4+Pj4+
PiArICAgICAgICAgICAgICAgICAgICBWSVJUSU9fUENJX0ZMQUdfUE1fTk9fU09GVF9SRVNFVF9C
SVQsIGZhbHNlKSwNCj4gDQo+IFdoeSBkb2VzIGl0IGNvbWUgd2l0aCBhbiB4IHByZWZpeD8NClNv
cnJ5LCBpdCdzIG15IG1pc3VuZGVyc3RhbmRpbmcgb2YgdGhpcyBwcmVmaXgsIGlmIE5vX1NvZnRf
UmVzZXQgZG9lc24ndCBuZWVkIHRoaXMgcHJlZml4LCBJIHdpbGwgZGVsZXRlIGl0IGluIG5leHQg
dmVyc2lvbi4NCkRvZXMgeCBwcmVmaXggbWVhbnMgY29tcGF0IG1hY2hpbmVyeT8gT3Igb3RoZXIg
bWVhbmluZ3M/DQoNCj4gDQo+Pj4+Pj4gICAgICBERUZJTkVfUFJPUF9CSVQoIngtcGNpZS1mbHIt
aW5pdCIsIFZpcnRJT1BDSVByb3h5LCBmbGFncywNCj4+Pj4+PiAgICAgICAgICAgICAgICAgICAg
ICBWSVJUSU9fUENJX0ZMQUdfSU5JVF9GTFJfQklULCB0cnVlKSwNCj4+Pj4+PiAgICAgIERFRklO
RV9QUk9QX0JJVCgiYWVyIiwgVmlydElPUENJUHJveHksIGZsYWdzLA0KPj4+Pj4NCj4+Pj4+IEkg
YW0gYSBiaXQgY29uZnVzZWQgYWJvdXQgdGhpcyBwYXJ0Lg0KPj4+Pj4gRG8geW91IHdhbnQgdG8g
bWFrZSB0aGlzIHNvZnR3YXJlIGNvbnRyb2xsYWJsZT8NCj4+Pj4gWWVzLCBiZWNhdXNlIGV2ZW4g
dGhlIHJlYWwgaGFyZHdhcmUsIHRoaXMgYml0IGlzIG5vdCBhbHdheXMgc2V0Lg0KPiANCj4gV2Ug
YXJlIHRhbGtpbmcgYWJvdXQgZW11bGF0ZWQgZGV2aWNlcyBoZXJlLg0KWWVzLCBJIGp1c3QgZ2F2
ZSBhbiBleGFtcGxlLiBJdCBhY3R1YWxseSB0aGlzIGJpdCBpcyBub3QgYWx3YXlzIHNldC4gV2hh
dCdzIHlvdXIgb3BpbmlvbiBhYm91dCB3aGVuIHRvIHNldCB0aGlzIGJpdCBvciB3aGljaCB2aXJ0
aW8tZGV2aWNlIHNob3VsZCBzZXQgdGhpcyBiaXQ/DQoNCj4gDQo+Pj4NCj4+PiBTbyB3aGljaCB2
aXJ0aW8gZGV2aWNlcyBzaG91bGQgYW5kIHdoaWNoIHNob3VsZCBub3Qgc2V0IHRoaXMgYml0Pw0K
Pj4gVGhpcyBkZXBlbmRzIG9uIHRoZSBzY2VuYXJpbyB0aGUgdmlydGlvLWRldmljZSBpcyB1c2Vk
LCBpZiB3ZSB3YW50IHRvIHRyaWdnZXIgYW4gaW50ZXJuYWwgc29mdCByZXNldCBmb3IgdGhlIHZp
cnRpby1kZXZpY2UgZHVyaW5nIFMzLCB0aGlzIGJpdCBzaG91bGRuJ3QgYmUgc2V0Lg0KPiANCj4g
SWYgdGhlIGRldmljZSBkb2Vzbid0IG5lZWQgcmVzZXQsIHdoeSBib3RoZXIgdGhlIGRyaXZlciBm
b3IgdGhpcz8NCkkgZG9uJ3Qga25vdyB3aGF0IHlvdSBtZWFuLg0KSWYgdGhlIGRldmljZSBkb2Vz
bid0IG5lZWQgcmVzZXQsIHdlIGNhbiBjb25maWcgdHJ1ZSB0byBzZXQgdGhpcyBiaXQsIHRoZW4g
b24gdGhlIGRyaXZlciBzaWRlLCBkcml2ZXIgZmluZHMgdGhpcyBiaXQgaXMgc2V0LCB0aGVuIGRy
aXZlciB3aWxsIG5vdCB0cmlnZ2VyIGEgc29mdCByZXNldC4NCg0KPiANCj4gQnR3LCBub19zb2Z0
X3Jlc2V0IGlzIGluc3VmZmljaWVudCBmb3Igc29tZSBjYXNlcywgDQpNYXkgSSBrbm93IHdoaWNo
IGNhc2VzPw0KDQo+IHRoZXJlJ3MgYSBwcm9wb3NhbCBmb3IgdGhlIHZpcnRpby1zcGVjLiBJIHRo
aW5rIHdlIG5lZWQgdG8gd2FpdCB1bnRpbCBpdCBpcyBkb25lLg0KQ2FuIHlvdSBzaGFyZSB0aGUg
cHJvcG9zYWw/DQoNCj4gDQo+PiBJbiBteSB1c2UgY2FzZSBvbiBteSBlbnZpcm9ubWVudCwgSSBk
b24ndCB3YW50IHRvIHJlc2V0IHZpcnRpby1ncHUgZHVyaW5nIFMzLA0KPj4gYmVjYXVzZSBvbmNl
IHRoZSBkaXNwbGF5IHJlc291cmNlcyBhcmUgZGVzdHJveWVkLCB0aGVyZSBhcmUgbm90IGVub3Vn
aCBpbmZvcm1hdGlvbiB0byByZS1jcmVhdGUgdGhlbSwgc28gdGhpcyBiaXQgc2hvdWxkIGJlIHNl
dC4NCj4+IE1ha2luZyB0aGlzIGJpdCBzb2Z0d2FyZSBjb250cm9sbGFibGUgaXMgY29udmVuaWVu
dCBmb3IgdXNlcnMgdG8gdGFrZSB0aGVpciBvd24gY2hvaWNlcy4NCj4gDQo+IFRoYW5rcw0KPiAN
Cj4+DQo+Pj4NCj4+Pj4+IE9yIHNob3VsZCB0aGlzIGJlIHNldCB0byB0cnVlIGJ5IGRlZmF1bHQg
YW5kIHRoZW4NCj4+Pj4+IGNoYW5nZWQgdG8gZmFsc2UgZm9yIG9sZCBtYWNoaW5lIHR5cGVzPw0K
Pj4+PiBIb3cgY2FuIEkgZG8gc28/DQo+Pj4+IERvIHlvdSBtZWFuIHNldCB0aGlzIHRvIHRydWUg
YnkgZGVmYXVsdCwgYW5kIGlmIG9sZCBtYWNoaW5lIHR5cGVzIGRvbid0IG5lZWQgdGhpcyBiaXQs
IHRoZXkgY2FuIHBhc3MgZmFsc2UgY29uZmlnIHRvIHFlbXUgd2hlbiBydW5uaW5nIHFlbXU/DQo+
Pj4NCj4+PiBObywgeW91IHdvdWxkIHVzZSBjb21wYXQgbWFjaGluZXJ5LiBTZWUgaG93IGlzIHgt
cGNpZS1mbHItaW5pdCBoYW5kbGVkLg0KPj4+DQo+Pj4NCj4+DQo+PiAtLQ0KPj4gQmVzdCByZWdh
cmRzLA0KPj4gSmlxaWFuIENoZW4uDQo+IA0KDQotLSANCkJlc3QgcmVnYXJkcywNCkppcWlhbiBD
aGVuLg0K

