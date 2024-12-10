Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1291AE7717F
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2024 16:44:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tL3Kx-00079h-GO; Tue, 10 Dec 2024 11:43:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1tL3Kv-00078k-Hd
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 11:43:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1tL3Ku-0002sB-1Z
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 11:43:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733849026;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8pGgEEeSELoHHf+V2ymV8EZKTzzoxb3eaT6wrXLBjJM=;
 b=Xc8mj9leItLm4bZyVo1vlccut5G7CxUfThewwqs5y/0068kHgN6xvuURdgS7ka0IwRAwVO
 /aKs/xwTVNqan0n2kYX+qh1Fph6QEWHkYyagKsSjmd3IVQuXfCUSBuHRMtB0l88pTe/3c1
 N3KAPo1RT/pbzkxNiR3mgH1ik+N5ARg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-388-Bg6OrrE3OHqsTt_p0WzVCg-1; Tue, 10 Dec 2024 11:43:41 -0500
X-MC-Unique: Bg6OrrE3OHqsTt_p0WzVCg-1
X-Mimecast-MFC-AGG-ID: Bg6OrrE3OHqsTt_p0WzVCg
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-434f5b7b4a2so22343605e9.0
 for <qemu-devel@nongnu.org>; Tue, 10 Dec 2024 08:43:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733849020; x=1734453820;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8pGgEEeSELoHHf+V2ymV8EZKTzzoxb3eaT6wrXLBjJM=;
 b=pCAZuw17cYBvPFflMJeJJnaAWzqGZrL881IEk5LwJqPLJH3+LU0Oabbn9gYwJ+tUFq
 zx7xPTaxWPeMT16ID+NdDoCBKiIrefU1J+p5ttMpUx5weqqZkJUyGsSuWJ3Tecp5a7Pr
 z2vjS8aXoF3NVTykdIbbD0ueJ52Ms4Z3vRVRxEUGGpCMGy2X0nFxVLc/E6wkLJKNnuAk
 jsa3Zk60earV5f9iC4r5wINNgL/n+i0dsiqMG0M4wNnFOHGJqxeWuEEAfcYdbTAz0bci
 w1r0ogYfKIiK2hBmVhsiPSMs3TKRLF5VPI5qUZsNNQoagqtjbrFgIJBW94dwafURQ+HG
 uD3g==
X-Forwarded-Encrypted: i=1;
 AJvYcCU5QpoVa1tBqQlbpTG5pMsKM5Gduqs68+jk3cM8XoAOcqJatsvKF2uYv37CrIY6dbg4E6sj7RRKGs3k@nongnu.org
X-Gm-Message-State: AOJu0Yx3ls4YQ+M7FhWk18inU1YLR20vsgG0PmnrqswJE3xPOnxQp/O+
 Lp+iOTPfH91Du8LWZsg8d/DzOpeNlqKm/MftH9HCdPecOrh7xhb8PbE+CKBsBPBiuEP0/ZYQ/8E
 3nmUfOqZmMviAWiL+o/0liHQ1JoCdrY/+BsZH8MFd4i52+7j3Wr3G
X-Gm-Gg: ASbGncvqpMJC7O27LJkcIL0tgMI2bCD//LP+qRo1Y4eMZzYV4pdkqcozrfRf4ls8PF4
 f9t5+cfvPtqw7eEyel0Wvu0LOWPPLF91n2SjxwQZ5uWf4r5T039gicP9AtzLzyUqWmn0oD1SCZd
 r91Sz+r3V0ct7Ad3hesMm1LztZ/pqvnZX93g8SRfuyrzb2oZrnQb7ufFsnFyfezWHt1mach3HS8
 xwsws3J2KKMzOwSJZ6qMp38zVdfNbA/urAtOQOL1Lie9/Iec/ipAp2Y/7rNlBUfFvFEQ/ZVvEf5
 lehwCxZXHQ1SKI7UVTmHaiV0kQ==
X-Received: by 2002:a05:600c:b94:b0:434:f753:600f with SMTP id
 5b1f17b1804b1-434fff502fcmr48447655e9.19.1733849020346; 
 Tue, 10 Dec 2024 08:43:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFNlydob5NfGcaRZsczB6/N7pk58H++97KNUX+qD1MU7YmLOnVjXYfc/V/jOP1AGOpRSBdvgQ==
X-Received: by 2002:a05:600c:b94:b0:434:f753:600f with SMTP id
 5b1f17b1804b1-434fff502fcmr48447375e9.19.1733849020010; 
 Tue, 10 Dec 2024 08:43:40 -0800 (PST)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-434d527395csm230317185e9.17.2024.12.10.08.43.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Dec 2024 08:43:39 -0800 (PST)
Date: Tue, 10 Dec 2024 17:43:38 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Philippe =?UTF-8?B?TWF0aGlldS1E?=
 =?UTF-8?B?YXVkw6k=?= <philmd@linaro.org>, Marcel Apfelbaum
 <marcel.apfelbaum@gmail.com>, Yanan Wang <wangyanan55@huawei.com>, Zhao Liu
 <zhao1.liu@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>, Richard
 Henderson <richard.henderson@linaro.org>, Cameron Esfahani
 <dirty@apple.com>, Roman Bolshakov <rbolshakov@ddn.com>, Marcelo Tosatti
 <mtosatti@redhat.com>, qemu-devel@nongnu.org
Subject: Re: [RFC PATCH 3/4] i386: Track cores_per_module in CPUX86State
Message-ID: <20241210174338.0fb05ecf@imammedo.users.ipa.redhat.com>
In-Reply-To: <20241205145716.472456-4-xiaoyao.li@intel.com>
References: <20241205145716.472456-1-xiaoyao.li@intel.com>
 <20241205145716.472456-4-xiaoyao.li@intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.52,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Thu,  5 Dec 2024 09:57:15 -0500
Xiaoyao Li <xiaoyao.li@intel.com> wrote:

> x86 is the only user of CPUState::nr_cores.
> 
> Define cores_per_module in CPUX86State, which can serve as the
> substitute of CPUState::nr_cores. After x86 switches to use
> CPUX86State::cores_per_module, CPUState::nr_cores will lose the only
> user and QEMU can drop it.
> 
> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
> ---
>  hw/i386/x86-common.c | 2 ++
>  target/i386/cpu.c    | 2 +-
>  target/i386/cpu.h    | 9 +++++++--
>  3 files changed, 10 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/i386/x86-common.c b/hw/i386/x86-common.c
> index dc031af66217..f7a20c1da30c 100644
> --- a/hw/i386/x86-common.c
> +++ b/hw/i386/x86-common.c
> @@ -271,6 +271,8 @@ void x86_cpu_pre_plug(HotplugHandler *hotplug_dev,
>  
>      init_topo_info(&topo_info, x86ms);
>  
> +    env->nr_cores = ms->smp.cores;
this doesn't look like the same as in qemu_init_vcpu(),
which uses machine_topo_get_cores_per_socket()
Can you clarify the change?

> +
>      if (ms->smp.modules > 1) {
>          env->nr_modules = ms->smp.modules;
>          set_bit(CPU_TOPOLOGY_LEVEL_MODULE, env->avail_cpu_topo);
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index 3725dbbc4b3f..15b50c44ae79 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -6503,7 +6503,7 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
>  
>      topo_info.dies_per_pkg = env->nr_dies;
>      topo_info.modules_per_die = env->nr_modules;
> -    topo_info.cores_per_module = cs->nr_cores / env->nr_dies / env->nr_modules;
> +    topo_info.cores_per_module = env->nr_cores;
>      topo_info.threads_per_core = cs->nr_threads;
>  
>      cores_per_pkg = topo_info.cores_per_module * topo_info.modules_per_die *
> diff --git a/target/i386/cpu.h b/target/i386/cpu.h
> index 5795a497e567..c37a49a1a02b 100644
> --- a/target/i386/cpu.h
> +++ b/target/i386/cpu.h
> @@ -2051,6 +2051,9 @@ typedef struct CPUArchState {
>      /* Number of modules within one die. */
>      unsigned nr_modules;
>  
> +    /* Number of cores within one module. */
> +    unsigned nr_cores;
> +
>      /* Bitmap of available CPU topology levels for this CPU. */
>      DECLARE_BITMAP(avail_cpu_topo, CPU_TOPOLOGY_LEVEL__MAX);
>  } CPUX86State;
> @@ -2393,10 +2396,12 @@ static inline void cpu_x86_load_seg_cache_sipi(X86CPU *cpu,
>  static inline uint64_t cpu_x86_get_msr_core_thread_count(X86CPU *cpu)
>  {
>      CPUState *cs = CPU(cpu);
> +    CPUX86State *env = &cpu->env;
>      uint64_t val;
> +    uint64_t cores_per_package = env->nr_cores * env->nr_modules * env->nr_dies;
>  
> -    val = cs->nr_threads * cs->nr_cores;  /* thread count, bits 15..0 */
> -    val |= ((uint32_t)cs->nr_cores << 16); /* core count, bits 31..16 */
> +    val = cs->nr_threads * cores_per_package;  /* thread count, bits 15..0 */
> +    val |= (cores_per_package << 16); /* core count, bits 31..16 */
>  
>      return val;
>  }


