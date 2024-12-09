Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A42DE77180
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2024 22:16:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tKm2J-0000S2-N2; Mon, 09 Dec 2024 17:15:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tKm2I-0000RG-Ah
 for qemu-devel@nongnu.org; Mon, 09 Dec 2024 17:15:26 -0500
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tKm2F-0006iD-Ry
 for qemu-devel@nongnu.org; Mon, 09 Dec 2024 17:15:25 -0500
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-725c24f3a89so2711641b3a.0
 for <qemu-devel@nongnu.org>; Mon, 09 Dec 2024 14:15:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733782522; x=1734387322; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=lXyvkRlb5wkKa40zxqdVtbiXmCQVydujio7/aV2+7x4=;
 b=y1BGVGt6p9UHpO9yHyMVhEmQ5l2NRFRa0n0skiwKiSBdnZCTFx19c2w4v0cu1p/Fz1
 fBP0d8U9sO4MxM3ywheIrd4MbZVMaH7fWfu+vklLc3H1v0hgPn/K1oPV8wzj4FZfP/51
 iURmtFrJ5CJt/bbVYm3I48SYNmGe9Ag891PcUfEA1ttKrUgC37eOttrCDjHZNnYpzjVO
 lT0BzHQBU5apc3t3qMiUHZKll/Lhba439bM8NiJUsfuxPHIW87WFLaKUaIfo3J8pcJ5g
 E8V8gh4bcYvdyte/nYbXQ3FOyfxYwDwlNieZM05vByru3xjEjXWEVJH42Sbm+HvipMMy
 1Xhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733782522; x=1734387322;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=lXyvkRlb5wkKa40zxqdVtbiXmCQVydujio7/aV2+7x4=;
 b=FmLGwaC04RRTjciWY9bLgfMMmc+oaY+M4+XDzhF7St7Lki9P/ieMibFjMwlyMExfuP
 XTmA64ifXdRXfCzQOobkFaoNZZH4HiCg8j2Z2RtiR3imovhZbicj35CZDgLdHhxFydQr
 YdjRgQpzJrOyK+oKayYJHsHP6gpa8rqCAuaCZPMOSDm0dUYk+8laBGYbVaipICU8bedd
 D4Jrmvj8qe79LIqKClEzr2yGAzXB08dO3szFI7GvKixK4zmu4YN/INfYZYcyNQ9xy1lF
 NEQxt8ZeQjGdNRsfNePXyke1SOfZehTctEHaexDBMfKihBzNibzf16FM7/wPRZnd8Rad
 IILQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV6C18rn8C9Ehc6S5KhvTCfVKV1enMEnjvo6j2V+VBj9pQdJT3C0wNRl9XgoAaj9KTkHGTdtXXIAR+v@nongnu.org
X-Gm-Message-State: AOJu0YzR6nOh+nvOd0G0f90sUmNqMID/ov2YbXuKv7W6l+0IXMnHwG+9
 vu/6xy4uMwGJYfkU4fQF/F88YA7uO1ulR551jndzgwOzgmn3ilQXsB0Hljh9Ke8=
X-Gm-Gg: ASbGncsNFM/fdbL1HKgxolBuUa82r5ITxl5KeRKLg9g+mvytFAPfiBWRK8xgGSxfSPx
 4SXLHt41OyFXSS3gK+kBT7y0fNhiAJOWbbns1XS6qoFSCMYNjrqII3j9F7W3JpuYyya2Eg5IhG0
 VV7rWJ+ZuWMvFOcTUfWlVGdANhB+oRorBD+CK1tjWBAq9/LjM3JQJDBSzDI9CVEZnenwxSDPJ0a
 t+Q2iXXDbENv1Hds/jZL8Gz3b4ngZK13hv3M2lCPIEJ7LVwiXzItoBJVkI4mg6n8Qqy/qP9xmue
 EmV5oy4o1w8UilyXe1lXTPa2lQ==
X-Google-Smtp-Source: AGHT+IHdbCMUTYXQeM64kzsbHhDIWGXaLJ5E+wGfA74o4S2SxIEc3ciTNMrvupMUDBI0j2aTfdFDvg==
X-Received: by 2002:a05:6a00:885:b0:727:3c7b:738 with SMTP id
 d2e1a72fcca58-7273c7b0a21mr3539692b3a.5.1733782521974; 
 Mon, 09 Dec 2024 14:15:21 -0800 (PST)
Received: from [192.168.1.67] (216-180-64-156.dyn.novuscom.net.
 [216.180.64.156]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-725d2bfba50sm4601169b3a.57.2024.12.09.14.15.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Dec 2024 14:15:21 -0800 (PST)
Message-ID: <d495918a-be31-4529-984f-46b9fad4b1e7@linaro.org>
Date: Mon, 9 Dec 2024 14:15:20 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/3] docs/devel/style: add a section about bitfield,
 and disallow them for packed structures
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, Alexandre Iooss
 <erdnaxe@crans.org>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>
References: <20241128201510.869974-1-pierrick.bouvier@linaro.org>
 <20241128201510.869974-3-pierrick.bouvier@linaro.org>
 <73cdfb51-aef9-4731-914a-7687f988997e@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <73cdfb51-aef9-4731-914a-7687f988997e@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42b.google.com
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

SGkgUGhpbGlwcGUsDQoNCk9uIDEyLzkvMjQgMTI6MzMsIFBoaWxpcHBlIE1hdGhpZXUtRGF1
ZMOpIHdyb3RlOg0KPiBPbiAyOC8xMS8yNCAyMToxNSwgUGllcnJpY2sgQm91dmllciB3cm90
ZToNCj4+IFNpZ25lZC1vZmYtYnk6IFBpZXJyaWNrIEJvdXZpZXIgPHBpZXJyaWNrLmJvdXZp
ZXJAbGluYXJvLm9yZz4NCj4+IC0tLQ0KPj4gICAgZG9jcy9kZXZlbC9zdHlsZS5yc3QgfCAy
MCArKysrKysrKysrKysrKysrKysrKw0KPj4gICAgMSBmaWxlIGNoYW5nZWQsIDIwIGluc2Vy
dGlvbnMoKykNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvZG9jcy9kZXZlbC9zdHlsZS5yc3QgYi9k
b2NzL2RldmVsL3N0eWxlLnJzdA0KPj4gaW5kZXggMmY2OGI1MDA3OTguLjJkNzNlNmE4Zjdh
IDEwMDY0NA0KPj4gLS0tIGEvZG9jcy9kZXZlbC9zdHlsZS5yc3QNCj4+ICsrKyBiL2RvY3Mv
ZGV2ZWwvc3R5bGUucnN0DQo+PiBAQCAtNDE2LDYgKzQxNiwyNiBAQCBkZWZpbml0aW9ucyBp
bnN0ZWFkIG9mIHR5cGVkZWZzIGluIGhlYWRlcnMgYW5kIGZ1bmN0aW9uIHByb3RvdHlwZXM7
IHRoaXMNCj4+ICAgIGF2b2lkcyBwcm9ibGVtcyB3aXRoIGR1cGxpY2F0ZWQgdHlwZWRlZnMg
YW5kIHJlZHVjZXMgdGhlIG5lZWQgdG8gaW5jbHVkZQ0KPj4gICAgaGVhZGVycyBmcm9tIG90
aGVyIGhlYWRlcnMuDQo+PiAgICANCj4+ICtCaXRmaWVsZHMNCj4+ICstLS0tLS0tLS0NCj4+
ICsNCj4+ICtDIGJpdGZpZWxkcyBjYW4gYmUgYSBjYXVzZSBvZiBub24tcG9ydGFiaWxpdHkg
aXNzdWVzLCBlc3BlY2lhbGx5IHVuZGVyIHdpbmRvd3MNCj4+ICt3aGVyZSBgTVNWQyBoYXMg
YSBkaWZmZXJlbnQgd2F5IHRvIGxheSB0aGVtIG91dCB0aGFuIGdjYw0KPiANCj4gIkdDQyIg
KGFzIE1TVkMpLg0KPiANCj4+ICs8aHR0cHM6Ly9nY2MuZ251Lm9yZy9vbmxpbmVkb2NzL2dj
Yy94ODYtVHlwZS1BdHRyaWJ1dGVzLmh0bWw+YF8sIGFuZCBvbiBiaWcgYW5kDQo+IA0KPiAi
YW5kIG9uIiBzb3VuZHMgb2RkIHRvIG1lLiBNYXliZSAiLCBvciB3aGVyZSBlbmRpYW5uZXNz
IG1hdHRlcnMuIj8NCj4gDQo+PiArbGl0dGxlIGVuZGlhbiBob3N0cy4NCj4+ICsNCj4+ICtG
b3IgdGhpcyByZWFzb24sIHdlIGRpc2FsbG93IHVzYWdlIG9mIGJpdGZpZWxkcyBpbiBwYWNr
ZWQgc3RydWN0dXJlcyBhbmQgaW4gYW55DQo+PiArc3RydWN0dXJlcyB3aGljaCBhcmUgc3Vw
cG9zZWQgdG8gZXhhY3RseSBtYXRjaCBhIHNwZWNpZmljIGxheW91dCBpbiBndWVzdA0KPj4g
K21lbW9yeS4gU29tZSBleGlzdGluZyBjb2RlIG1heSB1c2UgaXQsIGFuZCB3ZSBjYXJlZnVs
bHkgZW5zdXJlZCB0aGUgbGF5b3V0IHdhcw0KPj4gK3RoZSBvbmUgZXhwZWN0ZWQuDQo+PiAr
DQo+PiArV2UgYWxzbyBzdWdnZXN0IGF2b2lkaW5nIGJpdGZpZWxkcyBldmVuIGluIHN0cnVj
dHVyZXMgd2hlcmUgdGhlIGV4YWN0DQo+PiArbGF5b3V0IGRvZXMgbm90IG1hdHRlciwgdW5s
ZXNzIHlvdSBjYW4gc2hvdyB0aGF0IHRoZXkgcHJvdmlkZSBhIHNpZ25pZmljYW50DQo+PiAr
bWVtb3J5IHVzYWdlIG9yIHVzYWJpbGl0eSBiZW5lZml0Lg0KPiANCj4gSSBkb24ndCB0aGlu
ayB3ZSBzaG91bGQgbWVudGlvbiAic2lnbmlmaWNhbnQgbWVtb3J5IHVzYWdlIGJlbmVmaXQi
Lg0KPiANCj4gQW55aG93LA0KPiBSZXZpZXdlZC1ieTogUGhpbGlwcGUgTWF0aGlldS1EYXVk
w6kgPHBoaWxtZEBsaW5hcm8ub3JnPg0KPiANCj4+ICsNCj4+ICtXZSBlbmNvdXJhZ2UgdGhl
IHVzYWdlIG9mIGBgaW5jbHVkZS9ody9yZWdpc3RlcmZpZWxkcy5oYGAgYXMgYSBzYWZlIHJl
cGxhY2VtZW50DQo+PiArZm9yIGJpdGZpZWxkcy4NCj4+ICsNCj4+ICAgIFJlc2VydmVkIG5h
bWVzcGFjZXMgaW4gQyBhbmQgUE9TSVgNCj4+ICAgIC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0NCj4+ICAgIA0KPiANCg0KVGhhbmtzIGZvciB0aGUgcmV2aWV3LCBJJ2xs
IGludGVncmF0ZSB0aGUgY2hhbmdlcyBpbiBuZXh0IHZlcnNpb24uDQpJJ2xsIHdhaXQgYSBs
aXR0bGUgYml0IHRvIGdldCBmZWVkYmFjayBmb3IgcGF0Y2ggMyB0b28uDQoNClRoYW5rcywN
ClBpZXJyaWNrDQo=

