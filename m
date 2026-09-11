Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7D3DC88E41
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 02:22:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4qtw-0005VZ-BX; Thu, 10 Sep 2026 22:22:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wangyang25@otcaix.iscas.ac.cn>)
 id 1x4qUG-0007Nl-KP; Thu, 10 Sep 2026 21:55:40 -0400
Received: from smtp81.cstnet.cn ([159.226.251.81] helo=cstnet.cn)
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <wangyang25@otcaix.iscas.ac.cn>)
 id 1x4qTz-0007b1-N9; Thu, 10 Sep 2026 21:55:28 -0400
Received: from DESKTOP-7FLBREN (unknown [124.16.137.194])
 by APP-03 (Coremail) with SMTP id rQCowACHjz1sX6NqA05fBw--.10502S3;
 Fri, 11 Sep 2026 09:54:56 +0800 (CST)
Message-ID: <cde961533ff541a1a0c933aa69fba448@wangyang25.otcaix.iscas.ac.cn>
MIME-Version: 1.0
From: "wangyang" <wangyang25@otcaix.iscas.ac.cn>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, "Palmer Dabbelt" <palmer@dabbelt.com>, "Alistair
 Francis" <alistair.francis@wdc.com>, "Weiwei Li" <weiwei.li@gmail.com>,
 "Daniel Henrique Barboza" <daniel.barboza@oss.qualcomm.com>, "Liu Zhiwei"
 <zhiwei_liu@linux.alibaba.com>, "Chao Liu" <chao.liu@processmission.com>,
 "Laurent Vivier" <laurent@vivier.eu>, "Helge Deller" <deller@gmx.de>,
 "Pierrick Bouvier" <pierrick.bouvier@oss.qualcomm.com>
Date: 11 Sep 2026 09:54:56 +0800
Subject: [PATCH v2 0/2] linux-user/riscv: fix zicntr gating and reservations
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: base64
X-CM-TRANSID: rQCowACHjz1sX6NqA05fBw--.10502S3
X-Coremail-Antispam: 1UD129KBjvJXoWxJr47Ar43Cw13Ar45ArWrKrg_yoW5JF18pr
 Z5Gw4ayrZ5J34xJr4fAw1UCF1ruFZ3Gw4UWwn7tw1vqrs8Aryaqr4vk3WjqFy8JF10gr42
 9F4qkwn5u3yUGaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUmvb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
 0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
 A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xII
 jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWUJVW8JwA2z4x0Y4vEx4
 A2jsIEc7CjxVAFwI0_Gr0_Gr1UM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x2
 0xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17Mc
 Ij6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFcxC
 0VAYjxAxZF0Ew4CEw7xC0wACI402YVCY1x02628vn2kIc2xKxwCY1x0262kKe7AKxVWUtV
 W8ZwCY02Avz4vE14v_KwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC2
 0s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI
 0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv2
 0xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2js
 IE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UMVCEFcxC0VAYjxAxZFUv
 cSsGvfC2KfnxnUUI43ZEXa7IU5Du45UUUUU==
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

VGhpcyBpcyBhIHJlZnJlc2hlZCB0d28tcGF0Y2ggc2VyaWVzIGZvciB0aGUgbGludXgt
dXNlci9SSVNDLVYgaXNzdWVzDQp0cmFja2VkIGJ5IFdvcmsgSXRlbXMgIzQxNDggYW5k
ICM0MTQ5LiBUaGUgcGF0Y2hlcyBhZGRyZXNzIGluZGVwZW5kZW50DQpkZWZlY3RzIGlu
IHRoZSBzYW1lIHN1YnN5c3RlbSBhbmQgYXJlIHNlbnQgdG9nZXRoZXIgZm9yIHJldmll
dy4NCg0KUGF0Y2ggMSBmaXhlcyB0aGUgbGludXgtdXNlciBaaWNudHIgZXh0ZW5zaW9u
IGdhdGUuIFBhdGNoIDIgZml4ZXMNCnJlc2VydmF0aW9uIGludmFsaWRhdGlvbiBmb3Ig
YmFzZSBzY2FsYXIgaW50ZWdlciBzdG9yZXMgYW5kDQpBLWV4dGVuc2lvbiBBTU9zLg0K
UGF0Y2ggMiBhbHNvIGNsZWFycyByZXNlcnZhdGlvbiBzdGF0ZSB3aGVuIGEgbmV3IGxp
bnV4LXVzZXIgUklTQy1WIGhhcnQNCmlzIGNsb25lZCwgYW5kIHVzZXMgUUVNVSdzIGV4
aXN0aW5nIEVYQ1BfQVRPTUlDIHBhdGggdG8gbGluZWFyaXplIHRoZQ0KY29tcGxldGVk
IG1lbW9yeSBvcGVyYXRpb24gd2l0aCByZXNlcnZhdGlvbiBpbnZhbGlkYXRpb24uDQoN
CkNoYW5nZXMgc2luY2UgdjE6DQotIFJlYmFzZWQgdGhlIHNlcmllcyBvbnRvIGN1cnJl
bnQgbWFzdGVyLg0KLSBBZGRlZCBhIGNvdmVyIGxldHRlciBhbmQgcmVzZW50IHRoZSBj
b21wbGV0ZSB0d28tcGF0Y2ggc2VyaWVzLg0KLSBFeHBhbmRlZCBwYXRjaCAyIHRvIGNv
dmVyIG9yZGluYXJ5IHNjYWxhciBpbnRlZ2VyIHN0b3JlcyBhcyB3ZWxsIGFzDQogIEFN
T3MuDQotIFJlY29yZGVkIHRoZSBMUiBhY2Nlc3MgcmFuZ2UgYW5kIGhhbmRsZWQgcmVz
ZXJ2YXRpb24gc3RhdGUgYWNyb3NzIGhhcnQNCiAgY2xvbmluZy4NCi0gUGF0Y2ggMiBj
aGFuZ2VkIG1hdGVyaWFsbHksIHNvIGl0IHJlcXVlc3RzIGEgZnJlc2ggcmV2aWV3Lg0K
DQpUaGFuayB5b3UgZm9yIHRoZSByZXZpZXcgZ3VpZGFuY2UuIFRoaXMgdmVyc2lvbiBm
b2xsb3dzIHRoZSBzZXJpZXMNCnN0cnVjdHVyZSBhbmQgaW5jbHVkZXMgdGhlIG1pc3Np
bmcgY292ZXIgbGV0dGVyLiBQbGVhc2UgYWNjZXB0IG15DQphcG9sb2dpZXMgZm9yIG92
ZXJsb29raW5nIHRob3NlIGNvbW11bml0eSByZXF1aXJlbWVudHMuDQoNClRlc3Rpbmc6
DQotIFRoZSAxNC1jYXNlIFJWNjQgbGludXgtdXNlciB3aXRuZXNzIGNvdmVycyBzYW1l
LXZhbHVlIHN0b3JlcywNCiAgcHJlc2VydmUtdmFsdWUgQU1Pcywgd29yZC9kb3VibGV3
b3JkIG9wZXJhdGlvbnMsIG92ZXJsYXBwaW5nIGFkZHJlc3NlcywNCiAgZGlzdGFudC1h
ZGRyZXNzIGNvbnRyb2xzLCBhbmQgdHdvIGd1ZXN0IGhhcnRzLg0KLSBUaGUgY3VycmVu
dC1tYXN0ZXIgYmFzZWxpbmUgcmVwb3J0cyAxMiByZXF1aXJlZCBmYWlsdXJlczsgdGhl
IGZpeGVkDQogIGJ1aWxkIHJlcG9ydHMgMTQgY2FzZXMgYW5kIDAgZmFpbHVyZXMuDQot
IEEgc3VwcGxlbWVudGFyeSBjbG9uZSB3aXRuZXNzIHJlcG9ydHMgY2hpbGQgU0MgZmFp
bHVyZSBhbmQgdW5jaGFuZ2VkDQogIG1lbW9yeSBvbiB0aGUgZml4ZWQgYnVpbGQuDQot
IFRoZSBaaWNudHIgd2l0bmVzcyByZXBvcnRzIFNJR0lMTCBmb3IgYWxsIHRocmVlIGRp
c2FibGVkIGJhc2UgY291bnRlcnMNCiAgYW5kIHJldGFpbnMgdGhlIGVuYWJsZWQtZXh0
ZW5zaW9uIGNvbnRyb2wgYmVoYXZpb3IuDQoNCkV4aXN0aW5nIFdvcmsgSXRlbXM6DQot
IGh0dHBzOi8vZ2l0bGFiLmNvbS9xZW11LXByb2plY3QvcWVtdS8tL3dvcmtfaXRlbXMv
NDE0OA0KLSBodHRwczovL2dpdGxhYi5jb20vcWVtdS1wcm9qZWN0L3FlbXUvLS93b3Jr
X2l0ZW1zLzQxNDkNCg0Kd2FuZ3lhbmcgKDIpOg0KICBsaW51eC11c2VyL3Jpc2N2OiBo
b25vciB6aWNudHI9ZmFsc2UgZm9yIGJhc2UgY291bnRlciBDU1JzDQogIGxpbnV4LXVz
ZXIvcmlzY3Y6IGludmFsaWRhdGUgcmVzZXJ2YXRpb25zIGFmdGVyIHN0b3Jlcw0KDQog
bGludXgtdXNlci9yaXNjdi90YXJnZXRfY3B1LmggICAgICAgICAgICAgICAgIHwgIDIg
Kw0KIHRhcmdldC9yaXNjdi9jcHUuYyAgICAgICAgICAgICAgICAgICAgICAgICAgICB8
ICAzICsrDQogdGFyZ2V0L3Jpc2N2L2NwdS5oICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIHwgIDMgKysNCiB0YXJnZXQvcmlzY3YvaGVscGVyLmggICAgICAgICAgICAgICAg
ICAgICAgICAgfCAgNSArKysNCiB0YXJnZXQvcmlzY3YvdGNnL2Nzci5jICAgICAgICAg
ICAgICAgICAgICAgICAgfCAxMSArKysrLS0NCiB0YXJnZXQvcmlzY3YvdGNnL2luc25f
dHJhbnMvdHJhbnNfcnZhLmMuaW5jICAgfCAyNCArKysrKysrKysrKysNCiB0YXJnZXQv
cmlzY3YvdGNnL2luc25fdHJhbnMvdHJhbnNfcnZpLmMuaW5jICAgfCAxMSArKysrKysN
CiAuLi4vcmlzY3YvdGNnL2luc25fdHJhbnMvdHJhbnNfcnZ6YXdycy5jLmluYyAgfCAg
MyArKw0KIHRhcmdldC9yaXNjdi90Y2cvb3BfaGVscGVyLmMgICAgICAgICAgICAgICAg
ICB8IDM1ICsrKysrKysrKysrKysrKysrDQogdGFyZ2V0L3Jpc2N2L3RjZy90cmFuc2xh
dGUuYyAgICAgICAgICAgICAgICAgIHwgMzggKysrKysrKysrKysrKysrKysrKw0KIDEw
IGZpbGVzIGNoYW5nZWQsIDEzMSBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQ==


