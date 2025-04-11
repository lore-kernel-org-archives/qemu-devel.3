Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3835C36010
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Apr 2025 16:44:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u3HTt-0001NU-7U; Fri, 11 Apr 2025 12:43:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u3HTq-0001If-Ep
 for qemu-devel@nongnu.org; Fri, 11 Apr 2025 12:43:50 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u3HTo-0006Q3-HU
 for qemu-devel@nongnu.org; Fri, 11 Apr 2025 12:43:50 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-22438c356c8so26564925ad.1
 for <qemu-devel@nongnu.org>; Fri, 11 Apr 2025 09:43:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744389827; x=1744994627; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=yEehcKkEtvkrukIzx807jrlT1sua6l4Lwl0XwiVIqY8=;
 b=fDHQSkDuioMfl3QYGvYy8Vy7ZJSTmUH3++CKMeGRuXaEt1kiJhXRuX6BWpR0lWoMnr
 yFaNQLXrUvzUAR5OaIOQHsKMsPprqPPcJ6Z8s609xdGz8YENFo9KoU8BSMgarQPcLNhe
 WgQ9VXxLAaRghChuwUJLnQe9GRuTEKO7ALmsVqnnLlTl2iiwxxpwqzie6mdedUf0CSjV
 omUUYjEhcZ23Fg3YHLkxtK3GvR8+mWUMhkvcRBESTbxvLh7FdmjaWeFVbJKycEPuxCdh
 zdbzpkmhQ94JKexYMRumtweu4Y/63DlSl8GPS+rk5qnJXrvL/v+U/DGneQqTGdCJtOaI
 lGmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744389827; x=1744994627;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=yEehcKkEtvkrukIzx807jrlT1sua6l4Lwl0XwiVIqY8=;
 b=IQff0asb1spyYnT2SlhRNDOPKJ23QGxeaCHhqUgD//E+SsiYmzJEb2uoHlloka23cv
 dRP1ptKIIIf1wYDJhFz+KpbPbmxHIBWvCg9wvvnuLwaGwGWWKjkaQVlsQviN7Ue0GbCo
 41RgEXJGSNGmIHBOUqmC7duyf79n8Zv9nmPLwrUYJolA52UKFawPlCc74jEutea4jNne
 /AZs6ls4uArGXutaouXrq4R5Fd/eZf7O0PWqoo8fpdi44oPFTmaNY4Hm7H9VFw25RIQ8
 FXrr1QFYZ5J57HNwSH8r6UD6MdamuwTzwE5NQCxRL8CvodPZHHSlX1BwGtKQjwZVb0Y9
 xqyg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXgNrIH9JSpsTr7niJ7RbbAckIV/02r9Nx9BKD0sgTdKwpEx885Qkl9nwFWNOm18hxUWW9ZiY/w6hbk@nongnu.org
X-Gm-Message-State: AOJu0YyrUNHsZHWJHBa2qo3GNW1lBlcLeXQt3I8s/gw0AeoBnUWMCvUj
 eGUPvKfVCB2u3FtDWfNmlme0srABZ1zyt+vEkPs1ICCWaeDALLiI6WewIVGseXk=
X-Gm-Gg: ASbGncuifYpG/lVr3bXv+QSLJvQREkSwtK+4pKgYpDUJK3jd+tQinBPa/1eiwfgF96F
 mhmRPbwi5EU+k2kaqnnfBYO3pa2SP58Zyyd8CwDAgtXJQoyNSAGIJlE8zYxZ57okp3eDDglyHbv
 bwCw7iaaIDEtzGKO4hSz+CBcL6iA0FFVJbQJKjohZ1vpPPHvfE3PPtKhtQE3/mfTSrR2Ac9u3BM
 cSx5ede93JRkvoFkrxkbQ6HZB0cLNBecQXxXrZAo/AXIRfxADIXmTEM4BacBgSxLzuSIrjpJhld
 Ej7dhZCvre0UZ0QlcDuHVQu9hFtxEQCTg0j9oPAP+lcZwCxapDnPgg==
X-Google-Smtp-Source: AGHT+IGf54UMQ/WV03DIur+/XHnWpBL5Jn9QPVDaNn0xvv32LjsywHFJDgUYmDh0hVrTznsWUFFWkA==
X-Received: by 2002:a17:902:ef0b:b0:21f:8453:7484 with SMTP id
 d9443c01a7336-22bea4c76cdmr51659035ad.30.1744389826716; 
 Fri, 11 Apr 2025 09:43:46 -0700 (PDT)
Received: from [192.168.1.87] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22ac7ccb5ddsm51718575ad.230.2025.04.11.09.43.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 11 Apr 2025 09:43:46 -0700 (PDT)
Message-ID: <7538bb41-cb6a-4a82-8535-3059f12e2f67@linaro.org>
Date: Fri, 11 Apr 2025 09:43:45 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] target/arm/ptw: extract arm_mmu_idx_to_security_space
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, alex.bennee@linaro.org,
 qemu-arm@nongnu.org, Yannis Bolliger <yannis.bolliger@protonmail.com>
References: <20250410210022.809905-1-pierrick.bouvier@linaro.org>
 <20250410210022.809905-2-pierrick.bouvier@linaro.org>
 <cea136fd-50a1-42be-98c6-e9550e85c1ed@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <cea136fd-50a1-42be-98c6-e9550e85c1ed@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x635.google.com
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

T24gNC8xMS8yNSAwNjo0NCwgUGhpbGlwcGUgTWF0aGlldS1EYXVkw6kgd3JvdGU6DQo+IE9u
IDEwLzQvMjUgMjM6MDAsIFBpZXJyaWNrIEJvdXZpZXIgd3JvdGU6DQo+PiBXZSdsbCByZXVz
ZSB0aGlzIGZ1bmN0aW9uIGxhdGVyLg0KPj4NCj4+IFNpZ25lZC1vZmYtYnk6IFBpZXJyaWNr
IEJvdXZpZXIgPHBpZXJyaWNrLmJvdXZpZXJAbGluYXJvLm9yZz4NCj4+IC0tLQ0KPj4gICAg
dGFyZ2V0L2FybS9wdHcuYyB8IDIxICsrKysrKysrKysrKysrLS0tLS0tLQ0KPj4gICAgMSBm
aWxlIGNoYW5nZWQsIDE0IGluc2VydGlvbnMoKyksIDcgZGVsZXRpb25zKC0pDQo+Pg0KPj4g
ZGlmZiAtLWdpdCBhL3RhcmdldC9hcm0vcHR3LmMgYi90YXJnZXQvYXJtL3B0dy5jDQo+PiBp
bmRleCA4ZDRlOWUwN2E5NC4uNWUxOTZjZmE5NTUgMTAwNjQ0DQo+PiAtLS0gYS90YXJnZXQv
YXJtL3B0dy5jDQo+PiArKysgYi90YXJnZXQvYXJtL3B0dy5jDQo+PiBAQCAtMzU1MCwxMyAr
MzU1MCw5IEBAIGJvb2wgZ2V0X3BoeXNfYWRkcl93aXRoX3NwYWNlX25vZ3BjKENQVUFSTVN0
YXRlICplbnYsIHZhZGRyIGFkZHJlc3MsDQo+PiAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgbWVtb3AsIHJlc3VsdCwgZmkpOw0KPj4gICAgfQ0KPj4gICAgDQo+PiAtYm9v
bCBnZXRfcGh5c19hZGRyKENQVUFSTVN0YXRlICplbnYsIHZhZGRyIGFkZHJlc3MsDQo+PiAt
ICAgICAgICAgICAgICAgICAgIE1NVUFjY2Vzc1R5cGUgYWNjZXNzX3R5cGUsIE1lbU9wIG1l
bW9wLCBBUk1NTVVJZHggbW11X2lkeCwNCj4+IC0gICAgICAgICAgICAgICAgICAgR2V0UGh5
c0FkZHJSZXN1bHQgKnJlc3VsdCwgQVJNTU1VRmF1bHRJbmZvICpmaSkNCj4+ICtzdGF0aWMg
QVJNU2VjdXJpdHlTcGFjZSBhcm1fbW11X2lkeF90b19zZWN1cml0eV9zcGFjZQ0KPj4gKyhD
UFVBUk1TdGF0ZSAqZW52LCBBUk1NTVVJZHggbW11X2lkeCkNCj4gDQo+IFN0eWxlIGlzOg0K
PiANCj4gc3RhdGljIEFSTVNlY3VyaXR5U3BhY2UgYXJtX21tdV9pZHhfdG9fc2VjdXJpdHlf
c3BhY2UoQ1BVQVJNU3RhdGUgKmVudiwNCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICBBUk1NTVVJZHggbW11X2lkeCkNCj4gDQo+
IG9yOg0KPiANCj4gc3RhdGljIEFSTVNlY3VyaXR5U3BhY2UNCj4gYXJtX21tdV9pZHhfdG9f
c2VjdXJpdHlfc3BhY2UoQ1BVQVJNU3RhdGUgKmVudiwgQVJNTU1VSWR4IG1tdV9pZHgpDQo+
IA0KDQpUaGFua3MsIEknbGwgdXBkYXRlIHRvIHRoaXMgb25lLg0KDQo+IFJldmlld2VkLWJ5
OiBQaGlsaXBwZSBNYXRoaWV1LURhdWTDqSA8cGhpbG1kQGxpbmFyby5vcmc+DQo+IA0KDQo=


