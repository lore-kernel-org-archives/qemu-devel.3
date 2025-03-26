Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9029C36008
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Mar 2025 15:30:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1txShC-0000wm-C4; Wed, 26 Mar 2025 11:29:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1txSh6-0000uC-Ip
 for qemu-devel@nongnu.org; Wed, 26 Mar 2025 11:29:28 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1txSh4-0005jU-Sh
 for qemu-devel@nongnu.org; Wed, 26 Mar 2025 11:29:28 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-22435603572so19225ad.1
 for <qemu-devel@nongnu.org>; Wed, 26 Mar 2025 08:29:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743002965; x=1743607765; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=fdEf12LSslB4oUI25nMZyF9w6ESKOFnBc1a3wsIH7f0=;
 b=d7QbnxEh2XnE7WGwGFbT+GeuJEzXtooP3YcQ3AcW0fREXm9Hg23R9TCGqZ5R3cxV4z
 QxDkgTbhrMRuxbc1JqA77DNHaXpjppEWgn/dDqtr++52adq8iPLVC+OBICAspH4Fg8je
 edsJKDUmSl2Zc58OSgjVxvTnUfHCcQ0gZ6wUvLJK8K9WII4fpPBv58XB3FJ4+2Rs8xN5
 s/3ElrDbILywgUe5NipQPFmkcwCwdfpwTDP5aGsLY2vLCpgnPxvM57X5GWgnXQidQ9/0
 6JgIp4BIWnkOA/3Cw2+an0Fr1nLjX/EYzerbanE1y6lMQdGCgmnGwiuduTVnqtY3JmL3
 LCFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743002965; x=1743607765;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fdEf12LSslB4oUI25nMZyF9w6ESKOFnBc1a3wsIH7f0=;
 b=SIsFgEtNWUddVoiHdXt09deqR8UotGoAAZuePePv/JN8RrcXL6Va++d1jpzQDNC35h
 rA9XgefPfBeZ3oYbBbtSj/sIgiuGzWrA2qxPIEtKFe5W0LV1V7bCaIi+kA0q7lYDcv4d
 82tN9F5XQDcM9NTl5kTg0azadcwhnZ3UwvAFuKt4Dr41H0yyvnfASOwhh7JgIJF41y+J
 Rpit5swEA4/A6q0UYOU7w0z4N3HVnOXckpCCS20ASuTG02QK8kwi8R3TWmGjyx9WEew5
 d/OzYXDnRLycii7d+M4uGhh7gxVGZ07Rz5v6llf3lefBRU8PUqUl8cqEzTp3y0YgZUJ4
 Ft2w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXyG7d1Y4ddsXVTOEyjdWcNAj2xIfWm5ZERoD3Wl+R0sG1Xg8EJPm/cKTrXPFiPzVYtex+/FjMNIuFi@nongnu.org
X-Gm-Message-State: AOJu0YwpAt2Gd8i+mMcwSlPK0dM1e41+ZQg4SciMcNrdBPxvR9Wx51Ts
 NIs1WxDUAb5oxE3Xna/5pIzc/sqKZ634CqFHOB1nzVy4GYxbJ9K4YlzEkLSKigs=
X-Gm-Gg: ASbGncsm2TGwROUvR5Mv46PuWAlL8SYZQRYUPOV9V0Yu1UeLByAmtDygyKjh35ujCgh
 omMUjKdypwQNsKoM62S4y+O9Iddt7kydNfT8fsnWGJ1qbcAnIAQ5Fl+2bT54GUTKW3pE7lObsR8
 EEtbvAVoVttItdhWOWZk2Yke4UScgAQ35rNh7iWFRsJoY6a2+xmIeoCEMLVETryPji47SgLBsiI
 1gWSnLrV44Wjw6fbFJeb/1nuiIQetz6aRMiU52hDzh4qr+w8PxAr14d/x5Er2TL9rrLUHj4rjYj
 SEgA/5CcMwd7iVisVceKifMr3/BWvZxWXd4kYFC/OpxCuAW94Pd2RV4Jqg==
X-Google-Smtp-Source: AGHT+IEhrHDQHzMYLLzcwJEq/ku8/bO+huEZTZVPy2P8dIhGrPRG4mpmWoseNxr+Qxdux29FZQoMxw==
X-Received: by 2002:a17:903:98d:b0:220:e362:9b1a with SMTP id
 d9443c01a7336-22780d83b3emr410189765ad.25.1743002965229; 
 Wed, 26 Mar 2025 08:29:25 -0700 (PDT)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-227811bc272sm111122885ad.146.2025.03.26.08.29.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Mar 2025 08:29:24 -0700 (PDT)
Message-ID: <38dcf926-b9a8-4faa-a2cf-6eda3247d8dd@linaro.org>
Date: Wed, 26 Mar 2025 08:24:28 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-10.1 4/8] target/mips: Prefix MMU API with 'mips_'
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Eduardo Habkost <eduardo@habkost.net>, Zhao Liu <zhao1.liu@intel.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Aleksandar Rikalo
 <arikalo@gmail.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Anton Johansson <anjo@rev.ng>
References: <20250325154058.92735-1-philmd@linaro.org>
 <20250325154058.92735-5-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250325154058.92735-5-philmd@linaro.org>
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

T24gMy8yNS8yNSAwODo0MCwgUGhpbGlwcGUgTWF0aGlldS1EYXVkw6kgd3JvdGU6DQo+IE1J
UFMgTU1VIEFQSSBkZWNsYXJlZCBpbiB0Y2ctaW50ZXJuYWwuaCBoYXMgcHVibGljIGxpbmth
Z2UuDQo+IEluIG9yZGVyIHRvIGF2b2lkIG5hbWUgY2xhc2hpbmcgd2l0aCBvdGhlciB0YXJn
ZXRzLCBwcmVmaXgNCj4gdGhlIEFQSSB3aXRoICdtaXBzXycuDQo+IA0KPiBTaWduZWQtb2Zm
LWJ5OiBQaGlsaXBwZSBNYXRoaWV1LURhdWTDqSA8cGhpbG1kQGxpbmFyby5vcmc+DQo+IC0t
LQ0KPiAgIHRhcmdldC9taXBzL3RjZy90Y2ctaW50ZXJuYWwuaCAgICAgIHwgMiArLQ0KPiAg
IHRhcmdldC9taXBzL2NwdS5jICAgICAgICAgICAgICAgICAgIHwgMiArLQ0KPiAgIHRhcmdl
dC9taXBzL3RjZy9zeXN0ZW0vdGxiX2hlbHBlci5jIHwgMiArLQ0KPiAgIDMgZmlsZXMgY2hh
bmdlZCwgMyBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdp
dCBhL3RhcmdldC9taXBzL3RjZy90Y2ctaW50ZXJuYWwuaCBiL3RhcmdldC9taXBzL3RjZy90
Y2ctaW50ZXJuYWwuaA0KPiBpbmRleCA3NGZjMTMwOWE3MS4uYThiZjJhNWRhNDAgMTAwNjQ0
DQo+IC0tLSBhL3RhcmdldC9taXBzL3RjZy90Y2ctaW50ZXJuYWwuaA0KPiArKysgYi90YXJn
ZXQvbWlwcy90Y2cvdGNnLWludGVybmFsLmgNCj4gQEAgLTQ1LDcgKzQ1LDcgQEAgdm9pZCBk
b19yYWlzZV9leGNlcHRpb24oQ1BVTUlQU1N0YXRlICplbnYsDQo+ICAgdm9pZCBtaXBzX2Nw
dV9kb19pbnRlcnJ1cHQoQ1BVU3RhdGUgKmNwdSk7DQo+ICAgYm9vbCBtaXBzX2NwdV9leGVj
X2ludGVycnVwdChDUFVTdGF0ZSAqY3B1LCBpbnQgaW50X3JlcSk7DQo+ICAgDQo+IC12b2lk
IG1tdV9pbml0KENQVU1JUFNTdGF0ZSAqZW52LCBjb25zdCBtaXBzX2RlZl90ICpkZWYpOw0K
PiArdm9pZCBtaXBzX21tdV9pbml0KENQVU1JUFNTdGF0ZSAqZW52LCBjb25zdCBtaXBzX2Rl
Zl90ICpkZWYpOw0KPiAgIA0KPiAgIHZvaWQgdXBkYXRlX3BhZ2VtYXNrKENQVU1JUFNTdGF0
ZSAqZW52LCB0YXJnZXRfdWxvbmcgYXJnMSwgaW50MzJfdCAqcGFnZW1hc2spOw0KPiAgIA0K
PiBkaWZmIC0tZ2l0IGEvdGFyZ2V0L21pcHMvY3B1LmMgYi90YXJnZXQvbWlwcy9jcHUuYw0K
PiBpbmRleCA1ZWQ2YjM0MDJkMy4uZDg5MzA0NjhiN2QgMTAwNjQ0DQo+IC0tLSBhL3Rhcmdl
dC9taXBzL2NwdS5jDQo+ICsrKyBiL3RhcmdldC9taXBzL2NwdS5jDQo+IEBAIC00ODUsNyAr
NDg1LDcgQEAgc3RhdGljIHZvaWQgbWlwc19jcHVfcmVhbGl6ZWZuKERldmljZVN0YXRlICpk
ZXYsIEVycm9yICoqZXJycCkNCj4gICAgICAgZW52LT5leGNlcHRpb25fYmFzZSA9IChpbnQz
Ml90KTB4QkZDMDAwMDA7DQo+ICAgDQo+ICAgI2lmIGRlZmluZWQoQ09ORklHX1RDRykgJiYg
IWRlZmluZWQoQ09ORklHX1VTRVJfT05MWSkNCj4gLSAgICBtbXVfaW5pdChlbnYsIGVudi0+
Y3B1X21vZGVsKTsNCj4gKyAgICBtaXBzX21tdV9pbml0KGVudiwgZW52LT5jcHVfbW9kZWwp
Ow0KPiAgICNlbmRpZg0KPiAgICAgICBmcHVfaW5pdChlbnYsIGVudi0+Y3B1X21vZGVsKTsN
Cj4gICAgICAgbXZwX2luaXQoZW52KTsNCj4gZGlmZiAtLWdpdCBhL3RhcmdldC9taXBzL3Rj
Zy9zeXN0ZW0vdGxiX2hlbHBlci5jIGIvdGFyZ2V0L21pcHMvdGNnL3N5c3RlbS90bGJfaGVs
cGVyLmMNCj4gaW5kZXggY2E0ZDZiMjdiYzkuLjFlZjJjMzJjZmQ0IDEwMDY0NA0KPiAtLS0g
YS90YXJnZXQvbWlwcy90Y2cvc3lzdGVtL3RsYl9oZWxwZXIuYw0KPiArKysgYi90YXJnZXQv
bWlwcy90Y2cvc3lzdGVtL3RsYl9oZWxwZXIuYw0KPiBAQCAtNDY2LDcgKzQ2Niw3IEBAIHN0
YXRpYyB2b2lkIHI0a19tbXVfaW5pdChDUFVNSVBTU3RhdGUgKmVudiwgY29uc3QgbWlwc19k
ZWZfdCAqZGVmKQ0KPiAgICAgICBlbnYtPnRsYi0+aGVscGVyX3RsYmludmYgPSByNGtfaGVs
cGVyX3RsYmludmY7DQo+ICAgfQ0KPiAgIA0KPiAtdm9pZCBtbXVfaW5pdChDUFVNSVBTU3Rh
dGUgKmVudiwgY29uc3QgbWlwc19kZWZfdCAqZGVmKQ0KPiArdm9pZCBtaXBzX21tdV9pbml0
KENQVU1JUFNTdGF0ZSAqZW52LCBjb25zdCBtaXBzX2RlZl90ICpkZWYpDQo+ICAgew0KPiAg
ICAgICBlbnYtPnRsYiA9IGdfbWFsbG9jMChzaXplb2YoQ1BVTUlQU1RMQkNvbnRleHQpKTsN
Cj4gICANCg0KUmV2aWV3ZWQtYnk6IFBpZXJyaWNrIEJvdXZpZXIgPHBpZXJyaWNrLmJvdXZp
ZXJAbGluYXJvLm9yZz4NCg0K

