Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A4B0D6E2CA
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2024 06:26:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tDe9t-0001ip-LG; Wed, 20 Nov 2024 01:25:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tDe9m-0001iA-VU
 for qemu-devel@nongnu.org; Wed, 20 Nov 2024 01:25:42 -0500
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tDe9k-0006kC-Pw
 for qemu-devel@nongnu.org; Wed, 20 Nov 2024 01:25:42 -0500
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-7f71f2b136eso1360266a12.1
 for <qemu-devel@nongnu.org>; Tue, 19 Nov 2024 22:25:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732083939; x=1732688739; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=yuWBS6YqEeMC3xFYs0OrjJ6rnaAaoyyJXmzYyV9zP7U=;
 b=liM5HFbyP7wtdDBUlIrqouEMMEjHuV5xUjKKIbWwt6RYNbUkEJ1oSxgDDZMfsAPySA
 F7ixJ/gmE4peebDCfkUUEQWaAf5dSpVMeRLI5nnHWixpk/SfrbDwjPo++iGrsGfldCti
 RkmjFcpKOt04ZjsQZloDSqYZS4U/lFZTKqS3gEzylwCGfzCGl/uJpc9vuyG87kh204yE
 wpC0rmyfP3Ngqqfum1Tnj4+KKHjSpRtoEQZT/1UX9zjIh9CBpmGvzOHbZAsoboMeDYa6
 AQ3qdgYMcfjtCwEkoG2yBLxZX/EyNllHnhX6HafaYh5LSM0asxaLl4h8MZny89MBbQm+
 nq0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732083939; x=1732688739;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=yuWBS6YqEeMC3xFYs0OrjJ6rnaAaoyyJXmzYyV9zP7U=;
 b=hsMFTrrHKAj6P25sI6HmqU8ghGTdn3fgBMzfqo7wHXD0CjZ+BmLIYeL7ZzmKJJ2Civ
 FILnEpPg+/+1y4gyyhwxHGrfClqWmdtMnXHRwfVVSri7FjGMfv/QotqzMc6LRb7JMC/L
 C0S9ZDv019iB+SyQrdAXTEkK2r6FbxRmZ3Ik9Kb7r6xTsNLXDaff2WzOs2zDDsM3mfXO
 qunTV8Vwe7bS0e2F5Skrz7cJBl0T/Utf6WikyLEWFUAbpo2qrYUNYK7PZOZr+c09/IvQ
 Ju7R55gRFVRdjqNyfqr6lG+DmFGEpXNBZuZj1mijwoacLZLZMecyJ6ZIvdxfetWyOBt2
 K0FA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWwK0IIsz52Zk26X6zrEzRtT5cVNw/6B0aSJgoRGz2FshZuCQQhSP7TDE4hRrbAnKBvRw8cNzNWJS/w@nongnu.org
X-Gm-Message-State: AOJu0Yzb9yzEqMpwMw5ZHtMjGrYl+WQ1wvZfuUawC9Y52PXsh1QANO8r
 YV0NCNlpbSina6ircuJJfoidJdo40ikNQeML8/tzmG1NXZuqADgPdRHoqUNJE9Q=
X-Google-Smtp-Source: AGHT+IFuNa2USP91lTchxo80lZcRGk+pX1jhvI8MUo0XNDQuidqrqtvyuVKSpIvdAbejZcQvapMYGw==
X-Received: by 2002:a05:6a20:6a23:b0:1db:ee36:796 with SMTP id
 adf61e73a8af0-1ddae4e2668mr2287687637.13.1732083939018; 
 Tue, 19 Nov 2024 22:25:39 -0800 (PST)
Received: from [192.168.1.67] (216-180-64-156.dyn.novuscom.net.
 [216.180.64.156]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-724befac739sm784388b3a.152.2024.11.19.22.25.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 19 Nov 2024 22:25:38 -0800 (PST)
Message-ID: <b9df48b7-c1a9-4a46-bd78-b7ecb8328b33@linaro.org>
Date: Tue, 19 Nov 2024 22:25:37 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/7] docs/devel: add git-publish for patch submitting
To: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Andrew Melnychenko <andrew@daynix.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Thomas Huth <thuth@redhat.com>,
 alex.bennee@linaro.org,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Fabiano Rosas <farosas@suse.de>, Kevin Wolf <kwolf@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>,
 qemu-arm@nongnu.org, Yuri Benditovich <yuri.benditovich@daynix.com>,
 manos.pitsidianakis@linaro.org, qemu-block@nongnu.org,
 Michael Roth <michael.roth@amd.com>, Konstantin Kostiuk
 <kkostiuk@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Xu <peterx@redhat.com>, gustavo.romero@linaro.org,
 Peter Maydell <peter.maydell@linaro.org>
References: <20241118172357.475281-1-pierrick.bouvier@linaro.org>
 <20241118172357.475281-3-pierrick.bouvier@linaro.org>
 <ce090d62-89a8-4f1a-a864-add24704dd11@linaro.org>
Content-Language: en-US
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <ce090d62-89a8-4f1a-a864-add24704dd11@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::52d;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x52d.google.com
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

T24gMTEvMTkvMjQgMDA6NDEsIE1hcmNpbiBKdXN6a2lld2ljeiB3cm90ZToNCj4gVyBkbml1
IDE4LjExLjIwMjQgb8KgMTg6MjMsIFBpZXJyaWNrIEJvdXZpZXIgcGlzemU6DQo+PiBTaWdu
ZWQtb2ZmLWJ5OiBQaWVycmljayBCb3V2aWVyIDxwaWVycmljay5ib3V2aWVyQGxpbmFyby5v
cmc+DQo+PiAtLS0NCj4+ICAgIGRvY3MvZGV2ZWwvc3VibWl0dGluZy1hLXBhdGNoLnJzdCB8
IDE0ICsrKysrKysrKysrKysrDQo+PiAgICAxIGZpbGUgY2hhbmdlZCwgMTQgaW5zZXJ0aW9u
cygrKQ0KPj4NCj4+IGRpZmYgLS1naXQgYS9kb2NzL2RldmVsL3N1Ym1pdHRpbmctYS1wYXRj
aC5yc3QgYi9kb2NzL2RldmVsL3N1Ym1pdHRpbmctYS1wYXRjaC5yc3QNCj4+IGluZGV4IDM0
OWMzMmVlM2E5Li45NTM2ODJmMjBjYiAxMDA2NDQNCj4+IC0tLSBhL2RvY3MvZGV2ZWwvc3Vi
bWl0dGluZy1hLXBhdGNoLnJzdA0KPj4gKysrIGIvZG9jcy9kZXZlbC9zdWJtaXR0aW5nLWEt
cGF0Y2gucnN0DQo+PiBAQCAtMjM3LDYgKzIzNywyMCBAQCBhdHRhY2htZW50cyBjYW4gYmUg
dXNlZCBhcyBhIGxhc3QgcmVzb3J0IG9uIGEgZmlyc3QtdGltZSBzdWJtaXNzaW9uLg0KPj4g
ICAgDQo+PiAgICAuLiBfaWZfeW91X2Nhbm5vdF9zZW5kX3BhdGNoX2VtYWlsczoNCj4+ICAg
IA0KPj4gK1VzZSBnaXQtcHVibGlzaA0KPj4gK35+fn5+fn5+fn5+fn5+fg0KPj4gKw0KPj4g
K0lmIHlvdSBhbHJlYWR5IGNvbmZpZ3VyZWQgZ2l0IHNlbmQtZW1haWwsIHlvdSBjYW4gc2lt
cGx5IHVzZSBgZ2l0LXB1Ymxpc2gNCj4+ICs8aHR0cHM6Ly9naXRodWIuY29tL3N0ZWZhbmhh
L2dpdC1wdWJsaXNoPmBfXyB0byBzZW5kIHNlcmllcy4NCj4+ICsNCj4+ICs6Og0KPj4gKw0K
Pj4gKyAgICAkIGdpdCBjaGVja291dCBtYXN0ZXIgLWIgbXktZmVhdHVyZQ0KPj4gKyAgICAk
ICMgd29yayBvbiBuZXcgY29tbWl0cywgYWRkIHlvdXIgJ1NpZ25lZC1vZmYtYnknIGxpbmVz
IHRvIGVhY2gNCj4+ICsgICAgJCBnaXQgcHVibGlzaA0KPj4gKyAgICAkIC4uLiBtb3JlIHdv
cmssIHJlYmFzZSBvbiBtYXN0ZXIsIC4uLg0KPj4gKyAgICAkIGdpdCBwdWJsaXNoICMgd2ls
bCBzZW5kIGEgdjINCj4gDQo+IFlvdSByZWNvbW1lbmQgJ2I0IHNoYXphbScgaW4gMy83IHBh
dGNoIHNvIHdoeSBub3QgaGVyZT8gQm90aCAnYjQnIGFuZA0KPiAnZ2l0LXB1Ymxpc2gnIHNl
ZW0gdG8gZG8gc2FtZSBzdHVmZiAtIGhhbmRsZSBwYXRjaCBzZXJpZXMgYW5kIHNlbmQgdGhl
bQ0KPiB1cHN0cmVhbS4NCj4NCg0KQXJlIHlvdSB1c2luZyBiNCBmb3IgeW91ciBRRU1VIGNv
bnRyaWJ1dGlvbnM/DQoNCldoZW4gSSBzdGFydGVkIHdvcmtpbmcgb24gUUVNVSwgSSB0cmll
ZCBpdCBiZWZvcmUgZ2l0LXB1Ymxpc2ggYW5kIGhhZCBhbiANCmVycm9yIHdoZW4gdHJ5aW5n
IHRvIHNlbmQgbXkgc2VyaWVzLiBJIGRvbid0IHJlbWVtYmVyIGV4YWN0bHkgd2hhdCBpdCAN
CndhcywgYnV0IHNvbWV0aGluZyByZWxhdGVkIHRvIGZpbmRpbmcgdGhlIHJldmlld2VycyBm
b3IgYSBnaXZlbiBjb21taXQuIA0KV2hlbiBJIGFza2VkLCB0ZWFtIG1lbWJlcnMgcG9pbnRl
ZCBtZSB0b3dhcmRzIGdpdC1wdWJsaXNoLg0KDQo+IGI0IGFsbG93cyB0byBrZWVwIFRvL0Nj
IGVtYWlscyBpbnNpZGUgb2YgY292ZXIgbGV0dGVyIHdoaWNoIG1ha2VzIGl0DQo+IGVhc3kg
dG8gbm90IG1pc3MgYW55b25lIG5lZWRlZC4NCg0KZ2l0LXB1Ymxpc2ggd29ya3MgcHJldHR5
IHdlbGwgZm9yIG1lLCBhbmQgZG9lcyB3aGF0IHlvdSBleHBlY3QgKGtlZXAgDQp5b3VyIGNv
dmVyIGxldHRlci9jYyBhbmQgdHJhY2sgeW91ciB2ZXJzaW9ucykuDQo=

