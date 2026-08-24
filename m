Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FE06C5DF81
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 13:14:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyUV3-0002lP-Ff; Mon, 24 Aug 2026 09:14:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <neal.frager@amd.com>)
 id 1wyUV1-0002l6-GK
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 09:14:03 -0400
Received: from mail-westus2azon11012005.outbound.protection.outlook.com
 ([52.101.48.5] helo=MW6PR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <neal.frager@amd.com>)
 id 1wyUUz-00047j-GJ
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 09:14:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c8DKpipjr9ITkDMQfyaV5WVEbXQQorIytSjhCp57IL9O5pLWRb/3/bIcINUHkMezbx6YcV797JbxMdw8QwHax4Mfn/M0MKHVRyP9MhO0B2NCe3ZQt3g/50ZvSWVPcvSJoj+G8SFGO0Rs7rjpNiU/i1HecjPixao1cRyndI9E53VSbkib27p8/2Hv5aKIouW76ZlKIIv0h86YMAgk4VfiHTIf7w7qxMpzdUK2nKmzhhrpXw5u+BPTd4IoMPkfeIa9oFgieGEpmj7Z8EUjkSAFww5aYXd1B8OX3e6AYbMObErM/Jqbx6IBj5EC8crhEl2AHK54LorRN8YTOQ4WU4h4jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j3VJliHozSau3hHOQin8nch2veQW2FHnOwtfxdqPtCg=;
 b=amT58ksDUYrBFpsR3mtrdeHWXd9wkN0pa+xdJpXkVoCrOqKF1dpRyI5NyDSrJXuy4SGc3LDq6wxFY+qLMmZE6UdOqcRaTa2502ULkpbbXDvsMEF/51Qvx10GZh7XW+twb94goXyjT/AukbRZK2jFx5rFyKQQseZBKjhv3sNKxmH9TdfYbYgmGdtkFLxFxr9AyfkapqldokLC91pfruEXCZJg++WxEAGGeDt/W/34+RqFGqm5JoegOKOX+IKku7QTgsxnghDyAL3xUk9SpF6FqxpnJYCv+bbyuZ4zNAXV1ylskVydzpyjq3vD9QxQFPz/BCnhXeFhU6Ru4w20Nm2/pA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j3VJliHozSau3hHOQin8nch2veQW2FHnOwtfxdqPtCg=;
 b=QL1Rww/uT0b3dkzCBS/zbs7PrKyZaCgujn3EcqW4J4rWQnXPire1uXS6t4znc5ZISEY+v/sB78KhcUdEEwsC0q8eKXivj4p7muYhRqumos+/XyFFbctS8E4jSfhWJ4mlnA+EPXwalvwwjoEYeUL9vk7UOAb3Eo6V/nwlFydbOtY=
Received: from BL1PR12MB5032.namprd12.prod.outlook.com (2603:10b6:208:30a::12)
 by CH3PR12MB8658.namprd12.prod.outlook.com (2603:10b6:610:175::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Mon, 24 Aug
 2026 13:08:53 +0000
Received: from BL1PR12MB5032.namprd12.prod.outlook.com
 ([fe80::3c13:eeb6:d9ef:c95d]) by BL1PR12MB5032.namprd12.prod.outlook.com
 ([fe80::3c13:eeb6:d9ef:c95d%6]) with mapi id 15.21.0339.012; Mon, 24 Aug 2026
 13:08:53 +0000
From: "Frager, Neal" <neal.frager@amd.com>
To: "Hildebrand, Stewart" <Stewart.Hildebrand@amd.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "sstabellini@kernel.org" <sstabellini@kernel.org>,
 "anthony@xenproject.org" <anthony@xenproject.org>, "edgar.iglesias@gmail.com"
 <edgar.iglesias@gmail.com>, "xen-devel@lists.xenproject.org"
 <xen-devel@lists.xenproject.org>, "Stabellini, Stefano"
 <stefano.stabellini@amd.com>, "Saleab, Micheal" <Micheal.Saleab@amd.com>,
 "john.ernberg@actia.se" <john.ernberg@actia.se>,
 "matthew.l.weber3@boeing.com" <matthew.l.weber3@boeing.com>,
 "vincent.stehle@arm.com" <vincent.stehle@arm.com>
Subject: RE: [PATCH v1 1/1] include/hw/xen/xen_native.h: downgrade
 include-order assertion to warning
Thread-Topic: [PATCH v1 1/1] include/hw/xen/xen_native.h: downgrade
 include-order assertion to warning
Thread-Index: AQHdJJsckvnz/cO5N0ySs3v4A11/7LatQ5eAgAAFmcA=
Date: Mon, 24 Aug 2026 13:08:53 +0000
Message-ID: <BL1PR12MB5032F21E0E2A6F17398B6D76F0A02@BL1PR12MB5032.namprd12.prod.outlook.com>
References: <20260805052723.2823538-1-neal.frager@amd.com>
 <2383a98d-d88d-415d-9de1-aa68a5d215fe@amd.com>
In-Reply-To: <2383a98d-d88d-415d-9de1-aa68a5d215fe@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-08-24T13:05:13.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5032:EE_|CH3PR12MB8658:EE_
x-ms-office365-filtering-correlation-id: 6ff080b7-9c08-43b3-40da-08df01e0d8f4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|56012099006|10067099003|6133799003|18002099003|22082099003|11063799006|4143699003|38070700021;
x-microsoft-antispam-message-info: 3DTaVbQKrtK7rlXjQXJq/wVnLxXAhyHOsjAsTKprslkGwBGS0BofYUGVqYb+pItLkMSpoN/gF5Ukjd0mKixfm47K3eb5LBu6iNIVQnE0eLGtaTkFSE3CHmvZf1mg8hL1mXmcAEFi7YyCpIB0IkR+rcPhDkqkaMne+XaxdwZNoRoggy2DfUWgiX8cfATswThax5fngNPcBdxb2rdMCnVFJHZ9lcXhcZhOp/7eg9YNm/VIGtcj3dhTpJr0uMFL4ANDo99BdoCX99mYKdCdQSOgxosNFKlWD1HYeCBQlJLgmRtg6bivfbJ1lIEv4WO6vjqss/Lner9tySOzTpLGsbjtR0UVdcf7bJSUagQ8ey2W2X/G5ghWAQ0Dytc9CcqdndgUaXugsHXTlacS3gXVCoqf7MoOygE8530ZczNgHSjqSNXlWGuOlTnpJYbzd/bbdR7QTIlLLQWb6jMyk+/3PuQP7znygftKN5F+FS/nbgUa98yqIgRqWJUueXlfbpMsiCUqMsjAuJo0YCFaeRWatseo90Twf4l6xvgJKwXyW9g0+uJuLtdJZX8+P7fht9z827eW00AZo+Qbp9PWKDjVAuR8ThMJlwBmsz+XB1L+2fkLNj45jR4cJbovXyUBDUkJgfi9JxjxxwzsxindLsIWDqoy2t6HMmCT7Ez52IJ+tq12KRdR8vguqnYamYzIxble0UZhtiNyv53FIQRvERWOv8KsyciBW76AHcQpjeSs+WNUiu4=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5032.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(56012099006)(10067099003)(6133799003)(18002099003)(22082099003)(11063799006)(4143699003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TnI1bzJEMC90YitqUzN6QnJTc3pDelFucXNrYUNsSm5HTkhGM1VNcVFUenk2?=
 =?utf-8?B?S3FLTUM1VWxJZml5ZHhwdkhpaHpaMEFXMXNyeHA4QjhUYjFiSnVhM2JsaGxz?=
 =?utf-8?B?U0lyYUZwWlYvQmFpL2F6L3Q3bS9NOE0xNkZiRVBaSzdRdWhLbGNLQ3ptL01E?=
 =?utf-8?B?R0FBR0d1TjNZTk1QTnpMS0tDR1h5Z0luV0tVOCtKc21nTDVVZ0tjNjkzSW43?=
 =?utf-8?B?cC9rNnpkak9UTHhvTWdNRVNONkxWRVYwYlJLUkFSWG82R2ZuZml0clFtVDdP?=
 =?utf-8?B?cVRSS2FKZXduTW1qK0lvQnRWbVNXYm9NNHpEOVh4dENFeWJacTI1Ry8wUHRt?=
 =?utf-8?B?djhUaWRBdXkzWitwaFE1aEtJNGpzT084TEU5bDdzN0dCZzFDajJ6a3d5MUhX?=
 =?utf-8?B?U0tyRlVrdmdCTzhINXZYNTBkOEZVNEp6RldpUlgwSHRzY3BLZHBITi9NM1lR?=
 =?utf-8?B?S3VXbEdKNWhCNy93THFkMk5SeDc1bmFhUjc4SjlQdTRydVRSZEFRUElnWHhw?=
 =?utf-8?B?LzVER3M3OWIrMS9oR0hkM2NVUjhSd2FyRWtIOWl4Nm9LelIrcjBlZXVvaFJx?=
 =?utf-8?B?ZjJtWVRnRnlxRlVxbDVSNnV3c3Y3NytqMnd5d3ZZbzBTRFh3UW9TQi9UYmlX?=
 =?utf-8?B?emM4UXBibmxZbEV2eVVSWnJkbkpPSi8zaFZUdTV1cThvNzV2RE1kKzZnQTda?=
 =?utf-8?B?QUxuNTZJWGprOHYzTTBBS1ROWFN2UVB1U29vdnF2MWRkTy9zUzg2RVA0ZHd2?=
 =?utf-8?B?ZDZuQklJZ0NqWlRyaWtDZENTandpV3FWVjFLcmZ6bHlxVEUxRmoxRis1cGlU?=
 =?utf-8?B?QU5nWTJZUnhhLzdWVG8vUHU2NEJvZHNiOHJtU3hNbEpXUFFjUzJ4bnF6dGl3?=
 =?utf-8?B?NHhCNmp4ZkZkWm51YVJiZ1BuNmphYWc1UGpTK0Y3cFN5Sm5XOXU3WU5tZ3JH?=
 =?utf-8?B?Mm9zNDdvbWlWVWtLWEFteHRicitiYjFNWjRzTVRiV3phNmxMSncwcVJ0R2xV?=
 =?utf-8?B?VnhGd3BrMUxVazZHeElVV2pZMVB6dzR1dGN4TTY1RUlaYUs3blQ3enoxTm9E?=
 =?utf-8?B?T1JuNXNvWm9FWWVtcjNtdi84NkdzZVJWTEh5MXp6ZFJGUVUyZjNmVC9mc0k0?=
 =?utf-8?B?bmM0OGt1S2V1dWE1MUJLekpPSWRjU3JiOE81cUpRNTlDU2dKRmNKKzNBOE02?=
 =?utf-8?B?ckdPbWpkKzBqc0YwQ0NRRHQvblI4RGlPTlNzajFMRkZuRXN6ekJSU3NGQW9S?=
 =?utf-8?B?ZXR6SHFITEtQMmJVUXZwNkF2ejh0Uy95SGNZM0hhTUxnYTloVXYwQ2dJTUt2?=
 =?utf-8?B?THV3b2QvSEZBZDloY2dnZjI2S1dFVnpCdWsxZXcwdmhPTzJzWmZ3TXI4eFdT?=
 =?utf-8?B?b0FmbmphYTFFbTIzb3JKNDJYYWlRWmZ1KysyWllyazBsT2t5TFNQeHB6QnRD?=
 =?utf-8?B?MHltUHU3MEU2SkV4bVB0NUd4N3pCdklaUzBrOFVQVjlFL0pJRXludXdxS2ZX?=
 =?utf-8?B?OWxHS3c2U3UvQ0phMU5nb21wVVp4Mk01ci84SXZMRXRGUTVhdzd2RFJGSFVk?=
 =?utf-8?B?VHZ1Nm9xbTlZUUFTbDJBTEJaTlhqeUtGUUhBaWsvL1VGbDBKcU1GbkZuU1V1?=
 =?utf-8?B?dU4yWkZhbDAvV0trWjhFT2VxQUp4ZDdvMVdJK1MwZjRMUDdhcm0rYnFTblhZ?=
 =?utf-8?B?MWZnK1NoSHI4VnpjUWtaQnNDWElYN1ZwdTluYWtSODd6RHp5Sm5EOGdTbmF4?=
 =?utf-8?B?WVpQd0dTc3dvQUp5WU9BZnYwS0FUWUl6d2hCTnRTRGorUmJmeElaRnR3MTl6?=
 =?utf-8?B?MlVnVUtOdDU5OXp3Ri9WVGNYQkd0OGE1WEdYRzhyYTlsbm1DM2x4ME8xRHF0?=
 =?utf-8?B?Vzg3YU9mOS9OYjdQVVFQY3lUOUl3VWlPOXZaRmM4MXdmR2FCVlRJZngrTkF2?=
 =?utf-8?B?b1ZCRnNHTWhGUm9IZThTelZBREJOSmRmY0VXa3l6VTVaazIrK2xSTEgvVTdK?=
 =?utf-8?B?U1IwU0RIc01tUmZvZURxWHE0YUhkMVBHWitPclFjL0VlTC9uUHZBY0s2aGpL?=
 =?utf-8?B?VnZFNXEzZThPQm1yQ1BRZXNCY2llRFlubktPUnlqalJWTUFFZ3J6cFJLbWhF?=
 =?utf-8?B?MkJRV3ovcmMyVjhuY3dLWnhlSU1kOW8yRmVscU0ycHFZVVAxYzJabk51VmRp?=
 =?utf-8?B?bkk3NVJETVhiOWpBaWVoNENsLzg1MC9lRDZFdjlDNEdRTE9yd0NQK21WWEFR?=
 =?utf-8?B?Rk56aHozVDk2OGJKaXJEOWtGUVJIRk9WTVE4clc5eVMvSUJiV05UUEN3cmxK?=
 =?utf-8?Q?seemUFq6gtmtEXzpvS?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5032.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ff080b7-9c08-43b3-40da-08df01e0d8f4
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Aug 2026 13:08:53.4055 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CVJhnlGn896gmItvqMU9vFgi57J9GOvYVD8se10QoHVDZQPpWuH7mtX0Bq4lcz3z
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8658
Received-SPF: permerror client-ip=52.101.48.5;
 envelope-from=neal.frager@amd.com;
 helo=MW6PR02CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

QU1EIEdlbmVyYWwNCg0KSGkgU3Rld2FydCwNCg0KPiBUaGUgLUkkKFhFTl9ST09UKS90b29scy9p
bmNsdWRlIGFkZGVkIHRvIFFFTVUncyBleHRyYS1jZmxhZ3MgY2F1c2VzDQo+IF9fWEVOX0lOVEVS
RkFDRV9WRVJTSU9OX18gdG8gYmUgZGVmaW5lZCBiZWZvcmUgeGVuX25hdGl2ZS5oIGlzIGluY2x1
ZGVkLA0KPiB0cmlnZ2VyaW5nIGFuIGluY2x1ZGUtb3JkZXIgYXNzZXJ0aW9uLiBEb3duZ3JhZGUg
dG8gYSB3YXJuaW5nIHNpbmNlIHRoZQ0KPiB2ZXJzaW9uIGlzIGNvbnNpc3RlbnQgaW4gY3Jvc3Mt
Y29tcGlsZS4NCj4gUmVmOiBodHRwczovL2dpdGh1Yi5jb20vcWVtdS9xZW11L2NvbW1pdC9lMmFi
ZmU1ZWM2DQo+DQo+IFNpZ25lZC1vZmYtYnk6IE5lYWwgRnJhZ2VyIDxuZWFsLmZyYWdlckBhbWQu
Y29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBWaW5jZW50IFN0ZWhsw6kgPHZpbmNlbnQuc3RlaGxlQGFy
bS5jb20+DQo+IC0tLQ0KPiAgaW5jbHVkZS9ody94ZW4veGVuX25hdGl2ZS5oIHwgMiArLQ0KPiAg
MSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQo+DQo+IGRpZmYg
LS1naXQgYS9pbmNsdWRlL2h3L3hlbi94ZW5fbmF0aXZlLmggYi9pbmNsdWRlL2h3L3hlbi94ZW5f
bmF0aXZlLmgNCj4gaW5kZXggNWNhZjkxYTYxNi4uM2UxMTM3ZWZjMSAxMDA2NDQNCj4gLS0tIGEv
aW5jbHVkZS9ody94ZW4veGVuX25hdGl2ZS5oDQo+ICsrKyBiL2luY2x1ZGUvaHcveGVuL3hlbl9u
YXRpdmUuaA0KPiBAQCAtMiw3ICsyLDcgQEANCj4gICNkZWZpbmUgUUVNVV9IV19YRU5fTkFUSVZF
X0gNCj4NCj4gICNpZmRlZiBfX1hFTl9JTlRFUkZBQ0VfVkVSU0lPTl9fDQo+IC0jZXJyb3IgSW4g
WGVuIG5hdGl2ZSBmaWxlcywgaW5jbHVkZSB4ZW5fbmF0aXZlLmggYmVmb3JlIG90aGVyIFhlbiBo
ZWFkZXJzDQo+ICsjd2FybmluZyBJbiBYZW4gbmF0aXZlIGZpbGVzLCBpbmNsdWRlIHhlbl9uYXRp
dmUuaCBiZWZvcmUgb3RoZXIgWGVuIGhlYWRlcnMNCj4gICNlbmRpZg0KPg0KPiAgLyoNCg0KDQo+
IFRoaXMgaXMgYSBidWlsZHJvb3QgaXNzdWUsIHNvIEkgZG9uJ3QgYmVsaWV2ZSBpdCdzIG5lY2Vz
c2FyeSB0byBmaXggZnJvbSB0aGUNCj4gcWVtdSBzaWRlLg0KDQpJIGFtIG5vdCBzdXJlIEkgZnVs
bHkgYWdyZWUgaGVyZS4gV2hpbGUgdGhpcyBpcyBhIGJ1aWxkcm9vdCBpZGVudGlmaWVkIGlzc3Vl
LA0KdGhlcmUgY291bGQgYmUgb3RoZXIgdXNlIGNhc2VzIGZvciBfX1hFTl9JTlRFUkZBQ0VfVkVS
U0lPTl9fIHRvIGJlIGRlZmluZWQNCmJlZm9yZSB4ZW5fbmF0aXZlLmggaXMgaW5jbHVkZWQuIEFu
ZCB3aGF0IHdlIGhhdmUgZm91bmQgaXMgdGhhdCBpZg0KX19YRU5fSU5URVJGQUNFX1ZFUlNJT05f
XyB0byBiZSBkZWZpbmVkIGJlZm9yZSB4ZW5fbmF0aXZlLmggaXMgaW5jbHVkZWQsIGl0DQppcyBu
b3QgYSBoYXJkIGVycm9yLiAgRm9yIGJ1aWxkcm9vdCwgdGhlIHFlbXUgd29ya3MganVzdCBmaW5l
IGluIHNwaXRlIG9mDQp0aGlzLg0KDQpTaW5jZSBpdCBpcyBub3QgYSBoYXJkIGVycm9yIGNvbmRp
dGlvbiwgSSBzdGlsbCBiZWxpZXZlIGl0IHNob3VsZCBiZQ0KZG93bmdyYWRlZCB0byBhIHdhcm5p
bmcgaW5zdGVhZCBvZiBhbiBlcnJvci4NCg0KQW5kIHRodXMsIEkgd291bGQgc3RpbGwgbGlrZSB0
aGlzIHBhdGNoIHRvIGJlIGNvbnNpZGVyZWQgZm9yIHRoZSB1cHN0cmVhbQ0KcWVtdS4NCg0KQmVz
dCByZWdhcmRzLA0KTmVhbCBGcmFnZXINCkFNRA0K

