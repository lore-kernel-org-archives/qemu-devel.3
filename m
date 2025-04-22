Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E940C369C2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Apr 2025 18:06:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7I0f-0000DE-5Y; Tue, 22 Apr 2025 14:06:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u7I0c-0000BQ-3D
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 14:06:14 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u7I0Z-0003IN-0B
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 14:06:13 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-7398d65476eso117756b3a.1
 for <qemu-devel@nongnu.org>; Tue, 22 Apr 2025 11:06:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745345168; x=1745949968; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ixSj+UuLviJEDYh3IhoMOUSRfUguUg5zQSP4nWuMqLU=;
 b=fjOtIl7COCzm4vrPCJawwVQkQV+bT1jMwy+QSQULFGPL1WTNnWpiNNlke9CXHxP7eb
 7Q3QeZN3QwR+9YvwRj9BfeCxdFFwf8gXEtsdhIBN9gLig9PAUO23jUK9aoA63wmChQqK
 EbUToJRfXYRJTVquKoz3pMc5rRpaOT2yTrICtmA1V2Jk7ADt6arSyqaeuPH39FyPSOUW
 dhzVbQHFNyccMrEt9q65trY6+qNRbks0HG0wj2NnMush9T4TfPbf+V2BbAJoDMgh6p1m
 bvb3jAGEtGhNELGh23jJR6GlQ1Z/PMbFoB0kdaNaskJkS6/DNxLy3lHTRRVDYdk4ih9L
 cyYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745345168; x=1745949968;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ixSj+UuLviJEDYh3IhoMOUSRfUguUg5zQSP4nWuMqLU=;
 b=WC/dg845hIwfl545sUi0cgWrkGu8dNidvz/nAXlILk6ixWfz7Sir7dMoLXQUbviRuU
 wLwo4TWKhihj+BsnR5m6hLXeqZ233j6KQ/1nwSEtmrvzPnbxiMXZTBoRxf4E3Mn+UVlt
 itVDlLbY1oLOPcsDLdbqeDlXa9y2Xgjn/lHiVT8aAQH4p7s9JyhKACeO0J8zv0JEefOe
 4fo3Y86Z04run3FHQkTZ7mPpW8XWRcKNpyyec5fFMxbwCaDjV178jEFw5JIX6Jy4JOom
 LiRUpv72eXMFIUVbUHpGhGS2bSgX18ex0zUM9fv2vGtGlBpiZaBVt8D/ind98P5FZv1/
 nZ0w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWyrw5wraBmkD4jkioLrElEmw5mrCjq4Gs0UsWIdr7uDjVJ+56cHTyCBrni9uwbi1r/EwhmxJKd/zb/@nongnu.org
X-Gm-Message-State: AOJu0YxAyCbM087/6qqNIgiv/Sc/Xm7cvIGK4kuObM+cZ4jMSK/TXCU2
 r4pACBjkvZCZ9AWTPZjyxyde05pGQEJZd/lBghr8VPcyYTleH8fawU2di9n6FbU0z2MvN2MBQlC
 i
X-Gm-Gg: ASbGncvZ5sC49ulU7TxThZ+4yDIFu2LmG1U1N2DAPPIr83Ue5pDhiFKXtj6TXY1iWMh
 o9u7delbAJi0BhxWUGjKyvJGZr1y4cvnU/HqXjCJUIVsBc7Jn8zsPR+ESgqbuy9z2/XcZsPZN86
 iJWzeTenkzu/mSLXIISB5Tvo01M5Mp4XIsfJ6FfP9qOcUBAh0dDdOfsRee+F3dAxZg74SxdEs+n
 paVK6rnrBgWBvvIq8dqJgx+ccWdILxiHjpom5FKczR08xZOf5AAx0GIiANw6bV5AVT0IfLLE0s7
 kOVWAYS/mkZpcrJzulFXZ8k78os5iCsreqqEnFkySDWY3yvcDkwiJA==
X-Google-Smtp-Source: AGHT+IGXex13jgk+OTFJXPlVbpbZjtnOii2gMt2Gkve4+Ks28QrG79hbRJfeqHXyAVioZA/a2N+tkg==
X-Received: by 2002:a05:6a00:148e:b0:732:5875:eb95 with SMTP id
 d2e1a72fcca58-73dbe5201ddmr27080763b3a.4.1745345168640; 
 Tue, 22 Apr 2025 11:06:08 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73dbf8c04afsm8918057b3a.23.2025.04.22.11.06.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Apr 2025 11:06:08 -0700 (PDT)
Message-ID: <1f00ced1-429f-476f-bb39-6e0db0e0c0cc@linaro.org>
Date: Tue, 22 Apr 2025 11:06:07 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v4 11/19] hw/core/machine: Allow dynamic registration
 of valid CPU types
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>
References: <20250422145502.70770-1-philmd@linaro.org>
 <20250422145502.70770-12-philmd@linaro.org>
 <0ca405b8-77f8-452e-ba09-0ba820f64d6f@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <0ca405b8-77f8-452e-ba09-0ba820f64d6f@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x436.google.com
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

T24gNC8yMi8yNSAxMDo1NCwgUmljaGFyZCBIZW5kZXJzb24gd3JvdGU6DQo+IE9uIDQvMjIv
MjUgMDc6NTQsIFBoaWxpcHBlIE1hdGhpZXUtRGF1ZMOpIHdyb3RlOg0KPj4gaW5kZXggZjUy
YTRmMjI3M2IuLjhiNDA3MzVlZjk4IDEwMDY0NA0KPj4gLS0tIGEvaHcvY29yZS9tYWNoaW5l
LmMNCj4+ICsrKyBiL2h3L2NvcmUvbWFjaGluZS5jDQo+PiBAQCAtMTU4MSw2ICsxNTgxLDMz
IEBAIHN0YXRpYyBib29sIGlzX2NwdV90eXBlX3N1cHBvcnRlZChjb25zdCBNYWNoaW5lU3Rh
dGUgKm1hY2hpbmUsIEVycm9yICoqZXJycCkNCj4+ICAgICAgICAgICAgICAgIHJldHVybiBm
YWxzZTsNCj4+ICAgICAgICAgICAgfQ0KPj4gICAgICAgIH0NCj4+ICsgICAgaWYgKG1jLT5n
ZXRfdmFsaWRfY3B1X3R5cGVzKSB7DQo+PiArICAgICAgICBHU0xpc3QgKnZjdCA9IG1jLT5n
ZXRfdmFsaWRfY3B1X3R5cGVzKG1hY2hpbmUpOw0KPj4gKyAgICAgICAgYm9vbCB2YWxpZCA9
IGZhbHNlOw0KPj4gKyAgICAgICAgdW5zaWduZWQgY291bnQgPSAwOw0KPj4gKyAgICAgICAg
R1NMaXN0ICpsOw0KPj4gKw0KPj4gKyAgICAgICAgZm9yIChsID0gdmN0OyAhdmFsaWQgJiYg
bCAhPSBOVUxMOyBsID0gbC0+bmV4dCkgew0KPj4gKyAgICAgICAgICAgIHZhbGlkIHw9ICEh
b2JqZWN0X2NsYXNzX2R5bmFtaWNfY2FzdChvYywgbC0+ZGF0YSk7DQo+PiArICAgICAgICAg
ICAgY291bnQrKzsNCj4+ICsgICAgICAgIH0NCj4+ICsNCj4+ICsgICAgICAgIGlmICghdmFs
aWQpIHsNCj4+ICsgICAgICAgICAgICBnX2F1dG9mcmVlIGNoYXIgKnJlcXVlc3RlZCA9IGNw
dV9tb2RlbF9mcm9tX3R5cGUobWFjaGluZS0+Y3B1X3R5cGUpOw0KPj4gKyAgICAgICAgICAg
IHZjdCA9IGdfc2xpc3RfcmV2ZXJzZSh2Y3QpOw0KPj4gKyAgICAgICAgICAgIGVycm9yX3Nl
dGcoZXJycCwgIkludmFsaWQgQ1BVIG1vZGVsOiAlcyIsIHJlcXVlc3RlZCk7DQo+PiArICAg
ICAgICAgICAgZXJyb3JfYXBwZW5kX2hpbnQoZXJycCwgIlRoZSB2YWxpZCBtb2RlbHMgYXJl
OiAiKTsNCj4+ICsgICAgICAgICAgICBmb3IgKGwgPSB2Y3Q7IGwgIT0gTlVMTDsgbCA9IGwt
Pm5leHQpIHsNCj4+ICsgICAgICAgICAgICAgICAgZ19hdXRvZnJlZSBjaGFyICptb2RlbCA9
IGNwdV9tb2RlbF9mcm9tX3R5cGUobC0+ZGF0YSk7DQo+PiArICAgICAgICAgICAgICAgIGVy
cm9yX2FwcGVuZF9oaW50KGVycnAsICIlcyVzIiwgbW9kZWwsIC0tY291bnQgPyAiLCAiIDog
IiIpOw0KPj4gKyAgICAgICAgICAgIH0NCj4+ICsgICAgICAgICAgICBlcnJvcl9hcHBlbmRf
aGludChlcnJwLCAiXG4iKTsNCj4+ICsgICAgICAgIH0NCj4+ICsgICAgICAgIGdfc2xpc3Rf
ZnJlZV9mdWxsKHZjdCwgZ19mcmVlKTsNCj4+ICsgICAgICAgIGlmICghdmFsaWQpIHsNCj4+
ICsgICAgICAgICAgICByZXR1cm4gZmFsc2U7DQo+PiArICAgICAgICB9DQo+PiArICAgIH0N
Cj4gDQo+IFdoeSB1c2UgR1NMaXN0IGluc3RlYWQgb2YgR1B0ckFycmF5Pw0KPiBUaGF0IHdv
dWxkIHByb3ZpZGUgeW91IHRoZSBjb3VudCB3aXRob3V0IG1hbnVhbGx5IGNvbXB1dGluZyBp
dCwNCj4gYW5kIGl0IHdvdWxkIGF2b2lkIHRoZSBuZWVkIGZvciBhbnkgc29ydCBvZiByZXZl
cnNlLg0KPiBJIHRoaW5rIGl0IHdvdWxkIGFsc28gYWxsb3cgeW91IHRvIGF1dG8tZnJlZSB0
aGUgc2V0Lg0KPiANCg0KU2FtZSByZW1hcmsgdGhhbiBSaWNoYXJkLCBpdCB3b3VsZCByZW1v
dmUgYWxsIHRoZSBjaGVja3MgbmVlZGVkLCBhcyB3ZSANCmNhbiBzaW1wbHkgdXNlIHRoaXMg
YXJyYXkgImJsaW5kbHkiLg0KDQo+IA0KPiByfg0KDQo=

