Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1731C4345F
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2024 06:05:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rvA1H-0000zH-NU; Fri, 12 Apr 2024 02:04:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Jiqian.Chen@amd.com>)
 id 1rvA1F-0000yu-M5
 for qemu-devel@nongnu.org; Fri, 12 Apr 2024 02:04:13 -0400
Received: from mail-co1nam11on2047.outbound.protection.outlook.com
 ([40.107.220.47] helo=NAM11-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Jiqian.Chen@amd.com>)
 id 1rvA1C-0000AT-SE
 for qemu-devel@nongnu.org; Fri, 12 Apr 2024 02:04:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Khepx59Y75J8MVdwGar3ulDvdgjTTX19kZMS9bgBFi8IxgEm+Dg3LfcMxtsOjPw47U/hxif3WMIYQdy1QczcOoSA2cIDyrxDf563l31h7Hg26H2sZESGl8zeW2ssrrAiwao0/GBFAmGtQRqZemi9zXJFYhJ8/lejODHiq9cBpasvt0bSJBclk4N2Vds53yvcwfDnZfaQGaiX93x7IUPMUY5v/6FP046ItiRBCqMziYHd0ETy3FphQP+lmtLMcJPgOldFsHXkhgtl7CnLQTCVozgzBNU+zu3sUAGQMWzIPSLWFHu+sOZK37RVCK6asLasTATdfL/Hy6n4acS3UbS3Bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VNZ1HN3me6sDQTCbA3HzaKefa9L9Dbg3Lcrcq93LO1c=;
 b=HuCs0cNVVXm5FtVKA2KA02CDbYaWEO3VaIagkCGVDxgn4PQ0kMCPQDeRupYKhjgXpM3ggLqrU3ckePIVsVKDBKD/bBNMIxEqNAUvoVkbPaHTXCSYdiH2FwDN8O5yI0ARxVS+a2Lp4tuksMI8ceMBWSb84h5wkpvmBrqtbMVBAHjvu6KVfhkO48othIerwTeO2BNCtIlu3sVOWyUXzwW0yus40/0QNe5AvWltGt67mKxbk3iC+FTazRc2C19d9nOtNisWzKfn0xJDcjZuVGdhW2h7JUaqnKZkbdVglTIsq3hjPasA86LP7buwTGC++1mXh4l7TmjfT0pyN8zLlr48tQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VNZ1HN3me6sDQTCbA3HzaKefa9L9Dbg3Lcrcq93LO1c=;
 b=KZmCzzMgkYxPN/F+uu1tdUQqlVNLhV2yyKrwpfvlP1hntveUtfub3MyWz/42nQkWpjJK+3t/ZWYLh29+fzqCaJaUGk/W5DK1bB5QtDsIUQ5mylTX830c2uNsvOkZCp+0HboJdVprWmQ7D4QMZyBP21D4RFiVLRseElKhBrqHh3o=
Received: from BL1PR12MB5849.namprd12.prod.outlook.com (2603:10b6:208:384::18)
 by DS0PR12MB8318.namprd12.prod.outlook.com (2603:10b6:8:f6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Fri, 12 Apr
 2024 05:59:03 +0000
Received: from BL1PR12MB5849.namprd12.prod.outlook.com
 ([fe80::b77f:9333:3a5a:d285]) by BL1PR12MB5849.namprd12.prod.outlook.com
 ([fe80::b77f:9333:3a5a:d285%6]) with mapi id 15.20.7409.053; Fri, 12 Apr 2024
 05:59:03 +0000
From: "Chen, Jiqian" <Jiqian.Chen@amd.com>
To: Jason Wang <jasowang@redhat.com>
CC: "Michael S. Tsirkin" <mst@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "Huang, Ray" <Ray.Huang@amd.com>, "Chen, Jiqian"
 <Jiqian.Chen@amd.com>
Subject: Re: [RFC QEMU PATCH v8 2/2] virtio-pci: implement No_Soft_Reset bit
Thread-Topic: [RFC QEMU PATCH v8 2/2] virtio-pci: implement No_Soft_Reset bit
Thread-Index: AQHagPw4nwt3E6Dxr0GcatBwmH6cBbFM+5kAgACHiID//5QEAIABse2A//+IQICAADj0gIAGTJQAgAdcY4CACIoRgA==
Date: Fri, 12 Apr 2024 05:59:02 +0000
Message-ID: <BL1PR12MB5849380AAAE41CD6A2405D09E7042@BL1PR12MB5849.namprd12.prod.outlook.com>
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
In-Reply-To: <CACGkMEu6uEF+4P3_3Q5tw4TNZ9dj3GwJh+h_BtWDfq3WeUhKJQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-imapappendstamp: BL1PR12MB5947.namprd12.prod.outlook.com
 (15.20.7472.008)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5849:EE_|DS0PR12MB8318:EE_
x-ms-office365-filtering-correlation-id: 7c18f164-4b6b-4da6-8844-08dc5ab5a7c5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WHzm5D/MvyY4euOguxKIrmosKZEV0l+aWPlkWZ6A/ldb429kQ0tYRZ/kw7SjVDytZ9BwRNnRC4eqwcig0p7Cff+OJ8pyUO9IvvIh8lwWmMg3lUPEHxlOlL34UVfJAVxb58dYkASKO7fNxLMCiSoGNnhKqqkdESF7S5/XerKcTklIAoFBR2yIFCE5flLm6NOVtBGtI290ZOI5fIRTvvQsCq7FFjwlUT+ZAwt49mXtg82e16ZJdjY1o44rtGA731JPRD3jBZT30Vi/hHT2HOTjxRjDm5tCa9rWWkaC3V7Xunbq/Ijixkoctevc8FcQOAjVjoDwZ7i2ijboHlFfGF20T0s7l+Kiqy0r9cKGocQnmLOHq0tnE4nM3lyNnNa8GNhWv70LLnJHJOjLOyoNoaZeCx5fXGy4eU1pR/zl6orn4yhOhBdNsd1AtvSVRiTa+VGlxJQuTOTqkyPQFacDXfzHQijVyxiYjs54lBLMRacGmQpZZKgrlvNFSnnO2kRoqsLkWHLdEgVcieZNazXX8Ag2KE531F8W19CWhpld8AaaOMtc+Y1CKnclAsPFJ4x6Lt6DPTYsCGPRVzePQ0EGGc12NE+zYKlNZG3rx+MqZj/uwXz8Yl1783rNLDggrVlpjZaAfI1vXyCOT/qASLvhEad239wJ2NI1+ATj0yDay3OfS8Hmxu+tiPUUBNtdNyAqUmV8wo/ilCORoC0ilEu7yfWPM232uEsbVHGlhSF8g7xxlwY=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5849.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(366007)(1800799015)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?a08rRnJ6VjlKbDcwakRsc1c3V21HWnNCMzF3bTQwa1J5SzJycGZmdUwvc09Y?=
 =?utf-8?B?eGx3ejRhWi90WUpQaEM4eTJ0MTNuUmFBNlpsWWNINERuUGNlWXErekp6WXBK?=
 =?utf-8?B?VGZ0Yk8rQ1JVaEtFWisxZXJnVitTNW5aak1BYVNkL1h4aitMOGlaTHU3SjFi?=
 =?utf-8?B?RU5nU00vVTgybDREVVRBVEQ2ek1DR2JxUXF0T2NZV3hLYit2ZlkvdVRBN1p3?=
 =?utf-8?B?c3ZoalNyT1VMV0NRbVFpRWZISi9OVHFSTmtGY3NkcFMvbjd3SjRYRForTWJs?=
 =?utf-8?B?SzBHSjJZS2dXSGNRT3JqVWpjRDhJL3NHZ2xpeUhQQWNsY2FiSW5CdkpBRHJX?=
 =?utf-8?B?ZlYxTy9OL0FTQW15Mk1NOWhQZ0todTdmeGw2ejhPSjVJL3pSdlpETi9DQ0h4?=
 =?utf-8?B?S1FNWXByU2NZMm1CcWhrWXB6Sk9HRFJNUlVsTXA3S2VvWmpOVWFDYWRWZE1C?=
 =?utf-8?B?RXFQK3E5bkcxbythbjE1a0Rrai9oSWdDZlpINXdiajlMajBDT3gwQ0dOaHZ3?=
 =?utf-8?B?bUZRbjBHaGlLbWp6QkNYeEVyMTV6NzJrc0dQbU9tNUNrMDBzRHJsKzlpNlNn?=
 =?utf-8?B?cWRwU3FFSTJJOXdvcmtHQ3RkY3J2YlRTYlJtQ1pJWTVoaFQ3dEtsVFEwL0Z4?=
 =?utf-8?B?L0RITmJPM0d0L1l0MUpvZHZvR3NGVzBQWmRIZ0Z3cEU3bzBaYmo3WFRIWUlL?=
 =?utf-8?B?VncwZGxpZDA0cHdjWmVrd2hqUDd4U0dTRTlEcll6K1kzNm42ZkNqMU9sdU9M?=
 =?utf-8?B?SjFTU3hSRUdJUWxUWTBRRVJGRzdjdy8xT0ZCOXQ4NC9mZGJGN2NmNFBsMS9Q?=
 =?utf-8?B?MUZrc1lIWGdkSmJKY1ZiSTBtekRqY1d1WWlNei9vUllQV0d1TGRrWmlyTXVt?=
 =?utf-8?B?ZjM0aWQzTWFMd2pXbHIrZEZseGg5UDI5NU9NakhIbGhWSTFtTjBLOUhyMFVs?=
 =?utf-8?B?S3lDbkdzZjRtY05ZdnZrRWQyNkJ3QVdpRnNLeHJ5cHRzck10NCthSWRWUm9J?=
 =?utf-8?B?SGFuZ1VZODRuVHI5RitCeWRGcExQcFcyeFlzOHB0UGdmK2FmQkxGTXd1STVp?=
 =?utf-8?B?OXBHNTVqcElHUUdodzl0b1B4NldDY3NUQkZ2Vi9rNVNqYm1VcHpZNFR3MXl5?=
 =?utf-8?B?Sll6TGxVZUdlYkJuRW84K1hubW81a0xzUlpHcElycSt3cnluOVBRRUllWEQ4?=
 =?utf-8?B?MXhRK09JWnJ0Vm9ZakxFcXZyaGxWSXVLRG9aOGwxQXh3N0p4bWUvK3k3dVBz?=
 =?utf-8?B?NnBjY2NDQ2QwL1VYNk5yRCtLUjg2T3Z5dlUwM3dwMFRRL3k3cWZxS2RoSUxx?=
 =?utf-8?B?NVNrOHBvZUc5NDEwOXYxazVBaVhyQ2h6RDF1NWFVRmN6QjFFWkQ0T3QrUG4x?=
 =?utf-8?B?b2lOeDlHbzd1KytuOXhZOXFjeEF2Z2ZUbDNWTFFJRm8vWkgyZW1JUm1XRTVh?=
 =?utf-8?B?WFJkRFp3Q21lR2hpS1loOHJad3BaNTAwMlQ2V1Q3TnQzZjdYMkV6NmJ2aHBj?=
 =?utf-8?B?K0I5cElTL1F0N1AvTm0zSnlibUtlYjdjVzc0dUxPNnBzOGZSckQ1eHMzaFJp?=
 =?utf-8?B?bVFoUUxFMTRUUVlKcm51TEJkNWR2Nnp1c2lmaWRjKzJDWWhmSjErTGZHcjBh?=
 =?utf-8?B?cUw4TkxwUE9WTUpVT3pubDJJSzVZbFFGVndiUTRPbXc2dUxOMWhiREtvNk9T?=
 =?utf-8?B?cFlqTFd0aWlOT2RHN1RLci9IRC9CUVRuTDUxOXBudlh5SGJTTWF6aHNaVHlN?=
 =?utf-8?B?dkdFUnY2ek51NlhRdHNlS1ptdnZLdjg4eUlSV0VzOUE1U1NRWFlJSU5mWmF1?=
 =?utf-8?B?TmpZaHNSYncrODFtcWdRQ0lBTEtwSTZyYmp3d3AzbUJKMkwyUjF0VU13eGt3?=
 =?utf-8?B?NXJ6akQ5RUJrL1lPOWpPdUt2ZDFJTDJVVjVLTGpkb0pzQldLak5TZk55aTNG?=
 =?utf-8?B?dmhCS1dvTSsyT3U0ZFFhZzEraEcxQy9aRDNQeEIzWTYrVDdMZ2FhYnNTS1Zo?=
 =?utf-8?B?di9WQTJpa3NqeEUvQ3BYcktxOGxFN3pNUC82eGFlMmRnRTN5QjU0dXNYQjJx?=
 =?utf-8?B?TENCSWh0MU9PUFNjMjVzRzVQeDFFd2cyRkRHbmxqWXQ1ZjNFTFUvSGd6ek1U?=
 =?utf-8?Q?+o6w=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D451ACAE9E490741B0C4CC13C6FD335C@amdcloud.onmicrosoft.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c18f164-4b6b-4da6-8844-08dc5ab5a7c5
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Apr 2024 05:59:02.9877 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: h45oEZKXOASjgG5FtP7VHpnpPDhMB4T2e0kTiCUPbFz9cITQRr0hAuJmwGEGXHbqvTPfimy/aL7ThXzHecPrhQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8318
Received-SPF: permerror client-ip=40.107.220.47;
 envelope-from=Jiqian.Chen@amd.com;
 helo=NAM11-CO1-obe.outbound.protection.outlook.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.49,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

T24gMjAyNC80LzcgMTE6MjAsIEphc29uIFdhbmcgd3JvdGU6DQo+IE9uIFR1ZSwgQXByIDIsIDIw
MjQgYXQgMTE6MDPigK9BTSBDaGVuLCBKaXFpYW4gPEppcWlhbi5DaGVuQGFtZC5jb20+IHdyb3Rl
Og0KPj4NCj4+IE9uIDIwMjQvMy8yOSAxODo0NCwgTWljaGFlbCBTLiBUc2lya2luIHdyb3RlOg0K
Pj4+IE9uIEZyaSwgTWFyIDI5LCAyMDI0IGF0IDAzOjIwOjU5UE0gKzA4MDAsIEphc29uIFdhbmcg
d3JvdGU6DQo+Pj4+IE9uIEZyaSwgTWFyIDI5LCAyMDI0IGF0IDM6MDfigK9QTSBDaGVuLCBKaXFp
YW4gPEppcWlhbi5DaGVuQGFtZC5jb20+IHdyb3RlOg0KPj4+Pj4NCj4+Pj4+IE9uIDIwMjQvMy8y
OCAyMDozNiwgTWljaGFlbCBTLiBUc2lya2luIHdyb3RlOg0KPj4+Pj4+Pj4+ICt9DQo+Pj4+Pj4+
Pj4gKw0KPj4+Pj4+Pj4+ICBzdGF0aWMgdm9pZCB2aXJ0aW9fcGNpX2J1c19yZXNldF9ob2xkKE9i
amVjdCAqb2JqKQ0KPj4+Pj4+Pj4+ICB7DQo+Pj4+Pj4+Pj4gICAgICBQQ0lEZXZpY2UgKmRldiA9
IFBDSV9ERVZJQ0Uob2JqKTsNCj4+Pj4+Pj4+PiAgICAgIERldmljZVN0YXRlICpxZGV2ID0gREVW
SUNFKG9iaik7DQo+Pj4+Pj4+Pj4NCj4+Pj4+Pj4+PiArICAgIGlmICh2aXJ0aW9fcGNpX25vX3Nv
ZnRfcmVzZXQoZGV2KSkgew0KPj4+Pj4+Pj4+ICsgICAgICAgIHJldHVybjsNCj4+Pj4+Pj4+PiAr
ICAgIH0NCj4+Pj4+Pj4+PiArDQo+Pj4+Pj4+Pj4gICAgICB2aXJ0aW9fcGNpX3Jlc2V0KHFkZXYp
Ow0KPj4+Pj4+Pj4+DQo+Pj4+Pj4+Pj4gICAgICBpZiAocGNpX2lzX2V4cHJlc3MoZGV2KSkgew0K
Pj4+Pj4+Pj4+IEBAIC0yNDg0LDYgKzI1MTEsOCBAQCBzdGF0aWMgUHJvcGVydHkgdmlydGlvX3Bj
aV9wcm9wZXJ0aWVzW10gPSB7DQo+Pj4+Pj4+Pj4gICAgICAgICAgICAgICAgICAgICAgVklSVElP
X1BDSV9GTEFHX0lOSVRfTE5LQ1RMX0JJVCwgdHJ1ZSksDQo+Pj4+Pj4+Pj4gICAgICBERUZJTkVf
UFJPUF9CSVQoIngtcGNpZS1wbS1pbml0IiwgVmlydElPUENJUHJveHksIGZsYWdzLA0KPj4+Pj4+
Pj4+ICAgICAgICAgICAgICAgICAgICAgIFZJUlRJT19QQ0lfRkxBR19JTklUX1BNX0JJVCwgdHJ1
ZSksDQo+Pj4+Pj4+Pj4gKyAgICBERUZJTkVfUFJPUF9CSVQoIngtcGNpZS1wbS1uby1zb2Z0LXJl
c2V0IiwgVmlydElPUENJUHJveHksIGZsYWdzLA0KPj4+Pj4+Pj4+ICsgICAgICAgICAgICAgICAg
ICAgIFZJUlRJT19QQ0lfRkxBR19QTV9OT19TT0ZUX1JFU0VUX0JJVCwgZmFsc2UpLA0KPj4+Pg0K
Pj4+PiBXaHkgZG9lcyBpdCBjb21lIHdpdGggYW4geCBwcmVmaXg/DQo+Pj4+DQo+Pj4+Pj4+Pj4g
ICAgICBERUZJTkVfUFJPUF9CSVQoIngtcGNpZS1mbHItaW5pdCIsIFZpcnRJT1BDSVByb3h5LCBm
bGFncywNCj4+Pj4+Pj4+PiAgICAgICAgICAgICAgICAgICAgICBWSVJUSU9fUENJX0ZMQUdfSU5J
VF9GTFJfQklULCB0cnVlKSwNCj4+Pj4+Pj4+PiAgICAgIERFRklORV9QUk9QX0JJVCgiYWVyIiwg
VmlydElPUENJUHJveHksIGZsYWdzLA0KPj4+Pj4+Pj4NCj4+Pj4+Pj4+IEkgYW0gYSBiaXQgY29u
ZnVzZWQgYWJvdXQgdGhpcyBwYXJ0Lg0KPj4+Pj4+Pj4gRG8geW91IHdhbnQgdG8gbWFrZSB0aGlz
IHNvZnR3YXJlIGNvbnRyb2xsYWJsZT8NCj4+Pj4+Pj4gWWVzLCBiZWNhdXNlIGV2ZW4gdGhlIHJl
YWwgaGFyZHdhcmUsIHRoaXMgYml0IGlzIG5vdCBhbHdheXMgc2V0Lg0KPj4+Pg0KPj4+PiBXZSBh
cmUgdGFsa2luZyBhYm91dCBlbXVsYXRlZCBkZXZpY2VzIGhlcmUuDQo+Pj4+DQo+Pj4+Pj4NCj4+
Pj4+PiBTbyB3aGljaCB2aXJ0aW8gZGV2aWNlcyBzaG91bGQgYW5kIHdoaWNoIHNob3VsZCBub3Qg
c2V0IHRoaXMgYml0Pw0KPj4+Pj4gVGhpcyBkZXBlbmRzIG9uIHRoZSBzY2VuYXJpbyB0aGUgdmly
dGlvLWRldmljZSBpcyB1c2VkLCBpZiB3ZSB3YW50IHRvIHRyaWdnZXIgYW4gaW50ZXJuYWwgc29m
dCByZXNldCBmb3IgdGhlIHZpcnRpby1kZXZpY2UgZHVyaW5nIFMzLCB0aGlzIGJpdCBzaG91bGRu
J3QgYmUgc2V0Lg0KPj4+Pg0KPj4+PiBJZiB0aGUgZGV2aWNlIGRvZXNuJ3QgbmVlZCByZXNldCwg
d2h5IGJvdGhlciB0aGUgZHJpdmVyIGZvciB0aGlzPw0KPj4+Pg0KPj4+PiBCdHcsIG5vX3NvZnRf
cmVzZXQgaXMgaW5zdWZmaWNpZW50IGZvciBzb21lIGNhc2VzLCB0aGVyZSdzIGEgcHJvcG9zYWwN
Cj4+Pj4gZm9yIHRoZSB2aXJ0aW8tc3BlYy4gSSB0aGluayB3ZSBuZWVkIHRvIHdhaXQgdW50aWwg
aXQgaXMgZG9uZS4NCj4+Pg0KPj4+IFRoYXQgc2VlbXMgb3J0aG9nb25hbCBvciBkaWQgSSBtaXNz
IHNvbWV0aGluZz8NCj4+IFllcywgSSBsb29rZWQgdGhlIGRldGFpbCBvZiB0aGUgcHJvcG9zYWws
IEkgYWxzbyB0aGluayB0aGV5IGFyZSB1bnJlbGF0ZWQuDQo+IA0KPiBUaGUgcG9pbnQgaXMgdGhl
IHByb3Bvc2FsIHNhaWQNCj4gDQo+ICIiIg0KPiBXaXRob3V0IGEgbWVjaGFuaXNtIHRvDQo+IHN1
c3BlbmQvcmVzdW1lIHZpcnRpbyBkZXZpY2VzIHdoZW4gdGhlIGRyaXZlciBpcyBzdXNwZW5kZWQv
cmVzdW1lZCBpbg0KPiB0aGUgZWFybHkgcGhhc2Ugb2Ygc3VzcGVuZC9sYXRlIHBoYXNlIG9mIHJl
c3VtZSwgdGhlcmUgaXMgYSB3aW5kb3cgd2hlcmUNCj4gaW50ZXJydXB0cyBjYW4gYmUgbG9zdC4N
Cj4gIiIiDQo+IA0KPiBJdCBsb29rcyBzYWZlIHRvIGVuYWJsZSBpdCB3aXRoIHRoZSBzdXNwZW5k
IGJpdC4gT3IgaWYgeW91IHRoaW5rIGl0J3MNCj4gd3JvbmcsIHBsZWFzZSBjb21tZW50IG9uIHRo
ZSB2aXJ0aW8gc3BlYyBwYXRjaC4NCklmIEkgdW5kZXJzdGFuZCB0aGUgcHJvcG9zYWwgY29ycmVj
dGx5Lg0KT25seSBuZWVkIHRvIGNoZWNrIHRoZSBTVVNQRU5EIGJpdCB3aGVuIHZpcnRpb19wY2lf
YnVzX3Jlc2V0X2hvbGQgaXMgY2FsbGVkLg0KSXQgc2VlbXMgdGhlIHByb3Bvc2FsIHdvbid0IGJs
b2NrIHRoaXMgcGF0Y2ggdG8gdXBzdHJlYW0uDQpJbiBuZXh0IHZlcnNpb24sIEkgd2lsbCBhZGQg
Y29tbWVudHMgdG8gbm90ZSB0aGUgU1VTUEVORCBiaXQgdGhhdCBuZWVkIHRvIGJlIGNvbnNpZGVy
ZWQgb25jZSBpdCBpcyBhY2NlcHRlZC4NCg0KPiANCj4+IEkgd2lsbCBzZXQgdGhlIGRlZmF1bHQg
dmFsdWUgb2YgTm9fU29mdF9SZXNldCBiaXQgdG8gdHJ1ZSBpbiBuZXh0IHZlcnNpb24gYWNjb3Jk
aW5nIHRvIHlvdXIgb3Bpbmlvbi4NCj4+IEFib3V0IHRoZSBjb21wYXRpYmlsaXR5IG9mIG9sZCBt
YWNoaW5lIHR5cGVzLCB3aGljaCB0eXBlcyBzaG91bGQgSSBjb25zaWRlcj8gRG9lcyB0aGUgc2Ft
ZSBhcyB4LXBjaWUtcG0taW5pdChod19jb21wYXRfMl84KT8NCj4+IEZvcmdpdmUgbWUgZm9yIG5v
dCBrbm93aW5nIG11Y2ggYWJvdXQgY29tcGF0aWJpbGl0eS4NCj4gDQo+ICJ4IiBtZWFucyBubyBj
b21wYXRpYmlsaXR5IGF0IGFsbCwgcGxlYXNlIGRyb3AgdGhlICJ4IiBwcmVmaXguIEFuZCBpdA0K
VGhhbmtzIHRvIGV4cGxhaW4uDQpTbyBpdCBzZWVtcyB0aGUgcHJlZml4ICJ4IiBvZiAieC1wY2ll
LXBtLWluaXQiIGlzIGFsc28gd3Jvbmc/IEJlY2F1c2UgaXQgY29uc2lkZXJlZCB0aGUgaHdfY29t
cGF0XzJfOC4gQWxzbyAieC1wY2llLWZsci1pbml0Ii4NCkJhY2sgdG8gTm9fU29mdF9SZXNldCwg
ZG8geW91IGtub3cgd2hpY2ggb2xkIG1hY2hpbmVzIHNob3VsZCBJIGNvbnNpZGVyIHRvIGNvbXBh
dGlibGUgd2l0aD8NCg0KPiBsb29rcyBtb3JlIHNhZmUgdG8gc3RhcnQgYXMgImZhbHNlIiBieSBk
ZWZhdWx0Lg0KPiANCj4gVGhhbmtzDQo+IA0KPj4+DQo+Pj4+PiBJbiBteSB1c2UgY2FzZSBvbiBt
eSBlbnZpcm9ubWVudCwgSSBkb24ndCB3YW50IHRvIHJlc2V0IHZpcnRpby1ncHUgZHVyaW5nIFMz
LA0KPj4+Pj4gYmVjYXVzZSBvbmNlIHRoZSBkaXNwbGF5IHJlc291cmNlcyBhcmUgZGVzdHJveWVk
LCB0aGVyZSBhcmUgbm90IGVub3VnaCBpbmZvcm1hdGlvbiB0byByZS1jcmVhdGUgdGhlbSwgc28g
dGhpcyBiaXQgc2hvdWxkIGJlIHNldC4NCj4+Pj4+IE1ha2luZyB0aGlzIGJpdCBzb2Z0d2FyZSBj
b250cm9sbGFibGUgaXMgY29udmVuaWVudCBmb3IgdXNlcnMgdG8gdGFrZSB0aGVpciBvd24gY2hv
aWNlcy4NCj4+Pj4NCj4+Pj4gVGhhbmtzDQo+Pj4+DQo+Pj4+Pg0KPj4+Pj4+DQo+Pj4+Pj4+PiBP
ciBzaG91bGQgdGhpcyBiZSBzZXQgdG8gdHJ1ZSBieSBkZWZhdWx0IGFuZCB0aGVuDQo+Pj4+Pj4+
PiBjaGFuZ2VkIHRvIGZhbHNlIGZvciBvbGQgbWFjaGluZSB0eXBlcz8NCj4+Pj4+Pj4gSG93IGNh
biBJIGRvIHNvPw0KPj4+Pj4+PiBEbyB5b3UgbWVhbiBzZXQgdGhpcyB0byB0cnVlIGJ5IGRlZmF1
bHQsIGFuZCBpZiBvbGQgbWFjaGluZSB0eXBlcyBkb24ndCBuZWVkIHRoaXMgYml0LCB0aGV5IGNh
biBwYXNzIGZhbHNlIGNvbmZpZyB0byBxZW11IHdoZW4gcnVubmluZyBxZW11Pw0KPj4+Pj4+DQo+
Pj4+Pj4gTm8sIHlvdSB3b3VsZCB1c2UgY29tcGF0IG1hY2hpbmVyeS4gU2VlIGhvdyBpcyB4LXBj
aWUtZmxyLWluaXQgaGFuZGxlZC4NCj4+Pj4+Pg0KPj4+Pj4+DQo+Pj4+Pg0KPj4+Pj4gLS0NCj4+
Pj4+IEJlc3QgcmVnYXJkcywNCj4+Pj4+IEppcWlhbiBDaGVuLg0KPj4+DQo+Pg0KPj4gLS0NCj4+
IEJlc3QgcmVnYXJkcywNCj4+IEppcWlhbiBDaGVuLg0KPiANCg0KLS0gDQpCZXN0IHJlZ2FyZHMs
DQpKaXFpYW4gQ2hlbi4NCg==

