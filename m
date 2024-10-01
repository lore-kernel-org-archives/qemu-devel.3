Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BADBCEACE7
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2024 16:54:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svg5p-0006jg-8r; Tue, 01 Oct 2024 12:51:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1svg5S-0006Vr-6r
 for qemu-devel@nongnu.org; Tue, 01 Oct 2024 12:50:58 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1svg5Q-0007Qt-CE
 for qemu-devel@nongnu.org; Tue, 01 Oct 2024 12:50:57 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-20bb92346caso37785ad.0
 for <qemu-devel@nongnu.org>; Tue, 01 Oct 2024 09:50:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727801455; x=1728406255; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=MjsCRjwKwbWJrZPAmtn9mOW+dG68XD+K3d1r1VdPqTM=;
 b=lCg3F2tnRrd8Qw+l4vvt70/sOlZwufhmOjXBTOAnM2SVEPDt/cCjfMbIkOijbyKgiw
 sjws6+0WAOO64Iwb1VsRmK/qk/z5jKrgCQWGgYgRfu+cP2iGqtrsaPoVjlfjR8+xBRqp
 YHAnsNI+2E87r8qxuEJeJh+mRb1TRIDzxWt05X/X7WBOBpGDBAm70CTj9Mkasl6IfEGo
 /NiBOcr1dXvFNAkNUWd7m33DJIdhkhJ/OtX4BmTDD/GdSur2FKZp7cM7WXoFjZTtHZuE
 Pio0I9kE+WEDX1LfypgGtmAMP2wz//rAVZvTPHbAvZwj7GmK+2oQ7G8MHjZxPHUSGZsF
 WsAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727801455; x=1728406255;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=MjsCRjwKwbWJrZPAmtn9mOW+dG68XD+K3d1r1VdPqTM=;
 b=Nq8e1IdjXn4JfJ+BjoSmGM5MpMjyBU+OJ6+kfiBwQgWUvyVUN7QG1u7LzbcBBLCy3K
 H7198JpV7+rbRfJp5z0dnnV91vUIINKmMTWmX7+4hInveCNJ0Qkmki41NJNb12EGWsio
 MlSU1+khNmlpDuzOFlfWsP693rY1ixR6sO1Z6aWEQ/L/p4N1M0wYaasEdjoOTNCBOcqH
 MOfRFF4DV7ISRnFaHAVdq97XgeBVW96SbTEvuNV165Et9IO1OivknG4C9Oe+EvoEeEHX
 Xqgb/g75P9umSgbRFsvrz9RmWb9l+KQiq3vpLcH6WetVcSGY1NfMwA8RQCcWYd6VQWCt
 W/2w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXCmHeJGu6uFjyHemnhqitKbwWe7YP5I60girw+LkF/rgh/wQ7I04SczhvfH1fyb9Qr/DrFh3Ih3qqa@nongnu.org
X-Gm-Message-State: AOJu0YxKYM1Vmz3bKb6Kn8JQkd708r2cKzBTmnivN00Uy8XIuoDpG0/b
 AXhUrJaIUGJabsDX0uFzx5tPLimme+yUtzuA2Nc+zSKei3KC6MkHUoVkUyFXk4I=
X-Google-Smtp-Source: AGHT+IH32s7bEl5N2cWi1wWENI0Ov6yAdQrBVEKK/IeDM2+oaSZ9s/KDcfNBRSLG3ADn/pvKSnuqxw==
X-Received: by 2002:a17:902:f688:b0:206:892c:b758 with SMTP id
 d9443c01a7336-20ba9ed2162mr60636445ad.13.1727801454993; 
 Tue, 01 Oct 2024 09:50:54 -0700 (PDT)
Received: from [192.168.1.67] (216-180-64-156.dyn.novuscom.net.
 [216.180.64.156]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20b37da676fsm71883605ad.108.2024.10.01.09.50.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 01 Oct 2024 09:50:54 -0700 (PDT)
Message-ID: <1daf5428-cbc6-4949-90c9-8aa01f60a9ee@linaro.org>
Date: Tue, 1 Oct 2024 09:50:53 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/13] tests/tcg/plugins: Use the ld/st_endian_p() API
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
 <20240930073450.33195-7-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20240930073450.33195-7-philmd@linaro.org>
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
ZmFjdG9yIHRvIHVzZSB0aGUgcmVjZW50bHkgaW50cm9kdWNlZCBsZC9zdF9lbmRpYW5fcCgp
IEFQSQ0KPiBObyBsb2dpY2FsIGNoYW5nZSBpbnRlbmRlZC4NCj4gDQo+IFNpZ25lZC1vZmYt
Ynk6IFBoaWxpcHBlIE1hdGhpZXUtRGF1ZMOpIDxwaGlsbWRAbGluYXJvLm9yZz4NCj4gLS0t
DQo+ICAgdGVzdHMvdGNnL3BsdWdpbnMvbWVtLmMgfCAyNCArKysrKystLS0tLS0tLS0tLS0t
LS0tLS0NCj4gICAxIGZpbGUgY2hhbmdlZCwgNiBpbnNlcnRpb25zKCspLCAxOCBkZWxldGlv
bnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS90ZXN0cy90Y2cvcGx1Z2lucy9tZW0uYyBiL3Rl
c3RzL3RjZy9wbHVnaW5zL21lbS5jDQo+IGluZGV4IGIwZmE4YTlmMjcuLjM1ODZkMDU1ODcg
MTAwNjQ0DQo+IC0tLSBhL3Rlc3RzL3RjZy9wbHVnaW5zL21lbS5jDQo+ICsrKyBiL3Rlc3Rz
L3RjZy9wbHVnaW5zL21lbS5jDQo+IEBAIC0xNjMsMTMgKzE2Myw5IEBAIHN0YXRpYyB2b2lk
IHVwZGF0ZV9yZWdpb25faW5mbyh1aW50NjRfdCByZWdpb24sIHVpbnQ2NF90IG9mZnNldCwN
Cj4gICAgICAgew0KPiAgICAgICAgICAgdWludDE2X3QgKnAgPSAodWludDE2X3QgKikgJnJp
LT5kYXRhW29mZnNldF07DQo+ICAgICAgICAgICBpZiAoaXNfc3RvcmUpIHsNCj4gLSAgICAg
ICAgICAgIGlmIChiZSkgew0KPiAtICAgICAgICAgICAgICAgIHN0d19iZV9wKHAsIHZhbHVl
LmRhdGEudTE2KTsNCj4gLSAgICAgICAgICAgIH0gZWxzZSB7DQo+IC0gICAgICAgICAgICAg
ICAgc3R3X2xlX3AocCwgdmFsdWUuZGF0YS51MTYpOw0KPiAtICAgICAgICAgICAgfQ0KPiAr
ICAgICAgICAgICAgc3R3X2VuZGlhbl9wKGJlLCBwLCB2YWx1ZS5kYXRhLnUxNik7DQo+ICAg
ICAgICAgICB9IGVsc2Ugew0KPiAtICAgICAgICAgICAgdWludDE2X3QgdmFsID0gYmUgPyBs
ZHV3X2JlX3AocCkgOiBsZHV3X2xlX3AocCk7DQo+ICsgICAgICAgICAgICB1aW50MTZfdCB2
YWwgPSBsZHV3X2VuZGlhbl9wKGJlLCBwKTsNCj4gICAgICAgICAgICAgICB1bnNlZW5fZGF0
YSA9IHZhbCAhPSB2YWx1ZS5kYXRhLnUxNjsNCj4gICAgICAgICAgIH0NCj4gICAgICAgICAg
IGJyZWFrOw0KPiBAQCAtMTc4LDEzICsxNzQsOSBAQCBzdGF0aWMgdm9pZCB1cGRhdGVfcmVn
aW9uX2luZm8odWludDY0X3QgcmVnaW9uLCB1aW50NjRfdCBvZmZzZXQsDQo+ICAgICAgIHsN
Cj4gICAgICAgICAgIHVpbnQzMl90ICpwID0gKHVpbnQzMl90ICopICZyaS0+ZGF0YVtvZmZz
ZXRdOw0KPiAgICAgICAgICAgaWYgKGlzX3N0b3JlKSB7DQo+IC0gICAgICAgICAgICBpZiAo
YmUpIHsNCj4gLSAgICAgICAgICAgICAgICBzdGxfYmVfcChwLCB2YWx1ZS5kYXRhLnUzMik7
DQo+IC0gICAgICAgICAgICB9IGVsc2Ugew0KPiAtICAgICAgICAgICAgICAgIHN0bF9sZV9w
KHAsIHZhbHVlLmRhdGEudTMyKTsNCj4gLSAgICAgICAgICAgIH0NCj4gKyAgICAgICAgICAg
IHN0bF9lbmRpYW5fcChiZSwgcCwgdmFsdWUuZGF0YS51MzIpOw0KPiAgICAgICAgICAgfSBl
bHNlIHsNCj4gLSAgICAgICAgICAgIHVpbnQzMl90IHZhbCA9IGJlID8gbGRsX2JlX3AocCkg
OiBsZGxfbGVfcChwKTsNCj4gKyAgICAgICAgICAgIHVpbnQzMl90IHZhbCA9IGxkbF9lbmRp
YW5fcChiZSwgcCk7DQo+ICAgICAgICAgICAgICAgdW5zZWVuX2RhdGEgPSB2YWwgIT0gdmFs
dWUuZGF0YS51MzI7DQo+ICAgICAgICAgICB9DQo+ICAgICAgICAgICBicmVhazsNCj4gQEAg
LTE5MywxMyArMTg1LDkgQEAgc3RhdGljIHZvaWQgdXBkYXRlX3JlZ2lvbl9pbmZvKHVpbnQ2
NF90IHJlZ2lvbiwgdWludDY0X3Qgb2Zmc2V0LA0KPiAgICAgICB7DQo+ICAgICAgICAgICB1
aW50NjRfdCAqcCA9ICh1aW50NjRfdCAqKSAmcmktPmRhdGFbb2Zmc2V0XTsNCj4gICAgICAg
ICAgIGlmIChpc19zdG9yZSkgew0KPiAtICAgICAgICAgICAgaWYgKGJlKSB7DQo+IC0gICAg
ICAgICAgICAgICAgc3RxX2JlX3AocCwgdmFsdWUuZGF0YS51NjQpOw0KPiAtICAgICAgICAg
ICAgfSBlbHNlIHsNCj4gLSAgICAgICAgICAgICAgICBzdHFfbGVfcChwLCB2YWx1ZS5kYXRh
LnU2NCk7DQo+IC0gICAgICAgICAgICB9DQo+ICsgICAgICAgICAgICBzdHFfZW5kaWFuX3Ao
YmUsIHAsIHZhbHVlLmRhdGEudTY0KTsNCj4gICAgICAgICAgIH0gZWxzZSB7DQo+IC0gICAg
ICAgICAgICB1aW50NjRfdCB2YWwgPSBiZSA/IGxkcV9iZV9wKHApIDogbGRxX2xlX3AocCk7
DQo+ICsgICAgICAgICAgICB1aW50NjRfdCB2YWwgPSBsZHFfZW5kaWFuX3AoYmUsIHApOw0K
PiAgICAgICAgICAgICAgIHVuc2Vlbl9kYXRhID0gdmFsICE9IHZhbHVlLmRhdGEudTY0Ow0K
PiAgICAgICAgICAgfQ0KPiAgICAgICAgICAgYnJlYWs7DQoNClJldmlld2VkLWJ5OiBQaWVy
cmljayBCb3V2aWVyIDxwaWVycmljay5ib3V2aWVyQGxpbmFyby5vcmc+DQo=

