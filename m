Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48DD7C282EC
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Mar 2025 16:48:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpruP-0002Rr-Je; Wed, 05 Mar 2025 11:47:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tpruN-0002Qz-H4
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 11:47:47 -0500
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tpruK-00059m-A8
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 11:47:47 -0500
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-223f4c06e9fso17585235ad.1
 for <qemu-devel@nongnu.org>; Wed, 05 Mar 2025 08:47:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741193262; x=1741798062; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=yDTjrjl2lgL0PcFOS2hmGBgcSKflZXaPmkVfQZeqtdo=;
 b=vTrgq2iE+dgaWKeuw68CZvK1JJMniMKPCDWLr2lrZNw7S4cIFIXdZlQ9Cp1KTaOeLW
 OmBw2nJAeXKvSqQEsFVTGtIp8N3uxG4Q2ucB+k0WiOxaXILlL50zlqxodwuxedMhdXc3
 RtFbJOlyVUbk14IU1qO6ymOzqjLWSCdfFHct2g1qgCg678FEUaXFQDybqR00874DdCSn
 ap/NhWvL7YBaMJ4UP6aYMbZteCfRLZgBSZ6g/7DMjpGlsT4GnjedmF8M7lVJFt5o/qW1
 8oTQVmPTlm+UqRO2sm3N7xBNakC8ZogYjTV2JseftOy9RaJcQES6EDSy02M+byzjHLJE
 WLKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741193262; x=1741798062;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=yDTjrjl2lgL0PcFOS2hmGBgcSKflZXaPmkVfQZeqtdo=;
 b=sctAamGAITnz/Ma3cmHDPB2Rd4bg5p5JA8by+Wrh5YsfgXDuheM98Zc5eIxE0QYPqL
 kaOqcJqid5Q+FSMDC1gMOGgOZR98iOU6veCVbIRIOIGNXJrxSQg+/5wQhKyoLs74bMGH
 hKfATxmHrT5GWZqmFBFcE3KYw+X7ErCBiW+J305zuQqKhjSqx1RREnJtLxqKwHYYxbS3
 /ZPrXMmneELEFiERmu4D5xtVVqwSbgp62dzYJXbOYa3nF9NghEog5N7DIIKffb2IAFux
 xRC2uHcOiZrBeQFXIZhxNSzAxryGg0NDbRjapsqxpA0xCwTUZkQkkr47N/vu6xPwsgF4
 vbOg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXR3xTUDRCxKu5tAyUTCjVi6muMt/Y/3TMbshBJ/T9vryhF3mJssixQyRgUeUj/FTNcg8JrSfFhzGDe@nongnu.org
X-Gm-Message-State: AOJu0YzKctL0UQGwaMN06IfNCdwpCseawAJoz2Bmjq42THDTemkqtARY
 po21yVq/nK5mnK107e1nBD+jRJBEqP+FXnQFO9w/fBSGPOts3JqEkGK9QpmZmXI=
X-Gm-Gg: ASbGncswhUxbKP/5RVMAc6+1/tBsf/S0kpjAGRSxckxo/cxAk0BZWCa6aGNp1pOohHe
 XaRfuPsaGUBc7fUPJiWLUsRAIUxLdpRKHeiJWhebS3GEPr5y4G9fJMNo5FZIWoiyjgHYUMwnwr6
 0+KqtLaetxsNdXqhX7/P79PqYWby1M6OriTj1dX+1r00ruTcLRelyWN3zQC43K/HgH9Z0Tuy18P
 /xeHH17vJHrHmxn6AF1hi/ik+Z4ysv8c4wsEmCmRIQWRBhxf4isyucBeFiaK1JEhtJUgwykhygl
 mfjebcU6xvCsRTAvDwqKPe0NWlGXhgvQyqd5vZ8lJJ6uAUcavxnSaRWuAw==
X-Google-Smtp-Source: AGHT+IFvf6z4lu87G9ngKbVZnlrylTq1F7IyhWtdq6+xvfINUzGQbO9pnI4PpiA3ZW0lc6Bf5MZZOA==
X-Received: by 2002:a17:903:2302:b0:221:89e6:ccb6 with SMTP id
 d9443c01a7336-223f1e07b97mr71107725ad.25.1741193261838; 
 Wed, 05 Mar 2025 08:47:41 -0800 (PST)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-223501fae29sm115051435ad.95.2025.03.05.08.47.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 Mar 2025 08:47:41 -0800 (PST)
Message-ID: <62dcbd00-0bb6-43ff-998d-a07b85917c99@linaro.org>
Date: Wed, 5 Mar 2025 08:47:40 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/4] qom: Introduce TypeInfo::registerable() callback
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@kaod.org>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>
References: <20250305161248.54901-1-philmd@linaro.org>
 <20250305161248.54901-2-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250305161248.54901-2-philmd@linaro.org>
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

T24gMy81LzI1IDA4OjEyLCBQaGlsaXBwZSBNYXRoaWV1LURhdWTDqSB3cm90ZToNCj4gSW50
cm9kdWNlIHRoZSBUeXBlSW5mbzo6cmVnaXN0ZXJhYmxlKCkgY2FsbGJhY2sgdG8gYWxsb3cN
Cj4gcnVudGltZSBkZWNpc2lvbiBvbiB3aGV0aGVyIHJlZ2lzdGVyIGEgUU9NIHR5cGUgb3Ig
bm90Lg0KPiANCj4gU2lnbmVkLW9mZi1ieTogUGhpbGlwcGUgTWF0aGlldS1EYXVkw6kgPHBo
aWxtZEBsaW5hcm8ub3JnPg0KPiAtLS0NCj4gICBpbmNsdWRlL3FvbS9vYmplY3QuaCB8IDEg
Kw0KPiAgIHFvbS9vYmplY3QuYyAgICAgICAgIHwgNCArKysrDQo+ICAgcW9tL3RyYWNlLWV2
ZW50cyAgICAgfCAxICsNCj4gICAzIGZpbGVzIGNoYW5nZWQsIDYgaW5zZXJ0aW9ucygrKQ0K
PiANCj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvcW9tL29iamVjdC5oIGIvaW5jbHVkZS9xb20v
b2JqZWN0LmgNCj4gaW5kZXggOTE5MjI2NWRiNzYuLmYwNDY3OTFmNjBjIDEwMDY0NA0KPiAt
LS0gYS9pbmNsdWRlL3FvbS9vYmplY3QuaA0KPiArKysgYi9pbmNsdWRlL3FvbS9vYmplY3Qu
aA0KPiBAQCAtNDc2LDYgKzQ3Niw3IEBAIHN0cnVjdCBUeXBlSW5mbw0KPiAgIHsNCj4gICAg
ICAgY29uc3QgY2hhciAqbmFtZTsNCj4gICAgICAgY29uc3QgY2hhciAqcGFyZW50Ow0KPiAr
ICAgIGJvb2wgKCpyZWdpc3RlcmFibGUpKHZvaWQpOw0KPiAgIA0KPiAgICAgICBzaXplX3Qg
aW5zdGFuY2Vfc2l6ZTsNCj4gICAgICAgc2l6ZV90IGluc3RhbmNlX2FsaWduOw0KPiBkaWZm
IC0tZ2l0IGEvcW9tL29iamVjdC5jIGIvcW9tL29iamVjdC5jDQo+IGluZGV4IDAxNjE4ZDA2
YmQ4Li5jNjJiN2ZkMTY5NSAxMDA2NDQNCj4gLS0tIGEvcW9tL29iamVjdC5jDQo+ICsrKyBi
L3FvbS9vYmplY3QuYw0KPiBAQCAtMTY4LDYgKzE2OCwxMCBAQCBzdGF0aWMgVHlwZUltcGwg
KnR5cGVfcmVnaXN0ZXJfaW50ZXJuYWwoY29uc3QgVHlwZUluZm8gKmluZm8pDQo+ICAgICAg
ICAgICBmcHJpbnRmKHN0ZGVyciwgIlJlZ2lzdGVyaW5nICclcycgd2l0aCBpbGxlZ2FsIHR5
cGUgbmFtZVxuIiwgaW5mby0+bmFtZSk7DQo+ICAgICAgICAgICBhYm9ydCgpOw0KPiAgICAg
ICB9DQo+ICsgICAgaWYgKGluZm8tPnJlZ2lzdGVyYWJsZSAmJiAhaW5mby0+cmVnaXN0ZXJh
YmxlKCkpIHsNCj4gKyAgICAgICAgdHJhY2Vfb2JqZWN0X3JlZ2lzdGVyX3NraXBwZWQoaW5m
by0+bmFtZSk7DQo+ICsgICAgICAgIHJldHVybiBOVUxMOw0KPiArICAgIH0NCj4gICANCj4g
ICAgICAgdGkgPSB0eXBlX25ldyhpbmZvKTsNCj4gICANCj4gZGlmZiAtLWdpdCBhL3FvbS90
cmFjZS1ldmVudHMgYi9xb20vdHJhY2UtZXZlbnRzDQo+IGluZGV4IGIyZTlmNGE3MTI3Li4y
OWFmOTVkODUwNyAxMDA2NDQNCj4gLS0tIGEvcW9tL3RyYWNlLWV2ZW50cw0KPiArKysgYi9x
b20vdHJhY2UtZXZlbnRzDQo+IEBAIC0zLDMgKzMsNCBAQA0KPiAgICMgb2JqZWN0LmMNCj4g
ICBvYmplY3RfZHluYW1pY19jYXN0X2Fzc2VydChjb25zdCBjaGFyICp0eXBlLCBjb25zdCBj
aGFyICp0YXJnZXQsIGNvbnN0IGNoYXIgKmZpbGUsIGludCBsaW5lLCBjb25zdCBjaGFyICpm
dW5jKSAiJXMtPiVzICglczolZDolcykiDQo+ICAgb2JqZWN0X2NsYXNzX2R5bmFtaWNfY2Fz
dF9hc3NlcnQoY29uc3QgY2hhciAqdHlwZSwgY29uc3QgY2hhciAqdGFyZ2V0LCBjb25zdCBj
aGFyICpmaWxlLCBpbnQgbGluZSwgY29uc3QgY2hhciAqZnVuYykgIiVzLT4lcyAoJXM6JWQ6
JXMpIg0KPiArb2JqZWN0X3JlZ2lzdGVyX3NraXBwZWQoY29uc3QgY2hhciAqdHlwZSkgIk5v
dCByZWdpc3RlcmluZyAnJXMnIHR5cGUiDQoNClRoYXQncyBhIGdvb2Qgd2F5IHRvIGJlIGFi
bGUgdG8gc2VsZWN0IGF0IHJ1bnRpbWUgdGhlIG9iamVjdHMgZW5hYmxlZCwgDQpldmVuIHRo
b3VnaCB3ZSdsbCBoYXZlIGEgYmluYXJ5IHdpdGggYWxsIHFvbSBvYmplY3RzIGNvZGUgcHJl
c2VudC4NCg0KUmV2aWV3ZWQtYnk6IFBpZXJyaWNrIEJvdXZpZXIgPHBpZXJyaWNrLmJvdXZp
ZXJAbGluYXJvLm9yZz4NCg0K

