Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5B8AC5DF97
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Aug 2026 13:17:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wy82P-0003zj-0G; Sun, 23 Aug 2026 09:15:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wangyang25@otcaix.iscas.ac.cn>)
 id 1wy82F-0003vi-9C; Sun, 23 Aug 2026 09:14:51 -0400
Received: from smtp25.cstnet.cn ([159.226.251.25] helo=cstnet.cn)
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <wangyang25@otcaix.iscas.ac.cn>)
 id 1wy82B-0007Oi-LB; Sun, 23 Aug 2026 09:14:50 -0400
Received: from DESKTOP-7FLBREN (unknown [124.16.137.194])
 by APP-05 (Coremail) with SMTP id zQCowAD3Yz478opq7al2Bg--.8255S5;
 Sun, 23 Aug 2026 21:14:35 +0800 (CST)
Message-ID: <ce36a27e6346228b12c926a6f95835521ba56f86.1787489230.git.wangyang25@otcaix.iscas.ac.cn>
In-Reply-To: <cover.1787489230.git.wangyang25@otcaix.iscas.ac.cn>
References: <cover.1787489230.git.wangyang25@otcaix.iscas.ac.cn>
X-Mailer: git-send-email via .NET SmtpClient
MIME-Version: 1.0
From: wangyang25@otcaix.iscas.ac.cn
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, alistair.francis@wdc.com,
 liwei1518@gmail.com, daniel.barboza@oss.qualcomm.com,
 zhiwei_liu@linux.alibaba.com, chao.liu@processmission.com
Date: 23 Aug 2026 21:14:35 +0800
Subject: [PATCH 2/5] target/riscv: save ELP in MPELP for RNMI exceptions
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: base64
X-CM-TRANSID: zQCowAD3Yz478opq7al2Bg--.8255S5
X-Coremail-Antispam: 1UD129KBjvdXoW7GF18Wr1kur1fAry5CryUWrg_yoWkXrXE9a
 y8uFyvk3409w1vkFZ8CrnYyrWDG348ua40kw4fGr1furyxWFyakw1kXay5Ww1UZw15Xrn3
 CwsrXrW3ur13ZjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
 9fnUUIcSsGvfJTRUUUbG8YjsxI4VW3JwAYFVCjjxCrM7AC8VAFwI0_Wr0E3s1l1xkIjI8I
 6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l82xGYIkIc2x26280x7
 IE14v26r15M28IrcIa0xkI8VCY1x0267AKxVW8JVW5JwA2ocxC64kIII0Yj41l84x0c7CE
 w4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6x
 kF7I0E14v26r4j6F4UM28EF7xvwVC2z280aVAFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv6xkF
 7I0E14v26r4j6r4UJwAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv04
 87Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUAVWUtwAv7VC2z280
 aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4xvF2IEb7
 IF0Fy264kE64k0F24lw4CEc2x0rVAKj4xxMxkF7I0En4kS14v26r126r1DMxkIecxEwVAF
 wVW5GwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14
 v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkG
 c2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4U
 MIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UMVCEFcxC0VAYjxAxZFUvcSsGvfC2KfnxnU
 UI43ZEXa7IUn6nmtUUUUU==
X-Originating-IP: [124.16.137.194]
X-CM-SenderInfo: 5zdqw5xdqjjk46rwut1l0ox2xfdvhtffof0/
Received-SPF: pass client-ip=159.226.251.25;
 envelope-from=wangyang25@otcaix.iscas.ac.cn; helo=cstnet.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
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

QW4gTS1tb2RlIGV4Y2VwdGlvbiB3aXRoIG1uc3RhdHVzLk5NSUUgY2xlYXIgdXNlcyB0
aGUgUk5NSSB2ZWN0b3IsIGJ1dApTbXJubWkgb3RoZXJ3aXNlIHNwZWNpZmllcyB0aGUg
bm9ybWFsIE0tbW9kZSBzdGF0ZSB1cGRhdGVzLiBNUkVUIHJlc3RvcmVzCkVMUCBmcm9t
IG1zdGF0dXMuTVBFTFAsIHNvIHNhdmUgaXQgdGhlcmUgcmF0aGVyIHRoYW4gaW4gTU5Q
RUxQLgpSZXNvbHZlczogaHR0cHM6Ly9naXRsYWIuY29tL3FlbXUtcHJvamVjdC9xZW11
Ly0vd29ya19pdGVtcy80MjIzCgpTaWduZWQtb2ZmLWJ5OiB3YW5neWFuZyA8d2FuZ3lh
bmcyNUBvdGNhaXguaXNjYXMuYWMuY24+Ci0tLQogdGFyZ2V0L3Jpc2N2L3RjZy9jcHVf
aGVscGVyLmMgfCA3ICstLS0tLS0KIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigr
KSwgNiBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS90YXJnZXQvcmlzY3YvdGNnL2Nw
dV9oZWxwZXIuYyBiL3RhcmdldC9yaXNjdi90Y2cvY3B1X2hlbHBlci5jCmluZGV4IDA3
ZDkyMjIuLjYzMzdlOTEgMTAwNjQ0Ci0tLSBhL3RhcmdldC9yaXNjdi90Y2cvY3B1X2hl
bHBlci5jCisrKyBiL3RhcmdldC9yaXNjdi90Y2cvY3B1X2hlbHBlci5jCkBAIC0yMjc1
LDEyICsyMjc1LDcgQEAgdm9pZCByaXNjdl9jcHVfZG9faW50ZXJydXB0KENQVVN0YXRl
ICpjcykKICAgICAgICAgLyogaGFuZGxlIHRoZSB0cmFwIGluIE0tbW9kZSAqLwogICAg
ICAgICAvKiBzYXZlIGVscCBzdGF0dXMgKi8KICAgICAgICAgaWYgKGNwdV9nZXRfZmNm
aWVuKGVudikpIHsKLSAgICAgICAgICAgIGlmIChubm1pX2V4Y2VwKSB7Ci0gICAgICAg
ICAgICAgICAgZW52LT5tbnN0YXR1cyA9IHNldF9maWVsZChlbnYtPm1uc3RhdHVzLCBN
TlNUQVRVU19NTlBFTFAsCi0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICBlbnYtPmVscCk7Ci0gICAgICAgICAgICB9IGVsc2UgewotICAgICAgICAg
ICAgICAgIGVudi0+bXN0YXR1cyA9IHNldF9maWVsZChlbnYtPm1zdGF0dXMsIE1TVEFU
VVNfTVBFTFAsIGVudi0+ZWxwKTsKLSAgICAgICAgICAgIH0KKyAgICAgICAgICAgIGVu
di0+bXN0YXR1cyA9IHNldF9maWVsZChlbnYtPm1zdGF0dXMsIE1TVEFUVVNfTVBFTFAs
IGVudi0+ZWxwKTsKICAgICAgICAgfQogCiAgICAgICAgIGlmIChyaXNjdl9oYXNfZXh0
KGVudiwgUlZIKSkgewotLSAKMi41NS4wLndpbmRvd3MuMgoK


