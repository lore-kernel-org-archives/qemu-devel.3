Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C7C8CA0EC4
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Aug 2025 06:53:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ulirq-0000nk-B3; Tue, 12 Aug 2025 02:52:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <smail.aider@huawei.com>)
 id 1ulirn-0000nK-Fh
 for qemu-devel@nongnu.org; Tue, 12 Aug 2025 02:52:15 -0400
Received: from [185.176.79.56] (helo=frasgout.his.huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <smail.aider@huawei.com>)
 id 1ulirh-0003Ua-A3
 for qemu-devel@nongnu.org; Tue, 12 Aug 2025 02:52:15 -0400
Received: from mail.maildlp.com (unknown [172.18.186.216])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4c1MYY75dqz6H6mh;
 Tue, 12 Aug 2025 14:49:21 +0800 (CST)
Received: from frapeml500007.china.huawei.com (unknown [7.182.85.172])
 by mail.maildlp.com (Postfix) with ESMTPS id C9D0B140278;
 Tue, 12 Aug 2025 14:51:58 +0800 (CST)
Received: from frapeml500008.china.huawei.com (7.182.85.71) by
 frapeml500007.china.huawei.com (7.182.85.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 12 Aug 2025 08:51:58 +0200
Received: from frapeml500008.china.huawei.com ([7.182.85.71]) by
 frapeml500008.china.huawei.com ([7.182.85.71]) with mapi id 15.01.2507.039;
 Tue, 12 Aug 2025 08:51:58 +0200
To: Michael Tokarev <mjt@tls.msk.ru>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>
Subject: RE: [PATCH v3 1/1] target/arm: Trap PMCR when MDCR_EL2.TPMCR is set
Thread-Topic: [PATCH v3 1/1] target/arm: Trap PMCR when MDCR_EL2.TPMCR is set
Thread-Index: AQHcCrIoROzGXl5jCUm9VOEblJ0G6bRdQfOAgAAvcRD//+QbgIAAAJUAgAE+rpA=
Date: Tue, 12 Aug 2025 06:51:58 +0000
Message-ID: <dcc6e55ab8f44bc89623073ed6a8c065@huawei.com>
References: <20250811112143.1577055-1-smail.aider@huawei.com>
 <20250811112143.1577055-2-smail.aider@huawei.com>
 <7402c0f3-326b-4a98-bd62-b8da998b4401@linaro.org>
 <a8245ecc1e614beaa66f16dcb20d7dc1@huawei.com>
 <00bb0213-e4b3-457b-b5df-f575865b91ff@linaro.org>
 <38aeddc3-e5bc-4c7a-9a94-20090406d891@tls.msk.ru>
In-Reply-To: <38aeddc3-e5bc-4c7a-9a94-20090406d891@tls.msk.ru>
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
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

SGkgTWljaGFlbCwNCg0KQ291bGQgeW91IHBsZWFzZSByZW1vdmUgInZpYSIgZnJvbSB0aGUgYXV0
aG9yIG5hbWUsIGl0J3Mgbm90IHBhcnQgb2YgbXkgbmFtZSA6ICkgSSBndWVzcyBpdCB3YXMganVz
dCBhIHR5cG8uDQoNClRoYW5rIHlvdS4NCg0KLS0NCkJlc3QgUmVnYXJkcywNClNtYWlsIEFJREVS
DQpFLU1haWw6IHNtYWlsLmFpZGVyQGh1YXdlaS5jb20NCk9wZXJhdGluZyBTeXN0ZW0gUmVzZWFy
Y2hlci9EZXZlbG9wZXINCkRyZXNkZW4gUmVzZWFyY2ggQ2VudGVyLCBPUyBLZXJuZWwgTGFiDQpI
dWF3ZWkgVGVjaG5vbG9naWVzIENvLiwgTHRkDQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0t
DQpGcm9tOiBNaWNoYWVsIFRva2FyZXYgPG1qdEB0bHMubXNrLnJ1PiANClNlbnQ6IE1vbmRheSwg
QXVndXN0IDExLCAyMDI1IDM6NDggUE0NClRvOiBQaGlsaXBwZSBNYXRoaWV1LURhdWTDqSA8cGhp
bG1kQGxpbmFyby5vcmc+OyBTbWFpbCBBSURFUiA8c21haWwuYWlkZXJAaHVhd2VpLmNvbT47IHFl
bXUtZGV2ZWxAbm9uZ251Lm9yZw0KQ2M6IHFlbXUtYXJtQG5vbmdudS5vcmcNClN1YmplY3Q6IFJl
OiBbUEFUQ0ggdjMgMS8xXSB0YXJnZXQvYXJtOiBUcmFwIFBNQ1Igd2hlbiBNRENSX0VMMi5UUE1D
UiBpcyBzZXQNCg0KT24gMTEuMDguMjAyNSAxNjo0NSwgUGhpbGlwcGUgTWF0aGlldS1EYXVkw6kg
d3JvdGU6DQo+IE9uIDExLzgvMjUgMTU6MzMsIFNtYWlsIEFJREVSIHdyb3RlOg0KDQo+IFRoZW4g
cGxlYXNlIGFkZCBhIENjIHRhZyAobWFpbnRhaW5lciBjYW4gZG8gaXQgaWYgdGhpcyB2MyBpcyBP
Sywgbm8gbmVlZCANCj4gZm9yIHY0KToNCj4gDQo+IENjOiBxZW11LXN0YWJsZUBub25nbnUub3Jn
DQoNCkknbSBwaWNraW5nIGl0IHVwIGFscmVhZHkgLSBpdCdzIG9uIG15IHdhdGNoIGxpc3Qgc2lu
Y2UgdGhlIHYxIDopDQoNCi9tanQNCg==

