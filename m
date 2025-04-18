Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DB4CC369C2
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Apr 2025 02:54:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u5br5-0007A6-O5; Thu, 17 Apr 2025 22:53:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u5br3-00079X-Jr
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 22:53:25 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u5br1-000849-D1
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 22:53:25 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-739b3fe7ce8so1351396b3a.0
 for <qemu-devel@nongnu.org>; Thu, 17 Apr 2025 19:53:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744944801; x=1745549601; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=CmN8ODSf2l/vao7gZkwOIQrPU/Wqb0fF8TtdpzfR1Xw=;
 b=COzLqhoQNZiYyO3U9MOlIrksxt0q5VgXcuo0t1T8kwGi1eEM54+PaBCCOFAAwAavwg
 yTAxdWGzCyH+9upRSWg33sVo2h3egoEp++ykIjq/q9f47plCkXOd4oV45spT2jhwRF2u
 g0fm2a+5dlIJE40ub/f1RvgXoWa+qllebycVvuiBh01nmH1fV098nr8Xo47yaj4G1JDr
 0LUUXUv5xqb3LGy40z5ehOWGUsmGw7ly/od/0QIH5xikkNFa+NTbPTxRFupEwfRJgg8E
 NIwMmjgGeDCMZAVAq6WxcoyDY0AmlArGLPhVmpZOwgT/dVtWGmM13jjRgUv1j+SmlcP4
 D3TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744944801; x=1745549601;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=CmN8ODSf2l/vao7gZkwOIQrPU/Wqb0fF8TtdpzfR1Xw=;
 b=qeggJ2uZWDvIgZS1P1FtfoToNjNgigqtdiNbLqVZL+P42LNAwsxN/RrDVDtErbiY2d
 GqZrZMXChh2uu0uFROFmVAQf38JnquuuD7wReSnkSE761NdlEsewfLvumuSZRdTLgI40
 OMFnO737z8VYIjMoZRyfRquQjESwpuvBwUutPcBZTWkjYiniWOR4ZEajE5/i0PK1VycP
 /lgbJ4M4XJ5W7anHfquhIcFcjHQM43qrYDUFQQavDjCZzymFFNKwwNZedp+7yUpFu8Vl
 g5D2seEA5P821AssHFMFmN9lGavz9iguBEYNHr5aJbYOvupFtbETHZFxrRb59KvLpp7h
 NuXQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXbxTV0vTTjBbzCj4CyFIxfaJ1CoURX0YAYihwJA1ZrNHTyDtg+61IE6OwXIUKS93b/4LslVTN5J3mb@nongnu.org
X-Gm-Message-State: AOJu0YzsE0lhQdaJ/zUTEaZsI9NsPbpUMfZn/1O43pJweETYuhWiOr6Q
 T9a63JZZEXY7/5Zw+8yPPG4ztOQTUe6QKZ+FUEh9Ms0d5L2nGk2u5JPoq2jFCDo=
X-Gm-Gg: ASbGncsFGOgiTLMoXLxQfh4J2aFMFdUPmI3d/5TbhrensEJTHcSmon/BGF5EaP6J2No
 vja0lmGrUyreFqhLc02e0oXAj0ISpBo5QWDUeeLA78hbOjrYIMelxnD4Jbv7yS7YBKfCzSS68Yu
 pEJlGB0s7hEYAPqAwRUBE68WZAjrVyyWoMkSqqV7Qd1CTAyXdUEpqru7Asg1NIKFrpDkTB2WdqZ
 uI5WM4Q3GMhW1bBb4xnVMH5PGGZ7ektOsEhCII0V4jVoQOfZ32bbxB7BDm2VsvxJXqP6WjwG929
 n8Bbum2xvjPbkz0jnwiYxxiDeFhMO9PS4pHXwU/kM6KEixh9hUUuQJIDIhyS/Snd
X-Google-Smtp-Source: AGHT+IHCECl7/GVf8a7AZ2QthylopVXuy6YN0mNjjAxS13Bg8XEj8yUiw+nCFWlQa5Cksq0YS2VHUg==
X-Received: by 2002:a05:6a00:21c4:b0:736:ab48:5b0 with SMTP id
 d2e1a72fcca58-73dc147c2a5mr1457508b3a.2.1744944801182; 
 Thu, 17 Apr 2025 19:53:21 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73dbfae9e77sm623362b3a.160.2025.04.17.19.53.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 17 Apr 2025 19:53:20 -0700 (PDT)
Message-ID: <29beabe0-15ed-4af3-87f3-c3a32bf44dc1@linaro.org>
Date: Thu, 17 Apr 2025 19:53:19 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/11] hw/arm: Define machines as generic QOM types
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Andrey Smirnov <andrew.smirnov@gmail.com>,
 Antony Pavlov <antonynpavlov@gmail.com>, Zhao Liu <zhao1.liu@intel.com>,
 Beniamino Galvani <b.galvani@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Niek Linnenbank <nieklinnenbank@gmail.com>, qemu-arm@nongnu.org,
 Jean-Christophe Dubois <jcd@tribudubois.net>, Felipe Balbi
 <balbi@kernel.org>, Bernhard Beschow <shentey@gmail.com>,
 Strahinja Jankovic <strahinja.p.jankovic@gmail.com>,
 Jan Kiszka <jan.kiszka@web.de>, Alistair Francis <alistair@alistair23.me>,
 Subbaraya Sundeep <sundeep.lkml@gmail.com>,
 Alexandre Iooss <erdnaxe@crans.org>, Peter Maydell
 <peter.maydell@linaro.org>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>
References: <20250417235814.98677-1-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Content-Language: en-US
In-Reply-To: <20250417235814.98677-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x435.google.com
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

T24gNC8xNy8yNSAxNjo1OCwgUGhpbGlwcGUgTWF0aGlldS1EYXVkw6kgd3JvdGU6DQo+IFdo
aWxlIERFRklORV9NQUNISU5FKCkgaXMgYSBzdWNjaW5jdCBtYWNybywgaXQgZG9lc24ndA0K
PiBhbGxvdyByZWdpc3RlcmluZyBRT00gaW50ZXJmYWNlcyB0byB0aGUgZGVmaW5lZCBtYWNo
aW5lLg0KPiBDb252ZXJ0IHRvIHRoZSBnZW5lcmljIERFRklORV9UWVBFUygpIGluIHByZXBh
cmF0aW9uIHRvDQo+IHJlZ2lzdGVyIGludGVyZmFjZXMuDQo+IA0KPiBQaGlsaXBwZSBNYXRo
aWV1LURhdWTDqSAoMTEpOg0KPiAgICBody9jb3JlL251bGwtbWFjaGluZTogRGVmaW5lIG1h
Y2hpbmUgYXMgZ2VuZXJpYyBRT00gdHlwZQ0KPiAgICBody9hcm0vYmFuYW5hcGk6IERlZmlu
ZSBtYWNoaW5lIGFzIGdlbmVyaWMgUU9NIHR5cGUNCj4gICAgaHcvYXJtL2N1YmllYm9hcmQ6
IERlZmluZSBtYWNoaW5lIGFzIGdlbmVyaWMgUU9NIHR5cGUNCj4gICAgaHcvYXJtL2RpZ2lj
OiBEZWZpbmUgbWFjaGluZSBhcyBnZW5lcmljIFFPTSB0eXBlDQo+ICAgIGh3L2FybS9pbXg6
IERlZmluZSBtYWNoaW5lcyBhcyBnZW5lcmljIFFPTSB0eXBlcw0KPiAgICBody9hcm0vaW50
ZWdyYXRvcmNwOiBEZWZpbmUgbWFjaGluZSBhcyBnZW5lcmljIFFPTSB0eXBlDQo+ICAgIGh3
L2FybS9rem06IERlZmluZSBtYWNoaW5lIGFzIGdlbmVyaWMgUU9NIHR5cGUNCj4gICAgaHcv
YXJtL21zZjI6IERlZmluZSBtYWNoaW5lIGFzIGdlbmVyaWMgUU9NIHR5cGUNCj4gICAgaHcv
YXJtL211c2ljcGFsOiBEZWZpbmUgbWFjaGluZSBhcyBnZW5lcmljIFFPTSB0eXBlDQo+ICAg
IGh3L2FybS9vcmFuZ2VwaTogRGVmaW5lIG1hY2hpbmUgYXMgZ2VuZXJpYyBRT00gdHlwZQ0K
PiAgICBody9hcm0vc3RtMzI6IERlZmluZSBtYWNoaW5lcyBhcyBnZW5lcmljIFFPTSB0eXBl
cw0KPiANCj4gICBody9hcm0vYmFuYW5hcGlfbTJ1LmMgICAgICB8IDEzICsrKysrKysrKysr
LS0NCj4gICBody9hcm0vY3ViaWVib2FyZC5jICAgICAgICB8IDEzICsrKysrKysrKysrLS0N
Cj4gICBody9hcm0vZGlnaWNfYm9hcmRzLmMgICAgICB8IDE0ICsrKysrKysrKysrKy0tDQo+
ICAgaHcvYXJtL2lteDI1X3Bkay5jICAgICAgICAgfCAxNCArKysrKysrKysrKystLQ0KPiAg
IGh3L2FybS9pbXg4bXAtZXZrLmMgICAgICAgIHwgMTUgKysrKysrKysrKysrKy0tDQo+ICAg
aHcvYXJtL2ludGVncmF0b3JjcC5jICAgICAgfCAxNiArKysrKysrKysrKysrLS0tDQo+ICAg
aHcvYXJtL2t6bS5jICAgICAgICAgICAgICAgfCAxNCArKysrKysrKysrKystLQ0KPiAgIGh3
L2FybS9tY2lteDZ1bC1ldmsuYyAgICAgIHwgMTUgKysrKysrKysrKysrKy0tDQo+ICAgaHcv
YXJtL21jaW14N2Qtc2FicmUuYyAgICAgfCAxNSArKysrKysrKysrKysrLS0NCj4gICBody9h
cm0vbXNmMi1zb20uYyAgICAgICAgICB8IDEzICsrKysrKysrKysrLS0NCj4gICBody9hcm0v
bXVzaWNwYWwuYyAgICAgICAgICB8IDE2ICsrKysrKysrKysrKystLS0NCj4gICBody9hcm0v
bmV0ZHVpbm8yLmMgICAgICAgICB8IDEzICsrKysrKysrKysrLS0NCj4gICBody9hcm0vbmV0
ZHVpbm9wbHVzMi5jICAgICB8IDEzICsrKysrKysrKysrLS0NCj4gICBody9hcm0vb2xpbWV4
LXN0bTMyLWg0MDUuYyB8IDEzICsrKysrKysrKysrLS0NCj4gICBody9hcm0vb3JhbmdlcGku
YyAgICAgICAgICB8IDEzICsrKysrKysrKysrLS0NCj4gICBody9hcm0vc2FicmVsaXRlLmMg
ICAgICAgICB8IDE0ICsrKysrKysrKysrKy0tDQo+ICAgaHcvYXJtL3N0bTMydmxkaXNjb3Zl
cnkuYyAgfCAxMyArKysrKysrKysrKy0tDQo+ICAgaHcvY29yZS9udWxsLW1hY2hpbmUuYyAg
ICAgfCAxNCArKysrKysrKysrKystLQ0KPiAgIDE4IGZpbGVzIGNoYW5nZWQsIDIxMyBpbnNl
cnRpb25zKCspLCAzOCBkZWxldGlvbnMoLSkNCj4gDQoNClNvdW5kcyBnb29kLCBmb3IgdGhl
IHdob2xlIHNlcmllczoNClJldmlld2VkLWJ5OiBQaWVycmljayBCb3V2aWVyIDxwaWVycmlj
ay5ib3V2aWVyQGxpbmFyby5vcmc+DQoNCg==

