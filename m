Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09F00C3601A
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Apr 2025 17:12:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0kZn-0002aU-JT; Fri, 04 Apr 2025 13:11:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u0kZG-0002MS-SN
 for qemu-devel@nongnu.org; Fri, 04 Apr 2025 13:10:59 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u0kZE-0005n1-0p
 for qemu-devel@nongnu.org; Fri, 04 Apr 2025 13:10:58 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-2264aefc45dso31998385ad.0
 for <qemu-devel@nongnu.org>; Fri, 04 Apr 2025 10:10:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743786653; x=1744391453; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=0JK4E+HrqtO+4FICESU8gzxak/yV4IOTh3wqWaVYBrE=;
 b=y2tVBI5n3yHbECl2/NsumKW1J8KD4JGQQj500sTiq7p3vYwFZpPcdsXz8EvZn4fc6/
 TX9ArjFGTiEzbnw0jqrdMNo+LAw6cWunyufEYQflS5IxT1RzmynoeVAXmmkihpXi1HHV
 LWsDumUw+DzAO5Qtr5eWc5C7gXKiGMIH1MBitEW/n1UUiXJfyYLEC8CkaNalfLdVJnIq
 f64pyCENWMoh1ffEAp3rIYoSOcoYr711f2t9n1Dt/l1FezGezyikwkVvRIEmDkjnVIC8
 8BASRuqH32lbt04ZV4XWzoj8RzbhOELlxjS5RcO2YuY4mLxApFq9ESJYBbuC3OffGxHq
 kv5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743786653; x=1744391453;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0JK4E+HrqtO+4FICESU8gzxak/yV4IOTh3wqWaVYBrE=;
 b=rfkVwIZ9bof7UniUnu3/dAXYe1/x3pRgugNPWtC6tIPCRc0FHXC0rW/ZIhgjgdFv/k
 i1mVFBpMuTIZ+4QwVA3o9R4WmG++hQIJHY3jMLZcIVzMnXF7FeGdIEF22Nlqo+LA2/e3
 AlfQlctlEj/4DSNNH431qtS8/8LPnV6Z7/G01XMoswHIBb28BskjyyeD4pNfdzd2MYJB
 OX5N3lU4Oq2Icxx7Ulnzs1QTr1EHIc4RlRmJsMPS3nojPTcBMumplnhUeYaWZfp5lZYF
 Y5I9X3WaExlGW3qOJSq9rTMw/0AQHL2Xc0/pctaTDPArmmhLYrl0c/84Nz/odSjxehlU
 DZKg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUS6D7LxekgcPnfFPyhV1qzhLk3EUrlVCIu9aqHtVNyRrlz9xCZAAYejE/ktk1qAYqPsBrMI5MJMKBp@nongnu.org
X-Gm-Message-State: AOJu0YzK6R6UoIhd308nBdwMnNJqehuJuBFsc5jPHZT+0NFXOm/rVkbU
 95XrSZR4MlhYty0FvmrG6/oXoy9RsjnicexSXNhZ6Tmazh6HV6VC37ZIxAST3sc=
X-Gm-Gg: ASbGncvCahPniLwtnHGgn9SGqMck2Q8P8SYHD8Cxns2JWVJ7K0gIIgSR/15eBv48ojm
 A87rGQilQ/x3dfwwkFhaMywvvoE4E6PKUsc0qgOn5fxnzIspTgNXb0MsXHtfs2DI/85oQZ++kyH
 dZjZfEy4LLYWqAOpp/FYhwR9PHIqRxHClygCWZFEL7GF8vGS2PKP2jPAjy+yrNxCZ2c55uj6wVD
 A/uM/Meo6IFEWbp8CO1VSOlhW3GXsgR7AwNJWD7rQWnSJV5s3SKVdCBX97YLt+Ozh/YcdhSoQ/V
 qNeG/iIr4JM59sQK9Zia5UuogGOkUrudnqf9mlB5FbodRv3Ra2egtNOblw==
X-Google-Smtp-Source: AGHT+IGg86The9fk604YxStWvQzOjB0SRTyJFYvFlfOMstgnHzT2pxNT00mPMYMr9tO1Ku1Re9SpcA==
X-Received: by 2002:a17:903:1a10:b0:224:1c1:4ac1 with SMTP id
 d9443c01a7336-22a8a8d23acmr49000935ad.47.1743786653086; 
 Fri, 04 Apr 2025 10:10:53 -0700 (PDT)
Received: from [192.168.1.87] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-229785c0153sm34730435ad.65.2025.04.04.10.10.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 04 Apr 2025 10:10:52 -0700 (PDT)
Message-ID: <63446bf5-8f50-49f1-bb6d-8363111982bf@linaro.org>
Date: Fri, 4 Apr 2025 09:51:07 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH-for-10.1 10/19] cpus: Replace CPU_RESOLVING_TYPE ->
 target_cpu_type()
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20250403234914.9154-1-philmd@linaro.org>
 <20250403234914.9154-11-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250403234914.9154-11-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62e.google.com
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
Pg0KPiAtLS0NCj4gICBjcHUtdGFyZ2V0LmMgfCA3ICsrKystLS0NCj4gICAxIGZpbGUgY2hh
bmdlZCwgNCBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdp
dCBhL2NwdS10YXJnZXQuYyBiL2NwdS10YXJnZXQuYw0KPiBpbmRleCA3NjFjMmQyODY0NS4u
MDFiMDA2NGI5MWYgMTAwNjQ0DQo+IC0tLSBhL2NwdS10YXJnZXQuYw0KPiArKysgYi9jcHUt
dGFyZ2V0LmMNCj4gQEAgLTIyLDYgKzIyLDcgQEANCj4gICAjaW5jbHVkZSAicWFwaS9lcnJv
ci5oIg0KPiAgICNpbmNsdWRlICJxZW11L2Vycm9yLXJlcG9ydC5oIg0KPiAgICNpbmNsdWRl
ICJxZW11L3FlbXUtcHJpbnQuaCINCj4gKyNpbmNsdWRlICJxZW11L3RhcmdldF9pbmZvLmgi
DQo+ICAgI2luY2x1ZGUgInN5c3RlbS9hY2NlbC1vcHMuaCINCj4gICAjaW5jbHVkZSAic3lz
dGVtL2NwdXMuaCINCj4gICAjaW5jbHVkZSAiZXhlYy9jcHUtY29tbW9uLmgiDQo+IEBAIC0z
Nyw3ICszOCw3IEBAIFFFTVVfQlVJTERfQlVHX09OKG9mZnNldG9mKEFyY2hDUFUsIGVudikg
IT0gc2l6ZW9mKENQVVN0YXRlKSk7DQo+ICAgDQo+ICAgY2hhciAqY3B1X21vZGVsX2Zyb21f
dHlwZShjb25zdCBjaGFyICp0eXBlbmFtZSkNCj4gICB7DQo+IC0gICAgY29uc3QgY2hhciAq
c3VmZml4ID0gIi0iIENQVV9SRVNPTFZJTkdfVFlQRTsNCj4gKyAgICBnX2F1dG9mcmVlIGNo
YXIgKnN1ZmZpeCA9IGdfc3RyZHVwX3ByaW50ZigiLSVzIiwgdGFyZ2V0X2NwdV90eXBlKCkp
Ow0KPiAgIA0KPiAgICAgICBpZiAoIW9iamVjdF9jbGFzc19ieV9uYW1lKHR5cGVuYW1lKSkg
ew0KPiAgICAgICAgICAgcmV0dXJuIE5VTEw7DQo+IEBAIC02Myw3ICs2NCw3IEBAIGNvbnN0
IGNoYXIgKnBhcnNlX2NwdV9vcHRpb24oY29uc3QgY2hhciAqY3B1X29wdGlvbikNCj4gICAg
ICAgICAgIGV4aXQoMSk7DQo+ICAgICAgIH0NCj4gICANCj4gLSAgICBvYyA9IGNwdV9jbGFz
c19ieV9uYW1lKENQVV9SRVNPTFZJTkdfVFlQRSwgbW9kZWxfcGllY2VzWzBdKTsNCj4gKyAg
ICBvYyA9IGNwdV9jbGFzc19ieV9uYW1lKHRhcmdldF9jcHVfdHlwZSgpLCBtb2RlbF9waWVj
ZXNbMF0pOw0KPiAgICAgICBpZiAob2MgPT0gTlVMTCkgew0KPiAgICAgICAgICAgZXJyb3Jf
cmVwb3J0KCJ1bmFibGUgdG8gZmluZCBDUFUgbW9kZWwgJyVzJyIsIG1vZGVsX3BpZWNlc1sw
XSk7DQo+ICAgICAgICAgICBnX3N0cmZyZWV2KG1vZGVsX3BpZWNlcyk7DQo+IEBAIC05Miw3
ICs5Myw3IEBAIHN0YXRpYyB2b2lkIGNwdV9saXN0X2VudHJ5KGdwb2ludGVyIGRhdGEsIGdw
b2ludGVyIHVzZXJfZGF0YSkNCj4gICANCj4gICB2b2lkIGxpc3RfY3B1cyh2b2lkKQ0KPiAg
IHsNCj4gLSAgICBDUFVDbGFzcyAqY2MgPSBDUFVfQ0xBU1Mob2JqZWN0X2NsYXNzX2J5X25h
bWUoQ1BVX1JFU09MVklOR19UWVBFKSk7DQo+ICsgICAgQ1BVQ2xhc3MgKmNjID0gQ1BVX0NM
QVNTKG9iamVjdF9jbGFzc19ieV9uYW1lKHRhcmdldF9jcHVfdHlwZSgpKSk7DQo+ICAgDQo+
ICAgICAgIGlmIChjYy0+bGlzdF9jcHVzKSB7DQo+ICAgICAgICAgICBjYy0+bGlzdF9jcHVz
KCk7DQoNClRoaXMgY2hhbmdlIGNhbiBiZSBkb25lIGFzIGl0J3Mgbm90IHRhcmdldCBkZXBl
bmRlbnQuDQpQbGVhc2UgYWxzbyBzcXVhc2ggb3RoZXIgY29tbWl0cyBkb2luZyB0aGUgc2Ft
ZSBmb3Igb3RoZXIgZmlsZXMsIHNvIHdlIA0KaGF2ZSBhIHNpbmdsZSBjb21taXQgZG9pbmcg
dGhlIGNoYW5nZSBmb3Igd2hvbGUgY29kZWJhc2UuDQoNClJldmlld2VkLWJ5OiBQaWVycmlj
ayBCb3V2aWVyIDxwaWVycmljay5ib3V2aWVyQGxpbmFyby5vcmc+DQo=

