Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72D86C3601A
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Apr 2025 18:18:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0lcD-0000Ah-Ql; Fri, 04 Apr 2025 14:18:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u0lc1-0000AM-Fv
 for qemu-devel@nongnu.org; Fri, 04 Apr 2025 14:17:53 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u0lbw-0007Pd-Fy
 for qemu-devel@nongnu.org; Fri, 04 Apr 2025 14:17:53 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-22423adf751so24512855ad.2
 for <qemu-devel@nongnu.org>; Fri, 04 Apr 2025 11:17:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743790664; x=1744395464; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=HMuq76EgcIxXdTr2l7c58OJNDM89Omku0Rlosff6LPk=;
 b=GuiOte8vKkbtlLXtzf8r0z65bh6jCleZA/1LgqUrdnTzJg3qyi0fN54kZsdivTSNqp
 cP32wJUiNTvIf/Yq0WrbPKNqwW/11ib/8mC71kkG8jeJQyBfIeF6PkIQTwqYVC5J8P1w
 n0+HQ9gSL9wxs2odu1kU0d/jrEjae8QJdCUyWmvkNYsJt68KprfhrsmuKI9TaaOApvZ6
 Pym96xSHuHt895yid8SIZOER0LQUYYdk6hNi7kCznkz0MUXGmbw3YvDFFesHAXFpiemU
 B8gDbc9l9zEMLqF4w0KvivdeUiXUmSHBekgoKDj4/uqQXjvl1U/qyxDmwgaWixkFlDn0
 sDIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743790664; x=1744395464;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=HMuq76EgcIxXdTr2l7c58OJNDM89Omku0Rlosff6LPk=;
 b=umVcORRpo2wEB7rbMa00GrWyIaAVUr1JNpdzEIlqImk2pJNMmhtS1V/sRxRFWryGZD
 7wJI57c9qYVvh1Qiml3hE9FxFB9R36XJqAf8ErIQa8S1xDxizIgkFQBqdRU49WxgL8KQ
 lCJZ7yS2/KOt0pCMuN40dfGsX9j9cHqKKHSos66SZJ6kedX4DA7oXe9k7TzOiBc0ku+9
 11fGN1GMivTmrVLaO8ukAeBCVV39EGQIy/hW+rsxqSCVvy5EDL0hh48X8sc19MDow6HF
 HPOGGy/6Kg72gwIZGs4563tgudjorqf/jtgGy+0xsX/qsEzYFTnY4YTVWGGDOd2umMRz
 lZFw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWgufM7+bu+BxxEpcKaFMM9wjkBu3C17OpsWG6r3QC1vtO8p6xsanT2Gl36JdZ5enhSBPYZ29UEqueQ@nongnu.org
X-Gm-Message-State: AOJu0Yyo5NpykwH1C+splh7hY50bpOckQ0BaqB61KQVwt6c0BKxguXGh
 Kw59OYbd+JcOOfj7AcLqsuHWOK9lEe8LPjC3BdWnAq+PZyeNRXLMqPN0Bul5X1c=
X-Gm-Gg: ASbGncuG2hkgqHhcNP8G7ZAPf+Swbb1c02fh7axBlCYI1o8H76gosRUZmmPAMMbEKhw
 uuTJF7lWVWtQAagVe369iiSnH3dqprlIjo2XPx2tdJ3EdZXQNoU+CnNWxYivht3KWQVvlgmzrM9
 glSv03Tf9w55SUjQblF0IFUN7HnIzeckogJh7nlDyBa8E970fI2JTpQAaEhLHFUeL2/Z571vIk+
 W+FvotCdw5S3cBqbLB6yv9ewKzpLf15aHovNlNjMW+qsJXs6psODJulU7BIxp+ZoE8qD/IhVcwq
 eI/zZ0kUPB8oe7foqd/OFoNSJUoqJRC6+iRU3tX3uPwpFlti2fR1lmsqBw==
X-Google-Smtp-Source: AGHT+IHtxyEXXqKdeojIkfedEZ4tgSUuQw3Br+ZatY9MHLkmCsR17I4PRCI7Akd5m9yaprqrAtgPOw==
X-Received: by 2002:a17:902:d4cb:b0:227:e980:9190 with SMTP id
 d9443c01a7336-22a8a0b374fmr62493615ad.44.1743790664590; 
 Fri, 04 Apr 2025 11:17:44 -0700 (PDT)
Received: from [192.168.1.87] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2297877275fsm35507225ad.221.2025.04.04.11.17.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 04 Apr 2025 11:17:44 -0700 (PDT)
Message-ID: <9a042398-2131-4b5a-b9f4-abd888e7f2e3@linaro.org>
Date: Fri, 4 Apr 2025 11:17:43 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH-for-10.1 03/39] target/arm: Filter CPU types for binary
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Markus Armbruster <armbru@redhat.com>
References: <20250403235821.9909-1-philmd@linaro.org>
 <20250403235821.9909-4-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250403235821.9909-4-philmd@linaro.org>
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

T24gNC8zLzI1IDE2OjU3LCBQaGlsaXBwZSBNYXRoaWV1LURhdWTDqSB3cm90ZToNCj4gU2ln
bmVkLW9mZi1ieTogUGhpbGlwcGUgTWF0aGlldS1EYXVkw6kgPHBoaWxtZEBsaW5hcm8ub3Jn
Pg0KPiAtLS0NCj4gICB0YXJnZXQvYXJtL2NwdS5jICAgfCAyICsrDQo+ICAgdGFyZ2V0L2Fy
bS9jcHU2NC5jIHwgMiArKw0KPiAgIDIgZmlsZXMgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCsp
DQo+IA0KPiBkaWZmIC0tZ2l0IGEvdGFyZ2V0L2FybS9jcHUuYyBiL3RhcmdldC9hcm0vY3B1
LmMNCj4gaW5kZXggMzc3NzkxYzg0ZGQuLmIxYWE0ODJjNzI2IDEwMDY0NA0KPiAtLS0gYS90
YXJnZXQvYXJtL2NwdS5jDQo+ICsrKyBiL3RhcmdldC9hcm0vY3B1LmMNCj4gQEAgLTUwLDYg
KzUwLDcgQEANCj4gICAjaW5jbHVkZSAiZGlzYXMvY2Fwc3RvbmUuaCINCj4gICAjaW5jbHVk
ZSAiZnB1L3NvZnRmbG9hdC5oIg0KPiAgICNpbmNsdWRlICJjcHJlZ3MuaCINCj4gKyNpbmNs
dWRlICJxZW11L3RhcmdldF9pbmZvLXFvbS5oIg0KPiAgICNpbmNsdWRlICJ0YXJnZXQvYXJt
L2NwdS1xb20uaCINCj4gICAjaW5jbHVkZSAidGFyZ2V0L2FybS9ndGltZXIuaCINCj4gICAN
Cj4gQEAgLTI3NTksNiArMjc2MCw3IEBAIHZvaWQgYXJtX2NwdV9yZWdpc3Rlcihjb25zdCBB
Uk1DUFVJbmZvICppbmZvKQ0KPiAgICAgICAgICAgLmluc3RhbmNlX2luaXQgPSBhcm1fY3B1
X2luc3RhbmNlX2luaXQsDQo+ICAgICAgICAgICAuY2xhc3NfaW5pdCA9IGluZm8tPmNsYXNz
X2luaXQgPzogY3B1X3JlZ2lzdGVyX2NsYXNzX2luaXQsDQo+ICAgICAgICAgICAuY2xhc3Nf
ZGF0YSA9ICh2b2lkICopaW5mbywNCj4gKyAgICAgICAgLmludGVyZmFjZXMgPSBMRUdBQ1lf
QklOQVJZX1FFTVVfU1lTVEVNX0FSTV9JTlRFUkZBQ0UsDQo+ICAgICAgIH07DQo+ICAgDQo+
ICAgICAgIHR5cGVfaW5mby5uYW1lID0gZ19zdHJkdXBfcHJpbnRmKCIlcy0iIFRZUEVfQVJN
X0NQVSwgaW5mby0+bmFtZSk7DQo+IGRpZmYgLS1naXQgYS90YXJnZXQvYXJtL2NwdTY0LmMg
Yi90YXJnZXQvYXJtL2NwdTY0LmMNCj4gaW5kZXggODE4OGVkZTVjYzguLjlmOGM5ODU2M2Fj
IDEwMDY0NA0KPiAtLS0gYS90YXJnZXQvYXJtL2NwdTY0LmMNCj4gKysrIGIvdGFyZ2V0L2Fy
bS9jcHU2NC5jDQo+IEBAIC0yNCw2ICsyNCw3IEBADQo+ICAgI2luY2x1ZGUgImNwcmVncy5o
Ig0KPiAgICNpbmNsdWRlICJxZW11L21vZHVsZS5oIg0KPiAgICNpbmNsdWRlICJxZW11L3Vu
aXRzLmgiDQo+ICsjaW5jbHVkZSAicWVtdS90YXJnZXRfaW5mby1xb20uaCINCj4gICAjaW5j
bHVkZSAic3lzdGVtL2t2bS5oIg0KPiAgICNpbmNsdWRlICJzeXN0ZW0vaHZmLmgiDQo+ICAg
I2luY2x1ZGUgInN5c3RlbS9xdGVzdC5oIg0KPiBAQCAtODU2LDYgKzg1Nyw3IEBAIHZvaWQg
YWFyY2g2NF9jcHVfcmVnaXN0ZXIoY29uc3QgQVJNQ1BVSW5mbyAqaW5mbykNCj4gICAgICAg
ICAgIC5pbnN0YW5jZV9pbml0ID0gYWFyY2g2NF9jcHVfaW5zdGFuY2VfaW5pdCwNCj4gICAg
ICAgICAgIC5jbGFzc19pbml0ID0gaW5mby0+Y2xhc3NfaW5pdCA/OiBjcHVfcmVnaXN0ZXJf
Y2xhc3NfaW5pdCwNCj4gICAgICAgICAgIC5jbGFzc19kYXRhID0gKHZvaWQgKilpbmZvLA0K
PiArICAgICAgICAuaW50ZXJmYWNlcyA9IExFR0FDWV9CSU5BUllfUUVNVV9TWVNURU1fQUFS
Q0g2NF9JTlRFUkZBQ0UsDQo+ICAgICAgIH07DQo+ICAgDQo+ICAgICAgIHR5cGVfaW5mby5u
YW1lID0gZ19zdHJkdXBfcHJpbnRmKCIlcy0iIFRZUEVfQVJNX0NQVSwgaW5mby0+bmFtZSk7
DQoNCkkgd291bGQgc3RpY2sgdG8gc3BlY2lmaWMgQ1BVIGludGVyZmFjZSB0eXBlLCBpbnN0
ZWFkIG9mIHVzaW5nIGFueSANClNZU1RFTV9BQVJDSDY0IHR5cGUuDQoNClRZUEVfVEFSR0VU
X0NQVV9BUk0sIFRZUEVfVEFSR0VUX0NQVV9BQVJDSDY0Lg0KQW5kIGZvciBtYWNoaW5lczoN
ClRZUEVfVEFSR0VUX01BQ0hJTkVfQVJNLCBUWVBFX1RBUkdFVF9NQUNISU5FX0FBUkNINjQu
DQo=

