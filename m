Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5836BC369C2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Apr 2025 18:25:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7IIg-0002Kt-9L; Tue, 22 Apr 2025 14:24:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u7IIc-0002Gx-N8
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 14:24:51 -0400
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u7IIZ-000196-US
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 14:24:49 -0400
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-3085f827538so6776714a91.0
 for <qemu-devel@nongnu.org>; Tue, 22 Apr 2025 11:24:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745346271; x=1745951071; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=yvWp/BzrosDLw26NoWDCt9mg0eAsQaBkAoOokggw3sg=;
 b=rzn3sh208dfT1jBuLC+AcqfVtjV3aoJpPyLrsIZG0Iz1rs+J1cY+qzi7Dwxpjv4JAX
 Hvk8O2v1m/AfNkwdX1i1QqI2pf+9eqTZjWbKpWZmy6vXilGghJaUyDmTO1sVUpC57yKM
 ElPQn9wK4sOO9DrvlInUjk/2BfWZZdjFhOTYny6VYdsO8ns968xupJtyryDc7E5YlaE+
 vQr/gIM7uAkPyi7XBeFQnx1Gygzni0UYmgMsZ2/h5AEC4hKo+ogNDPe8HLN7HvHOt3lG
 mamfXkvv86pgJI9CbpzonhAU1EaxJnnPKhbF9rD0nxAhwIBHkRurn2iNsdbeFPEL+YY6
 gbRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745346271; x=1745951071;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=yvWp/BzrosDLw26NoWDCt9mg0eAsQaBkAoOokggw3sg=;
 b=qOIwhnDeBmuRkiMqsKP15leFZu5GDKQJ0yPzh2Hfz61oyw0XWpi8aqYMFVsAYN5egD
 XrTfyNKAF1cKAEzKGyRNf7qi33bAml/hj4tZHLReXrjVL5QsUwsm5qGLZwNYe5LaQET9
 7wumjIWnV94cP1HOdbH/AXtOB8Bu42sxA848VUlM1UhPS7SXl+seAUKvQY6bSje57mYF
 VPRPAvWzUeuf1gy7bIkch4haYRhG/j6Mz32xZgroirkdUWWoINA+lG1vRHFwN96dHFo+
 dlLLFS+emxsAcaI3kJT5wCioflzKvRvjAvXy1JCTS2Q7/ker3miKlfALsACaKgQWVYfW
 JGig==
X-Forwarded-Encrypted: i=1;
 AJvYcCV4np3DKxzlSGQogpmhYERYGAx6l8/9IBJP0H6qByTpYprUabUmhExbX1t9CYkBae/Nar/4/gw57zVO@nongnu.org
X-Gm-Message-State: AOJu0Yyd7WczLMryE1zF4a+hspyrk/eO6gyZSOvvNFE7mbs5HJ4w0eDC
 GHcwASnrG5QZK8aEhbu2wxI8/y0Ux1YU6wppJ9EXki7lpLVrnpw7HfQig++8CeU=
X-Gm-Gg: ASbGncspGWdfyi8t6egFqIgd5PAapsK1y1M80xOrjpJLqQY96BzwN8mezu+45oAQFn9
 AIsl7MumSeIFvhDgFA9Up9PcUZb1LmLH21hmZDuDZCWIx5HRkHLr4oFlu4kBHevBN5wFxXFoosH
 YUfTCbzQw9t5hj2v7ODYt85nzRjszF+SkBpp5d0OLFUI3/LWQMybMKsgBD60bl/Esa94utXhsPj
 gjF3I/zQ7m8s6Lr2zTkEf8rdXKp85/QtmdyiEbeH/Pyw4VefnnvIi6Sz1Gz2RPD5uoT4/6FBFmL
 DhDosZoI4L5uxyOZzNayZe2rayVquztt/WVb1mQY/iMnoR/SxTn17Q==
X-Google-Smtp-Source: AGHT+IE7vpPWsrCLexBnYhVLCzut7Quc21zFCWwVwxtjWDXJ7ufBfaXCfJZJZseRTgKd7b8PcfT2UQ==
X-Received: by 2002:a17:90b:2e48:b0:2ff:6167:e92d with SMTP id
 98e67ed59e1d1-3087bbc8c4dmr20094754a91.32.1745346270697; 
 Tue, 22 Apr 2025 11:24:30 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3087dee864dsm9074555a91.6.2025.04.22.11.24.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Apr 2025 11:24:30 -0700 (PDT)
Message-ID: <f504ee34-59ab-4f9b-82be-0f6c7cb9ba60@linaro.org>
Date: Tue, 22 Apr 2025 11:24:29 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v4 18/19] hw/core: Introduce
 MachineClass::get_default_cpu_type() helper
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>
References: <20250422145502.70770-1-philmd@linaro.org>
 <20250422145502.70770-19-philmd@linaro.org>
 <f62780da-1f37-4646-9189-b8ae2876c360@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <f62780da-1f37-4646-9189-b8ae2876c360@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::102d;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x102d.google.com
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

T24gNC8yMi8yNSAxMDo1OSwgUmljaGFyZCBIZW5kZXJzb24gd3JvdGU6DQo+IE9uIDQvMjIv
MjUgMDc6NTUsIFBoaWxpcHBlIE1hdGhpZXUtRGF1ZMOpIHdyb3RlOg0KPj4gTWFjaGluZUNs
YXNzOjpnZXRfZGVmYXVsdF9jcHVfdHlwZSgpIHJ1bnMgb25jZSB0aGUgbWFjaGluZSBpcw0K
Pj4gY3JlYXRlZCwgYmVpbmcgYWJsZSB0byBldmFsdWF0ZSBydW50aW1lIGNoZWNrczsgaXQg
cmV0dXJucyB0aGUNCj4+IG1hY2hpbmUgZGVmYXVsdCBDUFUgdHlwZS4NCj4+DQo+PiBTaWdu
ZWQtb2ZmLWJ5OiBQaGlsaXBwZSBNYXRoaWV1LURhdWTDqTxwaGlsbWRAbGluYXJvLm9yZz4N
Cj4+IC0tLQ0KPj4gICAgaW5jbHVkZS9ody9ib2FyZHMuaCB8ICA2ICsrKysrKw0KPj4gICAg
aHcvY29yZS9tYWNoaW5lLmMgICB8IDEwICsrKysrKysrKysNCj4+ICAgIHN5c3RlbS92bC5j
ICAgICAgICAgfCAgMiArLQ0KPj4gICAgMyBmaWxlcyBjaGFuZ2VkLCAxNyBpbnNlcnRpb25z
KCspLCAxIGRlbGV0aW9uKC0pDQo+IA0KPiBSZXZpZXdlZC1ieTogUmljaGFyZCBIZW5kZXJz
b24gPHJpY2hhcmQuaGVuZGVyc29uQGxpbmFyby5vcmc+DQo+IA0KPiByfg0KDQpSZXZpZXdl
ZC1ieTogUGllcnJpY2sgQm91dmllciA8cGllcnJpY2suYm91dmllckBsaW5hcm8ub3JnPg0K
DQo=

