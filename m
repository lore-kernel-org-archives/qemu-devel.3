Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17079F436BF
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2026 16:59:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDmXA-00011f-OL; Fri, 17 Apr 2026 12:59:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gabriel.hartmann@netways.de>)
 id 1wDdAk-0003JM-Ow
 for qemu-devel@nongnu.org; Fri, 17 Apr 2026 02:59:27 -0400
Received: from mail1.netways.de ([2a01:4a0:4:1002::146])
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gabriel.hartmann@netways.de>)
 id 1wDdAg-00044H-NB
 for qemu-devel@nongnu.org; Fri, 17 Apr 2026 02:59:25 -0400
Received: from exchange.int.netways.de (nethqex2.int.netways.de
 [IPv6:2a01:4a0:4:2102::112])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail1.netways.de (Postfix) with ESMTPS id 4fxm2V6js4z3sSs;
 Fri, 17 Apr 2026 08:59:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netways.de; s=20241115;
 t=1776409155;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8GMnt7XduqIPXyfLTInkhYMgqft64clwpRgfQtFO7ck=;
 b=n+kPw+NZrtUUVKrntRYG5bT07GoeDuavFvRfAHWi+NoRbrgQsY+wPiCpGmYVgEXNPZ18DD
 ud4PnEGR0IWPG70CqmRnIslOn51ckARcWkLNx7Jonao69x/z0x2lyAJJyWEjnF1H9HSRtp
 vPbnr5MaQYqeKv1d513FNH3b6bXJuIh9h70DM3+WM7cf8lslrx9uHtXmn56X95BU+wdpZg
 i/S2rpJYMDmWkL/7h8sCwC+yf+BxkLgZZoZGN49FHtyCjX0evwaxCnJ5SgEFRa5/94GkNP
 hHetG1qI8Msnkpr3BFtsTMxRpsuh+p6aDnaOUz+yXDAgvpblq9xe99bTVAbQNg==
Received: from nethqex1.int.netways.de (2a01:4a0:4:2102::111) by
 nethqex2.int.netways.de (2a01:4a0:4:2102::112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 17 Apr 2026 08:59:13 +0200
Received: from nethqex1.int.netways.de ([fe80::250:56ff:fe84:9c82]) by
 nethqex1.int.netways.de ([fe80::250:56ff:fe84:9c82%8]) with mapi id
 15.02.2562.037; Fri, 17 Apr 2026 08:59:13 +0200
From: Gabriel Hartmann <gabriel.hartmann@netways.de>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "hector.cao@canonical.com" <hector.cao@canonical.com>
Subject: Re: [PATCH] module: fix early stop for module loading function
Thread-Topic: [PATCH] module: fix early stop for module loading function
Thread-Index: AQHczjezEpcEbRRJDk6bvN4S4MrIdg==
Date: Fri, 17 Apr 2026 06:59:13 +0000
Message-ID: <894A0EA3-66BF-4B53-B44C-EECA28D3595C@netways.de>
References: <20260416134842.1726474-1-hector.cao@canonical.com>
In-Reply-To: <20260416134842.1726474-1-hector.cao@canonical.com>
Accept-Language: en-DE, de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [2a02:ed80:2:0:f816:3eff:feb9:43e0]
Content-Type: text/plain; charset="utf-8"
Content-ID: <70B009573A729340A31252D7D6DDFAA0@netways.de>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Received-SPF: pass client-ip=2a01:4a0:4:1002::146;
 envelope-from=gabriel.hartmann@netways.de; helo=mail1.netways.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 17 Apr 2026 12:59:11 -0400
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

T24gV2VkLCBBcHIgMTYsIDIwMjYgYXQgMDE6NDg6NDJQTSArMDAwMCwgSGVjdG9yIENhbyB3cm90
ZToNCj4gVGhlIGNvbW1pdCBjNTUxZmIwYjUzZCBpbnRyb2R1Y2VzIGEgcmVncmVzc2lvbiBvbiB0
aGUgYmVoYXZpb3INCj4gb2YgdGhlIG1vZHVsZSBsb2FkIGxvZ2ljLiBIaXN0b3JpY2FsbHksIGlm
IFFFTVUgY2Fubm90IGxvYWQgYQ0KPiBwYXJ0aWN1bGFyIG1vZHVsZSBpbiBhIGZvbGRlciwgaXQg
a2VlcHMgZ29pbmcgYW5kIGxvb2sgZm9yIHRoZQ0KPiBtb2R1bGUgaW4gdGhlIHJlbWFpbmluZyBm
b2xkZXJzLiBUaGUgbWVudGlvbmVkIGNvbW1pdCBtYWtlIFFFTVUNCj4gc3RvcCBpZiB0aGUgbW9k
dWxlIGV4aXN0cyBidXQgY2Fubm90IGJlIGxvYWRlZCAoYnVpbGQgbWlzbWF0Y2gNCj4gcmVhc29u
IGZvciBleGFtcGxlKS4NCg0KVGhhbmtzIGZvciB0aGUgcGF0Y2gsIEhlY3Rvci4gSSdtIHRoZSBv
cmlnaW5hbCByZXBvcnRlciBvZiB0aGlzIGlzc3VlDQphbmQgaGF2ZSBiZWVuIGRlYnVnZ2luZyBp
dCBvbiBvdXIgT3BlblN0YWNrL0NlcGggcHJvZHVjdGlvbiBlbnZpcm9ubWVudC4NClRoZSBhbmFs
eXNpcyBhbmQgYm90aCBmaXhlcyBsb29rIGNvcnJlY3QgdG8gbWUuIE9uZSBjb21tZW50Og0KDQo+
ICsgICAgcnYgPSAwOyAvKiBtb2R1bGUgbm90IGZvdW5kICovDQo+ICsgICAgZm9yIChpID0gMDsg
KGkgPCBuX2RpcnMpICYmIChydiAhPSAxKTsgaSsrKSB7DQo+ICAgICAgICAgIGNoYXIgKmZuYW1l
ID0gZ19zdHJkdXBfcHJpbnRmKCIlcy8lcyVzIiwNCj4gICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgZGlyc1tpXSwgbW9kdWxlX25hbWUsDQo+ICBDT05GSUdfSE9TVF9EU09T
VUYpOw0KPiAgICAgICAgICBpbnQgcmV0ID0gYWNjZXNzKGZuYW1lLCBGX09LKTsNCj4gLSAgICAg
ICAgaWYgKHJldCAhPSAwICYmIChlcnJubyA9PSBFTk9FTlQgfHwgZXJybm8gPT0gRU5PVERJUikp
IHsNCj4gLSAgICAgICAgICAgIC8qDQo+IC0gICAgICAgICAgICAgKiBpZiB3ZSBkb24ndCBmaW5k
IHRoZSBtb2R1bGUgaW4gdGhpcyBkaXIsIHRyeSB0aGUgbmV4dCBvbmUuDQo+IC0gICAgICAgICAg
ICAgKiBJZiB3ZSBkb24ndCBmaW5kIGl0IGluIGFueSBkaXIsIHRoYXQgY2FuIGJlIGZpbmUgdG9v
OiB1c2VyDQo+IC0gICAgICAgICAgICAgKiBkaWQgbm90IGluc3RhbGwgdGhlIG1vZHVsZS4gV2Ug
d2lsbCByZXR1cm4gMCBpbiB0aGlzIGNhc2UNCj4gLSAgICAgICAgICAgICAqIHdpdGggbm8gZXJy
b3Igc2V0Lg0KPiAtICAgICAgICAgICAgICovDQo+IC0gICAgICAgICAgICBnX2ZyZWUoZm5hbWUp
Ow0KPiAtICAgICAgICAgICAgY29udGludWU7DQo+IC0gICAgICAgIH0gZWxzZSBpZiAocmV0ICE9
IDApIHsNCj4gKyAgICAgICAgaWYgKChyZXQgPT0gMCkgJiYgbW9kdWxlX2xvYWRfZHNvKGZuYW1l
LCBleHBvcnRfc3ltYm9scywgZXJycCkpIHsNCj4gKyAgICAgICAgICAgIHJ2ID0gMTsgLyogbW9k
dWxlIHN1Y2Nlc3NmdWxseSBsb2FkZWQgKi8NCj4gKyAgICAgICAgfQ0KPiArDQo+ICsgICAgICAg
IC8qIFRoZSBmaWxlIGV4aXN0cyBidXQgY2Fubm90IGJlIGFjY2Vzc2VkIC0+IHJlcG9ydCBhbiBl
cnJvciBhbmQNCj4gY29udGludWUgKi8NCj4gKyAgICAgICAgaWYgKChyZXQgIT0gMCkgJiYgKGVy
cm5vICE9IEVOT0VOVCkgJiYgKGVycm5vICE9IEVOT1RESVIpKSB7DQo+ICAgICAgICAgICAgICAv
KiBtb3N0IGNvbW1vbiBpcyBFQUNDRVMgaGVyZSAqLw0KPiAgICAgICAgICAgICAgZXJyb3Jfc2V0
Z19lcnJubyhlcnJwLCBlcnJubywgImVycm9yIHRyeWluZyB0byBhY2Nlc3MgJXMiLCBmbmFtZSk7
DQo+IC0gICAgICAgIH0gZWxzZSBpZiAobW9kdWxlX2xvYWRfZHNvKGZuYW1lLCBleHBvcnRfc3lt
Ym9scywgZXJycCkpIHsNCj4gLSAgICAgICAgICAgIHJ2ID0gMTsgLyogbW9kdWxlIHN1Y2Nlc3Nm
dWxseSBsb2FkZWQgKi8NCj4gICAgICAgICAgfQ0KDQpUaGUgbG9vcCBjYW4gdHJpZ2dlciBhc3Nl
cnQoKmVycnAgPT0gTlVMTCkgaW5zaWRlIGVycm9yX3NldHYoKSB3aGVuDQplcnJvcnMgb2NjdXIg
aW4gbXVsdGlwbGUgaXRlcmF0aW9ucy4NCg0KQ29uc2lkZXI6IGRpcmVjdG9yeSAxIGNvbnRhaW5z
IHRoZSBtb2R1bGUgYnV0IHdpdGggYSBidWlsZCBtaXNtYXRjaC4NCm1vZHVsZV9sb2FkX2Rzbygp
IHJldHVybnMgZmFsc2UgYW5kIHNldHMgKmVycnAuIFRoZSBsb29wIGNvbnRpbnVlcyB0bw0KZGly
ZWN0b3J5IDIsIHdoaWNoIGVpdGhlciBhbHNvIGhhcyBhIG1pc21hdGNoZWQgbW9kdWxlIChjYWxs
aW5nDQptb2R1bGVfbG9hZF9kc28oKSAtPiBlcnJvcl9zZXRnKCkgYWdhaW4pIG9yIGhhcyBhbiBh
Y2Nlc3MgZXJyb3INCihjYWxsaW5nIGVycm9yX3NldGdfZXJybm8oKSkuIEluIGJvdGggY2FzZXMs
ICplcnJwIGlzIGFscmVhZHkgc2V0LA0KYW5kIGVycm9yX3NldHYoKSB3aWxsIGhpdCBpdHMgYXNz
ZXJ0KCplcnJwID09IE5VTEwpLg0KDQpUaGUgZXJyb3IgbmVlZHMgdG8gYmUgZnJlZWQgYmV0d2Vl
biBpdGVyYXRpb25zLCBmb3IgZXhhbXBsZToNCg0KICAgIHJ2ID0gMDsNCiAgICBmb3IgKGkgPSAw
OyAoaSA8IG5fZGlycykgJiYgKHJ2ICE9IDEpOyBpKyspIHsNCiAgICAgICAgY2hhciAqZm5hbWUg
PSBnX3N0cmR1cF9wcmludGYoIiVzLyVzJXMiLA0KICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICBkaXJzW2ldLCBtb2R1bGVfbmFtZSwgQ09ORklHX0hPU1RfRFNPU1VGKTsNCiAg
ICAgICAgaW50IHJldCA9IGFjY2VzcyhmbmFtZSwgRl9PSyk7DQogICAgICAgIGlmICgocmV0ID09
IDApICYmIG1vZHVsZV9sb2FkX2RzbyhmbmFtZSwgZXhwb3J0X3N5bWJvbHMsIGVycnApKSB7DQog
ICAgICAgICAgICBydiA9IDE7DQogICAgICAgIH0NCg0KICAgICAgICBpZiAoKHJldCAhPSAwKSAm
JiAoZXJybm8gIT0gRU5PRU5UKSAmJiAoZXJybm8gIT0gRU5PVERJUikpIHsNCiAgICAgICAgICAg
IGVycm9yX3NldGdfZXJybm8oZXJycCwgZXJybm8sICJlcnJvciB0cnlpbmcgdG8gYWNjZXNzICVz
IiwgZm5hbWUpOw0KICAgICAgICB9DQoNCiAgICAgICAgLyogQ2xlYXIgZXJyb3IgZnJvbSB0aGlz
IGl0ZXJhdGlvbiBiZWZvcmUgdHJ5aW5nIG5leHQgZGlyZWN0b3J5ICovDQogICAgICAgIGlmICgo
cnYgIT0gMSkgJiYgKmVycnApIHsNCiAgICAgICAgICAgIGVycm9yX2ZyZWUoKmVycnApOw0KICAg
ICAgICAgICAgKmVycnAgPSBOVUxMOw0KICAgICAgICB9DQoNCiAgICAgICAgZ19mcmVlKGZuYW1l
KTsNCiAgICB9DQoNCiAgICAvKiBJZiB3ZSBleGhhdXN0ZWQgYWxsIGRpcnMgd2l0aG91dCBzdWNj
ZXNzLCBzZXQgYSBtZWFuaW5nZnVsIGVycm9yICovDQogICAgaWYgKHJ2ICE9IDEgJiYgISplcnJw
KSB7DQogICAgICAgIGVycm9yX3NldGcoZXJycCwgImNvdWxkIG5vdCBsb2FkIG1vZHVsZSAnJXMn
IiwgbW9kdWxlX25hbWUpOw0KICAgIH0NCg0KQWx0ZXJuYXRpdmVseSwgdXNpbmcgYSBsb2NhbCBF
cnJvciAqbG9jYWxfZXJyID0gTlVMTCBhbmQgb25seQ0KcHJvcGFnYXRpbmcgdGhlIGxhc3QgZXJy
b3IgYXQgdGhlIGVuZCB3b3VsZCBmb2xsb3cgdGhlIGNvbW1vbiBRRU1VDQpwYXR0ZXJuIG1vcmUg
Y2xvc2VseS4NCg0KLS3igIINCkdhYnJpZWwgSGFydG1hbm4NClNlbmlvciBTeXN0ZW1zIEVuZ2lu
ZWVyDQoNCk5FVFdBWVMgTWFuYWdlZCBTZXJ2aWNlcyBHbWJIIHwgRGV1dHNjaGhlcnJuc3RyLiAx
NS0xOSB8IEQtOTA0MjkgTnVlcm5iZXJnDQpUZWw6ICs0OSA5MTEgOTI4ODUtMCB8IEZheDogKzQ5
IDkxMSA5Mjg4NS03Nw0KQ0VPOiBKdWxpYW4gSGVpbiwgQmVybmQgRXJrLCBTZWJhc3RpYW4gU2Fl
bWFubiB8IEFHIE51ZXJuYmVyZyBIUkIyNTIwNw0KaHR0cHM6Ly93d3cubmV0d2F5cy5kZSB8IGdh
YnJpZWwuaGFydG1hbm5AbmV0d2F5cy5kZQ0KDQoqKiBzdGFja2NvbmYgMjAyNiAtIEFwcmlsIHwg
TXVuaWNoIC0gaHR0cHM6Ly9zdGFja2NvbmYuZXUgKioNCioqIE9wZW4gU291cmNlIE1vbml0b3Jp
bmcgQ29uZmVyZW5jZSAyMDI2IC0gTm92ZW1iZXIgfCBOdXJlbWJlcmcgLSBodHRwczovL29zbWMu
ZGUgKioNCioqIE5FVFdBWVMgV2ViIFNlcnZpY2VzIC0gaHR0cHM6Ly9ud3MubmV0d2F5cy5kZSAq
Kg0KKiogTkVUV0FZUyBUcmFpbmluZ3MgLSBodHRwczovL25ldHdheXMuZGUvdHJhaW5pbmdzICoq
DQo=

