Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B13D1C5CFDB
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2026 10:40:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuSqJ-0002tw-Td; Thu, 13 Aug 2026 06:39:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wangyang25@otcaix.iscas.ac.cn>)
 id 1wuSqH-0002s2-72; Thu, 13 Aug 2026 06:39:21 -0400
Received: from smtp81.cstnet.cn ([159.226.251.81] helo=cstnet.cn)
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <wangyang25@otcaix.iscas.ac.cn>)
 id 1wuSqC-00014x-Rl; Thu, 13 Aug 2026 06:39:20 -0400
Received: from DESKTOP-7FLBREN (unknown [124.16.137.194])
 by APP-03 (Coremail) with SMTP id rQCowACnrz3Knn1qgUMmBQ--.60519S5;
 Thu, 13 Aug 2026 18:39:06 +0800 (CST)
Message-ID: <36c7cfebd27b4b6e8bcdd00e09e9dda0@wangyang25.otcaix.iscas.ac.cn>
In-Reply-To: <4bd85717cd6d4abea2a6d377e89c55dd@wangyang25.otcaix.iscas.ac.cn>
References: <4bd85717cd6d4abea2a6d377e89c55dd@wangyang25.otcaix.iscas.ac.cn>
MIME-Version: 1.0
From: "wangyang" <wangyang25@otcaix.iscas.ac.cn>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, alistair.francis@wdc.com
Date: 13 Aug 2026 18:39:06 +0800
Subject: [PATCH v2 2/4] target/riscv: reject FMV.X.W/FMV.W.X under Zfinx
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: base64
X-CM-TRANSID: rQCowACnrz3Knn1qgUMmBQ--.60519S5
X-Coremail-Antispam: 1UD129KBjvJXoW7KF1ktry5Cry3Kr4rCw1fXrb_yoW8XFW8pF
 sxGFWIkr4Ut3409ay8tr4avF13GFs3Gw42g39avws0va15GrZFqF1qkw43tFn8JF4kXr4Y
 9ayYyFy5ZFWDJFUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUQYb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I2
 0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI
 8067AKxVWUXwA2048vs2IY020Ec7CjxVAFwI0_JFI_Gr1l8cAvFVAK0II2c7xJM28CjxkF
 64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWUJVWUCwA2z4x0Y4vE2Ix0cI8IcV
 CY1x0267AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIE14v26r4j6F4UM28EF7xvwVC2z280aVCY
 1x0267AKxVW8JVW8Jr1lnxkEFVAIw20F6cxK64vIFxWle2I262IYc4CY6c8Ij28IcVAaY2
 xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2
 jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwACY4xI67k042
 43AVAKzVAKj4xxMxkIecxEwVAFwVW8twCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkE
 bVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67
 AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI
 42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMI
 IF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UMVCEFcxC
 0VAYjxAxZFUvcSsGvfC2KfnxnUUI43ZEXa7IU5uUDtUUUUU==
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

WmZpbnggZXhwbGljaXRseSBleGNsdWRlcyB0aGUgRk1WIHRyYW5zZmVyIGluc3RydWN0
aW9ucywgYnV0DQp0cmFuc19mbXZfeF93L3RyYW5zX2Ztdl93X3ggdXNlZCBSRVFVSVJF
X1pGSU5YX09SX0Ygc28gYSBaZmlueC1vbmx5DQpDUFUgYWNjZXB0ZWQgdGhlbS4gIFJl
cXVpcmUgUlZGIGluc3RlYWQgc28gdGhlIHRyYW5zZmVycyB0cmFwIHdpdGgNCmFuIGls
bGVnYWwgaW5zdHJ1Y3Rpb24gd2hlbiBvbmx5IFpmaW54IGlzIHByZXNlbnQuDQoNClJl
c29sdmVzOiBodHRwczovL2dpdGxhYi5jb20vcWVtdS1wcm9qZWN0L3FlbXUvLS93b3Jr
X2l0ZW1zLzQxMDgNClJldmlld2VkLWJ5OiBBbGlzdGFpciBGcmFuY2lzIDxhbGlzdGFp
ci5mcmFuY2lzQHdkYy5jb20+DQpTaWduZWQtb2ZmLWJ5OiB3YW5neWFuZyA8d2FuZ3lh
bmcyNUBvdGNhaXguaXNjYXMuYWMuY24+DQotLS0NCiAxIGZpbGUgY2hhbmdlZCwgNCBp
bnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEvdGFyZ2V0
L3Jpc2N2L3RjZy9pbnNuX3RyYW5zL3RyYW5zX3J2Zi5jLmluYyBiL3RhcmdldC9yaXNj
di90Y2cvaW5zbl90cmFucy90cmFuc19ydmYuYy5pbmMNCmluZGV4IGU5MzU1MjNjOTNj
Li4zMDVmNTQ1YjQ5NCAxMDA2NDQNCi0tLSBhL3RhcmdldC9yaXNjdi90Y2cvaW5zbl90
cmFucy90cmFuc19ydmYuYy5pbmMNCisrKyBiL3RhcmdldC9yaXNjdi90Y2cvaW5zbl90
cmFucy90cmFuc19ydmYuYy5pbmMNCkBAIC00MjgsNyArNDI4LDggQEAgc3RhdGljIGJv
b2wgdHJhbnNfZm12X3hfdyhEaXNhc0NvbnRleHQgKmN0eCwgYXJnX2Ztdl94X3cgKmEp
DQogew0KICAgICAvKiBOT1RFOiBUaGlzIHdhcyBGTVYuWC5TIGluIGFuIGVhcmxpZXIg
dmVyc2lvbiBvZiB0aGUgSVNBIHNwZWMhICovDQogICAgIFJFUVVJUkVfRlBVOw0KLSAg
ICBSRVFVSVJFX1pGSU5YX09SX0YoY3R4KTsNCisgICAgLyogWmZpbnggZXhwbGljaXRs
eSBleGNsdWRlcyB0aGUgRk1WIHRyYW5zZmVyIGluc3RydWN0aW9ucy4gKi8NCisgICAg
UkVRVUlSRV9FWFQoY3R4LCBSVkYpOw0KIA0KICAgICBUQ0d2IGRlc3QgPSBkZXN0X2dw
cihjdHgsIGEtPnJkKTsNCiAgICAgVENHdl9pNjQgc3JjMSA9IGdldF9mcHJfaHMoY3R4
LCBhLT5yczEpOw0KQEAgLTUzMSw3ICs1MzIsOCBAQCBzdGF0aWMgYm9vbCB0cmFuc19m
bXZfd194KERpc2FzQ29udGV4dCAqY3R4LCBhcmdfZm12X3dfeCAqYSkNCiB7DQogICAg
IC8qIE5PVEU6IFRoaXMgd2FzIEZNVi5TLlggaW4gYW4gZWFybGllciB2ZXJzaW9uIG9m
IHRoZSBJU0Egc3BlYyEgKi8NCiAgICAgUkVRVUlSRV9GUFU7DQotICAgIFJFUVVJUkVf
WkZJTlhfT1JfRihjdHgpOw0KKyAgICAvKiBaZmlueCBleHBsaWNpdGx5IGV4Y2x1ZGVz
IHRoZSBGTVYgdHJhbnNmZXIgaW5zdHJ1Y3Rpb25zLiAqLw0KKyAgICBSRVFVSVJFX0VY
VChjdHgsIFJWRik7DQogDQogICAgIFRDR3ZfaTY0IGRlc3QgPSBkZXN0X2ZwcihjdHgs
IGEtPnJkKTsNCiAgICAgVENHdiBzcmMgPSBnZXRfZ3ByKGN0eCwgYS0+cnMxLCBFWFRf
WkVSTyk7


