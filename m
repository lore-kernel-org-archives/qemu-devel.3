Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3637C36008
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Mar 2025 00:02:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tvmIn-0004rD-KR; Fri, 21 Mar 2025 20:01:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tvmIm-0004qy-7K
 for qemu-devel@nongnu.org; Fri, 21 Mar 2025 20:01:24 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tvmIj-0001Jw-Rl
 for qemu-devel@nongnu.org; Fri, 21 Mar 2025 20:01:23 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-22423adf751so52247675ad.2
 for <qemu-devel@nongnu.org>; Fri, 21 Mar 2025 17:01:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742601678; x=1743206478; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=8jIF53UuilIp95lERWLD96FBJysroCAg3PsA4TvpjMo=;
 b=gh+oim/G3/QSxm0XPh8lt2HHpZf5GjinpDUv+XyDvclJv0bjJ/yehmuAjvcyPsOAOe
 C/b5eaLlPgkBj6zXsVu6HII4+vouNb8DsOUS+8cLr88EVpTrCsPTXdZRrXkoPN1gyFeL
 v8GPouCv6fgj7vl0jNiawYJvMhXXWt3trYrFTwr0MehXzeiU5RZ9mW1vKoqG/0KAuWs6
 p3SgWBtE4sd7fWPClUcz0fH+K9u4PxDQ2W/vPtBJzzHfrw96FJQW4ZgIpZ6iJW3neAfI
 +44HqSVbECydcvttHTCmgZdUUg6onVqNWZqs4couSOO2RKdtc72an3DV7WaKLp01tiTq
 BNtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742601678; x=1743206478;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8jIF53UuilIp95lERWLD96FBJysroCAg3PsA4TvpjMo=;
 b=uZtsoP9EzD2F7awEUEH9OnU1jx/zDP36Ox2CjLNKPZSlfgxRASwWjUBvYftkf94EuS
 6Pdp3lCoQOOVO1a15qVWqVaV1ZIljAWqgdKyWmN9HZWHPlqM4OkKxYteJciSQTOP93hv
 ooV6VB/+VnoTg60UysJGYHToek+5YB5dcArYCZuF1aOBqj+ofw+cXdJKgG5l7nzRnTSB
 QtVi9YMO6knkGj+pjzTmo/wcQJV1rBc2YvFTuRsqpDsUWzXbR8w3bfB1MS6fyG44yaeu
 Kw3rNZWBWf5eBHYUY8OoX0hqP96aWOMTOzZlRTi2mxbQ13o1UMxf5tfvYH/ESnaUKzds
 zYdA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUhptmuSqF2e+mnnVSFzsw3bK4bnPRIHBKvfh3C08MvL+0Ow8Ai31/zeFq741RjfexVmnmUeRzv5JVL@nongnu.org
X-Gm-Message-State: AOJu0YxDse0FbVJf5F5nuNNsuyEKNcOuLMWncCEVXFrnBCbgLjOc1gsp
 zCJoEvFyXkyWj/DtcsmY60Vo4UtUx7xHL/B5RaBYaJDUIlpf328eydg6UWk/6eU=
X-Gm-Gg: ASbGnctQ6B5w4yqdPd9dKLQ3RiABlle6SjosCfrbigsmfJYKps0pb4+MwR+HmRkDsoV
 QQ/Zm0P680ztI4V5wSECsjLjPjBwGvuhKguHgxAyzT3dcx69ZYQLLVs9x51nA0fa0xElaOq4P0I
 II5m20osUexMU9OupRMFxi3n7XIoU4FRXIC8zCeYz1QOf6LjkuwBvff5YxjlNJnAtg3Bjd8n8ZX
 p1SvtRKEiC+ckeIGVQaxgm5okvJV9f2uDk/FuJSw3rLwO92e7vJPbBkahNnOGSn/6JJPBsedRIb
 czGjP+KuqDNZ0TAGA24jAz/GdenTbGtHsZoTy/s6vN1ftO2egQgOYHPx8g==
X-Google-Smtp-Source: AGHT+IFycojw9Uun5vxQflyFUKmw9FGit8EBg4TDZCtmc6CLRIFEIQnJbgKlCoaW1zxWlIPsnn0Hhg==
X-Received: by 2002:aa7:88c7:0:b0:736:5725:59b9 with SMTP id
 d2e1a72fcca58-7390593d43fmr7967391b3a.2.1742601677692; 
 Fri, 21 Mar 2025 17:01:17 -0700 (PDT)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7390618f080sm2780961b3a.176.2025.03.21.17.01.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 21 Mar 2025 17:01:17 -0700 (PDT)
Message-ID: <ebd25730-1947-4360-af36-cf1131f4155c@linaro.org>
Date: Fri, 21 Mar 2025 17:01:16 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 17/30] exec/target_page: runtime defintion for
 TARGET_PAGE_BITS_MIN
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini
 <pbonzini@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20250320223002.2915728-1-pierrick.bouvier@linaro.org>
 <20250320223002.2915728-18-pierrick.bouvier@linaro.org>
 <2e667bb0-7357-4caf-ab60-4e57aabdceeb@linaro.org>
 <e738b8b8-e06f-48d0-845e-f263adb3dee5@linaro.org>
 <a67d17bb-e0dc-4767-8a43-8f057db70c71@linaro.org>
 <216a39c6-384d-4f9e-b615-05af18c6ef59@linaro.org>
 <c0e338f5-6592-4d83-9f17-120b9c4f039e@linaro.org>
Content-Language: en-US
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <c0e338f5-6592-4d83-9f17-120b9c4f039e@linaro.org>
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

T24gMy8yMS8yNSAxNToxOSwgUmljaGFyZCBIZW5kZXJzb24gd3JvdGU6DQo+IE9uIDMvMjEv
MjUgMTM6MTEsIFBpZXJyaWNrIEJvdXZpZXIgd3JvdGU6DQo+PiBPbiAzLzIxLzI1IDEyOjI3
LCBSaWNoYXJkIEhlbmRlcnNvbiB3cm90ZToNCj4+PiBPbiAzLzIxLzI1IDExOjA5LCBQaWVy
cmljayBCb3V2aWVyIHdyb3RlOg0KPj4+Pj4gTW1tLCBvayBJIGd1ZXNzLsKgIFllc3RlcmRh
eSBJIHdvdWxkIGhhdmUgc3VnZ2VzdGVkIG1lcmdpbmcgdGhpcyB3aXRoIHBhZ2UtdmFyeS5o
LCBidXQNCj4+Pj4+IHRvZGF5IEknbSBhY3RpdmVseSB3b3JraW5nIG9uIG1ha2luZyBUQVJH
RVRfUEFHRV9CSVRTX01JTiBhIGdsb2JhbCBjb25zdGFudC4NCj4+Pj4+DQo+Pj4+DQo+Pj4+
IFdoZW4geW91IG1lbnRpb24gdGhpcywgZG8geW91IG1lYW4gImNvbnN0YW50IGFjY3Jvc3Mg
YWxsIGFyY2hpdGVjdHVyZXMiLCBvciBhIGdsb2JhbA0KPj4+PiAoY29uc3QpIHZhcmlhYmxl
IHZzIGhhdmluZyBhIGZ1bmN0aW9uIGNhbGw/DQo+Pj4gVGhlIGZpcnN0IC0tIGNvbnN0YW50
IGFjcm9zcyBhbGwgYXJjaGl0ZWN0dXJlcy4NCj4+Pg0KPj4NCj4+IFRoYXQncyBncmVhdC4N
Cj4+IERvZXMgY2hvb3NpbmcgdGhlIG1pbihzZXRfb2YoVEFSR0VUX1BBR0VfQklUU19NSU4p
KSBpcyB3aGF0IHdlIHdhbnQgdGhlcmUsIG9yIGlzIHRoZQ0KPj4gYW5zd2VyIG1vcmUgc3Vi
dGxlIHRoYW4gdGhhdD8NCj4gDQo+IEl0IHdpbGwgYmUsIHllcy4NCj4gDQo+IFRoaXMgaXNu
J3QgYXMgaGFyZCBhcyBpdCBzZWVtcywgYmVjYXVzZSB0aGVyZSBhcmUgZXhhY3RseSB0d28g
dGFyZ2V0cyB3aXRoDQo+IFRBUkdFVF9QQUdFX0JJVFMgPCAxMjogYXJtIGFuZCBhdnIuDQo+
IA0KPiBCZWNhdXNlIHdlIHN0aWxsIHN1cHBvcnQgYXJtdjQsIFRBUkdFVF9QQUdFX0JJVFNf
TUlOIG11c3QgYmUgPD0gMTAuDQo+IA0KPiBBVlIgY3VycmVudGx5IGhhcyBUQVJHRVRfUEFH
RV9CSVRTID09IDgsIHdoaWNoIGlzIGEgYml0IG9mIGEgcHJvYmxlbS4NCj4gTXkgZmlyc3Qg
dGFzayBpcyB0byBhbGxvdyBhdnIgdG8gY2hvb3NlIFRBUkdFVF9QQUdFX0JJVFNfTUlOID49
IDEwLg0KPiANCj4gV2hpY2ggd2lsbCBsZWF2ZSB1cyB3aXRoIFRBUkdFVF9QQUdFX0JJVFNf
TUlOID09IDEwLg0KPiANCg0KT2suDQoNCiBGcm9tIHdoYXQgSSB1bmRlcnN0YW5kLCB3ZSBt
YWtlIHN1cmUgdGxiIGZsYWdzIGFyZSBzdG9yZWQgaW4gYW4gDQppbW11dGFibGUgcG9zaXRp
b24sIHdpdGhpbiB2aXJ0dWFsIGFkZHJlc3NlcyByZWxhdGVkIHRvIGd1ZXN0LCBieSB1c2lu
ZyANCmxvd2VyIGJpdHMgYmVsb25naW5nIHRvIGFkZHJlc3MgcmFuZ2UgaW5zaWRlIGEgZ2l2
ZW4gcGFnZSwgc2luY2UgcGFnZSANCmFkZHJlc3NlcyBhcmUgYWxpZ25lZCBvbiBwYWdlIHNp
emUsIGxlYXZpbmcgdGhvc2UgYml0cyBmcmVlLg0KDQpiaXRzIFswLi4yKSBhcmUgYnN3YXAs
IHdhdGNocG9pbnQgYW5kIGNoZWNrX2FsaWduZWQuDQpiaXRzIFtUQVJHRVRfUEFHRV9CSVRT
X01JTiAtIDUuLlRBUkdFVF9QQUdFX0JJVFNfTUlOKSBhcmUgc2xvdywgDQpkaXNjYXJkX3dy
aXRlLCBtbWlvLCBub3RkaXJ0eSwgYW5kIGludmFsaWQgbWFzay4NCkFuZCB0aGUgY29tcGls
ZSB0aW1lIGNoZWNrIHdlIGhhdmUgaXMgdG8gbWFrZSBzdXJlIHdlIGRvbid0IG92ZXJsYXAg
DQp0aG9zZSBzZXRzICh3b3VsZCBoYXBwZW4gaW4gVEFSR0VUX1BBR0VfQklUU19NSU4gPD0g
NykuDQoNCkkgd29uZGVyIHdoeSB3ZSBjYW4ndCB1c2UgYml0cyBbMy4uOCkgZXZlcnl3aGVy
ZSwgbGlrZSBpdCdzIGRvbmUgZm9yIA0KQVZSLCBldmVuIGZvciBiaWdnZXIgcGFnZSBzaXpl
cy4gSSBub3RpY2VkIHRoZSBjb21tZW50IGFib3V0ICJhZGRyZXNzIA0KYWxpZ25tZW50IGJp
dHMiLCBidXQgSSdtIGNvbmZ1c2VkIHdoeSBiaXRzIFswLi4yKSBjYW4gYmUgdXNlZCwgYW5k
IG5vdCANCnVwcGVyIG9uZXMuDQoNCkFyZSB3ZSBzdG9yaW5nIHNvbWV0aGluZyBlbHNlIGlu
IHRoZSBtaWRkbGUgb24gb3RoZXIgYXJjaHMsIG9yIGRpZCBJIA0KbWlzcyBzb21lIHBpZWNl
IG9mIHRoZSBwdXp6bGU/DQoNClRoYW5rcywNClBpZXJyaWNrDQoNCj4gDQo+IHJ+DQoNCg==


