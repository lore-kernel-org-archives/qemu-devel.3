Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3D0FE7717D
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Dec 2024 22:27:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tK3GJ-0004NS-At; Sat, 07 Dec 2024 17:26:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tK3GI-0004NE-6L
 for qemu-devel@nongnu.org; Sat, 07 Dec 2024 17:26:54 -0500
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tK3GG-0000QP-5h
 for qemu-devel@nongnu.org; Sat, 07 Dec 2024 17:26:53 -0500
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-7256dc42176so3584195b3a.3
 for <qemu-devel@nongnu.org>; Sat, 07 Dec 2024 14:26:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733610405; x=1734215205; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=CZy4Pt72hnv9ZhCGvuLa0/ILvyaMog0QQzsY2pWLYGE=;
 b=u1RnP6g3TfZ2qBQH0ydr0oeCyuD5eI58VTYQKZ8DZ1oPZJA58qYzD8m+6K+E9jHdeA
 7hxCqR4IojSv56YeYnyBdGdMOnq9Cyq/T2MTqUE1HvmldjmcIN61K5C73LbZiztFtBO8
 mHuMVboZBCWIJzQhhh9aIahZxRdmaiG4xrXWbq3ulHTyGnuW/RHuk/2Y+D2A0ReWrR+Q
 uobwY3aay0X6uxFJyoeCNKiwatF80HfzCaA+5B5w24KAD75rK49HRN8DOlynfkzdYAHU
 I55bvqnf1z2pJL2zL6SxSGEkMbe1DUj5oG4I5/F0Zma77nPvLLRC9QA01sDNU9nPxxpE
 V6pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733610405; x=1734215205;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=CZy4Pt72hnv9ZhCGvuLa0/ILvyaMog0QQzsY2pWLYGE=;
 b=O2N94iLPgCtgrxQeAemF9i80ZwjZDOxV/EFPH2XeobereVbq1yPldIxlnQ2q7IlyA2
 BT4jtPgvDxNxMZWyih/b9ORvHAkZqk0LLzla3H6znRUAj2JUammyQq/qfUxAwBoZf5iK
 1B7Ld0j7ZHvcmyptlOqzIp+6ZBI//+ZsjuoO612OU7uJh7E/X65ZlwESl72bkIuYR9mw
 kfx1ouOftmpQH9tLOZ5PqxTNpDtRXuauDtGT82zhEneWXgd3d1kVHs8CA96Nz6iF/29t
 Tic0tzdBUtVzzxQZGDDNRLYgM2On9pddp8qokbnyPcfKSdUUtFl/VKVuUPYRn/Za69QZ
 1QLg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUZkrWNyuu7gcMKKhbhMzOpcIiB6/yJbDDzU0KCmLtgOQ/+XUZYx0cCk3Ra1/DqDw9/uZEhwLD9V3LB@nongnu.org
X-Gm-Message-State: AOJu0Ywq4oTgo7VecyGgpO1KkhSB6Pv/LFzmxrrjmGzJ9htP5sEPwMee
 B1tBIcotJYJM/0yGYnybxkTv0wb1on/o6uWmF+7QKYItrTC4wZaZ5w+rtVSVBEw=
X-Gm-Gg: ASbGncsfUTZuOWzBMbfpCnf2d2dg9tAf/nXGLeakiqI/X+V8vtaJ8ZJzqYvDowQYA9b
 4LTSvxSOshQzM9/iEXzthukIS+uPvX1x/csl1+UXt/5l3H7aRgCIlbtdhSHIBAHuEBM14oB3OFT
 juXRIIMY6Jq4DsFoX02nZXIxQhpaWTdJnX7MtENiFUSnOg5bEL5Vx5U2gpP8JB4QV0jS+cGF9uC
 jcUxJmGl89jFEszRv5yaMk0DXQWjWVi5v3xHG3M89sV2OdLoDd+aomcEGrbgONRlvLHQmKiCKf/
 uWvq42NvJWbYwwgQJthK+Q==
X-Google-Smtp-Source: AGHT+IFBKTRbgCS+eWkd7Ey+5tkUjVi9EmtqEfSO9gsC4eX844iz/j9bgvw5cAneGTQpJme+ufgr7g==
X-Received: by 2002:a05:6a00:1891:b0:71e:5a1d:ecdc with SMTP id
 d2e1a72fcca58-725b816fb01mr11829798b3a.17.1733610404856; 
 Sat, 07 Dec 2024 14:26:44 -0800 (PST)
Received: from [192.168.1.67] (216-180-64-156.dyn.novuscom.net.
 [216.180.64.156]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-725a2a904casm5055910b3a.129.2024.12.07.14.26.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 07 Dec 2024 14:26:44 -0800 (PST)
Message-ID: <07b98592-92ae-4da3-bff7-31d616d195d3@linaro.org>
Date: Sat, 7 Dec 2024 14:26:43 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tcg: Reset free_temps before tcg_optimize
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, qemu-stable@nongnu.org,
 wannacu <wannacu2049@gmail.com>
References: <20241207214700.211066-1-richard.henderson@linaro.org>
Content-Language: en-US
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20241207214700.211066-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x431.google.com
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

On 12/7/24 13:47, Richard Henderson wrote:
> When allocating new temps during tcg_optmize, do not re-use
> any EBB temps that were used within the TB.  We do not have
> any idea what span of the TB in which the temp was live.
> 
> Cc: qemu-stable@nongnu.org
> Fixes: fb04ab7ddd8 ("tcg/optimize: Lower TCG_COND_TST{EQ,NE} if unsupported")
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2711
> Reported-by: wannacu <wannacu2049@gmail.com>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
> 
> Unless there's some other reason to spin an -rc4, this can wait
> to be the first patch for 10.0.1.
> 
> r~
> 
> ---
>   tcg/tcg.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/tcg/tcg.c b/tcg/tcg.c
> index 0babae1b88..eece825e2e 100644
> --- a/tcg/tcg.c
> +++ b/tcg/tcg.c
> @@ -6120,6 +6120,9 @@ int tcg_gen_code(TCGContext *s, TranslationBlock *tb, uint64_t pc_start)
>       }
>   #endif
>   
> +    /* Do not reuse any EBB that may be allocated within the TB. */
> +    memset(s->free_temps, 0, sizeof(s->free_temps));
> +
>       tcg_optimize(s);
>   
>       reachable_code_pass(s);

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


