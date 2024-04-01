Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 818EBCD128A
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Apr 2024 07:56:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rrCW8-0002Dl-Uh; Mon, 01 Apr 2024 03:55:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1rrCW7-0002CQ-4N; Mon, 01 Apr 2024 03:55:43 -0400
Received: from esa10.fujitsucc.c3s2.iphmx.com ([68.232.159.247])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1rrCW5-0003oJ-48; Mon, 01 Apr 2024 03:55:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1711958141; x=1743494141;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=dINGQUnVYCXD1+Ti9d8bMs9YsevQg+3He324OCZIPgI=;
 b=ImhzNUSiviwm3dsMAfT8v1IA2du52Cd9izPRAhlJWeHo5aF1qjr64WO1
 xDrBhHCL+9+fZJ8aPASmZXu8CkmxLonqW5EI1Jl7vibS1nlPSZeAuCK36
 nzPB8m9cYdigZ2TGPsTSYsiynUf64ZWLGRJnfnLxQetc+prBaD/EaPSj7
 yQHMPtL+Vzfo0cDZ4ldciWpeu7/Bkf1WD5tpoyExDqEH+pM4hUP+VQXh9
 XBgs4n2fSMKLojIcra7WnYMtHzKMsPEZHibe0klAL9imaYWwIKQ7RQTMx
 FoToI1BYqAOzIUKmPk/tlXo5SyRPfyxFrtVZVJLOu6n24SoyZ35nhtteQ A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11030"; a="115665873"
X-IronPort-AV: E=Sophos;i="6.07,171,1708354800"; d="scan'208";a="115665873"
Received: from mail-os0jpn01lp2104.outbound.protection.outlook.com (HELO
 JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.104])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Apr 2024 16:55:31 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JTjuRExZAuxEEpoNgPbWFMW4BZ43EX56XEbtv1fBXTmRTDeaj0jLE8KplEEpVlPWQqG2PnH1K2fjYqL7cOcBJOGN8rcmHNe8Nm4fB6bGQqdlCzdzgkmJMAgCraOYxpezLeSu6RuOX8zylAEeRhVcrSLdcgvMxAGey7DvEiXUUqMyY+mEuk8eSm3X5igRtZC2ZLx6FufBXVGfCLb5LyjMUvXsu7R3y+FSAlk65xoaN/NVNaAZqQMy7vdd/u6H1nUz7eh9Z+gxhENV8E5L523ZRBDtHnlV1iZYpau5YocTO3Ap7Jlgm4vMivmNhtG1mrYbjpumjJHGi6LifV6W4pPCpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dINGQUnVYCXD1+Ti9d8bMs9YsevQg+3He324OCZIPgI=;
 b=D5Rgx+1Zl6Ka3M4hMW3ohhO9ODE8GRXxSb+fAsCoHQcZ6OywwrKI/6MW+jfWVucNFl7GBBK9mIfyPLU/xHzihh3Hwvb4OkhVsYHvHvcFPNXl/DFMavNT/S4emFQKxsI58gpKWsTH67GrZpa7VHqfGy1gKWzDjEwbM+E8yW50HzitHrWq4lkttYrV/aB9rds94Oe/kJa0atRiZHeJ2F3D5ssBax2KZ21zeiLFJHeKgtdVUzyVBnYh9ZeDkbW1byEOI0+def8WuBoDbx8nXm8dZPkAGo0OXdvRB2qSSZ68Qqlc0bwXFWKJ3cf0PjmZOEWvJYuIR6ABhRHAfxb2Usy7bA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TYAPR01MB5818.jpnprd01.prod.outlook.com
 (2603:1096:404:8059::10) by TYWPR01MB12062.jpnprd01.prod.outlook.com
 (2603:1096:400:442::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Mon, 1 Apr
 2024 07:55:28 +0000
Received: from TYAPR01MB5818.jpnprd01.prod.outlook.com
 ([fe80::e69:40a6:944b:f974]) by TYAPR01MB5818.jpnprd01.prod.outlook.com
 ([fe80::e69:40a6:944b:f974%5]) with mapi id 15.20.7409.042; Mon, 1 Apr 2024
 07:55:27 +0000
To: =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>, Peter Xu
 <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Yuval Shaia
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
 Moschetta <wainersm@redhat.com>, Beraldo Leal <bleal@redhat.com>, Peter
 Maydell <peter.maydell@linaro.org>, Yu Zhang <yu.zhang@ionos.com>
Subject: Re: [PATCH-for-9.1 v2 2/3] migration: Remove RDMA protocol handling
Thread-Topic: [PATCH-for-9.1 v2 2/3] migration: Remove RDMA protocol handling
Thread-Index: AQHagRBhZe2HiRGZ1kqMYe8iGl3wH7FNM10AgAAMBgCAALZIAIAAkAAAgASMGwA=
Date: Mon, 1 Apr 2024 07:55:27 +0000
Message-ID: <9d082daf-acf0-27c5-1758-5a3f2af7ee0f@fujitsu.com>
References: <20240328130255.52257-1-philmd@linaro.org>
 <20240328130255.52257-3-philmd@linaro.org> <87frwatp7n.fsf@suse.de>
 <ZgWGMmUTq0jqSUvr@x1n> <7a510fbe-1c27-4f67-93b8-0d9cf01c1c74@fujitsu.com>
 <ef160e75-d4a4-4be0-81f3-77d8b0e76178@linaro.org>
In-Reply-To: <ef160e75-d4a4-4be0-81f3-77d8b0e76178@linaro.org>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.1.1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYAPR01MB5818:EE_|TYWPR01MB12062:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BMFsMqHX1AEvhOS8I1udrJcaLCFkMn9F0Gff2BviTA6zxNnIfWdcoLBL1IrZ+An+ZqnjMewlJB7c8sQ2NtFPCkvNDXnSaPLmCXeSVlh+ItehzrxGTXpJbvGLZ32+0P0R3BUcNgkqIiOi6UTDbbI2TCH60ouPcbXOgxPFyBZIYm/VwfQLIaqMML9+S9j4CD5pS3k/53ZdTmKJt/v+7ie3QXtxpFMdY8luqy1SuELaMVXF0OQgg+tOg4R5NWBf4xyZWbaiPXGGUA/PgTO0S2rAaUdekHow2qrLYl9pTuqpXMd2yxiXsQCRnwEnjpDHSXygDH3RJeVJeO7AD5FHTgK1sKzkMXJUMMqHE8cJ2n8Ujm+yV06PLHhgMCGHlK9oDDlQ6P+xRy23n+A5sjwN3wiRB6Cc1EKVg2n3z79sfeT0sIO9dj7GADR/L5W8TIRd9qtq0wTX7Reqj7KEMiKBlJsXc2Ns5wkyB3/aP7147HU+j5zdvPG/lKPStb1YHrBwwAjFrC6s/XxE++Kbxpl0Enf+7yfxzEPlo31vHGPNk6njvcEMxS/HpkO//3Qyl5jAJm5AKO8HFxweQfg6/nOKqnj4bCUfiHfwSOSfwzKpk0e2gXFphNCZ3AHoZW8Yb4UF7GRULH0OeTa8WTi4Ou8DR4S1YSyediUraU6LIWKc4m90rPQ=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYAPR01MB5818.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(7416005)(1800799015)(1580799018); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QUUza0M2QzROYUNReUxsSXZUaDE5WS95eGZZa2RYWDE3VWNZNGFFQW5BWE5r?=
 =?utf-8?B?ZGZ1dCtVR0VrUVduaklrS0NnYnlYdkp4OFAzcUEwMi9FWTdMWHBvUElocmxw?=
 =?utf-8?B?QmF4KzEycVJ5Y0IwWmtmNm5XYVNFRkl3NVg5UmV0Qk5kTXNJQzh0b2VKL09E?=
 =?utf-8?B?dm1zMG1QZm1qcFdrTWJXekJYcy9BR3FJbTBpdk9HdHRsbTJLSFpNL2R0MzJE?=
 =?utf-8?B?K25XVWE4bXo4QlZ5Q0VuSEsvSnpUQm91WCtMVXRTdmdCQkkwcXl4em9aWlN0?=
 =?utf-8?B?NjVrK2NJeUVJMGZVRmdSSnVzZjlCTDVDSXVrNXg1Mm9IdjFKWmgrVkZvRHhL?=
 =?utf-8?B?OXRCeTdxOTdqYm9MNDBNZ0ZqNDdlbzJuU3orTE8zbkp1a0ZpWENFOFo5c1By?=
 =?utf-8?B?cFRHcjZpVXlWRmhja1oza0J5cGNEMkcyNzJ5VHZjT0k4NzU1MS81R2RicVVS?=
 =?utf-8?B?TTdiOEpTQXRlVzF3cUllZ3ZpWWdPaFJZVE1wTUhoWHp4MG0xS3NVSVNWeU1P?=
 =?utf-8?B?d2h2eU1wNFVxVlBscVJxTnNKUnRyUVZuWFBEUXpiS29WUzBlckpjY0NucTZO?=
 =?utf-8?B?d1hhNGwxbUwvRTlrdGpNRExxamlMaC9mOGRkVmR1SXBqZVhENmZsZmpIZ2Z5?=
 =?utf-8?B?V1EzT2NTSlFhQWpLSEVjTVlDTHFDRkMzVnBrbUZxWEVjSlNzdmdJRGVNMDM2?=
 =?utf-8?B?V2RSSEJNMHp3WFBGcFh1NUoyOTlMN1N6cGR0N09pcXZDTnF6VGVWUkJYM1M2?=
 =?utf-8?B?VDVLdndyNSt5ejB3RnBnQzJFSzZOQ3lIWVpnVjlVeXdiWlJPblp5QUVEeTcx?=
 =?utf-8?B?RE1hRDR4SW9DcG1wUkw0WW5kMElZQi9raTRYRk5YQyszcWNVdUJDcEFEZ3FS?=
 =?utf-8?B?N3pNQWlnTHN6blJFMng4V3hNaDUwNHp3dFdoVWJZTDZEQ1p6N2IyemVJK1h4?=
 =?utf-8?B?d1RTbGQ1bE00UUc0ZHkybTJaSStOSm9ZeEs0STJHeVhBMGEvSmMxZ2pEd0x5?=
 =?utf-8?B?VHl3S3VIVlJjdzN2ZG1jckU3MTFQN0lla2UrZ2JnU1ZXOVFabDRGdHdlRlBw?=
 =?utf-8?B?MHNKdmNLeVJZMVNMT2hTcEJTOXluZmFMeWNncDBZS2dia1B2SVBaNE5NeDN4?=
 =?utf-8?B?aW8wTVl6ZmdGd0FVT2h6MFpwaVNQNzExS2JYNnZDQXMzd1VaZTlzakczWmlT?=
 =?utf-8?B?WXIzZHlkcWRzancvVHNxMFlWWHBYa1Z3VU5NNUJZNCtiQU15anFXRVVRZjZP?=
 =?utf-8?B?cnUzcjFvUkNBaHZkM09qQno3RFk1Z0Y4S1dnNkJSSUR4UjkxdGhjN3l2KytC?=
 =?utf-8?B?TkZyL05IU3dvQ0F6VG9RTGZlZDhxenBrSWZnTHlXZG8zNUhUc1BkUE5CNjVi?=
 =?utf-8?B?cDBFdkpJak8xdFhiWjRjNExUSkFMNUVkZkJyNytPUllHbHhwUU9XaXUxb0ZR?=
 =?utf-8?B?SkE5S3BnTzcvZmVzK000YnlsaWJNazVtdVhvWVBUVjNrSGFnUVk2dlNaVFh3?=
 =?utf-8?B?QUNzTTcvSzhHTThwelFVUlNpQk5mbzNBR0J2d0xWVjl4am9oSE9NNkx0WHhr?=
 =?utf-8?B?MndYR1BCc0dqVkw4UWREYlNmTW50NllBQ29hR2h4UWhsMWwzVDMrWW8yUXVB?=
 =?utf-8?B?NUZTWU1ndUwvV1VQTjR6S3Y3a0o4K0JKd0JXaGJmcWo1cTFOa0x0OVR3NXNn?=
 =?utf-8?B?T2gzazJOYXhSQVcyTFdURXN5Yi8vaWV0bUlHQ3NDVm5LNlNOSVZiUk8yYitx?=
 =?utf-8?B?V0t1NEs2UjRvek5zTWdpSThsajYwSG9TT01pQTBzVjJwVGNXTEd6QVc0cEtC?=
 =?utf-8?B?N25iMG5BV1pBM3dJWklvSDI3aUh3bjVhS2l1Z2xoMHo0ak9GYy96akF4QTB4?=
 =?utf-8?B?bnhrWFVWWG00VHN3djRzWU4wY0xmUzc1TjRVd0FPN2FQMCtEYTRUaFFTdzBi?=
 =?utf-8?B?YzY5VkRJa3RTc09pMXFiQWk4SFFyZW5Hc2ZDUVBuVXNQVzk5NXQrKy9CQ0Ri?=
 =?utf-8?B?QnNISmwwamxSUTA5eGQvWkdSL0lvcmd3ajRjeUJwQ1JlL3UyWUpTSmtSRE9M?=
 =?utf-8?B?ZGRuV0FqcTljK0Z4TlJJNVZFNWhWMzdRUWdxa1dOM0ZkVmp2dDdWb3d1dk01?=
 =?utf-8?B?ZkN0M1dhTlIxNE1UTXVHZHdzamtBSmxneHZSSHBUaU5Ua0ZaK0ZlZWpsTlBp?=
 =?utf-8?B?NGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7A53C99AD32C9B4DBFD23B5751CE9304@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: y8G0dj3cQ5eTlqVUQqSF5qVZUqyY4h3bOyeWJUIw0+87VN1gDftqpNYLrRfwzhHi/nbH/TK2WHAzWxVU46/TdySPY/qoSmoBwh3Ze75el7MGusgJPwklIkBmi1qQJKqsbkwmMYnsmGwC8bpsjNrMHfkJJPKfpCzgm5UJ2k0ZD3pa5TmxSwkgFuDRQwK2dD8/9dMslpyD3Vf0PEGtD8J14ka7NpvJFelWCz8AEvKZdAYcbZKWfRfbGHkX7ti62sA8Bq45BsjqZiOCtoQziiMCNUEd5vfa1kwTCDb9oGga/O7HD5sUCwTDCwBSZQF834tLQ+M2p+hRHORNYmDm8sm9GpUo50bwb9DAWauBHjkkoVtFvpYfc2FD8zCGbsOZmCvLRhV9vIX+BJzMbKFrlsXZyvHxXc9GuHt27PXBXITdpQFyAlInmUWCSMNl/wy0ELI6rr5lOFHKmJn6TmWErCDrsjGE2+fIKz2KCB3/3+kRu2H9dGCDutenw+C90iGWgpL7ZU+bnrZtNbe1YhBi25mv1zzAB6r25+W9MBfPYyJILPzbDvjJn5tO7G6SRlehrORRORSyYPuTx8RbAWrNZOfIJR8iIbdpcnHJy41QGNw3hHBYAkp7Qz/PO491o7FVhlpK
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYAPR01MB5818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fae8fa5-a822-46fe-4f4c-08dc5221186d
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Apr 2024 07:55:27.6564 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: po5HaUnyH6Tk5ZWLvjd2WZWsIBYgAYfW2SCwRiHIWCzoyrim4+AubTD6KsZaoGxaVonKwQvEYyxLQ6/KwpO9OA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB12062
Received-SPF: pass client-ip=68.232.159.247;
 envelope-from=lizhijian@fujitsu.com; helo=esa10.fujitsucc.c3s2.iphmx.com
X-Spam_score_int: -87
X-Spam_score: -8.8
X-Spam_bar: --------
X-Spam_report: (-8.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-4.33,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

UGhpbCwNCg0Kb24gMy8yOS8yMDI0IDY6MjggUE0sIFBoaWxpcHBlIE1hdGhpZXUtRGF1ZMOpIHdy
b3RlOg0KPj4NCj4+DQo+Pj4gSU1ITyBpdCdzIG1vcmUgaW1wb3J0YW50IHRvIGtub3cgd2hldGhl
ciB0aGVyZSBhcmUgc3RpbGwgdXNlcnMgYW5kIA0KPj4+IHdoZXRoZXINCj4+PiB0aGV5IHdvdWxk
IHN0aWxsIGxpa2UgdG8gc2VlIGl0IGFyb3VuZC4NCj4+DQo+PiBBZ3JlZS4NCj4+IEkgZGlkbid0
IGltbWVkaWF0ZWx5IGV4cHJlc3MgbXkgb3BpbmlvbiBpbiBWMSBiZWNhdXNlIEknbSBhbHNvIA0K
Pj4gY29uc3VsdGluZyBvdXINCj4+IGN1c3RvbWVycyBmb3IgdGhpcyBmZWF0dXJlIGluIHRoZSBm
dXR1cmUuDQo+Pg0KPj4gUGVyc29uYWxseSwgSSBhZ3JlZSB3aXRoIFBlcnRlcidzIGlkZWEgdGhh
dCAiSSdkIHNsaWdodGx5IHByZWZlciANCj4+IHBvc3Rwb25pbmcgaXQgb25lDQo+PiBtb3JlIHJl
bGVhc2Ugd2hpY2ggbWlnaHQgaGVscCBhIGJpdCBvZiBvdXIgZG93bnN0cmVhbSBtYWludGVuYW5j
ZSINCj4NCj4gRG8geW91IG1pbmQgcG9zdGluZyBhIGRlcHJlY2F0aW9uIHBhdGNoIHRvIGNsYXJp
ZnkgdGhlIHNpdHVhdGlvbj8NCj4NCg0KTm8gcHJvYmxlbSwgaSBqdXN0IHBvc3RlZCBhIGRlcHJl
Y2F0aW9uIHBhdGNoLCBwbGVhc2UgdGFrZSBhIGxvb2suDQpodHRwczovL2xvcmUua2VybmVsLm9y
Zy9xZW11LWRldmVsLzIwMjQwNDAxMDM1OTQ3LjMzMTA4MzQtMS1saXpoaWppYW5AZnVqaXRzdS5j
b20vVC8jdQ0KDQpUaGFua3MNClpoaWppYW4NCg==

