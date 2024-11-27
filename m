Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E00C2D6ACF7
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2024 17:54:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tGMEJ-0000g2-Qp; Wed, 27 Nov 2024 12:53:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tGMED-0000fE-S1
 for qemu-devel@nongnu.org; Wed, 27 Nov 2024 12:53:31 -0500
Received: from mail-lj1-x231.google.com ([2a00:1450:4864:20::231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tGMEC-0002v2-DU
 for qemu-devel@nongnu.org; Wed, 27 Nov 2024 12:53:29 -0500
Received: by mail-lj1-x231.google.com with SMTP id
 38308e7fff4ca-2ffa12ad18cso83199481fa.2
 for <qemu-devel@nongnu.org>; Wed, 27 Nov 2024 09:53:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732730006; x=1733334806; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Fl0yWRDKsRkUwY1V3cYxi87+E/zb287gst5FoPTasa0=;
 b=U4kFbp6anXX0fvrDTxqUiQ/wtse42/n9EUE+HRmxYPqW2cC3FuCdFq31NBX3jwfmC7
 iXv/J+3giO+7DGUUZ+xymuq1sBPO21ZV08F9V/ko0+uRz9/WKVM0HwQyOjKhSqyxgWrS
 hJq7tYgHOjBikZIHes66yPSpKwJdAaJI/GP2oWRvcHvhov8Rj35+0+MGFYm2QXdwvVga
 Jdb/jrfLiXd9Y6hnlg9vaX2zXXFul2C05uBsCrxQCLpVSSqeSk5gdYXs4A7ppZI9gvcX
 Ck35hbcTtitw38OuE5/6x6Q/VSpSAErlxaeWiYkjb4hf61zhHBoV4qKGznuWt/e7JuXC
 hBHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732730006; x=1733334806;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Fl0yWRDKsRkUwY1V3cYxi87+E/zb287gst5FoPTasa0=;
 b=FybOnuMv1PYixL6H9E1dRJR7DVZthxZ6bBaJkYnxbvRcZjh0zVT6REzpQoax/vk6Ut
 DgOtQw3Hllf2Bn8z+1ejZHz85hyvTUJkVfYXA8qZcgrhbGzanloprLbF6P4oVDolyCVQ
 FL7O1JGpvykvoK3+WguuDHtGQH7UVSrtKvEJjc1UVrHyVkHpHk3shWqDggy+2q0MH3aJ
 YQ5NHjq/Z1LNHPGzIAcB19Ta0CSRcfWKIEf1Q6CShGrkq3OtkmRGFe5nAMJRD2wKjGCK
 rg27o2AnvHlgC77vlOjM0xKL+gmQZoZsk6iH2gv0u9Oddn7ZFGK5jP0mbV23HZG2+Hr2
 JPHg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVfI+0zEdTYqdf2MViCpvDcH0caTjcgJ8LgBIkM6vSjzgcTHE2ji8RaYlogDONrkSqxjo3S3jA/LXu6@nongnu.org
X-Gm-Message-State: AOJu0YxTi47ZtIvFdl8e6pR4FP4DnbxG3FLaUc1fSAgyTHUf7dfzuDfh
 p/9a2IeKA/Wadxk+J8S+OZFI3N5sXI72Zr/GKQOTwSlqi7Gk4hAUuYaKdBOKWUU=
X-Gm-Gg: ASbGncsQ/6OPHxRPMHJy4/EnItwZ0UmAqobxqUE3LgbQE6eKsG7AXAELw0QeE2+510S
 FoIUhNvclEgLSeLZuXJcfzzJ7buT7HRPt2gs5O26tGQlwnNnxknd5/60AIRhNGXDG0XfcNbezSu
 WTlGQillXKdmJAozQtHRZmfSJhd6bdPb9Sji0drUFasBwtpI/R1RBFoO5YIY+lw9ORH8Jy+1KYe
 V8G65gCBa6gdq0g0ObiOC5BhqKeDcFlnBMdxgNncWVcfYtxAakNFa9YCTdCnPx1sPVd
X-Google-Smtp-Source: AGHT+IGLIBx32c/RLwdUOUQuPI0py/hb4MrzmFC6+qj/yaCBuLGvXgeqy054gFzH1j77EjsXP8uyCg==
X-Received: by 2002:a05:651c:b1f:b0:2ff:c3a2:f42d with SMTP id
 38308e7fff4ca-2ffd60e16b0mr26837331fa.30.1732730006383; 
 Wed, 27 Nov 2024 09:53:26 -0800 (PST)
Received: from [192.168.170.227] ([91.209.212.66])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-2ffa4d16f62sm22187001fa.24.2024.11.27.09.53.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 27 Nov 2024 09:53:25 -0800 (PST)
Message-ID: <e5c7e738-3650-444a-bfa0-af6fff4e586f@linaro.org>
Date: Wed, 27 Nov 2024 11:53:17 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] plugins: optimize cpu_index code generation
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Mahmoud Mandour <ma.mandourr@gmail.com>,
 Alexandre Iooss <erdnaxe@crans.org>
References: <20241126190203.3094635-1-pierrick.bouvier@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241126190203.3094635-1-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::231;
 envelope-from=richard.henderson@linaro.org; helo=mail-lj1-x231.google.com
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

On 11/26/24 13:02, Pierrick Bouvier wrote:
> @@ -266,6 +266,19 @@ static void qemu_plugin_vcpu_init__async(CPUState *cpu, run_on_cpu_data unused)
>   
>       assert(cpu->cpu_index != UNASSIGNED_CPU_INDEX);
>       qemu_rec_mutex_lock(&plugin.lock);
> +
> +    /*
> +     * We want to flush tb when a second cpu appear.
> +     * When generating plugin code, we optimize cpu_index for num_vcpus == 1.
> +     */
> +    if (plugin.num_vcpus == 1) {
> +        qemu_rec_mutex_unlock(&plugin.lock);
> +        start_exclusive();
> +        qemu_rec_mutex_lock(&plugin.lock);
> +        tb_flush(cpu);
> +        end_exclusive();
> +    }

We already did this when creating the new thread.
Though we're using slightly different tests:

         /*
          * If this is our first additional thread, we need to ensure we
          * generate code for parallel execution and flush old translations.
          * Do this now so that the copy gets CF_PARALLEL too.
          */
         if (!tcg_cflags_has(cpu, CF_PARALLEL)) {
             tcg_cflags_set(cpu, CF_PARALLEL);
             tb_flush(cpu);
         }


r~

