Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B640C3600C
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Mar 2025 20:54:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1twonP-00082h-OC; Mon, 24 Mar 2025 16:53:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1twonN-00082J-Qk
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 16:53:17 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1twonM-0000oM-7t
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 16:53:17 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-227b650504fso34539125ad.0
 for <qemu-devel@nongnu.org>; Mon, 24 Mar 2025 13:53:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742849595; x=1743454395; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=UyL9yBVHGlBGcMJnM2cb8+sEvfUro5Sdj9lbL9RULf8=;
 b=j5PMSr/2UHW1IqubAkNQ5b2ABUxjG/dzT3BVkRJg8Rxbwu6VhSZw3nuVzCyESo8KZ9
 k2JJOPMdWp8qlyn5CWh9/GcLFIirQcFwR9VcboVnWNOfdwSL/SVUjvObiOR+oykC9uAA
 os0bTo03CD9V+oZ2D+zmjlshynxa/+bmXX/DCITz1lkS5uvQQvBy041xAe6Nftg0ZQeT
 22esoBev/No4n0FU6gaw4dkvwJ0PLPQ5aGx9x2YmpHcCqi5DQA0XnWlmiRp+1GUvEyzP
 0nDe4QyqMVe3NV5LRp3K2X8uM8WByfClm0PQ71AvdZnikLB3z6QB8AomhBMqX20iiYfJ
 lxqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742849595; x=1743454395;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=UyL9yBVHGlBGcMJnM2cb8+sEvfUro5Sdj9lbL9RULf8=;
 b=HfHmHI+0T3D7ATJ/sTMN4z1JyTbcwpurxvkMWy9N2+X3bVyCA170LfYenz1hvd4n2t
 G3GLd6D1Cy4ujV+ZWV+e/j+dHVL2miWgLgHv8RSLJv9ejZxQmaLZEq3GNblTm45EVnXk
 uQfX4IEyXQNMElXnxTQiKj/GebOmW45QH05Hrn6HSNNwsx7aV1MH+8xn7yAp9csA/YLQ
 jBBljybP/7j5yi3aqOWfnBb3DbtanUIZqwY2EMpTklAj6e0wHaz3m/ilC+DmiVf/vlUD
 o8/Q2vwdZvC61gLELYSVjkYaaCe6yVZnxVzUr0k/5xej1m0K897odgDswMflEZfp7FrD
 JDFg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUMXvRgn9mGJ0v12W32gvN2lzCzX5QuORxFDDxwnO0GXIxtcET2YqipZaQ3EQZRCEaI0xwPZgmNLeXP@nongnu.org
X-Gm-Message-State: AOJu0YxmygMmWoIZNF6YUJMBgE88XXwTDs9nk2hwHfQ0/93J1XWP1NT0
 TpQaIDlJ/029x7RuT2icJ//UuDFBut+zAF2vNL0LOxxSNRarYO1F42baFRoxeC4=
X-Gm-Gg: ASbGncvPJ/cUUs5Q90cghbom4pxmWF0z+ZE1QctXGOTgAV4oKBrqpx3YZcVQAKfSpX9
 dCISXA7ZeCP/12ecX0nFBWXFIoPeuI36HLPKqfhEUch/bpfdHcbYZE3LkDvs4a8GBrhr/T9qoFX
 uxlh1fgg53pgyz6XMHgMxKObPcyjacWorNgkhIxW74xSqXGnTQQwklcw/9DwHYnZ2gyS67b7Pkv
 kTgzUslZN4lzI+oAzdVIGWqL8LodGE/1CVJoJg9UR23YklCmskQbAlpwI8yMoQkIrPV69roAv3l
 7nNEmoQ+nY5HAB2bm/xVhXoU/j7cw6FocYIG/dGdT1YdNBn2WCzYCsDqxMw+k5Kwacc4
X-Google-Smtp-Source: AGHT+IGtQJg7XCAVFf0wk81uIt9NtaDE5Z6SNF6D+Cl57llFdRUQWBRkA4RLPKhp14q/W+6BzHFoBw==
X-Received: by 2002:a17:902:ea07:b0:224:76f:9e59 with SMTP id
 d9443c01a7336-22780c54d2cmr281262075ad.10.1742849594397; 
 Mon, 24 Mar 2025 13:53:14 -0700 (PDT)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3030f5b7886sm8682190a91.6.2025.03.24.13.53.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 24 Mar 2025 13:53:13 -0700 (PDT)
Message-ID: <43382d01-6da5-4890-a34f-93cc46d327a1@linaro.org>
Date: Mon, 24 Mar 2025 13:53:13 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-10.1 2/3] target/sparc: Inline qemu_get_betl() and
 qemu_put_betl()
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Huacai Chen <chenhuacai@kernel.org>, Peter Xu <peterx@redhat.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Fabiano Rosas <farosas@suse.de>,
 Aleksandar Rikalo <arikalo@gmail.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Aurelien Jarno <aurelien@aurel32.net>,
 Artyom Tarasenko <atar4qemu@gmail.com>
References: <20250323225047.35419-1-philmd@linaro.org>
 <20250323225047.35419-3-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250323225047.35419-3-philmd@linaro.org>
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

T24gMy8yMy8yNSAxNTo1MCwgUGhpbGlwcGUgTWF0aGlldS1EYXVkw6kgd3JvdGU6DQo+IFdl
IG9ubHkgdXNlIHFlbXVfZ2V0X2JldGwoKSBhbmQgcWVtdV9wdXRfYmV0bCgpIG9uY2UgaW4N
Cj4gdGhlIHdob2xlIGNvZGUgYmFzZS4gSW5saW5lIHRoZW0gKGNoZWNraW5nIFRBUkdFVF9T
UEFSQzY0DQo+IGluc3RlYWQgb2YgVEFSR0VUX0xPTkdfQklUUyA9PSA2NCkgc28gd2UgY2Fu
IHJlbW92ZSB0aGVtDQo+IGxhdGVyIGFzIHVudXNlZC4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6
IFBoaWxpcHBlIE1hdGhpZXUtRGF1ZMOpIDxwaGlsbWRAbGluYXJvLm9yZz4NCj4gLS0tDQo+
ICAgdGFyZ2V0L3NwYXJjL21hY2hpbmUuYyB8IDE0ICsrKysrKysrKysrKy0tDQo+ICAgMSBm
aWxlIGNoYW5nZWQsIDEyIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQo+IA0KPiBk
aWZmIC0tZ2l0IGEvdGFyZ2V0L3NwYXJjL21hY2hpbmUuYyBiL3RhcmdldC9zcGFyYy9tYWNo
aW5lLmMNCj4gaW5kZXggMjIyZTU3MDljNTUuLmNjNTg4MTI3ODFiIDEwMDY0NA0KPiAtLS0g
YS90YXJnZXQvc3BhcmMvbWFjaGluZS5jDQo+ICsrKyBiL3RhcmdldC9zcGFyYy9tYWNoaW5l
LmMNCj4gQEAgLTg3LDcgKzg3LDEzIEBAIHN0YXRpYyBpbnQgZ2V0X2ZzcihRRU1VRmlsZSAq
Ziwgdm9pZCAqb3BhcXVlLCBzaXplX3Qgc2l6ZSwNCj4gICAgICAgICAgICAgICAgICAgICAg
Y29uc3QgVk1TdGF0ZUZpZWxkICpmaWVsZCkNCj4gICB7DQo+ICAgICAgIFNQQVJDQ1BVICpj
cHUgPSBvcGFxdWU7DQo+IC0gICAgdGFyZ2V0X3Vsb25nIHZhbCA9IHFlbXVfZ2V0X2JldGwo
Zik7DQo+ICsgICAgdGFyZ2V0X3Vsb25nIHZhbDsNCj4gKw0KPiArI2lmZGVmIFRBUkdFVF9T
UEFSQzY0DQo+ICsgICAgdmFsID0gcWVtdV9nZXRfYmU2NChmKTsNCj4gKyNlbHNlDQo+ICsg
ICAgdmFsID0gcWVtdV9nZXRfYmUzMihmKTsNCj4gKyNlbmRpZg0KPiAgIA0KPiAgICAgICBj
cHVfcHV0X2ZzcigmY3B1LT5lbnYsIHZhbCk7DQo+ICAgICAgIHJldHVybiAwOw0KPiBAQCAt
OTksNyArMTA1LDExIEBAIHN0YXRpYyBpbnQgcHV0X2ZzcihRRU1VRmlsZSAqZiwgdm9pZCAq
b3BhcXVlLCBzaXplX3Qgc2l6ZSwNCj4gICAgICAgU1BBUkNDUFUgKmNwdSA9IG9wYXF1ZTsN
Cj4gICAgICAgdGFyZ2V0X3Vsb25nIHZhbCA9IGNwdV9nZXRfZnNyKCZjcHUtPmVudik7DQo+
ICAgDQo+IC0gICAgcWVtdV9wdXRfYmV0bChmLCB2YWwpOw0KPiArI2lmZGVmIFRBUkdFVF9T
UEFSQzY0DQo+ICsgICAgcWVtdV9wdXRfYmU2NChmLCB2YWwpOw0KPiArI2Vsc2UNCj4gKyAg
ICBxZW11X3B1dF9iZTMyKGYsIHZhbCk7DQo+ICsjZW5kaWYNCj4gICAgICAgcmV0dXJuIDA7
DQo+ICAgfQ0KPiAgIA0KDQpSZXZpZXdlZC1ieTogUGllcnJpY2sgQm91dmllciA8cGllcnJp
Y2suYm91dmllckBsaW5hcm8ub3JnPg0KDQo=

