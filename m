Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89A341049514
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 09:27:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0FqC-00059F-Pf; Wed, 11 Mar 2026 05:26:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1w0FqA-00058h-71; Wed, 11 Mar 2026 05:26:54 -0400
Received: from mail-westus3azlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c107::3] helo=PH0PR06CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1w0Fq8-0001xh-09; Wed, 11 Mar 2026 05:26:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AxGLojzlm8uzpuXzjJc9MTjmoCLbc96O78R7gQ0sKDzWzGXOlKnXf+BzYF8NmSoAX5qYCAHcXqydM4GCIDiyyMBj7avnsgnq6872QCEKBQTEDRKclYStDFrrum5vGqYmdTvlLrPcai7//PwlGBsqoOYD9FHo7V4g2fnvUcwjWDezHbg8ifSrpTtZrojdYcEsCKI7JZjJChJU6cZIFHvLVFnNNLgijdNdNBQQsbTA2XbJkwAbS7LYD5fHdkHkmtkx/KXz5TYhmjkNLU3FcP+XCpE8o0FJSfzbSXnlUEIrl/+Q+Gxkd74eXInZi7ZUPA1IOfqB6yz+dCt+EdCP9uAfgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CEfOQQxnNfdAxnnO7fEnExXiwiPW6A0/8PoIJSXm9as=;
 b=vYKs+729cjjoCIxdtV/nouFmKvTLzP+6DLqj3nljrxMkn+T5SlIVIO0lmqQCQMvq6DWlGGb8IQS78sfiHr7FuhXLgaIGwzbX7OgBwL6mwi6Ov7DuzFwPJQYP4JP0pnMlQJzR2pZ/bj1PC+wlfG2y+QZDZe4XATPCklEvVYWeZ+lX8jHnqTT/3xSTEqbkIuOPFsyRIFFcuBvE+Yzzns+grPJMQHvvUYHxYAJ29H/Sm+XgstrMWWZNNqSJpzPH0HhJbTz8RVrJSWxOQBlTZuq52dNcx8HJ1NcIBv90PZHQksaRdG8uvHy5L6BU9BJ335ryzFDItYJcHUj3tGx1jqcPwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CEfOQQxnNfdAxnnO7fEnExXiwiPW6A0/8PoIJSXm9as=;
 b=ovLJYwH7AOkJX4bkhZw9nRnDE96vAj4ICZeSaFjbicpxiWWYo7IH/PWZxaebm3JHFRIY3v4lGW3BlpO80SHWvDGi4cMoWTPXTK+su9B+4G6nPEltTzg4NGLPjqVJI0rBZ3240p8LpnDTXtQ7qq8Oqs/dTkC/RULS+ETfGExJ5+mq5s76PaDE06la+rRn8ge+IdyaPqz2Q48/JdEGAbkM1N5uZeT0dmUod0ctlWKLB6W6S0pGtq/5YkMOwudIrTDkFcHlNgtRY1RKEft1YKVUZkvVRiE0LFUrF42vrFtbwaTNUzV6ezsE26dNeogktgeaZy28pHnWl2YPt088wXEgjQ==
Received: from CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
 by IA0PR12MB8227.namprd12.prod.outlook.com (2603:10b6:208:406::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.4; Wed, 11 Mar
 2026 09:26:45 +0000
Received: from CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de]) by CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de%5]) with mapi id 15.20.9700.010; Wed, 11 Mar 2026
 09:26:45 +0000
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
Subject: RE: [PATCH v3 17/32] hw/arm/tegra241-cmdqv: mmap VINTF Page0 for CMDQV
Thread-Topic: [PATCH v3 17/32] hw/arm/tegra241-cmdqv: mmap VINTF Page0 for
 CMDQV
Thread-Index: AQHcpw4RCbTPqX85HUillxSq8Ev4K7WpCqgAgAAKhZA=
Date: Wed, 11 Mar 2026 09:26:45 +0000
Message-ID: <CH3PR12MB754885F68C4F08CC39732EB2AB47A@CH3PR12MB7548.namprd12.prod.outlook.com>
References: <20260226105056.897-1-skolothumtho@nvidia.com>
 <20260226105056.897-18-skolothumtho@nvidia.com>
 <22acfd93-72cd-49ca-b2f6-a080bf66104c@redhat.com>
In-Reply-To: <22acfd93-72cd-49ca-b2f6-a080bf66104c@redhat.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB7548:EE_|IA0PR12MB8227:EE_
x-ms-office365-filtering-correlation-id: 6b321118-18c9-43de-53a4-08de7f50507a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|376014|38070700021|56012099003|18002099003|22082099003;
x-microsoft-antispam-message-info: XYiP5gttbwvZ5zfLOUkL9A8EMEUkjyJ5Mnr4FZYCZJ1ePx6T9rBG5DRJNDRuTxrgun4fxBgBd5Ye2nBPqQm2m/WpJuPnGTfcJlLwm/OSHL6EoisyYtdSB/uNSd/j/crmSqFlsEAvHxHYnFQRjPKxv2nq307NPTc5H3dNaN0KIxEKNaL2SRsCmtFKPJsgEk4sEdHClbyRndutTfBpBnLvgl7/2S0DIpKs7W2SCJ9t6ppdrlElyvxfJAPp/9RU3W9V36PXwS52rjQv0zv67WqDPWHaywGkP7LDiFykIhDUE2da1/Os1Iw3y6N1Yt392SJ1kSOdjY5xZFYrG7fhiLcfPqhjbHET/ddUIFrFvkC9aHDxmSVoymyamVn0fgKfDlzHZfRRROcBeOLOjbEuWu0Wqiu4arxr3ZE+cYXqy1FoiIvQy63EfmZkgrTM22x4qlKd8dSmvBl2uLwD1f0WooGQr+CnF7R3O0PXNjwfmciixHrC8TnmqMyaMJpC7aT37TlJUcydjPSaKMLu7/DbttfsMFT//1dQJByvaQXvSkIz1tsMASxt0/vHrve0U0ZCoyV/9wuo+TGLaRjfv9J1pb5PP6qLDQ1+rLMmbLfqgCE+rnpBsBDgKV1hk//fv4p8ZrYRMaEadIRZuKcz48+mTSPxTpw5q+mB+n3SX93UVY9GXkc/b2vFOwA8qgNcmh6U/a0W64J9sLHz5e3c4lZsCUSLxMBPElQOfaSDIIq8c9MtXkfOeOi5UyYJ5POipsFqaJj9xQcSyagUD2Uh9YaPoSB1B6TADjA79U4LBIhPLV/ux/k=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB7548.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700021)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OU5ZbXE4R3UvbGRLYW5JV2JzdEZhTnJLQ2RhblQrNmtlSkJhYTJrdGM1VUN6?=
 =?utf-8?B?NDlQaDhWK21uemFQQ1hPNWhqT1pnVVZLaGFlN2lucUIvbDU0V2Vwdm5ZdU00?=
 =?utf-8?B?cHhjSjBCb1VnRGQ4SVJzYm03eGdGaFdLWTR5TXl1VlovZXQ1V0tkaGFveXBU?=
 =?utf-8?B?VWRHaXNyZmh3eVB3Z1ZSR3lOOW1vbmJmUkhxenZmYjVCSm14RlkweFVWSXU3?=
 =?utf-8?B?Z091V1dSVVlHeFJ2M3JlSWFabm05VU84Nlk0R3BVTXlUNDVSSjF0WnJhMFBk?=
 =?utf-8?B?L04vcm84dDRZMjdnYS9pOVdSQVg4TWxkK0Foam56RWp4aHpPRVJ6Qmhyei9U?=
 =?utf-8?B?WEk0Snh0eEFlUGg3R25tOE5mMGZvaGh3Z09SQW0xRm5IaWVneVJ3eWlFM29R?=
 =?utf-8?B?MWwwdGl4UXNRVXRSYTBSZW1zZzgwV0s5U3lTQXcxQnIxRzkvc3hqVDFJWTcx?=
 =?utf-8?B?bGZJUnBXYlUvQzB1VW56WjMrdzkrdUN4V1BxNDJxOGlqdW84dzdLQVEwNWgw?=
 =?utf-8?B?K3pGWjU2NHRoMjlnMlZMeGZpSmU3M0FMMk9GZXJtemVlY3ZhWXJxT0xUVnZI?=
 =?utf-8?B?R0JJSjZnWGptMWlkMzR3U2tsekduNFNBZlhualBmSUd1c29mZ25Ea2R3MGxP?=
 =?utf-8?B?UjZTUHlaU0lhSThsMjB5U1dMbytseUI0RDc1eVNlaER2cGpjQW5tK2xYQjVh?=
 =?utf-8?B?WDM2RHFNWnF4a3IrTnFXLy9QWGorSi9PRGZJWXRKNnM1ZEt6Q093K2ZBV2Jt?=
 =?utf-8?B?cDY0Nm0vWnZTTDlSdDk3a2t2bS90N1JDTFJSVkZ5azNxN3JhSnpTaTI4Y3Zh?=
 =?utf-8?B?MmwvbWpHWFBSZGFSa3NqS3dzQS9IcGFYTjl5dXVFMWhWNGk1RXcyVVFWZHdQ?=
 =?utf-8?B?REJ0Tzgvb0VpTFUwWTJPWFlNaU5WU1NqQW5PTjhkdFlXYXlpeGtDODRRak9j?=
 =?utf-8?B?STIvR0Zuc3lOMDNubUJHVmMzVnNTTktwRDZvUkJ4MFVnVHhjQktkUmhVR2xN?=
 =?utf-8?B?RElPUVpFOGFhbFcrNjcyZUE0dHJKWTROKzBmY0lKK1VqT1RlY1lCNlRCNU9r?=
 =?utf-8?B?US90Ukx0SzY4a1FkNlh1RG9CRThwZldXSXFtRloxZGNLMDZ3VTdubFJDNGR3?=
 =?utf-8?B?blhqSGpNYmJMdUh4VUU1R0NoQmZ1OVpYL2Q1ZVQxVzBubkNvWm11N05qOWFI?=
 =?utf-8?B?SHpSWm16aGcyUTVZVCs4eTU1N2UwR3djQ285VG9USXFXQ2R2ZGR4RFdsM3V5?=
 =?utf-8?B?Q2NHVjNvc2t5WXBNQnY0VU1PRS9iM1JIaU5CUjg4N0JNQ2pWWVdTMyt5VjY4?=
 =?utf-8?B?NEpub0xybGtQQnF1YzhZNW5heU9KN2NlQkdjY01YUTBSWWxWTVBvamh3MXZz?=
 =?utf-8?B?cTRzMXFCYVRZL0lhcHQ2UzNOazFpMlVMWmNIZmFwSVptUjBzOEFhK3ZuZmxY?=
 =?utf-8?B?Z0l2VThadWNpeEdEL2wwRUtuY2pJM0xVTC9jNlh2Z3o1SFF6eUpYQjErZU9C?=
 =?utf-8?B?ZmlGUjhDRlpiL0pEL0NWTlVjTHJvTGtZRmVWU0w5NWh2TTF2VElpTjUvcHVT?=
 =?utf-8?B?UVJFYzBWZ0dZTkZTZXZHTU1uUUl0OTNaMHBxbk45RC9CcFBYNWFWWjZZbG5J?=
 =?utf-8?B?cEZKMTJqL1hlVW0xdGtiU2t2MURsV2NVYlMrMVJvTU9MdEhjZ0lYcGQzZUk1?=
 =?utf-8?B?cndPNjlhSFVkMjFqanI0QktRaXBqRlVZMmxCSG9oTTNaSmtqSHRaUS8zaUE2?=
 =?utf-8?B?Wk0zOXJTYUJPckZYQ0VHU2loeFNFVGQvaWkyRkFoUmQ4ckQzUEJxc1dZWC9Q?=
 =?utf-8?B?d3ZzbCtMQ24rc25vaGhNbVpQcUhFWWhwaWVORW9DdjZ4NC9FdW1HM3VLYVB4?=
 =?utf-8?B?SEphL0hDUm41UllBUXRmMjBrcTlWTjJrM1hpbDRXbEZpZ0ZlOVVLdDhuNmp5?=
 =?utf-8?B?TjI1RnRBdXhMK0xvUnhJWHBMTW50NVZNMDNQZ2hOTWRMQURGMUJONUJ3ei9q?=
 =?utf-8?B?M01HNmtua1ozS2VNaFlTaFRZWFk1cHQwdG1hSG5UYWkyMG1RN1YrMEdjY2Fu?=
 =?utf-8?B?QVZSWExGRmlCUzlubTY5OUV2YmlnekxmSHEvU05abGVmN0JvVEdmMHlIczdS?=
 =?utf-8?B?WjdMbFQvNDJOdWUwT2p0WFM3d2lVQVNWQTZvNjJmQXFnZzdEOFlDOE8xQ1g5?=
 =?utf-8?B?REZXZnlXSDREOVJveHVYUzJwUnJRZGFRWDE5ZkVDdzJ6NXo5V2hyUjV2d3Jn?=
 =?utf-8?B?SXVFc0VvRGFoOW1sZy9OMGZrY0VzakdSaDZHWWo2aUJvRHpDM1NSZGh3YWJJ?=
 =?utf-8?B?MHdWeDEwcHZrVHdUaGZEeUIxc05xc2UvcXF5NERJVDdhNEd1L0M0UT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7548.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b321118-18c9-43de-53a4-08de7f50507a
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2026 09:26:45.7128 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JqWqQ/r2JygcNAuvQcj8+cC1FMiERJtcEfYLaoA4au839ZafLLGvr1I6wQGRxVQWbNKceGe+5UiERNyaR+U3Kw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8227
Received-SPF: permerror client-ip=2a01:111:f403:c107::3;
 envelope-from=skolothumtho@nvidia.com;
 helo=PH0PR06CU001.outbound.protection.outlook.com
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
Yy5hdWdlckByZWRoYXQuY29tPg0KPiBTZW50OiAxMSBNYXJjaCAyMDI2IDA3OjU1DQo+IFRvOiBT
aGFtZWVyIEtvbG90aHVtIFRob2RpIDxza29sb3RodW10aG9AbnZpZGlhLmNvbT47IHFlbXUtDQo+
IGFybUBub25nbnUub3JnOyBxZW11LWRldmVsQG5vbmdudS5vcmcNCj4gQ2M6IHBldGVyLm1heWRl
bGxAbGluYXJvLm9yZzsgY2xnQHJlZGhhdC5jb207IGFsZXhAc2hhemJvdC5vcmc7IE5pY29saW4N
Cj4gQ2hlbiA8bmljb2xpbmNAbnZpZGlhLmNvbT47IE5hdGhhbiBDaGVuIDxuYXRoYW5jQG52aWRp
YS5jb20+OyBNYXR0DQo+IE9jaHMgPG1vY2hzQG52aWRpYS5jb20+OyBKaWFuZGkgQW4gPGphbkBu
dmlkaWEuY29tPjsgSmFzb24gR3VudGhvcnBlDQo+IDxqZ2dAbnZpZGlhLmNvbT47IGpvbmF0aGFu
LmNhbWVyb25AaHVhd2VpLmNvbTsNCj4gemhhbmdmZWkuZ2FvQGxpbmFyby5vcmc7IHpoZW56aG9u
Zy5kdWFuQGludGVsLmNvbTsgS3Jpc2huYWthbnQgSmFqdQ0KPiA8a2phanVAbnZpZGlhLmNvbT47
IHBocmRpbmFAcmVkaGF0LmNvbQ0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHYzIDE3LzMyXSBody9h
cm0vdGVncmEyNDEtY21kcXY6IG1tYXAgVklOVEYgUGFnZTANCj4gZm9yIENNRFFWDQo+IA0KPiBF
eHRlcm5hbCBlbWFpbDogVXNlIGNhdXRpb24gb3BlbmluZyBsaW5rcyBvciBhdHRhY2htZW50cw0K
PiANCj4gDQo+IE9uIDIvMjYvMjYgMTE6NTAgQU0sIFNoYW1lZXIgS29sb3RodW0gd3JvdGU6DQo+
ID4gRnJvbTogTmljb2xpbiBDaGVuIDxuaWNvbGluY0BudmlkaWEuY29tPg0KPiA+DQo+ID4gR2xv
YmFsIFZDTURRIHBhZ2VzIHByb3ZpZGUgYSBWTSB3aWRlIHZpZXcgb2YgYWxsIFZDTURRcywgd2hp
bGUgdGhlDQo+ID4gVklOVEYgcGFnZXMgZXhwb3NlIGEgbG9naWNhbCB2aWV3IGxvY2FsIHRvIGEg
Z2l2ZW4gVklOVEYuIEFsdGhvdWdoIHJlYWwNCj4gPiBoYXJkd2FyZSBtYXkgc3VwcG9ydCBtdWx0
aXBsZSBWSU5URnMsIHRoZSBrZXJuZWwgY3VycmVudGx5IGV4cG9zZXMgYQ0KPiA+IHNpbmdsZSBW
SU5URiBwZXIgVk0uDQo+ID4NCj4gPiBUaGUga2VybmVsIHByb3ZpZGVzIGFuIG1tYXAgb2Zmc2V0
IGZvciB0aGUgVklOVEYgUGFnZTAgcmVnaW9uIGR1cmluZw0KPiA+IHZJT01NVSBhbGxvY2F0aW9u
LiBIb3dldmVyLCB0aGUgbG9naWNhbC10by1waHlzaWNhbCBhc3NvY2lhdGlvbiBiZXR3ZWVuDQo+
ID4gVkNNRFFzIGFuZCBhIFZJTlRGIGlzIG9ubHkgZXN0YWJsaXNoZWQgYWZ0ZXIgSFdfUVVFVUUg
YWxsb2NhdGlvbi4gUHJpb3INCj4gPiB0byB0aGF0LCB0aGUgbWFwcGVkIFBhZ2UwIGRvZXMgbm90
IGJhY2sgYW55IHJlYWwgVkNNRFEgc3RhdGUuDQo+ID4NCj4gPiBXaGVuIFZJTlRGIGlzIGVuYWJs
ZWQsIG1tYXAgdGhlIGtlcm5lbCBwcm92aWRlZCBQYWdlMCByZWdpb24gYW5kDQo+ID4gdW5tYXAg
aXQgd2hlbiBWSU5URiBpcyBkaXNhYmxlZC4gVGhpcyBwcmVwYXJlcyB0aGUgVklOVEYgbWFwcGlu
Zw0KPiA+IGluIGFkdmFuY2Ugb2Ygc3Vic2VxdWVudCBwYXRjaGVzIHRoYXQgYWRkIFZDTURRIGFs
bG9jYXRpb24gc3VwcG9ydC4NCj4gU28gYXQgc29tZSBwb2ludCB3ZSB0cmFuc2l0aW9uIGZyb20g
c29tZXRoaW5nIHRoYXQgaXMgcHVyZWx5IGVtdWxhdGVkDQo+IChwYWdlIDEgZ2xvYmFsIGNtZHEp
IHRvIHNvbWV0aGluZyB0aGF0IGlzIG1tYXBwZWQgb24gYSBob3N0IHBhZ2UuIEhvdyBkbw0KPiB3
ZSB0cmFuc2ZlciB0aGUgc3RhdGUgb2YgdGhlIGNtZHEgZnJvbSBvbmUgdG8gdGhlIG90aGVyPw0K
DQpSaWdodC4gSWYgYSBndWVzdCB1c2VzIGJvdGggdGhlICJHbG9iYWwgVkNNRFEgcmVnaXN0ZXJz
IFBhZ2UwIiBhbmQgdGhlDQoiVklOVEYwIExvZ2ljYWwgVkNNRFEgcmVnaXN0ZXJzIFBhZ2UwIiBp
bnRlcmNoYW5nZWFibHkgKGFuZCBJIHNlZQ0Kbm90aGluZyBpbiB0aGUgc3BlYyB0aGF0IGZvcmJp
ZHMgdGhpcyksIHRoZW4gd2UgbmVlZCB0byBrZWVwIHRoZSB0d28NCnZpZXdzIGluIHN5bmMuDQoN
ClNvIHdoZW4gdGhlIG1hcHBpbmcgYmV0d2VlbiBhIGdsb2JhbCBWQ01EUSBhbmQgYSBsb2dpY2Fs
IFZDTURRIGlzDQpjcmVhdGVkIHRocm91Z2ggdGhlIEhXX1FVRVVFIGlvY3RsLCB3ZSBzaG91bGQg
c3luYyB0aGUgc3RhdGUgYmV0d2Vlbg0KdGhlIEdsb2JhbCBWQ01EUSBQYWdlMCBhbmQgdGhlIFZJ
TlRGMCBMb2dpY2FsIFZDTURRIFBhZ2UwLg0KDQpJIHdpbGwgZG91YmxlIGNoZWNrIHRoaXMuDQoN
ClRoYW5rcywNClNoYW1lZXINCg0KPiBUaGFua3MNCj4gDQo+IEVyaWMNCj4gPg0KPiA+IFNpZ25l
ZC1vZmYtYnk6IE5pY29saW4gQ2hlbiA8bmljb2xpbmNAbnZpZGlhLmNvbT4NCj4gPiBTaWduZWQt
b2ZmLWJ5OiBTaGFtZWVyIEtvbG90aHVtIDxza29sb3RodW10aG9AbnZpZGlhLmNvbT4NCj4gPiAt
LS0NCj4gPiAgaHcvYXJtL3RlZ3JhMjQxLWNtZHF2LmggfCAgMyArKysNCj4gPiAgaHcvYXJtL3Rl
Z3JhMjQxLWNtZHF2LmMgfCA0NA0KPiArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKystLQ0KPiA+ICAyIGZpbGVzIGNoYW5nZWQsIDQ1IGluc2VydGlvbnMoKyksIDIgZGVsZXRp
b25zKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvaHcvYXJtL3RlZ3JhMjQxLWNtZHF2LmggYi9o
dy9hcm0vdGVncmEyNDEtY21kcXYuaA0KPiA+IGluZGV4IGQzNzliODg2MGMuLjNjZTlmNTM5YWUg
MTAwNjQ0DQo+ID4gLS0tIGEvaHcvYXJtL3RlZ3JhMjQxLWNtZHF2LmgNCj4gPiArKysgYi9ody9h
cm0vdGVncmEyNDEtY21kcXYuaA0KPiA+IEBAIC0xOCw2ICsxOCw4IEBADQo+ID4gICNkZWZpbmUg
VEVHUkEyNDFfQ01EUVZfTUFYX0NNRFEgICAgICAgICAgICAoMVUgPDwNCj4gVEVHUkEyNDFfQ01E
UVZfTlVNX0NNRFFfTE9HMikNCj4gPiAgI2RlZmluZSBURUdSQTI0MV9DTURRVl9OVU1fU0lEX1BF
Ul9WTV9MT0cyIDQNCj4gPg0KPiA+ICsjZGVmaW5lIFZJTlRGX1BBR0VfU0laRSAweDEwMDAwDQo+
ID4gKw0KPiA+ICAvKg0KPiA+ICAgKiBUZWdyYTI0MSBDTURRViBNTUlPIGxheW91dCAoNjRLQiBw
YWdlcykNCj4gPiAgICoNCj4gPiBAQCAtMzQsNiArMzYsNyBAQCB0eXBlZGVmIHN0cnVjdCBUZWdy
YTI0MUNNRFFWIHsNCj4gPiAgICAgIFNNTVV2M0FjY2VsU3RhdGUgKnNfYWNjZWw7DQo+ID4gICAg
ICBNZW1vcnlSZWdpb24gbW1pb19jbWRxdjsNCj4gPiAgICAgIHFlbXVfaXJxIGlycTsNCj4gPiAr
ICAgIHZvaWQgKnZpbnRmX3BhZ2UwOw0KPiA+DQo+ID4gICAgICAvKiBSZWdpc3RlciBDYWNoZSAq
Lw0KPiA+ICAgICAgdWludDMyX3QgY29uZmlnOw0KPiA+IGRpZmYgLS1naXQgYS9ody9hcm0vdGVn
cmEyNDEtY21kcXYuYyBiL2h3L2FybS90ZWdyYTI0MS1jbWRxdi5jDQo+ID4gaW5kZXggZTFmMTU2
MmM0NC4uYTM3NjdhODVhMyAxMDA2NDQNCj4gPiAtLS0gYS9ody9hcm0vdGVncmEyNDEtY21kcXYu
Yw0KPiA+ICsrKyBiL2h3L2FybS90ZWdyYTI0MS1jbWRxdi5jDQo+ID4gQEAgLTE1MSw2ICsxNTEs
MzkgQEAgc3RhdGljIHVpbnQ2NF90IHRlZ3JhMjQxX2NtZHF2X3JlYWQodm9pZA0KPiAqb3BhcXVl
LCBod2FkZHIgb2Zmc2V0LCB1bnNpZ25lZCBzaXplKQ0KPiA+ICAgICAgfQ0KPiA+ICB9DQo+ID4N
Cj4gPiArc3RhdGljIGJvb2wNCj4gPiArdGVncmEyNDFfY21kcXZfbXVubWFwX3ZpbnRmX3BhZ2Uw
KFRlZ3JhMjQxQ01EUVYgKmNtZHF2LCBFcnJvcg0KPiAqKmVycnApDQo+ID4gK3sNCj4gPiArICAg
IGlmICghY21kcXYtPnZpbnRmX3BhZ2UwKSB7DQo+ID4gKyAgICAgICAgcmV0dXJuIHRydWU7DQo+
ID4gKyAgICB9DQo+ID4gKw0KPiA+ICsgICAgaWYgKG11bm1hcChjbWRxdi0+dmludGZfcGFnZTAs
IFZJTlRGX1BBR0VfU0laRSkgPCAwKSB7DQo+ID4gKyAgICAgICAgZXJyb3Jfc2V0Z19lcnJubyhl
cnJwLCBlcnJubywgIkZhaWxlZCB0byB1bm1hcCBWSU5URiBwYWdlMCIpOw0KPiA+ICsgICAgICAg
IHJldHVybiBmYWxzZTsNCj4gPiArICAgIH0NCj4gPiArICAgIGNtZHF2LT52aW50Zl9wYWdlMCA9
IE5VTEw7DQo+ID4gKyAgICByZXR1cm4gdHJ1ZTsNCj4gPiArfQ0KPiA+ICsNCj4gPiArc3RhdGlj
IGJvb2wgdGVncmEyNDFfY21kcXZfbW1hcF92aW50Zl9wYWdlMChUZWdyYTI0MUNNRFFWDQo+ICpj
bWRxdiwgRXJyb3IgKiplcnJwKQ0KPiA+ICt7DQo+ID4gKyAgICBJT01NVUZEVmlvbW11ICp2aW9t
bXUgPSBjbWRxdi0+c19hY2NlbC0+dmlvbW11Ow0KPiA+ICsNCj4gPiArICAgIGlmIChjbWRxdi0+
dmludGZfcGFnZTApIHsNCj4gPiArICAgICAgICByZXR1cm4gdHJ1ZTsNCj4gPiArICAgIH0NCj4g
PiArDQo+ID4gKyAgICBpZiAoIWlvbW11ZmRfYmFja2VuZF92aW9tbXVfbW1hcCh2aW9tbXUtPmlv
bW11ZmQsIHZpb21tdS0NCj4gPnZpb21tdV9pZCwNCj4gPiArICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIFZJTlRGX1BBR0VfU0laRSwNCj4gPiArICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIGNtZHF2LT5jbWRxdl9kYXRhLm91dF92aW50Zl9tbWFwX29mZnNl
dCwNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICZjbWRxdi0+dmlu
dGZfcGFnZTAsIGVycnApKSB7DQo+ID4gKyAgICAgICAgcmV0dXJuIGZhbHNlOw0KPiA+ICsgICAg
fQ0KPiA+ICsNCj4gPiArICAgIHJldHVybiB0cnVlOw0KPiA+ICt9DQo+ID4gKw0KPiA+ICAvKg0K
PiA+ICAgKiBXcml0ZSBhIFZDTURRIHJlZ2lzdGVyIHVzaW5nIFZDTURRMF8qIG9mZnNldHMuDQo+
ID4gICAqDQo+ID4gQEAgLTIxNiw3ICsyNDksNyBAQCB0ZWdyYTI0MV9jbWRxdl93cml0ZV92Y21k
cShUZWdyYTI0MUNNRFFWDQo+ICpjbWRxdiwgaHdhZGRyIG9mZnNldDAsIGludCBpbmRleCwNCj4g
PiAgfQ0KPiA+DQo+ID4gIHN0YXRpYyB2b2lkIHRlZ3JhMjQxX2NtZHF2X3dyaXRlX3ZpbnRmKFRl
Z3JhMjQxQ01EUVYgKmNtZHF2LCBod2FkZHINCj4gb2Zmc2V0LA0KPiA+IC0gICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICB1aW50NjRfdCB2YWx1ZSkNCj4gPiArICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdWludDY0X3QgdmFsdWUsIEVycm9yICoqZXJy
cCkNCj4gPiAgew0KPiA+ICAgICAgaW50IGk7DQo+ID4NCj4gPiBAQCAtMjI3LDggKzI2MCwxMCBA
QCBzdGF0aWMgdm9pZA0KPiB0ZWdyYTI0MV9jbWRxdl93cml0ZV92aW50ZihUZWdyYTI0MUNNRFFW
ICpjbWRxdiwgaHdhZGRyIG9mZnNldCwNCj4gPg0KPiA+ICAgICAgICAgIGNtZHF2LT52aW50Zl9j
b25maWcgPSB2YWx1ZTsNCj4gPiAgICAgICAgICBpZiAodmFsdWUgJiBSX1ZJTlRGMF9DT05GSUdf
RU5BQkxFX01BU0spIHsNCj4gPiArICAgICAgICAgICAgdGVncmEyNDFfY21kcXZfbW1hcF92aW50
Zl9wYWdlMChjbWRxdiwgZXJycCk7DQo+ID4gICAgICAgICAgICAgIGNtZHF2LT52aW50Zl9zdGF0
dXMgfD0gUl9WSU5URjBfU1RBVFVTX0VOQUJMRV9PS19NQVNLOw0KPiA+ICAgICAgICAgIH0gZWxz
ZSB7DQo+ID4gKyAgICAgICAgICAgIHRlZ3JhMjQxX2NtZHF2X211bm1hcF92aW50Zl9wYWdlMChj
bWRxdiwgZXJycCk7DQo+ID4gICAgICAgICAgICAgIGNtZHF2LT52aW50Zl9zdGF0dXMgJj0gflJf
VklOVEYwX1NUQVRVU19FTkFCTEVfT0tfTUFTSzsNCj4gPiAgICAgICAgICB9DQo+ID4gICAgICAg
ICAgYnJlYWs7DQo+ID4gQEAgLTI1MSw2ICsyODYsNyBAQCBzdGF0aWMgdm9pZCB0ZWdyYTI0MV9j
bWRxdl93cml0ZSh2b2lkICpvcGFxdWUsDQo+IGh3YWRkciBvZmZzZXQsIHVpbnQ2NF90IHZhbHVl
LA0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB1bnNpZ25lZCBzaXplKQ0K
PiA+ICB7DQo+ID4gICAgICBUZWdyYTI0MUNNRFFWICpjbWRxdiA9IChUZWdyYTI0MUNNRFFWICop
b3BhcXVlOw0KPiA+ICsgICAgRXJyb3IgKmxvY2FsX2VyciA9IE5VTEw7DQo+ID4gICAgICBpbnQg
aW5kZXg7DQo+ID4NCj4gPiAgICAgIGlmIChvZmZzZXQgPj0gVEVHUkEyNDFfQ01EUVZfSU9fTEVO
KSB7DQo+ID4gQEAgLTI3Niw3ICszMTIsNyBAQCBzdGF0aWMgdm9pZCB0ZWdyYTI0MV9jbWRxdl93
cml0ZSh2b2lkICpvcGFxdWUsDQo+IGh3YWRkciBvZmZzZXQsIHVpbnQ2NF90IHZhbHVlLA0KPiA+
ICAgICAgICAgIGNtZHF2LT5jbWRxX2FsbG9jX21hcFsob2Zmc2V0IC0gQV9DTURRX0FMTE9DX01B
UF8wKSAvIDRdID0NCj4gdmFsdWU7DQo+ID4gICAgICAgICAgYnJlYWs7DQo+ID4gICAgICBjYXNl
IEFfVklOVEYwX0NPTkZJRyAuLi4gQV9WSU5URjBfTFZDTURRX0VSUl9NQVBfMzoNCj4gPiAtICAg
ICAgICB0ZWdyYTI0MV9jbWRxdl93cml0ZV92aW50ZihjbWRxdiwgb2Zmc2V0LCB2YWx1ZSk7DQo+
ID4gKyAgICAgICAgdGVncmEyNDFfY21kcXZfd3JpdGVfdmludGYoY21kcXYsIG9mZnNldCwgdmFs
dWUsICZsb2NhbF9lcnIpOw0KPiA+ICAgICAgICAgIGJyZWFrOw0KPiA+ICAgICAgY2FzZSBBX1ZJ
X1ZDTURRMF9DT05TX0lORFggLi4uIEFfVklfVkNNRFExX0dFUlJPUk46DQo+ID4gICAgICAgICAg
LyogU2FtZSBkZWNvZGluZyBhcyByZWFkKCkgY2FzZTogU2VlIGNvbW1lbnRzIGFib3ZlICovDQo+
ID4gQEAgLTMwMCw2ICszMzYsMTAgQEAgc3RhdGljIHZvaWQgdGVncmEyNDFfY21kcXZfd3JpdGUo
dm9pZCAqb3BhcXVlLA0KPiBod2FkZHIgb2Zmc2V0LCB1aW50NjRfdCB2YWx1ZSwNCj4gPiAgICAg
ICAgICBxZW11X2xvZ19tYXNrKExPR19VTklNUCwgIiVzIHVuaGFuZGxlZCB3cml0ZSBhY2Nlc3Mg
YXQgMHglIg0KPiBQUkl4NjQgIlxuIiwNCj4gPiAgICAgICAgICAgICAgICAgICAgICAgIF9fZnVu
Y19fLCBvZmZzZXQpOw0KPiA+ICAgICAgfQ0KPiA+ICsNCj4gPiArICAgIGlmIChsb2NhbF9lcnIp
IHsNCj4gPiArICAgICAgICBlcnJvcl9yZXBvcnRfZXJyKGxvY2FsX2Vycik7DQo+ID4gKyAgICB9
DQo+ID4gIH0NCj4gPg0KPiA+ICBzdGF0aWMgdm9pZCB0ZWdyYTI0MV9jbWRxdl9mcmVlX3Zpb21t
dShTTU1VdjNTdGF0ZSAqcykNCg0K

