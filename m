Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE47AC3ABC3
	for <qemu-devel@archiver.kernel.org>; Mon, 12 May 2025 05:59:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEMBE-00077E-Bt; Mon, 12 May 2025 01:58:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xb@ultrarisc.com>) id 1uEHt6-0005uX-GM
 for qemu-devel@nongnu.org; Sun, 11 May 2025 21:23:25 -0400
Received: from [218.76.62.146] (helo=ultrarisc.com)
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <xb@ultrarisc.com>) id 1uEHt2-0005po-Cu
 for qemu-devel@nongnu.org; Sun, 11 May 2025 21:23:24 -0400
Received: from xb$ultrarisc.com ( [192.168.100.1] ) by
 ajax-webmail-localhost.localdomain (Coremail) ; Mon, 12 May 2025 09:17:10
 +0800 (GMT+08:00)
X-Originating-IP: [192.168.100.1]
Date: Mon, 12 May 2025 09:17:10 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From: =?UTF-8?B?6LCi5rOi?= <xb@ultrarisc.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] target/riscv/kvm/kvm-cpu: Fixed the issue of resume after
 QEMU+KVM migration
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2024.1-cmXT6 build
 20240625(a75f206e) Copyright (c) 2002-2025 www.mailtech.cn
 mispb-8cc425bc-7df6-4523-bb46-a48cc1a964e6-ultrarisc.com
Content-Transfer-Encoding: base64
X-CM-CTRLDATA: tLTOPmZvb3Rlcl90eHQ9MjM4Mzo4NDA=
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <6863aff8.bc1.196c21139a6.Coremail.xb@ultrarisc.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: AQAAfwBHhxAXTCFoJ6QVAA--.951W
X-CM-SenderInfo: l0e63zxwud2x1vfou0bp/1tbiAQARB2gdgHsAFgADsM
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VW3Jw
 CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
 daVFxhVjvjDU=
X-Host-Lookup-Failed: Reverse DNS lookup failed for 218.76.62.146 (failed)
Received-SPF: pass client-ip=218.76.62.146; envelope-from=xb@ultrarisc.com;
 helo=ultrarisc.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_40=-0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 RDNS_NONE=0.793, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 12 May 2025 01:58:09 -0400
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

VGhpcyBwYXRjaCBmaXhlcyB0d28gY3JpdGljYWwgaXNzdWVzIGluIFFFTVUgd2l0aCBLVk06ClBv
c3QtTWlncmF0aW9uIEZhaWx1cmUgaW4gVXNlciBNb2RlOiBXaGVuIFFFTVUgd2l0aCBLVk0gaXMg
cnVubmluZyBpbiB1c2VyIG1vZGUsIHRoZSBndWVzdCBtYXkgZmFpbCB0byBmdW5jdGlvbiBjb3Jy
ZWN0bHkgYWZ0ZXIgbWlncmF0aW9uLgpNdWx0aS1Db3JlIEd1ZXN0IEluY29uc2lzdGVuY3k6IEFm
dGVyIG1pZ3JhdGlvbiwgb25seSB0aGUgZmlyc3QgQ1BVIChjb3JlIDApIHJlbWFpbnMgZnVuY3Rp
b25hbCwgd2hpbGUgYWxsIG90aGVyIGNvcmVzIGJlY29tZSB1bnJlc3BvbnNpdmUuClRoaXMgcGF0
Y2ggYWRkcmVzc2VzIGJvdGggcHJvYmxlbXMgdG8gZW5zdXJlIHN0YWJsZSBndWVzdCBvcGVyYXRp
b24gYWZ0ZXIgbWlncmF0aW9uLgoKU2lnbmVkLW9mZi1ieTogeGllYm8taGFvMTIzIDx4YkB1bHRy
YXJpc2MuY29tPgotLS0KIHRhcmdldC9yaXNjdi9rdm0va3ZtLWNwdS5jIHwgMjMgKysrKysrKysr
KysrKysrKysrKysrKysKIDEgZmlsZSBjaGFuZ2VkLCAyMyBpbnNlcnRpb25zKCspCgpkaWZmIC0t
Z2l0IGEvdGFyZ2V0L3Jpc2N2L2t2bS9rdm0tY3B1LmMgYi90YXJnZXQvcmlzY3Yva3ZtL2t2bS1j
cHUuYwppbmRleCA3NTcyNGI2YWY0Li5hMTVjYWEyMGNlIDEwMDY0NAotLS0gYS90YXJnZXQvcmlz
Y3Yva3ZtL2t2bS1jcHUuYworKysgYi90YXJnZXQvcmlzY3Yva3ZtL2t2bS1jcHUuYwpAQCAtNTc2
LDYgKzU3NiwxNCBAQCBzdGF0aWMgaW50IGt2bV9yaXNjdl9nZXRfcmVnc19jb3JlKENQVVN0YXRl
ICpjcykKICAgICB9CiAgICAgZW52LT5wYyA9IHJlZzsKCisgICAgICAgLypSZXN0b3JlIHRoZSBn
dWVzdCdzIHByaXZpbGVnZWQgc3RhdGUgdG8gZml4IHRoZSBndWVzdCdzIHByaXZpbGVnZWQgc3Rh
dGUgZXJyb3IgYWZ0ZXIgbWlncmF0aW9uKi8KKyAgICAgICByZXQgPSBrdm1fZ2V0X29uZV9yZWco
Y3MsIFJJU0NWX0NPUkVfUkVHKGVudiwgbW9kZSksICZyZWcpOworICAgIGlmIChyZXQpIHsKKyAg
ICAgICAgcmV0dXJuIHJldDsKKyAgICB9CisgICAgaWYocmVnICE9IDMpCisgICAgICAgIGVudi0+
cHJpdiA9IHJlZzsKKwogICAgIGZvciAoaSA9IDE7IGkgPCAzMjsgaSsrKSB7CiAgICAgICAgIHVp
bnQ2NF90IGlkID0ga3ZtX3Jpc2N2X3JlZ19pZF91bG9uZyhlbnYsIEtWTV9SRUdfUklTQ1ZfQ09S
RSwgaSk7CiAgICAgICAgIHJldCA9IGt2bV9nZXRfb25lX3JlZyhjcywgaWQsICZyZWcpOwpAQCAt
NjAxLDYgKzYwOSwxNSBAQCBzdGF0aWMgaW50IGt2bV9yaXNjdl9wdXRfcmVnc19jb3JlKENQVVN0
YXRlICpjcykKICAgICAgICAgcmV0dXJuIHJldDsKICAgICB9CgorICAgICAgIC8qU2F2ZSB0aGUg
Z3Vlc3QncyBwcml2aWxlZ2VkIHN0YXRlIHRvIGZpeCB0aGUgcHJvYmxlbSBvZiB0aGUgZ3Vlc3Qn
cyBwcml2aWxlZ2VkIHN0YXRlIGVycm9yIGFmdGVyIG1pZ3JhdGlvbiovCisgICAgICAgcmVnID0g
ZW52LT5wcml2OworICAgICAgIGlmKHJlZyAhPSAzKSB7CisgICAgICAgcmV0ID0ga3ZtX3NldF9v
bmVfcmVnKGNzLCBSSVNDVl9DT1JFX1JFRyhlbnYsIG1vZGUpLCAmcmVnKTsKKyAgICAgICBpZiAo
cmV0KSB7CisgICAgICAgICAgIHJldHVybiByZXQ7CisgICAgICAgIH0KKyAgICB9CisKICAgICBm
b3IgKGkgPSAxOyBpIDwgMzI7IGkrKykgewogICAgICAgICB1aW50NjRfdCBpZCA9IGt2bV9yaXNj
dl9yZWdfaWRfdWxvbmcoZW52LCBLVk1fUkVHX1JJU0NWX0NPUkUsIGkpOwogICAgICAgICByZWcg
PSBlbnYtPmdwcltpXTsKQEAgLTEyODksNiArMTMwNiwxMiBAQCBpbnQga3ZtX2FyY2hfcHV0X3Jl
Z2lzdGVycyhDUFVTdGF0ZSAqY3MsIGludCBsZXZlbCwgRXJyb3IgKiplcnJwKQogICAgICAgICBy
ZXR1cm4gcmV0OwogICAgIH0KCisgICAgICAgLypTZXQgb3RoZXIgY29yZXMgZXhjZXB0IGd1ZXN0
IGNvcmUgMCB0byBydW5uaW5nIHN0YXRlLCBmaXggdGhlIHByb2JsZW0gdGhhdCBvdGhlciBjb3Jl
cyBleGNlcHQgY29yZSAwIGNhbm5vdCBydW4gbm9ybWFsbHkgYWZ0ZXIgZ3Vlc3QgbXVsdGktY29y
ZSBtaWdyYXRpb24qLworICAgICAgIGlmKChsZXZlbCA9PSBLVk1fUFVUX0ZVTExfU1RBVEUpICYm
IChjcy0+Y3B1X2luZGV4ICE9IDApKXsKKyAgICAgICBSSVNDVkNQVSAqY3B1ID0gUklTQ1ZfQ1BV
KGNzKTsKKyAgICAgICByZXQgPSBrdm1fcmlzY3Zfc3luY19tcHN0YXRlX3RvX2t2bShjcHUsIEtW
TV9NUF9TVEFURV9SVU5OQUJMRSk7CisgICAgICAgfQorCiAgICAgaWYgKEtWTV9QVVRfUkVTRVRf
U1RBVEUgPT0gbGV2ZWwpIHsKICAgICAgICAgUklTQ1ZDUFUgKmNwdSA9IFJJU0NWX0NQVShjcyk7
CiAgICAgICAgIGlmIChjcy0+Y3B1X2luZGV4ID09IDApIHsKLS0KMi4zNC4xCg0KDQpfX19fX19f
X19fX19fX19fX19fX19fd3d3LnVsdHJhcmlzYy5jb20NCumHjeimgeaPkOekuu+8muacrOmCruS7
tuWMheaLrOmZhOS7tueahOWGheWuueaYr+WPl+azleW+i+S/neaKpOeahOS/neWvhuS/oeaBr++8
jOWmguaenOaCqOS4jeaYr+aMh+WumuaUtuS7tuS6uu+8jOivt+eri+WNs+WwhuacrOmCruS7tuWI
oOmZpO+8jOazleW+i+emgeatouS7u+S9lemdnuazleeahOaKq+mcsuOAgeWkjeWItuOAgeS8oOaS
reaIluS7peS7u+S9leaWueW8j+S9v+eUqOacrOmCruS7tuOAguacrOmCruS7tuS4reWMheWQq+ea
hOaEj+ingeOAgeW7uuiuruaYr+WfuuS6juaIluWPl+WIsOaIkeaWueihqOi+vuWSjOWumuS5ieea
hOadoeasvuWPiuadoeS7tueahOmZkOWumu+8jOWmguaXoOaIkeaWueeahOato+W8j+S5pumdoua+
hOa4heaIluaOiOadg++8jOS4jeWPr+iiq+WNleeLrOS9nOS4uuS7u+S9leaDheW9ouS4i+eahOiv
geaNruaIluS+neaNruOAguaEn+iwouaCqOeahOeQhuino+S4jumFjeWQiOOAgueJiOadg+aJgOac
ieOAgklNUE9SVEFOVCBOT1RJQ0U6IFRoaXMgZW1haWwsIGluY2x1ZGluZyBpdHMgYXR0YWNobWVu
dCBpZiBhbnksIGlzIGNvbmZpZGVudGlhbC4gSWYgeW91IGFyZSBub3QgdGhlIGludGVuZGVkIHJl
Y2lwaWVudCwgcGxlYXNlIGRlbGV0ZSBpdCBmcm9tIHlvdXIgY29tcHV0ZXIgaW1tZWRpYXRlbHku
IEFueSBkaXNjbG9zdXJlLCBjb3B5aW5nLCBvciBkaXN0cmlidXRpb24gb2YgdGhpcyBtZXNzYWdl
LCBvciB0YWtpbmcgb2YgYW55IGFjdGlvbiBiYXNlZCBvbiBpdCBpcyBzdHJpY3RseSBwcm9oaWJp
dGVkLiAgQW55IG9waW5pb25zIGFuZCBzdWdnZXN0aW9ucyBjb250YWluZWQgaW4gdGhpcyBlbWFp
bCBhcmUgc3ViamVjdCB0byB0aGUgdGVybXMgYW5kIGNvbmRpdGlvbnMgZXhwcmVzc2VkIGFuZCBk
ZWZpbmVkIGJ5IHVzIGFuZCBzaG91bGQgbm90IGJlIHJlbGllZCB1cG9uIHVuY29uZGl0aW9uYWxs
eSB1bmRlciBhbnkgY2lyY3Vtc3RhbmNlcyB1bmxlc3MgdGhleSBhcmUgY29uZmlybWVkIGluIG9m
ZmljaWFsIHdyaXR0ZW4gY2xhcmlmaWNhdGlvbiBvciBhdXRob3JpemF0aW9uIGZyb20gdXMuICBU
aGFuayB5b3UgZm9yIHlvdXIgdW5kZXJzdGFuZGluZyBhbmQgY29vcGVyYXRpb24uQWxsIHJpZ2h0
cyByZXNlcnZlZC4=

