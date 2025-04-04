Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD6BCC36010
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Apr 2025 17:12:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0ka3-0003K8-Hw; Fri, 04 Apr 2025 13:11:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u0kZG-0002MU-Sk
 for qemu-devel@nongnu.org; Fri, 04 Apr 2025 13:10:59 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u0kZE-0005mv-4Z
 for qemu-devel@nongnu.org; Fri, 04 Apr 2025 13:10:58 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-2240b4de12bso32068275ad.2
 for <qemu-devel@nongnu.org>; Fri, 04 Apr 2025 10:10:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743786652; x=1744391452; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=kcEmttgYk8pLfZ6Q3kRpQITTsagP8XSOk0kncQGBrhU=;
 b=wXLR9FcYAhuJaBYob/qfSom/Fm59onBH4TySh7FtlRyHeBpRh49kVNGb8bd6Olkkit
 hOPJAu7zRpRJdRrPinyx5ISeMiGisF4ipNsklR8kpSXOC3sHUDcRKThe0edqClLS48UM
 mqFmW3InJZ4+cCnpQKfbBjs3I6IRUfBzd90h/v3KZaI8xZSWuKCL/LIc4VUCRsi0wKvu
 6lq49UJtXlB8o4ZN8ZPYnQHCLInIjG3hierzbt4e08oaaYzBrolLiEXC/8mbrrFYzNcn
 u4BFy8JVfngjn2VVLjQ2D+fnEYDJlm9okkMgI2PgS6fx3zE5PiGi4h+sGuCpd9N/1iSD
 K0gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743786652; x=1744391452;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=kcEmttgYk8pLfZ6Q3kRpQITTsagP8XSOk0kncQGBrhU=;
 b=vpsG674bZCK3ARZUwRIwdEpo+Yyt3//rO22tPTH44tIdcQO8xnAMsImP3MvhNTkGRr
 HQvo6f6vasbUQTFlBKiBFtwNWJOsTK/B+oABs5ZJ47S1qpbbMD9nicQQO/2ZrZOOpmEB
 dSikRJgdp5HHJlhU/6c/Dyz3geB/bnTO5byli4TyQcu1fY8ZbN/OWPl/L0tMeiZVoO+Z
 HFHzUy8f+DkOGttFQrEjm7O7zBt4MP5B4hvxbGGErq3cAbmnac7jSCoQdVCUGLE+fnsI
 nP8VsTvLNNjToShmQw/FEFvhIFyXqvTdbbZ9DxUuXsEPtXSyidkwx553xsKE9QnrpqLb
 zk7g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXKQ8WDVldFREhJ2YodYJ2kZJep2hKdlphC2mrnz2+wtuBQ/0huCZE7y5NMTEtzR3PlIqODlISqT6Rf@nongnu.org
X-Gm-Message-State: AOJu0YwOBhpx590HPEc+kY3WtsWG75WV2kwzOU+aGb+Qg8vJ6WwLv/1b
 45CsxQy5n9UqwrJOfoLZVISum5lEao3AixjJsMaFHcBfhjhFy8fb+0X3on53feG2IpQE0XWQYGF
 3
X-Gm-Gg: ASbGnct5naz54SSg95CepmxLuRJUCi8HHydZkvan3O/6ITAGLxEa8fjsBW8RhEg4u/2
 syQB56Sv2V8gD3HvXoj7vPPxRZG+Mqz/U3BoLsjU7/INYMSqfze+eVC/uLtPU7OiDh5XLU3wl7K
 iqrm6h0PtaaG7W7aALJJ/DDeqLyFZmL17U9SRTK84dpPYMXJCH9QaqGRZTpl9ZxqGqrfdBO11Df
 LsQA0G65wgTRdPkjc1LFvyB9oNqiTN7O0GRuKucP7CCJylyX6aXxln6FiezdRO4580cdw0JBS/M
 v6wsppDyKj8hT+wlZcFlv+HKr4sB8/1HJK6R1ywVzE1F21kH1msd9+9hC3Jw6p7SsZmM
X-Google-Smtp-Source: AGHT+IF+PZf4CnZepaV7km/2OTgfgCeKzu46nfZu4DPmHVQm0sj1kVk4EkmVaHjzAyUDNucojNBwHA==
X-Received: by 2002:a17:903:187:b0:224:1ef:1e00 with SMTP id
 d9443c01a7336-22a8a0556f1mr54549685ad.19.1743786652182; 
 Fri, 04 Apr 2025 10:10:52 -0700 (PDT)
Received: from [192.168.1.87] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-229785c0153sm34730435ad.65.2025.04.04.10.10.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 04 Apr 2025 10:10:51 -0700 (PDT)
Message-ID: <d81a6a09-69c8-4f07-9040-5e3fdd803b71@linaro.org>
Date: Fri, 4 Apr 2025 09:48:50 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH-for-10.1 09/19] qemu: Introduce target_cpu_type()
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20250403234914.9154-1-philmd@linaro.org>
 <20250403234914.9154-10-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250403234914.9154-10-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62d.google.com
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

T24gNC8zLzI1IDE2OjQ5LCBQaGlsaXBwZSBNYXRoaWV1LURhdWTDqSB3cm90ZToNCj4gU2ln
bmVkLW9mZi1ieTogUGhpbGlwcGUgTWF0aGlldS1EYXVkw6kgPHBoaWxtZEBsaW5hcm8ub3Jn
Pg0KPiAtLS0NCj4gICBpbmNsdWRlL3FlbXUvdGFyZ2V0X2luZm8taW1wbC5oIHwgMyArKysN
Cj4gICBpbmNsdWRlL3FlbXUvdGFyZ2V0X2luZm8uaCAgICAgIHwgMiArKw0KPiAgIHRhcmdl
dF9pbmZvLXN0dWIuYyAgICAgICAgICAgICAgfCAyICsrDQo+ICAgdGFyZ2V0X2luZm8uYyAg
ICAgICAgICAgICAgICAgICB8IDUgKysrKysNCj4gICA0IGZpbGVzIGNoYW5nZWQsIDEyIGlu
c2VydGlvbnMoKykNCj4gDQo+IGRpZmYgLS1naXQgYS9pbmNsdWRlL3FlbXUvdGFyZ2V0X2lu
Zm8taW1wbC5oIGIvaW5jbHVkZS9xZW11L3RhcmdldF9pbmZvLWltcGwuaA0KPiBpbmRleCA4
ZmE1ODVmODEzOC4uZDZkNjcxYTAzYzAgMTAwNjQ0DQo+IC0tLSBhL2luY2x1ZGUvcWVtdS90
YXJnZXRfaW5mby1pbXBsLmgNCj4gKysrIGIvaW5jbHVkZS9xZW11L3RhcmdldF9pbmZvLWlt
cGwuaA0KPiBAQCAtMzAsNiArMzAsOSBAQCBzdHJ1Y3QgQmluYXJ5VGFyZ2V0SW5mbyB7DQo+
ICAgICAgIC8qIHJ1bnRpbWUgZXF1aXZhbGVudCBvZiBUQVJHRVRfTE9OR19CSVRTIGRlZmlu
aXRpb24gKi8NCj4gICAgICAgdW5zaWduZWQgbG9uZ19iaXRzOw0KPiAgIA0KPiArICAgIC8q
IHJ1bnRpbWUgZXF1aXZhbGVudCBvZiBDUFVfUkVTT0xWSU5HX1RZUEUgZGVmaW5pdGlvbiAq
Lw0KPiArICAgIGNvbnN0IGNoYXIgKmNvbnN0IGNwdV9yZXNvbHZpbmdfdHlwZTsNCj4gKw0K
PiAgIH07DQo+ICAgDQo+ICAgI2VuZGlmDQo+IGRpZmYgLS1naXQgYS9pbmNsdWRlL3FlbXUv
dGFyZ2V0X2luZm8uaCBiL2luY2x1ZGUvcWVtdS90YXJnZXRfaW5mby5oDQo+IGluZGV4IDY2
YzQzYjMyOWNjLi40MDdjZTMyOGU4NSAxMDA2NDQNCj4gLS0tIGEvaW5jbHVkZS9xZW11L3Rh
cmdldF9pbmZvLmgNCj4gKysrIGIvaW5jbHVkZS9xZW11L3RhcmdldF9pbmZvLmgNCj4gQEAg
LTM0LDQgKzM0LDYgQEAgYm9vbCB0YXJnZXRfd29yZHNfYmlnZW5kaWFuKHZvaWQpOw0KPiAg
IA0KPiAgIHVuc2lnbmVkIHRhcmdldF9sb25nX2JpdHModm9pZCk7DQo+ICAgDQo+ICtjb25z
dCBjaGFyICp0YXJnZXRfY3B1X3R5cGUodm9pZCk7DQo+ICsNCj4gICAjZW5kaWYNCj4gZGlm
ZiAtLWdpdCBhL3RhcmdldF9pbmZvLXN0dWIuYyBiL3RhcmdldF9pbmZvLXN0dWIuYw0KPiBp
bmRleCBhNTM3NGNhZWQ2Yy4uN2QyMTY3NWQ0YzAgMTAwNjQ0DQo+IC0tLSBhL3RhcmdldF9p
bmZvLXN0dWIuYw0KPiArKysgYi90YXJnZXRfaW5mby1zdHViLmMNCj4gQEAgLTgsNiArOCw3
IEBADQo+ICAgDQo+ICAgI2luY2x1ZGUgInFlbXUvb3NkZXAuaCINCj4gICAjaW5jbHVkZSAi
cWVtdS90YXJnZXRfaW5mby1pbXBsLmgiDQo+ICsjaW5jbHVkZSAiY3B1LmgiDQo+ICAgDQo+
ICAgI2lmZGVmIFRBUkdFVF9JTkZPX1NUVUJfTkVFREVEDQo+ICAgDQo+IEBAIC0xNyw2ICsx
OCw3IEBAIHN0YXRpYyBjb25zdCBCaW5hcnlUYXJnZXRJbmZvIHRhcmdldF9pbmZvX3N0dWIg
PSB7DQo+ICAgICAgIC5zeXN0ZW1fYXJjaCA9IC0xLA0KPiAgICAgICAuZW5kaWFubmVzcyA9
IFRBUkdFVF9CSUdfRU5ESUFOID8gRU5ESUFOX01PREVfQklHIDogRU5ESUFOX01PREVfTElU
VExFLA0KPiAgICAgICAubG9uZ19iaXRzID0gVEFSR0VUX0xPTkdfQklUUywNCj4gKyAgICAu
Y3B1X3Jlc29sdmluZ190eXBlID0gQ1BVX1JFU09MVklOR19UWVBFLA0KPiAgIH07DQo+ICAg
DQo+ICAgY29uc3QgQmluYXJ5VGFyZ2V0SW5mbyAqdGFyZ2V0X2luZm8odm9pZCkNCj4gZGlm
ZiAtLWdpdCBhL3RhcmdldF9pbmZvLmMgYi90YXJnZXRfaW5mby5jDQo+IGluZGV4IDJmZDMy
OTMxZTEzLi40YWQyMDU2MzZjMiAxMDA2NDQNCj4gLS0tIGEvdGFyZ2V0X2luZm8uYw0KPiAr
KysgYi90YXJnZXRfaW5mby5jDQo+IEBAIC00MSwzICs0MSw4IEBAIHVuc2lnbmVkIHRhcmdl
dF9sb25nX2JpdHModm9pZCkNCj4gICB7DQo+ICAgICAgIHJldHVybiB0YXJnZXRfaW5mbygp
LT5sb25nX2JpdHM7DQo+ICAgfQ0KPiArDQo+ICtjb25zdCBjaGFyICp0YXJnZXRfY3B1X3R5
cGUodm9pZCkNCj4gK3sNCj4gKyAgICByZXR1cm4gdGFyZ2V0X2luZm8oKS0+Y3B1X3Jlc29s
dmluZ190eXBlOw0KPiArfQ0KDQpSZXZpZXdlZC1ieTogUGllcnJpY2sgQm91dmllciA8cGll
cnJpY2suYm91dmllckBsaW5hcm8ub3JnPg0KDQo=

