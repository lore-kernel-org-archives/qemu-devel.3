Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DA6DC5B56A
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 05:08:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wteiC-0005bW-Lu; Tue, 11 Aug 2026 01:07:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wangyang25@otcaix.iscas.ac.cn>)
 id 1wtbEj-0007jz-HK; Mon, 10 Aug 2026 21:25:01 -0400
Received: from smtp21.cstnet.cn ([159.226.251.21] helo=cstnet.cn)
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <wangyang25@otcaix.iscas.ac.cn>)
 id 1wtbEf-0007YG-Ao; Mon, 10 Aug 2026 21:25:01 -0400
Received: from DESKTOP-7FLBREN (unknown [124.16.137.194])
 by APP-01 (Coremail) with SMTP id qwCowABXLfHjeXpqxxPZBA--.17429S3;
 Tue, 11 Aug 2026 09:24:51 +0800 (CST)
Message-ID: <f73caf0640c1446db5c566f1bb005966@wangyang25.otcaix.iscas.ac.cn>
MIME-Version: 1.0
From: "wangyang" <wangyang25@otcaix.iscas.ac.cn>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, alistair.francis@wdc.com
Date: 11 Aug 2026 09:24:52 +0800
Subject: [PATCH 1/7] linux-user/riscv: honor zicntr=false for base counter CSRs
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: base64
X-CM-TRANSID: qwCowABXLfHjeXpqxxPZBA--.17429S3
X-Coremail-Antispam: 1UD129KBjvJXoW7CFWUWr4xWw1rKr4xZFWDurg_yoW8WF4xpr
 4kGFW3GrZ5tF92ka97Kr4DWF1fJa18G3yUKw1xu3yDGw45J3y5Jr4qga43AF1vqFyfAa1q
 9Fsrtw1kCFW8AaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUBYb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I2
 0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
 A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xII
 jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWUJVW8JwA2z4x0Y4vEx4
 A2jsIEc7CjxVAFwI0_Gr0_Gr1UM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x2
 0xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r126r1DMc
 Ij6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFcxC
 0VAYjxAxZF0Ew4CEw7xC0wCY02Avz4vE14v_KwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4
 IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1r
 MI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCV
 W8JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j
 6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UMV
 CEFcxC0VAYjxAxZFUvcSsGvfC2KfnxnUUI43ZEXa7IU5Z6pJUUUUU==
X-Originating-IP: [124.16.137.194]
X-CM-SenderInfo: 5zdqw5xdqjjk46rwut1l0ox2xfdvhtffof0/
Received-SPF: pass client-ip=159.226.251.21;
 envelope-from=wangyang25@otcaix.iscas.ac.cn; helo=cstnet.cn
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 11 Aug 2026 01:07:37 -0400
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

SW4gdXNlci1vbmx5IGJ1aWxkcyB0aGUgYmFzZSBaaWNudHIgY291bnRlcnMgY3ljbGUv
aW5zdHJldCBhcmUgcmV0aXJlZA0KdW5jb25kaXRpb25hbGx5IGJlY2F1c2UgdGhlIGV4
dF96aWNudHIgZ2F0ZSBzaXRzIGluc2lkZSB0aGUNCiNpZiAhZGVmaW5lZChDT05GSUdf
VVNFUl9PTkxZKSBibG9jay4gIC1jcHUgLi4uICx6aWNudHI9ZmFsc2UgaXMNCnRoZXJl
Zm9yZSBhY2NlcHRlZCBidXQgaWdub3JlZCwgd2hpbGUgdGhlIHNpYmxpbmcgemlocG09
ZmFsc2UgY29ycmVjdGx5DQptYWtlcyBocG1jb3VudGVyMyBpbGxlZ2FsLiAgTW92ZSB0
aGUgZXh0X3ppY250ciBjaGVjayBhaGVhZCBvZiB0aGUNCnVzZXItb25seSBibG9jayBz
byBhbiBleHBsaWNpdCB6aWNudHI9ZmFsc2UgbWFrZXMgdGhlIGJhc2UgY291bnRlcnMN
CmJlaGF2ZSBhcyB1bnN1cHBvcnRlZCBpbiBsaW51eC11c2VyIG1vZGUsIG1hdGNoaW5n
IG5hdGl2ZSBoYXJkd2FyZS4NCg0KUmVzb2x2ZXM6IGh0dHBzOi8vZ2l0bGFiLmNvbS9x
ZW11LXByb2plY3QvcWVtdS8tL3dvcmtfaXRlbXMvNDE0OA0KU2lnbmVkLW9mZi1ieTog
d2FuZ3lhbmcgPHdhbmd5YW5nMjVAb3RjYWl4LmlzY2FzLmFjLmNuPg0KLS0tDQogdGFy
Z2V0L3Jpc2N2L3RjZy9jc3IuYyB8IDExICsrKysrKystLS0tDQogMSBmaWxlIGNoYW5n
ZWQsIDcgaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkNCg0KZGlmZiAtLWdpdCBh
L3RhcmdldC9yaXNjdi90Y2cvY3NyLmMgYi90YXJnZXQvcmlzY3YvdGNnL2Nzci5jDQpp
bmRleCAzNmYyMDA0YmM1Ni4uYzA4MjlhYWIwNDMgMTAwNjQ0DQotLS0gYS90YXJnZXQv
cmlzY3YvdGNnL2Nzci5jDQorKysgYi90YXJnZXQvcmlzY3YvdGNnL2Nzci5jDQpAQCAt
MTExLDYgKzExMSwxMyBAQCBzdGF0aWMgUklTQ1ZFeGNlcHRpb24gdnMoQ1BVUklTQ1ZT
dGF0ZSAqZW52LCBpbnQgY3Nybm8pDQogDQogc3RhdGljIFJJU0NWRXhjZXB0aW9uIGN0
cihDUFVSSVNDVlN0YXRlICplbnYsIGludCBjc3JubykNCiB7DQorICAgIGlmICgoY3Ny
bm8gPj0gQ1NSX0NZQ0xFICYmIGNzcm5vIDw9IENTUl9JTlNUUkVUKSB8fA0KKyAgICAg
ICAgKGNzcm5vID49IENTUl9DWUNMRUggJiYgY3Nybm8gPD0gQ1NSX0lOU1RSRVRIKSkg
ew0KKyAgICAgICAgaWYgKCFyaXNjdl9jcHVfY2ZnKGVudiktPmV4dF96aWNudHIpIHsN
CisgICAgICAgICAgICByZXR1cm4gUklTQ1ZfRVhDUF9JTExFR0FMX0lOU1Q7DQorICAg
ICAgICB9DQorICAgIH0NCisNCiAjaWYgIWRlZmluZWQoQ09ORklHX1VTRVJfT05MWSkN
CiAgICAgUklTQ1ZDUFUgKmNwdSA9IGVudl9hcmNoY3B1KGVudik7DQogICAgIGludCBj
dHJfaW5kZXg7DQpAQCAtMTI3LDEwICsxMzQsNiBAQCBzdGF0aWMgUklTQ1ZFeGNlcHRp
b24gY3RyKENQVVJJU0NWU3RhdGUgKmVudiwgaW50IGNzcm5vKQ0KIA0KICAgICBpZiAo
KGNzcm5vID49IENTUl9DWUNMRSAmJiBjc3JubyA8PSBDU1JfSU5TVFJFVCkgfHwNCiAg
ICAgICAgIChjc3JubyA+PSBDU1JfQ1lDTEVIICYmIGNzcm5vIDw9IENTUl9JTlNUUkVU
SCkpIHsNCi0gICAgICAgIGlmICghcmlzY3ZfY3B1X2NmZyhlbnYpLT5leHRfemljbnRy
KSB7DQotICAgICAgICAgICAgcmV0dXJuIFJJU0NWX0VYQ1BfSUxMRUdBTF9JTlNUOw0K
LSAgICAgICAgfQ0KLQ0KICAgICAgICAgZ290byBza2lwX2V4dF9wbXVfY2hlY2s7DQog
ICAgIH0NCiANCi0tIA0KMi40My4wDQo=


