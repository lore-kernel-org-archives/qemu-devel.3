Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBB79C36002
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Mar 2025 19:31:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1twnVq-0008Vp-TB; Mon, 24 Mar 2025 15:31:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1twnVe-0008M8-PH
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 15:30:57 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1twnVc-0005sN-UG
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 15:30:54 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-22403cbb47fso91431455ad.0
 for <qemu-devel@nongnu.org>; Mon, 24 Mar 2025 12:30:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742844651; x=1743449451; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=y4NBXuIqNAVEHZPI3HkclVWQ3wW8EC1SduB68D4EJ4A=;
 b=hkbPuANPfWmgOuIlwmt7+uiyzDYGuvNhVAr+NiEwQ1nlGXbr9wPHAkBJPY09GDMZtd
 h4zd/8eWK/OMyybEDzqzuxElPcZxc4imqmqIlJf+Ve260wFmFsVoHR8c0anQZV3pmos6
 F3GoaNBLrTYG/8SiGq4SR2Db3HdvLHdO3KfpFATkbtDXYZv8P/JKYeU+vBWwgeh8gqa1
 y2t/pARU0bHwyYSkvuY87RR4MMCOfP2fES6cvU/ZZ3V7Ev6vNGtieWX18ImsDJyKuwM8
 /D8NRDmMVoLfpWrGvCk6zqTRLvmcaWsK8Pyyn4Nvu6QFalAXwo2cVKfmIhndw7pBqI9M
 7F1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742844651; x=1743449451;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=y4NBXuIqNAVEHZPI3HkclVWQ3wW8EC1SduB68D4EJ4A=;
 b=h7uH5hVD7hTu1Sj+fgEJwFC24I8c9Ladd5nEcAMTcHGQgwoMVxphu7kgi0WdRM3DmG
 qcFzduB83yZM3xLY5wYQL3tnC+C8sBXem2Xc7IAjvxpyQ8HRjw8EQ9QuY5vFZN0IJ3KG
 SdSVt41xd2LCqmZxUq+LX9Ldp+sn4c4yY/zKl/F0OhguhGrqzE9WhZ9smLTlgopLWQah
 isiWgnwDfzCyro6F0hKLXVGrzlxuW/Lia1gTrbYmEVDrUVI8J26RVMwI8zbirM1MkBMr
 g14o5S5fmvMrU+Hd4yeuZmiwJIs4cMGNNMsWZntsJ+gi3aQSAIXXVhHCGrjg2wbhp1p4
 sr5w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWRxhTvjzaXqcSBnOzAdAuPgfZb4QICAlXvrb263PbkgAyds7vQtz039j7Y1sNPuC9w2B/CN0/Egi9e@nongnu.org
X-Gm-Message-State: AOJu0YxCwb6gH0KeAnG1DYOzoWdqeocVFbmOvs0zbpd/DhIA1knp1PQr
 R2tIU3v/X+QW7uu7cMIwI2+twUEXQ6LqZfXuoG06s/kd9Y7bDeRH8q6Gfsxjrjc=
X-Gm-Gg: ASbGnct6uv1bD6sZ44dsevBzlYvNLo0OyjxiJo+ZhMVTnYGggnWt1imZTKWAH7BRhhE
 4Luyf/sroauEBnfSaRQJEErsbcIB0OOKyYNA+z13T6A4Htcdhr3rgQAnPVPsUgeYMv/mLSCX1dw
 clKW6mZm3mYidzE1ibJO5oLkuypPlqzVOFWlLi7EsvQ6Yx2zhcdqwDwHDUk36mm5xhD11niE0mN
 KjFRoJokxjmGvbf54PF1i1kbH64o4KuebW7RGqT06QzE4x7xcbAgDhSgscOdZFnH/cSxTC1o/N4
 YTLMOBuTYWkTD1yFWQOM7TjvVd7AGFaCSzLkxS51iT1H4+FQ2i7St5eu9rTEpQlZGbCm
X-Google-Smtp-Source: AGHT+IEehcu8g08aQCATklHm504PcYLn4UeYhnqCMMcrPjynBCoBJgcXN+th+EvTTcFTLPrFbnq1Ow==
X-Received: by 2002:a17:902:da82:b0:224:162:a3e0 with SMTP id
 d9443c01a7336-22780e2a37fmr203899955ad.49.1742844651162; 
 Mon, 24 Mar 2025 12:30:51 -0700 (PDT)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22780f396fasm74767095ad.27.2025.03.24.12.30.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 24 Mar 2025 12:30:50 -0700 (PDT)
Message-ID: <6d2cb56c-0ba7-4b76-836d-801d52bd67aa@linaro.org>
Date: Mon, 24 Mar 2025 12:30:49 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 10/11] target/microblaze: convert gdbstub to new helper
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Nicholas Piggin <npiggin@gmail.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Markus Armbruster <armbru@redhat.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>, qemu-ppc@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>, David Gibson <david@gibson.dropbear.id.au>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-s390x@nongnu.org,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 David Hildenbrand <david@redhat.com>
References: <20250324102142.67022-1-alex.bennee@linaro.org>
 <20250324102142.67022-11-alex.bennee@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250324102142.67022-11-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62c.google.com
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

T24gMy8yNC8yNSAwMzoyMSwgQWxleCBCZW5uw6llIHdyb3RlOg0KPiBUaGlzIGlzIGEgcHJl
dHR5IHNpbXBsZSBjb252ZXJzaW9uIGdpdmVuIGEgc2luZ2xlIHNldCBvZiByZWdpc3RlcnMg
YW5kDQo+IGFuIGV4aXN0aW5nIGhlbHBlciB0byBwcm9iZSBlbmRpYW5lc3MuDQo+IA0KPiBT
aWduZWQtb2ZmLWJ5OiBBbGV4IEJlbm7DqWUgPGFsZXguYmVubmVlQGxpbmFyby5vcmc+DQo+
IA0KPiAtLS0NCj4gdjINCj4gICAgLSB1c2UgbWJfY3B1X2lzX2JpZ19lbmRpYW4NCj4gICAg
LSB1c2UgZXhwbGljaXQgTU9fMzIgc2l6ZQ0KPiAgICAtIGhhbmRsZSBkaWZmZXJpbmcgc2l6
ZSBvZiBlbnYtPmVhciBiZXR3ZWVuIHVzZXIvc3lzdGVtDQo+IC0tLQ0KPiAgIHRhcmdldC9t
aWNyb2JsYXplL2dkYnN0dWIuYyB8IDQ5ICsrKysrKysrKysrKysrKysrLS0tLS0tLS0tLS0t
LS0tLS0tLS0NCj4gICAxIGZpbGUgY2hhbmdlZCwgMjIgaW5zZXJ0aW9ucygrKSwgMjcgZGVs
ZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvdGFyZ2V0L21pY3JvYmxhemUvZ2Ric3R1
Yi5jIGIvdGFyZ2V0L21pY3JvYmxhemUvZ2Ric3R1Yi5jDQo+IGluZGV4IGQ0OTM2ODFkMzgu
LmRiYWY3ZWNiOWMgMTAwNjQ0DQo+IC0tLSBhL3RhcmdldC9taWNyb2JsYXplL2dkYnN0dWIu
Yw0KPiArKysgYi90YXJnZXQvbWljcm9ibGF6ZS9nZGJzdHViLmMNCj4gQEAgLTE5LDcgKzE5
LDcgQEANCj4gICAgKi8NCj4gICAjaW5jbHVkZSAicWVtdS9vc2RlcC5oIg0KPiAgICNpbmNs
dWRlICJjcHUuaCINCj4gLSNpbmNsdWRlICJnZGJzdHViL2hlbHBlcnMuaCINCj4gKyNpbmNs
dWRlICJnZGJzdHViL3JlZ2lzdGVycy5oIg0KPiAgIA0KPiAgIC8qDQo+ICAgICogR0RCIGV4
cGVjdHMgU1JFR3MgaW4gdGhlIGZvbGxvd2luZyBvcmRlcjoNCj4gQEAgLTUwLDYyICs1MCw1
NyBAQCBpbnQgbWJfY3B1X2dkYl9yZWFkX3JlZ2lzdGVyKENQVVN0YXRlICpjcywgR0J5dGVB
cnJheSAqbWVtX2J1ZiwgaW50IG4pDQo+ICAgew0KPiAgICAgICBNaWNyb0JsYXplQ1BVICpj
cHUgPSBNSUNST0JMQVpFX0NQVShjcyk7DQo+ICAgICAgIENQVU1CU3RhdGUgKmVudiA9ICZj
cHUtPmVudjsNCj4gLSAgICB1aW50MzJfdCB2YWw7DQo+ICsgICAgTWVtT3AgbW8gPSBtYl9j
cHVfaXNfYmlnX2VuZGlhbihjcykgPyBNT19CRSA6IE1PX0xFOw0KPiArICAgIHVpbnQzMl90
IG1zcjsNCj4gICANCj4gICAgICAgc3dpdGNoIChuKSB7DQo+ICAgICAgIGNhc2UgMSAuLi4g
MzE6DQo+IC0gICAgICAgIHZhbCA9IGVudi0+cmVnc1tuXTsNCj4gLSAgICAgICAgYnJlYWs7
DQo+ICsgICAgICAgIHJldHVybiBnZGJfZ2V0X3JlZzMyX3ZhbHVlKG1vIHwgTU9fMzIsIG1l
bV9idWYsICZlbnYtPnJlZ3Nbbl0pOw0KPiAgICAgICBjYXNlIEdEQl9QQzoNCj4gLSAgICAg
ICAgdmFsID0gZW52LT5wYzsNCj4gLSAgICAgICAgYnJlYWs7DQo+ICsgICAgICAgIHJldHVy
biBnZGJfZ2V0X3JlZzMyX3ZhbHVlKG1vIHwgTU9fMzIsIG1lbV9idWYsICZlbnYtPnBjKTsN
Cj4gICAgICAgY2FzZSBHREJfTVNSOg0KPiAtICAgICAgICB2YWwgPSBtYl9jcHVfcmVhZF9t
c3IoZW52KTsNCj4gLSAgICAgICAgYnJlYWs7DQo+ICsgICAgICAgIG1zciA9IG1iX2NwdV9y
ZWFkX21zcihlbnYpOw0KPiArICAgICAgICByZXR1cm4gZ2RiX2dldF9yZWczMl92YWx1ZSht
byB8IE1PXzMyLCBtZW1fYnVmLCAmbXNyKTsNCj4gICAgICAgY2FzZSBHREJfRUFSOg0KPiAt
ICAgICAgICB2YWwgPSBlbnYtPmVhcjsNCj4gLSAgICAgICAgYnJlYWs7DQo+ICsjaWYgVEFS
R0VUX0xPTkdfQklUUyA9PSA2NA0KPiArICAgICAgICByZXR1cm4gZ2RiX2dldF9yZWc2NF92
YWx1ZShtbyB8IE1PXzY0LCBtZW1fYnVmLCAmZW52LT5lYXIpOw0KPiArI2Vsc2UNCj4gKyAg
ICAgICAgcmV0dXJuIGdkYl9nZXRfcmVnMzJfdmFsdWUobW8gfCBNT18zMiwgbWVtX2J1Ziwg
JmVudi0+ZWFyKTsNCj4gKyNlbmRpZg0KPiAgICAgICBjYXNlIEdEQl9FU1I6DQo+IC0gICAg
ICAgIHZhbCA9IGVudi0+ZXNyOw0KPiAtICAgICAgICBicmVhazsNCj4gKyAgICAgICAgcmV0
dXJuIGdkYl9nZXRfcmVnMzJfdmFsdWUobW8gfCBNT18zMiwgbWVtX2J1ZiwgJmVudi0+ZXNy
KTsNCj4gICAgICAgY2FzZSBHREJfRlNSOg0KPiAtICAgICAgICB2YWwgPSBlbnYtPmZzcjsN
Cj4gLSAgICAgICAgYnJlYWs7DQo+ICsgICAgICAgIHJldHVybiBnZGJfZ2V0X3JlZzMyX3Zh
bHVlKG1vIHwgTU9fMzIsIG1lbV9idWYsICZlbnYtPmZzcik7DQo+ICAgICAgIGNhc2UgR0RC
X0JUUjoNCj4gLSAgICAgICAgdmFsID0gZW52LT5idHI7DQo+IC0gICAgICAgIGJyZWFrOw0K
PiArICAgICAgICByZXR1cm4gZ2RiX2dldF9yZWczMl92YWx1ZShtbyB8IE1PXzMyLCBtZW1f
YnVmLCAmZW52LT5idHIpOw0KPiAgICAgICBjYXNlIEdEQl9QVlIwIC4uLiBHREJfUFZSMTE6
DQo+ICAgICAgICAgICAvKiBQVlIxMiBpcyBpbnRlbnRpb25hbGx5IHNraXBwZWQgKi8NCj4g
LSAgICAgICAgdmFsID0gY3B1LT5jZmcucHZyX3JlZ3NbbiAtIEdEQl9QVlIwXTsNCj4gLSAg
ICAgICAgYnJlYWs7DQo+ICsgICAgICAgIHJldHVybiBnZGJfZ2V0X3JlZzMyX3ZhbHVlKG1v
IHwgTU9fMzIsIG1lbV9idWYsDQo+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICZjcHUtPmNmZy5wdnJfcmVnc1tuIC0gR0RCX1BWUjBdKTsNCj4gICAgICAgY2Fz
ZSBHREJfRURSOg0KPiAtICAgICAgICB2YWwgPSBlbnYtPmVkcjsNCj4gLSAgICAgICAgYnJl
YWs7DQo+ICsgICAgICAgIHJldHVybiBnZGJfZ2V0X3JlZzMyX3ZhbHVlKG1vIHwgTU9fMzIs
IG1lbV9idWYsICZlbnYtPmVkcik7DQo+ICAgICAgIGRlZmF1bHQ6DQo+ICAgICAgICAgICAv
KiBPdGhlciBTUmVncyBhcmVuJ3QgbW9kZWxlZCwgc28gcmVwb3J0IGEgdmFsdWUgb2YgMCAq
Lw0KPiAtICAgICAgICB2YWwgPSAwOw0KPiAtICAgICAgICBicmVhazsNCj4gKyAgICAgICAg
cmV0dXJuIDA7DQo+ICAgICAgIH0NCj4gLSAgICByZXR1cm4gZ2RiX2dldF9yZWczMihtZW1f
YnVmLCB2YWwpOw0KPiAgIH0NCj4gICANCj4gICBpbnQgbWJfY3B1X2dkYl9yZWFkX3N0YWNr
X3Byb3RlY3QoQ1BVU3RhdGUgKmNzLCBHQnl0ZUFycmF5ICptZW1fYnVmLCBpbnQgbikNCj4g
ICB7DQo+ICAgICAgIE1pY3JvQmxhemVDUFUgKmNwdSA9IE1JQ1JPQkxBWkVfQ1BVKGNzKTsN
Cj4gICAgICAgQ1BVTUJTdGF0ZSAqZW52ID0gJmNwdS0+ZW52Ow0KPiAtICAgIHVpbnQzMl90
IHZhbDsNCj4gKyAgICBNZW1PcCBtbyA9IFRBUkdFVF9CSUdfRU5ESUFOID8gTU9fQkVVTCA6
IE1PX0xFVUw7DQo+ICAgDQo+ICAgICAgIHN3aXRjaCAobikgew0KPiAgICAgICBjYXNlIEdE
Ql9TUF9TSEw6DQo+IC0gICAgICAgIHZhbCA9IGVudi0+c2xyOw0KPiArICAgICAgICByZXR1
cm4gZ2RiX2dldF9yZWczMl92YWx1ZShtbywgbWVtX2J1ZiwgJmVudi0+c2xyKTsNCj4gICAg
ICAgICAgIGJyZWFrOw0KPiAgICAgICBjYXNlIEdEQl9TUF9TSFI6DQo+IC0gICAgICAgIHZh
bCA9IGVudi0+c2hyOw0KPiArICAgICAgICByZXR1cm4gZ2RiX2dldF9yZWczMl92YWx1ZSht
bywgbWVtX2J1ZiwgJmVudi0+c2hyKTsNCj4gICAgICAgICAgIGJyZWFrOw0KPiAgICAgICBk
ZWZhdWx0Og0KPiAgICAgICAgICAgcmV0dXJuIDA7DQo+ICAgICAgIH0NCj4gLSAgICByZXR1
cm4gZ2RiX2dldF9yZWczMihtZW1fYnVmLCB2YWwpOw0KPiAgIH0NCj4gICANCj4gICBpbnQg
bWJfY3B1X2dkYl93cml0ZV9yZWdpc3RlcihDUFVTdGF0ZSAqY3MsIHVpbnQ4X3QgKm1lbV9i
dWYsIGludCBuKQ0KDQpSZXZpZXdlZC1ieTogUGllcnJpY2sgQm91dmllciA8cGllcnJpY2su
Ym91dmllckBsaW5hcm8ub3JnPg0KDQo=

