Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9E66E74ACA
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2024 19:37:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIYgc-00066q-K3; Tue, 03 Dec 2024 14:35:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tIYgT-00062o-AT
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 14:35:46 -0500
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tIYgR-0001yv-Ha
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 14:35:45 -0500
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-7250906bc63so108020b3a.1
 for <qemu-devel@nongnu.org>; Tue, 03 Dec 2024 11:35:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733254540; x=1733859340; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=sZ/sBGUSUepOtAok6niXHDSVom+mmgVuaxSazyrS/og=;
 b=A7At31JnPSrORh/CPpRG03KzCDpinsZ7ujcP43W/WZGkm0xY6Wi+YePraVdbYrRA80
 /xt6xGlhI1AvXHJO49uV+jMdbrFDm6LIrwcC3lOXsbNhBrkXObCstNn+gCSNgGY1hZ0s
 okb9DfTrrms4zOZPIVQkmnJFpqjKpJcQRP6SaCaoiJbtwWnLVQVWMQD1JUVqXnlYukJj
 KPNnkAY8YnpqhUpzs329BIcPenmddYLmY3gZxkQL7i5pZMdorAyEZFeTLyUHe+23rTVq
 Jf0zapqy+9WvYnxMcBJiScDzzbsLotpT8o4DY6OcooQ63AfTRVdqx4VOuV4MZIolZojP
 CTbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733254540; x=1733859340;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=sZ/sBGUSUepOtAok6niXHDSVom+mmgVuaxSazyrS/og=;
 b=XLsqsuq3t5fyl9+u3q6FbCmPauet2fON6xBa4gRJCNrqnocwH2ewxeyPzcl7mI4wKw
 VYoBMr6Sun1EP0YwjCa1tWV+Ia79cn2oyUNpKBwmAR8qREd4kzW3Rb56lGiRhdbjSAq9
 AHNMxm4TvBUfn65l1zZJwQ884EtiRASAz6FlDot7ROSkiLWdHrr1zhBeQULqBTh2pBNk
 wMi6a15dl1QRCETcmKTxSBhI/m+l0trSzZjrthmnA7E7bAjyvl3aOXp6pVdPLPnOMvBN
 Kb+8JR7uLW732Sdwm7UGJBb4YErOW8QdVIF6uyTApua3vve2gK3FCwIn/O22ajB66voJ
 lEww==
X-Gm-Message-State: AOJu0YwINQ6sxYINgyI1e9lj+CZcSqoXFGRZp/hKC4LXD4qlsD7JLfwB
 s1mI8HkcVZRzWssSL1UqUqWI8wvET/2TfVAcghmqndgTmATNejpbzx0auWAYuVI=
X-Gm-Gg: ASbGncuvOs8yCSd22ffqnrcUJ8RYj8I0+9BTjfaqInywFdNAznugBi/KWsF2SiW9n8z
 ePwDjbvvYrwygLFIPnIRpBIWMUmmoT4Gm7q+enUUHelYlaw7Fm35xgdyVsvoS6nKbrmp3ezvVsR
 zw/49QgQ8+W52zJWHsF3S7HjBo4mQa/dhtQW3m/AZDEcZIHOUKgrL3MhbDB5HH0myb/dKfxh6Ms
 YTKs0NEtlthSyF5p+NdGeYeNxoseQ6DzWV3rW4CXhAeTEO+SbSMd+3vzU00WYb4bfLV/FJHy9S0
 4i86A60z+hcesgu+uaM/AA==
X-Google-Smtp-Source: AGHT+IEuu78HwwXvG9FYHFJ0VUgXhcQhcCV2iyvLs/QgjslUV/5jpffgknaaR01zkj9YETVixUfNMQ==
X-Received: by 2002:a05:6a00:180a:b0:725:4301:ed5a with SMTP id
 d2e1a72fcca58-7257f8d5980mr5321451b3a.2.1733254539996; 
 Tue, 03 Dec 2024 11:35:39 -0800 (PST)
Received: from [192.168.1.67] (216-180-64-156.dyn.novuscom.net.
 [216.180.64.156]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7254184ad5csm10826895b3a.199.2024.12.03.11.35.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Dec 2024 11:35:39 -0800 (PST)
Message-ID: <ed84a4df-490e-44f2-819a-9fe47d235e0e@linaro.org>
Date: Tue, 3 Dec 2024 11:35:38 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/7] docs: add a codebase section
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Richard Henderson <richard.henderson@linaro.org>,
 Andrew Melnychenko <andrew@daynix.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Fabiano Rosas <farosas@suse.de>, Kevin Wolf <kwolf@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>,
 qemu-arm@nongnu.org, Yuri Benditovich <yuri.benditovich@daynix.com>,
 manos.pitsidianakis@linaro.org, qemu-block@nongnu.org,
 Michael Roth <michael.roth@amd.com>, Konstantin Kostiuk
 <kkostiuk@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Xu <peterx@redhat.com>, gustavo.romero@linaro.org
References: <20241118172357.475281-1-pierrick.bouvier@linaro.org>
 <20241118172357.475281-6-pierrick.bouvier@linaro.org>
 <CAFEAcA-UkmPvyNW_6o22-WhaLxnnji55UsBp3UcPA-gYH7kvVg@mail.gmail.com>
 <87zflcbs0l.fsf@draig.linaro.org>
 <CAFEAcA_Mmf0fH8biPaZz9c1bw6UdmEvVWhdjUduzPTqH4njnhQ@mail.gmail.com>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <CAFEAcA_Mmf0fH8biPaZz9c1bw6UdmEvVWhdjUduzPTqH4njnhQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x436.google.com
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

T24gMTIvMy8yNCAwOTo0NiwgUGV0ZXIgTWF5ZGVsbCB3cm90ZToNCj4gT24gVHVlLCAzIERl
YyAyMDI0IGF0IDE3OjIyLCBBbGV4IEJlbm7DqWUgPGFsZXguYmVubmVlQGxpbmFyby5vcmc+
IHdyb3RlOg0KPj4NCj4+IFBldGVyIE1heWRlbGwgPHBldGVyLm1heWRlbGxAbGluYXJvLm9y
Zz4gd3JpdGVzOg0KPj4NCj4+PiBPbiBNb24sIDE4IE5vdiAyMDI0IGF0IDE3OjI0LCBQaWVy
cmljayBCb3V2aWVyDQo+Pj4gPHBpZXJyaWNrLmJvdXZpZXJAbGluYXJvLm9yZz4gd3JvdGU6
DQo+Pj4+DQo+Pj4+IFByZXNlbnQgdGhlIHZhcmlvdXMgcGFydHMgb2YgUUVNVSBhbmQgb3Jn
YW5pemF0aW9uIG9mIGNvZGViYXNlLg0KPj4+Pg0KPj4+PiBTaWduZWQtb2ZmLWJ5OiBQaWVy
cmljayBCb3V2aWVyIDxwaWVycmljay5ib3V2aWVyQGxpbmFyby5vcmc+DQo+Pj4NCj4+PiBJ
IGxpa2UgdGhpczsgaXQncyBzb21ldGhpbmcgSSd2ZSB0aG91Z2h0IGZvciBhIHdoaWxlIHdv
dWxkDQo+Pj4gYmUgZ29vZCB0byBoYXZlLCBidXQgd2hpY2ggSSBuZXZlciBnb3Qgcm91bmQg
dG8gdHJ5aW5nIHRvDQo+Pj4gcHV0IHRvZ2V0aGVyLiBUaGFua3MgZm9yIGRvaW5nIHRoaXMh
DQo+Pj4NCj4+PiBNb3N0bHkgbXkgY29tbWVudHMgYmVsb3cgYXJlIHNwZWxsaW5nL3R5cG8g
bml0cyBhbmQNCj4+PiBvdGhlciBtaW5vciBzdHVmZi4NCj4+Pg0KPj4+PiAtLS0NCj4+Pj4g
ICBkb2NzL2Fib3V0L2VtdWxhdGlvbi5yc3QgICAgICAgICAgICAgICB8ICAgMiArDQo+Pj4+
ICAgZG9jcy9jb2RlYmFzZS9pbmRleC5yc3QgICAgICAgICAgICAgICAgfCAyMTEgKysrKysr
KysrKysrKysrKysrKysrKysrKw0KPj4+PiAgIGRvY3MvZGV2ZWwvZGVjb2RldHJlZS5yc3Qg
ICAgICAgICAgICAgIHwgICAyICsNCj4+Pj4gICBkb2NzL2RldmVsL2VicGZfcnNzLnJzdCAg
ICAgICAgICAgICAgICB8ICAgMiArDQo+Pj4+ICAgZG9jcy9kZXZlbC9pbmRleC1pbnRlcm5h
bHMucnN0ICAgICAgICAgfCAgIDIgKw0KPj4+PiAgIGRvY3MvZGV2ZWwvbWlncmF0aW9uL21h
aW4ucnN0ICAgICAgICAgIHwgICAyICsNCj4+Pj4gICBkb2NzL2RldmVsL3FhcGktY29kZS1n
ZW4ucnN0ICAgICAgICAgICB8ICAgMSArDQo+Pj4+ICAgZG9jcy9kZXZlbC90ZXN0aW5nL21h
aW4ucnN0ICAgICAgICAgICAgfCAgIDkgKy0NCj4+Pj4gICBkb2NzL2RldmVsL3Rlc3Rpbmcv
cXRlc3QucnN0ICAgICAgICAgICB8ICAgMiArDQo+Pj4+ICAgZG9jcy9pbmRleC5yc3QgICAg
ICAgICAgICAgICAgICAgICAgICAgfCAgIDMgKw0KPj4+PiAgIGRvY3MvaW50ZXJvcC9xZW11
LWdhLnJzdCAgICAgICAgICAgICAgIHwgICAyICsNCj4+Pj4gICBkb2NzL3N5c3RlbS9xZW11
LWJsb2NrLWRyaXZlcnMucnN0LmluYyB8ICAgMiArDQo+Pj4+ICAgZG9jcy90b29scy9xZW11
LXN0b3JhZ2UtZGFlbW9uLnJzdCAgICAgfCAgIDIgKw0KPj4+PiAgIGRvY3MvdXNlci9tYWlu
LnJzdCAgICAgICAgICAgICAgICAgICAgIHwgICA2ICsNCj4+Pj4gICAxNCBmaWxlcyBjaGFu
Z2VkLCAyNDcgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPj4+PiAgIGNyZWF0ZSBt
b2RlIDEwMDY0NCBkb2NzL2NvZGViYXNlL2luZGV4LnJzdA0KPj4+Pg0KPj4gPHNuaXA+DQo+
Pj4+ICsgIEJsb2NrIGRldmljZXMgYW5kIGBpbWFnZSBmb3JtYXRzPGRpc2sgaW1hZ2VzPmAg
aW1wbGVtZW50YXRpb24uDQo+Pj4+ICsqIGBic2QtdXNlciA8aHR0cHM6Ly9naXRsYWIuY29t
L3FlbXUtcHJvamVjdC9xZW11Ly0vdHJlZS9tYXN0ZXIvYnNkLXVzZXI+YF86DQo+Pj4+ICsg
IGBCU0QgVXNlciBtb2RlPGJzZC11c2VyLW1vZGU+YC4NCj4+Pj4gKyogYnVpbGQ6IFdoZXJl
IHRoZSBjb2RlIGJ1aWx0IGdvZXMhDQo+Pj4NCj4+PiBUaGUgYnVpbHQgY29kZSBkb2Vzbid0
IGhhdmUgdG8gYmUgaW4gJ2J1aWxkJy4gV2UgY291bGQgc2F5Og0KPj4+DQo+Pj4gICAqIGJ1
aWxkOiBZb3UgY2FuIHRlbGwgdGhlIFFFTVUgYnVpbGQgc3lzdGVtIHRvIHB1dCB0aGUgYnVp
bHQgY29kZQ0KPj4+ICAgICBhbnl3aGVyZSB5b3UgbGlrZS4gQnkgZGVmYXVsdCBpdCB3aWxs
IGdvIGludG8gYSBkaXJlY3RvcnkgbmFtZWQNCj4+PiAgICAgYGBidWlsZGBgLiBTb21ldGlt
ZXMgZG9jdW1lbnRhdGlvbiB3aWxsIGFzc3VtZSB0aGlzIGRlZmF1bHQNCj4+PiAgICAgZm9y
IGNvbnZlbmllbmNlIHdoZW4gZGVzY3JpYmluZyBjb21tYW5kIGxpbmVzOyB5b3UgY2FuIGFs
d2F5cw0KPj4+ICAgICByZXBsYWNlIGl0IHdpdGggdGhlIHBhdGggdG8geW91ciBidWlsZCB0
cmVlLg0KPj4+DQo+Pj4gPw0KPj4NCj4+IEkgYWx3YXlzIHJlY29tbWVuZCBjcmVhdGluZyBh
IGJ1aWxkcyBkaXJlY3RvcnkgYW5kIGhhdmluZyBtdWx0aXBsZSBidWlsZA0KPj4gdHJlZXMg
dW5kZXIgaXQ6DQo+IA0KPiBJbmRlZWQsIHRoYXQncyB3aGF0IEkgbGlrZSB0byBkbyB0b28s
IGJ1dCBJIGRvbid0IHRoaW5rIHRoaXMNCj4gZG9jdW1lbnQgaXMgdGhlIHJpZ2h0IHBsYWNl
IHRvIG1ha2UgdGhhdCBraW5kIG9mIHJlY29tbWVuZGF0aW9uLg0KPg0KDQpJIGFncmVlIHdp
dGggUGV0ZXIuDQpQZW9wbGUgd2hvIHVuZGVyc3RhbmQgdGhpcyBuZWVkIGFscmVhZHkga25v
dyBob3cgdG8gZG8gaXQsIGFuZCBpdCdzIG5vdCANCnRoZSBiZXN0IHBsYWNlIHRvIG1lbnRp
b24gdGhhdC4NCg0KQXMgd2VsbCwgdXNpbmcgc2V2ZXJhbCBmb2xkZXJzIGNhbiBiZSBlcnJv
ciBwcm9uZSAodXNpbmcgIm9sZCIgYmluYXJpZXMgDQpieSBtaXN0YWtlIGhhcHBlbnMgcXVp
Y2tseSksIGFuZCBpdCdzIHNvbWV0aGluZyBJIHVzdWFsbHkgZG9uJ3QgYWR2aXNlIA0KZm9y
IGJlZ2lubmVycy4gVXNpbmcgYSBzeW1saW5rIHRoYXQgcG9pbnRzIHRvIHRoZSByaWdodCBm
b2xkZXIgaXMgbGVzcyANCmVycm9yIHByb25lLCBidXQgaXQgb3BlbnMgdGhlIHBhdGggdG8g
YW5vdGhlciAoY3VzdG9tIGFuZCBwZXJzb25hbCkgDQpsYXllciB0byB0aGUgYnVpbGQgY29t
bWFuZC4NCg0KQW5vdGhlciAobW9yZSBzaW1wbGUpIHNvbHV0aW9uIGlzIHRvIHVzZSBhIHNp
bmdsZSBmb2xkZXIsIGFuZCBzaW1wbHkgDQpyZWx5IG9uIGNjYWNoZSBmb3IgcXVpY2sgcmVi
dWlsZHMuDQoNClRoZXJlIGFyZSBwcm9iYWJseSBhcyBtYW55IHNvbHV0aW9ucyBhbmQgb3Bp
bmlvbnMgYXMgdGhlcmUgYXJlIA0KZGV2ZWxvcGVycyBvbiB0aGlzIHRocmVhZCwgc28gaXQn
cyBiZXR0ZXIgdG8gc2ltcGx5IG1lbnRpb24gb25lIGJ1aWxkIA0KZm9sZGVyLCBhbmQgbm90
aGluZyBlbHNlLg0KDQo+IC0tIFBNTQ0KDQo=

