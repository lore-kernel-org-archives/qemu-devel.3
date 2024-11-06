Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B06A5D59F56
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2024 17:55:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8kEo-0004gs-Tc; Wed, 06 Nov 2024 12:54:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1t8kEk-0004f4-KZ
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 12:54:36 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1t8kEi-0002lY-1l
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 12:54:34 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4314fa33a35so718845e9.1
 for <qemu-devel@nongnu.org>; Wed, 06 Nov 2024 09:54:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730915669; x=1731520469; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=g5XP5mrLVcr+Vsc94v5s87FsZ6XnuyY7ClVqmiHfKmY=;
 b=nsqYB0E/CbAp644R6wMzsXmoXnZh0pyqVrKF18DeDJNRrfYftZ6YGceCzp+EsfPsfI
 OcC7+5iRz5Utv9TlVO4gk9eIoYS1dFBMbtDhXZCe2rpMzHSMD/MkGhoZJpZ4S69wbI1K
 iv/JbYW0xYvezi0FZvkueUDmDcCEkhrI0BaqEO0q+sLk/V+LlJj8HlmTKonaNPCWp/4w
 rgt1AVidY0/PwPprVJPUayqosKROGISTtyjqkP856xnl0pwJ9ELxCoTt/vik2OUqUaX6
 pwoiM8oC7AbOly8n6GSXOdwvEvAuuroUugZI63X6Zr7XmaBlaUUdExtBZeuoFcBj3rPK
 2htg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730915669; x=1731520469;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=g5XP5mrLVcr+Vsc94v5s87FsZ6XnuyY7ClVqmiHfKmY=;
 b=cbxFyyZXNG84ZBllYEQ9bqsXTye/9E/JYMnqGCeHee+BuZ0saLWDka8cb9wRDGuWIq
 kYXLlk5GqUX7XS4T7VIV+dZRou5IXoMOPv1mlMvwgVCJFPyff+Ss9UO+BFs0btaNXppY
 Kvv+nkOBEwHzbFMzxA16KCDg1tZLamdinsbA+zrPWCnApyUBhj3tu3y673SNPDXP1fPk
 DuvNEvydxxLGt6Kbz8qrwclwNncn9K5wgVuvbh4sDsLRiU38nBnu38acCv62E6joVQPk
 +ys423yAl/gYWfkVNfN37h/OvMB9F0FJ3c7W28GTO8d0vhBoonDPrlm81WpbtBEDekuz
 obkg==
X-Gm-Message-State: AOJu0Yxale1e1xCrhT+ciUGzi4rkzhyg0ii/LhbRUABEi8Xb8SRc8PAZ
 OrzxYKhiVxvNYZc3223Yc947ZyphiXURrx3Ax+u/4ikD6hBhSIvD21tOlE6RN08=
X-Google-Smtp-Source: AGHT+IHAaWmRFvD5xas81lf2T8lvkB1+5z+h+H0XvG0dXn9BAGO+UI0hf+G+m9/H99BrX6dJ25OWFQ==
X-Received: by 2002:adf:ec8f:0:b0:374:b35e:ea6c with SMTP id
 ffacd0b85a97d-381b70ed1c3mr18165409f8f.40.1730915669155; 
 Wed, 06 Nov 2024 09:54:29 -0800 (PST)
Received: from [10.134.195.192] ([193.32.126.165])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-381c10e61f9sm19791158f8f.58.2024.11.06.09.54.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 06 Nov 2024 09:54:28 -0800 (PST)
Message-ID: <b463bc8a-4625-43e6-a9da-4df526aa89a3@linaro.org>
Date: Wed, 6 Nov 2024 09:54:26 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] eif: cope with huge section offsets
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, dorjoychy111@gmail.com
References: <20241106174241.556373-1-pbonzini@redhat.com>
 <04fd0b86-4371-494e-a331-3d5d735f0d77@linaro.org>
 <CABgObfajkp+5vFnQuV+V6Mp+LuP_Yo-=JtZtGUcYB_GDDbWoJQ@mail.gmail.com>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <CABgObfajkp+5vFnQuV+V6Mp+LuP_Yo-=JtZtGUcYB_GDDbWoJQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-wm1-x32a.google.com
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

T24gMTEvNi8yNCAwOTo0OSwgUGFvbG8gQm9uemluaSB3cm90ZToNCj4gT24gV2VkLCBOb3Yg
NiwgMjAyNCBhdCA2OjQ34oCvUE0gUGllcnJpY2sgQm91dmllcg0KPiA8cGllcnJpY2suYm91
dmllckBsaW5hcm8ub3JnPiB3cm90ZToNCj4gDQo+Pj4gICAgICAgIGZvciAoaW50IGkgPSAw
OyBpIDwgTUFYX1NFQ1RJT05TOyArK2kpIHsNCj4+PiAgICAgICAgICAgIGhlYWRlci0+c2Vj
dGlvbl9vZmZzZXRzW2ldID0gYmU2NF90b19jcHUoaGVhZGVyLT5zZWN0aW9uX29mZnNldHNb
aV0pOw0KPj4+ICsgICAgICAgIGlmIChoZWFkZXItPnNlY3Rpb25fb2Zmc2V0c1tpXSA+IE9G
Rl9NQVgpIHsNCj4+DQo+PiBNYXliZSB3ZSBjb3VsZCBhZGQgYSBjb21tZW50IHRoYXQgc2Vj
dGlvbnNfb2Zmc2V0cyBpcyB1bnNpZ25lZCwgYXMgaXQNCj4+IGNhbiBiZSBjb25mdXNpbmcg
dG8gcmVhZCB2YWx1ZSA+IElOVF9NQVggd2l0aG91dCBtb3JlIGNvbnRleHQuDQo+IA0KPiBJ
dCBkb2VzIHNvdW5kIGxpa2UgT0ZGX01BWCBpcyByZWxhdGVkIHRvIHNlY3Rpb25fb2Zmc2V0
c1tdLCBidXQgaXQncw0KPiBhY3R1YWxseSByZWxhdGVkIHRvIG9mZl90LiAgU28gdGhlIGNv
bXBhcmlzb24gaXMgd2l0aCB0aGUgbWF4aW11bQ0KPiB2YWx1ZSBvZiBvZmZfdCwgd2hpY2gg
aXMgc2lnbmVkLg0KPiANCj4gVGhlIHByb2JsZW0gd291bGQgaGFwcGVuIGV2ZW4gaWYgc2Vj
dGlvbl9vZmZzZXRzW10gd2FzIHNpZ25lZCAoZm9yDQo+IGV4YW1wbGUgb2ZmX3QgY291bGQg
YmUgMzItYml0KS4NCj4gDQoNCkknbSBhIGJpdCBjb25mdXNlZC4NCkl0IHdvcmtzIGJlY2F1
c2Ugc2VjdGlvbl9vZmZzZXRzW2ldIGlzIHVuc2lnbmVkLiBJZiBpdCB3YXMgc2lnbmVkLCBh
bmQgDQpzaXplb2Yob2ZmX3QpIGlzIDgsIHdlIGNhbiBuZXZlciBzYXRpc2Z5ICIoaW50NjQp
ID4gSU5UNjRfTUFYIi4NCg0KPiBQYW9sbw0KPiANCj4+PiArICAgICAgICAgICAgZXJyb3Jf
c2V0ZyhlcnJwLCAiSW52YWxpZCBFSUYgaW1hZ2UuIFNlY3Rpb24gb2Zmc2V0IG91dCBvZiBi
b3VuZHMiKTsNCj4+PiArICAgICAgICAgICAgcmV0dXJuIGZhbHNlOw0KPj4+ICsgICAgICAg
IH0NCj4+PiAgICAgICAgfQ0KPj4+DQo+Pj4gICAgICAgIGZvciAoaW50IGkgPSAwOyBpIDwg
TUFYX1NFQ1RJT05TOyArK2kpIHsNCj4+DQo+PiBFbHNlLA0KPj4gUmV2aWV3ZWQtYnk6IFBp
ZXJyaWNrIEJvdXZpZXIgPHBpZXJyaWNrLmJvdXZpZXJAbGluYXJvLm9yZz4NCj4+DQo+IA0K
DQo=

