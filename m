Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46F37C369AB
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Apr 2025 04:03:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u5cvh-0000HO-0Q; Fri, 18 Apr 2025 00:02:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u5cve-0000H6-MX
 for qemu-devel@nongnu.org; Fri, 18 Apr 2025 00:02:15 -0400
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u5cvc-0008Hl-HE
 for qemu-devel@nongnu.org; Fri, 18 Apr 2025 00:02:14 -0400
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-af50f56b862so1106629a12.1
 for <qemu-devel@nongnu.org>; Thu, 17 Apr 2025 21:02:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744948930; x=1745553730; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=oXpIehn+NJXHP7Utv2xLgu3wTqcsgNSCuLg+wpwUWoQ=;
 b=mdhcBpnS1RFlgI3aX7orDjRGxerPGh6WX4zV0ttyIKBA+7C0cvOl0bP81QeFfg3lsn
 XKtMUOL+wsQlCeH7O/bANA/DxL3hrCmT3uPJPnK5+udTz/+Au4zaB2x+mmwXwbOrJcP0
 ABVw8kmvOEbE21OWVjn7keS0L1xHoM486j6GpHaww4kK+MIwFM0cXrDOe+RO/o7I/Q/b
 ue77xpwaz8A4WDQNj0n1DvF4K4Fu6IIkdSrvHApf/i1PDdjL5pALqKEKUs2/awmVPS5k
 koY7AN+Ue2x9q+/0OvJwJM1SJ0TbLxD91OLqbvTPaDs0elDvo/XyHcoEzh3vvC1xlmCM
 g0sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744948930; x=1745553730;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=oXpIehn+NJXHP7Utv2xLgu3wTqcsgNSCuLg+wpwUWoQ=;
 b=iJJtniERGUF6uN69ZVdkMVb8EPrX5WbA+JtKI2O9ncUu6mGFkC+sk1Chx7F6AfR8Td
 sUViZhNGWaIACMFp8dUPfAdsG5LeXoA7azmXvPvRXfmkNSrwvgLKvhk5ituZNMwPXz4Y
 OjRPvFWF2l1044WQqqRs92F1YrBc4RmjqYDJvsG+fv8nlYYtWZ+QRmZgo/dDjD02uSuZ
 uWpRG7ZHBl0uZcWVJQ8xXWXYHaTeOsqYUodjgwQYxFv6wTO72IIYJYYkV7odsmgsny9G
 Z8nzwbPpwth3+WjvUWAW5fbU8nPNDyLSlE5h5jPF4AgGo5wALM6O6QtKgj2PEbGQZOei
 fBNQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVBewXrfQI8Dfo5fSA6emOMJV3Q38c0sgsN6TNq4Jnk1Q2GArHpK0u21UODsoN3wxM1L8T326D5CD3/@nongnu.org
X-Gm-Message-State: AOJu0YyIwIVvzDBZoZQtNLAmA/loW5TRWSDu/jrT1tkb5Aac6wKopk4Y
 cT91QSCjibqMGWE8Az10svc91/VJSruOaVcYuwyOvuy2RiI56FkdrD+dqV0mfwY=
X-Gm-Gg: ASbGnctD/i8JtGbj5YUlUVIXwFnfPnf+llKueX2mxDW0g+2HXGH2zoL5Pqz4RJgLCCP
 avX0c4pWQp+2Sc+WSk5q8jyb1N4BjdahAPLrX/K/HZ1WIyFqMiI88YmqGyDQak28nPd6kViajBM
 DwlDbTvBbxkqBvH4Dp8rjKIANkCgx8a42z8KuQA3i+4OgBaeRBKqc2ay7Xm965bM8sdBAZVJop9
 IFD3IGC54UWmzOicpr4E20id7xdnte7D76PK4TRWA6PgYDHCzMqSSBWZTfe6RsKmbthZ3ocE45i
 wPu1/V9Z2Avd+iz13M7Zd61q64prWhO08pqHW3fLdzI/ghThCemJnQ==
X-Google-Smtp-Source: AGHT+IFyg5MFze8gjVcl0fcsMBhaAeGrh0VtITjUcxW1Hi/n2nLq6xeZZFSnZ+hNJ18SvIG1xNPg3Q==
X-Received: by 2002:a17:90b:2dc6:b0:306:b6f7:58ba with SMTP id
 98e67ed59e1d1-3087bb3e77cmr1882333a91.6.1744948930069; 
 Thu, 17 Apr 2025 21:02:10 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3087dee889csm288752a91.2.2025.04.17.21.02.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 17 Apr 2025 21:02:09 -0700 (PDT)
Message-ID: <7bcc10f7-43b5-48f4-8546-3169e2be4fcd@linaro.org>
Date: Thu, 17 Apr 2025 21:02:09 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 08/11] config/target: Implement per-binary
 TargetInfo structure (ARM)
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20250418005059.4436-1-philmd@linaro.org>
 <20250418005059.4436-9-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250418005059.4436-9-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::52d;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x52d.google.com
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

T24gNC8xNy8yNSAxNzo1MCwgUGhpbGlwcGUgTWF0aGlldS1EYXVkw6kgd3JvdGU6DQo+IElm
IGEgZmlsZSBkZWZpbmluZyB0aGUgYmluYXJ5IFRhcmdldEluZm8gc3RydWN0dXJlIGlzIGF2
YWlsYWJsZSwNCj4gbGluayB3aXRoIGl0LiBPdGhlcndpc2Uga2VlcCB1c2luZyB0aGUgc3R1
Yi4gSW1wbGVtZW50IHN1Y2gNCj4gc3RydWN0dXJlIGZvciBhcm0tc29mdG1tdS4NCj4gDQo+
IFNpZ25lZC1vZmYtYnk6IFBoaWxpcHBlIE1hdGhpZXUtRGF1ZMOpIDxwaGlsbWRAbGluYXJv
Lm9yZz4NCj4gLS0tDQo+ICAgbWVzb24uYnVpbGQgICAgICAgICAgICAgICAgICAgfCAgNyAr
KysrKystDQo+ICAgY29uZmlncy90YXJnZXRzL2FybS1zb2Z0bW11LmMgfCAyMiArKysrKysr
KysrKysrKysrKysrKysrDQo+ICAgMiBmaWxlcyBjaGFuZ2VkLCAyOCBpbnNlcnRpb25zKCsp
LCAxIGRlbGV0aW9uKC0pDQo+ICAgY3JlYXRlIG1vZGUgMTAwNjQ0IGNvbmZpZ3MvdGFyZ2V0
cy9hcm0tc29mdG1tdS5jDQo+IA0KPiBkaWZmIC0tZ2l0IGEvbWVzb24uYnVpbGQgYi9tZXNv
bi5idWlsZA0KPiBpbmRleCAxNjhiMDdiNTg4Ny4uZGEyNGNjMmJhNDEgMTAwNjQ0DQo+IC0t
LSBhL21lc29uLmJ1aWxkDQo+ICsrKyBiL21lc29uLmJ1aWxkDQo+IEBAIC0zODA5LDcgKzM4
MDksNiBAQCBzcGVjaWZpY19zcy5hZGQoZmlsZXMoJ3BhZ2UtdGFyZ2V0LmMnLCAncGFnZS12
YXJ5LXRhcmdldC5jJykpDQo+ICAgDQo+ICAgY29tbW9uX3NzLmFkZChmaWxlcygndGFyZ2V0
X2luZm8uYycpKQ0KPiAgIHN5c3RlbV9zcy5hZGQoZmlsZXMoJ3RhcmdldF9pbmZvLXFvbS5j
JykpDQo+IC1zcGVjaWZpY19zcy5hZGQoZmlsZXMoJ3RhcmdldF9pbmZvLXN0dWIuYycpKQ0K
PiAgIA0KPiAgIHN1YmRpcignYmFja2VuZHMnKQ0KPiAgIHN1YmRpcignZGlzYXMnKQ0KPiBA
QCAtNDI3Miw2ICs0MjcxLDEyIEBAIGZvcmVhY2ggdGFyZ2V0IDogdGFyZ2V0X2RpcnMNCj4g
ICAgICAgYXJjaF9zcmNzICs9IGdkYnN0dWJfeG1sDQo+ICAgICBlbmRpZg0KPiAgIA0KPiAr
ICB0YXJnZXRfaW5mb19jID0gbWVzb24ucHJvamVjdF9zb3VyY2Vfcm9vdCgpIC8gJ2NvbmZp
Z3MnIC8gJ3RhcmdldHMnIC8gdGFyZ2V0ICsgJy5jJw0KPiArICBpZiBub3QgZnMuZXhpc3Rz
KHRhcmdldF9pbmZvX2MpDQo+ICsgICAgdGFyZ2V0X2luZm9fYyA9IG1lc29uLnByb2plY3Rf
c291cmNlX3Jvb3QoKSAvICd0YXJnZXRfaW5mby1zdHViLmMnDQo+ICsgIGVuZGlmDQo+ICsg
IGFyY2hfc3JjcyArPSB0YXJnZXRfaW5mb19jDQo+ICsNCj4gICAgIHQgPSB0YXJnZXRfYXJj
aFt0YXJnZXRfYmFzZV9hcmNoXS5hcHBseShjb25maWdfdGFyZ2V0LCBzdHJpY3Q6IGZhbHNl
KQ0KPiAgICAgYXJjaF9zcmNzICs9IHQuc291cmNlcygpDQo+ICAgICBhcmNoX2RlcHMgKz0g
dC5kZXBlbmRlbmNpZXMoKQ0KDQpXaGlsZSB0aGlzIHdvcmtzLCBpdCB3b3VsZCBiZSBiZXR0
ZXIgd2l0aCBhIGRpY3Rpb25hcnksIHNvIGl0IGZvbGxvd3MgDQp0aGUgc3R5bGUgb2YgZXhp
c3RpbmcgbWVzb24uYnVpbGQuDQoNCkFzIHdlbGwsIHR3byBhZHZhbnRhZ2VzOg0KLSB3ZSBj
YW4gbW92ZSBjb25maWdzIHNvbWV3aGVyZSBlbHNlIGluIGNhc2Ugd2UgZGVjaWRlIHRvIHNw
bGl0IHRoZW0gaW4gDQpldmVyeSBmb2xkZXIgbGF0ZXINCi0gV2UgYXZvaWQgY2FsbGluZyBm
cy5leGlzdHMgZm9yIGV2ZXJ5IHRhcmdldCwgYnV0IGl0IHNob3VsZCBub3QgcmVhbGx5IA0K
Y2hhbmdlIGFueXRoaW5nIHRvIGNvbmZpZ3VyZSBzdGVwIHRpbWUuDQoNCi0tLQ0KDQpkaWZm
IC0tZ2l0IGEvbWVzb24uYnVpbGQgYi9tZXNvbi5idWlsZA0KaW5kZXggODFhZmE2Mzg1M2Uu
LjdmY2EzYzVjNGRjIDEwMDY0NA0KLS0tIGEvbWVzb24uYnVpbGQNCisrKyBiL21lc29uLmJ1
aWxkDQpAQCAtMzIyOCw2ICszMjI4LDcgQEAgY29uZmlnX2RldmljZXNfbWFrX2xpc3QgPSBb
XQ0KICBjb25maWdfZGV2aWNlc19oID0ge30NCiAgY29uZmlnX3RhcmdldF9oID0ge30NCiAg
Y29uZmlnX3RhcmdldF9tYWsgPSB7fQ0KK3RhcmdldF9pbmZvID0ge30NCg0KICBkaXNhc3Nl
bWJsZXJzID0gew0KICAgICdhbHBoYScgOiBbJ0NPTkZJR19BTFBIQV9ESVMnXSwNCkBAIC0z
ODIzLDkgKzM4MjQsOSBAQCBzcGVjaWZpY19zcy5hZGQoZmlsZXMoJ3BhZ2UtdGFyZ2V0LmMn
LCANCidwYWdlLXZhcnktdGFyZ2V0LmMnKSkNCg0KICBjb21tb25fc3MuYWRkKGZpbGVzKCd0
YXJnZXRfaW5mby5jJykpDQogIHN5c3RlbV9zcy5hZGQoZmlsZXMoJ3RhcmdldF9pbmZvLXFv
bS5jJykpDQotc3BlY2lmaWNfc3MuYWRkKGZpbGVzKCd0YXJnZXRfaW5mby1zdHViLmMnKSkN
Cg0KICBzdWJkaXIoJ2JhY2tlbmRzJykNCitzdWJkaXIoJ2NvbmZpZ3MvdGFyZ2V0cycpDQog
IHN1YmRpcignZGlzYXMnKQ0KICBzdWJkaXIoJ21pZ3JhdGlvbicpDQogIHN1YmRpcignbW9u
aXRvcicpDQpAQCAtNDI4Niw2ICs0Mjg3LDEyIEBAIGZvcmVhY2ggdGFyZ2V0IDogdGFyZ2V0
X2RpcnMNCiAgICAgIGFyY2hfc3JjcyArPSBnZGJzdHViX3htbA0KICAgIGVuZGlmDQoNCisg
IGlmIHRhcmdldCBpbiB0YXJnZXRfaW5mbw0KKyAgICBhcmNoX3NyY3MgKz0gdGFyZ2V0X2lu
Zm9bdGFyZ2V0XQ0KKyAgZWxzZQ0KKyAgICBhcmNoX3NyY3MgKz0gZmlsZXMoJ3RhcmdldF9p
bmZvLXN0dWIuYycpDQorICBlbmRpZg0KKw0KICAgIHQgPSB0YXJnZXRfYXJjaFt0YXJnZXRf
YmFzZV9hcmNoXS5hcHBseShjb25maWdfdGFyZ2V0LCBzdHJpY3Q6IGZhbHNlKQ0KICAgIGFy
Y2hfc3JjcyArPSB0LnNvdXJjZXMoKQ0KICAgIGFyY2hfZGVwcyArPSB0LmRlcGVuZGVuY2ll
cygpDQoNCmRpZmYgLS1naXQgYS9jb25maWdzL3RhcmdldHMvbWVzb24uYnVpbGQgYi9jb25m
aWdzL3RhcmdldHMvbWVzb24uYnVpbGQNCm5ldyBmaWxlIG1vZGUgMTAwNjQ0DQppbmRleCAw
MDAwMDAwMDAwMC4uMTQwMzg2ZTkzMmMNCi0tLSAvZGV2L251bGwNCisrKyBiL2NvbmZpZ3Mv
dGFyZ2V0cy9tZXNvbi5idWlsZA0KQEAgLTAsMCArMSwzIEBADQorZm9yZWFjaCB0YXJnZXQg
OiBbJ2FybS1zb2Z0bW11JywgJ2FhcmNoNjQtc29mdG1tdSddDQorICB0YXJnZXRfaW5mbyAr
PSB7dGFyZ2V0IDogZmlsZXModGFyZ2V0ICsgJy5jJyl9DQorZW5kZm9yZWFjaA0KDQo=

