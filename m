Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3DABC5CFDB
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2026 10:40:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuSqI-0002tL-EA; Thu, 13 Aug 2026 06:39:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wangyang25@otcaix.iscas.ac.cn>)
 id 1wuSqH-0002s1-6p; Thu, 13 Aug 2026 06:39:21 -0400
Received: from smtp81.cstnet.cn ([159.226.251.81] helo=cstnet.cn)
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <wangyang25@otcaix.iscas.ac.cn>)
 id 1wuSqC-00015N-Qz; Thu, 13 Aug 2026 06:39:20 -0400
Received: from DESKTOP-7FLBREN (unknown [124.16.137.194])
 by APP-03 (Coremail) with SMTP id rQCowACnrz3Knn1qgUMmBQ--.60519S6;
 Thu, 13 Aug 2026 18:39:06 +0800 (CST)
Message-ID: <ea287909fd6043e0bbcdbfdcb0cc8063@wangyang25.otcaix.iscas.ac.cn>
In-Reply-To: <4bd85717cd6d4abea2a6d377e89c55dd@wangyang25.otcaix.iscas.ac.cn>
References: <4bd85717cd6d4abea2a6d377e89c55dd@wangyang25.otcaix.iscas.ac.cn>
MIME-Version: 1.0
From: "wangyang" <wangyang25@otcaix.iscas.ac.cn>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, alistair.francis@wdc.com
Date: 13 Aug 2026 18:39:06 +0800
Subject: [PATCH v2 3/4] target/riscv: enforce even register constraints for
 Zdinx fcvt pairs
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: base64
X-CM-TRANSID: rQCowACnrz3Knn1qgUMmBQ--.60519S6
X-Coremail-Antispam: 1UD129KBjvJXoW7uFWkAr4kJFyDGrWDWr1kGrg_yoW8GFyUpF
 s3CF4UC3y5Kry0yay0yr48CF47WFs3K34xWw1S9wn5Xa1DGrZFqF4Fkr4ayrnrJFsrtr4Y
 v3Wj9r15WFWjq3JanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUQYb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I2
 0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI
 8067AKxVWUWwA2048vs2IY020Ec7CjxVAFwI0_Gr0_Xr1l8cAvFVAK0II2c7xJM28CjxkF
 64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWUCVW8JwA2z4x0Y4vE2Ix0cI8IcV
 CY1x0267AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIE14v26r4j6F4UM28EF7xvwVC2z280aVCY
 1x0267AKxVW8JVW8Jr1lnxkEFVAIw20F6cxK64vIFxWle2I262IYc4CY6c8Ij28IcVAaY2
 xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2
 jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwACY4xI67k042
 43AVAKzVAKj4xxMxkIecxEwVAFwVW8twCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkE
 bVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67
 AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI
 42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMI
 IF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UMVCEFcxC
 0VAYjxAxZFUvcSsGvfC2KfnxnUUI43ZEXa7IUY0ZX7UUUUU==
X-Originating-IP: [124.16.137.194]
X-CM-SenderInfo: 5zdqw5xdqjjk46rwut1l0ox2xfdvhtffof0/
Received-SPF: pass client-ip=159.226.251.81;
 envelope-from=wangyang25@otcaix.iscas.ac.cn; helo=cstnet.cn
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

ZmN2dC5kLmggYW5kIGZjdnQuaC5kIGFjY2VzcyBhIDY0LWJpdCBkb3VibGUgaGVsZCBp
biBhIHJlZ2lzdGVyDQpwYWlyLCBzbyB1bmRlciBaZGlueC9aaGlueG1pbiB0aGUgb2Rk
LXJkIChmY3Z0LmQuaCkgYW5kIG9kZC1yczENCihmY3Z0LmguZCkgZW5jb2RpbmdzIGFy
ZSByZXNlcnZlZC4gIEFkZCB0aGUgbWlzc2luZyBSRVFVSVJFX0VWRU4NCmNoZWNrcyBz
byB0aG9zZSBlbmNvZGluZ3MgcmFpc2UgYW4gaWxsZWdhbC1pbnN0cnVjdGlvbiBleGNl
cHRpb24NCmluc3RlYWQgb2YgcmV0aXJpbmcuDQoNClJlc29sdmVzOiBodHRwczovL2dp
dGxhYi5jb20vcWVtdS1wcm9qZWN0L3FlbXUvLS93b3JrX2l0ZW1zLzQxMDkNClJldmll
d2VkLWJ5OiBBbGlzdGFpciBGcmFuY2lzIDxhbGlzdGFpci5mcmFuY2lzQHdkYy5jb20+
DQpTaWduZWQtb2ZmLWJ5OiB3YW5neWFuZyA8d2FuZ3lhbmcyNUBvdGNhaXguaXNjYXMu
YWMuY24+DQotLS0NCiAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAwIGRl
bGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEvdGFyZ2V0L3Jpc2N2L3RjZy9pbnNuX3Ry
YW5zL3RyYW5zX3J2emZoLmMuaW5jIGIvdGFyZ2V0L3Jpc2N2L3RjZy9pbnNuX3RyYW5z
L3RyYW5zX3J2emZoLmMuaW5jDQppbmRleCBmMzZiNDZjMjExOC4uNmVlNzE1MDZkNjIg
MTAwNjQ0DQotLS0gYS90YXJnZXQvcmlzY3YvdGNnL2luc25fdHJhbnMvdHJhbnNfcnZ6
ZmguYy5pbmMNCisrKyBiL3RhcmdldC9yaXNjdi90Y2cvaW5zbl90cmFucy90cmFuc19y
dnpmaC5jLmluYw0KQEAgLTQxMyw2ICs0MTMsNyBAQCBzdGF0aWMgYm9vbCB0cmFuc19m
Y3Z0X2RfaChEaXNhc0NvbnRleHQgKmN0eCwgYXJnX2ZjdnRfZF9oICphKQ0KICAgICBS
RVFVSVJFX0ZQVTsNCiAgICAgUkVRVUlSRV9aRkhNSU5fT1JfWkhJTlhNSU4oY3R4KTsN
CiAgICAgUkVRVUlSRV9aRElOWF9PUl9EKGN0eCk7DQorICAgIFJFUVVJUkVfRVZFTihj
dHgsIGEtPnJkKTsNCiANCiAgICAgVENHdl9pNjQgZGVzdCA9IGRlc3RfZnByKGN0eCwg
YS0+cmQpOw0KICAgICBUQ0d2X2k2NCBzcmMxID0gZ2V0X2Zwcl9ocyhjdHgsIGEtPnJz
MSk7DQpAQCAtNDQ3LDYgKzQ0OCw3IEBAIHN0YXRpYyBib29sIHRyYW5zX2ZjdnRfaF9k
KERpc2FzQ29udGV4dCAqY3R4LCBhcmdfZmN2dF9oX2QgKmEpDQogICAgIFJFUVVJUkVf
RlBVOw0KICAgICBSRVFVSVJFX1pGSE1JTl9PUl9aSElOWE1JTihjdHgpOw0KICAgICBS
RVFVSVJFX1pESU5YX09SX0QoY3R4KTsNCisgICAgUkVRVUlSRV9FVkVOKGN0eCwgYS0+
cnMxKTsNCiANCiAgICAgVENHdl9pNjQgZGVzdCA9IGRlc3RfZnByKGN0eCwgYS0+cmQp
Ow0KICAgICBUQ0d2X2k2NCBzcmMxID0gZ2V0X2Zwcl9kKGN0eCwgYS0+cnMxKTs=


