Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B29DC369C2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Apr 2025 18:21:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7IFK-0007o1-Un; Tue, 22 Apr 2025 14:21:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u7IFG-0007jS-U0
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 14:21:23 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u7IFF-0008L3-0Z
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 14:21:22 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-2295d78b433so65034805ad.2
 for <qemu-devel@nongnu.org>; Tue, 22 Apr 2025 11:21:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745346074; x=1745950874; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=QfL5ZM6Vo4/TzZZIzUnyIqApp0acSucWAhDguC1CWhg=;
 b=FP1Y6cUze9rgGMUrIJVt3bbOvVEC9fMDJcUvydLs34xkpT1hOlgER+XH5GkuPToae/
 E6Q7RIOr3CwiluseHNubjEA6TSwwdFDW89lvT937CwZ1Dn/WCOa0hL0CgZvMvHmGDEsb
 kot+3Bexb8kE3dKhLjiDw7jSBFdTBYw1FUGdH5N1/HzfwC4a6xa9/b1KXygxTOR/VYDA
 wyy8U8mlaDcjH0xhLPv/JzS2RpdBOYOqYviVGm/mRkclmP/qX6/7w2uXiL0wK4DludT0
 Y+RVeZl+mhv98EhyAeDEn0uejTTnEXP9msMIe5NZgh2kA1sCI7nhP2ZMZLccerLzmcQx
 rKuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745346074; x=1745950874;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=QfL5ZM6Vo4/TzZZIzUnyIqApp0acSucWAhDguC1CWhg=;
 b=oK4/M0wOEA4FMPehCA+KJNK3iPWw+Uu3qnoumlt0G2UZbPylT5ORrVffI6WNi6gPXM
 U3QmfAD+duzP2uljsVt2UgrtrgH9OPi609V8xENGfpE/0qHhofVYf63YroUOc5WS3YTN
 lw8OqH8px6KmQKecrNcrUn4JSDLqBDoZjFBmhKQiv6lQ8OFPX/Di/JH92C0xKBCTGjzY
 XZa7dt2LdQlb+r1PVkveK/1Vu3gq5tFEU7+UaDMjuIv72yKR4hd/5Pr8182qiEn6vapS
 ftZ2U4tSUYQViHQ7xJnZ9ColCF1aq3diHZciHG20eKU75eWekyE+Sg2eyHjcD9rgt4I8
 KdAw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUjwqEVcUP8nQwYrDYfLwp/lwO6RWyHpPtE3I1tWVDTrtaP9Xq2hansRgmN+ZIS42cZpMaQSzjlrP/I@nongnu.org
X-Gm-Message-State: AOJu0YxjPtnYowVIWdjJQVKdnVhPt8ll6oFXn26lwlmhuLUtz/CunCJL
 RKgqAU+Gz/dP73gRcPzZjAauBGM5eaIBhaQA/dHHJsy2wZcgbYFCEM7UYNomliE=
X-Gm-Gg: ASbGnctqL6OFEt2ivDDGWVlXlOC++/jUYHEhPl9LjOvmRSYNvS86WXoaXSHkqkEvFY8
 r+iR1VXPcYyFyQJRMYswivurAsQw9lkbv8JW3zEY+zwiWOzS8Nm418k9C04CaQ7I4annLL6+PcN
 kF2esTLuZzWBjEkLsV0EOUhYehZlBRxkUR4KvGovS6uvJlpo+kqHOouZOYBFt1E0RDEiN7i9cyM
 pHJx/ERWWAiSVsSMsi0EDNO23zkIUiSsV795aRmZNbM+fMvoc3QsfJotlwVm+3KV+AtK0QU8OO4
 N8wnM7iB7Fnt6/RQOOdFQrpCRyENSvGWJP9P8P3j7gWirPWlkE7QSw==
X-Google-Smtp-Source: AGHT+IGiRLhE38My+db0HLC/iaGBxltqbnx/tHRQML/KVmCr7Hn6MS0PAJsIqChb32VzZnXbyIMtNA==
X-Received: by 2002:a17:903:228a:b0:21f:5638:2d8 with SMTP id
 d9443c01a7336-22c53620bdfmr225606395ad.53.1745346074002; 
 Tue, 22 Apr 2025 11:21:14 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22c50eceb4fsm88481725ad.183.2025.04.22.11.21.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Apr 2025 11:21:13 -0700 (PDT)
Message-ID: <d9301595-6547-4137-bdab-da1f52fc113d@linaro.org>
Date: Tue, 22 Apr 2025 11:21:13 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v4 15/19] qemu/target_info: Add target_aarch64() helper
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Anton Johansson <anjo@rev.ng>
References: <20250422145502.70770-1-philmd@linaro.org>
 <20250422145502.70770-16-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250422145502.70770-16-philmd@linaro.org>
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

T24gNC8yMi8yNSAwNzo1NCwgUGhpbGlwcGUgTWF0aGlldS1EYXVkw6kgd3JvdGU6DQo+IEFk
ZCBhIGhlbHBlciB0byBkaXN0aW5jdCB0aGUgYmluYXJ5IGlzIHRhcmdldHRpbmcNCj4gQWFy
Y2g2NCBvciBub3QuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBQaGlsaXBwZSBNYXRoaWV1LURh
dWTDqSA8cGhpbG1kQGxpbmFyby5vcmc+DQo+IC0tLQ0KPiAgIGluY2x1ZGUvcWVtdS90YXJn
ZXQtaW5mby5oIHwgNyArKysrKysrDQo+ICAgdGFyZ2V0LWluZm8uYyAgICAgICAgICAgICAg
fCA1ICsrKysrDQo+ICAgMiBmaWxlcyBjaGFuZ2VkLCAxMiBpbnNlcnRpb25zKCspDQo+IA0K
PiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9xZW11L3RhcmdldC1pbmZvLmggYi9pbmNsdWRlL3Fl
bXUvdGFyZ2V0LWluZm8uaA0KPiBpbmRleCAwMjI0YjM1YjE2Ni4uMzk1YzAwOWJhZjIgMTAw
NjQ0DQo+IC0tLSBhL2luY2x1ZGUvcWVtdS90YXJnZXQtaW5mby5oDQo+ICsrKyBiL2luY2x1
ZGUvcWVtdS90YXJnZXQtaW5mby5oDQo+IEBAIC0yNCw0ICsyNCwxMSBAQCBjb25zdCBjaGFy
ICp0YXJnZXRfbmFtZSh2b2lkKTsNCj4gICAgKi8NCj4gICBjb25zdCBjaGFyICp0YXJnZXRf
bWFjaGluZV90eXBlbmFtZSh2b2lkKTsNCj4gICANCj4gKy8qKg0KPiArICogdGFyZ2V0X2Fh
cmNoNjQ6DQo+ICsgKg0KPiArICogUmV0dXJucyB3aGV0aGVyIHRoZSB0YXJnZXQgYXJjaGl0
ZWN0dXJlIGlzIEFhcmNoNjQuDQo+ICsgKi8NCj4gK2Jvb2wgdGFyZ2V0X2FhcmNoNjQodm9p
ZCk7DQo+ICsNCj4gICAjZW5kaWYNCj4gZGlmZiAtLWdpdCBhL3RhcmdldC1pbmZvLmMgYi90
YXJnZXQtaW5mby5jDQo+IGluZGV4IDAwNDI3NjllM2EyLi43ZjE3NThhZTM0ZiAxMDA2NDQN
Cj4gLS0tIGEvdGFyZ2V0LWluZm8uYw0KPiArKysgYi90YXJnZXQtaW5mby5jDQo+IEBAIC0x
OSwzICsxOSw4IEBAIGNvbnN0IGNoYXIgKnRhcmdldF9tYWNoaW5lX3R5cGVuYW1lKHZvaWQp
DQo+ICAgew0KPiAgICAgICByZXR1cm4gdGFyZ2V0X2luZm8oKS0+bWFjaGluZV90eXBlbmFt
ZTsNCj4gICB9DQo+ICsNCj4gK2Jvb2wgdGFyZ2V0X2FhcmNoNjQodm9pZCkNCj4gK3sNCj4g
KyAgICByZXR1cm4gdGFyZ2V0X2luZm8oKS0+dGFyZ2V0X2FyY2ggPT0gU1lTX0VNVV9UQVJH
RVRfQUFSQ0g2NDsNCj4gK30NCg0KUmV2aWV3ZWQtYnk6IFBpZXJyaWNrIEJvdXZpZXIgPHBp
ZXJyaWNrLmJvdXZpZXJAbGluYXJvLm9yZz4NCg0K

