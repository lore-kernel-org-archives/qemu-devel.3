Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48A35C87FD2
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Aug 2025 13:35:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ulSeo-0005GX-TY; Mon, 11 Aug 2025 09:33:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <smail.aider@huawei.com>)
 id 1ulSel-0005Eh-4h; Mon, 11 Aug 2025 09:33:43 -0400
Received: from [185.176.79.56] (helo=frasgout.his.huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <smail.aider@huawei.com>)
 id 1ulSec-0004Sz-04; Mon, 11 Aug 2025 09:33:41 -0400
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4c0wSX4Pt9z6L5Wq;
 Mon, 11 Aug 2025 21:28:28 +0800 (CST)
Received: from frapeml100003.china.huawei.com (unknown [7.182.85.60])
 by mail.maildlp.com (Postfix) with ESMTPS id 98C7C140275;
 Mon, 11 Aug 2025 21:33:15 +0800 (CST)
Received: from frapeml500008.china.huawei.com (7.182.85.71) by
 frapeml100003.china.huawei.com (7.182.85.60) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 11 Aug 2025 15:33:15 +0200
Received: from frapeml500008.china.huawei.com ([7.182.85.71]) by
 frapeml500008.china.huawei.com ([7.182.85.71]) with mapi id 15.01.2507.039;
 Mon, 11 Aug 2025 15:33:15 +0200
To: =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: Alexander Spyridakis <alexander.spyridakis@huawei.com>, "zhangyue (BA)"
 <zhangyue165@huawei.com>, "Liuyutao(DRC)" <liuyutao2@huawei.com>,
 "mjt@tls.msk.ru" <mjt@tls.msk.ru>, Peter Maydell <peter.maydell@linaro.org>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "richard.henderson@linaro.org"
 <richard.henderson@linaro.org>
Subject: RE: [PATCH v3 1/1] target/arm: Trap PMCR when MDCR_EL2.TPMCR is set
Thread-Topic: [PATCH v3 1/1] target/arm: Trap PMCR when MDCR_EL2.TPMCR is set
Thread-Index: AQHcCrIoROzGXl5jCUm9VOEblJ0G6bRdQfOAgAAvcRA=
Date: Mon, 11 Aug 2025 13:33:15 +0000
Message-ID: <a8245ecc1e614beaa66f16dcb20d7dc1@huawei.com>
References: <20250811112143.1577055-1-smail.aider@huawei.com>
 <20250811112143.1577055-2-smail.aider@huawei.com>
 <7402c0f3-326b-4a98-bd62-b8da998b4401@linaro.org>
In-Reply-To: <7402c0f3-326b-4a98-bd62-b8da998b4401@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.206.134.11]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Host-Lookup-Failed: Reverse DNS lookup failed for 185.176.79.56 (deferred)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=smail.aider@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, RDNS_NONE=0.793, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Reply-to:  Smail AIDER <smail.aider@huawei.com>
From:  Smail AIDER via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

SGkgUGhpbGlwcGUsDQoNCkl0IGlzIG5vdCBqdXN0IHNvbWUgcmVmYWN0b3JpbmcuIFRoZSBsYXN0
IHBhdGNoIHYzIGlzIGEgc3F1YXNoIG9mIHR3byBwcmV2aW91cyBwYXRjaGVzIHYxIGFuZCB2Mi4N
Ck1heWJlIEkgbmVlZCB0byBjaGFuZ2UgdGhlIGhpc3RvcnkgZGVzY3JpcHRpb24gaWYgbm90IGNs
ZWFyIChJIHdhcyB0YWxraW5nIGZyb20gdjMgcG9pbnQgb2YgdmlldykuDQpUaGUgcHVycG9zZSBv
ZiB0aGUgc2VyaWVzIGlzIHRoZSBtYWluIGRlc2NyaXB0aW9uIGl0c2VsZi4gUGxlYXNlIGNoZWNr
IHRoZSB2MSBiZWxvdzoNCg0KaHR0cHM6Ly9wYXRjaGV3Lm9yZy9RRU1VLzIwMjUwNzIyMTMxOTI1
LjIxMTkxNjktMS1zbWFpbC5haWRlckBodWF3ZWkuY29tLw0KDQpPdGhlciB0aGFuIHRoYXQsIHRo
ZSBhcmd1bWVudCAoaXNfcG1jcikgaXMgY29ycmVjdC4gImlzcmVhZCIgaXMgbm90IHVzZWQgaW4g
dGhpcyBjYXNlLg0KDQotLQ0KQmVzdCBSZWdhcmRzLA0KU21haWwgQUlERVINCkUtTWFpbDogc21h
aWwuYWlkZXJAaHVhd2VpLmNvbQ0KT3BlcmF0aW5nIFN5c3RlbSBSZXNlYXJjaGVyL0RldmVsb3Bl
cg0KRHJlc2RlbiBSZXNlYXJjaCBDZW50ZXIsIE9TIEtlcm5lbCBMYWINCkh1YXdlaSBUZWNobm9s
b2dpZXMgQ28uLCBMdGQNCg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IFBoaWxp
cHBlIE1hdGhpZXUtRGF1ZMOpIDxwaGlsbWRAbGluYXJvLm9yZz4gDQpTZW50OiBNb25kYXksIEF1
Z3VzdCAxMSwgMjAyNSAyOjM2IFBNDQpUbzogU21haWwgQUlERVIgPHNtYWlsLmFpZGVyQGh1YXdl
aS5jb20+OyBxZW11LWRldmVsQG5vbmdudS5vcmcNCkNjOiBBbGV4YW5kZXIgU3B5cmlkYWtpcyA8
YWxleGFuZGVyLnNweXJpZGFraXNAaHVhd2VpLmNvbT47IHpoYW5neXVlIChCQSkgPHpoYW5neXVl
MTY1QGh1YXdlaS5jb20+OyBMaXV5dXRhbyhEUkMpIDxsaXV5dXRhbzJAaHVhd2VpLmNvbT47IG1q
dEB0bHMubXNrLnJ1OyBQZXRlciBNYXlkZWxsIDxwZXRlci5tYXlkZWxsQGxpbmFyby5vcmc+OyBx
ZW11LWFybUBub25nbnUub3JnOyByaWNoYXJkLmhlbmRlcnNvbkBsaW5hcm8ub3JnDQpTdWJqZWN0
OiBSZTogW1BBVENIIHYzIDEvMV0gdGFyZ2V0L2FybTogVHJhcCBQTUNSIHdoZW4gTURDUl9FTDIu
VFBNQ1IgaXMgc2V0DQoNCkhpIFNtYWlsLA0KDQoobm8gbmVlZCB0byBDYyBxZW11LXN0YWJsZSB3
aXRoIHRoaXMgcGF0Y2gsIGl0IGlzIGEgc2ltcGxlIHJlZmFjdG9yKQ0KDQpPbiAxMS84LzI1IDEz
OjIxLCBTbWFpbCBBSURFUiB2aWEgd3JvdGU6DQo+IEZyb206IFNtYWlsIEFJREVSIHZpYSA8cWVt
dS1kZXZlbEBub25nbnUub3JnPg0KPiANCj4gVHJhcCBQTUNSX0VMMCBvciBQTUNSIGFjY2Vzc2Vz
IHRvIEVMMiB3aGVuIE1EQ1JfRUwyLlRQTUNSIGlzIHNldC4NCj4gU2ltaWxhciB0byBNRENSX0VM
Mi5UUE0sIE1EQ1JfRUwyLlRQTUNSIGFsbG93cyB0cmFwcGluZyBFTDAgYW5kIEVMMQ0KPiBhY2Nl
c3NlcyB0byB0aGUgUE1DUiByZWdpc3RlciB0byBFTDIuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBT
bWFpbCBBSURFUiA8c21haWwuYWlkZXJAaHVhd2VpLmNvbT4NCj4gUmV2aWV3ZWQtYnk6IFJpY2hh
cmQgSGVuZGVyc29uIDxyaWNoYXJkLmhlbmRlcnNvbkBsaW5hcm8ub3JnPg0KPiBNZXNzYWdlLUlk
OiA8MjAyNTA3MjIxMzE5MjUuMjExOTE2OS0xLXNtYWlsLmFpZGVyQGh1YXdlaS5jb20+DQo+IC0t
LQ0KPiAgIHRhcmdldC9hcm0vY3ByZWdzLXBtdS5jIHwgMzMgKysrKysrKysrKysrKysrKysrKysr
KysrKy0tLS0tLS0tDQo+ICAgMSBmaWxlIGNoYW5nZWQsIDI1IGluc2VydGlvbnMoKyksIDggZGVs
ZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvdGFyZ2V0L2FybS9jcHJlZ3MtcG11LmMgYi90
YXJnZXQvYXJtL2NwcmVncy1wbXUuYw0KPiBpbmRleCA5YzQ0MzFjMThiLi4xMzM5MmRkYzRjIDEw
MDY0NA0KPiAtLS0gYS90YXJnZXQvYXJtL2NwcmVncy1wbXUuYw0KPiArKysgYi90YXJnZXQvYXJt
L2NwcmVncy1wbXUuYw0KPiBAQCAtMjI4LDIyICsyMjgsMjcgQEAgc3RhdGljIGJvb2wgZXZlbnRf
c3VwcG9ydGVkKHVpbnQxNl90IG51bWJlcikNCj4gICAgICAgcmV0dXJuIHN1cHBvcnRlZF9ldmVu
dF9tYXBbbnVtYmVyXSAhPSBVTlNVUFBPUlRFRF9FVkVOVDsNCj4gICB9DQo+ICAgDQo+IC1zdGF0
aWMgQ1BBY2Nlc3NSZXN1bHQgcG1yZWdfYWNjZXNzKENQVUFSTVN0YXRlICplbnYsIGNvbnN0IEFS
TUNQUmVnSW5mbyAqcmksDQo+IC0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGJv
b2wgaXNyZWFkKQ0KPiArc3RhdGljIENQQWNjZXNzUmVzdWx0IGRvX3BtcmVnX2FjY2VzcyhDUFVB
Uk1TdGF0ZSAqZW52LCBib29sIGlzX3BtY3IpDQoNCiJib29sIGlzX3BtY3IiIHZzIC4uLg0KDQo+
ICtzdGF0aWMgQ1BBY2Nlc3NSZXN1bHQgcG1yZWdfYWNjZXNzKENQVUFSTVN0YXRlICplbnYsIGNv
bnN0IEFSTUNQUmVnSW5mbyAqcmksDQo+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIGJvb2wgaXNyZWFkKQ0KDQouLi4gImJvb2wgaXNyZWFkIi4NCg0KSSBzdXBwb3NlIHdlIHdh
bnQgdG8gdXNlICJpc19wbWNyIiBoZXJlIGluc3RlYWQgb2YgImlzcmVhZCIuDQoNCj4gK3sNCj4g
KyAgICByZXR1cm4gZG9fcG1yZWdfYWNjZXNzKGVudiwgZmFsc2UpOw0KPiArfQ0KPiArDQo+ICtz
dGF0aWMgQ1BBY2Nlc3NSZXN1bHQgcG1yZWdfYWNjZXNzX3BtY3IoQ1BVQVJNU3RhdGUgKmVudiwg
Y29uc3QgQVJNQ1BSZWdJbmZvICpyaSwNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgYm9vbCBpc3JlYWQpDQo+ICt7DQo+ICsgICAgcmV0dXJuIGRvX3BtcmVnX2FjY2Vzcyhl
bnYsIHRydWUpOw0KPiArfQ0KPiArDQo+ICAgc3RhdGljIENQQWNjZXNzUmVzdWx0IHBtcmVnX2Fj
Y2Vzc194ZXZjbnRyKENQVUFSTVN0YXRlICplbnYsDQo+ICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIGNvbnN0IEFSTUNQUmVnSW5mbyAqcmksDQo+ICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGJvb2wgaXNyZWFkKQ0KPiBAQCAt
MTE4NywxNCArMTIwNCwxNCBAQCB2b2lkIGRlZmluZV9wbV9jcHJlZ3MoQVJNQ1BVICpjcHUpDQo+
ICAgICAgICAgICAgICAgLmZndCA9IEZHVF9QTUNSX0VMMCwNCj4gICAgICAgICAgICAgICAudHlw
ZSA9IEFSTV9DUF9JTyB8IEFSTV9DUF9BTElBUywNCj4gICAgICAgICAgICAgICAuZmllbGRvZmZz
ZXQgPSBvZmZzZXRvZmxvdzMyKENQVUFSTVN0YXRlLCBjcDE1LmM5X3BtY3IpLA0KPiAtICAgICAg
ICAgICAgLmFjY2Vzc2ZuID0gcG1yZWdfYWNjZXNzLA0KPiArICAgICAgICAgICAgLmFjY2Vzc2Zu
ID0gcG1yZWdfYWNjZXNzX3BtY3IsDQo+ICAgICAgICAgICAgICAgLnJlYWRmbiA9IHBtY3JfcmVh
ZCwgLnJhd19yZWFkZm4gPSByYXdfcmVhZCwNCj4gICAgICAgICAgICAgICAud3JpdGVmbiA9IHBt
Y3Jfd3JpdGUsIC5yYXdfd3JpdGVmbiA9IHJhd193cml0ZSwNCj4gICAgICAgICAgIH07DQo+ICAg
ICAgICAgICBjb25zdCBBUk1DUFJlZ0luZm8gcG1jcjY0ID0gew0KPiAgICAgICAgICAgICAgIC5u
YW1lID0gIlBNQ1JfRUwwIiwgLnN0YXRlID0gQVJNX0NQX1NUQVRFX0FBNjQsDQo+ICAgICAgICAg
ICAgICAgLm9wYzAgPSAzLCAub3BjMSA9IDMsIC5jcm4gPSA5LCAuY3JtID0gMTIsIC5vcGMyID0g
MCwNCj4gLSAgICAgICAgICAgIC5hY2Nlc3MgPSBQTDBfUlcsIC5hY2Nlc3NmbiA9IHBtcmVnX2Fj
Y2VzcywNCj4gKyAgICAgICAgICAgIC5hY2Nlc3MgPSBQTDBfUlcsIC5hY2Nlc3NmbiA9IHBtcmVn
X2FjY2Vzc19wbWNyLA0KPiAgICAgICAgICAgICAgIC5mZ3QgPSBGR1RfUE1DUl9FTDAsDQo+ICAg
ICAgICAgICAgICAgLnR5cGUgPSBBUk1fQ1BfSU8sDQo+ICAgICAgICAgICAgICAgLmZpZWxkb2Zm
c2V0ID0gb2Zmc2V0b2YoQ1BVQVJNU3RhdGUsIGNwMTUuYzlfcG1jciksDQoNCg==

