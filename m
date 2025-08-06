Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F03BC87FCB
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Aug 2025 21:56:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ujm73-0006Ze-9D; Wed, 06 Aug 2025 17:55:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1ujm71-0006ZK-JK
 for qemu-devel@nongnu.org; Wed, 06 Aug 2025 17:55:55 -0400
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1ujm6y-0006h6-Mr
 for qemu-devel@nongnu.org; Wed, 06 Aug 2025 17:55:54 -0400
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-31ecd40352fso371863a91.2
 for <qemu-devel@nongnu.org>; Wed, 06 Aug 2025 14:55:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754517351; x=1755122151; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7V5xrAloaYMr0YbK1tWOj6CedT2/H3lYjTwwXia4KwA=;
 b=Q8HSinkIjx0Uok0jH0w5kPvtMMorYpNLaXH7h5muZDcu3/E0aOexnir6r1c2Ln+Pzl
 EMoqg2kJ+ltZDzqCdzQg1vlmlk2WQ2bdhOcCAwRMrQY+HvIJV1eHL8dL0f35vPJAMk+t
 EgkcPvTRpBWuLtj8D3j7UVnJFow6vwAIsBQPPUOH1A4ga6rJ2ULqm4wu90XY3gIEA5rb
 izsQ3oQEpe4J/vBjKDwLv4WOf25vhAJm7ryYazLAVa71E9L0B28VufdBhgw4NroxoKUg
 V1+unohD+Nf3AcsFBXQu5sblOy+3P0mgDsE728zm6a1Csi2ijVvLpGGTaV89p7BYBeZR
 CotQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754517351; x=1755122151;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7V5xrAloaYMr0YbK1tWOj6CedT2/H3lYjTwwXia4KwA=;
 b=dxCU2sfuYFkuwak1D8nt/bkHED8u1A6t+tWNDhxelIdiafRxa4ZhdHsCaL5a7o1vWX
 VK3aorVRDTj/HDJczbmv8wypHheauvOQ+EVt0dutYKYoonPEVwFeAVPw4eFqSoTDU3ur
 C2HJU3UQq1gqgk2nCjMEK6MuyhwLpkDLEe1JtvqV+7f5Rhh9Dga1xY6zkzi5VA12LgdP
 hvgzZ0bYQ81nnGIjlLz9M5WREplqG/MhAvuFewmsRKfZJiZ33ikzwqdjN3ei0J7Ik+ex
 Qk4tZuB8LsT1Lw9IFmFGbKnvOl7oJEAgMELIJk5ip2EjXaS47brSNAFn8A1MZJQZ728d
 9DrA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUFztfHgO7RU6tjCKin6WAcYAAmrEmAy/dG30SabaMEEpLmXaq4sxj7jJXotIdd7J/yDqlrtI0g+s+N@nongnu.org
X-Gm-Message-State: AOJu0YzuRj/nrpgNL8Gspp2xm+AGtFLXYFod30DqCFtNGucNh+rB4h1Q
 qXSnQQ94i0QSeUJvQMrJSMGbvOR2Ao57oPy0ek6yyrIxMN6zc1KRD3ttNbwvbeZ8mLE=
X-Gm-Gg: ASbGnct5zOqvwb8b7xfMMRNLQH24tylmLslNSk61mXVa/yPjVmU5ngrssN3n50Bf4sq
 Va46hywtKZVZJ5xhQj/otacNNtnSF5m+DrOAygZ4kcVXTUu4djR6s4KNLpy8jowA/2fFiHb+lk3
 Kjf88AX6jx8zCMOTg+FgxhAGbU83TRINR/mdH510jRgZ78RiGf9hyuLg0IAU11SkIIiXobSBIoh
 NGY5auGbyTak0cnMH+g+CHGWcEoI/HDLlEE/U36YvKfJHKFDKbIu7HcV4DpXey8dYwmsDOKX8Ip
 Gph8oFHs6ibQRn7Z+lCgzsYGrz30giZuFtlJ3eq38SBXsqFJ9oXG4nIKAhGcGU+4NpDoRWZtKTU
 UBWPR9z6lQrU2h9J+GO+pox9lNF1wZ8WgyRz7PCSN6YeEXw==
X-Google-Smtp-Source: AGHT+IF+jN2lTkBshuphCkCU9S530k2krx398xpNUpyxHz2KHO9QOOKJRtoho6IgG6MwjlDTJpdiLw==
X-Received: by 2002:a17:90b:1b07:b0:314:2892:b1e0 with SMTP id
 98e67ed59e1d1-32166d06188mr5032916a91.34.1754517351089; 
 Wed, 06 Aug 2025 14:55:51 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3216121ec0esm3796258a91.10.2025.08.06.14.55.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 06 Aug 2025 14:55:50 -0700 (PDT)
Message-ID: <0b38d386-9d8b-46bd-a981-718cc7281eb6@linaro.org>
Date: Wed, 6 Aug 2025 14:55:50 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 04/11] hw/arm/smmuv3: Enable command processing for the
 Secure state
Content-Language: en-US
To: Tao Tang <tangtao1634@phytium.com.cn>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: Eric Auger <eric.auger@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Chen Baozi <chenbaozi@phytium.com.cn>
References: <20250806151134.365755-1-tangtao1634@phytium.com.cn>
 <20250806151134.365755-5-tangtao1634@phytium.com.cn>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250806151134.365755-5-tangtao1634@phytium.com.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1033;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x1033.google.com
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

On 8/6/25 8:11 AM, Tao Tang wrote:
> This patch enables the secure command queue, providing a dedicated
> interface for secure software to issue commands to the SMMU. Based on
> the SMMU_S_CMDQ_BASE configuration, the SMMU now fetches command
> entries directly from the Secure PA space so that we need to pass the
> memory transaction attributes when reading the command queue.
> 
> This provides a parallel command mechanism to the non-secure world.
> 
> Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>
> ---
>   hw/arm/smmuv3-internal.h |  8 ++++--
>   hw/arm/smmuv3.c          | 55 +++++++++++++++++++++++++---------------
>   hw/arm/trace-events      |  2 +-
>   3 files changed, 41 insertions(+), 24 deletions(-)
> 
> diff --git a/hw/arm/smmuv3-internal.h b/hw/arm/smmuv3-internal.h
> index 1a8b1cb204..5b2ca00832 100644
> --- a/hw/arm/smmuv3-internal.h
> +++ b/hw/arm/smmuv3-internal.h
> @@ -319,9 +319,13 @@ static inline void queue_cons_incr(SMMUQueue *q)
>       q->cons = deposit32(q->cons, 0, q->log2size + 1, q->cons + 1);
>   }
>   
> -static inline bool smmuv3_cmdq_enabled(SMMUv3State *s)
> +static inline bool smmuv3_cmdq_enabled(SMMUv3State *s, bool is_secure)
>   {
> -    return FIELD_EX32(s->cr[0], CR0, CMDQEN);
> +    if (is_secure) {
> +        return FIELD_EX32(s->secure_cr[0], S_CR0, CMDQEN);
> +    } else {
> +        return FIELD_EX32(s->cr[0], CR0, CMDQEN);
> +    }
>   }
>   
>   static inline bool smmuv3_eventq_enabled(SMMUv3State *s)
> diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
> index 0ea9d897af..0590f0f482 100644
> --- a/hw/arm/smmuv3.c
> +++ b/hw/arm/smmuv3.c
> @@ -105,14 +105,17 @@ static void smmuv3_write_gerrorn(SMMUv3State *s, uint32_t new_gerrorn)
>       trace_smmuv3_write_gerrorn(toggled & pending, s->gerrorn);
>   }
>   
> -static inline MemTxResult queue_read(SMMUQueue *q, Cmd *cmd)
> +static inline MemTxResult queue_read(SMMUQueue *q, Cmd *cmd, bool is_secure)
>   {
>       dma_addr_t addr = Q_CONS_ENTRY(q);
>       MemTxResult ret;
>       int i;
> +    MemTxAttrs attrs = is_secure ?
> +        (MemTxAttrs) { .secure = 1 } :
> +        (MemTxAttrs) { .unspecified = true };
>   
>       ret = dma_memory_read(&address_space_memory, addr, cmd, sizeof(Cmd),
> -                          MEMTXATTRS_UNSPECIFIED);
> +                          attrs);
>       if (ret != MEMTX_OK) {
>           return ret;
>       }
> @@ -1311,14 +1314,14 @@ static inline bool smmu_hw_secure_implemented(SMMUv3State *s)
>       return FIELD_EX32(s->secure_idr[1], S_IDR1, SECURE_IMPL);
>   }
>   
> -static int smmuv3_cmdq_consume(SMMUv3State *s)
> +static int smmuv3_cmdq_consume(SMMUv3State *s, bool is_secure)
>   {
>       SMMUState *bs = ARM_SMMU(s);
>       SMMUCmdError cmd_error = SMMU_CERROR_NONE;
> -    SMMUQueue *q = &s->cmdq;
> +    SMMUQueue *q = is_secure ? &s->secure_cmdq : &s->cmdq;
>       SMMUCommandType type = 0;
>   
> -    if (!smmuv3_cmdq_enabled(s)) {
> +    if (!smmuv3_cmdq_enabled(s, is_secure)) {
>           return 0;
>       }
>       /*
> @@ -1329,17 +1332,20 @@ static int smmuv3_cmdq_consume(SMMUv3State *s)
>        */
>   
>       while (!smmuv3_q_empty(q)) {
> -        uint32_t pending = s->gerror ^ s->gerrorn;
> +        uint32_t pending = is_secure ? s->secure_gerror ^ s->secure_gerrorn :
> +            s->gerror ^ s->gerrorn;
>           Cmd cmd;
>   
>           trace_smmuv3_cmdq_consume(Q_PROD(q), Q_CONS(q),
> -                                  Q_PROD_WRAP(q), Q_CONS_WRAP(q));
> +                                  Q_PROD_WRAP(q), Q_CONS_WRAP(q),
> +                                  is_secure);
>   
> -        if (FIELD_EX32(pending, GERROR, CMDQ_ERR)) {
> +        if (is_secure ? FIELD_EX32(pending, S_GERROR, CMDQ_ERR) :
> +            FIELD_EX32(pending, GERROR, CMDQ_ERR)) {
>               break;
>           }
>   
> -        if (queue_read(q, &cmd) != MEMTX_OK) {
> +        if (queue_read(q, &cmd, is_secure) != MEMTX_OK) {
>               cmd_error = SMMU_CERROR_ABT;
>               break;
>           }
> @@ -1364,8 +1370,11 @@ static int smmuv3_cmdq_consume(SMMUv3State *s)
>               SMMUDevice *sdev = smmu_find_sdev(bs, sid);
>   
>               if (CMD_SSEC(&cmd)) {
> -                cmd_error = SMMU_CERROR_ILL;
> -                break;
> +                if (!is_secure) {
> +                    /* Secure Stream with NON-Secure command */
> +                    cmd_error = SMMU_CERROR_ILL;
> +                    break;
> +                }
>               }
>   
>               if (!sdev) {
> @@ -1384,8 +1393,10 @@ static int smmuv3_cmdq_consume(SMMUv3State *s)
>               SMMUSIDRange sid_range;
>   
>               if (CMD_SSEC(&cmd)) {
> -                cmd_error = SMMU_CERROR_ILL;
> -                break;
> +                if (!is_secure) {
> +                    cmd_error = SMMU_CERROR_ILL;
> +                    break;
> +                }
>               }
>   
>               mask = (1ULL << (range + 1)) - 1;
> @@ -1403,8 +1414,10 @@ static int smmuv3_cmdq_consume(SMMUv3State *s)
>               SMMUDevice *sdev = smmu_find_sdev(bs, sid);
>   
>               if (CMD_SSEC(&cmd)) {
> -                cmd_error = SMMU_CERROR_ILL;
> -                break;
> +                if (!is_secure) {
> +                    cmd_error = SMMU_CERROR_ILL;
> +                    break;
> +                }
>               }
>   
>               if (!sdev) {
> @@ -1706,7 +1719,7 @@ static MemTxResult smmu_writel(SMMUv3State *s, hwaddr offset,
>           s->cr[0] = data;
>           s->cr0ack = data & ~SMMU_CR0_RESERVED;
>           /* in case the command queue has been enabled */
> -        smmuv3_cmdq_consume(s);
> +        smmuv3_cmdq_consume(s, false);
>           return MEMTX_OK;
>       case A_CR1:
>           s->cr[1] = data;
> @@ -1723,7 +1736,7 @@ static MemTxResult smmu_writel(SMMUv3State *s, hwaddr offset,
>            * By acknowledging the CMDQ_ERR, SW may notify cmds can
>            * be processed again
>            */
> -        smmuv3_cmdq_consume(s);
> +        smmuv3_cmdq_consume(s, false);
>           return MEMTX_OK;
>       case A_GERROR_IRQ_CFG0: /* 64b */
>           s->gerror_irq_cfg0 = deposit64(s->gerror_irq_cfg0, 0, 32, data);
> @@ -1772,7 +1785,7 @@ static MemTxResult smmu_writel(SMMUv3State *s, hwaddr offset,
>           return MEMTX_OK;
>       case A_CMDQ_PROD:
>           s->cmdq.prod = data;
> -        smmuv3_cmdq_consume(s);
> +        smmuv3_cmdq_consume(s, false);
>           return MEMTX_OK;
>       case A_CMDQ_CONS:
>           s->cmdq.cons = data;
> @@ -1810,7 +1823,7 @@ static MemTxResult smmu_writel(SMMUv3State *s, hwaddr offset,
>           s->secure_cr[0] = data;
>           /* clear reserved bits */
>           s->secure_cr0ack = data & ~SMMU_S_CR0_RESERVED;
> -        smmuv3_cmdq_consume(s);
> +        smmuv3_cmdq_consume(s, true);
>           return MEMTX_OK;
>       case A_S_CR1:
>           if (!smmu_validate_secure_write(attrs, secure_impl, offset,
> @@ -1836,7 +1849,7 @@ static MemTxResult smmu_writel(SMMUv3State *s, hwaddr offset,
>       case A_S_GERRORN:
>           SMMU_CHECK_SECURE_WRITE("S_GERRORN");
>           smmuv3_write_gerrorn(s, data);
> -        smmuv3_cmdq_consume(s);
> +        smmuv3_cmdq_consume(s, true);
>           return MEMTX_OK;
>       case A_S_GERROR_IRQ_CFG0:
>           SMMU_CHECK_ATTRS_SECURE("S_GERROR_IRQ_CFG0");
> @@ -1892,7 +1905,7 @@ static MemTxResult smmu_writel(SMMUv3State *s, hwaddr offset,
>       case A_S_CMDQ_PROD:
>           SMMU_CHECK_SECURE_WRITE("S_CMDQ_PROD");
>           s->secure_cmdq.prod = data;
> -        smmuv3_cmdq_consume(s);
> +        smmuv3_cmdq_consume(s, true);
>           return MEMTX_OK;
>       case A_S_CMDQ_CONS:
>           SMMU_CHECK_SECURE_WRITE("S_CMDQ_CONS");
> diff --git a/hw/arm/trace-events b/hw/arm/trace-events
> index 019129ea43..7d967226ff 100644
> --- a/hw/arm/trace-events
> +++ b/hw/arm/trace-events
> @@ -35,7 +35,7 @@ smmuv3_trigger_irq(int irq) "irq=%d"
>   smmuv3_write_gerror(uint32_t toggled, uint32_t gerror) "toggled=0x%x, new GERROR=0x%x"
>   smmuv3_write_gerrorn(uint32_t acked, uint32_t gerrorn) "acked=0x%x, new GERRORN=0x%x"
>   smmuv3_unhandled_cmd(uint32_t type) "Unhandled command type=%d"
> -smmuv3_cmdq_consume(uint32_t prod, uint32_t cons, uint8_t prod_wrap, uint8_t cons_wrap) "prod=%d cons=%d prod.wrap=%d cons.wrap=%d"
> +smmuv3_cmdq_consume(uint32_t prod, uint32_t cons, uint8_t prod_wrap, uint8_t cons_wrap, bool is_secure_cmdq) "prod=%d cons=%d prod.wrap=%d cons.wrap=%d is_secure_cmdq=%d"
>   smmuv3_cmdq_opcode(const char *opcode) "<--- %s"
>   smmuv3_cmdq_consume_out(uint32_t prod, uint32_t cons, uint8_t prod_wrap, uint8_t cons_wrap) "prod:%d, cons:%d, prod_wrap:%d, cons_wrap:%d "
>   smmuv3_cmdq_consume_error(const char *cmd_name, uint8_t cmd_error) "Error on %s command execution: %d"

This looks like a reasonable and readable approach to support secure and 
non secure accesses.

