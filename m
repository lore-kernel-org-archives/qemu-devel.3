Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16E3BD32D9E
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2024 12:17:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tApp7-0002Ij-Tn; Tue, 12 Nov 2024 07:16:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=039b511fc=graf@amazon.de>)
 id 1tApp6-0002IT-VS; Tue, 12 Nov 2024 07:16:44 -0500
Received: from smtp-fw-33001.amazon.com ([207.171.190.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=039b511fc=graf@amazon.de>)
 id 1tApp5-0005YJ-2b; Tue, 12 Nov 2024 07:16:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
 t=1731413803; x=1762949803;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=U1/dGXiMiP/pElwvUsTa743OTolAWFM5iek0GDTM5tQ=;
 b=MinLogXgUhfFMWwcZZc4VG1pvXzrOlbl9NiE6n+8DOyMt8Tx+oQjQWYN
 VxKfo+Z0AehchS8NbGi/hPQ6yFajKWH4XdI/aFwAhl+t1LYuCfEf6fKZM
 iSOmveYviWNeJqhUhTpgCcwSUkb6U0oNLluovn50g0H8W2RYk+VjZKrv9 k=;
X-IronPort-AV: E=Sophos;i="6.12,147,1728950400"; d="scan'208";a="384524240"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO
 smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
 by smtp-border-fw-33001.sea14.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2024 12:16:41 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.38.20:20255]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.13.54:2525]
 with esmtp (Farcaster)
 id c2fa75b4-958c-463d-85c0-d01f6ad21f5c; Tue, 12 Nov 2024 12:16:41 +0000 (UTC)
X-Farcaster-Flow-ID: c2fa75b4-958c-463d-85c0-d01f6ad21f5c
Received: from EX19D020UWC004.ant.amazon.com (10.13.138.149) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Tue, 12 Nov 2024 12:16:40 +0000
Received: from [0.0.0.0] (10.253.83.51) by EX19D020UWC004.ant.amazon.com
 (10.13.138.149) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34; Tue, 12 Nov 2024
 12:16:38 +0000
Message-ID: <d9c983ca-bc47-4e80-960e-5e40c43df48d@amazon.com>
Date: Tue, 12 Nov 2024 13:16:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Stable-7.2.15 17/33] target/i386: Walk NPT in guest real mode
To: Michael Tokarev <mjt@tls.msk.ru>, <qemu-devel@nongnu.org>
CC: <qemu-stable@nongnu.org>, Eduard Vlad <evlad@amazon.de>, Richard Henderson
 <richard.henderson@linaro.org>
References: <qemu-stable-7.2.15-20241109093832@cover.tls.msk.ru>
 <20241109063903.3272404-17-mjt@tls.msk.ru>
Content-Language: en-US
From: Alexander Graf <graf@amazon.com>
In-Reply-To: <20241109063903.3272404-17-mjt@tls.msk.ru>
X-Originating-IP: [10.253.83.51]
X-ClientProxiedBy: EX19D041UWB004.ant.amazon.com (10.13.139.143) To
 EX19D020UWC004.ant.amazon.com (10.13.138.149)
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=207.171.190.10;
 envelope-from=prvs=039b511fc=graf@amazon.de; helo=smtp-fw-33001.amazon.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.122,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 HEADER_FROM_DIFFERENT_DOMAINS=0.001, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
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

SGV5IE1pY2hhZWwsCgpEb2VzIHRoaXMgcXVldWUgYWxzbyBpbmNsdWRlIHRoZSBmaXggZm9yIHRo
ZSBmaXggKCJ0YXJnZXQvaTM4NjogRml4IApsZWdhY3kgcGFnZSB0YWJsZSB3YWxrIik/CgpodHRw
czovL2xvcmUua2VybmVsLm9yZy9xZW11LWRldmVsLzIwMjQxMTA2MTU0MzI5LjY3MjE4LTEtZ3Jh
ZkBhbWF6b24uY29tLwoKCkFsZXgKCk9uIDA5LjExLjI0IDA3OjM4LCBNaWNoYWVsIFRva2FyZXYg
d3JvdGU6Cj4gRnJvbTogQWxleGFuZGVyIEdyYWYgPGdyYWZAYW1hem9uLmNvbT4KPgo+IFdoZW4g
dHJhbnNsYXRpbmcgdmlydHVhbCB0byBwaHlzaWNhbCBhZGRyZXNzIHdpdGggYSBndWVzdCBDUFUg
dGhhdAo+IHN1cHBvcnRzIG5lc3RlZCBwYWdpbmcgKE5QVCksIHdlIG5lZWQgdG8gcGVyZm9ybSBl
dmVyeSBwYWdlIHRhYmxlIHdhbGsKPiBhY2Nlc3MgaW5kaXJlY3RseSB0aHJvdWdoIHRoZSBOUFQs
IHdoaWNoIHdlIGNvcnJlY3RseSBkby4KPgo+IEhvd2V2ZXIsIHdlIHRyZWF0IHJlYWwgbW9kZSAo
bm8gcGFnZSB0YWJsZSB3YWxrKSBzcGVjaWFsOiBJbiB0aGF0IGNhc2UsCj4gd2UgY3VycmVudGx5
IGp1c3Qgc2tpcCBhbnkgd2Fsa3MgYW5kIHRyYW5zbGF0ZSBWQSAtPiBQQS4gV2l0aCBOUFQKPiBl
bmFibGVkLCB3ZSBhbHNvIG5lZWQgdG8gdGhlbiBwZXJmb3JtIE5QVCB3YWxrIHRvIGRvIEdWQSAt
PiBHUEEgLT4gSFBBCj4gd2hpY2ggd2UgZmFpbCB0byBkbyBzbyBmYXIuCj4KPiBUaGUgbmV0IHJl
c3VsdCBvZiB0aGF0IGlzIHRoYXQgVENHIFZNcyB3aXRoIE5QVCBlbmFibGVkIHRoYXQgZXhlY3V0
ZQo+IHJlYWwgbW9kZSBjb2RlIChsaWtlIFNlYUJJT1MpIGVuZCB1cCB3aXRoIEdQQT09SFBBIG1h
cHBpbmdzIHdoaWNoIG1lYW5zCj4gdGhlIGd1ZXN0IGFjY2Vzc2VzIGhvc3QgY29kZSBhbmQgZGF0
YS4gVGhpcyB0eXBpY2FsbHkgc2hvd3MgYXMgZmFpbHVyZQo+IHRvIGJvb3QgZ3Vlc3RzLgo+Cj4g
VGhpcyBwYXRjaCBjaGFuZ2VzIHRoZSBwYWdlIHdhbGsgbG9naWMgZm9yIE5QVCBlbmFibGVkIGd1
ZXN0cyBzbyB0aGF0IHdlCj4gYWx3YXlzIHBlcmZvcm0gYSBHVkEgLT4gR1BBIHRyYW5zbGF0aW9u
IGFuZCB0aGVuIHNraXAgYW55IGxvZ2ljIHRoYXQKPiByZXF1aXJlcyBhbiBhY3R1YWwgUFRFLgo+
Cj4gVGhhdCB3YXksIGFsbCByZW1haW5pbmcgbG9naWMgdG8gd2FsayB0aGUgTlBUIHN0YXlzIGFu
ZCB3ZSBzdWNjZXNzZnVsbHkKPiB3YWxrIHRoZSBOUFQgaW4gcmVhbCBtb2RlLgo+Cj4gQ2M6IHFl
bXUtc3RhYmxlQG5vbmdudS5vcmcKPiBGaXhlczogZmU0NDEwNTRiYjNmMCAoInRhcmdldC1pMzg2
OiBBZGQgTlBUIHN1cHBvcnQiKQo+IFNpZ25lZC1vZmYtYnk6IEFsZXhhbmRlciBHcmFmIDxncmFm
QGFtYXpvbi5jb20+Cj4gUmVwb3J0ZWQtYnk6IEVkdWFyZCBWbGFkIDxldmxhZEBhbWF6b24uZGU+
Cj4gUmV2aWV3ZWQtYnk6IFJpY2hhcmQgSGVuZGVyc29uIDxyaWNoYXJkLmhlbmRlcnNvbkBsaW5h
cm8ub3JnPgo+IE1lc3NhZ2UtSUQ6IDwyMDI0MDkyMTA4NTcxMi4yODkwMi0xLWdyYWZAYW1hem9u
LmNvbT4KPiBTaWduZWQtb2ZmLWJ5OiBSaWNoYXJkIEhlbmRlcnNvbiA8cmljaGFyZC5oZW5kZXJz
b25AbGluYXJvLm9yZz4KPiAoY2hlcnJ5IHBpY2tlZCBmcm9tIGNvbW1pdCBiNTY2MTdiYmNiNDcz
YzI1ODE1ZDFiZjQ3NWUzMjZmODQ1NjNiMWRlKQo+IFNpZ25lZC1vZmYtYnk6IE1pY2hhZWwgVG9r
YXJldiA8bWp0QHRscy5tc2sucnU+Cj4KPiBkaWZmIC0tZ2l0IGEvdGFyZ2V0L2kzODYvdGNnL3N5
c2VtdS9leGNwX2hlbHBlci5jIGIvdGFyZ2V0L2kzODYvdGNnL3N5c2VtdS9leGNwX2hlbHBlci5j
Cj4gaW5kZXggZWI3OGZjYmExMS4uYTUyYTViNDE3ZSAxMDA2NDQKPiAtLS0gYS90YXJnZXQvaTM4
Ni90Y2cvc3lzZW11L2V4Y3BfaGVscGVyLmMKPiArKysgYi90YXJnZXQvaTM4Ni90Y2cvc3lzZW11
L2V4Y3BfaGVscGVyLmMKPiBAQCAtMTQ3LDYgKzE0Nyw3IEBAIHN0YXRpYyBib29sIG1tdV90cmFu
c2xhdGUoQ1BVWDg2U3RhdGUgKmVudiwgY29uc3QgVHJhbnNsYXRlUGFyYW1zICppbiwKPiAgICAg
ICB1aW50MzJfdCBwa3I7Cj4gICAgICAgaW50IHBhZ2Vfc2l6ZTsKPiAgICAgICBpbnQgZXJyb3Jf
Y29kZTsKPiArICAgIGludCBwcm90Owo+Cj4gICAgcmVzdGFydF9hbGw6Cj4gICAgICAgcnN2ZF9t
YXNrID0gfk1BS0VfNjRCSVRfTUFTSygwLCBlbnZfYXJjaGNwdShlbnYpLT5waHlzX2JpdHMpOwo+
IEBAIC0yOTUsNyArMjk2LDcgQEAgc3RhdGljIGJvb2wgbW11X3RyYW5zbGF0ZShDUFVYODZTdGF0
ZSAqZW52LCBjb25zdCBUcmFuc2xhdGVQYXJhbXMgKmluLAo+ICAgICAgICAgICAvKiBjb21iaW5l
IHBkZSBhbmQgcHRlIG54LCB1c2VyIGFuZCBydyBwcm90ZWN0aW9ucyAqLwo+ICAgICAgICAgICBw
dGVwICY9IHB0ZSBeIFBHX05YX01BU0s7Cj4gICAgICAgICAgIHBhZ2Vfc2l6ZSA9IDQwOTY7Cj4g
LSAgICB9IGVsc2Ugewo+ICsgICAgfSBlbHNlIGlmIChwZ19tb2RlKSB7Cj4gICAgICAgICAgIC8q
Cj4gICAgICAgICAgICAqIFBhZ2UgdGFibGUgbGV2ZWwgMgo+ICAgICAgICAgICAgKi8KPiBAQCAt
MzQwLDYgKzM0MSwxNSBAQCBzdGF0aWMgYm9vbCBtbXVfdHJhbnNsYXRlKENQVVg4NlN0YXRlICpl
bnYsIGNvbnN0IFRyYW5zbGF0ZVBhcmFtcyAqaW4sCj4gICAgICAgICAgIHB0ZXAgJj0gcHRlIHwg
UEdfTlhfTUFTSzsKPiAgICAgICAgICAgcGFnZV9zaXplID0gNDA5NjsKPiAgICAgICAgICAgcnN2
ZF9tYXNrID0gMDsKPiArICAgIH0gZWxzZSB7Cj4gKyAgICAgICAgLyoKPiArICAgICAgICAgKiBO
byBwYWdpbmcgKHJlYWwgbW9kZSksIGxldCdzIHRlbnRhdGl2ZWx5IHJlc29sdmUgdGhlIGFkZHJl
c3MgYXMgMToxCj4gKyAgICAgICAgICogaGVyZSwgYnV0IGNvbmRpdGlvbmFsbHkgc3RpbGwgcGVy
Zm9ybSBhbiBOUFQgd2FsayBvbiBpdCBsYXRlci4KPiArICAgICAgICAgKi8KPiArICAgICAgICBw
YWdlX3NpemUgPSAweDQwMDAwMDAwOwo+ICsgICAgICAgIHBhZGRyID0gaW4tPmFkZHI7Cj4gKyAg
ICAgICAgcHJvdCA9IFBBR0VfUkVBRCB8IFBBR0VfV1JJVEUgfCBQQUdFX0VYRUM7Cj4gKyAgICAg
ICAgZ290byBzdGFnZTI7Cj4gICAgICAgfQo+Cj4gICBkb19jaGVja19wcm90ZWN0Ogo+IEBAIC0z
NTUsNyArMzY1LDcgQEAgZG9fY2hlY2tfcHJvdGVjdF9wc2UzNjoKPiAgICAgICAgICAgZ290byBk
b19mYXVsdF9wcm90ZWN0Owo+ICAgICAgIH0KPgo+IC0gICAgaW50IHByb3QgPSAwOwo+ICsgICAg
cHJvdCA9IDA7Cj4gICAgICAgaWYgKCFpc19tbXVfaW5kZXhfc21hcChpbi0+bW11X2lkeCkgfHwg
IShwdGVwICYgUEdfVVNFUl9NQVNLKSkgewo+ICAgICAgICAgICBwcm90IHw9IFBBR0VfUkVBRDsK
PiAgICAgICAgICAgaWYgKChwdGVwICYgUEdfUldfTUFTSykgfHwgIShpc191c2VyIHx8IChwZ19t
b2RlICYgUEdfTU9ERV9XUCkpKSB7Cj4gQEAgLTQxNyw2ICs0MjcsNyBAQCBkb19jaGVja19wcm90
ZWN0X3BzZTM2Ogo+Cj4gICAgICAgLyogbWVyZ2Ugb2Zmc2V0IHdpdGhpbiBwYWdlICovCj4gICAg
ICAgcGFkZHIgPSAocHRlICYgUEdfQUREUkVTU19NQVNLICYgfihwYWdlX3NpemUgLSAxKSkgfCAo
YWRkciAmIChwYWdlX3NpemUgLSAxKSk7Cj4gKyBzdGFnZTI6Cj4KPiAgICAgICAvKgo+ICAgICAg
ICAqIE5vdGUgdGhhdCBOUFQgaXMgd2Fsa2VkIChmb3IgYm90aCBwYWdpbmcgc3RydWN0dXJlcyBh
bmQgZmluYWwgZ3Vlc3QKPiBAQCAtNTU4LDcgKzU2OSw3IEBAIHN0YXRpYyBib29sIGdldF9waHlz
aWNhbF9hZGRyZXNzKENQVVg4NlN0YXRlICplbnYsIHZhZGRyIGFkZHIsCj4gICAgICAgICAgICAg
ICBhZGRyID0gKHVpbnQzMl90KWFkZHI7Cj4gICAgICAgICAgIH0KPgo+IC0gICAgICAgIGlmIChs
aWtlbHkoZW52LT5jclswXSAmIENSMF9QR19NQVNLKSkgewo+ICsgICAgICAgIGlmIChsaWtlbHko
ZW52LT5jclswXSAmIENSMF9QR19NQVNLIHx8IHVzZV9zdGFnZTIpKSB7Cj4gICAgICAgICAgICAg
ICBpbi5jcjMgPSBlbnYtPmNyWzNdOwo+ICAgICAgICAgICAgICAgaW4ubW11X2lkeCA9IG1tdV9p
ZHg7Cj4gICAgICAgICAgICAgICBpbi5wdHdfaWR4ID0gdXNlX3N0YWdlMiA/IE1NVV9ORVNURURf
SURYIDogTU1VX1BIWVNfSURYOwo+IC0tCj4gMi4zOS41Cj4KCgoKQW1hem9uIFdlYiBTZXJ2aWNl
cyBEZXZlbG9wbWVudCBDZW50ZXIgR2VybWFueSBHbWJICktyYXVzZW5zdHIuIDM4CjEwMTE3IEJl
cmxpbgpHZXNjaGFlZnRzZnVlaHJ1bmc6IENocmlzdGlhbiBTY2hsYWVnZXIsIEpvbmF0aGFuIFdl
aXNzCkVpbmdldHJhZ2VuIGFtIEFtdHNnZXJpY2h0IENoYXJsb3R0ZW5idXJnIHVudGVyIEhSQiAy
NTc3NjQgQgpTaXR6OiBCZXJsaW4KVXN0LUlEOiBERSAzNjUgNTM4IDU5Nwo=


