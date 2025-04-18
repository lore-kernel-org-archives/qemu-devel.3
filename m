Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A373C369AB
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Apr 2025 16:30:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u5obb-00028G-DI; Fri, 18 Apr 2025 12:30:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u5obV-00022R-GP
 for qemu-devel@nongnu.org; Fri, 18 Apr 2025 12:30:13 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u5obT-0000qD-0o
 for qemu-devel@nongnu.org; Fri, 18 Apr 2025 12:30:13 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-7396f13b750so2217642b3a.1
 for <qemu-devel@nongnu.org>; Fri, 18 Apr 2025 09:30:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744993809; x=1745598609; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=SA1+85WNhXZ3S1YFYcOctUZ8tZndLOVMo/2A9wD5HGo=;
 b=Jv6JdwIJ58o9EdoCzrD2ShGVOLlnIUfAvCK0wXuvTpIMdGqOqihYEtoBdljdScZwsj
 PTU0EATT6gY3ZvX0XZZPp00WcmQIQOH8WMoGqL7KVc3YW9uyfUcIqBSQlw+KKsdI6urP
 zTTJLfV05ekzwdRHIRIHa6QHCkDX8U8dbadTNrIZyspcqHRuJmr+TnH8tYXEY6hNl9Dm
 PlSZUwPCN1kZ7erFsfyCCvOhnxqJCzbbiRvtV57z1E8J5SF/65ikxahgwoynvIZOsj5U
 j2t8cGr40WzrF2Hz5pwsvQbe16YEHkmonqlZ4pLrCR4NB33XP5ihS22p8TxSiGWJ5sh1
 aGrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744993809; x=1745598609;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=SA1+85WNhXZ3S1YFYcOctUZ8tZndLOVMo/2A9wD5HGo=;
 b=OSdtHQzE1oX5IW5gNmJOAIGV7QreHK4/YbFjOB/8t4qQn9Qtq7oFCRDaffULvBUNq4
 zuhusfbGSX1tdtBWZLPPrSworE9isjPcuH7yo3X5mO0anaYCeb5t4ATzF6XH6Io5sVAr
 V1SqFScerji9BSYlNmdHMJkZKjGVTIxgn2cFZo3Yh2pVSe9RbizFBeVM1wmbXvNZJ1Vl
 52nM1IVSL/yIfEewA1hOc4pIgHJYhn5WpGaOzbRrS8qHWD0+5ZpIxGkx505wxxFWuy24
 AFkKSvpk0kZBrfljfU30EEgfNprmrLU8rEDmVLa7OXTs5jcqJTyanaUV0L1e5LSKnKIh
 S44A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWFDaI6QJ9OChWB3iVHn2WM0InZOwzsWIwfFgeaSfhTGWZDK2fgGmobTreqNFciqEHwZNTTcWPRnK7o@nongnu.org
X-Gm-Message-State: AOJu0YwAhyFW6hTBqGiRboA1BDqRxVCzHXBX1WySoJnVxrZxfBk5YNc5
 YjG1vG9wt28zwvj+/wAGSN7Bjzi2VmtOr2E5eYVFx3UeuV0npVxHz50exjL1cWQ=
X-Gm-Gg: ASbGnct0VBChuB4A4RI9iNECNOMpJrtRBQRM7ASpwrPqbqA5fenyeStebq9PgRHGvuv
 CiKJs/P5JajqQkXdoVUTkCzkU+FmFQaH3R/WAvdFllFxh5sgvtSEVm0iB4/PrteI7hy8YVUcJCD
 7FFTa5Wqv/kWkvf3Mb5fIgwabcMpKbro/Q2FfjkHZVqYLfFUd7W8myEtUA5OAL666bV/zbTkZCm
 olY9NLSREcJl6wU4MJF83wkS4y/X3XcL4Dm1syvSZnRIT3qpUodJhaHpGoubi0JzMQBXkl0qcRB
 SLMMdAGiA5qo3ClLLQhvKbtkjZkzpKBS4KEnlJNb1k0sgT7VJjhMpQ==
X-Google-Smtp-Source: AGHT+IFVkvFvNKy4D9eL0bewXIK14u2dGqQ22ZIFtEZSjKVPT5u86rbvudccNd8cNUpskLwA2UN0eg==
X-Received: by 2002:a05:6a00:6c85:b0:736:4e02:c543 with SMTP id
 d2e1a72fcca58-73dc1497eb0mr3756332b3a.9.1744993808977; 
 Fri, 18 Apr 2025 09:30:08 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73dbf8e4932sm1861458b3a.55.2025.04.18.09.30.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 18 Apr 2025 09:30:08 -0700 (PDT)
Message-ID: <dc052898-e075-4e1e-ae45-e3e47f41caae@linaro.org>
Date: Fri, 18 Apr 2025 09:30:08 -0700
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
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <dcf13faa-31e8-4ae1-9d89-1990310d207d@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42d.google.com
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

T24gNC8xOC8yNSAwNzowNywgUGhpbGlwcGUgTWF0aGlldS1EYXVkw6kgd3JvdGU6DQo+IE9u
IDE4LzQvMjUgMDU6MDcsIFBpZXJyaWNrIEJvdXZpZXIgd3JvdGU6DQo+PiBPbiA0LzE3LzI1
IDE3OjUwLCBQaGlsaXBwZSBNYXRoaWV1LURhdWTDqSB3cm90ZToNCj4+PiBEZWZpbmUgdGhl
IFRZUEVfVEFSR0VUX0FSTV9NQUNISU5FIGFuZCBUWVBFX1RBUkdFVF9BQVJDSDY0X01BQ0hJ
TkUNCj4+PiBRT00gaW50ZXJmYWNlIG5hbWVzIHRvIGFsbG93IG1hY2hpbmVzIHRvIGltcGxl
bWVudCB0aGVtLg0KPj4+DQo+Pj4gU2lnbmVkLW9mZi1ieTogUGhpbGlwcGUgTWF0aGlldS1E
YXVkw6kgPHBoaWxtZEBsaW5hcm8ub3JnPg0KPj4+IC0tLQ0KPj4+ICDCoCBtZXNvbi5idWls
ZMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHzCoCAxICsNCj4+PiAg
wqAgaW5jbHVkZS9ody9ib2FyZHMuaMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKgIDEgKw0K
Pj4+ICDCoCBpbmNsdWRlL3FlbXUvdGFyZ2V0X2luZm8tcW9tLmggfCAxOCArKysrKysrKysr
KysrKysrKysNCj4+PiAgwqAgdGFyZ2V0X2luZm8tcW9tLmPCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCB8IDI0ICsrKysrKysrKysrKysrKysrKysrKysrKw0KPj4+ICDCoCA0IGZpbGVz
IGNoYW5nZWQsIDQ0IGluc2VydGlvbnMoKykNCj4+PiAgwqAgY3JlYXRlIG1vZGUgMTAwNjQ0
IGluY2x1ZGUvcWVtdS90YXJnZXRfaW5mby1xb20uaA0KPj4+ICDCoCBjcmVhdGUgbW9kZSAx
MDA2NDQgdGFyZ2V0X2luZm8tcW9tLmMNCj4+Pg0KPj4+IGRpZmYgLS1naXQgYS9tZXNvbi5i
dWlsZCBiL21lc29uLmJ1aWxkDQo+Pj4gaW5kZXggNDlhMDUwYTI4YTMuLjE2OGIwN2I1ODg3
IDEwMDY0NA0KPj4+IC0tLSBhL21lc29uLmJ1aWxkDQo+Pj4gKysrIGIvbWVzb24uYnVpbGQN
Cj4+PiBAQCAtMzgwOCw2ICszODA4LDcgQEAgY29tbW9uX3NzLmFkZChwYWdldmFyeSkNCj4+
PiAgwqAgc3BlY2lmaWNfc3MuYWRkKGZpbGVzKCdwYWdlLXRhcmdldC5jJywgJ3BhZ2UtdmFy
eS10YXJnZXQuYycpKQ0KPj4+ICDCoCBjb21tb25fc3MuYWRkKGZpbGVzKCd0YXJnZXRfaW5m
by5jJykpDQo+Pj4gK3N5c3RlbV9zcy5hZGQoZmlsZXMoJ3RhcmdldF9pbmZvLXFvbS5jJykp
DQo+Pj4gIMKgIHNwZWNpZmljX3NzLmFkZChmaWxlcygndGFyZ2V0X2luZm8tc3R1Yi5jJykp
DQo+Pj4gIMKgIHN1YmRpcignYmFja2VuZHMnKQ0KPj4+IGRpZmYgLS1naXQgYS9pbmNsdWRl
L2h3L2JvYXJkcy5oIGIvaW5jbHVkZS9ody9ib2FyZHMuaA0KPj4+IGluZGV4IDAyZjQzYWM1
ZDRkLi5iMWJiZjNjMzRkNCAxMDA2NDQNCj4+PiAtLS0gYS9pbmNsdWRlL2h3L2JvYXJkcy5o
DQo+Pj4gKysrIGIvaW5jbHVkZS9ody9ib2FyZHMuaA0KPj4+IEBAIC03LDYgKzcsNyBAQA0K
Pj4+ICDCoCAjaW5jbHVkZSAic3lzdGVtL2hvc3RtZW0uaCINCj4+PiAgwqAgI2luY2x1ZGUg
InN5c3RlbS9ibG9ja2Rldi5oIg0KPj4+ICDCoCAjaW5jbHVkZSAicWFwaS9xYXBpLXR5cGVz
LW1hY2hpbmUuaCINCj4+PiArI2luY2x1ZGUgInFlbXUvdGFyZ2V0X2luZm8tcW9tLmgiDQo+
Pj4gIMKgICNpbmNsdWRlICJxZW11L21vZHVsZS5oIg0KPj4+ICDCoCAjaW5jbHVkZSAicW9t
L29iamVjdC5oIg0KPj4+ICDCoCAjaW5jbHVkZSAiaHcvY29yZS9jcHUuaCINCj4+PiBkaWZm
IC0tZ2l0IGEvaW5jbHVkZS9xZW11L3RhcmdldF9pbmZvLXFvbS5oIGIvaW5jbHVkZS9xZW11
Lw0KPj4+IHRhcmdldF9pbmZvLXFvbS5oDQo+Pj4gbmV3IGZpbGUgbW9kZSAxMDA2NDQNCj4+
PiBpbmRleCAwMDAwMDAwMDAwMC4uN2ViOWI2YmQyNTQNCj4+PiAtLS0gL2Rldi9udWxsDQo+
Pj4gKysrIGIvaW5jbHVkZS9xZW11L3RhcmdldF9pbmZvLXFvbS5oDQo+Pj4gQEAgLTAsMCAr
MSwxOCBAQA0KPj4+ICsvKg0KPj4+ICsgKiBRRU1VIGJpbmFyeS90YXJnZXQgQVBJIChRT00g
dHlwZXMpDQo+Pj4gKyAqDQo+Pj4gKyAqwqAgQ29weXJpZ2h0IChjKSBMaW5hcm8NCj4+PiAr
ICoNCj4+PiArICogU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjAtb3ItbGF0ZXIN
Cj4+PiArICovDQo+Pj4gKw0KPj4+ICsjaWZuZGVmIFFFTVVfVEFSR0VUX0lORk9fUU9NX0gN
Cj4+PiArI2RlZmluZSBRRU1VX1RBUkdFVF9JTkZPX1FPTV9IDQo+Pj4gKw0KPj4+ICsjZGVm
aW5lIFRZUEVfVEFSR0VUX0FSTV9NQUNISU5FIFwNCj4+PiArwqDCoMKgwqDCoMKgwqAgInRh
cmdldC1pbmZvLWFybS1tYWNoaW5lIg0KPj4+ICsNCj4+PiArI2RlZmluZSBUWVBFX1RBUkdF
VF9BQVJDSDY0X01BQ0hJTkUgXA0KPj4+ICvCoMKgwqDCoMKgwqDCoCAidGFyZ2V0LWluZm8t
YWFyY2g2NC1tYWNoaW5lIg0KPj4+ICsNCj4+PiArI2VuZGlmDQo+Pj4gZGlmZiAtLWdpdCBh
L3RhcmdldF9pbmZvLXFvbS5jIGIvdGFyZ2V0X2luZm8tcW9tLmMNCj4+PiBuZXcgZmlsZSBt
b2RlIDEwMDY0NA0KPj4+IGluZGV4IDAwMDAwMDAwMDAwLi5kM2ZlZTU3MzYxYg0KPj4+IC0t
LSAvZGV2L251bGwNCj4+PiArKysgYi90YXJnZXRfaW5mby1xb20uYw0KPj4+IEBAIC0wLDAg
KzEsMjQgQEANCj4+PiArLyoNCj4+PiArICogUUVNVSBiaW5hcnkvdGFyZ2V0IEFQSSAoUU9N
IHR5cGVzKQ0KPj4+ICsgKg0KPj4+ICsgKsKgIENvcHlyaWdodCAoYykgTGluYXJvDQo+Pj4g
KyAqDQo+Pj4gKyAqIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4wLW9yLWxhdGVy
DQo+Pj4gKyAqLw0KPj4+ICsNCj4+PiArI2luY2x1ZGUgInFlbXUvb3NkZXAuaCINCj4+PiAr
I2luY2x1ZGUgInFlbXUvdGFyZ2V0X2luZm8tcW9tLmgiDQo+Pj4gKyNpbmNsdWRlICJxb20v
b2JqZWN0LmgiDQo+Pj4gKw0KPj4+ICtzdGF0aWMgY29uc3QgVHlwZUluZm8gdGFyZ2V0X2lu
Zm9fdHlwZXNbXSA9IHsNCj4+PiArwqDCoMKgIHsNCj4+PiArwqDCoMKgwqDCoMKgwqAgLm5h
bWXCoMKgwqDCoMKgwqDCoMKgwqDCoCA9IFRZUEVfVEFSR0VUX0FSTV9NQUNISU5FLA0KPj4+
ICvCoMKgwqDCoMKgwqDCoCAucGFyZW50wqDCoMKgwqDCoMKgwqDCoCA9IFRZUEVfSU5URVJG
QUNFLA0KPj4+ICvCoMKgwqAgfSwNCj4+PiArwqDCoMKgIHsNCj4+PiArwqDCoMKgwqDCoMKg
wqAgLm5hbWXCoMKgwqDCoMKgwqDCoMKgwqDCoCA9IFRZUEVfVEFSR0VUX0FBUkNINjRfTUFD
SElORSwNCj4+PiArwqDCoMKgwqDCoMKgwqAgLnBhcmVudMKgwqDCoMKgwqDCoMKgwqAgPSBU
WVBFX0lOVEVSRkFDRSwNCj4+PiArwqDCoMKgIH0sDQo+Pj4gK307DQo+Pj4gKw0KPj4+ICtE
RUZJTkVfVFlQRVModGFyZ2V0X2luZm9fdHlwZXMpDQo+Pg0KPj4gSWRlYWxseSwgdGhpcyBz
aG91bGQgYmUgaW4gdGFyZ2V0L2FybSwgYXMgdGhpcyB0eXBlIHdpbGwgb25seSBiZSB1c2Vk
IGJ5DQo+PiBib2FyZHMgaW4gaHcvYXJtLCBhbmQgYnkgdGhlIHRhcmdldF9pbmZvIHNwZWNp
YWxpemF0aW9uLg0KPiANCj4gTm90IHRoZSB3YXkgUU9NIHdvcmtzLCBpbnRlcmZhY2VzIG11
c3QgYmUgcmVnaXN0ZXJlZCwgd2hpY2ggaXMNCj4gd2h5IEkgdXNlIHRoaXMgY2VudHJhbGl6
ZWQgZmlsZS4gT3RoZXJ3aXNlIHdlIGdldDoNCj4gDQo+ICQgcWVtdS1zeXN0ZW0tc2g0IC1N
IGhlbHANCj4gcWVtdS1zeXN0ZW0tc2g0OiAtTSBoZWxwOiBtaXNzaW5nIGludGVyZmFjZSAn
dGFyZ2V0LWluZm8tYXJtLW1hY2hpbmUnDQo+IGZvciBvYmplY3QgJ21hY2hpbmUnDQo+IA0K
DQpJZiBJJ20gY29ycmVjdCwgdHlwZXMgY2FuIGJlIHJlZ2lzdGVyZWQgYW55d2hlcmUsIHNp
bmNlIHRoZXkgcmVseSBvbiANCnN0YXRpYyBpbml0aWFsaXplciwgYnV0IGluIHFlbXUtc3lz
dGVtLXNoNCwgaHcvYXJtIG9yIHRhcmdldC9hcm0gaXMgbm90IA0KbGlua2VkLCBzbyBpdCBm
YWlscy4NCkkgZ3Vlc3MgdGhpcyBpcyB0aGUgbnVsbCBib2FyZCB0aGF0IGlzIGNyZWF0aW5n
IHRoaXMgc2l0dWF0aW9uLCBzaW5jZSANCml0J3MgaW5jbHVkZWQgYnkgYWxsIGJpbmFyaWVz
Lg0KDQpJIHNlZSB0d28gc29sdXRpb25zIHdoaWxlIHN0aWxsIG1vdmluZyB0aG9zZSB0eXBl
cyBpbiB0YXJnZXQvYXJtOg0KLSBpbmNsdWRlIHRoaXMgdHlwZSBmaWxlIGluIGxpYmNvbW1v
biwgc28gaXQncyBhbHdheXMgbGlua2VkLg0KLSBpbnRyb2R1Y2UgYSBuZXcgVFlQRV9UQVJH
RVRfQUxMX01BQ0hJTkUsIGFuZCBhbHdheXMgaW5jbHVkZSBpdCBpbiBsaXN0IA0Kb2YgbWFj
aGluZXMuIEJ1dCBJIHRoaW5rIGl0J3Mgbm90IHNvIGdvb2QgYXMgaXQgd291bGQgcmVxdWly
ZSB0byBkZWFsIA0Kd2l0aCBhIGxpc3Qgb2YgdHlwZXMgd2hlbiB3ZSB3YW50IHRvIGFjY2Vz
cyBhIG1hY2hpbmUuDQoNClNvIEkgd291bGQganVzdCBtb3ZlIHRoZSBmaWxlIGFuZCBsaW5r
IGl0IGluY29uZGl0b25uYWxseSBpbiBhbGwgYmluYXJpZXMuDQoNCkhvdyBhYm91dCB0aGF0
Pw0K

