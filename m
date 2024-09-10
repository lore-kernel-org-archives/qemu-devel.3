Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E281EEB64DE
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2024 14:46:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1so28A-0003YK-DA; Tue, 10 Sep 2024 10:46:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1so285-0003E3-Ux
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 10:46:06 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1so283-0002sT-Sx
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 10:46:05 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-717929b671eso787484b3a.0
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2024 07:45:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725979554; x=1726584354; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=uYSeYNIcyB/uAalIVUx5IAGO9XhLQ4BnuYdzVKveX5M=;
 b=f/j84GWE2te+9n4lFB4FiztrtdulqKmCQEv+R4IPSgxdC2WqTjog1HC5KV7eeUwi68
 7gglzYMHAM9FdxfWIstG4OP0MKnRvana3BjGddRFVuhW9Ld8Gjs+tINwdh1vZmFKgvZ8
 Ksn3zllbeaMD5MjqKwCjEktFmD+affCX4R9DxNJqsaxxSg0+okIz+/Rz4LOS6kDeey2b
 JaXcx+F2QXFlIek2JwFhRg0SjHUp/9zViUmLoQHa9iJ+USELKzRZ4oBj4AP+qIUqBa1P
 nSQDNFMCWCEXHE5nT58odQGrtM1C1Yxl8XOaIl2pbX6catON8+2XRLoOGaVeGTbanYQb
 7vTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725979554; x=1726584354;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=uYSeYNIcyB/uAalIVUx5IAGO9XhLQ4BnuYdzVKveX5M=;
 b=FZjjjMlJNH68gSf46C4QKPL6z98HAfuYv8Bt3yEZI/ecmTDwFL1HE3PaQce+syLcjy
 ENhnewNo/revhGwDpT9SgZH5DrZ53mSawHOqMIbod9iHzlIbq1/Ct6t3lr4GJ0KMKGiw
 BALKIIVX6oEIEv5t1SBxRaP7/MVdt8QELOjQIOmAKDljYEEGcbhtWwL7JoXQQdW1GtrA
 8i9gxr3uzko6QRLFhMqbCEhoawnxZZTBNjmDeu1/JxGkUMSF4Ino/RII+591So/i/mro
 wjiLf1X7Kqp1O3Qt4Ny8H4VU7sXjrElOzFEsZxfKIv+iiu2Prz8MSK5vWIkSUIfTTcfi
 mz3Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWmJukLxgyzRNE9ZsU8usp5Q5WdZeSF5KPDHUX6MOj2/beEM6Qfk/NwGHmRk7QP7RyxBIOcGi+Crknq@nongnu.org
X-Gm-Message-State: AOJu0YyDeQPA1/Xikvq2FrxcndjV0O4+x74jENhUkCSkZqMqTCfH3E3j
 TKb3Dm2GffWTFeNtnXCSQVka9hvfTidk1Vh1VnE7AyIqcBas9Qcxt3dHYfRbGfA=
X-Google-Smtp-Source: AGHT+IGyL0oyBzc2ysV4WxjzqE9iaKhofGCvuUZhjwiX0XDoewtdeUOc1LeOdNsATLz5adCPNiVfSg==
X-Received: by 2002:a05:6a00:91cb:b0:714:1fc3:79f4 with SMTP id
 d2e1a72fcca58-718d5df1e4emr12664029b3a.5.1725979554446; 
 Tue, 10 Sep 2024 07:45:54 -0700 (PDT)
Received: from ?IPV6:2604:3d08:9384:1d00::9633? ([2604:3d08:9384:1d00::9633])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-719090923adsm1448840b3a.100.2024.09.10.07.45.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Sep 2024 07:45:54 -0700 (PDT)
Message-ID: <89d18e02-8d08-46cb-80a9-2d826f22bbea@linaro.org>
Date: Tue, 10 Sep 2024 07:45:52 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/26] deprecation: don't enable TCG plugins by default
 with TCI
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Eduardo Habkost <eduardo@habkost.net>, Zhao Liu <zhao1.liu@intel.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Beraldo Leal <bleal@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Alexandre Iooss <erdnaxe@crans.org>,
 Yanan Wang <wangyanan55@huawei.com>, Peter Maydell
 <peter.maydell@linaro.org>, Mahmoud Mandour <ma.mandourr@gmail.com>,
 Thomas Huth <thuth@redhat.com>, qemu-arm@nongnu.org,
 devel@lists.libvirt.org, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>
References: <20240910140733.4007719-1-alex.bennee@linaro.org>
 <20240910140733.4007719-13-alex.bennee@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20240910140733.4007719-13-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x435.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

T24gOS8xMC8yNCAwNzowNywgQWxleCBCZW5uw6llIHdyb3RlOg0KPiBUaGUgc29mdG1tdSBt
ZW1vcnkgaW5zdHJ1bWVudGF0aW9uIHRlc3Qgc2VlcyBzbyBtYW55IG1vcmUgYWNjZXNzZXMN
Cj4gdGhhbiBhIG5vcm1hbCB0cmFuc2xhdGVkIGhvc3QgYW5kIGl0cyByZWFsbHkgbm90IHdv
cnRoIGZpeGluZyB1cC4gTGV0cw0KPiBkZXByZWNhdGUgdGhpcyBvZGQgY29uZmlndXJhdGlv
biBhbmQgc2F2ZSBvbiB0aGUgQ0kgY3ljbGVzLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogQWxl
eCBCZW5uw6llIDxhbGV4LmJlbm5lZUBsaW5hcm8ub3JnPg0KPiAtLS0NCj4gICBkb2NzL2Fi
b3V0L2RlcHJlY2F0ZWQucnN0IHwgIDggKysrKysrKysNCj4gICBjb25maWd1cmUgICAgICAg
ICAgICAgICAgIHwgMTEgKysrKysrKysrLS0NCj4gICAyIGZpbGVzIGNoYW5nZWQsIDE3IGlu
c2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZG9jcy9h
Ym91dC9kZXByZWNhdGVkLnJzdCBiL2RvY3MvYWJvdXQvZGVwcmVjYXRlZC5yc3QNCj4gaW5k
ZXggZjdjN2MzM2QzOS4uNWFhMmUzNTMxNCAxMDA2NDQNCj4gLS0tIGEvZG9jcy9hYm91dC9k
ZXByZWNhdGVkLnJzdA0KPiArKysgYi9kb2NzL2Fib3V0L2RlcHJlY2F0ZWQucnN0DQo+IEBA
IC0xOTYsNiArMTk2LDE0IEBAIGJlbmVmaXRzIGZyb20gaGF2aW5nIHBsZW50eSBvZiBob3N0
IG1lbW9yeSBpdCBzZWVtcyByZWFzb25hYmxlIHRvDQo+ICAgZW5jb3VyYWdlIHVzZXJzIHRv
IHVzZSA2NCBiaXQgYnVpbGRzIG9mIFFFTVUgZm9yIGFuYWx5c2lzIHdvcmsNCj4gICB3aGF0
ZXZlciB0YXJnZXRzIHRoZXkgYXJlIGluc3RydW1lbnRpbmcuDQo+ICAgDQo+ICtUQ0cgUGx1
Z2luIHN1cHBvcnQgbm90IGVuYWJsZWQgYnkgZGVmYXVsdCB3aXRoIFRDSSAoc2luY2UgOS4y
KQ0KPiArJycnJycnJycnJycnJycnJycnJycnJycnJycnJycnJycnJycnJycnJycnJycnJycn
JycnJycnJycnJycnJycNCj4gKw0KPiArV2hpbGUgdGhlIFRDRyBpbnRlcnByZXRlciBjYW4g
aW50ZXJwcmV0IHRoZSBUQ0cgb3BzIHVzZWQgYnkgcGx1Z2lucyBpdA0KPiAraXMgZ29pbmcg
dG8gYmUgc28gbXVjaCBzbG93ZXIgaXQgd291bGRuJ3QgbWFrZSBzZW5zZSBmb3IgYW55IHNl
cmlvdXMNCj4gK2luc3RydW1lbnRhdGlvbi4gRHVlIHRvIGltcGxlbWVudGF0aW9uIGRpZmZl
cmVuY2VzIHRoZXJlIHdpbGwgYWxzbyBiZQ0KPiArYW5vbWFsaWVzIGluIHRoaW5ncyBsaWtl
IG1lbW9yeSBpbnN0cnVtZW50YXRpb24uDQo+ICsNCj4gICBTeXN0ZW0gZW11bGF0b3IgQ1BV
cw0KPiAgIC0tLS0tLS0tLS0tLS0tLS0tLS0tDQo+ICAgDQo+IGRpZmYgLS1naXQgYS9jb25m
aWd1cmUgYi9jb25maWd1cmUNCj4gaW5kZXggMTQ1ODFjMWI5YS4uMWJkYTZiM2EzYiAxMDA3
NTUNCj4gLS0tIGEvY29uZmlndXJlDQo+ICsrKyBiL2NvbmZpZ3VyZQ0KPiBAQCAtNjI5LDYg
KzYyOSw5IEBAIG1lc29uX29wdGlvbl9wYXJzZSgpIHsNCj4gICAgICAgZXhpdCAxDQo+ICAg
ICBmaQ0KPiAgIH0NCj4gK2hhc19tZXNvbl9vcHRpb24oKSB7DQo+ICsgICAgdGVzdCAiJHtt
ZXNvbl9vcHRpb25zIyoiJDEifSIgIT0gIiRtZXNvbl9vcHRpb25zIg0KPiArfQ0KPiAgIA0K
PiAgIG1lc29uX2FkZF9tYWNoaW5lX2ZpbGUoKSB7DQo+ICAgICBpZiB0ZXN0ICIkY3Jvc3Nf
Y29tcGlsZSIgPSAieWVzIjsgdGhlbg0KPiBAQCAtMTA0OCw4ICsxMDUxLDEyIEBAIGlmIHRl
c3QgIiRzdGF0aWMiID0gInllcyIgOyB0aGVuDQo+ICAgICBwbHVnaW5zPSJubyINCj4gICBm
aQ0KPiAgIGlmIHRlc3QgIiRwbHVnaW5zIiAhPSAibm8iICYmIHRlc3QgJGhvc3RfYml0cyAt
ZXEgNjQ7IHRoZW4NCj4gLSAgcGx1Z2lucz15ZXMNCj4gLSAgc3ViZGlycz0iJHN1YmRpcnMg
Y29udHJpYi9wbHVnaW5zIg0KPiArICAgIGlmIGhhc19tZXNvbl9vcHRpb24gIi1EdGNnX2lu
dGVycHJldGVyPXRydWUiOyB0aGVuDQo+ICsgICAgICAgIHBsdWdpbnM9Im5vIg0KPiArICAg
IGVsc2UNCj4gKyAgICAgICAgcGx1Z2lucz15ZXMNCj4gKyAgICAgICAgc3ViZGlycz0iJHN1
YmRpcnMgY29udHJpYi9wbHVnaW5zIg0KPiArICAgIGZpDQo+ICAgZmkNCj4gICANCj4gICBj
YXQgPiAkVE1QQyA8PCBFT0YNCg0KUmV2aWV3ZWQtYnk6IFBpZXJyaWNrIEJvdXZpZXIgPHBp
ZXJyaWNrLmJvdXZpZXJAbGluYXJvLm9yZz4NCg==

