Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50A5ED0EE12
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2024 17:06:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1szJ48-0000qN-4a; Fri, 11 Oct 2024 13:04:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>)
 id 1szJ43-0000hD-Dp; Fri, 11 Oct 2024 13:04:31 -0400
Received: from mx.treblig.org ([2a00:1098:5b::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>)
 id 1szIhv-0007Hs-4o; Fri, 11 Oct 2024 12:41:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
 ; s=bytemarkmx;
 h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
 :Subject; bh=0zqa5tnDqkjjfS8FhzEtcztGzsWJG65KY93UHFJK5fo=; b=VMpoc7pKBrS/mCqk
 TWuNOyOzamuuTJ6UI6YtqpfdzasAUJS/EPiC4aGXrekv516kF5hLBOPVH8Qy1oZOrW0Pb2sQ+qr05
 RaDWBMS73abzJkaGHxSUpnnJfNRVBkC8opakvkCANUyarIZT5Ju4JgWx1tMyE5Dj4xtlr3XWwvWae
 lk6rP1jn4wN/sBDd48/+aIF4RckIH2HqQLdmM37Bp6W47UxT5jWd9lZx9z1UgOZ/oL4/YQzuMkD56
 S2PBPIgeQDdP4x5ZkDHDzfGX+RvhqhgQPX5WANPfVKDOKP3lPYyuHfuSXSvR3am51OkLfZR97QlKb
 9clAtXaCRH7rowW1Kg==;
Received: from dg by mx.treblig.org with local (Exim 4.96)
 (envelope-from <dg@treblig.org>) id 1szIhc-00AYxy-3C;
 Fri, 11 Oct 2024 16:41:20 +0000
Date: Fri, 11 Oct 2024 16:41:20 +0000
From: "Dr. David Alan Gilbert" <dave@treblig.org>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Laurent Vivier <laurent@vivier.eu>,
 qemu-trivial@nongnu.org
Subject: Re: [PATCH] linux-user/vm86: Fix compilation with Clang
Message-ID: <ZwlVMKJG3adNfNTR@gallifrey>
References: <20241011161845.417342-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20241011161845.417342-1-thuth@redhat.com>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.1.0-21-amd64 (x86_64)
X-Uptime: 16:41:03 up 156 days,  3:55,  1 user,  load average: 0.00, 0.01, 0.00
User-Agent: Mutt/2.2.12 (2023-09-09)
Received-SPF: pass client-ip=2a00:1098:5b::1; envelope-from=dg@treblig.org;
 helo=mx.treblig.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

* Thomas Huth (thuth@redhat.com) wrote:
> Since commit 95b9c27c81 ("linux-user: Remove unused handle_vm86_fault")
> a bunch of other "static inline" function are now unused, too. Clang
> warns about such unused "static inline" functions in .c files, so the
> build currently breaks when compiling with "--enable-werror". Remove
> the unused functions to get it going again.
> 
> Fixes: 95b9c27c81 ("linux-user: Remove unused handle_vm86_fault")
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Sorry about that - thanks for the fix!

Reviewed-by: Dr. David Alan Gilbert <dave@treblig.org>

> ---
>  linux-user/vm86.c | 65 -----------------------------------------------
>  1 file changed, 65 deletions(-)
> 
> diff --git a/linux-user/vm86.c b/linux-user/vm86.c
> index 31a2d707cf..5091d53fb8 100644
> --- a/linux-user/vm86.c
> +++ b/linux-user/vm86.c
> @@ -47,30 +47,6 @@ static inline void vm_putw(CPUX86State *env, uint32_t segptr,
>      cpu_stw_data(env, segptr + (reg16 & 0xffff), val);
>  }
>  
> -static inline void vm_putl(CPUX86State *env, uint32_t segptr,
> -                           unsigned int reg16, unsigned int val)
> -{
> -    cpu_stl_data(env, segptr + (reg16 & 0xffff), val);
> -}
> -
> -static inline unsigned int vm_getb(CPUX86State *env,
> -                                   uint32_t segptr, unsigned int reg16)
> -{
> -    return cpu_ldub_data(env, segptr + (reg16 & 0xffff));
> -}
> -
> -static inline unsigned int vm_getw(CPUX86State *env,
> -                                   uint32_t segptr, unsigned int reg16)
> -{
> -    return cpu_lduw_data(env, segptr + (reg16 & 0xffff));
> -}
> -
> -static inline unsigned int vm_getl(CPUX86State *env,
> -                                   uint32_t segptr, unsigned int reg16)
> -{
> -    return cpu_ldl_data(env, segptr + (reg16 & 0xffff));
> -}
> -
>  void save_v86_state(CPUX86State *env)
>  {
>      CPUState *cs = env_cpu(env);
> @@ -131,19 +107,6 @@ static inline void return_to_32bit(CPUX86State *env, int retval)
>      env->regs[R_EAX] = retval;
>  }
>  
> -static inline int set_IF(CPUX86State *env)
> -{
> -    CPUState *cs = env_cpu(env);
> -    TaskState *ts = get_task_state(cs);
> -
> -    ts->v86flags |= VIF_MASK;
> -    if (ts->v86flags & VIP_MASK) {
> -        return_to_32bit(env, TARGET_VM86_STI);
> -        return 1;
> -    }
> -    return 0;
> -}
> -
>  static inline void clear_IF(CPUX86State *env)
>  {
>      CPUState *cs = env_cpu(env);
> @@ -162,34 +125,6 @@ static inline void clear_AC(CPUX86State *env)
>      env->eflags &= ~AC_MASK;
>  }
>  
> -static inline int set_vflags_long(unsigned long eflags, CPUX86State *env)
> -{
> -    CPUState *cs = env_cpu(env);
> -    TaskState *ts = get_task_state(cs);
> -
> -    set_flags(ts->v86flags, eflags, ts->v86mask);
> -    set_flags(env->eflags, eflags, SAFE_MASK);
> -    if (eflags & IF_MASK)
> -        return set_IF(env);
> -    else
> -        clear_IF(env);
> -    return 0;
> -}
> -
> -static inline int set_vflags_short(unsigned short flags, CPUX86State *env)
> -{
> -    CPUState *cs = env_cpu(env);
> -    TaskState *ts = get_task_state(cs);
> -
> -    set_flags(ts->v86flags, flags, ts->v86mask & 0xffff);
> -    set_flags(env->eflags, flags, SAFE_MASK);
> -    if (flags & IF_MASK)
> -        return set_IF(env);
> -    else
> -        clear_IF(env);
> -    return 0;
> -}
> -
>  static inline unsigned int get_vflags(CPUX86State *env)
>  {
>      CPUState *cs = env_cpu(env);
> -- 
> 2.46.1
> 
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

