Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3742FC36010
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Apr 2025 17:13:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0ka8-0003Wk-Hg; Fri, 04 Apr 2025 13:11:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u0kZX-0002Rc-M8
 for qemu-devel@nongnu.org; Fri, 04 Apr 2025 13:11:19 -0400
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u0kZN-0005pX-My
 for qemu-devel@nongnu.org; Fri, 04 Apr 2025 13:11:14 -0400
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-af52a624283so1895207a12.0
 for <qemu-devel@nongnu.org>; Fri, 04 Apr 2025 10:11:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743786663; x=1744391463; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=w19/DO+s+/jVWa0K92sDwLvUVQbZt6fZ3TEOIehILR4=;
 b=K7hef7A1MtXTnTdbCiFMYvD0tGpuiPEmNZbaUj9jxRcEdVJCTj9wEsdbMqZxJLyN86
 zHgSg2DhDMNPZET+t4CsgHnabh7dXTb7/P+FyDCLSR1px649Rabc8hsX4lE2V88C30lk
 R/Rw52JUsA/2g9NefXtyAbJ/fSK6+pIBfQZuFf4zlTYDWCpJ1/2/8BVDDM0AA3rORDpX
 gM6bC6iY3+kcQxtl/wX82ixP4EE9kbDBwTVJMfzp2MMW5meDICDhKNeCwOOTemf1SPZI
 YVoVvdXfFnxsUwn/RBnxLz0nTsECY1/tV+caHt7IbbKmClt8DaJ45gd2ioQfJj/NaBcZ
 LZcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743786663; x=1744391463;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=w19/DO+s+/jVWa0K92sDwLvUVQbZt6fZ3TEOIehILR4=;
 b=ZCQPbkeuhBYt70RsvxgN7hdRPfYf/OtdRAkOhg3M/IPo6GHCNN0SOE9feCZoUPA9AD
 RIvg5FSYJynuIZF5cviSFxyR84caOPxiXVS2jqXj+sgA7ohMHYa/A6Qzez/byzO1mGsY
 vjnUvtbjtQX0P2c62XjkAUEwdE5CeABY0EJxBuf6S1KLt8Jm+x/gHYQDn0LkPOSoAPP+
 h5VbW43L9h9XdZ5CHumHMn6WBCvK2VNwLVGFyfirtSl2zdV8YfmqVWuCoAQsan1V6ro4
 9WPHiy2CKW5e89dQ/kgDV0NOD5koLC6nRDKG1wp72InSdqRafC3MOqoNDHbmIE81tA4Y
 zzIw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX4PrRliSEnLFk9vB7krYpr/X6ha0D+I5nX70zMwRzLbtVVGZGpotB+in5xL5TGZq1gGebEOwVsG7zX@nongnu.org
X-Gm-Message-State: AOJu0Yy16cRsMXHZTDuoiUeW6Nj3TtvTi/WNA6cEZ2/J94Du1a7EmDQO
 oGEfvgYYIjCH8mjgOkqg6VxADcPWDUb6TXR0n9dx88++DY5Mqg80kQ+yNuOQCXY=
X-Gm-Gg: ASbGncu0xYqyLfSlSzHgMCm7AgXhUIleqiT4hlYRvkVWCVBdae1oVh5x6lyUv6lxU5r
 EXh4OrTrbh+XyruLTnCGywtMFXYVANz6VKWeNiBDgOhZ2jpah9SyLp87V2THJwQ7sdlZQklYjGE
 TiZoqUNjP+WtHwTdY7WOnWE2ufSuURIT6LSEMNxO6/LZyZS768Y4nPTn1xg1/ic6/DYs4PGPifS
 DPWCcbrW0OOQ0v4lk+Rv8gtURSm3mBle8F5lByGkzTI2LXzQBvaMhDpf3gqVwH5LaCqmvmWFJ3S
 veV67/S2XLZwX3IHxHpmaMCP/bM5/jbNMP4ptZLvA0yOxx1phhHBg5fxTQ==
X-Google-Smtp-Source: AGHT+IHtaTxQf38lG06EkLdOCN7M/hCzQo5pRF4oTVKyS+pfSJL0LEJrO339orrZcBrFSgfV+Mgxxg==
X-Received: by 2002:a17:90b:498b:b0:2fa:1e56:5d82 with SMTP id
 98e67ed59e1d1-306a4ec9210mr5206306a91.17.1743786663609; 
 Fri, 04 Apr 2025 10:11:03 -0700 (PDT)
Received: from [192.168.1.87] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3057ca498c6sm4357416a91.13.2025.04.04.10.11.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 04 Apr 2025 10:11:02 -0700 (PDT)
Message-ID: <5fa51205-4172-41d4-8bd9-5a95e8da24c2@linaro.org>
Date: Fri, 4 Apr 2025 10:10:23 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH-for-10.1 19/19] system/vl: Filter machine list for
 binary using machine_binary_filter()
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20250403234914.9154-1-philmd@linaro.org>
 <20250403234914.9154-20-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250403234914.9154-20-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::530;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x530.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

T24gNC8zLzI1IDE2OjQ5LCBQaGlsaXBwZSBNYXRoaWV1LURhdWTDqSB3cm90ZToNCj4gU2ln
bmVkLW9mZi1ieTogUGhpbGlwcGUgTWF0aGlldS1EYXVkw6kgPHBoaWxtZEBsaW5hcm8ub3Jn
Pg0KPiAtLS0NCj4gICBzeXN0ZW0vdmwuYyB8IDI0ICsrKysrKysrKysrKysrKysrKysrKysr
Kw0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAyNCBpbnNlcnRpb25zKCspDQo+IA0KPiBkaWZmIC0t
Z2l0IGEvc3lzdGVtL3ZsLmMgYi9zeXN0ZW0vdmwuYw0KPiBpbmRleCBkOGEwZmU3MTNjOS4u
NTU0ZjVmMmE0NjcgMTAwNjQ0DQo+IC0tLSBhL3N5c3RlbS92bC5jDQo+ICsrKyBiL3N5c3Rl
bS92bC5jDQo+IEBAIC0yNyw2ICsyNyw4IEBADQo+ICAgI2luY2x1ZGUgInFlbXUvZGF0YWRp
ci5oIg0KPiAgICNpbmNsdWRlICJxZW11L3VuaXRzLmgiDQo+ICAgI2luY2x1ZGUgInFlbXUv
bW9kdWxlLmgiDQo+ICsjaW5jbHVkZSAicWVtdS90YXJnZXRfaW5mby5oIg0KPiArI2luY2x1
ZGUgInFlbXUvdGFyZ2V0X2luZm8tcW9tLmgiDQo+ICAgI2luY2x1ZGUgImV4ZWMvY3B1LWNv
bW1vbi5oIg0KPiAgICNpbmNsdWRlICJleGVjL3BhZ2UtdmFyeS5oIg0KPiAgICNpbmNsdWRl
ICJody9xZGV2LXByb3BlcnRpZXMuaCINCj4gQEAgLTgzMywxNCArODM1LDI5IEBAIHN0YXRp
YyBib29sIHVzYl9wYXJzZShjb25zdCBjaGFyICpjbWRsaW5lLCBFcnJvciAqKmVycnApDQo+
ICAgLyoqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqLw0KPiAgIC8qIG1hY2hpbmUgcmVnaXN0cmF0aW9uICovDQo+ICAgDQo+ICtz
dGF0aWMgY2hhciAqbWFjaGluZV9iaW5hcnlfZmlsdGVyKHZvaWQpDQo+ICt7DQo+ICsgICAg
aWYgKHRhcmdldF9pbmZvX2lzX3N0dWIoKSkgew0KPiArICAgICAgICByZXR1cm4gTlVMTDsN
Cj4gKyAgICB9DQo+ICsgICAgcmV0dXJuIGdfc3RyY29uY2F0KFRZUEVfTEVHQUNZX0JJTkFS
WV9QUkVGSVgsDQo+ICsgICAgICAgICAgICAgICAgICAgICAgICJxZW11LXN5c3RlbS0iLCB0
YXJnZXRfbmFtZSgpLCBOVUxMKTsNCg0KTm8sIHdlIHNob3VsZCBub3QgaGF2ZSBzdWNoIHRo
aW5ncy4NCldlIGNhbiBtYWtlIGl0IHdvcmsgd2l0aCBwcm9wZXIgUU9NIHR5cGVzLCBkZWZp
bmVkIGJ5IHRhcmdldCwgaW5zdGVhZCBvZiANCnJlbHlpbmcgb24gc3RyaW5nIGNvbnN0cnVj
dGlvbi9jb21wYXJlIGxpa2UgdGhpcy4NCg0KPiArfQ0KPiArDQo+ICAgc3RhdGljIE1hY2hp
bmVDbGFzcyAqZmluZF9tYWNoaW5lKGNvbnN0IGNoYXIgKm5hbWUsIEdTTGlzdCAqbWFjaGlu
ZXMpDQo+ICAgew0KPiAgICAgICBHU0xpc3QgKmVsOw0KPiArICAgIGdfYXV0b2ZyZWUgY2hh
ciAqYmluYXJ5X2ZpbHRlciA9IG1hY2hpbmVfYmluYXJ5X2ZpbHRlcigpOw0KPiAgIA0KPiAg
ICAgICBmb3IgKGVsID0gbWFjaGluZXM7IGVsOyBlbCA9IGVsLT5uZXh0KSB7DQo+ICAgICAg
ICAgICBNYWNoaW5lQ2xhc3MgKm1jID0gZWwtPmRhdGE7DQo+ICAgDQo+ICAgICAgICAgICBp
ZiAoIXN0cmNtcChtYy0+bmFtZSwgbmFtZSkgfHwgIWdfc3RyY21wMChtYy0+YWxpYXMsIG5h
bWUpKSB7DQo+ICsgICAgICAgICAgICBpZiAoYmluYXJ5X2ZpbHRlciAmJiAhb2JqZWN0X2Ns
YXNzX2R5bmFtaWNfY2FzdChlbC0+ZGF0YSwNCj4gKyAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGJpbmFyeV9maWx0ZXIpKSB7
DQo+ICsgICAgICAgICAgICAgICAgLyogTWFjaGluZSBpcyBub3QgZm9yIHRoaXMgYmluYXJ5
OiBmYWlsICovDQo+ICsgICAgICAgICAgICAgICAgcmV0dXJuIE5VTEw7DQo+ICsgICAgICAg
ICAgICB9DQo+ICAgICAgICAgICAgICAgcmV0dXJuIG1jOw0KPiAgICAgICAgICAgfQ0KPiAg
ICAgICB9DQo+IEBAIC0xNTYzLDYgKzE1ODAsNyBAQCBzdGF0aWMgdm9pZCBtYWNoaW5lX2hl
bHBfZnVuYyhjb25zdCBRRGljdCAqcWRpY3QpDQo+ICAgICAgIGdfYXV0b3B0cihHU0xpc3Qp
IG1hY2hpbmVzID0gTlVMTDsNCj4gICAgICAgR1NMaXN0ICplbDsNCj4gICAgICAgY29uc3Qg
Y2hhciAqdHlwZSA9IHFkaWN0X2dldF90cnlfc3RyKHFkaWN0LCAidHlwZSIpOw0KPiArICAg
IGdfYXV0b2ZyZWUgY2hhciAqYmluYXJ5X2ZpbHRlciA9IG1hY2hpbmVfYmluYXJ5X2ZpbHRl
cigpOw0KPiAgIA0KPiAgICAgICBtYWNoaW5lcyA9IG9iamVjdF9jbGFzc19nZXRfbGlzdChU
WVBFX01BQ0hJTkUsIGZhbHNlKTsNCg0KSWYgd2UgZGVmaW5lIGEgcHJvcGVyIFRZUEVfVEFS
R0VUX01BQ0hJTkUgcGVyIHRhcmdldCwgYW5kIHdlIGFkZCB0aGlzIHRvIA0KVGFyZ2V0SW5m
bywgdGhpcyBjYW4gYmVjb21lOg0KDQptYWNoaW5lcyA9IG9iamVjdF9jbGFzc19nZXRfbGlz
dCh0YXJnZXRfbWFjaGluZV90eXBlKCksIGZhbHNlKTsNCg0KQW5kIHdlIGRvbid0IG5lZWQg
YW55IG90aGVyIHN0cmluZyBoYWNrIHRvIGRldGVjdCB3aGF0IGlzIHRoZSBjb3JyZWN0IHR5
cGUuDQoNCj4gICAgICAgaWYgKHR5cGUpIHsNCj4gQEAgLTE1NzcsNiArMTU5NSwxMiBAQCBz
dGF0aWMgdm9pZCBtYWNoaW5lX2hlbHBfZnVuYyhjb25zdCBRRGljdCAqcWRpY3QpDQo+ICAg
ICAgIG1hY2hpbmVzID0gZ19zbGlzdF9zb3J0KG1hY2hpbmVzLCBtYWNoaW5lX2NsYXNzX2Nt
cCk7DQo+ICAgICAgIGZvciAoZWwgPSBtYWNoaW5lczsgZWw7IGVsID0gZWwtPm5leHQpIHsN
Cj4gICAgICAgICAgIE1hY2hpbmVDbGFzcyAqbWMgPSBlbC0+ZGF0YTsNCj4gKw0KPiArICAg
ICAgICBpZiAoYmluYXJ5X2ZpbHRlciAmJiAhb2JqZWN0X2NsYXNzX2R5bmFtaWNfY2FzdChl
bC0+ZGF0YSwNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgYmluYXJ5X2ZpbHRlcikpIHsNCj4gKyAgICAgICAgICAgIC8qIE1h
Y2hpbmUgaXMgbm90IGZvciB0aGlzIGJpbmFyeTogc2tpcCAqLw0KPiArICAgICAgICAgICAg
Y29udGludWU7DQo+ICsgICAgICAgIH0NCg0KV2l0aCB0aGUgYXBwcm9hY2ggYWJvdmUsIHRo
aXMgaXMgbm90IG5lZWRlZCBhbnltb3JlLg0KDQo+ICAgICAgICAgICBpZiAobWMtPmFsaWFz
KSB7DQo+ICAgICAgICAgICAgICAgcHJpbnRmKCIlLTIwcyAlcyAoYWxpYXMgb2YgJXMpXG4i
LCBtYy0+YWxpYXMsIG1jLT5kZXNjLCBtYy0+bmFtZSk7DQo+ICAgICAgICAgICB9DQoNCkkg
dGhpbmsgd2UgYXJlIG1pc3NpbmcgYSBjb21taXQgaGVyZSwgZGVmaW5pbmcgYSBwcm9wZXIg
DQpUWVBFX1RBUkdFVF9NQUNISU5FX1BSRUZJWCwgdGhhdCBpcyB0YXJnZXQgZGVwZW5kZW50
LCBpbnN0ZWFkIG9mIHRoZSANClRZUEVfTEVHQUNZX0JJTkFSWV9QUkVGSVguDQoNCkFuZCB3
ZSBzaG91bGQgaW5jbHVkZSBpbiB0aGlzIHR5cGUgaW4gVGFyZ2V0SW5mbywgdGhlIHNhbWUg
d2F5IGl0IHdhcyANCmRvbmUgZm9yIGNwdXMuDQo=

