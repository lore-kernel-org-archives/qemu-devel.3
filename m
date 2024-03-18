Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42E34C54E5D
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Mar 2024 07:50:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rm7kJ-00021p-Ig; Mon, 18 Mar 2024 03:49:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Jiqian.Chen@amd.com>)
 id 1rm7kG-00021T-NU
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 03:49:20 -0400
Received: from mail-dm6nam04on2052.outbound.protection.outlook.com
 ([40.107.102.52] helo=NAM04-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Jiqian.Chen@amd.com>)
 id 1rm7kB-0007zc-F5
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 03:49:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ba32aIdMQBGvOQ9ZkLq3/jvSs3XJR3ShmxzKQ5ZzRdClpyR+al0oyM3W1UjWqRq9vvcpWHhMm0bxX6NOKI1RMLw3+e2m3cvPVzEIyUnwYIjYOsjHM47g9jnZBrc563f0d3en2+TLdTNqt1u48mRF0F2y6T0KHT8zZAZbQ781AHSs2JBLmmkZzDqQr3dsg9rat177mF4/EHlsUHrrbwVLbD3kxEO8bkUeKu38S6KoQB47xniK9JMMJ5qEI9hkZd/5tu4Ec4U94D0FAxqZNo6IzSMdE+/DsHSaz0O1m87tof2IXPd9lvrFUeaJCj3/eCDk6aexdaRXBrNoC0wmcqiXyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PJuwjkUGYKN4e1wJS5J3geeb9cMOe/ufUofr6kNuKaE=;
 b=apl+gaByTtKj6j7vtSpdctJjm59FqFaJcsUZOIjveqpALH3n52N6N0ukY0nsHgqNxzvwTjEmQm0pPePk2QY4tBV334sB0r9if9QBqDfs08ofQFD0njmN95Zh3Vc4KFYACvaN6lKVR1e+dijCs/uJfAQO7sZRmI0Hu8kW2GiW/eeaaIFUE5XUZloPJy6zlUcD4pnChrq6PE6D4owR3aR0GTBJPbAzWEIHFAeMg+1sWZUSrac3y93ohOt+Q0N92eVEGS4hdXmDSMxmCv83q4tBTdlAIW6g4u4ue+ugm1/WuLI/gvEnPaCwqLNKaMtUSlLWOy9P1FXY29RHztNSJ+yVIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PJuwjkUGYKN4e1wJS5J3geeb9cMOe/ufUofr6kNuKaE=;
 b=1WWbad+QtYForRUzpvqXd6GjiiLfR+vnh81FE9QsPB5WiVUl4Q7IujiyGTVX87JvovFlEfmEYnXBRK2gF7s+drpTr/60jSj2We6UXnmyuEKQzli5Ui7kSC8gS73HURnlTmdlx3gRhyc1Sh3iTZoG9iapL53BKldij6Oy788z0YA=
Received: from BL1PR12MB5849.namprd12.prod.outlook.com (2603:10b6:208:384::18)
 by SN7PR12MB7156.namprd12.prod.outlook.com (2603:10b6:806:2a7::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.26; Mon, 18 Mar
 2024 07:44:09 +0000
Received: from BL1PR12MB5849.namprd12.prod.outlook.com
 ([fe80::debf:178c:f5df:5efa]) by BL1PR12MB5849.namprd12.prod.outlook.com
 ([fe80::debf:178c:f5df:5efa%6]) with mapi id 15.20.7386.025; Mon, 18 Mar 2024
 07:44:09 +0000
From: "Chen, Jiqian" <Jiqian.Chen@amd.com>
To: "Michael S . Tsirkin" <mst@redhat.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "Chen, Jiqian"
 <Jiqian.Chen@amd.com>
Subject: Re: [QEMU PATCH v6 1/1] virtio-pci: implement No_Soft_Reset bit
Thread-Topic: [QEMU PATCH v6 1/1] virtio-pci: implement No_Soft_Reset bit
Thread-Index: AQHaZUDlDwXKf6cnZ0GccbPmz2mnprE9yvOA
Date: Mon, 18 Mar 2024 07:44:08 +0000
Message-ID: <BL1PR12MB584973E6899946613497A49AE72D2@BL1PR12MB5849.namprd12.prod.outlook.com>
References: <20240222034010.887390-1-Jiqian.Chen@amd.com>
 <20240222034010.887390-2-Jiqian.Chen@amd.com>
In-Reply-To: <20240222034010.887390-2-Jiqian.Chen@amd.com>
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
x-ms-traffictypediagnostic: BL1PR12MB5849:EE_|SN7PR12MB7156:EE_
x-ms-office365-filtering-correlation-id: 00c7171d-d533-4853-4ed7-08dc471f3220
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CQByzwWU/SvADQ1K2C0fCzvuCR3vlMps+yU7ROsO5xAS51oMe/SmrKWYje8r1o178auFgmbm2JuJ5m6DYp20HK4tb/HCWdGiW527epIolcH6OlJ5GE5CXYqeH70qHjg2PC68YS8zd/jtffGnWSKE32Ve6VoJr3adSImDJw9Eie50VXj0WuMHpgIdsATU79FdWQyXqkLbyXCqjkJcKuAiKpoxpHmHqf1NfCHkAzcHeKRZTjqQQsJ6AU//8xVyjS5Vj4b+Xl1x2q+xsgqiCy0USx42PmQDEfFXo5K4nhRG3QXqnBJ+XQ6T/7tlIJ1UvZ9nBMsPxjx/Ht7B2AfRvAZe4cdY85e7QoQ/Zyz1N/qdgCnzpiPGp9hqaoTGrpiMLrGRBs40Prz8rCDJ/Mg9bFKr7Kp5uWISFj234UQfN6qkuFz3rF75XDBZnkkY0nrMBroJ0f8psK3YfSiqgsUDRKgojRhjungAOHg/4JT3kPaEKV1dtWh7IqnPbnGOj8scO3Hj41AMKoDOs//5R4ToeZgt0C6x++i06zIca3TkEY/VyqKsJAZk8azDrkBecyHKSED3G/bM+3DRCbtnHhUX0c0fDHh/RrTQeR1CHvuTbrkniecBlaF4uQRRjR9pwHooKjeNbbSajzig8ygcEoJ5NtKmsIY0QAlL5xdKNbIyQ7Humgm/CXNuJkf4b5yCyOcqVFAzfo90053rJob6S+WRmiW7hVs39ERoy1aMxCOv6lqqFg4=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5849.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(366007)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ektUaTB2TTdISytBdEpOMXhtQ3o2Z0tPeEtsQjRJbi9LWmllK0o2anlDeE1q?=
 =?utf-8?B?bUljd2lZSnlOZllWcWRVYm1SYm1SK2hYUTl3SjRsYWFpZUFjK3B1VHVGMWRK?=
 =?utf-8?B?djc0UW11V25LNnV3UmNkZndYTGVLNW9SYnAvUVhYWThiYlIwM0J5dktyNTg2?=
 =?utf-8?B?YWRQbFVmRmtuY0xjKzd1WGdKdCs5c2tHMlJmem5ub25xK21XVXQ1eGFLLzV5?=
 =?utf-8?B?QUpKeGJSV3ZVTmZUTWRFZUxiSWRFeFBCVmg4bmkvTzJjVzM4bVBBdGw4bVRZ?=
 =?utf-8?B?azEzVUpKT24xQlFTUytPYjEzakxlK1FlM1V4Z0R0eXU4VE0zQUZRL2huMW9u?=
 =?utf-8?B?S1RFb2dZOTF3RnVBUUNjb09JZjBVcHZ3a2NyWjVDQjdsekUzVkpvSzlrZkw5?=
 =?utf-8?B?aVVvL1BJVkNWbFE0OGpCdW9PdzZiYnRlVk1uSml2eUxrQTV6YmVLVitibXBO?=
 =?utf-8?B?Qm1sdFpVVllOdlpZRUJuZ1RoU2M1R2k4RWRVMllYd1VENGlmQkVVckxYMy8y?=
 =?utf-8?B?WEFRTlpHV1oxVDk0S09nQ0w3d2VWSHlVNnRaOFhJeGdrUkdNMHRoRS9KNkcz?=
 =?utf-8?B?NFc1NU9OVnplYUk1Y1hLV1FweFJLYzN2bFQxOHMzZUJ1YUhJZ1ZNM1JacUli?=
 =?utf-8?B?Ri9USzRvZEVCZnNRdm8wTiswRTgyeXpMdWRVdUVPZEFoWEh4NG9JL0hnWUlE?=
 =?utf-8?B?d3g4T1RTUHJoM1hwbXFjZnZXZi9oT2F3UVZLd3ZSMlJRdG56aEQrL1BWajh2?=
 =?utf-8?B?K0VhMzFKSXMwWUlUM3NxV1ltVHpzTnVpc05oMHB3UmZ5Q0RzN0ZuenozeTY4?=
 =?utf-8?B?TDVlRS9WVTJEa2pVYWJFN2ZwSGhKWHQ4clo3Vy9pVnVSaElFakk1L3ZxSjY3?=
 =?utf-8?B?UnJ5cysyNnZMbFhqZ1dIYXdpbEo5N3c4MVlYUFVQK05ySEJ2VHRJaVZyQ2gw?=
 =?utf-8?B?VUhCWE9xWVBmRjVMd2dnUHZCSjBDOFMvdGtySFVJWHdvbXBMV2hLVkE5aTli?=
 =?utf-8?B?c2NFZ3F2QzVwUFBZMmRSd2Z2MDd5RFF0UjJLbU0xUWlRMDh0WmJTVk1QaXVl?=
 =?utf-8?B?OXI2SlhSNlc0NWJpQ0h4ZmxRRXdkY1dEYWU2RTJYU2RFbDJsVFRxRHlhRnBW?=
 =?utf-8?B?eUFvWkVqSUtpalRGUjFkQVNHNDM1cXVVMG02S3ZkbkZRS2xDMzhhVlFRZ2FR?=
 =?utf-8?B?c29tVHhST21zSHpZN09sNHNjOXVHL0JRcFR1ZFN4eXkxVFRuSlJKK1I3K3hO?=
 =?utf-8?B?MHlwNVRJR3MzRjZpUWQraVhNK0htSjFwV1cyTDBMT0FiZXRwZCtFZ2t4cVBN?=
 =?utf-8?B?NEZEdTNZOU12dEl3S0phMEZ5d21PUEVyUHZpVVhSZFQ1WERGK200VUtOZXli?=
 =?utf-8?B?QVNBNTdiZmxUUUJ6aEZwL2pTN1FFaWdkR1hqUTdlTklXUFZSWUxSWFpJNjJB?=
 =?utf-8?B?ZVhsWTlIYzdhUTRXNHpGUlFvZG1iY3JOMGViTlR4cE45Z2pOSmduZGZkV2gv?=
 =?utf-8?B?c0NtazEzcVMzd2FtaWIyS1ZHQzN2THRiT3dnb21KYlNLVDBxSlordGZreUpT?=
 =?utf-8?B?N3JNQzBxQkEwelVISTdwMkhuRDAyMlF4ZjNOQklkUHJXdk1IS3NHZmJLY0lG?=
 =?utf-8?B?VkRhbEdrVHZicm4yU2lYRjh1ODc3Vkx6Sm9kd1hpdTkxK2RQNDIwazZ3a2FH?=
 =?utf-8?B?MloyUDJRRWk5blV4dzdGTVF4dUtEWUZIV2M5NURrVm55YU1PRDlKdnVqb0dn?=
 =?utf-8?B?U0VVV3RTZDFxcGhYR3ZzRUpIcXdwemladzFLYU15YWVMZnpKdmlFU3F5SCtY?=
 =?utf-8?B?QXdNaUFJcktXWXMrZEIvM0RFclF5a2VMN0ZLNVF1WWQ0ZnpqKzBod3dpN3k2?=
 =?utf-8?B?RXpHd3F2YUpJNzBVQ0lWc1N5UlF2clZTYmJqaTdOaFFwTXVLb3o4QVlSeml3?=
 =?utf-8?B?NGFjR09PMFRHOTFhZFdMV1EzVTVRbXBvWnpjWEdBOHBDMW1vNDFsOUdhVko5?=
 =?utf-8?B?aVpPRHF6NStRMXlYQWVhaUhXZ0ttU3lOWEJiM1RyQzk1czhPYXVqNEI2Tkc4?=
 =?utf-8?B?QVJTeEJhcUdaSXczSUNVOXJDT0YrSnk4dFNpNDR2RXZNb3ZZeEY0bTEwV3do?=
 =?utf-8?Q?5CI8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <23C4188642227347B4FB0681B49ADEF3@amdcloud.onmicrosoft.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00c7171d-d533-4853-4ed7-08dc471f3220
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2024 07:44:09.0030 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ztkyTvxNciPB6FfYPvDlP7OPtwSA7gfDj0rg8G8Q952RSDjmMnMMJi+sQ7nljfL6z6bVO1gvEPGF+Q2bLFpvBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7156
Received-SPF: permerror client-ip=40.107.102.52;
 envelope-from=Jiqian.Chen@amd.com;
 helo=NAM04-DM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -4
X-Spam_score: -0.5
X-Spam_bar: /
X-Spam_report: (-0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.316,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1.9, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=no autolearn_force=no
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

SGkgTWljaGFlbCBTLiBUc2lya2luLA0KRG8geW91IGhhdmUgYW55IGNvbW1lbnRzIG9uIHRoaXMg
cGF0Y2g/DQoNCk9uIDIwMjQvMi8yMiAxMTo0MCwgSmlxaWFuIENoZW4gd3JvdGU6DQo+IEluIGN1
cnJlbnQgY29kZSwgd2hlbiBndWVzdCBkb2VzIFMzLCB2aXJ0aW8gZGV2aWNlcyBhcmUgcmVzZXQg
ZHVlIHRvDQo+IHRoZSBiaXQgTm9fU29mdF9SZXNldCBpcyBub3Qgc2V0LiBBZnRlciByZXNldHRp
bmcsIHRoZSBkaXNwbGF5IHJlc291cmNlcw0KPiBvZiB2aXJ0aW8tZ3B1IGFyZSBkZXN0cm95ZWQs
IHRoZW4gdGhlIGRpc3BsYXkgY2FuJ3QgY29tZSBiYWNrIGFuZCBvbmx5DQo+IHNob3cgYmxhbmsg
YWZ0ZXIgcmVzdW1pbmcuDQo+IA0KPiBJbXBsZW1lbnQgTm9fU29mdF9SZXNldCBiaXQgb2YgUENJ
X1BNX0NUUkwgcmVnaXN0ZXIsIHRoZW4gZ3Vlc3QgY2FuIGNoZWNrDQo+IHRoaXMgYml0LCBpZiB0
aGlzIGJpdCBpcyBzZXQsIHRoZSBkZXZpY2VzIHJlc2V0dGluZyB3aWxsIG5vdCBiZSBkb25lLCBh
bmQNCj4gdGhlbiB0aGUgZGlzcGxheSBjYW4gd29yayBhZnRlciByZXN1bWluZy4NCj4gDQo+IFNp
Z25lZC1vZmYtYnk6IEppcWlhbiBDaGVuIDxKaXFpYW4uQ2hlbkBhbWQuY29tPg0KPiAtLS0NCj4g
IGh3L3ZpcnRpby92aXJ0aW8tcGNpLmMgICAgICAgICB8IDM3ICsrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKy0NCj4gIGluY2x1ZGUvaHcvdmlydGlvL3ZpcnRpby1wY2kuaCB8ICA1ICsr
KysrDQo+ICAyIGZpbGVzIGNoYW5nZWQsIDQxIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkN
Cj4gDQo+IGRpZmYgLS1naXQgYS9ody92aXJ0aW8vdmlydGlvLXBjaS5jIGIvaHcvdmlydGlvL3Zp
cnRpby1wY2kuYw0KPiBpbmRleCAxYTcwMzlmYjBjNjguLmRhNTMxMjAxMDM0NSAxMDA2NDQNCj4g
LS0tIGEvaHcvdmlydGlvL3ZpcnRpby1wY2kuYw0KPiArKysgYi9ody92aXJ0aW8vdmlydGlvLXBj
aS5jDQo+IEBAIC0yMTk3LDYgKzIxOTcsMTEgQEAgc3RhdGljIHZvaWQgdmlydGlvX3BjaV9yZWFs
aXplKFBDSURldmljZSAqcGNpX2RldiwgRXJyb3IgKiplcnJwKQ0KPiAgICAgICAgICAgICAgcGNp
ZV9jYXBfbG5rY3RsX2luaXQocGNpX2Rldik7DQo+ICAgICAgICAgIH0NCj4gIA0KPiArICAgICAg
ICBpZiAocHJveHktPmZsYWdzICYgVklSVElPX1BDSV9GTEFHX1BNX05PX1NPRlRfUkVTRVQpIHsN
Cj4gKyAgICAgICAgICAgIHBjaV9zZXRfd29yZChwY2lfZGV2LT5jb25maWcgKyBwb3MgKyBQQ0lf
UE1fQ1RSTCwNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgICBQQ0lfUE1fQ1RSTF9OT19TT0ZU
X1JFU0VUKTsNCj4gKyAgICAgICAgfQ0KPiArDQo+ICAgICAgICAgIGlmIChwcm94eS0+ZmxhZ3Mg
JiBWSVJUSU9fUENJX0ZMQUdfSU5JVF9QTSkgew0KPiAgICAgICAgICAgICAgLyogSW5pdCBQb3dl
ciBNYW5hZ2VtZW50IENvbnRyb2wgUmVnaXN0ZXIgKi8NCj4gICAgICAgICAgICAgIHBjaV9zZXRf
d29yZChwY2lfZGV2LT53bWFzayArIHBvcyArIFBDSV9QTV9DVFJMLA0KPiBAQCAtMjI1OSwxOCAr
MjI2NCw0NiBAQCBzdGF0aWMgdm9pZCB2aXJ0aW9fcGNpX3Jlc2V0KERldmljZVN0YXRlICpxZGV2
KQ0KPiAgICAgIH0NCj4gIH0NCj4gIA0KPiArc3RhdGljIGJvb2wgZGV2aWNlX25vX25lZWRfcmVz
ZXQoUENJRGV2aWNlICpkZXYpDQo+ICt7DQo+ICsgICAgaWYgKHBjaV9pc19leHByZXNzKGRldikp
IHsNCj4gKyAgICAgICAgdWludDE2X3QgcG1jc3I7DQo+ICsNCj4gKyAgICAgICAgcG1jc3IgPSBw
Y2lfZ2V0X3dvcmQoZGV2LT5jb25maWcgKyBkZXYtPmV4cC5wbV9jYXAgKyBQQ0lfUE1fQ1RSTCk7
DQo+ICsgICAgICAgIC8qDQo+ICsgICAgICAgICAqIFdoZW4gTm9fU29mdF9SZXNldCBiaXQgaXMg
c2V0IGFuZCBkZXZpY2UNCj4gKyAgICAgICAgICogaXMgaW4gRDNob3Qgc3RhdGUsIGNhbid0IHJl
c2V0IGRldmljZQ0KPiArICAgICAgICAgKi8NCj4gKyAgICAgICAgaWYgKChwbWNzciAmIFBDSV9Q
TV9DVFJMX05PX1NPRlRfUkVTRVQpICYmDQo+ICsgICAgICAgICAgICAocG1jc3IgJiBQQ0lfUE1f
Q1RSTF9TVEFURV9NQVNLKSA9PSAzKQ0KPiArICAgICAgICAgICAgcmV0dXJuIHRydWU7DQo+ICsg
ICAgfQ0KPiArDQo+ICsgICAgcmV0dXJuIGZhbHNlOw0KPiArfQ0KPiArDQo+ICBzdGF0aWMgdm9p
ZCB2aXJ0aW9fcGNpX2J1c19yZXNldF9ob2xkKE9iamVjdCAqb2JqKQ0KPiAgew0KPiAgICAgIFBD
SURldmljZSAqZGV2ID0gUENJX0RFVklDRShvYmopOw0KPiAgICAgIERldmljZVN0YXRlICpxZGV2
ID0gREVWSUNFKG9iaik7DQo+ICANCj4gKyAgICBpZiAoZGV2aWNlX25vX25lZWRfcmVzZXQoZGV2
KSkNCj4gKyAgICAgICAgcmV0dXJuOw0KPiArDQo+ICAgICAgdmlydGlvX3BjaV9yZXNldChxZGV2
KTsNCj4gIA0KPiAgICAgIGlmIChwY2lfaXNfZXhwcmVzcyhkZXYpKSB7DQo+ICsgICAgICAgIHVp
bnQxNl90IHBtY3NyOw0KPiArICAgICAgICB1aW50MTZfdCB2YWwgPSAwOw0KPiArDQo+ICAgICAg
ICAgIHBjaWVfY2FwX2RldmVycl9yZXNldChkZXYpOw0KPiAgICAgICAgICBwY2llX2NhcF9sbmtj
dGxfcmVzZXQoZGV2KTsNCj4gIA0KPiAtICAgICAgICBwY2lfc2V0X3dvcmQoZGV2LT5jb25maWcg
KyBkZXYtPmV4cC5wbV9jYXAgKyBQQ0lfUE1fQ1RSTCwgMCk7DQo+ICsgICAgICAgIC8qIGRvbid0
IHJlc2V0IHRoZSBSTyBiaXRzICovDQo+ICsgICAgICAgIHBtY3NyID0gcGNpX2dldF93b3JkKGRl
di0+Y29uZmlnICsgZGV2LT5leHAucG1fY2FwICsgUENJX1BNX0NUUkwpOw0KPiArICAgICAgICB2
YWwgPSB2YWwgfCAocG1jc3IgJiBQQ0lfUE1fQ1RSTF9OT19TT0ZUX1JFU0VUKSB8DQo+ICsgICAg
ICAgICAgICAgICAgKHBtY3NyICYgUENJX1BNX0NUUkxfREFUQV9TQ0FMRV9NQVNLKTsNCj4gKyAg
ICAgICAgcGNpX3NldF93b3JkKGRldi0+Y29uZmlnICsgZGV2LT5leHAucG1fY2FwICsgUENJX1BN
X0NUUkwsIHZhbCk7DQo+ICAgICAgfQ0KPiAgfQ0KPiAgDQo+IEBAIC0yMjk3LDYgKzIzMzAsOCBA
QCBzdGF0aWMgUHJvcGVydHkgdmlydGlvX3BjaV9wcm9wZXJ0aWVzW10gPSB7DQo+ICAgICAgICAg
ICAgICAgICAgICAgIFZJUlRJT19QQ0lfRkxBR19JTklUX0xOS0NUTF9CSVQsIHRydWUpLA0KPiAg
ICAgIERFRklORV9QUk9QX0JJVCgieC1wY2llLXBtLWluaXQiLCBWaXJ0SU9QQ0lQcm94eSwgZmxh
Z3MsDQo+ICAgICAgICAgICAgICAgICAgICAgIFZJUlRJT19QQ0lfRkxBR19JTklUX1BNX0JJVCwg
dHJ1ZSksDQo+ICsgICAgREVGSU5FX1BST1BfQklUKCJ4LXBjaWUtcG0tbm8tc29mdC1yZXNldCIs
IFZpcnRJT1BDSVByb3h5LCBmbGFncywNCj4gKyAgICAgICAgICAgICAgICAgICAgVklSVElPX1BD
SV9GTEFHX1BNX05PX1NPRlRfUkVTRVRfQklULCB0cnVlKSwNCj4gICAgICBERUZJTkVfUFJPUF9C
SVQoIngtcGNpZS1mbHItaW5pdCIsIFZpcnRJT1BDSVByb3h5LCBmbGFncywNCj4gICAgICAgICAg
ICAgICAgICAgICAgVklSVElPX1BDSV9GTEFHX0lOSVRfRkxSX0JJVCwgdHJ1ZSksDQo+ICAgICAg
REVGSU5FX1BST1BfQklUKCJhZXIiLCBWaXJ0SU9QQ0lQcm94eSwgZmxhZ3MsDQo+IGRpZmYgLS1n
aXQgYS9pbmNsdWRlL2h3L3ZpcnRpby92aXJ0aW8tcGNpLmggYi9pbmNsdWRlL2h3L3ZpcnRpby92
aXJ0aW8tcGNpLmgNCj4gaW5kZXggNTlkODgwMThjMTZhLi45ZTY3YmEzOGM3NDggMTAwNjQ0DQo+
IC0tLSBhL2luY2x1ZGUvaHcvdmlydGlvL3ZpcnRpby1wY2kuaA0KPiArKysgYi9pbmNsdWRlL2h3
L3ZpcnRpby92aXJ0aW8tcGNpLmgNCj4gQEAgLTQzLDYgKzQzLDcgQEAgZW51bSB7DQo+ICAgICAg
VklSVElPX1BDSV9GTEFHX0lOSVRfRkxSX0JJVCwNCj4gICAgICBWSVJUSU9fUENJX0ZMQUdfQUVS
X0JJVCwNCj4gICAgICBWSVJUSU9fUENJX0ZMQUdfQVRTX1BBR0VfQUxJR05FRF9CSVQsDQo+ICsg
ICAgVklSVElPX1BDSV9GTEFHX1BNX05PX1NPRlRfUkVTRVRfQklULA0KPiAgfTsNCj4gIA0KPiAg
LyogTmVlZCB0byBhY3RpdmF0ZSB3b3JrLWFyb3VuZHMgZm9yIGJ1Z2d5IGd1ZXN0cyBhdCB2bXN0
YXRlIGxvYWQuICovDQo+IEBAIC03OSw2ICs4MCwxMCBAQCBlbnVtIHsNCj4gIC8qIEluaXQgUG93
ZXIgTWFuYWdlbWVudCAqLw0KPiAgI2RlZmluZSBWSVJUSU9fUENJX0ZMQUdfSU5JVF9QTSAoMSA8
PCBWSVJUSU9fUENJX0ZMQUdfSU5JVF9QTV9CSVQpDQo+ICANCj4gKy8qIEluaXQgVGhlIE5vX1Nv
ZnRfUmVzZXQgYml0IG9mIFBvd2VyIE1hbmFnZW1lbnQgKi8NCj4gKyNkZWZpbmUgVklSVElPX1BD
SV9GTEFHX1BNX05PX1NPRlRfUkVTRVQgXA0KPiArICAoMSA8PCBWSVJUSU9fUENJX0ZMQUdfUE1f
Tk9fU09GVF9SRVNFVF9CSVQpDQo+ICsNCj4gIC8qIEluaXQgRnVuY3Rpb24gTGV2ZWwgUmVzZXQg
Y2FwYWJpbGl0eSAqLw0KPiAgI2RlZmluZSBWSVJUSU9fUENJX0ZMQUdfSU5JVF9GTFIgKDEgPDwg
VklSVElPX1BDSV9GTEFHX0lOSVRfRkxSX0JJVCkNCj4gIA0KDQotLSANCkJlc3QgcmVnYXJkcywN
CkppcWlhbiBDaGVuLg0K

