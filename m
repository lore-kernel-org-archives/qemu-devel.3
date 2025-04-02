Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0702FC28B20
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Apr 2025 15:07:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzzgC-0006Gv-AK; Wed, 02 Apr 2025 11:07:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tzzfo-0006Ev-JL
 for qemu-devel@nongnu.org; Wed, 02 Apr 2025 11:06:39 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tzzfm-0004Qz-JF
 for qemu-devel@nongnu.org; Wed, 02 Apr 2025 11:06:36 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-7370a2d1981so288992b3a.2
 for <qemu-devel@nongnu.org>; Wed, 02 Apr 2025 08:06:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743606392; x=1744211192; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+suyxI6UtimLYmX9HGZ6Yx3RjITGhRsYKZALhU8U+ig=;
 b=p6j2KE4DvQj7kjNVkN5xjuAxl9YuCsxOC/jjRh0VENlz5fdtoxGHsV7vVKVNvmXf7c
 GWiSovHq5pGcMl08U92slOcMUTWiGittnvwRTVnZOxd6neEsdbr9QAPM9F8W0z/FaJbp
 2i5m4KzowhSD3eHnrc/266fvHP8uG84hDh8Syc+IwNULuwJkHVJZIlGMoWLrEeKHZh8f
 NU7PUWBrlmlGR1Mfm5ELXCvUhdPRRDsgL0pb4lWIjO2UvK0s/pgPWoSpelZ4buqqzU3A
 vV16YulwrM/6dAlODs3OFocnbwGwNIuA1JzCIFMQ1N4WzldfPW4rNNYxUnJyxJhlFcO6
 U6gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743606392; x=1744211192;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+suyxI6UtimLYmX9HGZ6Yx3RjITGhRsYKZALhU8U+ig=;
 b=fPqld6sgdcUzxD/oeY+6HMLNSqqQDZwpRAE7IzVawGoxoWC2GEQ2QUW+xtiQb0dapj
 i7pSNqpQWwsA0WweL/TLKNba9ejXz08z3IVs5orWCnsoKEiOBBDqpUSFDh8b5nUMKLms
 gkW4LGkVAhrTnTOxsf4lYcCT4/DDIc43aWrM9+MH2GijAIwvmTko5sdXIML0JfzqkSEF
 OgiTJJ/E5Y58BoKNv8BOokawH9xO8NXpZf1bc3E/hNiNgIKiBgR+ml+b+gmXLQtM1euj
 eNT89gthQ1W3rZCExVKrZjv2AEDzJ7wMVArdg98F7FbkkIk1YXB8HkyuPE8n5I/XEep+
 qFyw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWxPVtTK+eH/6wkFc30R8oyOOl1Jd2iNdOIgTOHXGoD02HxRkpaqTk5E3T/Fz03AQDPUx1/KoD+9oUa@nongnu.org
X-Gm-Message-State: AOJu0YyKJISFi0+fDvK5KALaKWSCkc6kiQWH8CmsTHRFfL1Pew2SenuS
 2KUB7U9+HGhwiBXmelV0z1YLpzFR+H62bztq5Xpsz4/suWfvnbahNxDbNvOV7os=
X-Gm-Gg: ASbGncv+fxBDrdO34CanARweWJhy2hMNr1kFNr5GEfQjisCym+6dGKo3KnfCUQx2Iak
 sWeIFFVXJ9ZQlfp8ClC0O1eoek+FBvA1F6W3THlKq3rCmdC9eEf1yIDy7G+D3mHwum8GRP4cGZ6
 tHNGGOt0aT75QIKeeh3opxXglCF2KEKp8ZDU/OurV+5mYCfRPDT6hjXES9nbBOjHLGw0r388Dqy
 0aHBuxcDKZOG/A6baOd5pihIRn1IGUZpiatus3IL3/KKLHFXgsEqK2ZC4m0IBfBOSo33cBsJH4r
 MmiHepjvNrV8MgjX17MsgLIpFBKQ0mAZVhDNx97QsoYD0oJODIpl8mIerA==
X-Google-Smtp-Source: AGHT+IE2WfizvIScfv6TpCwQcsyk99JyjHPhECR5f2dEFmILSKSO5YDax5Dfjn0t/XU0VwHf2cA1JQ==
X-Received: by 2002:a05:6a20:3952:b0:1f5:535c:82dc with SMTP id
 adf61e73a8af0-2009f79c626mr28021630637.42.1743606392389; 
 Wed, 02 Apr 2025 08:06:32 -0700 (PDT)
Received: from [192.168.1.87] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-af93b8b48e3sm10001437a12.58.2025.04.02.08.06.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Apr 2025 08:06:31 -0700 (PDT)
Message-ID: <10759233-e73b-49e2-870b-c7687c9cfd1e@linaro.org>
Date: Wed, 2 Apr 2025 08:06:31 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 20/30] target/arm/cpu: always define kvm related
 registers
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 Thomas Huth <thuth@redhat.com>
Cc: kvm@vger.kernel.org, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini
 <pbonzini@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20250320223002.2915728-1-pierrick.bouvier@linaro.org>
 <20250320223002.2915728-21-pierrick.bouvier@linaro.org>
 <1109fe22-9008-47c6-b14d-7323f9888822@linaro.org>
 <11b5441f-c7c0-4b4c-8061-471a49e8465a@linaro.org>
 <428e6fdb-24b9-47a2-9d3f-4ef5c2e1a0ae@linaro.org>
 <ca52ecb4-6c1d-4299-9764-5839db2d013e@linaro.org>
Content-Language: en-US
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <ca52ecb4-6c1d-4299-9764-5839db2d013e@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x433.google.com
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

T24gNC8yLzI1IDA2OjM2LCBQaGlsaXBwZSBNYXRoaWV1LURhdWTDqSB3cm90ZToNCj4gT24g
MjUvMy8yNSAwMjoyNCwgUmljaGFyZCBIZW5kZXJzb24gd3JvdGU6DQo+PiBPbiAzLzI0LzI1
IDE0OjExLCBQaWVycmljayBCb3V2aWVyIHdyb3RlOg0KPj4+IE9uIDMvMjMvMjUgMTI6Mzcs
IFJpY2hhcmQgSGVuZGVyc29uIHdyb3RlOg0KPj4+PiBPbiAzLzIwLzI1IDE1OjI5LCBQaWVy
cmljayBCb3V2aWVyIHdyb3RlOg0KPj4+Pj4gVGhpcyBkb2VzIG5vdCBodXJ0LCBldmVuIGlm
IHRoZXkgYXJlIG5vdCB1c2VkLg0KPj4+Pj4NCj4+Pj4+IFNpZ25lZC1vZmYtYnk6IFBpZXJy
aWNrIEJvdXZpZXIgPHBpZXJyaWNrLmJvdXZpZXJAbGluYXJvLm9yZz4NCj4+Pj4+IC0tLQ0K
Pj4+Pj4gIMKgwqAgdGFyZ2V0L2FybS9jcHUuaCB8IDIgLS0NCj4+Pj4+ICDCoMKgIDEgZmls
ZSBjaGFuZ2VkLCAyIGRlbGV0aW9ucygtKQ0KPj4+Pj4NCj4+Pj4+IGRpZmYgLS1naXQgYS90
YXJnZXQvYXJtL2NwdS5oIGIvdGFyZ2V0L2FybS9jcHUuaA0KPj4+Pj4gaW5kZXggYThhMWE4
ZmFmNmIuLmFiNzQxMjc3MmJjIDEwMDY0NA0KPj4+Pj4gLS0tIGEvdGFyZ2V0L2FybS9jcHUu
aA0KPj4+Pj4gKysrIGIvdGFyZ2V0L2FybS9jcHUuaA0KPj4+Pj4gQEAgLTk3MSw3ICs5NzEs
NiBAQCBzdHJ1Y3QgQXJjaENQVSB7DQo+Pj4+PiAgwqDCoMKgwqDCoMKgwqAgKi8NCj4+Pj4+
ICDCoMKgwqDCoMKgwqAgdWludDMyX3Qga3ZtX3RhcmdldDsNCj4+Pj4+IC0jaWZkZWYgQ09O
RklHX0tWTQ0KPj4+Pj4gIMKgwqDCoMKgwqDCoCAvKiBLVk0gaW5pdCBmZWF0dXJlcyBmb3Ig
dGhpcyBDUFUgKi8NCj4+Pj4+ICDCoMKgwqDCoMKgwqAgdWludDMyX3Qga3ZtX2luaXRfZmVh
dHVyZXNbN107DQo+Pj4+PiBAQCAtOTg0LDcgKzk4Myw2IEBAIHN0cnVjdCBBcmNoQ1BVIHsN
Cj4+Pj4+ICDCoMKgwqDCoMKgwqAgLyogS1ZNIHN0ZWFsIHRpbWUgKi8NCj4+Pj4+ICDCoMKg
wqDCoMKgwqAgT25PZmZBdXRvIGt2bV9zdGVhbF90aW1lOw0KPj4+Pj4gLSNlbmRpZiAvKiBD
T05GSUdfS1ZNICovDQo+Pj4+PiAgwqDCoMKgwqDCoMKgIC8qIFVuaXByb2Nlc3NvciBzeXN0
ZW0gd2l0aCBNUCBleHRlbnNpb25zICovDQo+Pj4+PiAgwqDCoMKgwqDCoMKgIGJvb2wgbXBf
aXNfdXA7DQo+Pj4+DQo+Pj4+IEknbSBub3Qgc3VyZSB3aGF0IHRoaXMgYWNoaWV2ZXM/wqDC
oCBDT05GSUdfS1ZNIGlzIGEgY29uZmlndXJlLXRpbWUNCj4+Pj4gc2VsZWN0aW9uLg0KPj4+
Pg0KPj4+DQo+Pj4gQ09ORklHX0tWTSBpcyBhIHBvaXNvbmVkIGlkZW50aWZpZXIuDQo+Pj4g
SXQncyBpbmNsdWRlZCB2aWEgY29uZmlnLXRhcmdldC5oLCBhbmQgbm90IGNvbmZpZy1ob3N0
LmguDQo+Pg0KPj4gV2hvb3BzLCB5ZXMuDQo+IA0KPiBJZiB3ZSBnbyB0aGlzIHdheSwgY2Fu
IHdlIGNvbnNpc3RlbnRseSBhbGxvdyBDT05GSUdfJHtIV19BQ0NFTH0NCj4gKHJlYWQgInJl
bW92ZSBwb2lzb25lZCBkZWZzIGluIGNvbmZpZy1wb2lzb24uaCk/DQoNCkl0IHdvdWxkIGJl
IHNhZmUgdG8gZG8gdGhpcyBmb3IgQ09ORklHX1RDRywgd2hpY2ggaXMgYXBwbGllZCB0byBh
bGwgDQpjb21waWxhdGlvbiB1bml0cyAodGhyb3VnaCBjb25maWdfaG9zdCkuIEFuZCB3ZSds
bCBkbyBpdCB3aGVuIHdlIG1lZXQgYSANCmNhc2UgdGhhdCByZWFsbHkgbmVlZHMgaXQsIG5v
dCBiZWZvcmUuIEFzIGxvbmcgYXMgdGhlIGNvZGUgY2FuIGJlIA0KY2xlYW5lZCB1cCBmcm9t
IHRob3NlIGlmZGVmcywgaXQncyBiZXR0ZXIuDQoNCkhvd2V2ZXIsIGl0J3Mgbm90IHNhZmUg
Zm9yIGFsbCBvdGhlciBDT05GSUdfJHtIV19BQ0NFTH0sIHdoaWNoIGFyZSANCmFwcGxpZWQg
c2VsZWN0aXZlbHkgb24gc29tZSB0YXJnZXRzIChiYXNpY2FsbHksIGZvciB0aGUgcGFpciB7
aG9zdCA9PSANCnRhcmdldH0sIHdoZW4gaG9zdCBzdXBwb3J0cyB0aGlzIGFjY2VsZXJhdGlv
bikuDQpGb3IgdGhlbSwgdGhlIHJpZ2h0IGZpeCBpcyB0byBtYWtlIHN1cmUgd2UgY2FsbCAi
e2FjY2VsfV9lbmFibGVkKCkiLCANCmV4cG9zZSB0aGUgYXNzb2NpYXRlZCBjb2RlLCBhbmQg
ZXZlbnR1YWxseSBkZWFsIHdpdGggbWlzc2luZyBzeW1ib2xzIGF0IA0KbGluay4NCg==

