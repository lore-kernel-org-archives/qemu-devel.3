Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FB40C54E67
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Mar 2024 09:03:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rplei-0003TR-QJ; Thu, 28 Mar 2024 05:02:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Jiqian.Chen@amd.com>)
 id 1rpleh-0003TH-GK
 for qemu-devel@nongnu.org; Thu, 28 Mar 2024 05:02:39 -0400
Received: from mail-dm6nam11on20600.outbound.protection.outlook.com
 ([2a01:111:f403:2415::600]
 helo=NAM11-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Jiqian.Chen@amd.com>)
 id 1rplec-0001Xb-MF
 for qemu-devel@nongnu.org; Thu, 28 Mar 2024 05:02:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g2NFYrGVK5nvoU+c75UbFLdScYvuNQCUwrFNCsw00Y6iyZAMk+BsdIW/obfX9SyHF+PcvoO8bOoip2y7x03LfM5ZbkDAFxdosxc9VvyixFY+4ho3uHaEqryGPd6g20V6IaUk9wzrFFodywTbBnA4NaeaYrAVNjU0/8RDRcNahZPY4XVwQCLZb/TxXpwRestE0ca3RqmTlUxn0N/ka/kQZBM/uaASjtRCyL9ZrAp7RqBUMHCTrXp8mW2L0DslpjIgm3zNmxDKF8Ibmn5QkHUnhDnKM/mIlbK3gxkBBhZhUk7txUR7k9mbRCjluh1dyIm/uKpChg9FYY/xANMIir6tbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QXZkcpxKFtWo5TUDVZ7upG2CZ3dhwCE03BxBOvj0ssg=;
 b=UKphC79HkvTHwC4Q3kOKAU1BFnjmTlcurigFEG2/x9i+Mn+U7nUVKqiGY6FR6PyL8p8BsWWPRdVAhUqA5vDpufpnRBdiRnDU4wjMK9oX8/D8tDqVv9X2ZcO1eS0xpGPAn1VNXb1x7AqhPDVGO5ZuGoLK41WKzmT+TqJSnQh2lzQ1TzvN5Rx7f+1a3mZa4plEbLsK4j8lVW+Ald9gaqIFvfx7B7NNmBvcPyHvSihRZCLJZ7vdwPYMZ3mxzOqouveIjsZYmsAzUsTMxoHpPo95sL9QwFaPLdVcF50QTj20xaRXOiVtc537gV6bkqSjzXKQXjTZy99yRdFurlL0BbiT+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QXZkcpxKFtWo5TUDVZ7upG2CZ3dhwCE03BxBOvj0ssg=;
 b=ECQUVhTrlv8dnOWsjjFI+YwtbsUUSVlZGP5RquLA7gcVftCkbE/Kw34UZyDE2S9YdHO8tnX+g4Ugg9bt2zAYM8AMP1cAZxpXiVCavUlTUHyuIOf38jzKf/mkl21ENmBpwFqLj2FDgrb3N+WelO0h2SG/VM5//wBDDFBvx3s9sQ8=
Received: from BL1PR12MB5849.namprd12.prod.outlook.com (2603:10b6:208:384::18)
 by SJ0PR12MB6832.namprd12.prod.outlook.com (2603:10b6:a03:47e::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.33; Thu, 28 Mar
 2024 09:02:28 +0000
Received: from BL1PR12MB5849.namprd12.prod.outlook.com
 ([fe80::debf:178c:f5df:5efa]) by BL1PR12MB5849.namprd12.prod.outlook.com
 ([fe80::debf:178c:f5df:5efa%6]) with mapi id 15.20.7409.031; Thu, 28 Mar 2024
 09:02:28 +0000
From: "Chen, Jiqian" <Jiqian.Chen@amd.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "Huang, Ray"
 <Ray.Huang@amd.com>, "Chen, Jiqian" <Jiqian.Chen@amd.com>
Subject: Re: [RFC QEMU PATCH v7 1/1] virtio-pci: implement No_Soft_Reset bit
Thread-Topic: [RFC QEMU PATCH v7 1/1] virtio-pci: implement No_Soft_Reset bit
Thread-Index: AQHafoMhZ4XQd/U9wkqB2PJdFlPRUrFM0gWAgACQ+QA=
Date: Thu, 28 Mar 2024 09:02:28 +0000
Message-ID: <BL1PR12MB5849CC32915B97625156EAF7E73B2@BL1PR12MB5849.namprd12.prod.outlook.com>
References: <20240325070724.574508-1-Jiqian.Chen@amd.com>
 <20240325070724.574508-2-Jiqian.Chen@amd.com>
 <20240328034641-mutt-send-email-mst@kernel.org>
In-Reply-To: <20240328034641-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-imapappendstamp: BL3PR12MB6425.namprd12.prod.outlook.com
 (15.20.7292.000)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5849:EE_|SJ0PR12MB6832:EE_
x-ms-office365-filtering-correlation-id: cb9da5ff-0ea4-499d-71ec-08dc4f05cb90
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9wQNynTmaYVtytkHsnnXnucvIOl6X0iudKc4SE/ahyGYpvqY2Q3vS1K3HB5/smhWxgz0l5QWiINYDC3Qf1CKuH9gfL5NB1va+JLauBlelau2hvONUSgQ/fHU0hKdeqUs6+E64XwE2ogdOcRRnEdVli0y2g5w9bSe+BD5Suet3kFTPy0wGWRPlUSZTsA8JyMT8i46Wc526nx/iiGaLAvNs+dZI5CjtEhnhvdgNYxHZYOxHS6CWjMpb7H65DRoqlvBUNzNMOYrmEc53plE16uLegZ4G5LaEaXLJvS7cPACiQ4K9GrsRqUIQo4/mG27qCfFwwaSwCVyFLpTa62v8cIklEiesgVYypAqzoznT3EYjYsujr5x19B7ZTmdCdGv6ydA5VHMqejjmE3NORhS7+pWVhbdRBlEjC1uOK18YJRkcXkbz+9av2nww8cihs3bylq+E3Fmkd7kSKadoY/jk0h8V9u5OE1Q4GDhOLd+0V4B0Q0Y0s9lbTet7UMimyTN5PKty5DdgDrkXPoXXktykIPsWi+X3aJk9l8Guux8uRyxqLm+OIdgaA/p60X5IhETa1jHDtT2Nc/Er39pOpV4xvPfVeEFP9UxdE0vbAPINYFj713G+DP2PM2eUTVAT/THdw4ogEYwHCBX8WDq1t5mmyfYCI/+jo8ILRj91BR18jbi+VFh6hMRU5vGpdp0VBkByeXnQ1rL3HNm0XGnL4iRJ4uyVg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5849.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(1800799015)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bC9KblNGaC9LdmMxR0xnQ21WdUpldTFtMEtzem9nWDk2Zm1lbVhhb255WEUr?=
 =?utf-8?B?ZkpyU3A4Mk0yclRkUkltenArcWZieGcwMFVWL0xtWnJYNXZkRXdsRjkvRXdT?=
 =?utf-8?B?anFwcmJ4SjJ1NGxoOUprdklSVmJySlpZRlhGekRkbUphUzM4emV5SXRDMEMy?=
 =?utf-8?B?SlhzRnhXTHhXV3h0S2dOTlZRWnBFd1d6SmZ5dXNpSS82ZG16K25IeThWMmlZ?=
 =?utf-8?B?b0JteUZBVG5IQWNHSmJUZWZRbisydXp3WEZjUzYzeG90WDM5UzlsNnBJeG1r?=
 =?utf-8?B?U0dWZmQ3dmNManFiUmh1ajdhaWZwNjZ2ZTcxOUUrWHNXd3BXZGxuSVkwR09P?=
 =?utf-8?B?ajVLOEhHS0RiU2txcHBVcGFaY2VNc0pwa2JPbXp5c2JacGM1ZUxKQjN3WTJK?=
 =?utf-8?B?dUxqOUx3WlI1UFpBOE1pU0h6Zi91UVFUZnczNjFhL0JVMDJFNEs4emUySVJy?=
 =?utf-8?B?cWlqOXk3VmdtSXd2M2xGODJKc1I3cHFsdU9GejdWR1FKb0ZCMjRTNzIwQTdC?=
 =?utf-8?B?eVVkc0YxMGNQaDdOMTZOT3hLZm1NVUZKTmtMTjBFUXlYTlBDWklsT3l6SmVF?=
 =?utf-8?B?QTJqRXdkaHlvK3FjL3RUMVh6SEJNeTJKdzhpOUR5ZElPZHhKVUJ2R0lldDZt?=
 =?utf-8?B?RkRKOU9wTlZ1QW54Z0ZhS0VVTDNVSEhweGVQZG5hR2tIelpzaW44TzdkekVp?=
 =?utf-8?B?bVhjakhGZnUrNWxwTG4xODBTNk53bU9CRmlhWWoxTmJZM1JXK0tWbXlVb1BR?=
 =?utf-8?B?NGJRL3hjRjJuNzBUVDdxU0tjVFZXQmQ0S2VtVGZuellkSVVNRkJVR3FIMlhq?=
 =?utf-8?B?aWl5MGNoalJqbVdVcnJ4SjdYLzA2Y1Zqa2dNTitIR3lHM0JNS0NRYW1kWUdM?=
 =?utf-8?B?ZFVCTXd4Nmd4SCthVGJhbUg4MkI1aldwODBsbEhsUG5wMm0wT0NLZGgyTWVU?=
 =?utf-8?B?Rmg1bE9xS1UvRVdzTlliQm5jdytHY2xKWmxlYmVYbEtUaG1aNksrRVJYOGFU?=
 =?utf-8?B?TEZmMFllM2tWZTNiaGJzNmtiQnExQmpGdndDQTZuNzM5cEZMem1POGtSRkVu?=
 =?utf-8?B?bjF0aFkyRmY5WW42d3FZMjAzUVB3K05RYWZjNTFsVXJteVVmRnMvb2VnSzFu?=
 =?utf-8?B?Q0syZit1bXZJeDRKRTlKd2lwT2RNR1M2WFZMTi9GdGwrOXZKWXpmWkhRUitt?=
 =?utf-8?B?TUpSeTRXWW1udjBRbTNiK2RMZ3pkWExyMzJCb3c1aEdLeGhQZFlTWHpNNGFr?=
 =?utf-8?B?WGtVZ0NCQ1RFaXlNNkVNUE8wZkZDNllRdHg5VzhHa0NEQk4xYnJUS2RMSy9X?=
 =?utf-8?B?SjZuTldjd2hYOXF5V3dhbzNOZEUyekplN3VLdExWNjJVYmk1SExUSDRxYTVG?=
 =?utf-8?B?RkZhR2Qwa2hyakpBSzhmYTE3YUlESnA5dTcxZjIxU2d3a2lsazZpajU3TjIz?=
 =?utf-8?B?RkxhSGw0blJFZXpPWXVQd2wxTnphSG4wU2U1dkYxMGlGdmVpUHoyZTdmWVln?=
 =?utf-8?B?MTJSck5tNDhwRjF2OWh2ZTc1c0JiWWhBcVBmZW1IZmZYREJ1TmRPRnNVYzFo?=
 =?utf-8?B?ZGYxYlRRT0llUXc4eUUySnRLQTk0SFh1eDdCeXZnQ0wxMHlUT21XUXZhZVJR?=
 =?utf-8?B?ZTZyUDAzTG5UdGtwZ2xDMXptdUNzMnlOQTkrRVRhdTNobW9FYzdrQ3gxZkdZ?=
 =?utf-8?B?TVZSS1NncTU2b21WNkVZQTZ6UFNybDMxbmtETURnR0FKbzNrZXZOazg4VmhZ?=
 =?utf-8?B?SklEMWpNMXFsNDdMQ3I2cXJlYmtZMGZ2MmM2elRaNlR2R2hvOGRiLzNsSCtF?=
 =?utf-8?B?Y0FLb3huOWd6SVR5TWRweWx1UTNKWmFsOWZtY1VSZjkxNk1tM1MvVGF5SDVp?=
 =?utf-8?B?ZnNaSGJUYTRXYnBJd3hlYTFQMHdzeEZ4dUxYMWhyaUR6RzEyVndhSDBpUFVr?=
 =?utf-8?B?aVNWUEZKQlVMWjFxbjBnK3h6R3NlY0ZRR2JpaVpsaEg1UnArV1htWk9QamJE?=
 =?utf-8?B?M2UxMDFBQ2Z5K25ZdDBIdTU2NEQzK2dhalRSSW5OdXpoYkxyRm9MQm9ZZ0xw?=
 =?utf-8?B?TGtjYVhhSldIbE9HUGFLSDMzYkpuWG11eDlGMk04N1dtUFlXTXBHbjZEaGpU?=
 =?utf-8?Q?6Dlk=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AF634748A1122744872E7E061A09FA02@amdcloud.onmicrosoft.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb9da5ff-0ea4-499d-71ec-08dc4f05cb90
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Mar 2024 09:02:28.8227 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rHuNDU8tsafTA9F6vvx0rA0Uav1fWcUOZ3jV/qtChXchkk81Smg6DYeEDJ+psmNNzIQOo7x7o6mdOOv+tIzldg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6832
Received-SPF: permerror client-ip=2a01:111:f403:2415::600;
 envelope-from=Jiqian.Chen@amd.com;
 helo=NAM11-DM6-obe.outbound.protection.outlook.com
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

DQpPbiAyMDI0LzMvMjggMTY6MTEsIE1pY2hhZWwgUy4gVHNpcmtpbiB3cm90ZToNCj4gDQo+PiAr
ICAgICAgICBWaXJ0SU9QQ0lQcm94eSAqcHJveHkgPSBWSVJUSU9fUENJKGRldik7DQo+PiArDQo+
PiAgICAgICAgICBwY2llX2NhcF9kZXZlcnJfcmVzZXQoZGV2KTsNCj4+ICAgICAgICAgIHBjaWVf
Y2FwX2xua2N0bF9yZXNldChkZXYpOw0KPj4gIA0KPj4gLSAgICAgICAgcGNpX3NldF93b3JkKGRl
di0+Y29uZmlnICsgZGV2LT5leHAucG1fY2FwICsgUENJX1BNX0NUUkwsIDApOw0KPj4gKyAgICAg
ICAgaWYgKHByb3h5LT5mbGFncyAmIFZJUlRJT19QQ0lfRkxBR19QTV9OT19TT0ZUX1JFU0VUKSB7
DQo+PiArICAgICAgICAgICAgdmFsIHw9IFBDSV9QTV9DVFJMX05PX1NPRlRfUkVTRVQ7DQo+PiAr
ICAgICAgICB9DQo+PiArICAgICAgICBwY2lfc2V0X3dvcmQoZGV2LT5jb25maWcgKyBkZXYtPmV4
cC5wbV9jYXAgKyBQQ0lfUE1fQ1RSTCwgdmFsKTsNCj4gDQo+IA0KPiBUaGVyZSBpcyBubyBuZWVk
IHRvIGRvIGl0IGxpa2UgdGhpcyAtIG9ubHkgc3RhdGUgaXMgd3JpdGVhYmxlDQo+IGFueXdheS4g
U28gc2ltcGx5DQo+IAlwY2lfd29yZF90ZXN0X2FuZF9jbGVhcl9tYXNrKGRldi0+Y29uZmlnICsg
ZGV2LT5leHAucG1fY2FwICsgUENJX1BNX0NUUkwsIFBDSV9QTV9DVFJMX1NUQVRFX01BU0spDQo+
IA0KPiANCj4gbWF5YmUgd2Ugc2hvdWxkIGFjdHVhbGx5IGNoZWNrIGhlcmU6DQo+ICAgICAgICBp
ZiAocHJveHktPmZsYWdzICYgVklSVElPX1BDSV9GTEFHX0lOSVRfUE0pDQo+IHRoZXJlJ3MgYSBj
aGFuY2UgY29tbWl0IDI3Y2UwZjNhZmM5IGJyb2tlIHRoaW5ncyBmb3Igb2xkIG1hY2hpbmVzDQo+
IGFuZCB3ZSBuZXZlciBub3RpY2VkLiBJZiBzbyB0aGF0IHNob3VsZCBiZSBhIHNlcGFyYXRlIGJ1
Z2ZpeCBwYXRjaCB0aG91Z2guDQpNYWtlIHNlbnNlLiBJdCBpcyBhY3R1YWxseSBhIGJ1ZyBpbXBv
cnRlZCBieSAyN2NlMGYzYWZjOS4NCkFjY29yZGluZyB0byB5b3VyIGNvbW1lbnRzLCBJIHRoaW5r
IGhlcmUgc2hvdWxkIGJlIGEgc2VwYXJhdGUgcGF0Y2gsIGxpa2U6DQogICBpZiAocGNpX2lzX2V4
cHJlc3MoZGV2KSkgew0KICAgICAgICBWaXJ0SU9QQ0lQcm94eSAqcHJveHkgPSBWSVJUSU9fUENJ
KGRldik7DQoNCiAgICAgICAgcGNpZV9jYXBfZGV2ZXJyX3Jlc2V0KGRldik7DQogICAgICAgIHBj
aWVfY2FwX2xua2N0bF9yZXNldChkZXYpOw0KDQogICAgICAgIGlmIChwcm94eS0+ZmxhZ3MgJiBW
SVJUSU9fUENJX0ZMQUdfSU5JVF9QTSkgew0KICAgICAgICAgICAgcGNpX3dvcmRfdGVzdF9hbmRf
Y2xlYXJfbWFzaygNCiAgICAgICAgICAgICAgICBkZXYtPmNvbmZpZyArIGRldi0+ZXhwLnBtX2Nh
cCArIFBDSV9QTV9DVFJMLA0KICAgICAgICAgICAgICAgIFBDSV9QTV9DVFJMX1NUQVRFX01BU0sp
Ow0KICAgICAgICB9DQogICAgfQ0KUmlnaHQ/DQoNCj4gDQo+IA0KDQotLSANCkJlc3QgcmVnYXJk
cywNCkppcWlhbiBDaGVuLg0K

