Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C38FFCA16D
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 18:34:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzfQd-0006PA-PO; Mon, 09 Mar 2026 14:34:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vzfQY-0006OA-75; Mon, 09 Mar 2026 14:34:03 -0400
Received: from mail-westus3azlp170100009.outbound.protection.outlook.com
 ([2a01:111:f403:c107::9] helo=PH7PR06CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vzfQV-0002sJ-4Y; Mon, 09 Mar 2026 14:34:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aUa1OH9NzoKaHawv5nm6rgnvVDXMxhvj4zY29MuFCxAJyM76qg6vfWtwT1KY3CAFm9KsMqeeg1u0SVQUiMwRAlP5YMya5wtILM0zK5xhTZtyb4tVgGETVkMvkjlCauoKFxPfb795UTFU/4EDLELzYD/owJJU8VL1zDnIZ4IuEVEc4ISO2v9VBYPGMu2pkgQuntjRKixD+TkVr96eRmo7i399ybjQLkHsrYDlGEAmLTB9B9NJ3+sK9iwwxbpsW71nfyy4Dinw0DN8veKJRXxIumB0CYjOl1XJuUA0xJw6TVdWxU3JnnDJT3XCwf7oTc9lcFoCioVBnDH32xFMRPRGJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qa2sN8VItNq2YFTvkODsdoBmnCJKxH7lWercSwXrt9Y=;
 b=vpgVJOMi/LBtFYfLOvVtPA6BvGsradbkYjSOOHpdp7l8HBEKFTYFjQiW40blQOPcfDftKskT7LcT+qiMXRBt+0O0dlAEvf1txtWdqNNObzmZqTx3oZm7c375e9oa5I9u+n4Az3AWnw5jrO7P+/Adjaz6Aw3VD4H44dKatdgbOhHvqlcmloHb9M9JPueKTfVCKvh00f/Zccam1n3COB5uYVoxY7LAeq+CGuvmdr42IU7KKBNGBWBKwnufCTxI/aqailmt1vCAwWaQ/xPlKY3LdsaPlwqkqZtp6dqOux0s5eBj+6/jjlyrRigB40eecxmT3htH9jVMXl53wMV39KmUwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qa2sN8VItNq2YFTvkODsdoBmnCJKxH7lWercSwXrt9Y=;
 b=B3/qgtW3zplyKZldwtihdMsvYsgIXV9FjcZfZ82KHLswaBeRQjrBi73h0cPMwmkpww8lllSoqotmbuUWpd+fwEPozM8zyYIq+MRej790J8C0ScE8Rbvb2DTdUv/gyBS+9vGN6/IDpJOv1U1Dk6NEOc1Yrf0zljm78xXJwklxAWhevNKuaqPhLASLHPdHLiXsOP3BVd9qHC4uwfcUwnZMO0zA7+XPiy8z1XA7ER5k++9PQM1mN/dkdp83hwjmidI9d0Rl/IbQSimJXXQfOeyMiz5nTqIMvlu8CbnKlkBViAEu7Jsb6TPPw+Dr0QZUmvltTofqeWyx1wK6g3go4I+BNA==
Received: from CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
 by PH8PR12MB6673.namprd12.prod.outlook.com (2603:10b6:510:1c0::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Mon, 9 Mar
 2026 18:33:53 +0000
Received: from CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de]) by CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de%5]) with mapi id 15.20.9700.010; Mon, 9 Mar 2026
 18:33:52 +0000
From: Shameer Kolothum Thodi <skolothumtho@nvidia.com>
To: "eric.auger@redhat.com" <eric.auger@redhat.com>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "peter.maydell@linaro.org" <peter.maydell@linaro.org>, "clg@redhat.com"
 <clg@redhat.com>, "alex@shazbot.org" <alex@shazbot.org>, Nicolin Chen
 <nicolinc@nvidia.com>, Nathan Chen <nathanc@nvidia.com>, Matt Ochs
 <mochs@nvidia.com>, Jiandi An <jan@nvidia.com>, Jason Gunthorpe
 <jgg@nvidia.com>, "jonathan.cameron@huawei.com"
 <jonathan.cameron@huawei.com>, "zhangfei.gao@linaro.org"
 <zhangfei.gao@linaro.org>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>, Krishnakant Jaju <kjaju@nvidia.com>,
 "phrdina@redhat.com" <phrdina@redhat.com>
Subject: RE: [PATCH v3 28/32] hw/arm/smmuv3: Add per-device identifier property
Thread-Topic: [PATCH v3 28/32] hw/arm/smmuv3: Add per-device identifier
 property
Thread-Index: AQHcpw4svc/RJvkwH0qFJw8rUKTGE7WmlU4AgAABA4A=
Date: Mon, 9 Mar 2026 18:33:52 +0000
Message-ID: <CH3PR12MB7548E1470C30CC9D5876BB03AB79A@CH3PR12MB7548.namprd12.prod.outlook.com>
References: <20260226105056.897-1-skolothumtho@nvidia.com>
 <20260226105056.897-29-skolothumtho@nvidia.com>
 <fb8c82d1-38e7-446a-9b04-8b2879eb181e@redhat.com>
In-Reply-To: <fb8c82d1-38e7-446a-9b04-8b2879eb181e@redhat.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB7548:EE_|PH8PR12MB6673:EE_
x-ms-office365-filtering-correlation-id: 28aef0b8-a557-4a34-18ec-08de7e0a6a14
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|7416014|1800799024|366016|38070700021; 
x-microsoft-antispam-message-info: 63Pr7Um45YylfezVAO7rHWchrGlXS5LobKkrfQHX/xvsrh0k1Y7GH843DOzWgsyguZpQZ7iQB9kcPDTsdx5ICayHkPukI8ZREhxO86EFOW9pM55w13Shx6QmlJVIDQd5aydCklD+O2U5VASZoqKtP+fR6X2stspqpUI19/wya+/fq4i5vAe7MVorDOavwzBLc5dAeA/9Am0zCcv8umIDYjkG6e7JDaPORHz+n92YV/DDXd74y0uhnGuVzY58x/QSnvTxb+b3emthmsBUEbkeQhje2zqacu7cSPKGnzEPv5/mteeVT7E3vZvmBE1GJ3eHBNNeq2ipyUXmhL5Tpw7RjJ2Pp/LQA5UFSWK/06DJuUOMztPeqsP8Izv5T3TUNPMT6az2o3CGtDw8I94wQFXAufLp+CdzD2GA1ylalhxrL1ju8MKaiB83/zlgOV0+47/JaQfJy25+qxpD+gjpWb50YxxEaRWDeePl7T/JqKqDbn0ThZVTVCixxCrXf1yptPt32G+CxCarfeQcPV/yLEExwnFw9XC44zAKmYDvUis1dzb4PCuokakrkrXxcW8dbtI22iYoRsYbYp8zC6bYjYLbdY9DDJpxQaDIX3JxF3AqDS0ZWBy3qvFZJtxkblfUT28owZ3NcB+XyywLC9Rlf/CNFkc4S0kPcrAd3KFlnUwNzw5vVvbAM+vqY6m9+DcbS9qVkkvQdsjior4JzgmRxkMi/e2PRTK9VICMFLq5TM6FPxuAySE9uE/TfR7FkW4XhsiVL4B9NNzQDZrE2shEAi/K/onplw7alPr78ea4Rqvpp/o=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB7548.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dEw0K3BtajhuR0orZzVmbkYrUmN3RWtIOVl3RDdlUnpIYklRa2dXcU1PL3A4?=
 =?utf-8?B?MG1SeUpxdlpFZWNGeVNoSVluZzg0TXc3MHYvRDB1VlRXaGZLcXFJSnY2VUJK?=
 =?utf-8?B?dklnUXFOa3ZYOU1Pc1RUVDlkTDIwMXlvcGplandmVGdTSG1qMFl3ZGFzZ0tj?=
 =?utf-8?B?SlRCMDJ6N2hyZWVRRmp0Zmg1ZWdDNGxNcUtSdjBjelRxVm5OLzVYcXNxTWFu?=
 =?utf-8?B?MlQvYm1BamNMWUFqNkc1Z0x5cDMwRWw0cmFSdFJXL3N5ZjM5WE1hWlNUbllR?=
 =?utf-8?B?aFZIWGdqSExrd3dmUzduWEo0Q1BzUTh6Nk9nT3BEVkR0QXZsQ1pWWGQxZzV2?=
 =?utf-8?B?c0FGamZYVDVCdkFyNk9hT3VweEg1TlFWemR2WmdqSjhBUjB0NUUvNkJqenBi?=
 =?utf-8?B?NzBoRHJzb0F2QlZkZlJ6L2ZaMGY1MWVmSHRyZG1LMnIxVXZFalRsdlJHUm9l?=
 =?utf-8?B?MjZOZXR1dW1PUjlCNjU3Qkl4U1FraVVzcytsd3JPTGtwSHBTVTlBMGZZaG9n?=
 =?utf-8?B?M29LUC9XM2R1U01tSjVNQWZNNGhOeTlEWmNNUElOa3RiNW1QMFgyUXZQczUw?=
 =?utf-8?B?QkJzeW4vYnFsd2NwakJoSXJSZUdqb2pwTG56K3dXTXhrOGN4NHpBcWtVS3pv?=
 =?utf-8?B?a09mcmlFY0FmNWJXTVJHVFZXZk9aOTU0L0IxWEEzSHQ2Wm16SGE5UXFjYkdB?=
 =?utf-8?B?Z1NEQUIxcWR0U2hQNHNxSnU1R04yWG8zOVFJN291eG5sUXI0dUFXbEErWWtU?=
 =?utf-8?B?U0lVaG44ZVpLcmtsL25qaHlNQVRmbVlmcHlOMW1aaWFocXcyVUx0aU9KT3pr?=
 =?utf-8?B?RmgrQWVkK05oSFNoY0taNTYwWEQza21aM1lOejQ3NG9LOG0yZDFXQktJOTNL?=
 =?utf-8?B?RElzWm1YMWsrNXNjOWFYSG5ZNW1rRTdpR212MjJQeUlMNUhmVXdJRDI4OWVu?=
 =?utf-8?B?c2tTbFFoM0VjMThVaStsWUZWbjZVSkVuR1JEei8zcmtCQnJOcHBXaVkvN01D?=
 =?utf-8?B?Y1F3dEx3Y1krNUdNanFmMGlTL3Q2MkRTL1loZEV6cjJOdnFES2xjeE1WQ1hV?=
 =?utf-8?B?VTdJTGJFTmFlK3NBNDNGNTlaSFpyQnZnRWV2K1A0dURaeHZ3enV5UjNWdGly?=
 =?utf-8?B?ZTV1Q2RTZXlvTUpKTnd6ODJDcytMSVlRc2hhdXB3RFEwdkJncmhKVzZjY1RI?=
 =?utf-8?B?T3dqT2wvdWM0Tlp3dVFSdWtYd1VmTUx3dHpJSGtsK1VDeGVMaFBuTWdZWG9X?=
 =?utf-8?B?OU5xMjk1REVaNzdIRnFraHIyMFFuNHJXd0ZWbG5oNWtUVmtnMitWYjVhZU5N?=
 =?utf-8?B?MkFPMVNQbzg3RzFRdUdoNWZkVHR5SHhOWnlubHF6dElBcEZJLy9WdGJrMXFs?=
 =?utf-8?B?TEkzNVdhU2RPNE02T0cvYnB2RmZGa2JCZkRwTmFoMUErVjRDN3E3NTNiUjk3?=
 =?utf-8?B?MmdLRmJ5RVV0cFBSZGJUVVpuRzVVbHBCOEhoNWhIWGg2TS9RcjFOMTUydUl0?=
 =?utf-8?B?eGVpZ0ZpWitVL0h3VUNYeitYR0VXT0dBdEtDWVZFcUtXOG15OHp2TzFhMzVi?=
 =?utf-8?B?bTZtWEZDOGUzc1NBcUR3TTFZWEJNOWhYOW5xRC9RTmVWb1VyZFZaeGxlTkNx?=
 =?utf-8?B?VFJ1a0xDc0N6aUpTRnEwS3ViWk9mNXVsVFlnVy9DWC9CZGxVai9lRGJpeFhr?=
 =?utf-8?B?d3lrMUxzVWVuNkY1REg3dzNVYVdYN1F1aENlM0djSGNXcjFaM25wdTBDeTlC?=
 =?utf-8?B?TndiTjZyNWtQc1B1ZUx0S2xjRWVBM0RZaWFMME9LbHQ1SWVCbktBaGRzOFRW?=
 =?utf-8?B?T242SmVuN3ZsUWVGNy9QcjZ1TU9SaFZvZjNEc0Y4YXQzQzZYY3c4UmNBb0Jn?=
 =?utf-8?B?ZXYvdTh6WWJ6MHM4K3J1NUV0NlJsTkRvaDZnUUZWSkxleFFueW8rR2tzTXNK?=
 =?utf-8?B?dnBXMUhVQUpoZkhHdFU2QjNmTWI1ZWdCSDN2M3VFcEg5NGxoWkY1WTB4bGFw?=
 =?utf-8?B?b1dKTlFJRXptM1FGUEw0blN0UjYwUTFWVmdVbUFFa2RoTE9BMEx4OXNFSWNz?=
 =?utf-8?B?bVY3WWlnNHh4OUVvU1R5YkxKMDMrSGdlSG1Makg2ZGcreHNURXZTcm1mUDF4?=
 =?utf-8?B?NEI1eG9IRXVwUDZ0OVJHRXcrdkVSODBIZ3JuU1IxRmYxcll2a2lnWWRKdVpU?=
 =?utf-8?B?cmhVb0p6cE1xVUU3eHRyZGg4akR6YldlUjh4c3NpSzFWZ3hKZXNmazNsR0xx?=
 =?utf-8?B?U1NpQjlVQmRzaGQ4dUFNaUFBRlNXNkpsN042WFViNDhYek0wNDZ3WlBUcWFn?=
 =?utf-8?B?UzZEMXU3b2F5bjcwQXBjSm94RnhheVh3YWFsVTJza0dQV0ZrYUdRdz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7548.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28aef0b8-a557-4a34-18ec-08de7e0a6a14
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Mar 2026 18:33:52.7422 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /d9P5r9fNm4T2ofdpP8GuxFheuxb6+aDrAPcCU3W6OAQ0NYTD+GmKSby4hdZlkksq0lnCiA2N+um92rNh27wgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6673
Received-SPF: permerror client-ip=2a01:111:f403:c107::9;
 envelope-from=skolothumtho@nvidia.com;
 helo=PH7PR06CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogRXJpYyBBdWdlciA8ZXJp
Yy5hdWdlckByZWRoYXQuY29tPg0KPiBTZW50OiAwOSBNYXJjaCAyMDI2IDE4OjIzDQo+IFRvOiBT
aGFtZWVyIEtvbG90aHVtIFRob2RpIDxza29sb3RodW10aG9AbnZpZGlhLmNvbT47IHFlbXUtDQo+
IGFybUBub25nbnUub3JnOyBxZW11LWRldmVsQG5vbmdudS5vcmcNCj4gQ2M6IHBldGVyLm1heWRl
bGxAbGluYXJvLm9yZzsgY2xnQHJlZGhhdC5jb207IGFsZXhAc2hhemJvdC5vcmc7IE5pY29saW4N
Cj4gQ2hlbiA8bmljb2xpbmNAbnZpZGlhLmNvbT47IE5hdGhhbiBDaGVuIDxuYXRoYW5jQG52aWRp
YS5jb20+OyBNYXR0DQo+IE9jaHMgPG1vY2hzQG52aWRpYS5jb20+OyBKaWFuZGkgQW4gPGphbkBu
dmlkaWEuY29tPjsgSmFzb24gR3VudGhvcnBlDQo+IDxqZ2dAbnZpZGlhLmNvbT47IGpvbmF0aGFu
LmNhbWVyb25AaHVhd2VpLmNvbTsNCj4gemhhbmdmZWkuZ2FvQGxpbmFyby5vcmc7IHpoZW56aG9u
Zy5kdWFuQGludGVsLmNvbTsgS3Jpc2huYWthbnQgSmFqdQ0KPiA8a2phanVAbnZpZGlhLmNvbT47
IHBocmRpbmFAcmVkaGF0LmNvbQ0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHYzIDI4LzMyXSBody9h
cm0vc21tdXYzOiBBZGQgcGVyLWRldmljZSBpZGVudGlmaWVyDQo+IHByb3BlcnR5DQo+IA0KPiBF
eHRlcm5hbCBlbWFpbDogVXNlIGNhdXRpb24gb3BlbmluZyBsaW5rcyBvciBhdHRhY2htZW50cw0K
PiANCj4gDQo+IE9uIDIvMjYvMjYgMTE6NTAgQU0sIFNoYW1lZXIgS29sb3RodW0gd3JvdGU6DQo+
ID4gQWRkIGFuICJpZGVudGlmaWVyIiBwcm9wZXJ0eSB0byB0aGUgU01NVXYzIGRldmljZSBhbmQg
dXNlIGl0IHdoZW4NCj4gPiBidWlsZGluZyB0aGUgQUNQSSBJT1JUIFNNTVV2MyBub2RlIElkZW50
aWZpZXIgZmllbGQuDQo+ID4NCj4gPiBUaGlzIGF2b2lkcyByZWx5aW5nIG9uIGRldmljZSBlbnVt
ZXJhdGlvbiBvcmRlciBhbmQgcHJvdmlkZXMgYSBzdGFibGUNCj4gPiBwZXItZGV2aWNlIGlkZW50
aWZpZXIuIEEgc3Vic2VxdWVudCBwYXRjaCB3aWxsIHVzZSB0aGUgc2FtZSBpZGVudGlmaWVyDQo+
ID4gd2hlbiBnZW5lcmF0aW5nIHRoZSBEU0RUIGRlc2NyaXB0aW9uIGZvciBUZWdyYTI0MSBDTURR
ViwgZW5zdXJpbmcgdGhhdA0KPiA+IHRoZSBJT1JUIGFuZCBEU0RUIGVudHJpZXMgcmVmZXIgdG8g
dGhlIHNhbWUgU01NVXYzIGluc3RhbmNlLg0KPiA+DQo+ID4gTm8gZnVuY3Rpb25hbCBjaGFuZ2Ug
aW50ZW5kZWQuDQo+ID4NCj4gPiBSZXZpZXdlZC1ieTogTmljb2xpbiBDaGVuIDxuaWNvbGluY0Bu
dmlkaWEuY29tPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFNoYW1lZXIgS29sb3RodW0gPHNrb2xvdGh1
bXRob0BudmlkaWEuY29tPg0KPiA+IC0tLQ0KPiA+ICBpbmNsdWRlL2h3L2FybS9zbW11djMuaCAg
fCAxICsNCj4gPiAgaHcvYXJtL3NtbXV2My5jICAgICAgICAgIHwgMiArKw0KPiA+ICBody9hcm0v
dmlydC1hY3BpLWJ1aWxkLmMgfCA0ICsrKy0NCj4gPiAgaHcvYXJtL3ZpcnQuYyAgICAgICAgICAg
IHwgMyArKysNCj4gPiAgNCBmaWxlcyBjaGFuZ2VkLCA5IGluc2VydGlvbnMoKyksIDEgZGVsZXRp
b24oLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2h3L2FybS9zbW11djMuaCBiL2lu
Y2x1ZGUvaHcvYXJtL3NtbXV2My5oDQo+ID4gaW5kZXggNjQ4NDEyY2FmYy4uNzNiOGYzOWFhYSAx
MDA2NDQNCj4gPiAtLS0gYS9pbmNsdWRlL2h3L2FybS9zbW11djMuaA0KPiA+ICsrKyBiL2luY2x1
ZGUvaHcvYXJtL3NtbXV2My5oDQo+ID4gQEAgLTYzLDYgKzYzLDcgQEAgc3RydWN0IFNNTVV2M1N0
YXRlIHsNCj4gPiAgICAgIHFlbXVfaXJxICAgICBpcnFbNF07DQo+ID4gICAgICBRZW11TXV0ZXgg
bXV0ZXg7DQo+ID4gICAgICBjaGFyICpzdGFnZTsNCj4gPiArICAgIHVpbnQ4X3QgaWRlbnRpZmll
cjsNCj4gPg0KPiA+ICAgICAgLyogU01NVSBoYXMgSFcgYWNjZWxlcmF0b3Igc3VwcG9ydCBmb3Ig
bmVzdGVkIFMxICsgczIgKi8NCj4gPiAgICAgIGJvb2wgYWNjZWw7DQo+ID4gZGlmZiAtLWdpdCBh
L2h3L2FybS9zbW11djMuYyBiL2h3L2FybS9zbW11djMuYw0KPiA+IGluZGV4IDQ2ODEzNWJiMjQu
LmMxZjg0YmVkZDQgMTAwNjQ0DQo+ID4gLS0tIGEvaHcvYXJtL3NtbXV2My5jDQo+ID4gKysrIGIv
aHcvYXJtL3NtbXV2My5jDQo+ID4gQEAgLTIxMDksNiArMjEwOSw4IEBAIHN0YXRpYyBjb25zdCBQ
cm9wZXJ0eSBzbW11djNfcHJvcGVydGllc1tdID0gew0KPiA+ICAgICAgICogRGVmYXVsdHMgdG8g
c3RhZ2UgMQ0KPiA+ICAgICAgICovDQo+ID4gICAgICBERUZJTkVfUFJPUF9TVFJJTkcoInN0YWdl
IiwgU01NVXYzU3RhdGUsIHN0YWdlKSwNCj4gPiArICAgIC8qIElkZW50aWZpZXIgdXNlZCBmb3Ig
QUNQSSBJT1JUIFNNTVV2MyAoYW5kIERTRFQgZm9yIENNRFFWKQ0KPiBnZW5lcmF0aW9uICovDQo+
ID4gKyAgICBERUZJTkVfUFJPUF9VSU5UOCgiaWRlbnRpZmllciIsIFNNTVV2M1N0YXRlLCBpZGVu
dGlmaWVyLCAwKSwNCj4gPiAgICAgIERFRklORV9QUk9QX0JPT0woImFjY2VsIiwgU01NVXYzU3Rh
dGUsIGFjY2VsLCBmYWxzZSksDQo+ID4gICAgICAvKiBHUEEgb2YgTVNJIGRvb3JiZWxsLCBmb3Ig
U01NVXYzIGFjY2VsIHVzZS4gKi8NCj4gPiAgICAgIERFRklORV9QUk9QX1VJTlQ2NCgibXNpLWdw
YSIsIFNNTVV2M1N0YXRlLCBtc2lfZ3BhLCAwKSwNCj4gPiBkaWZmIC0tZ2l0IGEvaHcvYXJtL3Zp
cnQtYWNwaS1idWlsZC5jIGIvaHcvYXJtL3ZpcnQtYWNwaS1idWlsZC5jDQo+ID4gaW5kZXggYWU3
OGU5YjllMC4uMjA2MDUxODVjNSAxMDA2NDQNCj4gPiAtLS0gYS9ody9hcm0vdmlydC1hY3BpLWJ1
aWxkLmMNCj4gPiArKysgYi9ody9hcm0vdmlydC1hY3BpLWJ1aWxkLmMNCj4gPiBAQCAtMzQyLDYg
KzM0Miw3IEBAIHN0YXRpYyBpbnQgaW9ydF9pZG1hcF9jb21wYXJlKGdjb25zdHBvaW50ZXIgYSwN
Cj4gZ2NvbnN0cG9pbnRlciBiKQ0KPiA+ICB0eXBlZGVmIHN0cnVjdCBBY3BpSW9ydFNNTVV2M0Rl
diB7DQo+ID4gICAgICBpbnQgaXJxOw0KPiA+ICAgICAgaHdhZGRyIGJhc2U7DQo+ID4gKyAgICB1
aW50OF90IGlkOw0KPiA+ICAgICAgR0FycmF5ICpyY19zbW11X2lkbWFwczsNCj4gPiAgICAgIC8q
IE9mZnNldCBvZiB0aGUgU01NVXYzIElPUlQgTm9kZSByZWxhdGl2ZSB0byB0aGUgc3RhcnQgb2Yg
dGhlIElPUlQgKi8NCj4gPiAgICAgIHNpemVfdCBvZmZzZXQ7DQo+ID4gQEAgLTQwNCw2ICs0MDUs
NyBAQCBzdGF0aWMgaW50IHBvcHVsYXRlX3NtbXV2M19kZXYoR0FycmF5DQo+ICpzZGV2X2Jsb2Is
IFZpcnRNYWNoaW5lU3RhdGUgKnZtcykNCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAmZXJyb3JfYWJvcnQpKTsNCj4gPiAgICAgICAgICBzZGV2LmFj
Y2VsID0gb2JqZWN0X3Byb3BlcnR5X2dldF9ib29sKG9iaiwgImFjY2VsIiwgJmVycm9yX2Fib3J0
KTsNCj4gPiAgICAgICAgICBzZGV2LmF0cyA9IG9iamVjdF9wcm9wZXJ0eV9nZXRfYm9vbChvYmos
ICJhdHMiLCAmZXJyb3JfYWJvcnQpOw0KPiA+ICsgICAgICAgIHNkZXYuaWQgPSBvYmplY3RfcHJv
cGVydHlfZ2V0X3VpbnQob2JqLCAiaWRlbnRpZmllciIsICZlcnJvcl9hYm9ydCk7DQo+ID4gICAg
ICAgICAgcGJ1cyA9IFBMQVRGT1JNX0JVU19ERVZJQ0Uodm1zLT5wbGF0Zm9ybV9idXNfZGV2KTsN
Cj4gPiAgICAgICAgICBzYmRldiA9IFNZU19CVVNfREVWSUNFKG9iaik7DQo+ID4gICAgICAgICAg
c2Rldi5iYXNlID0gcGxhdGZvcm1fYnVzX2dldF9tbWlvX2FkZHIocGJ1cywgc2JkZXYsIDApOw0K
PiA+IEBAIC02MzAsNyArNjMyLDcgQEAgYnVpbGRfaW9ydChHQXJyYXkgKnRhYmxlX2RhdGEsIEJJ
T1NMaW5rZXIgKmxpbmtlciwNCj4gVmlydE1hY2hpbmVTdGF0ZSAqdm1zKQ0KPiA+ICAgICAgICAg
ICAgICAgICAgICAgICAoSURfTUFQUElOR19FTlRSWV9TSVpFICogc21tdV9tYXBwaW5nX2NvdW50
KTsNCj4gPiAgICAgICAgICBidWlsZF9hcHBlbmRfaW50X25vcHJlZml4KHRhYmxlX2RhdGEsIG5v
ZGVfc2l6ZSwgMik7IC8qIExlbmd0aCAqLw0KPiA+ICAgICAgICAgIGJ1aWxkX2FwcGVuZF9pbnRf
bm9wcmVmaXgodGFibGVfZGF0YSwgNCwgMSk7IC8qIFJldmlzaW9uICovDQo+ID4gLSAgICAgICAg
YnVpbGRfYXBwZW5kX2ludF9ub3ByZWZpeCh0YWJsZV9kYXRhLCBpZCsrLCA0KTsgLyogSWRlbnRp
ZmllciAqLw0KPiA+ICsgICAgICAgIGJ1aWxkX2FwcGVuZF9pbnRfbm9wcmVmaXgodGFibGVfZGF0
YSwgc2Rldi0+aWQsIDQpOyAvKiBJZGVudGlmaWVyICovDQo+IEh1bSBhY3R1YWxseSBJIHNlZSB0
aGF0IHByZXZpb3VzbHkgdGhlIGlkIHNjb3BlIHdhcyBzaGFyZWQgYnkgYWxsIG5vZGVzLA0KPiBp
bmNsdWRpbmcgSVRTLCBTTU1VLCBSQy4NCj4gU28gbm93IGNhbiBoYXZlIGl0cyBhbmQgc21tdSBu
b2RlIGhhdmluZyBib3RoIGlkPTAuIEFuZCB0aGlzIGlzIHdoeSB5b3UNCj4gaGF2ZSBhIGNoYW5n
ZSBpbiB0aGUgSU9SVCB0YWJsZSBmb3IgaXRzPW9mZiB0ZXN0Lg0KDQpIbW0uLi4gSSBoYWQgdGhh
dCBkb3VidCBhcyB3ZWxsLiBCdXQgSSByZWFkIGl0IGFzIGEgdW5pcXVlIGlkZW50aWZpZXIgZm9y
IGVhY2ggDQp0eXBlIG9mIElPUlQgbm9kZS4gDQoNCj4gSXMgaXQgbGVnYWw/DQo+IA0KPiBJT1JU
IHNwZWMgc2F5czoNCj4gDQo+IFVuaXF1ZSBpZGVudGlmaWVyIGZvciB0aGlzIG5vZGUgdGhhdCBj
YW4gYmUgdXNlZCB0byBsb2NhdGUgaXQgaW4gdGhlDQo+IHBhcmVudCB0YWJsZS4gVGhpcyBpZGVu
dGlmaWVyIGVuYWJsZXMgb3RoZXIgQUNQSSB0YWJsZXMgYW5kIERTRFQgb2JqZWN0cw0KPiB0byBs
b2NhdGUgdGhpcyBub2RlLiBUaGlzIGZpZWxkIHNlcnZlcyBpbiB0aGUgc2FtZSBjYXBhY2l0eSBh
cyB0aGUgX1VJRA0KPiBvYmplY3QgYXNzb2NpYXRlZCB3aXRoIEFDUEkgZGV2aWNlIG9iamVjdHMu
IE5vdGUgSU1QTEVNRU5UQVRJT04gTk9URTogSW4NCj4gdGhlIHNpbXBsZXN0IHNjaGVtZSwgdGhl
IElkZW50aWZpZXIgbWlnaHQgYmUgc2V0IHRvIHRoZSBub2Rl4oCZcyBpbmRleCBpbg0KPiB0aGUg
YXJyYXkgb2YgSU9SVCBub2RlcyBpbiB0aGUgcGFyZW50IElPUlQgdGFibGUuIE90aGVyIHNjaGVt
ZXMgYXJlIGFsc28NCj4gcG9zc2libGUgYW5kIHBlcm1pdHRlZC4NCj4gDQo+IFNvIEkgZG9uJ3Qg
dGhpbmsgdGhpcyBpcyB2YWxpZA0KDQpJIHRoaW5rIHdlIG5lZWQgYW5vdGhlciB3YXkgdG8gc29y
dCBvdXQgdGhlIGlkZW50aWZpZXIgdGhlbi4NCg0KVGhhbmtzLA0KU2hhbWVlcg0K

