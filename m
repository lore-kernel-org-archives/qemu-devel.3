Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54D1BE8B397
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 04:37:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnUdw-00075l-Bb; Tue, 03 Feb 2026 23:37:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vnUdv-00075L-59
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 23:37:31 -0500
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vnUdt-0007XU-Jo
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 23:37:30 -0500
Received: by mail-pf1-x444.google.com with SMTP id
 d2e1a72fcca58-8230d228372so202850b3a.1
 for <qemu-devel@nongnu.org>; Tue, 03 Feb 2026 20:37:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770179847; x=1770784647; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=2WretFc+MWXwy612rL1TXzUrvnw1/LpQEDQv8YM/MSM=;
 b=QuH1kJf5BlZ0YFy0drEkYT9n2/lg4h4aTJXRCBr6qIVK4+mQJbhaU2rogL1zjPHoBv
 l33Y72K6ld0sGgCMqIkfx9+oWPFqvCiJfkV30ooqRN1rmephBf9zDzexlJTiUSIgIgZl
 zFk28RbgRBePlpCXXuy1gOlRFa3wxs80VJEKwPLXPyjxrGvT1w+bKPQVpteaMksBk1Xz
 MZn3YZTvFyoVS51pCkPSrR2XhngZ3C5wFVnu1/snkRPpEpxi+PHwn/1xXuoWRGH9ce21
 lyPmhnnNGjp9hG/ROw7fyRf3naJugC4uVuKwKrGiI9nmkOux2WQBgEP6Qw6zF7icq3gi
 g84w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770179847; x=1770784647;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2WretFc+MWXwy612rL1TXzUrvnw1/LpQEDQv8YM/MSM=;
 b=gqPvrP1FkXRl9x+5XjyDkV3dClk+trmVJH9uhoRFYnZrBFsA9lOGyHjXH8nYnUi4X9
 Uhwxm1Poh8e7ROAbWuvf3lGHkniV+9QS/5ueJGA0wEYABaj0+OfqqidlkSYZPVJtgLJj
 DBAlRH8NYounF43xySr00du7URSyi3eLdAEb4km+PuSqgoBhpJX2uerqO6ezl+zqMprt
 m1uJOJZ6x3+CFs1N7TwkXjkZpwPaMAuKu5bb7O2GryBtynjjNFUVKybhdv47b4KckuXU
 c45AP3o5Wv6hkbpciAL587LGpDZUG/CIohf65h4/ERRUfXTHuE49sVjX8gJYLtDTDf67
 CgJg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVeUmjpOGNe7TN1r/pz3ga3tjcilaPQ9UE635rj68jYv98J9wZ1Uli6qYOJ2e+6nqXvEyVat6C+SR4e@nongnu.org
X-Gm-Message-State: AOJu0YwofYkIxnciKdMDFdSO2t/DjbRxgHwOb8oN+T38c8X3j1pOEH6b
 umMPv48efG/FD9081ds/igk4/BLRVK8Qq4oGy2KbdjJ18ULZB5CbHvSwH5dc+to8b+s=
X-Gm-Gg: AZuq6aIGwZb+7jBE1FsSBzoJzHqOVfwiDC3H6LO++Iazfx05z29Z74ood71w7Yo+SE0
 og+ZMfks0oqpHWPMBwntPBuqjk/u63xXaD7Bcee0wNpK/WCbnuZGG00yKhUWXVcPeFu+5wGbOp3
 ILVi/HS9Lg+XQaGat46S/JP8muH8fvgbCGfCUm03PskuJv4NtFJ4g3PrSXoK9LX7nos+hmduwDC
 i2zHXuAfoAPBRysGYJWjFKudqMBC6DRj7KunI2NKYTauLb+xdxFxMtTQnTFEHmL3EqmAizuyvUN
 w3NEIZNUuF/Mdqlzt5CwXDjTDfJiNkZd6e22dIdwUGGKr6q5rtrdFHb/b4LAOdwvAArd3fSds8c
 WhdKaf7fiJRUsGRtBvHnm497clYJyN6jdTmc2x4SxfkAcEngyQAXzCBq1VLULPqpZO1yvY367pQ
 WPFWZ+JSJ379NW59oO3HUT61S/JcBtgkF6z3RN7H76/dRLvj2Uah7EXXmagYru/G0I7CTRjNdFn
 ezkwNQkCWJ72UKfMcVTnfUsEoc6pIIdR0Dq
X-Received: by 2002:a05:6a00:2d18:b0:81f:cea1:f93f with SMTP id
 d2e1a72fcca58-8241c6347bamr1905857b3a.53.1770179847288; 
 Tue, 03 Feb 2026 20:37:27 -0800 (PST)
Received: from ?IPV6:2401:d002:dc0f:2100:1bc:fe1e:491:928e?
 (bg30dhzlx7lnyrq74wrz.ip6.superloop.au.
 [2401:d002:dc0f:2100:1bc:fe1e:491:928e])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8241d468d73sm883726b3a.49.2026.02.03.20.37.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Feb 2026 20:37:26 -0800 (PST)
Message-ID: <00a4742c-cb5e-4a7d-be00-daebcba4cb9d@linaro.org>
Date: Wed, 4 Feb 2026 14:37:22 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/11] gdbstub: pass GString to gdb_build_stop_packet
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20260203115201.2387721-1-alex.bennee@linaro.org>
 <20260203115201.2387721-7-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260203115201.2387721-7-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::444;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x444.google.com
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

On 2/3/26 21:51, Alex Bennée wrote:
> The other functions we are going to clean-up work variously with there
> own dynamically allocated GStrings or with the common shared buffer.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>   gdbstub/internals.h | 5 ++++-
>   gdbstub/gdbstub.c   | 4 ++--
>   gdbstub/system.c    | 4 ++--
>   gdbstub/user.c      | 8 ++++----
>   4 files changed, 12 insertions(+), 9 deletions(-)

This function is brand new in patch 4.
Why not just merge these two patches?

Either way,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

> 
> diff --git a/gdbstub/internals.h b/gdbstub/internals.h
> index 3134a6e8eb2..9b25bf58b8e 100644
> --- a/gdbstub/internals.h
> +++ b/gdbstub/internals.h
> @@ -239,9 +239,12 @@ int gdb_target_memory_rw_debug(CPUState *cs, hwaddr addr,
>   
>   /**
>    * gdb_build_stop_packet() - craft the stop packet
> + * @buf: GString buffer for building the packet
>    * @cs: CPUState
> + *
> + * Craft the Stop/Reply packet when we halt.
>    */
>   
> -void gdb_build_stop_packet(CPUState *cs);
> +void gdb_build_stop_packet(GString *buf, CPUState *cs);
>   
>   #endif /* GDBSTUB_INTERNALS_H */
> diff --git a/gdbstub/gdbstub.c b/gdbstub/gdbstub.c
> index c82fb5ad324..b45eb7c7b2b 100644
> --- a/gdbstub/gdbstub.c
> +++ b/gdbstub/gdbstub.c
> @@ -1432,7 +1432,7 @@ static void handle_v_attach(GArray *params, void *user_ctx)
>           gdbserver_state.c_cpu = cpu;
>   
>           if (gdbserver_state.allow_stop_reply) {
> -            gdb_build_stop_packet(cpu);
> +            gdb_build_stop_packet(gdbserver_state.str_buf, cpu);
>               gdbserver_state.allow_stop_reply = false;
>           }
>       }
> @@ -2036,7 +2036,7 @@ static void handle_gen_set(GArray *params, void *user_ctx)
>   static void handle_target_halt(GArray *params, void *user_ctx)
>   {
>       if (gdbserver_state.allow_stop_reply) {
> -        gdb_build_stop_packet(gdbserver_state.c_cpu);
> +        gdb_build_stop_packet(gdbserver_state.str_buf, gdbserver_state.c_cpu);
>           gdbserver_state.allow_stop_reply = false;
>           gdb_put_strbuf();
>       }
> diff --git a/gdbstub/system.c b/gdbstub/system.c
> index 6963c930b01..8ec8b7ea336 100644
> --- a/gdbstub/system.c
> +++ b/gdbstub/system.c
> @@ -668,8 +668,8 @@ void gdb_breakpoint_remove_all(CPUState *cs)
>    *   T05core:{id};
>    */
>   
> -void gdb_build_stop_packet(CPUState *cs)
> +void gdb_build_stop_packet(GString *buf, CPUState *cs)
>   {
> -    g_string_printf(gdbserver_state.str_buf,
> +    g_string_printf(buf,
>                       "T%02xcore:%02x;", GDB_SIGNAL_TRAP, gdb_get_cpu_index(cs));
>   }
> diff --git a/gdbstub/user.c b/gdbstub/user.c
> index c7a3ef947ed..a16f37616b1 100644
> --- a/gdbstub/user.c
> +++ b/gdbstub/user.c
> @@ -976,9 +976,9 @@ void gdb_handle_query_xfer_siginfo(GArray *params, void *user_ctx)
>    *   T05thread:{id};
>    */
>   
> -void gdb_build_stop_packet(CPUState *cs)
> +void gdb_build_stop_packet(GString *buf, CPUState *cs)
>   {
> -    g_string_printf(gdbserver_state.str_buf, "T%02xthread:", GDB_SIGNAL_TRAP);
> -    gdb_append_thread_id(cs, gdbserver_state.str_buf);
> -    g_string_append_c(gdbserver_state.str_buf, ';');
> +    g_string_printf(buf, "T%02xthread:", GDB_SIGNAL_TRAP);
> +    gdb_append_thread_id(cs, buf);
> +    g_string_append_c(buf, ';');
>   }


