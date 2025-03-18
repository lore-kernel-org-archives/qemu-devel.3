Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C9F3C282EC
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Mar 2025 22:02:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuf0h-0005bq-4A; Tue, 18 Mar 2025 18:02:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tuf0f-0005bP-0q
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 18:02:05 -0400
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tuf0d-0007hq-7n
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 18:02:04 -0400
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-301918a4e3bso4791353a91.3
 for <qemu-devel@nongnu.org>; Tue, 18 Mar 2025 15:02:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742335321; x=1742940121; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=H1ma9eYDFTQwEAmIoEMN4Tv/PH0ALZLbCTLzoj3VnYo=;
 b=tT8r9jKoQsVTreG1a94FKMqGMz9mWDmMDmOlY8Fo9t3PW7NeGlEAUvGxAAnv3LGMYk
 eZdMcH2r3eZkNXDwymVWkUPo6/Sstw7iemGiInemPcWd2ei/sbPiVYOJ9UvyUDp4HZYn
 7pjBvhsOrkuMJ2Ew1dFRxtS2ODzp7arMImhzVbO6Za3grrvVEn/IKRM83nVxCeouyukS
 ETv02FU7bY+KtuMufCRT1xTz0rAG8ZUSkSU/EnDQ2kX3UxsWPUU6caA3WltUcfkLNug8
 H/d0dny1lmpz7n46w83BaJd+gB/1EdnjkydglCs0/NB0larcGVmhS3gVcECoKxQmFi9Y
 saPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742335321; x=1742940121;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=H1ma9eYDFTQwEAmIoEMN4Tv/PH0ALZLbCTLzoj3VnYo=;
 b=OhxD0k59KDEH9phjK5XtnWUD1jcisVUj3Rb8fWXwDs+uueL6/goTumx+LEUgepGzpf
 RtrR9W4wzaMWSmYnMbjPHNk0Essl8+p7yBhcJbpHAMh/gaFCXYIH8dasaHFb82srjC1l
 O/2nX7vr0HPPALGkUJyd0lnjYr+obOtMeYXaF+pCWsOLrVWNMGq/M1HC329ez7pb1mda
 N75kjdf134NAD8Av5XvH6RAAtt+9ExksRr/TzWxGfvXcanXhDFO3nSnlhKY2s/fwkZjz
 KF1G0mRzB2vJAs74eaXufAK9nZun918f2S32dx8WVaWw62mSzKcIB7aCaF4SsNVSQX1e
 E7sA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV0HOg0K7IrG0cy/+Zy889Zy8nLjYOTyYdYDuMdHYUAbm85npTJDAsEjUFRQO87dJQau5SyEXCOVpyJ@nongnu.org
X-Gm-Message-State: AOJu0YzOG9IBSxb+eTn6CD0ArFJZ96lV2d1PlBYUqq7QPalDgNZWGfPY
 69bmGcLfVt2y122PBN94G/9t64wJ4/zfEDiybX8nHYOsNYV7XozzmYeOX6h9y4I=
X-Gm-Gg: ASbGncv6k9fTfY+gAzkAA79s7PYNl+zkZjjnr6NAGCUMe+BoRF17k8wLZwBlsM9Lbjp
 ICuvRcaYB0EScMKgQLxjGrvaTrkneT5a3Ue7vaeBK3It8OqI6VvhACSLwjXrS1MpwItkyrRxaGU
 pMmhU5Q80ejeT8JRg67Ys1f3kJ6973DZNbMg4usHTxErOlqdgAdHSNlL3hjXT+G9YvK9YLIy2XI
 IrMvB6zYuRcRALPoXYj/Qqbqt1cnkFzSNhHGswTk7ePrAhUoCoQkMTCAOFhv/I5V0WS4o4Z868h
 5Nb4tuSq7eTo3dbZQHXCmE0ULNWb5NKx/tsMN/7Ck3IVDwnvEq+IRqdkbg==
X-Google-Smtp-Source: AGHT+IGA6xCelHZF+AcnCIa4FYtOlE+IfHizdWlF6wrWrLYDP61Pg/rKjIzimS7rzlvz3MmiPDdYTQ==
X-Received: by 2002:a17:90b:4b8e:b0:2ee:53b3:3f1c with SMTP id
 98e67ed59e1d1-301bde44515mr422400a91.5.1742335321248; 
 Tue, 18 Mar 2025 15:02:01 -0700 (PDT)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-301bf5a12fasm4355a91.24.2025.03.18.15.02.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Mar 2025 15:02:00 -0700 (PDT)
Message-ID: <52000c3d-827f-4e21-afa3-f191c6636b9d@linaro.org>
Date: Tue, 18 Mar 2025 15:02:00 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/13] target/arm/cpu: define ARM_MAX_VQ once for aarch32
 and aarch64
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-arm@nongnu.org, alex.bennee@linaro.org,
 Peter Maydell <peter.maydell@linaro.org>, kvm@vger.kernel.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
References: <20250318045125.759259-1-pierrick.bouvier@linaro.org>
 <20250318045125.759259-10-pierrick.bouvier@linaro.org>
 <a88f54cb-73be-4947-b3be-aa12b120f07e@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <a88f54cb-73be-4947-b3be-aa12b120f07e@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::1032;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x1032.google.com
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

T24gMy8xOC8yNSAxMTo1MCwgUGhpbGlwcGUgTWF0aGlldS1EYXVkw6kgd3JvdGU6DQo+IE9u
IDE4LzMvMjUgMDU6NTEsIFBpZXJyaWNrIEJvdXZpZXIgd3JvdGU6DQo+PiBUaGlzIHdpbGwg
YWZmZWN0IHpyZWdzIGZpZWxkIGZvciBhYXJjaDMyLg0KPj4gVGhpcyBmaWVsZCBpcyB1c2Vk
IGZvciBNVkUgYW5kIFNWRSBpbXBsZW1lbnRhdGlvbnMuIE1WRSBpbXBsZW1lbnRhdGlvbg0K
Pj4gaXMgY2xpcHBpbmcgaW5kZXggdmFsdWUgdG8gMCBvciAxIGZvciB6cmVnc1sqXS5kW10s
DQo+PiBzbyB3ZSBzaG91bGQgbm90IHRvdWNoIHRoZSByZXN0IG9mIGRhdGEgaW4gdGhpcyBj
YXNlIGFueXdheS4NCj4gDQo+IFdlIHNob3VsZCBkZXNjcmliZSB3aHkgaXQgaXMgc2FmZSBm
b3IgbWlncmF0aW9uLg0KPiANCj4gSS5lLiB2bXN0YXRlX3phIGRlcGVuZHMgb24gemFfbmVl
ZGVkKCkgLT4gU01FLCBub3QgaW5jbHVkZWQgaW4gMzItYml0DQo+IGNwdXMsIGV0Yy4NCj4g
DQo+IFNob3VsZCB3ZSB1cGRhdGUgdGFyZ2V0L2FybS9tYWNoaW5lLmMgaW4gdGhpcyBzYW1l
IHBhdGNoLCBvciBhDQo+IHByZWxpbWluYXJ5IG9uZT8NCj4gDQoNCnZtc3RhdGVfemEgZGVm
aW5pdGlvbiBhbmQgaW5jbHVzaW9uIGluIHZtc3RhdGVfYXJtX2NwdSBpcyB1bmRlciAjaWZk
ZWYgDQpUQVJHRVRfQUFSQ0g2NC4gSW4gdGhpcyBjYXNlIChUQVJHRVRfQUFSQ0g2NCksIEFS
TV9NQVhfVlEgd2FzIGFscmVhZHkgDQpkZWZpbmVkIGFzIDE2LCBzbyB0aGVyZSBzaG91bGQg
bm90IGJlIGFueSBjaGFuZ2UuDQoNCk90aGVyIHZhbHVlcyBkZXBlbmRpbmcgb24gQVJNX01B
WF9WUSwgZm9yIG1pZ3JhdGlvbiwgYXJlIGFzIHdlbGwgdW5kZXIgDQpUQVJHRVRfQUFSQ0g2
NCBpZmRlZnMgKHZtc3RhdGVfenJlZ19oaV9yZWcsIHZtc3RhdGVfcHJlZ19yZWcsIHZtc3Rh
dGVfdnJlZykuDQoNCkFuZCBmb3Igdm1zdGF0ZV92ZnAsIHdoaWNoIGlzIHByZXNlbnQgZm9y
IGFhcmNoMzIgYXMgd2VsbCwgdGhlIHNpemUgb2YgDQpkYXRhIHVuZGVyIGVhY2ggcmVnaXN0
ZXIgaXMgc3BlY2lmaWNhbGx5IHNldCB0byAyLg0KVk1TVEFURV9VSU5UNjRfU1VCX0FSUkFZ
KGVudi52ZnAuenJlZ3NbMF0uZCwgQVJNQ1BVLCAwLCAyKQ0KDQpTbyBldmVuIGlmIHN0b3Jh
Z2UgaGFzIG1vcmUgc3BhY2UsIGl0IHNob3VsZCBub3QgaW1wYWN0IGFueSB1c2FnZSBvZiBp
dC4NCg0KRXZlbiB0aG91Z2ggdGhpcyBjaGFuZ2UgaXMgdHJpdmlhbCwgSSBkaWRuJ3QgZG8g
aXQgYmxpbmRseSB0byAibWFrZSBpdCANCmNvbXBpbGUiIGFuZCBJIGNoZWNrZWQgdGhlIHZh
cmlvdXMgdXNhZ2VzIG9mIEFSTV9NQVhfVlEgYW5kIHpyZWdzLCBhbmQgSSANCmRpZG4ndCBz
ZWUgYW55dGhpbmcgdGhhdCBzZWVtcyB0byBiZSBhIHByb2JsZW0uDQoNCj4+DQo+PiBTaWdu
ZWQtb2ZmLWJ5OiBQaWVycmljayBCb3V2aWVyIDxwaWVycmljay5ib3V2aWVyQGxpbmFyby5v
cmc+DQo+PiAtLS0NCj4+ICAgIHRhcmdldC9hcm0vY3B1LmggfCA2ICstLS0tLQ0KPj4gICAg
MSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCA1IGRlbGV0aW9ucygtKQ0KPj4NCj4+
IGRpZmYgLS1naXQgYS90YXJnZXQvYXJtL2NwdS5oIGIvdGFyZ2V0L2FybS9jcHUuaA0KPj4g
aW5kZXggMjdhMGQ0NTUwZjIuLjAwZjc4ZDY0YmQ4IDEwMDY0NA0KPj4gLS0tIGEvdGFyZ2V0
L2FybS9jcHUuaA0KPj4gKysrIGIvdGFyZ2V0L2FybS9jcHUuaA0KPj4gQEAgLTE2OSwxMSAr
MTY5LDcgQEAgdHlwZWRlZiBzdHJ1Y3QgQVJNR2VuZXJpY1RpbWVyIHsNCj4+ICAgICAqIEFs
aWduIHRoZSBkYXRhIGZvciB1c2Ugd2l0aCBUQ0cgaG9zdCB2ZWN0b3Igb3BlcmF0aW9ucy4N
Cj4+ICAgICAqLw0KPj4gICAgDQo+PiAtI2lmZGVmIFRBUkdFVF9BQVJDSDY0DQo+PiAtIyBk
ZWZpbmUgQVJNX01BWF9WUSAgICAxNg0KPj4gLSNlbHNlDQo+PiAtIyBkZWZpbmUgQVJNX01B
WF9WUSAgICAxDQo+PiAtI2VuZGlmDQo+PiArI2RlZmluZSBBUk1fTUFYX1ZRICAgIDE2DQo+
PiAgICANCj4+ICAgIHR5cGVkZWYgc3RydWN0IEFSTVZlY3RvclJlZyB7DQo+PiAgICAgICAg
dWludDY0X3QgZFsyICogQVJNX01BWF9WUV0gUUVNVV9BTElHTkVEKDE2KTsNCj4gDQoNCg==


