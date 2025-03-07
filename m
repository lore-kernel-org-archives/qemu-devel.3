Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4DF7C19F32
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Mar 2025 19:31:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqdNd-0006GN-Lf; Fri, 07 Mar 2025 14:29:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tqdNU-00063T-Hn
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 14:29:00 -0500
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tqdNS-0003L6-QJ
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 14:29:00 -0500
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-223959039f4so47763745ad.3
 for <qemu-devel@nongnu.org>; Fri, 07 Mar 2025 11:28:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741375737; x=1741980537; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ZBji9SLm1n6gDqgXrnNplLSDlPNW6hnguse0rOotRF0=;
 b=Kny357dQq2SlkBceasnxrcX6GPNVrMG9ZQ2DvcELy9A1IvHMyRAF5m5Gx+pXf1pLU1
 vQKcAow+/Sv7YB9ziBLoG+aciKqmFRTmmrnpiqlaKbUnsam8DoxSdAKh9O+fMgXSFnP5
 8+ocE31Xj0LMvbw4a1PjHN4sK+EV5NrzLUc46jo6B26TssAOZ2SI8JsTKJOaxcBds6nG
 OcYtcBp9kkMWwZujAj7xixYXhtAa6dgWBiVTneJVW1qEzB3Ec94A2uH/zASVT26CAXBT
 9qiawNY12oF9Fkg3n8qxcTQjFq/mtmWVdb5oRw8V7KCG9FoujGzD4jfNU+hl7rLemLGJ
 /jHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741375737; x=1741980537;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ZBji9SLm1n6gDqgXrnNplLSDlPNW6hnguse0rOotRF0=;
 b=jCQTaJDeP2+6kia7lJ/iP8GRDpgMLR9xbKW/Gfzw2VDGkdz2OQUjebTRoiC02TvZtQ
 kr4i4raL1bBEqa0WJvpdUL1QBUj34GiLeSwXqe7O11T+PbnuiA1ggK+lSl07gyo35A81
 IwAw6fDh8K0lcHooqVDmBMxvJmNiHqSldkpgSiBIlrNVEmtZXqcnnbJUPIIsC1vYh+yH
 WibtgV8Li2AcKTW2iR0gKAsZhnVB58CCvoBhrQvyfJx0nECT69b88V7zeBPcs3mTqhnN
 tNmU+hTWTf5uBAmH0p+542vHVvVEUBkYteoGlbilkNSVfzjH/fxPNUz/UY0LoWOVI8PG
 6ShA==
X-Gm-Message-State: AOJu0YwVCU6We0YdbfgkQeBEP02o3en88L11Nvg99ZejWfhxI0mRsOIt
 W6yLgXTKGcC3BOC4J/yi5f0YlLN++2fJAsbMsKyRD2AcUrPO2i57veKfvGAzSk8=
X-Gm-Gg: ASbGncsDJbL1NKQl+STXui8C4VCHKCQnDeT0ssydMNDUKmnR39EYz7KbJq6m5HHzElx
 asU8W9MPsKXSv4oDVkx41ioXT4qE9k7M7S5cENUp2mIA+nbbLen7plKFtoR20MLEERpCijDp+nZ
 WVolRAkCGjWhVmoZG7+DTk8IT3PZmS4Rd6at98rrXeakpvTrpZHhYMyqFbJ1M9s8FxI9HnUpPCB
 H8CrhLsXFvgEbUwKdQOEH+hpf+tejq9Gpo9m9hzHPDGvfpImniPMHp8gMRMYAzEXRV27kKtrPVi
 YPfKIiPHhuHnMqm092v2tO3V6hNquXxrBJdwSRsIz7K7Q+Mlub7o/ym7VA==
X-Google-Smtp-Source: AGHT+IGAkRqc/S6geMQJVVSb/CDCz7aKF/qEaSkupYYZXWxqMLJd4OBa1CsE1ZVBoS914Z9OLi7PVw==
X-Received: by 2002:a17:903:2b0f:b0:21f:8453:7484 with SMTP id
 d9443c01a7336-22428a9d15dmr66825375ad.30.1741375737316; 
 Fri, 07 Mar 2025 11:28:57 -0800 (PST)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-224109ddcd9sm34015835ad.10.2025.03.07.11.28.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 07 Mar 2025 11:28:56 -0800 (PST)
Message-ID: <bb567f0a-ed7a-4861-a7bd-fda95f2ae7ce@linaro.org>
Date: Fri, 7 Mar 2025 11:28:56 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/7] hw/virtio/virtio-mem: Convert
 VIRTIO_MEM_USABLE_EXTENT to runtime
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Ani Sinha <anisinha@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Thomas Huth <thuth@redhat.com>
References: <20250307151543.8156-1-philmd@linaro.org>
 <20250307151543.8156-6-philmd@linaro.org> <877c503ie6.fsf@draig.linaro.org>
 <a7126584-00fa-42ed-8e5c-d27d9933ac2f@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <a7126584-00fa-42ed-8e5c-d27d9933ac2f@linaro.org>
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

T24gMy83LzI1IDA4OjQ5LCBQaGlsaXBwZSBNYXRoaWV1LURhdWTDqSB3cm90ZToNCj4gT24g
Ny8zLzI1IDE3OjM4LCBBbGV4IEJlbm7DqWUgd3JvdGU6DQo+PiBQaGlsaXBwZSBNYXRoaWV1
LURhdWTDqSA8cGhpbG1kQGxpbmFyby5vcmc+IHdyaXRlczoNCj4+DQo+Pj4gVXNlIHFlbXVf
YXJjaF9hdmFpbGFibGUoKSB0byBjaGVjayBhdCBydW50aW1lIGlmIGEgdGFyZ2V0DQo+Pj4g
YXJjaGl0ZWN0dXJlIGlzIGJ1aWx0IGluLg0KPj4+DQo+Pj4gU2lnbmVkLW9mZi1ieTogUGhp
bGlwcGUgTWF0aGlldS1EYXVkw6kgPHBoaWxtZEBsaW5hcm8ub3JnPg0KPj4+IC0tLQ0KPj4+
ICAgIGh3L3ZpcnRpby92aXJ0aW8tbWVtLmMgfCAyMCArKysrKysrKysrKystLS0tLS0tLQ0K
Pj4+ICAgIDEgZmlsZSBjaGFuZ2VkLCAxMiBpbnNlcnRpb25zKCspLCA4IGRlbGV0aW9ucygt
KQ0KPj4+DQo+Pj4gZGlmZiAtLWdpdCBhL2h3L3ZpcnRpby92aXJ0aW8tbWVtLmMgYi9ody92
aXJ0aW8vdmlydGlvLW1lbS5jDQo+Pj4gaW5kZXggNWY1N2VjY2JiNjYuLjhjNDAwNDIxMDhj
IDEwMDY0NA0KPj4+IC0tLSBhL2h3L3ZpcnRpby92aXJ0aW8tbWVtLmMNCj4+PiArKysgYi9o
dy92aXJ0aW8vdmlydGlvLW1lbS5jDQo+Pj4gQEAgLTE1LDYgKzE1LDcgQEANCj4+PiAgICAj
aW5jbHVkZSAicWVtdS9jdXRpbHMuaCINCj4+PiAgICAjaW5jbHVkZSAicWVtdS9lcnJvci1y
ZXBvcnQuaCINCj4+PiAgICAjaW5jbHVkZSAicWVtdS91bml0cy5oIg0KPj4+ICsjaW5jbHVk
ZSAic3lzdGVtL2FyY2hfaW5pdC5oIg0KPj4+ICAgICNpbmNsdWRlICJzeXN0ZW0vbnVtYS5o
Ig0KPj4+ICAgICNpbmNsdWRlICJzeXN0ZW0vc3lzdGVtLmgiDQo+Pj4gICAgI2luY2x1ZGUg
InN5c3RlbS9yZXNldC5oIg0KPj4+IEBAIC0xNzAsMTMgKzE3MSwxNiBAQCBzdGF0aWMgYm9v
bCB2aXJ0aW9fbWVtX2hhc19zaGFyZWRfemVyb3BhZ2UoUkFNQmxvY2sgKnJiKQ0KPj4+ICAg
ICAqIG5lY2Vzc2FyeSAoYXMgdGhlIHNlY3Rpb24gc2l6ZSBjYW4gY2hhbmdlKS4gQnV0IGl0
J3MgbW9yZSBsaWtlbHkgdGhhdCB0aGUNCj4+PiAgICAgKiBzZWN0aW9uIHNpemUgd2lsbCBy
YXRoZXIgZ2V0IHNtYWxsZXIgYW5kIG5vdCBiaWdnZXIgb3ZlciB0aW1lLg0KPj4+ICAgICAq
Lw0KPj4+IC0jaWYgZGVmaW5lZChUQVJHRVRfWDg2XzY0KSB8fCBkZWZpbmVkKFRBUkdFVF9J
Mzg2KSB8fCBkZWZpbmVkKFRBUkdFVF9TMzkwWCkNCj4+PiAtI2RlZmluZSBWSVJUSU9fTUVN
X1VTQUJMRV9FWFRFTlQgKDIgKiAoMTI4ICogTWlCKSkNCj4+PiAtI2VsaWYgZGVmaW5lZChU
QVJHRVRfQVJNKQ0KPj4+IC0jZGVmaW5lIFZJUlRJT19NRU1fVVNBQkxFX0VYVEVOVCAoMiAq
ICg1MTIgKiBNaUIpKQ0KPj4+IC0jZWxzZQ0KPj4+IC0jZXJyb3IgVklSVElPX01FTV9VU0FC
TEVfRVhURU5UIG5vdCBkZWZpbmVkDQo+Pj4gLSNlbmRpZg0KPj4+ICtzdGF0aWMgdWludDY0
X3QgdmlydGlvX21lbV91c2FibGVfZXh0ZW50X3NpemUodm9pZCkNCj4+PiArew0KPj4+ICsg
ICAgaWYgKHFlbXVfYXJjaF9hdmFpbGFibGUoUUVNVV9BUkNIX0kzODYgfCBRRU1VX0FSQ0hf
UzM5MFgpKSB7DQo+Pj4gKyAgICAgICAgcmV0dXJuIDIgKiAxMjggKiBNaUI7DQo+Pj4gKyAg
ICB9IGVsc2UgaWYgKHFlbXVfYXJjaF9hdmFpbGFibGUoUUVNVV9BUkNIX0FSTSkpIHsNCj4+
PiArICAgICAgICByZXR1cm4gMiAqIDUxMiAqIE1pQjsNCj4+PiArICAgIH0gZWxzZSB7DQo+
Pj4gKyAgICAgICAgZ19hc3NlcnRfbm90X3JlYWNoZWQoKTsNCj4+PiArICAgIH0NCj4+PiAr
fQ0KPj4NCj4+IFdoYXQgaGFwcGVucyBpZi93aGVuIHdlIGhhdmUgbXVsdGlwbGUgYXJjaGVz
IGF2YWlsYWJsZT8gV29uJ3Qgd2Ugd2FudCB0bw0KPj4ga25vdyB3aGljaCBDUFUgdGhlIHZp
cnRpby1tZW0gZGV2aWNlIGlzIGF0dGFjaGVkIHRvIG9yIGRvIHdlIHRha2UgdGhlDQo+PiBt
aW5pbWFsIHZhbHVlIG92ZXIgdGhlIHdob2xlIHN5c3RlbT8NCj4gDQo+ICJwZXIgYXR0YWNo
ZWQgdmNwdSIgaXMgaG93IEkgd2FzIHByZXZpb3VzbHkgY29uc2lkZXJpbmcgdGhpcyBwcm9i
bGVtLA0KPiBidXQgSUlVQyBmcm9tIHRoZSBkaXNjdXNzaW9ucyB3aXRoIFBpZXJyaWNrLCB3
ZSBzaG91bGQgY29uc2lkZXIgc2luZ2xlDQo+IGJpbmFyeSBhcyBhIGZpcnN0IHN0ZXAgYmVm
b3JlIGhldGVyb2dlbmVvdXMgZW11bGF0aW9uLg0KPiANCg0KSSB0aGluayBpdCdzIHNhZmUg
dG8gYXNzdW1lIG9ubHkgYSBzaW5nbGUgYXJjaCBpcyBlbmFibGUgZm9yIG5vdywgaW4gdGhl
IA0KY29udGV4dCBvZiB0aGUgc2luZ2xlIGJpbmFyeS4NCkEgdGhpbmcgd2UgY291bGQgZG8g
aXMgaW50cm9kdWNlIHFlbXVfYXJjaF9oZXRlcm9nZW5lbm91c19lbXVsYXRpb24oKSwgDQp0
aGF0IHJldHVybnMgZmFsc2UgZm9yIG5vdy4gQW5kIGFzc2VydCB0aGlzIGluIHBsYWNlcyB0
aGF0IHdpbGwgbmVlZCB0byANCmJlIGNoYW5nZWQuIFNvIHNwb3RzIHRoYXQgd2lsbCBuZWVk
IHJlZmFjdG9yaW5nIHdpbGwgYWxyZWFkeSBiZSBmbGFnZ2VkIA0KaW4gdGhlIGNvZGViYXNl
Lg0KDQpSZXZpZXdlZC1ieTogUGllcnJpY2sgQm91dmllciA8cGllcnJpY2suYm91dmllckBs
aW5hcm8ub3JnPg0KDQo+IElmIHlvdSB0aGluayB0aGUgbWluaW1hbCB2YWx1ZSBpcyBnb29k
IGVub3VnaCwgdGhlbiB0aGF0J2QgYmUgbXkNCj4gcHJlZmVycmVkIGNob2ljZSwgYXMgdGhl
IHNpbXBsZXN0IHRvIGltcGxlbWVudC4NCj4gDQo+Pg0KPj4+ICAgIA0KPj4+ICAgIHN0YXRp
YyBib29sIHZpcnRpb19tZW1faXNfYnVzeSh2b2lkKQ0KPj4+ICAgIHsNCj4+PiBAQCAtNzIx
LDcgKzcyNSw3IEBAIHN0YXRpYyB2b2lkIHZpcnRpb19tZW1fcmVzaXplX3VzYWJsZV9yZWdp
b24oVmlydElPTUVNICp2bWVtLA0KPj4+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgYm9vbCBjYW5fc2hyaW5rKQ0KPj4+ICAgIHsNCj4+PiAgICAg
ICAgdWludDY0X3QgbmV3c2l6ZSA9IE1JTihtZW1vcnlfcmVnaW9uX3NpemUoJnZtZW0tPm1l
bWRldi0+bXIpLA0KPj4+IC0gICAgICAgICAgICAgICAgICAgICAgICAgICByZXF1ZXN0ZWRf
c2l6ZSArIFZJUlRJT19NRU1fVVNBQkxFX0VYVEVOVCk7DQo+Pj4gKyAgICAgICAgICAgICAg
ICAgICAgICAgICAgIHJlcXVlc3RlZF9zaXplICsgdmlydGlvX21lbV91c2FibGVfZXh0ZW50
X3NpemUoKSk7DQo+Pj4gICAgDQo+Pj4gICAgICAgIC8qIFRoZSB1c2FibGUgcmVnaW9uIHNp
emUgYWx3YXlzIGhhcyB0byBiZSBtdWx0aXBsZXMgb2YgdGhlIGJsb2NrIHNpemUuICovDQo+
Pj4gICAgICAgIG5ld3NpemUgPSBRRU1VX0FMSUdOX1VQKG5ld3NpemUsIHZtZW0tPmJsb2Nr
X3NpemUpOw0KPj4NCj4gDQoNCg==

