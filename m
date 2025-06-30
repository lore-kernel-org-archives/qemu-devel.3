Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB8E7C8302D
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Jun 2025 11:52:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWD2T-0006p0-Si; Mon, 30 Jun 2025 07:51:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1uWD2S-0006od-86
 for qemu-devel@nongnu.org; Mon, 30 Jun 2025 07:51:08 -0400
Received: from mail-qt1-x831.google.com ([2607:f8b0:4864:20::831])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1uWD2Q-00086Y-22
 for qemu-devel@nongnu.org; Mon, 30 Jun 2025 07:51:08 -0400
Received: by mail-qt1-x831.google.com with SMTP id
 d75a77b69052e-4a7f61ea32aso79445471cf.3
 for <qemu-devel@nongnu.org>; Mon, 30 Jun 2025 04:51:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1751284263; x=1751889063; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=3RzLEaOXHmqUWkuQ3zmz/OCZ3SVN88BhJM0B53/UOLw=;
 b=AesiSkUGILUNdKTCdv2R8Yipqp0vHz2SUzlO4J0VQ/jB0Uf4p3qNrL0odEM2tdeDOP
 mKO0G/8uld1Z1CB+JN/9YFxsH0abkO8u6Pf/M6pgrkzsJZvdVNzT5gCtP6Cp0aekIe6m
 pQ4XwmWEKIWjsbN1cCTAl1G9/snsKofUVYX96AggeDOuib+6cmFmqRL/kwNxJRJTrMnf
 LqkDKTbAjiWzAkeKd4W4yzpQImLqtE+PYcNs1n2Re201tSOxfFxdywHdCkWo606D4cE6
 +fxp/5ojQyQHXk/iX0FMfHtncAyJVQ18+XHzwbmznOcaU6lAzLAZhyN7tlfVgBlz9HwC
 379Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751284263; x=1751889063;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3RzLEaOXHmqUWkuQ3zmz/OCZ3SVN88BhJM0B53/UOLw=;
 b=Dy1W3ksbjirzWJaZjsZ2s24q0JH+8CLsBOqkKjqPN5JfN4rcBu6d3RshYg6Jo5KwG3
 M8Zkm4WRCZauxJsKwORFgW6xqiIZ09f0QxAcE66R13xSjm1eL+GQCC6f4ziv2TprfJJE
 kGkUeYZJflDBVO3rKI5QaHaGaEblykB0cdj40EqGkRNECKLSPsZb3aImhsLBnHFzUpHw
 K5i9c6f2B0qeGcWtCQXZwmgReThz5CYfAtPvF2vBrvPpI6KY8Yz5bEr+t7AKDlFTh9ZU
 BYtFqtNtz5ZNDR0Wmwg21QMsERqzdc6aNtqWb/2hGlQcUqry9UNFu8GhszDLt9gerhfc
 gNaQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWAsjhc5/zHElloNQM/AEnTah+JvLJMZa0gzqcsYOFLEU3tT0Io+g+piOKrs5/S2ozvxFxSvSy/jzVS@nongnu.org
X-Gm-Message-State: AOJu0YwI05KezJCXT3lksWlau/zwH+uLhkjqn0GkklWu6OPnKYAaN4md
 CmlrKM8yesicXHOEcZk65kSMAveNI5V/GOjD7V67xj5iiVtmNdJtXVgo7k29Y5/lIIE=
X-Gm-Gg: ASbGnctM/gpuuFOttaYqG5FCduSioVYg2tpO6OVuOPBeC5nxo//Gi62rGFmk2huqgcZ
 ydZS2K5YB4jCvW/CG+YHZsLZ/DWi1iTJ9mqQcoyO5ZzAYiPU5PW9k+HnXxSNsnwPSpSHxTEdCmO
 xQ1QBQws08XugEgTHmOO24TUJaAzN7LeH0rqZortytyxr3ETtuhP5oJ5ATeSYvdAwSm1CHq5zSk
 43yNUqSbNCGWN2BYi97q4csUJUhhv+ri7jQcz5Jrrkx1IqU4BcBxHfDjD4vEvxkG167hNopAOyK
 11xN8g4wqK5c9B5yFF7CTqqny4w7xCD9lONsa4DOt94wyfk6OD0XzPrKyUDvkpaB92z63ZoHL48
 =
X-Google-Smtp-Source: AGHT+IGJrDBNwrqFd706CH0KhcFMn/UT9+yb9CNIRfGhIdoN21cJoz/IVxaSBMdE5Emq79PzMfLGLw==
X-Received: by 2002:a05:622a:296:b0:4a6:f6e6:7693 with SMTP id
 d75a77b69052e-4a7fc9d8522mr193028571cf.6.1751284263134; 
 Mon, 30 Jun 2025 04:51:03 -0700 (PDT)
Received: from [192.168.68.110] ([179.93.20.232])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4a7fc55c396sm57333521cf.50.2025.06.30.04.51.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 30 Jun 2025 04:51:02 -0700 (PDT)
Message-ID: <dc3ca3fd-1159-4186-acbf-ddd38276c33c@ventanamicro.com>
Date: Mon, 30 Jun 2025 08:50:58 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 02/11] target/riscv: Add cpu_set_exception_base
To: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>,
 "cfu@mips.com" <cfu@mips.com>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>
References: <20250625141732.59084-1-djordje.todorovic@htecgroup.com>
 <20250625141732.59084-3-djordje.todorovic@htecgroup.com>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20250625141732.59084-3-djordje.todorovic@htecgroup.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::831;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-qt1-x831.google.com
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



On 6/25/25 11:18 AM, Djordje Todorovic wrote:
> Add a new function, so we can change reset vector from platforms
> during runtime.
> 
> Signed-off-by: Chao-ying Fu <cfu@mips.com>
> Signed-off-by: Djordje Todorovic <djordje.todorovic@htecgroup.com>
> ---
>   target/riscv/cpu.h       | 4 ++++
>   target/riscv/translate.c | 8 ++++++++
>   2 files changed, 12 insertions(+)
> 
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index 229ade9ed9..fba0b0506b 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -656,6 +656,10 @@ G_NORETURN void riscv_raise_exception(CPURISCVState *env,
>   target_ulong riscv_cpu_get_fflags(CPURISCVState *env);
>   void riscv_cpu_set_fflags(CPURISCVState *env, target_ulong);
>   
> +#ifndef CONFIG_USER_ONLY
> +void cpu_set_exception_base(int vp_index, target_ulong address);
> +#endif
> +
>   FIELD(TB_FLAGS, MEM_IDX, 0, 3)
>   FIELD(TB_FLAGS, FS, 3, 2)
>   /* Vector flags */
> diff --git a/target/riscv/translate.c b/target/riscv/translate.c
> index d7a6de02df..c3fbae7cfe 100644
> --- a/target/riscv/translate.c
> +++ b/target/riscv/translate.c
> @@ -1427,3 +1427,11 @@ void riscv_translate_init(void)
>       load_val = tcg_global_mem_new(tcg_env, offsetof(CPURISCVState, load_val),
>                                "load_val");
>   }
> +
> +#ifndef CONFIG_USER_ONLY
> +void cpu_set_exception_base(int vp_index, target_ulong address)
> +{
> +    RISCVCPU *vp = RISCV_CPU(qemu_get_cpu(vp_index));
> +    vp->env.resetvec = address;
> +}

Sorry to not noticing this in v3 but I don't think this code belongs here. There's
no translation related code being done. This code is better placed in
target/riscv/cpu.c.

Also, qemu_get_cpu() can return NULL. Given that you handled the NULL cases in patch 1
to support sparse IDs I believe it would be consistent to do the same here for
the sake of future users of this API.


Thanks,

Daniel

> +#endif


