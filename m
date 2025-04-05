Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D744C36010
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Apr 2025 01:05:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0ryd-0002Uk-QR; Fri, 04 Apr 2025 21:05:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u0ryJ-0002Jg-SF
 for qemu-devel@nongnu.org; Fri, 04 Apr 2025 21:05:25 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u0ryH-0000H4-Kd
 for qemu-devel@nongnu.org; Fri, 04 Apr 2025 21:05:19 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-227aaa82fafso23894585ad.2
 for <qemu-devel@nongnu.org>; Fri, 04 Apr 2025 18:05:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743815115; x=1744419915; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=18gRym1AGQcF5VPRAt3snT8+UDKCN6adtpGYwJuYV3c=;
 b=a6uRf8Z749jJSrbhDbOzC2bxGoEGASnPwQsV0EIKePgrVaZpj6xtf372n1mRWZtMsp
 n2S35JVuUjjwXMYo38UdQpwAlU5Fggx7/8iTbNB2q4CaeKhqp5h4qYXBClYVtmbKO71g
 zSwpLqZuypBW2Oy0SwVTrUjGa76Og0otTzjJokJ3l+a6BNxv7BYvk6mq0dCZ3vvTJNGA
 Rj9WVXBXTwQUFMOzIp2vlQ8aR4zFBy2A9UK6VJzlH8s3cMlIFHp3/INdlvUclupqi2lp
 Ldn8gBkHRYRxLugFPIPfzznF/bOaULFj0Oqq41tpEWl8q6pBhgZT2DaKxx/0P1e+Kj3i
 hPxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743815115; x=1744419915;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=18gRym1AGQcF5VPRAt3snT8+UDKCN6adtpGYwJuYV3c=;
 b=exB94tba24tN8vnqA8rZ0MOh+P8tCylTGFfMsQqJuCrSRfDNv9KmZRC27SjEHrZG9o
 Esr4ee4R9/66R3gyOyXLFQjIV4XUhQ1P8BTkdcd2jDBGqmsqW7dMYDRLNNYQ1iTGqt8H
 WIittOACSEbAcDUzqlc+MVxEHGzLY4YIVMTJxcFvfmXxpHMc2sQ8BksZAHmJ8edhvNNC
 2LqYkCs6FNHGajMJu8Vk+kxfOqg/ko7o7IIfLx1lMBxD0qh+tSCdGAo8BXE3n5o+1yZM
 Sk2GleqXNoyx8CK9vi2Eh6Osol4Lb/7bFbUL3bC0jbJ7GLIXmQP5NHGZgd2MTLNr/dX4
 vDQw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWpOD1NSUlviUtKshSA/UfEJ34Uw7iWsR0MFegQwSbagFPi6KpsogFQrmZazxSeKP4nC466/oDFFU+a@nongnu.org
X-Gm-Message-State: AOJu0YyhEDFpUpYjfL7Noi6KD3wZzGaXQP/3dmh6kQumBtqlm4zzHyXh
 Ow/LeEJ5pcB37YTajlA5RVZk2VPETfwdnXzScRXjQGncUq9al74lHPCDjKZhG4M=
X-Gm-Gg: ASbGncuAMtQfTcmIWaeiD52aF57S3bxIIDZTzOIbZ0/dDT1pttzjKWcS4Uvs18GiZXB
 prGkTDB/OMWNCE+oGoPzZiu5TZ/Mb2va0K37bIAqPqikJwnIu1XBj45DfHCBoez6Bl49kB1dik5
 u9oqEy+5kjvBpAZMW0dNs8xgySkiam3GkT75LiIC49/xkL39qiu2Xl4SLiEY+z4IeQuT77orULs
 TSSBw+oQWVa0Kn0Y0Nbl4ujnygmjketS6ZeZWW8Ez+ydyf8i2HMMn1YvJMhDy0XkSvh2g4lnrtc
 17XqKy+c7zidg6cJq2DqJG5R6h73NukZ2XozVhPm1QEpuUnI51DeHZUKCA==
X-Google-Smtp-Source: AGHT+IGZ4qFhEFm4ZesW8hK42jPr1xRjdFp+Gi4EfxAfui8bI4uWXhO4TzcdqBI/YmNSGTAH/uS+Sw==
X-Received: by 2002:a17:903:2f8c:b0:224:1780:c1ec with SMTP id
 d9443c01a7336-22a8a1bb283mr74431145ad.35.1743815115187; 
 Fri, 04 Apr 2025 18:05:15 -0700 (PDT)
Received: from [192.168.1.87] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2297866e6fdsm38968045ad.165.2025.04.04.18.05.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 04 Apr 2025 18:05:14 -0700 (PDT)
Message-ID: <e80d0ac6-6be0-4bd5-93b2-c9e7b0b427d3@linaro.org>
Date: Fri, 4 Apr 2025 18:05:14 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH-for-10.1 27/39] system/hvf: Expose hvf_enabled() to
 common code
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Markus Armbruster <armbru@redhat.com>
References: <20250403235821.9909-1-philmd@linaro.org>
 <20250403235821.9909-28-philmd@linaro.org>
 <0e88a1ae-f9a3-4a06-9977-e5ce9b1b626e@linaro.org>
 <ed3f2bd6-2628-4d58-b426-c41ec587759a@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <ed3f2bd6-2628-4d58-b426-c41ec587759a@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62d.google.com
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

T24gNC80LzI1IDE0OjU2LCBQaGlsaXBwZSBNYXRoaWV1LURhdWTDqSB3cm90ZToNCj4gK1Bh
b2xvDQo+IA0KPiBPbiA0LzQvMjUgMjA6MjMsIFBpZXJyaWNrIEJvdXZpZXIgd3JvdGU6DQo+
PiBPbiA0LzMvMjUgMTY6NTgsIFBoaWxpcHBlIE1hdGhpZXUtRGF1ZMOpIHdyb3RlOg0KPj4+
IEN1cnJlbnRseSBodmZfZW5hYmxlZCgpIGlzIHJlc3RyaWN0ZWQgdG8gdGFyZ2V0LXNwZWNp
ZmljIGNvZGUuDQo+Pj4gQnkgZGVmaW5pbmcgQ09ORklHX0hWRl9JU19QT1NTSUJMRSB3ZSBh
bGxvdyBpdHMgdXNlIGFueXdoZXJlLg0KPj4+DQo+Pg0KPj4gSW5zdGVhZCwgd2UgY2FuIHNp
bXBseSBtYWtlIGh2Zl9lbmFibGVkIHByZXNlbnQgZm9yIGNvbW1vbiBhbmQgdGFyZ2V0DQo+
PiBzcGVjaWZpYyBjb2RlLCBhbmQgbGluayBjb3JyZWN0IGltcGxlbWVudGF0aW9uLCBiYXNl
ZCBvbiB3aGF0IHdlIGJ1aWxkLg0KPj4NCj4+IEkgZG9uJ3QgdGhpbmsgKl9JU19QT1NTSUJM
RSB3YXMgYSBnb29kIGlkZWEgdG8gc3RhcnQgd2l0aC4NCj4gDQo+IElJVUMgdGhlIHBvaW50
IG9mICpfSVNfUE9TU0lCTEUgaXMgdG8gZWxpZGUgY29kZSwgd2hpY2ggd2UNCj4gYXJlbid0
IGludGVyZXN0ZWQgYW55bW9yZSBmb3IgaG9zdC1yZWxhdGVkIGNvbmZpZ3MsIHNvIHdlDQo+
IGNhbiBhbHNvIHJlbW92ZSBDT05GSUdfS1ZNX0lTX1BPU1NJQkxFIGFuZCBDT05GSUdfWEVO
X0lTX1BPU1NJQkxFLg0KPiBJcyB0aGF0IGNvcnJlY3Q/DQo+IA0KDQpJZGVhbGx5LCB5ZXMs
IHdlIHNob3VsZCBub3QgaGF2ZSBhbnkgQ09ORklHX3thY2NlbH0sIG9mIGFueSANCkNPTkZJ
R197YWNjZWx9X0lTX1BPU1NJQkxFIGluIHRoZSBjb2RlLg0KSXQgc2hvdWxkIG9ubHkgYmUg
dXNlZCBpbiBidWlsZCBzeXN0ZW0gdG8gaW5jbHVkZSBzZWxlY3RpdmVseSANCmltcGxlbWVu
dGF0aW9ucyBiYXNlZCBvbiBob3N0IHN1cHBvcnRpbmcgaXQgb3Igbm90Lg0KDQpJdCdzIG5v
dCBuZWVkZWQgdG8gY2xlYW4gdGhhdCByaWdodCBub3csIGJ1dCBpZiB3ZSBjYW4gYXZvaWQg
dG8gDQpyZXByb2R1Y2UgdGhpcyBmb3IgSFZGLCBpdCdzIGJldHRlci4NCg0KPj4NCj4+PiBT
aWduZWQtb2ZmLWJ5OiBQaGlsaXBwZSBNYXRoaWV1LURhdWTDqSA8cGhpbG1kQGxpbmFyby5v
cmc+DQo+Pj4gLS0tDQo+Pj4gIMKgIE1BSU5UQUlORVJTwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIHzCoCAxICsNCj4+PiAgwqAgaW5jbHVkZS9zeXN0ZW0vaHZmLmjCoMKgwqAgfCAxNCAr
KysrKysrKystLS0tLQ0KPj4+ICDCoCBhY2NlbC9zdHVicy9odmYtc3R1Yi5jwqAgfCAxMiAr
KysrKysrKysrKysNCj4+PiAgwqAgYWNjZWwvc3R1YnMvbWVzb24uYnVpbGQgfMKgIDEgKw0K
Pj4+ICDCoCA0IGZpbGVzIGNoYW5nZWQsIDIzIGluc2VydGlvbnMoKyksIDUgZGVsZXRpb25z
KC0pDQo+Pj4gIMKgIGNyZWF0ZSBtb2RlIDEwMDY0NCBhY2NlbC9zdHVicy9odmYtc3R1Yi5j
DQo+Pj4NCj4+PiBkaWZmIC0tZ2l0IGEvTUFJTlRBSU5FUlMgYi9NQUlOVEFJTkVSUw0KPj4+
IGluZGV4IGM3MDgzYWIxZDkzLi4wMGVmMzNiZTBlMiAxMDA2NDQNCj4+PiAtLS0gYS9NQUlO
VEFJTkVSUw0KPj4+ICsrKyBiL01BSU5UQUlORVJTDQo+Pj4gQEAgLTUyNSw2ICs1MjUsNyBA
QCBSOiBQaGlsIERlbm5pcy1Kb3JkYW4gPHBoaWxAcGhpbGpvcmRhbi5ldT4NCj4+PiAgwqAg
VzogaHR0cHM6Ly93aWtpLnFlbXUub3JnL0ZlYXR1cmVzL0hWRg0KPj4+ICDCoCBTOiBNYWlu
dGFpbmVkDQo+Pj4gIMKgIEY6IGFjY2VsL2h2Zi8NCj4+PiArRjogYWNjZWwvc3R1YnMvaHZm
LXN0dWIuYw0KPj4+ICDCoCBGOiBpbmNsdWRlL3N5c3RlbS9odmYuaA0KPj4+ICDCoCBGOiBp
bmNsdWRlL3N5c3RlbS9odmZfaW50LmgNCj4+PiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9zeXN0
ZW0vaHZmLmggYi9pbmNsdWRlL3N5c3RlbS9odmYuaA0KPj4+IGluZGV4IGQ1MDA0OWUxYTFh
Li43YjQ1YTJlMTk4OCAxMDA2NDQNCj4+PiAtLS0gYS9pbmNsdWRlL3N5c3RlbS9odmYuaA0K
Pj4+ICsrKyBiL2luY2x1ZGUvc3lzdGVtL2h2Zi5oDQo+Pj4gQEAgLTE5LDE1ICsxOSwxOSBA
QA0KPj4+ICDCoCAjaW5jbHVkZSAicW9tL29iamVjdC5oIg0KPj4+ICDCoCAjaWZkZWYgQ09N
UElMSU5HX1BFUl9UQVJHRVQNCj4+PiArIyBpZmRlZiBDT05GSUdfSFZGDQo+Pj4gKyPCoCBk
ZWZpbmUgQ09ORklHX0hWRl9JU19QT1NTSUJMRQ0KPj4+ICsjIGVuZGlmIC8qICFDT05GSUdf
SFZGICovDQo+Pj4gKyNlbHNlDQo+Pj4gKyMgZGVmaW5lIENPTkZJR19IVkZfSVNfUE9TU0lC
TEUNCj4+PiArI2VuZGlmIC8qIENPTVBJTElOR19QRVJfVEFSR0VUICovDQo+Pj4gLSNpZmRl
ZiBDT05GSUdfSFZGDQo+Pj4gKyNpZmRlZiBDT05GSUdfSFZGX0lTX1BPU1NJQkxFDQo+Pj4g
IMKgIGV4dGVybiBib29sIGh2Zl9hbGxvd2VkOw0KPj4+ICDCoCAjZGVmaW5lIGh2Zl9lbmFi
bGVkKCkgKGh2Zl9hbGxvd2VkKQ0KPj4+IC0jZWxzZSAvKiAhQ09ORklHX0hWRiAqLw0KPj4+
ICsjZWxzZSAvKiAhQ09ORklHX0hWRl9JU19QT1NTSUJMRSAqLw0KPj4+ICDCoCAjZGVmaW5l
IGh2Zl9lbmFibGVkKCkgMA0KPj4+IC0jZW5kaWYgLyogIUNPTkZJR19IVkYgKi8NCj4+PiAt
DQo+Pj4gLSNlbmRpZiAvKiBDT01QSUxJTkdfUEVSX1RBUkdFVCAqLw0KPj4+ICsjZW5kaWYg
LyogIUNPTkZJR19IVkZfSVNfUE9TU0lCTEUgKi8NCj4+PiAgwqAgI2RlZmluZSBUWVBFX0hW
Rl9BQ0NFTCBBQ0NFTF9DTEFTU19OQU1FKCJodmYiKQ0KPj4+IGRpZmYgLS1naXQgYS9hY2Nl
bC9zdHVicy9odmYtc3R1Yi5jIGIvYWNjZWwvc3R1YnMvaHZmLXN0dWIuYw0KPj4+IG5ldyBm
aWxlIG1vZGUgMTAwNjQ0DQo+Pj4gaW5kZXggMDAwMDAwMDAwMDAuLjQyZWFkYzVjYTkyDQo+
Pj4gLS0tIC9kZXYvbnVsbA0KPj4+ICsrKyBiL2FjY2VsL3N0dWJzL2h2Zi1zdHViLmMNCj4+
PiBAQCAtMCwwICsxLDEyIEBADQo+Pj4gKy8qDQo+Pj4gKyAqIEhWRiBzdHVicyBmb3IgUUVN
VQ0KPj4+ICsgKg0KPj4+ICsgKsKgIENvcHlyaWdodCAoYykgTGluYXJvDQo+Pj4gKyAqDQo+
Pj4gKyAqIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4wLW9yLWxhdGVyDQo+Pj4g
KyAqLw0KPj4+ICsNCj4+PiArI2luY2x1ZGUgInFlbXUvb3NkZXAuaCINCj4+PiArI2luY2x1
ZGUgInN5c3RlbS9odmYuaCINCj4+PiArDQo+Pj4gK2Jvb2wgaHZmX2FsbG93ZWQ7DQo+Pj4g
ZGlmZiAtLWdpdCBhL2FjY2VsL3N0dWJzL21lc29uLmJ1aWxkIGIvYWNjZWwvc3R1YnMvbWVz
b24uYnVpbGQNCj4+PiBpbmRleCA5MWEyZDIxOTI1OC4uOGNhMWE0NTI5ZTIgMTAwNjQ0DQo+
Pj4gLS0tIGEvYWNjZWwvc3R1YnMvbWVzb24uYnVpbGQNCj4+PiArKysgYi9hY2NlbC9zdHVi
cy9tZXNvbi5idWlsZA0KPj4+IEBAIC0yLDUgKzIsNiBAQCBzeXN0ZW1fc3R1YnNfc3MgPSBz
cy5zb3VyY2Vfc2V0KCkNCj4+PiAgwqAgc3lzdGVtX3N0dWJzX3NzLmFkZCh3aGVuOiAnQ09O
RklHX1hFTicsIGlmX2ZhbHNlOiBmaWxlcygneGVuLXN0dWIuYycpKQ0KPj4+ICDCoCBzeXN0
ZW1fc3R1YnNfc3MuYWRkKHdoZW46ICdDT05GSUdfS1ZNJywgaWZfZmFsc2U6IGZpbGVzKCdr
dm0tc3R1Yi5jJykpDQo+Pj4gIMKgIHN5c3RlbV9zdHVic19zcy5hZGQod2hlbjogJ0NPTkZJ
R19UQ0cnLCBpZl9mYWxzZTogZmlsZXMoJ3RjZy1zdHViLmMnKSkNCj4+PiArc3lzdGVtX3N0
dWJzX3NzLmFkZCh3aGVuOiAnQ09ORklHX0hWRicsIGlmX2ZhbHNlOiBmaWxlcygnaHZmLXN0
dWIuYycpKQ0KPj4+ICDCoCBzcGVjaWZpY19zcy5hZGRfYWxsKHdoZW46IFsnQ09ORklHX1NZ
U1RFTV9PTkxZJ10sIGlmX3RydWU6DQo+Pj4gc3lzdGVtX3N0dWJzX3NzKQ0KPj4NCj4gDQoN
Cg==

