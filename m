Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 990EFC36002
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Mar 2025 01:49:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1twtPS-0001In-TE; Mon, 24 Mar 2025 21:48:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1twtPH-0001HZ-UY
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 21:48:47 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1twtPF-0008S4-N7
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 21:48:43 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-226185948ffso95973185ad.0
 for <qemu-devel@nongnu.org>; Mon, 24 Mar 2025 18:48:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742867319; x=1743472119; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=jepGxtMetxth7FUIkF6aKP1E2vtROZB2g8aTn+vFrpA=;
 b=BWFb9WWFfIbiFhKGZ3sVXbSCMMVmgk52P5p8T9hbszKATg0ch56DhbexkIgADdIiv7
 D7rGGStkFJxEDQTxNU1rf2PIVl+3bqE4ez3bmo/WMnienkwgwMMDam+1jpJv91BK7JVN
 gBmFoDRTlg9GNXbRUBd8p7C7Dthe2m1UMTnFgkRbYZczR/M1Un0ETC00GYycParaXOTs
 DHjA9WOAZzOL6E+FY1s3Ufw0rQS+Rz5IybfVuOiL9EPkmQNYC8vhEELNJRv5nGfD+f9R
 WcuBr4W+UTcw4ICd4h0+dmwjxYkfQpeoWma1OxjioUc+vPGh3ZfjVHOxh1heWwCk97zW
 O3lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742867319; x=1743472119;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jepGxtMetxth7FUIkF6aKP1E2vtROZB2g8aTn+vFrpA=;
 b=WLCpnJMlayJL0exax8aO1nwX000cP/5DjfLnKdBy/cMhohJJBsUwzSxDxswJVvYy/Y
 W+P7Gorzasp9cr907NmTSYLv/9jt7bRqeZwkJ0VfE0W7csBu8F44jnT2FE6PMAVCn47p
 Q6n8ai5BJGbaeS2I+ANQAo/o624bkOGVMAnS6pYjnGRL14vnMdroIjYo1mQ3TOsRKNXG
 KGYYtQwvDK0iTQx48jxnjSX+rH8kRkO+yqDOnr3CbE3LRU/kW0xAOHtb13wPK/F1JgyS
 C66yVEGyVADqUFNp0J1FcaylhO+W/c+tetzEO0Jm3XqmzvGEfJCUZM8XuPigNtJzoSIU
 qkCw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVjfnGVio8iy6YYfn4Wbgvxgu/ElkqYv0EnGej+vKUzE65aOF4ObR0uqp+htJrBi2mhdUAzgzxq8mGV@nongnu.org
X-Gm-Message-State: AOJu0YzIZLMXeT7R8bdxBe16pkXK58MFl6WpDkfHJlBEAvT3bZiQ1x5M
 HYK7xZCN3L6F5foxB19WTgbcez1wkfWrTybrHJflKOCBSA8nC66nqqzlB36Npr/6EoiCedSkMAl
 jT5g=
X-Gm-Gg: ASbGncsxW4V7+6WLMizZMzFQO93TGDk3XagjDX+qKuyF2pFISAqJTkn/MRoTAEHPjU9
 ERU+7JWUfZSZsyUhRYGmjp5+JBW2L4l22I8q/5Fb6wN4rBeqUd7HJWTIiJyLpkk/z7pArPHR0eX
 ubLEeVlFUGoNpQwIAqfFXSd1xwXXCTZ2N2wyS5ixpkEbOvLD+X+9SiB99eyX5H0CiVMq6lON3M6
 x9JJHJ9ZmY/HSVOgvF55i9xFwHXCdXACPgFtDbgq/HNiIud4OywLwX0dAD81nDFEkuwSjxlvxKM
 zEeVqC49zaHGGyOIlMCPl4dTHN8SIHYq+I/k1hmEDQB4SIwx0tmswSa9Vw==
X-Google-Smtp-Source: AGHT+IHoINdwL8jgY5FqgvZtk5Q6BeVpE4yF1ws/NywnBXzBwUcbjtM6+wv8Mc2pJC11Q5+zeW1xjA==
X-Received: by 2002:a05:6a20:12cf:b0:1f5:86f2:a674 with SMTP id
 adf61e73a8af0-1fe42f326e4mr25190629637.12.1742867318910; 
 Mon, 24 Mar 2025 18:48:38 -0700 (PDT)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-af8a2a23b2asm7923700a12.50.2025.03.24.18.48.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 24 Mar 2025 18:48:38 -0700 (PDT)
Message-ID: <60aa7341-e462-4334-bc85-f70f6d48e392@linaro.org>
Date: Mon, 24 Mar 2025 18:48:37 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 26/30] hw/arm/armv7m: prepare compilation unit to be
 common
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini
 <pbonzini@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20250320223002.2915728-1-pierrick.bouvier@linaro.org>
 <20250320223002.2915728-27-pierrick.bouvier@linaro.org>
 <0c9055a3-2650-4802-a28c-e5d79052bc81@linaro.org>
 <6cce9fd1-d008-4b63-a77f-c091fcd933e0@linaro.org>
 <67313299-0ce6-457d-ace7-73ad864a0eb0@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <67313299-0ce6-457d-ace7-73ad864a0eb0@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62f.google.com
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

T24gMy8yNC8yNSAxODoyMiwgUmljaGFyZCBIZW5kZXJzb24gd3JvdGU6DQo+IE9uIDMvMjQv
MjUgMTQ6MzEsIFBpZXJyaWNrIEJvdXZpZXIgd3JvdGU6DQo+PiBPbiAzLzIzLzI1IDEyOjQ4
LCBSaWNoYXJkIEhlbmRlcnNvbiB3cm90ZToNCj4+PiBPbiAzLzIwLzI1IDE1OjI5LCBQaWVy
cmljayBCb3V2aWVyIHdyb3RlOg0KPj4+PiBTaWduZWQtb2ZmLWJ5OiBQaWVycmljayBCb3V2
aWVyIDxwaWVycmljay5ib3V2aWVyQGxpbmFyby5vcmc+DQo+Pj4+IC0tLQ0KPj4+PiAgwqDC
oCBody9hcm0vYXJtdjdtLmMgfCAxMiArKysrKysrKy0tLS0NCj4+Pj4gIMKgwqAgMSBmaWxl
IGNoYW5nZWQsIDggaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkNCj4+Pj4NCj4+Pj4g
ZGlmZiAtLWdpdCBhL2h3L2FybS9hcm12N20uYyBiL2h3L2FybS9hcm12N20uYw0KPj4+PiBp
bmRleCA5OGE2OTg0NjExOS4uYzM2N2MyZGNiOTkgMTAwNjQ0DQo+Pj4+IC0tLSBhL2h3L2Fy
bS9hcm12N20uYw0KPj4+PiArKysgYi9ody9hcm0vYXJtdjdtLmMNCj4+Pj4gQEAgLTEzOSw4
ICsxMzksOSBAQCBzdGF0aWMgTWVtVHhSZXN1bHQgdjdtX3N5c3JlZ19uc193cml0ZSh2b2lk
ICpvcGFxdWUsIGh3YWRkciBhZGRyLA0KPj4+PiAgwqDCoMKgwqDCoMKgIGlmIChhdHRycy5z
ZWN1cmUpIHsNCj4+Pj4gIMKgwqDCoMKgwqDCoMKgwqDCoMKgIC8qIFMgYWNjZXNzZXMgdG8g
dGhlIGFsaWFzIGFjdCBsaWtlIE5TIGFjY2Vzc2VzIHRvIHRoZSByZWFsIHJlZ2lvbiAqLw0K
Pj4+PiAgwqDCoMKgwqDCoMKgwqDCoMKgwqAgYXR0cnMuc2VjdXJlID0gMDsNCj4+Pj4gK8Kg
wqDCoMKgwqDCoMKgIE1lbU9wIGVuZCA9IHRhcmdldF93b3Jkc19iaWdlbmRpYW4oKSA/IE1P
X0JFIDogTU9fTEU7DQo+Pj4+ICDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZXR1cm4gbWVtb3J5
X3JlZ2lvbl9kaXNwYXRjaF93cml0ZShtciwgYWRkciwgdmFsdWUsDQo+Pj4+IC3CoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBzaXplX21lbW9wKHNpemUpIHwgTU9fVEUsIGF0
dHJzKTsNCj4+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHNpemVfbWVt
b3Aoc2l6ZSkgfCBlbmQsIGF0dHJzKTsNCj4+Pg0KPj4+IHRhcmdldF93b3Jkc19iaWdlbmRp
YW4oKSBpcyBhbHdheXMgZmFsc2UgZm9yIGFybSBzeXN0ZW0gbW9kZS4NCj4+PiBKdXN0IHMv
VEUvTEUvLg0KPj4+DQo+Pg0KPj4gR29vZCBwb2ludC4NCj4+DQo+PiBCeSB0aGUgd2F5LCB3
aGF0J3MgdGhlIFFFTVUgcmF0aW9uYWxlIGJlaGluZCBoYXZpbmcgQXJtIGJpZyBlbmRpYW4g
dXNlciBiaW5hcmllcywgYW5kIG5vdA0KPj4gcHJvdmlkZSBpdCBmb3Igc29mdG1tdSBiaW5h
cmllcz8NCj4gDQo+IEZvciBzeXN0ZW0gbW9kZSwgZW5kaWFubmVzcyBpcyBzZXQgdmlhIGEg
Y29tYmluYXRpb24gb2YgQ1BTUi5FLCBTQ1RMUi5CIGFuZCBTQ1RMUi5FRSwNCj4gZGV0YWls
cyBkZXBlbmRpbmcgb24gYXJtdjQsIGFybXY2LCBhcm12NysuDQo+IA0KPiBJdCBpcyBJTVBM
RU1FTlRBVElPTiBERUZJTkVEIGhvdyB0aGUgY3B1IGluaXRpYWlsaXplcyBhdCByZXNldC4g
IEluIG9sZGVuIHRpbWVzLCB2aWEgYQ0KPiBib2FyZC1sZXZlbCBwaW4gKHNvbWV0aW1lcyBz
d2l0Y2hlZCwgc29tZXRpbWVzIHNvbGRlcmVkKS4gIFdlIG1vZGVsIHRoZSBib2FyZC1sZXZl
bCBwaW4NCj4gdmlhIHRoZSAiY2ZnZW5kIiBjcHUgcHJvcGVydHkuDQo+IA0KPiBJbiBhbnkg
Y2FzZSwgZm9yIHN5c3RlbSBtb2RlIHdlIGV4cGVjdCB0aGUgZ3Vlc3QgdG8gZG8gdGhlIHNh
bWUgdGhpbmcgaXQgd291bGQgbmVlZCB0byBkbw0KPiBvbiByZWFsIGhhcmR3YXJlLiAgRm9y
IHVzZXIgbW9kZSwgd2UgY2FuJ3QgZG8gdGhhdCwgYXMgd2UncmUgYWxzbyBlbXVsYXRpbmcg
dGhlIE9TIGxheWVyLA0KPiB3aGljaCBuZWVkcyB0byBrbm93IHRoZSBlbmRpYW5uZXNzIHRv
IGV4cGVjdCBmcm9tIHRoZSBndWVzdCBiaW5hcmllcy4NCj4gDQoNCk9oIHllcywgdG90YWxs
eSBtYWtlcyBzZW5zZS4gVGhhbmtzLg0KDQo+PiBJZiB0aG9zZSBzeXN0ZW1zIGFyZSBzbyBy
YXJlLCB3aHkgd291bGQgcGVvcGxlIG5lZWQgYSB1c2VyIG1vZGUgZW11bGF0aW9uPw0KPiAN
Cj4gSU1PIGFybWJlLWxpbnV4LXVzZXIgaXMgZXh0aW5jdC4NCj4gDQo+IERlYmlhbiBuZXZl
ciBoYWQgYmlnLWVuZGlhbiBzdXBwb3J0IGF0IGFsbC4gIElmIHRoZXJlIHdhcyBzb21lIG90
aGVyIGRpc3RybyB3aGljaCBoYWQgaXQsDQo+IEkgZG9uJ3QgcmVjYWxsIHdoaWNoLiAgT3Ro
ZXJ3aXNlIHlvdSdkIG5lZWQgdG8gYm9vdHN0cmFwIHRoZSBlbnRpcmUgdG9vbGNoYWluLCB3
aGljaCB0byBtZQ0KPiBzZWVtcyByYXRoZXIgYmVzaWRlIHRoZSBwb2ludC4NCj4gDQo+IA0K
PiByfg0KDQo=

