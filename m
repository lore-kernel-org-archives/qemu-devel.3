Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 335B2C28B28
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Mar 2025 23:33:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trQ8x-0005qo-7y; Sun, 09 Mar 2025 19:33:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1trQ8t-0005nJ-Pl
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 19:33:11 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1trQ8r-0001Ub-VR
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 19:33:11 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-224191d92e4so57686515ad.3
 for <qemu-devel@nongnu.org>; Sun, 09 Mar 2025 16:33:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741563188; x=1742167988; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=4b/UkAzN7ZHYgiU4BKJLTd8rxlg4iR/5B9OEm16oOJU=;
 b=crGZkL2F6rAR6TCu0ZTcpyZ7Uske0u9Eqi8KQBImTS64se6H/XLG7SuIhv59hFR/TZ
 x1FQ80xEYqo/AgbN8ydllWyyihkLYqni8C0ekYy2kxPz6D9rMWMF3VHorWzuG88zq2vr
 MGvsp3+lrH3fz4UYfMTaGS5VMr8ks1Rh2uoJB2cnKfsGUyFzGax5DZU0M16O2Pydeub1
 3TumxrKBhFx5AzLd7+TellQ6w/c8AKwLpu9/3FV91nH7Suw0gknh3X+G64iW4SZIabH8
 HByNL1sf6ExqVmxlx/S6cPwZmJ/Nfu1FpjPBXoHe7aJkkjZsGGeSnoL9uy9hNjOtNQfP
 D3cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741563188; x=1742167988;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4b/UkAzN7ZHYgiU4BKJLTd8rxlg4iR/5B9OEm16oOJU=;
 b=SuUID0E99E9w5WhdlimFgFz2WM/oGKp3RwCEis71iSSV+fCct+3V3TT2AuwLZAqbOc
 Ld9/N8qW+7/9FEXsTMXUwKZFnp9hynpngfm9uIzgQJH9pwsvyI2EU/jwKBZQM3btGUa3
 om5fTNtoi+3nTq1pxsTpFM10KUSh7Ch2fIKft8I4Yl5hn7CG8dVhG/ThMpAZtlSymZ7Y
 FTkUL7k6R5PwgbmbPFjvKEMVbhmtfs3/3nb8AMsgg6XyUkK1o69Hrt5Md08kODj/KxU7
 xptSmqu+rNbaOrEyeNKFn5sCfYW4rWCa6qf6uMz2s39iYaRsppVQRo41TqaL4TuxznmM
 yEXA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV4PIYFggzk/02cuEF6dsuTpcXBgHe10rPNHkW0/ZPMQ6bn+LQnSGsKV/LcwrpeAtJNBBr0QqSRznIb@nongnu.org
X-Gm-Message-State: AOJu0YzKqZG+II64iX5m/DzVEQGoxWSkY4D/NKuNYXu/xBiSD3dG83KL
 Kq3v0Y9W7FFvJvLmZuurPTSJv3NxrtUMEb8BoWKpPsDVufeaxdCf4xIYkVjf/wc=
X-Gm-Gg: ASbGnctzIn8ZqD9gIYl3gNuh5rz+3XrzVfsQqzi4V+jf5epCkRA6hBL7b2gN/kcu7uN
 dAobAqtQrCjy4ecrrYIKtibr0FdKNydmfnlvg4YZzWKZ3r/Ys0H+RATRXtszI1XTPbgCEpthI8j
 3doRpaIqS7SHS1V9ytEYXcB8B+1vONXSIlduRjQ7A0ZiBWMS+ijLwWSgJxp+j2sruF5gp8MvlYb
 TiJ/QctI2e+WSlnF26jPxsB8ZG4d3xsslgQgig849Y+StTl02oW8oIEmX0Vt4YlTBGz4xL5HuVE
 +kDbKUwajlb7tPZ/VTmDnvgjpgVvtuYJI3B69nASM24AiwOFNlHk4ih63Q==
X-Google-Smtp-Source: AGHT+IEJJimItTTmgzjc12itv0ixC5PTKLwwNaQJYzRT3y52Qe5O6A4YR8D59kmlSgj77EP8O5qChQ==
X-Received: by 2002:a05:6a20:43a7:b0:1f5:7ba7:69d8 with SMTP id
 adf61e73a8af0-1f57ba76d96mr2705823637.15.1741563188021; 
 Sun, 09 Mar 2025 16:33:08 -0700 (PDT)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-af28126e2c1sm5379232a12.52.2025.03.09.16.33.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 09 Mar 2025 16:33:07 -0700 (PDT)
Message-ID: <91ddf98c-3a5d-404b-9e80-ed4580c1c373@linaro.org>
Date: Sun, 9 Mar 2025 16:33:06 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/7] hw/hyperv: remove duplication compilation units
Content-Language: en-US
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
 alex.bennee@linaro.org, qemu-devel@nongnu.org,
 Marcelo Tosatti <mtosatti@redhat.com>, richard.henderson@linaro.org,
 manos.pitsidianakis@linaro.org
References: <20250307215623.524987-1-pierrick.bouvier@linaro.org>
 <8c511d16-05d6-4852-86fc-a3be993557c7@linaro.org>
 <8d2a19a8-e0a4-4050-8ba5-9baa9b47782f@maciej.szmigiero.name>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <8d2a19a8-e0a4-4050-8ba5-9baa9b47782f@maciej.szmigiero.name>
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

SGkgTWFjaWVqLA0KDQpPbiAzLzcvMjUgMTQ6MzEsIE1hY2llaiBTLiBTem1pZ2llcm8gd3Jv
dGU6DQo+IEhpIFBoaWxpcHBlLA0KPiANCj4gT24gNy4wMy4yMDI1IDIzOjI1LCBQaGlsaXBw
ZSBNYXRoaWV1LURhdWTDqSB3cm90ZToNCj4+IEhpIE1hY2llaiwNCj4+DQo+PiBPbiA3LzMv
MjUgMjI6NTYsIFBpZXJyaWNrIEJvdXZpZXIgd3JvdGU6DQo+Pj4gV29yayB0b3dhcmRzIGhh
dmluZyBhIHNpbmdsZSBiaW5hcnksIGJ5IHJlbW92aW5nIGR1cGxpY2F0ZWQgb2JqZWN0IGZp
bGVzLg0KPj4NCj4+PiBQaWVycmljayBCb3V2aWVyICg3KToNCj4+PiAgwqDCoCBody9oeXBl
cnYvaHYtYmFsbG9vbi1zdHViOiBjb21tb24gY29tcGlsYXRpb24gdW5pdA0KPj4+ICDCoMKg
IGh3L2h5cGVydi9oeXBlcnYuaDogaGVhZGVyIGNsZWFudXANCj4+PiAgwqDCoCBody9oeXBl
cnYvdm1idXM6IGNvbW1vbiBjb21waWxhdGlvbiB1bml0DQo+Pj4gIMKgwqAgaHcvaHlwZXJ2
L2h5cGVydi1wcm90bzogbW92ZSBTWU5EQkcgZGVmaW5pdGlvbiBmcm9tIHRhcmdldC9pMzg2
DQo+Pj4gIMKgwqAgaHcvaHlwZXJ2L3N5bmRiZzogY29tbW9uIGNvbXBpbGF0aW9uIHVuaXQN
Cj4+PiAgwqDCoCBody9oeXBlcnYvYmFsbG9vbjogY29tbW9uIGJhbGxvb24gY29tcGlsYXRp
b24gdW5pdHMNCj4+PiAgwqDCoCBody9oeXBlcnYvaHlwZXJ2X3Rlc3RkZXY6IGNvbW1vbiBj
b21waWxhdGlvbiB1bml0DQo+Pg0KPj4gSWYgeW91IGFyZSBoYXBweSB3aXRoIHRoaXMgc2Vy
aWVzIGFuZCBwcm92aWRlIHlvdXIgQWNrLWJ5IHRhZywNCj4+IEkgY2FuIHRha2UgaXQgaW4g
bXkgbmV4dCBody1taXNjIHB1bGwgcmVxdWVzdCBpZiB0aGF0IGhlbHBzLg0KPiANCj4gVGhl
cmUncyBub3RoaW5nIG9idmlvdXNseSB3cm9uZyBpbiB0aGUgcGF0Y2ggc2V0LA0KPiBidXQg
aWYgd2UgY2FuIGRlZmVyIHRoaXMgdG8gTW9uZGF5IHRoZW4gSSBjb3VsZCBkbw0KPiBhIHJ1
bnRpbWUgY2hlY2sgd2l0aCBhIFdpbmRvd3MgVk0gdG9vLg0KPiANCg0KdGhpcyBzZXJpZXMg
bmVlZHMgc29tZSBmaXh1cCBhZnRlciB0aGUgbWVyZ2Ugb2YgNThkMDA1MzogaW5jbHVkZS9l
eGVjOiANCk1vdmUgVEFSR0VUX1BBR0Vfe1NJWkUsTUFTSyxCSVRTfSB0byB0YXJnZXRfcGFn
ZS5oLg0KDQpJJ2xsIHJlLXNwaW4gaXQgbGF0ZXIsIHNvIGRvbid0IHdhc3RlIHlvdXIgdGlt
ZSB0cnlpbmcgaXQuDQoNClRoYW5rcywNClBpZXJyaWNrDQoNCj4+IFJlZ2FyZHMsDQo+Pg0K
Pj4gUGhpbC4NCj4gDQo+IFRoYW5rcywNCj4gTWFjaWVqDQo+IA0KDQo=

