Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF7D7CEACEA
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2024 16:55:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svg8n-0004iK-RK; Tue, 01 Oct 2024 12:54:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1svg8i-0004bY-Vr
 for qemu-devel@nongnu.org; Tue, 01 Oct 2024 12:54:21 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1svg8h-0007iO-4l
 for qemu-devel@nongnu.org; Tue, 01 Oct 2024 12:54:20 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-20b833f9b35so22593885ad.2
 for <qemu-devel@nongnu.org>; Tue, 01 Oct 2024 09:54:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727801657; x=1728406457; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=n8WZYo/smvGOwt0dJrtZi25lZ2Ge2hAEjMAzmHYif+I=;
 b=yACUloGFaF42FQuo9dDOcdQSnR/vZFcWz7UJ9gqnJMR9HZKHB9bdlMbSHMux+ydzSA
 gVw0dcHJi4ms2zw713umEdAqwCqTWCQo7w4m7n0QOT8eXoI+s7qUoP9rdFk6EcE6UKCx
 QNQg+e1+XRT69XH67m6OeIBMNMNkY1F4QDL//ZAbgPe7VXKfbVWBhxE4nfLpikqVps8N
 cf8MZB68lj+fReL++xvkOfmem9WBJ98uMYpIKEmIZBT5Vsh/Slp1nnvMPOpQJFk3x2mB
 Yd5/9W58xeRbU6CSnHON43JoCWZdKsSR17HnmlUZm8ZirAWBQ4LjS/AE7jmXdYDSrrvT
 /gKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727801657; x=1728406457;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=n8WZYo/smvGOwt0dJrtZi25lZ2Ge2hAEjMAzmHYif+I=;
 b=slIEsGsJ+4RsVNCZtahLICT2d6Tq2yO7/cn1ojDkyTOgkar/9vKB8FovAbi/9YsFAm
 IVtuhEoB6ymzjf3bB1hxV1rvX7fo14QV+Q25lU7RghoCbyHYyRMdIkTfC7zcfjVpVJDR
 HVSl3VTYISL12iZFv87kGZT6Th6X84kvmGCxqPqypy4+IjJ+BjjGbSSjZvX/v8taRzy9
 4LJktQDP9pSAYtf2feiGm0F1lYGkaJZjYBNmym/aZFD1wTanaWIGAC6b2637R+VK0oue
 S/2RKR6NsGxvwUGNXjo9DYzt9dFoALTguNPneX1ObjjEwYS2Wlu8wiCV380gTVZKNuWZ
 SPEg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW6m5BnG+aeQ0nhOeRkbSKYKV59CH5fW+TBonyOuFYr/DZyn7yU2uRiADnzcy6hMECwm43+OgKCv3Ta@nongnu.org
X-Gm-Message-State: AOJu0Yy4e2H04m2PEh+LjtXwxTXpe/QXpWW5RLiUxtcVB7NWSaDknEMy
 cS5SbHqi5Po8A9ECl4ugB/8Kc5Nzmx8WXkL4SEBNsEayMahnW2SaRgaS3VoiV3tnfoimz4SaGpi
 srg1ifw==
X-Google-Smtp-Source: AGHT+IGXpMi8lppIctK9eUZN9dYd+tHZ9l0HdoI5wWXECb2atWSCvRZAMEC3F0C4Z8+mOgcoBD4nSw==
X-Received: by 2002:a17:902:f543:b0:20b:7094:8d14 with SMTP id
 d9443c01a7336-20bc5999061mr2565645ad.5.1727801656645; 
 Tue, 01 Oct 2024 09:54:16 -0700 (PDT)
Received: from [192.168.1.67] (216-180-64-156.dyn.novuscom.net.
 [216.180.64.156]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20b37e0d733sm71423635ad.122.2024.10.01.09.54.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 01 Oct 2024 09:54:16 -0700 (PDT)
Message-ID: <ac7bde34-8c7a-4841-b8c2-94eb1bb1c724@linaro.org>
Date: Tue, 1 Oct 2024 09:54:15 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/13] exec/memory_ldst_phys: Introduce
 ld/st_endian_phys() API
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
 <20240930073450.33195-10-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20240930073450.33195-10-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x636.google.com
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

T24gOS8zMC8yNCAwMDozNCwgUGhpbGlwcGUgTWF0aGlldS1EYXVkw6kgd3JvdGU6DQo+IElu
dHJvZHVjZSB0aGUgbGQvc3RfZW5kaWFuX3BoeXMoKSBBUEksIHdoaWNoIHRha2VzIGFuIGV4
dHJhDQo+IGJvb2xlYW4gYXJndW1lbnQgdG8gZGlzcGF0Y2ggdG8gbGQvc3Rfe2JlLGxlfV9w
aHlzKCkgbWV0aG9kcy4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IFBoaWxpcHBlIE1hdGhpZXUt
RGF1ZMOpIDxwaGlsbWRAbGluYXJvLm9yZz4NCj4gLS0tDQo+IFRPRE86IFVwZGF0ZSBkb2Nz
dHJpbmcgcmVnZXhwDQo+IC0tLQ0KPiAgIGluY2x1ZGUvZXhlYy9tZW1vcnlfbGRzdF9waHlz
LmguaW5jIHwgNjYgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysNCj4gICAxIGZpbGUg
Y2hhbmdlZCwgNjYgaW5zZXJ0aW9ucygrKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUv
ZXhlYy9tZW1vcnlfbGRzdF9waHlzLmguaW5jIGIvaW5jbHVkZS9leGVjL21lbW9yeV9sZHN0
X3BoeXMuaC5pbmMNCj4gaW5kZXggZWNkNjc4NjEwZC4uOGVhMTYyYjQwZCAxMDA2NDQNCj4g
LS0tIGEvaW5jbHVkZS9leGVjL21lbW9yeV9sZHN0X3BoeXMuaC5pbmMNCj4gKysrIGIvaW5j
bHVkZS9leGVjL21lbW9yeV9sZHN0X3BoeXMuaC5pbmMNCj4gQEAgLTc0LDYgKzc0LDE2IEBA
IHN0YXRpYyBpbmxpbmUgdWludDE2X3QgZ2x1ZShsZHV3X2JlX3BoeXMsIFNVRkZJWCkoQVJH
MV9ERUNMLCBod2FkZHIgYWRkcikNCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIE1FTVRYQVRUUlNfVU5TUEVDSUZJRUQsIE5VTEwpOw0KPiAg
IH0NCj4gICANCj4gK3N0YXRpYyBpbmxpbmUgdWludDE2X3QgZ2x1ZShsZHV3X2VuZGlhbl9w
aHlzLCBTVUZGSVgpKGJvb2wgYmlnX2VuZGlhbiwNCj4gKyAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIEFSRzFfREVDTCwgaHdhZGRyIGFk
ZHIpDQo+ICt7DQo+ICsgICAgcmV0dXJuIGJpZ19lbmRpYW4NCj4gKyAgICAgICAgICAgPyBn
bHVlKGFkZHJlc3Nfc3BhY2VfbGR1d19sZSwgU1VGRklYKShBUkcxLCBhZGRyLA0KPiArICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIE1FTVRYQVRU
UlNfVU5TUEVDSUZJRUQsIE5VTEwpDQo+ICsgICAgICAgICAgIDogZ2x1ZShhZGRyZXNzX3Nw
YWNlX2xkdXdfYmUsIFNVRkZJWCkoQVJHMSwgYWRkciwNCj4gKyAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBNRU1UWEFUVFJTX1VOU1BFQ0lGSUVE
LCBOVUxMKTsNCj4gK30NCj4gKw0KPiAgIHN0YXRpYyBpbmxpbmUgdWludDMyX3QgZ2x1ZShs
ZGxfbGVfcGh5cywgU1VGRklYKShBUkcxX0RFQ0wsIGh3YWRkciBhZGRyKQ0KPiAgIHsNCj4g
ICAgICAgcmV0dXJuIGdsdWUoYWRkcmVzc19zcGFjZV9sZGxfbGUsIFNVRkZJWCkoQVJHMSwg
YWRkciwNCj4gQEAgLTg2LDYgKzk2LDE2IEBAIHN0YXRpYyBpbmxpbmUgdWludDMyX3QgZ2x1
ZShsZGxfYmVfcGh5cywgU1VGRklYKShBUkcxX0RFQ0wsIGh3YWRkciBhZGRyKQ0KPiAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBNRU1UWEFUVFJT
X1VOU1BFQ0lGSUVELCBOVUxMKTsNCj4gICB9DQo+ICAgDQo+ICtzdGF0aWMgaW5saW5lIHVp
bnQzMl90IGdsdWUobGRsX2VuZGlhbl9waHlzLCBTVUZGSVgpKGJvb2wgYmlnX2VuZGlhbiwN
Cj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgQVJHMV9ERUNMLCBod2FkZHIgYWRkcikNCj4gK3sNCj4gKyAgICByZXR1cm4gYmlnX2Vu
ZGlhbg0KPiArICAgICAgICAgICA/IGdsdWUoYWRkcmVzc19zcGFjZV9sZGxfbGUsIFNVRkZJ
WCkoQVJHMSwgYWRkciwNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIE1FTVRYQVRUUlNfVU5TUEVDSUZJRUQsIE5VTEwpDQo+ICsgICAgICAg
ICAgIDogZ2x1ZShhZGRyZXNzX3NwYWNlX2xkbF9iZSwgU1VGRklYKShBUkcxLCBhZGRyLA0K
PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgTUVN
VFhBVFRSU19VTlNQRUNJRklFRCwgTlVMTCk7DQo+ICt9DQo+ICsNCj4gICBzdGF0aWMgaW5s
aW5lIHVpbnQ2NF90IGdsdWUobGRxX2xlX3BoeXMsIFNVRkZJWCkoQVJHMV9ERUNMLCBod2Fk
ZHIgYWRkcikNCj4gICB7DQo+ICAgICAgIHJldHVybiBnbHVlKGFkZHJlc3Nfc3BhY2VfbGRx
X2xlLCBTVUZGSVgpKEFSRzEsIGFkZHIsDQo+IEBAIC05OCw2ICsxMTgsMTYgQEAgc3RhdGlj
IGlubGluZSB1aW50NjRfdCBnbHVlKGxkcV9iZV9waHlzLCBTVUZGSVgpKEFSRzFfREVDTCwg
aHdhZGRyIGFkZHIpDQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIE1FTVRYQVRUUlNfVU5TUEVDSUZJRUQsIE5VTEwpOw0KPiAgIH0NCj4gICAN
Cj4gK3N0YXRpYyBpbmxpbmUgdWludDMyX3QgZ2x1ZShsZHFfZW5kaWFuX3BoeXMsIFNVRkZJ
WCkoYm9vbCBiaWdfZW5kaWFuLA0KPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICBBUkcxX0RFQ0wsIGh3YWRkciBhZGRyKQ0KPiArew0K
PiArICAgIHJldHVybiBiaWdfZW5kaWFuDQo+ICsgICAgICAgICAgID8gZ2x1ZShhZGRyZXNz
X3NwYWNlX2xkcV9sZSwgU1VGRklYKShBUkcxLCBhZGRyLA0KPiArICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgTUVNVFhBVFRSU19VTlNQRUNJRklF
RCwgTlVMTCkNCj4gKyAgICAgICAgICAgOiBnbHVlKGFkZHJlc3Nfc3BhY2VfbGRxX2JlLCBT
VUZGSVgpKEFSRzEsIGFkZHIsDQo+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICBNRU1UWEFUVFJTX1VOU1BFQ0lGSUVELCBOVUxMKTsNCj4gK30N
Cj4gKw0KPiAgIHN0YXRpYyBpbmxpbmUgdm9pZCBnbHVlKHN0Yl9waHlzLCBTVUZGSVgpKEFS
RzFfREVDTCwgaHdhZGRyIGFkZHIsIHVpbnQ4X3QgdmFsKQ0KPiAgIHsNCj4gICAgICAgZ2x1
ZShhZGRyZXNzX3NwYWNlX3N0YiwgU1VGRklYKShBUkcxLCBhZGRyLCB2YWwsDQo+IEBAIC0x
MTYsNiArMTQ2LDE4IEBAIHN0YXRpYyBpbmxpbmUgdm9pZCBnbHVlKHN0d19iZV9waHlzLCBT
VUZGSVgpKEFSRzFfREVDTCwgaHdhZGRyIGFkZHIsIHVpbnQxNl90IHZhDQo+ICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgTUVNVFhBVFRSU19VTlNQRUNJRklF
RCwgTlVMTCk7DQo+ICAgfQ0KPiAgIA0KPiArc3RhdGljIGlubGluZSB2b2lkIGdsdWUoc3R3
X2VuZGlhbl9waHlzLCBTVUZGSVgpKGJvb2wgYmlnX2VuZGlhbiwgQVJHMV9ERUNMLA0KPiAr
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGh3YWRk
ciBhZGRyLCB1aW50MTZfdCB2YWwpDQo+ICt7DQo+ICsgICAgaWYgKGJpZ19lbmRpYW4pIHsN
Cj4gKyAgICAgICAgZ2x1ZShhZGRyZXNzX3NwYWNlX3N0d19iZSwgU1VGRklYKShBUkcxLCBh
ZGRyLCB2YWwsDQo+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgTUVNVFhBVFRSU19VTlNQRUNJRklFRCwgTlVMTCk7DQo+ICsgICB9IGVsc2Ugew0KPiAr
ICAgICAgICBnbHVlKGFkZHJlc3Nfc3BhY2Vfc3R3X2xlLCBTVUZGSVgpKEFSRzEsIGFkZHIs
IHZhbCwNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBN
RU1UWEFUVFJTX1VOU1BFQ0lGSUVELCBOVUxMKTsNCj4gKyAgICB9DQo+ICt9DQo+ICsNCj4g
ICBzdGF0aWMgaW5saW5lIHZvaWQgZ2x1ZShzdGxfbGVfcGh5cywgU1VGRklYKShBUkcxX0RF
Q0wsIGh3YWRkciBhZGRyLCB1aW50MzJfdCB2YWwpDQo+ICAgew0KPiAgICAgICBnbHVlKGFk
ZHJlc3Nfc3BhY2Vfc3RsX2xlLCBTVUZGSVgpKEFSRzEsIGFkZHIsIHZhbCwNCj4gQEAgLTEy
OCw2ICsxNzAsMTggQEAgc3RhdGljIGlubGluZSB2b2lkIGdsdWUoc3RsX2JlX3BoeXMsIFNV
RkZJWCkoQVJHMV9ERUNMLCBod2FkZHIgYWRkciwgdWludDMyX3QgdmENCj4gICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBNRU1UWEFUVFJTX1VOU1BFQ0lGSUVE
LCBOVUxMKTsNCj4gICB9DQo+ICAgDQo+ICtzdGF0aWMgaW5saW5lIHZvaWQgZ2x1ZShzdGxf
ZW5kaWFuX3BoeXMsIFNVRkZJWCkoYm9vbCBiaWdfZW5kaWFuLCBBUkcxX0RFQ0wsDQo+ICsg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgaHdhZGRy
IGFkZHIsIHVpbnQzMl90IHZhbCkNCj4gK3sNCj4gKyAgICBpZiAoYmlnX2VuZGlhbikgew0K
PiArICAgICAgICBnbHVlKGFkZHJlc3Nfc3BhY2Vfc3RsX2JlLCBTVUZGSVgpKEFSRzEsIGFk
ZHIsIHZhbCwNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICBNRU1UWEFUVFJTX1VOU1BFQ0lGSUVELCBOVUxMKTsNCj4gKyAgIH0gZWxzZSB7DQo+ICsg
ICAgICAgIGdsdWUoYWRkcmVzc19zcGFjZV9zdGxfbGUsIFNVRkZJWCkoQVJHMSwgYWRkciwg
dmFsLA0KPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIE1F
TVRYQVRUUlNfVU5TUEVDSUZJRUQsIE5VTEwpOw0KPiArICAgIH0NCj4gK30NCj4gKw0KPiAg
IHN0YXRpYyBpbmxpbmUgdm9pZCBnbHVlKHN0cV9sZV9waHlzLCBTVUZGSVgpKEFSRzFfREVD
TCwgaHdhZGRyIGFkZHIsIHVpbnQ2NF90IHZhbCkNCj4gICB7DQo+ICAgICAgIGdsdWUoYWRk
cmVzc19zcGFjZV9zdHFfbGUsIFNVRkZJWCkoQVJHMSwgYWRkciwgdmFsLA0KPiBAQCAtMTM5
LDYgKzE5MywxOCBAQCBzdGF0aWMgaW5saW5lIHZvaWQgZ2x1ZShzdHFfYmVfcGh5cywgU1VG
RklYKShBUkcxX0RFQ0wsIGh3YWRkciBhZGRyLCB1aW50NjRfdCB2YQ0KPiAgICAgICBnbHVl
KGFkZHJlc3Nfc3BhY2Vfc3RxX2JlLCBTVUZGSVgpKEFSRzEsIGFkZHIsIHZhbCwNCj4gICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBNRU1UWEFUVFJTX1VOU1BF
Q0lGSUVELCBOVUxMKTsNCj4gICB9DQo+ICsNCj4gK3N0YXRpYyBpbmxpbmUgdm9pZCBnbHVl
KHN0cV9lbmRpYW5fcGh5cywgU1VGRklYKShib29sIGJpZ19lbmRpYW4sIEFSRzFfREVDTCwN
Cj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBo
d2FkZHIgYWRkciwgdWludDY0X3QgdmFsKQ0KPiArew0KPiArICAgIGlmIChiaWdfZW5kaWFu
KSB7DQo+ICsgICAgICAgIGdsdWUoYWRkcmVzc19zcGFjZV9zdHFfYmUsIFNVRkZJWCkoQVJH
MSwgYWRkciwgdmFsLA0KPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIE1FTVRYQVRUUlNfVU5TUEVDSUZJRUQsIE5VTEwpOw0KPiArICAgfSBlbHNlIHsN
Cj4gKyAgICAgICAgZ2x1ZShhZGRyZXNzX3NwYWNlX3N0cV9sZSwgU1VGRklYKShBUkcxLCBh
ZGRyLCB2YWwsDQo+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgTUVNVFhBVFRSU19VTlNQRUNJRklFRCwgTlVMTCk7DQo+ICsgICAgfQ0KPiArfQ0KPiAg
ICNlbmRpZg0KPiAgIA0KPiAgICN1bmRlZiBBUkcxX0RFQ0wNCg0KUmV2aWV3ZWQtYnk6IFBp
ZXJyaWNrIEJvdXZpZXIgPHBpZXJyaWNrLmJvdXZpZXJAbGluYXJvLm9yZz4NCg==

