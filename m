Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E501CCD195
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Oct 2025 17:36:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9oMR-000165-0o; Fri, 17 Oct 2025 13:35:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1v9oMN-00015K-TX
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 13:35:23 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1v9oMH-0001Rs-8J
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 13:35:23 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-781010ff051so1710490b3a.0
 for <qemu-devel@nongnu.org>; Fri, 17 Oct 2025 10:35:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1760722510; x=1761327310; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=yoffZu5XkEq4WQJZFPOnxIx/BVnSDDnLwSN+S9UGUKk=;
 b=IN+ANKD2nANp7Tso/8zBfFvx/vi8cQIE3RaWK0FkKUYLV8ddv5599Ucv4ODKIAOSjR
 Y+Nol9cLG37IO1MOA+EXX5ur6uPLIL7bJH90MNd2um/+SngCtMWiLOORflSy9dnEc0pu
 kAaNztjYlR/pn06sy4W01935f/socNLWdNPpzOj6R1K3Yz9mnnMi1vMJNDEZqYWP7066
 kpwhTyq9sbQrE1UknpLWSq03HMn4050SP823k4GVpkozJD4yMeMR8aSKnfn40ehMO95O
 iQC5id6HsVSrBINEtygHd9290Fn+WLtn0dcTPcpRDYexolhGW1bRGus7sY3JS3fwL0fe
 xPWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760722510; x=1761327310;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=yoffZu5XkEq4WQJZFPOnxIx/BVnSDDnLwSN+S9UGUKk=;
 b=s0R8Qm5kh8GatQLpN5kn9f5kuLAG9zOiS9Z2+EX0uXTQFoDAZ9LWKryt7GtSmYzz8j
 qvPz5s3qcLNh8B8VnExQYRHuOOsSv9VS0Sv7OV2pC6fpLUwe4Dj38MI9fQN4BVDSmp4X
 WpkrNN6OjGy4MjP5dpR2EqjhCfpI70RktFrR34uw3nMQj5UxOpn3pU90PPAxAgX1WAaU
 0A6FQmkRUZeFTs237X8xv+MtCcFxTmWLb135JXxAHZE0fI243bDr/ImkNxMVOJSVOol0
 8Xr7LDqLZxNO0jymPqFWXwethX20FefBEKoKylQCy585mYUJ7SI3RD4DtiA15crx4WJ+
 UUkw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXKbjhaRc3yUBRhZz05hTK0vCVfde6wTW+lsunt3oSBMK0Nc9/wEoz2dkjAUfXWLxzMWWFmYmn8QdRa@nongnu.org
X-Gm-Message-State: AOJu0YxMLvKy7JuB3dCkCDXebB01fdOQ5LqDyci7RDFHaoxrAmXLIJ6h
 MK/MsTrg6mRTBv22hg5iLlyu3C2pJz5AHilqpg9WpbjCRQc4UrYZeLj2gg5gX22S7iA=
X-Gm-Gg: ASbGnct4ZyNtYT2DxbrndY808Oecrytm9wlTGAWd/juVZ8PT081JLeOTg+FLSCvp//a
 GZ0u6pwxJ+xbjv3gxf4UvChxscv+r/XuTaY/CaKDeDZIlthaWrN+X+w4D1u+7V6MVG8FMuC6NN5
 gftueHdyNsQfDzOtW11Hs2cgu7dyFJ0Zms+BW/nS8+nADHELYGNmr5lAjHW0z4GnRdY6jDGPhWC
 /qhVmSSm41Eipe5SCvHISgTm+7CMEWINebUgca6naaeXnW6lnnIKKrwAW+8S5XtjSQftRPNn0wg
 Gh7zl0Ydcu2rS4V/ixEZM9hnlm8mHzAhVi5yIwg4+xZLRMF6+5hq7D527fMqIr30jMSPQcpcBub
 KSyJlSfb5glkL8bhRH9z0PSLn7Mcr1oDq8qg+/OW1w3cGgu8ayKlkAXiqOYdmz3BikzJ6AEserW
 uZffpPs3pNY05JHKKsteYk+T+R2g==
X-Google-Smtp-Source: AGHT+IFM/PeDhj0fiOUqPWSAtgc5++uMK7Zk7ID8TmG+W2wsKhlgVkx4sggS5McAvkKP17/nXMoEaA==
X-Received: by 2002:a05:6a00:929f:b0:781:2271:50ed with SMTP id
 d2e1a72fcca58-7a220a5848cmr5842558b3a.5.1760722509701; 
 Fri, 17 Oct 2025 10:35:09 -0700 (PDT)
Received: from [192.168.68.110] ([152.234.122.223])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7a23010df83sm121147b3a.59.2025.10.17.10.35.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 17 Oct 2025 10:35:09 -0700 (PDT)
Message-ID: <b4263539-8704-401e-9bcc-0ead33666e15@ventanamicro.com>
Date: Fri, 17 Oct 2025 14:35:04 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 14/17] hw/riscv, target/riscv: send resync updiscon trace
 packets
To: Konstantin Semichastnov <k.semichastnov@syntacore.com>,
 qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, palmer@dabbelt.com,
 richard.henderson@linaro.org
References: <20251002112335.2374517-1-dbarboza@ventanamicro.com>
 <20251002112335.2374517-15-dbarboza@ventanamicro.com>
 <2e7ac207-5aee-4941-9fe8-91456e1c7ea9@syntacore.com>
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Content-Language: en-US
In-Reply-To: <2e7ac207-5aee-4941-9fe8-91456e1c7ea9@syntacore.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pf1-x429.google.com
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



On 10/17/25 12:05 PM, Konstantin Semichastnov wrote:
> 
> On 02.10.2025 14:23, Daniel Henrique Barboza wrote:
>> Send updiscon packets based on the constraints already discussed in the
>> previous patch:
>>
>> - We do not implement any form of call/return prediction in the encoder,
>>    and TCG will always retire a single insn per cycle, e.g. irreport will
>>    always be equal to updiscon;
>>
>> - irdepth is not implemented since we'll always return a  package where
>>    irreport == updiscon.
>>
>> Note that we're sending an updiscon packet if the 'updiscon_pending'
>> flag is set when we're about the send a resync or a trap packet. The TCG
>> helper in this case is just setting the trace encoder flags instead of
>> actually triggering a RAM sink SMEM write.
>>
>> Signed-off-by: Daniel Henrique Barboza<dbarboza@ventanamicro.com>
>> ---
>>   hw/riscv/trace-encoder.c                      | 37 +++++++++++++++++++
>>   hw/riscv/trace-encoder.h                      |  3 ++
>>   target/riscv/helper.h                         |  1 +
>>   .../riscv/insn_trans/trans_privileged.c.inc   | 11 ++++++
>>   target/riscv/insn_trans/trans_rvi.c.inc       |  2 +
>>   target/riscv/trace_helper.c                   | 14 +++++++
>>   target/riscv/translate.c                      | 11 ++++++
>>   7 files changed, 79 insertions(+)
>>
>> diff --git a/hw/riscv/trace-encoder.c b/hw/riscv/trace-encoder.c
>> index 9a4530bbea..5572483d26 100644
>> --- a/hw/riscv/trace-encoder.c
>> +++ b/hw/riscv/trace-encoder.c
>> @@ -402,6 +402,22 @@ static void trencoder_send_sync_msg(Object *trencoder_obj, uint64_t pc)
>>       trencoder_send_message_smem(trencoder, msg, msg_size);
>>   }
>>   
>> +static void trencoder_send_updiscon(TraceEncoder *trencoder, uint64_t pc)
>> +{
>> +    g_autofree uint8_t *format2_msg = g_malloc0(TRACE_MSG_MAX_SIZE);
>> +    uint8_t addr_msb = extract64(pc, 31, 1);
>> +    bool notify = addr_msb;
>> +    bool updiscon = !notify;
>> +    uint8_t msg_size;
>> +
>> +    msg_size = rv_etrace_gen_encoded_format2_msg(format2_msg, pc,
>> +                                                 notify,
>> +                                                 updiscon);
>> +    trencoder_send_message_smem(trencoder, format2_msg, msg_size);
>> +
>> +    trencoder->updiscon_pending = false;
>> +}
>> +
>>   void trencoder_set_first_trace_insn(Object *trencoder_obj, uint64_t pc)
>>   {
>>       TraceEncoder *trencoder = TRACE_ENCODER(trencoder_obj);
>> @@ -409,6 +425,10 @@ void trencoder_set_first_trace_insn(Object *trencoder_obj, uint64_t pc)
>>       g_autofree uint8_t *msg = g_malloc0(TRACE_MSG_MAX_SIZE);
>>       uint8_t msg_size;
>>   
>> +    if (trencoder->updiscon_pending) {
>> +        trencoder_send_updiscon(trencoder, pc);
>> +    }
>> +
>>       trencoder->first_pc = pc;
>>       trace_trencoder_first_trace_insn(pc);
>>       msg_size = rv_etrace_gen_encoded_sync_msg(msg, pc, priv);
>> @@ -426,6 +446,10 @@ void trencoder_trace_trap_insn(Object *trencoder_obj,
>>       g_autofree uint8_t *msg = g_malloc0(TRACE_MSG_MAX_SIZE);
>>       uint8_t msg_size;
>>   
>> +    if (trencoder->updiscon_pending) {
>> +        trencoder_send_updiscon(trencoder, pc);
>> +    }
>> +
>>       msg_size = rv_etrace_gen_encoded_trap_msg(msg, pc, priv,
>>                                                 ecause, is_interrupt,
>>                                                 tval);
>> @@ -435,9 +459,22 @@ void trencoder_trace_trap_insn(Object *trencoder_obj,
>>   
>>   void trencoder_trace_ppccd(Object *trencoder_obj, uint64_t pc)
>>   {
>> +    TraceEncoder *trencoder = TRACE_ENCODER(trencoder_obj);
>> +
>> +    if (trencoder->updiscon_pending) {
>> +        trencoder_send_updiscon(trencoder, pc);
>> +    }
>> +
>>       trencoder_send_sync_msg(trencoder_obj, pc);
>>   }
>>   
>> +void trencoder_report_updiscon(Object *trencoder_obj)
>> +{
>> +    TraceEncoder *trencoder = TRACE_ENCODER(trencoder_obj);
>> +
>> +    trencoder->updiscon_pending = true;
>> +}
>> +
>>   static const Property trencoder_props[] = {
>>       /*
>>        * We need a link to the associated CPU to
>> diff --git a/hw/riscv/trace-encoder.h b/hw/riscv/trace-encoder.h
>> index 2bf07c01f6..0c44092ccb 100644
>> --- a/hw/riscv/trace-encoder.h
>> +++ b/hw/riscv/trace-encoder.h
>> @@ -36,6 +36,8 @@ struct TraceEncoder {
>>       uint32_t regs[TRACE_R_MAX];
>>       RegisterInfo regs_info[TRACE_R_MAX];
>>   
>> +    bool updiscon_pending;
>> +
>>       bool enabled;
>>       bool trace_running;
>>       bool trace_next_insn;
>> @@ -51,5 +53,6 @@ void trencoder_trace_trap_insn(Object *trencoder_obj,
>>                                  bool is_interrupt,
>>                                  uint64_t tval);
>>   void trencoder_trace_ppccd(Object *trencoder_obj, uint64_t pc);
>> +void trencoder_report_updiscon(Object *trencoder_obj);
>>   
>>   #endif
>> diff --git a/target/riscv/helper.h b/target/riscv/helper.h
>> index e80320ad16..f27ff319e9 100644
>> --- a/target/riscv/helper.h
>> +++ b/target/riscv/helper.h
>> @@ -131,6 +131,7 @@ DEF_HELPER_6(csrrw_i128, tl, env, int, tl, tl, tl, tl)
>>   
>>   /* Trace helpers (should be put inside ifdef) */
>>   DEF_HELPER_2(trace_insn, void, env, i64)
>> +DEF_HELPER_1(trace_updiscon, void, env)
>>   
>>   #ifndef CONFIG_USER_ONLY
>>   DEF_HELPER_1(sret, tl, env)
>> diff --git a/target/riscv/insn_trans/trans_privileged.c.inc b/target/riscv/insn_trans/trans_privileged.c.inc
>> index 8a62b4cfcd..28089539d5 100644
>> --- a/target/riscv/insn_trans/trans_privileged.c.inc
>> +++ b/target/riscv/insn_trans/trans_privileged.c.inc
>> @@ -26,6 +26,8 @@
>>   
>>   static bool trans_ecall(DisasContext *ctx, arg_ecall *a)
>>   {
>> +    gen_trace_updiscon();
>> +
>>       /* always generates U-level ECALL, fixed in do_interrupt handler */
>>       generate_exception(ctx, RISCV_EXCP_U_ECALL);
>>       return true;
>> @@ -40,6 +42,8 @@ static bool trans_ebreak(DisasContext *ctx, arg_ebreak *a)
>>       uint32_t ebreak = 0;
>>       uint32_t post   = 0;
>>   
>> +    gen_trace_updiscon();
>> +
>>       /*
>>        * The RISC-V semihosting spec specifies the following
>>        * three-instruction sequence to flag a semihosting call:
>> @@ -95,6 +99,8 @@ static bool trans_sret(DisasContext *ctx, arg_sret *a)
>>   {
>>   #ifndef CONFIG_USER_ONLY
>>       if (has_ext(ctx, RVS)) {
>> +        gen_trace_updiscon();
>> +
>>           decode_save_opc(ctx, 0);
>>           translator_io_start(&ctx->base);
>>           gen_update_pc(ctx, 0);
>> @@ -113,6 +119,8 @@ static bool trans_sret(DisasContext *ctx, arg_sret *a)
>>   static bool trans_mret(DisasContext *ctx, arg_mret *a)
>>   {
>>   #ifndef CONFIG_USER_ONLY
>> +    gen_trace_updiscon();
>> +
>>       decode_save_opc(ctx, 0);
>>       translator_io_start(&ctx->base);
>>       gen_update_pc(ctx, 0);
>> @@ -129,6 +137,9 @@ static bool trans_mnret(DisasContext *ctx, arg_mnret *a)
>>   {
>>   #ifndef CONFIG_USER_ONLY
>>       REQUIRE_SMRNMI(ctx);
>> +
>> +    gen_trace_updiscon();
>> +
>>       decode_save_opc(ctx, 0);
>>       gen_helper_mnret(cpu_pc, tcg_env);
>>       tcg_gen_exit_tb(NULL, 0); /* no chaining */
>> diff --git a/target/riscv/insn_trans/trans_rvi.c.inc b/target/riscv/insn_trans/trans_rvi.c.inc
>> index b9c7160468..adda6b5bd8 100644
>> --- a/target/riscv/insn_trans/trans_rvi.c.inc
>> +++ b/target/riscv/insn_trans/trans_rvi.c.inc
>> @@ -183,6 +183,8 @@ static bool trans_jalr(DisasContext *ctx, arg_jalr *a)
>>           }
>>       }
>>   
>> +    gen_trace_updiscon();
>> +
>>       lookup_and_goto_ptr(ctx);
>>   
>>       if (misaligned) {
>> diff --git a/target/riscv/trace_helper.c b/target/riscv/trace_helper.c
>> index ed84e6f79a..4b2b645f04 100644
>> --- a/target/riscv/trace_helper.c
>> +++ b/target/riscv/trace_helper.c
>> @@ -28,9 +28,23 @@ void helper_trace_insn(CPURISCVState *env, uint64_t pc)
>>           te->trace_next_insn = false;
>>       }
>>   }
>> +
>> +void helper_trace_updiscon(CPURISCVState *env)
>> +{
>> +    RISCVCPU *cpu = env_archcpu(env);
>> +    TraceEncoder *te = TRACE_ENCODER(cpu->trencoder);
>> +
>> +    te->updiscon_pending = true;
>> +    te->trace_next_insn = true;
>> +}
>>   #else /* #ifndef CONFIG_USER_ONLY */
>>   void helper_trace_insn(CPURISCVState *env, uint64_t pc)
>>   {
>>       return;
>>   }
>> +
>> +void helper_trace_updiscon(CPURISCVState *env)
>> +{
>> +    return;
>> +}
>>   #endif /* #ifndef CONFIG_USER_ONLY*/
>> diff --git a/target/riscv/translate.c b/target/riscv/translate.c
>> index 75348480e6..17a6174899 100644
>> --- a/target/riscv/translate.c
>> +++ b/target/riscv/translate.c
>> @@ -604,6 +604,15 @@ static void gen_ctr_jal(DisasContext *ctx, int rd, target_ulong imm)
>>   }
>>   #endif
>>   
>> +static void gen_trace_updiscon(void)
>> +{
>> +    TCGLabel *skip = gen_new_label();
>> +
>> +    tcg_gen_brcondi_tl(TCG_COND_EQ, cpu_trace_running, 0, skip);
>> +    gen_helper_trace_updiscon(tcg_env);
>> +    gen_set_label(skip);
>> +}
>> +
>>   static void gen_jal(DisasContext *ctx, int rd, target_ulong imm)
>>   {
>>       TCGv succ_pc = dest_gpr(ctx, rd);
>> @@ -629,6 +638,8 @@ static void gen_jal(DisasContext *ctx, int rd, target_ulong imm)
>>       gen_pc_plus_diff(succ_pc, ctx, ctx->cur_insn_len);
>>       gen_set_gpr(ctx, rd, succ_pc);
>>   
>> +    gen_trace_updiscon();
> I have a question about this line. Why have you added the generation of an updiscon message if the JAL instruction is an inferable jump?

Because I did something wrong :) just double checked the Efficient Trace pdf,
in particular the decoder pseudo code in Chapter 11 and yeah, we don't need
to generate an updiscon for JAL.

I'll remove it in the next version. Thanks for pointing this out!


Daniel





>> +
>>       gen_goto_tb(ctx, 0, imm); /* must use this for safety */
>>       ctx->base.is_jmp = DISAS_NORETURN;
>>   }


