Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 097C2C3600B
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Mar 2025 15:30:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1txShb-000115-Ea; Wed, 26 Mar 2025 11:30:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1txShB-0000wv-Pk
 for qemu-devel@nongnu.org; Wed, 26 Mar 2025 11:29:34 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1txSh6-0005jj-V0
 for qemu-devel@nongnu.org; Wed, 26 Mar 2025 11:29:30 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-22423adf751so132707165ad.2
 for <qemu-devel@nongnu.org>; Wed, 26 Mar 2025 08:29:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743002967; x=1743607767; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=S8NZTTcQG0m6eq6/aNci5+eMmGwjz5XKnTA+1luJhxo=;
 b=kyzPPdRh0A45KF7waQ1ujHsSqN2UEq6xjdoRxHRw5vPEM6JI71vnG6sn6/JBP0+JQW
 zB8ixrqVeQ92+LOoHCtN+mgVrvVaWO/KplGfvMfXeEWVIUAUFCJUgNoTezciRNBl9zk+
 wWUlmlynNtia8vBSqGYK7Su8f3hsVxRwNyunVzLMqXxljX4eieWko6x+o63veFPfnvOL
 ZGxztBRCSM0KGgPycKuCfcnoZWBsjBP0NjtzvsoNYDj9XkAMnUCJWMESh8T9j5rEk7Av
 g/R3Ul4OxEE357Jw7vKVRrZ/wEWhESIzBoS8DClZ/7ERNdQHUmYhgjPOnsZPcrxwOITv
 nB/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743002967; x=1743607767;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=S8NZTTcQG0m6eq6/aNci5+eMmGwjz5XKnTA+1luJhxo=;
 b=P2wkzfrNEFOgaCKEyok0SU5m6iZPw9OwBaLIgvveJEQJWgCdxEZtRYfIDXXh2p61Uw
 sJwKirUd1L33BbI6NyfIFoYyV++6yDEQ6L3jXhxlRpTg9AHqZgMlGJuO92SiN9cv0e7o
 BsTJ4TtgY0TPsFGT52kzWvQORFiA5YQzxZZNy4ZEFhywS45NfuD6AMI9NPBNpy31OpV0
 qFseskeDZ9XQ5YL6b6a4SjFBxobskTqyX7MaiqOjktI5yUYWNLa0DcjkrbpghRKxIfDv
 uBy8veMD8hGnAyxkohKUa2MXgs/ByIB43wQ4ucVwIATkj3Mh3m6M4McU1ealDCC4MK6p
 xBqg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV2cfSCusoEjAHLN+78JKValKpxCAHZybDVJ6aKB4VAmcBEKIlRBnyogP+vLXbf2TNPPQHX72a83wO4@nongnu.org
X-Gm-Message-State: AOJu0YytQkLavpWLyGHC4WL+lxMbiZ2qHadcOdZNwAuOGxHbpS92KhC7
 Lqf9PLLQZQ4WYxASTi2htlHM9ggLw8xqsV2cT/AGbtOURWLqRLVvEJSpdk4BjMREn66iuZB0ZIz
 M
X-Gm-Gg: ASbGncs+aajP5qig2u57EQEViiNWE9XGL+RbaCsVMIaIhmwTRpT24HQeF5S2KYqWIMY
 yXvC1mm/pRDrwj7hC2n5KX/hr18Z8mWsC9NzvgjV6w3hke55cHJyqzbPBFoEYQ1Z5xfS1PO7hYv
 BzKwIwqoooFYMDMwSOeHsCA/hfflmrDLYBprF9agWOMC9PSYJui9tsSnojH4eASLRhOtpGlAVS+
 2X7DDgf0ogoXpogjifKHhpJmBad1fGgsfbhU3VK5b1ubKMYVOkCGv2bqjZ/PDoGe+H/NKmKTk4y
 w7++BFQEqe0kPpxG7LJYNiXuGAadxL5VFwKROVjxqQCM75RgtC1/hTtfEg==
X-Google-Smtp-Source: AGHT+IExOLe5bqffoRP/Pidrou6g1tSzTuw80gFI22oB/SG0V4Rml+2VqPBznggYFQqcfHz2t8/WPw==
X-Received: by 2002:a17:903:2350:b0:216:410d:4c53 with SMTP id
 d9443c01a7336-22780e10cdemr310285995ad.41.1743002967523; 
 Wed, 26 Mar 2025 08:29:27 -0700 (PDT)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-227811bc272sm111122885ad.146.2025.03.26.08.29.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Mar 2025 08:29:26 -0700 (PDT)
Message-ID: <009a68c6-1487-4bb1-b9d5-69879a06087f@linaro.org>
Date: Wed, 26 Mar 2025 08:26:25 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-10.1 6/8] target/mips: Introduce mips_cpu_is_64bit()
 helper
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
 <20250325154058.92735-7-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250325154058.92735-7-philmd@linaro.org>
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

T24gMy8yNS8yNSAwODo0MCwgUGhpbGlwcGUgTWF0aGlldS1EYXVkw6kgd3JvdGU6DQo+IG1p
cHNfY3B1X2lzXzY0Yml0KCkgcmV0dXJucyB3aGV0aGVyIHRoZSBDUFUgaXMgYQ0KPiAzMi1i
aXQgb3IgYSA2NC1iaXQgb25lLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogUGhpbGlwcGUgTWF0
aGlldS1EYXVkw6kgPHBoaWxtZEBsaW5hcm8ub3JnPg0KPiAtLS0NCj4gICB0YXJnZXQvbWlw
cy9jcHUtcW9tLmggfCAyICsrDQo+ICAgdGFyZ2V0L21pcHMvY3B1LmMgICAgIHwgNiArKysr
KysNCj4gICAyIGZpbGVzIGNoYW5nZWQsIDggaW5zZXJ0aW9ucygrKQ0KPiANCj4gZGlmZiAt
LWdpdCBhL3RhcmdldC9taXBzL2NwdS1xb20uaCBiL3RhcmdldC9taXBzL2NwdS1xb20uaA0K
PiBpbmRleCA5YWNmNjQ3NDIwYy4uNTI5OTZlN2MzNTQgMTAwNjQ0DQo+IC0tLSBhL3Rhcmdl
dC9taXBzL2NwdS1xb20uaA0KPiArKysgYi90YXJnZXQvbWlwcy9jcHUtcW9tLmgNCj4gQEAg
LTMzLDQgKzMzLDYgQEAgT0JKRUNUX0RFQ0xBUkVfQ1BVX1RZUEUoTUlQU0NQVSwgTUlQU0NQ
VUNsYXNzLCBNSVBTX0NQVSkNCj4gICAjZGVmaW5lIE1JUFNfQ1BVX1RZUEVfU1VGRklYICIt
IiBUWVBFX01JUFNfQ1BVDQo+ICAgI2RlZmluZSBNSVBTX0NQVV9UWVBFX05BTUUobW9kZWwp
IG1vZGVsIE1JUFNfQ1BVX1RZUEVfU1VGRklYDQo+ICAgDQo+ICtib29sIG1pcHNfY3B1X2lz
XzY0Yml0KE1JUFNDUFUgKmNwdSk7DQo+ICsNCj4gICAjZW5kaWYNCj4gZGlmZiAtLWdpdCBh
L3RhcmdldC9taXBzL2NwdS5jIGIvdGFyZ2V0L21pcHMvY3B1LmMNCj4gaW5kZXggZDg5MzA0
NjhiN2QuLjA1YjNjZTQyYWY1IDEwMDY0NA0KPiAtLS0gYS90YXJnZXQvbWlwcy9jcHUuYw0K
PiArKysgYi90YXJnZXQvbWlwcy9jcHUuYw0KPiBAQCAtNTE2LDYgKzUxNiwxMiBAQCBzdGF0
aWMgdm9pZCBtaXBzX2NwdV9pbml0Zm4oT2JqZWN0ICpvYmopDQo+ICAgI2VuZGlmDQo+ICAg
fQ0KPiAgIA0KPiArYm9vbCBtaXBzX2NwdV9pc182NGJpdChNSVBTQ1BVICpjcHUpDQo+ICt7
DQo+ICsgICAgcmV0dXJuICEhb2JqZWN0X2NsYXNzX2R5bmFtaWNfY2FzdChPQkpFQ1RfQ0xB
U1MoQ1BVKGNwdSktPmNjKSwNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIFRZUEVfTUlQUzY0X0NQVSk7DQo+ICt9DQo+ICsNCj4gICBzdGF0aWMgY2hhciAq
bWlwc19jcHVfdHlwZV9uYW1lKGNvbnN0IGNoYXIgKmNwdV9tb2RlbCkNCj4gICB7DQo+ICAg
ICAgIHJldHVybiBnX3N0cmR1cF9wcmludGYoTUlQU19DUFVfVFlQRV9OQU1FKCIlcyIpLCBj
cHVfbW9kZWwpOw0KDQpSZXZpZXdlZC1ieTogUGllcnJpY2sgQm91dmllciA8cGllcnJpY2su
Ym91dmllckBsaW5hcm8ub3JnPg0KDQpPbiB0aGUgbG9uZyB0ZXJtLCB3aGVuIGhhdmluZyB0
aGUgVGFyZ2V0SW5mbywgdGhpcyBpcyBwcm9iYWJseSBhbiANCmluZm9ybWF0aW9uIHdlIHdh
bnQgdG8gYmUgYWJsZSB0byByZXRyaWV2ZSBpbiB0aGUgc2FtZSB3YXkgZm9yIGV2ZXJ5IA0K
dGFyZ2V0LiBUaGF0IHNhaWQsIHdlIGNhbiBhbHdheXMgcmVwbGFjZSB0aGF0IGxhdGVyLCBz
byB0aGlzIHBhdGNoIGlzIG9rIA0KZm9yIG5vdy4NCg==

