Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB832CEACE8
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2024 16:51:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svg5G-0005tq-Rj; Tue, 01 Oct 2024 12:50:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1svg53-0005Wf-S7
 for qemu-devel@nongnu.org; Tue, 01 Oct 2024 12:50:36 -0400
Received: from mail-oi1-x229.google.com ([2607:f8b0:4864:20::229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1svg4z-0007PG-SM
 for qemu-devel@nongnu.org; Tue, 01 Oct 2024 12:50:32 -0400
Received: by mail-oi1-x229.google.com with SMTP id
 5614622812f47-3e3a47ae905so1228491b6e.1
 for <qemu-devel@nongnu.org>; Tue, 01 Oct 2024 09:50:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727801429; x=1728406229; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=jkcBkhworWYcMilm8ZSIwau6AaivEhklfIxZmGgwXTM=;
 b=LEz+x23wBPHpIh3W9LYXhp1S6CVrxEwCRJ5BqwHa7JqZuSz+MYiP6f+e24pNaiFbLT
 /FtT1msCZCncO88PlXq0TATFCIY5vjsyAPdXWryEX7DGcfJF7665PYhsoUqQGBPTE6Gb
 OlOMTXb5PztLPDIWL5WQS4Oc6HB75tnUrI5sawhS9ubmKNZW42IC1tM+PteqYElLgozb
 i/owmhJx42daJgmvWkW5Z8GYwAXiYkIMUNDdqzLXr9U2weDnsch0Bsj42kS7BgtZesnC
 xQKAQ410B1I1ljdbcx4IyuCmEZtOm0OAR0kVvWP5CVKfufbOpnrKJvgL/tj+N3yuPhwn
 +A7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727801429; x=1728406229;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jkcBkhworWYcMilm8ZSIwau6AaivEhklfIxZmGgwXTM=;
 b=mC+T6LnR/vD7GZJP+pFVa1FjBUmHUt2f85et9WgEcHOO34rfZUZkaHZ+xdwMnhh5jI
 DqS975Q8rYu50w3UafroBgRdFRhGWKabGafblCXoWDSWbsBoYUBg9BxhrD/YJgiJSlmF
 25p12qJcwXZaoA2nKow8U4XiGS6ThadhGbKtISuek7TSHlerwmodRZYePNOci3wbyvxT
 kmzOXgKDv145PL/D2XDAT1HKpmQ2LZ0Y8dsM2XnByr6CjqN/s8G1Y01HHCRPvAGAO034
 yN2b1wZBADNsK059MRMyo/8Xc6H+tnM5ECuPAWfy4kuYL27s9eHQ1/CIHjk8fgoDJI/N
 mHMw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW7ZoVzMvxPxckwrh3NPnH0QnhQ4x7tj7Xx/3hRbgkatUJsKxUNdvWbOdgQw4I1/xFZUE0DcxCPcJte@nongnu.org
X-Gm-Message-State: AOJu0YxFbn8ObhQ+iSGXnLw8ihYxXwJ/n+315801PhhTT8UT1h2WbGs/
 en9IdZ6zpilzJPLABYOQoowGcXi3k/gLuD6FWqklcywaPNZpOEHNB0sI77iZXko=
X-Google-Smtp-Source: AGHT+IFuuDQVtj4YxIAoKPzGs9R/GhRy1nX9Rx51LLqZsz/pQ3xvXUD5Rw+Wy8X48GhHkm10Rzx9Zg==
X-Received: by 2002:a05:6808:1281:b0:3e3:9a29:3fb6 with SMTP id
 5614622812f47-3e3b40f0efcmr599725b6e.5.1727801428671; 
 Tue, 01 Oct 2024 09:50:28 -0700 (PDT)
Received: from [192.168.1.67] (216-180-64-156.dyn.novuscom.net.
 [216.180.64.156]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71b2653735csm8280635b3a.197.2024.10.01.09.50.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 01 Oct 2024 09:50:28 -0700 (PDT)
Message-ID: <ea167bba-5677-48aa-b755-a6e5d87b8399@linaro.org>
Date: Tue, 1 Oct 2024 09:50:27 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/13] hw/mips: Add cpu_is_bigendian field to BlCpuCfg
 structure
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Mahmoud Mandour <ma.mandourr@gmail.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Thomas Huth
 <thuth@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>, Jason Wang <jasowang@redhat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, Anton Johansson <anjo@rev.ng>,
 Peter Maydell <peter.maydell@linaro.org>, Huacai Chen
 <chenhuacai@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 Sven Schnelle <svens@stackframe.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 qemu-arm@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>,
 Max Filippov <jcmvbkbc@gmail.com>, Paul Burton <paulburton@kernel.org>
References: <20240930073450.33195-1-philmd@linaro.org>
 <20240930073450.33195-6-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20240930073450.33195-6-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::229;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-oi1-x229.google.com
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

T24gOS8zMC8yNCAwMDozNCwgUGhpbGlwcGUgTWF0aGlldS1EYXVkw6kgd3JvdGU6DQo+IEFk
ZCB0aGUgQmxDcHVDZmc6OmNwdV9pc19iaWdlbmRpYW4gZmllbGQsIGluaXRpYWxpemUgaXQg
aW4NCj4gbWFjaGluZSBjb2RlLiBCb290bG9hZGVyIEFQSSB1c2UgdGhlIGxkL3N0X2VuZGlh
bl9wKCkgdG8NCj4gZGlzcGF0Y2ggdG8gdGFyZ2V0IGVuZGlhbm5lc3MuDQo+IA0KPiBTaWdu
ZWQtb2ZmLWJ5OiBQaGlsaXBwZSBNYXRoaWV1LURhdWTDqSA8cGhpbG1kQGxpbmFyby5vcmc+
DQo+IC0tLQ0KPiAgIGluY2x1ZGUvaHcvbWlwcy9ib290bG9hZGVyLmggfCAgMSArDQo+ICAg
aHcvbWlwcy9ib290bG9hZGVyLmMgICAgICAgICB8IDEwICsrKysrLS0tLS0NCj4gICBody9t
aXBzL2Jvc3Rvbi5jICAgICAgICAgICAgIHwgIDIgKy0NCj4gICBody9taXBzL2Z1bG9vbmcy
ZS5jICAgICAgICAgIHwgIDIgKy0NCj4gICBody9taXBzL21hbHRhLmMgICAgICAgICAgICAg
IHwgIDIgKy0NCj4gICA1IGZpbGVzIGNoYW5nZWQsIDkgaW5zZXJ0aW9ucygrKSwgOCBkZWxl
dGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2h3L21pcHMvYm9vdGxvYWRl
ci5oIGIvaW5jbHVkZS9ody9taXBzL2Jvb3Rsb2FkZXIuaA0KPiBpbmRleCA3NDRlYjExZDBl
Li5lZjc3OGEzOGQwIDEwMDY0NA0KPiAtLS0gYS9pbmNsdWRlL2h3L21pcHMvYm9vdGxvYWRl
ci5oDQo+ICsrKyBiL2luY2x1ZGUvaHcvbWlwcy9ib290bG9hZGVyLmgNCj4gQEAgLTEzLDYg
KzEzLDcgQEANCj4gICAjaW5jbHVkZSAiZXhlYy90YXJnZXRfbG9uZy5oIg0KPiAgIA0KPiAg
IHR5cGVkZWYgc3RydWN0IGJsX2NwdV9jZmcgew0KPiArICAgIGJvb2wgY3B1X2lzX2JpZ2Vu
ZGlhbjsNCj4gICB9IEJsQ3B1Q2ZnOw0KPiAgIA0KPiAgIHZvaWQgYmxfZ2VuX2p1bXBfdG8o
Y29uc3QgQmxDcHVDZmcgKmNmZywgdm9pZCAqKnAsIHRhcmdldF91bG9uZyBqdW1wX2FkZHIp
Ow0KPiBkaWZmIC0tZ2l0IGEvaHcvbWlwcy9ib290bG9hZGVyLmMgYi9ody9taXBzL2Jvb3Rs
b2FkZXIuYw0KPiBpbmRleCBlZTFhMWM0ZjIwLi4yNThjYzVkOGM4IDEwMDY0NA0KPiAtLS0g
YS9ody9taXBzL2Jvb3Rsb2FkZXIuYw0KPiArKysgYi9ody9taXBzL2Jvb3Rsb2FkZXIuYw0K
PiBAQCAtNTgsOSArNTgsOSBAQCBzdGF0aWMgdm9pZCBzdF9ubTMyX3AoY29uc3QgQmxDcHVD
ZmcgKmNmZywgdm9pZCAqKnB0ciwgdWludDMyX3QgaW5zbikNCj4gICB7DQo+ICAgICAgIHVp
bnQxNl90ICpwID0gKnB0cjsNCj4gICANCj4gLSAgICBzdHdfcChwLCBpbnNuID4+IDE2KTsN
Cj4gKyAgICBzdHdfZW5kaWFuX3AoY2ZnLT5jcHVfaXNfYmlnZW5kaWFuLCBwLCBpbnNuID4+
IDE2KTsNCj4gICAgICAgcCsrOw0KPiAtICAgIHN0d19wKHAsIGluc24gPj4gMCk7DQo+ICsg
ICAgc3R3X2VuZGlhbl9wKGNmZy0+Y3B1X2lzX2JpZ2VuZGlhbiwgcCwgaW5zbiA+PiAwKTsN
Cj4gICAgICAgcCsrOw0KPiAgIA0KPiAgICAgICAqcHRyID0gcDsNCj4gQEAgLTc0LDcgKzc0
LDcgQEAgc3RhdGljIHZvaWQgYmxfZ2VuX25vcChjb25zdCBCbENwdUNmZyAqY2ZnLCB2b2lk
ICoqcHRyKQ0KPiAgICAgICB9IGVsc2Ugew0KPiAgICAgICAgICAgdWludDMyX3QgKnAgPSAq
cHRyOw0KPiAgIA0KPiAtICAgICAgICBzdGxfcChwLCAwKTsNCj4gKyAgICAgICAgc3RsX2Vu
ZGlhbl9wKGNmZy0+Y3B1X2lzX2JpZ2VuZGlhbiwgcCwgMCk7DQo+ICAgICAgICAgICBwKys7
DQo+ICAgICAgICAgICAqcHRyID0gcDsNCj4gICAgICAgfQ0KPiBAQCAtOTUsNyArOTUsNyBA
QCBzdGF0aWMgdm9pZCBibF9nZW5fcl90eXBlKGNvbnN0IEJsQ3B1Q2ZnICpjZmcsDQo+ICAg
ICAgIGluc24gPSBkZXBvc2l0MzIoaW5zbiwgNiwgNSwgc2hpZnQpOw0KPiAgICAgICBpbnNu
ID0gZGVwb3NpdDMyKGluc24sIDAsIDYsIGZ1bmN0KTsNCj4gICANCj4gLSAgICBzdGxfcChw
LCBpbnNuKTsNCj4gKyAgICBzdGxfZW5kaWFuX3AoY2ZnLT5jcHVfaXNfYmlnZW5kaWFuLCBw
LCBpbnNuKTsNCj4gICAgICAgcCsrOw0KPiAgIA0KPiAgICAgICAqcHRyID0gcDsNCj4gQEAg
LTExMyw3ICsxMTMsNyBAQCBzdGF0aWMgdm9pZCBibF9nZW5faV90eXBlKGNvbnN0IEJsQ3B1
Q2ZnICpjZmcsDQo+ICAgICAgIGluc24gPSBkZXBvc2l0MzIoaW5zbiwgMTYsIDUsIHJ0KTsN
Cj4gICAgICAgaW5zbiA9IGRlcG9zaXQzMihpbnNuLCAwLCAxNiwgaW1tKTsNCj4gICANCj4g
LSAgICBzdGxfcChwLCBpbnNuKTsNCj4gKyAgICBzdGxfZW5kaWFuX3AoY2ZnLT5jcHVfaXNf
YmlnZW5kaWFuLCBwLCBpbnNuKTsNCj4gICAgICAgcCsrOw0KPiAgIA0KPiAgICAgICAqcHRy
ID0gcDsNCj4gZGlmZiAtLWdpdCBhL2h3L21pcHMvYm9zdG9uLmMgYi9ody9taXBzL2Jvc3Rv
bi5jDQo+IGluZGV4IDhlMjEwODc2ZTEuLmQ0ZGQyNDJkMGQgMTAwNjQ0DQo+IC0tLSBhL2h3
L21pcHMvYm9zdG9uLmMNCj4gKysrIGIvaHcvbWlwcy9ib3N0b24uYw0KPiBAQCAtMzI1LDcg
KzMyNSw3IEBAIHR5cGVfaW5pdChib3N0b25fcmVnaXN0ZXJfdHlwZXMpDQo+ICAgDQo+ICAg
c3RhdGljIHZvaWQgZ2VuX2Zpcm13YXJlKHZvaWQgKnAsIGh3YWRkciBrZXJuZWxfZW50cnks
IGh3YWRkciBmZHRfYWRkcikNCj4gICB7DQo+IC0gICAgY29uc3QgQmxDcHVDZmcgYmxfY2Zn
ID0geyB9Ow0KPiArICAgIGNvbnN0IEJsQ3B1Q2ZnIGJsX2NmZyA9IHsgLmNwdV9pc19iaWdl
bmRpYW4gPSBUQVJHRVRfQklHX0VORElBTiB9Ow0KPiAgICAgICB1aW50NjRfdCByZWdhZGRy
Ow0KPiAgIA0KPiAgICAgICAvKiBNb3ZlIENNIEdDUnMgKi8NCj4gZGlmZiAtLWdpdCBhL2h3
L21pcHMvZnVsb29uZzJlLmMgYi9ody9taXBzL2Z1bG9vbmcyZS5jDQo+IGluZGV4IGE5ODk2
MzdkM2IuLjRmZTUxMDg4NDUgMTAwNjQ0DQo+IC0tLSBhL2h3L21pcHMvZnVsb29uZzJlLmMN
Cj4gKysrIGIvaHcvbWlwcy9mdWxvb25nMmUuYw0KPiBAQCAtMTY1LDcgKzE2NSw3IEBAIHN0
YXRpYyB1aW50NjRfdCBsb2FkX2tlcm5lbChNSVBTQ1BVICpjcHUpDQo+ICAgc3RhdGljIHZv
aWQgd3JpdGVfYm9vdGxvYWRlcihDUFVNSVBTU3RhdGUgKmVudiwgdWludDhfdCAqYmFzZSwN
Cj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHVpbnQ2NF90IGtlcm5lbF9hZGRy
KQ0KPiAgIHsNCj4gLSAgICBjb25zdCBCbENwdUNmZyBibF9jZmcgPSB7IH07DQo+ICsgICAg
Y29uc3QgQmxDcHVDZmcgYmxfY2ZnID0geyAuY3B1X2lzX2JpZ2VuZGlhbiA9IGZhbHNlIH07
DQo+ICAgICAgIHVpbnQzMl90ICpwOw0KPiAgIA0KPiAgICAgICAvKiBTbWFsbCBib290bG9h
ZGVyICovDQo+IGRpZmYgLS1naXQgYS9ody9taXBzL21hbHRhLmMgYi9ody9taXBzL21hbHRh
LmMNCj4gaW5kZXggZmM0ODVjYzg4NC4uNmU3M2M4OTZmZiAxMDA2NDQNCj4gLS0tIGEvaHcv
bWlwcy9tYWx0YS5jDQo+ICsrKyBiL2h3L21pcHMvbWFsdGEuYw0KPiBAQCAtNjI0LDcgKzYy
NCw3IEBAIHN0YXRpYyB2b2lkIGJsX3NldHVwX2d0NjQxMjBfanVtcF9rZXJuZWwodm9pZCAq
KnAsIHVpbnQ2NF90IHJ1bl9hZGRyLA0KPiAgICAgICBzdGF0aWMgY29uc3QgY2hhciBwY2lf
cGluc19jZmdbUENJX05VTV9QSU5TXSA9IHsNCj4gICAgICAgICAgIDEwLCAxMCwgMTEsIDEx
IC8qIFBJSVggSVJRUkNbQTpEXSAqLw0KPiAgICAgICB9Ow0KPiAtICAgIGNvbnN0IEJsQ3B1
Q2ZnIGJsX2NmZyA9IHsgfTsNCj4gKyAgICBjb25zdCBCbENwdUNmZyBibF9jZmcgPSB7IC5j
cHVfaXNfYmlnZW5kaWFuID0gVEFSR0VUX0JJR19FTkRJQU4gfTsNCj4gICANCj4gICAgICAg
LyogQnVzIGVuZGlhbm5lc3MgaXMgYWx3YXlzIHJldmVyc2VkICovDQo+ICAgI2lmIFRBUkdF
VF9CSUdfRU5ESUFODQoNClJldmlld2VkLWJ5OiBQaWVycmljayBCb3V2aWVyIDxwaWVycmlj
ay5ib3V2aWVyQGxpbmFyby5vcmc+DQo=

