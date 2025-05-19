Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA31CC2D0CD
	for <qemu-devel@archiver.kernel.org>; Mon, 19 May 2025 09:42:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uGwza-0002vj-Pl; Mon, 19 May 2025 05:41:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xb@ultrarisc.com>) id 1uGwzT-0002vU-Uf
 for qemu-devel@nongnu.org; Mon, 19 May 2025 05:40:59 -0400
Received: from [218.76.62.146] (helo=ultrarisc.com)
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <xb@ultrarisc.com>) id 1uGwzN-0000hf-Vk
 for qemu-devel@nongnu.org; Mon, 19 May 2025 05:40:59 -0400
Received: from xb$ultrarisc.com ( [192.168.100.1] ) by
 ajax-webmail-localhost.localdomain (Coremail) ; Mon, 19 May 2025 17:41:36
 +0800 (GMT+08:00)
X-Originating-IP: [192.168.100.1]
Date: Mon, 19 May 2025 17:41:36 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From: =?UTF-8?B?6LCi5rOi?= <xb@ultrarisc.com>
To: qemu-devel@nongnu.org
Cc: alistair.francis@wdc.com, palmer@dabbelt.com, pbonzini@redhat.com
Subject: [PATCH] target/riscv/kvm/kvm-cpu: Fixed the issue of resume after
 QEMU+KVM migration
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2024.1-cmXT6 build
 20240625(a75f206e) Copyright (c) 2002-2025 www.mailtech.cn
 mispb-8cc425bc-7df6-4523-bb46-a48cc1a964e6-ultrarisc.com
Content-Transfer-Encoding: base64
X-CM-CTRLDATA: 5f4svGZvb3Rlcl90eHQ9MjM0Nzo4NDA=
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <58a08318.d0.196e7eb9068.Coremail.xb@ultrarisc.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: AQAAfwDXUNDR_CpodCECAA--.199W
X-CM-SenderInfo: l0e63zxwud2x1vfou0bp/1tbiAQAHB2gqi9gADAACse
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VW3Jw
 CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
 daVFxhVjvjDU=
X-Host-Lookup-Failed: Reverse DNS lookup failed for 218.76.62.146 (failed)
Received-SPF: pass client-ip=218.76.62.146; envelope-from=xb@ultrarisc.com;
 helo=ultrarisc.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_20=-0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RDNS_NONE=0.793, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

VGhpcyBwYXRjaCBmaXhlcyB0d28gY3JpdGljYWwgaXNzdWVzIGluIFFFTVUgd2l0aCBLVk06Cgox
LiBQb3N0LU1pZ3JhdGlvbiBGYWlsdXJlIGluIFVzZXIgTW9kZTogV2hlbiBRRU1VIHdpdGggS1ZN
IGlzIHJ1bm5pbmcgaW4gdXNlciBtb2RlLCB0aGUgZ3Vlc3QgbWF5IGZhaWwgdG8gZnVuY3Rpb24g
Y29ycmVjdGx5IGFmdGVyIG1pZ3JhdGlvbiBkdWUgdG8gaW5jb3JyZWN0IHByaXZpbGVnZSBzdGF0
ZSByZXN0b3JhdGlvbi4KCjIuIE11bHRpLUNvcmUgR3Vlc3QgSW5jb25zaXN0ZW5jeTogQWZ0ZXIg
bWlncmF0aW9uLCBvbmx5IHRoZSBmaXJzdCBDUFUgKGNvcmUgMCkgcmVtYWlucyBmdW5jdGlvbmFs
LCB3aGlsZSBhbGwgb3RoZXIgY29yZXMgYmVjb21lIHVucmVzcG9uc2l2ZS4gVGhpcyBwYXRjaCBl
bnN1cmVzIGFsbCBjb3JlcyBhcmUgcHJvcGVybHkgc2V0IHRvIHJ1bm5hYmxlIHN0YXRlIGFmdGVy
IG1pZ3JhdGlvbi4KCkNoYW5nZXMgaW5jbHVkZToKLSBQcm9wZXJseSByZXN0b3JpbmcgZ3Vlc3Qg
cHJpdmlsZWdlZCBzdGF0ZSBkdXJpbmcgcmVnaXN0ZXIgc3luY2hyb25pemF0aW9uLgotIENvcnJl
Y3RseSB1cGRhdGluZyBtdWx0aS1jb3JlIHN0YXRlIGFmdGVyIG1pZ3JhdGlvbiB0byBlbnN1cmUg
YWxsIGNvcmVzIGFyZSBhY3RpdmUuCgpTaWduZWQtb2ZmLWJ5OiBYaWUgQm8gPHhiQHVsdHJhcmlz
Yy5jb20+CgotLS0KIHRhcmdldC9yaXNjdi9rdm0va3ZtLWNwdS5jIHwgMjMgKysrKysrKysrKysr
KysrKysrKysrKysKIDEgZmlsZSBjaGFuZ2VkLCAyMyBpbnNlcnRpb25zKCspCgotLS0gYS90YXJn
ZXQvcmlzY3Yva3ZtL2t2bS1jcHUuYworKysgYi90YXJnZXQvcmlzY3Yva3ZtL2t2bS1jcHUuYwpA
QCAtNTc2LDYgKzU3NiwxNCBAQCBzdGF0aWMgaW50IGt2bV9yaXNjdl9nZXRfcmVnc19jb3JlKENQ
VVN0YXRlICpjcykKICAgICB9CiAgICAgZW52LT5wYyA9IHJlZzsKCisgICAgLyogUmVzdG9yZSBn
dWVzdCBwcml2aWxlZ2UgbGV2ZWwgYWZ0ZXIgbWlncmF0aW9uICovCisgICAgcmV0ID0ga3ZtX2dl
dF9vbmVfcmVnKGNzLCBSSVNDVl9DT1JFX1JFRyhlbnYsIG1vZGUpLCAmcmVnKTsKKyAgICBpZiAo
cmV0KSB7CisgICAgICAgIHJldHVybiByZXQ7CisgICAgfQorICAgIGlmIChyZWcgIT0gMykgewor
ICAgICAgICBlbnYtPnByaXYgPSByZWc7CisgICAgfQoKICAgICBmb3IgKGkgPSAxOyBpIDwgMzI7
IGkrKykgewogICAgICAgICB1aW50NjRfdCBpZCA9IGt2bV9yaXNjdl9yZWdfaWRfdWxvbmcoZW52
LCBLVk1fUkVHX1JJU0NWX0NPUkUsIGkpOwogICAgICAgICByZXQgPSBrdm1fZ2V0X29uZV9yZWco
Y3MsIGlkLCAmcmVnKTsKQEAgLTYwMSw2ICs2MDksMTUgQEAgc3RhdGljIGludCBrdm1fcmlzY3Zf
cHV0X3JlZ3NfY29yZShDUFVTdGF0ZSAqY3MpCiAgICAgICAgIHJldHVybiByZXQ7CiAgICAgfQoK
KyAgICAvKiBTYXZlIGd1ZXN0IHByaXZpbGVnZSBsZXZlbCBiZWZvcmUgbWlncmF0aW9uICovCisg
ICAgcmVnID0gZW52LT5wcml2OworICAgIGlmIChyZWcgIT0gMykgeworICAgICAgICByZXQgPSBr
dm1fc2V0X29uZV9yZWcoY3MsIFJJU0NWX0NPUkVfUkVHKGVudiwgbW9kZSksICZyZWcpOworICAg
ICAgICBpZiAocmV0KSB7CisgICAgICAgICAgICByZXR1cm4gcmV0OworICAgICAgICB9CisgICAg
fQorCiAgICAgZm9yIChpID0gMTsgaSA8IDMyOyBpKyspIHsKICAgICAgICAgdWludDY0X3QgaWQg
PSBrdm1fcmlzY3ZfcmVnX2lkX3Vsb25nKGVudiwgS1ZNX1JFR19SSVNDVl9DT1JFLCBpKTsKICAg
ICAgICAgcmVnID0gZW52LT5ncHJbaV07CkBAIC0xMjg5LDYgKzEzMDYsMTIgQEAgaW50IGt2bV9h
cmNoX3B1dF9yZWdpc3RlcnMoQ1BVU3RhdGUgKmNzLCBpbnQgbGV2ZWwsIEVycm9yICoqZXJycCkK
ICAgICAgICAgcmV0dXJuIHJldDsKICAgICB9CgorICAgIC8qIEVuc3VyZSBhbGwgbm9uLWNvcmUg
MCBDUFVzIGFyZSBydW5uYWJsZSBhZnRlciBtaWdyYXRpb24gKi8KKyAgICBpZiAoKGxldmVsID09
IEtWTV9QVVRfRlVMTF9TVEFURSkgJiYgKGNzLT5jcHVfaW5kZXggIT0gMCkpIHsKKyAgICAgICAg
UklTQ1ZDUFUgKmNwdSA9IFJJU0NWX0NQVShjcyk7CisgICAgICAgIHJldCA9IGt2bV9yaXNjdl9z
eW5jX21wc3RhdGVfdG9fa3ZtKGNwdSwgS1ZNX01QX1NUQVRFX1JVTk5BQkxFKTsKKyAgICAgICAg
aWYgKHJldCkgeworICAgICAgICAgICAgcmV0dXJuIHJldDsKKyAgICAgICAgfQorICAgIH0KCiAg
ICAgaWYgKEtWTV9QVVRfUkVTRVRfU1RBVEUgPT0gbGV2ZWwpIHsKICAgICAgICAgUklTQ1ZDUFUg
KmNwdSA9IFJJU0NWX0NQVShjcyk7CiAgICAgICAgIGlmIChjcy0+Y3B1X2luZGV4ID09IDApIHsK
LS0gCjIuMzQuMQ0KDQpfX19fX19fX19fX19fX19fX19fX19fd3d3LnVsdHJhcmlzYy5jb20NCumH
jeimgeaPkOekuu+8muacrOmCruS7tuWMheaLrOmZhOS7tueahOWGheWuueaYr+WPl+azleW+i+S/
neaKpOeahOS/neWvhuS/oeaBr++8jOWmguaenOaCqOS4jeaYr+aMh+WumuaUtuS7tuS6uu+8jOiv
t+eri+WNs+WwhuacrOmCruS7tuWIoOmZpO+8jOazleW+i+emgeatouS7u+S9lemdnuazleeahOaK
q+mcsuOAgeWkjeWItuOAgeS8oOaSreaIluS7peS7u+S9leaWueW8j+S9v+eUqOacrOmCruS7tuOA
guacrOmCruS7tuS4reWMheWQq+eahOaEj+ingeOAgeW7uuiuruaYr+WfuuS6juaIluWPl+WIsOaI
keaWueihqOi+vuWSjOWumuS5ieeahOadoeasvuWPiuadoeS7tueahOmZkOWumu+8jOWmguaXoOaI
keaWueeahOato+W8j+S5pumdoua+hOa4heaIluaOiOadg++8jOS4jeWPr+iiq+WNleeLrOS9nOS4
uuS7u+S9leaDheW9ouS4i+eahOivgeaNruaIluS+neaNruOAguaEn+iwouaCqOeahOeQhuino+S4
jumFjeWQiOOAgueJiOadg+aJgOacieOAgklNUE9SVEFOVCBOT1RJQ0U6IFRoaXMgZW1haWwsIGlu
Y2x1ZGluZyBpdHMgYXR0YWNobWVudCBpZiBhbnksIGlzIGNvbmZpZGVudGlhbC4gSWYgeW91IGFy
ZSBub3QgdGhlIGludGVuZGVkIHJlY2lwaWVudCwgcGxlYXNlIGRlbGV0ZSBpdCBmcm9tIHlvdXIg
Y29tcHV0ZXIgaW1tZWRpYXRlbHkuIEFueSBkaXNjbG9zdXJlLCBjb3B5aW5nLCBvciBkaXN0cmli
dXRpb24gb2YgdGhpcyBtZXNzYWdlLCBvciB0YWtpbmcgb2YgYW55IGFjdGlvbiBiYXNlZCBvbiBp
dCBpcyBzdHJpY3RseSBwcm9oaWJpdGVkLiAgQW55IG9waW5pb25zIGFuZCBzdWdnZXN0aW9ucyBj
b250YWluZWQgaW4gdGhpcyBlbWFpbCBhcmUgc3ViamVjdCB0byB0aGUgdGVybXMgYW5kIGNvbmRp
dGlvbnMgZXhwcmVzc2VkIGFuZCBkZWZpbmVkIGJ5IHVzIGFuZCBzaG91bGQgbm90IGJlIHJlbGll
ZCB1cG9uIHVuY29uZGl0aW9uYWxseSB1bmRlciBhbnkgY2lyY3Vtc3RhbmNlcyB1bmxlc3MgdGhl
eSBhcmUgY29uZmlybWVkIGluIG9mZmljaWFsIHdyaXR0ZW4gY2xhcmlmaWNhdGlvbiBvciBhdXRo
b3JpemF0aW9uIGZyb20gdXMuICBUaGFuayB5b3UgZm9yIHlvdXIgdW5kZXJzdGFuZGluZyBhbmQg
Y29vcGVyYXRpb24uQWxsIHJpZ2h0cyByZXNlcnZlZC4=

