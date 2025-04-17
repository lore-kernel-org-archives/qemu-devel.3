Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D3EBC369C7
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Apr 2025 09:51:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u5LtH-00077Y-Cl; Thu, 17 Apr 2025 05:50:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u5Lt8-00075Y-KY
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 05:50:30 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u5Lt6-0000sg-2X
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 05:50:30 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-43cebe06e9eso4538615e9.3
 for <qemu-devel@nongnu.org>; Thu, 17 Apr 2025 02:50:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744883425; x=1745488225; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=5BxTtwAQkIA/7hmrydh5BciZVxfSCSymTFm+usKP8Dk=;
 b=OoHbVtv3qqAZTcrVYy1YdY2YckF1u6V/JEMb6DLhDHIlebJ0wXObyfwfK8JaIXvHRO
 KiPV+VncMR/41nqGDBDzKOpcO58DHTj05ActDp8MrIBw1BH0MPh4ivB6E4n+gIREmPqf
 1EOVSPp2cRlRq3pGzsg3mTkiRV4usJyQb0kNTD70HlKpfNOlJRuVjyxOb2qKdgliWurx
 /GcMXH1+SRZjAUugLobysKRWdP9Zou5fWQ2NVo3zqjtlavDCzYcppLL7tCpTLjpD0mc/
 PZiyHsx9jls57FZmoUxUj76ojf/8TeKkk3IvJoQgkNhR9EPSh/iEIDBNbqZDeQ5lpHqL
 T8aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744883425; x=1745488225;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5BxTtwAQkIA/7hmrydh5BciZVxfSCSymTFm+usKP8Dk=;
 b=rSzQXlisenOGIpwh8dMBqFb46RGrQ5WjbtoUyojKWS5Bsfc2rBCCZY7/FbxjNHtPUD
 9S8gWQLg8958REQfTPX07IkhDKLWIY0mikGCkwqk21eHRHmUDCafvokoiTCjsUMddX85
 3mB641kCygxwW5+blvr0v8qSt7CYDhaH1kUqDj5baXspM54BQZFzDobeS84fFjJa9i8N
 by1IJUmbyzYShBenkoPa28OKOeesSa/BdTl7u1AGBgDs6NxKi45CBm8+eUI6FbFLiG+3
 00TyuTsjYl884or04V2wsYH3gYbPtrGhczouDlWwwYoAoMHmLva6O9uXo9DGDE2okvlx
 z4Jg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU1m00ZAINsRyQ4yVqK4QqIugsmQ1fteAQodjO1mk8ST6usJrUlBhRC63x53jvtAlaz/59L7yAB5DiL@nongnu.org
X-Gm-Message-State: AOJu0YwxJHftI9lLTYbV08gmBNjkMhjX7Gm7uFAz4wjdkuoqXZmmR4yQ
 wNsD3pk8UTsjgEsYsFLvGa9nSjd9OGaQhxvOUso51n6voXF8CbZt+YKlh9YbgHk=
X-Gm-Gg: ASbGncu4fd90J4h3HU9IZHZgoWQBI7+dS3kBCR+/kF21S23Zn0REzbm56BCuiE0JPd1
 NdzMjuapmFVe0IXYg3goY0GF2pUkeRhTE3bQVfMAKzh2Csc36L+UzIwIDEXKDdWbKtjOTNrocyt
 RQpy983FXfHpqVKjm+ng758YXvogSotDyegG1jG/G8CLeETLuMvrfVYFGwM3qDC8/zobprW5XNr
 RDqb83HEFX6DP6DjaO9xuOtNLRw1kOkLePl62i0iL0RMxiZtxAUv8J6enAnLvAZcbMAaTZA/cZ7
 3gV3P5RYbfBz2Rz+ihOAxHGvVbGGwRWdJlmr0BPIc0POlGbrJYmGSfgZZMdjuH0lIwBrl1Nn2YR
 ZSgBy7bHMycwwzbJR3Ko=
X-Google-Smtp-Source: AGHT+IFcQflbDZ12X4g9KWaMhIedgJHwJNO6CgZ3fYxf3VIS21k+SopVHxHUIJawnYDlLSKN75t0zg==
X-Received: by 2002:a05:600c:45c9:b0:43d:16a0:d82c with SMTP id
 5b1f17b1804b1-4405d5fce94mr50473445e9.2.1744883425515; 
 Thu, 17 Apr 2025 02:50:25 -0700 (PDT)
Received: from [192.168.69.176] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4405b4f39b1sm47042825e9.22.2025.04.17.02.50.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 17 Apr 2025 02:50:24 -0700 (PDT)
Message-ID: <c2bcfa70-1b6f-4182-ac3d-dd4493232a16@linaro.org>
Date: Thu, 17 Apr 2025 11:50:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/19] util/cacheflush.c: Update cache flushing mechanism
 for Emscripten
To: Kohei Tokunaga <ktokunaga.mail@gmail.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Alexandre Iooss <erdnaxe@crans.org>, Mahmoud Mandour
 <ma.mandourr@gmail.com>, Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Pavel Pisa <pisa@cmp.felk.cvut.cz>,
 Francisco Iglesias <francisco.iglesias@amd.com>,
 Vikram Garhwal <vikram.garhwal@bytedance.com>,
 Jason Wang <jasowang@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Peter Maydell <peter.maydell@linaro.org>, Zhao Liu <zhao1.liu@intel.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Hildenbrand <david@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 qemu-block@nongnu.org, qemu-arm@nongnu.org, qemu-ppc@nongnu.org,
 qemu-s390x@nongnu.org
References: <cover.1744787186.git.ktokunaga.mail@gmail.com>
 <97a2164b3f428265136bb1c01615a16b516138c2.1744787186.git.ktokunaga.mail@gmail.com>
 <29330430-61a8-42c8-a87c-259f0cdbefe0@linaro.org>
 <CAEDrbUYu-NH4Dwkby-UTtQpiy0ApN+Z4dwt+iOs_SZjCwfM_ZA@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CAEDrbUYu-NH4Dwkby-UTtQpiy0ApN+Z4dwt+iOs_SZjCwfM_ZA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

On 17/4/25 11:27, Kohei Tokunaga wrote:
> Hi Philippe,
> 
>  > The "why?" isn't clearly described.
> 

I'm happy with the following ...

> Although __builtin___clear_cache is used to flush the instruction cache for
> a specified memory region[1], this operation doesn't apply to wasm, as its
> memory isn't executable. Moreover, Emscripten does not support this builtin
> and fails to compile it with the following error.
> 
>  > fatal error: error in backend: llvm.clear_cache is not supported on wasm
> 
> To resolve this, I've removed the call to __builtin___clear_cache.

... used as commit description,

> 
> I'll update this patch to include an explicit "#elif" branch with an
> explanation, like the following:
> 
> +#elif defined(EMSCRIPTEN)
> +
> +/* Wasm does not have an executable memory region. */
> +

and this comment in the code. Thanks!

> 
> Please let me know if I'm missing something or if there is a preferred way
> to handle this case.
> 
> [1] https://gcc.gnu.org/onlinedocs/gcc-14.2.0/gcc/Other- 
> Builtins.html#index-_005f_005fbuiltin_005f_005f_005fclear_005fcache 
> <https://gcc.gnu.org/onlinedocs/gcc-14.2.0/gcc/Other- 
> Builtins.html#index-_005f_005fbuiltin_005f_005f_005fclear_005fcache>
> 


