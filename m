Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3931C4345F
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2024 06:10:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rvA78-0002mu-7F; Fri, 12 Apr 2024 02:10:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Jiqian.Chen@amd.com>)
 id 1rvA76-0002mV-On
 for qemu-devel@nongnu.org; Fri, 12 Apr 2024 02:10:16 -0400
Received: from mail-co1nam11on20600.outbound.protection.outlook.com
 ([2a01:111:f403:2416::600]
 helo=NAM11-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Jiqian.Chen@amd.com>)
 id 1rvA75-0001Zn-0u
 for qemu-devel@nongnu.org; Fri, 12 Apr 2024 02:10:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZRrL2innKLyvn56/HksGbe9yG8jaWtWNGPqvmuolbiZcvDCRYp2J2gYysRD1Lww0uWx4wUR3F/eDmJVsYPyqsjUMkc3FtaeBGM6CfRVoUFc1Jels7yPLgL/5L0VO366D8b5OUKY/ju0Su/rZOOCsSv3kDxEfNU731n/fQrFXkUAkgziaRky7EcoKjCT3P2Spqg24aD3pvL4e6aut1jll4SPAsLuHdpH4jqc9l63dw0XlYLUXbgh8HVGQAtA3Gs8N7ZLWZeuvzf7OWxfzCJBTJJZhInwjLshUOyCOE57jaOPUqoVO4VifSHsGITSTOT2qc1pn36u1ByEjCNo5/uyD4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TQY1HQOYac4l7CdVuZsbsznfB5UUKNsTArZk1AR5L94=;
 b=Li/CSovx++McoB1I9DE4OsJArInwUWrvYTN/EKjyBYw5uzkxtNRSg55Dd4TT1AAMB2hLvYhuia63t1SonjBuQElK7EL10b8pwHaQpGN2aa+g0tPI8p7b3oghyGE1tKq68AfB3vHg3ag2Y//DXRbprBYkN1m7L9Ldkb/pYpV2v2o4ZQEF57KfNXjbJ/MguM2mNKzuiwXUWS7QnnAGg/CbYy7dLSl7fDwtEgx/LmZM4RGLR3HX6emUNh01cOgUGS594gawd06u3XXI5UDlP+iSz0t0gR3G/Akzi3x3je3nWR9FfaFAJAqvEbeWEZCuzLbKmSFWJuyTvb+xm4h8o9mvOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TQY1HQOYac4l7CdVuZsbsznfB5UUKNsTArZk1AR5L94=;
 b=W2B7tmYS63McwPo7SXGgor6zb7lOWmle/bPYU1fGl4fnBMN/53ztAfaMRxH65PcQPqDAZBRgBeWGmuRrJKDC9LM6pCVlbBrkadwBadQoiJmnnEvmzh4jNGAXWVVWH5UHwbLAeKj+IUy4DpDnrIn1ZC1+hVrXUjuSimw9OMfYaoA=
Received: from BL1PR12MB5849.namprd12.prod.outlook.com (2603:10b6:208:384::18)
 by PH8PR12MB6914.namprd12.prod.outlook.com (2603:10b6:510:1cb::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Fri, 12 Apr
 2024 06:10:09 +0000
Received: from BL1PR12MB5849.namprd12.prod.outlook.com
 ([fe80::b77f:9333:3a5a:d285]) by BL1PR12MB5849.namprd12.prod.outlook.com
 ([fe80::b77f:9333:3a5a:d285%6]) with mapi id 15.20.7409.053; Fri, 12 Apr 2024
 06:10:09 +0000
From: "Chen, Jiqian" <Jiqian.Chen@amd.com>
To: Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
CC: "Chen, Jiqian" <Jiqian.Chen@amd.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "Huang, Ray" <Ray.Huang@amd.com>
Subject: Re: [RFC QEMU PATCH v8 2/2] virtio-pci: implement No_Soft_Reset bit
Thread-Topic: [RFC QEMU PATCH v8 2/2] virtio-pci: implement No_Soft_Reset bit
Thread-Index: AQHagPw4nwt3E6Dxr0GcatBwmH6cBbFM+5kAgACHiID//5QEAIABse2A//+IQICAADj0gIAGTJQAgAdcY4CAAI4zAIABHuUAgAbipYA=
Date: Fri, 12 Apr 2024 06:10:09 +0000
Message-ID: <BL1PR12MB5849DCAB96600C27C2BDC35BE7042@BL1PR12MB5849.namprd12.prod.outlook.com>
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
 <CACGkMEuzcVRfLY+axEP3QXb9TwYq_c=jLZRB5++EwyGWLv0YcQ@mail.gmail.com>
In-Reply-To: <CACGkMEuzcVRfLY+axEP3QXb9TwYq_c=jLZRB5++EwyGWLv0YcQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-imapappendstamp: IA1PR12MB7662.namprd12.prod.outlook.com
 (15.20.7472.008)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5849:EE_|PH8PR12MB6914:EE_
x-ms-office365-filtering-correlation-id: 92a5c4e6-3f46-4b6b-8ce6-08dc5ab7352e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TA5UPoqSo48m2GyRpir1IC28gzsFexJOFMsqJWySiLThi7UOOV7bQtpPa7i43L2iK6sAGnaqnuZC/15rid1UwqLpLO+ttE/ANGbkMB/FOVwRMaeLbbF2E7hEZIcZafAIBFRA/smk1c3rz96ONhaPGwGIe6WEIrGH5JgQFBvKYVdTpF8dPR4oRCtp3o0DyTcfO01dAsClWOBAs7nQkh/ITjr8c0F/6/w8HuJomPRpx6qolPF9p8ixWADAznhI2XGktWB0j6AuvM84xo4gm9cFcm+v+5TUkoMArQI9n5MHDgp2lVJAL9H6XAI9B17NNj88VqU08NhVSjTszkI/ZNDKZUBAKSCNpUZ0R+4DP6WO7L73OgzM2Gbo6xuPD5Glz/JrFrYhNPVuz3YXq2lNVL1AkJ9kA7xgPOTfVSxC2DFEhaT6fhCW1WUb2wSfdwWM+qDXIm4j3qewvxQ4msqZn9jL+Eh/bPW9gJemcMzF3EuwYdiTD6A7XmtlW+nKzXBVjMRmBPIpltZ2PqXTJ5dzKNjo3mb65/aOqW8xmnoqcuSv2Up2pXXrgAoFi3U7givMpUBYQ1K+gR+0i75XbaWpX5cZZFDQpq71zdNzQ/AHPficgeDaQN8+Ldkn/fG5rpwkTSzisnrLT19mwNAIvDyXUOs9TrgeMF1QO9HmGLG0eamuGBn7bp8So3/THDWktqA9TCToyVo1tM8rSC30rOq3GAwngg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5849.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(366007)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RlI5Y3luN2lXTlRraXNMQ1VWRS9qZkIrRXk3TzNnTDM3MTFJUlIrYlZEM3F5?=
 =?utf-8?B?UjlRTDRaeGZwaWltU3YrUFNvKzJ4bm82WFZLaS9XS0RpVXlEeWk2dUhpSVhN?=
 =?utf-8?B?R05MbjB5QTN6cmdvQmVWcG1kUEtLMTQwUmVjM3Y3Rm0xQnUxUmZNemppdTVv?=
 =?utf-8?B?ZVd5MDhoSHJDTU9admxFR1JWLzJZN0d1M0RGWUJldDdUWU40NTlsckwwN003?=
 =?utf-8?B?MmJnNURIcitlUFNOcjJlZDFXL21lbVNPVmtLeDBmQjlMTit5UXpxazlpMTlG?=
 =?utf-8?B?cWhqYTF6c3VLMkc0VHlFSnNNZ2Y4Zm5kZjdiV3ovd0UzZWZid2Vqd0lSVWtG?=
 =?utf-8?B?WEpGZnhnc1BVVVNqZ2VmM1UwbGNKbzdRN0t4TVdoQUlhcnREWEtteUo3TmVz?=
 =?utf-8?B?UzVxZW1Gb0hMSW95SFRLalplL2RzdzkyMjJTOUthWUFnVmlJK2J0bmVUSTN5?=
 =?utf-8?B?aG9rUlV6TEZBWmttTkFxRGt1QWhVMTJ5VThlcitwUTMwakdObW9XdTVkbVhQ?=
 =?utf-8?B?OWdZVmE0YWVSLzBTd3RvdzE5SE9pcUxORGFGcnpuaHZNVVZ2dEczL0QzYUZV?=
 =?utf-8?B?cEFlL0o1dTJUQ3RFU2p6enhxMGhiakdJaXNUQXNaVDlTNkNUWWhHa0p4ZWpI?=
 =?utf-8?B?YU9qN2UxSGJHVTh3cHRQbnJlYmxEQXhJTUhFVWpUNncwQ2w2Z1BVYmxtZTYy?=
 =?utf-8?B?OWx2RTAvMFAvY201Rzg3dS81c0U2ZDhpVUQrOUlQNm1zYTd2R1NHQjdCaWhO?=
 =?utf-8?B?bnVobGo5UWZMRG50SVlDTVh5U0pXeFYvRC9IN3NaM2NSaXE3bmtaR1JHRFpS?=
 =?utf-8?B?UTZVVnRDQ3d5dWdwSVF2Y3F4ZmxneDBYMVBKOW0rSkt3Vmc2bEpwSXBNc2JZ?=
 =?utf-8?B?a2pIdHlMYk1CSVR3M1AxOWVyOFczR3J3WFZhUkRUaEJMaUxHWjRIRjdOYzVQ?=
 =?utf-8?B?T3NjUTI2eENWc3dKTmZqTkR2TmxYS3ZzZWhKNzhra3RIdzQxUnpBQ3FPYjEr?=
 =?utf-8?B?aE43amVTWWwxM2w0c21YTzBuN3ljaTZKeHVVeXhKM0lGV05lRnZpQUYxcFB2?=
 =?utf-8?B?b2NsTWJxeTllbDlqbjNlM0ZpOWU4Q0tNL3dKQ3A1YXRDM2NqdGhQQjFlK2JG?=
 =?utf-8?B?dU0rbXNja3l3Ui85YkxyeUhhaEtRRDU3THVxWkdDdDY4aXlndzNnREhnOWlY?=
 =?utf-8?B?V2lPRnBHUnRNMmhpVTBrZDF2REZJcGJjczYyOWVkMHg0ZnRLREpKVFgwc3pQ?=
 =?utf-8?B?MGNwUGJnNmx6S3E4Rys0Smd2ZVcvUGRVT2diTjlPdEpXMDh5eVphRStoaDRr?=
 =?utf-8?B?cmV4THBMVURoUlhNVEVUQ1EwRXRRNEVFZHJUMU81TDgvQWFGS1FZZ0hhZFJs?=
 =?utf-8?B?YXZPQk1TdnhkbU1CZTIreWJWZW1oQWE4eFdIQTA5S2ZkK2dtaTJFMU1laVQx?=
 =?utf-8?B?VHZUS25DTnhiZ3FvK1o1dGxERnFiZCttSEdFZ01FbkhqZ3JRU2VFcE1aVi9L?=
 =?utf-8?B?ajEyNG5veDMzN2JQTU0ycmhhUkprWTBweU9iN0NYRkMydjYreVlMdkUvOVpG?=
 =?utf-8?B?bmxSRXNmUjdVS0hDWWFEdnNSTWNJWEp1NzNGMDUvSU16UTJTZE0yNnRoLzlL?=
 =?utf-8?B?b1RtKyszV2JCZTIvdHFoeEdsc0p2djM1N0VOZS9nMUNrL3RveXptWUMxMkxD?=
 =?utf-8?B?Y0N3dWRUeFBSZUY2QjFCbkVnb3VXZVFmWFEvVXhsdXVsV2dLUGhYZDdDNW5z?=
 =?utf-8?B?enNCYlREZ1dPZFFiK0ZGalZCRmFjQVJTcFNtTzkxMkZ1cXAxQkc2bVR0cDNH?=
 =?utf-8?B?dldSamRpQ0U0Vld2QkIwVG11ak94NkkzNDl5b3dGMkdWY1kwNjF1OXlOQkNX?=
 =?utf-8?B?bDB6N0V2bnR2eG1ITk00aXdzWHpoblFvQzVyRjZsTXlFb0w2YnFTTVlBL0xI?=
 =?utf-8?B?b3oveWVqbWxXNWVJZlUwMkw1amJhQU9KVWJLdHlIb0pxNW11NDBmbTc3dVdH?=
 =?utf-8?B?YWE4QUlDQ0l3SmNvWDV3eFAyZFZ2ZmtqeWNCZmtOYitxU0RrN3NpZGFWQXpo?=
 =?utf-8?B?a3A5UnltOEtqRVdkVkdQK0h6Zm9seXhaZDcxUEJqRkpNNERFMkNrQjMzVFk5?=
 =?utf-8?Q?ttE0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <865BA7DF04C09247983CC94BBFF15529@amdcloud.onmicrosoft.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92a5c4e6-3f46-4b6b-8ce6-08dc5ab7352e
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Apr 2024 06:10:09.6904 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4HUG65oA8fRTATxq3FE/jFlDErFFULBx/pS1WqPxrvKzRk7tyEdHn/R1BgBEov1Jba9qEBwXSRQncIhsu5j4ZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6914
Received-SPF: permerror client-ip=2a01:111:f403:2416::600;
 envelope-from=Jiqian.Chen@amd.com;
 helo=NAM11-CO1-obe.outbound.protection.outlook.com
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

T24gMjAyNC80LzggMTI6NTYsIEphc29uIFdhbmcgd3JvdGU6DQo+Pj4+IEkgd2lsbCBzZXQgdGhl
IGRlZmF1bHQgdmFsdWUgb2YgTm9fU29mdF9SZXNldCBiaXQgdG8gdHJ1ZSBpbiBuZXh0IHZlcnNp
b24gYWNjb3JkaW5nIHRvIHlvdXIgb3Bpbmlvbi4NCj4+Pj4gQWJvdXQgdGhlIGNvbXBhdGliaWxp
dHkgb2Ygb2xkIG1hY2hpbmUgdHlwZXMsIHdoaWNoIHR5cGVzIHNob3VsZCBJIGNvbnNpZGVyPyBE
b2VzIHRoZSBzYW1lIGFzIHgtcGNpZS1wbS1pbml0KGh3X2NvbXBhdF8yXzgpPw0KPj4+PiBGb3Jn
aXZlIG1lIGZvciBub3Qga25vd2luZyBtdWNoIGFib3V0IGNvbXBhdGliaWxpdHkuDQo+Pj4NCj4+
PiAieCIgbWVhbnMgbm8gY29tcGF0aWJpbGl0eSBhdCBhbGwsIHBsZWFzZSBkcm9wIHRoZSAieCIg
cHJlZml4LiBBbmQgaXQNCj4+PiBsb29rcyBtb3JlIHNhZmUgdG8gc3RhcnQgYXMgImZhbHNlIiBi
eSBkZWZhdWx0Lg0KPj4+DQo+Pj4gVGhhbmtzDQo+Pg0KPj4NCj4+IE5vdCBzdXJlIEkgYWdyZWUu
IEV4dGVybmFsIGZsYWdzIGFyZSBmb3Igd2hlbiB1c2VycyB3YW50IHRvIHR3ZWFrIHRoZW0uDQo+
PiBXaGVuIHdvdWxkIHVzZXJzIHdhbnQgaXQgdG8gYmUgb2ZmPw0KPiANCj4gSWYgSSB1bmRlcnN0
YW5kIHRoZSBzdXNwZW5kaW5nIHN0YXR1cyBwcm9wb3NhbCBjb3JyZWN0bHksIHRoZXJlIGFyZSBh
dA0KPiBsZWFzdCAxIGRldmljZSB0aGF0IGlzIG5vdCBzYWZlLiBBbmQgdGhpcyBzZXJpZXMgZG9l
cyBub3QgbWVudGlvbg0KPiB3aGljaCBkZXZpY2UgaXQgaGFzIHRlc3RlZC4NCkkgb25seSB0ZXN0
ZWQgdmlydGlvLWdwdSB3aXRoIG15IHBhdGNoLCBJIHdpbGwgbWVudGlvbiB0aGlzIGluICJjb21t
aXQgbWVzc2FnZSIgaW4gbmV4dCB2ZXJzaW9uLg0KDQo+IA0KPiBJdCBtZWFucyBpZiB3ZSBlbmFi
bGUgaXQgdW5jb25kaXRpb25hbGx5LCBndWVzdHMgbWF5IGJyZWFrLg0KTWFrZSBzZW5zZSwgd2ls
bCBrZWVwICIgTm9fU29mdF9SZXNldCBiaXQgIiBmYWxzZSBieSBkZWZhdWx0LiBBbmQgYWRkIHNv
bWUgY29tbWVudHMgaW4gdGhlIGNvZGVzIHRvIGRlc2NyaWJlIHdoYXQgeW91IGNvbnNpZGVyZWQu
DQoNCj4gDQo+IFRoYW5rcw0KPiANCj4+IFdoYXQgaXMgZG9uZSBoZXJlIGlzIEkgZmVlbCBzYW5l
LCBqdXN0IGFkZCBtYWNoaW5lIGNvbXBhdCBtYWNoaW5lcnkNCj4+IHRvIGNoYW5nZSB0byBvZmYg
Zm9yIG9sZCBtYWNoaW5lIHR5cGVzLg0KDQotLSANCkJlc3QgcmVnYXJkcywNCkppcWlhbiBDaGVu
Lg0K

