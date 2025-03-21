Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 260E3C36000
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Mar 2025 17:25:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tvg7G-00022L-26; Fri, 21 Mar 2025 13:25:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tvg6x-00020i-CS
 for qemu-devel@nongnu.org; Fri, 21 Mar 2025 13:24:49 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tvg6u-0006Af-Ts
 for qemu-devel@nongnu.org; Fri, 21 Mar 2025 13:24:47 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-227914acd20so9563715ad.1
 for <qemu-devel@nongnu.org>; Fri, 21 Mar 2025 10:24:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742577883; x=1743182683; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=iGkWGKEcyLrBkC2DRsuZHUvYNpY928YoawSZq7leLW4=;
 b=vDfLzbgResEoVsOyu9XjL0zDrgNFN2Ge5nVqhRrxgIkmY27n6FluWwzJfj3Hq3+6pm
 aFGV4r0rJd2jHMO+zLReEBT8cU+W90fbZZLmbcUJ1OwSosTl2dZxLnjaU6FM68NOI8Tl
 DboRgxfxLkQD6+fhF37KwpiSklgkODNVUFvnXvXIXbPTSFG1gqxbntKDPK4nvxZSLGQ/
 6wGbGUmy5Jv7N0do3q9fRNqWulEkL8bBxPHWqtGJtpKxIbEe57g/W6+sJxd9z7SU8hci
 9giAd9BTecmSQfHEMqFeyfFWUxE4LC8lteW67fPRLadLR+5jJq+QpDtxqSFgq3ITGRpx
 LzyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742577883; x=1743182683;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=iGkWGKEcyLrBkC2DRsuZHUvYNpY928YoawSZq7leLW4=;
 b=UrdWPK2DegV2eKZwehs3Cd9zDnEECbHE4TUzEpYlAFwTPQrXHrqGB0nWArrfsteZop
 q7MHV04/P9u217G+UIaPGdGiZy0Jm308JdB3uq43ssqHdDAAARDLYB4TlwrsgPQoGW4u
 TB8j+m4A0Uo/p1yLjLPREZkagBoW8W2uoUMw0FILdYbvynD32sKllh/uj9xS9ElPK/vO
 rtgYVxW9UDyyg7hu2dmhozbv7NgHyWb78ITKb2dNRQ8a8yYyWeGhPyKPQ7yLU1RTykBa
 luFuBnV3LLfdPpwt7B/yBecpWCk3AMJV/CtKUJYFuj4U1RHLmpwI+pWxG14RhtEpEMMn
 gPBA==
X-Gm-Message-State: AOJu0YzhflG1mQi4wWXOy4JGpkM4HD9kWVF0dx527QQ3L7DpltajI1Qi
 rNaTtOgr0HhCVxN9DbzXnAhc6rjL4VIbKX620r5Ddqdg39i21ToqcDGFIUSDytU=
X-Gm-Gg: ASbGncvdXdk93QPnoXrxlHy5owWot3ROaZVJ4Y/Fio8cX1WUyrGqbRdK+w7ZlXoPPeI
 hUBMSCi/elIApJzmsGF1erez7QAa1VjfsEe0gKi2JO9ci0qq7FXV5hrCKyvZub5ur8XwkQWklSe
 jgfRgjPmKcPyGKiThlrZXxx9gNwDYDFNamAXbVYSVqSBitj7yuTBGsQrLy+4ZMGd3EpoKlW+vnE
 XcFGIWpleJUH93wWcYcHRHghF4VUv4dwJtlOff8wCm3BeuhyKNXVgH+wUHLIVWd9jLSDFfVF204
 MxnHnHP623CeoRnzIDgc0GakKQzWebYo6P8IlIn6MG1Pnd1F6pbyAFKi92w=
X-Google-Smtp-Source: AGHT+IGhpyHCmI/3taDycuWv8sDIj0LwxBuh86+pYdB1wXiPhAPz5+TYLNZkGtY2HJKB4Pf2GYeKSQ==
X-Received: by 2002:a17:902:e5c5:b0:226:194f:48ef with SMTP id
 d9443c01a7336-2265e6bbbc8mr114271965ad.13.1742577882745; 
 Fri, 21 Mar 2025 10:24:42 -0700 (PDT)
Received: from [172.16.224.217] ([209.53.90.26])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-227811da347sm19717125ad.161.2025.03.21.10.24.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 21 Mar 2025 10:24:42 -0700 (PDT)
Message-ID: <f938d297-8593-4ff9-a41d-b8811f537d05@linaro.org>
Date: Fri, 21 Mar 2025 10:24:40 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/10] gdbstub: introduce target independent gdb register
 helper
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Juan Quintela <quintela@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>, Akihiko Odaki <akihiko.odaki@daynix.com>,
 qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>,
 qemu-s390x@nongnu.org, Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Peter Xu <peterx@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Hildenbrand <david@redhat.com>, Yonggang Luo <luoyonggang@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Beraldo Leal <bleal@redhat.com>, qemu-arm@nongnu.org,
 Greg Kurz <groug@kaod.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Nicholas Piggin <npiggin@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
References: <20250319182255.3096731-1-alex.bennee@linaro.org>
 <20250319182255.3096731-3-alex.bennee@linaro.org>
 <2c441f75-8fd8-4792-a4e4-1ae7c78754ba@linaro.org>
 <1bc5463d-1e37-4a92-b43d-2d4b61cc19ff@linaro.org>
 <87ldsylins.fsf@draig.linaro.org>
Content-Language: en-US
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <87ldsylins.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x636.google.com
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

T24gMy8yMS8yNSAwNDozNiwgQWxleCBCZW5uw6llIHdyb3RlOg0KPiBQaWVycmljayBCb3V2
aWVyIDxwaWVycmljay5ib3V2aWVyQGxpbmFyby5vcmc+IHdyaXRlczoNCj4gDQo+PiBPbiAz
LzIwLzI1IDEyOjMwLCBQaWVycmljayBCb3V2aWVyIHdyb3RlOg0KPj4+IE9uIDMvMTkvMjUg
MTE6MjIsIEFsZXggQmVubsOpZSB3cm90ZToNCj4+Pj4gVGhlIGN1cnJlbnQgaGVscGVyLmgg
ZnVuY3Rpb25zIHJlbHkgb24gaGFyZCBjb2RlZCBhc3N1bXB0aW9ucyBhYm91dA0KPj4+PiB0
YXJnZXQgZW5kaWFuZXNzIHRvIHVzZSB0aGUgdHN3YXAgbWFjcm9zLiBXZSBhbHNvIGVuZCB1
cCBkb3VibGUNCj4+Pj4gc3dhcHBpbmcgYSBidW5jaCBvZiB2YWx1ZXMgaWYgdGhlIHRhcmdl
dCBjYW4gcnVuIGluIG11bHRpcGxlIGVuZGlhbmVzcw0KPj4+PiBtb2Rlcy4gQXZvaWQgdGhp
cyBieSBnZXR0aW5nIHRoZSB0YXJnZXQgdG8gcGFzcyB0aGUgZW5kaWFuZXNzIGFuZCBzaXpl
DQo+Pj4+IHZpYSBhIE1lbU9wIGFuZCBmaXhpbmcgdXAgYXBwcm9wcmlhdGVseS4NCj4+Pj4N
Cj4+Pj4gU2lnbmVkLW9mZi1ieTogQWxleCBCZW5uw6llIDxhbGV4LmJlbm5lZUBsaW5hcm8u
b3JnPg0KPj4+PiAtLS0NCj4+Pj4gICAgIGluY2x1ZGUvZ2Ric3R1Yi9yZWdpc3RlcnMuaCB8
IDMwICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKw0KPj4+PiAgICAgZ2Ric3R1Yi9n
ZGJzdHViLmMgICAgICAgICAgIHwgMjIgKysrKysrKysrKysrKysrKysrKysrKw0KPj4+PiAg
ICAgMiBmaWxlcyBjaGFuZ2VkLCA1MiBpbnNlcnRpb25zKCspDQo+Pj4+ICAgICBjcmVhdGUg
bW9kZSAxMDA2NDQgaW5jbHVkZS9nZGJzdHViL3JlZ2lzdGVycy5oDQo+Pj4+DQo+Pj4+IGRp
ZmYgLS1naXQgYS9pbmNsdWRlL2dkYnN0dWIvcmVnaXN0ZXJzLmggYi9pbmNsdWRlL2dkYnN0
dWIvcmVnaXN0ZXJzLmgNCj4+Pj4gbmV3IGZpbGUgbW9kZSAxMDA2NDQNCj4+Pj4gaW5kZXgg
MDAwMDAwMDAwMC4uNGFiYzdhNmFlNw0KPj4+PiAtLS0gL2Rldi9udWxsDQo+Pj4+ICsrKyBi
L2luY2x1ZGUvZ2Ric3R1Yi9yZWdpc3RlcnMuaA0KPj4+PiBAQCAtMCwwICsxLDMwIEBADQo+
Pj4+ICsvKg0KPj4+PiArICogR0RCIENvbW1vbiBSZWdpc3RlciBIZWxwZXJzDQo+Pj4+ICsg
Kg0KPj4+PiArICogQ29weXJpZ2h0IChjKSAyMDI1IExpbmFybyBMdGQNCj4+Pj4gKyAqDQo+
Pj4+ICsgKiBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMC1vci1sYXRlcg0KPj4+
PiArICovDQo+Pj4+ICsNCj4+Pj4gKyNpZm5kZWYgR0RCX1JFR0lTVEVSU19IDQo+Pj4+ICsj
ZGVmaW5lIEdEQl9SRUdJU1RFUlNfSA0KPj4+PiArDQo+Pj4+ICsjaW5jbHVkZSAiZXhlYy9t
ZW1vcC5oIg0KPj4+PiArDQo+Pj4+ICsvKioNCj4+Pj4gKyAqIGdkYl9nZXRfcmVnaXN0ZXJf
dmFsdWUoKSAtIGdldCByZWdpc3RlciB2YWx1ZSBmb3IgZ2RiDQo+Pj4+ICsgKiBtbzogc2l6
ZSBhbmQgZW5kaWFuIE1lbU9wDQo+Pj4+ICsgKiBidWY6IEdCeXRlQXJyYXkgdG8gc3RvcmUg
aW4gdGFyZ2V0IG9yZGVyDQo+Pj4+ICsgKiB2YWw6IHBvaW50ZXIgdG8gdmFsdWUgaW4gaG9z
dCBvcmRlcg0KPj4+PiArICoNCj4+Pj4gKyAqIFRoaXMgcmVwbGFjZXMgdGhlIHByZXZpb3Vz
IGxlZ2FjeSByZWFkIGZ1bmN0aW9ucyB3aXRoIGEgc2luZ2xlDQo+Pj4+ICsgKiBmdW5jdGlv
biB0byBoYW5kbGUgYWxsIHNpemVzLiBQYXNzaW5nIEBtbyBhbGxvd3MgdGhlIHRhcmdldCBt
b2RlIHRvDQo+Pj4+ICsgKiBiZSB0YWtlbiBpbnRvIGFjY291bnQgYW5kIGF2b2lkcyB1c2lu
ZyBoYXJkIGNvZGVkIHRzd2FwKCkgbWFjcm9zLg0KPj4+PiArICoNCj4+Pj4gKyAqIFJldHVy
bnMgdGhlIG51bWJlciBvZiBieXRlcyB3cml0dGVuIHRvIHRoZSBhcnJheS4NCj4+Pj4gKyAq
Lw0KPj4+PiAraW50IGdkYl9nZXRfcmVnaXN0ZXJfdmFsdWUoTWVtT3Agb3AsIEdCeXRlQXJy
YXkgKmJ1ZiwgdWludDhfdCAqdmFsKTsNCj4+Pj4gKw0KPj4+PiArI2VuZGlmIC8qIEdEQl9S
RUdJU1RFUlNfSCAqLw0KPj4+PiArDQo+Pj4+ICsNCj4+Pj4gZGlmZiAtLWdpdCBhL2dkYnN0
dWIvZ2Ric3R1Yi5jIGIvZ2Ric3R1Yi9nZGJzdHViLmMNCj4+Pj4gaW5kZXggMjgyZTEzZTE2
My4uM2Q3YjEwMjhlNCAxMDA2NDQNCj4+Pj4gLS0tIGEvZ2Ric3R1Yi9nZGJzdHViLmMNCj4+
Pj4gKysrIGIvZ2Ric3R1Yi9nZGJzdHViLmMNCj4+Pj4gQEAgLTMyLDYgKzMyLDcgQEANCj4+
Pj4gICAgICNpbmNsdWRlICJleGVjL2dkYnN0dWIuaCINCj4+Pj4gICAgICNpbmNsdWRlICJn
ZGJzdHViL2NvbW1hbmRzLmgiDQo+Pj4+ICAgICAjaW5jbHVkZSAiZ2Ric3R1Yi9zeXNjYWxs
cy5oIg0KPj4+PiArI2luY2x1ZGUgImdkYnN0dWIvcmVnaXN0ZXJzLmgiDQo+Pj4+ICAgICAj
aWZkZWYgQ09ORklHX1VTRVJfT05MWQ0KPj4+PiAgICAgI2luY2x1ZGUgImFjY2VsL3RjZy92
Y3B1LXN0YXRlLmgiDQo+Pj4+ICAgICAjaW5jbHVkZSAiZ2Ric3R1Yi91c2VyLmgiDQo+Pj4+
IEBAIC00NSw2ICs0Niw3IEBADQo+Pj4+ICAgICAjaW5jbHVkZSAic3lzdGVtL3J1bnN0YXRl
LmgiDQo+Pj4+ICAgICAjaW5jbHVkZSAiZXhlYy9yZXBsYXktY29yZS5oIg0KPj4+PiAgICAg
I2luY2x1ZGUgImV4ZWMvaHdhZGRyLmgiDQo+Pj4+ICsjaW5jbHVkZSAiZXhlYy9tZW1vcC5o
Ig0KPj4+PiAgICAgICAgI2luY2x1ZGUgImludGVybmFscy5oIg0KPj4+PiAgICAgQEAgLTU1
MSw2ICs1NTMsMjYgQEAgc3RhdGljIGludCBnZGJfd3JpdGVfcmVnaXN0ZXIoQ1BVU3RhdGUN
Cj4+Pj4gKmNwdSwgdWludDhfdCAqbWVtX2J1ZiwgaW50IHJlZykNCj4+Pj4gICAgICAgICBy
ZXR1cm4gMDsNCj4+Pj4gICAgIH0NCj4+Pj4gICAgICsvKg0KPj4+PiArICogVGFyZ2V0IGhl
bHBlciBmdW5jdGlvbiB0byByZWFkIHZhbHVlIGludG8gR0J5dGVBcnJheSwgdGFyZ2V0DQo+
Pj4+ICsgKiBzdXBwbGllcyB0aGUgc2l6ZSBhbmQgdGFyZ2V0IGVuZGlhbmVzcyB2aWEgdGhl
IE1lbU9wLg0KPj4+PiArICovDQo+Pj4+ICtpbnQgZ2RiX2dldF9yZWdpc3Rlcl92YWx1ZShN
ZW1PcCBvcCwgR0J5dGVBcnJheSAqYnVmLCB1aW50OF90ICp2YWwpDQo+Pj4+ICt7DQo+Pj4+
ICsgICAgc2l6ZV90IGJ5dGVzID0gbWVtb3Bfc2l6ZShvcCk7DQo+Pj4+ICsNCj4+Pj4gKyAg
ICBpZiAob3AgJiBNT19CU1dBUCkgew0KPj4+PiArICAgICAgICBmb3IgKCBpbnQgaSA9IGJ5
dGVzIDsgaSA+IDA7IGktLSkgew0KPj4+PiArICAgICAgICAgICAgZ19ieXRlX2FycmF5X2Fw
cGVuZChidWYsICZ2YWxbaSAtIDFdLCAxKTsNCj4+Pj4gKyAgICAgICAgfTsNCj4+Pj4gKyAg
ICB9IGVsc2Ugew0KPj4+PiArICAgICAgICBnX2J5dGVfYXJyYXlfYXBwZW5kKGJ1ZiwgdmFs
LCBieXRlcyk7DQo+Pj4+ICsgICAgfQ0KPj4+PiArDQo+Pj4+ICsgICAgcmV0dXJuIGJ5dGVz
Ow0KPj4+PiArfQ0KPj4+PiArDQo+Pj4+ICsNCj4+Pj4gICAgIHN0YXRpYyB2b2lkIGdkYl9y
ZWdpc3Rlcl9mZWF0dXJlKENQVVN0YXRlICpjcHUsIGludCBiYXNlX3JlZywNCj4+Pj4gICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGdkYl9nZXRfcmVnX2NiIGdldF9y
ZWcsIGdkYl9zZXRfcmVnX2NiIHNldF9yZWcsDQo+Pj4+ICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICBjb25zdCBHREJGZWF0dXJlICpmZWF0dXJlKQ0KPj4+IEl0IGNv
dWxkIGJlIHByZWZlcmFibGUgdG8gc2V0IGJ1ZiB3aXRoIHRoZSB2YWx1ZSwgaW5zdGVhZCBv
ZiBzaW1wbHkNCj4+PiBhcHBlbmRpbmcgdGhlIHZhbHVlLiBUaGlzIHdheSwgdGhlcmUgaXMg
bm8gbmVlZCB0byByZXR1cm4gdGhlIHNpemUsIGFzDQo+Pj4gaXQncyBjb250YWluZWQgaW4g
YnVmZmVyIHNpemUgaXRzZWxmLg0KPj4+IElmIHdlIGluc2lzdCBvbiByZXR1cm5pbmcgdGhl
IHNpemUsIGl0J3MgYmV0dGVyIHRvIG1ha2UgaXQgYQ0KPj4+IHBhcmFtZXRlcg0KPj4+IChh
bmQgdXNlIGEgdm9pZCBwYXJhbWV0ZXIgdHlwZSksIGJlY2F1c2UgYXQgdGhlIG1vbWVudCwg
aXQgZ2l2ZXMgdGhlDQo+Pj4gaW1wcmVzc2lvbiB0aGUgZnVuY3Rpb24gaXRzZWxmIHJldHVy
bnMgdGhlIHZhbHVlLCB3aGljaCBtYXkgYmUgY29uZnVzaW5nLg0KPj4NCj4+IFNlZW1zIGxp
a2UgaXQncyB0aGUgZXhpc3RpbmcgY29udmVudGlvbiB0aHJvdWdoDQo+PiBnZGJfc2V0X3Jl
Z19jYi9nZGJfZ2V0X3JlZ19jYiwgc28gd2UgaGF2ZSB0byBmb2xsb3cgdGhpcy4NCj4gDQo+
IEZvciB0aGUgImciIHBhY2tldCB3ZSBhcHBlbmQgbXVsdGlwbGUgcmVnaXN0ZXJzIHNvIHRo
ZSBidWZmZXIgc2l6ZSBncm93cw0KPiBhcyB3ZSBhcHBlbmQgZWFjaCBvbmUuDQo+IA0KDQpU
aGFua3MgZm9yIHNoYXJpbmcgdGhlIHJhdGlvbmFsZSBiZWhpbmQgdGhpcy4NCg==

