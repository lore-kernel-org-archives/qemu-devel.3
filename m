Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B25BC282EC
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Mar 2025 18:38:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tri1M-0004de-Ql; Mon, 10 Mar 2025 14:38:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tri1C-0004aA-RW
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 14:38:29 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tri1A-0007HZ-LN
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 14:38:26 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-224341bbc1dso54161045ad.3
 for <qemu-devel@nongnu.org>; Mon, 10 Mar 2025 11:38:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741631901; x=1742236701; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=/DP5AjGkk70wA+kwuqXB6qU7MxjRwwqk69PGEbR4F1w=;
 b=lLHAaL8S/wyBDsRHLcfNZfKTxiur430dkeUnANJJumtJL3b2E1vL7kbYBrACG8Z74j
 h9VHmRP3DSqC6imEvHHCjVr/5+GepbG19jaLuFy5m8RY3XDUfTouEuPKoBVBk0AKv7Sw
 afLSLkFIcogVJI/6wzobAApZVG7vOS035WjWphnGZNx2mMaeprRuA4gGT1arR/+x1GQI
 FLO2dT8/x7S+qg9iPgDVjrontZPF2BW2ASkphGx/Y/pdPo1sY5fj2xxo8MVpNKJOP+OG
 xlq29WQu8dgOroPxHAONBlus2gXp2gLQEicPQCERFvXTB8QEOHVQjVc6j9ysknN6VzRH
 ef+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741631901; x=1742236701;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/DP5AjGkk70wA+kwuqXB6qU7MxjRwwqk69PGEbR4F1w=;
 b=uWZl3qu5cJE6RHtdXT6vhKrWEv6BWrSOmFKAMWCz/Et/tSJ/nZSq6GLgAZ374ExibU
 P9VJieS9CXYAQmp92n8WeKQeT4RcxB2Q9YZfxeoySMZij7gOOMuo4Q5Wj9E6C63NJN8F
 fPFeo8B3p6JlIE2NTGKLO+jGMf+g2WUNKyIVPQxc2g5kyWA2v7MUxI5G6oSuAte8CWIS
 v2M1kzGNsKDmfERpPOxJaJwU8W/P6lpmreS5ih2bljw+Em/hvN+olf4vugDH+bvhPS8p
 2dv1N6/3TNbm/vt2/bI/jCHGJ6m9cAAiQfRB56egTimSbPvdnJqymo+TlqeocguUb20Q
 pSqg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX+udKc+QgSaHXhA6VMKeGQiL/DF5rn5JA4F5509ncSZFvXtu4N1dZanL6SSb5BZ04hu3f+RBfTozl+@nongnu.org
X-Gm-Message-State: AOJu0YxJxQTONag0G6158H+BrsORs1qpy9mhVF2sl6BG1YeDi3gFg7SS
 9In0x9OWHyWbJStcWFMf2vbrZmrnPYOy8YLdAET8Wwugmz9rmwMLVG1FYgirymwqFJR77p0ALpJ
 wOS8=
X-Gm-Gg: ASbGncv3mFyhI1vXZWubsPejnKMS0AkGguprqD7GFCM13nfQlW11KxwLquGvTlzJ3YN
 0mkzc7yFYgZd4d02mgUXouGmqs+dkS3i2oiOWgu2fL43+tdki0KYWWtAzp/m6m8ZqwVX+qQ6jkF
 JTJ6LeHs1iiiM+wpM4NiedpYMzSnXSD9oS3GvI+PoIpXCT0kHyiCkOpZZ736D8JBkCFxGBGJkuV
 MwtFM6xho4Lg4x7BAEaf0ST9ADivlUU6hnTBLEbTox1izVUJN03hj6SXApF7CAMHU0bQi/Gajs2
 ZcHSKk4DXn9zw+fD241Kb96UnEhVHsYkYJPm3weivYXPWLg8whQxdwxZrQ==
X-Google-Smtp-Source: AGHT+IGuIyinBDl/hnQ54/dDKijd7oKxOoedXYG5HmZVr4E3KOARPWgq6G/gjBlq/QB9dQ6YO6lp6w==
X-Received: by 2002:a17:903:2d1:b0:224:1eaa:5de1 with SMTP id
 d9443c01a7336-22592e2ca63mr11300885ad.18.1741631900874; 
 Mon, 10 Mar 2025 11:38:20 -0700 (PDT)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73698206989sm8698359b3a.21.2025.03.10.11.38.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Mar 2025 11:38:20 -0700 (PDT)
Message-ID: <ebcdf213-fcd7-4417-9b2e-8fb3826a8002@linaro.org>
Date: Mon, 10 Mar 2025 11:38:19 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 15/16] system/memory: make compilation unit common
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250310045842.2650784-1-pierrick.bouvier@linaro.org>
 <20250310045842.2650784-16-pierrick.bouvier@linaro.org>
 <76b4e445-0676-4982-a2c8-d273c49a9170@linaro.org>
 <2d631838-e8a5-48d9-8235-9a41ffc3381c@linaro.org>
 <76269a95-652a-4064-8f2f-6584b0677191@linaro.org>
 <b411c27f-3f38-4d22-97ff-fa36ae77fb6e@linaro.org>
 <5bd88057-3e3e-4c34-9d06-68916c95f647@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <5bd88057-3e3e-4c34-9d06-68916c95f647@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62c.google.com
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

T24gMy8xMC8yNSAxMToyNywgUGhpbGlwcGUgTWF0aGlldS1EYXVkw6kgd3JvdGU6DQo+IE9u
IDEwLzMvMjUgMTk6MDQsIFBpZXJyaWNrIEJvdXZpZXIgd3JvdGU6DQo+PiBPbiAzLzEwLzI1
IDEwOjU4LCBSaWNoYXJkIEhlbmRlcnNvbiB3cm90ZToNCj4+PiBPbiAzLzEwLzI1IDEwOjQ3
LCBQaWVycmljayBCb3V2aWVyIHdyb3RlOg0KPj4+Pj4gTWF5YmUgYmV0dGVyIGFzDQo+Pj4+
Pg0KPj4+Pj4gIMKgwqDCoMKgwqDCoCBNZW1PcCBtb3AgPSAodGFyZ2V0X3dvcmRzX2JpZ2Vu
ZGlhbigpID8gTU9fQkUgOiBNT19MRSkgfA0KPj4+Pj4gc2l6ZV9tZW1vcChzaXplKTsNCj4+
Pj4+ICDCoMKgwqDCoMKgwqAgYWRqdXN0X2VuZGlhbm5lc3MobXIsICZtcmZkLmRhdGEsIHNp
emVfbWVtb3Aoc2l6ZSksIG1vcCk7DQo+Pj4+Pg0KPj4+Pg0KPj4+PiBEbyB5b3UgdGhpbmsg
ZGVmaW5pbmcgTU9fVEUgYXMgdGhpcyBleHByZXNzaW9uIGlzIGEgZ29vZCBpZGVhPw0KPj4+
DQo+Pj4gVGhlcmUgYXJlIG5vdCBzbyBtYW55IHJlZmVyZW5jZXMgdG8gTU9fVEUgb3V0c2lk
ZSB0YXJnZXQvIG9yIGFjY2VsL3RjZy8uDQo+Pj4NCj4+PiBJbmRlZWQsIGFmdGVyIHRoaXMg
Y2hhbmdlLCB0aGUgb25seSBvbmVzIGxlZnQgYXJlIGluIGh3L2FybS9hcm12N20uYywNCj4+
PiB3aGljaCAoYmVjYXVzZSBpdCdzIEFybSkgY2FuIGJlIGNoYW5nZWQgdG8gTU9fTEUuDQo+
Pj4NCj4+DQo+PiBJIHNlZSBhIGJpdCBtb3JlIHRoYW4gdGhhdCAoMTcgZmlsZXMpOg0KPj4g
aHcvYXJtL2FybXY3bS5jDQo+PiBpbmNsdWRlL2V4ZWMvbWVtb3AuaA0KPj4gdGFyZ2V0L2Fy
bS90Y2cvaGVscGVyLWE2NC5jDQo+PiB0YXJnZXQvYXJtL3RjZy90cmFuc2xhdGUuYw0KPj4g
dGFyZ2V0L2hleGFnb24vaWRlZi1wYXJzZXIvcGFyc2VyLWhlbHBlcnMuYw0KPj4gdGFyZ2V0
L2hwcGEvdHJhbnNsYXRlLmMNCj4+IHRhcmdldC9pMzg2L3RjZy9lbWl0LmMuaW5jDQo+PiB0
YXJnZXQvbG9vbmdhcmNoL3RjZy9pbnNuX3RyYW5zL3RyYW5zX3ZlYy5jLmluYw0KPj4gdGFy
Z2V0L202OGsvdHJhbnNsYXRlLmMNCj4+IHRhcmdldC9taXBzL3RjZy9taXBzMTZlX3RyYW5z
bGF0ZS5jLmluYw0KPj4gdGFyZ2V0L3Jpc2N2L3RyYW5zbGF0ZS5jDQo+PiB0YXJnZXQvcngv
dHJhbnNsYXRlLmMNCj4+IHRhcmdldC9zMzkweC90Y2cvbWVtX2hlbHBlci5jDQo+PiB0YXJn
ZXQvczM5MHgvdGNnL3RyYW5zbGF0ZS5jDQo+PiB0YXJnZXQvczM5MHgvdGNnL3RyYW5zbGF0
ZV92eC5jLmluYw0KPj4gdGFyZ2V0L3NwYXJjL2xkc3RfaGVscGVyLmMNCj4+IHRhcmdldC9z
cGFyYy90cmFuc2xhdGUuYw0KPiANCj4gRm9yIHRhcmdldHMgdGllZCB0byBzaW5nbGUgZW5k
aWFubmVzcywgd2UgY2FuIHJlcGxhY2UgdXNpbmcgZ3NlZCwNCj4gYnV0IHVzaW5nIGEgaGVs
cGVyIGlzIGNsZWFyZXIgKHNlZSBmb3IgZXhhbXBsZSBjb21taXQgNDE1YWFlNTQzZWQNCj4g
dGFyZ2V0L21pY3JvYmxhemU6IENvbnNpZGVyIGVuZGlhbm5lc3Mgd2hpbGUgdHJhbnNsYXRp
bmcgY29kZSIpLg0KPiANCg0KVGhhdCdzIGdvb2QsIEkganVzdCB3YW50IHRvIGtlZXAgdGhp
cyBzZXJpZXMgZm9jdXMgb24gbWluaW1hbCBjaGFuZ2VzIHRvIA0KYWNoaWV2ZSB0aGUgY3Vy
cmVudCBnb2FsLCBhbmQgbm90IGJyaW5nIGFueSBhZGRpdGlvbmFsIHJlZmFjdG9yaW5nIGhl
cmUuDQoNCj4+IFBsdXMgbW9yZSAoMjIgZmlsZXMpIHdobyByZWxpZXMgb246DQo+PiBNT19U
RSogdmFyaWFudHMgKHdoaWNoIHJlbGllcyBvbiBNT19URSB0cmFuc2l0aXZlbHkpDQo+Pg0K
Pj4gVGh1cyBteSBwcm9wb3NhbCB0byBoYXZlIGEgZmlyc3QgY2hhbmdlIHRvIE1PX1RFIGRl
ZmluaXRpb24sIGFuZA0KPj4gZXZlbnR1YWxseSBkbyB0aGUgY2hhbmdlIGxhdGVyLg0KPj4N
Cj4+IFdoYXQgZG8geW91IHRoaW5rPw0KPiANCj4gUmVtb3ZpbmcgTU9fVEUgaXMgaW4gbXkg
VE9ETyBsaXN0Lg0KPiANCj4gSSBzdGFydGVkIHdpdGggTWljcm9ibGF6ZSAobm93IG1lcmdl
ZCkgdG8gZ2V0IGZhbWlsaWFyLCB0aGVuIGhhZA0KPiBhIGxvb2sgYXQgQVJNIChzZWUgaS5l
Lg0KPiBodHRwczovL2xvcmUua2VybmVsLm9yZy9xZW11LWRldmVsLzIwMjQwOTI0MTkxOTMy
LjQ5Mzg2LTEtcGhpbG1kQGxpbmFyby5vcmcvDQo+IGFuZA0KPiBodHRwczovL2xvcmUua2Vy
bmVsLm9yZy9xZW11LWRldmVsL2Q4MzE2MDBhLTlhNjEtNDVjMS1hNTM1LWY3NWJiNjRjZGZm
NEBsaW5hcm8ub3JnLykuDQo+IEkgYWxzbyB0b29rIGNhcmUgb2YgTUlQUyBmZXcgeWVhcnMg
YWdvIGJ1dCBJIG5lZWQgdG8gcmViYXNlLA0KPiBob3dldmVyIGl0IGlzbid0IGluIHRoZSBw
cmlvcml0eSBsaXN0Lg0KDQpJbnN0ZWFkIG9mIGRvaW5nIGEgZnVsbCBjb2RlYmFzZSByZWZh
Y3RvcmluZy9jbGVhbnVwLCB3ZSBjYW4gYWRvcHQgYSAiYXMgDQpuZWVkZWQgYmFzaXMiIGFw
cHJvYWNoLg0KDQpCYXNpY2FsbHkgYXJjaGl0ZWN0dXJlcyB0aGF0IGNhbiBoYXZlIHZhcnlp
bmcgZW5kaWFubmVzcyBtdXN0IGJlIGhhbmRsZWQgDQooc2luY2UgdGhlaXIgY29tcGlsYXRp
b24gdW5pdHMgYXJlIGR1cGxpY2F0ZWQgZm9yIHZhcmlhbnRzKS4NCkZvciB0aGUgcmVzdCwg
YXMgUmljaGFyZCBtZW50aW9uZWQgb24gdGhpcyBzZXJpZXMsIHRoZSBjb2RlIHdpbGwgc3Rh
eSANCnRhcmdldCBzcGVjaWZpYywgY29tcGlsaW5nIHdpdGggYSBzaW5nbGUgc2V0IG9mIGRl
ZmluZXMsIHdoaWNoIGlzIHdoYXQgDQp3ZSByZWFsbHkgYWltIGZvci4NCg0KU2FtZSBkaXNj
dXNzaW9uIHdpbGwgaGFwcGVuIGZvciBhcmNoaXRlY3R1cmVzIHdpdGggZmlsZXMgZHVwbGlj
YXRlZCANCmJldHdlZW4gMzIvNjQgYml0cyB2YXJpYW50cy4NCg==

