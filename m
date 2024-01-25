Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BF43C46CD2
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jan 2024 00:23:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSnVy-0003Wn-NT; Wed, 24 Jan 2024 19:22:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rSnVs-0003Ol-GN
 for qemu-devel@nongnu.org; Wed, 24 Jan 2024 19:22:36 -0500
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rSnVq-0003zT-3k
 for qemu-devel@nongnu.org; Wed, 24 Jan 2024 19:22:35 -0500
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-6dd80d3d419so1910909b3a.3
 for <qemu-devel@nongnu.org>; Wed, 24 Jan 2024 16:22:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706142152; x=1706746952; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=QVOp7RdjqpVihjsRswW9QJeEHC9sgZcJs+J73ooG7Bo=;
 b=lJDS7pphCj6D7IgQMX++NFl7OtIfCp5MvWoFPLXxyO/TUlz3EPlB/ook81zRzLgVFb
 2eyYUJkYAkcHgrtwzOROvxR7gsKwdln6EB2r1XOUPbt2/BK9InEoDJs1Y21ePtMhrdX1
 Ka8ecRc911qBquEntOeV/NuRUcABuXlEIMUt4KOYQlFI3VRDC+GdHDo8r3o5nQICd3E/
 M2K0AM3pDrfy0LF2mPHmjilhQ2fQ0s2utjNvrmhk1G581lPsZcDGHbG+XVv2DR7Q4Qvm
 W35hwuIhLlZidGSlSDJ04A08JraM6fwSZaJbyLi7jsGEQypeSUt37RkXn7JljKpHsGHa
 iVGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706142152; x=1706746952;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=QVOp7RdjqpVihjsRswW9QJeEHC9sgZcJs+J73ooG7Bo=;
 b=tGohDXCWekoJRTgRYi2CaRUDEDdKynJNA4A7qCKFHeb7vBK5Sew107SXviYJ6VqHaW
 gnUBH45ue50CXeat8sjT96vOcmEz5yZJ4M2QlvWw4CzcLg1E3k+i6WrZUxf/m1ODTGbI
 wzEyTk0YJzIk97KP4VkYlGB5WPDUZdEbRYQymmE2DpxS/qoG9F5hH7euoCMZ4nzbzDnk
 c+96u9rnr78dNlXE647IYClck2prYcfTA81EfmL/4vqERvAtYJ7afiV4bsfhr7xw/fSx
 fsQfEFxuJ2h6alo7pwbuaj9wbH0X1hLLXr3emMJ+feCx15P8vFqjw2wDB8yXise4ZYKD
 WiFg==
X-Gm-Message-State: AOJu0YwUgBJ4srgsyBtor6mL/4X7h33QRd4SPRf6QkqbzqPUTzsVXHg9
 JZ4AgfBy7n9+/Ut2StkG11PDkcxEKCWB8yEN8nhhu5Rgcyqrwcct9S10COxfP74=
X-Google-Smtp-Source: AGHT+IGa/JuXCuKyfoJ5PpsAxH1qdZlwLtHw83Lw71xiZJmz7r971UIeGkHWIGIxT7Q4Y17Wh9bA4g==
X-Received: by 2002:a05:6a00:3:b0:6da:2898:1d6c with SMTP id
 h3-20020a056a00000300b006da28981d6cmr46833pfk.51.1706142152010; 
 Wed, 24 Jan 2024 16:22:32 -0800 (PST)
Received: from ?IPV6:2001:44b8:2176:c800:5fcf:9e3:2e58:9c7?
 (2001-44b8-2176-c800-5fcf-09e3-2e58-09c7.static.ipv6.internode.on.net.
 [2001:44b8:2176:c800:5fcf:9e3:2e58:9c7])
 by smtp.gmail.com with ESMTPSA id
 o6-20020a62f906000000b006dbd3aec001sm8454249pfh.146.2024.01.24.16.22.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 24 Jan 2024 16:22:31 -0800 (PST)
Message-ID: <7fc5e75b-4968-4df8-818c-ab2c4c758531@linaro.org>
Date: Thu, 25 Jan 2024 10:22:26 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: hexagon: modeling a shared lock state
Content-Language: en-US
To: Brian Cain <bcain@quicinc.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Sid Manning <sidneym@quicinc.com>, Marco Liebel <mliebel@qti.qualcomm.com>,
 Matheus Bernardino <mathbern@qti.qualcomm.com>
References: <CH3PR02MB102479550F96F09E0C9D50BA7B87B2@CH3PR02MB10247.namprd02.prod.outlook.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <CH3PR02MB102479550F96F09E0C9D50BA7B87B2@CH3PR02MB10247.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 1/25/24 01:07, Brian Cain wrote:
> Philippe,
> 
> For hexagon sysemu, while internally reviewing patches to be upstreamed we noticed that 
> our design for a lock instruction is not quite suitable.  The k0lock instruction will halt 
> if some other hexagon hardware CPU has already claimed the kernel lock, only to continue 
> executing once some CPU executes the unlock instruction.  We modeled this using a lock 
> state enumeration member { OWNER, WAITING, UNLOCKED } in **each** vCPU and atomically 
> transitioning the lock required us to have vCPU[n] write the updated lock state to vCPU[m] 
> when unlocking.
> 
> In context: 
> https://github.com/quic/qemu/blob/hexagon_sysemu_20_dec_2023/target/hexagon/op_helper.c#L1790-L1821 <https://github.com/quic/qemu/blob/hexagon_sysemu_20_dec_2023/target/hexagon/op_helper.c#L1790-L1821>
> 
> So instead, maybe it makes more sense to have a system device hold a single representation 
> of the lock’s state and each vCPU can do some kind of access via load/store and/or 
> interrupts to/from the device?  I was thinking of raising an interrupt on the lock device 
> at the vCPU’s k0lock instruction to indicate demand for the lock, and then the device 
> could raise an interrupt to one of the vCPUs when it’s granted the lock.  One drawback for 
> this is that this might add significant latency to the uncontested lock case.  So I also 
> considered doing a load of some part of the lock device’s memory that could indicate 
> whether the lock was available, and if available it would claim it with a store (both 
> ld/st while holding BQL).  Only if unavailable it would halt and raise the interrupt.  Is 
> it possible to create an address space that’s independent of the true system memory map 
> for this use case or would we need to carve out some memory from the existing memory map 
> for this synthetic device?  Or – do you have a suggestion for a better approach overall?

I think you are over-thinking this.  A system device would just get in the way.  I think 
you want something like

   struct CPUHexagonState {
     ...
     bool hwlock_pending;
   }

   hexagon_cpu_has_work() {
     if (cpu->hwlock_pending) {
       return false;
     }
   }

   static void do_hwlock(CPUHexagonState *env, bool *lock)
   {
     bql_lock();

     if (*lock) {
       env->hwlock_pending = true;
       cs->halted = true;
       cs->exception_index = EXCP_HALTED;
       bql_unlock();
       cpu_loop_exit(cs);
     } else {
       *lock = true;
       bql_unlock();
     }
   }

   static void do_hwunlock(CPUHexagonState *env, bool *lock)
   {
     CPUState *cs;
     BQL_LOCK_GUARD();

     *lock = false;

     CPU_FOREACH(cs) {
       if (cs->hwlock_pending) {
         cs->hwlock_pending = false;
         qemu_cpu_kick(cs);
       }
     }
   }

   static bool k0lock, tlblock;

   void HELPER(k0lock)(CPUHexagonState *env)
   void HELPER(tlblock)(CPUHexagonState *env)
   void HELPER(k0unlock)(CPUHexagonState *env)
   void HELPER(tlbunlock)(CPUHexagonState *env)

Open questions are:

(1) Do interrupts cancel lock wait?  Either way, placement in hexagon_cpu_has_work is key.

(2) I assume that the pc will not be advanced, so that after the kick we will re-execute 
the hwlock instruction.  There will be a thundering herd racing to grab the lock again, 
but it saves queuing logic, which might be complicated if interrupts are involved.


r~

