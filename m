Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 136B3CD1288
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Apr 2024 03:03:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rrUQx-0006uE-DH; Mon, 01 Apr 2024 23:03:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Jiqian.Chen@amd.com>)
 id 1rrUQv-0006u4-Ur
 for qemu-devel@nongnu.org; Mon, 01 Apr 2024 23:03:33 -0400
Received: from mail-dm3nam02on20700.outbound.protection.outlook.com
 ([2a01:111:f403:2405::700]
 helo=NAM02-DM3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Jiqian.Chen@amd.com>)
 id 1rrUQt-0003Hv-Vt
 for qemu-devel@nongnu.org; Mon, 01 Apr 2024 23:03:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WKV/O/u2rdeMbNE8mb+hVVGI4dd6df3NGXs1VhDALKNY9tVWzwNVLVFlpGZ1MUUATL9z8ade1UUTtwuopaR6TCibe2ZFOX4YmUPKnA+UhmELm0KD8SDX1vg2UOK1ZEgUd0QbGpiY2n3DtK3v/5xef7cHbsF6xGF6tgzvXhtDBk7ZE4tlXuPHtg7MPEGSFa7WZJJMXKMPlwv+3bDst8GMmLeXKHespZCLYJb1O72+4EcSF/9qdJjinFy/ISQEF/9bXv+6ZcmGwptACa7ZhjVZgmudj8n1S6b4GOrEoq7fB60cfKaiAR5CNI/rx5OkpPbm2xZ9syCJa8ACRFLo2mz23Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/r8rioC0rXTTKLrLsMkRePLa7D/+umFDodEafFiKV1k=;
 b=JspvW6zgF4KMp59WwOKqSWJ1c80IE74XKPzXvv3XE9dyFTSTz6rBo7sByRU7ciMk7hyhYIfvWpZtXWy32OxlKFd4Szi1HT1w8pe5ffaC8u5nXmVaMKffDm/cKDWfdpxisudTgDZFvozoRZWeFvNww/031h5+1xPoRUXfc43J9NLRsNo1hllbaf9jYY90V07SgTuY0DFjbKfd/+IAtXGWCsFnAr6ko7UuU1R4IgqBFBMHO6HM5hVeSBug/qn6kqsFlSsDP0CUrRNWdKBUTR2NhaEOx3Q4h3LMtQcvqr7CjJloqeOE/POBDoP92UIohhaiNDlwALYrZNVwy6WU6Hmkjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/r8rioC0rXTTKLrLsMkRePLa7D/+umFDodEafFiKV1k=;
 b=NxQtVVf7nslZx1UY7lUQ9mafQVtuh9bAiwAk0GSaJ5+a8uqgHXZXguQA3kPilBBjuNRutfbgteF2HNpJ78trZakzBkCeppg863x5TO8+JYeyqDmQdIAmvzloSAMEMJplFLRcxqUvkzlYr1/B7njCB0viSO1v99YzkLqxlOjB15Q=
Received: from BL1PR12MB5849.namprd12.prod.outlook.com (2603:10b6:208:384::18)
 by PH7PR12MB5656.namprd12.prod.outlook.com (2603:10b6:510:13b::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Tue, 2 Apr
 2024 03:03:24 +0000
Received: from BL1PR12MB5849.namprd12.prod.outlook.com
 ([fe80::debf:178c:f5df:5efa]) by BL1PR12MB5849.namprd12.prod.outlook.com
 ([fe80::debf:178c:f5df:5efa%6]) with mapi id 15.20.7409.042; Tue, 2 Apr 2024
 03:03:23 +0000
From: "Chen, Jiqian" <Jiqian.Chen@amd.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: Jason Wang <jasowang@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "Huang, Ray" <Ray.Huang@amd.com>, "Chen, Jiqian"
 <Jiqian.Chen@amd.com>
Subject: Re: [RFC QEMU PATCH v8 2/2] virtio-pci: implement No_Soft_Reset bit
Thread-Topic: [RFC QEMU PATCH v8 2/2] virtio-pci: implement No_Soft_Reset bit
Thread-Index: AQHagPw4nwt3E6Dxr0GcatBwmH6cBbFM+5kAgACHiID//5QEAIABse2A//+IQICAADj0gIAGTJQA
Date: Tue, 2 Apr 2024 03:03:23 +0000
Message-ID: <BL1PR12MB5849AA89DC28465714590B56E73E2@BL1PR12MB5849.namprd12.prod.outlook.com>
References: <20240328103903.408290-1-Jiqian.Chen@amd.com>
 <20240328103903.408290-3-Jiqian.Chen@amd.com>
 <20240328065606-mutt-send-email-mst@kernel.org>
 <BL1PR12MB5849ACCD6602EAB88BE2FED9E73B2@BL1PR12MB5849.namprd12.prod.outlook.com>
 <20240328083503-mutt-send-email-mst@kernel.org>
 <BL1PR12MB5849C37A0B0E1AF02644C203E73A2@BL1PR12MB5849.namprd12.prod.outlook.com>
 <CACGkMEt=V4V4JgT08o5_f7tj-eNZDi2GB4=H_Qp7xALrRxBWhQ@mail.gmail.com>
 <20240329064431-mutt-send-email-mst@kernel.org>
In-Reply-To: <20240329064431-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-imapappendstamp: IA1PR12MB8494.namprd12.prod.outlook.com
 (15.20.7292.000)
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5849:EE_|PH7PR12MB5656:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dP5P6MvS1L8YbkbB9Qyu2ON9hUlLvWUgY/vRODDaOJLlYx2h3TS64SvKZxl5GG1SfwbX9kcni4iuhM4qlqO85zk2W1R7dnC6G0s/1XyCNL/Kb9jx0PgBErsTyCZ8P3MGl64QP3B4Un3ZiQt9OwnmJZbAOYr+4Jo3mz1nWNm9VrYxF2G9xRv3akVHG1Kff4SeaVv5PUFNzSrjbyFvlPIbOvrq0N+JGOf24qEt81maVg/9KQClp9Cx3ycXBjPv4Uj0majokFz1uWSVHLj2qu7vYiHW1f4UqUKIyRqg4Lj+x3s0H0z8nfExY65SxngkRZK9qasHrkSXGDgT7wwLRNXAqrjUwfVaPyZKRRjxOHrQJXj+5zAO7p3l7WTkybUUpLMN2kj8k6KKvLXsFbW/FyPbcI7WLi0bDosu7p+NKsNAsrh+y/gzZad+QWTvqqbcqYWlGioJGz78913e6x8YhGsoC5GQBTY6tG7WHoYkDlwBgYhYFre/wjahGv2ihFypB8Q/DfzaSq+N7w1MxNwgBvH/DIuEfsTfajY66skNoIiYLKg+nMF1PBqJa5XRN+sK9t1ilf1jeveFi9WsCypHtFTNvwV9biEyjTZM15dsoR8CFV5QAOMoZaTuUsYXXMrEXc8jTIEgmMCWzeOmiV+9hgg2b9XX5fpltEqKtxdYdOoLgUQ=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5849.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(366007); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Q05IR05UWEN3QUpoMjBadnlzUjNZTmRTaFVmTE9xRUp6QW9IbkVocnNaYkhC?=
 =?utf-8?B?NVR6VnJpeUdPYm5ub0RsWXNXSHVHSUhnYzZZclVseDhjN1VCUkI5Y3pEZFFK?=
 =?utf-8?B?d0hDTG4rT0ZXWXpyWjdxdmpVYTRDcjE5OGVpY05MOU9XK2JoSm44YWxnYkVR?=
 =?utf-8?B?bGZPRmFIb2dBNUdXRzg1S1IrTnpKbUZsMHpsUDdmdWo3T2NFdEFCSHZrNm82?=
 =?utf-8?B?SVEvWkY1bG5kMFgvMWNWZmFKb1JzTkMvdDhTbExoM3E5RVp3clRLT3R6SWgr?=
 =?utf-8?B?MzZnQ0N4ejZ4S25jMWUybTc1Ry9XOE1tN1pMUk4weldZRzdsVUJMYjM5MnB4?=
 =?utf-8?B?QlFTMnJQZmNNMzlYMVJ3SzZsRFQ2ZlZGWmNxbUVkTzhha3pJRDdOL1NxM3Vk?=
 =?utf-8?B?TURlalI3TkhBaXJrK1d4bE96b1FtajBTR2k3MCtvenVMMS80Qi95M1lxTzl5?=
 =?utf-8?B?eVpOZGUyMWxHaUUvVldJNTBuc29Lb0FoSllxZFBadlhERDNiQU1mTlRpVnhr?=
 =?utf-8?B?NS9qbW9DVmhCRHZkTk5qYkJDMnF1MGNrdWdtUGRFUkdPRUw2NEpkOTl4VVZz?=
 =?utf-8?B?L1dmOFV1WUdTWmdNL2NYcE9sV3FjZVV3NS81YUkxQ3l6c1FhTFM2VDRxT3NJ?=
 =?utf-8?B?d0hMZlRMKzQ3YWZGQWRUT2dxRjhETFVKemNMdVVSY2hrc1MzOTlDVHR0YVJw?=
 =?utf-8?B?aFl0UStPMy9NUTV4Tld4UWRTZng1YU1kd21ESkhzOGtiNnNQN0tkR3F6R0l1?=
 =?utf-8?B?bU81cDlRbEQrVG5oa09LOHRwRzM4SXFoSm1zdWZqSjFMOEJ0MnRxQjRxNGlT?=
 =?utf-8?B?ZkFrRWpQTnpMVTZNMnZNN25UYURxTDN6eWE5K01yVUI3NG0wMTllUk9FMlZO?=
 =?utf-8?B?enJhWTdjM1I0RGtvN2NTb0tUdFRkbTUvVE9ML3FJdHlreEpaZjNmMmdXVFYx?=
 =?utf-8?B?aVFGSWhsWlhLeUc5eG5oQ0NLc0RqZDhhREs3NWx2bitOekhoclA1TXNsT3Iy?=
 =?utf-8?B?ZmlTRytsL0hYWWxrRzVUeTYzR1ByODBlWVVFMFZtNW9LT29SS1hOQ0R2anVz?=
 =?utf-8?B?eXFlSUZIdXRiTTBuYVJyUllBYllzMDNuQ0ZsNVNpbWpDUHZNQ2FCNlhqTUZ5?=
 =?utf-8?B?dHBLSTVGK3ozdG92bWZpS3lKVjVlR0cwWW5FYzJkVkZ1b1diSkpJMEJFaEJZ?=
 =?utf-8?B?VFdIV1I0N0h2aDQrdDE1WDRiUDRIME1Nc21tcDloM3pMa2t2bkJNMTVWZURy?=
 =?utf-8?B?bFJBc0ZsMnZUemttVFZTbWc3NlIzNDhjdFhHM3dRMDA3VVBrZmhuM3F6dDlP?=
 =?utf-8?B?b2NnK1hYdUZDVXQ3K2tibEE4UWV6bzZCYXljRE9LejVZNTQvN1Bkb2JOUU5R?=
 =?utf-8?B?U3NJL3ExT25yU3pkaldKSHdWaXJmNWJydkJjcUFMSFg1c2hkRUxqVDJ0UXdO?=
 =?utf-8?B?NGpkRDBpQms5MXE4THJsQ0xHajN6Q3BVbU1sTFUwL2JVRHRNOFBsOW0zMEkx?=
 =?utf-8?B?WmxQYkI4bDNOQ2w4MEJSSGcwR2lZTzlUdWRBdDVuemNSdmp4SEdqbmFMQmJF?=
 =?utf-8?B?cU00emdna2ZiZHVYK1l6Tk4yN1FwMmJOY2xndTlSOVE5QlUzSzZUM3kvZ3FX?=
 =?utf-8?B?NXdHbmNWYWVZbjZHN0dMVDRnTXBnKzQzRE80Q0lvdUQrb3dnSWowRk9xNDR4?=
 =?utf-8?B?c1A4ZGRhMHVTNG9DRzMrblo5bEdkZmtYS1RKYnZkNUtMNkNWUVJjZ01nWVJ2?=
 =?utf-8?B?NmdjRElJUzROeG1HRzJrNEorTC8yVFpFcEdMdm1RRjFaampNMlBYbERMb3FJ?=
 =?utf-8?B?REJLSm9weVpxNmZMdGlwcmpkeHBoOW43eHhhc0svYjZSNmhGQXdGQkVyRGE4?=
 =?utf-8?B?ckNjNEJUQThYS3NiaGcwaXVPOUZCcUVaMktMMnpkdmFuLytFNW1qdGdOamd4?=
 =?utf-8?B?azk1aHVVVmluUjh6TkhxWHF0YU05bVBEQ0c4S05QMlVrTWxLcmhNczRGT2Ra?=
 =?utf-8?B?VlhCVzdEVjZzbWlMbHdYWDhNT0plREMrUXVrd29KbWZycVNqWWlUREZ1NGJp?=
 =?utf-8?B?WE0zTngwRUhpVVBmbXZpVElsU1lUQWFUTUczdmdra082ejAveGdYeHdyOXlZ?=
 =?utf-8?Q?NVmc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CB23C92AE8783B42BFCB1F22C470367B@amdcloud.onmicrosoft.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2194307-490d-4fcb-73f0-08dc52c17587
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Apr 2024 03:03:23.3428 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MvyLIUNF3L1eW/PIuYTEQ4/4E5MzLkgd+14wh3kbKKPKv1zKfBr2WQP/xjXeAjgE8m7kWRXY3eIOCY2pEklxJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5656
Received-SPF: permerror client-ip=2a01:111:f403:2405::700;
 envelope-from=Jiqian.Chen@amd.com;
 helo=NAM02-DM3-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

T24gMjAyNC8zLzI5IDE4OjQ0LCBNaWNoYWVsIFMuIFRzaXJraW4gd3JvdGU6DQo+IE9uIEZyaSwg
TWFyIDI5LCAyMDI0IGF0IDAzOjIwOjU5UE0gKzA4MDAsIEphc29uIFdhbmcgd3JvdGU6DQo+PiBP
biBGcmksIE1hciAyOSwgMjAyNCBhdCAzOjA34oCvUE0gQ2hlbiwgSmlxaWFuIDxKaXFpYW4uQ2hl
bkBhbWQuY29tPiB3cm90ZToNCj4+Pg0KPj4+IE9uIDIwMjQvMy8yOCAyMDozNiwgTWljaGFlbCBT
LiBUc2lya2luIHdyb3RlOg0KPj4+Pj4+PiArfQ0KPj4+Pj4+PiArDQo+Pj4+Pj4+ICBzdGF0aWMg
dm9pZCB2aXJ0aW9fcGNpX2J1c19yZXNldF9ob2xkKE9iamVjdCAqb2JqKQ0KPj4+Pj4+PiAgew0K
Pj4+Pj4+PiAgICAgIFBDSURldmljZSAqZGV2ID0gUENJX0RFVklDRShvYmopOw0KPj4+Pj4+PiAg
ICAgIERldmljZVN0YXRlICpxZGV2ID0gREVWSUNFKG9iaik7DQo+Pj4+Pj4+DQo+Pj4+Pj4+ICsg
ICAgaWYgKHZpcnRpb19wY2lfbm9fc29mdF9yZXNldChkZXYpKSB7DQo+Pj4+Pj4+ICsgICAgICAg
IHJldHVybjsNCj4+Pj4+Pj4gKyAgICB9DQo+Pj4+Pj4+ICsNCj4+Pj4+Pj4gICAgICB2aXJ0aW9f
cGNpX3Jlc2V0KHFkZXYpOw0KPj4+Pj4+Pg0KPj4+Pj4+PiAgICAgIGlmIChwY2lfaXNfZXhwcmVz
cyhkZXYpKSB7DQo+Pj4+Pj4+IEBAIC0yNDg0LDYgKzI1MTEsOCBAQCBzdGF0aWMgUHJvcGVydHkg
dmlydGlvX3BjaV9wcm9wZXJ0aWVzW10gPSB7DQo+Pj4+Pj4+ICAgICAgICAgICAgICAgICAgICAg
IFZJUlRJT19QQ0lfRkxBR19JTklUX0xOS0NUTF9CSVQsIHRydWUpLA0KPj4+Pj4+PiAgICAgIERF
RklORV9QUk9QX0JJVCgieC1wY2llLXBtLWluaXQiLCBWaXJ0SU9QQ0lQcm94eSwgZmxhZ3MsDQo+
Pj4+Pj4+ICAgICAgICAgICAgICAgICAgICAgIFZJUlRJT19QQ0lfRkxBR19JTklUX1BNX0JJVCwg
dHJ1ZSksDQo+Pj4+Pj4+ICsgICAgREVGSU5FX1BST1BfQklUKCJ4LXBjaWUtcG0tbm8tc29mdC1y
ZXNldCIsIFZpcnRJT1BDSVByb3h5LCBmbGFncywNCj4+Pj4+Pj4gKyAgICAgICAgICAgICAgICAg
ICAgVklSVElPX1BDSV9GTEFHX1BNX05PX1NPRlRfUkVTRVRfQklULCBmYWxzZSksDQo+Pg0KPj4g
V2h5IGRvZXMgaXQgY29tZSB3aXRoIGFuIHggcHJlZml4Pw0KPj4NCj4+Pj4+Pj4gICAgICBERUZJ
TkVfUFJPUF9CSVQoIngtcGNpZS1mbHItaW5pdCIsIFZpcnRJT1BDSVByb3h5LCBmbGFncywNCj4+
Pj4+Pj4gICAgICAgICAgICAgICAgICAgICAgVklSVElPX1BDSV9GTEFHX0lOSVRfRkxSX0JJVCwg
dHJ1ZSksDQo+Pj4+Pj4+ICAgICAgREVGSU5FX1BST1BfQklUKCJhZXIiLCBWaXJ0SU9QQ0lQcm94
eSwgZmxhZ3MsDQo+Pj4+Pj4NCj4+Pj4+PiBJIGFtIGEgYml0IGNvbmZ1c2VkIGFib3V0IHRoaXMg
cGFydC4NCj4+Pj4+PiBEbyB5b3Ugd2FudCB0byBtYWtlIHRoaXMgc29mdHdhcmUgY29udHJvbGxh
YmxlPw0KPj4+Pj4gWWVzLCBiZWNhdXNlIGV2ZW4gdGhlIHJlYWwgaGFyZHdhcmUsIHRoaXMgYml0
IGlzIG5vdCBhbHdheXMgc2V0Lg0KPj4NCj4+IFdlIGFyZSB0YWxraW5nIGFib3V0IGVtdWxhdGVk
IGRldmljZXMgaGVyZS4NCj4+DQo+Pj4+DQo+Pj4+IFNvIHdoaWNoIHZpcnRpbyBkZXZpY2VzIHNo
b3VsZCBhbmQgd2hpY2ggc2hvdWxkIG5vdCBzZXQgdGhpcyBiaXQ/DQo+Pj4gVGhpcyBkZXBlbmRz
IG9uIHRoZSBzY2VuYXJpbyB0aGUgdmlydGlvLWRldmljZSBpcyB1c2VkLCBpZiB3ZSB3YW50IHRv
IHRyaWdnZXIgYW4gaW50ZXJuYWwgc29mdCByZXNldCBmb3IgdGhlIHZpcnRpby1kZXZpY2UgZHVy
aW5nIFMzLCB0aGlzIGJpdCBzaG91bGRuJ3QgYmUgc2V0Lg0KPj4NCj4+IElmIHRoZSBkZXZpY2Ug
ZG9lc24ndCBuZWVkIHJlc2V0LCB3aHkgYm90aGVyIHRoZSBkcml2ZXIgZm9yIHRoaXM/DQo+Pg0K
Pj4gQnR3LCBub19zb2Z0X3Jlc2V0IGlzIGluc3VmZmljaWVudCBmb3Igc29tZSBjYXNlcywgdGhl
cmUncyBhIHByb3Bvc2FsDQo+PiBmb3IgdGhlIHZpcnRpby1zcGVjLiBJIHRoaW5rIHdlIG5lZWQg
dG8gd2FpdCB1bnRpbCBpdCBpcyBkb25lLg0KPiANCj4gVGhhdCBzZWVtcyBvcnRob2dvbmFsIG9y
IGRpZCBJIG1pc3Mgc29tZXRoaW5nPw0KWWVzLCBJIGxvb2tlZCB0aGUgZGV0YWlsIG9mIHRoZSBw
cm9wb3NhbCwgSSBhbHNvIHRoaW5rIHRoZXkgYXJlIHVucmVsYXRlZC4NCkkgd2lsbCBzZXQgdGhl
IGRlZmF1bHQgdmFsdWUgb2YgTm9fU29mdF9SZXNldCBiaXQgdG8gdHJ1ZSBpbiBuZXh0IHZlcnNp
b24gYWNjb3JkaW5nIHRvIHlvdXIgb3Bpbmlvbi4NCkFib3V0IHRoZSBjb21wYXRpYmlsaXR5IG9m
IG9sZCBtYWNoaW5lIHR5cGVzLCB3aGljaCB0eXBlcyBzaG91bGQgSSBjb25zaWRlcj8gRG9lcyB0
aGUgc2FtZSBhcyB4LXBjaWUtcG0taW5pdChod19jb21wYXRfMl84KT8NCkZvcmdpdmUgbWUgZm9y
IG5vdCBrbm93aW5nIG11Y2ggYWJvdXQgY29tcGF0aWJpbGl0eS4NCj4gDQo+Pj4gSW4gbXkgdXNl
IGNhc2Ugb24gbXkgZW52aXJvbm1lbnQsIEkgZG9uJ3Qgd2FudCB0byByZXNldCB2aXJ0aW8tZ3B1
IGR1cmluZyBTMywNCj4+PiBiZWNhdXNlIG9uY2UgdGhlIGRpc3BsYXkgcmVzb3VyY2VzIGFyZSBk
ZXN0cm95ZWQsIHRoZXJlIGFyZSBub3QgZW5vdWdoIGluZm9ybWF0aW9uIHRvIHJlLWNyZWF0ZSB0
aGVtLCBzbyB0aGlzIGJpdCBzaG91bGQgYmUgc2V0Lg0KPj4+IE1ha2luZyB0aGlzIGJpdCBzb2Z0
d2FyZSBjb250cm9sbGFibGUgaXMgY29udmVuaWVudCBmb3IgdXNlcnMgdG8gdGFrZSB0aGVpciBv
d24gY2hvaWNlcy4NCj4+DQo+PiBUaGFua3MNCj4+DQo+Pj4NCj4+Pj4NCj4+Pj4+PiBPciBzaG91
bGQgdGhpcyBiZSBzZXQgdG8gdHJ1ZSBieSBkZWZhdWx0IGFuZCB0aGVuDQo+Pj4+Pj4gY2hhbmdl
ZCB0byBmYWxzZSBmb3Igb2xkIG1hY2hpbmUgdHlwZXM/DQo+Pj4+PiBIb3cgY2FuIEkgZG8gc28/
DQo+Pj4+PiBEbyB5b3UgbWVhbiBzZXQgdGhpcyB0byB0cnVlIGJ5IGRlZmF1bHQsIGFuZCBpZiBv
bGQgbWFjaGluZSB0eXBlcyBkb24ndCBuZWVkIHRoaXMgYml0LCB0aGV5IGNhbiBwYXNzIGZhbHNl
IGNvbmZpZyB0byBxZW11IHdoZW4gcnVubmluZyBxZW11Pw0KPj4+Pg0KPj4+PiBObywgeW91IHdv
dWxkIHVzZSBjb21wYXQgbWFjaGluZXJ5LiBTZWUgaG93IGlzIHgtcGNpZS1mbHItaW5pdCBoYW5k
bGVkLg0KPj4+Pg0KPj4+Pg0KPj4+DQo+Pj4gLS0NCj4+PiBCZXN0IHJlZ2FyZHMsDQo+Pj4gSmlx
aWFuIENoZW4uDQo+IA0KDQotLSANCkJlc3QgcmVnYXJkcywNCkppcWlhbiBDaGVuLg0K

