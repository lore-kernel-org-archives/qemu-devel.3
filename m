Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 673ECC36008
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Mar 2025 19:22:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1twnMu-0004W7-M2; Mon, 24 Mar 2025 15:21:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1twnMm-0004Uq-JL
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 15:21:45 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1twnMi-0004WP-Ub
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 15:21:44 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-22401f4d35aso99784495ad.2
 for <qemu-devel@nongnu.org>; Mon, 24 Mar 2025 12:21:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742844099; x=1743448899; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=iln3DDo11cc7Vmz6mM9p5G9GDb/RyNKpodhvE6L6MBc=;
 b=FkDDDBw0xlUvNS6BHr0NE7aJifxE02rElXM2S9oW9fwug68S88bN3MPSCsw0oghu9V
 30a1/6lS6p1FL25V1VJl+FdjiQIQg/4hrZjdtAMTckVD4pvHju3roxMg37/gIpTXmhKL
 Z65QGGNrdHnP4G4SzNqrpKx15VpI04HErpdR/FDAsnl9/x58Ld5sX0ju5K4Zou5D/Y7x
 mlIkrRwSLcpauBamuf0Yq7s7vVhG/MXs5otGlPK3cVZFwTXVUcZqt8PbDLv2DtLHz4sE
 Q+Px+DvQljGHYMfF4/Bs+6dC5gV+OtFSpypHbS77Wus8FjyZbwlFmYHDPlSxxCTF01UQ
 RC2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742844099; x=1743448899;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=iln3DDo11cc7Vmz6mM9p5G9GDb/RyNKpodhvE6L6MBc=;
 b=UHm2E/jf/GXjLTTT+TqYMcyMz2yTVrIR8NBqpQmsYIk42pp0zOFtiEuc+q1RenuOcI
 Rg0NU0HBQ5eSmP4h+O3q8OrKSsTCqJ9YnaQiRYwP/I5de4ThYORYUTzg1wblajz9Yt3g
 rxwDb5PbQQYg2Dy2UzuK1teaZeRIBL1JyX/tzKYZm3spwPhtohIlXGd6ac/gCr4+sVG4
 Q8Qqiu5D71IY0k3EwPAHot0sMb6cQYhV6dh/Xl9P9iy5BUK7BbrUHlxsD2m11nCHUI9z
 9RPpfVpcjCPoT7UPj/s2BkROlY/ZkURIbmKG+gjUJvA0K+lGa9ZH/MuppNg2kIB/1MRq
 uR9A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUkDiiQXmWuQy5wdhQnd5xvdMitwA7RDxwTxuq3x1ruu70vfD4S/LYSutS5cFQ/5AsURA7LJaXNXX2U@nongnu.org
X-Gm-Message-State: AOJu0Yz9DGRr5TWA3k9KmIDcT0t6DK9YUFpd3iFaR0mIbcuJoemAq/mX
 30DNK5AzhaqBPh1OdhtrvJiAHgJjCy0WE7yzK8KKxtDSBsm7a6DgwjC0hSJ4lHQ=
X-Gm-Gg: ASbGncuoqWpL0lsKzDi7yls7fInc8M8xJmIocsUrz6yQMaAE8+dSFUmh3naLIHiy3UR
 3LWP6JYylG2YsQOrxcdUVzeUbbgUi3QIouCcEF64AR2t7HIjuDu2PbhsQ1mLnG+gnTE+nr+6WXu
 jn0TgpPLozHOMUPTsfZ9USTrAn3TqXANeIkkvS2ZsOk43xuf21Vf1GGAsVYy9zWS5cTQvfRPpwQ
 QwzcS4ff9/+ClJU6NwIJjRXuLDq2rWgkddhMQIvjFLpLYk62d8NnSz+Frx1yURbZfUdcR2VZvoB
 MJZ27O7ef94l3a2Cw0zIDdYjE3qwzRLcrkN/E8Fp5D+uduempU5fhlMH8g==
X-Google-Smtp-Source: AGHT+IHYOY1wVcpMsFGkx0CnQt95K+iJnJ6lKJ0T7VvuOaeFM3sSy/ZmJb+ggNVx8IEMNk94k8I78w==
X-Received: by 2002:a17:902:fc4b:b0:223:4d7e:e52c with SMTP id
 d9443c01a7336-22780c689f7mr263820695ad.5.1742844099016; 
 Mon, 24 Mar 2025 12:21:39 -0700 (PDT)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-227811f6549sm74940855ad.208.2025.03.24.12.21.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 24 Mar 2025 12:21:38 -0700 (PDT)
Message-ID: <9843001d-d42c-4f25-b2d5-c7347e78847f@linaro.org>
Date: Mon, 24 Mar 2025 12:21:37 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 04/11] gdbstub: introduce target independent gdb
 register helper
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
 <20250324102142.67022-5-alex.bennee@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250324102142.67022-5-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

T24gMy8yNC8yNSAwMzoyMSwgQWxleCBCZW5uw6llIHdyb3RlOg0KPiBUaGUgY3VycmVudCBo
ZWxwZXIuaCBmdW5jdGlvbnMgcmVseSBvbiBoYXJkIGNvZGVkIGFzc3VtcHRpb25zIGFib3V0
DQo+IHRhcmdldCBlbmRpYW5lc3MgdG8gdXNlIHRoZSB0c3dhcCBtYWNyb3MuIFdlIGFsc28g
ZW5kIHVwIGRvdWJsZQ0KPiBzd2FwcGluZyBhIGJ1bmNoIG9mIHZhbHVlcyBpZiB0aGUgdGFy
Z2V0IGNhbiBydW4gaW4gbXVsdGlwbGUgZW5kaWFuZXNzDQo+IG1vZGVzLiBBdm9pZCB0aGlz
IGJ5IGdldHRpbmcgdGhlIHRhcmdldCB0byBwYXNzIHRoZSBlbmRpYW5lc3MgYW5kIHNpemUN
Cj4gdmlhIGEgTWVtT3AgYW5kIGZpeGluZyB1cCBhcHByb3ByaWF0ZWx5Lg0KPiANCj4gUmV2
aWV3ZWQtYnk6IFBpZXJyaWNrIEJvdXZpZXIgPHBpZXJyaWNrLmJvdXZpZXJAbGluYXJvLm9y
Zz4NCj4gU2lnbmVkLW9mZi1ieTogQWxleCBCZW5uw6llIDxhbGV4LmJlbm5lZUBsaW5hcm8u
b3JnPg0KPiANCj4gLS0tDQo+IHYyDQo+ICAgIC0gdXNlIHVuc2lnbmVkIGNvbnNpc3RlbnRs
eQ0KPiAgICAtIGZpeCBzb21lIHJvdWdlIHdoaXRlc3BhY2UNCj4gICAgLSBhZGQgdHlwZWQg
cmVnMzIvNjQgd3JhcHBlcnMNCj4gICAgLSBwYXNzIHZvaWQgKiB0byB1bmRlcmx5aW5nIGhl
bHBlciB0byBhdm9pZCBjYXN0aW5nDQo+IC0tLQ0KPiAgIGluY2x1ZGUvZ2Ric3R1Yi9yZWdp
c3RlcnMuaCB8IDU1ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysNCj4g
ICBnZGJzdHViL2dkYnN0dWIuYyAgICAgICAgICAgfCAyMyArKysrKysrKysrKysrKysrDQo+
ICAgMiBmaWxlcyBjaGFuZ2VkLCA3OCBpbnNlcnRpb25zKCspDQo+ICAgY3JlYXRlIG1vZGUg
MTAwNjQ0IGluY2x1ZGUvZ2Ric3R1Yi9yZWdpc3RlcnMuaA0KPiANCj4gZGlmZiAtLWdpdCBh
L2luY2x1ZGUvZ2Ric3R1Yi9yZWdpc3RlcnMuaCBiL2luY2x1ZGUvZ2Ric3R1Yi9yZWdpc3Rl
cnMuaA0KPiBuZXcgZmlsZSBtb2RlIDEwMDY0NA0KPiBpbmRleCAwMDAwMDAwMDAwLi4yMjIw
ZjU4ZWZlDQo+IC0tLSAvZGV2L251bGwNCj4gKysrIGIvaW5jbHVkZS9nZGJzdHViL3JlZ2lz
dGVycy5oDQo+IEBAIC0wLDAgKzEsNTUgQEANCj4gKy8qDQo+ICsgKiBHREIgQ29tbW9uIFJl
Z2lzdGVyIEhlbHBlcnMNCj4gKyAqDQo+ICsgKiBDb3B5cmlnaHQgKGMpIDIwMjUgTGluYXJv
IEx0ZA0KPiArICoNCj4gKyAqIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4wLW9y
LWxhdGVyDQo+ICsgKi8NCj4gKw0KPiArI2lmbmRlZiBHREJfUkVHSVNURVJTX0gNCj4gKyNk
ZWZpbmUgR0RCX1JFR0lTVEVSU19IDQo+ICsNCj4gKyNpbmNsdWRlICJleGVjL21lbW9wLmgi
DQo+ICsNCj4gKy8qKg0KPiArICogZ2RiX2dldF9yZWdpc3Rlcl92YWx1ZSgpIC0gZ2V0IHJl
Z2lzdGVyIHZhbHVlIGZvciBnZGINCj4gKyAqIG1vOiBzaXplIGFuZCBlbmRpYW4gTWVtT3AN
Cj4gKyAqIGJ1ZjogR0J5dGVBcnJheSB0byBzdG9yZSBpbiB0YXJnZXQgb3JkZXINCj4gKyAq
IHZhbDogcG9pbnRlciB0byB2YWx1ZSBpbiBob3N0IG9yZGVyDQo+ICsgKg0KPiArICogVGhp
cyByZXBsYWNlcyB0aGUgcHJldmlvdXMgbGVnYWN5IHJlYWQgZnVuY3Rpb25zIHdpdGggYSBz
aW5nbGUNCj4gKyAqIGZ1bmN0aW9uIHRvIGhhbmRsZSBhbGwgc2l6ZXMuIFBhc3NpbmcgQG1v
IGFsbG93cyB0aGUgdGFyZ2V0IG1vZGUgdG8NCj4gKyAqIGJlIHRha2VuIGludG8gYWNjb3Vu
dCBhbmQgYXZvaWRzIHVzaW5nIGhhcmQgY29kZWQgdHN3YXAoKSBtYWNyb3MuDQo+ICsgKg0K
PiArICogVGhlcmUgYXJlIHdyYXBwZXIgZnVuY3Rpb25zIGZvciB0aGUgY29tbW9uIHNpemVz
IHlvdSBjYW4gdXNlIHRvDQo+ICsgKiBrZWVwIHR5cGUgY2hlY2tpbmcuDQo+ICsgKg0KPiAr
ICogUmV0dXJucyB0aGUgbnVtYmVyIG9mIGJ5dGVzIHdyaXR0ZW4gdG8gdGhlIGFycmF5Lg0K
PiArICovDQo+ICtpbnQgZ2RiX2dldF9yZWdpc3Rlcl92YWx1ZShNZW1PcCBvcCwgR0J5dGVB
cnJheSAqYnVmLCB2b2lkICp2YWwpOw0KPiArDQo+ICsvKioNCj4gKyAqIGdkYl9nZXRfcmVn
MzJfdmFsdWUoKSAtIHR5cGUgY2hlY2tlZCB3cmFwcGVyIGZvciBnZGJfZ2V0X3JlZ2lzdGVy
X3ZhbHVlKCkNCj4gKyAqIG1vOiBzaXplIGFuZCBlbmRpYW4gTWVtT3ANCj4gKyAqIGJ1Zjog
R0J5dGVBcnJheSB0byBzdG9yZSBpbiB0YXJnZXQgb3JkZXINCj4gKyAqIHZhbDogcG9pbnRl
ciB0byB1aW50MzJfdCB2YWx1ZSBpbiBob3N0IG9yZGVyDQo+ICsgKi8NCj4gK3N0YXRpYyBp
bmxpbmUgaW50IGdkYl9nZXRfcmVnMzJfdmFsdWUoTWVtT3Agb3AsIEdCeXRlQXJyYXkgKmJ1
ZiwgdWludDMyX3QgKnZhbCkgew0KPiArICAgIGdfYXNzZXJ0KChvcCAmIE1PX1NJWkUpID09
IE1PXzMyKTsNCj4gKyAgICByZXR1cm4gZ2RiX2dldF9yZWdpc3Rlcl92YWx1ZShvcCwgYnVm
LCB2YWwpOw0KPiArfQ0KPiArDQo+ICsvKioNCj4gKyAqIGdkYl9nZXRfcmVnNjRfdmFsdWUo
KSAtIHR5cGUgY2hlY2tlZCB3cmFwcGVyIGZvciBnZGJfZ2V0X3JlZ2lzdGVyX3ZhbHVlKCkN
Cj4gKyAqIG1vOiBzaXplIGFuZCBlbmRpYW4gTWVtT3ANCj4gKyAqIGJ1ZjogR0J5dGVBcnJh
eSB0byBzdG9yZSBpbiB0YXJnZXQgb3JkZXINCj4gKyAqIHZhbDogcG9pbnRlciB0byB1aW50
MzJfdCB2YWx1ZSBpbiBob3N0IG9yZGVyDQo+ICsgKi8NCj4gK3N0YXRpYyBpbmxpbmUgaW50
IGdkYl9nZXRfcmVnNjRfdmFsdWUoTWVtT3Agb3AsIEdCeXRlQXJyYXkgKmJ1ZiwgdWludDY0
X3QgKnZhbCkgew0KPiArICAgIGdfYXNzZXJ0KChvcCAmIE1PX1NJWkUpID09IE1PXzY0KTsN
Cj4gKyAgICByZXR1cm4gZ2RiX2dldF9yZWdpc3Rlcl92YWx1ZShvcCwgYnVmLCB2YWwpOw0K
PiArfQ0KPiArDQoNCk1heWJlIHdlIGNvdWxkIHNpbXBseSBleHBlY3QgZW5kaWFuIGluZm9y
bWF0aW9uIGZyb20gTWVtT3AsIGFuZCBhZGQgDQpyZXF1aXJlZCBzaXplIGhlcmUuDQpJdCBj
bHV0dGVycyBjYWxsIHNpdGVzIHRvIGhhdmUgZ2RiX2dldF9yZWdYX3ZhbHVlKE1PX1ggfCAu
Li4pLg0KV2UgY2FuIGV2ZW50dWFsbHkgYXNzZXJ0IG5vIHNpemUgd2FzIHNldCwgc28gaXQn
cyBub3QgYWRkZWQgYnkgbWlzdGFrZSANCmZyb20gY2FsbGVycy4NCg0KPiArI2VuZGlmIC8q
IEdEQl9SRUdJU1RFUlNfSCAqLw0KPiArDQo+ICsNCj4gZGlmZiAtLWdpdCBhL2dkYnN0dWIv
Z2Ric3R1Yi5jIGIvZ2Ric3R1Yi9nZGJzdHViLmMNCj4gaW5kZXggYjZkNWUxMWUwMy4uZTc5
OWZkYzAxOSAxMDA2NDQNCj4gLS0tIGEvZ2Ric3R1Yi9nZGJzdHViLmMNCj4gKysrIGIvZ2Ri
c3R1Yi9nZGJzdHViLmMNCj4gQEAgLTMyLDYgKzMyLDcgQEANCj4gICAjaW5jbHVkZSAiZXhl
Yy9nZGJzdHViLmgiDQo+ICAgI2luY2x1ZGUgImdkYnN0dWIvY29tbWFuZHMuaCINCj4gICAj
aW5jbHVkZSAiZ2Ric3R1Yi9zeXNjYWxscy5oIg0KPiArI2luY2x1ZGUgImdkYnN0dWIvcmVn
aXN0ZXJzLmgiDQo+ICAgI2lmZGVmIENPTkZJR19VU0VSX09OTFkNCj4gICAjaW5jbHVkZSAi
YWNjZWwvdGNnL3ZjcHUtc3RhdGUuaCINCj4gICAjaW5jbHVkZSAiZ2Ric3R1Yi91c2VyLmgi
DQo+IEBAIC00NSw2ICs0Niw3IEBADQo+ICAgI2luY2x1ZGUgInN5c3RlbS9ydW5zdGF0ZS5o
Ig0KPiAgICNpbmNsdWRlICJleGVjL3JlcGxheS1jb3JlLmgiDQo+ICAgI2luY2x1ZGUgImV4
ZWMvaHdhZGRyLmgiDQo+ICsjaW5jbHVkZSAiZXhlYy9tZW1vcC5oIg0KPiAgIA0KPiAgICNp
bmNsdWRlICJpbnRlcm5hbHMuaCINCj4gICANCj4gQEAgLTU1MSw2ICs1NTMsMjcgQEAgc3Rh
dGljIGludCBnZGJfd3JpdGVfcmVnaXN0ZXIoQ1BVU3RhdGUgKmNwdSwgdWludDhfdCAqbWVt
X2J1ZiwgaW50IHJlZykNCj4gICAgICAgcmV0dXJuIDA7DQo+ICAgfQ0KPiAgIA0KPiArLyoN
Cj4gKyAqIFRhcmdldCBoZWxwZXIgZnVuY3Rpb24gdG8gcmVhZCB2YWx1ZSBpbnRvIEdCeXRl
QXJyYXksIHRhcmdldA0KPiArICogc3VwcGxpZXMgdGhlIHNpemUgYW5kIHRhcmdldCBlbmRp
YW5lc3MgdmlhIHRoZSBNZW1PcC4NCj4gKyAqLw0KPiAraW50IGdkYl9nZXRfcmVnaXN0ZXJf
dmFsdWUoTWVtT3Agb3AsIEdCeXRlQXJyYXkgKmJ1Ziwgdm9pZCAqdmFsKQ0KPiArew0KPiAr
ICAgIHVuc2lnbmVkIGJ5dGVzID0gbWVtb3Bfc2l6ZShvcCk7DQo+ICsNCj4gKyAgICBpZiAo
b3AgJiBNT19CU1dBUCkgew0KPiArICAgICAgICB1aW50OF90ICpwdHIgPSAmKCh1aW50OF90
ICopIHZhbClbYnl0ZXMgLSAxXTsNCj4gKyAgICAgICAgZm9yICh1bnNpZ25lZCBpID0gYnl0
ZXM7IGkgPiAwOyBpLS0pIHsNCj4gKyAgICAgICAgICAgIGdfYnl0ZV9hcnJheV9hcHBlbmQo
YnVmLCBwdHItLSwgMSk7DQo+ICsgICAgICAgIH07DQo+ICsgICAgfSBlbHNlIHsNCj4gKyAg
ICAgICAgZ19ieXRlX2FycmF5X2FwcGVuZChidWYsIHZhbCwgYnl0ZXMpOw0KPiArICAgIH0N
Cj4gKw0KPiArICAgIHJldHVybiBieXRlczsNCj4gK30NCj4gKw0KPiArDQo+ICAgc3RhdGlj
IHZvaWQgZ2RiX3JlZ2lzdGVyX2ZlYXR1cmUoQ1BVU3RhdGUgKmNwdSwgaW50IGJhc2VfcmVn
LA0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGdkYl9nZXRfcmVnX2Ni
IGdldF9yZWcsIGdkYl9zZXRfcmVnX2NiIHNldF9yZWcsDQo+ICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgY29uc3QgR0RCRmVhdHVyZSAqZmVhdHVyZSkNCg0K

