Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C226C87FD2
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Aug 2025 11:36:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ulQnh-0005mR-FV; Mon, 11 Aug 2025 07:34:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <smail.aider@huawei.com>)
 id 1ulQnb-0005mE-Ox
 for qemu-devel@nongnu.org; Mon, 11 Aug 2025 07:34:43 -0400
Received: from [185.176.79.56] (helo=frasgout.his.huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <smail.aider@huawei.com>)
 id 1ulQnR-0005ZP-KZ
 for qemu-devel@nongnu.org; Mon, 11 Aug 2025 07:34:43 -0400
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4c0std1ngHz6M5Dc;
 Mon, 11 Aug 2025 19:32:25 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
 by mail.maildlp.com (Postfix) with ESMTPS id ED519140275;
 Mon, 11 Aug 2025 19:34:19 +0800 (CST)
Received: from frapeml500008.china.huawei.com (7.182.85.71) by
 frapeml500008.china.huawei.com (7.182.85.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 11 Aug 2025 13:34:19 +0200
Received: from frapeml500008.china.huawei.com ([7.182.85.71]) by
 frapeml500008.china.huawei.com ([7.182.85.71]) with mapi id 15.01.2507.039;
 Mon, 11 Aug 2025 13:34:19 +0200
To: Michael Tokarev <mjt@tls.msk.ru>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: Peter Maydell <peter.maydell@linaro.org>, "zhangyue (BA)"
 <zhangyue165@huawei.com>, "richard.henderson@linaro.org"
 <richard.henderson@linaro.org>, "Liuyutao(DRC)" <liuyutao2@huawei.com>
Subject: RE: [PATCH v2 1/2] target/arm: Trap PMCR when MDCR_EL2.TPMCR is set
Thread-Topic: [PATCH v2 1/2] target/arm: Trap PMCR when MDCR_EL2.TPMCR is set
Thread-Index: AQHcAsOko37zELmrqkOCgijqUwHZTrRb4nUAgAF/HsA=
Date: Mon, 11 Aug 2025 11:34:19 +0000
Message-ID: <21e242a15cf64bf4b5c4cd7da523aca3@huawei.com>
References: <20250801090645.2205449-1-smail.aider@huawei.com>
 <20250801090645.2205449-2-smail.aider@huawei.com>
 <4288fe0a-a9ed-4a85-8edd-5af8256ff647@tls.msk.ru>
In-Reply-To: <4288fe0a-a9ed-4a85-8edd-5af8256ff647@tls.msk.ru>
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
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 RDNS_NONE=0.793, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

WWVzLCB0aGlzIHBhdGNoIGlzIGFsc28gaW50ZW5kZWQgdG8gcWVtdS1zdGFibGUuDQoNClRoYW5r
IHlvdS4NCg0KLS0NCkJlc3QgUmVnYXJkcywNClNtYWlsIEFJREVSDQpFLU1haWw6IHNtYWlsLmFp
ZGVyQGh1YXdlaS5jb20NCk9wZXJhdGluZyBTeXN0ZW0gUmVzZWFyY2hlci9EZXZlbG9wZXINCkRy
ZXNkZW4gUmVzZWFyY2ggQ2VudGVyLCBPUyBLZXJuZWwgTGFiDQpIdWF3ZWkgVGVjaG5vbG9naWVz
IENvLiwgTHRkDQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBNaWNoYWVsIFRv
a2FyZXYgPG1qdEB0bHMubXNrLnJ1PiANClNlbnQ6IFN1bmRheSwgQXVndXN0IDEwLCAyMDI1IDQ6
NDEgUE0NClRvOiBTbWFpbCBBSURFUiA8c21haWwuYWlkZXJAaHVhd2VpLmNvbT47IHFlbXUtZGV2
ZWxAbm9uZ251Lm9yZw0KQ2M6IEFsZXhhbmRlciBTcHlyaWRha2lzIDxhbGV4YW5kZXIuc3B5cmlk
YWtpc0BodWF3ZWkuY29tPjsgcWVtdS1hcm1Abm9uZ251Lm9yZzsgUGV0ZXIgTWF5ZGVsbCA8cGV0
ZXIubWF5ZGVsbEBsaW5hcm8ub3JnPjsgemhhbmd5dWUgKEJBKSA8emhhbmd5dWUxNjVAaHVhd2Vp
LmNvbT47IHJpY2hhcmQuaGVuZGVyc29uQGxpbmFyby5vcmc7IExpdXl1dGFvKERSQykgPGxpdXl1
dGFvMkBodWF3ZWkuY29tPjsgcWVtdS1zdGFibGUgPHFlbXUtc3RhYmxlQG5vbmdudS5vcmc+DQpT
dWJqZWN0OiBSZTogW1BBVENIIHYyIDEvMl0gdGFyZ2V0L2FybTogVHJhcCBQTUNSIHdoZW4gTURD
Ul9FTDIuVFBNQ1IgaXMgc2V0DQoNCk9uIDAxLjA4LjIwMjUgMTI6MDYsIFNtYWlsIEFJREVSIHZp
YSB3cm90ZToNCj4gRnJvbTogU21haWwgQUlERVIgdmlhIDxxZW11LWRldmVsQG5vbmdudS5vcmc+
DQo+IA0KPiBUcmFwIFBNQ1JfRUwwIG9yIFBNQ1IgYWNjZXNzZXMgdG8gRUwyIHdoZW4gTURDUl9F
TDIuVFBNQ1IgaXMgc2V0Lg0KPiBTaW1pbGFyIHRvIE1EQ1JfRUwyLlRQTSwgTURDUl9FTDIuVFBN
Q1IgYWxsb3dzIHRyYXBwaW5nIEVMMCBhbmQgRUwxDQo+IGFjY2Vzc2VzIHRvIHRoZSBQTUNSIHJl
Z2lzdGVyIHRvIEVMMi4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IFNtYWlsIEFJREVSIDxzbWFpbC5h
aWRlckBodWF3ZWkuY29tPg0KPiBNZXNzYWdlLUlkOiA8MjAyNTA3MjIxMzE5MjUuMjExOTE2OS0x
LXNtYWlsLmFpZGVyQGh1YXdlaS5jb20+DQoNCkknbSBhc3N1bWluZyB0aGlzIGlzIGZvciBxZW11
LXN0YWJsZSB0b28gKENjJ2VkKSwganVzdCBsaWtlIHRoZQ0KdjEgb2YgdGhpcyBwYXRjaCB3YXMu
ICBQbGVhc2UgbGV0IG1lIGtub3cgaXQgaXQgaXNuJ3QuDQoNClRoYW5rcywNCg0KL21qdA0K

