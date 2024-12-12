Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C8B2E7717F
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2024 19:25:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLooP-0001bj-Ud; Thu, 12 Dec 2024 14:25:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tLooM-0001Rt-2K
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 14:25:22 -0500
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tLooK-00059W-Ca
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 14:25:21 -0500
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-728f1e66418so905951b3a.2
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2024 11:25:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734031517; x=1734636317; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=utsWYL+DDhvblEjsqvBOkE8Wz5tC7f1n+6uXos9EyTY=;
 b=GTcSLUMCBEJpg3sHPIpCYdsrs7Rp4JycNGGkP7Qy96rh7474GpRaRVo8eCd6Pn84Nj
 9KYWROnCzQaH0iasnXHah/xGz3BkcNj5akfVAMIoEIYU3Av9GdhmptyIZiHp6tJ06ugn
 B3IAG4uhgKF6SrUyXcLUdt4XINtKYNOxTXWF+F5WtvUHN1Vw9bIrQHXo/s1nto1ue/Yl
 wBYd+UAiUBUVy70b/waGVOV6Y7HXbgcrR11fOy0JbmnRA8l71icpWHkX9aIHD9hxwOZv
 pZ84ECorS+cHzrDCtSTUD3scFLyZA2VxDeoGvkvWxSywvW3UAgKkEmfs9TKUe0yABJQQ
 R0uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734031517; x=1734636317;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=utsWYL+DDhvblEjsqvBOkE8Wz5tC7f1n+6uXos9EyTY=;
 b=ilPbSsknybDmJR59BvKOU4dDz2fDMNds7N4NrCh/vp+rkzdswAzOKmkmssSpZhFal8
 Cq3lPt52dsvfacBBr5LlzQEmXyEueSnxH7Q9W2lKuI5KAt9V5LLp8FBW2WZY2Hh1TXbc
 BIJ4nqZldm6cvBbJZGyex4eVFrdPoE2C6S0lRr/Y4VwTW1fNdS0zQCQhAoUfLEj3SEar
 Q+5oRP7SIT7EQe1VezjYTZ2aSNe5YJn7Shlt+1SV05FbxmNyfm5VTliw83ngk6uH5dTv
 V1b15hBebcK6CzQGgplSRVBmIoUepU0DVo2aPEO3JpyzYRCHDad48fZxt3UGq1zFAomQ
 AV0w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWOulNXOwAPJTapCeml4gv5g5rbKEX1G+AeOaTKan8nMXLkQs561sYkt9Bw86HkDsU8Hz8sawtFyoLt@nongnu.org
X-Gm-Message-State: AOJu0Yz38MfHaSmtFPQjtI5yJrgFKVJGyy3h5RKjnGzg9c2SvIJfmGxp
 zE1fwWzBaVxtFeW4G8kAbgSqDNZhaGfjuNnlvgn08qazqeJ67uSKj1cYT/dsfEw=
X-Gm-Gg: ASbGncusH8oROA/yn0Zyd8gxRIgTF/Gxo6D/oOu4pirw8s7Cygc6SNK6nepaDi6tTld
 xSCQgPdb8xe7hnpqpK9LiFzBiwXGdI0JyuwdzG7texJtlSBb7rFRrek2HdzDFAUdh4fpLRpzUn+
 lFatdrjQWC1tOJOXJHI/lqcuXozVv5QmMKtTAyHU62fz/4wH/vqFTCQT8CP3ElYyj88jhG9I3rL
 vswSuCQkrsjUK1PQPTfboN40rz4/tNOEfhGgGwFjQKIGBwXjkYpr1krB6VQoWmmYGP7AP/Wf1va
 WKXOuwl3bBBLhsGGPE0WFgqJM6dI
X-Google-Smtp-Source: AGHT+IHl/NWOrG/rhjpFoYEEmmZxplLEK7Xb2XJfOZjAjwVu3lfQzpM6/I46V8Z33jj1YlnuktuJjA==
X-Received: by 2002:a05:6a20:12c1:b0:1e0:eb49:b81b with SMTP id
 adf61e73a8af0-1e1dac20a73mr2762347637.31.1734031516996; 
 Thu, 12 Dec 2024 11:25:16 -0800 (PST)
Received: from [192.168.1.67] (216-180-64-156.dyn.novuscom.net.
 [216.180.64.156]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7fd413c315esm7433718a12.34.2024.12.12.11.25.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 12 Dec 2024 11:25:16 -0800 (PST)
Message-ID: <22e222cb-966e-418b-84e8-d7ff9531c23b@linaro.org>
Date: Thu, 12 Dec 2024 11:25:16 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/18] accel/tcg: Un-inline log_pc()
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
References: <20241212185341.2857-1-philmd@linaro.org>
 <20241212185341.2857-10-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20241212185341.2857-10-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x430.google.com
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

T24gMTIvMTIvMjQgMTA6NTMsIFBoaWxpcHBlIE1hdGhpZXUtRGF1ZMOpIHdyb3RlOg0KPiBs
b2dfcGMoKSBpcyBvbmx5IHVzZWQgd2l0aGluIGNwdS1leGVjLmMsIG5vIG5lZWQgdG8NCj4g
ZXhwb3NlIGl0IHZpYSAiaW50ZXJuYWwtdGFyZ2V0LmgiLg0KPiANCj4gU2lnbmVkLW9mZi1i
eTogUGhpbGlwcGUgTWF0aGlldS1EYXVkw6kgPHBoaWxtZEBsaW5hcm8ub3JnPg0KPiAtLS0N
Cj4gICBhY2NlbC90Y2cvaW50ZXJuYWwtdGFyZ2V0LmggfCAxMCAtLS0tLS0tLS0tDQo+ICAg
YWNjZWwvdGNnL2NwdS1leGVjLmMgICAgICAgIHwgMTEgKysrKysrKysrKysNCj4gICAyIGZp
bGVzIGNoYW5nZWQsIDExIGluc2VydGlvbnMoKyksIDEwIGRlbGV0aW9ucygtKQ0KPiANCj4g
ZGlmZiAtLWdpdCBhL2FjY2VsL3RjZy9pbnRlcm5hbC10YXJnZXQuaCBiL2FjY2VsL3RjZy9p
bnRlcm5hbC10YXJnZXQuaA0KPiBpbmRleCA2ZjRlYzBiZDQyNC4uMDQzN2Q3OTgyOTUgMTAw
NjQ0DQo+IC0tLSBhL2FjY2VsL3RjZy9pbnRlcm5hbC10YXJnZXQuaA0KPiArKysgYi9hY2Nl
bC90Y2cvaW50ZXJuYWwtdGFyZ2V0LmgNCj4gQEAgLTcyLDE2ICs3Miw2IEBAIEdfTk9SRVRV
Uk4gdm9pZCBjcHVfaW9fcmVjb21waWxlKENQVVN0YXRlICpjcHUsIHVpbnRwdHJfdCByZXRh
ZGRyKTsNCj4gICANCj4gICBib29sIHRiX2ludmFsaWRhdGVfcGh5c19wYWdlX3Vud2luZCh0
Yl9wYWdlX2FkZHJfdCBhZGRyLCB1aW50cHRyX3QgcGMpOw0KPiAgIA0KPiAtLyogUmV0dXJu
IHRoZSBjdXJyZW50IFBDIGZyb20gQ1BVLCB3aGljaCBtYXkgYmUgY2FjaGVkIGluIFRCLiAq
Lw0KPiAtc3RhdGljIGlubGluZSB2YWRkciBsb2dfcGMoQ1BVU3RhdGUgKmNwdSwgY29uc3Qg
VHJhbnNsYXRpb25CbG9jayAqdGIpDQo+IC17DQo+IC0gICAgaWYgKHRiX2NmbGFncyh0Yikg
JiBDRl9QQ1JFTCkgew0KPiAtICAgICAgICByZXR1cm4gY3B1LT5jYy0+Z2V0X3BjKGNwdSk7
DQo+IC0gICAgfSBlbHNlIHsNCj4gLSAgICAgICAgcmV0dXJuIHRiLT5wYzsNCj4gLSAgICB9
DQo+IC19DQo+IC0NCj4gICAvKioNCj4gICAgKiB0Y2dfcmVxX21vOg0KPiAgICAqIEB0eXBl
OiBUQ0dCYXINCj4gZGlmZiAtLWdpdCBhL2FjY2VsL3RjZy9jcHUtZXhlYy5jIGIvYWNjZWwv
dGNnL2NwdS1leGVjLmMNCj4gaW5kZXggZjgyODcwYTFlMmEuLjM5NmZhNmY0YTZiIDEwMDY0
NA0KPiAtLS0gYS9hY2NlbC90Y2cvY3B1LWV4ZWMuYw0KPiArKysgYi9hY2NlbC90Y2cvY3B1
LWV4ZWMuYw0KPiBAQCAtMjEsNiArMjEsNyBAQA0KPiAgICNpbmNsdWRlICJxZW11L3FlbXUt
cHJpbnQuaCINCj4gICAjaW5jbHVkZSAicWFwaS9lcnJvci5oIg0KPiAgICNpbmNsdWRlICJx
YXBpL3R5cGUtaGVscGVycy5oIg0KPiArI2luY2x1ZGUgImh3L2NvcmUvY3B1LmgiDQo+ICAg
I2luY2x1ZGUgImh3L2NvcmUvdGNnLWNwdS1vcHMuaCINCj4gICAjaW5jbHVkZSAidHJhY2Uu
aCINCj4gICAjaW5jbHVkZSAiZGlzYXMvZGlzYXMuaCINCj4gQEAgLTQzNCw2ICs0MzUsMTYg
QEAgY29uc3Qgdm9pZCAqSEVMUEVSKGxvb2t1cF90Yl9wdHIpKENQVUFyY2hTdGF0ZSAqZW52
KQ0KPiAgICAgICByZXR1cm4gdGItPnRjLnB0cjsNCj4gICB9DQo+ICAgDQo+ICsvKiBSZXR1
cm4gdGhlIGN1cnJlbnQgUEMgZnJvbSBDUFUsIHdoaWNoIG1heSBiZSBjYWNoZWQgaW4gVEIu
ICovDQo+ICtzdGF0aWMgdmFkZHIgbG9nX3BjKENQVVN0YXRlICpjcHUsIGNvbnN0IFRyYW5z
bGF0aW9uQmxvY2sgKnRiKQ0KPiArew0KPiArICAgIGlmICh0Yl9jZmxhZ3ModGIpICYgQ0Zf
UENSRUwpIHsNCj4gKyAgICAgICAgcmV0dXJuIGNwdS0+Y2MtPmdldF9wYyhjcHUpOw0KPiAr
ICAgIH0gZWxzZSB7DQo+ICsgICAgICAgIHJldHVybiB0Yi0+cGM7DQo+ICsgICAgfQ0KPiAr
fQ0KPiArDQo+ICAgLyogRXhlY3V0ZSBhIFRCLCBhbmQgZml4IHVwIHRoZSBDUFUgc3RhdGUg
YWZ0ZXJ3YXJkcyBpZiBuZWNlc3NhcnkgKi8NCj4gICAvKg0KPiAgICAqIERpc2FibGUgQ0ZJ
IGNoZWNrcy4NCg0KUmV2aWV3ZWQtYnk6IFBpZXJyaWNrIEJvdXZpZXIgPHBpZXJyaWNrLmJv
dXZpZXJAbGluYXJvLm9yZz4NCg0K

