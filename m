Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1646E74ACA
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2024 19:37:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIYiH-0007D4-5W; Tue, 03 Dec 2024 14:37:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tIYhp-0006zc-BW
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 14:37:10 -0500
Received: from mail-pg1-x529.google.com ([2607:f8b0:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tIYhn-0002Xq-Eh
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 14:37:09 -0500
Received: by mail-pg1-x529.google.com with SMTP id
 41be03b00d2f7-7f43259d220so4029901a12.3
 for <qemu-devel@nongnu.org>; Tue, 03 Dec 2024 11:37:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733254625; x=1733859425; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Pb8a5IwBeghZqzjXLfbY9pB3bbFhIIwjqTPBLorbw1A=;
 b=viqk0N4HFMdLIrHz+bUI0ms+gT48Nwsp16ZTWJimMXdpeXXHW7Wicj47hUhcbrPXQo
 FIjAH/xKgPwhH8JCM2jXfJ+0D2socjN6noGI3ljHKAsOlssp3L4fBItFPHwD5Shmt79t
 3zpgz/nwaIxolSPonCuG+VLGzEdWUn0kWejfnbCVoTecHQrr3K+qJuS+FY03FPYQv9Yp
 Gvi5JkRdpHMZofERRRNvFQf8d0dovvLHzkbh9HaRnB92NR0LOm1M2iT9TndaiLcqoPU1
 +671GDc8acNH93H3c9BCnNloKTRCyvE5n/mGkfo5YQB7SXE0uTUJ6phYiC2+L8IBskbM
 6++g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733254625; x=1733859425;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Pb8a5IwBeghZqzjXLfbY9pB3bbFhIIwjqTPBLorbw1A=;
 b=nBBdOjPAdrlkRNouiykvNvjrSe+PCsF0rQc5+MbCaA7Wcd07QMJ3mOXAOFFUGXFFUo
 E9n5Q/PMWCWmM24e0PSzGxNGDJZj4MJUGU02JE3CnyxisNPmIaRzemcNsot38B24AbAx
 hXRqVXPiV/Yxi3QvAVWer0TbD1RZm0TcllakiNbWvYyfuH8kSx1DuQ7laXIjB8LeP/wg
 45B90kzf1XIHlu6PiwarPDpIPGOt13ZyWZrlGOCpA09O+Hw262dMpyv0Mwv7Z1JRKC35
 efHbEyOXUjH2RrZ09JoDVWKkhHSvceqwsrFTqEu/YlyUhqDpIZlVi84DDYG7hj3clvxg
 9jOg==
X-Gm-Message-State: AOJu0Yz7RCsMh+yzOk1utMa1fxad8E9lomjo/sfUldR7TuU+CsuZqTTI
 O7M7zaLp6/QbfOce1XIKJQ84ZRkT4iKh3A99PDzRKzETSnmZBvsyF2KsFTwvJIY=
X-Gm-Gg: ASbGncvFiiHcHCK6AccwFjfhIFM220A3zVpMZTbXWFixQvNJHc0thWZOCpl1uJTT5PT
 v+SBq3tgkPPFWQdkCRuU3tNX99uoJHAQByXQdoQ23I/r6UMxntMcvQCTffJLsMjKCE7QgmYYIlB
 epmNWX8w8v5yhOeVQoWGGPxoBXiaxNpagfRlhKyJO+4mHEWVJ955+iRAQTNs/i3cSI9FvUuEd9H
 jeFCvxdVPGMMWJwUV37+naX2n3oY2ca9nRrUBQt4nKxMpxMt3HCsfUbcoEq7RWvUfB5QI4yRTds
 L7sSXOWjYn0I37jJqYJY6A==
X-Google-Smtp-Source: AGHT+IFlwe7xaxPr0ocE/L2TmmL6VY8/U+WOkCjJamNBezJeL3NlJsQ7wWktyE7+A+WKJH1n8+/VIA==
X-Received: by 2002:a05:6a20:72a1:b0:1db:e508:cf68 with SMTP id
 adf61e73a8af0-1e1653c8392mr4988756637.24.1733254625607; 
 Tue, 03 Dec 2024 11:37:05 -0800 (PST)
Received: from [192.168.1.67] (216-180-64-156.dyn.novuscom.net.
 [216.180.64.156]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-725417725e9sm10824148b3a.80.2024.12.03.11.37.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Dec 2024 11:37:05 -0800 (PST)
Message-ID: <29b57af5-2fdb-4f5d-9dee-2be271767025@linaro.org>
Date: Tue, 3 Dec 2024 11:37:04 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/7] docs: add a glossary
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
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
 <20241118172357.475281-7-pierrick.bouvier@linaro.org>
 <CAFEAcA9JdLxi5cr-Z2-YX6Q8nv=j0O3k=f9u6gS-CzSf5BH7Ug@mail.gmail.com>
 <87ttbkbpsr.fsf@draig.linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <87ttbkbpsr.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::529;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x529.google.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_SBL_A=0.1 autolearn=unavailable autolearn_force=no
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

T24gMTIvMy8yNCAxMDoxMCwgQWxleCBCZW5uw6llIHdyb3RlOg0KPiBQZXRlciBNYXlkZWxs
IDxwZXRlci5tYXlkZWxsQGxpbmFyby5vcmc+IHdyaXRlczoNCj4gDQo+PiBPbiBNb24sIDE4
IE5vdiAyMDI0IGF0IDE3OjI0LCBQaWVycmljayBCb3V2aWVyDQo+PiA8cGllcnJpY2suYm91
dmllckBsaW5hcm8ub3JnPiB3cm90ZToNCj4+Pg0KPj4+IFNpZ25lZC1vZmYtYnk6IFBpZXJy
aWNrIEJvdXZpZXIgPHBpZXJyaWNrLmJvdXZpZXJAbGluYXJvLm9yZz4NCj4+PiAtLS0NCj4+
PiAgIGRvY3MvZGV2ZWwvY29udHJvbC1mbG93LWludGVncml0eS5yc3QgfCAgIDIgKw0KPj4+
ICAgZG9jcy9kZXZlbC9tdWx0aS10aHJlYWQtdGNnLnJzdCAgICAgICB8ICAgMiArDQo+Pj4g
ICBkb2NzL2dsb3NzYXJ5L2luZGV4LnJzdCAgICAgICAgICAgICAgIHwgMjM4ICsrKysrKysr
KysrKysrKysrKysrKysrKysrDQo+Pj4gICBkb2NzL2luZGV4LnJzdCAgICAgICAgICAgICAg
ICAgICAgICAgIHwgICAxICsNCj4+PiAgIGRvY3Mvc3lzdGVtL2FybS92aXJ0LnJzdCAgICAg
ICAgICAgICAgfCAgIDIgKw0KPj4+ICAgZG9jcy9zeXN0ZW0vaW1hZ2VzLnJzdCAgICAgICAg
ICAgICAgICB8ICAgMiArDQo+Pj4gICBkb2NzL3Rvb2xzL3FlbXUtbmJkLnJzdCAgICAgICAg
ICAgICAgIHwgICAyICsNCj4+PiAgIDcgZmlsZXMgY2hhbmdlZCwgMjQ5IGluc2VydGlvbnMo
KykNCj4+PiAgIGNyZWF0ZSBtb2RlIDEwMDY0NCBkb2NzL2dsb3NzYXJ5L2luZGV4LnJzdA0K
Pj4NCj4+IEkgdGhpbmsgdGhpcyBpcyBhIGdvb2QgaWRlYTsgd2UndmUgaGFkIGF0IGxlYXN0
IG9uZSBidWcNCj4+IHJlcG9ydCBmcm9tIGEgdXNlciBwb2ludGluZyBvdXQgdGhhdCB3ZSBo
YWQgYSB0ZXJtIGluDQo+PiBvdXIgZG9jcyB3aGljaCB3ZSBkaWRuJ3QgZGVmaW5lICgiYmxv
Y2sgZHJpdmVyIik6DQo+PiBodHRwczovL2dpdGxhYi5jb20vcWVtdS1wcm9qZWN0L3FlbXUv
LS9pc3N1ZXMvMjYxMQ0KPj4gSSBoYXZlIHNvbWUgY29tbWVudHMgb24gc3BlY2lmaWMgZW50
cmllcyBiZWxvdy4NCj4+DQo+Pj4gZGlmZiAtLWdpdCBhL2RvY3MvZGV2ZWwvY29udHJvbC1m
bG93LWludGVncml0eS5yc3QgYi9kb2NzL2RldmVsL2NvbnRyb2wtZmxvdy1pbnRlZ3JpdHku
cnN0DQo+Pj4gaW5kZXggZTZiNzNhNGZlMWEuLjNkNTcwMmZhNGNjIDEwMDY0NA0KPj4+IC0t
LSBhL2RvY3MvZGV2ZWwvY29udHJvbC1mbG93LWludGVncml0eS5yc3QNCj4gPHNuaXA+DQo+
Pj4gKw0KPj4+ICtEZXZpY2UNCj4+PiArLS0tLS0tDQo+Pj4gKw0KPj4+ICtRRU1VIGlzIGFi
bGUgdG8gZW11bGF0ZSBhIENQVSwgYW5kIGFsbCB0aGUgaGFyZHdhcmUgaW50ZXJhY3Rpbmcg
d2l0aCBpdCwNCj4+PiAraW5jbHVkaW5nIG1hbnkgZGV2aWNlcy4gV2hlbiBRRU1VIHJ1bnMg
YSB2aXJ0dWFsIG1hY2hpbmUgdXNpbmcgYSBoYXJkd2FyZS1iYXNlZA0KPj4+ICthY2NlbGVy
YXRvciwgaXQgaXMgcmVzcG9uc2libGUgZm9yIGVtdWxhdGluZywgdXNpbmcgc29mdHdhcmUs
IGFsbCBkZXZpY2VzLg0KPj4NCj4+IFRoaXMgZGVmaW5pdGlvbiBkb2Vzbid0IGFjdHVhbGx5
IGRlZmluZSB3aGF0IGEgZGV2aWNlIGlzIDotKQ0KPiANCj4gQWxzbyB3ZSBjYW4geHJlZiB0
bzoNCj4gDQo+ICAgIGh0dHBzOi8vcWVtdS5yZWFkdGhlZG9jcy5pby9lbi92OS4xLjAvc3lz
dGVtL2RldmljZS1lbXVsYXRpb24uaHRtbA0KPiANCj4gd2hlcmUgd2UgZ28gaW50byBhIGJp
dCBtb3JlIGRldGFpbCBhYm91dCB3aGF0IGEgZGV2aWNlLCBidXMsIGZyb250ZW5kDQo+IGFu
ZCBiYWNrZW5kIGFyZS4NCj4gDQoNCkdvb2QgcG9pbnQsIEknbGwgYWRkIGl0Lg0KDQo+Pg0K
Pj4+ICsNCj4+PiArRURLMg0KPj4+ICstLS0tDQo+Pj4gKw0KPj4+ICtFREsyLCBhcyBrbm93
biBhcyBgVGlhbm9Db3JlIDxodHRwczovL3d3dy50aWFub2NvcmUub3JnLz5gXywgaXMgYW4g
b3BlbiBzb3VyY2UNCj4+PiAraW1wbGVtZW50YXRpb24gb2YgVUVGSSBzdGFuZGFyZC4gSXQn
cyByYW4gYnkgUUVNVSB0byBzdXBwb3J0IFVFRkkgZm9yIHZpcnR1YWwNCj4+PiArbWFjaGlu
ZXMuDQo+Pg0KPj4gUmVwbGFjZSBsYXN0IHNlbnRlbmNlIHdpdGgNCj4+ICJRRU1VIHZpcnR1
YWwgbWFjaGluZXMgdGhhdCBib290IGEgVUVGSSBCSU9TIHVzdWFsbHkgdXNlIEVESzIuIg0K
Pj4gPw0KPj4NCj4gPHNuaXA+DQo+IA0KDQo=

