Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F2E2E7716D
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2024 21:24:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIwqs-0007bL-SW; Wed, 04 Dec 2024 16:24:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tIwqa-0006X8-9R
 for qemu-devel@nongnu.org; Wed, 04 Dec 2024 16:23:48 -0500
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tIwqY-00060p-Fi
 for qemu-devel@nongnu.org; Wed, 04 Dec 2024 16:23:47 -0500
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-724ffe64923so304977b3a.2
 for <qemu-devel@nongnu.org>; Wed, 04 Dec 2024 13:23:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733347423; x=1733952223; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=tF4SOTM70NK7TKa044pzYE/o1+fgsBdlSl0B6ORUrAw=;
 b=gmQdrZvxmrTRGRftKtuq35DDF5viUeBF5EqQvrvbXBpVjY/HegqLjmkX4l8OZjulDT
 luSaVamlHnZKK4578NZWmT740qxk0dvdSVs5sqtcMoBDi8AlncYlXU6kmrlSiVQLmv/f
 GOm7UhtVoE6wn1OSiLBeL6p3ScTw05vPWiztSbz/lZwLyYyo7UkC7UyR0llHm4goxX8J
 2NQAuIjoIyczRTyZke7wzAmJeiez3qE8WeDZ1ueaZ6lGIdKwBO1AgIln4/gD8oudEI+F
 aJ8NsVdKxdpwXJ/4cmt1H9fgInbwhr9zHpwnPTXi1zVAfL0T4+3OIVASPaxmeLFGS89w
 QVew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733347423; x=1733952223;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=tF4SOTM70NK7TKa044pzYE/o1+fgsBdlSl0B6ORUrAw=;
 b=FjMeCVseKpErAYCnc3nGEV+bZpl6m00I/ZmARHawCjsE4nbiHAXyVR4LJNQgPddzxf
 bSwprHJUaBpYVRich/f8Enkg1CpGjVV1lFxjktC26S0ddlZT++gKSpE9vwXX0Us2BN8C
 iDEyftyvnfbIsSN3VNDXREPVLmFgHvXRnlci+KzMYPGwDbBzDab+42LwuBgOfjX1GmOU
 hzHKIGFmheX7JydEhNU1T814zPWzUYJPFWYPWuAmy2X9lS1+UFU+PNElPQdGKAoKsni4
 eya4Ky8jgqHGGhfkdDkq8YwE4zkWK2bZF21omQJhbPNOGgWqjODJX7ZKAfmnmx1YLrUf
 l2ew==
X-Forwarded-Encrypted: i=1;
 AJvYcCVq+lzBg3P4kid01l44gBnLWUvpJ6096TvTR5feeC7L6nF8jLG0pJxq8ptCy/4fj3Om7xhovm77uLI2@nongnu.org
X-Gm-Message-State: AOJu0YzRABamJoSGWnTq1CyZgg0S+ukx7hBnzmlwY6PYVWpkmB++mI2A
 VZr4IAa7Z7kCgkrnhLmmkoU9QFVb5qwOJ7xS3dUe+7d6FqIbjP6UF9vWsKnopG4=
X-Gm-Gg: ASbGncuaB+ELVx2uVpo7Al3XZOxbVna9xBBGds8oH6Sceo4IJGl4U4turlx8uKqaonK
 gUC6B2P+PZEcPmlQ2dOtrLIukK/DcJtVVYF0OuOimF8uCp89APB/JxhCgu451ybuu6Tjb7s1Oyg
 maeWXcN0QSDH5lNfQDM7tdaUWfo5cLzmphEbpkj90d71GK9TJIPOYD1qbPR+EVdJIrgdMpfKeR1
 sPL9KHlkemnJLbvqeKyTcF5677BNrstldk+D+GbVocvTdh5Xk4paK+N+ClcsZdRsGwdFO5gPl2G
 qcLcRF/zsVxbptMW3HpL2g==
X-Google-Smtp-Source: AGHT+IH09UzVZRPfcLn9Bi3oDI+ocDioCSwDvfGLm4T9uovHS+YfxqptKPoV/tJffOhV2hueh6LI+A==
X-Received: by 2002:a05:6a00:1789:b0:714:15ff:a2a4 with SMTP id
 d2e1a72fcca58-7257fa78c52mr10980012b3a.13.1733347423663; 
 Wed, 04 Dec 2024 13:23:43 -0800 (PST)
Received: from [192.168.1.67] (216-180-64-156.dyn.novuscom.net.
 [216.180.64.156]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72541828c61sm12871206b3a.163.2024.12.04.13.23.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Dec 2024 13:23:43 -0800 (PST)
Message-ID: <2ed5ff88-2577-46fb-83df-6d70de117040@linaro.org>
Date: Wed, 4 Dec 2024 13:23:42 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/sparc: Use memcpy() in memcpy32()
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Artyom Tarasenko <atar4qemu@gmail.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
References: <20241204204151.61221-1-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20241204204151.61221-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x432.google.com
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

T24gMTIvNC8yNCAxMjo0MSwgUGhpbGlwcGUgTWF0aGlldS1EYXVkw6kgd3JvdGU6DQo+IFJh
dGhlciB0aGFuIG1hbnVhbGx5IGNvcHlpbmcgZWFjaCByZWdpc3RlciwgdXNlDQo+IHRoZSBs
aWJjIG1lbWNweSgpLCB3aGljaCBpcyB3ZWxsIG9wdGltaXplZC4NCj4gDQo+IFNpZ25lZC1v
ZmYtYnk6IFBoaWxpcHBlIE1hdGhpZXUtRGF1ZMOpIDxwaGlsbWRAbGluYXJvLm9yZz4NCj4g
LS0tDQo+IFdvcnRoIHJlbmFtaW5nIGFzIHJlZzhjcHkoKT8NCj4gLS0tDQo+ICAgdGFyZ2V0
L3NwYXJjL3dpbl9oZWxwZXIuYyB8IDkgKy0tLS0tLS0tDQo+ICAgMSBmaWxlIGNoYW5nZWQs
IDEgaW5zZXJ0aW9uKCspLCA4IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL3Rh
cmdldC9zcGFyYy93aW5faGVscGVyLmMgYi90YXJnZXQvc3BhcmMvd2luX2hlbHBlci5jDQo+
IGluZGV4IGI1M2ZjOWNlOTQwLi5kYWIwZmYwMGNjYyAxMDA2NDQNCj4gLS0tIGEvdGFyZ2V0
L3NwYXJjL3dpbl9oZWxwZXIuYw0KPiArKysgYi90YXJnZXQvc3BhcmMvd2luX2hlbHBlci5j
DQo+IEBAIC0yNiwxNCArMjYsNyBAQA0KPiAgIA0KPiAgIHN0YXRpYyBpbmxpbmUgdm9pZCBt
ZW1jcHkzMih0YXJnZXRfdWxvbmcgKmRzdCwgY29uc3QgdGFyZ2V0X3Vsb25nICpzcmMpDQo+
ICAgew0KPiAtICAgIGRzdFswXSA9IHNyY1swXTsNCj4gLSAgICBkc3RbMV0gPSBzcmNbMV07
DQo+IC0gICAgZHN0WzJdID0gc3JjWzJdOw0KPiAtICAgIGRzdFszXSA9IHNyY1szXTsNCj4g
LSAgICBkc3RbNF0gPSBzcmNbNF07DQo+IC0gICAgZHN0WzVdID0gc3JjWzVdOw0KPiAtICAg
IGRzdFs2XSA9IHNyY1s2XTsNCj4gLSAgICBkc3RbN10gPSBzcmNbN107DQo+ICsgICAgbWVt
Y3B5KGRzdCwgc3JjLCA4ICogc2l6ZW9mKHRhcmdldF91bG9uZykpOw0KPiAgIH0NCj4gICAN
Cj4gICB2b2lkIGNwdV9zZXRfY3dwKENQVVNQQVJDU3RhdGUgKmVudiwgaW50IG5ld19jd3Ap
DQoNClBvdGVudGlhbGx5IHdlIGNvdWxkIGdvIGZ1cnRoZXIgYW5kIGp1c3QgcmVtb3ZlIHRo
ZSBtZW1jcHkzMiBmdW5jdGlvbi4NCg0KUmV2aWV3ZWQtYnk6IFBpZXJyaWNrIEJvdXZpZXIg
PHBpZXJyaWNrLmJvdXZpZXJAbGluYXJvLm9yZz4NCg==

