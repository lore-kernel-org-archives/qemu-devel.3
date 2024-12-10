Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6492E7717F
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2024 18:41:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tL5AB-0000Xg-HW; Tue, 10 Dec 2024 13:40:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tL5A9-0000Wy-EX
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 13:40:49 -0500
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tL5A7-0005sm-LK
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 13:40:49 -0500
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-725f3594965so1836406b3a.3
 for <qemu-devel@nongnu.org>; Tue, 10 Dec 2024 10:40:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733856045; x=1734460845; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=wY9DZy8SI8nUXsIFoOTVaKNvzWxc8v4fILlI68dywqI=;
 b=PTeER4HtMv39k42mk1nrrqwrk7W7+2B0OdiaNkrcMUMWUqu/rPfOZnwfPQ0OrwB+Z3
 j6iYb/J9A+MYjkO7fI2Q+DVOBU0ttZ7Bj1sxRstNYkswAmc/eoPf+gtwwQxsD0NcJqKV
 NSIdNVkAoQfAVl+P0NxTzVOnrOyoh1lyIBKc+t+4AGJHnc43UuFWZ+ahQ6Tncvk2+T5x
 4TGzt48/gyd3jm1aar0xbGvpNMYhbP4vHl+aH8oYIuc7ze/xmfPlCgXL6fFmB4h0zH6q
 /qR+Vl1Wq0Sb9RTrQNkNpCRKV4A5XwYCldd/BllxLSlUJQria/mV4wn5+7HzWHhTUFfl
 zjhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733856045; x=1734460845;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=wY9DZy8SI8nUXsIFoOTVaKNvzWxc8v4fILlI68dywqI=;
 b=sj/DIRG6tkUJMr0/LPGfUEqkJTEtxunbFvaeLwFooXQd0NdJNJKUaXi0XAFjny8Qs8
 ig5NfWPr8HfFJ/K+DXAd9s2yK74wJxJEbnFam3dn8U+lbW15dqCD86hx714ZhSyo5HeP
 IFg3sOQwimnEQ7ZJJ1Ptt/me3xEsA0e44pIFcvN9v4EZNT0Cy1YC9eGvu6zaf9vIQC37
 Ou0M0bIMbLZdbP+iKQF8HegByLDujr8aCxDNFpVgB89dypcVMm73FiACA08LjXTeFkFa
 91gENCpzSgsgTyFbE/nAUvqMLBtK3L8Y/p25dW1MmpEAfqew3nk7yUVSKjOzhVokC7o9
 X5mw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVFZDi86oQc8MA5IdxP4bfwsLjEFXQN8sBseEZs7gNm6iUEzyKJoY3qt18n3m+rb9xpB86p2apbDPCr@nongnu.org
X-Gm-Message-State: AOJu0YxYTeFtbyOumvPwOFzpqQI0551gAiMLM6hAUTEPozd3GMtjAliW
 8ZWw+OFD0keUWKR08r7TGvIwqzKC58Ug2bA1vXAnfCqUHAvxBwHDoRsxgkTVNhE=
X-Gm-Gg: ASbGncvxF6YNFdCVOqvfn1uI8j3VnGvtpWk8LeV0QhataRaa43OhovwnyJ6TcS82ls2
 vWLRZAzTv4KUUR3oje9z8mrh+FaokrimdvYBxZ7uZDhY2/rH0vUJ+fKereEieeypZCNDzmfOVNu
 qZW7FqJv03rGhV3VfyrZgOFLRa/U0IrxlMZe37iZxMYYQK/8ErxfahDYkPd8XrUuGbmEuH1NRoV
 ZUWfdQQzK6Py2CLEjsEbRkC9OdRpKrt7a7LTxx+lPbcHkJjyfTN6stnzybeF9i6sRLrWtTtRFBf
 MrEzciDzXi75Wuj47LA3okJhUQ==
X-Google-Smtp-Source: AGHT+IHoGTYLEftahoK6msSpkcfEbnfnUf4dNuK8+j2VueTg0MJ93UZYcG4rwA9E+26jTueNmW60OA==
X-Received: by 2002:a05:6a00:b87:b0:725:937a:b124 with SMTP id
 d2e1a72fcca58-725b81d84b5mr28837596b3a.26.1733856044978; 
 Tue, 10 Dec 2024 10:40:44 -0800 (PST)
Received: from [192.168.1.67] (216-180-64-156.dyn.novuscom.net.
 [216.180.64.156]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-725e67c2759sm4810013b3a.17.2024.12.10.10.40.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Dec 2024 10:40:44 -0800 (PST)
Message-ID: <6e3b5140-18cc-4f40-bd86-5dadc3e7e6fa@linaro.org>
Date: Tue, 10 Dec 2024 10:40:43 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] Add additional plugin API functions to read and
 write memory and registers
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: Rowan Hart <rowanbhart@gmail.com>, qemu-devel@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, Paolo Bonzini
 <pbonzini@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Peter Maydell <peter.maydell@linaro.org>
References: <20241206102605.961658-1-rowanbhart@gmail.com>
 <55c95bd1-a1bc-460c-b4fe-1f52f8af2c2e@linaro.org>
 <2c0893fa-9d84-4003-861b-91a923f9439f@gmail.com>
 <5b798177-c48f-4f69-8b7b-2b63c74c3505@linaro.org>
 <87o71ju5rg.fsf@draig.linaro.org>
Content-Language: en-US
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <87o71ju5rg.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x431.google.com
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

T24gMTIvMTAvMjQgMDM6MzgsIEFsZXggQmVubsOpZSB3cm90ZToNCj4gUGllcnJpY2sgQm91
dmllciA8cGllcnJpY2suYm91dmllckBsaW5hcm8ub3JnPiB3cml0ZXM6DQo+IA0KPj4gT24g
MTIvNi8yNCAxNjo1NywgUm93YW4gSGFydCB3cm90ZToNCj4+Pj4gSSBhbSBwZXJzb25hbGx5
IGluIGZhdm9yIHRvIGFkZGluZyBzdWNoIGZlYXR1cmVzIGluIHVwc3RyZWFtIFFFTVUsDQo+
Pj4+IGJ1dCB3ZSBzaG91bGQgZGlzY3VzcyBpdCB3aXRoIHRoZSBtYWludGFpbmVycywgYmVj
YXVzZSBpdCB3b3VsZA0KPj4+PiBhbGxvdyB0byBjaGFuZ2UgdGhlIHN0YXRlIG9mIGV4ZWN1
dGlvbiwgd2hpY2ggaXMgc29tZXRoaW5nIHFlbXUNCj4+Pj4gcGx1Z2lucyBhY3RpdmVseSBk
aWRuJ3QgdHJ5IHRvIGRvLiBJdCdzIGEgcmVhbCBwYXJhZGlnbSBzaGlmdCBmb3INCj4+Pj4g
cGx1Z2lucy4NCj4+Pj4NCj4+Pj4gQnkgd3JpdGluZyB0byBtZW1vcnkvcmVnaXN0ZXJzLCB3
ZSBjYW4gc3RhcnQgcmVwbGFjaW5nIGluc3RydWN0aW9ucyBhbmQgY29udHJvbCBmbG93LCBh
bmQgdGhlcmUgaXMgYSB3aG9sZSBzZXQgb2YgY29uc2VxdWVuY2VzIHRvIHRoYXQuDQo+Pj4+
DQo+Pj4gVG90YWxseSBhZ3JlZSEgQXMgbXVjaCBhcyBJIHJlYWxseSB3YW50IHRoaXMgZnVu
Y3Rpb25hbGl0eSBmb3INCj4+PiBwbHVnaW5zLCBJIHRoaW5rDQo+Pj4gYWxpZ25tZW50IG9u
IGl0IGlzIHF1aXRlIGltcG9ydGFudC4gSSBjYW4gc2VlIHZlcnkgY29vbCB1c2UgY2FzZXMg
Zm9yIGJlaW5nDQo+Pj4gYWJsZSB0byByZXBsYWNlIGluc3RydWN0aW9ucyBhbmQgY29udHJv
bCBmbG93IHRvIGFsbG93IGhvb2tpbmcgZnVuY3Rpb25zLA0KPj4+IGhvdHBhdGNoaW5nLCBh
bmQgc28gZm9ydGguDQo+IA0KPiBJIHRoaW5rIGN1cnJlbnRseSB0aGF0IG1ha2VzIHF1aXRl
IGEgbG90IG9mIGRlbWFuZHMgb24gdGhlIHRyYW5zbGF0b3IgdG8NCj4gbWFrZSBzdXJlIHRo
aW5ncyBhcmUga2VwdCBjb25zaXN0ZW50Lg0KPiANCj4gV2UgaGF2ZSBiZWVuIHRhbGtpbmcg
YWJvdXQgbWF5YmUgZW5hYmxpbmcgaHlwZXJjYWxscyBvZiBzb21lIHNvcnQgdG8NCj4gYWxs
b3cgZm9yIGhvb2tpbmcgZXhwbGljaXQgZnVuY3Rpb24gYm91bmRhcmllcyBpbiBsaW51eC11
c2VyLiBBIG5hdHVyYWwNCj4gZXh0ZW5zaW9uIG9mIHRoYXQgd291bGQgYmUgZm9yIGhvc3Qg
bGlicmFyeSBieXBhc3MgZnVuY3Rpb25zLiBJJ20gdW5zdXJlDQo+IG9mIGhvdyB0aGF0IHdv
dWxkIGFwcGx5IGluIHN5c3RlbSBlbXVsYXRpb24gbW9kZSB0aG91Z2ggd2hlcmUgdGhpbmdz
IGFyZQ0KPiBoYW5kbGVkIG9uIGEgbG90IG1vcmUgZ3JhbnVsYXIgbGV2ZWwuDQo+DQoNCklm
IHdlIGFyZSB0YWxraW5nIGFib3V0IHJlcGxhY2luZyBsaWJyYXJ5IGZ1bmN0aW9uIGNhbGxz
IHdpdGggaG9zdCANCnZhcmlhbnRzLCBJJ20gbm90IHN1cmUgaXQncyBjb25uZWN0ZWQgdG8g
dGhlIGh5cGVyY2FsbHMgd2UgYXJlIHRhbGtpbmcgDQphYm91dCBoZXJlLg0KDQo+Pj4gSSBk
b24ndCByZWFsbHkga25vdyB0aGUgZWRnZSBjYXNlcyBoZXJlIHNvIHlvdXIgZXhwZXJ0aXNl
IHdpbGwgYmUNCj4+PiBoZWxwZnVsLiBJbg0KPj4+IHRoZSB3b3JzdCBjYXNlIEkgY2FuIGlt
YWdpbmU6IHdoYXQgd291bGQgaGFwcGVuIGlmIGEgY2FsbGJhY2sgb3Zlcndyb3RlIHRoZQ0K
Pj4+IG5leHQgaW5zbj8gSSdtIG5vdCBzdXJlIHdoYXQgYmVoYXZpb3IgSSB3b3VsZCBleHBl
Y3QgaWYgdGhhdCBpbnNuIGhhcyBhbHJlYWR5DQo+Pj4gYmVlbiB0cmFuc2xhdGVkIGFzIHBh
cnQgb2YgdGhlIHNhbWUgdGIuIFRoYXQgc2FpZCwgdGhlIHBsdWdpbiBpcyBhd2FyZSBvZiB3
aGljaA0KPj4+IGluc25zIGhhdmUgYWxyZWFkeSBiZWVuIHRyYW5zbGF0ZWQsIHNvIG1heWJl
IGl0IGlzIG5vdCB1bnJlYXNvbmFibGUgdG8ganVzdA0KPj4+IGRvY3VtZW50IHRoaXMgYXMg
YSAiZG9uJ3QgZG8gdGhhdCIuIExldCBtZSBrbm93IHdoYXQgeW91IHRoaW5rLg0KPj4+DQo+
Pg0KPj4gSW4gdGhlIGVuZCwgaWYgd2UgaW1wbGVtZW50IHNvbWV0aGluZyB0byBtb2RpZnkg
cnVubmluZyBjb2RlLCB3ZQ0KPj4gc2hvdWxkIG1ha2Ugc3VyZSBpdCB3b3JrcyBhcyBleHBl
Y3RlZCAoZmx1c2hpbmcgdGhlIHJlbGF0ZWQgdGIpLiBJIGFtDQo+PiBub3Qgc3VyZSBhYm91
dCB0aGUgY3VycmVudCBzdGF0dXMsIGFuZCBhbGwgdGhlIGNoYW5nZXMgdGhhdCB3b3VsZCBi
ZQ0KPj4gbmVlZGVkLCBidXQgaXQncyBzb21ldGhpbmcgd2Ugc2hvdWxkIGRpc2N1c3MgYmVm
b3JlIGltcGxlbWVudGluZy4NCj4gDQo+IElmIHRoZSByaWdodCBhY2Nlc3MgaGVscGVycyBh
cmUgdXNlZCB3ZSBldmVudHVhbGx5IGVuZCB1cCBpbiBjcHV0bGIgYW5kDQo+IHRoZSBjb2Rl
IG1vZGlmaWNhdGlvbiBkZXRlY3Rpb24gY29kZSB3aWxsIGtpY2sgaW4uIEJ1dCB0aGF0IGRl
dGVjdGlvbg0KPiBtZWNoYW5pc20gcmVsaWVzIG9uIHRoZSBndWVzdCBjb250cm9sbGVkIHBh
Z2UgdGFibGVzIG1hcmtpbmcgZXhlY3V0YWJsZQ0KPiBjb2RlIGFuZCBob25vdXJpbmcgcncg
cGVybWlzc2lvbnMuIElmIHBsdWdpbnMgZG9uJ3QgaG9ub3VyIHRob3NlDQo+IHBlcm1pc3Np
b25zIHlvdSdsbCBiZWNvbWUgdW5zdHVjayBxdWl0ZSBxdWlja2x5Lg0KPiANCj4+IE1vcmUg
Z2xvYmFsbHksIGxldCdzIHdhaXQgdG8gaGVhciBmZWVkYmFjayBmcm9tIG1haW50YWluZXJz
IHRvIHNlZSBpZg0KPj4gdGhleSBhcmUgb3BlbiB0byB0aGUgaWRlYSBvciBub3QuIEEgImhh
cmQiIG5vIHdvdWxkIGVuZCBpdCB0aGVyZS4NCj4gDQo+IEl0J3Mgbm90IGEgaGFyZCBubyAt
IGJ1dCBJIHRoaW5rIGFueSBzdWNoIHBhdGNoaW5nIGFiaWxpdHkgd291bGQgbmVlZCBhDQo+
IHF1aXRlIGEgYml0IG9mIHRob3VnaHQgdG8gbWFrZSBzdXJlIGVkZ2UgY2FzZXMgYXJlIGNv
dmVyZWQuIEhvd2V2ZXIgSSBkbw0KPiBleHBlY3QgdGhlcmUgd2lsbCBiZSBkb3duc3RyZWFt
IGZvcmtzIHRoYXQgZ28gZnVydGhlciB0aGFuIHRoZSB1cHN0cmVhbQ0KPiBpcyBjdXJyZW50
bHkgY29tZm9ydGFibGUgd2l0aCBhbmQgaWYgdGhlIGNvZGUgaXMgc3RydWN0dXJlZCBpbiB0
aGUgcmlnaHQNCj4gd2F5IHdlIGNhbiBtaW5pbWlzZSB0aGUgcGFpbiBvZiByZS1iYXNpbmcu
DQo+IA0KDQpJbiBhIG1vcmUgc3RyYWlnaHRmb3J3YXJkIHdheSwgZG9lcyBpdCBtZWFuIHlv
dSBhcmUgb3BlbiB0byBjaGFuZ2Ugc3RhdGUgDQpvZiBleGVjdXRpb24gdGhyb3VnaCBwbHVn
aW5zPw0KDQpPdXQgb2YgdGhlIHRlY2huaWNhbCBhc3BlY3QgYW5kIGdldHRpbmcgYWxsIHRo
ZSBjb3JuZXIgY2FzZXMgcmlnaHQsIHdlIA0Kc2hvdWxkIGZpcnN0IGRpc2N1c3MgaWYgd2Ug
d2FudCB0byBnbyB0aGVyZSwgb3IgaWYgd2UgZGVjaWRlIGl0IGRvZXMgbm90IA0KaGF2ZSBp
dHMgcGxhY2UgdXBzdHJlYW0sIGFuZCBzaG91bGQgYmVsb25nIHRvIGRvd25zdHJlYW0gZm9y
a3MgaW5zdGVhZC4NCg0KPj4+PiBUaGUgaHlwZXJjYWxsIGZ1bmN0aW9uYWxpdHkgd291bGQg
YmUgdXNlZnVsIGZvciBwbHVnaW5zIGFzIGEgd2hvbGUuIEFuZCBJIHRoaW5rIGl0IGRlZmlu
aXRlbHkgZGVzZXJ2ZXMgdG8gYmUgd29ya2VkIG9uLCBpZiBtYWludGFpbmVycyBhcmUgb3Bl
biB0byB0aGF0IGFzIHdlbGwuDQo+Pj4gU3VyZSwgSSdkIGJlIGhhcHB5IHRvIHdvcmsgb24g
dGhpcyBzb21lIG1vcmUuIEF0IGxlYXN0IG9uIHRoZQ0KPj4+IGZ1enppbmcgc2lkZSBvZg0K
Pj4+IHRoaW5ncywgdGhlIHdheSBoeXBlcmNhbGxzIGFyZSBkb25lIGFjcm9zcyBoeXBlcnZp
c29ycyAoUUVNVSwgQm9jaHMsIGV0YykgaXMNCj4+PiBwcmV0dHkgY29uc2lzdGVudCBzbyBJ
IHRoaW5rIHdlIGNvdWxkIHByb3ZpZGUgYSB1c2VmdWwgY29tbW9uIHNldCBvZg0KPj4+IGZ1
bmN0aW9uYWxpdHkuIFRoZSByZWFzb24gSSBkaWQgdGhlIGJhcmUgbWluaW11bSBoZXJlIGlz
IEknbSBub3QgZmFtaWxpYXIgd2l0aA0KPj4+IGV2ZXJ5IGFyY2hpdGVjdHVyZSwgYW5kIGEg
Z29vZCBOT1AgbmVlZHMgdG8gYmUgY2hvc2VuIGZvciBlYWNoIG9uZSBhbG9uZyB3aXRoIGEN
Cj4+PiByZWFzb25hYmxlIHdheSB0byBwYXNzIHNvbWUgYXJndW1lbnRzIC0tIEkgZG9uJ3Qg
a25vdyBpZiBJJ20gdGhlIHJpZ2h0IHBlcnNvbg0KPj4+IHRvIG1ha2UgdGhhdCBjYWxsLg0K
Pj4+DQo+Pg0KPj4gV2UgaGF2ZSBiZWVuIGRpc2N1c3Npbmcgc29tZXRoaW5nIGxpa2UgdGhh
dCBmb3Igc3lzdGVtIG1vZGUgcmVjZW50bHksDQo+PiBzbyBpdCB3b3VsZCBkZWZpbml0ZWx5
IGJlIHVzZWZ1bC4NCj4+DQo+PiBJTUhPLCBpdCdzIG9wZW4gZm9yIGFueW9uZSB0byBjb250
cmlidXRlIHRoaXMsIHRoZSBwbHVnaW5zIGFyZWEgaXMgbm90DQo+PiBhIHByaXZhdGUgZ2Fy
ZGVuIHdoZXJlIG9ubHkgY2hvc2VuIG9uZXMgY2FuIGNoYW5nZSB0aGluZ3MuIEp1c3QgYmUN
Cj4+IHByZXBhcmVkIGZvciBjaGFuZ2UgcmVxdWVzdHMsIGFuZCBtdWx0aXBsZSB2ZXJzaW9u
cyBiZWZvcmUgdGhlIGZpbmFsDQo+PiBvbmUuDQo+Pg0KPj4gU2FtZSBvbiB0aGlzIG9uZSwg
d2UnbGwgc2VlIGlmIG1haW50YWluZXJzIGFyZSBvayB3aXRoIHRoZSBpZGVhLg0KPj4NCj4+
PiBHbGFkIHRvIGhlYXIgeW91J3JlIGZvciB0aGlzIGlkZWEhDQo+Pj4gLVJvd2FuDQo+Pg0K
Pj4gVGhhbmtzLA0KPj4gUGllcnJpY2sNCj4gDQoNCg==

