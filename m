Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB8BCCA0EC4
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Aug 2025 06:35:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ulia6-000482-Gz; Tue, 12 Aug 2025 02:33:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ulia3-00047N-OK
 for qemu-devel@nongnu.org; Tue, 12 Aug 2025 02:33:55 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uliZx-0000Fx-Cs
 for qemu-devel@nongnu.org; Tue, 12 Aug 2025 02:33:55 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-3b78b2c6ecfso2742693f8f.0
 for <qemu-devel@nongnu.org>; Mon, 11 Aug 2025 23:33:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754980425; x=1755585225; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=MzrC+BNqvTR2usQoMOztw+RVp/EjNBbYVhZfVl3Ga7c=;
 b=G2ulbqXGscZ6Ho+9z459TB9Q6kNNnPTZGWqePwQgPWLnqunL2EKylvNk6Mr+L5kvcH
 ylklXRIKepPglvdJg3U5wYHjGPSs7md8D7M/yqRsF1WRtOT3ONl9IRvO8ZJjlDcDC6X/
 xSmtrHi28Mz3ghLJX+02WgXunGJkuvB45sVQFhUWTd/oTb3geZ3GbOIjgYTus5MqLJ5W
 hdhWxRfTYVQUz0t5f5W32QPMdHq0iZj7GfMA2lq0aUb6hleEpCYu59BQVrc1dVoGjIkr
 GjJTveIZuwZ9cPdW/GnMrS1H8w8BSKlUSltm77xrrv7q/9LvjgUFvi9nOLnBcK1bacrn
 cL8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754980425; x=1755585225;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=MzrC+BNqvTR2usQoMOztw+RVp/EjNBbYVhZfVl3Ga7c=;
 b=fthnAjVNjQEpazDjREew3J4hy2mJsmmWl867X/b1+BwSAUcXCjHcB9z9kAfC9wyp61
 dDAo30J8wVpjijh9/+Lt9v0hDvS+uod/F81IaYxHCHxbd6fj87nHUMlVhjQSsCiBo3jX
 sIreun97Zv9ALLkuVFywVK6HgPTGR47oRhvMZ8ZQ5vBsGRIn8G5g+b8V0eYC0BdQN/so
 Cn2sd8ANy+jFbmGj42ay1gLAexFnj3+ARv5YucxHzcE9/zN9albgjgN/tawGv/l4XDHA
 CJRJDbmE3xjg8pLDsDf2Lg84pKrOKhWxbmGSnMuiMW60H/2fD9ZCk7U74dB0zzojvuDb
 zstg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVZoRNPQAKIVReErEHOiSkmZKrCYuNPoGmDiBhRprWL6ltOlvRuj0OCztznBW/7y51L7ZAO7TdYve/J@nongnu.org
X-Gm-Message-State: AOJu0YypGXxwqbAmcsFNTg0e8giBbJgCgu+N+jVotcUnYi6gkuhH+v4u
 0cT/FRCjy7klNT312N1e1WBTjl75Wqh1efMWdM92sZNZXnbDcPCtKha1Q+JxiipZHpQoQ9XrpM5
 RVXkF
X-Gm-Gg: ASbGnctmh/FlgmdqPfuoURcWunXKNiPsg6/ynIRk+1LC0PnW7ukz7QoBh0VfhOw17Vd
 F9T4uBs8peYYmUr8an8IwqUAiHSDireXOrA7MqhLN8ANpT9KMo/IffDjl944UYMuDwM5f0AOKoc
 dzNBfbF87flLaC4QwC2KKnmUtpwBIKotzjZ3IUmXEUMx7RtjoQCVWMBN0+FgcVK6ryBPHC1lquj
 0HrYZgzaxZQTkw0QNJBS00B+0PsbfesjGxFtLOXd146LTkCt4gGecfqFCmE5qQSjMw0IUuC+cRO
 3yMJjySRnlt1yQZKr5SFKgUrqI/Mi4wXWnkcJxhSrYN3sg1bxKYT8Sw1T5VZ4RUdhSVW8nK5E7N
 dKobI4mSznxZPqd0hZ78hCU8H3mDPueY0vdZdXzAEPh7+3rl4GkzLyMDgFYSM9WfA1w==
X-Google-Smtp-Source: AGHT+IH+ifaRYTfM2BaQW5/20fGbfCcxXOmKk2aJXwLiX3PePcFiLimGomo3ewOuUx9zXHg5nKn0lA==
X-Received: by 2002:a05:6000:2506:b0:3a5:1cc5:aa6f with SMTP id
 ffacd0b85a97d-3b91100798emr1860140f8f.34.1754980425365; 
 Mon, 11 Aug 2025 23:33:45 -0700 (PDT)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b79c469582sm42159939f8f.52.2025.08.11.23.33.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 Aug 2025 23:33:44 -0700 (PDT)
Message-ID: <4548bfd3-2d27-4fdd-819f-2f19cac2580f@linaro.org>
Date: Tue, 12 Aug 2025 08:33:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/85] linux-user/aarch64: Split out
 signal_for_exception
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>
References: <20250802232953.413294-1-richard.henderson@linaro.org>
 <20250802232953.413294-2-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250802232953.413294-2-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
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

On 3/8/25 01:28, Richard Henderson wrote:
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   linux-user/aarch64/cpu_loop.c | 84 ++++++++++++++++++++---------------
>   1 file changed, 47 insertions(+), 37 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


