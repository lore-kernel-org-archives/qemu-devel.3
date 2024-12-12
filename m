Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1005FE7717F
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2024 20:31:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLpps-0004vt-0U; Thu, 12 Dec 2024 15:31:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tLppq-0004vk-QP
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 15:30:58 -0500
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tLppo-0004ru-Ou
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 15:30:58 -0500
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-725f4623df7so868948b3a.2
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2024 12:30:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734035454; x=1734640254; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=MwvVNJX1Sea3xCbdz3WU97gbstRJovpcsoaRPiyqmYA=;
 b=RWIjI2WSgqfJyGuLW0rBhR05nDPMDGYeoBSPxr5hJWAV36uQO9BH5VIEViNALWBR7U
 oQYN9p6H82/HiCCxqehAFptpS0QZ7mwKD+Ica5sN6rJjdUCtWg44xyYG4B7hNuL3FvOK
 U4rWhfpxDsO2qrtg/WA5RO3FLQzaogyLFDZtM+ZJrlg/I0ilPNrdBJyNMJJGdWOK2C0Y
 hvwQ94Sd4417xajCWwyU1lAefoDsJAMkRnRrTXqkltPYT4ekv9aX6PsQTUzBBWnqmvuL
 AErT0enIwHnp+ymMn9stqCGu6uATy5FS8lpedJuQotXyxuaCuOYMxsW7wCGocM1lcp+N
 vNxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734035454; x=1734640254;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=MwvVNJX1Sea3xCbdz3WU97gbstRJovpcsoaRPiyqmYA=;
 b=vMK9BrGbSe6bHGy0Y3+gsmgRordU/UcErsJD2i6XvniJOoXNl4oylRvOU81BJwHTfk
 i1o3Kk0v3jN7cVsIijjZKHMz9mMhZWoOUx/hOnYnINmq1YeEe/MVzYaKPOjV8XVSn9Fx
 iiDeVBRTP6StKzQ4egJAhaNoasOxMvNB97L1eK6K+V+QSkx7oQ2lh5pNv/9du+43UXdH
 /nC7rqG5C0hYUY+l2ul874rug+WenawmJNkvF+9yog8YnXMpXoj8mhzAVySIBRUd2qw/
 DOYezSO9++cSZavTcby9wHAy1pnN4ckuUHCy3fu2jC+asjr9PELr3vnfG+BbIohKlBQu
 iCgw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUO00vJV3MhL1Kh+CTj8BDptjagZU9PCnTjoXCqbqRT2RDHn9oASAA2gvVl1A7xyt8XAYeaSRaDLh5/@nongnu.org
X-Gm-Message-State: AOJu0YxBDxHfEgNT8NzmjoULtE/n49nynRIXbaAJWt0SNp0BaGj077H3
 d1JHqDBb7FLI4+W3SjoEwi8fTBGrd6vfgruA8c9ipaPDSwBTKK6xzQSoVvQcyb0=
X-Gm-Gg: ASbGncsYDHxfOrAbEp0yT3Bbp+PZ4GTL7m0GB7rbBy7nFz1j3XBr6JdVrn43ItuVLx+
 zj2YW+eML7Px1g8ysjXLhoUqd+l/DZZEj9sd4F5mNf5m3eQjJ754Xxasw56Bg5wm/GmjJ+5Cb/O
 FeAKUOqmt3o6gklWYxAQ6KhH5Rs3fIX66FxbxmCmsz1qtAWoq2uFSKrEZ8W5HyiOOA5U4lY0yHM
 X4oDqMEN7OnCVfWAkBf023fYnDJWAnqvK4PhugJpmS+zFdGGgjtz/Ktrqco9kcEsdNUX0PHxvwh
 e6d0CJmV1IPZZxDtMcQxc1lQkra/
X-Google-Smtp-Source: AGHT+IFT7HRbxJwN5t5tTMjWaltCqx//NzrusFUZdFUUwr8Dd6vvzAwwr6++qCyX9QLW3DEDfVs1Kg==
X-Received: by 2002:a05:6a00:3396:b0:725:b201:2353 with SMTP id
 d2e1a72fcca58-729069c8fbbmr2125351b3a.13.1734035453873; 
 Thu, 12 Dec 2024 12:30:53 -0800 (PST)
Received: from [192.168.1.67] (216-180-64-156.dyn.novuscom.net.
 [216.180.64.156]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-725eeed027csm7459893b3a.131.2024.12.12.12.30.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 12 Dec 2024 12:30:53 -0800 (PST)
Message-ID: <1b8d4314-d71b-4f96-aff6-9dc5960c1f25@linaro.org>
Date: Thu, 12 Dec 2024 12:30:52 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/18] include: Include missing 'qemu/clang-tsa.h' header
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
References: <20241212185341.2857-1-philmd@linaro.org>
 <20241212185341.2857-4-philmd@linaro.org>
 <f2e5348e-8773-460a-a586-8e5be7a87f3b@linaro.org>
 <cffc3e39-bbd6-4acb-9033-7740ed479533@linaro.org>
Content-Language: en-US
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <cffc3e39-bbd6-4acb-9033-7740ed479533@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x429.google.com
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

T24gMTIvMTIvMjQgMTI6MTgsIFBoaWxpcHBlIE1hdGhpZXUtRGF1ZMOpIHdyb3RlOg0KPiBP
biAxMi8xMi8yNCAyMDoyMiwgUGllcnJpY2sgQm91dmllciB3cm90ZToNCj4+IE9uIDEyLzEy
LzI0IDEwOjUzLCBQaGlsaXBwZSBNYXRoaWV1LURhdWTDqSB3cm90ZToNCj4+PiBUaGUgbmV4
dCBjb21taXQgd2lsbCByZW1vdmUgInFlbXUvY2xhbmctdHNhLmgiIG9mICJleGVjL2V4ZWMt
YWxsLmgiLA0KPj4+IGhvd2V2ZXIgdGhlIGZvbGxvd2luZyBmaWxlcyBpbmRpcmVjdGx5IGlu
Y2x1ZGUgaXQ6DQo+Pj4NCj4+PiAgwqDCoCAkIGdpdCBncmVwIC1MIHFlbXUvY2xhbmctdHNh
LmggJChnaXQgZ3JlcCAtd2wgVFNBX05PX1RTQSkNCj4+PiAgwqDCoCBibG9jay9jcmVhdGUu
Yw0KPj4+ICDCoMKgIGluY2x1ZGUvYmxvY2svYmxvY2tfaW50LWNvbW1vbi5oDQo+Pj4gIMKg
wqAgdGVzdHMvdW5pdC90ZXN0LWJkcnYtZHJhaW4uYw0KPj4+ICDCoMKgIHRlc3RzL3VuaXQv
dGVzdC1ibG9jay1pb3RocmVhZC5jDQo+Pj4gIMKgwqAgdXRpbC9xZW11LXRocmVhZC1wb3Np
eC5jDQo+Pj4NCj4+PiBFeHBsaWNpdGx5IGluY2x1ZGUgaXQgc28gd2UgY2FuIHByb2Nlc3Mg
d2l0aCB0aGUgcmVtb3ZhbCBpbiB0aGUNCj4+PiBuZXh0IGNvbW1pdC4NCj4+Pg0KPj4+IFNp
Z25lZC1vZmYtYnk6IFBoaWxpcHBlIE1hdGhpZXUtRGF1ZMOpIDxwaGlsbWRAbGluYXJvLm9y
Zz4NCj4+PiAtLS0NCj4+PiAgwqAgaW5jbHVkZS9ibG9jay9ibG9ja19pbnQtY29tbW9uLmgg
fCAxICsNCj4+PiAgwqAgYmxvY2svY3JlYXRlLmPCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgfCAxICsNCj4+PiAgwqAgdGVzdHMvdW5pdC90ZXN0LWJkcnYtZHJhaW4u
Y8KgwqDCoMKgIHwgMSArDQo+Pj4gIMKgIHRlc3RzL3VuaXQvdGVzdC1ibG9jay1pb3RocmVh
ZC5jIHwgMSArDQo+Pj4gIMKgIHV0aWwvcWVtdS10aHJlYWQtcG9zaXguY8KgwqDCoMKgwqDC
oMKgwqAgfCAxICsNCj4+PiAgwqAgNSBmaWxlcyBjaGFuZ2VkLCA1IGluc2VydGlvbnMoKykN
Cj4+Pg0KPj4+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2Jsb2NrL2Jsb2NrX2ludC1jb21tb24u
aCBiL2luY2x1ZGUvYmxvY2svDQo+Pj4gYmxvY2tfaW50LWNvbW1vbi5oDQo+Pj4gaW5kZXgg
ZWJiNGU1NmE1MDMuLmJiOTFhMGY2MmZhIDEwMDY0NA0KPj4+IC0tLSBhL2luY2x1ZGUvYmxv
Y2svYmxvY2tfaW50LWNvbW1vbi5oDQo+Pj4gKysrIGIvaW5jbHVkZS9ibG9jay9ibG9ja19p
bnQtY29tbW9uLmgNCj4+PiBAQCAtMjgsNiArMjgsNyBAQA0KPj4+ICDCoCAjaW5jbHVkZSAi
YmxvY2svYmxvY2stY29tbW9uLmgiDQo+Pj4gIMKgICNpbmNsdWRlICJibG9jay9ibG9jay1n
bG9iYWwtc3RhdGUuaCINCj4+PiAgwqAgI2luY2x1ZGUgImJsb2NrL3NuYXBzaG90LmgiDQo+
Pj4gKyNpbmNsdWRlICJxZW11L2NsYW5nLXRzYS5oIg0KPj4+ICDCoCAjaW5jbHVkZSAicWVt
dS9pb3YuaCINCj4+PiAgwqAgI2luY2x1ZGUgInFlbXUvcmN1LmgiDQo+Pj4gIMKgICNpbmNs
dWRlICJxZW11L3N0YXRzNjQuaCINCj4+PiBkaWZmIC0tZ2l0IGEvYmxvY2svY3JlYXRlLmMg
Yi9ibG9jay9jcmVhdGUuYw0KPj4+IGluZGV4IDZiMjNhMjE2NzUzLi43MmFiYWZiNGMxMiAx
MDA2NDQNCj4+PiAtLS0gYS9ibG9jay9jcmVhdGUuYw0KPj4+ICsrKyBiL2Jsb2NrL2NyZWF0
ZS5jDQo+Pj4gQEAgLTI0LDYgKzI0LDcgQEANCj4+PiAgwqAgI2luY2x1ZGUgInFlbXUvb3Nk
ZXAuaCINCj4+PiAgwqAgI2luY2x1ZGUgImJsb2NrL2Jsb2NrX2ludC5oIg0KPj4+ICsjaW5j
bHVkZSAicWVtdS9jbGFuZy10c2EuaCINCj4+PiAgwqAgI2luY2x1ZGUgInFlbXUvam9iLmgi
DQo+Pj4gIMKgICNpbmNsdWRlICJxZW11L21haW4tbG9vcC5oIg0KPj4+ICDCoCAjaW5jbHVk
ZSAicWFwaS9xYXBpLWNvbW1hbmRzLWJsb2NrLWNvcmUuaCINCj4+PiBkaWZmIC0tZ2l0IGEv
dGVzdHMvdW5pdC90ZXN0LWJkcnYtZHJhaW4uYyBiL3Rlc3RzL3VuaXQvdGVzdC1iZHJ2LWRy
YWluLmMNCj4+PiBpbmRleCA3NDEwZTZmMzUyOC4uOThhZDg5YjM5MGMgMTAwNjQ0DQo+Pj4g
LS0tIGEvdGVzdHMvdW5pdC90ZXN0LWJkcnYtZHJhaW4uYw0KPj4+ICsrKyBiL3Rlc3RzL3Vu
aXQvdGVzdC1iZHJ2LWRyYWluLmMNCj4+PiBAQCAtMjgsNiArMjgsNyBAQA0KPj4+ICDCoCAj
aW5jbHVkZSAic3lzdGVtL2Jsb2NrLWJhY2tlbmQuaCINCj4+PiAgwqAgI2luY2x1ZGUgInFh
cGkvZXJyb3IuaCINCj4+PiAgwqAgI2luY2x1ZGUgInFlbXUvbWFpbi1sb29wLmgiDQo+Pj4g
KyNpbmNsdWRlICJxZW11L2NsYW5nLXRzYS5oIg0KPj4+ICDCoCAjaW5jbHVkZSAiaW90aHJl
YWQuaCINCj4+PiAgwqAgc3RhdGljIFFlbXVFdmVudCBkb25lX2V2ZW50Ow0KPj4+IGRpZmYg
LS1naXQgYS90ZXN0cy91bml0L3Rlc3QtYmxvY2staW90aHJlYWQuYyBiL3Rlc3RzL3VuaXQv
dGVzdC1ibG9jay0NCj4+PiBpb3RocmVhZC5jDQo+Pj4gaW5kZXggMjZhNmMwNTE3NTguLjFk
ZTA0YThhMTNkIDEwMDY0NA0KPj4+IC0tLSBhL3Rlc3RzL3VuaXQvdGVzdC1ibG9jay1pb3Ro
cmVhZC5jDQo+Pj4gKysrIGIvdGVzdHMvdW5pdC90ZXN0LWJsb2NrLWlvdGhyZWFkLmMNCj4+
PiBAQCAtMjksNiArMjksNyBAQA0KPj4+ICDCoCAjaW5jbHVkZSAic3lzdGVtL2Jsb2NrLWJh
Y2tlbmQuaCINCj4+PiAgwqAgI2luY2x1ZGUgInFhcGkvZXJyb3IuaCINCj4+PiAgwqAgI2lu
Y2x1ZGUgInFhcGkvcW1wL3FkaWN0LmgiDQo+Pj4gKyNpbmNsdWRlICJxZW11L2NsYW5nLXRz
YS5oIg0KPj4+ICDCoCAjaW5jbHVkZSAicWVtdS9tYWluLWxvb3AuaCINCj4+PiAgwqAgI2lu
Y2x1ZGUgImlvdGhyZWFkLmgiDQo+Pj4gZGlmZiAtLWdpdCBhL3V0aWwvcWVtdS10aHJlYWQt
cG9zaXguYyBiL3V0aWwvcWVtdS10aHJlYWQtcG9zaXguYw0KPj4+IGluZGV4IGIyZTI2ZTIx
MjA1Li42ZmZmNDE2MmFjNiAxMDA2NDQNCj4+PiAtLS0gYS91dGlsL3FlbXUtdGhyZWFkLXBv
c2l4LmMNCj4+PiArKysgYi91dGlsL3FlbXUtdGhyZWFkLXBvc2l4LmMNCj4+PiBAQCAtMTcs
NiArMTcsNyBAQA0KPj4+ICDCoCAjaW5jbHVkZSAicWVtdS10aHJlYWQtY29tbW9uLmgiDQo+
Pj4gIMKgICNpbmNsdWRlICJxZW11L3RzYW4uaCINCj4+PiAgwqAgI2luY2x1ZGUgInFlbXUv
Yml0bWFwLmgiDQo+Pj4gKyNpbmNsdWRlICJxZW11L2NsYW5nLXRzYS5oIg0KPj4+ICDCoCAj
aWZkZWYgQ09ORklHX1BUSFJFQURfU0VUX05BTUVfTlANCj4+PiAgwqAgI2luY2x1ZGUgPHB0
aHJlYWRfbnAuaD4NCj4+DQo+PiBTZWVtcyBsaWtlIGEgYmV0dGVyIHBsYWNlIGZvciBhbGwg
dGhpcyB3b3VsZCBiZSBpbjoNCj4+IGluY2x1ZGUvcWVtdS9jb21waWxlci5oLCBpbnN0ZWFk
IG9mIGEgc2VwYXJhdGUgY2xhbmctdHNhIGhlYWRlci4NCj4gDQo+IFllYWggSSB3YXMgdGhp
bmtpbmcgdGhlIHNhbWUsIGJ1dCBzaW5jZSB0aGVyZSBpcyBhbHJlYWR5IGFub3RoZXINCj4g
aGVhZGVyLCBJIGRpZG4ndCB3YW50IHRvIGRlbGF5IHRoaXMgY2xlYW51cCBmdXJ0aGVyIGJ5
IG1vZGlmeWluZw0KPiB1bnJlbGF0ZWQgZmlsZXMuDQo+DQoNCk5vIHdvcnJpZXMsIHRoYXQn
cyB3aHkgSSBzdGlsbCBzZW50IGEgcmV2aWV3ZWQtYnkuDQoNCj4+IEJ1dCBmb3IgdGhlIGN1
cnJlbnQgdmVyc2lvbiwNCj4+IFJldmlld2VkLWJ5OiBQaWVycmljayBCb3V2aWVyIDxwaWVy
cmljay5ib3V2aWVyQGxpbmFyby5vcmc+DQo+IA0KPiBUaGFua3MhDQoNCg==

