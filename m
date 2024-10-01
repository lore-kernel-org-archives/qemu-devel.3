Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BA16CEACE7
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2024 16:48:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svg0S-0005Kh-As; Tue, 01 Oct 2024 12:45:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1svg0N-0004wC-Eg
 for qemu-devel@nongnu.org; Tue, 01 Oct 2024 12:45:44 -0400
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1svg0L-0006xS-IR
 for qemu-devel@nongnu.org; Tue, 01 Oct 2024 12:45:43 -0400
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-2db85775c43so865a91.0
 for <qemu-devel@nongnu.org>; Tue, 01 Oct 2024 09:45:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727801139; x=1728405939; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=lsJSnuAxS8RZSzd2UMiRd3fh62oaT3/DBU+mJRHXMJ4=;
 b=ZSzejztt70B0EfNS51Fg8JYVRARpdXccDiMkO2KlJPEflKPnx9kRb1X2RDPYbJF7h2
 HywYndIS4kxGx0Tuz5GRHp5R/W4SBjgQ05r9kjP46ziTJzWG7nJC3mwvuBMNqO2Q1nuj
 HJslJ5Wd7ZfKwzrFBPVkibIUCgaof4LMxbzJtvB1fLPn8nFxfdV5x60udJPwMUQXF6cE
 qePOVoc9QTMNDtZsFCd2EZyWKaKMT5r2x8kX3gLn4/LsUn25leWWes8YcpvRWUT51i2p
 +DxlezU4P7lF2li9yvXB0pZ//soQDf3fycFqWaE6d03RnytXmPfFYlxYylqgclSdDKiH
 w1+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727801139; x=1728405939;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=lsJSnuAxS8RZSzd2UMiRd3fh62oaT3/DBU+mJRHXMJ4=;
 b=r6bmTysVKyZBf7oajbr2ksS/S4kLj09dUNtQontTIBetwjOaY5yY6hgWY1kDq+FIaZ
 ZExk1NcRn34A2pPDd0UAJ3U78IH1J8SDMR4IPfA/LaM2I4sIGwXDjAfVaInbqJQeRAPp
 1mOrLuQy8D381iG1uLiA+o9gwYwoYJnFrr9RVBOGljqSySwqr/zDH3nRfHMYkETCxgdD
 NYQU5hQZwyMpeWsC1+tzbYcF2SVv6yPxl70/hGGG3i3ScmmLK8pMWZvVWptmFBGO6Iuh
 nniGC9fMVzjAAp/byJfTi7fSMMCHYlelN5ULdhderYSZyWGS5l/2LGpqN0kT9/mZCivx
 dfBQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXdtnjG3xH7paKZAchGByIc+VIRQIF8o5/iyJMJFrR4AO6ZVeEZHfuer5vGAkZmLoTdwxDS+tO2m/4/@nongnu.org
X-Gm-Message-State: AOJu0YylGZ8P4T7zZ/TWWaFiORhSDE3+2g41W+CYVMdIh/ZiYQ8JVRXy
 otSBmL6WN0Z5pPe75ZuyCV7pRG7kxRo2++Bs5pCz8sCdm3/A0SRaGfzXwe7aE98=
X-Google-Smtp-Source: AGHT+IHSIhkgJJstnW58Cn8P2W87djwsAX8GriYroUSpUaUQ5R37whB+UObowCK5XkEqly4EzogcTw==
X-Received: by 2002:a17:90a:bb0c:b0:2c9:90fa:b9f8 with SMTP id
 98e67ed59e1d1-2e185211150mr333309a91.10.1727801139339; 
 Tue, 01 Oct 2024 09:45:39 -0700 (PDT)
Received: from [192.168.1.67] (216-180-64-156.dyn.novuscom.net.
 [216.180.64.156]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2e0b6c50e09sm10393238a91.9.2024.10.01.09.45.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 01 Oct 2024 09:45:38 -0700 (PDT)
Message-ID: <465731e5-36f5-440a-bb4a-3ee0e51a30e2@linaro.org>
Date: Tue, 1 Oct 2024 09:45:36 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/13] qemu/bswap: Introduce ld/st_endian_p() API
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
 <20240930073450.33195-2-philmd@linaro.org>
Content-Language: en-US
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20240930073450.33195-2-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::1034;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x1034.google.com
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

T24gOS8zMC8yNCAwMDozNCwgUGhpbGlwcGUgTWF0aGlldS1EYXVkw6kgd3JvdGU6DQo+IElu
dHJvZHVjZSB0aGUgbGQvc3RfZW5kaWFuX3AoKSBBUEksIHdoaWNoIHRha2VzIGFuIGV4dHJh
DQo+IGJvb2xlYW4gYXJndW1lbnQgdG8gZGlzcGF0Y2ggdG8gbGQvc3Rfe2JlLGxlfV9wKCkg
bWV0aG9kcy4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IFBoaWxpcHBlIE1hdGhpZXUtRGF1ZMOp
IDxwaGlsbWRAbGluYXJvLm9yZz4NCj4gLS0tDQo+IFRPRE86IFVwZGF0ZSBkb2NzdHJpbmcg
cmVnZXhwDQo+IC0tLQ0KPiAgIGluY2x1ZGUvcWVtdS9ic3dhcC5oIHwgMTkgKysrKysrKysr
KysrKysrKysrKw0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAxOSBpbnNlcnRpb25zKCspDQo+IA0K
PiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9xZW11L2Jzd2FwLmggYi9pbmNsdWRlL3FlbXUvYnN3
YXAuaA0KPiBpbmRleCBhZDIyOTEwYTVkLi5lYzgxM2E3NTZkIDEwMDY0NA0KPiAtLS0gYS9p
bmNsdWRlL3FlbXUvYnN3YXAuaA0KPiArKysgYi9pbmNsdWRlL3FlbXUvYnN3YXAuaA0KPiBA
QCAtNDMzLDQgKzQzMywyMyBAQCBET19TVE5fTEROX1AoYmUpDQo+ICAgI3VuZGVmIGxlX2Jz
d2Fwcw0KPiAgICN1bmRlZiBiZV9ic3dhcHMNCj4gICANCj4gKyNkZWZpbmUgbGR1d19lbmRp
YW5fcChiaWdfZW5kaWFuLCBwKSBcDQo+ICsgICAgICAgICAgICAgICAgICAgICAoYmlnX2Vu
ZGlhbikgPyBsZHV3X2JlX3AocCkgOiBsZHV3X2xlX3AocCkNCj4gKyNkZWZpbmUgbGRzd19l
bmRpYW5fcChiaWdfZW5kaWFuLCBwKSBcDQo+ICsgICAgICAgICAgICAgICAgICAgICAoYmln
X2VuZGlhbikgPyBsZHN3X2JlX3AocCkgOiBsZHN3X2JlX3AocCkNCj4gKyNkZWZpbmUgbGRs
X2VuZGlhbl9wKGJpZ19lbmRpYW4sIHApIFwNCj4gKyAgICAgICAgICAgICAgICAgICAgKGJp
Z19lbmRpYW4pID8gbGRsX2JlX3AocCkgOiBsZGxfbGVfcChwKQ0KPiArI2RlZmluZSBsZHFf
ZW5kaWFuX3AoYmlnX2VuZGlhbiwgcCkgXA0KPiArICAgICAgICAgICAgICAgICAgICAoYmln
X2VuZGlhbikgPyBsZHFfYmVfcChwKSA6IGxkcV9sZV9wKHApDQo+ICsjZGVmaW5lIHN0d19l
bmRpYW5fcChiaWdfZW5kaWFuLCBwLCB2KSBcDQo+ICsgICAgICAgICAgICAgICAgICAgIChi
aWdfZW5kaWFuKSA/IHN0d19iZV9wKHAsIHYpIDogc3R3X2xlX3AocCwgdikNCj4gKyNkZWZp
bmUgc3RsX2VuZGlhbl9wKGJpZ19lbmRpYW4sIHAsIHYpIFwNCj4gKyAgICAgICAgICAgICAg
ICAgICAgKGJpZ19lbmRpYW4pID8gc3RsX2JlX3AocCwgdikgOiBzdGxfbGVfcChwLCB2KQ0K
PiArI2RlZmluZSBzdHFfZW5kaWFuX3AoYmlnX2VuZGlhbiwgcCwgdikgXA0KPiArICAgICAg
ICAgICAgICAgICAgICAoYmlnX2VuZGlhbikgPyBzdHFfYmVfcChwLCB2KSA6IHN0cV9sZV9w
KHAsIHYpDQo+ICsjZGVmaW5lIGxkbl9lbmRpYW5fcChiaWdfZW5kaWFuLCBwLCBzeikgXA0K
PiArICAgICAgICAgICAgICAgICAgICAgKGJpZ19lbmRpYW4pID8gbGRuX2JlX3AocCwgc3op
IDogbGRuX2xlX3AocCwgc3opDQo+ICsjZGVmaW5lIHN0bl9lbmRpYW5fcChiaWdfZW5kaWFu
LCBwLCBzeiwgdikgXA0KPiArICAgICAgICAgICAgICAgICAgICAoYmlnX2VuZGlhbikgPyBz
dG5fYmVfcChwLCBzeiwgdikgOiBzdG5fbGVfcChwLCBzeiwgdikNCj4gKw0KPiAgICNlbmRp
ZiAvKiBCU1dBUF9IICovDQoNCk1heSBpdCBiZSB1c2VmdWwgdG8gaGF2ZSBleHRyYSBwYXJl
bnRoZXNpcyBhcm91bmQgbWFjcm8gdmFsdWUgdG8gcHJldmVudCANCmFueSBpc3N1ZSB3aGVu
IHVzaW5nIGl0Pw0KKChiaWdfZW5kaWFuKSA/IHN0bl9iZV9wKHAsIHN6LCB2KSA6IHN0bl9s
ZV9wKHAsIHN6LCB2KSkNCg0KRWxzZSwNClJldmlld2VkLWJ5OiBQaWVycmljayBCb3V2aWVy
IDxwaWVycmljay5ib3V2aWVyQGxpbmFyby5vcmc+DQo=

