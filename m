Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5384D637DF
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2024 04:10:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBRAd-0001TL-KJ; Wed, 13 Nov 2024 23:09:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tBRAb-0001RA-B0
 for qemu-devel@nongnu.org; Wed, 13 Nov 2024 23:09:25 -0500
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tBRAY-0003CU-SO
 for qemu-devel@nongnu.org; Wed, 13 Nov 2024 23:09:25 -0500
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-211c1c144f5so2459195ad.1
 for <qemu-devel@nongnu.org>; Wed, 13 Nov 2024 20:09:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731557361; x=1732162161; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=1uzC/qplX/KbWgH0kNa5nK4OaHri94fczlPVtVib/78=;
 b=oeRwsLjdHzokpQeGEZYyQTjLSOdHNqjxp/blqtJITVYxxw+FI/yHcp8JQDLs39wvoI
 7nbDbqolz4CDdLuxaT0F3xOsQszpBwVaIo0NeQtqdMsC9Nfc2jDTbElJdN1tfV1FPnLF
 c/2gvy86ov3JbWznA6M8TqPZHGBHT4tMytAIanmqO7pMH/WU+gZLvMIorQaTPK0f+Nsl
 mP+2q1jTloYhyWiakS5Oy81mP6W4sjeorx9XAHhb4JruHM0dvueDRajKLAAwwK//Vxfw
 HKLrqBpjHj0zkEA2KeF+Vshud/Hw6cEBnpMRJsPDGXGcAd7A4SXj1h/0Sn9zRUDfIKQD
 FuiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731557361; x=1732162161;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1uzC/qplX/KbWgH0kNa5nK4OaHri94fczlPVtVib/78=;
 b=Ua20xBjfIeeLQwXa2872AGkP7hbOTexgJcLel5gNeZQ2JYQgJEUiCfm0JEmoQCiY/6
 W7MxgMxlAQyJoN1NSav0gCMdqKwYv360tgycA31rK7K38L82djmWWNtcIlcgbmW3xY/K
 dalCnFvJ6aS8J+y0XjRub1nXSlY6czS0i3pkpgFSaVl84eV2S3vyyBpYO+2w8PJcg3CK
 gT8QNf+xCD5b6ZVU3z1F70IJ1fhufxMBHYFiLOFK+2UEaSA3MtLIUgmo/ShlqehSuCbS
 Ip/7q1M4F1mMCt3sQTafn/veUwN29lfqacHg1luGq8RC/zbMK/bBukR945KVfwOS5zmA
 AxhQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUrpEVeda5k/2HmizVeBvNXfYvho01Ha32XrUZEVFWhyTmGEQFUZirJmTYzqWyWHyfKWddDLwzPcy4N@nongnu.org
X-Gm-Message-State: AOJu0Yz/3XMvPZDEgutEVHNaqpzM7JNPSNjxhGuERiyp1EUoG5eBAQQk
 w79qzC3LYbJtYgvAcz73kubYGh4yVvZZiQ5mQeNpl+QhozMERTQ9TmoBVOYGvzY=
X-Google-Smtp-Source: AGHT+IGAquNpYcTrQuJhVu7KhYPa6+oqqBHuRkAo1PPfoNFrB+kLpwVwG9Jdgjsu0lL9GTZgCar9CA==
X-Received: by 2002:a17:903:120e:b0:205:7007:84fa with SMTP id
 d9443c01a7336-211c0fbcda4mr29024845ad.28.1731557361177; 
 Wed, 13 Nov 2024 20:09:21 -0800 (PST)
Received: from [192.168.1.67] (216-180-64-156.dyn.novuscom.net.
 [216.180.64.156]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-211c7d1f57esm1363635ad.224.2024.11.13.20.09.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 Nov 2024 20:09:20 -0800 (PST)
Message-ID: <b4a71289-6983-4e93-b549-6225b59b6836@linaro.org>
Date: Wed, 13 Nov 2024 20:09:19 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/24] exec/cpu-defs: Remove unnecessary headers
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Anton Johansson <anjo@rev.ng>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Thomas Huth <thuth@redhat.com>, qemu-arm@nongnu.org, 
 Peter Xu <peterx@redhat.com>, qemu-riscv@nongnu.org,
 David Hildenbrand <david@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-s390x@nongnu.org
References: <20241114011310.3615-1-philmd@linaro.org>
 <20241114011310.3615-3-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20241114011310.3615-3-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x634.google.com
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

DQoNCk9uIDExLzEzLzI0IDE3OjEyLCBQaGlsaXBwZSBNYXRoaWV1LURhdWTDqSB3cm90ZToN
Cj4gImV4ZWMvY3B1LWRlZnMuaCIgc2hvdWxkIGJlIGtlcHQgYXMgbWluaW1hbCBhcyBwb3Nz
aWJsZTsNCj4gYmVzaWRlcyB0aGVzZSBpbmNsdWRlcyBkb24ndCBzZWVtIG5lY2Vzc2F5LiBS
ZW1vdmUgdGhlbS4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IFBoaWxpcHBlIE1hdGhpZXUtRGF1
ZMOpIDxwaGlsbWRAbGluYXJvLm9yZz4NCj4gLS0tDQo+ICAgaW5jbHVkZS9leGVjL2NwdS1k
ZWZzLmggfCA4IC0tLS0tLS0tDQo+ICAgMSBmaWxlIGNoYW5nZWQsIDggZGVsZXRpb25zKC0p
DQo+IA0KPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9leGVjL2NwdS1kZWZzLmggYi9pbmNsdWRl
L2V4ZWMvY3B1LWRlZnMuaA0KPiBpbmRleCAwZGJlZjMwMTBjLi5hZTE4Mzk4ZmE5IDEwMDY0
NA0KPiAtLS0gYS9pbmNsdWRlL2V4ZWMvY3B1LWRlZnMuaA0KPiArKysgYi9pbmNsdWRlL2V4
ZWMvY3B1LWRlZnMuaA0KPiBAQCAtMjMsMTQgKzIzLDYgQEANCj4gICAjZXJyb3IgY3B1Lmgg
aW5jbHVkZWQgZnJvbSBjb21tb24gY29kZQ0KPiAgICNlbmRpZg0KPiAgIA0KPiAtI2luY2x1
ZGUgInFlbXUvaG9zdC11dGlscy5oIg0KPiAtI2luY2x1ZGUgInFlbXUvdGhyZWFkLmgiDQo+
IC0jaWZuZGVmIENPTkZJR19VU0VSX09OTFkNCj4gLSNpbmNsdWRlICJleGVjL2h3YWRkci5o
Ig0KPiAtI2VuZGlmDQo+IC0jaW5jbHVkZSAiZXhlYy9tZW1hdHRycy5oIg0KPiAtI2luY2x1
ZGUgImh3L2NvcmUvY3B1LmgiDQo+IC0NCj4gICAjaW5jbHVkZSAiY3B1LXBhcmFtLmgiDQo+
ICAgDQo+ICAgI2lmbmRlZiBUQVJHRVRfTE9OR19CSVRTDQoNClJldmlld2VkLWJ5OiBQaWVy
cmljayBCb3V2aWVyIDxwaWVycmljay5ib3V2aWVyQGxpbmFyby5vcmc+DQoNCg==

