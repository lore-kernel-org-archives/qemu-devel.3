Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66EA7CD128A
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Apr 2024 03:02:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rrUOz-00068B-Ip; Mon, 01 Apr 2024 23:01:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Jiqian.Chen@amd.com>)
 id 1rrUOx-000681-Aa
 for qemu-devel@nongnu.org; Mon, 01 Apr 2024 23:01:31 -0400
Received: from mail-co1nam11on2121.outbound.protection.outlook.com
 ([40.107.220.121] helo=NAM11-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Jiqian.Chen@amd.com>)
 id 1rrUOu-00039c-EU
 for qemu-devel@nongnu.org; Mon, 01 Apr 2024 23:01:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d/5s1FqGb6LvgRgtPr1Ou8xMv4AAArxIcCVl0Y0tJfDGOb45bTzuAny1Kz/elr2JqextXEdi5JCY20eSQG7ASAO4Ms6N+GeieyMEHtl9gAWxODjLbnQzA3uiwySSghsj8Xpv4egJtthfaObJ7mc03RXuCLiCMSEFiNNrkWD6ugeCO1ZRPhVaKjNTU256r+Fz2cZV3zIGQ46RM3fjkMZ9hISb0DIFL24lU9frhhZVGA/OgtVdwmWEdTAwSEPnhZJNkRZnYodBATyra3u6xIYDil5s0joguYbQJklAMP02PdQwDdZTrK2Xr9SGMgWfrMUAproaPMW0lyGiXOZAucvdiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z+RNX77G2UlEMjVITMljcRDG8GQ1w/U5Fuiy7j8ymG8=;
 b=H/f9GOg+0iTJdfU0HpzMWhve4HbvMLfmiuD4nz5g1ChbsbKQMSPMyxy1m51kxK8vsI3znyQjV9Qe36PZmd2ptdG+SJJa6OpbGXM2WaSrkWRCXlLAm5Ri81TLKJ746e4Y0tJz8dbywYXCC4ZRDz/pYDnBUWmF+W4L7ARD1WaOvC8jgwe3JGOWo7yIyXfKk7XLKzVJBUTfS5pV2sTUnxkSCi7K+XesfhIyZH55Q3wec9ziV1FbmyVGvYtC4M/05zwq6GeqlwlagqEaVRwM1tH13LiPyQfvwKxu4JPCF9hcpL7eA8Sr9G5t6OUEC255hpNsApx2w8L5DzU0jwfPvWt5Wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z+RNX77G2UlEMjVITMljcRDG8GQ1w/U5Fuiy7j8ymG8=;
 b=5BJ+RKnqsV3TQokT+9/6EB7vQoHbrdSuIU9YYCybUUmTkS1wWfjonBsn9rgqlldIliCVj0ce+JI3PiRog4afyZgH0ceoaKYow8TRqoGZ+uZH7Ut1KCWI2EwABwAgIQl5f7azePeV2YfQxqlz3rNeqDlKWHN+iUFfAPz2WEZeAnE=
Received: from BL1PR12MB5849.namprd12.prod.outlook.com (2603:10b6:208:384::18)
 by MN2PR12MB4144.namprd12.prod.outlook.com (2603:10b6:208:15f::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.32; Tue, 2 Apr
 2024 02:56:14 +0000
Received: from BL1PR12MB5849.namprd12.prod.outlook.com
 ([fe80::debf:178c:f5df:5efa]) by BL1PR12MB5849.namprd12.prod.outlook.com
 ([fe80::debf:178c:f5df:5efa%6]) with mapi id 15.20.7409.042; Tue, 2 Apr 2024
 02:56:14 +0000
From: "Chen, Jiqian" <Jiqian.Chen@amd.com>
To: Jason Wang <jasowang@redhat.com>
CC: "Michael S. Tsirkin" <mst@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "Huang, Ray" <Ray.Huang@amd.com>, "Chen, Jiqian"
 <Jiqian.Chen@amd.com>
Subject: Re: [RFC QEMU PATCH v8 2/2] virtio-pci: implement No_Soft_Reset bit
Thread-Topic: [RFC QEMU PATCH v8 2/2] virtio-pci: implement No_Soft_Reset bit
Thread-Index: AQHagPw4nwt3E6Dxr0GcatBwmH6cBbFM+5kAgACHiID//5QEAIABse2A//+IQICAAIqjgP//rH8AAMjqgIA=
Date: Tue, 2 Apr 2024 02:56:14 +0000
Message-ID: <BL1PR12MB584947CF6BFAEBA2CB4E904EE73E2@BL1PR12MB5849.namprd12.prod.outlook.com>
References: <20240328103903.408290-1-Jiqian.Chen@amd.com>
 <20240328103903.408290-3-Jiqian.Chen@amd.com>
 <20240328065606-mutt-send-email-mst@kernel.org>
 <BL1PR12MB5849ACCD6602EAB88BE2FED9E73B2@BL1PR12MB5849.namprd12.prod.outlook.com>
 <20240328083503-mutt-send-email-mst@kernel.org>
 <BL1PR12MB5849C37A0B0E1AF02644C203E73A2@BL1PR12MB5849.namprd12.prod.outlook.com>
 <CACGkMEt=V4V4JgT08o5_f7tj-eNZDi2GB4=H_Qp7xALrRxBWhQ@mail.gmail.com>
 <BL1PR12MB5849A4AECE81D37684B88129E73A2@BL1PR12MB5849.namprd12.prod.outlook.com>
 <CACGkMEvNjeYSRQRdcSz4=Cg-DvqNWhD6w9H75PFiqdcQPH+Xww@mail.gmail.com>
In-Reply-To: <CACGkMEvNjeYSRQRdcSz4=Cg-DvqNWhD6w9H75PFiqdcQPH+Xww@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-imapappendstamp: IA1PR12MB8494.namprd12.prod.outlook.com
 (15.20.7292.000)
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5849:EE_|MN2PR12MB4144:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EN3xrDfxE6FRiKckGJs4NZHIXrqwhpyEw+lilDjCiQmROh5fzRU8oouQ/bz7XPkzOR0iGU5n2vEkKj8gADeQO2WjCMB0VkwEFaUYOyKk8JIvv9yxm8Fl8CXtgMRBG5VUnHUmDvlUGG7bxncDjZiOkLlEd31xs/Svx3jfBQcTP/Vk/palh5Xv+1WOJFSnCwaz1fn/0JQgiL8vhHI5JsoChBdg6Tb0ls297wZEbdT5d05zlF/q1DnfVrmuYRDVA7vL8zgjsZ4nQCML9AlMi7MBLcS8LPyeeZPNVB0H+0GsREBv9sAO8vXB6HIYfARbgO/clz2hCf+gRM3ErNKK7t4yvW+ww7HODh4EowiL/xm1n2yXele4fg1wc4SICY2x9f9Ib3HhTcuRXMBM0gpflb8n7XsXqcoTunX6+AyCjiUrdP3h/JbinqFsVRv6Smsb9NC3jnhvFKIzbCNpFDSeWXhcDTkAnJFyDxKedVWN0kdqytXsXyYEDrasjREz2Vllo3P5WmICJB/Athd8NgbvNF7OSGGgAmxr8T2uI8tch0ZRXLWiVhPJRqMEB3oC+D1Az+2eJNULwC8Q9M7nuiQwMIeZGVtmp1peojgKy8fTAqaqiDg=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5849.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(366007); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UFdIZmY1QmNMelk2QlViaFVlNUtlSWIwTG1SdTllOHpRdkV3UnRRLzZzVFVN?=
 =?utf-8?B?blc1TWhPSUxidHNDS0IweVR4Sytxc1JYbVAvV0lPWnJkWkhCaDk4dHQzMGUw?=
 =?utf-8?B?MHZFVEYwVDZiaExXejk3M0ZsdkVzUnUwU1hxMzhmUmEvTWNFbmZCTGliWXIv?=
 =?utf-8?B?Q3M2VHFtQW5xVzdqL1FFcXNSOTFOT1RtWjhpRUlxcVRyVmorejlGRE9UM1J2?=
 =?utf-8?B?a3JCamRVUEJEcmd2dWExYTF5ZUJoaTdKcVduaGtPWHZ4dXkyS1ZsU1hIdnR1?=
 =?utf-8?B?WnJ1ZlNsbnIzQk10N3Z6YnlKV1pJWjJVOS94cjIvY0ZOTVE1WDIzQjUzbzZP?=
 =?utf-8?B?Y1Y1STFWSHpRSFRzVmw3eFhTVlJGeHJmdjNCUjNtRUdGbDkzS2pDcHE2Y0ta?=
 =?utf-8?B?WjFRd3VoUndrUWdpUTc3SENHdVREc3hIZWwxNTBVbFNZNU1hOGFJL3B0OXJC?=
 =?utf-8?B?NWNIL00zZlREME54MTJwOFlqVzRNb0xsUFA0YkdYNmsxV2FsMWZGT2VBdDFS?=
 =?utf-8?B?NzNVaGJ0bkRkaVhNVUdKblNycGpWN1UvMlNGdmZOSjZieUNIeG9CbGZDRFVX?=
 =?utf-8?B?akE4Z1JDYi8rUXB2c3BmWlpGQnh6Njh0UXpLNm1KUnNib3FJcEluRlgvUjhQ?=
 =?utf-8?B?QmhXWWpqU1ZKbWsyVzNHN095UHI2blcyMDY2VDlFUkZTb2IzTEtlWDVYVitt?=
 =?utf-8?B?TWN2Y3ZIWkVHUjlGRE1yU2F3TGphT2s0VVpzSVdZRUZZclAzSVUyMS80b0dM?=
 =?utf-8?B?T2I5dktqNm1DSllDWkVDdnFPOGZIczl5eGgvN0QzT05PcXE4N0dBdXY3L2xN?=
 =?utf-8?B?eEVZcnpEdnl6aURoa1VQNHNKRmNDaGljYm5jVkhvMUh1K2w1U2s1R09PTTgr?=
 =?utf-8?B?V29JdmdzekE3Sm9NRzJybThIL1dUM0F6Q3J4SUltSHl6Tnd5cDFXM0lSdktz?=
 =?utf-8?B?TDNleCtDWEJ5UGFsdjQrRjQyeTAvazBIbGVjc2I2SGpScHMyemdRUGVXdGFo?=
 =?utf-8?B?MWNFSW8wenFrWUhabXNwcURWZWhRUE9NanRkbUVEUmI4RUk3YWNBK2I4dk5O?=
 =?utf-8?B?dHV6bDZGb0xVbnBrRDhmcitDRnJKc0lXZDNHWTZOdkdtMExzbmpNcVdHQ2kr?=
 =?utf-8?B?UFB6b2NVUE13ZWtpbm1ZN0hRS09Xbmo4YTV2bUhmcTVRSElYcEpBbVJqa05p?=
 =?utf-8?B?WEt2Z21pVldZQ2JoVUdjSHJzNmRkdU1iWHNicUZHdXdrQWFEVlVDU2tUNWxM?=
 =?utf-8?B?WkRTMzV4TVEvTDNUd09QenhGdklPRXUxcENFaVB5QWhaRzRpNm5PcFNINWdF?=
 =?utf-8?B?dXNCRGRtTEMwY0Q2eWpwVHEzcy9YNVgyVWhWaWJaWTVKVE9RNkcyUEV3aUJm?=
 =?utf-8?B?REJ0a2NjRzd3dUNrcmUyZWo2a3JEdkdOV2RsaUl3TTU0OWJiZ1VIekN2Y3dR?=
 =?utf-8?B?TkFvQ1p5bHhjTVlObHMwNGZhL29teXJMcUVoWU9mRSttVUVEdUw4VjBRY3dG?=
 =?utf-8?B?ZVlEVEEvV3VobTVlY1RzRERzaGRycUN2bWgySU9uQUdtcGRIQzJPUDU5YVVz?=
 =?utf-8?B?REo0cVF5ajMweE8rdEtXVFF5UFJDMU5nY2RkSWl4V1B6SWVURDNrdXJFdGtG?=
 =?utf-8?B?WGNLYndYaWJxTE5vVk1vV2E2Ky9xbnJNdzlDSXZDMlNKTmRDSlpIczZJaHQ5?=
 =?utf-8?B?dE9FVTNPSnJtL3JEZC9RMGgxTVpDSXpxdkx3Y1B5MjdyV3ZFVWgyL0g4Qkxl?=
 =?utf-8?B?RysyTlB5RmpWQmVnS3hIa0tqKzVNYmFDTDNQWUk2SzEzWTNKN1YzSHdxQWxw?=
 =?utf-8?B?emthUDJnR3lyUTFQdGdEV29Ub2NtSWpQWFJmTi9SZ0NaUlVTY3NwVGY4ZW8w?=
 =?utf-8?B?SEphd3lNYzVjRmhxWU5zRVJaYm9pbUdXK00vOExGV2ZLcUJTV2I3bUp1YmUr?=
 =?utf-8?B?WlVUZXhZaXZYRERENTRrNnhSR0dTUG1hVHRqemdrTHBlWFYzeVR4UzV6S2l4?=
 =?utf-8?B?TUR4QzRFTUpVQUZtT0x6ZnQ4RUE1ZkhCL3FxNGNZWDZQWlc1N2J3UC96bEVq?=
 =?utf-8?B?R0RiWXhFUERTUmx1K0FBdVBEcXFkUTFHN2xHVXpZdkRGSHUvQkYweDVWR0lI?=
 =?utf-8?Q?X6G8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2ED489DC409C654CB6478BC0C948BD2F@amdcloud.onmicrosoft.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 608fffdd-29b1-4c12-3c45-08dc52c07609
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Apr 2024 02:56:14.7244 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bEoqYvGkjhQztu5f0T/OUNXVlhakilMwllnskTCDokCKFvTDA2PtGFk5tDzemkMeFGCNCz3d5+ah121szERELQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4144
Received-SPF: permerror client-ip=40.107.220.121;
 envelope-from=Jiqian.Chen@amd.com;
 helo=NAM11-CO1-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

T24gMjAyNC8zLzI5IDE4OjM4LCBKYXNvbiBXYW5nIHdyb3RlOg0KPiBPbiBGcmksIE1hciAyOSwg
MjAyNCBhdCA0OjAw4oCvUE0gQ2hlbiwgSmlxaWFuIDxKaXFpYW4uQ2hlbkBhbWQuY29tPiB3cm90
ZToNCj4+DQo+PiBPbiAyMDI0LzMvMjkgMTU6MjAsIEphc29uIFdhbmcgd3JvdGU6DQo+Pj4gT24g
RnJpLCBNYXIgMjksIDIwMjQgYXQgMzowN+KAr1BNIENoZW4sIEppcWlhbiA8SmlxaWFuLkNoZW5A
YW1kLmNvbT4gd3JvdGU6DQo+Pj4+DQo+Pj4+IE9uIDIwMjQvMy8yOCAyMDozNiwgTWljaGFlbCBT
LiBUc2lya2luIHdyb3RlOg0KPj4+Pj4+Pj4gK30NCj4+Pj4+Pj4+ICsNCj4+Pj4+Pj4+ICBzdGF0
aWMgdm9pZCB2aXJ0aW9fcGNpX2J1c19yZXNldF9ob2xkKE9iamVjdCAqb2JqKQ0KPj4+Pj4+Pj4g
IHsNCj4+Pj4+Pj4+ICAgICAgUENJRGV2aWNlICpkZXYgPSBQQ0lfREVWSUNFKG9iaik7DQo+Pj4+
Pj4+PiAgICAgIERldmljZVN0YXRlICpxZGV2ID0gREVWSUNFKG9iaik7DQo+Pj4+Pj4+Pg0KPj4+
Pj4+Pj4gKyAgICBpZiAodmlydGlvX3BjaV9ub19zb2Z0X3Jlc2V0KGRldikpIHsNCj4+Pj4+Pj4+
ICsgICAgICAgIHJldHVybjsNCj4+Pj4+Pj4+ICsgICAgfQ0KPj4+Pj4+Pj4gKw0KPj4+Pj4+Pj4g
ICAgICB2aXJ0aW9fcGNpX3Jlc2V0KHFkZXYpOw0KPj4+Pj4+Pj4NCj4+Pj4+Pj4+ICAgICAgaWYg
KHBjaV9pc19leHByZXNzKGRldikpIHsNCj4+Pj4+Pj4+IEBAIC0yNDg0LDYgKzI1MTEsOCBAQCBz
dGF0aWMgUHJvcGVydHkgdmlydGlvX3BjaV9wcm9wZXJ0aWVzW10gPSB7DQo+Pj4+Pj4+PiAgICAg
ICAgICAgICAgICAgICAgICBWSVJUSU9fUENJX0ZMQUdfSU5JVF9MTktDVExfQklULCB0cnVlKSwN
Cj4+Pj4+Pj4+ICAgICAgREVGSU5FX1BST1BfQklUKCJ4LXBjaWUtcG0taW5pdCIsIFZpcnRJT1BD
SVByb3h5LCBmbGFncywNCj4+Pj4+Pj4+ICAgICAgICAgICAgICAgICAgICAgIFZJUlRJT19QQ0lf
RkxBR19JTklUX1BNX0JJVCwgdHJ1ZSksDQo+Pj4+Pj4+PiArICAgIERFRklORV9QUk9QX0JJVCgi
eC1wY2llLXBtLW5vLXNvZnQtcmVzZXQiLCBWaXJ0SU9QQ0lQcm94eSwgZmxhZ3MsDQo+Pj4+Pj4+
PiArICAgICAgICAgICAgICAgICAgICBWSVJUSU9fUENJX0ZMQUdfUE1fTk9fU09GVF9SRVNFVF9C
SVQsIGZhbHNlKSwNCj4+Pg0KPj4+IFdoeSBkb2VzIGl0IGNvbWUgd2l0aCBhbiB4IHByZWZpeD8N
Cj4+IFNvcnJ5LCBpdCdzIG15IG1pc3VuZGVyc3RhbmRpbmcgb2YgdGhpcyBwcmVmaXgsIGlmIE5v
X1NvZnRfUmVzZXQgZG9lc24ndCBuZWVkIHRoaXMgcHJlZml4LCBJIHdpbGwgZGVsZXRlIGl0IGlu
IG5leHQgdmVyc2lvbi4NCj4+IERvZXMgeCBwcmVmaXggbWVhbnMgY29tcGF0IG1hY2hpbmVyeT8g
T3Igb3RoZXIgbWVhbmluZ3M/DQo+Pg0KPj4+DQo+Pj4+Pj4+PiAgICAgIERFRklORV9QUk9QX0JJ
VCgieC1wY2llLWZsci1pbml0IiwgVmlydElPUENJUHJveHksIGZsYWdzLA0KPj4+Pj4+Pj4gICAg
ICAgICAgICAgICAgICAgICAgVklSVElPX1BDSV9GTEFHX0lOSVRfRkxSX0JJVCwgdHJ1ZSksDQo+
Pj4+Pj4+PiAgICAgIERFRklORV9QUk9QX0JJVCgiYWVyIiwgVmlydElPUENJUHJveHksIGZsYWdz
LA0KPj4+Pj4+Pg0KPj4+Pj4+PiBJIGFtIGEgYml0IGNvbmZ1c2VkIGFib3V0IHRoaXMgcGFydC4N
Cj4+Pj4+Pj4gRG8geW91IHdhbnQgdG8gbWFrZSB0aGlzIHNvZnR3YXJlIGNvbnRyb2xsYWJsZT8N
Cj4+Pj4+PiBZZXMsIGJlY2F1c2UgZXZlbiB0aGUgcmVhbCBoYXJkd2FyZSwgdGhpcyBiaXQgaXMg
bm90IGFsd2F5cyBzZXQuDQo+Pj4NCj4+PiBXZSBhcmUgdGFsa2luZyBhYm91dCBlbXVsYXRlZCBk
ZXZpY2VzIGhlcmUuDQo+PiBZZXMsIEkganVzdCBnYXZlIGFuIGV4YW1wbGUuIEl0IGFjdHVhbGx5
IHRoaXMgYml0IGlzIG5vdCBhbHdheXMgc2V0LiBXaGF0J3MgeW91ciBvcGluaW9uIGFib3V0IHdo
ZW4gdG8gc2V0IHRoaXMgYml0IG9yIHdoaWNoIHZpcnRpby1kZXZpY2Ugc2hvdWxkIHNldCB0aGlz
IGJpdD8NCj4gDQo+IElmIHRoZSBpbXBsZW1lbnRhdGlvbiBvZiBRZW11IGlzIGNvcnJlY3QsIHdl
IHNob3VsZCBzZXQgaXQgdW5sZXNzIHdlDQo+IG5lZWQgY29tcGF0aWJpbGl0eS4NCk9rLCBJIHdp
bGwgc2V0IGl0IGRlZmF1bHQgdG8gdHJ1ZSBpbiBuZXh0IHZlcnNpb24uDQpJZiB3ZSBuZWVkIGNv
bXBhdGliaWxpdHksIHdoYXQncyB5b3VyIG9waW5pb24gYWJvdXQgd2hpY2ggbWFjaGluZSB0eXBl
cyBzaG91bGQgd2UgY29tcGF0aWJsZSB3aXRoPyBEb2VzIHRoZSBzYW1lIGFzIHgtcGNpZS1wbS1p
bml0Pw0KPiANCj4+DQo+Pj4NCj4+Pj4+DQo+Pj4+PiBTbyB3aGljaCB2aXJ0aW8gZGV2aWNlcyBz
aG91bGQgYW5kIHdoaWNoIHNob3VsZCBub3Qgc2V0IHRoaXMgYml0Pw0KPj4+PiBUaGlzIGRlcGVu
ZHMgb24gdGhlIHNjZW5hcmlvIHRoZSB2aXJ0aW8tZGV2aWNlIGlzIHVzZWQsIGlmIHdlIHdhbnQg
dG8gdHJpZ2dlciBhbiBpbnRlcm5hbCBzb2Z0IHJlc2V0IGZvciB0aGUgdmlydGlvLWRldmljZSBk
dXJpbmcgUzMsIHRoaXMgYml0IHNob3VsZG4ndCBiZSBzZXQuDQo+Pj4NCj4+PiBJZiB0aGUgZGV2
aWNlIGRvZXNuJ3QgbmVlZCByZXNldCwgd2h5IGJvdGhlciB0aGUgZHJpdmVyIGZvciB0aGlzPw0K
Pj4gSSBkb24ndCBrbm93IHdoYXQgeW91IG1lYW4uDQo+PiBJZiB0aGUgZGV2aWNlIGRvZXNuJ3Qg
bmVlZCByZXNldCwgd2UgY2FuIGNvbmZpZyB0cnVlIHRvIHNldCB0aGlzIGJpdCwgdGhlbiBvbiB0
aGUgZHJpdmVyIHNpZGUsIGRyaXZlciBmaW5kcyB0aGlzIGJpdCBpcyBzZXQsIHRoZW4gZHJpdmVy
IHdpbGwgbm90IHRyaWdnZXIgYSBzb2Z0IHJlc2V0Lg0KPiANCj4gSSBtZWFuIGlmIHRoZSBkZXZp
Y2UgY2FuIHN1c3BlbmQgd2l0aG91dCByZXNldCwgd2UgZG9uJ3QgbmVlZCB0bw0KPiBib3RoZXIg
dGhlIGRyaXZlciB0byBzYXZlIGFuZCBsb2FkIHN0YXRlcy4NCj4gDQo+Pg0KPj4+DQo+Pj4gQnR3
LCBub19zb2Z0X3Jlc2V0IGlzIGluc3VmZmljaWVudCBmb3Igc29tZSBjYXNlcywNCj4+IE1heSBJ
IGtub3cgd2hpY2ggY2FzZXM/DQo+Pg0KPj4+IHRoZXJlJ3MgYSBwcm9wb3NhbCBmb3IgdGhlIHZp
cnRpby1zcGVjLiBJIHRoaW5rIHdlIG5lZWQgdG8gd2FpdCB1bnRpbCBpdCBpcyBkb25lLg0KPj4g
Q2FuIHlvdSBzaGFyZSB0aGUgcHJvcG9zYWw/DQo+IA0KPiBTZWUgdGhpcw0KPiANCj4gaHR0cHM6
Ly9sb3JlLmtlcm5lbC5vcmcvYWxsLzIwMjQwMjI3MDE1MzQ1LjM2MTQ5NjUtMS1zdGV2ZW5zZEBj
aHJvbWl1bS5vcmcvVC8NCkkgbG9va2VkIHRoZSBkZXRhaWwgb2YgdGhpcyBwcm9wb3NhbC4NCldo
YXQgdGhlIHByb3Bvc2FsIGRvZXMgaXMgdG8gYWRkIGEgbmV3IHN0YXR1cyB0byB0cmlnZ2VyIGRl
dmljZSB0byBzdXNwZW5kL3Jlc3VtZS4NCkJ1dCB0aGlzIHBhdGNoIGlzIHRvIGFkZCBOb19Tb2Z0
X1Jlc2V0IGJpdCwgaXQgZGVjaWRlcyBpZiB0aGUgZGV2aWNlIHNob3VsZCBiZSByZXNldC4gVGhp
cyBwYXRjaCBkb2Vzbid0IGRlcGVuZCBvbiB0aGUgcHJvcG9zYWwuDQpJZiB5b3UgbWVhbiB0aGF0
IHRoZSBwcm9wb3NhbCBzYXlzICJBIGRldmljZSBNVVNUIG1haW50YWluIGl0cyBzdGF0ZSB3aGls
ZSBzdXNwZW5kZWQiLCBJIHRoaW5rIGl0IG5lZWRzIG5ldyBwYXRjaCB0byBpbXBsZW1lbnQgaXQg
YWZ0ZXIgdGhlIHByb3Bvc2FsIGlzIGRvbmUuDQoNCj4gDQo+IFRoYW5rcw0KPiANCj4+DQo+Pj4N
Cj4+Pj4gSW4gbXkgdXNlIGNhc2Ugb24gbXkgZW52aXJvbm1lbnQsIEkgZG9uJ3Qgd2FudCB0byBy
ZXNldCB2aXJ0aW8tZ3B1IGR1cmluZyBTMywNCj4+Pj4gYmVjYXVzZSBvbmNlIHRoZSBkaXNwbGF5
IHJlc291cmNlcyBhcmUgZGVzdHJveWVkLCB0aGVyZSBhcmUgbm90IGVub3VnaCBpbmZvcm1hdGlv
biB0byByZS1jcmVhdGUgdGhlbSwgc28gdGhpcyBiaXQgc2hvdWxkIGJlIHNldC4NCj4+Pj4gTWFr
aW5nIHRoaXMgYml0IHNvZnR3YXJlIGNvbnRyb2xsYWJsZSBpcyBjb252ZW5pZW50IGZvciB1c2Vy
cyB0byB0YWtlIHRoZWlyIG93biBjaG9pY2VzLg0KPj4+DQo+Pj4gVGhhbmtzDQo+Pj4NCj4+Pj4N
Cj4+Pj4+DQo+Pj4+Pj4+IE9yIHNob3VsZCB0aGlzIGJlIHNldCB0byB0cnVlIGJ5IGRlZmF1bHQg
YW5kIHRoZW4NCj4+Pj4+Pj4gY2hhbmdlZCB0byBmYWxzZSBmb3Igb2xkIG1hY2hpbmUgdHlwZXM/
DQo+Pj4+Pj4gSG93IGNhbiBJIGRvIHNvPw0KPj4+Pj4+IERvIHlvdSBtZWFuIHNldCB0aGlzIHRv
IHRydWUgYnkgZGVmYXVsdCwgYW5kIGlmIG9sZCBtYWNoaW5lIHR5cGVzIGRvbid0IG5lZWQgdGhp
cyBiaXQsIHRoZXkgY2FuIHBhc3MgZmFsc2UgY29uZmlnIHRvIHFlbXUgd2hlbiBydW5uaW5nIHFl
bXU/DQo+Pj4+Pg0KPj4+Pj4gTm8sIHlvdSB3b3VsZCB1c2UgY29tcGF0IG1hY2hpbmVyeS4gU2Vl
IGhvdyBpcyB4LXBjaWUtZmxyLWluaXQgaGFuZGxlZC4NCj4+Pj4+DQo+Pj4+Pg0KPj4+Pg0KPj4+
PiAtLQ0KPj4+PiBCZXN0IHJlZ2FyZHMsDQo+Pj4+IEppcWlhbiBDaGVuLg0KPj4+DQo+Pg0KPj4g
LS0NCj4+IEJlc3QgcmVnYXJkcywNCj4+IEppcWlhbiBDaGVuLg0KPiANCg0KLS0gDQpCZXN0IHJl
Z2FyZHMsDQpKaXFpYW4gQ2hlbi4NCg==

