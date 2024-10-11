Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FABED24470
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2024 17:12:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1szJ4M-00010z-Bw; Fri, 11 Oct 2024 13:04:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1szJ4J-0000wP-Gg
 for qemu-devel@nongnu.org; Fri, 11 Oct 2024 13:04:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1szI6f-0002ac-4g
 for qemu-devel@nongnu.org; Fri, 11 Oct 2024 12:03:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728662582;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=gP27aY80OEMMf4Goo9mZ/ptlgcrANELfxtLltyqEt4U=;
 b=QVziwHRc1UuBikXDgR+ttnZ4qCl12eA5z2KJOgDHBzJuTMNrs9Fkd4FlRsY6Z299NH2p3O
 Zqz45kNLF3FY5jKH/xf8pfCFgPhSDaJ1X/qFyiBNhFaZ5S8OW3j1CYacXwpp6dYBD3emO3
 esEomr/uihAFibUAJnsTfLYimVDASTk=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-122-WhmleQYhM2GYYhmV6NKhGQ-1; Fri, 11 Oct 2024 12:02:59 -0400
X-MC-Unique: WhmleQYhM2GYYhmV6NKhGQ-1
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-7ac8f684cdaso343932985a.3
 for <qemu-devel@nongnu.org>; Fri, 11 Oct 2024 09:02:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728662579; x=1729267379;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gP27aY80OEMMf4Goo9mZ/ptlgcrANELfxtLltyqEt4U=;
 b=IFJtWFrnYPogVXFqwN/N82bHBPe34vwnPhF2Ki0O06M0a3PddMiivP6DRCYEpnKYDo
 oedFWtnwSewdQD1QbUcIdAl/c+yhnQbkcTYF5uZMZEwvlsg7vE0m225EYKAx2OTCgGTY
 KnMd+B96zlzvdWA/PKs/0JerR2suYhwpIthwpj8Y0gC0Aixyke7cGGzq/1Wc5N7z6mp3
 iW9tmlO+yH59zg4B0tGk7Tz0CMnWTQDHKbJ94qMJQaBULo212xnrG4SyHHpV75zxX8d4
 qMQTzMB12LG3stnoAGazIT6j/Ko+nydLfl5iRYySJDmByQpPAb+Yw7inM3lcXNtP/OfL
 iPXw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUajcpHcaFvLgqI0EQqJ0NAn0G8lq+hyR+xiPQWylvRIMdOIUP+kGR6hsnOfYgGquRaghM9TomnxZFr@nongnu.org
X-Gm-Message-State: AOJu0Yzs13wt+X66IErYAFLAvr/BUw4tgOMIkNcoDL5/c1s3zN7xQv6V
 DxsPa4Db354F7uw7gDz1EB6xk4mZ8TYwoSYzlM4C00W0r0Btev/SElFf1pmXb4BJRZ5XMuelsuf
 /zXUU2wutu4dvaclzjpZ5fPFOTQ6pcm6QCS4Bpo5PwF5GwyE48++j
X-Received: by 2002:a05:620a:1aa2:b0:7a3:5f3f:c084 with SMTP id
 af79cd13be357-7b11a37c95bmr380621685a.30.1728662578923; 
 Fri, 11 Oct 2024 09:02:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGZuPi69rNLyz75MFkx9MlotY1HNuVHeKpL6Te8ml/8P5fbtqKI4NZhClvjRj5PCCIMzeVufA==
X-Received: by 2002:a05:620a:1aa2:b0:7a3:5f3f:c084 with SMTP id
 af79cd13be357-7b11a37c95bmr380615985a.30.1728662578314; 
 Fri, 11 Oct 2024 09:02:58 -0700 (PDT)
Received: from [192.168.0.7] (ip-109-42-51-26.web.vodafone.de. [109.42.51.26])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-460427e20d5sm16633111cf.37.2024.10.11.09.02.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 11 Oct 2024 09:02:57 -0700 (PDT)
Message-ID: <c48513a2-a58f-4d41-a1c4-f04b82325894@redhat.com>
Date: Fri, 11 Oct 2024 18:02:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 10/23] linux-user: Remove unused handle_vm86_fault
To: Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org
Cc: "Dr. David Alan Gilbert" <dave@treblig.org>, qemu-trivial@nongnu.org
References: <20241004160331.1282441-1-mjt@tls.msk.ru>
 <20241004160331.1282441-11-mjt@tls.msk.ru>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20241004160331.1282441-11-mjt@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.15,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 04/10/2024 18.03, Michael Tokarev wrote:
> From: "Dr. David Alan Gilbert" <dave@treblig.org>
> 
> handle_vm86_fault has been unused since:
>    1ade5b2fed ("linux-user/i386: Split out maybe_handle_vm86_trap")
> 
> Remove it, and it's local macros.
> 
> Signed-off-by: Dr. David Alan Gilbert <dave@treblig.org>
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> Reviewed-by: Michael Tokarev <mjt@tls.msk.ru>
> Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
> ---
>   linux-user/user-internals.h |   1 -
>   linux-user/vm86.c           | 136 ------------------------------------
>   2 files changed, 137 deletions(-)
> 
> diff --git a/linux-user/user-internals.h b/linux-user/user-internals.h
> index 5c7f173ceb..46ffc093f4 100644
> --- a/linux-user/user-internals.h
> +++ b/linux-user/user-internals.h
> @@ -102,7 +102,6 @@ int host_to_target_waitstatus(int status);
>   /* vm86.c */
>   void save_v86_state(CPUX86State *env);
>   void handle_vm86_trap(CPUX86State *env, int trapno);
> -void handle_vm86_fault(CPUX86State *env);
>   int do_vm86(CPUX86State *env, long subfunction, abi_ulong v86_addr);
>   #elif defined(TARGET_SPARC64)
>   void sparc64_set_context(CPUSPARCState *env);
> diff --git a/linux-user/vm86.c b/linux-user/vm86.c
> index 9f512a2242..31a2d707cf 100644
> --- a/linux-user/vm86.c
> +++ b/linux-user/vm86.c
> @@ -255,142 +255,6 @@ void handle_vm86_trap(CPUX86State *env, int trapno)
>       }
>   }
>   
> -#define CHECK_IF_IN_TRAP() \
> -      if ((ts->vm86plus.vm86plus.flags & TARGET_vm86dbg_active) && \
> -          (ts->vm86plus.vm86plus.flags & TARGET_vm86dbg_TFpendig)) \
> -                newflags |= TF_MASK
> -
> -#define VM86_FAULT_RETURN \
> -        if ((ts->vm86plus.vm86plus.flags & TARGET_force_return_for_pic) && \
> -            (ts->v86flags & (IF_MASK | VIF_MASK))) \
> -            return_to_32bit(env, TARGET_VM86_PICRETURN); \
> -        return
> -
> -void handle_vm86_fault(CPUX86State *env)
> -{
> -    CPUState *cs = env_cpu(env);
> -    TaskState *ts = get_task_state(cs);
> -    uint32_t csp, ssp;
> -    unsigned int ip, sp, newflags, newip, newcs, opcode, intno;
> -    int data32, pref_done;
> -
> -    csp = env->segs[R_CS].selector << 4;
> -    ip = env->eip & 0xffff;
> -
> -    ssp = env->segs[R_SS].selector << 4;
> -    sp = env->regs[R_ESP] & 0xffff;
> -
> -    LOG_VM86("VM86 exception %04x:%08x\n",
> -             env->segs[R_CS].selector, env->eip);
> -
> -    data32 = 0;
> -    pref_done = 0;
> -    do {
> -        opcode = vm_getb(env, csp, ip);
> -        ADD16(ip, 1);
> -        switch (opcode) {
> -        case 0x66:      /* 32-bit data */     data32=1; break;
> -        case 0x67:      /* 32-bit address */  break;
> -        case 0x2e:      /* CS */              break;
> -        case 0x3e:      /* DS */              break;
> -        case 0x26:      /* ES */              break;
> -        case 0x36:      /* SS */              break;
> -        case 0x65:      /* GS */              break;
> -        case 0x64:      /* FS */              break;
> -        case 0xf2:      /* repnz */	      break;
> -        case 0xf3:      /* rep */             break;
> -        default: pref_done = 1;
> -        }
> -    } while (!pref_done);
> -
> -    /* VM86 mode */
> -    switch(opcode) {
> -    case 0x9c: /* pushf */
> -        if (data32) {
> -            vm_putl(env, ssp, sp - 4, get_vflags(env));
> -            ADD16(env->regs[R_ESP], -4);
> -        } else {
> -            vm_putw(env, ssp, sp - 2, get_vflags(env));
> -            ADD16(env->regs[R_ESP], -2);
> -        }
> -        env->eip = ip;
> -        VM86_FAULT_RETURN;
> -
> -    case 0x9d: /* popf */
> -        if (data32) {
> -            newflags = vm_getl(env, ssp, sp);
> -            ADD16(env->regs[R_ESP], 4);
> -        } else {
> -            newflags = vm_getw(env, ssp, sp);
> -            ADD16(env->regs[R_ESP], 2);
> -        }
> -        env->eip = ip;
> -        CHECK_IF_IN_TRAP();
> -        if (data32) {
> -            if (set_vflags_long(newflags, env))
> -                return;
> -        } else {
> -            if (set_vflags_short(newflags, env))
> -                return;
> -        }
> -        VM86_FAULT_RETURN;
> -
> -    case 0xcd: /* int */
> -        intno = vm_getb(env, csp, ip);
> -        ADD16(ip, 1);
> -        env->eip = ip;
> -        if (ts->vm86plus.vm86plus.flags & TARGET_vm86dbg_active) {
> -            if ( (ts->vm86plus.vm86plus.vm86dbg_intxxtab[intno >> 3] >>
> -                  (intno &7)) & 1) {
> -                return_to_32bit(env, TARGET_VM86_INTx + (intno << 8));
> -                return;
> -            }
> -        }
> -        do_int(env, intno);
> -        break;
> -
> -    case 0xcf: /* iret */
> -        if (data32) {
> -            newip = vm_getl(env, ssp, sp) & 0xffff;
> -            newcs = vm_getl(env, ssp, sp + 4) & 0xffff;
> -            newflags = vm_getl(env, ssp, sp + 8);
> -            ADD16(env->regs[R_ESP], 12);
> -        } else {
> -            newip = vm_getw(env, ssp, sp);
> -            newcs = vm_getw(env, ssp, sp + 2);
> -            newflags = vm_getw(env, ssp, sp + 4);
> -            ADD16(env->regs[R_ESP], 6);
> -        }
> -        env->eip = newip;
> -        cpu_x86_load_seg(env, R_CS, newcs);
> -        CHECK_IF_IN_TRAP();
> -        if (data32) {
> -            if (set_vflags_long(newflags, env))
> -                return;
> -        } else {
> -            if (set_vflags_short(newflags, env))
> -                return;
> -        }
> -        VM86_FAULT_RETURN;
> -
> -    case 0xfa: /* cli */
> -        env->eip = ip;
> -        clear_IF(env);
> -        VM86_FAULT_RETURN;
> -
> -    case 0xfb: /* sti */
> -        env->eip = ip;
> -        if (set_IF(env))
> -            return;
> -        VM86_FAULT_RETURN;
> -
> -    default:
> -        /* real VM86 GPF exception */
> -        return_to_32bit(env, TARGET_VM86_UNKNOWN);
> -        break;
> -    }
> -}

FYI, looks like this broke compiling with Clang:

../../devel/qemu/linux-user/vm86.c:50:20: error: unused function 'vm_putl' 
[-Werror,-Wunused-function]
    50 | static inline void vm_putl(CPUX86State *env, uint32_t segptr,
       |                    ^~~~~~~
../../devel/qemu/linux-user/vm86.c:56:28: error: unused function 'vm_getb' 
[-Werror,-Wunused-function]
    56 | static inline unsigned int vm_getb(CPUX86State *env,
       |                            ^~~~~~~
../../devel/qemu/linux-user/vm86.c:62:28: error: unused function 'vm_getw' 
[-Werror,-Wunused-function]
    62 | static inline unsigned int vm_getw(CPUX86State *env,
       |                            ^~~~~~~
../../devel/qemu/linux-user/vm86.c:68:28: error: unused function 'vm_getl' 
[-Werror,-Wunused-function]
    68 | static inline unsigned int vm_getl(CPUX86State *env,
       |                            ^~~~~~~
../../devel/qemu/linux-user/vm86.c:165:19: error: unused function 
'set_vflags_long' [-Werror,-Wunused-function]
   165 | static inline int set_vflags_long(unsigned long eflags, CPUX86State 
*env)
       |                   ^~~~~~~~~~~~~~~
../../devel/qemu/linux-user/vm86.c:179:19: error: unused function 
'set_vflags_short' [-Werror,-Wunused-function]
   179 | static inline int set_vflags_short(unsigned short flags, 
CPUX86State *env)
       |                   ^~~~~~~~~~~~~~~~
6 errors generated.

Should be easy to fix, I guess..

  Thomas


