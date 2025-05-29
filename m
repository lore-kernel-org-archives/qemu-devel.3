Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56BE5C5AD49
	for <qemu-devel@archiver.kernel.org>; Thu, 29 May 2025 19:06:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKiZD-0000OL-Hi; Thu, 29 May 2025 15:05:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uKiZA-0000NR-5X
 for qemu-devel@nongnu.org; Thu, 29 May 2025 15:05:24 -0400
Received: from mail-pg1-x52f.google.com ([2607:f8b0:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uKiZ6-0006U8-Ud
 for qemu-devel@nongnu.org; Thu, 29 May 2025 15:05:23 -0400
Received: by mail-pg1-x52f.google.com with SMTP id
 41be03b00d2f7-b26ee6be1ecso902816a12.0
 for <qemu-devel@nongnu.org>; Thu, 29 May 2025 12:05:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748545518; x=1749150318; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=bll+2EjlBA4MSd0kWb3S0okuXrwrMzFDPYeGxWqrusk=;
 b=QopGCCF+vac9W2UQ5LuNLqbxoOXvoz6CDCmC6m3bD482SbUafnvXSNsoy7khYbn5tR
 BvP+lal8hCPSzyYTMjYt5w8ByfC3Sj9yaczW1sN1eCYRR0qiQitcoNmuyw4JlXpRd3ix
 NwZMaF3+y/Yznm5ZS6A7h7JjxI9wgCeZKVO6GgSIGXTiu7Du4xA0oQBWxOEgycI7dzly
 crC/bGisOv4N1CNMhJOA8liG6esXo9QTgzAQe3+CNa50oa8Z0qsgsO6figWZxsIA/kK8
 UywcVRcHuy3RfdA+oNAIcVJN1e9z16yKh4qWRyfP7F/ZHQB0CvOUzo45z8hEi7q/o3gQ
 rT0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748545518; x=1749150318;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=bll+2EjlBA4MSd0kWb3S0okuXrwrMzFDPYeGxWqrusk=;
 b=ah2Y27+E8WqdmaH4G48AKZKPkXBBO2GDoLErkPthoAi8UD3MAX1RfyPfSHK51yeYo+
 +adOpKu51jcMNiXEARkzQFarygNcVqko+EfM3GEeY432r24pHDnpsmgbqkPPTz8U+Qxy
 Qg8kNGhsv8dsTeV3avAo3HkbiniL522xkX/thphlgWqln/oW8DazreXchL6q9VZWrB9T
 VAG/5yJFvUbKK8V1KKlT4YnmXXPcbzb3Xds8WtfSyM2rexoBf18xJ7OYR7TnN6R/Hp7u
 4GkobjH/Wj7ttBO6rCqxVJ5PaUqvB3gIwqRArs94eYQW7Bm3FP/wzjYdpE0q1G+8qqVP
 0KVA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX1faI8zEk4GpS5dv+pbqZLVlvCS34NvBr4zLcFt4VSGfzKb2w+nVpC6waPeKfW+6BJdkTyuUesd0FK@nongnu.org
X-Gm-Message-State: AOJu0Yz4LAdFzur6GDsfSls6jEBuUcZH0ed6FfG8383p3Kp/NPH+Rd50
 iKbX0lP+B8/+F+dXYJdjZ/V57R61ZUPRZrTcsh7F4cM3VT9eLYCpa50pNiWvdZWRQ4EstWNagzU
 Hmed8o50=
X-Gm-Gg: ASbGncsk00/R+B7Tc4yp79MT7BCVv+8M2hkf08qgck9VLoiFruZ9XBLN7VMop9CfRq2
 Lr7kxYpttbsgnI1IpMEiaudxafsrUaXn3/e4UW54D5yOBijgteUAvZTUrWkjv80nwam3gmf8bbK
 igooKBpkEe1CSkoRAZ8S/QtGJynrni6kOtOSEdOsDNe2sDZhQZAC4OGa+zkltWytwiEW6v88rI3
 IG9+gGv2TBaXAnCZMzvPoBfDQiyfKHl/9Wewfws3j7ut+LEKM6kqidVJiwE/mZBSrbyApVaIYog
 CoEwjLtHqi+wb/ZvscNUVToRxFksicGk4HICRZvivvk5t9yPFrnntzneRLxepQinCqZFGk+Yzq0
 =
X-Google-Smtp-Source: AGHT+IFaGcVH+3zsLU/9N39hcjrq3HkryK1S5Pcb2+F+hH4ImFV+uga5BJ0UNisae84nFANgDAdbhw==
X-Received: by 2002:a05:6a20:7289:b0:215:eac9:1ab3 with SMTP id
 adf61e73a8af0-21ad97d9564mr1213267637.29.1748545518298; 
 Thu, 29 May 2025 12:05:18 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b2eceb29d2asm340309a12.23.2025.05.29.12.05.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 May 2025 12:05:17 -0700 (PDT)
Message-ID: <b0533c7f-2f8c-449d-ab30-159c35e321a9@linaro.org>
Date: Thu, 29 May 2025 12:05:17 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/9] plugins: Add enforcement of QEMU_PLUGIN_CB flags
 in register R/W callbacks
Content-Language: en-US
To: Rowan Hart <rowanbhart@gmail.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Mahmoud Mandour
 <ma.mandourr@gmail.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Eduardo Habkost <eduardo@habkost.net>
References: <20250523020344.1341179-1-rowanbhart@gmail.com>
 <20250523020344.1341179-4-rowanbhart@gmail.com>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250523020344.1341179-4-rowanbhart@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52f;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x52f.google.com
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

On 5/22/25 7:03 PM, Rowan Hart wrote:
> This patch adds functionality to enforce the requested QEMU_PLUGIN_CB_
> flags level passed when registering a callback function using the
> plugins API. Each time a callback is about to be invoked, a thread-local
> variable will be updated with the level that callback requested. Then,
> called API functions (in particular, the register read and write API)
> will call qemu_plugin_get_cb_flags() to check the level is at least the
> level they require.
> 
> Signed-off-by: Rowan Hart <rowanbhart@gmail.com>
> ---
>   accel/tcg/plugin-gen.c     | 27 +++++++++++++++++
>   include/qemu/plugin.h      | 12 ++++++++
>   include/qemu/qemu-plugin.h |  3 --
>   plugins/api.c              |  8 +++++
>   plugins/core.c             | 60 ++++++++++++++++++++++++++++++++++----
>   5 files changed, 101 insertions(+), 9 deletions(-)
> 
> diff --git a/accel/tcg/plugin-gen.c b/accel/tcg/plugin-gen.c
> index c1da753894..ceb2314bc1 100644
> --- a/accel/tcg/plugin-gen.c
> +++ b/accel/tcg/plugin-gen.c
> @@ -117,10 +117,19 @@ static TCGv_i32 gen_cpu_index(void)
>   static void gen_udata_cb(struct qemu_plugin_regular_cb *cb)
>   {
>       TCGv_i32 cpu_index = gen_cpu_index();
> +    enum qemu_plugin_cb_flags cb_flags =
> +        tcg_call_to_qemu_plugin_cb_flags(cb->info->flags);
> +    TCGv_i32 flags = tcg_constant_i32(cb_flags);
> +    tcg_gen_call1(qemu_plugin_set_cb_flags,
> +                    qemu_plugin_get_set_cb_flags_helper_info(), NULL,
> +                    tcgv_i32_temp(flags));
>       tcg_gen_call2(cb->f.vcpu_udata, cb->info, NULL,
>                     tcgv_i32_temp(cpu_index),
>                     tcgv_ptr_temp(tcg_constant_ptr(cb->userp)));
> +    tcg_gen_call0(qemu_plugin_clear_cb_flags,
> +                  qemu_plugin_get_clear_cb_flags_helper_info(), NULL);
>       tcg_temp_free_i32(cpu_index);
> +    tcg_temp_free_i32(flags);
>   }
>   
>   static TCGv_ptr gen_plugin_u64_ptr(qemu_plugin_u64 entry)
> @@ -173,10 +182,19 @@ static void gen_udata_cond_cb(struct qemu_plugin_conditional_cb *cb)
>       tcg_gen_ld_i64(val, ptr, 0);
>       tcg_gen_brcondi_i64(cond, val, cb->imm, after_cb);
>       TCGv_i32 cpu_index = gen_cpu_index();
> +    enum qemu_plugin_cb_flags cb_flags =
> +        tcg_call_to_qemu_plugin_cb_flags(cb->info->flags);
> +    TCGv_i32 flags = tcg_constant_i32(cb_flags);
> +    tcg_gen_call1(qemu_plugin_set_cb_flags,
> +                  qemu_plugin_get_set_cb_flags_helper_info(), NULL,
> +                  tcgv_i32_temp(flags));
>       tcg_gen_call2(cb->f.vcpu_udata, cb->info, NULL,
>                     tcgv_i32_temp(cpu_index),
>                     tcgv_ptr_temp(tcg_constant_ptr(cb->userp)));
> +     tcg_gen_call0(qemu_plugin_clear_cb_flags,
> +                  qemu_plugin_get_clear_cb_flags_helper_info(), NULL);
>       tcg_temp_free_i32(cpu_index);
> +    tcg_temp_free_i32(flags);
>       gen_set_label(after_cb);
>   
>       tcg_temp_free_i64(val);
> @@ -210,12 +228,21 @@ static void gen_mem_cb(struct qemu_plugin_regular_cb *cb,
>                          qemu_plugin_meminfo_t meminfo, TCGv_i64 addr)
>   {
>       TCGv_i32 cpu_index = gen_cpu_index();
> +    enum qemu_plugin_cb_flags cb_flags =
> +        tcg_call_to_qemu_plugin_cb_flags(cb->info->flags);
> +    TCGv_i32 flags = tcg_constant_i32(cb_flags);
> +    tcg_gen_call1(qemu_plugin_set_cb_flags,
> +                  qemu_plugin_get_set_cb_flags_helper_info(), NULL,
> +                  tcgv_i32_temp(flags));
>       tcg_gen_call4(cb->f.vcpu_mem, cb->info, NULL,
>                     tcgv_i32_temp(cpu_index),
>                     tcgv_i32_temp(tcg_constant_i32(meminfo)),
>                     tcgv_i64_temp(addr),
>                     tcgv_ptr_temp(tcg_constant_ptr(cb->userp)));
> +    tcg_gen_call0(qemu_plugin_clear_cb_flags,
> +                  qemu_plugin_get_clear_cb_flags_helper_info(), NULL);
>       tcg_temp_free_i32(cpu_index);
> +    tcg_temp_free_i32(flags);
>   }
>   
>   static void inject_cb(struct qemu_plugin_dyn_cb *cb)
> diff --git a/include/qemu/plugin.h b/include/qemu/plugin.h
> index 9726a9ebf3..f312cc1a72 100644
> --- a/include/qemu/plugin.h
> +++ b/include/qemu/plugin.h
> @@ -209,6 +209,18 @@ void qemu_plugin_user_prefork_lock(void);
>    */
>   void qemu_plugin_user_postfork(bool is_child);
>   
> +enum qemu_plugin_cb_flags tcg_call_to_qemu_plugin_cb_flags(int flags);
> +
> +void qemu_plugin_set_cb_flags(enum qemu_plugin_cb_flags flags);
> +
> +enum qemu_plugin_cb_flags qemu_plugin_get_cb_flags(void);
> +
> +void qemu_plugin_clear_cb_flags(void);
> +
> +TCGHelperInfo *qemu_plugin_get_set_cb_flags_helper_info(void);
> +
> +TCGHelperInfo *qemu_plugin_get_clear_cb_flags_helper_info(void);
> +
>   #else /* !CONFIG_PLUGIN */
>   
>   static inline void qemu_plugin_add_opts(void)
> diff --git a/include/qemu/qemu-plugin.h b/include/qemu/qemu-plugin.h
> index cfe1692ecb..120fb626a6 100644
> --- a/include/qemu/qemu-plugin.h
> +++ b/include/qemu/qemu-plugin.h
> @@ -254,9 +254,6 @@ typedef struct {
>    * @QEMU_PLUGIN_CB_NO_REGS: callback does not access the CPU's regs
>    * @QEMU_PLUGIN_CB_R_REGS: callback reads the CPU's regs
>    * @QEMU_PLUGIN_CB_RW_REGS: callback reads and writes the CPU's regs
> - *
> - * Note: currently QEMU_PLUGIN_CB_RW_REGS is unused, plugins cannot change
> - * system register state.
>    */
>   enum qemu_plugin_cb_flags {
>       QEMU_PLUGIN_CB_NO_REGS,
> diff --git a/plugins/api.c b/plugins/api.c
> index 3a7add50d2..16141f5c25 100644
> --- a/plugins/api.c
> +++ b/plugins/api.c
> @@ -437,6 +437,10 @@ int qemu_plugin_read_register(struct qemu_plugin_register *reg, GByteArray *buf)
>   {
>       g_assert(current_cpu);
>   
> +    if (qemu_plugin_get_cb_flags() == QEMU_PLUGIN_CB_NO_REGS) {
> +        return -1;
> +    }
> +
>       return gdb_read_register(current_cpu, buf, GPOINTER_TO_INT(reg) - 1);
>   }
>   
> @@ -445,6 +449,10 @@ int qemu_plugin_write_register(struct qemu_plugin_register *reg,
>   {
>       g_assert(current_cpu);
>   
> +    if (buf->len == 0 || qemu_plugin_get_cb_flags() != QEMU_PLUGIN_CB_RW_REGS) {
> +        return 0;
> +    }
> +
>       return gdb_write_register(current_cpu, buf->data, GPOINTER_TO_INT(reg) - 1);
>   }
>   
> diff --git a/plugins/core.c b/plugins/core.c
> index eb9281fe54..0ebde1fb87 100644
> --- a/plugins/core.c
> +++ b/plugins/core.c
> @@ -30,6 +30,9 @@ struct qemu_plugin_cb {
>   };
>   
>   struct qemu_plugin_state plugin;
> +static __thread enum qemu_plugin_cb_flags call_cb_flags;
> +static TCGHelperInfo qemu_plugin_set_cb_flags_helper;
> +static TCGHelperInfo qemu_plugin_clear_cb_flags_helper;
>   
>   struct qemu_plugin_ctx *plugin_id_to_ctx_locked(qemu_plugin_id_t id)
>   {
> @@ -364,14 +367,15 @@ void plugin_register_dyn_cb__udata(GArray **arr,
>                                      enum qemu_plugin_cb_flags flags,
>                                      void *udata)
>   {
> -    static TCGHelperInfo info[3] = {
> +    static TCGHelperInfo info[4] = {
>           [QEMU_PLUGIN_CB_NO_REGS].flags = TCG_CALL_NO_RWG,
>           [QEMU_PLUGIN_CB_R_REGS].flags = TCG_CALL_NO_WG,
> +        [QEMU_PLUGIN_CB_RW_REGS].flags = 0,
>           /*
>            * Match qemu_plugin_vcpu_udata_cb_t:
>            *   void (*)(uint32_t, void *)
>            */
> -        [0 ... 2].typemask = (dh_typemask(void, 0) |
> +        [0 ... 3].typemask = (dh_typemask(void, 0) |
>                                 dh_typemask(i32, 1) |
>                                 dh_typemask(ptr, 2))
>       };
> @@ -393,14 +397,15 @@ void plugin_register_dyn_cond_cb__udata(GArray **arr,
>                                           uint64_t imm,
>                                           void *udata)
>   {
> -    static TCGHelperInfo info[3] = {
> +    static TCGHelperInfo info[4] = {
>           [QEMU_PLUGIN_CB_NO_REGS].flags = TCG_CALL_NO_RWG,
>           [QEMU_PLUGIN_CB_R_REGS].flags = TCG_CALL_NO_WG,
> +        [QEMU_PLUGIN_CB_RW_REGS].flags = 0,
>           /*
>            * Match qemu_plugin_vcpu_udata_cb_t:
>            *   void (*)(uint32_t, void *)
>            */
> -        [0 ... 2].typemask = (dh_typemask(void, 0) |
> +        [0 ... 3].typemask = (dh_typemask(void, 0) |
>                                 dh_typemask(i32, 1) |
>                                 dh_typemask(ptr, 2))
>       };
> @@ -431,14 +436,15 @@ void plugin_register_vcpu_mem_cb(GArray **arr,
>           !__builtin_types_compatible_p(qemu_plugin_meminfo_t, uint32_t) &&
>           !__builtin_types_compatible_p(qemu_plugin_meminfo_t, int32_t));
>   
> -    static TCGHelperInfo info[3] = {
> +    static TCGHelperInfo info[4] = {
>           [QEMU_PLUGIN_CB_NO_REGS].flags = TCG_CALL_NO_RWG,
>           [QEMU_PLUGIN_CB_R_REGS].flags = TCG_CALL_NO_WG,
> +        [QEMU_PLUGIN_CB_RW_REGS].flags = 0,
>           /*
>            * Match qemu_plugin_vcpu_mem_cb_t:
>            *   void (*)(uint32_t, qemu_plugin_meminfo_t, uint64_t, void *)
>            */
> -        [0 ... 2].typemask =
> +        [0 ... 3].typemask =
>               (dh_typemask(void, 0) |
>                dh_typemask(i32, 1) |
>                (__builtin_types_compatible_p(qemu_plugin_meminfo_t, uint32_t)
> @@ -730,6 +736,11 @@ static void __attribute__((__constructor__)) plugin_init(void)
>       qht_init(&plugin.dyn_cb_arr_ht, plugin_dyn_cb_arr_cmp, 16,
>                QHT_MODE_AUTO_RESIZE);
>       atexit(qemu_plugin_atexit_cb);
> +    qemu_plugin_set_cb_flags_helper.flags = 0;
> +    qemu_plugin_set_cb_flags_helper.typemask = (dh_typemask(void, 0) |
> +                                               dh_typemask(i32, 1));
> +    qemu_plugin_clear_cb_flags_helper.flags = 0;
> +    qemu_plugin_clear_cb_flags_helper.typemask = dh_typemask(void, 0);
>   }
>   
>   int plugin_num_vcpus(void)
> @@ -760,3 +771,40 @@ void plugin_scoreboard_free(struct qemu_plugin_scoreboard *score)
>       g_array_free(score->data, TRUE);
>       g_free(score);
>   }
> +
> +enum qemu_plugin_cb_flags tcg_call_to_qemu_plugin_cb_flags(int flags)
> +{
> +    if (flags & TCG_CALL_NO_RWG) {
> +        return QEMU_PLUGIN_CB_NO_REGS;
> +    } else if (flags & TCG_CALL_NO_WG) {
> +        return QEMU_PLUGIN_CB_R_REGS;
> +    } else {
> +        return QEMU_PLUGIN_CB_RW_REGS;
> +    }
> +}
> +
> +void qemu_plugin_set_cb_flags(enum qemu_plugin_cb_flags flags)
> +{
> +    call_cb_flags = flags;
> +}
> +
> +enum qemu_plugin_cb_flags qemu_plugin_get_cb_flags(void)
> +{
> +    return call_cb_flags;
> +}
> +
> +void qemu_plugin_clear_cb_flags(void)
> +{
> +    call_cb_flags = QEMU_PLUGIN_CB_NO_REGS;
> +}
> +
> +
> +TCGHelperInfo *qemu_plugin_get_set_cb_flags_helper_info(void)
> +{
> +    return &qemu_plugin_set_cb_flags_helper;
> +}
> +
> +TCGHelperInfo *qemu_plugin_get_clear_cb_flags_helper_info(void)
> +{
> +    return &qemu_plugin_clear_cb_flags_helper;
> +}

The overall approach is good. The only other alternative I see is having 
an opaque handle passed to callbacks, but I don't think it's a good way 
to solve this. So storing flags before and cleaning after callbacks is 
the way to go.

It would be more efficient to generate a store directly, and keep the 
qemu_plugin_cb_flags directly in CPUNegativeOffsetState, as we know this 
will be used only in context of current cpu.
See plugin_mem_value_{low, high} which use this already.

Thanks,
Pierrick

