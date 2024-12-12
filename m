Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F02DFE7717F
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2024 19:24:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLoni-0000hX-HL; Thu, 12 Dec 2024 14:24:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tLonf-0000hL-Q4
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 14:24:39 -0500
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tLonY-0004tL-Bw
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 14:24:39 -0500
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-725c86bbae7so900848b3a.3
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2024 11:24:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734031471; x=1734636271; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=iMk5FxXmQSkmzmntzwiQD7mCAyGjVsdZdhV6Py1xSJY=;
 b=ryoQ9aKNDIb5HJ3mU00ooUDNC8ee+2kBr2w9n3we7KgBjgTKE8gnJ6wjzmL43z+W0C
 nD8jNqgtwvO8qKymAuKiWO+94hkw+eet0LalxRX5ZMPkcADQ7FO4laXaKJMV8ZyEkeQi
 BZ2kZpfwYfSZJvOSG2YYYLRgSVpxg73mIYbvZ8edcW79n0mbW1lJYYD6ftI7awy1OWdD
 LD64dBvZAdvWIAHAMGz/UP51yznSml3FF1QaNvQ5OFlXOp8z3nDtGbiZ2z0c0Fy7vrcF
 vP4iC268toCDZqomwAxCODonNJ8/pM63AK17RaBNxCADXCf7Vry/kqI9/qQ2C1PvkjN5
 b22Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734031471; x=1734636271;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=iMk5FxXmQSkmzmntzwiQD7mCAyGjVsdZdhV6Py1xSJY=;
 b=aNmCq95inqTR7RIrUlUkfkSTvF2se/N75CX4vaTIKkaQyOiNGZ5BqYW52eiEZCuoyL
 Qq8eot/xIev9zzWvKk2J8l828qDIvcdc7yoj1EUvfQAWd33IC/4Llsm2pMzi147DXCTn
 1DeHUi+6zbl30ts1pVbkrvJMc+7PoDz4i8rdZCpqRwmYwgvl/ToP40i8EMAE6L+XGOAV
 1Ur1+KPM5qzdGo8otlvOcI2KAjLqU4YKm8njXKOSUfdFqm9vS5RIjMcpZQHtmMKCV1gN
 12C42xQ8rbvLByp5dYE4//4JAiT6m4loBLrgxC0eBTTkW7mJsr3kzHgBgoWwGk6lLEl/
 plhg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV946FahnplZ+2sCGfxS0m5G9Jc2O5smL5ZwDvtRjKcArJZju0RqwANk/QU4M0Io28glsrCibe0C5RE@nongnu.org
X-Gm-Message-State: AOJu0YyPyK9wZGnzMcYqmCvo12GRR22ioWbGntQkowe4hyoLPJAmgfd8
 s7iUpfL/17gn/mgLnXyxrKLHG1Ag4Ek5PZTxAi0Op/9w7sqp0sQL2XkxX0/5QOU=
X-Gm-Gg: ASbGncusFbDj4LkPJndr1GMiSrUSmOsB7EfI/C9NRfCUQghjT8xpi3qmpaSYdbR/Jmg
 wWxZ+WRNaAZVU8oiBFXpb4kRtQQXcMIZOgbi3qQgMbC742664e/MILCJpcgQS5Gmaty4L3cDroF
 C68mlxz5cu5Ea7gwcPW0vig+el5DTLLDYel631wCBs5mAc4ASf5dp7cVov79Gw8hbUMgFuED2kE
 7HDWYgVAkSB0EnQo830h+d8R2Z9FxVF0z4FIQZnGuQUJasQG0ZvZ0eGB5yY22VIyKffCWGCokFS
 V+RMRno26JWMBFBpFwRppXjbvH+I
X-Google-Smtp-Source: AGHT+IEdxdWMehCsupf31yM0AgjbgXoA5QHH6GiBcIbduQc96SWq3MJbP+9GzEzfwXTJC+5JPC/AJw==
X-Received: by 2002:a05:6a00:ac05:b0:724:e75b:22d1 with SMTP id
 d2e1a72fcca58-72906ac9124mr1923370b3a.16.1734031470703; 
 Thu, 12 Dec 2024 11:24:30 -0800 (PST)
Received: from [192.168.1.67] (216-180-64-156.dyn.novuscom.net.
 [216.180.64.156]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-725ec158d1csm7729103b3a.91.2024.12.12.11.24.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 12 Dec 2024 11:24:30 -0800 (PST)
Message-ID: <aa8584f0-b980-43a9-9e9d-d4189b4e969e@linaro.org>
Date: Thu, 12 Dec 2024 11:24:29 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/18] accel/tcg: Move page_[un]protect() to
 'user/page-protection.h'
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
References: <20241212185341.2857-1-philmd@linaro.org>
 <20241212185341.2857-7-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20241212185341.2857-7-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42f.google.com
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

T24gMTIvMTIvMjQgMTA6NTMsIFBoaWxpcHBlIE1hdGhpZXUtRGF1ZMOpIHdyb3RlOg0KPiBT
aWduZWQtb2ZmLWJ5OiBQaGlsaXBwZSBNYXRoaWV1LURhdWTDqSA8cGhpbG1kQGxpbmFyby5v
cmc+DQo+IC0tLQ0KPiAgIGFjY2VsL3RjZy9pbnRlcm5hbC10YXJnZXQuaCAgICB8ICAxICsN
Cj4gICBpbmNsdWRlL2V4ZWMvdHJhbnNsYXRlLWFsbC5oICAgfCAgNSAtLS0tLQ0KPiAgIGlu
Y2x1ZGUvdXNlci9wYWdlLXByb3RlY3Rpb24uaCB8IDIwICsrKysrKysrKysrKysrKysrKysr
DQo+ICAgYWNjZWwvdGNnL3VzZXItZXhlYy5jICAgICAgICAgIHwgIDIgKy0NCj4gICBsaW51
eC11c2VyL2VsZmxvYWQuYyAgICAgICAgICAgfCAgMiArLQ0KPiAgIDUgZmlsZXMgY2hhbmdl
ZCwgMjMgaW5zZXJ0aW9ucygrKSwgNyBkZWxldGlvbnMoLSkNCj4gICBjcmVhdGUgbW9kZSAx
MDA2NDQgaW5jbHVkZS91c2VyL3BhZ2UtcHJvdGVjdGlvbi5oDQo+IA0KPiBkaWZmIC0tZ2l0
IGEvYWNjZWwvdGNnL2ludGVybmFsLXRhcmdldC5oIGIvYWNjZWwvdGNnL2ludGVybmFsLXRh
cmdldC5oDQo+IGluZGV4IGZlMTA5NzI0YzY4Li5hMDNjMDUzMTVhNCAxMDA2NDQNCj4gLS0t
IGEvYWNjZWwvdGNnL2ludGVybmFsLXRhcmdldC5oDQo+ICsrKyBiL2FjY2VsL3RjZy9pbnRl
cm5hbC10YXJnZXQuaA0KPiBAQCAtMzcsNiArMzcsNyBAQCB2b2lkIHBhZ2VfdGFibGVfY29u
ZmlnX2luaXQodm9pZCk7DQo+ICAgI2VuZGlmDQo+ICAgDQo+ICAgI2lmZGVmIENPTkZJR19V
U0VSX09OTFkNCj4gKyNpbmNsdWRlICJ1c2VyL3BhZ2UtcHJvdGVjdGlvbi5oIg0KPiAgIC8q
DQo+ICAgICogRm9yIHVzZXItb25seSwgcGFnZV9wcm90ZWN0IHNldHMgdGhlIHBhZ2UgcmVh
ZC1vbmx5Lg0KPiAgICAqIFNpbmNlIG1vc3QgZXhlY3V0aW9uIGlzIGFscmVhZHkgb24gcmVh
ZC1vbmx5IHBhZ2VzLCBhbmQgd2UnZCBuZWVkIHRvDQo+IGRpZmYgLS1naXQgYS9pbmNsdWRl
L2V4ZWMvdHJhbnNsYXRlLWFsbC5oIGIvaW5jbHVkZS9leGVjL3RyYW5zbGF0ZS1hbGwuaA0K
PiBpbmRleCBjNTA2NjFhMDVkNS4uMDM5NjY4ZmY4YWMgMTAwNjQ0DQo+IC0tLSBhL2luY2x1
ZGUvZXhlYy90cmFuc2xhdGUtYWxsLmgNCj4gKysrIGIvaW5jbHVkZS9leGVjL3RyYW5zbGF0
ZS1hbGwuaA0KPiBAQCAtMjUsOSArMjUsNCBAQA0KPiAgIC8qIHRyYW5zbGF0ZS1hbGwuYyAq
Lw0KPiAgIHZvaWQgdGJfY2hlY2tfd2F0Y2hwb2ludChDUFVTdGF0ZSAqY3B1LCB1aW50cHRy
X3QgcmV0YWRkcik7DQo+ICAgDQo+IC0jaWZkZWYgQ09ORklHX1VTRVJfT05MWQ0KPiAtdm9p
ZCBwYWdlX3Byb3RlY3QodGJfcGFnZV9hZGRyX3QgcGFnZV9hZGRyKTsNCj4gLWludCBwYWdl
X3VucHJvdGVjdCh0Yl9wYWdlX2FkZHJfdCBhZGRyZXNzLCB1aW50cHRyX3QgcGMpOw0KPiAt
I2VuZGlmDQo+IC0NCj4gICAjZW5kaWYgLyogVFJBTlNMQVRFX0FMTF9IICovDQo+IGRpZmYg
LS1naXQgYS9pbmNsdWRlL3VzZXIvcGFnZS1wcm90ZWN0aW9uLmggYi9pbmNsdWRlL3VzZXIv
cGFnZS1wcm90ZWN0aW9uLmgNCj4gbmV3IGZpbGUgbW9kZSAxMDA2NDQNCj4gaW5kZXggMDAw
MDAwMDAwMDAuLjQ0OGM3YTAzNDQ5DQo+IC0tLSAvZGV2L251bGwNCj4gKysrIGIvaW5jbHVk
ZS91c2VyL3BhZ2UtcHJvdGVjdGlvbi5oDQo+IEBAIC0wLDAgKzEsMjAgQEANCj4gKy8qDQo+
ICsgKiBRRU1VIHBhZ2UgcHJvdGVjdGlvbiBkZWNsYXJhdGlvbnMuDQo+ICsgKg0KPiArICog
IENvcHlyaWdodCAoYykgMjAwMyBGYWJyaWNlIEJlbGxhcmQNCj4gKyAqDQo+ICsgKiBTUERY
LUxpY2Vuc2UtSWRlbnRpZmllcjogTEdQTC0yLjErDQo+ICsgKi8NCj4gKyNpZm5kZWYgVVNF
Ul9QQUdFX1BST1RFQ1RJT05fSA0KPiArI2RlZmluZSBVU0VSX1BBR0VfUFJPVEVDVElPTl9I
DQo+ICsNCj4gKyNpZm5kZWYgQ09ORklHX1VTRVJfT05MWQ0KPiArI2Vycm9yIENhbm5vdCBp
bmNsdWRlIHRoaXMgaGVhZGVyIGZyb20gc3lzdGVtIGVtdWxhdGlvbg0KPiArI2VuZGlmDQo+
ICsNCj4gKyNpbmNsdWRlICJleGVjL3RyYW5zbGF0aW9uLWJsb2NrLmgiDQo+ICsNCj4gK3Zv
aWQgcGFnZV9wcm90ZWN0KHRiX3BhZ2VfYWRkcl90IHBhZ2VfYWRkcik7DQo+ICtpbnQgcGFn
ZV91bnByb3RlY3QodGJfcGFnZV9hZGRyX3QgYWRkcmVzcywgdWludHB0cl90IHBjKTsNCj4g
Kw0KPiArI2VuZGlmDQo+IGRpZmYgLS1naXQgYS9hY2NlbC90Y2cvdXNlci1leGVjLmMgYi9h
Y2NlbC90Y2cvdXNlci1leGVjLmMNCj4gaW5kZXggNGVkNmRkMTlmMzAuLjYzNjkzMjMwM2Ji
IDEwMDY0NA0KPiAtLS0gYS9hY2NlbC90Y2cvdXNlci1leGVjLmMNCj4gKysrIGIvYWNjZWwv
dGNnL3VzZXItZXhlYy5jDQo+IEBAIC0yNSw3ICsyNSw3IEBADQo+ICAgI2luY2x1ZGUgInFl
bXUvcmN1LmgiDQo+ICAgI2luY2x1ZGUgImV4ZWMvY3B1X2xkc3QuaCINCj4gICAjaW5jbHVk
ZSAicWVtdS9tYWluLWxvb3AuaCINCj4gLSNpbmNsdWRlICJleGVjL3RyYW5zbGF0ZS1hbGwu
aCINCj4gKyNpbmNsdWRlICJ1c2VyL3BhZ2UtcHJvdGVjdGlvbi5oIg0KPiAgICNpbmNsdWRl
ICJleGVjL3BhZ2UtcHJvdGVjdGlvbi5oIg0KPiAgICNpbmNsdWRlICJleGVjL2hlbHBlci1w
cm90by5oIg0KPiAgICNpbmNsdWRlICJxZW11L2F0b21pYzEyOC5oIg0KPiBkaWZmIC0tZ2l0
IGEvbGludXgtdXNlci9lbGZsb2FkLmMgYi9saW51eC11c2VyL2VsZmxvYWQuYw0KPiBpbmRl
eCA0NzFhMzg0YjIyMi4uNTIxZmRkZTBhYTIgMTAwNjQ0DQo+IC0tLSBhL2xpbnV4LXVzZXIv
ZWxmbG9hZC5jDQo+ICsrKyBiL2xpbnV4LXVzZXIvZWxmbG9hZC5jDQo+IEBAIC0zOTE4LDcg
KzM5MTgsNyBAQCBpbnQgbG9hZF9lbGZfYmluYXJ5KHN0cnVjdCBsaW51eF9iaW5wcm0gKmJw
cm0sIHN0cnVjdCBpbWFnZV9pbmZvICppbmZvKQ0KPiAgIH0NCj4gICANCj4gICAjaWZkZWYg
VVNFX0VMRl9DT1JFX0RVTVANCj4gLSNpbmNsdWRlICJleGVjL3RyYW5zbGF0ZS1hbGwuaCIN
Cj4gKyNpbmNsdWRlICJ1c2VyL3BhZ2UtcHJvdGVjdGlvbi5oIg0KPiAgIA0KPiAgIC8qDQo+
ICAgICogRGVmaW5pdGlvbnMgdG8gZ2VuZXJhdGUgSW50ZWwgU1ZSNC1saWtlIGNvcmUgZmls
ZXMuDQoNClJldmlld2VkLWJ5OiBQaWVycmljayBCb3V2aWVyIDxwaWVycmljay5ib3V2aWVy
QGxpbmFyby5vcmc+DQoNCg==

