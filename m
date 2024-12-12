Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90CFAE77182
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2024 19:20:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLoj7-0006sH-UY; Thu, 12 Dec 2024 14:19:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tLoj6-0006s2-AL
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 14:19:56 -0500
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tLoj4-0004OH-PS
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 14:19:56 -0500
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-2ee51c5f000so671811a91.0
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2024 11:19:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734031193; x=1734635993; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=y86wEqtqWxEjOjnMqoG9nPd//mSN+0eB43K1ELy+eN0=;
 b=BsheiRl6w92vzNU+1IpUbnVwbRMd5W57JZvtLx4KLg8OxlHuIzMBhB2Nn18AinAHnE
 j4XJi7L+6fPJdaCu4nB3OBp8gBr7cp91UJ2M24mvmxr6k/dc43MuyxsOKwTl7eAFKWD2
 ncLM1zwuzToccyvDvywT9wTzUtwGazQ9OTjnfopVgdBb8tXwWg8gNKXKPydiTnibr4Kj
 E2/ULeXzwzZcDJbNC5CiUbXz+IAUMxKfSzRt44KJt+q5nbB2SHwXBfzcbLInwtYfFlSQ
 0i43K67dFJ9wQNPzt6lQPvXQuZEX1leJi37bQfu8cpFCgg4M1Dte8Ssb04tm+86wHxua
 XwHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734031193; x=1734635993;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=y86wEqtqWxEjOjnMqoG9nPd//mSN+0eB43K1ELy+eN0=;
 b=Vn9GqGsmbmdJdxBVmmAjCx8/h/MplVBuuIxeYQ7glo8sUEoisdnMsIkyeZCGO1AFtR
 SkFVJZUZmgRRL/BrS/IRqebwxBw/cXjZxi9ixVut3ekxbL7H9G1vxMtvc9ivDQv8ocqg
 CalXOOkzvqatN96RHR85ZlfqG7T6ni8eBdBoT9zNC+k9PufgF23oTICNz69KsHFkzv6t
 jEnZBJAnulKi8W5vVwMeG1sUqeHAMg01t8PU76oxQiWpHF5WhO/ZXSbFzZlAn5jUKQkL
 AfFiC5tq4Zo7WPOdfCiMnPFeZkk/sfyWf+NAlCZAdS0M8drtDTTSKiSeWjJCaVsml1LH
 jCPw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXNWelNj4q4Dp5J64tK3an7G2FqtMYN9Pkd3AJv/EjzdZ0QBRQNogaMBG60eBK6DnT4xCqcX+5Ti/qz@nongnu.org
X-Gm-Message-State: AOJu0YzLRY0BDe15QpyuholhDmIAvzQC1PHV7SFTT3BYCT8dR5zeL5Rr
 sc5PJ0dHRXUrHOOF9EsV1Z5cc1NrT0BysdZFchSMxVPT7DrvAhEOA+CO/WGbllQ=
X-Gm-Gg: ASbGncv3vSlPPuc3aA2oWgxh00jpUbt4gexv4FH+DCVff1dTwi3KDu81OiGkUlOzSmP
 FrMgEDGJANk754MHPPvG5iKEOTVy6kCxPCbzZzWx1xaO/N/2xlXbawLdPMUwrqR/LDtMDYWnEAr
 sufg18hbW3lkfP5SBfEYY5B+WPht4GdyXw+QJIUKg6rIDUZYYGPuvRtf6f2Pwx5bsm+cyiMJioZ
 ipDU0mo93t5uSBaFpIzB4GdslthFK69bG6y7/KWVhI6CXX1+YPbKAM+uDynA7vNIF6zmi1+Dhrp
 Ec0UWyJB7dWDEH4x1Xj9M10qfvMl
X-Google-Smtp-Source: AGHT+IES04z0rRTATdfvQxpDSGAep5hMEOGylnvEDxXvQTfpC0oEjLv9YmSS6W7NTfFw/Dds3DOfig==
X-Received: by 2002:a17:90b:1d47:b0:2ee:45fd:34ee with SMTP id
 98e67ed59e1d1-2f1280586f9mr12571897a91.37.1734031192788; 
 Thu, 12 Dec 2024 11:19:52 -0800 (PST)
Received: from [192.168.1.67] (216-180-64-156.dyn.novuscom.net.
 [216.180.64.156]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2f142d90ba5sm1655528a91.1.2024.12.12.11.19.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 12 Dec 2024 11:19:52 -0800 (PST)
Message-ID: <722dd697-51ab-46df-8ebb-acc5679c5966@linaro.org>
Date: Thu, 12 Dec 2024 11:19:50 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/18] linux-user/aarch64: Include missing
 'user/abitypes.h' header
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
References: <20241212185341.2857-1-philmd@linaro.org>
 <20241212185341.2857-3-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20241212185341.2857-3-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::1034;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x1034.google.com
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

T24gMTIvMTIvMjQgMTA6NTMsIFBoaWxpcHBlIE1hdGhpZXUtRGF1ZMOpIHdyb3RlOg0KPiBh
cm1fc2V0X210ZV90Y2YwKCkgdXNlcyB0aGUgYWJpX2xvbmcgdHlwZSB3aGljaCBpcyBkZWZp
bmVkDQo+IGluICJ1c2VyL2FiaXR5cGVzLmgiLiBJbmNsdWRlIGl0IGluIG9yZGVyIHRvIGF2
b2lkIHdoZW4NCj4gcmVmYWN0b3Jpbmc6DQo+IA0KPiAgICBJbiBmaWxlIGluY2x1ZGVkIGZy
b20gLi4vLi4vdGFyZ2V0L2FybS9nZGJzdHViNjQuYzoyODoNCj4gICAgLi4vbGludXgtdXNl
ci9hYXJjaDY0L210ZV91c2VyX2hlbHBlci5oOjMwOjQyOiBlcnJvcjogdW5rbm93biB0eXBl
IG5hbWUg4oCYYWJpX2xvbmfigJk7IGRpZCB5b3UgbWVhbiDigJh1X2xvbmfigJk/DQo+ICAg
ICAgIDMwIHwgdm9pZCBhcm1fc2V0X210ZV90Y2YwKENQVUFyY2hTdGF0ZSAqZW52LCBhYmlf
bG9uZyB2YWx1ZSk7DQo+ICAgICAgICAgIHwgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICBefn5+fn5+fg0KPiANCj4gU2lnbmVkLW9mZi1ieTogUGhpbGlwcGUg
TWF0aGlldS1EYXVkw6kgPHBoaWxtZEBsaW5hcm8ub3JnPg0KPiAtLS0NCj4gICBsaW51eC11
c2VyL2FhcmNoNjQvbXRlX3VzZXJfaGVscGVyLmggfCAyICsrDQo+ICAgMSBmaWxlIGNoYW5n
ZWQsIDIgaW5zZXJ0aW9ucygrKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2xpbnV4LXVzZXIvYWFy
Y2g2NC9tdGVfdXNlcl9oZWxwZXIuaCBiL2xpbnV4LXVzZXIvYWFyY2g2NC9tdGVfdXNlcl9o
ZWxwZXIuaA0KPiBpbmRleCA4Njg1ZTUxNzVhMi4uMGM1M2FiZGEyMjIgMTAwNjQ0DQo+IC0t
LSBhL2xpbnV4LXVzZXIvYWFyY2g2NC9tdGVfdXNlcl9oZWxwZXIuaA0KPiArKysgYi9saW51
eC11c2VyL2FhcmNoNjQvbXRlX3VzZXJfaGVscGVyLmgNCj4gQEAgLTksNiArOSw4IEBADQo+
ICAgI2lmbmRlZiBBQVJDSDY0X01URV9VU0VSX0hFTFBFUl9IDQo+ICAgI2RlZmluZSBBQVJD
SDY0X01URSBVU0VSX0hFTFBFUl9IDQo+ICAgDQo+ICsjaW5jbHVkZSAidXNlci9hYml0eXBl
cy5oIg0KPiArDQo+ICAgI2lmbmRlZiBQUl9NVEVfVENGX1NISUZUDQo+ICAgIyBkZWZpbmUg
UFJfTVRFX1RDRl9TSElGVCAgICAgICAxDQo+ICAgIyBkZWZpbmUgUFJfTVRFX1RDRl9OT05F
ICAgICAgICAoMFVMIDw8IFBSX01URV9UQ0ZfU0hJRlQpDQoNClJldmlld2VkLWJ5OiBQaWVy
cmljayBCb3V2aWVyIDxwaWVycmljay5ib3V2aWVyQGxpbmFyby5vcmc+DQoNCg==

