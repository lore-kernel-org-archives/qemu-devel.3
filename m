Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F18DE7717F
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2024 19:22:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLolb-0007kY-3E; Thu, 12 Dec 2024 14:22:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tLolY-0007kM-Uh
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 14:22:28 -0500
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tLolX-0004lZ-3r
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 14:22:28 -0500
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-725c86bbae7so899359b3a.3
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2024 11:22:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734031345; x=1734636145; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=y0PwxKk/gV7xquCA6tGE6tKWjegBIGekYrhWVrKvax8=;
 b=cryZts6PI0imroxSkW86ABsB0Z/6LV5f5rfqOERyR7G2vkrRrbydozoLEEN+xLqti/
 4GyqFne6qN00Aq988+5ws8cWqfCaLe3L+x30o/bRBbVF0CDJaHdnd94hmrx8bFJZw4bl
 mAMEeZ84YduAV7HP+ETmSWMBLfkMB7GDoJofN6yhgMCSOWxYAPrYfhN0UR5NLhx0hVti
 A89pUgRXsCAybkHI0SjE5hM/2jk5N1m82tlVIxMeXxdLH6AQ/WXIHAd119r1DjnV7xIj
 mdmCwBbrbVgSXJulAigraq8v7MAVT7AiWhJjdwUytOFyOyTZKeZwjnl66tSQjbHgk77r
 En1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734031345; x=1734636145;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=y0PwxKk/gV7xquCA6tGE6tKWjegBIGekYrhWVrKvax8=;
 b=lR7ehUXBa5LVq1PIQ96+6DPdyFfs14HKBg4/+9zcl2JcpKBDLdvU0iMA7BqYIWXm7P
 JZrb/gAj6rW37wIyKM5vQtM98gzqWCxXyc7SBpC2UBjdqi1neU/D/tlrCTU3KQ7pMF1g
 m3r5JtRl1F1kiIR0iEsPFGB18u4m9VVPBVYUiJ74mhUIO7EGwWJzCGuEwPCiFlmK59ic
 QzvdhEXcGKi587C1kCSV7lYHtHrtV4XNP+bgzvYpwSrm2XDj6ti+P5CpB8f5hm+fAVR1
 4nihGTItdENH9DVBHTlRSubFjoSGO/xeh48/QDIpOiV3fWbf/tLOiYRSKaYZt1OmGSqw
 RPHQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX/1h+hrGtmRaCdRAo2cX323UtNCGwqLQf8JfnDa0BP/dYk9pq9W9z8X8yDaBYk5pn7M+GlhXdkXGmI@nongnu.org
X-Gm-Message-State: AOJu0YwTNqUCwLK8k3PIJFP7JCe+B0T8d1pxLowQhxNJkcMC6XoG8Bwv
 aIieez1NWaE5Nyi9xRe6FCeIi09y284kpz2SUkVV3dobipVpsLCcbO0sBQr3I5E=
X-Gm-Gg: ASbGncuq2Xho7yCBtlvRXBELlPNKHovTjquagA0Oap23tT8/20G83l6xbxFoh0A5Fzx
 3T1S0SBvA6yl7lgD9oDe0uowRnc0pZXUBxZnJbsv/6EJvHFUyyq2vi0y0OlIy/R5oHy0ceHq6i9
 mCru5G/1FWTUjBxQv0D1/cifXquiNLcA49DgeWqZXTHVbDINSQjtNY7TUYZYxsqEhJ/sa1Hrkhz
 QAa+P8slNmgMIQY6xmpwsU0eHavCJf4CECd6cmtTwoMfX58eFDqFgQVa8VIh5ALK6av+P6JJRio
 0ykvlW93R98rkYugnyyiTKT2CwEu
X-Google-Smtp-Source: AGHT+IFgTXPrKyrlW2yzmSKDqOAzYjAvDJAKpUYVmhKvYuifHyThEC6oFf146SZVyPymb5tTYvmpzw==
X-Received: by 2002:a05:6a00:9283:b0:725:cfa3:bc6b with SMTP id
 d2e1a72fcca58-72906940c11mr2287632b3a.3.1734031345684; 
 Thu, 12 Dec 2024 11:22:25 -0800 (PST)
Received: from [192.168.1.67] (216-180-64-156.dyn.novuscom.net.
 [216.180.64.156]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-725c9ec7217sm10573042b3a.60.2024.12.12.11.22.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 12 Dec 2024 11:22:25 -0800 (PST)
Message-ID: <f2e5348e-8773-460a-a586-8e5be7a87f3b@linaro.org>
Date: Thu, 12 Dec 2024 11:22:24 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/18] include: Include missing 'qemu/clang-tsa.h' header
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
References: <20241212185341.2857-1-philmd@linaro.org>
 <20241212185341.2857-4-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20241212185341.2857-4-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x429.google.com
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

T24gMTIvMTIvMjQgMTA6NTMsIFBoaWxpcHBlIE1hdGhpZXUtRGF1ZMOpIHdyb3RlOg0KPiBU
aGUgbmV4dCBjb21taXQgd2lsbCByZW1vdmUgInFlbXUvY2xhbmctdHNhLmgiIG9mICJleGVj
L2V4ZWMtYWxsLmgiLA0KPiBob3dldmVyIHRoZSBmb2xsb3dpbmcgZmlsZXMgaW5kaXJlY3Rs
eSBpbmNsdWRlIGl0Og0KPiANCj4gICAgJCBnaXQgZ3JlcCAtTCBxZW11L2NsYW5nLXRzYS5o
ICQoZ2l0IGdyZXAgLXdsIFRTQV9OT19UU0EpDQo+ICAgIGJsb2NrL2NyZWF0ZS5jDQo+ICAg
IGluY2x1ZGUvYmxvY2svYmxvY2tfaW50LWNvbW1vbi5oDQo+ICAgIHRlc3RzL3VuaXQvdGVz
dC1iZHJ2LWRyYWluLmMNCj4gICAgdGVzdHMvdW5pdC90ZXN0LWJsb2NrLWlvdGhyZWFkLmMN
Cj4gICAgdXRpbC9xZW11LXRocmVhZC1wb3NpeC5jDQo+IA0KPiBFeHBsaWNpdGx5IGluY2x1
ZGUgaXQgc28gd2UgY2FuIHByb2Nlc3Mgd2l0aCB0aGUgcmVtb3ZhbCBpbiB0aGUNCj4gbmV4
dCBjb21taXQuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBQaGlsaXBwZSBNYXRoaWV1LURhdWTD
qSA8cGhpbG1kQGxpbmFyby5vcmc+DQo+IC0tLQ0KPiAgIGluY2x1ZGUvYmxvY2svYmxvY2tf
aW50LWNvbW1vbi5oIHwgMSArDQo+ICAgYmxvY2svY3JlYXRlLmMgICAgICAgICAgICAgICAg
ICAgfCAxICsNCj4gICB0ZXN0cy91bml0L3Rlc3QtYmRydi1kcmFpbi5jICAgICB8IDEgKw0K
PiAgIHRlc3RzL3VuaXQvdGVzdC1ibG9jay1pb3RocmVhZC5jIHwgMSArDQo+ICAgdXRpbC9x
ZW11LXRocmVhZC1wb3NpeC5jICAgICAgICAgfCAxICsNCj4gICA1IGZpbGVzIGNoYW5nZWQs
IDUgaW5zZXJ0aW9ucygrKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvYmxvY2svYmxv
Y2tfaW50LWNvbW1vbi5oIGIvaW5jbHVkZS9ibG9jay9ibG9ja19pbnQtY29tbW9uLmgNCj4g
aW5kZXggZWJiNGU1NmE1MDMuLmJiOTFhMGY2MmZhIDEwMDY0NA0KPiAtLS0gYS9pbmNsdWRl
L2Jsb2NrL2Jsb2NrX2ludC1jb21tb24uaA0KPiArKysgYi9pbmNsdWRlL2Jsb2NrL2Jsb2Nr
X2ludC1jb21tb24uaA0KPiBAQCAtMjgsNiArMjgsNyBAQA0KPiAgICNpbmNsdWRlICJibG9j
ay9ibG9jay1jb21tb24uaCINCj4gICAjaW5jbHVkZSAiYmxvY2svYmxvY2stZ2xvYmFsLXN0
YXRlLmgiDQo+ICAgI2luY2x1ZGUgImJsb2NrL3NuYXBzaG90LmgiDQo+ICsjaW5jbHVkZSAi
cWVtdS9jbGFuZy10c2EuaCINCj4gICAjaW5jbHVkZSAicWVtdS9pb3YuaCINCj4gICAjaW5j
bHVkZSAicWVtdS9yY3UuaCINCj4gICAjaW5jbHVkZSAicWVtdS9zdGF0czY0LmgiDQo+IGRp
ZmYgLS1naXQgYS9ibG9jay9jcmVhdGUuYyBiL2Jsb2NrL2NyZWF0ZS5jDQo+IGluZGV4IDZi
MjNhMjE2NzUzLi43MmFiYWZiNGMxMiAxMDA2NDQNCj4gLS0tIGEvYmxvY2svY3JlYXRlLmMN
Cj4gKysrIGIvYmxvY2svY3JlYXRlLmMNCj4gQEAgLTI0LDYgKzI0LDcgQEANCj4gICANCj4g
ICAjaW5jbHVkZSAicWVtdS9vc2RlcC5oIg0KPiAgICNpbmNsdWRlICJibG9jay9ibG9ja19p
bnQuaCINCj4gKyNpbmNsdWRlICJxZW11L2NsYW5nLXRzYS5oIg0KPiAgICNpbmNsdWRlICJx
ZW11L2pvYi5oIg0KPiAgICNpbmNsdWRlICJxZW11L21haW4tbG9vcC5oIg0KPiAgICNpbmNs
dWRlICJxYXBpL3FhcGktY29tbWFuZHMtYmxvY2stY29yZS5oIg0KPiBkaWZmIC0tZ2l0IGEv
dGVzdHMvdW5pdC90ZXN0LWJkcnYtZHJhaW4uYyBiL3Rlc3RzL3VuaXQvdGVzdC1iZHJ2LWRy
YWluLmMNCj4gaW5kZXggNzQxMGU2ZjM1MjguLjk4YWQ4OWIzOTBjIDEwMDY0NA0KPiAtLS0g
YS90ZXN0cy91bml0L3Rlc3QtYmRydi1kcmFpbi5jDQo+ICsrKyBiL3Rlc3RzL3VuaXQvdGVz
dC1iZHJ2LWRyYWluLmMNCj4gQEAgLTI4LDYgKzI4LDcgQEANCj4gICAjaW5jbHVkZSAic3lz
dGVtL2Jsb2NrLWJhY2tlbmQuaCINCj4gICAjaW5jbHVkZSAicWFwaS9lcnJvci5oIg0KPiAg
ICNpbmNsdWRlICJxZW11L21haW4tbG9vcC5oIg0KPiArI2luY2x1ZGUgInFlbXUvY2xhbmct
dHNhLmgiDQo+ICAgI2luY2x1ZGUgImlvdGhyZWFkLmgiDQo+ICAgDQo+ICAgc3RhdGljIFFl
bXVFdmVudCBkb25lX2V2ZW50Ow0KPiBkaWZmIC0tZ2l0IGEvdGVzdHMvdW5pdC90ZXN0LWJs
b2NrLWlvdGhyZWFkLmMgYi90ZXN0cy91bml0L3Rlc3QtYmxvY2staW90aHJlYWQuYw0KPiBp
bmRleCAyNmE2YzA1MTc1OC4uMWRlMDRhOGExM2QgMTAwNjQ0DQo+IC0tLSBhL3Rlc3RzL3Vu
aXQvdGVzdC1ibG9jay1pb3RocmVhZC5jDQo+ICsrKyBiL3Rlc3RzL3VuaXQvdGVzdC1ibG9j
ay1pb3RocmVhZC5jDQo+IEBAIC0yOSw2ICsyOSw3IEBADQo+ICAgI2luY2x1ZGUgInN5c3Rl
bS9ibG9jay1iYWNrZW5kLmgiDQo+ICAgI2luY2x1ZGUgInFhcGkvZXJyb3IuaCINCj4gICAj
aW5jbHVkZSAicWFwaS9xbXAvcWRpY3QuaCINCj4gKyNpbmNsdWRlICJxZW11L2NsYW5nLXRz
YS5oIg0KPiAgICNpbmNsdWRlICJxZW11L21haW4tbG9vcC5oIg0KPiAgICNpbmNsdWRlICJp
b3RocmVhZC5oIg0KPiAgIA0KPiBkaWZmIC0tZ2l0IGEvdXRpbC9xZW11LXRocmVhZC1wb3Np
eC5jIGIvdXRpbC9xZW11LXRocmVhZC1wb3NpeC5jDQo+IGluZGV4IGIyZTI2ZTIxMjA1Li42
ZmZmNDE2MmFjNiAxMDA2NDQNCj4gLS0tIGEvdXRpbC9xZW11LXRocmVhZC1wb3NpeC5jDQo+
ICsrKyBiL3V0aWwvcWVtdS10aHJlYWQtcG9zaXguYw0KPiBAQCAtMTcsNiArMTcsNyBAQA0K
PiAgICNpbmNsdWRlICJxZW11LXRocmVhZC1jb21tb24uaCINCj4gICAjaW5jbHVkZSAicWVt
dS90c2FuLmgiDQo+ICAgI2luY2x1ZGUgInFlbXUvYml0bWFwLmgiDQo+ICsjaW5jbHVkZSAi
cWVtdS9jbGFuZy10c2EuaCINCj4gICANCj4gICAjaWZkZWYgQ09ORklHX1BUSFJFQURfU0VU
X05BTUVfTlANCj4gICAjaW5jbHVkZSA8cHRocmVhZF9ucC5oPg0KDQpTZWVtcyBsaWtlIGEg
YmV0dGVyIHBsYWNlIGZvciBhbGwgdGhpcyB3b3VsZCBiZSBpbjoNCmluY2x1ZGUvcWVtdS9j
b21waWxlci5oLCBpbnN0ZWFkIG9mIGEgc2VwYXJhdGUgY2xhbmctdHNhIGhlYWRlci4NCg0K
QnV0IGZvciB0aGUgY3VycmVudCB2ZXJzaW9uLA0KUmV2aWV3ZWQtYnk6IFBpZXJyaWNrIEJv
dXZpZXIgPHBpZXJyaWNrLmJvdXZpZXJAbGluYXJvLm9yZz4NCg0K

