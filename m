Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E581FC54E58
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Mar 2024 08:59:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rm8pJ-0007bL-9R; Mon, 18 Mar 2024 04:58:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Jiqian.Chen@amd.com>)
 id 1rm8pH-0007bC-Kk
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 04:58:35 -0400
Received: from mail-co1nam11on20600.outbound.protection.outlook.com
 ([2a01:111:f403:2416::600]
 helo=NAM11-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Jiqian.Chen@amd.com>)
 id 1rm8pF-0002PF-DA
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 04:58:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bBF/vegubtIrGz/mjoLJ5kfBtF969McNVxfRV4HIr48ewLHTclfqmhROkeVXmubZ+/CvDvzydzPwrkJv9bCi1nrrlAJWUyK0aKOPClJjo+hqmYisqKXfxhCdvjTaXJkh6L2CTbNcLDeF2GTA0r1GVdRk3nVtkQmx5ans1dsE4TGxORG6Wr8ev/1PYTLmpYXss51sbzI+0iJTt01l/8HwKSRXVPQ3+xprw5NXa6wE/uqhNQppyGhBTYs87F0NvDLvs07apelxiT+1jX4M1fEYngyeQQjJ8ry70SocByfYzYu9ozSJ4FM7HFQHkVdlmR+Hj5QWOGqaBJDBdA7o4ZAkMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cK6hVhQNfpPIFxbPF3u9fOKvIRqD8l64leydr5zdUNE=;
 b=f99lO2flvGhiconAWmmOEfyQ7lm60EIy1HV1jdX6y6CqGF9DKQwtdwhF4VXmogF+rY648T1EPdRVdyKt0h+bD4loqLqYtH4488tJuiKXm2o02uyjrePdfjt3r0qfoY2FahBYo73DOO5iGwH4RbFxvqcSFJXWSUM/kb7Cb2uCDgFS3DxIG06SVRfdco37v4eUaGUGmwJd44lGqcS02mjjC8nBVniRIrkXM28//54NEbuD9Lo5kyHOXLceu2Dzo2FBb5r1OxO3wPB+tCGyEcejxw45rAJWjUegw8b44uK0Qk5f6Y6hG+UqE7dsIRPjvduNfr/wtZHpNhP7wWcsAznk9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cK6hVhQNfpPIFxbPF3u9fOKvIRqD8l64leydr5zdUNE=;
 b=mBckf7phvANMt/Eu0W04lswe4jktmOg47UOi1MVr2weiKIUsmUkXI3LikvNqQbdcSwXakqNzgDCoIFMBfQQdila+VdSl/hM4+NtQKpQWd17+O7OM+hv9OYICb2n6/adrAeyNMwrHnCRMfBw7vPNwqK4zFVDf3AlItzL8Dwo/pFM=
Received: from BL1PR12MB5849.namprd12.prod.outlook.com (2603:10b6:208:384::18)
 by SJ0PR12MB7006.namprd12.prod.outlook.com (2603:10b6:a03:486::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.26; Mon, 18 Mar
 2024 08:58:28 +0000
Received: from BL1PR12MB5849.namprd12.prod.outlook.com
 ([fe80::debf:178c:f5df:5efa]) by BL1PR12MB5849.namprd12.prod.outlook.com
 ([fe80::debf:178c:f5df:5efa%6]) with mapi id 15.20.7386.025; Mon, 18 Mar 2024
 08:58:28 +0000
From: "Chen, Jiqian" <Jiqian.Chen@amd.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "Chen, Jiqian"
 <Jiqian.Chen@amd.com>
Subject: Re: [QEMU PATCH v6 1/1] virtio-pci: implement No_Soft_Reset bit
Thread-Topic: [QEMU PATCH v6 1/1] virtio-pci: implement No_Soft_Reset bit
Thread-Index: AQHaZUDlDwXKf6cnZ0GccbPmz2mnprE9SzkAgACJsYA=
Date: Mon, 18 Mar 2024 08:58:28 +0000
Message-ID: <BL1PR12MB58496A5ED04C4C2DE65ADBB9E72D2@BL1PR12MB5849.namprd12.prod.outlook.com>
References: <20240222034010.887390-1-Jiqian.Chen@amd.com>
 <20240222034010.887390-2-Jiqian.Chen@amd.com>
 <20240318035505-mutt-send-email-mst@kernel.org>
In-Reply-To: <20240318035505-mutt-send-email-mst@kernel.org>
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
x-ms-traffictypediagnostic: BL1PR12MB5849:EE_|SJ0PR12MB7006:EE_
x-ms-office365-filtering-correlation-id: 76e7a012-0b37-4376-5dee-08dc4729942a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nG5D6TiHSg9ij78MbLu+CBduslIHDJnTCnl69uNZz7U2ViE1ccbbiL4QA4OCEv2tV1qpZ+MURUa6Px0UiYJ1QXalm5LghVqhTRPrysjAMYCKzOJmuDGkBqGR4tQgwjd2TJ1Xgx61BPR9D9IJ8xQeuUfgDl4xRAbgPNjc89kHOKo2x/OXana/Zwrz8u25sesJVKG5H1J2vAWObc83Xz63ZyScb/jrEf1OF5TOYSZd+GUKyTGBFAvxFLsXpcpd0qWuXik6iDlu8ODki8p3bLeLa3XMTM6wkT0jqJpmRPBQMEBwO+Qw+yy8ldqN5UWO2yqfx7VRDE2SpZ8k2wXG9Yvyps7gXExfExeytWZJCxXw/+cKE3Oq4z+y++4pGGpV1sdkYRyHcy3lPhaYOTWkBcx2b0yyUr5LdRDw7SB7bgLbKvceSY+/YxyNuOizR0Jc31JfzsFOmCWJu+tR+2fc+SCIG+u2p6ungYlVPh78q6PwEqeE/mlKk2PSn+i8dcWVR2rUyP6r+baJZuLbv1/Rm4dAnAHs4HjQu1TCSUgsh/vjDuVqqX3DjeyWZL0A9DX/NQg3LGTylKp9LDpA826+NKCyiWjTTEjMP3aCTui0bFLIy/FIDFgkDmGtagVIxoyB3eHBUNLCbk9ToApNf+a1ZxQzhseipaslmvuBhw+V5oMBFPGuZPmP1KfPAKkNgXaZavNIS2XbS0w0oL/F+6XnNst/MIkxu/7QM95NX8ElgzdxOIs=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5849.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(366007)(1800799015)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eWFBMDV6UWVZRER3NXkwSHJ4ZXRaWUFqYTJVcGE4OUtSZjVjSWREcGRrcGZp?=
 =?utf-8?B?ZkQxY29qSmhvWE1nNFI5RDlkWUN4OTZnVTVvOTR1d3kxTUsxQUlaU040ZG05?=
 =?utf-8?B?bVNOcHFKcWVhQ0RZM29lY29FdEhFRjQ3c1Z4dlFZS0x4aFpibGZaU2FOb0lq?=
 =?utf-8?B?RWd0ZDgwQitLeTBlSWJCTjBnbjI5b2dyL3lvVnh6bWNsQWtkNGUwa05JaW90?=
 =?utf-8?B?SjJVdkNCYUdRczdDbUxldkFQbnRxUTh1ZU9vaTVUalhaYWtESi9oaXB2c0sz?=
 =?utf-8?B?QnluVUhtdHpZdE82azk1eEN3UGVmbEo1MndkM1V2Yzh2SEhjS2lCVExYUkps?=
 =?utf-8?B?Y0FhOEFqOFhJc1BocEtyMTVqVTNjZzdlWFFpVkZ0a2l2QkkvRldSUlJ5ak5n?=
 =?utf-8?B?b0VEYmxXUy9yRmVjWWtjMURlMDAyWUxDdW5xWDlERy80OHNuMnQwV0VQalVM?=
 =?utf-8?B?ckxDYUI0T0VGL0VRaFFuMlEyKzJYRjdtdlljeENhcWZJWFJKV2J5Z3N0R0tj?=
 =?utf-8?B?dmxiOVBIeHM5TWh0QXEvZjNpVVN5V2NKREtqSmRGZGR4UGRvcmZqeHJMZzJO?=
 =?utf-8?B?Q2Z5SDhYenJKNis1K09RRGVzQ1BRREhrQU9XQTd2ZnVhRXhKcklTUXptSkRP?=
 =?utf-8?B?cjFlaFpiU255cW9oeVNUOGZQWDI0VEdGMVh6SXdydDlsSEllbHU2U3RnY0M2?=
 =?utf-8?B?aVpEdktISzlpaTIxWUVZRS9SQ0ozejRuUnl5WHhRejh3bStPUy9TNWlRbWFu?=
 =?utf-8?B?eHBqZ2lSYmMyLzJNSFhaVnJnSXY2YVZiazFFVldkbmFlTXhBSWxabGpuZThi?=
 =?utf-8?B?WU1Pc29TT0VaNlIvU0Y1NkUxZWc2aW1aclRzRzJ0VGQ2cnh6R2lQZzM2bldX?=
 =?utf-8?B?QlM1YVVveGlEM0NUN1NQUEVlUUdUZFVjbVpNNFVYeTA5aG1HcTR1U0VMVUNp?=
 =?utf-8?B?S2t4VFBoZW1LcXdVY2ltMk5QQnBYaklTYWw1L3VNVTU4OHdqZ3F5TzdZZldD?=
 =?utf-8?B?TlB2eHBROUxXZUFwdjR0R0kyUTFsR0VBQWtqOHZLOVFNaCtyNXN1cHdWMUYw?=
 =?utf-8?B?TG80eDIxQUZCbEN3ckxodWhheVFiK2xuNmltSXVOWHBGbXhxQzdSbVdNemdF?=
 =?utf-8?B?NXVUYi9CaXdWQlMreVVBMllmYjZnbVV6a3NsOW12VVZXSUMyWEVGUDc0L0g2?=
 =?utf-8?B?VkJaRWFRNXRzN0YyQlkzZ0dqakJsNWU3QXRoUlg5QnZSQTYzZnFEbFlBRTRH?=
 =?utf-8?B?dmR6ak5YeURnVDRuVmVCWDFZenRMclNVNkdPdVAzZ0pVbDhmTXB5cEQya3Jz?=
 =?utf-8?B?TjB2OWhxQ21neHJ4N1dWMHBwS1BuSFJxU2pzSkhGMG9qU2FVR1R0UmthZTMw?=
 =?utf-8?B?aDVuL2RMWFVGaHI1Q0tjaFZ3Z1RETVUzcGg1ZTNBQlVzQ3FhYnF6Z3JoQmlG?=
 =?utf-8?B?K25KTFpJUUFrQlk1TTR4Y0h5MFczTzdMUFd0NzNZOUYzT2VRMWluOThvMktp?=
 =?utf-8?B?cU1aeTdSbFpuRUpVZTd5cTgxMzcwVVg0eFliclFhNkVuRWJ3YlIraXMwWXFW?=
 =?utf-8?B?UVkyRDRDbDM1b0xhWkc2QUU3WkxDMEQrVDcvb2oyQlU1YzRBeS85dG5NR1Y2?=
 =?utf-8?B?UG1vU1BFZFpsY25XVjROZkF6Z1Y0ZjdPODd4cFBDc3BVMzFLUXNHN2JSbmFX?=
 =?utf-8?B?clJIMW5GQUFXSDlrT1pwSUpSR3lQUTdNbXJBTEY5cEpRVTk2WGZiMjh2MlR2?=
 =?utf-8?B?cmRFVU5neWNBY2VlcFBYcXNkY3hCeEtDVFIyT3gzN2ZhNmIwbGRUWjJJNjlv?=
 =?utf-8?B?RVhqdEUrRFhLcnNlWVNIUm5hN3dKaTZic0Y0ZStGOWZvMlorMC9IU2ozVWJ2?=
 =?utf-8?B?Y05qcTA0cjR3d28zd0tSNHZ0bFFGb2Z1YkdFRm5LRnh5bHZjVjVVRjZxdGgy?=
 =?utf-8?B?d29QS0FRRFRYQnkzUmhKTWZSNG5LREE2TVdkNGRWemFMZC8zQUdHM0NONTJp?=
 =?utf-8?B?YnZZNllCMDd1NFgzU3BiS2dzUmlkaDQ0dDhGa3NTVm83bXNJL2xCYjNKZ3N5?=
 =?utf-8?B?amJMM1pRZWxqQmovSTJDajBDTWdJZkdjNlhUNDhvWjNvdituT1FXYWJHOUt3?=
 =?utf-8?Q?DoVw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CEA40E78762C3B45BF1762DF6F38C851@amdcloud.onmicrosoft.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76e7a012-0b37-4376-5dee-08dc4729942a
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2024 08:58:28.4411 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: M+N4C6fzbi9sJuyj9c5hG+1T1tYHxHJNKoTQiUqO+Fr2Q4vXxX06xA23ScurUf+tx8etXfG3InC5+dvJKzGZkA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7006
Received-SPF: permerror client-ip=2a01:111:f403:2416::600;
 envelope-from=Jiqian.Chen@amd.com;
 helo=NAM11-CO1-obe.outbound.protection.outlook.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.316,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

T24gMjAyNC8zLzE4IDE2OjA0LCBNaWNoYWVsIFMuIFRzaXJraW4gd3JvdGU6DQo+IE9uIFRodSwg
RmViIDIyLCAyMDI0IGF0IDExOjQwOjEwQU0gKzA4MDAsIEppcWlhbiBDaGVuIHdyb3RlOg0KPj4g
SW4gY3VycmVudCBjb2RlLCB3aGVuIGd1ZXN0IGRvZXMgUzMsIHZpcnRpbyBkZXZpY2VzIGFyZSBy
ZXNldCBkdWUgdG8NCj4+IHRoZSBiaXQgTm9fU29mdF9SZXNldCBpcyBub3Qgc2V0LiBBZnRlciBy
ZXNldHRpbmcsIHRoZSBkaXNwbGF5IHJlc291cmNlcw0KPj4gb2YgdmlydGlvLWdwdSBhcmUgZGVz
dHJveWVkLCB0aGVuIHRoZSBkaXNwbGF5IGNhbid0IGNvbWUgYmFjayBhbmQgb25seQ0KPj4gc2hv
dyBibGFuayBhZnRlciByZXN1bWluZy4NCj4+DQo+PiBJbXBsZW1lbnQgTm9fU29mdF9SZXNldCBi
aXQgb2YgUENJX1BNX0NUUkwgcmVnaXN0ZXIsIHRoZW4gZ3Vlc3QgY2FuIGNoZWNrDQo+PiB0aGlz
IGJpdCwgaWYgdGhpcyBiaXQgaXMgc2V0LCB0aGUgZGV2aWNlcyByZXNldHRpbmcgd2lsbCBub3Qg
YmUgZG9uZSwgYW5kDQo+PiB0aGVuIHRoZSBkaXNwbGF5IGNhbiB3b3JrIGFmdGVyIHJlc3VtaW5n
Lg0KPj4NCj4+IFNpZ25lZC1vZmYtYnk6IEppcWlhbiBDaGVuIDxKaXFpYW4uQ2hlbkBhbWQuY29t
Pg0KPj4gLS0tDQo+PiAgaHcvdmlydGlvL3ZpcnRpby1wY2kuYyAgICAgICAgIHwgMzcgKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrLQ0KPj4gIGluY2x1ZGUvaHcvdmlydGlvL3ZpcnRp
by1wY2kuaCB8ICA1ICsrKysrDQo+PiAgMiBmaWxlcyBjaGFuZ2VkLCA0MSBpbnNlcnRpb25zKCsp
LCAxIGRlbGV0aW9uKC0pDQo+Pg0KPj4gZGlmZiAtLWdpdCBhL2h3L3ZpcnRpby92aXJ0aW8tcGNp
LmMgYi9ody92aXJ0aW8vdmlydGlvLXBjaS5jDQo+PiBpbmRleCAxYTcwMzlmYjBjNjguLmRhNTMx
MjAxMDM0NSAxMDA2NDQNCj4+IC0tLSBhL2h3L3ZpcnRpby92aXJ0aW8tcGNpLmMNCj4+ICsrKyBi
L2h3L3ZpcnRpby92aXJ0aW8tcGNpLmMNCj4+IEBAIC0yMTk3LDYgKzIxOTcsMTEgQEAgc3RhdGlj
IHZvaWQgdmlydGlvX3BjaV9yZWFsaXplKFBDSURldmljZSAqcGNpX2RldiwgRXJyb3IgKiplcnJw
KQ0KPj4gICAgICAgICAgICAgIHBjaWVfY2FwX2xua2N0bF9pbml0KHBjaV9kZXYpOw0KPj4gICAg
ICAgICAgfQ0KPj4gIA0KPj4gKyAgICAgICAgaWYgKHByb3h5LT5mbGFncyAmIFZJUlRJT19QQ0lf
RkxBR19QTV9OT19TT0ZUX1JFU0VUKSB7DQo+PiArICAgICAgICAgICAgcGNpX3NldF93b3JkKHBj
aV9kZXYtPmNvbmZpZyArIHBvcyArIFBDSV9QTV9DVFJMLA0KPj4gKyAgICAgICAgICAgICAgICAg
ICAgICAgICBQQ0lfUE1fQ1RSTF9OT19TT0ZUX1JFU0VUKTsNCj4+ICsgICAgICAgIH0NCj4+ICsN
Cj4+ICAgICAgICAgIGlmIChwcm94eS0+ZmxhZ3MgJiBWSVJUSU9fUENJX0ZMQUdfSU5JVF9QTSkg
ew0KPj4gICAgICAgICAgICAgIC8qIEluaXQgUG93ZXIgTWFuYWdlbWVudCBDb250cm9sIFJlZ2lz
dGVyICovDQo+PiAgICAgICAgICAgICAgcGNpX3NldF93b3JkKHBjaV9kZXYtPndtYXNrICsgcG9z
ICsgUENJX1BNX0NUUkwsDQo+IA0KPiANCj4gRG9uJ3Qgd2UgbmVlZCBjb21wYXQgbWFjaGluZXJ5
IHRvIGF2b2lkIGJyZWFraW5nIG1pZ3JhdGlvbiBmb3INCj4gZXhpc3RpbmcgbWFjaGluZSB0eXBl
cz8NCkNvdWxkIHlvdSBlbGFib3JhdGUgb24gaXQ/IEkgYW0gc29ycnkgSSBkb24ndCBrbm93IHdo
aWNoIG1hY2hpbmUgdHlwZXMgdG8gYmUgY29tcGF0aWJsZSB3aXRoLCBhbmQgaG93IHRvIGJlIGNv
bXBhdGlibGUgd2l0aCB0aGVtLg0KQ2FuIEkgc2ltcGx5IHNldCB0aGUgZGVmYXVsdCB2YWx1ZSBv
ZiB4LXBjaWUtcG0tbm8tc29mdC1yZXNldCB0byBmYWxzZT8gSWYgc29tZW9uZSBuZWVkIHRoaXMg
Yml0LCB0aGV5IGNhbiBzZXQgeC1wY2llLXBtLW5vLXNvZnQtcmVzZXQ9dHJ1ZSBpbiB0aGUgY29u
ZmlnIHBhcmFtZXRlcnMgZm9yIFFlbXUuIFNvIHRoYXQgd2lsbCBub3QgYWZmZWN0IGV4aXRpbmcg
bWFjaGluZSB0eXBlcz8NCg0KPiANCj4+IEBAIC0yMjU5LDE4ICsyMjY0LDQ2IEBAIHN0YXRpYyB2
b2lkIHZpcnRpb19wY2lfcmVzZXQoRGV2aWNlU3RhdGUgKnFkZXYpDQo+PiAgICAgIH0NCj4+ICB9
DQo+PiAgDQo+PiArc3RhdGljIGJvb2wgZGV2aWNlX25vX25lZWRfcmVzZXQoUENJRGV2aWNlICpk
ZXYpDQo+PiArew0KPj4gKyAgICBpZiAocGNpX2lzX2V4cHJlc3MoZGV2KSkgew0KPj4gKyAgICAg
ICAgdWludDE2X3QgcG1jc3I7DQo+PiArDQo+PiArICAgICAgICBwbWNzciA9IHBjaV9nZXRfd29y
ZChkZXYtPmNvbmZpZyArIGRldi0+ZXhwLnBtX2NhcCArIFBDSV9QTV9DVFJMKTsNCj4+ICsgICAg
ICAgIC8qDQo+PiArICAgICAgICAgKiBXaGVuIE5vX1NvZnRfUmVzZXQgYml0IGlzIHNldCBhbmQg
ZGV2aWNlDQo+IA0KPiB0aGUgZGV2aWNlDQpXaWxsIGNoYW5nZSBpbiBuZXh0IHZlcnNpb24uDQo+
IA0KPj4gKyAgICAgICAgICogaXMgaW4gRDNob3Qgc3RhdGUsIGNhbid0IHJlc2V0IGRldmljZQ0K
PiANCj4gY2FuJ3Q/IG9yIGRvbid0Pw0KV2lsbCBjaGFuZ2UgdG8gImRvbid0IiBpbiBuZXh0IHZl
cnNpb24uDQoNCj4gDQo+PiArICAgICAgICAgKi8NCj4+ICsgICAgICAgIGlmICgocG1jc3IgJiBQ
Q0lfUE1fQ1RSTF9OT19TT0ZUX1JFU0VUKSAmJg0KPj4gKyAgICAgICAgICAgIChwbWNzciAmIFBD
SV9QTV9DVFJMX1NUQVRFX01BU0spID09IDMpDQo+PiArICAgICAgICAgICAgcmV0dXJuIHRydWU7
DQo+IA0KPiBjb2Rpbmcgc3R5bGUgdmlvbGF0aW9uDQpXaWxsIGFkZCBicmFjZXMge30gaW4gbmV4
dCB2ZXJzaW9uLg0KDQo+IA0KPj4gKyAgICB9DQo+PiArDQo+PiArICAgIHJldHVybiBmYWxzZTsN
Cj4+ICt9DQo+PiArDQo+PiAgc3RhdGljIHZvaWQgdmlydGlvX3BjaV9idXNfcmVzZXRfaG9sZChP
YmplY3QgKm9iaikNCj4+ICB7DQo+PiAgICAgIFBDSURldmljZSAqZGV2ID0gUENJX0RFVklDRShv
YmopOw0KPj4gICAgICBEZXZpY2VTdGF0ZSAqcWRldiA9IERFVklDRShvYmopOw0KPj4gIA0KPj4g
KyAgICBpZiAoZGV2aWNlX25vX25lZWRfcmVzZXQoZGV2KSkNCj4+ICsgICAgICAgIHJldHVybjsN
Cj4+ICsNCj4+ICAgICAgdmlydGlvX3BjaV9yZXNldChxZGV2KTsNCj4+ICANCj4+ICAgICAgaWYg
KHBjaV9pc19leHByZXNzKGRldikpIHsNCj4+ICsgICAgICAgIHVpbnQxNl90IHBtY3NyOw0KPj4g
KyAgICAgICAgdWludDE2X3QgdmFsID0gMDsNCj4+ICsNCj4+ICAgICAgICAgIHBjaWVfY2FwX2Rl
dmVycl9yZXNldChkZXYpOw0KPj4gICAgICAgICAgcGNpZV9jYXBfbG5rY3RsX3Jlc2V0KGRldik7
DQo+PiAgDQo+PiAtICAgICAgICBwY2lfc2V0X3dvcmQoZGV2LT5jb25maWcgKyBkZXYtPmV4cC5w
bV9jYXAgKyBQQ0lfUE1fQ1RSTCwgMCk7DQo+PiArICAgICAgICAvKiBkb24ndCByZXNldCB0aGUg
Uk8gYml0cyAqLw0KPj4gKyAgICAgICAgcG1jc3IgPSBwY2lfZ2V0X3dvcmQoZGV2LT5jb25maWcg
KyBkZXYtPmV4cC5wbV9jYXAgKyBQQ0lfUE1fQ1RSTCk7DQo+PiArICAgICAgICB2YWwgPSB2YWwg
fCAocG1jc3IgJiBQQ0lfUE1fQ1RSTF9OT19TT0ZUX1JFU0VUKSB8DQo+PiArICAgICAgICAgICAg
ICAgIChwbWNzciAmIFBDSV9QTV9DVFJMX0RBVEFfU0NBTEVfTUFTSyk7DQo+PiArICAgICAgICBw
Y2lfc2V0X3dvcmQoZGV2LT5jb25maWcgKyBkZXYtPmV4cC5wbV9jYXAgKyBQQ0lfUE1fQ1RSTCwg
dmFsKTsNCj4gDQo+IEZpcnN0LCB3ZSBoYXZlIHRlc3QgYW5kIGNsZWFyIGZvciB0aGlzLg0KPiAN
Cj4gU2Vjb25kLCB0aGlzIGhhcyB0byBiZSBjb25kaXRpb25hbCBvbiB0aGUgZmxhZywgbm8/DQpC
ZWZvcmUgcmVzZXR0aW5nLCBJIGZpcnN0IHJlYWQgdGhlIHZhbHVlIG9mIGNvbmZpZywgaXRzIGZ1
bmN0aW9uIGlzIGVxdWl2YWxlbnQgdG8gY2hlY2tpbmcgdGhlIGxhYmVsLCByaWdodD8NCklmIHRo
ZSBmbGFnIGlzIHNldCwgdGhlIHZhbHVlIG9mIE5vX1NvZnRfUmVzZXQgaXMgMSwgdGhlIGJpdCBv
ZiAidmFsIiBpcyBhbHNvIDEuDQpJZiB0aGUgZmxhZyBpcyBub3Qgc2V0LCB0aGUgdmFsdWUgb2Yg
Tm9fU29mdF9SZXNldCBpcyAwLCAidmFsIiBpcyBhbHNvIDAuDQoNCj4gV2l0aG91dCB0aGUgZmxh
ZyBkb24ndCB3ZSByZXNldCBldmVyeXRoaW5nPw0KV2UgbmVlZCByZXNldCBldmVyeXRoaW5nIGlu
Y2x1ZGUgdGhlIFJPIGJpdCwgcmlnaHQ/DQpJZiBzbywgdGhhdCBpcyBteSBmYXVsdCwgdGhlbiBJ
IHdpbGwgY2hhbmdlIHRvIGNoZWNrIHRoZSBmbGFnIG9mIHByb3h5IGluIG5leHQgdmVyc2lvbi4N
Cg0KPiBPciB5b3UgY2FuIHJldXNlIHdtYXNrIGZvciB0aGlzLCBhbHNvIGFuIG9wdGlvbi4NCj4g
DQo+IEFsc28gd2hhdCdzIGdvaW5nIG9uIHdpdGggUENJX1BNX0NUUkxfREFUQV9TQ0FMRV9NQVNL
Pw0KPiBXaGVyZSBkb2VzIHRoYXQgY29tZSBmcm9tPw0KSSByZWFkIGZyb20gUENJIHNwZWMsIHRo
ZSBiaXQgREFUQV9TQ0FMRSBhbmQgTm9fU29mdF9SZXNldCBhcmUgYm90aCBSTyBiaXQsIHNvIEkg
dGhvdWdodCB3ZSBzaG91bGRuJ3QgcmVzZXQgdGhlbS4NCkl0IGlzIHNvbWV0aGluZyB3cm9uZyB3
aXRoIG15IHVuZGVyc3RhbmRpbmcsIEkgd2lsbCByZW1vdmUgUENJX1BNX0NUUkxfREFUQV9TQ0FM
RV9NQVNLIGluIG5leHQgdmVyc2lvbi4gU29ycnkuDQoNCj4gDQo+PiAgICAgIH0NCj4+ICB9DQo+
PiAgDQo+PiBAQCAtMjI5Nyw2ICsyMzMwLDggQEAgc3RhdGljIFByb3BlcnR5IHZpcnRpb19wY2lf
cHJvcGVydGllc1tdID0gew0KPj4gICAgICAgICAgICAgICAgICAgICAgVklSVElPX1BDSV9GTEFH
X0lOSVRfTE5LQ1RMX0JJVCwgdHJ1ZSksDQo+PiAgICAgIERFRklORV9QUk9QX0JJVCgieC1wY2ll
LXBtLWluaXQiLCBWaXJ0SU9QQ0lQcm94eSwgZmxhZ3MsDQo+PiAgICAgICAgICAgICAgICAgICAg
ICBWSVJUSU9fUENJX0ZMQUdfSU5JVF9QTV9CSVQsIHRydWUpLA0KPj4gKyAgICBERUZJTkVfUFJP
UF9CSVQoIngtcGNpZS1wbS1uby1zb2Z0LXJlc2V0IiwgVmlydElPUENJUHJveHksIGZsYWdzLA0K
Pj4gKyAgICAgICAgICAgICAgICAgICAgVklSVElPX1BDSV9GTEFHX1BNX05PX1NPRlRfUkVTRVRf
QklULCB0cnVlKSwNCj4+ICAgICAgREVGSU5FX1BST1BfQklUKCJ4LXBjaWUtZmxyLWluaXQiLCBW
aXJ0SU9QQ0lQcm94eSwgZmxhZ3MsDQo+PiAgICAgICAgICAgICAgICAgICAgICBWSVJUSU9fUENJ
X0ZMQUdfSU5JVF9GTFJfQklULCB0cnVlKSwNCj4+ICAgICAgREVGSU5FX1BST1BfQklUKCJhZXIi
LCBWaXJ0SU9QQ0lQcm94eSwgZmxhZ3MsDQo+PiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9ody92aXJ0
aW8vdmlydGlvLXBjaS5oIGIvaW5jbHVkZS9ody92aXJ0aW8vdmlydGlvLXBjaS5oDQo+PiBpbmRl
eCA1OWQ4ODAxOGMxNmEuLjllNjdiYTM4Yzc0OCAxMDA2NDQNCj4+IC0tLSBhL2luY2x1ZGUvaHcv
dmlydGlvL3ZpcnRpby1wY2kuaA0KPj4gKysrIGIvaW5jbHVkZS9ody92aXJ0aW8vdmlydGlvLXBj
aS5oDQo+PiBAQCAtNDMsNiArNDMsNyBAQCBlbnVtIHsNCj4+ICAgICAgVklSVElPX1BDSV9GTEFH
X0lOSVRfRkxSX0JJVCwNCj4+ICAgICAgVklSVElPX1BDSV9GTEFHX0FFUl9CSVQsDQo+PiAgICAg
IFZJUlRJT19QQ0lfRkxBR19BVFNfUEFHRV9BTElHTkVEX0JJVCwNCj4+ICsgICAgVklSVElPX1BD
SV9GTEFHX1BNX05PX1NPRlRfUkVTRVRfQklULA0KPj4gIH07DQo+PiAgDQo+PiAgLyogTmVlZCB0
byBhY3RpdmF0ZSB3b3JrLWFyb3VuZHMgZm9yIGJ1Z2d5IGd1ZXN0cyBhdCB2bXN0YXRlIGxvYWQu
ICovDQo+PiBAQCAtNzksNiArODAsMTAgQEAgZW51bSB7DQo+PiAgLyogSW5pdCBQb3dlciBNYW5h
Z2VtZW50ICovDQo+PiAgI2RlZmluZSBWSVJUSU9fUENJX0ZMQUdfSU5JVF9QTSAoMSA8PCBWSVJU
SU9fUENJX0ZMQUdfSU5JVF9QTV9CSVQpDQo+PiAgDQo+PiArLyogSW5pdCBUaGUgTm9fU29mdF9S
ZXNldCBiaXQgb2YgUG93ZXIgTWFuYWdlbWVudCAqLw0KPj4gKyNkZWZpbmUgVklSVElPX1BDSV9G
TEFHX1BNX05PX1NPRlRfUkVTRVQgXA0KPj4gKyAgKDEgPDwgVklSVElPX1BDSV9GTEFHX1BNX05P
X1NPRlRfUkVTRVRfQklUKQ0KPj4gKw0KPj4gIC8qIEluaXQgRnVuY3Rpb24gTGV2ZWwgUmVzZXQg
Y2FwYWJpbGl0eSAqLw0KPj4gICNkZWZpbmUgVklSVElPX1BDSV9GTEFHX0lOSVRfRkxSICgxIDw8
IFZJUlRJT19QQ0lfRkxBR19JTklUX0ZMUl9CSVQpDQo+PiAgDQo+PiAtLSANCj4+IDIuMzQuMQ0K
PiANCg0KLS0gDQpCZXN0IHJlZ2FyZHMsDQpKaXFpYW4gQ2hlbi4NCg==

