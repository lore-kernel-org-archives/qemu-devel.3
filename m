Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8029CEACEB
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2024 16:55:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svg9Y-0005lO-Gn; Tue, 01 Oct 2024 12:55:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1svg9F-0005YW-Ox
 for qemu-devel@nongnu.org; Tue, 01 Oct 2024 12:54:55 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1svg9E-0007lS-9K
 for qemu-devel@nongnu.org; Tue, 01 Oct 2024 12:54:53 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-20b9b35c7c3so21232345ad.3
 for <qemu-devel@nongnu.org>; Tue, 01 Oct 2024 09:54:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727801691; x=1728406491; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=O3cQn7nEZVffi+N047IKUq9RZEYs/lpyONaUZxn39k4=;
 b=cz6PGllf04DI+YjE7eIKkH41BMWqmvJN5tI53NIND2Kb8nbd1w5f8ZPh6uFGPsUuGY
 IrGxyHd7oPzQzMwtYl0S7whLTZSz8viKs6/XMcOCgQHVI5pqXmLKIIcYX6o1WThBdV9A
 xPf+l/pzjGd/B3ZGchuOMWIeJMp53rNaHX5xXqN36x3OruyaSLXApRfjX4Yt4xzcHkFU
 tn3H99BcbWffUIdtvM0UJt9aG5QSZixxZT1hO8M5KHppZF6aH59u60F6cR/YDRsCT2ZN
 akv/RnZaEFAYhZMoh0mY7e2ycwEeDR0JqoCLVgNo+ZMgu2sKaNmHeIBfaB+zZpWXeJEL
 JHVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727801691; x=1728406491;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=O3cQn7nEZVffi+N047IKUq9RZEYs/lpyONaUZxn39k4=;
 b=Ej1O9SEWeIL6vk2xyk0xGNfH02PZ/OQHiZ3vBVecPY9abTNYEZ62HHp3cWiU0UuvDj
 CnUCQNTR/5NdtCEd6b7Fy0uAzb5IBFJOEbMeA1TYfY2HSUK4i3jzGYPNzVKZDyAVetc9
 k1E1iKnnZvi1BNAlnbzM6tZp/XYRA9XkkDZFGNNH6TizOCwYOeT2sAw3JPswnWkRex7J
 rk9+K+c3WpQ8OD43R7kyZIRPf1V47r3ycPrrrn3UiWVls5gsy7Hq2XfB+ecX3mXYB9lJ
 M2jLwJhQ3CYY7ZJIxlBIPepGslfnT9VvHf9PXAgs5VYl2YZqQm2XWlPXoUc0NyK3KdMg
 OW2w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUia4i4Edf4Q8xwfkgHzXt8Zd28hzzcIPDnhc6kO97+lm6Njsc0C8BANBOPRvIJErYbZtnOD0htq9Jn@nongnu.org
X-Gm-Message-State: AOJu0YwO2ke8Ge8RJv+DPx0HlrM+LA4XCnoZ0l26uMhECE10jxQp4ohE
 CQrzlrs2S+TDypQhLrbSbgtzWepuFmQgozO8iL30OE2z6dU4UemD+pOfXc8QPBc=
X-Google-Smtp-Source: AGHT+IEDEMrKyQMPd+BiZ4CYsvwxxBY/lnfLrgLbMPfCrue60H7W6dQHiqZLmefC4ebSmQXFthsXkA==
X-Received: by 2002:a17:903:1c4:b0:205:8407:6321 with SMTP id
 d9443c01a7336-20bc59c3bbcmr3930355ad.9.1727801691036; 
 Tue, 01 Oct 2024 09:54:51 -0700 (PDT)
Received: from [192.168.1.67] (216-180-64-156.dyn.novuscom.net.
 [216.180.64.156]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20b37e2f798sm71477785ad.183.2024.10.01.09.54.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 01 Oct 2024 09:54:50 -0700 (PDT)
Message-ID: <51ed8524-e732-469f-823a-90b29668674f@linaro.org>
Date: Tue, 1 Oct 2024 09:54:49 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/13] hw/virtio/virtio-access: Use ld/st_endian_phys() API
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
 <20240930073450.33195-11-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20240930073450.33195-11-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62f.google.com
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
ZmFjdG9yIHRvIHVzZSB0aGUgcmVjZW50bHkgaW50cm9kdWNlZCBsZC9zdF9lbmRpYW5fcGh5
cygpIEFQSS4NCj4gTm8gbG9naWNhbCBjaGFuZ2UgaW50ZW5kZWQuDQo+IA0KPiBTaWduZWQt
b2ZmLWJ5OiBQaGlsaXBwZSBNYXRoaWV1LURhdWTDqSA8cGhpbG1kQGxpbmFyby5vcmc+DQo+
IC0tLQ0KPiAgIGluY2x1ZGUvaHcvdmlydGlvL3ZpcnRpby1hY2Nlc3MuaCB8IDI3ICsrKysr
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPiAgIDEgZmlsZSBjaGFuZ2VkLCA1IGluc2VydGlv
bnMoKyksIDIyIGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvaHcv
dmlydGlvL3ZpcnRpby1hY2Nlc3MuaCBiL2luY2x1ZGUvaHcvdmlydGlvL3ZpcnRpby1hY2Nl
c3MuaA0KPiBpbmRleCBiOTIwODc0YmU4Li4zN2E0MjQwN2VhIDEwMDY0NA0KPiAtLS0gYS9p
bmNsdWRlL2h3L3ZpcnRpby92aXJ0aW8tYWNjZXNzLmgNCj4gKysrIGIvaW5jbHVkZS9ody92
aXJ0aW8vdmlydGlvLWFjY2Vzcy5oDQo+IEBAIC00MywzMCArNDMsMjEgQEAgc3RhdGljIGlu
bGluZSB1aW50MTZfdCB2aXJ0aW9fbGR1d19waHlzKFZpcnRJT0RldmljZSAqdmRldiwgaHdh
ZGRyIHBhKQ0KPiAgIHsNCj4gICAgICAgQWRkcmVzc1NwYWNlICpkbWFfYXMgPSB2ZGV2LT5k
bWFfYXM7DQo+ICAgDQo+IC0gICAgaWYgKHZpcnRpb19hY2Nlc3NfaXNfYmlnX2VuZGlhbih2
ZGV2KSkgew0KPiAtICAgICAgICByZXR1cm4gbGR1d19iZV9waHlzKGRtYV9hcywgcGEpOw0K
PiAtICAgIH0NCj4gLSAgICByZXR1cm4gbGR1d19sZV9waHlzKGRtYV9hcywgcGEpOw0KPiAr
ICAgIHJldHVybiBsZHV3X2VuZGlhbl9waHlzKHZpcnRpb19hY2Nlc3NfaXNfYmlnX2VuZGlh
bih2ZGV2KSwgZG1hX2FzLCBwYSk7DQo+ICAgfQ0KPiAgIA0KPiAgIHN0YXRpYyBpbmxpbmUg
dWludDMyX3QgdmlydGlvX2xkbF9waHlzKFZpcnRJT0RldmljZSAqdmRldiwgaHdhZGRyIHBh
KQ0KPiAgIHsNCj4gICAgICAgQWRkcmVzc1NwYWNlICpkbWFfYXMgPSB2ZGV2LT5kbWFfYXM7
DQo+ICAgDQo+IC0gICAgaWYgKHZpcnRpb19hY2Nlc3NfaXNfYmlnX2VuZGlhbih2ZGV2KSkg
ew0KPiAtICAgICAgICByZXR1cm4gbGRsX2JlX3BoeXMoZG1hX2FzLCBwYSk7DQo+IC0gICAg
fQ0KPiAtICAgIHJldHVybiBsZGxfbGVfcGh5cyhkbWFfYXMsIHBhKTsNCj4gKyAgICByZXR1
cm4gbGRsX2VuZGlhbl9waHlzKHZpcnRpb19hY2Nlc3NfaXNfYmlnX2VuZGlhbih2ZGV2KSwg
ZG1hX2FzLCBwYSk7DQo+ICAgfQ0KPiAgIA0KPiAgIHN0YXRpYyBpbmxpbmUgdWludDY0X3Qg
dmlydGlvX2xkcV9waHlzKFZpcnRJT0RldmljZSAqdmRldiwgaHdhZGRyIHBhKQ0KPiAgIHsN
Cj4gICAgICAgQWRkcmVzc1NwYWNlICpkbWFfYXMgPSB2ZGV2LT5kbWFfYXM7DQo+ICAgDQo+
IC0gICAgaWYgKHZpcnRpb19hY2Nlc3NfaXNfYmlnX2VuZGlhbih2ZGV2KSkgew0KPiAtICAg
ICAgICByZXR1cm4gbGRxX2JlX3BoeXMoZG1hX2FzLCBwYSk7DQo+IC0gICAgfQ0KPiAtICAg
IHJldHVybiBsZHFfbGVfcGh5cyhkbWFfYXMsIHBhKTsNCj4gKyAgICByZXR1cm4gbGRxX2Vu
ZGlhbl9waHlzKHZpcnRpb19hY2Nlc3NfaXNfYmlnX2VuZGlhbih2ZGV2KSwgZG1hX2FzLCBw
YSk7DQo+ICAgfQ0KPiAgIA0KPiAgIHN0YXRpYyBpbmxpbmUgdm9pZCB2aXJ0aW9fc3R3X3Bo
eXMoVmlydElPRGV2aWNlICp2ZGV2LCBod2FkZHIgcGEsDQo+IEBAIC03NCwxMSArNjUsNyBA
QCBzdGF0aWMgaW5saW5lIHZvaWQgdmlydGlvX3N0d19waHlzKFZpcnRJT0RldmljZSAqdmRl
diwgaHdhZGRyIHBhLA0KPiAgIHsNCj4gICAgICAgQWRkcmVzc1NwYWNlICpkbWFfYXMgPSB2
ZGV2LT5kbWFfYXM7DQo+ICAgDQo+IC0gICAgaWYgKHZpcnRpb19hY2Nlc3NfaXNfYmlnX2Vu
ZGlhbih2ZGV2KSkgew0KPiAtICAgICAgICBzdHdfYmVfcGh5cyhkbWFfYXMsIHBhLCB2YWx1
ZSk7DQo+IC0gICAgfSBlbHNlIHsNCj4gLSAgICAgICAgc3R3X2xlX3BoeXMoZG1hX2FzLCBw
YSwgdmFsdWUpOw0KPiAtICAgIH0NCj4gKyAgICBzdHdfZW5kaWFuX3BoeXModmlydGlvX2Fj
Y2Vzc19pc19iaWdfZW5kaWFuKHZkZXYpLCBkbWFfYXMsIHBhLCB2YWx1ZSk7DQo+ICAgfQ0K
PiAgIA0KPiAgIHN0YXRpYyBpbmxpbmUgdm9pZCB2aXJ0aW9fc3RsX3BoeXMoVmlydElPRGV2
aWNlICp2ZGV2LCBod2FkZHIgcGEsDQo+IEBAIC04NiwxMSArNzMsNyBAQCBzdGF0aWMgaW5s
aW5lIHZvaWQgdmlydGlvX3N0bF9waHlzKFZpcnRJT0RldmljZSAqdmRldiwgaHdhZGRyIHBh
LA0KPiAgIHsNCj4gICAgICAgQWRkcmVzc1NwYWNlICpkbWFfYXMgPSB2ZGV2LT5kbWFfYXM7
DQo+ICAgDQo+IC0gICAgaWYgKHZpcnRpb19hY2Nlc3NfaXNfYmlnX2VuZGlhbih2ZGV2KSkg
ew0KPiAtICAgICAgICBzdGxfYmVfcGh5cyhkbWFfYXMsIHBhLCB2YWx1ZSk7DQo+IC0gICAg
fSBlbHNlIHsNCj4gLSAgICAgICAgc3RsX2xlX3BoeXMoZG1hX2FzLCBwYSwgdmFsdWUpOw0K
PiAtICAgIH0NCj4gKyAgICBzdGxfZW5kaWFuX3BoeXModmlydGlvX2FjY2Vzc19pc19iaWdf
ZW5kaWFuKHZkZXYpLCBkbWFfYXMsIHBhLCB2YWx1ZSk7DQo+ICAgfQ0KPiAgIA0KPiAgIHN0
YXRpYyBpbmxpbmUgdm9pZCB2aXJ0aW9fc3R3X3AoVmlydElPRGV2aWNlICp2ZGV2LCB2b2lk
ICpwdHIsIHVpbnQxNl90IHYpDQoNClJldmlld2VkLWJ5OiBQaWVycmljayBCb3V2aWVyIDxw
aWVycmljay5ib3V2aWVyQGxpbmFyby5vcmc+DQo=

