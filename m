Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01C54C282D0
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Mar 2025 01:41:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpdlC-0005va-KK; Tue, 04 Mar 2025 20:41:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tpdl8-0005tk-HV
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 20:41:19 -0500
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tpdl6-0003Sn-Bo
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 20:41:18 -0500
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-22337bc9ac3so119319995ad.1
 for <qemu-devel@nongnu.org>; Tue, 04 Mar 2025 17:41:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741138873; x=1741743673; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=gacAInIvyxqLnynBEdwp2sZDwlbnqZNmAz09oLbfc2o=;
 b=NRtbEsVttO6PQE4ZrjdUeo1y1cF6s63rOWY4b7t95kB53DA7Rb0rW6HvydoEc9Pd0M
 w4koGf4h1w4H9oX65TnG+uZsmNaj0g8108Ry8GH8FASLyGn9gXp/tUdBE56/s+vILP3p
 e8TAPHdkpTPIY6XEX6EQWIw6QAhjn/D7m6aHNswKYJ+ZhxCKYo7or8VHqVhU4CZXF1Ix
 fXjOOOP9oHDGLa51C7aHy1TCtmD4jS/a9r0hMVkco7PHiL8TiFagB97VETR3eeYlUZvM
 8LF86kiAN/7xeokjJbbtSoryL77zkjVJucrB4OZX8rRBPQa+FD9zp1fwbW21JP1zdx4H
 ThMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741138873; x=1741743673;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=gacAInIvyxqLnynBEdwp2sZDwlbnqZNmAz09oLbfc2o=;
 b=py0JtJ0XerowkeDsjUYPHVH23ivbGxD7fqRCgbvXeVcN9XmsFwSFdVBe6SJPN6rjs4
 ZYaUH4l/6djcYGE6GYqZUklxZdbaHGQV5x6N5ZhdI714UEVOmfjk7pFI+PG6anGNkpb3
 JchHw/TDUkxuveIMGuP4Hpk9npb8vsfiES3bNt1Qkp7iUY5M4oXD1gbkulfJX/J71A1q
 Q1UScnbQTOTeGz0dYyUYPYKeAImqquVicyk4xNsdblCbv8e6wpWHTtDK7HcO6kym19hR
 KyvCHIgMGyyrmWqaUL9pRdcd2RwzgdBPL4TkJQ2KMwyQAPHSbK0XTJzFW7NJQrzaCV6L
 2CnA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWTn48kktTKcjbabQ6VL1AACxL9jfyneuszuvW57UBFMLuMz2GOCZ3Dh9Aw9fYf7mRrsc/pSRR44Ptd@nongnu.org
X-Gm-Message-State: AOJu0YyAdqhwe57Vv3x++qzuCn5N2CcHQPNIoQxICqRdXVSD67F4VqBD
 6p6VZtlZ2ffs9SAFhtTHJGcQr01LIv0cpLshDv8syvMqfSsaNPEMDvEFg3i5ORw=
X-Gm-Gg: ASbGncucTI+myZQpwEjT70+DDMptFpNd1iC4VEjiBkU7vfVglHWAofH39fEj5V2ZXNS
 2Jq4/lIV5lnwswT75FCKLTQqiItmRLhp+2WE/hCZ0VqaQbHcE1HvpTYZ5tdFRBPyS47kMEyK7kQ
 /KhCcYyEsPn6lP51km+qN9bNziLRjTgsNIk6XGoQkkhst89+0IILoBQhhRVeCqCOgoCMJ8yFEcY
 4befspbdsRuxtKbc1BQTRgVlHWhYCLxyDVxme9G4ymcUGVjrYj2QMw5bnnEzoDyELDOSKkyof4f
 EgYQLZ5OHaipQBQbmlXOTKtnrnpVROpcoPCgnNXZxBanTtijrhq5bHupDw==
X-Google-Smtp-Source: AGHT+IFJrx8g3rqzpcRtDr8epmFtwCT2Ch0Uw6Q3TG3WTZC4RQDLnzqrQjNxoVYOq6m0/zFADZg6ZA==
X-Received: by 2002:a05:6a00:170c:b0:736:3184:7fe8 with SMTP id
 d2e1a72fcca58-73682b54a53mr1748159b3a.2.1741138872727; 
 Tue, 04 Mar 2025 17:41:12 -0800 (PST)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73634b5838bsm7818191b3a.175.2025.03.04.17.41.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Mar 2025 17:41:12 -0800 (PST)
Message-ID: <a354c104-5172-42ca-9470-ba4150baf04d@linaro.org>
Date: Tue, 4 Mar 2025 17:41:11 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 01/11] system: Extract target-specific globals to
 their own compilation unit
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>
References: <20250305005225.95051-1-philmd@linaro.org>
 <20250305005225.95051-2-philmd@linaro.org>
 <539de40b-de27-4781-bcb0-46986fc2f28f@linaro.org>
 <a11bfca2-5ffc-49b4-94fa-e5d466bc56bf@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <a11bfca2-5ffc-49b4-94fa-e5d466bc56bf@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x633.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

T24gMy80LzI1IDE3OjMzLCBQaGlsaXBwZSBNYXRoaWV1LURhdWTDqSB3cm90ZToNCj4gT24g
NS8zLzI1IDAyOjIwLCBQaWVycmljayBCb3V2aWVyIHdyb3RlOg0KPj4gT24gMy80LzI1IDE2
OjUyLCBQaGlsaXBwZSBNYXRoaWV1LURhdWTDqSB3cm90ZToNCj4+PiBXZSBzaG91bGRuJ3Qg
dXNlIHRhcmdldCBzcGVjaWZpYyBnbG9iYWxzIGZvciBtYWNoaW5lIHByb3BlcnRpZXMuDQo+
Pj4gVGhlc2Ugb25lcyBjb3VsZCBiZSBkZXN1Z2FyaXplZCwgYXMgZXhwbGFpbmVkIGluIFsq
XS4gV2hpbGUNCj4+PiBjZXJ0YWlubHkgZG9hYmxlLCBub3QgdHJpdmlhbCBub3IgbXkgcHJp
b3JpdHkgZm9yIG5vdy4gSnVzdCBtb3ZlDQo+Pj4gdGhlbSB0byBhIGRpZmZlcmVudCBmaWxl
IHRvIGNsYXJpZnkgdGhleSBhcmUgKmdsb2JhbHMqLCBsaWtlIHRoZQ0KPj4+IGdlbmVyaWMg
Z2xvYmFscyByZXNpZGluZyBpbiBzeXN0ZW0vZ2xvYmFscy5jLg0KPj4+DQo+Pg0KPj4gTWF5
YmUgdGhvc2UgY291bGQgYmUgc2V0IGdsb2JhbGx5IHRvIHRoZSBkZWZhdWx0Og0KPj4gaW50
IGdyYXBoaWNfd2lkdGggPSA4MDA7DQo+PiBpbnQgZ3JhcGhpY19oZWlnaHQgPSA2MDA7DQo+
PiBpbnQgZ3JhcGhpY19kZXB0aCA9IDMyOw0KPj4NCj4+IEFuZCBvdmVycmlkZSB0aGVtIGZv
ciBzcGFyYyBhbmQgbTY4ayBpbiBxZW11X2luaXRfYXJjaF9tb2R1bGVzIGZ1bmN0aW9uLA0K
Pj4gdXNpbmcgcWVtdV9hcmNoX25hbWUoKS4NCj4+IFRoaXMgd2F5LCBubyBuZWVkIHRvIGhh
dmUgYSBuZXcgZmlsZSB0byBob2xkIHRoZW0uDQo+IA0KPiBUaGlzIGlzIG5vdCB3aGF0IFBh
b2xvIGV4cGxhaW5lZCAuLi4NCj4gDQo+Pg0KPj4+IFsqXSBodHRwczovL2xvcmUua2VybmVs
Lm9yZy9xZW11LWRldmVsL2U1MTRkNmRiLTc4MWQtNGFmZS0NCj4+PiBiMDU3LTkwNDZjNzAw
NDRkY0ByZWRoYXQuY29tLw0KPiANCj4gLi4uIGhlcmUgXiwgYnV0IG1heWJlIEkgbWlzdW5k
ZXJzdG9vZCBoaW0uDQo+IA0KPiBEb2luZyB0aGUgJy1nJyBDTEkgY2hhbmdlIGlzIG5vdCBt
eSBwcmlvcml0eSwgYW5kIEkgd2VsY29tZQ0KPiBhbnkgZGV2ZWxvcGVyIHdpbGxpbmcgdG8g
aGVscCA6KSBIZXJlIEknbSBqdXN0IHRyeWluZyB0byBtYWtlDQo+IHNlbnNlIG9mIHRoYXQg
YXJjaF9pbml0LmMgZmlsZS4NCj4gDQoNCkl0J3Mgbm90IHdoYXQgSSBzdWdnZXN0ZWQsIGFu
ZCB0aGUgZmluYWwgc3RhdGUgKGdsb2JhbHMgYXJlIHNldCB3aXRoIGEgDQp2YWx1ZSksIHNo
b3VsZCBiZSB0aGUgc2FtZS4NCg0KSXQncyBqdXN0DQpFdmVudHVhbGx5LCB0aGUNCmlmIChz
cGFyYykgew0KICAgIGdyYXBoaWNfKiA9IC4uLicNCn0gZWxzZSBpZiAobTg2aykgew0KICAg
IGdyYXBoaWNfKiA9IC4uLicNCn0NCg0KQ2FuIGJlIG1vdmVkIHNvbWV3aGVyZSBlbHNlIChz
b29uZXIpIGlmIG5lZWRlZC4NCkl0J3MganVzdCB0byBnZXQgcmlkIG9mIFRBUkdFVF9TUEFS
QyBhbmQgVEFSR0VUX002OEsgb24gdGhlIHdheSwgbm90IHRvIA0KY2hhbmdlIGFueXRoaW5n
IGVsc2UuDQoNCj4+PiBTaWduZWQtb2ZmLWJ5OiBQaGlsaXBwZSBNYXRoaWV1LURhdWTDqSA8
cGhpbG1kQGxpbmFyby5vcmc+DQo+Pj4gLS0tDQo+Pj4gIMKgIHN5c3RlbS9hcmNoX2luaXQu
Y8KgwqDCoMKgwqAgfCAxNCAtLS0tLS0tLS0tLS0tLQ0KPj4+ICDCoCBzeXN0ZW0vZ2xvYmFs
cy10YXJnZXQuYyB8IDI0ICsrKysrKysrKysrKysrKysrKysrKysrKw0KPj4+ICDCoCBzeXN0
ZW0vbWVzb24uYnVpbGTCoMKgwqDCoMKgIHzCoCAxICsNCj4+PiAgwqAgMyBmaWxlcyBjaGFu
Z2VkLCAyNSBpbnNlcnRpb25zKCspLCAxNCBkZWxldGlvbnMoLSkNCj4+PiAgwqAgY3JlYXRl
IG1vZGUgMTAwNjQ0IHN5c3RlbS9nbG9iYWxzLXRhcmdldC5jDQo+Pj4NCj4+PiBkaWZmIC0t
Z2l0IGEvc3lzdGVtL2FyY2hfaW5pdC5jIGIvc3lzdGVtL2FyY2hfaW5pdC5jDQo+Pj4gaW5k
ZXggZDJjMzJmODQ4ODcuLmVhMDg0MmI3NDEwIDEwMDY0NA0KPj4+IC0tLSBhL3N5c3RlbS9h
cmNoX2luaXQuYw0KPj4+ICsrKyBiL3N5c3RlbS9hcmNoX2luaXQuYw0KPj4+IEBAIC0yNSwy
MCArMjUsNiBAQA0KPj4+ICDCoCAjaW5jbHVkZSAicWVtdS9tb2R1bGUuaCINCj4+PiAgwqAg
I2luY2x1ZGUgInN5c3RlbS9hcmNoX2luaXQuaCINCj4+PiAtI2lmZGVmIFRBUkdFVF9TUEFS
Qw0KPj4+IC1pbnQgZ3JhcGhpY193aWR0aCA9IDEwMjQ7DQo+Pj4gLWludCBncmFwaGljX2hl
aWdodCA9IDc2ODsNCj4+PiAtaW50IGdyYXBoaWNfZGVwdGggPSA4Ow0KPj4+IC0jZWxpZiBk
ZWZpbmVkKFRBUkdFVF9NNjhLKQ0KPj4+IC1pbnQgZ3JhcGhpY193aWR0aCA9IDgwMDsNCj4+
PiAtaW50IGdyYXBoaWNfaGVpZ2h0ID0gNjAwOw0KPj4+IC1pbnQgZ3JhcGhpY19kZXB0aCA9
IDg7DQo+Pj4gLSNlbHNlDQo+Pj4gLWludCBncmFwaGljX3dpZHRoID0gODAwOw0KPj4+IC1p
bnQgZ3JhcGhpY19oZWlnaHQgPSA2MDA7DQo+Pj4gLWludCBncmFwaGljX2RlcHRoID0gMzI7
DQo+Pj4gLSNlbmRpZg0KPj4+IC0NCj4+PiAgwqAgY29uc3QgdWludDMyX3QgYXJjaF90eXBl
ID0gUUVNVV9BUkNIOw0KPj4+ICDCoCB2b2lkIHFlbXVfaW5pdF9hcmNoX21vZHVsZXModm9p
ZCkNCj4+PiBkaWZmIC0tZ2l0IGEvc3lzdGVtL2dsb2JhbHMtdGFyZ2V0LmMgYi9zeXN0ZW0v
Z2xvYmFscy10YXJnZXQuYw0KPj4+IG5ldyBmaWxlIG1vZGUgMTAwNjQ0DQo+Pj4gaW5kZXgg
MDAwMDAwMDAwMDAuLjk4OTcyMDU5MWU3DQo+Pj4gLS0tIC9kZXYvbnVsbA0KPj4+ICsrKyBi
L3N5c3RlbS9nbG9iYWxzLXRhcmdldC5jDQo+Pj4gQEAgLTAsMCArMSwyNCBAQA0KPj4+ICsv
Kg0KPj4+ICsgKiBHbG9iYWwgdmFyaWFibGVzIHRoYXQgc2hvdWxkIG5vdCBleGlzdCAodGFy
Z2V0IHNwZWNpZmljKQ0KPj4+ICsgKg0KPj4+ICsgKiBDb3B5cmlnaHQgKGMpIDIwMDMtMjAw
OCBGYWJyaWNlIEJlbGxhcmQNCj4+PiArICoNCj4+PiArICogU1BEWC1MaWNlbnNlLUlkZW50
aWZpZXI6IE1JVA0KPj4+ICsgKi8NCj4+PiArDQo+Pj4gKyNpbmNsdWRlICJxZW11L29zZGVw
LmgiDQo+Pj4gKyNpbmNsdWRlICJzeXN0ZW0vc3lzdGVtLmgiDQo+Pj4gKw0KPj4+ICsjaWZk
ZWYgVEFSR0VUX1NQQVJDDQo+Pj4gK2ludCBncmFwaGljX3dpZHRoID0gMTAyNDsNCj4+PiAr
aW50IGdyYXBoaWNfaGVpZ2h0ID0gNzY4Ow0KPj4+ICtpbnQgZ3JhcGhpY19kZXB0aCA9IDg7
DQo+Pj4gKyNlbGlmIGRlZmluZWQoVEFSR0VUX002OEspDQo+Pj4gK2ludCBncmFwaGljX3dp
ZHRoID0gODAwOw0KPj4+ICtpbnQgZ3JhcGhpY19oZWlnaHQgPSA2MDA7DQo+Pj4gK2ludCBn
cmFwaGljX2RlcHRoID0gODsNCj4+PiArI2Vsc2UNCj4+PiAraW50IGdyYXBoaWNfd2lkdGgg
PSA4MDA7DQo+Pj4gK2ludCBncmFwaGljX2hlaWdodCA9IDYwMDsNCj4+PiAraW50IGdyYXBo
aWNfZGVwdGggPSAzMjsNCj4+PiArI2VuZGlmDQo+Pj4gZGlmZiAtLWdpdCBhL3N5c3RlbS9t
ZXNvbi5idWlsZCBiL3N5c3RlbS9tZXNvbi5idWlsZA0KPj4+IGluZGV4IDQ5NTJmNGIyYzdk
Li4xODExOTU0MTBmYiAxMDA2NDQNCj4+PiAtLS0gYS9zeXN0ZW0vbWVzb24uYnVpbGQNCj4+
PiArKysgYi9zeXN0ZW0vbWVzb24uYnVpbGQNCj4+PiBAQCAtMSw2ICsxLDcgQEANCj4+PiAg
wqAgc3BlY2lmaWNfc3MuYWRkKHdoZW46ICdDT05GSUdfU1lTVEVNX09OTFknLCBpZl90cnVl
OiBbZmlsZXMoDQo+Pj4gIMKgwqDCoCAnYXJjaF9pbml0LmMnLA0KPj4+ICDCoMKgwqAgJ2lv
cG9ydC5jJywNCj4+PiArwqAgJ2dsb2JhbHMtdGFyZ2V0LmMnLA0KPj4+ICDCoMKgwqAgJ21l
bW9yeS5jJywNCj4+PiAgwqDCoMKgICdwaHlzbWVtLmMnLA0KPj4+ICDCoMKgwqAgJ3dhdGNo
cG9pbnQuYycsDQo+Pg0KPiANCg0K

