Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D1FACD4851
	for <qemu-devel@archiver.kernel.org>; Sat, 16 May 2026 18:21:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wOJdX-0006D7-Ll; Sat, 16 May 2026 14:21:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wOJdV-0006Cj-Qi
 for qemu-devel@nongnu.org; Sat, 16 May 2026 14:21:18 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wOJdU-0000LQ-1e
 for qemu-devel@nongnu.org; Sat, 16 May 2026 14:21:17 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-835399c11e0so402099b3a.0
 for <qemu-devel@nongnu.org>; Sat, 16 May 2026 11:21:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778955674; x=1779560474; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=TGCdv6On3YAfSxYqRHBeIe2InDqi7ySRsainmstbZiM=;
 b=RPM9SMGolqkj0NTQQrJCUY3k5BqyDeCMCIlre5PDErl+m3jdb3aMTKZ3IhZcJSnPy1
 xgTf4zCIymcLG5G3YVlMJPX3iHyGrJnMV3zUU8mpMTYF5S2L16US79vMJNdKkTXxvUK7
 BwRKUGvjl2dhL9ZbwVR/ZzfamKJohNEdhijF6cEfdnMjvfjHTwqHtTJD/AyZncsm1xoE
 7Fwr11aAMEU3kL99wVoOv4TfcbMRoYJCStxNgOmB47R9krWE73iVenPmGAEvIf7KLELd
 sEN1/X5FK56oxUYylNJ55dMuRoTUvMu4Y3zP+Dtc8JcnzHK+LekxPoE82N0h5uMIJiVF
 2LXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778955674; x=1779560474;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TGCdv6On3YAfSxYqRHBeIe2InDqi7ySRsainmstbZiM=;
 b=Dtu5coS33Qd0kopTkN9BARIwROUSPEQg5en8W4X03QqUrSWvL5p9KJL0mRS1xLeBg2
 Pgwq5+QM273lZ1/2ZlhSNdR+/hi+NDS0Yg+AT3ZylcpMW33BvbXc+LoQUM2BMXqDWSno
 i+qdvFyar8LdLhIj+43JKwSt7lmM9DDnIw1haXN81vtiFJEDlDrJ1rB79mF4QMtQQPE7
 MCCiVhzJVwjVm4aoKWiIiQZ9fAv+erVx1tDGnhgVgkTqKNQHe9IIKHjJHSTopTWUpTMB
 TDJochwBH1n8GwWH9Jp0a8xN3VVzfvZ64z7VpAcn2cJeksjlPuNSci8BRvFmrn9SnBLG
 +r5Q==
X-Gm-Message-State: AOJu0YxWsBoi+qSlwq76W59jly72x8rVE6/E95svoyxmeElTbWnK6QEp
 N/ZzQ+PW80wxEc2l9TRQRAj2l14zAPJ5cp8Qk6CkJQO24p1FyuwMSjBVsDGSTNa0+iC48J1Ucqw
 hYb1f
X-Gm-Gg: Acq92OFr7vpML1cVPwdbPkf/grdUi7VNPbD8dHXuyaRvv5gRUG3I/KNyP9uRqZgAjoH
 7OL/qdeqld/xus94lUZwpstxFkYGTlgwU/BtBUb8xRwzW+r3ZcgS4DoSqiZ5RRV3oRoNajyAMe9
 +B0jlWV2A+bt+IatWdJ3/oGlK/fjD5KvnKMLoq+co1qfovCCEGSONmnYi9cdlLxk+vTzJDIrrXe
 hnf8w/crDxJQeiEFmOGWFCmDcHLi5D2xWsLKu5+GOEOu7RPJex35GxiG0w+lf7WKuYcjuGTofpc
 S+i5BPUidJZ67G3h+DISkIibcn+OLw7TbYViunnryzAaqrUoJsAfbHZRgNXS2SvcGtrINQwnUtH
 QUe6zDbD68DHLkeuN+ux9oZLCNhrRhSTrbOw923hbl72K/Cke55c2EEVtgmmIZxxxBR8zWmDSqi
 hgPQzv0gbuQzqaQsON/wgjn7e2uGaDZ/sgtk0c
X-Received: by 2002:a05:6a00:398d:b0:82a:6d3d:9ba1 with SMTP id
 d2e1a72fcca58-83f33d9dd1bmr8583471b3a.24.1778955673992; 
 Sat, 16 May 2026 11:21:13 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.142.33])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-83f1979a0b2sm9516143b3a.26.2026.05.16.11.21.13
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 16 May 2026 11:21:13 -0700 (PDT)
Message-ID: <b7d98341-b669-4fea-b0e4-3b1572428548@linaro.org>
Date: Sat, 16 May 2026 11:21:11 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] linux-user/sh4: Fix target_ucontext tuc_link field
 type
To: qemu-devel@nongnu.org
References: <20260514165526.1530386-1-mattst88@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260514165526.1530386-1-mattst88@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42f.google.com
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

On 5/14/26 09:55, Matt Turner wrote:
> tuc_link is declared as 'struct target_ucontext *', which is a HOST
> pointer.  On a 64-bit host running a 32-bit SH4 target, this is 8 bytes
> instead of the 4 bytes the target expects, padding pushes tuc_mcontext
> 8 bytes past its correct offset.
> 
> When a signal handler receives ucontext_t *, every field accessed through
> uc_mcontext (gregs[], pc, pr, ...) is read from the wrong address.  In
> particular the saved PC comes back as a garbage stack value, which breaks
> any code that initialises a libunwind cursor from the signal context.
> 
> Fix it by using abi_ulong, which is always sized to the target ABI (4
> bytes for SH4), matching the layout the kernel and glibc agree on.  This
> is the same pattern used by arm/signal.c.
> 
> Also remove the (unsigned long *) cast from the __put_user that zeros
> tuc_link.  The cast was harmless when tuc_link was pointer-sized (8
> bytes matching unsigned long on a 64-bit host), but after the type
> change __put_user's sizeof dispatch would select stq_le_p (8-byte write)
> for a now-4-byte field, silently overwriting the start of tuc_stack.
> 
> Neither this fix nor the companion setup_sigtramp fix is independently
> sufficient: this fix corrects register values read from the signal context
> but libunwind still cannot detect the frame without the correct trampoline
> pattern; that fix makes the frame detectable but register reads remain
> garbage without the correct ucontext layout.  Together they fix the
> following libunwind tests on a 64-bit host:
>    Gtest-sig-context, Gtest-trace, Ltest-init-local-signal,
>    Ltest-sig-context, Ltest-trace
> 
> Signed-off-by: Matt Turner <mattst88@gmail.com>
> Cc: qemu-stable@nongnu.org
> ---
>   linux-user/sh4/signal.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git ./linux-user/sh4/signal.c ./linux-user/sh4/signal.c
> index 9ecc026fae..20d2bc8b2c 100644
> --- ./linux-user/sh4/signal.c
> +++ ./linux-user/sh4/signal.c
> @@ -57,7 +57,7 @@ struct target_sigframe
>   
>   struct target_ucontext {
>       target_ulong tuc_flags;
> -    struct target_ucontext *tuc_link;
> +    abi_ulong tuc_link;

abi_ptr.

Otherwise,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

>       target_stack_t tuc_stack;
>       struct target_sigcontext tuc_mcontext;
>       target_sigset_t tuc_sigmask;        /* mask last for extensibility */
> @@ -237,7 +237,7 @@ void setup_rt_frame(int sig, struct target_sigaction *ka,
>   
>       /* Create the ucontext.  */
>       __put_user(0, &frame->uc.tuc_flags);
> -    __put_user(0, (unsigned long *)&frame->uc.tuc_link);
> +    __put_user(0, &frame->uc.tuc_link);
>       target_save_altstack(&frame->uc.tuc_stack, regs);
>       setup_sigcontext(&frame->uc.tuc_mcontext,
>                        regs, set->sig[0]);


