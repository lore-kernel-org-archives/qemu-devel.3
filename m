Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08D64CD5BD1
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 00:56:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRg5M-0001Kj-4S; Mon, 25 May 2026 20:55:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wRg5K-0001KA-Fd
 for qemu-devel@nongnu.org; Mon, 25 May 2026 20:55:54 -0400
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wRg5I-0006r5-Sh
 for qemu-devel@nongnu.org; Mon, 25 May 2026 20:55:54 -0400
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-36974217d4eso6541220a91.2
 for <qemu-devel@nongnu.org>; Mon, 25 May 2026 17:55:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779756951; x=1780361751; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=tzRWXqvRidyKIYieKHlW62MQIGKXolY0ajANB3WZk+4=;
 b=xKJggHaywhFuiFKOMwgDx2kG03l2Ew2AnUC8dbySzh7DLj3CcJTQeKHOwNIWVri1j2
 TI80S2vHoV/HoYPi4dH/pd5LqAlx0iph8lk0fcPRtUlYpImsVyf2bANpiszMwbatag69
 X8O0d4AZ6Xtr/NAwlG+8f+Z/RTpoDNGENHl3TZ/21f3da7yrz/7mCos+H+7RCMMEwrK0
 Pjf/JzTJDzjWKJigMGl8KYMAz5ngg+zmhaFX9bWvVa8Z3rLefPWVlpjiMsDMlFqJwyRk
 N8eZFIuy/aBph+wwkc/NI96Q6g+0y9gSqcS3KfHEAsi9OA9Q5xPYjTBo+1nXOVz7nrsZ
 /oyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779756951; x=1780361751;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=tzRWXqvRidyKIYieKHlW62MQIGKXolY0ajANB3WZk+4=;
 b=LvmSY+6MhiYdPLv6Av0CCk+Ex+GA7xQOe9VdGyudRVKTl+pidkQAxJs+xmAmJ8xbJU
 pHKrRfmG2bqL+JZlc5OSLg4Uxhnx4gtHoUFRmMWToQsJVYvo7MCogNQkLsrGuV1l8bsd
 iV0wzxJh5xTQlEQ06pkByvBXljCuPS9gNy+LRixvVYbark/ubWApyqptc3+xaNOMZcV1
 usLnwIEumtH31FGk8DFOP0m8p8QzSeDVRd4gq9XghsvmEY895PHimNlMYA445CAcrXHR
 JfwHvTX/5jVdC6zn6wJf4GileyNn96Q03rePA6jjVEeMAYKXvoY+MbQIO/gaOvbZ64Kw
 ORgA==
X-Forwarded-Encrypted: i=1;
 AFNElJ8nbZdRxG1Qn9V8bKxccOjPoYwuP3zk2/6eiHfW7w4rUfd9dFW5cgGmHu7+uB9Yv31Eii7PMsEGpMQ3@nongnu.org
X-Gm-Message-State: AOJu0Yy/H+366AbHDNEwayQCGoh1dCawQr7q8uWoaKLAFzN1N51Kl/9M
 HfEs24G0tsHBpZggxQraPqRMu8i0t5FcZMQ783/pnIEn7zNtpzQNn09ziP3k3ah9br0=
X-Gm-Gg: Acq92OHJe9kacy/EbFxwP/S/x2A1c6S2/NXF93i/ydhdsJVhdWr5JI2sZDuMaqs+Fzb
 Pq6SOO4YVPnuZxhKG4b1ERnNDxRvG2YkMR+Swbi9bOPRA/2PDEIpEJeYojz2jugHeOKANs1rf2b
 QVjmEx7Rd1KZiGS55KLOU0sobxNL2uJ79Q9cFnOxhvKzp4qaBuRnpjdJgaYEfVmKBQVGY9diJ7J
 hXxWVxLj8fgxbFVfjHFapRDblp2SwZisQzOoYqVUdXxPPISy1dDPXcrzr/F4h5PAPs7sjO1MX7M
 AinEr2j6YnQGYgB55W1d9roDK0cm+R5eSevkKci3d9MC+y9cyVMktL9Yt9VXkuLCnGKErB8Ci6h
 O1Xit1nCKKLDXAZ4ggKAWrkoG0WXeMCEYJro/HudFeZDvwXF7JTdyNvr4Eyp2j+ZQo0kaED3mFP
 0eK31PHSyxpqcEKXk9qRDm/Z2snOQk1x1Yvncy
X-Received: by 2002:a17:90b:2b4e:b0:35e:d015:d675 with SMTP id
 98e67ed59e1d1-36a67719220mr17290935a91.7.1779756951377; 
 Mon, 25 May 2026 17:55:51 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.142.33])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-36a6c680110sm5560205a91.4.2026.05.25.17.55.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 25 May 2026 17:55:50 -0700 (PDT)
Message-ID: <ee9978fa-5fc5-4f2b-be74-49b01bda74fd@linaro.org>
Date: Mon, 25 May 2026 17:55:49 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] linux-user/sh4: preserve T/M/Q bits across signal
 delivery
To: Matt Turner <mattst88@gmail.com>, qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Yoshinori Sato <yoshinori.sato@nifty.com>, qemu-stable@nongnu.org
References: <20260525152642.4121729-1-mattst88@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260525152642.4121729-1-mattst88@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1036;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1036.google.com
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

On 5/25/26 08:26, Matt Turner wrote:
> QEMU keeps the SH4 T, M and Q status-register bits outside env->sr, in
> the dedicated env->sr_t, env->sr_m and env->sr_q fields; cpu_read_sr()
> folds them back into the architectural SR value and cpu_write_sr()
> splits them back out.
> 
> setup_sigcontext() saved the bare env->sr (so the T/M/Q bits were always
> zero in the signal frame) and restore_sigcontext() wrote the value
> straight back into env->sr without updating sr_t/sr_m/sr_q. As a result
> the T bit was never preserved across signal delivery: on sigreturn the
> interrupted code resumed with whatever T value the signal handler last
> left behind. Any conditional branch (or addc/subc/rotcl/div1, etc.)
> immediately following the interrupted instruction could then take the
> wrong path.
> 
> This is the cause of the long-standing intermittent failures of the
> tests/tcg/multiarch/signals.c test on sh4, which was marked BROKEN. With
> a SIGRTMIN timer firing every millisecond across many threads, the race
> was hit a few percent of the time and corrupted the guest heap, surfacing
> as a SIGSEGV in memset, a malloc assertion, or an rseq registration abort.
> 
> Traced on a deterministic rr recording: a cmp/hi set T=0, the timer
> signal interrupted the very next instruction (a bf), the handler left
> T=1, and the resumed bf took glibc calloc's MORECORE_CLEARS branch,
> using the old top-chunk size as the clear length for a freshly split
> small chunk and running memset off the end of the heap.
> 
> Fix setup_sigcontext()/restore_sigcontext() to use cpu_read_sr() and
> cpu_write_sr() so the T, M and Q bits round-trip correctly, and drop the
> BROKEN annotation on the sh4 signals test.
> 
> Fixes: c3b5bc8ab3 ("SH4: Signal handling for the user space emulator, by Magnus Damm.")
> Cc:qemu-stable@nongnu.org
> ---
>   linux-user/sh4/signal.c       | 12 ++++++++++--
>   tests/tcg/sh4/Makefile.target |  7 -------
>   2 files changed, 10 insertions(+), 9 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

