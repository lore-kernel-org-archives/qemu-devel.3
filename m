Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E084C369CB
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Apr 2025 15:00:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7bZW-0000Ti-20; Wed, 23 Apr 2025 10:59:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u7bZR-0000T8-Hq
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 10:59:31 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u7bZN-0006bg-1m
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 10:59:27 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-736a72220edso6723185b3a.3
 for <qemu-devel@nongnu.org>; Wed, 23 Apr 2025 07:59:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745420360; x=1746025160; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=z2KhhmsHf7V8y+q3+k2vT6mT1ccbmnDQhNGKas9n+vg=;
 b=BwT7pVs7GUDIWnt7WE/QvM0wRXtho2pimscCeoGWCu4aqKVxedlIlHtcomP0X40Ftn
 d35UiStDvB4/ikC5C02cQ4L4WyASHyzxgLLn0wS0mSPzYGCPScbeErNa08sFRyhn9y05
 Pn6zyLalfJxkN8/Anbdp+L/MHpa53hXsDLAqEg7XR0jNdudmQrw2NDmr2gRMWwAWOt6i
 9jf84VCAVaM8i7hPgH0ez1lnaRo1Wz9q1LeOoKy8+JKPBERYkMs9/k/DstvyXYGbJ5Xf
 p2R5Hu6i4uz9yCLG4ZN9Ik96C0eY6ZGArJof6LxsD9XBZR7Di5EzeGV+JB3jUAEkPYxZ
 ozKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745420360; x=1746025160;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=z2KhhmsHf7V8y+q3+k2vT6mT1ccbmnDQhNGKas9n+vg=;
 b=jSmTfElIM+OmMLK4J+n1z4oEIcB1fPlEuqcDUyhHHlR5r4TsrzOTmDLL5syx10f0BU
 sAKR/iB2b+FmYjiDJXOp4plPLXRxWXom/QF8pOV3xNC0V5axkTIgXaef0yufvwNIYPG6
 TIEW5YHAoUGJN1UBGzpfV+wjT0k/fdSMbMbyTKKPtrYteStlSA4laQN0GkenPwPDtnth
 RjbIkLxBpyr8w4gTl45WHPLpymoqzy/c4aOfRzHDX0AcApCDc8iwEGl63TmUPUmQGlgC
 eWu49DqNxgQNk5n1JkXGV1dOvU0uud1jGc1lz1jHTttcNOxrnyj15uV6qeTotohCrC4F
 hWbg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW0wGnFPEfwyOh4yv2/2zb5vp854Fdv6MTU1e/eGDxPNtp2WrY/0d8GAbQTxOJO+h+WFJLmGypo+wjL@nongnu.org
X-Gm-Message-State: AOJu0YyDXy/AKtGjuozT3WL6fmhu1P9jQSRucg9PEIrjpHWu6ibvSw0g
 orVF+6bZ0yHbrPBXrIgsNtLwlde8nl1mnoHDj1fd7MnJbPT9P0CTLxfgDbI/1BA=
X-Gm-Gg: ASbGncsH3Qh3dL/Oq+mwgXu4NMNBWG4DnWxz514r1yn9NY6EqQzZxK+7Yob21OPuaXu
 Z3jCOvUW5RvKb+hVqLtXQbr8CJA6RtVnaMRfGD5ySoHp6MuZ5YWLRGHCJAh4yJ3ONdrFD5Mrwgm
 MyzKlfWoHuYocn4iDoKUWYEu7Hr9Ey5j7FSOS4JejmF8fEvPYTO4zzUCaXfc3bRiwpc/RQYSoMe
 03KBlkdEr9fwOvIu1rVgB7x6P29kSsGFLPhjpFnAzJBogkPxKcBs81H8Z/5BlD5/+JR9lm8B5KQ
 KYHMv4ORTMYwdyC/9X83vZ3qD5FRhsRnEgRbF9HaeqzBbjAqsBBR8t+y/WwZw/qE
X-Google-Smtp-Source: AGHT+IEmbuK/OX9oHjGsQDkpqVZlu+245IFyQgQUGcwvpB4fiwDN7PIhA85Y+OEMlQVXjWDevz9cjQ==
X-Received: by 2002:a05:6a20:3d81:b0:1f5:6680:82b6 with SMTP id
 adf61e73a8af0-203cbd240c6mr32213551637.38.1745420360033; 
 Wed, 23 Apr 2025 07:59:20 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73dbfae939dsm10652815b3a.157.2025.04.23.07.59.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Apr 2025 07:59:19 -0700 (PDT)
Message-ID: <39a51598-e17d-4fc4-a917-e2481d23f15f@linaro.org>
Date: Wed, 23 Apr 2025 07:59:18 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v4 14/19] qemu/target_info: Add %target_arch field to
 TargetInfo
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Anton Johansson <anjo@rev.ng>, Markus Armbruster <armbru@redhat.com>
References: <20250422145502.70770-1-philmd@linaro.org>
 <20250422145502.70770-15-philmd@linaro.org>
 <cc5114fe-c17d-4e02-96f2-135ee1c7fa09@linaro.org>
 <a8a701b4-9da5-45d1-88e2-6a708b425146@linaro.org>
 <5c3cebf7-665d-4c07-97d8-cf913e78c3f0@linaro.org>
 <65ae1a3d-0376-4b66-8354-227303d8b90c@linaro.org>
 <7c1d7d7b-f58d-40f6-9a1b-c80231681b89@linaro.org>
 <9d811c1d-7431-4348-9252-37c412593556@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Content-Language: en-US
In-Reply-To: <9d811c1d-7431-4348-9252-37c412593556@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x431.google.com
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

T24gNC8yMy8yNSAwMjoxNCwgUGhpbGlwcGUgTWF0aGlldS1EYXVkw6kgd3JvdGU6DQo+IE9u
IDIzLzQvMjUgMDg6MjQsIFBpZXJyaWNrIEJvdXZpZXIgd3JvdGU6DQo+PiBPbiA0LzIyLzI1
IDIyOjM0LCBQaGlsaXBwZSBNYXRoaWV1LURhdWTDqSB3cm90ZToNCj4+PiBPbiAyMi80LzI1
IDIwOjMwLCBQaWVycmljayBCb3V2aWVyIHdyb3RlOg0KPj4+PiBPbiA0LzIyLzI1IDExOjI0
LCBQaGlsaXBwZSBNYXRoaWV1LURhdWTDqSB3cm90ZToNCj4+Pj4+IE9uIDIyLzQvMjUgMjA6
MjAsIFBpZXJyaWNrIEJvdXZpZXIgd3JvdGU6DQo+Pj4+Pj4gT24gNC8yMi8yNSAwNzo1NCwg
UGhpbGlwcGUgTWF0aGlldS1EYXVkw6kgd3JvdGU6DQo+Pj4+Pj4+IFNpZ25lZC1vZmYtYnk6
IFBoaWxpcHBlIE1hdGhpZXUtRGF1ZMOpIDxwaGlsbWRAbGluYXJvLm9yZz4NCj4+Pj4+Pj4g
LS0tDQo+Pj4+Pj4+ICDCoMKgwqAgaW5jbHVkZS9xZW11L3RhcmdldC1pbmZvLWltcGwuaMKg
wqAgfCA0ICsrKysNCj4+Pj4+Pj4gIMKgwqDCoCBjb25maWdzL3RhcmdldHMvYWFyY2g2NC1z
b2Z0bW11LmMgfCAxICsNCj4+Pj4+Pj4gIMKgwqDCoCBjb25maWdzL3RhcmdldHMvYXJtLXNv
ZnRtbXUuY8KgwqDCoMKgIHwgMSArDQo+Pj4+Pj4+ICDCoMKgwqAgdGFyZ2V0LWluZm8tc3R1
Yi5jwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHwgMSArDQo+Pj4+Pj4+ICDCoMKg
wqAgNCBmaWxlcyBjaGFuZ2VkLCA3IGluc2VydGlvbnMoKykNCj4+Pj4+Pj4NCj4+Pj4+Pj4g
ZGlmZiAtLWdpdCBhL2luY2x1ZGUvcWVtdS90YXJnZXQtaW5mby1pbXBsLmggYi9pbmNsdWRl
L3FlbXUvdGFyZ2V0LQ0KPj4+Pj4+PiBpbmZvLWltcGwuaA0KPj4+Pj4+PiBpbmRleCA0ZWY1
NGM1MTM2YS4uZTVjZDE2OWI0OWEgMTAwNjQ0DQo+Pj4+Pj4+IC0tLSBhL2luY2x1ZGUvcWVt
dS90YXJnZXQtaW5mby1pbXBsLmgNCj4+Pj4+Pj4gKysrIGIvaW5jbHVkZS9xZW11L3Rhcmdl
dC1pbmZvLWltcGwuaA0KPj4+Pj4+PiBAQCAtMTAsMTIgKzEwLDE2IEBADQo+Pj4+Pj4+ICDC
oMKgwqAgI2RlZmluZSBRRU1VX1RBUkdFVF9JTkZPX0lNUExfSA0KPj4+Pj4+PiAgwqDCoMKg
ICNpbmNsdWRlICJxZW11L3RhcmdldC1pbmZvLmgiDQo+Pj4+Pj4+ICsjaW5jbHVkZSAicWFw
aS9xYXBpLXR5cGVzLW1hY2hpbmUuaCINCj4+Pj4+Pj4gIMKgwqDCoCB0eXBlZGVmIHN0cnVj
dCBUYXJnZXRJbmZvIHsNCj4+Pj4+Pj4gIMKgwqDCoMKgwqDCoMKgIC8qIHJ1bnRpbWUgZXF1
aXZhbGVudCBvZiBUQVJHRVRfTkFNRSBkZWZpbml0aW9uICovDQo+Pj4+Pj4+ICDCoMKgwqDC
oMKgwqDCoCBjb25zdCBjaGFyICpjb25zdCB0YXJnZXRfbmFtZTsNCj4+Pj4+Pj4gK8KgwqDC
oCAvKiByZWxhdGVkIHRvIFRBUkdFVF9BUkNIIGRlZmluaXRpb24gKi8NCj4+Pj4+Pj4gK8Kg
wqDCoCBTeXNFbXVUYXJnZXQgdGFyZ2V0X2FyY2g7DQo+Pj4+Pj4+ICsNCj4+Pj4+Pj4gIMKg
wqDCoMKgwqDCoMKgIC8qIFFPTSB0eXBlbmFtZSBtYWNoaW5lcyBmb3IgdGhpcyBiaW5hcnkg
bXVzdCBpbXBsZW1lbnQgKi8NCj4+Pj4+Pj4gIMKgwqDCoMKgwqDCoMKgIGNvbnN0IGNoYXIg
KmNvbnN0IG1hY2hpbmVfdHlwZW5hbWU7DQo+Pj4+Pj4+IGRpZmYgLS1naXQgYS9jb25maWdz
L3RhcmdldHMvYWFyY2g2NC1zb2Z0bW11LmMgYi9jb25maWdzL3RhcmdldHMvDQo+Pj4+Pj4+
IGFhcmNoNjQtc29mdG1tdS5jDQo+Pj4+Pj4+IGluZGV4IDM3NWU2ZmEwYjdiLi5mZjg5NDAx
ZWEzNCAxMDA2NDQNCj4+Pj4+Pj4gLS0tIGEvY29uZmlncy90YXJnZXRzL2FhcmNoNjQtc29m
dG1tdS5jDQo+Pj4+Pj4+ICsrKyBiL2NvbmZpZ3MvdGFyZ2V0cy9hYXJjaDY0LXNvZnRtbXUu
Yw0KPj4+Pj4+PiBAQCAtMTMsNiArMTMsNyBAQA0KPj4+Pj4+PiAgwqDCoMKgIHN0YXRpYyBj
b25zdCBUYXJnZXRJbmZvIHRhcmdldF9pbmZvX2FhcmNoNjRfc3lzdGVtID0gew0KPj4+Pj4+
PiAgwqDCoMKgwqDCoMKgwqAgLnRhcmdldF9uYW1lID0gImFhcmNoNjQiLA0KPj4+Pj4+PiAr
wqDCoMKgIC50YXJnZXRfYXJjaCA9IFNZU19FTVVfVEFSR0VUX0FBUkNINjQsDQo+Pj4+Pj4+
ICDCoMKgwqDCoMKgwqDCoCAubWFjaGluZV90eXBlbmFtZSA9IFRZUEVfVEFSR0VUX0FBUkNI
NjRfTUFDSElORSwNCj4+Pj4+Pj4gIMKgwqDCoCB9Ow0KPj4+Pj4+PiBkaWZmIC0tZ2l0IGEv
Y29uZmlncy90YXJnZXRzL2FybS1zb2Z0bW11LmMgYi9jb25maWdzL3RhcmdldHMvYXJtLQ0K
Pj4+Pj4+PiBzb2Z0bW11LmMNCj4+Pj4+Pj4gaW5kZXggZDRhY2RhZTY0ZjMuLjIyZWM5ZTRm
YWEzIDEwMDY0NA0KPj4+Pj4+PiAtLS0gYS9jb25maWdzL3RhcmdldHMvYXJtLXNvZnRtbXUu
Yw0KPj4+Pj4+PiArKysgYi9jb25maWdzL3RhcmdldHMvYXJtLXNvZnRtbXUuYw0KPj4+Pj4+
PiBAQCAtMTMsNiArMTMsNyBAQA0KPj4+Pj4+PiAgwqDCoMKgIHN0YXRpYyBjb25zdCBUYXJn
ZXRJbmZvIHRhcmdldF9pbmZvX2FybV9zeXN0ZW0gPSB7DQo+Pj4+Pj4+ICDCoMKgwqDCoMKg
wqDCoCAudGFyZ2V0X25hbWUgPSAiYXJtIiwNCj4+Pj4+Pj4gK8KgwqDCoCAudGFyZ2V0X2Fy
Y2ggPSBTWVNfRU1VX1RBUkdFVF9BUk0sDQo+Pj4+Pj4+ICDCoMKgwqDCoMKgwqDCoCAubWFj
aGluZV90eXBlbmFtZSA9IFRZUEVfVEFSR0VUX0FSTV9NQUNISU5FLA0KPj4+Pj4+PiAgwqDC
oMKgIH07DQo+Pj4+Pj4+IGRpZmYgLS1naXQgYS90YXJnZXQtaW5mby1zdHViLmMgYi90YXJn
ZXQtaW5mby1zdHViLmMNCj4+Pj4+Pj4gaW5kZXggMjE4ZTU4OThlN2YuLmU1NzNmNWMxOTc1
IDEwMDY0NA0KPj4+Pj4+PiAtLS0gYS90YXJnZXQtaW5mby1zdHViLmMNCj4+Pj4+Pj4gKysr
IGIvdGFyZ2V0LWluZm8tc3R1Yi5jDQo+Pj4+Pj4+IEBAIC0xMiw2ICsxMiw3IEBADQo+Pj4+
Pj4+ICDCoMKgwqAgc3RhdGljIGNvbnN0IFRhcmdldEluZm8gdGFyZ2V0X2luZm9fc3R1YiA9
IHsNCj4+Pj4+Pj4gIMKgwqDCoMKgwqDCoMKgIC50YXJnZXRfbmFtZSA9IFRBUkdFVF9OQU1F
LA0KPj4+Pj4+PiArwqDCoMKgIC50YXJnZXRfYXJjaCA9IC0xLA0KPj4+Pj4+DQo+Pj4+Pj4g
SSB0aGluayB3ZSBzaG91bGQgaGF2ZSBhIGZ1bGwgaWZkZWYgbGFkZGVyIGhlcmUsIHRvIGhh
bmRsZSBhbGwNCj4+Pj4+PiBhcmNoaXRlY3R1cmVzLiBTZXR0aW5nIC0xIGlzIG5vdCBhIHNh
ZmUgZGVmYXVsdC4NCj4+Pj4+DQo+Pj4+PiBUYXJnZXRJbmZvIGRlZmluaXRpb24gaXMgaW50
ZXJuYWwgdG8gInFlbXUvdGFyZ2V0LWluZm8taW1wbC5oIiwNCj4+Pj4+IG90aGVyd2lzZSBp
dHMgdHlwZSBpcyBmb3J3YXJkLWRlY2xhcmVkIGFzIG9wYXF1ZS4NCj4+Pj4+DQo+Pj4+DQo+
Pj4+IEZpbmUsIGJ1dCB3ZSBuZWVkIHRvIGJlIGFibGUgdG8gYWNjZXNzIHRvIHRhcmdldF9h
cmNoKCksIHdoaWNoIHJldHVybnMNCj4+Pj4gdGhlIGVudW0gdmFsdWUsIHdpdGhvdXQgaGF2
aW5nIHRvIGRlYWwgd2l0aCAtMSBzaXR1YXRpb24sIHdoaWNoIGlzIG5vdCBhDQo+Pj4+IHBy
b3BlciBlbnVtIHZhbHVlLg0KPj4+Pg0KPj4+PiBzd2l0Y2ggKHRhcmdldF9hcmNoKCkpIHsN
Cj4+Pj4gY2FzZSBTWVNfRU1VX1RBUkdFVF9BUk06DQo+Pj4+IGNhc2UgU1lTX0VNVV9UQVJH
RVRfQUFSQ0g2NDoNCj4+Pj4gLi4uDQo+Pj4+IGRlZmF1bHQ6DQo+Pj4+ICDCoCDCoMKgwqDC
oGJyZWFrOw0KPj4+PiB9DQo+Pj4NCj4+PiBJIGRpZG4ndCBtZW50aW9uZWQgdGhhdCBiZWNh
dXNlIGluDQo+Pj4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvcWVtdS1kZXZlbC8zMjQyY2Vl
Ni03NDg1LTQ5NTgtDQo+Pj4gYTE5OC0zOGQwZmM2OGU4Y2RAbGluYXJvLm9yZy8NCj4+PiB5
b3Ugc2FpZDoNCj4+Pg0KPj4+ICDCoMKgwqAgQXQgdGhpcyBwb2ludCwgSSB3b3VsZCBsaWtl
IHRvIGZvY3VzIG9uIGhhdmluZyBhIGZpcnN0IHZlcnNpb24gb2YNCj4+PiAgwqDCoMKgIFRh
cmdldEluZm8gQVBJLCBhbmQgbm90IHJldmlld2luZyBhbnkgb3RoZXIgY2hhbmdlcywgYXMg
dGhpbmdzIG1heQ0KPj4+ICDCoMKgwqAgYmUgbW9kaWZpZWQsIGFuZCB0aGV5IHdvdWxkIG5l
ZWQgdG8gYmUgcmV2aWV3ZWQgYWdhaW4uIEl0J3MgaGFyZA0KPj4+ICDCoMKgwqAgdG8gZm9s
bG93IHRoZSBzYW1lIGFic3RyYWN0aW9uIGRvbmUgbXVsdGlwbGUgdGltZXMgaW4gbXVsdGlw
bGUNCj4+PiBzZXJpZXMuDQo+Pj4NCj4+PiBXaGF0IGlzIHlvdXIgImZ1bGwgaWZkZWYgbGFk
ZGVyIiBzdWdnZXN0aW9uIHRvIGF2b2lkIC0xPw0KPj4NCj4+ICNpZmRlZiBUQVJHRVRfQUFS
Q0g2NA0KPj4gIyBkZWZpbmUgVEFSR0VUX0FSQ0ggU1lTX0VNVV9UQVJHRVRfQUFSQ0g2NA0K
Pj4gI2VsaWYgVEFSR0VUX0FSQ0hfQUxQSEENCj4+ICMgZGVmaW5lIFRBUkdFVF9BUkNIIFNZ
U19FTVVfVEFSR0VUX0FMUEhBDQo+PiAuLi4NCj4+ICNlbHNlDQo+PiAjZXJyb3IgVGFyZ2V0
IGFyY2hpdGVjdHVyZSBjYW4ndCBiZSBkZXRlY3RlZA0KPiANCj4gSSdtIHNvcnJ5IGJ1dCBJ
IGRvbid0IHVuZGVyc3RhbmQgd2hhdCB3ZSBnYWluIGRvaW5nIHRoYXQuDQo+IA0KDQpGb3Ig
UUFQSSBnZW5lcmF0ZWQgZmlsZXMsIHdlJ2xsIG5lZWQgYSB2YXJpb3VzIGJ1bmNoIG9mIFRB
UkdFVF9YIHJ1bnRpbWUgDQpjb252ZXJzaW9uLCB0byBlbmFibGUgc29tZSBjb21tYW5kcyBv
bmx5IGZvciB0YXJnZXRzLg0KU29tZSBvZiB0aGUgY29uY2VybmVkIHRhcmdldHMgYXJlIGRp
ZmZlcmVudCBmcm9tIHRoZSBvbmUgd2UgZm9jdXMgb24gZm9yIA0Kc2luZ2xlIGJpbmFyeS4N
Cg0KTXkgaG9wZSB3YXMgdG8gaW5jbHVkZSB0YXJnZXRfYXJjaCgpIGZ1bmN0aW9uIGluIHRo
aXMgc2VyaWVzLCBzbyBpdCdzIA0Kbm90IGEgZGViYXRlIGluIG5leHQgc2VyaWVzIHRoYXQg
d2lsbCB0b3VjaCB0byBRQVBJLg0KSW4gc2hvcnQsIG1vdmUgdGhlIG5vaXNlIGhlcmUgYW5k
IG5vdyBjb21wYXJlZCB0byBsYXRlciB3aXRoIGFub3RoZXIgDQp1bnJlbGF0ZWQgdG9waWMs
IHRoYXQgd2lsbCBoYXZlIGEgbG90IG9mIGhlYXRlZCBvcGluaW9ucyBhbHJlYWR5Lg0KDQpM
aXN0IG9mIG5lZWRlZCAodGFyZ2V0XygpKSBmb3IgUUFQSToNClRBUkdFVF9TMzkwWA0KVEFS
R0VUX1BQQw0KVEFSR0VUX0FSTQ0KVEFSR0VUX0kzODYNClRBUkdFVF9MT09OR0FSQ0g2NA0K
VEFSR0VUX01JUFMNClRBUkdFVF9SSVNDVg0KVEFSR0VUX0kzODYNCg0KSWYgaXQncyB0b28g
bXVjaCB3b3JrIG9uIHlvdXIgc2lkZSwgd291bGQgeW91IGJlIG9wZW4gdGhhdCBJIHByb3Zp
ZGUgDQp0aGlzIHBhdGNoIG9uIHRvcCBvZiB5b3VyIHNlcmllcywgYW5kIHRoYXQgd2UgaW5j
bHVkZSBpdCB3aXRoIGl0Pw0KDQpUaGFua3MsDQpQaWVycmljaw0K

