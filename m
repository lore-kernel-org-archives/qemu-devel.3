Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AD0ACF34B0
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Oct 2024 16:05:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1swOK3-0008Ng-AJ; Thu, 03 Oct 2024 12:04:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1swOJx-0008L8-BT
 for qemu-devel@nongnu.org; Thu, 03 Oct 2024 12:04:53 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1swOJv-0006z4-FQ
 for qemu-devel@nongnu.org; Thu, 03 Oct 2024 12:04:52 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-7198cb6bb02so870483b3a.3
 for <qemu-devel@nongnu.org>; Thu, 03 Oct 2024 09:04:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727971489; x=1728576289; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=xd+KNlJuRhKfKfKDoqr+1HcJybPz+EG5VXk0CLeGvz4=;
 b=XnJrJuFyD/+UdA2iVThgGiFAlnqbESjThoELvI2cqPjOJt1nlBHxcHoD2wO3My8ZvA
 4wa6BaunOhgo9cTsL3jbwywc29Gi65gdnl96iou+v+2BMYSclISQ/JVI0CXLTT8Q5l3M
 He0G7hKBpZ2iM6Mx/pWCHeC+lp8G9ImsmZdSCfiok3QVMJLgmRoAFlFD43/Gy765gMSQ
 CDRG5xvcUJKNQNLYNYJARecDT8NBBr9V+5I8mL8d6E+YvkiG2NAOEcYG799dmCB0Wp85
 mrMMauIlaqpM29ZzgdUkQqbb2ESaDxVc4NRZZHIglFrA7bhFvegz/6lO2cMdYVYFKPCa
 uM0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727971489; x=1728576289;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xd+KNlJuRhKfKfKDoqr+1HcJybPz+EG5VXk0CLeGvz4=;
 b=ZQRJiPVwgjF6WnACXXGIlAGtEL5XThiafz8JqtXpML+DGqwC1CmyXU9AQRQiv9fQWf
 ADlCyopSm1s+ct66TGjevcTwwS+yxUXvs4D/AHh0gDWytksxBduegXzGtFjSkuanvo4K
 F0lMBrgla3Hwg+UdYssxL6mMXCC8CFBFDtMRf0ojBKAL+TwK+WGKeMTsjU88GVOAEosH
 pbpnSwFODPQUjFHVbRrh8v0UDRcSRCWu4gcJhzxhlzk5/52FDNg2e3DZjfDmY3HdZMhh
 9yUEhCMoQRTC0amMlGnS7TjCNFHalxzf7pD0kOXUFn7YeZwhAQUyvn26ig4zm2e/RGTY
 5FWQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUCnIxpkOh9l2acbPAgLZtVggAg2y+Pc72UAhkmPrAHIWB4/mMz+lyExwFtgKyEUMJYS4Xt5DuO5+QJ@nongnu.org
X-Gm-Message-State: AOJu0YyCYJq1ji+CtXh4jsBtQHxlbys+Ums8P9Af6VQzi1b9VcOrwY7E
 2ujz9VVZP+SznCqVlYAvbgkk+HSKHWf3Fak+OfAARCgruSCQXi5zlWnf5+rk7Q4=
X-Google-Smtp-Source: AGHT+IG9uo0HFqaGmZMevXzzrKkIrORLN6T3Ly0QJzV4gHFsGlE0SCtgdR3x6pyILKVijdlvhnGYZQ==
X-Received: by 2002:a05:6a00:b50:b0:70e:8d35:7ba3 with SMTP id
 d2e1a72fcca58-71dc5c8f187mr11052700b3a.14.1727971489290; 
 Thu, 03 Oct 2024 09:04:49 -0700 (PDT)
Received: from [192.168.1.67] (216-180-64-156.dyn.novuscom.net.
 [216.180.64.156]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71dd9d8bfefsm1502244b3a.52.2024.10.03.09.04.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Oct 2024 09:04:48 -0700 (PDT)
Message-ID: <a14cd43c-087b-4a5d-b036-39aa6a80e691@linaro.org>
Date: Thu, 3 Oct 2024 09:04:47 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/13] hw/xtensa/xtfpga: Replace memcpy()+tswap32() by
 stl_endian_p()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: Mahmoud Mandour <ma.mandourr@gmail.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>, Jason Wang <jasowang@redhat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, Anton Johansson <anjo@rev.ng>,
 Peter Maydell <peter.maydell@linaro.org>, Huacai Chen
 <chenhuacai@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 Sven Schnelle <svens@stackframe.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 qemu-arm@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>,
 Max Filippov <jcmvbkbc@gmail.com>, Paul Burton <paulburton@kernel.org>
References: <20240930073450.33195-1-philmd@linaro.org>
 <20240930073450.33195-9-philmd@linaro.org>
 <257b0de0-6744-4ae8-a2c5-f05eec29a3f0@redhat.com>
 <0c28a435-0af6-450f-8558-14dddc6cb6a6@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Content-Language: en-US
In-Reply-To: <0c28a435-0af6-450f-8558-14dddc6cb6a6@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42a.google.com
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

T24gMTAvMy8yNCAwOTowMiwgUGhpbGlwcGUgTWF0aGlldS1EYXVkw6kgd3JvdGU6DQo+IE9u
IDMwLzkvMjQgMTY6MzIsIFRob21hcyBIdXRoIHdyb3RlOg0KPj4gT24gMzAvMDkvMjAyNCAw
OS4zNCwgUGhpbGlwcGUgTWF0aGlldS1EYXVkw6kgd3JvdGU6DQo+Pj4gUmVwbGFjZSBhIHBh
aXIgb2YgbWVtY3B5KCkgKyB0c3dhcDMyKCkgYnkgc3RsX2VuZGlhbl9wKCksDQo+Pj4gd2hp
Y2ggYWxzbyBzd2FwIHRoZSB2YWx1ZSB1c2luZyB0YXJnZXQgZW5kaWFubmVzcy4NCj4+Pg0K
Pj4+IFNpZ25lZC1vZmYtYnk6IFBoaWxpcHBlIE1hdGhpZXUtRGF1ZMOpIDxwaGlsbWRAbGlu
YXJvLm9yZz4NCj4+PiAtLS0NCj4+PiAgwqAgaHcveHRlbnNhL3h0ZnBnYS5jIHwgNiArKy0t
LS0NCj4+PiAgwqAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlv
bnMoLSkNCj4+Pg0KPj4+IGRpZmYgLS1naXQgYS9ody94dGVuc2EveHRmcGdhLmMgYi9ody94
dGVuc2EveHRmcGdhLmMNCj4+PiBpbmRleCAyMjhmMDBiMDQ1Li41MjFmZTg0YjAxIDEwMDY0
NA0KPj4+IC0tLSBhL2h3L3h0ZW5zYS94dGZwZ2EuYw0KPj4+ICsrKyBiL2h3L3h0ZW5zYS94
dGZwZ2EuYw0KPj4+IEBAIC00MzgsMTEgKzQzOCw5IEBAIHN0YXRpYyB2b2lkIHh0ZnBnYV9p
bml0KGNvbnN0IFh0ZnBnYUJvYXJkRGVzYw0KPj4+ICpib2FyZCwgTWFjaGluZVN0YXRlICpt
YWNoaW5lKQ0KPj4+ICDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBjb25zdCBzaXplX3Qg
Ym9vdF9zeiA9IFRBUkdFVF9CSUdfRU5ESUFOID8gc2l6ZW9mKGJvb3RfYmUpDQo+Pj4gIMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCA6
IHNpemVvZihib290X2xlKTsNCj4+PiAgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgdWlu
dDhfdCAqYm9vdCA9IFRBUkdFVF9CSUdfRU5ESUFOID8gYm9vdF9iZSA6IGJvb3RfbGU7DQo+
Pj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgdWludDMyX3QgZW50cnlfcGMgPSB0c3dhcDMy
KGVudHJ5X3BvaW50KTsNCj4+PiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB1aW50MzJfdCBl
bnRyeV9hMiA9IHRzd2FwMzIodGFncHRyKTsNCj4+PiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCBtZW1jcHkoYm9vdCArIDQsICZlbnRyeV9wYywgc2l6ZW9mKGVudHJ5X3BjKSk7DQo+Pj4g
LcKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgbWVtY3B5KGJvb3QgKyA4LCAmZW50cnlfYTIsIHNp
emVvZihlbnRyeV9hMikpOw0KPj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHN0bF9lbmRp
YW5fcChUQVJHRVRfQklHX0VORElBTiwgYm9vdCArIDQsIGVudHJ5X3BvaW50KTsNCj4+PiAr
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBzdGxfZW5kaWFuX3AoVEFSR0VUX0JJR19FTkRJQU4s
IGJvb3QgKyA4LCB0YWdwdHIpOw0KPj4NCj4+IFdoeSBkb24ndCB5b3Ugc2ltcGx5IHVzZSBz
dGxfcCgpIGhlcmU/DQo+IA0KPiBXZSB3YW50IHRvIHJlbW92ZSB0aGUgdHN3YXAzMigpIGNh
bGxzLi4uDQo+IA0KDQpJIHRoaW5rIGlzIHBvaW50IGlzIHRoYXQgeW91IGNvdWxkIGRpcmVj
dGx5IHVzZSBzdGxfYmVfcCwgaW5zdGVhZCBvZiANCnN0bF9lbmRpYW5fcChUQVJHRVRfQklU
X0VORElBTiwgLi4uKS4NCkkgZG9uJ3Qga25vdyBpZiB5b3VyIGludGVudCBpcyB0byBtYWtl
IGJlL2xlIHZhcmlhbnQgInByaXZhdGUiIGFuZCANCnJlbGllcyBvbmx5IG9uIGVuZGlhbl9w
IHRob3VnaC4NCg==

