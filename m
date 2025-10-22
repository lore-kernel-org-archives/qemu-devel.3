Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7698CCD1BB
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Oct 2025 16:02:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBbGw-0007oD-GJ; Wed, 22 Oct 2025 12:01:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vBbGL-0007YN-37
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 12:00:33 -0400
Received: from mail-oo1-xc31.google.com ([2607:f8b0:4864:20::c31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vBbGF-0007Xt-74
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 12:00:29 -0400
Received: by mail-oo1-xc31.google.com with SMTP id
 006d021491bc7-651d30a5bebso2640470eaf.3
 for <qemu-devel@nongnu.org>; Wed, 22 Oct 2025 09:00:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761148824; x=1761753624; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=uZFpm1mhce9VWI9tRX2Eurx2U4rHFRrKSWEn0O9vcmo=;
 b=mAnydgIkfhPNmsesSW1J7cCQjdxLCgKe5hUSso6ub39OAlbj+fGLuoG3SqIuFlihIy
 5np+rl27D7yu0JF45Y6rhknc9HnBlcMK8ijN48XBoD+33KKfl6heoLy6RnbM16ThnU2M
 aG0h5gXs5vwt0xxEgZAmjLdG3ftMI+pK/Oc21dU90VmtLb5X6pZKuvsJg0xbp1xfnb5W
 3sNAWYusiAafX9PA/sS4mSBKffKl3sB04N9CyW3L1AFH3QDzHa0Esd9ckBbcoUnbiDMj
 OY1bzNHk1F8SF5ZUSwYIV01UtU3gvK8YNz3BHiYeHihFpb7ayWG2wR00idLdK3n0nPD1
 Fdwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761148824; x=1761753624;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=uZFpm1mhce9VWI9tRX2Eurx2U4rHFRrKSWEn0O9vcmo=;
 b=cFvWTcDFnJzCF76b0f8LV53WUrd23FFfzzncfZmu0cuLNLcAJJZE6tJ8NAx1jgI5Ys
 nZNgjVCo5pJUQUNdY1QJge2wZsHPDojeVmu3VDMacHMOWgn0XGq8VxNDB+3MgVxUMiQl
 CcQ42XM6LUbFac9KeFKq1UMW2oo7RkuN6UOgn5mnn3JFj3bAWWNmMswyosrPOkl5s4AH
 Q99yCxY6uq85Po6niJEGPjzMUd3QUQEkIQ7iWMZaULBughEbxzio2V4u/fX2LDocChZy
 upcjGeAo2qoy70ozE2RZMoKEdk8YlxZVpu0cRA9vp/KOe7Duig7CYEUEzWr7u0eMSWWB
 bPUw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWAloyR1GE2omEpI1ScGgw+kn8KV9+KsfPhXIrpD7pmEHiCQ4GnQOq80uLfyDF0xD/vs1jC4sXNheGX@nongnu.org
X-Gm-Message-State: AOJu0YwnKMl7BImTS2Lkg6RwRtqWbiiKjI5YHl9jmsFW3EZoKU9zgs6O
 +YiMvUTjnOu99mkU9f+kOCaL/eUuooxbr+9T0eLHfQobDipMr16hau+N6wZOLMu+Klo=
X-Gm-Gg: ASbGncsuG9PBHGOQmLxTUZ5+JYz9xWMkY541vP+0lG3KNBhrB60PvCPzGRtnffxalVs
 mrKGct3Z80tLEU4eCY+adyhAsYB/Nxfj1rVVy+g2/DtTzdFOFK55WddJIyLV//lVY+hwifiQoq8
 J6YDLWQvEifPJh9v4cFKixyj22Rl1VxNk61WL5Zz7e60yWkHS01+pBPCxF/TYfikMcE1OlgzOkR
 WFTRNRX+wp8tRIr1AzjGuUzbByGWGIrbpkXqOj8yxQk9FbYjTV5VpWpML2OC0OuqOlwH3Ri1Jbm
 OViDgzVxeYr7pcJiKCGlkqFsU/CmNQqUO7ivoOylfuJ8V6aGvpEMHOsWQJ/OEXf3BQ1dcm8CdZs
 fk5Ncxmw05f13SFQoxYlXuxEksfn/VKA8PU+9JqxKqwORo4SFbp4Jfq2dkKi+sVj1oxxyLt3ePR
 CqtwFazA48Y9euuhz8
X-Google-Smtp-Source: AGHT+IE/y0W8NiTvw0sjPwAATiLH5nKorZeI5wzRsIT4hbN89Cc8ltZ/iH5i6zBiia3rmG/7PwslRA==
X-Received: by 2002:a05:6870:959a:b0:3c1:68a1:6b10 with SMTP id
 586e51a60fabf-3c98cf25491mr8884858fac.6.1761148824324; 
 Wed, 22 Oct 2025 09:00:24 -0700 (PDT)
Received: from [10.128.41.227] ([50.194.179.134])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3cd7ee715d6sm2080815fac.26.2025.10.22.09.00.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 22 Oct 2025 09:00:23 -0700 (PDT)
Message-ID: <80029288-4571-4e5a-ab99-b3c5c8daf8b6@linaro.org>
Date: Wed, 22 Oct 2025 11:00:20 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH V2 1/2] linux-user: add a plugin API to filter syscalls
To: Ziyang Zhang <functioner@sjtu.edu.cn>, qemu-devel <qemu-devel@nongnu.org>
Cc: Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>,
 alex bennee <alex.bennee@linaro.org>, Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Zhengwei Qi <qizhwei@sjtu.edu.cn>, Yun Wang <yunwang94@sjtu.edu.cn>,
 Mingyuan Xia <xiamy@ultrarisc.com>, Kailiang Xu <xukl2019@sjtu.edu.cn>
References: <1341969682.5812455.1761115945695.JavaMail.zimbra@sjtu.edu.cn>
 <1236223604.5812631.1761116021855.JavaMail.zimbra@sjtu.edu.cn>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <1236223604.5812631.1761116021855.JavaMail.zimbra@sjtu.edu.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c31;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc31.google.com
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

On 10/22/25 01:53, Ziyang Zhang wrote:
> @@ -165,6 +166,10 @@ qemu_plugin_vcpu_syscall(CPUState *cpu, int64_t num, uint64_t a1,
>                            uint64_t a2, uint64_t a3, uint64_t a4, uint64_t a5,
>                            uint64_t a6, uint64_t a7, uint64_t a8);
>   void qemu_plugin_vcpu_syscall_ret(CPUState *cpu, int64_t num, int64_t ret);
> +bool
> +qemu_plugin_vcpu_syscall_filter(CPUState *cpu, int64_t num, uint64_t a1,
> +                         uint64_t a2, uint64_t a3, uint64_t a4, uint64_t a5,
> +                         uint64_t a6, uint64_t a7, uint64_t a8, uint64_t *ret);

The second and third lines should indented just past the ( on the first line, i.e. with 
CPUState.

> +static inline bool
> +qemu_plugin_vcpu_syscall_filter(CPUState *cpu, int64_t num, uint64_t a1,
> +                                uint64_t a2, uint64_t a3, uint64_t a4,
> +                                uint64_t a5, uint64_t a6, uint64_t a7,
> +                                uint64_t a8, uint64_t *ret)

Like this.

> +typedef bool
> +(*qemu_plugin_vcpu_syscall_filter_cb_t)(qemu_plugin_id_t id,
> +                                unsigned int vcpu_index,
> +                                int64_t num, uint64_t a1, uint64_t a2,
> +                                uint64_t a3, uint64_t a4, uint64_t a5,
> +                                uint64_t a6, uint64_t a7, uint64_t a8,
> +                                uint64_t *ret);

Likewise.

> +static inline bool send_through_syscall_filters(CPUState *cpu, int num,
> +                                  abi_long arg1, abi_long arg2,
> +                                  abi_long arg3, abi_long arg4,
> +                                  abi_long arg5, abi_long arg6,
> +                                  abi_long arg7, abi_long arg8, abi_long *ret)

Do not mark inline; let the compiler decide.

> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index d78b2029fa..b8225f838f 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -14084,8 +14084,11 @@ abi_long do_syscall(CPUArchState *cpu_env, int num, abi_long arg1,
>           print_syscall(cpu_env, num, arg1, arg2, arg3, arg4, arg5, arg6);
>       }
>   
> -    ret = do_syscall1(cpu_env, num, arg1, arg2, arg3, arg4,
> -                      arg5, arg6, arg7, arg8);
> +    if (!send_through_syscall_filters(cpu, num, arg1, arg2, arg3, arg4, arg5,
> +        arg6, arg7, arg8, &ret)) {

Incorrect indent.

> +        ret = do_syscall1(cpu_env, num, arg1, arg2, arg3, arg4,
> +                        arg5, arg6, arg7, arg8);

Likewise.

> diff --git a/plugins/core.c b/plugins/core.c
> index ead09fd2f1..1b2f875fb1 100644
> --- a/plugins/core.c
> +++ b/plugins/core.c
> @@ -538,6 +538,40 @@ void qemu_plugin_vcpu_syscall_ret(CPUState *cpu, int64_t num, int64_t ret)
>       }
>   }
>   
> +/*
> + * Disable CFI checks.
> + * The callback function has been loaded from an external library so we do not
> + * have type information
> + */
> +QEMU_DISABLE_CFI
> +bool
> +qemu_plugin_vcpu_syscall_filter(CPUState *cpu, int64_t num, uint64_t a1,
> +                         uint64_t a2, uint64_t a3, uint64_t a4, uint64_t a5,
> +                         uint64_t a6, uint64_t a7, uint64_t a8, uint64_t *ret)

Likewise.

> +{
> +    struct qemu_plugin_cb *cb, *next;
> +    enum qemu_plugin_event ev = QEMU_PLUGIN_EV_VCPU_SYSCALL_FILTER;
> +
> +    if (!test_bit(ev, cpu->plugin_state->event_mask)) {
> +        return false;
> +    }
> +
> +    bool filtered = false;
> +    QLIST_FOREACH_SAFE_RCU(cb, &plugin.cb_lists[ev], entry, next) {
> +        qemu_plugin_vcpu_syscall_filter_cb_t func = cb->f.vcpu_syscall_filter;
> +
> +        qemu_plugin_set_cb_flags(cpu, QEMU_PLUGIN_CB_RW_REGS);
> +        if (func(cb->ctx->id, cpu->cpu_index, num, a1, a2, a3, a4,
> +            a5, a6, a7, a8, ret)) {
> +            filtered = true;
> +            qemu_plugin_set_cb_flags(cpu, QEMU_PLUGIN_CB_NO_REGS);
> +            break;
> +        }
> +        qemu_plugin_set_cb_flags(cpu, QEMU_PLUGIN_CB_NO_REGS);
> +    }
> +    return filtered;
> +}

The loop is better written

     QLIST_FOREACH_SAFE_RCU(cb, &plugin.cb_lists[ev], entry, next) {
         bool filtered;

         qemu_plugin_set_cb_flags(cpu, QEMU_PLUGIN_CB_RW_REGS);
         filtered = cb->f.vcpu_syscall_filter(cb->ctx->id, cpu->cpu_index,
                                              num, a1, a2, a3, a4, a5,
                                              a6, a7, a8, ret);
         qemu_plugin_set_cb_flags(cpu, QEMU_PLUGIN_CB_NO_REGS);

         if (filtered) {
             return true;
         }
     }
     return false;


r~

