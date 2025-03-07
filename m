Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EF51C28B23
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Mar 2025 19:29:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqdHU-0003qf-2k; Fri, 07 Mar 2025 14:22:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tqdEZ-0006ZU-2g
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 14:19:47 -0500
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tqdEW-0005PB-UX
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 14:19:46 -0500
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-2fec13a4067so3631454a91.2
 for <qemu-devel@nongnu.org>; Fri, 07 Mar 2025 11:19:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741375183; x=1741979983; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=dGBOPEpoLJnftv+F44IL9sSyl0wd48zAbI62G0mxsjk=;
 b=ZX9YRmYFat6oEhxKmbAjJV/DgF7cXbEDor7CaGhewId8S+ZrrP3jy4OEMb/5eQGgQP
 2U49CTe0nXO6Os7L3nFZgO7AntjnEjYzjTFZ4LWzPw4CTssOywNJBe9EVYLyfrFGl/ks
 HKGRHVDUWK7xIRAJevQTlddHAYaZhpWdwT7uCIREtxEmC+TRvHYZYNy9VzLSwGYqO2bs
 pdvZJKov0HwQ9wAyJbvLsybmrnAZfn1c/L8jVH/yH0Wg2/LxiAaRO3y7SvfWEqZ9EJuf
 pS9Dkc6BdJK+RySrl6ebu2zFA00LDln2PPkcElEHjRmRwmmLVbfACiW6X/5L4fUbBCai
 qugw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741375183; x=1741979983;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=dGBOPEpoLJnftv+F44IL9sSyl0wd48zAbI62G0mxsjk=;
 b=pMYDwVyABCGEk2OG+EGacAFYl8EipjL8FYwAxr9F1m+M25oiCWRoBVKthK/XWaMP9i
 UU8jry9BePHDSLSV2hjpUw1dNegTT8rv47/oGlahtLenWkzbNZiGJbUXzEIYhz6VSYZ6
 SUMDLWYLoDRGpGWOUG/qwg3gSlw1ehS2PVevXBxKn24s6av1rabi8rd7G9V1CfyQwZEg
 q9wZApwgl1s0o/KBQeaFdcMQF9Y8X2Nt39quFBOOeDpe75rpNY6OHzp4EvH2/G6RtdrV
 a1S8rglJFatVhdJYaa9XzU9S4vY2XcCJW8+1InhFprxxvqosFiiAkYjq/VediIAAgkn4
 ftIg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVca5YD1JmK8kUEhJKu1ixZvqkBSmbjEeWKqYkMqp0JEkYx5ECAzAIv0fu/WDg3G7ITT9zmU0tpvjTi@nongnu.org
X-Gm-Message-State: AOJu0YyWpXOp5/xJ0kCJafLXRWZKuaWDWOWQlsqusQfuYMZkbpqaI5z1
 XpEjcTYVEjN3TQxU1CAwQ4DFePro65gRLk6VM9k6Zxf9HdLxXsqrtTosEdMD2L8=
X-Gm-Gg: ASbGncuWKr6U9xYhbdcGnaOgd9UqY6JR5vqeOroessprN/nrkjjpg5TVWOx3bmPFs27
 WINGbns/Bt4KxjfCXRloBARgn9B0nDAxIwLjl3ZxceUPb/eHs8jd8btR5hZFSBBDZRWT1QrTP38
 Li5WJM7l9jAH4yvjcRGkL7VFEF7RNn9V1bQjOe5lkvfH8RblmFrzy9tuv5fowPvLSBRAoK2a2HC
 OcRGEQ1n2+AH7ud3tmYmcUrCKeKcynARZQFKAhYDilcUQjPR8/hFg0ec02Z+VVA3jlkpuhSyliV
 84QIJNQiOhKWBZVr4On1I6nsg2BRCdRm4XbrmNkiwJOz6TaNx3k4+urgPw==
X-Google-Smtp-Source: AGHT+IH5/ocuUtLYUB/yaLzF5E8eNuzuh2M6KM3Ni4grpdlzQKCtZpFi+/Uqjj64U/wGveE6ONOPNA==
X-Received: by 2002:a17:90b:1a86:b0:2f6:dcc9:38e0 with SMTP id
 98e67ed59e1d1-2ff7cd58013mr8625652a91.0.1741375183369; 
 Fri, 07 Mar 2025 11:19:43 -0800 (PST)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2ff4e773c87sm5339712a91.16.2025.03.07.11.19.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 07 Mar 2025 11:19:42 -0800 (PST)
Message-ID: <e8171f31-6796-48dd-80cf-4fb637deb1d5@linaro.org>
Date: Fri, 7 Mar 2025 11:19:42 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 13/14] hw/vfio/ccw: Check CONFIG_IOMMUFD at runtime using
 iommufd_builtin()
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, qemu-ppc@nongnu.org,
 Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Tony Krowiak <akrowiak@linux.ibm.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 kvm@vger.kernel.org, Yi Liu <yi.l.liu@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>,
 Peter Xu <peterx@redhat.com>, Daniel Henrique Barboza
 <danielhb413@gmail.com>, Eric Auger <eric.auger@redhat.com>,
 qemu-s390x@nongnu.org, Jason Herne <jjherne@linux.ibm.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 David Hildenbrand <david@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>
References: <20250307180337.14811-1-philmd@linaro.org>
 <20250307180337.14811-14-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250307180337.14811-14-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::1029;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x1029.google.com
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

T24gMy83LzI1IDEwOjAzLCBQaGlsaXBwZSBNYXRoaWV1LURhdWTDqSB3cm90ZToNCj4gQ29u
dmVydCB0aGUgY29tcGlsZSB0aW1lIGNoZWNrIG9uIHRoZSBDT05GSUdfSU9NTVVGRCBkZWZp
bml0aW9uDQo+IGJ5IGEgcnVudGltZSBvbmUgYnkgY2FsbGluZyBpb21tdWZkX2J1aWx0aW4o
KS4NCj4gDQo+IFNpbmNlIHRoZSBmaWxlIGRvZXNuJ3QgdXNlIGFueSB0YXJnZXQtc3BlY2lm
aWMga25vd2xlZGdlIGFueW1vcmUsDQo+IG1vdmUgaXQgdG8gc3lzdGVtX3NzW10gdG8gYnVp
bGQgaXQgb25jZS4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IFBoaWxpcHBlIE1hdGhpZXUtRGF1
ZMOpIDxwaGlsbWRAbGluYXJvLm9yZz4NCj4gLS0tDQo+ICAgaHcvdmZpby9jY3cuYyAgICAg
ICB8IDI3ICsrKysrKysrKysrKystLS0tLS0tLS0tLS0tLQ0KPiAgIGh3L3ZmaW8vbWVzb24u
YnVpbGQgfCAgMiArLQ0KPiAgIDIgZmlsZXMgY2hhbmdlZCwgMTQgaW5zZXJ0aW9ucygrKSwg
MTUgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvaHcvdmZpby9jY3cuYyBiL2h3
L3ZmaW8vY2N3LmMNCj4gaW5kZXggZTVlMGQ5ZTNlN2UuLjg0ZDE0MzdhNTY4IDEwMDY0NA0K
PiAtLS0gYS9ody92ZmlvL2Njdy5jDQo+ICsrKyBiL2h3L3ZmaW8vY2N3LmMNCj4gQEAgLTE1
LDcgKzE1LDYgQEANCj4gICAgKi8NCj4gICANCj4gICAjaW5jbHVkZSAicWVtdS9vc2RlcC5o
Ig0KPiAtI2luY2x1ZGUgQ09ORklHX0RFVklDRVMgLyogQ09ORklHX0lPTU1VRkQgKi8NCj4g
ICAjaW5jbHVkZSA8bGludXgvdmZpby5oPg0KPiAgICNpbmNsdWRlIDxsaW51eC92ZmlvX2Nj
dy5oPg0KPiAgICNpbmNsdWRlIDxzeXMvaW9jdGwuaD4NCj4gQEAgLTY1MCwxMSArNjQ5LDEy
IEBAIHN0YXRpYyB2b2lkIHZmaW9fY2N3X3VucmVhbGl6ZShEZXZpY2VTdGF0ZSAqZGV2KQ0K
PiAgIHN0YXRpYyBjb25zdCBQcm9wZXJ0eSB2ZmlvX2Njd19wcm9wZXJ0aWVzW10gPSB7DQo+
ICAgICAgIERFRklORV9QUk9QX1NUUklORygic3lzZnNkZXYiLCBWRklPQ0NXRGV2aWNlLCB2
ZGV2LnN5c2ZzZGV2KSwNCj4gICAgICAgREVGSU5FX1BST1BfQk9PTCgiZm9yY2Utb3JiLXBm
Y2giLCBWRklPQ0NXRGV2aWNlLCBmb3JjZV9vcmJfcGZjaCwgZmFsc2UpLA0KPiAtI2lmZGVm
IENPTkZJR19JT01NVUZEDQo+ICsgICAgREVGSU5FX1BST1BfQ0NXX0xPQURQQVJNKCJsb2Fk
cGFybSIsIENjd0RldmljZSwgbG9hZHBhcm0pLA0KPiArfTsNCj4gKw0KPiArc3RhdGljIGNv
bnN0IFByb3BlcnR5IHZmaW9fY2N3X2lvbW11ZmRfcHJvcGVydGllc1tdID0gew0KPiAgICAg
ICBERUZJTkVfUFJPUF9MSU5LKCJpb21tdWZkIiwgVkZJT0NDV0RldmljZSwgdmRldi5pb21t
dWZkLA0KPiAgICAgICAgICAgICAgICAgICAgICAgIFRZUEVfSU9NTVVGRF9CQUNLRU5ELCBJ
T01NVUZEQmFja2VuZCAqKSwNCj4gLSNlbmRpZg0KPiAtICAgIERFRklORV9QUk9QX0NDV19M
T0FEUEFSTSgibG9hZHBhcm0iLCBDY3dEZXZpY2UsIGxvYWRwYXJtKSwNCj4gICB9Ow0KPiAg
IA0KPiAgIHN0YXRpYyBjb25zdCBWTVN0YXRlRGVzY3JpcHRpb24gdmZpb19jY3dfdm1zdGF0
ZSA9IHsNCj4gQEAgLTY4MiwxMiArNjgyLDEwIEBAIHN0YXRpYyB2b2lkIHZmaW9fY2N3X2lu
c3RhbmNlX2luaXQoT2JqZWN0ICpvYmopDQo+ICAgICAgICAgICAgICAgICAgICAgICAgREVW
SUNFKHZjZGV2KSwgdHJ1ZSk7DQo+ICAgfQ0KPiAgIA0KPiAtI2lmZGVmIENPTkZJR19JT01N
VUZEDQo+ICAgc3RhdGljIHZvaWQgdmZpb19jY3dfc2V0X2ZkKE9iamVjdCAqb2JqLCBjb25z
dCBjaGFyICpzdHIsIEVycm9yICoqZXJycCkNCj4gICB7DQo+ICAgICAgIHZmaW9fZGV2aWNl
X3NldF9mZCgmVkZJT19DQ1cob2JqKS0+dmRldiwgc3RyLCBlcnJwKTsNCj4gICB9DQo+IC0j
ZW5kaWYNCj4gICANCj4gICBzdGF0aWMgdm9pZCB2ZmlvX2Njd19jbGFzc19pbml0KE9iamVj
dENsYXNzICprbGFzcywgdm9pZCAqZGF0YSkNCj4gICB7DQo+IEBAIC02OTUsOSArNjkzLDEw
IEBAIHN0YXRpYyB2b2lkIHZmaW9fY2N3X2NsYXNzX2luaXQoT2JqZWN0Q2xhc3MgKmtsYXNz
LCB2b2lkICpkYXRhKQ0KPiAgICAgICBTMzkwQ0NXRGV2aWNlQ2xhc3MgKmNkYyA9IFMzOTBf
Q0NXX0RFVklDRV9DTEFTUyhrbGFzcyk7DQo+ICAgDQo+ICAgICAgIGRldmljZV9jbGFzc19z
ZXRfcHJvcHMoZGMsIHZmaW9fY2N3X3Byb3BlcnRpZXMpOw0KPiAtI2lmZGVmIENPTkZJR19J
T01NVUZEDQo+IC0gICAgb2JqZWN0X2NsYXNzX3Byb3BlcnR5X2FkZF9zdHIoa2xhc3MsICJm
ZCIsIE5VTEwsIHZmaW9fY2N3X3NldF9mZCk7DQo+IC0jZW5kaWYNCj4gKyAgICBpZiAoaW9t
bXVmZF9idWlsdGluKCkpIHsNCj4gKyAgICAgICAgZGV2aWNlX2NsYXNzX3NldF9wcm9wcyhk
YywgdmZpb19jY3dfaW9tbXVmZF9wcm9wZXJ0aWVzKTsNCj4gKyAgICAgICAgb2JqZWN0X2Ns
YXNzX3Byb3BlcnR5X2FkZF9zdHIoa2xhc3MsICJmZCIsIE5VTEwsIHZmaW9fY2N3X3NldF9m
ZCk7DQo+ICsgICAgfQ0KPiAgICAgICBkYy0+dm1zZCA9ICZ2ZmlvX2Njd192bXN0YXRlOw0K
PiAgICAgICBkYy0+ZGVzYyA9ICJWRklPLWJhc2VkIHN1YmNoYW5uZWwgYXNzaWdubWVudCI7
DQo+ICAgICAgIHNldF9iaXQoREVWSUNFX0NBVEVHT1JZX01JU0MsIGRjLT5jYXRlZ29yaWVz
KTsNCj4gQEAgLTcxNiwxMSArNzE1LDExIEBAIHN0YXRpYyB2b2lkIHZmaW9fY2N3X2NsYXNz
X2luaXQoT2JqZWN0Q2xhc3MgKmtsYXNzLCB2b2lkICpkYXRhKQ0KPiAgICAgICBvYmplY3Rf
Y2xhc3NfcHJvcGVydHlfc2V0X2Rlc2NyaXB0aW9uKGtsYXNzLCAvKiAzLjAgKi8NCj4gICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAiZm9yY2Utb3JiLXBm
Y2giLA0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICJG
b3JjZSB1bmxpbWl0ZWQgcHJlZmV0Y2giKTsNCj4gLSNpZmRlZiBDT05GSUdfSU9NTVVGRA0K
PiAtICAgIG9iamVjdF9jbGFzc19wcm9wZXJ0eV9zZXRfZGVzY3JpcHRpb24oa2xhc3MsIC8q
IDkuMCAqLw0KPiAtICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ImlvbW11ZmQiLA0KPiAtICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIlNldCBob3N0IElPTU1VRkQgYmFja2VuZCBkZXZpY2UiKTsNCj4gLSNlbmRpZg0KPiAr
ICAgIGlmIChpb21tdWZkX2J1aWx0aW4oKSkgew0KPiArICAgICAgICBvYmplY3RfY2xhc3Nf
cHJvcGVydHlfc2V0X2Rlc2NyaXB0aW9uKGtsYXNzLCAvKiA5LjAgKi8NCj4gKyAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAiaW9tbXVmZCIsDQo+ICsg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIlNldCBob3N0
IElPTU1VRkQgYmFja2VuZCBkZXZpY2UiKTsNCj4gKyAgICB9DQo+ICAgICAgIG9iamVjdF9j
bGFzc19wcm9wZXJ0eV9zZXRfZGVzY3JpcHRpb24oa2xhc3MsIC8qIDkuMiAqLw0KPiAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICJsb2FkcGFybSIsDQo+
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIkRlZmluZSB3
aGljaCBkZXZpY2VzIHRoYXQgY2FuIGJlIHVzZWQgZm9yIGJvb3RpbmciKTsNCj4gZGlmZiAt
LWdpdCBhL2h3L3ZmaW8vbWVzb24uYnVpbGQgYi9ody92ZmlvL21lc29uLmJ1aWxkDQo+IGlu
ZGV4IDUxMGViZTZkNzIwLi5iZDZlMWQ5OTllNCAxMDA2NDQNCj4gLS0tIGEvaHcvdmZpby9t
ZXNvbi5idWlsZA0KPiArKysgYi9ody92ZmlvL21lc29uLmJ1aWxkDQo+IEBAIC03LDcgKzcs
NiBAQCB2ZmlvX3NzLmFkZCh3aGVuOiAnQ09ORklHX1BTRVJJRVMnLCBpZl90cnVlOiBmaWxl
cygnc3BhcHIuYycpKQ0KPiAgIHZmaW9fc3MuYWRkKHdoZW46ICdDT05GSUdfVkZJT19QQ0kn
LCBpZl90cnVlOiBmaWxlcygNCj4gICAgICdwY2ktcXVpcmtzLmMnLA0KPiAgICkpDQo+IC12
ZmlvX3NzLmFkZCh3aGVuOiAnQ09ORklHX1ZGSU9fQ0NXJywgaWZfdHJ1ZTogZmlsZXMoJ2Nj
dy5jJykpDQo+ICAgdmZpb19zcy5hZGQod2hlbjogJ0NPTkZJR19WRklPX1BMQVRGT1JNJywg
aWZfdHJ1ZTogZmlsZXMoJ3BsYXRmb3JtLmMnKSkNCj4gICANCj4gICBzcGVjaWZpY19zcy5h
ZGRfYWxsKHdoZW46ICdDT05GSUdfVkZJTycsIGlmX3RydWU6IHZmaW9fc3MpDQo+IEBAIC0y
Niw2ICsyNSw3IEBAIHN5c3RlbV9zcy5hZGQod2hlbjogWydDT05GSUdfVkZJTycsICdDT05G
SUdfSU9NTVVGRCddLCBpZl90cnVlOiBmaWxlcygNCj4gICAgICdpb21tdWZkLmMnLA0KPiAg
ICkpDQo+ICAgc3lzdGVtX3NzLmFkZCh3aGVuOiAnQ09ORklHX1ZGSU9fQVAnLCBpZl90cnVl
OiBmaWxlcygnYXAuYycpKQ0KPiArc3lzdGVtX3NzLmFkZCh3aGVuOiAnQ09ORklHX1ZGSU9f
Q0NXJywgaWZfdHJ1ZTogZmlsZXMoJ2Njdy5jJykpDQo+ICAgc3lzdGVtX3NzLmFkZCh3aGVu
OiAnQ09ORklHX1ZGSU9fUENJJywgaWZfdHJ1ZTogZmlsZXMoDQo+ICAgICAnZGlzcGxheS5j
JywNCj4gICAgICdwY2kuYycsDQoNClJldmlld2VkLWJ5OiBQaWVycmljayBCb3V2aWVyIDxw
aWVycmljay5ib3V2aWVyQGxpbmFyby5vcmc+DQoNCg==

