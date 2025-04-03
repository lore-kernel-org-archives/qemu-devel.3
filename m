Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C76C5C3601A
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Apr 2025 18:23:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0PD8-0004LJ-VS; Thu, 03 Apr 2025 14:22:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u0PCx-0004Jn-M8
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 14:22:32 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u0PCu-0002Dn-JS
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 14:22:30 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-7376dd56f60so948301b3a.3
 for <qemu-devel@nongnu.org>; Thu, 03 Apr 2025 11:22:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743704546; x=1744309346; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=8Ir7/JHdNyExaAATw5WuR3k8dp564h4khHdSuzTycVI=;
 b=NclNRrI48j5hzUvDuiFK/4cjnyDkBnVKMF7uW2HbhZF+GYc0iHgJZOAmYbVPv1zepo
 AeIk01ve1EKj14CKWhi5gzKCeytNjC9TzIqBlbaeDfhPijgd+cvWVJdbYZZuFmz22Xqh
 IrB7bpXVP/CRIlBLeXWIqOTTKF2U7ptgBWwjDxfdzjzc+J6kPI+AoEj7NsmPZNZJvENL
 00MRaW1MK0mBh1i+UZzjvHxtB4FAoomRikL/osxGDAHqqUWX6BcU82+8FfHXSRWxTZJv
 x+yzioGsweZdKTUH6c/CDLrIW1jjcGVbWu3qpWZpBOid4m+264x7OA3oisvM/k3wAmcd
 JgFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743704546; x=1744309346;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8Ir7/JHdNyExaAATw5WuR3k8dp564h4khHdSuzTycVI=;
 b=tIjJ4qS0gOXvvlZJ+Cf1EAqbkUNJ/ewX9ZMHnE0kK/eNET9W5Iyn8rm7S3wrV50uq3
 xIXN+5egEOSjQeHWy6aCIypqXI89z2qhPQq86IE4vHXDaAbJR9Etg+EMGwcHttquhcdE
 8LzsYKK6hU7CGEou1UzDTV1bjakU3Zpp9sUE5ViT1JVDQYovtR0u78YIQhuynMm6vORk
 hpHge1xCTPHXjFCrm3qm6P/CmOomHdMZC+k/9KOxtDvhUIDTB4x+ep+0UN2j7mW7RWAu
 bHmrxhcHn1Hfb3cBo5RhiGK6uWAvb3aDaHj8KFx81BhDVUNJAvQJo1qJI/Un8r6IiOn4
 rEiw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUwXM4nLcUCsIUfc/eJhvwjeADcKwOQjM+QU8t4foetwzAU6o74nOpCCgBBKX3Bv32pL2eoxHSPdJvq@nongnu.org
X-Gm-Message-State: AOJu0YzJx3+Cya/0PbZZWkBMSFEXVD8cJoDsF7/22UeiI8zjhloLVkMN
 vqvp9Pot/2CO6eYFckN+3aZSQvPQLVR4hFwyxOHylLgT/MIkcXoMA0u8JR3rs58=
X-Gm-Gg: ASbGncsZRzFnDmMfHJv4kyCrCmvwt61peR50FH7JqLU+o8zIgvC9n8HXJP5O3oQm4X7
 48B0cjGs2HHF39NGoa0hIQv9R3HdDZQrnSsSVHWrZERF3E0btU2sNi740DHv2WPtQosTElsamBG
 X79YvEkSdIW3RzgjfC9AyeBHkR3yndiSBZOYkWH3pvVWQOTBlyvBB+Tyb+wPgxa6/GYEAXR5ZVS
 gv62lStDnfDFkf1JNuBnlosH4RoDNKYAvBwx+ctdG1wX8DAFhee4HsGIK0Ay0PACecayzrKzCVQ
 QCMVFRes8rhaAVxzmp+9/lT5fg1vOfpINBBpa9Z73H9jfMMQag9KDhaHR9lMC+AlBRwb
X-Google-Smtp-Source: AGHT+IGNP0LIVmiNdyAAojiN2WJ6TqKtTdPD6nigliJXjEehaf+13LaXKlU6kHH5W/1SBMZJjdhM2w==
X-Received: by 2002:a05:6a00:2e16:b0:736:69aa:112c with SMTP id
 d2e1a72fcca58-739e4b4d68amr591974b3a.9.1743704546590; 
 Thu, 03 Apr 2025 11:22:26 -0700 (PDT)
Received: from [192.168.1.87] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-739da0b3f5asm1863924b3a.131.2025.04.03.11.22.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Apr 2025 11:22:26 -0700 (PDT)
Message-ID: <cecbab0f-56f2-434a-8508-8a4df2992259@linaro.org>
Date: Thu, 3 Apr 2025 11:22:25 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-10.1 00/13] arm: Spring header cleanups
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
References: <20250402222334.66511-1-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250402222334.66511-1-philmd@linaro.org>
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

T24gNC8yLzI1IDE1OjIzLCBQaGlsaXBwZSBNYXRoaWV1LURhdWTDqSB3cm90ZToNCj4gVGhp
cyBzZXJpZXMgaXMgbW9yZSB1c2VmdWwgZm9yIGhldGVyb2dlbmVvdXMgZW11bGF0aW9uIHBy
ZXBhcmF0aW9uDQo+IHRoYW4gc2luZ2xlIGJpbmFyeSwgYmVjYXVzZSBpdCBhbGxvd3Mgbm9u
LUFSTSBody8gY29kZSB0byBjb25maWd1cmUNCj4gQVJNIGNvcmVzLCBzbyBub3QgdXNpbmcg
dGFyZ2V0LXNwZWNpZmljIEFQSXMuIEkgZmlndXJlZCBzb21lDQo+IHBhdGNoZXMgY291bGQg
YmUgdXNlZnVsIHRvIFBpZXJyaWNrICJidWlsZCBody9hcm0gb25jZSIgc2VyaWVzIChpbg0K
PiBwYXJ0aWN1bGFyIGFybV9jcHVfaGFzX2ZlYXR1cmUpLg0KPiANCg0KSSdtIG9rIHdpdGgg
dGhlIGNsZWFudXAgcGFydCwgYXMgSSBzZW50IGEgcmV2aWV3ZWQtYnkuDQoNCkhvd2V2ZXIs
IEknbSBub3Qgc3VyZSBpbiB3aGljaCBjb250ZXh0IG5vbi1BUk0gaHcvIGNvZGUgd2lsbCBy
ZWFsbHkgbmVlZCANCnRvIGRvIGl0LiBJdCB3b3VsZCBiZSBiZXR0ZXIgaWYgd2Ugc3RpY2sg
dG8gbWFuZGF0b3J5IGNoYW5nZXMgZm9yIG5vdywgDQppbnN0ZWFkIG9mIGFudGljaXBhdGlu
ZyBmdXR1cmUgbmVlZHMsIHdoaWNoIG1pZ2h0IGJlIHJlYWwgb3Igbm90Lg0KV2UgY2FuIGlt
cGxlbWVudCB0aG9zZSBjaGFuZ2VzIG9ubHkgYXMgcGFydCBvZiBhIHNlcmllcyB0aGF0IHJl
YWxseSANCm5lZWRzIGl0Lg0K

