Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3EC3C35FFC
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Mar 2025 14:22:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tx59W-0002hg-3Q; Tue, 25 Mar 2025 10:21:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tx59T-0002gy-Sy
 for qemu-devel@nongnu.org; Tue, 25 Mar 2025 10:21:11 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tx59P-0001F0-LG
 for qemu-devel@nongnu.org; Tue, 25 Mar 2025 10:21:11 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-22398e09e39so115363295ad.3
 for <qemu-devel@nongnu.org>; Tue, 25 Mar 2025 07:21:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742912465; x=1743517265; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=DWqWzgBMC4lNnssNGAxvfPfgbybGACwm/MQMsL+ZseI=;
 b=Mh87p9llTLMg9FyDbxVxTQsjgL2lkDYJXwLI774GACb05qQ8yoiPWTvHZcy6XR7tQw
 MsOYQS3N6MDo9jSxRnMiLo0Z+X3oWatbLXhu/yNhAlmH1kWUY6C385MIyplqAgt5bgh8
 CbMYcwIGPA4DmvYRlmczdPhmLmhf6Ii/xtwiS71CV2il4M0zQ8vEsj700FcpSx2TEJr9
 Dw66un0EabvbbWq67TtL4UsWZ+NrgNEpj4ZfhVVZc6VHwovciTOKaZLl4MDkNpntE+D/
 ZteOfSpNlwfq9/ageeO2c+G0w+Tk+8ifSbU4bcyALZG9rVAuxhdXlcksAsnBpme3okC9
 rzfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742912465; x=1743517265;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=DWqWzgBMC4lNnssNGAxvfPfgbybGACwm/MQMsL+ZseI=;
 b=I6eT6kBTnTqHmtWW8epaawK56KXNfkkzuAbroHs9KbTJytOQGhEfK3AeJw5uOO/WRf
 oZtykg+SJ9bbQiQzlO5uRsD8JncLCOhB3itAlYXS95swNiuGuZDvOxgopzTQCgTsjIS1
 u55oEdwnsTtajkd59SLL/mQDIjlWJfiRoLOPr6DGzmcg5cTG9N2MMKZ2UdFiWhh+IQwf
 NTbNjvne8Wu8sgltAkCDDGAsNYIsh3A7b3myQm0giFqa/aY3NhWRPS2n0H0MlcBh5BoM
 bIM4/kXLGqBYRy+oZDbI4Zn/c9pqfeOWKNlckq0IQlYonqosfmhMLu5f2Ynt8jz6ZmLp
 9FDQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVsfVmn21gHQzUsPz3eQ3i/OnX20wRRgNAUB6YNfEjPtcvBn8oKaE7xsLFYgF4soDhCku/zZGiBtYVn@nongnu.org
X-Gm-Message-State: AOJu0Yx1SeVkAyfWYMO3yYnaSaK93UsPvIbhNaYr8c87U8J2fTaxlBZ1
 78dDAaWeuBNaVrSIfk2uSoGhNYnMXvKgJbOnjMpPHCrvz22r66YDkoUfGYTjqoU=
X-Gm-Gg: ASbGncvnMSt29BWsP6Huba6rorlBIOjd4kBq+LJM2syb+f6exWO6E4sXM7/APXDg4qh
 Wo28GYttMsaCpbDWEsSGolidyRYXG4ACdxUiFt/lIdiJ9dHEfDv8vsyctOm4l6sx7x3lrM6Gegy
 Ijnz8PUuzNoKGGeJWCS1m8K7kzBvJkQXdWe0V+GpBdbZa+XNQrn+KAMoTC4yykMQJk2jmmB+XLM
 W9H5P1RpRXTGIjBWysdwAWQUsU4P2vTlpqAp2WlZv4oy8U41q5QsOpnQvi5zzoJkuwZxU+xqeHQ
 +eSKvZh8eOwPTRLG+t7bH5ASyf1d+z5t47qICTMQkREdwAa/i4ItnqoXWw==
X-Google-Smtp-Source: AGHT+IEKwhXjhwtAU/s6WZuq4+nogSSDpkyn455m9rPycEu42Jw7Z6BvWjvNpSQ/gi6yDlxfT+M4CQ==
X-Received: by 2002:a17:902:c949:b0:220:da88:2009 with SMTP id
 d9443c01a7336-22780e23fcfmr243510505ad.45.1742912464969; 
 Tue, 25 Mar 2025 07:21:04 -0700 (PDT)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7390611d945sm10155222b3a.112.2025.03.25.07.21.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 25 Mar 2025 07:21:04 -0700 (PDT)
Message-ID: <e5b667c0-117f-4dca-a591-cb56b772fe73@linaro.org>
Date: Tue, 25 Mar 2025 07:21:03 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 09/11] target/ppc: convert gdbstub to new helpers
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Nicholas Piggin <npiggin@gmail.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Markus Armbruster <armbru@redhat.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>, qemu-ppc@nongnu.org,
 Thomas Huth <thuth@redhat.com>, David Gibson <david@gibson.dropbear.id.au>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@kaod.org>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-s390x@nongnu.org, Wainer dos Santos Moschetta <wainersm@redhat.com>,
 David Hildenbrand <david@redhat.com>
References: <20250324102142.67022-1-alex.bennee@linaro.org>
 <20250324102142.67022-10-alex.bennee@linaro.org>
 <c99b4b18-2222-4868-9e2d-78305e530663@linaro.org>
 <7a60e516-e224-4766-830d-20e14bba3c8e@linaro.org>
 <f2fc4de2-7235-4c86-8574-2b8d630e5cd6@linaro.org>
 <4ff5ca15-6784-4660-b6f5-9c219d215378@linaro.org>
 <6fd61c99-c753-40bc-b6a0-8b40e0c3956b@linaro.org>
Content-Language: en-US
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <6fd61c99-c753-40bc-b6a0-8b40e0c3956b@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x632.google.com
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

T24gMy8yNS8yNSAwMjoyMiwgUGhpbGlwcGUgTWF0aGlldS1EYXVkw6kgd3JvdGU6DQo+IE9u
IDI0LzMvMjUgMjE6NDksIFBpZXJyaWNrIEJvdXZpZXIgd3JvdGU6DQo+PiBPbiAzLzI0LzI1
IDEzOjA0LCBSaWNoYXJkIEhlbmRlcnNvbiB3cm90ZToNCj4+PiBPbiAzLzI0LzI1IDEyOjI5
LCBQaWVycmljayBCb3V2aWVyIHdyb3RlOg0KPj4+PiBPbiAzLzI0LzI1IDEwOjM5LCBSaWNo
YXJkIEhlbmRlcnNvbiB3cm90ZToNCj4+Pj4+IE9uIDMvMjQvMjUgMDM6MjEsIEFsZXggQmVu
bsOpZSB3cm90ZToNCj4+Pj4+PiArwqDCoMKgICNpZmRlZiBUQVJHRVRfQklHX0VORElBTg0K
Pj4+Pj4+ICvCoMKgwqAgTWVtT3AgZW5kID0gTU9fQkU7DQo+Pj4+Pj4gK8KgwqDCoCAjZWxz
ZQ0KPj4+Pj4+ICvCoMKgwqAgTWVtT3AgZW5kID0gTU9fTEU7DQo+Pj4+Pj4gK8KgwqDCoCAj
ZW5kaWYNCj4+Pj4+PiArI2VuZGlmDQo+Pj4+Pg0KPj4+Pj4gVGhhdCdzIHdoYXQgTU9fVEUg
aXMgZm9yLg0KPj4+Pj4NCj4+Pj4+PiArLyoNCj4+Pj4+PiArICogSGVscGVycyBjb3BpZWQg
ZnJvbSBoZWxwZXJzLmgganVzdCBmb3IgaGFuZGxpbmcgdGFyZ2V0X3Vsb25nDQo+Pj4+Pj4g
dmFsdWVzDQo+Pj4+Pj4gKyAqIGZyb20gZ2Ric3R1YidzIEdCeXRlQXJyYXkgYmFzZWQgb24g
d2hhdCB0aGUgYnVpbGQgY29uZmlnIGlzLiBUaGlzDQo+Pj4+Pj4gKyAqIHdpbGwgbmVlZCBm
aXhpbmcgZm9yIHNpbmdsZS1iaW5hcnkuDQo+Pj4+Pj4gKyAqLw0KPj4+Pj4+ICsNCj4+Pj4+
PiArI2lmIFRBUkdFVF9MT05HX0JJVFMgPT0gNjQNCj4+Pj4+PiArI2RlZmluZSBsZHR1bF9w
KGFkZHIpIGxkcV9wKGFkZHIpDQo+Pj4+Pj4gKyNkZWZpbmUgZ2RiX2dldF9yZWdsX3ZhbHVl
KG0sIGIsIHYpIGdkYl9nZXRfcmVnNjRfdmFsdWUobSwgYiwgdikNCj4+Pj4+PiArI2Vsc2UN
Cj4+Pj4+PiArI2RlZmluZSBsZHR1bF9wKGFkZHIpIGxkbF9wKGFkZHIpDQo+Pj4+Pj4gKyNk
ZWZpbmUgZ2RiX2dldF9yZWdsX3ZhbHVlKG0sIGIsIHYpIGdkYl9nZXRfcmVnMzJfdmFsdWUo
bSwgYiwgdikNCj4+Pj4+PiArI2VuZGlmDQo+Pj4+Pg0KPj4+Pj4gU3VyZWx5IHlvdSdyZSBu
b3QgaW50ZW5kaW5nIHRvIHJlcGxpY2F0ZSB0aGlzIGluIGFueSB0YXJnZXQgdGhhdCBjYW4N
Cj4+Pj4+IGhhdmUgbXVsdGlwbGUgc2l6ZXM/DQo+Pj4+PiBUaGlzIGlzIG5vdCBhbiBpbXBy
b3ZlbWVudC4NCj4+Pj4+DQo+Pj4+DQo+Pj4+IElmIEknbSBjb3JyZWN0IChhbmQgZnJvbSB2
MSksIHBwYyBpcyB0aGUgb25seSBhcmNoaXRlY3R1cmUgaGF2aW5nDQo+Pj4+IHJlZ2lzdGVy
cyBkZWZpbmVkIHdpdGgNCj4+Pj4gdGFyZ2V0X2xvbmcgdHlwZXMuDQo+Pj4NCj4+PiBXaXRo
IGEgcXVpY2sgY2hlY2ssIG1pcHMsIHJpc2N2LCBzcGFyYyBkbyBhcyB3ZWxsLg0KPj4+DQo+
Pg0KPj4gUmlnaHQsIEkgc2hvdWxkIGhhdmUgcnVuIHRoZSBzaW1wbGUgZ3JlcCA6KQ0KPj4g
U28gaXQncyBiZXR0ZXIgdG8ga2VlcCB0aG9zZSBtYWNyb3MgZGVmaW5lZCBpbiBhIHNlcGFy
YXRlIGhlYWRlciAob3V0IG9mDQo+PiBoZWxwZXJzLmgsIGxpa2UgaGVscGVycy10YXJnZXQu
aCksIHNvIHdlIGNhbiBhbHJlYWR5IHN0YXJ0IHRvIGNsZWFudXANCj4+IHNvbWUgdGFyZ2V0
cywgYW5kIGRvIHRoZSByZXN0IG9mIHRoZSB3b3JrIGZvciB0aGUgb25lcyB1c2luZw0KPj4g
dGFyZ2V0X3Vsb25nIHR5cGUgZm9yIGxhdGVyLg0KPiANCj4gU2VlIGFsc28NCj4gaHR0cHM6
Ly9sb3JlLmtlcm5lbC5vcmcvcWVtdS1kZXZlbC9mOTEzMWY2ZS1lODQzLTQ4YmUtYjg1Zi1j
MzQxZWMxOTgxNTRAbGluYXJvLm9yZy8NCj4gY29uc2lkZXJpbmcgcy9UQVJHRVRfTE9OR19T
SVpFL3RhcmdldF9pbmZvX2xvbmdfc2l6ZSgpLw0KPiANCg0KVGhlIHByb2JsZW0gaXMgdGhh
dCBib3RoIG1hY3JvcyAobGR0dWwsIGdkYl9nZXRfcmVnbCkgaGF2ZSBkaWZmZXJlbnQgDQpz
aWduYXR1cmVzLiBGb3IgZ2RiX2dldF9yZWdsLCBpdCBjb3VsZCBiZSBzb2x2ZWQgYnkgY2Fz
dGluZyB0aGUgcG9pbnRlciANCnRvIHRoZSByaWdodCB0eXBlLg0KDQpIb3dldmVyLCBmb3Ig
bGR0dWwsIGl0J3MgbXVjaCBtb3JlIGRhbmdlcm91cywgYXMgbGRsIHJldHVybnMgYSBzaWdu
ZWQgDQp2YWx1ZSwgYW5kIGxkcSwgYW4gdW5zaWduZWQgb25lLiBJJ20gbm90IHN1cmUgd2hp
Y2ggc2lnbmF0dXJlIHdlIHNob3VsZCANCmFkb3B0IGZvciB0aGlzLg0KDQpUaGF0J3Mgd2h5
IEkgcHJvcG9zZWQgaW4gdGhlIGxhc3Qgc2VyaWVzIHRvIHJlcGxhY2UgbGR0dWxfcCB3aXRo
IGFub3RoZXIgDQpmdW5jdGlvbiByZXR1cm5pbmcgdmFsdWUgYnkgcG9pbnRlciwgc28gd2Ug
Y2FuIGVhc2lseSByZXBsYWNlIGNhbGwgc2l0ZXMgDQp3aXRob3V0IHRoZSByaXNrIG9mIHRy
dW5jYXRpbmcgc29tZXRoaW5nLg0K

