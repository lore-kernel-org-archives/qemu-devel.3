Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10201CD4F3C
	for <qemu-devel@archiver.kernel.org>; Sat, 16 May 2026 19:27:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wOKfE-0002Br-Br; Sat, 16 May 2026 15:27:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wOKfB-0002BO-Ge
 for qemu-devel@nongnu.org; Sat, 16 May 2026 15:27:05 -0400
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wOKf9-0007TO-Rc
 for qemu-devel@nongnu.org; Sat, 16 May 2026 15:27:05 -0400
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-3697f25d26eso279403a91.1
 for <qemu-devel@nongnu.org>; Sat, 16 May 2026 12:27:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778959621; x=1779564421; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=pC17rVZLDOmwzaCEXRlZ9KFkOknvwdIEowm+TPweffo=;
 b=MhyLhGKiwJu3PDjnvASEKkS0fk1AztBbSsm4/rLEuhfnqpLRWVwN6uamn07aCM3Qgy
 2mMWg/Rlk4o/slxDaK8aHQc6XU79R4bcPraeblWynvtbDhvVk1sSA3pJJN7u1JT7XhBO
 sNFgCbnmWGefN0k+vKhXLhQcObKuMklZymVBy0neKAfGR/2ogzkNBdU6ZhoIeFwotDSX
 Zi4kRKMhFJcxKikUQ6fPakQThnyBuiMdh22hxv2v4PaUKKYWwZZc7H380amWk/0ij4j+
 H6u0NzEz1i33QrLAdjZiJceMivdJkzisZ1PgsX6f0M1qQKF9pbh28/dnRnZ6d255XFBI
 NwTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778959621; x=1779564421;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pC17rVZLDOmwzaCEXRlZ9KFkOknvwdIEowm+TPweffo=;
 b=sgTSqFY/ALv1BVMu8gikUa5Jf0phWIFxzLZEgPqnTJ4v5uBisDkeNHRv62rXDkRsS1
 +R3PXkbPTRK2pcxHkepC5+TyB5qc7MGht+zYTPpuIIS3cVowtN4Gsvy5zlX1JHVp8ckT
 hgju20cK3n5dQbeEZ40Pf9tpcPU1xSIoAAthwjuM3OeU/OPDFKb4slzMRE3pT60rYSVl
 2EhjuEtg4dF/u1mxuOW4o773aRtBzNx0EsSRRETJe35OUOo0Dv1p1vY80XmbuqoBjw0k
 ROHwouzbZjSJRQgfpUVc1+s46HBBmhPT3rT28migqbZSlQTp8YBa4o9CikGMlfTO/G4m
 fehw==
X-Gm-Message-State: AOJu0YytEBfonaaJgf83ftCetl1/U5b4kbLpr00EtdS6Eki5ZAi1EIwf
 ZHdwJvZR9hUl5cN9IptF1Ua9SyQznfk8AV2hdImRRTq1LBDiHmxrS+gS3+0DIabj3P/TGZZuOoh
 FJTD0
X-Gm-Gg: Acq92OHs1rwUolLyLSlh6wnohMbjJeFR+zuiOeO971KsEG5a7pu5Z7UBfmDapmhnDi1
 Kny3V+q3TQvvHZoAGJnB8FjCJJFI7HLtCH+1Us9YUhnYNTC7cpoqZaRH7jm5lVhCrjF+UpeIntc
 LqVy4XdpyeQevxc3qzmpiKBcggNQVYZJ7M10afE3hKBsZqV0VWdmtEVKVYKVZMg76UtMu1RFYev
 MiYbV3WmUuIDqwvcoUfFx6784RXjGnVT0hJ053gjo5rN24BMu1RjhsONqw7RWw6EzP7ZY3RgbDS
 a7jm2VLnLHCYjzAKId0aCtppx76caYG5qJTMAnSGvJ5eanrFMojFMMUh4CH2j76KUG/MHFddjgg
 WGur36/0ukfMQ0qOsGvMEob21eBiLr2Yediw3nESuec8xP6eHYqsfC4DwuPw+KC9QM11m3GVmVr
 v8Dw6BgOz8n5IubX7Q3a8JL8fm4H1nGXeSpXxmsZQSzthiRk4=
X-Received: by 2002:a17:90b:2549:b0:366:4782:1389 with SMTP id
 98e67ed59e1d1-36951b8208dmr8580432a91.14.1778959621314; 
 Sat, 16 May 2026 12:27:01 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.142.33])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c82bb07d2f2sm8406367a12.10.2026.05.16.12.27.00
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 16 May 2026 12:27:00 -0700 (PDT)
Message-ID: <235807cd-8ac1-404d-81d1-cbb2556c4d5c@linaro.org>
Date: Sat, 16 May 2026 12:26:59 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] linux-user/sh4: Fix setup_sigtramp to match Linux
 kernel trampoline pattern
To: qemu-devel@nongnu.org
References: <20260514165526.1530386-1-mattst88@gmail.com>
 <20260514165526.1530386-2-mattst88@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260514165526.1530386-2-mattst88@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1035;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1035.google.com
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
> QEMU used MOVW(2) (0x9300), which loads the syscall number from PC+4,
> instead of the kernel's MOVW(7) (0x9305), which loads from PC+14.  The
> kernel uses five "or r0,r0" nop pads between TRAP_NOARG and the syscall
> number word to reach that offset.  libunwind's unw_is_signal_frame checks
> for the exact kernel byte pattern 0xc3109305 at the frame PC, so QEMU's
> compact layout was not detected, breaking unwinding through signal frames.
> 
> Expand each trampoline from 6 to 16 bytes matching the kernel layout
> defined in arch/sh/kernel/signal_32.c:
> 
>    #define MOVW(n)    (0x9300|((n)-2))  /* Move mem word at PC+n to R3 */
>    #define TRAP_NOARG 0xc310            /* Syscall w/no args (NR in R3) */
>    #define OR_R0_R0   0x200b            /* or r0,r0 (insert to avoid hardware bug) */
> 
>    __put_user(MOVW(7),          &frame->retcode[0]);  /* 0x9305 */
>    __put_user(TRAP_NOARG,       &frame->retcode[1]);  /* 0xc310 */
>    __put_user(OR_R0_R0,         &frame->retcode[2]);  /* 0x200b */
>    __put_user(OR_R0_R0,         &frame->retcode[3]);  /* 0x200b */
>    __put_user(OR_R0_R0,         &frame->retcode[4]);  /* 0x200b */
>    __put_user(OR_R0_R0,         &frame->retcode[5]);  /* 0x200b */
>    __put_user(OR_R0_R0,         &frame->retcode[6]);  /* 0x200b */
>    __put_user((__NR_sigreturn), &frame->retcode[7]);
> 
> The first two halfwords (MOVW(7) || TRAP_NOARG = 0xc3109305) form the
> 32-bit value libunwind checks at the frame PC, followed by two
> OR_R0_R0 halfwords (0x200b200b) at PC+4.  The same layout applies to
> the rt_sigreturn trampoline (lines 366-373 of signal_32.c).
> 
> Neither this fix nor the companion tuc_link fix is independently
> sufficient: this fix makes signal frames detectable but register reads
> remain garbage without the correct ucontext layout; that fix corrects the
> ucontext layout but libunwind still cannot detect the frame without the
> correct trampoline pattern.  Together they fix the following libunwind
> tests on a 64-bit host:
>    Gtest-sig-context, Gtest-trace, Ltest-init-local-signal,
>    Ltest-sig-context, Ltest-trace
> 
> Signed-off-by: Matt Turner<mattst88@gmail.com>
> Cc:qemu-stable@nongnu.org
> ---
>   linux-user/sh4/signal.c | 38 ++++++++++++++++++++++++++++++--------
>   1 file changed, 30 insertions(+), 8 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

Since you're looking at sh4, any chance you'd have time to create the vdso?
See e.g. linux-user/i386/{Makefile.vdso,vdso.S,vdso.ld}.


r~

