Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06154C25B4F
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2024 16:52:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4O3I-0003OY-Nk; Tue, 07 May 2024 12:52:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1s4O3F-0003NY-Rn
 for qemu-devel@nongnu.org; Tue, 07 May 2024 12:52:26 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1s4O3D-0007tO-1C
 for qemu-devel@nongnu.org; Tue, 07 May 2024 12:52:25 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-34d9c9f2cf0so2522595f8f.3
 for <qemu-devel@nongnu.org>; Tue, 07 May 2024 09:52:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715100741; x=1715705541; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ZwLFHNNApZOE61a8qN1aGj5IuWKhLLCa4h7hGLkQ9Cw=;
 b=agD/bukQJSKl4mQj+0U8Ya/z/SYIJavILx4EK7G6C2etzKGISFSYm3FmZClYGK8toS
 uFTX8C+1KmJeNee9C63mFh0wmdSgAbsmkleMnhoXhmHs0nTWyDeuaxK1TsNSIyQ/R0nv
 NteAAN/enLrJpodYxaVejeSYR4RDhVEUbuJzw5e/tCBsEiqee8quwsHgy595mvXKtjMk
 2sNyyLKd9rEkUzTmI1QIeRt7TxoCiXb+jv3v+XsX+zZeXeUYxpAYdtIVLacgWG/eQb2U
 eMaIMleHDbpvn5dUrlVpZHtfT9iT+s8Hh01dC0nN0A97AvT6aFxzbwxLuejQDhTIiA74
 kmQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715100741; x=1715705541;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ZwLFHNNApZOE61a8qN1aGj5IuWKhLLCa4h7hGLkQ9Cw=;
 b=WLrXojAd4uFGba5U0y0tg3mQ4E6QwfjedOK7YdRQsdEO3axU3sVtZ7U+rew7bmpaYD
 dkmexo17Zob1S4Uw3qiNmLU+iM4RdBOMJaJreRA5eL/lm4PEhkhAm40wqg7TAZhR3+RY
 ZbeLjDMRvCvrBEp5z3ypa2qyeaiM/iix9v8zbw14pPlnSZHDjRRsltpzPVn3bhjFCMnb
 4+n2Bc7TlhgAeLXNHL9zLDYsH1H16H5IlAPGpqA9mxig3/vDUawmOgRgl2EWWwcV9bkH
 4qRhAm+6VWmQCNokAox8i/j7U7DccoD/r9+GePGqW54V27D/kHgSSk/avY2ZHniSYwaE
 uQcA==
X-Gm-Message-State: AOJu0Yy7xPK8fUQH7UxWhcWThg9EikGH3gZXoJQsM2xc+3hOVu6XUa3U
 WAPEXI/tsNLSBIX1sAmTGXDdYq/aYkXx7Nj8okKTBKrYDCjcod+KMoMqL2s3BP8=
X-Google-Smtp-Source: AGHT+IGWU5SdH9LBsEphnvReEsfxEvBoZ9hOuE3NPdiIIpV3clAxLPXENSn3YRSu8Eg5M+4diWIKAQ==
X-Received: by 2002:a5d:4851:0:b0:346:bb51:c203 with SMTP id
 ffacd0b85a97d-34fca0552fcmr292062f8f.12.1715100740764; 
 Tue, 07 May 2024 09:52:20 -0700 (PDT)
Received: from [10.252.1.2] ([4.233.200.221]) by smtp.gmail.com with ESMTPSA id
 i15-20020adfb64f000000b0034af40b2efdsm13314676wre.108.2024.05.07.09.52.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 May 2024 09:52:20 -0700 (PDT)
Message-ID: <e72109cd-5ba2-4935-be5d-6faeee0ced89@linaro.org>
Date: Tue, 7 May 2024 09:52:16 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 0/9] TCG plugins new inline operations
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Mahmoud Mandour <ma.mandourr@gmail.com>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20240502211522.346467-1-pierrick.bouvier@linaro.org>
 <874jb9hah9.fsf@draig.linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Content-Language: en-US
In-Reply-To: <874jb9hah9.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-wr1-x42a.google.com
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

T24gNS83LzI0IDA5OjA3LCBBbGV4IEJlbm7DqWUgd3JvdGU6DQo+IFBpZXJyaWNrIEJvdXZp
ZXIgPHBpZXJyaWNrLmJvdXZpZXJAbGluYXJvLm9yZz4gd3JpdGVzOg0KPiANCj4+IFRoaXMg
c2VyaWVzIGltcGxlbWVudCB0d28gbmV3IG9wZXJhdGlvbnMgZm9yIHBsdWdpbnM6DQo+PiAt
IFN0b3JlIGlubGluZSBhbGxvd3MgdG8gd3JpdGUgYSBzcGVjaWZpYyB2YWx1ZSB0byBhIHNj
b3JlYm9hcmQuDQo+PiAtIENvbmRpdGlvbmFsIGNhbGxiYWNrIGV4ZWN1dGVzIGEgY2FsbGJh
Y2sgb25seSB3aGVuIGEgZ2l2ZW4gY29uZGl0aW9uIGlzIHRydWUuDQo+PiAgICBUaGUgY29u
ZGl0aW9uIGlzIGV2YWx1YXRlZCBpbmxpbmUuDQo+Pg0KPj4gSXQncyBwb3NzaWJsZSB0byBt
aXggdmFyaW91cyBpbmxpbmUgb3BlcmF0aW9ucyAoYWRkLCBzdG9yZSkgd2l0aCBjb25kaXRp
b25hbA0KPj4gY2FsbGJhY2tzLCBhbGxvd2luZyBlZmZpY2llbnQgInRyYXAiIGJhc2VkIGNv
dW50ZXJzLg0KPj4NCj4+IEl0IGJ1aWxkcyBvbiB0b3Agb2YgbmV3IHNjb3JlYm9hcmQgQVBJ
LCBpbnRyb2R1Y2VkIGluIHRoZSBwcmV2aW91cw0KPj4gc2VyaWVzLg0KPiANCj4gDQo+IFF1
ZXVlZCB0byBwbHVnaW5zL25leHQsIHRoYW5rcy4NCj4gDQoNClRoYW5rcyBBbGV4Lg0K

