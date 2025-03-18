Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15F28C282EC
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Mar 2025 18:14:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tubSP-0002Gp-NS; Tue, 18 Mar 2025 14:14:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tubRs-0002E7-R5
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 14:14:03 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tubRq-0000PD-TH
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 14:13:56 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-22580c9ee0aso104915565ad.2
 for <qemu-devel@nongnu.org>; Tue, 18 Mar 2025 11:13:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742321633; x=1742926433; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=lmUQbfDb36TKJU3sYGzcNnijG6zoXKkNnWbTZWel+Eg=;
 b=UIFiZvUd6yU75V9tXjvriOOnDflfK3tzyCQH1YiOwkcYBFm4hNkQRvZ1bC2Gx1FGeN
 8Wb6to5dN8Rd5gTxwu1uFo5Zdx3ktrcLphU9NPfL/hfIkwey4PsriJU+12kHnDZywFyl
 Tjs7FZtEswhj8TCsBerygc8Zb8bH0Lll/oZi53XUnNB/DZgIrpHjYsYDYlfyvWndX6AE
 epvEatcbcOPthzjrZau0TWiVJvn3szH+Un9wgQspxOHByXTByvfPbCHMulp3od33EH1j
 2MYictUL/gwBFrODBh2Vp3GVMO8vIOXNhVtQHDbb+qscUNktxVFqCbE4P2hQoAeG/K9g
 wXIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742321633; x=1742926433;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=lmUQbfDb36TKJU3sYGzcNnijG6zoXKkNnWbTZWel+Eg=;
 b=Fh6K42UUq9oCsuLdaSkcC4i665uXpi/hK0A164t8wrMGEeFL9/fs1amFcgMviMsew0
 +PQD4BBrRqiB+ndhEDxFzjXKxcbKirvsiSW+fhscR2bfsAxhTLMYOIGFg6CDd6lNNCqB
 +uoZLd9odYjSsmXZlW41kMJ+AJt09tkSOPkOHEBufUAOCy6/P0evYjSR/6rn/CPgfc4G
 xm20RHSWrt023XE09r9bXKFJv04KtKBifVRl5ncnhmlFUl/RdPKbOqScaro1Wyjhz6h3
 y0AWO4NACv8C3nJOufCP54UEVKdQeT3H82gGvQAfSIO48ShUx6+YcTMOrFk//Cu17/Ck
 OKFw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWaLB3X2pvRF71FwYlFWDI85M3KO2eJhLVGmWcxKALW7sDY1/+RWrRmhFcoPDkuNDOr1TWf+s/nq9cG@nongnu.org
X-Gm-Message-State: AOJu0Yx/ELRyJ/HWy09Gj6xvxGDHL+Nw2EQVd6oWKvlqNuU0fFXF8zMb
 iWNTKcPKqfYrfxINK7yoicA4rLe2NEMjwpDKRezfWzDXNMD4kqbYvXDSFMBjtUc=
X-Gm-Gg: ASbGncvcsKcEeYi0JRVackEEdc0sBF6SwNLvh+ptX2j9yqkNa6Upj0fF7Ws7z4/qofw
 vRBa6DY3ub0Vz2qRdY15BdEqkwjYam1rkF322DbHjX0tzTVXdGQk68wDNupawLGTvpS4SLdj7CT
 GuLfHM6XJl9MScdUqzsau6iYubKHGiFU36BF6WXYKQvBnBMv6TTXb9NuoxIiiKrApUBmBP1yRcX
 ahvCJMLIct2TgW+nqrNHWl/ey+cKckT8Q/+wM+fHt88v3+oTDIQLB1R8LPEkwvVxSrdMLejWTKW
 JnV5OZzp3qNRcSEnsncpi0eaAcNVpQTvHkgMu4iBd/SnmYV0WTZFNu0vug==
X-Google-Smtp-Source: AGHT+IGC4O6xkU9iAtNKj1qbqiWAy/fyUW5mk3mtgeMn6dcnh9ulFRbfkTwNDCZJfKmGVlCQn/E7NQ==
X-Received: by 2002:a05:6a00:4f92:b0:736:532b:7c10 with SMTP id
 d2e1a72fcca58-737223fccabmr22570526b3a.21.1742321633062; 
 Tue, 18 Mar 2025 11:13:53 -0700 (PDT)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-737116b1103sm9939246b3a.167.2025.03.18.11.13.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Mar 2025 11:13:52 -0700 (PDT)
Message-ID: <8291b89a-9e97-47e6-9ee6-fd407066c3bf@linaro.org>
Date: Tue, 18 Mar 2025 11:13:51 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/13] target/arm/cpu: remove inline stubs for aarch32
 emulation
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, qemu-arm@nongnu.org, alex.bennee@linaro.org,
 kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
References: <20250318045125.759259-1-pierrick.bouvier@linaro.org>
 <20250318045125.759259-12-pierrick.bouvier@linaro.org>
 <8a24a29c-9d2a-47c9-a183-c92242c82bd9@linaro.org>
 <CAFEAcA--jw3GmS70NTwviAEhdWeJ1UXE+ucNSkR60BXk6G8B6g@mail.gmail.com>
 <a3b61916-2466-4ec8-a4e1-567581be7a2b@linaro.org>
 <CAFEAcA9jsFqD-BR+zTzWV1V92fJqpghaOrGq1rDcdidm=R94Pw@mail.gmail.com>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <CAFEAcA9jsFqD-BR+zTzWV1V92fJqpghaOrGq1rDcdidm=R94Pw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x629.google.com
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

T24gMy8xOC8yNSAxMTowNiwgUGV0ZXIgTWF5ZGVsbCB3cm90ZToNCj4gT24gVHVlLCAxOCBN
YXIgMjAyNSBhdCAxNzo1MiwgUGllcnJpY2sgQm91dmllcg0KPiA8cGllcnJpY2suYm91dmll
ckBsaW5hcm8ub3JnPiB3cm90ZToNCj4+DQo+PiBPbiAzLzE4LzI1IDEwOjUwLCBQZXRlciBN
YXlkZWxsIHdyb3RlOg0KPj4+IE9uIFR1ZSwgMTggTWFyIDIwMjUgYXQgMTc6NDIsIFBoaWxp
cHBlIE1hdGhpZXUtRGF1ZMOpIDxwaGlsbWRAbGluYXJvLm9yZz4gd3JvdGU6DQo+Pj4+DQo+
Pj4+IE9uIDE4LzMvMjUgMDU6NTEsIFBpZXJyaWNrIEJvdXZpZXIgd3JvdGU6DQo+Pj4+PiBE
aXJlY3RseSBjb25kaXRpb24gYXNzb2NpYXRlZCBjYWxscyBpbiB0YXJnZXQvYXJtL2hlbHBl
ci5jIGZvciBub3cuDQo+Pj4+Pg0KPj4+Pj4gU2lnbmVkLW9mZi1ieTogUGllcnJpY2sgQm91
dmllciA8cGllcnJpY2suYm91dmllckBsaW5hcm8ub3JnPg0KPj4+Pj4gLS0tDQo+Pj4+PiAg
ICAgdGFyZ2V0L2FybS9jcHUuaCAgICB8IDggLS0tLS0tLS0NCj4+Pj4+ICAgICB0YXJnZXQv
YXJtL2hlbHBlci5jIHwgNiArKysrKysNCj4+Pj4+ICAgICAyIGZpbGVzIGNoYW5nZWQsIDYg
aW5zZXJ0aW9ucygrKSwgOCBkZWxldGlvbnMoLSkNCj4+Pj4+DQo+Pj4+PiBkaWZmIC0tZ2l0
IGEvdGFyZ2V0L2FybS9jcHUuaCBiL3RhcmdldC9hcm0vY3B1LmgNCj4+Pj4+IGluZGV4IDUx
YjY0MjhjZmVjLi45MjA1Y2JkZWM0MyAxMDA2NDQNCj4+Pj4+IC0tLSBhL3RhcmdldC9hcm0v
Y3B1LmgNCj4+Pj4+ICsrKyBiL3RhcmdldC9hcm0vY3B1LmgNCj4+Pj4+IEBAIC0xMjIyLDcg
KzEyMjIsNiBAQCBpbnQgYXJtX2NwdV93cml0ZV9lbGYzMl9ub3RlKFdyaXRlQ29yZUR1bXBG
dW5jdGlvbiBmLCBDUFVTdGF0ZSAqY3MsDQo+Pj4+PiAgICAgICovDQo+Pj4+PiAgICAgdm9p
ZCBhcm1fZW11bGF0ZV9maXJtd2FyZV9yZXNldChDUFVTdGF0ZSAqY3B1c3RhdGUsIGludCB0
YXJnZXRfZWwpOw0KPj4+Pj4NCj4+Pj4+IC0jaWZkZWYgVEFSR0VUX0FBUkNINjQNCj4+Pj4+
ICAgICBpbnQgYWFyY2g2NF9jcHVfZ2RiX3JlYWRfcmVnaXN0ZXIoQ1BVU3RhdGUgKmNwdSwg
R0J5dGVBcnJheSAqYnVmLCBpbnQgcmVnKTsNCj4+Pj4+ICAgICBpbnQgYWFyY2g2NF9jcHVf
Z2RiX3dyaXRlX3JlZ2lzdGVyKENQVVN0YXRlICpjcHUsIHVpbnQ4X3QgKmJ1ZiwgaW50IHJl
Zyk7DQo+Pj4+PiAgICAgdm9pZCBhYXJjaDY0X3N2ZV9uYXJyb3dfdnEoQ1BVQVJNU3RhdGUg
KmVudiwgdW5zaWduZWQgdnEpOw0KPj4+Pj4gQEAgLTEyNTQsMTMgKzEyNTMsNiBAQCBzdGF0
aWMgaW5saW5lIHVpbnQ2NF90ICpzdmVfYnN3YXA2NCh1aW50NjRfdCAqZHN0LCB1aW50NjRf
dCAqc3JjLCBpbnQgbnIpDQo+Pj4+PiAgICAgI2VuZGlmDQo+Pj4+PiAgICAgfQ0KPj4+Pj4N
Cj4+Pj4+IC0jZWxzZQ0KPj4+Pj4gLXN0YXRpYyBpbmxpbmUgdm9pZCBhYXJjaDY0X3N2ZV9u
YXJyb3dfdnEoQ1BVQVJNU3RhdGUgKmVudiwgdW5zaWduZWQgdnEpIHsgfQ0KPj4+Pj4gLXN0
YXRpYyBpbmxpbmUgdm9pZCBhYXJjaDY0X3N2ZV9jaGFuZ2VfZWwoQ1BVQVJNU3RhdGUgKmVu
diwgaW50IG8sDQo+Pj4+PiAtICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICBpbnQgbiwgYm9vbCBhKQ0KPj4+Pj4gLXsgfQ0KPj4+Pj4gLSNlbmRpZg0KPj4+Pj4g
LQ0KPj4+Pj4gICAgIHZvaWQgYWFyY2g2NF9zeW5jXzMyX3RvXzY0KENQVUFSTVN0YXRlICpl
bnYpOw0KPj4+Pj4gICAgIHZvaWQgYWFyY2g2NF9zeW5jXzY0X3RvXzMyKENQVUFSTVN0YXRl
ICplbnYpOw0KPj4+Pj4NCj4+Pj4+IGRpZmYgLS1naXQgYS90YXJnZXQvYXJtL2hlbHBlci5j
IGIvdGFyZ2V0L2FybS9oZWxwZXIuYw0KPj4+Pj4gaW5kZXggYjQ2YjJiZmZjZjMuLjc3NGUx
ZWUwMjQ1IDEwMDY0NA0KPj4+Pj4gLS0tIGEvdGFyZ2V0L2FybS9oZWxwZXIuYw0KPj4+Pj4g
KysrIGIvdGFyZ2V0L2FybS9oZWxwZXIuYw0KPj4+Pj4gQEAgLTY1NjIsNyArNjU2Miw5IEBA
IHN0YXRpYyB2b2lkIHpjcl93cml0ZShDUFVBUk1TdGF0ZSAqZW52LCBjb25zdCBBUk1DUFJl
Z0luZm8gKnJpLA0KPj4+Pj4gICAgICAgICAgKi8NCj4+Pj4+ICAgICAgICAgbmV3X2xlbiA9
IHN2ZV92cW0xX2Zvcl9lbChlbnYsIGN1cl9lbCk7DQo+Pj4+PiAgICAgICAgIGlmIChuZXdf
bGVuIDwgb2xkX2xlbikgew0KPj4+Pj4gKyNpZmRlZiBUQVJHRVRfQUFSQ0g2NA0KPj4+Pg0K
Pj4+PiBXaGF0IGFib3V0IHVzaW5nIHJ1bnRpbWUgY2hlY2sgaW5zdGVhZD8NCj4+Pj4NCj4+
Pj4gICAgIGlmIChhcm1fZmVhdHVyZSgmY3B1LT5lbnYsIEFSTV9GRUFUVVJFX0FBUkNINjQp
ICYmIG5ld19sZW4gPCBvbGRfbGVuKSB7DQo+Pj4+DQo+Pj4NCj4+PiBUaGF0IHdvdWxkIGJl
IGEgZGVhZCBjaGVjazogaXQgaXMgbm90IHBvc3NpYmxlIHRvIGdldCBoZXJlDQo+Pj4gdW5s
ZXNzIEFSTV9GRUFUVVJFX0FBUkNINjQgaXMgc2V0Lg0KPj4+DQo+Pg0KPj4gV2UgY2FuIHRo
ZW4gYXNzZXJ0IGl0LCB0byBtYWtlIHN1cmUgdGhlcmUgaXMgbm8gcmVncmVzc2lvbiBhcm91
bmQgdGhhdC4NCj4gDQo+IFdlIGhhdmUgYSBsb3Qgb2Ygd3JpdGUvcmVhZC9hY2Nlc3MgZm5z
IGZvciBBQXJjaDY0LW9ubHkgc3lzcmVncywgYW5kDQo+IHdlIGRvbid0IG5lZWQgdG8gYXNz
ZXJ0IGluIGFsbCBvZiB0aGVtIHRoYXQgdGhleSdyZSBjYWxsZWQgb25seSB3aGVuDQo+IHRo
ZSBDUFUgaGFzIEFBcmNoNjQgZW5hYmxlZC4NCj4gDQo+PiBXZSBub3cgaGF2ZSBhbm90aGVy
IGNvbnZlcnNhdGlvbiBhbmQgc29tZXRoaW5nIHRvIGRlY2lkZSBpbiBhbm90aGVyDQo+PiBm
aWxlLCBhbmQgdGhhdCdzIHdoeSBJIGNob3NlIHRvIGRvIHRoZSBtaW5pbWFsIGNoYW5nZSAo
ImlmZGVmIHRoZQ0KPj4gaXNzdWUiKSBpbnN0ZWFkIG9mIHRyeWluZyB0byBkbyBhbnkgY2hh
bmdlLg0KPiANCj4gSSB0aGluayB3ZSBjYW4gZmFpcmx5IGVhc2lseSBhdm9pZCBpZmRlZmZp
bmcgdGhlIGNhbGxzaXRlIG9mDQo+IGFhcmNoNjRfc3ZlX25hcnJvd192cSgpLiBDdXJyZW50
bHkgd2UgaGF2ZToNCj4gICAqIGEgcmVhbCB2ZXJzaW9uIG9mIHRoZSBmdW5jdGlvbiwgd2hv
c2UgZGVmaW5pdGlvbiBpcyBpbnNpZGUNCj4gICAgIGFuIGlmZGVmIFRBUkdFVF9BQVJDSDY0
IGluIHRhcmdldC9hcm0vaGVscGVyLmMNCj4gICAqIGEgc3R1YiB2ZXJzaW9uLCBpbmxpbmUg
aW4gdGhlIGNwdS5oIGhlYWRlcg0KPiANCj4gSWYgd2UgZG9uJ3Qgd2FudCB0byBoYXZlIHRo
ZSBzdHViIHZlcnNpb24gd2l0aCBpZmRlZnMsIHRoZW4gd2UgY2FuDQo+IG1vdmUgdGhlIHJl
YWwgaW1wbGVtZW50YXRpb24gb2YgdGhlIGZ1bmN0aW9uIHRvIG5vdCBiZSBpbnNpZGUgdGhl
DQo+IGlmZGVmIChtYXRjaGluZyB0aGUgZmFjdCB0aGF0IHRoZSBwcm90b3R5cGUgaXMgbm8g
bG9uZ2VyIGluc2lkZQ0KPiBhbiBpZmRlZikuIFRoZSBmdW5jdGlvbiBkb2Vzbid0IGNhbGwg
YW55IG90aGVyIGZ1bmN0aW9ucyB0aGF0IGFyZQ0KPiBUQVJHRVRfQUFSQ0g2NCBvbmx5LCBz
byBpdCBzaG91bGRuJ3QgYmUgYSAibm93IHdlIGhhdmUgdG8gbW92ZQ0KPiA1MCBvdGhlciB0
aGluZ3MiIHByb2JsZW0sIEkgaG9wZS4NCj4gDQoNCkknbGwgdHJ5IHRvIGp1c3QgbGV0IHRo
ZSBjYWxsIGJlIGRvbmUsIGFuZCBzZWUgd2hhdCBoYXBwZW5zLg0KQnV0IGlmIEkgbWVldCBh
IHJlZ3Jlc3Npb24gc29tZXdoZXJlIGluIHRhcmdldC9hcm0vKiwgSSdsbCBzaW1wbHkNCmxl
dCB0aGUgY3VycmVudCBpZmRlZiBmb3Igbm93Lg0KDQpJIHVuZGVyc3RhbmQgaXQgInNob3Vs
ZCBiZSBvayIsIGJ1dCBJIGp1c3Qgd2FudCB0byBmb2N1cyBvbiBody9hcm0sIGFuZCANCm5v
dCBzdGFydCBmdXJ0aGVyIGNoYW5nZXMgaW4gdGFyZ2V0L2FybS9oZWxwZXIuYyBhcyBhIHNp
ZGUgZWZmZWN0IG9mIA0Kc2ltcGx5IG1vdmluZyBhbiBpZmRlZiBpbiBhIGhlYWRlci4NCg0K
PiB0aGFua3MNCj4gLS0gUE1NDQoNCg==

