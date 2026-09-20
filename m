Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E36ADC982D8
	for <qemu-devel@archiver.kernel.org>; Sun, 20 Sep 2026 21:45:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x8PKj-0002zb-Ip; Sun, 20 Sep 2026 17:44:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x8PKi-0002zT-IT
 for qemu-devel@nongnu.org; Sun, 20 Sep 2026 17:44:24 -0400
Received: from mail-pz2-x0e.google.com ([2607:f8b0:4864:3b::e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x8PKg-0006E8-0c
 for qemu-devel@nongnu.org; Sun, 20 Sep 2026 17:44:23 -0400
Received: by mail-pz2-x0e.google.com with SMTP id
 41be03b00d2f7-cc4c3304784so2052055a12.3
 for <qemu-devel@nongnu.org>; Sun, 20 Sep 2026 14:44:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789940660; x=1790545460; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=zjPe3jJk1Ic8n1mCobto6kJXBjMCjlRLGBrRsqLhrR4=;
 b=LdgnKqdh8VLMZSLjZr6RUijI9nLlWVW5fMx6cv9/DyHpProXygYHJePb9sQDlCAG9J
 m75ltZvilaIM2WQdnXUChm4EDQZPL+GLfMFnM04Q0we/D9k5wo4cqjZNTYnVSupn0hB0
 0fuGdsJA7jEgVVw8wrT7BsJS2sVUoor1sZUmDjKeMKfC8yHMYy1w0JsSXyzQxdZWsyMK
 DtYfHGm2diyIAvy34yajY9UgFcSUOM+n+y5Im9OVJppKIuoYb1Sx3jzt2tdvC/zoSx8G
 ZbKkRvQ3ZxzSdk6z0DfRyoDio1NEUkofwPekRhy4Y68t8UsO+D2bwxyFcBV5vivfgyjd
 xZ2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789940660; x=1790545460;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=zjPe3jJk1Ic8n1mCobto6kJXBjMCjlRLGBrRsqLhrR4=;
 b=uSAOLNsYb1d8UnDTdEesyoJbXdxqiY7S+4QglxNUpJkfIc1ac9lBIVV7z0RWQwbi3o
 zSv6JjqyXbAej9H4IdgGLfxfdFbu2cJgTWSWbldc8arsiJ55NRZJG//Abnio0e5qhu33
 zoioC8lcHIim2mNcSYXMEIalbNBd7YMftZj+9IuO9pfcoTbcdLd85ZM/tDCqHOaHsu0w
 AsfMoISugNpnpnS/021JVLK54RKzp2KtSTdGlfIcLaqouQl+4C+A4gO5vMs1XvwidHiH
 xAAlCN81OxR6ia+pJ1Ut9KZzjzseQisLog23ERkfbtYW+0FmsDhQOZXgcKZrzOQN0aUw
 0/LA==
X-Gm-Message-State: AFuF++na+GfHHAQiGBpT1NNXhawfsPW5NzpTKSEWM24XqjhLRFb3iQUe
 hvGcTKBCE4Xhrz0NTViXST4EOWx9++kmAohvbHLA77Prn0iADZdVt236ohQg08gicWw=
X-Gm-Gg: AYBFou0RtOAq2nhzRWajRb/3sRUqYU1GZW6fnV84q9TU91b/L548ZnAi1Sv5+CW9iD6
 chyKAkkBq5QM9kHA5weyiW1LGvQFnGaykQTCtrfTING2/QHc2Bv/2NVAyc31hN8fMIrq2w8MYqp
 uRzxrBJdGrYuaQhuH21xr8dDZ/nQEzgGQtWWLIStLMytb5UPIl0JzwpNKcZc6gv+et+lePtSL5p
 Y5XcEx+FkGN6wFTA51kruHi160Giwkx0rvYo3Gyd4pZsHGoOoKJMH0YnzEgJ0NU4VgNZq7BJLud
 w0RGjQPlcvQXKSZsKXtm7NdBC6Dv3Zb68JqonBvHwMptyG5Pe3V6fK9/PgeG8ATylj6w+QbvWiP
 t+GPVVjWnXKmCfnsG2k+jNM4FPqSHg9BbN+DGXmNUptO3nZ0Qwl8lpYcbzL47Ym7m8qNsF6mfot
 l+EW5z/fqW34kT8KTWHkbiJITvTngM9/W7Nd1+EDl0Cd7Y5QeLv1C5hf86TncblAzviGar3HzGI
 M/6WC+r118lgV5lHBOTcH+L6LY4g1SZKgYTmlxbAtTkiIZX1HwenEG+xb6/
X-Received: by 2002:a05:6a21:140a:b0:3dd:a197:cf32 with SMTP id
 adf61e73a8af0-3dda197d889mr7447507637.86.1789940660321; 
 Sun, 20 Sep 2026 14:44:20 -0700 (PDT)
Received: from ?IPV6:2603:800c:7900:ed00:5f56:e854:5df2:d786?
 ([2603:800c:7900:ed00:5f56:e854:5df2:d786])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-144d55f299fsm26417517c88.15.2026.09.20.14.44.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 20 Sep 2026 14:44:19 -0700 (PDT)
Message-ID: <428adde7-03da-4385-9138-06831afd26e6@linaro.org>
Date: Sun, 20 Sep 2026 11:44:16 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/2] tests/guest-debug/run-test: Add --pargs
To: Matt Turner <mattst88@gmail.com>
Cc: qemu-devel@nongnu.org, Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
References: <20260917220718.60899-1-richard.henderson@linaro.org>
 <20260917220718.60899-2-richard.henderson@linaro.org>
 <CAEdQ38GUXfAvrgCjb6gqKk4Ph72HrGXZYo28QwTGtHZpuTaWOw@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <CAEdQ38GUXfAvrgCjb6gqKk4Ph72HrGXZYo28QwTGtHZpuTaWOw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:3b::e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pz2-x0e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 9/19/26 15:27, Matt Turner wrote:
> On Thu, Sep 17, 2026 at 6:07 PM Richard Henderson
> <richard.henderson@linaro.org> wrote:
>>
>> Add --pargs <string> to pass command-line arguments to
>> the user-mode program.
>>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> 
> Reviewed-by: Matt Turner <mattst88@gmail.com>
> 
> One observation: --pargs is only appended in the user-mode branch, so in
> the system-mode branch it is accepted and then silently dropped. That
> matches the option's stated purpose, since there is no program to pass
> arguments to there, but a silent drop is easy to spend time on. Perhaps
> worth either a comment or an explicit error.

Thanks.  I've added an "assert !args.pargs" on the system side.

Since this is developer facing rather than consumer facing, I think 
that's sufficient as an error message.  Especially since we can't detect 
system mode until after argument parsing is complete.


r~

