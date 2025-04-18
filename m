Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90FB5C369AB
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Apr 2025 17:07:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u5pBF-0008DD-1E; Fri, 18 Apr 2025 13:07:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u5pBC-0008Cb-Ja
 for qemu-devel@nongnu.org; Fri, 18 Apr 2025 13:07:06 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u5pBA-0005ZE-1k
 for qemu-devel@nongnu.org; Fri, 18 Apr 2025 13:07:06 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-22409077c06so29572645ad.1
 for <qemu-devel@nongnu.org>; Fri, 18 Apr 2025 10:07:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744996022; x=1745600822; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ym4m9hx/Ec9slrCL/pQw0QFF9kF9kzWnib9M8H9pHuM=;
 b=Anv04anQlok9D14cYdSKGTdwenDd6hsdA8kTJQ21vGw9T6k7NskapoGDYcT9qVT5VK
 uhNmApmmx23lmsjD1c3/o+pmo7nh8NVN2YdLD3bMsT1a7U11kL3ROUmOyRre1zNx3fwz
 7tX/SBzzE2QKYToFPdmYpJOAQHC3GWqePw9DwWT9mt4otBLV4hnzBhvd5NrBlnnCJB1w
 UvD7nJQUjSZr0AeDfl3gsdnzmKt+zuhQUqKCoALanDaF86SShYIyqSPXD9AAZYUQ7dQC
 PvKYGCOoozWEQhmzzrrp/KzSQdc2oyJRHaxPo//bdoLDa1e7RigahqnNJeS6qlQ0Se1c
 Q2jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744996022; x=1745600822;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ym4m9hx/Ec9slrCL/pQw0QFF9kF9kzWnib9M8H9pHuM=;
 b=d13buYlcXbyn23iUS5mUlw2ihkyJN9Muz9r/9a+cSZSl4zyVHrWT4F73jxBZbZ/XiN
 o5LAHr2ZtOa0mivyGx3BTQEXr0mbYbrCmpWIux6yP1vBXdn6/4gr6e+uQ3NiIRXobBeW
 M79aJoWjphbzhxtZ0WtkK+TPO6NZzfaz32J0mtZBW3vZZ++RvdqwH4/ttnE8MMN4WDKK
 ApnMbAFIpX2bkA1TAOf6N6DOuEoAdy6a0uTtK5h6uHPGmbzWc2UcIEWK+nyaHXrOoRMJ
 qOHjbIlxOIUrnoV3pBTFNz1kFtJvci8CRPAEZIT30Ikp4XjNvEw2YBdtwW3VVg9xNGUJ
 C88w==
X-Forwarded-Encrypted: i=1;
 AJvYcCW4HFTVR6YFwjEMF8eiTaEGXsG04J6uNoO10n2j4cYQcuLP8o+2dpkNILzgL4fnPjie7a+9ALI9CMJZ@nongnu.org
X-Gm-Message-State: AOJu0YzXCQmeJ3nipXTJw4C2nOilQ7vT0QfDd1MKvxpirkPHJo/KB7Qj
 MxrJnvX1A99Tr3B4zgbkf/41kG0LpEv7UYeEqcvVe10E+kbpik3OwSPJPGAdFkU=
X-Gm-Gg: ASbGncuPBYYt91KvWE8Wr8ReTGJ2JnefPNgg8FhwbaMLx+Azcz+P3QKoPbzf0ZFJgYl
 XBKqEXaSp8Hn5LfrJCw+y49g397KBpzLsqLZmKYwCTM1BsXtbuZOArQ2qKUWxlcp+JF9QYgAfRW
 0tG/xt5x7yJGpOBygTuiacTAurHYo7HXXFDbvzvB6HKrz+fgIMlGCbk3ebDgBvw2PY+S4CJM1UM
 wC8IMu/qZLtQJdQ/4ckguHrcYi2tQFb1z0/2NVA+1kzjQap2cfaf3VMVh36o8+gXSu+YGXARPCj
 KKug6FRO0z4Gq68WKdOqqijf0bJDFb1gys3zFoNKZBIc7nZaSm/bEA==
X-Google-Smtp-Source: AGHT+IHvqiznADCvc2J6Kq4L7YummyM5rPxL4IDiGqUbc2p27NoBtP9sGQ4dbygO/ENgKFKxiAMRXA==
X-Received: by 2002:a17:902:d4ce:b0:21f:164d:93fe with SMTP id
 d9443c01a7336-22c53621ac3mr43860495ad.53.1744996022371; 
 Fri, 18 Apr 2025 10:07:02 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22c50eceb5asm19070955ad.172.2025.04.18.10.07.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 18 Apr 2025 10:07:01 -0700 (PDT)
Message-ID: <be5d6d8f-b0df-4295-a2d3-16b5caef1eb0@linaro.org>
Date: Fri, 18 Apr 2025 10:07:01 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 04/11] hw/arm: Register TYPE_TARGET_ARM/AARCH64_CPU
 QOM interfaces
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20250418005059.4436-1-philmd@linaro.org>
 <20250418005059.4436-5-philmd@linaro.org>
 <ac98a60e-fa76-4460-a9fa-6f95dd35814d@linaro.org>
 <dcf13faa-31e8-4ae1-9d89-1990310d207d@linaro.org>
 <dc052898-e075-4e1e-ae45-e3e47f41caae@linaro.org>
 <11f622cc-e57f-423c-91ae-6301bb3f055a@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <11f622cc-e57f-423c-91ae-6301bb3f055a@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62a.google.com
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

T24gNC8xOC8yNSAxMDowNCwgUGhpbGlwcGUgTWF0aGlldS1EYXVkw6kgd3JvdGU6DQo+IE9u
IDE4LzQvMjUgMTg6MzAsIFBpZXJyaWNrIEJvdXZpZXIgd3JvdGU6DQo+PiBPbiA0LzE4LzI1
IDA3OjA3LCBQaGlsaXBwZSBNYXRoaWV1LURhdWTDqSB3cm90ZToNCj4+PiBPbiAxOC80LzI1
IDA1OjA3LCBQaWVycmljayBCb3V2aWVyIHdyb3RlOg0KPj4+PiBPbiA0LzE3LzI1IDE3OjUw
LCBQaGlsaXBwZSBNYXRoaWV1LURhdWTDqSB3cm90ZToNCj4+Pj4+IERlZmluZSB0aGUgVFlQ
RV9UQVJHRVRfQVJNX01BQ0hJTkUgYW5kIFRZUEVfVEFSR0VUX0FBUkNINjRfTUFDSElORQ0K
Pj4+Pj4gUU9NIGludGVyZmFjZSBuYW1lcyB0byBhbGxvdyBtYWNoaW5lcyB0byBpbXBsZW1l
bnQgdGhlbS4NCj4+Pj4+DQo+Pj4+PiBTaWduZWQtb2ZmLWJ5OiBQaGlsaXBwZSBNYXRoaWV1
LURhdWTDqSA8cGhpbG1kQGxpbmFyby5vcmc+DQo+Pj4+PiAtLS0NCj4+Pj4+ICDCoMKgIG1l
c29uLmJ1aWxkwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKgIDEg
Kw0KPj4+Pj4gIMKgwqAgaW5jbHVkZS9ody9ib2FyZHMuaMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgfMKgIDEgKw0KPj4+Pj4gIMKgwqAgaW5jbHVkZS9xZW11L3RhcmdldF9pbmZvLXFvbS5o
IHwgMTggKysrKysrKysrKysrKysrKysrDQo+Pj4+PiAgwqDCoCB0YXJnZXRfaW5mby1xb20u
Y8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHwgMjQgKysrKysrKysrKysrKysrKysrKysr
KysrDQo+Pj4+PiAgwqDCoCA0IGZpbGVzIGNoYW5nZWQsIDQ0IGluc2VydGlvbnMoKykNCj4+
Pj4+ICDCoMKgIGNyZWF0ZSBtb2RlIDEwMDY0NCBpbmNsdWRlL3FlbXUvdGFyZ2V0X2luZm8t
cW9tLmgNCj4+Pj4+ICDCoMKgIGNyZWF0ZSBtb2RlIDEwMDY0NCB0YXJnZXRfaW5mby1xb20u
Yw0KPj4+Pj4NCj4+Pj4+IGRpZmYgLS1naXQgYS9tZXNvbi5idWlsZCBiL21lc29uLmJ1aWxk
DQo+Pj4+PiBpbmRleCA0OWEwNTBhMjhhMy4uMTY4YjA3YjU4ODcgMTAwNjQ0DQo+Pj4+PiAt
LS0gYS9tZXNvbi5idWlsZA0KPj4+Pj4gKysrIGIvbWVzb24uYnVpbGQNCj4+Pj4+IEBAIC0z
ODA4LDYgKzM4MDgsNyBAQCBjb21tb25fc3MuYWRkKHBhZ2V2YXJ5KQ0KPj4+Pj4gIMKgwqAg
c3BlY2lmaWNfc3MuYWRkKGZpbGVzKCdwYWdlLXRhcmdldC5jJywgJ3BhZ2UtdmFyeS10YXJn
ZXQuYycpKQ0KPj4+Pj4gIMKgwqAgY29tbW9uX3NzLmFkZChmaWxlcygndGFyZ2V0X2luZm8u
YycpKQ0KPj4+Pj4gK3N5c3RlbV9zcy5hZGQoZmlsZXMoJ3RhcmdldF9pbmZvLXFvbS5jJykp
DQo+Pj4+PiAgwqDCoCBzcGVjaWZpY19zcy5hZGQoZmlsZXMoJ3RhcmdldF9pbmZvLXN0dWIu
YycpKQ0KPj4+Pj4gIMKgwqAgc3ViZGlyKCdiYWNrZW5kcycpDQo+Pj4+PiBkaWZmIC0tZ2l0
IGEvaW5jbHVkZS9ody9ib2FyZHMuaCBiL2luY2x1ZGUvaHcvYm9hcmRzLmgNCj4+Pj4+IGlu
ZGV4IDAyZjQzYWM1ZDRkLi5iMWJiZjNjMzRkNCAxMDA2NDQNCj4+Pj4+IC0tLSBhL2luY2x1
ZGUvaHcvYm9hcmRzLmgNCj4+Pj4+ICsrKyBiL2luY2x1ZGUvaHcvYm9hcmRzLmgNCj4+Pj4+
IEBAIC03LDYgKzcsNyBAQA0KPj4+Pj4gIMKgwqAgI2luY2x1ZGUgInN5c3RlbS9ob3N0bWVt
LmgiDQo+Pj4+PiAgwqDCoCAjaW5jbHVkZSAic3lzdGVtL2Jsb2NrZGV2LmgiDQo+Pj4+PiAg
wqDCoCAjaW5jbHVkZSAicWFwaS9xYXBpLXR5cGVzLW1hY2hpbmUuaCINCj4+Pj4+ICsjaW5j
bHVkZSAicWVtdS90YXJnZXRfaW5mby1xb20uaCINCj4+Pj4+ICDCoMKgICNpbmNsdWRlICJx
ZW11L21vZHVsZS5oIg0KPj4+Pj4gIMKgwqAgI2luY2x1ZGUgInFvbS9vYmplY3QuaCINCj4+
Pj4+ICDCoMKgICNpbmNsdWRlICJody9jb3JlL2NwdS5oIg0KPj4+Pj4gZGlmZiAtLWdpdCBh
L2luY2x1ZGUvcWVtdS90YXJnZXRfaW5mby1xb20uaCBiL2luY2x1ZGUvcWVtdS8NCj4+Pj4+
IHRhcmdldF9pbmZvLXFvbS5oDQo+Pj4+PiBuZXcgZmlsZSBtb2RlIDEwMDY0NA0KPj4+Pj4g
aW5kZXggMDAwMDAwMDAwMDAuLjdlYjliNmJkMjU0DQo+Pj4+PiAtLS0gL2Rldi9udWxsDQo+
Pj4+PiArKysgYi9pbmNsdWRlL3FlbXUvdGFyZ2V0X2luZm8tcW9tLmgNCj4+Pj4+IEBAIC0w
LDAgKzEsMTggQEANCj4+Pj4+ICsvKg0KPj4+Pj4gKyAqIFFFTVUgYmluYXJ5L3RhcmdldCBB
UEkgKFFPTSB0eXBlcykNCj4+Pj4+ICsgKg0KPj4+Pj4gKyAqwqAgQ29weXJpZ2h0IChjKSBM
aW5hcm8NCj4+Pj4+ICsgKg0KPj4+Pj4gKyAqIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBH
UEwtMi4wLW9yLWxhdGVyDQo+Pj4+PiArICovDQo+Pj4+PiArDQo+Pj4+PiArI2lmbmRlZiBR
RU1VX1RBUkdFVF9JTkZPX1FPTV9IDQo+Pj4+PiArI2RlZmluZSBRRU1VX1RBUkdFVF9JTkZP
X1FPTV9IDQo+Pj4+PiArDQo+Pj4+PiArI2RlZmluZSBUWVBFX1RBUkdFVF9BUk1fTUFDSElO
RSBcDQo+Pj4+PiArwqDCoMKgwqDCoMKgwqAgInRhcmdldC1pbmZvLWFybS1tYWNoaW5lIg0K
Pj4+Pj4gKw0KPj4+Pj4gKyNkZWZpbmUgVFlQRV9UQVJHRVRfQUFSQ0g2NF9NQUNISU5FIFwN
Cj4+Pj4+ICvCoMKgwqDCoMKgwqDCoCAidGFyZ2V0LWluZm8tYWFyY2g2NC1tYWNoaW5lIg0K
Pj4+Pj4gKw0KPj4+Pj4gKyNlbmRpZg0KPj4+Pj4gZGlmZiAtLWdpdCBhL3RhcmdldF9pbmZv
LXFvbS5jIGIvdGFyZ2V0X2luZm8tcW9tLmMNCj4+Pj4+IG5ldyBmaWxlIG1vZGUgMTAwNjQ0
DQo+Pj4+PiBpbmRleCAwMDAwMDAwMDAwMC4uZDNmZWU1NzM2MWINCj4+Pj4+IC0tLSAvZGV2
L251bGwNCj4+Pj4+ICsrKyBiL3RhcmdldF9pbmZvLXFvbS5jDQo+Pj4+PiBAQCAtMCwwICsx
LDI0IEBADQo+Pj4+PiArLyoNCj4+Pj4+ICsgKiBRRU1VIGJpbmFyeS90YXJnZXQgQVBJIChR
T00gdHlwZXMpDQo+Pj4+PiArICoNCj4+Pj4+ICsgKsKgIENvcHlyaWdodCAoYykgTGluYXJv
DQo+Pj4+PiArICoNCj4+Pj4+ICsgKiBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIu
MC1vci1sYXRlcg0KPj4+Pj4gKyAqLw0KPj4+Pj4gKw0KPj4+Pj4gKyNpbmNsdWRlICJxZW11
L29zZGVwLmgiDQo+Pj4+PiArI2luY2x1ZGUgInFlbXUvdGFyZ2V0X2luZm8tcW9tLmgiDQo+
Pj4+PiArI2luY2x1ZGUgInFvbS9vYmplY3QuaCINCj4+Pj4+ICsNCj4+Pj4+ICtzdGF0aWMg
Y29uc3QgVHlwZUluZm8gdGFyZ2V0X2luZm9fdHlwZXNbXSA9IHsNCj4+Pj4+ICvCoMKgwqAg
ew0KPj4+Pj4gK8KgwqDCoMKgwqDCoMKgIC5uYW1lwqDCoMKgwqDCoMKgwqDCoMKgwqAgPSBU
WVBFX1RBUkdFVF9BUk1fTUFDSElORSwNCj4+Pj4+ICvCoMKgwqDCoMKgwqDCoCAucGFyZW50
wqDCoMKgwqDCoMKgwqDCoCA9IFRZUEVfSU5URVJGQUNFLA0KPj4+Pj4gK8KgwqDCoCB9LA0K
Pj4+Pj4gK8KgwqDCoCB7DQo+Pj4+PiArwqDCoMKgwqDCoMKgwqAgLm5hbWXCoMKgwqDCoMKg
wqDCoMKgwqDCoCA9IFRZUEVfVEFSR0VUX0FBUkNINjRfTUFDSElORSwNCj4+Pj4+ICvCoMKg
wqDCoMKgwqDCoCAucGFyZW50wqDCoMKgwqDCoMKgwqDCoCA9IFRZUEVfSU5URVJGQUNFLA0K
Pj4+Pj4gK8KgwqDCoCB9LA0KPj4+Pj4gK307DQo+Pj4+PiArDQo+Pj4+PiArREVGSU5FX1RZ
UEVTKHRhcmdldF9pbmZvX3R5cGVzKQ0KPj4+Pg0KPj4+PiBJZGVhbGx5LCB0aGlzIHNob3Vs
ZCBiZSBpbiB0YXJnZXQvYXJtLCBhcyB0aGlzIHR5cGUgd2lsbCBvbmx5IGJlIHVzZWQgYnkN
Cj4+Pj4gYm9hcmRzIGluIGh3L2FybSwgYW5kIGJ5IHRoZSB0YXJnZXRfaW5mbyBzcGVjaWFs
aXphdGlvbi4NCj4+Pg0KPj4+IE5vdCB0aGUgd2F5IFFPTSB3b3JrcywgaW50ZXJmYWNlcyBt
dXN0IGJlIHJlZ2lzdGVyZWQsIHdoaWNoIGlzDQo+Pj4gd2h5IEkgdXNlIHRoaXMgY2VudHJh
bGl6ZWQgZmlsZS4gT3RoZXJ3aXNlIHdlIGdldDoNCj4+Pg0KPj4+ICQgcWVtdS1zeXN0ZW0t
c2g0IC1NIGhlbHANCj4+PiBxZW11LXN5c3RlbS1zaDQ6IC1NIGhlbHA6IG1pc3NpbmcgaW50
ZXJmYWNlICd0YXJnZXQtaW5mby1hcm0tbWFjaGluZScNCj4+PiBmb3Igb2JqZWN0ICdtYWNo
aW5lJw0KPj4+DQo+Pg0KPj4gSWYgSSdtIGNvcnJlY3QsIHR5cGVzIGNhbiBiZSByZWdpc3Rl
cmVkIGFueXdoZXJlLCBzaW5jZSB0aGV5IHJlbHkgb24NCj4+IHN0YXRpYyBpbml0aWFsaXpl
ciwgYnV0IGluIHFlbXUtc3lzdGVtLXNoNCwgaHcvYXJtIG9yIHRhcmdldC9hcm0gaXMgbm90
DQo+PiBsaW5rZWQsIHNvIGl0IGZhaWxzLg0KPj4gSSBndWVzcyB0aGlzIGlzIHRoZSBudWxs
IGJvYXJkIHRoYXQgaXMgY3JlYXRpbmcgdGhpcyBzaXR1YXRpb24sIHNpbmNlDQo+PiBpdCdz
IGluY2x1ZGVkIGJ5IGFsbCBiaW5hcmllcy4NCj4gDQo+IENvcnJlY3QuDQo+IA0KPj4gSSBz
ZWUgdHdvIHNvbHV0aW9ucyB3aGlsZSBzdGlsbCBtb3ZpbmcgdGhvc2UgdHlwZXMgaW4gdGFy
Z2V0L2FybToNCj4+IC0gaW5jbHVkZSB0aGlzIHR5cGUgZmlsZSBpbiBsaWJjb21tb24sIHNv
IGl0J3MgYWx3YXlzIGxpbmtlZC4NCj4+IC0gaW50cm9kdWNlIGEgbmV3IFRZUEVfVEFSR0VU
X0FMTF9NQUNISU5FLCBhbmQgYWx3YXlzIGluY2x1ZGUgaXQgaW4gbGlzdA0KPj4gb2YgbWFj
aGluZXMuIEJ1dCBJIHRoaW5rIGl0J3Mgbm90IHNvIGdvb2QgYXMgaXQgd291bGQgcmVxdWly
ZSB0byBkZWFsDQo+PiB3aXRoIGEgbGlzdCBvZiB0eXBlcyB3aGVuIHdlIHdhbnQgdG8gYWNj
ZXNzIGEgbWFjaGluZS4NCj4+DQo+PiBTbyBJIHdvdWxkIGp1c3QgbW92ZSB0aGUgZmlsZSBh
bmQgbGluayBpdCBpbmNvbmRpdG9ubmFsbHkgaW4gYWxsIGJpbmFyaWVzLg0KPiANCj4gV2hp
Y2ggZmlsZT8gdGFyZ2V0X2luZm8tcW9tLmMgaXMgYWxyZWFkeSBpbiBzeXN0ZW1fc3NbXS4N
Cg0KTW92ZSBleGlzdGluZyB0YXJnZXRfaW5mby1xb20gaW4gaW4gdGFyZ2V0L2FybS90YXJn
ZXRfaW5mb190eXBlcy5jLCBhbmQgDQphZGQgaXQgdG8gc3lzdGVtX3NzLCBpbnN0ZWFkIG9m
IGFybV9zcyBvciBhcm1fY29tbW9uX3NzLCBzbyBpdCdzIGFsd2F5cyANCmxpbmtlZC4NCg==


