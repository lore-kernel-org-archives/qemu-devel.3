Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AE40C369AB
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Apr 2025 17:24:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u5pR5-00076b-Ir; Fri, 18 Apr 2025 13:23:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u5pR3-00076I-3n
 for qemu-devel@nongnu.org; Fri, 18 Apr 2025 13:23:29 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u5pQz-0007bJ-5Q
 for qemu-devel@nongnu.org; Fri, 18 Apr 2025 13:23:27 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-73712952e1cso2075945b3a.1
 for <qemu-devel@nongnu.org>; Fri, 18 Apr 2025 10:23:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744997003; x=1745601803; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=U2oSEc2YmJR5eHOqx6CTDYcA5cAqz14NqJbQhV954ng=;
 b=NTdSibRTjEi6BJqh380JYlYGUhrYuEerFmcjVTxofYFVX+pOlyTqib2DWS+UEmshZq
 TrmoyDvoDVu3vmAHoMg6ocxIzFbR7X3OBGKz9QF9UsYIL4xSJp4rZ88e9zU27wZguycI
 A52NGF0BF7jBIjayqMwUrdmiHwm4l2RQnnfUbjAIDz0P8Aw6RagP0p7vHZmaD3CR9x59
 2Q63FO6Bwf5W0AvfrWi+GMBpIKozuOSsN+MHVNUC/18VlkkcePRyT6ns1pEQnmyMDKY1
 8veB9x0Bboyq3hpytM3QpofchYDc+rvhwrzl2QDbLVOLHRS2l8GN1oQL7T84JT0BVdSG
 NSaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744997003; x=1745601803;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=U2oSEc2YmJR5eHOqx6CTDYcA5cAqz14NqJbQhV954ng=;
 b=nptzDEUX1KgcdEjXvRFjgGpZ9VlqP3+46bkoMdGhJ4oPE668DEsE1JMYjUw5hNi3bH
 vItnlPKqPfMXkiVWor6MIa4SYffHXbEzJNpQJeScnJUZ61V4lBWEFONFUuhAL/s/81Oz
 kCoOXH5wBsGaW1fjswn1rvP3Vx4F+tSEZIk96pYu1z+rER1dAvh3lAIQo1s0XtO2n7PL
 fPuWNW1yAN11y46AfHnqyU4Sx9q7/2LKbQ9eFdxYVptBx0VFgC/EmiRfv3SWn4OwsIri
 EhZ3zAgrbEd96RbHGtKNuF+iEue6JC6xZnvv2ZliuZz360gY+INPjP+tcYgfIN9IgpPl
 AIeQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXf69Ey71W5s0LfzawpiasnduGNAAs2I4TQoR0DC9/hGMx/hZGffGbIKVUBYK9BF/bkmHj9qb2unD3l@nongnu.org
X-Gm-Message-State: AOJu0YwPm02GIG2UWzaxhrWFcrAgGztJDm/cIFlx2gBePm/ZoE5a6otl
 pnwyoD1mDdTDM3VTu1sTfKHIEFSIv4U6WKDqANujNMHCChE3l0qhPqZew1JI9Lo=
X-Gm-Gg: ASbGnct6RI5i/lyA+A9WsvU8esR9Y8zg4+AevPFYMV5wHKvzAhdSkQV7d6KnhphSTn7
 DxkiIXXY5qQ9LnAzEt2aPOWOOYuRwvnEZW1g6K0sdaNj8oEEj0TF6kg6UE2YycAL6JY1YU3Dul5
 dlK34e2FqPd0AJCEABiWW8vx0EPhAMPhgXId5bxZx7jr8sk9/eG0n1xuPNHnJouxTQ1ii1NxcUH
 FLhBwTXLFYC2FdtGGeq82hAeBbf2XxsuvTuFqX2tld0E0GdN3hOHdLMhOuV0RrHox4YeG6WsinD
 8z5il8mgrow28vRu1jDxwXyfxdbTcHLRiAP6z4JQ5j5iErSqbKyjFvjZE87RSg40
X-Google-Smtp-Source: AGHT+IGo2jlDbjMM4+lEEPe+aWdBNIrUPN25XpvszKKtdBcE6ysfC2yow0ME7uvs19BRimGP/2VwFw==
X-Received: by 2002:a05:6a00:2985:b0:736:64b7:f104 with SMTP id
 d2e1a72fcca58-73dc1444626mr4469896b3a.5.1744997003334; 
 Fri, 18 Apr 2025 10:23:23 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73dbf8e4825sm1922080b3a.54.2025.04.18.10.23.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 18 Apr 2025 10:23:22 -0700 (PDT)
Message-ID: <046e2106-de39-47f1-9454-b43547716c2e@linaro.org>
Date: Fri, 18 Apr 2025 10:23:22 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 04/11] hw/arm: Register TYPE_TARGET_ARM/AARCH64_CPU
 QOM interfaces
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20250418005059.4436-1-philmd@linaro.org>
 <20250418005059.4436-5-philmd@linaro.org>
 <ac98a60e-fa76-4460-a9fa-6f95dd35814d@linaro.org>
 <dcf13faa-31e8-4ae1-9d89-1990310d207d@linaro.org>
 <dc052898-e075-4e1e-ae45-e3e47f41caae@linaro.org>
 <11f622cc-e57f-423c-91ae-6301bb3f055a@linaro.org>
 <be5d6d8f-b0df-4295-a2d3-16b5caef1eb0@linaro.org>
 <d9a95e4f-2baa-4cf4-837b-a8fc9a41bfaf@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <d9a95e4f-2baa-4cf4-837b-a8fc9a41bfaf@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x430.google.com
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

T24gNC8xOC8yNSAxMDoxMCwgUGhpbGlwcGUgTWF0aGlldS1EYXVkw6kgd3JvdGU6DQo+IE9u
IDE4LzQvMjUgMTk6MDcsIFBpZXJyaWNrIEJvdXZpZXIgd3JvdGU6DQo+PiBPbiA0LzE4LzI1
IDEwOjA0LCBQaGlsaXBwZSBNYXRoaWV1LURhdWTDqSB3cm90ZToNCj4+PiBPbiAxOC80LzI1
IDE4OjMwLCBQaWVycmljayBCb3V2aWVyIHdyb3RlOg0KPj4+PiBPbiA0LzE4LzI1IDA3OjA3
LCBQaGlsaXBwZSBNYXRoaWV1LURhdWTDqSB3cm90ZToNCj4+Pj4+IE9uIDE4LzQvMjUgMDU6
MDcsIFBpZXJyaWNrIEJvdXZpZXIgd3JvdGU6DQo+Pj4+Pj4gT24gNC8xNy8yNSAxNzo1MCwg
UGhpbGlwcGUgTWF0aGlldS1EYXVkw6kgd3JvdGU6DQo+Pj4+Pj4+IERlZmluZSB0aGUgVFlQ
RV9UQVJHRVRfQVJNX01BQ0hJTkUgYW5kIFRZUEVfVEFSR0VUX0FBUkNINjRfTUFDSElORQ0K
Pj4+Pj4+PiBRT00gaW50ZXJmYWNlIG5hbWVzIHRvIGFsbG93IG1hY2hpbmVzIHRvIGltcGxl
bWVudCB0aGVtLg0KPj4+Pj4+Pg0KPj4+Pj4+PiBTaWduZWQtb2ZmLWJ5OiBQaGlsaXBwZSBN
YXRoaWV1LURhdWTDqSA8cGhpbG1kQGxpbmFyby5vcmc+DQo+Pj4+Pj4+IC0tLQ0KPj4+Pj4+
PiAgwqDCoMKgIG1lc29uLmJ1aWxkwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgfMKgIDEgKw0KPj4+Pj4+PiAgwqDCoMKgIGluY2x1ZGUvaHcvYm9hcmRzLmjCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIHzCoCAxICsNCj4+Pj4+Pj4gIMKgwqDCoCBpbmNsdWRlL3Fl
bXUvdGFyZ2V0X2luZm8tcW9tLmggfCAxOCArKysrKysrKysrKysrKysrKysNCj4+Pj4+Pj4g
IMKgwqDCoCB0YXJnZXRfaW5mby1xb20uY8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHwg
MjQgKysrKysrKysrKysrKysrKysrKysrKysrDQo+Pj4+Pj4+ICDCoMKgwqAgNCBmaWxlcyBj
aGFuZ2VkLCA0NCBpbnNlcnRpb25zKCspDQo+Pj4+Pj4+ICDCoMKgwqAgY3JlYXRlIG1vZGUg
MTAwNjQ0IGluY2x1ZGUvcWVtdS90YXJnZXRfaW5mby1xb20uaA0KPj4+Pj4+PiAgwqDCoMKg
IGNyZWF0ZSBtb2RlIDEwMDY0NCB0YXJnZXRfaW5mby1xb20uYw0KPj4+Pj4+Pg0KPj4+Pj4+
PiBkaWZmIC0tZ2l0IGEvbWVzb24uYnVpbGQgYi9tZXNvbi5idWlsZA0KPj4+Pj4+PiBpbmRl
eCA0OWEwNTBhMjhhMy4uMTY4YjA3YjU4ODcgMTAwNjQ0DQo+Pj4+Pj4+IC0tLSBhL21lc29u
LmJ1aWxkDQo+Pj4+Pj4+ICsrKyBiL21lc29uLmJ1aWxkDQo+Pj4+Pj4+IEBAIC0zODA4LDYg
KzM4MDgsNyBAQCBjb21tb25fc3MuYWRkKHBhZ2V2YXJ5KQ0KPj4+Pj4+PiAgwqDCoMKgIHNw
ZWNpZmljX3NzLmFkZChmaWxlcygncGFnZS10YXJnZXQuYycsICdwYWdlLXZhcnktdGFyZ2V0
LmMnKSkNCj4+Pj4+Pj4gIMKgwqDCoCBjb21tb25fc3MuYWRkKGZpbGVzKCd0YXJnZXRfaW5m
by5jJykpDQo+Pj4+Pj4+ICtzeXN0ZW1fc3MuYWRkKGZpbGVzKCd0YXJnZXRfaW5mby1xb20u
YycpKQ0KPj4+Pj4+PiAgwqDCoMKgIHNwZWNpZmljX3NzLmFkZChmaWxlcygndGFyZ2V0X2lu
Zm8tc3R1Yi5jJykpDQo+Pj4+Pj4+ICDCoMKgwqAgc3ViZGlyKCdiYWNrZW5kcycpDQo+Pj4+
Pj4+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2h3L2JvYXJkcy5oIGIvaW5jbHVkZS9ody9ib2Fy
ZHMuaA0KPj4+Pj4+PiBpbmRleCAwMmY0M2FjNWQ0ZC4uYjFiYmYzYzM0ZDQgMTAwNjQ0DQo+
Pj4+Pj4+IC0tLSBhL2luY2x1ZGUvaHcvYm9hcmRzLmgNCj4+Pj4+Pj4gKysrIGIvaW5jbHVk
ZS9ody9ib2FyZHMuaA0KPj4+Pj4+PiBAQCAtNyw2ICs3LDcgQEANCj4+Pj4+Pj4gIMKgwqDC
oCAjaW5jbHVkZSAic3lzdGVtL2hvc3RtZW0uaCINCj4+Pj4+Pj4gIMKgwqDCoCAjaW5jbHVk
ZSAic3lzdGVtL2Jsb2NrZGV2LmgiDQo+Pj4+Pj4+ICDCoMKgwqAgI2luY2x1ZGUgInFhcGkv
cWFwaS10eXBlcy1tYWNoaW5lLmgiDQo+Pj4+Pj4+ICsjaW5jbHVkZSAicWVtdS90YXJnZXRf
aW5mby1xb20uaCINCj4+Pj4+Pj4gIMKgwqDCoCAjaW5jbHVkZSAicWVtdS9tb2R1bGUuaCIN
Cj4+Pj4+Pj4gIMKgwqDCoCAjaW5jbHVkZSAicW9tL29iamVjdC5oIg0KPj4+Pj4+PiAgwqDC
oMKgICNpbmNsdWRlICJody9jb3JlL2NwdS5oIg0KPj4+Pj4+PiBkaWZmIC0tZ2l0IGEvaW5j
bHVkZS9xZW11L3RhcmdldF9pbmZvLXFvbS5oIGIvaW5jbHVkZS9xZW11Lw0KPj4+Pj4+PiB0
YXJnZXRfaW5mby1xb20uaA0KPj4+Pj4+PiBuZXcgZmlsZSBtb2RlIDEwMDY0NA0KPj4+Pj4+
PiBpbmRleCAwMDAwMDAwMDAwMC4uN2ViOWI2YmQyNTQNCj4+Pj4+Pj4gLS0tIC9kZXYvbnVs
bA0KPj4+Pj4+PiArKysgYi9pbmNsdWRlL3FlbXUvdGFyZ2V0X2luZm8tcW9tLmgNCj4+Pj4+
Pj4gQEAgLTAsMCArMSwxOCBAQA0KPj4+Pj4+PiArLyoNCj4+Pj4+Pj4gKyAqIFFFTVUgYmlu
YXJ5L3RhcmdldCBBUEkgKFFPTSB0eXBlcykNCj4+Pj4+Pj4gKyAqDQo+Pj4+Pj4+ICsgKsKg
IENvcHlyaWdodCAoYykgTGluYXJvDQo+Pj4+Pj4+ICsgKg0KPj4+Pj4+PiArICogU1BEWC1M
aWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjAtb3ItbGF0ZXINCj4+Pj4+Pj4gKyAqLw0KPj4+
Pj4+PiArDQo+Pj4+Pj4+ICsjaWZuZGVmIFFFTVVfVEFSR0VUX0lORk9fUU9NX0gNCj4+Pj4+
Pj4gKyNkZWZpbmUgUUVNVV9UQVJHRVRfSU5GT19RT01fSA0KPj4+Pj4+PiArDQo+Pj4+Pj4+
ICsjZGVmaW5lIFRZUEVfVEFSR0VUX0FSTV9NQUNISU5FIFwNCj4+Pj4+Pj4gK8KgwqDCoMKg
wqDCoMKgICJ0YXJnZXQtaW5mby1hcm0tbWFjaGluZSINCj4+Pj4+Pj4gKw0KPj4+Pj4+PiAr
I2RlZmluZSBUWVBFX1RBUkdFVF9BQVJDSDY0X01BQ0hJTkUgXA0KPj4+Pj4+PiArwqDCoMKg
wqDCoMKgwqAgInRhcmdldC1pbmZvLWFhcmNoNjQtbWFjaGluZSINCj4+Pj4+Pj4gKw0KPj4+
Pj4+PiArI2VuZGlmDQo+Pj4+Pj4+IGRpZmYgLS1naXQgYS90YXJnZXRfaW5mby1xb20uYyBi
L3RhcmdldF9pbmZvLXFvbS5jDQo+Pj4+Pj4+IG5ldyBmaWxlIG1vZGUgMTAwNjQ0DQo+Pj4+
Pj4+IGluZGV4IDAwMDAwMDAwMDAwLi5kM2ZlZTU3MzYxYg0KPj4+Pj4+PiAtLS0gL2Rldi9u
dWxsDQo+Pj4+Pj4+ICsrKyBiL3RhcmdldF9pbmZvLXFvbS5jDQo+Pj4+Pj4+IEBAIC0wLDAg
KzEsMjQgQEANCj4+Pj4+Pj4gKy8qDQo+Pj4+Pj4+ICsgKiBRRU1VIGJpbmFyeS90YXJnZXQg
QVBJIChRT00gdHlwZXMpDQo+Pj4+Pj4+ICsgKg0KPj4+Pj4+PiArICrCoCBDb3B5cmlnaHQg
KGMpIExpbmFybw0KPj4+Pj4+PiArICoNCj4+Pj4+Pj4gKyAqIFNQRFgtTGljZW5zZS1JZGVu
dGlmaWVyOiBHUEwtMi4wLW9yLWxhdGVyDQo+Pj4+Pj4+ICsgKi8NCj4+Pj4+Pj4gKw0KPj4+
Pj4+PiArI2luY2x1ZGUgInFlbXUvb3NkZXAuaCINCj4+Pj4+Pj4gKyNpbmNsdWRlICJxZW11
L3RhcmdldF9pbmZvLXFvbS5oIg0KPj4+Pj4+PiArI2luY2x1ZGUgInFvbS9vYmplY3QuaCIN
Cj4+Pj4+Pj4gKw0KPj4+Pj4+PiArc3RhdGljIGNvbnN0IFR5cGVJbmZvIHRhcmdldF9pbmZv
X3R5cGVzW10gPSB7DQo+Pj4+Pj4+ICvCoMKgwqAgew0KPj4+Pj4+PiArwqDCoMKgwqDCoMKg
wqAgLm5hbWXCoMKgwqDCoMKgwqDCoMKgwqDCoCA9IFRZUEVfVEFSR0VUX0FSTV9NQUNISU5F
LA0KPj4+Pj4+PiArwqDCoMKgwqDCoMKgwqAgLnBhcmVudMKgwqDCoMKgwqDCoMKgwqAgPSBU
WVBFX0lOVEVSRkFDRSwNCj4+Pj4+Pj4gK8KgwqDCoCB9LA0KPj4+Pj4+PiArwqDCoMKgIHsN
Cj4+Pj4+Pj4gK8KgwqDCoMKgwqDCoMKgIC5uYW1lwqDCoMKgwqDCoMKgwqDCoMKgwqAgPSBU
WVBFX1RBUkdFVF9BQVJDSDY0X01BQ0hJTkUsDQo+Pj4+Pj4+ICvCoMKgwqDCoMKgwqDCoCAu
cGFyZW50wqDCoMKgwqDCoMKgwqDCoCA9IFRZUEVfSU5URVJGQUNFLA0KPj4+Pj4+PiArwqDC
oMKgIH0sDQo+Pj4+Pj4+ICt9Ow0KPj4+Pj4+PiArDQo+Pj4+Pj4+ICtERUZJTkVfVFlQRVMo
dGFyZ2V0X2luZm9fdHlwZXMpDQo+Pj4+Pj4NCj4+Pj4+PiBJZGVhbGx5LCB0aGlzIHNob3Vs
ZCBiZSBpbiB0YXJnZXQvYXJtLCBhcyB0aGlzIHR5cGUgd2lsbCBvbmx5IGJlDQo+Pj4+Pj4g
dXNlZCBieQ0KPj4+Pj4+IGJvYXJkcyBpbiBody9hcm0sIGFuZCBieSB0aGUgdGFyZ2V0X2lu
Zm8gc3BlY2lhbGl6YXRpb24uDQo+Pj4+Pg0KPj4+Pj4gTm90IHRoZSB3YXkgUU9NIHdvcmtz
LCBpbnRlcmZhY2VzIG11c3QgYmUgcmVnaXN0ZXJlZCwgd2hpY2ggaXMNCj4+Pj4+IHdoeSBJ
IHVzZSB0aGlzIGNlbnRyYWxpemVkIGZpbGUuIE90aGVyd2lzZSB3ZSBnZXQ6DQo+Pj4+Pg0K
Pj4+Pj4gJCBxZW11LXN5c3RlbS1zaDQgLU0gaGVscA0KPj4+Pj4gcWVtdS1zeXN0ZW0tc2g0
OiAtTSBoZWxwOiBtaXNzaW5nIGludGVyZmFjZSAndGFyZ2V0LWluZm8tYXJtLW1hY2hpbmUn
DQo+Pj4+PiBmb3Igb2JqZWN0ICdtYWNoaW5lJw0KPj4+Pj4NCj4+Pj4NCj4+Pj4gSWYgSSdt
IGNvcnJlY3QsIHR5cGVzIGNhbiBiZSByZWdpc3RlcmVkIGFueXdoZXJlLCBzaW5jZSB0aGV5
IHJlbHkgb24NCj4+Pj4gc3RhdGljIGluaXRpYWxpemVyLCBidXQgaW4gcWVtdS1zeXN0ZW0t
c2g0LCBody9hcm0gb3IgdGFyZ2V0L2FybSBpcyBub3QNCj4+Pj4gbGlua2VkLCBzbyBpdCBm
YWlscy4NCj4+Pj4gSSBndWVzcyB0aGlzIGlzIHRoZSBudWxsIGJvYXJkIHRoYXQgaXMgY3Jl
YXRpbmcgdGhpcyBzaXR1YXRpb24sIHNpbmNlDQo+Pj4+IGl0J3MgaW5jbHVkZWQgYnkgYWxs
IGJpbmFyaWVzLg0KPj4+DQo+Pj4gQ29ycmVjdC4NCj4+Pg0KPj4+PiBJIHNlZSB0d28gc29s
dXRpb25zIHdoaWxlIHN0aWxsIG1vdmluZyB0aG9zZSB0eXBlcyBpbiB0YXJnZXQvYXJtOg0K
Pj4+PiAtIGluY2x1ZGUgdGhpcyB0eXBlIGZpbGUgaW4gbGliY29tbW9uLCBzbyBpdCdzIGFs
d2F5cyBsaW5rZWQuDQo+Pj4+IC0gaW50cm9kdWNlIGEgbmV3IFRZUEVfVEFSR0VUX0FMTF9N
QUNISU5FLCBhbmQgYWx3YXlzIGluY2x1ZGUgaXQgaW4gbGlzdA0KPj4+PiBvZiBtYWNoaW5l
cy4gQnV0IEkgdGhpbmsgaXQncyBub3Qgc28gZ29vZCBhcyBpdCB3b3VsZCByZXF1aXJlIHRv
IGRlYWwNCj4+Pj4gd2l0aCBhIGxpc3Qgb2YgdHlwZXMgd2hlbiB3ZSB3YW50IHRvIGFjY2Vz
cyBhIG1hY2hpbmUuDQo+Pj4+DQo+Pj4+IFNvIEkgd291bGQganVzdCBtb3ZlIHRoZSBmaWxl
IGFuZCBsaW5rIGl0IGluY29uZGl0b25uYWxseSBpbiBhbGwNCj4+Pj4gYmluYXJpZXMuDQo+
Pj4NCj4+PiBXaGljaCBmaWxlPyB0YXJnZXRfaW5mby1xb20uYyBpcyBhbHJlYWR5IGluIHN5
c3RlbV9zc1tdLg0KPj4NCj4+IE1vdmUgZXhpc3RpbmcgdGFyZ2V0X2luZm8tcW9tIGluIGlu
IHRhcmdldC9hcm0vdGFyZ2V0X2luZm9fdHlwZXMuYywgYW5kDQo+PiBhZGQgaXQgdG8gc3lz
dGVtX3NzLCBpbnN0ZWFkIG9mIGFybV9zcyBvciBhcm1fY29tbW9uX3NzLCBzbyBpdCdzIGFs
d2F5cw0KPj4gbGlua2VkLg0KPiANCj4gVGhhdCBzaG91bGQgd29yaywgYnV0IHdoYXQgaXMg
dGhlIGJlbmVmaXQgb3ZlciBoYXZpbmcgYSBzaW5nbGUgZmlsZQ0KPiB3aGVyZSBhbGwgZGVm
aW5pdGlvbnMgYXJlIGNvbmNlbnRyYXRlZD8NCj4gDQoNCkxpbWl0IHdoaWNoIHR5cGVzIGFy
ZSB2aXNpYmxlIGZyb20gZXZlcnkgaHcvWCwgc28gaXQncyBleHBsaWNpdCB3aGljaCANCmFy
Y2hpdGVjdHVyZSBldmVyeSBib2FyZC9jcHUvZGV2aWNlIHdpbGwgaW1wbGVtZW50IGluIHRo
ZSBlbmQuDQpJIGRvbid0IG1pbmQgaWYgeW91IHdhbnQgdG8ga2VlcCBpdCB0aGVyZSBmb3Ig
bm93LCBpdCBkb2Vzbid0IHJlYWxseSBtYXR0ZXIuDQo=

