Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA97CC19F32
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Mar 2025 19:28:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqdHK-0003Tb-Kg; Fri, 07 Mar 2025 14:22:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tqdE0-0005OX-2D
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 14:19:13 -0500
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tqdDx-0005Le-C3
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 14:19:10 -0500
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-22356471820so37842605ad.0
 for <qemu-devel@nongnu.org>; Fri, 07 Mar 2025 11:19:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741375148; x=1741979948; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=EL9ev4fYnuwjSp/gbtmrkNBbADrSXP4Qa9leqBRx5eY=;
 b=AUTnnsTB+0u2q9+P46437SnbM45EV/6tNhPMoScB4PdtvsIWhCfcoS/rK8SbfVGRF/
 m/Khplnx2sLnVaIyvGoHnCDUVkie+84aWd1P0Aiftxqpy5PkAq8TT5AGORjuFol3++Mp
 cwgSnPwGEAc+1wYd4qgtj36KSTKKAOu57W/dKlqhA4l5usRJ/ynWG+rNaPM81VsVaL92
 sztRM3Q04FJ7TLP4LUuAYoeFyMAGR3BFr1oVQd7fNfKVv79KT0WHWlLpyqJiRuL3gRjp
 QXY+fy2ZrEiRCbBwgySi84f0B1PMqK/NRtGj/P+s4TzIOkOgLdvb6uy71mCpudJoEEVB
 zOVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741375148; x=1741979948;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=EL9ev4fYnuwjSp/gbtmrkNBbADrSXP4Qa9leqBRx5eY=;
 b=w4RKWJmc1g9XVycCZ3IMVbNJpjcV6kH1B9+Y+1x0mq7OPU4OFxfZBGTLQZITxnmyA1
 enwViVYECTO3nIxoDP8/YcRG46JvyohDWu+GreIFeHgdFGZjlerRGRP21eDV0zjaaaJ1
 WtCxXHqjVoUZmq0Bo1kJ7Jn/ZkIbZsb+A8oaKnr9U2UYDncRO8c12VOZWyzNN9KtnKqv
 WqR9m4qcr4DLAy7qAtHw9ML/Cu9EBDQgTWLNkiQYfzudz6utevwabzhFgTHWNPMGHo7r
 yLJL/DcxKqVVUSWakoLtdlYBrGxggdO6wSgl4ACZJupM910C1B8gWVZHLoIV1DwdJfRU
 XK+g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUBMwDQj6TCMEbaOZ35OHuXD5MgwatjSQ6A/zpmIKeUZ/LA9dgMlk7W1DnKNtAwI7ZfUUqI0TliNWgE@nongnu.org
X-Gm-Message-State: AOJu0Yx6GLlYNWxXJGwydP5/5im6Itm5Py6ne5R//mrKckE841pihxxu
 JXEtt/S4zE1Y9xkMZ4JDzcQm74kjmayUC9haocHdbr3K5QbxF3tvaIt4jfEbOh7RyK2xZiui5uX
 z
X-Gm-Gg: ASbGncuxu+RDd3vN43j3yHGBl/ias/IDkAo+1RvVSGxKsYNQtPCS3N2B3Mr+PXSvPQ0
 Lp5gm1lw9Fqq4aqT4uRyS2iR9TRQ+H+ee8lCCuBC3p0gSCzBtzZ7hqqunctjhB3CGgug0+Uirjm
 XVYr6jx0gw9tBkBMNCQBgr6iQzn9ChHvtdHEEWR2ua09QGJSeIYDvumA+eQq7Z3qhJ2K4oEJU13
 1bd1TMb5Bp46ryVZ12RnB8qVo0V43aj4NILqLVwH+HaLVu5BVo5bKc3gKsdnD3jSxXOZ1SNmMRC
 e2jtOvy2+EWeQhKTGsAEREHPjqjm1T4gMs/6vTwfoxjhvSTXz25gc6pNPA==
X-Google-Smtp-Source: AGHT+IGmifsCw1FrIn9vrgcuI8mwFfE3GFR/kzOuNybbE/PFBGf19XE5D9LoWY3OgbblqUkVIuE0fw==
X-Received: by 2002:a05:6a00:4b4a:b0:736:5753:12f7 with SMTP id
 d2e1a72fcca58-736aa9b9741mr7490231b3a.3.1741375147975; 
 Fri, 07 Mar 2025 11:19:07 -0800 (PST)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-736984f723asm3739928b3a.96.2025.03.07.11.19.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 07 Mar 2025 11:19:07 -0800 (PST)
Message-ID: <0c70440f-675f-472b-a684-3cb8424715d4@linaro.org>
Date: Fri, 7 Mar 2025 11:19:06 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/14] hw/vfio/pci: Check CONFIG_IOMMUFD at runtime using
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
 <20250307180337.14811-12-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250307180337.14811-12-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x636.google.com
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
ZMOpIDxwaGlsbWRAbGluYXJvLm9yZz4NCj4gLS0tDQo+ICAgaHcvdmZpby9wY2kuYyAgICAg
ICB8IDM4ICsrKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0tLS0tLS0tDQo+ICAgaHcv
dmZpby9tZXNvbi5idWlsZCB8ICAyICstDQo+ICAgMiBmaWxlcyBjaGFuZ2VkLCAxOSBpbnNl
cnRpb25zKCspLCAyMSBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9ody92Zmlv
L3BjaS5jIGIvaHcvdmZpby9wY2kuYw0KPiBpbmRleCA5ODcyODg0ZmY4YS4uZTgzMjUyNzY2
ZDEgMTAwNjQ0DQo+IC0tLSBhL2h3L3ZmaW8vcGNpLmMNCj4gKysrIGIvaHcvdmZpby9wY2ku
Yw0KPiBAQCAtMTksNyArMTksNiBAQA0KPiAgICAqLw0KPiAgIA0KPiAgICNpbmNsdWRlICJx
ZW11L29zZGVwLmgiDQo+IC0jaW5jbHVkZSBDT05GSUdfREVWSUNFUyAvKiBDT05GSUdfSU9N
TVVGRCAqLw0KPiAgICNpbmNsdWRlIDxsaW51eC92ZmlvLmg+DQo+ICAgI2luY2x1ZGUgPHN5
cy9pb2N0bC5oPg0KPiAgIA0KPiBAQCAtMjk3MywxMSArMjk3MiwxMCBAQCBzdGF0aWMgdm9p
ZCB2ZmlvX3JlYWxpemUoUENJRGV2aWNlICpwZGV2LCBFcnJvciAqKmVycnApDQo+ICAgICAg
ICAgICBpZiAoISh+dmRldi0+aG9zdC5kb21haW4gfHwgfnZkZXYtPmhvc3QuYnVzIHx8DQo+
ICAgICAgICAgICAgICAgICB+dmRldi0+aG9zdC5zbG90IHx8IH52ZGV2LT5ob3N0LmZ1bmN0
aW9uKSkgew0KPiAgICAgICAgICAgICAgIGVycm9yX3NldGcoZXJycCwgIk5vIHByb3ZpZGVk
IGhvc3QgZGV2aWNlIik7DQo+IC0gICAgICAgICAgICBlcnJvcl9hcHBlbmRfaGludChlcnJw
LCAiVXNlIC1kZXZpY2UgdmZpby1wY2ksaG9zdD1EREREOkJCOkRELkYgIg0KPiAtI2lmZGVm
IENPTkZJR19JT01NVUZEDQo+IC0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAib3Ig
LWRldmljZSB2ZmlvLXBjaSxmZD1ERVZJQ0VfRkQgIg0KPiAtI2VuZGlmDQo+IC0gICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAib3IgLWRldmljZSB2ZmlvLXBjaSxzeXNmc2Rldj1Q
QVRIX1RPX0RFVklDRVxuIik7DQo+ICsgICAgICAgICAgICBlcnJvcl9hcHBlbmRfaGludChl
cnJwLCAiVXNlIC1kZXZpY2UgdmZpby1wY2ksaG9zdD1EREREOkJCOkRELkYgJXMiDQo+ICsg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAib3IgLWRldmljZSB2ZmlvLXBjaSxzeXNm
c2Rldj1QQVRIX1RPX0RFVklDRVxuIiwNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIGlvbW11ZmRfYnVpbHRpbigpDQo+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICA/ICJvciAtZGV2aWNlIHZmaW8tcGNpLGZkPURFVklDRV9GRCAiIDogIiIpOw0KPiAgICAg
ICAgICAgICAgIHJldHVybjsNCj4gICAgICAgICAgIH0NCj4gICAgICAgICAgIHZiYXNlZGV2
LT5zeXNmc2RldiA9DQo+IEBAIC0zNDEyLDE5ICszNDEwLDE4IEBAIHN0YXRpYyBjb25zdCBQ
cm9wZXJ0eSB2ZmlvX3BjaV9kZXZfcHJvcGVydGllc1tdID0gew0KPiAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgcWRldl9wcm9wX252X2dwdWRpcmVjdF9jbGlxdWUs
IHVpbnQ4X3QpLA0KPiAgICAgICBERUZJTkVfUFJPUF9PRkZfQVVUT19QQ0lCQVIoIngtbXNp
eC1yZWxvY2F0aW9uIiwgVkZJT1BDSURldmljZSwgbXNpeF9yZWxvLA0KPiAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgT0ZGX0FVVE9fUENJQkFSX09GRiksDQo+IC0jaWZk
ZWYgQ09ORklHX0lPTU1VRkQNCj4gLSAgICBERUZJTkVfUFJPUF9MSU5LKCJpb21tdWZkIiwg
VkZJT1BDSURldmljZSwgdmJhc2VkZXYuaW9tbXVmZCwNCj4gLSAgICAgICAgICAgICAgICAg
ICAgIFRZUEVfSU9NTVVGRF9CQUNLRU5ELCBJT01NVUZEQmFja2VuZCAqKSwNCj4gLSNlbmRp
Zg0KPiAgICAgICBERUZJTkVfUFJPUF9CT09MKCJza2lwLXZzYy1jaGVjayIsIFZGSU9QQ0lE
ZXZpY2UsIHNraXBfdnNjX2NoZWNrLCB0cnVlKSwNCj4gICB9Ow0KPiAgIA0KPiAtI2lmZGVm
IENPTkZJR19JT01NVUZEDQo+ICtzdGF0aWMgY29uc3QgUHJvcGVydHkgdmZpb19wY2lfZGV2
X2lvbW11ZmRfcHJvcGVydGllc1tdID0gew0KPiArICAgIERFRklORV9QUk9QX0xJTksoImlv
bW11ZmQiLCBWRklPUENJRGV2aWNlLCB2YmFzZWRldi5pb21tdWZkLA0KPiArICAgICAgICAg
ICAgICAgICAgICAgVFlQRV9JT01NVUZEX0JBQ0tFTkQsIElPTU1VRkRCYWNrZW5kICopLA0K
PiArfTsNCj4gKw0KPiAgIHN0YXRpYyB2b2lkIHZmaW9fcGNpX3NldF9mZChPYmplY3QgKm9i
aiwgY29uc3QgY2hhciAqc3RyLCBFcnJvciAqKmVycnApDQo+ICAgew0KPiAgICAgICB2Zmlv
X2RldmljZV9zZXRfZmQoJlZGSU9fUENJKG9iaiktPnZiYXNlZGV2LCBzdHIsIGVycnApOw0K
PiAgIH0NCj4gLSNlbmRpZg0KPiAgIA0KPiAgIHN0YXRpYyB2b2lkIHZmaW9fcGNpX2Rldl9j
bGFzc19pbml0KE9iamVjdENsYXNzICprbGFzcywgdm9pZCAqZGF0YSkNCj4gICB7DQo+IEBA
IC0zNDMzLDkgKzM0MzAsMTAgQEAgc3RhdGljIHZvaWQgdmZpb19wY2lfZGV2X2NsYXNzX2lu
aXQoT2JqZWN0Q2xhc3MgKmtsYXNzLCB2b2lkICpkYXRhKQ0KPiAgIA0KPiAgICAgICBkZXZp
Y2VfY2xhc3Nfc2V0X2xlZ2FjeV9yZXNldChkYywgdmZpb19wY2lfcmVzZXQpOw0KPiAgICAg
ICBkZXZpY2VfY2xhc3Nfc2V0X3Byb3BzKGRjLCB2ZmlvX3BjaV9kZXZfcHJvcGVydGllcyk7
DQo+IC0jaWZkZWYgQ09ORklHX0lPTU1VRkQNCj4gLSAgICBvYmplY3RfY2xhc3NfcHJvcGVy
dHlfYWRkX3N0cihrbGFzcywgImZkIiwgTlVMTCwgdmZpb19wY2lfc2V0X2ZkKTsNCj4gLSNl
bmRpZg0KPiArICAgIGlmIChpb21tdWZkX2J1aWx0aW4oKSkgew0KPiArICAgICAgICBkZXZp
Y2VfY2xhc3Nfc2V0X3Byb3BzKGRjLCB2ZmlvX3BjaV9kZXZfaW9tbXVmZF9wcm9wZXJ0aWVz
KTsNCj4gKyAgICAgICAgb2JqZWN0X2NsYXNzX3Byb3BlcnR5X2FkZF9zdHIoa2xhc3MsICJm
ZCIsIE5VTEwsIHZmaW9fcGNpX3NldF9mZCk7DQo+ICsgICAgfQ0KPiAgICAgICBkYy0+ZGVz
YyA9ICJWRklPLWJhc2VkIFBDSSBkZXZpY2UgYXNzaWdubWVudCI7DQo+ICAgICAgIHNldF9i
aXQoREVWSUNFX0NBVEVHT1JZX01JU0MsIGRjLT5jYXRlZ29yaWVzKTsNCj4gICAgICAgcGRj
LT5yZWFsaXplID0gdmZpb19yZWFsaXplOw0KPiBAQCAtMzU0MCwxMSArMzUzOCwxMSBAQCBz
dGF0aWMgdm9pZCB2ZmlvX3BjaV9kZXZfY2xhc3NfaW5pdChPYmplY3RDbGFzcyAqa2xhc3Ms
IHZvaWQgKmRhdGEpDQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgInZmLXRva2VuIiwNCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAiU3BlY2lmeSBVVUlEIFZGIHRva2VuLiBSZXF1aXJlZCBmb3IgVkYgd2hl
biBQRiBpcyBvd25lZCAiDQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgImJ5IGFub3RoZXIgVkZJTyBkcml2ZXIiKTsNCj4gLSNpZmRlZiBDT05GSUdf
SU9NTVVGRA0KPiAtICAgIG9iamVjdF9jbGFzc19wcm9wZXJ0eV9zZXRfZGVzY3JpcHRpb24o
a2xhc3MsIC8qIDkuMCAqLw0KPiAtICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgImlvbW11ZmQiLA0KPiAtICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIlNldCBob3N0IElPTU1VRkQgYmFja2VuZCBkZXZpY2UiKTsNCj4gLSNl
bmRpZg0KPiArICAgIGlmIChpb21tdWZkX2J1aWx0aW4oKSkgew0KPiArICAgICAgICBvYmpl
Y3RfY2xhc3NfcHJvcGVydHlfc2V0X2Rlc2NyaXB0aW9uKGtsYXNzLCAvKiA5LjAgKi8NCj4g
KyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAiaW9tbXVm
ZCIsDQo+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IlNldCBob3N0IElPTU1VRkQgYmFja2VuZCBkZXZpY2UiKTsNCj4gKyAgICB9DQo+ICAgICAg
IG9iamVjdF9jbGFzc19wcm9wZXJ0eV9zZXRfZGVzY3JpcHRpb24oa2xhc3MsIC8qIDkuMSAq
Lw0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICJ4LWRl
dmljZS1kaXJ0eS1wYWdlLXRyYWNraW5nIiwNCj4gICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAiRGlzYWJsZSBkZXZpY2UgZGlydHkgcGFnZSB0cmFja2lu
ZyBhbmQgdXNlICINCj4gZGlmZiAtLWdpdCBhL2h3L3ZmaW8vbWVzb24uYnVpbGQgYi9ody92
ZmlvL21lc29uLmJ1aWxkDQo+IGluZGV4IDk2ZTM0MmFhOGNiLi45YTAwNDk5MmMxMSAxMDA2
NDQNCj4gLS0tIGEvaHcvdmZpby9tZXNvbi5idWlsZA0KPiArKysgYi9ody92ZmlvL21lc29u
LmJ1aWxkDQo+IEBAIC02LDcgKzYsNiBAQCB2ZmlvX3NzLmFkZChmaWxlcygNCj4gICB2Zmlv
X3NzLmFkZCh3aGVuOiAnQ09ORklHX1BTRVJJRVMnLCBpZl90cnVlOiBmaWxlcygnc3BhcHIu
YycpKQ0KPiAgIHZmaW9fc3MuYWRkKHdoZW46ICdDT05GSUdfVkZJT19QQ0knLCBpZl90cnVl
OiBmaWxlcygNCj4gICAgICdwY2ktcXVpcmtzLmMnLA0KPiAtICAncGNpLmMnLA0KPiAgICkp
DQo+ICAgdmZpb19zcy5hZGQod2hlbjogJ0NPTkZJR19WRklPX0NDVycsIGlmX3RydWU6IGZp
bGVzKCdjY3cuYycpKQ0KPiAgIHZmaW9fc3MuYWRkKHdoZW46ICdDT05GSUdfVkZJT19QTEFU
Rk9STScsIGlmX3RydWU6IGZpbGVzKCdwbGF0Zm9ybS5jJykpDQo+IEBAIC0yOSw0ICsyOCw1
IEBAIHN5c3RlbV9zcy5hZGQod2hlbjogWydDT05GSUdfVkZJTycsICdDT05GSUdfSU9NTVVG
RCddLCBpZl90cnVlOiBmaWxlcygNCj4gICApKQ0KPiAgIHN5c3RlbV9zcy5hZGQod2hlbjog
J0NPTkZJR19WRklPX1BDSScsIGlmX3RydWU6IGZpbGVzKA0KPiAgICAgJ2Rpc3BsYXkuYycs
DQo+ICsgICdwY2kuYycsDQo+ICAgKSkNCg0KUmV2aWV3ZWQtYnk6IFBpZXJyaWNrIEJvdXZp
ZXIgPHBpZXJyaWNrLmJvdXZpZXJAbGluYXJvLm9yZz4NCg0K

