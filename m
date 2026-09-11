Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7839C88E41
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 02:18:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4qph-0003Kv-2Y; Thu, 10 Sep 2026 22:17:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wangyang25@otcaix.iscas.ac.cn>)
 id 1x4qUG-0007Nj-Jf; Thu, 10 Sep 2026 21:55:39 -0400
Received: from smtp81.cstnet.cn ([159.226.251.81] helo=cstnet.cn)
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <wangyang25@otcaix.iscas.ac.cn>)
 id 1x4qTz-0007b5-3r; Thu, 10 Sep 2026 21:55:28 -0400
Received: from DESKTOP-7FLBREN (unknown [124.16.137.194])
 by APP-03 (Coremail) with SMTP id rQCowACHjz1sX6NqA05fBw--.10502S4;
 Fri, 11 Sep 2026 09:54:57 +0800 (CST)
Message-ID: <41f744bcf7604f71ae13108069efd94e@wangyang25.otcaix.iscas.ac.cn>
In-Reply-To: <cde961533ff541a1a0c933aa69fba448@wangyang25.otcaix.iscas.ac.cn>
References: <cde961533ff541a1a0c933aa69fba448@wangyang25.otcaix.iscas.ac.cn>
MIME-Version: 1.0
From: "wangyang" <wangyang25@otcaix.iscas.ac.cn>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, "Palmer Dabbelt" <palmer@dabbelt.com>, "Alistair
 Francis" <alistair.francis@wdc.com>, "Weiwei Li" <weiwei.li@gmail.com>,
 "Daniel Henrique Barboza" <daniel.barboza@oss.qualcomm.com>, "Liu Zhiwei"
 <zhiwei_liu@linux.alibaba.com>, "Chao Liu" <chao.liu@processmission.com>,
 "Laurent Vivier" <laurent@vivier.eu>, "Helge Deller" <deller@gmx.de>,
 "Pierrick Bouvier" <pierrick.bouvier@oss.qualcomm.com>
Date: 11 Sep 2026 09:54:57 +0800
Subject: [PATCH v2 1/2] linux-user/riscv: honor zicntr=false for base
 counterCSRs
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: base64
X-CM-TRANSID: rQCowACHjz1sX6NqA05fBw--.10502S4
X-Coremail-Antispam: 1UD129KBjvJXoW7trWkAryrZFykCF1xtr15XFb_yoW8Wr4Dpr
 4kWa47WrZ5tas2ka97trsrWF1fWa1fG3y7Gws293ykGw45A3yUGrs0qF1UJF18WFZxCwsx
 uFW7tw4kCF48AFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUdqb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I2
 0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI
 8067AKxVWUGwA2048vs2IY020Ec7CjxVAFwI0_Gr0_Xr1l8cAvFVAK0II2c7xJM28CjxkF
 64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWUJVWUCwA2z4x0Y4vE2Ix0cI8IcV
 CY1x0267AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIE14v26r1j6r4UM28EF7xvwVC2z280aVCY
 1x0267AKxVW8JVW8Jr1lnxkEFVAIw20F6cxK64vIFxWle2I262IYc4CY6c8Ij28IcVAaY2
 xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2
 jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwACY4xI67k042
 43AVAKzVAKj4xxM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS14v26r1q6r43MxkI
 ecxEwVAFwVWkMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I
 8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8
 ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x
 0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_
 Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8Jr1l6VACY4xI67k04243AbIYCTnIWI
 evJa73UjIFyTuYvjxUyLIDDUUUU
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

SW4gdXNlci1vbmx5IGJ1aWxkcywgdGhlIGJhc2UgY3ljbGUgYW5kIGluc3RyZXQgQ1NS
cyBieXBhc3MgdGhlIHppY250cg0KZmVhdHVyZSBnYXRlIGJlY2F1c2UgdGhlIGNoZWNr
IGlzIGluc2lkZSB0aGUgc3lzdGVtLW1vZGUgYmxvY2suIE1vdmUgdGhlDQpjaGVjayBi
ZWZvcmUgdGhlIGNvbmRpdGlvbmFsIGJsb2NrIHNvIGFuIGV4cGxpY2l0bHkgZGlzYWJs
ZWQgemljbnRyDQpleHRlbnNpb24gbWFrZXMgdGhlIENTUnMgaWxsZWdhbCBpbiBsaW51
eC11c2VyIG1vZGUuDQoNClJlc29sdmVzOiBodHRwczovL2dpdGxhYi5jb20vcWVtdS1w
cm9qZWN0L3FlbXUvLS93b3JrX2l0ZW1zLzQxNDgNCg0KUmV2aWV3ZWQtYnk6IEFsaXN0
YWlyIEZyYW5jaXMgPGFsaXN0YWlyLmZyYW5jaXNAd2RjLmNvbT4NClNpZ25lZC1vZmYt
Ynk6IHdhbmd5YW5nIDx3YW5neWFuZzI1QG90Y2FpeC5pc2Nhcy5hYy5jbj4NCi0tLQ0K
Q2hhbmdlcyBzaW5jZSB2MToNCi0gUmViYXNlZCBvbnRvIGN1cnJlbnQgbWFzdGVyOyB0
aGUgY29kZSBjaGFuZ2UgaXMgdW5jaGFuZ2VkLg0KLSBSZXNlbnQgYXMgcGF0Y2ggMS8y
IGluIHRoZSBjb21wbGV0ZSBzZXJpZXMuDQoNCiB0YXJnZXQvcmlzY3YvdGNnL2Nzci5j
IHwgMTEgKysrKysrKy0tLS0NCiAxIGZpbGUgY2hhbmdlZCwgNyBpbnNlcnRpb25zKCsp
LCA0IGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEvdGFyZ2V0L3Jpc2N2L3RjZy9j
c3IuYyBiL3RhcmdldC9yaXNjdi90Y2cvY3NyLmMNCmluZGV4IGJkNGI2ZGMxMTQuLjA2
MWJjOWRiNzcgMTAwNjQ0DQotLS0gYS90YXJnZXQvcmlzY3YvdGNnL2Nzci5jDQorKysg
Yi90YXJnZXQvcmlzY3YvdGNnL2Nzci5jDQpAQCAtMTExLDYgKzExMSwxMyBAQCBzdGF0
aWMgUklTQ1ZFeGNlcHRpb24gdnMoQ1BVUklTQ1ZTdGF0ZSAqZW52LCBpbnQgY3Nybm8p
DQogDQogc3RhdGljIFJJU0NWRXhjZXB0aW9uIGN0cihDUFVSSVNDVlN0YXRlICplbnYs
IGludCBjc3JubykNCiB7DQorICAgIGlmICgoY3Nybm8gPj0gQ1NSX0NZQ0xFICYmIGNz
cm5vIDw9IENTUl9JTlNUUkVUKSB8fA0KKyAgICAgICAgKGNzcm5vID49IENTUl9DWUNM
RUggJiYgY3Nybm8gPD0gQ1NSX0lOU1RSRVRIKSkgew0KKyAgICAgICAgaWYgKCFyaXNj
dl9jcHVfY2ZnKGVudiktPmV4dF96aWNudHIpIHsNCisgICAgICAgICAgICByZXR1cm4g
UklTQ1ZfRVhDUF9JTExFR0FMX0lOU1Q7DQorICAgICAgICB9DQorICAgIH0NCisNCiAj
aWYgIWRlZmluZWQoQ09ORklHX1VTRVJfT05MWSkNCiAgICAgUklTQ1ZDUFUgKmNwdSA9
IGVudl9hcmNoY3B1KGVudik7DQogICAgIGludCBjdHJfaW5kZXg7DQpAQCAtMTI3LDEw
ICsxMzQsNiBAQCBzdGF0aWMgUklTQ1ZFeGNlcHRpb24gY3RyKENQVVJJU0NWU3RhdGUg
KmVudiwgaW50IGNzcm5vKQ0KIA0KICAgICBpZiAoKGNzcm5vID49IENTUl9DWUNMRSAm
JiBjc3JubyA8PSBDU1JfSU5TVFJFVCkgfHwNCiAgICAgICAgIChjc3JubyA+PSBDU1Jf
Q1lDTEVIICYmIGNzcm5vIDw9IENTUl9JTlNUUkVUSCkpIHsNCi0gICAgICAgIGlmICgh
cmlzY3ZfY3B1X2NmZyhlbnYpLT5leHRfemljbnRyKSB7DQotICAgICAgICAgICAgcmV0
dXJuIFJJU0NWX0VYQ1BfSUxMRUdBTF9JTlNUOw0KLSAgICAgICAgfQ0KLQ0KICAgICAg
ICAgZ290byBza2lwX2V4dF9wbXVfY2hlY2s7DQogICAgIH0NCiA=


