Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3E6AD2CDF9
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2024 00:34:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3PJd-00030a-7n; Tue, 22 Oct 2024 20:33:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1t3PJX-0002zq-SG
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 20:33:28 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1t3PJV-0007aP-VU
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 20:33:27 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-20cf6eea3c0so51073065ad.0
 for <qemu-devel@nongnu.org>; Tue, 22 Oct 2024 17:33:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729643603; x=1730248403; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=79ndCH4BWZEfycwpeQ4eGvQI1Eq+4kSlvhh1T8GdH5Q=;
 b=EERdriGIatx8RTQQdW0+JHCWGfZvzDhgBDt+dO9b7+mQeK3s+2ClgoFrun37Xr2Hy5
 /bllK29dhlUiArHYwZJKD4AQJxL+/75Qc8ENKvATgFnEThk+Xi5KnKQrVFzCpaiPUUMV
 eLV6vWfJBvhFmpYm62eqNqNAK7rAbY80/jCwcGGkW+8hCVRYY21ZplqtkaOFOz3WY5nq
 kaTqLJLERJLlhjz6pQgEzWv6QLkgDX0wnkszVVjDObWwQu7QnP7JSN2D90XAui6oNva1
 ytWFqPbTa9xre42DbxVj2FInnlRf3m4c9SdKH9BbqOrGf8LbQvxpeVnQnYJJnPXihjyQ
 7TBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729643603; x=1730248403;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=79ndCH4BWZEfycwpeQ4eGvQI1Eq+4kSlvhh1T8GdH5Q=;
 b=wWdOOrlvesiR4I18LbsjrCe1bgVzl4BdN1cwwUX7V9GDCvOX0kLEQIUmW29okicm/D
 Thn/JQ4ra3NNupcSPy1old8GzCIWDLWzCdgcsJBuKJ99tK1bngfG5+fM94VNT/GqowmQ
 unJIIqXHPL48TTp0Vj1a8IUvchJbEaQu2j3JrBCcT6waiNH36wPqxnSrJWjkqHyf7BjA
 FZcAqbudVUUCvEti8JnPWwhWMfRKtWpSdDMwb8eTjAN42uMuoU0RKc2oWegxF/VD71bY
 yxh4y31kggAWI7svoDw7yJRoJsbc49LXSv4PJn4B8lDwuDXxpuVVltoghOOFuhMdg6bp
 8BbA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVygGcYb+WM+fc7Q2TeMtkriGp2O7DHnxUawWunXQMrCRUiELGACZuzdu+eb7kzJQr/67joxgpt94bG@nongnu.org
X-Gm-Message-State: AOJu0Yy20lWIHcbzhauXkjGikJ1XQxRI50eHNubcr7w4oFY4m7zHSwg4
 oZMv+ulP6zLfM2xBNiiqODW1wF8qtTR3gJLJGbEwXBTe64NaS19g/fPQABVGSJaPnC/1ksva1dI
 XgBAseA==
X-Google-Smtp-Source: AGHT+IFhsM4ymH4z9iMfmjz8kHFWc3s1RItxg2i/WUFTPSle33GeerWDLNrU1JzWzNM+vUvkbjTJDw==
X-Received: by 2002:a17:902:e883:b0:20b:7ed8:3990 with SMTP id
 d9443c01a7336-20fa9de8bf5mr14329755ad.12.1729643603347; 
 Tue, 22 Oct 2024 17:33:23 -0700 (PDT)
Received: from [192.168.1.67] (216-180-64-156.dyn.novuscom.net.
 [216.180.64.156]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20e7f0ebb5csm48187915ad.240.2024.10.22.17.33.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Oct 2024 17:33:22 -0700 (PDT)
Message-ID: <17ab6a26-bfd2-4ee6-8fc4-c371d266dcb1@linaro.org>
Date: Tue, 22 Oct 2024 17:33:21 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 07/20] tests/tcg/x86_64: Add cross-modifying code test
To: Ilya Leoshkevich <iii@linux.ibm.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Cc: Beraldo Leal <bleal@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Yanan Wang <wangyanan55@huawei.com>,
 Thomas Huth <thuth@redhat.com>, John Snow <jsnow@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-arm@nongnu.org, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 devel@lists.libvirt.org, Cleber Rosa <crosa@redhat.com>,
 kvm@vger.kernel.org, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Alexandre Iooss <erdnaxe@crans.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Riku Voipio <riku.voipio@iki.fi>, Zhao Liu <zhao1.liu@intel.com>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20241022105614.839199-1-alex.bennee@linaro.org>
 <20241022105614.839199-8-alex.bennee@linaro.org>
 <6b18238b-f9c3-4046-964f-de16dc30d26e@linaro.org>
 <4c383f09bd6bd9b488ad301e5f050b8c9971f3a2.camel@linux.ibm.com>
Content-Language: en-US
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <4c383f09bd6bd9b488ad301e5f050b8c9971f3a2.camel@linux.ibm.com>
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

T24gMTAvMjIvMjQgMTc6MTYsIElseWEgTGVvc2hrZXZpY2ggd3JvdGU6DQo+IE9uIFR1ZSwg
MjAyNC0xMC0yMiBhdCAxMzozNiAtMDcwMCwgUGllcnJpY2sgQm91dmllciB3cm90ZToNCj4+
IE9uIDEwLzIyLzI0IDAzOjU2LCBBbGV4IEJlbm7DqWUgd3JvdGU6DQo+Pj4gRnJvbTogSWx5
YSBMZW9zaGtldmljaCA8aWlpQGxpbnV4LmlibS5jb20+DQo+Pj4NCj4+PiBjb21taXQgZjAy
NTY5MmM5OTJjICgiYWNjZWwvdGNnOiBDbGVhciBQQUdFX1dSSVRFIGJlZm9yZQ0KPj4+IHRy
YW5zbGF0aW9uIikNCj4+PiBmaXhlZCBjcm9zcy1tb2RpZnlpbmcgY29kZSBoYW5kbGluZywg
YnV0IGRpZCBub3QgYWRkIGEgdGVzdC4gVGhlDQo+Pj4gY2hhbmdlZCBjb2RlIHdhcyBmdXJ0
aGVyIGltcHJvdmVkIHJlY2VudGx5IFsxXSwgYW5kIEkgd2FzIG5vdCBzdXJlDQo+Pj4gd2hl
dGhlciB0aGVzZSBtb2RpZmljYXRpb25zIHdlcmUgc2FmZSAoc3BvaWxlcjogdGhleSB3ZXJl
IGZpbmUpLg0KPj4+DQo+Pj4gQWRkIGEgdGVzdCB0byBtYWtlIHN1cmUgdGhlcmUgYXJlIG5v
IHJlZ3Jlc3Npb25zLg0KPj4+DQo+Pj4gWzFdDQo+Pj4gaHR0cHM6Ly9saXN0cy5nbnUub3Jn
L2FyY2hpdmUvaHRtbC9xZW11LWRldmVsLzIwMjItMDkvbXNnMDAwMzQuaHRtbA0KPj4+DQo+
Pj4gU2lnbmVkLW9mZi1ieTogSWx5YSBMZW9zaGtldmljaCA8aWlpQGxpbnV4LmlibS5jb20+
DQo+Pj4gTWVzc2FnZS1JZDogPDIwMjQxMDAxMTUwNjE3Ljk5NzctMS1paWlAbGludXguaWJt
LmNvbT4NCj4+PiBTaWduZWQtb2ZmLWJ5OiBBbGV4IEJlbm7DqWUgPGFsZXguYmVubmVlQGxp
bmFyby5vcmc+DQo+Pj4gLS0tDQo+Pj4gIMKgIHRlc3RzL3RjZy94ODZfNjQvY3Jvc3MtbW9k
aWZ5aW5nLWNvZGUuYyB8IDgwDQo+Pj4gKysrKysrKysrKysrKysrKysrKysrKysrKw0KPj4+
ICDCoCB0ZXN0cy90Y2cveDg2XzY0L01ha2VmaWxlLnRhcmdldMKgwqDCoMKgwqDCoMKgIHzC
oCA0ICsrDQo+Pj4gIMKgIDIgZmlsZXMgY2hhbmdlZCwgODQgaW5zZXJ0aW9ucygrKQ0KPj4+
ICDCoCBjcmVhdGUgbW9kZSAxMDA2NDQgdGVzdHMvdGNnL3g4Nl82NC9jcm9zcy1tb2RpZnlp
bmctY29kZS5jDQo+Pj4NCj4+PiBkaWZmIC0tZ2l0IGEvdGVzdHMvdGNnL3g4Nl82NC9jcm9z
cy1tb2RpZnlpbmctY29kZS5jDQo+Pj4gYi90ZXN0cy90Y2cveDg2XzY0L2Nyb3NzLW1vZGlm
eWluZy1jb2RlLmMNCj4+PiBuZXcgZmlsZSBtb2RlIDEwMDY0NA0KPj4+IGluZGV4IDAwMDAw
MDAwMDAuLjI3MDRkZjYwNjENCj4+PiAtLS0gL2Rldi9udWxsDQo+Pj4gKysrIGIvdGVzdHMv
dGNnL3g4Nl82NC9jcm9zcy1tb2RpZnlpbmctY29kZS5jDQo+Pj4gQEAgLTAsMCArMSw4MCBA
QA0KPj4+ICsvKg0KPj4+ICsgKiBUZXN0IHBhdGNoaW5nIGNvZGUsIHJ1bm5pbmcgaW4gb25l
IHRocmVhZCwgZnJvbSBhbm90aGVyIHRocmVhZC4NCj4+PiArICoNCj4+PiArICogSW50ZWwg
U0RNIGNhbGxzIHRoaXMgImNyb3NzLW1vZGlmeWluZyBjb2RlIiBhbmQgcmVjb21tZW5kcyBh
DQo+Pj4gc3BlY2lhbA0KPj4+ICsgKiBzZXF1ZW5jZSwgd2hpY2ggcmVxdWlyZXMgYm90aCB0
aHJlYWRzIHRvIGNvb3BlcmF0ZS4NCj4+PiArICoNCj4+PiArICogTGludXgga2VybmVsIHVz
ZXMgYSBkaWZmZXJlbnQgc2VxdWVuY2UgdGhhdCBkb2VzIG5vdCByZXF1aXJlDQo+Pj4gY29v
cGVyYXRpb24gYW5kDQo+Pj4gKyAqIGludm9sdmVzIHBhdGNoaW5nIHRoZSBmaXJzdCBieXRl
IHdpdGggaW50My4NCj4+PiArICoNCj4+PiArICogRmluYWxseSwgdGhlcmUgaXMgdXNlci1t
b2RlIHNvZnR3YXJlIG91dCB0aGVyZSB0aGF0IHNpbXBseSB1c2VzDQo+Pj4gYXRvbWljcywg
YW5kDQo+Pj4gKyAqIHRoYXQgc2VlbXMgdG8gYmUgZ29vZCBlbm91Z2ggaW4gcHJhY3RpY2Uu
IFRlc3QgdGhhdCBRRU1VIGhhcyBubw0KPj4+IHByb2JsZW1zDQo+Pj4gKyAqIHdpdGggdGhp
cyBhcyB3ZWxsLg0KPj4+ICsgKi8NCj4+PiArDQo+Pj4gKyNpbmNsdWRlIDxhc3NlcnQuaD4N
Cj4+PiArI2luY2x1ZGUgPHB0aHJlYWQuaD4NCj4+PiArI2luY2x1ZGUgPHN0ZGJvb2wuaD4N
Cj4+PiArI2luY2x1ZGUgPHN0ZGxpYi5oPg0KPj4+ICsNCj4+PiArdm9pZCBhZGQxX29yX25v
cChsb25nICp4KTsNCj4+PiArYXNtKCIucHVzaHNlY3Rpb24gLnJ3eCxcImF3eFwiLEBwcm9n
Yml0c1xuIg0KPj4+ICvCoMKgwqAgIi5nbG9ibCBhZGQxX29yX25vcFxuIg0KPj4+ICvCoMKg
wqAgLyogYWRkcSAkMHgxLCglcmRpKSAqLw0KPj4+ICvCoMKgwqAgImFkZDFfb3Jfbm9wOiAu
Ynl0ZSAweDQ4LCAweDgzLCAweDA3LCAweDAxXG4iDQo+Pj4gK8KgwqDCoCAicmV0XG4iDQo+
Pj4gK8KgwqDCoCAiLnBvcHNlY3Rpb25cbiIpOw0KPj4+ICsNCj4+PiArI2RlZmluZSBUSFJF
QURfV0FJVCAwDQo+Pj4gKyNkZWZpbmUgVEhSRUFEX1BBVENIIDENCj4+PiArI2RlZmluZSBU
SFJFQURfU1RPUCAyDQo+Pj4gKw0KPj4+ICtzdGF0aWMgdm9pZCAqdGhyZWFkX2Z1bmModm9p
ZCAqYXJnKQ0KPj4+ICt7DQo+Pj4gK8KgwqDCoCBpbnQgdmFsID0gMHgwMDI2NzQ4ZDsgLyog
bm9wICovDQo+Pj4gKw0KPj4+ICvCoMKgwqAgd2hpbGUgKHRydWUpIHsNCj4+PiArwqDCoMKg
wqDCoMKgwqAgc3dpdGNoIChfX2F0b21pY19sb2FkX24oKGludCAqKWFyZywgX19BVE9NSUNf
U0VRX0NTVCkpIHsNCj4+PiArwqDCoMKgwqDCoMKgwqAgY2FzZSBUSFJFQURfV0FJVDoNCj4+
PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBicmVhazsNCj4+PiArwqDCoMKgwqDCoMKgwqAg
Y2FzZSBUSFJFQURfUEFUQ0g6DQo+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgdmFsID0g
X19hdG9taWNfZXhjaGFuZ2VfbigoaW50ICopJmFkZDFfb3Jfbm9wLCB2YWwsDQo+Pj4gK8Kg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIF9fQVRPTUlDX1NFUV9DU1QpOw0KPj4+ICvCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIGJyZWFrOw0KPj4+ICvCoMKgwqDCoMKgwqDCoCBjYXNlIFRIUkVBRF9T
VE9QOg0KPj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJldHVybiBOVUxMOw0KPj4+ICvC
oMKgwqDCoMKgwqDCoCBkZWZhdWx0Og0KPj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGFz
c2VydChmYWxzZSk7DQo+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgX19idWlsdGluX3Vu
cmVhY2hhYmxlKCk7DQo+Pg0KPj4gVXNlIGdfYXNzZXJ0X25vdF9yZWFjaGVkKCkgaW5zdGVh
ZC4NCj4+IGNoZWNrcGF0Y2ggZW1pdHMgYW4gZXJyb3IgZm9yIGl0IG5vdy4NCj4gDQo+IElz
IHRoZXJlIGFuIGVhc3kgd2F5IHRvIGluY2x1ZGUgZ2xpYiBmcm9tIHRlc3RjYXNlcz8NCj4g
SXQncyBsb2NhdGVkIHVzaW5nIG1lc29uLCBhbmQgSSBjYW4ndCBpbW1lZGlhdGVseSBzZWUg
aG93IHRvIHB1c2ggdGhlDQo+IHJlc3BlY3RpdmUgY29tcGlsZXIgZmxhZ3MgdG8gdGhlIHRl
c3QgTWFrZWZpbGVzIC0gdGhpcyBzZWVtcyB0byBiZQ0KPiBjdXJyZW50bHkgaGFuZGxlZCBi
eSBjb25maWd1cmUgd3JpdGluZyB0byAkY29uZmlnX3RhcmdldF9tYWsuDQo+IA0KPiBbLi4u
XQ0KPiANCg0KU29ycnkgeW91J3JlIHJpZ2h0LCBJIG1pc3NlZCB0aGUgZmFjdCB0ZXN0cyBk
b24ndCBoYXZlIHRoZSBkZXBzIHdlIGhhdmUgDQppbiBRRU1VIGl0c2VsZi4NCkkgZG9uJ3Qg
dGhpbmsgYW55IHRlc3QgY2FzZSBpbmNsdWRlIGFueSBleHRyYSBkZXBlbmRlbmN5IGZvciBu
b3cgKGFuZCANCndvdWxkIG1ha2UgaXQgaGFyZCB0byBjcm9zcyBjb21waWxlIHRoZW0gdG9v
KSwgc28gaXQncyBub3Qgd29ydGggdHJ5aW5nIA0KdG8gZ2V0IHRoZSByaWdodCBnbGliIGhl
YWRlciBmb3IgdGhpcy4NCg0KSSBkb24ndCBub3cgaWYgaXQgd2lsbCBiZSBhIHByb2JsZW0g
d2hlbiBtZXJnaW5nIHRoZSBzZXJpZXMgcmVnYXJkaW5nIA0KY2hlY2twYXRjaCwgYnV0IGlm
IGl0IGlzLCB3ZSBjYW4gYWx3YXlzIHJlcGxhY2UgdGhpcyBieSBhYm9ydCwgb3IgZXhpdC4N
Cg0KPiANCg0KQXMgaXQgaXMsDQpSZXZpZXdlZC1ieTogUGllcnJpY2sgQm91dmllciA8cGll
cnJpY2suYm91dmllckBsaW5hcm8ub3JnPg0K

