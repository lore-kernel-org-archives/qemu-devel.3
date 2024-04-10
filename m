Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EC46C67861
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2024 02:30:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ruNiB-0001UD-JG; Tue, 09 Apr 2024 22:29:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1ruNiA-0001TX-5H; Tue, 09 Apr 2024 22:29:18 -0400
Received: from esa16.fujitsucc.c3s2.iphmx.com ([216.71.158.33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1ruNi8-00041c-BH; Tue, 09 Apr 2024 22:29:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1712716156; x=1744252156;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=YSvbfLQVJp4GGZUwtuMh6pJ7/lyAaVdYhWHFxPemuds=;
 b=TfgT9MHyVdnL1hf2MgRdYQlRIPW+jGqWjZnTqlCgd0Tk2djSp4JGLvWL
 pMBAPqCb6+CiHSAia4F0kO2FtMh5bIvPCqchyNeZ5VbL3ZbyKbWB2VEh8
 Q6633GTxSOVOMoP/7lNPBuW25SZCFAqA6X1+Gbt+4BqOSAlxS54fv3dVp
 As6wa9bFp4BlLTA3BB6x+KSSyo9RLhIyj4XWV0PdHintzS2yrHK0EIg/6
 KZ4U2Oe/zqYoE6aBMBa9bbT7xAju7XN6X/W5PdO+YsRaVYzmC2MIExUV7
 JT5PLjMIVUM5dGo76Ib/eSA8DbNLf+1mV7S8HxEBY/MA7DimVy7B/wgoJ w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="116375723"
X-IronPort-AV: E=Sophos;i="6.07,190,1708354800"; d="scan'208";a="116375723"
Received: from mail-os0jpn01lp2105.outbound.protection.outlook.com (HELO
 JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.105])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Apr 2024 11:29:03 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LYwmPVDMbafu47EBY34xin5/JQeb3b+vCtRjhEVqqq7NOkaMNTyPbvW53YkImveoekKyVL+XC9YGqN7rVm9ItOJKaXuidXgfS2F7Sq39UZbrKnkMGgzbI0VozKVRU52ig3IKgQ3bNmAHlKyQcDVDhvMiloBJ1gRwxNBcg8zAQT8CNLbsWg9y5LrHXxCLorIhFLa80D8uJWYGl2jaL5w3P/TG6o1srq7peQYtk4uThJuRyNGa9Y+vrtZTBd6Ocaop5q2RUgScFUUVg8TlZ9urmr08kToQF4srxZIi/GY0wHiJm/7Py3TUngffE8qcwAU/JIJJCcq6h9SCWmVPUIqzaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YSvbfLQVJp4GGZUwtuMh6pJ7/lyAaVdYhWHFxPemuds=;
 b=gc7jfv4a5Xx2cCxj7tcW1z14wgpMuPXY+Qi5jXXwuo/cAHFHliQ0ZkFRY+MkpOAEPaPVVSXCrefB2rN4rzauDPEVqwbyNFel2TlSdwqSzsMZH9GeGwvH+CJF5/C5sCTKy6XTo2ReNiJeUDy8axCT2yaStT+GB/f8ftb49vCVvibIVS0joxQL6FvxxHizJ67VZJjomkNntgTYZ6bbjd4s1XTrIyhzg2j/5r4OgO5RhCRXNosHyZApTCQbrPSYgC99yHik+yOjbhEc1lFlnsjuvQxIC2M65L+RWLeXHuO5errd+6o1NLcgriwVUq1IStKgsQi835k5xX5K8gkh8t8W4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TYAPR01MB5818.jpnprd01.prod.outlook.com
 (2603:1096:404:8059::10) by TYCPR01MB7823.jpnprd01.prod.outlook.com
 (2603:1096:400:184::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Wed, 10 Apr
 2024 02:28:59 +0000
Received: from TYAPR01MB5818.jpnprd01.prod.outlook.com
 ([fe80::e69:40a6:944b:f974]) by TYAPR01MB5818.jpnprd01.prod.outlook.com
 ([fe80::e69:40a6:944b:f974%5]) with mapi id 15.20.7409.053; Wed, 10 Apr 2024
 02:28:59 +0000
To: Peter Xu <peterx@redhat.com>, Jinpu Wang <jinpu.wang@ionos.com>
CC: Yu Zhang <yu.zhang@ionos.com>, Elmar Gerdes <elmar.gerdes@ionos.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Yuval Shaia
 <yuval.shaia.ml@gmail.com>, Kevin Wolf <kwolf@redhat.com>, Prasanna Kumar
 Kalever <prasanna.kalever@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Michael Roth <michael.roth@amd.com>, Prasanna Kumar Kalever
 <prasanna4324@gmail.com>, "integration@gluster.org"
 <integration@gluster.org>, Paolo Bonzini <pbonzini@redhat.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 =?utf-8?B?RGFuaWVsIFAuIEJlcnJhbmfDqQ==?= <berrange@redhat.com>,
 "devel@lists.libvirt.org" <devel@lists.libvirt.org>, Hanna Reitz
 <hreitz@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Thomas Huth
 <thuth@redhat.com>, Eric Blake <eblake@redhat.com>, Song Gao
 <gaosong@loongson.cn>, =?utf-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?=
 <marcandre.lureau@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?utf-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, Wainer dos Santos
 Moschetta <wainersm@redhat.com>, Beraldo Leal <bleal@redhat.com>,
 "arei.gonglei@huawei.com" <arei.gonglei@huawei.com>, "pannengyuan@huawei.com"
 <pannengyuan@huawei.com>
Subject: Re: [PATCH-for-9.1 v2 2/3] migration: Remove RDMA protocol handling
Thread-Topic: [PATCH-for-9.1 v2 2/3] migration: Remove RDMA protocol handling
Thread-Index: AQHagRBhZe2HiRGZ1kqMYe8iGl3wH7FNM10AgAAMBgCAALZIAIAAkAAAgASMGwCAAOKZgIABkaUAgAjz/wCAACSFgIAA/5IAgADNDwCAAHBjgA==
Date: Wed, 10 Apr 2024 02:28:59 +0000
Message-ID: <082a21b0-d4d1-9f6c-24b5-bee56263008e@fujitsu.com>
References: <87frwatp7n.fsf@suse.de> <ZgWGMmUTq0jqSUvr@x1n>
 <7a510fbe-1c27-4f67-93b8-0d9cf01c1c74@fujitsu.com>
 <ef160e75-d4a4-4be0-81f3-77d8b0e76178@linaro.org>
 <9d082daf-acf0-27c5-1758-5a3f2af7ee0f@fujitsu.com>
 <CAHEcVy50AtvDyCjwPa9Hu+x1wiUF6xf5McGOTHL+wdt3WN3pgA@mail.gmail.com>
 <Zgx3brrz8m0V7HS4@x1n>
 <CAMGffE=i+hVCNaX_31h1D1VW7JGJBqoa9T0qEJe2CDcb9BPiAA@mail.gmail.com>
 <ZhQYu3ZnsIGv2qUZ@x1n>
 <CAMGffEm2TWJxOPcNQTQ1Sjytf5395dBzTCMYiKRqfxDzJwSN6A@mail.gmail.com>
 <ZhWa0YeAb9ySVKD1@x1n>
In-Reply-To: <ZhWa0YeAb9ySVKD1@x1n>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.1.1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYAPR01MB5818:EE_|TYCPR01MB7823:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /kwSybYIZABkUnB99c6MPAAlXz9xNip+fMDxahWyV7kkOB8zbBtCwY3erj9pfCFJOl+p2VXfbiar3lT+TYCYo/XSOTRv/XashZis4yAgTDIsoZ6DxXDSrMwESfXj/PvbzbNZLHmsrD/65AlL1TKLXm43zg3FZAq+iuUQdO2KVRem/+tsT0NUQzN5v+QPJTMimQJvDUkMCj9gFKxWa3i+m6Py3TS1Pq8d2Dyo06zlp1qtUAB4kCcyS5Nas1IAvoHytmO1eNSTI/12lj1AJwKWwz18bXQkTleZGwxqgBY3JJXJPUS/pChhZvfyHJB9N6JE5zleDNu2CVrmoEUCLk7gZLmLec9FkZFBOzjibaHDThrd8fNyWQtHzDWZTjKb8K5+0kS42xIcBxHqo9L+BMgNcK4bP20WbVEyWVKaOxpBnerfq6hfiB2C2jm9Gg7Wgud04CslNx9iw/PQ2YNY++Te//KzTnvFb4FlRv4G7sA36DuiPWF0kTBc9c/I9MJM2C8KEXbqygq78fsjPBbacoAnBdRdw7s1Dt/Oq2A4b/f0hseUZNH1Yf+R3tRAlH7apK3zaUS4jhPafoRXx1ZgEgOUpOODn3outd4VbemgROMoAMvBbFvWyXwJ6FGekBhnlDr/m7AmUbLU277xsdFrnZLMnNjo+aHYctvAX5oEt85t1G1PVxyTbCRihkp+Bhit7nz437d3/nyda46CEgFfbq0xKA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYAPR01MB5818.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(7416005)(376005)(1580799018); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YW5ObGowc2J5TFVPTTN3Z1RjRGZXdUpub0tUOUZpWGdYTGVlaHJjQkhGL1dv?=
 =?utf-8?B?U0lGR2ZRZDNnaGlQbGM5THpwWC95OS9IMGY2TWZhOUVFaHIzMmtycTF3eFk0?=
 =?utf-8?B?TldiOGpZOEtUOG1rWlluK280aHM1ckhCZU5TTXBuUkZ3d3RJM20zcVdQNG5n?=
 =?utf-8?B?SzN6b1lnYW04MUh1NWpkWFF5WFFYMllla0RvNXF6Yi9XMEc3WjhTVmlPbHpJ?=
 =?utf-8?B?ZUQrWVcxcEdMbmRSNjZKL2JGQXh5Q1YyU1o3eW5SWXB5UVpoRXVjQXlZWXhP?=
 =?utf-8?B?eWtWSkJkZmNId2Z5c3pOa2hMNHVYQ0pnbkpnRit1WVlNaGZtNUZtdGRyKzJI?=
 =?utf-8?B?ZHlYLzZFdDEyd2hYTFNSc2I5VjJJTG9XUWxrTUVNelhBNENmUXhRTWl0UXJJ?=
 =?utf-8?B?c0JtcFpKZDFNdG52TDBxN3A0c2RQcGs3K0duNzVqaFFTYkIxbERJUnBIU01G?=
 =?utf-8?B?blM1U1dBNUZ6Y2wzU0sySy9xRlp2QzBWSWVZTWpWZ0RRQUFVbUROL0tnQUxP?=
 =?utf-8?B?a3pIMmwvOUpJSlpOc2YxVmxIOTcwZ3RrdWJnMXFSMlRUQW1zQjBsTUs1MnlR?=
 =?utf-8?B?d3I2eEIzZ1ZOa0kzZUpFNm01dHdUOXdjS0NhY3N6SWJvOTNFaGJrL0pDNVF5?=
 =?utf-8?B?TXVqeW1WbEwvMXlFM3VVcFRJMXlxU1o0K0owV001Q2JNeXdlaHFLbk9GclNQ?=
 =?utf-8?B?NXdHTE1mL3lodjhNS1puRGNoOVZudVdQcVEwT1h1VnRxRnpuK0RSMGlYaEVw?=
 =?utf-8?B?NkZoNU5LanU5b2crUTA1Y1NFZUxuQnlUemJvUTV4M0RRa0lucEpMME90TG9y?=
 =?utf-8?B?MXBLOTFqTUh1MjNpQTRYSXQySGwvVkhJSjNuUUZ5a25UUnRkNVFEZW9hVFkr?=
 =?utf-8?B?WGIxWVRuYTVLSCtpd29xY3J0OTZyL2hmbDl3dU9kOTJ2Y0ZITkwvaFNuRk1a?=
 =?utf-8?B?NDYzRFBKNS9xVi90U0F5L2xNeWhkN3pvUjk0OW9zMVFKcktqWW5obVRzN1JM?=
 =?utf-8?B?NGtaYjVvdm56ZEZiOXZoUHY1cGw2Y3l5dVN4dTAzakRCb2JWNFFvZjhWSmp1?=
 =?utf-8?B?ZmNPYitReVJoWVBPVmh3MWdGeVpuVVpEVGZiQzN0R0t1d2ZJU01BUjlJNzVs?=
 =?utf-8?B?WWdKZEJnOVFOR2tmSE43TG1nbnRtNTJLanp0Y0gxVklHYzJReFQrTjkwUzl0?=
 =?utf-8?B?YlZTc1lhMzFNcGdDMEp4SkkwOThnNnNtdTIvY0N2V0k0OWh4emp4aG13SW9o?=
 =?utf-8?B?b1Z5Ti9PL3VKbGNJeVh4YUw1WmpTZ25GWVpReERXWWo2c01iU0NnWG56cmJK?=
 =?utf-8?B?VWdHTHc0cTZoY0xQNzRDOWhZNkQ5b29IVmxSNUI4UC9xeUdXSXozNzZFQ0Fi?=
 =?utf-8?B?NXlGYUtLRGFsU1VuaWxqZTIxc2N4VmFDcmVSM1VncEI2bW43UElFbEhpQ2tt?=
 =?utf-8?B?Q0VFelVRYm5DWXBJTm1xOFoyQlh0cjJ0SGVlY3dKQlhOQklxdkkwZVlRVGxI?=
 =?utf-8?B?ZGVqckZNczlqV1I0akJUb3UxL2JwTmlvdXZIRnRyV2dsNDJzZVF4K2pRQmdo?=
 =?utf-8?B?Titoa2phcWhDUGc3bXpyaHdkWjhEdFNWRXhMRy9uU3FTZlpQMEVHdUYvUVdm?=
 =?utf-8?B?SGkrcXJQbnJZcW9LQmRuWkovNzFaL3k1MlRKSTZXT1FFM21KRkp5bkkzSmR5?=
 =?utf-8?B?aVMrWFIxOWVwTmk0aXovRjhVa3ROd3p5MGw1WldVN2d6SUh3b0lXTHcyZGFx?=
 =?utf-8?B?VEdkQWNMYjFteXJXeUdraTJvYVN5MEY3dE53RXpWcW0yRjlqME84UDFXckZM?=
 =?utf-8?B?K0ZOVXJoUktxOFMvM21QZyt4MHlLTTFvaS9lTXAvQ3J5V1NMYThaU1dJQytK?=
 =?utf-8?B?TUQzeExDcnBaTDg4ZEkwdmd4cU1kUmFodVZiV2pwTTNlRklqQUI5NndHSzVh?=
 =?utf-8?B?OEd6VTVSdjc0TFNkNVpCRVlBNis2S0g1c2VmSWZRUjZXSmtndUJBQVJjUWFn?=
 =?utf-8?B?RUFEM09Qd0ZOelN3ZFJQdThucVROeXdNUGo4NHRRK0huL2gzZnhOVi9kczVI?=
 =?utf-8?B?Vmw4aFRxVnY4c2pZaEVZYnZxNmJ1RVNCMjl0amsvRUtjbG1MOFFOK01sejFz?=
 =?utf-8?B?REI1OWFya1IxUko1bVBhb2VZRThIVHhjYnMzSjlVdDBhdzBVL0VMMkRtTTIy?=
 =?utf-8?B?bXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <60E3C9DB0495D44F89F843B43D3F9031@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 1Vg0f8M449HYEVE53ESG7cH343ykk7k07fCTK/BW+Je5i4wFvmOJWBOYndQz2u79UBiqxP4PBVQypjKcEDhl+DX23kGHsHb8caOi+H5seIOkQEHbSX+kUbuDCFgNuetWsjeMwUjYypFZXVUpb6YpXG2AO8N9as7XYTeL9eFjRIKMX8SR7+lMwt4dyUBXP7JhSdjaMTZEeQlft4y9EvT3eH9Mx2WYo/UR4hxl3aG11joX1vF1/PwWXWtRwbL0z718Il95xMCzMoHPB7csvQVOUyjMR4LLr3MQgw9a7ak//dqKEVWI9x+8qpF42B2SvuxLxeUQmmCWrD6fhXS/HgxTVyALIi8ODAHtAYR60mEErU2q0qip73jeh4uN9YCInnxWvcpa3J/3RJPQUeCYPj+VBblK+26VHEN+6pnqaLbwLOnZ3DAnB2nI3Ikz3x3S4UilqEWFNF+BU9TFRFVcsEcKvRNlJGhXIIdG7P0ymr/tEdwKmnPZSGLNBB7kictVkQc7yJ+GhB8qyBXjJ/VtmVPhBYE8shsTwdiusGR7pZ8GtR8/Q/QVH8z5PuGwrZUxVKimaqcHhVXIjnMUL8iiAOnM2cyvItCajjSemr5iMz3kS2x/cCS8fIESSivB9rNogCK0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYAPR01MB5818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4e193cd-a118-4cf1-71b5-08dc5905fa7b
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Apr 2024 02:28:59.1670 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BlaoRWjCKN2afBgzp6peCmB/w6qHEkydZK/exalihor9wmo0znL483HUS+/DAirlEU6brEijKWI3spVBLBkY7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB7823
Received-SPF: pass client-ip=216.71.158.33; envelope-from=lizhijian@fujitsu.com;
 helo=esa16.fujitsucc.c3s2.iphmx.com
X-Spam_score_int: -61
X-Spam_score: -6.2
X-Spam_bar: ------
X-Spam_report: (-6.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.751,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Reply-to:  "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
From:  "Zhijian Li (Fujitsu)" via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

DQoNCm9uIDQvMTAvMjAyNCAzOjQ2IEFNLCBQZXRlciBYdSB3cm90ZToNCg0KPj4gSXMgdGhlcmUg
ZG9jdW1lbnQvbGluayBhYm91dCB0aGUgdW5pdHRlc3QvQ0kgZm9yIG1pZ3JhdGlvbiB0ZXN0cywg
V2h5DQo+PiBhcmUgdGhvc2UgdGVzdHMgbWlzc2luZz8NCj4+IElzIGl0IGhhcmQgb3IgdmVyeSBz
cGVjaWFsIHRvIHNldCB1cCBhbiBlbnZpcm9ubWVudCBmb3IgdGhhdD8gbWF5YmUgd2UNCj4+IGNh
biBoZWxwIGluIHRoaXMgcmVnYXJkcy4NCj4gU2VlIHRlc3RzL3F0ZXN0L21pZ3JhdGlvbi10ZXN0
LmMuICBXZSBwdXQgbW9zdCBvZiBvdXIgbWlncmF0aW9uIHRlc3RzDQo+IHRoZXJlIGFuZCB0aGF0
J3MgY292ZXJlZCBpbiBDSS4NCj4NCj4gSSB0aGluayBvbmUgbWFqb3IgaXNzdWUgaXMgQ0kgc3lz
dGVtcyBkb24ndCBub3JtYWxseSBoYXZlIHJkbWEgZGV2aWNlcy4NCj4gQ2FuIHJkbWEgbWlncmF0
aW9uIHRlc3QgYmUgY2FycmllZCBvdXQgd2l0aG91dCBhIHJlYWwgaGFyZHdhcmU/DQoNClllYWgs
wqAgUlhFIGFrYS4gU09GVC1Sb0NFIGlzIGFibGUgdG8gZW11bGF0ZSB0aGUgUkRNQSwgZm9yIGV4
YW1wbGUNCiQgc3VkbyByZG1hIGxpbmsgYWRkIHJ4ZV9ldGgwIHR5cGUgcnhlIG5ldGRldiBldGgw
wqAgIyBvbiBob3N0DQp0aGVuIHdlIGNhbiBnZXQgYSBuZXcgUkRNQSBpbnRlcmZhY2UgInJ4ZV9l
dGgwIi4NClRoaXMgbmV3IFJETUEgaW50ZXJmYWNlIGlzIGFibGUgdG8gZG8gdGhlIFFFTVUgUkRN
QSBtaWdyYXRpb24uDQoNCkFsc28sIHRoZSBsb29wYmFjayhsbykgZGV2aWNlIGlzIGFibGUgdG8g
ZW11bGF0ZSB0aGUgUkRNQSBpbnRlcmZhY2UgDQoicnhlX2xvIiwgaG93ZXZlciB3aGVuDQpJIHRy
aWVkKHllYXJzIGFnbykgdG8gZG8gUkRNQSBtaWdyYXRpb24gb3ZlciB0aGlzIA0KaW50ZXJmYWNl
KHJkbWE6MTI3LjAuMC4xOjMzMzMpICwgaXQgZ290IHNvbWV0aGluZyB3cm9uZy4NClNvIGkgZ2F2
ZSB1cCBlbmFibGluZyB0aGUgUkRNQSBtaWdyYXRpb24gcXRlc3QgYXQgdGhhdCB0aW1lLg0KDQoN
Cg0KVGhhbmtzDQpaaGlqaWFuDQoNCg0KDQogICAgIA0KDQo+DQo+Pj4gSXQgc2VlbXMgdGhlcmUg
Y2FuIHN0aWxsIGJlIHBlb3BsZSBqb2luaW5nIHRoaXMgZGlzY3Vzc2lvbi4gIEknbGwgaG9sZCBv
ZmYNCj4+PiBhIGJpdCBvbiBtZXJnaW5nIHRoaXMgcGF0Y2ggdG8gcHJvdmlkZSBlbm91Z2ggd2lu
ZG93IGZvciBhbnlvbmUgdG8gY2hpbSBpbi4NCj4+IFRoeCBmb3IgZGlzY3Vzc2lvbiBhbmQgdW5k
ZXJzdGFuZGluZy4NCj4gVGhhbmtzIGZvciBhbGwgdGhlc2UgaW5wdXRzIHNvIGZhci4gIFRoZXNl
IGNhbiBoZWxwIHVzIG1ha2UgYSB3aXNlciBhbmQNCj4gY2xlYXJlciBzdGVwIG5vIG1hdHRlciB3
aGljaCB3YXkgd2UgY2hvb3NlLg0K

