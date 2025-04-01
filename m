Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76B67C36010
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Apr 2025 14:33:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzcfz-00017g-Af; Tue, 01 Apr 2025 10:33:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tzcfw-0000zQ-SY
 for qemu-devel@nongnu.org; Tue, 01 Apr 2025 10:33:13 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tzcfv-00062Y-5J
 for qemu-devel@nongnu.org; Tue, 01 Apr 2025 10:33:12 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-227a8cdd241so21051135ad.3
 for <qemu-devel@nongnu.org>; Tue, 01 Apr 2025 07:33:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743517989; x=1744122789; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=/FhEiulSE9fCr21joZY5tEY58o/bf+b9NBGYeDAvy/k=;
 b=vtHA9DbJLJVHdU9y8fw1VYZjodmEWQrxSyxGJ3ccZnMG3R2CfqfrM7VRpV3KCKP1zI
 8wxz3V9T2vn2/UsvVFiPET2regNda6VHw8hDlMBoiLuT6DtGe8Uj3b7942dL3ceiFu8F
 wfaSZzip0QjJ/xg2i2kr1WmRlG+p+3d0pCgh96ywSH8KL3HI+orBkeGTH4OCAtjHHUEt
 +R0IJq99BDKhqogjLrw7YwIO8JBTcsXsin+pT/QqYxJOa9rUOM9bHp8WroNZ3dUIVjlc
 T1MP8fUZT0Pn1sTUUXVJFgxUrZP+/oSJeBRhPlgBmOOShBtt8R8xi1rDLUt5W5D6tDwl
 cygw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743517989; x=1744122789;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/FhEiulSE9fCr21joZY5tEY58o/bf+b9NBGYeDAvy/k=;
 b=SuCJ/yoZDtD/aY6Yd5MPyxYNzW/349glecB5Cm7tDUlba1Xaym4K6wJRZLPoN48Njw
 AGD/HMQhEknd0lK/Sl9wK10rDWYaczbcXcdQJoK/HeyJO0gozCYJfii5bJnpID8Gw3P9
 aBFLUnx2LNZEgEmXicMZaricp0heC6iCs7PpTxCZSVgfPNwdtnX90Ut+HpjyABszWbeg
 H/7PegXRhCv/0KGnuFhZhEku7Tj0D6hPYEufmKNmPYEu9Ej2VV0Q4cUDQi7VbtcL99zE
 NtaSYWH/HNR2IpJPFEirIhYYZuVhqWbG8huqZPaxF8O2+Ns2MMsxDyoAO2kgXAVPTbZY
 KZiQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU75jJAEf5Ol3faLxBcYebgGmusLoP6jtr0/Cn+CDB98Liu55OlE2rkMi73mNIDx2mX4QMgPVo/dPlM@nongnu.org
X-Gm-Message-State: AOJu0Yy2/C7TBGovTq4oBLbDLZNK+74YzQbh7GQ3ShOrqq7b0Oq88Yj0
 I7Rgv20JgFFIRJC2pGvJ0UqEBvwic1hbiS4RGTvwWr8c/Tlk1/E+/LVolHWANYE=
X-Gm-Gg: ASbGncuqlcnSVWUdEzmYrzf7susFTg90tPLmVxolck5dyggPVKpWN3S8bUXnZS7aLKF
 BsChZQ0xgazTXwU4ghmujPfkHnGRKGnBa/PIHnMCot8ZQl/X6NQdQqB6piHnVTALMUEFS+s+cxJ
 TFWVELvT+pIFFjEO8vE2KRd5YhRflga+OJSJOk4qutVT7alCp2pNNufvt6v6SDG9jTKM3Hx+0Bf
 SZF//TFq+EfEjcWVm0oOJqFx24lL+Sx2w4lwi+H5k3kgN/EjzIUpaJ114da1VTK7sr6hIQlQbXM
 kRRWhS7BbwjWdiiPyOgwOicbR4Ae3Ve8FVS1fYwiUG8p8GN4LVN5YaFelw==
X-Google-Smtp-Source: AGHT+IGq80yUjpMfT5SXD3+LIf++VeHsPeYyHY79jTS566ZBI1Tj1Cm4IIdChuqqMMn7xc62qQzxQQ==
X-Received: by 2002:a17:902:fc50:b0:215:9642:4d7a with SMTP id
 d9443c01a7336-2292f89209emr219608425ad.0.1743517989341; 
 Tue, 01 Apr 2025 07:33:09 -0700 (PDT)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2291f1ded6asm89229825ad.184.2025.04.01.07.33.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 01 Apr 2025 07:33:08 -0700 (PDT)
Message-ID: <c474f845-3d3b-4060-94c2-0d7b5f044d82@linaro.org>
Date: Tue, 1 Apr 2025 07:33:08 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] bsd-user: add option to enable plugins
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>, richard.henderson@linaro.org,
 alex.bennee@linaro.org, Kyle Evans <kevans@freebsd.org>
References: <20250331234228.3475706-1-pierrick.bouvier@linaro.org>
 <a2907212-feef-407f-bc2d-03667aaae174@linaro.org>
Content-Language: en-US
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <a2907212-feef-407f-bc2d-03667aaae174@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x633.google.com
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

T24gMy8zMS8yNSAyMzoxNSwgUGhpbGlwcGUgTWF0aGlldS1EYXVkw6kgd3JvdGU6DQo+IEhp
IFBpZXJyaWNrLA0KPiANCj4gT24gMS80LzI1IDAxOjQyLCBQaWVycmljayBCb3V2aWVyIHdy
b3RlOg0KPj4gTm90aGluZyBwcmV2ZW50IHBsdWdpbnMgdG8gYmUgZW5hYmxlZCBvbiB0aGlz
IHBsYXRmb3JtIGZvciB1c2VyDQo+PiBiaW5hcmllcywgb25seSB0aGUgb3B0aW9uIGluIHRo
ZSBkcml2ZXIgaXMgbWlzc2luZy4NCj4gDQo+IFBlciBjb21taXQgOTAzZTg3MGYyNDUgKCJw
bHVnaW5zL2FwaTogc3BsaXQgb3V0IGJpbmFyeQ0KPiBwYXRoL3N0YXJ0L2VuZC9lbnRyeSBj
b2RlIikgdGhpcyBpcyBkZWxpYmVyYXRlOg0KPiANCj4gICAgICAgVGhlIEJTRCB1c2VyLW1v
ZGUgY29tbWFuZCBsaW5lIGlzIHN0aWxsIG1pc3NpbmcgLXBsdWdpbi4NCj4gICAgICAgVGhp
cyBjYW4gYmUgZW5hYmxlZCBvbmNlIHdlIGhhdmUgcmVsaWFibGUgY2hlY2stdGNnIHRlc3Rz
DQo+ICAgICAgIHdvcmtpbmcgZm9yIHRoZSBCU0RzLg0KPiANCj4gU2hvdWxkIHdlIGVuYWJs
ZSB0aGlzIHdpdGhvdXQgdGVzdCBoYXJuZXNzaW5nPw0KPiANCg0KVGhhbmtzIGZvciBwb2lu
dGluZyB0aGlzLg0KDQpIb3dldmVyLCBJIGRvbid0IGdldCB0aGUgYXJndW1lbnQsIGFzIHRo
ZSBzYW1lIGNvdWxkIGJlIHNhaWQgYWJvdXQgDQpzeXN0ZW0gbW9kZSwgd2hpY2ggcnVucyBv
biBCU0QgYWxzbywgYW5kIGFscmVhZHkgaGFzIHBsdWdpbnMgZW5hYmxlZC4NClRoZSBjb3Vw
bGluZyBiZXR3ZWVuIHVzZXIgcmVsYXRlZCBjb2RlIGFuZCBwbHVnaW5zIGlzIHZlcnkgbG93
IChqdXN0IA0Kb3B0aW9ucyBwYXJzaW5nIGFuZCBpbml0IGNvZGUpLCBzbyBJIGRvbid0IHNl
ZSB3aHkgd2UgY291bGQgaGF2ZSBhIGJ1ZyANCnJlbGF0ZWQgdG8gYSBzcGVjaWZpYyBwbGF0
Zm9ybSBvbmx5IGZvciB1c2VyIGJpbmFyaWVzLg0KDQpTbyBlaXRoZXIgd2UgZGVhY3RpdmF0
ZSBwbHVnaW5zIGNvbXBsZXRlbHkgZm9yIGJzZCBiaW5hcmllcywgb3Igd2UgdGFrZSANCmEg
bGVhcCBvZiBmYWl0aCB0aGF0IGl0IHdvcmtzIGZvciB0aGVtLg0KDQpAQWxleCwgYW55IGZ1
cnRoZXIgaW5zaWdodCBvbiB0aGlzPw0KDQo+PiBTaWduZWQtb2ZmLWJ5OiBQaWVycmljayBC
b3V2aWVyIDxwaWVycmljay5ib3V2aWVyQGxpbmFyby5vcmc+DQo+PiAtLS0NCj4+ICAgIGJz
ZC11c2VyL21haW4uYyB8IDEyICsrKysrKysrKysrKw0KPj4gICAgMSBmaWxlIGNoYW5nZWQs
IDEyIGluc2VydGlvbnMoKykNCj4gDQo+IElkZWFsbHkgd2UnZCBoYXZlIGhlbHBlcnMgZm9y
IGNvbW1vbiB1c2VyIGNvZGUgaW4gY29tbW9uLXVzZXIvLi4uDQo+IA0KDQpFdmVyeXRoaW5n
IGlzIGFscmVhZHkgY29tbW9uIGZvciBwbHVnaW5zLCBleGNlcHQgYWRkaW5nIHRoZSBjYWxs
IHRvIA0KcGx1Z2luIGNvbW1hbmQgbGluZSBvcHRpb24gcGFyc2luZyBmdW5jdGlvbi4NCg0K
PiBBbnl3YXksIHNpbmNlIHRoaXMgcGF0Y2ggZG9lcyB3aGF0IGl0IHNheXM6DQo+IFJldmll
d2VkLWJ5OiBQaGlsaXBwZSBNYXRoaWV1LURhdWTDqSA8cGhpbG1kQGxpbmFyby5vcmc+DQo+
IA0KDQpUaGFua3MsDQpQaWVycmljaw0KDQo=

