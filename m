Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50916C98317
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2026 11:54:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9i1U-00016Z-WA; Thu, 24 Sep 2026 07:53:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mkchauras@gmail.com>)
 id 1x9fVj-0003Dd-Ps
 for qemu-devel@nongnu.org; Thu, 24 Sep 2026 05:12:59 -0400
Received: from mail-dy2-x10.google.com ([2607:f8b0:4864:36::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mkchauras@gmail.com>)
 id 1x9fVg-0001O1-Do
 for qemu-devel@nongnu.org; Thu, 24 Sep 2026 05:12:59 -0400
Received: by mail-dy2-x10.google.com with SMTP id
 5a478bee46e88-328664e061cso1991591eec.2
 for <qemu-devel@nongnu.org>; Thu, 24 Sep 2026 02:12:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790241174; x=1790845974; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=RUkgpIVqjvvd2FdfWd3eWDKdITOOkIynbwVYUmSXt+k=;
 b=aRL17UvOYdIwxB0a57FaJYeIJrl65HNXGvw9nYBfWX2eXPmyaoM5diq4gi4lGESsZL
 T9IYNMPTNt8LHf94O3hzMmVTI4d69qamNmBsoh5m8P0TeIqBWmocv37xNLGubBbsSb+U
 7vVCZldgxtsmr8X7SqpaoTNz2zI9buCSIwyP8leKniDz1iM17XgeKLzd1Idvm9o1t6AY
 Zvz81cPJulsqpAJXcjfgzS1GZJ89ZhBaBqsKKgxV70lB36FuzH4RfTovGWB4a0S5/gdY
 OliBECT/Jg6juBueCP0fhfcvUty0UIoZPKVQtmBhBDTZ6WrfW7n/dD1KEdHHZ/Zyn8Y2
 SqAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790241174; x=1790845974;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=RUkgpIVqjvvd2FdfWd3eWDKdITOOkIynbwVYUmSXt+k=;
 b=I6u7BepRjKfB9t+O/vrKJi6ym/HOAt+2QlUuN2QKW8wjmqe1kPMJAYdOWSvnjgOSt3
 jQ+AF6M0cE7ZWzvpYwNQgHCqBJRGruQG2oUc/SiiWClpdgMLtP1QQZgC5CzZGnYV6nJS
 ccV/hBTFKOOAfYLoazubAayztQnLMTbjREVLahg2mu49Z3phLRkgKR652hTha2a5EhOJ
 c4xej8fq3U8mLx8n12uQKBAbwEDA1rsIXRwZxw8Dw1uV4NmiJ+3YEaT5zeddHZBSwBUq
 QoYF6fBtl7WFzSO5LLptKk9trUx0UqGv7NdiYU4HelzNi+mjR8d3nrnr6u/j3TDCI2Mn
 gnTg==
X-Forwarded-Encrypted: i=1;
 AKwUvBylLxYCh0YTGWgvCXfFAp4v829XWaVHFD/eRxxbvyZeUCjS60S9Syglmch84jH9z6kvQHICPPQdT5t9@nongnu.org
X-Gm-Message-State: AFuF++kkkfq6vuwE70lA4WzMxPiqMFkyaFsnjjtbSmO38GwZcIn3Vs6X
 5yS31HlcYnZ0Ho6iEMHRSLlp8Zrt2wHMock2OIIwkMx0rFUFxpH5Atf4
X-Gm-Gg: AYBFou2U0H570DrGGIt0jYXyc7MbNQh7lYGXtOAuedWWt8isjxsUHC7n2FH/11PXxKK
 7hlAqZ8TKBZ3zQK74jnQCZYSJJTAKEMGmXzchEvSmXkLQXz+ABQBswa7/q5vOjlasf90d2sNkjw
 lYsDz09TrO/ZIULzUCEKwhQNBMzUPAnjhwUCnkjeF0shudHCm9lYG0wpIGqan/2c96Q5xNPsv8y
 DWaLaMJtKdfuMlmytpvYvRf0Mu+lfa3XlwBJ+WouBnUPlEUER5vBq2zeiahz3Qy6NyLxZyCSWi0
 IZMC5lwYEeBEzREbgQrTJ7nJzuzvcHiygFagZwCVfaOVUMap9rdkdztz1vzaf1amyQNUjiaOPIm
 dGkg0cJIhp4eXvZt+x0lrVYTHTzNxCScPB2GTtSNazvbmQwkEz14CFkBYismMhkhMn1W1Enxr08
 yKqNhAnSgWmwzCRHOQtnGydJCwG1fJvgEkkv6JOf+63sM8p1pE/4JkZQ75wMxqpKoN58lvT64YF
 RzTQi1qtykH37h83bEkskmHYR/YdBryHZiCzcyuwH21SxUNe29uByw=
X-Received: by 2002:a05:7301:4208:b0:33f:f57:c516 with SMTP id
 5a478bee46e88-34001c14d7fmr1452957eec.10.1790241174006; 
 Thu, 24 Sep 2026 02:12:54 -0700 (PDT)
Received: from li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com
 ([106.51.165.23]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33e95c7c23asm11364035eec.6.2026.09.24.02.12.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Sep 2026 02:12:53 -0700 (PDT)
Date: Thu, 24 Sep 2026 14:42:46 +0530
From: Mukesh Kumar Chaurasiya <mkchauras@gmail.com>
To: Shivang Upadhyay <shivangu@linux.ibm.com>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, sourabhjain@linux.ibm.com, 
 rathc@linux.ibm.com, npiggin@gmail.com, milesg@linux.ibm.com,
 harshpb@linux.ibm.com, 
 adityag@linux.ibm.com, richard.henderson@linaro.org, sshegde@linux.ibm.com, 
 srikar@linux.ibm.com, amachhiw@linux.ibm.com
Subject: Re: [PATCH] target/ppc: Stop vCPU thread before calling
 parent_unrealize
Message-ID: <arTpfPWGBLa2YlXF@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
References: <20260923121444.154175-1-shivangu@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260923121444.154175-1-shivangu@linux.ibm.com>
Received-SPF: pass client-ip=2607:f8b0:4864:36::10;
 envelope-from=mkchauras@gmail.com; helo=mail-dy2-x10.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 24 Sep 2026 07:53:55 -0400
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

On Wed, Sep 23, 2026 at 05:44:44PM +0530, Shivang Upadhyay wrote:
> During CPU hot-unplug (e.g. via dynamic reconfiguration unplug),
> ppc_cpu_unrealize() invoked pcc->parent_unrealize(dev) before calling
> cpu_remove_sync(CPU(cpu)).
> 
> pcc->parent_unrealize() calls cpu_common_unrealize(), which triggers
> accel_cpu_common_unrealize() -> tcg_exec_unrealizefn() -> tlb_destroy().
> This immediately frees the CPU's TLB tables and structures. Because the
> vCPU thread had not yet been stopped and joined via cpu_remove_sync(),
> the vCPU thread was still actively running its event loop and processing
> queued CPU work (such as tcg_commit_cpu / tlb_flush).
> 
> This resulted in a race where the running vCPU thread accessed and freed
> already-destroyed TLB tables concurrently with tlb_destroy(), leading to
> Segfault (due to heap corruption).
> 
> AddressSanitizer build reported a double-free:
> 
> =================================================================
> ==121930==ERROR: AddressSanitizer: attempting double-free on 0x7ef8f3438800 in thread T14:
>     #0 0x7fe8f74e5beb in free.part.0 (/lib64/libasan.so.8+0xe5beb)
>     #1 0x7fe8f6cb8f84 in g_free (/lib64/libglib-2.0.so.0+0x41f84)
>     #2 0x558bf6a391b1 in tlb_mmu_resize_locked accel/tcg/cputlb.c:249
>     #3 0x558bf6a396b5 in tlb_flush_one_mmuidx_locked accel/tcg/cputlb.c:296
>     #4 0x558bf6a39f91 in tlb_flush_by_mmuidx_async_work accel/tcg/cputlb.c:390
>     #5 0x558bf6a3a200 in tlb_flush_by_mmuidx accel/tcg/cputlb.c:417
>     #6 0x558bf6a3a22a in tlb_flush accel/tcg/cputlb.c:422
>     #7 0x558bf73f31ac in tcg_commit_cpu system/physmem.c:3068
>     #8 0x558bf6987c55 in process_queued_cpu_work cpu-common.c:378
>     #9 0x558bf73a9913 in qemu_process_cpu_events_common system/cpus.c:402
>     #10 0x558bf73a9a46 in qemu_process_cpu_events system/cpus.c:421
>     #11 0x558bf6a65974 in mttcg_cpu_thread_fn accel/tcg/tcg-accel-ops-mttcg.c:90
> 
> 0x7ef8f3438800 is located 0 bytes inside of 65536-byte region [0x7ef8f3438800,0x7ef8f3448800)
> freed by thread T9 here:
>     #0 0x7fe8f74e5beb in free.part.0 (/lib64/libasan.so.8+0xe5beb)
>     #1 0x7fe8f6cb8f84 in g_free (/lib64/libglib-2.0.so.0+0x41f84)
>     #2 0x558bf6a39a91 in tlb_destroy accel/tcg/cputlb.c:345
>     #3 0x558bf6a16354 in tcg_exec_unrealizefn accel/tcg/cpu-exec.c:1094
>     #4 0x558bf693d073 in accel_cpu_common_unrealize accel/accel-common.c:117
>     #5 0x558bf6980e37 in cpu_common_unrealize hw/core/cpu-common.c:279
>     #6 0x558bf6980dfa in cpu_common_unrealizefn hw/core/cpu-common.c:267
>     #7 0x558bf763ef65 in ppc_cpu_unrealize target/ppc/cpu_init.c:6965
>     #8 0x558bf7872199 in device_set_realized hw/core/qdev.c:618
>     #14 0x558bf756068f in spapr_unrealize_vcpu hw/ppc/spapr_cpu_core.c:209
> 
> Fix this by moving cpu_remove_sync() before pcc->parent_unrealize(dev)
> in ppc_cpu_unrealize(), ensuring the vCPU thread is stopped, has
> finished processing its events, and is joined before CPU resources
> and accelerator state are destroyed.
> 
> Signed-off-by: Shivang Upadhyay <shivangu@linux.ibm.com>
> ---
>  target/ppc/cpu_init.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
> index 6c626843c9..b711f9c0a8 100644
> --- a/target/ppc/cpu_init.c
> +++ b/target/ppc/cpu_init.c
> @@ -6962,10 +6962,10 @@ static void ppc_cpu_unrealize(DeviceState *dev)
>      PowerPCCPU *cpu = POWERPC_CPU(dev);
>      PowerPCCPUClass *pcc = POWERPC_CPU_GET_CLASS(cpu);
>  
> -    pcc->parent_unrealize(dev);
> -
>      cpu_remove_sync(CPU(cpu));
>  
> +    pcc->parent_unrealize(dev);
> +
>      destroy_ppc_opcodes(cpu);
>  }
>  
> -- 
> 2.54.0
> 
Makes Sense.

Reviewed-by: Mukesh Kumar Chaurasiya (IBM) <mkchauras@gmail.com>
> 

