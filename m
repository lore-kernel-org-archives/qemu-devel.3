Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 990C2C6FD1F
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Mar 2024 07:05:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rq6Ie-0005qg-KU; Fri, 29 Mar 2024 03:05:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Jiqian.Chen@amd.com>)
 id 1rq6Id-0005qT-Fr
 for qemu-devel@nongnu.org; Fri, 29 Mar 2024 03:05:15 -0400
Received: from mail-mw2nam12on2116.outbound.protection.outlook.com
 ([40.107.244.116] helo=NAM12-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Jiqian.Chen@amd.com>)
 id 1rq6IZ-00088q-3J
 for qemu-devel@nongnu.org; Fri, 29 Mar 2024 03:05:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LVc0Po7OHeVR7cTJ35I5MOyoHWJMcCx5TtBtLWJx3kqFipL2loWasr+Zb9X129LK3/cdcfJ9ZvTRZcVj50raxSh1lIqUU8vRAk02bVTP+DXgjWVjYA5aDMKLWPhag0Je0D2/RyolHucR7jLuL/pdFYMWve5+2Gmf+8vjlS39tNLrxGjdTU5JG2X8TZlR910PH+sq13ILsoUT5FUna2WoSJDrPm6SaUOMmb6NRlFtSoVg6boNZStoqD4z9wtM8gLAhKTGhbg2xzOgoSUTP5wN8SWrJ2YP2ky4419iuTPck3jpe+r3vSswoiZzIhvDCvJky9b36tqhuJdooNMj+Rapiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FoX8yhRULPgvk1Ycpv7uPolomgUw9Ro2fvVv19I9v14=;
 b=nnRqNqs1FimAold6UPEPnfB/Z+PoV+pNPmrweiT6kg1h3JeQEMN5MfMs3dfaihvuLc0AQm2bTkeO08HrHXyJg/7qJq7Cd1p1wPSwmz82VS2Fl1pnI/MkVuls+2HdXcuDtA/QrfW+HSIRmmxF3KDppj57kp9L7CdRnFCr2yJO5dnNlrNq9NrhwEm5kfgM/yP+F1bW7MmB8P8i8qX1uLivj0t++IzpwYfYVDb60p2c2v1iVHsn6ynEcsZda3+EWAgeQwV4243/r7T/c2Jx6KBi47pUfYVhCGZrztgDevL2DiFQSWI23Mnhfc5HRXSdwQ2zsWjcHaYO1hz++T+R4U8w6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FoX8yhRULPgvk1Ycpv7uPolomgUw9Ro2fvVv19I9v14=;
 b=teb4vwE3fXd2Ai9MizGUkp5gNz4m+cvJ1CFlKhzsR/IaJjd0Hx7hL9l+PaI2LpJ9wPkfZ1oG9DOYAZq86XKNpFkzSN7jUKwVHianqcc/Ppaxo85MK6L3L8lcgmnM4Y8Im8a3GwzSzOJZjaVBHNrr3CngHFs1zxDDm7hxUY7/XHk=
Received: from BL1PR12MB5849.namprd12.prod.outlook.com (2603:10b6:208:384::18)
 by PH7PR12MB5594.namprd12.prod.outlook.com (2603:10b6:510:134::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.40; Fri, 29 Mar
 2024 07:00:04 +0000
Received: from BL1PR12MB5849.namprd12.prod.outlook.com
 ([fe80::debf:178c:f5df:5efa]) by BL1PR12MB5849.namprd12.prod.outlook.com
 ([fe80::debf:178c:f5df:5efa%6]) with mapi id 15.20.7409.031; Fri, 29 Mar 2024
 07:00:03 +0000
From: "Chen, Jiqian" <Jiqian.Chen@amd.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "Huang, Ray"
 <Ray.Huang@amd.com>, "Chen, Jiqian" <Jiqian.Chen@amd.com>
Subject: Re: [RFC QEMU PATCH v8 2/2] virtio-pci: implement No_Soft_Reset bit
Thread-Topic: [RFC QEMU PATCH v8 2/2] virtio-pci: implement No_Soft_Reset bit
Thread-Index: AQHagPw4nwt3E6Dxr0GcatBwmH6cBbFM+5kAgACHiID//5QEAIABse2A
Date: Fri, 29 Mar 2024 07:00:02 +0000
Message-ID: <BL1PR12MB5849C37A0B0E1AF02644C203E73A2@BL1PR12MB5849.namprd12.prod.outlook.com>
References: <20240328103903.408290-1-Jiqian.Chen@amd.com>
 <20240328103903.408290-3-Jiqian.Chen@amd.com>
 <20240328065606-mutt-send-email-mst@kernel.org>
 <BL1PR12MB5849ACCD6602EAB88BE2FED9E73B2@BL1PR12MB5849.namprd12.prod.outlook.com>
 <20240328083503-mutt-send-email-mst@kernel.org>
In-Reply-To: <20240328083503-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-imapappendstamp: BL3PR12MB6425.namprd12.prod.outlook.com
 (15.20.7292.000)
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5849:EE_|PH7PR12MB5594:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MT31wtJSYJZtjDEj5G+DAZiE/tTdeUmnjGh55T0g6LrBJM7/VHSUd8w8GOOeBOYEr0Rwb6+EWDQQ7BB06TnTcANDTg/88mq2kzYE5myDDBkJCW8Gz84Qsbu2jCDVO5iJ0O0DdqU92LmYvwBoGmdK0uIIqvH9cZwA/v95JjF/DzLa5N2KR9tExU/yNM2rvAn7etxz6bCSRQpR39ZKtOHPs7tzKNYPTO2mNONFhDKzT6CgC18TBm1yF9ZHIDi7hFJWBrdj2E3BZPSzlwNVgh4JfFtPiMBafQ/kB/wdBa+IWMTMBFx/P2AUcSinVFkFP0S0RQnnPQY4nl7/m+9gffjbxG7CeNE2ck6BRbBlHb+dSI829NYgCUoW7FhYiMbrCDP9VRdH+/x2F6BjAOODzp6GF6yOViIDeIwysjxm7/SKiuzqPX8vt4WSxSL19pMt4jI+FbKMW9h8l9CWTLW7WghZllzNJlaxoDvujkzmAtmcawKHGhyyoPlggMVLanN1dJDhEgVJ8J98QSkm+ZqX0FqlshOyAAgEZAxm6ojvyOAl6KqUeKqFgkAxQugZXa/IB8f3PiQLsx457JXub8yintIP2dmytVqGkP0Svx9cKmTvMr+EOfqHKYbX/0fEBfO5UxoRemc96B/eM8sLevsZ6X4Bfpss5VSFy3I5ZfpMh4Xnmwo=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5849.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(376005); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?c0hzYm1DYVhZZ1dzVDJHeFBsOFg4Z0pTT0tONnk3NktVQndzNU8wWENyVmpr?=
 =?utf-8?B?ckRKNFJqV0QramhqZ3BUUy9naHR4QnhzQ25yd01CdE45VzNTUkN5c25MSGhU?=
 =?utf-8?B?N2dUSnFwNytlYzdZemlVK0dVc28wV2NZSmdVWUcrNWFWQ1NqamtxRUJKYmpn?=
 =?utf-8?B?ejJmbDgyVlNhcWR5Y2d4WllUYlhoSVd2YWRFYkxqUkY0ZFlkcUc4TWtmQ25O?=
 =?utf-8?B?Z2g1SkN5SzJVald0bjM4TWJsT3JiUkNzTW1DWlk0RnZYb2Q3dm85TWRpamJx?=
 =?utf-8?B?YXI3U3BzRitXcmFpVVBENlpNYjdhSy9VYXAxUXY2c1FubVkzNDUxRnZROTVB?=
 =?utf-8?B?MlZmUEZFZzBXdjY0M3pPY2ZIaTlwaTFtTmxnT3BvUTlhOUFEU2xPblYyYjBX?=
 =?utf-8?B?a3R4Zk8xKzJZN0QrM2dIVGlwMENjQWczTVluOERjYkxIeERtWEd6YkxUdzkx?=
 =?utf-8?B?bVRwcVA5NnhqRE1Gekw4dHJkeGswdkhVL0hVNjYyOTFkMlRvVDU2d3lTWlU3?=
 =?utf-8?B?TzNjSzlsdUNla29oUFRDQ2VFdTVVMHdNOFNOWjVYTXNEelZXbGhUbEsrVk9M?=
 =?utf-8?B?RDdBUm5RcGdJZDNxenF0S3lhQXNUakYyVkVSd2hsdytPdTZQVThGd3dEY2wr?=
 =?utf-8?B?dHFWSkt0a2UyWkc5dXFEb01INkRaaDJoMktGUDN0ZHppTkpZU2ZtVXhuSVEy?=
 =?utf-8?B?d1BYRmp4K29oZkZBd3FoMHBCSlp3TFBIcjdydUdzL0JkQ285VWxQbFlkM1NS?=
 =?utf-8?B?WTdkcWtMcWxtbHpLNmVBUC94REkyWnRjZHZZVjQxSit5NFFsTjBxaGVCMSty?=
 =?utf-8?B?REhsNzEyajJtTVYrdk9obnIyZUdVdDZCaG0wT2MyZ09wRDdNamR0ZW5EOHFw?=
 =?utf-8?B?WGt4ckpKWGtVeUJpMkxCNjRBd3JqaDdqc2RyVFk4RUtqQytDSzFzR3JnMkNh?=
 =?utf-8?B?WmtoL2xoNStSRmZINnBVdXdBRHZ3dzdjRGRYWGpvbWx0eE4zdVQ4TWlCeHU5?=
 =?utf-8?B?SmpIcW1acnVxeDVhaU81S2ZOeU1EYWFEaVZXN1RIRUYzV0hLYytyUmFPNmV2?=
 =?utf-8?B?VFlEY3NnVEhIQXNpWlVKejhhR0F3blNJVVdDd1BjdG8zNXZxWm0rZWRhNTN5?=
 =?utf-8?B?RjlyKy9hNk5LK3RSeW5qSzMza3NTMTZlMzQ4eU5GT2tGekRuamFzRlNsem94?=
 =?utf-8?B?MWVOanU3OTZPK3V5NkdpMXdFa3gveEVFSllJQm4yL3IrNkNkVXo1RVVjb216?=
 =?utf-8?B?Rzh2WnludDRJSTZJSjk2cldCeWJHdXFUaHFpVnU4U1Rrb1lhOTc5RHc2ODM5?=
 =?utf-8?B?bHRJUEEzVS9VNGRkRVBiL3ZDOFFjVnNFdDQ1Z1VHY3ZwbEduUTBwWFZ0d0po?=
 =?utf-8?B?S05jMUREbi9BdDJBZFFqaFVIYkRzR2c2amR0VlAwMGdnYlVLb3FBK21CZjBi?=
 =?utf-8?B?NnVUNkhKdzM5RFpuT3NRQ0toU1UzVWs0YmNwWmZQbFcybThGeUN2R3EyRTdr?=
 =?utf-8?B?ak9kUXQ3aHEyUVJ5eHlUMTUwSmdNRndxYXFhSlJFMjlvSjYxWE55WUZkdmFP?=
 =?utf-8?B?eUJ0SlZXSUlFOCsxWUVqOGI2T1pRbTAxWExpdzFlZ1pNOWd1NFYyTmRBSEw4?=
 =?utf-8?B?NHp3cmV6Ykg5QzhuenVQR3NyT2RKczFURzY5dzdGNTF2SStIcWZidHlDeU1U?=
 =?utf-8?B?b2YzRDZ2TEMrc3I0U1RMTk5EcGNEQmV4cXNpUkk1SVhmRzJkbUROMmYzdktH?=
 =?utf-8?B?NUF4KzU5ZlliOHZLaEwrc3A0ZDFwUFM1cVhZeG00NE02SkJSa0tZdzlEZEl2?=
 =?utf-8?B?QXJUQmtTWHlWQ2k1WWJYRzBGU1VtUFZ6NmMvRG5RTlZQeGQwMkV5MTlDV3dL?=
 =?utf-8?B?Q1BQY0NmQ0xrcjY3aUgyVHJBdmtiN05Nd1hmWWdITlhid2h2ZVI0KzNSMTRT?=
 =?utf-8?B?dnNTUXgwLzF1WUY3aWZRYmlMZ0JGUlJMbGFyWWNJOXo5d0ZrRzgxajZMeGRE?=
 =?utf-8?B?KzVDQmxPQWZ4NW1PTFFhRGI3TEoreWtBVUZDMmlLNXBpN0tNcG9qbzdObWhj?=
 =?utf-8?B?MzdNMENaUlNXaHJoZ3owRFBDZGJTcTRtWFNpSDI1UHJEMlB6aTlWWFFLMTVC?=
 =?utf-8?Q?omhs=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4D4DF03DCDC1C84796F2D67986523DB1@amdcloud.onmicrosoft.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57fb23e9-b5fa-428e-54f5-08dc4fbddb8a
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Mar 2024 07:00:02.9903 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oPXdaenjnfdOjfpKdrLTINXMpLGCsKLJ1tsAxpWRzU3xz5t7HaaOpR4XdX4pnRzToWzE95eFINiKaCMHZaqCsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5594
Received-SPF: permerror client-ip=40.107.244.116;
 envelope-from=Jiqian.Chen@amd.com;
 helo=NAM12-MW2-obe.outbound.protection.outlook.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.08,
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

T24gMjAyNC8zLzI4IDIwOjM2LCBNaWNoYWVsIFMuIFRzaXJraW4gd3JvdGU6DQo+Pj4+ICt9DQo+
Pj4+ICsNCj4+Pj4gIHN0YXRpYyB2b2lkIHZpcnRpb19wY2lfYnVzX3Jlc2V0X2hvbGQoT2JqZWN0
ICpvYmopDQo+Pj4+ICB7DQo+Pj4+ICAgICAgUENJRGV2aWNlICpkZXYgPSBQQ0lfREVWSUNFKG9i
aik7DQo+Pj4+ICAgICAgRGV2aWNlU3RhdGUgKnFkZXYgPSBERVZJQ0Uob2JqKTsNCj4+Pj4gIA0K
Pj4+PiArICAgIGlmICh2aXJ0aW9fcGNpX25vX3NvZnRfcmVzZXQoZGV2KSkgew0KPj4+PiArICAg
ICAgICByZXR1cm47DQo+Pj4+ICsgICAgfQ0KPj4+PiArDQo+Pj4+ICAgICAgdmlydGlvX3BjaV9y
ZXNldChxZGV2KTsNCj4+Pj4gIA0KPj4+PiAgICAgIGlmIChwY2lfaXNfZXhwcmVzcyhkZXYpKSB7
DQo+Pj4+IEBAIC0yNDg0LDYgKzI1MTEsOCBAQCBzdGF0aWMgUHJvcGVydHkgdmlydGlvX3BjaV9w
cm9wZXJ0aWVzW10gPSB7DQo+Pj4+ICAgICAgICAgICAgICAgICAgICAgIFZJUlRJT19QQ0lfRkxB
R19JTklUX0xOS0NUTF9CSVQsIHRydWUpLA0KPj4+PiAgICAgIERFRklORV9QUk9QX0JJVCgieC1w
Y2llLXBtLWluaXQiLCBWaXJ0SU9QQ0lQcm94eSwgZmxhZ3MsDQo+Pj4+ICAgICAgICAgICAgICAg
ICAgICAgIFZJUlRJT19QQ0lfRkxBR19JTklUX1BNX0JJVCwgdHJ1ZSksDQo+Pj4+ICsgICAgREVG
SU5FX1BST1BfQklUKCJ4LXBjaWUtcG0tbm8tc29mdC1yZXNldCIsIFZpcnRJT1BDSVByb3h5LCBm
bGFncywNCj4+Pj4gKyAgICAgICAgICAgICAgICAgICAgVklSVElPX1BDSV9GTEFHX1BNX05PX1NP
RlRfUkVTRVRfQklULCBmYWxzZSksDQo+Pj4+ICAgICAgREVGSU5FX1BST1BfQklUKCJ4LXBjaWUt
ZmxyLWluaXQiLCBWaXJ0SU9QQ0lQcm94eSwgZmxhZ3MsDQo+Pj4+ICAgICAgICAgICAgICAgICAg
ICAgIFZJUlRJT19QQ0lfRkxBR19JTklUX0ZMUl9CSVQsIHRydWUpLA0KPj4+PiAgICAgIERFRklO
RV9QUk9QX0JJVCgiYWVyIiwgVmlydElPUENJUHJveHksIGZsYWdzLA0KPj4+DQo+Pj4gSSBhbSBh
IGJpdCBjb25mdXNlZCBhYm91dCB0aGlzIHBhcnQuDQo+Pj4gRG8geW91IHdhbnQgdG8gbWFrZSB0
aGlzIHNvZnR3YXJlIGNvbnRyb2xsYWJsZT8NCj4+IFllcywgYmVjYXVzZSBldmVuIHRoZSByZWFs
IGhhcmR3YXJlLCB0aGlzIGJpdCBpcyBub3QgYWx3YXlzIHNldC4NCj4gDQo+IFNvIHdoaWNoIHZp
cnRpbyBkZXZpY2VzIHNob3VsZCBhbmQgd2hpY2ggc2hvdWxkIG5vdCBzZXQgdGhpcyBiaXQ/DQpU
aGlzIGRlcGVuZHMgb24gdGhlIHNjZW5hcmlvIHRoZSB2aXJ0aW8tZGV2aWNlIGlzIHVzZWQsIGlm
IHdlIHdhbnQgdG8gdHJpZ2dlciBhbiBpbnRlcm5hbCBzb2Z0IHJlc2V0IGZvciB0aGUgdmlydGlv
LWRldmljZSBkdXJpbmcgUzMsIHRoaXMgYml0IHNob3VsZG4ndCBiZSBzZXQuDQpJbiBteSB1c2Ug
Y2FzZSBvbiBteSBlbnZpcm9ubWVudCwgSSBkb24ndCB3YW50IHRvIHJlc2V0IHZpcnRpby1ncHUg
ZHVyaW5nIFMzLA0KYmVjYXVzZSBvbmNlIHRoZSBkaXNwbGF5IHJlc291cmNlcyBhcmUgZGVzdHJv
eWVkLCB0aGVyZSBhcmUgbm90IGVub3VnaCBpbmZvcm1hdGlvbiB0byByZS1jcmVhdGUgdGhlbSwg
c28gdGhpcyBiaXQgc2hvdWxkIGJlIHNldC4NCk1ha2luZyB0aGlzIGJpdCBzb2Z0d2FyZSBjb250
cm9sbGFibGUgaXMgY29udmVuaWVudCBmb3IgdXNlcnMgdG8gdGFrZSB0aGVpciBvd24gY2hvaWNl
cy4NCg0KPiANCj4+PiBPciBzaG91bGQgdGhpcyBiZSBzZXQgdG8gdHJ1ZSBieSBkZWZhdWx0IGFu
ZCB0aGVuDQo+Pj4gY2hhbmdlZCB0byBmYWxzZSBmb3Igb2xkIG1hY2hpbmUgdHlwZXM/DQo+PiBI
b3cgY2FuIEkgZG8gc28/DQo+PiBEbyB5b3UgbWVhbiBzZXQgdGhpcyB0byB0cnVlIGJ5IGRlZmF1
bHQsIGFuZCBpZiBvbGQgbWFjaGluZSB0eXBlcyBkb24ndCBuZWVkIHRoaXMgYml0LCB0aGV5IGNh
biBwYXNzIGZhbHNlIGNvbmZpZyB0byBxZW11IHdoZW4gcnVubmluZyBxZW11Pw0KPiANCj4gTm8s
IHlvdSB3b3VsZCB1c2UgY29tcGF0IG1hY2hpbmVyeS4gU2VlIGhvdyBpcyB4LXBjaWUtZmxyLWlu
aXQgaGFuZGxlZC4NCj4gDQo+IA0KDQotLSANCkJlc3QgcmVnYXJkcywNCkppcWlhbiBDaGVuLg0K

