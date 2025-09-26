Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38871CAC5B0
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Sep 2025 00:15:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1w6E-0003XB-Fe; Thu, 25 Sep 2025 20:14:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v1w65-0003M7-Vs
 for qemu-devel@nongnu.org; Thu, 25 Sep 2025 20:14:05 -0400
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v1w5z-0005ac-Jy
 for qemu-devel@nongnu.org; Thu, 25 Sep 2025 20:14:00 -0400
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-3352018e050so928866a91.2
 for <qemu-devel@nongnu.org>; Thu, 25 Sep 2025 17:13:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758845628; x=1759450428; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=6rOmgNXWN2hFSW1tyDiSBxLh6AGt5fNzi+gsoWP2Xv4=;
 b=XCmJm3YM3vaBTHLWieZseiJyqM+Innm4sV3BQ77ZrZslwzfUSlnINy9NTtqQpEOTyF
 MYrbfu08eugDvyfH21Mr0ahtKfmIWEidKjJQQS2kfk5MWxIMq4CIOI625NdZDxRSJGva
 49TZVrnYZB+Pg1Psk6Pj1geix8Y7kOfgePRyqGRrhafpgSxH5D5aCatu2EcRDxUkIhP0
 LeM03MTgXXATUup1vER9iBTdN4b1PKnH1FTWxJpI8MvPUIJAv3I0Dxz4EaI01pQyAMsI
 MigestWQVt7dI1TZ2eBd/2ObdiHhY4uO/SRfbHOQu6pmA0jk9DK3dJgWHZh9hKKMku/8
 Wq9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758845628; x=1759450428;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6rOmgNXWN2hFSW1tyDiSBxLh6AGt5fNzi+gsoWP2Xv4=;
 b=hVlVuSP4gfT0Xq3SsKWhd4o1s5sqNDr4ph5EcipTJrNzWVSLBkn7zk7If4zQZ9VPwF
 FmOmu9txQ//796p1GowlO/ncq8tEdm4IoZztt9w68XpY85nD03Be4tFUd1br7/eiTSzq
 QBNMVaci5hUE6o/8Si+aZGI1ihmrTIC81u1GKZSeOYJ/XdFD2UWCMnuONHqvEWTs1dSN
 D9zs3+U39ZVi23L5ivDozMJwVS58rN+x8lJ1xodnTYH32BzBl5WlCKT8J9b7T7dIkGwV
 UPOAWnzcMH/fLzELoco4jmo9Y9di+QmwYAFjwY42SGuhVTybunmVdL1Gz0u6ZJbkoK46
 2www==
X-Forwarded-Encrypted: i=1;
 AJvYcCVc39E5ndpChfmoCnBX0AZzqI99dsCEpSHwSYqntoFT/CUQA4h6jS497h0yZCpt0owL44lIeVcTlIco@nongnu.org
X-Gm-Message-State: AOJu0YyNZQ5n4Mpg2P1/c+E53KTN8Jk5PU/bsIS7eANBekp2ylxNnAuu
 UgGZ4kQj+1VhZip32Gq9mi9IUPdKTci01taFCfJ08PG7jzJzmEr8+vHy/+s9egvCM57FH6eM8Tk
 NKpkd
X-Gm-Gg: ASbGncvczkzfM7QfeTBEkeB1DxNayN60EheMbcPvoh371JHymps9bmhxZadjEL3HkvV
 t0e7VTXPHwsjH9HjCQd4cQSfjMjCeZD6cXvHKyCHp1P7/O1oe5iyJ+ZpMoZ8Hezyo5rmTlmmhkS
 zZ6D9q7v0l6Ae2kkC3g9i7IVmUD1zPis3m9lJxaGu1DbzZu4yI922S+86pwy5QsvNktpaywWC5f
 01sGNv5++NOUo0xmE4YlmoLOuv79ihWhZ2UV4CXl3PfzS9tfva+bHWJtp0sTUNPTrJK3WSkZHwd
 T9A5PO+FqvLL7ismvin6LmB26ynjgFL3Tn6bIn+Nu292WE5VwcXzi71g1zelvxJoRLOfPc+3qWK
 RogXDOvOy6no6z2wqOEuwm6VSaBXHjedU7Eja
X-Google-Smtp-Source: AGHT+IHjzNhQXM2undpvRXVCOx4eK2pIU36aU+PdsAjPQ38xYN6XlqUqgJMcComhc/p5Ev0rvzJyfg==
X-Received: by 2002:a17:90b:1b4e:b0:335:228c:6f1f with SMTP id
 98e67ed59e1d1-335228c6fecmr2564314a91.12.1758845627883; 
 Thu, 25 Sep 2025 17:13:47 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.157.132])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3341be45620sm7017073a91.29.2025.09.25.17.13.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 25 Sep 2025 17:13:47 -0700 (PDT)
Message-ID: <645808ee-7fb3-4409-af62-c5dab3abf39e@linaro.org>
Date: Thu, 25 Sep 2025 17:13:46 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] accel/hvf: Make async_safe_run_on_cpu() safe
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20250925025520.71805-1-philmd@linaro.org>
 <20250925025520.71805-4-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20250925025520.71805-4-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102a.google.com
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

On 9/24/25 19:55, Philippe Mathieu-Daudé wrote:
> Wrap hv_vcpu_run() calls with cpu_exec_start/end() in order to
> have the main loop perform more exclusive sections while all
> vCPUs are quiescent.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
> Could be related to the dubious thread_kicked access and pselect() in
> hvf_wait_for_ipi() (commit 219c101fa7f "arm/hvf: Add a WFI handler").
> 
> Cc: Peter Collingbourne <pcc@google.com>
> Cc: Alexander Graf <agraf@csgraf.de>
> Cc: Roman Bolshakov <r.bolshakov@yadro.com>
> Cc: Sergio Lopez <slp@redhat.com>
> ---
>   target/arm/hvf/hvf.c  | 2 ++
>   target/i386/hvf/hvf.c | 2 ++
>   2 files changed, 4 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

> 
> diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
> index b77db99079e..377eb4bbc6b 100644
> --- a/target/arm/hvf/hvf.c
> +++ b/target/arm/hvf/hvf.c
> @@ -1927,7 +1927,9 @@ int hvf_vcpu_exec(CPUState *cpu)
>       flush_cpu_state(cpu);
>   
>       bql_unlock();
> +    cpu_exec_start(cpu);
>       r = hv_vcpu_run(cpu->accel->fd);
> +    cpu_exec_end(cpu);
>       bql_lock();
>       switch (r) {
>       case HV_SUCCESS:
> diff --git a/target/i386/hvf/hvf.c b/target/i386/hvf/hvf.c
> index 8445cadecec..913ad47f3d8 100644
> --- a/target/i386/hvf/hvf.c
> +++ b/target/i386/hvf/hvf.c
> @@ -749,8 +749,10 @@ int hvf_vcpu_exec(CPUState *cpu)
>               return EXCP_HLT;
>           }
>   
> +        cpu_exec_start(cpu);
>           hv_return_t r = hv_vcpu_run_until(cpu->accel->fd, HV_DEADLINE_FOREVER);
>           assert_hvf_ok(r);
> +        cpu_exec_end(cpu);
>   
>           /* handle VMEXIT */
>           uint64_t exit_reason = rvmcs(cpu->accel->fd, VMCS_EXIT_REASON);


