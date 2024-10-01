Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64CF4CEACE7
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2024 16:51:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svg1i-0006ak-MO; Tue, 01 Oct 2024 12:47:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1svg1M-0006AQ-Ch
 for qemu-devel@nongnu.org; Tue, 01 Oct 2024 12:46:49 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1svg1I-00072I-As
 for qemu-devel@nongnu.org; Tue, 01 Oct 2024 12:46:42 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-71970655611so5356479b3a.0
 for <qemu-devel@nongnu.org>; Tue, 01 Oct 2024 09:46:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727801194; x=1728405994; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=fHyj2FFOIINO6gGnWney9CosK6M1zsGXyXPICUa4uV4=;
 b=MosjrE9FtXvOSHHxSWQ6JRTNB/sCWdVPtf9jbh206/fhHShxpdR6ayOoQYT1PogXQC
 vYjevKwQ0KYZ0DNdCU8cXw+8ABIgAKukm3223NYDwgNuCGhO9pwQL9390Ai2EJT4r5Ex
 T3YlHfwDw5r9HigajyDrrhS2KEFLLcUGQ2kLuwwFJ9Ihaz5k+dfp1/BPPrkuUNsrMaJO
 MFvZBvjOZPb5xTLdxylqh3BhrDVPhNuf9xhmF1XUYMelBmMfHeW4EnUZ2Hx/O3MK26Qa
 dsD3XXsj/3cfhkJQjsu6QYwhCNo6gs0cCrswh2/yj5nYR1znV5tiGyCgXpZ8bFJrIh/u
 fRww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727801194; x=1728405994;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fHyj2FFOIINO6gGnWney9CosK6M1zsGXyXPICUa4uV4=;
 b=pygk/z1IoHmOlT7D2Y7SY8b8xvtS3u0zjXLabOg0u7nPGaayz4sOrYe/4Hp+NMG6Mv
 gE9X76Dh7mYllU1Ex/6SAHsZ2+m7MaHGdpG1sga80bCLGynq3fRUlEXNAa+TGS74e4QF
 wAKlcTLcheAwGhTYXoput39e8O29wsLBUwvR/HygOV/eEyLkSdjGwTb4cv6rjGsS0hb5
 GRay+m+d6ObgJTUUJbmr4iwDDMqPQwr7hNu6qFGZ09Q/fR/ei11TrDdgolP2j6/OGi9Q
 2h0BMvLEiFQNthj8wM64TXGF9ME/NAMmTKePnPVBK1utMTyKP4pBQLd5X2RWPYIim1vw
 1yfg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUZdrzs293QJvzSXnN4+PhkccnmQ27J8RhZNoanitHkiCesr9M/y45cgAwNeZRjCMc4b9WaRwQl0zp6@nongnu.org
X-Gm-Message-State: AOJu0YyhS7pg1Xa/igR7CLbLlafjKXrU1UmbDcmra3L6X2+KEP1r57Jj
 7SSyEKaOwzbAabTk7dXUAiHJSbi9ObNKR5ebzYNCF2pzj9GDXIMgaG7nGJfgB4Y=
X-Google-Smtp-Source: AGHT+IGyCuGVJnzo/jZ1tIrm847oeGhcLTbht+8BIkGtXGWbZ9STlsZba8oEg8XEOGdD3gZuKJ9ing==
X-Received: by 2002:a05:6a00:889:b0:714:2198:26bd with SMTP id
 d2e1a72fcca58-71dc5c67060mr501653b3a.11.1727801194622; 
 Tue, 01 Oct 2024 09:46:34 -0700 (PDT)
Received: from [192.168.1.67] (216-180-64-156.dyn.novuscom.net.
 [216.180.64.156]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71b2649f879sm8247606b3a.22.2024.10.01.09.46.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 01 Oct 2024 09:46:34 -0700 (PDT)
Message-ID: <b2413aa8-40ae-4174-85ab-3a4be3e3b9e2@linaro.org>
Date: Tue, 1 Oct 2024 09:46:33 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/13] hw/virtio/virtio-access: Use the ld/st_endian_p()
 API
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Mahmoud Mandour <ma.mandourr@gmail.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Thomas Huth
 <thuth@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>, Jason Wang <jasowang@redhat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, Anton Johansson <anjo@rev.ng>,
 Peter Maydell <peter.maydell@linaro.org>, Huacai Chen
 <chenhuacai@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 Sven Schnelle <svens@stackframe.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 qemu-arm@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>,
 Max Filippov <jcmvbkbc@gmail.com>, Paul Burton <paulburton@kernel.org>
References: <20240930073450.33195-1-philmd@linaro.org>
 <20240930073450.33195-3-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20240930073450.33195-3-philmd@linaro.org>
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

T24gOS8zMC8yNCAwMDozNCwgUGhpbGlwcGUgTWF0aGlldS1EYXVkw6kgd3JvdGU6DQo+IFJl
ZmFjdG9yIHRvIHVzZSB0aGUgcmVjZW50bHkgaW50cm9kdWNlZCBsZC9zdF9lbmRpYW5fcCgp
IEFQSQ0KPiBObyBsb2dpY2FsIGNoYW5nZSBpbnRlbmRlZC4NCj4gDQo+IFNpZ25lZC1vZmYt
Ynk6IFBoaWxpcHBlIE1hdGhpZXUtRGF1ZMOpIDxwaGlsbWRAbGluYXJvLm9yZz4NCj4gLS0t
DQo+ICAgaW5jbHVkZS9ody92aXJ0aW8vdmlydGlvLWFjY2Vzcy5oIHwgMzYgKysrKysrLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPiAgIDEgZmlsZSBjaGFuZ2VkLCA2IGluc2VydGlv
bnMoKyksIDMwIGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvaHcv
dmlydGlvL3ZpcnRpby1hY2Nlc3MuaCBiL2luY2x1ZGUvaHcvdmlydGlvL3ZpcnRpby1hY2Nl
c3MuaA0KPiBpbmRleCAwN2FhZTY5MDQyLi5iOTIwODc0YmU4IDEwMDY0NA0KPiAtLS0gYS9p
bmNsdWRlL2h3L3ZpcnRpby92aXJ0aW8tYWNjZXNzLmgNCj4gKysrIGIvaW5jbHVkZS9ody92
aXJ0aW8vdmlydGlvLWFjY2Vzcy5oDQo+IEBAIC05NSw1NiArOTUsMzIgQEAgc3RhdGljIGlu
bGluZSB2b2lkIHZpcnRpb19zdGxfcGh5cyhWaXJ0SU9EZXZpY2UgKnZkZXYsIGh3YWRkciBw
YSwNCj4gICANCj4gICBzdGF0aWMgaW5saW5lIHZvaWQgdmlydGlvX3N0d19wKFZpcnRJT0Rl
dmljZSAqdmRldiwgdm9pZCAqcHRyLCB1aW50MTZfdCB2KQ0KPiAgIHsNCj4gLSAgICBpZiAo
dmlydGlvX2FjY2Vzc19pc19iaWdfZW5kaWFuKHZkZXYpKSB7DQo+IC0gICAgICAgIHN0d19i
ZV9wKHB0ciwgdik7DQo+IC0gICAgfSBlbHNlIHsNCj4gLSAgICAgICAgc3R3X2xlX3AocHRy
LCB2KTsNCj4gLSAgICB9DQo+ICsgICAgc3R3X2VuZGlhbl9wKHZpcnRpb19hY2Nlc3NfaXNf
YmlnX2VuZGlhbih2ZGV2KSwgcHRyLCB2KTsNCj4gICB9DQo+ICAgDQo+ICAgc3RhdGljIGlu
bGluZSB2b2lkIHZpcnRpb19zdGxfcChWaXJ0SU9EZXZpY2UgKnZkZXYsIHZvaWQgKnB0ciwg
dWludDMyX3QgdikNCj4gICB7DQo+IC0gICAgaWYgKHZpcnRpb19hY2Nlc3NfaXNfYmlnX2Vu
ZGlhbih2ZGV2KSkgew0KPiAtICAgICAgICBzdGxfYmVfcChwdHIsIHYpOw0KPiAtICAgIH0g
ZWxzZSB7DQo+IC0gICAgICAgIHN0bF9sZV9wKHB0ciwgdik7DQo+IC0gICAgfQ0KPiArICAg
IHN0bF9lbmRpYW5fcCh2aXJ0aW9fYWNjZXNzX2lzX2JpZ19lbmRpYW4odmRldiksIHB0ciwg
dik7DQo+ICAgfQ0KPiAgIA0KPiAgIHN0YXRpYyBpbmxpbmUgdm9pZCB2aXJ0aW9fc3RxX3Ao
VmlydElPRGV2aWNlICp2ZGV2LCB2b2lkICpwdHIsIHVpbnQ2NF90IHYpDQo+ICAgew0KPiAt
ICAgIGlmICh2aXJ0aW9fYWNjZXNzX2lzX2JpZ19lbmRpYW4odmRldikpIHsNCj4gLSAgICAg
ICAgc3RxX2JlX3AocHRyLCB2KTsNCj4gLSAgICB9IGVsc2Ugew0KPiAtICAgICAgICBzdHFf
bGVfcChwdHIsIHYpOw0KPiAtICAgIH0NCj4gKyAgICBzdHFfZW5kaWFuX3AodmlydGlvX2Fj
Y2Vzc19pc19iaWdfZW5kaWFuKHZkZXYpLCBwdHIsIHYpOw0KPiAgIH0NCj4gICANCj4gICBz
dGF0aWMgaW5saW5lIGludCB2aXJ0aW9fbGR1d19wKFZpcnRJT0RldmljZSAqdmRldiwgY29u
c3Qgdm9pZCAqcHRyKQ0KPiAgIHsNCj4gLSAgICBpZiAodmlydGlvX2FjY2Vzc19pc19iaWdf
ZW5kaWFuKHZkZXYpKSB7DQo+IC0gICAgICAgIHJldHVybiBsZHV3X2JlX3AocHRyKTsNCj4g
LSAgICB9IGVsc2Ugew0KPiAtICAgICAgICByZXR1cm4gbGR1d19sZV9wKHB0cik7DQo+IC0g
ICAgfQ0KPiArICAgIHJldHVybiBsZHV3X2VuZGlhbl9wKHZpcnRpb19hY2Nlc3NfaXNfYmln
X2VuZGlhbih2ZGV2KSwgcHRyKTsNCj4gICB9DQo+ICAgDQo+ICAgc3RhdGljIGlubGluZSBp
bnQgdmlydGlvX2xkbF9wKFZpcnRJT0RldmljZSAqdmRldiwgY29uc3Qgdm9pZCAqcHRyKQ0K
PiAgIHsNCj4gLSAgICBpZiAodmlydGlvX2FjY2Vzc19pc19iaWdfZW5kaWFuKHZkZXYpKSB7
DQo+IC0gICAgICAgIHJldHVybiBsZGxfYmVfcChwdHIpOw0KPiAtICAgIH0gZWxzZSB7DQo+
IC0gICAgICAgIHJldHVybiBsZGxfbGVfcChwdHIpOw0KPiAtICAgIH0NCj4gKyAgICByZXR1
cm4gbGRsX2VuZGlhbl9wKHZpcnRpb19hY2Nlc3NfaXNfYmlnX2VuZGlhbih2ZGV2KSwgcHRy
KTsNCj4gICB9DQo+ICAgDQo+ICAgc3RhdGljIGlubGluZSB1aW50NjRfdCB2aXJ0aW9fbGRx
X3AoVmlydElPRGV2aWNlICp2ZGV2LCBjb25zdCB2b2lkICpwdHIpDQo+ICAgew0KPiAtICAg
IGlmICh2aXJ0aW9fYWNjZXNzX2lzX2JpZ19lbmRpYW4odmRldikpIHsNCj4gLSAgICAgICAg
cmV0dXJuIGxkcV9iZV9wKHB0cik7DQo+IC0gICAgfSBlbHNlIHsNCj4gLSAgICAgICAgcmV0
dXJuIGxkcV9sZV9wKHB0cik7DQo+IC0gICAgfQ0KPiArICAgIHJldHVybiBsZHFfZW5kaWFu
X3AodmlydGlvX2FjY2Vzc19pc19iaWdfZW5kaWFuKHZkZXYpLCBwdHIpOw0KPiAgIH0NCj4g
ICANCj4gICBzdGF0aWMgaW5saW5lIHVpbnQxNl90IHZpcnRpb190c3dhcDE2KFZpcnRJT0Rl
dmljZSAqdmRldiwgdWludDE2X3QgcykNCg0KUmV2aWV3ZWQtYnk6IFBpZXJyaWNrIEJvdXZp
ZXIgPHBpZXJyaWNrLmJvdXZpZXJAbGluYXJvLm9yZz4NCg==

