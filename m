Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DCA7E8305C
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Feb 2026 07:58:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnBIH-0000hS-Dc; Tue, 03 Feb 2026 02:57:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1vnBI5-0000gT-Vf
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 02:57:42 -0500
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1vnBI4-0006Wq-5n
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 02:57:41 -0500
Received: by mail-pl1-x643.google.com with SMTP id
 d9443c01a7336-29efd139227so35256025ad.1
 for <qemu-devel@nongnu.org>; Mon, 02 Feb 2026 23:57:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770105458; x=1770710258; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=LMNKsMVbRoCuyOH7FBkHss38cAJ9Z2p705HQOidWoaU=;
 b=H5pTDnfIbELjbVCLa2i0VHs3XJbufuHcYPaVC5Txe8RxLCNbmhAHcJ8kAF+jOVjTRf
 qWELOKH2HgVo1e2zWp8EnuE4Yt6yc4Sm3jntb4y/kh6rRSG2YzRgZxVsafD3U8n4t/r9
 iB7WWdF2y23DQGCJOOBlcAizvq6t5zpTi1dCaz2euSXnakQLfMPNmORd3wWYh+87SxaN
 NGLfJoc8PLPuAV12rkmBKrl1yBs2JG3yledOAXXnUe4vcRhH9GY87hSpRsOoCwLJc9IL
 t6TMjnEL3bK9dZdQPxaFi5RqI9329IUSHqywCqnKQ1cYcJxVvWWauO5w/cu3oLeezlm0
 KcUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770105458; x=1770710258;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LMNKsMVbRoCuyOH7FBkHss38cAJ9Z2p705HQOidWoaU=;
 b=C/7BeaqhyT3iSvrVjYcv0reeNw+UpSANBOm154JH0TbLlQsAkcwmwY8qPrTwSaX12h
 22dpHXYIUb+DFmqq4wkUCRwuSSrcDHx5gKmvaaEB2u7x2RBDzw6vVJRNi2WIQ/XwYUFk
 vtGHAK4bKVOlFEuroFW4ITuurRTZglHsvcTY+Pn1mudilelFP3mxQSXKLt7iS64L9mOD
 IngAtBczdUl9VaIGgomjN84wVPMZxH8Qh16Fajm2lIBumN9DngO7J1ZsFEpv0Zp0e/0J
 C4NFx7rEsTZuWXAhiY5MxwN1TiDY/WPI6BMuLDG/1i1PZWg/pMpjyrJXFIUrEr0SaxS4
 AEiQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXK8ggKL3DGGStoxvwvhs+BqOORQM5/sJgUkjEme/opQsaoMoxtpZmVm0FLOBgRJmQxUGSDl0s8ZBXL@nongnu.org
X-Gm-Message-State: AOJu0YxsL84nEXTcSVvwgy6gSES6r5A9QjyaXGgdXIqpqTa2eM5o69Sk
 8qYJk5iO9FYXzKnZE83JwsmXyS5d7LYvpkBC0ofNa9UdJbO+ossd5tcx
X-Gm-Gg: AZuq6aL1n1jrfjcieq59Ca6qVeXGSGXCbQL2BMDZqcsrwLgyxGu5ETj4/6Rwiy33YDI
 XA5D31vb2gb3royHxH5yUc2sQpVjWvoh1FibxDlv/RAU3rwKGVSGFpwkoZmwj/fSLFIhJK4Ju79
 yVaoG8S3q1BcAu/y8ZK449CbnsvOl5z5SHtHdsHNrF/eqJDjplGffxPCztPk3yGqEwz6Wum06t7
 SfEj56dx/5O+z+pNHfbqJ8iwI0IukPjrm7nYoqQ8zRURC+U+dxrMeL2zTWMVe7wRclXcGgp0pvw
 vRHgYRU6dMnId3r8GICtpvk1guP6NuUSHAQkeUUndZtSkP9Qpez6D6gnq9TxCKcGHXAGsthMP6Z
 jySnJXzxw36gGuqauD15UyLKKjtzpK9+13mFvJqDypeAaIC/Iz/+QCIH6ze3XvkG5gqRrVLzooU
 clrxO3QmzwkZdB/jDA/OyCxi1TeIJC6DLOnTJfIS4gEBfGzIYowOOedr6iZzkr
X-Received: by 2002:a17:902:e78c:b0:2a1:3cd9:a73a with SMTP id
 d9443c01a7336-2a8d8163c80mr162938015ad.40.1770105458178; 
 Mon, 02 Feb 2026 23:57:38 -0800 (PST)
Received: from ZEVORN-PC.localdomain ([183.195.22.5])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a88b7f6c7csm172339055ad.98.2026.02.02.23.57.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Feb 2026 23:57:37 -0800 (PST)
Date: Tue, 3 Feb 2026 15:57:31 +0800
From: Chao Liu <chao.liu.zevorn@gmail.com>
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: Alistair Francis <alistair.francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Weiwei Li <liwei1518@gmail.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org, hust-os-kernel-patches@googlegroups.com,
 wangjingwei@iscas.ac.cn, devel@lists.libvirt.org
Subject: Re: [RFC PATCH v4 7/7] target/riscv: add sdtrig trigger action=debug
 mode
Message-ID: <aYGqa5ddiHUIeNVi@ZEVORN-PC.localdomain>
References: <cover.1769751489.git.chao.liu.zevorn@gmail.com>
 <8fe531a24703eb426a66618822649bf5ee78697f.1769751489.git.chao.liu.zevorn@gmail.com>
 <48b819aa-da6b-43f6-9427-78f721b9ad39@ventanamicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <48b819aa-da6b-43f6-9427-78f721b9ad39@ventanamicro.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::643;
 envelope-from=chao.liu.zevorn@gmail.com; helo=mail-pl1-x643.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Hi Daniel,

On Mon, Feb 02, 2026 at 02:48:11PM -0300, Daniel Henrique Barboza wrote:
> 
> 
> On 1/30/2026 3:00 AM, Chao Liu wrote:
> > RISC-V Debug Specification:
> > https://github.com/riscv/riscv-debug-spec/releases/tag/1.0
> > 
> > Allow mcontrol/mcontrol6 action=1 when Sdext is enabled. When such a
> > trigger hits, enter Debug Mode with cause=trigger and stop with
> > EXCP_DEBUG.
> > 
> > Also report inst-count triggers in tinfo and read their action field.
> > 
> > Signed-off-by: Chao Liu <chao.liu.zevorn@gmail.com>
> > ---
> >   target/riscv/debug.c | 53 ++++++++++++++++++++++++++++++++++++++++++--
> >   1 file changed, 51 insertions(+), 2 deletions(-)
> > 
> > diff --git a/target/riscv/debug.c b/target/riscv/debug.c
> > index 5877a60c50..4e30d42905 100644
> > --- a/target/riscv/debug.c
> > +++ b/target/riscv/debug.c
> > @@ -110,6 +110,8 @@ static trigger_action_t get_trigger_action(CPURISCVState *env,
> >           action = (tdata1 & TYPE6_ACTION) >> 12;
> >           break;
> >       case TRIGGER_TYPE_INST_CNT:
> > +        action = tdata1 & ITRIGGER_ACTION;
> > +        break;
> >       case TRIGGER_TYPE_INT:
> >       case TRIGGER_TYPE_EXCP:
> >       case TRIGGER_TYPE_EXT_SRC:
> > @@ -280,6 +282,7 @@ static target_ulong textra_validate(CPURISCVState *env, target_ulong tdata3)
> >   static void do_trigger_action(CPURISCVState *env, target_ulong trigger_index)
> >   {
> > +    CPUState *cs = env_cpu(env);
> >       trigger_action_t action = get_trigger_action(env, trigger_index);
> >       switch (action) {
> > @@ -289,6 +292,21 @@ static void do_trigger_action(CPURISCVState *env, target_ulong trigger_index)
> >           riscv_raise_exception(env, RISCV_EXCP_BREAKPOINT, 0);
> >           break;
> >       case DBG_ACTION_DBG_MODE:
> > +        if (!env_archcpu(env)->cfg.ext_sdext) {
> > +            qemu_log_mask(LOG_UNIMP,
> > +                          "trigger action=debug mode requires Sdext\n");
> 
> 
> I believe we want LOG_GUEST_ERROR for invalid actions like this one. You can
> check examples in trigger_priv_match and other places in debug.c
> 
> LOG_UNIMP is reserved for cases where QEMU does not implement something at
> all and we want to warn the user about it. For instance, again in
> debug.c:trigger_priv_match():
> 
> 
>     case TRIGGER_TYPE_INT:
>     case TRIGGER_TYPE_EXCP:
>     case TRIGGER_TYPE_EXT_SRC:
>         qemu_log_mask(LOG_UNIMP, "trigger type: %d is not supported\n",
> type);
>         break;
> 
> 
> This is the intended use for LOG_UNIMP.
> 
Thank you for the review and the clarification on the logging macros.

I will replace the sdext-related LOG_UNIMP macros with LOG_GUEST_ERROR for
this case. Will send v5 with this fix.

Thanks,
Chao

> Everything else LGTM.
> 
> Thanks,
> Daniel
> 
> 
> 
> > +            riscv_raise_exception(env, RISCV_EXCP_BREAKPOINT, 0);
> > +        }
> > +        riscv_cpu_enter_debug_mode(env, env->pc, DCSR_CAUSE_TRIGGER);
> > +        /*
> > +         * If this came from the Trigger Module's CPU breakpoint/watchpoint,
> > +         * we're already returning via EXCP_DEBUG. Otherwise, stop now.
> > +         */
> > +        if (cs->exception_index != EXCP_DEBUG) {
> > +            cs->exception_index = EXCP_DEBUG;
> > +            cpu_loop_exit_restore(cs, GETPC());
> > +        }
> > +        break;
> >       case DBG_ACTION_TRACE0:
> >       case DBG_ACTION_TRACE1:
> >       case DBG_ACTION_TRACE2:
> > @@ -441,6 +459,7 @@ static target_ulong type2_mcontrol_validate(CPURISCVState *env,
> >   {
> >       target_ulong val;
> >       uint32_t size;
> > +    uint32_t action;
> >       /* validate the generic part first */
> >       val = tdata1_validate(env, ctrl, TRIGGER_TYPE_AD_MATCH);
> > @@ -448,11 +467,25 @@ static target_ulong type2_mcontrol_validate(CPURISCVState *env,
> >       /* validate unimplemented (always zero) bits */
> >       warn_always_zero_bit(ctrl, TYPE2_MATCH, "match");
> >       warn_always_zero_bit(ctrl, TYPE2_CHAIN, "chain");
> > -    warn_always_zero_bit(ctrl, TYPE2_ACTION, "action");
> >       warn_always_zero_bit(ctrl, TYPE2_TIMING, "timing");
> >       warn_always_zero_bit(ctrl, TYPE2_SELECT, "select");
> >       warn_always_zero_bit(ctrl, TYPE2_HIT, "hit");
> > +    action = (ctrl & TYPE2_ACTION) >> 12;
> > +    if (action == DBG_ACTION_BP) {
> > +        val |= ctrl & TYPE2_ACTION;
> > +    } else if (action == DBG_ACTION_DBG_MODE) {
> > +        if (env_archcpu(env)->cfg.ext_sdext) {
> > +            val |= ctrl & TYPE2_ACTION;
> > +        } else {
> > +            qemu_log_mask(LOG_UNIMP,
> > +                          "trigger action=debug mode requires Sdext\n");
> > +        }
> > +    } else {
> > +        qemu_log_mask(LOG_UNIMP, "trigger action: %u is not supported\n",
> > +                      action);
> > +    }
> > +
> >       /* validate size encoding */
> >       size = type2_breakpoint_size(env, ctrl);
> >       if (access_size[size] == -1) {
> > @@ -569,6 +602,7 @@ static target_ulong type6_mcontrol6_validate(CPURISCVState *env,
> >   {
> >       target_ulong val;
> >       uint32_t size;
> > +    uint32_t action;
> >       /* validate the generic part first */
> >       val = tdata1_validate(env, ctrl, TRIGGER_TYPE_AD_MATCH6);
> > @@ -576,11 +610,25 @@ static target_ulong type6_mcontrol6_validate(CPURISCVState *env,
> >       /* validate unimplemented (always zero) bits */
> >       warn_always_zero_bit(ctrl, TYPE6_MATCH, "match");
> >       warn_always_zero_bit(ctrl, TYPE6_CHAIN, "chain");
> > -    warn_always_zero_bit(ctrl, TYPE6_ACTION, "action");
> >       warn_always_zero_bit(ctrl, TYPE6_TIMING, "timing");
> >       warn_always_zero_bit(ctrl, TYPE6_SELECT, "select");
> >       warn_always_zero_bit(ctrl, TYPE6_HIT, "hit");
> > +    action = (ctrl & TYPE6_ACTION) >> 12;
> > +    if (action == DBG_ACTION_BP) {
> > +        val |= ctrl & TYPE6_ACTION;
> > +    } else if (action == DBG_ACTION_DBG_MODE) {
> > +        if (env_archcpu(env)->cfg.ext_sdext) {
> > +            val |= ctrl & TYPE6_ACTION;
> > +        } else {
> > +            qemu_log_mask(LOG_UNIMP,
> > +                          "trigger action=debug mode requires Sdext\n");
> > +        }
> > +    } else {
> > +        qemu_log_mask(LOG_UNIMP, "trigger action: %u is not supported\n",
> > +                      action);
> > +    }
> > +
> >       /* validate size encoding */
> >       size = extract32(ctrl, 16, 4);
> >       if (access_size[size] == -1) {
> > @@ -919,6 +967,7 @@ target_ulong tinfo_csr_read(CPURISCVState *env)
> >   {
> >       /* assume all triggers support the same types of triggers */
> >       return BIT(TRIGGER_TYPE_AD_MATCH) |
> > +           BIT(TRIGGER_TYPE_INST_CNT) |
> >              BIT(TRIGGER_TYPE_AD_MATCH6);
> >   }
> 

