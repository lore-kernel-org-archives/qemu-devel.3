Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4A92C47DA9
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jan 2024 07:52:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUiug-0003D8-5l; Tue, 30 Jan 2024 02:52:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1rUiuR-00037Z-RT
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 02:51:58 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1rUiuQ-0005zs-5R
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 02:51:55 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-40e80046264so46208125e9.0
 for <qemu-devel@nongnu.org>; Mon, 29 Jan 2024 23:51:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706601113; x=1707205913; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=F15BY/k/u32IQT9Rupmm/kZX0LD6ysCp/mjS34/EHac=;
 b=MaFSm9mCWej53RNU1eOHIk8raY3sGIGCBFgRLpKuI5tubHsLYu5FCbOl8lTKSyLqvc
 Zlc+evpXN+i1kFi57Zwe215QNwau7jTJabpOTQfLER2LoShw6XWh8ysetnjEu71nUzOw
 eq3TjBS5fW22rvYXQl59JlN2TCNEZb+RV72FfhXxo/jKfZHM7ATmuPZQAs7D7I1EZ3kE
 HLXJmK264ucU8IYLSqypQMevsgWr2tlB6NY4qJnwO/UeDbXXem5tbDJeQACzluUQFHxV
 b9mJWIUVavMmnAvydkYCBIhrHaWwMeGa2OnqLJty7PuZ3dKBQtZXmXr8t7SFgeU5W07s
 7l7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706601113; x=1707205913;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=F15BY/k/u32IQT9Rupmm/kZX0LD6ysCp/mjS34/EHac=;
 b=EWczwp6nLg2V1o8y5eBK3D1K+Iqn2B2nvh+nv6IEOES6cWwVANcea0SG7S5P01Yn7G
 1f/oxiWtoVxZQBVFo5Xse4io/LxCG434YRy/Kdmvw7Lv3Kjs2dfoOr4hRe/urXynuH1M
 oRPZ0OOWLjL8IMqIJnELxUS8tbDFYbpgGcoaA0nVjW9HqdBASh//ZJPcmeV5IbfcxUbe
 k60gWi3hApgp60E1nEphfewD10AD3RBvTmo5BdbWiSwHBh3nvpnRG71pdQx7fzv5LDAI
 mMo6jIidm5c0J/ibxKOzCWkehGtsunhA/CGYEr/ULHSJk0uEFrcfzHWg4yytpV2lO65T
 T6/w==
X-Gm-Message-State: AOJu0YzQSJCvmEcEw7kigMU1Ze2mB/nAmGyT002gMZTx1kk+P6CLdI5m
 A/1NmJAcR3A5CQSnXxzFeRXI0sd8HzjheqLIA8la712RJ5E5a0HDMIhKhWnSOKk=
X-Google-Smtp-Source: AGHT+IEoD7GMkBZQ2TYVeNZHglG2mJuRWnxElRmqzpkoccIS4aH7MWHdCu1G5Acqn5Psz6z6vvGFng==
X-Received: by 2002:a05:6000:1e90:b0:33a:ea12:f54e with SMTP id
 dd16-20020a0560001e9000b0033aea12f54emr3613855wrb.31.1706601112767; 
 Mon, 29 Jan 2024 23:51:52 -0800 (PST)
Received: from [192.168.1.24] ([102.35.208.160])
 by smtp.gmail.com with ESMTPSA id
 f9-20020a056000036900b00339307d9d31sm9946617wrf.112.2024.01.29.23.51.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 29 Jan 2024 23:51:52 -0800 (PST)
Message-ID: <00c684c5-b5d2-4755-8583-1fba8fc7f1fb@linaro.org>
Date: Tue, 30 Jan 2024 11:51:48 +0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 14/14] contrib/plugins/execlog: fix new warnings
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Mahmoud Mandour <ma.mandourr@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>
References: <20240118032400.3762658-1-pierrick.bouvier@linaro.org>
 <20240118032400.3762658-15-pierrick.bouvier@linaro.org>
 <87msssqcnk.fsf@draig.linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <87msssqcnk.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-wm1-x332.google.com
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

T24gMS8yNi8yNCAyMDozMSwgQWxleCBCZW5uw6llIHdyb3RlOg0KPiBQaWVycmljayBCb3V2
aWVyIDxwaWVycmljay5ib3V2aWVyQGxpbmFyby5vcmc+IHdyaXRlczoNCj4gDQo+PiDigJhn
X3BhdHRlcm5fbWF0Y2hfc3RyaW5n4oCZIGlzIGRlcHJlY2F0ZWQsDQo+PiBVc2UgJ2dfcGF0
dGVybl9zcGVjX21hdGNoX3N0cmluZycgaW5zdGVhZC4NCj4gDQo+IFVuZm9ydHVuYXRlbHkg
dGhpcyBpc24ndCBlbm91Z2ggYXMgd2UgY2FuIHN0aWxsIGJ1aWxkIG9uIG9sZGVyIGdsaWJz
Og0KPiANCj4gICAgLyogQXNrIGZvciB3YXJuaW5ncyBmb3IgYW55dGhpbmcgdGhhdCB3YXMg
bWFya2VkIGRlcHJlY2F0ZWQgaW4NCj4gICAgICogdGhlIGRlZmluZWQgdmVyc2lvbiwgb3Ig
YmVmb3JlLiBJdCBpcyBhIGNhbmRpZGF0ZSBmb3IgcmV3cml0ZS4NCj4gICAgICovDQo+ICAg
ICNkZWZpbmUgR0xJQl9WRVJTSU9OX01JTl9SRVFVSVJFRCBHTElCX1ZFUlNJT05fMl81Ng0K
PiANCj4gWW91IGNhbiBkbyBzb21ldGhpbmcgbGlrZToNCj4gDQo+ICAgIC8qDQo+ICAgICAq
IGdfcGF0dGVybl9tYXRjaF9zdHJpbmcgaGFzIGJlZW4gZGVwcmVjYXRlZCBpbiBHbGliIHNp
bmNlIDIuNzAgYW5kDQo+ICAgICAqIHdpbGwgY29tcGxhaW4gYWJvdXQgaXQgaWYgeW91IHRy
eSB0byB1c2UgaXQuIEZvcnR1bmF0ZWx5IHRoZQ0KPiAgICAgKiBzaWduYXR1cmUgb2YgYm90
aCBmdW5jdGlvbnMgaXMgdGhlIHNhbWUgbWFraW5nIGl0IGVhc3kgdG8gd29yaw0KPiAgICAg
KiBhcm91bmQuDQo+ICAgICAqLw0KPiAgICBzdGF0aWMgaW5saW5lDQo+ICAgIGdib29sZWFu
IGdfcGF0dGVybl9zcGVjX21hdGNoX3N0cmluZ19xZW11KEdQYXR0ZXJuU3BlYyAqcHNwZWMs
DQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGNvbnN0
IGdjaGFyICpzdHJpbmcpDQo+ICAgIHsNCj4gICAgI2lmIEdMSUJfQ0hFQ0tfVkVSU0lPTigy
LCA3MCwgMCkNCj4gICAgICAgIHJldHVybiBnX3BhdHRlcm5fc3BlY19tYXRjaF9zdHJpbmco
cHNwZWMsIHN0cmluZyk7DQo+ICAgICNlbHNlDQo+ICAgICAgICByZXR1cm4gZ19wYXR0ZXJu
X21hdGNoX3N0cmluZyhwc3BlYywgc3RyaW5nKTsNCj4gICAgI2VuZGlmDQo+ICAgIH07DQo+
ICAgICNkZWZpbmUgZ19wYXR0ZXJuX3NwZWNfbWF0Y2hfc3RyaW5nKHAsIHMpIGdfcGF0dGVy
bl9zcGVjX21hdGNoX3N0cmluZ19xZW11KHAsIHMpDQo+IA0KPiBpbiBnbGliLWNvbXBhdC5o
IGJ1dCBJIHdhcyB3b25kZXJpbmcgaWYgaXQgd291bGQgYmUgdmFsaWQgdG8gYWRkIHRoYXQN
Cj4gZGVwZW5kZW5jeSB0byBwbHVnaW5zLiBXZSBtaWdodCBnZXQgYXdheSB3aXRoIGl0IGFz
IGl0IGRvZXNuJ3QgaW5jbHVkZQ0KPiBhbnl0aGluZyBmcm9tIFFFTVUgaXRzZWxmLg0KPiAN
Cg0KT2ggSSBzZWUuDQpTaW5jZSBpdCdzIHRoZSBvbmx5IHBsdWdpbiB1c2luZyB0aGlzIHNv
IGZhciwgYW5kIGl0J3MgYSAiY29udHJpYiIgDQpwbHVnaW5zLCBJJ2xsIHNpbXBseSBkcm9w
IHRoaXMgcGF0Y2ggZm9yIG5vdy4gV2UgY2FuIGFsd2F5cyBkaXNjdXNzIHRoaXMgDQphZ2Fp
biBpbiB0aGUgZnV0dXJlLg0KDQpJIHRoaW5rIHlvdSBhcmUgcmlnaHQsIGFuZCBpdCdzIG5v
dCB3b3J0aCBhZGRpbmcgdGhpcyB0byBnbGliLWNvbXBhdC5oLg0KDQo+Pg0KPj4gcGFzc2lu
ZyBhcmd1bWVudCAyIG9mIOKAmGdfcHRyX2FycmF5X2FkZOKAmSBkaXNjYXJkcyDigJhjb25z
dOKAmSBxdWFsaWZpZXIgZnJvbQ0KPj4gcG9pbnRlciB0YXJnZXQgdHlwZQ0KPj4NCj4+IFNp
Z25lZC1vZmYtYnk6IFBpZXJyaWNrIEJvdXZpZXIgPHBpZXJyaWNrLmJvdXZpZXJAbGluYXJv
Lm9yZz4NCj4+IC0tLQ0KPj4gICBjb250cmliL3BsdWdpbnMvZXhlY2xvZy5jIHwgNiArKyst
LS0NCj4+ICAgMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMo
LSkNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvY29udHJpYi9wbHVnaW5zL2V4ZWNsb2cuYyBiL2Nv
bnRyaWIvcGx1Z2lucy9leGVjbG9nLmMNCj4+IGluZGV4IDVhNGRlMWM5M2JlLi5kMTIxMzdj
ZTVjMCAxMDA2NDQNCj4+IC0tLSBhL2NvbnRyaWIvcGx1Z2lucy9leGVjbG9nLmMNCj4+ICsr
KyBiL2NvbnRyaWIvcGx1Z2lucy9leGVjbG9nLmMNCj4+IEBAIC0zMzYsOCArMzM2LDggQEAg
c3RhdGljIHZvaWQgcmVnaXN0ZXJzX2luaXQoaW50IHZjcHVfaW5kZXgpDQo+PiAgICAgICAg
ICAgICAgIGZvciAoaW50IHAgPSAwOyBwIDwgcm1hdGNoZXMtPmxlbjsgcCsrKSB7DQo+PiAg
ICAgICAgICAgICAgICAgICBnX2F1dG9wdHIoR1BhdHRlcm5TcGVjKSBwYXQgPSBnX3BhdHRl
cm5fc3BlY19uZXcocm1hdGNoZXMtPnBkYXRhW3BdKTsNCj4+ICAgICAgICAgICAgICAgICAg
IGdfYXV0b2ZyZWUgZ2NoYXIgKnJkX2xvd2VyID0gZ191dGY4X3N0cmRvd24ocmQtPm5hbWUs
IC0xKTsNCj4+IC0gICAgICAgICAgICAgICAgaWYgKGdfcGF0dGVybl9tYXRjaF9zdHJpbmco
cGF0LCByZC0+bmFtZSkgfHwNCj4+IC0gICAgICAgICAgICAgICAgICAgIGdfcGF0dGVybl9t
YXRjaF9zdHJpbmcocGF0LCByZF9sb3dlcikpIHsNCj4+ICsgICAgICAgICAgICAgICAgaWYg
KGdfcGF0dGVybl9zcGVjX21hdGNoX3N0cmluZyhwYXQsIHJkLT5uYW1lKSB8fA0KPj4gKyAg
ICAgICAgICAgICAgICAgICAgZ19wYXR0ZXJuX3NwZWNfbWF0Y2hfc3RyaW5nKHBhdCwgcmRf
bG93ZXIpKSB7DQo+PiAgICAgICAgICAgICAgICAgICAgICAgUmVnaXN0ZXIgKnJlZyA9IGlu
aXRfdmNwdV9yZWdpc3Rlcih2Y3B1X2luZGV4LCByZCk7DQo+PiAgICAgICAgICAgICAgICAg
ICAgICAgZ19wdHJfYXJyYXlfYWRkKHJlZ2lzdGVycywgcmVnKTsNCj4+ICAgDQo+PiBAQCAt
MzQ1LDcgKzM0NSw3IEBAIHN0YXRpYyB2b2lkIHJlZ2lzdGVyc19pbml0KGludCB2Y3B1X2lu
ZGV4KQ0KPj4gICAgICAgICAgICAgICAgICAgICAgIGlmIChkaXNhc19hc3Npc3QpIHsNCj4+
ICAgICAgICAgICAgICAgICAgICAgICAgICAgZ19tdXRleF9sb2NrKCZhZGRfcmVnX25hbWVf
bG9jayk7DQo+PiAgICAgICAgICAgICAgICAgICAgICAgICAgIGlmICghZ19wdHJfYXJyYXlf
ZmluZChhbGxfcmVnX25hbWVzLCByZWctPm5hbWUsIE5VTEwpKSB7DQo+PiAtICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIGdfcHRyX2FycmF5X2FkZChhbGxfcmVnX25hbWVzLCByZWct
Pm5hbWUpOw0KPj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICBnX3B0cl9hcnJheV9h
ZGQoYWxsX3JlZ19uYW1lcywgKGdwb2ludGVyKXJlZy0+bmFtZSk7DQo+PiAgICAgICAgICAg
ICAgICAgICAgICAgICAgIH0NCj4+ICAgICAgICAgICAgICAgICAgICAgICAgICAgZ19tdXRl
eF91bmxvY2soJmFkZF9yZWdfbmFtZV9sb2NrKTsNCj4+ICAgICAgICAgICAgICAgICAgICAg
ICB9DQo+IA0K

