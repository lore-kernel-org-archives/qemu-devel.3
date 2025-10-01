Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3417ACCA470
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Oct 2025 07:45:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3rVO-00050W-L6; Wed, 01 Oct 2025 03:44:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v3rVF-0004w2-NJ
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 03:43:58 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v3rV8-0008Mp-30
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 03:43:57 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-46e2562e8cbso52616985e9.1
 for <qemu-devel@nongnu.org>; Wed, 01 Oct 2025 00:43:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759304622; x=1759909422; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=C16I1I8Cue92gBYxb9oNGtCo9TW4jHCo+KWKhtf8xgo=;
 b=tctm8BrU0SlDnurzzzwDWaiK1tU6bQr0UOTb0ST0veWynBDdXwu0cGKBljF5oPDudY
 bEM3BRMx76VGuDE3xFadlFoSTReVQ1SLbAphViIudaod1gPFaMLXmJuRuyeYzZ5ufQHf
 4SN4qcIcWGMCUaFH4zslIgPsqRz7J8kJU0p5IgVwpReRT8O6NkfzcB1veClDXYFYvFZU
 2pxe2j1DcwsWCYue+QFgROa9c1wq/ClFyXlcveMmHVTLMHUqKb49N0qNRWtl665IYbh4
 QmATq0LFTCXitb+rOpVFqjG+D+sbdc5GE/WwX0SxxryN4ODVqbRQwaMkYkxRPS8abMLE
 ilHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759304622; x=1759909422;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=C16I1I8Cue92gBYxb9oNGtCo9TW4jHCo+KWKhtf8xgo=;
 b=WCMO+62n7Ki7zGCe6jdknOLQlxWmz82h9JMZ5ZtI8xV0/ZE5qfUofLLARCrw1J3FJq
 +gVJnG63zPNmSraFA4Xc8LhwDMBgvI/e1boJr5CbYfXKY45YnQsyy67BvuHnymluV5bk
 iEr2zWdUEnkriUDA9XtcC6xvFSLaB0+EvkbtCfYFnm/RGH7rW5N7sBOk9JyN25mQ9J5P
 HsSkRuWIHBweQOEPxNQow74PMLB07XIhDHHUDn190C3EJK4X6/SKrINZ3nYZtbdJSTON
 cBcAzQ9ZuI4Vw5Mrf0GCv4Yhs7ii84Q1xszAhveXfvTBZk9Spe7TUiZSroM+NSCRHvW0
 z9KQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX3lGRNQBcUz79T1SM3UqoOduUITzG8cOEGISUv3syOokHU4S2U6KgGAR2PSBy0JqV21VnJPUcpyaky@nongnu.org
X-Gm-Message-State: AOJu0YyigkmgeHak+z9lq3aKq5IGxe6AOM2kMx44KuBngbLlOR1lG9JS
 yVpZrKcmhT4qkSYq6yM8BiHrO3WHAhGYh0vii/ewu8frCsu5He58gSSYRpFs45WHYSZqoKbSCyJ
 dQIuodEVC0Q==
X-Gm-Gg: ASbGncum1aIbErxpRTlIHRDsRsBnpvzQnYw8DgQLCW/G0p0BPHhvEElDgDLMD02GYux
 7ncWhkDVBdlPhYYDGqq0xBQj69SA15jgj9hazcfSbeKK2jQOw6Azweq4BTQ4mCH3R2rs+iqG7b8
 sAKXrI1SP3msFclvqVWZL0sYditdFjbX/Z3JwJvYVIW+Dv1jPeNENV01TMjPhWk3dKSflu6D1yB
 b/BzjnBxnB6aYQeGsEVeE/8lVOIVvhNEVd9+w56iMOXWAJxb6Adtip7mlAHQiObOc/mg0jmOfL4
 RS2Yoff6vTx69KHx11pVRddducj5dTQjAmeRcxRFsenpSHYjWX0nrLi+l91VA+XYfp/74cr6541
 TS2MzbfCkjkQiD7SuI+RIdAB342NS/j6pgbVaPHSDbufcD/xQvTetC2PISa6t/Qv7HVF2Jl3IyQ
 mVIVo7KfbviK/8DQ==
X-Google-Smtp-Source: AGHT+IGlczMASVkgaTlXecge7zTMziecktEyTeNUNEpefBHUar2eF94zhomezrZseRlY4g0Zv9RDXg==
X-Received: by 2002:a05:600c:8b42:b0:46e:3d41:5fe6 with SMTP id
 5b1f17b1804b1-46e6127a545mr18715755e9.9.1759304621838; 
 Wed, 01 Oct 2025 00:43:41 -0700 (PDT)
Received: from [192.168.69.221] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e5b6d81f2sm29284235e9.5.2025.10.01.00.43.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 01 Oct 2025 00:43:41 -0700 (PDT)
Message-ID: <b4ef4193-5e9b-4912-8f1e-5f0edd2ea238@linaro.org>
Date: Wed, 1 Oct 2025 09:43:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 25/33] target/riscv: Indent PMUFixedCtrState correctly
Content-Language: en-US
To: Anton Johansson <anjo@rev.ng>, qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org, richard.henderson@linaro.org,
 alistair.francis@wdc.com, palmer@dabbelt.com
References: <20251001073306.28573-1-anjo@rev.ng>
 <20251001073306.28573-26-anjo@rev.ng>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251001073306.28573-26-anjo@rev.ng>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

On 1/10/25 09:32, Anton Johansson wrote:
> Signed-off-by: Anton Johansson <anjo@rev.ng>
> ---
>   target/riscv/cpu.h | 12 ++++++------
>   1 file changed, 6 insertions(+), 6 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


