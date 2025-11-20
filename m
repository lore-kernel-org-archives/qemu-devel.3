Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 938A8CF9C72
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Nov 2025 17:21:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vM8LA-0005eB-O2; Thu, 20 Nov 2025 12:21:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vM8L7-0005dE-MA
 for qemu-devel@nongnu.org; Thu, 20 Nov 2025 12:21:01 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vM8L5-0006HX-1U
 for qemu-devel@nongnu.org; Thu, 20 Nov 2025 12:21:01 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4779cc419b2so12980525e9.3
 for <qemu-devel@nongnu.org>; Thu, 20 Nov 2025 09:20:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763659257; x=1764264057; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=q6TvOqDM2qkI0tVpIlqonr3Ftv0tedG6CrCwpsmN5v0=;
 b=zkVEQdGG5y7PIW+k20gcoZaRe0oYBaZNp/BlgtcxHQgnLEw4tUAF+j/JFfiew0wdbL
 vuGH+5kYmlf4V8lP5Kqex/2JuyltRn2n0yyhbvBkhRg7gRQJKlLLnAK52js9RpNEpA29
 v7fkzl4CbZES9iN/RhQe3+G1oCXeSoi1STbTAmlpsX5uDotShaUHeRP+c4czrA2fh5/B
 hjEJr/nBla5PiDHfgGJer3K99niglDgmXsZ+kaVUuo2lVABanLc+T9pyLV/JDrlNgpDb
 Rogm4krkJ8AtpfXDbs3O9EgJBM/q+9f8pXM8bUM6lSOMtb5tq0+0SUNHf8q9cdJy3FBp
 st1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763659257; x=1764264057;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=q6TvOqDM2qkI0tVpIlqonr3Ftv0tedG6CrCwpsmN5v0=;
 b=EpjrDL34uZttfjFHbgmFzhOxBj9ESzW5x1p36Oe1vwmy8P4vzcYej60pIReNKdw4ru
 LHKrtBKn+f0PRpNg8tju5WRXwNJPkyGf4DPORoJ2GZXYzU3lDim51/iDJpKm7YQWECkY
 oGecW6szk2QA/g2i9rcureuOs1zx2WS+vJwS4iHYgFjOJoEctZhYaCP3cBu7PbnW6dp+
 MtHrpoI1qKljyfroQbzfvhtHNGL0xU1rG7HaFwYu1XbBrteVFHVS/JmRkUidGDcDAlb/
 Q5Q6VRqXRCgDZutKUX+erEcC+xxPITP4kd7W/2no83Fz/+O/X3cFiyVlcERIOrVYztZS
 BR+Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUTMOuF6aitLpGwAc+X1Zid+hGKtZHAYqMS4cG5utLKdpTJP1oQ7YlnMJ4IysChUf71L25ayMVuxCjh@nongnu.org
X-Gm-Message-State: AOJu0Yyxf4zgjs6W9suGWyjvXPmn7Qsgsx89CiNBHNh37ExdMGOxWu0h
 qGhv9xU/FFHul40KsVpHlQ7CphdN+6Q0XTnm9lnXah7AFCArirlNcHcx47hNAI2SK/A=
X-Gm-Gg: ASbGncvh8E2edZvck/yVPTL/F6Fv9Nzl/n/0Csm5ijLT7ffxEcAQgtIbVAmvbHBa6Cf
 SeY/pV1kZHn+MQPLLC4VtbkNJecHgLeEtO0ZZA7LgryOo9RWfb3Cs2NAroneoBbuVe4nChzsqae
 MnMc2NwCJKa7BCQZAbAehYhHKOm1Ox8VjUwnh844bIkXavUxM4IdGqMmTsGXyGzEH73hIjvfrMI
 njJGhoY+c6aKpuG15IWfV6nAOsOld2epS9aRHyY9UQbqm5d+2iNA+EkYn2JAeSu6IIU80PgR99g
 zaccSnXt9VILQLtP3lhhI2oztXIAQT70SYlxW53dQJP91bi1OWejJtbOd5qU1T6ijHffBP21KcZ
 GqgJ26Xne/RINL5+4gxJvoFFHItVtE1eNd5m6P21I94LktHPbmY3uGT9hlQKbS4gnsZ/CdnBb8a
 KNuYQid/2umxHqzpUo0I/6nWGM/o3dsJIPYxEZVU0mxOo6VgDdzYuooA==
X-Google-Smtp-Source: AGHT+IGuoMSLfDsNNzAwItK/fbBTbVjtBwVNjNVJDcsw3iAKbMOUQriOtLUJIO0etHeu4ITn86dgbQ==
X-Received: by 2002:a5d:588d:0:b0:42b:2eb3:c90f with SMTP id
 ffacd0b85a97d-42cb9a11814mr3342433f8f.10.1763659256775; 
 Thu, 20 Nov 2025 09:20:56 -0800 (PST)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42cb7fb8a29sm6511463f8f.30.2025.11.20.09.20.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Nov 2025 09:20:56 -0800 (PST)
Message-ID: <350863e7-19eb-4c7e-8b33-c4f7956ead4b@linaro.org>
Date: Thu, 20 Nov 2025 18:20:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 8/9] target/riscv: RISCVCPUTimeSrcIf: add
 register_time_change_notifier
Content-Language: en-US
To: Luc Michel <luc.michel@amd.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li
 <liwei1518@gmail.com>, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Francisco Iglesias <francisco.iglesias@amd.com>
References: <20251107102340.471141-1-luc.michel@amd.com>
 <20251107102340.471141-9-luc.michel@amd.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251107102340.471141-9-luc.michel@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

On 7/11/25 11:23, Luc Michel wrote:
> Add the register_time_change_notifier method to the RISCVCPUTimeSrcIf
> interface. This method allows the time source user to register a
> notifier on tick counter asynchronous modification (i.e., a modification
> that is not due to the monotonic nature of the counter). This can happen
> if the time source counter is writable, which is the case of the `time'
> register of the ACLINT.
> 
> Use this mechanism in time_helper.c to recompute the sstc timers
> deadlines.
> 
> Signed-off-by: Luc Michel <luc.michel@amd.com>
> ---
>   target/riscv/cpu-qom.h     |  7 +++++++
>   target/riscv/cpu.h         |  1 +
>   target/riscv/time_helper.h | 11 +++++++++++
>   target/riscv/time_helper.c | 13 +++++++++++++
>   4 files changed, 32 insertions(+)


> diff --git a/target/riscv/time_helper.h b/target/riscv/time_helper.h
> index b51fdd96570..074b516f4ad 100644
> --- a/target/riscv/time_helper.h
> +++ b/target/riscv/time_helper.h
> @@ -42,6 +42,17 @@ static inline uint32_t riscv_cpu_time_src_get_tick_freq(RISCVCPUTimeSrcIf *src)
>   
>       g_assert(rctsc->get_tick_freq != NULL);
>       return rctsc->get_tick_freq(src);
>   }
>   
> +static inline void
> +riscv_cpu_time_src_register_time_change_notifier(RISCVCPUTimeSrcIf *src,
> +                                                 Notifier *notifier)
> +{
> +    RISCVCPUTimeSrcIfClass *rctsc = RISCV_CPU_TIME_SRC_IF_GET_CLASS(src);
> +
> +    if (rctsc->register_time_change_notifier) {
> +        rctsc->register_time_change_notifier(src, notifier);
> +    }

What about some trace event to help developers? I.e.:

    if (!rctsc->register_time_change_notifier) {
        trace_riscv_cpu_time_src_register_time_change_without_notifier();
        return;
    }
    rctsc->register_time_change_notifier(src, notifier);

> +}

Anyhow:
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


