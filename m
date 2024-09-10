Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5955EEB64DE
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2024 14:47:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1so29I-000187-3w; Tue, 10 Sep 2024 10:47:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1so29G-00010A-5T
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 10:47:18 -0400
Received: from mail-pg1-x52f.google.com ([2607:f8b0:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1so29E-000325-CP
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 10:47:17 -0400
Received: by mail-pg1-x52f.google.com with SMTP id
 41be03b00d2f7-7d7a9200947so2168813a12.3
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2024 07:47:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725979635; x=1726584435; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=0ZgwdPCNPCvfmgwsZuXaM3Zy5aQk299ETeodJECpJz0=;
 b=u4VmLrEHCjdL8bCacMnxR5kjfebOAAYzoNPb4UXdoj0mBxoihZxjc7vZbY67JV2u/W
 pHD1wSXMEJAlDw5PcPtCMBrmnsCklvzFsBTkiWcsYM0td8PesUJ+cidxioc/vayUeeI/
 d7MbNJjnsQWO37IwltRKXG/0iNcnzgO0EJ/6fbr6/OOhzFEM4nDfF9CkvP8Jf2e2GETg
 1FIsl5raTdWT2YIxZ+0FqPPaMNkvvo5SL/tGW8tVqcIirXAVxBqKgZxIuqp4+gY5ZV4v
 qrc5CM+JEb0jPpHH4sXpxc1tgFLv+VHtINntBvZiKAQDG7LoYx0Ss6BZt59mSvC4RUH8
 5/Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725979635; x=1726584435;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0ZgwdPCNPCvfmgwsZuXaM3Zy5aQk299ETeodJECpJz0=;
 b=Nil7Lo/s1f7d/1crWRl7OdJGoUX7Piel2L0wkCLjb97W+5L/dKsnmU0jLAVx6ZExvz
 ucKPiGJszD/W+4gezk8aN2Y0ceIqfYmaVm/DJNdD8JNCCxPHJVXs+zAzNU4ujyjJDNLw
 aQZ1cBE/KOVSIzv7hz+Ezg/tnrubmH6fY7GuhbQ8wtQj2mnQP9Xj8a0abs/L8UEU8GMr
 OC07I7V3U1yPNv/nJQ4lVeE4q7UcfTN7p242NIPp4HxN1T1J69OTdYcOzb3Imgyvsr1S
 tAp2SuSIINyVPXRYrEQU/xuEn51iRjtJsS7baSGkXyFtqtllM2t7ytB48GhxoHUpmD7R
 sbGQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXPRezeY8NxrkH3EiktjXU6vcJ8XdFS8n4v435yiNHmFmO8TCnlg2gIHrWYtKDX/wcBzNCHI5l+xk6B@nongnu.org
X-Gm-Message-State: AOJu0YwC0FR3ubhjQxbOlDqNGcplusHcg1xmDpQY8VB7RgM78+Td9B5K
 7CbomC7dCGn4HYOFfiRaY1dwWXCEm6nfFqsQbPP0If2zjnkqoIIp9H/Z5e5dRWo=
X-Google-Smtp-Source: AGHT+IEJGq+QLpMiNX832acEXPFuBeadvscZ3JrRZxwKfYrFD9qMi+ZMAhFYFJpX5oh88cDAZuzKmQ==
X-Received: by 2002:a05:6a21:58d:b0:1cf:2aa3:1f94 with SMTP id
 adf61e73a8af0-1cf5e0f80c3mr1366512637.22.1725979635049; 
 Tue, 10 Sep 2024 07:47:15 -0700 (PDT)
Received: from ?IPV6:2604:3d08:9384:1d00::9633? ([2604:3d08:9384:1d00::9633])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20710eea930sm49828695ad.168.2024.09.10.07.47.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Sep 2024 07:47:14 -0700 (PDT)
Message-ID: <8f4eca23-4067-47bd-87a9-82f48f319fc2@linaro.org>
Date: Tue, 10 Sep 2024 07:47:13 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 19/26] tests/tcg: clean up output of memory system test
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Eduardo Habkost <eduardo@habkost.net>, Zhao Liu <zhao1.liu@intel.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Beraldo Leal <bleal@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Alexandre Iooss <erdnaxe@crans.org>,
 Yanan Wang <wangyanan55@huawei.com>, Peter Maydell
 <peter.maydell@linaro.org>, Mahmoud Mandour <ma.mandourr@gmail.com>,
 Thomas Huth <thuth@redhat.com>, qemu-arm@nongnu.org,
 devel@lists.libvirt.org, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>
References: <20240910140733.4007719-1-alex.bennee@linaro.org>
 <20240910140733.4007719-20-alex.bennee@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20240910140733.4007719-20-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::52f;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x52f.google.com
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

T24gOS8xMC8yNCAwNzowNywgQWxleCBCZW5uw6llIHdyb3RlOg0KPiBUaGlzIGlzIHVzZWZ1
bCBpbmZvcm1hdGlvbiB3aGVuIGRlYnVnZ2luZyBtZW1vcnkgaXNzdWVzIHNvIGxldHMNCj4g
aW1wcm92ZSBieToNCj4gDQo+ICAgIC0gaW5jbHVkZSB0aGUgcHRyIGFkZHJlc3MgZm9yIHU4
IGZpbGxzIChsaWtlIHRoZSBvdGhlcnMpDQo+ICAgIC0gaW5kaWNhdGUgdGhlIG51bWJlciBv
ZiBvcGVyYXRpb25zIGZvciByZWFkcyBhbmQgd3JpdGVzDQo+ICAgIC0gZXhwbGljaXRseSBu
b3RlIHdoZW4gd2UgYXJlIGZsdXNoaW5nDQo+ICAgIC0gbW92ZSB0aGUgZmlsbCBwcmludGYg
dG8gYWZ0ZXIgdGhlIHJlc2V0DQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBBbGV4IEJlbm7DqWUg
PGFsZXguYmVubmVlQGxpbmFyby5vcmc+DQo+IC0tLQ0KPiAgIHRlc3RzL3RjZy9tdWx0aWFy
Y2gvc3lzdGVtL21lbW9yeS5jIHwgNDcgKysrKysrKysrKysrKysrKysrLS0tLS0tLS0tLS0N
Cj4gICAxIGZpbGUgY2hhbmdlZCwgMjkgaW5zZXJ0aW9ucygrKSwgMTggZGVsZXRpb25zKC0p
DQo+IA0KPiBkaWZmIC0tZ2l0IGEvdGVzdHMvdGNnL211bHRpYXJjaC9zeXN0ZW0vbWVtb3J5
LmMgYi90ZXN0cy90Y2cvbXVsdGlhcmNoL3N5c3RlbS9tZW1vcnkuYw0KPiBpbmRleCA2ZWIy
ZWIxNmY3Li44ZjIzNzE5NzVkIDEwMDY0NA0KPiAtLS0gYS90ZXN0cy90Y2cvbXVsdGlhcmNo
L3N5c3RlbS9tZW1vcnkuYw0KPiArKysgYi90ZXN0cy90Y2cvbXVsdGlhcmNoL3N5c3RlbS9t
ZW1vcnkuYw0KPiBAQCAtNjMsMTIgKzYzLDE0IEBAIHN0YXRpYyB2b2lkIGluaXRfdGVzdF9k
YXRhX3U4KGludCB1bnVzZWRfb2Zmc2V0KQ0KPiAgICAgICBpbnQgaTsNCj4gICAgICAgKHZv
aWQpKHVudXNlZF9vZmZzZXQpOw0KPiAgIA0KPiAtICAgIG1sX3ByaW50ZigiRmlsbGluZyB0
ZXN0IGFyZWEgd2l0aCB1ODoiKTsNCj4gKyAgICBtbF9wcmludGYoIkZpbGxpbmcgdGVzdCBh
cmVhIHdpdGggdTggKCVwKToiLCBwdHIpOw0KPiArDQo+ICAgICAgIGZvciAoaSA9IDA7IGkg
PCBURVNUX1NJWkU7IGkrKykgew0KPiAgICAgICAgICAgKnB0cisrID0gQllURV9ORVhUKGNv
dW50KTsNCj4gICAgICAgICAgIHBkb3QoaSk7DQo+ICAgICAgIH0NCj4gLSAgICBtbF9wcmlu
dGYoImRvbmVcbiIpOw0KPiArDQo+ICsgICAgbWxfcHJpbnRmKCJkb25lICVkIEAgJXBcbiIs
IGksIHB0cik7DQo+ICAgfQ0KPiAgIA0KPiAgIC8qDQo+IEBAIC05NCw3ICs5Niw3IEBAIHN0
YXRpYyB2b2lkIGluaXRfdGVzdF9kYXRhX3M4KGJvb2wgbmVnX2ZpcnN0KQ0KPiAgICAgICAg
ICAgKnB0cisrID0gZ2V0X2J5dGUoaSwgIW5lZ19maXJzdCk7DQo+ICAgICAgICAgICBwZG90
KGkpOw0KPiAgICAgICB9DQo+IC0gICAgbWxfcHJpbnRmKCJkb25lXG4iKTsNCj4gKyAgICBt
bF9wcmludGYoImRvbmUgJWQgQCAlcFxuIiwgaSAqIDIsIHB0cik7DQo+ICAgfQ0KPiAgIA0K
PiAgIC8qDQo+IEBAIC0xMDUsOSArMTA3LDE4IEBAIHN0YXRpYyB2b2lkIHJlc2V0X3N0YXJ0
X2RhdGEoaW50IG9mZnNldCkNCj4gICB7DQo+ICAgICAgIHVpbnQzMl90ICpwdHIgPSAodWlu
dDMyX3QgKikgJnRlc3RfZGF0YVswXTsNCj4gICAgICAgaW50IGk7DQo+ICsNCj4gKyAgICBp
ZiAoIW9mZnNldCkgew0KPiArICAgICAgICByZXR1cm47DQo+ICsgICAgfQ0KPiArDQo+ICsg
ICAgbWxfcHJpbnRmKCJGbHVzaGluZyAlZCBieXRlcyBmcm9tICVwOiAiLCBvZmZzZXQsIHB0
cik7DQo+ICsNCj4gICAgICAgZm9yIChpID0gMDsgaSA8IG9mZnNldDsgaSsrKSB7DQo+ICAg
ICAgICAgICAqcHRyKysgPSAwOw0KPiAgICAgICB9DQo+ICsNCj4gKyAgICBtbF9wcmludGYo
ImRvbmUgJWQgQCAlcFxuIiwgaSwgcHRyKTsNCj4gICB9DQo+ICAgDQo+ICAgc3RhdGljIHZv
aWQgaW5pdF90ZXN0X2RhdGFfdTE2KGludCBvZmZzZXQpDQo+IEBAIC0xMTcsMTcgKzEyOCwx
NyBAQCBzdGF0aWMgdm9pZCBpbml0X3Rlc3RfZGF0YV91MTYoaW50IG9mZnNldCkNCj4gICAg
ICAgY29uc3QgaW50IG1heCA9IChURVNUX1NJWkUgLSBvZmZzZXQpIC8gc2l6ZW9mKHdvcmQp
Ow0KPiAgICAgICBpbnQgaTsNCj4gICANCj4gLSAgICBtbF9wcmludGYoIkZpbGxpbmcgdGVz
dCBhcmVhIHdpdGggdTE2IChvZmZzZXQgJWQsICVwKToiLCBvZmZzZXQsIHB0cik7DQo+IC0N
Cj4gICAgICAgcmVzZXRfc3RhcnRfZGF0YShvZmZzZXQpOw0KPiAgIA0KPiArICAgIG1sX3By
aW50ZigiRmlsbGluZyB0ZXN0IGFyZWEgd2l0aCB1MTYgKG9mZnNldCAlZCwgJXApOiIsIG9m
ZnNldCwgcHRyKTsNCj4gKw0KPiAgICAgICBmb3IgKGkgPSAwOyBpIDwgbWF4OyBpKyspIHsN
Cj4gICAgICAgICAgIHVpbnQxNl90IGxvdyA9IEJZVEVfTkVYVChjb3VudCksIGhpZ2ggPSBC
WVRFX05FWFQoY291bnQpOw0KPiAgICAgICAgICAgd29yZCA9IEJZVEVfU0hJRlQoaGlnaCwg
MSkgfCBCWVRFX1NISUZUKGxvdywgMCk7DQo+ICAgICAgICAgICAqcHRyKysgPSB3b3JkOw0K
PiAgICAgICAgICAgcGRvdChpKTsNCj4gICAgICAgfQ0KPiAtICAgIG1sX3ByaW50ZigiZG9u
ZSBAICVwXG4iLCBwdHIpOw0KPiArICAgIG1sX3ByaW50ZigiZG9uZSAlZCBAICVwXG4iLCBp
LCBwdHIpOw0KPiAgIH0NCj4gICANCj4gICBzdGF0aWMgdm9pZCBpbml0X3Rlc3RfZGF0YV91
MzIoaW50IG9mZnNldCkNCj4gQEAgLTEzNywxMCArMTQ4LDEwIEBAIHN0YXRpYyB2b2lkIGlu
aXRfdGVzdF9kYXRhX3UzMihpbnQgb2Zmc2V0KQ0KPiAgICAgICBjb25zdCBpbnQgbWF4ID0g
KFRFU1RfU0laRSAtIG9mZnNldCkgLyBzaXplb2Yod29yZCk7DQo+ICAgICAgIGludCBpOw0K
PiAgIA0KPiAtICAgIG1sX3ByaW50ZigiRmlsbGluZyB0ZXN0IGFyZWEgd2l0aCB1MzIgKG9m
ZnNldCAlZCwgJXApOiIsIG9mZnNldCwgcHRyKTsNCj4gLQ0KPiAgICAgICByZXNldF9zdGFy
dF9kYXRhKG9mZnNldCk7DQo+ICAgDQo+ICsgICAgbWxfcHJpbnRmKCJGaWxsaW5nIHRlc3Qg
YXJlYSB3aXRoIHUzMiAob2Zmc2V0ICVkLCAlcCk6Iiwgb2Zmc2V0LCBwdHIpOw0KPiArDQo+
ICAgICAgIGZvciAoaSA9IDA7IGkgPCBtYXg7IGkrKykgew0KPiAgICAgICAgICAgdWludDMy
X3QgYjQgPSBCWVRFX05FWFQoY291bnQpLCBiMyA9IEJZVEVfTkVYVChjb3VudCk7DQo+ICAg
ICAgICAgICB1aW50MzJfdCBiMiA9IEJZVEVfTkVYVChjb3VudCksIGIxID0gQllURV9ORVhU
KGNvdW50KTsNCj4gQEAgLTE0OSw3ICsxNjAsNyBAQCBzdGF0aWMgdm9pZCBpbml0X3Rlc3Rf
ZGF0YV91MzIoaW50IG9mZnNldCkNCj4gICAgICAgICAgICpwdHIrKyA9IHdvcmQ7DQo+ICAg
ICAgICAgICBwZG90KGkpOw0KPiAgICAgICB9DQo+IC0gICAgbWxfcHJpbnRmKCJkb25lIEAg
JXBcbiIsIHB0cik7DQo+ICsgICAgbWxfcHJpbnRmKCJkb25lICVkIEAgJXBcbiIsIGksIHB0
cik7DQo+ICAgfQ0KPiAgIA0KPiAgIHN0YXRpYyB2b2lkIGluaXRfdGVzdF9kYXRhX3U2NChp
bnQgb2Zmc2V0KQ0KPiBAQCAtMTU5LDEwICsxNzAsMTAgQEAgc3RhdGljIHZvaWQgaW5pdF90
ZXN0X2RhdGFfdTY0KGludCBvZmZzZXQpDQo+ICAgICAgIGNvbnN0IGludCBtYXggPSAoVEVT
VF9TSVpFIC0gb2Zmc2V0KSAvIHNpemVvZih3b3JkKTsNCj4gICAgICAgaW50IGk7DQo+ICAg
DQo+IC0gICAgbWxfcHJpbnRmKCJGaWxsaW5nIHRlc3QgYXJlYSB3aXRoIHU2NCAob2Zmc2V0
ICVkLCAlcCk6Iiwgb2Zmc2V0LCBwdHIpOw0KPiAtDQo+ICAgICAgIHJlc2V0X3N0YXJ0X2Rh
dGEob2Zmc2V0KTsNCj4gICANCj4gKyAgICBtbF9wcmludGYoIkZpbGxpbmcgdGVzdCBhcmVh
IHdpdGggdTY0IChvZmZzZXQgJWQsICVwKToiLCBvZmZzZXQsIHB0cik7DQo+ICsNCj4gICAg
ICAgZm9yIChpID0gMDsgaSA8IG1heDsgaSsrKSB7DQo+ICAgICAgICAgICB1aW50NjRfdCBi
OCA9IEJZVEVfTkVYVChjb3VudCksIGI3ID0gQllURV9ORVhUKGNvdW50KTsNCj4gICAgICAg
ICAgIHVpbnQ2NF90IGI2ID0gQllURV9ORVhUKGNvdW50KSwgYjUgPSBCWVRFX05FWFQoY291
bnQpOw0KPiBAQCAtMTc0LDcgKzE4NSw3IEBAIHN0YXRpYyB2b2lkIGluaXRfdGVzdF9kYXRh
X3U2NChpbnQgb2Zmc2V0KQ0KPiAgICAgICAgICAgKnB0cisrID0gd29yZDsNCj4gICAgICAg
ICAgIHBkb3QoaSk7DQo+ICAgICAgIH0NCj4gLSAgICBtbF9wcmludGYoImRvbmUgQCAlcFxu
IiwgcHRyKTsNCj4gKyAgICBtbF9wcmludGYoImRvbmUgJWQgQCAlcFxuIiwgaSwgcHRyKTsN
Cj4gICB9DQo+ICAgDQo+ICAgc3RhdGljIGJvb2wgcmVhZF90ZXN0X2RhdGFfdTE2KGludCBv
ZmZzZXQpDQo+IEBAIC0xOTgsNyArMjA5LDcgQEAgc3RhdGljIGJvb2wgcmVhZF90ZXN0X2Rh
dGFfdTE2KGludCBvZmZzZXQpDQo+ICAgICAgICAgICB9DQo+ICAgDQo+ICAgICAgIH0NCj4g
LSAgICBtbF9wcmludGYoImRvbmUgQCAlcFxuIiwgcHRyKTsNCj4gKyAgICBtbF9wcmludGYo
ImRvbmUgJWQgQCAlcFxuIiwgaSwgcHRyKTsNCj4gICAgICAgcmV0dXJuIHRydWU7DQo+ICAg
fQ0KPiAgIA0KPiBAQCAtMjM5LDcgKzI1MCw3IEBAIHN0YXRpYyBib29sIHJlYWRfdGVzdF9k
YXRhX3UzMihpbnQgb2Zmc2V0KQ0KPiAgICAgICAgICAgICAgIHBkb3QoaSk7DQo+ICAgICAg
ICAgICB9DQo+ICAgICAgIH0NCj4gLSAgICBtbF9wcmludGYoImRvbmUgQCAlcFxuIiwgcHRy
KTsNCj4gKyAgICBtbF9wcmludGYoImRvbmUgJWQgQCAlcFxuIiwgaSwgcHRyKTsNCj4gICAg
ICAgcmV0dXJuIHRydWU7DQo+ICAgfQ0KPiAgIA0KPiBAQCAtMjkzLDcgKzMwNCw3IEBAIHN0
YXRpYyBib29sIHJlYWRfdGVzdF9kYXRhX3U2NChpbnQgb2Zmc2V0KQ0KPiAgICAgICAgICAg
ICAgIHBkb3QoaSk7DQo+ICAgICAgICAgICB9DQo+ICAgICAgIH0NCj4gLSAgICBtbF9wcmlu
dGYoImRvbmUgQCAlcFxuIiwgcHRyKTsNCj4gKyAgICBtbF9wcmludGYoImRvbmUgJWQgQCAl
cFxuIiwgaSwgcHRyKTsNCj4gICAgICAgcmV0dXJuIHRydWU7DQo+ICAgfQ0KPiAgIA0KPiBA
QCAtMzY1LDcgKzM3Niw3IEBAIHN0YXRpYyBib29sIHJlYWRfdGVzdF9kYXRhX3M4KGludCBv
ZmZzZXQsIGJvb2wgbmVnX2ZpcnN0KQ0KPiAgICAgICAgICAgICAgIHJldHVybiBmYWxzZTsN
Cj4gICAgICAgICAgIH0NCj4gICAgICAgfQ0KPiAtICAgIG1sX3ByaW50ZigiZG9uZSBAICVw
XG4iLCBwdHIpOw0KPiArICAgIG1sX3ByaW50ZigiZG9uZSAlZCBAICVwXG4iLCBpICogMiwg
cHRyKTsNCj4gICAgICAgcmV0dXJuIHRydWU7DQo+ICAgfQ0KPiAgIA0KPiBAQCAtMzk4LDcg
KzQwOSw3IEBAIHN0YXRpYyBib29sIHJlYWRfdGVzdF9kYXRhX3MxNihpbnQgb2Zmc2V0LCBi
b29sIG5lZ19maXJzdCkNCj4gICAgICAgICAgICAgICByZXR1cm4gZmFsc2U7DQo+ICAgICAg
ICAgICB9DQo+ICAgICAgIH0NCj4gLSAgICBtbF9wcmludGYoImRvbmUgQCAlcFxuIiwgcHRy
KTsNCj4gKyAgICBtbF9wcmludGYoImRvbmUgJWQgQCAlcFxuIiwgaSwgcHRyKTsNCj4gICAg
ICAgcmV0dXJuIHRydWU7DQo+ICAgfQ0KPiAgIA0KPiBAQCAtNDMxLDcgKzQ0Miw3IEBAIHN0
YXRpYyBib29sIHJlYWRfdGVzdF9kYXRhX3MzMihpbnQgb2Zmc2V0LCBib29sIG5lZ19maXJz
dCkNCj4gICAgICAgICAgICAgICByZXR1cm4gZmFsc2U7DQo+ICAgICAgICAgICB9DQo+ICAg
ICAgIH0NCj4gLSAgICBtbF9wcmludGYoImRvbmUgQCAlcFxuIiwgcHRyKTsNCj4gKyAgICBt
bF9wcmludGYoImRvbmUgJWQgQCAlcFxuIiwgaSwgcHRyKTsNCj4gICAgICAgcmV0dXJuIHRy
dWU7DQo+ICAgfQ0KPiAgIA0KDQpSZXZpZXdlZC1ieTogUGllcnJpY2sgQm91dmllciA8cGll
cnJpY2suYm91dmllckBsaW5hcm8ub3JnPg0K

