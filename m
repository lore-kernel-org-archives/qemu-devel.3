Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 180ACC5475B
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Mar 2024 09:45:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfzNq-00078I-8d; Fri, 01 Mar 2024 04:40:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1rfzNj-0006SE-6G
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 04:40:47 -0500
Received: from mail-lj1-x236.google.com ([2a00:1450:4864:20::236])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1rfzNg-0006nd-Us
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 04:40:42 -0500
Received: by mail-lj1-x236.google.com with SMTP id
 38308e7fff4ca-2d311081954so16621381fa.2
 for <qemu-devel@nongnu.org>; Fri, 01 Mar 2024 01:40:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709286037; x=1709890837; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Wt0BOcnSpo/3ofseFCOKCpIXtYfeyqRnv70PZLb2BjE=;
 b=ZBTj3jak3JDNVv1K8TsGqmoJNR5AlnS1lxsojCOOkstAsBaIjhEfKuN0vccA8xAyzD
 DdWJ0FblNH1LxxQV2l03lNuG5DoueYUxZB+PLG+QGhZZZ6Q76T9FGmXMmGDuWiDTEpUo
 7au73fzJjEJBEHra693VWbgZmK64BiIVznKlBlWGCv08oLBvfI3WaccFegSp7uQTtFib
 0HxgOviYpw54Ro/NCNAOvWNRraSjbwm0/eOYG0Zu7lK3JU/+LUf/iecf374ZgTmCMIpw
 bplb6yE/W6bWWTH1x3zzlsay/enrvRu+/H0Lc5koP98ko5BS3IOo5DqrWB/5yHsmWXYz
 4JKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709286037; x=1709890837;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Wt0BOcnSpo/3ofseFCOKCpIXtYfeyqRnv70PZLb2BjE=;
 b=WXbMz7bERl9LoUHsGNv8zH9IsfFGuXxlyGP4d2bwnIW5e1/IinL0/BuiTSydeA+JZ6
 Imr7tJyOPI0Iy4kTlcP6DV/PnS8siUicH2B435MQswkxSCDRPNCKXQjhYhfDi+EAaWpM
 ivUCyRQJOwaxENSjtiswrKGaURCwC3xydWAzQp+3dsYG75AYQBKvziZE0y0eXfhAz4PP
 j5BHuyoaahtSXmMF1xhrmpbEHnNJEEsET/IK5Fk77Zo7wWr0gEg0JzcLUdEwuYUuJ7OM
 ZdT9sPnusmI4o/DE0xSsIb8L3GCe4tek3fTem9qJEPjyq5eD3vr9M2yaMDUDsr+rwDSs
 jnRg==
X-Gm-Message-State: AOJu0Yy2BItVKSoIMvAgGQLdO4Ufgv0oUAnnjU2gcMLd/iUV2PGAMktY
 OSqhACr+rWCrvk1LL6lQzzV7OreAhRo5VyYmZUfUd/ElALvZgUU6lCnAl08sbls=
X-Google-Smtp-Source: AGHT+IEDthvEVUZJ1JvhBZ8uILkBLCcT+jUBBaPs+vSuuYd/hO0vPV4Ub0dZZNauKrkvBwRxoADD6A==
X-Received: by 2002:a05:651c:382:b0:2d2:6820:a9f1 with SMTP id
 e2-20020a05651c038200b002d26820a9f1mr782634ljp.14.1709286036954; 
 Fri, 01 Mar 2024 01:40:36 -0800 (PST)
Received: from [192.168.1.24] ([102.35.208.160])
 by smtp.gmail.com with ESMTPSA id
 u17-20020a05600c19d100b00412a31d2e2asm4860695wmq.32.2024.03.01.01.40.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 01 Mar 2024 01:40:36 -0800 (PST)
Message-ID: <0dbaebb4-645e-495b-abb0-5eca86d180a2@linaro.org>
Date: Fri, 1 Mar 2024 13:40:30 +0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 06/12] tests/plugin/mem: migrate to new per_vcpu API
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Mahmoud Mandour <ma.mandourr@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Luc Michel <luc.michel@amd.com>
References: <20240229052506.933222-1-pierrick.bouvier@linaro.org>
 <20240229052506.933222-7-pierrick.bouvier@linaro.org>
 <87y1b35ej7.fsf@draig.linaro.org>
Content-Language: en-US
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <87y1b35ej7.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2a00:1450:4864:20::236;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-lj1-x236.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

T24gMi8yOS8yNCAxMDowOCBQTSwgQWxleCBCZW5uw6llIHdyb3RlOg0KPiBQaWVycmljayBC
b3V2aWVyIDxwaWVycmljay5ib3V2aWVyQGxpbmFyby5vcmc+IHdyaXRlczoNCj4gDQo+PiBS
ZXZpZXdlZC1ieTogTHVjIE1pY2hlbCA8bHVjLm1pY2hlbEBhbWQuY29tPg0KPj4gU2lnbmVk
LW9mZi1ieTogUGllcnJpY2sgQm91dmllciA8cGllcnJpY2suYm91dmllckBsaW5hcm8ub3Jn
Pg0KPj4gLS0tDQo+PiAgIHRlc3RzL3BsdWdpbi9tZW0uYyB8IDQ2ICsrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKystLS0tLS0tLS0tLS0tLS0NCj4+ICAgMSBmaWxlIGNoYW5nZWQs
IDMxIGluc2VydGlvbnMoKyksIDE1IGRlbGV0aW9ucygtKQ0KPj4NCj4+IGRpZmYgLS1naXQg
YS90ZXN0cy9wbHVnaW4vbWVtLmMgYi90ZXN0cy9wbHVnaW4vbWVtLmMNCj4+IGluZGV4IDQ0
ZTkxMDY1YmE3Li5iNjUwZGRkY2NlMSAxMDA2NDQNCj4+IC0tLSBhL3Rlc3RzL3BsdWdpbi9t
ZW0uYw0KPj4gKysrIGIvdGVzdHMvcGx1Z2luL21lbS5jDQo+PiBAQCAtMTYsOSArMTYsMTQg
QEANCj4+ICAgDQo+PiAgIFFFTVVfUExVR0lOX0VYUE9SVCBpbnQgcWVtdV9wbHVnaW5fdmVy
c2lvbiA9IFFFTVVfUExVR0lOX1ZFUlNJT047DQo+PiAgIA0KPj4gLXN0YXRpYyB1aW50NjRf
dCBpbmxpbmVfbWVtX2NvdW50Ow0KPj4gLXN0YXRpYyB1aW50NjRfdCBjYl9tZW1fY291bnQ7
DQo+PiAtc3RhdGljIHVpbnQ2NF90IGlvX2NvdW50Ow0KPj4gK3R5cGVkZWYgc3RydWN0IHsN
Cj4+ICsgICAgdWludDY0X3QgbWVtX2NvdW50Ow0KPj4gKyAgICB1aW50NjRfdCBpb19jb3Vu
dDsNCj4+ICt9IENQVUNvdW50Ow0KPj4gKw0KPj4gK3N0YXRpYyBzdHJ1Y3QgcWVtdV9wbHVn
aW5fc2NvcmVib2FyZCAqY291bnRzOw0KPj4gK3N0YXRpYyBxZW11X3BsdWdpbl91NjQgbWVt
X2NvdW50Ow0KPj4gK3N0YXRpYyBxZW11X3BsdWdpbl91NjQgaW9fY291bnQ7DQo+PiAgIHN0
YXRpYyBib29sIGRvX2lubGluZSwgZG9fY2FsbGJhY2s7DQo+PiAgIHN0YXRpYyBib29sIGRv
X2hhZGRyOw0KPj4gICBzdGF0aWMgZW51bSBxZW11X3BsdWdpbl9tZW1fcncgcncgPSBRRU1V
X1BMVUdJTl9NRU1fUlc7DQo+PiBAQCAtMjcsMTYgKzMyLDE2IEBAIHN0YXRpYyB2b2lkIHBs
dWdpbl9leGl0KHFlbXVfcGx1Z2luX2lkX3QgaWQsIHZvaWQgKnApDQo+PiAgIHsNCj4+ICAg
ICAgIGdfYXV0b3B0cihHU3RyaW5nKSBvdXQgPSBnX3N0cmluZ19uZXcoIiIpOw0KPj4gICAN
Cj4+IC0gICAgaWYgKGRvX2lubGluZSkgew0KPj4gLSAgICAgICAgZ19zdHJpbmdfcHJpbnRm
KG91dCwgImlubGluZSBtZW0gYWNjZXNzZXM6ICUiIFBSSXU2NCAiXG4iLCBpbmxpbmVfbWVt
X2NvdW50KTsNCj4+IC0gICAgfQ0KPj4gLSAgICBpZiAoZG9fY2FsbGJhY2spIHsNCj4+IC0g
ICAgICAgIGdfc3RyaW5nX2FwcGVuZF9wcmludGYob3V0LCAiY2FsbGJhY2sgbWVtIGFjY2Vz
c2VzOiAlIiBQUkl1NjQgIlxuIiwgY2JfbWVtX2NvdW50KTsNCj4+ICsgICAgaWYgKGRvX2lu
bGluZSB8fCBkb19jYWxsYmFjaykgew0KPj4gKyAgICAgICAgZ19zdHJpbmdfcHJpbnRmKG91
dCwgIm1lbSBhY2Nlc3NlczogJSIgUFJJdTY0ICJcbiIsDQo+PiArICAgICAgICAgICAgICAg
ICAgICAgICAgcWVtdV9wbHVnaW5fdTY0X3N1bShtZW1fY291bnQpKTsNCj4+ICAgICAgIH0N
Cj4+ICAgICAgIGlmIChkb19oYWRkcikgew0KPj4gLSAgICAgICAgZ19zdHJpbmdfYXBwZW5k
X3ByaW50ZihvdXQsICJpbyBhY2Nlc3NlczogJSIgUFJJdTY0ICJcbiIsIGlvX2NvdW50KTsN
Cj4+ICsgICAgICAgIGdfc3RyaW5nX2FwcGVuZF9wcmludGYob3V0LCAiaW8gYWNjZXNzZXM6
ICUiIFBSSXU2NCAiXG4iLA0KPj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBx
ZW11X3BsdWdpbl91NjRfc3VtKGlvX2NvdW50KSk7DQo+PiAgICAgICB9DQo+PiAgICAgICBx
ZW11X3BsdWdpbl9vdXRzKG91dC0+c3RyKTsNCj4+ICsgICAgcWVtdV9wbHVnaW5fc2NvcmVi
b2FyZF9mcmVlKGNvdW50cyk7DQo+PiAgIH0NCj4+ICAgDQo+PiAgIHN0YXRpYyB2b2lkIHZj
cHVfbWVtKHVuc2lnbmVkIGludCBjcHVfaW5kZXgsIHFlbXVfcGx1Z2luX21lbWluZm9fdCBt
ZW1pbmZvLA0KPj4gQEAgLTQ2LDEyICs1MSwxMiBAQCBzdGF0aWMgdm9pZCB2Y3B1X21lbSh1
bnNpZ25lZCBpbnQgY3B1X2luZGV4LCBxZW11X3BsdWdpbl9tZW1pbmZvX3QgbWVtaW5mbywN
Cj4+ICAgICAgICAgICBzdHJ1Y3QgcWVtdV9wbHVnaW5faHdhZGRyICpod2FkZHI7DQo+PiAg
ICAgICAgICAgaHdhZGRyID0gcWVtdV9wbHVnaW5fZ2V0X2h3YWRkcihtZW1pbmZvLCB2YWRk
cik7DQo+PiAgICAgICAgICAgaWYgKHFlbXVfcGx1Z2luX2h3YWRkcl9pc19pbyhod2FkZHIp
KSB7DQo+PiAtICAgICAgICAgICAgaW9fY291bnQrKzsNCj4+ICsgICAgICAgICAgICBxZW11
X3BsdWdpbl91NjRfYWRkKGlvX2NvdW50LCBjcHVfaW5kZXgsIDEpOw0KPj4gICAgICAgICAg
IH0gZWxzZSB7DQo+PiAtICAgICAgICAgICAgY2JfbWVtX2NvdW50Kys7DQo+PiArICAgICAg
ICAgICAgcWVtdV9wbHVnaW5fdTY0X2FkZChtZW1fY291bnQsIGNwdV9pbmRleCwgMSk7DQo+
PiAgICAgICAgICAgfQ0KPj4gICAgICAgfSBlbHNlIHsNCj4+IC0gICAgICAgIGNiX21lbV9j
b3VudCsrOw0KPj4gKyAgICAgICAgcWVtdV9wbHVnaW5fdTY0X2FkZChtZW1fY291bnQsIGNw
dV9pbmRleCwgMSk7DQo+PiAgICAgICB9DQo+PiAgIH0NCj4+ICAgDQo+PiBAQCAtNjQsOSAr
NjksMTAgQEAgc3RhdGljIHZvaWQgdmNwdV90Yl90cmFucyhxZW11X3BsdWdpbl9pZF90IGlk
LCBzdHJ1Y3QgcWVtdV9wbHVnaW5fdGIgKnRiKQ0KPj4gICAgICAgICAgIHN0cnVjdCBxZW11
X3BsdWdpbl9pbnNuICppbnNuID0gcWVtdV9wbHVnaW5fdGJfZ2V0X2luc24odGIsIGkpOw0K
Pj4gICANCj4+ICAgICAgICAgICBpZiAoZG9faW5saW5lKSB7DQo+PiAtICAgICAgICAgICAg
cWVtdV9wbHVnaW5fcmVnaXN0ZXJfdmNwdV9tZW1faW5saW5lKGluc24sIHJ3LA0KPj4gLSAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBRRU1VX1BM
VUdJTl9JTkxJTkVfQUREX1U2NCwNCj4+IC0gICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgJmlubGluZV9tZW1fY291bnQsIDEpOw0KPj4gKyAgICAg
ICAgICAgIHFlbXVfcGx1Z2luX3JlZ2lzdGVyX3ZjcHVfbWVtX2lubGluZV9wZXJfdmNwdSgN
Cj4+ICsgICAgICAgICAgICAgICAgaW5zbiwgcncsDQo+PiArICAgICAgICAgICAgICAgIFFF
TVVfUExVR0lOX0lOTElORV9BRERfVTY0LA0KPj4gKyAgICAgICAgICAgICAgICBtZW1fY291
bnQsIDEpOw0KPj4gICAgICAgICAgIH0NCj4+ICAgICAgICAgICBpZiAoZG9fY2FsbGJhY2sp
IHsNCj4+ICAgICAgICAgICAgICAgcWVtdV9wbHVnaW5fcmVnaXN0ZXJfdmNwdV9tZW1fY2Io
aW5zbiwgdmNwdV9tZW0sDQo+PiBAQCAtMTE3LDYgKzEyMywxNiBAQCBRRU1VX1BMVUdJTl9F
WFBPUlQgaW50IHFlbXVfcGx1Z2luX2luc3RhbGwocWVtdV9wbHVnaW5faWRfdCBpZCwNCj4+
ICAgICAgICAgICB9DQo+PiAgICAgICB9DQo+PiAgIA0KPj4gKyAgICBpZiAoZG9faW5saW5l
ICYmIGRvX2NhbGxiYWNrKSB7DQo+PiArICAgICAgICBmcHJpbnRmKHN0ZGVyciwNCj4+ICsg
ICAgICAgICAgICAgICAgImNhbid0IGVuYWJsZSBpbmxpbmUgYW5kIGNhbGxiYWNrIGNvdW50
aW5nIGF0IHRoZSBzYW1lIHRpbWVcbiIpOw0KPj4gKyAgICAgICAgcmV0dXJuIC0xOw0KPj4g
KyAgICB9DQo+PiArDQo+PiArICAgIGNvdW50cyA9IHFlbXVfcGx1Z2luX3Njb3JlYm9hcmRf
bmV3KHNpemVvZihDUFVDb3VudCkpOw0KPj4gKyAgICBtZW1fY291bnQgPSBxZW11X3BsdWdp
bl9zY29yZWJvYXJkX3U2NF9pbl9zdHJ1Y3QoDQo+PiArICAgICAgICBjb3VudHMsIENQVUNv
dW50LCBtZW1fY291bnQpOw0KPj4gKyAgICBpb19jb3VudCA9IHFlbXVfcGx1Z2luX3Njb3Jl
Ym9hcmRfdTY0X2luX3N0cnVjdChjb3VudHMsIENQVUNvdW50LCBpb19jb3VudCk7DQo+PiAg
ICAgICBxZW11X3BsdWdpbl9yZWdpc3Rlcl92Y3B1X3RiX3RyYW5zX2NiKGlkLCB2Y3B1X3Ri
X3RyYW5zKTsNCj4+ICAgICAgIHFlbXVfcGx1Z2luX3JlZ2lzdGVyX2F0ZXhpdF9jYihpZCwg
cGx1Z2luX2V4aXQsIE5VTEwpOw0KPj4gICAgICAgcmV0dXJuIDA7DQo+IA0KPiBZb3UgbmVl
ZCB0aGUgZm9sbG93aW5nIHRvIGtlZXAgY2hlY2stdGNnIHdvcmtpbmc6DQo+IA0KPiBtb2Rp
ZmllZCAgIHRlc3RzL3RjZy9NYWtlZmlsZS50YXJnZXQNCj4gQEAgLTE2OCw3ICsxNjgsNyBA
QCBSVU5fVEVTVFMrPSQoRVhUUkFfUlVOUykNCj4gICANCj4gICAjIFNvbWUgcGx1Z2lucyBu
ZWVkIGFkZGl0aW9uYWwgYXJndW1lbnRzIGFib3ZlIHRoZSBkZWZhdWx0IHRvIGZ1bGx5DQo+
ICAgIyBleGVyY2lzZSB0aGluZ3MuIFdlIGNhbiBkZWZpbmUgdGhlbSBvbiBhIHBlci10ZXN0
IGJhc2lzIGhlcmUuDQo+IC1ydW4tcGx1Z2luLSUtd2l0aC1saWJtZW0uc286IFBMVUdJTl9B
UkdTPSQoQ09NTUEpaW5saW5lPXRydWUkKENPTU1BKWNhbGxiYWNrPXRydWUNCj4gK3J1bi1w
bHVnaW4tJS13aXRoLWxpYm1lbS5zbzogUExVR0lOX0FSR1M9JChDT01NQSlpbmxpbmU9dHJ1
ZQ0KPiAgIA0KPiAgIGlmZXEgKCQoZmlsdGVyICUtc29mdG1tdSwgJChUQVJHRVQpKSwpDQo+
ICAgcnVuLSU6ICUNCj4gDQoNCk1pc3NlZCB0aGF0LCB3aWxsIGZpeCBpbiBuZXh0IHZlcnNp
b24uIFRoYW5rcyENCg==

