Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D291CA0FFD
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Sep 2025 09:47:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ut17g-0000yW-A6; Mon, 01 Sep 2025 05:46:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <smail.aider@huawei.com>)
 id 1ut17b-0000x0-Np; Mon, 01 Sep 2025 05:46:43 -0400
Received: from [185.176.79.56] (helo=frasgout.his.huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <smail.aider@huawei.com>)
 id 1ut17Y-0007OS-6K; Mon, 01 Sep 2025 05:46:43 -0400
Received: from mail.maildlp.com (unknown [172.18.186.31])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4cFkTk6NRqz6M535;
 Mon,  1 Sep 2025 17:43:54 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
 by mail.maildlp.com (Postfix) with ESMTPS id E3BFF1402F3;
 Mon,  1 Sep 2025 17:46:19 +0800 (CST)
Received: from frapeml500008.china.huawei.com (7.182.85.71) by
 frapeml500008.china.huawei.com (7.182.85.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 1 Sep 2025 11:46:19 +0200
Received: from frapeml500008.china.huawei.com ([7.182.85.71]) by
 frapeml500008.china.huawei.com ([7.182.85.71]) with mapi id 15.01.2507.039;
 Mon, 1 Sep 2025 11:46:19 +0200
To: Michael Tokarev <mjt@tls.msk.ru>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "zhangyue (BA)" <zhangyue165@huawei.com>, "Liuyutao(DRC)"
 <liuyutao2@huawei.com>, "qemu-stable@nongnu.org" <qemu-stable@nongnu.org>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "richard.henderson@linaro.org"
 <richard.henderson@linaro.org>, Smail AIDER <smail.aider@huawei.com>, "Peter
 Maydell" <peter.maydell@linaro.org>
Subject: RE: [PATCH v3 1/1] target/arm: Trap PMCR when MDCR_EL2.TPMCR is set
Thread-Topic: [PATCH v3 1/1] target/arm: Trap PMCR when MDCR_EL2.TPMCR is set
Thread-Index: AQHcCrIoROzGXl5jCUm9VOEblJ0G6bR8MsqAgAH53aA=
Date: Mon, 1 Sep 2025 09:46:19 +0000
Message-ID: <6595d36298d344af89ce37bd5dbcd7d6@huawei.com>
References: <20250811112143.1577055-1-smail.aider@huawei.com>
 <20250811112143.1577055-2-smail.aider@huawei.com>
 <2e6d011f-a8a5-4eef-9fe0-2a95984e4116@tls.msk.ru>
In-Reply-To: <2e6d011f-a8a5-4eef-9fe0-2a95984e4116@tls.msk.ru>
Accept-Language: en-US
Content-Language: en-US
X-Mentions: peter.maydell@linaro.org
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.206.134.31]
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
 RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

SGkgTWljaGFlbCwNCg0KWW91ciBiYWNrLXBvcnQgY29tbWl0IGlzIHNhbmUuIFllcywgSSBzdXBw
b3NlIHRoaXMgY2hhbmdlIG5lZWRzIHRvIGJlIHBvcnRlZCB0byBvdGhlciByZWxlYXNlcy4gSXQg
aGFzIGFscmVhZHkgYmVlbiBhcHBsaWVkIHRvIHRoZSBuZXh0IDEwLjIgYnkgQFBldGVyIE1heWRl
bGwuDQoNClRoYW5rcywNClNtYWlsIEFJREVSDQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0t
DQoNCkhpISAgUGxlYXNlIHRha2UgYSBsb29rIGF0DQpodHRwczovL2dpdGxhYi5jb20vbWp0MGsv
cWVtdS8tL2NvbW1pdC84NDI5MThlZTNjMWNiOWFjNjg3YmIyNzkyMGM4ZDkwMjBjMmMxMDliDQpm
b3IgbXkgYmFjay1wb3J0IG9mIHRoaXMgY29tbWl0IHRvIHYxMC4wLnggc2VyaWVzLCAtLSBkb2Vz
IGl0IGxvb2sgc2FuZT8gIEkgYXNzdW1lIHRoaXMgY2hhbmdlIGlzIHRhcmdldHRpbmcgMTAuMC54
IHRvbywgbm90IGp1c3QgMTAuMS54Lg0KDQpUaGFua3MsDQoNCi9tanQNCg==

