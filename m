Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93002C369C2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Apr 2025 18:24:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7IHb-0001gs-GY; Tue, 22 Apr 2025 14:23:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u7IHZ-0001gF-1u
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 14:23:45 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u7IHX-0000if-7N
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 14:23:44 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-227d6b530d8so57396325ad.3
 for <qemu-devel@nongnu.org>; Tue, 22 Apr 2025 11:23:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745346221; x=1745951021; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=uIyYniR+YYgUeEOA2UYynHwf9nbIqJwMJC1pVJ2+B+4=;
 b=AnCXP1FPCDuw3TI9HTg2P+EVF0sucvj2KZ63k31oCfSnJ3shh9lranuBzgFYXwtaP8
 3Y15N0JnL1giQm8/tpXHq+7gAnu1MOG35m70Gya/uNnvh057goMO1lVgh9ZDyU+EurDT
 0QxoEo4FehGwc7pTGe9ExA0wrQllrLIWou7iBd0TcqG/0ddkM1eLD3w1j5oYfSHDRZ89
 Pk6P2OnAZHBWYUaOxnvYlWcWAgbAk6nyfN/avcc1tau7wD79nUSLQkPqtiz9VR7wlQjh
 pPOLhVL+iAPrInFR92ID3NCFhXFvwyUOqp85KpmmdF2JrebtD/hyjDJ09V4JeeaZH39H
 ZRbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745346221; x=1745951021;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=uIyYniR+YYgUeEOA2UYynHwf9nbIqJwMJC1pVJ2+B+4=;
 b=C9W3pRM1gueHdXKwOwjNUa41NkUaGb61yzk2exzRHmTvOzoFtGEnf459PR7LlmEqQ+
 bcmGF846i9zewd2scGj2OD6KGMKJvg6R2Ud1URONQBHO4JMOLTY2ZyGNmMa176aX/OXq
 BO4Vk70X4/ZNUTXfRILrVVoiMwDuVQX6xNTbFHAm6dm5zs43UUXjFHe/UeXU6vgbM1YA
 IAUMeWtoIHYSh8IEiS8x+WePZRkGR0L4PWUs/szqB43f7ABVDbWfJU70p6i2XqfuTp/+
 21P46Sk4Oh+B+zMngEg9zR9jM8MCaCdEMdpblMYwKsytlu6UABsqsyE+/DcTqGoYHleu
 zWDw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUmNh3BRByNC5giNKEFOvoJZWXzGcwoiT9xvOERP6IntMOzq2NXKjWrTw89zBqvCi9rEnFSZpujDO1a@nongnu.org
X-Gm-Message-State: AOJu0YyHqEjgg1iMOQ5RFvym8zJlXfioRfQJz9ZN1kIzfIS9F3g/uJLv
 2F6nhOk5QNIKUK7nVjhj1NPT6kRNuGDRh2HvoOIy9PXGskb59+S28zWwdkKn8LrcvOOYWaYAswg
 n
X-Gm-Gg: ASbGncs10SLDpaqL7l6lfBjZ5ddTGt4Sg57TN9d0Gt+0+RT5lCkTqeZHriMNZDrIRmR
 WL6ZSRM6/FRNPmdeyHM8VuZFE/Tx0IDU3q+XrwY7wlW46psE89GI7WJE8wZ1hAW3M16z6IBZ9jY
 VXy6tpPibv6SLU5KX5vLBtV/3Ak2GWAXUHit4w5FNU3YdfNvpQe9bwJVku6HmH5X6VU0NGQn3Cp
 H4BR4S2CBced6M4i03q6ecqQNpp+8ywpDdYVnOdjlkWtQ768bmI4ffXuIh9aH6e6ya312qouR8i
 qeNRGYUca5FeCLY5AduQPFcb12PLQyr6YkO1p6l9AHy01/tnZKaD6A==
X-Google-Smtp-Source: AGHT+IHqWogPQqoOif0eZz2//SqMZZCiGYA5sjn4qwv8LRlQ2wOtO2NGthSvAPyLT72pUzHlEC1hnw==
X-Received: by 2002:a17:903:947:b0:223:517c:bfa1 with SMTP id
 d9443c01a7336-22c5360c7admr273800155ad.38.1745346221606; 
 Tue, 22 Apr 2025 11:23:41 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22d78db8b04sm65626945ad.238.2025.04.22.11.23.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Apr 2025 11:23:41 -0700 (PDT)
Message-ID: <b4c1839b-93ae-4c06-94c2-f22dc00f8b44@linaro.org>
Date: Tue, 22 Apr 2025 11:23:40 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v4 17/19] hw/core: Get default_cpu_type calling
 machine_class_default_cpu_type()
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Anton Johansson <anjo@rev.ng>
References: <20250422145502.70770-1-philmd@linaro.org>
 <20250422145502.70770-18-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250422145502.70770-18-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x629.google.com
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

T24gNC8yMi8yNSAwNzo1NCwgUGhpbGlwcGUgTWF0aGlldS1EYXVkw6kgd3JvdGU6DQo+IFNp
bmNlIGNvbW1pdCA2MmI0YTIyN2EzMyB0aGUgZGVmYXVsdCBjcHUgdHlwZSBjYW4gY29tZSBm
cm9tIHRoZQ0KPiB2YWxpZF9jcHVfdHlwZXNbXSBhcnJheS4gQ2FsbCB0aGUgbWFjaGluZV9j
bGFzc19kZWZhdWx0X2NwdV90eXBlKCkNCj4gaW5zdGVhZCBvZiBhY2Nlc3NpbmcgTWFjaGlu
ZUNsYXNzOjpkZWZhdWx0X2NwdV90eXBlIGZpZWxkLg0KPiANCj4gQ2M6IHFlbXUtc3RhYmxl
QG5vbmdudS5vcmcNCj4gRml4ZXM6IDYyYjRhMjI3YTMzICgiaHcvY29yZTogQWRkIG1hY2hp
bmVfY2xhc3NfZGVmYXVsdF9jcHVfdHlwZSgpIikNCj4gU2lnbmVkLW9mZi1ieTogUGhpbGlw
cGUgTWF0aGlldS1EYXVkw6kgPHBoaWxtZEBsaW5hcm8ub3JnPg0KPiAtLS0NCj4gQ2M6IEdh
dmluIFNoYW4gPGdzaGFuQHJlZGhhdC5jb20+DQo+IC0tLQ0KPiAgIGh3L2NvcmUvbWFjaGlu
ZS1xbXAtY21kcy5jIHwgNSArKystLQ0KPiAgIHRhcmdldC9wcGMvY3B1X2luaXQuYyAgICAg
IHwgMiArLQ0KPiAgIDIgZmlsZXMgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspLCAzIGRlbGV0
aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2h3L2NvcmUvbWFjaGluZS1xbXAtY21kcy5j
IGIvaHcvY29yZS9tYWNoaW5lLXFtcC1jbWRzLmMNCj4gaW5kZXggNTI5Y2U4ZGQ5YTAuLmE4
ZjhmOGM4MTM4IDEwMDY0NA0KPiAtLS0gYS9ody9jb3JlL21hY2hpbmUtcW1wLWNtZHMuYw0K
PiArKysgYi9ody9jb3JlL21hY2hpbmUtcW1wLWNtZHMuYw0KPiBAQCAtNzMsNiArNzMsNyBA
QCBNYWNoaW5lSW5mb0xpc3QgKnFtcF9xdWVyeV9tYWNoaW5lcyhib29sIGhhc19jb21wYXRf
cHJvcHMsIGJvb2wgY29tcGF0X3Byb3BzLA0KPiAgIA0KPiAgICAgICBmb3IgKGVsID0gbWFj
aGluZXM7IGVsOyBlbCA9IGVsLT5uZXh0KSB7DQo+ICAgICAgICAgICBNYWNoaW5lQ2xhc3Mg
Km1jID0gZWwtPmRhdGE7DQo+ICsgICAgICAgIGNvbnN0IGNoYXIgKmRlZmF1bHRfY3B1X3R5
cGUgPSBtYWNoaW5lX2NsYXNzX2RlZmF1bHRfY3B1X3R5cGUobWMpOw0KPiAgICAgICAgICAg
TWFjaGluZUluZm8gKmluZm87DQo+ICAgDQo+ICAgICAgICAgICBpbmZvID0gZ19tYWxsb2Mw
KHNpemVvZigqaW5mbykpOw0KPiBAQCAtOTEsOCArOTIsOCBAQCBNYWNoaW5lSW5mb0xpc3Qg
KnFtcF9xdWVyeV9tYWNoaW5lcyhib29sIGhhc19jb21wYXRfcHJvcHMsIGJvb2wgY29tcGF0
X3Byb3BzLA0KPiAgICAgICAgICAgaW5mby0+bnVtYV9tZW1fc3VwcG9ydGVkID0gbWMtPm51
bWFfbWVtX3N1cHBvcnRlZDsNCj4gICAgICAgICAgIGluZm8tPmRlcHJlY2F0ZWQgPSAhIW1j
LT5kZXByZWNhdGlvbl9yZWFzb247DQo+ICAgICAgICAgICBpbmZvLT5hY3BpID0gISFvYmpl
Y3RfY2xhc3NfcHJvcGVydHlfZmluZChPQkpFQ1RfQ0xBU1MobWMpLCAiYWNwaSIpOw0KPiAt
ICAgICAgICBpZiAobWMtPmRlZmF1bHRfY3B1X3R5cGUpIHsNCj4gLSAgICAgICAgICAgIGlu
Zm8tPmRlZmF1bHRfY3B1X3R5cGUgPSBnX3N0cmR1cChtYy0+ZGVmYXVsdF9jcHVfdHlwZSk7
DQo+ICsgICAgICAgIGlmIChkZWZhdWx0X2NwdV90eXBlKSB7DQo+ICsgICAgICAgICAgICBp
bmZvLT5kZWZhdWx0X2NwdV90eXBlID0gZ19zdHJkdXAoZGVmYXVsdF9jcHVfdHlwZSk7DQo+
ICAgICAgICAgICB9DQo+ICAgICAgICAgICBpZiAobWMtPmRlZmF1bHRfcmFtX2lkKSB7DQo+
ICAgICAgICAgICAgICAgaW5mby0+ZGVmYXVsdF9yYW1faWQgPSBnX3N0cmR1cChtYy0+ZGVm
YXVsdF9yYW1faWQpOw0KPiBkaWZmIC0tZ2l0IGEvdGFyZ2V0L3BwYy9jcHVfaW5pdC5jIGIv
dGFyZ2V0L3BwYy9jcHVfaW5pdC5jDQo+IGluZGV4IGEzZGZmMDgxNGQxLi4yYzBkYjJhMDVh
OSAxMDA2NDQNCj4gLS0tIGEvdGFyZ2V0L3BwYy9jcHVfaW5pdC5jDQo+ICsrKyBiL3Rhcmdl
dC9wcGMvY3B1X2luaXQuYw0KPiBAQCAtNzA4MSw3ICs3MDgxLDcgQEAgT2JqZWN0Q2xhc3Mg
KnBwY19jcHVfY2xhc3NfYnlfbmFtZShjb25zdCBjaGFyICpuYW1lKQ0KPiAgICAgICBpZiAo
c3RyY21wKG5hbWUsICJtYXgiKSA9PSAwKSB7DQo+ICAgICAgICAgICBNYWNoaW5lQ2xhc3Mg
Km1jID0gTUFDSElORV9HRVRfQ0xBU1MocWRldl9nZXRfbWFjaGluZSgpKTsNCj4gICAgICAg
ICAgIGlmIChtYykgew0KPiAtICAgICAgICAgICAgcmV0dXJuIG9iamVjdF9jbGFzc19ieV9u
YW1lKG1jLT5kZWZhdWx0X2NwdV90eXBlKTsNCj4gKyAgICAgICAgICAgIHJldHVybiBvYmpl
Y3RfY2xhc3NfYnlfbmFtZShtYWNoaW5lX2NsYXNzX2RlZmF1bHRfY3B1X3R5cGUobWMpKTsN
Cj4gICAgICAgICAgIH0NCj4gICAgICAgfQ0KPiAgICNlbmRpZg0KDQpSZXZpZXdlZC1ieTog
UGllcnJpY2sgQm91dmllciA8cGllcnJpY2suYm91dmllckBsaW5hcm8ub3JnPg0KDQo=

