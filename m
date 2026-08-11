Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B68F6C5AD55
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 02:16:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtc2L-0005xq-1y; Mon, 10 Aug 2026 22:16:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liliang2057@phytium.com.cn>)
 id 1wtc2H-0005xU-KQ; Mon, 10 Aug 2026 22:16:14 -0400
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net ([162.243.164.118])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <liliang2057@phytium.com.cn>)
 id 1wtc2F-0004Yf-Hb; Mon, 10 Aug 2026 22:16:13 -0400
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
 by hzbj-icmmx-7 (Coremail) with UTF8SMTP id AQAAfwAXHFDbhXpq6eAvAw--.7652S2;
 Tue, 11 Aug 2026 10:15:55 +0800 (CST)
Received: from liliang2057$phytium.com.cn ( [218.76.62.144] ) by
 ajax-webmail-mail (Coremail) ; Tue, 11 Aug 2026 10:15:55 +0800 (GMT+08:00)
X-Originating-IP: [218.76.62.144]
Date: Tue, 11 Aug 2026 10:15:55 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From: =?UTF-8?B?5p2O5Lqu?= <liliang2057@phytium.com.cn>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, "Alistair Francis" <alistair.francis@wdc.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: RISC-V vle8ff vl truncation when a plugin instruments memory ops
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2024.3-cmXT6 build
 20250512(e7b47ee3) Copyright (c) 2002-2026 www.mailtech.cn OP_ICM_ICMVM
Content-Transfer-Encoding: base64
X-CM-CTRLDATA: Eus1pmZvb3Rlcl90eHQ9MjYxOTozODM=
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <7c079844.701b.19fee9ae132.Coremail.liliang2057@phytium.com.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: AQAAf8DwFHbbhXpqzTQiAA--.20013W
X-CM-SenderInfo: 5oloxttqjsikux6sx5pwlxzhxfrphubq/1tbiAQAEAGp6JskBDAAB
	s2
Authentication-Results: hzbj-icmmx-7; spf=neutral smtp.mail=liliang205
 7@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoW3Xw4kJr4DCryxuryUuF45ZFb_yoWxZr15p3
 WxJa4UAw1UK3W7XrWSgw18Zry5G3yUGr47Jw1xt3yqywsrJrn0qrnxKFWxJ3Wjga45trWD
 tw1UZrZ8Xr1jqrUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
 DUYxn0WfASr-VFAU7a7-sFnT9fnUUIcSsGvfJ3UbIYCTnIWIevJa73UjIFyTuYvj4RJUUU
 UUUUU
Received-SPF: pass client-ip=162.243.164.118;
 envelope-from=liliang2057@phytium.com.cn;
 helo=zg8tmtyylji0my4xnjqumte4.icoremail.net
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

SGksCgpJJ2QgbGlrZSB0aGUgY29tbXVuaXR5J3MgdGFrZSBvbiBhbiBpbnRlcmFjdGlvbiBiZXR3
ZWVuIFJJU0MtViB2ZWN0b3IKZmF1bHQtb25seS1maXJzdCBsb2FkcyBhbmQgcGx1Z2luIG1lbW9y
eSBjYWxsYmFja3Mg4oCUIHdoZXRoZXIgaXQncyBjb25zaWRlcmVkIGEKYnVnIG9yIGV4cGVjdGVk
LCBhbmQgd2hldGhlciBvdXIgcHJvdG90eXBlIGZpeCBpcyBvbiB0aGUgcmlnaHQgdHJhY2suCgpX
aGVuIGEgcGx1Z2luIHJlZ2lzdGVycyBhIGB2Y3B1X21lbWAgY2FsbGJhY2ssIGB2bGU4ZmYudmAg
aW4gYSBzY2FuL3N0cmxlbgpsb29wIHJ1bnMgfjE2eCBtb3JlIG9mdGVuIHRoYW4gd2l0aCB0aGUg
cGx1Z2luIGRpc2FibGVkLiBSZXByb2R1Y2VkIG9uCm1hc3RlciAodjExLjEuMC1yYzMpIHdpdGgg
YSBtaW5pbWFsIGNvdW50aW5nIHBsdWdpbiArIGFuIGlubGluZS1hc20KYHZsZThmZmAgZ3Vlc3Qg
bG9vcDogdmxlOGZmIGV4ZWN1dGlvbnMgZ28gZnJvbSAzMk0gKGNhbGxiYWNrcyBvZmYpIHRvCjUx
Mk0gKGNhbGxiYWNrcyBvbiksIGFuZCB0b3RhbCBpbnNucyBmcm9tIH4yMzRNIHRvIH4zNTk0TS4K
ClRoZSBjYXVzZSwgYXMgZmFyIGFzIHdlIGNhbiB0ZWxsOiBgdmV4dF9sZGZmKClgIGRlY2lkZXMg
YHZsYCBieSBwcm9iaW5nIGVhY2gKZWxlbWVudCBhbmQgdHJ1bmNhdGluZyBhdCB0aGUgZmlyc3Qg
ZmF1bHQuIFRoYXQgcHJvYmUgZ29lcyB0aHJvdWdoCmBwcm9iZV9hY2Nlc3NfZmxhZ3MoKWAsIHdo
aWNoIOKAlCB1bmRlciBhIG1lbW9yeS1vYnNlcnZpbmcgcGx1Z2luIOKAlCByZXR1cm5zIGEKbm9u
LXplcm8gIm5vdCBwbGFpbiBSQU0iIGZsYWcgKGBUTEJfTU1JT2AgdmlhIGBmb3JjZV9tbWlvYCBp
biBzeXN0ZW0gbW9kZSDigJQKYWRkZWQgYnkgYDZkMDMyMjZiNDJgIOKAlCBvciBgVExCX0ZPUkNF
X1NMT1dgIGluIHVzZXIgbW9kZSkuIFNpbmNlCmB2ZXh0X2xkZmYoKWAgdHJlYXRzIGFueSBmbGFn
IG90aGVyIHRoYW4gYFRMQl9XQVRDSFBPSU5UYCBhcyAidGhpcyBlbGVtZW50CmZhdWx0cyIsIHRo
ZSBzZWNvbmQgZWxlbWVudCAoaT0xKSBpcyByZXBvcnRlZCBmYXVsdGluZyBhbmQgYHZsYCBpcyB0
cnVuY2F0ZWQKdG8gMS4gVGhlIGxvYWRlZCBkYXRhIHN0YXlzIGNvcnJlY3QsIGJ1dCB0aGUgc2Nh
biBkZWdlbmVyYXRlcyB0bwoxIGJ5dGUvaXRlci4KCk9ubHkgZmF1bHQtb25seS1maXJzdCBzZWVt
cyBhZmZlY3RlZDogYW4gb3JkaW5hcnkgbG9hZCB1c2VzIHRoZSBwcm9iZSByZXN1bHQKb25seSB0
byBwaWNrIGZhc3QgdnMgc2xvdyBwYXRoLCBhbmQgdGhlIHNsb3cgcGF0aCBzdGlsbCByZWFkcyB0
aGUgZGF0YQpjb3JyZWN0bHkgKGFuZCBpcyB3aGVyZSB0aGUgY2FsbGJhY2sgZmlyZXMpLiBPbmx5
IEZPRiB1c2VzIHRoZSBwcm9iZSByZXN1bHQKYXMgYSBzZW1hbnRpYyBpbnB1dCAoaXQgZGVjaWRl
cyBgdmxgKS4KCk91ciBwcm90b3R5cGU6IHJvdXRlIHRoZSBzZW1hbnRpYyBwcm9iZXMgaW5zaWRl
IGB2ZXh0X2xkZmYoKWAgdGhyb3VnaApgcHJvYmVfYWNjZXNzX2Z1bGxfbW11KClgICh3aGljaCBw
cm9iZXMgd2l0aCBgY2hlY2tfbWVtX2Nicz1mYWxzZWApLCB3aGlsZQpsZWF2aW5nIHRoZSBwbGFp
bi1sb2FkIHBhdGggb24gYHByb2JlX2FjY2Vzc19mbGFncygpYCBzbyBwbHVnaW4gb2JzZXJ2YXRp
b24Kb2YgcmVhbCBsb2Fkcy9zdG9yZXMgaXMgdW5jaGFuZ2VkLiBDb25jcmV0ZWx5IHRoaXMgbWVh
bnQgYW4gYGlnbm9yZV9wbHVnaW5gCmJvb2wgb24gdGhlIFJJU0MtViBgcHJvYmVfcGFnZXMoKWAg
aGVscGVyLCBwbHVzIGEgdXNlci1tb2RlIGNvdW50ZXJwYXJ0IG9mCmBwcm9iZV9hY2Nlc3NfZnVs
bF9tbXUoKWAgKGl0IG9ubHkgZXhpc3RlZCBpbiBzeXN0ZW0gbW9kZSkuIFdpdGggaXQsIHRoZQp2
bGU4ZmYgY291bnQgaXMgaWRlbnRpY2FsIHdpdGgvd2l0aG91dCBjYWxsYmFja3MgKDMyTSBib3Ro
IHdheXMpLiBBCnNlbGYtY29udGFpbmVkIHJlcHJvZHVjZXIgaXMgcmVhZHkuCgpUaHJlZSBxdWlj
ayBxdWVzdGlvbnM6CgogIDEuIElzIHRoZSBgdmxgIHRydW5jYXRpb24gdW5kZXIgYSBtZW1vcnkt
b2JzZXJ2aW5nIHBsdWdpbiBhIGJ1Zywgb3IgaXMKICAgICByZWZsZWN0aW5nIGZvcmNlX21taW8v
VExCX0ZPUkNFX1NMT1cgaW50byB0aGUgRk9GIHByb2JlIGludGVudGlvbmFsPwogIDIuIElmIGEg
YnVnLCBpcyBgcHJvYmVfYWNjZXNzX2Z1bGxfbW11KClgIGF0IHRoZSBGT0YgY2FsbCBzaXRlcyB0
aGUKICAgICBwcmVmZXJyZWQgbGF5ZXIsIG9yIHNob3VsZCBgcHJvYmVfYWNjZXNzX2ZsYWdzKClg
IGl0c2VsZiBub3QgZm9sZAogICAgIHBsdWdpbi1pbmR1Y2VkIGZvcmNlLXNsb3cgaW50byBpdHMg
cmV0dXJuZWQgZmxhZ3M/CiAgMy4gSXMgYW4gUkZDIHBhdGNoICsgcmVwcm9kdWNlciB3ZWxjb21l
PwoKSSBub3RpY2VkIGB0YXJnZXQvaTM4Ni90Y2cvYWNjZXNzLmNgIGFscmVhZHkgd29ya3MgYXJv
dW5kIHRoZSBzYW1lCmZvcmNlLXNsb3cgKHRoZSAiTm8gaGFkZHIgbWVhbnMgcHJvYmVfYWNjZXNz
IHdhbnRzIHRvIGZvcmNlIHNsb3cgcGF0aCIKY29tbWVudCwgYW5kIGlzc3VlICMyNDg5KSwgd2hp
Y2ggaXMgd2h5IEkgd2FudGVkIHRvIGFzayBiZWZvcmUgcG9zdGluZy4KClRoYW5rcywKTGlhbmcg
TGkKCgoKCg0KDQrkv6Hmga/lronlhajlo7DmmI7vvJrmnKzpgq7ku7bljIXlkKvkv6Hmga/lvZLl
j5Hku7bkurrmiYDlnKjnu4Tnu4fmiYDmnIks5Y+R5Lu25Lq65omA5Zyo57uE57uH5a+56K+l6YKu
5Lu25oul5pyJ5omA5pyJ5p2D5Yip44CC6K+35o6l5pS26ICF5rOo5oSP5L+d5a+GLOacque7j+WP
keS7tuS6uuS5pumdouiuuOWPryzkuI3lvpflkJHku7vkvZXnrKzkuInmlrnnu4Tnu4flkozkuKrk
urrpgI/pnLLmnKzpgq7ku7bmiYDlkKvkv6Hmga/jgIINCkluZm9ybWF0aW9uIFNlY3VyaXR5IE5v
dGljZTogVGhlIGluZm9ybWF0aW9uIGNvbnRhaW5lZCBpbiB0aGlzIG1haWwgaXMgc29sZWx5IHBy
b3BlcnR5IG9mIHRoZSBzZW5kZXIncyBvcmdhbml6YXRpb24uVGhpcyBtYWlsIGNvbW11bmljYXRp
b24gaXMgY29uZmlkZW50aWFsLlJlY2lwaWVudHMgbmFtZWQgYWJvdmUgYXJlIG9ibGlnYXRlZCB0
byBtYWludGFpbiBzZWNyZWN5IGFuZCBhcmUgbm90IHBlcm1pdHRlZCB0byBkaXNjbG9zZSB0aGUg
Y29udGVudHMgb2YgdGhpcyBjb21tdW5pY2F0aW9uIHRvIG90aGVycy4=


