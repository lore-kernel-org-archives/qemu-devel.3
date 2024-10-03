Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAF68CF34CA
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Oct 2024 21:34:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1swTSl-0007Xb-JU; Thu, 03 Oct 2024 17:34:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1swTSk-0007WY-Bd
 for qemu-devel@nongnu.org; Thu, 03 Oct 2024 17:34:18 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1swTSh-0006MA-N5
 for qemu-devel@nongnu.org; Thu, 03 Oct 2024 17:34:18 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-20b78ee6298so9134605ad.2
 for <qemu-devel@nongnu.org>; Thu, 03 Oct 2024 14:34:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727991254; x=1728596054; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=wut2VfmefsDTxx/0B6GKn5XwtTzZN0devQNAsGmEMVI=;
 b=OltdftrTicrjutIrDe7tjVIhrEs9sbBtCen7CgdvFiboGS5BVetJoQX3K5vKFduQII
 gKraYcKMxwIM5rwLB4b/WAHGO9ZwHcJZU6TERYx2m7ESULtR+LOwNG9nUWIhkJ8fL0Gq
 QQaisC/UlnEredpOsjeKXR0NeBfDzjuspI3xhlX0wZjDVP7NK3m+bfdptSAKTuY9/Nqx
 nG527R5lHtWFR62q9nSONquFEAOTlBfyFpkwG8Bcx+f9fyfxYPzBHgOztK4Jc1Yc/o9m
 Exk2yZ5zoG2R6cqmgt3ZS4upzV+G99Xl1KPeeRRfTUw13gqhc+WUGlg2DLQTepbHHuZ+
 OpfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727991254; x=1728596054;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=wut2VfmefsDTxx/0B6GKn5XwtTzZN0devQNAsGmEMVI=;
 b=g27IrCwG7VLy6LwquRDQNwcwinGibWpT/cohO7UgUQ9HGkvQSubFH/Zvid0UkwaQsi
 TAveA5F2x6xKOyFUYlNLWZSgA433/xG+Wu3chKhUEIa2HWgml4FRuwvSQ1kT3KZT4tUx
 6FuTFRvS/vQCPAktC1Z1AHmHKIKezr2HcgxP6ISkh/UEY++GpLpdmySYvMRnF60sO+Ci
 Fyxt+8hn3MF8m3RookPz7qoSFvZNMOcLOgLja0MxH9+3UXTJ5wX5mANoW76oAMFanURa
 zUGRcr61w40rruoTOq+M+ZuUIF2HWW+FzOV3VP4k69Dr1wo4hMRgttw+OCEucGa+VpbQ
 iHUg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVECcujS/Nu+qO/wrawIy82fuZlZbM4fo5NDkQCXKp+rQEkUHncSjrl1SDNZxLYq/6tqSF5/QPePGvJ@nongnu.org
X-Gm-Message-State: AOJu0Yy0eCtJK3pm8aZxJ14CwiFxK/KFUkL8Dw8zEx/BLWGy4HhE9GiS
 ZWULwxkIdJRkuNtoL1pfX6UK3/lvhOUu3pvBGukLBSuf0tW8KKKbUvOYKdNusdY=
X-Google-Smtp-Source: AGHT+IHNC5G3L1x04inR/nzkP/D/G2BJXAL1GAUGKLld1pMsIP7srJorshH+6lLW9EI11G3E6ucI1g==
X-Received: by 2002:a17:903:24f:b0:1fb:90e1:c8c5 with SMTP id
 d9443c01a7336-20bfe03f6a2mr6740075ad.33.1727991254158; 
 Thu, 03 Oct 2024 14:34:14 -0700 (PDT)
Received: from [192.168.1.67] (216-180-64-156.dyn.novuscom.net.
 [216.180.64.156]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20bef70701fsm13136695ad.258.2024.10.03.14.34.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Oct 2024 14:34:13 -0700 (PDT)
Message-ID: <46ea20fd-c6bc-411a-b8e2-ab7179c00185@linaro.org>
Date: Thu, 3 Oct 2024 14:34:12 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/13] hw/xtensa/xtfpga: Replace memcpy()+tswap32() by
 stl_endian_p()
Content-Language: en-US
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: Mahmoud Mandour <ma.mandourr@gmail.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>, Jason Wang <jasowang@redhat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, Anton Johansson <anjo@rev.ng>,
 Peter Maydell <peter.maydell@linaro.org>, Huacai Chen
 <chenhuacai@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 Sven Schnelle <svens@stackframe.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 qemu-arm@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>,
 Max Filippov <jcmvbkbc@gmail.com>, Paul Burton <paulburton@kernel.org>
References: <20240930073450.33195-1-philmd@linaro.org>
 <20240930073450.33195-9-philmd@linaro.org>
 <257b0de0-6744-4ae8-a2c5-f05eec29a3f0@redhat.com>
 <0c28a435-0af6-450f-8558-14dddc6cb6a6@linaro.org>
 <a14cd43c-087b-4a5d-b036-39aa6a80e691@linaro.org>
 <f20cebfe-027a-4664-82f0-3769c7047e38@linaro.org>
 <aeb88605-989b-4c26-9371-15fbe44a9e3a@linaro.org>
In-Reply-To: <aeb88605-989b-4c26-9371-15fbe44a9e3a@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x630.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

T24gMTAvMy8yNCAxNDozMSwgUGllcnJpY2sgQm91dmllciB3cm90ZToNCj4gT24gMTAvMy8y
NCAxMzo0OCwgUGhpbGlwcGUgTWF0aGlldS1EYXVkw6kgd3JvdGU6DQo+PiBPbiAzLzEwLzI0
IDE4OjA0LCBQaWVycmljayBCb3V2aWVyIHdyb3RlOg0KPj4+IE9uIDEwLzMvMjQgMDk6MDIs
IFBoaWxpcHBlIE1hdGhpZXUtRGF1ZMOpIHdyb3RlOg0KPj4+PiBPbiAzMC85LzI0IDE2OjMy
LCBUaG9tYXMgSHV0aCB3cm90ZToNCj4+Pj4+IE9uIDMwLzA5LzIwMjQgMDkuMzQsIFBoaWxp
cHBlIE1hdGhpZXUtRGF1ZMOpIHdyb3RlOg0KPj4+Pj4+IFJlcGxhY2UgYSBwYWlyIG9mIG1l
bWNweSgpICsgdHN3YXAzMigpIGJ5IHN0bF9lbmRpYW5fcCgpLA0KPj4+Pj4+IHdoaWNoIGFs
c28gc3dhcCB0aGUgdmFsdWUgdXNpbmcgdGFyZ2V0IGVuZGlhbm5lc3MuDQo+Pj4+Pj4NCj4+
Pj4+PiBTaWduZWQtb2ZmLWJ5OiBQaGlsaXBwZSBNYXRoaWV1LURhdWTDqSA8cGhpbG1kQGxp
bmFyby5vcmc+DQo+Pj4+Pj4gLS0tDQo+Pj4+Pj4gICDCoMKgIGh3L3h0ZW5zYS94dGZwZ2Eu
YyB8IDYgKystLS0tDQo+Pj4+Pj4gICDCoMKgIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlv
bnMoKyksIDQgZGVsZXRpb25zKC0pDQo+Pj4+Pj4NCj4+Pj4+PiBkaWZmIC0tZ2l0IGEvaHcv
eHRlbnNhL3h0ZnBnYS5jIGIvaHcveHRlbnNhL3h0ZnBnYS5jDQo+Pj4+Pj4gaW5kZXggMjI4
ZjAwYjA0NS4uNTIxZmU4NGIwMSAxMDA2NDQNCj4+Pj4+PiAtLS0gYS9ody94dGVuc2EveHRm
cGdhLmMNCj4+Pj4+PiArKysgYi9ody94dGVuc2EveHRmcGdhLmMNCj4+Pj4+PiBAQCAtNDM4
LDExICs0MzgsOSBAQCBzdGF0aWMgdm9pZCB4dGZwZ2FfaW5pdChjb25zdCBYdGZwZ2FCb2Fy
ZERlc2MNCj4+Pj4+PiAqYm9hcmQsIE1hY2hpbmVTdGF0ZSAqbWFjaGluZSkNCj4+Pj4+PiAg
IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgY29uc3Qgc2l6ZV90IGJvb3Rfc3ogPSBU
QVJHRVRfQklHX0VORElBTiA/DQo+Pj4+Pj4gc2l6ZW9mKGJvb3RfYmUpDQo+Pj4+Pj4gICDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCA6DQo+Pj4+Pj4gc2l6ZW9mKGJvb3RfbGUpOw0KPj4+Pj4+ICAgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCB1aW50OF90ICpib290ID0gVEFSR0VUX0JJR19FTkRJQU4gPyBib290
X2JlIDogYm9vdF9sZTsNCj4+Pj4+PiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB1aW50MzJf
dCBlbnRyeV9wYyA9IHRzd2FwMzIoZW50cnlfcG9pbnQpOw0KPj4+Pj4+IC3CoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIHVpbnQzMl90IGVudHJ5X2EyID0gdHN3YXAzMih0YWdwdHIpOw0KPj4+
Pj4+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgIG1lbWNweShib290ICsgNCwgJmVudHJ5X3Bj
LCBzaXplb2YoZW50cnlfcGMpKTsNCj4+Pj4+PiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBt
ZW1jcHkoYm9vdCArIDgsICZlbnRyeV9hMiwgc2l6ZW9mKGVudHJ5X2EyKSk7DQo+Pj4+Pj4g
K8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgc3RsX2VuZGlhbl9wKFRBUkdFVF9CSUdfRU5ESUFO
LCBib290ICsgNCwgZW50cnlfcG9pbnQpOw0KPj4+Pj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIHN0bF9lbmRpYW5fcChUQVJHRVRfQklHX0VORElBTiwgYm9vdCArIDgsIHRhZ3B0cik7
DQo+Pj4+Pg0KPj4+Pj4gV2h5IGRvbid0IHlvdSBzaW1wbHkgdXNlIHN0bF9wKCkgaGVyZT8N
Cj4+Pj4NCj4+Pj4gV2Ugd2FudCB0byByZW1vdmUgdGhlIHRzd2FwMzIoKSBjYWxscy4uLg0K
Pj4+Pg0KPj4+DQo+Pj4gSSB0aGluayBpcyBwb2ludCBpcyB0aGF0IHlvdSBjb3VsZCBkaXJl
Y3RseSB1c2Ugc3RsX2JlX3AsIGluc3RlYWQgb2YNCj4+PiBzdGxfZW5kaWFuX3AoVEFSR0VU
X0JJVF9FTkRJQU4sIC4uLikuDQo+Pg0KPj4gVEFSR0VUX0JJR19FTkRJQU4gaXMgZGVmaW5l
ZCBhcyAwIG9uIGxpdHRsZSBlbmRpYW4sIGFuZCAxIG9uIGJpZyBvbmUuDQo+Pg0KPj4gVGhl
IGZvbGxvd2luZyBjaGFuZ2UgaXNuJ3Qgd29ydGggaXQ6DQo+Pg0KPj4gICAgICBpZiAoVEFS
R0VUX0JJR19FTkRJQU4pIHsNCj4+ICAgICAgICBzdGxfYmVfcChib290ICsgOCwgdGFncHRy
KTsNCj4+ICAgICAgfSBlbHNlIHsNCj4+ICAgICAgICBzdGxfbGVfcChib290ICsgOCwgdGFn
cHRyKTsNCj4+ICAgICAgfQ0KPj4NCj4+IE1heWJlIEknbSBtaXNzaW5nIFRob21hcyBwb2lu
dCwgYXMgdGhlIHh0ZnBnYSBtYWNoaW5lcyBhcmUgYXZhaWxhYmxlDQo+PiBmb3IgYm90aCB4
dGVuc2Etc29mdG1tdSAoTEUpIGFuZCB4dGVuc2FlYi1zb2Z0bW11IChCRSkuDQo+Pg0KPj4+
IEkgZG9uJ3Qga25vdyBpZiB5b3VyIGludGVudCBpcyB0byBtYWtlIGJlL2xlIHZhcmlhbnQg
InByaXZhdGUiIGFuZA0KPj4+IHJlbGllcyBvbmx5IG9uIGVuZGlhbl9wIHRob3VnaC4NCj4+
DQo+PiBNeSBpbnRlbnQgaXMgdG8gZW5mb3JjZSBlbmRpYW4gYWdub3N0aWMgQVBJIHVzZXMg
d2hlbiBwb3NzaWJsZSwgYW5kDQo+PiB1c2UgTEUvQkUgc3BlY2lmaWMgdmFyaWFudCB3aGVu
IGl0IGlzIGtub3duIGF0IGJ1aWxkIHRpbWUuDQo+IA0KPiBPaCBvaywgaXQncyBtZSB3aG8g
bWlzc2VkIHlvdXIgcG9pbnQgdGhlbi4NCj4gRm9yIHNvbWUgcmVhc29uLCBJIHRob3VnaHQg
d2Ugd2VyZSBhbHdheXMgY2FsbGluZyBiaWcgZW5kaWFuIHZhcmlhbnQuDQo+IA0KPiBUaHVz
LCB5b3VyIGltcGxlbWVudGF0aW9uIG1ha2VzIHRvdGFsbHkgc2Vuc2UuDQo+IA0KPiBMZXQn
cyBzZWUgaWYgVGhvbWFzIG1lYW50IHNvbWV0aGluZyBkaWZmZXJlbnQuDQo+IEVsc2UsDQo+
IFJldmlld2VkLWJ5OiBQaWVycmljayBCb3V2aWVyIDxwaWVycmljay5ib3V2aWVyQGxpbmFy
by5vcmc+DQoNCkxvb2tpbmcgbW9yZSBjbG9zZWx5LA0Kc3RsX3AgaXMgYWxyZWFkeSBjb3Jy
ZWN0bHkgZGVmaW5lZCB3aGVuIHlvdSBrbm93IGF0IGNvbXBpbGUgdGltZSB5b3VyIA0KdGFy
Z2V0IGVuZGlhbm5lc3MuIFNvIFRob21hcyB3YXMgcmVmZXJyaW5nIHRvIHRoaXMuDQoNCmh0
dHBzOi8vZ2l0bGFiLmNvbS9xZW11LXByb2plY3QvcWVtdS8tL2JsYW1lL21hc3Rlci9pbmNs
dWRlL2V4ZWMvY3B1LWFsbC5oP3JlZl90eXBlPWhlYWRzI0w0OQ0K

