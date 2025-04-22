Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40158C369D1
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Apr 2025 18:19:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7ID5-00068N-Hl; Tue, 22 Apr 2025 14:19:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u7ID3-00067g-VL
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 14:19:06 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u7ICz-0007OX-P4
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 14:19:03 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-227cf12df27so1740695ad.0
 for <qemu-devel@nongnu.org>; Tue, 22 Apr 2025 11:19:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745345940; x=1745950740; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=v2r29VSTGVoA+ne9mUHi7mcrbRcZzR9pHtxrFoOIZ8w=;
 b=Kt2Cg8CTTP2HEz4cuTxUA2dEXJImuaj3adsON+SbpkVBthuZMxwAWSq/OUNeBBdaKj
 cQ0PVjsKXK+l3ZvgV7A1rqD1G80Cc5j2Em+NuTpzUsVOlTdpwwx1PMS1LiiBnbTNO3bC
 0uQhkvRbkwtqy3i2qfG0vJrY+dGnSmV1OkbNcD5/R+0nbYTdUoQFW7vU9iuGvs+wakhy
 Ro3i/yL19YsVRBCcDHTBd+4IkDMaxyIgQEyzMJdcfy91nj0ttDp6JCBfSN9rZK0vmOyH
 RzU5hSgjJ6zDKqtN0eOz1QBqARoY4gt2Gnf/jQyLM5oCld+3pPt8lyOIcNVwviivptQw
 PBVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745345940; x=1745950740;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=v2r29VSTGVoA+ne9mUHi7mcrbRcZzR9pHtxrFoOIZ8w=;
 b=IkLMMtPnXomb+Bkp4aUcniwZ82I9gXLj6yiw6px5kexGn4oTuveDC5hd+rOb6ROvZr
 WO7rhqoViwLevjatZzAMPMzkwLIXxSEkZwU/iP80jvEeWS4pfe+4hPKoFFFiyV4+cZKP
 hYwU1m89gHb6Dg9GZWQQxJy7INGiZ0S8BwzeXJ0ibdJ2+5WePhVxNsbEtaSiDwlnqWkM
 NzZPEGzAi43lrxSM4e2h6DHYV+mLgO0iAczCUoWOIRH14lc2Pn/UP8ZSCTrp0fYExdrg
 fOmtrGVZcfLL3ghYgJT5ffjKMSc8fCfLt28wWjE8qkjIlGbRcPAzB9OMxnYUbnNb0VxY
 acGQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUxiwcamwnjPVKWZzLreLCFuYRSRF32xXlpjQU2e7tOoE+V9fqXmbDms8ocMRl2eFaB4wIH4mjAa9P1@nongnu.org
X-Gm-Message-State: AOJu0YwFGmkykMh6a74iUJfydgYbOoXzvDNUiHWrWK11lch/covxvJGU
 vuE/trn/0PlC0Glv5PMIw+tWbxjRNQAP2U0Nq5MHK2bGi8q8VZnBGdKrXiG8Gdo=
X-Gm-Gg: ASbGncufW//Uu9CWnrdpvKdJ8Z4uxG0Av3EVFAHHzIebwMEskRU+R2meFyDAGaQO8A7
 5a3kbgLPvOH4Hz2ZiNi617nkmq9KQGKprUjt8liyuX8JxrKEZ+Izbt0AUmbmVXwWzJLBaBacvSH
 hFNXKQTpkHfNxF2FOgJ2l51/2bFxUA2s5aZcX8KI7CaN3ok5Oyy6TVC3SwVF32vhjKe0yQ09k7d
 UALW091i04QW4rhDa8a/foo/HWFqYRmyBeQEx4U1bEy14SHzirxxohELUoZCZcfFgAu2dJj6SK7
 a3zRHtieYOoFmP83H7g1UEEm8QtTqiKpXUL3JjunVfxbjLJWHBwU3g==
X-Google-Smtp-Source: AGHT+IFZCxQB1Rp2pfrFdrtzX0VWwWeycx8rHlInv6BkwEN53dx3sSe0PZ/dEQItv1/uvyhmLPXFgA==
X-Received: by 2002:a17:903:2a86:b0:220:e91f:4408 with SMTP id
 d9443c01a7336-22c50d64436mr241700245ad.22.1745345940320; 
 Tue, 22 Apr 2025 11:19:00 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22c50eb4930sm88017195ad.139.2025.04.22.11.18.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Apr 2025 11:18:59 -0700 (PDT)
Message-ID: <4899ce29-9579-4999-8604-cabfe7210f55@linaro.org>
Date: Tue, 22 Apr 2025 11:18:59 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v4 13/19] hw/arm/virt: Check accelerator availability
 at runtime
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Anton Johansson <anjo@rev.ng>
References: <20250422145502.70770-1-philmd@linaro.org>
 <20250422145502.70770-14-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250422145502.70770-14-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62b.google.com
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

T24gNC8yMi8yNSAwNzo1NCwgUGhpbGlwcGUgTWF0aGlldS1EYXVkw6kgd3JvdGU6DQo+IFJl
cGxhY2UgY29tcGlsZS10aW1lIGNoZWNrIG9uIENPTkZJR197QUNDRUx9IGJ5DQo+IHJ1bnRp
bWUgY2hlY2sgb24ge2FjY2VsfV9lbmFibGVkKCkgaGVscGVycy4NCj4gDQoNCk1heWJlIHdl
IGNhbiBhZGQgaXQgdGhlIGRlc2NyaXB0aW9uIHdoeSBpdCB3b3Jrczogc2luY2UgDQpnZXRf
dmFsaWRfY3B1X3R5cGVzIGlzIGNhbGxlZCBhZnRlciBhY2NlbGVyYXRvciBpbml0aWFsaXph
dGlvbi4NCg0KcW1wX3hfZXhpdF9wcmVjb25maWcNCiAgICsgcWVtdV9pbml0X2JvYXJkDQog
ICAgICsgbWFjaGluZV9ydW5fYm9hcmRfaW5pdA0KICAgICAgICsgaXNfY3B1X3R5cGVfc3Vw
cG9ydGVkDQoNCndoaWNoIGlzIGNhbGxlZCBhZnRlcjoNCmNvbmZpZ3VyZV9hY2NlbGVyYXRv
cnMNCg0KSXQgd2FzIGFuIGlzc3VlIHdpdGggdGhlIGZpcnN0IGFwcHJvYWNoIGJ1aWxkaW5n
IHRoZSBsaXN0IGJlZm9yZSBtYWluKCksIA0Kc28gd29ydGggbWVudGlvbmluZy4NCg0KPiBT
aWduZWQtb2ZmLWJ5OiBQaGlsaXBwZSBNYXRoaWV1LURhdWTDqSA8cGhpbG1kQGxpbmFyby5v
cmc+DQo+IC0tLQ0KPiAgIGh3L2FybS92aXJ0LmMgfCA4ICsrKystLS0tDQo+ICAgMSBmaWxl
IGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYg
LS1naXQgYS9ody9hcm0vdmlydC5jIGIvaHcvYXJtL3ZpcnQuYw0KPiBpbmRleCBjNmFlN2Nj
MTcwNS4uZDcxOTc5NThmN2MgMTAwNjQ0DQo+IC0tLSBhL2h3L2FybS92aXJ0LmMNCj4gKysr
IGIvaHcvYXJtL3ZpcnQuYw0KPiBAQCAtMzEzNCw3ICszMTM0LDcgQEAgc3RhdGljIEdTTGlz
dCAqdmlydF9nZXRfdmFsaWRfY3B1X3R5cGVzKGNvbnN0IE1hY2hpbmVTdGF0ZSAqbXMpDQo+
ICAgew0KPiAgICAgICBHU0xpc3QgKnZjdCA9IE5VTEw7DQo+ICAgDQo+IC0jaWZkZWYgQ09O
RklHX1RDRw0KPiArICAgIGlmICh0Y2dfZW5hYmxlZCgpKSB7DQo+ICAgICAgICAgICB2Y3Qg
PSBnX3NsaXN0X3ByZXBlbmQodmN0LCBnX3N0cmR1cChBUk1fQ1BVX1RZUEVfTkFNRSgiY29y
dGV4LWE3IikpKTsNCj4gICAgICAgICAgIHZjdCA9IGdfc2xpc3RfcHJlcGVuZCh2Y3QsIGdf
c3RyZHVwKEFSTV9DUFVfVFlQRV9OQU1FKCJjb3J0ZXgtYTE1IikpKTsNCj4gICAjaWZkZWYg
VEFSR0VUX0FBUkNINjQNCj4gQEAgLTMxNDgsMTMgKzMxNDgsMTMgQEAgc3RhdGljIEdTTGlz
dCAqdmlydF9nZXRfdmFsaWRfY3B1X3R5cGVzKGNvbnN0IE1hY2hpbmVTdGF0ZSAqbXMpDQo+
ICAgICAgICAgICB2Y3QgPSBnX3NsaXN0X3ByZXBlbmQodmN0LCBnX3N0cmR1cChBUk1fQ1BV
X1RZUEVfTkFNRSgibmVvdmVyc2UtdjEiKSkpOw0KPiAgICAgICAgICAgdmN0ID0gZ19zbGlz
dF9wcmVwZW5kKHZjdCwgZ19zdHJkdXAoQVJNX0NQVV9UWVBFX05BTUUoIm5lb3ZlcnNlLW4y
IikpKTsNCj4gICAjZW5kaWYgLyogVEFSR0VUX0FBUkNINjQgKi8NCj4gLSNlbmRpZiAvKiBD
T05GSUdfVENHICovDQo+ICsgICAgfQ0KPiAgICNpZmRlZiBUQVJHRVRfQUFSQ0g2NA0KPiAg
ICAgICAgICAgdmN0ID0gZ19zbGlzdF9wcmVwZW5kKHZjdCwgZ19zdHJkdXAoQVJNX0NQVV9U
WVBFX05BTUUoImNvcnRleC1hNTMiKSkpOw0KPiAgICAgICAgICAgdmN0ID0gZ19zbGlzdF9w
cmVwZW5kKHZjdCwgZ19zdHJkdXAoQVJNX0NQVV9UWVBFX05BTUUoImNvcnRleC1hNTciKSkp
Ow0KPiAtI2lmIGRlZmluZWQoQ09ORklHX0tWTSkgfHwgZGVmaW5lZChDT05GSUdfSFZGKQ0K
PiArICAgICAgICBpZiAoa3ZtX2VuYWJsZWQoKSB8fCBodmZfZW5hYmxlZCgpKSB7DQo+ICAg
ICAgICAgICAgICAgdmN0ID0gZ19zbGlzdF9wcmVwZW5kKHZjdCwgZ19zdHJkdXAoQVJNX0NQ
VV9UWVBFX05BTUUoImhvc3QiKSkpOw0KPiAtI2VuZGlmIC8qIENPTkZJR19LVk0gfHwgQ09O
RklHX0hWRiAqLw0KPiArICAgICAgICB9DQo+ICAgI2VuZGlmIC8qIFRBUkdFVF9BQVJDSDY0
ICovDQo+ICAgICAgIHZjdCA9IGdfc2xpc3RfcHJlcGVuZCh2Y3QsIGdfc3RyZHVwKEFSTV9D
UFVfVFlQRV9OQU1FKCJtYXgiKSkpOw0KPiAgIA0KDQo=

