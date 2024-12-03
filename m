Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C75BFE74AC3
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2024 18:25:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIXZM-0004sO-62; Tue, 03 Dec 2024 13:24:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tIXZJ-0004s2-Ov
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 13:24:17 -0500
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tIXZH-0003rE-Aj
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 13:24:16 -0500
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-7fc99fc2b16so3472456a12.3
 for <qemu-devel@nongnu.org>; Tue, 03 Dec 2024 10:24:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733250253; x=1733855053; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=yRicpJhjhTpg1qPlxyavzgixO/UppNZDPdXxUR0Ay4o=;
 b=JdvC4R2YX7+kul9rRb2i2FWdsU3bTIHBlNUbYzK6GOg1tgWq1YUjmN+Ne71859qTGy
 df45E98Eg+bOtXqYB4Q1NqOisGMxU7qwoTr1nO93XC7pcRVvTdn/napFICY1bW26eBVq
 xaW5QbhrFQ480tFCWm5aZ/sfLuHneO0KWmmr7jnNM2wp3VKNGqAGkX0iYo4HQyUBimve
 PwTY2XwNJ3K0qXh3NadNyZ/siiRaY7bmxQfhS95/nIXUdEzpnWEGQshJind1HQlPqXrh
 lvblSPinL0tbA/IiSdu6/wntvOuG0qN1MMAlphcthNTSOXybMZsn+uGLh3J0xyCeEFk8
 6ktg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733250253; x=1733855053;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=yRicpJhjhTpg1qPlxyavzgixO/UppNZDPdXxUR0Ay4o=;
 b=r9iOXOyUcEfdb409cX1Q+gLxZKtIbj3w3uwi/nC66d/V1w4XIiQQsDRDEPloM0qU1l
 FguaNxGPk1rASX7RriHdCG5zwk42IJtneBf8KK6P2Tih9pdQT3tLgkY8qfCKnUbmhMVV
 X//9R0svcXb2us6jUHrUoNahB/zyZQG45eeZD43dwndlpOMUQTH9UrJwvY+5t2QPPkkX
 jwq8XAxUN6U/K8gXbr3UkaA7DvjI+owlvWPCcJfld67JpCGuBb+sI14v34TuPHUOqv5U
 /1rvZRfBrfgtV68QtDb2ZxliCJ0cc68UmYL6No1ZscPo2mLivJxsMfdRAILdLCgyBGiD
 Qy9Q==
X-Gm-Message-State: AOJu0Yxrl/mUJZ98kMJCNDUBV7QrJmd+AYbFDSeSXJLSZ3MfuoY353XR
 zXi8m539cxs0cASz++/Xt+UrzSpxmD6KANW7XaTIh1F+KKNrzOAMnSIJAtJgqiA=
X-Gm-Gg: ASbGncsH1gsj1iRQYNRqmEOgAJ1Y3HfEUfjbMlGRBT+mBVG5dr1nB2TmMAmoV8zMdxR
 PMiiWUmKtHWKVIlpndlQUD9qCgMVUHof1hddgc8qS/1SReDLeOT23ncLqhtv/eh01GiUcnHG7w8
 DxRj9IaeAt3+PpsGz8L4aNxOxYMGO9zDzCoCWuBmNz1i4ev8VuTJqww2NVgXOpu7knjL7YUiJ6N
 FvLrPQkrEDA4GN8inW32+gtVXduYMrtu5JeaotcyEJ8oyvW8jZSsuOe542QCg6aK+oa/cBgzTSZ
 fGU+xPhsR2UCw/RsoJd62A==
X-Google-Smtp-Source: AGHT+IHuneTpULUKLV4vtUTUm6C+HlcUPz8+EYQNt0xb76hBfzxmd8whAeRj54m7FgAxWi5qX339mw==
X-Received: by 2002:a05:6a20:7f8f:b0:1e0:d333:2b9d with SMTP id
 adf61e73a8af0-1e1653c5227mr5661048637.22.1733250252997; 
 Tue, 03 Dec 2024 10:24:12 -0800 (PST)
Received: from [192.168.1.67] (216-180-64-156.dyn.novuscom.net.
 [216.180.64.156]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2ee769580dasm6996311a91.19.2024.12.03.10.24.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Dec 2024 10:24:12 -0800 (PST)
Message-ID: <8c10de63-f81f-4f51-9040-b25116e3545c@linaro.org>
Date: Tue, 3 Dec 2024 10:24:11 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] tests/functional/aarch64: add tests for FEAT_RME
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Troy Lee <leetroy@gmail.com>, Alistair Francis <alistair@alistair23.me>,
 Peter Maydell <peter.maydell@linaro.org>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Jamin Lin <jamin_lin@aspeedtech.com>, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>,
 Niek Linnenbank <nieklinnenbank@gmail.com>, Joel Stanley <joel@jms.id.au>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
References: <20241128213729.1021961-1-pierrick.bouvier@linaro.org>
 <87mshcdddn.fsf@draig.linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <87mshcdddn.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::530;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x530.google.com
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

T24gMTIvMy8yNCAwNjo1NiwgQWxleCBCZW5uw6llIHdyb3RlOg0KPiBQaWVycmljayBCb3V2
aWVyIDxwaWVycmljay5ib3V2aWVyQGxpbmFyby5vcmc+IHdyaXRlczoNCj4gDQo+PiBUaGlz
IGJvb3QgYW4gT1AtVEVFIGVudmlyb25tZW50LCBhbmQgbGF1bmNoIGEgbmVzdGVkIGd1ZXN0
IFZNIGluc2lkZSBpdA0KPj4gdXNpbmcgdGhlIFJlYWxtcyBmZWF0dXJlLiBXZSBkbyBpdCBm
b3IgdmlydCBhbmQgc2JzYS1yZWYgcGxhdGZvcm1zLg0KPj4NCj4+IFNpZ25lZC1vZmYtYnk6
IFBpZXJyaWNrIEJvdXZpZXIgPHBpZXJyaWNrLmJvdXZpZXJAbGluYXJvLm9yZz4NCj4+DQo+
IDxzbmlwPg0KPj4gKw0KPj4gKyAgICAgICAgc2VsZi52bS5hZGRfYXJncygnLWFjY2VsJywg
J3RjZycpDQo+PiArICAgICAgICBzZWxmLnZtLmFkZF9hcmdzKCctY3B1JywgJ21heCx4LXJt
ZT1vbicpDQo+IA0KPiBXaXRoIGRlYnVnIG9uIHRoZSBQQUMgZnVuY3Rpb24gYXJlIGNlcnRh
aW5seSB2ZXJ5IGhpZ2ggaW4gdGhlIHBlcmYNCj4gcmVwb3J0LiBTbyBwYXV0aC1pbXBkZWY9
b24gc2VlbXMgd29ydGh3aGlsZSBoZXJlLg0KPiANCj4+ICsgICAgICAgIHNlbGYudm0uYWRk
X2FyZ3MoJy1tJywgJzJHJykNCj4+ICsgICAgICAgIHNlbGYudm0uYWRkX2FyZ3MoJy1NJywg
J3Nic2EtcmVmJykNCj4+ICsgICAgICAgIHNlbGYudm0uYWRkX2FyZ3MoJy1kcml2ZScsIGYn
ZmlsZT17cGZsYXNoMH0sZm9ybWF0PXJhdyxpZj1wZmxhc2gnKQ0KPj4gKyAgICAgICAgc2Vs
Zi52bS5hZGRfYXJncygnLWRyaXZlJywgZidmaWxlPXtwZmxhc2gxfSxmb3JtYXQ9cmF3LGlm
PXBmbGFzaCcpDQo+PiArICAgICAgICBzZWxmLnZtLmFkZF9hcmdzKCctZHJpdmUnLCBmJ2Zp
bGU9ZmF0OnJ3Ont2aXJ0dWFsfSxmb3JtYXQ9cmF3JykNCj4+ICsgICAgICAgIHNlbGYudm0u
YWRkX2FyZ3MoJy1kcml2ZScsIGYnZm9ybWF0PXJhdyxpZj1ub25lLGZpbGU9e2RyaXZlfSxp
ZD1oZDAnKQ0KPj4gKyAgICAgICAgc2VsZi52bS5hZGRfYXJncygnLWRldmljZScsICd2aXJ0
aW8tYmxrLXBjaSxkcml2ZT1oZDAnKQ0KPj4gKyAgICAgICAgc2VsZi52bS5hZGRfYXJncygn
LWRldmljZScsICd2aXJ0aW8tOXAtcGNpLGZzZGV2PXNocjAsbW91bnRfdGFnPXNocjAnKQ0K
Pj4gKyAgICAgICAgc2VsZi52bS5hZGRfYXJncygnLWZzZGV2JywgZidsb2NhbCxzZWN1cml0
eV9tb2RlbD1ub25lLHBhdGg9e3JtZV9zdGFja30saWQ9c2hyMCcpDQo+PiArICAgICAgICBz
ZWxmLnZtLmFkZF9hcmdzKCctZGV2aWNlJywgJ3ZpcnRpby1uZXQtcGNpLG5ldGRldj1uZXQw
JykNCj4+ICsgICAgICAgIHNlbGYudm0uYWRkX2FyZ3MoJy1uZXRkZXYnLCAndXNlcixpZD1u
ZXQwJykNCj4gPHNuaXA+DQo+PiArDQo+PiArICAgICAgICBzZWxmLnZtLmFkZF9hcmdzKCct
YWNjZWwnLCAndGNnJykNCj4+ICsgICAgICAgIHNlbGYudm0uYWRkX2FyZ3MoJy1jcHUnLCAn
bWF4LHgtcm1lPW9uJykNCj4gDQo+IEFuZCBoZXJlLg0KPiANCj4gPHNuaXA+DQo+IA0KPiBX
aXRoIHRoYXQgdGhlIHRlc3RzIGJvdGggcGFzcyB3aXRoIC0tZW5hYmxlLWRlYnVnICgzMTJz
LCAzNTJzKSBhbmQgdGhlDQo+IHByb2ZpbGUgbG9va3MgbGlrZToNCj4gDQo+ICAgICA2LjMz
JSAgcWVtdS1zeXN0ZW0tYWFyICBxZW11LXN5c3RlbS1hYXJjaDY0ICAgICAgICAgICAgICAg
ICAgICAgICBbLl0gYXJtX2ZlYXR1cmUNCj4gICAgIDUuNjYlICBxZW11LXN5c3RlbS1hYXIg
IHFlbXUtc3lzdGVtLWFhcmNoNjQgICAgICAgICAgICAgICAgICAgICAgIFsuXSB0Y2dfZmx1
c2hfam1wX2NhY2hlDQo+ICAgICAzLjQ0JSAgcWVtdS1zeXN0ZW0tYWFyICBxZW11LXN5c3Rl
bS1hYXJjaDY0ICAgICAgICAgICAgICAgICAgICAgICBbLl0gcmVidWlsZF9oZmxhZ3NfYTY0
DQo+IA0KPiBUaGlzIEkgc3VzcGVjdCBpcyB0cmlnZ2VyZWQgYnkgYXNzZXJ0X2hmbGFnc19y
ZWJ1aWxkX2NvcnJlY3RseSgpIHdoaWNoDQo+IGlzIHZhbGlkYXRpbmcgd2UndmUgbm90IHNr
aXBwZWQgcmVidWlsZGluZyB0aGUgZmxhZ3Mgd2hlbiB3ZSBuZWVkIHRvLg0KPiBJdCdzIGEg
bG90IGVhc2llciB0aGFuIGRlYnVnZ2luZyB3aHkgeW91ciBleGVjdXRpb24gdHJhY2UgbG9v
a3Mgd2VpcmQuDQo+IA0KPiAgICAgMi45NSUgIHFlbXUtc3lzdGVtLWFhciAgcWVtdS1zeXN0
ZW0tYWFyY2g2NCAgICAgICAgICAgICAgICAgICAgICAgWy5dIGV4dHJhY3Q2NA0KPiAgICAg
Mi41MiUgIHFlbXUtc3lzdGVtLWFhciAgcWVtdS1zeXN0ZW0tYWFyY2g2NCAgICAgICAgICAg
ICAgICAgICAgICAgWy5dIGV4dHJhY3Q2NA0KPiANCj4gVGhpcyBpcyB1c3VhbGx5IHRyaWdn
ZXJlZCBieSB0cmFuc2xhdGlvbiBjb2RlIHdoaWNoIHVzZXMgZXh0cmFjdDY0DQo+IGhlYXZp
bHkgZHVyaW5nIGluc3RydWN0aW9uIGRlY29kZS4NCj4gDQo+IEl0IG1pZ2h0IGJlIHVzZWZ1
bCB0byBzZWUgaWYgd2UgY2FuIGdldCBmdW5jdGlvbmFsIHRlc3RzIHJ1biB1bmRlciBUQ0cN
Cj4gdG8gZHVtcCAiaW5mbyBqaXQiIGF0IHRoZSBlbmQgYW5kIGVuc3VyZSB3ZSBhcmUgbm90
IG92ZXIgZ2VuZXJhdGluZyBjb2RlDQo+IGFuZCBleGhhdXN0aW5nIHRoZSB0cmFuc2xhdGlv
biBjYWNoZS4NCj4gDQo+ICAgICAyLjEyJSAgcWVtdS1zeXN0ZW0tYWFyICBxZW11LXN5c3Rl
bS1hYXJjaDY0ICAgICAgICAgICAgICAgICAgICAgICBbLl0gYXJtX2VsX2lzX2FhNjQNCj4g
ICAgIDIuMTElICBxZW11LXN5c3RlbS1hYXIgIHFlbXUtc3lzdGVtLWFhcmNoNjQgICAgICAg
ICAgICAgICAgICAgICAgIFsuXSBhcm1fc2VjdXJpdHlfc3BhY2VfYmVsb3dfZWwzDQo+ICAg
ICAyLjExJSAgcWVtdS1zeXN0ZW0tYWFyICBxZW11LXN5c3RlbS1hYXJjaDY0ICAgICAgICAg
ICAgICAgICAgICAgICBbLl0gZGVwb3NpdDY0DQo+ICAgICAxLjQ5JSAgcWVtdS1zeXN0ZW0t
YWFyICBxZW11LXN5c3RlbS1hYXJjaDY0ICAgICAgICAgICAgICAgICAgICAgICBbLl0gYXJt
X2hjcl9lbDJfZWZmX3NlY3N0YXRlDQo+ICAgICAxLjQ2JSAgcWVtdS1zeXN0ZW0tYWFyICBx
ZW11LXN5c3RlbS1hYXJjaDY0ICAgICAgICAgICAgICAgICAgICAgICBbLl0gYXJtX2lzX2Vs
Ml9lbmFibGVkX3NlY3N0YXRlDQo+ICAgICAxLjM4JSAgcWVtdS1zeXN0ZW0tYWFyICBxZW11
LXN5c3RlbS1hYXJjaDY0ICAgICAgICAgICAgICAgICAgICAgICBbLl0gZXh0cmFjdDMyDQo+
ICAgICAxLjM0JSAgcWVtdS1zeXN0ZW0tYWFyICBxZW11LXN5c3RlbS1hYXJjaDY0ICAgICAg
ICAgICAgICAgICAgICAgICBbLl0gZXh0cmFjdDY0DQo+ICAgICAxLjMwJSAgcWVtdS1zeXN0
ZW0tYWFyICBxZW11LXN5c3RlbS1hYXJjaDY0ICAgICAgICAgICAgICAgICAgICAgICBbLl0g
Z2V0X3BoeXNfYWRkcl9scGFlDQo+ICAgICAxLjIzJSAgcWVtdS1zeXN0ZW0tYWFyICBxZW11
LXN5c3RlbS1hYXJjaDY0ICAgICAgICAgICAgICAgICAgICAgICBbLl0gYWE2NF92YV9wYXJh
bWV0ZXJzDQo+ICAgICAxLjA5JSAgcWVtdS1zeXN0ZW0tYWFyICBxZW11LXN5c3RlbS1hYXJj
aDY0ICAgICAgICAgICAgICAgICAgICAgICBbLl0gcm9sMzINCj4gICAgIDEuMDclICBxZW11
LXN5c3RlbS1hYXIgIHFlbXUtc3lzdGVtLWFhcmNoNjQgICAgICAgICAgICAgICAgICAgICAg
IFsuXSBwcm9iZV9hY2Nlc3NfaW50ZXJuYWwNCj4gICAgIDEuMDIlICBxZW11LXN5c3RlbS1h
YXIgIHFlbXUtc3lzdGVtLWFhcmNoNjQgICAgICAgICAgICAgICAgICAgICAgIFsuXSBkZXBv
c2l0MzINCj4gDQo+IA0KDQpUaGFua3MgQWxleC4NCg0KSSBkaWQgdGhlIHNhbWUgaW52ZXN0
aWdhdGlvbiwgYW5kIHN3aXRjaGluZyB0byBwYXV0aC1pbXBkZWYgYnJpbmdzIGRvd24gDQp0
aW1lIGZyb20gMTUwMHMgdG8gYSBtb3JlICJhY2NlcHRhYmxlIiA0NTBzIG9uIG15IG1hY2hp
bmUuDQpJbiBteSBwcm9maWxlICh1c2luZyBjYWxsIGdyYXBocywgd2hpY2ggSSdtIG5vdCBz
dXJlIHlvdSB1c2VkKSwgSSANCm9ic2VydmUgdGhhdCAyNiUgb2YgdGhlIHRpbWUgaXMgc3Bl
bnQgaW4gDQphc3NlcnRfaGZsYWdzX3JlYnVpbGRfY29ycmVjdGx5LCB3aGljaCBpcyBlbmFi
bGVkIGJ5IC0tZW5hYmxlLWRlYnVnLXRjZy4NCg0KSSdsbCBzZW5kIGEgdjMgc3dpdGNoaW5n
IHRvIGltcGRlZiBhbmQgaW5jcmVhc2luZyB0aGUgdGltZW91dCwgc2hvdWxkIGJlIA0KZW5v
dWdoIGZvciB0aGlzIHRpbWUuDQoNClBpZXJyaWNrDQo=

