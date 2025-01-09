Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2FE4E7719A
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2025 20:51:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVzU3-00055b-Nj; Thu, 09 Jan 2025 15:50:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tVzU3-00055L-00
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 15:50:27 -0500
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tVzU1-0007OJ-2O
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 15:50:26 -0500
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-2166651f752so27834895ad.3
 for <qemu-devel@nongnu.org>; Thu, 09 Jan 2025 12:50:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736455823; x=1737060623; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=S295p9xnfunXVAIWUkyPGoPNScyk5XwPA01Orj+3Ivk=;
 b=KjTTeU/JpmYMVp+0U1hTL9FU0VQ1l9FuEOGMbwiLDXuEGs9slbB+uyi45YP7dYr/kK
 s1XZwyyJB9hutl/8Czt/Xzv6GXtJ7SdhpfiAPvFBJveWY2t7A17iRkLaQs71OhEPJ3Hs
 BiQgxj1N/XTYo4Eh43o7CyGuo7GQTkJqGPlZG9E2ryTf0QOV8QS5We91PjfNaAFLszYR
 ozL7V3oS041f6Pap5sLpRX3r+KoVNHLFun+9InmY0KJFPOg19dok24Z11QZ5azpHisA2
 PcVNL0zc2osLZZSvvRwr+JlZBFvWJBe9hgqEhPmrj/TI+2ydbqqKTipwF5Pc7UtoJAJB
 t+2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736455823; x=1737060623;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=S295p9xnfunXVAIWUkyPGoPNScyk5XwPA01Orj+3Ivk=;
 b=LcpM0bocN7LX8upZgz1Y9AgwE3h7iwYdlbIW2BbmSlr682pWMnY0Vck1Hf8xY0C3CA
 +yqw9T20JsODVRYSPk5WV7fLHT8/HQp8eoz7kxGBvmuXzrEzAQeJgI2T0NLy53nYtLKw
 MbjmzdXN2ovSON+ChiR51FAst63vD7CHIAIzSJYavoByqfUqGfUta2Ua/UDmZ+dfsQwI
 ++styDoQgeLXsKtygoWeqBJrMp8IV0Mxs54H8fW9QPjW9eylOMFlsQeFSW/eS3fl1FRx
 zCXdYK32tT245Qsll3K3qEynWIIcyHXQjuH19l2zOGPB5NR6OXBxvbz2pSwwP5GRqfAI
 Bp3A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWB/0s80nZxnfLaNSw3w4XiPiWS2yr7TQkXLQ4H9NbSrbQZB8Tv6jxaZ6fGWXa2juHv0F7Um4mRgUOk@nongnu.org
X-Gm-Message-State: AOJu0YwQ//Fb8R4g+888VZajJAda2Bl2sWk9awAAmQot+u0ECAEfTFxu
 GUUY0IjQo/op4RMezYY+juFKquL+znYwxe+hdduu3kIfquDBtNu7j+5BpIrbHp4=
X-Gm-Gg: ASbGnct5mncmjxjIRou/Ig1Tai66M77T7Psl9x3W5SKJ+5X0l0rrbL/hBCDWnWJHpoR
 jAlf9XvRhx0xptCwY45U6r97ZPN2SDcPcHTWjM/GQwx8IhhAXaJVqOlQhF90feL7rOGYMD2nbaM
 Z/SlrG3QoTnLM6CKxL9jwashNo3LzqIo8prZK5J4lF1N2XjCHQkapCpKuA+v99CeIdUh5/+QoIR
 lRl1OZJc7yygORdKrc7AcDBN91goo6jtFKlY90frXS7PAbkJWQxGC+FTnUld74jdT6uag==
X-Google-Smtp-Source: AGHT+IHMi8722kLaUBBtp3VZ/AsiIbCP3/lBPN2qEvLetqArVyjFZm52SVi7oYhhIxPs8GMo9t7W9Q==
X-Received: by 2002:a17:902:cccb:b0:216:3297:92a4 with SMTP id
 d9443c01a7336-21a83fe5083mr124113305ad.46.1736455823422; 
 Thu, 09 Jan 2025 12:50:23 -0800 (PST)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21a9f12f93fsm2118335ad.65.2025.01.09.12.50.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Jan 2025 12:50:22 -0800 (PST)
Message-ID: <2824f6ea-c3f5-4832-8fd8-af6e6dc0c032@linaro.org>
Date: Thu, 9 Jan 2025 12:50:21 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] contrib/plugins/bbv.c: Start bb index from 1
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Cc: ckf104 <1900011634@pku.edu.cn>, qemu-trivial@nongnu.org,
 Alexandre Iooss <erdnaxe@crans.org>, Mahmoud Mandour
 <ma.mandourr@gmail.com>, QEMU-Devel <qemu-devel@nongnu.org>
References: <20241217142413.148978-1-1900011634@pku.edu.cn>
 <514c2c90-4c0f-486e-857d-fa0360c47d38@tls.msk.ru>
 <875xn4lm80.fsf@draig.linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <875xn4lm80.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x634.google.com
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

T24gMTIvMjcvMjQgMTU6NTAsIEFsZXggQmVubsOpZSB3cm90ZToNCj4gTWljaGFlbCBUb2th
cmV2IDxtanRAdGxzLm1zay5ydT4gd3JpdGVzOg0KPiANCj4+IDE3LjEyLjIwMjQgMTc6MjQs
IGNrZjEwNCB3cm90ZToNCj4+PiBTdGFuZGFyZCBzaW1wb2ludCB0b29sIHJlcWV1c3RzIHRo
YXQgaW5kZXggb2YgYmFzaWMgYmxvY2sgaW5kZXggc3RhcnRzIGZyb20gMS4NCj4+DQo+PiBX
aGlsZSB0aGlzIHBhdGNoIGlzIGEgdHJpdmlhbCBvbmUtbGluZXIsIGJ1dCB0aGUgdW5kZXJs
eWluZyBpc3N1ZSByZXF1aXJlcyBhdCBsZWFzdA0KPj4gYSBtaW5pbWFsIHVuZGVyc3RhbmRp
bmcgb2Ygd2hhdCBpdCBpcyBhbGwgYWJvdXQsIHdoYXQgKmlzKiBiYnYgdG8gYmVnaW4gd2l0
aCwgd2hhdA0KPj4gYHNpbXBvaW50JyBpcy4gIEknbSBub3Qgc3VyZSBpdCByZWFsbHkgaXMg
YSB0cml2aWFsIG1hdGVyaWFsPw0KPj4NCj4+PiBTaWduZWQtb2ZmLWJ5OiBja2YxMDQgPDE5
MDAwMTE2MzRAcGt1LmVkdS5jbj4NCj4+DQo+PiBEbyB3ZSBhY2NlcHQgc3VjaCBTb0JzIHRo
ZXNlIGRheXM/DQo+IA0KPiBUaGUgZ3VpZGFuY2UgaXMgY292ZXJlZCBoZXJlOiBodHRwczov
L3FlbXUucmVhZHRoZWRvY3MuaW8vZW4vbWFzdGVyL2RldmVsL3N1Ym1pdHRpbmctYS1wYXRj
aC5odG1sI3BhdGNoLWVtYWlscy1tdXN0LWluY2x1ZGUtYS1zaWduZWQtb2ZmLWJ5LWxpbmUN
Cj4gDQo+IFRoZSB3b3JkaW5nOiAiSXQgaXMgdGhlIGlkZW50aXR5IHlvdSBjaG9vc2UgdG8g
YmUga25vd24gYnkgaW4gdGhlDQo+IGNvbW11bml0eSwgYnV0IHNob3VsZCBub3QgYmUgYW5v
bnltb3VzLCBub3IgbWlzcmVwcmVzZW50IHdob20geW91IGFyZSINCj4gaW1wbGllcyB5b3Ug
c2hvdWxkIGJlIGlkZW50aWZpYWJsZSB0byBhc3NlcnQgeW91IGNhbiBzdWJtaXQgY29kZSBh
bmQNCj4gY3VycmVudGx5IHRoaXMgZW1haWwgb25seSBzaG93cyB1cCBmb3IgdGhpcyBwYXRj
aCBzbyBpcyBmdW5jdGlvbmFsbHkNCj4gYW5vbnltb3VzIEkgdGhpbms/DQo+IA0KDQpJdCB0
aGlzIGlzIGFuIGlzc3VlLCBpdCdzIHByb2JhYmx5IGZhc3RlciB0byByZXNwaW4gdGhlIHBh
dGNoIHVuZGVyIHlvdXIgDQpuYW1lLiBHaXZlbiB0aGUgdHJpdmlhbCBjb250ZW50LCBJIGRv
bid0IHRoaW5rIGl0IHdvdWxkIGJlIGEgcHJvYmxlbSBmb3IgDQp0aGUgb3JpZ2luYWwgYXV0
aG9yLg0KDQo+IA0KPj4NCj4+IFRoYW5rcywNCj4+DQo+PiAvbWp0DQo+IA0KDQo=

