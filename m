Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8737FF55811
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2026 08:22:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFSq1-0005LG-8e; Wed, 22 Apr 2026 04:21:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wFSpt-0005HE-7H
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 04:21:29 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wFSpq-0006NK-Ht
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 04:21:28 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-43d77f60944so4135581f8f.3
 for <qemu-devel@nongnu.org>; Wed, 22 Apr 2026 01:21:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776846084; x=1777450884; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=jU8rQIWbGq1V7J5yFzv6iHTchMAHIKmP2PMMHfQZHYQ=;
 b=kdSTy8l9BefknMWLYYY8HTJ6Q84Ymfyz+1w0qA7qmDzCrNNBVlTF9s7k3Y0d8j2S1y
 KmhpQHC+3H/6HglsyvzTcGwepUBGF9osSvIY1HurGrCL5J4CExnlv184CHMJVkJbBfbg
 xQFN7qcnPfQWW1p/Z5vTRA3TY3i/X9nLD6SO7UlhP6wt2BaK4hOj4NyQc7usI/4F7hAv
 anT8JkCkK7grGyNhlOgJWvq1GgXOTsa8SflC4VYfocDq7i87Q6NwNuwZbQkLFMkW6AXc
 aYE8zFGOfJLZQ5FJ8CqAPiYomFbxW6syEmnnw7uq22aVtVwVJY7YByDIxB7BRl3OPVnz
 Farw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776846084; x=1777450884;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jU8rQIWbGq1V7J5yFzv6iHTchMAHIKmP2PMMHfQZHYQ=;
 b=FS9pqt7aliLYMgIzhXZtIqN0ARYZ9fWZmxKOxAb3eOQUkLGwAWb7wWm4dd8lr6n7dl
 OYhdNAQ/qSZVpmWH0gR0e8QB/gpd8cjPwXDsPI9UdKYK03XBXFwVnAOUCZwdk5LpPfH4
 qq/dYqJHiSebhCedrvigkyVbr7+1b0eVUlLZ6hVUC8yxb/ZN7pN+qVi4iBD37+3bbCET
 zh7SFWQjNvSeyZbKoOZ0K1cCelQkBD9QrVpAZsbIegBJxm+39n4guSl2MHmQqmuZGVFM
 Vkv4G4hESS5LhnJxBSaZeVsyBbVvwgPBmjjTxyQ75aaOjeQDmHigSJ4PlaJU8HzNpElW
 KHaw==
X-Forwarded-Encrypted: i=1;
 AFNElJ+gE1eWFhrUeUhJCt4yBRME6a6hNboBA1KmgXyzQJjVWNIKKqX+Gk0ab9wAEf11pd0y5yYxnqqGqI4x@nongnu.org
X-Gm-Message-State: AOJu0YzcRRN8jQ3tNW3EjcUvXV4JYh+ML6VtV//AOmheRM/FkGONSlIo
 P+dBlK5ic6lmZW+Z9fU4PclsQ36P4320kju9HSVVbQ2CqZeGVpB59jR2MzzZcNT3uTU=
X-Gm-Gg: AeBDiet28myk3hwUACgwYVqEiNvS8mxs0heETlxqrr2amkrfBd2GsUE2aOsWsXZgFJC
 fNttXvU+ckjyBiMmEreh2YFqpw81Udy/Da4+fApJDK2/xj/oELVWEm78PMbji6LhRekKCi+Jfjd
 t7xnwCryNBW+lWVU2XaLpborffsNzESW+c8iTxTXZITopuiLFDXRcgW6R1za9Be2r1maeZKwqIn
 NUpp0LZdybv/Zu7DcRTsqBo4woVNUdI9T316zAqkSqHJJjZwml9cULNe32aGpi8pRCj+m47O3wM
 S51F0aHwGBnXO075ztXSV4+zK8WPaR+D6LV2JCZJVaohgGbt7tA3ituzMf1QzDdIbJ2qORgYuMJ
 D9OmMmlQ/yLTqTcHD9unA4Xb8/5FevOvSaG8olVieGjZkwk0/MF3gOSFBT98UB6jseEKUo3D/aO
 GU/oof6RfA9rXxDgYCSYl9pVSmDoPIR2g1K47Um8vIW2VdhSfI5CfHU4y5xtfBUKh7dhu5zl5wI
 7Qu
X-Received: by 2002:a05:6000:178b:b0:43e:aefa:db84 with SMTP id
 ffacd0b85a97d-43fe3e1601amr33257392f8f.34.1776846084492; 
 Wed, 22 Apr 2026 01:21:24 -0700 (PDT)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43fe4e46471sm42769771f8f.28.2026.04.22.01.21.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 22 Apr 2026 01:21:23 -0700 (PDT)
Message-ID: <23006638-7d07-4e8f-b910-ef06c2dc13cc@linaro.org>
Date: Wed, 22 Apr 2026 10:21:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/riscv: Make number of debug triggers configurable
Content-Language: en-US
To: Alvin Chang <alvinga@andestech.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org, Anton Johansson <anjo@rev.ng>
Cc: alistair.francis@wdc.com, bin.meng@windriver.com, liwei1518@gmail.com,
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com,
 vivahavey@gmail.com, Yu-Ming Chang <yumin686@andestech.com>
References: <20251201080524.186697-1-alvinga@andestech.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251201080524.186697-1-alvinga@andestech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x432.google.com
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

On 1/12/25 09:05, Alvin Chang via wrote:
> In current implementation, the number of debug triggers was hardcoded as
> RV_MAX_TRIGGERS macro. This commit replaces the fixed value with a new
> "num_triggers" configuration, allowing platforms to configure the number
> of debug triggers they want.
> 
> If no specific option is provided, the default number of debug triggers
> remains 2 as before.
> 
> A new CPU property "num-triggers" is added to let users configure the
> number of debug triggers from the command line. For example:
> 
>    -cpu max,num-triggers=8
> 
> Signed-off-by: Alvin Chang <alvinga@andestech.com>
> Reviewed-by: Yu-Ming Chang <yumin686@andestech.com>
> ---
>   target/riscv/cpu.c                | 34 +++++++++++++++++++++++++++++++
>   target/riscv/cpu.h                | 12 +++++------
>   target/riscv/cpu_cfg_fields.h.inc |  1 +
>   target/riscv/csr.c                |  3 ++-
>   target/riscv/debug.c              | 23 +++++++++++++--------
>   target/riscv/debug.h              |  2 --
>   target/riscv/machine.c            | 16 ++++++++++-----
>   7 files changed, 69 insertions(+), 22 deletions(-)


> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index 36e7f10..b32ed78 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -450,13 +450,13 @@ struct CPUArchState {
>   
>       /* trigger module */
>       target_ulong trigger_cur;
> -    target_ulong tdata1[RV_MAX_TRIGGERS];
> -    target_ulong tdata2[RV_MAX_TRIGGERS];
> -    target_ulong tdata3[RV_MAX_TRIGGERS];
> +    target_ulong *tdata1;
> +    target_ulong *tdata2;
> +    target_ulong *tdata3;
>       target_ulong mcontext;
> -    struct CPUBreakpoint *cpu_breakpoint[RV_MAX_TRIGGERS];
> -    struct CPUWatchpoint *cpu_watchpoint[RV_MAX_TRIGGERS];
> -    QEMUTimer *itrigger_timer[RV_MAX_TRIGGERS];
> +    struct CPUBreakpoint **cpu_breakpoint;
> +    struct CPUWatchpoint **cpu_watchpoint;
> +    QEMUTimer **itrigger_timer;
>       int64_t last_icount;
>       bool itrigger_enabled;


> diff --git a/target/riscv/machine.c b/target/riscv/machine.c
> index 18d790a..c7244b7 100644
> --- a/target/riscv/machine.c
> +++ b/target/riscv/machine.c
> @@ -239,15 +239,21 @@ static int debug_post_load(void *opaque, int version_id)
>   
>   static const VMStateDescription vmstate_debug = {
>       .name = "cpu/debug",
> -    .version_id = 2,
> -    .minimum_version_id = 2,
> +    .version_id = 3,
> +    .minimum_version_id = 3,
>       .needed = debug_needed,
>       .post_load = debug_post_load,
>       .fields = (const VMStateField[]) {
>           VMSTATE_UINTTL(env.trigger_cur, RISCVCPU),
> -        VMSTATE_UINTTL_ARRAY(env.tdata1, RISCVCPU, RV_MAX_TRIGGERS),
> -        VMSTATE_UINTTL_ARRAY(env.tdata2, RISCVCPU, RV_MAX_TRIGGERS),
> -        VMSTATE_UINTTL_ARRAY(env.tdata3, RISCVCPU, RV_MAX_TRIGGERS),
> +        VMSTATE_VARRAY_UINT32(env.tdata1, RISCVCPU,
> +                              cfg.num_triggers, 0,
> +                              vmstate_info_uinttl, target_ulong),
> +        VMSTATE_VARRAY_UINT32(env.tdata2, RISCVCPU,
> +                              cfg.num_triggers, 0,
> +                              vmstate_info_uinttl, target_ulong),
> +        VMSTATE_VARRAY_UINT32(env.tdata3, RISCVCPU,
> +                              cfg.num_triggers, 0,
> +                              vmstate_info_uinttl, target_ulong),

Breaking migration is a good opportunity to convert the underlying
type to uint64_t. Although can be also done later.
Anton, Alistair, WDYT?

>           VMSTATE_END_OF_LIST()
>       }
>   };


