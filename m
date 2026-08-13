Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF4C5C5DF66
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2026 10:39:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuSqH-0002rk-OF; Thu, 13 Aug 2026 06:39:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wangyang25@otcaix.iscas.ac.cn>)
 id 1wuSqF-0002qt-Ox; Thu, 13 Aug 2026 06:39:19 -0400
Received: from smtp81.cstnet.cn ([159.226.251.81] helo=cstnet.cn)
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <wangyang25@otcaix.iscas.ac.cn>)
 id 1wuSqC-00014z-Lm; Thu, 13 Aug 2026 06:39:19 -0400
Received: from DESKTOP-7FLBREN (unknown [124.16.137.194])
 by APP-03 (Coremail) with SMTP id rQCowACnrz3Knn1qgUMmBQ--.60519S4;
 Thu, 13 Aug 2026 18:39:06 +0800 (CST)
Message-ID: <9b2f22fc402b48b8ba81f72be8ed04bc@wangyang25.otcaix.iscas.ac.cn>
In-Reply-To: <4bd85717cd6d4abea2a6d377e89c55dd@wangyang25.otcaix.iscas.ac.cn>
References: <4bd85717cd6d4abea2a6d377e89c55dd@wangyang25.otcaix.iscas.ac.cn>
MIME-Version: 1.0
From: "wangyang" <wangyang25@otcaix.iscas.ac.cn>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, alistair.francis@wdc.com
Date: 13 Aug 2026 18:39:06 +0800
Subject: [PATCH v2 1/4] target/riscv: honor zicbo* envcfg gating in
 linux-user mode
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: base64
X-CM-TRANSID: rQCowACnrz3Knn1qgUMmBQ--.60519S4
X-Coremail-Antispam: 1UD129KBjvJXoW7WrW8trW5KryxGr4xtw43Wrg_yoW8KryrpF
 s3WrW7Gr95Ca4kJa97Jr18W3Wruw4rGrWj9an7C3yvq3y5ArZxWFn8tw12gF98Wan5Jr42
 93ZFvw1a9r4kJaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUQ0b7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
 0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI
 8067AKxVWUGwA2048vs2IY020Ec7CjxVAFwI0_Jrv_JF4l8cAvFVAK0II2c7xJM28CjxkF
 64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWUJVWUCwA2z4x0Y4vE2Ix0cI8IcV
 CY1x0267AKxVWUJVW8JwA2z4x0Y4vEx4A2jsIE14v26r4j6F4UM28EF7xvwVC2z280aVCY
 1x0267AKxVW8JVW8Jr1lnxkEFVAIw20F6cxK64vIFxWle2I262IYc4CY6c8Ij28IcVAaY2
 xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2
 jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwACY4xI67k042
 43AVAKzVAKj4xxMxkIecxEwVAFwVW8twCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkE
 bVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67
 AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI
 42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMI
 IF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_Gr1l6VACY4xI
 67k04243AbIYCTnIWIevJa73UjIFyTuYvjxUgJKsDUUUU
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

SW4gdXNlci1vbmx5IGJ1aWxkcyBjaGVja196aWNib19lbnZjZmcoKSBza2lwcGVkIHRo
ZSBlbnZjZmcgY2hlY2sNCmVudGlyZWx5ICgjaWYgIWRlZmluZWQoQ09ORklHX1VTRVJf
T05MWSkpLCBzbyBjYm8uaW52YWwvY2JvLmZsdXNoLw0KY2JvLnplcm8gcmV0aXJlZCB1
bmNvbmRpdGlvbmFsbHkgaW4gbGludXgtdXNlciBldmVuIHRob3VnaCB0aGUNCm1hY2hp
bmUtbGV2ZWwgZW52Y2ZnIGZpZWxkcyBhcmUgbmV2ZXIgaW5pdGlhbGl6ZWQuICBHaXZl
IHRoZQ0KdXNlci1tb2RlIGJ1aWxkIGEgc2VudmNmZy1iYXNlZCBnYXRlLCBhbmQgaW5p
dGlhbGl6ZSBTRU5WQ0ZHX0NCWkUgYXQNCnJlc2V0IHdoZW4gZXh0X3ppY2JveiBpcyBl
bmFibGVkIHNvIGNiby56ZXJvIHN0YXlzIHVzYWJsZSB3aGlsZQ0KY2JvLmludmFsL2Ni
by5mbHVzaCByZW1haW4gaWxsZWdhbCwgbWF0Y2hpbmcgdGhlIHVzZXItbW9kZSB2aWV3
IG9mIGENCnR5cGljYWwgZmlybXdhcmUva2VybmVsIHNldHVwLg0KDQpSZXNvbHZlczog
aHR0cHM6Ly9naXRsYWIuY29tL3FlbXUtcHJvamVjdC9xZW11Ly0vd29ya19pdGVtcy80
MTA3DQpSZXZpZXdlZC1ieTogQWxpc3RhaXIgRnJhbmNpcyA8YWxpc3RhaXIuZnJhbmNp
c0B3ZGMuY29tPg0KU2lnbmVkLW9mZi1ieTogd2FuZ3lhbmcgPHdhbmd5YW5nMjVAb3Rj
YWl4LmlzY2FzLmFjLmNuPg0KLS0tDQogMiBmaWxlcyBjaGFuZ2VkLCAxOCBpbnNlcnRp
b25zKCspLCAxIGRlbGV0aW9uKC0pDQoNCmRpZmYgLS1naXQgYS90YXJnZXQvcmlzY3Yv
Y3B1LmMgYi90YXJnZXQvcmlzY3YvY3B1LmMNCmluZGV4IDVhODJlNjU2M2JmLi40NWI3
NjEwYWE0ZiAxMDA2NDQNCi0tLSBhL3RhcmdldC9yaXNjdi9jcHUuYw0KKysrIGIvdGFy
Z2V0L3Jpc2N2L2NwdS5jDQpAQCAtMTA2MSw2ICsxMDYxLDE0IEBAIHN0YXRpYyB2b2lk
IHJpc2N2X2NwdV9yZXNldF9ob2xkKE9iamVjdCAqb2JqLCBSZXNldFR5cGUgdHlwZSkN
CiAjZWxzZQ0KICAgICBlbnYtPnByaXYgPSBQUlZfVTsNCiAgICAgZW52LT5zZW52Y2Zn
ID0gMDsNCisgICAgLyoNCisgICAgICogTWF0Y2ggdGhlIHVzZXItbW9kZSB2aWV3IG9m
IGEgdHlwaWNhbCBmaXJtd2FyZS9rZXJuZWwgc2V0dXAgd2hlcmUNCisgICAgICogY2Jv
Lnplcm8gaXMgZW5hYmxlZCBmb3IgdXNlciBtb2RlOyB0aGUgQ0JDRkUvQ0JJRSBiaXRz
IHN0YXkgemVybywNCisgICAgICogc28gdGhlIGNhY2hlLW1hbmFnZW1lbnQgb3BlcmF0
aW9ucyByZW1haW4gaWxsZWdhbCBpbiB1c2VyIG1vZGUuDQorICAgICAqLw0KKyAgICBp
ZiAocmlzY3ZfY3B1X2NmZyhlbnYpLT5leHRfemljYm96KSB7DQorICAgICAgICBlbnYt
PnNlbnZjZmcgfD0gU0VOVkNGR19DQlpFOw0KKyAgICB9DQogICAgIGVudi0+bWVudmNm
ZyA9IDA7DQogI2VuZGlmIC8qICFDT05GSUdfVVNFUl9PTkxZICovDQogDQpkaWZmIC0t
Z2l0IGEvdGFyZ2V0L3Jpc2N2L3RjZy9vcF9oZWxwZXIuYyBiL3RhcmdldC9yaXNjdi90
Y2cvb3BfaGVscGVyLmMNCmluZGV4IGJhM2M3ZGEzNzVhLi5iOWQwZGVhY2RmYiAxMDA2
NDQNCi0tLSBhL3RhcmdldC9yaXNjdi90Y2cvb3BfaGVscGVyLmMNCisrKyBiL3Rhcmdl
dC9yaXNjdi90Y2cvb3BfaGVscGVyLmMNCkBAIC0xNDYsNyArMTQ2LDE2IEBAIHRhcmdl
dF91bG9uZyBoZWxwZXJfY3NycndfaTEyOChDUFVSSVNDVlN0YXRlICplbnYsIGludCBj
c3IsDQogc3RhdGljIHZvaWQgY2hlY2tfemljYm9fZW52Y2ZnKENQVVJJU0NWU3RhdGUg
KmVudiwgdGFyZ2V0X3Vsb25nIGVudmJpdHMsDQogICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICB1aW50cHRyX3QgcmEpDQogew0KLSNpZm5kZWYgQ09ORklHX1VTRVJf
T05MWQ0KKyNpZiBkZWZpbmVkKENPTkZJR19VU0VSX09OTFkpDQorICAgIC8qDQorICAg
ICAqIGxpbnV4LXVzZXI6IHRoZSBtYWNoaW5lLWxldmVsIGVudmNmZyBmaWVsZHMgYXJl
IG5vdCBwYXJ0IG9mIHRoZQ0KKyAgICAgKiB1c2VyLW1vZGUgZW52aXJvbm1lbnQ7IG9u
bHkgdGhlIHVzZXItbW9kZSB2aWV3IG9mIHRoZSBlbmFibGluZw0KKyAgICAgKiBiaXRz
IChzZW52Y2ZnLCBhcyBpbml0aWFsaXplZCBmb3IgdGhlIGd1ZXN0KSBhcHBsaWVzLg0K
KyAgICAgKi8NCisgICAgaWYgKCFnZXRfZmllbGQoZW52LT5zZW52Y2ZnLCBlbnZiaXRz
KSkgew0KKyAgICAgICAgcmlzY3ZfcmFpc2VfZXhjZXB0aW9uKGVudiwgUklTQ1ZfRVhD
UF9JTExFR0FMX0lOU1QsIHJhKTsNCisgICAgfQ0KKyNlbHNlDQogICAgIGlmICgoZW52
LT5wcml2IDwgUFJWX00pICYmICFnZXRfZmllbGQoZW52LT5tZW52Y2ZnLCBlbnZiaXRz
KSkgew0KICAgICAgICAgcmlzY3ZfcmFpc2VfZXhjZXB0aW9uKGVudiwgUklTQ1ZfRVhD
UF9JTExFR0FMX0lOU1QsIHJhKTsNCiAgICAgfQ==


