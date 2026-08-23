Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D92FC5DF97
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Aug 2026 13:15:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wy82b-0004BN-Qo; Sun, 23 Aug 2026 09:15:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wangyang25@otcaix.iscas.ac.cn>)
 id 1wy82F-0003vj-Rj; Sun, 23 Aug 2026 09:14:52 -0400
Received: from smtp25.cstnet.cn ([159.226.251.25] helo=cstnet.cn)
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <wangyang25@otcaix.iscas.ac.cn>)
 id 1wy82B-0007Of-AO; Sun, 23 Aug 2026 09:14:50 -0400
Received: from DESKTOP-7FLBREN (unknown [124.16.137.194])
 by APP-05 (Coremail) with SMTP id zQCowAD3Yz478opq7al2Bg--.8255S3;
 Sun, 23 Aug 2026 21:14:35 +0800 (CST)
Message-ID: <cover.1787489230.git.wangyang25@otcaix.iscas.ac.cn>
X-Mailer: git-send-email via .NET SmtpClient
MIME-Version: 1.0
From: wangyang25@otcaix.iscas.ac.cn
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, alistair.francis@wdc.com,
 liwei1518@gmail.com, daniel.barboza@oss.qualcomm.com,
 zhiwei_liu@linux.alibaba.com, chao.liu@processmission.com
Date: 23 Aug 2026 21:14:35 +0800
Subject: [PATCH 0/5] target/riscv: fix CFI and envcfg CSR handling
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: base64
X-CM-TRANSID: zQCowAD3Yz478opq7al2Bg--.8255S3
X-Coremail-Antispam: 1UD129KBjvJXoWrurW7CF4DZw1ftw13Zw1kXwb_yoW8JryDpr
 WxWr15Can3GFy3Aa4fJw1Utr15Xw4fG3y3Z3Z2yw1UtFyrAFWjyr9rK39rGF1UJFWfGw1a
 9a1jyr45CF4DAa7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUm2b7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
 0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
 A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xII
 jxv20xvEc7CjxVAFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVWUJVW8JwA2z4x0Y4vEx4
 A2jsIEc7CjxVAFwI0_Gr0_Gr1UM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x2
 0xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r126r1DMc
 Ij6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l
 FcxC0VAYjxAxZF0Ew4CEw7xC0wAKzVCY07xG64k0F24lc7CjxVAaw2AFwI0_JF0_Jw1lc2
 xSY4AK67AK6ry8MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E
 5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtV
 W8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY
 1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI
 0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JwCE64xvF2IEb7IF0Fy7YxBIdaVF
 xhVjvjDU0xZFpf9x07b2PEhUUUUU=
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

VGhpcyBzZXJpZXMgZml4ZXMgZml2ZSBpbmRlcGVuZGVudCBSSVNDLVYgQ1NSIGFuZCB0
cmFwLWhhbmRsaW5nIGRlZmVjdHMuCgpUaGUgcGF0Y2hlcyBjb3ZlcjoKCiAtIG1ha2lu
ZyBtbnN0YXR1cy5NTlBFTFAgd3JpdGFibGUgd2hlbiBaaWNmaWxwIGlzIGltcGxlbWVu
dGVkOwogLSBzYXZpbmcgRUxQIGluIG1zdGF0dXMuTVBFTFAgZm9yIE0tbW9kZSBSTk1J
IGV4Y2VwdGlvbnM7CiAtIG1hc2tpbmcgaW5hY3RpdmUgc2VudmNmZy5TU0Ugb24gcmVh
ZGJhY2s7CiAtIGdhdGluZyBlbnZjZmcgQ0JPIGZpZWxkcyBvbiBaaWNib20gYW5kIFpp
Y2JvejsKIC0gZW5mb3JjaW5nIG1lbnZjZmcuU1NFIHByZWNlZGVuY2UgZm9yIHNzcCBD
U1IgYWNjZXNzLgoKRWFjaCBwYXRjaCBpbmNsdWRlcyBhIGNvcnJlc3BvbmRpbmcgR2l0
TGFiIFdvcmsgSXRlbSBhbmQgYSBTaWduZWQtb2ZmLWJ5CmxpbmUuIFRoZSByZXBvcnRz
IHdlcmUgZm91bmQgd2l0aCBhbiBhdXRvbWF0ZWQgZGlmZmVyZW50aWFsL2VtdWxhdGlv
biB0b29sCmFuZCBtYW51YWxseSB0cmlhZ2VkIGFnYWluc3QgUUVNVSBtYXN0ZXIgZWVh
OGZlNjFiOGJlLgoKVGhlIHdpdG5lc3MgZmFtaWxpZXMgd2VyZSByZXJ1biBvbiB0aGUg
TGludXggeDg2XzY0IGV4ZWN1dGlvbiBwbGFuZS4gVGhlCnBhdGNoZXMgYXBwbHkgY2xl
YW5seSBhbmQgcGFzcyBnaXQgZGlmZiAtLWNoZWNrIGFuZCBjaGVja3BhdGNoLnBsIHdp
dGggemVybwplcnJvcnMgYW5kIHplcm8gd2FybmluZ3MuCgp3YW5neWFuZyAoNSk6CiAg
dGFyZ2V0L3Jpc2N2OiBtYWtlIG1uc3RhdHVzLk1OUEVMUCB3cml0YWJsZSB3aXRoIFpp
Y2ZpbHAKICB0YXJnZXQvcmlzY3Y6IHNhdmUgRUxQIGluIE1QRUxQIGZvciBSTk1JIGV4
Y2VwdGlvbnMKICB0YXJnZXQvcmlzY3Y6IG1hc2sgaW5hY3RpdmUgc2VudmNmZy5TU0Ug
b24gcmVhZAogIHRhcmdldC9yaXNjdjogZ2F0ZSBlbnZjZmcgQ0JPIGZpZWxkcyBvbiBl
eHRlbnNpb25zCiAgdGFyZ2V0L3Jpc2N2OiBlbmZvcmNlIFNTRSBwcmVjZWRlbmNlIGZv
ciBzc3AgQ1NSIGFjY2VzcwoKIHRhcmdldC9yaXNjdi90Y2cvY3B1X2hlbHBlci5jIHwg
IDcgKy0tLQogdGFyZ2V0L3Jpc2N2L3RjZy9jc3IuYyAgICAgICAgfCA3OSArKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrLS0tLQogMiBmaWxlcyBjaGFuZ2VkLCA3MSBp
bnNlcnRpb25zKCspLCAxNSBkZWxldGlvbnMoLSkKCi0tIAoyLjU1LjAud2luZG93cy4y
Cg==


