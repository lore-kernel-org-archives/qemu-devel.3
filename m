Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B7BDC35FF3
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Mar 2025 00:33:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuhMw-0003EP-Fv; Tue, 18 Mar 2025 20:33:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tuhMM-0002yw-Fe
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 20:32:39 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tuhMK-0003kJ-SC
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 20:32:38 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-225df540edcso3810265ad.0
 for <qemu-devel@nongnu.org>; Tue, 18 Mar 2025 17:32:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742344355; x=1742949155; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=YPqPhrAGna/QcfSiy0bsy//jAIF/XYtY5p4CVdzRrP8=;
 b=R6rwEUC8Hgy4xniL6SM5tk9mZ7KNS1tWCY9/xOyNPSUqHyKjdAyyLkNOu4slAqZrnD
 l1t9vcD+1I0VMzXyQW31qVNxepfWH/dPCQNtMaN8ULGrGxAvxkQYKKMxvds5DMvnuFH7
 E4JcJWMY+ayFDhQYFjgWYaWUVzpNHqBPN64HujlXSS/Z2FnJQpeQwQ4Q5+Yv6VHyWcWt
 CijHdDt4jjHf0FygyLMv4ARJY9hFYibkzamB3LHIC5xlBEH8SIQisjcvlIER7GImAO+Y
 qt4eCvRF2d854berlDgAr8KJzsBic4SQV0BZ3coRBMEKBXNJXmf7OcY2CRPGSg0Q4yBz
 8u2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742344355; x=1742949155;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=YPqPhrAGna/QcfSiy0bsy//jAIF/XYtY5p4CVdzRrP8=;
 b=RtNemgsKa8b0PXcs8xE2zd5qxRTPdGz2LVznIpgzTU21BkqPMveCoHxC8EDC+61tuw
 u4l/Yu1Iko9jVxsoA2ev6ZAJOp6lca5N6k3r5pN8j0MGDjRVL6fHQXFz7RQqQjqsr6Sn
 kXelAyBQyK1CFKQQWyzspS4AWi7XxEUeSa9kB/cQDgnfvXffkxg9r08yRWok7Xc6y7NI
 q8h/sf41+4H97wE72lCJ/07ThIC+3rGL7u6XR/IuOFORp16zkyf2mAX5niwq8cppgp/Y
 8jRCCyrOtlrbfZUyRnUVwSQP+k35Vt2YB+BwrAl5twf0oSRKCWmWKGzSy0HTG/IREjMr
 5qFg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUrLz3y2e8hxvTZK3Do6Ax7eaJewPlGEUL39ZgpA7QNeq3gyNPuzIzFlPV5m5TFpWu0qDIGE14vjIiG@nongnu.org
X-Gm-Message-State: AOJu0YzH+CfRi0ecu5R1JZhnnKvL7MOilCwPDdVwcdL9Beb2Ug99HpLW
 13UIuROiMqZQ+XJFjCbBEY1rfqxPx6Hz/IPZWUm56ZF3Tp0F/vVsnIh5WIbs0Mc=
X-Gm-Gg: ASbGnctbhNOET09qJVOBjyBU3xjNtU67TREjDvViBH9+iZrFy5IDbMaJCtsx/qnTeKZ
 rwwA6b1IsnTxjNpGWxg6mZuXXp6MB4tJInQR2anlnh+Y2zGvkhqo0509Jdx8WnX8i+FYie1jHAA
 5C+akHlKWIz4vCdTCSrzSxDXv5bT1LszWO93P8CCT7rVGUVAOF2OQWEym3jqzXwr8MyiHlaBlbe
 DxtlMHj8fG1IkoXmV8e/bIf8rBr82XZ4x3OayIiByFoDZcfwXZmi5h9vqzciNxpuYZEf8HPjViQ
 PcSBUlKsO7y/C7eZczCwA+sc9prtbP3MVASjIzaDb/YXmcFnHRCr1ZfZEA==
X-Google-Smtp-Source: AGHT+IE4YrzIA5m2tOL6JrjfeKj31kxq1IAOcfjpwYf8BF2s3mpuq8lazqh+/v1Fv489EimpuCZdUg==
X-Received: by 2002:a05:6a21:3417:b0:1f5:9cdc:54bb with SMTP id
 adf61e73a8af0-1fa4ff2fc05mr7218589637.11.1742344354901; 
 Tue, 18 Mar 2025 17:32:34 -0700 (PDT)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-af56e9ddf44sm9667222a12.18.2025.03.18.17.32.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Mar 2025 17:32:34 -0700 (PDT)
Message-ID: <e36c4b17-cac0-4e53-a88a-d6238492443c@linaro.org>
Date: Tue, 18 Mar 2025 17:32:33 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 31/42] system: Move most files to libsystem_ss
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: philmd@linaro.org
References: <20250318213209.2579218-1-richard.henderson@linaro.org>
 <20250318213209.2579218-32-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250318213209.2579218-32-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62e.google.com
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

On 3/18/25 14:31, Richard Henderson wrote:
> Some of the headers used require CONFIG_USER_ONLY.
> Do not move vl.c, because it has other include dependencies
> that are present in system_ss.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   system/meson.build | 7 +++++--
>   1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/system/meson.build b/system/meson.build
> index 063301c3ad..c2f0082766 100644
> --- a/system/meson.build
> +++ b/system/meson.build
> @@ -4,6 +4,10 @@ specific_ss.add(when: 'CONFIG_SYSTEM_ONLY', if_true: [files(
>   )])
>   
>   system_ss.add(files(
> +  'vl.c',
> +), sdl, libpmem, libdaxctl)
> +
> +libsystem_ss.add(files(
>     'balloon.c',
>     'bootdevice.c',
>     'cpus.c',
> @@ -23,9 +27,8 @@ system_ss.add(files(
>     'runstate-hmp-cmds.c',
>     'runstate.c',
>     'tpm-hmp-cmds.c',
> -  'vl.c',
>     'watchpoint.c',
> -), sdl, libpmem, libdaxctl)
> +))
>   
>   if have_tpm
>     system_ss.add(files('tpm.c'))

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


