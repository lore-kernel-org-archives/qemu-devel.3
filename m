Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E82CECEACEB
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2024 16:55:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svg6X-0007s0-KS; Tue, 01 Oct 2024 12:52:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1svg6H-0007bC-Jv
 for qemu-devel@nongnu.org; Tue, 01 Oct 2024 12:51:50 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1svg6E-0007TD-SO
 for qemu-devel@nongnu.org; Tue, 01 Oct 2024 12:51:49 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-71b070ff24dso5152015b3a.2
 for <qemu-devel@nongnu.org>; Tue, 01 Oct 2024 09:51:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727801505; x=1728406305; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ZxUb89UEgr8+F/1ANN0knUMlzDPHNk6lVEUfsVPaNHU=;
 b=UYGqtQjA1/ONsHMwn6Cwf4q++uZRY1ISHzoZoUzZQL114dDgbaNcqzndIOXeXK7J8S
 DbBgS2qiktgQHGARA6G3Roo01ovtpS4EnP3JOAcEEuVzhVTmsh6uY4XZDwmFtG+CfwYC
 GYe5yTuJSWGDQ8VuBm+TYRPrbpChcctt+zNir8ubi8YjPDpM5FtlnTESNtlucpZmCSAq
 fxUXAbOImOa38zq0zDGel7zsam082GnFmNjXhGEJsKnWTuum/wffUQoT+0aPcd9c/+DT
 fMKpK2LYert+4/Lf0OL+vfZu1I1HG8PavxGE9mQHtH2dmXrKhKxN7ryuE7xPR8fiayXq
 pZlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727801505; x=1728406305;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ZxUb89UEgr8+F/1ANN0knUMlzDPHNk6lVEUfsVPaNHU=;
 b=JqOKb4pq2bqT/vP/SyTzX5b0y4m74nu9piFkE55aY+M/O+QjU+ds3Ng7ww/AUxI9T2
 /2KVqvbHMKQZ8y4MuJ6k17HiizcqVJcAOTnSnPKMua2/DSj//3qekoHI8W1biWZZ/C9f
 uYmg5MuVB5CHNsi7tF3hFQbiiLLp2TbGcmKAY8/BSb9QU/ykdyo3trw9SSmIoe5ofEwX
 VnQ9+s/tBJQR4VIiU8zzw4QocOFcIoUHcpSyKzmuchBscVYMQ7zdZs2zjZ5luTKWWlXj
 ClorpTmZTLQWk42SH28IOerwbnv5UwzTAoj7n3wHA2jwKj789h2k1h2hfrljo1OF3X27
 IhBg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUVBJkNOEz6EX1yGt5JcI1U13D9JuIqnAOMngRkDZ63afmMutybbfEY/q7x93QooamW+uemkW5mFepQ@nongnu.org
X-Gm-Message-State: AOJu0YwNv9nT7xjQ29pJISrmCt3pGxFubjt4f+sFaDrdSJw6ZfENCX+E
 P6LK3FjEbgq19NFYsk3oHLAYvGp3TZ1ahT0TDi2hl3gtiUYd1TmA9HDpwlAsByE=
X-Google-Smtp-Source: AGHT+IE0u/7UpIos2pzVBMUPBWrD2NqnZOScTdbEDnrAvQYCqJPBAav3DpG0faFn14HOSZZgNV8PDA==
X-Received: by 2002:a05:6a21:1796:b0:1cf:42ab:5776 with SMTP id
 adf61e73a8af0-1d5e2cb144cmr560017637.32.1727801505455; 
 Tue, 01 Oct 2024 09:51:45 -0700 (PDT)
Received: from [192.168.1.67] (216-180-64-156.dyn.novuscom.net.
 [216.180.64.156]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71b265160c8sm8220739b3a.126.2024.10.01.09.51.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 01 Oct 2024 09:51:45 -0700 (PDT)
Message-ID: <450bccc8-262a-4ecb-aba1-5a7054aa7ed7@linaro.org>
Date: Tue, 1 Oct 2024 09:51:44 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/13] hw/xtensa/xtfpga: Remove TARGET_BIG_ENDIAN #ifdef'ry
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
 <20240930073450.33195-8-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20240930073450.33195-8-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x433.google.com
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

T24gOS8zMC8yNCAwMDozNCwgUGhpbGlwcGUgTWF0aGlldS1EYXVkw6kgd3JvdGU6DQo+IE1v
dmUgY29kZSBldmFsdWF0aW9uIGZyb20gcHJlcHJvY2Vzc29yIHRvIGNvbXBpbGVyIHNvDQo+
IGJvdGggaWYoKSBsYWRkZXJzIGFyZSBwcm9jZXNzZWQuIE1vc3RseSBzdHlsZSBjaGFuZ2Uu
DQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBQaGlsaXBwZSBNYXRoaWV1LURhdWTDqSA8cGhpbG1k
QGxpbmFyby5vcmc+DQo+IC0tLQ0KPiAgIGh3L3h0ZW5zYS94dGZwZ2EuYyB8IDEyICsrKysr
KystLS0tLQ0KPiAgIDEgZmlsZSBjaGFuZ2VkLCA3IGluc2VydGlvbnMoKyksIDUgZGVsZXRp
b25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvaHcveHRlbnNhL3h0ZnBnYS5jIGIvaHcveHRl
bnNhL3h0ZnBnYS5jDQo+IGluZGV4IDk1NWU4ODY3YTMuLjIyOGYwMGIwNDUgMTAwNjQ0DQo+
IC0tLSBhL2h3L3h0ZW5zYS94dGZwZ2EuYw0KPiArKysgYi9ody94dGVuc2EveHRmcGdhLmMN
Cj4gQEAgLTQxNSw4ICs0MTUsNyBAQCBzdGF0aWMgdm9pZCB4dGZwZ2FfaW5pdChjb25zdCBY
dGZwZ2FCb2FyZERlc2MgKmJvYXJkLCBNYWNoaW5lU3RhdGUgKm1hY2hpbmUpDQo+ICAgICAg
ICAgICAgICAgfQ0KPiAgICAgICAgICAgfQ0KPiAgICAgICAgICAgaWYgKGVudHJ5X3BvaW50
ICE9IGVudi0+cGMpIHsNCj4gLSAgICAgICAgICAgIHVpbnQ4X3QgYm9vdFtdID0gew0KPiAt
I2lmIFRBUkdFVF9CSUdfRU5ESUFODQo+ICsgICAgICAgICAgICB1aW50OF90IGJvb3RfYmVb
XSA9IHsNCj4gICAgICAgICAgICAgICAgICAgMHg2MCwgMHgwMCwgMHgwOCwgICAgICAgLyog
aiAgICAxZiAqLw0KPiAgICAgICAgICAgICAgICAgICAweDAwLCAgICAgICAgICAgICAgICAg
ICAvKiAubGl0ZXJhbF9wb3NpdGlvbiAqLw0KPiAgICAgICAgICAgICAgICAgICAweDAwLCAw
eDAwLCAweDAwLCAweDAwLCAvKiAubGl0ZXJhbCBlbnRyeV9wYyAqLw0KPiBAQCAtNDI1LDcg
KzQyNCw4IEBAIHN0YXRpYyB2b2lkIHh0ZnBnYV9pbml0KGNvbnN0IFh0ZnBnYUJvYXJkRGVz
YyAqYm9hcmQsIE1hY2hpbmVTdGF0ZSAqbWFjaGluZSkNCj4gICAgICAgICAgICAgICAgICAg
MHgxMCwgMHhmZiwgMHhmZSwgICAgICAgLyogbDMyciBhMCwgZW50cnlfcGMgKi8NCj4gICAg
ICAgICAgICAgICAgICAgMHgxMiwgMHhmZiwgMHhmZSwgICAgICAgLyogbDMyciBhMiwgZW50
cnlfYTIgKi8NCj4gICAgICAgICAgICAgICAgICAgMHgwYSwgMHgwMCwgMHgwMCwgICAgICAg
LyoganggICBhMCAqLw0KPiAtI2Vsc2UNCj4gKyAgICAgICAgICAgIH07DQo+ICsgICAgICAg
ICAgICB1aW50OF90IGJvb3RfbGVbXSA9IHsNCj4gICAgICAgICAgICAgICAgICAgMHgwNiwg
MHgwMiwgMHgwMCwgICAgICAgLyogaiAgICAxZiAqLw0KPiAgICAgICAgICAgICAgICAgICAw
eDAwLCAgICAgICAgICAgICAgICAgICAvKiAubGl0ZXJhbF9wb3NpdGlvbiAqLw0KPiAgICAg
ICAgICAgICAgICAgICAweDAwLCAweDAwLCAweDAwLCAweDAwLCAvKiAubGl0ZXJhbCBlbnRy
eV9wYyAqLw0KPiBAQCAtNDM0LDE0ICs0MzQsMTYgQEAgc3RhdGljIHZvaWQgeHRmcGdhX2lu
aXQoY29uc3QgWHRmcGdhQm9hcmREZXNjICpib2FyZCwgTWFjaGluZVN0YXRlICptYWNoaW5l
KQ0KPiAgICAgICAgICAgICAgICAgICAweDAxLCAweGZlLCAweGZmLCAgICAgICAvKiBsMzJy
IGEwLCBlbnRyeV9wYyAqLw0KPiAgICAgICAgICAgICAgICAgICAweDIxLCAweGZlLCAweGZm
LCAgICAgICAvKiBsMzJyIGEyLCBlbnRyeV9hMiAqLw0KPiAgICAgICAgICAgICAgICAgICAw
eGEwLCAweDAwLCAweDAwLCAgICAgICAvKiBqeCAgIGEwICovDQo+IC0jZW5kaWYNCj4gICAg
ICAgICAgICAgICB9Ow0KPiArICAgICAgICAgICAgY29uc3Qgc2l6ZV90IGJvb3Rfc3ogPSBU
QVJHRVRfQklHX0VORElBTiA/IHNpemVvZihib290X2JlKQ0KPiArICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA6IHNpemVvZihib290X2xl
KTsNCj4gKyAgICAgICAgICAgIHVpbnQ4X3QgKmJvb3QgPSBUQVJHRVRfQklHX0VORElBTiA/
IGJvb3RfYmUgOiBib290X2xlOw0KPiAgICAgICAgICAgICAgIHVpbnQzMl90IGVudHJ5X3Bj
ID0gdHN3YXAzMihlbnRyeV9wb2ludCk7DQo+ICAgICAgICAgICAgICAgdWludDMyX3QgZW50
cnlfYTIgPSB0c3dhcDMyKHRhZ3B0cik7DQo+ICAgDQo+ICAgICAgICAgICAgICAgbWVtY3B5
KGJvb3QgKyA0LCAmZW50cnlfcGMsIHNpemVvZihlbnRyeV9wYykpOw0KPiAgICAgICAgICAg
ICAgIG1lbWNweShib290ICsgOCwgJmVudHJ5X2EyLCBzaXplb2YoZW50cnlfYTIpKTsNCj4g
LSAgICAgICAgICAgIGNwdV9waHlzaWNhbF9tZW1vcnlfd3JpdGUoZW52LT5wYywgYm9vdCwg
c2l6ZW9mKGJvb3QpKTsNCj4gKyAgICAgICAgICAgIGNwdV9waHlzaWNhbF9tZW1vcnlfd3Jp
dGUoZW52LT5wYywgYm9vdCwgYm9vdF9zeik7DQo+ICAgICAgICAgICB9DQo+ICAgICAgIH0g
ZWxzZSB7DQo+ICAgICAgICAgICBpZiAoZmxhc2gpIHsNCg0KUmV2aWV3ZWQtYnk6IFBpZXJy
aWNrIEJvdXZpZXIgPHBpZXJyaWNrLmJvdXZpZXJAbGluYXJvLm9yZz4NCg==

