Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4954C36002
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Mar 2025 20:54:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1twonK-00081r-5n; Mon, 24 Mar 2025 16:53:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1twonJ-00081h-3y
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 16:53:13 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1twonH-0000np-2W
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 16:53:12 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-227c7e57da2so23938255ad.0
 for <qemu-devel@nongnu.org>; Mon, 24 Mar 2025 13:53:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742849589; x=1743454389; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=AHlhz+pUBpBNXnEnIPgbLnZ23IalJRJ/shcQXXoWGOs=;
 b=GfRbxro11rsQpHEIwPa8/91LW4ZMr+mPUP/hCMYIVMoHAnLX4jwmtyZXw80ROQa8ZE
 X4uxUDJLiL4AHJAhjt49POhKZVEgG0pQ3TTpjCgn6EOLUGF8Zevx/AVud9LlrQwiPrrn
 3EETIRA9k7FChOy3i4OSxaweis1lWSUmKga4PAw6cjgoCYUeTTy5Iotc9L7o9QW/C1Ty
 YkYbkEPLdBq/WwLdrg0r1oUHAioINtMR0QlogmpSKr6aFpu53EV4tvJeziaVpUZqMfeC
 tvR+vIaXmIQMU0r+zqGGqcuiRJ2izdc2+v1Kfx83hkxG3msLi0ZiRMmUte0H1mq/rmWw
 WKgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742849589; x=1743454389;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=AHlhz+pUBpBNXnEnIPgbLnZ23IalJRJ/shcQXXoWGOs=;
 b=CSiuHli9vivHpphYwZkORgDhPutjxoMjnv+MoCb9I9vp4xZSadvFWjtaA507mN1RCU
 COl6fIGJ7uTigWCqFtzztEd+cR4XwjNh2lYQlIc7raoBF+uvvjTyaEPlxyA5tB1DXqLy
 gpSVhHn8BRv+5SRsOouH+gNMMuZRX99xMCQY2BsNc9s59WlGNb5ttqCsn3/zQfVKVuQ9
 wZ2XmjB9ngwZR2Tq5pSnpkSznNtgAGnS53sjpVzTc6aPSF+c7k4apb8d39pqP9ZAt16c
 wX+ubGszMCkZVCY+Q/Noq5IF7IS8mSpmIABJ1WIsabVpKgc8WPbIaoPxJsGbQbfCFOGe
 eSTA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVZ+BWrFOVIe25/180JqY54StLh0h3Z2xn3wSHtPyfQk+60xeJ4oLtkZV8UNe/iKeUSC0r0fSnWmqNm@nongnu.org
X-Gm-Message-State: AOJu0Yzo+A052vxi/xEZEbpOuTxmtR47VMVhBtouceNOMhuOCRIDe1C0
 JPFXt4c1WLpFdylmfKGePWKrBfmekQjSRcu3ptgHWnzqmK6jB9M5JLAjE7wsUfQ=
X-Gm-Gg: ASbGncvVYhWobvdRS94nGhMnHq/umDsTb6tVrMToTyJ7+2e0FjgQ25ksCzKRmseIok/
 zt1ZEjaIX5ivLrPGIPc6MIs27jSyZxUO0aCY0ttbhe0v+pWsMADc8hVOdsPh+q5kHenle5twgeM
 RSxQ3BlziY4+JAQcrA/UimLKwT4ittiEk6rnz7YQPe3Uw6TzGjBH/AgcRcA6t2Qq7NNyse7MrXb
 QiK2Ey0pHoLCi6MQ7EEy7jSFNh+MGOqYQW0FlXwEwy+rJoLyiUb+Zyd9vb+/1SXu11gglW2/Gjd
 Bfc4q6Y6hGiknwmj1UJsqTQRxdf6E8Y218VFWDAqoNfNx51V2mGPzmluEg==
X-Google-Smtp-Source: AGHT+IHD9soOxoHn/Wk+49y9X/QFKqSHWYMf+NWFqhGgXZdCdjbYPR+ADI/SgwR06VyELgvysCPMeg==
X-Received: by 2002:a17:902:d48a:b0:223:2cae:4a96 with SMTP id
 d9443c01a7336-22780e3fb29mr170472105ad.42.1742849589109; 
 Mon, 24 Mar 2025 13:53:09 -0700 (PDT)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3030f5b7886sm8682190a91.6.2025.03.24.13.53.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 24 Mar 2025 13:53:08 -0700 (PDT)
Message-ID: <4987c982-7786-43e4-bc68-0581cd234960@linaro.org>
Date: Mon, 24 Mar 2025 13:53:07 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-10.1 1/3] target/mips: Inline qemu_get_betls() and
 qemu_put_betls()
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
 <20250323225047.35419-2-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250323225047.35419-2-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62f.google.com
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
IG9ubHkgdXNlIHFlbXVfZ2V0X2JldGxzKCkgYW5kIHFlbXVfcHV0X2JldGxzKCkgb25jZSBp
bg0KPiB0aGUgd2hvbGUgY29kZSBiYXNlLiBJbmxpbmUgdGhlbSAoY2hlY2tpbmcgVEFSR0VU
X01JUFM2NA0KPiBpbnN0ZWFkIG9mIFRBUkdFVF9MT05HX0JJVFMgPT0gNjQpIHNvIHdlIGNh
biByZW1vdmUgdGhlbQ0KPiBsYXRlciBhcyB1bnVzZWQuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5
OiBQaGlsaXBwZSBNYXRoaWV1LURhdWTDqSA8cGhpbG1kQGxpbmFyby5vcmc+DQo+IC0tLQ0K
PiAgIHRhcmdldC9taXBzL3N5c3RlbS9tYWNoaW5lLmMgfCAxMiArKysrKysrKysrLS0NCj4g
ICAxIGZpbGUgY2hhbmdlZCwgMTAgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4g
DQo+IGRpZmYgLS1naXQgYS90YXJnZXQvbWlwcy9zeXN0ZW0vbWFjaGluZS5jIGIvdGFyZ2V0
L21pcHMvc3lzdGVtL21hY2hpbmUuYw0KPiBpbmRleCA4YWYxMWZkODk2Yi4uYzRjOTJhOWEx
Y2EgMTAwNjQ0DQo+IC0tLSBhL3RhcmdldC9taXBzL3N5c3RlbS9tYWNoaW5lLmMNCj4gKysr
IGIvdGFyZ2V0L21pcHMvc3lzdGVtL21hY2hpbmUuYw0KPiBAQCAtMTM5LDcgKzEzOSwxMSBA
QCBzdGF0aWMgaW50IGdldF90bGIoUUVNVUZpbGUgKmYsIHZvaWQgKnB2LCBzaXplX3Qgc2l6
ZSwNCj4gICAgICAgcjRrX3RsYl90ICp2ID0gcHY7DQo+ICAgICAgIHVpbnQxNl90IGZsYWdz
Ow0KPiAgIA0KPiAtICAgIHFlbXVfZ2V0X2JldGxzKGYsICZ2LT5WUE4pOw0KPiArI2lmZGVm
IFRBUkdFVF9NSVBTNjQNCj4gKyAgICBxZW11X2dldF9iZTY0cyhmLCAmdi0+VlBOKTsNCj4g
KyNlbHNlDQo+ICsgICAgcWVtdV9nZXRfYmUzMnMoZiwgJnYtPlZQTik7DQo+ICsjZW5kaWYN
Cj4gICAgICAgcWVtdV9nZXRfYmUzMnMoZiwgJnYtPlBhZ2VNYXNrKTsNCj4gICAgICAgcWVt
dV9nZXRfYmUxNnMoZiwgJnYtPkFTSUQpOw0KPiAgICAgICBxZW11X2dldF9iZTMycyhmLCAm
di0+TU1JRCk7DQo+IEBAIC0xODIsNyArMTg2LDExIEBAIHN0YXRpYyBpbnQgcHV0X3RsYihR
RU1VRmlsZSAqZiwgdm9pZCAqcHYsIHNpemVfdCBzaXplLA0KPiAgICAgICAgICAgICAgICAg
ICAgICAgICAodi0+RDAgPDwgMSkgfA0KPiAgICAgICAgICAgICAgICAgICAgICAgICAodi0+
RDEgPDwgMCkpOw0KPiAgIA0KPiAtICAgIHFlbXVfcHV0X2JldGxzKGYsICZ2LT5WUE4pOw0K
PiArI2lmZGVmIFRBUkdFVF9NSVBTNjQNCj4gKyAgICBxZW11X3B1dF9iZTY0cyhmLCAmdi0+
VlBOKTsNCj4gKyNlbHNlDQo+ICsgICAgcWVtdV9wdXRfYmUzMnMoZiwgJnYtPlZQTik7DQo+
ICsjZW5kaWYNCj4gICAgICAgcWVtdV9wdXRfYmUzMnMoZiwgJnYtPlBhZ2VNYXNrKTsNCj4g
ICAgICAgcWVtdV9wdXRfYmUxNnMoZiwgJmFzaWQpOw0KPiAgICAgICBxZW11X3B1dF9iZTMy
cyhmLCAmbW1pZCk7DQoNClJldmlld2VkLWJ5OiBQaWVycmljayBCb3V2aWVyIDxwaWVycmlj
ay5ib3V2aWVyQGxpbmFyby5vcmc+DQoNCg==

