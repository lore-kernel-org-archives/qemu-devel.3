Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A39A9C369AB
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Apr 2025 16:24:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u5oVZ-00064t-Hw; Fri, 18 Apr 2025 12:24:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u5oVX-00064U-Gz
 for qemu-devel@nongnu.org; Fri, 18 Apr 2025 12:24:03 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u5oVU-00080r-FE
 for qemu-devel@nongnu.org; Fri, 18 Apr 2025 12:24:03 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-2254e0b4b79so30192845ad.2
 for <qemu-devel@nongnu.org>; Fri, 18 Apr 2025 09:23:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744993438; x=1745598238; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=bo2xEJjH6Pu8VzhCAGRIMsGU65d0sCUXyolz51i99sk=;
 b=ynypN0+PpKz/yFX9xSQxyIl3BMz1oKtgqdrrzBYugaxwuogsuWV7ZnqXtMbrDwyFbv
 HbIrh73oB54W73CjcsrtBUNzTIGx6d8k3SO3tJaivooJPonkHbn6c35DedgXtwdkgzY6
 sNIpvjGiMG7aexKbfqljv0Ic5z690si5SCfTNL1bQHeqd2pXOCCVAQv3CxkfrW7WCX6h
 icO6xKmIi07mSvlKX7xs1MB93WJjIgW/3DuKVPVzCOYdcGzaUIi3DwwxbGiIz21AbXiv
 epRbXRTKJ4ynwmu8HBGJG3H35eqBV1r5IPq4usmsFvwuEr+whS9K4dh8IIV2r5lbSyZR
 5tMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744993438; x=1745598238;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=bo2xEJjH6Pu8VzhCAGRIMsGU65d0sCUXyolz51i99sk=;
 b=HPLlZy2r/ZYTtMyVsOMT0D0Zpxh3yv156Iv31kmb3cKHGvWzR6vUYhPjkEdkYCnUoN
 QU1juth0GRvdFoXReK/yT4EwYeK+HUHJ3HVo4WWP0TAQwtg9nMsVCyozf2zrTpW2GT3x
 lPwq7/OCF1K0eBgoPPir777ALAuJCMWIDMX24JsUnbLW66iHtF1KwR2PPJgU2GGab4rX
 QYEGaq4Q017dGMeB6FfkKIPrSYYhciZpKyS5DaLQcluM3DwYcANDTD31PuRU3Ycfaq8J
 2rlZ3lzh+zFUr7cGE7ah7RVP3tlsCOtVyAFA1P3w5XY91X9l6zWgl2x6Gdr2Kf1+g/DP
 IUEg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUZu3Dyw64xaY1qCRNIcMrwSEXM80jlnN3vC3kWvrPxKz2ZygWr0DHoQRWk5hay2EM1A7eUAbaehLJE@nongnu.org
X-Gm-Message-State: AOJu0Yyf5kf468tACbclrMqdqTGS7IPcb0XSppoQbkx8f4U51usViepn
 ezy4PYuRrIBzhkTVrIE8mC7VrxFMw26x76qojf7sa4x9OFCTeDyI6/lhS+MmQ5RTkC5wMT4bMyD
 H
X-Gm-Gg: ASbGncvSJCt9qt4O89nNTTL1pYINScDKnftDGcRBklh0hLjXnFghs1u9uI2bVLjhz/G
 ZmseWaIes0pJR9xqmeBSQwjhPtgYPyaeg3uDdidw4spYSxVwRO4aqk26sOiPY8CUty8mocj5dUx
 HZrod0HY07/Z3I285r9x3fV76mSeGBP3dMP+FdcZ5Ya+hBTjr844Y3zawon/9FezXXxjpVOwzaP
 8lqw/Y0WVAJjv/8dvyw7WNxZTD/1oAMEs9TO0kDvB/yX1gT+GjMtbDUAwuQw8RiHQp4CTm1MiKg
 X1Vj2JdqUE1kCUmcX85Tc9iTXXBIOeYuBi+iI/yVhwwaz1OGzUppKg==
X-Google-Smtp-Source: AGHT+IE/frwOfPN9I7aF+K+qV++0yCQlw9gIutPBoQl/pSb+CGLbVIGvHJfGnJXbzwJyiRib+faAwg==
X-Received: by 2002:a17:903:1a27:b0:223:26da:4b6f with SMTP id
 d9443c01a7336-22c53582587mr52007595ad.14.1744993438332; 
 Fri, 18 Apr 2025 09:23:58 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22c50eb4a5csm18597105ad.129.2025.04.18.09.23.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 18 Apr 2025 09:23:57 -0700 (PDT)
Message-ID: <f488e95f-14df-4cdd-88e0-4160e83acec3@linaro.org>
Date: Fri, 18 Apr 2025 09:23:57 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 02/11] qemu: Convert target_name() to TargetInfo API
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20250418005059.4436-1-philmd@linaro.org>
 <20250418005059.4436-3-philmd@linaro.org>
 <cff3276a-0a17-406d-a7d2-0c932d1fb1f4@linaro.org>
 <3fc281a5-3a6b-47d6-bead-3a93f331a258@linaro.org>
Content-Language: en-US
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <3fc281a5-3a6b-47d6-bead-3a93f331a258@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x630.google.com
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

T24gNC8xOC8yNSAwNzowMiwgUGhpbGlwcGUgTWF0aGlldS1EYXVkw6kgd3JvdGU6DQo+IE9u
IDE4LzQvMjUgMDU6MDEsIFBpZXJyaWNrIEJvdXZpZXIgd3JvdGU6DQo+PiBPbiA0LzE3LzI1
IDE3OjUwLCBQaGlsaXBwZSBNYXRoaWV1LURhdWTDqSB3cm90ZToNCj4+PiBIYXZlIHRhcmdl
dF9uYW1lKCkgYmUgYSB0YXJnZXQtYWdub3N0aWMgbWV0aG9kLCBkaXNwYXRjaGluZw0KPj4+
IHRvIGEgcGVyLXRhcmdldCBUYXJnZXRJbmZvIHNpbmdsZXRvbiBzdHJ1Y3R1cmUuDQo+Pj4g
QnkgZGVmYXVsdCBhIHN0dWIgc2luZ2xldG9uIGlzIHVzZWQuIE5vIGxvZ2ljYWwgY2hhbmdl
DQo+Pj4gZXhwZWN0ZWQuDQo+Pj4NCj4+PiBJbnNwaXJlZC1ieTogUGllcnJpY2sgQm91dmll
ciA8cGllcnJpY2suYm91dmllckBsaW5hcm8ub3JnPg0KPj4+IFNpZ25lZC1vZmYtYnk6IFBo
aWxpcHBlIE1hdGhpZXUtRGF1ZMOpIDxwaGlsbWRAbGluYXJvLm9yZz4NCj4+PiBSZXZpZXdl
ZC1ieTogUGllcnJpY2sgQm91dmllciA8cGllcnJpY2suYm91dmllckBsaW5hcm8ub3JnPg0K
Pj4+IC0tLQ0KPj4+ICDCoCBtZXNvbi5idWlsZMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgfMKgIDMgKysrDQo+Pj4gIMKgIGluY2x1ZGUvaHcvY29yZS9jcHUu
aMKgwqDCoMKgwqDCoMKgwqDCoMKgIHzCoCAyIC0tDQo+Pj4gIMKgIGluY2x1ZGUvcWVtdS90
YXJnZXRfaW5mby1pbXBsLmggfCAyMyArKysrKysrKysrKysrKysrKysrKysrKw0KPj4+ICDC
oCBpbmNsdWRlL3FlbXUvdGFyZ2V0X2luZm8uaMKgwqDCoMKgwqAgfCAxOSArKysrKysrKysr
KysrKysrKysrDQo+Pj4gIMKgIGNwdS10YXJnZXQuY8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIHzCoCA1IC0tLS0tDQo+Pj4gIMKgIGh3L2NvcmUvbWFjaGluZS1x
bXAtY21kcy5jwqDCoMKgwqDCoCB8wqAgMSArDQo+Pj4gIMKgIHBsdWdpbnMvbG9hZGVyLmPC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKgIDIgKy0NCj4+PiAgwqAgc3lzdGVt
L3ZsLmPCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHzCoCAyICst
DQo+Pj4gIMKgIHRhcmdldF9pbmZvLXN0dWIuY8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IHwgMTkgKysrKysrKysrKysrKysrKysrKw0KPj4+ICDCoCB0YXJnZXRfaW5mby5jwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHwgMTYgKysrKysrKysrKysrKysrKw0K
Pj4+ICDCoCAxMCBmaWxlcyBjaGFuZ2VkLCA4MyBpbnNlcnRpb25zKCspLCA5IGRlbGV0aW9u
cygtKQ0KPj4+ICDCoCBjcmVhdGUgbW9kZSAxMDA2NDQgaW5jbHVkZS9xZW11L3RhcmdldF9p
bmZvLWltcGwuaA0KPj4+ICDCoCBjcmVhdGUgbW9kZSAxMDA2NDQgaW5jbHVkZS9xZW11L3Rh
cmdldF9pbmZvLmgNCj4+PiAgwqAgY3JlYXRlIG1vZGUgMTAwNjQ0IHRhcmdldF9pbmZvLXN0
dWIuYw0KPj4+ICDCoCBjcmVhdGUgbW9kZSAxMDA2NDQgdGFyZ2V0X2luZm8uYw0KPiANCj4g
DQo+Pj4gZGlmZiAtLWdpdCBhL3RhcmdldF9pbmZvLXN0dWIuYyBiL3RhcmdldF9pbmZvLXN0
dWIuYw0KPj4+IG5ldyBmaWxlIG1vZGUgMTAwNjQ0DQo+Pj4gaW5kZXggMDAwMDAwMDAwMDAu
LjFlNDRiYjZmNmZiDQo+Pj4gLS0tIC9kZXYvbnVsbA0KPj4+ICsrKyBiL3RhcmdldF9pbmZv
LXN0dWIuYw0KPj4+IEBAIC0wLDAgKzEsMTkgQEANCj4+PiArLyoNCj4+PiArICogUUVNVSB0
YXJnZXQgaW5mbyBzdHVicw0KPj4+ICsgKg0KPj4+ICsgKsKgIENvcHlyaWdodCAoYykgTGlu
YXJvDQo+Pj4gKyAqDQo+Pj4gKyAqIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4w
LW9yLWxhdGVyDQo+Pj4gKyAqLw0KPj4+ICsNCj4+PiArI2luY2x1ZGUgInFlbXUvb3NkZXAu
aCINCj4+PiArI2luY2x1ZGUgInFlbXUvdGFyZ2V0X2luZm8taW1wbC5oIg0KPj4+ICsNCj4+
PiArc3RhdGljIGNvbnN0IFRhcmdldEluZm8gdGFyZ2V0X2luZm9fc3R1YiA9IHsNCj4+PiAr
wqDCoMKgIC5uYW1lID0gVEFSR0VUX05BTUUsDQo+Pj4gK307DQo+Pj4gKw0KPj4+ICtjb25z
dCBUYXJnZXRJbmZvICp0YXJnZXRfaW5mbyh2b2lkKQ0KPj4+ICt7DQo+Pj4gK8KgwqDCoCBy
ZXR1cm4gJnRhcmdldF9pbmZvX3N0dWI7DQo+Pj4gK30NCj4+PiBkaWZmIC0tZ2l0IGEvdGFy
Z2V0X2luZm8uYyBiL3RhcmdldF9pbmZvLmMNCj4+PiBuZXcgZmlsZSBtb2RlIDEwMDY0NA0K
Pj4+IGluZGV4IDAwMDAwMDAwMDAwLi44NzdhNmExNTAxNA0KPj4+IC0tLSAvZGV2L251bGwN
Cj4+PiArKysgYi90YXJnZXRfaW5mby5jDQo+Pj4gQEAgLTAsMCArMSwxNiBAQA0KPj4+ICsv
Kg0KPj4+ICsgKiBRRU1VIGJpbmFyeS90YXJnZXQgaGVscGVycw0KPj4+ICsgKg0KPj4+ICsg
KsKgIENvcHlyaWdodCAoYykgTGluYXJvDQo+Pj4gKyAqDQo+Pj4gKyAqIFNQRFgtTGljZW5z
ZS1JZGVudGlmaWVyOiBHUEwtMi4wLW9yLWxhdGVyDQo+Pj4gKyAqLw0KPj4+ICsNCj4+PiAr
I2luY2x1ZGUgInFlbXUvb3NkZXAuaCINCj4+PiArI2luY2x1ZGUgInFlbXUvdGFyZ2V0X2lu
Zm8taW1wbC5oIg0KPj4+ICsjaW5jbHVkZSAicWVtdS90YXJnZXRfaW5mby5oIg0KPj4+ICsN
Cj4+PiArY29uc3QgY2hhciAqdGFyZ2V0X25hbWUodm9pZCkNCj4+PiArew0KPj4+ICvCoMKg
wqAgcmV0dXJuIHRhcmdldF9pbmZvKCktPm5hbWU7DQo+Pj4gK30NCj4+DQo+PiBXaGF0IGlz
IHRoZSBiZW5lZml0IHRvIGhhdmUgdHdvIGRpZmZlcmVudCBmaWxlcyAoY29tbW9uIGFuZCBz
cGVjaWZpYyk/DQo+PiB0YXJnZXRfbmFtZSgpIGNhbiBiZSBpbmxpbmUgaW4gdGhlIHNhbWUg
aGVhZGVyLCByZXR1cm5pbmcgdGhlIG1hdGNoaW5nDQo+PiBmaWVsZCBpbiBleGlzdGluZyB0
YXJnZXRfaW5mbywgd2hpY2ggZG9lcyBub3QgbmVlZCBhbnkgc3BlY2lhbGl6YXRpb24NCj4+
IHBlciB0YXJnZXQuDQo+IA0KPiBjb21tb24gaW50ZXJmYWNlIGV4cG9zZWQgdGFyZ2V0LWFn
bm9zdGljLCBkaXNwYXRjaGluZyB0byB0YXJnZXQtc3BlY2lmaWMNCj4gaW1wbGVtZW50YXRp
b24gKHByb3ZpZGluZyBhIHN0dWIgd2UnbGwgcmVtb3ZlIG9uY2UgYWxsIHRhcmdldHMgY29u
dmVydGVkKS4NCj4gDQo+IFdoYXQgd291bGQgeW91IHN1Z2dlc3Q/DQoNClRvIHJlbW92ZSB0
YXJnZXRfaW5mby5jIGFuZCB0YXJnZXRfaW5mby1pbXBsLmgsIGFuZCBpbXBsZW1lbnQgDQp0
YXJnZXRfbmFtZSgpIGFzIGEgc3RhdGljIGlubGluZSBpbiB0YXJnZXRfaW5mby5oLg0KDQpU
aGlzIHdheSwgdGFyZ2V0X2luZm8uaCBjYW4gc3RpbGwgYmUgaW5jbHVkZWQgZnJvbSBjb21t
b24gY29kZSwgdGhlIA0Kc3RydWN0dXJlIGlzIGRpcmVjdGx5IGFjY2Vzc2VkLCBhbmQgd2Ug
aGF2ZSBhIHNpbmdsZSBoZWFkZXIgd2hlcmUgd2UgY2FuIA0KYWRkIG5ldyBzdWdhciBmdW5j
dGlvbnMgYW5kIGFzc29jaWF0ZWQgZmllbGRzIGxhdGVyLg0K

